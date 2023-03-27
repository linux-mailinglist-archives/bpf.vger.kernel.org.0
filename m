Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911B46CAB5F
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 19:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjC0RDa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 13:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjC0RCy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 13:02:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA165266
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 10:02:27 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ew6so38942061edb.7
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 10:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679936539;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l5NO08+OCWq//S7PxnG9QSUgdfD1VUO1HikfwO9C608=;
        b=P8/6Ris0tCJ5RdYZ87k5aTHJRAKXZAkaS80Tf5RXofdU2XVNvSsyYt48BLrCFazChR
         t0YpRRXz/fe1xGY3uoIX6tPPPwS6qRuuPCl7qBfsr4YOGwqM8cAysmxPjKgKWo0q1Ekw
         isRkbrF9Znw0njikcKPwsS3wFDIKZG8MNzmGtH7gK7Ob7CLwY1r37Cgghx6zmhjDc4Ud
         30WU1yLpSTR3Ev6FnD6IUj7co+ZGOVy+s5aPtB/M/MmKsYq72WZ74H82tba7wmsGFk5w
         nIfZUctCSFo25wU2C93NgIe1hCuP8GuCYxedTp/gTVuHdOFn7VQkwi6iHUr21dTDNmc2
         wZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679936539;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l5NO08+OCWq//S7PxnG9QSUgdfD1VUO1HikfwO9C608=;
        b=eFHosrbzwOLrZOwmFH5d0btNr+oHkYAunfStJhIWNLbylbr8p7a6fhgVWPB8HuTtxN
         gFxsUiBPN1uQC4SqxeiHvL5He4KcKZJHfLVyTUgar/nZAcxabYjYc8haionA0hZnZiNF
         RYwhIym9lmAtrMfNhCTvNWV5TwSWeFqD5wIT1Q1oePgRe+Jua79v6NYxwcJPpZ4yFPT+
         NkLB3aPiiv39KidGSw3PhxZw3BtDHRf8PXjzsXGkkl1UOytsSWe9PBeRbxQ3KgUZPhVX
         ohkifFF/frZLHwwdBBUyvr5jCAJH6262o4352Qrqg7v0eNJncy3IGCPPpnDnvu90B60v
         rB3Q==
X-Gm-Message-State: AAQBX9ey95DtzKiL/0okr7Nroi27jmsoJ+zVy6fNlV5WHOuD4xOeCB6o
        RHlqfh5CeRv7m+rKI/rAL9Y=
X-Google-Smtp-Source: AKy350YY3R8t95uhQToos71t33JTJG+XY/zmsWREmOIZamYYGz6P9Ki8RntzY9bSzIeRgbSPwvyZ8A==
X-Received: by 2002:a05:6402:c4:b0:502:4875:721 with SMTP id i4-20020a05640200c400b0050248750721mr2187788edu.15.1679936538813;
        Mon, 27 Mar 2023 10:02:18 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q28-20020a50aa9c000000b004fb556e905fsm14914125edc.49.2023.03.27.10.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 10:02:17 -0700 (PDT)
Message-ID: <288e8ccf770d28d47f26d31c989d65ab29fdf05c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] bpftool: Support inline annotations
 when dumping the CFG of a program
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org
Date:   Mon, 27 Mar 2023 20:02:15 +0300
In-Reply-To: <20230327110655.58363-4-quentin@isovalent.com>
References: <20230327110655.58363-1-quentin@isovalent.com>
         <20230327110655.58363-4-quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2023-03-27 at 12:06 +0100, Quentin Monnet wrote:
