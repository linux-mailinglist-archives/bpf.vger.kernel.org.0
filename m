Return-Path: <bpf+bounces-30900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19238D45B5
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 09:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3632BB24238
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 07:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3535121C160;
	Thu, 30 May 2024 07:05:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5758B143727
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 07:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717052715; cv=none; b=QxefRCaYw1tOs1LK79J+rZAXsXyrBrEsw9WGuer8CAxScP+qQK3bi7gMhselnp4pwN2UGhxAfY6rAN/Zjc8waBRZlLHMBNcc+QYcO/cMcUr3qcQbnBbubOxiukEiRmbOn4EDnBrzOzieqFIHuOTnT0I4047nPYvjxdGTcyTRWNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717052715; c=relaxed/simple;
	bh=DpkJWvgBK9sPKqGSzNdJzzcLqpFix4lPs6xoqrk5qws=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ain0tCcAgYZzps8wFzUF19ocyNfQPNhIc+NpPrXDflGrLCbsmE7C5HwQ5/rECamqS/a3Xzf0+0yHjWpcnges29VE4UvOffhv+wFxxQbJr8ZRgWiLB0ycuak2A+Yiv+WtjAH0qHel53lkhldEaQDwxstAgZgLcxtSvFygDxKxIdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=meta.com; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44U2k27F031682
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 00:05:13 -0700
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yegy3gwjr-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 00:05:13 -0700
Received: from twshared25218.38.frc1.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 30 May 2024 07:05:06 +0000
Received: by devbig1475.frc2.facebook.com (Postfix, from userid 460691)
	id 4F2145DFFC01; Thu, 30 May 2024 00:04:53 -0700 (PDT)
From: <thinker.li@gmail.com>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <kernel-team@meta.com>, <andrii@kernel.org>, <sinquersw@gmail.com>,
        <kuifeng@meta.com>, <thinker.li@gmail.com>
Subject: [PATCH bpf-next v7 5/8] selftests/bpf: test struct_ops with epoll
Date: Wed, 29 May 2024 23:59:43 -0700
Message-ID: <20240530065946.979330-6-thinker.li@gmail.com>
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
X-Proofpoint-GUID: bURi8t0QsaA9-YIYzy6Zl6KiYAVGWw3B
X-Proofpoint-ORIG-GUID: bURi8t0QsaA9-YIYzy6Zl6KiYAVGWw3B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_04,2024-05-28_01,2024-05-17_01

From: Kui-Feng Lee <thinker.li@gmail.com>

Verify whether a user space program is informed through epoll with EPOLLH=
UP
when a struct_ops object is detached.

The BPF code in selftests/bpf/progs/struct_ops_module.c has become
complex. Therefore, struct_ops_detach.c has been added to segregate the B=
PF
code for detachment tests from the BPF code for other tests based on the
recommendation of Andrii Nakryiko.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_module.c   | 57 +++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_detach.c   | 10 ++++
 2 files changed, 67 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_detach.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_modul=
e.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 29e183a80f49..bbcf12696a6b 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -3,9 +3,12 @@
 #include <test_progs.h>
 #include <time.h>
=20
+#include <sys/epoll.h>
+
 #include "struct_ops_module.skel.h"
 #include "struct_ops_nulled_out_cb.skel.h"
 #include "struct_ops_forgotten_cb.skel.h"
+#include "struct_ops_detach.skel.h"
=20
 static void check_map_info(struct bpf_map_info *info)
 {
@@ -242,6 +245,58 @@ static void test_struct_ops_forgotten_cb(void)
 	struct_ops_forgotten_cb__destroy(skel);
 }
=20
+/* Detach a link from a user space program */
+static void test_detach_link(void)
+{
+	struct epoll_event ev, events[2];
+	struct struct_ops_detach *skel;
+	struct bpf_link *link =3D NULL;
+	int fd, epollfd =3D -1, nfds;
+	int err;
+
+	skel =3D struct_ops_detach__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_detach__open_and_load"))
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
+	err =3D bpf_link__detach(link);
+	if (!ASSERT_OK(err, "detach_link"))
+		goto cleanup;
+
+	/* Wait for EPOLLHUP */
+	nfds =3D epoll_wait(epollfd, events, 2, 500);
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
@@ -254,5 +309,7 @@ void serial_test_struct_ops_module(void)
 		test_struct_ops_nulled_out_cb();
 	if (test__start_subtest("struct_ops_forgotten_cb"))
 		test_struct_ops_forgotten_cb();
+	if (test__start_subtest("test_detach_link"))
+		test_detach_link();
 }
=20
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_detach.c b/tool=
s/testing/selftests/bpf/progs/struct_ops_detach.c
new file mode 100644
index 000000000000..56b787a89876
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_do_detach;
--=20
2.43.0


