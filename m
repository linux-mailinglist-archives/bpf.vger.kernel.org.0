Return-Path: <bpf+bounces-75630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5395C8CAD5
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 03:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 667393518A3
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 02:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C3026D4F9;
	Thu, 27 Nov 2025 02:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2XM1mcE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E793B26B95B
	for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 02:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764210995; cv=none; b=LlaXT7E3ZJoVH8TWW14xGFlFc3vkItS/drEBA/TclsnPS1o/nMi/K/DQJoEgHJ4tbUpvA3QZT6uWeGm3sRloj2cXVq1qpD+2jJetA/+w1OH4SzPcWtcxnZKdLPh5Mj0Rs4Lv0qL+Lv9IaOVslWd9nHlYqg1KQ/yshY0faf4X3H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764210995; c=relaxed/simple;
	bh=6lsSEDghUHNyP6w2EoWt1EQeRkZUMyIncrYhfu2hxPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSYdaF1+cV8SeVNmjOJkcaBm2FOCABhC1KNS0GzivRIDcensTa4aSHWZKhPyDJYGDgblad+Hn1sxkGs26SZIIsX3S84C6PNv5i2DYbl6Y/JKiQcfOKE5S1+F8WNGb6w2Fxm6mapmvajkRd/hnTLQQoU57QqPyNTv2tL/gl3+W6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2XM1mcE; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78a6c7ac38fso4580727b3.0
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 18:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764210992; x=1764815792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dG4CF2IMP7M0Y+1dFumBVpCBxoZ8uo+lnVXyk35N/v0=;
        b=J2XM1mcEvryeuPEXjjShcZS7U6Nydqt0U9LoxlVoKY5KhcGVWnD8qQqK82vCYK8rSs
         aoALUAOmqtz+ljrPkDU2fCQFIQCRtPN5uCd6/UnGNmFWtsncmbOFYruo1SChLsaRyEVJ
         HC0JUm/Az0W58PiaBEFFpkFW6Zhrq+UgZFKeQ85+x/odV4reTu0nJ7f1yX89gxv/WxRP
         GULL1u7zMvKewppQwUYEH13Rfnbv1YlC4ncbUkbkMACEHbvPF64cjyZNh0sXkJ2ClEzr
         yAuO/ozwVY6SM9gHNeETuQUnV4Xa4/MzSEZ4pt5RV9m0vYlHskTL7KbYaNJSaGA21PPM
         GIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764210992; x=1764815792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dG4CF2IMP7M0Y+1dFumBVpCBxoZ8uo+lnVXyk35N/v0=;
        b=tQ4iAyVvwt20atCNghbjQjdcF0igDYRFwfj6qROWKHZ8OK/HcM0fbpWxmskgXgzBtg
         KZYEq/LErtPXjNCRnfdBhU8QVxDymOHRfXoEYwJgSj2nVpeTPJMBN55DlKPtr2LnoakP
         31lsN4tWzc8gGy4RfBAM6RUnFvV9BhyB0z5YvSIOXEcaKVmoYL5slpYckySmTU5mhD+g
         O2y1zgpODY1DF3abx7SgLE82Sj+2DljhrZ9+GykRGJNSB+nPqkvIf5Dj0VgTklrUqOHL
         f6kTU5+MT6gRaly3M9YglP05+98c6sVCZhr3mCaBcrtUur6EMk5swOL8H4Br+OHavqOu
         zaUw==
X-Forwarded-Encrypted: i=1; AJvYcCVNqGcb1rvUbr0fIAa3ChAy+rSkWjMz/9YIo/Hm3b0SKiP5ztGA79e/Tn56GKi+AGELLNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUduSwKIyGqDVb0e8GKCXcoVOwUv4pg5API9YiStJAK0CqrgRA
	5JrZO85v5qFxkm9ui6c6HmHqBgzUpuNp4GpSlDgH9OSJSK3Jf4fe9uPxPpU0a2IlT0eVG9vZmnI
	BdR0ti2L9EpiuVH2FfAHAvU+NOr1E3Zg=
X-Gm-Gg: ASbGncswmukpts1VT8M3GLIuM2Lwc2EmXsL1mrZjKR1DO1mqX32DVeo93npK3ZuPu9J
	bTFQbKCzhmiyqKxWGxNaQzts0YJzJmyKiumpFYyox4XlhUDKZQ9G3a+CtMu2IZSDnhAAL/T9MPM
	wVNsFwbttCXa/0DbgHeMr2GiT+Z1loSb/ejZh60ySeny59ygnZgjbM6BasIzzQpE70M1C7Fq0VX
	1dls+TR44/rY2oQqlckt+tRQYO5ZKkVJ2iU0XuANN8RdZExi9AIwePklYR/2re28GFnzA3cbLWv
	tNmZDqw=
