Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416736DA64D
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 01:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjDFXo2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 6 Apr 2023 19:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239432AbjDFXnu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 19:43:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9777A5CE
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 16:43:13 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 336LRni8020297
        for <bpf@vger.kernel.org>; Thu, 6 Apr 2023 16:43:06 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3psfmg8yjs-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 16:43:06 -0700
Received: from twshared7331.15.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 6 Apr 2023 16:42:46 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id AC6FC2D5BE512; Thu,  6 Apr 2023 16:42:34 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v4 bpf-next 13/19] bpf: simplify internal verifier log interface
Date:   Thu, 6 Apr 2023 16:41:59 -0700
Message-ID: <20230406234205.323208-14-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406234205.323208-1-andrii@kernel.org>
References: <20230406234205.323208-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: trm1OULRkhOfIlDS8a2R6xiBbAAWel1C
X-Proofpoint-ORIG-GUID: trm1OULRkhOfIlDS8a2R6xiBbAAWel1C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_13,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Simplify internal verifier log API down to bpf_vlog_init() and
bpf_vlog_finalize(). The former handles input arguments validation in
one place and makes it easier to change it. The latter subsumes -ENOSPC
(truncation) and -EFAULT handling and simplifies both caller's code
(bpf_check() and btf_parse()).

For btf_parse(), this patch also makes sure that verifier log
finalization happens even if there is some error condition during BTF
verification process prior to normal finalization step.

Acked-by: Lorenz Bauer <lmb@isovalent.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h | 13 ++------
 kernel/bpf/btf.c             | 65 ++++++++++++++++++------------------
 kernel/bpf/log.c             | 48 +++++++++++++++++++++-----
 kernel/bpf/verifier.c        | 39 +++++++++-------------
 4 files changed, 90 insertions(+), 75 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 98d2eb382dbb..f03852b89d28 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -518,13 +518,6 @@ struct bpf_verifier_log {
 #define BPF_LOG_MIN_ALIGNMENT 8U
 #define BPF_LOG_ALIGNMENT 40U
 
-static inline bool bpf_verifier_log_full(const struct bpf_verifier_log *log)
-{
-	if (log->level & BPF_LOG_FIXED)
-		return log->end_pos >= log->len_total;
-	return false;
-}
-
 static inline bool bpf_verifier_log_needed(const struct bpf_verifier_log *log)
 {
 	return log && log->level;
@@ -612,16 +605,16 @@ struct bpf_verifier_env {
 	char type_str_buf[TYPE_STR_BUF_LEN];
 };
 
-bool bpf_verifier_log_attr_valid(const struct bpf_verifier_log *log);
 __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
 				      const char *fmt, va_list args);
 __printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
 					   const char *fmt, ...);
 __printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
 			    const char *fmt, ...);
+int bpf_vlog_init(struct bpf_verifier_log *log, u32 log_level,
+		  char __user *log_buf, u32 log_size);
 void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos);
