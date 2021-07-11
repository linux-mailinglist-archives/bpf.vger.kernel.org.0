Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C0D3C3B13
	for <lists+bpf@lfdr.de>; Sun, 11 Jul 2021 09:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhGKHiv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Jul 2021 03:38:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhGKHiu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Jul 2021 03:38:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2F7B613AF;
        Sun, 11 Jul 2021 07:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625988964;
        bh=zBiR78gaxnfZ5HO+ic2oQH67cBzeyE6tUoGekaUimmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wt0Fj9DqhroKB4kqB7NBvLrjaDi6EkXWdyhQ77mQrfFMmDUqlhOfZaxiTSzheF+Yl
         Kvx/Qq9vcR3BCozs9iWhTe8pof3LgoVuxXzGffv+zwZjx9Z4SV/wRsDS52QZuk9ZGB
         bHJCrH8naUYWVBrcWUx/wj+cThjhGW56bMjAngiQdtTw7exqVl4KdlYbfG/HkoPxKQ
         zE6TBDp/qun3C0c5arPw0JiRexP//3/bou62aqBHcH8ytjR08zPy3Cqoj+xj27Nwho
         4VS6OVlSRG6o+ddFCDtUxK7GRB+rS+VzXi3nyfOaCU/1i+mHcA4SlTgO6SmPNSCC19
         8aaQlJpFYgTZw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     X86 ML <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH -tip v2 6/6] kprobes: Use bool type for functions which returns boolean value
Date:   Sun, 11 Jul 2021 16:35:29 +0900
Message-Id: <162598892887.1222130.14030293570685289988.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162598881438.1222130.11530594038964049135.stgit@devnote2>
References: <162598881438.1222130.11530594038964049135.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use the 'bool' type instead of 'int' for the functions which
returns a boolean value, because this makes clear that those
functions don't return any error code.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2:
  - Fix trace_kprobe's kprobe_gone() too.
---
 include/linux/kprobes.h     |    8 ++++----
 kernel/kprobes.c            |   26 +++++++++++++-------------
 kernel/trace/trace_kprobe.c |    2 +-
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index bb6d1e72a943..7d0d21f2315a 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -104,25 +104,25 @@ struct kprobe {
 #define KPROBE_FLAG_FTRACE	8 /* probe is using ftrace */
 
 /* Has this kprobe gone ? */
-static inline int kprobe_gone(struct kprobe *p)
+static inline bool kprobe_gone(struct kprobe *p)
 {
 	return p->flags & KPROBE_FLAG_GONE;
 }
 
 /* Is this kprobe disabled ? */
-static inline int kprobe_disabled(struct kprobe *p)
+static inline bool kprobe_disabled(struct kprobe *p)
 {
 	return p->flags & (KPROBE_FLAG_DISABLED | KPROBE_FLAG_GONE);
 }
 
 /* Is this kprobe really running optimized path ? */
-static inline int kprobe_optimized(struct kprobe *p)
+static inline bool kprobe_optimized(struct kprobe *p)
 {
 	return p->flags & KPROBE_FLAG_OPTIMIZED;
 }
 
 /* Is this kprobe uses ftrace ? */
-static inline int kprobe_ftrace(struct kprobe *p)
+static inline bool kprobe_ftrace(struct kprobe *p)
 {
 	return p->flags & KPROBE_FLAG_FTRACE;
 }
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index e30c639fe2cc..2029d7ceaa11 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -198,8 +198,8 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 	return slot;
 }
 
-/* Return 1 if all garbages are collected, otherwise 0. */
-static int collect_one_slot(struct kprobe_insn_page *kip, int idx)
+/* Return true if all garbages are collected, otherwise false. */
+static bool collect_one_slot(struct kprobe_insn_page *kip, int idx)
 {
 	kip->slot_used[idx] = SLOT_CLEAN;
 	kip->nused--;
@@ -223,9 +223,9 @@ static int collect_one_slot(struct kprobe_insn_page *kip, int idx)
 			kip->cache->free(kip->insns);
 			kfree(kip);
 		}
-		return 1;
+		return true;
 	}
-	return 0;
+	return false;
 }
 
 static int collect_garbage_slots(struct kprobe_insn_cache *c)
@@ -389,13 +389,13 @@ NOKPROBE_SYMBOL(get_kprobe);
 static int aggr_pre_handler(struct kprobe *p, struct pt_regs *regs);
 
 /* Return true if 'p' is an aggregator */
-static inline int kprobe_aggrprobe(struct kprobe *p)
+static inline bool kprobe_aggrprobe(struct kprobe *p)
 {
 	return p->pre_handler == aggr_pre_handler;
 }
 
 /* Return true if 'p' is unused */
-static inline int kprobe_unused(struct kprobe *p)
+static inline bool kprobe_unused(struct kprobe *p)
 {
 	return kprobe_aggrprobe(p) && kprobe_disabled(p) &&
 	       list_empty(&p->list);
@@ -455,7 +455,7 @@ static inline int kprobe_optready(struct kprobe *p)
 }
 
 /* Return true if the kprobe is disarmed. Note: p must be on hash list */
-static inline int kprobe_disarmed(struct kprobe *p)
+static inline bool kprobe_disarmed(struct kprobe *p)
 {
 	struct optimized_kprobe *op;
 
@@ -469,16 +469,16 @@ static inline int kprobe_disarmed(struct kprobe *p)
 }
 
 /* Return true if the probe is queued on (un)optimizing lists */
-static int kprobe_queued(struct kprobe *p)
+static bool kprobe_queued(struct kprobe *p)
 {
 	struct optimized_kprobe *op;
 
 	if (kprobe_aggrprobe(p)) {
 		op = container_of(p, struct optimized_kprobe, kp);
 		if (!list_empty(&op->list))
-			return 1;
+			return true;
 	}
-	return 0;
+	return false;
 }
 
 /*
@@ -1683,7 +1683,7 @@ int register_kprobe(struct kprobe *p)
 EXPORT_SYMBOL_GPL(register_kprobe);
 
 /* Check if all probes on the 'ap' are disabled. */
-static int aggr_kprobe_disabled(struct kprobe *ap)
+static bool aggr_kprobe_disabled(struct kprobe *ap)
 {
 	struct kprobe *kp;
 
@@ -1695,9 +1695,9 @@ static int aggr_kprobe_disabled(struct kprobe *ap)
 			 * Since there is an active probe on the list,
 			 * we can't disable this 'ap'.
 			 */
-			return 0;
+			return false;
 
-	return 1;
+	return true;
 }
 
 static struct kprobe *__disable_kprobe(struct kprobe *p)
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index ea6178cb5e33..c6e0345a44e9 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -101,7 +101,7 @@ static nokprobe_inline unsigned long trace_kprobe_offset(struct trace_kprobe *tk
 
 static nokprobe_inline bool trace_kprobe_has_gone(struct trace_kprobe *tk)
 {
-	return !!(kprobe_gone(&tk->rp.kp));
+	return kprobe_gone(&tk->rp.kp);
 }
 
 static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,

