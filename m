Return-Path: <bpf+bounces-34264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330D992C253
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 19:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA8B3B2BFE4
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 17:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E2C187877;
	Tue,  9 Jul 2024 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZm42W9N"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F57D17B056;
	Tue,  9 Jul 2024 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720544260; cv=none; b=QT+kfJAQX5DiETmnCm51JOZ5qG1Nnh2F7pgYssnx41MLEYJ+ZDi6modeK6iYbsNZkDcmj1UQaQT8ekuBirm76980n7RkAiwwu6y1qI4wgc3PlcQgEYAlWb/nzQCf5fp5ZoXMow+h/6AwooXR7qjhbVWa2ZAYMC3FSUll+2v9mnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720544260; c=relaxed/simple;
	bh=qj+Iu/SvAEvk+IBCByZw2lxCopI8NWpoNUohCnMb9sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtTBBpDkArFQGxOb+hIl1crE7s0uElmicxP5/HHQ1BMbKBARCmIo/0OUoobbbjMRQ/B8IwQUN4HjlOyO2l2aOgzBtt331InvMi02r1xhrd+1JWv2LzXX1/bi8x46AIg6vsLQqBiK29QYTNOdVJ5xm/1+KZpVi3bSsRkiJAqfOmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZm42W9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D6CC3277B;
	Tue,  9 Jul 2024 16:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720544260;
	bh=qj+Iu/SvAEvk+IBCByZw2lxCopI8NWpoNUohCnMb9sQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cZm42W9NZsXilNjZOcSQ0Ci9KD/cY2kSyXXTb+WCxgbiOgq0X2mqHg/2P36AoLZYX
	 No2mGb3ze5gHGLNGjUuj2HRHMq0fXUTLE/o9QGwPFdaan+Wi5ouPtmj/TCI22Tod7q
	 tDRc/eolJX07Rg3Svf70bx4k9KOGNJ9Vmi+HHO7UHB96shldUeR8uARtKEYLWEoOW2
	 beFssf6r1qtCvaJNw3bYMCm5DluHsuIz2ntvH+CNunt2CcTvoiVa11AaZ3XUo5YQWe
	 ZefYIgnRmSLzrpdmYwrI6qS5FunYOR+RX4F3WNr+upQx9VtbZkA/nJwE3/WsETJqTx
	 vOeaKIYV47FyA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A25FBCE0A45; Tue,  9 Jul 2024 09:57:39 -0700 (PDT)
Date: Tue, 9 Jul 2024 09:57:39 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org,
	andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, jolsa@kernel.org,
	clm@meta.com, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <f4e0675e-caad-4a1f-85b4-6b651d8565cd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240708091241.544262971@infradead.org>
 <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
 <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <20240709090153.GF27299@noisy.programming.kicks-ass.net>
 <91d37ad3-137b-4feb-8154-4deaa4b11dc3@paulmck-laptop>
 <20240709142943.GL27299@noisy.programming.kicks-ass.net>
 <Zo1hBFS7c_J-Yx-7@casper.infradead.org>
 <Zo1lrpO3suceheVj@casper.infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo1lrpO3suceheVj@casper.infradead.org>

On Tue, Jul 09, 2024 at 05:30:38PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 09, 2024 at 05:10:45PM +0100, Matthew Wilcox wrote:
> > > So I fundamentally do not believe in per-VMA locking. Specifically for
> > > this case that would be trading one hot line for another. I tried
> > > telling people that, but it doesn't seem to stick :/
> > 
> > SRCU also had its own performance problems, so we've got problems one
> > way or the other.  The per-VMA lock probably doesn't work quite the way
> > you think it does, but it absoutely can be a hot cacheline.
> > 
> > I did propose a store-free variant at LSFMM 2022 and again at 2023,
> > but was voted down.  https://lwn.net/Articles/932298/
> 
> Actually, the 2022 version has a bit more of the flavour of the
> argument: https://lwn.net/Articles/893906/

Thank you for the citations!

From what I can see, part of the problem is that applications commonly
running on Linux have worked around many of these limitations one way or
another, which makes it harder to find a real-world use case for which
the store-free lookup gives substantial benefits.  Perhaps this uprobes
case will be helpful in that regard.  (Hey, I can dream, can't I?)

							Thanx, Paul

