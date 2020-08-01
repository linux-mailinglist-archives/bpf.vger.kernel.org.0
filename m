Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6337123513C
	for <lists+bpf@lfdr.de>; Sat,  1 Aug 2020 10:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgHAIty (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Aug 2020 04:49:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15168 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728484AbgHAItx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 1 Aug 2020 04:49:53 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0718mPNE022611
        for <bpf@vger.kernel.org>; Sat, 1 Aug 2020 01:49:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=WIgQmJTcjQAh1WZkR5Yt3/IhXJ/pNkVpepRij4ldUnk=;
 b=dZRQys+YRCMJEE+UCAQx77GSGd+RHBQXMZ76QTGDLhrxNEYSAOEJewNzf7S/NM/fPBMV
 vvkA8UEc9+53nVsJdmtVAbUeDq7Cij4FmbIxAwkIEF6hFKETdGppB9xl51OkkUaSpN47
 m7zTjRqy0sMb0sL/HqpejIPhGT723LvllfA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 32n42m05vt-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2020 01:49:50 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 1 Aug 2020 01:49:49 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id A474562E53C3; Sat,  1 Aug 2020 01:47:25 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <brouer@redhat.com>, <dlxu@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 1/5] bpf: introduce BPF_PROG_TYPE_USER
Date:   Sat, 1 Aug 2020 01:47:17 -0700
Message-ID: <20200801084721.1812607-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200801084721.1812607-1-songliubraving@fb.com>
References: <20200801084721.1812607-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-01_07:2020-07-31,2020-08-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=992 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008010068
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As of today, to trigger BPF program from user space, the common practise
is to create a uprobe on a special function and calls that function. For
example, bpftrace uses BEGIN_trigger and END_trigger for the BEGIN and EN=
D
programs.

However, uprobe is not ideal for this use case. First, uprobe uses trap,
which adds non-trivial overhead. Second, uprobe requires calculating
function offset at runtime, which is not very reliable. bpftrace has
seen issues with this:
  https://github.com/iovisor/bpftrace/pull/1438
  https://github.com/iovisor/bpftrace/issues/1440

This patch introduces a new BPF program type BPF_PROG_TYPE_USER, or "user
program". User program is triggered via sys_bpf(BPF_PROG_TEST_RUN), which
is significant faster than a trap.

To make user program more flexible, we enabled the following features:
  1. The user can specify on which cpu the program should run. If the
     target cpu is not current cpu, the program is triggered via IPI.
  2. User can pass optional argument to user program. Currently, the
     argument can only be 5x u64 numbers.

User program has access to helper functions in bpf_tracing_func_proto()
and bpf_get_stack|stackid().

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/bpf_types.h      |   2 +
 include/uapi/linux/bpf.h       |  19 ++++++
 kernel/bpf/syscall.c           |   3 +-
 kernel/trace/bpf_trace.c       | 121 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  19 ++++++
 5 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index a52a5688418e5..3c52f3207aced 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -76,6 +76,8 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_EXT, bpf_extension,
 BPF_PROG_TYPE(BPF_PROG_TYPE_LSM, lsm,
 	       void *, void *)
 #endif /* CONFIG_BPF_LSM */
+BPF_PROG_TYPE(BPF_PROG_TYPE_USER, user,
+	       void *, void *)
 #endif
=20
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY, array_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index eb5e0c38eb2cf..f6b9d4e7eeb4e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -190,6 +190,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_EXT,
 	BPF_PROG_TYPE_LSM,
 	BPF_PROG_TYPE_SK_LOOKUP,
+	BPF_PROG_TYPE_USER,
 };
