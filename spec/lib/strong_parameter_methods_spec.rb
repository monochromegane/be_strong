require 'spec_helper'

describe BeStrong::StrongParameterMethods do
  describe '#method_for' do
    subject { described_class.method_for(model) }

    context 'when model has attr_accessible columns' do
      let(:model) { 'author' }
      it do
        is_expected.to eq(<<-'EOS'.strip_heredoc)
          def author_params
            params.require(:author).permit(:name, :age)
          end
        EOS
      end

      context 'when model dose not have attr_accessible columns' do
        let(:model) { 'no_attr_accessible' }
        it do
          is_expected.to eq(<<-'EOS'.strip_heredoc)
          def no_attr_accessible_params
            params.require(:no_attr_accessible)
          end
          EOS
        end
      end

      context 'when model dose not exist' do
        let(:model) { 'unknown' }
        it { is_expected.to be_nil }
      end
    end
  end
end
