Return-Path: <bpf+bounces-72920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 640E4C1D9AE
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 23:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8910C3B4441
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 22:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87B22DC788;
	Wed, 29 Oct 2025 22:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVetzJTD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747562D594F
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 22:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761777834; cv=none; b=uRisPPwzIVUcMVhcW/zE9q5yklX/jF2PlGmsh0qb1mDZFChmPRWc+whdfiwBaIkYd4bMUJXyuiNaozjqg8ZvB9Za8Rgqh1vtcbeq1Y3RQYpL+IOGi+zVxHQAtNGbEFRmmcq5mbGYI1xykANwmH2uhyxwl4aPyWA69Sxun/hFiyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761777834; c=relaxed/simple;
	bh=wik67zmjPJSCJArpOPAfO/nO0IlbnlsMUwHITZGrZG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJn3ZrRD0lnT7H3PukAuiczE4FHrH8svAf9+wlSxYlvEkIqJkKTfWZFAdbEqKZSEkgS4JdNSRvwDhZg/ADHaMGDVgPu/bC6EATbayqyIeAnvwUi+FP7LXjJjTCnI4KlrEbauB9VsA8H6XGdLXcewwNK0ifSoLIKJJ1cdvn1hswc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVetzJTD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47109187c32so1916765e9.2
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 15:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761777831; x=1762382631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wik67zmjPJSCJArpOPAfO/nO0IlbnlsMUwHITZGrZG0=;
        b=mVetzJTDY0XFXAtlvcIJX5FAgxmXcYfXKlq4L9Wk41tl6eZE5gPwzN45+3JMagE4IA
         izbJSFbKJbgFSjnGiW4xy36dC8VNK0AAD2WIKqPcYf1HfpPJ0M5HSZtUh2iqNJWeYdAI
         lf34qx+wGlKR2+ty15cf39qU8F77q12LRh+xLftRL08FTHdALhPZM/bzugjF7arqheFE
         nOHEcE3tWch2X12QFKWmZgRyJieoK4PS5BrbP4xX7U01SmV66sOwULwcLxoKVHN4kOWO
         FjgUNp+LOP+M+IAeiB+EWYIWOy9uaoV+SE9KC3SC77voiSSh73Bh8DrMFUB2vKQuLja7
         hVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761777831; x=1762382631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wik67zmjPJSCJArpOPAfO/nO0IlbnlsMUwHITZGrZG0=;
        b=dtG5/EPwzL/Kfjb/XH9+QtTmma204gJLoRehUIqSqn2rj+Yai1aNR92yEm0ASLmZEq
         jTRbsTKNm04eSzNSrtdIeN8ir+uIYUFRemx30hmk5caOFmbYWT4tc8cWY/c2BGCOpNyU
         dzSgaHc10TT7xOigS2f3HQ7ALf6tr34qeeLBipSLCDkfcdg6S/YHpNBHY5HHnpk5LVSI
         FYRvItn7GEnwm7+vlqDMjRHSDkOJ/mUw+lkZUR6m4lh5JaIM184ipO0U+zeHCoUsNr+x
         KA7N0prcRl5/6z4uUns5RQKjJQZJ/QN0y53MR5NlJK/nNty+5amc+qNVY+een7pZY1qU
         +GFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwL3f5DG3f2VqB8WYJ2K7+R5W1JD503Majz4pGlU4/J2Gn8ZF+LpoeigiPCe0KBcoSjCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3L6pR6BcPR3V7L3FGxzhAwNG5cnU5L0aICA6O+EMYUXSCunjG
	3n2F4nA7MeIA2dMpugAD4zM/ssRSt595q8Wb5uAEnC3KCwM8ypfdNDv9+KIjyfV6RJAQ2UXhniP
	2h0xQYHUiF+uMNe9e1oXL0oZkvspieMHjiQ==
X-Gm-Gg: ASbGnctjfMkACEO/TK0wJRcbUeh6xQkSpWQgAh4+0kpiWHA2ejDhd29dpk4lrdqyIrR
	1oZfa/llSlazDa9SVKz8wrOYueTgEUqOaBKNGCXDvu8RNalcZqIvoxsV43bIc4P9XoHdCerL7ET
	cf6jkUF+i6IH7sHdG+9HWAxR4ZsiYe7qJ3w4rA/xrgX9TwYEjdUC7/lsoYyKH4ZatK3J5Pr65Dt
	5pUIitAoIdz6w6WaloEnfX5VnruxRRmK5YVBI91bA3cQKB9fjM1lvMb9tkkTmNAe8siEFmtRaGm
	A5vhxZwFsoJ7iQVpEgMoBtj1IE8W
