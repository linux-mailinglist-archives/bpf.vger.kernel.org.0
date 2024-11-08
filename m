Return-Path: <bpf+bounces-44390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9049C266A
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 21:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9020B2352E
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 20:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CB61C1F2B;
	Fri,  8 Nov 2024 20:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0Y2guDw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF6E1AA1C1;
	Fri,  8 Nov 2024 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097376; cv=none; b=L30bu3Lfv6KTcRg1buP9nP1olaBd6HrFuSlLNiJhaqxZh1OisFg9HOOHCGZQkAr4/hGm8nkv26cYNK0byNaoL/gFtU3RroCMreMvACLx2s3B8g7Pff/zsl7MsKnIbztdBWIS2PMUI/CqMZd6uENGKdU/RR6Zn6J0cDKfqWtXNz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097376; c=relaxed/simple;
	bh=XJU61EN1IqZaoeR1rSzm9dj0fle8xMBiTlgB72uJXus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tte/cCm0yVul0du51uRBRV6+Ze1nr5BVJ1nDcCe/pbTVNykKG0tJHAVgsSDG2YHmaky9FmpbDK7E72T0AxyprCo85lUBOtMC7cy3Tqz6I3IQlRDsIx/qJwKW+htq/5FMV3YQtmqZNvSEqha09Cu3TqVdKNMqbfVwqTwO1wniTFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0Y2guDw; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4314c452180so21177125e9.0;
        Fri, 08 Nov 2024 12:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731097373; x=1731702173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/xUMGKi2SD6hf3c1UEJz+hJwgmvF3CxZFQ3ymqr9uE=;
        b=h0Y2guDwQa+zIHHx9V9M5qx0NkK6t3VbhW7ISIiGEXNXDiC21UqiPCeB119EPsTn0e
         NeWEZJhzCwGAoPM6WzBOX1UhGNfliwlFJuiFhyd9hj6yegjuGtlWx2g5jes18SG2NMTV
         2P3IIVWHuKhWdIFsvAQnCbFi2boUQsIH15mvJurcPuiUai/zsJSi6rrBoYSuDVZQ9Fow
         As0f3sZvBOAjZoshcyECebsJLmZpuoWyqqiq0PMAg93/Icrt1V5vm1bWajIlzMMtQ3Sv
         kwYbHVvR9/GKoUYZas648o8Zx/vLJC8AbelW/kKpwGTYcJk7LCI+lYfuwoBrPllnp2f+
         NNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731097373; x=1731702173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/xUMGKi2SD6hf3c1UEJz+hJwgmvF3CxZFQ3ymqr9uE=;
        b=nNBv6LaWsZCovJp10JhnWICWtB/W9IrDGzJMAy59GSamETx6yIRemKQinUWzUaS7h5
         /Mr0AJ3EP6R25Eu22uiltIMXUMlF0AOg6NHI3Q/0lGkmoxwSMUE41Icw2gLv0u+922MV
         EgtUT7/+Yabs28Q3XTcfMVgbOYLOXgZdkVHDYnjpat3s96oYwYDahG/KbKt7vtIeG6/N
         MITcn3Wo8+bouxYjbv4r4T3xsT7Lo0+qxejZ0CopEHi00H2hmOkdM21GbSjhhvGOt8WT
         oVHJookP0g41cPwu3RN3LYfaOhEY0A8wI0a0BP1ta+Lk+ZBAb4gGy+e5JROUZKK4U8U9
         uJoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL7imeKpef3FYLY3k9fArNXyEDOMALpL/N5PVb+5Qobg8YScENE9lU07nSmTrkz0YTC6w=@vger.kernel.org, AJvYcCXiArkjKMFkBaPE1fdtJrQXR3VSmqCjyh8NEm4ab6myRe43b+90b4NLefmGMelKiKCxGEVpMaMT69xT78SR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzux6cqt5f294gu1sJeUw2nuU9GbUp5SqEbB/0OpB6CKs69u5+M
	AK88756CnZWZf3Gh896OAgm8pWqXfe2pcySvyQj90jUVrUJ7bVjGShVjE/5OGvtJ6hhmAAX2Zwo
	KHReM3EthRon+nC/C/SSuWg5nrt8=
X-Google-Smtp-Source: AGHT+IGUHee0ozy2XcI20tavIZRFKwh+dhcBCCR60pmA9ssCOt/7grB0zNc6bidarNowdjUxSilPi6pqfzPAsuINZCQ=
X-Received: by 2002:a5d:64c7:0:b0:37c:fdc8:77ab with SMTP id
 ffacd0b85a97d-381f0f57f22mr4424747f8f.7.1731097372614; Fri, 08 Nov 2024
 12:22:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108063214.578120-1-kunwu.chan@linux.dev>
