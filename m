Return-Path: <bpf+bounces-2342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4BF72AF91
	for <lists+bpf@lfdr.de>; Sun, 11 Jun 2023 00:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39C31C20A2D
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 22:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163792107B;
	Sat, 10 Jun 2023 22:44:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E6290B
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 22:44:00 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B018B35A9
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 15:43:58 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30b023b0068so2205320f8f.0
        for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 15:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686437037; x=1689029037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MtEQ+zmjlo+PxvRvqQ9oWAo06mAjcFCkwDy89f5uVLw=;
        b=MN8j1OHClgJveOJBJalo315tN57IxkrgmuSfnwrTJoxeMXZybTFRR0daYWDRTMhaYQ
         Z3ujg5V4Cslq3VeIg14OBQAqn6Kj0//gM6UYH7IpnKJiiK5lcvzJ4m3luYBPANdcpe8k
         D/6fR9KykWrUdaprqDWWl19UEXZy8qR2ipZwm5V9ZEevf5+svcwfLmvlN0XaRJ6hPi+k
         vor9XLC2dRzO+wS1tHeEaJa1ZuYu3O4cQV4D+Uv/yt7FaaQnO74ojjpz1/6I9ZeIpByk
         7gS3p3condoHjmKzXYge3QayezV39VVoQfaQuNUBR33j2r1eJaPRPm1zuoxZntNcKhQK
         4qFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686437037; x=1689029037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtEQ+zmjlo+PxvRvqQ9oWAo06mAjcFCkwDy89f5uVLw=;
        b=Atcg/40oDksEX/RIPktdwglytVx/cGR+HQNsRldaxf0eUEX5O/N4Fy2yGjaeCzpFmu
         BpDsz810SK2LAp7akJ7k5zS4r7X+jpedbOVOExKL9cNCyj3YLApRhW/3kdD8iEuxdLw4
         iD5oGXzz+wovkbcR8hELcXmdw4JL4gs6wI7IQE7N2sTcXtMZytEsrd8gk7Wf0j+r8hbp
         DdODvU50KwRc8dh7rTpC1FEnIRxBfsTFWx3RNez0+NUmurAsmr5ayZbo4SB0KUlbBZx7
         dKNcHrKCw2kKyHtZ8cA6P8j1lSVFOvPhAcvejGrwc5kApnaEmDxMF2LXFuGjcF0yrTzJ
         jaqw==
X-Gm-Message-State: AC+VfDzS2v8yep+T5KBzG/mnkWdxbu2tjsTJ+32yK7QvnsZRKOIu+NS7
	Upfhgy+IKxtbrnOvNQPpskY=
X-Google-Smtp-Source: ACHHUZ5uns+YRe0Zxb8/9phDKaP7hPJo1rF8+Ya96L5B09Te1MnrlBChIOzoWAn3nGCaHPj1htkNRA==
X-Received: by 2002:a5d:42cd:0:b0:30f:bd17:4f07 with SMTP id t13-20020a5d42cd000000b0030fbd174f07mr30342wrr.13.1686437036804;
        Sat, 10 Jun 2023 15:43:56 -0700 (PDT)
Received: from krava ([213.235.133.42])
        by smtp.gmail.com with ESMTPSA id z6-20020a5d4d06000000b0030fb98484f6sm1138284wrt.114.2023.06.10.15.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 15:43:56 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 11 Jun 2023 00:43:53 +0200
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, quentin@isovalent.com, bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH v2 bpf-next 09/11] libbpf: Add perf event names
Message-ID: <ZIT8qWzkl6P2wXmq@krava>
References: <20230608103523.102267-1-laoar.shao@gmail.com>
 <20230608103523.102267-10-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608103523.102267-10-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 08, 2023 at 10:35:21AM +0000, Yafang Shao wrote:
