Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E80048E0EB
	for <lists+bpf@lfdr.de>; Fri, 14 Jan 2022 00:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbiAMXdG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jan 2022 18:33:06 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27604 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230181AbiAMXdG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Jan 2022 18:33:06 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20DN6Xfa002894
        for <bpf@vger.kernel.org>; Thu, 13 Jan 2022 15:33:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=q3CYOeAr6DF4Tj5sbWkXEiSc+qoUQX+iq1lA6pQ0sGM=;
 b=Ij5u1iLVB3B9kPs0w/Fu/5EiZxVqwV+rBQL2kwpjPJYt6UYq3lH8SuFbuq74zcrLOHBU
 C/pOjVmzGxoho77IEmm6V6QNUdf/UzCAZ0TaHqLbNeRVNDApfJQ3HxxYz6tpx4PON6pO
 dAb7a1Ae4v3tu3o11cVgCMH4J09ciLuSXi4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3dj4b988vd-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 13 Jan 2022 15:33:05 -0800
Received: from twshared3814.24.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 15:33:04 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id 9E71A8F97AA9; Thu, 13 Jan 2022 15:32:58 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>, <yhs@fb.com>
CC:     Kenny Yu <kennyyu@fb.com>
Subject: [PATCH bpf-next 1/3] bpf: Add bpf_access_process_vm() helper
Date:   Thu, 13 Jan 2022 15:31:56 -0800
Message-ID: <20220113233158.1582743-2-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220113233158.1582743-1-kennyyu@fb.com>
References: <20220113233158.1582743-1-kennyyu@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Ech1wvUCubWlNXWXAKTjMjGDJTGlLFZ3
X-Proofpoint-ORIG-GUID: Ech1wvUCubWlNXWXAKTjMjGDJTGlLFZ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_10,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201130140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds a helper for bpf programs to access the memory of other
tasks. This also adds the ability for bpf iterator programs to
be sleepable.

As an example use case at Meta, we are using a bpf task iterator program
and this new helper to print C++ async stack traces for all threads of
a given process.

Signed-off-by: Kenny Yu <kennyyu@fb.com>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       | 10 ++++++++++
 kernel/bpf/helpers.c           | 19 +++++++++++++++++++
 kernel/trace/bpf_trace.c       |  2 ++
 tools/include/uapi/linux/bpf.h | 10 ++++++++++
 5 files changed, 42 insertions(+)

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
index b0383d371b9a..4b47ec8ae569 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5018,6 +5018,15 @@ union bpf_attr {
  *
  *	Return
  *		The number of arguments of the traced function.
+ *
+ * long bpf_access_process_vm(struct task_struct *tsk, unsigned long add=
r, void *buf, int len, unsigned int gup_flags)
+ *	Description
+ *		Read *len* bytes from user space address *addr* in *tsk*'s
+ *		address space, and stores the data in *buf*. This is a wrapper
+ *		of **access_process_vm**\ ().
+ *	Return
+ *		The number of bytes written to the buffer, or a negative error
+ *		in case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5206,6 +5215,7 @@ union bpf_attr {
 	FN(get_func_arg),		\
 	FN(get_func_ret),		\
 	FN(get_func_arg_cnt),		\
+	FN(access_process_vm),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 01cfdf40c838..dd588912e197 100644
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
@@ -671,6 +672,24 @@ const struct bpf_func_proto bpf_copy_from_user_proto=
 =3D {
 	.arg3_type	=3D ARG_ANYTHING,
 };
=20
+BPF_CALL_5(bpf_access_process_vm, struct task_struct *, tsk,
+	   unsigned long, addr, void *, buf, int, len, unsigned int, gup_flags)
+{
+	return access_process_vm(tsk, addr, buf, len, gup_flags);
+}
+
+const struct bpf_func_proto bpf_access_process_vm_proto =3D {
+	.func		=3D bpf_access_process_vm,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id	=3D &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
+	.arg2_type	=3D ARG_ANYTHING,
+	.arg3_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg4_type	=3D ARG_CONST_SIZE_OR_ZERO,
+	.arg5_type	=3D ARG_ANYTHING,
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
index b0383d371b9a..4b47ec8ae569 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5018,6 +5018,15 @@ union bpf_attr {
  *
  *	Return
  *		The number of arguments of the traced function.
+ *
+ * long bpf_access_process_vm(struct task_struct *tsk, unsigned long add=
r, void *buf, int len, unsigned int gup_flags)
+ *	Description
+ *		Read *len* bytes from user space address *addr* in *tsk*'s
+ *		address space, and stores the data in *buf*. This is a wrapper
+ *		of **access_process_vm**\ ().
+ *	Return
+ *		The number of bytes written to the buffer, or a negative error
+ *		in case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5206,6 +5215,7 @@ union bpf_attr {
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

