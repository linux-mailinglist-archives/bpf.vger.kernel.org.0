Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9574E47A5
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 21:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiCVUkS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 16:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiCVUkR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 16:40:17 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A0969282
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 13:38:48 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id b9so13283842ila.8
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 13:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MkXbtzKxVOQqsoiIN3SqXpTKVr6wtC4Y4soo/dn7JRs=;
        b=cxGDf+swb8b+eo939F7pJDrIhNF8Ey/Sng0hA2A+PTDfARCpLFAKsfn82kfnRUDj7T
         a7hkhCoNxr53kFMso12+kLct65HXJYK2X/55laN3rZZQS8u4c3y7pdIRAXTYIRendpU1
         MiYRdOd5tWQWqodKqqCHoHcweufdQdH2U13Lm5QfMDIukh7/82pySw9Awusfp000MzSu
         0QcR38H343nNWBAB3jiXRoOLyKr94igfLYMuZzLr63aqxfxFWuq/J9deWheKIBRKR5kp
         hvjk38R4/0XSrGJe5DtzDhQOVVMjiut49u9NAlwi909GbMdqsf4JqDjlWjRodVFc9UlW
         88tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MkXbtzKxVOQqsoiIN3SqXpTKVr6wtC4Y4soo/dn7JRs=;
        b=r0E7pI5dW1IYnp9w6awg7tB4ieP5tkDm+cUbBgF03lAF0vDIWkxxyjTxe5B2vTJvfN
         mqQvQN75PUQSiB+fdc4kJ26Vt6AroWe5XPFdVAmYxT9ZAeZK5+sIvUauoMlPlL3v3YXM
         EzCYFleSM9G2RSP1edQ0fOnNHzEzENm3vNc1ToWNlKXdtHrKfQqokJRIB3VVQd40wxLB
         PB6go4rwZr8RGI3XciSsCu9OOtMtSYxw4be71/fFL+0DLwZyl2BvJApmnwq6qw0u9yfP
         OldX6G5G/NgbzwjkrfZKUv754mslM6c7ZrVi9LbcW4y2v/9WK08w5VdgwGmQUem9CoZH
         cYzw==
X-Gm-Message-State: AOAM530W+dLFRYQbSSU8y0Bt6p5D6owa0OrPJb2uZbo5bbFmlUody7R6
        wQ/4WCGvVHA6fAtXhGNvCNDvm/s5DgVp6VXA2X0=
X-Google-Smtp-Source: ABdhPJxULPLsKh/4DPlk+U3X0IFTIh+ROlm6tLNtaLNR2sXfGah39h8NA434B2bMy3cAVbzPPZl0UxmXTB8AnKjvOsE=
X-Received: by 2002:a05:6e02:16c7:b0:2c7:e458:d863 with SMTP id
 7-20020a056e0216c700b002c7e458d863mr12302872ilx.71.1647981527993; Tue, 22 Mar
 2022 13:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220320155510.671497-1-memxor@gmail.com> <20220320155510.671497-8-memxor@gmail.com>
In-Reply-To: <20220320155510.671497-8-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 22 Mar 2022 13:38:36 -0700
Message-ID: <CAEf4BzayMZcghFEKtbG58b9yC76P1wzc==wrape89bdS9wQemA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 07/13] bpf: Adapt copy_map_value for multiple
 offset case
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