> We support dumping the control flow graph of loaded programs to the DOT
> format with bpftool, but so far this feature wouldn't display the source
> code lines available through BTF along with the eBPF bytecode. Let's add
> support for these annotations, to make it easier to read the graph.
>=20
> In prog.c, we move the call to dump_xlated_cfg() in order to pass and
> use the full struct dump_data, instead of creating a minimal one in
> draw_bb_node().
>=20
> We pass the pointer to this struct down to dump_xlated_for_graph() in
> xlated_dumper.c, where most of the logics is added. We deal with BTF
> mostly like we do for plain or JSON output, except that we cannot use a
> "nr_skip" value to skip a given number of linfo records (we don't
> process the BPF instructions linearly, and apart from the root of the
> graph we don't know how many records we should skip, so we just store
> the last linfo and make sure the new one we find is different before
> printing it).
>=20
> When printing the source instructions to the label of a DOT graph node,
> there are a few subtleties to address. We want some special newline
> markers, and there are some characters that we must escape. To deal with
> them, we introduce a new dedicated function btf_dump_linfo_dotlabel() in
> btf_dumper.c. We'll reuse this function in a later commit to format the
> filepath, line, and column references as well.
>=20
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> Acked-by: Stanislav Fomichev <sdf@google.com>
> ---
>  tools/bpf/bpftool/btf_dumper.c    | 32 +++++++++++++++++++++++++++++++
>  tools/bpf/bpftool/cfg.c           | 23 ++++++++++------------
>  tools/bpf/bpftool/cfg.h           |  4 +++-
>  tools/bpf/bpftool/main.h          |  2 ++
>  tools/bpf/bpftool/prog.c          | 17 +++++++---------
>  tools/bpf/bpftool/xlated_dumper.c | 32 ++++++++++++++++++++++++++++++-
>  6 files changed, 85 insertions(+), 25 deletions(-)
>=20
> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumpe=
r.c
> index e7f6ec3a8f35..8bfc1b69497d 100644
> --- a/tools/bpf/bpftool/btf_dumper.c
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -821,3 +821,35 @@ void btf_dump_linfo_json(const struct btf *btf,
>  					BPF_LINE_INFO_LINE_COL(linfo->line_col));
>  	}
>  }
> +
> +static void dotlabel_puts(const char *s)
> +{
> +	for (; *s; ++s) {
> +		switch (*s) {
> +		case '\\':
> +		case '"':
> +		case '{':
> +		case '}':
> +		case '>':

The "case '<':" is missing, w/o it dot reports warnings as follows:

  Error: bad label format {; if (hdr + hdr_size <=3D data_end)...

I used existing bpt testcase for testing:

  $ cd <kernel>/tools/testing/selftests/bpf
  $ bpftool prog load bpf_flow.bpf.o /sys/fs/bpf/test-prog
  $ prog dump xlated pinned /sys/fs/bpf/test-prog visual > test.cfg
  $ dot -Tpng -O test.cfg
 =20
Also [1] says the following:

> Braces, vertical bars and angle brackets must be escaped with a
> backslash character if you wish them to appear as a literal
> character. Spaces are interpreted as separators between tokens, so
> they must be escaped if you want spaces in the text.

So, maybe escape spaces as well?

[1] https://graphviz.org/doc/info/shapes.html#record

> +		case '|':
> +			putchar('\\');
> +			__fallthrough;
> +		default:
> +			putchar(*s);
> +		}
> +	}
> +}
> +
> +void btf_dump_linfo_dotlabel(const struct btf *btf,
> +			     const struct bpf_line_info *linfo)
> +{
> +	const char *line =3D btf__name_by_offset(btf, linfo->line_off);
> +
> +	if (!line)
> +		return;
> +	line =3D ltrim(line);
> +
> +	printf("; ");
> +	dotlabel_puts(line);
> +	printf("\\l\\\n");
> +}
> diff --git a/tools/bpf/bpftool/cfg.c b/tools/bpf/bpftool/cfg.c
> index 1951219a9af7..9fdc1f0cdd6e 100644
> --- a/tools/bpf/bpftool/cfg.c
> +++ b/tools/bpf/bpftool/cfg.c
> @@ -380,7 +380,8 @@ static void cfg_destroy(struct cfg *cfg)
>  	}
>  }
> =20
> -static void draw_bb_node(struct func_node *func, struct bb_node *bb)
> +static void
> +draw_bb_node(struct func_node *func, struct bb_node *bb, struct dump_dat=
a *dd)
>  {
>  	const char *shape;
> =20
> @@ -398,13 +399,9 @@ static void draw_bb_node(struct func_node *func, str=
uct bb_node *bb)
>  		printf("EXIT");
>  	} else {
>  		unsigned int start_idx;
> -		struct dump_data dd =3D {};
> -
> -		printf("{");
> -		kernel_syms_load(&dd);
> +		printf("{\\\n");
>  		start_idx =3D bb->head - func->start;
> -		dump_xlated_for_graph(&dd, bb->head, bb->tail, start_idx);
> -		kernel_syms_destroy(&dd);
> +		dump_xlated_for_graph(dd, bb->head, bb->tail, start_idx);
>  		printf("}");
>  	}
> =20
> @@ -430,12 +427,12 @@ static void draw_bb_succ_edges(struct func_node *fu=
nc, struct bb_node *bb)
>  	}
>  }
> =20
> -static void func_output_bb_def(struct func_node *func)
> +static void func_output_bb_def(struct func_node *func, struct dump_data =
*dd)
>  {
>  	struct bb_node *bb;
> =20
>  	list_for_each_entry(bb, &func->bbs, l) {
> -		draw_bb_node(func, bb);
> +		draw_bb_node(func, bb, dd);
>  	}
>  }
> =20
> @@ -455,7 +452,7 @@ static void func_output_edges(struct func_node *func)
>  	       func_idx, ENTRY_BLOCK_INDEX, func_idx, EXIT_BLOCK_INDEX);
>  }
> =20
> -static void cfg_dump(struct cfg *cfg)
> +static void cfg_dump(struct cfg *cfg, struct dump_data *dd)
>  {
>  	struct func_node *func;
> =20
> @@ -463,14 +460,14 @@ static void cfg_dump(struct cfg *cfg)
>  	list_for_each_entry(func, &cfg->funcs, l) {
>  		printf("subgraph \"cluster_%d\" {\n\tstyle=3D\"dashed\";\n\tcolor=3D\"=
black\";\n\tlabel=3D\"func_%d ()\";\n",
>  		       func->idx, func->idx);
> -		func_output_bb_def(func);
> +		func_output_bb_def(func, dd);
>  		func_output_edges(func);
>  		printf("}\n");
>  	}
>  	printf("}\n");
>  }
> =20
> -void dump_xlated_cfg(void *buf, unsigned int len)
> +void dump_xlated_cfg(struct dump_data *dd, void *buf, unsigned int len)
>  {
>  	struct bpf_insn *insn =3D buf;
>  	struct cfg cfg;
> @@ -479,7 +476,7 @@ void dump_xlated_cfg(void *buf, unsigned int len)
>  	if (cfg_build(&cfg, insn, len))
>  		return;
> =20
> -	cfg_dump(&cfg);
> +	cfg_dump(&cfg, dd);
> =20
>  	cfg_destroy(&cfg);
>  }
> diff --git a/tools/bpf/bpftool/cfg.h b/tools/bpf/bpftool/cfg.h
> index e144257ea6d2..909d17e6d4c2 100644
> --- a/tools/bpf/bpftool/cfg.h
> +++ b/tools/bpf/bpftool/cfg.h
> @@ -4,6 +4,8 @@
>  #ifndef __BPF_TOOL_CFG_H
>  #define __BPF_TOOL_CFG_H
> =20
> -void dump_xlated_cfg(void *buf, unsigned int len);
> +#include "xlated_dumper.h"
> +
> +void dump_xlated_cfg(struct dump_data *dd, void *buf, unsigned int len);
> =20
>  #endif /* __BPF_TOOL_CFG_H */
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 0ef373cef4c7..e9ee514b22d4 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -229,6 +229,8 @@ void btf_dump_linfo_plain(const struct btf *btf,
>  			  const char *prefix, bool linum);
>  void btf_dump_linfo_json(const struct btf *btf,
>  			 const struct bpf_line_info *linfo, bool linum);
> +void btf_dump_linfo_dotlabel(const struct btf *btf,
> +			     const struct bpf_line_info *linfo);
> =20
>  struct nlattr;
>  struct ifinfomsg;
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index afbe3ec342c8..d855118f0d96 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -840,11 +840,6 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode=
 mode,
