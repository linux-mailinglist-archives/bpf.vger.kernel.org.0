Return-Path: <bpf+bounces-22631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9F8862154
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 01:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20521289935
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 00:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899C74416;
	Sat, 24 Feb 2024 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMNcV9nZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD72138A
	for <bpf@vger.kernel.org>; Sat, 24 Feb 2024 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708735832; cv=none; b=FN8oU6mQIFgctS+BF6f+HiirsdhCUrOKDwmnnMysCYIHUhaP+PHg2730bLPTmK8TWdu+BcLAHDtgsuYrvlxTindNsn9/33Sy0uD8ms4/PE8chOsIiKQilmuWGHeFPEqzYSF8wYb9nJ/74zqIMJ/+6gzUPl6BzbmN1aUBMaPDqto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708735832; c=relaxed/simple;
	bh=GiYfR5V/2XLdiTpXuuCiTMLF5MsL0b2afhkqEzL/8fc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=seOQUeo8LzJFlIFRhoqSQBYdlgx9Lxu4OJ8VtTWsJiJJCowFjp441Q5hYrJdiNxkv+VbUOud61k+aR4RES/ahPe+3L2r3UUT2+4Db5BIRlg37owxdzlFK5aLUZS6+61fE/+zxl7K/MNFEyICYHUTt5/wzJf7csCTpcCLrnTxWI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMNcV9nZ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512bb2ed1f7so1215046e87.3
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 16:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708735828; x=1709340628; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aWTuercRF+glWSDJkUg/afzkByWPz6tPGd90SU6g9ZQ=;
        b=bMNcV9nZs9x7YlysLQvSc6PScEkG1lTQ8yrlQJMNywmfY6mjeyWDFWgkxO2mYXtKjQ
         GazqFyJ4eB5qczDdV5FzbzdkmWTS8eKIoSeNpvckaqKO0qakJUnd+AMZBaFIxd5fzIHv
         nFys+22fIxgf1LyB3bpWJ4RuFlb/XOZetCHyT9WN42CB14LS6ZwxAUtn+4B215hp6Rdv
         udd0dYrgkKosmVG1f7r/41PRlBC040s9RJtPMrbW4pNh4Ki49rnT5L+FhzEzkxQS/b7E
         ITKHIYeYRFjkhZbbUp+qVhunGmFpd0zFbU7BaieW1YlNJtHAUFk76bDRvu1ZXRdMdVPv
         4kyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708735828; x=1709340628;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWTuercRF+glWSDJkUg/afzkByWPz6tPGd90SU6g9ZQ=;
        b=FshY2ykJ6wR4kyqWTncjNwKY0giFqTCCft3x1sV6GXdrpOJrw/12F9DKjq8ASBSOHw
         Fx0VwWHikezNuCrUpy+SMiRZZSCioerwnbjymcHMgR7m5Ef2RKmncLhI90UNQxiDrSsW
         BQt1h3hrikEjNusdy4z8Ab4OW2HViBKCkjsMr7cRilCoMwZ59JGGRe2gO7bGIjba75wT
         nceIOSsl5dFQ32K3usQy72ow+8s2/t8ZUUK6VCS+i5T6X+xhk7wQFcWMhPBM5neHt2Dr
         gqI8Mf9qJnUDfiwBdngGxrN+vWP/73nHjQy/2RqGVX0hN8DVFKP1XFMQ/9zNSWHSeXWH
         OTYA==
X-Gm-Message-State: AOJu0YyWakTCln43/iyy7V1Smgflp/zeffLlHYj1sRnjZ6WyJI5aivUc
	jlvJKFP0tp3SIhajG5okx9b6DBo2Ohv/XJm1W7gfi4jmdgsCAPoOn1ArrJDZt7s=
X-Google-Smtp-Source: AGHT+IG+pjFzMMhktdUXik9wxRRiplbs1JhXhnKEcA51KUq5gNcyMF09W1MdUXD/X9uvAYS7RF4qTw==
X-Received: by 2002:a05:6512:3da9:b0:511:5f38:76e with SMTP id k41-20020a0565123da900b005115f38076emr1090780lfv.1.1708735828126;
        Fri, 23 Feb 2024 16:50:28 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id n17-20020a170906b31100b00a3fbe13e2aasm90765ejz.83.2024.02.23.16.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 16:50:27 -0800 (PST)
