Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E206A5A0263
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 21:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbiHXT7a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 15:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbiHXT72 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 15:59:28 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AB779EDB
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 12:59:27 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id p187so6815596iod.8
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 12:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=BXUdI1Jpalg34NGFGVj8iK1ZM3Vaaf6IdCCmFUSOd1c=;
        b=muZmJbVruwFJsDz2f+TETMiZ+kWP9hQw78ruf2XtkyLDP1m11vzKXgg5z6B+zkeP+D
         SdGj2p6LDsN9i4DcZEhKLh9cDPNSgDARghZrpDgWwk6nutNpllVDRc2PDgeTj1koIOt2
         uMqaJSKbnb7Fug8ey4IxNRFAuxZgz3OHoUdNeUjE3PDbImeWZQgjh+KQRUJ1kAZYoOT4
         zPCWfAOEC4f7QUsQua8MRP8ANTfE9ehJe7b4fKuGw3FTsL+uY3dRO6+02nnHhBbrGO/O
         8ZGXXuDHpWroNbkin+mcp2z0Ndtpj7yNX3V2ksqcR6W5vG8533JaRHjmLu0oePRfvhM5
         5shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BXUdI1Jpalg34NGFGVj8iK1ZM3Vaaf6IdCCmFUSOd1c=;
        b=Gmh9DX8tZFIhGwdk8lq6SKXMivFVA5qGvKARwKObtVmPvc1i22gSZYygnVza9IZAxg
         hMn5B0x4Qa6f2dsQRxwXTUkZ7FPHKv1zN5XgJcHRY7+x4k0vZ2QmRuSXkTbT/yx0yV6g
         VYPgTD2PoZ1A/mlC9QX1J6w/usvMoKrUs62b2jf5soXFUSpRi68W4Cc/zDrdnaLj5648
         3DycR+VvIYuCmCTeMW0sZ9QMtSXaXb4HrhtkTONw2aU9F9Ak5wzlqlVc5W0hKRXMCsKe
         2/Mg4OXj1CtwtwkpDwdW74C93J3pUDQlJ47uIKje9Ar2Ifhl59/Zz45Ih1tvRN6NMvos
         oLNw==
X-Gm-Message-State: ACgBeo3Z67+mka9PXAn39+tjxANFUK0IqHBkFv3iA2A6r2yTW25dah/i
        6m/8WVi5J7RoYCcXYGS2+Ou1onP+pRzNfNcyzYcSdBrts14=
X-Google-Smtp-Source: AA6agR61fZl2+zM3w8B4PiKtjpYezq7vEaugAGbr6jwhA0PjbY/w6WkVXLzrjcEUQHf/geX/5CcyDjVqOG9kWcZpST0=
X-Received: by 2002:a05:6638:2382:b0:347:7dae:b276 with SMTP id
 q2-20020a056638238200b003477daeb276mr253066jat.124.1661371166555; Wed, 24 Aug
 2022 12:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com> <20220819214232.18784-10-alexei.starovoitov@gmail.com>
In-Reply-To: <20220819214232.18784-10-alexei.starovoitov@gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Wed, 24 Aug 2022 21:58:49 +0200
Message-ID: <CAP01T74qCUsm3mO64d6mbDcjQZxO2fxjZ+JX7kkv2ACXPpZojw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 09/15] bpf: Batch call_rcu callbacks instead
 of SLAB_TYPESAFE_BY_RCU.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        tj@kernel.org, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com, joel@joelfernandes.org
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

On Fri, 19 Aug 2022 at 23:43, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> SLAB_TYPESAFE_BY_RCU makes kmem_caches non mergeable and slows down
> kmem_cache_destroy. All bpf_mem_cache are safe to share across different maps
> and programs. Convert SLAB_TYPESAFE_BY_RCU to batched call_rcu. This change
> solves the memory consumption issue, avoids kmem_cache_destroy latency and
> keeps bpf hash map performance the same.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Makes sense, there was a call_rcu_lazy work from Joel (CCed) on doing
this batching using a timer + max batch count instead, I wonder if
that fits our use case and could be useful in the future when it is
merged?

https://lore.kernel.org/rcu/20220713213237.1596225-2-joel@joelfernandes.org

wdyt?

