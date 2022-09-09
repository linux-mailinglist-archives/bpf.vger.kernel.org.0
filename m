Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE05C5B37FD
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 14:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiIIMiA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 08:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIIMh7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 08:37:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C157C36DD8;
        Fri,  9 Sep 2022 05:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662727078; x=1694263078;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mo99IpYm1AvzncHba+O/i3dk/CKKv38nddBho+Fzb6Y=;
  b=hLdYq4ClIxika3o6y653o4u858fTa8ViclQGvB7MSUhQUjjEwYdQBmic
   zSojbK4c0fr4/4/BjA/qyLyQfTEDgSt8DeFvGL+zpdocNdVt4ZZY9XdJ+
   CTMycAjIM0oMmcrGU72Pv+2QsN5KZZB9BZ6JtClifw8kq6LEpBEOQKH1d
   rn/KuVsdFSflHY47md7rq0skrfAs4NxOqgRmNOA8yKeMT5Qt+sOO2SrA0
   g0wH+jZpbVeH/NcJpP/doA5mQkqYfJt6MjWEbXDHZzs+Y30Vp0ySV+Eb6
   tqVGokVuvrX9+uIUyIpa92C3MvaW4vWXkMxFm/ISNx1OQChOVVu7CvP/0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="284482523"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="284482523"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 05:37:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="683625990"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 09 Sep 2022 05:37:57 -0700
Received: from [10.252.209.107] (kliang2-mobl1.ccr.corp.intel.com [10.252.209.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id CA530580692;
        Fri,  9 Sep 2022 05:37:54 -0700 (PDT)
Message-ID: <842164ce-b754-b727-c976-39d05c34ddf3@linux.intel.com>
Date:   Fri, 9 Sep 2022 08:37:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 1/3] perf: Use sample_flags for callchain
To:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220908214104.3851807-1-namhyung@kernel.org>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220908214104.3851807-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022-09-08 5:41 p.m., Namhyung Kim wrote:
> So that it can call perf_callchain() only if needed.  Historically it used
> __PERF_SAMPLE_CALLCHAIN_EARLY but we can do that with sample_flags in the
> struct perf_sample_data.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

The series look good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  arch/x86/events/amd/ibs.c  | 4 +++-
>  arch/x86/events/intel/ds.c | 8 ++++++--
>  kernel/events/core.c       | 2 +-
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index c251bc44c088..dab094166693 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -798,8 +798,10 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>  	 * recorded as part of interrupt regs. Thus we need to use rip from
>  	 * interrupt regs while unwinding call stack.
>  	 */
> -	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
> +	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
>  		data.callchain = perf_callchain(event, iregs);
> +		data.sample_flags |= PERF_SAMPLE_CALLCHAIN;
> +	}
>  
>  	throttle = perf_event_overflow(event, &data, &regs);
>  out:
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index a5275c235c2a..4ba6ab6d0d92 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1546,8 +1546,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
>  	 * previous PMI context or an (I)RET happened between the record and
>  	 * PMI.
>  	 */
> -	if (sample_type & PERF_SAMPLE_CALLCHAIN)
> +	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
>  		data->callchain = perf_callchain(event, iregs);
> +		data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
> +	}
>  
>  	/*
>  	 * We use the interrupt regs as a base because the PEBS record does not
> @@ -1719,8 +1721,10 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
>  	 * previous PMI context or an (I)RET happened between the record and
>  	 * PMI.
>  	 */
> -	if (sample_type & PERF_SAMPLE_CALLCHAIN)
> +	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
>  		data->callchain = perf_callchain(event, iregs);
> +		data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
> +	}
>  
>  	*regs = *iregs;
>  	/* The ip in basic is EventingIP */
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 15d27b14c827..b8af9fdbf26f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7323,7 +7323,7 @@ void perf_prepare_sample(struct perf_event_header *header,
>  	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
>  		int size = 1;
>  
> -		if (!(sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY))
> +		if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
>  			data->callchain = perf_callchain(event, regs);
>  
>  		size += data->callchain->nr;
