Return-Path: <bpf+bounces-52204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC91AA3FD30
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 18:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF541884448
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 17:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21EC24E4C7;
	Fri, 21 Feb 2025 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jsv+x1Tm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CD624E4A2
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158147; cv=none; b=pumuvGHmiODgBkWP1rMU6bZsJMC1iNYj2jvDq7a04U2m2SZ8UyIlK93NrIQQcG77XSUKYaiYtV4xb5Twr2d+sDLvuOyjqU70JR/W+jwZDv35+QzTOT8DHTmwgn6wWHuq++0iorn2Fy2+U185hf8M4QKHn+F2SzuUsOQ31yq/TDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158147; c=relaxed/simple;
	bh=Agg+neHrEpxh4frienV4pBt3QQ08ML6J6HNfZyKok/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4NLhiAeU3ID0Q2rNRREGCBxL0BQ7fgzdHTc1XtfB0aWIjzloQM2hMzZQvuSL4BXzdUbAPlxxBtS4Af6MaeB60u9AkTc9/LuY521RgG0Lr05VkoJGxMrJ/umM/bax1ZlMRXj5gF7s1c0Sz0EQ9QMpEds1ssY1bIGlePl1ww3hJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jsv+x1Tm; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fc0d44a876so3920818a91.3
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 09:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740158145; x=1740762945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpBOLXVUGu+rKuOFxGqH6gSAJFghra9/JnDkgvh1OnY=;
        b=Jsv+x1TmckWxiMcC9QWiMz1nKtTF4NBDIxJE9gQXwnZbc2lR7Me88+/reIrRDuABhr
         49hYSPcCUILFavnAzyp66UKgkLE5Jarh/BygupscUvIqo7d6BgxwpLA91gAW60sKMXsV
         ZWrCBzMzkCtg/kg6RvB1209bVGJaH3JtCIjpCfUSSDi6OLIJ5NJwn6E2OpVCpHB6uLrf
         Bi4/J6tVBYyuAX6ZpJKrqM6WBYWsDuSNMj37AQqIm1UTed5hetkXuXo5vlZLqQXi7ZBs
         c6x7Ub9E61a2dMvb8QoxNivQTyDRDHBjjAMDiyHD7ac2gWje9JKSe9IROJRNZNeTd+ib
         45gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740158145; x=1740762945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpBOLXVUGu+rKuOFxGqH6gSAJFghra9/JnDkgvh1OnY=;
        b=GUxiRYe0vl1iKMAZsbGGt0DIaJJE8ueyjxTWjDAsk2BNz5n23AXgKoM0iug/PHEaWs
         I/dcFUvHP8NVXjfl1xBwICRwo8TB00xiCoZuTvUwH8NmXs8hV28ylkGyDsChCtUZOBd/
         csptWsu+Onmz69a25tLjwNIwbEHyb9Y++8WLcrIZnl/pwW0QuUw56aOX+DHN4Ez+xCbp
         ZZvn7j/efOyVsbbZKSXWEI6qkFOOrG3Pmen0YrelNXfPv1ZHVzuRBbRznaccPhLB+deM
         BsYFpHEtviG3yUB3SnpY0bvJepsX+6rHEWiBFNj+25ko8tb2gqGdHefv23R3bkRbTxft
         rWEg==
X-Forwarded-Encrypted: i=1; AJvYcCVeygTV6Pkk4MUbE/x1r7Pi49W7bmYvSqfoL8q3RpDZlzwmsKNzR9uTPAUWkma5qWo36is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw17KKljcZzgBXDiKeoZqrs4jozoWLLlRQpHgiuEABMDLyvDRKW
	zenRPx0cdNNc9H+BDUkocFW8Y2vkOaIWVLcwyhS+lZhM6sH4RPd61K8fn6K4awrD+PKrbaDT1xz
	fhbOhJYg521N3vkJEEu9w+JBd4Mc=
X-Gm-Gg: ASbGncuCvaTQyKgImppTRUuH5iSLL6URqbSNhC74Zwod+Uo+lDrJAKrLm+w/M/mJX2O
	9jbQ8oInur4H4jx5q/QkAGiA71tyuLHPTKgrK1qb4E3ja1FJUv6dSDuwXZLkU7qJB0QRnwww0i4
	mvXyVLCw==
X-Google-Smtp-Source: AGHT+IGrq0T8fgldKDyIwF90Cn4KZ7qJdt9QoYTP0JvCxirr4gj8bPxSnb4IXbHtJ4u5b1EvJgwsDpUFbe4TW6Fim6M=
X-Received: by 2002:a17:90b:2d46:b0:2ee:f440:53ed with SMTP id
 98e67ed59e1d1-2fce7b45be4mr6118533a91.31.1740158144920; Fri, 21 Feb 2025
 09:15:44 -0800 (PST)
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
 <CAEf4Bzbny7VFufpMq6RZJ1_poYsAFw89tpmKHhMSbTNb2=PsBg@mail.gmail.com>
 <CAP01T77PkyNSweQ8SAoaxc7zO8eL66UX0HgjwAX7Q9rqatCgKw@mail.gmail.com>
 <CAEf4BzbQGW0jCT99-kskMOAE=po6+9txmf91oU-QDqqwWc1rfg@mail.gmail.com> <CAP01T74zy-DfLP0JiW8m8-QncBmwB=Zes8PV0C0TvkXUSkpnVA@mail.gmail.com>
