Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524234E3491
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 00:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiCUXlL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 19:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbiCUXlK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 19:41:10 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C4A3CFCE
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:39:43 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q5so21907184ljb.11
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f1y1pcjZWIl8IWJ6wUF0BP0ZTTXMJ4Es1acklmUtuIE=;
        b=dOvP4hHlGHxdUAokrDdjcu/0MxSLUeBPQF5GMa1aE7ITO5+WYS7qmtwbgduuRQ8mC+
         HGhh5k809hGJsp1Kl2UdZhDOTC6DfQK62wwlr7RQ4DVf3Itl7BHFqcIVXaHVnIwjwjcs
         BH+3pH9i8z4jG9vNngm07g6yxZ8yX7DKk2P3yAGXHyf/JMCUF2gZJAAGVj1UuI8qcJKu
         BpPa94wKmBFsY/esK0CB+PNwRqUtIufpb5uPRJe5z9nrs80LNzW6J+l6yAaQJ+WG/7hI
         rDdTTMbH+NAYgMVCrtTxmMFUATNFcMiysar7gnmYfCCYCv7qyUoqu0gfovO9rcA3SckO
         ooMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f1y1pcjZWIl8IWJ6wUF0BP0ZTTXMJ4Es1acklmUtuIE=;
        b=XIs656YCdzW8m7QjWbIUOSW20q2PIoJYFCRmDQNOH/84voafsK51/E+vrGKT9z03vA
         Ye6PyUwTb9Cnnsbf+wHYVcoUSecn1sdwaJvLrcmCKT4Fj/55p+CLbxOEZ/XVAKJMayFz
         yv0oLq4rK8KSXNG164u3rA69TEb9554GIEqqob8DN7cGyMFwSdd70Jt/ZFEsGPA+GUJZ
         LEVsH386D7kERLhJuP+7KMHR19dEn0S3AU7S4mJdxFm0ZXFRbDC58MqxDZk65nLpI2+e
         3raTyiJK0s+i79bMYXDn7xYUxvM4lopQzVs6Oqi/FPhPnNR8MrwwC7bPu1dvts2ghJ19
         uvwg==
X-Gm-Message-State: AOAM532YbPeYqpeQJdmIBr5024LrzLUY5JG8qRnFjy7D2/Nji+saS88/
        ayELmDNhACvcnpt8j/NbcfSQMDUzY0bwetnwMfQ=
X-Google-Smtp-Source: ABdhPJyZMyxoqRVPVLOshtj43RlLeQ6dNEAjj4oos7nSjkPl/pEtVXc9CO9cVVNhIR821BNgEOPoCUcVuV7n5wlGALo=
X-Received: by 2002:a05:651c:198b:b0:249:8bf4:498b with SMTP id
 bx11-20020a05651c198b00b002498bf4498bmr2818806ljb.441.1647905981187; Mon, 21
 Mar 2022 16:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220320155510.671497-1-memxor@gmail.com> <20220320155510.671497-4-memxor@gmail.com>
In-Reply-To: <20220320155510.671497-4-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 21 Mar 2022 16:39:30 -0700
Message-ID: <CAJnrk1btaBKMQsLaj3LZX+ipeq0YtA2KYSeN_DSKMjqg7bGiZg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 03/13] bpf: Allow storing unreferenced kptr in map
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
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