>  					      false))
>  				goto exit_free;
>  		}
> -	} else if (visual) {
> -		if (json_output)
> -			jsonw_null(json_wtr);
> -		else
> -			dump_xlated_cfg(buf, member_len);
>  	} else {
>  		kernel_syms_load(&dd);
>  		dd.nr_jited_ksyms =3D info->nr_jited_ksyms;
> @@ -854,12 +849,14 @@ prog_dump(struct bpf_prog_info *info, enum dump_mod=
e mode,
>  		dd.finfo_rec_size =3D info->func_info_rec_size;
>  		dd.prog_linfo =3D prog_linfo;
> =20
> -		if (json_output)
> -			dump_xlated_json(&dd, buf, member_len, opcodes,
> -					 linum);
> +		if (json_output && visual)
> +			jsonw_null(json_wtr);

Should this be an error? Maybe check that json_output is false when
arguments are parsed and 'visual' is specified?

> +		else if (json_output)
> +			dump_xlated_json(&dd, buf, member_len, opcodes, linum);
> +		else if (visual)
> +			dump_xlated_cfg(&dd, buf, member_len);
>  		else
> -			dump_xlated_plain(&dd, buf, member_len, opcodes,
> -					  linum);
> +			dump_xlated_plain(&dd, buf, member_len, opcodes, linum);
>  		kernel_syms_destroy(&dd);
>  	}
> =20
> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated=
_dumper.c
> index 3daa05d9bbb7..5fbe94aa8589 100644
> --- a/tools/bpf/bpftool/xlated_dumper.c
> +++ b/tools/bpf/bpftool/xlated_dumper.c
> @@ -369,20 +369,50 @@ void dump_xlated_for_graph(struct dump_data *dd, vo=
id *buf_start, void *buf_end,
>  		.cb_imm		=3D print_imm,
>  		.private_data	=3D dd,
>  	};
> +	const struct bpf_prog_linfo *prog_linfo =3D dd->prog_linfo;
> +	const struct bpf_line_info *last_linfo =3D NULL;
> +	struct bpf_func_info *record =3D dd->func_info;
>  	struct bpf_insn *insn_start =3D buf_start;
>  	struct bpf_insn *insn_end =3D buf_end;
>  	struct bpf_insn *cur =3D insn_start;
> +	struct btf *btf =3D dd->btf;
>  	bool double_insn =3D false;
> +	char func_sig[1024];
> =20
>  	for (; cur <=3D insn_end; cur++) {
> +		unsigned int insn_off;
> +
>  		if (double_insn) {
>  			double_insn =3D false;
>  			continue;
>  		}
>  		double_insn =3D cur->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW);
> =20
> -		printf("% 4d: ", (int)(cur - insn_start + start_idx));
> +		insn_off =3D (unsigned int)(cur - insn_start + start_idx);
> +		if (btf && record) {
> +			if (record->insn_off =3D=3D insn_off) {
> +				btf_dumper_type_only(btf, record->type_id,
> +						     func_sig,
> +						     sizeof(func_sig));
> +				if (func_sig[0] !=3D '\0')
> +					printf("; %s:\\l\\\n", func_sig);
> +				record =3D (void *)record + dd->finfo_rec_size;
> +			}
> +		}
> +
> +		if (prog_linfo) {
> +			const struct bpf_line_info *linfo;
> +
> +			linfo =3D bpf_prog_linfo__lfind(prog_linfo, insn_off, 0);
> +			if (linfo && linfo !=3D last_linfo) {
> +				btf_dump_linfo_dotlabel(btf, linfo);
> +				last_linfo =3D linfo;
> +			}
> +		}
> +
> +		printf("%d: ", insn_off);
>  		print_bpf_insn(&cbs, cur, true);
> +
>  		if (cur !=3D insn_end)
>  			printf(" | ");
>  	}

