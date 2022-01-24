Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97140498995
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 19:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343852AbiAXS5N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 13:57:13 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13860 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344643AbiAXSy6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Jan 2022 13:54:58 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20OHVqJq005336
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 10:54:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+ezaQxHam7VXMQnvszO4TLp5tUJASdAEjJaxMepjlwk=;
 b=G1skclSbxtpjyfCLHFTihWsu1xerXVfdRkY7gLvNqfojz9N9+N1xllCtqGlY1jKv04Y4
 sx92hzw3x5EHyvzeS1O7Q48pY3wpL4stD2KJhM8AR/mdq/L79g5vKFbRBNIxmNN5kghQ
 5wFu+ufbh0cncBox+2FVNWtsO6m+l5hPUds= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dssx9uap1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 10:54:57 -0800
Received: from twshared13036.24.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 10:54:54 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id 6E03A9816193; Mon, 24 Jan 2022 10:54:43 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <kennyyu@fb.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <yhs@fb.com>,
        <alexei.starovoitov@gmail.com>, <andrii.nakryiko@gmail.com>,
        <phoenix1987@gmail.com>
Subject: [PATCH v7 bpf-next 2/4] bpf: Add bpf_copy_from_user_task() helper
Date:   Mon, 24 Jan 2022 10:54:01 -0800
Message-ID: <20220124185403.468466-3-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124185403.468466-1-kennyyu@fb.com>
References: <20220113233158.1582743-1-kennyyu@fb.com>
 <20220124185403.468466-1-kennyyu@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: a7LidNgak8CPMWneSZgaeTVveQ65L_i8
X-Proofpoint-GUID: a7LidNgak8CPMWneSZgaeTVveQ65L_i8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_09,2022-01-24_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201240124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds a helper for bpf programs to read the memory of other
tasks.

As an example use case at Meta, we are using a bpf task iterator program
and this new helper to print C++ async stack traces for all threads of
a given process.

Signed-off-by: Kenny Yu <kennyyu@fb.com>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       | 11 +++++++++++
 kernel/bpf/helpers.c           | 34 ++++++++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c       |  2 ++
 tools/include/uapi/linux/bpf.h | 11 +++++++++++
 5 files changed, 59 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e8ec8d2f2fe3..4f13642c6a47 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2238,6 +2238,7 @@ extern const struct bpf_func_proto bpf_kallsyms_loo=
kup_name_proto;
 extern const struct bpf_func_proto bpf_find_vma_proto;
 extern const struct bpf_func_proto bpf_loop_proto;
 extern const struct bpf_func_proto bpf_strncmp_proto;
+extern const struct bpf_func_proto bpf_copy_from_user_task_proto;
=20
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 16a7574292a5..4a2f7041ebae 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5076,6 +5076,16 @@ union bpf_attr {
  *		associated to *xdp_md*, at *offset*.
  *	Return
  *		0 on success, or a negative error in case of failure.
+ *
+ * long bpf_copy_from_user_task(void *dst, u32 size, const void *user_pt=
r, struct task_struct *tsk, u64 flags)
+ *	Description
+ *		Read *size* bytes from user space address *user_ptr* in *tsk*'s
+ *		address space, and stores the data in *dst*. *flags* is not
+ *		used yet and is provided for future extensibility. This helper
+ *		can only be used by sleepable programs.
+ *	Return
+ *		0 on success, or a negative error in case of failure. On error
+ *		*dst* buffer is zeroed out.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5269,6 +5279,7 @@ union bpf_attr {
 	FN(xdp_get_buff_len),		\
 	FN(xdp_load_bytes),		\
 	FN(xdp_store_bytes),		\
+	FN(copy_from_user_task),	\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 01cfdf40c838..2688b0064289 100644
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
@@ -671,6 +672,39 @@ const struct bpf_func_proto bpf_copy_from_user_proto=
 =3D {
 	.arg3_type	=3D ARG_ANYTHING,
 };
=20
+BPF_CALL_5(bpf_copy_from_user_task, void *, dst, u32, size,
+	   const void __user *, user_ptr, struct task_struct *, tsk, u64, flags=
)
+{
+	int ret;
+
+	/* flags is not used yet */
+	if (flags)
+		return -EINVAL;
+
+	if (size =3D=3D 0)
+		return 0;
+
+	ret =3D access_process_vm(tsk, (unsigned long)user_ptr, dst, size, 0);
+	if (ret =3D=3D size)
+		return 0;
+
+	memset(dst, 0, size);
+	/* Return -EFAULT for partial read */
+	return (ret < 0) ? ret : -EFAULT;
+}
+
+const struct bpf_func_proto bpf_copy_from_user_task_proto =3D {
+	.func		=3D bpf_copy_from_user_task,
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
index 06a9e220069e..a2024ba32a20 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1235,6 +1235,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
 		return &bpf_get_task_stack_proto;
 	case BPF_FUNC_copy_from_user:
 		return prog->aux->sleepable ? &bpf_copy_from_user_proto : NULL;
+	case BPF_FUNC_copy_from_user_task:
+		return prog->aux->sleepable ? &bpf_copy_from_user_task_proto : NULL;
 	case BPF_FUNC_snprintf_btf:
 		return &bpf_snprintf_btf_proto;
 	case BPF_FUNC_per_cpu_ptr:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 16a7574292a5..4a2f7041ebae 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5076,6 +5076,16 @@ union bpf_attr {
  *		associated to *xdp_md*, at *offset*.
  *	Return
  *		0 on success, or a negative error in case of failure.
+ *
+ * long bpf_copy_from_user_task(void *dst, u32 size, const void *user_pt=
r, struct task_struct *tsk, u64 flags)
+ *	Description
+ *		Read *size* bytes from user space address *user_ptr* in *tsk*'s
+ *		address space, and stores the data in *dst*. *flags* is not
+ *		used yet and is provided for future extensibility. This helper
+ *		can only be used by sleepable programs.
+ *	Return
+ *		0 on success, or a negative error in case of failure. On error
+ *		*dst* buffer is zeroed out.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5269,6 +5279,7 @@ union bpf_attr {
 	FN(xdp_get_buff_len),		\
 	FN(xdp_load_bytes),		\
 	FN(xdp_store_bytes),		\
+	FN(copy_from_user_task),	\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

