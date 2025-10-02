Return-Path: <bpf+bounces-70204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC20BB4657
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 17:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0093C254D
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 15:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3279F2356D9;
	Thu,  2 Oct 2025 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LOb7t/if"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99952235063
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420171; cv=none; b=Ze/IxAuL+MKST+QUDg/HaexAsW/zHpRU1Z9ZTbLzU18YfvWVWSoSA1b3UBpry/VeYACVpNuXWZaz2Feg9kUynrXiLgs6eyiDxav9BexsLwT95mtJa4ZQyCSgwYevuDIDRQNOIr+G3I3gST35X5+K8QCX9RhWa+B58LXgCRLcsEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420171; c=relaxed/simple;
	bh=Gb2ORwcTQB4wHBtw5CbVk4kwWOM+xzFSFVl9UpynhXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iwm8QjjX7mM0I19kSS+ujdRISPSiK0Mf0jlHwgj97y4tvd/gvIj5fsJSmQ1dhTxt5YeZJKRynx/gf70Mq6YCu6mPheMk6WTsoeT0ODJEsAZRdEWwqeAjXuLfqOAJZc1WR93V5wnwPbpTcQoczQ6cWQ4tlA91tSZbepif9L4hQts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LOb7t/if; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759420166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DVgxhqVak886hJTXMj/peQ+d+2be8VtQdEIkSQahFGU=;
	b=LOb7t/ifV70ajFPo3GaUZZX10dUqGkeRon6Alb+LctR5Qybk6IWYOcTY3XxUbu69izFIDR
	PKpgU3CX8swnSTTEUAY1QYTNNiil9lPGBv82XnHysawx1eMlJNgEAH3pYy3S7lnuznCgqT
	/Rn/bLPxJyasESq9GuIH9AIJxzfuEj0=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next v3 05/10] bpf: Refactor reporting btf_log_true_size for btf_load
Date: Thu,  2 Oct 2025 23:48:36 +0800
Message-ID: <20251002154841.99348-6-leon.hwang@linux.dev>
In-Reply-To: <20251002154841.99348-1-leon.hwang@linux.dev>
References: <20251002154841.99348-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the next commit, it will be able to report logs via extended common
attributes, which will report 'log_true_size' via the extended common
attributes meanwhile.

Therefore, refactor the way of 'btf_log_true_size' reporting in order to
report 'log_true_size' via the extended common attributes easily.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/btf.h  |  2 +-
 kernel/bpf/btf.c     | 25 +++++--------------------
 kernel/bpf/syscall.c | 22 +++++++++++++++++++---
 3 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f06976ffb63f9..60e29d05a8a90 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -145,7 +145,7 @@ const char *btf_get_name(const struct btf *btf);
 void btf_get(struct btf *btf);
 void btf_put(struct btf *btf);
 const struct btf_header *btf_header(const struct btf *btf);
-int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_sz);
+int btf_new_fd(union bpf_attr *attr, bpfptr_t uattr);
 struct btf *btf_get_by_fd(int fd);
 int btf_get_info_by_fd(const struct btf *btf,
 		       const union bpf_attr *attr,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b3..0d83ce16947d7 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5745,22 +5745,7 @@ static int btf_check_type_tags(struct btf_verifier_env *env,
 	return 0;
 }
 
-static int finalize_log(struct bpf_verifier_log *log, bpfptr_t uattr, u32 uattr_size)
-{
-	u32 log_true_size;
-	int err;
-
-	err = bpf_vlog_finalize(log, &log_true_size);
-
-	if (uattr_size >= offsetofend(union bpf_attr, btf_log_true_size) &&
-	    copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, btf_log_true_size),
-				  &log_true_size, sizeof(log_true_size)))
-		err = -EFAULT;
-
-	return err;
-}
-
-static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
+static struct btf *btf_parse(union bpf_attr *attr, bpfptr_t uattr)
 {
 	bpfptr_t btf_data = make_bpfptr(attr->btf, uattr.is_kernel);
 	char __user *log_ubuf = u64_to_user_ptr(attr->btf_log_buf);
@@ -5841,7 +5826,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 		}
 	}
 
-	err = finalize_log(&env->log, uattr, uattr_size);
+	err = bpf_vlog_finalize(&env->log, &attr->btf_log_true_size);
 	if (err)
 		goto errout_free;
 
@@ -5853,7 +5838,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	btf_free_struct_meta_tab(btf);
 errout:
 	/* overwrite err with -ENOSPC or -EFAULT */
-	ret = finalize_log(&env->log, uattr, uattr_size);
+	ret = bpf_vlog_finalize(&env->log, &attr->btf_log_true_size);
 	if (ret)
 		err = ret;
 errout_free:
@@ -8017,12 +8002,12 @@ static int __btf_new_fd(struct btf *btf)
 	return anon_inode_getfd("btf", &btf_fops, btf, O_RDONLY | O_CLOEXEC);
 }
 
-int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
+int btf_new_fd(union bpf_attr *attr, bpfptr_t uattr)
 {
 	struct btf *btf;
 	int ret;
 
-	btf = btf_parse(attr, uattr, uattr_size);
+	btf = btf_parse(attr, uattr);
 	if (IS_ERR(btf))
 		return PTR_ERR(btf);
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 698c30ff99486..3bdcd6c065039 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5397,7 +5397,7 @@ static int bpf_obj_get_info_by_fd(const union bpf_attr *attr,
 
 #define BPF_BTF_LOAD_LAST_FIELD btf_token_fd
 
-static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
+static int bpf_btf_load(union bpf_attr *attr, bpfptr_t uattr)
 {
 	struct bpf_token *token = NULL;
 
@@ -5424,7 +5424,7 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_
 
 	bpf_token_put(token);
 
-	return btf_new_fd(attr, uattr, uattr_size);
+	return btf_new_fd(attr, uattr);
 }
 
 #define BPF_BTF_GET_FD_BY_ID_LAST_FIELD fd_by_id_token_fd
@@ -6151,6 +6151,19 @@ static int copy_prog_load_log_true_size(union bpf_attr *attr, bpfptr_t uattr, un
 	return 0;
 }
 
+static int copy_btf_load_log_true_size(union bpf_attr *attr, bpfptr_t uattr, unsigned int size)
+{
+	if (!attr->btf_log_true_size)
+		return 0;
+
+	if (size >= offsetofend(union bpf_attr, btf_log_true_size) &&
+	    copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, btf_log_true_size),
+				  &attr->btf_log_true_size, sizeof(attr->btf_log_true_size)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		     bpfptr_t uattr_common, unsigned int size_common)
 {
@@ -6257,7 +6270,10 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = bpf_raw_tracepoint_open(&attr);
 		break;
 	case BPF_BTF_LOAD:
-		err = bpf_btf_load(&attr, uattr, size);
+		attr.btf_log_true_size = 0;
+		err = bpf_btf_load(&attr, uattr);
+		ret = copy_btf_load_log_true_size(&attr, uattr, size);
+		err = ret ? ret : err;
 		break;
 	case BPF_BTF_GET_FD_BY_ID:
 		err = bpf_btf_get_fd_by_id(&attr);
-- 
2.51.0


