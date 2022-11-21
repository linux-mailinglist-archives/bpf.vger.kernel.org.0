Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AB0632A4D
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 18:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiKURF7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 12:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiKURFp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 12:05:45 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACD8CB949
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 09:05:41 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALCSEA2015926
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 09:05:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=L1Ha21rW6HuIxnnqQcXIHkz8fES1C09ioL+HsinoyV4=;
 b=eP1aZB20eKXRBqfd7ojMzueWc3sHCX9BOd9pG+E/D6U/7f0l2hIZe5xR0ukAwq9ujxry
 WoM7MnSaP42Ys6TLJh3Icaf52SHPt14V0C+l4RN/GG+13UaQHAdycdlqFbvcvPFPI1Rb
 K5px0XUeqvgD/oNXOweNCeG/lSAll9uv+ao= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kxw4xx8e7-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 09:05:41 -0800
Received: from twshared13940.35.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 09:05:40 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 3DE981282A606; Mon, 21 Nov 2022 09:05:36 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v7 4/4] selftests/bpf: Add tests for bpf_rcu_read_lock()
Date:   Mon, 21 Nov 2022 09:05:36 -0800
Message-ID: <20221121170536.1198240-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221121170515.1193967-1-yhs@fb.com>
References: <20221121170515.1193967-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: krT1dc4jbeFQ0rCgEwWYRKpw6x3XCjIZ
X-Proofpoint-ORIG-GUID: krT1dc4jbeFQ0rCgEwWYRKpw6x3XCjIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_14,2022-11-18_01,2022-06-22_01
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
and its corresponding verifier support. The new test will fail
on s390x and aarch64, so an entry is added to each of their
respective deny lists.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/rcu_read_lock.c  | 153 +++++++++
 .../selftests/bpf/progs/rcu_read_lock.c       | 325 ++++++++++++++++++
 4 files changed, 480 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rcu_read_lock.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/rcu_read_lock.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing=
/selftests/bpf/DENYLIST.aarch64
index affc5aebbf0f..8e77515d56f6 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -45,6 +45,7 @@ modify_return                                    # modi=
fy_return__attach failed
 module_attach                                    # skel_attach skeleton =
attach failed: -524
 mptcp/base                                       # run_test mptcp unexpe=
cted error: -524 (errno 524)
 netcnt                                           # packets unexpected pa=
ckets: actual 10001 !=3D expected 10000
+rcu_read_lock                                    # failed to attach: ERR=
OR: strerror_r(-524)=3D22
 recursion                                        # skel_attach unexpecte=
d error: -524 (errno 524)
 ringbuf                                          # skel_attach skeleton =
attachment failed: -1
 setget_sockopt                                   # attach_cgroup unexpec=
ted error: -524
diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/s=
elftests/bpf/DENYLIST.s390x
index 12cf2159975e..77aabc4dc64c 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -42,6 +42,7 @@ module_attach                            # skel_attach =
skeleton attach failed: -
 mptcp
 netcnt                                   # failed to load BPF skeleton '=
netcnt_prog': -7                               (?)
 probe_user                               # check_kprobe_res wrong kprobe=
 res from probe read                           (?)
+rcu_read_lock                            # failed to find kernel BTF typ=
e ID of '__x64_sys_getpgid': -3                (?)
 recursion                                # skel_attach unexpected error:=
 -524                                          (trampoline)
 ringbuf                                  # skel_load skeleton load faile=
d                                              (?)
 select_reuseport                         # intermittently fails on new s=