Message-ID: <971cbc8e82a3bcf93e4f30d5368a293017f3fa83.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Introduce bpf_can_loop() kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel
 Team <kernel-team@fb.com>
Date: Sat, 24 Feb 2024 02:50:26 +0200
In-Reply-To: <CAADnVQLu0xzEuxfJ=6HU5yGv02Gf0Vud3X9LEOvK6AMzx3vAuQ@mail.gmail.com>
References: <20240222063324.46468-1-alexei.starovoitov@gmail.com>
	 <53cc7e1fea7efb557cd4d65fdff5642c0047f255.camel@gmail.com>
	 <CAADnVQLu0xzEuxfJ=6HU5yGv02Gf0Vud3X9LEOvK6AMzx3vAuQ@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-23 at 16:22 -0800, Alexei Starovoitov wrote:
[...]

> I think you're missing the point.
> It's not about this particular list iterator.
> It's about _all_ for(), while() loops.
> I've started converting lib/radix-tree.c to bpf and arena.
> There are hundreds of various loops that need to be converted.
> The best is to copy-paste them as-is and add bpf_can_loop() to loop
> condition. That's it.
> Otherwise explicit iterators are changing the code significantly
> and distract from the logic of the algorithm.
>=20
> Another key point is the last sentence of the commit log:
> "New instruction with the same semantics can be added, so that LLVM
> can generate it."
>=20
> This is the way to implement __builtin_memcpy, __builtin_strcmp
> and friends in llvm and gcc.

There are two things that usage of bpf_can_loop() provides:
1. A proof that BPF program would terminate at runtime.
2. A way for verifier to terminate verification process
   (by stopping processing some path when two verifier states are exactly e=
qual).

The (1) is iffy, because there are simple ways to forgo it in practical ter=
ms.
E.g. for the program below it would be possible to make 64 * 10^12 iteratio=
ns
at runtime:

    void bar(...) {
      while (... && bpf_can_loop())
        ... do something ...;
    }

    void foo(...) {
      while (... && bpf_can_loop())
        bar();
    }

If we decide that for some programs it is not necessary to enforce
proof of runtime termination, then it would be possible to untie (2)
from iterators and just check if looping state is states_equal(... exact=3D=
true)
to some previous one.

[...]

> > > @@ -7954,10 +7956,14 @@ static int process_iter_next_call(struct bpf_=
verifier_env *env, int insn_idx,
> > >       struct bpf_reg_state *cur_iter, *queued_iter;
> > >       int iter_frameno =3D meta->iter.frameno;
> > >       int iter_spi =3D meta->iter.spi;
> > > +     bool is_can_loop =3D is_can_loop_kfunc(meta);
> > >=20
> > >       BTF_TYPE_EMIT(struct bpf_iter);
> > >=20
> > > -     cur_iter =3D &env->cur_state->frame[iter_frameno]->stack[iter_s=
pi].spilled_ptr;
> > > +     if (is_can_loop)
> > > +             cur_iter =3D &cur_st->can_loop_reg;
> > > +     else
> > > +             cur_iter =3D &cur_st->frame[iter_frameno]->stack[iter_s=
pi].spilled_ptr;
> >=20
> > I think that adding of a utility function hiding this choice, e.g.:
> >=20
> >     get_iter_reg(struct bpf_verifier_state *st, int insn_idx)
> >=20
> > would simplify the code a bit, here and in is_state_visited().
>=20
> Hmm. That sounds like obfuscation, since 'meta' would need to be passed i=
n,
> but is_state_visited() doesn't have meta.
> Create fake meta there?!
>=20
> I'm missing how such get_iter_reg() helper will look.
> meta->iter.frameno was populated by process_iter_arg().
> Far away from process_iter_next_call().

I meant that this helper can peek spi from R1 just like code in
is_state_visited() does currently. Forgoing the 'meta' completely.

[...]

