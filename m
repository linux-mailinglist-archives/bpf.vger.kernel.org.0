Return-Path: <bpf+bounces-65970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA569B2B847
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 06:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2A0621F86
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 04:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A815B30F559;
	Tue, 19 Aug 2025 04:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1+rAt4Gw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2555524A063
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 04:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755576709; cv=none; b=R36t+aw3vPiI2tqmRPATtyjZdtFxUNSkZ/kBVHS++PXujbjMhOhVgVIQKuHMI/MpH9ksUllXYXo3z1rOaNd+9fWiZMyDlSLgvAXyvosCi5snNXIFPhpgAgTcgV5YzGZ3hv5eEOCEAfDOyqoHFjHIGDUCNAo6iDvVuavV3XXVRuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755576709; c=relaxed/simple;
	bh=j1YjiO+WBIYe+63Uxi6Y+3K/hSyp44QYUYSbQ9alQeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q69zx70iHNgS2RQ42aSFghT9TtThKRyPp+aXzKUZyPsYRK/DgaTYvLGVl3YJgyhZxtPqsuqZ2QSiOEUq8p2Nu2vLU1cd2j9sYfeQm0M88lEzgOO+0M/9VAbm6oLlO1ge4bALvBH3lfq9T23y5f7UbueGCW6uS9MHyd0bmTXXYZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1+rAt4Gw; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b0bf08551cso170781cf.1
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 21:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755576706; x=1756181506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSRl+XdsVz6cA+qVhJDiAEDxaINC+OwPT1vBcMVSeXo=;
        b=1+rAt4Gw/E2ip24ott5TCKXjhru3nSIElyA5iZ/OK2gUNr4xZjUPqwhyoX4Y0tAlyo
         4S3key1O6bi26Vz4vroR/eXBXMKwYEwaHMiuard1qex2/9JhMewC9sPJVFlX1+0EyheE
         jKL2o+s7LcrVlLThNyD9S+tanE0kv4Ygh9okkc7oN3K0Q/NxR0pM1/+q8Py5nTQy0Vv9
         4zpBA5g00+u7i+UYlCimN90+rar4zO2U79+Z9B6gLyPGbdbFJINZR9Gnt/W80KtAA7gG
         vNgzS3Z1G9Gs8Sqq+wxfQiL/XUzY92fDy73FCjwJlE5uJpLI7frxzidGQLdRXSYCUzjF
         fwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755576706; x=1756181506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSRl+XdsVz6cA+qVhJDiAEDxaINC+OwPT1vBcMVSeXo=;
        b=hjLp6pEVDB9BX555oEYKnIoV0WNsQjuaXq8k9AUH4bdeS9G4vLkh96V4ROJNGrS9lK
         5zt3/IDi1GrZr1Oxiar+zCOX4PnqOnyoS0FGkdVxEvkr+XrRfHZG6svMSoSAH45BhRid
         5BknssEsKkryhsyiFdrWoEuhNdHmrxcPZcxa2bep9oRaklk1SvDdxVAb78i9254ivyQG
         XeS9FS7IR9mn97AenTFSuMhR9R5Jg9hTwiUbcfpMp+FgQuv4evr9pzEY4V7dw7rKCZqt
         P23ivXZaAF/gjweZc4DmZ2TnKwuc39NPdwCE7E4ZEC+8EmBzPQWLG+jFRZcu0EsCZ5f1
         Y1wA==
X-Forwarded-Encrypted: i=1; AJvYcCWP8eGVwADUYqXenoAUNwagNiWbl3LiCFLPIKKdLbwu7ReIjZ9RR9k+nloj1B4nLAMznCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgUuZcTZbvBXAhdXblzuhBM0gXto0k1iaswGr+tapLHTitmjPx
	VwYysgwGnRVlFdWwXx9fvqmk4VxID6KhgSII5Y0ox+W+LUft6DOJOOISwyhxkr6XG2dm6Q5cWA/
	NoYS/v+xpL08m20Mr5qsOKQoEJ9Xx7ADmqldNfE3f
