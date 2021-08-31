Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A823FCAE7
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 17:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239410AbhHaPeU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 11:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239482AbhHaPeP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Aug 2021 11:34:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4058C061575;
        Tue, 31 Aug 2021 08:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wVbnNec/6ixz+jlkHVGfYg8FrC6hp+XJ8sgJ6bsJr1o=; b=CHNDb13IUz7LAZQK388Gpsngmp
        zh6Nrzs2HSKSe1PpyisTVcQneowcBu8H3nQtFIBp+b+aqlk7R4AelNs8LCfZNwBdEPmlmFvpii/x4
        UWsZz5rrMyBhUL2UdsMwFDnDF3ckBuET/iBBuUcsUTCyzsndnzMyKYB33Cj47Z4yTBROfmSZBwnNQ
        3ettJXTd3CJeD71k0ixRYcEV6IJzAQT5eiOyXoQrh397tWk06Fdk+JR8oXhpf90CCwhkx4hhuoD1S
        wsxwLL/kxMMCsnIziTt+7i3jgngy7i6ZzzdaonPqXfNIo88l2tjv5zbC5aEZNFar0U7sWaM172EMs
        SHQljwKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mL5kC-001KiR-2d; Tue, 31 Aug 2021 15:32:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 83794300109;
        Tue, 31 Aug 2021 17:32:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 676BA20AEBF37; Tue, 31 Aug 2021 17:32:11 +0200 (CEST)
Date:   Tue, 31 Aug 2021 17:32:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        mingo@redhat.com, kjain@linux.ibm.com, kernel-team@fb.com
Subject: Re: [PATCH v3 bpf-next 2/3] bpf: introduce helper
 bpf_get_branch_snapshot
Message-ID: <YS5LexDSokkcOJ7O@hirez.programming.kicks-ass.net>
References: <20210830214106.4142056-1-songliubraving@fb.com>
 <20210830214106.4142056-3-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830214106.4142056-3-songliubraving@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 30, 2021 at 02:41:05PM -0700, Song Liu wrote:

> @@ -564,6 +565,18 @@ static void notrace inc_misses_counter(struct bpf_prog *prog)
>  u64 notrace __bpf_prog_enter(struct bpf_prog *prog)
>  	__acquires(RCU)
>  {
	preempt_disable_notrace();

> +#ifdef CONFIG_PERF_EVENTS
> +	/* Calling migrate_disable costs two entries in the LBR. To save
> +	 * some entries, we call perf_snapshot_branch_stack before
> +	 * migrate_disable to save some entries. This is OK because we
> +	 * care about the branch trace before entering the BPF program.
> +	 * If migrate happens exactly here, there isn't much we can do to
> +	 * preserve the data.
> +	 */
> +	if (prog->call_get_branch)
> +		static_call(perf_snapshot_branch_stack)(
> +			this_cpu_ptr(&bpf_perf_branch_snapshot));

Here the comment is accurate, but if you recall the calling context
requirements of perf_snapshot_branch_stack from the last patch, you'll
see it requires you have at the very least preemption disabled, which
you just violated.

I think you'll find that (on x86 at least) the suggested
preempt_disable_notrace() incurs no additional branches.

Still, there is the next point to consider...

> +#endif
>  	rcu_read_lock();
>  	migrate_disable();

	preempt_enable_notrace();

>  	if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1)) {

> @@ -1863,9 +1892,23 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
>  	preempt_enable();
>  }
>  
> +DEFINE_PER_CPU(struct perf_branch_snapshot, bpf_perf_branch_snapshot);
> +
>  static __always_inline
>  void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
>  {
> +#ifdef CONFIG_PERF_EVENTS
> +	/* Calling migrate_disable costs two entries in the LBR. To save
> +	 * some entries, we call perf_snapshot_branch_stack before
> +	 * migrate_disable to save some entries. This is OK because we
> +	 * care about the branch trace before entering the BPF program.
> +	 * If migrate happens exactly here, there isn't much we can do to
> +	 * preserve the data.
> +	 */
> +	if (prog->call_get_branch)
> +		static_call(perf_snapshot_branch_stack)(
> +			this_cpu_ptr(&bpf_perf_branch_snapshot));
> +#endif
>  	cant_sleep();

In the face of ^^^^^^ the comment makes no sense. Still, what are the
nesting rules for __bpf_trace_run() and __bpf_prog_enter() ? I'm
thinking the trace one can nest inside an occurence of prog, at which
point you have pieces.

>  	rcu_read_lock();
>  	(void) bpf_prog_run(prog, args);