> Add libbpf API to get generic perf event name.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c   | 107 +++++++++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   |  56 +++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.map |   6 +++
>  3 files changed, 169 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 47632606..27d396f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -119,6 +119,64 @@
>  	[BPF_STRUCT_OPS]		= "struct_ops",
>  };
>  
> +static const char * const perf_type_name[] = {
> +	[PERF_TYPE_HARDWARE]		= "hardware",
> +	[PERF_TYPE_SOFTWARE]		= "software",
> +	[PERF_TYPE_TRACEPOINT]		= "tracepoint",
> +	[PERF_TYPE_HW_CACHE]		= "hw_cache",
> +	[PERF_TYPE_RAW]			= "raw",
> +	[PERF_TYPE_BREAKPOINT]		= "breakpoint",
> +};
> +
> +static const char * const perf_hw_name[] = {
> +	[PERF_COUNT_HW_CPU_CYCLES]		= "cpu_cycles",

could you use '-' instead of '_' because that's what we do in perf

actually would be great if you could use same names like in
  tool/perf/util/parse-events.c  'event_symbols_*' arrays
  tool/perf/util/evsel.c         'evsel__hw_cache' array

so perf and bpftool would use same names and we have a chance
to use same code for that in future

jirka

> +	[PERF_COUNT_HW_INSTRUCTIONS]		= "instructions",
> +	[PERF_COUNT_HW_CACHE_REFERENCES]	= "cache_references",
> +	[PERF_COUNT_HW_CACHE_MISSES]		= "cache_misses",
> +	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= "branch_instructions",
> +	[PERF_COUNT_HW_BRANCH_MISSES]		= "branch_misses",
> +	[PERF_COUNT_HW_BUS_CYCLES]		= "bus_cycles",
> +	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= "stalled_cycles_frontend",
> +	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= "stalled_cycles_backend",
> +	[PERF_COUNT_HW_REF_CPU_CYCLES]		= "ref_cpu_cycles",
> +};
> +
> +static const char * const perf_hw_cache_name[] = {
> +	[PERF_COUNT_HW_CACHE_L1D]		= "l1d",
> +	[PERF_COUNT_HW_CACHE_L1I]		= "l1i",
> +	[PERF_COUNT_HW_CACHE_LL]		= "ll",
> +	[PERF_COUNT_HW_CACHE_DTLB]		= "dtlb",
> +	[PERF_COUNT_HW_CACHE_ITLB]		= "itlb",
> +	[PERF_COUNT_HW_CACHE_BPU]		= "bpu",
> +	[PERF_COUNT_HW_CACHE_NODE]		= "node",
> +};
> +
> +static const char * const perf_hw_cache_op_name[] = {
> +	[PERF_COUNT_HW_CACHE_OP_READ]		= "read",
> +	[PERF_COUNT_HW_CACHE_OP_WRITE]		= "write",
> +	[PERF_COUNT_HW_CACHE_OP_PREFETCH]	= "prefetch",
> +};
> +
> +static const char * const perf_hw_cache_op_result_name[] = {
> +	[PERF_COUNT_HW_CACHE_RESULT_ACCESS]	= "access",
> +	[PERF_COUNT_HW_CACHE_RESULT_MISS]	= "miss",
> +};
> +
> +static const char * const perf_sw_name[] = {
> +	[PERF_COUNT_SW_CPU_CLOCK]		= "cpu_clock",
> +	[PERF_COUNT_SW_TASK_CLOCK]		= "task_clock",
> +	[PERF_COUNT_SW_PAGE_FAULTS]		= "page_faults",
> +	[PERF_COUNT_SW_CONTEXT_SWITCHES]	= "context_switches",
> +	[PERF_COUNT_SW_CPU_MIGRATIONS]		= "cpu_migrations",
> +	[PERF_COUNT_SW_PAGE_FAULTS_MIN]		= "page_faults_min",
> +	[PERF_COUNT_SW_PAGE_FAULTS_MAJ]		= "page_faults_maj",
> +	[PERF_COUNT_SW_ALIGNMENT_FAULTS]	= "alignment_faults",
> +	[PERF_COUNT_SW_EMULATION_FAULTS]	= "emulation_faults",
> +	[PERF_COUNT_SW_DUMMY]			= "dummy",
> +	[PERF_COUNT_SW_BPF_OUTPUT]		= "bpf_output",
> +	[PERF_COUNT_SW_CGROUP_SWITCHES]		= "cgroup_switches",
> +};
> +
>  static const char * const link_type_name[] = {
>  	[BPF_LINK_TYPE_UNSPEC]			= "unspec",
>  	[BPF_LINK_TYPE_RAW_TRACEPOINT]		= "raw_tracepoint",
> @@ -8953,6 +9011,55 @@ const char *libbpf_bpf_attach_type_str(enum bpf_attach_type t)
>  	return attach_type_name[t];
>  }
>  
> +const char *libbpf_perf_type_str(enum perf_type_id t)
> +{
> +	if (t < 0 || t >= ARRAY_SIZE(perf_type_name))
> +		return NULL;
> +
> +	return perf_type_name[t];
> +}
> +
> +const char *libbpf_perf_hw_str(enum perf_hw_id t)
> +{
> +	if (t < 0 || t >= ARRAY_SIZE(perf_hw_name))
> +		return NULL;
> +
> +	return perf_hw_name[t];
> +}
> +
> +const char *libbpf_perf_hw_cache_str(enum perf_hw_cache_id t)
> +{
> +	if (t < 0 || t >= ARRAY_SIZE(perf_hw_cache_name))
> +		return NULL;
> +
> +	return perf_hw_cache_name[t];
> +}
> +
> +const char *libbpf_perf_hw_cache_op_str(enum perf_hw_cache_op_id t)
> +{
> +	if (t < 0 || t >= ARRAY_SIZE(perf_hw_cache_op_name))
> +		return NULL;
> +
> +	return perf_hw_cache_op_name[t];
> +}
> +
> +const char *
> +libbpf_perf_hw_cache_op_result_str(enum perf_hw_cache_op_result_id t)
> +{
> +	if (t < 0 || t >= ARRAY_SIZE(perf_hw_cache_op_result_name))
> +		return NULL;
> +
> +	return perf_hw_cache_op_result_name[t];
> +}
> +
> +const char *libbpf_perf_sw_str(enum perf_sw_ids t)
> +{
> +	if (t < 0 || t >= ARRAY_SIZE(perf_sw_name))
> +		return NULL;
> +
> +	return perf_sw_name[t];
> +}
> +
>  const char *libbpf_bpf_link_type_str(enum bpf_link_type t)
>  {
>  	if (t < 0 || t >= ARRAY_SIZE(link_type_name))
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 754da73..4123e4c 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -16,6 +16,7 @@
>  #include <stdbool.h>
>  #include <sys/types.h>  // for size_t
>  #include <linux/bpf.h>
> +#include <linux/perf_event.h>
>  
>  #include "libbpf_common.h"
>  #include "libbpf_legacy.h"
> @@ -61,6 +62,61 @@ enum libbpf_errno {
>  LIBBPF_API const char *libbpf_bpf_attach_type_str(enum bpf_attach_type t);
>  
>  /**
> + * @brief **libbpf_perf_type_str()** converts the provided perf type value
> + * into a textual representation.
> + * @param t The perf type.
> + * @return Pointer to a static string identifying the perf type. NULL is
> + * returned for unknown **perf_type_id** values.
> + */
> +LIBBPF_API const char *libbpf_perf_type_str(enum perf_type_id t);
> +
> +/**
> + * @brief **libbpf_perf_hw_str()** converts the provided perf hw id
> + * into a textual representation.
> + * @param t The perf hw id.
> + * @return Pointer to a static string identifying the perf hw id. NULL is
> + * returned for unknown **perf_hw_id** values.
> + */
> +LIBBPF_API const char *libbpf_perf_hw_str(enum perf_hw_id t);
> +
> +/**
> + * @brief **libbpf_perf_hw_cache_str()** converts the provided perf hw cache
> + * id into a textual representation.
> + * @param t The perf hw cache id.
> + * @return Pointer to a static string identifying the perf hw cache id.
> + * NULL is returned for unknown **perf_hw_cache_id** values.
> + */
> +LIBBPF_API const char *libbpf_perf_hw_cache_str(enum perf_hw_cache_id t);
> +
> +/**
> + * @brief **libbpf_perf_hw_cache_op_str()** converts the provided perf hw
> + * cache op id into a textual representation.
> + * @param t The perf hw cache op id.
> + * @return Pointer to a static string identifying the perf hw cache op id.
> + * NULL is returned for unknown **perf_hw_cache_op_id** values.
> + */
> +LIBBPF_API const char *libbpf_perf_hw_cache_op_str(enum perf_hw_cache_op_id t);
> +
> +/**
> + * @brief **libbpf_perf_hw_cache_op_result_str()** converts the provided
> + * perf hw cache op result id into a textual representation.
> + * @param t The perf hw cache op result id.
> + * @return Pointer to a static string identifying the perf hw cache op result
> + * id. NULL is returned for unknown **perf_hw_cache_op_result_id** values.
> + */
> +LIBBPF_API const char *
> +libbpf_perf_hw_cache_op_result_str(enum perf_hw_cache_op_result_id t);
> +
> +/**
> + * @brief **libbpf_perf_sw_str()** converts the provided perf sw id
> + * into a textual representation.
> + * @param t The perf sw id.
> + * @return Pointer to a static string identifying the perf sw id. NULL is
> + * returned for unknown **perf_sw_ids** values.
> + */
> +LIBBPF_API const char *libbpf_perf_sw_str(enum perf_sw_ids t);
> +
> +/**
>   * @brief **libbpf_bpf_link_type_str()** converts the provided link type value
>   * into a textual representation.
>   * @param t The link type.
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 7521a2f..6ae0a36 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -395,4 +395,10 @@ LIBBPF_1.2.0 {
>  LIBBPF_1.3.0 {
>  	global:
>  		bpf_obj_pin_opts;
> +		libbpf_perf_hw_cache_op_result_str;
> +		libbpf_perf_hw_cache_op_str;
> +		libbpf_perf_hw_cache_str;
> +		libbpf_perf_hw_str;
> +		libbpf_perf_sw_str;
> +		libbpf_perf_type_str;
>  } LIBBPF_1.2.0;
> -- 
> 1.8.3.1
> 

