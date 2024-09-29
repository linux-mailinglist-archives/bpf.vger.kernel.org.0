Return-Path: <bpf+bounces-40526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FC698977E
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 23:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E670C1F216ED
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 21:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3004D17E00F;
	Sun, 29 Sep 2024 20:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVbrTRuY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FE9175D32;
	Sun, 29 Sep 2024 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727643577; cv=none; b=YVj/JRAVc9qkRdgti3xNGxARA44WmlNSWgDXV1db7jJ9g0n+bMgYRrxjBlfcrfJbEPNQOmCZF9hzMikx8Y/p8WiIuIcB+HoWhQan7aa3PKiloSgfOMRfF1e8ImfX4Xb0t8mDN5KLXeXrR611wGETiut6HIOZh0LtFMGL4xXY/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727643577; c=relaxed/simple;
	bh=iytPBV/coYs8uklN481sCB6sr+lO7xPubDoHnHmKQm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJX5u9vvROJB1P2X/DzbHz/Uw5Qz7j25cbH1Bdpy7MKDs2LqoLed1ndnSwR1fbHCA8anGIN43Cz7rfcJgIBryYfONuuolcIN3GKJ6YxrALvEKvdrfscYd2GWTPqp7hSsKotHAK1qC8gONbE47mgfaTHpKhcu+rn2OnAIxtk/0v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVbrTRuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7A2C4CEC5;
	Sun, 29 Sep 2024 20:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727643577;
	bh=iytPBV/coYs8uklN481sCB6sr+lO7xPubDoHnHmKQm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVbrTRuYkpu0qtaqULHFtRDkT4JV3LTuPtF+JA1JO45W02jTV4k3iJ1oyIuuaYWAZ
	 INgOpqb387zxBxke0rhi15UM/CZpRhQg+/qE5BW5U4IykMrmDKoFfF5DCzJrVba9yN
	 vEiIVg5L3KvjDi/yz7rg1FpcqZFPhmAEIk9JyyZp+P9PsfqRPoSrnjd2R5EHugIQ3z
	 jcTVgo9thAqsvNa3SBmjxjwkz+rSZZB6yntPax+IXX8o2blCewHjTrtFU3vAbTLp0I
	 2TNfCuVwveLqheABw+jUk/KzRLUx46ErNpW+032vW/tfV6Ov6Iqchp6Hmtc78pDKto
	 AHwzlinwqK1wA==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv5 bpf-next 11/13] selftests/bpf: Add kprobe session verifier test for return value
Date: Sun, 29 Sep 2024 22:57:15 +0200
Message-ID: <20240929205717.3813648-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240929205717.3813648-1-jolsa@kernel.org>
References: <20240929205717.3813648-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Making sure kprobe.session program can return only [0,1] values.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/kprobe_multi_test.c        |  2 ++
 .../bpf/progs/kprobe_multi_verifier.c         | 31 +++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_verifier.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 960c9323d1e0..66ab1cae923e 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -6,6 +6,7 @@
 #include "kprobe_multi_override.skel.h"
 #include "kprobe_multi_session.skel.h"
 #include "kprobe_multi_session_cookie.skel.h"
+#include "kprobe_multi_verifier.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "bpf/hashmap.h"
 
@@ -764,4 +765,5 @@ void test_kprobe_multi_test(void)
 		test_session_skel_api();
 	if (test__start_subtest("session_cookie"))
 		test_session_cookie_skel_api();
+	RUN_TESTS(kprobe_multi_verifier);
 }
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_verifier.c b/tools/testing/selftests/bpf/progs/kprobe_multi_verifier.c
new file mode 100644
index 000000000000..288577e81deb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_verifier.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/usdt.bpf.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+
+SEC("kprobe.session")
+__success
+int kprobe_session_return_0(struct pt_regs *ctx)
+{
+	return 0;
+}
+
+SEC("kprobe.session")
+__success
+int kprobe_session_return_1(struct pt_regs *ctx)
+{
+	return 1;
+}
+
+SEC("kprobe.session")
+__failure
+__msg("At program exit the register R0 has smin=2 smax=2 should have been in [0, 1]")
+int kprobe_session_return_2(struct pt_regs *ctx)
+{
+	return 2;
+}
-- 
2.46.1


