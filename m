Return-Path: <bpf+bounces-66731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55598B38BAE
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 23:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1019C5E4F5F
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 21:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA7730F94B;
	Wed, 27 Aug 2025 21:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6DgA+4N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E700630F935;
	Wed, 27 Aug 2025 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756331452; cv=none; b=U6L39miMYT0MGUXGMRlr2SKdzGMzjPmDH9N1rmRaUymK0GF4UHfJazBMXJV0eVM3cfAIXhT0IgNW5T/gKi/StrbufAoE3uPdl5Xb1Dm+Uf4B4RwgZO+reFI0/kCMywEoAaumYCK0G8i0o8XkhQf5ti1JdOCJWZEe4IleXoVWK7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756331452; c=relaxed/simple;
	bh=c4t5RbUOOEco+/DSiBeBScfm2OAgTR3KhKwXEO4c+JY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEyXDP/Ep4BfW6U0JA86Rk5zEBW44+GYdVghk+M0A0nYFZUDQqgndjz6oisfI/ZY9bAG9Wrl5Ydc7InKjdiaM3pXACzpaS86kJ5aGxQ5Oqh+pCPzE6eb3JG85+CL2Bh7iDK34LmNVNh80SWG2E3WFA80axJtciM4o+lXfZuTjNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6DgA+4N; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so273171a91.2;
        Wed, 27 Aug 2025 14:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756331450; x=1756936250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeDfts8gt4wnyCuEYOnb6uV1ppW7WiK7TkBvoIpFoX0=;
        b=K6DgA+4N2ARysKZqkm76mPf5s8/FlTgyrPTLLTRKfEs98DEMLZl9wH3JpT/Gg84ZMs
         m42OZ5o5rIO8AT4flJK1UeP+iPuad6wsTJyZUdo4YJ/1w3w7CHujPBSo/KWrKF8IH9vG
         Y/1VB10ivbea6H5GotKQATrtY/jpQrxTeUv6GI6cOmP74sH7EvJQbdHjp9AHfoCW0Jk2
         M5uqPfP8ok8ky4C1Qb7/ykMZJhcRtXRv8TAoIuyoUdX0rcEdpeaY7K67RelEmK9y2T9D
         RUEkzftiFLnaVqClZfxbeomAv45wr5WNqGUTekcyUponvUm3mcqMzUtSPbs4IRW593Ge
         Of4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756331450; x=1756936250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeDfts8gt4wnyCuEYOnb6uV1ppW7WiK7TkBvoIpFoX0=;
        b=E4PEBtUnIqgYtzcC3WcgrlcMEjT1mK265dSRw63ZGfKfmkHD399RHJNs5T4+vzepu3
         vIXK8rSCTnjY5HSQvyFl9TH41AlBUwYkgLFfH69gJZgId9yJ46sTCQgk35vfEuEkNUXf
         vovQ21VTJ9O8eZlZ7NbXoK3uZ3FFzvUwl6kkIkUttwtdukpd8e972PNxefLlGOvIzj6L
         tgdW4mrsTYb5sG/NQ5hwLSpdadyvNxXL7/cn/ia6tQYVwYEbUaxOgBYC+IRsL53wBSI4
         aiKyseM//e4mwHnqh6ri3c2455ltItofYVb86g/emop3ngbojsugR0JGn5AtS+2cBRbL
         9y+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkL0cy4OKY+F6j6j4/FYTsZ1U4bGHt7+6xZoU3uiTOXFzUZSGibOYISy8kb+pmK/h6vhinT4cbZgsz@vger.kernel.org, AJvYcCXus64QTQ3VJDYw1bku/MOR8pdLQFrdfgIBThQC3vgEOzsVEW+o2jqVZSG7t9167Szh47Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4D+/i0uSyEtyxYQx3ejLpDL0a4xZs/NazbrYsHTiTME/ahm6H
	BQ+0o4eD0X/5rbspcr77fluadnMvDHG4FdChq129ffdQqgSObODSnM9dK+hBZiA3kVH3UfwQx8o
	U/acWdhSBceC1a5XWc1vfDgyr5mqs44w=
X-Gm-Gg: ASbGncugaAE0ibry4evr6+xEyEnQhx/nlLDmfgf6Zb4koO3u7ksdRC/Yx7IZ2BGKA1u
	BCkOzsPwjGtyP1AMaWC5M00ULOGAvrV8RUl0+AJxTMCFtnecTR5awcCPRjqqgePy6ZcmjTKWN1f
	sysk/4iM2QIH14lpzI/ZICZGOiN5d4EZHyHn2B9/qfZvnivVTi0J2CzQXoGHY3ve9Smu/q19feo
	4IGVspq7Hsv0zooUCaOwLXFIPvEfnwreWxbI0DNIFdV
