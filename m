Return-Path: <bpf+bounces-73082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17846C22935
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 23:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFFE03BAE8B
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 22:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63B733BBA8;
	Thu, 30 Oct 2025 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO+UIa4o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ECD331A6D
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761863900; cv=none; b=g3Lz9tbHLU9vPVtk6pF9+ZWxW8t+70n9kdJcussNVCRHIQJtyrqvq1N2CTP29Tj6orFzLmfQwSZoiCZKVQKZbHeGkAkKTg3FQtTn2OyQKYWPd95yP0Qn6kE5fldDlxtx00rjZ1zTgOHgsDwlRNqnXD2LdMm69LFqFv6u4HcBYxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761863900; c=relaxed/simple;
	bh=rJQAWq+XjRqxja76Aq+TSm1F0DMkRb0mJTNn7fYmTXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=biu4A5mBsCwX7annyI66XfqpJmNr+deKOCj/Df9zKEfbeAXjfS7Kg+rxpNo6yWTvRi1fv6JKQ5g4ocfRjCS8ununN6h8NU2EOMVInzL6fSyBL+0Pgy2Ypz6nrKhHW5k2ps1ZxcfY4WQ5HtYp0jD6M45/I8IktWRVFlaFFJFGnOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kO+UIa4o; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-426fd62bfeaso742095f8f.2
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 15:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761863897; x=1762468697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wegkSekqGGUT4XWQzMNJtqpWRUXHy7Tf0VKql4UkVGc=;
        b=kO+UIa4oll1W3PmQnEPUrq9tq3NHR+xCBnoZIiUHA+vB5QfdM7cML8gZB4380FVFWk
         6fJj6Ci58+XYcH6+PDANksMjuRo9jeLgy1P7vH3H5uJp1zxtCVmODEa2ugVG1oSSrnV5
         qiqP0coFL5EMvmK+YdextWkm9pauocq+Ri4ZpxALJmigv/2TPLHOkPMunOsjcmWlSz6+
         Tr3Wdm9wGgQcX5KgeSlLwfb0f0GJA0UQ2CIR/x3KhMfEuLXQb9Xu20f8u8xp6XlFixeb
         MDXwECnHUJFtrMcOe0QvUyjnpPJzRKFoqJzsIrV8llyH/qNsO2bU1KN3BgGM3K+fOOow
         iHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761863897; x=1762468697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wegkSekqGGUT4XWQzMNJtqpWRUXHy7Tf0VKql4UkVGc=;
        b=CPojZm8IhxcKMi267De2/BQje5nOFvOnI2Y7Qq0qR9QutekPblpsxAUgRMxEorsThz
         P0UNDwdgw1nIMUHbw6c3zET4C/5lP9sSDNzHmxBDiYQCkFak5ZsgG6VygjtMcOe5YdO0
         eaivTFrNkKu0IsAqUnvJs+Eblsu903GCtQ7FrWMGO1urILRXeK3Z4VupleTxS6/YgagR
         Ld/jtoC5Elnc53dnMOg9UAOrbAMsz3aZ1QyT6IfbGeDlXDQT3ZfeL8K0GXnVIFQa0OXn
         I/XUEOizDy9yeu1gUnDGc+//efYUEYmoGWTk7pZB+zrJCfkj921IG2ggiAC27imaRuY4
         uYdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1kAaA9+8b6N28be7uTUgEspNdmbg8oUwkndYNrw8xxxEAs5Sf9EJAgDw5x96CcqUsIQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySY6b2ooKBvLx4V3feH8ZU9lU2GDlZbJGGt6S2XHU4AWLXmsFQ
	/wd2vRxUCqUTeLslViDmL3sk3WMrZCavrDVJlPxppM0blRQ0H8Qxrc3XfoJdjxFUTGjFvXph01v
	dk2HxkKgxJ2JYm19twebUSzp7QvW+N1c=
X-Gm-Gg: ASbGncse8LXEjYC9KR5rzc8jMYcViM6aIaHLNFs8CX1fz66Pd9FTKLBxC6CyvF3h6Wk
	33O0xp413kVFhOGW+Pcgpd0prPcubr92vN866ZiRCuMLaS53DMdHvfFCHoFKGGhJWD7dqL4sTVW
	bhcPLhomv66KVCmBlY5x0NrIt84UT3HxgE+ayPPpYtUJ5qgl3cR3nYizIhWMs9jdp1i2cCM40ZA
	KHZ0SPOM4v1bRxN+zvqQGmRP7rZIRJ61zKp8eJi21uvZj6FSIeezYO7gBp4b3tNQpre3qjDSC5V
	DCFTDrWmEQncfbnIOQ==
