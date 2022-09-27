Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFAB5EC080
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 13:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiI0LGO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 07:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiI0LF1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 07:05:27 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DDB12A83;
        Tue, 27 Sep 2022 04:04:39 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id iv17so6279547wmb.4;
        Tue, 27 Sep 2022 04:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=Yhtyz+rc8DK2qRhHJpUkICfDmtLqhEc6gU4qVf/w8Ic=;
        b=jHhB848+Q7gFvCcSr/7i4K7B9085Urf4qKnCeUesvpgp5vQ4wK3JTSG8J83SnC1skP
         e9MlwBTM/I+rtn77JMVx6GYz85L0v1X8NvhN9sQcXN3XmPAwxhLIajfUoXVLv26LdAWl
         UYlUe7Csqio/WLE+xVCEJBuqrkTF3l6oYYsKhIWKDBYqPjnAf7YFglhR5H0hVMRWlGnE
         KBqv2jb9Kkd7UkMjIjS3sx9SeKwdrnOxTSy34oM8JQBCHI2sIvtoqLheqFHdYURKzuH+
         vrko5xVG/lRYtulR96tpfurGVCFtH7uFNlWe3KdwkQeRJBz0I9DNYqfyHaYfmWXP3qfM
         ZXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Yhtyz+rc8DK2qRhHJpUkICfDmtLqhEc6gU4qVf/w8Ic=;
        b=TP8ON003P5b3LCYLQ3X6V55YGv1JfHE/Fp8ztuydtyNzkgwHjc/9fqzu2xLJ0eu9Qk
         sLC0V8yyt7BtywlLqKl03Vv7GeBSukH/vjHm4+ZSam2VC+mY5Png714hIGaqWwVqxDlJ
         zZaiCmZ1deG+HgX3K/h7eT5jC2HZUIHOv7DtL4IYUxe1DFU7jgiIszIbFks17doqo5+9
         TNpeUtSCwfTqjYw4mB2UDa28xxEuPaAuozjggHLeZIsz+snERIlOH3Xu5itIuzSvvELr
         aM+48UqPM160Y+CE0XVgBsI7jStmJZ+CDdOt7Xutjnzj1K8VEUTF11Bl4Vny9Y1sdhc5
         ptDQ==
X-Gm-Message-State: ACrzQf1ZNgUUk6W6NG4IGae+JgHCgoy6wk/hMCD9zbpUpwdJIFNWtDcM
        0CTCPwv+joKppmOd++28YYc=
X-Google-Smtp-Source: AMsMyM7K+FDeiDo5S8m/iEPBgHoNcIyATpUEsjbOlsCFN9ImDbMaF8k8x42sblGzzkYtDIERKMzt3Q==
X-Received: by 2002:a05:600c:3d05:b0:3b4:9a42:10d0 with SMTP id bh5-20020a05600c3d0500b003b49a4210d0mr2241793wmb.135.1664276675796;
        Tue, 27 Sep 2022 04:04:35 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id q16-20020adfcd90000000b0022cbf4cda62sm1431872wrj.27.2022.09.27.04.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 04:04:35 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 27 Sep 2022 13:04:28 +0200
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        eranian@google.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        andreas.kogler.0x@gmail.com, atrajeev@linux.vnet.ibm.com,
        namhyung@kernel.org, ravi.bangoria@amd.com, bpf@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCH V2 3/6] perf: Use sample_flags for branch stack
Message-ID: <YzLYvELkvaTQesLD@krava>
References: <20220901130959.1285717-1-kan.liang@linux.intel.com>
 <20220901130959.1285717-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901130959.1285717-4-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 01, 2022 at 06:09:56AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Use the new sample_flags to indicate whether the branch stack is filled
