Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7103D29F8EC
	for <lists+bpf@lfdr.de>; Fri, 30 Oct 2020 00:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgJ2XMd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Oct 2020 19:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2XMd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Oct 2020 19:12:33 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E04C0613CF;
        Thu, 29 Oct 2020 16:12:33 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id o70so3614067ybc.1;
        Thu, 29 Oct 2020 16:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f/Bc/v64iDP0ELb4JzwzGaOTdRaZ/Pl633zholMKGEQ=;
        b=rrPh9YBMHLayCIOnNBd+I557HWsz0Hjw2myKwuqoVwVRgDWZYcnTacswIiL/OF+ov2
         prOnRW4h3dS4YxLn6nPVHbNxYvsmlfnYv2Z/u20QmoRv9FCfSqxePhRWj3DRa1P6d+iO
         i7H/iz+G/2xFNEztZPA9AFQ+w5Mae7Dbp9NDcXLvcQRbXnIPT0JgNRVPtv+GyS0goH27
         fAyqCAFWxhN3l0BmRPb4oaMeRl8p5hHsJilJQDNgbj1QxpfSO6GIoTKM2zVkIEuvp9Wb
         Fzjb+lK94uGYl9J31d+bi4y37BIzhLVHZfXJ4M4g5MF6A5XZrqdcKlXOfFfgVZV3jYrf
         g/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f/Bc/v64iDP0ELb4JzwzGaOTdRaZ/Pl633zholMKGEQ=;
        b=GovOmvjAw2wlPOZZmRlhSZ94L0dEKfpzxlQ5NJlkChNvR5rfzJuhj9mqR8JmSlHuim
         1iCjJCzvqOASOStGJ1T+YB1LH8ieRheyiYmRaxQ4AVTnFnjBPzS3vT8+CAlJvM6v+01w
         DAOvLoAEkjO7Q1VGa/bEWGFQql4g2haVTIzt+qo+hQKZLkkMSJDeT6D9sJsQhoYXPlN7
         O67ODlf2pVL1KyTyZ2xTJDmS4BjLavvRSKkL+FXsWRO3d0RQ501l6Vf51wu1PpC5WPDf
         1KdDA04TLX6OrZsZ78ZSks7c5xCMmgY/XCM6SuzThxI1B7APNqD+XX8kFY8fG+leaw0z
         3/rw==
X-Gm-Message-State: AOAM531UhRswcJO7sgYvlBAGdCHukpOoP4muNIHOemJC4ziyTXUBqlfS
        BoRQa77P7Zi2Ye05oflMSquSG5EGOW4FXIK+5QQ=
X-Google-Smtp-Source: ABdhPJxvSoa9Pw97zqBolMtyoHthXRB/rqjijrszK40wG5o2sLWgEEwKv89ZKmNtRvhbDq+/AMzjd61ZkoY/lLYjCjk=
X-Received: by 2002:a25:da4e:: with SMTP id n75mr9183989ybf.425.1604013152317;
 Thu, 29 Oct 2020 16:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201027170317.2011119-1-kpsingh@chromium.org> <20201027170317.2011119-2-kpsingh@chromium.org>
In-Reply-To: <20201027170317.2011119-2-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 29 Oct 2020 16:12:20 -0700
Message-ID: <CAEf4BzatLFGpht-CiSmOfSjBY_nATZsgnWhLnUFuDgvMi4yXLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Implement task local storage
To:     KP Singh <kpsingh@chromium.org>
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

On Wed, Oct 28, 2020 at 9:17 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> Similar to bpf_local_storage for sockets and inodes add local storage
> for task_struct.
>
> The life-cycle of storage is managed with the life-cycle of the
> task_struct.  i.e. the storage is destroyed along with the owning task
> with a callback to the bpf_task_storage_free from the task_free LSM
> hook.
>
> The BPF LSM allocates an __rcu pointer to the bpf_local_storage in
> the security blob which are now stackable and can co-exist with other
> LSMs.
>
> The userspace map operations can be done by using a pid fd as a key
> passed to the lookup, update and delete operations.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---

Please also double-check all three of get_pid_task() uses, you need to
put_task_struct() in all cases.

>  include/linux/bpf_lsm.h                       |  23 ++
>  include/linux/bpf_types.h                     |   1 +
>  include/uapi/linux/bpf.h                      |  39 +++
>  kernel/bpf/Makefile                           |   1 +
>  kernel/bpf/bpf_lsm.c                          |   4 +
>  kernel/bpf/bpf_task_storage.c                 | 327 ++++++++++++++++++
>  kernel/bpf/syscall.c                          |   3 +-
>  kernel/bpf/verifier.c                         |  10 +
>  security/bpf/hooks.c                          |   2 +
>  .../bpf/bpftool/Documentation/bpftool-map.rst |   3 +-
>  tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
>  tools/bpf/bpftool/map.c                       |   4 +-
>  tools/include/uapi/linux/bpf.h                |  39 +++
>  tools/lib/bpf/libbpf_probes.c                 |   2 +
>  14 files changed, 456 insertions(+), 4 deletions(-)
>  create mode 100644 kernel/bpf/bpf_task_storage.c

Please split out bpftool, bpftool documentation, and libbpf changes
into their respective patches.

[...]

> + *
> + * int bpf_task_storage_delete(struct bpf_map *map, void *task)

please use long for return type, as all other helpers (except
bpf_inode_storage_delete, which would be nice to fix as well) do.

> + *     Description
> + *             Delete a bpf_local_storage from a *task*.
> + *     Return
> + *             0 on success.
> + *
> + *             **-ENOENT** if the bpf_local_storage cannot be found.
>   */

[...]

> +
> +void bpf_task_storage_free(struct task_struct *task)
> +{
> +       struct bpf_local_storage_elem *selem;
> +       struct bpf_local_storage *local_storage;
> +       bool free_task_storage = false;
> +       struct bpf_storage_blob *bsb;
> +       struct hlist_node *n;
> +
> +       bsb = bpf_task(task);
> +       if (!bsb)
> +               return;
> +
> +       rcu_read_lock();
> +
> +       local_storage = rcu_dereference(bsb->storage);
> +       if (!local_storage) {
> +               rcu_read_unlock();
> +               return;
> +       }
> +
> +       /* Netiher the bpf_prog nor the bpf-map's syscall

typo: Neither

> +        * could be modifying the local_storage->list now.
> +        * Thus, no elem can be added-to or deleted-from the
> +        * local_storage->list by the bpf_prog or by the bpf-map's syscall.
> +        *
> +        * It is racing with bpf_local_storage_map_free() alone
> +        * when unlinking elem from the local_storage->list and
> +        * the map's bucket->list.
> +        */
> +       raw_spin_lock_bh(&local_storage->lock);
> +       hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
> +               /* Always unlink from map before unlinking from
> +                * local_storage.
> +                */
> +               bpf_selem_unlink_map(selem);
> +               free_task_storage = bpf_selem_unlink_storage_nolock(
> +                       local_storage, selem, false);

this will override the previous value of free_task_storage. Did you
intend to do || here?

> +       }
> +       raw_spin_unlock_bh(&local_storage->lock);
> +       rcu_read_unlock();
> +
> +       /* free_task_storage should always be true as long as
> +        * local_storage->list was non-empty.
> +        */
> +       if (free_task_storage)
> +               kfree_rcu(local_storage, rcu);
> +}
> +

[...]
