Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF71C63CD5F
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 03:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiK3C3s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 21:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiK3C3r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 21:29:47 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3136A76B
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 18:29:46 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ud5so38170467ejc.4
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 18:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NpN8m2rGJOqcna6uXpvOIEGM/1jOUuz4XXUb9q5YuSQ=;
        b=bGn5mbyEsF0TpHbOddNHf9uwWncn0BKq7UgLCnmK1CUsfh5GL8Jm2MOaxSTur+UQjv
         UADsqEMHkae3RUdBBkTObY07Hucf5wdsHey8AvYft82lw/zp4PxUkpsF9HHFzxa9pYdr
         nTIxpxG2webVUBotZVgyex7BOIl0jy1GTe375bWWEu9UGicWk16tRtAwpCgvWvVUg3i/
         +nv5M3f4Fur8BIaZjJafTBwDsvekACY2MfNPosP3vbWSJzjPFQj03MalpfFMsqvr/Is4
         dNR3ynmBD1//Ye8UBXEpJJ4Q9AMhT2dgRL/iB3P0mVu6LDl2hHEOJ7j1RgtoqL5iZZ97
         UPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NpN8m2rGJOqcna6uXpvOIEGM/1jOUuz4XXUb9q5YuSQ=;
        b=DyUTnzjcklyN6IIM3CmbgbR9jqYqkkQCqwiOyS0JWgqCBLCqaRCfedeUxbwo3z/hRx
         r31RzWUktppsuUVunkh80E3I7jnfqb7q6iODCwThG9NAjy0+bByRGQjw60eUzsJ6A5Il
         kps0Ctg9TdM20o6jTOsXexyJuReLkG7f87D5xfstT8urf9lq3EW7vL8CkhqCWWyukqPf
         Hl9R7S3XHKU/6r3wFoZIZ98WlnsPfZZ9jPfKFieXdYzEK/GDe5rNWZnKATUbojnPM3x+
         jjSgC9hcf6BMKBdAvPB8Oug7gNvJym6S9yIs6ZBdRIJ21KNxVf1+g8ltvPhPIqHXCD7G
         zsdQ==
X-Gm-Message-State: ANoB5pkjD4nFWiibTDRz+2g/ze7NmaoZgDVhN56lJDRxxgxEfTIWl7K2
        /7syiwAfe7pzMwi+aV0+2tVMEUhsL4Y=
X-Google-Smtp-Source: AA0mqf6sfkHwo/IiDhCzdaCR1ceocbjjnkuUFyFbsXX521eWmKJJes2GbhFJZ/zIh0l+S9NAlD9UtA==
X-Received: by 2002:a17:906:2e82:b0:7ae:44b2:cb7f with SMTP id o2-20020a1709062e8200b007ae44b2cb7fmr35399113eji.437.1669775384484;
        Tue, 29 Nov 2022 18:29:44 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id z5-20020aa7cf85000000b0045d74aa401fsm83166edx.60.2022.11.29.18.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 18:29:44 -0800 (PST)
Message-ID: <a95d7cae1ba418bac8d024c2590c34849a73472a.camel@gmail.com>
Subject: Re: Sv: Bad padding with bpftool btf dump .. format c
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Per =?ISO-8859-1?Q?Sundstr=F6m?= XP 
        <per.xp.sundstrom@ericsson.com>,
        "olsajiri@gmail.com" <olsajiri@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Date:   Wed, 30 Nov 2022 04:29:43 +0200
In-Reply-To: <CAEf4BzZt0VCEf-PVK0=aKBzqHHS4EBDiRc0tA23rrC7_amnxDQ@mail.gmail.com>
References: <9cfc736f2b45422a50a21b90b94de04b19836682.camel@ericsson.com>
         <Y3d9mYrkWjrkJ9q2@krava>
         <HE1PR07MB3321F2F4C156BCA6EFD3A3DBBD099@HE1PR07MB3321.eurprd07.prod.outlook.com>
         <b529c3fa5946537f96430d679b9e8a4280f03e4b.camel@ericsson.com>
         <CAEf4Bza8c59wH05pRaBL2hHznFVs0_yWpVy1GHexURu3Ln-a=g@mail.gmail.com>
         <c4a265caf1653412ac88b8e6c56a694a0d50879c.camel@gmail.com>
         <CAEf4BzZt0VCEf-PVK0=aKBzqHHS4EBDiRc0tA23rrC7_amnxDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-11-29 at 16:27 -0800, Andrii Nakryiko wrote:
