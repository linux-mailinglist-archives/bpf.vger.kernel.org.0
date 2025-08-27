Return-Path: <bpf+bounces-66728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6FBB38B55
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 23:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B4C1C22A1C
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 21:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41D630C62E;
	Wed, 27 Aug 2025 21:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VORZSDHb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D367A280A5F
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 21:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756330132; cv=none; b=Yu5xSkIIR2se44FchWhvNeE69EDtF4GFtN/EnuHpx3TLuu5Famhvnb+6fnL48nR9anU1+LfpGEDwH4xKwG+p/IQoaESna0RAKMKarqT29DDqP4WieeUaGaZTt2Ompz+KpiVmgCVUdPwBXjmujmOqUBZKuBu45r6mfvwb6JsJW1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756330132; c=relaxed/simple;
	bh=14x6mTLnb+otM8gyVuteeJeehazkwRhlWBEJQBs1mwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vD1nETb9RlxwXwSEZValoIU/mUWhTHzg4xk+cKOj8o1mra/BtI2XXZpwJeufcCQkj/3ZFO1MHttc1/1UbsaEu/1AGFJAw6IFQAU9BZ8dm2QnfP6kQb3qtsOrK7opIOILUjGdakQspsEBITZ2SsO3rJLQsze6vT6y/mMrpyPRMBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VORZSDHb; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b49cf21320aso401730a12.1
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 14:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756330130; x=1756934930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egGLwGgznQD0cyyABvtGr9UMRder2xzOk0bFAUncqWM=;
        b=VORZSDHbrWypN9hWKxe9Bk6lpf34IxEcg5xfuKt+LERF1203tgw9xbCrPGCg0Ok5AN
         UFp5mqtnxHCOEQA4f5JHxNR5awonHQTa9I4t/YgUCCSTTDC5shVuD7GqhN0G7VPoidSL
         SLGhX+DyLI2AXGGWL33D4O5SgykBpMrnc1kWBwxmd6I84ureGmpSLPKNxfZg5UtPzAxN
         cchEj5nohHn6rZwCsPLB4bRVyvK09r9SIcggoAflFT8kVDQbH5VcFCCphKzOFXezE1qs
         L6TUy1G+gGZbfUDC8KdMuUElx4cEp3E6fhEuESBTPM5G53TxjIYWA2JlWtNj40WSyDyz
         q9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756330130; x=1756934930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egGLwGgznQD0cyyABvtGr9UMRder2xzOk0bFAUncqWM=;
        b=XimKI5V4VcMl46fv6dZ96ihvSRQJp8PA5rwCu18perwXjvUQdmFb5WVfJQ9WILCEB+
         dzufBBBGtFcniSahN1m+oxOpanK3W68wLMnIJYac8kEStYQz+2EVtHsbEH528aWLe6LS
         UPqVZcm8coTFxkyTNXVXpUaWdfZZOAtKxfDDiKIYdvD7W3qe2E9wPyohDMk/VLMcSgiw
         i7ZChU7tYbkx36diJ6Y82LjTCaBhGrrJiGOUSkW7D+l8qww0zZzYgOUqOndtur7MAr1p
         9c5Z1ZsOlKNM0kOOr6ivsiCaOxjz5zoKItMK7To3vS9EPDWuEnJK4CUav+0h/4XOWi52
         UVjA==
X-Forwarded-Encrypted: i=1; AJvYcCVGy/GmA2lMf2Y7c2OBx5O5k00SXX7kL4QOJ/1nMkTgm1T9boTvMX/sS9zBtDpGToR2OZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlg0KILPBzD8DlAcXNiC5jMi6XV5a6rgqzomFJjAUPCilWP42L
	/FG1XSudFjwxbB1Hqjyo8FJOnATF2z/R+62zzdf9UztJqh0XVcqfba5AEW0f3cd+cwl4M1nO1Ps
	hRsHNcrjimbF1Pk9lPyEtXueW3wERmaUcAg==
