Return-Path: <bpf+bounces-69856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 974F8BA4BEB
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 19:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BC756332F
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 17:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7672930C622;
	Fri, 26 Sep 2025 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="GGk3EmOg"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE9430BBB3
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758906728; cv=none; b=A0kVMj6T4HHGTrU/nMP4rly3+zWRZFXCc6fYSoVI8OC4tnty6Fa2d1BQCy0b0oHqW7AonWQWzm32JgGea2OrArqlSz/tRhyDHubHWTcuW3PrAdjBgvtgCjj7DwkSNOMPoW1c+00GaMDn+wGD6xf1A+UgU2bD7YcgwAcm4CGxpvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758906728; c=relaxed/simple;
	bh=HfEPuYLNwhsCRX2kOElPzanIL7dWG822vsX89bW1SF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANFp4feAIjSKhX4eDAmTZTHc/BUGOpI6BQDMVZvpkAQ+35cpjQ1/h80OyEzxrXbPf3wZbueydAitSv+A4yX6wS7koiWRQbPBk7MB+IBKKyYoPTk9LxyudBA8j73TA7Twtj0m+heci8BJvCqmq+hj9m+I2Y/RnUmaPi+xC9qKziU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=GGk3EmOg; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tw8BkifKpS/TAU8iRKn3GWeHOLf+sH8HbrgwV4QEwqA=; b=GGk3EmOg7EWMg5FoaVeDLreq1W
	Fiueux/aC2Iy+2SlcUTj10dx+bzPerqS6Py1ni3pMp+yhAjytB0YtODZMFZKxQqHXDwfCLB2rj3Ux
	jE+lQXKcuGWhS3iqK1UQVlGaFX1ixFHr3vxZvEHBttcVCKqThBF2qKesC2V51Nj7GoxjbNt3uGwHJ
	R2eEifJlgEYm7ME6M59tu7uJh3buua+Y/+VzW9ZT7GeVHFqLR+htHsbHOu3Z+kzs/ax6s5P1YJhr+
	+iwtUDRnjg0HxQ53/0ZEFsGnF3eSipb/WLkzzYudY3RjYiMAT9XZ0AvDfx8i6fPGjvQIawGcbMEok
	xSdNalyg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1v2BzG-0002Ve-23;
	Fri, 26 Sep 2025 19:12:02 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii.nakryiko@gmail.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add test case for different expected_attach_type
Date: Fri, 26 Sep 2025 19:12:01 +0200
Message-ID: <20250926171201.188490-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926171201.188490-1-daniel@iogearbox.net>
References: <20250926171201.188490-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27774/Fri Sep 26 10:27:36 2025)

Add a small test case which adds two programs - one calling the other
through a tailcall - and check that BPF rejects them in case of different
expected_attach_type values:

  # ./vmtest.sh -- ./test_progs -t xdp_devmap
  [...]
  #641/1   xdp_devmap_attach/DEVMAP with programs in entries:OK
  #641/2   xdp_devmap_attach/DEVMAP with frags programs in entries:OK
  #641/3   xdp_devmap_attach/Verifier check of DEVMAP programs:OK
  #641/4   xdp_devmap_attach/DEVMAP with programs in entries on veth:OK
  #641     xdp_devmap_attach:OK
  Summary: 2/4 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../bpf/prog_tests/xdp_devmap_attach.c        | 31 ++++++++++++++++++-
 .../bpf/progs/test_xdp_devmap_tailcall.c      | 29 +++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_devmap_tailcall.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
index 461ab18705d5..a8ab05216c38 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
@@ -7,6 +7,7 @@
 #include <test_progs.h>
 
 #include "test_xdp_devmap_helpers.skel.h"
+#include "test_xdp_devmap_tailcall.skel.h"
 #include "test_xdp_with_devmap_frags_helpers.skel.h"
 #include "test_xdp_with_devmap_helpers.skel.h"
 
@@ -107,6 +108,29 @@ static void test_neg_xdp_devmap_helpers(void)
 	}
 }
 
+static void test_xdp_devmap_tailcall(enum bpf_attach_type prog_dev,
+				     enum bpf_attach_type prog_tail,
+				     bool expect_reject)
+{
+	struct test_xdp_devmap_tailcall *skel;
+	int err;
+
+	skel = test_xdp_devmap_tailcall__open();
+	if (!ASSERT_OK_PTR(skel, "test_xdp_devmap_tailcall__open"))
+		return;
+
+	bpf_program__set_expected_attach_type(skel->progs.xdp_devmap, prog_dev);
+	bpf_program__set_expected_attach_type(skel->progs.xdp_entry, prog_tail);
+
+	err = test_xdp_devmap_tailcall__load(skel);
+	if (expect_reject)
+		ASSERT_ERR(err, "test_xdp_devmap_tailcall__load");
+	else
+		ASSERT_OK(err, "test_xdp_devmap_tailcall__load");
+
+	test_xdp_devmap_tailcall__destroy(skel);
+}
+
 static void test_xdp_with_devmap_frags_helpers(void)
 {
 	struct test_xdp_with_devmap_frags_helpers *skel;
@@ -238,8 +262,13 @@ void serial_test_xdp_devmap_attach(void)
 	if (test__start_subtest("DEVMAP with frags programs in entries"))
 		test_xdp_with_devmap_frags_helpers();
 
-	if (test__start_subtest("Verifier check of DEVMAP programs"))
+	if (test__start_subtest("Verifier check of DEVMAP programs")) {
 		test_neg_xdp_devmap_helpers();
+		test_xdp_devmap_tailcall(BPF_XDP_DEVMAP, BPF_XDP_DEVMAP, false);
+		test_xdp_devmap_tailcall(0, 0, true);
+		test_xdp_devmap_tailcall(BPF_XDP_DEVMAP, 0, true);
+		test_xdp_devmap_tailcall(0, BPF_XDP_DEVMAP, true);
+	}
 
 	if (test__start_subtest("DEVMAP with programs in entries on veth"))
 		test_xdp_with_devmap_helpers_veth();
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_devmap_tailcall.c b/tools/testing/selftests/bpf/progs/test_xdp_devmap_tailcall.c
new file mode 100644
index 000000000000..814e2a980e97
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_xdp_devmap_tailcall.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+SEC("xdp")
+int xdp_devmap(struct xdp_md *ctx)
+{
+	return ctx->egress_ifindex;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__array(values, int (void *));
+} xdp_map SEC(".maps") = {
+	.values = {
+		[0] = (void *)&xdp_devmap,
+	},
+};
+
+SEC("xdp")
+int xdp_entry(struct xdp_md *ctx)
+{
+	bpf_tail_call(ctx, &xdp_map, 0);
+	return 0;
+}
-- 
2.43.0


