Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D5B6CFA0F
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 06:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjC3ES3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 30 Mar 2023 00:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjC3ESW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 00:18:22 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2D85BBE
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 21:18:17 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TJTvWl006271
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 21:18:17 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pmr5349tv-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 21:18:16 -0700
Received: from twshared32017.39.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 29 Mar 2023 21:18:13 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 221042C6767D3; Wed, 29 Mar 2023 21:18:06 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 6/8] bpf: add log_size_actual output field to return log contents size
Date:   Wed, 29 Mar 2023 21:16:40 -0700
Message-ID: <20230330041642.1118787-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330041642.1118787-1-andrii@kernel.org>
References: <20230330041642.1118787-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: LlaF7KQrFL7ZoizayJKFnVmAjO2N9Tcs
X-Proofpoint-ORIG-GUID: LlaF7KQrFL7ZoizayJKFnVmAjO2N9Tcs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_16,2023-03-28_02,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add output-only log_size_actual/btf_log_size_actual field to
BPF_PROG_LOAD and BPF_BTF_LOAD commands, respectively. It will return
the size of log buffer necessary to fit in all the log contents at
specified log_level. This is very useful for BPF loader libraries like
libbpf to be able to size log buffer correctly, but could be used by
users directly, if necessary, as well.

This patch plumbs all this through the code, taking into account actual
bpf_attr size provided by user to determine if these new fields are
expected by users. And if they are, set them from kernel on return.

We refactory btf_parse() function to accommodate this, moving attr and
uattr handling inside it. The rest is very straightforward code, which
is split from the logging accounting changes in the previous patch to
make it simpler to review logic vs UAPI changes.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h            |  2 +-
 include/linux/btf.h            |  2 +-
 include/uapi/linux/bpf.h       | 10 ++++++++++
 kernel/bpf/btf.c               | 32 ++++++++++++++++++--------------
 kernel/bpf/syscall.c           | 16 ++++++++--------
 kernel/bpf/verifier.c          |  8 +++++++-
 tools/include/uapi/linux/bpf.h | 12 +++++++++++-
 7 files changed, 56 insertions(+), 26 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2d8f3f639e68..57507a2fcc8d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2176,7 +2176,7 @@ int bpf_check_uarg_tail_zero(bpfptr_t uaddr, size_t expected_size,
 			     size_t actual_size);
 
 /* verify correctness of eBPF program */
-int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr);
+int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size);
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
diff --git a/include/linux/btf.h b/include/linux/btf.h
index d53b10cc55f2..495250162422 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -125,7 +125,7 @@ extern const struct file_operations btf_fops;
 
 void btf_get(struct btf *btf);
 void btf_put(struct btf *btf);
