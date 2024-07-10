Return-Path: <bpf+bounces-34362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8808A92CB29
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 08:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F711C224B1
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 06:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4333D78281;
	Wed, 10 Jul 2024 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMJqMfU8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D956F30D
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593368; cv=none; b=M00wGyPcoA6OW/QBspJhtSYurLW7aqkPXMnLLT/bKNDqXb75yfTbw4UZuuIClk2twFe3M9mlMTumQmnHgkNjKoBXcx2+XIFqJ3EXpiZ7YAwegFEQiWVsDQaWdqXkbUjBozcXS3IcfUkuPCfMchhM2u1KNaqmtXzgnlhEu+OblHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593368; c=relaxed/simple;
	bh=ZUwd4OWJbOmQEkz3ra2LaJOwPOpF0VCaI/IKUuENNTI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S2Z/0yL7BGfFw5/JwREEztbiZGiZEuVA2CK7je0z26eYHckb3ON6/Hk6zx6nclzxZOm0mYyaZ0ANYMPGdYGKctnQ6sAIKJZ1zSH7o9V9oaelcsV6O4m7iHPGc5rhTxiXKs1Hq77ZNxZtxwgNjXPfj41priaM92mMVPRmBLRUxXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMJqMfU8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fa55dbf2e7so30727265ad.2
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 23:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720593367; x=1721198167; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lYBpTiCCaH1nWrjVDuT8YmcnqA35MSfQ3e1tdmwsVuE=;
        b=SMJqMfU8h4YYWZj/beEU+XpI1I9uQHPf38P9ayjsFqmNbiKnGSImcDdQ+yNuY3NEK4
         YCMmVHdhtz+fpQ+Pf4sX9qQyjMi+Xk7bS7wDGAkLfsYXFiX7Jv3tfOzz7FTntw6YIPS4
         RWQkrrGxua0XPYVhBPLjwFM22AqcNgxYcJMCsg+XXJI3D4MjPFc5ex7gMVn4tf88/WY+
         OYeH6biGudgiu2t/5bfYukOPfi94b3Ig6Yu/n3QoIV1wpS+7JAJNXWpfUZIFR2fsi1mU
         Fs6c0vuODnBnch5wv7iuFT/5rrk0Ho9762eK79wM0Rrp4OactURINBTGRVLOyvmrUA/1
         z0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720593367; x=1721198167;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lYBpTiCCaH1nWrjVDuT8YmcnqA35MSfQ3e1tdmwsVuE=;
        b=owXBL/jIJFz0irfSXBkIjmWdEBhQLBMPJ2LnJNowAIbhMlFHuGJxtRDd61UXFYkUCW
         e2FSyP0SV8vgL2cqYyJDFNlVKB4iqbj3+WiqJNe5Imfn9yN4GA1I8yPDzkCPObFSAikd
         Nat8Kwme4YCqKAvqj1XRTgy1ykPb4/ZL8iL8rC6c3hbsMRuVV/nUuLrVymaXA5Yb3k7w
         w2bSGPwt8z1wIPqZxfjQG5PJBjnmSKqpoEqpt3kcKq9ulUujH0zt1WIngsKPyUK4b8i3
         du9KO8dayYfTYQeR1x/av/dAaSK6pUYYRKVMOaeArbjqBZ4HjM1lp3d9Dit+ziWOHccP
         Ut5w==
X-Gm-Message-State: AOJu0YyMopfhH0XCLY2/o0BmuHyR2QPVU/JMcafU6BRtopHE50tec5yv
	xH6prlDbdAYtopM8kOZvKJ/eK3C9dqO3fYcLIvNpfL9Fe9BmuvYi
X-Google-Smtp-Source: AGHT+IFpam7xHB/JHVT/IacisW0JFxfZp3ehCmfvl10vc4mFNx2S6F+bCVU35HGtKy55s7SeM3LZrg==
X-Received: by 2002:a17:903:1252:b0:1f9:a8ce:3375 with SMTP id d9443c01a7336-1fbb6ea4187mr37827745ad.50.1720593366624;
        Tue, 09 Jul 2024 23:36:06 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab75ffsm26255035ad.175.2024.07.09.23.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:36:06 -0700 (PDT)
