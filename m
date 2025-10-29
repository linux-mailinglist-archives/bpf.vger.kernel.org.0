Return-Path: <bpf+bounces-72675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CD8C18064
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 03:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84A8F4E83B4
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 02:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0E42E9ECA;
	Wed, 29 Oct 2025 02:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpFEtg/T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922532EA754
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 02:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761704056; cv=none; b=VUPJEeZU31gAvY3RqS5kprPGntSIArSdcee0Uw8BHVvsJOv7KEGwUdmOQgAdOAQyHk/obVqzMokLtbNRYL8OAOYD4LFbQdbiRq17nLzFEHw98N7Mxc0QBFXNR4fin6W1kQb7kjcgFXS+iLimLscf1t7wWjuARiL6By/i/Y5LIsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761704056; c=relaxed/simple;
	bh=8RPgutMqqZXCWberJHcO1HrhEW4wChNSJ96jWHaKgYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owPSWNJgtgzr8v79OuiEgKrby+HLFvnn0Z85yXjnlhtbSm3+uMk8M9n+GSpSrYozWFgYt1jjL29JDbakTWiwhqTpptLJdvvHt9W75CHDQ8EQh4GlkLV3j1bQXXMCDji7PCnsu1ClrTKGGKhNacZ14Yj+vdR2zk6jDI887Vz/Ftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpFEtg/T; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7832691f86cso92677857b3.1
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 19:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761704053; x=1762308853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vPGYW3pX+7b1B0RO8MNUWDpnqr51YW+OGVAApLwa9M=;
        b=GpFEtg/Tm2BBQ3gYDuiQuavNb8lkczuRD/5k9xvzv3Ur4Pr+qfmPBalSWyHsIcsXfu
         OFyEjNIRVAysTu0ACUtYwDUCpXwKj17hu4r1PZem91gOKhmJCr5fZXuDyx0C+wNzDXlu
         n/W/FHwzC8DUQa6skroeoosSNNo9f4dMrndaejPSQwZ9laWJB2zolDkNs9A4uqzFuV/7
         M5jo7gSNDlQXdMHZFCDiEdTjXkGPL6m/nYrAHCPvKULFGnvbQA9PVz/1LqpV6yhkcusi
         S/LZt1i0HzFSMFR3gh7d/nodPGiKbuoyzul+B7iULoKHdIUcxrLCkVGj1o3MdyNUfq6a
         jIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761704053; x=1762308853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vPGYW3pX+7b1B0RO8MNUWDpnqr51YW+OGVAApLwa9M=;
        b=DDqRhcuRDwLLTBDASEkgECxzESqR/mYsP8Qtffzkud7C6x14+RBNjk8n5RwDHIDQy+
         ACFsUBCwa1fN3yzzzOchUJ3oKXPjoZPtY5tr95OVcsqXqXz5Mx9yeHMDbCk2VbDJ87M0
         WizCb/Za5vFocUiNWvI3tGL1qWwqZOdZmf633d++rZxpMVTcuoL37A2Zkc83u/kclH5V
         Mtydtb6slt807jHlMSS1a3zxPhZt8vk/G8jaVgzJutJuKDiMPiesKKD20OIcZni272nJ
         PPgonwX3/lW9jJXtgChNYaRQfRwL6N5grCalveTJxU1DHjolUtJQdwBk8h1X1ksPkjTD
         4m/w==
X-Forwarded-Encrypted: i=1; AJvYcCXD9LKB4WksUXcJylWpdOZ8Oq0/vc2PFe4qPxTOKPgzPXZzAN/ngTk8What6jvTYBkTcK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu73Tb/e1CRwjMCZNSlgUyGUYIovU2JBybi+Q6RuRdZmywh+li
	aAifEfSNs8GKSzdIyznEdoUB4UxyzfFYw5Po+o86di17ZjHQcXGH6lKtZQhB7GFpnbVzBvQAcIH
	9FPZaz2xe6GisvDBt9A3GjqzpttYZP4U=
