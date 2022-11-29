Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F21663C681
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 18:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiK2RiK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 12:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbiK2RiJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 12:38:09 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AF324956
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 09:38:06 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id vv4so35617130ejc.2
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 09:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oIY9wEM3y4D4kuvUCCjNNGmugehRhnNWxGsBXZ1sfKk=;
        b=EvTdsE+wGgym6EPDGdA90HYvvoCyQmXmgm1PvvC3oCBvdsQ8PsJtlhI+jOgKp0Z6WK
         au5hI5qYgZSIpbGUZmVFDIHewx7vQhlwWkczUI+F3S1D5fhwrN+pGVeYMgEFs4wdXFTJ
         QkFnTA7T9OzUZp4ar+cEsTBjY7czIhG4vZsE/Ju41QutxuJbeSyN/NF/uvYvDQqUnMn2
         mVoL5VlHzZVTCvBahbp6nYMAtz9UW86hsAMCUtlC9rTXGBsatpS9xMatD6sqjxBudSG5
         5+eXtjvcHGqjwK1eKBcA18AAIt0Kkj76oDFe7vMqCDD6ByoPNHO9acDMzq9qvDMj8dAr
         lXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oIY9wEM3y4D4kuvUCCjNNGmugehRhnNWxGsBXZ1sfKk=;
        b=woCjagrvCTBWg7qhUesMzchZcIRDGOt4p5m7pMGwZoG45/+UUM54/KMq9wdScsd739
         Q1S7Y/dMonC4IIFm/YsrWmz2vEO7VYtzsHGdeoo35RKDOqrbTF2iYrh5dmA/n8jfTsDO
         WasowHn0RmV2YVWkD8iAfzauf5rnobtftteG2TnlRY7ZnwsC1Lxr6v1Q5PPkoz/wUI5g
         MLKt8R+tHt94/diHNUYGs28JNPsqla/sqJziMdMGsDSOVsGBPu2gk3joUHhbkU+KaP/7
         Fo6+J1uf+QPiPObcXBLZimHH1+L2Kva/drfUCIvHEoqie7oKIUQFTBT8EKsHN1DCvz7J
         LYlw==
X-Gm-Message-State: ANoB5pmPJ7FDJa5spxwKZoblfZEyBkCXXaL+Mc0t5g3CAuV93A1Vsevy
        R6JmIN7g7S/RLbz9m/6pEmM=
X-Google-Smtp-Source: AA0mqf6s8YoMyLZMHbIIoPDpfyKaXxNQJIua2LATVTO+yHymUu1VkNgqx04kLoQIrCXEtn/mxhTHrw==
X-Received: by 2002:a17:906:1585:b0:7ad:84c7:502d with SMTP id k5-20020a170906158500b007ad84c7502dmr34964228ejd.177.1669743484736;
        Tue, 29 Nov 2022 09:38:04 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b007ade5cc6e7asm5605248eja.39.2022.11.29.09.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 09:38:04 -0800 (PST)
Message-ID: <c4a265caf1653412ac88b8e6c56a694a0d50879c.camel@gmail.com>
Subject: Re: Sv: Bad padding with bpftool btf dump .. format c
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Per =?ISO-8859-1?Q?Sundstr=F6m?= XP 
        <per.xp.sundstrom@ericsson.com>
Cc:     "olsajiri@gmail.com" <olsajiri@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Date:   Tue, 29 Nov 2022 19:38:03 +0200
In-Reply-To: <CAEf4Bza8c59wH05pRaBL2hHznFVs0_yWpVy1GHexURu3Ln-a=g@mail.gmail.com>
References: <9cfc736f2b45422a50a21b90b94de04b19836682.camel@ericsson.com>
         <Y3d9mYrkWjrkJ9q2@krava>
         <HE1PR07MB3321F2F4C156BCA6EFD3A3DBBD099@HE1PR07MB3321.eurprd07.prod.outlook.com>
         <b529c3fa5946537f96430d679b9e8a4280f03e4b.camel@ericsson.com>
         <CAEf4Bza8c59wH05pRaBL2hHznFVs0_yWpVy1GHexURu3Ln-a=g@mail.gmail.com>
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

