Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13096AD5E4
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 04:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjCGDsS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 22:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjCGDsO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 22:48:14 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8896053DB3
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 19:47:47 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j11so27718248edq.4
        for <bpf@vger.kernel.org>; Mon, 06 Mar 2023 19:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678160866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZVlN7J902DTz+QOHmOfe80In2ome1MY65E223DvtIE=;
        b=ATkWa+AoL/AEqamJ3apPY3Sh8ro6EsAg806Vg3O7ot3CDSWtCxxuWUyopA13gmni+9
         lCGeK4o2sU7Ta+7oewDzf55hDmK2LWBmMKZpwbZhSUo5B1JbNk9S5Kt4uhUyofjfz8Sz
         B51MULbR+UiBl84flpHmB2HlL8sMMgHCOtfOOPk/S6yPVTHCk16lQqXlIqQSN2Mt9Tye
         JOxvymwjV49q13CiHPBvvsBg3w/xfbZUW7ukCvP7y4jKkvhNFNvxCdtHhiM3zYuaRAk6
         qZr5EwVoJhm4dMinl5WU9gCDrQSzzRTbsf5lcDkAzVBEPw79NN2TMueN3PPwfbiDMiFl
         uw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678160866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZVlN7J902DTz+QOHmOfe80In2ome1MY65E223DvtIE=;
        b=XdFQCUgGBzPcTuuFaAqt22IdPyzvdwZEVzCGm47vEZMnyfY1yeB6/kIAphrKKrpaW3
         NQyvWhQAEIRaqCY9ZA/AgCu/SWIFTh+p4FyQQGocxnYF4v/SBAo1wrD18q9v7ITqaI11
         z3DFPfZZ135IUkctti1xp8FuO0tv2I3Nal4sfLRVsYGsokZGI9agH6X93vdYHft+FaDG
         eYOlaaXt5/MCDQoFIGNbhB9ssfzjhHKzYZnlyIlIZyxbpe1LsuciWrl9Bz6o+EgijSxI
         67r+o+iOsYOraSZozV1lc0eES0WAdjHUaOwSphr4cT6x4QOBjfPk+6e/E6Dz5hAw6p1U
         mnqg==
X-Gm-Message-State: AO0yUKVYRqR5cuAcepbLw4caAR9d9gqYsl2lgNDL5bOkMo9k6RV1OhEY
        8qtbnROoERLMUWL60eJodPrp/Z/uGjw4SIJHkaQ=
X-Google-Smtp-Source: AK7set908GHIfkuAt/OZjjU2juDS8E7SOpzsSWouRUWkzbmOEdulZSmlUYdfOk1RZOkuJ6cvXwAe8WWxQzzrB/PbxFg=
X-Received: by 2002:a50:d758:0:b0:4bd:ce43:9ee8 with SMTP id
 i24-20020a50d758000000b004bdce439ee8mr7305900edj.6.1678160865966; Mon, 06 Mar
 2023 19:47:45 -0800 (PST)
