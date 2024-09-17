Return-Path: <bpf+bounces-40034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAA297AD26
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 10:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1A3D1C2179F
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 08:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4302815358F;
	Tue, 17 Sep 2024 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZS//yoc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35D51531DB;
	Tue, 17 Sep 2024 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563166; cv=none; b=TqROxczg3dmmVG2Xw/XckShBGMueMFozjf0LqM6mv8rhyCXGd5Yc2LOGfD7PqD/nbAyUTkY9kvcUvhIaoaG9XOzQ8ITn8iTNrbZojGSZy8H98RNc6ib1clVVN9/ULG0Odt+vXFIwUm9tYfZzHaify8+ZKDsL5yFaJzlqLQLN7ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563166; c=relaxed/simple;
	bh=T3RMf23E4F/2hFMp057R2xW1km127UKxzkjsQAUmI2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PD6MgkdqPXx6jM/EurRZmw4Hy6oYEo2ZhEvuMUU1JvNf7SCdUvU7qaXbj9KPZVcPyTbm5EOqauXhbQ+atXp6Xpx6QFpRWDUvSuLysklQlyc5h/JHRfHVcdEZfGqpS+ZMzX7Od/lOXYsND6f0CgSoC8mZEIdNlvG/XA1Cj3cPWL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZS//yoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE47C4CEC5;
	Tue, 17 Sep 2024 08:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726563166;
	bh=T3RMf23E4F/2hFMp057R2xW1km127UKxzkjsQAUmI2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XZS//yocn1Pf4rp0yfugVhRLXdZ09IDB31UNchDvzVGkbIdH1az6Ye5GxDmskttLN
	 cWjxvleN+xvzVk7kP+dzVM3H2nhZImsOpREvQVk5abYnquR2bwxDDFYg/a4RipC1XZ
	 QjinVG06hVkpgTnduHj/+Cbc03+nBK/GUJVrYWcEzT9T/zEsd/LKBA/WXn03zx47BY
	 09ZUScz2V9wL9WC8saoERqXWl92QhOl5yjEF+sjtKckQ30b5K1RWVAFXOiteYUKOF6
	 cFa2G7twREbQ4G5ZcLwDAFd9Qc5Z8NWXaANhLUqx7mdUHqa8FTOQ8Z1wcEycnu+RX4
	 +q9kCuIQCqwtA==
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
Subject: [PATCHv4 11/14] selftests/bpf: Add uprobe session verifier test for return value
Date: Tue, 17 Sep 2024 10:50:21 +0200
Message-ID: <20240917085024.765883-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917085024.765883-1-jolsa@kernel.org>
References: <20240917085024.765883-1-jolsa@kernel.org>
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
index 39d505f27784..210cdb620ee0 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -9,6 +9,7 @@
 #include "uprobe_multi_session.skel.h"
 #include "uprobe_multi_session_cookie.skel.h"
 #include "uprobe_multi_session_recursive.skel.h"
+#include "uprobe_multi_verifier.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "testing_helpers.h"
 #include "../sdt.h"
@@ -838,4 +839,5 @@ void test_uprobe_multi_test(void)
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
2.46.0