On Sun, Mar 20, 2022 at 5:27 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> This commit introduces a new pointer type 'kptr' which can be embedded
> in a map value as holds a PTR_TO_BTF_ID stored by a BPF program during
> its invocation. Storing to such a kptr, BPF program's PTR_TO_BTF_ID
> register must have the same type as in the map value's BTF, and loading
> a kptr marks the destination register as PTR_TO_BTF_ID with the correct
> kernel BTF and BTF ID.
>
> Such kptr are unreferenced, i.e. by the time another invocation of the
> BPF program loads this pointer, the object which the pointer points to
> may not longer exist. Since PTR_TO_BTF_ID loads (using BPF_LDX) are
> patched to PROBE_MEM loads by the verifier, it would safe to allow user
> to still access such invalid pointer, but passing such pointers into
> BPF helpers and kfuncs should not be permitted. A future patch in this
> series will close this gap.
>
> The flexibility offered by allowing programs to dereference such invalid
> pointers while being safe at runtime frees the verifier from doing
> complex lifetime tracking. As long as the user may ensure that the
> object remains valid, it can ensure data read by it from the kernel
> object is valid.
>
> The user indicates that a certain pointer must be treated as kptr
> capable of accepting stores of PTR_TO_BTF_ID of a certain type, by using
> a BTF type tag 'kptr' on the pointed to type of the pointer. Then, this
> information is recorded in the object BTF which will be passed into the
> kernel by way of map's BTF information. The name and kind from the map
> value BTF is used to look up the in-kernel type, and the actual BTF and
> BTF ID is recorded in the map struct in a new kptr_off_tab member. For
> now, only storing pointers to structs is permitted.
>
> An example of this specification is shown below:
>
>         #define __kptr __attribute__((btf_type_tag("kptr")))
>
>         struct map_value {
>                 ...
>                 struct task_struct __kptr *task;
>                 ...
>         };
>
> Then, in a BPF program, user may store PTR_TO_BTF_ID with the type
> task_struct into the map, and then load it later.
>
> Note that the destination register is marked PTR_TO_BTF_ID_OR_NULL, as
> the verifier cannot know whether the value is NULL or not statically, it
> must treat all potential loads at that map value offset as loading a
> possibly NULL pointer.
>
> Only BPF_LDX, BPF_STX, and BPF_ST with insn->imm = 0 (to denote NULL)
> are allowed instructions that can access such a pointer. On BPF_LDX, the
> destination register is updated to be a PTR_TO_BTF_ID, and on BPF_STX,
> it is checked whether the source register type is a PTR_TO_BTF_ID with
> same BTF type as specified in the map BTF. The access size must always
> be BPF_DW.
>
> For the map in map support, the kptr_off_tab for outer map is copied
> from the inner map's kptr_off_tab. It was chosen to do a deep copy
> instead of introducing a refcount to kptr_off_tab, because the copy only
> needs to be done when paramterizing using inner_map_fd in the map in map
> case, hence would be unnecessary for all other users.
>
> It is not permitted to use MAP_FREEZE command and mmap for BPF map
> having kptr, similar to the bpf_timer case.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h     |  29 +++++++-
>  include/linux/btf.h     |   2 +
>  kernel/bpf/btf.c        | 161 ++++++++++++++++++++++++++++++++++------
>  kernel/bpf/map_in_map.c |   5 +-
>  kernel/bpf/syscall.c    | 112 +++++++++++++++++++++++++++-
>  kernel/bpf/verifier.c   | 120 ++++++++++++++++++++++++++++++
>  6 files changed, 401 insertions(+), 28 deletions(-)
>
[...]
> +
>  struct bpf_map *bpf_map_get(u32 ufd);
>  struct bpf_map *bpf_map_get_with_uref(u32 ufd);
>  struct bpf_map *__bpf_map_get(struct fd f);
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 36bc09b8e890..5b578dc81c04 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -123,6 +123,8 @@ bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
>                            u32 expected_offset, u32 expected_size);
>  int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
>  int btf_find_timer(const struct btf *btf, const struct btf_type *t);
> +struct bpf_map_value_off *btf_find_kptr(const struct btf *btf,
> +                                       const struct btf_type *t);

nit: given that "btf_find_kptr" allocates memory as well, maybe the
name "btf_parse_kptr" would be more reflective?

