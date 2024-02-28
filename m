Return-Path: <bpf+bounces-22843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3025586A858
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 07:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF0C1F25A42
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 06:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079382262B;
	Wed, 28 Feb 2024 06:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeTgemqW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB90125542
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709101861; cv=none; b=f5ecvBnCaDo5GTm+xRiRegcOwrclghi50LsSoWmgjeSU6WTR7n3lM+646MifXZuqAehFipb5px50En0t9xb/h+Drz2Arje6erhKT/q83ydIzYicbozGHFeLbhSGYpcLLFdc2bcY0ABmyZpPH8KdLjpzr5XVrxw9lqkJDmSr8U7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709101861; c=relaxed/simple;
	bh=hDimqeVAD8EwIL6zg7H7orV2o3/nP6hHo3srVQs8L60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxdFzJrryxp2koXJV1uPE4amuCVk4F0ZohUFbrOkk4SG+OqS0M5PY21EjKNF0gBv2fZt5ZvqRTidocSgUHnmV2cSSa3WJkVtm0V6wvUokt8CRPKVzV0rrCXEdqQ/7Iygp7oUvR2IJwubWfgoLiN+GlvRmtiUqR/IMJ2JGutFJTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeTgemqW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412b34fb36bso2528465e9.3
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 22:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709101858; x=1709706658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pW7gZblRxThMFEbJhGnk+I3aXHRbfZI2GR2qtUd+PcI=;
        b=PeTgemqW2A7we+9KKWFXJVk13KcrIibfQvuJUX5MvLbSe2dsxc3nIyd1iUMXH66ddq
         2i3zVIRh8fem/4lelhmdWqvwvy1CRxmLroM0ur/P2ieqymImCE1GwfelEEcUz5bpreS4
         ZCvx9k5z9CPLvgTRxQl1FSYI7IUkChEm9/+WizgP225G1FAn6em6LOmjviGDpKTiHkE8
         mUP1dmSlVL9mpBDj0AhJjFSN1JxetStG7iZFgeAUKNuu6AKI2SEm7TgBFmoOHbibO49t
         bB2gJE+5qS6W2jNeJcsbutlOaVvn4RD2Y9n3u9kFHw3iNMYGfMVo9Ke/OtNyucqQ1jQR
         Yxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709101858; x=1709706658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pW7gZblRxThMFEbJhGnk+I3aXHRbfZI2GR2qtUd+PcI=;
        b=SFLg4Nhegl5u3Pet2joDUdhsiuYTCc5jdO9CW9TNNhBYJ16CDwUfp38qEGYU0azC+/
         NnYUk5692NrNBbzdbMWAPWeBy0Y+Z6TH4lXORSE93lEdorZFNh0M47GbZ/SqDQy5OJLZ
         qHCNyv19WdfecSeeqZS9VV4HF797hygLm1jk+tSncozyiAZ6oI9SDBlVfRW8bLRDQe03
         69ND7ws1Uan5f/W5QQzS5pBZQV2h1gzX/vjIYVhwG0ZBq0kjEbSP78VKUk47m4eb6hkH
         F+s/0VYHdzQRLv5LmeqGzOmK2qRjLr1N4oNZ3TqPRv4FiA/s3DxKHUI0XqF7wi9c0n5U
         OFfw==
X-Gm-Message-State: AOJu0Yxmso9W70nCPUijYB1Ci9v7yrUUz+qN4Eubfs/Vcf797BqwIH5K
	Kpwy1V++W7QXFuniLF1IeDvCLUIBaI3Ur9IJTnkwnsS9z59b4F1oILmTuKZNssDiSH0eDE+LtV6
	JtYemoOOjoc5FLGhG7m85tEcM6XSjDVVjuwY=
X-Google-Smtp-Source: AGHT+IFqrwYzjXQqYsJ7HbVcPEoe0FT+IEFt9gEs6IsmqInVRVj9CJNGv8nW2uokeGRw/dvJKJxxiNdRw4OKov7kcKE=
X-Received: by 2002:a05:600c:4f95:b0:412:6dd3:e11f with SMTP id
 n21-20020a05600c4f9500b004126dd3e11fmr7875742wmq.5.1709101857799; Tue, 27 Feb
 2024 22:30:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222063324.46468-1-alexei.starovoitov@gmail.com>
 <53cc7e1fea7efb557cd4d65fdff5642c0047f255.camel@gmail.com>
 <CAADnVQLu0xzEuxfJ=6HU5yGv02Gf0Vud3X9LEOvK6AMzx3vAuQ@mail.gmail.com>
 <971cbc8e82a3bcf93e4f30d5368a293017f3fa83.camel@gmail.com> <CAADnVQJDuFn4R1TTsgcom5Dos7criW9ZD3qpAp4zga1m7tNHGg@mail.gmail.com>
