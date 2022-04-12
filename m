Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B496B4FCF78
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 08:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbiDLGaj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 02:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiDLGai (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 02:30:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A8B15828
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 23:28:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCF56618C8
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 06:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D855C385AE
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 06:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649744900;
        bh=mwl/X3jH/wWMVhNOcjFkGxPIUXfayR73qHOxettQLgE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gk/ttuHpA+DFM/msA3ni2ngUTq3v/9nnGvHvs5frT8zzZGLbOE7vlr/VbTWf8l9Ec
         wY8dk8T0fKobMSQIWROOF0EgKX7r3J0zfIbZAq8rMIi6ZFY6+yQltMROWIS1Q6+wl1
         WeKUiw3pr/MLPhw/NIk401nv9miD942nZOTkB0xhu8RXuqNck/RP6S78b6cfIdJmVt
         gRBj5FntExbv8NUPUblfJX4Xg5ob7smqhQjJHb5zxPsokAzTKSkMwH3/XrkjASzdHy
         04Jqr9W+qA0PbqUvKUdfC75zgbDNzpktsmeRFx0R6SDY85ay0M0aUDON+fxb/v3FCn
         F8NVxU7DyoBXQ==
Received: by mail-ej1-f53.google.com with SMTP id bg10so35262325ejb.4
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 23:28:20 -0700 (PDT)
X-Gm-Message-State: AOAM531UsSHD4Johcu7EBXlTn3dzWnD85rimG2+2jK1YSAZXsycq/lRz
        sceTqMBnH7Bvo7QXWngOGbge2KvrsjKTQ/tNOttN0w==
X-Google-Smtp-Source: ABdhPJzEBS+AxTvF4jWgmQEcmeHbYoxiZN/0+3g6WPW5KH4CGk4fMrX4L5vKGpb0wbv7VhgujoQdvfeX43YVM02WKRI=
X-Received: by 2002:a17:906:81ca:b0:6e8:ad09:1951 with SMTP id
 e10-20020a17090681ca00b006e8ad091951mr2660005ejx.745.1649744898374; Mon, 11
 Apr 2022 23:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89i+rfrkRrdYAq8Baq04n_ACq+VdB+UcsMoq7U-dB-2hKJA@mail.gmail.com>
 <20220401000642.GB4285@paulmck-ThinkPad-P17-Gen-1> <CANn89iJtfTiSz4v+L3YW+b_gzNoPLz_wuAmXGrNJXqNs9BU9cA@mail.gmail.com>
 <20220401130114.GC4285@paulmck-ThinkPad-P17-Gen-1> <CANn89iLicuKS2wDjY1D5qNT4c-ob=D2n1NnRnm5fGg4LFuW1Kg@mail.gmail.com>
 <20220401152037.GD4285@paulmck-ThinkPad-P17-Gen-1> <20220401152814.GA2841044@paulmck-ThinkPad-P17-Gen-1>
 <20220401154837.GA2842076@paulmck-ThinkPad-P17-Gen-1> <7a90a9b5-df13-6824-32d1-931f19c96cba@quicinc.com>
 <CACYkzJ4FzbFu5NfdRMParp3Ome=ygVAqQPs2v6UGzRDt2LC6iw@mail.gmail.com>
 <20220405203818.qsi7j74jpsex7oky@kafai-mbp.dhcp.thefacebook.com> <CACYkzJ5PkwidPAomc-+js=OTFdzwf38hMO01Q_rbsPM-HZTTkg@mail.gmail.com>
In-Reply-To: <CACYkzJ5PkwidPAomc-+js=OTFdzwf38hMO01Q_rbsPM-HZTTkg@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 12 Apr 2022 08:28:07 +0200
X-Gmail-Original-Message-ID: <CACYkzJ77k7=UwAve-DBkhO7cmBh7W9e6JgFrc3HoHQ3AU1Xfsg@mail.gmail.com>
Message-ID: <CACYkzJ77k7=UwAve-DBkhO7cmBh7W9e6JgFrc3HoHQ3AU1Xfsg@mail.gmail.com>
Subject: Re: [BUG] rcu-tasks : should take care of sparse cpu masks
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Neeraj Upadhyay <quic_neeraju@quicinc.com>, paulmck@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>, andrii@kernel.org,
        ast@kernel.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 6, 2022 at 5:44 PM KP Singh <kpsingh@kernel.org> wrote:
>
> On Tue, Apr 5, 2022 at 10:38 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Tue, Apr 05, 2022 at 02:04:34AM +0200, KP Singh wrote:
> > > > >>> Either way, how frequently is call_rcu_tasks_trace() being invoked in
> > > > >>> your setup?  If it is being invoked frequently, increasing delays would
> > > > >>> allow multiple call_rcu_tasks_trace() instances to be served by a single
> > > > >>> tasklist scan.
> > > > >>>
> > > > >>>> Given that, I do not think bpf_sk_storage_free() can/should use
> > > > >>>> call_rcu_tasks_trace(),
> > > > >>>> we probably will have to fix this soon (or revert from our kernels)
> > > > >>>
> > > > >>> Well, you are in luck!!!  This commit added call_rcu_tasks_trace() to
> > > > >>> bpf_selem_unlink_storage_nolock(), which is invoked in a loop by
> > > > >>> bpf_sk_storage_free():
> > > > >>>
> > > > >>> 0fe4b381a59e ("bpf: Allow bpf_local_storage to be used by sleepable programs")
> > > > >>>
> > > > >>> This commit was authored by KP Singh, who I am adding on CC.  Or I would
> > > > >>> have, except that you beat me to it.  Good show!!!  ;-)
> > >
> > > Hello :)
> > >
> > > Martin, if this ends up being an issue we might have to go with the
> > > initial proposed approach
> > > of marking local storage maps explicitly as sleepable so that not all
> > > maps are forced to be
> > > synchronized via trace RCU.
> > >
> > > We can make the verifier reject loading programs that try to use
> > > non-sleepable local storage
> > > maps in sleepable programs.
> > >
> > > Do you think this is a feasible approach we can take or do you have
> > > other suggestions?
> > bpf_sk_storage_free() does not need to use call_rcu_tasks_trace().
> > The same should go for the bpf_{task,inode}_storage_free().
> > The sk at this point is being destroyed.  No bpf prog (sleepable or not)
> > can have a hold on this sk.  The only storage reader left is from
> > bpf_local_storage_map_free() which is under rcu_read_lock(),
> > so a 'kfree_rcu(selem, rcu)' is enough.
> > A few lines below in bpf_sk_storage_free(), 'kfree_rcu(sk_storage, rcu)'
> > is currently used instead of call_rcu_tasks_trace() for the same reason.
> >
> > KP, if the above makes sense, can you make a patch for it?
> > The bpf_local_storage_map_free() code path also does not need
> > call_rcu_tasks_trace(), so may as well change it together.
> > The bpf_*_storage_delete() helper and the map_{delete,update}_elem()
> > syscall still require the call_rcu_tasks_trace().
>
> Thanks, I will send a patch.

