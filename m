Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A1A455DF4
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 15:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhKROaU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 09:30:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35730 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233068AbhKROaT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 09:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637245639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+mjVtw/CpZ9mnTSxomjiaZMKpdhiPPoco6lrom4G9Pk=;
        b=EIkzqn7cQPKlFOHxCMdWNEpwE3qFj9JIxpvKWSTRxvLj8uv0L3YflOTfaOKP5f94yJCIcJ
        8Ets389qo7p6fl+VACKRRn8XfVqCuWHcfoIG8MR/n5hQ7xUPmpZTupfXJrtVOx8+gv2Y62
        +A1fhpOfx2zlQ90gbke35PaMFHjTBNk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-wvYb8artPhGQEuyfYOU9Lw-1; Thu, 18 Nov 2021 09:27:17 -0500
X-MC-Unique: wvYb8artPhGQEuyfYOU9Lw-1
Received: by mail-ed1-f69.google.com with SMTP id w4-20020aa7cb44000000b003e7c0f7cfffso5442553edt.2
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 06:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+mjVtw/CpZ9mnTSxomjiaZMKpdhiPPoco6lrom4G9Pk=;
        b=yJbGKmpmd9kPDumm1w8X2gCS/Ndi4qsuoUX6qX3mvMsEMz8nAUWBK55i5lPRenW+rl
         AWUlKlHBautjRyCl4lZdABRlT9FcIZD3RvvawQwzgZUgs4DjL+Yb/nKnc4m64sUbJUxR
         MOdCF6SreOK7sXztm6IMcwY+vYTT6PaipnvQV7wmuut1s2h8sYVTRynu+s28uDUtDIZa
         vPrbnPSA/m7V4nw3PhbwkiAhbpSXMG0IRUuBd6HyR2bzD2KzYsY4CeBgUNb7sZXEYO8o
         7UM5WAdh8t4cmiX9KJIeOoXpYPShj8VwX809yF9KtQuaY6VPzX45w5k4oBF9vF8SIr3L
         moQw==
X-Gm-Message-State: AOAM532U3HIBwya5XuYhdiF2nFwuXU6aXilRVXBT0PIVkHoQ3RN0DKLQ
        W9Nx34ApfLL0SkwHxqANAJsfTUPO83wBsKR2iZfzdofUot1Ujg/NfQemJmfxo/tP9MkhIszpFqt
        kqroonRC6v6Vt
X-Received: by 2002:a17:907:7255:: with SMTP id ds21mr35033599ejc.42.1637245636663;
        Thu, 18 Nov 2021 06:27:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyiLrS3pC4da7uc9pSZQzR6ZgTCJ2MvZLo2Mcp7ohwLe1l2H78xi2U23MvZtW33ojXBAntDAw==
X-Received: by 2002:a17:907:7255:: with SMTP id ds21mr35033567ejc.42.1637245636438;
        Thu, 18 Nov 2021 06:27:16 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id jl8sm1342621ejc.59.2021.11.18.06.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:27:16 -0800 (PST)
Date:   Thu, 18 Nov 2021 15:27:14 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: accommodate DWARF/compiler bug with
 duplicated structs
Message-ID: <YZZiwnWReYnthtzH@krava>
References: <20211117194114.347675-1-andrii@kernel.org>
 <CAEf4Bza2NSV8MBb0jSokmUcrzy0SpLvY2uqu4mG9ObxnT-jQLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bza2NSV8MBb0jSokmUcrzy0SpLvY2uqu4mG9ObxnT-jQLw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 17, 2021 at 11:42:58AM -0800, Andrii Nakryiko wrote:
> On Wed, Nov 17, 2021 at 11:41 AM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > According to [0], compilers sometimes might produce duplicate DWARF
> > definitions for exactly the same struct/union within the same
> > compilation unit (CU). We've had similar issues with identical arrays
> > and handled them with a similar workaround in 6b6e6b1d09aa ("libbpf:
> > Accomodate DWARF/compiler bug with duplicated identical arrays"). Do the
> > same for struct/union by ensuring that two structs/unions are exactly
> > the same, down to the integer values of field referenced type IDs.
> 
> Jiri, can you please try this in your setup and see if that handles
> all situations or there are more complicated ones still. We'll need a
> test for more complicated ones in that case :( Thanks.

it seems to help largely, but I still see few modules (67 out of 780)
that keep 'struct module' for some reason.. their struct module looks
completely the same as is in vmlinux

I uploaded one of the module with vmlinux in here:
  http://people.redhat.com/~jolsa/kmodbtf/2/

I will do some debugging and find out why it did not work in this module
and try to come up with another test

thanks,
jirka

> 
> >
> > Solving this more generically (allowing referenced types to be
> > equivalent, but using different type IDs, all within a single CU)
> > requires a huge complexity increase to handle many-to-many mappings
> > between canonidal and candidate type graphs. Before we invest in that,
> > let's see if this approach handles all the instances of this issue in
> > practice. Thankfully it's pretty rare, it seems.
> >
> >   [0] https://lore.kernel.org/bpf/YXr2NFlJTAhHdZqq@krava/
> >
> > Reported-by: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/btf.c | 45 +++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 41 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index b6be579e0dc6..e97217a77196 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -3477,8 +3477,8 @@ static long btf_hash_struct(struct btf_type *t)
> >  }
> >
> >  /*
> > - * Check structural compatibility of two FUNC_PROTOs, ignoring referenced type
> > - * IDs. This check is performed during type graph equivalence check and
> > + * Check structural compatibility of two STRUCTs/UNIONs, ignoring referenced
> > + * type IDs. This check is performed during type graph equivalence check and
> >   * referenced types equivalence is checked separately.
> >   */
> >  static bool btf_shallow_equal_struct(struct btf_type *t1, struct btf_type *t2)
> > @@ -3851,6 +3851,31 @@ static int btf_dedup_identical_arrays(struct btf_dedup *d, __u32 id1, __u32 id2)
> >         return btf_equal_array(t1, t2);
> >  }
> >
> > +/* Check if given two types are identical STRUCT/UNION definitions */
> > +static bool btf_dedup_identical_structs(struct btf_dedup *d, __u32 id1, __u32 id2)
> > +{
> > +       const struct btf_member *m1, *m2;
> > +       struct btf_type *t1, *t2;
> > +       int n, i;
> > +
> > +       t1 = btf_type_by_id(d->btf, id1);
> > +       t2 = btf_type_by_id(d->btf, id2);
> > +
> > +       if (!btf_is_composite(t1) || btf_kind(t1) != btf_kind(t2))
> > +               return false;
> > +
> > +       if (!btf_shallow_equal_struct(t1, t2))
> > +               return false;
> > +
> > +       m1 = btf_members(t1);
> > +       m2 = btf_members(t2);
> > +       for (i = 0, n = btf_vlen(t1); i < n; i++, m1++, m2++) {
> > +               if (m1->type != m2->type)
> > +                       return false;
> > +       }
> > +       return true;
> > +}
> > +
> >  /*
> >   * Check equivalence of BTF type graph formed by candidate struct/union (we'll
> >   * call it "candidate graph" in this description for brevity) to a type graph
> > @@ -3962,6 +3987,8 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
> >
> >         hypot_type_id = d->hypot_map[canon_id];
> >         if (hypot_type_id <= BTF_MAX_NR_TYPES) {
> > +               if (hypot_type_id == cand_id)
> > +                       return 1;
> >                 /* In some cases compiler will generate different DWARF types
> >                  * for *identical* array type definitions and use them for
> >                  * different fields within the *same* struct. This breaks type
> > @@ -3970,8 +3997,18 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
> >                  * types within a single CU. So work around that by explicitly
> >                  * allowing identical array types here.
> >                  */
> > -               return hypot_type_id == cand_id ||
> > -                      btf_dedup_identical_arrays(d, hypot_type_id, cand_id);
> > +               if (btf_dedup_identical_arrays(d, hypot_type_id, cand_id))
> > +                       return 1;
> > +               /* It turns out that similar situation can happen with
> > +                * struct/union sometimes, sigh... Handle the case where
> > +                * structs/unions are exactly the same, down to the referenced
> > +                * type IDs. Anything more complicated (e.g., if referenced
> > +                * types are different, but equivalent) is *way more*
> > +                * complicated and requires a many-to-many equivalence mapping.
> > +                */
> > +               if (btf_dedup_identical_structs(d, hypot_type_id, cand_id))
> > +                       return 1;
> > +               return 0;
> >         }
> >
> >         if (btf_dedup_hypot_map_add(d, canon_id, cand_id))
> > --
> > 2.30.2
> >
> 

