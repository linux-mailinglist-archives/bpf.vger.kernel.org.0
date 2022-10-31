Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47996612E74
	for <lists+bpf@lfdr.de>; Mon, 31 Oct 2022 02:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJaBAf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 30 Oct 2022 21:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJaBAe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 30 Oct 2022 21:00:34 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CED9FD0
        for <bpf@vger.kernel.org>; Sun, 30 Oct 2022 18:00:32 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id o12so17012872lfq.9
        for <bpf@vger.kernel.org>; Sun, 30 Oct 2022 18:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XM2bJ4qHXjUmTpq/MS/3xC8WCEmQHSN7mgsogc0Nv8g=;
        b=VZkGpBt7WvgRNpdkHjULtXn/AZGMv7/gvPsbcFuG829vbg5bIT616jm2+myrubzLHd
         TIMyo0XsCG7CTLKWm5z9lFnuWqFgo4yioFZdu4aDYUQ/ozIg+qn/2EIhgwGoXxigay+C
         MFDpK94H1scxEN3vhvJGYoZvO4EbTomq9GV5+DQjXLr29R8Ynyorza6Jhw+QI55gMFOD
         VJimZpB7slQwlsGj0hw2xlXKQziPBq3KZYu6nHvIXQ8SKfuz2elUm46FXqxjKV7wU8hv
         oaSsPhHrMbIFgXIr+eIT2pUA3Z+hW8NRxI8c6dn0Sa5QQuWan5vuSDWL9yZrU9rFCk1a
         EAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XM2bJ4qHXjUmTpq/MS/3xC8WCEmQHSN7mgsogc0Nv8g=;
        b=fHP7dXGuskXOQGKNxcx5UC96k6eJLrwWKq+dqDb/N/TtXAN/G4ixB4lCqtVAr0QFzv
         nn8zIfTeEZw9KSMUMPxMqXtoPJWlxBNzQxvpFJplukQhgosnLIDNj9cl5CyDNs79JGls
         dJN/IG6hI1ZDx9k2iIktAWRjt2geRYzdfFWeJ457VeZ3ZqN7iEtywo938T7Y3px3VGY0
         QQalhE9RGuRIKUafNuymIrfgyV07C82rMnweOR14uqR+H8ZvYod/NW5r8hMwoA6Cq7hG
         UJhdp9VoK4XWFvCRmjPnZyLgQyco7gVikyxeBYH0j8bwgKmQwpV9Chbz6pGWW/8WiYAo
         ldjA==
X-Gm-Message-State: ACrzQf3pfc/AGXo//DEvyyr7o/Z/xRhiMFqImTe+PWzd1RSK3faGZJi7
        5+9lzqwuXl6w2H5TSYE5JVN2N3DjYqJaShzC
X-Google-Smtp-Source: AMsMyM7E4b6WUuv1nzrRsfwmERcUDbXZzjaeDcBrpLNbjriJUs6eozwE7id0L4eDTpGUTHbMp6BYPQ==
X-Received: by 2002:a05:6512:1156:b0:4a2:7e51:b3e0 with SMTP id m22-20020a056512115600b004a27e51b3e0mr4562446lfg.118.1667178031078;
        Sun, 30 Oct 2022 18:00:31 -0700 (PDT)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id r4-20020ac25f84000000b004a26debaf1fsm1025204lfe.117.2022.10.30.18.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 18:00:30 -0700 (PDT)
Message-ID: <8da108a196542eb2d85327b4eeb9c8630fe8cf60.camel@gmail.com>
Subject: Re: [RFC bpf-next 01/12] libbpf: Deduplicate unambigous standalone
 forward declarations
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        arnaldo.melo@gmail.com
Date:   Mon, 31 Oct 2022 03:00:29 +0200
In-Reply-To: <CAEf4Bzaf8XhO6OPoKSHPPSa1oQQ+KFHeN5Rmp0vn_9dgvOkOYw@mail.gmail.com>
References: <20221025222802.2295103-1-eddyz87@gmail.com>
         <20221025222802.2295103-2-eddyz87@gmail.com>
         <CAEf4Bzaf8XhO6OPoKSHPPSa1oQQ+KFHeN5Rmp0vn_9dgvOkOYw@mail.gmail.com>
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

