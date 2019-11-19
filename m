Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C08CA1010CD
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 02:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfKSBit (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Nov 2019 20:38:49 -0500
Received: from www62.your-server.de ([213.133.104.62]:53658 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfKSBis (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Nov 2019 20:38:48 -0500
Received: from 45.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.45] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iWsTe-0002k5-DZ; Tue, 19 Nov 2019 02:38:46 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     john.fastabend@gmail.com, andrii.nakryiko@gmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH bpf-next 4/8] bpf: add initial poke descriptor table for jit images
Date:   Tue, 19 Nov 2019 02:38:35 +0100
Message-Id: <a08b0f2ed58fe90eb733d5ad8409285ee126c888.1574126683.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1574126683.git.daniel@iogearbox.net>
References: <cover.1574126683.git.daniel@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25637/Mon Nov 18 10:53:23 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add initial poke table data structures and management to the BPF
prog that can later be used by JITs. Also add an instance of poke
specific data for tail call maps; plan for later work is to extend
this also for BPF static keys.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 include/linux/bpf.h    | 20 ++++++++++++++++++++
 include/linux/filter.h | 10 ++++++++++
 kernel/bpf/core.c      | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 836e49855bf9..cad4382c1265 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -488,6 +488,24 @@ struct bpf_func_info_aux {
 	bool unreliable;
 };
 
+enum bpf_jit_poke_reason {
+	BPF_POKE_REASON_TAIL_CALL,
+};
+
+/* Descriptor of pokes pointing /into/ the JITed image. */
+struct bpf_jit_poke_descriptor {
+	void *ip;
+	union {
+		struct {
+			struct bpf_map *map;
+			u32 key;
+		} tail_call;
+	};
+	u8 ip_stable;
+	u8 adj_off;
+	u16 reason;
+};
+
 struct bpf_prog_aux {
 	atomic64_t refcnt;
 	u32 used_map_cnt;
@@ -513,6 +531,8 @@ struct bpf_prog_aux {
 	const char *attach_func_name;
 	struct bpf_prog **func;
 	void *jit_data; /* JIT specific data. arch dependent */
+	struct bpf_jit_poke_descriptor *poke_tab;
+	u32 size_poke_tab;
 	struct latch_tree_node ksym_tnode;
 	struct list_head ksym_lnode;
 	const struct bpf_prog_ops *ops;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index ad80e9c6111c..796b60d8cc6c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -952,6 +952,9 @@ void *bpf_jit_alloc_exec(unsigned long size);
 void bpf_jit_free_exec(void *addr);
 void bpf_jit_free(struct bpf_prog *fp);
 
+int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
+				struct bpf_jit_poke_descriptor *poke);
+
 int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 			  const struct bpf_insn *insn, bool extra_pass,
 			  u64 *func_addr, bool *func_addr_fixed);
@@ -1055,6 +1058,13 @@ static inline bool bpf_prog_ebpf_jited(const struct bpf_prog *fp)
 	return false;
 }
 
+static inline int
+bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
+			    struct bpf_jit_poke_descriptor *poke)
+{
+	return -ENOTSUPP;
+}
+
 static inline void bpf_jit_free(struct bpf_prog *fp)
 {
 	bpf_prog_unlock_free(fp);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 07af9c1d9cf1..608b7085e0c9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -256,6 +256,7 @@ void __bpf_prog_free(struct bpf_prog *fp)
 {
 	if (fp->aux) {
 		free_percpu(fp->aux->stats);
+		kfree(fp->aux->poke_tab);
 		kfree(fp->aux);
 	}
 	vfree(fp);
@@ -756,6 +757,39 @@ int bpf_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 	return ret;
 }
 
+int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
+				struct bpf_jit_poke_descriptor *poke)
+{
+	struct bpf_jit_poke_descriptor *tab = prog->aux->poke_tab;
+	static const u32 poke_tab_max = 1024;
+	u32 slot = prog->aux->size_poke_tab;
+	u32 size = slot + 1;
+
+	if (size > poke_tab_max)
+		return -ENOSPC;
+	if (poke->ip || poke->ip_stable || poke->adj_off)
+		return -EINVAL;
+
+	switch (poke->reason) {
+	case BPF_POKE_REASON_TAIL_CALL:
+		if (!poke->tail_call.map)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	tab = krealloc(tab, size * sizeof(*poke), GFP_KERNEL);
+	if (!tab)
+		return -ENOMEM;
+
+	memcpy(&tab[slot], poke, sizeof(*poke));
+	prog->aux->size_poke_tab = size;
+	prog->aux->poke_tab = tab;
+
+	return slot;
+}
+
 static atomic_long_t bpf_jit_current;
 
 /* Can be overridden by an arch's JIT compiler if it has a custom,
-- 
2.21.0

