Return-Path: <bpf+bounces-14373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E65C7E34BB
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 05:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21099280F88
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 04:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F24517C8;
	Tue,  7 Nov 2023 04:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJqPAmF6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7216C1C2F;
	Tue,  7 Nov 2023 04:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCD1C433C7;
	Tue,  7 Nov 2023 04:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699333058;
	bh=+atNa9jj/RKmQ4L0ql0VIH5h4x0ye9pD2wZ+hE8Z2E8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uJqPAmF69f3JfMtIw902KFtxEBleEFJ03sC5AYvSCH86r3oPrmTApMF9QSjwwV2wU
	 JrEsmS6ZvgEitmb28MmlC2nC8xQwWMdBez13ZFX6PIIxaqiDs4ofRJWJUSmahXEmiE
	 kMZ2okSwJ4t/U+a1jr+zf7uexlWTRGnF7h/sbH4Tl/Q2U2sflgsTNCVmSeGiq3lhoc
	 nJAvNfEd7loouZfyFy0iCwG/Ffbk2AKbY1rfgf3kz83fK7SYGgOEFBPuw801tarlNW
	 AV4d7qrD6H4i+7wrzLG0isU4e+jJ9/Vn8bEMRWagZ5IFCq40g0iMp4eGhwflvR6lL+
	 H6YuPusBhjlfQ==
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
	kpsingh@kernel.org,
	vadfed@meta.com,
	Song Liu <song@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH bpf-next 1/3] bpf: Add __bpf_dynptr_data* for in kernel use
Date: Mon,  6 Nov 2023 20:57:23 -0800
Message-Id: <20231107045725.2278852-2-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107045725.2278852-1-song@kernel.org>
References: <20231107045725.2278852-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Different types of bpf dynptr have different internal data storage.
Specifically, SKB and XDP type of dynptr may have non-continuous data.
Therefore, it is not always safe to directly access dynptr->data.

Add __bpf_dynptr_data and __bpf_dynptr_data_rw to replace direct access to
dynptr->data.

Update bpf_verify_pkcs7_signature to use __bpf_dynptr_data instead of
dynptr->data.

Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 include/linux/bpf.h      |  2 ++
 kernel/bpf/helpers.c     | 19 +++++++++++++++++++
 kernel/trace/bpf_trace.c | 12 ++++++++----
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b4825d3cdb29..eb84caf133df 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1222,6 +1222,8 @@ enum bpf_dynptr_type {
 
 int bpf_dynptr_check_size(u32 size);
 u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
+const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len);
+void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len);
 
 #ifdef CONFIG_BPF_JIT
 int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e46ac288a108..6b7c8163e128 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2611,3 +2611,22 @@ static int __init kfunc_init(void)
 }
 
 late_initcall(kfunc_init);
+
+/* Get a pointer to dynptr data up to len bytes for read only access. If
+ * the dynptr doesn't have continuous data up to len bytes, return NULL.
+ */
+const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len)
+{
+	return bpf_dynptr_slice(ptr, 0, NULL, len);
+}
+
+/* Get a pointer to dynptr data up to len bytes for read write access. If
+ * the dynptr doesn't have continuous data up to len bytes, or the dynptr
+ * is read only, return NULL.
+ */
+void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len)
+{
+	if (__bpf_dynptr_is_rdonly(ptr))
+		return NULL;
+	return (void *)__bpf_dynptr_data(ptr, len);
+}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index df697c74d519..d525a22b8d56 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1378,6 +1378,8 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
 			       struct bpf_dynptr_kern *sig_ptr,
 			       struct bpf_key *trusted_keyring)
 {
+	const void *data, *sig;
+	u32 data_len, sig_len;
 	int ret;
 
 	if (trusted_keyring->has_ref) {
@@ -1394,10 +1396,12 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
 			return ret;
 	}
 
-	return verify_pkcs7_signature(data_ptr->data,
-				      __bpf_dynptr_size(data_ptr),
-				      sig_ptr->data,
-				      __bpf_dynptr_size(sig_ptr),
+	data_len = __bpf_dynptr_size(data_ptr);
+	data = __bpf_dynptr_data(data_ptr, data_len);
+	sig_len = __bpf_dynptr_size(sig_ptr);
+	sig = __bpf_dynptr_data(sig_ptr, sig_len);
+
+	return verify_pkcs7_signature(data, data_len, sig, sig_len,
 				      trusted_keyring->key,
 				      VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
 				      NULL);
-- 
2.34.1


