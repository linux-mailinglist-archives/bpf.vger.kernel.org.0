Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C227364A7CD
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 20:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiLLTCW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 14:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbiLLTBM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 14:01:12 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D970E18341
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 10:59:07 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id c1so1011350lfi.7
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 10:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sDGVWum7LXfX8K+/GVP7KU76dOM+ln8UhvSC5F746bY=;
        b=VUsEsIeDtlAvdFOzINdtjJm7SE4cIcaTkRrrpFdNqXR69qWEY4pQ4uYGmShQlwbWSQ
         IIlXlOZ9NQRj6mAhuEXcvxpThL/5CFQ/FnlLJ5LbeoWV55rC7wamfsV0HCsOyDsZlBdo
         qvq8dw6SOu9I8Svnx+yKsTWUmwH4QHFaxB8AegrmH30bGb2Fud7gpk3Ts0m97mzhAiVF
         BwiM8YnDpzSn4TleBfsnzsR00qFaZtJ7ujsWZsc71rD7mICyGCWj5EhQnEKFgpmq62PD
         AxII81kabHFOCjygr4IA5NHPKhFXKL1ZSTFYrO7ISYBtdyB4VxazGujHe7cUMyjGj249
         j5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sDGVWum7LXfX8K+/GVP7KU76dOM+ln8UhvSC5F746bY=;
        b=FtIGKYNe8R5SozGnQ5OC0hJkKpah/2mNcUBNHO6d6DWNCgqPQuAb9Y6hqxSHmQm13E
         pYsnCFTwgpVTiormNeQBiieAwcxK0qUkUDhakkE617PHft4eLpHSZHvLGsUlhw1n3khH
         B48HPgjB7QQJ71qhcQGZY0KGotHuuC2lBDP11iXYclMDHpsCCvY5lhE1p3uUe3V3+lGJ
         3JAtUj9dq8qie5UXPhwSxIsPLN5f3dZMUNWVQOoBrxsUe7lw0qGn8ITpibbx0TySrZUY
         Oi2FA5LfRl50TnXs30XAKiCYNr4BKDiqP8/vOIYkoF2w+iMQZDdGlNRbsSeAHcAozST0
         E8TA==
X-Gm-Message-State: ANoB5pmYAv11Xm+SP6FwyriG8zSuSaqIR6ifvuhp4zzOrp9BZm2hpWPE
        cxvLOD1mFVw3Goghp4+Fjl8=
X-Google-Smtp-Source: AA0mqf5tXl3Uy7eqoasS0XPmL9pVOJm1tQBQHLR1vtncUx9p4qARpZ1NkWsThvM+cLgMowV1/yiHaw==
X-Received: by 2002:a05:6512:3414:b0:4b4:b5d3:6603 with SMTP id i20-20020a056512341400b004b4b5d36603mr7094555lfr.32.1670871546071;
        Mon, 12 Dec 2022 10:59:06 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id g26-20020a19e05a000000b004b094730074sm61528lfj.267.2022.12.12.10.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:59:05 -0800 (PST)
Message-ID: <90ad59d8c4552284062ca756016ba0c1a70b4eb1.camel@gmail.com>
Subject: Re: [PATCH bpf-next 5/6] libbpf: fix BTF-to-C converter's padding
 logic
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        Per =?ISO-8859-1?Q?Sundstr=F6m?= XP 
        <per.xp.sundstrom@ericsson.com>
Date:   Mon, 12 Dec 2022 20:59:04 +0200
In-Reply-To: <CAEf4BzbG7ToGkam79zJWHQSVGz-L-f8wgmTEBqFBNGf53aGxFw@mail.gmail.com>
References: <20221208185703.2681797-1-andrii@kernel.org>
         <20221208185703.2681797-6-andrii@kernel.org>
         <d22b1c3b25e1739a1318df1f619705a66d8f8584.camel@gmail.com>
         <CAEf4BzbG7ToGkam79zJWHQSVGz-L-f8wgmTEBqFBNGf53aGxFw@mail.gmail.com>
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

