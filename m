Return-Path: <bpf+bounces-60692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9193ADA310
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 20:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333AE1889254
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 18:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C5E27B4F9;
	Sun, 15 Jun 2025 18:54:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A451922F4
	for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750013649; cv=none; b=lBDHFmCtdnRiCIEcxTzuq5uZyh34/7j2sbIzbDoufXiUoE1T2NPEnaZgBn95Li1kTpHrEqwQ2E+gr+qmMHEwL15VPUskk3y/ATyc7O0W+xA/7HhFtWSLVDVe/cogmRBQb1AcGdOpNECjg0wOaZJ694XM4064jke9IMMN3olQVys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750013649; c=relaxed/simple;
	bh=5OAByZtwLWPOAIWSWTiXzyAD1FzoTFXBdESR19/4lSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfHSYgOasah071d35exvtmTr6lowphJhSKIQ6EFAmh6KDwIR1GO/INEdN8EBsRzP0t0a9xZ8aNQjLCBiM/gUZL2dBUioXCv6HvJekssDY9O1AxFw1wd8JUZzgim5tsNMbG2YHP2tT5q7N5jfEQ0vUdz9icqutDihUl5tevh+Ct4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 336F99A90F8A; Sun, 15 Jun 2025 11:53:56 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Add test_usdt_multispec.inc.h for sharing between multiple progs
Date: Sun, 15 Jun 2025 11:53:56 -0700
Message-ID: <20250615185356.2757535-1-yonghong.song@linux.dev>
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

Replace test_usdt_multispec.c to test_usdt_multispec.inc.h so the bpf pro=
g
usdt_100 can be used for multiple bpf programs. The newer test_usdt_multi=
spec.c
will just include test_usdt_multispec.inc.h.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/test_usdt_multispec.c | 28 +----------------
 .../bpf/progs/test_usdt_multispec.inc.h       | 30 +++++++++++++++++++
 2 files changed, 31 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_multispec=
.inc.h

diff --git a/tools/testing/selftests/bpf/progs/test_usdt_multispec.c b/to=
ols/testing/selftests/bpf/progs/test_usdt_multispec.c
index 962f3462066a..97c6082df328 100644
--- a/tools/testing/selftests/bpf/progs/test_usdt_multispec.c
+++ b/tools/testing/selftests/bpf/progs/test_usdt_multispec.c
@@ -1,30 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
=20
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-#include <bpf/usdt.bpf.h>
-
-/* this file is linked together with test_usdt.c to validate that usdt.b=
pf.h
- * can be included in multiple .bpf.c files forming single final BPF obj=
ect
- * file
- */
-
-extern int my_pid;
-
-int usdt_100_called;
-int usdt_100_sum;
-
-SEC("usdt//proc/self/exe:test:usdt_100")
-int BPF_USDT(usdt_100, int x)
-{
-	if (my_pid !=3D (bpf_get_current_pid_tgid() >> 32))
-		return 0;
-
-	__sync_fetch_and_add(&usdt_100_called, 1);
-	__sync_fetch_and_add(&usdt_100_sum, x);
-
-	return 0;
-}
-
-char _license[] SEC("license") =3D "GPL";
+#include "test_usdt_multispec.inc.h"
diff --git a/tools/testing/selftests/bpf/progs/test_usdt_multispec.inc.h =
b/tools/testing/selftests/bpf/progs/test_usdt_multispec.inc.h
new file mode 100644
index 000000000000..962f3462066a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_usdt_multispec.inc.h
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/usdt.bpf.h>
+
+/* this file is linked together with test_usdt.c to validate that usdt.b=
pf.h
+ * can be included in multiple .bpf.c files forming single final BPF obj=
ect
+ * file
+ */
+
+extern int my_pid;
+
+int usdt_100_called;
+int usdt_100_sum;
+
+SEC("usdt//proc/self/exe:test:usdt_100")
+int BPF_USDT(usdt_100, int x)
+{
+	if (my_pid !=3D (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	__sync_fetch_and_add(&usdt_100_called, 1);
+	__sync_fetch_and_add(&usdt_100_sum, x);
+
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.47.1


