Return-Path: <bpf+bounces-21965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EF785490C
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 13:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1AB286379
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 12:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101B71BC4F;
	Wed, 14 Feb 2024 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2x9mLRTP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Khnhbq7L"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AED11BC2F;
	Wed, 14 Feb 2024 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707913166; cv=none; b=OgRUZAfRWLtStVzFpxkoUDG4M6t+UOncjLYKg81SN+khwnvxF5Z6859Skyr32Dy7zs/3+q5smEsIzrm3VBvjmQYbBlCKnFnwKlNpEwgMTOLI2cd2uuOJ6l2ln1ZFwN9g5pHPFNFdyW6f9q8PLtmKLPZt4WJuadf924kwZ6GmL7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707913166; c=relaxed/simple;
	bh=VgFeoYyTB4fn3435l7WNNWsNs0bJNnj0aE0QV7uVYy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z81QbT+Sct1EY9BZxSFtZJdHCJFhejovXzfAdx/rxIwr0+GXW8iC5bDuc5BYXKGrYqqWCC1JwmZ1XZV6ydkRc73kcO2cG0+IFWuVe6lxh1tMrdq/iwiYwDaQrDGeZZETzuuQT2eg/KjNgWbgq9x14KAeV700B4eVhPaZmh27qMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2x9mLRTP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Khnhbq7L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Feb 2024 13:19:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707913163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K4Y44MKuxNKwjsBvggpladPTLai1AztGkC2oP6HBP0I=;
	b=2x9mLRTPYvCPfThzEsLM9wIoIp3+23uqIZ1CCb1yEfYQwHDZuh09vTbnJ3a4K9jT6Ih984
	noxdijAYxCmf6lk8okSNBUODqXLUI5uNyILdRNbDwKWYVx9446upq34AqrThrmRYwK9PZs
	KjtLRuoDD22cc1gyWLm+5scsTBDFvpNcjF03ASg60UozLRhadoz2XtlB9txB6x3lMQ6fCY
	fHrOZVh6brjFoBf2KhrrU7atfIThlQxH3jJTuIf3bPtVJUXSnOSy78NlB7CYmeH/klNUnT
	2Pz+FwinXlSgoqWy0K6tdFXjAQ3d1WCZnxPzEcF8UD8dJe3jR3XsgZLBy5ccIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707913163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K4Y44MKuxNKwjsBvggpladPTLai1AztGkC2oP6HBP0I=;
	b=Khnhbq7Lh0wJ4EGBruHaGdcV144e59NZFAjOkxrUsBKs5GNcBYVAqdCde71u/H3NbZBvhb
	FyiWIjgVLe7uBPCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240214121921.VJJ2bCBE@linutronix.de>
References: <20240213145923.2552753-1-bigeasy@linutronix.de>
 <20240213145923.2552753-2-bigeasy@linutronix.de>
 <66d9ee60-fbe3-4444-b98d-887845d4c187@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66d9ee60-fbe3-4444-b98d-887845d4c187@kernel.org>

On 2024-02-13 21:50:51 [+0100], Jesper Dangaard Brouer wrote:
> I generally like the idea around bpf_xdp_storage.
> 
> I only skimmed the code, but noticed some extra if-statements (for
> !NULL). I don't think they will make a difference, but I know Toke want
> me to test it...

I've been looking at the assembly for the return value of
bpf_redirect_info() and there is a NULL pointer check. I hoped it was
obvious to be nun-NULL because it is a static struct.

Should this become a problem I could add
"__attribute__((returns_nonnull))" to the declaration of the function
which will optimize the NULL check away.

> I'll hopefully have time to look at code closer tomorrow.
> 
> --Jesper

Sebastian

