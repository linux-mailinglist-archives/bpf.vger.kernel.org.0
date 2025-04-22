Return-Path: <bpf+bounces-56416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 584F8A96E4E
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 16:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C26D189AD31
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 14:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588212857F2;
	Tue, 22 Apr 2025 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eQBYO1ai"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481EA2857D8;
	Tue, 22 Apr 2025 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331903; cv=none; b=R7vbFHl5ZQTsW6SRidURo0j4ACEAPfr6aPRTRRusB3c1XrsTHQrWgEcEDrsS7S4Gm/w4Kd9andNCu7CADAsNX3HN6E6OQb14nhQRF1Bszjdsrc+70+YI1Fs5PB3eOupcXPlS42441xsyRgteuimnqTsoeqinZNwuK/F2tlSRk5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331903; c=relaxed/simple;
	bh=VLWL9iT1FoHtVBgA51yvlSPckY27Polw6StAFJ/RMXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cagOhPcFVqqwnwB4wu4dHv34+dE2fFEBPs/6baxvAiSxNTqGlTFAuvtgAALETBqBoQMa3TGATKkAN+1nk3OFOJH+3euSA0SgguSefzu1HTmyQsV4OB5C85j/VCfYuDCAHuqDdCms67vE/xiduWcCJ2p8pazTgaQLZ3fW1X4U/Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eQBYO1ai; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z2Y954V3Q5aJLR4hVrgeyT2X97uSAkp06ZXSuty2AG0=; b=eQBYO1aiZKRVyNL/De9i+KG+gT
	kamKA9nznKv1KTqyhl6zvRSPukeATo85MycrHjM/bbiTnPIFmX95cCWcubn8WuCwFuTHfDn5IL24X
	mb7N1cvSlaSMZttHtazhwvp1940r1BSaV1633Tz7vawc8btfN+H6cNFglItEYTcbKLTlNJYyr+Q2M
	fFvFiyGz0cw/bRV3JMbdEz7pW5S1C8PDItmDPDB/ITkkah2ylofptEZUfzRv/VPxRp/7/4R/AVGOZ
	u6uAg/IxTgFamT//T4JSyyXCWSwzRq82FkUCZoI0KgYcmrYqDgaBE/VSF9BXNaCEa7DqMerD89US7
	G3MC6C9Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u7EYH-0000000BF3O-1bBU;
	Tue, 22 Apr 2025 14:24:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CDDA83003C4; Tue, 22 Apr 2025 16:24:44 +0200 (CEST)
Date: Tue, 22 Apr 2025 16:24:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jianlin Lv <iecedge@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org, jianlv@ebay.com
Subject: Re: [RFC PATCH  bpf-next 2/2] Export irq_time_read for BPF module
 usage
Message-ID: <20250422142444.GB15651@noisy.programming.kicks-ass.net>
References: <cover.1745250534.git.iecedge@gmail.com>
 <75aef5f2b9d9292ae919f2af9f82a8618f9b191e.1745250534.git.iecedge@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75aef5f2b9d9292ae919f2af9f82a8618f9b191e.1745250534.git.iecedge@gmail.com>

On Tue, Apr 22, 2025 at 09:47:27PM +0800, Jianlin Lv wrote:
> From: Jianlin Lv <iecedge@gmail.com>
> 
> Move irq_time_read function to kernel/sched/core.c and export for
> external use when CONFIG_IRQ_TIME_ACCOUNTING is enabled.
> 
> Signed-off-by: Jianlin Lv <iecedge@gmail.com>
> ---
>  include/linux/sched.h |  4 ++++
>  kernel/sched/core.c   | 22 ++++++++++++++++++++++
>  kernel/sched/sched.h  | 19 -------------------
>  3 files changed, 26 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index f96ac1982893..3b83ac99b533 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2281,4 +2281,8 @@ static __always_inline void alloc_tag_restore(struct alloc_tag *tag, struct allo
>  #define alloc_tag_restore(_tag, _old)		do {} while (0)
>  #endif
>  
> +#ifdef CONFIG_IRQ_TIME_ACCOUNTING
> +extern inline u64 irq_time_read(int cpu);
> +#endif
> +
>  #endif
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index cfaca3040b2f..c840d1ffdaca 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10747,3 +10747,25 @@ void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx)
>  		set_next_task(rq, ctx->p);
>  }
>  #endif	/* CONFIG_SCHED_CLASS_EXT */
> +
> +#ifdef CONFIG_IRQ_TIME_ACCOUNTING
> +/*
> + * Returns the irqtime minus the softirq time computed by ksoftirqd.
> + * Otherwise ksoftirqd's sum_exec_runtime is subtracted its own runtime
> + * and never move forward.
> + */
> +inline u64 irq_time_read(int cpu)
> +{
> +	struct irqtime *irqtime = &per_cpu(cpu_irqtime, cpu);
> +	unsigned int seq;
> +	u64 total;
> +
> +	do {
> +		seq = __u64_stats_fetch_begin(&irqtime->sync);
> +		total = irqtime->total;
> +	} while (__u64_stats_fetch_retry(&irqtime->sync, seq));
> +
> +	return total;
> +}
> +EXPORT_SYMBOL(irq_time_read);

_GPL(), but as I've argued in the earlier email, I don't think you want
this. I think you want access to clock_task instead.