On Thu, 2022-10-27 at 15:07 -0700, Andrii Nakryiko wrote:
> On Tue, Oct 25, 2022 at 3:28 PM Eduard Zingerman <eddyz87@gmail.com> wrot=
e:
> >=20
> > Deduplicate forward declarations that don't take part in type graphs
> > comparisons if declaration name is unambiguous. Example:
> >=20
> > CU #1:
> >=20
> > struct foo;              // standalone forward declaration
> > struct foo *some_global;
> >=20
> > CU #2:
> >=20
> > struct foo { int x; };
> > struct foo *another_global;
> >=20
> > The `struct foo` from CU #1 is not a part of any definition that is
> > compared against another definition while `btf_dedup_struct_types`
> > processes structural types. The the BTF after `btf_dedup_struct_types`
> > the BTF looks as follows:
> >=20
> > [1] STRUCT 'foo' size=3D4 vlen=3D1 ...
> > [2] INT 'int' size=3D4 ...
> > [3] PTR '(anon)' type_id=3D1
> > [4] FWD 'foo' fwd_kind=3Dstruct
> > [5] PTR '(anon)' type_id=3D4
> >=20
> > This commit adds a new pass `btf_dedup_standalone_fwds`, that maps
> > such forward declarations to structs or unions with identical name in
> > case if the name is not ambiguous.
> >=20
> > The pass is positioned before `btf_dedup_ref_types` so that types
> > [3] and [5] could be merged as a same type after [1] and [4] are merged=
.
> > The final result for the example above looks as follows:
> >=20
> > [1] STRUCT 'foo' size=3D4 vlen=3D1
> >         'x' type_id=3D2 bits_offset=3D0
> > [2] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
> > [3] PTR '(anon)' type_id=3D1
> >=20
> > For defconfig kernel with BTF enabled this removes 63 forward
> > declarations. Examples of removed declarations: `pt_regs`, `in6_addr`.
> > The running time of `btf__dedup` function is increased by about 3%.
> >=20
>=20
> What about modules, can you share stats for module BTFs?
>=20
> Also cc Alan as he was looking at BTF dedup improvements for kernel
> module BTF dedup.
>=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  tools/lib/bpf/btf.c | 178 +++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 174 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index d88647da2c7f..c34c68d8e8a0 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -2881,6 +2881,7 @@ static int btf_dedup_strings(struct btf_dedup *d)=
;
> >  static int btf_dedup_prim_types(struct btf_dedup *d);
> >  static int btf_dedup_struct_types(struct btf_dedup *d);
> >  static int btf_dedup_ref_types(struct btf_dedup *d);
> > +static int btf_dedup_standalone_fwds(struct btf_dedup *d);
> >  static int btf_dedup_compact_types(struct btf_dedup *d);
> >  static int btf_dedup_remap_types(struct btf_dedup *d);
> >=20
> > @@ -2988,15 +2989,16 @@ static int btf_dedup_remap_types(struct btf_ded=
up *d);
> >   * Algorithm summary
> >   * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   *
> > - * Algorithm completes its work in 6 separate passes:
> > + * Algorithm completes its work in 7 separate passes:
> >   *
> >   * 1. Strings deduplication.
> >   * 2. Primitive types deduplication (int, enum, fwd).
> >   * 3. Struct/union types deduplication.
> > - * 4. Reference types deduplication (pointers, typedefs, arrays, funcs=
, func
> > + * 4. Standalone fwd declarations deduplication.
>=20
> Let's call this "Resolve unambiguous forward declarations", we don't
> really deduplicate anything. And call the function
> btf_dedup_resolve_fwds()?
>=20
> > + * 5. Reference types deduplication (pointers, typedefs, arrays, funcs=
, func
> >   *    protos, and const/volatile/restrict modifiers).
> > - * 5. Types compaction.
> > - * 6. Types remapping.
> > + * 6. Types compaction.
> > + * 7. Types remapping.
> >   *
> >   * Algorithm determines canonical type descriptor, which is a single
> >   * representative type for each truly unique type. This canonical type=
 is the
> > @@ -3060,6 +3062,11 @@ int btf__dedup(struct btf *btf, const struct btf=
_dedup_opts *opts)
> >                 pr_debug("btf_dedup_struct_types failed:%d\n", err);
> >                 goto done;
> >         }
> > +       err =3D btf_dedup_standalone_fwds(d);
> > +       if (err < 0) {
> > +               pr_debug("btf_dedup_standalone_fwd failed:%d\n", err);
> > +               goto done;
> > +       }
> >         err =3D btf_dedup_ref_types(d);
> >         if (err < 0) {
> >                 pr_debug("btf_dedup_ref_types failed:%d\n", err);
> > @@ -4525,6 +4532,169 @@ static int btf_dedup_ref_types(struct btf_dedup=
 *d)
> >         return 0;
> >  }
> >=20
> > +/*
> > + * `name_off_map` maps name offsets to type ids (essentially __u32 -> =
__u32).
> > + *
> > + * The __u32 key/value representations are cast to `void *` before pas=
sing
> > + * to `hashmap__*` functions. These pseudo-pointers are never derefere=
nced.
> > + *
> > + */
> > +static struct hashmap *name_off_map__new(void)
> > +{
> > +       return hashmap__new(btf_dedup_identity_hash_fn,
> > +                           btf_dedup_equal_fn,
> > +                           NULL);
> > +}
>=20
> is there a point in name_off_map__new and name_off_map__find wrappers
> except to add one extra function to jump through when reading the
> code? If you look at other uses of hashmaps in this file, we use the
> directly. Let's drop those.
>=20
> > +
> > +static int name_off_map__find(struct hashmap *map, __u32 name_off, __u=
32 *type_id)
> > +{
> > +       /* This has to be sizeof(void *) in order to be passed to hashm=
ap__find */
> > +       void *tmp;
> > +       int found =3D hashmap__find(map, (void *)(ptrdiff_t)name_off, &=
tmp);
>=20
> but this (void *) casting everything was an error in API design, mea
> culpa. I've been wanting to switch hashmap to use long as key/value
> type for a long while, maybe let's do it now, as we are adding even
> more code that looks weird? It seems like accepting long will make
> hashmap API usage cleaner in most cases. There are not a lot of places
> where we use hashmap APIs in libbpf, but we'll also need to fix up
> bpftool usage, and I believe perf copy/pasted hashmap.h (cc Arnaldo),
> so we'd need to make sure to not break all that. But good thing it's
> all in the same repo and we can convert them at the same time with no
> breakage.
>=20
> WDYT?

Well, I did the change, excluding tests it amounts to:
- 15 files changed, 114 insertions(+), 137 deletions(-);
- 45 casts removed;
- 30 casts added.

TBH, it seems like I should just use "u32_as_hash_field" and be done
with it. In any case I'll post this as a part of v1 series for
"libbpf: Resolve unambigous forward declarations".

To account for a case when map has to store pointers and pointers are
32 bit I chose to update the map interface to be "uintptr_t -> uintptr_t".
Had it been "u64 -> u64" the additional temporary variable would be
necessary for "old" values, e.g. while working with hashmap__insert.
(Contrary to what we discussed on Friday).

>=20
> > +       /*
> > +        * __u64 cast is necessary to avoid pointer to integer conversi=
on size warning.
> > +        * It is fine to get rid of this warning as `void *` is used as=
 an integer value.
> > +        */
> > +       if (found)
> > +               *type_id =3D (__u64)tmp;
> > +       return found;
> > +}
> > +
> > +static int name_off_map__set(struct hashmap *map, __u32 name_off, __u3=
2 type_id)
> > +{
> > +       return hashmap__set(map, (void *)(size_t)name_off, (void *)(siz=
e_t)type_id,
> > +                           NULL, NULL);
> > +}
>=20
> this function will also be completely unnecessary with longs
>=20
> > +
> > +/*
> > + * Collect a `name_off_map` that maps type names to type ids for all
> > + * canonical structs and unions. If the same name is shared by several
> > + * canonical types use a special value 0 to indicate this fact.
> > + */
> > +static int btf_dedup_fill_unique_names_map(struct btf_dedup *d, struct=
 hashmap *names_map)
