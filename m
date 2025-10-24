Return-Path: <bpf+bounces-72146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35726C07C31
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 20:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856A93A72FA
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 18:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2BC348467;
	Fri, 24 Oct 2025 18:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWIVq2Y6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228D6347FEE;
	Fri, 24 Oct 2025 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330564; cv=none; b=OTEMeyU79DupKIYGke+MAsFk4dfSYynwCq+hTa5pAIzkteSpBO0s7YDQ1IxNgauQEv0gATQbhHNpnYwzFsGsAZQJU/gseoqgy3SWqFL49ktCCXvKC5+9AuI2bkgWEZxxBnQ+E/mBDNdgmLPM50EC0JaY9xxyVcM4HU5ZDENtlIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330564; c=relaxed/simple;
	bh=FdKjfQUkbsHQuQuH4GP6RLNRxDDenqqoHQY/8v93xLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJ7oXAcpX0AWtQ6Q1nsgBmIbFM3uqYMdsuwEoYy82Bc8V/Qmf35JMsHo1y4XQhPdv5YocwsR1hRPyaGcZDwn+UxwNNsLp1fgqY4AIdlP7PFtwyWTMzlcCBhBG6aPJtsunur8V5uVYzA5zbG7CnoQuHa1YOVhhHYquvtJmlBbdP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWIVq2Y6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A52C4CEF1;
	Fri, 24 Oct 2025 18:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761330563;
	bh=FdKjfQUkbsHQuQuH4GP6RLNRxDDenqqoHQY/8v93xLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KWIVq2Y6kDUNi1CQ1Gg9p++ZMLhojbwixzkuQ1gL+MpZQQOMq/BxZreOIsHO9KWmI
	 7hd7+t9uQxQBPDnpucWWJKAlvNYYK4TstqSlnAwXv97L+M7WP0tQUFfCMIDJ/x8eQP
	 L+FWHESed2jDsGId4ZXnpXl6nvHjxfCKk7KdrFFN1x/hKPPYgSODjQvB5/HMUa6nQ+
	 uKwyeOtLyaMRn+9sZs9zyI91JJqui0KvM5sH/YQSYahtF/5prm5iYxny7VYYh9AtUV
	 7rGjYev/6ttJSMNFDIwXwCU3HVA0yFIxDnsYtvCiQJYPvXqOqZS9eKfHN7fm4Noxi+
	 g5y1GDeFm9xxw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	rostedt@goodmis.org,
	andrey.grodzovsky@crowdstrike.com,
	mhiramat@kernel.org,
	kernel-team@meta.com,
	olsajiri@gmail.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf 3/3] selftests/bpf: Add tests for livepatch + bpf trampoline
Date: Fri, 24 Oct 2025 11:29:01 -0700
Message-ID: <20251024182901.3247573-4-song@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024182901.3247573-1-song@kernel.org>
References: <20251024182901.3247573-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both livepatch and BPF trampoline use ftrace. Special attention is needed
when livepatch and fexit program touch the same function at the same
time, because livepatch updates a kernel function and the BPF trampoline
need to call into the right version of the kernel function.

Use samples/livepatch/livepatch-sample.ko for the test.

The test covers two cases:
  1) When a fentry program is loaded first. This exercises the
     modify_ftrace_direct code path.
  2) When a fentry program is loaded first. This exercises the
     register_ftrace_direct code path.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/config            |   3 +
 .../bpf/prog_tests/livepatch_trampoline.c     | 107 ++++++++++++++++++
 .../bpf/progs/livepatch_trampoline.c          |  30 +++++
 3 files changed, 140 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
 create mode 100644 tools/testing/selftests/bpf/progs/livepatch_trampoline.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 70b28c1e653e..f2a2fd236ca8 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -50,6 +50,7 @@ CONFIG_IPV6_SIT=y
 CONFIG_IPV6_TUNNEL=y
 CONFIG_KEYS=y
 CONFIG_LIRC=y
+CONFIG_LIVEPATCH=y
 CONFIG_LWTUNNEL=y
 CONFIG_MODULE_SIG=y
 CONFIG_MODULE_SRCVERSION_ALL=y
@@ -111,6 +112,8 @@ CONFIG_IP6_NF_FILTER=y
 CONFIG_NF_NAT=y
 CONFIG_PACKET=y
 CONFIG_RC_CORE=y
