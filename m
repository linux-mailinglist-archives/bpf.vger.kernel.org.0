Return-Path: <bpf+bounces-4714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BACA74E534
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 05:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00209281632
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B440D3D60;
	Tue, 11 Jul 2023 03:19:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE5B23D8
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 03:19:27 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA76BF
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 20:19:25 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-635eedf073eso34270996d6.2
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 20:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1689045564; x=1691637564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ik5uHaugDoEAFveCczUWTAZcELGLKgFykeSVZ7+OeIo=;
        b=BvPLe5RPZzpO48IpCOe9aHW+oSte1l+UTQzYffP43/qA97HEuGx5uaUm9vU4LT4Tb7
         83WtyeSQ0RBAm8UrLwbP1JwxLFlK/T9G1Y10TgTiHvKMYm5lmDgx2V21+tydwfZr1d39
         eDyBEffYhUM06hno8pVyxWo17ZtZMQEcXZECjkFerkeMZ1c9RrMXZRECFTTW96oce9oa
         mVOLGLlxd9I5czmlmFpSRKqSm+lDId7S3eylp/SgiDyLPDz/lPvIdSoy5KH+VB9fAa5h
         HiXvtQAJjF/4AMjgHXOYmFMbJ1/vklUk8DGlY2OW3ChxBEIu9/eYzm76lIshQAp97sWZ
         qeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689045564; x=1691637564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ik5uHaugDoEAFveCczUWTAZcELGLKgFykeSVZ7+OeIo=;
        b=SVjXj6lYuyhwC/A3maWWGEQs02imtXJ4/dbFtAZXQg25HSKm1lB9ZT8iOdw1Us3aC9
         +3L0N3lffpUHHqRiovDkELJ9BAmlN/3Xxz6sTvBPaYKSIhoEyRK/86VJ1TxC4yOOcGos
         RobfGwIN4Hs2BFIRrne0iF0EfLUUanu+Vw765DJhWigrIiKKXC9lVrJgwGjWHyQT6gBg
         yhWuQZ7jsoXAtlNpLyMevcjRmFQXzYjn3e6OTOMNtMD9Om6Wlwsr8CJiAvFjK7LcYEkX
         QMn9lw9CG7osZhmNb5WIorVQI1X2+1PRRvFDYhbNxdZghGFz9tnG+jUrOcYElItZqIJA
         ZkQQ==
X-Gm-Message-State: ABy/qLaAiTwUWgYgCyrjYlMAab1u6nT80rIAazVYidojT5+A+c1WhnZC
	eRM/cND9PoFLSmyyLia/izsmvq/MAKve9XvC4I16Sg==
X-Google-Smtp-Source: APBJJlG1AMIvBJeo0PJxRleyGNGt2oI49pWla0Y6J61AAqFFqdDbsO4kc0PyXW8NNs4kUamT0j73QYuQf2eLtSAlej8=
X-Received: by 2002:a0c:cb87:0:b0:636:4e70:5425 with SMTP id
 p7-20020a0ccb87000000b006364e705425mr10644825qvk.54.1689045564524; Mon, 10
 Jul 2023 20:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710215819.723550-1-hawkinsw@obs.cr> <20230710215819.723550-2-hawkinsw@obs.cr>
 <CAADnVQ+F5VT72LzONEo79ksqaRj=c7mJDd_Ebb87767v01Nosw@mail.gmail.com>
In-Reply-To: <CAADnVQ+F5VT72LzONEo79ksqaRj=c7mJDd_Ebb87767v01Nosw@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Mon, 10 Jul 2023 23:19:14 -0400
Message-ID: <CADx9qWgmYu_LVVFtR0R7pcqM_270kQFzvmiSZ-2Umn2pE6qn=g@mail.gmail.com>
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

On Mon, Jul 10, 2023 at 11:00=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 10, 2023 at 2:58=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wr=
ote:
> >
> > In the documentation of the eBPF ISA it is unspecified how integers are
> > represented. Specify that twos complement is used.
> >
> > Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
> > ---
> >  Documentation/bpf/instruction-set.rst | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/=
instruction-set.rst
> > index 751e657973f0..63dfcba5eb9a 100644
> > --- a/Documentation/bpf/instruction-set.rst
> > +++ b/Documentation/bpf/instruction-set.rst
> > @@ -173,6 +173,11 @@ BPF_ARSH  0xc0   sign extending dst >>=3D (src & m=
ask)
> >  BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ b=
elow)
> >  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > +eBPF supports 32- and 64-bit signed and unsigned integers. It does
> > +not support floating-point data types. All signed integers are represe=
nted in
> > +twos-complement format where the sign bit is stored in the most-signif=
icant
> > +bit.
>
> Could you point to another ISA document (like x86, arm, ...) that
> talks about signed and unsigned integers?

Thank you for the reply. I hope that this change is useful. I proposed
this change to mimic the documentation of "Numeric Data Types" in
Volume 1, Chapter 4 of "Intel=C2=AE 64 and IA-32 Architectures Software
Developer=E2=80=99s Manual" [1].

[1] https://www.intel.com/content/www/us/en/developer/articles/technical/in=
tel-sdm.html

