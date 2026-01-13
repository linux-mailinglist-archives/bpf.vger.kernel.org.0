Return-Path: <bpf+bounces-78708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDDBD18E3B
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 13:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4158A3012756
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 12:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E0C38F228;
	Tue, 13 Jan 2026 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzrEsjbb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECF23D3B3
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768308407; cv=none; b=Ij3Rj4KiNeKstSV1huvoAaZrfmVax4e9vO0Xme+oqswLZm5oOl0u17XhtQ6xM5vCDBfG+4DS2NecoBVEDL68UlljZL8tJp1WEqU7st0phdV5qY7H+1GVS+yNpCepdQS2Oh4lnHUkFMxrZ6Oswg7r7R32ZSFtv67pSHeP02tOG9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768308407; c=relaxed/simple;
	bh=vfZZzhVcSuZRSWhsz140UO0jmPNfK2OHhVUz1fAqdUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYgvpzD386nBrbqMzEqcTTxGc4hagQsBct4etg8+LwizaliA8GTNZ9S81jf/hCgu79ZsovcWUjU45/faWTzHgLxJRSWo7jY4iFqD8f5zMisvvHXKucSpcfr54HtSx1cZpYyy4QUiHJs6yvBkOsfqAmsU8mBlLetFSuwsEJaCSIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzrEsjbb; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64760131fc1so4138956d50.2
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 04:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768308405; x=1768913205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eHj6eu8QUIhQT3379yD0LS4ETiuNh0tW9nXgScZlK4=;
        b=CzrEsjbb3NLdhxCaTJw+4VvP+8r7nsxvHL6vA5Tx/wzFhs+NY2H3Hd6FJoYtL0jYCk
         cQIR24An6FnL3qAxiKtB6P/CJf0PEEmrd0MjsxcSY4EGhQS8Stg4D7rwwdsehmGxeP51
         NE/CjWmr+2Va3/nFEEj8MLJGi4ViO0gaIvinoKlQ06M4NSBlpSPwx5EUzA8ixAC+8cfr
         gX1ME0EkaqezebKlH5PWy1+ZZMtqQECooL0RewwRnc3jfA2MpRPnl0KOUVvEdNldUkJd
         awYquch4j30uuqzz7eLUTVOP5b2beNyDMt+K6a08IfxHhUKeh+bZ2jcH6YIyQNYDBKxJ
         WD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768308405; x=1768913205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+eHj6eu8QUIhQT3379yD0LS4ETiuNh0tW9nXgScZlK4=;
        b=AMpDfpTU3CN1iqj4olUbrgHAxuluCLGdijsL6gi7LEO35KSy3aY7GMjdYMzWFXSfjc
         c1daUobfg6KaKKF6v0mF909PIWhQU9JKxysFEb3vqxHVxygBiKJ+1x0dClw8y+mNFZFq
         2US4/B0DFvE5sXhIchQLQReusLeZcHvrh+3MTOUN0ytHnazBp7BJoGTI0Z8EgdXfFaV+
         jXx6jvuUUZm4Pxg4k56oLqI1QJrou7Ns4AW93GxIrimQeAygwBr2s5mDAvrk5EYKrDcT
         ZpqWXvGHcz6kPIe4aIk4gJHe7Mn2BV+k70ZD7tMsBBeItub8DdF5vZnJKCBdv3sBxRiw
         PiSg==
X-Forwarded-Encrypted: i=1; AJvYcCW9rVjwlIuepLxNvrzYlnl52J2t8d+nCl7kmE4FYhr1T2Mn9nfq3Ero4CtzD4/Ry3RJnLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBGdU3B61//3S934WKkw6lT+ka7ePkook1dIk0uJXqpyPqlfBp
	DUqCJkIQvyXp9ejzySZZhw9cP1wsaNd2mSrGuoxalKHWr7U4QSzO2IsvvWzMdQBx+0DJ1z7vwRI
	vkguaFXLhFpBimi6hLcz3nnUVeBb+Q4s=
