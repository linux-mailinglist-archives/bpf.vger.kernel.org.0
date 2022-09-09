Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E695B41D2
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 23:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiIIVzg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 17:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiIIVzc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 17:55:32 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72124B4EAF
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 14:55:31 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id a12-20020a65604c000000b0042a8c1cc701so1557877pgp.1
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 14:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=HNlDT3gVvwBVOhKMXBW4B60Ol4ocuwIV/B0A7SzjlEY=;
        b=EznPSYGEM58GN+pzDJDqAN6tC9uN623n2fRsm1Stavs8XGoV00vrQksydPf4wOSEKa
         BUQmh/wM5lHT/CS3ronTnHa8DvenrE7+wSpeL2aG1OCkbtQxW6w4bO23WeiJ1nKfdeZl
         hai/s5o6+lrXJR4Cc84ktAL8xUKrIbze15KqdtrIFfoibOF0PmHh5id/3R2qX4GLbmIR
         dc8lGAnl8xV6k30g9AnYI3NbdgXMtFaXizt8Ap/TZ8SGwBeGoyF9FMvuWwSlWaJxaUo5
         SCyshhZmiC+JsQ5OLFnNmhMaCt13mVnU8QcTIeBpDJy+9Mzb2PffBURPlx0rwHOlgdLW
         B7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=HNlDT3gVvwBVOhKMXBW4B60Ol4ocuwIV/B0A7SzjlEY=;
        b=tlMFdFirFDRxUchjuC83AoNR8Cc2Jd+nKqsjHpbXy9T1JgCsm17vdPlQl31MgAQCj5
         WqwLM+04s6C9E4ZxMRI4DYfBKJKHKuFZbgIGTJsfjqYYF07s4by90Gx9rfw2Qm7q3zF+
         nmWmxAFcFaQb8+asU+OhYZXy8vWZzH4Z9PBEb6bMXgeE5TO5PMlTv5dd7kOeakc3z+cY
         RiBfcO3P5AKHhqqf8vMuPeadO/8ROy5sxKG+KC8M1sQ8QIGq59jWW85Q7fMndWqovF96
         t8c0MYWy4jrvOm3E/m7hjkJqDolfIr5HIOgqOwcz6mW0VWTPn9qAdTT8CvGUutav82Cc
         lOuw==
X-Gm-Message-State: ACgBeo3W5vtYXlIP5cch8PMs3QOce9orOtWJJ+pwVc542QMANBXVEH68
        HgnmB/BE0igKEjgg31GAkD5owDg=
X-Google-Smtp-Source: AA6agR6TDVIKIe1EOBn6X39KQH+CHhzOu+/ol1kmCYVWswVfrBPSBz4GHOtDIgN6BIK0AaYAw7eiv+Y=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:10a:b0:200:2849:235f with SMTP id
 p10-20020a17090b010a00b002002849235fmr20724pjz.1.1662760529942; Fri, 09 Sep
 2022 14:55:29 -0700 (PDT)
Date:   Fri, 9 Sep 2022 14:55:28 -0700
In-Reply-To: <20220908214104.3851807-2-namhyung@kernel.org>
Mime-Version: 1.0
References: <20220908214104.3851807-1-namhyung@kernel.org> <20220908214104.3851807-2-namhyung@kernel.org>
Message-ID: <Yxu2UCaofBIyrewX@google.com>
Subject: Re: [PATCH 2/3] perf/bpf: Always use perf callchains if exist
From:   sdf@google.com
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        bpf@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 09/08, Namhyung Kim wrote:
> If the perf_event has PERF_SAMPLE_CALLCHAIN, BPF can use it for stack  
> trace.
> The problematic cases like PEBS and IBS already handled in the PMU driver  
> and
> they filled the callchain info in the sample data.  For others, we can  
> call
> perf_callchain() before the BPF handler.

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Stanislav Fomichev <sdf@google.com>

At least from the description it make sense. We're filling a callchain
when it's been requested by the event, but it's missing on the
sample data (aka, software fallback?). perf_callchain also seems to
always fallback to &__empty_callchain in case of an error, so seems
safe.

> ---
>   kernel/bpf/stackmap.c |  4 ++--
>   kernel/events/core.c  | 12 ++++++++++--
>   2 files changed, 12 insertions(+), 4 deletions(-)

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 1adbe67cdb95..aecea7451b61 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -338,7 +338,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct  
> bpf_perf_event_data_kern *, ctx,
>   	int ret;

>   	/* perf_sample_data doesn't have callchain, use bpf_get_stackid */
> -	if (!(event->attr.sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY))
> +	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
>   		return bpf_get_stackid((unsigned long)(ctx->regs),
>   				       (unsigned long) map, flags, 0, 0);

> @@ -506,7 +506,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct  
> bpf_perf_event_data_kern *, ctx,
>   	int err = -EINVAL;
>   	__u64 nr_kernel;

> -	if (!(event->attr.sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY))
> +	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
>   		return __bpf_get_stack(regs, NULL, NULL, buf, size, flags);

>   	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index b8af9fdbf26f..2ea93ce75ad4 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10003,8 +10003,16 @@ static void bpf_overflow_handler(struct  
> perf_event *event,
>   		goto out;
>   	rcu_read_lock();
>   	prog = READ_ONCE(event->prog);
> -	if (prog)
> +	if (prog) {
> +		if (prog->call_get_stack &&
> +		    (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
> +		    !(data->sample_flags & PERF_SAMPLE_CALLCHAIN)) {
> +			data->callchain = perf_callchain(event, regs);
> +			data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
> +		}
> +
>   		ret = bpf_prog_run(prog, &ctx);
> +	}
>   	rcu_read_unlock();
>   out:
>   	__this_cpu_dec(bpf_prog_active);
> @@ -10030,7 +10038,7 @@ static int perf_event_set_bpf_handler(struct  
> perf_event *event,

>   	if (event->attr.precise_ip &&
>   	    prog->call_get_stack &&
> -	    (!(event->attr.sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY) ||
> +	    (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) ||
>   	     event->attr.exclude_callchain_kernel ||
>   	     event->attr.exclude_callchain_user)) {
>   		/*
> --
> 2.37.2.789.g6183377224-goog

