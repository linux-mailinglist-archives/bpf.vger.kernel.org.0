Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4C9630252
	for <lists+bpf@lfdr.de>; Thu, 30 May 2019 20:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfE3Sxa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 May 2019 14:53:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45456 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3Sxa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 May 2019 14:53:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id t1so8261300qtc.12;
        Thu, 30 May 2019 11:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3lpSw4A7vcWTO2q/bCUo06/BZoiQqjvQo8KcCK27ZDs=;
        b=qdnNnPklN2i3zKFxEo31/RBLkG/+vgtcOA9xKNijRar0ngQ/T427e+EiE1HdbFbPZU
         k0Nc6vdy3MqSoEeeISRzSQUmhQo+/E1jjkcwQ8imCzvaC4UNMm2PUPq6aY9DPcytCec1
         lP1N6dJBn3TWcBJ5Z1fsg463SYsl1JWnT08l7v5NJXnGvi14MTZ4CZPWYXVNjPA1Zrha
         RBOEpSthwmHt+sDkYCF7GTEhhr47vHKbBYapfuX4A9S2QgYRJ5XmeKqUq5JbZxCyvO7n
         2B44S6Ff/FV+je4LZtbvpfqqH5DliQghRVTC4DLuMS+k+YTvXKPxVlO3dHxHK74IJD1X
         dMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3lpSw4A7vcWTO2q/bCUo06/BZoiQqjvQo8KcCK27ZDs=;
        b=dHidc0TC+tNGidERHcjz30fVeb3EL3JIsTkt+6B/I0WhMrC3aM4CYI5+b99riS0DU0
         d/pbjdEFvrwwUIV8lp7d8sbPpoPEhh6mqL5GMPM5kGDqPMgCN3U1941tptDsW17GMW/X
         Uk/cG+oEBclfXs7KqX3crAVf43suH2/GXKl5sjQuReYhNsFvQBk1Ti2x+f8my9yhaA8o
         XT7GhEef7Vey8r09YivVhBxD5FuaR4wtX8b6A5P52g6muM9JIk3FASGFfcWr4Oi+oKVp
         UcAiwizp6eOkwAKcVbwzSp/bxKbA9BlniEtiCUJ2u2suMHE/JLq3ktui3XAwrEfSuW6H
         ZjHg==
X-Gm-Message-State: APjAAAWtllngq+VvbJ4MTd/M8Cgreh8UhvvfjDVbypXn+juVhVvdKsFx
        R9omU9QtENLhHUgPZRAjp/ul3nwcAFPHD6EwF3E=
X-Google-Smtp-Source: APXvYqzaEJXI1/iTC2G5t10lrf8RsLSrP72esy17LggkwvpNYBc9rQk5WmNqmjHEkPaQoVR4zrmX4tEa0qNv4Nhp3dU=
X-Received: by 2002:ac8:4107:: with SMTP id q7mr2274328qtl.139.1559242408748;
 Thu, 30 May 2019 11:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190530010359.2499670-1-guro@fb.com> <20190530010359.2499670-4-guro@fb.com>
