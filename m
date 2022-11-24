Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6961F637085
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 03:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiKXCiO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 21:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiKXCiM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 21:38:12 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28438167D0
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 18:38:11 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id e27so1179479ejc.12
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 18:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2c4WL5j7cEYDwlPHrscJ34hhzXm64WFyB5g7wJsN3Q=;
        b=mkDsGCZnVa7tlSaoq2dk4Wv4JM2V+w8RHHIKyaqvvylrdCGStq5bAOSE572mB65UkH
         2RWOpZQxTZ+3D5JDkc1fzOKbqCckuus2kKdbp9ZqxY94e6Sbkttsz39O2ScOjQo4k9BL
         I5HOAhJoaLwITMaEgdHn7465u15UnMP7EontmnrCaTjVW5i2cnNhl3kUarG1372N9hGd
         8gguLq89WqiirHNnVeBRUlR1ho2oguWmp3q7nY+oMIEiaD5Qe/uj0MLzh1iEEeYXiYVF
         lIcZP5cXZua9xNdK+65wuWDAgRaNXXJFczg/izJMDrZiJq/FNvzfvWtCOw4cfD8Jo6kE
         3xxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2c4WL5j7cEYDwlPHrscJ34hhzXm64WFyB5g7wJsN3Q=;
        b=LVu9rPTzSOuIxGKIVBEDvG9e6Kc9grYn/FCHZB8r03TdRJe+MscFGdqbTHpTp+qRwf
         u/mzw2H3FcpWmvyNY27qO92vCUWrdRkXvOU3p6F3ukjqeOSKAAKdtmudkJEVMNDQmQYD
         vZCf0HMiJw5f7x+ikpKYDM9BbtYa+diP9qow3eY4HBtkwAfWoJsed1lysp6f7mfctEmj
         HoxSdrQvqdyqeXJaLNPZB4KMUz5kZGN9bFOhGhcG5tiHZaEceiUOvcUwtytr6mKOmrXg
         86muf0TykuUU1z4gsv7VGVXrrJe/ndR0UVruHjQaUDE5xvukNpJFHYj6cLI6+l8n/fVF
         DD7Q==
X-Gm-Message-State: ANoB5pkya3sWyxYKPcStB05+wS80/LHqH6zXAmtaHofGAdWiy/2ONFJv
        I4HcoWfXD16ikAlNpCoClMZtjh/8jsFqc7uWWDg=
X-Google-Smtp-Source: AA0mqf4P1R0SdKvNLzk/UtvESXeJW0CJMK8GzMp1C4bDyircKsPD0JvL/DUK31mukjJAztBPggsPBEUoxLzcQhAWgAk=
X-Received: by 2002:a17:906:180e:b0:7a2:6d38:1085 with SMTP id
 v14-20020a170906180e00b007a26d381085mr10175923eje.114.1669257489576; Wed, 23
 Nov 2022 18:38:09 -0800 (PST)
MIME-Version: 1.0
References: <9cfc736f2b45422a50a21b90b94de04b19836682.camel@ericsson.com>
 <Y3d9mYrkWjrkJ9q2@krava> <HE1PR07MB3321F2F4C156BCA6EFD3A3DBBD099@HE1PR07MB3321.eurprd07.prod.outlook.com>
 <b529c3fa5946537f96430d679b9e8a4280f03e4b.camel@ericsson.com>
In-Reply-To: <b529c3fa5946537f96430d679b9e8a4280f03e4b.camel@ericsson.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 23 Nov 2022 18:37:57 -0800
Message-ID: <CAEf4Bza8c59wH05pRaBL2hHznFVs0_yWpVy1GHexURu3Ln-a=g@mail.gmail.com>
Subject: Re: Sv: Bad padding with bpftool btf dump .. format c
To:     =?UTF-8?Q?Per_Sundstr=C3=B6m_XP?= <per.xp.sundstrom@ericsson.com>
Cc:     "olsajiri@gmail.com" <olsajiri@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 9:26 AM Per Sundstr=C3=B6m XP
<per.xp.sundstrom@ericsson.com> wrote:
>
>
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vanilla =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > > struct foo {
> > >     struct {
> > >         int  aa;
> > >         char ab;
> > >     } a;
> > >     long   :64;
> > >     int    :4;
> > >     char   b;
> > >     short  c;
> > > };
> > > offsetof(struct foo, c)=3D18
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Custom =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > > struct foo {
> > >         long: 8;
> > >         long: 64;
> > >         long: 64;
> > >         char b;
> > >         short c;
> > > };
> >
> > so I guess the issue is that the first 'long: 8' is padded to full
> > long: 64 ?
> >
> > looks like btf_dump_emit_bit_padding did not take into accout the gap
> > on the
> > begining of the struct
> >
> > on the other hand you generated that header file from 'min_core_btf'
> > btf data,
> > which takes away all the unused fields.. it might not beeen
> > considered as a
> > use case before
> >
> > jirka
> >
>
> > That could be the case, but I think the 'emit_bit_padding()' will not
> > really have a
> > lot to do for the non sparse headers ..
> >   /Per
>
>
> Looks like something like this makes tings a lot better:

yep, this helps, though changes output with padding to more verbose
version, quite often unnecessarily. I need to thing a bit more on
this, but the way we currently calculate alignment of a type is not
always going to be correct. E.g., just because there is an int field,
doesn't mean that struct actually has 4-byte alignment.

We must take into account natural alignment, but also actual
alignment, which might be different due to __attribute__((packed)).

Either way, thanks for reporting!

>
> diff --git a/src/btf_dump.c b/src/btf_dump.c
> index 12f7039..a8bd52a 100644
> --- a/src/btf_dump.c
> +++ b/src/btf_dump.c
> @@ -881,13 +881,13 @@ static void btf_dump_emit_bit_padding(const
> struct btf_dump *d,
>                 const char *pad_type;
>                 int pad_bits;
>
> -               if (ptr_bits > 32 && off_diff > 32) {
> +               if (align > 4 && ptr_bits > 32 && off_diff > 32) {
>                         pad_type =3D "long";
>                         pad_bits =3D chip_away_bits(off_diff, ptr_bits);
> -               } else if (off_diff > 16) {
> +               } else if (align > 2 && off_diff > 16) {
>                         pad_type =3D "int";
>                         pad_bits =3D chip_away_bits(off_diff, 32);
> -               } else if (off_diff > 8) {
> +               } else if (align > 1 && off_diff > 8) {
>                         pad_type =3D "short";
>                         pad_bits =3D chip_away_bits(off_diff, 16);
>                 } else {
>   /Per
