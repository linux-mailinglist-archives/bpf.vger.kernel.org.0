Return-Path: <bpf+bounces-72964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A13C1E26D
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 03:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759C540564E
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 02:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5C52DC359;
	Thu, 30 Oct 2025 02:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io3ypgND"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE4B32ABFD
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 02:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761792084; cv=none; b=aXC0tu1QWJl4mFjS/Nkg1/Rq1e8MXe+QY1b0XbsLRcIRCDRBGmk5I3obfqbaeEGuDG3BkPGs21N/t40BfOBNTwLotDfSsJLc9z88WhmLTnMy6E3lAB00cJiq9xdvv5B3Yquhh3dOj3mj4qSjx2K5f32qPAEE7WZKenUPBMFJ78Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761792084; c=relaxed/simple;
	bh=9TSBSsCeEXSKuAlFMZSwVj85c3yzRZ84YCI2Xe8vXI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6sJkUG+CePIIs3s1PUG0PY7d/Q8bFFnhkMUzsTU5erUzzEzP//aenrwDU6SQQBe3Mwz34jdR0ZQdGrPYdh+l213CbJcdZ5OsprZ5PeS1vOyFXyvCkxPXS0o+JkDZthwG3DkbCt4XpfgfRCCGhwX9yg+yhlNuFWDKjuX9rQNSCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=io3ypgND; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78488cdc20aso8626397b3.1
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 19:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761792079; x=1762396879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSe4ujmKxwC2DXJeO8t3ogNFeO6qZ+2rbxk+w2YyOCw=;
        b=io3ypgNDy2ncDRxXUZvPt0AxwybSSMHUA7Aw1GS4C3g9GIzAEtSHqCJz0CKO/oHZsX
         4yQcMs/zhkXvA9geg0bjAr0SlstD+9HneZgJC0zyxaPHUwkWZDsThUAq/ndB2r3FXcaE
         BS1+nXqvAF1kuBNbKlcYusgg11EWMZnU7H1ChKdM+J5kwtqAP+39RpxvXjlAPfvApyE1
         fPoY1OuP87mjD3WFEsiIhWp+QKT0WT9I81NPzbCH9S6DJ3ltilHo5EqM+zxX+MsUv4qb
         fG1WUcimmOjOLFTF8S4XBtL9mxiZNU/VYDJ2RjqBRd78oGJ2dVlakIVHpeYuQJZfr55w
         M6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761792079; x=1762396879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSe4ujmKxwC2DXJeO8t3ogNFeO6qZ+2rbxk+w2YyOCw=;
        b=gKGrMaDtfj2QFqQ92p92J3oIYJmag25Zj+OLqAHXiH5rjt1yIVkqxGuNMu9aBS3aAT
         2fQQSltsD+6jp+zV0APrKkYZqXcbcEEW8hEe4vz0pANsM7vF/i05uAOTs51ZwbRixHLz
         4JFQ2ZAu51m6wZ0dUp9UxpQ0eW8tWhAlU7Ynx0dOWPfou//oJpeuS5eWIxXROZ9u3Hgx
         DG5Qy6hjF6AbI23LwDFAO/se3sGIkjTy3NvL8WwpkhIU/NXXkI2lhhR4tKR8eheB0K2m
         HXOdXm1ljiXwr/7YmhpKBLq4Vpy5IvausU/fLLeyxrIKh4KGF9lND3rdwE1r9ra8Uita
         EaTw==
X-Forwarded-Encrypted: i=1; AJvYcCVR7NXdeTIwIV/7eGAVAIHAoZHr/yhMtANrPO3bvS6bLdqGkXwm2lO1LM8Wx64RwpIplV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEQRsDva4kKGysxceDq2I5eZUEmSVOQHapc9QARVBGE7rejJ1p
	YpYYqcFczpyEJR6yeDoJV99vrzp5wsQoezgRNsdyn558ywtEDYk9ZsSXzPau5mfrWWe5Cyhoxjx
	e2W3dgYKx6QHl+FYR9vdIN/DBWC6NgJQ=
X-Gm-Gg: ASbGncsOPoVW9xzvql4SfUugWYW5Zyr3HJHWMIFOKR97IPE2m1ZkYeW46LLtOrqrBUf
	tf3zyOg+ahe7D/JENV6ZfISPIfq4mDIE/hwhshgv14KYLsT2FJATWkj0+cPSWhMB/iH2qlg+ztw
	3Wo1f5QeXolAt4VTDkMLeia2JL9vCebQ8tr+Ow3kxikQ6ik9nyo2dyItD0Ib17t4nhN4LpFAnUD
	OYbbHDAYP3NDwvf3GVDvAzeeWcPWHM4DSgkpwmqvxpWUZuU2Wo7iOoIe6PHvg==
