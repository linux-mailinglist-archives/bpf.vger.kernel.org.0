Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D441B45B948
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 12:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240948AbhKXLmP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 06:42:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32740 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232946AbhKXLmO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Nov 2021 06:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637753944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XflycumpvCWuqmL0mOGF0gX+EtFGRB7n3Q2DJ2OsP6s=;
        b=byIbh/gfeCZwV0AX1FmvbTyFPECYfe3APUUqJV/0OgZbPXcY1XyPWnJvOUirZQqlRUVCXs
        3MhRIfcK3vZbSFPTEsgHeMDGyJt6KjGk4L8ao+JyVJvV1TKt+y86BwkcO/oLs1CsRSc3Z+
        5xsB6onRO7Utf9xE02uxlKx4lx9QGlk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-YsWGTFp_N1G8nqC1FmFsjw-1; Wed, 24 Nov 2021 06:39:03 -0500
X-MC-Unique: YsWGTFp_N1G8nqC1FmFsjw-1
Received: by mail-wm1-f71.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso2862197wms.4
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 03:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XflycumpvCWuqmL0mOGF0gX+EtFGRB7n3Q2DJ2OsP6s=;
        b=wXAeIFlFF2XRF/3ZIxKwKfznDleZWMmfWChpTuSXadurn3zhxNvt+JHzW0adDs6Zgn
         2LqQKyfikhtzzmXf8ZHfYr1m5CNgitT10QXHNriQfBBgZoR1iDJVOVJjL794hSBLtFPo
         3ombly6zWVRHWZYeFLReFzETJh5Cpfub1X/6eu0S3Hduie2AqepVvYNutiphFyBKcFjd
         aHsqRXwAJKRX5cYkatJWCZK1l3+Vwgz8fV2PGUCpW4L4fyrioBs2hi2hY5jMTz96R06t
         hgqaLE1+F/dhaR4ha7KPxZGPl2dh2FjUSsN2cCNmqbzBNuMsU/vRt5e+y7B+MX+SEJxC
         Xqjw==
X-Gm-Message-State: AOAM533cUSAIxzY8acrHO74XwfnMQVxRNeqdCus/O/LkIMmeR34gR5rC
        lgu1JSCx4venTiO8Gd9Mw/xGgIaY4OlsqVDrm2e5vQiqSL7o6qG8c69etszsiQxq9XQG8G1IO//
        QWtxj+Ayr5b/y
X-Received: by 2002:a05:600c:4f0f:: with SMTP id l15mr14135408wmq.25.1637753941000;
        Wed, 24 Nov 2021 03:39:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJQly1qoyo1MZ7dmK+QaCylfttyz8k9oKNaDBks7ddpPK+LHhw8sWnCXEEzdUtmJkyEGZtWA==
X-Received: by 2002:a05:600c:4f0f:: with SMTP id l15mr14135378wmq.25.1637753940768;
        Wed, 24 Nov 2021 03:39:00 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id m34sm5344595wms.25.2021.11.24.03.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 03:39:00 -0800 (PST)
Date:   Wed, 24 Nov 2021 12:38:59 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: accommodate DWARF/compiler bug with
 duplicated structs
Message-ID: <YZ4kUzG26392CvWi@krava>
References: <20211117194114.347675-1-andrii@kernel.org>
 <CAEf4Bza2NSV8MBb0jSokmUcrzy0SpLvY2uqu4mG9ObxnT-jQLw@mail.gmail.com>
 <YZZiwnWReYnthtzH@krava>
 <CAEf4BzZ9E3Yg2jjCvzdfDN2dCX-hJBqt1cHFvVNzujrx7KWdgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ9E3Yg2jjCvzdfDN2dCX-hJBqt1cHFvVNzujrx7KWdgg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 18, 2021 at 02:49:35PM -0800, Andrii Nakryiko wrote:
