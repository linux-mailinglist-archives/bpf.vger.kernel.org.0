Return-Path: <bpf+bounces-52127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D19A3E997
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 02:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3624519C42F6
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 01:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E792CCA5;
	Fri, 21 Feb 2025 01:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nP56d6z+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CFD3594E
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 01:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099740; cv=none; b=ep8a8adKUqM94FdghBLF++mv8u6E+DNOmEZch47Ufj1/f69hERrHNm1Tos85qsgbFI3UYshkciBVBGIwwN3OFhA6VihC+3cy2lBclGhYioFvDB3FDsdKj7KLn557u7gWbYNz3WnmRRVg5D+6Ze6vUd6xlxKdjZpVDiNsEONeB0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099740; c=relaxed/simple;
	bh=l+6kdNhTYVai6NE8RGKRLb9Kn8FqOM4mXa2Ek5k/umE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLsX01JPXGQJR8SjGlWgmSy+k6bIPeOU+OdZAGr/7nt6XG0qGNO+tUHpdnjG006zdXMGJ3ivXi555Ta6aPdtUFSGccMpJr85lyoj7pW6yE7pTdN59sqvOv7VeiC/MDrOOg0ZR5ENTpVrc6yvQELqmcpQ7rkBxzqu6RLoaAXeb+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nP56d6z+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220d28c215eso24698935ad.1
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 17:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740099737; x=1740704537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/XD1eCcEbDnYoRhB2zsl0r5aTKtI/770+zegD/8PkU=;
        b=nP56d6z+/lwytlBAJuqrBIAv8sUUXIujN+6+Ii13vp43t3LYAi1KNsEzv7xg9h/T4v
         /HNjiBy38ypIWmGceudWfGUVzbkVJnl4nvkc72SAIn8wLlTJDCxbcE0FZRHBZzHUz9pO
         0SsX55xioo7JVdY9uPxvg4cvlDgDC2JiD1QG6uEa/NpwEgM/iA3PiLuaE7VP4OsemOfE
         ZC3mmyDKt/fAXM3C/WTNmOacjmOF6gVb89HFEfHo2+WHvee0t5Kcs/aosZ04Xho/+HM1
         zN1SpgUlWGKO4Fc8k+yWmRNEgliYnDyj8qOCvB1S0ddyPGSvkmoh13d+lWLI0EXUWK4Q
         Ykgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740099737; x=1740704537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/XD1eCcEbDnYoRhB2zsl0r5aTKtI/770+zegD/8PkU=;
        b=XVjQ4t5jmz8OkXc04GAghNhMZLhStc3vujHI91oIgg3KkxL/t6COdPthcicunVpvZg
         kzgV6fdEucCZxSkCF2dIAtZVZOjNgwACa797IF3/8D1qPsxxOonXO6pb51HHdW2SBMEO
         sLUXNlIwbNOihkx55ib2e0YTlHzx83EE/YmX/Ezp3oqYv4Gfm9OA3vCEpZpl+ZplUNlw
         zs6L2LMPEjNgO+ZY8lD8AZsYFa7kpT4/zv7clmc/dYke/sdW9g0vnpLEgoEWiyo/rOaQ
         gDMrbnsClj8ncxF28L/WhVGSi7TXvka2xLzgq7WCqqHD6ITB29ZNo0EN2sPcJW+EXGWr
         iXZA==
X-Forwarded-Encrypted: i=1; AJvYcCWFHxoZkCYjpOakhHGEwDOeo016WpPyIChwkKGM3g9nuf5NSh5gkKVR88CrECT2kE8NQnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyci5smQeMKTNmCekDrBiBT/zxyQFqLHEAoTaDdEIQWTl3+2N4c
	Uj/Iw8UT3kaDfb2NSVQkgHkBjD+PFLPDt2iasMtKyuMj5w6ym4Yyy5IqtrByD+jdZCCu5STJl53
	5gS7DwmSX71EU1rlboEzhVTjzxuM=
X-Gm-Gg: ASbGncvtcCu1MvmG4EuUi0Z1ORl7iUTFkAjEbn2ZCKOT1P1cAbLAmQUsa+h9LzbQUs2
	Nu/JYSGWIrLsWajg7e9y5PR7s48/JxEuBUX7Svvy5VvbiGVGu9VvuMHveVkL4KgYyBg9yNdRoj/
	0Sl4Jhzy53zmbv
