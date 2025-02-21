Return-Path: <bpf+bounces-52121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28F4A3E92D
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 01:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C68E42336E
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 00:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1748C6136;
	Fri, 21 Feb 2025 00:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUYyQnrP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47AA2AE69
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 00:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740098259; cv=none; b=UirF7wtcytKwUwpUtCZuiKiVBVZU3VBXumyp2U42c7TNkRDfL0kYdoHCJ5qEG3sKqVtWbaHENwcoLJWsI6NFEG1Yrqte1eapxhQWr2L2jrZsz8KC0k6ygE9Q9dyTMKbZfPvQ22sFQN+0GzeikJPFBxCUsP3t0k9k4w8TTHJEp9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740098259; c=relaxed/simple;
	bh=FaVNtZrnIS4USkc7RR4pZdU7F+BU1jWiv6ca/kvqeBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFuLRD/INhxlrGs1yqSAQNn1OEqzBSD+OfIY9Gc1RMSdYniQ1uvuGko5BmTgofdfZ0IJqkZeg/TZ/t9VW888sTbJ2JzrSKikMCLv2UBRU93eBEEVy00HUJB+QLNy3UkUrzw/tGLVE39npp61oUEeKxUWRDbbhEHi+NO/8K1WiUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUYyQnrP; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so318430466b.3
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 16:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740098256; x=1740703056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQlxSTRPYXEpf16bnFGhwwqkS7lDQSzSPQpTGKsgFYg=;
        b=KUYyQnrPJ/KIgaGuUWC8zvhtD55HLIvQpfP2j4W3djaElx9GPNheK6DOBb/QcE5jaR
         p4q7fNGJbBKkzF2a/MzJbClFEiFnEBdAjJ1MCzBiSwq/xzAcsl+1zlGhOiBtwiGoE/ez
         5ANZbs5MZCnR9RRscTQ9rGT7XZA1dPdRTpAnTfUX3XWLqY/jjukd312EL7uW6nTwWKtn
         uKxVwmk/uofYfSxjrf7YSJ+siiIqQJZMLoBkV7ohuYwA9PoszkWer76g0Jn413PfBmxQ
         zVWdpTgmKXyFfkqD4NZ/Zv9GplpKBcAF58Dn+7LBFjbtCgLDqnJCC7r5DqZuOy67ifTG
         bnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740098256; x=1740703056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQlxSTRPYXEpf16bnFGhwwqkS7lDQSzSPQpTGKsgFYg=;
        b=UqiX3EsBazv0FYhQRUsiVuu1cLi3zmPxVhlqYpc2cL5dp/zQeK8eFaQNUc5Ku0bsp2
         lsQnQdvAcZLgu0lIxcmVbX/e0Bov0kl1lOdtdUsSLuiNtuYg8XItym+aEPiHB2WXBlI3
         UZwzbq+cu7fxIXi0OaCmwjrm3/QSdfOex/NEPG07Fhq2WcvskVaAIcN66VQPUpVlKhmY
         xyuJKzvZzI88gjRy+m9SfwNjXeOavXHi8O8fyq2hDtHTwHSDd5r2MTd97NLTZcUsM7nH
         kPjnh4juDXG0WXIByZ4mKz574olG8tAcw42ienjL4GFoMRLXIVq0bxSW63trI19VmrcV
         wJ5A==
X-Forwarded-Encrypted: i=1; AJvYcCUcbJ96qLUdal6K/91AFyvYU208EdZQtQMacdO0mZwDyoa8VSOpYBO0mzUnIH+pwNq+whc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYjduWTpoTlwoUhZT/+unqbrQBKSxUf5Efks16xwna+IUGkpP0
	c+RooT3Y2SzuZz46oFu7F9FalUBy/AIn/h/16eR8yttyocnBDT5JV7I6nkvMINhdtvpwAWIK36L
	g1p9eOxv10q6WIZ6lGkjC2Iil18w=
X-Gm-Gg: ASbGnctsZPGGax7jIKWyLtSzA3o/IpOQ0Pl0TO55gFYsq9ib0mDdRT9WsmcWM9kQZhe
	M6L2Vthdf2nHlHQ+3eF3Ww3K//7Y0C54XtQspHyovYJhf1DWdYpC1EGgo0dOKI8MAIeMWqNePov
	qg2pUDWYorcJfsEynlvA==
X-Google-Smtp-Source: AGHT+IEW7ipWsGH1lTm25R55MqPx1boWjckwilJ102ztC5jqg5+qWxj2tVvamC0IkSlBzKHFqcWh462Eb8D3LDa62aU=
X-Received: by 2002:a17:906:7956:b0:ab2:b84b:2dab with SMTP id
 a640c23a62f3a-abc09ab8f13mr135313766b.30.1740098255914; Thu, 20 Feb 2025
 16:37:35 -0800 (PST)
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
 <CAP01T76=Twha0twPgzO8Un6--e3cX1PMFEtu1jHVS_7iQzOcfQ@mail.gmail.com> <CAEf4Bzbny7VFufpMq6RZJ1_poYsAFw89tpmKHhMSbTNb2=PsBg@mail.gmail.com>
