Return-Path: <bpf+bounces-44333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1459C167C
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 07:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068D81C22A70
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 06:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57F028F5;
	Fri,  8 Nov 2024 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XdeUC+b/"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FDA14D2BB
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 06:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731047571; cv=none; b=H/NGDM4p1R8SOq7zj4GfOZGkrqQ82PxCMPKqb2AFdVge9MR2L8+mdFk49s9CCaU6tCrJEOmrfdSVSoFte6AJzDpuK4spLRP9go9nmyBRCWk0SRdsN2e+rnoXcpQBw3dyDouWPiFVZwpjKFUHrDuW5bMywFmo6/FbqIDdtrs+DXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731047571; c=relaxed/simple;
	bh=glCvAj1wcmZlfuLGIavms5IdCXD7UIBEhGCsE6OsPSA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RuCGbvSc6Rcgq0/ILQjH59qocOdM/ibH8DtJvfns9L5Xffu699dE3rsT9yuJMQXstL+pO3NgcweMiC+238MrN1jUxJBqphCVjMCOIl7jp622vJMxDtwRTDrlxog9Xmzlvf1aboDI3023QGw4vLZf2+/2W5jtAxsZyiVwjb0Bzsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XdeUC+b/; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731047565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y5zsbgVR21nLaT8o8D3suARsPPte/XErGgbHlgcN2T4=;
	b=XdeUC+b/PsEPKYhSUhCXEeSZDo2ATbBi6IW3AfDM0HrbRigcyzHwZrU1mf49fM3VGU2Cun
	K3ZkjFbEzrMxREW0DnZZdxpTsoLhBwccy77GCxaFgBoPNX1opmKTTs7BYgMS3YEF7UjJkT
	TasIclJ+z+B4mgTWJ8IX3Hb6VH0rTyM=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	tglx@linutronix.de
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Kunwu Chan <chentao@kylinos.cn>,
	syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com
Subject: [PATCH] bpf: Convert lpm_trie::lock to 'raw_spinlock_t'
Date: Fri,  8 Nov 2024 14:32:14 +0800
Message-Id: <20241108063214.578120-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

When PREEMPT_RT is enabled, 'spinlock_t' becomes preemptible
and bpf program has owned a raw_spinlock under a interrupt handler,
which results in invalid lock acquire context.

[ BUG: Invalid wait context ]
6.12.0-rc5-next-20241031-syzkaller #0 Not tainted
-----------------------------
swapper/0/0 is trying to lock:
ffff8880261e7a00 (&trie->lock){....}-{3:3},
at: trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462
other info that might help us debug this:
context-{3:3}
5 locks held by swapper/0/0:
 #0: ffff888020bb75c8 (&vp_dev->lock){-...}-{3:3},
at: vp_vring_interrupt drivers/virtio/virtio_pci_common.c:80 [inline]
 #0: ffff888020bb75c8 (&vp_dev->lock){-...}-{3:3},
at: vp_interrupt+0x142/0x200 drivers/virtio/virtio_pci_common.c:113
 #1: ffff88814174a120 (&vb->stop_update_lock){-...}-{3:3},
at: spin_lock include/linux/spinlock.h:351 [inline]
 #1: ffff88814174a120 (&vb->stop_update_lock){-...}-{3:3},
at: stats_request+0x6f/0x230 drivers/virtio/virtio_balloon.c:438
 #2: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #2: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #2: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
at: __queue_work+0x199/0xf50 kernel/workqueue.c:2259
 #3: ffff8880b863dd18 (&pool->lock){-.-.}-{2:2},
at: __queue_work+0x759/0xf50
 #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
at: __bpf_trace_run kernel/trace/bpf_trace.c:2339 [inline]
 #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
