Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D95EC164965
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2020 17:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBSQCX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Feb 2020 11:02:23 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44477 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBSQCX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Feb 2020 11:02:23 -0500
Received: by mail-lf1-f66.google.com with SMTP id v201so501499lfa.11
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2020 08:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6n7FGTFZf1uL4ahqCHz4P8jrbgn99ewq7X+E5paM98A=;
        b=Gn4nXZlydzEw2XTB8TPk8za8FlqHs0woDmdqWtei+FkSF1SYPl2Rdpqif4+yt9NmVZ
         2umZm2oci3kbzr1GzkiytQQQjlQDLwfge1piMoLUTCh/8CE80XXfsthiqMtUcABLZ7mk
         JoNwaO4FT/e2g31py0m6ISeyG+g2XezzYE/CkkCydZ7F6iHS2k3J4NMR52wjfIWPMdje
         cvxhyI3dLTLZmpLFw44ccTWh2NAmg26EYbulG4wHPkCkpNeArV0+GFC8Rn68MtyL8tQD
         4CrjT1sfkMRGspJRl1bJ/Z3upiJuicG7IPAjZVozyRXyHpLS2s33Js2ipZYM5+SUni5O
         3NjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6n7FGTFZf1uL4ahqCHz4P8jrbgn99ewq7X+E5paM98A=;
        b=qkgo+IaP2zGEV8AKXZRZ0Yy5jsldYsLfkV3wddlXWMtm13uF+Ml85oZ2a2Qf84ANLb
         rM3PGV5+kMEZ/hywgK0jFLulRC6WxDV8F+BO9c4r8fdsjxxxLYCtg5QNuSlmp6Dzc99a
         lNM9YSTIxrzMYBH2+sZXUVEiz6ebD10kE4BNGZj44zFWZdKEIW0H9uKfVQrJ/DK7d0mA
         qnckOkXwfev9GT5rvFZ9N5Ro+3zgEnqGWbvgIkpkiLUQ6nMBVgShCQHA6jLQ+9zWg21h
         opOR7DN3gFJioxozyiicZlkV+r4dKc4aput0RFcEBEU+fMJKdEOr350GoJ7ow7211gsI
         N5cQ==
X-Gm-Message-State: APjAAAWmnBtYVBKpIgGu5B9H8lydpPHpLWmK6nDfRpERTKPxTl69mZ29
        AVWG8TJzcLCF0yJAtJg1qXhraQAFOEu9x46N+dD/8GUeIEiTiA==
X-Google-Smtp-Source: APXvYqxlQ628KPTU03TRtNdLYe873Jh3KWl+sAX6ZuiIT0NDLM5qI9BRGLtYjSpBTOrqOUhW1/fc8cuuG/WL67+1yo4=
X-Received: by 2002:ac2:59dd:: with SMTP id x29mr13678449lfn.95.1582128139758;
 Wed, 19 Feb 2020 08:02:19 -0800 (PST)
MIME-Version: 1.0
References: <20200219064817.3636079-1-yhs@fb.com>
In-Reply-To: <20200219064817.3636079-1-yhs@fb.com>
From:   Brian Vazquez <brianvv@google.com>
Date:   Wed, 19 Feb 2020 08:02:08 -0800
Message-ID: <CAMzD94Spc019gYJ8AdzYRvRDO3koQKqr8DJOkN2cduL8QBC0AQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix a potential deadlock with bpf_map_do_batch
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Acked-by: Brian Vazquez <brianvv@google.com>