Message-ID: <61b1630295c8df2f78ffabfc1768c521b69a705f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: track find_equal_scalars history
 on per-instruction level
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  sunhao.th@gmail.com
Date: Tue, 09 Jul 2024 23:36:00 -0700
In-Reply-To: <CAEf4BzbnduEs50kcFbN=jR1otTBtbqxrQrtRHo8iF4b=j_onUw@mail.gmail.com>
References: <20240705205851.2635794-1-eddyz87@gmail.com>
	 <20240705205851.2635794-2-eddyz87@gmail.com>
	 <CAEf4Bzbq8Lg+n1K=V0RjgKh7+PFU5rrwFPP2s0Z+g_nLbUpcPA@mail.gmail.com>
	 <e1551a1e473d0497275f74a005e47841f058cf7b.camel@gmail.com>
	 <CAEf4BzbnduEs50kcFbN=jR1otTBtbqxrQrtRHo8iF4b=j_onUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-09 at 22:28 -0700, Andrii Nakryiko wrote:

[...]

> > > >   r2 =3D r10             |
> > > >   r2 +=3D r0             v mark_chain_precision(r0)
> > > >=20
> > > >             while doing mark_chain_precision(r0)
> > > >   r1 =3D r0              ^
> > > >   if r1 < 8  goto ...  | mark r0,r1 as precise
> > > >   if r0 > 16 goto ...  | mark r0,r1 as precise
> > > >   r2 =3D r10             |
> > > >   r2 +=3D r0             | mark r0 precise
> > >=20
> > > let's reverse the order here so it's linear in how the algorithm
> > > actually works (backwards)?
> >=20
> > I thought the arrow would be enough. Ok, can reverse.
>=20
> it's the reverse order compared to what you'd see in the verifier log.
> I did see the arrow (though it wasn't all that clear on the first
> reading), but still feels like it would be better to have consistent
> order with verifier log

Ok, no problem

>=20
> [...]
>=20
> > > > @@ -3844,6 +3974,7 @@ static int backtrack_insn(struct bpf_verifier=
_env *env, int idx, int subseq_idx,
> > > >                          */
> > > >                         bt_set_reg(bt, dreg);
> > > >                         bt_set_reg(bt, sreg);
> > > > +               } else if (BPF_SRC(insn->code) =3D=3D BPF_K) {
> > > >                          /* else dreg <cond> K
> > >=20
> > > drop "else" from the comment then? I like this change.
> >=20
> > This is actually a leftover from v1. I can drop "else" from the
> > comment or drop this hunk as it is not necessary for the series.
>=20
> I'd keep explicit `else if`

Ok, will do

[...]

> > > > @@ -15312,6 +15500,21 @@ static int check_cond_jmp_op(struct bpf_ve=
rifier_env *env,
> > > >                 return 0;
> > > >         }
> > > >=20
> > > > +       /* Push scalar registers sharing same ID to jump history,
> > > > +        * do this before creating 'other_branch', so that both
> > > > +        * 'this_branch' and 'other_branch' share this history
> > > > +        * if parent state is created.
> > > > +        */
> > > > +       if (BPF_SRC(insn->code) =3D=3D BPF_X && src_reg->type =3D=
=3D SCALAR_VALUE && src_reg->id)
> > > > +               find_equal_scalars(this_branch, src_reg->id, &linke=
d_regs);
> > > > +       if (dst_reg->type =3D=3D SCALAR_VALUE && dst_reg->id)
> > > > +               find_equal_scalars(this_branch, dst_reg->id, &linke=
d_regs);
> > > > +       if (linked_regs.cnt > 1) {
> > >=20
> > > if we have just one, should it be even marked as linked?
> >=20
> > Sorry, I don't understand. Do you suggest to add an additional check
> > in find_equal_scalars/collect_linked_regs and reset it if 'cnt' equals =
1?
>=20
> I find `if (linked_regs.cnt > 1)` check a bit weird and it feels like
> it should be unnecessary. As soon as we are left with just one
> "linked" register (linked with what? with itself?) it shouldn't be
> linked anymore. Is there a point where we break the link between
> registers where we can/should drop ID from the singularly linked
> register? Why keep that scalar register ID set?

I can push this check inside find_equal_scalars/collect_linked_regs, e.g.:

collect_linked_regs(... linked_regs ...)
{
	...
	if (linked_regs.cnt =3D=3D 1)
		linked_regs.cnt =3D 0;
	...
}

But then this particular place would have to be modified as follows:

	if (linked_regs.cnt > 0) {
		err =3D push_jmp_history(env, this_branch, 0, linked_regs_pack(&linked_re=
gs));
		if (err)
			return err;
	}

Or something similar has to be done inside push_jmp_history().

[...]

