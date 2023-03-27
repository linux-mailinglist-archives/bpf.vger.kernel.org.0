Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D636CAB7E
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 19:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjC0RGs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 13:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjC0RGc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 13:06:32 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4570C5244
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 10:05:03 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r11so39042878edd.5
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 10:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679936682;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uOeCS9bfh0zfcDSjJiF+Hzohi169pPl4g6mOlLIegAs=;
        b=k6no+T1dN9pOQpYa+MAMX6KxFSRt1n5BFiFMT2QNdXm1RTmfd3opLq+4/TD9dCALJA
         kGfhlgvcrT9qaCi+haWDHgUVFXzHqXWo+Y/ZMwPqNoumK1ujU2bAkpUracuBpCMBl3KW
         Y+Pa1dUyDlGo454xKDZzQMdWKACGED2m2ZROCCwx9zDJ56QN/0z8zjlo0mb4WZbuTZ1L
         9R4C3XVfjR0kjrqkFWCWolc63Re/D61Xa59GaYyawCEapBuXGueoYZnEm0SoqOukKVzL
         vjvoCMNpUjOP8Yc7BjPEPRTXzaHAQ0DigUUTkPoMKoMt/RfJjbsIvlwvpNxV6ibThMVt
         sVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679936682;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uOeCS9bfh0zfcDSjJiF+Hzohi169pPl4g6mOlLIegAs=;
        b=pFbdOosesklZqd/frUDeO7SdWggFabP7SsBAkl/RqTnaD8Ri65Sr94kPQDKkPdKBWv
         nWa7OHDLJ2LCKueZNHAvMs/U4Lj5mI32WW8HKfXPvEUP+W/Nn6WfIHrQg3ZD2m3LfS4C
         HbqxKp8IGXB8xpyRXxEME1k+hTSCmoJnnGD/YDUPB6oXKR511OzcuMSG9sxcx2zlgdkF
         OJ86mtZHcfSkoUitxw6A8JSCAARR7fwCkO0oecUYiAVXmX55lKxjfcAOChQJnQGgyvj/
         8t1sNCJ/VwIR+v0LPq16fR9OM4YmpLeiKa8MHd074hS5LcrEGH5R5W5Tc72H8mAd1jbz
         hxiA==
X-Gm-Message-State: AAQBX9f7Cdk+NVN4RX5H+ssBHPWokAL2lUPx87UsL2p9vlk86ONjMW/U
        dslesBbkWiQdLMd+2gbOWRc=
X-Google-Smtp-Source: AKy350baa7aSveCm5eVJ5+5Ev+ocfVd3ml2LRkL+lUIjc9H33HCRa+Jhik6f9Sa1/xFlRytyJ6s0XA==
X-Received: by 2002:aa7:dc0e:0:b0:502:2953:c0b2 with SMTP id b14-20020aa7dc0e000000b005022953c0b2mr10269174edu.12.1679936682488;
        Mon, 27 Mar 2023 10:04:42 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id k12-20020a50ce4c000000b004af70c546dasm14915514edj.87.2023.03.27.10.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 10:04:41 -0700 (PDT)