In-Reply-To: <20241108063214.578120-1-kunwu.chan@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Nov 2024 12:22:41 -0800
Message-ID: <CAADnVQJ8KzVdScXM=qhdT4jMrZLBPpgd+pf1Fqyc-9TFnfabAg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Convert lpm_trie::lock to 'raw_spinlock_t'
To: Kunwu Chan <kunwu.chan@linux.dev>, Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Sebastian Sewior <bigeasy@linutronix.de>, clrkwllms@kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	Kunwu Chan <chentao@kylinos.cn>, syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 10:32=E2=80=AFPM Kunwu Chan <kunwu.chan@linux.dev> w=
rote:
>
> From: Kunwu Chan <chentao@kylinos.cn>
>
> When PREEMPT_RT is enabled, 'spinlock_t' becomes preemptible
> and bpf program has owned a raw_spinlock under a interrupt handler,
> which results in invalid lock acquire context.
>
> [ BUG: Invalid wait context ]
> 6.12.0-rc5-next-20241031-syzkaller #0 Not tainted
> -----------------------------
> swapper/0/0 is trying to lock:
> ffff8880261e7a00 (&trie->lock){....}-{3:3},
> at: trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462
> other info that might help us debug this:
> context-{3:3}
> 5 locks held by swapper/0/0:
>  #0: ffff888020bb75c8 (&vp_dev->lock){-...}-{3:3},
> at: vp_vring_interrupt drivers/virtio/virtio_pci_common.c:80 [inline]
>  #0: ffff888020bb75c8 (&vp_dev->lock){-...}-{3:3},
> at: vp_interrupt+0x142/0x200 drivers/virtio/virtio_pci_common.c:113
>  #1: ffff88814174a120 (&vb->stop_update_lock){-...}-{3:3},
> at: spin_lock include/linux/spinlock.h:351 [inline]
>  #1: ffff88814174a120 (&vb->stop_update_lock){-...}-{3:3},
> at: stats_request+0x6f/0x230 drivers/virtio/virtio_balloon.c:438
>  #2: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
> at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>  #2: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
> at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
>  #2: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
> at: __queue_work+0x199/0xf50 kernel/workqueue.c:2259
>  #3: ffff8880b863dd18 (&pool->lock){-.-.}-{2:2},
> at: __queue_work+0x759/0xf50
>  #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
> at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>  #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
> at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
>  #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
> at: __bpf_trace_run kernel/trace/bpf_trace.c:2339 [inline]
>  #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
> at: bpf_trace_run1+0x1d6/0x520 kernel/trace/bpf_trace.c:2380
> stack backtrace:
> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
> 6.12.0-rc5-next-20241031-syzkaller #0
> Hardware name: Google Compute Engine/Google Compute Engine,
> BIOS Google 09/13/2024
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline]
>  check_wait_context kernel/locking/lockdep.c:4898 [inline]
>  __lock_acquire+0x15a8/0x2100 kernel/locking/lockdep.c:5176
>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
>  trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462

This trace is from non-RT kernel where spin_lock =3D=3D raw_spin_lock.

I don't think Hou's explanation earlier is correct.
https://lore.kernel.org/bpf/e14d8882-4760-7c9c-0cfc-db04eda494ee@huaweiclou=
d.com/

>  bpf_prog_2c29ac5cdc6b1842+0x43/0x47
>  bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
>  __bpf_prog_run include/linux/filter.h:701 [inline]
>  bpf_prog_run include/linux/filter.h:708 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2340 [inline]
>  bpf_trace_run1+0x2ca/0x520 kernel/trace/bpf_trace.c:2380
>  trace_workqueue_activate_work+0x186/0x1f0 include/trace/events/workqueue=
.h:59
>  __queue_work+0xc7b/0xf50 kernel/workqueue.c:2338
>  queue_work_on+0x1c2/0x380 kernel/workqueue.c:2390

here irqs are disabled, but raw_spin_lock in lpm should be fine.

>  queue_work include/linux/workqueue.h:662 [inline]
>  stats_request+0x1a3/0x230 drivers/virtio/virtio_balloon.c:441
>  vring_interrupt+0x21d/0x380 drivers/virtio/virtio_ring.c:2595
>  vp_vring_interrupt drivers/virtio/virtio_pci_common.c:82 [inline]
>  vp_interrupt+0x192/0x200 drivers/virtio/virtio_pci_common.c:113
>  __handle_irq_event_percpu+0x29a/0xa80 kernel/irq/handle.c:158
>  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
>  handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
>  handle_fasteoi_irq+0x48a/0xae0 kernel/irq/chip.c:720
>  generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
>  handle_irq arch/x86/kernel/irq.c:247 [inline]
>  call_irq_handler arch/x86/kernel/irq.c:259 [inline]
>  __common_interrupt+0x136/0x230 arch/x86/kernel/irq.c:285
>  common_interrupt+0xb4/0xd0 arch/x86/kernel/irq.c:278
>  </IRQ>
>
> Reported-by: syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/6723db4a.050a0220.35b515.0168.GAE@goo=
gle.com/
> Fixes: 66150d0dde03 ("bpf, lpm: Make locking RT friendly")
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  kernel/bpf/lpm_trie.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index 9b60eda0f727..373cdcfa0505 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -35,7 +35,7 @@ struct lpm_trie {
>         size_t                          n_entries;
>         size_t                          max_prefixlen;
>         size_t                          data_size;
> -       spinlock_t                      lock;
> +       raw_spinlock_t                  lock;
>  };

We're certainly not going back.

pw-bot: cr

