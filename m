Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7F963CC7E
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 01:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiK3A1V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 19:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiK3A1R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 19:27:17 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448D36DCF3
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 16:27:16 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z20so21996309edc.13
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 16:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kcLmdyWPz4HDlDl+dcOQM64LaNWRLhz5Cue7G7DCLQ=;
        b=AsBhk6A3U1jIbV3dWfVsgXG8WCcOMLSIyrN4DoopG2yJ3dSyTgEZE9bt48/4Tn7iS9
         mscIzJl0IgU88/xpWjAHhdQcB4BInbrHmZ9kM7AUEgG1ccSzew4lhGD9v4HpBNQzPAmd
         +DSClR9YJ9BBVYE/XYAc3Z/gkNk7hm8uvJj/FT8ga4NyAPUUbK3IDznJZlIJ0GH2MdEB
         jjoA02g2E/lqh71tnEwvAUez4AknK/4UDZYnkRehOPHWr2YlfHuuIEU/qbVq/eKM+1an
         JZCPtOOIF6n6FGM7TfcPHSrZm9xvyeKNRXTxMxvBFEwPGAWrlir1zdjPKZzM4qEw/pX5
         RnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kcLmdyWPz4HDlDl+dcOQM64LaNWRLhz5Cue7G7DCLQ=;
        b=EOjfrTFmAqqFEd4tSlGZjLpPijvhDJwcQADfYSQDjshH4qWighIzU6ZYx1SQeYOxQk
         6t4rHvwa12i/awivcp0BojtDZ3lL6srQR9zts95PgopQJsHYie46p4A0IeiBIPrhby8j
         eXWgta8nFxM9UqrS7w++e7uW6JGVFO+0GFNqJzWty0abuMijZ/BQiMq7FdGPHz5d0DqU
         4xd//KmG8rqUPqAdmney2WjYgbb2WhjQHDZ9nw3ec74DsMDq8zIpZbNxqPBoWtBL8LV7
         MfwZE6dAAAGzqL/X9QSVlhoUwB95JEl4KoaDxsh9xK7qRvM6Z0QsGNWjibVU0oeeJNWe
         1WAw==
X-Gm-Message-State: ANoB5pnVp7iudU/ILP1rcM7ZzYMmY8o2+MZVu3eEUdf1bC8+1NDkw1IQ
        dtvneLwo8aqAVo8uGbTDFB0QedJ2tHIWU6wOJ44BnT4bYSI=
X-Google-Smtp-Source: AA0mqf5vNtUukeSYOu4INlAYqadNSY6LcmXyQ4GrDahG8SjwvdRDiL2RN3+Fr3LhTTFHpPPR0ip9IxTnS1XFdwIu8aI=
X-Received: by 2002:a05:6402:4008:b0:458:dd63:e339 with SMTP id
 d8-20020a056402400800b00458dd63e339mr35255379eda.81.1669768034621; Tue, 29
 Nov 2022 16:27:14 -0800 (PST)
MIME-Version: 1.0
References: <9cfc736f2b45422a50a21b90b94de04b19836682.camel@ericsson.com>
 <Y3d9mYrkWjrkJ9q2@krava> <HE1PR07MB3321F2F4C156BCA6EFD3A3DBBD099@HE1PR07MB3321.eurprd07.prod.outlook.com>
 <b529c3fa5946537f96430d679b9e8a4280f03e4b.camel@ericsson.com>
 <CAEf4Bza8c59wH05pRaBL2hHznFVs0_yWpVy1GHexURu3Ln-a=g@mail.gmail.com> <c4a265caf1653412ac88b8e6c56a694a0d50879c.camel@gmail.com>
In-Reply-To: <c4a265caf1653412ac88b8e6c56a694a0d50879c.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 29 Nov 2022 16:27:02 -0800
Message-ID: <CAEf4BzZt0VCEf-PVK0=aKBzqHHS4EBDiRc0tA23rrC7_amnxDQ@mail.gmail.com>
Subject: Re: Sv: Bad padding with bpftool btf dump .. format c
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     =?UTF-8?Q?Per_Sundstr=C3=B6m_XP?= <per.xp.sundstrom@ericsson.com>,
        "olsajiri@gmail.com" <olsajiri@gmail.com>,
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