-int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr);
+int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_sz);
 struct btf *btf_get_by_fd(int fd);
 int btf_get_info_by_fd(const struct btf *btf,
 		       const union bpf_attr *attr,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e3d3b5160d26..2d90b820ba1e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1407,6 +1407,11 @@ union bpf_attr {
 		__aligned_u64	fd_array;	/* array of FDs */
 		__aligned_u64	core_relos;
 		__u32		core_relo_rec_size; /* sizeof(struct bpf_core_relo) */
+		/* output: actual total log contents size (including termintaing zero).
+		 * It could be both larger than original log_size (if log was
+		 * truncated), or smaller (if log buffer wasn't filled completely).
+		 */
+		__u32		log_size_actual;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
@@ -1492,6 +1497,11 @@ union bpf_attr {
 		__u32		btf_size;
 		__u32		btf_log_size;
 		__u32		btf_log_level;
+		/* output: actual total log contents size (including termintaing zero).
+		 * It could be both larger than original log_size (if log was
+		 * truncated), or smaller (if log buffer wasn't filled completely).
+		 */
+		__u32		btf_log_size_actual;
 	};
 
 	struct {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 36e3c25bdca5..1e974383f0e6 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5504,9 +5504,10 @@ static int btf_check_type_tags(struct btf_verifier_env *env,
 	return 0;
 }
 
-static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
-			     u32 log_level, char __user *log_ubuf, u32 log_size)
+static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 {
+	bpfptr_t btf_data = make_bpfptr(attr->btf, uattr.is_kernel);
+	char __user *log_ubuf = u64_to_user_ptr(attr->btf_log_buf);
 	struct btf_struct_metas *struct_meta_tab;
 	struct btf_verifier_env *env = NULL;
 	struct bpf_verifier_log *log;
@@ -5514,7 +5515,7 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 	u8 *data;
 	int err;
 
-	if (btf_data_size > BTF_MAX_SIZE)
+	if (attr->btf_size > BTF_MAX_SIZE)
 		return ERR_PTR(-E2BIG);
 
 	env = kzalloc(sizeof(*env), GFP_KERNEL | __GFP_NOWARN);
@@ -5522,13 +5523,13 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 		return ERR_PTR(-ENOMEM);
 
 	log = &env->log;
-	if (log_level || log_ubuf || log_size) {
+	if (attr->btf_log_level || log_ubuf || attr->btf_log_size) {
 		/* user requested verbose verifier output
 		 * and supplied buffer to store the verification trace
 		 */
-		log->level = log_level;
+		log->level = attr->btf_log_level;
 		log->ubuf = log_ubuf;
-		log->len_total = log_size;
+		log->len_total = attr->btf_log_size;
 
 		/* log attributes have to be sane */
 		if (!bpf_verifier_log_attr_valid(log)) {
@@ -5544,16 +5545,16 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 	}
 	env->btf = btf;
 
-	data = kvmalloc(btf_data_size, GFP_KERNEL | __GFP_NOWARN);
+	data = kvmalloc(attr->btf_size, GFP_KERNEL | __GFP_NOWARN);
 	if (!data) {
 		err = -ENOMEM;
 		goto errout;
 	}
 
 	btf->data = data;
-	btf->data_size = btf_data_size;
+	btf->data_size = attr->btf_size;
 
-	if (copy_from_bpfptr(data, btf_data, btf_data_size)) {
+	if (copy_from_bpfptr(data, btf_data, attr->btf_size)) {
 		err = -EFAULT;
 		goto errout;
 	}
@@ -5594,6 +5595,12 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 	}
 
 	bpf_vlog_finalize(log);
+	if (uattr_size >= offsetofend(union bpf_attr, btf_log_size_actual) &&
+	    copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, btf_log_size_actual),
+				  &log->len_max, sizeof(log->len_max))) {
+		err = -EFAULT;
+		goto errout_meta;
+	}
 	if (bpf_vlog_truncated(log)) {
 		err = -ENOSPC;
 		goto errout_meta;
@@ -7214,15 +7221,12 @@ static int __btf_new_fd(struct btf *btf)
 	return anon_inode_getfd("btf", &btf_fops, btf, O_RDONLY | O_CLOEXEC);
 }
 
-int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr)
+int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 {
 	struct btf *btf;
 	int ret;
 
-	btf = btf_parse(make_bpfptr(attr->btf, uattr.is_kernel),
-			attr->btf_size, attr->btf_log_level,
-			u64_to_user_ptr(attr->btf_log_buf),
-			attr->btf_log_size);
+	btf = btf_parse(attr, uattr, uattr_size);
 	if (IS_ERR(btf))
 		return PTR_ERR(btf);
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e18ac7fdc210..fe2411a0d68e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2501,9 +2501,9 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 }
 
 /* last field in 'union bpf_attr' used by this command */
-#define	BPF_PROG_LOAD_LAST_FIELD core_relo_rec_size
+#define	BPF_PROG_LOAD_LAST_FIELD log_size_actual
 
-static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
+static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 {
 	enum bpf_prog_type type = attr->prog_type;
 	struct bpf_prog *prog, *dst_prog = NULL;
@@ -2653,7 +2653,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 		goto free_prog_sec;
 
 	/* run eBPF verifier */
-	err = bpf_check(&prog, attr, uattr);
+	err = bpf_check(&prog, attr, uattr, uattr_size);
 	if (err < 0)
 		goto free_used_maps;
 
@@ -4371,9 +4371,9 @@ static int bpf_obj_get_info_by_fd(const union bpf_attr *attr,
 	return err;
 }
 
-#define BPF_BTF_LOAD_LAST_FIELD btf_log_level
+#define BPF_BTF_LOAD_LAST_FIELD btf_log_size_actual
 
-static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr)
+static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
 {
 	if (CHECK_ATTR(BPF_BTF_LOAD))
 		return -EINVAL;
@@ -4381,7 +4381,7 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr)
 	if (!bpf_capable())
 		return -EPERM;
 
-	return btf_new_fd(attr, uattr);
+	return btf_new_fd(attr, uattr, uattr_size);
 }
 
 #define BPF_BTF_GET_FD_BY_ID_LAST_FIELD btf_id
@@ -5059,7 +5059,7 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 		err = map_freeze(&attr);
 		break;
 	case BPF_PROG_LOAD:
-		err = bpf_prog_load(&attr, uattr);
+		err = bpf_prog_load(&attr, uattr, size);
 		break;
 	case BPF_OBJ_PIN:
 		err = bpf_obj_pin(&attr);
@@ -5104,7 +5104,7 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 		err = bpf_raw_tracepoint_open(&attr);
 		break;
 	case BPF_BTF_LOAD:
-		err = bpf_btf_load(&attr, uattr);
+		err = bpf_btf_load(&attr, uattr, size);
 		break;
 	case BPF_BTF_GET_FD_BY_ID:
 		err = bpf_btf_get_fd_by_id(&attr);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index efeeafe590b9..b9f7ebf8b536 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18620,7 +18620,7 @@ struct btf *bpf_get_btf_vmlinux(void)
 	return btf_vmlinux;
 }
 
