Return-Path: <bpf+bounces-44403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 275469C28FA
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 01:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598711C218F4
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 00:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955F611C83;
	Sat,  9 Nov 2024 00:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="WBuHlVjF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CE38F5C
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 00:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112964; cv=none; b=YMDRKJvu7AfKF62O/6dQgu4xefRVzPtZfW+zbSkXsP9QHYmfAggkvbFMMK5c7xCNG1zvYA1KEltWShuwp/jckfx2b2JZ/vIBnlL0q388Wj5m0Hcb5E354plcuVqPTNCziqWEPt+ASBAIqX004muRDsQZKs/gN4We6njjhO3pr10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112964; c=relaxed/simple;
	bh=q2zm7XhpWXgczVLTp50flukPx5I2rnMRsgcIbA/JdIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=po7Bno5YknSSxn+yMYPy2FJOv1x623XwQ4IRm1dcbZQ8zUwTQHotTh5ikW3ZgQeRe5d1yJnBMUnu2iijIG5VrD6/v3fDkZSVfcPJY0vRjoRcFPkSZJBMc9o+J++Rqp9PR1IugoBirxdaPBjIxbeaSnPaS3WlX0PUdmUsqhCmhWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=WBuHlVjF; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4A8LFZ1d009131;
	Fri, 8 Nov 2024 16:42:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=B445bxnRd7VbM2XZKpHtwArCnEdBMewd+pcv5w8IaSQ=; b=WBuHlVjFI/n1
	k56zIjmanC+2AoWO3CrUQDG8f0uYuwzAMm8DA8GQ0TRbg1mrt0xzL/EAvNCp19k7
	3Z+OuK642TgY9cmopeZmAGKOOJN6cx9vYcUoUxhBQj8Bb4xC+h4OcYYb4a0tia8w
	3wLWJV/0qzXv/Qun3pd/y6s8t4leQEo5sCh/oaGJOw9Ol22tQsXdcClvBW+hXS4I
	JKA7pN9eo+6wj+HJMXgCsKDgPxWv3jlUoqOaJykfSuxDTnehdPmcFiIAGqqS3NPl
	BtNCujd8rJhkeZZCtFumOGmSWe6HVAD4IGD4CYt0iFvfRKK6CV0gQIOxHuUCW14f
	5v4nEsvBiw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 42srnnsw3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 08 Nov 2024 16:42:17 -0800 (PST)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server id
 15.2.1544.11; Sat, 9 Nov 2024 00:42:13 +0000
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
Subject: [PATCH bpf-next v5 4/4] selftests/bpf: add usage example for cpu cycles kfuncs
Date: Fri, 8 Nov 2024 16:41:57 -0800
Message-ID: <20241109004158.2259301-4-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241109004158.2259301-1-vadfed@meta.com>
References: <20241109004158.2259301-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: FGo1yo3M2jPzlkAjGi_DRpiv2svRW0-L
X-Proofpoint-ORIG-GUID: FGo1yo3M2jPzlkAjGi_DRpiv2svRW0-L
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


