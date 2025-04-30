Return-Path: <bpf+bounces-57062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C32AA512C
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 18:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6A81BC45C7
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 16:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EFD261362;
	Wed, 30 Apr 2025 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SATxz8LI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C310017A2F5
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029232; cv=none; b=F7gezpX5rIzFzdAGdLEoL6YeLT3f/lba/Dv7DuvlYpGeJkq4/Hz//+PiVA2MdFSRds+KpRPGGP2WdOwcw2U4OzxirfxjmjgXJUAd2zelv+7BdgT4Vo9cklKQZ87v8UAvpObhmKi0fSDZqI1bJ0kiKOI0SuRD4cmjvMuVi/Ue6oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029232; c=relaxed/simple;
	bh=Bm70VS8QTHKZQKPTKa32166DugBYvk+up77svilcHv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=fZg0x6nIKKiG8VS+nI/Eoy1YQu0d6E27o6Gd3WpC42JsgzSlE+pXQ3rWKj8mCWbtCoI5JPmmMeqlkhiJoJgRpvwq7euoyKO9GNhOwscxvSz1wbRIf+wHS1wXZQNjcRPo3aF/Xyr2LkYSm903XYf6tPI/E2Eo7CpG7whszqvowz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SATxz8LI; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c56a3def84so723006885a.0
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746029229; x=1746634029; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zQ7ppAzBejUmFebxp620NG0aCIkVnqqLnTlpcMySAY=;
        b=SATxz8LIuoQPLANlfvxfA5K/5P8BdkKQmDavJSkzetSTgUmUTIQRUXyS5gZ2ES6Y/Y
         61wfk1tiJ0FdvwooNPDUD61YsZkDYAz/X331FkaH21HXRhaeuSIQMIlHsXo3GIdTXNZb
         F4ti0bSQF1UtEuWL/fF8DpecKvlsN0wTFUhKMlhMJdp7orwXWZIBZotP/MwGfAtrDq6R
         73VMdIEN6ZC+cShnfyzXHk+A+p0PI5dKgcX3cjoS8D8XlJDl0/gNrIEjkP4+llTuLdw8
         GLK+PBlxYNp6Ej4fzlsl3rivTn9EKoU8KuwUt8txKJjx+9/QnQZK4kbNpaqkFeu1nL3i
         dTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746029229; x=1746634029;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zQ7ppAzBejUmFebxp620NG0aCIkVnqqLnTlpcMySAY=;
        b=ssWqgEiaBnJ0i/XPjWdqJRrP3yIfLI6Oi2Migo6kSmOz3QlCobuWQA++LTrAoqxkCU
         n1aUBGpEUqrjqUcc3uh0use71VDtmMuz9BTseORGgthZQkEsoJKbfvF52yNb1G0Ng0oA
         5XzsfC4VG9Dut2wOBx1a6thl13ED/+toD7zZ2z21QDJZUdw6JFX5H/gY1YGOYSPLjPR9
         zesHlJhgV7BsTnI84EB6/6LUggHw8OULcSsPkg7haO0u2dF6rQolUg3WI3rxc7yhY8bi
         JluAPoMK87xB/7Q1TThncG7Hbm9kYLY/IzksWRmOPyLa+81sgqsk5MVcfz4CGNMk5tzu
         I64Q==
X-Forwarded-Encrypted: i=1; AJvYcCUiq9GOwyf+Tf49/vcL1qlGb0QiZ4sWoyS3jt6HN5z4QYNA0dKsc6o+OCnFCta0i+gToRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYeRekYrDHNbwa8wSAgvhCeCsvkVyQ+s0C4muLEZlYuYUzR4JP
	L2SPFob+4OwJdZge/PhfM8cRJjpVpwgCxKDtr6jZxekvcIhVl/CD4pijOSRwXCN4Q4lLysQLikS
	gaxeVb4qMJVFFhHdrYUESIoAEawU=
X-Gm-Gg: ASbGncupLgLkdwlZ5D326g2+0dYmPaGtqqoF7ac5/vLh36eg0niazQ4tdhaEaG6pJzD
	TEicYFTkxNn5FUr/l8iW2HNHr/kJmbZCX2+aGXfmxFfHJYSTjm9bIwlbXdoi2lXtW4zXnLog5AQ
	PsAHFT6Iw89u7GR8ftJTtF
