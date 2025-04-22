Return-Path: <bpf+bounces-56415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B5CA96E49
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 16:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19220170C65
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 14:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87932857DE;
	Tue, 22 Apr 2025 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SWx9Js0e"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE0C2857C9;
	Tue, 22 Apr 2025 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331852; cv=none; b=IR9WYVjuZzAfbEeOxDwU8HYv6fZ1mZo2iTFeQ8O3TZhTLGwH8nNy22smYB1T+v28g+4LsEp6g3nK2udrdaGJf90J5D5a6k7Lhi0zY7IT/JhBSsiW6/iwExeeghdpbGBMUY4DkglbY+FbQ+J3ux+KCPqMhkPlt7suLWAQcaY5kc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331852; c=relaxed/simple;
	bh=reo5IMM3ELzJnULKt75xetc9jZ40Wz4pm7F/MDP3LiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjmnVbcvoKEBkgeMdVcg1brR/cpPTK5ttAOBYH+q7Y/xiEP0xIaWHocYRyzdqWfUHJUOpE6IOlsRRIvyKR0L70/fK2f3ISjInPeDH073YDQoBmwoGzw+a+jYMHTX0AZPIRoXNL6xuhh0yo/TPyJT0pcumODKKhcldlN0UlVo9PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SWx9Js0e; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xBPEswy0hkFKnSjr4quZYPj2iAWCq2IbEgnPyK1Uy7U=; b=SWx9Js0eS/GLgqz5Mc1kqoYS9+
	iywXjWZ6HaJnvx4W7jmQg4LAJk4FJkWmq85AFrjc+MR5geL4m1o4eujNv4AF/AfggPS3Y87ANS95K
	1KfalfxdmfkzGq4FSbYJqTT6zIC1eHnlDQjlxeLsladdu9F1haZGXdVPuU2crf+QxU3UT9s+Og46o
	xPxO7FnDNJUBqCOcTuzyzUfkWAyBB4wFRYmgxlUZU+mHovZKaHm9OHZlC6PcA5A0x+BLcJTAC7ci4
	R+NL8a+B8XSYDVNxjfWdXlC8YXqHAnW7M3wBgp0MRtsGrNbBBkjofygnoYRjAtfjMBAGhwEqEBCq2
	au/G9NGQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7EXR-00000004ibw-38Mp;
	Tue, 22 Apr 2025 14:23:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2B06B30057E; Tue, 22 Apr 2025 16:23:53 +0200 (CEST)
Date: Tue, 22 Apr 2025 16:23:52 +0200
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
Subject: Re: [RFC PATCH  bpf-next 1/2] Enhance BPF execution timing by
 excluding IRQ time
Message-ID: <20250422142352.GA15651@noisy.programming.kicks-ass.net>
References: <cover.1745250534.git.iecedge@gmail.com>
 <73fdbbf9aafd3e24e12bb58f89c70959fb3a37f1.1745250534.git.iecedge@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73fdbbf9aafd3e24e12bb58f89c70959fb3a37f1.1745250534.git.iecedge@gmail.com>

On Tue, Apr 22, 2025 at 09:47:26PM +0800, Jianlin Lv wrote:
> From: Jianlin Lv <iecedge@gmail.com>
> 
> This commit excludes IRQ time from the total execution duration of BPF
> programs. When CONFIG_IRQ_TIME_ACCOUNTING is enabled, IRQ time is
> accounted for separately, offering a more accurate assessment of CPU
> usage for BPF programs.
> 
> Signed-off-by: Jianlin Lv <iecedge@gmail.com>
> ---
>  include/linux/filter.h | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index f5cf4d35d83e..3e0f975176a6 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -703,12 +703,32 @@ static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
>  	cant_migrate();
>  	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
>  		struct bpf_prog_stats *stats;
> -		u64 duration, start = sched_clock();
> +		u64 duration, start, start_time, end_time, irq_delta;
>  		unsigned long flags;
> +		unsigned int cpu;
>  
> -		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
> +		#ifdef CONFIG_IRQ_TIME_ACCOUNTING
> +		if (in_task()) {
> +			cpu = get_cpu();
> +			put_cpu();
> +			start_time = irq_time_read(cpu);

This is all sorts of daft.. you don't need get_cpu()/put_cpu().

> +		}
> +		#endif
>  
> +		start = sched_clock();
> +		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
>  		duration = sched_clock() - start;
> +
> +		#ifdef CONFIG_IRQ_TIME_ACCOUNTING
> +		if (in_task()) {
> +			end_time = irq_time_read(cpu);
> +			if (end_time > start_time) {
> +				irq_delta = end_time - start_time;
> +				duration -= irq_delta;
> +			}
> +		}
> +		#endif

This is really dodgy coding style. Please keep the preprocessor
directives at column 0.

What do you think about steal-time, do you want to remove that from your
BPF runtime too?

If so, perhaps expose the scheduler's clock_task, which does both things
already?