In-Reply-To: <CAADnVQJDuFn4R1TTsgcom5Dos7criW9ZD3qpAp4zga1m7tNHGg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 27 Feb 2024 22:30:46 -0800
Message-ID: <CAADnVQLd7MaY4r8EauhnbKS6vxTRv97cXj7+jUtXwQxLdqNK-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Introduce bpf_can_loop() kfunc
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 5:55=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Feb 23, 2024 at 4:50=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Fri, 2024-02-23 at 16:22 -0800, Alexei Starovoitov wrote:
> > [...]
> >
> > > I think you're missing the point.
> > > It's not about this particular list iterator.
> > > It's about _all_ for(), while() loops.
> > > I've started converting lib/radix-tree.c to bpf and arena.
> > > There are hundreds of various loops that need to be converted.
> > > The best is to copy-paste them as-is and add bpf_can_loop() to loop
> > > condition. That's it.
> > > Otherwise explicit iterators are changing the code significantly
> > > and distract from the logic of the algorithm.
> > >
> > > Another key point is the last sentence of the commit log:
> > > "New instruction with the same semantics can be added, so that LLVM
> > > can generate it."
> > >
> > > This is the way to implement __builtin_memcpy, __builtin_strcmp
> > > and friends in llvm and gcc.
> >
> > There are two things that usage of bpf_can_loop() provides:
> > 1. A proof that BPF program would terminate at runtime.
> > 2. A way for verifier to terminate verification process
> >    (by stopping processing some path when two verifier states are exact=
ly equal).
> >
> > The (1) is iffy, because there are simple ways to forgo it in practical=
 terms.
> > E.g. for the program below it would be possible to make 64 * 10^12 iter=
ations
> > at runtime:
> >
> >     void bar(...) {
> >       while (... && bpf_can_loop())
> >         ... do something ...;
> >     }
> >
> >     void foo(...) {
> >       while (... && bpf_can_loop())
> >         bar();
> >     }
>
> so ?
> bpf_loop() helper and open coded iterators can do the same already.
> It's something we need to fix regardless.
>
> (1) is not iffy. The program will terminate. That's a 100% guarantee.
>
> > If we decide that for some programs it is not necessary to enforce
> > proof of runtime termination, then it would be possible to untie (2)
> > from iterators and just check if looping state is states_equal(... exac=
t=3Dtrue)
> > to some previous one.
>
> No. That's not at all the same.
> Looping and eventually exiting is a strong guarantee by
> the verifier and the users know that all paths to exit are explored.
> Just "looping is ok" without exit guarantee
> means that a bunch of code may not be visited by the verifier.
> Arguably dead code elimination should kick in,
> but I don't think it's a territory we can go to.
>
> >
> > [...]
> >
> > > > > @@ -7954,10 +7956,14 @@ static int process_iter_next_call(struct =
bpf_verifier_env *env, int insn_idx,
> > > > >       struct bpf_reg_state *cur_iter, *queued_iter;
> > > > >       int iter_frameno =3D meta->iter.frameno;
> > > > >       int iter_spi =3D meta->iter.spi;
> > > > > +     bool is_can_loop =3D is_can_loop_kfunc(meta);
> > > > >
> > > > >       BTF_TYPE_EMIT(struct bpf_iter);
> > > > >
> > > > > -     cur_iter =3D &env->cur_state->frame[iter_frameno]->stack[it=
er_spi].spilled_ptr;
> > > > > +     if (is_can_loop)
> > > > > +             cur_iter =3D &cur_st->can_loop_reg;
> > > > > +     else
> > > > > +             cur_iter =3D &cur_st->frame[iter_frameno]->stack[it=
er_spi].spilled_ptr;
> > > >
> > > > I think that adding of a utility function hiding this choice, e.g.:
> > > >
> > > >     get_iter_reg(struct bpf_verifier_state *st, int insn_idx)
> > > >
> > > > would simplify the code a bit, here and in is_state_visited().
> > >
> > > Hmm. That sounds like obfuscation, since 'meta' would need to be pass=
ed in,
> > > but is_state_visited() doesn't have meta.
> > > Create fake meta there?!
> > >
> > > I'm missing how such get_iter_reg() helper will look.
> > > meta->iter.frameno was populated by process_iter_arg().
> > > Far away from process_iter_next_call().
> >
> > I meant that this helper can peek spi from R1 just like code in
> > is_state_visited() does currently. Forgoing the 'meta' completely.
>
> I see.
> You mean removing:
>                 meta->iter.spi =3D spi;
>                 meta->iter.frameno =3D reg->frameno;
> from process_iter_arg() and
> 'meta' arg from process_iter_next_call() as well then ?

Ed,

That was a bad idea.
I tried what you suggested with
static struct bpf_reg_state *get_iter_reg(struct bpf_verifier_env *env,
                                          struct bpf_verifier_state
*st, int insn_idx)

and implemented in v2.
It's buggy as can be seen in CI (I sloppy tested it before sending it
yesterday).
I'm going to go back to v1 approach.
process_iter_next_call() _has_ to use meta,
since caller saved regs already cleared by the time it's called.
And doing fake 'meta' in is_state_visited() is not a good idea.
It took me a few hours to debug this :(

