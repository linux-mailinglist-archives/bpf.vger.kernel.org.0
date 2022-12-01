Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B55663E931
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 06:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiLAFHS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 00:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiLAFHR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 00:07:17 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60742A0555
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 21:07:16 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AUJWY4N005689
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 21:07:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=uMu44AwmNLPDNUKZne1y6aFARJAW8R8uuZiNPJeLTzY=;
 b=TgxQodiAF7gBVHH6n77EoBCY9XSU/1L1eZTkoDeSCaDP4dUblAZ1ep8cedCkIF/QFmEJ
 H+XxRF4/UE//R4tOD9qNYqPveBPNpisKD+W54XRRgFkYUno9gRfSUOqtaLyUf8759ZAH
 c48PBNQWdXZrsF0+qQMa1bc4p4aDaHJSpwk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m5mqj9rhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 21:07:15 -0800
Received: from twshared0705.02.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 21:07:14 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id AD89F13007409; Wed, 30 Nov 2022 21:04:49 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 2/2] bpf: Add sleepable prog tests for cgrp local storage
Date:   Wed, 30 Nov 2022 21:04:49 -0800
Message-ID: <20221201050449.2785613-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221201050444.2785007-1-yhs@fb.com>
References: <20221201050444.2785007-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: dFzuHPi8AphvANetHbXvJao6_OjwOAIZ
X-Proofpoint-ORIG-GUID: dFzuHPi8AphvANetHbXvJao6_OjwOAIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_03,2022-11-30_02,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add three tests for cgrp local storage support for sleepable progs.
Two tests can load and run properly, one for cgroup_iter, another
for passing current->cgroups->dfl_cgrp to bpf_cgrp_storage_get()
helper. One test has bpf_rcu_read_lock() and failed to load.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../bpf/prog_tests/cgrp_local_storage.c       | 94 +++++++++++++++++++
 .../selftests/bpf/progs/cgrp_ls_sleepable.c   | 80 ++++++++++++++++
 2 files changed, 174 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c =
b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
index 1c30412ba132..33a2776737e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
@@ -10,7 +10,9 @@
 #include "cgrp_ls_recursion.skel.h"
 #include "cgrp_ls_attach_cgroup.skel.h"
 #include "cgrp_ls_negative.skel.h"
+#include "cgrp_ls_sleepable.skel.h"
 #include "network_helpers.h"
+#include "cgroup_helpers.h"
=20
 struct socket_cookie {
 	__u64 cookie_key;
@@ -150,14 +152,100 @@ static void test_negative(void)
 	}
 }
