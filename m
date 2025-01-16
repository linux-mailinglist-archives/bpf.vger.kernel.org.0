Return-Path: <bpf+bounces-49017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F405DA1314B
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 03:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1806D16581D
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 02:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F081F7081C;
	Thu, 16 Jan 2025 02:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnP5tkrl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B380750285
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 02:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736994053; cv=none; b=Z3VkXybbAEqn/xGsOx9ZK+I/n7eIGaXtpjMoKZicErVauHcUBEiseWvEKUH+zvsqaFeQNktk+DhlQfUbu/HGMvrIzcaHQK6L/+oLSE4FFDmwNzi64m5WoOq7XM95/rYQppzxDChI8SKTsO2mmujM89eZBZOa2ltpCjzqXhuApus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736994053; c=relaxed/simple;
	bh=fbA4jaFG9T2sT/oXtnwld6beKed6AWg3NrH3Bc73Dl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rq4i6YeLeqg1XlT6/coetW8HS+N7W5GKw/syuBjPG22QxVDScXgHnEmbFPcC4zHXrU63yECv77wGAfsE+ag30JmgwO/q/0sd5bRgjtCjj/ijZJvH2eCbM2QRET6JKy/A8UIHhfnkwmKUe61OHIp6WJewMgTYs3WIWkMlr96V/P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnP5tkrl; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3862d6d5765so213344f8f.3
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 18:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736994050; x=1737598850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRlfV8HawfxpT8T4TI/pnqhjM8rBBcPb6CYaKC9QCFM=;
        b=XnP5tkrl/qQbZG3oNeLBPqa2mbT44NY88ZrrQbtE/0DEZKxcP2Zd7/xvJ2HGQ6uQu3
         PAIAIFush4i0vmZxiEVuugwq2aQUocaEbcYhf3dJxfAano/IBfW7WqUxkEF4bYzbf0+e
         strvGtQ+YJxKUliT1vofg6Bqaz7WGYMkxn6atsX79aqZF5yIzFvnUAcpQ3VfNZzhnkPt
         fPPs7Xay7uDRh7eG7LjmxIjV8t+yCDZnKcgiAEyN1Pbi6lqmcUnoYByTT/8p9V3iw3Ad
         Gsovq/uJTKiXeHqZso8jQljH/5BgJ5Mj3qeT6lh4ncKiN938PM7AbsDkZKCMMKBl7QlJ
         i/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736994050; x=1737598850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRlfV8HawfxpT8T4TI/pnqhjM8rBBcPb6CYaKC9QCFM=;
        b=UUdtFRmJqmGFCvv/xtGV8uIe9fuALYsrGIaPpogkwWeWDNYI71yDUz3qBLxTgAjS8n
         I2Ie7NKyPRZez7dvsFjJ6oEnx3vvtN8CyOq+XpzR0Cjb2UTorfrH2JR3upQDFmhlphAv
         XuBL9ZXfjAXRMO7z6K5s96GQ7S3PqBWlQHJHJG90Pv3R1aTbl0aeTphmRoG55FhguA/h
         uviKZ0unb/1cuFOiCPTA8fKdnx0zcXtrLp5XvcAaAl2XaLmv6bARyMqWPJKhyG/8uJJf
         /rFK+MnDh6Y89nCtXKRGJjpPX10IvooRSjfTwgEbqh1BfDuH/4/nHjLORG7eu89YEoqh
         f1yQ==
X-Gm-Message-State: AOJu0YztkBbOGcRDp9fiHKfF9qIVjgOJEPeWwqJ07s1EfBQI8j2rbh3n
	ryoRAXArjmvqvCG1Hvxh/6g0HDtRHa2zL+BdLlWaXsnVeS0cNlIpQkSWdQr7GdbaY6xagzahfbR
	P0dEiLijVixu1NyqAA41gVkNlcSE=
X-Gm-Gg: ASbGncuw0B/ofzni5Iq5x4p4AHrkmGMeBJEx803okTGV1aSwQ6i26lxPTeDm+ZFKdqb
	tZ9cEqX4PghPVyBTWEny9oFXX4dTd90dahrnTCymVUXwOkroTqmxtAg==
X-Google-Smtp-Source: AGHT+IH4UULK1HVLpczFGPJfQvxAuFwYt6Vz0YbS+lFQZfLRCjaI6ne7OABkBzzhchGKMb/a7imWAzY+HNYx20c31h0=
X-Received: by 2002:a5d:64ed:0:b0:38a:9f27:82f2 with SMTP id
 ffacd0b85a97d-38a9f278491mr15270330f8f.49.1736994049689; Wed, 15 Jan 2025
 18:20:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-4-alexei.starovoitov@gmail.com> <e6685465-9e72-4822-95a1-990f0893f206@suse.cz>
