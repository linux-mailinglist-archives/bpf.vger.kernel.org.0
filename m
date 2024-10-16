Return-Path: <bpf+bounces-42196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894EF9A0BDF
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 15:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D97C2846FA
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 13:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70D020C002;
	Wed, 16 Oct 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="HihfryH6"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD14209F29
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729086560; cv=none; b=ujE0urdYSYfeg2y7dCKT/knkAcAD1iIk1Uj9Xfvhqad/40xsIG0dQHQCAP2unfIhhKApbMcXI1NmLx4JM1omVPr1epmbTyIdLdE5TZtRcR8zUllizepi2plFCtaxFH9wYfUP/xerPqHgpXzKWzos/U1m0L/V0Ulgcfttgbzv0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729086560; c=relaxed/simple;
	bh=4mcRfEKKjvKVrdMJBI3OfUzuQSGMcXsxDWfGYMSFCuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R8b2JIxTvWWhP+50zXnVeP3UQ2aIpNUC4rlD3sF92fqhm+TSleHbNbjPozaYLvTZajDdy7D0BOTNWYCiaR6kaGeOzVsmelRJM+sers15gEtjo/H9vFJ492tIBGFODzTBuNiPt2GFzcqTCjK0173P5aeTqAz/D24lrH+jL1tRHR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=HihfryH6; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=UNgkOOrzAVujuxVwkOKKekCbLp6Z7Q9WsIeGa3Wo6nI=; b=HihfryH6SzDO06+s4dKb7rpUoX
	2MKbcuPgkABo+Gx6rGeoAqkU2Vbkux4T4JUcom83xV+M+XBUo+vkqBu8vop5pmAQMgnIVV4l/p3nd
	o27qnB9Js5DAsbANhZbZVV+//zru3FipT4Le1+AK1A6/jOjpi/wFG1hYGecTE9370E3zfAdtlcua2
	l5GNQFlAAmVDkLc9+9xJNcPBZec7A3jkIc54dWB04gsNVHFTz+pMkz8GFmUy2VyxfFTVFQ+Y1qbGI
	akiJYSlaL/6+xuDf0LsQPC3W//QJ1fmlyLTGANDjz7pj5mxGtvx/vz4s8DkSfYgsIwYm7JAE7r/zb
	2q3q7f+Q==;
Received: from 44.248.197.178.dynamic.cust.swisscom.net ([178.197.248.44] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1t14Op-000NfR-B6; Wed, 16 Oct 2024 15:49:15 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: nathaniel.theis@nccgroup.com,
	ast@kernel.org,
	eddyz87@gmail.com,
	andrii@kernel.org,
	john.fastabend@gmail.com
Subject: [PATCH bpf 3/3] selftests/bpf: Add test case for delta propagation
Date: Wed, 16 Oct 2024 15:49:13 +0200
Message-Id: <20241016134913.32249-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016134913.32249-1-daniel@iogearbox.net>
References: <20241016134913.32249-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27429/Wed Oct 16 10:34:11 2024)

Add a small BPF verifier test case to ensure that alu32 additions to
registers are not subject to linked scalar delta tracking.

  # ./vmtest.sh -- ./test_progs -t verifier_linked_scalars
  [...]
  ./test_progs -t verifier_linked_scalars
  [    1.413138] tsc: Refined TSC clocksource calibration: 3407.993 MHz
  [    1.413524] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fcd52370, max_idle_ns: 440795242006 ns
  [    1.414223] clocksource: Switched to clocksource tsc
  [    1.419640] bpf_testmod: loading out-of-tree module taints kernel.
  [    1.420025] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
  #500/1   verifier_linked_scalars/scalars: find linked scalars:OK
  #500     verifier_linked_scalars:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
  [    1.590858] ACPI: PM: Preparing to enter system sleep state S5
  [    1.591402] reboot: Power down
  [...]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../bpf/progs/verifier_linked_scalars.c       | 34 +++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_linked_scalars.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index e26b5150fc43..5356f26bbb3f 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -44,6 +44,7 @@
 #include "verifier_ld_ind.skel.h"
 #include "verifier_ldsx.skel.h"
 #include "verifier_leak_ptr.skel.h"
+#include "verifier_linked_scalars.skel.h"
 #include "verifier_loops1.skel.h"
 #include "verifier_lwt.skel.h"
 #include "verifier_map_in_map.skel.h"
@@ -170,6 +171,7 @@ void test_verifier_jit_convergence(void)      { RUN(verifier_jit_convergence); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
 void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }
 void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); }
+void test_verifier_linked_scalars(void)       { RUN(verifier_linked_scalars); }
 void test_verifier_loops1(void)               { RUN(verifier_loops1); }
 void test_verifier_lwt(void)                  { RUN(verifier_lwt); }
 void test_verifier_map_in_map(void)           { RUN(verifier_map_in_map); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
new file mode 100644
index 000000000000..8f755d2464cf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("socket")
+__description("scalars: find linked scalars")
+__failure
+__msg("math between fp pointer and 2147483647 is not allowed")
+__naked void scalars(void)
+{
+	asm volatile ("				\
+	r0 = 0;					\
+	r1 = 0x80000001 ll;			\
+	r1 /= 1;				\
+	r2 = r1;				\
+	r4 = r1;				\
+	w2 += 0x7FFFFFFF;			\
+	w4 += 0;				\
+	if r2 == 0 goto l1;			\
+	exit;					\
+l1:						\
+	r4 >>= 63;				\
+	r3 = 1;					\
+	r3 -= r4;				\
+	r3 *= 0x7FFFFFFF;			\
+	r3 += r10;				\
+	*(u8*)(r3 - 1) = r0;			\
+	exit;					\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


