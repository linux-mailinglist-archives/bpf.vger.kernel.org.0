Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDF85ECED2
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 22:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiI0Ul1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 16:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbiI0UlW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 16:41:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A2C100AA7;
        Tue, 27 Sep 2022 13:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664311278; x=1695847278;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DtZi3Sm9jkfhyr6ST6vhbGoeIvsdEwtVMuB6wMEC3Wo=;
  b=GCmxp7u4W/aLLYbZI3Wwmc+XsronW8zMl5cVbAQRIxp9sTOF18KtAgyf
   yn047EhxrWk4Ha19qAXmxyhZrkqzJeus1qgOcLabzrIDfgcAXSdXbTHDN
   /E+es42Y2PBRhgAgSLcYRDnJ0PfWWy5lq/LIOY5FFihTx2SDZ88I+fMCH
   VRcj/qTWHXsYAfPD2dpPmN3cCwvbShy1gpIeIxyFQC27Neg6n5IP5r+ew
   WC8ENCYCYJSL6Uo1Jn+dr68teSKkJLcRlzwb/0RUa/6BvFKkkswzJXiDR
   T0FHGPn1Y+lpirijTVq674Mn17P2iH7uDGsic5uC72r/wboAxwyHcJGgb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="301404897"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="301404897"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 13:41:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="616962254"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="616962254"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 27 Sep 2022 13:41:04 -0700
Received: from [10.252.215.51] (kliang2-mobl1.ccr.corp.intel.com [10.252.215.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8C3C4580BE9;
        Tue, 27 Sep 2022 13:41:03 -0700 (PDT)
Message-ID: <8af9bdd8-47d0-b9cd-57b4-0f92c8b2889a@linux.intel.com>
Date:   Tue, 27 Sep 2022 16:41:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH -tip] bpf: Check flags for branch stack in
 bpf_read_branch_records helper
To:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, Daniel Xu <dxu@dxuuu.xyz>
References: <20220927203259.590950-1-jolsa@kernel.org>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220927203259.590950-1-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022-09-27 4:32 p.m., Jiri Olsa wrote:
> Recent commit [1] changed branch stack data indication from
> br_stack pointer to sample_flags in perf_sample_data struct.
> 
> We need to check sample_flags for PERF_SAMPLE_BRANCH_STACK
> bit for valid branch stack data.
> 
> [1] a9a931e26668 ("perf: Use sample_flags for branch stack")
> 
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Fixes: a9a931e26668 ("perf: Use sample_flags for branch stack")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Thanks for the fix.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
> NOTE sending on top of tip/master because [1] is not
>      merged in bpf-next/master yet
> 
>  kernel/trace/bpf_trace.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 68e5cdd24cef..1fcd1234607e 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1507,6 +1507,9 @@ BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
>  	if (unlikely(flags & ~BPF_F_GET_BRANCH_RECORDS_SIZE))
>  		return -EINVAL;
>  
> +	if (unlikely(!(ctx->data->sample_flags & PERF_SAMPLE_BRANCH_STACK)))
> +		return -ENOENT;
> +
>  	if (unlikely(!br_stack))
>  		return -ENOENT;
>  
