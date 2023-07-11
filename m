Return-Path: <bpf+bounces-4718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AAE74E54A
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 05:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DEB1C20D34
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1413FE4;
	Tue, 11 Jul 2023 03:28:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A162F361
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 03:28:24 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8F0E3
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 20:28:22 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-635de6776bdso35803506d6.2
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 20:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1689046102; x=1691638102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPHOpuG0nRzVKLS8XM9h0fEa3eKyMGT7EzxN/swJKAg=;
        b=YznUrHIE3/38DzxSIOJ9dWHnQFG+V4OnoQMkNosYGc0VxdfcZw59gx8EfN9KNZNhDa
         01Ijn3EfEufWMDwr2CYb3YcVdW9At5ueHsTbS8ro5RN9PdagEOMUNjCoeslO72J1nuUu
         R3Uj+ihMjv/mqh/K2PvN3kWcfHn+GPgaRxjqkN7w5pOyn05APkOgmTXvbcgaYa3zggwC
         UyS1rp+nT0U8iRkgjpDv0fm36TjP7QKwdWwlP4ilw7zDsijBToItbEPHoIBfRIs7bTcj
         YxoipDIsbXV/pIkohdvZ0KEncOO3b5/tJ/pSfe8ffVGZzUto60d6v3PwUMryby5soxsp
         w64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689046102; x=1691638102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPHOpuG0nRzVKLS8XM9h0fEa3eKyMGT7EzxN/swJKAg=;
        b=GTd2jQX+AmwLHYzsk9D+6z25KCbn8T2TEGvzc+mKowN9Tsa4GwgOA4fHXLbwd5CJeR
         XY3tG9RM56bHay5AmZJvjJDo7MSjG8nWGgSVamzd2x9K6TGMv017nyqGKU609K1xdfVV
         3w/jOxQUZmFWP/PJBGt440InTYIPWZLYQmv4a24U7hAT2vApBQU90qKxoaf6xp3vPRwk
         IyEmoxVeYAY+9Js1ZskuaoEi6z7BfqF9/B94B59JVSqNQ/sxIHxVI6AVFl7pDJh5HlYf
         L7gkl7wdTftXxKnignY4ivxiDXcm7Eg8KLftxKVjWpbSG3eoR/Lb/If9nAHdcMWAab8Y
         utxw==
X-Gm-Message-State: ABy/qLYKGzNGT2JXFNV3L2BmQal46XVlQT3z0Au+vhBIQBMF+cDKSTOE
	5E7Xs4HlBooo2ehfYl2c7wjp2KPePr92kRqHToukAE+XPh9MGeZaP0Q=
X-Google-Smtp-Source: APBJJlEwd9lWr+uix9pe2kGV82O3+oRMScTHHFLH7LePg9HDjgBqMdeuKiotMgVio1VW9WAL52hDDxwXAFSbC7tvXbQ=
X-Received: by 2002:a0c:f0d3:0:b0:637:398f:83be with SMTP id
 d19-20020a0cf0d3000000b00637398f83bemr12649425qvl.14.1689046101931; Mon, 10
 Jul 2023 20:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710215819.723550-1-hawkinsw@obs.cr> <20230710215819.723550-2-hawkinsw@obs.cr>
 <CAADnVQ+F5VT72LzONEo79ksqaRj=c7mJDd_Ebb87767v01Nosw@mail.gmail.com>
 <CADx9qWgmYu_LVVFtR0R7pcqM_270kQFzvmiSZ-2Umn2pE6qn=g@mail.gmail.com> <CADx9qWhTi+NetbqbBpMTEAFRsbQQbn3CXRvhC8wyzqQQviy0kA@mail.gmail.com>
In-Reply-To: <CADx9qWhTi+NetbqbBpMTEAFRsbQQbn3CXRvhC8wyzqQQviy0kA@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Mon, 10 Jul 2023 23:28:11 -0400
Message-ID: <CADx9qWjCpHpdRup306JkUNDypQdOOuUduvmRwA3c1uRzS3Xo1w@mail.gmail.com>
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

On Mon, Jul 10, 2023 at 11:24=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wro=
te:
>
> On Mon, Jul 10, 2023 at 11:19=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> w=
rote:
> >
> > On Mon, Jul 10, 2023 at 11:00=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Jul 10, 2023 at 2:58=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr=
> wrote:
> > > >
> > > > In the documentation of the eBPF ISA it is unspecified how integers=
 are
> > > > represented. Specify that twos complement is used.
> > > >
> > > > Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
> > > > ---
> > > >  Documentation/bpf/instruction-set.rst | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/=
bpf/instruction-set.rst
> > > > index 751e657973f0..63dfcba5eb9a 100644
> > > > --- a/Documentation/bpf/instruction-set.rst
> > > > +++ b/Documentation/bpf/instruction-set.rst
> > > > @@ -173,6 +173,11 @@ BPF_ARSH  0xc0   sign extending dst >>=3D (src=
 & mask)
> > > >  BPF_END   0xd0   byte swap operations (see `Byte swap instructions=
`_ below)
> > > >  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > >
> > > > +eBPF supports 32- and 64-bit signed and unsigned integers. It does
> > > > +not support floating-point data types. All signed integers are rep=
resented in
> > > > +twos-complement format where the sign bit is stored in the most-si=
gnificant
> > > > +bit.
> > >
> > > Could you point to another ISA document (like x86, arm, ...) that
> > > talks about signed and unsigned integers?
> >
> > Thank you for the reply. I hope that this change is useful. I proposed
> > this change to mimic the documentation of "Numeric Data Types" in
> > Volume 1, Chapter 4 of "Intel=C2=AE 64 and IA-32 Architectures Software
> > Developer=E2=80=99s Manual" [1].
> >
> > [1] https://www.intel.com/content/www/us/en/developer/articles/technica=
l/intel-sdm.html

(Apologies for a string of responses)

The RISC-V ISA specifies integer representation [1].

[1] https://riscv.org/technical/specifications/

>
> Perhaps you would prefer that this information goes (again) in a psABI
> document? If so, that's great -- I am working on a strawman version of
> one as we speak, in fact.
>
> Whatever you think is best is great -- you are the expert I am just
> trying to help!
>
> Sincerely,
> Will

