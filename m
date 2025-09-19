Return-Path: <bpf+bounces-69002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2F3B8B787
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 00:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9662D7E5222
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 22:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4892D3A68;
	Fri, 19 Sep 2025 22:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/u4YTJz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F8925BEF1
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758320972; cv=none; b=k17jIlga6qTwSNsW+WmHqWm3MTyrAP1us2WRbN346ZDyjJUH0qR9oEJ4TsKhFBdIBSGDhst0k2lzVa2tvmxeS2QYQ5viMN5LVWLAi+fxL2J9oI6SFSOeMLC2tfIYrhG8GQ7K2bnG5EbLDwADE670oFf0ITyRVMBITDl8/4uHNec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758320972; c=relaxed/simple;
	bh=3xIrvba4VbbYjqpF0TMuM5tM3GrInpIZhpgrrB7txlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QN3jWb5kS9OECaFwq43mXYXEFqV+Frkb1dHca1CATNVoZ71FN3m0Pr3EJ5MqutcU5lhs0l1fx/06/ew6gTrQ/rxemDrbdVfao4NuuOeIy0bnYE/PdG3QCixC8mkpVCwzNnpg3xiIhSmLzgVNC43e6+Ync3UwvnoqFrD7D4p3Bd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/u4YTJz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-26685d63201so25325185ad.0
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 15:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758320970; x=1758925770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gz0xbRCsyuFCEdeUVqSIk18YQVTH8dg0QOwJoen90po=;
        b=W/u4YTJzmOn/U9UXE1skvv2mQCZTh0neSphkofo7NHDF/wGzMdgwKiTA+jpm9zXjmw
         7tqTzkQDjshBuX352tE6rN/SKYIcySjz/GqdiOnzYZ/lwU58ckXar9Vvi6QjC2LuuMYI
         bK+ZADTGdYLjPFy2sD/9hDu+lx+wNNHH7FCBOi9vX9zOBZX8GZSOrAM5RmXF1c0U5cx6
         +QYXzbZ1t6QKbOtpqT4eurIu2o4pK9rohBZuRTddtv4WmJbz18nlqQdcDT+/1IcHiH9T
         kYLnZ9XGuzKp6SxVL+EJhEY5kiFu0vymmBWCxIijAz9S/sLodohAL6fMBcxgRG2JlvcU
         G2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758320970; x=1758925770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gz0xbRCsyuFCEdeUVqSIk18YQVTH8dg0QOwJoen90po=;
        b=IGdDUv10jDoaf1q1UZ0Y99K/yqPtgQJ7ia2fNE60JvsapMuRHlbfcDxJ0mOAxI3yJX
         z/HbVIO0rcMoNUDgQFWSLmA8qOoMaUg3bi2msQkf6cSGpyf7rUQr205IxOZnEuamYbeD
         36RhBOVStwlrKy9LMxnvIUcQU5fiHAvqOrBDdV16HAqVqkTOggTZ0+iHP5kJlo/LLEhD
         OgDXx768WvAQhABA6KDHLAigDCvBfbavV/j/Gifg9l6D63ZSfHwOqImI6xlp9GlAEoCR
         Yu2rZPeVkHzF2/cSDZss3tKTJB9HguNBfiH9kq+qjUgzV3OUgt30Rjzvh7Z1elQ6yuVJ
         hHIA==
X-Forwarded-Encrypted: i=1; AJvYcCV2rZEgEnNDMVysTdwPglLhfGS1RlrlAri3JEr9JXIAr3cd8ryC1S9uyBN65P9+AiX8MEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj5ZUGXn9k9s2jkm7+zuUbUN0iNAvjQlgly5Ys8c1RiynhILxM
	yI89ODf3EzhaCfWfe4Nja1DsFwe6xS3ELHvTdBAPHkgWeFwEb27qDvJzWx+MSmycOO8PhUmlpi9
	hn8BKIJMUhrYGHLpfqjrOJZOSpMuM/Jk=
