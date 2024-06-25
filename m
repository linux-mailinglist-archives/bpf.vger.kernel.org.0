Return-Path: <bpf+bounces-33068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CBC916D63
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 17:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C0D28EB39
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5727416F906;
	Tue, 25 Jun 2024 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SXBBXu9s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ls3DiFrg"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8954E153506;
	Tue, 25 Jun 2024 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330438; cv=none; b=Q9pOW+hE2QP4I5BqNoLj0pQoLw3sEMUtzDn4ugSQ0H8scOEK1NUWi22oMBRej/bUCy/EfXoKig8yY3R0ICMJUNYcuYddFV5b2KsQAgnsgCL13lbGfcNnZUI6Jyw4QUvzWVL/uPRQ1mK23K7hizotCk5Oa/37jnGkuwLusvX5DHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330438; c=relaxed/simple;
	bh=hfBquKQniv9noN02gtpMGU8burun9BThFhklk1tfuNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l65MsGGYnJ+VAjUMnuD6joHZJ0wPC+c/fLTVMomgs7S1gZKdafBWgKfh+qvsowHiEtSveGz7n06YaxS2Zb64DTWK6jXaCV7neVeW3dG3dKiGsc+8dzEkVOME1mWFwEbo0NE3I0Pu/xJajTkykb4FM28lFZemvLmh2UAW8nDO17I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SXBBXu9s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ls3DiFrg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719330435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mgoZS8cRFnMTN3N+2tTfMzAEhQwWUBVYpDta13n2FZs=;
	b=SXBBXu9sgDiCJWI98b9gPhyEynjeYdoWNeEK2+C5pCEDKFuyAo1ZH+sMTtoLFdejApS7Ty
	CN3XxOpmQDuprLWn1rOlc3ynKFuUQsMoQfjmQGuEw/7T+/RohEhhZSv3tpRMN3rxAmT+Ji
	oge7wi2zV/sx2hR07PeWL7xosOe/2WZO8CzlhKBaDaGGA9llHFY44GDSYPFd/r3CUZdigz
	qhL2PTUawuWWwJIYC+3ZevhmLBCFrdHCCTqJ1Z9DgO/J8Bl0rrKLhVm/RN2Lf54YX72cIg
	MBEiSmI/UEQ57hhqODGMZ+ngtv2CPooVeGR3WlQdeOb5lUtKmVOwhxf+zRDFcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719330435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mgoZS8cRFnMTN3N+2tTfMzAEhQwWUBVYpDta13n2FZs=;
	b=Ls3DiFrgC56nrOQjTn4ehzlGNFI8Iela0MhcRPfdj2DaWC8iCC1xsxo67bVSCLE/uYr7vR
	YhIinKlTJ1cPEtAA==
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Petr Mladek
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: defer printk() inside __bpf_prog_run()
In-Reply-To: <60704acc-61bd-4911-bb96-bd1cdd69803d@I-love.SAKURA.ne.jp>
References: <345098dc-8cb4-4808-98cf-fa9ab3af4fc4@I-love.SAKURA.ne.jp>
 <87ed8lxg1c.fsf@jogness.linutronix.de>
 <60704acc-61bd-4911-bb96-bd1cdd69803d@I-love.SAKURA.ne.jp>
Date: Tue, 25 Jun 2024 17:53:14 +0206
Message-ID: <87ikxxxbwd.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-06-26, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> On 2024/06/25 23:17, John Ogness wrote:
>> On 2024-06-25, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>>> syzbot is reporting circular locking dependency inside __bpf_prog_run(),
>>> for fault injection calls printk() despite rq lock is already held.
>>>
>>> Guard __bpf_prog_run() using printk_deferred_{enter,exit}() (and
>>> preempt_{disable,enable}() if CONFIG_PREEMPT_RT=n) in order to defer any
>>> printk() messages.
>> 
>> Why is the reason for disabling preemption?
>
> Because since kernel/printk/printk_safe.c uses a percpu counter for deferring
> printk(), printk_safe_enter() and printk_safe_exit() have to be called from
> the same CPU. preempt_disable() before printk_safe_enter() and preempt_enable()
> after printk_safe_exit() guarantees that printk_safe_enter() and
> printk_safe_exit() are called from the same CPU.

Yes, but we already have cant_migrate(). Are you suggesting there are
configurations where cant_migrate() is true but the context can be
migrated anyway?

John

