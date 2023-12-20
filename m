Return-Path: <bpf+bounces-18364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9778197FF
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 06:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30F11F25B26
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 05:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93232D26F;
	Wed, 20 Dec 2023 05:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHCD1P/w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11AF16406
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 05:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e2ce4fb22so5451680e87.1
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 21:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703049364; x=1703654164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAgqiDUE4sjmgkkv43AV3VPYM5LXEuPeZX6Rp0Kcy+o=;
        b=MHCD1P/wdkeDzj6hCHGYmNKSwegdnU/S0y/bPTJImvO/IxvgTa1mHcwG3WlwqlNxAk
         LkaqpGRl8CegWc40kkWeQCbnur16AYW9cMgKuKeduPANgokjh/kq9RtmK4BfyzChS5uk
         so3KHjiDvCVHSkrkHdeIxu0wTmjd1EMCNR8jwzyFvwOFmyafJYGBcnQNmo/CoGiI3r+x
         CAh7gc8572Km3ZSCBYiIVu3crJ2y7fHwMEbs9UoWe6OmbMdTVJpnwXSpNdrHO+SzBYA1
         6+Fr8BCmBDLz6ZbCueAYCUwgt0QJ9j7YKOIsV7Veb1RJulHNysuzVlKmPF3aiQDcmEEU
         NGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703049364; x=1703654164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAgqiDUE4sjmgkkv43AV3VPYM5LXEuPeZX6Rp0Kcy+o=;
        b=cjEBGoAkhS4lHI8tJGryHADiMHm+pVH/PBpEIbVTqb1Fg44JQfRyBWbzxFfuvDDqPW
         pxO6OYVMtorB/e2Nj09HwxMrr9wLPMZhI66EjBhkmPDqZyj+GBZd18I9xqrbYwhaYyNC
         6WvGzbDx2wKU2ubP34S86NJFmkJCNlV4qEVPDdoNSPZpCljOTiVbJT4HS4/Mez5BeObF
         l3rvr7S2T95A/2kDYtEQaSrysv5emMxommcbRc4eOM+rf1TnYP1CPeLpxgxzfW1HCkKH
         o+xan53fS4OGG4mxOjiMV2Do37xrDDpbPrxMZ38sRmIywC4fyLqDA4s1Zh4fy2FfngA7
         9yDQ==
X-Gm-Message-State: AOJu0YyrBswzhvnuYUHoUsDGLX/xSnyFg9HSPD0qnZW8HyyRh9kFD77x
	fOVC+bqJ62wVeTcSFCgC6vRnIxNkUH9pG0mlF04=
X-Google-Smtp-Source: AGHT+IG+5k4dAjM3hZRJlXYoYlQY71npCqsRdvW2pcAluGLbb+tLHSg67Wv5nIlDVUPoenyuGTDBKx+8RddBdecLZ5I=
X-Received: by 2002:a05:6512:1596:b0:50e:36c3:47a6 with SMTP id
 bp22-20020a056512159600b0050e36c347a6mr3739960lfb.36.1703049363236; Tue, 19
 Dec 2023 21:16:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215011334.2307144-1-andrii@kernel.org> <20231215011334.2307144-8-andrii@kernel.org>
 <CAADnVQL_aTdNBJ3oCruAFqirE-qYUQq3ycbftzN=PffT7aAx5A@mail.gmail.com>
In-Reply-To: <CAADnVQL_aTdNBJ3oCruAFqirE-qYUQq3ycbftzN=PffT7aAx5A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Dec 2023 21:15:50 -0800
Message-ID: <CAEf4BzatgkgnWU0kdg-ipYincX0xNcmwHxrSohLbNoZ82DNp+g@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 07/10] bpf: add support for passing dynptr
 pointer to global subprog
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 6:19=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Dec 14, 2023 at 5:14=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> > +               } else if (arg->arg_type =3D=3D (ARG_PTR_TO_DYNPTR | ME=
M_RDONLY)) {
> > +                       ret =3D process_dynptr_func(env, regno, -1, arg=
->arg_type, 0);
>
> Minor nit:
>
> It's a rdonly dynptr, but still... may be pass env->insn_idx instead of -=
1 ?

I don't mind, but you are right, it's MEM_RDONLY, so insn_idx
*shouldn't* be necessary, which is what I sort of tried to ensure
explicitly. But I think the real problem here is that perhaps
process_dynptr_func() should be split into two: one that initializes
dynptr slots (MEM_UNINIT case), and separate that validates that
dynptr is properly initialized on the stack (non-UNINIT).

I will try to remember to come back to this after the holidays and
clean it up, ok?

>
> Separately, I'm not sure why we still pass insn_idx in so many
> functions. Looks like we can use env->insn_idx pretty much everywhere
> and remove that argument.

Do not know :) But some of those insn_idx passing goes really deep. I
think there is a constant opportunity (and, really, the need) to keep
refactoring and simplifying things in verifier's logic.

>
> The first 5 patches are very tricky, but all tests are green,
> so they must be correct :)

fingers crossed... :)

