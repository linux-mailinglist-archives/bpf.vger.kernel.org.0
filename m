Return-Path: <bpf+bounces-66005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C762B2C400
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 14:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08761887E1F
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 12:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F303043D9;
	Tue, 19 Aug 2025 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MFjJHCyZ"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCB72C11F3;
	Tue, 19 Aug 2025 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755607219; cv=none; b=D7limo3+than5d+qN6jNJK8txrh3xL6wVwW2b3CFMU18cRKFvTcWyX6trZMt2d+CcUwReRD78yLZr28ix2eCMp25DFxjTjjb4VB0U37wzpKfmHhw7CpQdhyvJe5lkGsiduUH3XTBVQDC8nqqKN9zcsnAdF6wGHs/AnBMvR/mbbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755607219; c=relaxed/simple;
	bh=za7vA9XPHjAzfb4aMaEZy5Wxe9acUa2WIcuIi0ShysM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+oJ4mDzhS3jzhtkjX18uBFo+KND99VdYiqd9QDPVPX8P7ahbPOJ4krVa+Uhf7KMIbWP3wlfkGxCq7C5itAJcCawdY919HHPq3NclEtzBmZOXKBEJFlk/aHQKd2IcGVxRhuZUAldHbPmz1xw6Yn2aojKshOiFEeQoQnIYS2sc3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MFjJHCyZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=87oTdEnwJ+QgqT7Ja4Wk7OlEXILX5aNO6KR51R86+tU=; b=MFjJHCyZ2aZAD4uBF2jCDVVJOO
	mvLX39gREc21qOMp40hZmBlXXzTuFCykEz7q2s/eisu9eeujxuyyBM5GVmi0MdZhpmQkbPBZGDldG
	wkZC3eX1mqbas9/u0leF2DzEe8nCt0yWlQGCswgcGpUvuuApcu1IPc+hxgPhTTzvsC/QMZo4z6i/a
	oYImv/An19P1xtZM0CTLUAMgHgE03kxxlhAVnCmjfsIeEVsw22rKLRZQEOmEwhiZWBLIMQIzYbChW
	IZUumT85MQFnq1i5L0VdICMgNrtBLHYGUq3Zn5bU5A77emZ/WGya4eb4Cj2aw61WeLIIUZuneo8He
	Ee8b8p0Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoLdJ-00000005FOM-0BDQ;
	Tue, 19 Aug 2025 12:40:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E2ADF30036F; Tue, 19 Aug 2025 14:40:08 +0200 (CEST)
Date: Tue, 19 Aug 2025 14:40:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, simona.vetter@ffwll.ch,
	tzimmermann@suse.de, jani.nikula@intel.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/3] sched: make migrate_enable/migrate_disable inline
Message-ID: <20250819124008.GI4067720@noisy.programming.kicks-ass.net>
References: <20250819015832.11435-1-dongml2@chinatelecom.cn>
 <20250819015832.11435-3-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819015832.11435-3-dongml2@chinatelecom.cn>

On Tue, Aug 19, 2025 at 09:58:31AM +0800, Menglong Dong wrote:

> The "struct rq" is not available in include/linux/sched.h, so we can't
> access the "runqueues" with this_cpu_ptr(), as the compilation will fail
> in this_cpu_ptr() -> raw_cpu_ptr() -> __verify_pcpu_ptr():
>   typeof((ptr) + 0)
> 
> So we introduce the this_rq_raw() and access the runqueues with
> arch_raw_cpu_ptr() directly.

^ That, wants to be a comment near here:

> @@ -2312,4 +2315,78 @@ static __always_inline void alloc_tag_restore(struct alloc_tag *tag, struct allo
>  #define alloc_tag_restore(_tag, _old)		do {} while (0)
>  #endif
>  
> +#ifndef COMPILE_OFFSETS
> +
> +extern void __migrate_enable(void);
> +
> +struct rq;
> +DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> +
> +#ifdef CONFIG_SMP
> +#define this_rq_raw() arch_raw_cpu_ptr(&runqueues)
> +#else
> +#define this_rq_raw() PERCPU_PTR(&runqueues)
> +#endif

Because that arch_ thing really is weird.

> +	(*(unsigned int *)((void *)this_rq_raw() + RQ_nr_pinned))--;
> +	(*(unsigned int *)((void *)this_rq_raw() + RQ_nr_pinned))++;

And since you did a macro anyway, why not fold that magic in there,
instead of duplicating it?

#define __this_rq_raw()  ((void *)arch_raw_cpu_ptr(&runqueues))
#define this_rq_pinned() (*(unsigned int *)(__this_rq_raw() + RQ_nr_pinned))

	this_rq_pinned()--;
	this_rq_pinned()++;

is nicer, no?

