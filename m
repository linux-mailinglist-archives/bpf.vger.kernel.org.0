Return-Path: <bpf+bounces-41630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 588F099937D
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052651F25241
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CF31E8820;
	Thu, 10 Oct 2024 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXF+l5Kg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA471CF28E;
	Thu, 10 Oct 2024 20:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591135; cv=none; b=ZMEtFbqrBTUlopSXNkZFb2EjOld0XrCwH0doPj/S6vZaGcLqBGT+lf2ODcFRPIWxlKiqnbXMGjPbD5wzyGx01UAynrCam1cOaG/zefmYGk7wX04WH3n683G/Wgn/AjNv0i0T8mC+uFguKl9kx41OqaMZih+BNJFmY2oGUMbetb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591135; c=relaxed/simple;
	bh=2ZRqx+7SKkGoE3vDYuntBskDrfcteLP+fK9qAu1N+7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rC01sEY0nW2PoVYQ8C9iQSGgC8M0q/L6Q6N0DUmbQOF9vEpqsZ35p/ySW+2HeHoUp5pOlLWGbZc1KF0fEN9VWMLQNjVxB3TEZirg2c1UCykZMJBO01DLVOyi/Qnp1NkHhlzN8FJkQJ8KfJM7IdiJ4syjrGR0eIfTQo3g1UeW8l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXF+l5Kg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88241C4CEC5;
	Thu, 10 Oct 2024 20:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728591134;
	bh=2ZRqx+7SKkGoE3vDYuntBskDrfcteLP+fK9qAu1N+7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IXF+l5KgHIrWC88gjz0MOsAVYL07tDV/cbMfk7Ii/V1dmwY8+YSeZVqlorA50OTk/
	 ewuxf8F0JZnR6yhf4E/JTTKajsTAztSR6+FDfXaNZGohYy6kDHtOMdZIORx5JIHjGQ
	 d6avEIl63Z05h3l6iGAbTbm38GebKNKcYgbYfSK92FFZ0TQ/84vERu2pWsLPcY3xiT
	 qEFpJGO+x6e3MKVug4xjibBiKE/lHhV+V2EBjppYiBxHN5D6iID6R88MFzIzBFmcSI
	 YbsfKH6CIC3gqe8X8zMGh1y2nCuWy3aU/UwzorH0qSZVkISks4PdxLOY1ArA0a9wrb
	 VJQXWklGZnZmA==
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
Subject: [PATCHv6 bpf-next 11/16] selftests/bpf: Add uprobe session verifier test for return value
Date: Thu, 10 Oct 2024 22:09:52 +0200
Message-ID: <20241010200957.2750179-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010200957.2750179-1-jolsa@kernel.org>
References: <20241010200957.2750179-1-jolsa@kernel.org>
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
2.46.2


