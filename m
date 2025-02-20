Return-Path: <bpf+bounces-52087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E743A3DEFA
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 16:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1931787B5
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 15:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7688F1FF7C3;
	Thu, 20 Feb 2025 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYALEC2U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A3D1FF60B
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066106; cv=none; b=QSSwTE1cw+R07X1ooal/+t9f2eLR8ThHHpqw117CuuSBTVSp1kWuF++Cvdu4z5l9ZN1z411VJhyuW+SEjROMT42GcaFSZiUQGV4MCADQODkPk+ZSipvdIoR3Gw9RY5ewf0eVegUJbevGM8JXMN0VdV4TxwKx0ucJUbTkgcwzhbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066106; c=relaxed/simple;
	bh=pYcLfVu/UCqz+KGXFtbs11BVnvg4z0hyUsoJ2Fo+POQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlypWupUXaaQmAwcw9MVtuFXgzCWLlDkU1NSjUV13JXtzsU5YKV/ozSEYWzSdUaqOcnYxbyrs7GlLGhRH0pVYjU/T6u4L98aOVrYkmK6MSsEKnHAhLfNQU7Co1Wb86nlOkrt6yzZaAqbn3nZaWFOUrhhs0TG1vYkTymtN0itsao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYALEC2U; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5deb1266031so1997897a12.2
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 07:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740066102; x=1740670902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDZr8AzR5HhKcEw/bFEg9Q1KbyxC4pmXvV8J/N+NLYA=;
        b=jYALEC2U0pmwzzvjpUz+ldmGpnbWkn9ZKPQ11F28He8oRQ4cEugVo2Mbagpo9xTqtU
         plhhD2p8BjqgvxVLfi7EcLLY0amOH5T78cZQSHjOvEjr2/vmtQxi8X/QoHPAx0QWeeAv
         3vXB96ZGZnTFOWY5ipZZH+U8e18ONIBu//5roHB0W4J+0c30M50P+8NwfDSRHk2uOBOx
         uBWlYoyvD6VOfCwSK3TTBBT6vJhw3d5O004DNLC9rgozf+qjxF4qmquDNxmeOzXnu+LQ
         CJ1x0T19WnSYZGbM6O7FVZX+CPB5TqoHAGmtzCR/D4VKxMO7tlG1MapezhRebXHESDT9
         Pk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066102; x=1740670902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDZr8AzR5HhKcEw/bFEg9Q1KbyxC4pmXvV8J/N+NLYA=;
        b=i0PYWhDqHBD6AZjBndOTUP2zOr9J+vDZ13+birzBL6B1oj/20pYyW9kFQyXX0qay8a
         eqIWLUckWV3dPr1Yd/6i8FRkfBJLcmbv5Vxxp7QFgHsfLkrhvVYPsNYAv2VD7MWGevNv
         WKiAlMBh0DblFTyrY0ArubTNcrooGksscCgwD3re7lCO75hQuXII7pUps29AWRsAXJUb
         1T13dxQ0Jr7MoHZbruAYavlOGswJxi17je8SVwW/Bzl/l9D81KiB3Zkt8kZrmu/aBTln
         7Y5uDZ2Ps0XMMhcehF44ic9pUG9IelB+PjcF0x4a+HRJk/qX4mPwjEx2fy2aDJXzOIV3
         4HUg==
X-Forwarded-Encrypted: i=1; AJvYcCV4xhorLZSB4aEoHC7qEBLB1ll6kA/LhFCltQ0ZrkkSo5UbdQBbsOky7SuQhEDUl2KLnBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtconEplmkaBjiDB9ehzPK7D182V579GrBBnYwvERa1PDjBo8x
	LLrYOhvU+GAuSU+E7YlnvfkZ57a9TT5F3iqJx9nHvndZqZ9UXleZ85E2yDAFVRmnaZ51qELd+kx
	jnzQR4pWGmpg6V85mc+8GmmklWso=
X-Gm-Gg: ASbGncuf6RqC/rlk2ERwlFCFitiIvtHy2VzgV71SdhDbyBZEbiffBgh1KNgvIbo7FzH
	yB3ddhvdQBdki3Q4rynN+29rIQXGdB5NPnHMfwJmUoPVd5FjKDoSngkj1zROUlwNjupK9cuk1Id
	i4lKHPUk8qoavc6iQAoQ==
X-Google-Smtp-Source: AGHT+IFX5ulOdX7BIjSDF9X3y/wDO4XDdOccGvDs++349FDe6gqwXqhL5o9hiyRHSky2mhS6YBBtWa5wWTpQ3U/d/eE=
X-Received: by 2002:a05:6402:3550:b0:5e0:9607:2669 with SMTP id
 4fb4d7f45d1cf-5e096072ccamr6392957a12.17.1740066102204; Thu, 20 Feb 2025
 07:41:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219125117.1956939-1-memxor@gmail.com> <20250219125117.1956939-2-memxor@gmail.com>
 <CAADnVQ+TBG+yAxtY1Q5D6HnhbvgusUVrzyRm7-8oF7wYw+Nqfw@mail.gmail.com>
 <CAP01T74tZudfS8huoz=sP4UkEgs5ipkz9Qjf=6XNVzJvGOFLgQ@mail.gmail.com> <CAEf4BzbyF3aWdE0Uk0KtdeYwmEYSahfpZk=vK-JhhZ-Bgb55ZQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbyF3aWdE0Uk0KtdeYwmEYSahfpZk=vK-JhhZ-Bgb55ZQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 20 Feb 2025 16:41:04 +0100
