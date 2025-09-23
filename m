Return-Path: <bpf+bounces-69491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA9AB97A82
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 23:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0714C4699
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 21:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6E63126BC;
	Tue, 23 Sep 2025 21:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFtdiphn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B16730E82D;
	Tue, 23 Sep 2025 21:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664415; cv=none; b=lZuGaznuT9v70/McuBHi0NymrMz+0XtQK+ajskw4KHvhSWHqM6DwZ2/EJm3NrI2/qgg6fhNruopIYlgDSbA+vI7hOle8YpYxDiLXJjzPdtQc3ecwUuY6bCkYO9Ks+jyY/2g8pV3RZvRgg9xTmdmGGpoB4rluNkzEGdROOVNF32Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664415; c=relaxed/simple;
	bh=43T9HLopp5TSSfaS/PpEBs04jnF5DnlAwLGcj6tvQ8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bw5+c6M+t4iZhi6yWxSPk3N2z0WQrWxZpSDK9RTxAT/Uwcr4njGdqmOtpZBOUO1C7US5SNvjpybfacuxHbrygVoYVu3L+9cavlZFdFeW1NunwfS6sX036IBtB/G60SkG/UzDw+eRtG2n7xkONMKnQxlNCsn1AgTPM7HB6oIdHYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFtdiphn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D072C4CEF5;
	Tue, 23 Sep 2025 21:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758664415;
	bh=43T9HLopp5TSSfaS/PpEBs04jnF5DnlAwLGcj6tvQ8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QFtdiphnN9U6PqfI4yB+FMCirtdRv+x4abZHcBByKq62QTC45K2gDopib2ulQNxDb
	 w+HUWaDby+yb+VNyzwN+0gQrESBnT43VpPMATSYgc1DbjLs7r+YgDnxeIg0K8xfDdv
	 pE5yM0R/CrUBYjye8s/9oNBEKYKWFdpsVUbaLuyWDfI3Tlq7DFt8sEn1o3fjG0psp3
	 gflVn+TR38Tu5VPU5U+AwKXvQgdmNeUpOpFhr6Sc+Rz8+LNVSSSN/pI76pqzXROjDb
	 YnuZUIIpmZMN4HAXlMmYj5gleREbbO7ujyhVDrMCjLTHukL9FRbMD9Y4w+gEWW5a/q
	 kqq2AXN8Lgi5w==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>,
	Florent Revest <revest@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: [PATCH 9/9] bpf, x86: Use single ftrace_ops for direct calls
Date: Tue, 23 Sep 2025 23:51:47 +0200
Message-ID: <20250923215147.1571952-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923215147.1571952-1-jolsa@kernel.org>
References: <20250923215147.1571952-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using single ftrace_ops for direct calls update instead of allocating
ftrace_ops obejct for each trampoline.

At the moment we can enable this only on x86 arch, because arm relies
on ftrace_ops object representing just single trampoline image (stored
in ftrace_ops::direct_call).

Adding HAVE_SINGLE_FTRACE_DIRECT_OPS config option to be enabled on
each arch that supports this.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/Kconfig        |  1 +
 kernel/bpf/trampoline.c | 85 +++++++++++++++++++++++++++++++++++------
 kernel/trace/Kconfig    |  3 ++
 kernel/trace/ftrace.c   | 15 +++++++-
 4 files changed, 92 insertions(+), 12 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 52c8910ba2ef..bfc9115baa6f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -330,6 +330,7 @@ config X86
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
 	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
+	select HAVE_SINGLE_FTRACE_DIRECT_OPS	if X86_64 && DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 3464859189a2..e3b721773dfb 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -33,12 +33,40 @@ static DEFINE_MUTEX(trampoline_mutex);
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex);
 
