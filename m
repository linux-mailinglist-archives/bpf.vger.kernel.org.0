Return-Path: <bpf+bounces-9453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F40DD797D25
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 22:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA383281792
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 20:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71B91426F;
	Thu,  7 Sep 2023 20:07:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3683A14265
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 20:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6DEC433C8;
	Thu,  7 Sep 2023 20:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694117228;
	bh=orlObO315+MAh+KOyYTkWS15jAMax3LMTI4lLd7x110=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yce+vRSnmaCObZrMYZrXRnuvPH3I6jgqYr/D7ObqqhBg28pu8dBJp9Jnizr8LLItP
	 RXUPoSuRFsPnaUbDwi3qX9GDptEh+rlsgziwD6SC+b9oK9e/B0AWdwsY5whYRpXZWg
	 7jRoicfAHLObzhrcBCnhMk8cJa1yVBmd3HQek4FnlW0bqWxJ/RIoOSbQIkc2wRqsBI
	 Ob5oTDjJWXYBQbF6d7fZyn0FZbuQcXQnbWf2pECkLpy9AotHpsAvt+8XL6N8Wlnpz9
	 4IzxXXLqEK1I16iSgzRdHjNeFB0T7+1Cp/DHWScsW67ABxNUC27ddh1X9Ip8D5AcHH
	 LWEyxDCcXih/A==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Djalal Harouni <tixxdz@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: Add kprobe_multi override test
Date: Thu,  7 Sep 2023 22:06:52 +0200
Message-ID: <20230907200652.926951-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907200652.926951-1-jolsa@kernel.org>
References: <20230907200652.926951-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test that tries to attach program with bpf_override_return
helper to function not within error injection list.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/kprobe_multi_test.c        | 37 +++++++++++++++++++
 .../bpf/progs/kprobe_multi_override.c         | 13 +++++++
 2 files changed, 50 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_override.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 179fe300534f..e05477b210a5 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -3,6 +3,7 @@
 #include "kprobe_multi.skel.h"
 #include "trace_helpers.h"
 #include "kprobe_multi_empty.skel.h"
+#include "kprobe_multi_override.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "bpf/hashmap.h"
 
@@ -453,6 +454,40 @@ static void test_kprobe_multi_bench_attach(bool kernel)
 	}
 }
 
+void test_attach_override(void)
+{
+	struct kprobe_multi_override *skel = NULL;
+	struct bpf_link *link = NULL;
+
+	skel = kprobe_multi_override__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "kprobe_multi_empty__open_and_load"))
+		goto cleanup;
+
+	/* The test_override calls bpf_override_return so it should fail
+	 * to attach to bpf_fentry_test1 function, which is not on error
+	 * injection list.
+	 */
+	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_override,
+						     "bpf_fentry_test1", NULL);
+	if (!ASSERT_ERR_PTR(link, "override_attached_bpf_fentry_test1")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	/* The should_fail_bio function is on error injection list,
+	 * attach should succeed.
+	 */
+	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_override,
+						     "should_fail_bio", NULL);
+	if (!ASSERT_OK_PTR(link, "override_attached_should_fail_bio"))
+		goto cleanup;
+
+	bpf_link__destroy(link);
+
+cleanup:
+	kprobe_multi_override__destroy(skel);
+}
+
 void serial_test_kprobe_multi_bench_attach(void)
 {
 	if (test__start_subtest("kernel"))
@@ -480,4 +515,6 @@ void test_kprobe_multi_test(void)
 		test_attach_api_syms();
 	if (test__start_subtest("attach_api_fails"))
 		test_attach_api_fails();
+	if (test__start_subtest("attach_override"))
+		test_attach_override();
 }
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_override.c b/tools/testing/selftests/bpf/progs/kprobe_multi_override.c
new file mode 100644
index 000000000000..28f8487c9059
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_override.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("kprobe.multi")
+int test_override(struct pt_regs *ctx)
+{
+	bpf_override_return(ctx, 123);
+	return 0;
+}
-- 
2.41.0


