Return-Path: <bpf+bounces-52010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 014A5A3CE03
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 01:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C085B1898071
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 00:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB0A257D;
	Thu, 20 Feb 2025 00:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5Nbs7yZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D29635
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 00:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740010387; cv=none; b=A1r0A2tOFMtRQdae3UhjlfOwXtCKYD591tplDTSwXzZKBrRgmTVIXJ+iuO3l3FgXzvZ6V+aHJa+IG8RN2HrjvhuaeeB/149qSVy7CLOv7xSNjOSv7YFTxDaBu6USzLQB3F/sgwHckCRgLGU0T6nhTbBOdQtIKcJ5G3h5J/LTucM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740010387; c=relaxed/simple;
	bh=hxMgYtMOZvBbp3ehF1uZi3vSQPptrh7ijXvXde7ZR4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZyX3xMlnIn3GyZuzT4MFcnS4FpHtPB6BgF/3Tx9sS150a0y8Eyf8a449quTngsUei6gPsqz3mX1dNzASdgclKNe5dgSLH8WmjlDBJ+ylWdrcCGQTXUSUE3sGgjahmvBTdPrwuDSsicYHbqmjnawMzUxMvP9MFYYi+lEEiutne4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5Nbs7yZ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fbf5c2f72dso590108a91.1
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 16:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740010385; x=1740615185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAjDFbqjH3I72q32ke/XvkeB+bDWUKwLi/wDsrgT/Tw=;
        b=V5Nbs7yZa1YROhr5+skNHEp0bRf+AktqsnCzYbNil59N3NxHCDrNo2KgbUboWinYBO
         pWS/RV5VwR1gFLr8eO4Gp8h1IlY5k0uV/b2Zx4V9UtvuioJJBqsAKMktxs4cpeFzDO8d
         +UlrB+L1zgsvt14x46AEVloc7PgwS/HQAQSRxVbNTnKPE6CPgoHI5+vhoYCKHfWcdkDt
         cSmrL6ASI7HkvTJSockLFxmTOH+mFmSajfYJHsloXv9xzbr2pdd1YuBCgeYy+YzZIhHj
         kh/7+Nd8naXPUk/iA/18E/sIwutOnYA4aCCR6nlI4wyFP5ShKFjeh1fEIrA5SadE/uks
         LfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740010385; x=1740615185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAjDFbqjH3I72q32ke/XvkeB+bDWUKwLi/wDsrgT/Tw=;
        b=j5V2ckfKsB44nDkrP/J+6ymH9gL8EX12mZ+B5kAwKF4dnhiJkxLhxtrpLcNGBUQpNm
         cHXytjxRNPo2zcC2n8yhGQWMjipYkahGTUFLX8EXR/d+W2z4A3/zB2wi0IYHnAyPfjM0
         XXtYmFUYcNB1oilK5JwWGVhAC82zxqTmtWqBmHrVlzGb540yPW2g1Bg4Xrjcjaa8iIfE
         qH+hXEF+6Jwm0rNG0L0XTdAoRjYEy7jhXAXeYwS1dYgsSKvq5A9pmUWdq7G0FD2OuNSI
         3/2L9zPvyILgzSZRQpzYSm8XtS+lhhx62hms0jdohQ3yOBDy80sc/90hSMPEMupSEwcK
         gKnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeftiH77WJPG/gCUpstTmX1b6aPiC7dgGKKpY9q8b9mOBGaHxlUhbsumatvdP82zZnwZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk4AwS83J5J2JkQ22wsr1EwB4ZRe/eMgAnQAJ9bV53Vfo1juxT
	m71rM+jETX/juF5RMqn9KUm9BiC0LPk4LzZsPuJJJKD8Q8a4UkB/XuNlCnp4Z3jo+6ZbVKEG7GC
	dt2lWMPrFR429kb0f5j763u0hcLUr5g==
X-Gm-Gg: ASbGnctBZCu/Bs6O6IDm/xcobLwQeETQmNLLPB+qYH8rc8UAjQDPuR51+LLepKlL94v
	DOqiqaLHEy7qjfCmiotN08nHLVH0yiMmYOY3AJFxEyDiAZZHMG+aAlstsv/GL+FWnF1DnWLVBKE
	oFi2OaqLRg+Snm
