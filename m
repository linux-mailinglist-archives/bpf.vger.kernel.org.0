Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263513F9090
	for <lists+bpf@lfdr.de>; Fri, 27 Aug 2021 01:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhHZWOR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 18:14:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17786 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243737AbhHZWOR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 26 Aug 2021 18:14:17 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17QMDTkH002918
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 15:13:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=SU8+R4fX0oKFbMqgMHJrrCfxi9zMrGH0LGLOvUK6EuE=;
 b=Ygp22gEUwaKJZVgfexoCkHgSvFA0Xd4jUEGdXbLCbX46Mx9QoOx2M/2L9ihVnfb6A4Rd
 ngIN82SMHVQqRSVPseZUVGgAK8CudRY+WdEv8yKeWDXYL1rXfjKb+twtHscniwXmL93/
 zsVRqoEzTTbZisCu9udggnS4bUQVHzupDwo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3apb9hkpgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 15:13:28 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 26 Aug 2021 15:13:22 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 3605EE2EC447; Thu, 26 Aug 2021 15:13:17 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <kjain@linux.ibm.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 bpf-next 2/3] bpf: introduce helper bpf_get_branch_snapshot
Date:   Thu, 26 Aug 2021 15:13:05 -0700
Message-ID: <20210826221306.2280066-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210826221306.2280066-1-songliubraving@fb.com>
References: <20210826221306.2280066-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: LhAbAUB2Z9r9G40UuXxuwk68ACHl6iaI
X-Proofpoint-GUID: LhAbAUB2Z9r9G40UuXxuwk68ACHl6iaI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-26_05:2021-08-26,2021-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108260124
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
 include/linux/bpf.h            |  2 ++
 include/linux/filter.h         |  3 ++-
 include/uapi/linux/bpf.h       | 16 ++++++++++++++
 kernel/bpf/trampoline.c        | 11 ++++++++++
 kernel/bpf/verifier.c          |  7 +++++++
 kernel/trace/bpf_trace.c       | 38 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 16 ++++++++++++++
 7 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f4c16f19f83e3..1868434dc519a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2220,4 +2220,6 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, co=
nst u64 *raw_args,
 			u32 **bin_buf, u32 num_args);
 void bpf_bprintf_cleanup(void);
