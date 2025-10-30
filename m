Return-Path: <bpf+bounces-72955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37F6C1DF6A
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 01:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6596188E23F
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E54C22422B;
	Thu, 30 Oct 2025 00:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WE1r/S04"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5FE1C2BD
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 00:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761785844; cv=none; b=TEvAFPY2V97ktWH980LLUmxqp5HcHhSBSwVDBM/QjBSB+2JVFP2IaM3g0IeFkauVIKsLkL+SWkYj6CS7kONH/SWWTl8FZYKn7pgMG3EhE7Npnl2+61W5zkIy4GO4xcm3D/5E5fR7GdSu8qd9EF395yNTIdLr6qaVeYVGg+DrtMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761785844; c=relaxed/simple;
	bh=HCBqT6c9oEmlOq+w8pWXt9F7ZD8iSND1Iy+pqe2VdBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEtFjlUyTga62AuVl9/qhn0wjaLuxzYEpS6zQlPJFJzrWE+OJw8nGMjZldvDJOQBevUzG4EwzVPY7JntthiZw7VCmta51SWzrCQz7U+WyiEnB/NKMiNdYt7se21TuDTbnNM9C5ibrEkefNJ/y0YVCj4ZsuuFUQLaG/l34DMnO+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WE1r/S04; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4711b95226dso5554565e9.0
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 17:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761785840; x=1762390640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGOSLQUTALcsgNMy+aMsU9t+nwOQ+f3KSncHX5+6nPo=;
        b=WE1r/S04nSz74W28OGCOI0BmfUAT2kogRonQADh9WS/Z66leMeeLRGO6EzuRIJohdT
         v0vseCjtt20JJJXng3o2UWbwhUwq7X+4QAKuX9eI7BLHmUELY9hN6mqHYKeh9HCYiAWk
         PL3Pwdnl7w556wtaITV+ud8Ujm6tLl9mjbMCH+X+lnXWvn3D8R9IORAvaXXqMI4d3xsZ
         XLatZTprLU+yo3wPWQGPJuYiszXyFt19mS9LdLe924s74a0Nh5+kZil4jVC+41pGlo6D
         2eX8s0Y6Cj7KnoDvGXRxuNXBdE8slAjlmxA1GxZXpaTJTBDi0t/KnCRBlLfApU8NTFI5
         CdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761785840; x=1762390640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGOSLQUTALcsgNMy+aMsU9t+nwOQ+f3KSncHX5+6nPo=;
        b=EXQ3xoJ2MLFten0V8NGp+JGndztB5a4egDHZF88zEyD0LnzRwRfGBUKcfwnSIZTVCY
         VCHqVAV27RUas0poF6OP+VcceuPBTmLeAct+oaDvlWzsu351bXhyJTfH7Ghssuj4OjIH
         wRWUCbcYnjtK2WQVHUPqrEz2Hjw1LuPdue7i37OiKWastW59GmP/Cn9BoKld29AnlrV5
         bJxAWTLwRyCGxZMy/+KuhOTkbUNyHanzDj6vHh9nJd4M/Qy+WV6fcPj8N78ZgLmRDxWu
         pfngbBSeiQ8iEO8l07OLHUhWB64zJzRLqSX1CZ20Odrw/mDHuyBRvgTTenEC+bclebF1
         PMrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD+7o3W/rZE0ZWt9f3XHB8pka+f9FZBKIYgUEIfC8FZDi+ER67GoEOcCBhYTzEaYu9BfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWmFqWsbpvbnfly4W1MhB4iUJ22mDDhwP1/RKTCG+gBfwxcF8v
	Q5v2wxDi7ljWqidb8TeZjkq3y2gWYZ3qVVxv2tGI02tOm1FwecnyNAnPM2RHxoarOAYK5yx6t1s
	OIj+NMW0ezV1YeRSedkeQWk1gXbYKCLw=
X-Gm-Gg: ASbGncvzz34u27yS4FkBAeFZDiL4l0/tRQgEkuDl/0OGYKjLgT4gKmiO9NXBNi4FVKX
	I2Ql26YutunngYQHOThnKHP0yQd3LrgQA0COB5WYq3t5vHX9VvKQv6r8M9fYb3G/LMGflos502O
	ucNurIcdWkuV8iwhdMJDb739JH2UHRlfXknM+p0tJ0yc+TB/KJtRA2Qwo+Mb9yyP87Myn6fzK3P
	lY99RO1vIClfdjVL0NvWWal5xw26Ch1Z9B5UApdlFL/kApPpx05I+yr0lp1wOuQckV7/+Vu/ef7
	/puDIImP/kexhUHfnQ==
