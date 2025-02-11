Return-Path: <bpf+bounces-51126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A307A30822
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 11:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A001674C9
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 10:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543BA1F3FC1;
	Tue, 11 Feb 2025 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="miRlq9mP"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8531F3BBE;
	Tue, 11 Feb 2025 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268714; cv=none; b=Sb0IvwIeIvfrl595bp2VRNX9lRr7yWsIr85vdETrOAdZIM9nns0M4Pq31FhSw8JAqD/H1F/hiNreuchG15NqS0QGE14BNZ/R1+takhG010/38l4OcniCNYwoSO2TJRIueNDPF4+HdbHX2zqY0amqhw4NKv+iT1A/+F9BA87P0YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268714; c=relaxed/simple;
	bh=PcvVTX8L9ACVG/gTTCKjpqy9r2utuVwxHIetmFSrHaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebgWUbgNNfOeMd+iaJoCW4KiqEmZc7Ch7d4Qpqcigvem4nF4EAeOcsbGo7kaBWTerjgIDYgcxejxMEpMFHO2QOyZ5Lw9Lb2Q5jfhLA/xhD+5OX2dkeyoNShT/+2nOJ3mxqwfC4I8NBawO6A5VId0z9XfHIM7cqJldPL0TTUjuRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=miRlq9mP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=PV93ETFkrqs3pTKrkdQXX0D434rl02bBD6bSk/+peHA=; b=miRlq9mP3oLnwBVm41ESdv4Rd/
	uLSFj20mx7H3po/BbLLy045i2QiQicSnht6rNCCLUol9u0EFRy9v+eYbRgwyrFPhr13vqyHLynlrl
	BKVzen+RSPUkikZejJclhIdJV3TrMutvu65yG9+nJG6SS2FZAC1Ni6H7Mqpb1UFYqeMqN2TjLyaLF
	zid52R8Famn3Gg8THdDiUdg58NUi8MquONAcc6yT6P0x6ieejo4UrVmtKVbwJcvGq44xxYyywbSvk
	p1rHFEfzsYnyApJi+s1VJs1ERxXb53ptPPkXNwKqqAYdMX1O7XrCAgUN+KmdTlwXGUHBbI85Ga1X1
	n3LbfjiQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1thnF4-00000000voA-3zf4;
	Tue, 11 Feb 2025 10:11:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6293A3004AF; Tue, 11 Feb 2025 11:11:46 +0100 (CET)
Date: Tue, 11 Feb 2025 11:11:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Barret Rhoden <brho@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 07/26] rqspinlock: Add support for timeouts
Message-ID: <20250211101146.GB29593@noisy.programming.kicks-ass.net>
References: <20250206105435.2159977-1-memxor@gmail.com>
 <20250206105435.2159977-8-memxor@gmail.com>
 <20250210095607.GH10324@noisy.programming.kicks-ass.net>
 <CAADnVQKefT6iQVQ66QTCeRCMs_am4cC3pBt1Ym1fxfeeQVDDWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKefT6iQVQ66QTCeRCMs_am4cC3pBt1Ym1fxfeeQVDDWA@mail.gmail.com>

On Mon, Feb 10, 2025 at 08:55:56PM -0800, Alexei Starovoitov wrote:
> On Mon, Feb 10, 2025 at 1:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Feb 06, 2025 at 02:54:15AM -0800, Kumar Kartikeya Dwivedi wrote:
> > > @@ -68,6 +71,44 @@
> > >
> > >  #include "mcs_spinlock.h"
> > >
> > > +struct rqspinlock_timeout {
> > > +     u64 timeout_end;
> > > +     u64 duration;
> > > +     u16 spin;
> > > +};
> > > +
> > > +static noinline int check_timeout(struct rqspinlock_timeout *ts)
> > > +{
> > > +     u64 time = ktime_get_mono_fast_ns();
> >
> > This is only sane if you have a TSC clocksource. If you ever manage to
> > hit the HPET fallback, you're *really* sad.
> 
> ktime_get_mono_fast_ns() is the best NMI safe time source we're aware of.
> perf, rcu, even hardlockup detector are using it.

perf is primarily using local_clock(), as is the scheduler.


