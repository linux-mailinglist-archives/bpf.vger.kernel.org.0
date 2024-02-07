Return-Path: <bpf+bounces-21393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C96E84C563
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 08:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555F31C250FA
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 07:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B641CF87;
	Wed,  7 Feb 2024 07:01:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81531CD3C
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 07:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707289283; cv=none; b=Rh71ZjvZtj7Y4+m+ysiuhVUa7x50URW2p7Qt6L6ZJOC6yw4njS8fRZAHCzKq7RXJ3ZPrHC7HH6ra1AjUxpq8v2r4t3wK7OlRhq30DhrOZZB5hXxUc4H1+Pr0UMYXH9AQy9Z10u5HRLKYq6lq7uY1DgeFKd4qAMt54tiD5tWrAaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707289283; c=relaxed/simple;
	bh=Pvst8qdNECDUjjk2jwdk57gLmOgVuLcJu3RzyvPICG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AZwdDf8spGRsHB8WT2poc5afTiq5Fr0AGUw6rni9yfVNkENjsW9QRMITV24ht7N48hClm+bwrtnnsgneBooVktSATRr7HDWGHpI+RcOZpVAApBUcoV3uYd443aRLYuhdds9G9TE26AzeTLyjlNbZ1+UZNTBTXFg1Hkk3mYZ2EyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 291772D6F909B; Tue,  6 Feb 2024 23:01:07 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Ensure fentry prog cannot attach to bpf_spin_{lock,unlcok}()
Date: Tue,  6 Feb 2024 23:01:07 -0800
Message-Id: <20240207070107.335341-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207070102.335167-1-yonghong.song@linux.dev>
References: <20240207070102.335167-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add two tests to ensure fentry programs cannot attach to
bpf_spin_{lock,unlock}() helpers. The tracing_failure.c files
can be used in the future for other tracing failure cases.

Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/prog_tests/tracing_failure.c          | 37 +++++++++++++++++++
 .../selftests/bpf/progs/tracing_failure.c     | 20 ++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_failur=
e.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_failure.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c b/t=
ools/testing/selftests/bpf/prog_tests/tracing_failure.c
new file mode 100644
index 000000000000..a222df765bc3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include "tracing_failure.skel.h"
+
+static void test_bpf_spin_lock(bool is_spin_lock)
+{
+	struct tracing_failure *skel;
+	int err;
+
+	skel =3D tracing_failure__open();
+	if (!ASSERT_OK_PTR(skel, "tracing_failure__open"))
+		return;
+
+	if (is_spin_lock)
+		bpf_program__set_autoload(skel->progs.test_spin_lock, true);
+	else
+		bpf_program__set_autoload(skel->progs.test_spin_unlock, true);
+
+	err =3D tracing_failure__load(skel);
+	if (!ASSERT_OK(err, "tracing_failure__load"))
+		goto out;
+
+	err =3D tracing_failure__attach(skel);
+	ASSERT_ERR(err, "tracing_failure__attach");
+
+out:
+	tracing_failure__destroy(skel);
+}
+
+void test_tracing_failure(void)
+{
+	if (test__start_subtest("bpf_spin_lock"))
+		test_bpf_spin_lock(true);
+	if (test__start_subtest("bpf_spin_unlock"))
+		test_bpf_spin_lock(false);
+}
diff --git a/tools/testing/selftests/bpf/progs/tracing_failure.c b/tools/=
testing/selftests/bpf/progs/tracing_failure.c
new file mode 100644
index 000000000000..d41665d2ec8c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_failure.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("?fentry/bpf_spin_lock")
+int BPF_PROG(test_spin_lock, struct bpf_spin_lock *lock)
+{
+	return 0;
+}
+
+SEC("?fentry/bpf_spin_unlock")
+int BPF_PROG(test_spin_unlock, struct bpf_spin_lock *lock)
+{
+	return 0;
+}
--=20
2.34.1


