Return-Path: <bpf+bounces-4716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AB774E53F
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 05:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F18B61C20C85
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066173D7B;
	Tue, 11 Jul 2023 03:24:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACE93FDC
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 03:24:57 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064ECC2
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 20:24:56 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-635857af3beso26138606d6.0
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 20:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1689045895; x=1691637895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRrBHyxlTn8ItFZqGDsaTFG1bK3+seEFvi8lbsGP7n8=;
        b=A7fl8QTt4NCecxWEfbm/KnF+XYGfw+guubIr8HPXrU2AtE4aXlmW5n5X6KDyS1b3xI
         8FullbXSZE4xAG4tznGuTmShRlkILZmEQ/005IQXbzB4v6CRMxAQLmKcwhpxZwa3B3YJ
         zclBKKMkp7XaRbw9XaVTc1YgtlW58NtMM7VFtkcAh28ujPUf4Ib5uQAnsSsbb5WSz13i
         GWsSEi0Yr07O+cBZanzFKJnEt7/iYKHNBGrZ1u9yKL3E/2rpHPnFmjTA49JX0YfPWPlE
         fwPV29+j1ec7RuDTTWHW/OxKkTOt01qkdgx8PiXp2oPMGtPsBQzsGEaIAWIO9xGuBuun
         OAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689045895; x=1691637895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRrBHyxlTn8ItFZqGDsaTFG1bK3+seEFvi8lbsGP7n8=;
        b=fwe0P8OnNGYtMB9hVB64XbAbgh6mG6cCUAtBMYTayvkyw+v1LLLObXvH3YbmCVkfIh
         GacbjeK18IYeuUPth4BJaHpd4Zw0BV43krpqlxETjXEuhCogcjSKzgDZZw69nQBWSuAm
         q5PN6JGOp6csWU9/zRIKexNaq0/2C7LqYoQQ+nYxNkC1bN0gWTCcobXCPfDjI273PULg
         frDMnpWAQF4drYIblsQQmD+CnTPtwUNdxxdWbn9nFMdOY0cdoJCs2cJA8X75cY1yp2Kh
         QobDb9lkNFv9L94v3gAYF3nA4K1PzFjNa9cEPG9ksWSJH0hw2uGkj0WQA8da8A8Dov+9
         e27g==
X-Gm-Message-State: ABy/qLbqG5fPQmufMqpwZqth0czGxssvwHQigHkatEu5Z4voBCyEAl4I
	3SP6K5i0hLC8+sixoOq/72wkShKwCtQEC63vVQrHxQ==
X-Google-Smtp-Source: APBJJlHScF0oeOrxMIy/NhuInzroJ6APwFktJ37YBj1NBVLdMqpG2VoP2M5jHaKfcU4T3X5y5VoLb5GTMlFUdgbOwDQ=
X-Received: by 2002:a0c:e38c:0:b0:631:e696:7b1 with SMTP id
 a12-20020a0ce38c000000b00631e69607b1mr11326022qvl.62.1689045895050; Mon, 10
 Jul 2023 20:24:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710215819.723550-1-hawkinsw@obs.cr> <20230710215819.723550-2-hawkinsw@obs.cr>
 <CAADnVQ+F5VT72LzONEo79ksqaRj=c7mJDd_Ebb87767v01Nosw@mail.gmail.com> <CADx9qWgmYu_LVVFtR0R7pcqM_270kQFzvmiSZ-2Umn2pE6qn=g@mail.gmail.com>
In-Reply-To: <CADx9qWgmYu_LVVFtR0R7pcqM_270kQFzvmiSZ-2Umn2pE6qn=g@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Mon, 10 Jul 2023 23:24:45 -0400
Message-ID: <CADx9qWhTi+NetbqbBpMTEAFRsbQQbn3CXRvhC8wyzqQQviy0kA@mail.gmail.com>
Subject: Re: [PATCH 1/1] bpf, docs: Specify twos complement as format for
 signed integers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 11:19=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wro=
te:
>
> On Mon, Jul 10, 2023 at 11:00=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Jul 10, 2023 at 2:58=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> =
wrote:
> > >
> > > In the documentation of the eBPF ISA it is unspecified how integers a=
re
> > > represented. Specify that twos complement is used.
> > >
> > > Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
> > > ---
> > >  Documentation/bpf/instruction-set.rst | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bp=
f/instruction-set.rst
> > > index 751e657973f0..63dfcba5eb9a 100644
> > > --- a/Documentation/bpf/instruction-set.rst
> > > +++ b/Documentation/bpf/instruction-set.rst
> > > @@ -173,6 +173,11 @@ BPF_ARSH  0xc0   sign extending dst >>=3D (src &=
 mask)
> > >  BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_=
 below)
> > >  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > +eBPF supports 32- and 64-bit signed and unsigned integers. It does
> > > +not support floating-point data types. All signed integers are repre=
sented in
> > > +twos-complement format where the sign bit is stored in the most-sign=
ificant
> > > +bit.
> >
> > Could you point to another ISA document (like x86, arm, ...) that
> > talks about signed and unsigned integers?
>
> Thank you for the reply. I hope that this change is useful. I proposed
> this change to mimic the documentation of "Numeric Data Types" in
> Volume 1, Chapter 4 of "Intel=C2=AE 64 and IA-32 Architectures Software
> Developer=E2=80=99s Manual" [1].
>
> [1] https://www.intel.com/content/www/us/en/developer/articles/technical/=
intel-sdm.html

Perhaps you would prefer that this information goes (again) in a psABI
document? If so, that's great -- I am working on a strawman version of
one as we speak, in fact.

Whatever you think is best is great -- you are the expert I am just
trying to help!

Sincerely,
Will

