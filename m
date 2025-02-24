Return-Path: <bpf+bounces-52353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 098BBA42273
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3EB19C06B5
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 14:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87A3148314;
	Mon, 24 Feb 2025 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="da8+Ils4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A2F78F2D;
	Mon, 24 Feb 2025 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405829; cv=none; b=ZtzZojUFeTatlajYeJ5MylHDJmHl+NvRrr0Ryus0tZRbvELvQesDeUS4xfvdqbJ5maRf8ayPlGc/hKnrtlI/FKsjJcNFFlYSzie52Yrwiao779fl2MR/ygVrpJCseBs8bI06l0l00U4b3VEANxG6ml6594dkKLEU3EQoX1zDBc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405829; c=relaxed/simple;
	bh=DI3+wxJCXVEI4vdD0jGCmR1QuUB76PhVpEYPnlewXeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aL9XIZ7y6W77UmsDeyideE9mXU7NDE+2jHuxX5Z0MtXwF98A4aXUkGvTktmtU3Zb33pr8qRPNtZ5I8GR+H5gNXFQO4F5YlmRvyyFZHj63lkO6lFLj0XkqD2YtTSsjcjUuxkayRBDVZAEO94xNetowxEi3qKGeP4mQ7QVPy2u+L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=da8+Ils4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0DBC4CED6;
	Mon, 24 Feb 2025 14:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405828;
	bh=DI3+wxJCXVEI4vdD0jGCmR1QuUB76PhVpEYPnlewXeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=da8+Ils4Toea8BLFEaAvErA+BOwkQ1Cv8cIz099sWdIRts0MPH4HDJWAJMao96t/v
	 4IB+imO7fM1Jffeek0Vm3CK3LwkqD4j83GTTw3WNhH1VyWU2ljPvfSGROccqYe61sC
	 i5R02bONG4KnAEqhBDrMnElxDQuC+8nAq/NTLISSLcu4DUevtoWPDeQygzrzi9bIIZ
	 CXA+3sJBuUN3JMHslJ3jNdKAEj2xCFsXiVCV3DuQTCHCy8i9GtctZ+2FtN3b/bFB9F
	 9JNwPn9qP5/A3Y9ocGpFrmcWdHkBzGr3QlBU6bUu2B7YB77yzepff+oYGRVcxHog4l
	 WCiFntaTnhuiA==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH RFCv2 10/18] uprobes/x86: Add mm_uprobe objects to track uprobes within mm
Date: Mon, 24 Feb 2025 15:01:42 +0100
Message-ID: <20250224140151.667679-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224140151.667679-1-jolsa@kernel.org>
References: <20250224140151.667679-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We keep track of global uprobe instances, because with just 2 types
of update - writing breakpoint or original opcode - we don't need to
track the state of the specific uprobe state for mm_struct.

With optimized uprobe support we will need to make several instructions
updates and make sure we keep the state of the update per mm_struct.

Adding the mm_uprobe object to keep track of installed uprobes per
mm_struct. It's kept in rb_tree for fast lookups and the tree is
cleaned up when the breakpoint is uninstalled or the mm_struct is
released.

The key is uprobe object's address together with virtual address of
the breakpoint. The reason for the adding the latter to the key is
that we can have multiple virtual addresses for single uprobe,
because the code (for given offset) can be loaded multiple times.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 115 ++++++++++++++++++++++++++++++++++++++
 include/linux/uprobes.h   |   1 +
 2 files changed, 116 insertions(+)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index e0c3fb01a43c..8d4eb8133221 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -798,19 +798,134 @@ static __maybe_unused void uprobe_trampoline_put(struct uprobe_trampoline *tramp
 		destroy_uprobe_trampoline(tramp);
 }
 
