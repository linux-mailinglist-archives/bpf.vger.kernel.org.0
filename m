Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 870F71652F8
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2020 00:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgBSXNh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Feb 2020 18:13:37 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45830 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgBSXNh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Feb 2020 18:13:37 -0500
Received: by mail-lj1-f195.google.com with SMTP id e18so2141455ljn.12
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2020 15:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MY71HOISQ10TljJZzXktEtr8dOSsB0TCoO4yis4UFsM=;
        b=VW72Clqt3e58yTz7c3Q6qhz5L6B2BOlF5kps3Ls0dRGyxe8EkiTv83GLrc9ko1k5gc
         5q310GXMLMuqpeX/Mr25fp10/kxC8K9Riy8in0pRo8bYVM8ug/V5PA/bZGmh+s6bSFoE
         Oh30fGtBOwNWt6V0f8n3S/IpTZ5cbK/bHCwfQz/TkK0SxxheMj1B3LJdrq8szuHIU9JY
         ro2Zt4BAFGtRxIUMboGXyf86ywExxj7CyyaPyDa8n7w7LYpUNi9NaOFS1mi86YMKKWkO
         mxQMU1oHNZS3w+LBNgXGcFcPDdx6groapZOgPVvYeuiw6mI4YmUekIvecbgO73zkYA7S
         45og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MY71HOISQ10TljJZzXktEtr8dOSsB0TCoO4yis4UFsM=;
        b=DxWIGf+DH+XEL3z4h9mSWvey2GYOEXdxh7hjZlSSiLLdj2AHE6a9AwDJqoheGuLth8
         VNGlN60Ltmul856pmbpCDzXWTjfKRPelmAz4eDbX8/UUE0F0W4tiF4RgNCMKDTSesHRI
         QUOnxXtHQcPLJ/sO0zz1NTZ4MuHxcfgX5GCHN5dIbRtBEj4tuFMn3bKxT0cz+I/LuPTs
         kgYcOoXsqRVFnLVuELzc65A7qufWoJ8ue+cg9syF8lR+ei8Wq8pZ0VET//XdLoRmQ7IV
         ZIxGeyIPNV6THQuVnnF4fDH+E4c2lhN1E0ekPf7Q881eIraC+sGQZO24kubICrxNISDm
         PVnw==
X-Gm-Message-State: APjAAAW0rAnkbcCOAjfaVT7OJQ5mj2ivfaIoRpmKiAM6eW1+DIlIwLXD
        tM7YO9G0JVgVIdeFOr/7/SquiEd7MOspgbi9vG4=
X-Google-Smtp-Source: APXvYqw22/79izZXDZJsm8JPtRU66Tj21oE9JowjY4i2jDhqC6wEno8us+/nF235dD1q7flLwgqJXAoJj/pg1AUP+CM=
X-Received: by 2002:a2e:8145:: with SMTP id t5mr17424274ljg.144.1582154014446;
 Wed, 19 Feb 2020 15:13:34 -0800 (PST)