In-Reply-To: <20190530010359.2499670-4-guro@fb.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 30 May 2019 11:53:17 -0700
Message-ID: <CAPhsuW4V++8+=VBBTifHDMOeHx1CBu60K2ZAgZ02YS2RpTJyoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] bpf: group memory related fields in struct bpf_map_memory
To:     Roman Gushchin <guro@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 29, 2019 at 6:04 PM Roman Gushchin <guro@fb.com> wrote:
>
> Group "user" and "pages" fields of bpf_map into the bpf_map_memory
> structure. Later it can be extended with "memcg" and other related
> information.
>
> The main reason for a such change (beside cosmetics) is to pass
> bpf_map_memory structure to charging functions before the actual
> allocation of bpf_map.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  include/linux/bpf.h           | 10 +++++++---
>  kernel/bpf/arraymap.c         |  2 +-
>  kernel/bpf/cpumap.c           |  4 ++--
>  kernel/bpf/devmap.c           |  4 ++--
>  kernel/bpf/hashtab.c          |  4 ++--
>  kernel/bpf/local_storage.c    |  2 +-
>  kernel/bpf/lpm_trie.c         |  4 ++--
>  kernel/bpf/queue_stack_maps.c |  2 +-
>  kernel/bpf/reuseport_array.c  |  2 +-
>  kernel/bpf/stackmap.c         |  4 ++--
>  kernel/bpf/syscall.c          | 19 ++++++++++---------
>  kernel/bpf/xskmap.c           |  4 ++--
>  net/core/bpf_sk_storage.c     |  2 +-
>  net/core/sock_map.c           |  4 ++--
>  14 files changed, 36 insertions(+), 31 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index ff3e00ff84d2..980b7a9bdd21 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -66,6 +66,11 @@ struct bpf_map_ops {
>                                      u64 imm, u32 *off);
>  };
>
> +struct bpf_map_memory {
> +       u32 pages;
> +       struct user_struct *user;
> +};
> +
>  struct bpf_map {
>         /* The first two cachelines with read-mostly members of which some
>          * are also accessed in fast-path (e.g. ops, max_entries).
> @@ -86,7 +91,7 @@ struct bpf_map {
>         u32 btf_key_type_id;
>         u32 btf_value_type_id;
>         struct btf *btf;
> -       u32 pages;
> +       struct bpf_map_memory memory;
>         bool unpriv_array;
>         bool frozen; /* write-once */
>         /* 48 bytes hole */
> @@ -94,8 +99,7 @@ struct bpf_map {
>         /* The 3rd and 4th cacheline with misc members to avoid false sharing
>          * particularly with refcounting.
>          */
> -       struct user_struct *user ____cacheline_aligned;
> -       atomic_t refcnt;
> +       atomic_t refcnt ____cacheline_aligned;
>         atomic_t usercnt;
>         struct work_struct work;
>         char name[BPF_OBJ_NAME_LEN];
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 584636c9e2eb..8fda24e78193 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -138,7 +138,7 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
>
>         /* copy mandatory map attributes */
>         bpf_map_init_from_attr(&array->map, attr);
> -       array->map.pages = cost;
> +       array->map.memory.pages = cost;
>         array->elem_size = elem_size;
>
>         if (percpu && bpf_array_alloc_percpu(array)) {
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index cf727d77c6c6..035268add724 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -108,10 +108,10 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *attr)
>         cost += cpu_map_bitmap_size(attr) * num_possible_cpus();
>         if (cost >= U32_MAX - PAGE_SIZE)
>                 goto free_cmap;
> -       cmap->map.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
> +       cmap->map.memory.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
>
>         /* Notice returns -EPERM on if map size is larger than memlock limit */
> -       ret = bpf_map_precharge_memlock(cmap->map.pages);
> +       ret = bpf_map_precharge_memlock(cmap->map.memory.pages);
>         if (ret) {
>                 err = ret;
>                 goto free_cmap;
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 1e525d70f833..f6c57efb1d0d 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -111,10 +111,10 @@ static struct bpf_map *dev_map_alloc(union bpf_attr *attr)
>         if (cost >= U32_MAX - PAGE_SIZE)
>                 goto free_dtab;
>
> -       dtab->map.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
> +       dtab->map.memory.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
>
>         /* if map size is larger than memlock limit, reject it early */
> -       err = bpf_map_precharge_memlock(dtab->map.pages);
> +       err = bpf_map_precharge_memlock(dtab->map.memory.pages);
>         if (err)
>                 goto free_dtab;
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 0f2708fde5f7..15bf228d2e98 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -364,10 +364,10 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>                 /* make sure page count doesn't overflow */
>                 goto free_htab;
>
> -       htab->map.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
> +       htab->map.memory.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
>
>         /* if map size is larger than memlock limit, reject it early */
> -       err = bpf_map_precharge_memlock(htab->map.pages);
> +       err = bpf_map_precharge_memlock(htab->map.memory.pages);
>         if (err)
>                 goto free_htab;
>
> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index e48302ecb389..574325276650 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -303,7 +303,7 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
>         if (!map)
>                 return ERR_PTR(-ENOMEM);
>
> -       map->map.pages = pages;
> +       map->map.memory.pages = pages;
>
>         /* copy mandatory map attributes */
>         bpf_map_init_from_attr(&map->map, attr);
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index e61630c2e50b..8e423a582760 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -578,9 +578,9 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
>                 goto out_err;
>         }
>
> -       trie->map.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
> +       trie->map.memory.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
>
> -       ret = bpf_map_precharge_memlock(trie->map.pages);
> +       ret = bpf_map_precharge_memlock(trie->map.memory.pages);
>         if (ret)
>                 goto out_err;
>
> diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
> index 0b140d236889..8a510e71d486 100644
> --- a/kernel/bpf/queue_stack_maps.c
> +++ b/kernel/bpf/queue_stack_maps.c
> @@ -89,7 +89,7 @@ static struct bpf_map *queue_stack_map_alloc(union bpf_attr *attr)
>
>         bpf_map_init_from_attr(&qs->map, attr);
>
> -       qs->map.pages = cost;
> +       qs->map.memory.pages = cost;
>         qs->size = size;
>
>         raw_spin_lock_init(&qs->lock);
> diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
> index 18e225de80ff..819515242739 100644
> --- a/kernel/bpf/reuseport_array.c
> +++ b/kernel/bpf/reuseport_array.c
> @@ -176,7 +176,7 @@ static struct bpf_map *reuseport_array_alloc(union bpf_attr *attr)
>
>         /* copy mandatory map attributes */
>         bpf_map_init_from_attr(&array->map, attr);
> -       array->map.pages = cost;
> +       array->map.memory.pages = cost;
>
>         return &array->map;
>  }
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 950ab2f28922..08d4efff73ac 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -131,9 +131,9 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
>         bpf_map_init_from_attr(&smap->map, attr);
>         smap->map.value_size = value_size;
>         smap->n_buckets = n_buckets;
> -       smap->map.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
> +       smap->map.memory.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
>
> -       err = bpf_map_precharge_memlock(smap->map.pages);
> +       err = bpf_map_precharge_memlock(smap->map.memory.pages);
>         if (err)
>                 goto free_smap;
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 3d546b6f4646..df14e63806c8 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -222,19 +222,20 @@ static int bpf_map_init_memlock(struct bpf_map *map)
>         struct user_struct *user = get_current_user();
>         int ret;
>
> -       ret = bpf_charge_memlock(user, map->pages);
> +       ret = bpf_charge_memlock(user, map->memory.pages);
>         if (ret) {
>                 free_uid(user);
>                 return ret;
>         }
> -       map->user = user;
> +       map->memory.user = user;
>         return ret;
>  }
>
>  static void bpf_map_release_memlock(struct bpf_map *map)
>  {
> -       struct user_struct *user = map->user;
> -       bpf_uncharge_memlock(user, map->pages);
> +       struct user_struct *user = map->memory.user;
> +
> +       bpf_uncharge_memlock(user, map->memory.pages);
>         free_uid(user);
>  }
>
> @@ -242,17 +243,17 @@ int bpf_map_charge_memlock(struct bpf_map *map, u32 pages)
>  {
>         int ret;
>
> -       ret = bpf_charge_memlock(map->user, pages);
> +       ret = bpf_charge_memlock(map->memory.user, pages);
>         if (ret)
>                 return ret;
> -       map->pages += pages;
> +       map->memory.pages += pages;
>         return ret;
>  }
>
>  void bpf_map_uncharge_memlock(struct bpf_map *map, u32 pages)
>  {
> -       bpf_uncharge_memlock(map->user, pages);
> -       map->pages -= pages;
> +       bpf_uncharge_memlock(map->memory.user, pages);
> +       map->memory.pages -= pages;
>  }
>
>  static int bpf_map_alloc_id(struct bpf_map *map)
> @@ -395,7 +396,7 @@ static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
>                    map->value_size,
>                    map->max_entries,
>                    map->map_flags,
> -                  map->pages * 1ULL << PAGE_SHIFT,
> +                  map->memory.pages * 1ULL << PAGE_SHIFT,
>                    map->id,
>                    READ_ONCE(map->frozen));
>
> diff --git a/kernel/bpf/xskmap.c b/kernel/bpf/xskmap.c
> index 686d244e798d..f816ee1a0fa0 100644
> --- a/kernel/bpf/xskmap.c
> +++ b/kernel/bpf/xskmap.c
> @@ -40,10 +40,10 @@ static struct bpf_map *xsk_map_alloc(union bpf_attr *attr)
>         if (cost >= U32_MAX - PAGE_SIZE)
>                 goto free_m;
>
> -       m->map.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
> +       m->map.memory.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
>
>         /* Notice returns -EPERM on if map size is larger than memlock limit */
> -       err = bpf_map_precharge_memlock(m->map.pages);
> +       err = bpf_map_precharge_memlock(m->map.memory.pages);
>         if (err)
>                 goto free_m;
>
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 9a8aaf8e235d..92581c3ff220 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -659,7 +659,7 @@ static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
>         smap->elem_size = sizeof(struct bpf_sk_storage_elem) + attr->value_size;
>         smap->cache_idx = (unsigned int)atomic_inc_return(&cache_idx) %
>                 BPF_SK_STORAGE_CACHE_SIZE;
> -       smap->map.pages = pages;
> +       smap->map.memory.pages = pages;
>
>         return &smap->map;
>  }
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index be6092ac69f8..4eb5b6a1b29f 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -49,8 +49,8 @@ static struct bpf_map *sock_map_alloc(union bpf_attr *attr)
>                 goto free_stab;
>         }
>
> -       stab->map.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
> -       err = bpf_map_precharge_memlock(stab->map.pages);
> +       stab->map.memory.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
> +       err = bpf_map_precharge_memlock(stab->map.memory.pages);
>         if (err)
>                 goto free_stab;
>
> --
> 2.20.1
>
