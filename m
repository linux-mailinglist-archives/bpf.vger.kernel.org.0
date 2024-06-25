Return-Path: <bpf+bounces-33028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2DB916058
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 09:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5877E1C22016
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 07:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E4B146A86;
	Tue, 25 Jun 2024 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kkum7d9L"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1AC144312;
	Tue, 25 Jun 2024 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719301799; cv=none; b=YJ2yk0p6XWMvPuwcLkmzT/f1eJRx1gfkCYv+GLZ4uvI5BXsd0LYw82kiaUFlxmdYLExzQ8Lv+E3IAYnhvx9XsKsfzeqSBvXKO6SXvAhY+8JtSqAsN4C8YykUJbaZjaNeLc1kThe8PD2omC/3TBDBkso9D7/dIehd0+hRC5t26hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719301799; c=relaxed/simple;
	bh=faTrCwWkv+dGeihbfSy+yUMRIjnBk+iNnBz941VIPLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMdaIakSIbPEvfugoaSP5yhtK/2/5DrZK9TcbWLQWQJ0AoOV5GixGUihShSJk8+5rASqg3sVWbJjEuVM0OhQlCwszpxAnbH0yoTVViy51bUVTTmN0ZonKENLytfR5f4fQ5pUFM6ljXjNgpQLmS6qPOaW9ke77CvGCR9uti+I42E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kkum7d9L; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RWff8z15v7KMYOgrnwioRyYitDX4SGZrSy68ZykxM7E=; b=Kkum7d9LGj3bNrYMV9A/TIvCq8
	6SkmNeNKg2Ksmz1YUggVgTrVMy9Wg/Z/rsJtgU/7b7weNUDGsQLRatgBiKzmgu/1ekZLWv2P8AxU9
	g52Qx7wT5XjnjC+K+buxjjO1IgAvIbjWPLvQguZZOZ5bryw0rG4c35nCWOnoDLuLZk5/1w7WZdiss
	JNPfElSVNnaCU0xeHwyQ8x+38VhmDcRClGrxd92VgnGM/x+qwhB8XGzffeUyF7SKMXJCLm7/hJF36
	5ldZS9HhN6jq304GC1SiR6zIpeaymaG/x8f3L/mv0pBS+fd/OYiyi3O75G6OfCK8MbeiNEG24Z3gm
	daaE2VEQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM0vo-0000000Av70-3oaP;
	Tue, 25 Jun 2024 07:49:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 54AAB300754; Tue, 25 Jun 2024 09:49:35 +0200 (CEST)
Date: Tue, 25 Jun 2024 09:49:35 +0200
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
Message-ID: <20240625074935.GR31592@noisy.programming.kicks-ass.net>
References: <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx>
 <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx>
 <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <CAHk-=wgjbNLRtOvcmeEUtBQyJtYYAtvRTROBy9GHeF1Quszfgg@mail.gmail.com>
 <ZnRptXC-ONl-PAyX@slm.duckdns.org>
 <ZnSp5mVp3uhYganb@slm.duckdns.org>
 <20240624085927.GE31592@noisy.programming.kicks-ass.net>
 <ZnnelpsfuVPK7rE2@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnnelpsfuVPK7rE2@slm.duckdns.org>

On Mon, Jun 24, 2024 at 11:01:10AM -1000, Tejun Heo wrote:
> Hello, Peter.
> 
> On Mon, Jun 24, 2024 at 10:59:27AM +0200, Peter Zijlstra wrote:
> > > @@ -5907,7 +5907,10 @@ restart:
> > >  	for_each_active_class(class) {
> > >  		p = class->pick_next_task(rq);
> > >  		if (p) {
> > > -			scx_next_task_picked(rq, p, class);
> > > +			const struct sched_class *prev_class = prev->sched_class;
> > > +
> > > +			if (class != prev_class && prev_class->switch_class)
> > > +				prev_class->switch_class(rq, p);
> > 
> > I would much rather see sched_class::pick_next_task() get an extra
> > argument so that the BPF thing can do what it needs in there and we can
> > avoid this extra code here.
> 
> Hmm... but here, the previous class's ->pick_next_task() might not be called
> at all, so I'm not sure how that'd work. For context, sched_ext is using
> this to tell the BPF scheduler that it lost a CPU to a higher priority class
> (be that RT or CFS) os that the BPF scheduler can respond if necessary (e.g.
> punting tasks that were queued on that CPU somewhere else and so on).
> 
> Imagine a case where a sched_ext task was running but then a RT task wakes
> up on the CPU. We'd enter the scheduling path, RT's pick_next_task() would
> return the new RT task to run. We now need to tell the BPF scheduler that we
> lost the CPU to the RT task but haven't called its pick_next_task() yet.

Bah, I got it backwards indeed. But in this case, don't you also need
something in pick_task() -- the whole core scheduling thing does much
the same.



