Return-Path: <bpf+bounces-51754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E592BA387EE
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 16:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99AA3B575D
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAC9224B1B;
	Mon, 17 Feb 2025 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fne8472f"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CE2224B0D
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807056; cv=none; b=aqF/AkeBI+q/8Bw9LYkNSmZQyaT23CZaRsqg0fatrkSwdm+SZKN8ctwcHqYvLn4bk2eoIt10tZL3iiWQGDZ9o8F8l+Udyd3yVDQbFJcR2wDv3U2AUfT2td0xuUjb2vJYiI6jnz5YNT92DbF/KnZFQFNveqvlOIiPmUYXVx2rEL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807056; c=relaxed/simple;
	bh=gaasYv+ZWWBEZcy+eypw/FkBT9UUS6T/amOOEKy/tDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGwqSaAiryrELJT0/kYM2tORSw4LOv/mspJU8vIp0PMBuY2/ggABC6lQEuONMHsVabodsVL3QkLqiJI1DR8Gr+q3xocMySEJsE48bHDB+Uv1F51oWRKwngxSe+sU6ZsWMZ3IVMEyWkUff9uITpui15OepeB8MxOw+ME9IqklTKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fne8472f; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739807052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+4JgzDMbjZJKWH+aMWvOsfvkBO5x0NDysvtqRsrf0bY=;
	b=fne8472f5/36jgT0jVxLS5mHjfkq42evex9W8eYbdJd9aJnzYo0jNV5j0ZAMSoNGJBCRIP
	Idx74U98lXizfML5GnRbn512pszw2vKewGcqvfhGnGjdnhbjlgJUVzQz1kFV/Dl1hz94B7
	a2UP3PTBqpw2k4EMLZFrQEbjREdeZBM=
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
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: Add test case for freplace attachment failure logging
Date: Mon, 17 Feb 2025 23:43:18 +0800
Message-ID: <20250217154318.76145-5-leon.hwang@linux.dev>
In-Reply-To: <20250217154318.76145-1-leon.hwang@linux.dev>
References: <20250217154318.76145-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch adds a selftest to verify that freplace attachment failure
produces meaningful logs.

cd tools/testing/selftests/bpf/; ./test_progs -t attach_log -v
test_freplace_attach_log:PASS:tailcall_bpf2bpf1__open_and_load 0 nsec
test_freplace_attach_log:PASS:freplace_global_func__open 0 nsec
test_freplace_attach_log:PASS:bpf_program__set_attach_target 0 nsec
test_freplace_attach_log:PASS:freplace_global_func__load 0 nsec
libbpf: prog 'new_test_pkt_access': failed to attach to freplace: -EINVAL
libbpf: prog 'new_test_pkt_access': attach log: subprog_tail() is not a global function
test_freplace_attach_log:PASS:bpf_program__attach_freplace 0 nsec
114     freplace_attach_log:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../bpf/prog_tests/tracing_link_attach_log.c  | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_link_attach_log.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_link_attach_log.c b/tools/testing/selftests/bpf/prog_tests/tracing_link_attach_log.c
new file mode 100644
index 0000000000000..cfdcb9ebdd255
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_link_attach_log.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Leon Hwang */
+
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
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
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
+	freplace_link = bpf_program__attach_freplace(prog, prog_fd, "subprog_tail");
+	ASSERT_ERR_PTR(freplace_link, "bpf_program__attach_freplace");
+
+out:
+	bpf_link__destroy(freplace_link);
+	freplace_global_func__destroy(freplace_skel);
+	tailcall_bpf2bpf1__destroy(tailcall_skel);
+}
-- 
2.47.1


