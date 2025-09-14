Return-Path: <bpf+bounces-68309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB44B5643E
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 04:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24220189DFA4
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 02:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE67C24635E;
	Sun, 14 Sep 2025 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ3w0joW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BDC1D90DD
	for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757816430; cv=none; b=hFAcfqig2fPJ9mAdbaPbbE8GpKQ/tjykiqqyKQshZpjdfNGYIVa9avTd1uA2+cs1FVDHySxVWhz4D8KMKVVBB1r9+f9dyCuCNn+xIKP4Zlw5ZAcviuB/udRAx54pFoS65H6LXNy69UerTiZ7X0ZcHAoD+DKSTr6lrzhNQLGR3uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757816430; c=relaxed/simple;
	bh=OwJEwqEt78Ndzrx3q0hEfkrL76rC49OFN8MA8xI+XWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxrXCWCJrq29AQB0hUSrMClVrkx+5WruM7hQ+1T2EhGTidygDDoeC2tanxfz5Qn9DoB0WC7ldk5auXs98PBm9Gb7NjJ3nLa+PksavR7rpKBEr10UZkVd7I4WfQ3ixCC9QgAKdpwIeg7fkzOq/ufjL/uUhLOS2OlHZoUlm1FYSX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ3w0joW; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-777dbedf6f0so3163756d6.1
        for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 19:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757816428; x=1758421228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FLLFKulJIRo/+/A7W+JN2XhQBYj1VMkK/MLnr9PzSo=;
        b=IQ3w0joW1fkarS2hnpisnEy5L8RoJ6/nUn5mFMedPlOt2NiM0FVRLgw1ooXQJjHsS7
         0GpA73pdOnvELrpNctEek0ebmx9hXxE57Xs0DX/ctaxkST9tiijenwhAlKz98mHp9zEA
         eXrOp0CSDx8xEYZL4QVYua3Baaj4ETHPYmnjb9K5/Z8ToQdBF+dJ/0yRdxTq3ZzNwilC
         vSNnTzodQSz8L1WK56khVpMkDFI7E87OKP4BVZn1S/RZakO+QroasnLsha1Riia/VEer
         rlt65RJL30uBzDOztM8EaT/B69q06jn9ex0n/OxmYDNOzrm2Ua+qXYZNjo2hiE5+Njxz
         Ak+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757816428; x=1758421228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FLLFKulJIRo/+/A7W+JN2XhQBYj1VMkK/MLnr9PzSo=;
        b=rTCjAK/T9aKGPAtmsNHh3kPB/kgmzLW25iIsXc/E+1WkjnSGXgZ2XgNq+OBAzUwZJW
         qfeb58RLIC3iXmCNuVxp55TX6N636ziprNdrGol1VG6+qF0vdzyUHO0AYGnsDywuKupJ
         tvaV/ilbYYUk972YdRwFdee26QdBBX4a5t0Xg2B3F+N3DHtdxlLU4YvDPXqG3bJvyw4l
         7HAC6hS64pZqthLr88SKk0pEoNpG/FHVHp+wUkj6mgGYYKtfmSUpvucrNtV/82/9m+yA
         zS8v/VvA+UZ35sMZrlsVMGnYbmx8oHt5X3Aa6fm9PZyYgR1Qr/XvxN9QfnmSvJWXqWye
         dWKw==
X-Forwarded-Encrypted: i=1; AJvYcCX82IogTk7iHewCXWLJFs6SYZaK3KHiC3NpGU+Uz7RF9G/+Tw12VeMUOBBv4E6NCz3rZBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH56597UejpG3wyOKAGiFvYhatwoaryIk4ykYDB5u2yHhp3xX5
	gIVU33ZulZTfxw7AZvAiPlKK9dFbiRQbokN5Uu+VZL9Ba4tBda1SzY187o44KcbYSfiznz5D2JU
	PLwHnJqzaOFf2TzS6K8tFJ1uMMhxsyzQ=
X-Gm-Gg: ASbGnctyOuBcWEcgs78dcD13pFP3NV2bQgQTigChumFqtlL9GYn0RSq3D0M521Wlc/4
	StVl4MV449fLS0VCzDcXUUnWzvkzdIdmsefLFKLo9l+IO816sb70WO9mI0X9ttouYKkbVIr6qBY
	EVaFUfFJCD5hYqWsr3zDfMex1cjFs0h9fqYh3kokbADeYptA3IToMXZfkJw+SqZPyQAT72hIrBT
	HNdYzT5S/NYZH6RVW3b9JzsJIXBuE04IS1jqG1w
X-Google-Smtp-Source: AGHT+IHq6u/4AIG+O1oq71Zy5dzM6cZoHuGdo1nSrFvwbC9QDSx6PwHNBUTam12RFvIzhBOryUKFBBcpe/eyu+MXbrU=
X-Received: by 2002:ad4:5ced:0:b0:77e:dd3e:a0c9 with SMTP id
 6a1803df08f44-77edd3ea3d1mr2130156d6.14.1757816427569; Sat, 13 Sep 2025
 19:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910024447.64788-1-laoar.shao@gmail.com> <20250910024447.64788-5-laoar.shao@gmail.com>
 <a2c122f5-ab6a-4242-9db8-e5175d5b27b3@lucifer.local> <CALOAHbCSudQ9y1UdD4YjuUFGae5bRu8_0bgThJV4WgwLwtcwew@mail.gmail.com>
 <42226608-bbb1-4d58-9de7-dfbb3a38d064@lucifer.local>
