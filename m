Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F1C40E146
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 18:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241282AbhIPQ27 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Sep 2021 12:28:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40382 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241995AbhIPQ0b (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Sep 2021 12:26:31 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18GFgsYM027913
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 09:25:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=2Ud41W8f3UVH99N8pgaXHFy5OqTvZZTVZAHia0O/tSY=;
 b=rR+24Bq/c67WB6j1TeBlwwMMjHa0XJO1dvRorNROPyuvY84ABLyJIC1P70nR9+bhbPyb
 Jr1Sbn3+bYHEP8SVIVUmvWJrMsXanO00/tuneUMR5VpBz4udJxj/LskqYANx0qU9uNLC
 6/yZC04QQuxBmdU7L51CQW4MyBuK8P2ALBw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3b42vxtth9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 09:25:10 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 16 Sep 2021 09:25:09 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 27B82BE68AAA; Thu, 16 Sep 2021 09:25:02 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Mel Gorman <mgorman@techsingularity.net>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH rfc 1/6] bpf: sched: basic infrastructure for scheduler bpf
Date:   Thu, 16 Sep 2021 09:24:46 -0700
Message-ID: <20210916162451.709260-2-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916162451.709260-1-guro@fb.com>
References: <20210915213550.3696532-1-guro@fb.com>
 <20210916162451.709260-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: QNn0CZhVpdTXPQJl5CxmIXl2K8maan7p
X-Proofpoint-ORIG-GUID: QNn0CZhVpdTXPQJl5CxmIXl2K8maan7p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_04,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=734 adultscore=0
 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit introduces basic definitions and infrastructure for
scheduler bpf programs. It defines the BPF_PROG_TYPE_SCHED program
type and the BPF_SCHED attachment type.

The implementation is inspired by lsm bpf programs and is based on
kretprobes. This will allow to add new hooks with a minimal changes to
the kernel code and without any changes to libbpf/bpftool.
It's very convenient as I anticipate a large number of private patches
being used for a long time before (or if at all) reaching upstream.

Sched programs are expected to return an int, which meaning will be
context defined.

This patch doesn't add any real scheduler hooks (only a stub), it will
be done by following patches in the series.

Scheduler bpf programs as now are very restricted in what they can do:
only the bpf_printk() helper is available. The scheduler context can
impose significant restrictions on what's safe and what's not. So
let's extend their abilities on case by case basis when a need arise.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/bpf_sched.h       | 28 +++++++++++++++
 include/linux/bpf_types.h       |  3 ++
 include/linux/sched_hook_defs.h |  2 ++
 include/uapi/linux/bpf.h        |  2 ++
 kernel/bpf/btf.c                |  1 +
 kernel/bpf/syscall.c            | 14 ++++++--
 kernel/bpf/trampoline.c         |  1 +
 kernel/bpf/verifier.c           |  9 ++++-
 kernel/sched/Makefile           |  1 +
 kernel/sched/bpf_sched.c        | 62 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h  |  2 ++
 11 files changed, 122 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/bpf_sched.h
 create mode 100644 include/linux/sched_hook_defs.h
 create mode 100644 kernel/sched/bpf_sched.c

diff --git a/include/linux/bpf_sched.h b/include/linux/bpf_sched.h
new file mode 100644
index 000000000000..0f8d3dae53df
--- /dev/null
+++ b/include/linux/bpf_sched.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BPF_SCHED_H
+#define _BPF_SCHED_H
+
+#include <linux/bpf.h>
+
+#ifdef CONFIG_BPF_SYSCALL
+
+#define BPF_SCHED_HOOK(RET, DEFAULT, NAME, ...) \
+	RET bpf_sched_##NAME(__VA_ARGS__);
+#include <linux/sched_hook_defs.h>
+#undef BPF_SCHED_HOOK
+
+int bpf_sched_verify_prog(struct bpf_verifier_log *vlog,
+			  const struct bpf_prog *prog);
+
+#else /* CONFIG_BPF_SYSCALL */
+
+#define BPF_SCHED_HOOK(RET, DEFAULT, NAME, ...)	\
+static inline RET bpf_sched_##NAME(__VA_ARGS__)	\
+{						\
+	return DEFAULT;				\
+}
+#undef BPF_SCHED_HOOK
+
+#endif /* CONFIG_BPF_SYSCALL */
+
+#endif /* _BPF_CGROUP_H */
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 9c81724e4b98..ed6aac4368c0 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -79,6 +79,9 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_LSM, lsm,
 #endif
 BPF_PROG_TYPE(BPF_PROG_TYPE_SYSCALL, bpf_syscall,
 	      void *, void *)
