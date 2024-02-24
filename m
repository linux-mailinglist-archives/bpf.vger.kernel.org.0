Return-Path: <bpf+bounces-22630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FB1862126
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 01:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768D31F275A5
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 00:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3B7645;
	Sat, 24 Feb 2024 00:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLK36lUV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FC119A
	for <bpf@vger.kernel.org>; Sat, 24 Feb 2024 00:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708734146; cv=none; b=qzpRY24PoBR9fTLRUh7X+dK9UJvO2n0afsyjumXFPah9er/tqCuEQO7h8o4H9jsDVyw9wZSyr5CR1V4WpyUQD3sGUxlRWNwr0WVawKgibZtUJfpsFwhWY9BdpbmNS8vmvl0SuKnR8150j+qIguYRaWyCqjZVjpc1D5pTFtJ5q0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708734146; c=relaxed/simple;
	bh=nMHBy8ga4+/WodLGj9e3u0GQU22EQ/olql9+AgZWjLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpdt2E/RjX81JSsdVNMAhTpY/C1ZqO78Xowt1QK2jTDGylwdO4LYufpiUWJoRyL9sPq7ErIQrDSRpFs2rDiyfbHefgidpnPovo5QHdB1L/pIcuB+LRho0laZp9aVeAC6pUSa2PBXOXSKtjxm3XxF7XNTgaS8VQqUWXMOhbX+ZIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLK36lUV; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3392b045e0aso1014222f8f.2
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 16:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708734142; x=1709338942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Wk+K+aq+7rcL1c5bYQ8yUZSgrHZN8c3lepvSqm0WVQ=;
        b=WLK36lUV7crg7Xe1V8LzaO2MpoOR+Q3MezGNNyPOedGr+I03/ejAAi+6e8fc8ReqPm
         NB1FuKMibMLw0LOg2kjNGBIrDDAPuryWxxVaAI1/G59IyqhGYC5PkUVMklvfk/DZMTh/
         BtnyJCvDR2XZNEXZm6kA15Unr1ZcY8NjgtTojk9rh7biOdDKyghbePJgPs1THRYFkfss
         ovFATdZf52Fg0wFgv4cAT3gTnGiY4DhmhkOFLd5J7KvfhBBm1mwyNX8ejNYsBzrHzw3A
         NJNLHAtUK2leeQti/lWWm10tqK8siecBURB3nfftJ79OI1nEhK+LtDDiZz4mL5nsKz0z
         9eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708734142; x=1709338942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Wk+K+aq+7rcL1c5bYQ8yUZSgrHZN8c3lepvSqm0WVQ=;
        b=I/IhscregmsVfPjaAoz4KN5lh8ABsknVU5Gic17FRDIdQVCmhAStJfzb6lJqUkRfaO
         4zDazSclrF/bQ4HZEfUIGtcJgM3Qc2kKZXFGgkaMqlUCcAchs0b1Yf4zvRBzLfCRVWMB
         ZS8wgfAag4zNzDlL08vfx5oiqKqujhDGJEw5M+QFAFPhww73cuL3G0YEuPgXlu7jkexz
         Q21jzTNJ2lxFkUB/RwrR9JesKMt5uK5QvUIS8PSq1cAqH9Ebn23GPjzM80EnKaTOWEuV
         TMfydNBjpTxsskAAZFPs2vtt+8NvZen17MD0LrBdI12q7U4Wd49an7v9lr84stPzt4UM
         tUtA==
X-Gm-Message-State: AOJu0Yyhd4KzJhHG45Xfmvj2QmbIJoB2Z+Np4H9CZgzan3zRAmN3sBoG
	ZjZrF0XRPpX+omKOblM/mC30K1tXVl/BbWfCM0KjLehzXjU0JY8hvYUqaGZxkpk9OFBGTh/hUTA
	EI6D8ImB+k8cMy5W6CTpJ27WTZ2k=
X-Google-Smtp-Source: AGHT+IFEgnFY2VWenr4wJAxVJLUcBg1rd9KWU6yTD0XCytKNXAE8rqz6FUTxDpx3mWUfFsKg9y3IQzbQM5asVY8qRA8=
X-Received: by 2002:adf:fd8e:0:b0:33d:7606:808b with SMTP id
 d14-20020adffd8e000000b0033d7606808bmr804254wrr.68.1708734142483; Fri, 23 Feb
 2024 16:22:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222063324.46468-1-alexei.starovoitov@gmail.com> <53cc7e1fea7efb557cd4d65fdff5642c0047f255.camel@gmail.com>
