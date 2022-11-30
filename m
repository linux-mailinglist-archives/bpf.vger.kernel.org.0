Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D6463E440
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 00:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiK3XGu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 18:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiK3XGn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 18:06:43 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3A5950F0
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 15:06:42 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id n20so289049ejh.0
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 15:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LiUbmD61bzehkF//XnQfTsLtBhkMvuVHEAD+XXRv+G4=;
        b=CRkldKt3pZKNIp6q4ImV+LsseItge2RU2r+qU0eBhKdA2f231QdYigqaE9L+I7De0h
         KG4ZKJgd9WzxbiIKTW6jPWmpEk/EXCOZKqQBKiHZSiQDmPQqL/Wq0kTvDFT0NIFsdaYN
         xITms19f/0Er78EBkgMVcxh/LZ4sOE4LbH2qpCvPLy4mUTs4lzI6m10oNcjwRBb5T2HL
         +FXFBTR27fP4x+gc2Y4p2QXKbaC/IeRzLdgP14hd7APTBJzaF4nRHgNt2DabJdpvqIYe
         xkHeTbvPPdC4u6EoggzF96W3PHbTeP98hpnulY19xeUBcoJ/xmyiWSP414cuY31/kH1m
         7FPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LiUbmD61bzehkF//XnQfTsLtBhkMvuVHEAD+XXRv+G4=;
        b=abWgoi4/YQsLsyRB4fSMoS1t7eSmuI4ktK5ww1t7imzLvG67Ypw+sGefNXAR7Ps2qv
         evZoetW8IBbhXVRX/4SV4oEB/aEH5rceAZELP5NyzyOWOvz0x9JBtcIsPj7xjMVxsg/e
         J2n4dm8RXutEoXeoOVLinmdef8vR0kxufA6Igj0ajnR4y+J0tIcIretBwl9QjAsVygQD
         bpg58YxEsPWfzBNuUiwKaM9SI0gXZTmLYkTeNtorrFCW2Kq/LNHUSDF2NMtMjH+0+sVY
         bwPOKBnKJu7r8S35nMQ7oQpLH6aPW3O3TRGSLhxv66Ip+s/LrX77L1tOv3BP5Ogr7HiT
         19KQ==
X-Gm-Message-State: ANoB5pnr0xRZ0hfeVRRY0IP0Rn4ZlaNfdvLF5MdWX+P74L4DWzqzQWNw
        QKwx880wLbGS1On9qCyzMvM=
X-Google-Smtp-Source: AA0mqf7gAPGw+jtPMdZGOVGTYGs/PRFm5BTiDOvvz5vmgkEC+cepEAtMlTTJInxuPqdOdVcoGqZOeQ==
X-Received: by 2002:a17:906:38cd:b0:7be:4d3c:1a44 with SMTP id r13-20020a17090638cd00b007be4d3c1a44mr18822016ejd.543.1669849600906;
        Wed, 30 Nov 2022 15:06:40 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id cq3-20020a056402220300b00463597d2c25sm1089148edb.74.2022.11.30.15.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 15:06:40 -0800 (PST)
Message-ID: <02cbc397cf2ed051bf3f79bbe8e1be07fadb3f10.camel@gmail.com>
Subject: Re: Sv: Bad padding with bpftool btf dump .. format c
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Per =?ISO-8859-1?Q?Sundstr=F6m?= XP 
        <per.xp.sundstrom@ericsson.com>,
        "olsajiri@gmail.com" <olsajiri@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Date:   Thu, 01 Dec 2022 01:06:39 +0200
In-Reply-To: <CAEf4BzbsxV63=-wET7eXS-He3eKkWnHtokzCak59ctztGn4kqQ@mail.gmail.com>
References: <9cfc736f2b45422a50a21b90b94de04b19836682.camel@ericsson.com>
         <Y3d9mYrkWjrkJ9q2@krava>
         <HE1PR07MB3321F2F4C156BCA6EFD3A3DBBD099@HE1PR07MB3321.eurprd07.prod.outlook.com>
         <b529c3fa5946537f96430d679b9e8a4280f03e4b.camel@ericsson.com>
         <CAEf4Bza8c59wH05pRaBL2hHznFVs0_yWpVy1GHexURu3Ln-a=g@mail.gmail.com>
         <c4a265caf1653412ac88b8e6c56a694a0d50879c.camel@gmail.com>
         <CAEf4BzZt0VCEf-PVK0=aKBzqHHS4EBDiRc0tA23rrC7_amnxDQ@mail.gmail.com>
         <a95d7cae1ba418bac8d024c2590c34849a73472a.camel@gmail.com>
         <CAEf4BzbsxV63=-wET7eXS-He3eKkWnHtokzCak59ctztGn4kqQ@mail.gmail.com>
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

