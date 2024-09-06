Return-Path: <bpf+bounces-39138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CF996F60E
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 15:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC1E5B211CB
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 13:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669D11D0488;
	Fri,  6 Sep 2024 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ct00P1JR"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4501CF2B8
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630984; cv=none; b=Z1oRMYbAO3W6n9pDvAtp2f9INCZn22VUKTsYYxc42k9IqlcLp6JkQeYS1H7rXSqcN4IfKx7Z78yApX5M83212mSJlxdP5jyPOpBAdlq8+GDqLy0cD0jU2yWWoMnH2HsmpiWuqozbZpYmDujt+UYT3Xbcuz+V5MWVE8VjW5ycl5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630984; c=relaxed/simple;
	bh=VrXzW/2RAtqjLM4Fu9WGuZA10fCiBj22p0Fs+rEwe8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X/pbZmPh+c+wwc53iAVlWLNXfXTDl/X8FKzWxb4WnlDfpYX33ndDr+zB7vkO7NkFTszMizwwcPqu1eK6NMAB9+UnK3hzr+TLcjO6CDtsr0umQR+biy0Bt61/SNeQuXKC6UTkLd8XPITaUpKJlNbjHgYrFN+R7QO/146N5eDmuBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ct00P1JR; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=KFNLab3cIsER8Aljjj6meWCJpb+FGLpJck1PnjUyTcQ=; b=ct00P1JRv4OwVEWK+TXy0TWgf3
	7/LlHWXssDr7EuGIJjJ0y4h/m3vPChBX0aURxzUGlmAv2jwXZKsgcWSK18nkoNKpk5AqxHU5VZtKf
	ETCKtpGHWjaCghgTFI5k7+uXJLh4e1iOt9bUgNhpIGc1+UzH1+46AdPbHq3meRyXzU8B0IPoX9fu2
	7hRE5jGpmdB6v9rkmSPN0QbXIOjE5KA1Skn2gC6Mx6S/X0TeUEay0z6SJIDG3ftUxdqWPwe6p2CIb
	q564KAS+ncrmu1/rvwfhHo/yl5ik+3QOpRtoGg1LobDGkXAeJgKcwbhposP05+rES4sHgLF1V59YZ
	yVcuD0bA==;
Received: from 15.248.197.178.dynamic.cust.swisscom.net ([178.197.248.15] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1smZRe-0001zp-HS; Fri, 06 Sep 2024 15:56:14 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: shung-hsi.yu@suse.com,
	andrii@kernel.org,
	ast@kernel.org,
	kongln9170@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v4 8/8] selftests/bpf: Add a test case to write into .rodata
Date: Fri,  6 Sep 2024 15:56:08 +0200
Message-Id: <20240906135608.26477-8-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240906135608.26477-1-daniel@iogearbox.net>
References: <20240906135608.26477-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27390/Fri Sep  6 10:38:06 2024)

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
index df398e714dff..e26b5150fc43 100644
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
@@ -146,6 +147,7 @@ void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
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


