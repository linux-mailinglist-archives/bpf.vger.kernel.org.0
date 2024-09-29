Return-Path: <bpf+bounces-40525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D80C98977C
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 22:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161B71F2120F
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 20:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8844E17E00A;
	Sun, 29 Sep 2024 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grzzITYy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077F2178CC8;
	Sun, 29 Sep 2024 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727643566; cv=none; b=qyzgudQ71gX8J0OTBVere4KfSul3lB7S/JN4hfI6pMRlRYFcQspWWBydXN3+lhun3hGG1OeQwJnyG6zLf9MpLKimgn224ILUUOH1J8x5HlfeF+UBShMfbhcKkmrOTIdcOq1QEhr18hQ7FYoVYWKbtE5fEGZ2S2/XO/X4+7aU5dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727643566; c=relaxed/simple;
	bh=nDwwKIoORj0HBWMmH82W4I0Tpkb3tviaGj5oODCtCrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+yqBf0laC3aFdOFJufXungkjZH09ruw2kIr2FCrS9DoCIQ8uD/9oMxIKA/8SNlr0PrZ5TZAMqk9Z238EMcvN+W0WcRt/lWx3CiP8d9V4oy4fZO10DaSMQVSbW+y+2d5CLFz3SDVSVc1W/pMCUtrutVsTO3hml4YOEqXUqBbjNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grzzITYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEF2C4CEC5;
	Sun, 29 Sep 2024 20:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727643565;
	bh=nDwwKIoORj0HBWMmH82W4I0Tpkb3tviaGj5oODCtCrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=grzzITYyIgLjmrS1FMMC+i7xZdPZ5JAlLa26JMGu2xptA7ptJoFMFFMLtV/vLKkr7
	 fbkSkZQuWnV1evV8hNtq3ffr99KSQihyPLCfdsz14SbOm5g7ht3n7tNuVaYJWK/tgN
	 sDnfd09gUx7uTM7X7AOZ17sxAInygFaJ4dhhWHUpPYhYdLHkiED9C/aIT87MdgTodm
	 XncIdM6WGWnkfgc7GHfOc/DyKB/SLpM2E5+Mcoo65DoaX8+7oUNMau4TFGAxnlbyAH
	 z8qG9nEf++8N63H7Cjcxth5CeQpDrVzhTXx2FrlSA8a/TgYYhaia7qE7BsOwpLNflF
	 WGKukmQQQHl4w==
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
Subject: [PATCHv5 bpf-next 10/13] selftests/bpf: Add uprobe session verifier test for return value
Date: Sun, 29 Sep 2024 22:57:14 +0200
Message-ID: <20240929205717.3813648-11-jolsa@kernel.org>
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

Making sure uprobe.session program can return only [0,1] values.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        |  2 ++
 .../bpf/progs/uprobe_multi_verifier.c         | 31 +++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 284cd7fce576..e693eeb1a5a5 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -11,6 +11,7 @@
 #include "uprobe_multi_session.skel.h"
 #include "uprobe_multi_session_cookie.skel.h"
 #include "uprobe_multi_session_recursive.skel.h"
+#include "uprobe_multi_verifier.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "testing_helpers.h"
 #include "../sdt.h"
@@ -1246,4 +1247,5 @@ void test_uprobe_multi_test(void)
 		test_session_cookie_skel_api();
 	if (test__start_subtest("session_cookie_recursive"))
 		test_session_recursive_skel_api();
+	RUN_TESTS(uprobe_multi_verifier);
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c b/tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c
new file mode 100644
index 000000000000..fe49f2cb5360
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c
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
+SEC("uprobe.session")
+__success
+int uprobe_sesison_return_0(struct pt_regs *ctx)
+{
+	return 0;
+}
+
+SEC("uprobe.session")
+__success
+int uprobe_sesison_return_1(struct pt_regs *ctx)
+{
+	return 1;
+}
+
+SEC("uprobe.session")
+__failure
+__msg("At program exit the register R0 has smin=2 smax=2 should have been in [0, 1]")
+int uprobe_sesison_return_2(struct pt_regs *ctx)
+{
+	return 2;
+}
-- 
2.46.1


