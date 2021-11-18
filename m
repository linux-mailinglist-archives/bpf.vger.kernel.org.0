Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943684565E0
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 23:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhKRWwt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 17:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhKRWws (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Nov 2021 17:52:48 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEAAC061574
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 14:49:47 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id e71so22651442ybh.10
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 14:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VdIxpMyt3SWjRJBdtzvosHaDxrAWUqys1OSuqAlao9g=;
        b=KjfvSU1SYQu6uLcLUB1z5tJV5GziUM+Xq4YN18WIStQVb3EMERv8MN5SEJSaHj0oCg
         2TEOT7KxzOvQtYBS6+DM6ZgOUb+b/VV2EcrCdbgz2sgGMA8eB+A7nIVr8qAFXQ1KjWQg
         A0ZVWzfQ20Tf6E0XmwZUMsrdxshZPoyiqIrDckVG9ytYkcH9M2tcVdKkvy9/kGhv44z8
         SMB0IzneMpiRtZtBBphXyA6JmJg+/IanT52SlMd8EhpjwvgEhnlb8wg0Eolo1LnMpfs+
         Vgy9OUvUDKm4srrpTqCUwi8dusiMK9z3/VFG+voZE1LA5TVQq4FE9YekwICrbfTOt4gq
         5R8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VdIxpMyt3SWjRJBdtzvosHaDxrAWUqys1OSuqAlao9g=;
        b=Lod5ozLzNlAAVzyKDG/s8K5GqcuThzFv1NJiWiVCeLf3L8Lx0bfpeiB/IVNy6vM51q
         2R4gFXihZG2hBw3ZO9npEhzdNVSRnnoVXvtfEQzQ5KM8NWzPiaqQCg68o7JTfPIa2AOU
         c987BV+tqIhV37zjduhj0NOcAPlgfw8WEfF6qcUcX+Rwt1PzXC0P7Bw6VKZAxa14pH7o
         8ul3zhEcOFTN4tB9sS2UKs2POCMd3DAmJ9NDHaE4wjxmoPlrDeQ/J/DG+qHgg6wYAlp1
         XwRKVMr5vYoJQJyDO+XbK3tMhLx3yf1kPjqtZlyEYRyq/qLG+iUdr1R0sJBXVMmq+9vf
         evrw==
X-Gm-Message-State: AOAM5305sM8VHuadaPxIVSYpmd0N8GT3cdonJ1ukZaQJ2jobOeSOLtjx
        V7yPuC/qSHb+N6hEWEy3LJM3cWi85e+nh9aOcjo=
X-Google-Smtp-Source: ABdhPJw43d3hZT7VGSpsRmX3ue+4ty6NQEwRnxLN1J+Nzc3LxW/ReFNZdSnuIdmFJu+UaO5kEu7XdrOTYHkjYpZ35Zo=
X-Received: by 2002:a25:ccd4:: with SMTP id l203mr8748113ybf.225.1637275786936;
 Thu, 18 Nov 2021 14:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20211117194114.347675-1-andrii@kernel.org> <CAEf4Bza2NSV8MBb0jSokmUcrzy0SpLvY2uqu4mG9ObxnT-jQLw@mail.gmail.com>
 <YZZiwnWReYnthtzH@krava>
In-Reply-To: <YZZiwnWReYnthtzH@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 18 Nov 2021 14:49:35 -0800
Message-ID: <CAEf4BzZ9E3Yg2jjCvzdfDN2dCX-hJBqt1cHFvVNzujrx7KWdgg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: accommodate DWARF/compiler bug with
 duplicated structs
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 18, 2021 at 6:27 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Nov 17, 2021 at 11:42:58AM -0800, Andrii Nakryiko wrote:
> > On Wed, Nov 17, 2021 at 11:41 AM Andrii Nakryiko <andrii@kernel.org> wrote:
> > >
> > > According to [0], compilers sometimes might produce duplicate DWARF
> > > definitions for exactly the same struct/union within the same
> > > compilation unit (CU). We've had similar issues with identical arrays
> > > and handled them with a similar workaround in 6b6e6b1d09aa ("libbpf:
> > > Accomodate DWARF/compiler bug with duplicated identical arrays"). Do the
> > > same for struct/union by ensuring that two structs/unions are exactly
> > > the same, down to the integer values of field referenced type IDs.
> >
> > Jiri, can you please try this in your setup and see if that handles
> > all situations or there are more complicated ones still. We'll need a
> > test for more complicated ones in that case :( Thanks.
>
> it seems to help largely, but I still see few modules (67 out of 780)
> that keep 'struct module' for some reason.. their struct module looks
> completely the same as is in vmlinux

Curious, what's the size of all the module BTFs now? And yes, please
try to narrow down what is causing the bloat this time. I think this
change can go in anyways, it's conceptually the same as a workaround
for duplicate arrays produced by the compiler.

>
> I uploaded one of the module with vmlinux in here:
>   http://people.redhat.com/~jolsa/kmodbtf/2/
>
> I will do some debugging and find out why it did not work in this module
> and try to come up with another test
>
> thanks,
> jirka
>
> >
> > >
> > > Solving this more generically (allowing referenced types to be
> > > equivalent, but using different type IDs, all within a single CU)
> > > requires a huge complexity increase to handle many-to-many mappings
> > > between canonidal and candidate type graphs. Before we invest in that,
> > > let's see if this approach handles all the instances of this issue in
> > > practice. Thankfully it's pretty rare, it seems.
> > >
> > >   [0] https://lore.kernel.org/bpf/YXr2NFlJTAhHdZqq@krava/
> > >
> > > Reported-by: Jiri Olsa <jolsa@kernel.org>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  tools/lib/bpf/btf.c | 45 +++++++++++++++++++++++++++++++++++++++++----
> > >  1 file changed, 41 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > index b6be579e0dc6..e97217a77196 100644
> > > --- a/tools/lib/bpf/btf.c
> > > +++ b/tools/lib/bpf/btf.c
> > > @@ -3477,8 +3477,8 @@ static long btf_hash_struct(struct btf_type *t)
> > >  }
> > >
> > >  /*
> > > - * Check structural compatibility of two FUNC_PROTOs, ignoring referenced type
> > > - * IDs. This check is performed during type graph equivalence check and
> > > + * Check structural compatibility of two STRUCTs/UNIONs, ignoring referenced
> > > + * type IDs. This check is performed during type graph equivalence check and
> > >   * referenced types equivalence is checked separately.
> > >   */
> > >  static bool btf_shallow_equal_struct(struct btf_type *t1, struct btf_type *t2)
> > > @@ -3851,6 +3851,31 @@ static int btf_dedup_identical_arrays(struct btf_dedup *d, __u32 id1, __u32 id2)
> > >         return btf_equal_array(t1, t2);
> > >  }
> > >
> > > +/* Check if given two types are identical STRUCT/UNION definitions */
> > > +static bool btf_dedup_identical_structs(struct btf_dedup *d, __u32 id1, __u32 id2)
> > > +{
> > > +       const struct btf_member *m1, *m2;
> > > +       struct btf_type *t1, *t2;
> > > +       int n, i;
> > > +
> > > +       t1 = btf_type_by_id(d->btf, id1);
> > > +       t2 = btf_type_by_id(d->btf, id2);
> > > +
> > > +       if (!btf_is_composite(t1) || btf_kind(t1) != btf_kind(t2))
> > > +               return false;
> > > +
> > > +       if (!btf_shallow_equal_struct(t1, t2))
> > > +               return false;
> > > +
> > > +       m1 = btf_members(t1);
> > > +       m2 = btf_members(t2);
> > > +       for (i = 0, n = btf_vlen(t1); i < n; i++, m1++, m2++) {
> > > +               if (m1->type != m2->type)
> > > +                       return false;
> > > +       }
> > > +       return true;
> > > +}
> > > +
> > >  /*
> > >   * Check equivalence of BTF type graph formed by candidate struct/union (we'll
> > >   * call it "candidate graph" in this description for brevity) to a type graph
> > > @@ -3962,6 +3987,8 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
> > >
> > >         hypot_type_id = d->hypot_map[canon_id];
> > >         if (hypot_type_id <= BTF_MAX_NR_TYPES) {
> > > +               if (hypot_type_id == cand_id)
> > > +                       return 1;
> > >                 /* In some cases compiler will generate different DWARF types
> > >                  * for *identical* array type definitions and use them for
> > >                  * different fields within the *same* struct. This breaks type
> > > @@ -3970,8 +3997,18 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
> > >                  * types within a single CU. So work around that by explicitly
> > >                  * allowing identical array types here.
> > >                  */
> > > -               return hypot_type_id == cand_id ||
> > > -                      btf_dedup_identical_arrays(d, hypot_type_id, cand_id);
> > > +               if (btf_dedup_identical_arrays(d, hypot_type_id, cand_id))
> > > +                       return 1;
> > > +               /* It turns out that similar situation can happen with
> > > +                * struct/union sometimes, sigh... Handle the case where
> > > +                * structs/unions are exactly the same, down to the referenced
> > > +                * type IDs. Anything more complicated (e.g., if referenced
> > > +                * types are different, but equivalent) is *way more*
> > > +                * complicated and requires a many-to-many equivalence mapping.
> > > +                */
> > > +               if (btf_dedup_identical_structs(d, hypot_type_id, cand_id))
> > > +                       return 1;
> > > +               return 0;
> > >         }
> > >
> > >         if (btf_dedup_hypot_map_add(d, canon_id, cand_id))
> > > --
> > > 2.30.2
> > >
> >
>
