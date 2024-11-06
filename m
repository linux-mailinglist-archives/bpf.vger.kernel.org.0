Return-Path: <bpf+bounces-44122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F38AB9BE533
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 12:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F4C1C20C5E
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 11:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405761DE4E1;
	Wed,  6 Nov 2024 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YYc5yuky"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743061DACBB;
	Wed,  6 Nov 2024 11:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730891170; cv=none; b=MZnpVqLE8p/1Itgor0VIrRnrkEJQcVoRB4Fd3KXxErl5H34qTsuSVgyrqv2ce9WFlivxjDXLUI66B34kuh6o72sQgtgK2v2TgPg51wtkzavqeweNr+H4bWfAKoZK4OWKm81xbk9ZA6l51Wa9S/FvNHjQfIpCuKzmLvtYnj67wio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730891170; c=relaxed/simple;
	bh=x1daPAci/sH83L77hKsJtfM7BbABjcNhbB9A2zFZeIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUt1f6iM3o/M30r91Ea3/YG2k9Vt5uwQ9MHFF3LxrEoAGfH7eveV4Jal5EfHhE6qg6RWh5vx0QkRZi0A/eG00iCucg2VCzMEu7ocAbcNK147tf7dd5keNbzQgaJyJETtntb47dHlaO7WBGZKtG9ZYPCHfMgjVI73wzWQzc6BeVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YYc5yuky; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=KHhlvkY8UlSzLnmAPPPFJYM+1mV9xaApz1N9IxO+X3E=; b=YYc5yukyNei5Uqg2meExPOJ1cv
	4/f75h4eVieapeaztoHVEuXr6JM6ZSh3S95Iiz0oH29FJR5dNlaftCulT51z+1KKUMbX2j7lVKXOi
	fYN8I7PAKZgVQdUYlkqbHjowT6i1HBz0lEpO7N59D4wzQSOHJf15Z0/h/gQrEe9/MATutq/npDHO4
	BpqRuiztCUgxSok5E0he8kysi3woj0V0vqAhbDvc9QHVeOgUp0+132q3n16FwiruXa2FLQBnsAm2Y
	fRJ7oUjdqvbHU0OyKMhw7qv5bMoVeQdp4RSjS9OxVMs62DwKgLL81/9xylcyLEC3ruN/DXUG6obDO
	eCsXzMnA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8drK-0000000BwK8-1Hm8;
	Wed, 06 Nov 2024 11:05:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 809ED300478; Wed,  6 Nov 2024 12:05:57 +0100 (CET)
Date: Wed, 6 Nov 2024 12:05:57 +0100
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
Message-ID: <20241106110557.GY33184@noisy.programming.kicks-ass.net>
References: <CAEf4BzarhiBHAQXECJzP5e-z0fbSaTpfQNPaSXwdgErz2f0vUA@mail.gmail.com>
 <ZyH_fWNeL3XYNEH1@krava>
 <CAEf4BzZTTuBdCT2Qe=n7gqhf3yENZwHYUdsrQP9WfaEC4C35rw@mail.gmail.com>
 <20241106104639.GL10375@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106104639.GL10375@noisy.programming.kicks-ass.net>

On Wed, Nov 06, 2024 at 11:46:39AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 05, 2024 at 06:11:07PM -0800, Andrii Nakryiko wrote:
> > On Wed, Oct 30, 2024 at 2:42 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Wed, Oct 16, 2024 at 12:35:21PM -0700, Andrii Nakryiko wrote:
> > >
> > > SNIP
> > >
> > > >   - Jiri Olsa's uprobe "session" support ([5]). This is less
> > > > performance focused, but important functionality by itself. But I'm
> > > > calling this out here because the first two patches are pure uprobe
> > > > internal changes, and I believe they should go into tip/perf/core to
> > > > avoid conflicts with the rest of pending uprobe changes.
> > > >
> > > > Peter, do you mind applying those two and creating a stable tag for
> > > > bpf-next to pull? We'll apply the rest of Jiri's series to
> > > > bpf-next/master.
> > >
> > >
> > > Hi Ingo,
> > > there's uprobe session support change that already landed in tip tree,
> > > but we have bpf related changes that need to go in through bpf-next tree
> > >
> > > could you please create the stable tag that we could pull to bpf-next/master
> > > and apply the rest of the uprobe session changes in there?
> > 
> > Ping. We (BPF) are blocked on this, we can't apply Jiri's uprobe
> > session series ([0]), until we merge two of his patches that landed
> > into perf/core. Can we please get a stable tag which we can use to
> > pull perf/core's patches into bpf-next/master?
> 
> The whole tip/perf/core should be stable, but let me try and figure out
> how git tags work.. might as well read a man-page today.

I might have managed to create a perf-core-for-bpf-next tag, but I'm not
sure I know enough about git to even test it.

Let me know..

