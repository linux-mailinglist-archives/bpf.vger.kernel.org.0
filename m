Return-Path: <bpf+bounces-15833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BF97F88A1
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 07:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739AF2815A3
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 06:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DE723B0;
	Sat, 25 Nov 2023 06:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hR1VHQh+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683601B6
	for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 22:36:18 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6bd5730bef9so2407133b3a.1
        for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 22:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700894178; x=1701498978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHiMIvLDO2ZbTxHRaxuFBOG4CVORHQwJmWn9Lh3DRLs=;
        b=hR1VHQh+B4bHUwzPilr4XxlN1jPBOpi/tShwGHkhRZNu5q4086Mc5pJ7wKyv2ldl7v
         SBNmriM4yynuxrr1rmUOk/nbK6oVb/u7TqVHOt+umPopvmm9o7n+PChBZx9LGE9EVPRR
         8XmnckfqHBT2QCVk0CKNHoQXrMjOOhNTR67/hWs9wB49/wlMaAhaHqD5i8jsy9yTY044
         rsJRazZpjy6H4tLpyAGRbqzwp7XWOH2rqnAwpFP7bt/wdjMJ67c5f1lvVfeY+MhMdAN1
         J5U75TwJWJl9wgZKxKFu8x7ptUz3+Y+TN0vw9jh+lC/dh6jVTtN1AyrBjazQIe/v0sTe
         n9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700894178; x=1701498978;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHiMIvLDO2ZbTxHRaxuFBOG4CVORHQwJmWn9Lh3DRLs=;
        b=KCl+5keSHJ5sngfV6YkWmHPUiFe/KWUntZdLFfew+ju1ng7i6qI9GQ2TK9kjreiYSX
         NnHg/EEvtB7Z/laBy8X/PonIaP2aK9mB94e6+6WcHKdv2YHe82VxlQM6COyzonAXf325
         NOmLQMikV8WjoJc9+t5JfNKO7u8VHSyHL6c3altAPWagRcYpN5qm7owFnXxw5oT1lJ9o
         cCMcM09caBqV/J5B0RretzY5ylwy4WwViE2mKaRfHNrY+zbvBfQ9FGMTsLnbmzIr1Lqh
         9xrRK7hSYC8uK0tb2ZS3URvOLuTNfVEBqGa7pQDBo8TPKLII6KBfbk4mFNAMVUGtdBIw
         AWCw==
X-Gm-Message-State: AOJu0Yxa2MiSyb3Z4WlJTvb3sSRG1TZSZmJ3uw0bKbRbZ8mV1K0oJeON
	5UWg8txKxHOsPUmQqPleRX1+S0vgxXLlwA==
X-Google-Smtp-Source: AGHT+IFEMYx3CqBGnCWlwYY4bVdXcUnsPkqsCWtL/TYoIO2IX3aE391QWTtWkOI6qF6uKFt1r3x4l95P4Fjhsw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:6a00:8911:b0:68e:3053:14b9 with SMTP
 id hw17-20020a056a00891100b0068e305314b9mr1864932pfb.2.1700894177861; Fri, 24
 Nov 2023 22:36:17 -0800 (PST)
Date: Sat, 25 Nov 2023 06:36:16 +0000
In-Reply-To: <20231123193937.11628-3-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231123193937.11628-1-ddrokosov@salutedevices.com> <20231123193937.11628-3-ddrokosov@salutedevices.com>
Message-ID: <20231125063616.dex3kh3ea43ceyu3@google.com>
Subject: Re: [PATCH v3 2/2] mm: memcg: introduce new event to trace shrink_memcg
From: Shakeel Butt <shakeelb@google.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	mhocko@suse.com, akpm@linux-foundation.org, kernel@sberdevices.ru, 
	rockosov@gmail.com, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 23, 2023 at 10:39:37PM +0300, Dmitry Rokosov wrote:
