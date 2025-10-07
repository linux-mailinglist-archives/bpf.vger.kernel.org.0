Return-Path: <bpf+bounces-70496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B42BC0C64
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 10:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E04934D8B5
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 08:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9EB1E633C;
	Tue,  7 Oct 2025 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gndoXDH7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA5815746F
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826867; cv=none; b=Fbf1Ugv7r6ITOYYsp469elGKoODw7ltv/MIqOPJfstLK2kjkXT2P+3ES8C3P+Oa3yF48xgwdcdaiZCde++tHmetYy/6W+IGrIsva4sCe7OCWVb8EEajKNt+r63Mt3k+CyLuldqTFslZn+YvXz9o2ums87j2QSF6FV/V+dXwFk4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826867; c=relaxed/simple;
	bh=vo73nD6X7GknqwKu4/t/n5UEit3SnnPN2ApB1mJISAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSwex2av3oj31shhTyHX8Ovz9rN5eJGi1xUNBA1Hw0+3SaTNslIGgjieEm21mKZEjEHf8mL006QZnw+J2ac0amqj8KvuTMR3LBQkCcHHJaDeLKcvUIvIM/d0wpC0xHnIkdmVOmy4UhUrlOurtwh3kfD+pE5blNXKDVojn4LBO/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gndoXDH7; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-79390b83c7dso48779426d6.1
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 01:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759826865; x=1760431665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crh9HauYP95GJ4zrJ0uVPldJHjW/rsd9tWC0UjT3/hA=;
        b=gndoXDH7Ko6uxNr64bSMWEi4D0l18rZUChLuCdFObnGvYpLYFOjrslx0mRFT17PAlB
         eden4YMr1RK2piK7X0AYBnkX4sD2x83PbIXbcgiRJv47ojDDVeuyqLI8gnS4cPIA5LwY
         aNDbybBzHszSgy3Zp+NS9bHPqGQUZWHvQe+C6R3HLaBVC2oyWDTSx5FtjqXhRqUzLYEe
         j4DM6VT/7oPabqc4ZZ4oHuH/LwBEkoOvYrvkYnJ7S+QvGhZJENpEHQV8GGKIpdxjbXY6
         sOmndYRGircEq0491JAhNOb6tHfVihPRDn9JGwldHVZjfljRkCG67NbipUAc73V51+Mq
         2HTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759826865; x=1760431665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crh9HauYP95GJ4zrJ0uVPldJHjW/rsd9tWC0UjT3/hA=;
        b=Aqau7X1NoVfuXmjhI6q3OomwWSkP7BGFZt93wJpaY5qgayOVyFS58qSJQEFK4K3jD1
         1PIUcbcKU4pg0redQMvlmnp6Rh/ACkkd2CtR3HBSBHRorYGRhx00z7ovHkM3ZBNWO/UQ
         ZOteuoHK7ekVj6ZQGWP5e9JLdmTTbSi6s5xjdRT5spPduaq4DrWl5xeOpEbHfkYL/6+l
         wSXCMXTNnbvnAlZqE9TouYLbjpuirS9MgHY/4tElJIV37icjg3542eNakLZ/t1h32uvr
         mw+6Rm7XBF1v+FWu2q2L0rlEo8Hi/xvV6c+04Dzr4/Gnnx/VKrgUga05xgWyRZpsTmAq
         XfTw==
X-Forwarded-Encrypted: i=1; AJvYcCWMEtcCGfJTCRuaJZxv2EqaQgPbrPndTetcbxzp/f+jARBYMU6yyp0+uwvd6yHqngqtriU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ufPlPey65NVkhzmZJ2VNlNbRzC9E9BbESKYKUFYDbQxw+/aA
	Ez0D4HY+HgX31UsXZpJl+N0R4TmB/BBKQFMm8z+/EqJLVY1/sHGT7rZTHkI6Pb8CwMy2dmYjgzJ
	zEwgmrBmqekAiC3DxPD2iuDYDqLhNe7M=
X-Gm-Gg: ASbGncskBmq9TC/bweULVRwydmS9uth73srXfGMiyNhxKu2RO3NF5bdMFOQSyqVEvAh
	p0zY0GcE3ulZhTF9b3XV4NobNYgE+bdDgUNS1JzWBw7EBh53ggtAC+086HmYSgTAXc1F3Sql19u
	KqsDzHCCHzWte+qZPsPIOMAJ8LeSze6K4ezzbrtD85VLFUqj+krn9+bDSz2VECE5eJOo32YdIGe
	hsn0H7N1lxQOahFxYnMbdMyybx4Ifx/texTPVJBkrADYVzRecj/E/w0m+JmfkWDTgYhnbqe
X-Google-Smtp-Source: AGHT+IE0kCx/uqxAfqV2bOwZSICMDBVUoFj0t71GiPD3ZOtz/k069SnnR01KVwEtbQaFoOkSu9qAE8VcxY6KD+XN6HQ=
X-Received: by 2002:ad4:5ca5:0:b0:815:2c80:5538 with SMTP id
 6a1803df08f44-879dc82c417mr175681336d6.35.1759826864937; Tue, 07 Oct 2025
 01:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930055826.9810-1-laoar.shao@gmail.com> <20250930055826.9810-4-laoar.shao@gmail.com>
 <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
