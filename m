Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C262663E556
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 00:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiK3XTi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 18:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiK3XTX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 18:19:23 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184BDAB029
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 15:12:37 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z20so86947edc.13
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 15:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9+zat4T8MXSWgtxjunu0kuyV3OfI4S4XCBdN781efg=;
        b=EjhXCRtZ7KU0Q9mYzIViIjnfff3MpfoO4QX1Mw2K1tPwQCkiWcrlH2ggjj6OHRbfr2
         1wKFUDP7Sgz6nc6zo9MOaotZO89J2dcv8TpKgTtTMfUhedslXjW468o7gGQVSYJ7k+8H
         E+1Un5p7lQER8Q9zt/3UUuVL7+2xKvDySCsm4BNh5QLGBn4Jy/FgevaF/3yONpXJtHRU
         IpIe3htngWim+nW786mgiODfWCj/KWiplGu53Rza/FNiXnkofnbxzZZvaANE7Zaw1c/C
         DQRkQaopfaZ6nzH1OT4fgkTh1NpvzNKf6SxpGzWwYku4/2tOxdnHK5eHNwj/q8ZXkmtW
         OlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9+zat4T8MXSWgtxjunu0kuyV3OfI4S4XCBdN781efg=;
        b=mSSegbNr61i34p/rIP9CbZyCJYG6YTiVJQO5nZQcXMJfw39s2Oda1w7ie+cONKTo7g
         8ewwv1e9UvuIHVI8j3rt/rybg9nYTYjNTgFYNl0KSwt7e6fRWGMvXOlbSGfPTRH6+0bg
         BkWLgNf6um5czucelyu+Cgw7JG24R0xMoSZAiOuiyaEZhm1GV+CT8y3jOoHYxExytYqS
         ajWNOQZkqs4ZSrRt7g+h3mTk+JmCcJlDUif94DAZQqBFMQ13C4roCb6Od8pIyRKelVm3
         hoYJtEy7DIpVudORBaSfHM+tO9WdYMIDWatTkViIwrEImOjmYDF4RDIxETrLgxuQBQ3R
         ixEw==
X-Gm-Message-State: ANoB5pkuAQBN3ac4DKtF2yBQfi+Sfu5qRZFCusEEEjui3/ZhdRygfegv
        jSWzzfEgQQhKhcZE8AmVSEcNlYJ2f0IsiUtpGsk=
X-Google-Smtp-Source: AA0mqf5Mpx2LDo0JXkhBwLF4Lzxd4UPEUDj/+xMRfYj5Emjm4D4V7GQIjNjGSAaALeru+E9LgvXArj9sCV3MxVwOnKI=
X-Received: by 2002:aa7:d80d:0:b0:46b:7645:86a9 with SMTP id
 v13-20020aa7d80d000000b0046b764586a9mr9348231edq.311.1669849922379; Wed, 30
 Nov 2022 15:12:02 -0800 (PST)
MIME-Version: 1.0
References: <9cfc736f2b45422a50a21b90b94de04b19836682.camel@ericsson.com>
 <Y3d9mYrkWjrkJ9q2@krava> <HE1PR07MB3321F2F4C156BCA6EFD3A3DBBD099@HE1PR07MB3321.eurprd07.prod.outlook.com>
 <b529c3fa5946537f96430d679b9e8a4280f03e4b.camel@ericsson.com>
 <CAEf4Bza8c59wH05pRaBL2hHznFVs0_yWpVy1GHexURu3Ln-a=g@mail.gmail.com>
 <c4a265caf1653412ac88b8e6c56a694a0d50879c.camel@gmail.com>
 <CAEf4BzZt0VCEf-PVK0=aKBzqHHS4EBDiRc0tA23rrC7_amnxDQ@mail.gmail.com>
 <a95d7cae1ba418bac8d024c2590c34849a73472a.camel@gmail.com>
 <CAEf4BzbsxV63=-wET7eXS-He3eKkWnHtokzCak59ctztGn4kqQ@mail.gmail.com> <02cbc397cf2ed051bf3f79bbe8e1be07fadb3f10.camel@gmail.com>
In-Reply-To: <02cbc397cf2ed051bf3f79bbe8e1be07fadb3f10.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 30 Nov 2022 15:11:50 -0800
Message-ID: <CAEf4BzbQuxm2PEuLLZ0ydaheK8B1xt5WVXGZBuMfsphU7z=u0Q@mail.gmail.com>
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

