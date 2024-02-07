Return-Path: <bpf+bounces-21390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C0084C30E
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 04:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DB21C21A83
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 03:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4016AFC02;
	Wed,  7 Feb 2024 03:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKhj6jUz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D52FC08
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 03:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707276311; cv=none; b=DXE5SmjnCRlsx57nXfEA/ovoocrfv0l4SXt+geDuKrqJscG7nweeVLt1LNBH/Eoe0bfc9EbZ7F5z8cfe8AIiGzrWuz112N90VX2GjXsudXHmhLHtFPpP5FRgK/KZG0oOKdr8/DNHPzheowu+vU3Oft1mdvHI09bND7W/n0suBmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707276311; c=relaxed/simple;
	bh=oIxrbyBnGSVLLu0sAVNrKBccxiIlOXPwO/aat9Ns2eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e97JRODmD+rXiDY/o1HzPxnvvnY9+hnqdqgX7QRbl2ZWFwTiW0iOaPsx4q+fGcIVW40MpCcYF1SoDTvmnmXKDz9EbsTTXNqUIx8MSaeCk6LxNSEJqcT+WmjL3zWev4Bkhd/ZTX22LT6pviMi5rD8WJCcK00C+x5tTu4sTSXyegg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKhj6jUz; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6818aa08a33so1745216d6.0
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 19:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707276309; x=1707881109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZb8QCT6YTDd90dpAQMginOsHOiWHQM2m1Gzjk81jcY=;
        b=CKhj6jUzPuADcem92j5stf+CKlZ8EtkibcY67HhbGDXylJDH4E98vwo6k/H/YVVwwn
         VJD+0+jqM8TX0yTDn9k7dblKeiszHSi67ofFkjodbnkGBL/Yn3aOyhzcIDNBsdDYrbYn
         akA3dN2WW2/T/dSS711R4myh54vB1rcsrZZ6QvzhR306e8S7VpGYcxxzIbJwWiGGMDgU
         wWXlp9Xsx5RKNzSYwBCIjjlqqLL7SaZyLNhHCS2BicVogc0Uy1Gqbug6GJkFdOnMA/qN
         YjNIrWQAJnyNWWMwP4FnHiiZwsd0Dcwmz4HNSh3fIYVU1PzUFA7GAfQU7mZ2jcu+iten
         IJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707276309; x=1707881109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZb8QCT6YTDd90dpAQMginOsHOiWHQM2m1Gzjk81jcY=;
        b=sJ8JlEhOVbKQwfTA2WP6dzc7Sl1hjgvr/5eCelLhwO+C2H92EHPqVXDiqiTWo3sBgR
         SLpdhHLWfCwptRjcr7JD/oQby57PQzg9/vznoY31PQqotOVsv11QWJdA/Qi6uDIz5ShF
         2ige9Rp+OnFmYsgff+NEJvi8LmWZOb2f2MNZjU3+I799aCLNF/zvfQ8453hM8h5RL4zt
         OYtSw/2coVG10FabM4U/tDaiXFVL+nOLKapqXfcc28bSsHWMvMMBZx+v86RMT2337AmI
         oBYcvZELECYtd4edz47JXhqGMRwNpDeOGfBkj7R8gn6IeGi5dMqULS0F9haG4hNTmFFI
         Qprg==
X-Gm-Message-State: AOJu0YxiSLKFl7Tg/a11jQqxp7ZwXVXxXBBRRYge8LSQzC1Ed7TOTcD1
	6u8d1tLMtAteF+EDVcwF+Iv/FHmmYpdZyTSxcbChTDA+x6ktoTg69pfZUfeFT9PRAZrm0L6YWtY
	8KP7j0t9rbOoSl+D6aCN27NoWlS4=
