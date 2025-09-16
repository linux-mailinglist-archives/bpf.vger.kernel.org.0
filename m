Return-Path: <bpf+bounces-68527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7BFB59C91
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 17:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67AA0324953
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 15:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15A2352FF2;
	Tue, 16 Sep 2025 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ks1VWwLT"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C061FE44B
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037954; cv=none; b=fzg0hFMgnC3qh7fah5k7mChdf9JARWezk49Z/MJhcHh5/KFPg+ZkILMnvKO7vZnrOxxhYNMExZNNtEj1NCgHRhXYauoPVLLp+NBJ4UNDKjCDFXGBKEop7D/hmkToNpiXxYjhHUpYSs5LsUUnDwPTfVrSO8SU4SdNaHJ2EAuED0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037954; c=relaxed/simple;
	bh=+hXZvqi6LNV3jJvzoftmaJUhD4I8rnkbyKCrYu8qGX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdagNDuFCWgJkqRKPlhyyX9JU8vd8pA9taFsQT+FNUNNheWiOX42g7e16qxKIf7okYJ6wmlU01Vdp/eWyfOXlBDH9du7+2ILpp0pO0Lu65Ok6EGG1Kec+ailQ1Gw1n5tdXsOGFDbJLPxH1UkYdsRhPldhpSmNt8RO3enq5Z6s7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ks1VWwLT; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758037950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tcyDoKI1I55gsyGOWBcccb0vzEVYkAWuqickrooeuto=;
	b=Ks1VWwLTmQl0VSHtcF+dQuTb7BBa5syPrziW5LqwZXTN8hWDwGBEjIwhpMvR0xlMVYezI5
	5wUY6MvfkyTNra+DNK9hKUFulOnOV+9mk3KBejfinm9IHd9Ci8H8+ktxUXSHFogszgl+b5
	vREnEV2mQsni9uk3N32Rdfhl8QQe1m8=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	yatsenko@meta.com,
	puranjay@kernel.org,
	davidzalman.101@gmail.com,
	cheick.traore@foss.st.com,
	chen.dylane@linux.dev,
	mika.westerberg@linux.intel.com,
	ameryhung@gmail.com,
	menglong8.dong@gmail.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 1/3] bpf: Allow union argument in trampoline based programs
Date: Tue, 16 Sep 2025 23:52:09 +0800
Message-ID: <20250916155211.61083-2-leon.hwang@linux.dev>
In-Reply-To: <20250916155211.61083-1-leon.hwang@linux.dev>
References: <20250916155211.61083-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, functions with 'union' arguments cannot be traced with
fentry/fexit:

bpftrace -e 'fentry:release_pages { exit(); }' -v
AST node count: 6
Attaching 1 probe...
ERROR: Error loading BPF program for fentry_vmlinux_release_pages_1.
Kernel error log:
The function release_pages arg0 type UNION is unsupported.
processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

ERROR: Loading BPF object(s) failed.

The type of the 'release_pages' argument is defined as:

typedef union {
	struct page **pages;
	struct folio **folios;
	struct encoded_page **encoded_pages;
} release_pages_arg __attribute__ ((__transparent_union__));

This patch relaxes the restriction by allowing function arguments of type
'union' to be traced in verifier.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h | 3 +++
 include/linux/btf.h | 5 +++++
 kernel/bpf/btf.c    | 8 +++++---
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 41f776071ff51..010ecbb798c60 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1119,6 +1119,9 @@ struct bpf_prog_offload {
 /* The argument is signed. */
 #define BTF_FMODEL_SIGNED_ARG		BIT(1)
 
+/* The argument is a union. */
+#define BTF_FMODEL_UNION_ARG		BIT(2)
+
 struct btf_func_model {
 	u8 ret_size;
 	u8 ret_flags;
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 9eda6b113f9b4..255f8c6bd2438 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -404,6 +404,11 @@ static inline bool btf_type_is_struct(const struct btf_type *t)
 	return kind == BTF_KIND_STRUCT || kind == BTF_KIND_UNION;
 }
 
+static inline bool __btf_type_is_union(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_UNION;
+}
+
 static inline bool __btf_type_is_struct(const struct btf_type *t)
 {
 	return BTF_INFO_KIND(t->info) == BTF_KIND_STRUCT;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 64739308902f7..2a85c51412bea 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6762,7 +6762,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	/* skip modifiers */
 	while (btf_type_is_modifier(t))
 		t = btf_type_by_id(btf, t->type);
-	if (btf_type_is_small_int(t) || btf_is_any_enum(t) || __btf_type_is_struct(t))
+	if (btf_type_is_small_int(t) || btf_is_any_enum(t) || btf_type_is_struct(t))
 		/* accessing a scalar */
 		return true;
 	if (!btf_type_is_ptr(t)) {
@@ -7334,7 +7334,7 @@ static int __get_type_size(struct btf *btf, u32 btf_id,
 	if (btf_type_is_ptr(t))
 		/* kernel size of pointer. Not BPF's size of pointer*/
 		return sizeof(void *);
-	if (btf_type_is_int(t) || btf_is_any_enum(t) || __btf_type_is_struct(t))
+	if (btf_type_is_int(t) || btf_is_any_enum(t) || btf_type_is_struct(t))
 		return t->size;
 	return -EINVAL;
 }
@@ -7347,6 +7347,8 @@ static u8 __get_type_fmodel_flags(const struct btf_type *t)
 		flags |= BTF_FMODEL_STRUCT_ARG;
 	if (btf_type_is_signed_int(t))
 		flags |= BTF_FMODEL_SIGNED_ARG;
+	if (__btf_type_is_union(t))
+		flags |= BTF_FMODEL_UNION_ARG;
 
 	return flags;
 }
@@ -7384,7 +7386,7 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
 		return -EINVAL;
 	}
 	ret = __get_type_size(btf, func->type, &t);
-	if (ret < 0 || __btf_type_is_struct(t)) {
+	if (ret < 0 || btf_type_is_struct(t)) {
 		bpf_log(log,
 			"The function %s return type %s is unsupported.\n",
 			tname, btf_type_str(t));
-- 
2.50.1