>  bool btf_type_is_void(const struct btf_type *t);
>  s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
>  const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 9e17af936a7a..92afbec0a887 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3164,9 +3164,16 @@ static void btf_struct_log(struct btf_verifier_env *env,
>  enum {
>         BTF_FIELD_SPIN_LOCK,
>         BTF_FIELD_TIMER,
> +       BTF_FIELD_KPTR,
> +};
> +
> +enum {
> +       BTF_FIELD_IGNORE = 0,
> +       BTF_FIELD_FOUND  = 1,
>  };
>
>  struct btf_field_info {
> +       const struct btf_type *type;
>         u32 off;
>  };
>
> @@ -3174,23 +3181,48 @@ static int btf_find_field_struct(const struct btf *btf, const struct btf_type *t
>                                  u32 off, int sz, struct btf_field_info *info)
>  {
>         if (!__btf_type_is_struct(t))
> -               return 0;
> +               return BTF_FIELD_IGNORE;
>         if (t->size != sz)
> -               return 0;
> -       if (info->off != -ENOENT)
> -               /* only one such field is allowed */
> -               return -E2BIG;
> +               return BTF_FIELD_IGNORE;
>         info->off = off;
> -       return 0;
> +       return BTF_FIELD_FOUND;
> +}
> +
> +static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
> +                              u32 off, int sz, struct btf_field_info *info)
> +{
> +       /* For PTR, sz is always == 8 */
> +       if (!btf_type_is_ptr(t))
> +               return BTF_FIELD_IGNORE;
> +       t = btf_type_by_id(btf, t->type);
> +
> +       if (!btf_type_is_type_tag(t))
> +               return BTF_FIELD_IGNORE;
> +       /* Reject extra tags */
> +       if (btf_type_is_type_tag(btf_type_by_id(btf, t->type)))
> +               return -EINVAL;
> +       if (strcmp("kptr", __btf_name_by_offset(btf, t->name_off)))
> +               return -EINVAL;
> +
> +       /* Get the base type */
> +       if (btf_type_is_modifier(t))
> +               t = btf_type_skip_modifiers(btf, t->type, NULL);
> +       /* Only pointer to struct is allowed */
> +       if (!__btf_type_is_struct(t))
> +               return -EINVAL;
> +
> +       info->type = t;
> +       info->off = off;
> +       return BTF_FIELD_FOUND;
>  }
>
>  static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t,
>                                  const char *name, int sz, int align, int field_type,
> -                                struct btf_field_info *info)
> +                                struct btf_field_info *info, int info_cnt)

From my understanding, this patch now modifies btf_find_struct_field
and btf_find_datasec_var such that the "info" that is passed in has to
be an array of size max possible + 1 while "info_cnt" is the max
possible count, or we risk writing beyond the "info" array passed in.
It seems like we could just modify the
btf_find_struct_field/btf_find_datasec_var logic so that the user can
just pass in info array of max possible size instead of max possible
size + 1 - or is your concern that this would require more idx >=
info_cnt checks inside the functions? Maybe we should include a
comment here and in btf_find_datasec_var to document that "info"
should always be max possible size + 1?

