Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9E01107D5D
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2019 08:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfKWHMx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Nov 2019 02:12:53 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35505 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfKWHMw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Nov 2019 02:12:52 -0500
Received: by mail-pg1-f193.google.com with SMTP id k32so4565664pgl.2;
        Fri, 22 Nov 2019 23:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PeWZTEuJrBIsRU3Dqk2B5sO+TsetSi05gotUvOhuUFg=;
        b=mNfrCr490Mn5bJ8BhPvyIW34HpDEEXy1LnJgJ7XoMJeEKvT1Uw4m1vhvFC4ad5WVZ2
         xlFPhxmidKxAukXNN/8rG91OQO8OKDeTjuf9t+R2ExOuuwx3MEjZFhHZsO9llnJnguRD
         KC9EiP8SKNdhKv9IXJQkgbrxX/c4/m14yrSLAwIBthJ7PkoJSfZE7IecASc0tWqz+zm9
         ToabvIcp7GPT2+i1qcRUHq39Mbojy2j4Ff/zqBF1rIGQGRF+mRyW8EZv+/+Kj6OC06Ya
         W2+91/ne14rZFohZ5CLep0Cf5jW3WrzMWfRfDxgJ3uXtnyVKHFR+ZrGgO1J3pyGG8unc
         1gNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PeWZTEuJrBIsRU3Dqk2B5sO+TsetSi05gotUvOhuUFg=;
        b=WZmPaZfyP2KRMgKCbfWViI20B70hmSxQB4mOq2izsV1NholhKLdMcX2RP6bCn+fMx3
         2wVIjd+FcPgZehe9zwJ5UdMvmQepNHOnpW7flZzvpiicgX3da8M8DZLblEBT5BLr50UJ
         r47X8wwGlhp/qgiStnZwLowCSX0Gm1/6OLSoIBY3BYK07fwdJehTQbwuYqXjpsV7h/QU
         LKNB4Ad+knfqUonhxcbzSgG6gfkEbZ1dHjclVN0/gKZ3ir34VahI9Ws4rOAf+FCkIEBn
         jEDwlh3GuhaVinZ4xuipE3TbwDNOWtcuTW30Mfp+3+r9YjxWtS3JP22Eqx2SRxB+pdwl
         iFsg==
X-Gm-Message-State: APjAAAXF6fwnRuYcB27CGN0sAlfgho18DpCN3sgvSiEgzvuhdhBO5Hm2
        gbehUcETGgMtpXyaQ7pjUfUlxtII0ls8xQ==
X-Google-Smtp-Source: APXvYqydpeddLk95Ck7QswfjvIIqiFgji4Z/fcClG8vXY8hMFAvByzW0Omfki2ojqBY9AzmprFhXsA==
X-Received: by 2002:a65:5c48:: with SMTP id v8mr20766404pgr.419.1574493171053;
        Fri, 22 Nov 2019 23:12:51 -0800 (PST)
Received: from btopel-mobl.ger.intel.com ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id 67sm798960pjz.27.2019.11.22.23.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 23:12:50 -0800 (PST)
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To:     netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        bpf@vger.kernel.org, magnus.karlsson@gmail.com,
        magnus.karlsson@intel.com, jonathan.lemon@gmail.com,
        ecree@solarflare.com, thoiland@redhat.com,
        andrii.nakryiko@gmail.com, tariqt@mellanox.com,
        saeedm@mellanox.com, maximmi@mellanox.com
Subject: [PATCH bpf-next v2 1/6] bpf: introduce BPF dispatcher
Date:   Sat, 23 Nov 2019 08:12:20 +0100
Message-Id: <20191123071226.6501-2-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191123071226.6501-1-bjorn.topel@gmail.com>
References: <20191123071226.6501-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

The BPF dispatcher is a multiway branch code generator, mainly
targeted for XDP programs. When an XDP program is executed via the
bpf_prog_run_xdp(), it is invoked via an indirect call. With
retpolines enabled, the indirect call has a substantial performance
impact. The dispatcher is a mechanism that transform multiple indirect
calls to direct calls, and therefore avoids the retpoline. The
dispatcher is generated using the BPF JIT, and relies on text poking
provided by bpf_arch_text_poke().

