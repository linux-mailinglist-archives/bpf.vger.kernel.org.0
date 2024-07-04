Return-Path: <bpf+bounces-33861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4C19271E1
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 10:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C6D1F23C03
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 08:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F40F1A4F3C;
	Thu,  4 Jul 2024 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TKO+7K3N"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124281A4F22;
	Thu,  4 Jul 2024 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720082387; cv=none; b=TCU3Q1Tr/eoiestO4MC7D9TuiGNltCHm01IhI1nDy12kYpvePx4l7PQ/HBmTQ0OZ55N7nriDGV2LHQoxIopUq0nqa8sha+lo9Mbqsl6qT7RDWXl/M4T5+pVG7St0KAJpHWzwRcweEXYAvFaxw7YIcf4tGyf0JZenAnXJashAPhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720082387; c=relaxed/simple;
	bh=oYhN/+apSJfsDF6FgPay1/LBoptt7tXd21AcvutSs20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1p5/Z+gbGrgwaZeC2+ms9BjinI7cQ3+oemWA3mg1ga4nMHMaUC+ylUFLfWlMMwmxQKf1FePSqPR6R6XaepeiLkUMIOwkFFjnp0wr15ZGWT60lP31MoDivd4IWy6r4O7kDd6meyS8FJXziwoiulXOfuhp66/xx2I4ECViM6Am7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TKO+7K3N; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hK3S3qTsE33229u2kAAMlNgGN474Lo9VhEX2kL7iJDM=; b=TKO+7K3NguPB5dm1q1B8fBK9Ru
	d/8G8elCVQLFPoJ6F8NBELJIv4OPhM4x7gqfT50XwhJXWvCcdURvGj8GCSJsj29cXLAxL/PyXejAM
	0MswBUpVvYWug9Nt3IwcSRz04/JY/2hHITEDroFZaQivebuG7k3W8PzLUOy/h1avw3RUQVBAAbvzF
	IAVd/3WBT/9DhUNZAcuzolu3qb3DohoWoisE0eDTr3sm09+GFgsGaRmt1xDMRWuTt58XNHmQrQyXZ
	6p2d0d5TJxI3pywA5gO/QczbrTpEuf3wxJJZmRXflHf0BD2kUa2Ce5MkOzUh5k9n2xjfykEOdIPoz
	tsoHGnyg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPI0C-00000002fAJ-0jIT;
	Thu, 04 Jul 2024 08:39:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D2EF23003FF; Thu,  4 Jul 2024 10:39:35 +0200 (CEST)
Date: Thu, 4 Jul 2024 10:39:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, oleg@redhat.com, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, clm@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] uprobes: add batched register/unregister APIs
 and per-CPU RW semaphore
Message-ID: <20240704083935.GR11386@noisy.programming.kicks-ass.net>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240702102353.GG11386@noisy.programming.kicks-ass.net>
 <20240702115447.GA28838@noisy.programming.kicks-ass.net>
 <CAEf4BzaQUzQdba2=F2NoV7=Th98fxz2EN62QX2Ej92bazt1GAg@mail.gmail.com>
 <20240702191857.GJ11386@noisy.programming.kicks-ass.net>
 <fd1d8b71-2a42-4649-b7ba-1b2e88028a20@paulmck-laptop>
 <20240703075057.GK11386@noisy.programming.kicks-ass.net>
 <6b728325-b628-488f-aabf-dbd9afa388fb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b728325-b628-488f-aabf-dbd9afa388fb@paulmck-laptop>

On Wed, Jul 03, 2024 at 07:08:21AM -0700, Paul E. McKenney wrote:
> On Wed, Jul 03, 2024 at 09:50:57AM +0200, Peter Zijlstra wrote:

> > Would it make sense to disable it for those architectures that have
> > already done this work?
> 
> It might well.  Any architectures other than x86 at this point?

Per 408b961146be ("tracing: WARN on rcuidle")
and git grep "select.*ARCH_WANTS_NO_INSTR"
arch/arm64/Kconfig:     select ARCH_WANTS_NO_INSTR
arch/loongarch/Kconfig: select ARCH_WANTS_NO_INSTR
arch/riscv/Kconfig:     select ARCH_WANTS_NO_INSTR
arch/s390/Kconfig:      select ARCH_WANTS_NO_INSTR
arch/x86/Kconfig:       select ARCH_WANTS_NO_INSTR

I'm thinking you can simply use that same condition here?

