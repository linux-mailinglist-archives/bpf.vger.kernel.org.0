Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517A33EF789
	for <lists+bpf@lfdr.de>; Wed, 18 Aug 2021 03:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhHRBaj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 21:30:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56434 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233027AbhHRBai (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Aug 2021 21:30:38 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17I1F9Ln013263
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 18:30:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=TnVQkMH4mAe8fhubdqSGXRk+f71lWpczr+zPvZIv9lA=;
 b=nq5nwyhAo4/O9SF78nk6i8s6wUZoACKUk8bwevDkHf6UNZxPL8CCFDgr0XztsawD1jMx
 BYdzb7nOl8MO598QFS9sJ1f/sr7xof94Iu0VICVGQimGhiRJ7PW/KcXaow9Gqt/kNH+g
 YVUqD971WpoXCiVJd7RcFJFCDqCuO55pY/c= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3afqeybxxm-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 18:30:04 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 18:30:03 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 5C194D053991; Tue, 17 Aug 2021 18:30:01 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Like Xu <like.xu@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [RFC] bpf: lbr: enable reading LBR from tracing bpf programs
Date:   Tue, 17 Aug 2021 18:29:37 -0700
Message-ID: <20210818012937.2522409-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: NNOkHqGxXNpPDnqduchT7737YcI491tU
X-Proofpoint-GUID: NNOkHqGxXNpPDnqduchT7737YcI491tU
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-17_09:2021-08-17,2021-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108180007
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The typical way to access LBR is via hardware perf_event. For CPUs with
FREEZE_LBRS_ON_PMI support, PMI could capture reliable LBR. On the other
hand, LBR could also be useful in non-PMI scenario. For example, in
kretprobe or bpf fexit program, LBR could provide a lot of information
on what happened with the function.

In this RFC, we try to enable LBR for BPF program. This works like:
  1. Create a hardware perf_event with PERF_SAMPLE_BRANCH_* on each CPU;
  2. Call a new bpf helper (bpf_get_branch_trace) from the BPF program;
  3. Before calling this bpf program, the kernel stops LBR on local CPU,
     make a copy of LBR, and resumes LBR;
  4. In the bpf program, the helper access the copy from #3.

Please see tools/testing/selftests/bpf/[progs|prog_tests]/get_call_trace.=
c
for a detailed example. Not that, this process is far from ideal, but it
allows quick prototype of this feature.

AFAICT, the biggest challenge here is that we are now sharing LBR in PMI
and out of PMI, which could trigger some interesting race conditions.
However, if we allow some level of missed/corrupted samples, this should
still be very useful.

Please share your thoughts and comments on this. Thanks in advance!

Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Like Xu <like.xu@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 arch/x86/events/intel/lbr.c                   | 16 ++++
 include/linux/filter.h                        |  3 +-
 include/linux/perf_event.h                    |  2 +
 include/uapi/linux/bpf.h                      |  8 ++
 kernel/bpf/trampoline.c                       |  3 +
 kernel/bpf/verifier.c                         |  7 ++
 kernel/events/core.c                          |  5 ++
 kernel/trace/bpf_trace.c                      | 27 ++++++
 net/bpf/test_run.c                            | 15 +++-
 tools/include/uapi/linux/bpf.h                |  8 ++
 .../bpf/prog_tests/get_branch_trace.c         | 82 +++++++++++++++++++
 .../selftests/bpf/progs/get_branch_trace.c    | 36 ++++++++
 tools/testing/selftests/bpf/trace_helpers.c   | 30 +++++++
 tools/testing/selftests/bpf/trace_helpers.h   |  5 ++
 14 files changed, 245 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_branch_tra=
ce.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_branch_trace.c

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 9e6d6eaeb4cb6..e4e863f6fb93d 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1862,3 +1862,19 @@ EXPORT_SYMBOL_GPL(x86_perf_get_lbr);
 struct event_constraint vlbr_constraint =3D
 	__EVENT_CONSTRAINT(INTEL_FIXED_VLBR_EVENT, (1ULL << INTEL_PMC_IDX_FIXED=
_VLBR),
 			  FIXED_EVENT_FLAGS, 1, 0, PERF_X86_EVENT_LBR_SELECT);
+
+DEFINE_PER_CPU(struct perf_branch_entry, bpf_lbr_entries[MAX_LBR_ENTRIES=
]);
+DEFINE_PER_CPU(int, bpf_lbr_cnt);
+
+int bpf_branch_record_read(void)
+{
+	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
+
+	intel_pmu_lbr_disable_all();
+	intel_pmu_lbr_read();
+	memcpy(this_cpu_ptr(&bpf_lbr_entries), cpuc->lbr_entries,
+	       sizeof(struct perf_branch_entry) * x86_pmu.lbr_nr);
+	*this_cpu_ptr(&bpf_lbr_cnt) =3D x86_pmu.lbr_nr;
+	intel_pmu_lbr_enable_all(false);
+	return 0;
+}
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
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fe156a8170aa3..cdc36fa5fda91 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -116,6 +116,8 @@ struct perf_branch_stack {
 	struct perf_branch_entry	entries[];
 };
=20
+int bpf_branch_record_read(void);
+
 struct task_struct;
=20
 /*
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c4f7892edb2b3..442cfef8d6bd5 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4871,6 +4871,13 @@ union bpf_attr {
  * 	Return
  *		Value specified by user at BPF link creation/attachment time
  *		or 0, if it was not specified.
+ *
+ * long bpf_get_branch_trace(void *entries, u32 size, u64 flags)
+ *	Description
+ *		Get branch strace from hardware engines like Intel LBR.
+ * 	Return
+ *		> 0, # of entries.
+ *		**-EOPNOTSUP**, the hardware/kernel does not support this function
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5048,6 +5055,7 @@ union bpf_attr {
 	FN(timer_cancel),		\
 	FN(get_func_ip),		\
 	FN(get_attach_cookie),		\
+	FN(get_branch_trace),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index fe1e857324e66..0526e187f9b21 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -566,6 +566,9 @@ u64 notrace __bpf_prog_enter(struct bpf_prog *prog)
 {
 	rcu_read_lock();
 	migrate_disable();
+	if (prog->call_get_branch)
+		bpf_branch_record_read();
+
 	if (unlikely(__this_cpu_inc_return(*(prog->active)) !=3D 1)) {
 		inc_misses_counter(prog);
 		return 0;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f5a0077c99811..292d2b471892a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6446,6 +6446,13 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 		env->prog->call_get_func_ip =3D true;
 	}
=20
+	if (func_id =3D=3D BPF_FUNC_get_branch_trace) {
+		if (env->prog->aux->sleepable) {
+			verbose(env, "sleepable progs cannot call get_branch_trace\n");
+			return -ENOTSUPP;
+		}
+		env->prog->call_get_branch =3D true;
+	}
 	if (changes_data)
 		clear_all_pkt_pointers(env);
 	return 0;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2d1e63dd97f23..4808ce268223d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13434,3 +13434,8 @@ struct cgroup_subsys perf_event_cgrp_subsys =3D {
 	.threaded	=3D true,
 };
 #endif /* CONFIG_CGROUP_PERF */
+
+int __weak  bpf_branch_record_read(void)
+{
+	return -EOPNOTSUPP;
+}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cbc73c08c4a4e..85683bde1f991 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1002,6 +1002,29 @@ static const struct bpf_func_proto bpf_get_attach_=
cookie_proto_pe =3D {
 	.arg1_type	=3D ARG_PTR_TO_CTX,
 };
=20
+#ifndef MAX_LBR_ENTRIES
+#define MAX_LBR_ENTRIES		32
+#endif
+
+DECLARE_PER_CPU(struct perf_branch_entry, bpf_lbr_entries[MAX_LBR_ENTRIE=
S]);
+DECLARE_PER_CPU(int, bpf_lbr_cnt);
+BPF_CALL_3(bpf_get_branch_trace, void *, buf, u32, size, u64, flags)
+{
+	memcpy(buf, *this_cpu_ptr(&bpf_lbr_entries),
+	       min_t(u32, size,
+		     sizeof(struct perf_branch_entry) * MAX_LBR_ENTRIES));
+	return *this_cpu_ptr(&bpf_lbr_cnt);
+}
+
+static const struct bpf_func_proto bpf_get_branch_trace_proto =3D {
+	.func		=3D bpf_get_branch_trace,
+	.gpl_only	=3D true,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg2_type	=3D ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	=3D ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *=
prog)
 {
@@ -1115,6 +1138,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
 		return &bpf_snprintf_proto;
 	case BPF_FUNC_get_func_ip:
 		return &bpf_get_func_ip_proto_tracing;
+	case BPF_FUNC_get_branch_trace:
+		return &bpf_get_branch_trace_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -1851,6 +1876,8 @@ void __bpf_trace_run(struct bpf_prog *prog, u64 *ar=
gs)
 {
 	cant_sleep();
 	rcu_read_lock();
+	if (prog->call_get_branch)
+		bpf_branch_record_read();
 	(void) bpf_prog_run(prog, args);
 	rcu_read_unlock();
 }
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 2eb0e55ef54d2..60ff066ddab86 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -231,6 +231,18 @@ struct sock * noinline bpf_kfunc_call_test3(struct s=
ock *sk)
 	return sk;
 }
=20
+int noinline bpf_fexit_loop_test1(int n)
+{
+	int i, sum =3D 0;
+
+	/* the primary goal of this test is to test LBR. Create a lot of
+	 * branches in the function, so we can catch it easily.
+	 */
+	for (i =3D 0; i < n; i++)
+		sum +=3D i;
+	return sum;
+}
+
 __diag_pop();
=20
 ALLOW_ERROR_INJECTION(bpf_modify_return_test, ERRNO);
@@ -293,7 +305,8 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 		    bpf_fentry_test5(11, (void *)12, 13, 14, 15) !=3D 65 ||
 		    bpf_fentry_test6(16, (void *)17, 18, 19, (void *)20, 21) !=3D 111 =
||
 		    bpf_fentry_test7((struct bpf_fentry_test_t *)0) !=3D 0 ||
-		    bpf_fentry_test8(&arg) !=3D 0)
+		    bpf_fentry_test8(&arg) !=3D 0 ||
+		    bpf_fexit_loop_test1(101) !=3D 5050)
 			goto out;
 		break;
 	case BPF_MODIFY_RETURN:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index c4f7892edb2b3..442cfef8d6bd5 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4871,6 +4871,13 @@ union bpf_attr {
  * 	Return
  *		Value specified by user at BPF link creation/attachment time
  *		or 0, if it was not specified.
+ *
+ * long bpf_get_branch_trace(void *entries, u32 size, u64 flags)
+ *	Description
+ *		Get branch strace from hardware engines like Intel LBR.
+ * 	Return
+ *		> 0, # of entries.
+ *		**-EOPNOTSUP**, the hardware/kernel does not support this function
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5048,6 +5055,7 @@ union bpf_attr {
 	FN(timer_cancel),		\
 	FN(get_func_ip),		\
 	FN(get_attach_cookie),		\
+	FN(get_branch_trace),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/tools/testing/selftests/bpf/prog_tests/get_branch_trace.c b/=
tools/testing/selftests/bpf/prog_tests/get_branch_trace.c
new file mode 100644
index 0000000000000..509bef6e3edd2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/get_branch_trace.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include <test_progs.h>
+#include "get_branch_trace.skel.h"
+
+static int pfd_array[128] =3D {-1};  /* TODO remove hardcodded 128 */
+
+static int create_perf_events(void)
+{
+	struct perf_event_attr attr =3D {0};
+	int cpu;
+
+	/* create perf event */
+	attr.size =3D sizeof(attr);
+	attr.type =3D PERF_TYPE_HARDWARE;
+	attr.config =3D PERF_COUNT_HW_CPU_CYCLES;
+	attr.freq =3D 1;
+	attr.sample_freq =3D 4000;
+	attr.sample_type =3D PERF_SAMPLE_BRANCH_STACK;
+	attr.branch_sample_type =3D PERF_SAMPLE_BRANCH_KERNEL |
+		PERF_SAMPLE_BRANCH_USER | PERF_SAMPLE_BRANCH_ANY;
+	for (cpu =3D 0; cpu < libbpf_num_possible_cpus(); cpu++) {
+		pfd_array[cpu] =3D syscall(__NR_perf_event_open, &attr,
+					 -1, cpu, -1, PERF_FLAG_FD_CLOEXEC);
+		if (pfd_array[cpu] < 0)
+			break;
+	}
+	return cpu =3D=3D 0;
+}
+
+static void close_perf_events(void)
+{
+	int cpu =3D 0;
+	int fd;
+
+	while (cpu < 128) {
+		fd =3D pfd_array[cpu];
+		if (fd < 0)
+			break;
+		close(fd);
+	}
+}
+
+void test_get_branch_trace(void)
+{
+	struct get_branch_trace *skel;
+	int err, prog_fd;
+	__u32 retval;
+
+	if (create_perf_events()) {
+		test__skip();  /* system doesn't support LBR */
+		goto cleanup;
+	}
+
+	skel =3D get_branch_trace__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "get_branch_trace__open_and_load"))
+		goto cleanup;
+
+	err =3D kallsyms_find("bpf_fexit_loop_test1", &skel->bss->address_low);
+	if (!ASSERT_OK(err, "kallsyms_find"))
+		goto cleanup;
+
+	err =3D kallsyms_find_next("bpf_fexit_loop_test1", &skel->bss->address_=
high);
+	if (!ASSERT_OK(err, "kallsyms_find_next"))
+		goto cleanup;
+
+	err =3D get_branch_trace__attach(skel);
+	if (!ASSERT_OK(err, "get_branch_trace__attach"))
+		goto cleanup;
+
+	prog_fd =3D bpf_program__fd(skel->progs.test1);
+	err =3D bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, 0, &retval, NULL);
+
+	if (!ASSERT_OK(err, "bpf_prog_test_run"))
+		goto cleanup;
+	ASSERT_GT(skel->bss->test1_hits, 5, "find_test1_in_lbr");
+
+cleanup:
+	get_branch_trace__destroy(skel);
+	close_perf_events();
+}
diff --git a/tools/testing/selftests/bpf/progs/get_branch_trace.c b/tools=
/testing/selftests/bpf/progs/get_branch_trace.c
new file mode 100644
index 0000000000000..cacfe25fd92e8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/get_branch_trace.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+__u64 test1_hits =3D 0;
+__u64 address_low =3D 0;
+__u64 address_high =3D 0;
+
+#define MAX_LBR_ENTRIES 32
+
+struct perf_branch_entry entries[MAX_LBR_ENTRIES] =3D {};
+
+static inline bool in_range(__u64 val)
+{
+	return (val >=3D address_low) && (val < address_high);
+}
+
+SEC("fexit/bpf_fexit_loop_test1")
+int BPF_PROG(test1, int n, int ret)
+{
+	long cnt, i;
+
+	cnt =3D bpf_get_branch_trace(entries, sizeof(entries), 0);
+
+	for (i =3D 0; i < MAX_LBR_ENTRIES; i++) {
+		if (i >=3D cnt)
+			break;
+		if (in_range(entries[i].from) && in_range(entries[i].to))
+			test1_hits++;
+	}
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/=
selftests/bpf/trace_helpers.c
index e7a19b04d4eaf..2926a3b626821 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -117,6 +117,36 @@ int kallsyms_find(const char *sym, unsigned long lon=
g *addr)
 	return err;
 }
