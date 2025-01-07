Return-Path: <bpf+bounces-48169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC3EA04A0D
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 20:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78751621C7
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 19:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD521F4720;
	Tue,  7 Jan 2025 19:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JL0jgqS4"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4B12C187;
	Tue,  7 Jan 2025 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736277735; cv=none; b=e1fl1hMnnwKACrLhoZoGHKeTb5f9Mu5yZH5grE0rI+iANnKq70f6+BluXLSS0wuvDjnNNJ1MmvXjDGksFj9wrM74tpCfGkAK/15lCBRDHQNgmO0pihk5NAvi6EV+iw3FmSzhbpKkkSyZNV9v37CxLm747oJITT+bV0U5e7ySp0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736277735; c=relaxed/simple;
	bh=RKQbsfZ5Tlq2BSM+fDH5iGBX7UikkOXTBICya22Jg1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFVRuJ3xS68Zsm6BTTi7m/t+ghhjBYmgIaUWACjsgLfKQBmdP8W52R0mhKz+f4oeh74Nc8pZgRMpdlzeHWWu5N+9433/ZFrkyeK4Oi8c7W+YL0YgZknMgvDw2s63hOcEVw7fp69OiPO1A3fS/tlymVrTADkKo/hcxg+N7Re2YOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JL0jgqS4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=HhPITW/6h59oPUkZvp4JzTOK2pd0oxkpvyZxfxdflbw=; b=JL0jgqS43aSTI5hiO1PyOq84IV
	cUDL0o2TJK8x4pe+Wv6YwMNN5cIvbI/Ws9OtLk9lhPw6x+efsaYB4CR8pryt0wqWt8AWY5+HZzrOG
	bq6be8JYynGJRnnH87E7dLyyJzzcBvRVbPilT1BJbjqFmEe7uaGqHjDssmh+TeeOfkWu2+kPSGKEE
	qKOHBSYx/0pVs9+gT3s9A//rloKICMmTQW6z8AKVsvhLG3lLO/WoYkUCzCPxPgMIvA9ZohSblXp8Z
	QILjR4aKuYN8ybJWPksYioqzi4J2FUetXsqYKpSfWxm95un0j9ZX2ZrU/fFU38o+JGPE0Ll4KyS6m
	pFao8mfw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVF9P-00000008dsL-2MMG;
	Tue, 07 Jan 2025 19:22:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D100730057A; Tue,  7 Jan 2025 20:22:02 +0100 (CET)
Date: Tue, 7 Jan 2025 20:22:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Barret Rhoden <brho@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 08/22] rqspinlock: Protect pending bit owners
 from stalls
Message-ID: <20250107192202.GA36003@noisy.programming.kicks-ass.net>
References: <20250107140004.2732830-1-memxor@gmail.com>
 <20250107140004.2732830-9-memxor@gmail.com>
 <20250107145159.GB23315@noisy.programming.kicks-ass.net>
 <CAP01T74SHdhtshm3iO_=+W4AHNQSZekJVKwaQn-Sr5up2apKhA@mail.gmail.com>
 <20250107191756.GA28303@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250107191756.GA28303@noisy.programming.kicks-ass.net>

On Tue, Jan 07, 2025 at 08:17:56PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 07, 2025 at 10:44:16PM +0530, Kumar Kartikeya Dwivedi wrote:
> > On Tue, 7 Jan 2025 at 20:22, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Jan 07, 2025 at 05:59:50AM -0800, Kumar Kartikeya Dwivedi wrote:
> > > > +     if (val & _Q_LOCKED_MASK) {
> > > > +             RES_RESET_TIMEOUT(ts);
> > > > +             smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret));
> > > > +     }
> > >
> > > Please check how smp_cond_load_acquire() works on ARM64 and then add
> > > some words on how RES_CHECK_TIMEOUT() is still okay.
> > 
> > Thanks Peter,
> > 
> > The __cmpwait_relaxed bit does indeed look problematic, my
> > understanding is that the ldxr + wfe sequence can get stuck because we
> > may not have any updates on the &lock->locked address, and we’ll not
> > call into RES_CHECK_TIMEOUT since that cond_expr check precedes the
> > __cmpwait macro.
> 
> IIRC the WFE will wake at least on every interrupt but might have an
> inherent timeout itself, so it will make some progress, but not at a
> speed comparable to a pure spin.
> 
> > Do you have suggestions on resolving this? We want to invoke this
> > macro as part of the waiting loop. We can have a
> > rqspinlock_smp_cond_load_acquire that maps to no-WFE smp_load_acquire
> > loop on arm64 and uses the asm-generic version elsewhere.
> 
> That will make arm64 sad -- that wfe thing is how they get away with not
> having paravirt spinlocks iirc. Also power consumption.
> 
> I've not read well enough to remember what order of timeout you're
> looking for, but you could have the tick sample the lock like a watchdog
> like, and write a magic 'lock' value when it is deemed stuck.

Oh, there is this thread:

  https://lkml.kernel.org/r/20241107190818.522639-1-ankur.a.arora@oracle.com

That seems to add exactly what you need -- with the caveat that the
arm64 people will of course have to accept it first :-)

