Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980D16D2319
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 16:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjCaOxD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 10:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjCaOw6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 10:52:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FF51E718
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 07:52:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l27so22709554wrb.2
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 07:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680274355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ktIwYpxO1Lv0ZMglh5zUQer4d6hi6iZqSeZEBlXZU5I=;
        b=JqJheeHYv9GsLix14aRCaepqaY+tAomVOEmGlJg/8G0Dhw+9k1ht9iK3fKtQKIdaRe
         PPFrb/oI//LUDCrW6e8yDtcQJXGevFIvcsRT1vmDBxJ7F8cEnM9vZ0MwmH31/2TPLHr6
         Q/gmFdhRMQUVbWZo5ft7USXDGSwFxh+L3H0SVRlS2FNatu9yoM7Uz0JpQD0p6kJXAfsK
         oK93TwyJetUjtK4P1wJ+8KueLj2nRpeNN8lgDTfZrYAK0IazTYog+kfljnugBQ6JMJyj
         NtfTFTi+87OZGCZ04VS8HnnWMPfW2YaqdcJCFyUiIBbLtLJ9+arEjFdOdByjG7ByipSa
         6KDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680274355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ktIwYpxO1Lv0ZMglh5zUQer4d6hi6iZqSeZEBlXZU5I=;
        b=Ub0I/XOyORVrGCrbKLRXOfGepHrTzyhrVJEPigROi2ktyEbfAKN4SbRRnLq+0WhMN9
         FCw/ZViSCUOBg+u+Tsk7H7t5/WLGftsoz0Swewp8VEGAxN3VHGOVkRLiiDV+Ld68+zIY
         NG4AnAUiHSmn3M1N0FDG8o30F1MK2+dI9ZSbCYmT9CAWD7LqeiY57cFskcBeshCX9VmB
         yj4MYDQkWhts75e9Ij92AtKuIn2ruQy1bBQaBG2gn71DB/iZLGVqOJtRUY6fYi7xFISV
         R0y+bu/xvu2JMuyv1mtDgwvx6P/j/zzUMfO9lSeF3R4m0z788nFGc/U51qs0ouRcfIq9
         Kmxg==
X-Gm-Message-State: AAQBX9cdTMdeP6rBQsJm6nrhBIJWyQU7BS9WJXzjVPhSkWHHRMSiRJya
        /gP1xSIzRzRDnh1mkgv3XHsPLQbxMfHYWhR14XaWqw==
X-Google-Smtp-Source: AKy350Zu9S8iSj/EX3EBHNKU7k+uJcwRtVJkkIYmDeWfWPT4vIRVTIms5K4W9chRB0d2iIisCJGBMA==
X-Received: by 2002:a05:6000:50b:b0:2db:bca:ac7d with SMTP id a11-20020a056000050b00b002db0bcaac7dmr20811502wrf.67.1680274354843;
        Fri, 31 Mar 2023 07:52:34 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:2132:91fa:4658:d135? ([2a02:8011:e80c:0:2132:91fa:4658:d135])
        by smtp.gmail.com with ESMTPSA id w18-20020a5d6812000000b002cde25fba30sm2428422wru.1.2023.03.31.07.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:52:34 -0700 (PDT)
Message-ID: <7f785b9b-7e61-2b05-1170-64bcb2fd44c4@isovalent.com>
Date:   Fri, 31 Mar 2023 15:52:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH bpf-next v2 3/5] bpftool: Support inline annotations when
 dumping the CFG of a program
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
 <20230327110655.58363-4-quentin@isovalent.com>
 <288e8ccf770d28d47f26d31c989d65ab29fdf05c.camel@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <288e8ccf770d28d47f26d31c989d65ab29fdf05c.camel@gmail.com>
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

Hi Eduard, apologies for the slow answer