In-Reply-To: <53cc7e1fea7efb557cd4d65fdff5642c0047f255.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Feb 2024 16:22:11 -0800
Message-ID: <CAADnVQLu0xzEuxfJ=6HU5yGv02Gf0Vud3X9LEOvK6AMzx3vAuQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Introduce bpf_can_loop() kfunc
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 4:00=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2024-02-21 at 22:33 -0800, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > While working on bpf_arena the following monster macro had to be
> > used to iterate a link list:
> >         for (struct bpf_iter_num ___it __attribute__((aligned(8),      =
                 \
> >                                                       cleanup(bpf_iter_=
num_destroy))),  \
> >                         * ___tmp =3D (                                 =
                   \
> >                                 bpf_iter_num_new(&___it, 0, (1000000)),=
                 \
> >                                 pos =3D list_entry_safe((head)->first, =
                   \
> >                                                       typeof(*(pos)), m=
ember),          \
> >                                 (void)bpf_iter_num_destroy, (void *)0);=
                 \
> >              bpf_iter_num_next(&___it) && pos &&                       =
                 \
> >                 ({ ___tmp =3D (void *)pos->member.next; 1; });         =
                   \
> >              pos =3D list_entry_safe((void __arena *)___tmp, typeof(*(p=
os)), member))
> >
> > It's similar to bpf_for(), bpf_repeat() macros.
> > Unfortunately every "for" in normal C code needs an equivalent monster =
macro.
>
> Tbh, I really don't like the idea of adding more hacks for loop handling.
> This would be the fourth: regular bounded loops, bpf_loop, iterators
> and now bpf_can_loop. Imo, it would be better to:
> - either create a reusable "semi-monster" macro e.g. "__with_bound(iter_n=
ame)"
>   that would hide "struct bpf_iter_num iter_name ... cleanup ..." declara=
tion
>   to simplify definitions of other iterating macro;
> - or add kfuncs for list iterator.

I think you're missing the point.
It's not about this particular list iterator.
It's about _all_ for(), while() loops.
I've started converting lib/radix-tree.c to bpf and arena.
There are hundreds of various loops that need to be converted.
The best is to copy-paste them as-is and add bpf_can_loop() to loop
condition. That's it.
Otherwise explicit iterators are changing the code significantly
and distract from the logic of the algorithm.

Another key point is the last sentence of the commit log:
"New instruction with the same semantics can be added, so that LLVM
can generate it."

This is the way to implement __builtin_memcpy, __builtin_strcmp
and friends in llvm and gcc.

We can go a step further and add such insn to any for/while loop
that uses arena pointers.
Then running kernel code as bpf program will be copy-paste
and addition of __arena tag. Easy.

And if we can make:
#pragma clang attribute push (__attribute__((address_space(1))),
apply_to =3D pointers)

work, then we won't even need to copy paste!
We will be able to compile lib/radix-tree.c with --target=3Dbpf as-is.


> Having said that, I don't see any obvious technical issues with this part=
icular patch.
> A few nits below.
>
> [...]
>
> > @@ -7954,10 +7956,14 @@ static int process_iter_next_call(struct bpf_ve=
rifier_env *env, int insn_idx,
> >       struct bpf_reg_state *cur_iter, *queued_iter;
> >       int iter_frameno =3D meta->iter.frameno;
> >       int iter_spi =3D meta->iter.spi;
> > +     bool is_can_loop =3D is_can_loop_kfunc(meta);
> >
> >       BTF_TYPE_EMIT(struct bpf_iter);
> >
> > -     cur_iter =3D &env->cur_state->frame[iter_frameno]->stack[iter_spi=
].spilled_ptr;
> > +     if (is_can_loop)
> > +             cur_iter =3D &cur_st->can_loop_reg;
> > +     else
> > +             cur_iter =3D &cur_st->frame[iter_frameno]->stack[iter_spi=
].spilled_ptr;
>
> I think that adding of a utility function hiding this choice, e.g.:
>
>     get_iter_reg(struct bpf_verifier_state *st, int insn_idx)
>
> would simplify the code a bit, here and in is_state_visited().

Hmm. That sounds like obfuscation, since 'meta' would need to be passed in,
but is_state_visited() doesn't have meta.
Create fake meta there?!

I'm missing how such get_iter_reg() helper will look.
meta->iter.frameno was populated by process_iter_arg().
Far away from process_iter_next_call().

>
> [...]
>
> > @@ -19549,6 +19608,8 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
> >                       delta    +=3D cnt - 1;
> >                       env->prog =3D prog =3D new_prog;
> >                       insn      =3D new_prog->insnsi + i + delta;
> > +                     if (stack_extra)
> > +                             stack_depth_extra =3D max(stack_depth_ext=
ra, stack_extra);
>
> I don't think that using "max" here makes much sense.
> If several sorts of kfuncs would need extra stack space,
> most likely this space won't be shared,

I see. I was assuming that the space will be shared.
Like in the follow up I was planning to roll optimize_bpf_loop()
into this. And optimize_bpf_loop() will be sharing the scratch area.
But now, I'm not sure what I was thinking, since bpf_can_loop()
cannot share that space with optimize_bpf_loop().

> e.g. bpf_can_loop() would need
> it's 8 bytes + bpf_some_new_feature() would need 16 bytes on top of that =
etc.
> So some kind of flags indicating space for which features is reacquired i=
s needed here.

Yeah. It needs some way to indicate shared stack_extra vs exclusive.
Will fix in v2.

