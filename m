Return-Path: <bpf+bounces-15591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880DF7F3737
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 21:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF060282141
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 20:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54FB54663;
	Tue, 21 Nov 2023 20:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3L9PMA1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54429D
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 12:23:03 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so74820731fa.3
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 12:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700598182; x=1701202982; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u/Xt+GBiRhzLxTY8+BETgnvswEFei8CFjtA7auOGd5M=;
        b=Q3L9PMA1V8BpZz0ghLnENHFqH3rpNlNpKdxSNxGNGiDHZ32PeGPqS70pDcdp8bVLPC
         WtwPncxkB5r3R2PTaKZ6TOpw/djGvkUwQxvRlUVzJDFLkBETvc+VMNhmsrUlJ++XYuY0
         jrSWaNmaxi/e+ntY2BiXxV9z5+9qzg5zEIpctGfeqM8+JHSngxxQxsV4uwY/UZs+fx7d
         U0VgDyJ6kn5UtyldT4z85J9a8Be6a0ZWLLruXHOdwagi2LdFzr3ChCMEs1xQvvs8Wbfo
         T9rVeZ1XQbexbXM5vS3iITAQSeFjsWn9NoM7VxNav1+Bjqy1EEvhcHMxr2sD/rh20rAG
         TtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700598182; x=1701202982;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/Xt+GBiRhzLxTY8+BETgnvswEFei8CFjtA7auOGd5M=;
        b=SnqrYeMLdaI1GGIHmZlPMPNWejFLjedHjmIBOvm4lfyIpYcGjDZL2OSJlbPoqUjK+q
         uy29IQug61koZUJoO85Qi38KWP2AmrvkOB5bm1hei7fH0Lo3qBQp/BUx1Q3KrSXgpOq0
         +XOb3EgK5O8aBLoZg2Xll2hgv2myTDCqizLWKRQxPje/68F/amX3YO0XwVGL9rYqLbOM
         FMr/El2vdP1/HHdg3UPY62WHQW7rt7AhgjnXbsbvduynhACO6e+tykVdf+QQGLqj51AD
         2jskCvmaR3sfJq2wDy6bJYdOgUuJGjEUVyEBJccEOp6xaP9XfkUFi5maUDxSxfynsjOD
         MEfw==
X-Gm-Message-State: AOJu0YwenvDprGEfHZ2jyee87IcpwNgctPXedRLXuke+ZUC5+HEHsKuG
	CGOOavuekbGmpHvRX5lFQrA=
X-Google-Smtp-Source: AGHT+IEeBNGh2cM6DqLhyEc6KNbgMf9i5ZOBTfpYvgSM8Lr7wpHwtgnyKCtq5h5QrGm9IdebMgoeBA==
X-Received: by 2002:a2e:8e99:0:b0:2c0:c6a:d477 with SMTP id z25-20020a2e8e99000000b002c00c6ad477mr204665ljk.18.1700598181628;
        Tue, 21 Nov 2023 12:23:01 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id t4-20020a2e9d04000000b002c887d5b4dbsm375363lji.42.2023.11.21.12.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 12:23:00 -0800 (PST)
Message-ID: <4a91459cfdc249dfa6fc0dcc166ed5629f00def1.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 06/10] bpf: preserve constant zero when
 doing partial register restore
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Tue, 21 Nov 2023 22:22:59 +0200
In-Reply-To: <CAEf4BzbeNwJSDo0t=NxK4dL2m2m9O30=iAxTata1kK9p-uxxxQ@mail.gmail.com>
References: <20231121002221.3687787-1-andrii@kernel.org>
	 <20231121002221.3687787-7-andrii@kernel.org>
	 <d2cc304ac744e2663c8802e3853ed1e948743b32.camel@gmail.com>
	 <CAEf4BzbeNwJSDo0t=NxK4dL2m2m9O30=iAxTata1kK9p-uxxxQ@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-21 at 10:14 -0800, Andrii Nakryiko wrote:
> On Tue, Nov 21, 2023 at 8:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Mon, 2023-11-20 at 16:22 -0800, Andrii Nakryiko wrote:
> > > Similar to special handling of STACK_ZERO, when reading 1/2/4 bytes f=
rom
> > > stack from slot that has register spilled into it and that register h=
as
> > > a constant value zero, preserve that zero and mark spilled register a=
s
> > > precise for that. This makes spilled const zero register and STACK_ZE=
RO
> > > cases equivalent in their behavior.
> > >=20
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> >=20
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >=20
> > [...]
> >=20
> > > +                             if (spill_cnt =3D=3D size &&
> > > +                                 tnum_is_const(reg->var_off) && reg-=
>var_off.value =3D=3D 0) {
> > > +                                     __mark_reg_const_zero(&state->r=
egs[dst_regno]);
> > > +                                     /* this IS register fill, so ke=
ep insn_flags */
> > > +                             } else if (zero_cnt =3D=3D size) {
> > > +                                     /* similarly to mark_reg_stack_=
read(), preserve zeroes */
> > > +                                     __mark_reg_const_zero(&state->r=
egs[dst_regno]);
> > > +                                     insn_flags =3D 0; /* not restor=
ing original register state */
> >=20
> > nit: In case if there would be v3, could you please
> >      leave a comment here, something like below:
> >=20
> >        when check_stack_write_fixed_off() puts STACK_ZERO marks
> >        for writes, not aligned on register boundary, it marks source
> >        registers precise. Thus, additional precision propagation is
> >        necessary in this case and insn_flags could be cleared.
> >=20
> >      or something along these lines?
> >=20
>=20
> Hm... this seems misleading, precision propagation of original
> register on write is orthogonal to this. The real reason why we clear
> insn_flags is because there is no *register* fill here. There might
> not be any spilled register at all here, or a completely irrelevant
> spilled register. This instruction is basically `r1 =3D 0;`, though
> obfuscated as stack dereference. So from the backtracking side of
> things, there is no stack access here.

Hm, I mostly agree. This comment would be relevant only before patch #8
in this series.

