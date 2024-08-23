Return-Path: <bpf+bounces-37993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E14895D934
	for <lists+bpf@lfdr.de>; Sat, 24 Aug 2024 00:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93BE5B215DE
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 22:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F2419414A;
	Fri, 23 Aug 2024 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="gooV7xME"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B2D193412
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724451652; cv=none; b=gf2QeSvdyXeTbjdOzUq9omGhifUAuffZC6jdl1TnxJenq7e7eguKBgjSGTZ0RAwCeHyrHN3IrB7Gz25RNZ5a7d6HDcMA99aCxkHuuYx7M6CMF2pmbp8FyQJhKal9ZP+PnH/HsH0mM+VtsnUqtutt39M4NN/XK82ONSTRD8UGvJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724451652; c=relaxed/simple;
	bh=QK8MK39HiFkZC9IdDGeoH6mRwoWDNkw7grcxl9vDWYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XsYVTM7EwPYNwY2BwUyXYqlbsAUnzn+r/feepfPu1+3yRk54j5vlNFfXhyY7SkvQ/TdpQIf0tPjCpvYlsrBM9eD7gDEXEhH21VOqnnA4bSprGjX9dGvgkYnq1EF1U5wth0yaVb5aT+KLrSYyhhncRPuEjhhLx5xJ3e+cSy18Koo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=gooV7xME; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=y0Oj4oQJjwroW1spdDm2zx9giylR4ILGPim9m4wm28g=; b=gooV7xMEj3m44BSokYiPjxaHrO
	EqXqVNdXKrm5x+OqlrlrXWWEmxeJeP/5lgs5xsFu+br7YOxSQbLYf4FTMwpvIh5Z8UNPGUhQBAIgO
	0CgjVwcXB/YMsQHfGv/mLtqYLTtwvp7KRhL+lNlP8Lk+nRSwxhyktmQC/awUMUpV5Fhy/HhsXAWSS
	rqDqHAtqn3w91IMqNCbdZ1Ceijmuut1mQh2obUW55FXNYfoIfjkPqB8G+wlMj+LAPe6DvRy/rVK4d
	l6oc+PfrEGR0org6sXRejcSY7hzfLCiEjGrNsBU1biZW2i2NRPOXw/fbQgeXVDTkoRMqu9mCsXtJm
	8/hbj/ig==;
Received: from 23.248.197.178.dynamic.cust.swisscom.net ([178.197.248.23] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1shceF-000FrE-RP; Sat, 24 Aug 2024 00:20:47 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: kongln9170@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 4/4] selftests/bpf: Add a test case to write into .rodata
Date: Sat, 24 Aug 2024 00:20:33 +0200
Message-Id: <20240823222033.31006-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240823222033.31006-1-daniel@iogearbox.net>
References: <20240823222033.31006-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27376/Fri Aug 23 10:47:45 2024)

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
---
 .../selftests/bpf/prog_tests/tc_links.c       |  1 +
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_const.c      | 42 +++++++++++++++++++
 3 files changed, 45 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_const.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_links.c b/tools/testing/selftests/bpf/prog_tests/tc_links.c
index 1af9ec1149aa..92c647dfd6f1 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_links.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_links.c
@@ -9,6 +9,7 @@
 #define ping_cmd "ping -q -c1 -w1 127.0.0.1 > /dev/null"
 
 #include "test_tc_link.skel.h"
+#include "test_const.skel.h"
 
 #include "netlink_helpers.h"
 #include "tc_helpers.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 9dc3687bc406..c0cb1a145274 100644
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
@@ -140,6 +141,7 @@ void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
 void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_retcode); }
 void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
 void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_storage); }
+void test_verifier_const(void)                { RUN(verifier_const); }
 void test_verifier_const_or(void)             { RUN(verifier_const_or); }
 void test_verifier_ctx(void)                  { RUN(verifier_ctx); }
 void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_const.c b/tools/testing/selftests/bpf/progs/verifier_const.c
new file mode 100644
index 000000000000..81302d9738fa
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
+const long foo = 42;
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