X-Google-Smtp-Source: AGHT+IEK2iOkwSYxyslAnZkxkeJx6nWUyX7pEMGAel0zGMEm9adF85kps5SSwc/GgEtgjlzFX1smLnN4gAJsY7oETU4=
X-Received: by 2002:a05:6214:2a49:b0:6e6:61f1:458a with SMTP id
 6a1803df08f44-6f4fce68783mr66421376d6.14.1746029229284; Wed, 30 Apr 2025
 09:07:09 -0700 (PDT)
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
 <CALOAHbCNrOqqTV9gZ8PeaS1fcaQJ-CkUcwvFsx6VjHTmaTHjgQ@mail.gmail.com> <ygshjrctjzzggrv5kcnn6pg4hrxikoiue5bljvqcazfioa5cij@ijfcv7r4elol>
In-Reply-To: <ygshjrctjzzggrv5kcnn6pg4hrxikoiue5bljvqcazfioa5cij@ijfcv7r4elol>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 1 May 2025 00:06:31 +0800
X-Gm-Features: ATxdqUHJRWXK5-pSkGYEN5idIyqxJ3F5TfeWPFCUSpk63kWiycE8PWLRtr4NIBc
Message-ID: <CALOAHbCL-NOEeA1+t=D2F_q7UUi7GvkLDry5=SiehtWs1TKX1Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Zi Yan <ziy@nvidia.com>, akpm@linux-foundation.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, David Hildenbrand <david@redhat.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 11:53=E2=80=AFPM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Yafang Shao <laoar.shao@gmail.com> [250430 11:37]:
> > On Wed, Apr 30, 2025 at 11:21=E2=80=AFPM Liam R. Howlett
> > <Liam.Howlett@oracle.com> wrote:
> > >
> > > * Zi Yan <ziy@nvidia.com> [250430 11:01]:
> > >
> > > ...
> > >
> > > > >>>>> Since multiple services run on a single host in a containeriz=
ed environment,
> > > > >>>>> enabling THP globally is not ideal. Previously, we set THP to=
 madvise,
> > > > >>>>> allowing selected services to opt in via MADV_HUGEPAGE. Howev=
er, this
> > > > >>>>> approach had limitation:
> > > > >>>>>
> > > > >>>>> - Some services inadvertently used madvise(MADV_HUGEPAGE) thr=
ough
> > > > >>>>>   third-party libraries, bypassing our restrictions.
> > > > >>>>
> > > > >>>> Basically, you want more precise control of THP enablement and=
 the
> > > > >>>> ability of overriding madvise() from userspace.
> > > > >>>>
> > > > >>>> In terms of overriding madvise(), do you have any concrete exa=
mple of
> > > > >>>> these third-party libraries? madvise() users are supposed to k=
now what
> > > > >>>> they are doing, so I wonder why they are causing trouble in yo=
ur
> > > > >>>> environment.
> > > > >>>
> > > > >>> To my knowledge, jemalloc [0] supports THP.
> > > > >>> Applications using jemalloc typically rely on its default
> > > > >>> configurations rather than explicitly enabling or disabling THP=
. If
> > > > >>> the system is configured with THP=3Dmadvise, these applications=
 may
> > > > >>> automatically leverage THP where appropriate
> > > > >>>
> > > > >>> [0]. https://github.com/jemalloc/jemalloc
> > > > >>
> > > > >> It sounds like a userspace issue. For jemalloc, if applications =
require
> > > > >> it, can't you replace the jemalloc with a one compiled with --di=
sable-thp
> > > > >> to work around the issue?
> > > > >
> > > > > That=E2=80=99s not the issue this patchset is trying to address o=
r work
> > > > > around. I believe we should focus on the actual problem it's mean=
t to
> > > > > solve.
> > > > >
> > > > > By the way, you might not raise this question if you were managin=
g a
> > > > > large fleet of servers. We're a platform provider, but we don=E2=
=80=99t
> > > > > maintain all the packages ourselves. Users make their own choices
> > > > > based on their specific requirements. It's not a feasible solutio=
n for
> > > > > us to develop and maintain every package.
> > > >
> > > > Basically, user wants to use THP, but as a service provider, you th=
ink
> > > > differently, so want to override userspace choice. Am I getting it =
right?
> > >
> > > Who is the platform provider in question?  It makes me uneasy to have
> > > such claims from an @gmail account with current world events..
> >
> > It=E2=80=99s a small company based in China, called PDD=E2=80=94if that=
 information is helpful.
