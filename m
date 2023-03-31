Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAE76D2326
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 16:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjCaOx2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 10:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjCaOxJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 10:53:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DB71DF9A
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 07:52:53 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id s13so13031965wmr.4
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680274372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wG8mJy96PY4usBRIGUsanQ5FkXRUkj23SFXfIcJ+Wv8=;
        b=RgMZFuQmKolmBFm2j2eRnu1i8D8CwBkLfg6nRE2NKV0d3ASERRHrlQMAMwyhx1BaRf
         xzuQCmV2XCZXTFrW9dTDIzOyy+FrXbc53SUo2qlNAQ5rDdyfRHS7ZpYx9efABuhUfMBG
         2D0N9y9XSXFbj6uJUMEHKN85hXgnvjBhorOzrm3ubbFezhWYs1iPl9Jh8lm5ySfw6HE2
         cCwGazF0116IvleXsdH557XU1kRYj+lmxThkMNMJ0exBfVQYvX1Txrnoo5HQqd1JQFnE
         mNKjE6fYJb1aEjcFv5ghr6Z7BLBcpZD0zJ596W5VIvB85TCXMffJzd15S3jr8rRN2hxl
         4Xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680274372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wG8mJy96PY4usBRIGUsanQ5FkXRUkj23SFXfIcJ+Wv8=;
        b=IugwxrSOuLMGYVoyQXpwKSZ4IImKuk8JrmPq4dSEhv96ug9bUDRSCyFpEEGAfgX3fK
         lXtBfWeeuiZbr5u0ULX8SOZKrsEzc15ty1XmulLBPUr+omyLYZfMfTMH5+Rk6aDyVa20
         L8Ud19TvqGQvvkApseiOhlDHvwS3VN7f04CdcSRC+zo9eht44O22OIqbs9qDAmEr/Dch
         rkvXDmhosC87AjjUmtfv1vnRENbtCD5bSmAGNdsnMPWpN8VShT78K0GFcP0oy3A+0QKu
         oDPRsRiQwcUzOlpPQJAHtV2EV/MCCoSOo62uhFi4zM1Kci83BrcnctGnQRdMufu2un33
         Jnfg==
X-Gm-Message-State: AO0yUKUp0dCHsvxnO5ha7AF46vJs8KKA4hThAszipS87Bz2yj1WLXvQA
        yADb9mDParvR17+cO0dq4svPaAIBAyt+5JGYSUd6vQ==
X-Google-Smtp-Source: AK7set9YaXLoAZH8XmSaYn3KQWHTuJKG0U199djrZZYEfnOwNxguRF0oROHO5JZ4JowlKDq5QIM+TA==
X-Received: by 2002:a05:600c:204:b0:3ea:d620:57a7 with SMTP id 4-20020a05600c020400b003ead62057a7mr21400080wmi.8.1680274371702;
        Fri, 31 Mar 2023 07:52:51 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:2132:91fa:4658:d135? ([2a02:8011:e80c:0:2132:91fa:4658:d135])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bcb89000000b003ed4f6c6234sm2911107wmi.23.2023.03.31.07.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:52:51 -0700 (PDT)
Message-ID: <899fb41c-2bc4-c60f-c83b-4eb5c348e711@isovalent.com>
Date:   Fri, 31 Mar 2023 15:52:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH bpf-next v2 5/5] bpftool: Support printing opcodes and
 source file references in CFG
Content-Language: en-GB
To:     Eduard Zingerman <eddyz87@gmail.com>,
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
References: <20230327110655.58363-1-quentin@isovalent.com>
 <20230327110655.58363-6-quentin@isovalent.com>
 <fa28d05a6a123aea329a02ac666dbb18e7c5f519.camel@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <fa28d05a6a123aea329a02ac666dbb18e7c5f519.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-03-27 20:04 UTC+0300 ~ Eduard Zingerman <eddyz87@gmail.com>