On Tue, Nov 29, 2022 at 9:38 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2022-11-23 at 18:37 -0800, Andrii Nakryiko wrote:
> > On Fri, Nov 18, 2022 at 9:26 AM Per Sundstr=C3=B6m XP
> > <per.xp.sundstrom@ericsson.com> wrote:
> > >
> > >
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vanilla =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > > > struct foo {
> > > > >     struct {
> > > > >         int  aa;
> > > > >         char ab;
> > > > >     } a;
> > > > >     long   :64;
> > > > >     int    :4;
> > > > >     char   b;
> > > > >     short  c;
> > > > > };
> > > > > offsetof(struct foo, c)=3D18
> > > > >
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Custom =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > > struct foo {
> > > > >         long: 8;
> > > > >         long: 64;
> > > > >         long: 64;
> > > > >         char b;
> > > > >         short c;
> > > > > };
> > > >
> > > > so I guess the issue is that the first 'long: 8' is padded to full
> > > > long: 64 ?
> > > >
> > > > looks like btf_dump_emit_bit_padding did not take into accout the g=
ap
> > > > on the
> > > > begining of the struct
> > > >
> > > > on the other hand you generated that header file from 'min_core_btf=
'
> > > > btf data,
> > > > which takes away all the unused fields.. it might not beeen
> > > > considered as a
> > > > use case before
> > > >
> > > > jirka
> > > >
> > >
> > > > That could be the case, but I think the 'emit_bit_padding()' will n=
ot
> > > > really have a
> > > > lot to do for the non sparse headers ..
> > > >   /Per
> > >
> > >
> > > Looks like something like this makes tings a lot better:
> >
> > yep, this helps, though changes output with padding to more verbose
> > version, quite often unnecessarily. I need to thing a bit more on
> > this, but the way we currently calculate alignment of a type is not
> > always going to be correct. E.g., just because there is an int field,
> > doesn't mean that struct actually has 4-byte alignment.
> >
> > We must take into account natural alignment, but also actual
> > alignment, which might be different due to __attribute__((packed)).
> >
> > Either way, thanks for reporting!
>
> Hi everyone,
>
> I think the fix is simpler:
>
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index deb2bc9a0a7b..23a00818854b 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -860,7 +860,7 @@ static bool btf_is_struct_packed(const struct btf *bt=
f, __u32 id,
>
>  static int chip_away_bits(int total, int at_most)
>  {
> -       return total % at_most ? : at_most;
> +       return total > at_most ? at_most : total;
>  }
>
> It changes the order in which btf_dump_emit_bit_padding() prints field
> sizes. Right now it returns the division remainder on a first call and
> full 'at_most' values at subsequent calls. For this particular example
> the bit offset of 'b' is 136, so the output looks as follows:
>
> struct foo {
>         long: 8;    // first call pad_bits =3D 136 % 64 ? : 64; off_diff =
-=3D 8;
>         long: 64;   // second call pad_bits =3D 128 % 64 ? : 64; off_diff=
 -=3D 64; ...
>         long: 64;
>         char b;
>         short c;
> };
>
> This is incorrect, because compiler would always add padding between
> the first and second members to account for the second member alignment.
>
> However, my change inverts the order, which avoids the accidental
> padding and gets the desired output:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Custom =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> struct foo {
>         long: 64;
>         long: 64;
>         char: 8;
>         char b;
>         short c;
> };
> offsetof(struct foo, c)=3D18
>
> =3D=3D=3D BTF offsets =3D=3D=3D
> full   :        'c' type_id=3D6 bits_offset=3D144
> custom :        'c' type_id=3D3 bits_offset=3D144
>
> wdyt?

There were at least two issues I realized when I was thinking about
fixing this, and I think you are missing at least one of them.

1. Adding `long :xxx` as padding makes struct at least 8-byte aligned.
If the struct originally had a smaller alignment requirement, you are
now potentially breaking the struct layout by changing its layout.

2. The way btf__align_of() is calculating alignment doesn't work
correctly for __attribute__((packed)) structs.

So we need to fix btf__align_of() first. What btf__align_of() is
calculating right now is a natural alignment requirement if we ignore
actual field offsets. This might be useful (at the very least to
determine if the struct is packed or not), so maybe we should have a
separate btf__natural_align_of() or something along those lines?

And then we need to fix btf_dump_emit_bit_padding() to better handle
alignment and padding rules. This is what Per Sundstr=C3=B6m is trying to
do, I believe, but I haven't carefully thought about his latest code
suggestion.

In general, the most obvious solution would be to pad with `char :8;`
everywhere, but that's very ugly and I'd prefer us to have as
"natural" output as possible. That is, only emit strictly necessary
padding fields and rely on natural alignment otherwise.

>
>
> >
> > >
> > > diff --git a/src/btf_dump.c b/src/btf_dump.c
> > > index 12f7039..a8bd52a 100644
> > > --- a/src/btf_dump.c
> > > +++ b/src/btf_dump.c
> > > @@ -881,13 +881,13 @@ static void btf_dump_emit_bit_padding(const
> > > struct btf_dump *d,
> > >                 const char *pad_type;
> > >                 int pad_bits;
> > >
> > > -               if (ptr_bits > 32 && off_diff > 32) {
> > > +               if (align > 4 && ptr_bits > 32 && off_diff > 32) {
> > >                         pad_type =3D "long";
> > >                         pad_bits =3D chip_away_bits(off_diff, ptr_bit=
s);
> > > -               } else if (off_diff > 16) {
> > > +               } else if (align > 2 && off_diff > 16) {
> > >                         pad_type =3D "int";
> > >                         pad_bits =3D chip_away_bits(off_diff, 32);
> > > -               } else if (off_diff > 8) {
> > > +               } else if (align > 1 && off_diff > 8) {
> > >                         pad_type =3D "short";
> > >                         pad_bits =3D chip_away_bits(off_diff, 16);
> > >                 } else {
> > >   /Per
>
