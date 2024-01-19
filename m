Return-Path: <bpf+bounces-19882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE53832709
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 10:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 548EDB24C91
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 09:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAA43C494;
	Fri, 19 Jan 2024 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYh9dfSB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2A83C486
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705657877; cv=none; b=J/XE1ulXEWoXn43mp+n8DrfG358/uhoa9yQoP0zV6k5fcFpGi804NBF0DDxbp9gsw/YeHuwhRj3ObFzzMN2/CeDvOPQeuRWh/KKRSPOGS9V7Ktp+epdpXmy4729A6TwOnPEXzyP86d1QlyH6MuT7wUNUqqgEjk4fipemx6aqapQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705657877; c=relaxed/simple;
	bh=KdSCswnB6nGucAFlK1pvKJp81piTHrJIJXwhAIqRPBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6bDxw98hjYwOHIJmep2B8BWgt7DWa0vC7pB8oa+qJq/IsxMXUjkwlX04Kj9YyvwArFp2vrqi3rW5192ZRYY/eA9Di6R3TK1AZyoP5ZRxl4OVY9OVqJk4h2Fh8AzAnJiAbbH8DculvDslEZClDUsjmn1mTiqVk462HjltB0LYU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYh9dfSB; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6818d263cb3so3757446d6.2
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 01:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705657875; x=1706262675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I82iFwkLI1lj6n3+lkI1DPEIGjKZqR02MMJxDyZSvvM=;
        b=WYh9dfSB5JCIkyUB5hePRiR+V4mt2i6lho+xYput/1E2ghucEs/Klc56P6E35n419O
         lIrXSk3rzHDkFJUtAL+DNC+cBZASGPUpjuJPxfkeDlaoxN2HjxGzd+AcdRr9R5dleq0t
         95cnUsorBJ5Sr9RoYXNRbONYNXf2jtTKGo9GpWs8drpN5DBgRLhX8xdvztB154IzDts6
         DZtjd1zi/Wq6nkYn/hXJCo8H1RSrMly34fEi0dSYiOA1W64g6iDZWgIFpB1+EeGOWnS3
         E99wBbII4ZDMhqvyBvAe7gAsqxQ7V2inC3oRDMLXj98d+Ke7gby2/RRLxCdLMyC46RkM
         2LcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705657875; x=1706262675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I82iFwkLI1lj6n3+lkI1DPEIGjKZqR02MMJxDyZSvvM=;
        b=HDazVfd5IFgqTy2pMAXwEQKrowh8CDJJaFU6uxOo6Ve+5WRtsh7LuNUK2nyyEjZHDW
         ytlIlD5+lueAm4dXw8cQflUa1srgfwBq6Wjuy/acv3vYzn0zK7BWDltq8lbySrThsrqC
         AllW6IV2TL9Ja9ibcC8yR/yJv2xu7w+CKL/6xrDS4NxExXWOCNqr2LqDt5PCiMc2vbCy
         JvY4GL897j8lKTS69SoGIExlwQy4w0685LFvpQAnYAdV7HsWcCBTaWwMeX2zQ7DOLCX/
         dJDothDe92XxWwlmhGDOOhVsqgzI7rsO+11SPNQ3ugaB5TJmo/jr3QGetgRDQseHQiMp
         QMng==
X-Gm-Message-State: AOJu0Yxiz5X77QYWCXSGFlmHf1JiJclIu7kn/0Un2BYAJptVlOw6IQrw
	osU93EA0yn54nb/6O1UVuPCJoCMmCDw3ZA+t09mzuzNvv/o+7WI3isYO4L6374oEJp4O7s2ggd/
	fJjAhSUbLHbJe+ziNJDxV2UmQ1Xw=
X-Google-Smtp-Source: AGHT+IGdo/0818y83rH5DXDwClqj5hrHJJUGVZHTsAEeT74RIHBddg4B1cy45y55dckZIFOHkxndgO1oLux4c62KhKg=
X-Received: by 2002:ad4:4ee7:0:b0:681:9996:f623 with SMTP id
 dv7-20020ad44ee7000000b006819996f623mr2344531qvb.64.1705657874770; Fri, 19
 Jan 2024 01:51:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117024823.4186-1-laoar.shao@gmail.com> <20240117024823.4186-2-laoar.shao@gmail.com>
 <a7699a08-827b-4433-99a8-bfbfda1d38af@linux.dev>