X-Google-Smtp-Source: AGHT+IHkaGRY47Vr0p1/F79EcJ88ITWDpiXG/ComEOJWc5GK5/nf645jMmUB4EHdKa7lCdd0T+UHtmu0FhAOXVmqa3w=
X-Received: by 2002:a05:690c:88b:b0:784:ab8d:4b97 with SMTP id
 00721157ae682-78628fdba8dmr47819317b3.58.1761792079474; Wed, 29 Oct 2025
 19:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026100159.6103-1-laoar.shao@gmail.com> <20251026100159.6103-7-laoar.shao@gmail.com>
 <CAADnVQKziFmRiVjDpjtYcmxU74VjPg4Pqn2Ax=O2SsfjLLy5Zw@mail.gmail.com>
 <CALOAHbD+9gxukoZ3OQvH2fNH2Ff+an+Dx-fzx_+mhb=8fZZ+sw@mail.gmail.com> <CAADnVQK9kp_5zh0gYvXdJ=3MSuXTbmZT+cah5uhZiGk5qYfckw@mail.gmail.com>
In-Reply-To: <CAADnVQK9kp_5zh0gYvXdJ=3MSuXTbmZT+cah5uhZiGk5qYfckw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 30 Oct 2025 10:40:43 +0800
X-Gm-Features: AWmQ_bm6gqmyylYroPXEXY8mGbZ4lcr6XBjms3-D9YBfaNqoGFMZKAl7IMZRKqQ
Message-ID: <CALOAHbC3p-zUZBs7S2r78nCPZm3F=AjJY7cL3RezTPtOXmLb6g@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 06/10] mm: bpf-thp: add support for global mode
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Thu, Oct 30, 2025 at 8:57=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 28, 2025 at 7:14=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Wed, Oct 29, 2025 at 9:33=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sun, Oct 26, 2025 at 3:03=E2=80=AFAM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > The per-process BPF-THP mode is unsuitable for managing shared reso=
urces
> > > > such as shmem THP and file-backed THP. This aligns with known cgrou=
p
> > > > limitations for similar scenarios [0].
> > > >
> > > > Introduce a global BPF-THP mode to address this gap. When registere=
d:
> > > > - All existing per-process instances are disabled
> > > > - New per-process registrations are blocked
> > > > - Existing per-process instances remain registered (no forced unreg=
istration)
> > > >
> > > > The global mode takes precedence over per-process instances. Update=
s are
> > > > type-isolated: global instances can only be updated by new global
> > > > instances, and per-process instances by new per-process instances.
> > >
> > > ...
> > >
> > > >         spin_lock(&thp_ops_lock);
> > > > -       /* Each process is exclusively managed by a single BPF-THP.=
 */
