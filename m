Return-Path: <bpf+bounces-33896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCEF9279B0
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 17:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7FE1C23BF2
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 15:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD39E1B11E9;
	Thu,  4 Jul 2024 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjPdDL6C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F31AED55;
	Thu,  4 Jul 2024 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106026; cv=none; b=nFWM09bZQX36BM3zgvlfZwEwxy0om6HO2cs4nOGWYH+wrHBQ6Tbfx4rKrwjCfCelp9vDQ10GqkgG2ZjpxvumCzI3I6rOnQaHgalsQeypWiqb00y0QfYe3Oof4NTdr/OOBPLVz2LqrHwuwU+dNE5z8I7nn2pr/PpjEx+zZS0dxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106026; c=relaxed/simple;
	bh=z7E+MknHGutSinOZE8ZFEWbblRdqQlH1U//ryH1/BB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAcfp+F4yX/n4KH7I4HpgVyN5Db5zkIbODTnUgzOnFtZMZIexkFOWq0SO9V4/IZjTF11XzrhUCKh0EsYg55rMRehbrj8HSpzbc1IlHzOwTZTBo8RXK0DXHZMEpTrfqof+4eJ4t1oIx0/djJS1qTcjbQVQsK0rZSTJvKrcgohtPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjPdDL6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D81C3277B;
	Thu,  4 Jul 2024 15:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720106025;
	bh=z7E+MknHGutSinOZE8ZFEWbblRdqQlH1U//ryH1/BB4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=NjPdDL6CQBJrq0/WmbQgLIoMGSBl5lUkuAp+B53vBy/alChCVD8VDqK490MdjOv96
	 ItGHH12WL0HtHNWaVv+ZlExbr9a5G+D/ow1x3KzNaZ8TGWRrPOND3B0t1IlVXc8bqu
	 XDZVx24zyj3/1K6CbLoU6jAJh925ERsGh7oJe4d8J9UTYt8hojYyuwi77x3proNI3E
	 ihAH3V/v3O/svzggxKcL8xk4lD7S49HQiQQ2CJaIjdbwsDeg2SCXIkeLM6mEaP5GPd
	 SUhdqP5GHGS284mhY38zoGGmMBnKkttsDARXs4ZsOAnR07hvX3izvUay9DwtSuOofB
	 DPZWV6Z6xS57g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6D6F0CE09D9; Thu,  4 Jul 2024 08:13:45 -0700 (PDT)
Date: Thu, 4 Jul 2024 08:13:45 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, oleg@redhat.com, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, clm@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] uprobes: add batched register/unregister APIs
 and per-CPU RW semaphore
Message-ID: <2118e0a9-e878-4bc5-83d2-9a11b2d5efb9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240702102353.GG11386@noisy.programming.kicks-ass.net>
 <20240702115447.GA28838@noisy.programming.kicks-ass.net>
 <CAEf4BzaQUzQdba2=F2NoV7=Th98fxz2EN62QX2Ej92bazt1GAg@mail.gmail.com>
 <20240702191857.GJ11386@noisy.programming.kicks-ass.net>
 <fd1d8b71-2a42-4649-b7ba-1b2e88028a20@paulmck-laptop>
 <20240703075057.GK11386@noisy.programming.kicks-ass.net>
 <6b728325-b628-488f-aabf-dbd9afa388fb@paulmck-laptop>
 <20240704083935.GR11386@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704083935.GR11386@noisy.programming.kicks-ass.net>

On Thu, Jul 04, 2024 at 10:39:35AM +0200, Peter Zijlstra wrote:
> On Wed, Jul 03, 2024 at 07:08:21AM -0700, Paul E. McKenney wrote:
> > On Wed, Jul 03, 2024 at 09:50:57AM +0200, Peter Zijlstra wrote:
> 
> > > Would it make sense to disable it for those architectures that have
> > > already done this work?
> > 
> > It might well.  Any architectures other than x86 at this point?
> 
> Per 408b961146be ("tracing: WARN on rcuidle")
> and git grep "select.*ARCH_WANTS_NO_INSTR"
> arch/arm64/Kconfig:     select ARCH_WANTS_NO_INSTR
> arch/loongarch/Kconfig: select ARCH_WANTS_NO_INSTR
> arch/riscv/Kconfig:     select ARCH_WANTS_NO_INSTR
> arch/s390/Kconfig:      select ARCH_WANTS_NO_INSTR
> arch/x86/Kconfig:       select ARCH_WANTS_NO_INSTR
> 
> I'm thinking you can simply use that same condition here?

New one on me!  And it does look like that would work, and it also
looks like other code assumes that these architectures have all of their
deep-idle and entry/exit functions either inlined or noinstr-ed, so it
should be OK for Tasks Trace Rude to do likewise.  Thank you!!!

If you would like a sneak preview, please see the last few commits on
the "dev" branch of -rcu.  And this is easier than my original plan
immortalized (at least temporarily) on the "dev.2024.07.02a" branch.

Things left to do: (1) Rebase fixes into original commits. (2)
Make RCU Tasks stop ignoring idle tasks.  (3) Reorder the commits
for bisectability.  (4) Make rcutorture test RCU Tasks Rude even when
running on platforms that don't need it.  (5) Fix other bugs that I have
not yet spotted.

I expect to post an RFC patch early next week.  Unless there is some
emergency, I will slate these for the v6.12 merge window to give them
some soak time.

							Thanx, Paul

