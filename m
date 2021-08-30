Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92933FBE70
	for <lists+bpf@lfdr.de>; Mon, 30 Aug 2021 23:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbhH3VmN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 17:42:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22952 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237612AbhH3VmN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Aug 2021 17:42:13 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ULc4Gu007715
        for <bpf@vger.kernel.org>; Mon, 30 Aug 2021 14:41:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=IlPZLgL4AQdy5d0I3ncGnp6ikd94kA8YfEuE30PUQOI=;
 b=WXh5IbIdlqHLt8gXN6cwB8rMDUhbx+j9DyqgI+yuDiiNihGBeFRXeKnl4K56fOIsVbQq
 L172qLRuzD//6W7nDWtXXBS4t8BtwMO22pEH06ACFDQZaQy/jU3qUOFpDXKvGJ8QmuRD
 Q5x2nSVP9DfWljeX4T1zQ74z1aSyasQOqSA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aryqs39n5-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 30 Aug 2021 14:41:18 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 30 Aug 2021 14:41:16 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 10B8EF146816; Mon, 30 Aug 2021 14:41:14 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <kjain@linux.ibm.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v3 bpf-next 2/3] bpf: introduce helper bpf_get_branch_snapshot
Date:   Mon, 30 Aug 2021 14:41:05 -0700
Message-ID: <20210830214106.4142056-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210830214106.4142056-1-songliubraving@fb.com>
References: <20210830214106.4142056-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 7w-E9Fpy3_Z1gsJI0K0a2uv84UZE-edj
X-Proofpoint-ORIG-GUID: 7w-E9Fpy3_Z1gsJI0K0a2uv84UZE-edj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-30_06:2021-08-30,2021-08-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108300136
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
 include/uapi/linux/bpf.h       | 16 +++++++++++++
 kernel/bpf/trampoline.c        | 13 ++++++++++
 kernel/bpf/verifier.c          | 12 ++++++++++
 kernel/trace/bpf_trace.c       | 43 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 16 +++++++++++++
 7 files changed, 104 insertions(+), 1 deletion(-)

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
index 7d248941ecea3..75aa541c8a134 100644
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
+				call_get_branch:1; /* Do we call get_branch_snapshot() */
 	enum bpf_prog_type	type;		/* Type of BPF program */
 	enum bpf_attach_type	expected_attach_type; /* For some prog types */
 	u32			len;		/* Number of filter blocks */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 791f31dd0abee..1fd4e85d123da 100644
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
+ *		**-EOPNOTSUPP**, the hardware/kernel does not support this function
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
index fe1e857324e66..137293fcceed7 100644
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
@@ -564,6 +565,18 @@ static void notrace inc_misses_counter(struct bpf_pr=
og *prog)
 u64 notrace __bpf_prog_enter(struct bpf_prog *prog)
 	__acquires(RCU)
 {
+#ifdef CONFIG_PERF_EVENTS
+	/* Calling migrate_disable costs two entries in the LBR. To save
+	 * some entries, we call perf_snapshot_branch_stack before
+	 * migrate_disable to save some entries. This is OK because we
+	 * care about the branch trace before entering the BPF program.
+	 * If migrate happens exactly here, there isn't much we can do to
+	 * preserve the data.
+	 */
+	if (prog->call_get_branch)
+		static_call(perf_snapshot_branch_stack)(
+			this_cpu_ptr(&bpf_perf_branch_snapshot));
+#endif
 	rcu_read_lock();
 	migrate_disable();
 	if (unlikely(__this_cpu_inc_return(*(prog->active)) !=3D 1)) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 206c221453cfa..72e8b49da0bf9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6446,6 +6446,18 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 		env->prog->call_get_func_ip =3D true;
 	}
=20
+	if (func_id =3D=3D BPF_FUNC_get_branch_snapshot) {
+		if (env->prog->aux->sleepable) {
+			verbose(env, "sleepable progs cannot call get_branch_snapshot\n");
+			return -ENOTSUPP;
+		}
+		if (!IS_ENABLED(CONFIG_PERF_EVENTS)) {
+			verbose(env, "func %s#%d not supported without CONFIG_PERF_EVENTS\n",
+				func_id_name(func_id), func_id);
+			return -ENOTSUPP;
+		}
+		env->prog->call_get_branch =3D true;
+	}
 	if (changes_data)
 		clear_all_pkt_pointers(env);
 	return 0;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 8e2eb950aa829..a01f26b7877e6 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1017,6 +1017,33 @@ static const struct bpf_func_proto bpf_get_attach_=
cookie_proto_pe =3D {
 	.arg1_type	=3D ARG_PTR_TO_CTX,
 };
=20
+BPF_CALL_2(bpf_get_branch_snapshot, void *, buf, u32, size)
+{
+#ifdef CONFIG_PERF_EVENTS
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
+#else
+	return -EOPNOTSUPP;
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
@@ -1132,6 +1159,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
 		return &bpf_snprintf_proto;
 	case BPF_FUNC_get_func_ip:
 		return &bpf_get_func_ip_proto_tracing;
+	case BPF_FUNC_get_branch_snapshot:
+		return &bpf_get_branch_snapshot_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -1863,9 +1892,23 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_m=
ap *btp)
 	preempt_enable();
 }
=20
+DEFINE_PER_CPU(struct perf_branch_snapshot, bpf_perf_branch_snapshot);
+
 static __always_inline
 void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
 {
+#ifdef CONFIG_PERF_EVENTS
+	/* Calling migrate_disable costs two entries in the LBR. To save
+	 * some entries, we call perf_snapshot_branch_stack before
+	 * migrate_disable to save some entries. This is OK because we
+	 * care about the branch trace before entering the BPF program.
+	 * If migrate happens exactly here, there isn't much we can do to
+	 * preserve the data.
+	 */
+	if (prog->call_get_branch)
+		static_call(perf_snapshot_branch_stack)(
+			this_cpu_ptr(&bpf_perf_branch_snapshot));
+#endif
 	cant_sleep();
 	rcu_read_lock();
 	(void) bpf_prog_run(prog, args);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 791f31dd0abee..1fd4e85d123da 100644
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
+ *		**-EOPNOTSUPP**, the hardware/kernel does not support this function
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