In-Reply-To: <42226608-bbb1-4d58-9de7-dfbb3a38d064@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 14 Sep 2025 10:19:51 +0800
X-Gm-Features: AS18NWBsv--35q_kcFfQDULeKAOuuY0Oif44eGzcMAx_dTI7CPLBxPfXjMJKB3Q
Message-ID: <CALOAHbAx_Qpt50Knr765Gp63C_ad8m1+kaTFveWkuybhaN3uBw@mail.gmail.com>
Subject: Re: [PATCH v7 mm-new 04/10] mm: thp: enable THP allocation
 exclusively through khugepaged
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 9:48=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Sep 12, 2025 at 02:17:01PM +0800, Yafang Shao wrote:
> > On Thu, Sep 11, 2025 at 11:58=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Wed, Sep 10, 2025 at 10:44:41AM +0800, Yafang Shao wrote:
> > > > Currently, THP allocation cannot be restricted to khugepaged alone =
while
> > > > being disabled in the page fault path. This limitation exists becau=
se
> > > > disabling THP allocation during page faults also prevents the execu=
tion of
> > > > khugepaged_enter_vma() in that path.
> > >
> > > This is quite confusing, I see what you mean - you want to be able to=
 disable
> > > page fault THP but not khugepaged THP _at the point of possibly fault=
ing in a
> > > THP aligned VMA_.
> > >
> > > It seems this patch makes khugepaged_enter_vma() unconditional for an=
 anonymous
> > > VMA, rather than depending on the return value specified by
> > > thp_vma_allowable_order().
> >
> > The functions thp_vma_allowable_order(TVA_PAGEFAULT) and
> > thp_vma_allowable_order(TVA_KHUGEPAGED) are functionally equivalent
> > within the page fault handler; they always yield the same result.
> > Consequently, their execution order is irrelevant.
>
> It seems hard to definitely demonstrate that by checking !in_pf vs not in=
 this
> situation :) but it seems broadly true afaict.
>
> So they differ only in that one starts khugepaged, the other tries to
> establish a THP on fault via create_huge_pmd().

right

>
> >
> > The change reorders these two calls and, in doing so, also moves the
> > call to vmf_anon_prepare(vmf). This alters the control flow:
> > - before this change:  The logic checked the return value of
> > vmf_anon_prepare() between the two thp_vma_allowable_order() calls.
> >
> >     thp_vma_allowable_order(TVA_PAGEFAULT);
> >     ret =3D vmf_anon_prepare(vmf);
> >     if (ret)
> >         return ret;
> >     thp_vma_allowable_order(TVA_KHUGEPAGED);
>
> I mean it's also _only if_ the TVA_PAGEFAULT invocation succeeds that the
> TVA_KHUGEPAGED one happens.
>
> >
> >  - after this change: The logic now executes both
> > thp_vma_allowable_order() calls first and does not check the return
> > value of vmf_anon_prepare().
> >
> >     thp_vma_allowable_order(TVA_KHUGEPAGED);
> >     thp_vma_allowable_order(TVA_PAGEFAULT);
> >     ret =3D vmf_anon_prepare(vmf); // Return value 'ret' is ignored.
>
> Hm this is confusing, your code does:
>
> +       if (pmd_none(*vmf.pmd)) {
> +               if (vma_is_anonymous(vma))
> +                       khugepaged_enter_vma(vma, vm_flags);
> +               if (thp_vma_allowable_order(vma, vm_flags, TVA_PAGEFAULT,=
 PMD_ORDER)) {
> +                       ret =3D create_huge_pmd(&vmf);
> +                       if (!(ret & VM_FAULT_FALLBACK))
> +                               return ret;
> +               }
>
> So the ret is absolutely not ignored, but whether it succeeds or not, we =
still
> invoke khugepaged_enter_vma().
>
> Previously we would not have one this had vmf_anon_prepare() failed in
> do_huge_pmd_anonymous_page().
>
> Which I guess is what you mean?
>
> >
> > This change is safe because the return value of vmf_anon_prepare() can
> > be safely ignored. This function checks for transient system-level
> > conditions (e.g., memory pressure, THP availability) that might
> > prevent an immediate THP allocation. It does not guarantee that a
> > subsequent allocation will succeed.
> >
> > This behavior is consistent with the policy in hugepage_madvise(),
> > where a VMA is queued for khugepaged before a definitive allocation
> > check. If the system is under pressure, khugepaged will simply retry
> > the allocation at a more opportune time.
>
> OK. I do note though that the khugepaged being kicked off is at mm_struct=
 level.

The unit of operation for khugepaged is the mm_struct itself. It
processes the entire mm even when only a single VMA within it is a
candidate for a THP.

>
> So us trying to invoke khugepaged on the mm again is about.. something ha=
ving
> changed that would previously have prevented us but now doesn't?
>
> That is, a product of thp_vma_allowable_order() right?
>
> So probably a sysfs change or similar?
>
> But I guess it makes sense to hook in BPF whenever this is the case becau=
se this
> _could_ be the point at which khugepaged enters the mm, and we want to se=
lect
> the allowable order at this time.
>
> So on basis of the two checks being effectively equivalent (on assumption=
 this
> is always the case) then the change is fairly reasonable.

Yes, that is exactly what I mean.

>
> Though I would put this information, that the checks are equivalent, in t=
he
> commit message so it's really clear.

will add it.

--=20
Regards
Yafang