=20
+DECLARE_PER_CPU(struct perf_branch_snapshot, bpf_perf_branch_snapshot);
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7d248941ecea3..8c30712f56ab2 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -575,7 +575,8 @@ struct bpf_prog {
 				has_callchain_buf:1, /* callchain buffer allocated? */
 				enforce_expected_attach_type:1, /* Enforce expected_attach_type chec=
king at attach time */
 				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid()=
 */
-				call_get_func_ip:1; /* Do we call get_func_ip() */
+				call_get_func_ip:1, /* Do we call get_func_ip() */
+				call_get_branch:1; /* Do we call get_branch_trace() */
 	enum bpf_prog_type	type;		/* Type of BPF program */
 	enum bpf_attach_type	expected_attach_type; /* For some prog types */
 	u32			len;		/* Number of filter blocks */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 791f31dd0abee..e113879d4f882 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4877,6 +4877,21 @@ union bpf_attr {
  *		Get the struct pt_regs associated with **task**.
  *	Return
  *		A pointer to struct pt_regs.
+ *
+ * long bpf_get_branch_snapshot(void *entries, u32 size)
+ *	Description
+ *		Get branch trace from hardware engines like Intel LBR. The
+ *		branch trace is taken soon after the trigger point of the
+ *		BPF program, so it may contain some entries after the
+ *		trigger point. The user need to filter these entries
+ *		accordingly.
+ *
+ *		The data is stored as struct perf_branch_entry into output
+ *		buffer *entries*. *size* is the size of *entries* in bytes.
+ *
+ *	Return
+ *		> 0, number of valid output entries.
+ *		**-EOPNOTSUP**, the hardware/kernel does not support this function
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5055,6 +5070,7 @@ union bpf_attr {
 	FN(get_func_ip),		\
 	FN(get_attach_cookie),		\
 	FN(task_pt_regs),		\
+	FN(get_branch_snapshot),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index fe1e857324e66..4e21982aec1c6 100644
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
@@ -564,6 +565,16 @@ static void notrace inc_misses_counter(struct bpf_pr=
og *prog)
 u64 notrace __bpf_prog_enter(struct bpf_prog *prog)
 	__acquires(RCU)
 {
+	/* Calling migrate_disable costs two entries in the LBR. To save
+	 * some entries, we call perf_snapshot_branch_stack before
+	 * migrate_disable to save some entries. This is OK because we
+	 * care about the branch trace before entering the BPF program.
+	 * If migrate happens exactly here, there isn't much we can do to
+	 * preserve the data.
+	 */
+	if (prog->call_get_branch)
+		static_call_cond(perf_snapshot_branch_stack)(
+			this_cpu_ptr(&bpf_perf_branch_snapshot));
 	rcu_read_lock();
 	migrate_disable();
 	if (unlikely(__this_cpu_inc_return(*(prog->active)) !=3D 1)) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 206c221453cfa..ba91ec0e204c0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6446,6 +6446,13 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 		env->prog->call_get_func_ip =3D true;
 	}
=20
+	if (func_id =3D=3D BPF_FUNC_get_branch_snapshot) {
+		if (env->prog->aux->sleepable) {
+			verbose(env, "sleepable progs cannot call get_branch_snapshot\n");
+			return -ENOTSUPP;
+		}
+		env->prog->call_get_branch =3D true;
+	}
 	if (changes_data)
 		clear_all_pkt_pointers(env);
 	return 0;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 8e2eb950aa829..4ecade09369e6 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1017,6 +1017,29 @@ static const struct bpf_func_proto bpf_get_attach_=
cookie_proto_pe =3D {
 	.arg1_type	=3D ARG_PTR_TO_CTX,
 };
=20
+BPF_CALL_2(bpf_get_branch_snapshot, void *, buf, u32, size)
+{
+	u32 max_size;
+
+	if (this_cpu_ptr(&bpf_perf_branch_snapshot)->nr =3D=3D 0)
+		return -EOPNOTSUPP;
+
+	max_size =3D this_cpu_ptr(&bpf_perf_branch_snapshot)->nr *
+		sizeof(struct perf_branch_entry);
+	memcpy(buf, this_cpu_ptr(&bpf_perf_branch_snapshot)->entries,
+	       min_t(u32, size, max_size));
+
+	return this_cpu_ptr(&bpf_perf_branch_snapshot)->nr;
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
@@ -1132,6 +1155,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
 		return &bpf_snprintf_proto;
 	case BPF_FUNC_get_func_ip:
 		return &bpf_get_func_ip_proto_tracing;
+	case BPF_FUNC_get_branch_snapshot:
+		return &bpf_get_branch_snapshot_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -1863,9 +1888,22 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_m=
ap *btp)
 	preempt_enable();
 }
=20
+DEFINE_PER_CPU(struct perf_branch_snapshot, bpf_perf_branch_snapshot);
+
 static __always_inline
 void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
 {
+	/* Calling migrate_disable costs two entries in the LBR. To save
+	 * some entries, we call perf_snapshot_branch_stack before
+	 * migrate_disable to save some entries. This is OK because we
+	 * care about the branch trace before entering the BPF program.
+	 * If migrate happens exactly here, there isn't much we can do to
+	 * preserve the data.
+	 */
+	if (prog->call_get_branch)
+		static_call_cond(perf_snapshot_branch_stack)(
+			this_cpu_ptr(&bpf_perf_branch_snapshot));
+
 	cant_sleep();
 	rcu_read_lock();
 	(void) bpf_prog_run(prog, args);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 791f31dd0abee..e113879d4f882 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4877,6 +4877,21 @@ union bpf_attr {
  *		Get the struct pt_regs associated with **task**.
  *	Return
  *		A pointer to struct pt_regs.
+ *
+ * long bpf_get_branch_snapshot(void *entries, u32 size)
+ *	Description
+ *		Get branch trace from hardware engines like Intel LBR. The
+ *		branch trace is taken soon after the trigger point of the
+ *		BPF program, so it may contain some entries after the
+ *		trigger point. The user need to filter these entries
+ *		accordingly.
+ *
+ *		The data is stored as struct perf_branch_entry into output
+ *		buffer *entries*. *size* is the size of *entries* in bytes.
+ *
+ *	Return
+ *		> 0, number of valid output entries.
+ *		**-EOPNOTSUP**, the hardware/kernel does not support this function
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5055,6 +5070,7 @@ union bpf_attr {
 	FN(get_func_ip),		\
 	FN(get_attach_cookie),		\
 	FN(task_pt_regs),		\
+	FN(get_branch_snapshot),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

