Return-Path: <bpf+bounces-44819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6119C7F7E
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 01:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0047F283FFD
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 00:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A70EAD2;
	Thu, 14 Nov 2024 00:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRIh0zSj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49DD1FC3
	for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 00:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545310; cv=none; b=KuuQiDgchemI64FaxKFZ+Gz8eIs8rn/3ax4g99NdvUXsPkX5ElV9E9YC3i9+W1+MRurUwutaKkS6H9ITRnXlVYWKkqf0NBnt3TCriErkK8zCtqBdJFr/NXmguZ63UHxGMosrjd3ZT/uDCJ4V7bo2CoJzZ5Mrm08n1WuMnKUVOXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545310; c=relaxed/simple;
	bh=z3x1M0W/8UoeNujlToOkkaMrLgclneGn9YLl19Mr3UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntNoq/tqiiAgulJSUbwdfImEvoeJUAL7ETRlIv/Bx3kGVexIXiNDZoAyfaYuiuzJKrYrvd1wge6mDlZXs8f3dSCSLcNTsqiFBwoi5GaCq/ecUJftGjEfRXFgQTeFH2H7s0Ol7mgRJLNi7RTpve5oETs920LbziCgnIQDgLuoD6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRIh0zSj; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-382171e1a83so130051f8f.0
        for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 16:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731545307; x=1732150107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyBFkWFryTo8q1Kf4IvgS4SGgNaUzmR4x+BrU7X1+gA=;
        b=hRIh0zSjyGNLAoCBT1y4JJf3YIBBCIPKft2LIGmy9kaJN5aOlRm0o2/LqeiTPj26fH
         +xunjGUxP+04rmGtMjHugy7NeIjIH3tzxtadZO/WnBN12Rt3iDJkslTPk7JQ+j4U82k4
         qMdXIZfOWfNKYC4K46t7VTASzmdW1RS7JkK11rZxekh0rih2cNeKyzBT9GWME511/q7F
         as7Z9s/jna1oQZ7E3Yzh29KjplWrCFMMmzw8ZjIy1Uhvp0FS9dNG+763aLKRXSQ7kZ9P
         JBKtqA9elffmULNwtLrkqTYUuBzuvZqDIrsgxTBIm9eoWE2FcqDMyk1nD/J+a1faZIEt
         S9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731545307; x=1732150107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyBFkWFryTo8q1Kf4IvgS4SGgNaUzmR4x+BrU7X1+gA=;
        b=tb3TjQHB5oVSFfa73UMex5YFS1qN55SCc8DUDNPytn8D3wztV+azEklrNEEHhJYyxe
         XQ7+9JtUXJgC18/D812CMQ92Jvh02Guhwy5hiShXn8/jX51XKLIqUZ0fRFqLP3UXvqjr
         n8T6LwfFiqudfKyiud4+XnAcuPgfbhMAICHng2DfORwgD72XOGQJGayVC9p1OUzM+drI
         aj1ggOq6l8SbIs38saKnF3sSZgZgEcCH5vzuOV8eZY3p0ao+O2+RWzLC1v9pYjvO51BI
         EX1BaNmmVDyyMhdN4YYb+iZUIHLfyd2bfx46KybqKTbwyD4XAeg/MEa6RHSb/nNFCXnr
         lHTg==
X-Gm-Message-State: AOJu0Yy23LiXh4ax7P7KYST+2VMIZsanI5ML3zaOdxMu30cDQte08rZv
	r9uu4WgxWLKoMsFgkB1QnPbqRH+BsORllrjYASHC08Ix7zqjzhULL+AhwhJbDrgb7PrrmB2RKTH
	KNJ4kp+HZfzvitgptqomSuo0oq4ON6pll