MIME-Version: 1.0
References: <20200219193106.2246922-1-yhs@fb.com> <20200219194959.v7zamotbfkmwvvcd@kafai-mbp>
In-Reply-To: <20200219194959.v7zamotbfkmwvvcd@kafai-mbp>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 19 Feb 2020 15:13:23 -0800
Message-ID: <CAADnVQL5ZYJVZr=vgBYua+0E2btMnz+QeXiiraKvb28Ape493g@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf: fix a potential deadlock with bpf_map_do_batch
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 19, 2020 at 11:50 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Feb 19, 2020 at 11:31:06AM -0800, Yonghong Song wrote:
> > Commit 057996380a42 ("bpf: Add batch ops to all htab bpf map")
> > added lookup_and_delete batch operation for hash table.
> > The current implementation has bpf_lru_push_free() inside
> > the bucket lock, which may cause a deadlock.
> >
> > syzbot reports:
> >    -> #2 (&htab->buckets[i].lock#2){....}:
> >        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >        _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:159
> >        htab_lru_map_delete_node+0xce/0x2f0 kernel/bpf/hashtab.c:593
> >        __bpf_lru_list_shrink_inactive kernel/bpf/bpf_lru_list.c:220 [inline]
> >        __bpf_lru_list_shrink+0xf9/0x470 kernel/bpf/bpf_lru_list.c:266
> >        bpf_lru_list_pop_free_to_local kernel/bpf/bpf_lru_list.c:340 [inline]
> >        bpf_common_lru_pop_free kernel/bpf/bpf_lru_list.c:447 [inline]
> >        bpf_lru_pop_free+0x87c/0x1670 kernel/bpf/bpf_lru_list.c:499
> >        prealloc_lru_pop+0x2c/0xa0 kernel/bpf/hashtab.c:132
> >        __htab_lru_percpu_map_update_elem+0x67e/0xa90 kernel/bpf/hashtab.c:1069
> >        bpf_percpu_hash_update+0x16e/0x210 kernel/bpf/hashtab.c:1585
> >        bpf_map_update_value.isra.0+0x2d7/0x8e0 kernel/bpf/syscall.c:181
> >        generic_map_update_batch+0x41f/0x610 kernel/bpf/syscall.c:1319
> >        bpf_map_do_batch+0x3f5/0x510 kernel/bpf/syscall.c:3348
> >        __do_sys_bpf+0x9b7/0x41e0 kernel/bpf/syscall.c:3460
> >        __se_sys_bpf kernel/bpf/syscall.c:3355 [inline]
> >        __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:3355
> >        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
> >        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> >    -> #0 (&loc_l->lock){....}:
> >        check_prev_add kernel/locking/lockdep.c:2475 [inline]
> >        check_prevs_add kernel/locking/lockdep.c:2580 [inline]
> >        validate_chain kernel/locking/lockdep.c:2970 [inline]
> >        __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3954
> >        lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
> >        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >        _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:159
> >        bpf_common_lru_push_free kernel/bpf/bpf_lru_list.c:516 [inline]
> >        bpf_lru_push_free+0x250/0x5b0 kernel/bpf/bpf_lru_list.c:555
> >        __htab_map_lookup_and_delete_batch+0x8d4/0x1540 kernel/bpf/hashtab.c:1374
> >        htab_lru_map_lookup_and_delete_batch+0x34/0x40 kernel/bpf/hashtab.c:1491
> >        bpf_map_do_batch+0x3f5/0x510 kernel/bpf/syscall.c:3348
> >        __do_sys_bpf+0x1f7d/0x41e0 kernel/bpf/syscall.c:3456
> >        __se_sys_bpf kernel/bpf/syscall.c:3355 [inline]
> >        __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:3355
> >        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
> >        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> >     Possible unsafe locking scenario:
> >
> >           CPU0                    CPU2
> >           ----                    ----
> >      lock(&htab->buckets[i].lock#2);
> >                                   lock(&l->lock);
> >                                   lock(&htab->buckets[i].lock#2);
> >      lock(&loc_l->lock);
> >
> >     *** DEADLOCK ***
> >
> > To fix the issue, for htab_lru_map_lookup_and_delete_batch() in CPU0,
> > let us do bpf_lru_push_free() out of the htab bucket lock. This can
> > avoid the above deadlock scenario.
> >
> > Fixes: 057996380a42 ("bpf: Add batch ops to all htab bpf map")
> > Reported-by: syzbot+a38ff3d9356388f2fb83@syzkaller.appspotmail.com
> > Reported-by: syzbot+122b5421d14e68f29cd1@syzkaller.appspotmail.com
> > Suggested-by: Hillf Danton <hdanton@sina.com>
> > Suggested-by: Martin KaFai Lau <kafai@fb.com>
> > Acked-by: Brian Vazquez <brianvv@google.com>
> > Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
> >  kernel/bpf/hashtab.c | 34 +++++++++++++++++++++++++++++++---
> >  1 file changed, 31 insertions(+), 3 deletions(-)
> >
> > Changelog:
> >   v2 -> v3:
> >      . changed variable name, fixed reverse Christmas tree
> >        coding style and added more comments, from Martin.
> Acked-by: Martin KaFai Lau <kafai@fb.com>

It conflicts with Brian's fix. Please respin.
