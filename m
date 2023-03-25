Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496C16C8A93
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 04:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjCYDFV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 23:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCYDFU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 23:05:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A3B2683
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 20:05:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c187-20020a25c0c4000000b00b6fd84f760dso3528372ybf.12
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 20:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679713518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3u4gfnZFo0FH5ozGlBGacYSx5WR5cwJeJ3/BmixkRvU=;
        b=NI7WAxoDLlGZnTjS/N2eLEJ/dieGsZSrrpYDuIh7IrtQEFa6/3E7EJ5rTzQNrtQ9Fh
         c+MjylfagRiRgdBRD++GP55c+OdvWiRjYVlhc5riN5F1sPN6QjnEw0f7qVNYK4DXsPkG
         flBpEyDrAjzWdnuIAEbxL+2sMXyb/9quv+6hxpv+coM01zS2AKiGShfQOtFuPTzLVyql
         NmLCTE12k63xOAUUFVKRQ3Czoy94qpDiHFjyBfFfXh313IrDnHOw0tZee/l0p9LawUV+
         45MVkQzDM/D7IeYWBy6hDPqn6a/OcvV4rS8sBq4yvhjaRLjbfVud/DvZ67jcmPS6+UUx
         rEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679713518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3u4gfnZFo0FH5ozGlBGacYSx5WR5cwJeJ3/BmixkRvU=;
        b=LLe7L3AROnINSRo5I1cfaivgoogcRlr8AATbmIWbOz3K5w+66QGKrnGNvrZkx0BKT4
         Zqmu4So5FTqK1VSZ8fs9ykfOo/tJWLyOKNvVpmDp6aVO6nllFYWO7PY/lerheifuFuHi
         TZPeMnA/nOKRlJpbmsVRo7B+6wOqxD+G2OTxSV0wX3kTzXatzLpyApEZzwokH6shAwZU
         aZQtzSGldZAa7qmTcjPEXeNnFjzIvUYV2dIal7OJKPYCBs5nTOS9fuhQm0JUNxZDBTJb
         PCm0hq4uGjU85hg9rKjb1Fo7id1d2Eu6Z2fbu6Lxc+bT16dG1r0XNRgnNUzynNPomczk
         8luQ==
X-Gm-Message-State: AAQBX9cdjaxTA1MLhTKqsuTnoYKRURBltuDhalnV216oNVMr7ruL14ue
        JUSAfDr9OGJ+UMlN9haFsBeAMys=
X-Google-Smtp-Source: AKy350ZCU7FYw3Gy3bNQlSkVgSsUq403ZFo3cXwC780d3ELXp5StdCir+QqJdaglE6TfK9vF+MdfejE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:1201:b0:b6c:4d60:1bd6 with SMTP id
 s1-20020a056902120100b00b6c4d601bd6mr2853035ybu.9.1679713518049; Fri, 24 Mar
 2023 20:05:18 -0700 (PDT)
Date:   Fri, 24 Mar 2023 20:05:16 -0700
In-Reply-To: <20230324230209.161008-4-quentin@isovalent.com>
Mime-Version: 1.0
References: <20230324230209.161008-1-quentin@isovalent.com> <20230324230209.161008-4-quentin@isovalent.com>
Message-ID: <ZB5k7DFJ4TRe1W7I@google.com>
Subject: Re: [PATCH bpf-next 3/5] bpftool: Support inline annotations when
 dumping the CFG of a program
From:   Stanislav Fomichev <sdf@google.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/24, Quentin Monnet wrote:
> We support dumping the control flow graph of loaded programs to the DOT
> format with bpftool, but so far this feature wouldn't display the source
> code lines available through BTF along with the eBPF bytecode. Let's add
> support for these annotations, to make it easier to read the graph.

> In prog.c, we move the call to dump_xlated_cfg() in order to pass and
> use the full struct dump_data, instead of creating a minimal one in
> draw_bb_node().

> We pass the pointer to this struct down to dump_xlated_for_graph() in
> xlated_dumper.c, where most of the logics is added. We deal with BTF
> mostly like we do for plain or JSON output, except that we cannot use a
> "nr_skip" value to skip a given number of linfo records (we don't
> process the BPF instructions linearly, and apart from the root of the
> graph we don't know how many records we should skip, so we just store
> the last linfo and make sure the new one we find is different before
> printing it).

> When printing the source instructions to the label of a DOT graph node,
> there are a few subtleties to address. We want some special newline
> markers, and there are some characters that we must escape. To deal with
> them, we introduce a new dedicated function btf_dump_linfo_dotlabel() in
> btf_dumper.c. We'll reuse this function in a later commit to format the
> filepath, line, and column references as well.

> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> ---
>   tools/bpf/bpftool/btf_dumper.c    | 34 +++++++++++++++++++++++++++++++
>   tools/bpf/bpftool/cfg.c           | 23 +++++++++------------
>   tools/bpf/bpftool/cfg.h           |  4 +++-
>   tools/bpf/bpftool/main.h          |  2 ++
>   tools/bpf/bpftool/prog.c          | 17 +++++++---------
>   tools/bpf/bpftool/xlated_dumper.c | 32 ++++++++++++++++++++++++++++-
>   6 files changed, 87 insertions(+), 25 deletions(-)

> diff --git a/tools/bpf/bpftool/btf_dumper.c  
> b/tools/bpf/bpftool/btf_dumper.c
> index e7f6ec3a8f35..504d7c75cc27 100644
> --- a/tools/bpf/bpftool/btf_dumper.c
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -821,3 +821,37 @@ void btf_dump_linfo_json(const struct btf *btf,
>   					BPF_LINE_INFO_LINE_COL(linfo->line_col));
>   	}
>   }
> +
> +static void dotlabel_puts(const char *s)
> +{
> +	FILE *stream = stdout;
> +
> +	for (; *s; ++s) {
> +		switch (*s) {
> +		case '\\':
> +		case '"':
> +		case '{':
> +		case '}':
> +		case '>':
> +		case '|':
> +			fputc('\\', stream);
> +			__fallthrough;
> +		default:
> +			fputc(*s, stream);
> +		}

nit: optionally, if you're going to respin, maybe do putchar instead
of fputc + stdout? (not sure why you're doing fputs)

> +	}
> +}
> +
> +void btf_dump_linfo_dotlabel(const struct btf *btf,
> +			     const struct bpf_line_info *linfo)
> +{
> +	const char *line = btf__name_by_offset(btf, linfo->line_off);
> +
> +	if (!line)
> +		return;
> +	line = ltrim(line);
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
>   	}
>   }

> -static void draw_bb_node(struct func_node *func, struct bb_node *bb)
> +static void
> +draw_bb_node(struct func_node *func, struct bb_node *bb, struct  
> dump_data *dd)
>   {
>   	const char *shape;

> @@ -398,13 +399,9 @@ static void draw_bb_node(struct func_node *func,  
> struct bb_node *bb)
>   		printf("EXIT");
>   	} else {
>   		unsigned int start_idx;
> -		struct dump_data dd = {};
> -
> -		printf("{");
> -		kernel_syms_load(&dd);
> +		printf("{\\\n");
>   		start_idx = bb->head - func->start;
> -		dump_xlated_for_graph(&dd, bb->head, bb->tail, start_idx);
> -		kernel_syms_destroy(&dd);
> +		dump_xlated_for_graph(dd, bb->head, bb->tail, start_idx);
>   		printf("}");
>   	}

> @@ -430,12 +427,12 @@ static void draw_bb_succ_edges(struct func_node  
> *func, struct bb_node *bb)
>   	}
>   }

> -static void func_output_bb_def(struct func_node *func)
> +static void func_output_bb_def(struct func_node *func, struct dump_data  
> *dd)
>   {
>   	struct bb_node *bb;

>   	list_for_each_entry(bb, &func->bbs, l) {
> -		draw_bb_node(func, bb);
> +		draw_bb_node(func, bb, dd);
>   	}
>   }

> @@ -455,7 +452,7 @@ static void func_output_edges(struct func_node *func)
>   	       func_idx, ENTRY_BLOCK_INDEX, func_idx, EXIT_BLOCK_INDEX);
>   }

