Return-Path: <bpf+bounces-32068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 998B7906D2D
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 13:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3337828647F
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 11:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CE5146A9D;
	Thu, 13 Jun 2024 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="OIM4o0Sg"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8001465A7
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279606; cv=none; b=r7IHPkW0JId/VViqFV5ZjSPGcIsVxTbgJIjDhN6JUroBqqqT7vk558mA3RM5YECUMxIOxvo/wmJAvT6LVJgBqpOT4niRMf4cr46VLhMlUeb5xumEas9xZn+Nky4ETq7XBMe5uw18FAVpAdvZ/+yU+qNl3EsL24kJZY/Xf1NHOUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279606; c=relaxed/simple;
	bh=t5yCSYWOrRjz+NEyFxR2z1HBVcYrhunIORkWjVCWtMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FFDR5dltPUXCnPAKjShI8itzAUcFWI+Tjs1j2FYvXb5H803rhBh8cC+vlFlUmrqvKKkwCjsW34ZfA+uU+DkPCmzC3oxGTM3cU5LuZqEPkpKWlpn1hUNbzOr47JMJUle2jFmzKOpVFy2O/emDpPavQ2a83+h6+YhP2pnBgjN7YA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=OIM4o0Sg; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=LM5Yisb5JgoNf9shukkLBkpqcmde+coRvZty7DN3vU0=; b=OIM4o0SgEAdwZNJ/gE3qWxq0cm
	3W23bgPwGKT+JVjt6xBpUyZbHyTV7IWKF0YjHBp75tGCpNBCiHvX7SzBnFzzpGbWS++WV8/GkoP3q
	WfqYLC4uWL8dbRPDkEugVz9p2fOYGlj8mKBA4865X8SomUmTwsMAZiJvG+yTsf+iw4iuC1cz6897N
	7lEv1SioPsbGsKEJjuq539bwqRvQzoXzHRwOqC/ELpk82Y00enE9byDvCqFn3J5UiBf3TUuAL8FNW
	8Ymi70P+4tde3AKp8NGbnSz13fXx9oEy58S8bKJ+7nv3wCWgm+MJxwwd+ZMGXFadrEhrdtOmaiA9S
	6JlEKQNw==;
Received: from 34.249.197.178.dynamic.cust.swisscom.net ([178.197.249.34] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sHj18-000G9t-0S; Thu, 13 Jun 2024 13:53:22 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	jjlopezjaimez@google.com,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 3/3] selftests/bpf: Add test coverage for reg_set_min_max handling
Date: Thu, 13 Jun 2024 13:53:10 +0200
Message-Id: <20240613115310.25383-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240613115310.25383-1-daniel@iogearbox.net>
References: <20240613115310.25383-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27305/Thu Jun 13 10:33:25 2024)

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
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_or_jmp32_k.c | 41 +++++++++++++++++++
 2 files changed, 43 insertions(+)
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
index 000000000000..f37713a265ac
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_or_jmp32_k.c
@@ -0,0 +1,41 @@
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
+	if w0 != 0x7ffffffd goto l1;			\
+	r0 = 1;						\
+	exit;						\
+l3:							\
+	r0 = 5;						\
+	*(u64*)(r0 - 8) = r0;				\
+	exit;						\
+l2:							\
+	w0 -= 0xe;					\
+	if w0 == 1 goto l3;				\
+	r0 = 4;						\
+	exit;						\
+l1:							\
+	w0 -= 0x7ffffff0;				\
+	if w0 s>= 0xe goto l2;				\
+	r0 = 3;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


