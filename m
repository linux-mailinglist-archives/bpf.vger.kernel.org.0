Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035F461E69C
	for <lists+bpf@lfdr.de>; Sun,  6 Nov 2022 22:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiKFVkh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Nov 2022 16:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiKFVkg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Nov 2022 16:40:36 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6E6101E9
        for <bpf@vger.kernel.org>; Sun,  6 Nov 2022 13:40:34 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id o4so13749106wrq.6
        for <bpf@vger.kernel.org>; Sun, 06 Nov 2022 13:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R/3oEHQkDejrUSKuDvNfOU1C2MnTtEVlPcLj5qHsBMY=;
        b=fPaoxUPHGXyFxt0ohjByULdNRWFUMXRFmEI0QFGQNF34jdmxgbg41FkVuPGv7k1ejY
         yajx6QoD9sM9Gp/hzxINlUWDETth7fdW+WnSRSCcNYNrOzOMXLlWyI9W14XvMuzIkza+
         v4i5nkQBLrG9F9Oa5REjNP648DU5O6THbldfeNsTUz5kqHoLvHIRBl/6wfRn7gACo3TN
         OVFY9Nyd/IuGpaNEQqhiknpHCPknnhL3q3Rs8aea660eaE6x0Y8blNv3SED60LGNcZkx
         q0sovdiTERtf9/Ysh9meKxOcCiT2UwetPdx9TKRa6Jcrd8+bw1PHdgvp1H1fkNmK9sxP
         MOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R/3oEHQkDejrUSKuDvNfOU1C2MnTtEVlPcLj5qHsBMY=;
        b=6ueXqWILhdBszve6CRasBuE+fmQNHWeUbwQfCnsstf64sJp4zRwt6eE1Arv2lSFtbr
         vxMfPbUYpQQVVWL8M+B/zD+lAfqAJKO+Pqu5DhTLeCA2KWvYeEg2trQogyXQC4zgsLi+
         QRxTx7KG1eStWCHjWjDi/uVOmJdWOKc3pocDiOqb5XSvfuzi9qp78JGQXORDc+unk9Gr
         LoW/P7dBfl72HsLjOE4n6hIyy45lfgMHxWGBDWkgra82NjcdJUZKAoJcd+bzlF+euJUk
         4uXmxv3SHPwYB6X0l8ke6HXGrueIrpac/UNv7Y9Fd33tizCz33AjZ0PQpKZKkbJCOpEF
         JVZQ==
X-Gm-Message-State: ACrzQf28ugiQNTKvRdm7OtmAPIdIMOx/AAjoSvs+gp9/iH+vyUho1Nc6
        Vo14jonH6XXyoABm3lbsc0c=
X-Google-Smtp-Source: AMsMyM6PZuX1nlyIqQsp4QC+Mq11aunvQ5a4W49ETK7tC0teGAAr2kSo92gRGsaPdSskLfI8ABwqhQ==
X-Received: by 2002:adf:e785:0:b0:236:5998:67a0 with SMTP id n5-20020adfe785000000b00236599867a0mr29826963wrm.414.1667770832783;
        Sun, 06 Nov 2022 13:40:32 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id ay15-20020a05600c1e0f00b003c6deb5c1edsm6392476wmb.45.2022.11.06.13.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 13:40:31 -0800 (PST)
Message-ID: <79ac9dd769fd83ffd1ba61598cb4d2124e8568b6.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf:
 __attribute__((btf_decl_tag("..."))) for btf dump in C format
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        alan.maguire@oracle.com
Date:   Sun, 06 Nov 2022 23:40:30 +0200
In-Reply-To: <CAEf4Bzb9dcBy5JEWzphkfr=wzvcT8gXcCjA5UYPPKAywh=k_Fg@mail.gmail.com>
References: <20221103134522.2764601-1-eddyz87@gmail.com>
         <CAEf4Bzb9dcBy5JEWzphkfr=wzvcT8gXcCjA5UYPPKAywh=k_Fg@mail.gmail.com>
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

