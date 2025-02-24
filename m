Return-Path: <bpf+bounces-52378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83DDA42673
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 16:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EBE169501
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EBF24887A;
	Mon, 24 Feb 2025 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R9a8UP/A"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E386248861
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411300; cv=none; b=fFxO32eCm+beq3MB48WbvVogDOyj+ezC+uQExJIOsC9xYG5qBGfmZgpDYcsgSsaW3Tl2ju1HOwclUMWuvivADEPMj7X2ekZ+ibgzOp18N8jA+UXGlTuUmA5saAqGTjGJNhkAQKQjapUypwdg3MZpiSnKzXrJZ+bJlcDNTn9gr58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411300; c=relaxed/simple;
	bh=rOHdKdSeBCnFIOGx0eK7EOP0HBYShu6UeLVvdwxlMB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVg7b2Rw3ooq/2zCWylwWk8L/FFujRvk+H3Njg2Rsz4UtgJHcVr9XZsC8miXABTwap92K4Wp9BCsRl2pQYGmRFW9GnqOknKJbhOi1deEpL/MxkGu/L6PK6cYJoFh08IRFYBQ9I2Y0RwoQcBubeEqoM3svYxk2UfgT4Uf1OLhblY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R9a8UP/A; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740411297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFaOT575pWRobAbYpSu1/GGMB2pQbpc3rBz1ROHxFEQ=;
	b=R9a8UP/A8Ix+l7udACm0BX/ohSIXkWwxRvO4bz4qUqaoQSaf+ndBArpF1y6bsd/bYdCXif
	QVEuG2dAUdmYagfkqMt/8+PcoS58WlZEv5agbd9wbzGbUaG3j5O60OOXxrRLk33CliO1gn
	A+78kF7zhzpJcwgko5HyHbT8eIPlNDs=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	me@manjusaka.me,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 4/4] selftests/bpf: Add test case for freplace attachment failure log
Date: Mon, 24 Feb 2025 23:33:52 +0800
Message-ID: <20250224153352.64689-5-leon.hwang@linux.dev>
In-Reply-To: <20250224153352.64689-1-leon.hwang@linux.dev>
References: <20250224153352.64689-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch adds a selftest to verify that freplace attachment failure
produces meaningful log.

cd tools/testing/selftests/bpf/; ./test_progs -t attach_log
115     freplace_attach_log:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../bpf/prog_tests/tracing_link_attach_log.c  | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_link_attach_log.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_link_attach_log.c b/tools/testing/selftests/bpf/prog_tests/tracing_link_attach_log.c
new file mode 100644
index 0000000000000..92f770966f8cd
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_link_attach_log.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "tailcall_bpf2bpf1.skel.h"
+#include "freplace_global_func.skel.h"
+
+void test_freplace_attach_log(void)
+{
+	struct freplace_global_func *freplace_skel = NULL;
+	struct tailcall_bpf2bpf1 *tailcall_skel = NULL;
+	struct bpf_link *freplace_link = NULL;
+	struct bpf_program *prog;
+	char log_buf[64];
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_freplace_opts, freplace_opts,
+		    .log_buf = log_buf,
+		    .log_buf_size = sizeof(log_buf),
+	);
+
+	tailcall_skel = tailcall_bpf2bpf1__open_and_load();
+	if (!ASSERT_OK_PTR(tailcall_skel, "tailcall_bpf2bpf1__open_and_load"))
+		return;
+
+	freplace_skel = freplace_global_func__open();
+	if (!ASSERT_OK_PTR(freplace_skel, "freplace_global_func__open"))
+		goto out;
+
+	prog = freplace_skel->progs.new_test_pkt_access;
+	prog_fd = bpf_program__fd(tailcall_skel->progs.entry);
+	err = bpf_program__set_attach_target(prog, prog_fd, "entry");
+	if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
+		goto out;
+
+	err = freplace_global_func__load(freplace_skel);
+	if (!ASSERT_OK(err, "freplace_global_func__load"))
+		goto out;
+
+	freplace_opts.prog = prog;
+	freplace_opts.target_prog_fd = prog_fd;
+	freplace_opts.attach_func_name = "subprog_tail";
+	freplace_link = bpf_program__attach_freplace_opts(&freplace_opts);
+	ASSERT_ERR_PTR(freplace_link, "bpf_program__attach_freplace");
+	ASSERT_STREQ(log_buf, "subprog_tail() is not a global function\n", "log_buf");
+
+out:
+	bpf_link__destroy(freplace_link);
+	freplace_global_func__destroy(freplace_skel);
+	tailcall_bpf2bpf1__destroy(tailcall_skel);
+}
-- 
2.47.1


