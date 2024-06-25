Return-Path: <bpf+bounces-33029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A539160E7
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 10:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7473C280FAF
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 08:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CA1147C98;
	Tue, 25 Jun 2024 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MNXxHY0s"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2720E22313;
	Tue, 25 Jun 2024 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303419; cv=none; b=NCS44SQk7qX6TQbSAgJDzNM4pydWsDUzPmp1vJDjdmhO374OYF8wn+RLsCDXkVp9BLqgRhHa/jd14ViTAvTp2BrrCwhmwKqgWo0n/PR4HYEpQ+p0+vRxxb8FmTqDYe58aT6eJcUnpyodG4pbpoHcB5JzVwue2WO1TsG7zSpgoRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303419; c=relaxed/simple;
	bh=kP2G2AwtDhatycgWspG5fUFjnEX4Z71anAgqAA3T5fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCNPMjmRmi2VkIUhtxfcszYc3S9yFpjbPCp+9ntT/yoGLrTK9J5pMGXakpL0f3fGupUDx8bW5NrDNIPw/hfWVX5vYnBrxV2dGUfSoTG3qsRRAC+E4SNLyJLu2piKQ1B4C9Kz5fxwXUtm0bB5CcnU/4wfz4bpsjVeffK/AejY7FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MNXxHY0s; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w6oFRyv4cwWlY7Mt60hmmxxMtr0YnLssGUXxiho1gYA=; b=MNXxHY0sC1CzsuP80MUfBsC3yq
	6gpFJ8wlw7Uf5Aex+q5WM2fZiDKVq7hQUtYWOZ6VnpD6AQRSfpzUaszkYd13Ts4QT4tRJ7DesmZTb
	IK/LBhw+BaiPHlpfhqFjo0YJdjzS3FyNr5nV8CLMa0Yf3wb1KDWFnpP0Iqm1a4d748ura1Opbcu6K
	LTTMu1bFjhyb2FGPG+9Y0Zeg7kAYJl0vCpBKA3ow2j5XizwXHuq9oyLj+RJErbKRwMi7csQA94gOO
	JTvY/IE1lLBMAMXQNoBe6huqUp1UVarR6Bi9r5jGZ43E5ZRrGhOLS6WtpAXYEOTfl+3VNi/iV2O+J
	a+VcKZiQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM1Lu-00000008N1a-1Ti5;
	Tue, 25 Jun 2024 08:16:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EC86C300754; Tue, 25 Jun 2024 10:16:33 +0200 (CEST)
Date: Tue, 25 Jun 2024 10:16:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	andrea.righi@canonical.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 05/39] sched: Add sched_class->switching_to() and expose
 check_class_changing/changed()
Message-ID: <20240625081633.GS31592@noisy.programming.kicks-ass.net>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-6-tj@kernel.org>
 <20240624110624.GJ31592@noisy.programming.kicks-ass.net>
 <Znnwn0waZXAcNsjn@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Znnwn0waZXAcNsjn@slm.duckdns.org>

On Mon, Jun 24, 2024 at 12:18:07PM -1000, Tejun Heo wrote:
> Hello, Peter.
> 
> On Mon, Jun 24, 2024 at 01:06:24PM +0200, Peter Zijlstra wrote:
> ...
> > > +	void (*switching_to) (struct rq *this_rq, struct task_struct *task);
> > >  	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
> > >  	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
> > 
> > So I *think* that I can handle all the current cases in
> > sched_class::{en,de}queue_task() if we add {EN,DE}QUEUE_CLASS flags.
> > 
> > Would that work for the BPF thing as well?
> >
> > Something like the very much incomplete below... It would allow removing
> > all these switch{ed,ing}_{to,from}() things entirely, instead of
> > adding yet more.
> 
> Hmm... so, I tried to make it work for SCX but enqueue() and dequeue() are
> only called if the task was queued at the time of sched_class change, right?
> However, these callbacks expect to be called even when the task is not
> currently queued. Maybe I'm misreading code but it looks like that'd break
> other classes too. What am I missing?

Ah,.. so I think the RT/DL ones can work (which is what I looked at),
they're only concerned with balancing tasks that are on the queue.
But yeah, I missed that the fair thing needs it regardless.

Bummer. I was hoping to reduce calls.

