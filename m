Return-Path: <bpf+bounces-33056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF99916A13
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 16:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C220C1C22551
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 14:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382CF169AD0;
	Tue, 25 Jun 2024 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Syo3/vBZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qnlv1E6Q"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F28BE71;
	Tue, 25 Jun 2024 14:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325075; cv=none; b=t1gDhpAsMY9b76+yhf+tcy4X2iX+mccWEUm1VWWUEh0KdGMM7kYcmtlUIhX5NZXYDRFJqUyaqDomfAhb4dKPm49UYK8dku29Z2n2+RTe+q+V3E1yIYDYhwmenFIkx2n5soN/w/m3/hgo86jKw9rUV84hIwnde7t5IG65CKAY7Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325075; c=relaxed/simple;
	bh=e0Xxg3bDdJc8OeBXVF1Qhji37otgW7Fb1gXHSU9f6nQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RVoIhwVwEjuAfn+q9MkheQAR+AFjkQXOxQweCV/m+xuMjgBs+LCDWROUggCvcn92snaZ9fuapRyDU+qVd8r4/01d7+la8Vk0GO+3nSc/zquniQ4SQHZHD5Ct7kQ+FfPyZ5ED6E6uPHXWB9QsjtSlqUP1oweCbCUmvJsx8jaPXpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Syo3/vBZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qnlv1E6Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719325072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e0Xxg3bDdJc8OeBXVF1Qhji37otgW7Fb1gXHSU9f6nQ=;
	b=Syo3/vBZppV+N4Yfd5J59zbH/jFH4hVQJ3Ec5X1ioqP4TmjBKwJuAjXcYiY7DpNzD3ZAjA
	PWAMeOGWeOPsHfstvWTdE/ScTw6NDVWh0A6k+MxgqJLGq3bo5sQ3ReyjAgXNx6lN7vCIvw
	H9V4xqAdI5FAwMtR+CLa8c6WjIKYg9uzJKfMFCkgMfFLn+oBVZhf/x+NegvgTJrqBRdV1j
	OhEnMU169ESQ11gwHGy0wFAPbh69Z7dlZ3bji4myaL7oze3+hFqZsArtPWStbzhoGECHXv
	Cb6/CB4APcsbtwc4KBUEBRxwiqJPm/biQ1LixL2HTz9dN1CDCUpT9AZ3Hdmjrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719325072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e0Xxg3bDdJc8OeBXVF1Qhji37otgW7Fb1gXHSU9f6nQ=;
	b=qnlv1E6QbDAsN0TCNUO8AGqWmgOtATmaBtF2bNZBh17dGTZVCoZm2sSTZB9vZKCfAm3K+a
	6ol4/GEE7R1tgzAQ==
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
In-Reply-To: <345098dc-8cb4-4808-98cf-fa9ab3af4fc4@I-love.SAKURA.ne.jp>
References: <345098dc-8cb4-4808-98cf-fa9ab3af4fc4@I-love.SAKURA.ne.jp>
Date: Tue, 25 Jun 2024 16:23:51 +0206
Message-ID: <87ed8lxg1c.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-06-25, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> syzbot is reporting circular locking dependency inside __bpf_prog_run(),
> for fault injection calls printk() despite rq lock is already held.
>
> Guard __bpf_prog_run() using printk_deferred_{enter,exit}() (and
> preempt_{disable,enable}() if CONFIG_PREEMPT_RT=n) in order to defer any
> printk() messages.

Why is the reason for disabling preemption?

John Ogness

