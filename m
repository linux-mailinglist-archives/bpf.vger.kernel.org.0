Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5DF64D4B1
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 01:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLOAeb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 19:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLOAea (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 19:34:30 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE1636C48
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 16:34:25 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ud5so48618667ejc.4
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 16:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBl5p/BffEw2wYtFp0DGEfZYAzS/w1uwUA5Jh/HNYk8=;
        b=b/Ab5QiOHt1kaw2k3V5mvabaI8c6NakOqKfxe2j5lh7HnahoOcwpvgmdZhOBzT2Vsz
         g9RpJtHfIqqIZc15M79nlyy9HIpmz/mmEutPDFT2RAgzoCJqJyjjYzPvmPxAZNF6KGO2
         l2dnmNz4grb2Ooyw/1jHjYWvs5Pg8MCTYrHKoJ7keSlVjm/4yJFvec3o40d7KdGcz2ib
         J4MbnurF4qqYWDyNvxoFr5qq7swPg3n4ebjHOWTiS9tjRhXCY5PvzlW1KwV1FoNmug3x
         VMK8mPTcf1ABFANUcDoKIFmuN+Rz+zUSKuC+oBM+X3rIQAL91seHoUigQCm6jLalSaO/
         qlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBl5p/BffEw2wYtFp0DGEfZYAzS/w1uwUA5Jh/HNYk8=;
        b=eqmqh0AFd/e9pz8jbssIDdkYjlC/+GNYqcNJC+Z/EbGQDDzgS003NzSj7kldwaW600
         BCND79U3/vql1D/qzamUulWu3DqViYKJP8F6ZlQhNldhBGPt+2NP+CWPTP+7cCz/NzPX
         DJR343HLwfkQ9cFef2r3CCvEAg2LBitoh1sEygTXRawBRjrL+MP9qrgOVW7rda59hDmD
         yDFR9jWxs7yNcK18zWX7A1KZTKNhqhKtj/YewygBvjx72qTjYBqFg/uI9GmeXf1GjqMz
         FhMkgTAtVZs8r+B9slYVH05Spxo5rcgfGKr457JB5Z82XpuNIYt2cFPXjtwGv7VMA4He
         DExA==
X-Gm-Message-State: ANoB5pn2FmgxQ9Q8DrhTvEHoQNuNZmm4/vcjpo6YM60fxmOiHc8giMdh
        1dJ6EjgpHhVQj33Lski9HtMWaWHUiW7S2420lHVH42TpR8A=
X-Google-Smtp-Source: AA0mqf6egi1QAulWZ+R/0LZ6nQh+16Pe0cjOlc9DOC62CF/Oh7LnVuunhKJQ5e59Kc8fJdbxdqESiop4orAjXWKakJI=
X-Received: by 2002:a17:906:94e:b0:7ba:4617:3f17 with SMTP id
 j14-20020a170906094e00b007ba46173f17mr59610483ejd.226.1671064463521; Wed, 14
 Dec 2022 16:34:23 -0800 (PST)
MIME-Version: 1.0
References: <20221212211505.558851-1-andrii@kernel.org> <20221212211505.558851-6-andrii@kernel.org>
 <0a1f4677cf72f2a75b5acafc3a48df16d530e0e6.camel@gmail.com>
In-Reply-To: <0a1f4677cf72f2a75b5acafc3a48df16d530e0e6.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 14 Dec 2022 16:34:11 -0800
Message-ID: <CAEf4Bzbi=goxjjRa0+h9BABc=YX4RLuASf888OFBtuXn260XHg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 5/6] libbpf: fix BTF-to-C converter's padding logic
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        =?UTF-8?Q?Per_Sundstr=C3=B6m_XP?= <per.xp.sundstrom@ericsson.com>
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