> by the PMU driver.
> 
> Remove the br_stack from the perf_sample_data_init() to minimize the number
> of cache lines touched.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/powerpc/perf/core-book3s.c | 1 +
>  arch/x86/events/amd/core.c      | 4 +++-
>  arch/x86/events/core.c          | 4 +++-
>  arch/x86/events/intel/core.c    | 4 +++-
>  arch/x86/events/intel/ds.c      | 5 ++++-
>  include/linux/perf_event.h      | 4 ++--
>  kernel/events/core.c            | 4 ++--
>  7 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index 13919eb96931..1ad1efdb33f9 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -2297,6 +2297,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
>  			cpuhw = this_cpu_ptr(&cpu_hw_events);
>  			power_pmu_bhrb_read(event, cpuhw);
>  			data.br_stack = &cpuhw->bhrb_stack;
> +			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
>  		}
>  
>  		if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 9fbdfbcaf25a..8b70237c33f7 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -929,8 +929,10 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
>  		if (!x86_perf_event_set_period(event))
>  			continue;
>  
> -		if (has_branch_stack(event))
> +		if (has_branch_stack(event)) {
>  			data.br_stack = &cpuc->lbr_stack;
> +			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
> +		}
>  
>  		if (perf_event_overflow(event, &data, regs))
>  			x86_pmu_stop(event, 0);
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index c3d6d139a3c1..b30b8bbcd1e2 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1701,8 +1701,10 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
>  
>  		perf_sample_data_init(&data, 0, event->hw.last_period);
>  
> -		if (has_branch_stack(event))
> +		if (has_branch_stack(event)) {
>  			data.br_stack = &cpuc->lbr_stack;
> +			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
> +		}
>  
>  		if (perf_event_overflow(event, &data, regs))
>  			x86_pmu_stop(event, 0);
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 7c1e3d36bc65..b5c02627a155 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3017,8 +3017,10 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  
>  		perf_sample_data_init(&data, 0, event->hw.last_period);
>  
> -		if (has_branch_stack(event))
> +		if (has_branch_stack(event)) {
>  			data.br_stack = &cpuc->lbr_stack;
> +			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
> +		}
>  
>  		if (perf_event_overflow(event, &data, regs))
>  			x86_pmu_stop(event, 0);
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 01cbe26225c2..5dcfd2de6ef8 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1648,8 +1648,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
>  		data->sample_flags |= PERF_SAMPLE_TIME;
>  	}
>  
> -	if (has_branch_stack(event))
> +	if (has_branch_stack(event)) {
>  		data->br_stack = &cpuc->lbr_stack;
> +		data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
> +	}
>  }
>  
>  static void adaptive_pebs_save_regs(struct pt_regs *regs,
> @@ -1799,6 +1801,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
>  		if (has_branch_stack(event)) {
>  			intel_pmu_store_pebs_lbrs(lbr);
>  			data->br_stack = &cpuc->lbr_stack;
> +			data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
>  		}
>  	}
>  
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 0978165a2d87..1e12e79454e0 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1011,7 +1011,6 @@ struct perf_sample_data {
>  	u64				sample_flags;
>  	u64				addr;
>  	struct perf_raw_record		*raw;
> -	struct perf_branch_stack	*br_stack;
>  	u64				period;
>  	union perf_sample_weight	weight;
>  	u64				txn;
> @@ -1021,6 +1020,8 @@ struct perf_sample_data {
>  	 * The other fields, optionally {set,used} by
>  	 * perf_{prepare,output}_sample().
>  	 */
> +	struct perf_branch_stack	*br_stack;
> +
>  	u64				type;
>  	u64				ip;
>  	struct {
> @@ -1061,7 +1062,6 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
>  	data->sample_flags = 0;
>  	data->addr = addr;
>  	data->raw  = NULL;
> -	data->br_stack = NULL;

hi,
there's one more place, I'll send full patch for that

jirka


---
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b05f0310dbd3..98abc6ebb8ea 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1687,6 +1687,9 @@ BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
 	if (unlikely(flags & ~BPF_F_GET_BRANCH_RECORDS_SIZE))
 		return -EINVAL;
 
+	if (unlikely(!(ctx->data->sample_flags & PERF_SAMPLE_BRANCH_STACK)))
+		return -ENOENT;
+
 	if (unlikely(!br_stack))
 		return -ENOENT;
 