> ---
>  kernel/bpf/memalloc.c | 64 +++++++++++++++++++++++++++++++++++++++++--
>  kernel/bpf/syscall.c  |  5 +++-
>  2 files changed, 65 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 22b729914afe..d765a5cb24b4 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -100,6 +100,11 @@ struct bpf_mem_cache {
>         /* count of objects in free_llist */
>         int free_cnt;
>         int low_watermark, high_watermark, batch;
> +
> +       struct rcu_head rcu;
> +       struct llist_head free_by_rcu;
> +       struct llist_head waiting_for_gp;
> +       atomic_t call_rcu_in_progress;
>  };
>
>  struct bpf_mem_caches {
> @@ -188,6 +193,45 @@ static void free_one(struct bpf_mem_cache *c, void *obj)
>                 kfree(obj);
>  }
>
> +static void __free_rcu(struct rcu_head *head)
> +{
> +       struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
> +       struct llist_node *llnode = llist_del_all(&c->waiting_for_gp);
> +       struct llist_node *pos, *t;
> +
> +       llist_for_each_safe(pos, t, llnode)
> +               free_one(c, pos);
> +       atomic_set(&c->call_rcu_in_progress, 0);
> +}
> +
> +static void enque_to_free(struct bpf_mem_cache *c, void *obj)
> +{
> +       struct llist_node *llnode = obj;
> +
> +       /* bpf_mem_cache is a per-cpu object. Freeing happens in irq_work.
> +        * Nothing races to add to free_by_rcu list.
> +        */
> +       __llist_add(llnode, &c->free_by_rcu);
> +}
> +
> +static void do_call_rcu(struct bpf_mem_cache *c)
> +{
> +       struct llist_node *llnode, *t;
> +
> +       if (atomic_xchg(&c->call_rcu_in_progress, 1))
> +               return;
> +
> +       WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp));
> +       llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu))
> +               /* There is no concurrent __llist_add(waiting_for_gp) access.
> +                * It doesn't race with llist_del_all either.
> +                * But there could be two concurrent llist_del_all(waiting_for_gp):
> +                * from __free_rcu() and from drain_mem_cache().
> +                */
> +               __llist_add(llnode, &c->waiting_for_gp);
> +       call_rcu(&c->rcu, __free_rcu);
> +}
> +
>  static void free_bulk(struct bpf_mem_cache *c)
>  {
>         struct llist_node *llnode, *t;
> @@ -207,12 +251,13 @@ static void free_bulk(struct bpf_mem_cache *c)
>                 local_dec(&c->active);
>                 if (IS_ENABLED(CONFIG_PREEMPT_RT))
>                         local_irq_restore(flags);
> -               free_one(c, llnode);
> +               enque_to_free(c, llnode);
>         } while (cnt > (c->high_watermark + c->low_watermark) / 2);
>
>         /* and drain free_llist_extra */
>         llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra))
> -               free_one(c, llnode);
> +               enque_to_free(c, llnode);
> +       do_call_rcu(c);
>  }
>
>  static void bpf_mem_refill(struct irq_work *work)
> @@ -298,7 +343,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size)
>                         return -ENOMEM;
>                 size += LLIST_NODE_SZ; /* room for llist_node */
>                 snprintf(buf, sizeof(buf), "bpf-%u", size);
> -               kmem_cache = kmem_cache_create(buf, size, 8, SLAB_TYPESAFE_BY_RCU, NULL);
> +               kmem_cache = kmem_cache_create(buf, size, 8, 0, NULL);
>                 if (!kmem_cache) {
>                         free_percpu(pc);
>                         return -ENOMEM;
> @@ -340,6 +385,15 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
>  {
>         struct llist_node *llnode, *t;
>
> +       /* The caller has done rcu_barrier() and no progs are using this
> +        * bpf_mem_cache, but htab_map_free() called bpf_mem_cache_free() for
> +        * all remaining elements and they can be in free_by_rcu or in
> +        * waiting_for_gp lists, so drain those lists now.
> +        */
> +       llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu))
> +               free_one(c, llnode);
> +       llist_for_each_safe(llnode, t, llist_del_all(&c->waiting_for_gp))
> +               free_one(c, llnode);
>         llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist))
>                 free_one(c, llnode);
>         llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra))
> @@ -361,6 +415,10 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
>                 kmem_cache_destroy(c->kmem_cache);
>                 if (c->objcg)
>                         obj_cgroup_put(c->objcg);
> +               /* c->waiting_for_gp list was drained, but __free_rcu might
> +                * still execute. Wait for it now before we free 'c'.
> +                */
> +               rcu_barrier();
>                 free_percpu(ma->cache);
>                 ma->cache = NULL;
>         }
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a4d40d98428a..850270a72350 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -638,7 +638,10 @@ static void __bpf_map_put(struct bpf_map *map, bool do_idr_lock)
>                 bpf_map_free_id(map, do_idr_lock);
>                 btf_put(map->btf);
>                 INIT_WORK(&map->work, bpf_map_free_deferred);
> -               schedule_work(&map->work);
> +               /* Avoid spawning kworkers, since they all might contend
> +                * for the same mutex like slab_mutex.
> +                */
> +               queue_work(system_unbound_wq, &map->work);
>         }
>  }
>
> --
> 2.30.2
>