> > +{
> > +       int i, err =3D 0;
> > +       __u32 type_id, collision_id;
> > +       __u16 kind;
> > +       struct btf_type *t;
> > +
> > +       for (i =3D 0; i < d->btf->nr_types; i++) {
> > +               type_id =3D d->btf->start_id + i;
> > +               t =3D btf_type_by_id(d->btf, type_id);
> > +               kind =3D btf_kind(t);
> > +
> > +               if (kind !=3D BTF_KIND_STRUCT && kind !=3D BTF_KIND_UNI=
ON)
> > +                       continue;
>=20
> let's also do ENUM FWD resolution. ENUM FWD is just ENUM with vlen=3D0
>=20
> > +
> > +               /* Skip non-canonical types */
> > +               if (type_id !=3D d->map[type_id])
> > +                       continue;
> > +
> > +               err =3D 0;
> > +               if (name_off_map__find(names_map, t->name_off, &collisi=
on_id)) {
> > +                       /* Mark non-unique names with 0 */
> > +                       if (collision_id !=3D 0 && collision_id !=3D ty=
pe_id)
> > +                               err =3D name_off_map__set(names_map, t-=
>name_off, 0);
> > +               } else {
> > +                       err =3D name_off_map__set(names_map, t->name_of=
f, type_id);
> > +               }
>=20
> err =3D hashmap__add(..., t->name_off, type_id);
> if (err =3D=3D -EEXISTS) {
>     hashmap__set(..., 0);
>     return 0;
> }
>=20
> see comment for hashmap_insert_strategy in hashmap.h
>=20
> > +
> > +               if (err < 0)
> > +                       return err;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int btf_dedup_standalone_fwd(struct btf_dedup *d,
> > +                                   struct hashmap *names_map,
> > +                                   __u32 type_id)
> > +{
> > +       struct btf_type *t =3D btf_type_by_id(d->btf, type_id);
> > +       __u16 kind =3D btf_kind(t);
> > +       enum btf_fwd_kind fwd_kind =3D BTF_INFO_KFLAG(t->info);
> > +
>=20
> nit: don't break variables block in two parts, there shouldn't be empty l=
ines
>=20
> also please use btf_kflag(t)
>=20
>=20
> > +       struct btf_type *cand_t;
> > +       __u16 cand_kind;
> > +       __u32 cand_id =3D 0;
> > +
> > +       if (kind !=3D BTF_KIND_FWD)
> > +               return 0;
> > +
> > +       /* Skip if this FWD already has a mapping */
> > +       if (type_id !=3D d->map[type_id])
> > +               return 0;
> > +
>=20
> [...]