X-Google-Smtp-Source: AGHT+IGCNb6BmtHpaPHoBHQ6Ipo4VK78lwnolII4TMwisljYP5RNaG/tzMn0ir2zw//Dsg5YMx96cEQPYpz8ClVCC38=
X-Received: by 2002:a17:90b:4d89:b0:325:3937:ef93 with SMTP id
 98e67ed59e1d1-3253937f1bfmr25183524a91.20.1756331450213; Wed, 27 Aug 2025
 14:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826071948.2618-1-laoar.shao@gmail.com> <20250826071948.2618-4-laoar.shao@gmail.com>
 <5fb8bd8d-cdd9-42e0-b62d-eb5a517a35c2@lucifer.local>
In-Reply-To: <5fb8bd8d-cdd9-42e0-b62d-eb5a517a35c2@lucifer.local>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Aug 2025 14:50:36 -0700
X-Gm-Features: Ac12FXx81PD0lPnzpRyp5ouxJbY2sXvnz6hd1oTpKhVDJte3eFVatPHa4qbmTxo
Message-ID: <CAEf4BzaOA-3NtwTmrPgveqbW16m3KZAAA1E_xn_qjtiJBGsE4g@mail.gmail.com>
Subject: Re: [PATCH v6 mm-new 03/10] mm: thp: add a new kfunc bpf_mm_get_task()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, david@redhat.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 8:48=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Aug 26, 2025 at 03:19:41PM +0800, Yafang Shao wrote:
> > We will utilize this new kfunc bpf_mm_get_task() to retrieve the
> > associated task_struct from the given @mm. The obtained task_struct mus=
t
> > be released by calling bpf_task_release() as a paired operation.
>
> You're basically describing the patch you're not saying why - yeah you're
> getting a task struct from an mm (only if CONFIG_MEMCG which you don't
> mention here), but not for what purpose you intend to use this?
>
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  mm/bpf_thp.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
> > index b757e8f425fd..46b3bc96359e 100644
> > --- a/mm/bpf_thp.c
> > +++ b/mm/bpf_thp.c
> > @@ -205,11 +205,45 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cg=
roup *memcg)
> >  #endif
> >  }
> >
> > +/**
> > + * bpf_mm_get_task - Get the task struct associated with a mm_struct.
> > + * @mm: The mm_struct to query
> > + *
> > + * The obtained task_struct must be released by calling bpf_task_relea=
se().
>
> Hmmm so now bpf programs can cause kernel bugs by keeping a reference aro=
und?

BPF verifier will reject any program that cannot guarantee that
bpf_task_release() will always be called. So there shouldn't be any
problem here.

>
> This feels extremely dodgy, I don't like this at all.
>
> I thought the whole point of BPF was that this kind of thing couldn't pos=
sibly
> happen?
>
> Or would this be a kernel bug?
>
> If a bpf program can lead to a refcount not being put, this is not
> upstreamable surely?
>
> > + *
> > + * Return: The associated task_struct on success, or NULL on failure. =
Note that
> > + * this function depends on CONFIG_MEMCG being enabled - it will alway=
s return
> > + * NULL if CONFIG_MEMCG is not configured.
> > + */
> > +__bpf_kfunc struct task_struct *bpf_mm_get_task(struct mm_struct *mm)
> > +{
> > +#ifdef CONFIG_MEMCG
> > +     struct task_struct *task;
> > +
> > +     if (!mm)
> > +             return NULL;
> > +     rcu_read_lock();
> > +     task =3D rcu_dereference(mm->owner);

Question to Yafang, though. Instead of adding new kfunc just for this,
have you tried marking mm->owner as BTF_TYPE_SAFE_TRUSTED_OR_NULL,
which, if I understand correctly, would allow BPF program to just work
with `mm->owner` (after checking for NULL) directly. And then you can
just use existing bpf_task_acquire()

>
> > +     if (!task)
> > +             goto out;
> > +     if (!refcount_inc_not_zero(&task->rcu_users))
> > +             goto out;

nit: just call bpf_task_acquire(), which will more obviously pair with
suggested bpf_task_release()?

> > +
> > +     rcu_read_unlock();
> > +     return task;
> > +
> > +out:
> > +     rcu_read_unlock();
> > +#endif
>
> This #ifdeffery is horrid, can we please just have separate functions ins=
tead of
> inside the one? Thanks.
>
> > +     return NULL;
>
> So we can't tell the difference between this failling due to CONFIG_MEMCG
> not being set (in which case it will _always_ fail) or we couldn't get a
> task or we couldn't get a refcount on the task.
>
> Maybe this doesn't matter since perhaps we are only using this if
> CONFIG_MEMCG but in that case why even expose this if !CONFIG_MEMCG?
>
> > +}
> > +
> >  __bpf_kfunc_end_defs();
> >
> >  BTF_KFUNCS_START(bpf_thp_ids)
> >  BTF_ID_FLAGS(func, bpf_mm_get_mem_cgroup, KF_TRUSTED_ARGS | KF_ACQUIRE=
 | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_RELEASE)
> > +BTF_ID_FLAGS(func, bpf_mm_get_task, KF_TRUSTED_ARGS | KF_ACQUIRE | KF_=
RET_NULL)
> >  BTF_KFUNCS_END(bpf_thp_ids)
> >
> >  static const struct btf_kfunc_id_set bpf_thp_set =3D {
> > --
> > 2.47.3
> >

