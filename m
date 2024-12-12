Return-Path: <bpf+bounces-46715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 760A89EEDAB
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 16:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26BB128B4FC
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 15:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8B2223C68;
	Thu, 12 Dec 2024 15:48:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAFD223C53
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018493; cv=none; b=lFzzvjlUy+0a/h/1hvdDKJm8XPyaxwOy3nIjynrnlq+CXbf3hkw6klIjGEswWnjWowT1tbA6jCgXHaoGBjYxuMD6d+O+pc+l9gp+Kks0MfY4nhpo1+DVmEHY/VblDY072lV7n25ZopfBFZ0FC1ujyxW05x0NH+Wyf9P7JtBsOb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018493; c=relaxed/simple;
	bh=JX8SHwmmwKGHeVuKS8zehWjTTaIB0FRtjcRkXRsuWHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYhUbJgY/+7ofccs0gM4O6hF7qqmUVdG/1XbXF/MTW2SInLAoDVdVM1jBWpZh3xb7hZs2ZTZVsBddLGP6OWE8MMVRgyFEdPR8l02HfZt2Gm1eQKYLYvzOb3EEXdyEtXfjXgbUPeC73U4VQG8uP11bi3W+zjh+T7gZz2YwEnZpvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E479AC4CED0;
	Thu, 12 Dec 2024 15:48:11 +0000 (UTC)
Date: Thu, 12 Dec 2024 10:48:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Sewior <bigeasy@linutronix.de>
Cc: Michal Hocko <mhocko@suse.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Matthew Wilcox <willy@infradead.org>, bpf
 <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 shakeel.butt@linux.dev, Thomas Gleixner <tglx@linutronix.de>, Tejun Heo
 <tj@kernel.org>, linux-mm <linux-mm@kvack.org>, Kernel Team
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
Message-ID: <20241212104809.1c6cb0a1@batman.local.home>
In-Reply-To: <20241212153506.dT1MvukO@linutronix.de>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
	<20241210023936.46871-2-alexei.starovoitov@gmail.com>
	<Z1fSMhHdSTpurYCW@casper.infradead.org>
	<Z1gEUmHkF1ikgbor@tiehlicka>
	<CAADnVQKj40zerCcfcLwXOTcL+13rYzrraxWABRSRQcPswz6Brw@mail.gmail.com>
	<20241212150744.dVyycFUJ@linutronix.de>
	<Z1r_eKGkJYMz-uwH@tiehlicka>
	<20241212153506.dT1MvukO@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Dec 2024 16:35:06 +0100
Sebastian Sewior <bigeasy@linutronix.de> wrote:

> If NMI is one of the possible calling contexts, yes.
>=20
> One thing I am not 100% sure about is how "good" a spinlock_t trylock is
> if attempted from hardirq (on PREEMPT_RT). Obtaining the lock und
> unlocking is doable. The lock part will assign the "current" task as the
> task that owns the lock now. This task is just randomly on the CPU while
> the hardirq triggered. The regular spin_lock() will see this random task
> as the owner and might PI-boost it. This could work=E2=80=A6

Looking at the unlock code, it and the slowtrylock() appears to use
raw_spin_lock_irqsave(). Hence it expects that it can be called from
irq disabled context. If it can be used in interrupt disabled context,
I don't see why it wouldn't work in actual interrupt context.

-- Steve