=20
+/* find the address of the next symbol, this can be used to determine th=
e
+ * end of a function
+ */
+int kallsyms_find_next(const char *sym, unsigned long long *addr)
+{
+	char type, name[500];
+	unsigned long long value;
+	bool found =3D false;
+	int err =3D 0;
+	FILE *f;
+
+	f =3D fopen("/proc/kallsyms", "r");
+	if (!f)
+		return -EINVAL;
+
+	while (fscanf(f, "%llx %c %499s%*[^\n]\n", &value, &type, name) > 0) {
+		if (found) {
+			*addr =3D value;
+			goto out;
+		}
+		if (strcmp(name, sym) =3D=3D 0)
+			found =3D true;
+	}
+	err =3D -ENOENT;
+
+out:
+	fclose(f);
+	return err;
+}
+
 void read_trace_pipe(void)
 {
 	int trace_fd;
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/=
selftests/bpf/trace_helpers.h
index d907b445524d5..bc8ed86105d94 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -16,6 +16,11 @@ long ksym_get_addr(const char *name);
 /* open kallsyms and find addresses on the fly, faster than load + searc=
h. */
 int kallsyms_find(const char *sym, unsigned long long *addr);
=20
+/* find the address of the next symbol, this can be used to determine th=
e
+ * end of a function
+ */
+int kallsyms_find_next(const char *sym, unsigned long long *addr);
+
 void read_trace_pipe(void);
=20
 ssize_t get_uprobe_offset(const void *addr, ssize_t base);
--=20
2.30.2

