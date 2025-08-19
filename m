Return-Path: <bpf+bounces-66049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883E0B2CF60
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 00:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AAE17AA596
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 22:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A96F21B9F1;
	Tue, 19 Aug 2025 22:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I9HqhpWb"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B601DDC07
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755642695; cv=none; b=VB10GlPXRZ4ay/bN/1FflaDLG2eTgUm8x2Tdd/u2Xew6G7Tqxj8GnrkE/DPjTNCB/VgPoZiiS+BZPT8a+VxS2UZxzMQS+EJ7IF7p2/pjEH9AU/GyKAZuqkmwxIdPp02AQJY5lSn/6ZLHk+7LNOf6JV1Brwo9UmsYG8Tmys78l10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755642695; c=relaxed/simple;
	bh=Jp37FnaMW3SGF2UwE1j8keUem9dU0+0fii3l61vhAK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gbTxMdrG301mLYLdIm7lOeHiGflye4V1etOPqGBSr7JFdHwiimDwt5qD2ka5lSKzB5QKxEiEIwuC1h6IUwtqG7/F+46RaCYaONydlEVr7BBrz7xLOHqIZ9LWb4CSn80UbGwX2qwBYBn+LrCIvrFkUbVVbVpgVZmp0h8r4Q9g5WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I9HqhpWb; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755642680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y6I2HzOQJ0e0LbaC1kZlQtqVrPCjoKUw/Vl4HSzIUc4=;
	b=I9HqhpWbrJX8oi8AUFjch9CBh8Me+OyPlz0JMNwze71iDhsVE8lHO1tNAUrnnbj87Pxl8Q
	0jzznr72IwsN/M/e24AyV9V7pcwK+jOuKQnAv6Z0uXKn/MwlC2QBarn6JAynZhbndcz26a
	ss/gWh712LhEKQMHHPEFFFVkeHUkS28=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org,  bpf@vger.kernel.org,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@suse.com>,  David Rientjes
 <rientjes@google.com>,  Matt Bobrowski <mattbobrowski@google.com>,  Song
 Liu <song@kernel.org>,  Kumar Kartikeya Dwivedi <memxor@gmail.com>,
  Alexei Starovoitov <ast@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 12/14] sched: psi: implement psi trigger handling
 using bpf