On Wed, 2022-11-30 at 14:49 -0800, Andrii Nakryiko wrote:
> On Tue, Nov 29, 2022 at 6:29 PM Eduard Zingerman <eddyz87@gmail.com> wrot=
e:
> >=20
> > On Tue, 2022-11-29 at 16:27 -0800, Andrii Nakryiko wrote:
> > > On Tue, Nov 29, 2022 at 9:38 AM Eduard Zingerman <eddyz87@gmail.com> =
wrote:
> > > >=20
> > > > On Wed, 2022-11-23 at 18:37 -0800, Andrii Nakryiko wrote:
> > > > > On Fri, Nov 18, 2022 at 9:26 AM Per Sundstr=C3=B6m XP
> > > > > <per.xp.sundstrom@ericsson.com> wrote:
> > > > > >=20
> > > > > >=20
> > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vanilla =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > > > > > struct foo {
> > > > > > > >     struct {
> > > > > > > >         int  aa;
> > > > > > > >         char ab;
> > > > > > > >     } a;
> > > > > > > >     long   :64;
> > > > > > > >     int    :4;
> > > > > > > >     char   b;
> > > > > > > >     short  c;
> > > > > > > > };
> > > > > > > > offsetof(struct foo, c)=3D18
> > > > > > > >=20
> > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Custom =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > > > > > struct foo {
> > > > > > > >         long: 8;
> > > > > > > >         long: 64;
> > > > > > > >         long: 64;
> > > > > > > >         char b;
> > > > > > > >         short c;
> > > > > > > > };
> > > > > > >=20
> > > > > > > so I guess the issue is that the first 'long: 8' is padded to=
 full
> > > > > > > long: 64 ?
> > > > > > >=20
> > > > > > > looks like btf_dump_emit_bit_padding did not take into accout=
 the gap