+CONFIG_SAMPLES=y
+CONFIG_SAMPLE_LIVEPATCH=m
 CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
 CONFIG_SYN_COOKIES=y
diff --git a/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c b/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
new file mode 100644
index 000000000000..72aa5376c30e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include "testing_helpers.h"
+#include "livepatch_trampoline.skel.h"
+
+static int load_livepatch(void)
+{
+	char path[4096];
+
+	/* CI will set KBUILD_OUTPUT */
+	snprintf(path, sizeof(path), "%s/samples/livepatch/livepatch-sample.ko",
+		 getenv("KBUILD_OUTPUT") ? : "../../../..");
+
+	return load_module(path, env_verbosity > VERBOSE_NONE);
+}
+
+static void unload_livepatch(void)
+{
+	/* Disable the livepatch before unloading the module */
+	system("echo 0 > /sys/kernel/livepatch/livepatch_sample/enabled");
+
+	unload_module("livepatch_sample", env_verbosity > VERBOSE_NONE);
+}
+
+static void read_proc_cmdline(void)
+{
+	char buf[4096];
+	int fd, ret;
+
+	fd = open("/proc/cmdline", O_RDONLY);
+	if (!ASSERT_OK_FD(fd, "open /proc/cmdline"))
+		return;
+
+	ret = read(fd, buf, sizeof(buf));
+	if (!ASSERT_GT(ret, 0, "read /proc/cmdline"))
+		goto out;
+
+	ASSERT_OK(strncmp(buf, "this has been live patched", 26), "strncmp");
+
+out:
+	close(fd);
+}
+
+static void __test_livepatch_trampoline(bool fexit_first)
+{
+	struct livepatch_trampoline *skel = NULL;
+	int err;
+
+	skel = livepatch_trampoline__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		goto out;
+
+	skel->bss->my_pid = getpid();
+
+	if (!fexit_first) {
+		/* fentry program is loaded first by default */
+		err = livepatch_trampoline__attach(skel);
+		if (!ASSERT_OK(err, "skel_attach"))
+			goto out;
+	} else {
+		/* Manually load fexit program first. */
+		skel->links.fexit_cmdline = bpf_program__attach(skel->progs.fexit_cmdline);
+		if (!ASSERT_OK_PTR(skel->links.fexit_cmdline, "attach_fexit"))
+			goto out;
+
+		skel->links.fentry_cmdline = bpf_program__attach(skel->progs.fentry_cmdline);
+		if (!ASSERT_OK_PTR(skel->links.fentry_cmdline, "attach_fentry"))
+			goto out;
+	}
+
+	read_proc_cmdline();
+
+	ASSERT_EQ(skel->bss->fentry_hit, 1, "fentry_hit");
+	ASSERT_EQ(skel->bss->fexit_hit, 1, "fexit_hit");
+out:
+	livepatch_trampoline__destroy(skel);
+}
+
+void test_livepatch_trampoline(void)
+{
+	int retry_cnt = 0;
+
+retry:
+	if (load_livepatch()) {
+		if (retry_cnt) {
+			ASSERT_OK(1, "load_livepatch");
+			goto out;
+		}
+		/*
+		 * Something else (previous run of the same test?) loaded
+		 * the KLP module. Unload the KLP module and retry.
+		 */
+		unload_livepatch();
+		retry_cnt++;
+		goto retry;
+	}
+
+	if (test__start_subtest("fentry_first"))
+		__test_livepatch_trampoline(false);
+
+	if (test__start_subtest("fexit_first"))
+		__test_livepatch_trampoline(true);
+out:
+	unload_livepatch();
+}
diff --git a/tools/testing/selftests/bpf/progs/livepatch_trampoline.c b/tools/testing/selftests/bpf/progs/livepatch_trampoline.c
new file mode 100644
index 000000000000..15579d5bcd91
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/livepatch_trampoline.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+int fentry_hit;
+int fexit_hit;
+int my_pid;
+
+SEC("fentry/cmdline_proc_show")
+int BPF_PROG(fentry_cmdline)
+{
+	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	fentry_hit = 1;
+	return 0;
+}
+
+SEC("fexit/cmdline_proc_show")
+int BPF_PROG(fexit_cmdline)
+{
+	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	fexit_hit = 1;
+	return 0;
+}
-- 
2.47.3


