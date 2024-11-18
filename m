Return-Path: <bpf+bounces-45110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FD29D1878
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 19:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9E89B23606
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 18:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61F71E282A;
	Mon, 18 Nov 2024 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="f8rYuOJn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF22A1E102E
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731956022; cv=none; b=kggyVf0kuxFfUMCZtKCRZ7uAUvQUm2HW6CUWwbqWDi3YpAOG34kAdBRaR9ew/QvXfzWM5lvZu8+IQvtoNt5R5ibIG2mHJvxvWzijAfLdO2pNG1fsr4VOklJQEWBmsd/+DRDkc9SOZHg7xUsTR2/TaWCws/0lcPwsNDs6b/Yr8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731956022; c=relaxed/simple;
	bh=q2zm7XhpWXgczVLTp50flukPx5I2rnMRsgcIbA/JdIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXs+ukehyDvonV0xk3twgv2I6z1apP6mYa9qquHjVULIJGkcQNsCWvqqK1T80ij0vQ1KF3QsvDwbmrKfQuUF5h+eYAB+KSdsoA6mLaHdZG/24NbqYbAe/y+yq2rZMRLVHb44McGfIU1NpxR+PpbAHKkD2TNQkSWjMz5z8DtzjMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=f8rYuOJn; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIHAYLr007482;
	Mon, 18 Nov 2024 10:53:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=B445bxnRd7VbM2XZKpHtwArCnEdBMewd+pcv5w8IaSQ=; b=f8rYuOJnq0Kb
	x5AquDRVEz+Lwwij4cThwJ3UfhiKJg8siqE8eA+IdraVfBRvqU/5LQmaQQnJ1FDZ
	0GSphBwrJF4zuXDnjK5a9+A/Zuo+RX64ZoDmBKivWiWXTVL9FT7cIo08uyJOSSlj
	ijeQDlrKsjIDcDpcwdaTve/eNNUmWRPFScAd0ndbvJXocKmQC80pmg6h7ZgR1UcD
	dbVVCNNhgia6DN4+wL2TR5Hxy+wr5LNozaoT8AWyzZr4bngYU88C5biYLEuvqqTR
	+IHRrQW1ZzIdtvr6SLAVnF6BnTbYshUNyaVNh/yYbdKKrpqgG2mpNvHeQsFYaE+j
	2upeu1WVEw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4301j83rjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 18 Nov 2024 10:53:08 -0800 (PST)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Mon, 18 Nov 2024 18:53:06 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yonghong Song <yonghong.song@linux.dev>,
        Vadim Fedorenko
	<vadim.fedorenko@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>
CC: <x86@kernel.org>, <bpf@vger.kernel.org>,
        Vadim Fedorenko
	<vadfed@meta.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v7 4/4] selftests/bpf: add usage example for cpu cycles kfuncs
Date: Mon, 18 Nov 2024 10:52:45 -0800
Message-ID: <20241118185245.1065000-5-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241118185245.1065000-1-vadfed@meta.com>
References: <20241118185245.1065000-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: DSNdGWUDWDLVKxcbn70t0FmkGY7EleNs
X-Proofpoint-ORIG-GUID: DSNdGWUDWDLVKxcbn70t0FmkGY7EleNs
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