+BPF_PROG_TYPE(BPF_PROG_TYPE_SCHED, bpf_sched,
+	      void *, void *)
+
=20
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY, array_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_ARRAY, percpu_array_map_ops)
diff --git a/include/linux/sched_hook_defs.h b/include/linux/sched_hook_d=
efs.h
new file mode 100644
index 000000000000..14344004e335
--- /dev/null
+++ b/include/linux/sched_hook_defs.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+BPF_SCHED_HOOK(int, 0, dummy, void)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d21326558d42..6dfbebb8fc8f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -949,6 +949,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_LSM,
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
+	BPF_PROG_TYPE_SCHED,
 };
=20
 enum bpf_attach_type {
@@ -994,6 +995,7 @@ enum bpf_attach_type {
 	BPF_SK_REUSEPORT_SELECT,
 	BPF_SK_REUSEPORT_SELECT_OR_MIGRATE,
 	BPF_PERF_EVENT,
+	BPF_SCHED,
 	__MAX_BPF_ATTACH_TYPE
 };
=20
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c3d605b22473..fb46e447a062 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4884,6 +4884,7 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
 				return true;
 			t =3D btf_type_by_id(btf, t->type);
 			break;
+		case BPF_SCHED:
 		case BPF_MODIFY_RETURN:
 			/* For now the BPF_MODIFY_RETURN can only be attached to
 			 * functions that return an int.
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4e50c0bfdb7d..67e062376f22 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2026,6 +2026,7 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_=
type,
 		case BPF_PROG_TYPE_LSM:
 		case BPF_PROG_TYPE_STRUCT_OPS:
 		case BPF_PROG_TYPE_EXT:
+		case BPF_PROG_TYPE_SCHED:
 			break;
 		default:
 			return -EINVAL;
@@ -2149,6 +2150,7 @@ static bool is_perfmon_prog_type(enum bpf_prog_type=
 prog_type)
 	case BPF_PROG_TYPE_LSM:
 	case BPF_PROG_TYPE_STRUCT_OPS: /* has access to struct sock */
 	case BPF_PROG_TYPE_EXT: /* extends any prog */
+	case BPF_PROG_TYPE_SCHED:
 		return true;
 	default:
 		return false;
@@ -2682,6 +2684,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog=
 *prog,
 			goto out_put_prog;
 		}
 		break;
+	case BPF_PROG_TYPE_SCHED:
+		if (prog->expected_attach_type !=3D BPF_SCHED) {
+			err =3D -EINVAL;
+			goto out_put_prog;
+		}
+		break;
 	default:
 		err =3D -EINVAL;
 		goto out_put_prog;
