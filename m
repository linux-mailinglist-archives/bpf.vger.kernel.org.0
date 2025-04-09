Return-Path: <bpf+bounces-55498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61204A81B83
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 05:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23AAE1B64266
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 03:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF111D6DDD;
	Wed,  9 Apr 2025 03:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="D9hngyZa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mQ9JDIIv"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025FD1B0F19;
	Wed,  9 Apr 2025 03:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744169688; cv=none; b=GyE1yFEYteY5EN6dEOcwvh1GDtjbf2naDLNbv3li7FN5RlE6UxPIYcXYTM3fVlJpab3IdusXVm4J+MqHwwUcecDejuMRDky5dkSrIf60NshC8AxB5VsolYambnZsB839dyP4Wnxyfvt2b+DNRvtYDtATtw3SaLruIIE0pXjd+m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744169688; c=relaxed/simple;
	bh=QXr34y1BBnk95UOhAjZL1nmam+j0Fdcl94+3BfUENI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uquL6QMHUCMpf/Gmh71PatDzjUb9EZbog0miyezriODFzvuA3lUbaxtLwax+TK2ouCf2Zt8x0NhRpZgijlHmbKRJbyTAwjO+IqJcsPCiJ6kIXs4VmILLWPOyYkjVRxSE28UL/GKVXvXbvpvPJg+Q5EGHd7Kzs/2rXxepxVd0w3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=D9hngyZa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mQ9JDIIv; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F32C511401EC;
	Tue,  8 Apr 2025 23:34:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 08 Apr 2025 23:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1744169683; x=
	1744256083; bh=OM4hK3F4t50b4B6ugerD2gic1tcnPFDEvF+QwAo4ZqA=; b=D
	9hngyZaXk4RZ76LoqaTYboTmAHmENJ3fpjq2h6M4W4PskjI3mky1sSlIH+eSujg0
	l9AgEUqOd7PLONNzNtV/m70NvKpFQCnn8H+mow84OBwG7XNNsp/04pcouwC7xKW+
	NSjKbIwOb4HWr1EvZmL8aWbZCZPGU7fVKVK5fpTM2wpaQflaZray+zCwCO/bmvu4
	fIeSW7O71mSSpkpr8/0Wrce2//Wvv85dvrbi1FTI4TcVtDA0APkzKYNIfVq/qJsp
	afnfQEEnaS3FGCV7vWwNZ/UIw6DyzKLCkZjwexHgHEFpXHmJDI01tsfOb3xmZM7B
	A+mLo6kd4eTd2ctwYodGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744169683; x=1744256083; bh=O
	M4hK3F4t50b4B6ugerD2gic1tcnPFDEvF+QwAo4ZqA=; b=mQ9JDIIvS8zcFEiw4
	LKu62FmfpRk+SdSFf+0/EeVKZtvGcw8rqFrqubFZ2mBSt8fdojn7DL1Q/AUefylp
	16u5GvtD7JFKvbBlc5M24nlTXOiB6xdRhUp8JPAHuDYSGXynMJQtMmfCuXWTWfsn
	Pauz1DCzy8HSseN9wnL4nOiQrQkngLSbKswe4wKZMwgN/oX50uTM6LN8k5u5iknZ
	F7qid1xeTYcUXayYDlH6jytpkEDHojpzt28T6V2QVMUrKCDn+61DVXfWdxq5XLaO
	L492T8gD4jGXmX9nZFQqxGfP5+hY+XJdhrdTR71Uqr1pVGo0SUxrhWGl8NGyGM1m
	STttw==
X-ME-Sender: <xms:0-r1Z244R3FvEmf-2b6WkB_lPEdKAJvmSzeOosiFTkUWL0slGuNn1A>
    <xme:0-r1Z_72Y-koAgL8AzQOiyBwRzGXuQfEL3CcixhUR1vwVUiMci09B0m9z3ZT90-w9
    NdL4PF-qby8XW8ztQ>