390x setup
diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c b/too=
ls/testing/selftests/bpf/prog_tests/rcu_read_lock.c
new file mode 100644
index 000000000000..58d5fe3da223
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
@@ -0,0 +1,153 @@
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
+#include "cgroup_helpers.h"
+
+static unsigned long long cgroup_id;
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
+	bpf_program__set_autoload(skel->progs.get_cgroup_id, true);
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
+	ASSERT_EQ(skel->bss->task_storage_val, 2, "task_storage_val");
+	ASSERT_EQ(skel->bss->cgroup_id, cgroup_id, "cgroup_id");
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
+static const char * const inproper_region_tests[] =3D {
+	"miss_lock",
+	"miss_unlock",
+	"non_sleepable_rcu_mismatch",
+	"inproper_sleepable_helper",
+	"inproper_sleepable_kfunc",
+	"nested_rcu_region",
+};
+
+static void test_inproper_region(void)
+{
+	struct rcu_read_lock *skel;
+	struct bpf_program *prog;
+	int i, err;
+
+	for (i =3D 0; i < ARRAY_SIZE(inproper_region_tests); i++) {
+		skel =3D rcu_read_lock__open();
+		if (!ASSERT_OK_PTR(skel, "skel_open"))
+			return;
+
+		prog =3D bpf_object__find_program_by_name(skel->obj, inproper_region_t=
ests[i]);
+		if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+			goto out;
+		bpf_program__set_autoload(prog, true);
+		err =3D rcu_read_lock__load(skel);
+		ASSERT_ERR(err, "skel_load");
+out:
+		rcu_read_lock__destroy(skel);
+	}
+}
+
+static const char * const rcuptr_misuse_tests[] =3D {
+	"task_untrusted_ptr",
+	"task_incorrect_rcu_region1",
+	"task_incorrect_rcu_region2",
+	"cross_rcu_region",
+};
+
+static void test_rcuptr_misuse(void)
+{
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
+	for (i =3D 0; i < ARRAY_SIZE(rcuptr_misuse_tests); i++) {
+		skel =3D rcu_read_lock__open();
+		if (!ASSERT_OK_PTR(skel, "skel_open"))
+			return;
+
+		prog =3D bpf_object__find_program_by_name(skel->obj, rcuptr_misuse_tes=
ts[i]);
+		if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+			goto out;
+		bpf_program__set_autoload(prog, true);
+		err =3D rcu_read_lock__load(skel);
+		ASSERT_ERR(err, "skel_load");
+out:
+		rcu_read_lock__destroy(skel);
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
+	cgroup_id =3D get_cgroup_id("/rcu_read_lock");
+	if (test__start_subtest("local_storage"))
+		test_local_storage();
+	if (test__start_subtest("runtime_diff_rcu_tag"))
+		test_runtime_diff_rcu_tag();
+	if (test__start_subtest("negative_tests_inproper_region"))
+		test_inproper_region();
+	if (test__start_subtest("negative_tests_rcuptr_misuse"))
+		test_rcuptr_misuse();
+
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/te=
sting/selftests/bpf/progs/rcu_read_lock.c
new file mode 100644
index 000000000000..add30d1becb1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
@@ -0,0 +1,325 @@
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
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, long);
+} map_a SEC(".maps");
+
+__u32 user_data, key_serial, target_pid =3D 0;
+__u64 flags, task_storage_val, cgroup_id;
+
+struct bpf_key *bpf_lookup_user_key(__u32 serial, __u64 flags) __ksym;
+void bpf_key_put(struct bpf_key *key) __ksym;
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int get_cgroup_id(void *ctx)
+{
+	struct task_struct *task;
+
+	task =3D bpf_get_current_task_btf();
+	if (task->pid !=3D target_pid)
+		return 0;
+
+	/* simulate bpf_get_current_cgroup_id() helper */
+	bpf_rcu_read_lock();
+	cgroup_id =3D task->cgroups->dfl_cgrp->kn->id;
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int task_succ(void *ctx)
+{
+	struct task_struct *task, *real_parent;
+	long init_val =3D 2;
+	long *ptr;
+
+	task =3D bpf_get_current_task_btf();
+	if (task->pid !=3D target_pid)
+		return 0;
+
+	bpf_rcu_read_lock();
+	/* region including helper using rcu ptr real_parent */
+	real_parent =3D task->real_parent;
+	ptr =3D bpf_task_storage_get(&map_a, real_parent, &init_val,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!ptr)
+		goto out;
+	ptr =3D bpf_task_storage_get(&map_a, real_parent, 0, 0);
+	if (!ptr)
+		goto out;
+	task_storage_val =3D *ptr;
+out:
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
+	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
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
+	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
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
+	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
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
+	(void)bpf_task_storage_get(&map_a, task, 0, 0);
+	bpf_rcu_read_unlock();
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
+	(void)bpf_task_storage_get(&map_a, task, 0, 0);
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
+	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
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
+	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
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
+	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
+	bpf_rcu_read_unlock();
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int task_untrusted_ptr(void *ctx)
+{
+	struct task_struct *task, *last_wakee;
+
+	task =3D bpf_get_current_task_btf();
+
+	bpf_rcu_read_lock();
+	/* the pointer last_wakee marked as untrusted */
+	last_wakee =3D task->real_parent->last_wakee;
+	(void)bpf_task_storage_get(&map_a, last_wakee, 0, 0);
+	bpf_rcu_read_unlock();
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
+	/* helper use of rcu ptr outside the rcu read lock region */
+	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
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
+	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
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
+	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
--=20
2.30.2