2023-03-27 20:02 UTC+0300 ~ Eduard Zingerman <eddyz87@gmail.com>
> On Mon, 2023-03-27 at 12:06 +0100, Quentin Monnet wrote:
>> We support dumping the control flow graph of loaded programs to the DOT
>> format with bpftool, but so far this feature wouldn't display the source
>> code lines available through BTF along with the eBPF bytecode. Let's add
>> support for these annotations, to make it easier to read the graph.
>>
>> In prog.c, we move the call to dump_xlated_cfg() in order to pass and
>> use the full struct dump_data, instead of creating a minimal one in
>> draw_bb_node().
>>
>> We pass the pointer to this struct down to dump_xlated_for_graph() in
>> xlated_dumper.c, where most of the logics is added. We deal with BTF
>> mostly like we do for plain or JSON output, except that we cannot use a
>> "nr_skip" value to skip a given number of linfo records (we don't
>> process the BPF instructions linearly, and apart from the root of the
>> graph we don't know how many records we should skip, so we just store
>> the last linfo and make sure the new one we find is different before
>> printing it).
>>
>> When printing the source instructions to the label of a DOT graph node,
>> there are a few subtleties to address. We want some special newline
>> markers, and there are some characters that we must escape. To deal with
>> them, we introduce a new dedicated function btf_dump_linfo_dotlabel() in
>> btf_dumper.c. We'll reuse this function in a later commit to format the
>> filepath, line, and column references as well.
>>
>> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
>> Acked-by: Stanislav Fomichev <sdf@google.com>
>> ---
>>  tools/bpf/bpftool/btf_dumper.c    | 32 +++++++++++++++++++++++++++++++
>>  tools/bpf/bpftool/cfg.c           | 23 ++++++++++------------
>>  tools/bpf/bpftool/cfg.h           |  4 +++-
>>  tools/bpf/bpftool/main.h          |  2 ++
>>  tools/bpf/bpftool/prog.c          | 17 +++++++---------
>>  tools/bpf/bpftool/xlated_dumper.c | 32 ++++++++++++++++++++++++++++++-
>>  6 files changed, 85 insertions(+), 25 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
>> index e7f6ec3a8f35..8bfc1b69497d 100644
>> --- a/tools/bpf/bpftool/btf_dumper.c
>> +++ b/tools/bpf/bpftool/btf_dumper.c
>> @@ -821,3 +821,35 @@ void btf_dump_linfo_json(const struct btf *btf,
>>  					BPF_LINE_INFO_LINE_COL(linfo->line_col));
>>  	}
>>  }
>> +
>> +static void dotlabel_puts(const char *s)
>> +{
>> +	for (; *s; ++s) {
>> +		switch (*s) {
>> +		case '\\':
>> +		case '"':
>> +		case '{':
>> +		case '}':
>> +		case '>':
> 
> The "case '<':" is missing, w/o it dot reports warnings as follows:
> 
>   Error: bad label format {; if (hdr + hdr_size <= data_end)...

Good catch, thank you!

> 
> I used existing bpt testcase for testing:
> 
>   $ cd <kernel>/tools/testing/selftests/bpf
>   $ bpftool prog load bpf_flow.bpf.o /sys/fs/bpf/test-prog
>   $ prog dump xlated pinned /sys/fs/bpf/test-prog visual > test.cfg
>   $ dot -Tpng -O test.cfg
>   
> Also [1] says the following:
> 
>> Braces, vertical bars and angle brackets must be escaped with a
>> backslash character if you wish them to appear as a literal
>> character. Spaces are interpreted as separators between tokens, so
>> they must be escaped if you want spaces in the text.
> 
> So, maybe escape spaces as well?
> 
> [1] https://graphviz.org/doc/info/shapes.html#record

I hesitated a little, because we risk getting a wider output if we
preserve spaces. But it's maybe better to preserve the initial line
rather than to decide we can get rid of sequences with multiple
spaces... OK I'll escape them, too.

> 
>> +		case '|':
>> +			putchar('\\');
>> +			__fallthrough;
>> +		default:
>> +			putchar(*s);
>> +		}
>> +	}
>> +}
>> +
>> +void btf_dump_linfo_dotlabel(const struct btf *btf,
>> +			     const struct bpf_line_info *linfo)
>> +{
>> +	const char *line = btf__name_by_offset(btf, linfo->line_off);
>> +
>> +	if (!line)
>> +		return;
>> +	line = ltrim(line);
>> +
>> +	printf("; ");
>> +	dotlabel_puts(line);
>> +	printf("\\l\\\n");
>> +}
>> diff --git a/tools/bpf/bpftool/cfg.c b/tools/bpf/bpftool/cfg.c
>> index 1951219a9af7..9fdc1f0cdd6e 100644
>> --- a/tools/bpf/bpftool/cfg.c
>> +++ b/tools/bpf/bpftool/cfg.c
>> @@ -380,7 +380,8 @@ static void cfg_destroy(struct cfg *cfg)
>>  	}
>>  }
>>  
>> -static void draw_bb_node(struct func_node *func, struct bb_node *bb)
>> +static void
>> +draw_bb_node(struct func_node *func, struct bb_node *bb, struct dump_data *dd)
>>  {
>>  	const char *shape;
>>  
>> @@ -398,13 +399,9 @@ static void draw_bb_node(struct func_node *func, struct bb_node *bb)
>>  		printf("EXIT");
>>  	} else {
>>  		unsigned int start_idx;
>> -		struct dump_data dd = {};
>> -
>> -		printf("{");
>> -		kernel_syms_load(&dd);
>> +		printf("{\\\n");
>>  		start_idx = bb->head - func->start;
>> -		dump_xlated_for_graph(&dd, bb->head, bb->tail, start_idx);
>> -		kernel_syms_destroy(&dd);
>> +		dump_xlated_for_graph(dd, bb->head, bb->tail, start_idx);
>>  		printf("}");
>>  	}
>>  
>> @@ -430,12 +427,12 @@ static void draw_bb_succ_edges(struct func_node *func, struct bb_node *bb)
>>  	}
>>  }
>>  
>> -static void func_output_bb_def(struct func_node *func)
>> +static void func_output_bb_def(struct func_node *func, struct dump_data *dd)
>>  {
>>  	struct bb_node *bb;
>>  
>>  	list_for_each_entry(bb, &func->bbs, l) {
>> -		draw_bb_node(func, bb);
>> +		draw_bb_node(func, bb, dd);
>>  	}
>>  }
>>  
>> @@ -455,7 +452,7 @@ static void func_output_edges(struct func_node *func)
>>  	       func_idx, ENTRY_BLOCK_INDEX, func_idx, EXIT_BLOCK_INDEX);
>>  }
>>  
>> -static void cfg_dump(struct cfg *cfg)
>> +static void cfg_dump(struct cfg *cfg, struct dump_data *dd)
>>  {
>>  	struct func_node *func;
>>  
>> @@ -463,14 +460,14 @@ static void cfg_dump(struct cfg *cfg)
>>  	list_for_each_entry(func, &cfg->funcs, l) {
>>  		printf("subgraph \"cluster_%d\" {\n\tstyle=\"dashed\";\n\tcolor=\"black\";\n\tlabel=\"func_%d ()\";\n",
>>  		       func->idx, func->idx);
>> -		func_output_bb_def(func);
>> +		func_output_bb_def(func, dd);
>>  		func_output_edges(func);
>>  		printf("}\n");
>>  	}
>>  	printf("}\n");
>>  }
>>  
>> -void dump_xlated_cfg(void *buf, unsigned int len)
>> +void dump_xlated_cfg(struct dump_data *dd, void *buf, unsigned int len)
>>  {
>>  	struct bpf_insn *insn = buf;
>>  	struct cfg cfg;
>> @@ -479,7 +476,7 @@ void dump_xlated_cfg(void *buf, unsigned int len)
>>  	if (cfg_build(&cfg, insn, len))
>>  		return;
>>  
>> -	cfg_dump(&cfg);
>> +	cfg_dump(&cfg, dd);
>>  
>>  	cfg_destroy(&cfg);
>>  }
>> diff --git a/tools/bpf/bpftool/cfg.h b/tools/bpf/bpftool/cfg.h
>> index e144257ea6d2..909d17e6d4c2 100644
>> --- a/tools/bpf/bpftool/cfg.h
>> +++ b/tools/bpf/bpftool/cfg.h
>> @@ -4,6 +4,8 @@
>>  #ifndef __BPF_TOOL_CFG_H
>>  #define __BPF_TOOL_CFG_H
>>  
>> -void dump_xlated_cfg(void *buf, unsigned int len);
>> +#include "xlated_dumper.h"
>> +
>> +void dump_xlated_cfg(struct dump_data *dd, void *buf, unsigned int len);
>>  
>>  #endif /* __BPF_TOOL_CFG_H */
>> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
>> index 0ef373cef4c7..e9ee514b22d4 100644
>> --- a/tools/bpf/bpftool/main.h
>> +++ b/tools/bpf/bpftool/main.h
>> @@ -229,6 +229,8 @@ void btf_dump_linfo_plain(const struct btf *btf,
>>  			  const char *prefix, bool linum);
>>  void btf_dump_linfo_json(const struct btf *btf,
>>  			 const struct bpf_line_info *linfo, bool linum);
>> +void btf_dump_linfo_dotlabel(const struct btf *btf,
>> +			     const struct bpf_line_info *linfo);
>>  
>>  struct nlattr;
>>  struct ifinfomsg;
>> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>> index afbe3ec342c8..d855118f0d96 100644
>> --- a/tools/bpf/bpftool/prog.c
>> +++ b/tools/bpf/bpftool/prog.c
>> @@ -840,11 +840,6 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
>>  					      false))
>>  				goto exit_free;
>>  		}
>> -	} else if (visual) {
>> -		if (json_output)
>> -			jsonw_null(json_wtr);
>> -		else
>> -			dump_xlated_cfg(buf, member_len);
>>  	} else {
>>  		kernel_syms_load(&dd);
>>  		dd.nr_jited_ksyms = info->nr_jited_ksyms;
>> @@ -854,12 +849,14 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
>>  		dd.finfo_rec_size = info->func_info_rec_size;
>>  		dd.prog_linfo = prog_linfo;
>>  
>> -		if (json_output)
>> -			dump_xlated_json(&dd, buf, member_len, opcodes,
>> -					 linum);
>> +		if (json_output && visual)
>> +			jsonw_null(json_wtr);
> 
> Should this be an error? Maybe check that json_output is false when
> arguments are parsed and 'visual' is specified?

Right, makes sense to turn this into an error.
