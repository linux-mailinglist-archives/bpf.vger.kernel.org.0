Return-Path: <bpf+bounces-67342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8507BB42A86
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 22:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D44F27B4930
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 20:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93FA30499A;
	Wed,  3 Sep 2025 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZuHz5wyr"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB032FFDDE;
	Wed,  3 Sep 2025 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930111; cv=none; b=r0rFXCZJFVSORgEJ3WiJ6Jhl7fTU3N3Yv2w+IgYpLTzDcErP1+iPQXV/ugN2PDwOLARKSYSMBZDH5ZuRM71Lf1UFru9YVcCISz8T8BZyegwCR1UnRajaEu9nFDwwTJa/YPY1Qvzwexy7cmnY6FcTkEtojsy6lS0HFVRCXKFFr7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930111; c=relaxed/simple;
	bh=n+kFJ5CQIGan32iPVcC94ZEat0JU7F76LsSpuSFKvKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uttxg2URrMp7pUZhh9u7boH0bXtAYnZIjOnshU3Krjj8nwdz0NfCbrcFr1Ca4bixCW4yCxAAAjOQ7F+us4WSTlOJMrapbguJd5HxhUixjw6yMthx3FdBPXcWx0yvI8nu+O57SaWVxOLqeURttsDVvJt9NxQnGcIcNqBM5r9zJkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZuHz5wyr; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OJR4LUUI05YAM3lRoCy8dS0UeKlA3a69ENhcSTWLppY=; b=ZuHz5wyrVpbrYLS9qzAZOginbC
	LsTGuRgcP6wehZ4eYQbnJmgFAjHWK4G4b+V5bWnzzrHRowVn0yMkx5BxhHV2wQemPDtUxNhUpfzRw
	SW815j9t10ZXpLhdmCbhS0Rebj+v834u3EGhHfHryDhw68W6sCGXCEfXAVawB0dMvn/k+LbX4GrJy
	mxhqCyXCqARxGGag4We9otCjNwBGWHxMpnmv6+6R6YQ6oTl5Vj1OCjmdOUl94/s6m2tcXhOTJ+mBH
	iLc7lO4SVcgWJeR9Qt3zggh7pHVgReLimhLNYo6U/gU1XeUM4/fGT5EMFshkLT643OKw2uYag5xv7
	X8XHsD0w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uttmI-00000004DJV-3bV8;
	Wed, 03 Sep 2025 20:08:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 68B39300220; Wed, 03 Sep 2025 22:08:22 +0200 (CEST)
Date: Wed, 3 Sep 2025 22:08:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luigi De Matteis <ldematteis123@gmail.com>
Subject: Re: [PATCH 07/16] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <20250903200822.GO4067720@noisy.programming.kicks-ass.net>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-8-arighi@nvidia.com>
 <aLidEvX41Xie5kwY@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLidEvX41Xie5kwY@slm.duckdns.org>

On Wed, Sep 03, 2025 at 09:54:58AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Sep 03, 2025 at 11:33:33AM +0200, Andrea Righi wrote:
> > +static struct task_struct *ext_server_pick_task(struct sched_dl_entity *dl_se,
> > +						void *flags)
> > +{
> > +	struct rq_flags *rf = flags;
> > +
> > +	balance_scx(dl_se->rq, dl_se->rq->curr, rf);
> > +	return pick_task_scx(dl_se->rq, rf);
> > +}
> 
> I'm a bit confused. This series doesn't have prep patches to add @rf to
> dl_server_pick_f. Is this the right patch?

Patch 14 seems to be the proposed alternative, and I'm not liking that
at all.

That rf passing was very much also needed for that other issue; I'm not
sure why that's gone away.

