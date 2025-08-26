Return-Path: <bpf+bounces-66503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1ABB35253
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 05:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37DD85E1C86
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 03:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916462D1936;
	Tue, 26 Aug 2025 03:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="jX4iQZfB"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FD042A99
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 03:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756179947; cv=none; b=hZ/guGMBs57VXHwUwT0raVIA29uVjRaDSQMklDIaXam653hmbw3beBPSZixKwesIrYganmqbW/AADRlM9irwRbJt4YYSQNmg0JHmU7MP42XHJvThpA/51YRs6I9inYzFiBeBedHfGrG+Tg3lW0oSDtp4CeLr4OVg+urys9TSoZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756179947; c=relaxed/simple;
	bh=o7WVm/rMOe+BMpelZuj12+6g0OlpgqoupgXD0wBebts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CGh5rM4IYyS2cbiBacfoRcJixIdwQGzlKCQmYaZuQlTDGBxxqytbvpktLc+J385Hy/CZZspRy9rvk/u59pg9x9UWSSAYKRaBrL3DDwcx9+y02edfw39hU9BIQQwxucdSuskwXVe0N3T72MQbq/yw+S7sJpT05MNON/d3n3PztUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=jX4iQZfB; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from localhost.localdomain (unknown [14.139.174.50])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id AEB4F44CDC;
	Tue, 26 Aug 2025 03:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1756179942;
	bh=o7WVm/rMOe+BMpelZuj12+6g0OlpgqoupgXD0wBebts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jX4iQZfBo5WFU0Jko+limQpK4C/Evcc69ntxf0fpRzFDBpipDbCRempC+vaFeyx/d
	 AQAL5bRKpjleAkxPVyRSV3I8dYgvRChytUGoDYO6li4u20RzgVk58VHg6+c95sueb6
	 nvWIpogF8wy+/jjgKmxztXdfJLzrQuvN9Il3ze5aB9HI/4xaQRLmzoJVVjX/kYKxB2
	 BYanKyzTOyrkA9+2hFvB+DGe/wwHjCsR3orDmFDj8rh3tahOwmHfxjlvEFj7mttab9
	 3XvWDn2jMwTQCcErBIgTz8f9sna24HEPmISfO0Mv3a5qO5RpJMIvGKJ8SGVLsbGuJl
	 mM92Zo9syrUFA==
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
To: alexei.starovoitov@gmail.com
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Nandakumar Edamana <nandakumar@nandakumar.co.in>
Subject: [PATCH v6 bpf-next 2/2] bpf: Add selftest to check the verifier's abstract multiplication
Date: Tue, 26 Aug 2025 09:15:24 +0530
Message-Id: <20250826034524.2159515-2-nandakumar@nandakumar.co.in>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250826034524.2159515-1-nandakumar@nandakumar.co.in>
References: <20250826034524.2159515-1-nandakumar@nandakumar.co.in>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

Add new selftest to test the abstract multiplication technique(s) used
by the verifier, following the recent improvement in tnum
multiplication (tnum_mul). One of the newly added programs,
verifier_mul/mul_precise, results in a false positive with the old
tnum_mul, while the program passes with the latest one.

Signed-off-by: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_mul.c        | 38 +++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_mul.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 77ec95d4ffaa..e35c216dbaf2 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -59,6 +59,7 @@
 #include "verifier_meta_access.skel.h"
 #include "verifier_movsx.skel.h"
 #include "verifier_mtu.skel.h"
+#include "verifier_mul.skel.h"
 #include "verifier_netfilter_ctx.skel.h"
 #include "verifier_netfilter_retcode.skel.h"
 #include "verifier_bpf_fastcall.skel.h"
@@ -194,6 +195,7 @@ void test_verifier_may_goto_1(void)           { RUN(verifier_may_goto_1); }
 void test_verifier_may_goto_2(void)           { RUN(verifier_may_goto_2); }
 void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
 void test_verifier_movsx(void)                 { RUN(verifier_movsx); }
+void test_verifier_mul(void)                  { RUN(verifier_mul); }
 void test_verifier_netfilter_ctx(void)        { RUN(verifier_netfilter_ctx); }
 void test_verifier_netfilter_retcode(void)    { RUN(verifier_netfilter_retcode); }
 void test_verifier_bpf_fastcall(void)         { RUN(verifier_bpf_fastcall); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_mul.c b/tools/testing/selftests/bpf/progs/verifier_mul.c
new file mode 100644
index 000000000000..7145fe3351d5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_mul.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Nandakumar Edamana */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+/* Intended to test the abstract multiplication technique(s) used by
+ * the verifier. Using assembly to avoid compiler optimizations.
+ */
+SEC("fentry/bpf_fentry_test1")
+void BPF_PROG(mul_precise, int x)
+{
+	/* First, force the verifier to be uncertain about the value:
+	 *     unsigned int a = (bpf_get_prandom_u32() & 0x2) | 0x1;
+	 *
+	 * Assuming the verifier is using tnum, a must be tnum{.v=0x1, .m=0x2}.
+	 * Then a * 0x3 would be m0m1 (m for uncertain). Added imprecision
+	 * would cause the following to fail, because the required return value
+	 * is 0:
+	 *     return (a * 0x3) & 0x4);
+	 */
+	asm volatile ("\
+	call %[bpf_get_prandom_u32];\
+	r0 &= 0x2;\
+	r0 |= 0x1;\
+	r0 *= 0x3;\
+	r0 &= 0x4;\
+	if r0 != 0 goto l0_%=;\
+	r0 = 0;\
+	goto l1_%=;\
+l0_%=:\
+	r0 = 1;\
+l1_%=:\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
-- 
2.39.5


