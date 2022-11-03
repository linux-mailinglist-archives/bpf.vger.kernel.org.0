Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BA561778B
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 08:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiKCHVl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 03:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiKCHVh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 03:21:37 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAFCB24
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 00:21:36 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2NVtwd000634
        for <bpf@vger.kernel.org>; Thu, 3 Nov 2022 00:21:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=mgwyfgqUxIlVpYfoLEW7VnZsTqyWJC4e45kvgOpD8yw=;
 b=HvWy3Qfqk2tArI2jY1HWs/HM/qkQbWYyiZ/48qfucL1ZT77eFe5W5ZO5Nlbt1F1YG5/N
 n5VU1by/p8LAQt2xs51mZvJ8wYB/L54HJOuauLBCGsw9qGx0Frs8rm+5qM+Z48voRejS
 x4xAiQG39s84XGX4MPBI88X8au9Pw85Kq34= 
Received: from maileast.thefacebook.com ([163.114.130.8])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kkmtutha8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 00:21:35 -0700
Received: from twshared9088.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 00:21:34 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 6B0401192D10B; Thu,  3 Nov 2022 00:21:29 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 5/5] selftests/bpf: Add tests for bpf_rcu_read_lock()
Date:   Thu, 3 Nov 2022 00:21:29 -0700
Message-ID: <20221103072129.2325722-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221103072102.2320490-1-yhs@fb.com>
References: <20221103072102.2320490-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0z7KlH2eC_ECHlTjHA3R2dtAT8BbQwrF
X-Proofpoint-GUID: 0z7KlH2eC_ECHlTjHA3R2dtAT8BbQwrF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

  ./test_progs -t rcu_read_lock
  ...
  #145/1   rcu_read_lock/local_storage:OK
  #145/2   rcu_read_lock/runtime_diff_rcu_tag:OK
  #145/3   rcu_read_lock/negative_tests:OK
  #145     rcu_read_lock:OK
  Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/rcu_read_lock.c  | 101 ++++++++
 .../selftests/bpf/progs/rcu_read_lock.c       | 241 ++++++++++++++++++
 2 files changed, 342 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rcu_read_lock.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/rcu_read_lock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c b/too=
ls/testing/selftests/bpf/prog_tests/rcu_read_lock.c
new file mode 100644
index 000000000000..46c02bdb1360
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates.*/
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <test_progs.h>
+#include "rcu_read_lock.skel.h"
+
+static void test_local_storage(void)
+{
+	struct rcu_read_lock *skel;
+	int err;
+
+        skel =3D rcu_read_lock__open();
+        if (!ASSERT_OK_PTR(skel, "skel_open"))
+                return;
+
+	skel->bss->target_pid =3D syscall(SYS_gettid);
+
+	bpf_program__set_autoload(skel->progs.cgrp_succ, true);
+	bpf_program__set_autoload(skel->progs.task_succ, true);
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
+	return;
+}
+
+static void test_runtime_diff_rcu_tag(void)
+{
+	struct rcu_read_lock *skel;
+	int err;
+
+        skel =3D rcu_read_lock__open();
+        if (!ASSERT_OK_PTR(skel, "skel_open"))
+                return;
+
+	bpf_program__set_autoload(skel->progs.dump_ipv6_route, true);
+	err =3D rcu_read_lock__load(skel);
+	ASSERT_OK(err, "skel_load");
+	rcu_read_lock__destroy(skel);
+	return;
+}
+
+static void test_negative(void)
+{
+#define NUM_FAILED_PROGS	7
+	struct bpf_program *failed_progs[NUM_FAILED_PROGS];
+	struct rcu_read_lock *skel;
+	int i, err;
+
+        skel =3D rcu_read_lock__open();
+        if (!ASSERT_OK_PTR(skel, "skel_open"))
+                return;
+
+	failed_progs[0] =3D skel->progs.miss_lock;
+	failed_progs[1] =3D skel->progs.miss_unlock;
+	failed_progs[2] =3D skel->progs.cgrp_incorrect_rcu_region;
+	failed_progs[3] =3D skel->progs.task_incorrect_rcu_region1;
+	failed_progs[4] =3D skel->progs.task_incorrect_rcu_region2;
+	failed_progs[5] =3D skel->progs.inproper_sleepable_helper;
+	failed_progs[6] =3D skel->progs.inproper_sleepable_kfunc;
+	for (i =3D 0; i < NUM_FAILED_PROGS; i++) {
+		bpf_program__set_autoload(failed_progs[i], true);
+		err =3D rcu_read_lock__load(skel);
+		if (!ASSERT_ERR(err, "skel_load")) {
+			rcu_read_lock__destroy(skel);
+			return;
+		}
+		bpf_program__set_autoload(failed_progs[i], false);
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
+	if (test__start_subtest("negative_tests"))
+		test_negative();
+
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/te=
sting/selftests/bpf/progs/rcu_read_lock.c
new file mode 100644
index 000000000000..d7cf0a1bbac9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
@@ -0,0 +1,241 @@
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
+extern struct bpf_key *bpf_lookup_user_key(__u32 serial, __u64 flags) __=
ksym;
+extern void bpf_key_put(struct bpf_key *key) __ksym;
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
+	fib6_nh =3D &rt->fib6_nh[0];
+	flags =3D rt->fib6_flags;
+
+	nh =3D rt->nh;
+	bpf_rcu_read_lock();
+	if (rt->nh)
+		fib6_nh =3D &nh->nh_info->fib6_nh;
+
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
+	task =3D bpf_get_current_task_btf();
+	bpf_rcu_read_lock();
+	cgroups =3D task->cgroups;
+	bpf_rcu_read_unlock();
+	dfl_cgrp =3D cgroups->dfl_cgrp;
+	bpf_rcu_read_unlock();
+	(void)bpf_cgrp_storage_get(&map_a, dfl_cgrp, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
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
+	bpf_rcu_read_lock();
+	task =3D bpf_get_current_task_btf();
+	bpf_rcu_read_lock();
+	cgroups =3D task->cgroups;
+	bpf_rcu_read_unlock();
+	dfl_cgrp =3D cgroups->dfl_cgrp;
+	(void)bpf_cgrp_storage_get(&map_a, dfl_cgrp, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
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
+	bpf_rcu_read_lock();
+	bkey =3D bpf_lookup_user_key(key_serial, flags);
+	bpf_rcu_read_unlock();
+        if (!bkey)
+                return -1;
+        bpf_key_put(bkey);
+
+        return 0;
+}
--=20
2.30.2

