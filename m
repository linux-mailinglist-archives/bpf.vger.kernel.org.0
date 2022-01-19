Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256CA493F8D
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 19:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354132AbiASSD1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 13:03:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8274 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351948AbiASSD1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Jan 2022 13:03:27 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20JFIx1t009998
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 10:03:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Xbr2QdKmKjbWWlzrxum3Qw0N17pFdADGQJem8uG9LGo=;
 b=ReZdhQo1IU7tt0kght6QohEaQULZ8CdEHqBrHqCV/IvUwysz/FDEHcubOHb3yDzJip+S
 WYVBg/Ga5IxhAkf+qpzBOhG2EpdgxAp0wMFGNdL1fupadsiuA0f62ct9gc9NKnyDwPBN
 iMOfkSKcIGGKnxI21zDj5r6tK9MaX39m9/8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dp99dvypg-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 10:03:26 -0800
Received: from twshared29821.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 10:03:25 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id 37E94942E70F; Wed, 19 Jan 2022 10:03:20 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <kennyyu@fb.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <yhs@fb.com>,
        <alexei.starovoitov@gmail.com>, <phoenix1987@gmail.com>
Subject: [PATCH v3 bpf-next 1/3] bpf: Add bpf_access_process_vm() helper
Date:   Wed, 19 Jan 2022 10:02:52 -0800
Message-ID: <20220119180254.3174340-2-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220119180254.3174340-1-kennyyu@fb.com>
References: <20220113233158.1582743-1-kennyyu@fb.com>
 <20220119180254.3174340-1-kennyyu@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: yLH8Y1vYKdq9EDxahpTdOR-4GFPsSAtq
X-Proofpoint-GUID: yLH8Y1vYKdq9EDxahpTdOR-4GFPsSAtq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_10,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190102
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
 kernel/bpf/helpers.c           | 21 +++++++++++++++++++++
 kernel/trace/bpf_trace.c       |  2 ++
 tools/include/uapi/linux/bpf.h | 11 +++++++++++
 6 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6e947cd91152..d3d0ef8df148 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2222,6 +2222,7 @@ extern const struct bpf_func_proto bpf_kallsyms_loo=
kup_name_proto;
 extern const struct bpf_func_proto bpf_find_vma_proto;
 extern const struct bpf_func_proto bpf_loop_proto;
 extern const struct bpf_func_proto bpf_strncmp_proto;
+extern const struct bpf_func_proto bpf_access_process_vm_proto;
=20
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b0383d371b9a..27c2a18d5941 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5018,6 +5018,16 @@ union bpf_attr {
  *
  *	Return
  *		The number of arguments of the traced function.
+ *
+ * long bpf_access_process_vm(void *dst, u32 size, const void *unsafe_pt=
r, struct task_struct *tsk, u32 flags)
+ *	Description
+ *		Read *size* bytes from user space address *unsafe_ptr* in *tsk*'s
+ *		address space, and stores the data in *dst*. *flags* is not
+ *		used yet and is provided for future extensibility. This is a
+ *		wrapper of **access_process_vm**\ ().
+ *	Return
+ *		The number of bytes written to the buffer, or a negative error
+ *		in case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5206,6 +5216,7 @@ union bpf_attr {
 	FN(get_func_arg),		\
 	FN(get_func_ret),		\
 	FN(get_func_arg_cnt),		\
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
index 01cfdf40c838..30f1067ca8dc 100644
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
@@ -671,6 +672,26 @@ const struct bpf_func_proto bpf_copy_from_user_proto=
 =3D {
 	.arg3_type	=3D ARG_ANYTHING,
 };
=20
+BPF_CALL_5(bpf_access_process_vm, void *, dst, u32, size,
+	   const void __user *, user_ptr, struct task_struct *, tsk,
+	   u32, flags)
+{
+	/* flags is not used yet */
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
index b0383d371b9a..27c2a18d5941 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5018,6 +5018,16 @@ union bpf_attr {
  *
  *	Return
  *		The number of arguments of the traced function.
+ *
+ * long bpf_access_process_vm(void *dst, u32 size, const void *unsafe_pt=
r, struct task_struct *tsk, u32 flags)
+ *	Description
+ *		Read *size* bytes from user space address *unsafe_ptr* in *tsk*'s
+ *		address space, and stores the data in *dst*. *flags* is not
+ *		used yet and is provided for future extensibility. This is a
+ *		wrapper of **access_process_vm**\ ().
+ *	Return
+ *		The number of bytes written to the buffer, or a negative error
+ *		in case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5206,6 +5216,7 @@ union bpf_attr {
 	FN(get_func_arg),		\
 	FN(get_func_ret),		\
 	FN(get_func_arg_cnt),		\
+	FN(access_process_vm),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

