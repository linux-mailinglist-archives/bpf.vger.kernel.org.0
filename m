Return-Path: <bpf+bounces-22632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C13862219
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 02:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D47CB2378E
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 01:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67443D51C;
	Sat, 24 Feb 2024 01:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pu7QOG7O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE55BA2D
	for <bpf@vger.kernel.org>; Sat, 24 Feb 2024 01:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708739761; cv=none; b=NduhXXcE3Sh8MUvbekJI1xCr21BXQugPFmHdCd/aGnpWvw7Mdvvqcx+HVNCwc4B73VLm1EgEB9P7s+aP232ptc9OUpeUXO6kwDqdSCyb7C4pSUQiB7jmKajUzIBxiNzw+zmV4iE9Un82Q/Lssn/aLaN5OYKvnwO4tIUdvXobb40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708739761; c=relaxed/simple;
	bh=bwr969+4vdabN+HFHL+nxp3P2tUYxhyjbGtQ5+docL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lcyl9LluHK3ps1B56RPv2wG0Hf95eCpLP9retXxkxQzIQocc7FGcCyHkyRAgKoi4CJKYlkBI5YSHphrXWRhGCQtL3uHwkSHoPaELz7o/t+txc3FLR22/RJiFSAk5q3DfoShMSo3JTphuC2pCBz53cOwr9oTXDiWFH+czZj5SAkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pu7QOG7O; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d36736d4eso688846f8f.1
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 17:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708739757; x=1709344557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crOfXaH2zR7owaVzgcl+Vk/sTjvL/AX+QbFny75yV0U=;
        b=Pu7QOG7O3+8luaQrqIohcs5Tnfm3cf+mwisNR4R7reZXyorcwvWXpwou2//H++afRo
         D+wBadXSlnoM6eDFB0iXUNPmdALIhnB8rNzyBAsupu+DZGNqt4vAxWqw7kDFRu8Nc2Pz
         mSGMVH+fdr5zLolDpetFKm6Xg6fuofI3blSYUoDssBu290/p9dXYxXYhtVJH9T2vVVQJ
         fVDdnAZhYIohqh6NQI9Ni8ja8h1NCz/GPFhy24goAU75hO+Zk/pLoFbV9CXlcM6IeIVQ
         YCMcgLcsaAEpsJB4iXppNYeXLPXpbs12f/YgMxQvzCVXO5p+OwZrVU7IGLMNplROSJDC
         5QrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708739757; x=1709344557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crOfXaH2zR7owaVzgcl+Vk/sTjvL/AX+QbFny75yV0U=;
        b=LUSMbT0g/AvSVAuVMVTrZ1n7amiM+gYZyLuw/jwdSvehOvKYNfl/cc3mGzxtJfuZIL
         7jCv9Pcby5Law67GfArNtw1dbCmsUucuG10kpUWdCIgDIZqRFWgmN/+W24uX1VWm4eGv
         hsosORe1SImQNsFXlReni7pVFDgZnaHYzCga1GGZdc8Ypy8ey3oqLEiThcqYVbaA8PZ+
         hfmoueOCj0X0Y10Hlyt9TRoFsJ5hci9LBvu3u6qXGZUHmkZqq8aCkKNnmVl3LSRiyfjz
         SA5Gpz3CIYjtqisJIcNg+GngUO9oP9fnOqk/GlHp9CLrf/MMeyumDD02tWRFsAOL6KmY
         CRBQ==
X-Gm-Message-State: AOJu0YwWU0mUrvPMYxNoqrJE/ilclSFRE3BbvP1nv82ZKCGgJgUgm4pE
	5IimUXb4XKye4/UXIj6VOPG8NoruRTd584I8sy5OHBgi7LVy5ba+0AlidbQOElhfQWFZHFEROoz
	zycTmnfI4HySkMoCxJnKTXIg8Fn0=
X-Google-Smtp-Source: AGHT+IGELgaYHYTI+UKKv6riHydESUgf8VYicPvD7q2sez5eQsTEn3reagldv8Qv7oWrE4ivrBZ/vsCLvI+YZB6Ch1s=
X-Received: by 2002:a05:6000:24a:b0:33d:9eef:4f25 with SMTP id
 m10-20020a056000024a00b0033d9eef4f25mr790442wrz.51.1708739757261; Fri, 23 Feb
 2024 17:55:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222063324.46468-1-alexei.starovoitov@gmail.com>
 <53cc7e1fea7efb557cd4d65fdff5642c0047f255.camel@gmail.com>
 <CAADnVQLu0xzEuxfJ=6HU5yGv02Gf0Vud3X9LEOvK6AMzx3vAuQ@mail.gmail.com> <971cbc8e82a3bcf93e4f30d5368a293017f3fa83.camel@gmail.com>
