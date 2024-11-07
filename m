Return-Path: <bpf+bounces-44299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D32BE9C10C1
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 22:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FAC1F2324F
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 21:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E658E21830E;
	Thu,  7 Nov 2024 21:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="G3KE1ns5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97301CF7BB
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 21:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013978; cv=none; b=A4Eau49mqbmugGV045fyFT7hSnunLVXrH9dQsHgEw/UVykml8gZWRmiKeS5fdIxfA2ASQ1PdWS91bW5bQMeEcdQ4Ih+/SNNlh3bwSe/zukhgFrIlagcOWQD09Ywxt5/LbGbwRdXT+KXgnN1LgXhzq6DgzQthdtn5eQLTffIzTf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013978; c=relaxed/simple;
	bh=q2zm7XhpWXgczVLTp50flukPx5I2rnMRsgcIbA/JdIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=heGdWT4nCk/X30KM0BsCD02TIaInHYt7LzmOHVV16r2DQSSujz7Tc03TI/ps/4fGj1+fqwF21vs1i+8gqzBZDWLivHk4Pho8DJmrV9lvjbrQx+GS9cGC0NC3SFB7OCiq/3jyUn4u9cv8S2V8/UFzF4+kEjWgMoTa78bJ+uqpVbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=G3KE1ns5; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4A7KC9ab025532;
	Thu, 7 Nov 2024 13:12:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=B445bxnRd7VbM2XZKpHtwArCnEdBMewd+pcv5w8IaSQ=; b=G3KE1ns5UxY3
	9mPXocvEH+JgwZRE37WoqZYfeJcBpcFvziibeEQT7LvbERBPibhJYqhKRCyv++WC
	biHpShKh4hAjcl2JNEgA9SAOV5Xg3OoEPKIfmyAECcXRr512QHsXcfWLWA4MyJuI
	krZOM79LJoPK9Qq51zfjTYqj+yfG+1PJT+uBWCl9wcF8226ANOviM+0/5DzWLNR4
	B9XQ9U+KQ+kgilJJ29uvkWgFBTY3n1ZxvZ6S4NMnqfuFpGqW+VyHfxTsOR+w/MT1
	RLfswj29SbpqCRsJSb2ZiCpY9namaNGgD46bcdjp90hTXtxwKL3uKA+/vtImaAQu
	dZjGLsyttg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 42s12waa00-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 07 Nov 2024 13:12:30 -0800 (PST)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 7 Nov 2024 21:12:26 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman
	<eddyz87@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vadim Fedorenko
	<vadim.fedorenko@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: <x86@kernel.org>, <bpf@vger.kernel.org>,
        Vadim Fedorenko
	<vadfed@meta.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v4 4/4] selftests/bpf: add usage example for cpu cycles kfuncs
Date: Thu, 7 Nov 2024 13:12:06 -0800
Message-ID: <20241107211206.2814069-4-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107211206.2814069-1-vadfed@meta.com>
References: <20241107211206.2814069-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: WZb6L7EBjKHRR-RKtJ-M_jp7Q36w-yzD
X-Proofpoint-ORIG-GUID: WZb6L7EBjKHRR-RKtJ-M_jp7Q36w-yzD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

The selftest provides an example of how to measure the latency of bpf
kfunc/helper call in cycles and nanoseconds.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 .../bpf/prog_tests/test_cpu_cycles.c          | 35 +++++++++++++++++++
 .../selftests/bpf/progs/test_cpu_cycles.c     | 25 +++++++++++++
 2 files changed, 60 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_cpu_cycles.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cpu_cycles.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_cpu_cycles.c b/tools/testing/selftests/bpf/prog_tests/test_cpu_cycles.c
new file mode 100644
index 000000000000..d7f3b66594b3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_cpu_cycles.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Inc. */
+
+#include <test_progs.h>
+#include "test_cpu_cycles.skel.h"
+
+static void cpu_cycles(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct test_cpu_cycles *skel;
+	int err, pfd;
+
+	skel = test_cpu_cycles__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_cpu_cycles open and load"))
+		return;
+
+	pfd = bpf_program__fd(skel->progs.bpf_cpu_cycles);
+	if (!ASSERT_GT(pfd, 0, "test_cpu_cycles fd"))
+		goto fail;
+
+	err = bpf_prog_test_run_opts(pfd, &opts);
+	if (!ASSERT_OK(err, "test_cpu_cycles test run"))
+		goto fail;
+
+	ASSERT_NEQ(skel->bss->cycles, 0, "test_cpu_cycles 0 cycles");
+	ASSERT_NEQ(skel->bss->ns, 0, "test_cpu_cycles 0 ns");
+fail:
+	test_cpu_cycles__destroy(skel);
+}
+
+void test_cpu_cycles(void)
+{
+	if (test__start_subtest("cpu_cycles"))
+		cpu_cycles();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_cpu_cycles.c b/tools/testing/selftests/bpf/progs/test_cpu_cycles.c
new file mode 100644
index 000000000000..48762f07ad7f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_cpu_cycles.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Inc. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+extern u64 bpf_cpu_cycles_to_ns(u64 cycles) __weak __ksym;
+extern u64 bpf_get_cpu_cycles(void) __weak __ksym;
+
+__u64 cycles, ns;
+
+SEC("syscall")
+int bpf_cpu_cycles(void)
+{
+	struct bpf_pidns_info pidns;
+	__u64 start;
+
+	start = bpf_get_cpu_cycles();
+	bpf_get_ns_current_pid_tgid(0, 0, &pidns, sizeof(struct bpf_pidns_info));
+	cycles = bpf_get_cpu_cycles() - start;
+	ns = bpf_cpu_cycles_to_ns(cycles);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.5


