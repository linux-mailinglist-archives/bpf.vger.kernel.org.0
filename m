Return-Path: <bpf+bounces-69841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8230BA3F20
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 15:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB4B3B8328
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 13:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D09E19D074;
	Fri, 26 Sep 2025 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="dC7C5WYL"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7F3199FAB
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894623; cv=none; b=eFuKRRNs2mNQ04ItY3LsN04/eQ1RAUcczfaGM45568EuEenvEbv2hdXPK6dy7W5B6he03KQJ/sOZYgVvz927yFVUTVO6iWVfSd8pKfXiMKloRHlVjHV22eotjcXeVRJ19f0azqK3rsFgonkCfb/LIqsWQDu4L99ZmTW38PLxLhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894623; c=relaxed/simple;
	bh=g+Zw3LyIAc4Ils1XDPmPHfC5nhnb2Xw/aKtErKjotHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqnBH22u2hLuBTkP8654nok4akk85NliaYKBLS7eYNdpR9AHaTslHghP3pBP2wrB3NMeyyQolsrK8nLPlCkUPPaJaBVV+r2iysMx7USvTZc8r2NB4XIH7c5mio/A7fKfwgCqkiwgyk9teHh/7nrq1mmb477CItSg0SGzrf/PP+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=dC7C5WYL; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=DIoPHMw05n1YbAOGDHEFFGtoXhvc/a0BonXSDzgxqNo=; b=dC7C5WYL4obwoLhPdmzasxO7dY
	vHQRC/RXOdjjQRommU78LJNEvNP+/shRcuDV0Ix8S53ZKfWf0yDbuFyVmISoXVNBE9cqnLU/102CW
	x4b68ytyKVcMdriL0c63i8FzNKJ7iV/2jygH4bfwz6l425wg3OyGGg0Bke7TFE5Rz0cUI34ILZV3n
	1xziHiZPfF1al74l1YTl7DyEr0eRvuphGyUVb3Hu/FQG9N/Xek/BzcAs+lNKxqZNp/OkHAfOv2SKQ
	p8N8JUU1e/1naIZZ06vk5zSFDmKnfKMxPbjHc2uITOTXoDGsg5xo40OeltYEtgn7k7BG5O9CyUBBG
	nfmtJPqA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1v28pv-000HNB-1S;
	Fri, 26 Sep 2025 15:50:11 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii.nakryiko@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test case for different expected_attach_type
Date: Fri, 26 Sep 2025 15:50:10 +0200
Message-ID: <20250926135010.185569-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926135010.185569-1-daniel@iogearbox.net>
References: <20250926135010.185569-1-daniel@iogearbox.net>
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
  #641/1   xdp_devmap_attach/Verifier check of DEVMAP programs:OK
  #641     xdp_devmap_attach:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

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
index 000000000000..ea2d4912e499
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