> > > > > > > on the
> > > > > > > begining of the struct
> > > > > > >=20
> > > > > > > on the other hand you generated that header file from 'min_co=
re_btf'
> > > > > > > btf data,
> > > > > > > which takes away all the unused fields.. it might not beeen
> > > > > > > considered as a
> > > > > > > use case before
> > > > > > >=20
> > > > > > > jirka
> > > > > > >=20
> > > > > >=20
> > > > > > > That could be the case, but I think the 'emit_bit_padding()' =
will not
> > > > > > > really have a
> > > > > > > lot to do for the non sparse headers ..
> > > > > > >   /Per
> > > > > >=20
> > > > > >=20
> > > > > > Looks like something like this makes tings a lot better:
> > > > >=20
> > > > > yep, this helps, though changes output with padding to more verbo=
se
> > > > > version, quite often unnecessarily. I need to thing a bit more on
> > > > > this, but the way we currently calculate alignment of a type is n=
ot
> > > > > always going to be correct. E.g., just because there is an int fi=
eld,
> > > > > doesn't mean that struct actually has 4-byte alignment.
> > > > >=20
> > > > > We must take into account natural alignment, but also actual
> > > > > alignment, which might be different due to __attribute__((packed)=
).
> > > > >=20
> > > > > Either way, thanks for reporting!
> > > >=20
> > > > Hi everyone,
> > > >=20
> > > > I think the fix is simpler:
> > > >=20
> > > > diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> > > > index deb2bc9a0a7b..23a00818854b 100644
> > > > --- a/tools/lib/bpf/btf_dump.c
> > > > +++ b/tools/lib/bpf/btf_dump.c
> > > > @@ -860,7 +860,7 @@ static bool btf_is_struct_packed(const struct b=
tf *btf, __u32 id,
> > > >=20
> > > >  static int chip_away_bits(int total, int at_most)
> > > >  {
> > > > -       return total % at_most ? : at_most;
> > > > +       return total > at_most ? at_most : total;
> > > >  }
> > > >=20
> > > > It changes the order in which btf_dump_emit_bit_padding() prints fi=
eld
> > > > sizes. Right now it returns the division remainder on a first call =
and
> > > > full 'at_most' values at subsequent calls. For this particular exam=
ple
> > > > the bit offset of 'b' is 136, so the output looks as follows:
> > > >=20
> > > > struct foo {
> > > >         long: 8;    // first call pad_bits =3D 136 % 64 ? : 64; off=
_diff -=3D 8;
> > > >         long: 64;   // second call pad_bits =3D 128 % 64 ? : 64; of=
f_diff -=3D 64; ...
> > > >         long: 64;
> > > >         char b;
> > > >         short c;
> > > > };
> > > >=20
> > > > This is incorrect, because compiler would always add padding betwee=
n
> > > > the first and second members to account for the second member align=
ment.
> > > >=20
> > > > However, my change inverts the order, which avoids the accidental
> > > > padding and gets the desired output:
> > > >=20
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Custom =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > struct foo {
> > > >         long: 64;
> > > >         long: 64;
> > > >         char: 8;
> > > >         char b;
> > > >         short c;
> > > > };
> > > > offsetof(struct foo, c)=3D18
> > > >=20
> > > > =3D=3D=3D BTF offsets =3D=3D=3D
> > > > full   :        'c' type_id=3D6 bits_offset=3D144
> > > > custom :        'c' type_id=3D3 bits_offset=3D144
> > > >=20
> > > > wdyt?
> > >=20
> > > There were at least two issues I realized when I was thinking about
> > > fixing this, and I think you are missing at least one of them.
> > >=20
> > > 1. Adding `long :xxx` as padding makes struct at least 8-byte aligned=
.
> > > If the struct originally had a smaller alignment requirement, you are
> > > now potentially breaking the struct layout by changing its layout.
> > >=20
> > > 2. The way btf__align_of() is calculating alignment doesn't work
> > > correctly for __attribute__((packed)) structs.
> >=20
> > Missed these point, sorry.
> > On the other hand isn't this information lost in the custom.btf?
> >=20
> > $ bpftool btf dump file custom.btf
> > [1] STRUCT 'foo' size=3D20 vlen=3D2
> >         'b' type_id=3D2 bits_offset=3D136
> >         'c' type_id=3D3 bits_offset=3D144
> > [2] INT 'char' size=3D1 bits_offset=3D0 nr_bits=3D8 encoding=3DSIGNED
> > [3] INT 'short' size=3D2 bits_offset=3D0 nr_bits=3D16 encoding=3DSIGNED
> >=20
> > This has no info that 'foo' had fields of size 'long'. It does not
> > matter for structs used inside BTF because 'bits_offset' is specified
> > everywhere, but would matter if STRUCT 'foo' is used as a member of a
> > non-BTF struct.
>=20
> Yes, the latter is important, though, right?

Do you want to do anything about this at the custom BTF creation stage?
E.g. leave one real member / create a synthetic member to force a specific
struct alignment in the minimized version.

> So I think ideally we determine "maximum allowable alignment" and use
> that to determine what's the allowable set of padding types is. WDYT?

Yes, I agree.
I think that a change in the btf__align_of() should be minimal, just check
if structure is packed and if so return 1, otherwise logic should remain
unchanged, this would match what LLVM does ([1]).
Also the flip of the order of chip_away_bits() should remain.

[1] https://github.com/eddyz87/llvm-project/blob/main/llvm/lib/IR/DataLayou=
t.cpp#L764
>=20
> >=20
> > >=20
> > > So we need to fix btf__align_of() first. What btf__align_of() is
> > > calculating right now is a natural alignment requirement if we ignore
> > > actual field offsets. This might be useful (at the very least to
> > > determine if the struct is packed or not), so maybe we should have a
> > > separate btf__natural_align_of() or something along those lines?
> > >=20
> > > And then we need to fix btf_dump_emit_bit_padding() to better handle
> > > alignment and padding rules. This is what Per Sundstr=C3=B6m is tryin=
g to
> > > do, I believe, but I haven't carefully thought about his latest code
> > > suggestion.
> > >=20
> > > In general, the most obvious solution would be to pad with `char :8;`
> > > everywhere, but that's very ugly and I'd prefer us to have as
> > > "natural" output as possible. That is, only emit strictly necessary
> > > padding fields and rely on natural alignment otherwise.
> > >=20
> > > >=20
> > > >=20
> > > > >=20
> > > > > >=20
> > > > > > diff --git a/src/btf_dump.c b/src/btf_dump.c
> > > > > > index 12f7039..a8bd52a 100644
> > > > > > --- a/src/btf_dump.c
> > > > > > +++ b/src/btf_dump.c
> > > > > > @@ -881,13 +881,13 @@ static void btf_dump_emit_bit_padding(con=
st
> > > > > > struct btf_dump *d,
> > > > > >                 const char *pad_type;
> > > > > >                 int pad_bits;
> > > > > >=20
> > > > > > -               if (ptr_bits > 32 && off_diff > 32) {
> > > > > > +               if (align > 4 && ptr_bits > 32 && off_diff > 32=
) {
> > > > > >                         pad_type =3D "long";
> > > > > >                         pad_bits =3D chip_away_bits(off_diff, p=
tr_bits);
> > > > > > -               } else if (off_diff > 16) {
> > > > > > +               } else if (align > 2 && off_diff > 16) {
> > > > > >                         pad_type =3D "int";
> > > > > >                         pad_bits =3D chip_away_bits(off_diff, 3=
2);
> > > > > > -               } else if (off_diff > 8) {
> > > > > > +               } else if (align > 1 && off_diff > 8) {
> > > > > >                         pad_type =3D "short";
> > > > > >                         pad_bits =3D chip_away_bits(off_diff, 1=
6);
> > > > > >                 } else {
> > > > > >   /Per
> > > >=20
> >=20

