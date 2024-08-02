Return-Path: <bpf+bounces-36264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F719459E1
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 10:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750EB1C2310A
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 08:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7631C231C;
	Fri,  2 Aug 2024 08:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XeuOp4XH"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5176513FF6;
	Fri,  2 Aug 2024 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722587261; cv=none; b=KQ8IyxZUa9dkQxe/rmtGj4u/++jZOBm68ieCkpDJ4RvUlkZHTBl7267+pBR5VQSio9SaKKK8BlXLoRjKUjR1UU+tUdP0CmcoaUKvPvu07tIKz+kgiDIlDBzB++4ubmTBin/8x8VKftiMscj7hpeZKvjPVrQyejADKPh3K5B/wHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722587261; c=relaxed/simple;
	bh=h+h6qklDL9o4ftiLeV0/tVt+paMOZfiKFQqSc3OJ6Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kj9MPL3l9zB5PrQXZGA6dTBFCCfqnjps8TIzkV00LCCHYBHB49556m79Rgklz8TfSVQpAqOyT/uuR5MQgJ9XIfsJgTTeOwMi4OHv3ghPCiEQ4IEI+4/jvXM/Azv0x4ZqqU0KireV0N/pzISJFZrsvVo2rivz00HVM9D7BcgrLo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XeuOp4XH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=cVjjEKKBcVLAmoDniQWcBQ8wxvJtaWVESHunm41KKbw=; b=XeuOp4XHsYvEcn9o4h+vqY4LKQ
	j05p09EpCwvWzsGPdHGS1/8HYx/CEZI5gCKbEhUPh97BmnRzxSRXD4lLKiNd08WAgzgm74Lo08TQB
	ffPKT4sufyi9edTrGD13YAea/IyG2Uz0sQXOVy2Mrb5hEYxGPdFq9uiTRWrCKfjv87baVafaAVwjf
	tcK/Mew0A78XqRZtL+neDs2lpOLpKg+mMty/VYYEZlWcllMyD9R8lGPu0gz7grNjC0eBIfIopvCme
	FqbGhixoJ29ke8EJYhwK8V7Oah3oJoTFjYa2F8FtImoLbxa1SUSKqWWT1dc39KFA6DhduWrvYLkak
	dc7xXf+A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZndF-00000005f0t-2eS3;
	Fri, 02 Aug 2024 08:27:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A2E1830049D; Fri,  2 Aug 2024 10:27:24 +0200 (CEST)
Date: Fri, 2 Aug 2024 10:27:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Oleg Nesterov <oleg@redhat.com>, andrii@kernel.org,
	mhiramat@kernel.org, jolsa@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v4 0/9] uprobes: misc cleanups/simplifications
Message-ID: <20240802082724.GE39708@noisy.programming.kicks-ass.net>
References: <20240801132638.GA8759@redhat.com>
 <20240801133617.GA39708@noisy.programming.kicks-ass.net>
 <CAEf4BzY-gNWHhjnSh3myb0sStjm0Qjsu6nhFtXEULLvo_E=i5w@mail.gmail.com>
 <CAEf4BzY9diEi2_tHsLxB4Yk-ZAWHT=XJNmagjQtOXc7qShqgrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY9diEi2_tHsLxB4Yk-ZAWHT=XJNmagjQtOXc7qShqgrA@mail.gmail.com>

On Thu, Aug 01, 2024 at 02:13:41PM -0700, Andrii Nakryiko wrote:
> On Thu, Aug 1, 2024 at 11:58 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > + bpf
> >
> > On Thu, Aug 1, 2024 at 6:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Aug 01, 2024 at 03:26:38PM +0200, Oleg Nesterov wrote:
> > > > (Andrii, I'll try to look at your new series on Weekend).
> > >
> > > OK, I dropped all your previous patches and stuffed these in.
> > >
> > > They should all be visible in queue/perf/core, and provided the robot
> > > doesn't scream, I'll push them into tip/perf/core soonish.
> >
> > Just FYI, it seems like tip/perf/core is currently broken for uprobes
> > (and by implication also queue/perf/core). Also torvalds/linux/master
> > master is broken. See what I'm getting when running BPF selftests
> > dealing with uprobes. Sometimes I only get that WARNING and nothing
> > else.
> >
> > I'm bisecting at the moment with bpf/master being a "good" checkpoint,
> > will let you know once I bisect.
> 
> Ok, this bisected to:
> 
> 675ad74989c2 ("perf/core: Add aux_pause, aux_resume, aux_start_paused")
> 
> Reverting all (applied to tip/perf/core) four patches from that series:
> 
> 6763ebdb4983 (tip/perf/core) perf/x86/intel: Do not enable large PEBS
> for events with aux actions or aux sampling
> 6a45d8847597 perf/x86/intel/pt: Add support for pause / resume
> 675ad74989c2 perf/core: Add aux_pause, aux_resume, aux_start_paused
> d92792a4b26e perf/x86/intel/pt: Fix sampling synchronization
> 
> ... makes everything work again. I'll leave it up to you and Adrian to
> figure this out.

Thanks for catching this. I'll go have a look.

