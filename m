Return-Path: <bpf+bounces-48902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D02EA11739
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 03:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5031883514
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 02:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C26822E3F1;
	Wed, 15 Jan 2025 02:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyK/n8zR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F8522DF91
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 02:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736907818; cv=none; b=pqNBQ8G81Q4UJxw11U2OA+XKUq2jN3aHslcPT5eUHnOdS27rjDLDBCjI95WH3/y1Ly0rrTAl5vyFZ6gzS86+M6G2bWoo1dmdUVH0BTSqu4m9lyUQJAgoQetw0GOaLcUUOVvHO8mc0DR7pzX/UGNjKzkH+Y2FnlooaO6rDHJMGek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736907818; c=relaxed/simple;
	bh=dIxJ7+g80k7xN5gqicaMASDNttT5A00fNKofl9TbUlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOIx+tVgr5HwlFHZhxCiacIDGpEgiBEgK/YIhpNkOy04O0qBUjuMNuRPgXA5xLsOVspNROmvgA5sr5c/WqKw+jkXxFF1eJPzjBDnDRifCeg3UrQgcrsv7epn1p53sNErXB5TB5UgNpwSnOU6sGYxbjTz/eaM6k6c09dNOyw+QXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyK/n8zR; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38637614567so2974350f8f.3
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 18:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736907815; x=1737512615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBELE3X2SMyc3MQcTfgyuVEYPx80Dr26GwrfXs8KHHI=;
        b=FyK/n8zR3CYlH0IqKnXRMTM11ukH84cZP8KMKyqmdmu8jmH8ZGLetpOBIobXjxhImR
         VuoN++oKPWou68R7xmvw1ESFR2FtHEOQIcu1xdf8csih27+wtlqyaclH2zXoz2vDx0w5
         jIzkii4dBsyMOrWLBU+mzJXPM4K0i3K0wqZZ45o7uQTDJerhrlALgw2MW5b+TRpr7UGV
         cGaftT6lt6QAhDpw4J/DYI81bgkpRCCuUulB+RcZBG3NhZZsu6eftvE0QyUAWJQ85D4l
         SSGH3UI+oiRd3xbJlAMW5fg8B4SnilbdKAtXKet2J+/sikMoXBBaykhRTSolzv7JHsxQ
         aINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736907815; x=1737512615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBELE3X2SMyc3MQcTfgyuVEYPx80Dr26GwrfXs8KHHI=;
        b=KwC5b1KmDSJegDduLMdbsG+wxi3ONk5qD7DAdWjRzqGAWHFHbAiSjuJrNHnKngmZtX
         O7jRU0BphdzFZocbCG+HFjRcQkZvtWN2udho/VmrJ4nregHDIUW3nO/mac7fl2CO4YUx
         5Gw3wLN6rk6Lz9ZFXg9Rbn1FkSdko1Kt2kyr5rklQ9gq/7+vLXTpZ2cZN0fDkAGBqSVH
         Eqe2Aafy5dQKlpiRd0yiH2YSsAMOvfW9Se2RgG6YDxaDQ9MFwA+xsDy6+oLUXBcz5ppZ
         FkUCyCVBbJu5bDVm8L+781Q500aevSdjWo246Gbd4A1fqHZCMClusmChSVaezMf7Vw0J
         jlKw==
X-Gm-Message-State: AOJu0YwxbvSlcMdyQiYug0PcuQ5pfU/laG09cMvZwjZr1IPRWamI/qY5
	T7h5A5uRItZ8IwZStP2Ia60SMSi1PREQw0U8HFcepCLu5zQamxKpkbL3I2EzTORvXhBAXyurTfS
	uucX4ng4N+CADGR1uqwn3Tu9oILo3wOx4
X-Gm-Gg: ASbGncsOFpkFEcbI5yqjPsEo5MAEute1lVSPOr2JWwhFq6XP/r7xKtSMKJn0Rw4r6mO
	59f7ZaNC/Kbv4sCrmJDMf4pY9acRP75L05K33NmBQq+0qH8rtAkOh2A==
