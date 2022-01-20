Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C315E495340
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 18:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiATRaf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 12:30:35 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37968 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231317AbiATRaI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 12:30:08 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K9YPYW021292
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 09:30:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+IkdYh09MP7ydjauiIiQReGVbOvPT093ggijwGTaiq0=;
 b=ECFuSec0Qr6A4msf0ceW+jYYkPYUvTYudJXduFZexaZWhrF+FJko3+dkQqxHPKhwEHQd
 hD40xyPjELuamwwhrL7IyiyLjpUR5R+MJ93EErU8Qc7MzGNki9EZqE7ZMDkqWuZ/QmSH
 s7OW+WR3NHgGrFmItHlSruTIVejPVS7RIVU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dq56xjp28-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 09:30:07 -0800
Received: from twshared14140.35.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 20 Jan 2022 09:29:55 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id 7302794F45BC; Thu, 20 Jan 2022 09:29:53 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <kennyyu@fb.com>
CC:     <alexei.starovoitov@gmail.com>, <andrii@kernel.org>,
        <ast@kernel.org>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
        <phoenix1987@gmail.com>, <yhs@fb.com>
Subject: [PATCH v5 bpf-next 1/3] bpf: Add bpf_access_process_vm() helper
Date:   Thu, 20 Jan 2022 09:29:40 -0800
Message-ID: <20220120172942.246805-2-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220120172942.246805-1-kennyyu@fb.com>
References: <20220113233158.1582743-1-kennyyu@fb.com>
 <20220120172942.246805-1-kennyyu@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: h9Fhz5ySRFtv8MZTCMLtbXV4zHRTf0Wa
X-Proofpoint-ORIG-GUID: h9Fhz5ySRFtv8MZTCMLtbXV4zHRTf0Wa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_06,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 bulkscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201200090
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds a helper for bpf programs to access the memory of other
tasks. This also adds the ability for bpf iterator programs to
be sleepable.

This changes `bpf_iter_run_prog` to use the appropriate synchronization f=
or
sleepable bpf programs. With sleepable bpf iterator programs, we can no
longer use `rcu_read_lock()` and must use `rcu_read_lock_trace()` instead
to protect the bpf program.

As an example use case at Meta, we are using a bpf task iterator program
and this new helper to print C++ async stack traces for all threads of
a given process.

Signed-off-by: Kenny Yu <kennyyu@fb.com>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       | 11 +++++++++++
 kernel/bpf/bpf_iter.c          | 20 +++++++++++++++-----
 kernel/bpf/helpers.c           | 23 +++++++++++++++++++++++
 kernel/trace/bpf_trace.c       |  2 ++
 tools/include/uapi/linux/bpf.h | 11 +++++++++++
 6 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index dce54eb0aae8..29f174c08126 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2220,6 +2220,7 @@ extern const struct bpf_func_proto bpf_kallsyms_loo=
kup_name_proto;
 extern const struct bpf_func_proto bpf_find_vma_proto;
 extern const struct bpf_func_proto bpf_loop_proto;
 extern const struct bpf_func_proto bpf_strncmp_proto;
