Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5340D62D256
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 05:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbiKQE3O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 23:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239223AbiKQE3L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 23:29:11 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E658A45A14
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 20:29:03 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AH0bmcC026848
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 20:29:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=24RI0q+k5bBV+R2W63oSbq6pdrMkrLugwBrc+dsbz7M=;
 b=V/NvnR87ab+Te8dbquLK1D7PChBjY/5EPKcSsL+F5jYROVs5o1uE9Z85F8MhlyO1763D
 451v9veMoKzhE0Pf8AAnNQP8tdU5Iezyl+vLICPwKmRNYCU1OO0VFlUpPHQtWBtmE3Bx
 GXcabsr2KTzO5VuSLq73AcYG1Te0evYAsbo= 
Received: from maileast.thefacebook.com ([163.114.130.3])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kvy58fps8-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 20:29:02 -0800
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 20:29:00 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 8F3BF124860D5; Wed, 16 Nov 2022 20:28:49 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v6 6/7] selftests/bpf: Add tests for bpf_rcu_read_lock()
Date:   Wed, 16 Nov 2022 20:28:49 -0800
Message-ID: <20221117042849.1091228-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221117042818.1086954-1-yhs@fb.com>
References: <20221117042818.1086954-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3aAikYtQc_cpSJGjUOKtD5cglrQrj370
X-Proofpoint-GUID: 3aAikYtQc_cpSJGjUOKtD5cglrQrj370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a few positive/negative tests to test bpf_rcu_read_lock()
and its corresponding verifier support.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/rcu_read_lock.c  | 166 ++++++++
 .../selftests/bpf/progs/rcu_read_lock.c       | 366 ++++++++++++++++++
 2 files changed, 532 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rcu_read_lock.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/rcu_read_lock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c b/too=
