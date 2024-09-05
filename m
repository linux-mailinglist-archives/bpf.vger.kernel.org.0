Return-Path: <bpf+bounces-39024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2321096DAC1
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 15:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D753A287E44
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 13:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574DC19E7DC;
	Thu,  5 Sep 2024 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Vsf90FKp"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E280F19DF5E
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544105; cv=none; b=f+iUjU2TtvMCO2rlzhvQKK60ExiOYEIUmf7wF4Pw41Vb/faOYfHD2RKuc/jczLgGg8S1CqBy9JD9uva6eSJ5h4olYuyE73aCKGh2N9EoTqa1SY5rjFHjxOUIf9qSRZ0EN9fjiRWCS1h/B1VyZ1KbNwZeO2jMvzcK8Xb2Scmk1jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544105; c=relaxed/simple;
	bh=gHDYpKf0GiNS5GKjOccDz/Nnf9d5GCHwP4u3Dv6Lw2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I5PhsfFAKvBPqDzsbZqlb+Yugz//GAqp8UlbJ0BsGn3IdlV8AnVNzFkT0ZTNaWZaL/Qd2t4jJ3yWwque8m7CDascm4B1T/3i+0FRaavb3zb9yLo8IM6z3JXNBisPEu3bPWuTrHyk/1byKKOxtR3D4/SPbf+khK6P35W9i7mGeTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Vsf90FKp; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=gdzZQIhkAwk01U2LyJBHTjx1Kd1R9masdnEbcR+x7G0=; b=Vsf90FKp6bsFRynSKVe5RyqV/R
	t+d3FHvwodUK6Q0MikyN64hpvmt+JHKnFTlwIIrJIsbICm6TaePNV4WQenwrC9khXo5GgnLv7g513
	FpqS634bBbIKb+4Y8DAMcB96nRqi5SM1NlUTqW6jSPQ9XE5GEzsZuiOB7Kud3mqzGppTaxlIgGvJn
	aWb6VhanAmYk9MbX6ADhVSWOAr3vx4moK2Zz39LXyYpGKNk3ifCoEcoddCVXz40mjswF8ZCQ+kQOP
	FsLQTR9uyidiqAJREbF3SGi92RoLkLzZSCvVXpUnBJZjtPROxn+WSvAu0sLT1lP3ztAY3SvrGx8VK
	DiSa2Maw==;
Received: from 23.248.197.178.dynamic.cust.swisscom.net ([178.197.248.23] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1smCqT-000FEm-LD; Thu, 05 Sep 2024 15:48:21 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: shung-hsi.yu@suse.com,
	andrii@kernel.org,
	ast@kernel.org,
	kongln9170@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v3 6/6] selftests/bpf: Add a test case to write into .rodata
Date: Thu,  5 Sep 2024 15:48:13 +0200
Message-Id: <20240905134813.874-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240905134813.874-1-daniel@iogearbox.net>
References: <20240905134813.874-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27389/Thu Sep  5 10:33:25 2024)

Add a test case which attempts to write into .rodata section of the
BPF program, and for comparison this adds test cases also for .bss
and .data section.

Before fix:

  # ./vmtest.sh -- ./test_progs -t verifier_const
  [...]
  ./test_progs -t verifier_const
  tester_init:PASS:tester_log_buf 0 nsec
  process_subtest:PASS:obj_open_mem 0 nsec
  process_subtest:PASS:specs_alloc 0 nsec
  run_subtest:PASS:obj_open_mem 0 nsec
  run_subtest:FAIL:unexpected_load_success unexpected success: 0
  #465/1   verifier_const/rodata: write rejected:FAIL
  #465/2   verifier_const/bss: write accepted:OK
  #465/3   verifier_const/data: write accepted:OK
  #465     verifier_const:FAIL
  [...]

After fix:

  # ./vmtest.sh -- ./test_progs -t verifier_const
  [...]
  ./test_progs -t verifier_const
  #465/1   verifier_const/rodata: write rejected:OK
  #465/2   verifier_const/bss: write accepted:OK
  #465/3   verifier_const/data: write accepted:OK
  #465     verifier_const:OK
  [...]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 v1 -> v2:
 - const volatile long (Andrii)

 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_const.c      | 42 +++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_const.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 80a90c627182..98d195ff778d 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -21,6 +21,7 @@
 #include "verifier_cgroup_inv_retcode.skel.h"
 #include "verifier_cgroup_skb.skel.h"
 #include "verifier_cgroup_storage.skel.h"
+#include "verifier_const.skel.h"
 #include "verifier_const_or.skel.h"
 #include "verifier_ctx.skel.h"
 #include "verifier_ctx_sk_msg.skel.h"
@@ -145,6 +146,7 @@ void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
 void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_retcode); }
 void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
 void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_storage); }
+void test_verifier_const(void)                { RUN(verifier_const); }
 void test_verifier_const_or(void)             { RUN(verifier_const_or); }
 void test_verifier_ctx(void)                  { RUN(verifier_ctx); }
 void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_const.c b/tools/testing/selftests/bpf/progs/verifier_const.c
new file mode 100644
index 000000000000..5158dbea8c43
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_const.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Isovalent */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+const volatile long foo = 42;
+long bar;
+long bart = 96;
+
+SEC("tc/ingress")
+__description("rodata: write rejected")
+__failure __msg("write into map forbidden")
+int tcx1(struct __sk_buff *skb)
+{
+	char buff[] = { '8', '4', '\0' };
+	bpf_strtol(buff, sizeof(buff), 0, (long *)&foo);
+	return TCX_PASS;
+}
+
+SEC("tc/ingress")
+__description("bss: write accepted")
+__success
+int tcx2(struct __sk_buff *skb)
+{
+	char buff[] = { '8', '4', '\0' };
+	bpf_strtol(buff, sizeof(buff), 0, &bar);
+	return TCX_PASS;
+}
+
+SEC("tc/ingress")
+__description("data: write accepted")
+__success
+int tcx3(struct __sk_buff *skb)
+{
+	char buff[] = { '8', '4', '\0' };
+	bpf_strtol(buff, sizeof(buff), 0, &bart);
+	return TCX_PASS;
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.43.0


