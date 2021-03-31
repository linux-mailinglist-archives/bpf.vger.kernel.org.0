Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E2234F7FE
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 06:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhCaEbG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 00:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhCaEai (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 00:30:38 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477E5C061574;
        Tue, 30 Mar 2021 21:30:38 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id o66so19762981ybg.10;
        Tue, 30 Mar 2021 21:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4esu5/8aBEwO8JEPxG1S5eUZ6Mfa6xOvaxBjrBis5jo=;
        b=NGDXfmF96i8nsiNf+bi/gM7M+dNJBHah5XN8O8c2QqUbQfoQGqizUFTx0GGNqviShy
         wnZ67UEC6WYJBV3q2C0bsXP/Z+VpYJsyLhYltKAyYvDxf/lQBY/o9zFz83fb+tc4aiHF
         s/fJ+kGC4KWfPXKqKl54t6S72Zk3oQtH7y1jvkrCnWCntgA2hSFAhkXaU5RWAzM0JNii
         eclSmxpNABdM6SHq10ts6RRVKjyjcFMTwOo76MvRYsSb8YMNur+IwcJ3dXFEemZXTY2t
         U6yGozMfmCyPrYIlDmHy9t9jzhJI/NHXJy54R6MYPaYRcKG8aGHqYaqJHseayH1QzhO0
         9R0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4esu5/8aBEwO8JEPxG1S5eUZ6Mfa6xOvaxBjrBis5jo=;
        b=ih7iV/HLyF8YK3f5MV4v+pGHKM/EjLmrhmyhvbuFd1SrC5qbL30mXE0wrcafhvHh/Q
         CnQ1GvE+nhaG7eI71MA+GHtaOE+FvIQgLxRgo+QGBXzbZgR0orUfODrofq8Sm+UXW8JX
         phCm0tpbkqtwytQRA4tofRS0GDzFuf4wNmH/hRt9FVvDbNw8USxmWvrrMDb2tipYVR1q
         0Hm0elcbarM4xSHnsL6Uiy6izGHtOLJaHLCMUCii5UDxqU1i8M6aTGB2dPxAPCv3p0xs
         Rw53ub57wft5FKHIyHzrVWZhKKhYRzZueiQCIAPPH5fPp/DS5kSod9DeoWmS26HIA0V0
         FChw==
X-Gm-Message-State: AOAM533c8FKYEIVFvtEYevdIYS3e7eqS8CZGraj4l7KjGaJJ9b41mnPm
        wW1u6QnscNXmNkT0QPov9E58TkOFng17bQ7pwUo=
X-Google-Smtp-Source: ABdhPJxweHnm+VuaJeNWJzt4Uoef6fHakeC3i3nCligpcWgNv40YeAYWWG9y4YCryDsaKc0B4M8/QCStIEv63y/PruM=
X-Received: by 2002:a25:c4c5:: with SMTP id u188mr2037199ybf.425.1617165037328;
 Tue, 30 Mar 2021 21:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210325065316.3121287-1-yhs@fb.com> <20210325065322.3121605-1-yhs@fb.com>
 <CAEf4BzYcfEjeRHD_aVPvJNXqtqR2Uso4Rt+Q4SmCk5+GUoAzEg@mail.gmail.com>
 <55c83f03-1b86-ad79-2bfa-69c8c26fa7d2@fb.com> <YGHd/qO/MwurHcaR@kernel.org>
In-Reply-To: <YGHd/qO/MwurHcaR@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 30 Mar 2021 21:30:26 -0700
Message-ID: <CAEf4BzZR9sfgxwj+6dDh8ohhFH3MdL0BVer9rQbAH3DSME17Lg@mail.gmail.com>
Subject: Re: [PATCH dwarves 1/3] dwarf_loader: permits flexible HASHTAGS__BITS
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 29, 2021 at 7:02 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Mar 26, 2021 at 04:26:20PM -0700, Yonghong Song escreveu:
> >
> >
> > On 3/26/21 4:13 PM, Andrii Nakryiko wrote:
> > > On Wed, Mar 24, 2021 at 11:53 PM Yonghong Song <yhs@fb.com> wrote:
> > > >
> > > > Currently, types/tags hash table has fixed HASHTAGS__BITS = 15.
> > > > That means the number of buckets will be 1UL << 15 = 32768.
> > > > In my experiments, a thin-LTO built vmlinux has roughly 9M entries
> > > > in types table and 5.2M entries in tags table. So the number
> > > > of buckets is too less for an efficient lookup. This patch
> > > > refactored the code to allow the number of buckets to be changed.
> > > >
> > > > In addition, currently hashtags__fn(key) return value is
> > > > assigned to uint16_t. Change to uint32_t as in a later patch
> > > > the number of hashtag bits can be increased to be more than 16.
> > > >
> > > > Signed-off-by: Yonghong Song <yhs@fb.com>
> > > > ---
> > > >   dwarf_loader.c | 48 +++++++++++++++++++++++++++++++++++++-----------
> > > >   1 file changed, 37 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > > > index c106919..a02ef23 100644
> > > > --- a/dwarf_loader.c
> > > > +++ b/dwarf_loader.c
> > > > @@ -50,7 +50,12 @@ struct strings *strings;
> > > >   #define DW_FORM_implicit_const 0x21
> > > >   #endif
> > > >
> > > > -#define hashtags__fn(key) hash_64(key, HASHTAGS__BITS)
> > > > +static uint32_t hashtags__bits = 15;
> > > > +
> > > > +uint32_t hashtags__fn(Dwarf_Off key)
> > > > +{
> > > > +       return hash_64(key, hashtags__bits);
> > >
> > > I vaguely remember pahole patch that updated hash function to use the
> > > same one as libbpf's hashmap is using. Arnaldo, wasn't that patch
> > > accepted?
>
> I guess so:
>
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=9fecc77ed82d429fd3fe49ba275465813228e617

Oh, my bad. I fetched the latest master but didn't notice that I had
some local changes that conflicted, so my master didn't actually
update. Sorry about the noise.

>
> dwarf_loader: Use a better hashing function, from libbpf
>
> This hashing function[1] produces better hash table bucket
> distributions. The original hashing function always produced zeros in
> the three least significant bits. The new hashing function gives a
> modest performance boost:
>
>   Original: 0:11.373s
>   New:      0:11.110s
>
> for a performance improvement of ~2%.
>
> [1] From the hash function used in libbpf.
>
> Committer notes:
>
> Bill found the suboptimality of the hash function being used, Andrii
> suggested using the libbpf one, which ended up being better.
>
> Signed-off-by: Bill Wendling <morbo@google.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Cc: bpf@vger.kernel.org
> Cc: dwarves@vger.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> > > But more to the point, I think hashtags__fn() should probably preserve
> > > all 64 bits of the hash?
> >
> > I don't know the context. If the purpose is to avoid future changes
> > in case that the hashtags__bits > 32 happens, yes, the change may
> > make sense.
> >
> > >
> > > > +}
> > > >
> > > >   bool no_bitfield_type_recode = true;
> > > >
> > > > @@ -102,9 +107,6 @@ static void dwarf_tag__set_spec(struct dwarf_tag *dtag, dwarf_off_ref spec)
> > > >          *(dwarf_off_ref *)(dtag + 1) = spec;
> > > >   }
> > > >
> > > > -#define HASHTAGS__BITS 15
> > > > -#define HASHTAGS__SIZE (1UL << HASHTAGS__BITS)
> > > > -
> > > >   #define obstack_chunk_alloc malloc
> > > >   #define obstack_chunk_free free
> > > >
> > > > @@ -118,22 +120,41 @@ static void *obstack_zalloc(struct obstack *obstack, size_t size)
> > > >   }
> > > >
> > > >   struct dwarf_cu {
> > > > -       struct hlist_head hash_tags[HASHTAGS__SIZE];
> > > > -       struct hlist_head hash_types[HASHTAGS__SIZE];
> > > > +       struct hlist_head *hash_tags;
> > > > +       struct hlist_head *hash_types;
> > > >          struct obstack obstack;
> > > >          struct cu *cu;
> > > >          struct dwarf_cu *type_unit;
> > > >   };
> > > >
> > > > -static void dwarf_cu__init(struct dwarf_cu *dcu)
> > > > +static int dwarf_cu__init(struct dwarf_cu *dcu)
> > > >   {
> > > > +       uint64_t hashtags_size = 1UL << hashtags__bits;
> > >
> > > I wish pahole could just use libbpf's dynamically resized hashmap,
> > > instead of hard-coding maximum size like this :(
> > >
> > > Arnaldo, libbpf is not going to expose its hashmap as public API, but
> > > if you'd like to use it, feel free to just copy/paste the code. It
> > > hasn't change for a while and is unlikely to change (unless some day
> > > we decide to make more efficient open-addressing implementation).
> > >
> > > > +       dcu->hash_tags = malloc(sizeof(struct hlist_head) * hashtags_size);
> > > > +       if (!dcu->hash_tags)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       dcu->hash_types = malloc(sizeof(struct hlist_head) * hashtags_size);
> > > > +       if (!dcu->hash_types) {
> > > > +               free(dcu->hash_tags);
> > > > +               return -ENOMEM;
> > > > +       }
> > > > +
> > >
> > > [...]
> > >
>
> --
>
> - Arnaldo
