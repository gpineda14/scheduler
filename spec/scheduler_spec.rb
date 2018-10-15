require './scheduler'

describe 'scheduler' do
  context "Testing whole program" do
    it 'returns Algebra 1, Geometry, Algebra 2, Pre Calculus if input is math.json' do
      math = File.expand_path('../../input/math.json', __FILE__)
      expect { scheduler(math) }.to output("Algebra 1\nGeometry\nAlgebra 2\nPre Calculus\n").to_stdout
    end

    it 'returns Calculus, Scientific Thinking, Differetial Equations, Intro to Physics, Relativity if input is physics.json' do
      physics = File.expand_path('../../input/physics.json', __FILE__)
      expect { scheduler(physics) }.to output("Calculus\nScientific Thinking\nDifferential Equations\nIntro to Physics\nRelativity\n").to_stdout
    end

    it "returns CS31, CS32, CS33, CS35L if input is lowerdivs.json" do
      lowerdivs = File.expand_path('../../input/lowerdivs.json', __FILE__)
      expect { scheduler(lowerdivs) }.to output("CS 31\nCS 32\nCS 33\nCS 35L\n").to_stdout
    end

    it "returns Ling 20, Ling 120B, Ling 102, Ling 120A, Ling 165A, Ling 185A, Ling 120C if input is linguistics.json" do
      linguistics = File.expand_path('../../input/linguistics.json', __FILE__)
      expect { scheduler(linguistics) }.to output("Ling 20\nLing 120B\nLing 102\nLing 120A\nLing 165A\nLing 185A\nLing 120C\n").to_stdout
    end

    it "returns CS 35L, CS 131, CS 180, CS 181, CS 161 if input is upperdivs.json" do
      upperdivs = File.expand_path('../../input/upperdivs.json', __FILE__)
      expect { scheduler(upperdivs) }.to output("CS 35L\nCS 131\nCS 180\nCS 181\nCS 161\n").to_stdout
    end
  end

  context "Testing ArrangeClasses" do

    it "should return [a, b, c, d, f, e]" do
      input = {"d" => ["a", "c"], "e" => ["d", "f"], "a" => [], "c" => ["b"], "b" => [], "f" => []}
      expect(arrangeClasses(input)).to eq (["a", "b", "c", "d", "f", "e"])
    end

    it "should return [d, e, k, a, b, p, g]" do
      input = {"g" => ["k", "p"], "k" => ["e"], "e" => ["d"],"d" => [], "p" => ["a", "b"], "a" => [], "b" => []}
      expect(arrangeClasses(input)).to eq (["d", "e", "k", "a", "b", "p", "g"])
    end

    it "should return [e, g, h, i, f, a, j, l, m, n, p, q, r, o, k, b, c, d]" do
      input = {"d" => ["a", "b", "c"], "a" => ["e", "f"], "b" => ["j", "k"],
              "c" => [], "e" => [], "f" => ["g", "h", "i"], "j" => [], "g" => [],
              "h" => [], "i" => [], "k" => ["l", "m", "n", "o"], "o" => ["p", "q", "r"], "l" => [], "m" => [], "n" => [],
              "p" => [], "q" => [], "r" => []}
      expect(arrangeClasses(input)).to eq (["e", "g", "h", "i", "f", "a", "j", "l", "m", "n", "p", "q", "r", "o", "k", "b", "c", "d"])
    end
  end
end