> On Tue, Nov 29, 2022 at 9:38 AM Eduard Zingerman <eddyz87@gmail.com> wrot=
e:
> >=20
> > On Wed, 2022-11-23 at 18:37 -0800, Andrii Nakryiko wrote:
> > > On Fri, Nov 18, 2022 at 9:26 AM Per Sundstr=C3=B6m XP
> > > <per.xp.sundstrom@ericsson.com> wrote:
> > > >=20
> > > >=20
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vanilla =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > > > > struct foo {
> > > > > >     struct {
> > > > > >         int  aa;
> > > > > >         char ab;
> > > > > >     } a;
> > > > > >     long   :64;
> > > > > >     int    :4;
> > > > > >     char   b;
> > > > > >     short  c;
> > > > > > };
> > > > > > offsetof(struct foo, c)=3D18
> > > > > >=20
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Custom =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > > > > struct foo {
> > > > > >         long: 8;
> > > > > >         long: 64;
> > > > > >         long: 64;
> > > > > >         char b;
> > > > > >         short c;
> > > > > > };
> > > > >=20
> > > > > so I guess the issue is that the first 'long: 8' is padded to ful=
l
> > > > > long: 64 ?
> > > > >=20
> > > > > looks like btf_dump_emit_bit_padding did not take into accout the=
 gap
> > > > > on the
> > > > > begining of the struct
> > > > >=20
> > > > > on the other hand you generated that header file from 'min_core_b=
tf'
> > > > > btf data,
> > > > > which takes away all the unused fields.. it might not beeen
> > > > > considered as a
> > > > > use case before
> > > > >=20
> > > > > jirka
> > > > >=20
> > > >=20
> > > > > That could be the case, but I think the 'emit_bit_padding()' will=
 not
