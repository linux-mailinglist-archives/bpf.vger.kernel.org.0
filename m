Return-Path: <bpf+bounces-30899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9C98D45B4
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 09:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75651F22C33
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 07:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4B73DABF0;
	Thu, 30 May 2024 07:05:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469CB143727
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 07:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717052711; cv=none; b=VsILvrQjk0gprAG1NUABmTq3uBR68AJdgypnonAj6yiUjeXch53IEuXOxbWQRkPA9SPJlgECZ2g8qFJRaRIliczYYV+rMUhrN8rUAJ/HWKg4gy8H+9M4VRM7HYRF+EuVAKDd5mWcSpe7B1aJshqRm3hs33GM2X7lGix2MxZkbY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717052711; c=relaxed/simple;
	bh=l5YaB//5XL62Z1PTF8PXQrGe+ErLIEHeE+/ZNHX5aUY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P13PEAOzGpm3o4U4wcNxXnDJ2svx0vES1wIiX+VpRtvoBbGSpKwyLq1MXWIkB3MR0OtuH3HNGTyQBVGe4H8rdDO2spfLezFfLcioYMRkywfrLTpQg1JTRyfMCQlCqwvG4psfAQCe1rrZVffzPAmB5uNcd2kNfrJbiFRggaPmKgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=meta.com; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 44U1MC0s015361
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 00:05:09 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3yds3khfv8-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 00:05:09 -0700
Received: from twshared20084.14.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 30 May 2024 07:04:59 +0000
Received: by devbig1475.frc2.facebook.com (Postfix, from userid 460691)
	id D20995DFFC05; Thu, 30 May 2024 00:04:53 -0700 (PDT)
From: <thinker.li@gmail.com>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <kernel-team@meta.com>, <andrii@kernel.org>, <sinquersw@gmail.com>,
        <kuifeng@meta.com>, <thinker.li@gmail.com>
Subject: [PATCH bpf-next v7 6/8] selftests/bpf: detach a struct_ops link from the subsystem managing it.
Date: Wed, 29 May 2024 23:59:44 -0700
Message-ID: <20240530065946.979330-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530065946.979330-1-thinker.li@gmail.com>
References: <20240530065946.979330-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: PaZDCJYc5uP22H9ZRD_uugLKpbPyTnjB
X-Proofpoint-ORIG-GUID: PaZDCJYc5uP22H9ZRD_uugLKpbPyTnjB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_04,2024-05-28_01,2024-05-17_01

From: Kui-Feng Lee <thinker.li@gmail.com>

Not only a user space program can detach a struct_ops link, the subsystem
managing a link can also detach the link. This patch adds a kfunc to
simulate detaching a link by the subsystem managing it and makes sure use=
r
space programs get notified through epoll.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 42 ++++++++++++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  1 +
 .../bpf/prog_tests/test_struct_ops_module.c   | 67 +++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_detach.c   |  7 ++
 4 files changed, 117 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 0a09732cde4b..2b3a89609b7e 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -744,6 +744,38 @@ __bpf_kfunc int bpf_kfunc_call_kernel_getpeername(st=
ruct addr_args *args)
 	return err;
 }
=20
+static DEFINE_SPINLOCK(detach_lock);
+static struct bpf_link *link_to_detach;
+
+__bpf_kfunc int bpf_dummy_do_link_detach(void)
+{
+	struct bpf_link *link;
+	int ret =3D -ENOENT;
+
+	/* A subsystem must ensure that a link is valid when detaching the
+	 * link. In order to achieve that, the subsystem may need to obtain
+	 * a lock to safeguard a table that holds the pointer to the link
+	 * being detached. However, the subsystem cannot invoke
+	 * link->ops->detach() while holding the lock because other tasks
+	 * may be in the process of unregistering, which could lead to
+	 * acquiring the same lock and causing a deadlock. This is why
+	 * bpf_link_inc_not_zero() is used to maintain the link's validity.
+	 */
+	spin_lock(&detach_lock);
+	link =3D link_to_detach;
+	/* Make sure the link is still valid by increasing its refcnt */
+	if (link && IS_ERR(bpf_link_inc_not_zero(link)))
+		link =3D NULL;
+	spin_unlock(&detach_lock);
+
+	if (link) {
+		ret =3D link->ops->detach(link);
+		bpf_link_put(link);
+	}
+
+	return ret;
+}
+
 BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
@@ -780,6 +812,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_sendmsg, KF_=
SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_sock_sendmsg, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_getsockname, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_getpeername, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_dummy_do_link_detach)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
=20
 static int bpf_testmod_ops_init(struct btf *btf)