On Sun, Mar 20, 2022 at 8:55 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Since now there might be at most 10 offsets that need handling in
> copy_map_value, the manual shuffling and special case is no longer going
> to work. Hence, let's generalise the copy_map_value function by using
> a sorted array of offsets to skip regions that must be avoided while
> copying into and out of a map value.
>
> When the map is created, we populate the offset array in struct map,
> with one extra element for map->value_size, which is used as the final
> offset to subtract previous offset from. Then, copy_map_value uses this
> sorted offset array is used to memcpy while skipping timer, spin lock,
> and kptr.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h  | 55 +++++++++++++++++++++++---------------------
>  kernel/bpf/syscall.c | 52 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 81 insertions(+), 26 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 9d424d567dd3..6474d2d44b78 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -158,6 +158,10 @@ struct bpf_map_ops {
>  enum {
>         /* Support at most 8 pointers in a BPF map value */
>         BPF_MAP_VALUE_OFF_MAX = 8,
> +       BPF_MAP_OFF_ARR_MAX   = BPF_MAP_VALUE_OFF_MAX +
> +                               1 + /* for bpf_spin_lock */
> +                               1 + /* for bpf_timer */
> +                               1,  /* for map->value_size sentinel */
>  };
>
>  enum {
> @@ -206,9 +210,17 @@ struct bpf_map {
>         char name[BPF_OBJ_NAME_LEN];
>         bool bypass_spec_v1;
>         bool frozen; /* write-once; write-protected by freeze_mutex */
> -       /* 6 bytes hole */
> -
> -       /* The 3rd and 4th cacheline with misc members to avoid false sharing
> +       /* 2 bytes hole */
> +       struct {
> +               struct {
> +                       u32 off;
> +                       u8 sz;

So here we are wasting 11 * 3 == 33 bytes of padding, right? And it
will only increase as we add bpf_dynptr support soon.

But if we split this struct into two arrays you won't be wasting any of that:

struct {
    u32 cnt;
    u32 field_offs[BPF_MAP_OFF_ARR_MAX];
    u8 szs[BPF_MAP_OFF_ARR_MAX]
} off_arr;

?

Further, given the majority of BPF maps in the system probably won't
use any of these special fields, would it make sense to dynamically
allocate this portion of struct bpf_map?

> +               } field[BPF_MAP_OFF_ARR_MAX];
> +               u32 cnt;
> +       } off_arr;
> +       /* 40 bytes hole */
> +
> +       /* The 4th and 5th cacheline with misc members to avoid false sharing
>          * particularly with refcounting.
>          */
>         atomic64_t refcnt ____cacheline_aligned;
> @@ -250,36 +262,27 @@ static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
>                 memset(dst + map->spin_lock_off, 0, sizeof(struct bpf_spin_lock));
>         if (unlikely(map_value_has_timer(map)))
>                 memset(dst + map->timer_off, 0, sizeof(struct bpf_timer));
> +       if (unlikely(map_value_has_kptr(map))) {
> +               struct bpf_map_value_off *tab = map->kptr_off_tab;
> +               int i;
> +
> +               for (i = 0; i < tab->nr_off; i++)
> +                       *(u64 *)(dst + tab->off[i].offset) = 0;
> +       }
>  }
>
>  /* copy everything but bpf_spin_lock and bpf_timer. There could be one of each. */
>  static inline void copy_map_value(struct bpf_map *map, void *dst, void *src)
>  {
> -       u32 s_off = 0, s_sz = 0, t_off = 0, t_sz = 0;
> +       int i;
>
> -       if (unlikely(map_value_has_spin_lock(map))) {
> -               s_off = map->spin_lock_off;
> -               s_sz = sizeof(struct bpf_spin_lock);
> -       }
> -       if (unlikely(map_value_has_timer(map))) {
> -               t_off = map->timer_off;
> -               t_sz = sizeof(struct bpf_timer);
> -       }
> +       memcpy(dst, src, map->off_arr.field[0].off);
> +       for (i = 1; i < map->off_arr.cnt; i++) {
> +               u32 curr_off = map->off_arr.field[i - 1].off;
> +               u32 next_off = map->off_arr.field[i].off;
>
> -       if (unlikely(s_sz || t_sz)) {
> -               if (s_off < t_off || !s_sz) {
> -                       swap(s_off, t_off);
> -                       swap(s_sz, t_sz);
> -               }
> -               memcpy(dst, src, t_off);
> -               memcpy(dst + t_off + t_sz,
> -                      src + t_off + t_sz,
> -                      s_off - t_off - t_sz);
> -               memcpy(dst + s_off + s_sz,
> -                      src + s_off + s_sz,
> -                      map->value_size - s_off - s_sz);
> -       } else {
> -               memcpy(dst, src, map->value_size);
> +               curr_off += map->off_arr.field[i - 1].sz;
> +               memcpy(dst + curr_off, src + curr_off, next_off - curr_off);
>         }

We can also get away with value_size sentinel value if we rewrite this
logic as follows:

u32 cur_off = 0;
int i;

for (i = 0; i < map->off_arr.cnt; i++) {
    memcpy(dst + cur_off, src + cur_off,  map->off_arr.field[i].off - cur_off);
    cur_off += map->off_arr.field[i].sz;
}

memcpy(dst + cur_off, src + cur_off, map->value_size - cur_off);


It will be as optimal but won't require value_size sentinel.

>  }
>  void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 5990d6fa97ab..7b32537bd81f 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -30,6 +30,7 @@
>  #include <linux/pgtable.h>
>  #include <linux/bpf_lsm.h>
>  #include <linux/poll.h>
> +#include <linux/sort.h>
>  #include <linux/bpf-netns.h>
>  #include <linux/rcupdate_trace.h>
>  #include <linux/memcontrol.h>
> @@ -851,6 +852,55 @@ int map_check_no_btf(const struct bpf_map *map,
>         return -ENOTSUPP;
>  }
>
> +static int map_off_arr_cmp(const void *_a, const void *_b)
> +{
> +       const u32 a = *(const u32 *)_a;
> +       const u32 b = *(const u32 *)_b;
> +
> +       if (a < b)
> +               return -1;
> +       else if (a > b)
> +               return 1;
> +       return 0;
> +}
> +
> +static void map_populate_off_arr(struct bpf_map *map)
> +{
> +       u32 i;
> +
> +       map->off_arr.cnt = 0;
> +       if (map_value_has_spin_lock(map)) {
> +               i = map->off_arr.cnt;
> +
> +               map->off_arr.field[i].off = map->spin_lock_off;
> +               map->off_arr.field[i].sz = sizeof(struct bpf_spin_lock);
> +               map->off_arr.cnt++;
> +       }
> +       if (map_value_has_timer(map)) {
> +               i = map->off_arr.cnt;
> +
> +               map->off_arr.field[i].off = map->timer_off;
> +               map->off_arr.field[i].sz = sizeof(struct bpf_timer);
> +               map->off_arr.cnt++;
> +       }
> +       if (map_value_has_kptr(map)) {
> +               struct bpf_map_value_off *tab = map->kptr_off_tab;
> +               u32 j = map->off_arr.cnt;
> +
> +               for (i = 0; i < tab->nr_off; i++) {
> +                       map->off_arr.field[j + i].off = tab->off[i].offset;
> +                       map->off_arr.field[j + i].sz = sizeof(u64);
> +               }
> +               map->off_arr.cnt += tab->nr_off;
> +       }
> +
> +       map->off_arr.field[map->off_arr.cnt++].off = map->value_size;

Using a pointer for map->off_arr.field[j + i] and incrementing it
along the cnt would make this code more succinct, and possibly even a
bit more efficient. With my above suggestion to split offs from szs,
you'll need two pointers, but still might be cleaner.

> +       if (map->off_arr.cnt == 1)
> +               return;
> +       sort(map->off_arr.field, map->off_arr.cnt, sizeof(map->off_arr.field[0]),
> +            map_off_arr_cmp, NULL);

See how Jiri is using sort_r() to sort two related arrays and keep
them in sync w.r.t. order.

> +}
> +
>  static int map_check_btf(struct bpf_map *map, const struct btf *btf,
>                          u32 btf_key_id, u32 btf_value_id)
>  {
> @@ -1018,6 +1068,8 @@ static int map_create(union bpf_attr *attr)
>                         attr->btf_vmlinux_value_type_id;
>         }
>
> +       map_populate_off_arr(map);
> +
>         err = security_bpf_map_alloc(map);
>         if (err)
>                 goto free_map;
> --
> 2.35.1
>
