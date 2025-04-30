Return-Path: <bpf+bounces-57057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56500AA508B
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 17:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275B53B4BB2
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 15:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B5925DD10;
	Wed, 30 Apr 2025 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3gciKb1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FFB21D3E9
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746027466; cv=none; b=fMfgECoAOgepb06fjncU8HWKuKh7J+qqMSCX4nr55oAxYiHclfBTkqtUHRQT0cs0x8o4thYqvoFob3LX+tylpi/7t7yGyViSIfir+p+ipbvju1eC2NNzj1A3Bucs2F23oO/0QwBC0zdvlA3/ek6tQIc2MSMj2Ls+Yk9OEe+XJ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746027466; c=relaxed/simple;
	bh=RuAJprzu7NyXsgvs9CcaBrsKvp3KARm7+0n/jO2vnK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=W//DfH3zxAquLR7qO3WRoV4ViSvJzwSH9SfAzhUoHztVBxA72c6hmV9uwJmHFc2GZRpeycl+SmFhJhN2eUJ38nw1idKQECI567W+tqDmt4vwZK8RpMSsZc10BFiEsK+dQ2sQFwMf4rBX7SjWOCXgPmoviudVq1zQKzHvi4o37C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3gciKb1; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e900a7ce55so380886d6.3
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 08:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746027464; x=1746632264; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRw+yEq9weFB0BCZUYk2ytPuqJJHEMzPnj2c6RnUpAc=;
        b=k3gciKb1+5zks7sGF1GIT8pUJ6PMxyvxteG4O7QtmvA+Axe4WdQqmsQ6UY5jfrstAs
         PgYuEe3Ij5dsuU77v5f8P/f+bqYyGSztcTZAIFGRPZIHTefzgtKkvJ45R9so4ZZzjkvE
         2k8sHIyC0ft0bLn+bGGx0GI8ZyWuU0j72xDtK6hGZ/TSmd17m8yKHHqx1qcbU0RyOPEn
         WfHiI1W79dwPDnqMKHCQop0j13tDWwq7htrRWbqB+dOg16dcB/HIsmxhueGnL80Hytbk
         +ncw3nGCtTobdtwDeMNiFL/NnzJc0Ie8jGN/ZA6CmPe9gke2udNNrshr+nhp/6mgZ334
         hanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746027464; x=1746632264;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRw+yEq9weFB0BCZUYk2ytPuqJJHEMzPnj2c6RnUpAc=;
        b=PWrg249Q6BCjdAcEhTI5uf1haF3VYSU6nBpFs2UBzROyXtceepC1nJ1BovlwQcZgz7
         3zjc6pmGVCYLGqsnj2HIs+X5nBitn2MmsUyKPbTpoQfHevqItOYnJlRU85B7OtQpVnCY
         rygHa9AeIejeCcx9U2MNigyRTZh73qrU4mk9NNqhf18hkweHcADmwQegmROMPN8cK+ri
         o9E8ZuxTdwkg9Pnx+AEt9X8CUlKJqBWLSKK+ev9I5qDZ14V4IRJph8fZOpmNrbkdcsGz
         6vh6xcSIYx2TLbcJyOSgTqGNULG7PX+t5kCWpbFQUcX27a+KyigGrBfp1jsCuJiRAuny
         SGYw==
X-Forwarded-Encrypted: i=1; AJvYcCWdFdtNgskE4um4IsWccDmQ5IiR4WTVO8CdauC0bVs6TbXo7xRZgO6Ow0liy4bnGWZQQgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjnvuRFqcIyLf5RphnQOeTOyBuMVxFQzuklfO4BGjDBlHYthPU
	mUv9aUpoi8pZoIobx1oQZBPvPEAmkaK1kmJQeiGXwJUk+EGLhBnX9oZ8HpOvVs68fNt/s1rGcpf
	v8cN+yrEWOPVA+JzOhVTMfYknTP0=
X-Gm-Gg: ASbGncvgGykJ0nSygiQhBBnoLVYNCibAD0IgP4fgpc7iap+tfpIBLZ9WJiw6LGxMLvA
	WoQA0vuLEe9AXnfecFnRuRun2Gip8w5zvIybgqTtT1HboySf7pkSnPm6dn9wyRkk50N+9HqjPLH
	mURiuQMhkKiB58rREWxS85xdY=
X-Google-Smtp-Source: AGHT+IF+aq9iikENH60hZ845vHJlrkoG3zl+ByzpSrFg949If3QGHY7mdvnjsL9+gS6npDryLWtUYQDRULbZdL109is=
X-Received: by 2002:a05:6214:20cc:b0:6e0:f451:2e22 with SMTP id
 6a1803df08f44-6f4fe12ec22mr56109566d6.38.1746027463841; Wed, 30 Apr 2025
 08:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429024139.34365-1-laoar.shao@gmail.com> <D9J7UWF1S5WH.285Y0GXSUD30W@nvidia.com>
 <CALOAHbBfSat7-qOjKseEJy=w5MVF7um3vYKPCb0VMbEgw-KAuw@mail.gmail.com>
 <42ECBC51-E695-4480-A055-36D08FE61C12@nvidia.com> <CALOAHbCtBB81MKV5=rTM03qt=qCF-CWctCmF0xjxDo_sXwaOYw@mail.gmail.com>
 <8F000270-A724-4536-B69E-C22701522B89@nvidia.com> <mnv3jjbdqx3eqrcxjrn5eeql3kpcfa6jzyjihh2cdyvrd7ldga@3cmkqwudlomh>
