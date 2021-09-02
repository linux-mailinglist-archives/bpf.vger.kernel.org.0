Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CCB3FF1F7
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 18:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346464AbhIBQ7S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 12:59:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34656 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242920AbhIBQ7R (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 2 Sep 2021 12:59:17 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 182GtFJG021449
        for <bpf@vger.kernel.org>; Thu, 2 Sep 2021 09:58:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=pH8/nR2PqifgRk2kuwzHEB3by0fF+l7GC6tqeDa1XB4=;
 b=OWaao3Ul44rh3Vd1ACF6vQTZKzTSwvS0bm/QdwjLJwu+ZMtY6WgEVAcBw92/4JEldSZH
 lm001iEHV9bPfI/sqPA3CPnh70OiwlXKn0nYNCQPBtHPFGhClb+gY5XL/MH85YTPWpIa
 0fPfybOmQQgBQgSEIEs/ZMbyZiRdKHSUoWs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3atdxvb58a-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Sep 2021 09:58:18 -0700
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 2 Sep 2021 09:57:20 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 36812FBB7C5B; Thu,  2 Sep 2021 09:57:18 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <kjain@linux.ibm.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v5 bpf-next 2/3] bpf: introduce helper bpf_get_branch_snapshot
Date:   Thu, 2 Sep 2021 09:57:05 -0700
Message-ID: <20210902165706.2812867-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210902165706.2812867-1-songliubraving@fb.com>
References: <20210902165706.2812867-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: GYYMcLl8h3zHA4Jz0uc4VBU_SjwCgtQC
X-Proofpoint-GUID: GYYMcLl8h3zHA4Jz0uc4VBU_SjwCgtQC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-02_04:2021-09-02,2021-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 bulkscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109020098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce bpf_get_branch_snapshot(), which allows tracing pogram to get
branch trace from hardware (e.g. Intel LBR). To use the feature, the
user need to create perf_event with proper branch_record filtering
on each cpu, and then calls bpf_get_branch_snapshot in the bpf function.
On Intel CPUs, VLBR event (raw event 0x1b00) can be use for this.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/uapi/linux/bpf.h       | 22 ++++++++++++++++++++++
 kernel/bpf/trampoline.c        |  3 ++-
 kernel/trace/bpf_trace.c       | 33 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 22 ++++++++++++++++++++++
 4 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 791f31dd0abee..c986e6fad5bc0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4877,6 +4877,27 @@ union bpf_attr {
  *		Get the struct pt_regs associated with **task**.
  *	Return
  *		A pointer to struct pt_regs.
+ *
+ * long bpf_get_branch_snapshot(void *entries, u32 size, u64 flags)
+ *	Description
+ *		Get branch trace from hardware engines like Intel LBR. The
+ *		branch trace is taken soon after the trigger point of the
+ *		BPF program, so it may contain some entries after the
+ *		trigger point. The user need to filter these entries
+ *		accordingly.
+ *
+ *		The data is stored as struct perf_branch_entry into output
+ *		buffer *entries*. *size* is the size of *entries* in bytes.
+ *		*flags* is reserved for now and must be zero.
+ *
+ *	Return
+ *		On success, number of bytes written to *buf*. On error, a
+ *		negative value.
+ *
+ *		**-EINVAL** if arguments invalid or **size** not a multiple
+ *		of **sizeof**\ (**struct perf_branch_entry**\ ).
+ *
+ *		**-ENOENT** if architecture does not support branch records.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5055,6 +5076,7 @@ union bpf_attr {
 	FN(get_func_ip),		\
 	FN(get_attach_cookie),		\
 	FN(task_pt_regs),		\
+	FN(get_branch_snapshot),	\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index fe1e857324e66..39eaaff81953d 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -10,6 +10,7 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/module.h>
+#include <linux/static_call.h>
=20
 /* dummy _ops. The verifier will operate on target program's ops. */
 const struct bpf_verifier_ops bpf_extension_verifier_ops =3D {
@@ -526,7 +527,7 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 }
=20
 #define NO_START_TIME 1
-static u64 notrace bpf_prog_start_time(void)
+static __always_inline u64 notrace bpf_prog_start_time(void)
 {
 	u64 start =3D NO_START_TIME;
=20
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 8e2eb950aa829..1954bc113087c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1017,6 +1017,37 @@ static const struct bpf_func_proto bpf_get_attach_=
cookie_proto_pe =3D {
 	.arg1_type	=3D ARG_PTR_TO_CTX,
 };
=20
+BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
+{
+#ifndef CONFIG_X86
+	return -ENOENT;
+#else
+	static const u32 br_entry_size =3D sizeof(struct perf_branch_entry);
+	u32 entry_cnt =3D size / br_entry_size;
+
+	if (unlikely(flags))
+		return -EINVAL;
+
+	if (!buf || (size % br_entry_size !=3D 0))
+		return -EINVAL;
+
+	entry_cnt =3D static_call(perf_snapshot_branch_stack)(buf, entry_cnt);
+
+	if (!entry_cnt)
+		return -ENOENT;
+
+	return entry_cnt * br_entry_size;
+#endif
+}
+
+static const struct bpf_func_proto bpf_get_branch_snapshot_proto =3D {
+	.func		=3D bpf_get_branch_snapshot,
+	.gpl_only	=3D true,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg2_type	=3D ARG_CONST_SIZE_OR_ZERO,
+};
+
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *=
prog)
 {
@@ -1132,6 +1163,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
 		return &bpf_snprintf_proto;
 	case BPF_FUNC_get_func_ip:
 		return &bpf_get_func_ip_proto_tracing;
+	case BPF_FUNC_get_branch_snapshot:
+		return &bpf_get_branch_snapshot_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 791f31dd0abee..c986e6fad5bc0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4877,6 +4877,27 @@ union bpf_attr {
  *		Get the struct pt_regs associated with **task**.
  *	Return
  *		A pointer to struct pt_regs.
+ *
+ * long bpf_get_branch_snapshot(void *entries, u32 size, u64 flags)
+ *	Description
+ *		Get branch trace from hardware engines like Intel LBR. The
+ *		branch trace is taken soon after the trigger point of the
+ *		BPF program, so it may contain some entries after the
+ *		trigger point. The user need to filter these entries
+ *		accordingly.
+ *
+ *		The data is stored as struct perf_branch_entry into output
+ *		buffer *entries*. *size* is the size of *entries* in bytes.
+ *		*flags* is reserved for now and must be zero.
+ *
+ *	Return
+ *		On success, number of bytes written to *buf*. On error, a
+ *		negative value.
+ *
+ *		**-EINVAL** if arguments invalid or **size** not a multiple
+ *		of **sizeof**\ (**struct perf_branch_entry**\ ).
+ *
+ *		**-ENOENT** if architecture does not support branch records.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5055,6 +5076,7 @@ union bpf_attr {
 	FN(get_func_ip),		\
 	FN(get_attach_cookie),		\
 	FN(task_pt_regs),		\
+	FN(get_branch_snapshot),	\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

