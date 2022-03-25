Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61844E7602
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 16:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348201AbiCYPJq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 11:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359871AbiCYPIO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 11:08:14 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81A9A7741
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 08:06:39 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id jx9so7790784pjb.5
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 08:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GBku90AupFIne1jZANCrIvTNqpqO+pDrsrySmIH0P+A=;
        b=T3N9lghWNRKWSxDLjIV3W+9qpNCAgIQalnhu/mxAfOIklcCarRu3Zjk2FtYU8vOdaX
         C50mG2IFMKdRvfnyXWhO96+t65UoJEvSsflL44SeQ30C4PmenSkinBTyg3zaBByP99tJ
         H/tEj3S/OjLBzj9KTsGpBvNs0UYG6UTnKh624kbRo9KnXuTBckIkytwyApCoJnKSA0Mn
         4ZSKDgkRY62+VwUCZ5EYEzCoDUFQmX+Q6YXvcff35sVI3fP9KFNk+fmKmTPyTvct+C6P
         GzOj2gx0sk9tvYEj1jq6Qza5+OlLlSzaZ6PC7zJ3Laaruwl5QT1vZ8VDXScBXl+bImxJ
         9EEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GBku90AupFIne1jZANCrIvTNqpqO+pDrsrySmIH0P+A=;
        b=UZBjRB6rObDExLRqsOqJl/SFNLsrsIS6wiR40o45FlnQQjKSPGoZNVmGMTWfZoURxP
         dPowxD3xD7Fqf8J/vfFM07WFal9+b08xPWl/lBvY3NDnzXtYSiuzOaNOMk+DXuYqDm2h
         BvQTDKZ+Xyd26aTJWEqEr2+oopQ2Zl3oEBJZ88gN0jgZwtfwq2V1SEZcSOZ9wTVwOP4n
         N+IHfUB1MZeUH3JgJT8cN1ctkPYpwsnbOHJm+jUc2o1Py3P9tVJAoCXH1wPm45/H7cH8
         kpG8C7+J48uJPKKDpyYUfmqeE/dT8g6zpp+v7U/F167nrKWuG0OhtKTy8KWXuRH3PtXc
         rOUA==
X-Gm-Message-State: AOAM530dpOjVYXKARhqPpn+cWziiGig0jNuAGwzdCPyJJLiS1cnJLjXi
        o1Lbrqg4VPvp+WUm9NYrlTA=
X-Google-Smtp-Source: ABdhPJzT4p6unai5O5bkI0az2kMiw90SaIkAn8cqJiW5F7GOIePHVlZ3SnjW4vke5Kgxpw+8/tFUDA==
X-Received: by 2002:a17:902:ce0a:b0:14f:bdcd:a56 with SMTP id k10-20020a170902ce0a00b0014fbdcd0a56mr12094459plg.97.1648220798934;
        Fri, 25 Mar 2022 08:06:38 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id s20-20020aa78d54000000b004fac74c83b3sm7113955pfe.186.2022.03.25.08.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 08:06:38 -0700 (PDT)
Date:   Fri, 25 Mar 2022 20:36:35 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v3 07/13] bpf: Adapt copy_map_value for multiple
 offset case
Message-ID: <20220325150635.ebrdzxjlt2bhqjt4@apollo>
References: <20220320155510.671497-1-memxor@gmail.com>
 <20220320155510.671497-8-memxor@gmail.com>
 <CAEf4BzayMZcghFEKtbG58b9yC76P1wzc==wrape89bdS9wQemA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzayMZcghFEKtbG58b9yC76P1wzc==wrape89bdS9wQemA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 23, 2022 at 02:08:36AM IST, Andrii Nakryiko wrote:
