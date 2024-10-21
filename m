Return-Path: <bpf+bounces-42654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B989A6E1E
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 17:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F4D1F242B8
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 15:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FF313BAEE;
	Mon, 21 Oct 2024 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="rUB11hlm"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E23C13AA4C
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524497; cv=none; b=U5S7aXPrWwn2SUk4ySc8tcSaXmxnHWf6StkrQylLfbmUHVsLP9QLgJeZgwTMstoakVPdNDB97Sw7Gt/8cJQy8uq5G3yDCjHKxG+DUeDSoIJhjYiuvj2G9A6soSDiO4dBgpXGNgzFyTYJOj94CaFrIXz93lbv8bBSvy2b74xMUek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524497; c=relaxed/simple;
	bh=uh7MQRZtcvFvNUzvLDVuM3QObqKhpbJluFMLDskapwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uxNZLqqo4Ff2HTR988i9e+rlwN52rzgFS0ffc5CUBRhZGlCbAaIfxWr5l9z2udsBsNs40MRa8gKxgspfsQYjxibzaMZlbWHWMzRRGNkq9tqcGa6DkAQoPZ3ael+2cC02qR0H+l8nW701e5UABuji9KM3c7WKvdFmltrtY6Eoobk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=rUB11hlm; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Yptr5E3rFtVujK5OEPOuZTPsCXgRbOkbSs4BCSk+DWc=; b=rUB11hlmkbMgaB5SSLwlqlVoNH
	60sHRxG0vXsIuezEH8zsK82Tvc4c5qhtsU7wIv7bi1T1yy6z6CZQqMJ1CE2PVnhNl/ma53NVqVSya
	i9zJwSS2HKTWbUiHduSdelI13Hp6W01Vkc5d/wxQhy7ppchUpfOlZwqjgA1Gu2E9/Cy6eLztCvl+u
	EyVp02hxVXwhiwHMf7ypqjs7qFuOy2ymk9YdR0CmeFpPSsevZd3xotdtsKtkfVNOfujsQdHkXB26a
	ky27bxUR9N11/X9mpIkgpHAdyv/TcHWPmFVLBIjd1a6i7859FyJuw9mSm3cVF1hmUtoRZ6ClTgwzO
	zjutXOMw==;
Received: from 43.248.197.178.dynamic.cust.swisscom.net ([178.197.248.43] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1t2uKK-000Mzd-Fa; Mon, 21 Oct 2024 17:28:12 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: andrii@kernel.org,
	kongln9170@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf 5/5] selftests/bpf: Add test for passing in uninit mtu_len
Date: Mon, 21 Oct 2024 17:28:09 +0200
Message-Id: <20241021152809.33343-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021152809.33343-1-daniel@iogearbox.net>
References: <20241021152809.33343-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27434/Mon Oct 21 10:49:31 2024)

Add a small test to pass an uninitialized mtu_len to the bpf_check_mtu()
helper to probe whether the verifier rejects it under !CAP_PERFMON.

  # ./vmtest.sh -- ./test_progs -t verifier_mtu
  [...]
  ./test_progs -t verifier_mtu
  [    1.414712] tsc: Refined TSC clocksource calibration: 3407.993 MHz
  [    1.415327] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fcd52370, max_idle_ns: 440795242006 ns
  [    1.416463] clocksource: Switched to clocksource tsc
  [    1.429842] bpf_testmod: loading out-of-tree module taints kernel.
  [    1.430283] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
  #510/1   verifier_mtu/uninit/mtu: write rejected:OK
  #510     verifier_mtu:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/verifier.c       | 19 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_mtu.c        | 18 ++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_mtu.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index e26b5150fc43..4a6ecdcfa6a0 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -53,6 +53,7 @@
 #include "verifier_masking.skel.h"
 #include "verifier_meta_access.skel.h"
 #include "verifier_movsx.skel.h"
+#include "verifier_mtu.skel.h"
 #include "verifier_netfilter_ctx.skel.h"
 #include "verifier_netfilter_retcode.skel.h"
 #include "verifier_bpf_fastcall.skel.h"
@@ -221,6 +222,24 @@ void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_pack
 void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
 void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
 
+void test_verifier_mtu(void)
+{
+	__u64 caps = 0;
+	int ret;
+
+	/* In case CAP_BPF and CAP_PERFMON is not set */
+	ret = cap_enable_effective(1ULL << CAP_BPF | 1ULL << CAP_NET_ADMIN, &caps);
+	if (!ASSERT_OK(ret, "set_cap_bpf_cap_net_admin"))
+		return;
+	ret = cap_disable_effective(1ULL << CAP_SYS_ADMIN | 1ULL << CAP_PERFMON, NULL);
+	if (!ASSERT_OK(ret, "disable_cap_sys_admin"))
+		goto restore_cap;
+	RUN(verifier_mtu);
+restore_cap:
+	if (caps)
+		cap_enable_effective(caps, NULL);
+}
+
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
 	struct test_val value = {
diff --git a/tools/testing/selftests/bpf/progs/verifier_mtu.c b/tools/testing/selftests/bpf/progs/verifier_mtu.c
new file mode 100644
index 000000000000..70c7600a26a0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_mtu.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("tc/ingress")
+__description("uninit/mtu: write rejected")
+__failure __msg("invalid indirect read from stack")
+int tc_uninit_mtu(struct __sk_buff *ctx)
+{
+	__u32 mtu;
+
+	bpf_check_mtu(ctx, 0, &mtu, 0, 0);
+	return TCX_PASS;
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.43.0


