Return-Path: <bpf+bounces-23247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A06486F179
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 17:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0C6283181
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 16:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45472261F;
	Sat,  2 Mar 2024 16:50:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7935231
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709398237; cv=none; b=qug0L2jL/dghNFKY+Yah3pycmqH3Q/echqUXlTO9ODZWlhwOagqSEFK6CIOMhsnwSuF1U0XHrBzcqeMJfhakCS5/JZO2aFTHLaq+7dHm//4VpeXgNg5SbJgNv2Ty9J4AJ09V4XeM5POFRbv6j+oEhmI8aX8+9v0tjdsPOsW2rbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709398237; c=relaxed/simple;
	bh=G2o0WfBT96x1x5a71jPIAJ+Cpd7PQAQW6C4cTQyizgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/gIZezR4tjVrDYyWqIdMFmORNGLviz4jjvr8jtHfNFzqoy/uXT7XHLPotp7uTfIQX9WJSTzxG+A9g+/cAs+3RwdQW85NPJKKMGSCdokTA9BA0FaiqcYa+VLjvVBs4Mw+fNJB8vY7RtM47CWKcOEq+DnyIx+0r8mPl3B8809XmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id AA20611F11B4; Sat,  2 Mar 2024 08:50:22 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 1/4] selftests/bpf: Replace CHECK with ASSERT macros for ksyms test
Date: Sat,  2 Mar 2024 08:50:22 -0800
Message-ID: <20240302165022.1627562-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302165017.1627295-1-yonghong.song@linux.dev>
References: <20240302165017.1627295-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I am going to modify ksyms test later so take this opportunity
to replace old CHECK macros with new ASSERT macros.
No functionality change.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../testing/selftests/bpf/prog_tests/ksyms.c  | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/testi=
ng/selftests/bpf/prog_tests/ksyms.c
index b295969b263b..e081f8bf3f17 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksyms.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
@@ -5,8 +5,6 @@
 #include "test_ksyms.skel.h"
 #include <sys/stat.h>
=20
-static int duration;
-
 void test_ksyms(void)
 {
 	const char *btf_path =3D "/sys/kernel/btf/vmlinux";
@@ -18,43 +16,45 @@ void test_ksyms(void)
 	int err;
=20
 	err =3D kallsyms_find("bpf_link_fops", &link_fops_addr);
-	if (CHECK(err =3D=3D -EINVAL, "kallsyms_fopen", "failed to open: %d\n",=
 errno))
+	if (err =3D=3D -EINVAL) {
+		ASSERT_TRUE(false, "kallsyms_fopen for bpf_link_fops");
 		return;
-	if (CHECK(err =3D=3D -ENOENT, "ksym_find", "symbol 'bpf_link_fops' not =
found\n"))
+	}
+	if (err =3D=3D -ENOENT) {
+		ASSERT_TRUE(false, "ksym_find for bpf_link_fops");
 		return;
+	}
=20
 	err =3D kallsyms_find("__per_cpu_start", &per_cpu_start_addr);
-	if (CHECK(err =3D=3D -EINVAL, "kallsyms_fopen", "failed to open: %d\n",=
 errno))
+	if (err =3D=3D -EINVAL) {
+		ASSERT_TRUE(false, "kallsyms_fopen for __per_cpu_start");
 		return;
-	if (CHECK(err =3D=3D -ENOENT, "ksym_find", "symbol 'per_cpu_start' not =
found\n"))
+	}
+	if (err =3D=3D -ENOENT) {
+		ASSERT_TRUE(false, "ksym_find for __per_cpu_start");
 		return;
+	}
=20
-	if (CHECK(stat(btf_path, &st), "stat_btf", "err %d\n", errno))
+	if (!ASSERT_OK(stat(btf_path, &st), "stat_btf"))
 		return;
 	btf_size =3D st.st_size;
=20
 	skel =3D test_ksyms__open_and_load();
-	if (CHECK(!skel, "skel_open", "failed to open and load skeleton\n"))
+	if (!ASSERT_OK_PTR(skel, "test_ksyms__open_and_load"))
 		return;
=20
 	err =3D test_ksyms__attach(skel);
-	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
+	if (!ASSERT_OK(err, "test_ksyms__attach"))
 		goto cleanup;
=20
 	/* trigger tracepoint */
 	usleep(1);
=20
 	data =3D skel->data;
-	CHECK(data->out__bpf_link_fops !=3D link_fops_addr, "bpf_link_fops",
-	      "got 0x%llx, exp 0x%llx\n",
-	      data->out__bpf_link_fops, link_fops_addr);
-	CHECK(data->out__bpf_link_fops1 !=3D 0, "bpf_link_fops1",
-	      "got %llu, exp %llu\n", data->out__bpf_link_fops1, (__u64)0);
-	CHECK(data->out__btf_size !=3D btf_size, "btf_size",
-	      "got %llu, exp %llu\n", data->out__btf_size, btf_size);
-	CHECK(data->out__per_cpu_start !=3D per_cpu_start_addr, "__per_cpu_star=
t",
-	      "got %llu, exp %llu\n", data->out__per_cpu_start,
-	      per_cpu_start_addr);
+	ASSERT_EQ(data->out__bpf_link_fops, link_fops_addr, "bpf_link_fops");
+	ASSERT_EQ(data->out__bpf_link_fops1, 0, "bpf_link_fops1");
+	ASSERT_EQ(data->out__btf_size, btf_size, "btf_size");
+	ASSERT_EQ(data->out__per_cpu_start, per_cpu_start_addr, "__per_cpu_star=
t");
=20
 cleanup:
 	test_ksyms__destroy(skel);
--=20
2.43.0


