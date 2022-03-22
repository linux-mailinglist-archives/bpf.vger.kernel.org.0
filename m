Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA54B4E39D7
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 08:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiCVHrQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 03:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiCVHrG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 03:47:06 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A0647AF3
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 00:43:59 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w4so14735597ply.13
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 00:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uznHauPu35hktL/T3NYPvxSGDGURn5Dg586HPZhyeKQ=;
        b=nJ4kqr879P4vBqO3f8+7/Txe+7/8qTQ/l7+hn15/1spilJcs6Fvpwj7lQXGKIO8clK
         oHMZrZAhNbFBM4frhQAb4TvBD2iV5UtibsvLqgHjdmN46WhkX74Yvdg6etN7W/JLrGW3
         f4skN4MjgDtR3RihbYexX/Zjlcmd+D1CzFnEWY+hGIxmOPKbivLhBCxYKTrfoLPbgOeo
         QkT5szr6+mmCpep7G4OXENuGS0P48J3VCV39rdgvLfWUbbik17j+ZEdpK/EDTCvOfyWK
         FgKcyguEjL2KyQ+BU4ga/gOEbzXFs0POUzt1OLPfuTg8HJnj9eM2yb3cAHZQrcNy+GEg
         7Qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uznHauPu35hktL/T3NYPvxSGDGURn5Dg586HPZhyeKQ=;
        b=eX92B6+8ttnoRfeFByrbDzPlsTudIcfwrNcf7+dT5CG1gnfcqt60UmA6Kt9cGon6DL
         e/6t8OVkj5dED2SMQMB7MGt03eZZc4YKnS4uFipupCbODmMbGeT9TeTHblwBVXMoFwkz
         uR/hdH362sLz3C6/zpfYhxSIuag8RvJuRtkCVjF29ILD34l3yY2OniQI03BvNR+ECmnU
         rNql9mNy2kJ5Rz0qfVwSBqKd0MsQV7/w/jtGkkutqAJ515r9cjxeLlfgpRlRgy36QueE
         AFyI9qMOz/NzR3gvSJre0payGUm8dl4kRPi2dS1O7BAqwSKDUaMQcqVXhX8Kv8PpPsPX
         aN3g==
X-Gm-Message-State: AOAM5300PQ9NgLvAj6vs67brWyL4YcJECaiBhGaVyLTSEqKgvh3gz7Me
        cW8lNTLlGjIXvvsU6qKCpiE=
X-Google-Smtp-Source: ABdhPJyPWADXpawuTiCysM3Tk1FFQ0jBG43R/6l0RKPb6KMdq/Q0HHmGZMJ1PuppCEVLglDKpD0QlA==
X-Received: by 2002:a17:90a:a78f:b0:1bc:8042:9330 with SMTP id f15-20020a17090aa78f00b001bc80429330mr3466714pjq.229.1647935039151;
        Tue, 22 Mar 2022 00:43:59 -0700 (PDT)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00084a00b004f7ebae5be6sm23215239pfk.155.2022.03.22.00.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 00:43:58 -0700 (PDT)
Date:   Tue, 22 Mar 2022 13:13:57 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v3 03/13] bpf: Allow storing unreferenced kptr
 in map
Message-ID: <20220322074357.rdz6waehxgtyr4sq@apollo>
References: <20220320155510.671497-1-memxor@gmail.com>
 <20220320155510.671497-4-memxor@gmail.com>
 <CAEf4BzaJuW8tdmFz_NDe8K2qeNuLcOjVo3ZP4g5H1Yp60sQrTA@mail.gmail.com>
 <20220322071640.nqc2he44grixyhle@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322071640.nqc2he44grixyhle@apollo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 22, 2022 at 12:46:40PM IST, Kumar Kartikeya Dwivedi wrote:
> On Tue, Mar 22, 2022 at 11:15:42AM IST, Andrii Nakryiko wrote:
> > On Sun, Mar 20, 2022 at 8:55 AM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > This commit introduces a new pointer type 'kptr' which can be embedded
> > > in a map value as holds a PTR_TO_BTF_ID stored by a BPF program during
> > > its invocation. Storing to such a kptr, BPF program's PTR_TO_BTF_ID
> > > register must have the same type as in the map value's BTF, and loading
> > > a kptr marks the destination register as PTR_TO_BTF_ID with the correct
> > > kernel BTF and BTF ID.
> > >
> > > Such kptr are unreferenced, i.e. by the time another invocation of the
> > > BPF program loads this pointer, the object which the pointer points to
> > > may not longer exist. Since PTR_TO_BTF_ID loads (using BPF_LDX) are
> > > patched to PROBE_MEM loads by the verifier, it would safe to allow user
> > > to still access such invalid pointer, but passing such pointers into
> > > BPF helpers and kfuncs should not be permitted. A future patch in this
> > > series will close this gap.
> > >
> > > The flexibility offered by allowing programs to dereference such invalid
> > > pointers while being safe at runtime frees the verifier from doing
> > > complex lifetime tracking. As long as the user may ensure that the
> > > object remains valid, it can ensure data read by it from the kernel
> > > object is valid.
> > >
> > > The user indicates that a certain pointer must be treated as kptr
> > > capable of accepting stores of PTR_TO_BTF_ID of a certain type, by using
> > > a BTF type tag 'kptr' on the pointed to type of the pointer. Then, this
> > > information is recorded in the object BTF which will be passed into the
> > > kernel by way of map's BTF information. The name and kind from the map
> > > value BTF is used to look up the in-kernel type, and the actual BTF and
> > > BTF ID is recorded in the map struct in a new kptr_off_tab member. For
> > > now, only storing pointers to structs is permitted.
> > >
> > > An example of this specification is shown below:
> > >
> > >         #define __kptr __attribute__((btf_type_tag("kptr")))
> > >
> > >         struct map_value {
> > >                 ...
> > >                 struct task_struct __kptr *task;
> > >                 ...
> > >         };
> > >
> > > Then, in a BPF program, user may store PTR_TO_BTF_ID with the type
> > > task_struct into the map, and then load it later.
> > >
> > > Note that the destination register is marked PTR_TO_BTF_ID_OR_NULL, as
> > > the verifier cannot know whether the value is NULL or not statically, it
> > > must treat all potential loads at that map value offset as loading a
> > > possibly NULL pointer.
> > >
> > > Only BPF_LDX, BPF_STX, and BPF_ST with insn->imm = 0 (to denote NULL)
> > > are allowed instructions that can access such a pointer. On BPF_LDX, the
> > > destination register is updated to be a PTR_TO_BTF_ID, and on BPF_STX,
> > > it is checked whether the source register type is a PTR_TO_BTF_ID with
> > > same BTF type as specified in the map BTF. The access size must always
> > > be BPF_DW.
> > >
> > > For the map in map support, the kptr_off_tab for outer map is copied
> > > from the inner map's kptr_off_tab. It was chosen to do a deep copy
> > > instead of introducing a refcount to kptr_off_tab, because the copy only
> > > needs to be done when paramterizing using inner_map_fd in the map in map
> > > case, hence would be unnecessary for all other users.
> > >
> > > It is not permitted to use MAP_FREEZE command and mmap for BPF map
> > > having kptr, similar to the bpf_timer case.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  include/linux/bpf.h     |  29 +++++++-
> > >  include/linux/btf.h     |   2 +
> > >  kernel/bpf/btf.c        | 161 ++++++++++++++++++++++++++++++++++------
> > >  kernel/bpf/map_in_map.c |   5 +-
> > >  kernel/bpf/syscall.c    | 112 +++++++++++++++++++++++++++-
> > >  kernel/bpf/verifier.c   | 120 ++++++++++++++++++++++++++++++
> > >  6 files changed, 401 insertions(+), 28 deletions(-)
> > >
> >
> > [...]
> >
> > > +static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
> > > +                              u32 off, int sz, struct btf_field_info *info)
> > > +{
> > > +       /* For PTR, sz is always == 8 */
> > > +       if (!btf_type_is_ptr(t))
> > > +               return BTF_FIELD_IGNORE;
> > > +       t = btf_type_by_id(btf, t->type);
> > > +
> > > +       if (!btf_type_is_type_tag(t))
> > > +               return BTF_FIELD_IGNORE;
> > > +       /* Reject extra tags */
> > > +       if (btf_type_is_type_tag(btf_type_by_id(btf, t->type)))
> > > +               return -EINVAL;
> >
> > Can we have tag -> const -> tag -> volatile -> tag in BTF? Wouldn't
> > you assume there are no more tags with just this check?
> >
>
> All tags are supposed to be before other modifiers, so tags come first, in
> continuity. See [0].
>
> Alexei suggested to reject all other tags for now.
>
>  [0]: https://lore.kernel.org/bpf/20220127154627.665163-1-yhs@fb.com
>
> >
> > > +       if (strcmp("kptr", __btf_name_by_offset(btf, t->name_off)))
> > > +               return -EINVAL;
> > > +
> > > +       /* Get the base type */
> > > +       if (btf_type_is_modifier(t))
> > > +               t = btf_type_skip_modifiers(btf, t->type, NULL);
> > > +       /* Only pointer to struct is allowed */
> > > +       if (!__btf_type_is_struct(t))
> > > +               return -EINVAL;
> > > +
> > > +       info->type = t;
> > > +       info->off = off;
> > > +       return BTF_FIELD_FOUND;
> > >  }
> > >
> > >  static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t,
> > >                                  const char *name, int sz, int align, int field_type,
> > > -                                struct btf_field_info *info)
> > > +                                struct btf_field_info *info, int info_cnt)
> > >  {
> > >         const struct btf_member *member;
> > > +       int ret, idx = 0;
> > >         u32 i, off;
> > > -       int ret;
> > >
> > >         for_each_member(i, t, member) {
> > >                 const struct btf_type *member_type = btf_type_by_id(btf,
> > > @@ -3210,24 +3242,35 @@ static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t
> > >                 switch (field_type) {
> > >                 case BTF_FIELD_SPIN_LOCK:
> > >                 case BTF_FIELD_TIMER:
> > > -                       ret = btf_find_field_struct(btf, member_type, off, sz, info);
> > > +                       ret = btf_find_field_struct(btf, member_type, off, sz, &info[idx]);
> > > +                       if (ret < 0)
> > > +                               return ret;
> > > +                       break;
> > > +               case BTF_FIELD_KPTR:
> > > +                       ret = btf_find_field_kptr(btf, member_type, off, sz, &info[idx]);
> > >                         if (ret < 0)
> > >                                 return ret;
> > >                         break;
> > >                 default:
> > >                         return -EFAULT;
> > >                 }
> > > +
> > > +               if (ret == BTF_FIELD_FOUND && idx >= info_cnt)
> >
> > hm.. haven't you already written info[info_cnt] above by now? I see
> > that above you do (info_cnt - 1), but why such tricks if you can have
> > a temporary struct btf_field_info on the stack, write into it, and if
> > BTF_FIELD_FOUND and idx < info_cnt then write it into info[idx]?
> >
> >
> > > +                       return -E2BIG;
> > > +               else if (ret == BTF_FIELD_IGNORE)
> > > +                       continue;
> > > +               ++idx;
> > >         }
> > > -       return 0;
> > > +       return idx;
> > >  }
> > >
> > >  static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
> > >                                 const char *name, int sz, int align, int field_type,
> > > -                               struct btf_field_info *info)
> > > +                               struct btf_field_info *info, int info_cnt)
> > >  {
> > >         const struct btf_var_secinfo *vsi;
> > > +       int ret, idx = 0;
> > >         u32 i, off;
> > > -       int ret;
> > >
> > >         for_each_vsi(i, t, vsi) {
> > >                 const struct btf_type *var = btf_type_by_id(btf, vsi->type);
> > > @@ -3245,19 +3288,30 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
> > >                 switch (field_type) {
> > >                 case BTF_FIELD_SPIN_LOCK:
> > >                 case BTF_FIELD_TIMER:
> > > -                       ret = btf_find_field_struct(btf, var_type, off, sz, info);
> > > +                       ret = btf_find_field_struct(btf, var_type, off, sz, &info[idx]);
> > > +                       if (ret < 0)
> > > +                               return ret;
> > > +                       break;
> > > +               case BTF_FIELD_KPTR:
> > > +                       ret = btf_find_field_kptr(btf, var_type, off, sz, &info[idx]);
> > >                         if (ret < 0)
> > >                                 return ret;
> > >                         break;
> > >                 default:
> > >                         return -EFAULT;
> > >                 }
> > > +
> > > +               if (ret == BTF_FIELD_FOUND && idx >= info_cnt)
> >
> > same, already writing past the end of array?
> >
> > > +                       return -E2BIG;
> > > +               if (ret == BTF_FIELD_IGNORE)
> > > +                       continue;
> > > +               ++idx;
> > >         }
> > > -       return 0;
> > > +       return idx;
> > >  }
> > >
> > >  static int btf_find_field(const struct btf *btf, const struct btf_type *t,
> > > -                         int field_type, struct btf_field_info *info)
> > > +                         int field_type, struct btf_field_info *info, int info_cnt)
> > >  {
> > >         const char *name;
> > >         int sz, align;
> > > @@ -3273,14 +3327,20 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
> > >                 sz = sizeof(struct bpf_timer);
> > >                 align = __alignof__(struct bpf_timer);
> > >                 break;
> > > +       case BTF_FIELD_KPTR:
> > > +               name = NULL;
> > > +               sz = sizeof(u64);
> > > +               align = __alignof__(u64);
> >
> > can be 4 on 32-bit arch, is that ok?
> >
>
> Good catch, it must be 8, so will hardcode.
>
> > > +               break;
> > >         default:
> > >                 return -EFAULT;
> > >         }
> > >
> > > +       /* The maximum allowed fields of a certain type will be info_cnt - 1 */
> > >         if (__btf_type_is_struct(t))
> > > -               return btf_find_struct_field(btf, t, name, sz, align, field_type, info);
> > > +               return btf_find_struct_field(btf, t, name, sz, align, field_type, info, info_cnt - 1);
> >
> > why -1, to avoid overwriting past the end of array?
> >
>
> Yes, see my reply to Joanne, let's continue discussing it there.
>
> > >         else if (btf_type_is_datasec(t))
> > > -               return btf_find_datasec_var(btf, t, name, sz, align, field_type, info);
> > > +               return btf_find_datasec_var(btf, t, name, sz, align, field_type, info, info_cnt - 1);
> > >         return -EINVAL;
> > >  }
> > >
> > > @@ -3290,24 +3350,79 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
> > >   */
> > >  int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t)
> > >  {
> > > -       struct btf_field_info info = { .off = -ENOENT };
> > > +       /* btf_find_field requires array of size max + 1 */
> >
> > ok, right, as I expected above, but see also suggestion to not have
> > these weird implicit expectations
> >
> > > +       struct btf_field_info info_arr[2];
> > >         int ret;
> > >
> > > -       ret = btf_find_field(btf, t, BTF_FIELD_SPIN_LOCK, &info);
> > > +       ret = btf_find_field(btf, t, BTF_FIELD_SPIN_LOCK, info_arr, ARRAY_SIZE(info_arr));
> > >         if (ret < 0)
> > >                 return ret;
> > > -       return info.off;
> > > +       if (!ret)
> > > +               return -ENOENT;
> > > +       return info_arr[0].off;
> > >  }
> > >
> > >  int btf_find_timer(const struct btf *btf, const struct btf_type *t)
> > >  {
> > > -       struct btf_field_info info = { .off = -ENOENT };
> > > +       /* btf_find_field requires array of size max + 1 */
> > > +       struct btf_field_info info_arr[2];
> > >         int ret;
> > >
> > > -       ret = btf_find_field(btf, t, BTF_FIELD_TIMER, &info);
> > > +       ret = btf_find_field(btf, t, BTF_FIELD_TIMER, info_arr, ARRAY_SIZE(info_arr));
> > >         if (ret < 0)
> > >                 return ret;
> > > -       return info.off;
> > > +       if (!ret)
> > > +               return -ENOENT;
> > > +       return info_arr[0].off;
> > > +}
> > > +
> > > +struct bpf_map_value_off *btf_find_kptr(const struct btf *btf,
> > > +                                       const struct btf_type *t)
> > > +{
> > > +       /* btf_find_field requires array of size max + 1 */
> > > +       struct btf_field_info info_arr[BPF_MAP_VALUE_OFF_MAX + 1];
> > > +       struct bpf_map_value_off *tab;
> > > +       int ret, i, nr_off;
> > > +
> > > +       /* Revisit stack usage when bumping BPF_MAP_VALUE_OFF_MAX */
> > > +       BUILD_BUG_ON(BPF_MAP_VALUE_OFF_MAX != 8);
> >
> > you can store u32 type_id instead of full btf_type pointer, type
> > looking below in the loop is cheap and won't fail
> >
>
> Ok, will switch to type_id.
>
> >
> > > +
> > > +       ret = btf_find_field(btf, t, BTF_FIELD_KPTR, info_arr, ARRAY_SIZE(info_arr));
> > > +       if (ret < 0)
> > > +               return ERR_PTR(ret);
> > > +       if (!ret)
> > > +               return NULL;
> > > +
> >
> > [...]
> >
> > > +
> > > +bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b)
> > > +{
> > > +       struct bpf_map_value_off *tab_a = map_a->kptr_off_tab, *tab_b = map_b->kptr_off_tab;
> > > +       bool a_has_kptr = map_value_has_kptr(map_a), b_has_kptr = map_value_has_kptr(map_b);
> > > +       int size;
> > > +
> > > +       if (!a_has_kptr && !b_has_kptr)
> > > +               return true;
> > > +       if ((a_has_kptr && !b_has_kptr) || (!a_has_kptr && b_has_kptr))
> > > +               return false;
> >
> > if (a_has_kptr != b_has_kptr)
> >     return false;
> >
>
> Ack.
>
> > > +       if (tab_a->nr_off != tab_b->nr_off)
> > > +               return false;
> > > +       size = offsetof(struct bpf_map_value_off, off[tab_a->nr_off]);
> > > +       return !memcmp(tab_a, tab_b, size);
> > > +}
> > > +
> > >  /* called from workqueue */
> > >  static void bpf_map_free_deferred(struct work_struct *work)
> > >  {
> > >         struct bpf_map *map = container_of(work, struct bpf_map, work);
> > >
> > >         security_bpf_map_free(map);
> > > +       bpf_map_free_kptr_off_tab(map);
> > >         bpf_map_release_memcg(map);
> > >         /* implementation dependent freeing */
> > >         map->ops->map_free(map);
> > > @@ -640,7 +724,7 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
> > >         int err;
> > >
> > >         if (!map->ops->map_mmap || map_value_has_spin_lock(map) ||
> > > -           map_value_has_timer(map))
> > > +           map_value_has_timer(map) || map_value_has_kptr(map))
> > >                 return -ENOTSUPP;
> > >
> > >         if (!(vma->vm_flags & VM_SHARED))
> > > @@ -820,9 +904,31 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
> > >                         return -EOPNOTSUPP;
> > >         }
> > >
> > > -       if (map->ops->map_check_btf)
> > > +       map->kptr_off_tab = btf_find_kptr(btf, value_type);
> >
> > btf_find_kptr() is so confusingly named. It certainly can find more
> > than one kptr, so at least it should be btf_find_kptrs(). Combining
> > with Joanne's suggestion, btf_parse_kptrs() would indeed be better.
> >
>
> Ok.
>
> > > +       if (map_value_has_kptr(map)) {
> > > +               if (!bpf_capable())
> > > +                       return -EPERM;
> > > +               if (map->map_flags & BPF_F_RDONLY_PROG) {
> > > +                       ret = -EACCES;
> > > +                       goto free_map_tab;
> > > +               }
> > > +               if (map->map_type != BPF_MAP_TYPE_HASH &&
> > > +                   map->map_type != BPF_MAP_TYPE_LRU_HASH &&
> > > +                   map->map_type != BPF_MAP_TYPE_ARRAY) {
> >
> > what about PERCPU_ARRAY, for instance? Is there something
> > fundamentally wrong to support it for local storage maps?
> >
>
> Plugging in support into maps that already take timers was easier to begin, I
> can do percpu support as a follow up.
>
> In case of local storage, I'm a little worried about how we prevent creating
> reference cycles. There was a thread where find_get_task_by_pid was proposed as
> unstable helper, once we e.g. support embedding task_struct in map, and allow
> storing such pointer in task local storage, it would be pretty easy to construct
> a circular reference cycle.
>
> Should we think about this now, or should we worry about this when task_struct
> is actually supported as kptr? It's not only task_struct, same applies to sock.
>
> There's a discussion to be had, hence I left it out for now.
>
> > > +                       ret = -EOPNOTSUPP;
> > > +                       goto free_map_tab;
> > > +               }
> > > +       }
> > > +
> > > +       if (map->ops->map_check_btf) {
> > >                 ret = map->ops->map_check_btf(map, btf, key_type, value_type);
> > > +               if (ret < 0)
> > > +                       goto free_map_tab;
> > > +       }
> > >
> > > +       return ret;
> > > +free_map_tab:
> > > +       bpf_map_free_kptr_off_tab(map);
> > >         return ret;
> > >  }
> > >
> > > @@ -1639,7 +1745,7 @@ static int map_freeze(const union bpf_attr *attr)
> > >                 return PTR_ERR(map);
> > >
> > >         if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS ||
> > > -           map_value_has_timer(map)) {
> > > +           map_value_has_timer(map) || map_value_has_kptr(map)) {
> > >                 fdput(f);
> > >                 return -ENOTSUPP;
> > >         }
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 4ce9a528fb63..744b7362e52e 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -3507,6 +3507,94 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
> > >         return __check_ptr_off_reg(env, reg, regno, false);
> > >  }
> > >
> > > +static int map_kptr_match_type(struct bpf_verifier_env *env,
> > > +                              struct bpf_map_value_off_desc *off_desc,
> > > +                              struct bpf_reg_state *reg, u32 regno)
> > > +{
> > > +       const char *targ_name = kernel_type_name(off_desc->btf, off_desc->btf_id);
> > > +       const char *reg_name = "";
> > > +
> > > +       if (reg->type != PTR_TO_BTF_ID && reg->type != PTR_TO_BTF_ID_OR_NULL)
> >
> > base_type(reg->type) != PTR_TO_BTF_ID ?
> >
> > > +               goto bad_type;
> > > +
> > > +       if (!btf_is_kernel(reg->btf)) {
> > > +               verbose(env, "R%d must point to kernel BTF\n", regno);
> > > +               return -EINVAL;
> > > +       }
> > > +       /* We need to verify reg->type and reg->btf, before accessing reg->btf */
> > > +       reg_name = kernel_type_name(reg->btf, reg->btf_id);
> > > +
> > > +       if (__check_ptr_off_reg(env, reg, regno, true))
> > > +               return -EACCES;
> > > +
> > > +       if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> > > +                                 off_desc->btf, off_desc->btf_id))
> > > +               goto bad_type;
> > > +       return 0;
> > > +bad_type:
> > > +       verbose(env, "invalid kptr access, R%d type=%s%s ", regno,
> > > +               reg_type_str(env, reg->type), reg_name);
> > > +       verbose(env, "expected=%s%s\n", reg_type_str(env, PTR_TO_BTF_ID), targ_name);
> >
> > why two separate verbose calls, you can easily combine them (and they
> > should be output on a single line given it's a single error)
> >
>
> reg_type_str cannot be called more than once in the same statement, since it
> reuses the same buffer.
>

I think to fix this we can use an array of buffers (e.g. max of 6 or so), and
then use i++ % ARRAY_SIZE(...), this would allow calling it twice in the same
statement.

> > > +       return -EINVAL;
> > > +}
> > > +
> >
> > [...]
>
> --
> Kartikeya

--
Kartikeya
