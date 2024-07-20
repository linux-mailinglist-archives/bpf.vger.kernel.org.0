Return-Path: <bpf+bounces-35151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DE6937F2B
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 08:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C531C215FA
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 06:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9631E26AF9;
	Sat, 20 Jul 2024 06:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tBNL836q"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AC512E63
	for <bpf@vger.kernel.org>; Sat, 20 Jul 2024 06:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721456589; cv=none; b=ZQ2adtKQqPYRQEf7wMnKEIdMyS9Lp+IAbnmGIUr56mpnLITOPxsd77EH1QnYq/pTeU2ElNpsh/QWzuY7n264c8QtO9f/DHvyKKaIEwFiCRdkHoSB2xj8ThrYS75O574pAZ12ZuXIjdsCCS95l1VkLrt5ZeP+tg0BzQz8YHC7YYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721456589; c=relaxed/simple;
	bh=8nBZoDOYaMafbs2tQ5jQ6IBDoBUUsosahG4m4qnGJzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4O7XprMQFCKBtlf0lpWsSJZdui9mFr3k9XOQYcibKTkaVBBtrtjjnzD0IL3GjKNLGHxCin/iIWmiBFTZU7AYVloouvGnNP631Z/rMRFei2967sAFMdPZvpv2//TQEVnCgkKZVCtZaaFZYUpWaz2n1mtvYyeLAU94WjkfriMZ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tBNL836q; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721456585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTsRWIvPgE7R3E+caKP99B5R3ccpA/54CGWPFDvINao=;
	b=tBNL836q9/1cz7tuqhnLP0N54CqRa3gfz8H88Qw2MdXClss+Sb1M2z0tg6Wyn7vuljB3Jm
	K7wpRVuj6ufO3Z/3QAM2+1NqZj0+beoVGZKo2+H+pQjkVnm1e6hJKPSNcswM6XeQbsPwhQ
	R0UmSJ73Fb2X+PcycRuZINziUESLikQ=
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@meta.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 3/3] selftests/bpf: Ensure the unsupported struct_ops prog cannot be loaded
Date: Fri, 19 Jul 2024 23:22:31 -0700
Message-ID: <20240720062233.2319723-4-martin.lau@linux.dev>
In-Reply-To: <20240720062233.2319723-1-martin.lau@linux.dev>
References: <20240720062233.2319723-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

There is an existing "bpf_tcp_ca/unsupp_cong_op" test to ensure
the unsupported tcp-cc "get_info" struct_ops prog cannot be loaded.

This patch adds a new test in the bpf_testmod such that the
unsupported ops test does not depend on other kernel subsystem
where its supporting ops may be changed in the future.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  1 +
 .../bpf/prog_tests/test_struct_ops_module.c   |  2 ++
 .../selftests/bpf/progs/unsupported_ops.c     | 22 +++++++++++++++++++
 3 files changed, 25 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/unsupported_ops.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index 23fa1872ee67..fe0d402b0d65 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -35,6 +35,7 @@ struct bpf_testmod_ops {
 	void (*test_2)(int a, int b);
 	/* Used to test nullable arguments. */
 	int (*test_maybe_null)(int dummy, struct task_struct *task);
+	int (*unsupported_ops)(void);
 
 	/* The following fields are used to test shadow copies. */
 	char onebyte;
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index bbcf12696a6b..75a0dea511b3 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -9,6 +9,7 @@
 #include "struct_ops_nulled_out_cb.skel.h"
 #include "struct_ops_forgotten_cb.skel.h"
 #include "struct_ops_detach.skel.h"
+#include "unsupported_ops.skel.h"
 
 static void check_map_info(struct bpf_map_info *info)
 {
@@ -311,5 +312,6 @@ void serial_test_struct_ops_module(void)
 		test_struct_ops_forgotten_cb();
 	if (test__start_subtest("test_detach_link"))
 		test_detach_link();
+	RUN_TESTS(unsupported_ops);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/unsupported_ops.c b/tools/testing/selftests/bpf/progs/unsupported_ops.c
new file mode 100644
index 000000000000..9180365a3568
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/unsupported_ops.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/unsupported_ops")
+__failure
+__msg("attach to unsupported member unsupported_ops of struct bpf_testmod_ops")
+int BPF_PROG(unsupported_ops)
+{
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod = {
+	.unsupported_ops = (void *)unsupported_ops,
+};
-- 
2.43.0


