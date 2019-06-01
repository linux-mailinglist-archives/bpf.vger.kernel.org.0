Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63B3931E82
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2019 15:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfFANWJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Jun 2019 09:22:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728308AbfFANWI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Jun 2019 09:22:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF0102731E;
        Sat,  1 Jun 2019 13:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395327;
        bh=N+BjOKf0zUJqaaoNQXlasbiLv6CLZE9pBnFrKQEThvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rg1kykLjU/1HWJMIyMMtyjX4gjjrKvqdt9/xdm9xerDxC1I6KPD05zEqwAI5kLO3M
         Si4uni37UfmqW/FiHCqgfid8BWcMtN3O0RKoJvHan7gSX/JKxbuYmDrB0IKL1eDb7B
         sxqh8ZlAaTbGbKMS2EaOdhMCr+df22I1Xbiif0oc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Li Rongqing <lirongqing@baidu.com>, Zhang Yu <zhangyu31@baidu.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 004/141] ipc: prevent lockup on alloc_msg and free_msg
Date:   Sat,  1 Jun 2019 09:19:40 -0400
Message-Id: <20190601132158.25821-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132158.25821-1-sashal@kernel.org>
References: <20190601132158.25821-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Li Rongqing <lirongqing@baidu.com>

[ Upstream commit d6a2946a88f524a47cc9b79279667137899db807 ]

msgctl10 of ltp triggers the following lockup When CONFIG_KASAN is
enabled on large memory SMP systems, the pages initialization can take a
long time, if msgctl10 requests a huge block memory, and it will block
rcu scheduler, so release cpu actively.

After adding schedule() in free_msg, free_msg can not be called when
holding spinlock, so adding msg to a tmp list, and free it out of
spinlock

  rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
  rcu:     Tasks blocked on level-1 rcu_node (CPUs 16-31): P32505
  rcu:     Tasks blocked on level-1 rcu_node (CPUs 48-63): P34978
  rcu:     (detected by 11, t=35024 jiffies, g=44237529, q=16542267)
  msgctl10        R  running task    21608 32505   2794 0x00000082
  Call Trace:
   preempt_schedule_irq+0x4c/0xb0
   retint_kernel+0x1b/0x2d
  RIP: 0010:__is_insn_slot_addr+0xfb/0x250
  Code: 82 1d 00 48 8b 9b 90 00 00 00 4c 89 f7 49 c1 ee 03 e8 59 83 1d 00 48 b8 00 00 00 00 00 fc ff df 4c 39 eb 48 89 9d 58 ff ff ff <41> c6 04 06 f8 74 66 4c 8d 75 98 4c 89 f1 48 c1 e9 03 48 01 c8 48
  RSP: 0018:ffff88bce041f758 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
  RAX: dffffc0000000000 RBX: ffffffff8471bc50 RCX: ffffffff828a2a57
  RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: ffff88bce041f780
  RBP: ffff88bce041f828 R08: ffffed15f3f4c5b3 R09: ffffed15f3f4c5b3
  R10: 0000000000000001 R11: ffffed15f3f4c5b2 R12: 000000318aee9b73
  R13: ffffffff8471bc50 R14: 1ffff1179c083ef0 R15: 1ffff1179c083eec
   kernel_text_address+0xc1/0x100
   __kernel_text_address+0xe/0x30
   unwind_get_return_address+0x2f/0x50
   __save_stack_trace+0x92/0x100
   create_object+0x380/0x650
   __kmalloc+0x14c/0x2b0
   load_msg+0x38/0x1a0
   do_msgsnd+0x19e/0xcf0
   do_syscall_64+0x117/0x400
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

  rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
  rcu:     Tasks blocked on level-1 rcu_node (CPUs 0-15): P32170
  rcu:     (detected by 14, t=35016 jiffies, g=44237525, q=12423063)
  msgctl10        R  running task    21608 32170  32155 0x00000082
  Call Trace:
   preempt_schedule_irq+0x4c/0xb0
   retint_kernel+0x1b/0x2d
  RIP: 0010:lock_acquire+0x4d/0x340
  Code: 48 81 ec c0 00 00 00 45 89 c6 4d 89 cf 48 8d 6c 24 20 48 89 3c 24 48 8d bb e4 0c 00 00 89 74 24 0c 48 c7 44 24 20 b3 8a b5 41 <48> c1 ed 03 48 c7 44 24 28 b4 25 18 84 48 c7 44 24 30 d0 54 7a 82
  RSP: 0018:ffff88af83417738 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
  RAX: dffffc0000000000 RBX: ffff88bd335f3080 RCX: 0000000000000002
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88bd335f3d64
  RBP: ffff88af83417758 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000001 R11: ffffed13f3f745b2 R12: 0000000000000000
  R13: 0000000000000002 R14: 0000000000000000 R15: 0000000000000000
   is_bpf_text_address+0x32/0xe0
   kernel_text_address+0xec/0x100
   __kernel_text_address+0xe/0x30
   unwind_get_return_address+0x2f/0x50
   __save_stack_trace+0x92/0x100
   save_stack+0x32/0xb0
   __kasan_slab_free+0x130/0x180
   kfree+0xfa/0x2d0
   free_msg+0x24/0x50
   do_msgrcv+0x508/0xe60
   do_syscall_64+0x117/0x400
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