Martin, does this work? (I can send it as a patch later today)

diff --git a/include/linux/bpf_local_storage.h
b/include/linux/bpf_local_storage.h
index 493e63258497..7ea18d4da84b 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -143,9 +143,9 @@ void bpf_selem_link_storage_nolock(struct
bpf_local_storage *local_storage,

 bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
      struct bpf_local_storage_elem *selem,
-     bool uncharge_omem);
+     bool uncharge_omem, bool use_trace_rcu);

-void bpf_selem_unlink(struct bpf_local_storage_elem *selem);
+void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool
use_trace_rcu);

 void bpf_selem_link_map(struct bpf_local_storage_map *smap,
  struct bpf_local_storage_elem *selem);
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 96be8d518885..10424a1cda51 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -90,7 +90,7 @@ void bpf_inode_storage_free(struct inode *inode)
  */
  bpf_selem_unlink_map(selem);
  free_inode_storage = bpf_selem_unlink_storage_nolock(
- local_storage, selem, false);
+ local_storage, selem, false, false);
  }
  raw_spin_unlock_bh(&local_storage->lock);
  rcu_read_unlock();
@@ -149,7 +149,7 @@ static int inode_storage_delete(struct inode
*inode, struct bpf_map *map)
  if (!sdata)
  return -ENOENT;

- bpf_selem_unlink(SELEM(sdata));
+ bpf_selem_unlink(SELEM(sdata), true);

  return 0;
 }
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 01aa2b51ec4d..fbe35554bab7 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -106,7 +106,7 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
  */
 bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
      struct bpf_local_storage_elem *selem,