In-Reply-To: <971cbc8e82a3bcf93e4f30d5368a293017f3fa83.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Feb 2024 17:55:45 -0800
Message-ID: <CAADnVQJDuFn4R1TTsgcom5Dos7criW9ZD3qpAp4zga1m7tNHGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Introduce bpf_can_loop() kfunc
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 4:50=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2024-02-23 at 16:22 -0800, Alexei Starovoitov wrote:
> [...]
>
> > I think you're missing the point.
> > It's not about this particular list iterator.
> > It's about _all_ for(), while() loops.
> > I've started converting lib/radix-tree.c to bpf and arena.
> > There are hundreds of various loops that need to be converted.
> > The best is to copy-paste them as-is and add bpf_can_loop() to loop
> > condition. That's it.
> > Otherwise explicit iterators are changing the code significantly
> > and distract from the logic of the algorithm.
> >
> > Another key point is the last sentence of the commit log:
> > "New instruction with the same semantics can be added, so that LLVM
> > can generate it."
> >
> > This is the way to implement __builtin_memcpy, __builtin_strcmp
> > and friends in llvm and gcc.
>
> There are two things that usage of bpf_can_loop() provides:
> 1. A proof that BPF program would terminate at runtime.
> 2. A way for verifier to terminate verification process
>    (by stopping processing some path when two verifier states are exactly=
 equal).
>
> The (1) is iffy, because there are simple ways to forgo it in practical t=
erms.
> E.g. for the program below it would be possible to make 64 * 10^12 iterat=
ions
> at runtime:
>
>     void bar(...) {
>       while (... && bpf_can_loop())
>         ... do something ...;
>     }
>
>     void foo(...) {
>       while (... && bpf_can_loop())
>         bar();
>     }

so ?
bpf_loop() helper and open coded iterators can do the same already.
It's something we need to fix regardless.

(1) is not iffy. The program will terminate. That's a 100% guarantee.

> If we decide that for some programs it is not necessary to enforce
> proof of runtime termination, then it would be possible to untie (2)
> from iterators and just check if looping state is states_equal(... exact=
=3Dtrue)
> to some previous one.

No. That's not at all the same.
Looping and eventually exiting is a strong guarantee by
the verifier and the users know that all paths to exit are explored.
Just "looping is ok" without exit guarantee
means that a bunch of code may not be visited by the verifier.
Arguably dead code elimination should kick in,
but I don't think it's a territory we can go to.

>
> [...]
>
> > > > @@ -7954,10 +7956,14 @@ static int process_iter_next_call(struct bp=
f_verifier_env *env, int insn_idx,
> > > >       struct bpf_reg_state *cur_iter, *queued_iter;
> > > >       int iter_frameno =3D meta->iter.frameno;
> > > >       int iter_spi =3D meta->iter.spi;
> > > > +     bool is_can_loop =3D is_can_loop_kfunc(meta);
> > > >
> > > >       BTF_TYPE_EMIT(struct bpf_iter);
> > > >
> > > > -     cur_iter =3D &env->cur_state->frame[iter_frameno]->stack[iter=
_spi].spilled_ptr;
> > > > +     if (is_can_loop)
> > > > +             cur_iter =3D &cur_st->can_loop_reg;
> > > > +     else
> > > > +             cur_iter =3D &cur_st->frame[iter_frameno]->stack[iter=
_spi].spilled_ptr;
> > >
> > > I think that adding of a utility function hiding this choice, e.g.:
> > >
> > >     get_iter_reg(struct bpf_verifier_state *st, int insn_idx)
> > >
> > > would simplify the code a bit, here and in is_state_visited().
> >
> > Hmm. That sounds like obfuscation, since 'meta' would need to be passed=
 in,
> > but is_state_visited() doesn't have meta.
> > Create fake meta there?!
> >
> > I'm missing how such get_iter_reg() helper will look.
> > meta->iter.frameno was populated by process_iter_arg().
> > Far away from process_iter_next_call().
>
> I meant that this helper can peek spi from R1 just like code in
> is_state_visited() does currently. Forgoing the 'meta' completely.

I see.
You mean removing:
                meta->iter.spi =3D spi;
                meta->iter.frameno =3D reg->frameno;
from process_iter_arg() and
'meta' arg from process_iter_next_call() as well then ?

