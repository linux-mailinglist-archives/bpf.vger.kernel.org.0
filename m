Return-Path: <bpf+bounces-44350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 384B49C1E64
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 14:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE0F1B21396
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 13:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B41F1F4299;
	Fri,  8 Nov 2024 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWtRywY9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F03B1E907A;
	Fri,  8 Nov 2024 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073686; cv=none; b=F0N7p//AyjMsxDhxDcdRxCvM64WSYUKfLYFp7FmRRKWw9D1NnViT7mVILOqAKBVD7iQe7V5nJWyB8/eIh1AG8Y9fu5oRxzkxKjhiztOi3pDf5DJYcBSTD5OyZOaz7bU/cBeru6m2aySv8umF0rQN/mrE2ewuFYkR3Q2PnKJHvR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073686; c=relaxed/simple;
	bh=gsCOCREnwNJgKmtWRm8PgQYUqmPe8Fz7Zkgdxlt1OAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/8FmYU093s3ks4zMn5n4r0CVBTWN+DG/6b6cFStkv9UMy98WeUX+7kR6EB4egYLulgOCNof126PgMByBBpusadXVaw7+wITY0Dr0sTc/ipI4yKL31EupUXYkPz77rugG/3NryCkkOSKB30WGFAgSzhWxgb18c6QJhIZYD5CDH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWtRywY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BBBC4CECD;
	Fri,  8 Nov 2024 13:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731073686;
	bh=gsCOCREnwNJgKmtWRm8PgQYUqmPe8Fz7Zkgdxlt1OAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mWtRywY9Vqo9W/SjBgP09mpsNd3tJoosgrLTYQMoxoatB7PFmDZQGiU3fvkP8W2ry
	 IfRfQSc72eISlAE+AOqfZkLL83BAF2+SPcgy+l4uBoVzNUa8Vt+LJyLeeqxSSigSkv
	 v/AWMsokv/3nK+Q2ZxpOayoZrbVUHQ7NAam3RT0ZkEK7HtdV50NR1hW8GkZzdgLtrx
	 /yaluw+zZ6Ch+KmjvN7lPleN3s/Z569FkEO9xMz05TpmSfN8vkhaJt4FgFY8GhOblM
	 BTsFcYcXK3ns2hlpTYdPx1sOUhAYhJTymMT6YMCO1E5/+jVsKd1lTQfg2k/syVdj9m
	 G3IpTyJBCqErQ==
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
Subject: [PATCHv9 bpf-next 10/13] selftests/bpf: Add kprobe session verifier test for return value
Date: Fri,  8 Nov 2024 14:45:41 +0100
Message-ID: <20241108134544.480660-11-jolsa@kernel.org>
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

Making sure kprobe.session program can return only [0,1] values.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
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
2.47.0


