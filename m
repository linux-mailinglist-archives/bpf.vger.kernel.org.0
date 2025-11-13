Return-Path: <bpf+bounces-74339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E52DC55354
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 02:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B713AA04E
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 01:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AAE16DEB3;
	Thu, 13 Nov 2025 01:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="br4bXwW6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B171339A4
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 01:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762996123; cv=none; b=ljhHHdEfPTS3COnyYMIBfZ7ipVF+Qo5iJNzzjCX75mV+0DzGjoiwOXq5rVRGnuYnfOpRRRqGJg/pzUkH1h2b3C+19S72nC62t7hOizgyAm6W2D9nyPIJoY8NUx0Df7+61XDcC/Ef1VPeE8vHT2pOjckIJbBz9lWySzWH0+M+nAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762996123; c=relaxed/simple;
	bh=XnCS8qyptf0vST4GZS/1xoTrNHeL4TsnW1n+M5/59r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jop44a+Cz1wg4jfbu0gg4zIrF1xzpmxeuPmRSuh3EIJEvINcZk9pSFw2lDVTvVr67enqeAY6ElpSoNqUPy+ExoS37yWJX3QswM+2vr9f/LSyJDz63lFKEHWy6Y1W9Ka8683gIOHRhTR8EuM16Uxv+DjHokm+zpMTEv1xf/VnQK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=br4bXwW6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47789cd2083so1787995e9.2
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 17:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762996120; x=1763600920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1N0CdywXWJkzs/uu4zmd/+dbG2bWTLP5dNFNQgQXHI=;
        b=br4bXwW6ABOfvVQGHQO2opeOE70zsfcbmFsshtsYyt7ERI5tBgfajaaO7xSYSkrvA0
         CwseO0y/lOUTGbcKaHV42vfc8Neuc4/xLb1Oa47Fzsy0b83RY5EG0bnPxWaTRk/ZM4kc
         mP+yZa2vK2hF0o4j5+Rtu/eyX8YiZcd/gzpYyo4XMweQ9Xkp7WKzA0pxGudLqanL+8kx
         QtDbEnNwGl/l2mFZz+z6tTh603yFqQTZLsaaKIxQswnJCKtpfa45hdIrzcD76oHVimqu
         rEJL2YSlUuxze54Wmb6Y4tb0zjLvkTuqbxaC/hcWFCDY/jUherqHRnMIYAivPSm9yZ+1
         DNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762996120; x=1763600920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v1N0CdywXWJkzs/uu4zmd/+dbG2bWTLP5dNFNQgQXHI=;
        b=MbBFDvU9lv6P55cAaTNCZhXsi+gCwEcY1VHUuGyYzprdyRdWrDJFvL1nBdo2ZKWt9e
         6xUHOb6LsRYXGwOaJz2XBlCoBnPesTac7KkSc/y9QAjqT6T476fF7RZZ69qQ4r7tNXBG
         Ok+uS4DgS7FWwKnaAhvUQCI/7jrq7o7lrQtbMA4oLS8oIVOG2eriFx74LOEqz5dUNkRn
         E6JTEDJ14qTX70g6GmEjfkAkC0AjAXUX4TRPYuwawVF0I78ZiS4O0t4FJBWPfZJCruCv
         UvLIKHP7By2U6Px26+cDEB6wSImIc531EtXJCyCK5oMUkYSbibCzlvIia38HAFNcfRg6
         wyjw==
X-Gm-Message-State: AOJu0YzFPBjEw1Rd7oHQ/8JQPT7bFkhOGOx0p/3jPmRRlbkHBNHwHidT
	niASUHwaEbz4fqPmPvNO/HHz8x12bApNyS3AOmRNx3z0NpW0FrTEVz+qVDhjF+EQCcD1QMJZCT+
	oLVhdZT/a6TFAf3cIhXoieqhnzxNhKP8=
X-Gm-Gg: ASbGncv5bLv+mEcxF99jaoXsGjbQfeShhxzUje7+Lu02yQzc6pP6TBh1VHMhSjLkBC0
	eg7j8tsN6+dn2SBqbno4CaTDJ47u5W08JmXmSiJY8S9l9eEz8f79rtoBUy4T6DmLt4XTU4mzptB
	IVcfL6u9OddlmNpfgR2QGYy9/IkchHTOxl/TDbIuao9B5M/h3IWFM+tz4TLFtU9td7iIG1YiPLf
	Dji4ul+a9kGdi6jR2AOh5tEoF1WcWgDRomBW/VIdZH3LD3hazFdafvdNFkMzBfrRSqWEPt8h1mY
	a867e4OxZu3iLrKC3Q==
X-Google-Smtp-Source: AGHT+IHrdqivMrcXOUdSQqkQ5q/xuu+cm4gPIwiWWnq4LgnVm65lEXQ3ZkHIrzLaVaBe1PMMO6UUWoLnb7OvB9JdtqM=
X-Received: by 2002:a05:6000:310b:b0:42b:3131:5434 with SMTP id
 ffacd0b85a97d-42b4bdb014emr4465781f8f.38.1762996119971; Wed, 12 Nov 2025
 17:08:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112175939.2365295-1-ameryhung@gmail.com> <20251112175939.2365295-3-ameryhung@gmail.com>
 <CAADnVQ+2OXNo99B2krjwOb5XeFhi6GUagotcyf36xvLDoHqmjw@mail.gmail.com>
 <CAMB2axM0-NF5F=O6Lq1WPbb8PJtdZrQaOTFKWApWEhfT7MD4hw@mail.gmail.com>
 <CAADnVQKWKC3oh6ycxE+tstYupwVsdbhYHOncnfTOFWLL2DmJjw@mail.gmail.com> <CAMB2axOEauSyi13-acjDJUB--8+V7ZUG+r2V=fATwZHDQjFH4w@mail.gmail.com>