X-Gm-Gg: ASbGncsg3eN/MGxH/6/tWPNtCVQLS9tc8MA9tUhCbUR+VbBSD5tL7uNy5UcDj72ixi7
	15ugexJxA8H3E2Otd8KIDLBNhcymeLfwlDYH2Mb9Qcqz2dRMOjYTqa5DTh7XakWfOKKtUzbzsD0
	/H8OWRQFTXq0sy0Rq53jaLdvmwzKQTbw5rOr5hyo3O+Y5u3DAmWKFlU+/q3nHkJTjndR2aO4MYh
	1XtdMrdZp+2vgR8hnOtum9PVpAT1+mhiCrjkJ5j9d3mZ7BeUeXhhVECXuwYhEOjzRqcqaF5
X-Google-Smtp-Source: AGHT+IGAN6hw0WwRvKtq3B1y0SiTrVIZoYnrx0iULGRASJtLgN5JvkICVwdenSNU90hNH8FkNZBvjoCAptWUticznOo=
X-Received: by 2002:a05:690c:6289:b0:76c:b76c:ddaf with SMTP id
 00721157ae682-78628e24788mr15670597b3.5.1761704053447; Tue, 28 Oct 2025
 19:14:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026100159.6103-1-laoar.shao@gmail.com> <20251026100159.6103-7-laoar.shao@gmail.com>
 <CAADnVQKziFmRiVjDpjtYcmxU74VjPg4Pqn2Ax=O2SsfjLLy5Zw@mail.gmail.com>
In-Reply-To: <CAADnVQKziFmRiVjDpjtYcmxU74VjPg4Pqn2Ax=O2SsfjLLy5Zw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 29 Oct 2025 10:13:37 +0800
X-Gm-Features: AWmQ_bl6ri9Brpc7kQ08rlFDC7Zg4B3FVd1R7XVe5An1qRSKX_V24AXUbVkKMWI
Message-ID: <CALOAHbD+9gxukoZ3OQvH2fNH2Ff+an+Dx-fzx_+mhb=8fZZ+sw@mail.gmail.com>
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

On Wed, Oct 29, 2025 at 9:33=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Oct 26, 2025 at 3:03=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > The per-process BPF-THP mode is unsuitable for managing shared resource=
s
> > such as shmem THP and file-backed THP. This aligns with known cgroup
> > limitations for similar scenarios [0].
> >
> > Introduce a global BPF-THP mode to address this gap. When registered:
> > - All existing per-process instances are disabled
> > - New per-process registrations are blocked
> > - Existing per-process instances remain registered (no forced unregistr=
ation)
> >
> > The global mode takes precedence over per-process instances. Updates ar=
e
> > type-isolated: global instances can only be updated by new global
> > instances, and per-process instances by new per-process instances.
>
> ...
>
> >         spin_lock(&thp_ops_lock);
> > -       /* Each process is exclusively managed by a single BPF-THP. */
> > -       if (rcu_access_pointer(mm->bpf_mm.bpf_thp)) {
> > +       /* Each process is exclusively managed by a single BPF-THP.
> > +        * Global mode disables per-process instances.
> > +        */
> > +       if (rcu_access_pointer(mm->bpf_mm.bpf_thp) || rcu_access_pointe=
r(bpf_thp_global)) {
> >                 err =3D -EBUSY;
> >                 goto out;
> >         }
>
> You didn't address the issue and instead doubled down
> on this broken global approach.
>
> This bait-and-switch patchset is frankly disingenuous.
> 'lets code up some per-mm hack, since people will hate it anyway,
> and I'm not going to use it either, and add this global mode
> as a fake "fallback"...'
>
> The way the previous thread evolved and this followup hack
> I don't see a genuine desire to find a solution.
> Just relentless push for global mode.
>
> Nacked-by: Alexei Starovoitov <ast@kernel.org>
>
> Please carry it in all future patches.

To move forward, I'm happy to set the global mode aside for now and
potentially drop it in the next version. I'd really like to hear your
perspective on the per-process mode. Does this implementation meet
your needs?


--
Regards
Yafang

