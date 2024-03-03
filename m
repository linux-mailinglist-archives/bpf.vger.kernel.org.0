Return-Path: <bpf+bounces-23279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 262DB86F662
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 18:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF34281D7F
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 17:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22A57640A;
	Sun,  3 Mar 2024 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1+J5h/k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F4741A80
	for <bpf@vger.kernel.org>; Sun,  3 Mar 2024 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709486494; cv=none; b=mH7Gf/ggGaw+oxCXVfaNnFhiIJLy5KRILliJUtV4A6dIeNqLVfy4YGk7N/SGqJYJzt8QyuZMVRb2CxTjDyOOoUUnlcFVFJGwmfCmfM2o+NfRghZRwf30f5C1PYan3bgTUo0jAR+ZCyo7If0pSGKrMSzWqsh7H8OyxM59o0TbspU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709486494; c=relaxed/simple;
	bh=SyDdJfgV92VRqocKJt0U63QX/DKlxqAbaIRFhozxroE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSUwjZIn+UE73HoAWVHQQ1XGBkHsFmXaUQ+3IQnpv+lMiTwc+NyosymA1oRGSNxmfwUbDFgzFQBWuKeW50mEUZRUqcu98n/j1W1zGGM1CcDzYCO1S4UnftzaFFwKS4hjEnCUAIsrMOaeTknQ9EaMBddJ8ZkyLfOlUiXSv2dc+T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1+J5h/k; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e162b1b71so2729574f8f.1
        for <bpf@vger.kernel.org>; Sun, 03 Mar 2024 09:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709486491; x=1710091291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WA011/UD9lPkxgreG8pFDC4UI0TYOWPhPXHgpHjIU3E=;
        b=j1+J5h/kraqgohqUcFNj/f3TbGepbPAd9ThZZshXqIq3V2lV+tl71mdhOrwpgV9gLd
         mSM42Ek/lKcNjhoxVMEUHpWlpg1tmZd4m9HPWCk5ZBFSJvfUl/V0URlt5rpH8E8J6RBe
         mPYc+sVpdofFtvXHEMH8ItZCmdGum6Li1N6Drhx9jlGSwOi26ICx7sjNjGWejo6nOMRw
         6ZGmmZmgsz9JuLMaa6eio+LekIEhOJx35510Krovji4o5c2myTmltgHNfLE2Upn75lTX
         d1FQY1Qg8ai67vWfqmdTai/owXGCvwJ356qlNnPxoKSZ2WATLaWHYkzR28EZat9towUA
         uwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709486491; x=1710091291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WA011/UD9lPkxgreG8pFDC4UI0TYOWPhPXHgpHjIU3E=;
        b=NkgEVLWHdUq5dYpYmhdlZ/2dSaeqDT5zWQOg3/86vLzUFJGI3zvsTlh8PADTgcoBjt
         Y/96bhVanSFFdV7B3ighAr0649pqjdSJeQLea9WUe4jcRSseqKXMnjv7NSx1v9kWNlnb
         j6eDuUP/7rFhuoQu2rZ8o5rrekJF61YmuiWngvnRJ5nwEPRILoW01PaDNbXPvSYmXFNu
         3PVwr/r4gACplY9k+fmJynOgjjD+8bBho7tO8oC2qvlTMsEq2u7NaGy4gzJF12WWPvfv
         7d0ssmsY9tdTHZ16FYRhekpfTiRBSOoLOm6Cf4/oNYpKdKgRYYiiEVSbQu9aVcr47tMb
         fs5Q==
X-Gm-Message-State: AOJu0YxG/GgSprR5R17svb4id9Y/qPg00oUULnHTmpUiUwxPZHzaverA
	7cTj0llWBkdL1rl0gvntIqlXHrc6ghVbdcsxotK28NlK38SXRHruohdlIyyc8/YMtQ5ufcC86RV
	xsmcWIEt+FlO6qahWCXPbT37qXhEFygaYk7M=