@@ -832,11 +865,20 @@ static int bpf_dummy_reg(void *kdata, struct bpf_li=
nk *link)
 	if (ops->test_2)
 		ops->test_2(4, ops->data);
=20
+	spin_lock(&detach_lock);
+	if (!link_to_detach)
+		link_to_detach =3D link;
+	spin_unlock(&detach_lock);
+
 	return 0;
 }
=20
 static void bpf_dummy_unreg(void *kdata, struct bpf_link *link)
 {
+	spin_lock(&detach_lock);
+	if (link =3D=3D link_to_detach)
+		link_to_detach =3D NULL;
+	spin_unlock(&detach_lock);
 }
=20
 static int bpf_testmod_test_1(void)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h =
b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index b0d586a6751f..19131baf4a9e 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -121,6 +121,7 @@ void bpf_kfunc_call_test_fail1(struct prog_test_fail1=
 *p);
 void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p);
 void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p);
 void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len);
+int bpf_dummy_do_link_detach(void) __ksym;
=20
 void bpf_kfunc_common_test(void) __ksym;
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_modul=
e.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index bbcf12696a6b..f4000bf04752 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 #include <test_progs.h>
 #include <time.h>
+#include <network_helpers.h>
=20
 #include <sys/epoll.h>
=20
@@ -297,6 +298,70 @@ static void test_detach_link(void)
 	struct_ops_detach__destroy(skel);
 }
=20
+/* Detach a link from the subsystem that the link was registered to */
+static void test_subsystem_detach(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in =3D &pkt_v4,
+		    .data_size_in =3D sizeof(pkt_v4));
+	struct epoll_event ev, events[2];
+	struct struct_ops_detach *skel;
+	struct bpf_link *link =3D NULL;
+	int fd, epollfd =3D -1, nfds;
+	int prog_fd;
+	int err;
+
+	skel =3D struct_ops_detach__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_detach_open_and_load"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(skel->maps.testmod_do_detach);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto cleanup;
+
+	fd =3D bpf_link__fd(link);
+	if (!ASSERT_GE(fd, 0, "link_fd"))
+		goto cleanup;
+
+	prog_fd =3D bpf_program__fd(skel->progs.start_detach);
+	if (!ASSERT_GE(prog_fd, 0, "start_detach_fd"))
+		goto cleanup;
+
+	/* Do detachment from the registered subsystem */
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "start_detach_run"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(topts.retval, 0, "start_detach_run_retval"))
+		goto cleanup;
+
+	epollfd =3D epoll_create1(0);
+	if (!ASSERT_GE(epollfd, 0, "epoll_create1"))
+		goto cleanup;
+
+	ev.events =3D EPOLLHUP;
+	ev.data.fd =3D fd;
+	err =3D epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev);
+	if (!ASSERT_OK(err, "epoll_ctl"))
+		goto cleanup;
+
+	/* Wait for EPOLLHUP */
+	nfds =3D epoll_wait(epollfd, events, 2, 5000);
+	if (!ASSERT_EQ(nfds, 1, "epoll_wait"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(events[0].data.fd, fd, "epoll_wait_fd"))
+		goto cleanup;
+	if (!ASSERT_TRUE(events[0].events & EPOLLHUP, "events[0].events"))
+		goto cleanup;
+
+cleanup:
+	if (epollfd >=3D 0)
+		close(epollfd);
+	bpf_link__destroy(link);
+	struct_ops_detach__destroy(skel);
+}
+
 void serial_test_struct_ops_module(void)
 {
 	if (test__start_subtest("struct_ops_load"))
@@ -311,5 +376,7 @@ void serial_test_struct_ops_module(void)
 		test_struct_ops_forgotten_cb();
 	if (test__start_subtest("test_detach_link"))
 		test_detach_link();
+	if (test__start_subtest("test_subsystem_detach"))
+		test_subsystem_detach();
 }
=20
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_detach.c b/tool=
s/testing/selftests/bpf/progs/struct_ops_detach.c
index 56b787a89876..3ce2f7c3815d 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_detach.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
@@ -3,8 +3,15 @@
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include "../bpf_testmod/bpf_testmod.h"
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
=20
 char _license[] SEC("license") =3D "GPL";
=20
 SEC(".struct_ops.link")
 struct bpf_testmod_ops testmod_do_detach;
+
+SEC("tc")
+int start_detach(void *skb)
+{
+	return bpf_dummy_do_link_detach();
+}
--=20
2.43.0


