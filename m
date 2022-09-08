Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CEE5B12B4
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 04:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiIHC7N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 22:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIHC7N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 22:59:13 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5925C6B4F
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 19:59:11 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id k9so5408464ils.12
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 19:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=C1R6uWnFuTRL+nsPsZydRBFUuCYNzYqr15UqiqZAhoI=;
        b=QsLesqf40itZjpir074WyhgbN0PXX3LALoquC4osS0FgZZKeMEBTOXAY6g/DUCfQa8
         cYIjOADOPiaj+kFA9NCN05GhUbueTo6TZo6PXivTyj9JehbHwyyMnnQVn5ud41dfaB1x
         cXQli5sz2Eh3Lw+TiXdxg4Cyo5eW6bLELI+sQ+xNfHH/2SghOKULoToeIqpfZ5yCWwte
         byKb+GdHxvQTCS4f5fsTulq+RFNwrMj3S7duXQStyH70hqGdRc9Vt4MWw935+CRdL+Dl
         Qr9zpH49gfSXmAxb0ZAKZQaziO1uZ+8XP0B61NT8Gnik7ungAv9MeE9iMXViQXlgojDC
         zAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=C1R6uWnFuTRL+nsPsZydRBFUuCYNzYqr15UqiqZAhoI=;
        b=vaik0y5+LDTxNlQco/VwEIlPbmaqxASjXmvTfnwUqztMI7Dux/ncLF06x5Mmyko8Xp
         ctgCxca/Lc/7vNVF9LfeOaGdUjyx3l5t/6NDuI0Nr9QzO1wfHBkqkqRh8RUp+gqQCzNL
         LNHIQxpmj5FHFghdKNiVZz9Cx+QG5NV9nRIRE9Qnvgk2x2ktnxbtC1QqjS2o/A5/x1Mb
         tSOq8h0QP71yz3pGSPNjsfhvgT+9iF49QjSjOXBL3DoKacfEOnz5//eocaKcJv3sjrQi
         +ooEDHKKUr5Q9MaQjq4MgYZOCbRWLBMkFBIkjCxZHwcnEN1L88SWm7gtiSG1QaLR73ur
         3wag==
X-Gm-Message-State: ACgBeo1NCaPFKStNE9GqY5Kcf+sQeH6W90hBsFHIQXgwxkVuQyw7kkL4
        sN1BGgozhr0rMcJv1eMPdR/zhwupAVyjASKGnKQ=
X-Google-Smtp-Source: AA6agR62SAolE1r2SBM2sswNdQmb5pMk3eywRrABCDBZM5K6phkzZ3E/Xe8JQ8g+JlrfmEl29RtFHh0cDSjxOOLW/vs=
X-Received: by 2002:a05:6e02:1d0b:b0:2eb:73fc:2235 with SMTP id
 i11-20020a056e021d0b00b002eb73fc2235mr804905ila.164.1662605950848; Wed, 07
 Sep 2022 19:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-14-memxor@gmail.com>
 <20220907224633.kh6nyqhhk5ut5cax@macbook-pro-4.dhcp.thefacebook.com>
In-Reply-To: <20220907224633.kh6nyqhhk5ut5cax@macbook-pro-4.dhcp.thefacebook.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu, 8 Sep 2022 04:58:34 +0200
Message-ID: <CAP01T77nmnqopjjf56ZqUeFKUKoafhNH1=48HCNs_NXXdNj3jQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 13/32] bpf: Introduce bpf_list_head
 support for BPF maps
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 8 Sept 2022 at 00:46, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Sep 04, 2022 at 10:41:26PM +0200, Kumar Kartikeya Dwivedi wrote:
> > Add the basic support on the map side to parse, recognize, verify, and
> > build metadata table for a new special field of the type struct
> > bpf_list_head. To parameterize the bpf_list_head for a certain value
> > type and the list_node member it will accept in that value type, we use
> > BTF declaration tags.
> >
> > The definition of bpf_list_head in a map value will be done as follows:
> >
> > struct foo {
> >       int data;
> >       struct bpf_list_node list;
> > };
> >
> > struct map_value {
> >       struct bpf_list_head list __contains(struct, foo, node);
> > };
>
> kptrs are only for structs.
> So I would drop explicit 1st argument which is going to be 'struct'
> for foreseeable future and leave it as:
>  struct bpf_list_head list __contains(foo, node);
>