X-Gm-Gg: AY/fxX52E4aEqmPRTVNhoO3VpPaPflVK25XFKsBs8owl6/OplwnXqU7hFixZ4kusMd5
	NIxwTYEjtGpXVzBVH2latgu3Boq1FLqITHyWaCEEgd4wsfUt2UGVxb8gvr30boDv3itO1bHvdCs
	1nAGuwtu/ZbhNd5ocNsST/rYu5lZC36i3pGbo7dIdbv6T0L60klB43Kzp6uOVCbsxphD23v+psI
	bag0ikwrStzNUNUnQ5Di8x6+MZTA9AgprlzOUEoymWNxIA7EuPx1WSdbaGcuZpNA/NFuTIZ
X-Google-Smtp-Source: AGHT+IGjXbsHaf3qaC93Qq3o81HX/9/GW9BuCGijx83kAwgsR9hZFk8J5TZfoj5N23Vb/NFJCv8eCC+OG7V6e4dx/7E=
X-Received: by 2002:a05:690c:6209:b0:78d:6f35:bda3 with SMTP id
 00721157ae682-790b5829054mr422917867b3.53.1768308404771; Tue, 13 Jan 2026
 04:46:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113121238.11300-3-laoar.shao@gmail.com> <be08950549a97cf3a2efd077cffc767395c208807f5f65af081db9a9a9623944@mail.kernel.org>
In-Reply-To: <be08950549a97cf3a2efd077cffc767395c208807f5f65af081db9a9a9623944@mail.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 13 Jan 2026 20:46:08 +0800
X-Gm-Features: AZwV_QgV5cvSxlqXHAoUL5sRKv197J3ZXWpFD3iA2PJgz-IvQZ48HUKVYxFcyvA
Message-ID: <CALOAHbCv7UWpPg9DK4j_xH-_DYifmjnRFyK1Cfu_Asy1L093bQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/3] mm: add support for bpf based numa balancing
To: bot+bpf-ci@kernel.org
Cc: roman.gushchin@linux.dev, inwardvessel@gmail.com, shakeel.butt@linux.dev, 
	akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, mkoutny@suse.com, yu.c.chen@intel.com, zhao1.liu@intel.com, 
	bpf@vger.kernel.org, linux-mm@kvack.org, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 8:29=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/mm/Makefile b/mm/Makefile
> > index bf46fe31dc14..c2b887491f09 100644
>
> [ ... ]
>
> > @@ -107,8 +107,13 @@ ifdef CONFIG_SWAP
> >  obj-$(CONFIG_MEMCG) +=3D swap_cgroup.o
> >  endif
> >  ifdef CONFIG_BPF_SYSCALL
> > +ifdef CONFIG_NUMA_BALANCING
> >  obj-$(CONFIG_MEMCG) +=3D bpf_memcontrol.o
> >  endif
> > +endif
> > +ifdef CONFIG_BPF_SYSCALL
> > +obj-$(CONFIG_MEMCG) +=3D bpf_numa_balancing.o
> > +endif
>
> Should bpf_numa_balancing.o also require CONFIG_SHRINKER_DEBUG? The code
> calls mem_cgroup_get_from_ino() which is only defined when
> CONFIG_SHRINKER_DEBUG is enabled. Without it, compilation will fail due t=
o
> an undefined reference.

Yes, this functionality depends on CONFIG_SHRINKER_DEBUG.
If this patchset is accepted, it will be merged after Roman's series
[0] since it has additional dependencies on that work. This explains
why CONFIG_SHRINKER_DEBUG is not added here.

[0]. https://lore.kernel.org/bpf/20251027231727.472628-5-roman.gushchin@lin=
ux.dev/

>
> Also, should it require CONFIG_NUMA_BALANCING? Without that config option=
,
> task_numab_enabled() returns false unconditionally, so the BPF hook would
> never be invoked even if a program is attached.

will fix it.

