Return-Path: <bpf+bounces-28742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F47C8BD86E
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 02:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DD61F22927
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 00:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13364652;
	Tue,  7 May 2024 00:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFwKoIVM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E0710E6
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 00:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715040829; cv=none; b=eLogyBb/qqhVIZ0GuTwjqZdqmOPNo7lXkva63mxn1hgWUOeCAywSTLkqqL+MIBXfugZgYzW41XnF72hrcB9rl+/JKIm9Zqhcy0T7kli1L6GgVEVFwsX6TP5XSDgsjg2jkinzTzf14i7bHQ/GTb7q81thGfyw2B6pboXJbjbC6ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715040829; c=relaxed/simple;
	bh=vXSXvlNAbkNh+7+KL0k+gtLsik1yPo/wXZKumA436Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOqL6BFrTk29V1Dw0MqVcMfguYi+xp9m0bmzeQ581VV3oUV+gkXCimyT28ecr0nhH72gpzDB9Ev4Ih0H4O1o4EiRizjfXlqaQZ5bS0+3UTnioogEwKU9U+xYGqZSVgz0Xljnd/rvuD8ztpdAXu0c0rLgootm6P1yvqVh1qi9SMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFwKoIVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59D3C116B1;
	Tue,  7 May 2024 00:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715040829;
	bh=vXSXvlNAbkNh+7+KL0k+gtLsik1yPo/wXZKumA436Ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VFwKoIVMfRJK3O0Cfm9SVrhRTi24i/uJ/DFpdRIc76N6zXwo2lmfozlkMyM7EvRD8
	 /3JrRHB9o/FwelZvpM482YwMYOGRYKsF/yUXuZR+X4VFysyZtpx59eFC8hGK5EFtG1
	 2HpD6uIOlC+fPiU2yJTukcG5YbRB9ZD36IlQaxVh32gaKjJwril9OpfV/yBVMXtBs8
	 S70Dcd7hDDVoN1vr7Ag17cWLri3iFxydkO6gwfX/rCFVj7xLY+shHc7tpyhcGWxV6h
	 7hmj91EHsdwnyolz4ibHp5BO8d6NrsEWi0xC8/wXLofie6Mue06BfrPNtAeNHpDmKz
	 ct28RITvW8xAw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 3/7] selftests/bpf: add another struct_ops callback use case test
Date: Mon,  6 May 2024 17:13:31 -0700
Message-ID: <20240507001335.1445325-4-andrii@kernel.org>
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

Add a test which tests the case that was just fixed. Kernel has full
type information about callback, but user explicitly nulls out the
reference to declaratively set BPF program reference.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/test_struct_ops_module.c   | 27 +++++++++++++++++++
 .../bpf/progs/struct_ops_nulled_out_cb.c      | 22 +++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nulled_out_cb.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index bd39586abd5a..f3c61ebad323 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -4,6 +4,7 @@
 #include <time.h>
 
 #include "struct_ops_module.skel.h"
+#include "struct_ops_nulled_out_cb.skel.h"
 
 static void check_map_info(struct bpf_map_info *info)
 {
@@ -174,6 +175,30 @@ static void test_struct_ops_incompatible(void)
 	struct_ops_module__destroy(skel);
 }
 
+/* validate that it's ok to "turn off" callback that kernel supports */
+static void test_struct_ops_nulled_out_cb(void)
+{
+	struct struct_ops_nulled_out_cb *skel;
+	int err;
+
+	skel = struct_ops_nulled_out_cb__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	/* kernel knows about test_1, but we still null it out */
+	skel->struct_ops.ops->test_1 = NULL;
+
+	err = struct_ops_nulled_out_cb__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	ASSERT_FALSE(bpf_program__autoload(skel->progs.test_1_turn_off), "prog_autoload");
+	ASSERT_LT(bpf_program__fd(skel->progs.test_1_turn_off), 0, "prog_fd");
+
+cleanup:
+	struct_ops_nulled_out_cb__destroy(skel);
+}
+
 void serial_test_struct_ops_module(void)
 {
 	if (test__start_subtest("test_struct_ops_load"))
@@ -182,5 +207,7 @@ void serial_test_struct_ops_module(void)
 		test_struct_ops_not_zeroed();
 	if (test__start_subtest("test_struct_ops_incompatible"))
 		test_struct_ops_incompatible();
+	if (test__start_subtest("test_struct_ops_null_out_cb"))
+		test_struct_ops_nulled_out_cb();
 }
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_nulled_out_cb.c b/tools/testing/selftests/bpf/progs/struct_ops_nulled_out_cb.c
new file mode 100644
index 000000000000..fa2021388485
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_nulled_out_cb.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+int rand;
+int arr[1];
+
+SEC("struct_ops/test_1")
+int BPF_PROG(test_1_turn_off)
+{
+	return arr[rand]; /* potentially way out of range access */
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops ops = {
+	.test_1 = (void *)test_1_turn_off,
+};
+
-- 
2.43.0