=20
+static void test_cgroup_iter_sleepable(int cgroup_fd, __u64 cgroup_id)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo;
+	struct cgrp_ls_sleepable *skel;
+	struct bpf_link *link;
+	int err, iter_fd;
+	char buf[16];
+
+	skel =3D cgrp_ls_sleepable__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.cgroup_iter, true);
+	err =3D cgrp_ls_sleepable__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto out;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.cgroup.cgroup_fd =3D cgroup_fd;
+	linfo.cgroup.order =3D BPF_CGROUP_ITER_SELF_ONLY;
+	opts.link_info =3D &linfo;
+	opts.link_info_len =3D sizeof(linfo);
+	link =3D bpf_program__attach_iter(skel->progs.cgroup_iter, &opts);
+	if (!ASSERT_OK_PTR(link, "attach_iter"))
+		goto out;
+
+	iter_fd =3D bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "iter_create"))
+		goto out;
+
+	/* trigger the program run */
+	(void)read(iter_fd, buf, sizeof(buf));
+
+	ASSERT_EQ(skel->bss->cgroup_id, cgroup_id, "cgroup_id");
+
+	close(iter_fd);
+out:
+	cgrp_ls_sleepable__destroy(skel);
+}
+
+static void test_no_rcu_lock(__u64 cgroup_id)
+{
+	struct cgrp_ls_sleepable *skel;
+	int err;
+
+	skel =3D cgrp_ls_sleepable__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->bss->target_pid =3D syscall(SYS_gettid);
+
+	bpf_program__set_autoload(skel->progs.no_rcu_lock, true);
+	err =3D cgrp_ls_sleepable__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto out;
+
+	err =3D cgrp_ls_sleepable__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto out;
+
+	syscall(SYS_getpgid);
+
+	ASSERT_EQ(skel->bss->cgroup_id, cgroup_id, "cgroup_id");
+out:
+	cgrp_ls_sleepable__destroy(skel);
+}
+
+static void test_rcu_lock(void)
+{
+	struct cgrp_ls_sleepable *skel;
+	int err;
+
+	skel =3D cgrp_ls_sleepable__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.yes_rcu_lock, true);
+	err =3D cgrp_ls_sleepable__load(skel);
+	ASSERT_ERR(err, "skel_load");
+
+	cgrp_ls_sleepable__destroy(skel);
+}
+
 void test_cgrp_local_storage(void)
 {
+	__u64 cgroup_id;
 	int cgroup_fd;
=20
 	cgroup_fd =3D test__join_cgroup("/cgrp_local_storage");
 	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup /cgrp_local_storage"))
 		return;
=20
+	cgroup_id =3D get_cgroup_id("/cgrp_local_storage");
 	if (test__start_subtest("tp_btf"))
 		test_tp_btf(cgroup_fd);
 	if (test__start_subtest("attach_cgroup"))
@@ -166,6 +254,12 @@ void test_cgrp_local_storage(void)
 		test_recursion(cgroup_fd);
 	if (test__start_subtest("negative"))
 		test_negative();
+	if (test__start_subtest("cgroup_iter_sleepable"))
+		test_cgroup_iter_sleepable(cgroup_fd, cgroup_id);
+	if (test__start_subtest("no_rcu_lock"))
+		test_no_rcu_lock(cgroup_id);
+	if (test__start_subtest("rcu_lock"))
+		test_rcu_lock();
=20
 	close(cgroup_fd);
 }
diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c b/tool=
s/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
new file mode 100644
index 000000000000..2d11ed528b6f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "bpf_iter.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
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
+__u32 target_pid;
+__u64 cgroup_id;
+
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
+SEC("?iter.s/cgroup")
+int cgroup_iter(struct bpf_iter__cgroup *ctx)
+{
+	struct seq_file *seq =3D ctx->meta->seq;
+	struct cgroup *cgrp =3D ctx->cgroup;
+	long *ptr;
+
+	if (cgrp =3D=3D NULL)
+		return 0;
+
+	ptr =3D bpf_cgrp_storage_get(&map_a, cgrp, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (ptr)
+		cgroup_id =3D cgrp->kn->id;
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int no_rcu_lock(void *ctx)
+{
+	struct task_struct *task;
+	struct cgroup *cgrp;
+	long *ptr;
+
+	task =3D bpf_get_current_task_btf();
+	if (task->pid !=3D target_pid)
+		return 0;
+
+	/* ptr_to_btf_id semantics. should work. */
+	cgrp =3D task->cgroups->dfl_cgrp;
+	ptr =3D bpf_cgrp_storage_get(&map_a, cgrp, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (ptr)
+		cgroup_id =3D cgrp->kn->id;
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int yes_rcu_lock(void *ctx)
+{
+	struct task_struct *task;
+	struct cgroup *cgrp;
+	long *ptr;
+
+	task =3D bpf_get_current_task_btf();
+	if (task->pid !=3D target_pid)
+		return 0;
+
+	bpf_rcu_read_lock();
+	cgrp =3D task->cgroups->dfl_cgrp;
+	/* cgrp is untrusted and cannot pass to bpf_cgrp_storage_get() helper. =
*/
+	ptr =3D bpf_cgrp_storage_get(&map_a, cgrp, 0, BPF_LOCAL_STORAGE_GET_F_C=
REATE);
+	if (ptr)
+		cgroup_id =3D cgrp->kn->id;
+	bpf_rcu_read_unlock();
+	return 0;
+}
--=20
2.30.2

