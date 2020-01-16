Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C9213DDE3
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 15:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgAPOpu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 09:45:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728981AbgAPOpl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 09:45:41 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7185E207E0;
        Thu, 16 Jan 2020 14:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579185940;
        bh=9hKc13sX3wl6v6E7D/d/V41QrfhG81urjfZd9vMLYX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aXCjgQXAXdlEr/vZiau2kV4qAhpzZrrfNBrM2+5Prkee16N6DHA9KY2W86t2+Lvjp
         ATv0Pv8gD0L4yBDIOufPHLWGxr7n6/hWr76P6BimdtlqVzEU4mwfQdelNbN5tJrPyQ
         ikJYFhEcAi6NsR2oHbiLNZvEd8c8e9rhUu5GkU64=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Brendan Gregg <brendan.d.gregg@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     mhiramat@kernel.org, Ingo Molnar <mingo@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [RFT PATCH 08/13] kprobes: Use workqueue for reclaiming kprobe insn cache pages
Date:   Thu, 16 Jan 2020 23:45:33 +0900
Message-Id: <157918593350.29301.7175144493909010321.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157918584866.29301.6941815715391411338.stgit@devnote2>
References: <157918584866.29301.6941815715391411338.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use workqueues for reclaiming kprobe insn cache pages. This can
split the heaviest part from the unregistration process.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/kprobes.h |    2 ++
 kernel/kprobes.c        |   29 ++++++++++++++++++-----------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 04bdaf01112c..0f832817fca3 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -245,6 +245,7 @@ struct kprobe_insn_cache {
 	struct list_head pages; /* list of kprobe_insn_page */
 	size_t insn_size;	/* size of instruction slot */
 	int nr_garbage;
+	struct work_struct work;
 };
 
 #ifdef __ARCH_WANT_KPROBES_INSN_SLOT
@@ -254,6 +255,7 @@ extern void __free_insn_slot(struct kprobe_insn_cache *c,
 /* sleep-less address checking routine  */
 extern bool __is_insn_slot_addr(struct kprobe_insn_cache *c,
 				unsigned long addr);
+void kprobe_insn_cache_gc(struct work_struct *work);
 
 #define DEFINE_INSN_CACHE_OPS(__name)					\
 extern struct kprobe_insn_cache kprobe_##__name##_slots;		\
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 09b0e33bc845..a9114923da4c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -126,8 +126,15 @@ struct kprobe_insn_cache kprobe_insn_slots = {
 	.pages = LIST_HEAD_INIT(kprobe_insn_slots.pages),
 	.insn_size = MAX_INSN_SIZE,
 	.nr_garbage = 0,
+	.work = __WORK_INITIALIZER(kprobe_insn_slots.work,
+				   kprobe_insn_cache_gc),
 };
-static int collect_garbage_slots(struct kprobe_insn_cache *c);
+
+static void kick_kprobe_insn_cache_gc(struct kprobe_insn_cache *c)
+{
+	if (!work_pending(&c->work))
+		schedule_work(&c->work);
+}
 
 /**
  * __get_insn_slot() - Find a slot on an executable page for an instruction.
@@ -140,7 +147,6 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 
 	/* Since the slot array is not protected by rcu, we need a mutex */
 	mutex_lock(&c->mutex);
- retry:
 	list_for_each_entry(kip, &c->pages, list) {
 		if (kip->nused < slots_per_page(c)) {
 			int i;
@@ -158,11 +164,7 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 		}
 	}
 
-	/* If there are any garbage slots, collect it and try again. */
-	if (c->nr_garbage && collect_garbage_slots(c) == 0)
-		goto retry;
-
-	/* All out of space.  Need to allocate a new page. */
+	/* All out of space. Need to allocate a new page. */
 	kip = kmalloc(KPROBE_INSN_PAGE_SIZE(slots_per_page(c)), GFP_KERNEL);
 	if (!kip)
 		goto out;
@@ -213,10 +215,12 @@ static int collect_one_slot(struct kprobe_insn_page *kip, int idx)
 	return 0;
 }
 
-static int collect_garbage_slots(struct kprobe_insn_cache *c)
+void kprobe_insn_cache_gc(struct work_struct *work)
 {
+	struct kprobe_insn_cache *c = container_of(work, typeof(*c), work);
 	struct kprobe_insn_page *kip, *next;
 
+	mutex_lock(&c->mutex);
 	/* Ensure no-one is running on the garbages. */
 	synchronize_rcu_tasks();
 
@@ -226,12 +230,13 @@ static int collect_garbage_slots(struct kprobe_insn_cache *c)
 			continue;
 		kip->ngarbage = 0;	/* we will collect all garbages */
 		for (i = 0; i < slots_per_page(c); i++) {
-			if (kip->slot_used[i] == SLOT_DIRTY && collect_one_slot(kip, i))
+			if (kip->slot_used[i] == SLOT_DIRTY &&
+			    collect_one_slot(kip, i))
 				break;
 		}
 	}
 	c->nr_garbage = 0;
-	return 0;
+	mutex_unlock(&c->mutex);
 }
 
 void __free_insn_slot(struct kprobe_insn_cache *c,
@@ -259,7 +264,7 @@ void __free_insn_slot(struct kprobe_insn_cache *c,
 			kip->slot_used[idx] = SLOT_DIRTY;
 			kip->ngarbage++;
 			if (++c->nr_garbage > slots_per_page(c))
-				collect_garbage_slots(c);
+				kick_kprobe_insn_cache_gc(c);
 		} else {
 			collect_one_slot(kip, idx);
 		}
@@ -299,6 +304,8 @@ struct kprobe_insn_cache kprobe_optinsn_slots = {
 	.pages = LIST_HEAD_INIT(kprobe_optinsn_slots.pages),
 	/* .insn_size is initialized later */
 	.nr_garbage = 0,
+	.work = __WORK_INITIALIZER(kprobe_optinsn_slots.work,
+				   kprobe_insn_cache_gc),
 };
 #endif
 #endif

