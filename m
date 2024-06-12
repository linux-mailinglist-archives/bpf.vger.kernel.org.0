Return-Path: <bpf+bounces-31980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4640C905EA0
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 00:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF7B1C20E01
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 22:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6F112B171;
	Wed, 12 Jun 2024 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Bbzc5t1B"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F104F21360
	for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718232009; cv=none; b=m1GjPn1xglyqIwCxn4tp7V3iNXGQWYVvwQb3TlebS9lodeub0Eeo0j7q1IpD3heNQoCxiltI9u8lBs6x8r7X2D+xWWGkGJ6PUSkrUy6jUvDQKCsMUJTJzd9e2Qj4Fm/f0xB3SZ9y0KUxrn8bOO2gtGa5hLuPu6+POse+yPz+ffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718232009; c=relaxed/simple;
	bh=RoDjvHSTMs1HH6Q5BPX7XJO1Cc9JRo9su++PhdD9X+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bEDS2YFiBKCYqSrFAmmmXN85WzhygyU+bzTUIVvLbJx8wnnTQpQc+TUM4LK2MSI1PzQAm8ubxD7OBoNv3aYCQGpNrxrTKNdmSTuVLuFCwxJR4fzNYJE76TL9SfudZNQWEoKliioxsR7r8aJuSLsYUtgIogCW1wtXFc+949iRiTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Bbzc5t1B; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Fh0qE81JJRQPSiipR0NwBh6F9/M882+6JkDK/X69dLI=; b=Bbzc5t1Bm4j6S7g1kJgLyzB68R
	7rhqTZhy7dbBPbW1AUQ9NLbwdXaB65FJMODgzBEF4rS6z+F09fUwyTJ+KnVFSsuNqiHLncLFEN2Bs
	gyA3bPuJawY00cfrOBp8OxQq8U0el6LhZbc3mxFpIPRdweJz1XtGgcoHWM0v0q3eAFWijEjY7xUYr
	lI1OYctmPPYj/fdxs9ElZ9EDE7VsqZqzhV5uP14+DuxRIgjGjv9xvzR49vTT/HFR30CIA3Luzn8Bu
	q2cT1AYzx0TjV4Xz9QlPrfaHgC+Ff8yjBEdOUlJ/hGmUaQrh+iKELdNPDhIRBA7BrLdpAadBcY9wN
	r0CBNtCg==;
Received: from 34.249.197.178.dynamic.cust.swisscom.net ([178.197.249.34] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sHWER-000GZT-MM; Thu, 13 Jun 2024 00:14:15 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: jjlopezjaimez@google.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 2/2] selftests/bpf: Add test coverage for reg_set_min_max handling
Date: Thu, 13 Jun 2024 00:14:05 +0200
Message-Id: <20240612221405.3378-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240612221405.3378-1-daniel@iogearbox.net>
References: <20240612221405.3378-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27304/Wed Jun 12 10:27:29 2024)

Add a test case for the jmp32/k fix to ensure selftests have coverage.

Before fix:

  # ./vmtest.sh -- ./test_progs -t verifier_or_jmp32_k
  [...]
  ./test_progs -t verifier_or_jmp32_k
  tester_init:PASS:tester_log_buf 0 nsec
  process_subtest:PASS:obj_open_mem 0 nsec
  process_subtest:PASS:specs_alloc 0 nsec
  run_subtest:PASS:obj_open_mem 0 nsec
  run_subtest:FAIL:unexpected_load_success unexpected success: 0
  #492/1   verifier_or_jmp32_k/or_jmp32_k: bit ops + branch on unknown value:FAIL
  #492     verifier_or_jmp32_k:FAIL
  Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED

After fix:

  # ./vmtest.sh -- ./test_progs -t verifier_or_jmp32_k
  [...]
  ./test_progs -t verifier_or_jmp32_k
  #492/1   verifier_or_jmp32_k/or_jmp32_k: bit ops + branch on unknown value:OK
  #492     verifier_or_jmp32_k:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_or_jmp32_k.c | 43 +++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_or_jmp32_k.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 1c9c4ec1be11..98ef39efa77e 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -53,6 +53,7 @@
 #include "verifier_movsx.skel.h"
 #include "verifier_netfilter_ctx.skel.h"
 #include "verifier_netfilter_retcode.skel.h"
+#include "verifier_or_jmp32_k.skel.h"
 #include "verifier_precision.skel.h"
 #include "verifier_prevent_map_lookup.skel.h"
 #include "verifier_raw_stack.skel.h"
@@ -170,6 +171,7 @@ void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
 void test_verifier_movsx(void)                 { RUN(verifier_movsx); }
 void test_verifier_netfilter_ctx(void)        { RUN(verifier_netfilter_ctx); }
 void test_verifier_netfilter_retcode(void)    { RUN(verifier_netfilter_retcode); }
+void test_verifier_or_jmp32_k(void)           { RUN(verifier_or_jmp32_k); }
 void test_verifier_precision(void)            { RUN(verifier_precision); }
 void test_verifier_prevent_map_lookup(void)   { RUN(verifier_prevent_map_lookup); }
 void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_or_jmp32_k.c b/tools/testing/selftests/bpf/progs/verifier_or_jmp32_k.c
new file mode 100644
index 000000000000..c02c3a647e59
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_or_jmp32_k.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("socket")
+__description("or_jmp32_k: bit ops + branch on unknown value")
+__failure
+__msg("R0 invalid mem access 'scalar'")
+__naked void or_jmp32_k(void)
+{
+	asm volatile ("					\
+	r0 = 0xffffffff;				\
+	r0 /= 1;					\
+	r1 = 0;						\
+	w1 = -1;					\
+	w1 >>= 1;					\
+	w0 &= w1;					\
+	w0 |= 2;					\
+	if w0 != 0x7ffffffd goto l2;			\
+	r0 = 1;						\
+	exit;						\
+l4:							\
+	r0 = 5;						\
+	*(u64*)(r0 - 8) = r0;				\
+	exit;						\
+l3:							\
+	w0 -= 0xe;					\
+	if w0 == 1 goto l4;				\
+	r0 = 4;						\
+	exit;						\
+l2:							\
+	w0 -= 0x7ffffff0;				\
+	if w0 s>= 0xe goto l3;				\
+	r0 = 3;						\
+	exit;						\
+"	:
+	:
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