X-Gm-Features: AWEUYZl7TOe9zWCLXLQ4psC_D0EOg0JWmQu8ISMLo6yHEH3EKA3IXWBuo8Y3UTI
Message-ID: <CAP01T76=Twha0twPgzO8Un6--e3cX1PMFEtu1jHVS_7iQzOcfQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 1/2] bpf: Explore PTR_TO_STACK as R0 for bpf_dynptr_slice_rdwr
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Feb 2025 at 01:13, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Wed, Feb 19, 2025 at 10:10=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Wed, 19 Feb 2025 at 18:41, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Feb 19, 2025 at 4:51=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > For the bpf_dynptr_slice_rdwr kfunc, the verifier may return a poin=
ter
> > > > to the underlying packet (if the requested slice is linear), or cop=
y out
> > > > the data to the buffer passed into the kfunc. The verifier performs
> > > > symbolic execution assuming the returned value is a PTR_TO_MEM of a
> > > > certain size (passed into the kfunc), and ensures reads and writes =
are
> > > > within bounds.
> > >
> > > sounds like
> > > check_kfunc_mem_size_reg() -> check_mem_size_reg() ->
> > > check_helper_mem_access()
> > >    case PTR_TO_STACK:
> > >       check_stack_range_initialized()
> > >          clobber =3D true
> > >              if (clobber) {
> > >                   __mark_reg_unknown(env, &state->stack[spi].spilled_=
ptr);
> > >
> > > is somehow broken?
> > >
> > > ohh. It might be:
> > > || !is_kfunc_arg_optional(meta->btf, buff_arg)
> > >
> > > This bit is wrong then.
> > > When arg is not-null check_kfunc_mem_size_reg() should be called.
> > > The PTR_TO_STACK abuse is a small subset of issues
> > > if check_kfunc_mem_size_reg() is indeed not called.
> >
> > The condition looks ok to me.
> >
> > The condition to do check_mem_size_reg is !null || !opt.
> > So when it's null, and it's opt, it will be skipped.
> > When it's null, and it's not opt, the check will happen.
> > When arg is not-null, the said function is called, opt does not matter =
then.
> > So the stack slots are marked misc.
> >
> > In our case we're not passing a NULL pointer in the selftest.
> >
> > The problem occurs once we spill to that slot _after_ the call, and
> > then do a write through returned mem pointer.
> >
> > The final few lines from the selftest do the dirty thing, where r0 is
> > aliasing fp-8, and r1 =3D 0.
> >
> > + *(u64 *)(r10 - 8) =3D r8; \
> > + *(u64 *)(r0 + 0) =3D r1; \
> > + r8 =3D *(u64 *)(r10 - 8); \
> > + r0 =3D *(u64 *)(r8 + 0); \
> >
> > The write through r0 must re-mark the stack, but the verifier doesn't
> > know it's pointing to the stack.
> > push_stack was the conceptually cleaner/simpler fix, but it apparently
> > isn't good enough.
> >
> > Remarking the stack on write to PTR_TO_MEM, or invalidating PTR_TO_MEM
> > when r8 is spilled to fp-8 first time after the call are two options.
> > Both have some concerns (first, the misaligned stack access is not
> > caught, second PTR_TO_MEM may outlive stack frame).
>
> Reading the description of the problem my first instinct was to have
> stack slots with associated obj_ref_id for such cases and when
> something writes into that stack slot, invalidate everything with that
> obj_ref_id. So that's probably what you mean by invalidating
> PTR_TO_MEM, right?
>
> Not sure I understand what "PTR_TO_STACK with mem_size" (that Alexei
> mentioned in another email) means, though, so hard to compare.
>

Invalidation is certainly one option. The one Alexei mentioned was
where we discussed bounding how much data can be read through the
PTR_TO_STACK (similar to PTR_TO_MEM), and mark r0 as PTR_TO_STACK.
This ends up combining the constraints of both types of pointers (it
may as well be called PTR_TO_STACK_OR_MEM) without forking paths.

The benefit over the push_stack approach is that we avoid the states
regression for cls_redirect and balancer_ingress.
For the selftest failure, I plan to just silence the error by changing it.

> >
> > I don't recall if there was a hardware/JIT specific reason to care
> > about stack access alignment or not (on some architectures), but
> > otherwise we can over approximately mark at 8-byte granularity for any
> > slot(s) that overlap with the buffer to cover such a case. The second
> > problem is slightly trickier, which makes me lean towards invalidating
> > returned PTR_TO_MEM when stack slot is overwritten or frame is
> > destroyed.

