Return-Path: <bpf+bounces-34402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667AD92D4E0
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 17:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1748F285C0B
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 15:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124D6194143;
	Wed, 10 Jul 2024 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZZNuTFT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F42A1C9
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720624936; cv=none; b=uljIbtppzcdpRb8wR12IM8VLXQLXfereudw+fhsnLYTkVabIUetmzIRrHhr1mIyTkoLJorzrR+1YQxHlA5hlgIlIlz3vbftY6MJxMEBT2WcYeHVVBhTrbO0CtQrPosUC8zqFWYov0goDZR4GqT2s1OZ/HHiZxBDqF8hVbs/9MXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720624936; c=relaxed/simple;
	bh=j9luzw9/8Rl4lsHsYPJhBwQqbYJQqbnadMw0kYYCTxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGczZEunuULvTCTqpCiofA7iVXI/eklKbdfgSYfU6f3HO6IVecjdPUU79rXYaITwaaXcecgHE3nDIkq4pRqEMcTj1qKhFCD/Hyt7sltb7P1wa+drMj5Xaqg3undF41ZHRLpEP72pMbeSkIBKfWsjD3jrxkV3/YreY0CSoFo0Dnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZZNuTFT; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso7282262a12.3
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 08:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720624933; x=1721229733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2YpKYvcg7pdFmTbNLMAVeFG1wNwh1GswPuKzDjvVHY=;
        b=LZZNuTFTGkgNJMjY1LXORUaGon9mrd9ZgqReRgV99FPulIyYdH5tw0Ndrvq5UcJaA9
         ULBdceElFRwrEKdqKWpsSfuBm+c/PV/KvLHADn8Qo7HgNo3upNnV54dc/yUEidkooewE
         yq0vCQLiVALHh8UaheGW+bGEQKAakI/nXg+wCj1OnRpcwAokDYRbabJuRnDSAlmmHVKB
         43XAwYBScach95K87UdY15PkNTwtl+J/eUkDStNoWG3hsvjub2hF1WKVBGdVOuWg3jM4
         uAbY+pjsXrBYzr6t2NZa0VRKRKzWYziy7xAN5e/2obWx/qI9nDfevMDtntJnbrwzUi41
         2qKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720624933; x=1721229733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2YpKYvcg7pdFmTbNLMAVeFG1wNwh1GswPuKzDjvVHY=;
        b=WRKt9yWSNeNmbIACcvotv05h0f2BWV90vVUZaoNsBXgHmHFjk+0P1YzlBWByoSCLeH
         ZkPUYWTNGM7uxUAUzqQUQQt+HWnqedM2LjXoRvnpRZBpwTwiP4pdT086rwQULXN1KetC
         eER9AK7p3UXdGmqWV4FtmK7N0Y2eXJt9EEBvlG41RiQ9FlAJDeRpUI+V+iwq2WWE0HVE
         NJpva4cWujHO4somXQ0UyhinGAV8HzOcmYftudxFMCOQ9HGMF+Aq0kvRoMC02Jnt3GuB
         p6HOkO0wwIJGR6aElY3rizIddDBylL25PMQPHZGXLiZiplzciiJ8ynLBaxTj52t+qXg6
         t2Zg==
X-Gm-Message-State: AOJu0YwUHR+cgxMtq3zG/XffObBD7/v4m9zPbngoOw9FbTkU/r6hmYhI
	7XZDjPBKPLHZ1JicF/2B1FV2JHgYvhO4d2hMGotEtHvKLjQ9vf1mAPQj6TT8E35I8JPGA2++quv
	VIOxzt8u126YxH7FukQYP9iXSVbA=
X-Google-Smtp-Source: AGHT+IGZjh2rL2x3pPsdhqT2d9dmN5Z99HLEz3LCxSX0ihhbdDn0pjW01qXNjtvYa6eLly8mPHnzWn7/SOk/twHkWAM=
X-Received: by 2002:a17:907:da7:b0:a72:50f7:3c6f with SMTP id
 a640c23a62f3a-a780b688751mr457701066b.14.1720624932897; Wed, 10 Jul 2024
 08:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705205851.2635794-1-eddyz87@gmail.com> <20240705205851.2635794-2-eddyz87@gmail.com>
 <CAEf4Bzbq8Lg+n1K=V0RjgKh7+PFU5rrwFPP2s0Z+g_nLbUpcPA@mail.gmail.com>
 <e1551a1e473d0497275f74a005e47841f058cf7b.camel@gmail.com>
 <CAEf4BzbnduEs50kcFbN=jR1otTBtbqxrQrtRHo8iF4b=j_onUw@mail.gmail.com> <61b1630295c8df2f78ffabfc1768c521b69a705f.camel@gmail.com>
