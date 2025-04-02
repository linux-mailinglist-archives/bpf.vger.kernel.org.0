Return-Path: <bpf+bounces-55152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFED0A78E57
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 14:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A57173E85
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 12:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814BB239597;
	Wed,  2 Apr 2025 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GWXTbkyl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sf2XaxLG"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D4A239089
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596692; cv=none; b=DGOXQsbJ3Ai+hwmJdvqC6LpqeEnUJ6PjwLHNOVCik9Fiob1XcPCI6pCUccW0zklHU9OQS0YA4wrE+6KBEbdEYxkFQXW6JEULaz5NyuFYVD6X2uCJ3VZKyv7t+Y/XMdFtooj4k5sKwh2XDwLsfXrPynxNcMWIr/Os+0VUiIRyHX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596692; c=relaxed/simple;
	bh=kIhCGYeB4Rf8CS2JtosmfXrY7Y98DrGOV4JqLFue6Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxyRKzrYFUKFrhDKu5h1xx5gbeoX/ZRfsEp65WwyuEXpfdkycDvcO8Y+r9RVEqnWlT2U7PTF0bVas/hyYGK3syw6N3/1jxIkr4J1TkYY2YNmIVjumJI9JyTfn3IOh7c+KKq5Qtrw7piVCPlpG0CdQS6Ec87RuNautijcHf0KAiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GWXTbkyl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sf2XaxLG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 2 Apr 2025 14:24:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743596688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rz4ugf95/W8SWgAFf/NAf1HNQnHq3Y77rxAca/LWuLA=;
	b=GWXTbkyl5xrcwibdV8Id8O+Mla0C1vkl3RD8DerJz1rhliQl+2Jlmj5Ls63PZ8qTrmUwCP
	7tr0JhWE8dGfH0mnJzEJYNydvLDXe4srH0WiJkJ0ANXExKkxRu46rpPabpjm3/jC8csb9c
	N6dY9AXcYwXk91otO+UVi7/65OmFLSR3D0mXsftMhJ3z/TWPzfTSg+hNM+qFL//b4HntlZ
	EShKqrNomTkKlv2Y6QroSM4/q3Hxj6U/nylk4rwTVtlBUJWWV6L/K9TGL6Cb4lsFnNy97L
	b/ernbcqmbYRkNhM6fn4aRWP6qHXbBjZNx35kUM1CKuCO9MnYbgba3fq3Vl+XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743596688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rz4ugf95/W8SWgAFf/NAf1HNQnHq3Y77rxAca/LWuLA=;
	b=sf2XaxLGsgF9AEbjK09K0tx3pjhYtkjAaCKGEGhEulM1lxqvtpuF2zN8umV7spCcELnZ0X
	OLuWyblrLQs2ZGBA==
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
Message-ID: <20250402122447.B3XIrQnG@linutronix.de>
References: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
 <20250401172225.06b01b22@gandalf.local.home>
 <CAEf4BzbVmUfDVEs1ndy5hr2YYA5xgt7NODjNhy4x+Syfbr1yaA@mail.gmail.com>
 <20250402103326.GD22091@redhat.com>
 <20250402105746.FMPvRBwL@linutronix.de>
 <20250402112308.GF22091@redhat.com>
 <20250402121315.UdZVK1JE@linutronix.de>
 <20250402121850.GI22091@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250402121850.GI22091@redhat.com>

On 2025-04-02 14:18:51 [+0200], Oleg Nesterov wrote:
> On 04/02, Sebastian Sewior wrote:

I need to tell mutt to replace my name in case it is misspelled.

> > The preempted ri_timer() could stall a read_seqcount_begin().
> 
> Again, nobody use read_seqcount_begin(utask->ri_seqcount).
> 
> free_ret_instance() uses raw_seqcount_try_begin(utask->ri_seqcount),
> which, since ri_seqcount is seqcount_t, is just smp_load_acquire().
> This can't stall.

Yes. This would work for here just to skip the check because of all
details that are hard to express. Therefore I suggested to use
raw_write_seqcount_begin() instead of write_seqcount_begin() in
20250402122158.j_8VoHQ-@linutronix.de. Would that work?

> Oleg.

Sebastian

