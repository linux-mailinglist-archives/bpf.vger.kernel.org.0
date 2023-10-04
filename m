Return-Path: <bpf+bounces-11345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1927B76C4
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 05:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 3043C1C204BF
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 03:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0361EC9;
	Wed,  4 Oct 2023 03:08:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9A5811
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 03:08:36 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEDBB0
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 20:08:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3231d67aff2so1632013f8f.0
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 20:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696388912; x=1696993712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqlFtl/G5BQpr2tECctPl2bwiyWMUcLexTINpMN1hm4=;
        b=bG8QwiJI0ieZPmM1zIdUaiCoDoYoIF4LWwuC+LkneHjc0UU2PL0/XqUYF9OmrkTeez
         TJBeHNTAoOd75Q7Xswm0eNtei6JWaKJfd0aPJbNDhEKaOZCs/DCvnnVPwLvUclfJhABk
         UTYfTNZOq6ntiY+6os4AVY4b4HIoYROnQR30Ov9ib++3dPRzyv8RNlshjFw+0rXsz+6C
         a2J+TGboCo33+BBkOXjDqNavqUdcP8T9k0hhmEbzTtnT3GHzn5X6lTmASdiYlh2xYB1C
         xunqeP9Bh+4pP0OXwnK/pfdkDZA2fvmtydqsL50ZxeEMeNGmVQzkGSSyyF6trZDTONxa
         WMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696388912; x=1696993712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqlFtl/G5BQpr2tECctPl2bwiyWMUcLexTINpMN1hm4=;
        b=PIXXYr+h25NBGvdoWOF3ccZlUq8WXjCvOzCGy0EnFNU3o4VhEVZY1Y6WEcDLF72xrn
         nWifNJYPKB313pGrBSoTuOz3ZNvT49LUcKhUW30QzFzgKVjswbRSb4Gyhz7xR5nmsYms
         yNVGMqdOwXmEalLHbplYKAddZZo9LsM4H3oPVGU56IoOseUia2/ygZQV4muFuslZCVnR
         2RTuajbAwyzeVvLUEd2I6szvXFDZC3C/73XZ6y7Ji4iJo4OfvshsmdXa2WdftDYOacdR
         Q60wITigUD60/1s7P/UJLIlr6uY1ZUSIXRb6090vroPaqcwo+59KDzAGpROAFYtCKe9x
         lyVw==
X-Gm-Message-State: AOJu0YzC2XlL/DF+GltG4FySmJ5YY/a+HEx29pZAyCszNGmQSNTLjdJP
	dW8pIkq4JpooA3qC8BiSFBTOA/c/FvUeCUkLZtcL484rxh8=
X-Google-Smtp-Source: AGHT+IERyU4A6E6y1LGe50inyQeVCM1l8oYp/F98xtBiicgS+fpOiJZjBP+dkS8m+qU6nqpwK5OHWLMqvffpUCmIYuo=
X-Received: by 2002:adf:f452:0:b0:31f:fed4:d79d with SMTP id
 f18-20020adff452000000b0031ffed4d79dmr829112wrp.30.1696388912113; Tue, 03 Oct
 2023 20:08:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231004004350.533234-1-song@kernel.org>
In-Reply-To: <20231004004350.533234-1-song@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Oct 2023 20:08:20 -0700
Message-ID: <CAEf4BzbM6yvBwT3-_7NkzKgqdoXc_G3+_5Fnv96b_2U68=Hunw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: Avoid unnecessary -EBUSY from htab_lock_bucket
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@kernel.org, kernel-team@meta.com, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 5:45=E2=80=AFPM Song Liu <song@kernel.org> wrote:
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
>
> ---
> Changes in v2:
> 1. Use raw_spin_unlock() and local_irq_restore() in htab_unlock_bucket().
>    (Andrii)
> ---
>  kernel/bpf/hashtab.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>

Now it's more symmetrical and seems correct to me, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index a8c7e1c5abfa..fd8d4b0addfc 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -155,13 +155,15 @@ static inline int htab_lock_bucket(const struct bpf=
_htab *htab,
>         hash =3D hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets=
 - 1);
>
>         preempt_disable();
> +       local_irq_save(flags);
>         if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) !=
=3D 1)) {
>                 __this_cpu_dec(*(htab->map_locked[hash]));
> +               local_irq_restore(flags);
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
> +       local_irq_restore(flags);
>         preempt_enable();
>  }
>
> --
> 2.34.1
>