+extern const struct bpf_func_proto bpf_access_process_vm_proto;
=20
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fe2272defcd9..2ac56e2512df 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5049,6 +5049,16 @@ union bpf_attr {
  *		This helper is currently supported by cgroup programs only.
  *	Return
  *		0 on success, or a negative error in case of failure.
+ *
+ * long bpf_access_process_vm(void *dst, u32 size, const void *user_ptr,=
 struct task_struct *tsk, u64 flags)
+ *	Description
+ *		Read *size* bytes from user space address *user_ptr* in *tsk*'s
+ *		address space, and stores the data in *dst*. *flags* is not
+ *		used yet and is provided for future extensibility. This is a
+ *		wrapper of **access_process_vm**\ ().
+ *	Return
+ *		The number of bytes written to the buffer, or a negative error
+ *		in case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5239,6 +5249,7 @@ union bpf_attr {
 	FN(get_func_arg_cnt),		\
 	FN(get_retval),			\
 	FN(set_retval),			\
+	FN(access_process_vm),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index b7aef5b3416d..110029ede71e 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -5,6 +5,7 @@
 #include <linux/anon_inodes.h>
 #include <linux/filter.h>
 #include <linux/bpf.h>
+#include <linux/rcupdate_trace.h>
=20
 struct bpf_iter_target_info {
 	struct list_head list;
@@ -684,11 +685,20 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *=
ctx)
 {
 	int ret;
=20
-	rcu_read_lock();
-	migrate_disable();
-	ret =3D bpf_prog_run(prog, ctx);
-	migrate_enable();
-	rcu_read_unlock();
+	if (prog->aux->sleepable) {
+		rcu_read_lock_trace();
+		migrate_disable();
+		might_fault();
+		ret =3D bpf_prog_run(prog, ctx);
+		migrate_enable();
+		rcu_read_unlock_trace();
+	} else {
+		rcu_read_lock();
+		migrate_disable();
+		ret =3D bpf_prog_run(prog, ctx);
+		migrate_enable();
+		rcu_read_unlock();
+	}
=20
 	/* bpf program can only return 0 or 1:
 	 *  0 : okay
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 01cfdf40c838..9d7e86edc48e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -16,6 +16,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/proc_ns.h>
 #include <linux/security.h>
+#include <linux/btf_ids.h>
=20
 #include "../../lib/kstrtox.h"
=20
@@ -671,6 +672,28 @@ const struct bpf_func_proto bpf_copy_from_user_proto=
 =3D {
 	.arg3_type	=3D ARG_ANYTHING,
 };
=20
+BPF_CALL_5(bpf_access_process_vm, void *, dst, u32, size,
+	   const void __user *, user_ptr, struct task_struct *, tsk,
+	   u64, flags)
+{
+	/* flags is not used yet */
+	if (flags)
+		return -EINVAL;
+	return access_process_vm(tsk, (unsigned long)user_ptr, dst, size, 0);
+}
+
+const struct bpf_func_proto bpf_access_process_vm_proto =3D {
+	.func		=3D bpf_access_process_vm,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg2_type	=3D ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	=3D ARG_ANYTHING,
+	.arg4_type	=3D ARG_PTR_TO_BTF_ID,
+	.arg4_btf_id	=3D &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
+	.arg5_type	=3D ARG_ANYTHING
+};
+
 BPF_CALL_2(bpf_per_cpu_ptr, const void *, ptr, u32, cpu)
 {
 	if (cpu >=3D nr_cpu_ids)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 21aa30644219..1a6a81ce2e36 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1257,6 +1257,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
 		return &bpf_find_vma_proto;
 	case BPF_FUNC_trace_vprintk:
 		return bpf_get_trace_vprintk_proto();
+	case BPF_FUNC_access_process_vm:
+		return prog->aux->sleepable ? &bpf_access_process_vm_proto : NULL;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index fe2272defcd9..2ac56e2512df 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5049,6 +5049,16 @@ union bpf_attr {
  *		This helper is currently supported by cgroup programs only.
  *	Return
  *		0 on success, or a negative error in case of failure.
+ *
+ * long bpf_access_process_vm(void *dst, u32 size, const void *user_ptr,=
 struct task_struct *tsk, u64 flags)
+ *	Description
+ *		Read *size* bytes from user space address *user_ptr* in *tsk*'s
+ *		address space, and stores the data in *dst*. *flags* is not
+ *		used yet and is provided for future extensibility. This is a
+ *		wrapper of **access_process_vm**\ ().
+ *	Return
+ *		The number of bytes written to the buffer, or a negative error
+ *		in case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5239,6 +5249,7 @@ union bpf_attr {
 	FN(get_func_arg_cnt),		\
 	FN(get_retval),			\
 	FN(set_retval),			\
+	FN(access_process_vm),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

