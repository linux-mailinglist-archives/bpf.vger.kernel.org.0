Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F8860D663
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 23:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbiJYVyj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 17:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiJYVyi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 17:54:38 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F390E32D9D
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 14:54:36 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PJjfFS003268
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 14:54:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=U9muyVMgPIT1wbn7rT/Aj4+arJ6PX8P9pDoZNZ/iutc=;
 b=ZTaMeJBrtmb6AUI6kqj06E6fqv7eC46s8m6xar1wzS5RuN/mUZjZpvOkD6PIzpxQaYDH
 gLlyeZAzT5CWDJWw/979bGmxIayoznfMAP/qNEIh4NVUUSgkrw5JYEGywyq9pAwJTvSF
 koexvZPH0EABLSyenJnFmbNz+wP7xDbaPbM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ke5sn38aw-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 14:54:36 -0700
Received: from twshared3704.02.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 14:54:35 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 5FEFC112E9E1D; Tue, 25 Oct 2022 14:54:24 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v5 6/7] selftests/bpf: Add selftests for new cgroup local storage
Date:   Tue, 25 Oct 2022 14:54:24 -0700
Message-ID: <20221025215424.4187612-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221025215352.4184578-1-yhs@fb.com>
References: <20221025215352.4184578-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0yHBWlx5j3qdlngpeXcGgWUVUgtwSfV3
X-Proofpoint-GUID: 0yHBWlx5j3qdlngpeXcGgWUVUgtwSfV3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_13,2022-10-25_01,2022-06-22_01
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add four tests for new cgroup local storage, (1) testing bpf program help=
ers
and user space map APIs, (2) testing recursive fentry triggering won't de=
adlock,
(3) testing progs attached to cgroups, and (4) a negative test if the
bpf_cgrp_storage_get() helper key is not a cgroup btf id.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../bpf/prog_tests/cgrp_local_storage.c       | 171 ++++++++++++++++++
 .../bpf/progs/cgrp_ls_attach_cgroup.c         | 101 +++++++++++
 .../selftests/bpf/progs/cgrp_ls_negative.c    |  26 +++
 .../selftests/bpf/progs/cgrp_ls_recursion.c   |  70 +++++++
 .../selftests/bpf/progs/cgrp_ls_tp_btf.c      |  88 +++++++++
 5 files changed, 456 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgrp_local_sto=