> The shrink_memcg flow plays a crucial role in memcg reclamation.
> Currently, it is not possible to trace this point from non-direct
> reclaim paths. However, direct reclaim has its own tracepoint, so there
> is no issue there. In certain cases, when debugging memcg pressure,
> developers may need to identify all potential requests for memcg
> reclamation including kswapd(). The patchset introduces the tracepoints
> mm_vmscan_memcg_shrink_{begin|end}() to address this problem.
> 
> Example of output in the kswapd context (non-direct reclaim):
>     kswapd0-39      [001] .....   240.356378: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356396: mm_vmscan_memcg_shrink_end: nr_reclaimed=0 memcg=16
>     kswapd0-39      [001] .....   240.356420: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356454: mm_vmscan_memcg_shrink_end: nr_reclaimed=1 memcg=16
>     kswapd0-39      [001] .....   240.356479: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356506: mm_vmscan_memcg_shrink_end: nr_reclaimed=4 memcg=16
>     kswapd0-39      [001] .....   240.356525: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356593: mm_vmscan_memcg_shrink_end: nr_reclaimed=11 memcg=16
>     kswapd0-39      [001] .....   240.356614: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356738: mm_vmscan_memcg_shrink_end: nr_reclaimed=25 memcg=16
>     kswapd0-39      [001] .....   240.356790: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.357125: mm_vmscan_memcg_shrink_end: nr_reclaimed=53 memcg=16
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  include/trace/events/vmscan.h | 22 ++++++++++++++++++++++
>  mm/vmscan.c                   |  7 +++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index e9093fa1c924..a4686afe571d 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -180,6 +180,17 @@ DEFINE_EVENT(mm_vmscan_memcg_reclaim_begin_template, mm_vmscan_memcg_softlimit_r
>  	TP_ARGS(order, gfp_flags, memcg)
>  );
>  
> +DEFINE_EVENT(mm_vmscan_memcg_reclaim_begin_template, mm_vmscan_memcg_shrink_begin,
> +
> +	TP_PROTO(int order, gfp_t gfp_flags, const struct mem_cgroup *memcg),
> +
> +	TP_ARGS(order, gfp_flags, memcg)
> +);
> +
> +#else
> +
> +#define trace_mm_vmscan_memcg_shrink_begin(...)
> +
>  #endif /* CONFIG_MEMCG */
>  
>  DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_end_template,
> @@ -243,6 +254,17 @@ DEFINE_EVENT(mm_vmscan_memcg_reclaim_end_template, mm_vmscan_memcg_softlimit_rec
>  	TP_ARGS(nr_reclaimed, memcg)
>  );
>  
> +DEFINE_EVENT(mm_vmscan_memcg_reclaim_end_template, mm_vmscan_memcg_shrink_end,
> +
> +	TP_PROTO(unsigned long nr_reclaimed, const struct mem_cgroup *memcg),
> +
> +	TP_ARGS(nr_reclaimed, memcg)
> +);
> +
> +#else
> +
> +#define trace_mm_vmscan_memcg_shrink_end(...)
> +
>  #endif /* CONFIG_MEMCG */
>  
>  TRACE_EVENT(mm_shrink_slab_start,
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 45780952f4b5..f7e3ddc5a7ad 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6461,6 +6461,10 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  		 */
>  		cond_resched();
>  
> +		trace_mm_vmscan_memcg_shrink_begin(sc->order,
> +						   sc->gfp_mask,
> +						   memcg);
> +

If you place the start of the trace here, you may have only the begin
trace for memcgs whose usage are below their min or low limits. Is that
fine? Otherwise you can put it just before shrink_lruvec() call.

>  		mem_cgroup_calculate_protection(target_memcg, memcg);
>  
>  		if (mem_cgroup_below_min(target_memcg, memcg)) {
> @@ -6491,6 +6495,9 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
>  			    sc->priority);
>  
> +		trace_mm_vmscan_memcg_shrink_end(sc->nr_reclaimed - reclaimed,
> +						 memcg);
> +
>  		/* Record the group's reclaim efficiency */
>  		if (!sc->proactive)
>  			vmpressure(sc->gfp_mask, memcg, false,
> -- 
> 2.36.0
> 

