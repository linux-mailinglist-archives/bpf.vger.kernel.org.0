Return-Path: <bpf+bounces-20208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A387883A578
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 10:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB2D1F2C682
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 09:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B071518021;
	Wed, 24 Jan 2024 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKY81KNW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1FC17C95
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088684; cv=none; b=salJ8Gk4hUWXCbK1/7IkKgIAV50h72WiP+iliNrVF/4tMMNYZbsa/Qi5SXNV9KqLV0ag6+d9TNmIAe1xUkk01Z60h8+yr7XxTOaZZfF5fBxtTzw3oijwvqgtqJ+UUWJWFI6pgfI4crWeqqighdPHF69B4oZ5s8k2K5LkXv7NMLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088684; c=relaxed/simple;
	bh=VcjtCKmRyDjlwi/+LfG7q4DgsMkoAI1uwNVf//GUZYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kT3EtXcrc6XN4YF+4oupZm9aV4jDiueNIFiCRKSSlXYcqO8UNXPojDSWO+ARgKfINeV6Nk5ZOf883ktMAsBEk5f5+uzpMzw5DNQup2CVB7bkn5vPLJM4Mxt3yFaXRD1cQHfnrFmKURotHPl/y427/HkVUxTaIrqNkUXbElgn+5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKY81KNW; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-683cabd9763so32194986d6.3
        for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 01:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706088681; x=1706693481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JF+WDp5n/Xr+KmBd7C5quLFJDFz6viThytIcVMN5xB8=;
        b=fKY81KNWW1a8kqjWeorP1Inya1f12Ue+kq3tKV/z2A6rzNSsu/8wPFEr1koWP5JfbA
         uAUSoUmuCBAUTaoB2KkuTSde4MBc0UmOpKAoqQIO1Vt/bDMGVwOfyPEVXt9DlsLY+uli
         DV0mY/tab4qvHp3jUx2rESpsXasaz8Ry2bMLdDe9wrhD/Ei8G898UebpYI3Fd/TBRuDH
         H8W+MktkIYNqmWdeAR4G+3xUmhA4AY66SR7tJ14XFmYk8ZQsNWGwNAO8j7tR3puf5MV9
         w/qFspGT9r4wk5sOhJy/VGahIdCATkCbyVuZqi0o/PIWeb26mD73tFKNIRlncMDMolza
         kKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706088681; x=1706693481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JF+WDp5n/Xr+KmBd7C5quLFJDFz6viThytIcVMN5xB8=;
        b=ZmmeObIG0pc3nhXKRoGSV824DAquXqI2PwuLWuPr7f88StwKAOPGL/PHb3TD+yWfHY
         klU1qHktDhJZXJLOGyU2Y4yEhgjR6AaOvpjOMjW7BT+F8F09xeR6zp/8GZTZIc6/P2NM
         ZHolTZX3n0bLfIJKOdPcQP2003OpdG+6TPAw/nN5c4R2tQl2csawcRkbyoxC6QkRGlf9
         Zr23tPE+Q8BdZV3+7hP8Hasw8sR+uNXss0Dc/W05njSgpNweL4uGoUeQQCJkIpd6MVJW
         2m9DaTrqlHbKMkSVaiL4dEOkvO512pvhNHaQSlHqBN0TUzOf0HxhwswSbF+iWT2/1Rme
         0nTw==
X-Gm-Message-State: AOJu0YweaSAGqItTwwaCVdbukYLe98emxr6SbrwQxp5T4oWNKW4QMSDL
	6yEnIy6qzlTheDEyQxZRZUYgvHu+gkagEDmK6PadJnkeKeEcYY78QSHRraxVsFgrrmVDUHvsoIY
	gaOgrxE5dgrRFr1VlswWSA0Kh1gw=
X-Google-Smtp-Source: AGHT+IGrBViDNOaLvtYPbLytI3ZdChyCqR+mCwpN/xKQMt+jfWT0Tz+FN25RaBlSGlnZPVmNTKUZvccHtKSecPT7IE0=
X-Received: by 2002:a05:6214:5099:b0:681:9ea:b99f with SMTP id
 kk25-20020a056214509900b0068109eab99fmr2760595qvb.57.1706088681481; Wed, 24
 Jan 2024 01:31:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123152716.5975-1-laoar.shao@gmail.com> <20240123152716.5975-2-laoar.shao@gmail.com>
 <20240123182617.GA30071@maniforge>