@@ -2740,13 +2748,14 @@ static int bpf_tracing_prog_attach(struct bpf_pro=
g *prog,
 	 */
 	if (!prog->aux->dst_trampoline && !tgt_prog) {
 		/*
-		 * Allow re-attach for TRACING and LSM programs. If it's
+		 * Allow re-attach for TRACING, LSM ans SCHED programs. If it's
 		 * currently linked, bpf_trampoline_link_prog will fail.
 		 * EXT programs need to specify tgt_prog_fd, so they
 		 * re-attach in separate code path.
 		 */
 		if (prog->type !=3D BPF_PROG_TYPE_TRACING &&
-		    prog->type !=3D BPF_PROG_TYPE_LSM) {
+		    prog->type !=3D BPF_PROG_TYPE_LSM &&
+		    prog->type !=3D BPF_PROG_TYPE_SCHED) {
 			err =3D -EINVAL;
 			goto out_unlock;
 		}
@@ -2996,6 +3005,7 @@ static int bpf_raw_tracepoint_open(const union bpf_=
attr *attr)
 	case BPF_PROG_TYPE_TRACING:
 	case BPF_PROG_TYPE_EXT:
 	case BPF_PROG_TYPE_LSM:
+	case BPF_PROG_TYPE_SCHED:
 		if (attr->raw_tracepoint.name) {
 			/* The attach point for this category of programs
 			 * should be specified via btf_id during program load.
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 39eaaff81953..980b878892a4 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -394,6 +394,7 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tr=
amp(struct bpf_prog *prog)
 	switch (prog->expected_attach_type) {
 	case BPF_TRACE_FENTRY:
 		return BPF_TRAMP_FENTRY;
+	case BPF_SCHED:
 	case BPF_MODIFY_RETURN:
 		return BPF_TRAMP_MODIFY_RETURN;
 	case BPF_TRACE_FEXIT:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 047ac4b4703b..233445619084 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22,6 +22,7 @@
 #include <linux/error-injection.h>
 #include <linux/bpf_lsm.h>
 #include <linux/btf_ids.h>
+#include <linux/bpf_sched.h>
=20
 #include "disasm.h"
=20
@@ -13477,6 +13478,7 @@ int bpf_check_attach_target(struct bpf_verifier_l=
og *log,
 	case BPF_LSM_MAC:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_SCHED:
 		if (!btf_type_is_func(t)) {
 			bpf_log(log, "attach_btf_id %u is not a function\n",
 				btf_id);
@@ -13601,7 +13603,8 @@ static int check_attach_btf_id(struct bpf_verifie=
r_env *env)
=20
 	if (prog->type !=3D BPF_PROG_TYPE_TRACING &&
 	    prog->type !=3D BPF_PROG_TYPE_LSM &&
-	    prog->type !=3D BPF_PROG_TYPE_EXT)
+	    prog->type !=3D BPF_PROG_TYPE_EXT &&
+	    prog->type !=3D BPF_PROG_TYPE_SCHED)
 		return 0;
=20
 	ret =3D bpf_check_attach_target(&env->log, prog, tgt_prog, btf_id, &tgt=
_info);
@@ -13642,6 +13645,10 @@ static int check_attach_btf_id(struct bpf_verifi=
er_env *env)
 	} else if (prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
 		   btf_id_set_contains(&btf_id_deny, btf_id)) {
 		return -EINVAL;
+	} else if (prog->type =3D=3D BPF_PROG_TYPE_SCHED) {
+		ret =3D bpf_sched_verify_prog(&env->log, prog);
+		if (ret < 0)
+			return ret;
 	}
=20
 	key =3D bpf_trampoline_compute_key(tgt_prog, prog->aux->attach_btf, btf=
_id);
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 978fcfca5871..efb2cad4651b 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -37,3 +37,4 @@ obj-$(CONFIG_MEMBARRIER) +=3D membarrier.o
 obj-$(CONFIG_CPU_ISOLATION) +=3D isolation.o
 obj-$(CONFIG_PSI) +=3D psi.o
 obj-$(CONFIG_SCHED_CORE) +=3D core_sched.o
+obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_sched.o
diff --git a/kernel/sched/bpf_sched.c b/kernel/sched/bpf_sched.c
new file mode 100644
index 000000000000..2f05c186cfd0
--- /dev/null
+++ b/kernel/sched/bpf_sched.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <linux/cgroup.h>
+#include <linux/bpf_verifier.h>
+#include <linux/bpf_sched.h>
+#include <linux/btf_ids.h>
+#include "sched.h"
+
+/*
+ * For every hook declare a nop function where a BPF program can be atta=
ched.
+ */
+#define BPF_SCHED_HOOK(RET, DEFAULT, NAME, ...)	\
+noinline RET bpf_sched_##NAME(__VA_ARGS__)	\
+{						\
+	return DEFAULT;				\
+}
+
+#include <linux/sched_hook_defs.h>
+#undef BPF_SCHED_HOOK
+
+#define BPF_SCHED_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_sched_#=
#NAME)
+BTF_SET_START(bpf_sched_hooks)
+#include <linux/sched_hook_defs.h>
+#undef BPF_SCHED_HOOK
+BTF_SET_END(bpf_sched_hooks)
+
+int bpf_sched_verify_prog(struct bpf_verifier_log *vlog,
+			  const struct bpf_prog *prog)
+{
+	if (!prog->gpl_compatible) {
+		bpf_log(vlog,
+			"sched programs must have a GPL compatible license\n");
+		return -EINVAL;
+	}
+
+	if (!btf_id_set_contains(&bpf_sched_hooks, prog->aux->attach_btf_id)) {
+		bpf_log(vlog, "attach_btf_id %u points to wrong type name %s\n",
+			prog->aux->attach_btf_id, prog->aux->attach_func_name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct bpf_func_proto *
+bpf_sched_func_proto(enum bpf_func_id func_id, const struct bpf_prog *pr=
og)
+{
+	switch (func_id) {
+	case BPF_FUNC_trace_printk:
+		return bpf_get_trace_printk_proto();
+	default:
+		return NULL;
+	}
+}
+
+const struct bpf_prog_ops bpf_sched_prog_ops =3D {
+};
+
+const struct bpf_verifier_ops bpf_sched_verifier_ops =3D {
+	.get_func_proto =3D bpf_sched_func_proto,
+	.is_valid_access =3D btf_ctx_access,
+};
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index d21326558d42..6dfbebb8fc8f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -949,6 +949,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_LSM,
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
+	BPF_PROG_TYPE_SCHED,
 };
=20
 enum bpf_attach_type {
@@ -994,6 +995,7 @@ enum bpf_attach_type {
 	BPF_SK_REUSEPORT_SELECT,
 	BPF_SK_REUSEPORT_SELECT_OR_MIGRATE,
 	BPF_PERF_EVENT,
+	BPF_SCHED,
 	__MAX_BPF_ATTACH_TYPE
 };
=20
--=20
2.31.1

