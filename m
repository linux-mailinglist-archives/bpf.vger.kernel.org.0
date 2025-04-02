Return-Path: <bpf+bounces-55146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6911BA78DF3
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 14:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57FC216C38B
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 12:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EB1238D2F;
	Wed,  2 Apr 2025 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UrCdzr4U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KWujkwY+"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B323238D2E
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596000; cv=none; b=NmxCYOXOYoGgSw+gqpEE6bDftmkXPnRhZ1OWwoUXg54lrwVFgA+5lWsxym4/IlykW/M6jRjQ9NYYLSuoBj3aAtqtANgp0x11IOy3UfJ+2pHAqd/5En2kukX3kp8G2exLkMqMli1MXCncEkUiFrYSZSY60p8g9K89gqPucxwdCmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596000; c=relaxed/simple;
	bh=SExxXNmpvQegFK2NWezqNlOp9Qmitf7bZb5XKBO6xxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPoTAlO6/gUenApbVPEitNtC/JBfq9fCp6Op0XVEpkFyg4ulbzdedfeGDjMDpnXZncP6hC4z0yePZZ0ya6nhtEXVx9pJhqvfkrgiFQtwaivoTG+FKn8jidTvkMlFUk18RDi675IbgtGA71QNCESfnQk6V6N4Xv81F06CriXpYlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UrCdzr4U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KWujkwY+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 2 Apr 2025 14:13:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743595997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y2gNK8pUnYhXB7DXD4S82u85XIyj81iPFAPZEfu4hmc=;
	b=UrCdzr4UCps+z7j/cFKrHC10tEwKhclXV5CtRVP2PxvR+gNXbQ9RJSIwfDOUy+ECdes+Zq
	opoZyZfnTZsfJDORapZNURJwJjAVK+Tav1bYQ7VOPfooUqNFP0RLRn8fI7wvgBeontIoLi
	fUayhyVDzEZztBUkJBog21OIWphDu/kiLNjiUZgljCJUnXtJwHE3ELD+bsp7oZhaNR1+VQ
	kf3GP2ANf9UfPlw/ZNBVys8Sl3mFYDJdh4eSfvNU4w+mjq++ZvJLt7ONNfLu8BsA3Wfn+H
	zsjMs2VSRPg44/6cUhcrowVJieOoqTvToL6RLhj7FEP1p1vhGAZF7vXyHnydpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743595997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y2gNK8pUnYhXB7DXD4S82u85XIyj81iPFAPZEfu4hmc=;
	b=KWujkwY+qwZQrmAZ7s77SJS1YlyVq/8khI5Op0CzBqXSzJUNPuCHszDKPNwdwuC2UiJSc9
	7ADvjwlNOv0XLfDA==
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
Message-ID: <20250402121315.UdZVK1JE@linutronix.de>
References: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
 <20250401172225.06b01b22@gandalf.local.home>
 <CAEf4BzbVmUfDVEs1ndy5hr2YYA5xgt7NODjNhy4x+Syfbr1yaA@mail.gmail.com>
 <20250402103326.GD22091@redhat.com>
 <20250402105746.FMPvRBwL@linutronix.de>
 <20250402112308.GF22091@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250402112308.GF22091@redhat.com>

On 2025-04-02 13:23:09 [+0200], Oleg Nesterov wrote:
> On 04/02, Sebastian Sewior wrote:
> >
> > On 2025-04-02 12:33:55 [+0200], Oleg Nesterov wrote:
> > >
> > > The "writer" ri_timer() can't race with itself, right?
> >
> > On PREEMPT_RT the timer could be preempted by a task with higher
> > priority and invoke hprobe_expire() somewhere else.
> 
> This is clear, but ri_timer() still can not race with itself, no?

No, ri_timer() can not race against itself.
The preempted ri_timer() could stall a read_seqcount_begin(). Also not
the case. The API tries to prevent such things.

> Oleg.

Sebastian