In-Reply-To: <CAEf4Bzbny7VFufpMq6RZJ1_poYsAFw89tpmKHhMSbTNb2=PsBg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 21 Feb 2025 01:36:59 +0100
X-Gm-Features: AWEUYZnxkwdTJQ8DBNRFuzKke7aOpcA2mUfFMbA5b0NhIvpv36PjyBv2veSypDg
Message-ID: <CAP01T77PkyNSweQ8SAoaxc7zO8eL66UX0HgjwAX7Q9rqatCgKw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 1/2] bpf: Explore PTR_TO_STACK as R0 for bpf_dynptr_slice_rdwr
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2025 at 01:27, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Thu, Feb 20, 2025 at 7:41=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Thu, 20 Feb 2025 at 01:13, Andrii Nakryiko <andrii.nakryiko@gmail.co=
m> wrote:
> > >
> > > On Wed, Feb 19, 2025 at 10:10=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > On Wed, 19 Feb 2025 at 18:41, Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Wed, Feb 19, 2025 at 4:51=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > > > <memxor@gmail.com> wrote:
> > > > > >
> > > > > > For the bpf_dynptr_slice_rdwr kfunc, the verifier may return a =
pointer
> > > > > > to the underlying packet (if the requested slice is linear), or=
 copy out
> > > > > > the data to the buffer passed into the kfunc. The verifier perf=
orms
> > > > > > symbolic execution assuming the returned value is a PTR_TO_MEM =
of a
> > > > > > certain size (passed into the kfunc), and ensures reads and wri=
tes are
> > > > > > within bounds.
> > > > >
> > > > > sounds like
> > > > > check_kfunc_mem_size_reg() -> check_mem_size_reg() ->
> > > > > check_helper_mem_access()
> > > > >    case PTR_TO_STACK:
> > > > >       check_stack_range_initialized()
> > > > >          clobber =3D true
> > > > >              if (clobber) {
> > > > >                   __mark_reg_unknown(env, &state->stack[spi].spil=
led_ptr);
> > > > >
> > > > > is somehow broken?
> > > > >
> > > > > ohh. It might be:
> > > > > || !is_kfunc_arg_optional(meta->btf, buff_arg)
> > > > >
> > > > > This bit is wrong then.
> > > > > When arg is not-null check_kfunc_mem_size_reg() should be called.
> > > > > The PTR_TO_STACK abuse is a small subset of issues
> > > > > if check_kfunc_mem_size_reg() is indeed not called.
> > > >
> > > > The condition looks ok to me.
> > > >
> > > > The condition to do check_mem_size_reg is !null || !opt.
> > > > So when it's null, and it's opt, it will be skipped.
> > > > When it's null, and it's not opt, the check will happen.
> > > > When arg is not-null, the said function is called, opt does not mat=
ter then.
> > > > So the stack slots are marked misc.
> > > >
> > > > In our case we're not passing a NULL pointer in the selftest.
> > > >
> > > > The problem occurs once we spill to that slot _after_ the call, and
> > > > then do a write through returned mem pointer.
> > > >
> > > > The final few lines from the selftest do the dirty thing, where r0 =
is
> > > > aliasing fp-8, and r1 =3D 0.
> > > >
> > > > + *(u64 *)(r10 - 8) =3D r8; \
> > > > + *(u64 *)(r0 + 0) =3D r1; \
> > > > + r8 =3D *(u64 *)(r10 - 8); \
> > > > + r0 =3D *(u64 *)(r8 + 0); \
> > > >
> > > > The write through r0 must re-mark the stack, but the verifier doesn=
't
> > > > know it's pointing to the stack.
> > > > push_stack was the conceptually cleaner/simpler fix, but it apparen=
tly
> > > > isn't good enough.
> > > >
> > > > Remarking the stack on write to PTR_TO_MEM, or invalidating PTR_TO_=
MEM
> > > > when r8 is spilled to fp-8 first time after the call are two option=
s.
> > > > Both have some concerns (first, the misaligned stack access is not
> > > > caught, second PTR_TO_MEM may outlive stack frame).
> > >
> > > Reading the description of the problem my first instinct was to have
> > > stack slots with associated obj_ref_id for such cases and when
> > > something writes into that stack slot, invalidate everything with tha=
t
> > > obj_ref_id. So that's probably what you mean by invalidating
> > > PTR_TO_MEM, right?
> > >
> > > Not sure I understand what "PTR_TO_STACK with mem_size" (that Alexei
> > > mentioned in another email) means, though, so hard to compare.
> > >
> >
> > Invalidation is certainly one option. The one Alexei mentioned was
> > where we discussed bounding how much data can be read through the
> > PTR_TO_STACK (similar to PTR_TO_MEM), and mark r0 as PTR_TO_STACK.
> > This ends up combining the constraints of both types of pointers (it
> > may as well be called PTR_TO_STACK_OR_MEM) without forking paths.
>
> Yeah, PTR_TO_STACK_OR_MEM would be more precise. But how does that
> help with this problem? Not sure I follow the idea of the solution
> (but I can wait for patches to be posted).

The reason for push_stack was to ensure writes through the returned
pointer take effect on stack state.
By keeping it PTR_TO_STACK, we get that behavior.
However, in the other path of this patch, the verifier would verify
the pointer as PTR_TO_MEM, with a bounded mem_size.
Thus it would not allow writing beyond a certain size.
If we simply set r0 to PTR_TO_STACK now, it would possibly allow going
beyond the size that was passed to kfunc.
E.g. say buffer was fp-24 and size was 8, we can also modify fp-8
through it and not just fp-16.
Adding an additional mem_size field and checking it (when set) for
PTR_TO_STACK allows us to ensure we cannot write beyond 8 bytes
through r0=3Dfp-24.

I hope this is clearer.

>
> >
> [...]

