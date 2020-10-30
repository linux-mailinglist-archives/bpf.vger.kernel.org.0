Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D712A0399
	for <lists+bpf@lfdr.de>; Fri, 30 Oct 2020 12:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgJ3LC1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Oct 2020 07:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgJ3LCY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Oct 2020 07:02:24 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00B0C0613D2
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2020 04:02:23 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 2so6355946ljj.13
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2020 04:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g4U1X0cuCQq2FJSQGKH/y0J4HgoYleMzFhYfqXT6nxc=;
        b=JSwXE9sBPDBUqg2kuEuZw1n+pERLqzwPWDFohb2kNYPyXt+bjyF+ILxAmh39Qoa3GU
         cLOipdPwlMWuEQNz0tiRBRY/I66ddjuP0kaCeqF8RQEgQvjBatJBDF9a485IKk61Ct0y
         sqZ7j2iJ1v8KcissNCU0QYlgKFLfT8RgTBmSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g4U1X0cuCQq2FJSQGKH/y0J4HgoYleMzFhYfqXT6nxc=;
        b=KQGPPptMGzQd3mVB+dUxgfxRyq5ZYlwIcToYx1mHC9V5ETLHTM1ZiGNe+ajI2utIwd
         z6QRkuRgmJa50IuJF8ClB6foFIbaJSRoP2s3gQuqoBZFbHuQPfEBCJh0HMNvQNNjoeKF
         jWtgk1v8jfIB8ldPY3wkxlzBzVKn31voN9c0gJYEEFuyI0J2/5y4L0jzVFvtuZYG06mK
         7t+IEX3zYYo9IspiGZQS+ZjQqq6PwQsnGIuTDT7vCFgidF8Gln5J6JErcMAFaR7bKn4Z
         faydeNG18kvlbbwbXsrT/z73pHwklJaQtP+vnhwaiVPa93oQ6F+uDk8tToIpcAB/FUWB
         DhgA==
X-Gm-Message-State: AOAM531+BuTAyFARpTL1hTcTw1rOUgKXzzw5gN+i0H2XtSgJXhdcgjr3
        5lwnpIWdBOLX0tQSR0YhzA5hTwNm+TgPVbrTC/Kq6g==
X-Google-Smtp-Source: ABdhPJy1jGh/rtq4K33qnnzBvC7eTnFrN+rfLl3SG/zcWBoCosXpOO4VlL2ZklJLdz4ALEvuzL4kudPxxv3GLbQ2TOc=
X-Received: by 2002:a05:651c:1345:: with SMTP id j5mr819011ljb.430.1604055742294;
 Fri, 30 Oct 2020 04:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201027170317.2011119-1-kpsingh@chromium.org>
 <20201027170317.2011119-2-kpsingh@chromium.org> <CAEf4BzatLFGpht-CiSmOfSjBY_nATZsgnWhLnUFuDgvMi4yXLw@mail.gmail.com>
In-Reply-To: <CAEf4BzatLFGpht-CiSmOfSjBY_nATZsgnWhLnUFuDgvMi4yXLw@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Fri, 30 Oct 2020 12:02:11 +0100
Message-ID: <CACYkzJ6iEVQ1GNexBH58jtPrtwzrYWi87sj_jsEaGuWypxbA4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Implement task local storage
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 30, 2020 at 12:12 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Oct 28, 2020 at 9:17 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > Similar to bpf_local_storage for sockets and inodes add local storage
> > for task_struct.
> >
> > The life-cycle of storage is managed with the life-cycle of the
> > task_struct.  i.e. the storage is destroyed along with the owning task
> > with a callback to the bpf_task_storage_free from the task_free LSM
> > hook.
> >
> > The BPF LSM allocates an __rcu pointer to the bpf_local_storage in
> > the security blob which are now stackable and can co-exist with other
> > LSMs.
> >
> > The userspace map operations can be done by using a pid fd as a key
> > passed to the lookup, update and delete operations.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
>
> Please also double-check all three of get_pid_task() uses, you need to
> put_task_struct() in all cases.

Done, Martin also pointed it out.

>
> >  include/linux/bpf_lsm.h                       |  23 ++
> >  include/linux/bpf_types.h                     |   1 +
> >  include/uapi/linux/bpf.h                      |  39 +++
> >  kernel/bpf/Makefile                           |   1 +

[...]

>
> > + *
> > + * int bpf_task_storage_delete(struct bpf_map *map, void *task)
>
> please use long for return type, as all other helpers (except
> bpf_inode_storage_delete, which would be nice to fix as well) do.

Done. Will also fix the return value of bpf_inode_storage_delete in a
separate patch.

>
> > + *     Description
> > + *             Delete a bpf_local_storage from a *task*.
> > + *     Return
> > + *             0 on success.

[...]

> > +               return;
> > +       }
> > +
> > +       /* Netiher the bpf_prog nor the bpf-map's syscall
>
> typo: Neither

Thanks. Fixed.

>
> > +        * could be modifying the local_storage->list now.
> > +        * Thus, no elem can be added-to or deleted-from the
> > +        * local_storage->list by the bpf_prog or by the bpf-map's syscall.
> > +        *
> > +        * It is racing with bpf_local_storage_map_free() alone
> > +        * when unlinking elem from the local_storage->list and
> > +        * the map's bucket->list.
> > +        */
> > +       raw_spin_lock_bh(&local_storage->lock);
> > +       hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
> > +               /* Always unlink from map before unlinking from
> > +                * local_storage.
> > +                */
> > +               bpf_selem_unlink_map(selem);
> > +               free_task_storage = bpf_selem_unlink_storage_nolock(
> > +                       local_storage, selem, false);
>
> this will override the previous value of free_task_storage. Did you
> intend to do || here?

in bpf_selem_unlink_storage_nolock:

  free_local_storage = hlist_is_singular_node(&selem->snode,
  &local_storage->list);

free_local_storage is only true when the linked list has one element, so it does
not really matter. I guess we could use the "||" here for correctness, and if
we do that, we should also update the other local storages.

>
> > +       }
> > +       raw_spin_unlock_bh(&local_storage->lock);
> > +       rcu_read_unlock();
> > +
> > +       /* free_task_storage should always be true as long as
> > +        * local_storage->list was non-empty.
> > +        */
> > +       if (free_task_storage)
> > +               kfree_rcu(local_storage, rcu);
> > +}
> > +
>
> [...]