Message-ID: <fa28d05a6a123aea329a02ac666dbb18e7c5f519.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] bpftool: Support printing opcodes and
 source file references in CFG
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
Date:   Mon, 27 Mar 2023 20:04:40 +0300
In-Reply-To: <20230327110655.58363-6-quentin@isovalent.com>
References: <20230327110655.58363-1-quentin@isovalent.com>
         <20230327110655.58363-6-quentin@isovalent.com>
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
> Add support for displaying opcodes or/and file references (filepath,
> line and column numbers) when dumping the control flow graphs of loaded
> BPF programs with bpftool.
>=20
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> Acked-by: Stanislav Fomichev <sdf@google.com>
> ---
>  tools/bpf/bpftool/btf_dumper.c    | 19 ++++++++++++++++++-
>  tools/bpf/bpftool/cfg.c           | 22 ++++++++++++++--------
>  tools/bpf/bpftool/cfg.h           |  3 ++-
>  tools/bpf/bpftool/main.h          |  2 +-
>  tools/bpf/bpftool/prog.c          |  2 +-
>  tools/bpf/bpftool/xlated_dumper.c | 15 +++++++++++++--
>  tools/bpf/bpftool/xlated_dumper.h |  3 ++-
>  7 files changed, 51 insertions(+), 15 deletions(-)
>=20
> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumpe=
r.c
> index 8bfc1b69497d..24835c3f9a1c 100644
> --- a/tools/bpf/bpftool/btf_dumper.c
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -841,7 +841,7 @@ static void dotlabel_puts(const char *s)
>  }
> =20
>  void btf_dump_linfo_dotlabel(const struct btf *btf,
> -			     const struct bpf_line_info *linfo)
> +			     const struct bpf_line_info *linfo, bool linum)
>  {
>  	const char *line =3D btf__name_by_offset(btf, linfo->line_off);
> =20
> @@ -849,6 +849,23 @@ void btf_dump_linfo_dotlabel(const struct btf *btf,
>  		return;
>  	line =3D ltrim(line);
> =20
> +	if (linum) {
> +		const char *file =3D btf__name_by_offset(btf, linfo->file_name_off);
> +
> +		/* More forgiving on file because linum option is
> +		 * expected to provide more info than the already
> +		 * available src line.
> +		 */
> +		if (!file)
> +			file =3D "";
> +
> +		printf("; [file:");
> +		dotlabel_puts(file);
> +		printf("line_num:%u line_col:%u]\\l\\\n",

Space between file name and 'line_num' is missing.

Also, at-least for BPF test-cases the labels might become quite long,
which makes graph unnecessarily wide, e.g.:

  ; [file:/home/eddy/work/bpf-next/tools/testing/selftests/bpf/progs/bpf_fl=
ow.cline_num:97 line_col:34]\l\

The file names are encoded in full during compilation, but maybe
shorten long file names by removing some preceding levels
(and use shorter tags 'line:', 'col:', is 'file:' tag necessary at all?).
For example:

  ; [.../progs/bpf_flow.c line:97 col:34]\l\.

> +		       BPF_LINE_INFO_LINE_NUM(linfo->line_col),
> +		       BPF_LINE_INFO_LINE_COL(linfo->line_col));
> +	}
> +
>  	printf("; ");
>  	dotlabel_puts(line);
>  	printf("\\l\\\n");
> diff --git a/tools/bpf/bpftool/cfg.c b/tools/bpf/bpftool/cfg.c
> index 9fdc1f0cdd6e..eec437cca2ea 100644
> --- a/tools/bpf/bpftool/cfg.c
> +++ b/tools/bpf/bpftool/cfg.c
> @@ -381,7 +381,8 @@ static void cfg_destroy(struct cfg *cfg)
>  }
> =20
>  static void
> -draw_bb_node(struct func_node *func, struct bb_node *bb, struct dump_dat=
a *dd)
> +draw_bb_node(struct func_node *func, struct bb_node *bb, struct dump_dat=
a *dd,
> +	     bool opcodes, bool linum)
>  {
>  	const char *shape;
> =20
> @@ -401,7 +402,8 @@ draw_bb_node(struct func_node *func, struct bb_node *=
bb, struct dump_data *dd)
>  		unsigned int start_idx;
>  		printf("{\\\n");
>  		start_idx =3D bb->head - func->start;
> -		dump_xlated_for_graph(dd, bb->head, bb->tail, start_idx);
> +		dump_xlated_for_graph(dd, bb->head, bb->tail, start_idx,
> +				      opcodes, linum);
>  		printf("}");
>  	}
> =20
> @@ -427,12 +429,14 @@ static void draw_bb_succ_edges(struct func_node *fu=
nc, struct bb_node *bb)
>  	}
>  }
> =20
> -static void func_output_bb_def(struct func_node *func, struct dump_data =
*dd)
> +static void
> +func_output_bb_def(struct func_node *func, struct dump_data *dd,
> +		   bool opcodes, bool linum)
>  {
>  	struct bb_node *bb;
> =20
>  	list_for_each_entry(bb, &func->bbs, l) {
> -		draw_bb_node(func, bb, dd);
> +		draw_bb_node(func, bb, dd, opcodes, linum);
>  	}
>  }
> =20
> @@ -452,7 +456,8 @@ static void func_output_edges(struct func_node *func)
>  	       func_idx, ENTRY_BLOCK_INDEX, func_idx, EXIT_BLOCK_INDEX);
>  }
> =20
> -static void cfg_dump(struct cfg *cfg, struct dump_data *dd)
> +static void
> +cfg_dump(struct cfg *cfg, struct dump_data *dd, bool opcodes, bool linum=
)
>  {
>  	struct func_node *func;
> =20
> @@ -460,14 +465,15 @@ static void cfg_dump(struct cfg *cfg, struct dump_d=
ata *dd)
>  	list_for_each_entry(func, &cfg->funcs, l) {
>  		printf("subgraph \"cluster_%d\" {\n\tstyle=3D\"dashed\";\n\tcolor=3D\"=
black\";\n\tlabel=3D\"func_%d ()\";\n",
>  		       func->idx, func->idx);
> -		func_output_bb_def(func, dd);
> +		func_output_bb_def(func, dd, opcodes, linum);
>  		func_output_edges(func);
>  		printf("}\n");
>  	}
>  	printf("}\n");
>  }
> =20
> -void dump_xlated_cfg(struct dump_data *dd, void *buf, unsigned int len)
> +void dump_xlated_cfg(struct dump_data *dd, void *buf, unsigned int len,
> +		     bool opcodes, bool linum)
>  {
>  	struct bpf_insn *insn =3D buf;
>  	struct cfg cfg;
> @@ -476,7 +482,7 @@ void dump_xlated_cfg(struct dump_data *dd, void *buf,=
 unsigned int len)
>  	if (cfg_build(&cfg, insn, len))
>  		return;
> =20
> -	cfg_dump(&cfg, dd);
> +	cfg_dump(&cfg, dd, opcodes, linum);
> =20
>  	cfg_destroy(&cfg);
>  }
> diff --git a/tools/bpf/bpftool/cfg.h b/tools/bpf/bpftool/cfg.h
> index 909d17e6d4c2..b3793f4e1783 100644
> --- a/tools/bpf/bpftool/cfg.h
> +++ b/tools/bpf/bpftool/cfg.h
> @@ -6,6 +6,7 @@
> =20
>  #include "xlated_dumper.h"
> =20
> -void dump_xlated_cfg(struct dump_data *dd, void *buf, unsigned int len);
> +void dump_xlated_cfg(struct dump_data *dd, void *buf, unsigned int len,
> +		     bool opcodes, bool linum);
> =20
>  #endif /* __BPF_TOOL_CFG_H */
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index e9ee514b22d4..00d11ca6d3f2 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -230,7 +230,7 @@ void btf_dump_linfo_plain(const struct btf *btf,
>  void btf_dump_linfo_json(const struct btf *btf,
>  			 const struct bpf_line_info *linfo, bool linum);
>  void btf_dump_linfo_dotlabel(const struct btf *btf,
> -			     const struct bpf_line_info *linfo);
> +			     const struct bpf_line_info *linfo, bool linum);
> =20
>  struct nlattr;
>  struct ifinfomsg;
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 567ac37dbd86..848f57a7d762 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -854,7 +854,7 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode =
mode,
>  		else if (json_output)
>  			dump_xlated_json(&dd, buf, member_len, opcodes, linum);
>  		else if (visual)
> -			dump_xlated_cfg(&dd, buf, member_len);
> +			dump_xlated_cfg(&dd, buf, member_len, opcodes, linum);
>  		else
>  			dump_xlated_plain(&dd, buf, member_len, opcodes, linum);
>  		kernel_syms_destroy(&dd);
> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated=
_dumper.c
> index 5fbe94aa8589..c5e03833fadf 100644
> --- a/tools/bpf/bpftool/xlated_dumper.c
> +++ b/tools/bpf/bpftool/xlated_dumper.c
> @@ -361,7 +361,8 @@ void dump_xlated_plain(struct dump_data *dd, void *bu=
f, unsigned int len,
>  }
> =20
>  void dump_xlated_for_graph(struct dump_data *dd, void *buf_start, void *=
buf_end,
> -			   unsigned int start_idx)
> +			   unsigned int start_idx,
> +			   bool opcodes, bool linum)
>  {
>  	const struct bpf_insn_cbs cbs =3D {
>  		.cb_print	=3D print_insn_for_graph,
> @@ -405,7 +406,7 @@ void dump_xlated_for_graph(struct dump_data *dd, void=
 *buf_start, void *buf_end,
> =20
>  			linfo =3D bpf_prog_linfo__lfind(prog_linfo, insn_off, 0);
>  			if (linfo && linfo !=3D last_linfo) {
> -				btf_dump_linfo_dotlabel(btf, linfo);
> +				btf_dump_linfo_dotlabel(btf, linfo, linum);
>  				last_linfo =3D linfo;
>  			}
>  		}
> @@ -413,6 +414,16 @@ void dump_xlated_for_graph(struct dump_data *dd, voi=
d *buf_start, void *buf_end,
>  		printf("%d: ", insn_off);
>  		print_bpf_insn(&cbs, cur, true);
> =20
> +		if (opcodes) {
> +			printf("       ");

These spaces are treated as a single space by the dot renderer, as [1]
says: "Spaces are interpreted as separators between tokens, so they
must be escaped if you want spaces in the text."

[1] https://graphviz.org/doc/info/shapes.html#record

> +			fprint_hex(stdout, cur, 8, " ");
> +			if (double_insn && cur <=3D insn_end - 1) {
> +				printf(" ");
> +				fprint_hex(stdout, cur + 1, 8, " ");
> +			}
> +			printf("\\l\\\n");
> +		}
> +
>  		if (cur !=3D insn_end)
>  			printf(" | ");
>  	}
> diff --git a/tools/bpf/bpftool/xlated_dumper.h b/tools/bpf/bpftool/xlated=
_dumper.h
> index 54847e174273..9a946377b0e6 100644
> --- a/tools/bpf/bpftool/xlated_dumper.h
> +++ b/tools/bpf/bpftool/xlated_dumper.h
> @@ -34,6 +34,7 @@ void dump_xlated_json(struct dump_data *dd, void *buf, =
unsigned int len,
>  void dump_xlated_plain(struct dump_data *dd, void *buf, unsigned int len=
,
>  		       bool opcodes, bool linum);
>  void dump_xlated_for_graph(struct dump_data *dd, void *buf, void *buf_en=
d,
> -			   unsigned int start_index);
> +			   unsigned int start_index,
> +			   bool opcodes, bool linum);
> =20
>  #endif