X-Google-Smtp-Source: AGHT+IFscxFW2ggLMAed0mcLjS+lTPXX/IYypIrwnI23PlvXCQXGwz8zeMmX8xN1ppTvvvdFYTwUzBStVAqGAO5MNc4=
X-Received: by 2002:a05:6000:430d:b0:428:3d1d:6d19 with SMTP id
 ffacd0b85a97d-429bd6e3c35mr975711f8f.47.1761863896907; Thu, 30 Oct 2025
 15:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030030010.95352-2-dongml2@chinatelecom.cn> <18b6f2c755710330b0c7399d17606a46c977f1ba3de4f37319aa1783638b1d2f@mail.kernel.org>
In-Reply-To: <18b6f2c755710330b0c7399d17606a46c977f1ba3de4f37319aa1783638b1d2f@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 30 Oct 2025 15:38:05 -0700
X-Gm-Features: AWmQ_bmL7lntft1GBOHR2IcVkzf9liFe42SBURFh4tzSUjIC9KTBL9QL13tu4yM
Message-ID: <CAADnVQKaUqRMvbno2RKo+kfK98377hkUjxSGMBV5qzgHOvkoMg@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: use rqspinlock for lru map
To: bot+bpf-ci@kernel.org
Cc: Menglong Dong <menglong8.dong@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Leon Hwang <leon.hwang@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, jiang.biao@linux.dev, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Chris Mason <clm@meta.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 8:38=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
>
> ```
> commit 8ae9fd98fe53c45a1a89adf6d254c2db90d26544
> Author: Menglong Dong <menglong8.dong@gmail.com>
>
> bpf: use rqspinlock for lru map
>
> This patch converts raw_spinlock_t to rqspinlock_t in BPF LRU maps to
> prevent NMI context deadlocks. The new lock API can fail gracefully
> instead of deadlocking, returning an error code.
>
> Link: https://lore.kernel.org/bpf/CAEf4BzbTJCUx0D=3Dzjx6+5m5iiGhwLzaP94hn=
w36ZMDHAf4-U_w@mail.gmail.com/
>
> > diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
> > index e7a2fc605..38fddcb1e 100644
> > --- a/kernel/bpf/bpf_lru_list.c
> > +++ b/kernel/bpf/bpf_lru_list.c
>
> [ ... ]
>
> > @@ -466,23 +470,26 @@ static struct bpf_lru_node *bpf_common_lru_pop_fr=
ee(struct bpf_lru *lru,
> >       do {
> >               steal_loc_l =3D per_cpu_ptr(clru->local_list, steal);
> >
> > -             raw_spin_lock_irqsave(&steal_loc_l->lock, flags);
> > +             if (raw_res_spin_lock_irqsave(&steal_loc_l->lock, flags))
> > +                     goto out_next;
> >
> >               node =3D __local_list_pop_free(steal_loc_l);
> >               if (!node)
> >                       node =3D __local_list_pop_pending(lru, steal_loc_=
l);
> >
> > -             raw_spin_unlock_irqrestore(&steal_loc_l->lock, flags);
> > +             raw_res_spin_unlock_irqrestore(&steal_loc_l->lock, flags)=
;
> >
> > +out_next:
> >               steal =3D cpumask_next_wrap(steal, cpu_possible_mask);
> >       } while (!node && steal !=3D first_steal);
> >
> >       loc_l->next_steal =3D steal;
> >
> >       if (node) {
> > -             raw_spin_lock_irqsave(&loc_l->lock, flags);
> > +             if (raw_res_spin_lock_irqsave(&loc_l->lock, flags))
> > +                     return NULL;
>                         ^^^^^^^^^^^
>
> Can this leak the node? At this point in bpf_common_lru_pop_free(),
> a node was successfully stolen from another CPU's list. The
> __local_list_pop_free() or __local_list_pop_pending() call removed
> the node from steal_loc_l, and steal_loc_l was unlocked. The node
> now exists but is not in any list.
>
> When raw_res_spin_lock_irqsave() fails here, the function returns
> NULL, but the stolen node is never added to the local pending list
> and never returned to any list. The node becomes orphaned.

AI is right. Here and in other places you can just leak the objects.
res_spin_lock() is not a drop-in replacement.
The whole thing needs to be thought through.