In-Reply-To: <CAP01T74zy-DfLP0JiW8m8-QncBmwB=Zes8PV0C0TvkXUSkpnVA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Feb 2025 09:15:32 -0800
X-Gm-Features: AWEUYZkXDt3Wmx3aT4F84rcMBazMjrTBuJVL1UvSHkZ-WrE_Mk1kx8rQ1ovYdAc
Message-ID: <CAEf4BzZSNEerrjg6iX=1u2CQk2TDC_V3cOBhHK3UB9GOrnd_Ug@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 1/2] bpf: Explore PTR_TO_STACK as R0 for bpf_dynptr_slice_rdwr
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 5:13=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 21 Feb 2025 at 02:02, Andrii Nakryiko <andrii.nakryiko@gmail.com>=
 wrote:
> >
> > On Thu, Feb 20, 2025 at 4:37=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Fri, 21 Feb 2025 at 01:27, Andrii Nakryiko <andrii.nakryiko@gmail.=
com> wrote:
> > > >
> > > > On Thu, Feb 20, 2025 at 7:41=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > > <memxor@gmail.com> wrote:
> > > > >
> > > > > On Thu, 20 Feb 2025 at 01:13, Andrii Nakryiko <andrii.nakryiko@gm=
ail.com> wrote:
> > > > > >
> > > > > > On Wed, Feb 19, 2025 at 10:10=E2=80=AFAM Kumar Kartikeya Dwived=
i
> > > > > > <memxor@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, 19 Feb 2025 at 18:41, Alexei Starovoitov
> > > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Feb 19, 2025 at 4:51=E2=80=AFAM Kumar Kartikeya Dwi=
vedi
> > > > > > > > <memxor@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > For the bpf_dynptr_slice_rdwr kfunc, the verifier may ret=
urn a pointer
> > > > > > > > > to the underlying packet (if the requested slice is linea=
r), or copy out
> > > > > > > > > the data to the buffer passed into the kfunc. The verifie=
r performs
> > > > > > > > > symbolic execution assuming the returned value is a PTR_T=
O_MEM of a
> > > > > > > > > certain size (passed into the kfunc), and ensures reads a=
nd writes are
> > > > > > > > > within bounds.
> > > > > > > >
> > > > > > > > sounds like
> > > > > > > > check_kfunc_mem_size_reg() -> check_mem_size_reg() ->
> > > > > > > > check_helper_mem_access()
> > > > > > > >    case PTR_TO_STACK:
> > > > > > > >       check_stack_range_initialized()
> > > > > > > >          clobber =3D true
> > > > > > > >              if (clobber) {
> > > > > > > >                   __mark_reg_unknown(env, &state->stack[spi=
].spilled_ptr);
> > > > > > > >
> > > > > > > > is somehow broken?
> > > > > > > >
> > > > > > > > ohh. It might be:
> > > > > > > > || !is_kfunc_arg_optional(meta->btf, buff_arg)
> > > > > > > >
> > > > > > > > This bit is wrong then.
> > > > > > > > When arg is not-null check_kfunc_mem_size_reg() should be c=
alled.
> > > > > > > > The PTR_TO_STACK abuse is a small subset of issues
> > > > > > > > if check_kfunc_mem_size_reg() is indeed not called.
> > > > > > >
> > > > > > > The condition looks ok to me.
> > > > > > >
> > > > > > > The condition to do check_mem_size_reg is !null || !opt.
> > > > > > > So when it's null, and it's opt, it will be skipped.
> > > > > > > When it's null, and it's not opt, the check will happen.
> > > > > > > When arg is not-null, the said function is called, opt does n=
ot matter then.
> > > > > > > So the stack slots are marked misc.
> > > > > > >
> > > > > > > In our case we're not passing a NULL pointer in the selftest.
> > > > > > >
> > > > > > > The problem occurs once we spill to that slot _after_ the cal=
l, and
> > > > > > > then do a write through returned mem pointer.
> > > > > > >
> > > > > > > The final few lines from the selftest do the dirty thing, whe=
re r0 is
> > > > > > > aliasing fp-8, and r1 =3D 0.
> > > > > > >
> > > > > > > + *(u64 *)(r10 - 8) =3D r8; \
> > > > > > > + *(u64 *)(r0 + 0) =3D r1; \
> > > > > > > + r8 =3D *(u64 *)(r10 - 8); \
> > > > > > > + r0 =3D *(u64 *)(r8 + 0); \
> > > > > > >
> > > > > > > The write through r0 must re-mark the stack, but the verifier=
 doesn't
> > > > > > > know it's pointing to the stack.
> > > > > > > push_stack was the conceptually cleaner/simpler fix, but it a=
pparently
> > > > > > > isn't good enough.
> > > > > > >
> > > > > > > Remarking the stack on write to PTR_TO_MEM, or invalidating P=
TR_TO_MEM
> > > > > > > when r8 is spilled to fp-8 first time after the call are two =
options.
> > > > > > > Both have some concerns (first, the misaligned stack access i=
s not
> > > > > > > caught, second PTR_TO_MEM may outlive stack frame).
> > > > > >
> > > > > > Reading the description of the problem my first instinct was to=
 have
> > > > > > stack slots with associated obj_ref_id for such cases and when
> > > > > > something writes into that stack slot, invalidate everything wi=
th that
> > > > > > obj_ref_id. So that's probably what you mean by invalidating
> > > > > > PTR_TO_MEM, right?
> > > > > >
> > > > > > Not sure I understand what "PTR_TO_STACK with mem_size" (that A=
lexei
> > > > > > mentioned in another email) means, though, so hard to compare.
> > > > > >
> > > > >
> > > > > Invalidation is certainly one option. The one Alexei mentioned wa=
s
> > > > > where we discussed bounding how much data can be read through the
> > > > > PTR_TO_STACK (similar to PTR_TO_MEM), and mark r0 as PTR_TO_STACK=
.
> > > > > This ends up combining the constraints of both types of pointers =
(it
> > > > > may as well be called PTR_TO_STACK_OR_MEM) without forking paths.
> > > >
> > > > Yeah, PTR_TO_STACK_OR_MEM would be more precise. But how does that
> > > > help with this problem? Not sure I follow the idea of the solution
> > > > (but I can wait for patches to be posted).
> > >
> > > The reason for push_stack was to ensure writes through the returned
> > > pointer take effect on stack state.
> > > By keeping it PTR_TO_STACK, we get that behavior.
> > > However, in the other path of this patch, the verifier would verify
> > > the pointer as PTR_TO_MEM, with a bounded mem_size.
> > > Thus it would not allow writing beyond a certain size.
> > > If we simply set r0 to PTR_TO_STACK now, it would possibly allow goin=
g
> > > beyond the size that was passed to kfunc.
> > > E.g. say buffer was fp-24 and size was 8, we can also modify fp-8
> > > through it and not just fp-16.
> > > Adding an additional mem_size field and checking it (when set) for
> > > PTR_TO_STACK allows us to ensure we cannot write beyond 8 bytes
> > > through r0=3Dfp-24.
> >
> > yeah, this part is clear, of course, but I was actually more worried
> > about handling the following situation:
> >
>
> For simplicity, let's just forget about stack_or_mem, and assume stack
> pointer with this extra mem_size.
> I haven't written the code yet but the idea would be to limit writing
> to [fp-N, fp-N+mem_size) through it.
> A screening check before we pass through to the normal stack access
> handling code.
>
> >
> > struct bpf_dynptr dptr;
> > void *slice;
> > union {
> >     char buf[32];
> >     void *map_value;
> > } blah;
> >
> > bpf_dynptr_from_skb(..., &dptr);
>
> At this point we mark dptr.
>
> >
> > slice =3D bpf_dynptr_slice_rdwr(&dptr, 0, &blah.buf, sizeof(blah.buf));
> > if (!slice) return 0; /* whatever */
> >
>
> slice is PTR_TO_STACK w/ mem_size =3D 32.
>
> We mark the bytes for buf as STACK_MISC at this point.
>
> > /* now slice points to blah.{buf,map_value}, right? */
> >
> > map_value =3D bpf_map_lookup_elem(&some_map, ...);
> > if (!map_value) return 0;
>
> The 8-byte slot for map_value in these 32-bytes becomes map_value.
> Rest remains misc.
>
> >
> > /* we shouldn't allow working with slice at this point */
> > *(u64 *)slice =3D 0xdeadbeef; /* overwrite map_value */
>
> And because slice is PTR_TO_STACK, we will notice the overwrite of map
> value with scalar.
>
> >
> > *(u64 *)map_value =3D 123; /* BOOM */
> >
>
> So this would fail as deref of scalar.
>
> Let me know if I missed something you were trying to point out.

Thanks for elaborating, I got the idea now. But I'm still unsure why
we need to invent this new mechanism instead of building upon the
existing one we already have. Note that when someone is overwriting
dynptr slots on the stack, we automatically invalidate all the
pointers derived from that dynptr. And also note that by itself it's
not even an invalid thing to use. Once code is done using dynptr, it's
ok to reuse that stack for something else.

So I was thinking the same thing here. That buffer on the stack passed
to bpf_dynptr_slice would be marked as DYNPTR_BUF or something like
that, and whenever some instruction overwrites any part of those stack
slots, we just invalidate those pointers.

This new PTR_TO_STACK aliasing for bpf_dynptr_slice() approach seems a
bit more error-prone, IMO (especially that returned pointer in reality
might not, and most often will not, point to the stack memory
actually; so it's a bit of mental exercise to keep this discrepancy in
one's head). Plus it might regress states convergence, because any
write through that pointer is now tracking some state on the stack,
even though we just read/write raw unknown bytes "somewhere in
memory".

Anyways, probably nothing broken here, but just a new concept that
feels unnecessary.