>
> > diff --git a/mm/bpf_numa_balancing.c b/mm/bpf_numa_balancing.c
> > new file mode 100644
> > index 000000000000..aac4eec7c6ba
> > --- /dev/null
> > +++ b/mm/bpf_numa_balancing.c
>
> [ ... ]
>
> > +static int bpf_numab_reg(void *kdata, struct bpf_link *link)
> > +{
> > +     struct bpf_numab_ops *ops =3D kdata;
> > +     struct mem_cgroup *memcg;
> > +     int err =3D 0;
> > +
> > +     /* Only the link mode is supported. */
> > +     if (!link)
> > +             return -EOPNOTSUPP;
> > +
> > +     /* Depends on CONFIG_SHRINKER_DEBUG */
> > +     memcg =3D mem_cgroup_get_from_ino(ops->cgroup_id);
> > +     if (!memcg || IS_ERR(memcg))
> > +             return -ENOENT;
> > +
> > +     spin_lock(&numab_ops_lock);
> > +     /* Each memory cgroup can have at most one attached BPF program t=
o ensure
> > +      * exclusive control and avoid interference between different BPF=
 policies.
> > +      */
> > +     if (rcu_access_pointer(memcg->bpf_numab)) {
> > +             err =3D -EBUSY;
> > +             goto out;
> > +     }
> > +     rcu_assign_pointer(memcg->bpf_numab, ops);
> > +     spin_unlock(&numab_ops_lock);
> > +     static_branch_inc(&bpf_numab_enabled_key);
> > +
> > +out:
> > +     mem_cgroup_put(memcg);
> > +     return err;
> > +}
>
> When rcu_access_pointer(memcg->bpf_numab) is non-NULL, the code sets err
> to -EBUSY and jumps to out:, but this bypasses the spin_unlock(). Is the
> spinlock left held when returning -EBUSY?

Nice catch!

>
> > +static void bpf_numab_unreg(void *kdata, struct bpf_link *link)
> > +{
> > +     struct bpf_numab_ops *ops =3D kdata;
> > +     struct mem_cgroup *memcg;
> > +
> > +     memcg =3D mem_cgroup_get_from_ino(ops->cgroup_id);
> > +     if (!memcg)
> > +             return;
>
> mem_cgroup_get_from_ino() returns ERR_PTR() on failure, not NULL. If the
> cgroup was deleted between reg and unreg, this function would get an
> ERR_PTR value, the if (!memcg) check would pass, and then
> rcu_access_pointer(memcg->bpf_numab) would dereference an invalid pointer=
.
> Should this check be if (!memcg || IS_ERR(memcg)) like in bpf_numab_reg()=
?
>
> Also, mem_cgroup_get_from_ino() takes a reference on the memcg via
> cgroup_get_e_css(). Where is the corresponding mem_cgroup_put() call?
> The function appears to leak the memcg reference on all paths.

Nice catch.
will fix it.

>
> > +     spin_lock(&numab_ops_lock);
> > +     if (!rcu_access_pointer(memcg->bpf_numab)) {
> > +             spin_unlock(&numab_ops_lock);
> > +             return;
> > +     }
> > +     rcu_replace_pointer(memcg->bpf_numab, NULL, lockdep_is_held(&numa=
b_ops_lock));
> > +     spin_unlock(&numab_ops_lock);
> > +     static_branch_dec(&bpf_numab_enabled_key);
> > +     synchronize_rcu();
> > +}
> > +
> > +static int bpf_numab_update(void *kdata, void *old_kdata, struct bpf_l=
ink *link)
> > +{
> > +     struct bpf_numab_ops *ops =3D kdata;
> > +     struct mem_cgroup *memcg;
> > +
> > +     memcg =3D mem_cgroup_get_from_ino(ops->cgroup_id);
> > +     if (!memcg)
> > +             return -EINVAL;
>
> Same two issues as bpf_numab_unreg(): the check should handle ERR_PTR()
> values, and there appears to be no mem_cgroup_put() to release the
> reference taken by mem_cgroup_get_from_ino().

Thanks for your review.
You are awesome!

--=20
Regards
Yafang

