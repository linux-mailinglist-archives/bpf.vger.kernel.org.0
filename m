Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94284DA06A
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 17:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350179AbiCOQuo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 12:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbiCOQum (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 12:50:42 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AAF50E33
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 09:49:30 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b8so18365381pjb.4
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 09:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lEmcnk2bRnzVYKLy4ND8LlQLqDZKeOM5FuW36l0r0v8=;
        b=ivrRVVrOt/vag8K3heEvpg536T4yP2YH93SixmUdWM5eH+A5CAiqWqHs7G0DdACHhr
         Vsg6JT5BqBIVh8xwC2y3MvuHcPDxs70P8c1xoXl6tq0wfP44tiJS9zRWt47Extem+W+j
         ecVDu4v991LglrNBgtlMaR95QSMItTLh55sI7YUqwdqrc5YN26CWl1cy29RHES7Ldpfz
         9MLO68BbeMJfAaA7dvY06cUgijRw6uTfXTXYOHZUFJ/rxGFIEt9mAZsmbzs7oEsJwiS/
         2kEPkgiNbDEeRRvwhYYns9le6+DuXQFLxVII/4KShnn1k17e7tAGCJ33QbiPKCus7Rfy
         aVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lEmcnk2bRnzVYKLy4ND8LlQLqDZKeOM5FuW36l0r0v8=;
        b=AlWaxvrA+36o/hqpSwz8nIVa9IullfIMMrs4Pc8vpgDCLoMORl9bZ3Z+srtC4qay7Q
         teOiTrHB8s9Zkw12FU6vvhalXvI7GKog933t2TeVPzRxjpi9MZ5tsfTaBd8qI1spXr9k
         lJ7SHqAaPKOdWETaRDCIgilPWScYZF8O+ENlhE/JoOUxa2aH7bLJT3llX5oguab92vYQ
         VmZ5Y5Zs78RjOjTQFuIjuuHymSBVcxhluWhcMALNzfOmrLW05fZjNcuH3PQO6pBuf+S6
         FgzRdlKYNjSmw0TEASRXHHfEsa8d4H//gf4u3r/0YhYfMVt1d7zOC/n4Eubhf5E1P4kr
         1wnQ==
X-Gm-Message-State: AOAM5322pksERbLS806HKM2iEGxpzGBF6hr3ln/nvVTSqXxJ9HKh6gyk
        uzXtWZvPJkHq7Vb8q1j1tYU=
X-Google-Smtp-Source: ABdhPJyc24b6H+B+OvQncffre/dIDUXFMYz3+OYq7NDWhlEDyCNAwXUD3B7HL7wl9kAd2vIZCvCcLw==
X-Received: by 2002:a17:902:e949:b0:14b:1f32:e926 with SMTP id b9-20020a170902e94900b0014b1f32e926mr29285857pll.170.1647362969439;
        Tue, 15 Mar 2022 09:49:29 -0700 (PDT)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id z16-20020a056a00241000b004f3a647ae89sm24717483pfh.174.2022.03.15.09.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 09:49:29 -0700 (PDT)
Date:   Tue, 15 Mar 2022 22:19:16 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     KP Singh <kpsingh@kernel.org>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, tj@kernel.org, davemarchevsky@fb.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Enable non-atomic allocations in local
 storage
Message-ID: <20220315164916.jlqjxcgetxuhur7i@apollo>
References: <20220312011643.2136370-1-joannekoong@fb.com>
 <CACYkzJ6TWGOWk5UTh6juuEO2xYheu7MEh-m=R8h20sCG5sV71g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACYkzJ6TWGOWk5UTh6juuEO2xYheu7MEh-m=R8h20sCG5sV71g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 15, 2022 at 07:56:46AM IST, KP Singh wrote:
> On Sat, Mar 12, 2022 at 2:17 AM Joanne Koong <joannekoong@fb.com> wrote:
> >
> > From: Joanne Koong <joannelkoong@gmail.com>
> >
> > Currently, local storage memory can only be allocated atomically
> > (GFP_ATOMIC). This restriction is too strict for sleepable bpf
> > programs.
> >
> > In this patch, the verifier detects whether the program is sleepable,
> > and passes the corresponding GFP_KERNEL or GFP_ATOMIC flag as a
> > 5th argument to bpf_task/sk/inode_storage_get. This flag will propagate
> > down to the local storage functions that allocate memory.
> >
> > A few things to note:
> > * bpf_task/sk/inode_storage_update_elem functions are invoked by
> > userspace applications through syscalls. Preemption is disabled before
> > bpf_task/sk/inode_storage_update_elem is called, which means they will
> > always have to allocate memory atomically.
> >
> > * In bpf_local_storage_update, we have to do the memory charging and
> > allocation outside the spinlock. There are some cases where it is
> > permissible for the memory charging and/or allocation to fail, so in
> > these failure cases, we continue on to determine at a later time whether
> > the failure is relevant.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/bpf_local_storage.h |  7 +--
> >  kernel/bpf/bpf_inode_storage.c    |  9 ++--
> >  kernel/bpf/bpf_local_storage.c    | 77 +++++++++++++++++++++----------
> >  kernel/bpf/bpf_task_storage.c     | 10 ++--
> >  kernel/bpf/verifier.c             | 20 ++++++++
> >  net/core/bpf_sk_storage.c         | 21 +++++----
> >  6 files changed, 99 insertions(+), 45 deletions(-)
> >
> > diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> > index 37b3906af8b1..d6905e85399d 100644
> > --- a/include/linux/bpf_local_storage.h
> > +++ b/include/linux/bpf_local_storage.h
> > @@ -154,16 +154,17 @@ void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem);
> >
> >  struct bpf_local_storage_elem *
> >  bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
> > -               bool charge_mem);
> > +               gfp_t mem_flags);
> >
> >  int
> >  bpf_local_storage_alloc(void *owner,
> >                         struct bpf_local_storage_map *smap,
> > -                       struct bpf_local_storage_elem *first_selem);
> > +                       struct bpf_local_storage_elem *first_selem,
> > +                       gfp_t mem_flags);
> >
> >  struct bpf_local_storage_data *
> >  bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > -                        void *value, u64 map_flags);
> > +                        void *value, u64 map_flags, gfp_t mem_flags);
> >
> >  void bpf_local_storage_free_rcu(struct rcu_head *rcu);
> >
> > diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
> > index e29d9e3d853e..41b0bec1e7e9 100644
> > --- a/kernel/bpf/bpf_inode_storage.c
> > +++ b/kernel/bpf/bpf_inode_storage.c
> > @@ -136,7 +136,7 @@ static int bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
> >
> >         sdata = bpf_local_storage_update(f->f_inode,
> >                                          (struct bpf_local_storage_map *)map,
> > -                                        value, map_flags);
> > +                                        value, map_flags, GFP_ATOMIC);
> >         fput(f);
> >         return PTR_ERR_OR_ZERO(sdata);
> >  }
> > @@ -169,8 +169,9 @@ static int bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
> >         return err;
> >  }
> >
> > -BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
> > -          void *, value, u64, flags)
> > +/* *mem_flags* is set by the bpf verifier */
> > +BPF_CALL_5(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
> > +          void *, value, u64, flags, gfp_t, mem_flags)
> >  {
> >         struct bpf_local_storage_data *sdata;
> >
> > @@ -196,7 +197,7 @@ BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
> >         if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
> >                 sdata = bpf_local_storage_update(
> >                         inode, (struct bpf_local_storage_map *)map, value,
> > -                       BPF_NOEXIST);
> > +                       BPF_NOEXIST, mem_flags);
> >                 return IS_ERR(sdata) ? (unsigned long)NULL :
> >                                              (unsigned long)sdata->data;
> >         }
> > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> > index 092a1ac772d7..ca402f9cf1a5 100644
> > --- a/kernel/bpf/bpf_local_storage.c
> > +++ b/kernel/bpf/bpf_local_storage.c
> > @@ -63,23 +63,22 @@ static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
> >
> >  struct bpf_local_storage_elem *
> >  bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
> > -               void *value, bool charge_mem)
> > +               void *value, gfp_t mem_flags)
> >  {
> >         struct bpf_local_storage_elem *selem;
> >
> > -       if (charge_mem && mem_charge(smap, owner, smap->elem_size))
> > +       if (mem_charge(smap, owner, smap->elem_size))
> >                 return NULL;
> >
> >         selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
> > -                               GFP_ATOMIC | __GFP_NOWARN);
> > +                               mem_flags | __GFP_NOWARN);
> >         if (selem) {
> >                 if (value)
> >                         memcpy(SDATA(selem)->data, value, smap->map.value_size);
> >                 return selem;
> >         }
> >
> > -       if (charge_mem)
> > -               mem_uncharge(smap, owner, smap->elem_size);
> > +       mem_uncharge(smap, owner, smap->elem_size);
> >
> >         return NULL;
> >  }
> > @@ -282,7 +281,8 @@ static int check_flags(const struct bpf_local_storage_data *old_sdata,
> >
> >  int bpf_local_storage_alloc(void *owner,
> >                             struct bpf_local_storage_map *smap,
> > -                           struct bpf_local_storage_elem *first_selem)
> > +                           struct bpf_local_storage_elem *first_selem,
> > +                           gfp_t mem_flags)
> >  {
> >         struct bpf_local_storage *prev_storage, *storage;
> >         struct bpf_local_storage **owner_storage_ptr;
> > @@ -293,7 +293,7 @@ int bpf_local_storage_alloc(void *owner,
> >                 return err;
> >
> >         storage = bpf_map_kzalloc(&smap->map, sizeof(*storage),
> > -                                 GFP_ATOMIC | __GFP_NOWARN);
> > +                                 mem_flags | __GFP_NOWARN);
> >         if (!storage) {
> >                 err = -ENOMEM;
> >                 goto uncharge;
> > @@ -350,13 +350,13 @@ int bpf_local_storage_alloc(void *owner,
> >   */
> >  struct bpf_local_storage_data *
> >  bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > -                        void *value, u64 map_flags)
> > +                        void *value, u64 map_flags, gfp_t mem_flags)
> >  {
> >         struct bpf_local_storage_data *old_sdata = NULL;
> >         struct bpf_local_storage_elem *selem;
> >         struct bpf_local_storage *local_storage;
> >         unsigned long flags;
> > -       int err;
> > +       int err, charge_err;
> >
> >         /* BPF_EXIST and BPF_NOEXIST cannot be both set */
> >         if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
> > @@ -373,11 +373,11 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> >                 if (err)
> >                         return ERR_PTR(err);
> >
> > -               selem = bpf_selem_alloc(smap, owner, value, true);
> > +               selem = bpf_selem_alloc(smap, owner, value, mem_flags);
> >                 if (!selem)
> >                         return ERR_PTR(-ENOMEM);
> >
> > -               err = bpf_local_storage_alloc(owner, smap, selem);
> > +               err = bpf_local_storage_alloc(owner, smap, selem, mem_flags);
> >                 if (err) {
> >                         kfree(selem);
> >                         mem_uncharge(smap, owner, smap->elem_size);
> > @@ -404,6 +404,19 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> >                 }
> >         }
> >
> > +       /* Since mem_flags can be non-atomic, we need to do the memory
> > +        * allocation outside the spinlock.
> > +        *
> > +        * There are a few cases where it is permissible for the memory charge
> > +        * and allocation to fail (eg if BPF_F_LOCK is set and a local storage
> > +        * value already exists, we can swap values without needing an
> > +        * allocation), so in the case of a failure here, continue on and see
> > +        * if the failure is relevant.
> > +        */
> > +       charge_err = mem_charge(smap, owner, smap->elem_size);
> > +       selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
> > +                               mem_flags | __GFP_NOWARN);
> > +
> >         raw_spin_lock_irqsave(&local_storage->lock, flags);
> >
> >         /* Recheck local_storage->list under local_storage->lock */
> > @@ -425,25 +438,37 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> >         if (old_sdata && (map_flags & BPF_F_LOCK)) {
> >                 copy_map_value_locked(&smap->map, old_sdata->data, value,
> >                                       false);
> > -               selem = SELEM(old_sdata);
> > -               goto unlock;
> > +
> > +               raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > +
> > +               if (!charge_err)
> > +                       mem_uncharge(smap, owner, smap->elem_size);
> > +               kfree(selem);
> > +
> > +               return old_sdata;
> > +       }
> > +
> > +       if (!old_sdata && charge_err) {
> > +               /* If there is no existing local storage value, then this means
> > +                * we needed the charge to succeed. We must make sure this did not
> > +                * return an error.
> > +                *
> > +                * Please note that if an existing local storage value exists, then
> > +                * it doesn't matter if the charge failed because we can just
> > +                * "reuse" the charge from the existing local storage element.
> > +                */
>
> But we did allocate a new element which was unaccounted for, even if
> it was temporarily.
> [for the short period of time till we freed the old element]
>
> Martin, is this something we are okay with?
>
> > +               err = charge_err;
> > +               goto unlock_err;
> >         }
> >
> > -       /* local_storage->lock is held.  Hence, we are sure
> > -        * we can unlink and uncharge the old_sdata successfully
> > -        * later.  Hence, instead of charging the new selem now
> > -        * and then uncharge the old selem later (which may cause
> > -        * a potential but unnecessary charge failure),  avoid taking
> > -        * a charge at all here (the "!old_sdata" check) and the
> > -        * old_sdata will not be uncharged later during
> > -        * bpf_selem_unlink_storage_nolock().
> > -        */
> > -       selem = bpf_selem_alloc(smap, owner, value, !old_sdata);
> >         if (!selem) {
> >                 err = -ENOMEM;
> >                 goto unlock_err;
> >         }
> >
> > +       if (value)
> > +               memcpy(SDATA(selem)->data, value, smap->map.value_size);
> > +
> >         /* First, link the new selem to the map */
> >         bpf_selem_link_map(smap, selem);
> >
> > @@ -454,15 +479,17 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> >         if (old_sdata) {
> >                 bpf_selem_unlink_map(SELEM(old_sdata));
> >                 bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
> > -                                               false);
> > +                                               !charge_err);
> >         }
> >
> > -unlock:
> >         raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> >         return SDATA(selem);
> >
> >  unlock_err:
> >         raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > +       if (!charge_err)
> > +               mem_uncharge(smap, owner, smap->elem_size);
> > +       kfree(selem);
> >         return ERR_PTR(err);
> >  }
> >
> > diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
> > index 5da7bed0f5f6..bb9e22bad42b 100644
> > --- a/kernel/bpf/bpf_task_storage.c
> > +++ b/kernel/bpf/bpf_task_storage.c
> > @@ -174,7 +174,8 @@ static int bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
> >
> >         bpf_task_storage_lock();
> >         sdata = bpf_local_storage_update(
> > -               task, (struct bpf_local_storage_map *)map, value, map_flags);
> > +               task, (struct bpf_local_storage_map *)map, value, map_flags,
> > +               GFP_ATOMIC);
> >         bpf_task_storage_unlock();
> >
> >         err = PTR_ERR_OR_ZERO(sdata);
> > @@ -226,8 +227,9 @@ static int bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
> >         return err;
> >  }
> >
> > -BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
> > -          task, void *, value, u64, flags)
> > +/* *mem_flags* is set by the bpf verifier */
>
> Is there a precedence of this happening for any other helpers?
>