> On Thu, Nov 18, 2021 at 6:27 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Wed, Nov 17, 2021 at 11:42:58AM -0800, Andrii Nakryiko wrote:
> > > On Wed, Nov 17, 2021 at 11:41 AM Andrii Nakryiko <andrii@kernel.org> wrote:
> > > >
> > > > According to [0], compilers sometimes might produce duplicate DWARF
> > > > definitions for exactly the same struct/union within the same
> > > > compilation unit (CU). We've had similar issues with identical arrays
> > > > and handled them with a similar workaround in 6b6e6b1d09aa ("libbpf:
> > > > Accomodate DWARF/compiler bug with duplicated identical arrays"). Do the
> > > > same for struct/union by ensuring that two structs/unions are exactly
> > > > the same, down to the integer values of field referenced type IDs.
> > >
> > > Jiri, can you please try this in your setup and see if that handles
> > > all situations or there are more complicated ones still. We'll need a
> > > test for more complicated ones in that case :( Thanks.
> >
> > it seems to help largely, but I still see few modules (67 out of 780)
> > that keep 'struct module' for some reason.. their struct module looks
> > completely the same as is in vmlinux
> 
> Curious, what's the size of all the module BTFs now?

sorry for delay, I was waiting for s390x server

so with 'current' fedora kernel rawhide I'm getting slightly different
total size number than before, so something has changed after the merge
window..

however the increase with BTF enabled in modules is now from 16M to 18M,
so the BTF data adds just about 2M, which I think we can live with

> And yes, please
> try to narrow down what is causing the bloat this time. I think this

I'm on it

> change can go in anyways, it's conceptually the same as a workaround
> for duplicate arrays produced by the compiler.

yes, thanks
jirka

> 
> >
> > I uploaded one of the module with vmlinux in here:
> >   http://people.redhat.com/~jolsa/kmodbtf/2/
> >
> > I will do some debugging and find out why it did not work in this module
> > and try to come up with another test
> >
> > thanks,
> > jirka
> >
> > >
> > > >
> > > > Solving this more generically (allowing referenced types to be
> > > > equivalent, but using different type IDs, all within a single CU)
> > > > requires a huge complexity increase to handle many-to-many mappings
> > > > between canonidal and candidate type graphs. Before we invest in that,
> > > > let's see if this approach handles all the instances of this issue in
> > > > practice. Thankfully it's pretty rare, it seems.
> > > >
> > > >   [0] https://lore.kernel.org/bpf/YXr2NFlJTAhHdZqq@krava/
> > > >
> > > > Reported-by: Jiri Olsa <jolsa@kernel.org>
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  tools/lib/bpf/btf.c | 45 +++++++++++++++++++++++++++++++++++++++++----
> > > >  1 file changed, 41 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > > index b6be579e0dc6..e97217a77196 100644
> > > > --- a/tools/lib/bpf/btf.c
> > > > +++ b/tools/lib/bpf/btf.c
> > > > @@ -3477,8 +3477,8 @@ static long btf_hash_struct(struct btf_type *t)
> > > >  }
> > > >
> > > >  /*
> > > > - * Check structural compatibility of two FUNC_PROTOs, ignoring referenced type
> > > > - * IDs. This check is performed during type graph equivalence check and
> > > > + * Check structural compatibility of two STRUCTs/UNIONs, ignoring referenced
> > > > + * type IDs. This check is performed during type graph equivalence check and
> > > >   * referenced types equivalence is checked separately.
> > > >   */
> > > >  static bool btf_shallow_equal_struct(struct btf_type *t1, struct btf_type *t2)
> > > > @@ -3851,6 +3851,31 @@ static int btf_dedup_identical_arrays(struct btf_dedup *d, __u32 id1, __u32 id2)
> > > >         return btf_equal_array(t1, t2);
> > > >  }
> > > >
> > > > +/* Check if given two types are identical STRUCT/UNION definitions */
> > > > +static bool btf_dedup_identical_structs(struct btf_dedup *d, __u32 id1, __u32 id2)
> > > > +{
> > > > +       const struct btf_member *m1, *m2;
> > > > +       struct btf_type *t1, *t2;
> > > > +       int n, i;
> > > > +
> > > > +       t1 = btf_type_by_id(d->btf, id1);
> > > > +       t2 = btf_type_by_id(d->btf, id2);
> > > > +
> > > > +       if (!btf_is_composite(t1) || btf_kind(t1) != btf_kind(t2))
> > > > +               return false;
> > > > +
> > > > +       if (!btf_shallow_equal_struct(t1, t2))
> > > > +               return false;
> > > > +
> > > > +       m1 = btf_members(t1);
> > > > +       m2 = btf_members(t2);
> > > > +       for (i = 0, n = btf_vlen(t1); i < n; i++, m1++, m2++) {
> > > > +               if (m1->type != m2->type)
> > > > +                       return false;
> > > > +       }
> > > > +       return true;
> > > > +}
> > > > +
> > > >  /*
> > > >   * Check equivalence of BTF type graph formed by candidate struct/union (we'll
> > > >   * call it "candidate graph" in this description for brevity) to a type graph
> > > > @@ -3962,6 +3987,8 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
> > > >
> > > >         hypot_type_id = d->hypot_map[canon_id];
> > > >         if (hypot_type_id <= BTF_MAX_NR_TYPES) {
> > > > +               if (hypot_type_id == cand_id)
> > > > +                       return 1;
> > > >                 /* In some cases compiler will generate different DWARF types
> > > >                  * for *identical* array type definitions and use them for
> > > >                  * different fields within the *same* struct. This breaks type
> > > > @@ -3970,8 +3997,18 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
> > > >                  * types within a single CU. So work around that by explicitly
> > > >                  * allowing identical array types here.
> > > >                  */
> > > > -               return hypot_type_id == cand_id ||
> > > > -                      btf_dedup_identical_arrays(d, hypot_type_id, cand_id);
> > > > +               if (btf_dedup_identical_arrays(d, hypot_type_id, cand_id))
> > > > +                       return 1;
> > > > +               /* It turns out that similar situation can happen with
> > > > +                * struct/union sometimes, sigh... Handle the case where
> > > > +                * structs/unions are exactly the same, down to the referenced
> > > > +                * type IDs. Anything more complicated (e.g., if referenced
> > > > +                * types are different, but equivalent) is *way more*
> > > > +                * complicated and requires a many-to-many equivalence mapping.
> > > > +                */
> > > > +               if (btf_dedup_identical_structs(d, hypot_type_id, cand_id))
> > > > +                       return 1;
> > > > +               return 0;
> > > >         }
> > > >
> > > >         if (btf_dedup_hypot_map_add(d, canon_id, cand_id))
> > > > --
> > > > 2.30.2
> > > >
> > >
> >
> 

