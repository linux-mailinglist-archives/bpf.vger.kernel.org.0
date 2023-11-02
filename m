Return-Path: <bpf+bounces-14018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE537DFB51
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 21:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54500281D22
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 20:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9F2219FB;
	Thu,  2 Nov 2023 20:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhIHNyhv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F1E1CF8C;
	Thu,  2 Nov 2023 20:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74DCC433C7;
	Thu,  2 Nov 2023 20:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698956193;
	bh=ETF1/rX5iV9HIuY7H7rg+QzZyoetNRA4MjPURFOxlMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KhIHNyhvFpoL9Ei6AHcu3NqhkTVSVKQ4VuFsyjVflWP0Bp6lE9sd5Sp9+48v971Ip
	 uOGzkgKHl+2+5wMJNSu8Ht0/4WBtJHVVxiTidYQzwSq/Je918Ig+fGdUaOLDEOnErG
	 yNmRyl1cdAxLiFTgpKdt1j7WxpqY4w00aT4DKXGeSxEASwuWrELFfg/n0rUKOm9nu8
	 vwSAkRJTfYQfH0+AXiCE3pxJKXJVHXKoVjYTOJDsvjPl9kavgAr1DNaoo5Iv8icGHJ
	 seN3rC0gsF6rx1EjtJymc2OGmgCOYvx6sBgpyUKJftSyxiFX2klWjzMKwMGjyIknfu
	 Sv2d95hvmcHRg==
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
	Song Liu <song@kernel.org>
Subject: [PATCH v8 bpf-next 1/9] bpf: Add __bpf_dynptr_data* for in kernel use
Date: Thu,  2 Nov 2023 13:16:11 -0700
Message-Id: <20231102201619.3135203-2-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102201619.3135203-1-song@kernel.org>
References: <20231102201619.3135203-1-song@kernel.org>
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
---
 include/linux/bpf.h      |  2 ++
 kernel/bpf/helpers.c     | 47 ++++++++++++++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c | 13 +++++++----
 3 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b4825d3cdb29..129c5a7c5982 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1222,6 +1222,8 @@ enum bpf_dynptr_type {
 
 int bpf_dynptr_check_size(u32 size);
 u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
+void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len);
+void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len);
 
 #ifdef CONFIG_BPF_JIT
 int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e46ac288a108..ddd1a5a81652 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2611,3 +2611,50 @@ static int __init kfunc_init(void)
 }
 
 late_initcall(kfunc_init);
+
+/* Get a pointer to dynptr data up to len bytes for read only access. If
+ * the dynptr doesn't have continuous data up to len bytes, return NULL.
+ */
+void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len)
+{
+	enum bpf_dynptr_type type;
+	int err;
+
+	if (!ptr->data)
+		return NULL;
+
+	err = bpf_dynptr_check_off_len(ptr, 0, len);
+	if (err)
+		return NULL;
+	type = bpf_dynptr_get_type(ptr);
+
+	switch (type) {
+	case BPF_DYNPTR_TYPE_LOCAL:
+	case BPF_DYNPTR_TYPE_RINGBUF:
+		return ptr->data + ptr->offset;
+	case BPF_DYNPTR_TYPE_SKB:
+		return skb_pointer_if_linear(ptr->data, ptr->offset, len);
+	case BPF_DYNPTR_TYPE_XDP:
+	{
+		void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset, len);
+
+		if (IS_ERR_OR_NULL(xdp_ptr))
+			return NULL;
+		return xdp_ptr;
+	}
+	default:
+		WARN_ONCE(true, "unknown dynptr type %d\n", type);
+		return NULL;
+	}
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
+	return __bpf_dynptr_data(ptr, len);
+}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index df697c74d519..92dc20d9b9ae 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1378,6 +1378,7 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
 			       struct bpf_dynptr_kern *sig_ptr,
 			       struct bpf_key *trusted_keyring)
 {
+	void *data, *sig;
 	int ret;
 
 	if (trusted_keyring->has_ref) {
@@ -1394,10 +1395,14 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
 			return ret;
 	}
 
-	return verify_pkcs7_signature(data_ptr->data,
-				      __bpf_dynptr_size(data_ptr),
-				      sig_ptr->data,
-				      __bpf_dynptr_size(sig_ptr),
+	data = __bpf_dynptr_data(data_ptr, __bpf_dynptr_size(data_ptr));
+	sig = __bpf_dynptr_data(sig_ptr, __bpf_dynptr_size(sig_ptr));
+
+	if (!data || !sig)
+		return -EINVAL;
+
+	return verify_pkcs7_signature(data, __bpf_dynptr_size(data_ptr),
+				      sig, __bpf_dynptr_size(sig_ptr),
 				      trusted_keyring->key,
 				      VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
 				      NULL);
-- 
2.34.1