X-Google-Smtp-Source: AGHT+IGAw9dvEl/sZNEafcCYOdYUwX1MZoJ6PtsR8Epqt/y6NprNekXYo1fxRgSdD+sKopuCEE+He+8RDygUZvhW+oA=
X-Received: by 2002:a17:903:946:b0:215:5a53:edee with SMTP id
 d9443c01a7336-2219ff35f5dmr19352165ad.9.1740099736956; Thu, 20 Feb 2025
 17:02:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219125117.1956939-1-memxor@gmail.com> <20250219125117.1956939-2-memxor@gmail.com>
 <CAADnVQ+TBG+yAxtY1Q5D6HnhbvgusUVrzyRm7-8oF7wYw+Nqfw@mail.gmail.com>
 <CAP01T74tZudfS8huoz=sP4UkEgs5ipkz9Qjf=6XNVzJvGOFLgQ@mail.gmail.com>
 <CAEf4BzbyF3aWdE0Uk0KtdeYwmEYSahfpZk=vK-JhhZ-Bgb55ZQ@mail.gmail.com>
 <CAP01T76=Twha0twPgzO8Un6--e3cX1PMFEtu1jHVS_7iQzOcfQ@mail.gmail.com>
 <CAEf4Bzbny7VFufpMq6RZJ1_poYsAFw89tpmKHhMSbTNb2=PsBg@mail.gmail.com> <CAP01T77PkyNSweQ8SAoaxc7zO8eL66UX0HgjwAX7Q9rqatCgKw@mail.gmail.com>
In-Reply-To: <CAP01T77PkyNSweQ8SAoaxc7zO8eL66UX0HgjwAX7Q9rqatCgKw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 20 Feb 2025 17:02:04 -0800
X-Gm-Features: AWEUYZlh0ibSzrXJ-fN2AkcpJGtRirSTBGlNfpwHgVO0-SP7zMnMJ5tBJLAl10k
Message-ID: <CAEf4BzbQGW0jCT99-kskMOAE=po6+9txmf91oU-QDqqwWc1rfg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 1/2] bpf: Explore PTR_TO_STACK as R0 for bpf_dynptr_slice_rdwr
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 4:37=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 21 Feb 2025 at 01:27, Andrii Nakryiko <andrii.nakryiko@gmail.com>=
 wrote:
> >
> > On Thu, Feb 20, 2025 at 7:41=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Thu, 20 Feb 2025 at 01:13, Andrii Nakryiko <andrii.nakryiko@gmail.=
com> wrote:
> > > >
> > > > On Wed, Feb 19, 2025 at 10:10=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > > <memxor@gmail.com> wrote:
> > > > >
> > > > > On Wed, 19 Feb 2025 at 18:41, Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Feb 19, 2025 at 4:51=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > > > > <memxor@gmail.com> wrote:
> > > > > > >
> > > > > > > For the bpf_dynptr_slice_rdwr kfunc, the verifier may return =
a pointer
> > > > > > > to the underlying packet (if the requested slice is linear), =
or copy out
> > > > > > > the data to the buffer passed into the kfunc. The verifier pe=
rforms
> > > > > > > symbolic execution assuming the returned value is a PTR_TO_ME=
M of a
> > > > > > > certain size (passed into the kfunc), and ensures reads and w=
rites are
> > > > > > > within bounds.
> > > > > >
> > > > > > sounds like
> > > > > > check_kfunc_mem_size_reg() -> check_mem_size_reg() ->
> > > > > > check_helper_mem_access()
> > > > > >    case PTR_TO_STACK:
> > > > > >       check_stack_range_initialized()
> > > > > >          clobber =3D true
> > > > > >              if (clobber) {
> > > > > >                   __mark_reg_unknown(env, &state->stack[spi].sp=
illed_ptr);
> > > > > >
> > > > > > is somehow broken?
> > > > > >
> > > > > > ohh. It might be:
> > > > > > || !is_kfunc_arg_optional(meta->btf, buff_arg)
> > > > > >
> > > > > > This bit is wrong then.
> > > > > > When arg is not-null check_kfunc_mem_size_reg() should be calle=
d.
> > > > > > The PTR_TO_STACK abuse is a small subset of issues
> > > > > > if check_kfunc_mem_size_reg() is indeed not called.
> > > > >
> > > > > The condition looks ok to me.
> > > > >
> > > > > The condition to do check_mem_size_reg is !null || !opt.
> > > > > So when it's null, and it's opt, it will be skipped.
> > > > > When it's null, and it's not opt, the check will happen.
> > > > > When arg is not-null, the said function is called, opt does not m=
atter then.
> > > > > So the stack slots are marked misc.
> > > > >
> > > > > In our case we're not passing a NULL pointer in the selftest.
> > > > >
> > > > > The problem occurs once we spill to that slot _after_ the call, a=
nd
> > > > > then do a write through returned mem pointer.
> > > > >
> > > > > The final few lines from the selftest do the dirty thing, where r=
0 is
> > > > > aliasing fp-8, and r1 =3D 0.
> > > > >
> > > > > + *(u64 *)(r10 - 8) =3D r8; \
> > > > > + *(u64 *)(r0 + 0) =3D r1; \
> > > > > + r8 =3D *(u64 *)(r10 - 8); \
> > > > > + r0 =3D *(u64 *)(r8 + 0); \
> > > > >
> > > > > The write through r0 must re-mark the stack, but the verifier doe=
sn't
> > > > > know it's pointing to the stack.
> > > > > push_stack was the conceptually cleaner/simpler fix, but it appar=
ently
> > > > > isn't good enough.
> > > > >
> > > > > Remarking the stack on write to PTR_TO_MEM, or invalidating PTR_T=
O_MEM
> > > > > when r8 is spilled to fp-8 first time after the call are two opti=
ons.
> > > > > Both have some concerns (first, the misaligned stack access is no=
t
> > > > > caught, second PTR_TO_MEM may outlive stack frame).
> > > >
> > > > Reading the description of the problem my first instinct was to hav=
e
> > > > stack slots with associated obj_ref_id for such cases and when
> > > > something writes into that stack slot, invalidate everything with t=
hat
> > > > obj_ref_id. So that's probably what you mean by invalidating
> > > > PTR_TO_MEM, right?
> > > >
> > > > Not sure I understand what "PTR_TO_STACK with mem_size" (that Alexe=
i
> > > > mentioned in another email) means, though, so hard to compare.
> > > >
> > >
> > > Invalidation is certainly one option. The one Alexei mentioned was
> > > where we discussed bounding how much data can be read through the
> > > PTR_TO_STACK (similar to PTR_TO_MEM), and mark r0 as PTR_TO_STACK.
> > > This ends up combining the constraints of both types of pointers (it
> > > may as well be called PTR_TO_STACK_OR_MEM) without forking paths.
> >
> > Yeah, PTR_TO_STACK_OR_MEM would be more precise. But how does that
> > help with this problem? Not sure I follow the idea of the solution
> > (but I can wait for patches to be posted).
>
> The reason for push_stack was to ensure writes through the returned
> pointer take effect on stack state.
> By keeping it PTR_TO_STACK, we get that behavior.
> However, in the other path of this patch, the verifier would verify
> the pointer as PTR_TO_MEM, with a bounded mem_size.
> Thus it would not allow writing beyond a certain size.
> If we simply set r0 to PTR_TO_STACK now, it would possibly allow going
> beyond the size that was passed to kfunc.
> E.g. say buffer was fp-24 and size was 8, we can also modify fp-8
> through it and not just fp-16.
> Adding an additional mem_size field and checking it (when set) for
> PTR_TO_STACK allows us to ensure we cannot write beyond 8 bytes
> through r0=3Dfp-24.

yeah, this part is clear, of course, but I was actually more worried
about handling the following situation:


struct bpf_dynptr dptr;
void *slice;
union {
    char buf[32];
    void *map_value;
} blah;

bpf_dynptr_from_skb(..., &dptr);

slice =3D bpf_dynptr_slice_rdwr(&dptr, 0, &blah.buf, sizeof(blah.buf));
if (!slice) return 0; /* whatever */

/* now slice points to blah.{buf,map_value}, right? */

map_value =3D bpf_map_lookup_elem(&some_map, ...);
if (!map_value) return 0;

/* we shouldn't allow working with slice at this point */
*(u64 *)slice =3D 0xdeadbeef; /* overwrite map_value */

*(u64 *)map_value =3D 123; /* BOOM */


Would this PTR_TO_STACK_OR_MEM approach handle this? If so, can you
briefly walk me through how? Thanks!

>
> I hope this is clearer.
>
> >
> > >
> > [...]