-     bool uncharge_mem)
+     bool uncharge_mem, bool use_trace_rcu)
 {
  struct bpf_local_storage_map *smap;
  bool free_local_storage;
@@ -150,11 +150,16 @@ bool bpf_selem_unlink_storage_nolock(struct
bpf_local_storage *local_storage,
     SDATA(selem))
  RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);

- call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
+ if (use_trace_rcu)
+ call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
+ else
+ kfree_rcu(selem, rcu);
+
  return free_local_storage;
 }

-static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem)
+static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
+       bool use_trace_rcu)
 {
  struct bpf_local_storage *local_storage;
  bool free_local_storage = false;
@@ -169,12 +174,16 @@ static void __bpf_selem_unlink_storage(struct
bpf_local_storage_elem *selem)
  raw_spin_lock_irqsave(&local_storage->lock, flags);
  if (likely(selem_linked_to_storage(selem)))
  free_local_storage = bpf_selem_unlink_storage_nolock(
- local_storage, selem, true);
+ local_storage, selem, true, use_trace_rcu);
  raw_spin_unlock_irqrestore(&local_storage->lock, flags);

- if (free_local_storage)
- call_rcu_tasks_trace(&local_storage->rcu,
+ if (free_local_storage) {
+ if (use_trace_rcu)
+ call_rcu_tasks_trace(&local_storage->rcu,
      bpf_local_storage_free_rcu);
+ else
+ kfree_rcu(local_storage, rcu);
+ }
 }

 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
@@ -214,14 +223,14 @@ void bpf_selem_link_map(struct
bpf_local_storage_map *smap,
  raw_spin_unlock_irqrestore(&b->lock, flags);
 }

-void bpf_selem_unlink(struct bpf_local_storage_elem *selem)
+void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool use_trace_rcu)
 {
  /* Always unlink from map before unlinking from local_storage
  * because selem will be freed after successfully unlinked from
  * the local_storage.
  */
  bpf_selem_unlink_map(selem);
- __bpf_selem_unlink_storage(selem);
+ __bpf_selem_unlink_storage(selem, use_trace_rcu);
 }

 struct bpf_local_storage_data *
@@ -548,7 +557,7 @@ void bpf_local_storage_map_free(struct
bpf_local_storage_map *smap,
  migrate_disable();
  __this_cpu_inc(*busy_counter);
  }
- bpf_selem_unlink(selem);
+ bpf_selem_unlink(selem, false);
  if (busy_counter) {
  __this_cpu_dec(*busy_counter);
  migrate_enable();
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 6638a0ecc3d2..57904263a710 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -102,7 +102,7 @@ void bpf_task_storage_free(struct task_struct *task)
  */
  bpf_selem_unlink_map(selem);
  free_task_storage = bpf_selem_unlink_storage_nolock(
- local_storage, selem, false);
+ local_storage, selem, false, false);
  }
  raw_spin_unlock_irqrestore(&local_storage->lock, flags);
  bpf_task_storage_unlock();
@@ -192,7 +192,7 @@ static int task_storage_delete(struct task_struct
*task, struct bpf_map *map)
  if (!sdata)
  return -ENOENT;

- bpf_selem_unlink(SELEM(sdata));
+ bpf_selem_unlink(SELEM(sdata), true);

  return 0;
 }
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index e3ac36380520..83d7641ef67b 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -40,7 +40,7 @@ static int bpf_sk_storage_del(struct sock *sk,
struct bpf_map *map)
  if (!sdata)
  return -ENOENT;

- bpf_selem_unlink(SELEM(sdata));
+ bpf_selem_unlink(SELEM(sdata), true);

  return 0;
 }
@@ -75,8 +75,8 @@ void bpf_sk_storage_free(struct sock *sk)
  * sk_storage.
  */
  bpf_selem_unlink_map(selem);
- free_sk_storage = bpf_selem_unlink_storage_nolock(sk_storage,
-  selem, true);
+ free_sk_storage = bpf_selem_unlink_storage_nolock(
+ sk_storage, selem, true, false);
  }
  raw_spin_unlock_bh(&sk_storage->lock);
  rcu_read_unlock();