X-Google-Smtp-Source: AGHT+IGvjcQQfiHVadwFt3bHcsOsXNcbo3T2OxiWgOk76itjrEDonDQaGmxQHClsBRnMPMlcXIdh4SQeNHVWtsqXWbs=
X-Received: by 2002:ad4:5ec6:0:b0:68c:b8d4:1fa2 with SMTP id
 jm6-20020ad45ec6000000b0068cb8d41fa2mr4483555qvb.10.1707276309123; Tue, 06
 Feb 2024 19:25:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206081416.26242-1-laoar.shao@gmail.com> <20240206081416.26242-2-laoar.shao@gmail.com>
 <CAADnVQ+n0xDB5=+bpTiuAaHQ7UJAzQVQKkyuNSOxaPyOhHWYBw@mail.gmail.com>
In-Reply-To: <CAADnVQ+n0xDB5=+bpTiuAaHQ7UJAzQVQKkyuNSOxaPyOhHWYBw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 7 Feb 2024 11:24:33 +0800
Message-ID: <CALOAHbDJWHOB+viBz6SUqdeF+Nkxmh4gLZo5Ad_keQXjBWHAsQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 1/5] bpf: Add bpf_iter_cpumask kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 9:06=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 6, 2024 at 12:14=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
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
> > ---
> >  kernel/bpf/cpumask.c | 79 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> >
> > diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> > index dad0fb1c8e87..ed6078cfa40e 100644
> > --- a/kernel/bpf/cpumask.c
> > +++ b/kernel/bpf/cpumask.c
> > @@ -422,6 +422,82 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cp=
umask *cpumask)
> >         return cpumask_weight(cpumask);
> >  }
> >
> > +struct bpf_iter_cpumask {
> > +       __u64 __opaque[2];
> > +} __aligned(8);
> > +
> > +struct bpf_iter_cpumask_kern {
> > +       struct cpumask *mask;
> > +       int cpu;
> > +} __aligned(8);
> > +
> > +/**
> > + * bpf_iter_cpumask_new() - Initialize a new CPU mask iterator for a g=
iven CPU mask
> > + * @it: The new bpf_iter_cpumask to be created.
> > + * @mask: The cpumask to be iterated over.
> > + *
> > + * This function initializes a new bpf_iter_cpumask structure for iter=
ating over
> > + * the specified CPU mask. It assigns the provided cpumask to the newl=
y created
> > + * bpf_iter_cpumask @it for subsequent iteration operations.
> > + *
> > + * On success, 0 is returned. On failure, ERR is returned.
> > + */
> > +__bpf_kfunc int bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, cons=
t struct cpumask *mask)
> > +{
> > +       struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> > +
> > +       BUILD_BUG_ON(sizeof(struct bpf_iter_cpumask_kern) > sizeof(stru=
ct bpf_iter_cpumask));
> > +       BUILD_BUG_ON(__alignof__(struct bpf_iter_cpumask_kern) !=3D
> > +                    __alignof__(struct bpf_iter_cpumask));
> > +
> > +       kit->mask =3D bpf_mem_alloc(&bpf_global_ma, cpumask_size());
> > +       if (!kit->mask)
> > +               return -ENOMEM;
> > +
> > +       cpumask_copy(kit->mask, mask);
>
> Since it's mem_alloc plus memcpy how about we make it more
> generic ?
> Instead of cpumask specific let's pass arbitrary
> "void *unsafe_addr, u32 size"
>
> allocate that much and probe_read_kernel into the buffer?
>
>
> > +__bpf_kfunc int *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it)
> > +{
> > +       struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> > +       const struct cpumask *mask =3D kit->mask;
> > +       int cpu;
> > +
> > +       if (!mask)
> > +               return NULL;
> > +       cpu =3D cpumask_next(kit->cpu, mask);
>
> Instead of cpumask_next() call find_next_bit()
>
> > +       if (cpu >=3D nr_cpu_ids)
> > +               return NULL;
>
> instead of nr_cpu_ids we can check size in bits of copied bit array.
>
> > BTF_ID_FLAGS(func, bpf_iter_cpumask_new, KF_ITER_NEW | KF_RCU)
>
> KF_RCU is also not needed.
> Such iterator will be callable from anywhere and on any address.
>
> wdyt?

Good suggestion. A more generic bitmap iter is better. I will analyze it.

--=20
Regards
Yafang