In-Reply-To: <61b1630295c8df2f78ffabfc1768c521b69a705f.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jul 2024 08:21:56 -0700
Message-ID: <CAEf4BzaCrTzXqVo60LdbqPOQEaDXyETgezbJ6nGN5py4TAShzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: track find_equal_scalars history on
 per-instruction level
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 11:36=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-07-09 at 22:28 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > > >   r2 =3D r10             |
> > > > >   r2 +=3D r0             v mark_chain_precision(r0)
> > > > >
> > > > >             while doing mark_chain_precision(r0)
> > > > >   r1 =3D r0              ^
> > > > >   if r1 < 8  goto ...  | mark r0,r1 as precise
> > > > >   if r0 > 16 goto ...  | mark r0,r1 as precise
> > > > >   r2 =3D r10             |
> > > > >   r2 +=3D r0             | mark r0 precise
> > > >
> > > > let's reverse the order here so it's linear in how the algorithm
> > > > actually works (backwards)?
> > >
> > > I thought the arrow would be enough. Ok, can reverse.
> >
> > it's the reverse order compared to what you'd see in the verifier log.
> > I did see the arrow (though it wasn't all that clear on the first
> > reading), but still feels like it would be better to have consistent
> > order with verifier log
>
> Ok, no problem
>
> >
> > [...]
> >
> > > > > @@ -3844,6 +3974,7 @@ static int backtrack_insn(struct bpf_verifi=
er_env *env, int idx, int subseq_idx,
> > > > >                          */
> > > > >                         bt_set_reg(bt, dreg);
> > > > >                         bt_set_reg(bt, sreg);
> > > > > +               } else if (BPF_SRC(insn->code) =3D=3D BPF_K) {
> > > > >                          /* else dreg <cond> K
> > > >
> > > > drop "else" from the comment then? I like this change.
> > >
> > > This is actually a leftover from v1. I can drop "else" from the
> > > comment or drop this hunk as it is not necessary for the series.
> >
> > I'd keep explicit `else if`
>
> Ok, will do
>
> [...]
>
> > > > > @@ -15312,6 +15500,21 @@ static int check_cond_jmp_op(struct bpf_=
verifier_env *env,
> > > > >                 return 0;
> > > > >         }
> > > > >
> > > > > +       /* Push scalar registers sharing same ID to jump history,
> > > > > +        * do this before creating 'other_branch', so that both
> > > > > +        * 'this_branch' and 'other_branch' share this history
> > > > > +        * if parent state is created.
> > > > > +        */
> > > > > +       if (BPF_SRC(insn->code) =3D=3D BPF_X && src_reg->type =3D=
=3D SCALAR_VALUE && src_reg->id)
> > > > > +               find_equal_scalars(this_branch, src_reg->id, &lin=
ked_regs);
> > > > > +       if (dst_reg->type =3D=3D SCALAR_VALUE && dst_reg->id)
> > > > > +               find_equal_scalars(this_branch, dst_reg->id, &lin=
ked_regs);
> > > > > +       if (linked_regs.cnt > 1) {
> > > >
> > > > if we have just one, should it be even marked as linked?
> > >
> > > Sorry, I don't understand. Do you suggest to add an additional check
> > > in find_equal_scalars/collect_linked_regs and reset it if 'cnt' equal=
s 1?
> >
> > I find `if (linked_regs.cnt > 1)` check a bit weird and it feels like
> > it should be unnecessary. As soon as we are left with just one
> > "linked" register (linked with what? with itself?) it shouldn't be
> > linked anymore. Is there a point where we break the link between
> > registers where we can/should drop ID from the singularly linked
> > register? Why keep that scalar register ID set?
>
> I can push this check inside find_equal_scalars/collect_linked_regs, e.g.=
:
>
> collect_linked_regs(... linked_regs ...)
> {
>         ...
>         if (linked_regs.cnt =3D=3D 1)
>                 linked_regs.cnt =3D 0;

I mean, fine, that's ok. But you are missing the point I'm making. I'm
saying there is somewhere in the verifier (and I'm too lazy/don't care
to go find where) where we break linked registers link (we reset ID on
one of them, probably). What I am asking is whether we should have a
check there to also reset ID on the last remaining
"kind-of-linked-but-not-really-anymore" register.


Anyways, this doesn't have to be solved right away, so let's do this
fixup you are proposing here and keep clean "linked_regs.cnt > 0"
check below.

>         ...
> }
>
> But then this particular place would have to be modified as follows:
>
>         if (linked_regs.cnt > 0) {

yes, this makes total sense ("are there any linked regs? if not, there
is nothing to push to history")

>                 err =3D push_jmp_history(env, this_branch, 0, linked_regs=
_pack(&linked_regs));
>                 if (err)
>                         return err;
>         }
>
> Or something similar has to be done inside push_jmp_history().

no need to push this inside push_jmp_history(), why paying the price
of linked_regs_pack() unnecessarily?

>
> [...]