On Mon, 2022-12-12 at 10:44 -0800, Andrii Nakryiko wrote:
> On Fri, Dec 9, 2022 at 9:21 AM Eduard Zingerman <eddyz87@gmail.com> wrote=
:
> >=20
> > On Thu, 2022-12-08 at 10:57 -0800, Andrii Nakryiko wrote:
> > > Turns out that btf_dump API doesn't handle a bunch of tricky corner
> > > cases, as reported by Per, and further discovered using his testing
> > > Python script ([0]).
> > >=20
> > > This patch revamps btf_dump's padding logic significantly, making it
> > > more correct and also avoiding unnecessary explicit padding, where
> > > compiler would pad naturally. This overall topic turned out to be ver=
y
> > > tricky and subtle, there are lots of subtle corner cases. The comment=
s
> > > in the code tries to give some clues, but comments themselves are
> > > supposed to be paired with good understanding of C alignment and padd=
ing
> > > rules. Plus some experimentation to figure out subtle things like
> > > whether `long :0;` means that struct is now forced to be long-aligned
> > > (no, it's not, turns out).
> > >=20
> > > Anyways, Per's script, while not completely correct in some known
> > > situations, doesn't show any obvious cases where this logic breaks, s=
o
> > > this is a nice improvement over the previous state of this logic.
> > >=20
> > > Some selftests had to be adjusted to accommodate better use of natura=
l
> > > alignment rules, eliminating some unnecessary padding, or changing it=
 to
> > > `type: 0;` alignment markers.
> > >=20
> > > Note also that for when we are in between bitfields, we emit explicit
> > > bit size, while otherwise we use `: 0`, this feels much more natural =
in
> > > practice.
> > >=20
> > > Next patch will add few more test cases, found through randomized Per=
's
> > > script.
> > >=20
> > >   [0] https://lore.kernel.org/bpf/85f83c333f5355c8ac026f835b18d150607=
25fcb.camel@ericsson.com/
> > >=20
> > > Reported-by: Per Sundstr=C3=B6m XP <per.xp.sundstrom@ericsson.com>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  tools/lib/bpf/btf_dump.c                      | 169 +++++++++++++---=
--
> > >  .../bpf/progs/btf_dump_test_case_bitfields.c  |   2 +-
> > >  .../bpf/progs/btf_dump_test_case_padding.c    |  58 ++++--
> > >  3 files changed, 164 insertions(+), 65 deletions(-)
> > >=20
> > > diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> > > index 234e82334d56..d708452c9952 100644
> > > --- a/tools/lib/bpf/btf_dump.c
> > > +++ b/tools/lib/bpf/btf_dump.c
> > > @@ -830,6 +830,25 @@ static void btf_dump_emit_type(struct btf_dump *=
d, __u32 id, __u32 cont_id)
> > >       }
> > >  }
> > >=20
> > > +static int btf_natural_align_of(const struct btf *btf, __u32 id)
> > > +{
> > > +     const struct btf_type *t =3D btf__type_by_id(btf, id);
> > > +     int i, align, vlen;
> > > +     const struct btf_member *m;
> > > +
> > > +     if (!btf_is_composite(t))
> > > +             return btf__align_of(btf, id);
> > > +
> > > +     align =3D 1;
> > > +     m =3D btf_members(t);
> > > +     vlen =3D btf_vlen(t);
> > > +     for (i =3D 0; i < vlen; i++, m++) {
> > > +             align =3D max(align, btf_natural_align_of(btf, m->type)=
);
> > > +     }
> > > +
> > > +     return align;
> > > +}
> > > +
> >=20
> > The btf_natural_align_of() recursively visits nested structures.
> > However, the "packed" relation is non-recursive (see entry for
> > "packed" in [1]). Such mismatch leads to the following example being
> > printed incorrectly:
> >=20
> >         struct a {
> >                 int x;
> >         };
> >=20
> >         struct b {
> >                 struct a a;
> >                 char c;
> >         } __attribute__((packed));
> >=20
> >         struct c {
> >                 struct b b1;
> >                 short a1;
> >                 struct b b2;
> >         };
> >=20
> > The bpftool output looks as follows:
> >=20
> >         struct a {
> >                 int x;
> >         };
> >=20
> >         struct b {
> >                 struct a a;
> >                 char c;
> >         } __attribute__((packed));
> >=20
> >         struct c {
> >                 struct b b1;
> >                 short: 0;
> >                 short a1;
> >                 struct b b2;
> >         } __attribute__((packed));
>=20
> Nice find, thank you! The fix is very simple:
>=20
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index d708452c9952..d6fd93a57f11 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -843,7 +843,7 @@ static int btf_natural_align_of(const struct btf
> *btf, __u32 id)
>         m =3D btf_members(t);
>         vlen =3D btf_vlen(t);
>         for (i =3D 0; i < vlen; i++, m++) {
> -               align =3D max(align, btf_natural_align_of(btf, m->type));
> +               align =3D max(align, btf__align_of(btf, m->type));
>         }
>=20
> I'll also add your example to selftests to make sure.
>=20
> [...]
>=20
> >=20
> > Also the following comment in [2] is interesting:
> >=20
> > >  If the member is a structure, then the structure has an alignment
> > >  of 1-byte, but the members of that structure continue to have their
> > >  natural alignment.
> >=20
>=20
> If I read it correctly, it just means that within that nested struct
> all the members are aligned naturally (unless nested struct itself is
> packed), which makes sense and is already handled correctly. Or did I
> miss some subtle point you are making?

No additional subtle points.
It's a consequence of the non-recursiveness of "packed" and I wanted to
find a direct confirmation of such behaviour in the doc as it seemed odd.

>=20
> > Which leads to unaligned access in the following case:
> >=20
> >         int foo(struct a *p) { return p->x; }
> >=20
> >         int main() {
> >           struct b b[2] =3D {{ {1}, 2 }, { {3}, 4 }};
> >           printf("%i, %i\n", foo(&b[0].a), foo(&b[1].a));
> >         }
> >=20
> >         $ gcc -Wall test.c
> >         test.c: In function =E2=80=98main=E2=80=99:
> >         test.c:38:26: warning: taking address of packed member of =E2=
=80=98struct b=E2=80=99 may result
> >                       in an unaligned pointer value [-Waddress-of-packe=
d-member]
> >            38 |   printf("%i, %i\n", foo(&b[0].a), foo(&b[1].a));
> >=20
> > (This works fine on my x86 machine, but would be an issue on arm as
> >  far as I understand).
> >=20
> > [1] https://gcc.gnu.org/onlinedocs/gcc-12.2.0/gcc/Common-Type-Attribute=
s.html#Common-Type-Attributes
> > [2] https://developer.arm.com/documentation/100748/0607/writing-optimiz=
ed-code/packing-data-structures
> >=20
>=20
> [...]