Yes, e.g. bpf_timer_set_callback receives hidden prog->aux.

> You may want to add here that "any value, even if set by uapi, will be ignored"
>
> Can we go even beyond this and ensure that the verifier understands
> that this is an
> "internal only arg" something in check_helper_call?
>

Since bpf_func_proto was not changed, arg5_type is still ARG_DONTCARE, so
verifier should already ignore register type for R5, and anyway user cannot
assume it remains same across call (since it is caller-saved), so I think this
is fine.

> > +BPF_CALL_5(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
> > +          task, void *, value, u64, flags, gfp_t, mem_flags)
> >  {
> >         struct bpf_local_storage_data *sdata;
> >
> > @@ -250,7 +252,7 @@ BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
> >             (flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
> >                 sdata = bpf_local_storage_update(
> >                         task, (struct bpf_local_storage_map *)map, value,
> > -                       BPF_NOEXIST);
> > +                       BPF_NOEXIST, mem_flags);
> >
> >  unlock:
> >         bpf_task_storage_unlock();
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0db6cd8dcb35..392fdaabedbd 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -13491,6 +13491,26 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> >                         goto patch_call_imm;
> >                 }
> >
> > +               if (insn->imm == BPF_FUNC_task_storage_get ||
> > +                   insn->imm == BPF_FUNC_sk_storage_get ||
> > +                   insn->imm == BPF_FUNC_inode_storage_get) {
> > +                       if (env->prog->aux->sleepable)
> > +                               insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, GFP_KERNEL);
> > +                       else
> > +                               insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, GFP_ATOMIC);
> > +                       insn_buf[1] = *insn;
> > +                       cnt = 2;
> > +
> > +                       new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> > +                       if (!new_prog)
> > +                               return -ENOMEM;
> > +
> > +                       delta += cnt - 1;
> > +                       env->prog = prog = new_prog;
> > +                       insn = new_prog->insnsi + i + delta;
> > +                       goto patch_call_imm;
> > +               }
> > +
> >                 /* BPF_EMIT_CALL() assumptions in some of the map_gen_lookup
> >                  * and other inlining handlers are currently limited to 64 bit
> >                  * only.
> > diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> > index d9c37fd10809..8790a3791d39 100644
> > --- a/net/core/bpf_sk_storage.c
> > +++ b/net/core/bpf_sk_storage.c
> > @@ -141,7 +141,7 @@ static int bpf_fd_sk_storage_update_elem(struct bpf_map *map, void *key,
> >         if (sock) {
> >                 sdata = bpf_local_storage_update(
> >                         sock->sk, (struct bpf_local_storage_map *)map, value,
> > -                       map_flags);
> > +                       map_flags, GFP_ATOMIC);
> >                 sockfd_put(sock);
> >                 return PTR_ERR_OR_ZERO(sdata);
> >         }
> > @@ -172,7 +172,7 @@ bpf_sk_storage_clone_elem(struct sock *newsk,
> >  {
> >         struct bpf_local_storage_elem *copy_selem;
> >
> > -       copy_selem = bpf_selem_alloc(smap, newsk, NULL, true);
> > +       copy_selem = bpf_selem_alloc(smap, newsk, NULL, GFP_ATOMIC);
> >         if (!copy_selem)
> >                 return NULL;
> >
> > @@ -230,7 +230,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
> >                         bpf_selem_link_map(smap, copy_selem);
> >                         bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);
> >                 } else {
> > -                       ret = bpf_local_storage_alloc(newsk, smap, copy_selem);
> > +                       ret = bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);
> >                         if (ret) {
> >                                 kfree(copy_selem);
> >                                 atomic_sub(smap->elem_size,
> > @@ -255,8 +255,9 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
> >         return ret;
> >  }
> >
> > -BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
> > -          void *, value, u64, flags)
> > +/* *mem_flags* is set by the bpf verifier */
> > +BPF_CALL_5(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
> > +          void *, value, u64, flags, gfp_t, mem_flags)
> >  {
> >         struct bpf_local_storage_data *sdata;
> >
> > @@ -277,7 +278,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
> >             refcount_inc_not_zero(&sk->sk_refcnt)) {
> >                 sdata = bpf_local_storage_update(
> >                         sk, (struct bpf_local_storage_map *)map, value,
> > -                       BPF_NOEXIST);
> > +                       BPF_NOEXIST, mem_flags);
> >                 /* sk must be a fullsock (guaranteed by verifier),
> >                  * so sock_gen_put() is unnecessary.
> >                  */
> > @@ -417,14 +418,16 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
> >         return false;
> >  }
> >
> > -BPF_CALL_4(bpf_sk_storage_get_tracing, struct bpf_map *, map, struct sock *, sk,
> > -          void *, value, u64, flags)
> > +/* *mem_flags* is set by the bpf verifier */
> > +BPF_CALL_5(bpf_sk_storage_get_tracing, struct bpf_map *, map, struct sock *, sk,
> > +          void *, value, u64, flags, gfp_t, mem_flags)
> >  {
> >         WARN_ON_ONCE(!bpf_rcu_lock_held());
> >         if (in_hardirq() || in_nmi())
> >                 return (unsigned long)NULL;
> >
> > -       return (unsigned long)____bpf_sk_storage_get(map, sk, value, flags);
> > +       return (unsigned long)____bpf_sk_storage_get(map, sk, value, flags,
> > +                                                    mem_flags);
> >  }
> >
> >  BPF_CALL_2(bpf_sk_storage_delete_tracing, struct bpf_map *, map,
> > --
> > 2.30.2
> >

--
Kartikeya