>  {
>         const struct btf_member *member;
> +       int ret, idx = 0;
>         u32 i, off;
> -       int ret;
>
>         for_each_member(i, t, member) {
>                 const struct btf_type *member_type = btf_type_by_id(btf,
> @@ -3210,24 +3242,35 @@ static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t
>                 switch (field_type) {
>                 case BTF_FIELD_SPIN_LOCK:
>                 case BTF_FIELD_TIMER:
> -                       ret = btf_find_field_struct(btf, member_type, off, sz, info);
> +                       ret = btf_find_field_struct(btf, member_type, off, sz, &info[idx]);
> +                       if (ret < 0)
> +                               return ret;
> +                       break;
> +               case BTF_FIELD_KPTR:
> +                       ret = btf_find_field_kptr(btf, member_type, off, sz, &info[idx]);
>                         if (ret < 0)
>                                 return ret;
>                         break;
>                 default:
>                         return -EFAULT;
>                 }
> +
> +               if (ret == BTF_FIELD_FOUND && idx >= info_cnt)
> +                       return -E2BIG;
> +               else if (ret == BTF_FIELD_IGNORE)
> +                       continue;
> +               ++idx;
>         }
> -       return 0;
> +       return idx;
>  }
>
>  static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
>                                 const char *name, int sz, int align, int field_type,
> -                               struct btf_field_info *info)
> +                               struct btf_field_info *info, int info_cnt)
>  {
>         const struct btf_var_secinfo *vsi;
> +       int ret, idx = 0;
>         u32 i, off;
> -       int ret;
>
>         for_each_vsi(i, t, vsi) {
>                 const struct btf_type *var = btf_type_by_id(btf, vsi->type);
> @@ -3245,19 +3288,30 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
>                 switch (field_type) {
>                 case BTF_FIELD_SPIN_LOCK:
>                 case BTF_FIELD_TIMER:
> -                       ret = btf_find_field_struct(btf, var_type, off, sz, info);
> +                       ret = btf_find_field_struct(btf, var_type, off, sz, &info[idx]);
> +                       if (ret < 0)
> +                               return ret;
> +                       break;
> +               case BTF_FIELD_KPTR:
> +                       ret = btf_find_field_kptr(btf, var_type, off, sz, &info[idx]);
>                         if (ret < 0)
>                                 return ret;
>                         break;
>                 default:
>                         return -EFAULT;
>                 }
> +
> +               if (ret == BTF_FIELD_FOUND && idx >= info_cnt)
> +                       return -E2BIG;
> +               if (ret == BTF_FIELD_IGNORE)
> +                       continue;
> +               ++idx;
>         }
> -       return 0;
> +       return idx;
>  }
>
>  static int btf_find_field(const struct btf *btf, const struct btf_type *t,
> -                         int field_type, struct btf_field_info *info)
> +                         int field_type, struct btf_field_info *info, int info_cnt)
>  {
>         const char *name;
>         int sz, align;
> @@ -3273,14 +3327,20 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
>                 sz = sizeof(struct bpf_timer);
>                 align = __alignof__(struct bpf_timer);
>                 break;
> +       case BTF_FIELD_KPTR:
> +               name = NULL;
> +               sz = sizeof(u64);
> +               align = __alignof__(u64);
> +               break;
>         default:
>                 return -EFAULT;
>         }
>
> +       /* The maximum allowed fields of a certain type will be info_cnt - 1 */
>         if (__btf_type_is_struct(t))
> -               return btf_find_struct_field(btf, t, name, sz, align, field_type, info);
> +               return btf_find_struct_field(btf, t, name, sz, align, field_type, info, info_cnt - 1);
>         else if (btf_type_is_datasec(t))
> -               return btf_find_datasec_var(btf, t, name, sz, align, field_type, info);
> +               return btf_find_datasec_var(btf, t, name, sz, align, field_type, info, info_cnt - 1);
>         return -EINVAL;
>  }
>
> @@ -3290,24 +3350,79 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
>   */
>  int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t)
>  {
> -       struct btf_field_info info = { .off = -ENOENT };
> +       /* btf_find_field requires array of size max + 1 */
> +       struct btf_field_info info_arr[2];
>         int ret;
>
> -       ret = btf_find_field(btf, t, BTF_FIELD_SPIN_LOCK, &info);
> +       ret = btf_find_field(btf, t, BTF_FIELD_SPIN_LOCK, info_arr, ARRAY_SIZE(info_arr));
>         if (ret < 0)
>                 return ret;
> -       return info.off;
> +       if (!ret)
> +               return -ENOENT;
> +       return info_arr[0].off;
>  }
>
>  int btf_find_timer(const struct btf *btf, const struct btf_type *t)
>  {
> -       struct btf_field_info info = { .off = -ENOENT };
> +       /* btf_find_field requires array of size max + 1 */
> +       struct btf_field_info info_arr[2];
>         int ret;
>
> -       ret = btf_find_field(btf, t, BTF_FIELD_TIMER, &info);
> +       ret = btf_find_field(btf, t, BTF_FIELD_TIMER, info_arr, ARRAY_SIZE(info_arr));
>         if (ret < 0)
>                 return ret;
> -       return info.off;
> +       if (!ret)
> +               return -ENOENT;
> +       return info_arr[0].off;
> +}
> +
> +struct bpf_map_value_off *btf_find_kptr(const struct btf *btf,
> +                                       const struct btf_type *t)
> +{
> +       /* btf_find_field requires array of size max + 1 */
> +       struct btf_field_info info_arr[BPF_MAP_VALUE_OFF_MAX + 1];
> +       struct bpf_map_value_off *tab;
> +       int ret, i, nr_off;
> +
> +       /* Revisit stack usage when bumping BPF_MAP_VALUE_OFF_MAX */
> +       BUILD_BUG_ON(BPF_MAP_VALUE_OFF_MAX != 8);
> +
> +       ret = btf_find_field(btf, t, BTF_FIELD_KPTR, info_arr, ARRAY_SIZE(info_arr));
> +       if (ret < 0)
> +               return ERR_PTR(ret);
> +       if (!ret)
> +               return NULL;
> +
> +       nr_off = ret;
> +       tab = kzalloc(offsetof(struct bpf_map_value_off, off[nr_off]), GFP_KERNEL | __GFP_NOWARN);
> +       if (!tab)
> +               return ERR_PTR(-ENOMEM);
> +
> +       tab->nr_off = 0;
> +       for (i = 0; i < nr_off; i++) {
> +               const struct btf_type *t;
> +               struct btf *off_btf;
> +               s32 id;
> +
> +               t = info_arr[i].type;
> +               id = bpf_find_btf_id(__btf_name_by_offset(btf, t->name_off), BTF_INFO_KIND(t->info),
> +                                    &off_btf);
> +               if (id < 0) {
> +                       ret = id;
> +                       goto end;
> +               }
> +
> +               tab->off[i].offset = info_arr[i].off;
> +               tab->off[i].btf_id = id;
> +               tab->off[i].btf = off_btf;
> +               tab->nr_off = i + 1;
> +       }
> +       return tab;
> +end:
> +       while (tab->nr_off--)
> +               btf_put(tab->off[tab->nr_off].btf);
> +       kfree(tab);
> +       return ERR_PTR(ret);
>  }
>
>  static void __btf_struct_show(const struct btf *btf, const struct btf_type *t,
> diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
> index 5cd8f5277279..135205d0d560 100644
> --- a/kernel/bpf/map_in_map.c
> +++ b/kernel/bpf/map_in_map.c
> @@ -52,6 +52,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
>         inner_map_meta->max_entries = inner_map->max_entries;
>         inner_map_meta->spin_lock_off = inner_map->spin_lock_off;
>         inner_map_meta->timer_off = inner_map->timer_off;
> +       inner_map_meta->kptr_off_tab = bpf_map_copy_kptr_off_tab(inner_map);
>         if (inner_map->btf) {
>                 btf_get(inner_map->btf);
>                 inner_map_meta->btf = inner_map->btf;
> @@ -71,6 +72,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
>
>  void bpf_map_meta_free(struct bpf_map *map_meta)
>  {
> +       bpf_map_free_kptr_off_tab(map_meta);
>         btf_put(map_meta->btf);
>         kfree(map_meta);
>  }
> @@ -83,7 +85,8 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
>                 meta0->key_size == meta1->key_size &&
>                 meta0->value_size == meta1->value_size &&
>                 meta0->timer_off == meta1->timer_off &&
> -               meta0->map_flags == meta1->map_flags;
> +               meta0->map_flags == meta1->map_flags &&
> +               bpf_map_equal_kptr_off_tab(meta0, meta1);
>  }
>
>  void *bpf_map_fd_get_ptr(struct bpf_map *map,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index cdaa1152436a..5990d6fa97ab 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -6,6 +6,7 @@
>  #include <linux/bpf_trace.h>
>  #include <linux/bpf_lirc.h>
>  #include <linux/bpf_verifier.h>
> +#include <linux/bsearch.h>
>  #include <linux/btf.h>
>  #include <linux/syscalls.h>
>  #include <linux/slab.h>
> @@ -473,12 +474,95 @@ static void bpf_map_release_memcg(struct bpf_map *map)
>  }
>  #endif
>
> +static int bpf_map_kptr_off_cmp(const void *a, const void *b)
> +{
> +       const struct bpf_map_value_off_desc *off_desc1 = a, *off_desc2 = b;
> +
> +       if (off_desc1->offset < off_desc2->offset)
> +               return -1;
> +       else if (off_desc1->offset > off_desc2->offset)
> +               return 1;
> +       return 0;
> +}
> +
> +struct bpf_map_value_off_desc *bpf_map_kptr_off_contains(struct bpf_map *map, u32 offset)
> +{
> +       /* Since members are iterated in btf_find_field in increasing order,
> +        * offsets appended to kptr_off_tab are in increasing order, so we can
> +        * do bsearch to find exact match.
> +        */
> +       struct bpf_map_value_off *tab;
> +
> +       if (!map_value_has_kptr(map))
> +               return NULL;
> +       tab = map->kptr_off_tab;
> +       return bsearch(&offset, tab->off, tab->nr_off, sizeof(tab->off[0]), bpf_map_kptr_off_cmp);
> +}
> +
> +void bpf_map_free_kptr_off_tab(struct bpf_map *map)
> +{
> +       struct bpf_map_value_off *tab = map->kptr_off_tab;
> +       int i;
> +
> +       if (!map_value_has_kptr(map))
> +               return;
> +       for (i = 0; i < tab->nr_off; i++) {
> +               struct btf *btf = tab->off[i].btf;
> +
> +               btf_put(btf);
> +       }
> +       kfree(tab);
> +       map->kptr_off_tab = NULL;
> +}
> +
> +struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map)
> +{
> +       struct bpf_map_value_off *tab = map->kptr_off_tab, *new_tab;
> +       int size, i, ret;
> +
> +       if (!map_value_has_kptr(map))
> +               return ERR_PTR(-ENOENT);
> +       /* Do a deep copy of the kptr_off_tab */
> +       for (i = 0; i < tab->nr_off; i++)
> +               btf_get(tab->off[i].btf);
> +
> +       size = offsetof(struct bpf_map_value_off, off[tab->nr_off]);
> +       new_tab = kzalloc(size, GFP_KERNEL | __GFP_NOWARN);
> +       if (!new_tab) {
> +               ret = -ENOMEM;
> +               goto end;
> +       }
> +       memcpy(new_tab, tab, size);
> +       return new_tab;
> +end:
> +       while (i--)
> +               btf_put(tab->off[i].btf);
> +       return ERR_PTR(ret);
> +}
> +
> +bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b)
> +{
> +       struct bpf_map_value_off *tab_a = map_a->kptr_off_tab, *tab_b = map_b->kptr_off_tab;
> +       bool a_has_kptr = map_value_has_kptr(map_a), b_has_kptr = map_value_has_kptr(map_b);
> +       int size;
> +
> +       if (!a_has_kptr && !b_has_kptr)
> +               return true;
> +       if ((a_has_kptr && !b_has_kptr) || (!a_has_kptr && b_has_kptr))

nit: I think we could simplify this second if check to
if (!a_has_kptr || !b_has_kptr)
    return false;

> +               return false;
> +       if (tab_a->nr_off != tab_b->nr_off)
> +               return false;
> +       size = offsetof(struct bpf_map_value_off, off[tab_a->nr_off]);
> +       return !memcmp(tab_a, tab_b, size);
> +}
> +
>  /* called from workqueue */
>  static void bpf_map_free_deferred(struct work_struct *work)
>  {
>         struct bpf_map *map = container_of(work, struct bpf_map, work);
>
>         security_bpf_map_free(map);
> +       bpf_map_free_kptr_off_tab(map);
>         bpf_map_release_memcg(map);
>         /* implementation dependent freeing */
>         map->ops->map_free(map);
> @@ -640,7 +724,7 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
>         int err;
>
>         if (!map->ops->map_mmap || map_value_has_spin_lock(map) ||
> -           map_value_has_timer(map))
> +           map_value_has_timer(map) || map_value_has_kptr(map))
>                 return -ENOTSUPP;
>
>         if (!(vma->vm_flags & VM_SHARED))
> @@ -820,9 +904,31 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
>                         return -EOPNOTSUPP;
>         }
>
> -       if (map->ops->map_check_btf)
> +       map->kptr_off_tab = btf_find_kptr(btf, value_type);
> +       if (map_value_has_kptr(map)) {
> +               if (!bpf_capable())
> +                       return -EPERM;
> +               if (map->map_flags & BPF_F_RDONLY_PROG) {
> +                       ret = -EACCES;
> +                       goto free_map_tab;
> +               }
> +               if (map->map_type != BPF_MAP_TYPE_HASH &&
> +                   map->map_type != BPF_MAP_TYPE_LRU_HASH &&
> +                   map->map_type != BPF_MAP_TYPE_ARRAY) {
> +                       ret = -EOPNOTSUPP;
> +                       goto free_map_tab;
> +               }
> +       }
> +
> +       if (map->ops->map_check_btf) {
>                 ret = map->ops->map_check_btf(map, btf, key_type, value_type);
> +               if (ret < 0)
> +                       goto free_map_tab;
> +       }
>
> +       return ret;
> +free_map_tab:
> +       bpf_map_free_kptr_off_tab(map);
>         return ret;
>  }
>
> @@ -1639,7 +1745,7 @@ static int map_freeze(const union bpf_attr *attr)
>                 return PTR_ERR(map);
>
>         if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS ||
> -           map_value_has_timer(map)) {
> +           map_value_has_timer(map) || map_value_has_kptr(map)) {
>                 fdput(f);
>                 return -ENOTSUPP;
>         }
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4ce9a528fb63..744b7362e52e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3507,6 +3507,94 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
>         return __check_ptr_off_reg(env, reg, regno, false);
>  }
>
> +static int map_kptr_match_type(struct bpf_verifier_env *env,
> +                              struct bpf_map_value_off_desc *off_desc,
> +                              struct bpf_reg_state *reg, u32 regno)
> +{
> +       const char *targ_name = kernel_type_name(off_desc->btf, off_desc->btf_id);
> +       const char *reg_name = "";
> +
> +       if (reg->type != PTR_TO_BTF_ID && reg->type != PTR_TO_BTF_ID_OR_NULL)
> +               goto bad_type;
> +
> +       if (!btf_is_kernel(reg->btf)) {
> +               verbose(env, "R%d must point to kernel BTF\n", regno);
> +               return -EINVAL;
> +       }
> +       /* We need to verify reg->type and reg->btf, before accessing reg->btf */
> +       reg_name = kernel_type_name(reg->btf, reg->btf_id);
> +
> +       if (__check_ptr_off_reg(env, reg, regno, true))
> +               return -EACCES;
> +
> +       if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> +                                 off_desc->btf, off_desc->btf_id))
> +               goto bad_type;
> +       return 0;
> +bad_type:
> +       verbose(env, "invalid kptr access, R%d type=%s%s ", regno,
> +               reg_type_str(env, reg->type), reg_name);
> +       verbose(env, "expected=%s%s\n", reg_type_str(env, PTR_TO_BTF_ID), targ_name);
> +       return -EINVAL;
> +}
> +
> +/* Returns an error, or 0 if ignoring the access, or 1 if register state was
> + * updated, in which case later updates must be skipped.
> + */
> +static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
> +                                int off, int size, int value_regno,
> +                                enum bpf_access_type t, int insn_idx)