On Fri, 2022-11-04 at 13:54 -0700, Andrii Nakryiko wrote:
> On Thu, Nov 3, 2022 at 6:45 AM Eduard Zingerman <eddyz87@gmail.com> wrote=
:
> >=20
> > Clang's `__attribute__((btf_decl_tag("...")))` is represented in BTF
> > as a record of kind BTF_KIND_DECL_TAG with `type` field pointing to
> > the type annotated with this attribute. This commit adds
> > reconstitution of such attributes for BTF dump in C format.
> >=20
> > BTF doc says that BTF_KIND_DECL_TAGs should follow a target type but
> > this is not enforced and tests don't honor this restriction.
> > This commit uses hashmap to map types to the list of decl tags.
> > The hashmap is filled by `btf_dump_assign_decl_tags` function called
> > from `btf_dump__new`.
> >=20
> > It is assumed that total number of types annotated with decl tags is
> > relatively small, thus some space is saved by using hashmap instead of
> > adding a new field to `struct btf_dump_type_aux_state`.
> >=20
> > It is assumed that list of decl tags associated with a single type is
> > small. Thus the list is represented by an array which grows linearly.
> >=20
> > To accommodate older Clang versions decl tags are dumped using the
> > following macro:
> >=20
> >  #if __has_attribute(btf_decl_tag)
> >  #  define __btf_decl_tag(x) __attribute__((btf_decl_tag(x)))
> >  #else
> >  #  define __btf_decl_tag(x)
> >  #endif
> >=20
> > The macro definition is emitted upon first call to `btf_dump__dump_type=
`.
> >=20
> > Clang allows to attach btf_decl_tag attributes to the following kinds
> > of items:
> > - struct/union         supported
> > - struct/union field   supported
> > - typedef              supported
> > - function             not applicable
> > - function parameter   not applicable
> > - variable             not applicable
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  tools/lib/bpf/btf_dump.c | 163 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 160 insertions(+), 3 deletions(-)
> >=20
>=20
> Functions and their args can also have tags. This works:
>=20
> diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_ta=
g.c
> b/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
> index 7a5af8b86065..75fcabe700cd 100644
> --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
> +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
> @@ -54,7 +54,7 @@ struct root_struct {
>=20
>  /* ------ END-EXPECTED-OUTPUT ------ */
>=20
> -int f(struct root_struct *s)
> +int f(struct root_struct *s __btf_decl_tag("func_arg_tag"))
> __btf_decl_tag("func_tag")
>  {
>         return 0;
>  }
>=20
> And I see correct BTF:
>=20
> [26] FUNC 'f' type_id=3D25 linkage=3Dglobal
> [27] DECL_TAG 'func_arg_tag' type_id=3D26 component_idx=3D0
> [28] DECL_TAG 'func_tag' type_id=3D26 component_idx=3D-1
>=20
> So let's add support and test for that case as well. btf_dump
> shouldn't assume vmlinux.h-only case.
>=20
> Also, please check if DATASEC and VARs can have decl_tags associated with=
 them.
>=20
> [...]
>=20
> > @@ -143,6 +174,7 @@ static void btf_dump_printf(const struct btf_dump *=
d, const char *fmt, ...)
> >=20
> >  static int btf_dump_mark_referenced(struct btf_dump *d);
> >  static int btf_dump_resize(struct btf_dump *d);
> > +static int btf_dump_assign_decl_tags(struct btf_dump *d);
> >=20
> >  struct btf_dump *btf_dump__new(const struct btf *btf,
> >                                btf_dump_printf_fn_t printf_fn,
> > @@ -179,11 +211,21 @@ struct btf_dump *btf_dump__new(const struct btf *=
btf,
> >                 d->ident_names =3D NULL;
> >                 goto err;
> >         }
> > +       d->decl_tags =3D hashmap__new(identity_hash_fn, identity_equal_=
fn, NULL);
> > +       if (IS_ERR(d->decl_tags)) {
> > +               err =3D PTR_ERR(d->decl_tags);
> > +               d->decl_tags =3D NULL;
>=20
> nit: no need to clear out ERR pointer, hashmap__free() handles that prope=
rly

The `err` is passed to `libbpf_err_ptr` at the end of the function:

struct btf_dump *btf_dump__new(...)
{
	...
err:
	btf_dump__free(d);
	return libbpf_err_ptr(err);
}

The `libbpf_err_ptr` uses it to update the `errno` global. So I think
that PTR_ERR call is not redundant in this case.

>=20
> > +               goto err;
> > +       }
> >=20
> >         err =3D btf_dump_resize(d);
> >         if (err)
> >                 goto err;
> >=20
> > +       err =3D btf_dump_assign_decl_tags(d);
> > +       if (err)
> > +               goto err;
> > +
> >         return d;
> >  err:
> >         btf_dump__free(d);
> > @@ -232,7 +274,8 @@ static void btf_dump_free_names(struct hashmap *map=
)
> >=20
> >  void btf_dump__free(struct btf_dump *d)
> >  {
> > -       int i;
> > +       int i, bkt;
> > +       struct hashmap_entry *cur;
> >=20
> >         if (IS_ERR_OR_NULL(d))
> >                 return;
> > @@ -248,14 +291,22 @@ void btf_dump__free(struct btf_dump *d)
> >         free(d->cached_names);
> >         free(d->emit_queue);
> >         free(d->decl_stack);
> > -       btf_dump_free_names(d->type_names);
> > -       btf_dump_free_names(d->ident_names);
> > +       if (d->type_names)
> > +               btf_dump_free_names(d->type_names);
> > +       if (d->ident_names)
> > +               btf_dump_free_names(d->ident_names);
> > +       if (d->decl_tags) {
> > +               hashmap__for_each_entry(d->decl_tags, cur, bkt)
> > +                       free(cur->value);
> > +               hashmap__free(d->decl_tags);
>=20
> generalize btf_dump_free_names() to btf_dump_free_strs_map() and
> handle IS_ERR_OR_NULL call internally?
>=20
> > +       }
> >=20
> >         free(d);
> >  }
> >=20
> >  static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool thro=
ugh_ptr);
> >  static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 con=
t_id);
> > +static void btf_dump_maybe_define_btf_decl_tag(struct btf_dump *d);
>=20
> naming nit: btf_dump_ensure_btf_decl_tag_macro() ?
>=20
> >=20
> >  /*
> >   * Dump BTF type in a compilable C syntax, including all the necessary
> > @@ -284,6 +335,8 @@ int btf_dump__dump_type(struct btf_dump *d, __u32 i=
d)
> >         if (err)
> >                 return libbpf_err(err);
> >=20
> > +       btf_dump_maybe_define_btf_decl_tag(d);
> > +
> >         d->emit_queue_cnt =3D 0;
> >         err =3D btf_dump_order_type(d, id, false);
> >         if (err < 0)
> > @@ -373,6 +426,61 @@ static int btf_dump_mark_referenced(struct btf_dum=
p *d)
> >         return 0;
> >  }
> >=20
> > +/*
> > + * This hashmap lookup is used in several places, so extract it as a
> > + * function to hide all the ceremony with casts and NULL assignment.
> > + */
> > +static struct decl_tag_array *btf_dump_find_decl_tags(struct btf_dump =
*d, __u32 id)
> > +{
> > +       struct decl_tag_array *decl_tags =3D NULL;
> > +
> > +       hashmap__find(d->decl_tags, (void *)(uintptr_t)id, (void **)&de=
cl_tags);
> > +
> > +       return decl_tags;
> > +}
> > +
>=20
> with your hashmap void * -> long refactoring this is not necessary,
> though, right?

