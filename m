Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56354D928F
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 03:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240957AbiCOC2M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Mar 2022 22:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbiCOC2L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Mar 2022 22:28:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8140846B2D
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 19:27:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF9F760F50
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 02:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B84C340EC
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 02:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647311219;
        bh=cmyePwMh9YC1+cvjeFuS8/lOk1jQ2Rz6FH1MU7+Bx6I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s4vLCU//HHbS5O8kw+vwZBUxMHa4wJKo8bamD2GbYo9EO94tF+Hvmw0F3ErtUTOa7
         L4JFB4XNzYPSz7YyrRF9mT2egUNTXQxv6DOydx6AFmluS6QqfvBDjugdH34aFKNyMr
         nfcIHvhd6YlnI0S51tx7gROBIWj7KJRziIcJphB9Zi/eiguNzb2JVP/S6D9bAVEB29
         0nFxr5edzq8GQeso1BmzU+t1v6Lxc4vSz2jDwFSiY58CCSkJKk4pht2Wj67Ic6nPhA
         81cOGTX6QV/0e861Mqtm7cZeNzScW16MF/YQNLC06GQeKLICUAgi1c1LmEUkxIoH+W
         Lr3GXB23sLHtg==
Received: by mail-ej1-f44.google.com with SMTP id kt27so38286202ejb.0
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 19:26:59 -0700 (PDT)
X-Gm-Message-State: AOAM533iuoDsyYWslrvpiquZcFbdVbgHfAfE1aIyhfOadgXSR/nnWvcx
        MAJn4zAcyyP+phMn+J3VG2ncpd53HdwqHk1/0m2KZg==
X-Google-Smtp-Source: ABdhPJxsTbi3ZiPKPJuk38tvpoBNfpMY0hO+nAPLcTGQjRTdxBHAr38lj/QiUc9MxSxHgz+N6irHFvvvtaRyA9AheSw=
X-Received: by 2002:a17:907:3f9e:b0:6da:842e:873e with SMTP id
 hr30-20020a1709073f9e00b006da842e873emr21009959ejc.383.1647311217317; Mon, 14
 Mar 2022 19:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220312011643.2136370-1-joannekoong@fb.com>
In-Reply-To: <20220312011643.2136370-1-joannekoong@fb.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 15 Mar 2022 03:26:46 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6TWGOWk5UTh6juuEO2xYheu7MEh-m=R8h20sCG5sV71g@mail.gmail.com>
Message-ID: <CACYkzJ6TWGOWk5UTh6juuEO2xYheu7MEh-m=R8h20sCG5sV71g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Enable non-atomic allocations in local storage
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, tj@kernel.org,
        davemarchevsky@fb.com, Joanne Koong <joannelkoong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 12, 2022 at 2:17 AM Joanne Koong <joannekoong@fb.com> wrote:
>
> From: Joanne Koong <joannelkoong@gmail.com>
>
> Currently, local storage memory can only be allocated atomically
> (GFP_ATOMIC). This restriction is too strict for sleepable bpf
> programs.
>
> In this patch, the verifier detects whether the program is sleepable,
> and passes the corresponding GFP_KERNEL or GFP_ATOMIC flag as a
> 5th argument to bpf_task/sk/inode_storage_get. This flag will propagate
> down to the local storage functions that allocate memory.
>
> A few things to note:
> * bpf_task/sk/inode_storage_update_elem functions are invoked by
> userspace applications through syscalls. Preemption is disabled before
> bpf_task/sk/inode_storage_update_elem is called, which means they will
> always have to allocate memory atomically.
>
> * In bpf_local_storage_update, we have to do the memory charging and
> allocation outside the spinlock. There are some cases where it is
> permissible for the memory charging and/or allocation to fail, so in
> these failure cases, we continue on to determine at a later time whether
> the failure is relevant.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/bpf_local_storage.h |  7 +--
>  kernel/bpf/bpf_inode_storage.c    |  9 ++--
>  kernel/bpf/bpf_local_storage.c    | 77 +++++++++++++++++++++----------
>  kernel/bpf/bpf_task_storage.c     | 10 ++--
>  kernel/bpf/verifier.c             | 20 ++++++++
>  net/core/bpf_sk_storage.c         | 21 +++++----
>  6 files changed, 99 insertions(+), 45 deletions(-)
>
> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> index 37b3906af8b1..d6905e85399d 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -154,16 +154,17 @@ void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem);
>
>  struct bpf_local_storage_elem *
>  bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
> -               bool charge_mem);
> +               gfp_t mem_flags);
>
>  int
>  bpf_local_storage_alloc(void *owner,
>                         struct bpf_local_storage_map *smap,
> -                       struct bpf_local_storage_elem *first_selem);
> +                       struct bpf_local_storage_elem *first_selem,
> +                       gfp_t mem_flags);
>
>  struct bpf_local_storage_data *
>  bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> -                        void *value, u64 map_flags);
> +                        void *value, u64 map_flags, gfp_t mem_flags);
>
>  void bpf_local_storage_free_rcu(struct rcu_head *rcu);
>
> diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
> index e29d9e3d853e..41b0bec1e7e9 100644
> --- a/kernel/bpf/bpf_inode_storage.c
> +++ b/kernel/bpf/bpf_inode_storage.c
> @@ -136,7 +136,7 @@ static int bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
>
>         sdata = bpf_local_storage_update(f->f_inode,
>                                          (struct bpf_local_storage_map *)map,
> -                                        value, map_flags);
> +                                        value, map_flags, GFP_ATOMIC);
>         fput(f);
>         return PTR_ERR_OR_ZERO(sdata);
>  }
> @@ -169,8 +169,9 @@ static int bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
>         return err;
>  }
>
> -BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
> -          void *, value, u64, flags)
> +/* *mem_flags* is set by the bpf verifier */
> +BPF_CALL_5(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
> +          void *, value, u64, flags, gfp_t, mem_flags)
>  {
>         struct bpf_local_storage_data *sdata;
>
> @@ -196,7 +197,7 @@ BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
>         if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
>                 sdata = bpf_local_storage_update(
>                         inode, (struct bpf_local_storage_map *)map, value,
> -                       BPF_NOEXIST);
> +                       BPF_NOEXIST, mem_flags);
>                 return IS_ERR(sdata) ? (unsigned long)NULL :
>                                              (unsigned long)sdata->data;
>         }
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 092a1ac772d7..ca402f9cf1a5 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -63,23 +63,22 @@ static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
>
>  struct bpf_local_storage_elem *
>  bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
> -               void *value, bool charge_mem)
> +               void *value, gfp_t mem_flags)
>  {
>         struct bpf_local_storage_elem *selem;
>
> -       if (charge_mem && mem_charge(smap, owner, smap->elem_size))
> +       if (mem_charge(smap, owner, smap->elem_size))
>                 return NULL;
>
>         selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
> -                               GFP_ATOMIC | __GFP_NOWARN);
> +                               mem_flags | __GFP_NOWARN);
>         if (selem) {
>                 if (value)
>                         memcpy(SDATA(selem)->data, value, smap->map.value_size);
>                 return selem;
>         }
>
> -       if (charge_mem)
> -               mem_uncharge(smap, owner, smap->elem_size);
> +       mem_uncharge(smap, owner, smap->elem_size);
>
>         return NULL;
>  }
> @@ -282,7 +281,8 @@ static int check_flags(const struct bpf_local_storage_data *old_sdata,
>
>  int bpf_local_storage_alloc(void *owner,
>                             struct bpf_local_storage_map *smap,
> -                           struct bpf_local_storage_elem *first_selem)
> +                           struct bpf_local_storage_elem *first_selem,
> +                           gfp_t mem_flags)
>  {
>         struct bpf_local_storage *prev_storage, *storage;
>         struct bpf_local_storage **owner_storage_ptr;
> @@ -293,7 +293,7 @@ int bpf_local_storage_alloc(void *owner,
>                 return err;
>
>         storage = bpf_map_kzalloc(&smap->map, sizeof(*storage),
> -                                 GFP_ATOMIC | __GFP_NOWARN);
> +                                 mem_flags | __GFP_NOWARN);
>         if (!storage) {
>                 err = -ENOMEM;
>                 goto uncharge;
> @@ -350,13 +350,13 @@ int bpf_local_storage_alloc(void *owner,
>   */
>  struct bpf_local_storage_data *
>  bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> -                        void *value, u64 map_flags)
> +                        void *value, u64 map_flags, gfp_t mem_flags)
>  {
>         struct bpf_local_storage_data *old_sdata = NULL;
>         struct bpf_local_storage_elem *selem;
>         struct bpf_local_storage *local_storage;
>         unsigned long flags;
> -       int err;
> +       int err, charge_err;
>
>         /* BPF_EXIST and BPF_NOEXIST cannot be both set */
>         if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
> @@ -373,11 +373,11 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>                 if (err)
>                         return ERR_PTR(err);
>
> -               selem = bpf_selem_alloc(smap, owner, value, true);
> +               selem = bpf_selem_alloc(smap, owner, value, mem_flags);
>                 if (!selem)
>                         return ERR_PTR(-ENOMEM);
>
> -               err = bpf_local_storage_alloc(owner, smap, selem);
> +               err = bpf_local_storage_alloc(owner, smap, selem, mem_flags);
>                 if (err) {
>                         kfree(selem);
>                         mem_uncharge(smap, owner, smap->elem_size);
> @@ -404,6 +404,19 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>                 }
>         }
>
> +       /* Since mem_flags can be non-atomic, we need to do the memory
> +        * allocation outside the spinlock.
> +        *
> +        * There are a few cases where it is permissible for the memory charge
> +        * and allocation to fail (eg if BPF_F_LOCK is set and a local storage
> +        * value already exists, we can swap values without needing an
> +        * allocation), so in the case of a failure here, continue on and see
> +        * if the failure is relevant.
> +        */
> +       charge_err = mem_charge(smap, owner, smap->elem_size);
> +       selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
> +                               mem_flags | __GFP_NOWARN);
> +
>         raw_spin_lock_irqsave(&local_storage->lock, flags);
>
>         /* Recheck local_storage->list under local_storage->lock */
> @@ -425,25 +438,37 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>         if (old_sdata && (map_flags & BPF_F_LOCK)) {
>                 copy_map_value_locked(&smap->map, old_sdata->data, value,
>                                       false);
> -               selem = SELEM(old_sdata);
> -               goto unlock;
> +
> +               raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> +
> +               if (!charge_err)
> +                       mem_uncharge(smap, owner, smap->elem_size);
> +               kfree(selem);
> +
> +               return old_sdata;
> +       }
> +
> +       if (!old_sdata && charge_err) {
> +               /* If there is no existing local storage value, then this means
> +                * we needed the charge to succeed. We must make sure this did not
> +                * return an error.
> +                *
> +                * Please note that if an existing local storage value exists, then
> +                * it doesn't matter if the charge failed because we can just
> +                * "reuse" the charge from the existing local storage element.
> +                */

But we did allocate a new element which was unaccounted for, even if
it was temporarily.
[for the short period of time till we freed the old element]

Martin, is this something we are okay with?

> +               err = charge_err;
> +               goto unlock_err;
>         }
>
> -       /* local_storage->lock is held.  Hence, we are sure
> -        * we can unlink and uncharge the old_sdata successfully
> -        * later.  Hence, instead of charging the new selem now
> -        * and then uncharge the old selem later (which may cause
> -        * a potential but unnecessary charge failure),  avoid taking
> -        * a charge at all here (the "!old_sdata" check) and the
> -        * old_sdata will not be uncharged later during
> -        * bpf_selem_unlink_storage_nolock().
> -        */
> -       selem = bpf_selem_alloc(smap, owner, value, !old_sdata);
>         if (!selem) {
>                 err = -ENOMEM;
>                 goto unlock_err;
>         }
>
> +       if (value)
> +               memcpy(SDATA(selem)->data, value, smap->map.value_size);
> +
>         /* First, link the new selem to the map */
>         bpf_selem_link_map(smap, selem);
>
> @@ -454,15 +479,17 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>         if (old_sdata) {
>                 bpf_selem_unlink_map(SELEM(old_sdata));
>                 bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
> -                                               false);
> +                                               !charge_err);
>         }
>
> -unlock:
>         raw_spin_unlock_irqrestore(&local_storage->lock, flags);
>         return SDATA(selem);
>
>  unlock_err:
>         raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> +       if (!charge_err)
> +               mem_uncharge(smap, owner, smap->elem_size);
> +       kfree(selem);
>         return ERR_PTR(err);
>  }
>
> diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
> index 5da7bed0f5f6..bb9e22bad42b 100644
> --- a/kernel/bpf/bpf_task_storage.c
> +++ b/kernel/bpf/bpf_task_storage.c
> @@ -174,7 +174,8 @@ static int bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
>
>         bpf_task_storage_lock();
>         sdata = bpf_local_storage_update(
> -               task, (struct bpf_local_storage_map *)map, value, map_flags);
> +               task, (struct bpf_local_storage_map *)map, value, map_flags,
> +               GFP_ATOMIC);
>         bpf_task_storage_unlock();
>
>         err = PTR_ERR_OR_ZERO(sdata);
> @@ -226,8 +227,9 @@ static int bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
>         return err;
>  }
>
> -BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
> -          task, void *, value, u64, flags)
> +/* *mem_flags* is set by the bpf verifier */