-int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
+int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
 {
 	u64 start_time = ktime_get_ns();
 	struct bpf_verifier_env *env;
@@ -18787,6 +18787,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 	env->prog->aux->verified_insns = env->insn_processed;
 
 	bpf_vlog_finalize(log);
+	if (uattr_size >= offsetofend(union bpf_attr, log_size_actual) &&
+	    copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, log_size_actual),
+				  &log->len_max, sizeof(log->len_max))) {
+		ret = -EFAULT;
+		goto err_release_maps;
+	}
 	if (bpf_vlog_truncated(log))
 		ret = -ENOSPC;
 	if (log->level && log->level != BPF_LOG_KERNEL && !log->ubuf)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d6c5a022ae28..2d90b820ba1e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1407,6 +1407,11 @@ union bpf_attr {
 		__aligned_u64	fd_array;	/* array of FDs */
 		__aligned_u64	core_relos;
 		__u32		core_relo_rec_size; /* sizeof(struct bpf_core_relo) */
+		/* output: actual total log contents size (including termintaing zero).
+		 * It could be both larger than original log_size (if log was
+		 * truncated), or smaller (if log buffer wasn't filled completely).
+		 */
+		__u32		log_size_actual;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
@@ -1492,6 +1497,11 @@ union bpf_attr {
 		__u32		btf_size;
 		__u32		btf_log_size;
 		__u32		btf_log_level;
+		/* output: actual total log contents size (including termintaing zero).
+		 * It could be both larger than original log_size (if log was
+		 * truncated), or smaller (if log buffer wasn't filled completely).
+		 */
+		__u32		btf_log_size_actual;
 	};
 
 	struct {
@@ -1513,7 +1523,7 @@ union bpf_attr {
 	struct { /* struct used by BPF_LINK_CREATE command */
 		union {
 			__u32		prog_fd;	/* eBPF program to attach */
-			__u32		map_fd;		/* eBPF struct_ops to attach */
+			__u32		map_fd;		/* struct_ops to attach */
 		};
 		union {
 			__u32		target_fd;	/* object to attach to */
-- 
2.34.1