X-Gm-Gg: ASbGncsL71gr8JDfff9/uIOGYOqfy7Uq8+nbdRzB0oMuSD2acEcxHaiFwIe241V31rt
	+JYIujCxIy2gezOYnQG6z0qpMg57QFhKw68l89w0WD+jsbiNByYlzongl+n+cFzHR2AONsFzzwH
	pXLNgeSPjrMtoIybqP03ri14DSav6wanvYxRlGEY947CRcsgo7xIU3rvUco/VJJ0yw2GLBRdkDy
	TLRXC2iuDcGshE1Poe7uVE=
X-Google-Smtp-Source: AGHT+IEAseXbHFUZdNyUY54h5iSQd62BVcDHaihC55US9eLcEdX0N7rEYNfU731T7AGfBiLn4iXQdtXOMIXCCFU6pRs=
X-Received: by 2002:a05:622a:4509:b0:4a8:19d5:e9bb with SMTP id
 d75a77b69052e-4b286e0a930mr1555521cf.13.1755576705543; Mon, 18 Aug 2025
 21:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev> <20250818170136.209169-13-roman.gushchin@linux.dev>
In-Reply-To: <20250818170136.209169-13-roman.gushchin@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 18 Aug 2025 21:11:34 -0700
X-Gm-Features: Ac12FXwVPItwJbpSe93H9DaM2201NIL0iMl7AL-zzp9WRItxN2YCOPUE7r8hX9M
Message-ID: <CAJuCfpHUDSJ_yLEqtfmU0rykUGYM6tXR+rgVv1i3QjJz+2JU1A@mail.gmail.com>
Subject: Re: [PATCH v1 12/14] sched: psi: implement psi trigger handling using bpf
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 10:02=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> This patch implements a bpf struct ops-based mechanism to create
> psi triggers, attach them to cgroups or system wide and handle
> psi events in bpf.
>
> The struct ops provides 3 callbacks:
>   - init() called once at load, handy for creating psi triggers
>   - handle_psi_event() called every time a psi trigger fires
>   - handle_cgroup_free() called if a cgroup with an attached
>     trigger is being freed
>
> A single struct ops can create a number of psi triggers, both
> cgroup-scoped and system-wide.
>
> All 3 struct ops callbacks can be sleepable. handle_psi_event()
> handlers are executed using a separate workqueue, so it won't
> affect the latency of other psi triggers.

I'll need to stare some more into this code but overall it makes sense
to me. Some early comments below.

