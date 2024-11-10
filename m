Return-Path: <bpf+bounces-44448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A0E9C3021
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 01:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791181C20B7B
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 00:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843DF20E6;
	Sun, 10 Nov 2024 00:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgrxB0oO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F43D139B;
	Sun, 10 Nov 2024 00:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731197100; cv=none; b=pyMncPSHo8HSBIzlHaaDZXPWT2+HLNa3xQSSIWCK83WE2COajkJ5iv7e9Mn333A5UUo+xBsHSXCmqyrejHeNQCr/WWlpA/TW+BShqvSsK7CYMx5jVNg2mr1rjk4mG7fTm6i4OSd/+qMYLyS3+JJy9HjXvK0kA0pIwcwwQjCS4QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731197100; c=relaxed/simple;
	bh=9Hxv7oaDUovflEet7ur6gvgvlY5JXSzLdI2t/y/Xxh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0ZQDRsMFmJdeHblpFcpQMEkI0t+lb/mcpfMkjEwR3DN8KiM+w+Zma+icECZjynYoTBLQNmEtgHunVgL0GA9FyRceV/pcKUaorcjlufXWFneAtY0p1MValUgA4oFJ/QKISHfHetBhA4o2wEYwAJ1tNNYUmd8NSd6Lmmd7lfIJKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgrxB0oO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d49ffaba6so2280582f8f.0;
        Sat, 09 Nov 2024 16:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731197096; x=1731801896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxOIfU6W1HDRqKnxFhMOr1Urekjgylv3QvfsZV7rOJA=;
        b=WgrxB0oOuMgbg1FwfwtM0QjaKQpLAVFgfeb26Me+oBZMdz/oAUiVtD2F9bz52UYQTq
         9TuSpqE0AhYtp2BXy+HaYK345UEXDcHNwkW+hMMyIabCrZuRBMcy3wWivsMZMQ/1FmLU
         ofDWT9FCQJCe1AdUE4G1RXBSveY/nIvz3znA8nNh8CtFqM4Z7QHlM0ZBF0Dwf/OsCVsg
         L5PdA8tF86lyWESIVfXc8n9OVmO+v3GN1zPeIGpLwLnZDS5FjKUq8fVc+BrqlB4shNCC
         qp5+JBMR+OEXdEuRBQSWI3R2O1JJqhdOcHMjTa3XNpj8hCqjQ4Bpy5AETyA72C49frgG
         h+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731197096; x=1731801896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxOIfU6W1HDRqKnxFhMOr1Urekjgylv3QvfsZV7rOJA=;
        b=LjajjM283pffGJ8EQFu9b7ng91aM5CjYz15OqTDlnaluaT67/ONiDoU3gYdlVn1UMa
         zYpjgciN/Ivq0yYJJhmUItuLe2HAe1+nzkdAhQk3tKfd4bJXPcq1w/Be0EJyEmAsBEZx
         NcAsOBaGaQQb9F8gd3CZnugMAh4yisbHFRLTBwGrHch3kn7VflYsz1rcoNGqWIsRxAxn
         iGDzO8DgYYuZSrpaJ/g6RZCeQP/B9VkMbs/zLeR0hPKDVSeDpzkg9Ie686e1RPcw+TC5
         hvLODn6RuhSBjO3CFAjzNg2OLA9pnxZgqup0AW7+2WzfnCaq/V9jKUPTQ2Ss5bHpiK2d
         nFvw==
X-Forwarded-Encrypted: i=1; AJvYcCWn1GvjT1a9pEt7RCqxJO9lfpEV8i1XwRk56/KP6oZ/e4cRDADZeHRV7lUYCciqNIMckQg=@vger.kernel.org, AJvYcCX0JNvWYZatcl/9s0qb+YpB0Gq6nQVfaxyz9XgNC3urAzNjZdA7nhREHcD6Oe4ntcDwu3sCAARzDRAwn8tE@vger.kernel.org
X-Gm-Message-State: AOJu0YxbWJ5IZe0cLCK3cCHbtKn708Ax073HTEUf7b9JUGC5sFW8wG7f
	N2CSNbg8GpbjWywx6W091wK7EyEED4fnNia8VlJeECPi4Qq0JEpN9MZ2sA9Ru+s8/0TesMZTA1l
	sxDs8C2VbhQ8KWTYVBy5DsQw8Fas=