In-Reply-To: <CAMB2axOEauSyi13-acjDJUB--8+V7ZUG+r2V=fATwZHDQjFH4w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Nov 2025 17:08:28 -0800
X-Gm-Features: AWmQ_bncqlcglG-GkdSa8mhOykpKralpcw0lL-lfG32KEXN81iXAz7zHpD57Y80
Message-ID: <CAADnVQL1aocxXXsrdy1RAPf+LGX_jVKe8sVXmC9cWCktUzS+aQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/2] bpf: Use kmalloc_nolock() in local
 storage unconditionally
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 1:15=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Wed, Nov 12, 2025 at 12:05=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Nov 12, 2025 at 11:51=E2=80=AFAM Amery Hung <ameryhung@gmail.co=
m> wrote:
> > >
> > > On Wed, Nov 12, 2025 at 11:35=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Wed, Nov 12, 2025 at 9:59=E2=80=AFAM Amery Hung <ameryhung@gmail=
.com> wrote:
> > > > >
> > > > > @@ -80,23 +80,12 @@ bpf_selem_alloc(struct bpf_local_storage_map =
*smap, void *owner,
> > > > >         if (mem_charge(smap, owner, smap->elem_size))
> > > > >                 return NULL;
> > > > >
> > > > > -       if (smap->bpf_ma) {
> > > > > -               selem =3D bpf_mem_cache_alloc_flags(&smap->selem_=
ma, gfp_flags);
> > > > > -               if (selem)
> > > > > -                       /* Keep the original bpf_map_kzalloc beha=
vior
> > > > > -                        * before started using the bpf_mem_cache=
_alloc.
> > > > > -                        *
> > > > > -                        * No need to use zero_map_value. The bpf=
_selem_free()
> > > > > -                        * only does bpf_mem_cache_free when ther=
e is
> > > > > -                        * no other bpf prog is using the selem.
> > > > > -                        */
> > > > > -                       memset(SDATA(selem)->data, 0, smap->map.v=
alue_size);
> > > > > -       } else {
> > > > > -               selem =3D bpf_map_kzalloc(&smap->map, smap->elem_=
size,
> > > > > -                                       gfp_flags | __GFP_NOWARN)=
;
> > > > > -       }
> > > > > +       selem =3D bpf_map_kmalloc_nolock(&smap->map, smap->elem_s=
ize, gfp_flags, NUMA_NO_NODE);
> > > >
> > > >
> > > > Pls enable CONFIG_DEBUG_VM=3Dy then you'll see that the above trigg=
ers:
> > > > void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
> > > > {
> > > >         gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_f=
lags;
> > > > ...
> > > >         VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
> > > >                                       __GFP_NO_OBJ_EXT));
> > > >
> > > > and benchmarking numbers have to be redone, since with
> > > > unsupported gfp flags kmalloc_nolock() is likely doing something wr=
ong.
> > >
> > > I see. Thanks for pointing it out. Currently the verifier determines
> > > the flag and rewrites the program based on if the caller of
> > > storage_get helpers is sleepable. I will remove it and redo the
> > > benchmark.
> >
> > yes. that part of the verifier can be removed too.
> > First I would redo the benchmark numbers with s/gfp_flags/0 in the abov=
e line.
>
> Here are the new numbers after setting gfp_flags =3D __GFP_ZERO and
> removing memset(0). BTW, the test is done on a physical machine. The
> numbers for sk local storage can change =C2=B11-2. I will try to increase
> the test iteration or kill other unnecessary things running on the
> machine to see if the number fluctuates less.

fyi gfp_zero is pretty much the same memset().
Shouldn't be any difference between __GFP_ZERO vs manual memset() after all=
oc.

> Socket local storage
> memory alloc     batch  creation speed              creation speed diff
> ---------------  ----   ------------------                         ----
> kzalloc           16    104.217 =C2=B1 0.974k/s  4.15 kmallocs/create
> (before)          32    104.355 =C2=B1 0.606k/s  4.13 kmallocs/create
>                   64    103.611 =C2=B1 0.707k/s  4.15 kmallocs/create
>
> kmalloc_nolock    16    100.402 =C2=B1 1.282k/s  1.11 kmallocs/create  -3=
.7%
> (after)           32    101.592 =C2=B1 0.861k/s  1.07 kmallocs/create  -2=
.6%
>                   64     98.995 =C2=B1 0.868k/s  1.07 kmallocs/create  -4=
.6%

could you perf record/report both to see where the difference comes from?
The only reason I could explain the difference is that kfree_nolock()
is hitting defer_free() case, but that shouldn't happen
in this microbenchmark. But if you see free_deferred_objects()
in perf report that would explain it.