X-Google-Smtp-Source: AGHT+IGgG3j4M2SQf3XFssiae2E5GaU0Oz0HOJLZDxtGjEKIMo/1gRVHcuNdOoC/ksGXyg/SfrIqUSHv9CMrDZOG1Sg=
X-Received: by 2002:a05:600c:3e07:b0:46e:48fd:a1a9 with SMTP id
 5b1f17b1804b1-4771e3fbdcemr39702415e9.33.1761777830545; Wed, 29 Oct 2025
 15:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev> <aQJZgd8-xXpK-Af8@slm.duckdns.org>
 <87ldkte9pr.fsf@linux.dev> <aQJ61wC0mvzc7qIU@slm.duckdns.org>
 <CAHzjS_vhk6RM6pkfKNrDNeEC=eObofL=f9FZ51tyqrFFz9tn1w@mail.gmail.com> <871pmle5ng.fsf@linux.dev>
In-Reply-To: <871pmle5ng.fsf@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Oct 2025 15:43:39 -0700
X-Gm-Features: AWmQ_bklQRlCeWMvvDMXXjosBJpVWn26QkhuJgrczs1PBday5NsqxYLilK9uBkc
Message-ID: <CAADnVQJ+4a97bp26BOpD5A9LOzfJ+XxyNt4bdG8n7jaO6+nV3Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops to cgroups
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Song Liu <song@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:53=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Song Liu <song@kernel.org> writes:
>
> > Hi Tejun,
> >
> > On Wed, Oct 29, 2025 at 1:36=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote=
:
> >>
> >> On Wed, Oct 29, 2025 at 01:25:52PM -0700, Roman Gushchin wrote:
> >> > > BTW, for sched_ext sub-sched support, I'm just adding cgroup_id to
> >> > > struct_ops, which seems to work fine. It'd be nice to align on the=
 same
> >> > > approach. What are the benefits of doing this through fd?
> >> >
> >> > Then you can attach a single struct ops to multiple cgroups (or Idk
> >> > sockets or processes or some other objects in the future).
> >> > And IMO it's just a more generic solution.
> >>
> >> I'm not very convinced that sharing a single struct_ops instance acros=
s
> >> multiple cgroups would be all that useful. If you map this to normal
> >> userspace programs, a given struct_ops instance is package of code and=
 all
> >> the global data (maps). ie. it's not like running the same program mul=
tiple
> >> times against different targets. It's more akin to running a single pr=
ogram
> >> instance which can handle multiple targets.
> >>
> >> Maybe that's useful in some cases, but that program would have to expl=
icitly
> >> distinguish the cgroups that it's attached to. I have a hard time imag=
ining
> >> use cases where a single struct_ops has to service multiple disjoint c=
groups
> >> in the hierarchy and it ends up stepping outside of the usual operatio=
n
> >> model of cgroups - commonality being expressed through the hierarchica=
l
> >> structure.
> >
> > How about we pass a pointer to mem_cgroup (and/or related pointers)
> > to all the callbacks in the struct_ops? AFAICT, in-kernel _ops structur=
es like
> > struct file_operations and struct tcp_congestion_ops use this method. A=
nd
> > we can actually implement struct tcp_congestion_ops in BPF. With the
> > struct tcp_congestion_ops model, the struct_ops map and the struct_ops
> > link are both shared among multiple instances (sockets).
>
> +1 to this.
> I agree it might be debatable when it comes to cgroups, but when it comes=
 to
> sockets or similar objects, having a separate struct ops per object
> isn't really an option.

I think the general bpf philosophy that load and attach are two
separate steps. For struct-ops it's almost there, but not quite.
struct-ops shouldn't be an exception.
The bpf infra should be able to load a set of progs (aka struct-ops)
and attach it with a link to different entities. Like cgroups.
I think sched-ext should do that too. Even if there is no use case
today for the same sched-ext in two different cgroups.
For bpf-oom I can imagine a use case where container management sw
would pre-load struct-ops and then attach it later to different
containers depending on container configs. These container might
be peers in hierarchy, but attaching to their parent won't be
equivalent, since other peers might not need that bpf-oom management.
The "workaround" could be to create another cgroup layer
between parent and container, but that becomes messy, since now
there is a cgroup only for the purpose of attaching bpf-oom to it.

Whether struct-ops link attach is using cgroup_fd or cgroup_id
is debatable. I think FD is cleaner.