X-ME-Received: <xmr:0-r1Z1e2AB3RoiYInNCvbr-F7VG9mQ123o8xb5y5ZFZAzsRFpN8wicJ4qQSILImX0brXG9bQoyqh1Si_PZaEgPRORp5Yw4BLLOnzqJtGTeFtyGEz4vv6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdegledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffuc
    dljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhm
    peffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvg
    hrnhepgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepugiguh
    esugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    hstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgs
    ohigrdhnvghtpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghp
    thhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhngheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhu
    gidruggvvhdprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0-r1ZzI5N8zt0RlzBi4lvpHq51wGVQNVM1otzwS2IZ9TkGWYLwWOPQ>
    <xmx:0-r1Z6IKQuOHJ0n2W2wi_alSgsXRuVquxE8i7_lYbxXZUNj1j-HIjA>
    <xmx:0-r1Z0yv6uKTmAOReha-qujVAkyyiqcrs8heawPlB-nybMzVNcjgzA>
    <xmx:0-r1Z-J8GGzoutXZ_ETE5IK5zV8UaWr2VGJf1WFw2g4-x5wNt3wx6w>
    <xmx:0-r1ZybSclKNceyved3zLxvYvCGAkxUYV9DtjbVQ_0HE1JBzc1bgR371>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 23:34:42 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC bpf-next 04/13] bpf: Move bpf_check_attach_target() to core
Date: Tue,  8 Apr 2025 21:33:59 -0600
Message-ID: <9448dae93bf91b62fb6e097cf783d0277fdeb542.1744169424.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1744169424.git.dxu@dxuuu.xyz>
References: <cover.1744169424.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This routine is used in a few other places in BPF subsystem. In an
effort to make verifier.c a leaf node, move the definition as well as
some other single use helpers into core.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/bpf.h          |   6 +
 include/linux/bpf_verifier.h |   5 -
 kernel/bpf/core.c            | 368 +++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 363 ----------------------------------
 4 files changed, 374 insertions(+), 368 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8e26141f3e7e..e0bd78ff1540 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2002,6 +2002,12 @@ static inline void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog)
 }
 #endif
 
+int bpf_check_attach_target(struct bpf_verifier_log *log,
+			    const struct bpf_prog *prog,
+			    const struct bpf_prog *tgt_prog,
+			    u32 btf_id,
+			    struct bpf_attach_target_info *tgt_info);
+
 struct bpf_array {
 	struct bpf_map map;
 	u32 elem_size;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9734544b6957..f61f5429647a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -879,11 +879,6 @@ static inline void bpf_trampoline_unpack_key(u64 key, u32 *obj_id, u32 *btf_id)
 		*btf_id = key & 0x7FFFFFFF;
 }
 
-int bpf_check_attach_target(struct bpf_verifier_log *log,
-			    const struct bpf_prog *prog,
-			    const struct bpf_prog *tgt_prog,
-			    u32 btf_id,
-			    struct bpf_attach_target_info *tgt_info);
 void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 
 int mark_chain_precision(struct bpf_verifier_env *env, int regno);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 80ba83cb6350..aaf0841140c0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -38,6 +38,8 @@
 #include <linux/bpf_mem_alloc.h>
 #include <linux/memcontrol.h>
 #include <linux/execmem.h>
+#include <linux/bpf_lsm.h>
+#include <linux/trace_events.h>
 
 #include <asm/barrier.h>
 #include <linux/unaligned.h>
@@ -74,6 +76,372 @@ EXPORT_SYMBOL_GPL(bpf_global_percpu_ma);
 bool bpf_global_percpu_ma_set;
 EXPORT_SYMBOL_GPL(bpf_global_percpu_ma_set);
 
