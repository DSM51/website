module Rouge
  module Lexers
    class ASM8051 < RegexLexer
      tag 'asm8051'
      filenames '*.asm', '*.s'
      mimetypes 'text/x-asm8051'

      title 'Assembler 8051'
      desc 'Assembler for Intel 8051'

      ws = %r((?:\s|;.*?\n/)+)
      id = /[a-zA-Z_][a-zA-Z0-9_\.]*/

      def self.keywords
        @keywords ||= Set.new %w(
          acall add addc ajmp anl cjne clr cpl da dec div djnz inc jb jbc jc jmp
          jnb jnc jnz jz lcall ljmp mov movc movx mul nop orl pop push ret reti
          rl rlc rr rrc setb sjmp subb swap xch xchd xrl
        )
      end

      def self.builtins
        @keywords ||= Set.new %w(
          R0 P1.7
        )
      end

      state :root do
        rule /[a-z0-9A-Z]+:/, Name::Function

        rule /#[0-9]+/i, Num::Integer
        rule /;.*/, Comment

        rule id do |m|
          name = m[0]

          if self.class.keywords.include? name
            token Keyword
          elsif self.class.builtins.include? name
            token Name::Builtin
          else
            token Name
          end
        end

        rule /,/, Text
        rule /[ \t\r]+/, Text
      end
    end
  end
end
