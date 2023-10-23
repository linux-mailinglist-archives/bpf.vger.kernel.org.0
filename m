Return-Path: <bpf+bounces-13016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9387D3BAB
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 18:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4718CB20F1E
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 16:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDAB1CAB9;
	Mon, 23 Oct 2023 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOcshhNB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0181C28A;
	Mon, 23 Oct 2023 16:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B10FC433C7;
	Mon, 23 Oct 2023 16:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698077041;
	bh=dZ2GcRRuvMMRyP0Qo7gMpZJYT+xU7qjYOosJK+G6G5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YOcshhNBFaLxhfrYc/dYJLQzHP8/upkjFyQ32KdRahpbIc1J+yU+9n2q/bzZMdZtq
	 5InySebOBzHUr4XoEEKYJlccL5qxV7Kd3CPo6voxZebQmKnlCM9Cr5AJSrMdq0+f5F
	 zRpNx66DlR1iko94f8F0vrt3bOPlDn4Nel6F40H5U68a3L/Jdhg526ouV66zpPxdZT
	 5Y5xdFDcaf1qdIYajK8j0U9PpuvHNGEdOMjDZRObIhw0f1T83ZQ7kaIeN2dWAOtDjk
	 VdqzhlZdXfO3mweHkQw4s5NnVEsyGy1nosJgv08PQgGUY8dW3jr0DEfA5w1+nJlgul
	 RL+cFieVwa3nw==
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
Subject: [PATCH v3 bpf-next 1/9] bpf: Expose bpf_dynptr_slice* kfuncs for in kernel use
Date: Mon, 23 Oct 2023 09:03:41 -0700
Message-Id: <20231023160349.4161154-2-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023160349.4161154-1-song@kernel.org>
References: <20231023160349.4161154-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These kfuncs can be used to access the dynptr data. Expose them in bpf.h
and use bpf_dynptr_slice in bpf_verify_pkcs7_signature.

Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/bpf.h      |  4 ++++
 kernel/trace/bpf_trace.c | 15 +++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

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
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index df697c74d519..43ed45a83ee2 100644
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
+	if (IS_ERR_OR_NULL(data))
+		return PTR_ERR(data);
+
+	sig = bpf_dynptr_slice(sig_ptr, 0, NULL, 0);
+	if (IS_ERR_OR_NULL(sig))
+		return PTR_ERR(sig);
+
+	return verify_pkcs7_signature(data, __bpf_dynptr_size(data_ptr),
+				      sig, __bpf_dynptr_size(sig_ptr),
 				      trusted_keyring->key,
 				      VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
 				      NULL);
-- 
2.34.1