ls/testing/selftests/bpf/prog_tests/rcu_read_lock.c
new file mode 100644
index 000000000000..38ce62cde93b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates.*/
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "rcu_read_lock.skel.h"
+
+static void test_local_storage(void)
+{
+	struct rcu_read_lock *skel;
+	int err;
+
+	skel =3D rcu_read_lock__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->bss->target_pid =3D syscall(SYS_gettid);
+
+	bpf_program__set_autoload(skel->progs.cgrp_succ, true);
+	bpf_program__set_autoload(skel->progs.task_succ, true);
+	bpf_program__set_autoload(skel->progs.two_regions, true);
+	bpf_program__set_autoload(skel->progs.non_sleepable_1, true);
+	bpf_program__set_autoload(skel->progs.non_sleepable_2, true);
+	err =3D rcu_read_lock__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto done;
+
+	err =3D rcu_read_lock__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto done;
+
+	syscall(SYS_getpgid);
+
+	ASSERT_EQ(skel->bss->result, 2, "result");
+done:
+	rcu_read_lock__destroy(skel);
+}
+
+static void test_runtime_diff_rcu_tag(void)
+{
+	struct rcu_read_lock *skel;
+	int err;
+
+	skel =3D rcu_read_lock__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.dump_ipv6_route, true);
+	err =3D rcu_read_lock__load(skel);
+	ASSERT_OK(err, "skel_load");
+	rcu_read_lock__destroy(skel);
+}
+
+static void test_negative_region(void)
+{
+#define NUM_REGION_FAILED_PROGS		6
+	struct rcu_read_lock *skel;
+	struct bpf_program *prog;
+	int i, err;
+
+	for (i =3D 0; i < NUM_REGION_FAILED_PROGS; i++) {
+		skel =3D rcu_read_lock__open();
+		if (!ASSERT_OK_PTR(skel, "skel_open"))
+			return;
+
+		switch (i) {
+		case 0:
+			prog =3D skel->progs.miss_lock;
+			break;
+		case 1:
+			prog =3D skel->progs.miss_unlock;
+			break;
+		case 2:
+			prog =3D skel->progs.non_sleepable_rcu_mismatch;
+			break;
+		case 3:
+			prog =3D skel->progs.inproper_sleepable_helper;
+			break;
+		case 4:
+			prog =3D skel->progs.inproper_sleepable_kfunc;
+			break;
+		default:
+			prog =3D skel->progs.nested_rcu_region;
+			break;
+		}
+
+		bpf_program__set_autoload(prog, true);
+		err =3D rcu_read_lock__load(skel);
+		if (!ASSERT_ERR(err, "skel_load")) {
+			rcu_read_lock__destroy(skel);
+			return;
+		}
+	}
+}
+
+static void test_negative_rcuptr_misuse(void)
+{
+#define NUM_RCUPTR_FAILED_PROGS		4
+	struct rcu_read_lock *skel;
+	struct bpf_program *prog;
+	struct btf *vmlinux_btf;
+	int i, err, type_id;
+
+	vmlinux_btf =3D btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(vmlinux_btf, "could not load vmlinux BTF"))
+		return;
+
+	/* skip the test if btf_type_tag("rcu") is not present in vmlinux */
+	type_id =3D btf__find_by_name_kind(vmlinux_btf, "rcu", BTF_KIND_TYPE_TA=
G);
+	if (type_id < 0) {
+		test__skip();
+		return;
+	}
+
+	for (i =3D 0; i < NUM_RCUPTR_FAILED_PROGS; i++) {
+		skel =3D rcu_read_lock__open();
+		if (!ASSERT_OK_PTR(skel, "skel_open"))
+			return;
+
+		switch (i) {
+		case 0:
+			prog =3D skel->progs.cgrp_incorrect_rcu_region;
+			break;
+		case 1:
+			prog =3D skel->progs.task_incorrect_rcu_region1;
+			break;
+		case 2:
+			prog =3D skel->progs.task_incorrect_rcu_region2;
+			break;
+		default:
+			prog =3D skel->progs.cross_rcu_region;
+			break;
+		}
+
+		bpf_program__set_autoload(prog, true);
+		err =3D rcu_read_lock__load(skel);
+		if (!ASSERT_ERR(err, "skel_load")) {
+			rcu_read_lock__destroy(skel);
+			return;
+		}
+	}
+}
+
+void test_rcu_read_lock(void)
+{
+	int cgroup_fd;
+
+	cgroup_fd =3D test__join_cgroup("/rcu_read_lock");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup /rcu_read_lock"))
+		return;
+
+	if (test__start_subtest("local_storage"))
+		test_local_storage();
+	if (test__start_subtest("runtime_diff_rcu_tag"))
+		test_runtime_diff_rcu_tag();
+	if (test__start_subtest("negative_tests_region"))
+		test_negative_region();
+	if (test__start_subtest("negative_tests_rcuptr_misuse"))
+		test_negative_rcuptr_misuse();
+
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/te=
sting/selftests/bpf/progs/rcu_read_lock.c
new file mode 100644
index 000000000000..32f9af19ea42
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
@@ -0,0 +1,366 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_tracing_net.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, long);
+} map_a SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, long);
+} map_b SEC(".maps");
+
+__u32 user_data, key_serial, target_pid =3D 0;
+__u64 flags, result =3D 0;
+
+struct bpf_key *bpf_lookup_user_key(__u32 serial, __u64 flags) __ksym;
+void bpf_key_put(struct bpf_key *key) __ksym;
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int cgrp_succ(void *ctx)
+{
+	struct task_struct *task;
+	struct css_set *cgroups;
+	struct cgroup *dfl_cgrp;
+	long init_val =3D 2;
+	long *ptr;
+
+	task =3D bpf_get_current_task_btf();
+	if (task->pid !=3D target_pid)
+		return 0;
+
+	/* For this specific case, the below bpf_rcu_read_lock region
+	 * protects rcu pointer memory access (cgroups) properly.
+	 * But to access dfl_cgrp memory, a reference to cgroups->dfl_cgrp
+	 * needs to be held so dfl_cgrp can keep valid outside the
+	 * bpf_rcu_read_lock region.
+	 *
+	 * The current approach is to treat walked pointers as 'trusted' so
+	 * we do not enclose all walked pointer/mem access in the
+	 * bpf_rcu_read_lock region. For this particular case, the
+	 * bpf_rcu_read_unlock can be placed right before the first
+	 * 'return 0; or immediately after the second bpf_cgrp_storage_get()
+	 * to protect dfl_cgrp as well.
+	 */
+	bpf_rcu_read_lock();
+	cgroups =3D task->cgroups;
+	dfl_cgrp =3D cgroups->dfl_cgrp;
+	bpf_rcu_read_unlock();
+	ptr =3D bpf_cgrp_storage_get(&map_a, dfl_cgrp, &init_val,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!ptr)
+		return 0;
+	ptr =3D bpf_cgrp_storage_get(&map_a, dfl_cgrp, 0, 0);
+	if (!ptr)
+		return 0;
+	result =3D *ptr;
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
+int task_succ(void *ctx)
+{
+	struct task_struct *task, *real_parent;
+
+	task =3D bpf_get_current_task_btf();
+	if (task->pid !=3D target_pid)
+		return 0;
+
+	/* region including helper using rcu ptr */
+	bpf_rcu_read_lock();
+	real_parent =3D task->real_parent;
+	(void)bpf_task_storage_get(&map_b, real_parent, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
+int two_regions(void *ctx)
+{
+	struct task_struct *task, *real_parent;
+
+	/* two regions */
+	task =3D bpf_get_current_task_btf();
+	bpf_rcu_read_lock();
+	bpf_rcu_read_unlock();
+	bpf_rcu_read_lock();
+	real_parent =3D task->real_parent;
+	(void)bpf_task_storage_get(&map_b, real_parent, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?fentry/" SYS_PREFIX "sys_getpgid")
+int non_sleepable_1(void *ctx)
+{
+	struct task_struct *task, *real_parent;
+
+	task =3D bpf_get_current_task_btf();
+
+	bpf_rcu_read_lock();
+	real_parent =3D task->real_parent;
+	(void)bpf_task_storage_get(&map_b, real_parent, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?fentry/" SYS_PREFIX "sys_getpgid")
+int non_sleepable_2(void *ctx)
+{
+	struct task_struct *task, *real_parent;
+
+	bpf_rcu_read_lock();
+	task =3D bpf_get_current_task_btf();
+	bpf_rcu_read_unlock();
+
+	bpf_rcu_read_lock();
+	real_parent =3D task->real_parent;
+	(void)bpf_task_storage_get(&map_b, real_parent, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?iter.s/ipv6_route")
+int dump_ipv6_route(struct bpf_iter__ipv6_route *ctx)
+{
+	struct seq_file *seq =3D ctx->meta->seq;
+	struct fib6_info *rt =3D ctx->rt;
+	const struct net_device *dev;
+	struct fib6_nh *fib6_nh;
+	unsigned int flags;
+	struct nexthop *nh;
+
+	if (rt =3D=3D (void *)0)
+		return 0;
+
+	/* fib6_nh is not a rcu ptr */
+	fib6_nh =3D &rt->fib6_nh[0];
+	flags =3D rt->fib6_flags;
+
+	nh =3D rt->nh;
+	bpf_rcu_read_lock();
+	if (rt->nh)
+		/* fib6_nh is a rcu ptr */
+		fib6_nh =3D &nh->nh_info->fib6_nh;
+
+	/* fib6_nh could be a rcu or non-rcu ptr */
+	if (fib6_nh->fib_nh_gw_family) {
+		flags |=3D RTF_GATEWAY;
+		BPF_SEQ_PRINTF(seq, "%pi6 ", &fib6_nh->fib_nh_gw6);
+	} else {
+		BPF_SEQ_PRINTF(seq, "00000000000000000000000000000000 ");
+	}
+
+	dev =3D fib6_nh->fib_nh_dev;
+	bpf_rcu_read_unlock();
+	if (dev)
+		BPF_SEQ_PRINTF(seq, "%08x %08x %08x %08x %8s\n", rt->fib6_metric,
+			       rt->fib6_ref.refs.counter, 0, flags, dev->name);
+	else
+		BPF_SEQ_PRINTF(seq, "%08x %08x %08x %08x\n", rt->fib6_metric,
+			       rt->fib6_ref.refs.counter, 0, flags);
+
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int miss_lock(void *ctx)
+{
+	struct task_struct *task;
+	struct css_set *cgroups;
+	struct cgroup *dfl_cgrp;
+
+	/* missing bpf_rcu_read_lock() */
+	task =3D bpf_get_current_task_btf();
+	bpf_rcu_read_lock();
+	cgroups =3D task->cgroups;
+	dfl_cgrp =3D cgroups->dfl_cgrp;
+	bpf_rcu_read_unlock();
+	(void)bpf_cgrp_storage_get(&map_a, dfl_cgrp, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int miss_unlock(void *ctx)
+{
+	struct task_struct *task;
+	struct css_set *cgroups;
+	struct cgroup *dfl_cgrp;
+
+	/* missing bpf_rcu_read_unlock() */
+	task =3D bpf_get_current_task_btf();
+	bpf_rcu_read_lock();
+	cgroups =3D task->cgroups;
+	dfl_cgrp =3D cgroups->dfl_cgrp;
+	(void)bpf_cgrp_storage_get(&map_a, dfl_cgrp, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	return 0;
+}
+
+SEC("?fentry/" SYS_PREFIX "sys_getpgid")
+int non_sleepable_rcu_mismatch(void *ctx)
+{
+	struct task_struct *task, *real_parent;
+
+	task =3D bpf_get_current_task_btf();
+
+	/* non-sleepable: missing bpf_rcu_read_unlock() in one path */
+	bpf_rcu_read_lock();
+	real_parent =3D task->real_parent;
+	(void)bpf_task_storage_get(&map_b, real_parent, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (real_parent)
+		bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int inproper_sleepable_helper(void *ctx)
+{
+	struct task_struct *task, *real_parent;
+	struct pt_regs *regs;
+	__u32 value =3D 0;
+	void *ptr;
+
+	task =3D bpf_get_current_task_btf();
+
+	/* sleepable helper in rcu read lock region */
+	bpf_rcu_read_lock();
+	real_parent =3D task->real_parent;
+	regs =3D (struct pt_regs *)bpf_task_pt_regs(real_parent);
+	if (!regs) {
+		bpf_rcu_read_unlock();
+		return 0;
+	}
+
+	ptr =3D (void *)PT_REGS_IP(regs);
+	(void)bpf_copy_from_user_task(&value, sizeof(uint32_t), ptr, task, 0);
+	user_data =3D value;
+	(void)bpf_task_storage_get(&map_b, real_parent, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?lsm.s/bpf")
+int BPF_PROG(inproper_sleepable_kfunc, int cmd, union bpf_attr *attr, un=
signed int size)
+{
+	struct bpf_key *bkey;
+
+	/* sleepable kfunc in rcu read lock region */
+	bpf_rcu_read_lock();
+	bkey =3D bpf_lookup_user_key(key_serial, flags);
+	bpf_rcu_read_unlock();
+	if (!bkey)
+		return -1;
+	bpf_key_put(bkey);
+
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
+int nested_rcu_region(void *ctx)
+{
+	struct task_struct *task, *real_parent;
+
+	/* nested rcu read lock regions */
+	task =3D bpf_get_current_task_btf();
+	bpf_rcu_read_lock();
+	bpf_rcu_read_lock();
+	real_parent =3D task->real_parent;
+	(void)bpf_task_storage_get(&map_b, real_parent, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	bpf_rcu_read_unlock();
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int cgrp_incorrect_rcu_region(void *ctx)
+{
+	struct task_struct *task;
+	struct css_set *cgroups;
+	struct cgroup *dfl_cgrp;
+
+	/* load with rcu_ptr outside the rcu read lock region */
+	bpf_rcu_read_lock();
+	task =3D bpf_get_current_task_btf();
+	cgroups =3D task->cgroups;
+	bpf_rcu_read_unlock();
+	dfl_cgrp =3D cgroups->dfl_cgrp;
+	(void)bpf_cgrp_storage_get(&map_a, dfl_cgrp, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int task_incorrect_rcu_region1(void *ctx)
+{
+	struct task_struct *task, *real_parent;
+
+	task =3D bpf_get_current_task_btf();
+
+	/* helper use of rcu ptr outside the rcu read lock region */
+	bpf_rcu_read_lock();
+	real_parent =3D task->real_parent;
+	bpf_rcu_read_unlock();
+	(void)bpf_task_storage_get(&map_b, real_parent, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int task_incorrect_rcu_region2(void *ctx)
+{
+	struct task_struct *task, *real_parent;
+
+	task =3D bpf_get_current_task_btf();
+
+	/* missing bpf_rcu_read_unlock() in one path */
+	bpf_rcu_read_lock();
+	real_parent =3D task->real_parent;
+	(void)bpf_task_storage_get(&map_b, real_parent, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (real_parent)
+		bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
+int cross_rcu_region(void *ctx)
+{
+	struct task_struct *task, *real_parent;
+
+	/* rcu ptr define/use in different regions */
+	task =3D bpf_get_current_task_btf();
+	bpf_rcu_read_lock();
+	real_parent =3D task->real_parent;
+	bpf_rcu_read_unlock();
+	bpf_rcu_read_lock();
+	(void)bpf_task_storage_get(&map_b, real_parent, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
--=20
2.30.2

