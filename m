Return-Path: <bpf+bounces-41631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DF699937F
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E711C22CC9
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116C21E4121;
	Thu, 10 Oct 2024 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdCho8uA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B6C15B0F2;
	Thu, 10 Oct 2024 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591146; cv=none; b=cC/7MHPOvZnUaxffOTYld3Ya1yV2Bi9tdjcEy/QQdl/6NWmSpLVWr9UjLwzoGbQx2+wA3ez9tCX582NxUu7whGPVKdScgtCBdK+24pY2fgHyl7qb23KBb65Sbq9iG1E+bOFhLxTUPXsHDb4/U/D84Nckl0PK5MLTF9Od1vaHBd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591146; c=relaxed/simple;
	bh=uSy+gDXv0e/W1F1L/aoCy9/PnJuM+20kIhQfaP/dM28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAFPlODblrd2DMFeOalpOeXuxk9pRM8AFcU+VQr9w6xiG+kok3G6o2waTmEX3dpEbPAuR/BzLdhKJeY7KNOvAsbsYuNbopoRLPk0wwwi9RViv/lZ9oQrBueOeY/pPQV4CMaZdYEKZhm3xtXfTtk9kQf01/VPNx6wgV4Kopr+TBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdCho8uA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23738C4CEC5;
	Thu, 10 Oct 2024 20:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728591146;
	bh=uSy+gDXv0e/W1F1L/aoCy9/PnJuM+20kIhQfaP/dM28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LdCho8uAmcGy7zbbFuPaDwPil3QAbB/vPEpz77CckmA+FOZT7KHHkkP6pOHDmNBiS
	 WIFwczjPvvcNbMU9zIrUH+9nfXxX7KOexYTKVk5I7Gl3h6ALG9PPQFx4hd/8cI8Yh9
	 51SXbDakdTA2METgJiwH3WLFHXDi1tRC/dg0plzAmNCaMSjmuB+H9G/UH270q9yxxR
	 I49M7vNFEirfsiJR8iWp2pw/rT0PP+RK+nHW9vz1K+c8ydjjPyRq1ZhXv/GXYr54Uy
	 4oxDQAoofWrc0qtqqvUey7AOLfXc89sa5qlzuuktP9gC6nyV2N9Zz/H8p+isCLQPxB
	 TOeXkbb9TcZkA==
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
Subject: [PATCHv6 bpf-next 12/16] selftests/bpf: Add kprobe session verifier test for return value
Date: Thu, 10 Oct 2024 22:09:53 +0200
Message-ID: <20241010200957.2750179-13-jolsa@kernel.org>
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
2.46.2