If that refactoring is accepted the casts would go away, but it is
still convenient for me to have a function returning pointer for the
in the btf_dump_emit_typedef_def. I can inline it in all three call
locations, but I think it is a bit cleaner this way.

>=20
> > +/*
> > + * Scans all BTF objects looking for BTF_KIND_DECL_TAG entries.
> > + * The id's of the entries are stored in the `btf_dump.decl_tags` tabl=
e,
> > + * grouped by a target type.
> > + */
> > +static int btf_dump_assign_decl_tags(struct btf_dump *d)
> > +{
> > +       __u32 id, new_cnt, type_cnt =3D btf__type_cnt(d->btf);
> > +       struct decl_tag_array *decl_tags;
> > +       const struct btf_type *t;
> > +       int err;
> > +
> > +       for (id =3D 1; id < type_cnt; id++) {
> > +               t =3D btf__type_by_id(d->btf, id);
> > +               if (!btf_is_decl_tag(t))
> > +                       continue;
> > +
> > +               decl_tags =3D btf_dump_find_decl_tags(d, t->type);
> > +               /* Assume small number of decl tags per id, increase ar=
ray size by 1 */
> > +               new_cnt =3D decl_tags ? decl_tags->cnt + 1 : 1;
> > +               if (new_cnt > MAX_DECL_TAGS_PER_ID)
> > +                       return -ERANGE;
>=20
> why artificial limitations? user will pay the price proportional to
> its BTF, and we don't really care as the memory is allocated
> dynamically anyway

Since you requested to change allocation strategy from buffer doubling
to +1 I figured that this point would get unusably slow for some large
enough value. I'll remove this limitation.

>=20
> > +
> > +               /* Allocate new_cnt + 1 to account for decl_tag_array h=
eader */
> > +               decl_tags =3D libbpf_reallocarray(decl_tags, new_cnt + =
1, sizeof(__u32));
>=20
> oh, this new_cnt + 1 looks weird and error prone. we are reallocating
> entire struct, not just an array, so realloc() makes more sense here.
> How about:
>=20
> decl_tags =3D realloc(decl_tags, sizeof(decl_tags) + new_cnt *
> sizeof(decl_tags->tag_ids[0]));
>=20
> ?

Ok, will replace with realloc.

>=20
> > +               if (!decl_tags)
> > +                       return -ENOMEM;
> > +
> > +               err =3D hashmap__insert(d->decl_tags, (void *)(uintptr_=
t)t->type, decl_tags,
> > +                                     HASHMAP_SET, NULL, NULL);
>=20
> why not using hashmap__set()?
>=20
> > +               if (err) {
> > +                       free(decl_tags);
>=20
> hm... as this is written, it makes it look like double free can happen
> if previous version of this pointer stays in d->decl_tags.

It can indeed, thank you for catching this.

>=20
> I think error shouldn't ever be returned because hashmap__insert()
> won't be allocating any new memory, so I think it's best to leave a
> small comment about this and just do:
>=20
> (void)hashmap__set(d->decl_tag, t->type, (long)decl_tags, NULL, NULL);
>=20
> and no error checking because we don't expect it to ever fail
>=20
> > +                       return err;
> > +               }
> > +
> > +               decl_tags->tag_ids[new_cnt - 1] =3D id;
> > +               decl_tags->cnt =3D new_cnt;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static int btf_dump_add_emit_queue_id(struct btf_dump *d, __u32 id)
> >  {
> >         __u32 *new_queue;
> > @@ -899,6 +1007,51 @@ static void btf_dump_emit_bit_padding(const struc=
t btf_dump *d,
> >         }
> >  }
> >=20
> > +/*
> > + * Define __btf_decl_tag to be either __attribute__ or noop.
> > + */
> > +static void btf_dump_maybe_define_btf_decl_tag(struct btf_dump *d)
> > +{
> > +       if (d->btf_decl_tag_is_defined || !hashmap__size(d->decl_tags))
> > +               return;
> > +
> > +       d->btf_decl_tag_is_defined =3D true;
> > +       btf_dump_printf(d, "#if __has_attribute(btf_decl_tag)\n");
> > +       btf_dump_printf(d, "#  define __btf_decl_tag(x) __attribute__((=
btf_decl_tag(x)))\n");
> > +       btf_dump_printf(d, "#else\n");
> > +       btf_dump_printf(d, "#  define __btf_decl_tag(x)\n");
> > +       btf_dump_printf(d, "#endif\n\n");
> > +}
> > +
>=20
> $ rg '#\s+define' | wc -l
> 44
> $ rg '#define' | wc -l
> 696
>=20
> not a big fan of this cuteness, #define is better IMO (more grep'able
> as well, if anything)
>=20
> > +/*
> > + * Emits a list of __btf_decl_tag(...) attributes attached to some typ=
e.
> > + * Decl tags attached to a type and to it's fields reside in a same
> > + * list, thus use component_idx to filter out relevant tags:
> > + * - component_idx =3D=3D -1 designates the type itself;
> > + * - component_idx >=3D  0 designates specific field.
> > + */
> > +static void btf_dump_emit_decl_tags(struct btf_dump *d,
> > +                                   struct decl_tag_array *decl_tags,
> > +                                   int component_idx)
> > +{
> > +       struct btf_type *decl_tag_t;
>=20
> is there any ambiguity to justify verbose name? maybe just "t"?
>=20
> > +       const char *decl_tag_text;
> > +       struct btf_decl_tag *tag;
> > +       __u32 i;
> > +
> > +       if (!decl_tags)
> > +               return;
> > +
> > +       for (i =3D 0; i < decl_tags->cnt; ++i) {
> > +               decl_tag_t =3D btf_type_by_id(d->btf, decl_tags->tag_id=
s[i]);
> > +               tag =3D btf_decl_tag(decl_tag_t);
> > +               if (tag->component_idx !=3D component_idx)
> > +                       continue;
> > +               decl_tag_text =3D btf__name_by_offset(d->btf, decl_tag_=
t->name_off);
> > +               btf_dump_printf(d, " __btf_decl_tag(\"%s\")", decl_tag_=
text);
> > +       }
> > +}
> > +
> >  static void btf_dump_emit_struct_fwd(struct btf_dump *d, __u32 id,
> >                                      const struct btf_type *t)
> >  {
> > @@ -913,6 +1066,7 @@ static void btf_dump_emit_struct_def(struct btf_du=
mp *d,
> >                                      const struct btf_type *t,
> >                                      int lvl)
> >  {
> > +       struct decl_tag_array *decl_tags =3D btf_dump_find_decl_tags(d,=
 id);
> >         const struct btf_member *m =3D btf_members(t);
> >         bool is_struct =3D btf_is_struct(t);
> >         int align, i, packed, off =3D 0;
> > @@ -945,6 +1099,7 @@ static void btf_dump_emit_struct_def(struct btf_du=
mp *d,
> >                         m_sz =3D max((__s64)0, btf__resolve_size(d->btf=
, m->type));
> >                         off =3D m_off + m_sz * 8;
> >                 }
> > +               btf_dump_emit_decl_tags(d, decl_tags, i);
> >                 btf_dump_printf(d, ";");
> >         }
> >=20
> > @@ -964,6 +1119,7 @@ static void btf_dump_emit_struct_def(struct btf_du=
mp *d,
> >         btf_dump_printf(d, "%s}", pfx(lvl));
> >         if (packed)
> >                 btf_dump_printf(d, " __attribute__((packed))");
> > +       btf_dump_emit_decl_tags(d, decl_tags, -1);
> >  }
> >=20
> >  static const char *missing_base_types[][2] =3D {
> > @@ -1104,6 +1260,7 @@ static void btf_dump_emit_typedef_def(struct btf_=
dump *d, __u32 id,
> >=20
> >         btf_dump_printf(d, "typedef ");
> >         btf_dump_emit_type_decl(d, t->type, name, lvl);
> > +       btf_dump_emit_decl_tags(d, btf_dump_find_decl_tags(d, id), -1);
> >  }
> >=20
> >  static int btf_dump_push_decl_stack_id(struct btf_dump *d, __u32 id)
> > --
> > 2.34.1
> >=20