-void bpf_vlog_finalize(struct bpf_verifier_log *log);
-bool bpf_vlog_truncated(const struct bpf_verifier_log *log);
+int bpf_vlog_finalize(struct bpf_verifier_log *log, u32 *log_size_actual);
 
 static inline struct bpf_func_state *cur_func(struct bpf_verifier_env *env)
 {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0748cf4b8ab6..ffc31a1c84af 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5504,16 +5504,30 @@ static int btf_check_type_tags(struct btf_verifier_env *env,
 	return 0;
 }
 
+static int finalize_log(struct bpf_verifier_log *log, bpfptr_t uattr, u32 uattr_size)
+{
+	u32 log_true_size;
+	int err;
+
+	err = bpf_vlog_finalize(log, &log_true_size);
+
+	if (uattr_size >= offsetofend(union bpf_attr, btf_log_true_size) &&
+	    copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, btf_log_true_size),
+				  &log_true_size, sizeof(log_true_size)))
+		err = -EFAULT;
+
+	return err;
+}
+
 static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 {
 	bpfptr_t btf_data = make_bpfptr(attr->btf, uattr.is_kernel);
 	char __user *log_ubuf = u64_to_user_ptr(attr->btf_log_buf);
 	struct btf_struct_metas *struct_meta_tab;
 	struct btf_verifier_env *env = NULL;
-	struct bpf_verifier_log *log;
 	struct btf *btf = NULL;
 	u8 *data;
-	int err;
+	int err, ret;
 
 	if (attr->btf_size > BTF_MAX_SIZE)
 		return ERR_PTR(-E2BIG);
@@ -5522,21 +5536,13 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	if (!env)
 		return ERR_PTR(-ENOMEM);
 
-	log = &env->log;
-	if (attr->btf_log_level || log_ubuf || attr->btf_log_size) {
-		/* user requested verbose verifier output
-		 * and supplied buffer to store the verification trace
-		 */
-		log->level = attr->btf_log_level;
-		log->ubuf = log_ubuf;
-		log->len_total = attr->btf_log_size;
-
-		/* log attributes have to be sane */
-		if (!bpf_verifier_log_attr_valid(log)) {
-			err = -EINVAL;
-			goto errout;
-		}
-	}
+	/* user could have requested verbose verifier output
+	 * and supplied buffer to store the verification trace
+	 */
+	err = bpf_vlog_init(&env->log, attr->btf_log_level,
+			    log_ubuf, attr->btf_log_size);
+	if (err)
+		goto errout_free;
 
 	btf = kzalloc(sizeof(*btf), GFP_KERNEL | __GFP_NOWARN);
 	if (!btf) {
@@ -5577,7 +5583,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	if (err)
 		goto errout;
 
-	struct_meta_tab = btf_parse_struct_metas(log, btf);
+	struct_meta_tab = btf_parse_struct_metas(&env->log, btf);
 	if (IS_ERR(struct_meta_tab)) {
 		err = PTR_ERR(struct_meta_tab);
 		goto errout;
@@ -5594,21 +5600,9 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 		}
 	}
 
-	bpf_vlog_finalize(log);
-	if (uattr_size >= offsetofend(union bpf_attr, btf_log_true_size) &&
-	    copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, btf_log_true_size),
-				  &log->len_max, sizeof(log->len_max))) {
-		err = -EFAULT;
-		goto errout_meta;
-	}
-	if (bpf_vlog_truncated(log)) {
-		err = -ENOSPC;
-		goto errout_meta;
-	}
-	if (log->level && log->level != BPF_LOG_KERNEL && !log->ubuf) {
-		err = -EFAULT;
-		goto errout_meta;
-	}
+	err = finalize_log(&env->log, uattr, uattr_size);
+	if (err)
+		goto errout_free;
 
 	btf_verifier_env_free(env);
 	refcount_set(&btf->refcnt, 1);
@@ -5617,6 +5611,11 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 errout_meta:
 	btf_free_struct_meta_tab(btf);
 errout:
+	/* overwrite err with -ENOSPC or -EFAULT */
+	ret = finalize_log(&env->log, uattr, uattr_size);
+	if (ret)
+		err = ret;
+errout_free:
 	btf_verifier_env_free(env);
 	if (btf)
 		btf_free(btf);
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 47bea2fad6fe..1fae2c5d7ae4 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -10,12 +10,26 @@
 #include <linux/bpf_verifier.h>
 #include <linux/math64.h>
 
-bool bpf_verifier_log_attr_valid(const struct bpf_verifier_log *log)
+static bool bpf_verifier_log_attr_valid(const struct bpf_verifier_log *log)
 {
 	return log->len_total > 0 && log->len_total <= UINT_MAX >> 2 &&
 	       log->level && log->ubuf && !(log->level & ~BPF_LOG_MASK);
 }
 
