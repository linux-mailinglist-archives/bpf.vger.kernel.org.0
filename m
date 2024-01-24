Return-Path: <bpf+bounces-20249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A4F83B07E
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 18:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316E9280D46
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 17:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A32012BF17;
	Wed, 24 Jan 2024 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVS8cS4M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C60A12BF0A
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118677; cv=none; b=JdrmFGdSdqVD2Nd0YkmqsZbmP8whDkLFnNaqCMFzuI9jbITd7y5JM3s7fx917o/Z55qAnbNgImgGqYh1n0/3Ri3GlP5hu0+MPkncfoKagJjWQ/7L2XYCUtWGqAHrzeSkQGHKAQQ2nPUF4N8EKxbyV187WhhlVbDMzLhLu+NlnHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118677; c=relaxed/simple;
	bh=/OjtQ8SVJUnC8w5OB3pGOMPIShISm+TFw2/PRUexS7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZFFsZEFfMb22O0vyPLp4X9EnncgEHA6QXfeQ1qCWXXCAZGCKyULEcNXJH6h14JZcsZMtdEMJ3La3z9a15wsfhk1BBj+tiC2ccSsemtFM3lh2Hh5zjusfRBHRDIDfoU55/Ip0omNly+bRL/jDMr1uPbkZRKHzxhafIeVuCkHHVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVS8cS4M; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e7ddd999bso6612731e87.1
        for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 09:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706118673; x=1706723473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vV4whgz53++s4Iswtym+dgI3UfonWddVCaBcXx5RlVo=;
        b=FVS8cS4MK9hpkLLRrxMYceV/BacDoJpYN0QCgNrNx4fAbKGTU7DubMUFcv713kH6Lk
         ULAdOORE0S5fdOfB4pjYLuJX1K8yNfRsz+JduAVgdXY6Z2E+kFJRvF1LtPcL9mP0lCgl
         e3OvR2ARSwRCFrkw+GJSN1UabXhmemlTeINCBC0tK5KVMyimHHarZwDKJY2hhBUeEnQD
         v1XyZ8Z+zxu9XOsOc6NXaKLzoPC2XrUbYrYHTbLVpjbNxQHF+3F4XctCKL/n7Va0rySa
         /ue4mCCAMx8K5a7sC+9BNNtQuQ3PqoWaP8QPNioRuSMPQ6k3W44MtdhkfxMonYt14QJ2
         NW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118673; x=1706723473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vV4whgz53++s4Iswtym+dgI3UfonWddVCaBcXx5RlVo=;
        b=XtjjwsSG6Oipl2OBp0eX4msgTGGUfYHZkxmfJ6oQKjQcOk/ncBcOwIjHRYcx3z9tq0
         LU7AwWEmm3lWgFKEoA0Ke/iJBrmqPUozDpmcZC4noqUyjsomAxtLjGSXsB4SxwthhKxZ
         kG8rPvtP5xCk5R43PWR+FvMDDQSUbvo+lGOT8aSDSSqNA5PUbQbXkDebcOu9kzUxs/w9
         UJpa3rhLd+j5soVlPp4Q99gPAUikvVV82YtHRvp6jziae1tD06N9hvlxoRGYj5vR5vzX
         ZhHOjLbsOj2fZcTuP+gQsk8wVEb4t3WjaCf/qr5vmnlypupax3hUc37WH8Iv47Q6O6+o
         SKfA==
X-Gm-Message-State: AOJu0Yy4J//95NjKEUKcn3fOzOXgyBvXaMlaVVz9y+7iIPr/SzuILMFD
	2ieevoCSMDuKaDvNClUMWSu5NZjqu/xcJbzwwOo8G4pHOidBorM1lMOthwhPmuwewsNgZ5VrKSy
	CDPP5fMZNjwQM/J+gUHBuMqtZyxBSJu/4
