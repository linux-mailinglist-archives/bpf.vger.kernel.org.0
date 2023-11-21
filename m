Return-Path: <bpf+bounces-15568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06707F35CB
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 19:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24EAEB21473
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 18:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A82C3BB56;
	Tue, 21 Nov 2023 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1YVVt/n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70081AA
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 10:15:12 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ffef4b2741so284602066b.3
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 10:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700590511; x=1701195311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bp1Q+ohmhQ7TFLlLyHhjJfZPTs52PgnA6+y1/FiziR8=;
        b=R1YVVt/n1bvyQMIaFceb2ffuoZrQJtxixTpy5H0Zj5g3CLMFLsBgnYmLiCnXIrExsK
         nuNf2+VUuKYgrIOvdnmsJuuiIyjGEFqU68SfiyLp/CcgrK4PHoDP3YleJOkAMe5JXtVd
         3K0z7qqgVk06gNEMonYYIGnAIUhZX8pTOAEZ12WyNHb5ArEbTS2EJ6Pt+dFszJiKB2fE
         ED37TMsrTSOhBR8j0RRjFag6X26ZyCyOefPaZ0Yq95PZSkyYWC1pPGuPJwE7e8QVR7Ki
         fel4AoqXuzbI21RlTC0MAHrmKEWPkUurmRj30+hLZM+Rwneolv+0LEYEdbVdgiRxglTf
         yUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700590511; x=1701195311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bp1Q+ohmhQ7TFLlLyHhjJfZPTs52PgnA6+y1/FiziR8=;
        b=QJUGgB0VA5ATor0eySAzs4h9uG2T9mHXQK3O4YC2n4f7YBfhcMl0jwUT6XKpeoatx6
         IVPGdZjK32WcT1zGBbjhZtVYzf1c7xWwLIxHD+X5mwjR2K7FQsOewQZW11oHdGzISR0E
         3z9LmXUXMNCfmaQpI/QUZluHpai/leen1wdX2W5j+muGFMJrnHxkdC1PDix4pEqHVGjt
         i8N6V/fooynFfWHna4Aos5ikbNrLSfOJRsTe6beCK4Kz4/J/do9/k9n5MLoNxq1nen1K
         6mLKTlXT8WJfmHm1Oep8Nk3tSLN7dV9XmRHO9n/1bMroymUNqm+w/wrV/8CcN2yRya7d
         sUTw==
X-Gm-Message-State: AOJu0YzxJ5Ra7whIMaobgo6j9NCfDB7h853XsD4AlHHs9AARdo5ENNe1
	CAdAy91keN0qv5Py8BFpXQJgbnHQ9JSwdO5u6EToPnYS
X-Google-Smtp-Source: AGHT+IGN37c9N2AasNhhmaGoxirCOn53olJsLm/xhNvsuKGdQRKW/UIXF0GzjVuBu4ay+UKoEk8F6wePYUfkJav/AV8=
X-Received: by 2002:a17:906:104c:b0:a03:90a3:b775 with SMTP id
 j12-20020a170906104c00b00a0390a3b775mr346449ejj.27.1700590510564; Tue, 21 Nov
 2023 10:15:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121002221.3687787-1-andrii@kernel.org> <20231121002221.3687787-7-andrii@kernel.org>
 <d2cc304ac744e2663c8802e3853ed1e948743b32.camel@gmail.com>
In-Reply-To: <d2cc304ac744e2663c8802e3853ed1e948743b32.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 21 Nov 2023 10:14:59 -0800
Message-ID: <CAEf4BzbeNwJSDo0t=NxK4dL2m2m9O30=iAxTata1kK9p-uxxxQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 06/10] bpf: preserve constant zero when doing
 partial register restore
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 8:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2023-11-20 at 16:22 -0800, Andrii Nakryiko wrote:
> > Similar to special handling of STACK_ZERO, when reading 1/2/4 bytes fro=
m
> > stack from slot that has register spilled into it and that register has
> > a constant value zero, preserve that zero and mark spilled register as
> > precise for that. This makes spilled const zero register and STACK_ZERO
> > cases equivalent in their behavior.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > +                             if (spill_cnt =3D=3D size &&
> > +                                 tnum_is_const(reg->var_off) && reg->v=
ar_off.value =3D=3D 0) {
> > +                                     __mark_reg_const_zero(&state->reg=
s[dst_regno]);
> > +                                     /* this IS register fill, so keep=
 insn_flags */
> > +                             } else if (zero_cnt =3D=3D size) {
> > +                                     /* similarly to mark_reg_stack_re=
ad(), preserve zeroes */
> > +                                     __mark_reg_const_zero(&state->reg=
s[dst_regno]);
> > +                                     insn_flags =3D 0; /* not restorin=
g original register state */
>
> nit: In case if there would be v3, could you please
>      leave a comment here, something like below:
>
>        when check_stack_write_fixed_off() puts STACK_ZERO marks
>        for writes, not aligned on register boundary, it marks source
>        registers precise. Thus, additional precision propagation is
>        necessary in this case and insn_flags could be cleared.
>
>      or something along these lines?
>

Hm... this seems misleading, precision propagation of original
register on write is orthogonal to this. The real reason why we clear
insn_flags is because there is no *register* fill here. There might
not be any spilled register at all here, or a completely irrelevant
spilled register. This instruction is basically `r1 =3D 0;`, though
obfuscated as stack dereference. So from the backtracking side of
things, there is no stack access here.



> > +                             } else {
> > +                                     mark_reg_unknown(env, state->regs=
, dst_regno);
> > +                                     insn_flags =3D 0; /* not restorin=
g original register state */
> > +                             }
> >                       }
> >                       state->regs[dst_regno].live |=3D REG_LIVE_WRITTEN=
;
> >               } else if (dst_regno >=3D 0) {
>
>
>