Is there a precedence of this happening for any other helpers?

You may want to add here that "any value, even if set by uapi, will be ignored"

Can we go even beyond this and ensure that the verifier understands
that this is an
"internal only arg" something in check_helper_call?

> +BPF_CALL_5(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
> +          task, void *, value, u64, flags, gfp_t, mem_flags)
>  {
>         struct bpf_local_storage_data *sdata;
>
> @@ -250,7 +252,7 @@ BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
>             (flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
>                 sdata = bpf_local_storage_update(
>                         task, (struct bpf_local_storage_map *)map, value,
> -                       BPF_NOEXIST);
> +                       BPF_NOEXIST, mem_flags);
>
>  unlock:
>         bpf_task_storage_unlock();
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0db6cd8dcb35..392fdaabedbd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13491,6 +13491,26 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>                         goto patch_call_imm;
>                 }
>
> +               if (insn->imm == BPF_FUNC_task_storage_get ||
> +                   insn->imm == BPF_FUNC_sk_storage_get ||
> +                   insn->imm == BPF_FUNC_inode_storage_get) {
> +                       if (env->prog->aux->sleepable)
> +                               insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, GFP_KERNEL);
> +                       else
> +                               insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, GFP_ATOMIC);
> +                       insn_buf[1] = *insn;
> +                       cnt = 2;
> +
> +                       new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> +                       if (!new_prog)
> +                               return -ENOMEM;
> +
> +                       delta += cnt - 1;
> +                       env->prog = prog = new_prog;
> +                       insn = new_prog->insnsi + i + delta;
> +                       goto patch_call_imm;
> +               }
> +
>                 /* BPF_EMIT_CALL() assumptions in some of the map_gen_lookup
>                  * and other inlining handlers are currently limited to 64 bit
>                  * only.
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index d9c37fd10809..8790a3791d39 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -141,7 +141,7 @@ static int bpf_fd_sk_storage_update_elem(struct bpf_map *map, void *key,
>         if (sock) {
>                 sdata = bpf_local_storage_update(
>                         sock->sk, (struct bpf_local_storage_map *)map, value,
> -                       map_flags);
> +                       map_flags, GFP_ATOMIC);
>                 sockfd_put(sock);
>                 return PTR_ERR_OR_ZERO(sdata);
>         }
> @@ -172,7 +172,7 @@ bpf_sk_storage_clone_elem(struct sock *newsk,
>  {
>         struct bpf_local_storage_elem *copy_selem;
>
> -       copy_selem = bpf_selem_alloc(smap, newsk, NULL, true);
> +       copy_selem = bpf_selem_alloc(smap, newsk, NULL, GFP_ATOMIC);
>         if (!copy_selem)
>                 return NULL;
>
> @@ -230,7 +230,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
>                         bpf_selem_link_map(smap, copy_selem);
>                         bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);
>                 } else {
> -                       ret = bpf_local_storage_alloc(newsk, smap, copy_selem);
> +                       ret = bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);
>                         if (ret) {
>                                 kfree(copy_selem);
>                                 atomic_sub(smap->elem_size,
> @@ -255,8 +255,9 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
>         return ret;
>  }
>
> -BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
> -          void *, value, u64, flags)
> +/* *mem_flags* is set by the bpf verifier */
> +BPF_CALL_5(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
> +          void *, value, u64, flags, gfp_t, mem_flags)
>  {
>         struct bpf_local_storage_data *sdata;
>
> @@ -277,7 +278,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
>             refcount_inc_not_zero(&sk->sk_refcnt)) {
>                 sdata = bpf_local_storage_update(
>                         sk, (struct bpf_local_storage_map *)map, value,
> -                       BPF_NOEXIST);
> +                       BPF_NOEXIST, mem_flags);
>                 /* sk must be a fullsock (guaranteed by verifier),
>                  * so sock_gen_put() is unnecessary.
>                  */
> @@ -417,14 +418,16 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
>         return false;
>  }
>
> -BPF_CALL_4(bpf_sk_storage_get_tracing, struct bpf_map *, map, struct sock *, sk,
> -          void *, value, u64, flags)
> +/* *mem_flags* is set by the bpf verifier */
> +BPF_CALL_5(bpf_sk_storage_get_tracing, struct bpf_map *, map, struct sock *, sk,
> +          void *, value, u64, flags, gfp_t, mem_flags)
>  {
>         WARN_ON_ONCE(!bpf_rcu_lock_held());
>         if (in_hardirq() || in_nmi())
>                 return (unsigned long)NULL;
>
> -       return (unsigned long)____bpf_sk_storage_get(map, sk, value, flags);
> +       return (unsigned long)____bpf_sk_storage_get(map, sk, value, flags,
> +                                                    mem_flags);
>  }
>
>  BPF_CALL_2(bpf_sk_storage_delete_tracing, struct bpf_map *, map,
> --
> 2.30.2
>