X-Gm-Gg: ASbGncuGKln9XDO/DJOD2xq+dNJ1DU8/67vaq0Oj2BJ64Z/aiKVw1DFa5rNV07KR7pu
	h0XV8vpvmLknTrxeUbWla0TIbe/KDvcPastBMDhaTlXiuHjkD7nO/eP+Ug1bOtgueyoZhIE9jpw
	iZ7ltT/XAqJ9Re5bK4SsEt9NMeKGrTqMsYfVo5GdyG83foMPqo/SWleTUNwzCQOsnW9rR1P/fmF
	6M3WHpu1TewMB7b4WZZLJE=
X-Google-Smtp-Source: AGHT+IGrXR6VjukAxiPHpDyPrMagqZbM8m52bH1eshishJyoJj3B0Oy1H3dx+TRH9vMrkh/g+SPbPwbyiUnQeBQf6vU=
X-Received: by 2002:a17:902:ce0f:b0:26e:146e:7692 with SMTP id
 d9443c01a7336-26e146e795dmr27870565ad.17.1758320969729; Fri, 19 Sep 2025
 15:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918093606.454541-1-a.s.protopopov@gmail.com>
 <CAADnVQLso776xFQTzPFahmV=JbE3Ca8jQ7UdPuMChjJAK_echg@mail.gmail.com>
 <aMwy+pt+Rg1eNr0z@mail.gmail.com> <CAADnVQ+2ic2gWyvqp4qFCwZpKqV+7BDnovL08Jp0tFSaC4pm9g@mail.gmail.com>
In-Reply-To: <CAADnVQ+2ic2gWyvqp4qFCwZpKqV+7BDnovL08Jp0tFSaC4pm9g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Sep 2025 15:29:15 -0700
X-Gm-Features: AS18NWDqkgF2rGRl_WBWj-a-UnDChIiNFg0u9TyVWWBFHjIXOr-gWziwuGfbAlc
Message-ID: <CAEf4BzYi1xX3p_bY3j9dEuPvtCW3H7z=p2vdn-2GY0OOenxQAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix build with new LLVM
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 9:29=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 18, 2025 at 9:21=E2=80=AFAM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > On 25/09/18 08:02AM, Alexei Starovoitov wrote:
> > > On Thu, Sep 18, 2025 at 2:30=E2=80=AFAM Anton Protopopov
> > > <a.s.protopopov@gmail.com> wrote:
> > > >
> > > > The progs/stream.c BPF program now uses arena helpers, so it includ=
es
> > > > bpf_arena_common.h, which conflicts with the declarations generated
> > > > in vmlinux.h. This leads to the following build errors with the rec=
ent
> > > > LLVM:
> > > >
> > > >     In file included from progs/stream.c:8:
> > > >     .../tools/testing/selftests/bpf/bpf_arena_common.h:47:15: error=
: conflicting types for 'bpf_arena_alloc_pages'
> > > >        47 | void __arena* bpf_arena_alloc_pages(void *map, void __a=
rena *addr, __u32 page_cnt,
> > > >           |               ^
> > > >     .../tools/testing/selftests/bpf/tools/include/vmlinux.h:229284:=
14: note: previous declaration is here
> > > >      229284 | extern void *bpf_arena_alloc_pages(void *p__map, void=
 *addr__ign, u32 page_cnt, int node_id, u64 flags) __weak __ksym;
> > > >             |              ^
> > > >
> > > >     ... etc
> > >
> > > I suspect you're using old pahole.
> > > New one can transfer __arena tags into vmlinux.h
> >
> > Ok, TIL about CONFIG_PAHOLE_VERSION (before I've sent the patch,
> > I've updated the pahole, re-built the kernel, but didn't do `make
> > oldconfig` after updating pahole.)
>
> Yeah. It's a footgun that few people are aware of :(
> I was bitten by it too.
> We have a small section about pahole in bpf_devel_QA.rst.
> We should probably expand it and list the common issues and how to fix th=
em.
> Every week somebody sends a patch due to old pahole :(
>

There is some magical CC_VERSION_TEXT that is supposed to fix a
similar problem for the compiler version. I didn't completely
understand how it's done, but perhaps we can use the same idea to
update pahole version when it changes?

