Return-Path: <bpf+bounces-55209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB3EA79D19
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 09:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 178637A5CBE
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 07:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0979E24167E;
	Thu,  3 Apr 2025 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j6HpObcH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G3bD46Cb"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E1241139
	for <bpf@vger.kernel.org>; Thu,  3 Apr 2025 07:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743665859; cv=none; b=lWWH4N/LgnX+O1FqoT9OHxrZGAed+3fVZuWarFQJkLQWBPzycRGuF3JdMAtKUNpK1pac59NymG+OJa63FGUBuzCrddDAp+3AXYu7sLTy4QTWcEw0NohsBzZwAXqECLm19zBV9xwCnbBP1x2Osphd4alsbX8JLyBqAANnSCYSH5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743665859; c=relaxed/simple;
	bh=0zMH1MgRjq2b3gl7q2kzt7wbggaTuK8vve7tmy3kHXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfX22KOhG6C2IIn379RvK6JCCveD9FRH3y+Zr5GuXIFdYsubGpPLOoLGgCXLxw9WqymNfOSh8g0N5qYuGPljim448ATTqYXRSvMC3fuyBYB68Vhn/nQBv6ewpWwUh4fZ+B/NpjIXh6jzlvP6X3LhGaMvtIsaU9Qfkz6vDGul1hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j6HpObcH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G3bD46Cb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 3 Apr 2025 09:37:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743665849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y6JbZyxvgeOJnaS61yeYd4hCsKtS7hwmtF1doeYIPX4=;
	b=j6HpObcHxzEJcf5kwuxqshXhgdN/ypjEQ0zPcYAIAeSX+P8+IEiEF5ULcCZriEPILK2W+j
	gxRfDIlI6RN3n9Xj3WCtFW3e5Z11HR/LBqexcfVYJ15/mgwGUzURHc+nZQiTPH85ldMo3z
	7dRiaQLPb4MVmSpT2HQJ20co1Mmm7rpzaMPVM2P3gL9fR6ELvQCTaU61q8s4wagnbMHT1w
	lTt3fVcm2Xabmo7ZN/QbinQ73gVtf+I/fV4pIHbvb11jR/JWZ26bZbr7amcCaRglZg3YcU
	7vZYxIl2nDvtvoOE8zzFEAd6qBJcmRSg3KBkyco61uv3eTVtfw7q9Mg397J87A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743665849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y6JbZyxvgeOJnaS61yeYd4hCsKtS7hwmtF1doeYIPX4=;
	b=G3bD46CbTCyzH9za0iGkt6LLvPPvtBBy3mlyMkjZPtOxenFhdEusCAdIU36LmsVA0WrS/i
	uPT2Un3/bgyTbYCw==
From: Sebastian Sewior <bigeasy@linutronix.de>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Ziljstra <peterz@infradead.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: uprobe splat in PREEMP_RT
Message-ID: <20250403073728.c7kEmd8l@linutronix.de>
References: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
 <20250401172225.06b01b22@gandalf.local.home>
 <CAEf4BzbVmUfDVEs1ndy5hr2YYA5xgt7NODjNhy4x+Syfbr1yaA@mail.gmail.com>
 <20250402103326.GD22091@redhat.com>
 <20250402105746.FMPvRBwL@linutronix.de>
 <20250402112308.GF22091@redhat.com>
 <20250402121315.UdZVK1JE@linutronix.de>
 <20250402121850.GI22091@redhat.com>
 <20250402122447.B3XIrQnG@linutronix.de>
 <20250402141245.GK22091@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250402141245.GK22091@redhat.com>

On 2025-04-02 16:12:46 [+0200], Oleg Nesterov wrote:
> On 04/02, Sebastian Sewior wrote:
> >
> > On 2025-04-02 14:18:51 [+0200], Oleg Nesterov wrote:
> > > On 04/02, Sebastian Sewior wrote:
> >
> > I need to tell mutt to replace my name in case it is misspelled.
> 
> Hmm... have I misspelled your name somewhere?
> 
> If yes - my apologies.

Don't worry. You didn't start it, it is just I noticed it.

> > > > The preempted ri_timer() could stall a read_seqcount_begin().
> > >
> > > Again, nobody use read_seqcount_begin(utask->ri_seqcount).
> > >
> > > free_ret_instance() uses raw_seqcount_try_begin(utask->ri_seqcount),
> > > which, since ri_seqcount is seqcount_t, is just smp_load_acquire().
> > > This can't stall.
> >
> > Yes. This would work for here just to skip the check because of all
> > details that are hard to express. Therefore I suggested to use
> > raw_write_seqcount_begin() instead of write_seqcount_begin() in
> > 20250402122158.j_8VoHQ-@linutronix.de. Would that work?
> 
> If this can work, then let me repeat: why can't we turn ->ri_seqcount
> into a boolean?

I just stumbled here due to the warning. Now that you ask the question,
it is used a bool in the current construct. So yes, I also don't see
why.

> Oleg.

Sebastian

