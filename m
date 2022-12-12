Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9E764A760
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 19:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiLLSqL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 13:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbiLLSpu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 13:45:50 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595F9C18
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 10:45:10 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id r26so14241912edc.10
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 10:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiZmN4ZjJSXFzf25rnM53KhSNg/9LOlJ5n6URUAfv/c=;
        b=ptz90eBbnCaTYqsujhS5PzGy3XuxuW+hjWG/VP0TXGprzZ0Julhgl3FgPYtKQnIMfz
         UPlzVXfSCs+EPZeKdPksRqpseP5lAF+u7YRPZvY5Ilqn0hdOxd9OYzUwY7Hi3/fi41h6
         F2SQWG8+JlhEdsFxcWXQCOMR+0nRIq7JmOmwtbLmoyIXbp0gZo4FLZQonVamacww8ljQ
         9ujTjsJTwjxQ4qoCFbNiS+3vcHmtCqIfWz4TgzgVugwlEqv+tRa8H10/OHHwP01TfT77
         UmrHdzIr2c+B/GUAYVxC31vl/mIDtTQldG9BmhiJC1bJ91u+g96FAqC07VYTy/mneVZ7
         moJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiZmN4ZjJSXFzf25rnM53KhSNg/9LOlJ5n6URUAfv/c=;
        b=k+lV1ZYonj+65HIcrr2lSmqO3g12yb2hnwWrYk1lRI6TAQm/EixDT+dg7hDi96D1eL
         TOte9L+FZ0qoXdiX+0UJlxi+dW1178ld2Q3K6Y1OqwJHKzE6ppCzdzMlmpYNpE/rJd+j
         3zoMzD1WexfZmV3GSiMqJk4SebV+RTZHEwmtz5nhjUsQhCjpaq9XFPjumVYLjOEOTHFT
         tsKNYBqsNX77IY9gQucEJACDo1aZSoNmfKgI2WmR9o77S7iGS5hwdLzMzntwslWH6yke
         04QYEayU2pfzbWFhbb3D2k1OWFdNRqQyhjM4PvR2gdj2a2Y/1SR5YzmA5IUg6hUEAZ80
         mKNw==
X-Gm-Message-State: ANoB5pnis5cHxs8SXhk7jmRDKJlB1GEtAOVrpyBr8PYVrm9H2TxvF6u0
        Of5WFnz91AokjaXLNQdedKMlMyatpLhLg/FySmo=
X-Google-Smtp-Source: AA0mqf4YTdlJoC+EpAE/4L9H7dBoksEj9zmxvsDvnUdmu/IrOOgUS72YByoujjxksMGYg6jOPkiDlc7SWbVgXgnsq6E=
X-Received: by 2002:aa7:cd05:0:b0:46c:e558:ce90 with SMTP id
 b5-20020aa7cd05000000b0046ce558ce90mr13219901edw.81.1670870708802; Mon, 12
 Dec 2022 10:45:08 -0800 (PST)
MIME-Version: 1.0
References: <20221208185703.2681797-1-andrii@kernel.org> <20221208185703.2681797-6-andrii@kernel.org>
 <d22b1c3b25e1739a1318df1f619705a66d8f8584.camel@gmail.com>
In-Reply-To: <d22b1c3b25e1739a1318df1f619705a66d8f8584.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 12 Dec 2022 10:44:55 -0800
Message-ID: <CAEf4BzbG7ToGkam79zJWHQSVGz-L-f8wgmTEBqFBNGf53aGxFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/6] libbpf: fix BTF-to-C converter's padding logic
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

On Fri, Dec 9, 2022 at 9:21 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2022-12-08 at 10:57 -0800, Andrii Nakryiko wrote:
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
> > index 234e82334d56..d708452c9952 100644
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
> > +             align =3D max(align, btf_natural_align_of(btf, m->type));
> > +     }
> > +
> > +     return align;
> > +}
> > +
>
> The btf_natural_align_of() recursively visits nested structures.
> However, the "packed" relation is non-recursive (see entry for
> "packed" in [1]). Such mismatch leads to the following example being
> printed incorrectly:
>
>         struct a {
>                 int x;
>         };
>
>         struct b {
>                 struct a a;
>                 char c;
>         } __attribute__((packed));
>
>         struct c {
>                 struct b b1;
>                 short a1;
>                 struct b b2;
>         };
>
> The bpftool output looks as follows:
>
>         struct a {
>                 int x;
>         };
>
>         struct b {
>                 struct a a;
>                 char c;
>         } __attribute__((packed));
>
>         struct c {
>                 struct b b1;
>                 short: 0;
>                 short a1;
>                 struct b b2;
>         } __attribute__((packed));

Nice find, thank you! The fix is very simple:

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index d708452c9952..d6fd93a57f11 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -843,7 +843,7 @@ static int btf_natural_align_of(const struct btf
*btf, __u32 id)
        m =3D btf_members(t);
        vlen =3D btf_vlen(t);
        for (i =3D 0; i < vlen; i++, m++) {
-               align =3D max(align, btf_natural_align_of(btf, m->type));
+               align =3D max(align, btf__align_of(btf, m->type));
        }

I'll also add your example to selftests to make sure.

[...]

>
> Also the following comment in [2] is interesting:
>
> >  If the member is a structure, then the structure has an alignment
> >  of 1-byte, but the members of that structure continue to have their
> >  natural alignment.
>

If I read it correctly, it just means that within that nested struct
all the members are aligned naturally (unless nested struct itself is
packed), which makes sense and is already handled correctly. Or did I
miss some subtle point you are making?

> Which leads to unaligned access in the following case:
>
>         int foo(struct a *p) { return p->x; }
>
>         int main() {
>           struct b b[2] =3D {{ {1}, 2 }, { {3}, 4 }};
>           printf("%i, %i\n", foo(&b[0].a), foo(&b[1].a));
>         }
>
>         $ gcc -Wall test.c
>         test.c: In function =E2=80=98main=E2=80=99:
>         test.c:38:26: warning: taking address of packed member of =E2=80=
=98struct b=E2=80=99 may result
>                       in an unaligned pointer value [-Waddress-of-packed-=
member]
>            38 |   printf("%i, %i\n", foo(&b[0].a), foo(&b[1].a));
>
> (This works fine on my x86 machine, but would be an issue on arm as
>  far as I understand).
>
> [1] https://gcc.gnu.org/onlinedocs/gcc-12.2.0/gcc/Common-Type-Attributes.=
html#Common-Type-Attributes
> [2] https://developer.arm.com/documentation/100748/0607/writing-optimized=
-code/packing-data-structures
>

[...]