In-Reply-To: <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 7 Oct 2025 16:47:07 +0800
X-Gm-Features: AS18NWAAW7GO0Nbda-yTtjdo7G3EzwEKMHmRebu2XNJhJXwwvRx2obOSyUBetgo
Message-ID: <CALOAHbATDURsi265PGQ7022vC9QsKUxxyiDUL9wLKGgVpaxJUw@mail.gmail.com>
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, Johannes Weiner <hannes@cmpxchg.org>, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, Matthew Wilcox <willy@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	David Rientjes <rientjes@google.com>, Jonathan Corbet <corbet@lwn.net>, 21cnbao@gmail.com, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, lance.yang@linux.dev, 
	Randy Dunlap <rdunlap@infradead.org>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 10:18=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 29, 2025 at 10:59=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> >
> > +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
> > +                                     enum tva_type type,
> > +                                     unsigned long orders)
> > +{
> > +       thp_order_fn_t *bpf_hook_thp_get_order;
> > +       int bpf_order;
> > +
> > +       /* No BPF program is attached */
> > +       if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> > +                     &transparent_hugepage_flags))
> > +               return orders;
> > +
> > +       rcu_read_lock();
> > +       bpf_hook_thp_get_order =3D rcu_dereference(bpf_thp.thp_get_orde=
r);
> > +       if (WARN_ON_ONCE(!bpf_hook_thp_get_order))
> > +               goto out;
> > +
> > +       bpf_order =3D bpf_hook_thp_get_order(vma, type, orders);
> > +       orders &=3D BIT(bpf_order);
> > +
> > +out:
> > +       rcu_read_unlock();
> > +       return orders;
> > +}
>

Hello Alexei,

My apologies for the slow reply. I'm on a family vacation and am
checking email intermittently.

> I thought I explained it earlier.

I recall your earlier suggestion for a cgroup-based approach for
BPF-THP. However, as I mentioned, I believe cgroups might not be the
best fit[0]. My understanding was that we had agreed to move away from
that model. Could we realign on this?

[0].  https://lwn.net/ml/all/CALOAHbBvwT+6f_4gBHzPc9n_SukhAs_sa5yX=3DAjHYsW=
ic1MRuw@mail.gmail.com/

> Nack to a single global prog approach.

The design of BPF-THP as a global program is a direct consequence of
its purpose: to extend the existing global
/sys/kernel/mm/transparent_hugepage/ interface. This architectural
consistency simplifies both understanding and maintenance.

Crucially, this global nature does not limit policy control. The
program is designed with the flexibility to enforce policies at
multiple levels=E2=80=94globally, per-cgroup, or per-task=E2=80=94enabling =
all of our
target use cases through a unified mechanism.

>
> The logic must accommodate multiple programs per-container
> or any other way from the beginning.
> If cgroup based scoping doesn't fit use per process tree scoping.

During the initial design of BPF-THP, I evaluated whether a global
program or a per-process program would be more suitable. While a
per-process design would require embedding a struct_ops into
task_struct, this seemed like over-engineering to me. We can
efficiently implement both cgroup-tree-scoped and process-tree-scoped
THP policies using existing BPF helpers, such as:

  SCOPING                        BPF kfuncs
  cgroup tree   ->  bpf_task_under_cgroup()
  process tree -> bpf_task_is_ ancestors()

With these kfuncs, there is no need to attach individual BPF-THP
programs to every process or cgroup tree. I have not identified a
valid use case that necessitates embedding a struct_ops in task_struct
which can't be achieved more simply with these kfuncs. If such use
cases exist, please detail them. Consequently, I proceeded with a
global struct_ops implementation.

The desire to attach multiple BPF-THP programs simultaneously does not
appear to be a valid use case. Furthermore, our production experience
has shown that multiple attachments often introduce conflicts. This is
precisely why system administrators prefer to manage BPF programs with
a single manager=E2=80=94to avoid undefined behaviors from competing progra=
ms.

Focusing specifically on BPF-THP, the semantics of the program make
multiple attachments unsuitable. A BPF-THP program's outcome is its
return value (a suggested THP order), not the side effects of its
execution. In other words, it is functionally a variant of fmod_ret.

If we allow multiple attachments and they return different values, how
do we resolve the conflict?

If one program returns order-9 and another returns order-1, which
value should be chosen? Neither 1, 9, nor a combination (1 & 9) is
appropriate. The only logical solution is to reject subsequent
attachments and explicitly notify the user of the conflict. Our goal
should be to prevent conflicts from the outset, rather than forcing
developers to create another userspace manager to handle them.

A single global program is a natural and logical extension of the
existing global /sys/kernel/mm/transparent_hugepage/ interface. It is
a good fit for BPF-THP and avoids unnecessary complexity.

Please provide a detailed clarification if I have misunderstood your positi=
on.

--=20
Regards
Yafang