>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  include/linux/bpf_psi.h      |  71 ++++++++++
>  include/linux/psi_types.h    |  43 +++++-
>  kernel/sched/bpf_psi.c       | 253 +++++++++++++++++++++++++++++++++++
>  kernel/sched/build_utility.c |   4 +
>  kernel/sched/psi.c           |  49 +++++--
>  5 files changed, 408 insertions(+), 12 deletions(-)
>  create mode 100644 include/linux/bpf_psi.h
>  create mode 100644 kernel/sched/bpf_psi.c
>
> diff --git a/include/linux/bpf_psi.h b/include/linux/bpf_psi.h
> new file mode 100644
> index 000000000000..826ab89ac11c
> --- /dev/null
> +++ b/include/linux/bpf_psi.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __BPF_PSI_H
> +#define __BPF_PSI_H
> +
> +#include <linux/list.h>
> +#include <linux/spinlock.h>
> +#include <linux/srcu.h>
> +#include <linux/psi_types.h>
> +
> +struct cgroup;
> +struct bpf_psi;
> +struct psi_trigger;
> +struct psi_trigger_params;
> +
> +#define BPF_PSI_FULL 0x80000000
> +
> +struct bpf_psi_ops {
> +       /**
> +        * @init: Initialization callback, suited for creating psi trigge=
rs.
> +        * @bpf_psi: bpf_psi pointer, can be passed to bpf_psi_create_tri=
gger().
> +        *
> +        * A non-0 return value means the initialization has been failed.
> +        */
> +       int (*init)(struct bpf_psi *bpf_psi);
> +
> +       /**
> +        * @handle_psi_event: PSI event callback
> +        * @t: psi_trigger pointer
> +        */
> +       void (*handle_psi_event)(struct psi_trigger *t);
> +
> +       /**
> +        * @handle_cgroup_free: Cgroup free callback
> +        * @cgroup_id: Id of freed cgroup
> +        *
> +        * Called every time a cgroup with an attached bpf psi trigger is=
 freed.
> +        * No psi events can be raised after handle_cgroup_free().
> +        */
> +       void (*handle_cgroup_free)(u64 cgroup_id);
> +
> +       /* private */
> +       struct bpf_psi *bpf_psi;
> +};
> +
> +struct bpf_psi {
> +       spinlock_t lock;
> +       struct list_head triggers;
> +       struct bpf_psi_ops *ops;
> +       struct srcu_struct srcu;
> +};
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +void bpf_psi_add_trigger(struct psi_trigger *t,
> +                        const struct psi_trigger_params *params);
> +void bpf_psi_remove_trigger(struct psi_trigger *t);
> +void bpf_psi_handle_event(struct psi_trigger *t);
> +#ifdef CONFIG_CGROUPS
> +void bpf_psi_cgroup_free(struct cgroup *cgroup);
> +#endif
> +
> +#else /* CONFIG_BPF_SYSCALL */
> +static inline void bpf_psi_add_trigger(struct psi_trigger *t,
> +                       const struct psi_trigger_params *params) {}
> +static inline void bpf_psi_remove_trigger(struct psi_trigger *t) {}
> +static inline void bpf_psi_handle_event(struct psi_trigger *t) {}
> +static inline void bpf_psi_cgroup_free(struct cgroup *cgroup) {}
> +
> +#endif /* CONFIG_BPF_SYSCALL */
> +
> +#endif /* __BPF_PSI_H */
> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> index cea54121d9b9..f695cc34cfd4 100644
> --- a/include/linux/psi_types.h
> +++ b/include/linux/psi_types.h
> @@ -124,6 +124,7 @@ struct psi_window {
>  enum psi_trigger_type {
>         PSI_SYSTEM,
>         PSI_CGROUP,
> +       PSI_BPF,
>  };
>
>  struct psi_trigger_params {
> @@ -145,8 +146,15 @@ struct psi_trigger_params {
>         /* Privileged triggers are treated differently */
>         bool privileged;
>
> -       /* Link to kernfs open file, only for PSI_CGROUP */
> -       struct kernfs_open_file *of;
> +       union {
> +               /* Link to kernfs open file, only for PSI_CGROUP */
> +               struct kernfs_open_file *of;
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +               /* Link to bpf_psi structure, only for BPF_PSI */
> +               struct bpf_psi *bpf_psi;
> +#endif
> +       };
>  };
>
>  struct psi_trigger {
> @@ -188,6 +196,31 @@ struct psi_trigger {
>
>         /* Trigger type - PSI_AVGS for unprivileged, PSI_POLL for RT */
>         enum psi_aggregators aggregator;
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +       /* Fields specific to PSI_BPF triggers */
> +
> +       /* Bpf psi structure for events handling */
> +       struct bpf_psi *bpf_psi;
> +
> +       /* List node inside bpf_psi->triggers list */
> +       struct list_head bpf_psi_node;
> +
> +       /* List node inside group->bpf_triggers list */
> +       struct list_head bpf_group_node;
> +
> +       /* Work structure, used to execute event handlers */
> +       struct work_struct bpf_work;

I think bpf_work can be moved into struct bpf_psi as you are using it
get to bpf_psi anyway:

       t =3D container_of(work, struct psi_trigger, bpf_work);
       bpf_psi =3D READ_ONCE(t->bpf_psi);

> +
> +       /*
> +        * Whether the trigger is being pinned in memory.
> +        * Protected by group->bpf_triggers_lock.
> +        */
> +       bool pinned;

Same with pinned field. I think you are using it only with triggers
which have a valid t->bpf_work, so might as well move in there. I
would also call this field "isolated" rather than "pinned" but that's
just a preference.

> +
> +       /* Cgroup Id */
> +       u64 cgroup_id;

This cgroup_id field is weird. It's not initialized and not used here,
then it gets initialized in the next patch and used in the last patch
from a selftest. This is quite confusing. Also logically I don't think
a cgroup attribute really belongs to psi_trigger... Can we at least
move it into bpf_psi where it might fit a bit better?

> +#endif
>  };
>
>  struct psi_group {
> @@ -236,6 +269,12 @@ struct psi_group {
>         u64 rtpoll_total[NR_PSI_STATES - 1];
>         u64 rtpoll_next_update;
>         u64 rtpoll_until;
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +       /* List of triggers owned by bpf and corresponding lock */
> +       spinlock_t bpf_triggers_lock;
> +       struct list_head bpf_triggers;
> +#endif
>  };
>
>  #else /* CONFIG_PSI */
> diff --git a/kernel/sched/bpf_psi.c b/kernel/sched/bpf_psi.c
> new file mode 100644
> index 000000000000..2ea9d7276b21
> --- /dev/null
> +++ b/kernel/sched/bpf_psi.c
> @@ -0,0 +1,253 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * BPF PSI event handlers
> + *
> + * Author: Roman Gushchin <roman.gushchin@linux.dev>
> + */
> +
> +#include <linux/bpf_psi.h>
> +#include <linux/cgroup-defs.h>
> +
> +static struct workqueue_struct *bpf_psi_wq;
> +
> +static struct bpf_psi *bpf_psi_create(struct bpf_psi_ops *ops)
> +{
> +       struct bpf_psi *bpf_psi;
> +
> +       bpf_psi =3D kzalloc(sizeof(*bpf_psi), GFP_KERNEL);
> +       if (!bpf_psi)
> +               return NULL;
> +
> +       if (init_srcu_struct(&bpf_psi->srcu)) {
> +               kfree(bpf_psi);
> +               return NULL;
> +       }
> +
> +       spin_lock_init(&bpf_psi->lock);
> +       bpf_psi->ops =3D ops;
> +       INIT_LIST_HEAD(&bpf_psi->triggers);
> +       ops->bpf_psi =3D bpf_psi;
> +
> +       return bpf_psi;
> +}
> +
> +static void bpf_psi_free(struct bpf_psi *bpf_psi)
> +{
> +       cleanup_srcu_struct(&bpf_psi->srcu);
> +       kfree(bpf_psi);
> +}
> +
> +static void bpf_psi_handle_event_fn(struct work_struct *work)
> +{
> +       struct psi_trigger *t;
> +       struct bpf_psi *bpf_psi;
> +       int idx;
> +
> +       t =3D container_of(work, struct psi_trigger, bpf_work);
> +       bpf_psi =3D READ_ONCE(t->bpf_psi);
> +
> +       if (likely(bpf_psi)) {
> +               idx =3D srcu_read_lock(&bpf_psi->srcu);
> +               if (bpf_psi->ops->handle_psi_event)
> +                       bpf_psi->ops->handle_psi_event(t);
> +               srcu_read_unlock(&bpf_psi->srcu, idx);
> +       }
> +}
> +
> +void bpf_psi_add_trigger(struct psi_trigger *t,
> +                        const struct psi_trigger_params *params)
> +{
> +       t->bpf_psi =3D params->bpf_psi;
> +       t->pinned =3D false;
> +       INIT_WORK(&t->bpf_work, bpf_psi_handle_event_fn);
> +
> +       spin_lock(&t->bpf_psi->lock);
> +       list_add(&t->bpf_psi_node, &t->bpf_psi->triggers);
> +       spin_unlock(&t->bpf_psi->lock);
> +
> +       spin_lock(&t->group->bpf_triggers_lock);
> +       list_add(&t->bpf_group_node, &t->group->bpf_triggers);
> +       spin_unlock(&t->group->bpf_triggers_lock);
> +}
> +
> +void bpf_psi_remove_trigger(struct psi_trigger *t)
> +{
> +       spin_lock(&t->group->bpf_triggers_lock);
> +       list_del(&t->bpf_group_node);
> +       spin_unlock(&t->group->bpf_triggers_lock);
> +
> +       spin_lock(&t->bpf_psi->lock);
> +       list_del(&t->bpf_psi_node);
> +       spin_unlock(&t->bpf_psi->lock);
> +}
> +
> +#ifdef CONFIG_CGROUPS
> +void bpf_psi_cgroup_free(struct cgroup *cgroup)
> +{
> +       struct psi_group *group =3D cgroup->psi;
> +       u64 cgrp_id =3D cgroup_id(cgroup);
> +       struct psi_trigger *t, *p;
> +       struct bpf_psi *bpf_psi;
> +       LIST_HEAD(to_destroy);
> +       int idx;
> +
> +       spin_lock(&group->bpf_triggers_lock);
> +       list_for_each_entry_safe(t, p, &group->bpf_triggers, bpf_group_no=
de) {
> +               if (!t->pinned) {
> +                       t->pinned =3D true;
> +                       list_move(&t->bpf_group_node, &to_destroy);
> +               }
> +       }
> +       spin_unlock(&group->bpf_triggers_lock);
> +
> +       list_for_each_entry_safe(t, p, &to_destroy, bpf_group_node) {
> +               bpf_psi =3D READ_ONCE(t->bpf_psi);
> +
> +               idx =3D srcu_read_lock(&bpf_psi->srcu);
> +               if (bpf_psi->ops->handle_cgroup_free)
> +                       bpf_psi->ops->handle_cgroup_free(cgrp_id);
> +               srcu_read_unlock(&bpf_psi->srcu, idx);
> +
> +               spin_lock(&bpf_psi->lock);
> +               list_del(&t->bpf_psi_node);
> +               spin_unlock(&bpf_psi->lock);
> +
> +               WRITE_ONCE(t->bpf_psi, NULL);
> +               flush_workqueue(bpf_psi_wq);
> +               synchronize_srcu(&bpf_psi->srcu);
> +               psi_trigger_destroy(t);
> +       }
> +}
> +#endif
> +
> +void bpf_psi_handle_event(struct psi_trigger *t)
> +{
> +       queue_work(bpf_psi_wq, &t->bpf_work);
> +}
> +
> +// bpf struct ops

C++ style comment?

> +
> +static int __bpf_psi_init(struct bpf_psi *bpf_psi) { return 0; }
> +static void __bpf_psi_handle_psi_event(struct psi_trigger *t) {}
> +static void __bpf_psi_handle_cgroup_free(u64 cgroup_id) {}
> +
> +static struct bpf_psi_ops __bpf_psi_ops =3D {
> +       .init =3D __bpf_psi_init,
> +       .handle_psi_event =3D __bpf_psi_handle_psi_event,
> +       .handle_cgroup_free =3D __bpf_psi_handle_cgroup_free,
> +};
> +
> +static const struct bpf_func_proto *
> +bpf_psi_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog=
)
> +{
> +       return tracing_prog_func_proto(func_id, prog);
> +}
> +
> +static bool bpf_psi_ops_is_valid_access(int off, int size,
> +                                       enum bpf_access_type type,
> +                                       const struct bpf_prog *prog,
> +                                       struct bpf_insn_access_aux *info)
> +{
> +       return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
> +}
> +
> +static const struct bpf_verifier_ops bpf_psi_verifier_ops =3D {
> +       .get_func_proto =3D bpf_psi_func_proto,
> +       .is_valid_access =3D bpf_psi_ops_is_valid_access,
> +};
> +
> +static int bpf_psi_ops_reg(void *kdata, struct bpf_link *link)
> +{
> +       struct bpf_psi_ops *ops =3D kdata;
> +       struct bpf_psi *bpf_psi;
> +
> +       bpf_psi =3D bpf_psi_create(ops);
> +       if (!bpf_psi)
> +               return -ENOMEM;
> +
> +       return ops->init(bpf_psi);
> +}
> +
> +static void bpf_psi_ops_unreg(void *kdata, struct bpf_link *link)
> +{
> +       struct bpf_psi_ops *ops =3D kdata;
> +       struct bpf_psi *bpf_psi =3D ops->bpf_psi;
> +       struct psi_trigger *t, *p;
> +       LIST_HEAD(to_destroy);
> +
> +       spin_lock(&bpf_psi->lock);
> +       list_for_each_entry_safe(t, p, &bpf_psi->triggers, bpf_psi_node) =
{
> +               spin_lock(&t->group->bpf_triggers_lock);
> +               if (!t->pinned) {
> +                       t->pinned =3D true;
> +                       list_move(&t->bpf_group_node, &to_destroy);
> +                       list_del(&t->bpf_psi_node);
> +
> +                       WRITE_ONCE(t->bpf_psi, NULL);
> +               }
> +               spin_unlock(&t->group->bpf_triggers_lock);
> +       }
> +       spin_unlock(&bpf_psi->lock);
> +
> +       flush_workqueue(bpf_psi_wq);
> +       synchronize_srcu(&bpf_psi->srcu);
> +
> +       list_for_each_entry_safe(t, p, &to_destroy, bpf_group_node)
> +               psi_trigger_destroy(t);
> +
> +       bpf_psi_free(bpf_psi);
> +}
> +
> +static int bpf_psi_ops_check_member(const struct btf_type *t,
> +                                   const struct btf_member *member,
> +                                   const struct bpf_prog *prog)
> +{
> +       return 0;
> +}
> +
> +static int bpf_psi_ops_init_member(const struct btf_type *t,
> +                                  const struct btf_member *member,
> +                                  void *kdata, const void *udata)
> +{
> +       return 0;
> +}
> +
> +static int bpf_psi_ops_init(struct btf *btf)
> +{
> +       return 0;
> +}
> +
> +static struct bpf_struct_ops bpf_psi_bpf_ops =3D {
> +       .verifier_ops =3D &bpf_psi_verifier_ops,
> +       .reg =3D bpf_psi_ops_reg,
> +       .unreg =3D bpf_psi_ops_unreg,
> +       .check_member =3D bpf_psi_ops_check_member,
> +       .init_member =3D bpf_psi_ops_init_member,
> +       .init =3D bpf_psi_ops_init,
> +       .name =3D "bpf_psi_ops",
> +       .owner =3D THIS_MODULE,
> +       .cfi_stubs =3D &__bpf_psi_ops
> +};
> +
> +static int __init bpf_psi_struct_ops_init(void)
> +{
> +       int wq_flags =3D WQ_MEM_RECLAIM | WQ_UNBOUND | WQ_HIGHPRI;
> +       int err;
> +
> +       bpf_psi_wq =3D alloc_workqueue("bpf_psi_wq", wq_flags, 0);
> +       if (!bpf_psi_wq)
> +               return -ENOMEM;
> +
> +       err =3D register_bpf_struct_ops(&bpf_psi_bpf_ops, bpf_psi_ops);
> +       if (err) {
> +               pr_warn("error while registering bpf psi struct ops: %d",=
 err);
> +               goto err;
> +       }
> +
> +       return 0;
> +
> +err:
> +       destroy_workqueue(bpf_psi_wq);
> +       return err;
> +}
> +late_initcall(bpf_psi_struct_ops_init);
> diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
> index bf9d8db94b70..80f3799a2fa6 100644
> --- a/kernel/sched/build_utility.c
> +++ b/kernel/sched/build_utility.c
> @@ -19,6 +19,7 @@
>  #include <linux/sched/rseq_api.h>
>  #include <linux/sched/task_stack.h>
>
> +#include <linux/bpf_psi.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask_api.h>
>  #include <linux/cpuset.h>
> @@ -92,6 +93,9 @@
>
>  #ifdef CONFIG_PSI
>  # include "psi.c"
> +# ifdef CONFIG_BPF_SYSCALL
> +#  include "bpf_psi.c"
> +# endif
>  #endif
>
>  #ifdef CONFIG_MEMBARRIER
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index e1d8eaeeff17..e10fbbc34099 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -201,6 +201,10 @@ static void group_init(struct psi_group *group)
>         init_waitqueue_head(&group->rtpoll_wait);
>         timer_setup(&group->rtpoll_timer, poll_timer_fn, 0);
>         rcu_assign_pointer(group->rtpoll_task, NULL);
> +#ifdef CONFIG_BPF_SYSCALL
> +       spin_lock_init(&group->bpf_triggers_lock);
> +       INIT_LIST_HEAD(&group->bpf_triggers);
> +#endif
>  }
>
>  void __init psi_init(void)
> @@ -489,10 +493,17 @@ static void update_triggers(struct psi_group *group=
, u64 now,
>
>                 /* Generate an event */
>                 if (cmpxchg(&t->event, 0, 1) =3D=3D 0) {
> -                       if (t->type =3D=3D PSI_CGROUP)
> -                               kernfs_notify(t->of->kn);
> -                       else
> +                       switch (t->type) {
> +                       case PSI_SYSTEM:
>                                 wake_up_interruptible(&t->event_wait);
> +                               break;
> +                       case PSI_CGROUP:
> +                               kernfs_notify(t->of->kn);
> +                               break;
> +                       case PSI_BPF:
> +                               bpf_psi_handle_event(t);
> +                               break;
> +                       }
>                 }
>                 t->last_event_time =3D now;
>                 /* Reset threshold breach flag once event got generated *=
/
> @@ -1125,6 +1136,7 @@ void psi_cgroup_free(struct cgroup *cgroup)
>                 return;
>
>         cancel_delayed_work_sync(&cgroup->psi->avgs_work);
> +       bpf_psi_cgroup_free(cgroup);
>         free_percpu(cgroup->psi->pcpu);
>         /* All triggers must be removed by now */
>         WARN_ONCE(cgroup->psi->rtpoll_states, "psi: trigger leak\n");
> @@ -1356,6 +1368,9 @@ struct psi_trigger *psi_trigger_create(struct psi_g=
roup *group,
>         case PSI_CGROUP:
>                 t->of =3D params->of;
>                 break;
> +       case PSI_BPF:
> +               bpf_psi_add_trigger(t, params);
> +               break;
>         }
>
>         t->pending_event =3D false;
> @@ -1369,8 +1384,10 @@ struct psi_trigger *psi_trigger_create(struct psi_=
group *group,
>
>                         task =3D kthread_create(psi_rtpoll_worker, group,=
 "psimon");
>                         if (IS_ERR(task)) {
> -                               kfree(t);
>                                 mutex_unlock(&group->rtpoll_trigger_lock)=
;
> +                               if (t->type =3D=3D PSI_BPF)
> +                                       bpf_psi_remove_trigger(t);
> +                               kfree(t);
>                                 return ERR_CAST(task);
>                         }
>                         atomic_set(&group->rtpoll_wakeup, 0);
> @@ -1414,10 +1431,16 @@ void psi_trigger_destroy(struct psi_trigger *t)

Will this function be ever called for PSI_BPF triggers? Same question
for psi_trigger_poll().




>          * being accessed later. Can happen if cgroup is deleted from und=
er a
>          * polling process.
>          */
> -       if (t->type =3D=3D PSI_CGROUP)
> -               kernfs_notify(t->of->kn);
> -       else
> +       switch (t->type) {
> +       case PSI_SYSTEM:
>                 wake_up_interruptible(&t->event_wait);
> +               break;
> +       case PSI_CGROUP:
> +               kernfs_notify(t->of->kn);
> +               break;
> +       case PSI_BPF:
> +               break;
> +       }
>
>         if (t->aggregator =3D=3D PSI_AVGS) {
>                 mutex_lock(&group->avgs_lock);
> @@ -1494,10 +1517,16 @@ __poll_t psi_trigger_poll(void **trigger_ptr,
>         if (!t)
>                 return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
>
> -       if (t->type =3D=3D PSI_CGROUP)
> -               kernfs_generic_poll(t->of, wait);
> -       else
> +       switch (t->type) {
> +       case PSI_SYSTEM:
>                 poll_wait(file, &t->event_wait, wait);
> +               break;
> +       case PSI_CGROUP:
> +               kernfs_generic_poll(t->of, wait);
> +               break;
> +       case PSI_BPF:
> +               break;
> +       }
>
>         if (cmpxchg(&t->event, 1, 0) =3D=3D 1)
>                 ret |=3D EPOLLPRI;
> --
> 2.50.1
>

