Return-Path: <bpf+bounces-13190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B805A7D5EDA
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 01:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B3ACB208FA
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 23:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C554737F;
	Tue, 24 Oct 2023 23:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSoLqBQ+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE28749D;
	Tue, 24 Oct 2023 23:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5A7C433C7;
	Tue, 24 Oct 2023 23:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698191769;
	bh=Bta9NWIO+aJqzINU5B5Ke/oUGBAcJ3VwzIbovF/dvM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RSoLqBQ+R+iD256FO9LOdMnFP48I/w1eQVBqpWwO0sWC0/p26/nE0MrJAtsC4dlDk
	 YWtxWNfIgvxewVFZpdjGbF5YCeiDphkL3sZ1JY5NmO1dPVnlXcB2SJv68/WUjN5gT5
	 6BePLTkCm9lGJ6ucNopmqmK2xBTSl4vHLDagdObYvc7dFxGfZgZVpt7LmS5ODy1s3G
	 g7+HitRELRvrycbJcGUB5GAkjKIX30qPzq54eGiBsAx8V0yqqEnosDV41n8PNkfB/c
	 Bjtd+iDxaAEpE6Lzneavz9/2xRi4U8yMfXmm8C+fc/Gv4C5ME+Ms/aza8SQQOeVyKr
	 ECtwkutmCSfig==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	fsverity@lists.linux.dev
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	kernel-team@meta.com,
	ebiggers@kernel.org,
	tytso@mit.edu,
	roberto.sassu@huaweicloud.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v6 bpf-next 1/9] bpf: Expose bpf_dynptr_slice* kfuncs for in kernel use
Date: Tue, 24 Oct 2023 16:55:43 -0700
Message-Id: <20231024235551.2769174-2-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024235551.2769174-1-song@kernel.org>
References: <20231024235551.2769174-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kfuncs bpf_dynptr_slice and bpf_dynptr_slice_rdwr are used by BPF programs
to access the dynptr data. They are also useful for in kernel functions
that access dynptr data, for example, bpf_verify_pkcs7_signature.

Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr to bpf.h so that kernel
functions can use them instead of accessing dynptr->data directly.

Update bpf_verify_pkcs7_signature to use bpf_dynptr_slice instead of
dynptr->data.

Also, update the comments for bpf_dynptr_slice and bpf_dynptr_slice_rdwr
that they may return error pointers for BPF_DYNPTR_TYPE_XDP.

Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/bpf.h      |  4 ++++
 kernel/bpf/helpers.c     | 16 ++++++++--------
 kernel/trace/bpf_trace.c | 15 +++++++++++----
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b4825d3cdb29..3ed3ae37cbdf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1222,6 +1222,10 @@ enum bpf_dynptr_type {
 
 int bpf_dynptr_check_size(u32 size);
 u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
+void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
+		       void *buffer__opt, u32 buffer__szk);
+void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 offset,
+			    void *buffer__opt, u32 buffer__szk);
 
 #ifdef CONFIG_BPF_JIT
 int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e46ac288a108..af5059f11e83 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2270,10 +2270,10 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
  * bpf_dynptr_slice will not invalidate any ctx->data/data_end pointers in
  * the bpf program.
  *
- * Return: NULL if the call failed (eg invalid dynptr), pointer to a read-only
- * data slice (can be either direct pointer to the data or a pointer to the user
- * provided buffer, with its contents containing the data, if unable to obtain
- * direct pointer)
+ * Return: NULL or error pointer if the call failed (eg invalid dynptr), pointer
+ * to a read-only data slice (can be either direct pointer to the data or a
+ * pointer to the user provided buffer, with its contents containing the data,
+ * if unable to obtain direct pointer)
  */
 __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
 				   void *buffer__opt, u32 buffer__szk)
@@ -2354,10 +2354,10 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
  * bpf_dynptr_slice_rdwr will not invalidate any ctx->data/data_end pointers in
  * the bpf program.
  *
- * Return: NULL if the call failed (eg invalid dynptr), pointer to a
- * data slice (can be either direct pointer to the data or a pointer to the user
- * provided buffer, with its contents containing the data, if unable to obtain
- * direct pointer)
+ * Return: NULL or error pointer if the call failed (eg invalid dynptr), pointer
+ * to a data slice (can be either direct pointer to the data or a pointer to the
+ * user provided buffer, with its contents containing the data, if unable to
+ * obtain direct pointer)
  */
 __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 offset,
 					void *buffer__opt, u32 buffer__szk)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index df697c74d519..2626706b6387 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1378,6 +1378,7 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
 			       struct bpf_dynptr_kern *sig_ptr,
 			       struct bpf_key *trusted_keyring)
 {
+	void *data, *sig;
 	int ret;
 
 	if (trusted_keyring->has_ref) {
@@ -1394,10 +1395,16 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
 			return ret;
 	}
 
-	return verify_pkcs7_signature(data_ptr->data,
-				      __bpf_dynptr_size(data_ptr),
-				      sig_ptr->data,
-				      __bpf_dynptr_size(sig_ptr),
+	data = bpf_dynptr_slice(data_ptr, 0, NULL, 0);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	sig = bpf_dynptr_slice(sig_ptr, 0, NULL, 0);
+	if (IS_ERR(sig))
+		return PTR_ERR(sig);
+
+	return verify_pkcs7_signature(data, __bpf_dynptr_size(data_ptr),
+				      sig, __bpf_dynptr_size(sig_ptr),
 				      trusted_keyring->key,
 				      VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
 				      NULL);
-- 
2.34.1