> > > > > really have a
> > > > > lot to do for the non sparse headers ..
> > > > >   /Per
> > > >=20
> > > >=20
> > > > Looks like something like this makes tings a lot better:
> > >=20
> > > yep, this helps, though changes output with padding to more verbose
> > > version, quite often unnecessarily. I need to thing a bit more on
> > > this, but the way we currently calculate alignment of a type is not
> > > always going to be correct. E.g., just because there is an int field,
> > > doesn't mean that struct actually has 4-byte alignment.
> > >=20
> > > We must take into account natural alignment, but also actual
> > > alignment, which might be different due to __attribute__((packed)).
> > >=20
> > > Either way, thanks for reporting!
> >=20
> > Hi everyone,
> >=20
> > I think the fix is simpler:
> >=20
> > diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> > index deb2bc9a0a7b..23a00818854b 100644
> > --- a/tools/lib/bpf/btf_dump.c
> > +++ b/tools/lib/bpf/btf_dump.c
> > @@ -860,7 +860,7 @@ static bool btf_is_struct_packed(const struct btf *=
btf, __u32 id,
> >=20
> >  static int chip_away_bits(int total, int at_most)
> >  {
> > -       return total % at_most ? : at_most;
> > +       return total > at_most ? at_most : total;
> >  }
> >=20
> > It changes the order in which btf_dump_emit_bit_padding() prints field
> > sizes. Right now it returns the division remainder on a first call and
> > full 'at_most' values at subsequent calls. For this particular example
> > the bit offset of 'b' is 136, so the output looks as follows:
> >=20
> > struct foo {
> >         long: 8;    // first call pad_bits =3D 136 % 64 ? : 64; off_dif=
f -=3D 8;
> >         long: 64;   // second call pad_bits =3D 128 % 64 ? : 64; off_di=
ff -=3D 64; ...
> >         long: 64;
> >         char b;
> >         short c;
> > };
> >=20
> > This is incorrect, because compiler would always add padding between
> > the first and second members to account for the second member alignment=
.
> >=20
> > However, my change inverts the order, which avoids the accidental
> > padding and gets the desired output:
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Custom =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > struct foo {
> >         long: 64;
> >         long: 64;
> >         char: 8;
> >         char b;
> >         short c;
> > };
> > offsetof(struct foo, c)=3D18
> >=20
> > =3D=3D=3D BTF offsets =3D=3D=3D
> > full   :        'c' type_id=3D6 bits_offset=3D144
> > custom :        'c' type_id=3D3 bits_offset=3D144
> >=20
> > wdyt?
>=20
> There were at least two issues I realized when I was thinking about
> fixing this, and I think you are missing at least one of them.
>=20
> 1. Adding `long :xxx` as padding makes struct at least 8-byte aligned.
> If the struct originally had a smaller alignment requirement, you are
> now potentially breaking the struct layout by changing its layout.
>
> 2. The way btf__align_of() is calculating alignment doesn't work
> correctly for __attribute__((packed)) structs.

Missed these point, sorry.
On the other hand isn't this information lost in the custom.btf?

$ bpftool btf dump file custom.btf
[1] STRUCT 'foo' size=3D20 vlen=3D2
	'b' type_id=3D2 bits_offset=3D136
	'c' type_id=3D3 bits_offset=3D144
[2] INT 'char' size=3D1 bits_offset=3D0 nr_bits=3D8 encoding=3DSIGNED
[3] INT 'short' size=3D2 bits_offset=3D0 nr_bits=3D16 encoding=3DSIGNED

This has no info that 'foo' had fields of size 'long'. It does not
matter for structs used inside BTF because 'bits_offset' is specified
everywhere, but would matter if STRUCT 'foo' is used as a member of a
non-BTF struct.

>=20
> So we need to fix btf__align_of() first. What btf__align_of() is
> calculating right now is a natural alignment requirement if we ignore
> actual field offsets. This might be useful (at the very least to
> determine if the struct is packed or not), so maybe we should have a
> separate btf__natural_align_of() or something along those lines?
>=20
> And then we need to fix btf_dump_emit_bit_padding() to better handle
> alignment and padding rules. This is what Per Sundstr=C3=B6m is trying to
> do, I believe, but I haven't carefully thought about his latest code
> suggestion.
>=20
> In general, the most obvious solution would be to pad with `char :8;`
> everywhere, but that's very ugly and I'd prefer us to have as
> "natural" output as possible. That is, only emit strictly necessary
> padding fields and rely on natural alignment otherwise.
>=20
> >=20
> >=20
> > >=20
> > > >=20
> > > > diff --git a/src/btf_dump.c b/src/btf_dump.c
> > > > index 12f7039..a8bd52a 100644
> > > > --- a/src/btf_dump.c
> > > > +++ b/src/btf_dump.c
> > > > @@ -881,13 +881,13 @@ static void btf_dump_emit_bit_padding(const
> > > > struct btf_dump *d,
> > > >                 const char *pad_type;
> > > >                 int pad_bits;
> > > >=20
> > > > -               if (ptr_bits > 32 && off_diff > 32) {
> > > > +               if (align > 4 && ptr_bits > 32 && off_diff > 32) {
> > > >                         pad_type =3D "long";
> > > >                         pad_bits =3D chip_away_bits(off_diff, ptr_b=
its);
> > > > -               } else if (off_diff > 16) {
> > > > +               } else if (align > 2 && off_diff > 16) {
> > > >                         pad_type =3D "int";
> > > >                         pad_bits =3D chip_away_bits(off_diff, 32);
> > > > -               } else if (off_diff > 8) {
> > > > +               } else if (align > 1 && off_diff > 8) {
> > > >                         pad_type =3D "short";
> > > >                         pad_bits =3D chip_away_bits(off_diff, 16);
> > > >                 } else {
> > > >   /Per
> >=20