In-Reply-To: <mnv3jjbdqx3eqrcxjrn5eeql3kpcfa6jzyjihh2cdyvrd7ldga@3cmkqwudlomh>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 30 Apr 2025 23:37:07 +0800
X-Gm-Features: ATxdqUHlw_D1Z2w46AQq5zzxERhtXm_FtWE0HLa0uRHO69s5Y3koPmM114Oe0y0
Message-ID: <CALOAHbCNrOqqTV9gZ8PeaS1fcaQJ-CkUcwvFsx6VjHTmaTHjgQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, David Hildenbrand <david@redhat.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 11:21=E2=80=AFPM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Zi Yan <ziy@nvidia.com> [250430 11:01]:
>
> ...
>
> > >>>>> Since multiple services run on a single host in a containerized e=
nvironment,
> > >>>>> enabling THP globally is not ideal. Previously, we set THP to mad=
vise,
> > >>>>> allowing selected services to opt in via MADV_HUGEPAGE. However, =
this
> > >>>>> approach had limitation:
> > >>>>>
> > >>>>> - Some services inadvertently used madvise(MADV_HUGEPAGE) through
> > >>>>>   third-party libraries, bypassing our restrictions.
> > >>>>
> > >>>> Basically, you want more precise control of THP enablement and the
> > >>>> ability of overriding madvise() from userspace.
> > >>>>
> > >>>> In terms of overriding madvise(), do you have any concrete example=
 of
> > >>>> these third-party libraries? madvise() users are supposed to know =
what
> > >>>> they are doing, so I wonder why they are causing trouble in your
> > >>>> environment.
> > >>>
> > >>> To my knowledge, jemalloc [0] supports THP.
> > >>> Applications using jemalloc typically rely on its default
> > >>> configurations rather than explicitly enabling or disabling THP. If
> > >>> the system is configured with THP=3Dmadvise, these applications may
> > >>> automatically leverage THP where appropriate
> > >>>
> > >>> [0]. https://github.com/jemalloc/jemalloc
> > >>
> > >> It sounds like a userspace issue. For jemalloc, if applications requ=
ire
> > >> it, can't you replace the jemalloc with a one compiled with --disabl=
e-thp
> > >> to work around the issue?
> > >
> > > That=E2=80=99s not the issue this patchset is trying to address or wo=
rk
> > > around. I believe we should focus on the actual problem it's meant to
> > > solve.
> > >
> > > By the way, you might not raise this question if you were managing a
> > > large fleet of servers. We're a platform provider, but we don=E2=80=
=99t
> > > maintain all the packages ourselves. Users make their own choices
> > > based on their specific requirements. It's not a feasible solution fo=
r
> > > us to develop and maintain every package.
> >
> > Basically, user wants to use THP, but as a service provider, you think
> > differently, so want to override userspace choice. Am I getting it righ=
t?
>
> Who is the platform provider in question?  It makes me uneasy to have
> such claims from an @gmail account with current world events..

It=E2=80=99s a small company based in China, called PDD=E2=80=94if that inf=
ormation is helpful.

>
> ...
>
> > >>>
> > >>> I chose not to include this in the self-tests to avoid the complexi=
ty
> > >>> of setting up cgroups for testing purposes. However, in patch #4 of
> > >>> this series, I've included a simpler example demonstrating task-lev=
el
> > >>> control.
> > >>
> > >> For task-level control, why not using prctl(PR_SET_THP_DISABLE)?
> > >
> > > You=E2=80=99ll need to modify the user-space code=E2=80=94and again, =
this likely
> > > wouldn=E2=80=99t be a concern if you were managing a large fleet of s=
ervers.
> > >
> > >>
> > >>> For service-level control, we could potentially utilize BPF task lo=
cal
> > >>> storage as an alternative approach.
> > >>
> > >> +cgroup people
> > >>
> > >> For service-level control, there was a proposal of adding cgroup bas=
ed
> > >> THP control[1]. You might need a strong use case to convince people.
> > >>
> > >> [1] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierr=
ez.asier@huawei-partners.com/
> > >
> > > Thanks for the reference. I've reviewed the related discussion, and i=
f
> > > I understand correctly, the proposal was rejected by the maintainers.
>
> More of the point is why it was rejected.  Why is your motive different?
>
> >
> > I wonder why your approach is better than the cgroup based THP control =
proposal.
>
> I think Matthew's response in that thread is pretty clear and still
> relevant.

Are you refering
https://lore.kernel.org/linux-mm/ZyT7QebITxOKNi_c@casper.infradead.org/
 or https://lore.kernel.org/linux-mm/ZyIxRExcJvKKv4JW@casper.infradead.org/
?

If it=E2=80=99s the latter, then this patchset aims to make sysadmins' live=
s easier.

> If it isn't, can you state why?
>
> The main difference is that you are saying it's in a container that you
> don't control.  Your plan is to violate the control the internal
> applications have over THP because you know better.  I'm not sure how
> people might feel about you messing with workloads,

It=E2=80=99s not a mess. They have the option to deploy their services on
dedicated servers, but they would need to pay more for that choice.
This is a two-way decision.

> but beyond that, you
> are fundamentally fixing things at a sysadmin level because programmers
> have made errors.

No, they=E2=80=99re not making mistakes=E2=80=94they simply focus on the
implementation details of their own services and don=E2=80=99t find it
worthwhile to dive into kernel internals. Their services run perfectly
well with or without THP.

> You state as much in the cover letter, yes?

I=E2=80=99ll try to explain it in more detail in the next version if that
would be helpful.

--=20
Regards
Yafang

