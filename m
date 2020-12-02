Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8092CB182
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 01:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgLBAZJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 1 Dec 2020 19:25:09 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63310 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727379AbgLBAZG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Dec 2020 19:25:06 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B20Fm6f030814
        for <bpf@vger.kernel.org>; Tue, 1 Dec 2020 16:24:25 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 355vfk1jyn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 01 Dec 2020 16:24:23 -0800
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 1 Dec 2020 16:24:20 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 888F62ECA70C; Tue,  1 Dec 2020 16:24:17 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v4 bpf-next 10/14] bpf: allow to specify kernel module BTFs when attaching BPF programs
Date:   Tue, 1 Dec 2020 16:16:12 -0800
Message-ID: <20201202001616.3378929-11-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201202001616.3378929-1-andrii@kernel.org>
References: <20201202001616.3378929-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_12:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=8 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012020000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add ability for user-space programs to specify non-vmlinux BTF when attaching
BTF-powered BPF programs: raw_tp, fentry/fexit/fmod_ret, LSM, etc. For this,
add attach_btf_obj_id field which contains BTF object ID for either vmlinux or
module. For backwards compatibility (and simplicity) reasons, 0 denotes
vmlinux BTF. Only kernel BTF (vmlinux or module) can be specified.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/btf.h            |  2 ++
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/btf.c               | 25 +++++++++++++++++++------
 kernel/bpf/syscall.c           | 22 +++++++++++++++++++---
 tools/include/uapi/linux/bpf.h |  1 +
 5 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index fb608e4de076..53ce2bc6dc54 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -89,7 +89,9 @@ int btf_type_snprintf_show(const struct btf *btf, u32 type_id, void *obj,
 			   char *buf, int len, u64 flags);
 
 int btf_get_fd_by_id(u32 id);
+struct btf *btf_get_by_id(int id);
 u32 btf_obj_id(const struct btf *btf);
+bool btf_is_kernel(const struct btf *btf);
 bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   const struct btf_member *m,
 			   u32 expected_offset, u32 expected_size);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c3458ec1f30a..60b95b51ccb8 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -558,6 +558,7 @@ union bpf_attr {
 		__u32		line_info_cnt;	/* number of bpf_line_info records */
 		__u32		attach_btf_id;	/* in-kernel BTF type id to attach to */
 		__u32		attach_prog_fd; /* 0 to attach to vmlinux */
+		__u32		attach_btf_obj_id; /* vmlinux/module BTF object ID for BTF type */
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7a19bf5bfe97..12876b272c6b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5652,6 +5652,19 @@ struct btf *btf_get_by_fd(int fd)
 	return btf;
 }
 
+struct btf *btf_get_by_id(int id)
+{
+	struct btf *btf;
+
+	rcu_read_lock();
+	btf = idr_find(&btf_idr, id);
+	if (!btf || !refcount_inc_not_zero(&btf->refcnt))
+		btf = ERR_PTR(-ENOENT);
+	rcu_read_unlock();
+
+	return btf;
+}
+
 int btf_get_info_by_fd(const struct btf *btf,
 		       const union bpf_attr *attr,
 		       union bpf_attr __user *uattr)
@@ -5717,12 +5730,7 @@ int btf_get_fd_by_id(u32 id)
 	struct btf *btf;
 	int fd;
 
-	rcu_read_lock();
-	btf = idr_find(&btf_idr, id);
-	if (!btf || !refcount_inc_not_zero(&btf->refcnt))
-		btf = ERR_PTR(-ENOENT);
-	rcu_read_unlock();
-
+	btf = btf_get_by_id(id);
 	if (IS_ERR(btf))
 		return PTR_ERR(btf);
 
@@ -5738,6 +5746,11 @@ u32 btf_obj_id(const struct btf *btf)
 	return btf->id;
 }
 
+bool btf_is_kernel(const struct btf *btf)
+{
+	return btf->kernel_btf;
+}
+
 static int btf_id_cmp_func(const void *a, const void *b)
 {
 	const int *pa = a, *pb = b;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5ee00611af53..3af073642664 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1968,7 +1968,7 @@ static void bpf_prog_load_fixup_attach_type(union bpf_attr *attr)
 static int
 bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 			   enum bpf_attach_type expected_attach_type,
-			   u32 btf_id, u32 prog_fd)
+			   u32 btf_obj_id, u32 btf_id, u32 prog_fd)
 {
 	if (btf_id) {
 		if (btf_id > BTF_MAX_TYPE)
@@ -1985,6 +1985,9 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 		}
 	}
 
+	if (btf_obj_id && (!btf_id || prog_fd))
+		return -EINVAL;
+
 	if (prog_fd && prog_type != BPF_PROG_TYPE_TRACING &&
 	    prog_type != BPF_PROG_TYPE_EXT)
 		return -EINVAL;
@@ -2097,7 +2100,7 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 }
 
 /* last field in 'union bpf_attr' used by this command */
-#define	BPF_PROG_LOAD_LAST_FIELD attach_prog_fd
+#define	BPF_PROG_LOAD_LAST_FIELD attach_btf_obj_id
 
 static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 {
@@ -2146,6 +2149,7 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 
 	bpf_prog_load_fixup_attach_type(attr);
 	if (bpf_prog_load_check_attach(type, attr->expected_attach_type,
+				       attr->attach_btf_obj_id,
 				       attr->attach_btf_id,
 				       attr->attach_prog_fd))
 		return -EINVAL;
@@ -2158,7 +2162,19 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 	prog->expected_attach_type = attr->expected_attach_type;
 	prog->aux->attach_btf_id = attr->attach_btf_id;
 
-	if (attr->attach_btf_id && !attr->attach_prog_fd) {
+	if (attr->attach_btf_obj_id) {
+		struct btf *btf;
+
+		btf = btf_get_by_id(attr->attach_btf_obj_id);
+		if (IS_ERR(btf))
+			return PTR_ERR(btf);
+		if (!btf_is_kernel(btf)) {
+			btf_put(btf);
+			return -EINVAL;
+		}
+
+		prog->aux->attach_btf = btf;
+	} else if (attr->attach_btf_id && !attr->attach_prog_fd) {
 		struct btf *btf;
 
 		btf = bpf_get_btf_vmlinux();
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c3458ec1f30a..60b95b51ccb8 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -558,6 +558,7 @@ union bpf_attr {
 		__u32		line_info_cnt;	/* number of bpf_line_info records */
 		__u32		attach_btf_id;	/* in-kernel BTF type id to attach to */
 		__u32		attach_prog_fd; /* 0 to attach to vmlinux */
+		__u32		attach_btf_obj_id; /* vmlinux/module BTF object ID for BTF type */
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
-- 
2.24.1