On Wed, 2022-11-23 at 18:37 -0800, Andrii Nakryiko wrote:
> On Fri, Nov 18, 2022 at 9:26 AM Per Sundstr=C3=B6m XP
> <per.xp.sundstrom@ericsson.com> wrote:
> >=20
> >=20
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vanilla =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > struct foo {
> > > >     struct {
> > > >         int  aa;
> > > >         char ab;
> > > >     } a;
> > > >     long   :64;
> > > >     int    :4;
> > > >     char   b;
> > > >     short  c;
> > > > };
> > > > offsetof(struct foo, c)=3D18
> > > >=20
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Custom =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > struct foo {
> > > >         long: 8;
> > > >         long: 64;
> > > >         long: 64;
> > > >         char b;
> > > >         short c;
> > > > };
> > >=20
> > > so I guess the issue is that the first 'long: 8' is padded to full
> > > long: 64 ?
> > >=20
> > > looks like btf_dump_emit_bit_padding did not take into accout the gap
> > > on the
> > > begining of the struct
> > >=20
> > > on the other hand you generated that header file from 'min_core_btf'
> > > btf data,
> > > which takes away all the unused fields.. it might not beeen
> > > considered as a
> > > use case before
> > >=20
> > > jirka
> > >=20
> >=20
> > > That could be the case, but I think the 'emit_bit_padding()' will not
> > > really have a
> > > lot to do for the non sparse headers ..
> > >   /Per
> >=20
> >=20
> > Looks like something like this makes tings a lot better:
>=20
> yep, this helps, though changes output with padding to more verbose
> version, quite often unnecessarily. I need to thing a bit more on
> this, but the way we currently calculate alignment of a type is not
> always going to be correct. E.g., just because there is an int field,
> doesn't mean that struct actually has 4-byte alignment.
>=20
> We must take into account natural alignment, but also actual
> alignment, which might be different due to __attribute__((packed)).
>=20
> Either way, thanks for reporting!

Hi everyone,

I think the fix is simpler:

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index deb2bc9a0a7b..23a00818854b 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -860,7 +860,7 @@ static bool btf_is_struct_packed(const struct btf *btf,=
 __u32 id,
=20
 static int chip_away_bits(int total, int at_most)
 {
-	return total % at_most ? : at_most;
+	return total > at_most ? at_most : total;
 }

It changes the order in which btf_dump_emit_bit_padding() prints field
sizes. Right now it returns the division remainder on a first call and
full 'at_most' values at subsequent calls. For this particular example
the bit offset of 'b' is 136, so the output looks as follows:

struct foo {
	long: 8;    // first call pad_bits =3D 136 % 64 ? : 64; off_diff -=3D 8;
	long: 64;   // second call pad_bits =3D 128 % 64 ? : 64; off_diff -=3D 64;=
 ...
	long: 64;
	char b;
	short c;
};

This is incorrect, because compiler would always add padding between
the first and second members to account for the second member alignment.

However, my change inverts the order, which avoids the accidental
padding and gets the desired output:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Custom =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
struct foo {
	long: 64;
	long: 64;
	char: 8;
	char b;
	short c;
};
offsetof(struct foo, c)=3D18

=3D=3D=3D BTF offsets =3D=3D=3D
full   : 	'c' type_id=3D6 bits_offset=3D144
custom : 	'c' type_id=3D3 bits_offset=3D144

wdyt?


>=20
> >=20
> > diff --git a/src/btf_dump.c b/src/btf_dump.c
> > index 12f7039..a8bd52a 100644
> > --- a/src/btf_dump.c
> > +++ b/src/btf_dump.c
> > @@ -881,13 +881,13 @@ static void btf_dump_emit_bit_padding(const
> > struct btf_dump *d,
> >                 const char *pad_type;
> >                 int pad_bits;
> >=20
> > -               if (ptr_bits > 32 && off_diff > 32) {
> > +               if (align > 4 && ptr_bits > 32 && off_diff > 32) {
> >                         pad_type =3D "long";
> >                         pad_bits =3D chip_away_bits(off_diff, ptr_bits)=
;
> > -               } else if (off_diff > 16) {
> > +               } else if (align > 2 && off_diff > 16) {
> >                         pad_type =3D "int";
> >                         pad_bits =3D chip_away_bits(off_diff, 32);
> > -               } else if (off_diff > 8) {
> > +               } else if (align > 1 && off_diff > 8) {
> >                         pad_type =3D "short";
> >                         pad_bits =3D chip_away_bits(off_diff, 16);
> >                 } else {
> >   /Per