In-Reply-To: <20240123182617.GA30071@maniforge>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 24 Jan 2024 17:30:45 +0800
Message-ID: <CALOAHbCpWgcwKfoWAQdjwwFDpsqqW9Ordy3cGVTY4h4=sUYK5g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/3] bpf: Add bpf_iter_cpumask kfuncs
To: David Vernet <void@manifault.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 2:26=E2=80=AFAM David Vernet <void@manifault.com> w=
rote:
>
> On Tue, Jan 23, 2024 at 11:27:14PM +0800, Yafang Shao wrote:
> > Add three new kfuncs for bpf_iter_cpumask.
> > - bpf_iter_cpumask_new
> >   KF_RCU is defined because the cpumask must be a RCU trusted pointer
> >   such as task->cpus_ptr.
> > - bpf_iter_cpumask_next
> > - bpf_iter_cpumask_destroy
> >
> > These new kfuncs facilitate the iteration of percpu data, such as
> > runqueues, psi_cgroup_cpu, and more.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> Thanks for working on this, this will be nice to have!
>
> > ---
> >  kernel/bpf/cpumask.c | 82 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> >
> > diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> > index 2e73533a3811..474072a235d6 100644
> > --- a/kernel/bpf/cpumask.c
> > +++ b/kernel/bpf/cpumask.c
> > @@ -422,6 +422,85 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cp=
umask *cpumask)
> >       return cpumask_weight(cpumask);
> >  }
> >
> > +struct bpf_iter_cpumask {
> > +     __u64 __opaque[2];
> > +} __aligned(8);
> > +
> > +struct bpf_iter_cpumask_kern {
> > +     struct cpumask *mask;
> > +     int cpu;
> > +} __aligned(8);
>
> Why do we need both of these if we're not going to put the opaque
> iterator in UAPI?

Good point! Will remove it.
It aligns with the pattern seen in
bpf_iter_{css,task,task_vma,task_css}_kern, suggesting that we should
indeed eliminate them.

>
> > +
> > +/**
> > + * bpf_iter_cpumask_new() - Create a new bpf_iter_cpumask for a specif=
ied cpumask
> > + * @it: The new bpf_iter_cpumask to be created.
> > + * @mask: The cpumask to be iterated over.
> > + *
> > + * This function initializes a new bpf_iter_cpumask structure for iter=
ating over
> > + * the specified CPU mask. It assigns the provided cpumask to the newl=
y created
> > + * bpf_iter_cpumask @it for subsequent iteration operations.
> > + *
> > + * On success, 0 is returen. On failure, ERR is returned.
> > + */
> > +__bpf_kfunc int bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, cons=
t struct cpumask *mask)
> > +{
> > +     struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> > +
> > +     BUILD_BUG_ON(sizeof(struct bpf_iter_cpumask_kern) > sizeof(struct=
 bpf_iter_cpumask));
> > +     BUILD_BUG_ON(__alignof__(struct bpf_iter_cpumask_kern) !=3D
> > +                  __alignof__(struct bpf_iter_cpumask));
>
> Why are we checking > in the first expression instead of just plain
> equality?

Similar to the previous case, it aligns with others. Once we eliminate
the struct bpf_iter_cpumask_kern, we can safely discard these
BUILD_BUG_ON() statements as well.

>
> > +
> > +     kit->mask =3D bpf_mem_alloc(&bpf_global_ma, sizeof(struct cpumask=
));
>
> Probably better to use cpumask_size() here.

will use it.

>
> > +     if (!kit->mask)
> > +             return -ENOMEM;
> > +
> > +     cpumask_copy(kit->mask, mask);
> > +     kit->cpu =3D -1;
> > +     return 0;
> > +}
> > +
> > +/**
> > + * bpf_iter_cpumask_next() - Get the next CPU in a bpf_iter_cpumask
> > + * @it: The bpf_iter_cpumask
> > + *
> > + * This function retrieves a pointer to the number of the next CPU wit=
hin the
> > + * specified bpf_iter_cpumask. It allows sequential access to CPUs wit=
hin the
> > + * cpumask. If there are no further CPUs available, it returns NULL.
> > + *
> > + * Returns a pointer to the number of the next CPU in the cpumask or N=
ULL if no
> > + * further CPUs.
> > + */
> > +__bpf_kfunc int *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it)
> > +{
> > +     struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> > +     const struct cpumask *mask =3D kit->mask;
> > +     int cpu;
> > +
> > +     if (!mask)
> > +             return NULL;
> > +     cpu =3D cpumask_next(kit->cpu, mask);
> > +     if (cpu >=3D nr_cpu_ids)
> > +             return NULL;
> > +
> > +     kit->cpu =3D cpu;
> > +     return &kit->cpu;
> > +}
> > +
> > +/**
> > + * bpf_iter_cpumask_destroy() - Destroy a bpf_iter_cpumask
> > + * @it: The bpf_iter_cpumask to be destroyed.
> > + *
> > + * Destroy the resource assiciated with the bpf_iter_cpumask.
> > + */
> > +__bpf_kfunc void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it)
> > +{
> > +     struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> > +
> > +     if (!kit->mask)
> > +             return;
> > +     bpf_mem_free(&bpf_global_ma, kit->mask);
> > +}
> > +
> >  __bpf_kfunc_end_defs();
> >
> >  BTF_SET8_START(cpumask_kfunc_btf_ids)
> > @@ -450,6 +529,9 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
> >  BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
> >  BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
> >  BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
> > +BTF_ID_FLAGS(func, bpf_iter_cpumask_new, KF_ITER_NEW | KF_RCU)
> > +BTF_ID_FLAGS(func, bpf_iter_cpumask_next, KF_ITER_NEXT | KF_RET_NULL)
> > +BTF_ID_FLAGS(func, bpf_iter_cpumask_destroy, KF_ITER_DESTROY)
> >  BTF_SET8_END(cpumask_kfunc_btf_ids)
> >
> >  static const struct btf_kfunc_id_set cpumask_kfunc_set =3D {
> > --
> > 2.39.1
> >
> >

--=20
Regards
Yafang

