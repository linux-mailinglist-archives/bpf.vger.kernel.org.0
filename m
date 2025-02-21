Return-Path: <bpf+bounces-52132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DAFA3E9B7
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 02:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C8337AA4A8
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 01:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72083597F;
	Fri, 21 Feb 2025 01:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTeAW36b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829803594E
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 01:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100424; cv=none; b=asxJRylmAZdHMibbwvN5/0LvjHasz7WccSJtAo/mrMvzOYcF4BAzQxQGbv4P02/kVKDlmR2ky/i3gEKl5LW4qeyF4wfUh55uSV6d9xzyZUAJmyIXeHHtHGpe0LGoSWR597s2W4/VWB+XEEo2p7mBOU0T4kb8LmWzrbjgnkbjwAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100424; c=relaxed/simple;
	bh=gsJfDQdvzdez8UtYxv0qxq2w0ZlrjuA56aiQOIGD5fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hC7ObdRFyj2McyEIF79FVYm5oVzUgvMgnT1KHHax1YbGaRLSV+qe9NpRl2XXSouaqaOurGTzMR1pJyqwdlqN/EWuDbz8iKL7/BM3njJhejin5pHRP5xfj5NTpBvY0BUgxh6GD4Ju6zO7ZxkonW1W+iE5BNvahPskWdYtsn5jRyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTeAW36b; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5e04064af07so1239884a12.0
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 17:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740100419; x=1740705219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2L/I2c7iZhP5qNROUKbrLy4st6SZt8jhG9l1JW8scY=;
        b=KTeAW36bCk0O2skKqfJVUWJvuy9bKTBO4nZTScBPLLNwgF4kzg7ERq7L9voySJJgpK
         nnInSB6C2BidnKxRnnqSNvBFmm5fF3vW9zzpxdP0q61Z68RPyreVTuNjlAMvC/66XQY3
         NiYZb0B4d8zV10FgMOvQ9Y7RT5HPu2A/csNMCULkvJ9HaQ57+siCjZK0X1DwxIKNysLY
         vQy5L/RZNpyK79ailuNJ33HoSaVVkcqMuKcn7mphh+ZIj/lMg2UfcayAjSzUj9R+cch0
         k3pY0r6WXWEyJF8Vr5qa76y3wapyOmWf3esn4uMFlAcj0+DdaLRf2TreOci7NSJV6une
         gilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740100419; x=1740705219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2L/I2c7iZhP5qNROUKbrLy4st6SZt8jhG9l1JW8scY=;
        b=BNbBT2UZb7oBT0F3WB/sLKrEGS0DPaZ0Jkf3FFcz9qVYGzyyFer6cD0/TmyV4ZW2lG
         pe7dv4P+4l8g5rsvHq2GNvaQsceGp3q5T7FsgdqwlmRU+Mx/gEgBSKJlE/NWZg+5Vqu2
         i9+U2HpFpgfVdUDtMO/WPGQZjt189UDRPDcq0kdWu8jNRPU0kyk3ejFBxu12qSIl3QnL
         L1sPME26VF4Uahgdc+KaI8pesKNablRhFiCs4ctoC9oRT/naIaND1y+BGPG51Bp791DF
         IGylLKiElcyr3qjY43ZdOoXVFKTANbnV8JjbCAiPW4iffBPTreqPytzrgkzm6YRrwbJp
         4fng==
X-Forwarded-Encrypted: i=1; AJvYcCVjg5gX3/AzjE9fj0e+43LVzIu0v7Bh1febsCFADvvzFb2/bsvEbjgpQGqHgmXcBmfFK3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxwWx2w/uZeAzyr2VCHFDFocqCNSVfBblEuE2EaGCfn0jHIOns
	9wRCciVJtUupzLU/IJTAHBADDidgYxR1d9egntzzcPdgCa5ab2Xx0RxABLgSXDTrDUb56g8KBZ7
	MnMYys8+PSWF9e/XNzXsonSy2/0Pf/L49
X-Gm-Gg: ASbGncsJZfq333kgvQymvLko8m/dhe0kR94vBmVLu1meypSpnfzHvW4e8tY6/goz+8v
	LZhkx/1xbHzZVOwXlnD2rLnYE0hYU8VuwrJg2b1LRTXWJC6Skw03k1JVscNVbQ1XIbHFhTFkWo4
	LPsRHaqjYDaJTlmEvQsg==