X-Google-Smtp-Source: AGHT+IHzb6GbWEA2lAqeRgloqna/ZHXRQ78ItI/J72zPhDV1zTk5DSn9Zm/L4HGeFuXyRxYjKzkLgw7n7oXufXLheNc=
X-Received: by 2002:a05:6512:3403:b0:50e:7a9c:e1f1 with SMTP id
 i3-20020a056512340300b0050e7a9ce1f1mr4625999lfr.126.1706118672871; Wed, 24
 Jan 2024 09:51:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123152716.5975-1-laoar.shao@gmail.com> <20240123152716.5975-2-laoar.shao@gmail.com>
 <20240123182617.GA30071@maniforge> <CALOAHbCpWgcwKfoWAQdjwwFDpsqqW9Ordy3cGVTY4h4=sUYK5g@mail.gmail.com>
In-Reply-To: <CALOAHbCpWgcwKfoWAQdjwwFDpsqqW9Ordy3cGVTY4h4=sUYK5g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Jan 2024 09:50:59 -0800
Message-ID: <CAEf4BzYjiNXibJBMERYLKy9em2k3HyXgxD2x=j+FRceUDmzfhw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/3] bpf: Add bpf_iter_cpumask kfuncs
To: Yafang Shao <laoar.shao@gmail.com>
Cc: David Vernet <void@manifault.com>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 1:31=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Wed, Jan 24, 2024 at 2:26=E2=80=AFAM David Vernet <void@manifault.com>=
 wrote:
> >
> > On Tue, Jan 23, 2024 at 11:27:14PM +0800, Yafang Shao wrote:
> > > Add three new kfuncs for bpf_iter_cpumask.
> > > - bpf_iter_cpumask_new
> > >   KF_RCU is defined because the cpumask must be a RCU trusted pointer
> > >   such as task->cpus_ptr.
> > > - bpf_iter_cpumask_next
> > > - bpf_iter_cpumask_destroy
> > >
> > > These new kfuncs facilitate the iteration of percpu data, such as
> > > runqueues, psi_cgroup_cpu, and more.
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >
> > Thanks for working on this, this will be nice to have!
> >
> > > ---
> > >  kernel/bpf/cpumask.c | 82 ++++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 82 insertions(+)
> > >
> > > diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> > > index 2e73533a3811..474072a235d6 100644
> > > --- a/kernel/bpf/cpumask.c
> > > +++ b/kernel/bpf/cpumask.c
> > > @@ -422,6 +422,85 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct =
cpumask *cpumask)
> > >       return cpumask_weight(cpumask);
> > >  }
> > >
> > > +struct bpf_iter_cpumask {
> > > +     __u64 __opaque[2];
> > > +} __aligned(8);
> > > +
> > > +struct bpf_iter_cpumask_kern {
> > > +     struct cpumask *mask;
> > > +     int cpu;
> > > +} __aligned(8);
> >
> > Why do we need both of these if we're not going to put the opaque
> > iterator in UAPI?
>
> Good point! Will remove it.
> It aligns with the pattern seen in
> bpf_iter_{css,task,task_vma,task_css}_kern, suggesting that we should
> indeed eliminate them.
>

It feels a bit cleaner to have API-oriented (despite being unstable
and coming from vmlinux.h) iter struct like bpf_iter_cpumask with just
"__opaque" field. And then having _kern variant with actual memory
layout. Technically _kern struct could grow smaller.

I certainly wanted this split for bpf_iter_num as that one is more of
a general purpose and stable struct. It's less relevant for more
unstable iters here.

