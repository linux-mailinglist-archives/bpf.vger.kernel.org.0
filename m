Return-Path: <bpf+bounces-44349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 944E59C1E62
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 14:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22092B247A2
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 13:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E491F12FD;
	Fri,  8 Nov 2024 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhwDzYri"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B721EBA1E;
	Fri,  8 Nov 2024 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073674; cv=none; b=bvKs/KmpJWhjrZxVqiHWgJL2DSe57SuMvMV2fiB0/XFJbxb3voxhwp/zCcTBdnB2X7r+VUav/idM7kNsSFL35kgYAA2ah7jnF3JnAQtPQp87OB6xJf5x+x+HIysydzCAf5qavtoyqRfnIGTXs+P0y0hqWaR84DuhgzhKJrnhApw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073674; c=relaxed/simple;
	bh=z2DCLT1FLhrnevYpBg3PNT7Zgn1AasGN0zBJOW7Prv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2rsBWtcmKaGHphwTBnLluDZF5A6GWEGa+CnoDqi8JauKQnEgoGygcZ27+XgoTqj42Il06FQOtagEv7dWSewsPLrV78vuTfEw7RnePxGDnEYH6UsUe1zBs62FzS7zsZ2JffzJmwUn3XXMjBuJ+FqHKj5r55Vz/y4RRVIxhGQ6ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhwDzYri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650D1C4CECD;
	Fri,  8 Nov 2024 13:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731073674;
	bh=z2DCLT1FLhrnevYpBg3PNT7Zgn1AasGN0zBJOW7Prv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rhwDzYriXgz5optmfGpishHClAwOp2Xe3aJkSjuSA7EwFmO41jBfAxCJEPduBdI03
	 D7wLwjXfUJXD0LMGUhv1/bgsRBtxV8SCVu+E52FyY21DNxm4XSH96fXGovQ776ID2U
	 B/NYqCLjXNPPd/YYxib6CPghEVqccMBWvmArdwgs1kFvRW6b9Y5E+AEM3uGWMUkRU2
	 9wBkzFfPKdrxydh8CswjLgi+ojCBHNA/77OEsMzM69vpApvnAjNMu7NfEeiwa6n9gA
	 wtOTk7WjskioARZZFvu3UKi+uaRwy6hVW6JNDRtveXc2waKOdr9Qa20HI7B+gm2IVp
	 u05q2upyghhpQ==
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
Subject: [PATCHv9 bpf-next 09/13] selftests/bpf: Add uprobe session verifier test for return value
Date: Fri,  8 Nov 2024 14:45:40 +0100
Message-ID: <20241108134544.480660-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108134544.480660-1-jolsa@kernel.org>
References: <20241108134544.480660-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Making sure uprobe.session program can return only [0,1] values.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        |  2 ++
 .../bpf/progs/uprobe_multi_verifier.c         | 31 +++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index b9448fb63a19..5dad31d1b606 100644
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
@@ -1248,4 +1249,5 @@ void test_uprobe_multi_test(void)
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
2.47.0