X-Google-Smtp-Source: AGHT+IH3Ar7TE+0Xsk4HnRftcigwYpDh5AHfAoI9i1YFOvAWbAqPckNGSZKGetojmNTDdtozyqc4ArfnXv+dLH5Vs9Q=
X-Received: by 2002:a05:6402:50c7:b0:5d9:a62:32b with SMTP id
 4fb4d7f45d1cf-5e0b70d0b39mr830818a12.7.1740100418810; Thu, 20 Feb 2025
 17:13:38 -0800 (PST)
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
 <CAP01T77PkyNSweQ8SAoaxc7zO8eL66UX0HgjwAX7Q9rqatCgKw@mail.gmail.com> <CAEf4BzbQGW0jCT99-kskMOAE=po6+9txmf91oU-QDqqwWc1rfg@mail.gmail.com>
In-Reply-To: <CAEf4BzbQGW0jCT99-kskMOAE=po6+9txmf91oU-QDqqwWc1rfg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 21 Feb 2025 02:13:02 +0100
X-Gm-Features: AWEUYZnxELdHQN8fnTgRgd8u9v3oBCEZxrjkSowv2iKbamwCcO5T8LqYZBxEmis
Message-ID: <CAP01T74zy-DfLP0JiW8m8-QncBmwB=Zes8PV0C0TvkXUSkpnVA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 1/2] bpf: Explore PTR_TO_STACK as R0 for bpf_dynptr_slice_rdwr
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2025 at 02:02, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Thu, Feb 20, 2025 at 4:37=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Fri, 21 Feb 2025 at 01:27, Andrii Nakryiko <andrii.nakryiko@gmail.co=
m> wrote:
> > >
> > > On Thu, Feb 20, 2025 at 7:41=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > On Thu, 20 Feb 2025 at 01:13, Andrii Nakryiko <andrii.nakryiko@gmai=
l.com> wrote:
> > > > >
> > > > > On Wed, Feb 19, 2025 at 10:10=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > > > <memxor@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, 19 Feb 2025 at 18:41, Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Feb 19, 2025 at 4:51=E2=80=AFAM Kumar Kartikeya Dwive=
di
> > > > > > > <memxor@gmail.com> wrote:
> > > > > > > >
> > > > > > > > For the bpf_dynptr_slice_rdwr kfunc, the verifier may retur=
n a pointer
> > > > > > > > to the underlying packet (if the requested slice is linear)=
, or copy out
> > > > > > > > the data to the buffer passed into the kfunc. The verifier =
performs
> > > > > > > > symbolic execution assuming the returned value is a PTR_TO_=
MEM of a
> > > > > > > > certain size (passed into the kfunc), and ensures reads and=
 writes are