X-Google-Smtp-Source: AGHT+IE8ujPhUrddhGr1ou5jGncEGSlrHU/1FNSJfOObUCYG1pNyel0Awu+5uZ4HHENyvHOHjZC7HyCZC9+zzKwILg8=
X-Received: by 2002:a05:600c:3d98:b0:46e:36f8:1eb7 with SMTP id
 5b1f17b1804b1-4771e39f7f7mr33114585e9.10.1761785840454; Wed, 29 Oct 2025
 17:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026100159.6103-1-laoar.shao@gmail.com> <20251026100159.6103-7-laoar.shao@gmail.com>
 <CAADnVQKziFmRiVjDpjtYcmxU74VjPg4Pqn2Ax=O2SsfjLLy5Zw@mail.gmail.com> <CALOAHbD+9gxukoZ3OQvH2fNH2Ff+an+Dx-fzx_+mhb=8fZZ+sw@mail.gmail.com>
In-Reply-To: <CALOAHbD+9gxukoZ3OQvH2fNH2Ff+an+Dx-fzx_+mhb=8fZZ+sw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Oct 2025 17:57:09 -0700
X-Gm-Features: AWmQ_bl2FRWYQe1q3u6mxOkWzHju5ssI-I6pfEKXXZzZ5UwL_V6B6USXxdaH9OQ
Message-ID: <CAADnVQK9kp_5zh0gYvXdJ=3MSuXTbmZT+cah5uhZiGk5qYfckw@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 06/10] mm: bpf-thp: add support for global mode
To: Yafang Shao <laoar.shao@gmail.com>
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

On Tue, Oct 28, 2025 at 7:14=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Wed, Oct 29, 2025 at 9:33=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sun, Oct 26, 2025 at 3:03=E2=80=AFAM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > The per-process BPF-THP mode is unsuitable for managing shared resour=
ces
> > > such as shmem THP and file-backed THP. This aligns with known cgroup
> > > limitations for similar scenarios [0].
> > >
> > > Introduce a global BPF-THP mode to address this gap. When registered:
> > > - All existing per-process instances are disabled
> > > - New per-process registrations are blocked
> > > - Existing per-process instances remain registered (no forced unregis=
tration)
> > >
> > > The global mode takes precedence over per-process instances. Updates =
are
> > > type-isolated: global instances can only be updated by new global
> > > instances, and per-process instances by new per-process instances.
> >
> > ...
> >
> > >         spin_lock(&thp_ops_lock);
> > > -       /* Each process is exclusively managed by a single BPF-THP. *=
/
> > > -       if (rcu_access_pointer(mm->bpf_mm.bpf_thp)) {
> > > +       /* Each process is exclusively managed by a single BPF-THP.
> > > +        * Global mode disables per-process instances.
> > > +        */
> > > +       if (rcu_access_pointer(mm->bpf_mm.bpf_thp) || rcu_access_poin=
ter(bpf_thp_global)) {
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
> >
> > The way the previous thread evolved and this followup hack
> > I don't see a genuine desire to find a solution.
> > Just relentless push for global mode.
> >
> > Nacked-by: Alexei Starovoitov <ast@kernel.org>
> >
> > Please carry it in all future patches.
>
> To move forward, I'm happy to set the global mode aside for now and
> potentially drop it in the next version. I'd really like to hear your
> perspective on the per-process mode. Does this implementation meet
> your needs?

Attaching st_ops to task_struct or to mm_struct is a can of worms.
With cgroup-bpf we went through painful bugs with lifetime
of cgroup vs bpf, dying cgroups, wq deadlock, etc. All these
problems are behind us. With st_ops in mm_struct it will be more
painful. I'd rather not go that route.

And revist cgroup instead, since you were way too quick
to accept the pushback because all you wanted is global mode.

The main reason for pushback was:
"
Cgroup was designed for resource management not for grouping processes and
tune those processes
"

which was true when cgroup-v2 was designed, but that ship sailed
years ago when we introduced cgroup-bpf.
None of the progs are doing resource management and lots of infrastructure,
container management, and open source projects use cgroup-bpf
as a grouping of processes. bpf progs attached to cgroup/hook tuple
only care about processes within that cgroup. No resource management.
See __cgroup_bpf_check_dev_permission or __cgroup_bpf_run_filter_sysctl
and others.
The path is current->cgroup->bpf_progs and progs do exactly
what cgroup wasn't designed to do. They tune a set of processes.

You should do the same.

Also I really don't see a compelling use case for bpf in THP.
Your selftest is beyond primitive:
+int pmd_order;
+
+SEC("struct_ops/thp_get_order")
+int BPF_PROG(thp_not_eligible, struct vm_area_struct *vma, enum tva_type t=
ype,
+     unsigned long orders)
+{
+ /* THPeligible in /proc/pid/smaps is 0 */
+ if (type =3D=3D TVA_SMAPS)
+ return 0;
+ return pmd_order;
+}
hard code this thing. Don't bother with bpf.