On Wed, Nov 30, 2022 at 3:06 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2022-11-30 at 14:49 -0800, Andrii Nakryiko wrote:
> > On Tue, Nov 29, 2022 at 6:29 PM Eduard Zingerman <eddyz87@gmail.com> wr=
ote:
> > >
> > > On Tue, 2022-11-29 at 16:27 -0800, Andrii Nakryiko wrote:
> > > > On Tue, Nov 29, 2022 at 9:38 AM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
> > > > >
> > > > > On Wed, 2022-11-23 at 18:37 -0800, Andrii Nakryiko wrote:
> > > > > > On Fri, Nov 18, 2022 at 9:26 AM Per Sundstr=C3=B6m XP
> > > > > > <per.xp.sundstrom@ericsson.com> wrote:
> > > > > > >
> > > > > > >
> > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vanilla =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > > > > > > struct foo {
> > > > > > > > >     struct {
> > > > > > > > >         int  aa;
> > > > > > > > >         char ab;
> > > > > > > > >     } a;
> > > > > > > > >     long   :64;
> > > > > > > > >     int    :4;
> > > > > > > > >     char   b;
> > > > > > > > >     short  c;
> > > > > > > > > };
> > > > > > > > > offsetof(struct foo, c)=3D18
> > > > > > > > >
> > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Custom =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > > > > > > struct foo {
> > > > > > > > >         long: 8;
> > > > > > > > >         long: 64;
> > > > > > > > >         long: 64;
> > > > > > > > >         char b;
> > > > > > > > >         short c;
> > > > > > > > > };
> > > > > > > >
> > > > > > > > so I guess the issue is that the first 'long: 8' is padded =
to full
> > > > > > > > long: 64 ?
> > > > > > > >
> > > > > > > > looks like btf_dump_emit_bit_padding did not take into acco=
ut the gap
> > > > > > > > on the
> > > > > > > > begining of the struct
> > > > > > > >
> > > > > > > > on the other hand you generated that header file from 'min_=
core_btf'
> > > > > > > > btf data,
> > > > > > > > which takes away all the unused fields.. it might not beeen
> > > > > > > > considered as a
> > > > > > > > use case before
> > > > > > > >
> > > > > > > > jirka
> > > > > > > >
> > > > > > >
> > > > > > > > That could be the case, but I think the 'emit_bit_padding()=
' will not
> > > > > > > > really have a
> > > > > > > > lot to do for the non sparse headers ..
> > > > > > > >   /Per
> > > > > > >
> > > > > > >
> > > > > > > Looks like something like this makes tings a lot better:
> > > > > >
> > > > > > yep, this helps, though changes output with padding to more ver=
bose
> > > > > > version, quite often unnecessarily. I need to thing a bit more =
on
> > > > > > this, but the way we currently calculate alignment of a type is=
 not