Davidlohr said:
 "So after releasing the lock, the msg rbtree/list is empty and new
  calls will not see those in the newly populated tmp_msg list, and
  therefore they cannot access the delayed msg freeing pointers, which
  is good. Also the fact that the node_cache is now freed before the
  actual messages seems to be harmless as this is wanted for
  msg_insert() avoiding GFP_ATOMIC allocations, and after releasing the
  info->lock the thing is freed anyway so it should not change things"

Link: http://lkml.kernel.org/r/1552029161-4957-1-git-send-email-lirongqing@baidu.com
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 ipc/mqueue.c  | 10 ++++++++--
 ipc/msgutil.c |  6 ++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index c0d58f390c3b4..bce7af1546d9c 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -391,7 +391,8 @@ static void mqueue_evict_inode(struct inode *inode)
 	struct user_struct *user;
 	unsigned long mq_bytes, mq_treesize;
 	struct ipc_namespace *ipc_ns;
-	struct msg_msg *msg;
+	struct msg_msg *msg, *nmsg;
+	LIST_HEAD(tmp_msg);
 
 	clear_inode(inode);
 
@@ -402,10 +403,15 @@ static void mqueue_evict_inode(struct inode *inode)
 	info = MQUEUE_I(inode);
 	spin_lock(&info->lock);
 	while ((msg = msg_get(info)) != NULL)
-		free_msg(msg);
+		list_add_tail(&msg->m_list, &tmp_msg);
 	kfree(info->node_cache);
 	spin_unlock(&info->lock);
 
+	list_for_each_entry_safe(msg, nmsg, &tmp_msg, m_list) {
+		list_del(&msg->m_list);
+		free_msg(msg);
+	}
+
 	/* Total amount of bytes accounted for the mqueue */
 	mq_treesize = info->attr.mq_maxmsg * sizeof(struct msg_msg) +
 		min_t(unsigned int, info->attr.mq_maxmsg, MQ_PRIO_MAX) *
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index 84598025a6ade..e65593742e2be 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -18,6 +18,7 @@
 #include <linux/utsname.h>
 #include <linux/proc_ns.h>
 #include <linux/uaccess.h>
+#include <linux/sched.h>
 
 #include "util.h"
 
@@ -64,6 +65,9 @@ static struct msg_msg *alloc_msg(size_t len)
 	pseg = &msg->next;
 	while (len > 0) {
 		struct msg_msgseg *seg;
+
+		cond_resched();
+
 		alen = min(len, DATALEN_SEG);
 		seg = kmalloc(sizeof(*seg) + alen, GFP_KERNEL_ACCOUNT);
 		if (seg == NULL)
@@ -176,6 +180,8 @@ void free_msg(struct msg_msg *msg)
 	kfree(msg);
 	while (seg != NULL) {
 		struct msg_msgseg *tmp = seg->next;
+
+		cond_resched();
 		kfree(seg);
 		seg = tmp;
 	}
-- 
2.20.1

