Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A067224859
	for <lists+bpf@lfdr.de>; Sat, 18 Jul 2020 05:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgGRDsb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jul 2020 23:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgGRDsa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jul 2020 23:48:30 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A973C0619D2
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 20:48:30 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id e18so8992223ilr.7
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 20:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fe6lmwItvtyaE2gaz592veoDeuzA/THJqvOKICC8ysk=;
        b=Vm7dQyn1PkCfLHiM85ltRnVXDS7J1f7n5QuXCTgf9oSkEDng8PRsObYl8ORl0181N0
         v9mAZYfV0B03fbDDH7XmnTC2v468KcE2KZS+WKlPm86yuHopu1f9SgDZfW/yAIGREreQ
         h/w+D32FEnRSh2iEdeBQdKR+qq+TG5xdRFSOkEobzcyu3zDgTi2seJFFKoUWhcYRiaf2
         Xh6KYXD4H5hFDQAh72IYM3rz59uQzK8qsA09MqED/3gtf9FNNNIU8yvTG+vfhIUG10Bv
         4Ttj6IIoLzGIJebi14/rHTpTAjqLNW3W9LysEDVQR+Eh5PWifr4dSZkbRbKB1O+/k935
         Y6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fe6lmwItvtyaE2gaz592veoDeuzA/THJqvOKICC8ysk=;
        b=B47n5clxtFFO0zDFMYAhjaFVHedENgDsmSPJfAqWYX89tFF3i72/YOJFLZyMxFwtU0
         OenDgkqXLNLqDh/AdG3jIb+JkXXuqfiDgF138L1/v3YXe/tOZgi4C/rPCPrR9FK8tLkI
         q7MSnTrZ2CEO5YAMuGBdqhq92ZZ3Nu/8C5oxhKnLIlnzgPZb8QRBQB+jdFpNFMUqIhur
         BSwmoiLr62b181X+Mnh1VExR5Ofz6bTy7n5fIy54D7zFScD4WMsrpC/DOYPHLKL9aTf3
         iQo7PZZQDoOqAZSkYF7DTBw+9DvtpcVqRvmdwg/IVCVNcKcxAx83p2eQjkQ7oBbrcxVK
         sOKw==
X-Gm-Message-State: AOAM532wlAiyOQnxWgU9nKjGfjHaVikJc6czZ5zUqeUVpbqmj7+1dZ2p
        EAgnjxYc7BPw8Wp+ADsQiRYG69gZ+B9zc9jzrGVMcg==
X-Google-Smtp-Source: ABdhPJwWFrUUN1rE6uZbq63UJlC/dMYRBIEjwQCkkA4FhmJZbLwAEyiHvA/zvv1y97tOa71cuo8QDbKB7itqop8c6wI=
X-Received: by 2002:a92:150d:: with SMTP id v13mr12375153ilk.297.1595044109375;
 Fri, 17 Jul 2020 20:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594944827.git.zhuyifei@google.com> <4321b6199e2719b49ec6e55dae4ebbfb4f7ed0be.1594944827.git.zhuyifei@google.com>
 <20200718033044.ms2ievjoseaoenwj@kafai-mbp>
In-Reply-To: <20200718033044.ms2ievjoseaoenwj@kafai-mbp>
From:   YiFei Zhu <zhuyifei@google.com>
Date:   Fri, 17 Jul 2020 22:48:18 -0500
Message-ID: <CAA-VZPn9Yki+LBQAGM05vC3r9z5R5Y3fm7PLEKWXEyvu_7iVcw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/5] bpf: Make cgroup storages shared across
 attaches on the same cgroup
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 17, 2020 at 10:30 PM Martin KaFai Lau <kafai@fb.com> wrote:
> I still failed to understand why there is a need to do this dance
> that always link/publish first and then unlink/unpublish during failure.
> It causes all these changes to add and track "storage_reused" params
> in a few functions for handling this one failure. That also requires
> to introduce the cgroup_storage_lookup_insert().
>
> Going back to my earlier comment in v2 which I didn't here any feedback:
>
> **** snippet ****
> >> lookup old, found=>reuse, not-found=>alloc.
> >>
> >> Only publish the new storage after the attach has succeeded.
> *** snippet ****
>
> I try to put them in code here (uncompiled code).  wdyt?

Ah, I see what you mean now. I was under the false impression that
multiple CPUs may attempt to link at the same time, so one would need
a weird dance to avoid races and allocating-during-spinlock, but this
is not the case, given that they are under the cgroup_mutex. Thanks
for pointing that out. Will fix in v4.