> > > > > > always going to be correct. E.g., just because there is an int =
field,
> > > > > > doesn't mean that struct actually has 4-byte alignment.
> > > > > >
> > > > > > We must take into account natural alignment, but also actual
> > > > > > alignment, which might be different due to __attribute__((packe=
d)).
> > > > > >
> > > > > > Either way, thanks for reporting!
> > > > >
> > > > > Hi everyone,
> > > > >
> > > > > I think the fix is simpler:
> > > > >
> > > > > diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> > > > > index deb2bc9a0a7b..23a00818854b 100644
> > > > > --- a/tools/lib/bpf/btf_dump.c
> > > > > +++ b/tools/lib/bpf/btf_dump.c
> > > > > @@ -860,7 +860,7 @@ static bool btf_is_struct_packed(const struct=
 btf *btf, __u32 id,
> > > > >
> > > > >  static int chip_away_bits(int total, int at_most)
> > > > >  {
> > > > > -       return total % at_most ? : at_most;
> > > > > +       return total > at_most ? at_most : total;
> > > > >  }
> > > > >
> > > > > It changes the order in which btf_dump_emit_bit_padding() prints =
field
> > > > > sizes. Right now it returns the division remainder on a first cal=
l and
> > > > > full 'at_most' values at subsequent calls. For this particular ex=
ample
> > > > > the bit offset of 'b' is 136, so the output looks as follows:
> > > > >
> > > > > struct foo {
> > > > >         long: 8;    // first call pad_bits =3D 136 % 64 ? : 64; o=
ff_diff -=3D 8;
> > > > >         long: 64;   // second call pad_bits =3D 128 % 64 ? : 64; =
off_diff -=3D 64; ...
> > > > >         long: 64;
> > > > >         char b;
> > > > >         short c;
> > > > > };
> > > > >
> > > > > This is incorrect, because compiler would always add padding betw=
een
> > > > > the first and second members to account for the second member ali=
gnment.
> > > > >
> > > > > However, my change inverts the order, which avoids the accidental
> > > > > padding and gets the desired output:
> > > > >
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Custom =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > > struct foo {
> > > > >         long: 64;
> > > > >         long: 64;
> > > > >         char: 8;
> > > > >         char b;
> > > > >         short c;
> > > > > };
> > > > > offsetof(struct foo, c)=3D18
> > > > >
> > > > > =3D=3D=3D BTF offsets =3D=3D=3D
> > > > > full   :        'c' type_id=3D6 bits_offset=3D144
> > > > > custom :        'c' type_id=3D3 bits_offset=3D144
> > > > >
> > > > > wdyt?
> > > >
> > > > There were at least two issues I realized when I was thinking about
> > > > fixing this, and I think you are missing at least one of them.
> > > >
> > > > 1. Adding `long :xxx` as padding makes struct at least 8-byte align=
ed.
> > > > If the struct originally had a smaller alignment requirement, you a=
re
> > > > now potentially breaking the struct layout by changing its layout.
> > > >
> > > > 2. The way btf__align_of() is calculating alignment doesn't work
> > > > correctly for __attribute__((packed)) structs.
> > >
> > > Missed these point, sorry.
> > > On the other hand isn't this information lost in the custom.btf?
> > >
> > > $ bpftool btf dump file custom.btf
> > > [1] STRUCT 'foo' size=3D20 vlen=3D2
> > >         'b' type_id=3D2 bits_offset=3D136
> > >         'c' type_id=3D3 bits_offset=3D144
> > > [2] INT 'char' size=3D1 bits_offset=3D0 nr_bits=3D8 encoding=3DSIGNED
> > > [3] INT 'short' size=3D2 bits_offset=3D0 nr_bits=3D16 encoding=3DSIGN=
ED
> > >
> > > This has no info that 'foo' had fields of size 'long'. It does not
> > > matter for structs used inside BTF because 'bits_offset' is specified
> > > everywhere, but would matter if STRUCT 'foo' is used as a member of a
> > > non-BTF struct.
> >
> > Yes, the latter is important, though, right?
>
> Do you want to do anything about this at the custom BTF creation stage?

No, absolutely not. We just need to teach btf_dump.c to not introduce
any new alignment requirements while taking advantage of existing
ones. We can derive enough information from BTF to achieve this.

> E.g. leave one real member / create a synthetic member to force a specifi=
c
> struct alignment in the minimized version.
>
> > So I think ideally we determine "maximum allowable alignment" and use
> > that to determine what's the allowable set of padding types is. WDYT?
>
> Yes, I agree.
> I think that a change in the btf__align_of() should be minimal, just chec=
k
> if structure is packed and if so return 1, otherwise logic should remain
> unchanged, this would match what LLVM does ([1]).
> Also the flip of the order of chip_away_bits() should remain.

Let's come up with a few tricky examples trying to break existing
logic and then fix it. I suspect just chip_away_bits() changes are not
sufficient.

>
> [1] https://github.com/eddyz87/llvm-project/blob/main/llvm/lib/IR/DataLay=
out.cpp#L764
> >
> > >
> > > >
> > > > So we need to fix btf__align_of() first. What btf__align_of() is
> > > > calculating right now is a natural alignment requirement if we igno=
re
> > > > actual field offsets. This might be useful (at the very least to
> > > > determine if the struct is packed or not), so maybe we should have =
a
> > > > separate btf__natural_align_of() or something along those lines?
> > > >
> > > > And then we need to fix btf_dump_emit_bit_padding() to better handl=
e
> > > > alignment and padding rules. This is what Per Sundstr=C3=B6m is try=
ing to
> > > > do, I believe, but I haven't carefully thought about his latest cod=
e
> > > > suggestion.
> > > >
> > > > In general, the most obvious solution would be to pad with `char :8=
;`
> > > > everywhere, but that's very ugly and I'd prefer us to have as
> > > > "natural" output as possible. That is, only emit strictly necessary
> > > > padding fields and rely on natural alignment otherwise.
> > > >
> > > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > diff --git a/src/btf_dump.c b/src/btf_dump.c
> > > > > > > index 12f7039..a8bd52a 100644
> > > > > > > --- a/src/btf_dump.c
> > > > > > > +++ b/src/btf_dump.c
> > > > > > > @@ -881,13 +881,13 @@ static void btf_dump_emit_bit_padding(c=
onst
> > > > > > > struct btf_dump *d,
> > > > > > >                 const char *pad_type;
> > > > > > >                 int pad_bits;
> > > > > > >
> > > > > > > -               if (ptr_bits > 32 && off_diff > 32) {
> > > > > > > +               if (align > 4 && ptr_bits > 32 && off_diff > =
32) {
> > > > > > >                         pad_type =3D "long";
> > > > > > >                         pad_bits =3D chip_away_bits(off_diff,=
 ptr_bits);
> > > > > > > -               } else if (off_diff > 16) {
> > > > > > > +               } else if (align > 2 && off_diff > 16) {
> > > > > > >                         pad_type =3D "int";
> > > > > > >                         pad_bits =3D chip_away_bits(off_diff,=
 32);
> > > > > > > -               } else if (off_diff > 8) {
> > > > > > > +               } else if (align > 1 && off_diff > 8) {
> > > > > > >                         pad_type =3D "short";
> > > > > > >                         pad_bits =3D chip_away_bits(off_diff,=
 16);
> > > > > > >                 } else {
> > > > > > >   /Per
> > > > >
> > >
>