+struct mm_uprobe {
+	struct rb_node rb_node;
+	unsigned long auprobe;
+	unsigned long vaddr;
+};
+
+#define __node_2_mm_uprobe(node) rb_entry((node), struct mm_uprobe, rb_node)
+
+struct __mm_uprobe_key {
+	unsigned long auprobe;
+	unsigned long vaddr;
+};
+
+static inline int mm_uprobe_cmp(unsigned long l_auprobe, unsigned long l_vaddr,
+				const struct mm_uprobe *r_mmu)
+{
+	if (l_auprobe < r_mmu->auprobe)
+		return -1;
+	if (l_auprobe > r_mmu->auprobe)
+		return 1;
+	if (l_vaddr < r_mmu->vaddr)
+		return -1;
+	if (l_vaddr > r_mmu->vaddr)
+		return 1;
+
+	return 0;
+}
+
+static inline int __mm_uprobe_cmp(struct rb_node *a, const struct rb_node *b)
+{
+	struct mm_uprobe *mmu_a = __node_2_mm_uprobe(a);
+
+	return mm_uprobe_cmp(mmu_a->auprobe, mmu_a->vaddr, __node_2_mm_uprobe(b));
+}
+
+static inline bool __mm_uprobe_less(struct rb_node *a, const struct rb_node *b)
+{
+	struct mm_uprobe *mmu_a = __node_2_mm_uprobe(a);
+
+	return mm_uprobe_cmp(mmu_a->auprobe, mmu_a->vaddr, __node_2_mm_uprobe(b)) < 0;
+}
+
+static inline int __mm_uprobe_cmp_key(const void *key, const struct rb_node *b)
+{
+	const struct __mm_uprobe_key *a = key;
+
+	return mm_uprobe_cmp(a->auprobe, a->vaddr, __node_2_mm_uprobe(b));
+}
+
+static struct mm_uprobe *find_mm_uprobe(struct mm_struct *mm, struct arch_uprobe *auprobe,
+					unsigned long vaddr)
+{
+	struct __mm_uprobe_key key = {
+		.auprobe = (unsigned long) auprobe,
+		.vaddr = vaddr,
+	};
+	struct rb_node *node;
+
+	node = rb_find(&key, &mm->uprobes_state.root_uprobes, __mm_uprobe_cmp_key);
+	return node ? __node_2_mm_uprobe(node) : NULL;
+}
+
+static struct mm_uprobe *insert_mm_uprobe(struct mm_struct *mm, struct arch_uprobe *auprobe,
+					  unsigned long vaddr)
+{
+	struct mm_uprobe *mmu;
+
+	mmu = kmalloc(sizeof(*mmu), GFP_KERNEL);
+	if (mmu) {
+		mmu->auprobe = (unsigned long) auprobe;
+		mmu->vaddr = vaddr;
+		RB_CLEAR_NODE(&mmu->rb_node);
+		rb_add(&mmu->rb_node, &mm->uprobes_state.root_uprobes, __mm_uprobe_less);
+	}
+	return mmu;
+}
+
+static void destroy_mm_uprobe(struct mm_uprobe *mmu, struct rb_root *root)
+{
+	rb_erase(&mmu->rb_node, root);
+	kfree(mmu);
+}
+
+int set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
+{
+	struct mm_uprobe *mmu;
+
+	if (find_mm_uprobe(mm, auprobe, vaddr))
+		return 0;
+	mmu = insert_mm_uprobe(mm, auprobe, vaddr);
+	if (!mmu)
+		return -ENOMEM;
+	return uprobe_write_opcode(auprobe, mm, vaddr, UPROBE_SWBP_INSN, false);
+}
+
+int set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
+{
+	struct mm_uprobe *mmu;
+
+	mmu = find_mm_uprobe(mm, auprobe, vaddr);
+	if (!mmu)
+		return 0;
+	destroy_mm_uprobe(mmu, &mm->uprobes_state.root_uprobes);
+	return uprobe_write_opcode(auprobe, mm, vaddr, *(uprobe_opcode_t *)&auprobe->insn, true);
+}
+
 void arch_uprobe_init_state(struct mm_struct *mm)
 {
 	INIT_HLIST_HEAD(&mm->uprobes_state.head_tramps);
+	mm->uprobes_state.root_uprobes = RB_ROOT;
 }
 
 void arch_uprobe_clear_state(struct mm_struct *mm)
 {
 	struct uprobes_state *state = &mm->uprobes_state;
 	struct uprobe_trampoline *tramp;
+	struct rb_node *node, *next;
 	struct hlist_node *n;
 
 	hlist_for_each_entry_safe(tramp, n, &state->head_tramps, node)
 		destroy_uprobe_trampoline(tramp);
+
+	node = rb_first(&state->root_uprobes);
+	while (node) {
+		next = rb_next(node);
+		destroy_mm_uprobe(__node_2_mm_uprobe(node), &state->root_uprobes);
+		node = next;
+	}
 }
 #else /* 32-bit: */
 /*
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 05a156750e8d..bd726daa4428 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -186,6 +186,7 @@ struct uprobes_state {
 	struct xol_area		*xol_area;
 #ifdef CONFIG_X86_64
 	struct hlist_head	head_tramps;
+	struct rb_root		root_uprobes;
 #endif
 };
 
-- 
2.48.1


