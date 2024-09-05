Return-Path: <bpf+bounces-39008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A5496D7CD
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 14:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953D61C2342E
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 12:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364A619ABDE;
	Thu,  5 Sep 2024 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="SEasP3Mh"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251C51990CE
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537706; cv=none; b=DZfreRzBppMQBOkcxuHLI7BuSv1HZzbarb1OFJSl/cuqp4KYJpTK23tq5kTptatA+7IxJqvAzZ7OBK7Vi94+czuBii3P/QlpBm1Ng33AaJ+Rzab282zqLmdCuELZmyJ1bDCTEHY8ol1tqY+NXDgvogar3789YqWneQ8cTPPnBsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537706; c=relaxed/simple;
	bh=gHDYpKf0GiNS5GKjOccDz/Nnf9d5GCHwP4u3Dv6Lw2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b+Qk3EY2LuGYsuJFfvMxPS+aPpXmhgPAOtm8bMKaMigmaxBx7eMObZVQjlbTDaNWKupXEusohb68eWnN9lpdlsdKNvq26VhcGZBMROtcHRVQpXqF7cWrHa7NuMklRbNRLiX4toGw3gfoTQ7PBXsV+c+y0deoi/4fhTkF5JjgW3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=SEasP3Mh; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=gdzZQIhkAwk01U2LyJBHTjx1Kd1R9masdnEbcR+x7G0=; b=SEasP3MhWUPCFezmAuDIqcHHjb
	jC9nlW8s5bFboXoQClzUYmfTQl3ytqkoO3hQ0xMqgd6f60QLktYnkCeYqolwEyEBOlEoqOGGeYIc0
	ok6WsyZl7k6Uav5ixSNfgkmeFRHQQUw8EdSzUR8ltR0zGpk/I4cGgO17hqCwlexeBu1veUEqTtgXv
	yX4S3lkoPGUOWkPZEoIdzF7jfoofBAA9E+iGLaFyu88XFkEVPjq09f4pmUNdq5zbknwtnztiCa3ov
	CTeBP2X9kTrCUUBmYcf/0a6Nasril4Bd3hiFPM630Y88xPnELMZpClJgMR/FE8R71gQBgCy1TG8iL
	wI9rVZ5w==;
Received: from 23.248.197.178.dynamic.cust.swisscom.net ([178.197.248.23] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1smBB9-0001h7-Ux; Thu, 05 Sep 2024 14:01:35 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: shung-hsi.yu@suse.com,
	andrii@kernel.org,
	ast@kernel.org,
	kongln9170@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v2 6/6] selftests/bpf: Add a test case to write into .rodata
Date: Thu,  5 Sep 2024 14:01:28 +0200
Message-Id: <20240905120128.7322-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240905120128.7322-1-daniel@iogearbox.net>
References: <20240905120128.7322-1-daniel@iogearbox.net>
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