On Tue, Feb 18, 2020 at 10:48 PM Yonghong Song <yhs@fb.com> wrote:
>
> Commit 057996380a42 ("bpf: Add batch ops to all htab bpf map")
> added lookup_and_delete batch operation for hash table.
> The current implementation has bpf_lru_push_free() inside
> the bucket lock, which may cause a deadlock.
>
> syzbot reports:
>    -> #2 (&htab->buckets[i].lock#2){....}:
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:159
>        htab_lru_map_delete_node+0xce/0x2f0 kernel/bpf/hashtab.c:593
>        __bpf_lru_list_shrink_inactive kernel/bpf/bpf_lru_list.c:220 [inline]
>        __bpf_lru_list_shrink+0xf9/0x470 kernel/bpf/bpf_lru_list.c:266
>        bpf_lru_list_pop_free_to_local kernel/bpf/bpf_lru_list.c:340 [inline]
>        bpf_common_lru_pop_free kernel/bpf/bpf_lru_list.c:447 [inline]
>        bpf_lru_pop_free+0x87c/0x1670 kernel/bpf/bpf_lru_list.c:499
>        prealloc_lru_pop+0x2c/0xa0 kernel/bpf/hashtab.c:132
>        __htab_lru_percpu_map_update_elem+0x67e/0xa90 kernel/bpf/hashtab.c:1069
>        bpf_percpu_hash_update+0x16e/0x210 kernel/bpf/hashtab.c:1585
>        bpf_map_update_value.isra.0+0x2d7/0x8e0 kernel/bpf/syscall.c:181
>        generic_map_update_batch+0x41f/0x610 kernel/bpf/syscall.c:1319
>        bpf_map_do_batch+0x3f5/0x510 kernel/bpf/syscall.c:3348
>        __do_sys_bpf+0x9b7/0x41e0 kernel/bpf/syscall.c:3460
>        __se_sys_bpf kernel/bpf/syscall.c:3355 [inline]
>        __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:3355
>        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
>    -> #0 (&loc_l->lock){....}:
>        check_prev_add kernel/locking/lockdep.c:2475 [inline]
>        check_prevs_add kernel/locking/lockdep.c:2580 [inline]
>        validate_chain kernel/locking/lockdep.c:2970 [inline]
>        __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3954
>        lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:159
>        bpf_common_lru_push_free kernel/bpf/bpf_lru_list.c:516 [inline]
>        bpf_lru_push_free+0x250/0x5b0 kernel/bpf/bpf_lru_list.c:555
>        __htab_map_lookup_and_delete_batch+0x8d4/0x1540 kernel/bpf/hashtab.c:1374
>        htab_lru_map_lookup_and_delete_batch+0x34/0x40 kernel/bpf/hashtab.c:1491
>        bpf_map_do_batch+0x3f5/0x510 kernel/bpf/syscall.c:3348
>        __do_sys_bpf+0x1f7d/0x41e0 kernel/bpf/syscall.c:3456
>        __se_sys_bpf kernel/bpf/syscall.c:3355 [inline]
>        __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:3355
>        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
>     Possible unsafe locking scenario:
>
>           CPU0                    CPU2
>           ----                    ----
>      lock(&htab->buckets[i].lock#2);
>                                   lock(&l->lock);
>                                   lock(&htab->buckets[i].lock#2);
>      lock(&loc_l->lock);
>
>     *** DEADLOCK ***
>
> To fix the issue, for htab_lru_map_lookup_and_delete_batch() in CPU0,
> let us do bpf_lru_push_free() out of the htab bucket lock. This can
> avoid the above deadlock scenario.
>
> Fixes: 057996380a42 ("bpf: Add batch ops to all htab bpf map")
> Reported-by: syzbot+a38ff3d9356388f2fb83@syzkaller.appspotmail.com
> Reported-by: syzbot+122b5421d14e68f29cd1@syzkaller.appspotmail.com
> Suggested-by: Hillf Danton <hdanton@sina.com>
> Suggested-by: Martin KaFai Lau <kafai@fb.com>
> Cc: Brian Vazquez <brianvv@google.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/bpf/hashtab.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 2d182c4ee9d9..59083061dd3a 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -56,6 +56,7 @@ struct htab_elem {
>                         union {
>                                 struct bpf_htab *htab;
>                                 struct pcpu_freelist_node fnode;
> +                               struct htab_elem *link;
>                         };
>                 };
>         };
> @@ -1255,6 +1256,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>         void __user *uvalues = u64_to_user_ptr(attr->batch.values);
>         void __user *ukeys = u64_to_user_ptr(attr->batch.keys);
>         void *ubatch = u64_to_user_ptr(attr->batch.in_batch);
> +       struct htab_elem *node_to_free = NULL;
>         u32 batch, max_count, size, bucket_size;
>         u64 elem_map_flags, map_flags;
>         struct hlist_nulls_head *head;
> @@ -1370,9 +1372,13 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>                 }
>                 if (do_delete) {
>                         hlist_nulls_del_rcu(&l->hash_node);
> -                       if (is_lru_map)
> -                               bpf_lru_push_free(&htab->lru, &l->lru_node);
> -                       else
> +                       if (is_lru_map) {
> +                               /* link to-be-freed elements together so
> +                                * they can freed outside bucket lock region.
> +                                */
> +                               l->link = node_to_free;
> +                               node_to_free = l;
> +                       } else
>                                 free_htab_elem(htab, l);
>                 }
>                 dst_key += key_size;
> @@ -1380,6 +1386,13 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>         }
>
>         raw_spin_unlock_irqrestore(&b->lock, flags);
> +
> +       while (node_to_free) {
> +               l = node_to_free;
> +               node_to_free = node_to_free->link;
> +               bpf_lru_push_free(&htab->lru, &l->lru_node);
> +       }
> +
>         /* If we are not copying data, we can go to next bucket and avoid
>          * unlocking the rcu.
>          */
> --
> 2.17.1
>