rage.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgrp_ls_attach_cgro=
up.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgrp_ls_negative.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgrp_ls_tp_btf.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c =
b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
new file mode 100644
index 000000000000..1c30412ba132
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates.*/
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <test_progs.h>
+#include "cgrp_ls_tp_btf.skel.h"
+#include "cgrp_ls_recursion.skel.h"
+#include "cgrp_ls_attach_cgroup.skel.h"
+#include "cgrp_ls_negative.skel.h"
+#include "network_helpers.h"
+
+struct socket_cookie {
+	__u64 cookie_key;
+	__u32 cookie_value;
+};
+
+static void test_tp_btf(int cgroup_fd)
+{
+	struct cgrp_ls_tp_btf *skel;
+	long val1 =3D 1, val2 =3D 0;
+	int err;
+
+	skel =3D cgrp_ls_tp_btf__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	/* populate a value in map_b */
+	err =3D bpf_map_update_elem(bpf_map__fd(skel->maps.map_b), &cgroup_fd, =
&val1, BPF_ANY);
+	if (!ASSERT_OK(err, "map_update_elem"))
+		goto out;
+
+	/* check value */
+	err =3D bpf_map_lookup_elem(bpf_map__fd(skel->maps.map_b), &cgroup_fd, =
&val2);
+	if (!ASSERT_OK(err, "map_lookup_elem"))
+		goto out;
+	if (!ASSERT_EQ(val2, 1, "map_lookup_elem, invalid val"))
+		goto out;
+
+	/* delete value */
+	err =3D bpf_map_delete_elem(bpf_map__fd(skel->maps.map_b), &cgroup_fd);
+	if (!ASSERT_OK(err, "map_delete_elem"))
+		goto out;
+
+	skel->bss->target_pid =3D syscall(SYS_gettid);
+
+	err =3D cgrp_ls_tp_btf__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto out;
+
+	syscall(SYS_gettid);
+	syscall(SYS_gettid);
+
+	skel->bss->target_pid =3D 0;
+
+	/* 3x syscalls: 1x attach and 2x gettid */
+	ASSERT_EQ(skel->bss->enter_cnt, 3, "enter_cnt");
+	ASSERT_EQ(skel->bss->exit_cnt, 3, "exit_cnt");
+	ASSERT_EQ(skel->bss->mismatch_cnt, 0, "mismatch_cnt");
+out:
+	cgrp_ls_tp_btf__destroy(skel);
+}
+
+static void test_attach_cgroup(int cgroup_fd)
+{
+	int server_fd =3D 0, client_fd =3D 0, err =3D 0;
+	socklen_t addr_len =3D sizeof(struct sockaddr_in6);
+	struct cgrp_ls_attach_cgroup *skel;
+	__u32 cookie_expected_value;
+	struct sockaddr_in6 addr;
+	struct socket_cookie val;
+
+	skel =3D cgrp_ls_attach_cgroup__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->links.set_cookie =3D bpf_program__attach_cgroup(
+		skel->progs.set_cookie, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.set_cookie, "prog_attach"))
+		goto out;
+
+	skel->links.update_cookie_sockops =3D bpf_program__attach_cgroup(
+		skel->progs.update_cookie_sockops, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.update_cookie_sockops, "prog_attach"))
+		goto out;
+
+	skel->links.update_cookie_tracing =3D bpf_program__attach(
+		skel->progs.update_cookie_tracing);
+	if (!ASSERT_OK_PTR(skel->links.update_cookie_tracing, "prog_attach"))
+		goto out;
+
+	server_fd =3D start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto out;
+
+	client_fd =3D connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect_to_fd"))
+		goto close_server_fd;
+
+	err =3D bpf_map_lookup_elem(bpf_map__fd(skel->maps.socket_cookies),
+				  &cgroup_fd, &val);
+	if (!ASSERT_OK(err, "map_lookup(socket_cookies)"))
+		goto close_client_fd;
+
+	err =3D getsockname(client_fd, (struct sockaddr *)&addr, &addr_len);
+	if (!ASSERT_OK(err, "getsockname"))
+		goto close_client_fd;
+
+	cookie_expected_value =3D (ntohs(addr.sin6_port) << 8) | 0xFF;
+	ASSERT_EQ(val.cookie_value, cookie_expected_value, "cookie_value");
+
+close_client_fd:
+	close(client_fd);
+close_server_fd:
+	close(server_fd);
+out:
+	cgrp_ls_attach_cgroup__destroy(skel);
+}
+
+static void test_recursion(int cgroup_fd)
+{
+	struct cgrp_ls_recursion *skel;
+	int err;
+
+	skel =3D cgrp_ls_recursion__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	err =3D cgrp_ls_recursion__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto out;
+
+	/* trigger sys_enter, make sure it does not cause deadlock */
+	syscall(SYS_gettid);
+
+out:
+	cgrp_ls_recursion__destroy(skel);
+}
+
+static void test_negative(void)
+{
+	struct cgrp_ls_negative *skel;
+
+	skel =3D cgrp_ls_negative__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "skel_open_and_load")) {
+		cgrp_ls_negative__destroy(skel);
+		return;
+	}
+}
+
+void test_cgrp_local_storage(void)
+{
+	int cgroup_fd;
+
+	cgroup_fd =3D test__join_cgroup("/cgrp_local_storage");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup /cgrp_local_storage"))
+		return;
+
+	if (test__start_subtest("tp_btf"))
+		test_tp_btf(cgroup_fd);
+	if (test__start_subtest("attach_cgroup"))
+		test_attach_cgroup(cgroup_fd);
+	if (test__start_subtest("recursion"))
+		test_recursion(cgroup_fd);
+	if (test__start_subtest("negative"))
+		test_negative();
+
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_attach_cgroup.c b/=
tools/testing/selftests/bpf/progs/cgrp_ls_attach_cgroup.c
new file mode 100644
index 000000000000..6652d18465b2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgrp_ls_attach_cgroup.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_tracing_net.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+struct socket_cookie {
+	__u64 cookie_key;
+	__u64 cookie_value;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct socket_cookie);
+} socket_cookies SEC(".maps");
+
+SEC("cgroup/connect6")
+int set_cookie(struct bpf_sock_addr *ctx)
+{
+	struct socket_cookie *p;
+	struct tcp_sock *tcp_sk;
+	struct bpf_sock *sk;
+
+	if (ctx->family !=3D AF_INET6 || ctx->user_family !=3D AF_INET6)
+		return 1;
+
+	sk =3D ctx->sk;
+	if (!sk)
+		return 1;
+
+	tcp_sk =3D bpf_skc_to_tcp_sock(sk);
+	if (!tcp_sk)
+		return 1;
+
+	p =3D bpf_cgrp_storage_get(&socket_cookies,
+		tcp_sk->inet_conn.icsk_inet.sk.sk_cgrp_data.cgroup, 0,
+		BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!p)
+		return 1;
+
+	p->cookie_value =3D 0xF;
+	p->cookie_key =3D bpf_get_socket_cookie(ctx);
+	return 1;
+}
+
+SEC("sockops")
+int update_cookie_sockops(struct bpf_sock_ops *ctx)
+{
+	struct socket_cookie *p;
+	struct tcp_sock *tcp_sk;
+	struct bpf_sock *sk;
+
+	if (ctx->family !=3D AF_INET6 || ctx->op !=3D BPF_SOCK_OPS_TCP_CONNECT_=
CB)
+		return 1;
+
+	sk =3D ctx->sk;
+	if (!sk)
+		return 1;
+
+	tcp_sk =3D bpf_skc_to_tcp_sock(sk);
+	if (!tcp_sk)
+		return 1;
+
+	p =3D bpf_cgrp_storage_get(&socket_cookies,
+		tcp_sk->inet_conn.icsk_inet.sk.sk_cgrp_data.cgroup, 0, 0);
+	if (!p)
+		return 1;
+
+	if (p->cookie_key !=3D bpf_get_socket_cookie(ctx))
+		return 1;
+
+	p->cookie_value |=3D (ctx->local_port << 8);
+	return 1;
+}
+
+SEC("fexit/inet_stream_connect")
+int BPF_PROG(update_cookie_tracing, struct socket *sock,
+	     struct sockaddr *uaddr, int addr_len, int flags)
+{
+	struct socket_cookie *p;
+	struct tcp_sock *tcp_sk;
+
+	if (uaddr->sa_family !=3D AF_INET6)
+		return 0;
+
+	p =3D bpf_cgrp_storage_get(&socket_cookies, sock->sk->sk_cgrp_data.cgro=
up, 0, 0);
+	if (!p)
+		return 0;
+
+	if (p->cookie_key !=3D bpf_get_socket_cookie(sock->sk))
+		return 0;
+
+	p->cookie_value |=3D 0xF0;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_negative.c b/tools=
/testing/selftests/bpf/progs/cgrp_ls_negative.c
new file mode 100644
index 000000000000..d41f90e2ab64
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgrp_ls_negative.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
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
+SEC("tp_btf/sys_enter")
+int BPF_PROG(on_enter, struct pt_regs *regs, long id)
+{
+	struct task_struct *task;
+
+	task =3D bpf_get_current_task_btf();
+	(void)bpf_cgrp_storage_get(&map_a, (struct cgroup *)task, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c b/tool=
s/testing/selftests/bpf/progs/cgrp_ls_recursion.c
new file mode 100644
index 000000000000..a043d8fefdac
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
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
+	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, long);
+} map_b SEC(".maps");
+
+SEC("fentry/bpf_local_storage_lookup")
+int BPF_PROG(on_lookup)
+{
+	struct task_struct *task =3D bpf_get_current_task_btf();
+
+	bpf_cgrp_storage_delete(&map_a, task->cgroups->dfl_cgrp);
+	bpf_cgrp_storage_delete(&map_b, task->cgroups->dfl_cgrp);
+	return 0;
+}
+
+SEC("fentry/bpf_local_storage_update")
+int BPF_PROG(on_update)
+{
+	struct task_struct *task =3D bpf_get_current_task_btf();
+	long *ptr;
+
+	ptr =3D bpf_cgrp_storage_get(&map_a, task->cgroups->dfl_cgrp, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (ptr)
+		*ptr +=3D 1;
+
+	ptr =3D bpf_cgrp_storage_get(&map_b, task->cgroups->dfl_cgrp, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (ptr)
+		*ptr +=3D 1;
+
+	return 0;
+}
+
+SEC("tp_btf/sys_enter")
+int BPF_PROG(on_enter, struct pt_regs *regs, long id)
+{
+	struct task_struct *task;
+	long *ptr;
+
+	task =3D bpf_get_current_task_btf();
+	ptr =3D bpf_cgrp_storage_get(&map_a, task->cgroups->dfl_cgrp, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (ptr)
+		*ptr =3D 200;
+
+	ptr =3D bpf_cgrp_storage_get(&map_b, task->cgroups->dfl_cgrp, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (ptr)
+		*ptr =3D 100;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_tp_btf.c b/tools/t=
esting/selftests/bpf/progs/cgrp_ls_tp_btf.c
new file mode 100644
index 000000000000..9ebb8e2fe541
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgrp_ls_tp_btf.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
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
+	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, long);
+} map_b SEC(".maps");
+
+#define MAGIC_VALUE 0xabcd1234
+
+pid_t target_pid =3D 0;
+int mismatch_cnt =3D 0;
+int enter_cnt =3D 0;
+int exit_cnt =3D 0;
+
+SEC("tp_btf/sys_enter")
+int BPF_PROG(on_enter, struct pt_regs *regs, long id)
+{
+	struct task_struct *task;
+	long *ptr;
+	int err;
+
+	task =3D bpf_get_current_task_btf();
+	if (task->pid !=3D target_pid)
+		return 0;
+
+	/* populate value 0 */
+	ptr =3D bpf_cgrp_storage_get(&map_a, task->cgroups->dfl_cgrp, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!ptr)
+		return 0;
+
+	/* delete value 0 */
+	err =3D bpf_cgrp_storage_delete(&map_a, task->cgroups->dfl_cgrp);
+	if (err)
+		return 0;
+
+	/* value is not available */
+	ptr =3D bpf_cgrp_storage_get(&map_a, task->cgroups->dfl_cgrp, 0, 0);
+	if (ptr)
+		return 0;
+
+	/* re-populate the value */
+	ptr =3D bpf_cgrp_storage_get(&map_a, task->cgroups->dfl_cgrp, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!ptr)
+		return 0;
+	__sync_fetch_and_add(&enter_cnt, 1);
+	*ptr =3D MAGIC_VALUE + enter_cnt;
+
+	return 0;
+}
+
+SEC("tp_btf/sys_exit")
+int BPF_PROG(on_exit, struct pt_regs *regs, long id)
+{
+	struct task_struct *task;
+	long *ptr;
+
+	task =3D bpf_get_current_task_btf();
+	if (task->pid !=3D target_pid)
+		return 0;
+
+	ptr =3D bpf_cgrp_storage_get(&map_a, task->cgroups->dfl_cgrp, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!ptr)
+		return 0;
+
+	__sync_fetch_and_add(&exit_cnt, 1);
+	if (*ptr !=3D MAGIC_VALUE + exit_cnt)
+		__sync_fetch_and_add(&mismatch_cnt, 1);
+	return 0;
+}
--=20
2.30.2

