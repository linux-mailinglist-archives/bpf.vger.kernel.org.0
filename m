Return-Path: <bpf+bounces-60693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0913ADA30F
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 20:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21673AF570
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 18:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E17927BF7E;
	Sun, 15 Jun 2025 18:54:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206281922F4
	for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750013654; cv=none; b=WzlYSgWxjFqIhgzTLfy/09mKbGzl7KCtvwlQsG2xPa4cvyy6FGhUo9NEc8UsIO6xUGc/lAGPet+mKtdzL0Y353/aZdCDH9U+HZWOuatNXlnwjQjpH0wR0jLbiWi2mm1Aymhdsa56kLij8CC9Gnl1VbecFHQRchAXjAK77BUezAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750013654; c=relaxed/simple;
	bh=PDA1EHCWahQn73OLBZQBN859P/YbuxZhbNl7dcbzyuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiKOrODyRqg42vGLEt4013h0OTbwLrHe6a1fg5ChDzPYRSy9qGL/cX+i6zdTNcDXU+UEaDVNpnnvVeQiP2iwkvYQHHPC6VMWCXwGpqphkG05TB19AjFKD1qcr/D5pTfRM6FtqmSIkwB31CfBf7h7POcQMEsAlwdlaHTfQRFMAG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 4C9159A90FA3; Sun, 15 Jun 2025 11:54:01 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Add subtest usdt_multispec_fail with adjustable BPF_USDT_MAX_SPEC_CNT
Date: Sun, 15 Jun 2025 11:54:01 -0700
Message-ID: <20250615185401.2757703-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250615185345.2756663-1-yonghong.song@linux.dev>
References: <20250615185345.2756663-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add udst_multispec_fail subtest. For arm64/clang20 build, the
BPF_USDT_MAX_SPEC_CNT is set to 2. Otherwise, the BPF_USDT_MAX_SPEC_CNT
remains the default value 256. This resolved the previous test failure.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/usdt.c          |  7 ++++---
 .../selftests/bpf/progs/test_usdt_multispec_fail.c     | 10 ++++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_multispec=
_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testin=
g/selftests/bpf/prog_tests/usdt.c
index dc29ef94312a..cc7f38b03a96 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -7,6 +7,7 @@
=20
 #include "test_usdt.skel.h"
 #include "test_urandom_usdt.skel.h"
+#include "test_usdt_multispec_fail.skel.h"
=20
 int lets_test_this(int);
=20
@@ -305,10 +306,10 @@ static void subtest_multispec_usdt(void)
 static void subtest_multispec_fail_usdt(void)
 {
 	LIBBPF_OPTS(bpf_usdt_opts, opts);
-	struct test_usdt *skel;
+	struct test_usdt_multispec_fail *skel;
 	int err;
=20
-	skel =3D test_usdt__open_and_load();
+	skel =3D test_usdt_multispec_fail__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
=20
@@ -322,7 +323,7 @@ static void subtest_multispec_fail_usdt(void)
 	ASSERT_EQ(err, -E2BIG, "usdt_300_attach_err");
=20
 cleanup:
-	test_usdt__destroy(skel);
+	test_usdt_multispec_fail__destroy(skel);
 }
=20
 static FILE *urand_spawn(int *pid)
diff --git a/tools/testing/selftests/bpf/progs/test_usdt_multispec_fail.c=
 b/tools/testing/selftests/bpf/progs/test_usdt_multispec_fail.c
new file mode 100644
index 000000000000..4cca3d8d45fb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_usdt_multispec_fail.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#if defined(__clang__) && defined(__TARGET_ARCH_arm64)
+#define BPF_USDT_MAX_SPEC_CNT 2
+#endif
+
+int my_pid;
+
+#include "test_usdt_multispec.inc.h"
--=20
2.47.1


