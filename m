Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0DE62029B
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 23:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiKGWwX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 17:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiKGWwW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 17:52:22 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A720E27CDF
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 14:52:20 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r14so19920457edc.7
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 14:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0RkmE0jNh3TwVvJwHbhi5QIqyA+cJcCbAgJmkfGEs2o=;
        b=qVM9nFTnlU2Znbl+opbL/Aze46NyYuTpb2kNOUfed4+5Jv4zSxQ+c1QkK5Ytczjvyi
         Gl5jAO1M8JuTvjvdKRLR+iIhE8IMNyWwdJylLrD0VtlJE8iJt4TqM1GT44ZQiv4LJJTJ
         B0xmOLHIGyZ6vGGyM4DTPqbKda8MwTQx3mrtgfJVxYxIfswox+mUG4n5EGbwdYKc4gjN
         f9LS99ClFtY9jXjW3ITzYzRP7ID0wAPx6fTwE5cwymWTO7EmnMUtULiHljXBpbAmmntz
         ptTIL+gEsXiju+/Ed4WR+EQDoWRAH8kmHblu/1Cm55FQdpPKRAq3f/a21wM0zLmpA6tl
         5v4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0RkmE0jNh3TwVvJwHbhi5QIqyA+cJcCbAgJmkfGEs2o=;
        b=kl/oG5ERnwweYeOjXE0rdEHK3ZaWck7sTl+38rrrFCoC5MsJ4IRDfIwhcHoUZKKx14
         b10tUj3TN7vPiENiD1BOsy+IQ+DdmnaCc+v34S9rFdoWmQjsJIhVfLgxg4noaLvKjoge
         quDm7uI9n8EP4nWM+HSS8eJEvhYosqDGBbQDOqDMRPaTueo0p8SHR+ZrSCT2rez2to1n
         Fa82+r+5sVwVHfr3QEhw/9YfDYckcNK7YlEYbnH5Za0A8E5Ao8+5uAG5QWl3Xs9/G7CC
         DngPiePY/74egdILM4hKqYrH2B5lIaMYnhuS8Woc/R0qQI9jcwo0fo1T8QW/t/U25tSu
         wSCA==
X-Gm-Message-State: ACrzQf0SPprW7Xlrz3qyWk/iFji1hqLoXP9+ibGHmBc3ezt7YK4ahGXb
        ZVLljuy58nOBfMhX59mlTg7pVIjLkkry8uekGoo=
X-Google-Smtp-Source: AMsMyM7MhwsRvguE8n1pHTtoawBZv3KJ7WHANLl1oY5OacCbrJ6mb3hnfCwyfFW6lRpq9h07p4Vchd812I4bKwqcq5U=
X-Received: by 2002:a05:6402:3641:b0:45c:4231:ddcc with SMTP id
 em1-20020a056402364100b0045c4231ddccmr53599458edb.224.1667861539013; Mon, 07
 Nov 2022 14:52:19 -0800 (PST)
MIME-Version: 1.0
References: <20221103134522.2764601-1-eddyz87@gmail.com> <CAEf4Bzb9dcBy5JEWzphkfr=wzvcT8gXcCjA5UYPPKAywh=k_Fg@mail.gmail.com>
 <79ac9dd769fd83ffd1ba61598cb4d2124e8568b6.camel@gmail.com>
In-Reply-To: <79ac9dd769fd83ffd1ba61598cb4d2124e8568b6.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Nov 2022 14:52:06 -0800
Message-ID: <CAEf4BzYaQyc8f0yzKAeJNtf07n5JFoR=wcaSLh8eAfRj_Lueig@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: __attribute__((btf_decl_tag("...")))
 for btf dump in C format
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        alan.maguire@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 6, 2022 at 1:40 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Fri, 2022-11-04 at 13:54 -0700, Andrii Nakryiko wrote:
> > On Thu, Nov 3, 2022 at 6:45 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > >
> > > Clang's `__attribute__((btf_decl_tag("...")))` is represented in BTF
> > > as a record of kind BTF_KIND_DECL_TAG with `type` field pointing to
> > > the type annotated with this attribute. This commit adds
> > > reconstitution of such attributes for BTF dump in C format.
> > >
> > > BTF doc says that BTF_KIND_DECL_TAGs should follow a target type but
> > > this is not enforced and tests don't honor this restriction.
> > > This commit uses hashmap to map types to the list of decl tags.
> > > The hashmap is filled by `btf_dump_assign_decl_tags` function called
> > > from `btf_dump__new`.
> > >
> > > It is assumed that total number of types annotated with decl tags is
> > > relatively small, thus some space is saved by using hashmap instead of
> > > adding a new field to `struct btf_dump_type_aux_state`.
> > >
> > > It is assumed that list of decl tags associated with a single type is
> > > small. Thus the list is represented by an array which grows linearly.
> > >
> > > To accommodate older Clang versions decl tags are dumped using the
> > > following macro:
> > >
> > >  #if __has_attribute(btf_decl_tag)
> > >  #  define __btf_decl_tag(x) __attribute__((btf_decl_tag(x)))
> > >  #else
> > >  #  define __btf_decl_tag(x)
> > >  #endif
> > >
> > > The macro definition is emitted upon first call to `btf_dump__dump_type`.
> > >
> > > Clang allows to attach btf_decl_tag attributes to the following kinds
> > > of items:
> > > - struct/union         supported
> > > - struct/union field   supported
> > > - typedef              supported
> > > - function             not applicable
> > > - function parameter   not applicable
> > > - variable             not applicable
> > >
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  tools/lib/bpf/btf_dump.c | 163 ++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 160 insertions(+), 3 deletions(-)
> > >
> >

