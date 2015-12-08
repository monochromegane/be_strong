require 'spec_helper'

describe BeStrong::Code do

  describe '#apply_strong_parameter!' do
    subject { described_class.new(code).apply_strong_parameter! }

    context 'when code has mass assignment methods with params' do
      let(:code) do
        <<-'EOS'.strip_heredoc
        class Hoge
          Author.new(params[:author])
        end
        EOS
      end

      it do
        is_expected.to eq(<<-'EOS'.strip_heredoc)
        class Hoge
          Author.new(author_params)

          private

          def author_params
            params.require(:author).permit(:name, :age)
          end
        end
        EOS
      end

      context 'when code already has private method' do
        let(:code) do
          <<-'EOS'.strip_heredoc
          class Hoge
            Author.new(params[:author])

            private

            def fuga
            end
          end
          EOS
        end

        it do
          is_expected.to eq(<<-'EOS'.strip_heredoc)
          class Hoge
            Author.new(author_params)

            private

            def author_params
              params.require(:author).permit(:name, :age)
            end

            def fuga
            end
          end
          EOS
        end
      end
    end

    context 'when code dose not have mass assignment methods with params' do
      let(:code) do
        <<-'EOS'.strip_heredoc
        class Hoge
          Author.new(author_params)
        end
        EOS
      end

      it { is_expected.to eq(code) }
    end
  end

  describe '#add_private!' do
    subject { described_class.new(code).add_private! }

    context 'when code dose not have private' do
      let(:code) do
        <<-'EOS'.strip_heredoc
          class Hoge
          end
        EOS
      end
      it do
        is_expected.to eq(<<-'EOS'.strip_heredoc)
        class Hoge

          private
        end
        EOS
      end
    end

    context 'when class has private' do
      let(:code) do
        <<-'EOS'.strip_heredoc
          class Hoge
            private
          end
        EOS
      end
      it { is_expected.to eq(code) }
    end
  end
end