X-Google-Smtp-Source: AGHT+IFty0foJe60xmSvupYhhse18eyk3EN8EjMD86WVUwloMtbCpwcJm5NueA8gMdYKKXKopGj8DS3tftFF9TYpGOE=
X-Received: by 2002:a5d:5f52:0:b0:385:fa2e:a33e with SMTP id
 ffacd0b85a97d-38a8733a284mr24871047f8f.43.1736907814624; Tue, 14 Jan 2025
 18:23:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com> <20250115021746.34691-4-alexei.starovoitov@gmail.com>
In-Reply-To: <20250115021746.34691-4-alexei.starovoitov@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Jan 2025 18:23:21 -0800
X-Gm-Features: AbW1kvbtCTgZp92cF7D97Rt4YDzwJOgeAm26rHANr0zM9wy90QvXZf0H5wZaYbo
Message-ID: <CAADnVQKJVWxaOMM=-faRh=1TBK=HNm8iOWD536Q_65+W4X=gVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/7] locking/local_lock: Introduce local_trylock_irqsave()
To: bpf <bpf@vger.kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 6:18=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Similar to local_lock_irqsave() introduce local_trylock_irqsave().
> This is inspired by 'struct local_tryirq_lock' in:
> https://lore.kernel.org/all/20241112-slub-percpu-caches-v1-5-ddc0bdc27e05=
@suse.cz/
>
> Use spin_trylock in PREEMPT_RT when not in hard IRQ and not in NMI
> and fail instantly otherwise, since spin_trylock is not safe from IRQ
> due to PI issues.
>
> In !PREEMPT_RT use simple active flag to prevent IRQs or NMIs
> reentering locked region.
>
> Note there is no need to use local_inc for active flag.
> If IRQ handler grabs the same local_lock after READ_ONCE(lock->active)
> already completed it has to unlock it before returning.
> Similar with NMI handler. So there is a strict nesting of scopes.
> It's a per cpu lock. Multiple cpus do not access it in parallel.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/local_lock.h          |  9 ++++
>  include/linux/local_lock_internal.h | 76 ++++++++++++++++++++++++++---
>  2 files changed, 78 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
> index 091dc0b6bdfb..84ee560c4f51 100644
> --- a/include/linux/local_lock.h
> +++ b/include/linux/local_lock.h
> @@ -30,6 +30,15 @@
>  #define local_lock_irqsave(lock, flags)                                \
>         __local_lock_irqsave(lock, flags)
>
> +/**
> + * local_trylock_irqsave - Try to acquire a per CPU local lock, save and=
 disable
> + *                        interrupts. Always fails in RT when in_hardirq=
 or NMI.
> + * @lock:      The lock variable
> + * @flags:     Storage for interrupt flags
> + */
> +#define local_trylock_irqsave(lock, flags)                     \
> +       __local_trylock_irqsave(lock, flags)
> +
>  /**
>   * local_unlock - Release a per CPU local lock
>   * @lock:      The lock variable
> diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lo=
ck_internal.h
> index 8dd71fbbb6d2..93672127c73d 100644
> --- a/include/linux/local_lock_internal.h
> +++ b/include/linux/local_lock_internal.h
> @@ -9,6 +9,7 @@
>  #ifndef CONFIG_PREEMPT_RT
>
>  typedef struct {
> +       int active;
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>         struct lockdep_map      dep_map;
>         struct task_struct      *owner;
> @@ -22,7 +23,7 @@ typedef struct {
>                 .wait_type_inner =3D LD_WAIT_CONFIG,      \
>                 .lock_type =3D LD_LOCK_PERCPU,            \
>         },                                              \
> -       .owner =3D NULL,
> +       .owner =3D NULL, .active =3D 0

Sebastian,

could you please review/ack this patch ?

I looked through all current users of local_lock and the extra active
flag will be in the noise in all cases.
So I don't see any runtime/memory concerns
while extra lockdep_assert to catch reentrance issues
in RT and !RT will certainly help long term.