> > > > -       if (rcu_access_pointer(mm->bpf_mm.bpf_thp)) {
> > > > +       /* Each process is exclusively managed by a single BPF-THP.
> > > > +        * Global mode disables per-process instances.
> > > > +        */
> > > > +       if (rcu_access_pointer(mm->bpf_mm.bpf_thp) || rcu_access_po=
inter(bpf_thp_global)) {
> > > >                 err =3D -EBUSY;
> > > >                 goto out;
> > > >         }
> > >
> > > You didn't address the issue and instead doubled down
> > > on this broken global approach.
> > >
> > > This bait-and-switch patchset is frankly disingenuous.
> > > 'lets code up some per-mm hack, since people will hate it anyway,
> > > and I'm not going to use it either, and add this global mode
> > > as a fake "fallback"...'
> > >
> > > The way the previous thread evolved and this followup hack
> > > I don't see a genuine desire to find a solution.
> > > Just relentless push for global mode.
> > >
> > > Nacked-by: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Please carry it in all future patches.
> >
> > To move forward, I'm happy to set the global mode aside for now and
> > potentially drop it in the next version. I'd really like to hear your
> > perspective on the per-process mode. Does this implementation meet
> > your needs?
>
> Attaching st_ops to task_struct or to mm_struct is a can of worms.

The feedback suggests there may not have been an opportunity to review
patch #3 in detail yet. I would appreciate it if you could take a look
at the specific changes in that patch, as it addresses the core of the
implementation.

> With cgroup-bpf we went through painful bugs with lifetime
> of cgroup vs bpf, dying cgroups, wq deadlock, etc. All these
> problems are behind us.

The attachment-based design of cgroup-bpf creates significant
operational challenges. It lacks visibility, making it difficult to
identify which cgroups have active attachments, and requires explicit
author knowledge for clean detachment.

> With st_ops in mm_struct it will be more
> painful.

To save your time, I've pasted the relevant portion of patch #3 below:

  When registering a BPF-THP, we specify the PID of a target task. The
  BPF-THP is then installed in the task's `mm_struct`

    struct mm_struct {
        struct bpf_thp_ops __rcu *thp_thp;
    };

  Inheritance Behavior:

  - Existing child processes are unaffected
  - Newly forked children inherit the BPF-THP from their parent
  -  The BPF-THP persists across execve() calls

    A new linked list tracks all tasks managed by each BPF-THP instance:

  - Newly managed tasks are added to the list
  - Exiting tasks are automatically removed from the list
  - During BPF-THP unregistration (e.g., when the BPF link is removed), all
    managed tasks have their bpf_thp pointer set to NULL
  - BPF-THP instances can be dynamically updated, with all tracked tasks
    automatically migrating to the new version.

  This design simplifies BPF-THP management in production environments by
  providing clear lifecycle management and preventing conflicts between
  multiple BPF-THP instances.

To clarify, this design has no lifecycle issues. It provides clear
traceability: you can always identify who loaded the program and which
processes it's attached to. Moreover, removing either the loader or
the pinned bpf_link will completely remove the program and all its
associated state.

> I'd rather not go that route.

I'm glad we can talk about this directly=E2=80=94it saves us both a lot of =
guesswork.

>
> And revist cgroup instead, since you were way too quick
> to accept the pushback because all you wanted is global mode.
>
> The main reason for pushback was:
> "
> Cgroup was designed for resource management not for grouping processes an=
d
> tune those processes
> "
>
> which was true when cgroup-v2 was designed, but that ship sailed
> years ago when we introduced cgroup-bpf.
> None of the progs are doing resource management and lots of infrastructur=
e,
> container management, and open source projects use cgroup-bpf
> as a grouping of processes. bpf progs attached to cgroup/hook tuple
> only care about processes within that cgroup. No resource management.
> See __cgroup_bpf_check_dev_permission or __cgroup_bpf_run_filter_sysctl
> and others.
> The path is current->cgroup->bpf_progs and progs do exactly
> what cgroup wasn't designed to do. They tune a set of processes.
>
> You should do the same.

I'm fully supportive of a cgroup-based approach, as it simplifies
integration by requiring only a kubelet plugin instead of
modifications to containerd.

However, my primary concern is the potential for maintainer pushback,
given the historical precedent. For instance, a similar discussion in
the NUMA-balancing context saw cgroup maintainers insisting on a
process-based method (see link below):

  https://lore.kernel.org/lkml/ldyynnd3ngxnu3bie7ezuavewshgfepro5kjids6cuxy=
4imzy5@nt5id7nj5kt7/

To proactively address this, what alternative plan would you recommend
if we encounter such resistance? It's unclear what a viable path
forward would be if we are committed to a cgroup-based approach but it
is ultimately rejected by the maintainers.

(Adding Michal to CC for visibility)

>
> Also I really don't see a compelling use case for bpf in THP.

I'd recommend familiarizing yourself with the THP implementation. This
would be beneficial for our discussion on the specific changes.

> Your selftest is beyond primitive:
> +int pmd_order;
> +
> +SEC("struct_ops/thp_get_order")
> +int BPF_PROG(thp_not_eligible, struct vm_area_struct *vma, enum tva_type=
 type,
> +     unsigned long orders)
> +{
> + /* THPeligible in /proc/pid/smaps is 0 */
> + if (type =3D=3D TVA_SMAPS)
> + return 0;
> + return pmd_order;
> +}
> hard code this thing. Don't bother with bpf.

A prior implementation that combined these components existed in an
earlier version:

  https://lore.kernel.org/linux-mm/20250729091807.84310-5-laoar.shao@gmail.=
com/

However, based on your previous guidance that fexit and struct_ops
should not be mixed, the current approach was adopted.

In summary, I'm happy to proceed with a cgroup-based implementation. I
would appreciate your support in addressing any concerns the cgroup
maintainers might have.

--=20
Regards
Yafang