> >
> > > +
> > > +/**
> > > + * bpf_iter_cpumask_new() - Create a new bpf_iter_cpumask for a spec=
ified cpumask
> > > + * @it: The new bpf_iter_cpumask to be created.
> > > + * @mask: The cpumask to be iterated over.
> > > + *
> > > + * This function initializes a new bpf_iter_cpumask structure for it=
erating over
> > > + * the specified CPU mask. It assigns the provided cpumask to the ne=
wly created
> > > + * bpf_iter_cpumask @it for subsequent iteration operations.
> > > + *
> > > + * On success, 0 is returen. On failure, ERR is returned.
> > > + */
> > > +__bpf_kfunc int bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, co=
nst struct cpumask *mask)
> > > +{
> > > +     struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> > > +
> > > +     BUILD_BUG_ON(sizeof(struct bpf_iter_cpumask_kern) > sizeof(stru=
ct bpf_iter_cpumask));
> > > +     BUILD_BUG_ON(__alignof__(struct bpf_iter_cpumask_kern) !=3D
> > > +                  __alignof__(struct bpf_iter_cpumask));
> >
> > Why are we checking > in the first expression instead of just plain
> > equality?
>
> Similar to the previous case, it aligns with others. Once we eliminate
> the struct bpf_iter_cpumask_kern, we can safely discard these
> BUILD_BUG_ON() statements as well.
>
> >
> > > +
> > > +     kit->mask =3D bpf_mem_alloc(&bpf_global_ma, sizeof(struct cpuma=
sk));
> >
> > Probably better to use cpumask_size() here.
>
> will use it.
>
> >
> > > +     if (!kit->mask)
> > > +             return -ENOMEM;
> > > +
> > > +     cpumask_copy(kit->mask, mask);
> > > +     kit->cpu =3D -1;
> > > +     return 0;
> > > +}
> > > +
> > > +/**
> > > + * bpf_iter_cpumask_next() - Get the next CPU in a bpf_iter_cpumask
> > > + * @it: The bpf_iter_cpumask
> > > + *
> > > + * This function retrieves a pointer to the number of the next CPU w=
ithin the
> > > + * specified bpf_iter_cpumask. It allows sequential access to CPUs w=
ithin the
> > > + * cpumask. If there are no further CPUs available, it returns NULL.
> > > + *
> > > + * Returns a pointer to the number of the next CPU in the cpumask or=
 NULL if no
> > > + * further CPUs.
> > > + */
> > > +__bpf_kfunc int *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it)
> > > +{
> > > +     struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> > > +     const struct cpumask *mask =3D kit->mask;
> > > +     int cpu;
> > > +
> > > +     if (!mask)
> > > +             return NULL;
> > > +     cpu =3D cpumask_next(kit->cpu, mask);
> > > +     if (cpu >=3D nr_cpu_ids)
> > > +             return NULL;
> > > +
> > > +     kit->cpu =3D cpu;
> > > +     return &kit->cpu;
> > > +}
> > > +
> > > +/**
> > > + * bpf_iter_cpumask_destroy() - Destroy a bpf_iter_cpumask
> > > + * @it: The bpf_iter_cpumask to be destroyed.
> > > + *
> > > + * Destroy the resource assiciated with the bpf_iter_cpumask.
> > > + */
> > > +__bpf_kfunc void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *i=
t)
> > > +{
> > > +     struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> > > +
> > > +     if (!kit->mask)
> > > +             return;
> > > +     bpf_mem_free(&bpf_global_ma, kit->mask);
> > > +}
> > > +
> > >  __bpf_kfunc_end_defs();
> > >
> > >  BTF_SET8_START(cpumask_kfunc_btf_ids)
> > > @@ -450,6 +529,9 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
> > >  BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
> > >  BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
> > >  BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
> > > +BTF_ID_FLAGS(func, bpf_iter_cpumask_new, KF_ITER_NEW | KF_RCU)
> > > +BTF_ID_FLAGS(func, bpf_iter_cpumask_next, KF_ITER_NEXT | KF_RET_NULL=
)
> > > +BTF_ID_FLAGS(func, bpf_iter_cpumask_destroy, KF_ITER_DESTROY)
> > >  BTF_SET8_END(cpumask_kfunc_btf_ids)
> > >
> > >  static const struct btf_kfunc_id_set cpumask_kfunc_set =3D {
> > > --
> > > 2.39.1
> > >
> > >
>
> --
> Regards
> Yafang

