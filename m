Return-Path: <bpf+bounces-2621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BFB731524
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 12:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128361C20B92
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 10:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26405883B;
	Thu, 15 Jun 2023 10:23:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EBF8BEE
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 10:23:19 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB424212A;
	Thu, 15 Jun 2023 03:23:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f8cc04c287so16407175e9.0;
        Thu, 15 Jun 2023 03:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686824596; x=1689416596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8GW8J4zhmS4czfOBZRK/1qdOH2FHh5hYDGYYRmWxND4=;
        b=cMFTfUYW76Tsz2ukdjtgOsoZKTgu3dfdjUhR7jhWxBa4jfvwranVOvV6tEnsS4s4PQ
         7iozmkGipnwSjINOaQyeDNIuRYS5S/6X5yYEOV6RLM5j1M3hhnyGhNKJer7btdY9sPit
         y+scHZ6zvM6eg8W3+SnNYGrcHyu0sBwXWmonzCW/qOB73Y92VnMSyagmuABxag6CPFDA
         uU5gdfdgk1CwA0vmv2H2lwOfjJayj5fpU61ZY0N0oasxGeV9mL2ra5FpTu6XxOODk251
         dAfejLROzlZWZ609cR+qPz5k9ho5k8S+Fy4vVyf7LbLqQjGqW+xSNdxmwD///vHqupzt
         qClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686824596; x=1689416596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GW8J4zhmS4czfOBZRK/1qdOH2FHh5hYDGYYRmWxND4=;
        b=CTprF1jxI6hhy/A30DCfWHB/f2qt/DMVdMpJgV7tnVKgeYo5YoVPCWcDIXdVef1lC0
         zpixAwrupjLzh/NOEBZVQBthsapmS7z4qDsOwnuQDNH4bUx6pTjtaJ6ktFBasDA68oOC
         QD+NjKDLqM6YVBRpSGRqYdjFyAfx8XKub6Wv3eAPRoWIEiazy3qOQB1Jl2AUGqNHCovm
         qWdlsXJVfGFYNX27HsEhV51KqGShl3LXMv5VsWD1zHmQNdT+1Pmf5/7qtWQ4iVJGeIx1
         vFADxGtms36n5PiCCbF/n2SqiqORGHTHOvDv/kxukX9sCHIX+cDJfYhNukycLwtH226i
         oviQ==
X-Gm-Message-State: AC+VfDyExI8BA8VOu8NC7cvZyweVozSmo3n5rUspRc6BTlhHxpmTFfOv
	wkOg2L651D1G7RGDNIoML5E=
X-Google-Smtp-Source: ACHHUZ61CGrEJGC6vOzDeMAI5qRBiCNxq5myaSeL6DbnOYzdy4jKSCJdSzmdn3xmU+dAZNrJ+FeK1Q==
X-Received: by 2002:a05:600c:3786:b0:3f7:f45d:5e44 with SMTP id o6-20020a05600c378600b003f7f45d5e44mr12616501wmr.32.1686824595976;
        Thu, 15 Jun 2023 03:23:15 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id z14-20020a7bc7ce000000b003f50d6ee334sm20062857wmk.47.2023.06.15.03.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:23:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 15 Jun 2023 12:23:12 +0200
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	quentin@isovalent.com, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH v3 bpf-next 09/10] bpftool: Add perf event names
Message-ID: <ZIrmkBONOMdAH1PU@krava>
References: <20230612151608.99661-1-laoar.shao@gmail.com>
 <20230612151608.99661-10-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612151608.99661-10-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 12, 2023 at 03:16:07PM +0000, Yafang Shao wrote:
> Add new functions and macros to get perf event names. These names are
> copied from tool/perf/util/{parse-events,evsel}.c, so that in the future we
> will have a good chance to use the same code.
> 
> Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/bpf/bpftool/perf.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++
>  tools/bpf/bpftool/perf.h |  11 +++++
>  2 files changed, 118 insertions(+)
>  create mode 100644 tools/bpf/bpftool/perf.h
> 
> diff --git a/tools/bpf/bpftool/perf.c b/tools/bpf/bpftool/perf.c
> index 9174344..fbdf88c 100644
> --- a/tools/bpf/bpftool/perf.c
> +++ b/tools/bpf/bpftool/perf.c
> @@ -18,6 +18,113 @@
>  #include <bpf/bpf.h>
>  
>  #include "main.h"
> +#include "perf.h"
> +
> +static const char *perf_type_name[PERF_TYPE_MAX] = {
> +	[PERF_TYPE_HARDWARE]			= "hardware",
> +	[PERF_TYPE_SOFTWARE]			= "software",
> +	[PERF_TYPE_TRACEPOINT]			= "tracepoint",
> +	[PERF_TYPE_HW_CACHE]			= "hw-cache",
> +	[PERF_TYPE_RAW]				= "raw",
> +	[PERF_TYPE_BREAKPOINT]			= "breakpoint",
> +};
> +
> +const char *event_symbols_hw[PERF_COUNT_HW_MAX] = {
> +	[PERF_COUNT_HW_CPU_CYCLES]		= "cpu-cycles",
> +	[PERF_COUNT_HW_INSTRUCTIONS]		= "instructions",
> +	[PERF_COUNT_HW_CACHE_REFERENCES]	= "cache-references",
> +	[PERF_COUNT_HW_CACHE_MISSES]		= "cache-misses",
> +	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= "branch-instructions",
> +	[PERF_COUNT_HW_BRANCH_MISSES]		= "branch-misses",
> +	[PERF_COUNT_HW_BUS_CYCLES]		= "bus-cycles",
> +	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= "stalled-cycles-frontend",
> +	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= "stalled-cycles-backend",
> +	[PERF_COUNT_HW_REF_CPU_CYCLES]		= "ref-cycles",
> +};
> +
> +const char *event_symbols_sw[PERF_COUNT_SW_MAX] = {
> +	[PERF_COUNT_SW_CPU_CLOCK]		= "cpu-clock",
> +	[PERF_COUNT_SW_TASK_CLOCK]		= "task-clock",
> +	[PERF_COUNT_SW_PAGE_FAULTS]		= "page-faults",
> +	[PERF_COUNT_SW_CONTEXT_SWITCHES]	= "context-switches",
> +	[PERF_COUNT_SW_CPU_MIGRATIONS]		= "cpu-migrations",
> +	[PERF_COUNT_SW_PAGE_FAULTS_MIN]		= "minor-faults",
> +	[PERF_COUNT_SW_PAGE_FAULTS_MAJ]		= "major-faults",
> +	[PERF_COUNT_SW_ALIGNMENT_FAULTS]	= "alignment-faults",
> +	[PERF_COUNT_SW_EMULATION_FAULTS]	= "emulation-faults",
> +	[PERF_COUNT_SW_DUMMY]			= "dummy",
> +	[PERF_COUNT_SW_BPF_OUTPUT]		= "bpf-output",
> +	[PERF_COUNT_SW_CGROUP_SWITCHES]		= "cgroup-switches",
> +};
> +
> +const char *evsel__hw_cache[PERF_COUNT_HW_CACHE_MAX] = {
> +	[PERF_COUNT_HW_CACHE_L1D]		= "L1-dcache",
> +	[PERF_COUNT_HW_CACHE_L1I]		= "L1-icache",
> +	[PERF_COUNT_HW_CACHE_LL]		= "LLC",
> +	[PERF_COUNT_HW_CACHE_DTLB]		= "dTLB",
> +	[PERF_COUNT_HW_CACHE_ITLB]		= "iTLB",
> +	[PERF_COUNT_HW_CACHE_BPU]		= "branch",
> +	[PERF_COUNT_HW_CACHE_NODE]		= "node",
> +};
> +
> +const char *evsel__hw_cache_op[PERF_COUNT_HW_CACHE_OP_MAX] = {
> +	[PERF_COUNT_HW_CACHE_OP_READ]		= "load",
> +	[PERF_COUNT_HW_CACHE_OP_WRITE]		= "store",
> +	[PERF_COUNT_HW_CACHE_OP_PREFETCH]	= "prefetch",
> +};
> +
> +const char *evsel__hw_cache_result[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
> +	[PERF_COUNT_HW_CACHE_RESULT_ACCESS]	= "refs",
> +	[PERF_COUNT_HW_CACHE_RESULT_MISS]	= "misses",
> +};

names lok good to me, thanks

jirka

> +
> +const char *perf_type_str(enum perf_type_id t)
> +{
> +	if (t < 0 || t >= ARRAY_SIZE(perf_type_name))
> +		return NULL;
> +
> +	return perf_type_name[t];
> +}
> +
> +const char *perf_hw_str(enum perf_hw_id t)
> +{
> +	if (t < 0 || t >= ARRAY_SIZE(event_symbols_hw))
> +		return NULL;
> +
> +	return event_symbols_hw[t];
> +}
> +
> +const char *perf_hw_cache_str(enum perf_hw_cache_id t)
> +{
> +	if (t < 0 || t >= ARRAY_SIZE(evsel__hw_cache))
> +		return NULL;
> +
> +	return evsel__hw_cache[t];
> +}
> +
> +const char *perf_hw_cache_op_str(enum perf_hw_cache_op_id t)
> +{
> +	if (t < 0 || t >= ARRAY_SIZE(evsel__hw_cache_op))
> +		return NULL;
> +
> +	return evsel__hw_cache_op[t];
> +}
> +
> +const char *perf_hw_cache_op_result_str(enum perf_hw_cache_op_result_id t)
> +{
> +	if (t < 0 || t >= ARRAY_SIZE(evsel__hw_cache_result))
> +		return NULL;
> +
> +	return evsel__hw_cache_result[t];
> +}
> +
> +const char *perf_sw_str(enum perf_sw_ids t)
> +{
> +	if (t < 0 || t >= ARRAY_SIZE(event_symbols_sw))
> +		return NULL;
> +
> +	return event_symbols_sw[t];
> +}
>  
>  /* 0: undecided, 1: supported, 2: not supported */
>  static int perf_query_supported;
> diff --git a/tools/bpf/bpftool/perf.h b/tools/bpf/bpftool/perf.h
> new file mode 100644
> index 0000000..3fd7e42
> --- /dev/null
> +++ b/tools/bpf/bpftool/perf.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
> +
> +#include <linux/perf_event.h>
> +
> +const char *perf_type_str(enum perf_type_id t);
> +const char *perf_hw_str(enum perf_hw_id t);
> +const char *perf_hw_cache_str(enum perf_hw_cache_id t);
> +const char *perf_hw_cache_op_str(enum perf_hw_cache_op_id t);
> +const char *perf_hw_cache_op_result_str(enum perf_hw_cache_op_result_id t);
> +const char *perf_sw_str(enum perf_sw_ids t);
> -- 
> 1.8.3.1
> 