X-Google-Smtp-Source: AGHT+IGTOgijBeB/Jj0wxI1sEHJWYw/hn2iixgblYctkqaPiX18FR3c5TOiTj9twFqzU6to43O5bq9TMHXxBor48gDw=
X-Received: by 2002:a05:6000:181b:b0:33e:162b:5353 with SMTP id
 m27-20020a056000181b00b0033e162b5353mr5221138wrh.16.1709486490733; Sun, 03
 Mar 2024 09:21:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302020010.95393-1-alexei.starovoitov@gmail.com>
 <20240302020010.95393-3-alexei.starovoitov@gmail.com> <136a8fbc350dacbb8b8a4a4c0236c11f1c49d4cb.camel@gmail.com>
In-Reply-To: <136a8fbc350dacbb8b8a4a4c0236c11f1c49d4cb.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 3 Mar 2024 09:21:19 -0800
Message-ID: <CAADnVQ+AeSkSovp_4wDztNhGKMF0X4+k+36_9r0DUZD5horZOA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/4] bpf: Recognize that two registers are
 safe when their ranges match
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 6:12=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2024-03-01 at 18:00 -0800, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > When open code iterators, bpf_loop or may_goto is used the following tw=
o states
> > are equivalent and safe to prune the search:
> >
> > cur state: fp-8_w=3Dscalar(id=3D3,smin=3Dumin=3Dsmin32=3Dumin32=3D2,sma=
x=3Dumax=3Dsmax32=3Dumax32=3D11,var_off=3D(0x0; 0xf))
> > old state: fp-8_rw=3Dscalar(id=3D2,smin=3Dumin=3Dsmin32=3Dumin32=3D1,sm=
ax=3Dumax=3Dsmax32=3Dumax32=3D11,var_off=3D(0x0; 0xf))
> >
> > In other words "exact" state match should ignore liveness and precision=
 marks,
> > since open coded iterator logic didn't complete their propagation,
> > but range_within logic that applies to scalars, ptr_to_mem, map_value, =
pkt_ptr
> > is safe to rely on.
> >
> > Avoid doing such comparison when regular infinite loop detection logic =
is used,
> > otherwise bounded loop logic will declare such "infinite loop" as false
> > positive. Such example is in progs/verifier_loops1.c not_an_inifinite_l=
oop().
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> I think this makes sense, don't see counter-examples at the moment.
> One nit below.
>
> Also, I'm curious if there is veristat results impact,
> could be huge for some cases with bpf_loop().

No doubt, there will be improvements here and there. For iters.bpf.o:
Insns (A)  Insns (B)  Insns  (DIFF)  States (A)  States (B)  States
(DIFF)  Program
---------  ---------  -------------  ----------  ----------
-------------  -------------------------------
      858        823   -35 (-4.08%)          81          79    -2
(-2.47%)  iter_nested_iters
      137        110  -27 (-19.71%)          12          10   -2
(-16.67%)  iter_obfuscate_counter
     1161       1109   -52 (-4.48%)          92          88    -4
(-4.35%)  iter_subprog_iters
       62         35  -27 (-43.55%)           5           3   -2
(-40.00%)  triple_continue

the rest in this file didn't change. No change for pyperf either.

> [...]
>
> > @@ -17257,7 +17263,7 @@ static int is_state_visited(struct bpf_verifier=
_env *env, int insn_idx)
> >                */
> >               loop_entry =3D get_loop_entry(&sl->state);
> >               force_exact =3D loop_entry && loop_entry->branches > 0;
> > -             if (states_equal(env, &sl->state, cur, force_exact)) {
> > +             if (states_equal(env, &sl->state, cur, force_exact ? EXAC=
T : NOT_EXACT)) {
>
> Logically this checks same condition as checks for calls_callback() or
> is_iter_next_insn() above: whether current state is equivalent to some
> old state, where old state had not been tracked to 'exit' for each
> possible path yet.
> Thus, 'exact' flags used in these checks should be the same:
> "force_exact ? RANGE_WITHIN : NOT_EXACT".

Good point. Will change. It should help as well.