On Wed, Dec 14, 2022 at 4:19 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Mon, 2022-12-12 at 13:15 -0800, Andrii Nakryiko wrote:
> > Turns out that btf_dump API doesn't handle a bunch of tricky corner
> > cases, as reported by Per, and further discovered using his testing
> > Python script ([0]).
> >
> > This patch revamps btf_dump's padding logic significantly, making it
> > more correct and also avoiding unnecessary explicit padding, where
> > compiler would pad naturally. This overall topic turned out to be very
> > tricky and subtle, there are lots of subtle corner cases. The comments
> > in the code tries to give some clues, but comments themselves are
> > supposed to be paired with good understanding of C alignment and paddin=
g
> > rules. Plus some experimentation to figure out subtle things like
> > whether `long :0;` means that struct is now forced to be long-aligned
> > (no, it's not, turns out).
> >
> > Anyways, Per's script, while not completely correct in some known
> > situations, doesn't show any obvious cases where this logic breaks, so
> > this is a nice improvement over the previous state of this logic.
> >
> > Some selftests had to be adjusted to accommodate better use of natural
> > alignment rules, eliminating some unnecessary padding, or changing it t=
o
> > `type: 0;` alignment markers.
> >
> > Note also that for when we are in between bitfields, we emit explicit
> > bit size, while otherwise we use `: 0`, this feels much more natural in
> > practice.
> >
> > Next patch will add few more test cases, found through randomized Per's
> > script.
> >
> >   [0] https://lore.kernel.org/bpf/85f83c333f5355c8ac026f835b18d15060725=
fcb.camel@ericsson.com/
> >
> > Reported-by: Per Sundstr=C3=B6m XP <per.xp.sundstrom@ericsson.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/btf_dump.c                      | 169 +++++++++++++-----
> >  .../bpf/progs/btf_dump_test_case_bitfields.c  |   2 +-
> >  .../bpf/progs/btf_dump_test_case_padding.c    |  58 ++++--
> >  3 files changed, 164 insertions(+), 65 deletions(-)
> >
> > diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> > index 234e82334d56..d6fd93a57f11 100644
> > --- a/tools/lib/bpf/btf_dump.c
> > +++ b/tools/lib/bpf/btf_dump.c
> > @@ -830,6 +830,25 @@ static void btf_dump_emit_type(struct btf_dump *d,=
 __u32 id, __u32 cont_id)
> >       }
> >  }
> >
> > +static int btf_natural_align_of(const struct btf *btf, __u32 id)
> > +{
> > +     const struct btf_type *t =3D btf__type_by_id(btf, id);
> > +     int i, align, vlen;
> > +     const struct btf_member *m;
> > +
> > +     if (!btf_is_composite(t))
> > +             return btf__align_of(btf, id);
> > +
> > +     align =3D 1;
> > +     m =3D btf_members(t);
> > +     vlen =3D btf_vlen(t);
> > +     for (i =3D 0; i < vlen; i++, m++) {
> > +             align =3D max(align, btf__align_of(btf, m->type));
> > +     }
> > +
> > +     return align;
> > +}
> > +
> >  static bool btf_is_struct_packed(const struct btf *btf, __u32 id,
> >                                const struct btf_type *t)
> >  {
> > @@ -837,16 +856,16 @@ static bool btf_is_struct_packed(const struct btf=
 *btf, __u32 id,
> >       int align, i, bit_sz;
> >       __u16 vlen;
> >
> > -     align =3D btf__align_of(btf, id);
> > -     /* size of a non-packed struct has to be a multiple of its alignm=
ent*/
> > -     if (align && t->size % align)
> > +     align =3D btf_natural_align_of(btf, id);
> > +     /* size of a non-packed struct has to be a multiple of its alignm=
ent */
> > +     if (align && (t->size % align) !=3D 0)
> >               return true;
> >
> >       m =3D btf_members(t);
> >       vlen =3D btf_vlen(t);
> >       /* all non-bitfield fields have to be naturally aligned */
> >       for (i =3D 0; i < vlen; i++, m++) {
> > -             align =3D btf__align_of(btf, m->type);
> > +             align =3D btf_natural_align_of(btf, m->type);
>
> Sorry, I'm late to the party...
>
> I think that this call to btf__align_of() should remain as is,
> otherwise the packed-ness of the m->type is ignored, which leads to
> the example below generating unnecessary packed annotation, which in
> turn leads to wrong result of sizeof() if asked.
> Reverting this hunk makes the test below work as expected and
> no other tests break.

Yep, I don't think I actually need btf_natural_align_of(), I'll just
adjust btf_is_struct_packed() instead. Thanks for another great catch!
I'll send a follow up fix.


>
> 02:02:44 tmp$ cat test.c
> #ifndef __BPF__
>
> #include <stddef.h>
> #include <stdio.h>
>
> #endif /* __BPF__ */
>
> struct a {
>   int x;
>   char y;
> }  __attribute__((packed));
>
> struct b {
>   short x;
>   struct a a;
> };
>
> #ifdef __BPF__
>
> int root(struct b *b) { return 7; }
>
> #else /* __BPF__ */
>
> struct b1 {
>   short x;
>   struct a a;
> } __attribute__((packed));
>
> int main() {
>   printf("sizeof(struct b ): %ld\n", sizeof(struct b));
>   printf("sizeof(struct b1): %ld\n", sizeof(struct b1));
> }
>
> #endif /* __BPF__ */
>
> 02:04:24 tmp$ clang test.c && ./a.out
> sizeof(struct b ): 8
> sizeof(struct b1): 7
>
> 02:04:30 tmp$ clang -target bpf -g -c test.c -o test.o && bpftool btf dum=
p file ./test.o format c
> #ifndef __VMLINUX_H__
> #define __VMLINUX_H__
>
> #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
> #pragma clang attribute push (__attribute__((preserve_access_index)), app=
ly_to =3D record)
> #endif
>
> struct a {
>         int x;
>         char y;
> } __attribute__((packed));
>
> struct b {
>         short x;
>         struct a a;
> } __attribute__((packed));
>
> #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
> #pragma clang attribute pop
> #endif
>
> #endif /* __VMLINUX_H__ */
>
> >               bit_sz =3D btf_member_bitfield_size(t, i);
> >               if (align && bit_sz =3D=3D 0 && m->offset % (8 * align) !=
=3D 0)
> >                       return true;

[...]