> >       spin_lock_bh(&map->lock);
> >
> > -     if (map->aux && map->aux != aux)
> > -             goto unlock;
> >       if (aux->cgroup_storage[stype] &&
> >           aux->cgroup_storage[stype] != _map)
> >               goto unlock;
> >
> > -     map->aux = aux;
> Is spin_lock_bh(&map->lock) still required in this function?

No. Will fix in v4.

YiFei Zhu

On Fri, Jul 17, 2020 at 10:30 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Thu, Jul 16, 2020 at 07:16:27PM -0500, YiFei Zhu wrote:
>
> > Fourth, on attach, we reuse the old storage if the key already
> > exists in the map. Because the rbtree traversal holds the spinlock
> > of the map, during which we can't allocate a new storage if we
> > don't find an old storage, instead we preallocate the storage
> > unconditionally, and free the preallocated storage if we find an
> > old storage in the map. This results in a change of semantics in
> > bpf_cgroup_storage{,s}_link, and rename cgroup_storage_insert to
> > cgroup_storage_lookup_insert that does both lookup and conditionally
> > insert or free. bpf_cgroup_storage{,s}_link also tracks exactly
> > which storages are reused in an array of bools, so it can unlink
> > and free the new storages in the event that attachment failed
> > later than link. bpf_cgroup_storages_{free,unlink} accepts the
> > bool array in order to facilitate that.
>
> [ ... ]
>
> > ---
> >  include/linux/bpf-cgroup.h     | 15 +++---
> >  include/uapi/linux/bpf.h       |  2 +-
> >  kernel/bpf/cgroup.c            | 69 +++++++++++++++------------
> >  kernel/bpf/core.c              | 12 -----
> >  kernel/bpf/local_storage.c     | 85 ++++++++++++++++------------------
> >  tools/include/uapi/linux/bpf.h |  2 +-
> >  6 files changed, 91 insertions(+), 94 deletions(-)
> >
> > diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> > index 2c6f26670acc..c83cd8862298 100644
> > --- a/include/linux/bpf-cgroup.h
> > +++ b/include/linux/bpf-cgroup.h
> > @@ -46,7 +46,8 @@ struct bpf_cgroup_storage {
> >       };
> >       struct bpf_cgroup_storage_map *map;
> >       struct bpf_cgroup_storage_key key;
> > -     struct list_head list;
> > +     struct list_head list_map;
> > +     struct list_head list_cg;
> >       struct rb_node node;
> >       struct rcu_head rcu;
> >  };
> > @@ -78,6 +79,9 @@ struct cgroup_bpf {
> >       struct list_head progs[MAX_BPF_ATTACH_TYPE];
> >       u32 flags[MAX_BPF_ATTACH_TYPE];
> >
> > +     /* list of cgroup shared storages */
> > +     struct list_head storages;
> > +
> >       /* temp storage for effective prog array used by prog_attach/detach */
> >       struct bpf_prog_array *inactive;
> >
> > @@ -164,12 +168,11 @@ static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage
> >  struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog,
> >                                       enum bpf_cgroup_storage_type stype);
> >  void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage);
> > -void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
> > -                          struct cgroup *cgroup,
> > -                          enum bpf_attach_type type);
> > +struct bpf_cgroup_storage *
> > +bpf_cgroup_storage_link(struct bpf_cgroup_storage *new_storage,
> > +                     struct cgroup *cgroup, bool *storage_reused);
> >  void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage);
> >  int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux, struct bpf_map *map);
> > -void bpf_cgroup_storage_release(struct bpf_prog_aux *aux, struct bpf_map *map);
> >
> >  int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, void *value);
> >  int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
> > @@ -383,8 +386,6 @@ static inline void bpf_cgroup_storage_set(
> >       struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE]) {}
> >  static inline int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux,
> >                                           struct bpf_map *map) { return 0; }
> > -static inline void bpf_cgroup_storage_release(struct bpf_prog_aux *aux,
> > -                                           struct bpf_map *map) {}
> >  static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
> >       struct bpf_prog *prog, enum bpf_cgroup_storage_type stype) { return NULL; }
> >  static inline void bpf_cgroup_storage_free(
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 7ac3992dacfe..b14f008ad028 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -78,7 +78,7 @@ struct bpf_lpm_trie_key {
> >
> >  struct bpf_cgroup_storage_key {
> >       __u64   cgroup_inode_id;        /* cgroup inode id */
> > -     __u32   attach_type;            /* program attach type */
> > +     __u32   attach_type;            /* program attach type, unused */
> >  };
> >
> >  /* BPF syscall commands, see bpf(2) man-page for details. */
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index ac53102e244a..6b1ef4a809bb 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> > @@ -28,12 +28,14 @@ void cgroup_bpf_offline(struct cgroup *cgrp)
> >       percpu_ref_kill(&cgrp->bpf.refcnt);
> >  }
> >
> > -static void bpf_cgroup_storages_free(struct bpf_cgroup_storage *storages[])
> > +static void bpf_cgroup_storages_free(struct bpf_cgroup_storage *storages[],
> > +                                  bool *storage_reused)
> >  {
> >       enum bpf_cgroup_storage_type stype;
> >
> >       for_each_cgroup_storage_type(stype)
> > -             bpf_cgroup_storage_free(storages[stype]);
> > +             if (!storage_reused || !storage_reused[stype])
> > +                     bpf_cgroup_storage_free(storages[stype]);
> >  }
> >
> >  static int bpf_cgroup_storages_alloc(struct bpf_cgroup_storage *storages[],
> > @@ -45,7 +47,7 @@ static int bpf_cgroup_storages_alloc(struct bpf_cgroup_storage *storages[],
> >               storages[stype] = bpf_cgroup_storage_alloc(prog, stype);
> >               if (IS_ERR(storages[stype])) {
> >                       storages[stype] = NULL;
> > -                     bpf_cgroup_storages_free(storages);
> > +                     bpf_cgroup_storages_free(storages, NULL);
> >                       return -ENOMEM;
> >               }
> >       }
> > @@ -63,21 +65,24 @@ static void bpf_cgroup_storages_assign(struct bpf_cgroup_storage *dst[],
> >  }
> >
> >  static void bpf_cgroup_storages_link(struct bpf_cgroup_storage *storages[],
> > -                                  struct cgroup* cgrp,
> > -                                  enum bpf_attach_type attach_type)
> > +                                  struct cgroup *cgrp, bool *storage_reused)
> >  {
> >       enum bpf_cgroup_storage_type stype;
> >
> >       for_each_cgroup_storage_type(stype)
> > -             bpf_cgroup_storage_link(storages[stype], cgrp, attach_type);
> > +             storages[stype] =
> > +                     bpf_cgroup_storage_link(storages[stype], cgrp,
> > +                                             &storage_reused[stype]);
> >  }
> >
> > -static void bpf_cgroup_storages_unlink(struct bpf_cgroup_storage *storages[])
> > +static void bpf_cgroup_storages_unlink(struct bpf_cgroup_storage *storages[],
> > +                                    bool *storage_reused)
> >  {
> >       enum bpf_cgroup_storage_type stype;
> >
> >       for_each_cgroup_storage_type(stype)
> > -             bpf_cgroup_storage_unlink(storages[stype]);
> > +             if (!storage_reused || !storage_reused[stype])
> > +                     bpf_cgroup_storage_unlink(storages[stype]);
> >  }
> >
> >  /* Called when bpf_cgroup_link is auto-detached from dying cgroup.
> > @@ -101,22 +106,23 @@ static void cgroup_bpf_release(struct work_struct *work)
> >       struct cgroup *p, *cgrp = container_of(work, struct cgroup,
> >                                              bpf.release_work);
> >       struct bpf_prog_array *old_array;
> > +     struct list_head *storages = &cgrp->bpf.storages;
> > +     struct bpf_cgroup_storage *storage, *stmp;
> > +
> >       unsigned int type;
> >
> >       mutex_lock(&cgroup_mutex);
> >
> >       for (type = 0; type < ARRAY_SIZE(cgrp->bpf.progs); type++) {
> >               struct list_head *progs = &cgrp->bpf.progs[type];
> > -             struct bpf_prog_list *pl, *tmp;
> > +             struct bpf_prog_list *pl, *pltmp;
> >
> > -             list_for_each_entry_safe(pl, tmp, progs, node) {
> > +             list_for_each_entry_safe(pl, pltmp, progs, node) {
> >                       list_del(&pl->node);
> >                       if (pl->prog)
> >                               bpf_prog_put(pl->prog);
> >                       if (pl->link)
> >                               bpf_cgroup_link_auto_detach(pl->link);
> > -                     bpf_cgroup_storages_unlink(pl->storage);
> > -                     bpf_cgroup_storages_free(pl->storage);
> >                       kfree(pl);
> >                       static_branch_dec(&cgroup_bpf_enabled_key);
> >               }
> > @@ -126,6 +132,11 @@ static void cgroup_bpf_release(struct work_struct *work)
> >               bpf_prog_array_free(old_array);
> >       }
> >
> > +     list_for_each_entry_safe(storage, stmp, storages, list_cg) {
> > +             bpf_cgroup_storage_unlink(storage);
> > +             bpf_cgroup_storage_free(storage);
> > +     }
> > +
> >       mutex_unlock(&cgroup_mutex);
> >
> >       for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
> > @@ -290,6 +301,8 @@ int cgroup_bpf_inherit(struct cgroup *cgrp)
> >       for (i = 0; i < NR; i++)
> >               INIT_LIST_HEAD(&cgrp->bpf.progs[i]);
> >
> > +     INIT_LIST_HEAD(&cgrp->bpf.storages);
> > +
> >       for (i = 0; i < NR; i++)
> >               if (compute_effective_progs(cgrp, i, &arrays[i]))
> >                       goto cleanup;
> > @@ -422,7 +435,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
> >       struct list_head *progs = &cgrp->bpf.progs[type];
> >       struct bpf_prog *old_prog = NULL;
> >       struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
> > -     struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
> > +     bool storage_reused[MAX_BPF_CGROUP_STORAGE_TYPE];
> >       struct bpf_prog_list *pl;
> >       int err;
> >
> > @@ -455,22 +468,22 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
> >       if (IS_ERR(pl))
> >               return PTR_ERR(pl);
> >
> > -     if (bpf_cgroup_storages_alloc(storage, prog ? : link->link.prog))
> > -             return -ENOMEM;
> > -
> >       if (pl) {
> >               old_prog = pl->prog;
> > -             bpf_cgroup_storages_unlink(pl->storage);
> > -             bpf_cgroup_storages_assign(old_storage, pl->storage);
> >       } else {
> >               pl = kmalloc(sizeof(*pl), GFP_KERNEL);
> > -             if (!pl) {
> > -                     bpf_cgroup_storages_free(storage);
> > +             if (!pl)
> >                       return -ENOMEM;
> > -             }
> > +
> >               list_add_tail(&pl->node, progs);
> >       }
> >
> > +     err = bpf_cgroup_storages_alloc(storage, prog ? : link->link.prog);
> > +     if (err)
> > +             goto cleanup;
> > +
> > +     bpf_cgroup_storages_link(storage, cgrp, storage_reused);
> > +
> >       pl->prog = prog;
> >       pl->link = link;
> >       bpf_cgroup_storages_assign(pl->storage, storage);
> > @@ -478,24 +491,24 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
> >
> >       err = update_effective_progs(cgrp, type);
> >       if (err)
> > -             goto cleanup;
> > +             goto cleanup_unlink;
> >
> > -     bpf_cgroup_storages_free(old_storage);
> >       if (old_prog)
> >               bpf_prog_put(old_prog);
> >       else
> >               static_branch_inc(&cgroup_bpf_enabled_key);
> > -     bpf_cgroup_storages_link(pl->storage, cgrp, type);
> >       return 0;
> >
> > +cleanup_unlink:
> > +     bpf_cgroup_storages_unlink(storage, storage_reused);
> > +
> I still failed to understand why there is a need to do this dance
> that always link/publish first and then unlink/unpublish during failure.
> It causes all these changes to add and track "storage_reused" params
> in a few functions for handling this one failure. That also requires
> to introduce the cgroup_storage_lookup_insert().
>
> Going back to my earlier comment in v2 which I didn't here any feedback:
>
> **** snippet ****
> >> lookup old, found=>reuse, not-found=>alloc.
> >>
> >> Only publish the new storage after the attach has succeeded.
> *** snippet ****
>
> I try to put them in code here (uncompiled code).  wdyt?
>
> static int bpf_cgroup_storages_alloc(struct bpf_cgroup_storage *storages[],
>                                      struct bpf_cgroup_storage *new_storages[],
>                                      struct bpf_prog *prog,
>                                      struct cgroup *cgrp)
> {
>         enum bpf_cgroup_storage_type stype;
>         struct bpf_cgroup_storage_key key;
>         struct bpf_map *map;
>
>         key.cgroup_inode_id = cgroup_id(cgrp);
>         key.attach_type = 0;
>
>         for_each_cgroup_storage_type(stype) {
>                 map = prog->aux->cgroup_storage[stype];
>                 if (!map)
>                         continue;
>
>                 storages[stype] = cgroup_storage_lookup((void *)map, &key, false);
>                 if (!storages[stype]) {
>                         struct bpf_cgroup_storage *new_storage;
>
>                         new_storage = bpf_cgroup_storage_alloc(prog, stype);
>                         if (IS_ERR(new_storage)) {
>                                 bpf_cgroup_storages_free(new_storages);
>                                 return PTR_ERR(new_storage);
>                         }
>                         storages[stype] = new_storage;
>                         new_storages[stype] = new_storage;
>                 }
>         }
>
>         return 0;
> }
>
> @@ -422,7 +439,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
>         struct list_head *progs = &cgrp->bpf.progs[type];
>         struct bpf_prog *old_prog = NULL;
>         struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
> -       struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
> +       struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
>         struct bpf_prog_list *pl;
>         int err;
>
> @@ -455,17 +472,16 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
>         if (IS_ERR(pl))
>                 return PTR_ERR(pl);
>
> -       if (bpf_cgroup_storages_alloc(storage, prog ? : link->link.prog))
> +       if (bpf_cgroup_storages_alloc(storage, new_storage,
> +                                     prog ? : link->link.prog, cgrp))
>                 return -ENOMEM;
>
>         if (pl) {
>                 old_prog = pl->prog;
> -               bpf_cgroup_storages_unlink(pl->storage);
> -               bpf_cgroup_storages_assign(old_storage, pl->storage);
>         } else {
>                 pl = kmalloc(sizeof(*pl), GFP_KERNEL);
>                 if (!pl) {
> -                       bpf_cgroup_storages_free(storage);
> +                       bpf_cgroup_storages_free(new_storage);
>                         return -ENOMEM;
>                 }
>                 list_add_tail(&pl->node, progs);
> @@ -480,12 +496,11 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
>         if (err)
>                 goto cleanup;
>
> -       bpf_cgroup_storages_free(old_storage);
>         if (old_prog)
>                 bpf_prog_put(old_prog);
>         else
>                 static_branch_inc(&cgroup_bpf_enabled_key);
> -       bpf_cgroup_storages_link(pl->storage, cgrp, type);
> +       bpf_cgroup_storages_link(new_storage, cgrp, type);
>         return 0;
>
>  cleanup:
> @@ -493,9 +508,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
>                 pl->prog = old_prog;
>                 pl->link = NULL;
>         }
> -       bpf_cgroup_storages_free(pl->storage);
> -       bpf_cgroup_storages_assign(pl->storage, old_storage);
> -       bpf_cgroup_storages_link(pl->storage, cgrp, type);
> +       bpf_cgroup_storages_free(new_storage);
>         if (!old_prog) {
>                 list_del(&pl->node);
>                 kfree(pl);
>
> [ ... ]
>
> > diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> > index 51bd5a8cb01b..78ffe69ff1d8 100644
> > --- a/kernel/bpf/local_storage.c
> > +++ b/kernel/bpf/local_storage.c
> [ ... ]
> > @@ -318,6 +313,17 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
> >  static void cgroup_storage_map_free(struct bpf_map *_map)
> >  {
> >       struct bpf_cgroup_storage_map *map = map_to_storage(_map);
> > +     struct list_head *storages = &map->list;
> > +     struct bpf_cgroup_storage *storage, *stmp;
> > +
> > +     mutex_lock(&cgroup_mutex);
> > +
> > +     list_for_each_entry_safe(storage, stmp, storages, list_map) {
> > +             bpf_cgroup_storage_unlink(storage);
> > +             bpf_cgroup_storage_free(storage);
> > +     }
> > +
> > +     mutex_unlock(&cgroup_mutex);
> >
> >       WARN_ON(!RB_EMPTY_ROOT(&map->root));
> >       WARN_ON(!list_empty(&map->list));
> > @@ -431,13 +437,10 @@ int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux, struct bpf_map *_map)
> >
> >       spin_lock_bh(&map->lock);
> >
> > -     if (map->aux && map->aux != aux)
> > -             goto unlock;
> >       if (aux->cgroup_storage[stype] &&
> >           aux->cgroup_storage[stype] != _map)
> >               goto unlock;
> >
> > -     map->aux = aux;
> Is spin_lock_bh(&map->lock) still required in this function?
>