In-Reply-To: <e6685465-9e72-4822-95a1-990f0893f206@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 15 Jan 2025 18:20:36 -0800
X-Gm-Features: AbW1kvauJUoZ1NXXwEjf8FCxtWpfLGkbHhkR9AY0EL8FcloeCpiUIxyjHXnZdkU
Message-ID: <CAADnVQKxBDaoFxav_WCgQ7sDuV_esTgQVp4Ci+L3e3UCz98e3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/7] locking/local_lock: Introduce local_trylock_irqsave()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 6:22=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/15/25 03:17, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Similar to local_lock_irqsave() introduce local_trylock_irqsave().
> > This is inspired by 'struct local_tryirq_lock' in:
> > https://lore.kernel.org/all/20241112-slub-percpu-caches-v1-5-ddc0bdc27e=
05@suse.cz/
>
> Let's see what locking maintainers say about adding the flag to every
> local_lock even if it doesn't use the trylock operation.

As I replied to Sebastian there are very few users and
hot users of local_lock like networking use it in RT only.
local_lock_nested_bh() stays true nop in !RT.
This patch doesn't change it.
So active flag on !RT is not in critical path
(at least as much I could study the code)

> > Use spin_trylock in PREEMPT_RT when not in hard IRQ and not in NMI
> > and fail instantly otherwise, since spin_trylock is not safe from IRQ
> > due to PI issues.
> >
> > In !PREEMPT_RT use simple active flag to prevent IRQs or NMIs
> > reentering locked region.
> >
> > Note there is no need to use local_inc for active flag.
> > If IRQ handler grabs the same local_lock after READ_ONCE(lock->active)
>
> IRQ handler AFAICS can't do that since __local_trylock_irqsave() is the o=
nly
> trylock operation and it still does local_irq_save(). Could you have adde=
d a
> __local_trylock() operation instead? Guess not for your use case because =
I
> see in Patch 4 you want to use the local_unlock_irqrestore() universally =
for
> sections that are earlier locked either by local_trylock_irqsave() or
> local_lock_irqsave(). But I wonder if those can be changed (will reply on
> that patch).

Pasting your reply from patch 4 here to reply to both...

Yes, I'm only adding local_trylock_irqsave() and not local_trylock(),
since memcg and slab are using local_lock_irqsave() in numerous
places, and adding local_trylock() here would be just dead code.

> The motivation in my case was to avoid the overhead of irqsave/restore on
> !PREEMPT_RT. If there was a separate "flavor" of local_lock that would
> support the trylock operation, I think it would not need the _irq and
> _irqsave variants at all, and it would also avoid adding the "active" fla=
g
> on !PREEMPT_RT. Meanwhile on PREEMPT_RT, a single implementation could
> likely handle both flavors with no downsides?

I agree with the desire to use local_lock() in slab and memcg long term,
but this is something that definitely should _not_ be done in this patch se=
t.
try_alloc_page() needs to learn to walk before we teach it to run.

> The last line can practially only happen on RT, right? On non-RT irqsave
> means we could only fail the trylock from a nmi and then we should have
> gfp_flags that don't allow spinning.

Correct.

> So suppose we used local_trylock(), local_lock() and local_unlock()  (no
> _irqsave) instead, as I mentioned in reply to 3/7. The RT implementation
> would be AFAICS the same. On !RT the trylock could now fail from a IRQ
> context in addition to NMI context, but that should also have a gfp_mask
> that does not allow spinning, so it should work fine.

Also correct.

> It would however mean converting all users of the lock, i.e. also
> consume_obj_stock() etc., but AFAIU that will be necessary anyway to have
> opportunistic slab allocations?

Exactly. And as soon as we do that we start to conflict between trees.
But the main concern is that change like that needs to be
thoroughly analyzed.
I'm not convinced that stock_lock as preempt_disable() will work for memcg.

People do GFP_NOWAIT allocations from IRQ and assume it works.
If memcg local_irqsave (aka local_lock_irqsave) is replaced
with preempt_disable the IRQ can happen in the middle of memcg
update of the counters,
so ALL of stock_lock operations would have to local_TRYlock()
with fallback in case IRQ kmalloc(GFP_NOWAIT) happens to reenter.

Same issue with slub.
local_lock_irqsave(&s->cpu_slab->lock)
as irq disabled region works for kmalloc(GPF_NOWAIT) users.
If it becomes preempt_disable I suspect it will break things.

Like perf and bpf use irq_work do wakeups and allocations.
slub's s->cpu_slab protected by preempt_disable
would mean that 'perf record -a' will be triggering in the
middle of slab partial, deactivate slab logic and
perf will be doing wakups right there. I suspect it will be sad.
While right now irq work handler will be called only
after the last local_unlock_irqrestore enables irqs.

So replacing local_lock_irqsave in slab and memcg with
local_lock is not something to take lightly.

