local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
local rep = require("luasnip.extras").rep

return {
	s("cl", {
		t("console.log("),
		i(1),
		t(");"),
	}),
	s({ trig = "iu" }, {
		t("import _ from 'underscore';"),
	}),
	s({ trig = "uci" }, {
		t("const clientId = useClientId"),
		i(1),
		t("();"),
	}),
	s({ trig = "ut" }, {
		t("const { t } = useTranslation"),
		i(1),
		t("();"),
	}),
	s({ trig = "fcp" }, {
		t({ "import React, { VFC } from 'react';", "", "type Props = {", "\t" }),
		i(2),
		t({ "", "}", "", "const " }),
		i(1),
		t(": VFC<Props> = ({ "),
		i(3),
		t({ " }) => {", "\t" }),
		i(4),
		t({ "", "}", "", "export default " }),
		rep(1),
		t(";"),
	}),
	s({ trig = "fc" }, {
		t({ "import React, { VFC } from 'react';", "", "const " }),
		i(1),
		t({ ": VFC = () => {", "\t" }),
		i(2),
		t({ "", "}", "", "export default " }),
		rep(1),
		t(";"),
	}),
	s({ trig = "od" }, {
		t("const { "),
		i(2),
		t(" } = "),
		i(1),
		t(";"),
	}),
	s({ trig = "ad" }, {
		t("const [ "),
		i(2),
		t(" ] = "),
		i(1),
		t(";"),
	}),
	s({ trig = "i" }, {
		t("import "),
		i(2),
		t(" from '"),
		i(1),
		t("';"),
	}),
	s({ trig = "af" }, {
		t("("),
		i(1),
		t(") => "),
		i(2),
	}),
	s({ trig = "fn" }, {
		t("function "),
		i(1),
		t("("),
		i(2),
		t({ ") {", "\t" }),
		i(3),
		t({ "", "}" }),
	}),
	s({ trig = "taf" }, {
		t("("),
		i(1),
		t("): "),
		i(2),
		t(" => "),
		i(3),
	}),
	s({ trig = "tfn" }, {
		t("function "),
		i(1),
		t("("),
		i(2),
		t("): "),
		i(3),
		t({ " {", "\t" }),
		i(4),
		t({ "", "}" }),
	}),
	s({ trig = "to" }, {
		t("{ "),
		i(2),
		t(" }: "),
		i(1),
	}),
}