+/* list of non-sleepable functions that are otherwise on
+ * ALLOW_ERROR_INJECTION list
+ */
+BTF_SET_START(btf_non_sleepable_error_inject)
+/* Three functions below can be called from sleepable and non-sleepable context.
+ * Assume non-sleepable from bpf safety point of view.
+ */
+BTF_ID(func, __filemap_add_folio)
+#ifdef CONFIG_FAIL_PAGE_ALLOC
+BTF_ID(func, should_fail_alloc_page)
+#endif
+#ifdef CONFIG_FAILSLAB
+BTF_ID(func, should_failslab)
+#endif
+BTF_SET_END(btf_non_sleepable_error_inject)
+
+#define SECURITY_PREFIX "security_"
+
+static int check_attach_modify_return(unsigned long addr, const char *func_name)
+{
+	if (within_error_injection_list(addr) ||
+	    !strncmp(SECURITY_PREFIX, func_name, sizeof(SECURITY_PREFIX) - 1))
+		return 0;
+
+	return -EINVAL;
+}
+
+
+static int check_non_sleepable_error_inject(u32 btf_id)
+{
+	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
+}
+
+
+int bpf_check_attach_target(struct bpf_verifier_log *log,
+			    const struct bpf_prog *prog,
+			    const struct bpf_prog *tgt_prog,
+			    u32 btf_id,
+			    struct bpf_attach_target_info *tgt_info)
+{
+	bool prog_extension = prog->type == BPF_PROG_TYPE_EXT;
+	bool prog_tracing = prog->type == BPF_PROG_TYPE_TRACING;
+	char trace_symbol[KSYM_SYMBOL_LEN];
+	const char prefix[] = "btf_trace_";
+	struct bpf_raw_event_map *btp;
+	int ret = 0, subprog = -1, i;
+	const struct btf_type *t;
+	bool conservative = true;
+	const char *tname, *fname;
+	struct btf *btf;
+	long addr = 0;
+	struct module *mod = NULL;
+
+	if (!btf_id) {
+		bpf_log(log, "Tracing programs must provide btf_id\n");
+		return -EINVAL;
+	}
+	btf = tgt_prog ? tgt_prog->aux->btf : prog->aux->attach_btf;
+	if (!btf) {
+		bpf_log(log,
+			"FENTRY/FEXIT program can only be attached to another program annotated with BTF\n");
+		return -EINVAL;
+	}
+	t = btf_type_by_id(btf, btf_id);
+	if (!t) {
+		bpf_log(log, "attach_btf_id %u is invalid\n", btf_id);
+		return -EINVAL;
+	}
+	tname = btf_name_by_offset(btf, t->name_off);
+	if (!tname) {
+		bpf_log(log, "attach_btf_id %u doesn't have a name\n", btf_id);
+		return -EINVAL;
+	}
+	if (tgt_prog) {
+		struct bpf_prog_aux *aux = tgt_prog->aux;
+		bool tgt_changes_pkt_data;
+		bool tgt_might_sleep;
+
+		if (bpf_prog_is_dev_bound(prog->aux) &&
+		    !bpf_prog_dev_bound_match(prog, tgt_prog)) {
+			bpf_log(log, "Target program bound device mismatch");
+			return -EINVAL;
+		}
+
+		for (i = 0; i < aux->func_info_cnt; i++)
+			if (aux->func_info[i].type_id == btf_id) {
+				subprog = i;
+				break;
+			}
+		if (subprog == -1) {
+			bpf_log(log, "Subprog %s doesn't exist\n", tname);
+			return -EINVAL;
+		}
+		if (aux->func && aux->func[subprog]->aux->exception_cb) {
+			bpf_log(log,
+				"%s programs cannot attach to exception callback\n",
+				prog_extension ? "Extension" : "FENTRY/FEXIT");
+			return -EINVAL;
+		}
+		conservative = aux->func_info_aux[subprog].unreliable;
+		if (prog_extension) {
+			if (conservative) {
+				bpf_log(log,
+					"Cannot replace static functions\n");
+				return -EINVAL;
+			}
+			if (!prog->jit_requested) {
+				bpf_log(log,
+					"Extension programs should be JITed\n");
+				return -EINVAL;
+			}
+			tgt_changes_pkt_data = aux->func
+					       ? aux->func[subprog]->aux->changes_pkt_data
+					       : aux->changes_pkt_data;
+			if (prog->aux->changes_pkt_data && !tgt_changes_pkt_data) {
+				bpf_log(log,
+					"Extension program changes packet data, while original does not\n");
+				return -EINVAL;
+			}
+
+			tgt_might_sleep = aux->func
+					  ? aux->func[subprog]->aux->might_sleep
+					  : aux->might_sleep;
+			if (prog->aux->might_sleep && !tgt_might_sleep) {
+				bpf_log(log,
+					"Extension program may sleep, while original does not\n");
+				return -EINVAL;
+			}
+		}
+		if (!tgt_prog->jited) {
+			bpf_log(log, "Can attach to only JITed progs\n");
+			return -EINVAL;
+		}
+		if (prog_tracing) {
+			if (aux->attach_tracing_prog) {
+				/*
+				 * Target program is an fentry/fexit which is already attached
+				 * to another tracing program. More levels of nesting
+				 * attachment are not allowed.
+				 */
+				bpf_log(log, "Cannot nest tracing program attach more than once\n");
+				return -EINVAL;
+			}
+		} else if (tgt_prog->type == prog->type) {
+			/*
+			 * To avoid potential call chain cycles, prevent attaching of a
+			 * program extension to another extension. It's ok to attach
+			 * fentry/fexit to extension program.
+			 */
+			bpf_log(log, "Cannot recursively attach\n");
+			return -EINVAL;
+		}
+		if (tgt_prog->type == BPF_PROG_TYPE_TRACING &&
+		    prog_extension &&
+		    (tgt_prog->expected_attach_type == BPF_TRACE_FENTRY ||
+		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT)) {
+			/* Program extensions can extend all program types
+			 * except fentry/fexit. The reason is the following.
+			 * The fentry/fexit programs are used for performance
+			 * analysis, stats and can be attached to any program
+			 * type. When extension program is replacing XDP function
+			 * it is necessary to allow performance analysis of all
+			 * functions. Both original XDP program and its program
+			 * extension. Hence attaching fentry/fexit to
+			 * BPF_PROG_TYPE_EXT is allowed. If extending of
+			 * fentry/fexit was allowed it would be possible to create
+			 * long call chain fentry->extension->fentry->extension
+			 * beyond reasonable stack size. Hence extending fentry
+			 * is not allowed.
+			 */
+			bpf_log(log, "Cannot extend fentry/fexit\n");
+			return -EINVAL;
+		}
+	} else {
+		if (prog_extension) {
+			bpf_log(log, "Cannot replace kernel functions\n");
+			return -EINVAL;
+		}
+	}
+
+	switch (prog->expected_attach_type) {
+	case BPF_TRACE_RAW_TP:
+		if (tgt_prog) {
+			bpf_log(log,
+				"Only FENTRY/FEXIT progs are attachable to another BPF prog\n");
+			return -EINVAL;
+		}
+		if (!btf_type_is_typedef(t)) {
+			bpf_log(log, "attach_btf_id %u is not a typedef\n",
+				btf_id);
+			return -EINVAL;
+		}
+		if (strncmp(prefix, tname, sizeof(prefix) - 1)) {
+			bpf_log(log, "attach_btf_id %u points to wrong type name %s\n",
+				btf_id, tname);
+			return -EINVAL;
+		}
+		tname += sizeof(prefix) - 1;
+
+		/* The func_proto of "btf_trace_##tname" is generated from typedef without argument
+		 * names. Thus using bpf_raw_event_map to get argument names.
+		 */
+		btp = bpf_get_raw_tracepoint(tname);
+		if (!btp)
+			return -EINVAL;
+		fname = kallsyms_lookup((unsigned long)btp->bpf_func, NULL, NULL, NULL,
+					trace_symbol);
+		bpf_put_raw_tracepoint(btp);
+
+		if (fname)
+			ret = btf_find_by_name_kind(btf, fname, BTF_KIND_FUNC);
+
+		if (!fname || ret < 0) {
+			bpf_log(log, "Cannot find btf of tracepoint template, fall back to %s%s.\n",
+				prefix, tname);
+			t = btf_type_by_id(btf, t->type);
+			if (!btf_type_is_ptr(t))
+				/* should never happen in valid vmlinux build */
+				return -EINVAL;
+		} else {
+			t = btf_type_by_id(btf, ret);
+			if (!btf_type_is_func(t))
+				/* should never happen in valid vmlinux build */
+				return -EINVAL;
+		}
+
+		t = btf_type_by_id(btf, t->type);
+		if (!btf_type_is_func_proto(t))
+			/* should never happen in valid vmlinux build */
+			return -EINVAL;
+
+		break;
+	case BPF_TRACE_ITER:
+		if (!btf_type_is_func(t)) {
+			bpf_log(log, "attach_btf_id %u is not a function\n",
+				btf_id);
+			return -EINVAL;
+		}
+		t = btf_type_by_id(btf, t->type);
+		if (!btf_type_is_func_proto(t))
+			return -EINVAL;
+		ret = btf_distill_func_proto(log, btf, t, tname, &tgt_info->fmodel);
+		if (ret)
+			return ret;
+		break;
+	default:
+		if (!prog_extension)
+			return -EINVAL;
+		fallthrough;
+	case BPF_MODIFY_RETURN:
+	case BPF_LSM_MAC:
+	case BPF_LSM_CGROUP:
+	case BPF_TRACE_FENTRY:
+	case BPF_TRACE_FEXIT:
+		if (!btf_type_is_func(t)) {
+			bpf_log(log, "attach_btf_id %u is not a function\n",
+				btf_id);
+			return -EINVAL;
+		}
+		if (prog_extension &&
+		    btf_check_type_match(log, prog, btf, t))
+			return -EINVAL;
+		t = btf_type_by_id(btf, t->type);
+		if (!btf_type_is_func_proto(t))
+			return -EINVAL;
+
+		if ((prog->aux->saved_dst_prog_type || prog->aux->saved_dst_attach_type) &&
+		    (!tgt_prog || prog->aux->saved_dst_prog_type != tgt_prog->type ||
+		     prog->aux->saved_dst_attach_type != tgt_prog->expected_attach_type))
+			return -EINVAL;
+
+		if (tgt_prog && conservative)
+			t = NULL;
+
+		ret = btf_distill_func_proto(log, btf, t, tname, &tgt_info->fmodel);
+		if (ret < 0)
+			return ret;
+
+		if (tgt_prog) {
+			if (subprog == 0)
+				addr = (long) tgt_prog->bpf_func;
+			else
+				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
+		} else {
+			if (btf_is_module(btf)) {
+				mod = btf_try_get_module(btf);
+				if (mod)
+					addr = find_kallsyms_symbol_value(mod, tname);
+				else
+					addr = 0;
+			} else {
+				addr = kallsyms_lookup_name(tname);
+			}
+			if (!addr) {
+				module_put(mod);
+				bpf_log(log,
+					"The address of function %s cannot be found\n",
+					tname);
+				return -ENOENT;
+			}
+		}
+
+		if (prog->sleepable) {
+			ret = -EINVAL;
+			switch (prog->type) {
+			case BPF_PROG_TYPE_TRACING:
+
+				/* fentry/fexit/fmod_ret progs can be sleepable if they are
+				 * attached to ALLOW_ERROR_INJECTION and are not in denylist.
+				 */
+				if (!check_non_sleepable_error_inject(btf_id) &&
+				    within_error_injection_list(addr))
+					ret = 0;
+				/* fentry/fexit/fmod_ret progs can also be sleepable if they are
+				 * in the fmodret id set with the KF_SLEEPABLE flag.
+				 */
+				else {
+					u32 *flags = btf_kfunc_is_modify_return(btf, btf_id,
+										prog);
+
+					if (flags && (*flags & KF_SLEEPABLE))
+						ret = 0;
+				}
+				break;
+			case BPF_PROG_TYPE_LSM:
+				/* LSM progs check that they are attached to bpf_lsm_*() funcs.
+				 * Only some of them are sleepable.
+				 */
+				if (bpf_lsm_is_sleepable_hook(btf_id))
+					ret = 0;
+				break;
+			default:
+				break;
+			}
+			if (ret) {
+				module_put(mod);
+				bpf_log(log, "%s is not sleepable\n", tname);
+				return ret;
+			}
+		} else if (prog->expected_attach_type == BPF_MODIFY_RETURN) {
+			if (tgt_prog) {
+				module_put(mod);
+				bpf_log(log, "can't modify return codes of BPF programs\n");
+				return -EINVAL;
+			}
+			ret = -EINVAL;
+			if (btf_kfunc_is_modify_return(btf, btf_id, prog) ||
+			    !check_attach_modify_return(addr, tname))
+				ret = 0;
+			if (ret) {
+				module_put(mod);
+				bpf_log(log, "%s() is not modifiable\n", tname);
+				return ret;
+			}
+		}
+
+		break;
+	}
+	tgt_info->tgt_addr = addr;
+	tgt_info->tgt_name = tname;
+	tgt_info->tgt_type = t;
+	tgt_info->tgt_mod = mod;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bpf_check_attach_target);
+
 /* No hurry in this branch
  *
  * Exported for the bpf jit load helper.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 322c1674b626..2b5e29ee8310 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -28,7 +28,6 @@
 #include <linux/cpumask.h>
 #include <linux/bpf_mem_alloc.h>
 #include <net/xdp.h>
-#include <linux/trace_events.h>
 #include <linux/kallsyms.h>
 
 #include "disasm.h"
@@ -22998,368 +22997,6 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	return bpf_prog_ctx_arg_info_init(prog, st_ops_desc->arg_info[member_idx].info,
 					  st_ops_desc->arg_info[member_idx].cnt);
 }
-#define SECURITY_PREFIX "security_"
-
-static int check_attach_modify_return(unsigned long addr, const char *func_name)
-{
-	if (within_error_injection_list(addr) ||
-	    !strncmp(SECURITY_PREFIX, func_name, sizeof(SECURITY_PREFIX) - 1))
-		return 0;
-
-	return -EINVAL;
-}
-
-/* list of non-sleepable functions that are otherwise on
- * ALLOW_ERROR_INJECTION list
- */
-BTF_SET_START(btf_non_sleepable_error_inject)
-/* Three functions below can be called from sleepable and non-sleepable context.
- * Assume non-sleepable from bpf safety point of view.
- */
-BTF_ID(func, __filemap_add_folio)
-#ifdef CONFIG_FAIL_PAGE_ALLOC
-BTF_ID(func, should_fail_alloc_page)
-#endif
-#ifdef CONFIG_FAILSLAB
-BTF_ID(func, should_failslab)
-#endif
-BTF_SET_END(btf_non_sleepable_error_inject)
-
-static int check_non_sleepable_error_inject(u32 btf_id)
-{
-	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
-}
-
-int bpf_check_attach_target(struct bpf_verifier_log *log,
-			    const struct bpf_prog *prog,
-			    const struct bpf_prog *tgt_prog,
-			    u32 btf_id,
-			    struct bpf_attach_target_info *tgt_info)
-{
-	bool prog_extension = prog->type == BPF_PROG_TYPE_EXT;
-	bool prog_tracing = prog->type == BPF_PROG_TYPE_TRACING;
-	char trace_symbol[KSYM_SYMBOL_LEN];
-	const char prefix[] = "btf_trace_";
-	struct bpf_raw_event_map *btp;
-	int ret = 0, subprog = -1, i;
-	const struct btf_type *t;
-	bool conservative = true;
-	const char *tname, *fname;
-	struct btf *btf;
-	long addr = 0;
-	struct module *mod = NULL;
-
-	if (!btf_id) {
-		bpf_log(log, "Tracing programs must provide btf_id\n");
-		return -EINVAL;
-	}
-	btf = tgt_prog ? tgt_prog->aux->btf : prog->aux->attach_btf;
-	if (!btf) {
-		bpf_log(log,
-			"FENTRY/FEXIT program can only be attached to another program annotated with BTF\n");
-		return -EINVAL;
-	}
-	t = btf_type_by_id(btf, btf_id);
-	if (!t) {
-		bpf_log(log, "attach_btf_id %u is invalid\n", btf_id);
-		return -EINVAL;
-	}
-	tname = btf_name_by_offset(btf, t->name_off);
-	if (!tname) {
-		bpf_log(log, "attach_btf_id %u doesn't have a name\n", btf_id);
-		return -EINVAL;
-	}
-	if (tgt_prog) {
-		struct bpf_prog_aux *aux = tgt_prog->aux;
-		bool tgt_changes_pkt_data;
-		bool tgt_might_sleep;
-
-		if (bpf_prog_is_dev_bound(prog->aux) &&
-		    !bpf_prog_dev_bound_match(prog, tgt_prog)) {
-			bpf_log(log, "Target program bound device mismatch");
-			return -EINVAL;
-		}
-
-		for (i = 0; i < aux->func_info_cnt; i++)
-			if (aux->func_info[i].type_id == btf_id) {
-				subprog = i;
-				break;
-			}
-		if (subprog == -1) {
-			bpf_log(log, "Subprog %s doesn't exist\n", tname);
-			return -EINVAL;
-		}
-		if (aux->func && aux->func[subprog]->aux->exception_cb) {
-			bpf_log(log,
-				"%s programs cannot attach to exception callback\n",
-				prog_extension ? "Extension" : "FENTRY/FEXIT");
-			return -EINVAL;
-		}
-		conservative = aux->func_info_aux[subprog].unreliable;
-		if (prog_extension) {
-			if (conservative) {
-				bpf_log(log,
-					"Cannot replace static functions\n");
-				return -EINVAL;
-			}
-			if (!prog->jit_requested) {
-				bpf_log(log,
-					"Extension programs should be JITed\n");
-				return -EINVAL;
-			}
-			tgt_changes_pkt_data = aux->func
-					       ? aux->func[subprog]->aux->changes_pkt_data
-					       : aux->changes_pkt_data;
-			if (prog->aux->changes_pkt_data && !tgt_changes_pkt_data) {
-				bpf_log(log,
-					"Extension program changes packet data, while original does not\n");
-				return -EINVAL;
-			}
-
-			tgt_might_sleep = aux->func
-					  ? aux->func[subprog]->aux->might_sleep
-					  : aux->might_sleep;
-			if (prog->aux->might_sleep && !tgt_might_sleep) {
-				bpf_log(log,
-					"Extension program may sleep, while original does not\n");
-				return -EINVAL;
-			}
-		}
-		if (!tgt_prog->jited) {
-			bpf_log(log, "Can attach to only JITed progs\n");
-			return -EINVAL;
-		}
-		if (prog_tracing) {
-			if (aux->attach_tracing_prog) {
-				/*
-				 * Target program is an fentry/fexit which is already attached
-				 * to another tracing program. More levels of nesting
-				 * attachment are not allowed.
-				 */
-				bpf_log(log, "Cannot nest tracing program attach more than once\n");
-				return -EINVAL;
-			}
-		} else if (tgt_prog->type == prog->type) {
-			/*
-			 * To avoid potential call chain cycles, prevent attaching of a
-			 * program extension to another extension. It's ok to attach
-			 * fentry/fexit to extension program.
-			 */
-			bpf_log(log, "Cannot recursively attach\n");
-			return -EINVAL;
-		}
-		if (tgt_prog->type == BPF_PROG_TYPE_TRACING &&
-		    prog_extension &&
-		    (tgt_prog->expected_attach_type == BPF_TRACE_FENTRY ||
-		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT)) {
-			/* Program extensions can extend all program types
-			 * except fentry/fexit. The reason is the following.
-			 * The fentry/fexit programs are used for performance
-			 * analysis, stats and can be attached to any program
-			 * type. When extension program is replacing XDP function
-			 * it is necessary to allow performance analysis of all
-			 * functions. Both original XDP program and its program
-			 * extension. Hence attaching fentry/fexit to
-			 * BPF_PROG_TYPE_EXT is allowed. If extending of
-			 * fentry/fexit was allowed it would be possible to create
-			 * long call chain fentry->extension->fentry->extension
-			 * beyond reasonable stack size. Hence extending fentry
-			 * is not allowed.
-			 */
-			bpf_log(log, "Cannot extend fentry/fexit\n");
-			return -EINVAL;
-		}
-	} else {
-		if (prog_extension) {
-			bpf_log(log, "Cannot replace kernel functions\n");
-			return -EINVAL;
-		}
-	}
-
-	switch (prog->expected_attach_type) {
-	case BPF_TRACE_RAW_TP:
-		if (tgt_prog) {
-			bpf_log(log,
-				"Only FENTRY/FEXIT progs are attachable to another BPF prog\n");
-			return -EINVAL;
-		}
-		if (!btf_type_is_typedef(t)) {
-			bpf_log(log, "attach_btf_id %u is not a typedef\n",
-				btf_id);
-			return -EINVAL;
-		}
-		if (strncmp(prefix, tname, sizeof(prefix) - 1)) {
-			bpf_log(log, "attach_btf_id %u points to wrong type name %s\n",
-				btf_id, tname);
-			return -EINVAL;
-		}
-		tname += sizeof(prefix) - 1;
-
-		/* The func_proto of "btf_trace_##tname" is generated from typedef without argument
-		 * names. Thus using bpf_raw_event_map to get argument names.
-		 */
-		btp = bpf_get_raw_tracepoint(tname);
-		if (!btp)
-			return -EINVAL;
-		fname = kallsyms_lookup((unsigned long)btp->bpf_func, NULL, NULL, NULL,
-					trace_symbol);
-		bpf_put_raw_tracepoint(btp);
-
-		if (fname)
-			ret = btf_find_by_name_kind(btf, fname, BTF_KIND_FUNC);
-
-		if (!fname || ret < 0) {
-			bpf_log(log, "Cannot find btf of tracepoint template, fall back to %s%s.\n",
-				prefix, tname);
-			t = btf_type_by_id(btf, t->type);
-			if (!btf_type_is_ptr(t))
-				/* should never happen in valid vmlinux build */
-				return -EINVAL;
-		} else {
-			t = btf_type_by_id(btf, ret);
-			if (!btf_type_is_func(t))
-				/* should never happen in valid vmlinux build */
-				return -EINVAL;
-		}
-
-		t = btf_type_by_id(btf, t->type);
-		if (!btf_type_is_func_proto(t))
-			/* should never happen in valid vmlinux build */
-			return -EINVAL;
-
-		break;
-	case BPF_TRACE_ITER:
-		if (!btf_type_is_func(t)) {
-			bpf_log(log, "attach_btf_id %u is not a function\n",
-				btf_id);
-			return -EINVAL;
-		}
-		t = btf_type_by_id(btf, t->type);
-		if (!btf_type_is_func_proto(t))
-			return -EINVAL;
-		ret = btf_distill_func_proto(log, btf, t, tname, &tgt_info->fmodel);
-		if (ret)
-			return ret;
-		break;
-	default:
-		if (!prog_extension)
-			return -EINVAL;
-		fallthrough;
-	case BPF_MODIFY_RETURN:
-	case BPF_LSM_MAC:
-	case BPF_LSM_CGROUP:
-	case BPF_TRACE_FENTRY:
-	case BPF_TRACE_FEXIT:
-		if (!btf_type_is_func(t)) {
-			bpf_log(log, "attach_btf_id %u is not a function\n",
-				btf_id);
-			return -EINVAL;
-		}
-		if (prog_extension &&
-		    btf_check_type_match(log, prog, btf, t))
-			return -EINVAL;
-		t = btf_type_by_id(btf, t->type);
-		if (!btf_type_is_func_proto(t))
-			return -EINVAL;
-
-		if ((prog->aux->saved_dst_prog_type || prog->aux->saved_dst_attach_type) &&
-		    (!tgt_prog || prog->aux->saved_dst_prog_type != tgt_prog->type ||
-		     prog->aux->saved_dst_attach_type != tgt_prog->expected_attach_type))
-			return -EINVAL;
-
-		if (tgt_prog && conservative)
-			t = NULL;
-
-		ret = btf_distill_func_proto(log, btf, t, tname, &tgt_info->fmodel);
-		if (ret < 0)
-			return ret;
-
-		if (tgt_prog) {
-			if (subprog == 0)
-				addr = (long) tgt_prog->bpf_func;
-			else
-				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
-		} else {
-			if (btf_is_module(btf)) {
-				mod = btf_try_get_module(btf);
-				if (mod)
-					addr = find_kallsyms_symbol_value(mod, tname);
-				else
-					addr = 0;
-			} else {
-				addr = kallsyms_lookup_name(tname);
-			}
-			if (!addr) {
-				module_put(mod);
-				bpf_log(log,
-					"The address of function %s cannot be found\n",
-					tname);
-				return -ENOENT;
-			}
-		}
-
-		if (prog->sleepable) {
-			ret = -EINVAL;
-			switch (prog->type) {
-			case BPF_PROG_TYPE_TRACING:
-
-				/* fentry/fexit/fmod_ret progs can be sleepable if they are
-				 * attached to ALLOW_ERROR_INJECTION and are not in denylist.
-				 */
-				if (!check_non_sleepable_error_inject(btf_id) &&
-				    within_error_injection_list(addr))
-					ret = 0;
-				/* fentry/fexit/fmod_ret progs can also be sleepable if they are
-				 * in the fmodret id set with the KF_SLEEPABLE flag.
-				 */
-				else {
-					u32 *flags = btf_kfunc_is_modify_return(btf, btf_id,
-										prog);
-
-					if (flags && (*flags & KF_SLEEPABLE))
-						ret = 0;
-				}
-				break;
-			case BPF_PROG_TYPE_LSM:
-				/* LSM progs check that they are attached to bpf_lsm_*() funcs.
-				 * Only some of them are sleepable.
-				 */
-				if (bpf_lsm_is_sleepable_hook(btf_id))
-					ret = 0;
-				break;
-			default:
-				break;
-			}
-			if (ret) {
-				module_put(mod);
-				bpf_log(log, "%s is not sleepable\n", tname);
-				return ret;
-			}
-		} else if (prog->expected_attach_type == BPF_MODIFY_RETURN) {
-			if (tgt_prog) {
-				module_put(mod);
-				bpf_log(log, "can't modify return codes of BPF programs\n");
-				return -EINVAL;
-			}
-			ret = -EINVAL;
-			if (btf_kfunc_is_modify_return(btf, btf_id, prog) ||
-			    !check_attach_modify_return(addr, tname))
-				ret = 0;
-			if (ret) {
-				module_put(mod);
-				bpf_log(log, "%s() is not modifiable\n", tname);
-				return ret;
-			}
-		}
-
-		break;
-	}
-	tgt_info->tgt_addr = addr;
-	tgt_info->tgt_name = tname;
-	tgt_info->tgt_type = t;
-	tgt_info->tgt_mod = mod;
-	return 0;
-}
 
 BTF_SET_START(btf_id_deny)
 BTF_ID_UNUSED
-- 
2.47.1