+#ifdef CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS
+static struct bpf_trampoline *direct_ops_ip_lookup(struct ftrace_ops *ops, unsigned long ip)
+{
+	struct hlist_head *head_ip;
+	struct bpf_trampoline *tr;
+
+	mutex_lock(&trampoline_mutex);
+	head_ip = &trampoline_ip_table[hash_64(ip, TRAMPOLINE_HASH_BITS)];
+	hlist_for_each_entry(tr, head_ip, hlist_ip) {
+		if (tr->func.addr == (void *) ip)
+			goto out;
+	}
+	tr = NULL;
+out:
+	mutex_unlock(&trampoline_mutex);
+	return tr;
+}
+#else
+static struct bpf_trampoline *direct_ops_ip_lookup(struct ftrace_ops *ops, unsigned long ip)
+{
+	return ops->private;
+}
+#endif /* CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS */
+
 static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
 				     enum ftrace_ops_cmd cmd)
 {
-	struct bpf_trampoline *tr = ops->private;
+	struct bpf_trampoline *tr;
 	int ret = 0;
 
+	tr = direct_ops_ip_lookup(ops, ip);
+	if (!tr)
+		return -EINVAL;
+
 	if (cmd == FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_SELF) {
 		/* This is called inside register_ftrace_direct_multi(), so
 		 * tr->mutex is already locked.
@@ -137,6 +165,48 @@ void bpf_image_ksym_del(struct bpf_ksym *ksym)
 			   PAGE_SIZE, true, ksym->name);
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+#ifdef CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS
+struct ftrace_ops direct_ops = {
+       .ops_func = bpf_tramp_ftrace_ops_func,
+};
+
+static int direct_ops_get(struct bpf_trampoline *tr)
+{
+	tr->fops = &direct_ops;
+	return 0;
+}
+static void direct_ops_clear(struct bpf_trampoline *tr) { }
+static void direct_ops_free(struct bpf_trampoline *tr) { }
+#else
+static int direct_ops_get(struct bpf_trampoline *tr)
+{
+	tr->fops = kzalloc(sizeof(struct ftrace_ops), GFP_KERNEL);
+	if (!tr->fops)
+		return -1;
+	tr->fops->private = tr;
+	tr->fops->ops_func = bpf_tramp_ftrace_ops_func;
+	return 0;
+}
+
+static void direct_ops_clear(struct bpf_trampoline *tr)
+{
+	tr->fops->func = NULL;
+	tr->fops->trampoline = 0;
+}
+
+static void direct_ops_free(struct bpf_trampoline *tr)
+{
+	if (tr->fops) {
+		ftrace_free_filter(tr->fops);
+		kfree(tr->fops);
+	}
+}
+#endif /* CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS */
+#else
+static void direct_ops_free(struct bpf_trampoline *tr) { }
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
+
 static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
 {
 	struct bpf_trampoline *tr;
@@ -155,14 +225,11 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
 	if (!tr)
 		goto out;
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-	tr->fops = kzalloc(sizeof(struct ftrace_ops), GFP_KERNEL);
-	if (!tr->fops) {
+	if (direct_ops_get(tr)) {
 		kfree(tr);
 		tr = NULL;
 		goto out;
 	}
-	tr->fops->private = tr;
-	tr->fops->ops_func = bpf_tramp_ftrace_ops_func;
 #endif
 
 	tr->key = key;
@@ -482,8 +549,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		 * trampoline again, and retry register.
 		 */
 		/* reset fops->func and fops->trampoline for re-register */
-		tr->fops->func = NULL;
-		tr->fops->trampoline = 0;
+		direct_ops_clear(tr);
 
 		/* free im memory and reallocate later */
 		bpf_tramp_image_free(im);
@@ -864,10 +930,7 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	 */
 	hlist_del(&tr->hlist_key);
 	hlist_del(&tr->hlist_ip);
-	if (tr->fops) {
-		ftrace_free_filter(tr->fops);
-		kfree(tr->fops);
-	}
+	direct_ops_free(tr);
 	kfree(tr);
 out:
 	mutex_unlock(&trampoline_mutex);
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index d2c79da81e4f..4bf5beb04a5b 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -50,6 +50,9 @@ config HAVE_DYNAMIC_FTRACE_WITH_REGS
 config HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	bool
 
+config HAVE_SINGLE_FTRACE_DIRECT_OPS
+	bool
+
 config HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
 	bool
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 2af1304d1a83..c4b969fb1010 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2592,8 +2592,13 @@ unsigned long ftrace_find_rec_direct(unsigned long ip)
 static void call_direct_funcs(unsigned long ip, unsigned long pip,
 			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
-	unsigned long addr = READ_ONCE(ops->direct_call);
+	unsigned long addr;
 
+#ifdef CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS
+	addr = ftrace_find_rec_direct(ip);
+#else
+	addr = READ_ONCE(ops->direct_call);
+#endif
 	if (!addr)
 		return;
 
@@ -5986,6 +5991,10 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long ip, unsigned lo
 	if (!hash)
 		return -ENOMEM;
 
+#ifndef CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS
+	ops->direct_call = addr;
+#endif
+
 	err = register_ftrace_direct_hash(ops, hash);
 	free_ftrace_hash(hash);
 	return err;
@@ -6050,6 +6059,10 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long ip, unsigned long
 		return -ENOMEM;
 
 	err = modify_ftrace_direct_hash(ops, hash, lock_direct_mutex);
+#ifndef CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS
+	if (!err)
+		ops->direct_call = addr;
+#endif
 	free_ftrace_hash(hash);
 	return err;
 }
-- 
2.51.0