> -static void cfg_dump(struct cfg *cfg)
> +static void cfg_dump(struct cfg *cfg, struct dump_data *dd)
>   {
>   	struct func_node *func;

> @@ -463,14 +460,14 @@ static void cfg_dump(struct cfg *cfg)
>   	list_for_each_entry(func, &cfg->funcs, l) {
>   		printf("subgraph \"cluster_%d\"  
> {\n\tstyle=\"dashed\";\n\tcolor=\"black\";\n\tlabel=\"func_%d ()\";\n",
>   		       func->idx, func->idx);
> -		func_output_bb_def(func);
> +		func_output_bb_def(func, dd);
>   		func_output_edges(func);
>   		printf("}\n");
>   	}
>   	printf("}\n");
>   }

> -void dump_xlated_cfg(void *buf, unsigned int len)
> +void dump_xlated_cfg(struct dump_data *dd, void *buf, unsigned int len)
>   {
>   	struct bpf_insn *insn = buf;
>   	struct cfg cfg;
> @@ -479,7 +476,7 @@ void dump_xlated_cfg(void *buf, unsigned int len)
>   	if (cfg_build(&cfg, insn, len))
>   		return;

> -	cfg_dump(&cfg);
> +	cfg_dump(&cfg, dd);

>   	cfg_destroy(&cfg);
>   }
> diff --git a/tools/bpf/bpftool/cfg.h b/tools/bpf/bpftool/cfg.h
> index e144257ea6d2..909d17e6d4c2 100644
> --- a/tools/bpf/bpftool/cfg.h
> +++ b/tools/bpf/bpftool/cfg.h
> @@ -4,6 +4,8 @@
>   #ifndef __BPF_TOOL_CFG_H
>   #define __BPF_TOOL_CFG_H

> -void dump_xlated_cfg(void *buf, unsigned int len);
> +#include "xlated_dumper.h"
> +
> +void dump_xlated_cfg(struct dump_data *dd, void *buf, unsigned int len);

>   #endif /* __BPF_TOOL_CFG_H */
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 0ef373cef4c7..e9ee514b22d4 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -229,6 +229,8 @@ void btf_dump_linfo_plain(const struct btf *btf,
>   			  const char *prefix, bool linum);
>   void btf_dump_linfo_json(const struct btf *btf,
>   			 const struct bpf_line_info *linfo, bool linum);
> +void btf_dump_linfo_dotlabel(const struct btf *btf,
> +			     const struct bpf_line_info *linfo);

>   struct nlattr;
>   struct ifinfomsg;
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index afbe3ec342c8..d855118f0d96 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -840,11 +840,6 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode  
> mode,
>   					      false))
>   				goto exit_free;
>   		}
> -	} else if (visual) {
> -		if (json_output)
> -			jsonw_null(json_wtr);
> -		else
> -			dump_xlated_cfg(buf, member_len);
>   	} else {
>   		kernel_syms_load(&dd);
>   		dd.nr_jited_ksyms = info->nr_jited_ksyms;
> @@ -854,12 +849,14 @@ prog_dump(struct bpf_prog_info *info, enum  
> dump_mode mode,
>   		dd.finfo_rec_size = info->func_info_rec_size;
>   		dd.prog_linfo = prog_linfo;

> -		if (json_output)
> -			dump_xlated_json(&dd, buf, member_len, opcodes,
> -					 linum);
> +		if (json_output && visual)
> +			jsonw_null(json_wtr);
> +		else if (json_output)
> +			dump_xlated_json(&dd, buf, member_len, opcodes, linum);
> +		else if (visual)
> +			dump_xlated_cfg(&dd, buf, member_len);
>   		else
> -			dump_xlated_plain(&dd, buf, member_len, opcodes,
> -					  linum);
> +			dump_xlated_plain(&dd, buf, member_len, opcodes, linum);
>   		kernel_syms_destroy(&dd);
>   	}

> diff --git a/tools/bpf/bpftool/xlated_dumper.c  
> b/tools/bpf/bpftool/xlated_dumper.c
> index 3daa05d9bbb7..5fbe94aa8589 100644
> --- a/tools/bpf/bpftool/xlated_dumper.c
> +++ b/tools/bpf/bpftool/xlated_dumper.c
> @@ -369,20 +369,50 @@ void dump_xlated_for_graph(struct dump_data *dd,  
> void *buf_start, void *buf_end,
>   		.cb_imm		= print_imm,
>   		.private_data	= dd,
>   	};
> +	const struct bpf_prog_linfo *prog_linfo = dd->prog_linfo;
> +	const struct bpf_line_info *last_linfo = NULL;
> +	struct bpf_func_info *record = dd->func_info;
>   	struct bpf_insn *insn_start = buf_start;
>   	struct bpf_insn *insn_end = buf_end;
>   	struct bpf_insn *cur = insn_start;
> +	struct btf *btf = dd->btf;
>   	bool double_insn = false;
> +	char func_sig[1024];

>   	for (; cur <= insn_end; cur++) {
> +		unsigned int insn_off;
> +
>   		if (double_insn) {
>   			double_insn = false;
>   			continue;
>   		}
>   		double_insn = cur->code == (BPF_LD | BPF_IMM | BPF_DW);

> -		printf("% 4d: ", (int)(cur - insn_start + start_idx));
> +		insn_off = (unsigned int)(cur - insn_start + start_idx);
> +		if (btf && record) {
> +			if (record->insn_off == insn_off) {
> +				btf_dumper_type_only(btf, record->type_id,
> +						     func_sig,
> +						     sizeof(func_sig));
> +				if (func_sig[0] != '\0')
> +					printf("; %s:\\l\\\n", func_sig);
> +				record = (void *)record + dd->finfo_rec_size;
> +			}
> +		}
> +
> +		if (prog_linfo) {
> +			const struct bpf_line_info *linfo;
> +
> +			linfo = bpf_prog_linfo__lfind(prog_linfo, insn_off, 0);
> +			if (linfo && linfo != last_linfo) {
> +				btf_dump_linfo_dotlabel(btf, linfo);
> +				last_linfo = linfo;
> +			}
> +		}
> +
> +		printf("%d: ", insn_off);
>   		print_bpf_insn(&cbs, cur, true);
> +
>   		if (cur != insn_end)
>   			printf(" | ");
>   	}
> --
> 2.34.1