[...]

> > >  struct btf_dump *btf_dump__new(const struct btf *btf,
> > >                                btf_dump_printf_fn_t printf_fn,
> > > @@ -179,11 +211,21 @@ struct btf_dump *btf_dump__new(const struct btf *btf,
> > >                 d->ident_names = NULL;
> > >                 goto err;
> > >         }
> > > +       d->decl_tags = hashmap__new(identity_hash_fn, identity_equal_fn, NULL);
> > > +       if (IS_ERR(d->decl_tags)) {
> > > +               err = PTR_ERR(d->decl_tags);
> > > +               d->decl_tags = NULL;
> >
> > nit: no need to clear out ERR pointer, hashmap__free() handles that properly
>
> The `err` is passed to `libbpf_err_ptr` at the end of the function:
>
> struct btf_dump *btf_dump__new(...)
> {
>         ...
> err:
>         btf_dump__free(d);
>         return libbpf_err_ptr(err);
> }
>
> The `libbpf_err_ptr` uses it to update the `errno` global. So I think
> that PTR_ERR call is not redundant in this case.
>

I was talking about `d->decl_tags = NULL;`, you don't need to do that,
hashmap__free() handles such non-NULL error pointer just fine.


> >
> > > +               goto err;
> > > +       }
> > >
> > >         err = btf_dump_resize(d);
> > >         if (err)
> > >                 goto err;
> > >
> > > +       err = btf_dump_assign_decl_tags(d);
> > > +       if (err)
> > > +               goto err;
> > > +
> > >         return d;
> > >  err:
> > >         btf_dump__free(d);

[...]

> > >
> > > +/*
> > > + * This hashmap lookup is used in several places, so extract it as a
> > > + * function to hide all the ceremony with casts and NULL assignment.
> > > + */
> > > +static struct decl_tag_array *btf_dump_find_decl_tags(struct btf_dump *d, __u32 id)
> > > +{
> > > +       struct decl_tag_array *decl_tags = NULL;
> > > +
> > > +       hashmap__find(d->decl_tags, (void *)(uintptr_t)id, (void **)&decl_tags);
> > > +
> > > +       return decl_tags;
> > > +}
> > > +
> >
> > with your hashmap void * -> long refactoring this is not necessary,
> > though, right?
>
> If that refactoring is accepted the casts would go away, but it is
> still convenient for me to have a function returning pointer for the
> in the btf_dump_emit_typedef_def. I can inline it in all three call
> locations, but I think it is a bit cleaner this way.
>

I think

if (!hashmap__find(d->decl_tags, id, (void **)&decl_tags)) {
  /* handle NULL case */
}

is just as readable. Let's not add unnecessary helpers.

> >
> > > +/*
> > > + * Scans all BTF objects looking for BTF_KIND_DECL_TAG entries.
> > > + * The id's of the entries are stored in the `btf_dump.decl_tags` table,
> > > + * grouped by a target type.
> > > + */
> > > +static int btf_dump_assign_decl_tags(struct btf_dump *d)
> > > +{
> > > +       __u32 id, new_cnt, type_cnt = btf__type_cnt(d->btf);
> > > +       struct decl_tag_array *decl_tags;
> > > +       const struct btf_type *t;
> > > +       int err;
> > > +
> > > +       for (id = 1; id < type_cnt; id++) {
> > > +               t = btf__type_by_id(d->btf, id);
> > > +               if (!btf_is_decl_tag(t))
> > > +                       continue;
> > > +
> > > +               decl_tags = btf_dump_find_decl_tags(d, t->type);
> > > +               /* Assume small number of decl tags per id, increase array size by 1 */
> > > +               new_cnt = decl_tags ? decl_tags->cnt + 1 : 1;
> > > +               if (new_cnt > MAX_DECL_TAGS_PER_ID)
> > > +                       return -ERANGE;
> >
> > why artificial limitations? user will pay the price proportional to
> > its BTF, and we don't really care as the memory is allocated
> > dynamically anyway
>
> Since you requested to change allocation strategy from buffer doubling
> to +1 I figured that this point would get unusably slow for some large
> enough value. I'll remove this limitation.

allocators like jemalloc don't actually reallocate internally on every
realloc() call, they just adjust size if the value stays within the
same size bucket, so while you can micro-optimize to avoid unnecessary
calls to realloc() (but not necessarily reallocations themselves),
it's not that critical in practice, especially somewhere where we
don't expects many thousands of calls

>
> >
> > > +
> > > +               /* Allocate new_cnt + 1 to account for decl_tag_array header */
> > > +               decl_tags = libbpf_reallocarray(decl_tags, new_cnt + 1, sizeof(__u32));
> >

[...]
