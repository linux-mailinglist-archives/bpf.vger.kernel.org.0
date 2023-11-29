Return-Path: <bpf+bounces-16203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B4B7FE459
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 00:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1551C20B9C
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 23:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB54747A6A;
	Wed, 29 Nov 2023 23:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuZwSF1o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9399EB2
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 15:55:13 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a0064353af8so293434466b.0
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 15:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701302112; x=1701906912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cL59atYyTbrU3zPrN5rRx4ln4qf/sokDGr+bfPVBr9Y=;
        b=ZuZwSF1ojvoovg2RA0wj/VMClg4dtC5hURvt2DP3PMc0eZsN00QclpbSQ7URWzf83U
         oHmBVqgc/bFS+IiEWIwNIRMKNIhlxSJd/V9O7Z/JFEVTdqn0C9RD0rB/DLYBbv7z/iLw
         fuAXCtOyhv6Ghu/rKWLUuw+44dIiw3WgNju2I248X3B4ScQEPUN2pmYhTkw1dw8hih7o
         WeLRZA8JcBGA4a4rSYEYC5+98oLGz95uBWRmHgQeh8EC/dWzmSMCCLWFXgeIq5i5B4hb
         Fuv0FXz7U7GWKviUvnayfJ5yEptOqzrhOWR7JMWrZbPld00UdGBoryeSpGKjsVi3ZQv9
         Ylcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701302112; x=1701906912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cL59atYyTbrU3zPrN5rRx4ln4qf/sokDGr+bfPVBr9Y=;
        b=SaJtr+GkFiWsZKxw7sa4yNGS65bJ9eKfcwI9S9eCsExCrTP9YkmMZO2a0/ccSImrjT
         f8JMdaw+F1llEE7e2SuguGtwrQ3SlCT6R4VM6snT2Pgj0557Y4aJWfKBWBitmDmFzxOU
         y7DlIiFHu/suTPj/3GDElmjVqM337D05uCA+KczvhxpnpbNkxXoq55o00lq7ulfIKcm+
         /slGIlJuj3B9/v4EZR8m+wK37XS1PrVsuXkaNkH8JbBQ96akj4xCUff65G6kyJEcNAjw
         Vbco8BQw0EXOmG8KHEqJiu7RHZWaYIT0rOmvpi6WQmff3XetnS67rojyBs7vvkansCTL
         QOig==
X-Gm-Message-State: AOJu0Yy4wCCV4aZBzxh3FgsE2QVHeguHhIJt7kSfuuhYcCgLewCGZ2ry
	3YuKFW34KSB8XAL9PCj4gsLPjk2YqivJZtKNWcfo5w3o
X-Google-Smtp-Source: AGHT+IHPa+lPf7Dw7Dd/oJxdDa6S1QSE4hJgWwL2EC12ygVPLFIGVPwBy7HXxvKFjGKrA+5iBY6L2hRS3IXZERWpArk=
X-Received: by 2002:a17:906:5788:b0:a18:4d81:5091 with SMTP id
 k8-20020a170906578800b00a184d815091mr519962ejq.21.1701302111813; Wed, 29 Nov
 2023 15:55:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231126015045.1092826-1-andreimatei1@gmail.com>
 <20231126015045.1092826-2-andreimatei1@gmail.com> <CAEf4BzacRRwzdQH8LuQkV695=rm65jnv1bX2n9gks6G+wGAw6w@mail.gmail.com>
 <CABWLses9f6izTmODQf_hKwhvH54-vpWrzWHP_KRG=n8gRWpp-w@mail.gmail.com>
In-Reply-To: <CABWLses9f6izTmODQf_hKwhvH54-vpWrzWHP_KRG=n8gRWpp-w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 29 Nov 2023 15:54:59 -0800
Message-ID: <CAEf4BzZuf1XHe7=Am1c3Crv9CMrz8TjDKczKQaih=guAVi0wpA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: fix accesses to uninit stack slots
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org, sunhao.th@gmail.com, eddyz87@gmail.com, 
	kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 8:48=E2=80=AFAM Andrei Matei <andreimatei1@gmail.co=
m> wrote:
>
> [...]
>
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index af2819d5c8ee..f9546dd73f3c 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -1685,10 +1685,12 @@ static int resize_reference_state(struct bpf_=
func_state *state, size_t n)
> > >         return 0;
> > >  }
> > >
> > > -static int grow_stack_state(struct bpf_func_state *state, int size)
> > > +/* Possibly update state->allocated_stack to be at least size bytes.=
 Also
> > > + * possibly update the function's high-water mark in its bpf_subprog=
_info.
> > > + */
> > > +static int grow_stack_state(struct bpf_verifier_env *env, struct bpf=
_func_state *state, int size)
> > >  {
> > >         size_t old_n =3D state->allocated_stack / BPF_REG_SIZE, n =3D=
 size / BPF_REG_SIZE;
> >
> > shouldn't this be rounding up? (size + BPF_REG_SIZE - 1) / BPF_REG_SIZE=
?
>
> You're saying this was always broken, regardless of the current patch, ri=
ght? I

I think so, yes...

> think you're right, but that seems like a bug that should have been
> caught somehow; I'm surprised no programs crashed the verifier. Perhaps i=
n
> practice all stack accesses are 8-byte aligned, so the rounding doesn't m=
atter?
>
> I'll spend a bit of time reading code and come back.

Thanks!

>
> [...]

