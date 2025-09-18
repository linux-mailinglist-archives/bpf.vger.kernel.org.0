Return-Path: <bpf+bounces-68822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA3FB860BF
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F161CC1660
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 16:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E583112DD;
	Thu, 18 Sep 2025 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfmtERof"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CB72192E3
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212800; cv=none; b=ei9olQV8Pip3tF73nqA3VxDFDlS841186gYeqhqjKLm0pkDMWRg421gmRWkOB9TKWJk9OJOybipU1bLTrKqhBPo1tiOsAulRYjfsPcRkMgtnUKRGnsWOyzPCWoMZ9PzQ8Hj2IwixSLjCz+J0ZSWp40jRYAlQsfy7sx0QA+rkeos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212800; c=relaxed/simple;
	bh=9+Mq+YcHakC1aonqWSsqaqkLLTr4FLrcP95BRzRfzZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAgE9zXKN9lNgR6YQ6VX4ZVpIWqTy2K1QzmWOwWE9b6z0oOQuGNyGOvLh76rLv/9NVl918xXz+K3gHU59UltRq+Lpyaenb+hXgRGk5d16X3/V8Q86/S8t7XvS2oOtVtF+AdxKiv9A01raBtqVGZrKHOE1lmmv7Fa/TkJmRKkPK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfmtERof; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45f2cf99bbbso7206175e9.0
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 09:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758212797; x=1758817597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wbiof32HOUHhC6r3EOORVrui2edZ5pz+Ms95ogDj4rg=;
        b=AfmtERofcysbV11ghnwvCHWyFoXvPyStl6w3ob7P2kDOQ8ehQmilqZ+7WfgCu3Rq/F
         kpPGV9Cmfd/iyh8qKS1bkP0741pZDacCn0f37MP/ox4izZ8waUACTl1RTskM5XArSspQ
         jAvx636NGo/3FAVmnB8C5v4yy4z7dkoC6Bhadr9ZnwAZpkcPZBgcMMgXBAJkaJ31SgRd
         +S7Mik/EuDUgxEVTkF7GF7uAE6XqV1ixRTwbmQHYxuIzEmk+f+ITY8y88pZLGTGb5Mjo
         pUgT0mpHVffeDFdyH3j6e5G+d3hWWYm36FXgsPC3sGn2VA+IJ1r5ieyGC8kJCX9X3kha
         orNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758212797; x=1758817597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wbiof32HOUHhC6r3EOORVrui2edZ5pz+Ms95ogDj4rg=;
        b=vqbJy5bI0320VmJabtMUj+INCceNEUZUMcqq+Qb+45XPBdk8/W6XopKlUmdF2QMwxK
         I3LI/OUQatyC50NjFmHq0GXXQBV2J+pYrZDha1jqFclnmp8wWRyampXhNj6c1A0Pd9YC
         0LJ+1NO8WCCHzYpz5JBRzwe+NFDbRVD64qnUMXsyX4fAKjTt4xOmzaM/Cwnq2z1bl/5j
         VjOaLcecKacVeiLXfX4lcXMM8H1LecGy7B+x0mjQl3/Pd6tq5A2ODUPHKItY1LTBgtC3
         LUbxymKXGZVgaiOSTRcVnzEYOGfbSb2Jqs1AHhnaA3pbalwSG6v7XlVKvoYN43gydc5E
         G0oQ==
X-Gm-Message-State: AOJu0Yzc7dk9DkcP9vxg879bBxoGIDE4KmzQV3Jzxai0Hfcv8ZPoMPFE
	1i3ryUeT2Fp+SamlVUo6xeQDv+R/qpwFUArJIR0BuUMQIaA3ibC5ZSMupAaab+5ww1WN/xeQNEE
	hBnuI+4ECpl18YWeFjPAXrT+mit1mLakAXC10
X-Gm-Gg: ASbGnctzjSZs/6jQc2wQPjtByZl8q8VKYXgbE4NROKJsJVqLGwxn2EDkHjL+Sppnrxz
	JCsLCW8wfxRftBKORIiKLCo/8BUi+bx+DALjym7R+gKrBzwHik1z8QJexPsNkacv02UpTSPcnKq
	2BVaZWrj/YlqvrQ3DEzQ4aAi5SbLc5MtSq+050FUcrbNLeoslBwrz10qGGP2b3eDpEcekmz3oi4
	V/vr1CPpFvH/mxIyFGpZweNUxNJwjkLA0x770W9DQ==
X-Google-Smtp-Source: AGHT+IGkA89p9YjER9dFRystLowpNPwOsVNXiTd/Xy8ecOf8LhWSp+oooa4bJnKnVVe4p9eb9qPqSAmt19AFZO8z2zk=
X-Received: by 2002:a05:600c:314c:b0:45c:b549:2241 with SMTP id
 5b1f17b1804b1-46206842a9amr56726415e9.27.1758212796642; Thu, 18 Sep 2025
 09:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918093606.454541-1-a.s.protopopov@gmail.com>
 <CAADnVQLso776xFQTzPFahmV=JbE3Ca8jQ7UdPuMChjJAK_echg@mail.gmail.com> <aMwy+pt+Rg1eNr0z@mail.gmail.com>
In-Reply-To: <aMwy+pt+Rg1eNr0z@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 18 Sep 2025 09:26:22 -0700
X-Gm-Features: AS18NWC3QWbMrrqvbFcI4HUShh5l1YCTy2_KJOi6XJx8rFaYZmfvHIbEN9kXyiY
Message-ID: <CAADnVQ+2ic2gWyvqp4qFCwZpKqV+7BDnovL08Jp0tFSaC4pm9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix build with new LLVM
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 9:21=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> On 25/09/18 08:02AM, Alexei Starovoitov wrote:
> > On Thu, Sep 18, 2025 at 2:30=E2=80=AFAM Anton Protopopov
> > <a.s.protopopov@gmail.com> wrote:
> > >
> > > The progs/stream.c BPF program now uses arena helpers, so it includes
> > > bpf_arena_common.h, which conflicts with the declarations generated
> > > in vmlinux.h. This leads to the following build errors with the recen=
t
> > > LLVM:
> > >
> > >     In file included from progs/stream.c:8:
> > >     .../tools/testing/selftests/bpf/bpf_arena_common.h:47:15: error: =
conflicting types for 'bpf_arena_alloc_pages'
> > >        47 | void __arena* bpf_arena_alloc_pages(void *map, void __are=
na *addr, __u32 page_cnt,
> > >           |               ^
> > >     .../tools/testing/selftests/bpf/tools/include/vmlinux.h:229284:14=
: note: previous declaration is here
> > >      229284 | extern void *bpf_arena_alloc_pages(void *p__map, void *=
addr__ign, u32 page_cnt, int node_id, u64 flags) __weak __ksym;
> > >             |              ^
> > >
> > >     ... etc
> >
> > I suspect you're using old pahole.
> > New one can transfer __arena tags into vmlinux.h
>
> Ok, TIL about CONFIG_PAHOLE_VERSION (before I've sent the patch,
> I've updated the pahole, re-built the kernel, but didn't do `make
> oldconfig` after updating pahole.)

Yeah. It's a footgun that few people are aware of :(
I was bitten by it too.
We have a small section about pahole in bpf_devel_QA.rst.
We should probably expand it and list the common issues and how to fix them=
.
Every week somebody sends a patch due to old pahole :(