> On Sun, Mar 20, 2022 at 8:55 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Since now there might be at most 10 offsets that need handling in
> > copy_map_value, the manual shuffling and special case is no longer going
> > to work. Hence, let's generalise the copy_map_value function by using
> > a sorted array of offsets to skip regions that must be avoided while
> > copying into and out of a map value.
> >
> > When the map is created, we populate the offset array in struct map,
> > with one extra element for map->value_size, which is used as the final
> > offset to subtract previous offset from. Then, copy_map_value uses this
> > sorted offset array is used to memcpy while skipping timer, spin lock,
> > and kptr.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h  | 55 +++++++++++++++++++++++---------------------
> >  kernel/bpf/syscall.c | 52 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 81 insertions(+), 26 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 9d424d567dd3..6474d2d44b78 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -158,6 +158,10 @@ struct bpf_map_ops {
> >  enum {
> >         /* Support at most 8 pointers in a BPF map value */
> >         BPF_MAP_VALUE_OFF_MAX = 8,
> > +       BPF_MAP_OFF_ARR_MAX   = BPF_MAP_VALUE_OFF_MAX +
> > +                               1 + /* for bpf_spin_lock */
> > +                               1 + /* for bpf_timer */
> > +                               1,  /* for map->value_size sentinel */
> >  };
> >
> >  enum {
> > @@ -206,9 +210,17 @@ struct bpf_map {
> >         char name[BPF_OBJ_NAME_LEN];
> >         bool bypass_spec_v1;
> >         bool frozen; /* write-once; write-protected by freeze_mutex */
> > -       /* 6 bytes hole */
> > -
> > -       /* The 3rd and 4th cacheline with misc members to avoid false sharing
> > +       /* 2 bytes hole */
> > +       struct {
> > +               struct {
> > +                       u32 off;
> > +                       u8 sz;
>
> So here we are wasting 11 * 3 == 33 bytes of padding, right? And it
> will only increase as we add bpf_dynptr support soon.
>
> But if we split this struct into two arrays you won't be wasting any of that:
>
> struct {
>     u32 cnt;
>     u32 field_offs[BPF_MAP_OFF_ARR_MAX];
>     u8 szs[BPF_MAP_OFF_ARR_MAX]
> } off_arr;
>
> ?

Ok, will switch to this.

>
> Further, given the majority of BPF maps in the system probably won't
> use any of these special fields, would it make sense to dynamically
> allocate this portion of struct bpf_map?
>

Yes, dynamically allocating also makes sense. I'll go with that for v4.

> > +               } field[BPF_MAP_OFF_ARR_MAX];
> > +               u32 cnt;
> > +       } off_arr;
> > +       /* 40 bytes hole */
> > +
> > +       /* The 4th and 5th cacheline with misc members to avoid false sharing
> >          * particularly with refcounting.
> >          */
> >         atomic64_t refcnt ____cacheline_aligned;
> > @@ -250,36 +262,27 @@ static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
> >                 memset(dst + map->spin_lock_off, 0, sizeof(struct bpf_spin_lock));
> >         if (unlikely(map_value_has_timer(map)))
> >                 memset(dst + map->timer_off, 0, sizeof(struct bpf_timer));
> > +       if (unlikely(map_value_has_kptr(map))) {
> > +               struct bpf_map_value_off *tab = map->kptr_off_tab;
> > +               int i;
> > +
> > +               for (i = 0; i < tab->nr_off; i++)
> > +                       *(u64 *)(dst + tab->off[i].offset) = 0;
> > +       }
> >  }
> >
> >  /* copy everything but bpf_spin_lock and bpf_timer. There could be one of each. */
> >  static inline void copy_map_value(struct bpf_map *map, void *dst, void *src)
> >  {
> > -       u32 s_off = 0, s_sz = 0, t_off = 0, t_sz = 0;
> > +       int i;
> >
> > -       if (unlikely(map_value_has_spin_lock(map))) {
> > -               s_off = map->spin_lock_off;
> > -               s_sz = sizeof(struct bpf_spin_lock);
> > -       }
> > -       if (unlikely(map_value_has_timer(map))) {
> > -               t_off = map->timer_off;
> > -               t_sz = sizeof(struct bpf_timer);
> > -       }
> > +       memcpy(dst, src, map->off_arr.field[0].off);
> > +       for (i = 1; i < map->off_arr.cnt; i++) {
> > +               u32 curr_off = map->off_arr.field[i - 1].off;
> > +               u32 next_off = map->off_arr.field[i].off;
> >
> > -       if (unlikely(s_sz || t_sz)) {
> > -               if (s_off < t_off || !s_sz) {
> > -                       swap(s_off, t_off);
> > -                       swap(s_sz, t_sz);
> > -               }
> > -               memcpy(dst, src, t_off);
> > -               memcpy(dst + t_off + t_sz,
> > -                      src + t_off + t_sz,
> > -                      s_off - t_off - t_sz);
> > -               memcpy(dst + s_off + s_sz,
> > -                      src + s_off + s_sz,
> > -                      map->value_size - s_off - s_sz);
> > -       } else {
> > -               memcpy(dst, src, map->value_size);
> > +               curr_off += map->off_arr.field[i - 1].sz;
> > +               memcpy(dst + curr_off, src + curr_off, next_off - curr_off);
> >         }
>
> We can also get away with value_size sentinel value if we rewrite this
> logic as follows:
>
> u32 cur_off = 0;
> int i;
>
> for (i = 0; i < map->off_arr.cnt; i++) {
>     memcpy(dst + cur_off, src + cur_off,  map->off_arr.field[i].off - cur_off);
>     cur_off += map->off_arr.field[i].sz;
> }
>
> memcpy(dst + cur_off, src + cur_off, map->value_size - cur_off);
>

Looks better, will switch.

>
> It will be as optimal but won't require value_size sentinel.
>
> >  }
> >  void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 5990d6fa97ab..7b32537bd81f 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/pgtable.h>
> >  #include <linux/bpf_lsm.h>
> >  #include <linux/poll.h>
> > +#include <linux/sort.h>
> >  #include <linux/bpf-netns.h>
> >  #include <linux/rcupdate_trace.h>
> >  #include <linux/memcontrol.h>
> > @@ -851,6 +852,55 @@ int map_check_no_btf(const struct bpf_map *map,
> >         return -ENOTSUPP;
> >  }
> >
> > +static int map_off_arr_cmp(const void *_a, const void *_b)
> > +{
> > +       const u32 a = *(const u32 *)_a;
> > +       const u32 b = *(const u32 *)_b;
> > +
> > +       if (a < b)
> > +               return -1;
> > +       else if (a > b)
> > +               return 1;
> > +       return 0;
> > +}
> > +
> > +static void map_populate_off_arr(struct bpf_map *map)
> > +{
> > +       u32 i;
> > +
> > +       map->off_arr.cnt = 0;
> > +       if (map_value_has_spin_lock(map)) {
> > +               i = map->off_arr.cnt;
> > +
> > +               map->off_arr.field[i].off = map->spin_lock_off;
> > +               map->off_arr.field[i].sz = sizeof(struct bpf_spin_lock);
> > +               map->off_arr.cnt++;
> > +       }
> > +       if (map_value_has_timer(map)) {
> > +               i = map->off_arr.cnt;
> > +
> > +               map->off_arr.field[i].off = map->timer_off;
> > +               map->off_arr.field[i].sz = sizeof(struct bpf_timer);
> > +               map->off_arr.cnt++;
> > +       }
> > +       if (map_value_has_kptr(map)) {
> > +               struct bpf_map_value_off *tab = map->kptr_off_tab;
> > +               u32 j = map->off_arr.cnt;
> > +
> > +               for (i = 0; i < tab->nr_off; i++) {
> > +                       map->off_arr.field[j + i].off = tab->off[i].offset;
> > +                       map->off_arr.field[j + i].sz = sizeof(u64);
> > +               }
> > +               map->off_arr.cnt += tab->nr_off;
> > +       }
> > +
> > +       map->off_arr.field[map->off_arr.cnt++].off = map->value_size;
>
> Using a pointer for map->off_arr.field[j + i] and incrementing it
> along the cnt would make this code more succinct, and possibly even a
> bit more efficient. With my above suggestion to split offs from szs,
> you'll need two pointers, but still might be cleaner.
>

Ack.

> > +       if (map->off_arr.cnt == 1)
> > +               return;
> > +       sort(map->off_arr.field, map->off_arr.cnt, sizeof(map->off_arr.field[0]),
> > +            map_off_arr_cmp, NULL);
>
> See how Jiri is using sort_r() to sort two related arrays and keep
> them in sync w.r.t. order.
>

Thanks for the pointer.

> > +}
> > +
> >  static int map_check_btf(struct bpf_map *map, const struct btf *btf,
> >                          u32 btf_key_id, u32 btf_value_id)
> >  {
> > @@ -1018,6 +1068,8 @@ static int map_create(union bpf_attr *attr)
> >                         attr->btf_vmlinux_value_type_id;
> >         }
> >
> > +       map_populate_off_arr(map);
> > +
> >         err = security_bpf_map_alloc(map);
> >         if (err)
> >                 goto free_map;
> > --
> > 2.35.1
> >

--
Kartikeya