at: bpf_trace_run1+0x1d6/0x520 kernel/trace/bpf_trace.c:2380
stack backtrace:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
6.12.0-rc5-next-20241031-syzkaller #0
Hardware name: Google Compute Engine/Google Compute Engine,
BIOS Google 09/13/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline]
 check_wait_context kernel/locking/lockdep.c:4898 [inline]
 __lock_acquire+0x15a8/0x2100 kernel/locking/lockdep.c:5176
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462
 bpf_prog_2c29ac5cdc6b1842+0x43/0x47
 bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run include/linux/filter.h:708 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2340 [inline]
 bpf_trace_run1+0x2ca/0x520 kernel/trace/bpf_trace.c:2380
 trace_workqueue_activate_work+0x186/0x1f0 include/trace/events/workqueue.h:59
 __queue_work+0xc7b/0xf50 kernel/workqueue.c:2338
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2390
 queue_work include/linux/workqueue.h:662 [inline]
 stats_request+0x1a3/0x230 drivers/virtio/virtio_balloon.c:441
 vring_interrupt+0x21d/0x380 drivers/virtio/virtio_ring.c:2595
 vp_vring_interrupt drivers/virtio/virtio_pci_common.c:82 [inline]
 vp_interrupt+0x192/0x200 drivers/virtio/virtio_pci_common.c:113
 __handle_irq_event_percpu+0x29a/0xa80 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
 handle_fasteoi_irq+0x48a/0xae0 kernel/irq/chip.c:720
 generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
 handle_irq arch/x86/kernel/irq.c:247 [inline]
 call_irq_handler arch/x86/kernel/irq.c:259 [inline]
 __common_interrupt+0x136/0x230 arch/x86/kernel/irq.c:285
 common_interrupt+0xb4/0xd0 arch/x86/kernel/irq.c:278
 </IRQ>

Reported-by: syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/6723db4a.050a0220.35b515.0168.GAE@google.com/
Fixes: 66150d0dde03 ("bpf, lpm: Make locking RT friendly")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/bpf/lpm_trie.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 9b60eda0f727..373cdcfa0505 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -35,7 +35,7 @@ struct lpm_trie {
 	size_t				n_entries;
 	size_t				max_prefixlen;
 	size_t				data_size;
-	spinlock_t			lock;
+	raw_spinlock_t			lock;
 };
 
 /* This trie implements a longest prefix match algorithm that can be used to
@@ -330,7 +330,7 @@ static long trie_update_elem(struct bpf_map *map,
 	if (key->prefixlen > trie->max_prefixlen)
 		return -EINVAL;
 
-	spin_lock_irqsave(&trie->lock, irq_flags);
+	raw_spin_lock_irqsave(&trie->lock, irq_flags);
 
 	/* Allocate and fill a new node */
 
@@ -437,7 +437,7 @@ static long trie_update_elem(struct bpf_map *map,
 		kfree(im_node);
 	}
 
-	spin_unlock_irqrestore(&trie->lock, irq_flags);
+	raw_spin_unlock_irqrestore(&trie->lock, irq_flags);
 	kfree_rcu(free_node, rcu);
 
 	return ret;
@@ -459,7 +459,7 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 	if (key->prefixlen > trie->max_prefixlen)
 		return -EINVAL;
 
-	spin_lock_irqsave(&trie->lock, irq_flags);
+	raw_spin_lock_irqsave(&trie->lock, irq_flags);
 
 	/* Walk the tree looking for an exact key/length match and keeping
 	 * track of the path we traverse.  We will need to know the node
@@ -535,7 +535,7 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 	free_node = node;
 
 out:
-	spin_unlock_irqrestore(&trie->lock, irq_flags);
+	raw_spin_unlock_irqrestore(&trie->lock, irq_flags);
 	kfree_rcu(free_parent, rcu);
 	kfree_rcu(free_node, rcu);
 
@@ -581,7 +581,7 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
 			  offsetof(struct bpf_lpm_trie_key_u8, data);
 	trie->max_prefixlen = trie->data_size * 8;
 
-	spin_lock_init(&trie->lock);
+	raw_spin_lock_init(&trie->lock);
 
 	return &trie->map;
 }
-- 
2.34.1