X-Google-Smtp-Source: AGHT+IEfGF3G6Xrnk8yMcxNOjeLiOqXkh/P0LlvvwujkGp+/F2tyGLoCvpYeFlB/683/+y06H1dQFW2YGSdh7OzoyU4=
X-Received: by 2002:a5d:47a9:0:b0:371:8319:4dcc with SMTP id
 ffacd0b85a97d-381f1827144mr6391772f8f.2.1731197096042; Sat, 09 Nov 2024
 16:04:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108063214.578120-1-kunwu.chan@linux.dev> <CAADnVQJ8KzVdScXM=qhdT4jMrZLBPpgd+pf1Fqyc-9TFnfabAg@mail.gmail.com>
 <78012426-80d2-4d77-23c4-ae000148fadd@huaweicloud.com>
In-Reply-To: <78012426-80d2-4d77-23c4-ae000148fadd@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 9 Nov 2024 16:04:45 -0800
Message-ID: <CAADnVQK_FptUD17REjtT1wnRyxZ2dx6sZuePsJQES-q27NKKLA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Convert lpm_trie::lock to 'raw_spinlock_t'
To: Hou Tao <houtao@huaweicloud.com>
Cc: Kunwu Chan <kunwu.chan@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Sebastian Sewior <bigeasy@linutronix.de>, clrkwllms@kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	Kunwu Chan <chentao@kylinos.cn>, syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 6:46=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi Alexei,
>
> On 11/9/2024 4:22 AM, Alexei Starovoitov wrote:
> > On Thu, Nov 7, 2024 at 10:32=E2=80=AFPM Kunwu Chan <kunwu.chan@linux.de=
v> wrote:
> >> From: Kunwu Chan <chentao@kylinos.cn>
> >>
> >> When PREEMPT_RT is enabled, 'spinlock_t' becomes preemptible
> >> and bpf program has owned a raw_spinlock under a interrupt handler,
> >> which results in invalid lock acquire context.
> >>
> >> [ BUG: Invalid wait context ]
> >> 6.12.0-rc5-next-20241031-syzkaller #0 Not tainted
> >> -----------------------------
> >> swapper/0/0 is trying to lock:
> >> ffff8880261e7a00 (&trie->lock){....}-{3:3},
> >> at: trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462
> >> other info that might help us debug this:
> >> context-{3:3}
> >> 5 locks held by swapper/0/0:
> >>  #0: ffff888020bb75c8 (&vp_dev->lock){-...}-{3:3},
> >> at: vp_vring_interrupt drivers/virtio/virtio_pci_common.c:80 [inline]
> >>  #0: ffff888020bb75c8 (&vp_dev->lock){-...}-{3:3},
> >> at: vp_interrupt+0x142/0x200 drivers/virtio/virtio_pci_common.c:113
> >>  #1: ffff88814174a120 (&vb->stop_update_lock){-...}-{3:3},
> >> at: spin_lock include/linux/spinlock.h:351 [inline]
> >>  #1: ffff88814174a120 (&vb->stop_update_lock){-...}-{3:3},
> >> at: stats_request+0x6f/0x230 drivers/virtio/virtio_balloon.c:438
> >>  #2: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
> >> at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
> >>  #2: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
> >> at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
> >>  #2: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
> >> at: __queue_work+0x199/0xf50 kernel/workqueue.c:2259
> >>  #3: ffff8880b863dd18 (&pool->lock){-.-.}-{2:2},
> >> at: __queue_work+0x759/0xf50
> >>  #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
> >> at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
> >>  #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
> >> at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
> >>  #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
> >> at: __bpf_trace_run kernel/trace/bpf_trace.c:2339 [inline]
> >>  #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
> >> at: bpf_trace_run1+0x1d6/0x520 kernel/trace/bpf_trace.c:2380
> >> stack backtrace:
> >> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
> >> 6.12.0-rc5-next-20241031-syzkaller #0
> >> Hardware name: Google Compute Engine/Google Compute Engine,
> >> BIOS Google 09/13/2024
> >> Call Trace:
> >>  <IRQ>
> >>  __dump_stack lib/dump_stack.c:94 [inline]
> >>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >>  print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline=
]
> >>  check_wait_context kernel/locking/lockdep.c:4898 [inline]
> >>  __lock_acquire+0x15a8/0x2100 kernel/locking/lockdep.c:5176
> >>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
> >>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >>  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
> >>  trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462
> > This trace is from non-RT kernel where spin_lock =3D=3D raw_spin_lock.
>
> Yes. However, I think the reason for the warning is that lockdep
> considers the case is possible under PREEMPT_RT and it violates the rule
> of lock [1].
>
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/?id=3D560af5dc839eef08a273908f390cfefefb82aa04
> >
> > I don't think Hou's explanation earlier is correct.
> > https://lore.kernel.org/bpf/e14d8882-4760-7c9c-0cfc-db04eda494ee@huawei=
cloud.com/
>
> OK. Is the bpf mem allocator part OK for you ?
> >
> >>  bpf_prog_2c29ac5cdc6b1842+0x43/0x47
> >>  bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
> >>  __bpf_prog_run include/linux/filter.h:701 [inline]
> >>  bpf_prog_run include/linux/filter.h:708 [inline]
> >>  __bpf_trace_run kernel/trace/bpf_trace.c:2340 [inline]
> >>  bpf_trace_run1+0x2ca/0x520 kernel/trace/bpf_trace.c:2380
> >>  trace_workqueue_activate_work+0x186/0x1f0 include/trace/events/workqu=
eue.h:59
> >>  __queue_work+0xc7b/0xf50 kernel/workqueue.c:2338
> >>  queue_work_on+0x1c2/0x380 kernel/workqueue.c:2390
> > here irqs are disabled, but raw_spin_lock in lpm should be fine.
> >
> >>  queue_work include/linux/workqueue.h:662 [inline]
> >>  stats_request+0x1a3/0x230 drivers/virtio/virtio_balloon.c:441
> >>  vring_interrupt+0x21d/0x380 drivers/virtio/virtio_ring.c:2595
> >>  vp_vring_interrupt drivers/virtio/virtio_pci_common.c:82 [inline]
> >>  vp_interrupt+0x192/0x200 drivers/virtio/virtio_pci_common.c:113
> >>  __handle_irq_event_percpu+0x29a/0xa80 kernel/irq/handle.c:158
> >>  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
> >>  handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
> >>  handle_fasteoi_irq+0x48a/0xae0 kernel/irq/chip.c:720
> >>  generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
> >>  handle_irq arch/x86/kernel/irq.c:247 [inline]
> >>  call_irq_handler arch/x86/kernel/irq.c:259 [inline]
> >>  __common_interrupt+0x136/0x230 arch/x86/kernel/irq.c:285
> >>  common_interrupt+0xb4/0xd0 arch/x86/kernel/irq.c:278
> >>  </IRQ>
> >>
> >> Reported-by: syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com
> >> Closes: https://lore.kernel.org/bpf/6723db4a.050a0220.35b515.0168.GAE@=
google.com/
> >> Fixes: 66150d0dde03 ("bpf, lpm: Make locking RT friendly")
> >> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> >> ---
> >>  kernel/bpf/lpm_trie.c | 12 ++++++------
> >>  1 file changed, 6 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> >> index 9b60eda0f727..373cdcfa0505 100644
> >> --- a/kernel/bpf/lpm_trie.c
> >> +++ b/kernel/bpf/lpm_trie.c
> >> @@ -35,7 +35,7 @@ struct lpm_trie {
> >>         size_t                          n_entries;
> >>         size_t                          max_prefixlen;
> >>         size_t                          data_size;
> >> -       spinlock_t                      lock;
> >> +       raw_spinlock_t                  lock;
> >>  };
> > We're certainly not going back.
>
> Only switching from spinlock_t to raw_spinlock_t is not enough, running
> it under PREEMPT_RT after the change will still trigger the similar
> lockdep warning. That is because kmalloc() may acquire a spinlock_t as
> well. However, after changing the kmalloc and its variants to bpf memory
> allocator, I think the switch to raw_spinlock_t will be safe. I have
> already written a draft patch set. Will post after after polishing and
> testing it. WDYT ?

Switching lpm to bpf_mem_alloc would address the issue.
Why do you want a switch to raw_spin_lock as well?
kfree_rcu() is already done outside of the lock.

