Return-Path: <bpf+bounces-44121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 952339BE496
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 11:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636A02853C9
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 10:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F1A1DE4C2;
	Wed,  6 Nov 2024 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RWgp7HSH"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C448E1DE3D0;
	Wed,  6 Nov 2024 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890012; cv=none; b=TRXqo3F37T4kFjtFWixHeujVZKjojpE7/DlPYp2GhTm1fV87abDDceydT4kbt6Rg9S7xVrHY9DHfQyiJ4Xmphhw6UXzwzkMO1cpXBb5Jl/mDCglPbl2m5C+OWH9jYn5pcq4DFcP+W/8U2UUBA9ejr9C29rZSfg7uolP+QfOryLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890012; c=relaxed/simple;
	bh=vkkM2h695D/l5SDWyygknwKCqGMFK5wq+MaFFHsuDNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afEOUtc/YVnUEnihIEedxexc8PLrXO636daWPsnEcfXUhsEdiJ5UCYByPLky6lj36GVj/WaLQCpAWvtu9iKGcmc2CGT8erbblIWYW2RWvykT7lZXgh1uAhJqc1DHFP6IB322U+Duwp7zWjPdRT7eCbfLPJjACZSS5AMEvikkRVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RWgp7HSH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=n9pw/ncIr5xOQG+ZVQBxpx/l5w//5qbE75eKMDsD6eQ=; b=RWgp7HSHErvWscYGf1Ffm3pndl
	wZb86wwxZSTq50rJJ73hOf9XdgYa7NkwXbNsWfbMR490miX4DN5skr2j4TaPcbBBehFi2UOvpfs2L
	iMGqnFjXS7MuIqFrjI67qlhWA0akoD+5TldIzUnkN+/gcwr/EY+smdDft6Fola4hDzOq2vcSr+x/m
	OKXrbxMuJtXMOB0pJLvL1fHEP6UoS5BekteG+l+aaMlcIW5HN9kccPF0qkeqCIvSmHs9KXsRDxpkP
	n9a/7rgziZhXmN3f7DYepd57Le/kzu9dDsPPNRv3I3xiXb26mQ9jPH8Udg8sXcdSgLXxIW/QWLdah
	L/6nj1sg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8dYd-00000004Olv-1fBL;
	Wed, 06 Nov 2024 10:46:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2C45A300478; Wed,  6 Nov 2024 11:46:39 +0100 (CET)
Date: Wed, 6 Nov 2024 11:46:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Liao Chang <liaochang1@huawei.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: The state of uprobes work and logistics
Message-ID: <20241106104639.GL10375@noisy.programming.kicks-ass.net>
References: <CAEf4BzarhiBHAQXECJzP5e-z0fbSaTpfQNPaSXwdgErz2f0vUA@mail.gmail.com>
 <ZyH_fWNeL3XYNEH1@krava>
 <CAEf4BzZTTuBdCT2Qe=n7gqhf3yENZwHYUdsrQP9WfaEC4C35rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZTTuBdCT2Qe=n7gqhf3yENZwHYUdsrQP9WfaEC4C35rw@mail.gmail.com>

On Tue, Nov 05, 2024 at 06:11:07PM -0800, Andrii Nakryiko wrote:
> On Wed, Oct 30, 2024 at 2:42 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Oct 16, 2024 at 12:35:21PM -0700, Andrii Nakryiko wrote:
> >
> > SNIP
> >
> > >   - Jiri Olsa's uprobe "session" support ([5]). This is less
> > > performance focused, but important functionality by itself. But I'm
> > > calling this out here because the first two patches are pure uprobe
> > > internal changes, and I believe they should go into tip/perf/core to
> > > avoid conflicts with the rest of pending uprobe changes.
> > >
> > > Peter, do you mind applying those two and creating a stable tag for
> > > bpf-next to pull? We'll apply the rest of Jiri's series to
> > > bpf-next/master.
> >
> >
> > Hi Ingo,
> > there's uprobe session support change that already landed in tip tree,
> > but we have bpf related changes that need to go in through bpf-next tree
> >
> > could you please create the stable tag that we could pull to bpf-next/master
> > and apply the rest of the uprobe session changes in there?
> 
> Ping. We (BPF) are blocked on this, we can't apply Jiri's uprobe
> session series ([0]), until we merge two of his patches that landed
> into perf/core. Can we please get a stable tag which we can use to
> pull perf/core's patches into bpf-next/master?

The whole tip/perf/core should be stable, but let me try and figure out
how git tags work.. might as well read a man-page today.