X-Google-Smtp-Source: AGHT+IFB22bib658o09vCwnfImhfduaEfjt98Ro7oDIb37Ukj+275EgB0ny0rCtw+IvYaeTKG/ClQk9Rnom8/8sg7ww=
X-Received: by 2002:a05:6000:385:b0:382:6d3:407a with SMTP id
 ffacd0b85a97d-38213ff950bmr1110014f8f.4.1731545306886; Wed, 13 Nov 2024
 16:48:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108025616.17625-1-alexei.starovoitov@gmail.com> <CAEf4BzbTmKri_qOtT7kQzdzaiT3QHMLH742Aw38CrhqqCo9f7A@mail.gmail.com>
In-Reply-To: <CAEf4BzbTmKri_qOtT7kQzdzaiT3QHMLH742Aw38CrhqqCo9f7A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 13 Nov 2024 16:48:15 -0800
Message-ID: <CAADnVQL9NwZFeqJ2UrUANRAaf3Ndi2frz+3jFKPQD7wXaQKD3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] bpf: range_tree for bpf arena
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, djwong@kernel.org, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 1:59=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 7, 2024 at 6:56=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Introduce range_tree (internval tree plus rbtree) to track
> > unallocated ranges in bpf arena and replace maple_tree with it.
> > This is a step towards making bpf_arena|free_alloc_pages non-sleepable.
> > The previous approach to reuse drm_mm to replace maple_tree reached
> > dead end, since sizeof(struct drm_mm_node) =3D 168 and
> > sizeof(struct maple_node) =3D 256 while
> > sizeof(struct range_node) =3D 64 introduced in this patch.
> > Not only it's smaller, but the algorithm splits and merges
> > adjacent ranges. Ultimate performance doesn't matter.
> > The main objective of range_tree is to work in context
> > where kmalloc/kfree are not safe. It achieves that via bpf_mem_alloc.
> >
> > Alexei Starovoitov (2):
> >   bpf: Introduce range_tree data structure and use it in bpf arena
> >   selftests/bpf: Add a test for arena range tree algorithm
> >
> >  kernel/bpf/Makefile                           |   2 +-
> >  kernel/bpf/arena.c                            |  34 ++-
> >  kernel/bpf/range_tree.c                       | 262 ++++++++++++++++++
> >  kernel/bpf/range_tree.h                       |  21 ++
> >  .../bpf/progs/verifier_arena_large.c          | 110 +++++++-
> >  5 files changed, 412 insertions(+), 17 deletions(-)
> >  create mode 100644 kernel/bpf/range_tree.c
> >  create mode 100644 kernel/bpf/range_tree.h
> >
> > --
> > 2.43.5
> >
>
> I skimmed through just to familiarize myself, superficially the range
> addition logic seems correct.
>
> I'll just bikeshed a bit, take it for what it's worth. I found some
> naming choices a bit weird.
>
> rn_start and rn_last, just doesn't match in my head. If it's "start",
> then it's "end" (or "finish", but it's weird for this case). If it's
> "last", then it should have "first". "start"/"end" sounds best in my
> head, fwiw.

Agree. It bothered me too a bit, but I kept it as-is to be
consistent with xbitmap. So prefer to keep it this way.

>
> As for an API, is_range_tree_set() caught my eye as well. I'd expect
> to see a consistent "range_tree_" prefix for the internal API for this
> data structure. So "range_tree_is_set()" was what I expected.

This is what I tried first, but looking at how it can be used
the "_is_" part in the middle is too easy to misread.

if (!range_tree_is_set(rt, pgoff, page_cnt))
   range_tree_set(rt, pgoff, page_cnt);   // not so bad here

if (!range_tree_is_set(rt, pgoff, page_cnt))
   // is above "_set" or "_is_set"
   range_tree_clear(rt, pgoff, page_cnt);


Hence I moved "is_" to the beginning to make it more visually different:

if (!is_range_tree_set(rt, pgoff, page_cnt))
   range_tree_clear(rt, pgoff, page_cnt);

Not sure whether the consistent "range_tree_" prefix is a better trade off.
No strong opinion.

