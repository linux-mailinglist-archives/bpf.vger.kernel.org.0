Return-Path: <bpf+bounces-33140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 125BC917AF8
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 10:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C408B1F25383
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 08:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D921161314;
	Wed, 26 Jun 2024 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FYPJl1ye"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5222923BF;
	Wed, 26 Jun 2024 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719390552; cv=none; b=Fi4cSobo3p0ZdixQhXpgLOdEjP31Yb9zFlDW3/r5Onm1nKok/3ngfwLluF+cgSpVECm5SRSqY12KGEs3q3/fXoVwYlQsQWwoEc1M6xkUF86j2x+evH8JcTJIXJvQsT0bw+SprIDWVPRyUvxkYb1apy74k60jtazM1hN1XllIHnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719390552; c=relaxed/simple;
	bh=Cp7NuRUJVqGGZYwOZ8n29EcYvv+5dVawcwjYBiu90F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlW0jX8xTcE023xg/BN/veDxmUo9zxZbMk8bdquc5NDr1sFXiycrl1MBT650r3+Lh2vai1LM9N8LuwJfD7CjZyT+6xZNbOrgVUJcfGTM09htBB/z7BWTfCTxjo38oyMAe3wb4o7wFZBDMqo4Utv/aTMtDtFBXzKJHk2ne4jAPa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FYPJl1ye; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gx1YbM7m9OifZ66nwDwy8F0WLf5LnqApcjTF7ww/P44=; b=FYPJl1yeXy6/ssmw7YTSEecDm+
	8miUIgYGdjz/FiaOWbN/u4zwXu2zYt/g1ipyvH9N10LEUu14PcLG+1Ema97tXdxmjwErHrzYWjfMK
	yv25AqjD5/cioi8CHFAtTYoKZR9VS/lqWdGaKXHVwNsXSWgYqXl76Z96Insn/c8QEs28lkvKVG90y
	6Y7pG2evZEKL20FjlGxCunQN1vpYq7Gsu4koboUHe3RwkPErcDsMod/Nba/qwWgEzFBWBARafAVgt
	8wqOMvIPzkQccV1yu4+0OPgP21BgnekUL3aV2DWnO8IAWnTQgg8UC5vmvRLcAzbe++DrZQngfbFxd
	MPVgtLiw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMO1I-0000000C48O-3pdW;
	Wed, 26 Jun 2024 08:28:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8E69330057C; Wed, 26 Jun 2024 10:28:48 +0200 (CEST)
Date: Wed, 26 Jun 2024 10:28:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, andrea.righi@canonical.com,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH sched_ext/for-6.11] sched, sched_ext: Replace
 scx_next_task_picked() with sched_class->switch_class()
Message-ID: <20240626082848.GZ31592@noisy.programming.kicks-ass.net>
References: <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx>
 <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <CAHk-=wgjbNLRtOvcmeEUtBQyJtYYAtvRTROBy9GHeF1Quszfgg@mail.gmail.com>
 <ZnRptXC-ONl-PAyX@slm.duckdns.org>
 <ZnSp5mVp3uhYganb@slm.duckdns.org>
 <20240624085927.GE31592@noisy.programming.kicks-ass.net>
 <ZnnelpsfuVPK7rE2@slm.duckdns.org>
 <20240625074935.GR31592@noisy.programming.kicks-ass.net>
 <ZntS_eM2reaszYcj@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZntS_eM2reaszYcj@slm.duckdns.org>

On Tue, Jun 25, 2024 at 01:30:05PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jun 25, 2024 at 09:49:35AM +0200, Peter Zijlstra wrote:
> > > Imagine a case where a sched_ext task was running but then a RT task wakes
> > > up on the CPU. We'd enter the scheduling path, RT's pick_next_task() would
> > > return the new RT task to run. We now need to tell the BPF scheduler that we
> > > lost the CPU to the RT task but haven't called its pick_next_task() yet.
> > 
> > Bah, I got it backwards indeed. But in this case, don't you also need
> > something in pick_task() -- the whole core scheduling thing does much
> > the same.
> 
> Yes, indeed we do, but because we're dispatching from the balance path, the
> cpu_acquire method is being called from there. Because who was running on
> the CPU before us is less interesting, @prev is not passed into
> cpu_acquire() but if that becomes necessary, it's already available there
> too.

I suppose I need to read more, because I'm not knowing what cpu_acquire
is :/ I do know I don't much like the asymmetry here, but maybe it makes
sense, dunno.