In-Reply-To: <CAJuCfpHUDSJ_yLEqtfmU0rykUGYM6tXR+rgVv1i3QjJz+2JU1A@mail.gmail.com>
	(Suren Baghdasaryan's message of "Mon, 18 Aug 2025 21:11:34 -0700")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<20250818170136.209169-13-roman.gushchin@linux.dev>
	<CAJuCfpHUDSJ_yLEqtfmU0rykUGYM6tXR+rgVv1i3QjJz+2JU1A@mail.gmail.com>
Date: Tue, 19 Aug 2025 15:31:13 -0700
Message-ID: <87tt23vt8u.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Suren Baghdasaryan <surenb@google.com> writes:

> On Mon, Aug 18, 2025 at 10:02=E2=80=AFAM Roman Gushchin
> <roman.gushchin@linux.dev> wrote:
>>
>> This patch implements a bpf struct ops-based mechanism to create
>> psi triggers, attach them to cgroups or system wide and handle
>> psi events in bpf.
>>
>> The struct ops provides 3 callbacks:
>>   - init() called once at load, handy for creating psi triggers
>>   - handle_psi_event() called every time a psi trigger fires
>>   - handle_cgroup_free() called if a cgroup with an attached
>>     trigger is being freed
>>
>> A single struct ops can create a number of psi triggers, both
>> cgroup-scoped and system-wide.
>>
>> All 3 struct ops callbacks can be sleepable. handle_psi_event()
>> handlers are executed using a separate workqueue, so it won't
>> affect the latency of other psi triggers.
>
> I'll need to stare some more into this code but overall it makes sense
> to me. Some early comments below.

Ack, thanks!


>>
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> ---
>>  include/linux/bpf_psi.h      |  71 ++++++++++
>>  include/linux/psi_types.h    |  43 +++++-
>>  kernel/sched/bpf_psi.c       | 253 +++++++++++++++++++++++++++++++++++
>>  kernel/sched/build_utility.c |   4 +
>>  kernel/sched/psi.c           |  49 +++++--
>>  5 files changed, 408 insertions(+), 12 deletions(-)
>>  create mode 100644 include/linux/bpf_psi.h
>>  create mode 100644 kernel/sched/bpf_psi.c
>>
>> diff --git a/include/linux/bpf_psi.h b/include/linux/bpf_psi.h
>> new file mode 100644
>> index 000000000000..826ab89ac11c
>> --- /dev/null
>> +++ b/include/linux/bpf_psi.h
>> @@ -0,0 +1,71 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +
>> +#ifndef __BPF_PSI_H
>> +#define __BPF_PSI_H
>> +
>> +#include <linux/list.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/srcu.h>
>> +#include <linux/psi_types.h>
>> +
>> +struct cgroup;
>> +struct bpf_psi;
>> +struct psi_trigger;
>> +struct psi_trigger_params;
>> +
>> +#define BPF_PSI_FULL 0x80000000
>> +
>> +struct bpf_psi_ops {
>> +       /**
>> +        * @init: Initialization callback, suited for creating psi trigg=
ers.
>> +        * @bpf_psi: bpf_psi pointer, can be passed to bpf_psi_create_tr=
igger().
>> +        *
>> +        * A non-0 return value means the initialization has been failed.
>> +        */
>> +       int (*init)(struct bpf_psi *bpf_psi);
>> +
>> +       /**
>> +        * @handle_psi_event: PSI event callback
>> +        * @t: psi_trigger pointer
>> +        */
>> +       void (*handle_psi_event)(struct psi_trigger *t);
>> +
>> +       /**
>> +        * @handle_cgroup_free: Cgroup free callback
>> +        * @cgroup_id: Id of freed cgroup
>> +        *
>> +        * Called every time a cgroup with an attached bpf psi trigger i=
s freed.
>> +        * No psi events can be raised after handle_cgroup_free().
>> +        */
>> +       void (*handle_cgroup_free)(u64 cgroup_id);
>> +
>> +       /* private */
>> +       struct bpf_psi *bpf_psi;
>> +};
>> +
>> +struct bpf_psi {
>> +       spinlock_t lock;
>> +       struct list_head triggers;
>> +       struct bpf_psi_ops *ops;
>> +       struct srcu_struct srcu;
>> +};
>> +
>> +#ifdef CONFIG_BPF_SYSCALL
>> +void bpf_psi_add_trigger(struct psi_trigger *t,
>> +                        const struct psi_trigger_params *params);
>> +void bpf_psi_remove_trigger(struct psi_trigger *t);
>> +void bpf_psi_handle_event(struct psi_trigger *t);
>> +#ifdef CONFIG_CGROUPS
>> +void bpf_psi_cgroup_free(struct cgroup *cgroup);
>> +#endif
>> +
>> +#else /* CONFIG_BPF_SYSCALL */
>> +static inline void bpf_psi_add_trigger(struct psi_trigger *t,
>> +                       const struct psi_trigger_params *params) {}
>> +static inline void bpf_psi_remove_trigger(struct psi_trigger *t) {}
>> +static inline void bpf_psi_handle_event(struct psi_trigger *t) {}
>> +static inline void bpf_psi_cgroup_free(struct cgroup *cgroup) {}
>> +
>> +#endif /* CONFIG_BPF_SYSCALL */
>> +
>> +#endif /* __BPF_PSI_H */
>> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
>> index cea54121d9b9..f695cc34cfd4 100644
>> --- a/include/linux/psi_types.h
>> +++ b/include/linux/psi_types.h
>> @@ -124,6 +124,7 @@ struct psi_window {
>>  enum psi_trigger_type {
>>         PSI_SYSTEM,
>>         PSI_CGROUP,
>> +       PSI_BPF,
>>  };
>>
>>  struct psi_trigger_params {
>> @@ -145,8 +146,15 @@ struct psi_trigger_params {
>>         /* Privileged triggers are treated differently */
>>         bool privileged;
>>
>> -       /* Link to kernfs open file, only for PSI_CGROUP */
>> -       struct kernfs_open_file *of;
>> +       union {
>> +               /* Link to kernfs open file, only for PSI_CGROUP */
>> +               struct kernfs_open_file *of;
>> +
>> +#ifdef CONFIG_BPF_SYSCALL
>> +               /* Link to bpf_psi structure, only for BPF_PSI */
>> +               struct bpf_psi *bpf_psi;
>> +#endif
>> +       };
>>  };
>>
>>  struct psi_trigger {
>> @@ -188,6 +196,31 @@ struct psi_trigger {
>>
>>         /* Trigger type - PSI_AVGS for unprivileged, PSI_POLL for RT */
>>         enum psi_aggregators aggregator;
>> +
>> +#ifdef CONFIG_BPF_SYSCALL
>> +       /* Fields specific to PSI_BPF triggers */
>> +
>> +       /* Bpf psi structure for events handling */
>> +       struct bpf_psi *bpf_psi;
>> +
>> +       /* List node inside bpf_psi->triggers list */
>> +       struct list_head bpf_psi_node;
>> +
>> +       /* List node inside group->bpf_triggers list */
>> +       struct list_head bpf_group_node;
>> +
>> +       /* Work structure, used to execute event handlers */
>> +       struct work_struct bpf_work;
>
> I think bpf_work can be moved into struct bpf_psi as you are using it
> get to bpf_psi anyway:
>
>        t =3D container_of(work, struct psi_trigger, bpf_work);
>        bpf_psi =3D READ_ONCE(t->bpf_psi);

Not really.
The problem is that for every bpf_psi structure there can bu multiple
triggers. E.g. a trigger for each cgroup. We should be able to handle
them independently.

>> +
>> +       /*
>> +        * Whether the trigger is being pinned in memory.
>> +        * Protected by group->bpf_triggers_lock.
>> +        */
>> +       bool pinned;
>
> Same with pinned field. I think you are using it only with triggers
> which have a valid t->bpf_work, so might as well move in there. I
> would also call this field "isolated" rather than "pinned" but that's
> just a preference.

Here the problem is that a bpf trigger can be destroyed from 2 sides:
if the struct_ops is unloaded or the corresponding cgroup is being
freed. Each trigger sits on two lists: a list of triggers attached
to a specific group and a list of triggers owned by a bpf_psi.
This makes the locking a bit complicated and this is why I need
this pinned flag. It's pinning triggers, not bpf_psi.

>
>> +
>> +       /* Cgroup Id */
>> +       u64 cgroup_id;
>
> This cgroup_id field is weird. It's not initialized and not used here,
> then it gets initialized in the next patch and used in the last patch
> from a selftest. This is quite confusing. Also logically I don't think
> a cgroup attribute really belongs to psi_trigger... Can we at least
> move it into bpf_psi where it might fit a bit better?

I can't move it to bpf_psi, because a single bpf_psi might own multiple
triggers with different cgroup_id's.
For sure I can move it to the next patch, if it's preferred.

If you really don't like it here, other option is to replace it with
a new bpf helper (kfunc) which calculates the cgroup_id by walking the
trigger->group->cgroup->cgroup_id path each time.

>
>> +#endif
>>  };
>>
>>  struct psi_group {
>> @@ -236,6 +269,12 @@ struct psi_group {
>>         u64 rtpoll_total[NR_PSI_STATES - 1];
>>         u64 rtpoll_next_update;
>>         u64 rtpoll_until;
>> +
>> +#ifdef CONFIG_BPF_SYSCALL
>> +       /* List of triggers owned by bpf and corresponding lock */
>> +       spinlock_t bpf_triggers_lock;
>> +       struct list_head bpf_triggers;
>> +#endif
>>  };
>>
>>  #else /* CONFIG_PSI */
>> diff --git a/kernel/sched/bpf_psi.c b/kernel/sched/bpf_psi.c
>> new file mode 100644
>> index 000000000000..2ea9d7276b21
>> --- /dev/null
>> +++ b/kernel/sched/bpf_psi.c
>> @@ -0,0 +1,253 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * BPF PSI event handlers
>> + *
>> + * Author: Roman Gushchin <roman.gushchin@linux.dev>
>> + */
>> +
>> +#include <linux/bpf_psi.h>
>> +#include <linux/cgroup-defs.h>
>> +
>> +static struct workqueue_struct *bpf_psi_wq;
>> +
>> +static struct bpf_psi *bpf_psi_create(struct bpf_psi_ops *ops)
>> +{
>> +       struct bpf_psi *bpf_psi;
>> +
>> +       bpf_psi =3D kzalloc(sizeof(*bpf_psi), GFP_KERNEL);
>> +       if (!bpf_psi)
>> +               return NULL;
>> +
>> +       if (init_srcu_struct(&bpf_psi->srcu)) {
>> +               kfree(bpf_psi);
>> +               return NULL;
>> +       }
>> +
>> +       spin_lock_init(&bpf_psi->lock);
>> +       bpf_psi->ops =3D ops;
>> +       INIT_LIST_HEAD(&bpf_psi->triggers);
>> +       ops->bpf_psi =3D bpf_psi;
>> +
>> +       return bpf_psi;
>> +}
>> +
>> +static void bpf_psi_free(struct bpf_psi *bpf_psi)
>> +{
>> +       cleanup_srcu_struct(&bpf_psi->srcu);
>> +       kfree(bpf_psi);
>> +}
>> +
>> +static void bpf_psi_handle_event_fn(struct work_struct *work)
>> +{
>> +       struct psi_trigger *t;
>> +       struct bpf_psi *bpf_psi;
>> +       int idx;
>> +
>> +       t =3D container_of(work, struct psi_trigger, bpf_work);
>> +       bpf_psi =3D READ_ONCE(t->bpf_psi);
>> +
>> +       if (likely(bpf_psi)) {
>> +               idx =3D srcu_read_lock(&bpf_psi->srcu);
>> +               if (bpf_psi->ops->handle_psi_event)
>> +                       bpf_psi->ops->handle_psi_event(t);
>> +               srcu_read_unlock(&bpf_psi->srcu, idx);
>> +       }
>> +}
>> +
>> +void bpf_psi_add_trigger(struct psi_trigger *t,
>> +                        const struct psi_trigger_params *params)
>> +{
>> +       t->bpf_psi =3D params->bpf_psi;
>> +       t->pinned =3D false;
>> +       INIT_WORK(&t->bpf_work, bpf_psi_handle_event_fn);
>> +
>> +       spin_lock(&t->bpf_psi->lock);
>> +       list_add(&t->bpf_psi_node, &t->bpf_psi->triggers);
>> +       spin_unlock(&t->bpf_psi->lock);
>> +
>> +       spin_lock(&t->group->bpf_triggers_lock);
>> +       list_add(&t->bpf_group_node, &t->group->bpf_triggers);
>> +       spin_unlock(&t->group->bpf_triggers_lock);
>> +}
>> +
>> +void bpf_psi_remove_trigger(struct psi_trigger *t)
>> +{
>> +       spin_lock(&t->group->bpf_triggers_lock);
>> +       list_del(&t->bpf_group_node);
>> +       spin_unlock(&t->group->bpf_triggers_lock);
>> +
>> +       spin_lock(&t->bpf_psi->lock);
>> +       list_del(&t->bpf_psi_node);
>> +       spin_unlock(&t->bpf_psi->lock);
>> +}
>> +
>> +#ifdef CONFIG_CGROUPS
>> +void bpf_psi_cgroup_free(struct cgroup *cgroup)
>> +{
>> +       struct psi_group *group =3D cgroup->psi;
>> +       u64 cgrp_id =3D cgroup_id(cgroup);
>> +       struct psi_trigger *t, *p;
>> +       struct bpf_psi *bpf_psi;
>> +       LIST_HEAD(to_destroy);
>> +       int idx;
>> +
>> +       spin_lock(&group->bpf_triggers_lock);
>> +       list_for_each_entry_safe(t, p, &group->bpf_triggers, bpf_group_n=
ode) {
>> +               if (!t->pinned) {
>> +                       t->pinned =3D true;
>> +                       list_move(&t->bpf_group_node, &to_destroy);
>> +               }
>> +       }
>> +       spin_unlock(&group->bpf_triggers_lock);
>> +
>> +       list_for_each_entry_safe(t, p, &to_destroy, bpf_group_node) {
>> +               bpf_psi =3D READ_ONCE(t->bpf_psi);
>> +
>> +               idx =3D srcu_read_lock(&bpf_psi->srcu);
>> +               if (bpf_psi->ops->handle_cgroup_free)
>> +                       bpf_psi->ops->handle_cgroup_free(cgrp_id);
>> +               srcu_read_unlock(&bpf_psi->srcu, idx);
>> +
>> +               spin_lock(&bpf_psi->lock);
>> +               list_del(&t->bpf_psi_node);
>> +               spin_unlock(&bpf_psi->lock);
>> +
>> +               WRITE_ONCE(t->bpf_psi, NULL);
>> +               flush_workqueue(bpf_psi_wq);
>> +               synchronize_srcu(&bpf_psi->srcu);
>> +               psi_trigger_destroy(t);
>> +       }
>> +}
>> +#endif
>> +
>> +void bpf_psi_handle_event(struct psi_trigger *t)
>> +{
>> +       queue_work(bpf_psi_wq, &t->bpf_work);
>> +}
>> +
>> +// bpf struct ops
>
> C++ style comment?

Fixed.

>> +
>> +static int __bpf_psi_init(struct bpf_psi *bpf_psi) { return 0; }
>> +static void __bpf_psi_handle_psi_event(struct psi_trigger *t) {}
>> +static void __bpf_psi_handle_cgroup_free(u64 cgroup_id) {}
>> +
>> +static struct bpf_psi_ops __bpf_psi_ops =3D {
>> +       .init =3D __bpf_psi_init,
>> +       .handle_psi_event =3D __bpf_psi_handle_psi_event,
>> +       .handle_cgroup_free =3D __bpf_psi_handle_cgroup_free,
>> +};
>> +
>> +static const struct bpf_func_proto *
>> +bpf_psi_func_proto(enum bpf_func_id func_id, const struct bpf_prog *pro=
g)
>> +{
>> +       return tracing_prog_func_proto(func_id, prog);
>> +}
>> +
>> +static bool bpf_psi_ops_is_valid_access(int off, int size,
>> +                                       enum bpf_access_type type,
>> +                                       const struct bpf_prog *prog,
>> +                                       struct bpf_insn_access_aux *info)
>> +{
>> +       return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
>> +}
>> +
>> +static const struct bpf_verifier_ops bpf_psi_verifier_ops =3D {
>> +       .get_func_proto =3D bpf_psi_func_proto,
>> +       .is_valid_access =3D bpf_psi_ops_is_valid_access,
>> +};
>> +
>> +static int bpf_psi_ops_reg(void *kdata, struct bpf_link *link)
>> +{
>> +       struct bpf_psi_ops *ops =3D kdata;
>> +       struct bpf_psi *bpf_psi;
>> +
>> +       bpf_psi =3D bpf_psi_create(ops);
>> +       if (!bpf_psi)
>> +               return -ENOMEM;
>> +
>> +       return ops->init(bpf_psi);
>> +}
>> +
>> +static void bpf_psi_ops_unreg(void *kdata, struct bpf_link *link)
>> +{
>> +       struct bpf_psi_ops *ops =3D kdata;
>> +       struct bpf_psi *bpf_psi =3D ops->bpf_psi;
>> +       struct psi_trigger *t, *p;
>> +       LIST_HEAD(to_destroy);
>> +
>> +       spin_lock(&bpf_psi->lock);
>> +       list_for_each_entry_safe(t, p, &bpf_psi->triggers, bpf_psi_node)=
 {
>> +               spin_lock(&t->group->bpf_triggers_lock);
>> +               if (!t->pinned) {
>> +                       t->pinned =3D true;
>> +                       list_move(&t->bpf_group_node, &to_destroy);
>> +                       list_del(&t->bpf_psi_node);
>> +
>> +                       WRITE_ONCE(t->bpf_psi, NULL);
>> +               }
>> +               spin_unlock(&t->group->bpf_triggers_lock);
>> +       }
>> +       spin_unlock(&bpf_psi->lock);
>> +
>> +       flush_workqueue(bpf_psi_wq);
>> +       synchronize_srcu(&bpf_psi->srcu);
>> +
>> +       list_for_each_entry_safe(t, p, &to_destroy, bpf_group_node)
>> +               psi_trigger_destroy(t);
>> +
>> +       bpf_psi_free(bpf_psi);
>> +}
>> +
>> +static int bpf_psi_ops_check_member(const struct btf_type *t,
>> +                                   const struct btf_member *member,
>> +                                   const struct bpf_prog *prog)
>> +{
>> +       return 0;
>> +}
>> +
>> +static int bpf_psi_ops_init_member(const struct btf_type *t,
>> +                                  const struct btf_member *member,
>> +                                  void *kdata, const void *udata)
>> +{
>> +       return 0;
>> +}
>> +
>> +static int bpf_psi_ops_init(struct btf *btf)
>> +{
>> +       return 0;
>> +}
>> +
>> +static struct bpf_struct_ops bpf_psi_bpf_ops =3D {
>> +       .verifier_ops =3D &bpf_psi_verifier_ops,
>> +       .reg =3D bpf_psi_ops_reg,
>> +       .unreg =3D bpf_psi_ops_unreg,
>> +       .check_member =3D bpf_psi_ops_check_member,
>> +       .init_member =3D bpf_psi_ops_init_member,
>> +       .init =3D bpf_psi_ops_init,
>> +       .name =3D "bpf_psi_ops",
>> +       .owner =3D THIS_MODULE,
>> +       .cfi_stubs =3D &__bpf_psi_ops
>> +};
>> +
>> +static int __init bpf_psi_struct_ops_init(void)
>> +{
>> +       int wq_flags =3D WQ_MEM_RECLAIM | WQ_UNBOUND | WQ_HIGHPRI;
>> +       int err;
>> +
>> +       bpf_psi_wq =3D alloc_workqueue("bpf_psi_wq", wq_flags, 0);
>> +       if (!bpf_psi_wq)
>> +               return -ENOMEM;
>> +
>> +       err =3D register_bpf_struct_ops(&bpf_psi_bpf_ops, bpf_psi_ops);
>> +       if (err) {
>> +               pr_warn("error while registering bpf psi struct ops: %d"=
, err);
>> +               goto err;
>> +       }
>> +
>> +       return 0;
>> +
>> +err:
>> +       destroy_workqueue(bpf_psi_wq);
>> +       return err;
>> +}
>> +late_initcall(bpf_psi_struct_ops_init);
>> diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
>> index bf9d8db94b70..80f3799a2fa6 100644
>> --- a/kernel/sched/build_utility.c
>> +++ b/kernel/sched/build_utility.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/sched/rseq_api.h>
>>  #include <linux/sched/task_stack.h>
>>
>> +#include <linux/bpf_psi.h>
>>  #include <linux/cpufreq.h>
>>  #include <linux/cpumask_api.h>
>>  #include <linux/cpuset.h>
>> @@ -92,6 +93,9 @@
>>
>>  #ifdef CONFIG_PSI
>>  # include "psi.c"
>> +# ifdef CONFIG_BPF_SYSCALL
>> +#  include "bpf_psi.c"
>> +# endif
>>  #endif
>>
>>  #ifdef CONFIG_MEMBARRIER
>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>> index e1d8eaeeff17..e10fbbc34099 100644
>> --- a/kernel/sched/psi.c
>> +++ b/kernel/sched/psi.c
>> @@ -201,6 +201,10 @@ static void group_init(struct psi_group *group)
>>         init_waitqueue_head(&group->rtpoll_wait);
>>         timer_setup(&group->rtpoll_timer, poll_timer_fn, 0);
>>         rcu_assign_pointer(group->rtpoll_task, NULL);
>> +#ifdef CONFIG_BPF_SYSCALL
>> +       spin_lock_init(&group->bpf_triggers_lock);
>> +       INIT_LIST_HEAD(&group->bpf_triggers);
>> +#endif
>>  }
>>
>>  void __init psi_init(void)
>> @@ -489,10 +493,17 @@ static void update_triggers(struct psi_group *grou=
p, u64 now,
>>
>>                 /* Generate an event */
>>                 if (cmpxchg(&t->event, 0, 1) =3D=3D 0) {
>> -                       if (t->type =3D=3D PSI_CGROUP)
>> -                               kernfs_notify(t->of->kn);
>> -                       else
>> +                       switch (t->type) {
>> +                       case PSI_SYSTEM:
>>                                 wake_up_interruptible(&t->event_wait);
>> +                               break;
>> +                       case PSI_CGROUP:
>> +                               kernfs_notify(t->of->kn);
>> +                               break;
>> +                       case PSI_BPF:
>> +                               bpf_psi_handle_event(t);
>> +                               break;
>> +                       }
>>                 }
>>                 t->last_event_time =3D now;
>>                 /* Reset threshold breach flag once event got generated =
*/
>> @@ -1125,6 +1136,7 @@ void psi_cgroup_free(struct cgroup *cgroup)
>>                 return;
>>
>>         cancel_delayed_work_sync(&cgroup->psi->avgs_work);
>> +       bpf_psi_cgroup_free(cgroup);
>>         free_percpu(cgroup->psi->pcpu);
>>         /* All triggers must be removed by now */
>>         WARN_ONCE(cgroup->psi->rtpoll_states, "psi: trigger leak\n");
>> @@ -1356,6 +1368,9 @@ struct psi_trigger *psi_trigger_create(struct psi_=
group *group,
>>         case PSI_CGROUP:
>>                 t->of =3D params->of;
>>                 break;
>> +       case PSI_BPF:
>> +               bpf_psi_add_trigger(t, params);
>> +               break;
>>         }
>>
>>         t->pending_event =3D false;
>> @@ -1369,8 +1384,10 @@ struct psi_trigger *psi_trigger_create(struct psi=
_group *group,
>>
>>                         task =3D kthread_create(psi_rtpoll_worker, group=
, "psimon");
>>                         if (IS_ERR(task)) {
>> -                               kfree(t);
>>                                 mutex_unlock(&group->rtpoll_trigger_lock=
);
>> +                               if (t->type =3D=3D PSI_BPF)
>> +                                       bpf_psi_remove_trigger(t);
>> +                               kfree(t);
>>                                 return ERR_CAST(task);
>>                         }
>>                         atomic_set(&group->rtpoll_wakeup, 0);
>> @@ -1414,10 +1431,16 @@ void psi_trigger_destroy(struct psi_trigger *t)
>
> Will this function be ever called for PSI_BPF triggers?=20

Yes, from bpf_psi_cgroup_free() and bpf_psi_ops_unreg()

> Same question for psi_trigger_poll().

No.

And btw thank you for reviewing the series, highly appreciated!

