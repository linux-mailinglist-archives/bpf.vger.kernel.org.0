Return-Path: <bpf+bounces-66528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 421C1B3568D
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 10:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2FA1B63581
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 08:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06332F6591;
	Tue, 26 Aug 2025 08:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VR8KGCD/"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A491487D1;
	Tue, 26 Aug 2025 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196342; cv=none; b=TJ0XiM9XCTZyoqWqg3B2RryZYzSTb/Ygb9anDZAUlkEpCi3ygWn1U+Amt3EomxIRMKVyNgpgLqs1tiBRjS79NsaCh0pspO90KkEsVB+m0FOPCYJBsyKkuk9ro74E/cOJJ+CcmC834AjV0JN8MoBGOpqiSh+L2OUAdjXIxM1YadU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196342; c=relaxed/simple;
	bh=41IoulidayxgjAbe5s4PmAeMbvG69mqSaY1k6zaexSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwMZUcxUMybSVOqRoIwZB7SxQ5xYzwR5g4ChjOxjbIoKuW4Qf9sA94+z5cSYYWd0R/MCDCyVDpZo1cOxeGtbmuSvIXTzXymJN4t/AUc/cZe3kzmKXDwYmhq99UpLPeWd46UdHaUe89ygjqCygfUenSY2Zk6sw7azv7RL6zwpE94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VR8KGCD/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nVYZlqRiYdtJsyk81GGNOMDzQ5oa3wfkhSujjBbhLXE=; b=VR8KGCD/1ws3zOkQVG/eU6tPg5
	EePH6AIHIeuESlFjDKi5l6FH8mwZ9V4GAFm6TaGAJbQxjKBP3FNfNygOgy/8pzG2jdd4j9unpe/IY
	8Bko82nV04w32zLUcS735lU0LHLfmTXqOrdN0cAwmFQqhbdA6NbJs7IUwKKKxjaPHFu46yJWcwwiD
	NMP5AfdsZtTkVyNhs7kq2gC6vFYgfgBOtaY4MgSk3pgNTNDR6GU9ua4fXNZe8R7RAMSQbRxY2mTjO
	JJszi6/4RoxBfdpKfoARjxgA8ujZxWJU2TeBry5OtwK/RUfWLZB84RBndliitd9cWEjqNSdAKVbyR
	XqY5VYFg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqot7-0000000F0rT-0HVj;
	Tue, 26 Aug 2025 08:18:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5EDB23002C5; Tue, 26 Aug 2025 10:18:40 +0200 (CEST)
Date: Tue, 26 Aug 2025 10:18:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: jolsa@kernel.org, oleg@redhat.com, andrii@kernel.org,
	mhiramat@kernel.org, linux-kernel@vger.kernel.org, alx@kernel.org,
	eyal.birger@gmail.com, kees@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	haoluo@google.com, rostedt@goodmis.org, alan.maguire@oracle.com,
	David.Laight@aculab.com, thomas@t-8ch.de, mingo@kernel.org,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH 2/6] uprobes/x86: Optimize is_optimize()
Message-ID: <20250826081840.GD3245006@noisy.programming.kicks-ass.net>
References: <20250821122822.671515652@infradead.org>
 <20250821123656.823296198@infradead.org>
 <20250826065158.1b7ad5fc@pumpkin>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826065158.1b7ad5fc@pumpkin>

On Tue, Aug 26, 2025 at 06:51:58AM +0100, David Laight wrote:

> > @@ -1069,17 +1068,14 @@ int set_swbp(struct arch_uprobe *auprobe
> >  	     unsigned long vaddr)
> >  {
> >  	if (should_optimize(auprobe)) {
> > -		bool optimized = false;
> > -		int err;
> > -
> >  		/*
> >  		 * We could race with another thread that already optimized the probe,
> >  		 * so let's not overwrite it with int3 again in this case.
> >  		 */
> > -		err = is_optimized(vma->vm_mm, vaddr, &optimized);
> > -		if (err)
> > -			return err;
> > -		if (optimized)
> > +		int ret = is_optimized(vma->vm_mm, vaddr);
> > +		if (ret < 0)
> > +			return ret;
> > +		if (ret)
> >  			return 0;
> 
> Looks like you should swap over 0 and 1.
> That would then be: if (ret <= 0) return ret;

I considered that, but that was actually more confusing. Yes the return
check is neat, but urgh.

The tri-state return is: 

<0 -- error
 0 -- false
 1 -- true

and that is converted to the 'normal' convention:

<0 -- error
 0 -- success


Making that intermediate:

<0 -- error
 0 -- true
 1 -- false

is just asking for trouble later.