X-Gm-Gg: ASbGncvgcapZBN2HwfE1iwL7vQ3GA4UYBHsCgikkYmlcyacwa4pnTP0c5nH5+DhMGKJ
	oNvvK8OYiJ1K0Zs7Llh/93itIaitDqewE6O/5cLz+XyS5JgQzBDBhD2yPTmtXgbWjoOxz3Z9NZS
	XEibYEgtR8FAwx8Q7vrAVBoecSZOQ0tuxA5qMloyygNZ1l89ygNHde0aGHg6/opS6HM4KQdgWIi
	rK6h5HNTcP+u6bgzfu7dNR6164Sfd3soA==
X-Google-Smtp-Source: AGHT+IEjElbk5Sg2SLZA/hfRXsmxn/AnPpYrDlUv/jT3bqMHvRexDPnuLfZjB/a6AzdmHr4OoltiBLBl9rDtW5EaAYg=
X-Received: by 2002:a17:90b:1f91:b0:325:83:e1d6 with SMTP id
 98e67ed59e1d1-32515ee21bbmr23987586a91.2.1756330130116; Wed, 27 Aug 2025
 14:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827130519.411700-1-iii@linux.ibm.com> <20250827130519.411700-2-iii@linux.ibm.com>
 <CAEf4BzZgf4vRWnse6N1X_h4X6XPuax_iMxiJ5x=kwLyJzz8x-w@mail.gmail.com>
 <1c796beb8e6d864f6c7498b8a31e2085986e2d60.camel@linux.ibm.com>
 <CAEf4BzYaZJ-TH_T32QpuxdeXOa4yt1dqrExbV6xrsXvs+kp6kQ@mail.gmail.com>
 <f1b6178d73d242c20ac2345d2da9293dd3d1906f.camel@linux.ibm.com> <b1b7ffb001712eca27cfafb71365920833eafcd9.camel@linux.ibm.com>
In-Reply-To: <b1b7ffb001712eca27cfafb71365920833eafcd9.camel@linux.ibm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Aug 2025 14:28:35 -0700
X-Gm-Features: Ac12FXwpUtLOmKL7yRRhwHKlDgjZyW2HOxvkAFJC3zGZARSZ11n7Vpp7C3vCz5Y
Message-ID: <CAEf4BzY3wpBSQY5CWkm7CLrD3ZHHoq6LR7dOiCiT6=TmKONGLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Annotate
 bpf_obj_new_impl() with __must_check