> On Mon, 2023-03-27 at 12:06 +0100, Quentin Monnet wrote:
>> Add support for displaying opcodes or/and file references (filepath,
>> line and column numbers) when dumping the control flow graphs of loaded
>> BPF programs with bpftool.
>>
>> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
>> Acked-by: Stanislav Fomichev <sdf@google.com>
>> ---
>>  tools/bpf/bpftool/btf_dumper.c    | 19 ++++++++++++++++++-
>>  tools/bpf/bpftool/cfg.c           | 22 ++++++++++++++--------
>>  tools/bpf/bpftool/cfg.h           |  3 ++-
>>  tools/bpf/bpftool/main.h          |  2 +-
>>  tools/bpf/bpftool/prog.c          |  2 +-
>>  tools/bpf/bpftool/xlated_dumper.c | 15 +++++++++++++--
>>  tools/bpf/bpftool/xlated_dumper.h |  3 ++-
>>  7 files changed, 51 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
>> index 8bfc1b69497d..24835c3f9a1c 100644
>> --- a/tools/bpf/bpftool/btf_dumper.c
>> +++ b/tools/bpf/bpftool/btf_dumper.c
>> @@ -841,7 +841,7 @@ static void dotlabel_puts(const char *s)
>>  }
>>  
>>  void btf_dump_linfo_dotlabel(const struct btf *btf,
>> -			     const struct bpf_line_info *linfo)
>> +			     const struct bpf_line_info *linfo, bool linum)
>>  {
>>  	const char *line = btf__name_by_offset(btf, linfo->line_off);
>>  
>> @@ -849,6 +849,23 @@ void btf_dump_linfo_dotlabel(const struct btf *btf,
>>  		return;
>>  	line = ltrim(line);
>>  
>> +	if (linum) {
>> +		const char *file = btf__name_by_offset(btf, linfo->file_name_off);
>> +
>> +		/* More forgiving on file because linum option is
>> +		 * expected to provide more info than the already
>> +		 * available src line.
>> +		 */
>> +		if (!file)
>> +			file = "";
>> +
>> +		printf("; [file:");
>> +		dotlabel_puts(file);
>> +		printf("line_num:%u line_col:%u]\\l\\\n",
> 
> Space between file name and 'line_num' is missing.

My bad, thanks!

> 
> Also, at-least for BPF test-cases the labels might become quite long,
> which makes graph unnecessarily wide, e.g.:
> 
>   ; [file:/home/eddy/work/bpf-next/tools/testing/selftests/bpf/progs/bpf_flow.cline_num:97 line_col:34]\l\
> 
> The file names are encoded in full during compilation, but maybe
> shorten long file names by removing some preceding levels
> (and use shorter tags 'line:', 'col:', is 'file:' tag necessary at all?).
> For example:
> 
>   ; [.../progs/bpf_flow.c line:97 col:34]\l\.

I thought about that but was unsure. But yeah, I suppose the risk of
users getting confused about where the file is located is limited,
especially given that we still have regular program dump that will keep
the full path. OK I'll look into that for the next version.

> 
>> +		       BPF_LINE_INFO_LINE_NUM(linfo->line_col),
>> +		       BPF_LINE_INFO_LINE_COL(linfo->line_col));
>> +	}
>> +
>>  	printf("; ");
>>  	dotlabel_puts(line);
>>  	printf("\\l\\\n");
>> diff --git a/tools/bpf/bpftool/cfg.c b/tools/bpf/bpftool/cfg.c
>> index 9fdc1f0cdd6e..eec437cca2ea 100644
>> --- a/tools/bpf/bpftool/cfg.c
>> +++ b/tools/bpf/bpftool/cfg.c
>> @@ -381,7 +381,8 @@ static void cfg_destroy(struct cfg *cfg)
>>  }
>>  
>>  static void
>> -draw_bb_node(struct func_node *func, struct bb_node *bb, struct dump_data *dd)
>> +draw_bb_node(struct func_node *func, struct bb_node *bb, struct dump_data *dd,
>> +	     bool opcodes, bool linum)
>>  {
>>  	const char *shape;
>>  
>> @@ -401,7 +402,8 @@ draw_bb_node(struct func_node *func, struct bb_node *bb, struct dump_data *dd)
>>  		unsigned int start_idx;
>>  		printf("{\\\n");
>>  		start_idx = bb->head - func->start;
>> -		dump_xlated_for_graph(dd, bb->head, bb->tail, start_idx);
>> +		dump_xlated_for_graph(dd, bb->head, bb->tail, start_idx,
>> +				      opcodes, linum);
>>  		printf("}");
>>  	}
>>  
>> @@ -427,12 +429,14 @@ static void draw_bb_succ_edges(struct func_node *func, struct bb_node *bb)
>>  	}
>>  }
>>  
>> -static void func_output_bb_def(struct func_node *func, struct dump_data *dd)
>> +static void
>> +func_output_bb_def(struct func_node *func, struct dump_data *dd,
>> +		   bool opcodes, bool linum)
>>  {
>>  	struct bb_node *bb;
>>  
>>  	list_for_each_entry(bb, &func->bbs, l) {
>> -		draw_bb_node(func, bb, dd);
>> +		draw_bb_node(func, bb, dd, opcodes, linum);
>>  	}
>>  }
>>  
>> @@ -452,7 +456,8 @@ static void func_output_edges(struct func_node *func)
>>  	       func_idx, ENTRY_BLOCK_INDEX, func_idx, EXIT_BLOCK_INDEX);
>>  }
>>  
>> -static void cfg_dump(struct cfg *cfg, struct dump_data *dd)
>> +static void
>> +cfg_dump(struct cfg *cfg, struct dump_data *dd, bool opcodes, bool linum)
>>  {
>>  	struct func_node *func;
>>  
>> @@ -460,14 +465,15 @@ static void cfg_dump(struct cfg *cfg, struct dump_data *dd)
>>  	list_for_each_entry(func, &cfg->funcs, l) {
>>  		printf("subgraph \"cluster_%d\" {\n\tstyle=\"dashed\";\n\tcolor=\"black\";\n\tlabel=\"func_%d ()\";\n",
>>  		       func->idx, func->idx);
>> -		func_output_bb_def(func, dd);
>> +		func_output_bb_def(func, dd, opcodes, linum);
>>  		func_output_edges(func);
>>  		printf("}\n");
>>  	}
>>  	printf("}\n");
>>  }
>>  
>> -void dump_xlated_cfg(struct dump_data *dd, void *buf, unsigned int len)
>> +void dump_xlated_cfg(struct dump_data *dd, void *buf, unsigned int len,
>> +		     bool opcodes, bool linum)
>>  {
>>  	struct bpf_insn *insn = buf;
>>  	struct cfg cfg;
>> @@ -476,7 +482,7 @@ void dump_xlated_cfg(struct dump_data *dd, void *buf, unsigned int len)
>>  	if (cfg_build(&cfg, insn, len))
>>  		return;
>>  
>> -	cfg_dump(&cfg, dd);
>> +	cfg_dump(&cfg, dd, opcodes, linum);
>>  
>>  	cfg_destroy(&cfg);
>>  }
>> diff --git a/tools/bpf/bpftool/cfg.h b/tools/bpf/bpftool/cfg.h
>> index 909d17e6d4c2..b3793f4e1783 100644
>> --- a/tools/bpf/bpftool/cfg.h
>> +++ b/tools/bpf/bpftool/cfg.h
>> @@ -6,6 +6,7 @@
>>  
>>  #include "xlated_dumper.h"
>>  
>> -void dump_xlated_cfg(struct dump_data *dd, void *buf, unsigned int len);
>> +void dump_xlated_cfg(struct dump_data *dd, void *buf, unsigned int len,
>> +		     bool opcodes, bool linum);
>>  
>>  #endif /* __BPF_TOOL_CFG_H */
>> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
>> index e9ee514b22d4..00d11ca6d3f2 100644
>> --- a/tools/bpf/bpftool/main.h
>> +++ b/tools/bpf/bpftool/main.h
>> @@ -230,7 +230,7 @@ void btf_dump_linfo_plain(const struct btf *btf,
>>  void btf_dump_linfo_json(const struct btf *btf,
>>  			 const struct bpf_line_info *linfo, bool linum);
>>  void btf_dump_linfo_dotlabel(const struct btf *btf,
>> -			     const struct bpf_line_info *linfo);
>> +			     const struct bpf_line_info *linfo, bool linum);
>>  
>>  struct nlattr;
>>  struct ifinfomsg;
>> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>> index 567ac37dbd86..848f57a7d762 100644
>> --- a/tools/bpf/bpftool/prog.c
>> +++ b/tools/bpf/bpftool/prog.c
>> @@ -854,7 +854,7 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
>>  		else if (json_output)
>>  			dump_xlated_json(&dd, buf, member_len, opcodes, linum);
>>  		else if (visual)
>> -			dump_xlated_cfg(&dd, buf, member_len);
>> +			dump_xlated_cfg(&dd, buf, member_len, opcodes, linum);
>>  		else
>>  			dump_xlated_plain(&dd, buf, member_len, opcodes, linum);
>>  		kernel_syms_destroy(&dd);
>> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
>> index 5fbe94aa8589..c5e03833fadf 100644
>> --- a/tools/bpf/bpftool/xlated_dumper.c
>> +++ b/tools/bpf/bpftool/xlated_dumper.c
>> @@ -361,7 +361,8 @@ void dump_xlated_plain(struct dump_data *dd, void *buf, unsigned int len,
>>  }
>>  
>>  void dump_xlated_for_graph(struct dump_data *dd, void *buf_start, void *buf_end,
>> -			   unsigned int start_idx)
>> +			   unsigned int start_idx,
>> +			   bool opcodes, bool linum)
>>  {
>>  	const struct bpf_insn_cbs cbs = {
>>  		.cb_print	= print_insn_for_graph,
>> @@ -405,7 +406,7 @@ void dump_xlated_for_graph(struct dump_data *dd, void *buf_start, void *buf_end,
>>  
>>  			linfo = bpf_prog_linfo__lfind(prog_linfo, insn_off, 0);
>>  			if (linfo && linfo != last_linfo) {
>> -				btf_dump_linfo_dotlabel(btf, linfo);
>> +				btf_dump_linfo_dotlabel(btf, linfo, linum);
>>  				last_linfo = linfo;
>>  			}
>>  		}
>> @@ -413,6 +414,16 @@ void dump_xlated_for_graph(struct dump_data *dd, void *buf_start, void *buf_end,
>>  		printf("%d: ", insn_off);
>>  		print_bpf_insn(&cbs, cur, true);
>>  
>> +		if (opcodes) {
>> +			printf("       ");
> 
> These spaces are treated as a single space by the dot renderer, as [1]
> says: "Spaces are interpreted as separators between tokens, so they
> must be escaped if you want spaces in the text."
> 
> [1] https://graphviz.org/doc/info/shapes.html#record

I noticed, I kept the multiple spaces to make the DOT output slightly
more readable. But it would maybe make sense to indent more in the graph
as well, if it doesn't make opcode sequences wider than instructions.
I'll have a look at this.