In-Reply-To: <a7699a08-827b-4433-99a8-bfbfda1d38af@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 19 Jan 2024 17:50:38 +0800
Message-ID: <CALOAHbBb7tLC7wVJOF+PA5vTVwzJPuvSfnjnd6ZEzWmTWGgG9A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: Add bpf_iter_cpumask kfuncs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, tj@kernel.org, 
	bpf@vger.kernel.org, lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 6:27=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 1/16/24 6:48 PM, Yafang Shao wrote:
> > Add three new kfuncs for bpf_iter_cpumask.
> > - bpf_iter_cpumask_new
> >    It is defined with KF_RCU_PROTECTED and KF_RCU.
> >    KF_RCU_PROTECTED is defined because we must use it under the
> >    protection of RCU.
> >    KF_RCU is defined because the cpumask must be a RCU trusted pointer
> >    such as task->cpus_ptr.
>
> I am not sure whether we need both or not.
>
> KF_RCU_PROTECTED means the function call needs within the rcu cs.
> KF_RCU means the argument usage needs within the rcu cs.
> We only need one of them (preferrably KF_RCU).

As you explained below, KF_RCU_PROTECTED is actually for
bpf_iter_cpumask_next().

>
> > - bpf_iter_cpumask_next
> > - bpf_iter_cpumask_destroy
> >
> > These new kfuncs facilitate the iteration of percpu data, such as
> > runqueues, psi_cgroup_cpu, and more.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >   kernel/bpf/cpumask.c | 69 +++++++++++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 69 insertions(+)
> >
> > diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> > index 2e73533a3811..1840e48e6142 100644
> > --- a/kernel/bpf/cpumask.c
> > +++ b/kernel/bpf/cpumask.c
> > @@ -422,6 +422,72 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cp=
umask *cpumask)
> >       return cpumask_weight(cpumask);
> >   }
> >
> > +struct bpf_iter_cpumask {
> > +     __u64 __opaque[2];
> > +} __aligned(8);
> > +
> > +struct bpf_iter_cpumask_kern {
> > +     const struct cpumask *mask;
> > +     int cpu;
> > +} __aligned(8);
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
> > +
> > +     kit->mask =3D mask;
> > +     kit->cpu =3D -1;
> > +     return 0;
> > +}
>
> We have problem here. Let us say bpf_iter_cpumask_new() is called inside =
rcu cs.
> Once the control goes out of rcu cs, 'mask' could be freed, right?
> Or you require bpf_iter_cpumask_next() needs to be in the same rcu cs
> as bpf_iter_cpumask_new(). But such a requirement seems odd.
>
> I think we can do things similar to bpf_iter_task_vma. You can allocate m=
emory
> with bpf_mem_alloc() in bpf_iter_cpumask_new() to keep a copy of mask. Th=
is
> way, you do not need to worry about potential use-after-free issue.
> The memory can be freed with bpf_iter_cpumask_destroy().

Good suggestion. That seems better.

>
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
> > + */
> > +__bpf_kfunc void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it)
> > +{
> > +}
> > +
> >   __bpf_kfunc_end_defs();
> >
> >   BTF_SET8_START(cpumask_kfunc_btf_ids)
> > @@ -450,6 +516,9 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
> >   BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
> >   BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
> >   BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
> > +BTF_ID_FLAGS(func, bpf_iter_cpumask_new, KF_ITER_NEW | KF_RCU_PROTECTE=
D | KF_RCU)
> > +BTF_ID_FLAGS(func, bpf_iter_cpumask_next, KF_ITER_NEXT | KF_RET_NULL)
> > +BTF_ID_FLAGS(func, bpf_iter_cpumask_destroy, KF_ITER_DESTROY)
> >   BTF_SET8_END(cpumask_kfunc_btf_ids)
> >
> >   static const struct btf_kfunc_id_set cpumask_kfunc_set =3D {



--
Regards
Yafang

