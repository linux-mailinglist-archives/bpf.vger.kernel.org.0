Return-Path: <bpf+bounces-70202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16735BB4651
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 17:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E44E97A2C09
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 15:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDA3231827;
	Thu,  2 Oct 2025 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jF52U7N2"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8492343C0
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420165; cv=none; b=RS/G+X5OW+CVG56D8XBCOGd8g2g/XL5W2uGKRxup+csoJvh8R5schw7oIwK32s4H/dJu+54pb1BUiQieAQj0oL/T8w3lU9uP72q/jWC/UJNxLH10IDiZP7oVT/JeudR0YWinbtUvEtt6tjo4DKCJrVvn3pt64BFfo+E2KeTnXXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420165; c=relaxed/simple;
	bh=LQFuutTIbV8XT0rd6YgHjkM3/QFacS+XZ+SEg73hIM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsWIlTDdnTqiJRFNnO3lIctTGInBjglmtmaHZffaY/nlFjBd0y+bH69nMm74KCgzwhcRoSVS1/YxPDEDsT49MhR8b2FvGNh3l+B6v7f3yp9NogJGUC9jubcT8SCgwPjmzRHgAX7U5JW+/z9E07C5glQkT3QUuwhRlw9TI04LbSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jF52U7N2; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759420161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iBLcjwTtr7HZ419qPDBY9Eo8KbVlSCQRp1k3reDSam8=;
	b=jF52U7N2CNcLeQUKKfm6ysuuAwzp1SYI1YsasEJi8JwypMqEio13dUT9APoA4yxm2aQkE5
	6jhLsVW+M3jxG9+b2WCa8VbZEWA1PyUavZ7YxRvjc8A5pzh++tzavpUQngep3eL+RXMbMH
	JHXyfYW94eG6M+yvp88xV7LIJp2hY8A=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next v3 03/10] bpf: Refactor reporting log_true_size for prog_load
Date: Thu,  2 Oct 2025 23:48:34 +0800
Message-ID: <20251002154841.99348-4-leon.hwang@linux.dev>
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

Therefore, refactor the way of 'log_true_size' reporting in order to
report 'log_true_size' via the extended common attributes easily.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h   |  2 +-
 kernel/bpf/syscall.c  | 24 ++++++++++++++++++++----
 kernel/bpf/verifier.c | 12 ++----------
 3 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a98c833461347..4f595439943d7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2738,7 +2738,7 @@ int bpf_check_uarg_tail_zero(bpfptr_t uaddr, size_t expected_size,
 			     size_t actual_size);
 
 /* verify correctness of eBPF program */
-int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size);
+int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr);
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8d97d67e6abaa..2bdc0b43ec832 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2841,7 +2841,7 @@ static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_PROG_LOAD_LAST_FIELD keyring_id
 
-static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
+static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 {
 	enum bpf_prog_type type = attr->prog_type;
 	struct bpf_prog *prog, *dst_prog = NULL;
@@ -3059,7 +3059,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 		goto free_prog_sec;
 
 	/* run eBPF verifier */
-	err = bpf_check(&prog, attr, uattr, uattr_size);
+	err = bpf_check(&prog, attr, uattr);
 	if (err < 0)
 		goto free_used_maps;
 
@@ -6092,12 +6092,25 @@ static int prog_stream_read(union bpf_attr *attr)
 	return ret;
 }
 
+static int copy_prog_load_log_true_size(union bpf_attr *attr, bpfptr_t uattr, unsigned int size)
+{
+	if (!attr->log_true_size)
+		return 0;
+
+	if (size >= offsetofend(union bpf_attr, log_true_size) &&
+	    copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, log_true_size),
+				  &attr->log_true_size, sizeof(attr->log_true_size)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		     bpfptr_t uattr_common, unsigned int size_common)
 {
 	struct bpf_common_attr common_attrs;
 	union bpf_attr attr;
-	int err;
+	int err, ret;
 
 	err = bpf_check_uarg_tail_zero(uattr, sizeof(attr), size);
 	if (err)
@@ -6145,7 +6158,10 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = map_freeze(&attr);
 		break;
 	case BPF_PROG_LOAD:
-		err = bpf_prog_load(&attr, uattr, size);
+		attr.log_true_size = 0;
+		err = bpf_prog_load(&attr, uattr);
+		ret = copy_prog_load_log_true_size(&attr, uattr, size);
+		err = ret ? ret : err;
 		break;
 	case BPF_OBJ_PIN:
 		err = bpf_obj_pin(&attr);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e892df386eed7..d5089f026f578 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24499,12 +24499,11 @@ static int compute_scc(struct bpf_verifier_env *env)
 	return err;
 }
 
-int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
+int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 {
 	u64 start_time = ktime_get_ns();
 	struct bpf_verifier_env *env;
 	int i, len, ret = -EINVAL, err;
-	u32 log_true_size;
 	bool is_priv;
 
 	BTF_TYPE_EMIT(enum bpf_features);
@@ -24700,17 +24699,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	env->prog->aux->verified_insns = env->insn_processed;
 
 	/* preserve original error even if log finalization is successful */
-	err = bpf_vlog_finalize(&env->log, &log_true_size);
+	err = bpf_vlog_finalize(&env->log, &attr->log_true_size);
 	if (err)
 		ret = err;
 
-	if (uattr_size >= offsetofend(union bpf_attr, log_true_size) &&
-	    copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, log_true_size),
-				  &log_true_size, sizeof(log_true_size))) {
-		ret = -EFAULT;
-		goto err_release_maps;
-	}
-
 	if (ret)
 		goto err_release_maps;
 
-- 
2.51.0


