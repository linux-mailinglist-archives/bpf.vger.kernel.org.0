Return-Path: <bpf+bounces-2505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB45772E461
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 15:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B971C20C48
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 13:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D9C34CF1;
	Tue, 13 Jun 2023 13:42:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98353522B
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 13:42:05 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9D21B2
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 06:42:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f7368126a6so41431315e9.0
        for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 06:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1686663720; x=1689255720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8DxCJ2fwsLy/Md+Keh8flwh6zngRGNz3N+LVOE3QUgQ=;
        b=JA7tXdwQAXHXYXid9W1Y1qo5F45DfRD/pxOHTq9rzUECNrCcHi9uEqlKLfHKHwnDvm
         yk0rOfSwieZxHkg5hD2+trbUnGT1hJ3Xf6rDoubjaW/4Z+jy9ZJgxEksPrHcIaimuFHE
         PWK2gCxcg+Ypz+Dh/6AAhMWIcrkVany2mNueS84VNkDe/NCfhFFErTeW+E8Jr4n2pRRF
         vuTUccRH3IynvjEiZM+im48A2dBwfVNgS+JL/+G96q4mcPpf+aNwRPfpcIYqiNhPl2wZ
         tEhXm+vYp+RiYWvdZ+4xozOlF0bghE3cf+Gbd7Hpjcv7fQBRZSmeG1Wp4kUHWCQ4Zokh
         L06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686663720; x=1689255720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DxCJ2fwsLy/Md+Keh8flwh6zngRGNz3N+LVOE3QUgQ=;
        b=Dy6vTyNy5+qHOHu9VSel4vKo6JiGV0yrtMfAGKdXwIOL8p+Pv4ELdhy/Ecx0QqIIPn
         /0N3WahJ1aRcqP9tXla4GB1xHzkaAV394gQVozOOBS1xZQf0liwPwaVbt1DlWPFWw+vC
         Bda4K1/Cviqztj1aqKeCsk740yOohJ9Ye/5KkRWqeECwaajKc0cITt4lMN4LWfcNA3pt
         bE+nE0vHfTtcp7wsuLwTHO328w68xTAGLOYF1pKQTy4HMX4hbz5B2PO/lESPw7tSXJds
         4ZBHOjzzc9LwRakcyPIAlmNu2TYwH2A6fagwFlOUkv7Jkq6goCQTWBhOXWCMJ/647IRg
         EVzg==
X-Gm-Message-State: AC+VfDyYbRAOn/+lXHmSTmNdTCRBO8hF/qFkPOBvE87nA/nQLoUJXKXb
	Gm9D4FfCe4NHdR8STU6rF2uYPg==
X-Google-Smtp-Source: ACHHUZ7et3/D4EUm2BGloQRFaop8ROOKNa81OLTycIpTn1A6sPu9MhgUQsziZM3QommB5nIMO/rwfg==
X-Received: by 2002:a05:600c:22cc:b0:3f8:153b:a521 with SMTP id 12-20020a05600c22cc00b003f8153ba521mr5282937wmg.26.1686663719928;
        Tue, 13 Jun 2023 06:41:59 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:a03e:3034:b6bf:fd8e? ([2a02:8011:e80c:0:a03e:3034:b6bf:fd8e])
        by smtp.gmail.com with ESMTPSA id u9-20020a05600c00c900b003f72468833esm14546741wmm.26.2023.06.13.06.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 06:41:59 -0700 (PDT)
Message-ID: <1cd688c3-f633-8ae7-97bb-8e899545118e@isovalent.com>
Date: Tue, 13 Jun 2023 14:41:58 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 bpf-next 09/10] bpftool: Add perf event names
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Jiri Olsa <olsajiri@gmail.com>
References: <20230612151608.99661-1-laoar.shao@gmail.com>
 <20230612151608.99661-10-laoar.shao@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230612151608.99661-10-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-06-12 15:16 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> Add new functions and macros to get perf event names. These names are
> copied from tool/perf/util/{parse-events,evsel}.c, so that in the future we
> will have a good chance to use the same code.
> 
> Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/bpf/bpftool/perf.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++
>  tools/bpf/bpftool/perf.h |  11 +++++

Although the names are deceiving, I think these should all be moved to
link.c and link.h, where we'll actually use them, or to some other file
with a new name. File perf.c is for implementing "bpftool perf ...".

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

I'm not sure we need all these API functions if we keep the arrays in
bpftool. I'd probably have just a generic one and pass it the name of
the relevant array in argument. Although I've got no objection with the
current form if it helps unifying the code with perf in the future.