> > > > > > > > within bounds.
> > > > > > >
> > > > > > > sounds like
> > > > > > > check_kfunc_mem_size_reg() -> check_mem_size_reg() ->
> > > > > > > check_helper_mem_access()
> > > > > > >    case PTR_TO_STACK:
> > > > > > >       check_stack_range_initialized()
> > > > > > >          clobber =3D true
> > > > > > >              if (clobber) {
> > > > > > >                   __mark_reg_unknown(env, &state->stack[spi].=
spilled_ptr);
> > > > > > >
> > > > > > > is somehow broken?
> > > > > > >
> > > > > > > ohh. It might be:
> > > > > > > || !is_kfunc_arg_optional(meta->btf, buff_arg)
> > > > > > >
> > > > > > > This bit is wrong then.
> > > > > > > When arg is not-null check_kfunc_mem_size_reg() should be cal=
led.
> > > > > > > The PTR_TO_STACK abuse is a small subset of issues
> > > > > > > if check_kfunc_mem_size_reg() is indeed not called.
> > > > > >
> > > > > > The condition looks ok to me.
> > > > > >
> > > > > > The condition to do check_mem_size_reg is !null || !opt.
> > > > > > So when it's null, and it's opt, it will be skipped.
> > > > > > When it's null, and it's not opt, the check will happen.
> > > > > > When arg is not-null, the said function is called, opt does not=
 matter then.
> > > > > > So the stack slots are marked misc.
> > > > > >
> > > > > > In our case we're not passing a NULL pointer in the selftest.
> > > > > >
> > > > > > The problem occurs once we spill to that slot _after_ the call,=
 and
> > > > > > then do a write through returned mem pointer.
> > > > > >
> > > > > > The final few lines from the selftest do the dirty thing, where=
 r0 is
> > > > > > aliasing fp-8, and r1 =3D 0.
> > > > > >
> > > > > > + *(u64 *)(r10 - 8) =3D r8; \
> > > > > > + *(u64 *)(r0 + 0) =3D r1; \
> > > > > > + r8 =3D *(u64 *)(r10 - 8); \
> > > > > > + r0 =3D *(u64 *)(r8 + 0); \
> > > > > >
> > > > > > The write through r0 must re-mark the stack, but the verifier d=
oesn't
> > > > > > know it's pointing to the stack.
> > > > > > push_stack was the conceptually cleaner/simpler fix, but it app=
arently
> > > > > > isn't good enough.
> > > > > >
> > > > > > Remarking the stack on write to PTR_TO_MEM, or invalidating PTR=
_TO_MEM
> > > > > > when r8 is spilled to fp-8 first time after the call are two op=
tions.
> > > > > > Both have some concerns (first, the misaligned stack access is =
not
> > > > > > caught, second PTR_TO_MEM may outlive stack frame).
> > > > >
> > > > > Reading the description of the problem my first instinct was to h=
ave
> > > > > stack slots with associated obj_ref_id for such cases and when
> > > > > something writes into that stack slot, invalidate everything with=
 that
> > > > > obj_ref_id. So that's probably what you mean by invalidating
> > > > > PTR_TO_MEM, right?
> > > > >
> > > > > Not sure I understand what "PTR_TO_STACK with mem_size" (that Ale=
xei
> > > > > mentioned in another email) means, though, so hard to compare.
> > > > >
> > > >
> > > > Invalidation is certainly one option. The one Alexei mentioned was
> > > > where we discussed bounding how much data can be read through the
> > > > PTR_TO_STACK (similar to PTR_TO_MEM), and mark r0 as PTR_TO_STACK.
> > > > This ends up combining the constraints of both types of pointers (i=
t
> > > > may as well be called PTR_TO_STACK_OR_MEM) without forking paths.
> > >
> > > Yeah, PTR_TO_STACK_OR_MEM would be more precise. But how does that
> > > help with this problem? Not sure I follow the idea of the solution
> > > (but I can wait for patches to be posted).
> >
> > The reason for push_stack was to ensure writes through the returned
> > pointer take effect on stack state.
> > By keeping it PTR_TO_STACK, we get that behavior.
> > However, in the other path of this patch, the verifier would verify
> > the pointer as PTR_TO_MEM, with a bounded mem_size.
> > Thus it would not allow writing beyond a certain size.
> > If we simply set r0 to PTR_TO_STACK now, it would possibly allow going
> > beyond the size that was passed to kfunc.
> > E.g. say buffer was fp-24 and size was 8, we can also modify fp-8
> > through it and not just fp-16.
> > Adding an additional mem_size field and checking it (when set) for
> > PTR_TO_STACK allows us to ensure we cannot write beyond 8 bytes
> > through r0=3Dfp-24.
>
> yeah, this part is clear, of course, but I was actually more worried
> about handling the following situation:
>

For simplicity, let's just forget about stack_or_mem, and assume stack
pointer with this extra mem_size.
I haven't written the code yet but the idea would be to limit writing
to [fp-N, fp-N+mem_size) through it.
A screening check before we pass through to the normal stack access
handling code.

>
> struct bpf_dynptr dptr;
> void *slice;
> union {
>     char buf[32];
>     void *map_value;
> } blah;
>
> bpf_dynptr_from_skb(..., &dptr);

At this point we mark dptr.

>
> slice =3D bpf_dynptr_slice_rdwr(&dptr, 0, &blah.buf, sizeof(blah.buf));
> if (!slice) return 0; /* whatever */
>

slice is PTR_TO_STACK w/ mem_size =3D 32.

We mark the bytes for buf as STACK_MISC at this point.

> /* now slice points to blah.{buf,map_value}, right? */
>
> map_value =3D bpf_map_lookup_elem(&some_map, ...);
> if (!map_value) return 0;

The 8-byte slot for map_value in these 32-bytes becomes map_value.
Rest remains misc.

>
> /* we shouldn't allow working with slice at this point */
> *(u64 *)slice =3D 0xdeadbeef; /* overwrite map_value */

And because slice is PTR_TO_STACK, we will notice the overwrite of map
value with scalar.

>
> *(u64 *)map_value =3D 123; /* BOOM */
>

So this would fail as deref of scalar.

Let me know if I missed something you were trying to point out.