+int bpf_vlog_init(struct bpf_verifier_log *log, u32 log_level,
+		  char __user *log_buf, u32 log_size)
+{
+	log->level = log_level;
+	log->ubuf = log_buf;
+	log->len_total = log_size;
+
+	/* log attributes have to be sane */
+	if (!bpf_verifier_log_attr_valid(log))
+		return -EINVAL;
+
+	return 0;
+}
+
 static void bpf_vlog_update_len_max(struct bpf_verifier_log *log, u32 add_len)
 {
 	/* add_len includes terminal \0, so no need for +1. */
@@ -197,24 +211,25 @@ static int bpf_vlog_reverse_ubuf(struct bpf_verifier_log *log, int start, int en
 	return 0;
 }
 
-bool bpf_vlog_truncated(const struct bpf_verifier_log *log)
+static bool bpf_vlog_truncated(const struct bpf_verifier_log *log)
 {
 	return log->len_max > log->len_total;
 }
 
-void bpf_vlog_finalize(struct bpf_verifier_log *log)
+int bpf_vlog_finalize(struct bpf_verifier_log *log, u32 *log_size_actual)
 {
 	u32 sublen;
 	int err;
 
-	if (!log || !log->level || !log->ubuf)
-		return;
-	if ((log->level & BPF_LOG_FIXED) || log->level == BPF_LOG_KERNEL)
-		return;
+	*log_size_actual = 0;
+	if (!log || log->level == 0 || log->level == BPF_LOG_KERNEL)
+		return 0;
 
+	if (!log->ubuf)
+		goto skip_log_rotate;
 	/* If we never truncated log, there is nothing to move around. */
-	if (log->start_pos == 0)
-		return;
+	if ((log->level & BPF_LOG_FIXED) || log->start_pos == 0)
+		goto skip_log_rotate;
 
 	/* Otherwise we need to rotate log contents to make it start from the
 	 * buffer beginning and be a continuous zero-terminated string. Note
@@ -257,6 +272,21 @@ void bpf_vlog_finalize(struct bpf_verifier_log *log)
 	err = err ?: bpf_vlog_reverse_ubuf(log, sublen, log->len_total);
 	if (err)
 		log->ubuf = NULL;
+
+skip_log_rotate:
+	*log_size_actual = log->len_max;
+
+	/* properly initialized log has either both ubuf!=NULL and len_total>0
+	 * or ubuf==NULL and len_total==0, so if this condition doesn't hold,
+	 * we got a fault somewhere along the way, so report it back
+	 */
+	if (!!log->ubuf != !!log->len_total)
+		return -EFAULT;
+
+	if (bpf_vlog_truncated(log))
+		return -ENOSPC;
+
+	return 0;
 }
 
 /* log_level controls verbosity level of eBPF verifier.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index da8b030c82ce..ff10a7214861 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18678,8 +18678,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 {
 	u64 start_time = ktime_get_ns();
 	struct bpf_verifier_env *env;
-	struct bpf_verifier_log *log;
-	int i, len, ret = -EINVAL;
+	int i, len, ret = -EINVAL, err;
+	u32 log_true_size;
 	bool is_priv;
 
 	/* no program is valid */
@@ -18692,7 +18692,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	env = kzalloc(sizeof(struct bpf_verifier_env), GFP_KERNEL);
 	if (!env)
 		return -ENOMEM;
-	log = &env->log;
 
 	len = (*prog)->len;
 	env->insn_aux_data =
@@ -18713,20 +18712,14 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (!is_priv)
 		mutex_lock(&bpf_verifier_lock);
 
-	if (attr->log_level || attr->log_buf || attr->log_size) {
-		/* user requested verbose verifier output
-		 * and supplied buffer to store the verification trace
-		 */
-		log->level = attr->log_level;
-		log->ubuf = (char __user *) (unsigned long) attr->log_buf;
-		log->len_total = attr->log_size;
-
-		/* log attributes have to be sane */
-		if (!bpf_verifier_log_attr_valid(log)) {
-			ret = -EINVAL;
-			goto err_unlock;
-		}
-	}
+	/* user could have requested verbose verifier output
+	 * and supplied buffer to store the verification trace
+	 */
+	ret = bpf_vlog_init(&env->log, attr->log_level,
+			    (char __user *) (unsigned long) attr->log_buf,
+			    attr->log_size);
+	if (ret)
+		goto err_unlock;
 
 	mark_verifier_state_clean(env);
 
@@ -18840,17 +18833,17 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	print_verification_stats(env);
 	env->prog->aux->verified_insns = env->insn_processed;
 
-	bpf_vlog_finalize(log);
+	/* preserve original error even if log finalization is successful */
+	err = bpf_vlog_finalize(&env->log, &log_true_size);
+	if (err)
+		ret = err;
+
 	if (uattr_size >= offsetofend(union bpf_attr, log_true_size) &&
 	    copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, log_true_size),
-				  &log->len_max, sizeof(log->len_max))) {
+				  &log_true_size, sizeof(log_true_size))) {
 		ret = -EFAULT;
 		goto err_release_maps;
 	}
-	if (bpf_vlog_truncated(log))
-		ret = -ENOSPC;
-	if (log->level && log->level != BPF_LOG_KERNEL && !log->ubuf)
-		ret = -EFAULT;
 
 	if (ret)
 		goto err_release_maps;
-- 
2.34.1