=20
 enum bpf_attach_type {
@@ -556,6 +557,12 @@ union bpf_attr {
 						 */
 		__aligned_u64	ctx_in;
 		__aligned_u64	ctx_out;
+		__u32		cpu_plus;	/* run this program on cpu
+						 * (cpu_plus - 1).
+						 * If cpu_plus =3D=3D 0, run on
+						 * current cpu. Only valid
+						 * for BPF_PROG_TYPE_USER.
+						 */
 	} test;
=20
 	struct { /* anonymous struct used by BPF_*_GET_*_ID */
@@ -4441,4 +4448,16 @@ struct bpf_sk_lookup {
 	__u32 local_port;	/* Host byte order */
 };
=20
+struct pt_regs;
+
+#define BPF_USER_PROG_MAX_ARGS 5
+struct bpf_user_prog_args {
+	__u64 args[BPF_USER_PROG_MAX_ARGS];
+};
+
+struct bpf_user_prog_ctx {
+	struct pt_regs *regs;
+	__u64 args[BPF_USER_PROG_MAX_ARGS];
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cd3d599e9e90e..f5a28fd8a9bc2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2078,6 +2078,7 @@ static bool is_perfmon_prog_type(enum bpf_prog_type=
 prog_type)
 	case BPF_PROG_TYPE_LSM:
 	case BPF_PROG_TYPE_STRUCT_OPS: /* has access to struct sock */
 	case BPF_PROG_TYPE_EXT: /* extends any prog */
+	case BPF_PROG_TYPE_USER:
 		return true;
 	default:
 		return false;
@@ -2969,7 +2970,7 @@ static int bpf_prog_query(const union bpf_attr *att=
r,
 	}
 }
=20
-#define BPF_PROG_TEST_RUN_LAST_FIELD test.ctx_out
+#define BPF_PROG_TEST_RUN_LAST_FIELD test.cpu_plus
=20
 static int bpf_prog_test_run(const union bpf_attr *attr,
 			     union bpf_attr __user *uattr)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cb91ef902cc43..cbe789bc1b986 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -16,6 +16,7 @@
 #include <linux/error-injection.h>
 #include <linux/btf_ids.h>
=20
+#include <asm/irq_regs.h>
 #include <asm/tlb.h>
=20
 #include "trace_probe.h"
@@ -1740,6 +1741,126 @@ const struct bpf_verifier_ops perf_event_verifier=
_ops =3D {
 const struct bpf_prog_ops perf_event_prog_ops =3D {
 };
=20
+struct bpf_user_prog_test_run_info {
+	struct bpf_prog *prog;
+	struct bpf_user_prog_ctx ctx;
+	u32 retval;
+};
+
+static void
+__bpf_prog_test_run_user(struct bpf_user_prog_test_run_info *info)
+{
+	rcu_read_lock();
+	migrate_disable();
+	info->retval =3D BPF_PROG_RUN(info->prog, &info->ctx);
+	migrate_enable();
+	rcu_read_unlock();
+}
+
+static void _bpf_prog_test_run_user(void *data)
+{
+	struct bpf_user_prog_test_run_info *info =3D data;
+
+	info->ctx.regs =3D get_irq_regs();
+	__bpf_prog_test_run_user(info);
+}
+
+static int bpf_prog_test_run_user(struct bpf_prog *prog,
+				  const union bpf_attr *kattr,
+				  union bpf_attr __user *uattr)
+{
+	void __user *data_in =3D u64_to_user_ptr(kattr->test.data_in);
+	__u32 data_size =3D kattr->test.data_size_in;
+	struct bpf_user_prog_test_run_info info;
+	int cpu =3D kattr->test.cpu_plus - 1;
+	int err;
+
+	if (kattr->test.ctx_in || kattr->test.ctx_out ||
+	    kattr->test.duration || kattr->test.repeat ||
+	    kattr->test.data_out)
+		return -EINVAL;
+
+	if ((data_in && !data_size) || (!data_in && data_size))
+		return -EINVAL;
+
+	/* if provided, data_in should be struct bpf_user_prog_args */
+	if (data_size > 0 && data_size !=3D sizeof(struct bpf_user_prog_args))
+		return -EINVAL;
+
+	if (kattr->test.data_size_in) {
+		if (copy_from_user(&info.ctx.args, data_in,
+				   sizeof(struct bpf_user_prog_args)))
+			return -EFAULT;
+	} else {
+		memset(&info.ctx.args, 0, sizeof(struct bpf_user_prog_args));
+	}
+
+	info.prog =3D prog;
+
+	if (!kattr->test.cpu_plus || cpu =3D=3D smp_processor_id()) {
+		/* non-IPI, use regs from perf_fetch_caller_regs */
+		info.ctx.regs =3D get_bpf_raw_tp_regs();
+		if (IS_ERR(info.ctx.regs))
+			return PTR_ERR(info.ctx.regs);
+		perf_fetch_caller_regs(info.ctx.regs);
+		__bpf_prog_test_run_user(&info);
+		put_bpf_raw_tp_regs();
+	} else {
+		err =3D smp_call_function_single(cpu, _bpf_prog_test_run_user,
+					       &info, 1);
+		if (err)
+			return err;
+	}
+
+	if (copy_to_user(&uattr->test.retval, &info.retval, sizeof(u32)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static bool user_prog_is_valid_access(int off, int size, enum bpf_access=
_type type,
+				      const struct bpf_prog *prog,
+				      struct bpf_insn_access_aux *info)
+{
+	const int size_u64 =3D sizeof(u64);
+
+	if (off < 0 || off >=3D sizeof(struct bpf_user_prog_ctx))
+		return false;
+
+	switch (off) {
+	case bpf_ctx_range(struct bpf_user_prog_ctx, regs):
+		bpf_ctx_record_field_size(info, size_u64);
+		if (!bpf_ctx_narrow_access_ok(off, size, size_u64))
+			return false;
+		break;
+	default:
+		break;
+	}
+	return true;
+}
+
+static const struct bpf_func_proto *
+user_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *pr=
og)
+{
+	switch (func_id) {
+	case BPF_FUNC_get_stackid:
+		return &bpf_get_stackid_proto;
+	case BPF_FUNC_get_stack:
+		return &bpf_get_stack_proto;
+	default:
+		return bpf_tracing_func_proto(func_id, prog);
+	}
+}
+
+const struct bpf_verifier_ops user_verifier_ops =3D {
+	.get_func_proto		=3D user_prog_func_proto,
+	.is_valid_access	=3D user_prog_is_valid_access,
+};
+
+const struct bpf_prog_ops user_prog_ops =3D {
+	.test_run	=3D bpf_prog_test_run_user,
+};
+
 static DEFINE_MUTEX(bpf_event_mutex);
=20
 #define BPF_TRACE_MAX_PROGS 64
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index eb5e0c38eb2cf..f6b9d4e7eeb4e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -190,6 +190,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_EXT,
 	BPF_PROG_TYPE_LSM,
 	BPF_PROG_TYPE_SK_LOOKUP,
+	BPF_PROG_TYPE_USER,
 };
=20
 enum bpf_attach_type {
@@ -556,6 +557,12 @@ union bpf_attr {
 						 */
 		__aligned_u64	ctx_in;
 		__aligned_u64	ctx_out;
+		__u32		cpu_plus;	/* run this program on cpu
+						 * (cpu_plus - 1).
+						 * If cpu_plus =3D=3D 0, run on
+						 * current cpu. Only valid
+						 * for BPF_PROG_TYPE_USER.
+						 */
 	} test;
=20
 	struct { /* anonymous struct used by BPF_*_GET_*_ID */
@@ -4441,4 +4448,16 @@ struct bpf_sk_lookup {
 	__u32 local_port;	/* Host byte order */
 };
=20
+struct pt_regs;
+
+#define BPF_USER_PROG_MAX_ARGS 5
+struct bpf_user_prog_args {
+	__u64 args[BPF_USER_PROG_MAX_ARGS];
+};
+
+struct bpf_user_prog_ctx {
+	struct pt_regs *regs;
+	__u64 args[BPF_USER_PROG_MAX_ARGS];
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
--=20
2.24.1

