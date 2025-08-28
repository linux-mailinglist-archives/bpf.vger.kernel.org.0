Return-Path: <bpf+bounces-66801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB53B39436
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 08:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7216F46453D
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 06:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2749C272E75;
	Thu, 28 Aug 2025 06:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mg7AjHvp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5B02459E1;
	Thu, 28 Aug 2025 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363849; cv=none; b=KhZ+XFzpmq5JhCau+3GL+BYu8xHnmqht3kBVPX0mCiE4O2KJcPiug6eoHKg+Hv/54Tcbz0+ymKfkHMJIm2wSMxS1nVpyO24PubyvyDlSSVBnG7EDh3MUbx+8QChd7e5q7qR0a9ZOwDdkdw2bypV/sIuvAbE6A8InLNGGB+sR3ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363849; c=relaxed/simple;
	bh=7cAIRuvpfeD0LfyyMieehgm8DOPAdJvF2vmF4W+o/JU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2LTRGSUmKiEC5R7uH1RdsS4JN18ZbRZJpmQtApdHly91vzsZxruGympZ4u5eChX8Gmo7Po3YSKwssdg+CrhWwpKil8RDzjlDf//JLgmQ76jn/s9P3AknQbKEguVmo1owpj0SCYf0PHAxUjpATnKzzneZ4DrMl9xLOI3feM4qh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mg7AjHvp; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70de1230e87so4660366d6.0;
        Wed, 27 Aug 2025 23:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756363846; x=1756968646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiNHEvw4OCzSJ36sRfMVygFrm4X1IJUCPsv6ANJRoOE=;
        b=Mg7AjHvp/CjiHIgF26rAWOFPNsUdYl0neq9E2Ol98BEjN1mIQogswpae/JO+WO/EzJ
         8J8gTp53LZVDHwVXfFXVqcHlarpu0g769AmBcbFnnSR/xTdHpRgrsGq4sPFHF3MKh6ch
         0ywaVRH2UtoVmE3B8TbzJ6A321X8h7h2nY5GudVelT2QttoE4bdhl8YRttFDhHB2T1/t
         ZKm4MvIhybMQ0z9jHqh5DcliOK8acD8taYwXGLonk6zHi4iwUObpjKwSlClRcXHR+1UV
         pofOw79LHsYPYLAouwwZyVdPNvEv0egwuF/G5Ny4q67d/Uby6UnjzrrybpiQS9vRxLW1
         3m8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756363846; x=1756968646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiNHEvw4OCzSJ36sRfMVygFrm4X1IJUCPsv6ANJRoOE=;
        b=SCMX1Qt9MBc1U1w42kjua9ZJ/qHFR7x1xfJ4IPVmViD5mrb/7wZJNgkE7z7TV9F8jW
         p6hCVPUcQy8RBpsXT7yRXZQXHdU2Uv8VlbqaO7AmK0qsJVWH3TDdSik6SVAEgibwSo5Q
         C5ya6eT6WaYfna3302mTfg8h7G1oZJpOO9Nu3bbsm4GCisSIqk5jkzg+mo2n/OvPVEVv
         i8sE0HadIaxevzxOMBs9TwVFFOA07UpThjHKf1ZbKw65JT3EybZRg79QxzxSthhns6mD
         xI5esLj9kyOJVPf8X/JUcWqQOcPLv6zQjDNFdbKId5KesyGPg5LPViqj01BH/ixDZwTz
         Pntg==
X-Forwarded-Encrypted: i=1; AJvYcCU9UpSK3r7l4YS4XYtsl0ecAUSZ2mERQJhmUJb8cieelNTtQJxlhrk1s1xvP1xL2b2u0Ng=@vger.kernel.org, AJvYcCWTonQWlj++cA+FGTlP9chZLKSJrTq1P5Ary1Z/+RdERAPDI56WUaI+/VaauzuGPAsycmaFMbvyclJJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwmFC1g4k5fCUTkJylldnoEUcIDr2xX8hkRNabgkvJ5HRIjZ8Md
	7MtwfwXOaGbYFvSAoZYIg/WeyDoDUUJP+8MZp/SOILKKy205jVid5hb8dfnoxghGnMRlsZbtHbe
	pBoWDvmarXAuBCdVHcZL/K+5iOVJLVlY=
X-Gm-Gg: ASbGncusde83FWFt7YUXb0+XLeUDDICHRYPobfBv3iqrLD+QjAqJeI7x/Id6Jx3YsJL
	27ECAeohv+gEZdIG8WUkjHZVaWWd63MZESb7VWXhujecgEktDEiPjHNYuF3844Y12086p5Uf4vp
	6LFhpGUab/9bBZ7E2xdFdJwgtLjvsAgCkSg3sfx9i2EZ6CtMnBnNHrgciFIZDR7VKXDfuPErErk
	Mw9GXc6uoTvm/W8BmpLZGZ7WV8Npb/a0+t64q8kUxhxohip6Q==