X-Google-Smtp-Source: AGHT+IEfDA/1rHeriKTtWS6bCyAPbkv++vWNjxf3ZtzQfH/D7x8K9kI181xzUZI2IDSfMgR8uq8FIQ6PZ94MkZtBzVQ=
X-Received: by 2002:a05:690c:6087:b0:786:5926:edab with SMTP id
 00721157ae682-78a8b491ceamr194700327b3.17.1764210991823; Wed, 26 Nov 2025
 18:36:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026100159.6103-1-laoar.shao@gmail.com> <20251026100159.6103-7-laoar.shao@gmail.com>
 <CAADnVQKziFmRiVjDpjtYcmxU74VjPg4Pqn2Ax=O2SsfjLLy5Zw@mail.gmail.com> <177c8e4d0567456baecc962bf5c1038f05358cc0.camel@surriel.com>
In-Reply-To: <177c8e4d0567456baecc962bf5c1038f05358cc0.camel@surriel.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 27 Nov 2025 10:35:55 +0800
X-Gm-Features: AWmQ_blljVhaUoneZ62O-qRbUJWn4XyE-NLR9m4vdRR0mJlvaxy3SlytZXAid4o
Message-ID: <CALOAHbCeRZO6vy6qmnG9OgttpTDBtymrvrUZk4+kRmiN4xrpRg@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 06/10] mm: bpf-thp: add support for global mode
To: Rik van Riel <riel@surriel.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, Johannes Weiner <hannes@cmpxchg.org>, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, Matthew Wilcox <willy@infradead.org>, 
	Amery Hung <ameryhung@gmail.com>, David Rientjes <rientjes@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Barry Song <21cnbao@gmail.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, lance.yang@linux.dev, 
	Randy Dunlap <rdunlap@infradead.org>, Chris Mason <clm@meta.com>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 11:13=E2=80=AFPM Rik van Riel <riel@surriel.com> wr=
ote:
>
> On Tue, 2025-10-28 at 18:32 -0700, Alexei Starovoitov wrote:
> > On Sun, Oct 26, 2025 at 3:03=E2=80=AFAM Yafang Shao <laoar.shao@gmail.c=
om>
> > wrote:
> > >
> > > The per-process BPF-THP mode is unsuitable for managing shared
> > > resources
> > > such as shmem THP and file-backed THP. This aligns with known
> > > cgroup
> > > limitations for similar scenarios [0].
> > >
> > > Introduce a global BPF-THP mode to address this gap. When
> > > registered:
> > > - All existing per-process instances are disabled
> > > - New per-process registrations are blocked
> > > - Existing per-process instances remain registered (no forced
> > > unregistration)
> > >
> > > The global mode takes precedence over per-process instances.
> > > Updates are
> > > type-isolated: global instances can only be updated by new global
> > > instances, and per-process instances by new per-process instances.
> >
> > ...
> >
> > >         spin_lock(&thp_ops_lock);
> > > -       /* Each process is exclusively managed by a single BPF-THP.
> > > */
> > > -       if (rcu_access_pointer(mm->bpf_mm.bpf_thp)) {
> > > +       /* Each process is exclusively managed by a single BPF-THP.
> > > +        * Global mode disables per-process instances.
> > > +        */
> > > +       if (rcu_access_pointer(mm->bpf_mm.bpf_thp) ||
> > > rcu_access_pointer(bpf_thp_global)) {
> > >                 err =3D -EBUSY;
> > >                 goto out;
> > >         }
> >
> > You didn't address the issue and instead doubled down
> > on this broken global approach.
> >
> > This bait-and-switch patchset is frankly disingenuous.
> > 'lets code up some per-mm hack, since people will hate it anyway,
> > and I'm not going to use it either, and add this global mode
> > as a fake "fallback"...'
>
> Should things be the other way around, where
> per-process BPF THP policy overrides global
> policy?

Makes sense

>
> I can definitely see a use for global policy,
> but also a reason to override it for some
> programs or containers.

We have deployed BPF-THP across nearly all of our fleets for over six
months and have enabled THP for dozens of our services.

Based on our practical experience, the global mode has proven highly
useful as it establishes a default policy for all services. When a
specific THP policy is required for a particular service, we implement
it using dedicated BPF maps=E2=80=94such as thp-always, thp-madvise,
thp-never, or other custom policy maps.

That said, I also find value in combining a default global policy with
the ability to override it for certain processes or containers.

The global mode and the per-process/cgroup mode are not mutually
exclusive; they can coexist.

Through our use of BPF-THP, we have found that the most reliable
approach is to allocate all THP at the initial stage. If a service
dynamically allocates a large number of THP during runtime, it can
easily trigger compaction stalls=E2=80=94even on the latest upstream kernel=
.
Therefore, monitoring compaction stalls and memory pressure is
essential to determine when a service should stop allocating
additional THP.


--
Regards
Yafang

