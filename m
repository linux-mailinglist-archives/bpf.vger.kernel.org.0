Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524413FD059
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 02:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhIAAgd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 20:36:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12048 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241458AbhIAAgb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Aug 2021 20:36:31 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1810ShFG011771
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 17:35:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=wAnRhnQHsBGWS30dkE41tRfVrCpRIrwrA3URonrxIPY=;
 b=eDls+kmj5k/ZqNbOzphaDriia8Rg2WcjO5ly7vXvxvJE2fHf/yOdlBQxbvqiURnZwYAG
 /Dyr2trV3/1QpfNNZSHawgui/FWBtXSj9Qbuubneh5Ajb49uXVOTMbcd1aQa/tuD9mRN
 pZkd441w5n+CG5i0zd7M3yFCeue5aeq8QK4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3arykq3tjr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 17:35:35 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 31 Aug 2021 17:35:33 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 7041FF586921; Tue, 31 Aug 2021 17:35:26 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <kjain@linux.ibm.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v4 bpf-next 2/3] bpf: introduce helper bpf_get_branch_snapshot
Date:   Tue, 31 Aug 2021 17:35:16 -0700
Message-ID: <20210901003517.3953145-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210901003517.3953145-1-songliubraving@fb.com>
References: <20210901003517.3953145-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: ZwJdycc0MsNgz679farVLcuAGaI2tTSn
X-Proofpoint-ORIG-GUID: ZwJdycc0MsNgz679farVLcuAGaI2tTSn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_10:2021-08-31,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2109010001
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
 include/uapi/linux/bpf.h       | 22 +++++++++++++++++++
 kernel/bpf/trampoline.c        |  3 ++-
 kernel/trace/bpf_trace.c       | 40 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 22 +++++++++++++++++++
 4 files changed, 86 insertions(+), 1 deletion(-)

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
index 8e2eb950aa829..a8ec3634a3329 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1017,6 +1017,44 @@ static const struct bpf_func_proto bpf_get_attach_=
cookie_proto_pe =3D {
 	.arg1_type	=3D ARG_PTR_TO_CTX,
 };
=20
+static DEFINE_PER_CPU(struct perf_branch_snapshot, bpf_perf_branch_snaps=
hot);
+
+BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
+{
+#ifndef CONFIG_X86
+	return -ENOENT;
+#else
+	static const u32 br_entry_size =3D sizeof(struct perf_branch_entry);
+	u32 to_copy;
+
+	if (unlikely(flags))
+		return -EINVAL;
+
+	if (!buf || (size % br_entry_size !=3D 0))
+		return -EINVAL;
+
+	static_call(perf_snapshot_branch_stack)(this_cpu_ptr(&bpf_perf_branch_s=
napshot));
+
+	if (this_cpu_ptr(&bpf_perf_branch_snapshot)->nr =3D=3D 0)
+		return -ENOENT;
+
+	to_copy =3D this_cpu_ptr(&bpf_perf_branch_snapshot)->nr *
+		sizeof(struct perf_branch_entry);
+	to_copy =3D min_t(u32, size, to_copy);
+	memcpy(buf, this_cpu_ptr(&bpf_perf_branch_snapshot)->entries, to_copy);
+
+	return to_copy;
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
@@ -1132,6 +1170,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, co=
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