MIME-Version: 1.0
References: <20230306084216.3186830-1-martin.lau@linux.dev> <20230306084216.3186830-13-martin.lau@linux.dev>
In-Reply-To: <20230306084216.3186830-13-martin.lau@linux.dev>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 6 Mar 2023 19:47:34 -0800
Message-ID: <CAADnVQJck3WUKNht++fAjKRTBtLUVL2K2FrWeyUr=+MMeiiZvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 12/16] bpf: Use bpf_mem_cache_alloc/free in bpf_selem_alloc/free
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@meta.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 6, 2023 at 12:43=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> This patch uses bpf_mem_cache_alloc/free in bpf_selem_alloc/free.
>
> The ____cacheline_aligned attribute is no longer needed
> in 'struct bpf_local_storage_elem'. bpf_mem_cache_alloc will
> have 'struct llist_node' in front of the 'struct bpf_local_storage_elem'.
> It will use the 8bytes hole in the bpf_local_storage_elem.
>
> After bpf_mem_cache_alloc(), the SDATA(selem)->data is zero-ed because
> bpf_mem_cache_alloc() could return a reused selem. It is to keep
> the existing bpf_map_kzalloc() behavior. Only SDATA(selem)->data
> is zero-ed. SDATA(selem)->data is the visible part to the bpf prog.
> No need to use zero_map_value() to do the zeroing because
> bpf_selem_free() ensures no bpf prog is using the selem before
> returning the selem through bpf_mem_cache_free(). For the internal
> fields of selem, they will be initialized when linking to the
> new smap and the new local_storage.
>
> When bpf_mem_cache_alloc() fails, bpf_selem_alloc() will try to
> fallback to kzalloc only if the caller has GFP_KERNEL flag set (ie. from
> sleepable bpf prog that should not cause deadlock). BPF_MA_SIZE
> and BPF_MA_PTR macro are added for that.
>
> For the common selem free path where the selem is freed when its owner
> is also being freed, reuse_now =3D=3D true and selem can be reused
> immediately. bpf_selem_free() uses bpf_mem_cache_free() where
> selem will be considered for immediate reuse.
>
> For the uncommon path that the bpf prog explicitly deletes the selem (by
> using the helper bpf_*_storage_delete), the selem cannot be reused
> immediately. reuse_now =3D=3D false and bpf_selem_free() will stay with
> the current call_rcu_tasks_trace. BPF_MA_NODE macro is added to get
> the correct address for the kfree.
>
> mem_charge and mem_uncharge are changed to use the BPF_MA_SIZE
> macro. It will have a temporarily over-charge for the
> bpf_local_storage_alloc() because bpf_local_storage is not
> moved to bpf_mem_cache_alloc in this patch but it will be done
> in the next patch.
>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  include/linux/bpf_local_storage.h |  8 ++---
>  include/linux/bpf_mem_alloc.h     |  5 +++
>  kernel/bpf/bpf_local_storage.c    | 56 +++++++++++++++++++++++++------
>  3 files changed, 53 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_=
storage.h
> index adb5023a1af5..a236c9b964cf 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -13,6 +13,7 @@
>  #include <linux/list.h>
>  #include <linux/hash.h>
>  #include <linux/types.h>
> +#include <linux/bpf_mem_alloc.h>
>  #include <uapi/linux/btf.h>
>
>  #define BPF_LOCAL_STORAGE_CACHE_SIZE   16
> @@ -55,6 +56,7 @@ struct bpf_local_storage_map {
>         u32 bucket_log;
>         u16 elem_size;
>         u16 cache_idx;
> +       struct bpf_mem_alloc selem_ma;
>  };
>
>  struct bpf_local_storage_data {
> @@ -74,11 +76,7 @@ struct bpf_local_storage_elem {
>         struct hlist_node snode;        /* Linked to bpf_local_storage */
>         struct bpf_local_storage __rcu *local_storage;
>         struct rcu_head rcu;
> -       /* 8 bytes hole */
> -       /* The data is stored in another cacheline to minimize
> -        * the number of cachelines access during a cache hit.
> -        */
> -       struct bpf_local_storage_data sdata ____cacheline_aligned;
> +       struct bpf_local_storage_data sdata;
>  };
>
>  struct bpf_local_storage {
> diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.=
h
> index a7104af61ab4..0ab16fb0ab50 100644
> --- a/include/linux/bpf_mem_alloc.h
> +++ b/include/linux/bpf_mem_alloc.h
> @@ -5,6 +5,11 @@
>  #include <linux/compiler_types.h>
>  #include <linux/workqueue.h>
>
> +#define BPF_MA_NODE_SZ sizeof(struct llist_node)
> +#define BPF_MA_SIZE(_size) ((_size) + BPF_MA_NODE_SZ)
> +#define BPF_MA_PTR(_node) ((void *)(_node) + BPF_MA_NODE_SZ)
> +#define BPF_MA_NODE(_ptr) ((void *)(_ptr) - BPF_MA_NODE_SZ)
> +
>  struct bpf_mem_cache;
>  struct bpf_mem_caches;
>
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
> index 532b82084ba7..d3c0dd5737d6 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -31,7 +31,7 @@ static int mem_charge(struct bpf_local_storage_map *sma=
p, void *owner, u32 size)
>         if (!map->ops->map_local_storage_charge)
>                 return 0;
>
> -       return map->ops->map_local_storage_charge(smap, owner, size);
> +       return map->ops->map_local_storage_charge(smap, owner, BPF_MA_SIZ=
E(size));
>  }
>
>  static void mem_uncharge(struct bpf_local_storage_map *smap, void *owner=
,
> @@ -40,7 +40,7 @@ static void mem_uncharge(struct bpf_local_storage_map *=
smap, void *owner,
>         struct bpf_map *map =3D &smap->map;
>
>         if (map->ops->map_local_storage_uncharge)
> -               map->ops->map_local_storage_uncharge(smap, owner, size);
> +               map->ops->map_local_storage_uncharge(smap, owner, BPF_MA_=
SIZE(size));
>  }
>
>  static struct bpf_local_storage __rcu **
> @@ -80,12 +80,32 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, v=
oid *owner,
>         if (charge_mem && mem_charge(smap, owner, smap->elem_size))
>                 return NULL;
>
> -       selem =3D bpf_map_kzalloc(&smap->map, smap->elem_size,
> -                               gfp_flags | __GFP_NOWARN);
> +       migrate_disable();
> +       selem =3D bpf_mem_cache_alloc(&smap->selem_ma);
> +       migrate_enable();
> +       if (!selem && (gfp_flags & GFP_KERNEL)) {
> +               void *ma_node;
> +
> +               ma_node =3D bpf_map_kzalloc(&smap->map,
> +                                         BPF_MA_SIZE(smap->elem_size),
> +                                         gfp_flags | __GFP_NOWARN);
> +               if (ma_node)
> +                       selem =3D BPF_MA_PTR(ma_node);
> +       }

If I understand it correctly the code is not trying
to free selem the same way it allocated it.
So we can have kzalloc-ed selems freed into bpf_mem_cache_alloc free-list.
That feels dangerous.
I don't think we can do such things in local storage,
but if we add this api to bpf_mem_alloc it might be acceptable.
I mean mem alloc will try to take from the free list and if empty
and GFP_KERNEL it will kzalloc it.
The knowledge of hidden llist_node shouldn't leave the bpf/memalloc.c file.
reuse_now should probably be a memalloc api flag too.
The implementation detail that it's scary but ok-ish to kfree or
bpf_mem_cache_free depending on circumstances should stay in memalloc.c
