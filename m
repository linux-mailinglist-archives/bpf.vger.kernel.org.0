Return-Path: <bpf+bounces-29851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077588C779B
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 15:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290631C225F9
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 13:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0691F1474C6;
	Thu, 16 May 2024 13:30:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE46146A72;
	Thu, 16 May 2024 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866218; cv=none; b=kd3XzXRJMlf6qMT1q/PGMOV0l1gjH2ZDZtb66y7E9R6J71DKojbZlBx5rq6driS3Ls3HH2R7XhsPs71NUa2Uy2KirYw7PBKwnIu9WdzbU9JJWwpvv08KP7lht3vAAPiFwt3QU440WDRlmMm67lFOiuWbOL3IyguuSotof3GHUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866218; c=relaxed/simple;
	bh=VoDwIILpoicckdZeh86XX6ygw+F1snJSo0Fmdop6IXE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vAwJyC6xtzxO7X5JlfUmJb07idlcdLoQ9gd5o7S/IGl0Ch5Wqq8BN9MpVsk6MepeHnlhERj9Xb3pv7wjs9qn+C6jOqPjyTj0/BYZhYPvcld2+PXHiX1CeyIzD6o54BjlnNQX5jDinVWgj8CquANYPWUoGCcX62SYBI/nh8FjQH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vg9tw17csz4f3kKP;
	Thu, 16 May 2024 21:30:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BB11E1A0FEE;
	Thu, 16 May 2024 21:30:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ5ZCkZmVmxPMw--.64017S4;
	Thu, 16 May 2024 21:30:03 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: netdev@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Davide Caratti <dcaratti@redhat.com>
Cc: bpf@vger.kernel.org,
	houtao1@huawei.com
Subject: [PATCH] net/sched: unregister root_lock_key in the error path of qdisc_alloc()
Date: Thu, 16 May 2024 21:30:35 +0800
Message-Id: <20240516133035.1050113-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHZQ5ZCkZmVmxPMw--.64017S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1DWFy7CF1UurW8JFWkZwb_yoWruF4DpF
	s5KrWxJr18try8Zr4Uta18GrWUXwsxJr1UCFnagr4rZ3Z8Gw1Igrs2gr98WFy5Cry8ua4Y
	ywn8J39rWr1UJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

The following slab-use-after-free problem was reported by syzbot:

==================================================================
BUG: KASAN: slab-use-after-free in lockdep_register_key+0x253/0x3f0 kernel/locking/lockdep.c:1225
Read of size 8 at addr ffff88805fe2c298 by task syz-executor.1/5906

CPU: 1 PID: 5906 Comm: syz-executor.1 Not tainted 6.9.0-rc5-syzkaller-01473-g2506f6229bd0 #0
......
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 lockdep_register_key+0x253/0x3f0 kernel/locking/lockdep.c:1225
 htab_map_alloc+0x9b/0xe60 kernel/bpf/hashtab.c:506
 map_create+0x90c/0x1200 kernel/bpf/syscall.c:1333
 __sys_bpf+0x6d1/0x810 kernel/bpf/syscall.c:5659
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
......
 </TASK>

Allocated by task 5593:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3966 [inline]
 __kmalloc_node_track_caller+0x24e/0x4e0 mm/slub.c:3986
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:597
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:666
 alloc_skb include/linux/skbuff.h:1308 [inline]
 alloc_skb_with_frags+0xc3/0x770 net/core/skbuff.c:6455
 ......

Freed by task 5593:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kfree+0x153/0x3a0 mm/slub.c:4390
 skb_kfree_head net/core/skbuff.c:1033 [inline]
 skb_free_head net/core/skbuff.c:1045 [inline]
 ......

The buggy address belongs to the object at ffff88805fe2c000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 664 bytes inside of
 freed 2048-byte region [ffff88805fe2c000, ffff88805fe2c800)

At first glance, it seems there is a problem with bpf hash-table,
because the use-after-free problem is reported when invoking
htab_map_alloc(). However, after checking the reported error more
carefully, it appears that qdiscs_alloc() is the culprit. The most
important clue regarding why qdisc_alloc() is involved is the following:
"The buggy address is located 664 bytes inside of freed 2048-byte
region". lockdep_register_key() has several callers, and only the
offset of lock_class_key in Qdisc in 664. The problem occurs as follow:

(1) call qdisc_alloc()
After calling lockdep_register_key(), qdisc_alloc() jumps to errout1
label because netdev_alloc_pcpu_stats() or alloc_percpu() fails (e.g.,
due to mem-cg limitation or SIGKILL). However it doesn't call
lockdep_unregister_key() to unregister root_lock_key, but it frees the
allocated memory.

(2) call htab_map_alloc
During the calling of lockdep_register_key(), it finds the lockdep_key
registered by free-ed Qdisc and triggers the use-after-free.

Fix it by invoking lockdep_unregister_key() in the error path of
qdisc_alloc().

Reported-by: syzbot+061f58eec3bde7ee8ffa@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/d28e4f02-965d-96de-ee56-f7a001b67fe7@huaweicloud.com/T/#m47c0670021ada17869bf887c73438133d879d326
Fixes: af0cb3fa3f9e ("net/sched: fix false lockdep warning on qdisc root lock")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 net/sched/sch_generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 31dfd6c7405b0..d3f6006b563cc 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -982,6 +982,7 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 
 	return sch;
 errout1:
+	lockdep_unregister_key(&sch->root_lock_key);
 	kfree(sch);
 errout:
 	return ERR_PTR(err);
-- 
2.29.2


