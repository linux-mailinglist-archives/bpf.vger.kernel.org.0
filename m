Return-Path: <bpf+bounces-68166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A53BCB53960
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 18:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E99D1CC157F
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 16:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BFC3570B3;
	Thu, 11 Sep 2025 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dO4b7QnY"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E4434F476
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608431; cv=none; b=WKQmw70TMM5TDqAf25y2ypnTUBm6poEXId9m8Ae1MZFcmVjXa0HYu/MgXXkiC1HCkLoC+fwWUiybLbWJ1SMg7Yw5sTAaKlP75EYz4nyKzWTTpYo7CGoJzt8GiOd5ujV3UMJCIO4398pILNu/LNeEnts8FtNX1XcgriXdSgf1xXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608431; c=relaxed/simple;
	bh=QJMFsVlC6iUtwrTQZTcP4mI2xdodvhGoxlobT0ZNOLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0nhZV16IAnfEIqr7AjhHFMwfH78dmgASyFLzxqb04ehHN+Go9EX36MvSYIAs8X78B1rc3BiXhkhjHl9shVnkJQZa5Tqsznv7OtBW2jLjiPy4oJ9YUXSdPYhfteO+CNJuO/BS5G977SnfuNjAQP7w6griDNxHuA/mLvepudq1Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dO4b7QnY; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757608426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S5BAKJCyU4pPpZyPyOAVYDHjhWPEcG/SFfYJJphezyk=;
	b=dO4b7QnYjd4c9NV2mkfWbDzJsDiF/PE2elNH38e0gvnRDNPidCJUBufKJXz1hw/1qtkYwC
	EWe8a/HPZYGU0/aQDDp3193jqHlp6rPWpaCvA6Nvmeut67oA4BOXS62xCVZEI+fNdtUVkj
	Bgm15+1Thz7NsSVA9TS0ACxoxTe4saw=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	menglong8.dong@gmail.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next v2 3/6] bpf: Add common attr support for prog_load and btf_load
Date: Fri, 12 Sep 2025 00:33:25 +0800
Message-ID: <20250911163328.93490-4-leon.hwang@linux.dev>
In-Reply-To: <20250911163328.93490-1-leon.hwang@linux.dev>
References: <20250911163328.93490-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The log buffer of common attributes would be confusing with the one in
'union bpf_attr' for BPF_PROG_LOAD and BPF_BTF_LOAD.

In order to clarify the usage of these two 'log_buf's, they both can be
used for logging if:

* They are same, including 'log_buf', 'log_level' and 'log_size'.
* One of them is missing, then another one will be used for logging.

If they both have 'log_buf' but they are not same, a log message will be
written to the log buffer of 'union bpf_attr'.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h          |  3 ++-
 include/linux/bpf_verifier.h |  2 +-
 include/linux/btf.h          |  3 ++-
 kernel/bpf/btf.c             | 12 +++++++-----
 kernel/bpf/log.c             | 23 ++++++++++++++++++++++-
 kernel/bpf/syscall.c         | 14 ++++++++------
 kernel/bpf/verifier.c        |  8 ++++----
 7 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8f6e87f0f3a89..adc0e68cb4e50 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2717,7 +2717,8 @@ int bpf_check_uarg_tail_zero(bpfptr_t uaddr, size_t expected_size,
 			     size_t actual_size);
 
 /* verify correctness of eBPF program */
-int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size);
+int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size,
+	      struct bpf_common_attr *common_attrs);
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 020de62bd09cd..2d61afec91c92 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -864,7 +864,7 @@ __printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
 __printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
 			    const char *fmt, ...);
 int bpf_vlog_init(struct bpf_verifier_log *log, u32 log_level,
-		  char __user *log_buf, u32 log_size);
+		  char __user *log_buf, u32 log_size, const struct bpf_common_attr *common_attrs);
 void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos);
 int bpf_vlog_finalize(struct bpf_verifier_log *log, u32 *log_size_actual);
 
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 9eda6b113f9b4..c0acb46930bde 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -145,7 +145,8 @@ const char *btf_get_name(const struct btf *btf);
 void btf_get(struct btf *btf);
 void btf_put(struct btf *btf);
 const struct btf_header *btf_header(const struct btf *btf);
-int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_sz);
+int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_sz,
+	       const struct bpf_common_attr *common_attrs);
 struct btf *btf_get_by_fd(int fd);
 int btf_get_info_by_fd(const struct btf *btf,
 		       const union bpf_attr *attr,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 64739308902f7..4a17ae4842210 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5771,7 +5771,8 @@ static int finalize_log(struct bpf_verifier_log *log, bpfptr_t uattr, u32 uattr_
 	return err;
 }
 
-static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
+static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size,
+			     const struct bpf_common_attr *common_attrs)
 {
 	bpfptr_t btf_data = make_bpfptr(attr->btf, uattr.is_kernel);
 	char __user *log_ubuf = u64_to_user_ptr(attr->btf_log_buf);
@@ -5791,8 +5792,8 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	/* user could have requested verbose verifier output
 	 * and supplied buffer to store the verification trace
 	 */
-	err = bpf_vlog_init(&env->log, attr->btf_log_level,
-			    log_ubuf, attr->btf_log_size);
+	err = bpf_vlog_init(&env->log, attr->btf_log_level, log_ubuf, attr->btf_log_size,
+			    common_attrs);
 	if (err)
 		goto errout_free;
 
@@ -8028,12 +8029,13 @@ static int __btf_new_fd(struct btf *btf)
 	return anon_inode_getfd("btf", &btf_fops, btf, O_RDONLY | O_CLOEXEC);
 }
 