Did you mean to include the "enum bpf_access_type t" argument? I'm not
seeing where it's being used in this function

> +{
> +       struct bpf_reg_state *reg = reg_state(env, regno), *val_reg;
> +       struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
> +       struct bpf_map_value_off_desc *off_desc;
> +       struct bpf_map *map = reg->map_ptr;
> +       int class = BPF_CLASS(insn->code);
> +
> +       /* Things we already checked for in check_map_access:
> +        *  - Reject cases where variable offset may touch BTF ID pointer
> +        *  - size of access (must be BPF_DW)
> +        *  - off_desc->offset == off + reg->var_off.value
> +        */
> +       if (!tnum_is_const(reg->var_off))
> +               return 0;
> +
> +       off_desc = bpf_map_kptr_off_contains(map, off + reg->var_off.value);
> +       if (!off_desc)
> +               return 0;
> +
> +       /* Only BPF_[LDX,STX,ST] | BPF_MEM | BPF_DW is supported */
> +       if (BPF_MODE(insn->code) != BPF_MEM)
> +               goto end;
> +
> +       if (class == BPF_LDX) {
> +               val_reg = reg_state(env, value_regno);
> +               /* We can simply mark the value_regno receiving the pointer
> +                * value from map as PTR_TO_BTF_ID, with the correct type.
> +                */
> +               mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, off_desc->btf,
> +                               off_desc->btf_id, PTR_MAYBE_NULL);
> +               val_reg->id = ++env->id_gen;
> +       } else if (class == BPF_STX) {
> +               val_reg = reg_state(env, value_regno);
> +               if (!register_is_null(val_reg) &&
> +                   map_kptr_match_type(env, off_desc, val_reg, value_regno))
> +                       return -EACCES;
> +       } else if (class == BPF_ST) {
> +               if (insn->imm) {
> +                       verbose(env, "BPF_ST imm must be 0 when storing to kptr at off=%u\n",
> +                               off_desc->offset);
> +                       return -EACCES;
> +               }
> +       } else {
> +               goto end;
> +       }
> +       return 1;
> +end:
> +       verbose(env, "kptr in map can only be accessed using BPF_LDX/BPF_STX/BPF_ST\n");
> +       return -EACCES;
> +}
> +
>  /* check read/write into a map element with possible variable offset */
>  static int check_map_access(struct bpf_verifier_env *env, u32 regno,
>                             int off, int size, bool zero_size_allowed)
> @@ -3545,6 +3633,32 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
>                         return -EACCES;
>                 }
>         }
> +       if (map_value_has_kptr(map)) {
> +               struct bpf_map_value_off *tab = map->kptr_off_tab;
> +               int i;
> +
> +               for (i = 0; i < tab->nr_off; i++) {
> +                       u32 p = tab->off[i].offset;
> +
> +                       if (reg->smin_value + off < p + sizeof(u64) &&
> +                           p < reg->umax_value + off + size) {
> +                               if (!tnum_is_const(reg->var_off)) {
> +                                       verbose(env, "kptr access cannot have variable offset\n");
> +                                       return -EACCES;
> +                               }
> +                               if (p != off + reg->var_off.value) {
> +                                       verbose(env, "kptr access misaligned expected=%u off=%llu\n",
> +                                               p, off + reg->var_off.value);
> +                                       return -EACCES;
> +                               }
> +                               if (size != bpf_size_to_bytes(BPF_DW)) {
> +                                       verbose(env, "kptr access size must be BPF_DW\n");
> +                                       return -EACCES;
> +                               }
> +                               break;
> +                       }
> +               }
> +       }
>         return err;
>  }
>
> @@ -4421,6 +4535,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>                 if (err)
>                         return err;
>                 err = check_map_access(env, regno, off, size, false);
> +               err = err ?: check_map_kptr_access(env, regno, off, size, value_regno, t, insn_idx);
> +               if (err < 0)
> +                       return err;
> +               /* if err == 0, check_map_kptr_access ignored the access */
>                 if (!err && t == BPF_READ && value_regno >= 0) {
>                         struct bpf_map *map = reg->map_ptr;
>
> @@ -4442,6 +4560,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn)
>                                 mark_reg_unknown(env, regs, value_regno);
>                         }
>                 }
> +               /* clear err == 1 */
> +               err = err < 0 ? err : 0;

I find this flow a bit unintuitive to follow. Would something like

    err = check_map_access(env, regno, off, size, false);
    if (err)
        return err;
    if (bpf_map_kptr_off_contains(map, off + reg->var_off.value, &off_desc)) {
        err = check_map_kptr_access(...) *where check_map_kptr_access
now returns 0 on success and error code otherwise*
    } else if (!err && t == BPF_READ && value_regno >= 0) {
        ...
    }

be clearer?


>         } else if (base_type(reg->type) == PTR_TO_MEM) {
>                 bool rdonly_mem = type_is_rdonly_mem(reg->type);
>
> --
> 2.35.1
>