X-Google-Smtp-Source: AGHT+IGqCj8Q7o+5s4UB3O2RoT2AD3st0RjvRm9AaoDH5/vrpQDeaWQPsCxVigVFTEju5HwI7bNAdozr04xRM5E1Ly0=
X-Received: by 2002:a17:90b:2788:b0:2fa:228d:5b03 with SMTP id
 98e67ed59e1d1-2fcb5a344c1mr8403623a91.19.1740010384950; Wed, 19 Feb 2025
 16:13:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219125117.1956939-1-memxor@gmail.com> <20250219125117.1956939-2-memxor@gmail.com>
 <CAADnVQ+TBG+yAxtY1Q5D6HnhbvgusUVrzyRm7-8oF7wYw+Nqfw@mail.gmail.com> <CAP01T74tZudfS8huoz=sP4UkEgs5ipkz9Qjf=6XNVzJvGOFLgQ@mail.gmail.com>
In-Reply-To: <CAP01T74tZudfS8huoz=sP4UkEgs5ipkz9Qjf=6XNVzJvGOFLgQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 19 Feb 2025 16:12:53 -0800
X-Gm-Features: AWEUYZnsakgT1hZZ2E6DEBQP0cImdiNPvKva_lfUdxIeUEPHpJE8EzBOYnbnmyY
Message-ID: <CAEf4BzbyF3aWdE0Uk0KtdeYwmEYSahfpZk=vK-JhhZ-Bgb55ZQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 1/2] bpf: Explore PTR_TO_STACK as R0 for bpf_dynptr_slice_rdwr
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 10:10=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, 19 Feb 2025 at 18:41, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Feb 19, 2025 at 4:51=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > For the bpf_dynptr_slice_rdwr kfunc, the verifier may return a pointe=
r
> > > to the underlying packet (if the requested slice is linear), or copy =
out
> > > the data to the buffer passed into the kfunc. The verifier performs
> > > symbolic execution assuming the returned value is a PTR_TO_MEM of a
> > > certain size (passed into the kfunc), and ensures reads and writes ar=
e
> > > within bounds.
> >
> > sounds like
> > check_kfunc_mem_size_reg() -> check_mem_size_reg() ->
> > check_helper_mem_access()
> >    case PTR_TO_STACK:
> >       check_stack_range_initialized()
> >          clobber =3D true
> >              if (clobber) {
> >                   __mark_reg_unknown(env, &state->stack[spi].spilled_pt=
r);
> >
> > is somehow broken?
> >
> > ohh. It might be:
> > || !is_kfunc_arg_optional(meta->btf, buff_arg)
> >
> > This bit is wrong then.
> > When arg is not-null check_kfunc_mem_size_reg() should be called.
> > The PTR_TO_STACK abuse is a small subset of issues
> > if check_kfunc_mem_size_reg() is indeed not called.
>
> The condition looks ok to me.
>
> The condition to do check_mem_size_reg is !null || !opt.
> So when it's null, and it's opt, it will be skipped.
> When it's null, and it's not opt, the check will happen.
> When arg is not-null, the said function is called, opt does not matter th=
en.
> So the stack slots are marked misc.
>
> In our case we're not passing a NULL pointer in the selftest.
>
> The problem occurs once we spill to that slot _after_ the call, and
> then do a write through returned mem pointer.
>
> The final few lines from the selftest do the dirty thing, where r0 is
> aliasing fp-8, and r1 =3D 0.
>
> + *(u64 *)(r10 - 8) =3D r8; \
> + *(u64 *)(r0 + 0) =3D r1; \
> + r8 =3D *(u64 *)(r10 - 8); \
> + r0 =3D *(u64 *)(r8 + 0); \
>
> The write through r0 must re-mark the stack, but the verifier doesn't
> know it's pointing to the stack.
> push_stack was the conceptually cleaner/simpler fix, but it apparently
> isn't good enough.
>
> Remarking the stack on write to PTR_TO_MEM, or invalidating PTR_TO_MEM
> when r8 is spilled to fp-8 first time after the call are two options.
> Both have some concerns (first, the misaligned stack access is not
> caught, second PTR_TO_MEM may outlive stack frame).

Reading the description of the problem my first instinct was to have
stack slots with associated obj_ref_id for such cases and when
something writes into that stack slot, invalidate everything with that
obj_ref_id. So that's probably what you mean by invalidating
PTR_TO_MEM, right?

Not sure I understand what "PTR_TO_STACK with mem_size" (that Alexei
mentioned in another email) means, though, so hard to compare.

>
> I don't recall if there was a hardware/JIT specific reason to care
> about stack access alignment or not (on some architectures), but
> otherwise we can over approximately mark at 8-byte granularity for any
> slot(s) that overlap with the buffer to cover such a case. The second
> problem is slightly trickier, which makes me lean towards invalidating
> returned PTR_TO_MEM when stack slot is overwritten or frame is
> destroyed.