To: Ilya Leoshkevich <iii@linux.ibm.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 2:04=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> On Wed, 2025-08-27 at 22:54 +0200, Ilya Leoshkevich wrote:
> > On Wed, 2025-08-27 at 13:05 -0700, Andrii Nakryiko wrote:
> > > On Wed, Aug 27, 2025 at 11:34=E2=80=AFAM Ilya Leoshkevich
> > > <iii@linux.ibm.com>
> > > wrote:
> > > >
> > > > On Wed, 2025-08-27 at 10:32 -0700, Andrii Nakryiko wrote:
> > > > > On Wed, Aug 27, 2025 at 6:05=E2=80=AFAM Ilya Leoshkevich
> > > > > <iii@linux.ibm.com>
> > > > > wrote:
> > > > > >
> > > > > > The verifier requires that pointers returned by
> > > > > > bpf_obj_new_impl()
> > > > > > are
> > > > > > either dropped or stored in a map. Therefore programs that do
> > > > > > not
> > > > > > use
> > > > > > its return values will fail to load. Make the compiler point
> > > > > > out
> > > > > > these
> > > > > > issues. Adjust selftests that check that the verifier does
> > > > > > indeed
> > > > > > spot
> > > > > > these bugs.
> > > > > >
> > > > > > Link:
> > > > > > https://lore.kernel.org/bpf/CAADnVQL6Q+QRv3_JwEd26biwGpFYcwD_=
=3DBjBJWLAtpgOP9CKRw@mail.gmail.com/
> > > > > > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > > > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > > > ---
> > > > > >  tools/lib/bpf/bpf_helpers.h                          | 4
> > > > > > ++++
> > > > > >  tools/testing/selftests/bpf/bpf_experimental.h       | 2 +-
> > > > > >  tools/testing/selftests/bpf/progs/linked_list_fail.c | 8
> > > > > > ++++-
> > > > > > ---
> > > > > >  3 files changed, 9 insertions(+), 5 deletions(-)
> >
> > [...]
> >
> > > > > >  /* When utilizing vmlinux.h with BPF CO-RE, user BPF
> > > > > > programs
> > > > > > can't include
> > > > > >   * any system-level headers (such as stddef.h,
> > > > > > linux/version.h,
> > > > > > etc), and
> > > > > >   * commonly-used macros like NULL and KERNEL_VERSION aren't
> > > > > > available through
> > > > > > diff --git a/tools/testing/selftests/bpf/bpf_experimental.h
> > > > > > b/tools/testing/selftests/bpf/bpf_experimental.h
> > > > > > index da7e230f2781..e5ef4792da42 100644
> > > > > > --- a/tools/testing/selftests/bpf/bpf_experimental.h
> > > > > > +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> > > > > > @@ -20,7 +20,7 @@
> > > > > >   *     A pointer to an object of the type corresponding to
> > > > > > the
> > > > > > passed in
> > > > > >   *     'local_type_id', or NULL on failure.
> > > > > >   */
> > > > > > -extern void *bpf_obj_new_impl(__u64 local_type_id, void
> > > > > > *meta)
> > > > > > __ksym;
> > > > > > +extern __must_check void *bpf_obj_new_impl(__u64
> > > > > > local_type_id,
> > > > > > void *meta) __ksym;
> > > > >
> > > > > bpf_obj_new_impl will generally come from vmlinux.h nowadays,
> > > > > and
> > > > > that
> > > > > one won't have __must_check annotation, is that a problem?
> > > >
> > > > It should be fine according to [1]:
> > > >
> > > > Compatible attribute specifications on distinct declarations of
> > > > the
> > > > same function are merged.
> > > >
> > > > I will add this to the commit message in v3.
> > >
> > > Sure, for BPF selftests it will work. My question was broader, for
> > > anyone using bpf_obj_new in the wild, they won't have __must_check
> > > annotation from vmlinux.h (and I doubt they will manually add it
> > > like
> > > we do here for BPF selftests), so if that's important, I guess we
> > > need
> > > to think how to wire that up so that it happens automatically
> > > through
> > > vmlinux.h.
> > >
> > > "It's not that important to bother" is a fine answer as well :)
> >
> > I see. Seems like it's tough:
> >
> > - The attribute is not available in DWARF
> > - But we could introduce KF_MUST_CHECK flag
> > - Which pahole would extract from .BTF_ids and convert to
> >   a btf_decl_tag
> >   - This will make pahole depend on .BTF_ids format though, which
> > might
> >     be undesirable
>
> Hm, I should have checked that before hitting "send": apparently pahole
> already parses both .BTF_ids and __BTF_ID__set8__*.

Correct, this isn't any new dependency.

> Still, DW_TAG_GNU_annotation looks like a better long-term solution.

Ihor a bit earlier added BTF-specific way to attach any random
attribute to BTF type (it's a special form of
BTF_TYPE_TAG/BTF_DECL_TAG), I think it's still on his plate to wire up
the use of that for a few long-standing issues with vmlinux.h, so this
might be yet another reason and use case for that.

But agreed, for now I'd go with BPF selftests-specific mitigation.

>
> > - Then bpftool would convert this btf_decl_tag to __must_check
> >
> > Seems like they are attempting to upstream the new
> > DW_TAG_GNU_annotation right now [1], if that lands and is available
> > for non-BPF targets, we could put
> > __attribute((btf_decl_tag("must_check"))) on kernel's
> > bpf_obj_new_impl() and directly access it from bpftool.
> >
> > So for now I would propose to limit the solution to selftests.
> >
> > [1] https://gcc.gnu.org/pipermail/gcc-patches/2025-August/692445.html
> >
> > > > [1]
> > > > https://gcc.gnu.org/onlinedocs/gcc-12.4.0/gcc/Function-Attributes.h=
tml
> > > >
> > > > [...]