The dispatcher hijacks a trampoline function it via the __fentry__ nop
of the trampoline. One dispatcher instance currently supports up to 16
dispatch points. This can be extended in the future.

An example: A module/driver allocates a dispatcher. The dispatcher is
shared for all netdevs. Each unique XDP program has a slot in the
dispatcher, registered by a netdev. The netdev then uses the
dispatcher to call the correct program with a direct call.

Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
---
 arch/x86/net/bpf_jit_comp.c | 135 +++++++++++++++++++++++
 kernel/bpf/Makefile         |   1 +
 kernel/bpf/dispatcher.c     | 208 ++++++++++++++++++++++++++++++++++++
 3 files changed, 344 insertions(+)
 create mode 100644 kernel/bpf/dispatcher.c

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 15615c94804f..9ca81bc9e7f3 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -10,10 +10,12 @@
 #include <linux/if_vlan.h>
 #include <linux/bpf.h>
 #include <linux/memory.h>
+#include <linux/sort.h>
 #include <asm/extable.h>
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
 #include <asm/text-patching.h>
+#include <asm/asm-prototypes.h>
 
 static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
 {
@@ -1565,6 +1567,139 @@ int arch_prepare_bpf_trampoline(void *image, struct btf_func_model *m, u32 flags
 	return 0;
 }
 
+#if defined(CONFIG_BPF_JIT) && defined(CONFIG_RETPOLINE)
+
+static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+	s64 offset;
+
+	offset = func - (ip + 2 + 4);
+	if (!is_simm32(offset)) {
+		pr_err("Target %p is out of range\n", func);
+		return -EINVAL;
+	}
+	EMIT2_off32(0x0F, jmp_cond + 0x10, offset);
+	*pprog = prog;
+	return 0;
+}
+
+static void emit_nops(u8 **pprog, unsigned int len)
+{
+	unsigned int i, noplen;
+	u8 *prog = *pprog;
+	int cnt = 0;
+
+	while (len > 0) {
+		noplen = len;
+
+		if (noplen > ASM_NOP_MAX)
+			noplen = ASM_NOP_MAX;
+
+		for (i = 0; i < noplen; i++)
+			EMIT1(ideal_nops[noplen][i]);
+		len -= noplen;
+	}
+
+	*pprog = prog;
+}
+
+static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs)
+{
+	u8 *jg_reloc, *jg_target, *prog = *pprog;
+	int pivot, err, jg_bytes = 1, cnt = 0;
+	s64 jg_offset;
+
+	if (a == b) {
+		/* Leaf node of recursion, i.e. not a range of indices
+		 * anymore.
+		 */
+		EMIT1(add_1mod(0x48, BPF_REG_3));	/* cmp rdx,func */
+		if (!is_simm32(progs[a]))
+			return -1;
+		EMIT2_off32(0x81, add_1reg(0xF8, BPF_REG_3),
+			    progs[a]);
+		err = emit_cond_near_jump(&prog,	/* je func */
+					  (void *)progs[a], prog,
+					  X86_JE);
+		if (err)
+			return err;
+
+		err = emit_jump(&prog,			/* jmp thunk */
+				__x86_indirect_thunk_rdx, prog);
+		if (err)
+			return err;
+
+		*pprog = prog;
+		return 0;
+	}
+
+	/* Not a leaf node, so we pivot, and recursively descend into
+	 * the lower and upper ranges.
+	 */
+	pivot = (b - a) / 2;
+	EMIT1(add_1mod(0x48, BPF_REG_3));		/* cmp rdx,func */
+	if (!is_simm32(progs[a + pivot]))
+		return -1;
+	EMIT2_off32(0x81, add_1reg(0xF8, BPF_REG_3), progs[a + pivot]);
+
+	if (pivot > 2) {				/* jg upper_part */
+		/* Require near jump. */
+		jg_bytes = 4;
+		EMIT2_off32(0x0F, X86_JG + 0x10, 0);
+	} else {
+		EMIT2(X86_JG, 0);
+	}
+	jg_reloc = prog;
+
+	err = emit_bpf_dispatcher(&prog, a, a + pivot,	/* emit lower_part */
+				  progs);
+	if (err)
+		return err;
+
+	/* Intel 64 and IA-32 ArchitecturesOptimization Reference
+	 * Manual, 3.4.1.5 Code Alignment Assembly/Compiler Coding
+	 * Rule 12. (M impact, H generality) All branch targets should
+	 * be 16-byte aligned.
+	 */
+	jg_target = PTR_ALIGN(prog, 16);
+	if (jg_target != prog)
+		emit_nops(&prog, jg_target - prog);
+	jg_offset = prog - jg_reloc;
+	emit_code(jg_reloc - jg_bytes, jg_offset, jg_bytes);
+
+	err = emit_bpf_dispatcher(&prog, a + pivot + 1,	/* emit upper_part */
+				  b, progs);
+	if (err)
+		return err;
+
+	*pprog = prog;
+	return 0;
+}
+
+static int cmp_ips(const void *a, const void *b)
+{
+	const s64 *ipa = a;
+	const s64 *ipb = b;
+
+	if (*ipa > *ipb)
+		return 1;
+	if (*ipa < *ipb)
+		return -1;
+	return 0;
+}
+
+int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs)
+{
+	u8 *prog = image;
+
+	sort(funcs, num_funcs, sizeof(funcs[0]), cmp_ips, NULL);
+	return emit_bpf_dispatcher(&prog, 0, num_funcs - 1, funcs);
+}
+
+#endif
+
 struct x64_jit_data {
 	struct bpf_binary_header *header;
 	int *addrs;
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 3f671bf617e8..d4f330351f87 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
 obj-$(CONFIG_BPF_SYSCALL) += btf.o
+obj-$(CONFIG_BPF_JIT) += dispatcher.o
 ifeq ($(CONFIG_NET),y)
 obj-$(CONFIG_BPF_SYSCALL) += devmap.o
 obj-$(CONFIG_BPF_SYSCALL) += cpumap.o
diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
new file mode 100644
index 000000000000..385dd76ab6d2
--- /dev/null
+++ b/kernel/bpf/dispatcher.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2019 Intel Corporation. */
+
+#ifdef CONFIG_RETPOLINE
+
+#include <linux/hash.h>
+#include <linux/bpf.h>
+#include <linux/filter.h>
+
+/* The BPF dispatcher is a multiway branch code generator. The
+ * dispatcher is a mechanism to avoid the performance penalty of an
+ * indirect call when retpolines are enabled. A dispatch client tries
+ * to register a BPF program into the dispatcher, and if there is
+ * available room in the dispatcher a direct call to the BPF program
+ * will be generated. All calls to the BPF programs called via the
+ * dispatcher will then be a direct call, instead of an indirect. The
+ * dispatcher hijacks a trampoline function it via the __fentry__ of
+ * the trampoline. The trampoline function has the following
+ * signature:
+ *	unsigned int trampoline(
+ *		const void *xdp_ctx,
+ *		const struct bpf_insn *insnsi,
+ *		unsigned int (*bpf_func)(const void *,
+ *					 const struct bpf_insn *));
+ *
+ * Direct use of the dispatcher is discouraged, and instead a wrapper
+ * such as xdp_call.h should be used.
+ */
+
+#define DISPATCHER_HASH_BITS 10
+#define DISPATCHER_TABLE_SIZE (1 << DISPATCHER_HASH_BITS)
+
+static struct hlist_head dispatcher_table[DISPATCHER_TABLE_SIZE];
+
+#define BPF_DISPATCHER_MAX 16
+
+struct bpf_dispatcher {
+	struct hlist_node hlist;
+	void *func;
+	struct bpf_prog *progs[BPF_DISPATCHER_MAX];
+	int num_progs;
+	void *image;
+	u64 selector;
+};
+
+static DEFINE_MUTEX(dispatcher_mutex);
+
+static struct bpf_dispatcher *bpf_dispatcher_lookup(void *func)
+{
+	struct bpf_dispatcher *d;
+	struct hlist_head *head;
+	void *image;
+
+	head = &dispatcher_table[hash_ptr(func, DISPATCHER_HASH_BITS)];
+	hlist_for_each_entry(d, head, hlist) {
+		if (d->func == func)
+			return d;
+	}
+	d = kzalloc(sizeof(*d), GFP_KERNEL);
+	if (!d)
+		return NULL;
+
+	image = bpf_jit_alloc_exec(PAGE_SIZE);
+	if (!image) {
+		kfree(d);
+		return NULL;
+	}
+
+	d->func = func;
+	INIT_HLIST_NODE(&d->hlist);
+	hlist_add_head(&d->hlist, head);
+
+	set_vm_flush_reset_perms(image);
+	set_memory_x((long)image, 1);
+	d->image = image;
+	return d;
+}
+
+static void bpf_dispatcher_free(struct bpf_dispatcher *d)
+{
+	bpf_jit_free_exec(d->image);
+	hlist_del(&d->hlist);
+	kfree(d);
+}
+
+static bool bpf_dispatcher_add_prog(struct bpf_dispatcher *d,
+				    struct bpf_prog *prog)
+{
+	struct bpf_prog **entry = NULL;
+	int i;
+
+	if (!prog)
+		return false;
+
+	if (d->num_progs == BPF_DISPATCHER_MAX)
+		return false;
+
+	for (i = 0; i < BPF_DISPATCHER_MAX; i++) {
+		if (!entry && !d->progs[i])
+			entry = &d->progs[i];
+		if (d->progs[i] == prog)
+			return false;
+	}
+
+	bpf_prog_inc(prog);
+	*entry = prog;
+	d->num_progs++;
+	return true;
+}
+
+static bool bpf_dispatcher_remove_prog(struct bpf_dispatcher *d,
+				       struct bpf_prog *prog)
+{
+	int i;
+
+	if (!prog)
+		return false;
+
+	for (i = 0; i < BPF_DISPATCHER_MAX; i++) {
+		if (d->progs[i] == prog) {
+			bpf_prog_put(prog);
+			d->progs[i] = NULL;
+			d->num_progs--;
+			return true;
+		}
+	}
+	return false;
+}
+
+int __weak arch_prepare_bpf_dispatcher(void *image, s64 *funcs,
+				       int num_funcs)
+{
+	return -ENOTSUPP;
+}
+
+static void bpf_dispatcher_update(struct bpf_dispatcher *d)
+{
+	void *old_image = d->image + ((d->selector + 1) & 1) * PAGE_SIZE / 2;
+	void *new_image = d->image + (d->selector & 1) * PAGE_SIZE / 2;
+	s64 ips[BPF_DISPATCHER_MAX] = {}, *ipsp = &ips[0];
+	int i, err;
+
+	if (!d->num_progs) {
+		bpf_arch_text_poke(d->func, BPF_MOD_JUMP_TO_NOP,
+				   old_image, NULL);
+		return;
+	}
+
+	for (i = 0; i < BPF_DISPATCHER_MAX; i++) {
+		if (d->progs[i])
+			*ipsp++ = (s64)(uintptr_t)d->progs[i]->bpf_func;
+	}
+	err = arch_prepare_bpf_dispatcher(new_image, &ips[0], d->num_progs);
+	if (err)
+		return;
+
+	if (d->selector) {
+		/* progs already running at this address */
+		err = bpf_arch_text_poke(d->func, BPF_MOD_JUMP_TO_JUMP,
+					 old_image, new_image);
+	} else {
+		/* first time registering */
+		err = bpf_arch_text_poke(d->func, BPF_MOD_NOP_TO_JUMP,
+					 NULL, new_image);
+	}
+	if (err)
+		return;
+	d->selector++;
+}
+
+void bpf_dispatcher_change_prog(void *func, struct bpf_prog *from,
+				struct bpf_prog *to)
+{
+	struct bpf_dispatcher *d;
+	bool changed = false;
+
+	if (from == to)
+		return;
+
+	mutex_lock(&dispatcher_mutex);
+	d = bpf_dispatcher_lookup(func);
+	if (!d)
+		goto out;
+
+	changed |= bpf_dispatcher_remove_prog(d, from);
+	changed |= bpf_dispatcher_add_prog(d, to);
+
+	if (!changed)
+		goto out;
+
+	bpf_dispatcher_update(d);
+	if (!d->num_progs)
+		bpf_dispatcher_free(d);
+out:
+	mutex_unlock(&dispatcher_mutex);
+}
+
+static int __init init_dispatchers(void)
+{
+	int i;
+
+	for (i = 0; i < DISPATCHER_TABLE_SIZE; i++)
+		INIT_HLIST_HEAD(&dispatcher_table[i]);
+	return 0;
+}
+late_initcall(init_dispatchers);
+
+#endif
-- 
2.20.1