Ok.

> There is typo s/list;/node;/ in struct foo, right?

Yes.

>
> > Then, the bpf_list_head only allows adding to the list using the
> > bpf_list_node 'list' for the type struct foo.
> >
> > The 'contains' annotation is a BTF declaration tag composed of four
> > parts, "contains:kind:name:node" where the kind and name is then used to
> > look up the type in the map BTF. The node defines name of the member in
> > this type that has the type struct bpf_list_node, which is actually used
> > for linking into the linked list.
> >
> > This allows building intrusive linked lists in BPF, using container_of
> > to obtain pointer to entry, while being completely type safe from the
> > perspective of the verifier. The verifier knows exactly the type of the
> > nodes, and knows that list helpers return that type at some fixed offset
> > where the bpf_list_node member used for this list exists. The verifier
> > also uses this information to disallow adding types that are not
> > accepted by a certain list.
> >
> > For now, no elements can be added to such lists. Support for that is
> > coming in future patches, hence draining and freeing items is left out
> > for now, and just freeing the list_head_off_tab is done, since it is
> > still built and populated when bpf_list_head is specified in the map
> > value.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h                           |  64 +++++--
> >  include/linux/btf.h                           |   2 +
> >  kernel/bpf/arraymap.c                         |   2 +
> >  kernel/bpf/bpf_local_storage.c                |   1 +
> >  kernel/bpf/btf.c                              | 173 +++++++++++++++++-
> >  kernel/bpf/hashtab.c                          |   1 +
> >  kernel/bpf/map_in_map.c                       |   5 +-
> >  kernel/bpf/syscall.c                          | 131 +++++++++++--
> >  kernel/bpf/verifier.c                         |  21 +++
> >  .../testing/selftests/bpf/bpf_experimental.h  |  21 +++
> >  10 files changed, 378 insertions(+), 43 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/bpf_experimental.h
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index d4e6bf789c02..35c2e9caeb98 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -28,6 +28,9 @@
> >  #include <linux/btf.h>
> >  #include <linux/rcupdate_trace.h>
> >
> > +/* Experimental BPF APIs header for type definitions */
> > +#include "../../../tools/testing/selftests/bpf/bpf_experimental.h"
> > +
> >  struct bpf_verifier_env;
> >  struct bpf_verifier_log;
> >  struct perf_event;
> > @@ -164,27 +167,40 @@ struct bpf_map_ops {
> >  };
> >
> >  enum {
> > -     /* Support at most 8 pointers in a BPF map value */
> > -     BPF_MAP_VALUE_OFF_MAX = 8,
> > -     BPF_MAP_OFF_ARR_MAX   = BPF_MAP_VALUE_OFF_MAX +
> > -                             1 + /* for bpf_spin_lock */
> > -                             1,  /* for bpf_timer */
> > -};
> > -
> > -enum bpf_kptr_type {
> > +     /* Support at most 8 offsets in a table */
> > +     BPF_MAP_VALUE_OFF_MAX           = 8,
> > +     /* Support at most 8 pointer in a BPF map value */
> > +     BPF_MAP_VALUE_KPTR_MAX          = BPF_MAP_VALUE_OFF_MAX,
> > +     /* Support at most 8 list_head in a BPF map value */
> > +     BPF_MAP_VALUE_LIST_HEAD_MAX     = BPF_MAP_VALUE_OFF_MAX,
> > +     BPF_MAP_OFF_ARR_MAX             = BPF_MAP_VALUE_KPTR_MAX +
> > +                                       BPF_MAP_VALUE_LIST_HEAD_MAX +
> > +                                       1 + /* for bpf_spin_lock */
> > +                                       1,  /* for bpf_timer */
> > +};
> > +
> > +enum bpf_off_type {
> >       BPF_KPTR_UNREF,
> >       BPF_KPTR_REF,
> > +     BPF_LIST_HEAD,
> >  };
> >
> >  struct bpf_map_value_off_desc {
> >       u32 offset;
> > -     enum bpf_kptr_type type;
> > -     struct {
> > -             struct btf *btf;
> > -             struct module *module;
> > -             btf_dtor_kfunc_t dtor;
> > -             u32 btf_id;
> > -     } kptr;
> > +     enum bpf_off_type type;
> > +     union {
> > +             struct {
> > +                     struct btf *btf;
> > +                     struct module *module;
> > +                     btf_dtor_kfunc_t dtor;
> > +                     u32 btf_id;
> > +             } kptr; /* for BPF_KPTR_{UNREF,REF} */
> > +             struct {
> > +                     struct btf *btf;
> > +                     u32 value_type_id;
> > +                     u32 list_node_off;
> > +             } list_head; /* for BPF_LIST_HEAD */
> > +     };
> >  };
> >
> >  struct bpf_map_value_off {
> > @@ -215,6 +231,7 @@ struct bpf_map {
> >       u32 map_flags;
> >       int spin_lock_off; /* >=0 valid offset, <0 error */
> >       struct bpf_map_value_off *kptr_off_tab;
> > +     struct bpf_map_value_off *list_head_off_tab;
>
> The union in bpf_map_value_off_desc prompts the question
> why separate array is needed.
> Sorting gets uglier.
>

I'll try to create a unified offset array, there aren't going to be
any collisions anyway, and we can discern between field types using
the type field.

> >       int timer_off; /* >=0 valid offset, <0 error */
> >       u32 id;
> >       int numa_node;
> > @@ -265,6 +282,11 @@ static inline bool map_value_has_kptrs(const struct bpf_map *map)
> >       return !IS_ERR_OR_NULL(map->kptr_off_tab);
> >  }
> >
> > +static inline bool map_value_has_list_heads(const struct bpf_map *map)
> > +{
> > +     return !IS_ERR_OR_NULL(map->list_head_off_tab);
> > +}
> > +
> >  static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
> >  {
> >       if (unlikely(map_value_has_spin_lock(map)))
> > @@ -278,6 +300,13 @@ static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
> >               for (i = 0; i < tab->nr_off; i++)
> >                       *(u64 *)(dst + tab->off[i].offset) = 0;
> >       }
> > +     if (unlikely(map_value_has_list_heads(map))) {
> > +             struct bpf_map_value_off *tab = map->list_head_off_tab;
> > +             int i;
> > +
> > +             for (i = 0; i < tab->nr_off; i++)
> > +                     memset(dst + tab->off[i].offset, 0, sizeof(struct list_head));
> > +     }
>
> Do we really need to distinguish map_value_has_kptrs vs map_value_has_list_heads ?
> Can they be generalized?
> rb_root will be next.
> that would be yet another array and another 'if'-s everywhere?
> And then another special pseudo-map type that will cause a bunch of copy-paste again?
> Maybe it's inevitable.
> Trying to brainstorm.
>

Yes, it's a bit unfortunate how this is turning out to be.
If we use a unified array we might be able to do it in one go though,
taking size from the type.

> >  }
> >
> >  /* memcpy that is used with 8-byte aligned pointers, power-of-8 size and
> > @@ -1676,6 +1705,11 @@ struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map);
> >  bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b);
> >  void bpf_map_free_kptrs(struct bpf_map *map, void *map_value);
> >
> > +struct bpf_map_value_off_desc *bpf_map_list_head_off_contains(struct bpf_map *map, u32 offset);
> > +void bpf_map_free_list_head_off_tab(struct bpf_map *map);
> > +struct bpf_map_value_off *bpf_map_copy_list_head_off_tab(const struct bpf_map *map);
> > +bool bpf_map_equal_list_head_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b);
> > +
> >  struct bpf_map *bpf_map_get(u32 ufd);
> >  struct bpf_map *bpf_map_get_with_uref(u32 ufd);
> >  struct bpf_map *__bpf_map_get(struct fd f);
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index 8062f9da7c40..9b62b8b2117e 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -156,6 +156,8 @@ int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
> >  int btf_find_timer(const struct btf *btf, const struct btf_type *t);
> >  struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
> >                                         const struct btf_type *t);
> > +struct bpf_map_value_off *btf_parse_list_heads(struct btf *btf,
> > +                                            const struct btf_type *t);
> >  bool btf_type_is_void(const struct btf_type *t);
> >  s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
> >  const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
> > diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> > index 832b2659e96e..c7263ee3a35f 100644
> > --- a/kernel/bpf/arraymap.c
> > +++ b/kernel/bpf/arraymap.c
> > @@ -423,6 +423,8 @@ static void array_map_free(struct bpf_map *map)
> >       struct bpf_array *array = container_of(map, struct bpf_array, map);
> >       int i;
> >
> > +     bpf_map_free_list_head_off_tab(map);
> > +
> >       if (map_value_has_kptrs(map)) {
> >               if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
> >                       for (i = 0; i < array->map.max_entries; i++) {
> > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> > index 58cb0c179097..b5ccd76026b6 100644
> > --- a/kernel/bpf/bpf_local_storage.c
> > +++ b/kernel/bpf/bpf_local_storage.c
> > @@ -616,6 +616,7 @@ void bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
> >               rcu_barrier();
> >               bpf_map_free_kptr_off_tab(&smap->map);
> >       }
> > +     bpf_map_free_list_head_off_tab(&smap->map);
> >       kvfree(smap->buckets);
> >       bpf_map_area_free(smap);
> >  }
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 6740c3ade8f1..0fb045be3837 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -3185,6 +3185,7 @@ enum btf_field_type {
> >       BTF_FIELD_SPIN_LOCK,
> >       BTF_FIELD_TIMER,
> >       BTF_FIELD_KPTR,
> > +     BTF_FIELD_LIST_HEAD,
> >  };
> >
> >  enum {
> > @@ -3193,9 +3194,17 @@ enum {
> >  };
> >
> >  struct btf_field_info {
> > -     u32 type_id;
> >       u32 off;
> > -     enum bpf_kptr_type type;
> > +     union {
> > +             struct {
> > +                     u32 type_id;
> > +                     enum bpf_off_type type;
> > +             } kptr;
> > +             struct {
> > +                     u32 value_type_id;
> > +                     const char *node_name;
> > +             } list_head;
> > +     };
> >  };
> >
> >  static int btf_find_struct(const struct btf *btf, const struct btf_type *t,
> > @@ -3212,7 +3221,7 @@ static int btf_find_struct(const struct btf *btf, const struct btf_type *t,
> >  static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
> >                        u32 off, int sz, struct btf_field_info *info)
> >  {
> > -     enum bpf_kptr_type type;
> > +     enum bpf_off_type type;
> >       u32 res_id;
> >
> >       /* Permit modifiers on the pointer itself */
> > @@ -3241,9 +3250,71 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
> >       if (!__btf_type_is_struct(t))
> >               return -EINVAL;
> >
> > -     info->type_id = res_id;
> >       info->off = off;
> > -     info->type = type;
> > +     info->kptr.type_id = res_id;
> > +     info->kptr.type = type;
> > +     return BTF_FIELD_FOUND;
> > +}
> > +
> > +static const char *btf_find_decl_tag_value(const struct btf *btf,
> > +                                        const struct btf_type *pt,
> > +                                        int comp_idx, const char *tag_key)
> > +{
> > +     int i;
> > +
> > +     for (i = 1; i < btf_nr_types(btf); i++) {
> > +             const struct btf_type *t = btf_type_by_id(btf, i);
> > +             int len = strlen(tag_key);
> > +
> > +             if (!btf_type_is_decl_tag(t))
> > +                     continue;
> > +             /* TODO: Instead of btf_type pt, it would be much better if we had BTF
> > +              * ID of the map value type. This would avoid btf_type_by_id call here.
> > +              */
> > +             if (pt != btf_type_by_id(btf, t->type) ||
> > +                 btf_type_decl_tag(t)->component_idx != comp_idx)
> > +                     continue;
> > +             if (strncmp(__btf_name_by_offset(btf, t->name_off), tag_key, len))
> > +                     continue;
> > +             return __btf_name_by_offset(btf, t->name_off) + len;
> > +     }
> > +     return NULL;
> > +}
> > +
> > +static int btf_find_list_head(const struct btf *btf, const struct btf_type *pt,
> > +                           int comp_idx, const struct btf_type *t,
> > +                           u32 off, int sz, struct btf_field_info *info)
> > +{
> > +     const char *value_type;
> > +     const char *list_node;
> > +     s32 id;
> > +
> > +     if (!__btf_type_is_struct(t))
> > +             return BTF_FIELD_IGNORE;
> > +     if (t->size != sz)
> > +             return BTF_FIELD_IGNORE;
> > +     value_type = btf_find_decl_tag_value(btf, pt, comp_idx, "contains:");
> > +     if (!value_type)
> > +             return -EINVAL;
> > +     if (strncmp(value_type, "struct:", sizeof("struct:") - 1))
> > +             return -EINVAL;
> > +     value_type += sizeof("struct:") - 1;
> > +     list_node = strstr(value_type, ":");
> > +     if (!list_node)
> > +             return -EINVAL;
> > +     value_type = kstrndup(value_type, list_node - value_type, GFP_ATOMIC);
> > +     if (!value_type)
> > +             return -ENOMEM;
> > +     id = btf_find_by_name_kind(btf, value_type, BTF_KIND_STRUCT);
> > +     kfree(value_type);
> > +     if (id < 0)
> > +             return id;
> > +     list_node++;
> > +     if (str_is_empty(list_node))
> > +             return -EINVAL;
> > +     info->off = off;
> > +     info->list_head.value_type_id = id;
> > +     info->list_head.node_name = list_node;
> >       return BTF_FIELD_FOUND;
> >  }
> >
> > @@ -3286,6 +3357,12 @@ static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t
> >                       if (ret < 0)
> >                               return ret;
> >                       break;
> > +             case BTF_FIELD_LIST_HEAD:
> > +                     ret = btf_find_list_head(btf, t, i, member_type, off, sz,
> > +                                              idx < info_cnt ? &info[idx] : &tmp);
> > +                     if (ret < 0)
> > +                             return ret;
> > +                     break;
> >               default:
> >                       return -EFAULT;
> >               }
> > @@ -3336,6 +3413,12 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
> >                       if (ret < 0)
> >                               return ret;
> >                       break;
> > +             case BTF_FIELD_LIST_HEAD:
> > +                     ret = btf_find_list_head(btf, var, -1, var_type, off, sz,
> > +                                              idx < info_cnt ? &info[idx] : &tmp);
> > +                     if (ret < 0)
> > +                             return ret;
> > +                     break;
> >               default:
> >                       return -EFAULT;
> >               }
> > @@ -3372,6 +3455,11 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
> >               sz = sizeof(u64);
> >               align = 8;
> >               break;
> > +     case BTF_FIELD_LIST_HEAD:
> > +             name = "bpf_list_head";
> > +             sz = sizeof(struct bpf_list_head);
> > +             align = __alignof__(struct bpf_list_head);
> > +             break;
> >       default:
> >               return -EFAULT;
> >       }
> > @@ -3440,7 +3528,7 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
> >               /* Find type in map BTF, and use it to look up the matching type
> >                * in vmlinux or module BTFs, by name and kind.
> >                */
> > -             t = btf_type_by_id(btf, info_arr[i].type_id);
> > +             t = btf_type_by_id(btf, info_arr[i].kptr.type_id);
> >               id = bpf_find_btf_id(__btf_name_by_offset(btf, t->name_off), BTF_INFO_KIND(t->info),
> >                                    &kernel_btf);
> >               if (id < 0) {
> > @@ -3451,7 +3539,7 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
> >               /* Find and stash the function pointer for the destruction function that
> >                * needs to be eventually invoked from the map free path.
> >                */
> > -             if (info_arr[i].type == BPF_KPTR_REF) {
> > +             if (info_arr[i].kptr.type == BPF_KPTR_REF) {
> >                       const struct btf_type *dtor_func;
> >                       const char *dtor_func_name;
> >                       unsigned long addr;
> > @@ -3494,7 +3582,7 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
> >               }
> >
> >               tab->off[i].offset = info_arr[i].off;
> > -             tab->off[i].type = info_arr[i].type;
> > +             tab->off[i].type = info_arr[i].kptr.type;
> >               tab->off[i].kptr.btf_id = id;
> >               tab->off[i].kptr.btf = kernel_btf;
> >               tab->off[i].kptr.module = mod;
> > @@ -3515,6 +3603,75 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
> >       return ERR_PTR(ret);
> >  }
> >
> > +struct bpf_map_value_off *btf_parse_list_heads(struct btf *btf, const struct btf_type *t)
> > +{
> > +     struct btf_field_info info_arr[BPF_MAP_VALUE_OFF_MAX];
> > +     struct bpf_map_value_off *tab;
> > +     int ret, i, nr_off;
> > +
> > +     ret = btf_find_field(btf, t, BTF_FIELD_LIST_HEAD, info_arr, ARRAY_SIZE(info_arr));
>
> Like if search for both LIST_HEAD and KPTR here to know the size.
>

Yes, it seems like a good idea to unify things, I'll do it in v1.

> > +     if (ret < 0)
> > +             return ERR_PTR(ret);
> > +     if (!ret)
> > +             return NULL;
> > +
> > +     nr_off = ret;
> > +     tab = kzalloc(offsetof(struct bpf_map_value_off, off[nr_off]), GFP_KERNEL | __GFP_NOWARN);
> > +     if (!tab)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     for (i = 0; i < nr_off; i++) {
> > +             const struct btf_type *t, *n = NULL;
> > +             const struct btf_member *member;
> > +             u32 offset;
> > +             int j;
>
> and here we can process both, since field_info has type.
>
> > +
> > +             t = btf_type_by_id(btf, info_arr[i].list_head.value_type_id);
> > +             /* We've already checked that value_type_id is a struct type. We
> > +              * just need to figure out the offset of the list_node, and
> > +              * verify its type.
> > +              */
> > +             ret = -EINVAL;
> > +             for_each_member(j, t, member) {
> > +                     if (strcmp(info_arr[i].list_head.node_name, __btf_name_by_offset(btf, member->name_off)))
> > +                             continue;
> > +                     /* Invalid BTF, two members with same name */
> > +                     if (n) {
> > +                             /* We also need to btf_put for the current iteration! */
> > +                             i++;
> > +                             goto end;
> > +                     }
> > +                     n = btf_type_by_id(btf, member->type);
> > +                     if (!__btf_type_is_struct(n))
> > +                             goto end;
> > +                     if (strcmp("bpf_list_node", __btf_name_by_offset(btf, n->name_off)))
> > +                             goto end;
> > +                     offset = __btf_member_bit_offset(n, member);
> > +                     if (offset % 8)
> > +                             goto end;
> > +                     offset /= 8;
> > +                     if (offset % __alignof__(struct bpf_list_node))
> > +                             goto end;
> > +
> > +                     tab->off[i].offset = info_arr[i].off;
> > +                     tab->off[i].type = BPF_LIST_HEAD;
> > +                     btf_get(btf);
>
> Do we need to btf_get? The btf should be pinned already and not going to be released
> until prog ends.
>

Hm, I think that's true. This is also the map BTF, not prog BTF, which
I guess map holds a ref to it anyway until __bpf_map_put, so it should
be fine. I'll add a comment.
