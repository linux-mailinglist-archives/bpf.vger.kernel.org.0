Return-Path: <bpf+bounces-28745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BBB8BD871
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 02:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D678282C25
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 00:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE864653;
	Tue,  7 May 2024 00:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W75IATbt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32992389
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715040839; cv=none; b=d6Y5Qad7wH2RK5s0gWgKN1AXtzG/7CL4XGpTzLHG/16ZpMRY3aIW8eilfjPj3l6t88Ke9uALnlzgyWbwB9hGHrHubYstZjDfJgGdc1yOV/wOtXpbInONlmXgovEksh729idQg6idxRSrtmAmS+JsPTRQn/5R3XyKsBsJ2b6GGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715040839; c=relaxed/simple;
	bh=NadnHBQ3TBYENzaBm12S5ll5QN2eMBpcavPtAqhYpw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5/+UdfInPYI/1PkM3dwPblPiVFmS0RiCCuYZpjJMHzyhnWg2gy5NRIZBsMWUrP1Rm4FUz4bwWEK2ZjT4qYPEo2L+Mn/UKhQKFOSF8x5y2cfBxVEFmUxssUJddw5fIUgKzpRRt4iIVmjLpJyNRzqqwPM2c8aBDXxJ+xzz+rg/bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W75IATbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9817EC116B1;
	Tue,  7 May 2024 00:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715040838;
	bh=NadnHBQ3TBYENzaBm12S5ll5QN2eMBpcavPtAqhYpw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W75IATbtvaG84uUeGmehk/H05lw7AmXucrmfhkGwhSnih9Vl6UFAKfrFNkkz6pSjJ
	 4QPmQXONZiyx2+7/N7Q5Eq68Vx6lVnoOuliViLi4AAJwcat1RFGTFHeo8MOKDO6qRu
	 tVcmgnoDONn/bDsgC81LS9i6wArEGmQKenm5KVBzhwSFhFZhvWDzFFtOuH5fwM7mog
	 yAdFfv/vDYo4vxhM+l4IZAGxwDd1pHuE2PDV0HDAwAFmXelI2pUaz3Cbkavf7azorp
	 jxT9B4MgAnbig2UPP+WZm/YMT5dnis/3EJOqpFO05YOygWt4tYBWEDpZJrrumPDicm
	 MDx2FTfC5KBnw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 6/7] selftests/bpf: validate struct_ops early failure detection logic
Date: Mon,  6 May 2024 17:13:34 -0700
Message-ID: <20240507001335.1445325-7-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507001335.1445325-1-andrii@kernel.org>
References: <20240507001335.1445325-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple test that validates that libbpf will reject isolated
struct_ops program early with helpful warning message.

Also validate that explicit use of such BPF program through BPF skeleton
after BPF object is open won't trigger any warnings.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/test_struct_ops_module.c   | 45 +++++++++++++++++++
 .../bpf/progs/struct_ops_forgotten_cb.c       | 19 ++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_forgotten_cb.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index f3c61ebad323..3785b648c8ad 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -5,6 +5,7 @@
 
 #include "struct_ops_module.skel.h"
 #include "struct_ops_nulled_out_cb.skel.h"
+#include "struct_ops_forgotten_cb.skel.h"
 
 static void check_map_info(struct bpf_map_info *info)
 {
@@ -199,6 +200,48 @@ static void test_struct_ops_nulled_out_cb(void)
 	struct_ops_nulled_out_cb__destroy(skel);
 }
 
+/* validate that libbpf generates reasonable error message if struct_ops is
+ * not referenced in any struct_ops map
+ */
+static void test_struct_ops_forgotten_cb(void)
+{
+	struct struct_ops_forgotten_cb *skel;
+	char *log;
+	int err;
+
+	skel = struct_ops_forgotten_cb__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	start_libbpf_log_capture();
+
+	err = struct_ops_forgotten_cb__load(skel);
+	if (!ASSERT_ERR(err, "skel_load"))
+		goto cleanup;
+
+	log = stop_libbpf_log_capture();
+	ASSERT_HAS_SUBSTR(log,
+			  "prog 'test_1_forgotten': SEC(\"struct_ops\") program isn't referenced anywhere, did you forget to use it?",
+			  "libbpf_log");
+	free(log);
+
+	struct_ops_forgotten_cb__destroy(skel);
+
+	/* now let's programmatically use it, we should be fine now */
+	skel = struct_ops_forgotten_cb__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->struct_ops.ops->test_1 = skel->progs.test_1_forgotten; /* not anymore */
+
+	err = struct_ops_forgotten_cb__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+cleanup:
+	struct_ops_forgotten_cb__destroy(skel);
+}
+
 void serial_test_struct_ops_module(void)
 {
 	if (test__start_subtest("test_struct_ops_load"))
@@ -209,5 +252,7 @@ void serial_test_struct_ops_module(void)
 		test_struct_ops_incompatible();
 	if (test__start_subtest("test_struct_ops_null_out_cb"))
 		test_struct_ops_nulled_out_cb();
+	if (test__start_subtest("struct_ops_forgotten_cb"))
+		test_struct_ops_forgotten_cb();
 }
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_forgotten_cb.c b/tools/testing/selftests/bpf/progs/struct_ops_forgotten_cb.c
new file mode 100644
index 000000000000..3c822103bd40
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_forgotten_cb.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/test_1")
+int BPF_PROG(test_1_forgotten)
+{
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops ops = {
+	/* we forgot to reference test_1_forgotten above, oops */
+};
+
-- 
2.43.0


