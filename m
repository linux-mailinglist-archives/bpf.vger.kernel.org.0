Return-Path: <bpf+bounces-16906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D918C807747
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 19:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7A0281FDB
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 18:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0266E2DC;
	Wed,  6 Dec 2023 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRxVa8JQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E05D44
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 10:05:44 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2ca0715f0faso748311fa.0
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 10:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701885942; x=1702490742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpEVSuHt21rDXsxQCkQN58rOm7BV76ft5dYyMtgH4Vo=;
        b=QRxVa8JQp1hxeAZovEyW7kdZYQ1MxlCU9l1Ep/3XS8Dh0Gi8MQ4gXDo9OinJYTHs1f
         XkVK63aohnUgF21UqXkkODV8od4IFT0UmCL50iHyL1SrxjifAB69wa186h8yA+c4A1gf
         RjUwLsyMqwSnnsmWHRrKOsKY/qa3CyN4G0zqSZZ1gwkny0oifGw4qonMhl7EUG8kEf/9
         s+S50yE+1FBjLglnHiR+19zIAy8OlJMKyjtD/hGuOGG6dpo/BwWqfbn8R8uQpLDar+ZD
         On+3OxLokALKNGeoEWgIy2Yv8DYFHwdeu+IuTqd/8xizZXq1eae2AfJJC3r7rlNnlxdT
         9VqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701885942; x=1702490742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpEVSuHt21rDXsxQCkQN58rOm7BV76ft5dYyMtgH4Vo=;
        b=oRuV1GuRS+2u4O7S67qksQ2bwuWDMix6pI0DQsuvTks0K2jQ9wMSvekSr55XYIJ4Pd
         u74uRCfFyZmRzZOasGjCyY8EdUt1Bu4nDqEHIyUqAnA2oaSA2Kk7FjAXYFdfXg2t4y6b
         bnJx5xNH7EkX62mcqrawtGuUlKx10FHO5Wg/It55brOOLHAA41Ei4dxCuehvNo01rko/
         TEYXgqNVIANEZmBKFWM1DNb02kAJIp9hhiki0g50syCDf6JPy06t4MbzX7fA3L0kD3g0
         bZRexXzLep+FD54kCN4BPKRaLhqICbjYE68S0pWrD0xYICCFdsj2QYqRH/Sey9H5/Veh
         n+kA==
X-Gm-Message-State: AOJu0Yyen4NDqAUOvQG0eSt9asIq01KY/X5BlMpirJaFS7Y81Pz9IAUi
	mmYtS8d7tCkfRt1tiOClc0H0NYlwwKuFSsGADhnoEAKn
X-Google-Smtp-Source: AGHT+IE4FcSB9RpexxGLcIECpBV0WcgaA0E0iDyEDcAwSwUSFoS6qj/DpA1xhDDVMMS2vcxZAiORR02OCoNm1vZ5IBo=
X-Received: by 2002:a2e:a4c6:0:b0:2ca:2801:496a with SMTP id
 p6-20020a2ea4c6000000b002ca2801496amr417903ljm.82.1701885942281; Wed, 06 Dec
 2023 10:05:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204233931.49758-1-andrii@kernel.org> <20231204233931.49758-10-andrii@kernel.org>
 <a64282c46316e59a57e86639debf14290915fd52.camel@gmail.com>
In-Reply-To: <a64282c46316e59a57e86639debf14290915fd52.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Dec 2023 10:05:30 -0800
Message-ID: <CAEf4BzaLVEt-bQMPwOGd2vEYjHGFB5_HjDjMm8=h04aOxnXx3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/13] bpf: reuse subprog argument parsing logic
 for subprog call checks
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 3:22=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2023-12-04 at 15:39 -0800, Andrii Nakryiko wrote:
> > Remove duplicated BTF parsing logic when it comes to subprog call check=
.
> > Instead, use (potentially cached) results of btf_prepare_func_args() to
> > abstract away expectations of each subprog argument in generic terms
> > (e.g., "this is pointer to context", or "this is a pointer to memory of
> > size X"), and then use those simple high-level argument type
> > expectations to validate actual register states to check if they match
> > expectations.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> >  kernel/bpf/verifier.c                         | 109 ++++++------------
> >  .../selftests/bpf/progs/test_global_func5.c   |   2 +-
> >  2 files changed, 37 insertions(+), 74 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 2103f94b605b..5787b7fd16ba 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -9214,21 +9214,23 @@ static int setup_func_entry(struct bpf_verifier=
_env *env, int subprog, int calls
> >       return err;
> >  }
> >
> > -static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > +static int btf_check_func_arg_match(struct bpf_verifier_env *env, int =
subprog,
> >                                   const struct btf *btf, u32 func_id,
> > -                                 struct bpf_reg_state *regs,
> > -                                 bool ptr_to_mem_ok)
> > +                                 struct bpf_reg_state *regs)
>
> Nit: It looks like 'func_id' is always 'prog->aux->func_info[subprog].typ=
e_id'.
>      Maybe remove this parameter and retrieve func_id inside this functio=
n?
>      Or at-least, could you please rename it to subprog_btf_id?
>      For me names 'subprog' and 'func_id' seem interchangeable and thus c=
onfusing.

func_id is not actually used anymore, so I'll just drop it altogether.
I agree that func_id is a confusing name.

>
>