>
> Thanks.
>
> >
> > >
> > > ...
> > >
> > > > >>>
> > > > >>> I chose not to include this in the self-tests to avoid the comp=
lexity
> > > > >>> of setting up cgroups for testing purposes. However, in patch #=
4 of
> > > > >>> this series, I've included a simpler example demonstrating task=
-level
> > > > >>> control.
> > > > >>
> > > > >> For task-level control, why not using prctl(PR_SET_THP_DISABLE)?
> > > > >
> > > > > You=E2=80=99ll need to modify the user-space code=E2=80=94and aga=
in, this likely
> > > > > wouldn=E2=80=99t be a concern if you were managing a large fleet =
of servers.
> > > > >
> > > > >>
> > > > >>> For service-level control, we could potentially utilize BPF tas=
k local
> > > > >>> storage as an alternative approach.
> > > > >>
> > > > >> +cgroup people
> > > > >>
> > > > >> For service-level control, there was a proposal of adding cgroup=
 based
> > > > >> THP control[1]. You might need a strong use case to convince peo=
ple.
> > > > >>
> > > > >> [1] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gut=
ierrez.asier@huawei-partners.com/
> > > > >
> > > > > Thanks for the reference. I've reviewed the related discussion, a=
nd if
> > > > > I understand correctly, the proposal was rejected by the maintain=
ers.
> > >
> > > More of the point is why it was rejected.  Why is your motive differe=
nt?
> > >
> > > >
> > > > I wonder why your approach is better than the cgroup based THP cont=
rol proposal.
> > >
> > > I think Matthew's response in that thread is pretty clear and still
> > > relevant.
> >
> > Are you refering
> > https://lore.kernel.org/linux-mm/ZyT7QebITxOKNi_c@casper.infradead.org/
> >  or https://lore.kernel.org/linux-mm/ZyIxRExcJvKKv4JW@casper.infradead.=
org/
> > ?
> >
> > If it=E2=80=99s the latter, then this patchset aims to make sysadmins' =
lives easier.
>
> Both, really.  Your patch gives the sysadm another knob to turn and know
> when to turn it.  Matthew is suggesting we should know when to do the
> right thing and avoid a knob in the first place.

The problem is that there's no proper mechanism to control THP at the
container level. From the moment we introduced containers and cgroups,
the goal has been to manage all resources through cgroups. Of course,
implementing everything at once wasn=E2=80=99t feasible, so we added
controllers incrementally=E2=80=94and we=E2=80=99re still introducing new o=
nes even
today, aren=E2=80=99t we? Now, with BPF, we have a more flexible way to
achieve this=E2=80=94so why not use it?

I believe we should focus on making life easier for users, not just
sysadmins. That philosophy has been a driving force behind the
continued development of the Linux kernel.

>
> >
> > > If it isn't, can you state why?
> > >
> > > The main difference is that you are saying it's in a container that y=
ou
> > > don't control.  Your plan is to violate the control the internal
> > > applications have over THP because you know better.  I'm not sure how
> > > people might feel about you messing with workloads,
> >
> > It=E2=80=99s not a mess. They have the option to deploy their services =
on
> > dedicated servers, but they would need to pay more for that choice.
> > This is a two-way decision.
>
> This implies you want a container-level way of controlling the setting
> and not a system service-level?

Right. We want to control the THP per container.

>  I guess I find the wording of the
> problem statement unclear.
>
> >
> > > but beyond that, you
> > > are fundamentally fixing things at a sysadmin level because programme=
rs
> > > have made errors.
> >
> > No, they=E2=80=99re not making mistakes=E2=80=94they simply focus on th=
e
> > implementation details of their own services and don=E2=80=99t find it
> > worthwhile to dive into kernel internals. Their services run perfectly
> > well with or without THP.
> >
> > > You state as much in the cover letter, yes?
> >
> > I=E2=80=99ll try to explain it in more detail in the next version if th=
at
> > would be helpful.
>
> Yes, I think so.
>
> Thanks,
> Liam



--=20
Regards
Yafang