X-Google-Smtp-Source: AGHT+IF+ehKK78j4DDuJ4sGpjti346ms5dAzHA6bOxAHCOy4qjrtSDtJIZ0Z8hdL2OZci0mG9+6t4jpIK1su2Tf5Rdw=
X-Received: by 2002:a05:6214:ccd:b0:70d:bdee:ce2a with SMTP id
 6a1803df08f44-70dbdeed2bcmr157099056d6.46.1756363845938; Wed, 27 Aug 2025
 23:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826071948.2618-1-laoar.shao@gmail.com> <20250826071948.2618-4-laoar.shao@gmail.com>
 <5fb8bd8d-cdd9-42e0-b62d-eb5a517a35c2@lucifer.local> <CAEf4BzaOA-3NtwTmrPgveqbW16m3KZAAA1E_xn_qjtiJBGsE4g@mail.gmail.com>
In-Reply-To: <CAEf4BzaOA-3NtwTmrPgveqbW16m3KZAAA1E_xn_qjtiJBGsE4g@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 28 Aug 2025 14:50:08 +0800
X-Gm-Features: Ac12FXxzAaUxjJkSIKj9IhilFeKPZNkJYuhj1_W1tJSrtzY4m65m7APoD6Uecqk
Message-ID: <CALOAHbCc7upWnZuAsxSvW0LAwMi+RzAYZh9MzO52+B=TcY8NzA@mail.gmail.com>
Subject: Re: [PATCH v6 mm-new 03/10] mm: thp: add a new kfunc bpf_mm_get_task()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, david@redhat.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 5:50=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Aug 27, 2025 at 8:48=E2=80=AFAM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Tue, Aug 26, 2025 at 03:19:41PM +0800, Yafang Shao wrote:
> > > We will utilize this new kfunc bpf_mm_get_task() to retrieve the
> > > associated task_struct from the given @mm. The obtained task_struct m=
ust
> > > be released by calling bpf_task_release() as a paired operation.
> >
> > You're basically describing the patch you're not saying why - yeah you'=
re
> > getting a task struct from an mm (only if CONFIG_MEMCG which you don't
> > mention here), but not for what purpose you intend to use this?
> >
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> > >  mm/bpf_thp.c | 34 ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 34 insertions(+)
> > >
> > > diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
> > > index b757e8f425fd..46b3bc96359e 100644
> > > --- a/mm/bpf_thp.c
> > > +++ b/mm/bpf_thp.c
> > > @@ -205,11 +205,45 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_=
cgroup *memcg)
> > >  #endif
> > >  }
> > >
> > > +/**
> > > + * bpf_mm_get_task - Get the task struct associated with a mm_struct=
.
> > > + * @mm: The mm_struct to query
> > > + *
> > > + * The obtained task_struct must be released by calling bpf_task_rel=
ease().
> >
> > Hmmm so now bpf programs can cause kernel bugs by keeping a reference a=
round?
>
> BPF verifier will reject any program that cannot guarantee that
> bpf_task_release() will always be called. So there shouldn't be any
> problem here.

Thanks for the clarification.

>
> >
> > This feels extremely dodgy, I don't like this at all.
> >
> > I thought the whole point of BPF was that this kind of thing couldn't p=
ossibly
> > happen?
> >
> > Or would this be a kernel bug?
> >
> > If a bpf program can lead to a refcount not being put, this is not
> > upstreamable surely?
> >
> > > + *
> > > + * Return: The associated task_struct on success, or NULL on failure=
. Note that
> > > + * this function depends on CONFIG_MEMCG being enabled - it will alw=
ays return
> > > + * NULL if CONFIG_MEMCG is not configured.
> > > + */
> > > +__bpf_kfunc struct task_struct *bpf_mm_get_task(struct mm_struct *mm=
)
> > > +{
> > > +#ifdef CONFIG_MEMCG
> > > +     struct task_struct *task;
> > > +
> > > +     if (!mm)
> > > +             return NULL;
> > > +     rcu_read_lock();
> > > +     task =3D rcu_dereference(mm->owner);
>
> Question to Yafang, though. Instead of adding new kfunc just for this,
> have you tried marking mm->owner as BTF_TYPE_SAFE_TRUSTED_OR_NULL,
> which, if I understand correctly, would allow BPF program to just work
> with `mm->owner` (after checking for NULL) directly. And then you can
> just use existing bpf_task_acquire()

good suggestion.
will change it.

>
> >
> > > +     if (!task)
> > > +             goto out;
> > > +     if (!refcount_inc_not_zero(&task->rcu_users))
> > > +             goto out;
>
> nit: just call bpf_task_acquire(), which will more obviously pair with
> suggested bpf_task_release()?

makes sense.

--=20
Regards
Yafang