-int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
+int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size,
+	       const struct bpf_common_attr *common_attrs)
 {
 	struct btf *btf;
 	int ret;
 
-	btf = btf_parse(attr, uattr, uattr_size);
+	btf = btf_parse(attr, uattr, uattr_size, common_attrs);
 	if (IS_ERR(btf))
 		return PTR_ERR(btf);
 
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index e4983c1303e76..a9a0834884eb9 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -29,12 +29,33 @@ static bool bpf_verifier_log_attr_valid(const struct bpf_verifier_log *log)
 }
 
 int bpf_vlog_init(struct bpf_verifier_log *log, u32 log_level,
-		  char __user *log_buf, u32 log_size)
+		  char __user *log_buf, u32 log_size, const struct bpf_common_attr *common_attrs)
 {
+	u32 log_true_size;
+	int err;
+
 	log->level = log_level;
 	log->ubuf = log_buf;
 	log->len_total = log_size;
 
+	if (log_buf && common_attrs && common_attrs->log_buf &&
+	    ((u64) log_buf != common_attrs->log_buf || log_level != common_attrs->log_level ||
+	     log_size != common_attrs->log_size)) {
+		if (!bpf_verifier_log_attr_valid(log))
+			return -EINVAL;
+		bpf_log(log, "Conflict log configs between bpf_attr and common_attr.\n");
+		err = bpf_vlog_finalize(log, &log_true_size);
+		if (err)
+			return err;
+		return -EINVAL;
+	}
+
+	if (!log_buf && common_attrs && common_attrs->log_buf) {
+		log->level = common_attrs->log_level;
+		log->ubuf = u64_to_user_ptr(common_attrs->log_buf);
+		log->len_total = common_attrs->log_size;
+	}
+
 	/* log attributes have to be sane */
 	if (!bpf_verifier_log_attr_valid(log))
 		return -EINVAL;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d49f822ceea12..5e5cf0262a14e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2764,7 +2764,8 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_PROG_LOAD_LAST_FIELD fd_array_cnt
 
-static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
+static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size,
+			 struct bpf_common_attr *common_attrs)
 {
 	enum bpf_prog_type type = attr->prog_type;
 	struct bpf_prog *prog, *dst_prog = NULL;
@@ -2976,7 +2977,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 		goto free_prog_sec;
 
 	/* run eBPF verifier */
-	err = bpf_check(&prog, attr, uattr, uattr_size);
+	err = bpf_check(&prog, attr, uattr, uattr_size, common_attrs);
 	if (err < 0)
 		goto free_used_maps;
 
@@ -5292,7 +5293,8 @@ static int bpf_obj_get_info_by_fd(const union bpf_attr *attr,
 
 #define BPF_BTF_LOAD_LAST_FIELD btf_token_fd
 
-static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
+static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size,
+			struct bpf_common_attr *common_attrs)
 {
 	struct bpf_token *token = NULL;
 
@@ -5319,7 +5321,7 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_
 
 	bpf_token_put(token);
 
-	return btf_new_fd(attr, uattr, uattr_size);
+	return btf_new_fd(attr, uattr, uattr_size, common_attrs);
 }
 
 #define BPF_BTF_GET_FD_BY_ID_LAST_FIELD fd_by_id_token_fd
@@ -6036,7 +6038,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = map_freeze(&attr);
 		break;
 	case BPF_PROG_LOAD:
-		err = bpf_prog_load(&attr, uattr, size);
+		err = bpf_prog_load(&attr, uattr, size, &common_attrs);
 		break;
 	case BPF_OBJ_PIN:
 		err = bpf_obj_pin(&attr);
@@ -6081,7 +6083,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = bpf_raw_tracepoint_open(&attr);
 		break;
 	case BPF_BTF_LOAD:
-		err = bpf_btf_load(&attr, uattr, size);
+		err = bpf_btf_load(&attr, uattr, size, &common_attrs);
 		break;
 	case BPF_BTF_GET_FD_BY_ID:
 		err = bpf_btf_get_fd_by_id(&attr);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b9394f8fac0ed..77b57289ec097 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24584,7 +24584,8 @@ static int compute_scc(struct bpf_verifier_env *env)
 	return err;
 }
 
-int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
+int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size,
+	      struct bpf_common_attr *common_attrs)
 {
 	u64 start_time = ktime_get_ns();
 	struct bpf_verifier_env *env;
@@ -24633,9 +24634,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	/* user could have requested verbose verifier output
 	 * and supplied buffer to store the verification trace
 	 */
-	ret = bpf_vlog_init(&env->log, attr->log_level,
-			    (char __user *) (unsigned long) attr->log_buf,
-			    attr->log_size);
+	ret = bpf_vlog_init(&env->log, attr->log_level, u64_to_user_ptr(attr->log_buf),
+			    attr->log_size, common_attrs);
 	if (ret)
 		goto err_unlock;
 
-- 
2.50.1


