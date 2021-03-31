Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B255434F855
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 07:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhCaFox (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 01:44:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233595AbhCaFov (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 01:44:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D47B6024A;
        Wed, 31 Mar 2021 05:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617169491;
        bh=4vzFQPDT3xus/+3X6W7v5KWyPLjj8HNd8PrsBug0278=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bhwvMYVwVLISmNlfYLM8ndSdl5JUSW9i8j5Ne4EHW9xkHxBfje/uvU9I8haXXLNfq
         wqsey2V/otSWShRQoo6Yl0briAr537XvMaGAbsU/5MmuesLOmZkYeQTtqUBifHRmQS
         teERgr39hz9GfDxI/JqnfwBovVwQJQGZg/M9mp94ssIaPJ6QTHxHOKhPNoNkFTEWjP
         wsowFV8XEHnbkP3NAz3hViqBi3VJMuTMFrDbyPBIBW3diueaMmu1p15GCEQ3K4OGyJ
         DUQlALB6mFwOv50v/VjExOz6VwkIpa198jAKdPDQHqcSWW+9D01mw68VRGu0MKQ1T7
         UNekaSMcaqAvA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC PATCH -tip 2/3] kprobes: Add functions to find instruction buffer entry address
Date:   Wed, 31 Mar 2021 14:44:45 +0900
Message-Id: <161716948533.721514.17707467357877538662.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161716946413.721514.4057380464113663840.stgit@devnote2>
References: <161716946413.721514.4057380464113663840.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add find_kprobe_{insn,optinsn}_slot_entry() functions to find
corresponding entry address of the kprobe instrurction buffer
which includes given address.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/kprobes.h |    8 ++++++++
 kernel/kprobes.c        |   25 ++++++++++++++++++-------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index f530f82a046d..08adfd6cf562 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -305,6 +305,8 @@ extern void __free_insn_slot(struct kprobe_insn_cache *c,
 /* sleep-less address checking routine  */
 extern bool __is_insn_slot_addr(struct kprobe_insn_cache *c,
 				unsigned long addr);
+extern unsigned long
+__find_insn_slot_entry(struct kprobe_insn_cache *c, unsigned long addr);
 
 #define DEFINE_INSN_CACHE_OPS(__name)					\
 extern struct kprobe_insn_cache kprobe_##__name##_slots;		\
@@ -322,6 +324,12 @@ static inline void free_##__name##_slot(kprobe_opcode_t *slot, int dirty)\
 static inline bool is_kprobe_##__name##_slot(unsigned long addr)	\
 {									\
 	return __is_insn_slot_addr(&kprobe_##__name##_slots, addr);	\
+}									\
+									\
+static inline unsigned long						\
+find_kprobe_##__name##_slot_entry(unsigned long addr)			\
+{									\
+	return __find_insn_slot_entry(&kprobe_##__name##_slots, addr);	\
 }
 #define KPROBE_INSN_PAGE_SYM		"kprobe_insn_page"
 #define KPROBE_OPTINSN_PAGE_SYM		"kprobe_optinsn_page"
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 4ce3e6f5d28d..b62635969fa6 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -277,26 +277,37 @@ void __free_insn_slot(struct kprobe_insn_cache *c,
 }
 
 /*
- * Check given address is on the page of kprobe instruction slots.
- * This will be used for checking whether the address on a stack
- * is on a text area or not.
+ * Find the entry address of the kprobe instruction slots where the
+ * @addr points.
  */
-bool __is_insn_slot_addr(struct kprobe_insn_cache *c, unsigned long addr)
+unsigned long
+__find_insn_slot_entry(struct kprobe_insn_cache *c, unsigned long addr)
 {
 	struct kprobe_insn_page *kip;
-	bool ret = false;
+	unsigned long entry = 0, index;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(kip, &c->pages, list) {
 		if (addr >= (unsigned long)kip->insns &&
 		    addr < (unsigned long)kip->insns + PAGE_SIZE) {
-			ret = true;
+			index = (addr - (unsigned long)kip->insns) / c->insn_size;
+			entry = (unsigned long)kip->insns + (index * c->insn_size);
 			break;
 		}
 	}
 	rcu_read_unlock();
 
-	return ret;
+	return entry;
+}
+
+/*
+ * Check given address is on the page of kprobe instruction slots.
+ * This will be used for checking whether the address on a stack
+ * is on a text area or not.
+ */
+bool __is_insn_slot_addr(struct kprobe_insn_cache *c, unsigned long addr)
+{
+	return __find_insn_slot_entry(c, addr) != 0;
 }
 
 int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c, unsigned int *symnum,

