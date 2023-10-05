Return-Path: <bpf+bounces-11467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BD67BA877
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 19:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1ABCA281E58
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 17:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282833B79A;
	Thu,  5 Oct 2023 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QG9Z+2VT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875C33AC08
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 17:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97C9C433C8
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 17:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696528350;
	bh=w8Gh+PfMZMxfbaUwjLyhNTHT+fMaO1iA/RX9rKdlABc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QG9Z+2VTx1nuuU7Suymmyq/gsg+huv6QDhjTCQKGwGzPCy8clo+R2p/yFY3LmtZTv
	 b43HQjJovDtUUam0GhmydLGLs24vxQc0z/w7H06HuyW7LwKCLijdblpBZuzcSHZ1yT
	 L7OHiHtPxi3524l5wuyzjwxXxRReoURuc4f+ftTcUCKErSVNX1aJ68x/Ixtr58dGgs
	 vGb9mSP6CImdnDTLLJK/ThL+9BoQk1wC8kOLAYUNCGjmDMxWiGSlqzq3FbXUwm4dtF
	 sf948wUGhebdBE9PujjzBb0vrmf3GOaZA9eIm2bynd6QYZDcA6S6rTJjWE3h2/stVT
	 sX0otTtbXIWyQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-503056c8195so1682191e87.1
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 10:52:30 -0700 (PDT)
X-Gm-Message-State: AOJu0YwCxvjQ/MZnHLRBwPxjhgFmtnkYSNvZpTD/HTgqLEpibZqwq5fd
	ZDUGFRVxC5x0IZrJuPDcJsCK/Daofl4EUW/Y3do=
X-Google-Smtp-Source: AGHT+IHeiFJHNwCexB61ZHWFFw8nA3mCY0A7DbwTH+S1u9KPctEumVQZ69NZWVg8p/osgIlbAmn9oKk7MRjkZGQ/9/s=
X-Received: by 2002:a05:6512:304b:b0:500:9969:60bf with SMTP id
 b11-20020a056512304b00b00500996960bfmr6028641lfb.68.1696528349116; Thu, 05
 Oct 2023 10:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005063152.3205800-1-song@kernel.org>
In-Reply-To: <20231005063152.3205800-1-song@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 5 Oct 2023 10:52:16 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5ZN+Pkqpj_8_XjWaoZO3E-pcb0d1fU_owu41kJTVxBiQ@mail.gmail.com>
Message-ID: <CAPhsuW5ZN+Pkqpj_8_XjWaoZO3E-pcb0d1fU_owu41kJTVxBiQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] bpf: Avoid unnecessary -EBUSY from htab_lock_bucket
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 4, 2023 at 11:32=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> htab_lock_bucket uses the following logic to avoid recursion:
>
> 1. preempt_disable();
> 2. check percpu counter htab->map_locked[hash] for recursion;
>    2.1. if map_lock[hash] is already taken, return -BUSY;
> 3. raw_spin_lock_irqsave();
>
> However, if an IRQ hits between 2 and 3, BPF programs attached to the IRQ
> logic will not able to access the same hash of the hashtab and get -EBUSY=
.
> This -EBUSY is not really necessary. Fix it by disabling IRQ before
> checking map_locked:
>
> 1. preempt_disable();
> 2. local_irq_save();
> 3. check percpu counter htab->map_locked[hash] for recursion;
>    3.1. if map_lock[hash] is already taken, return -BUSY;
> 4. raw_spin_lock().
>
> Similarly, use raw_spin_unlock() and local_irq_restore() in
> htab_unlock_bucket().
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Song Liu <song@kernel.org>

This still doesn't look right. Let me try more..

Thanks,
Song

>
> ---
> Changes in v3:
> 1. Use raw_local_irq_* APIs instead.
>
> Changes in v2:
> 1. Use raw_spin_unlock() and local_irq_restore() in htab_unlock_bucket().
>    (Andrii)
> ---
>  kernel/bpf/hashtab.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index a8c7e1c5abfa..74c8d1b41dd5 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -155,13 +155,15 @@ static inline int htab_lock_bucket(const struct bpf=
_htab *htab,
>         hash =3D hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets=
 - 1);
>
>         preempt_disable();
> +       raw_local_irq_save(flags);
>         if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) !=
=3D 1)) {
>                 __this_cpu_dec(*(htab->map_locked[hash]));
> +               raw_local_irq_restore(flags);
>                 preempt_enable();
>                 return -EBUSY;
>         }
>
> -       raw_spin_lock_irqsave(&b->raw_lock, flags);
> +       raw_spin_lock(&b->raw_lock);
>         *pflags =3D flags;
>
>         return 0;
> @@ -172,8 +174,9 @@ static inline void htab_unlock_bucket(const struct bp=
f_htab *htab,
>                                       unsigned long flags)
>  {
>         hash =3D hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets=
 - 1);
> -       raw_spin_unlock_irqrestore(&b->raw_lock, flags);
> +       raw_spin_unlock(&b->raw_lock);
>         __this_cpu_dec(*(htab->map_locked[hash]));
> +       raw_local_irq_restore(flags);
>         preempt_enable();
>  }
>
> --
> 2.34.1
>

