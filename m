Return-Path: <bpf+bounces-53837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D023BA5C8D8
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 16:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597753AB51A
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 15:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DEE25EFB4;
	Tue, 11 Mar 2025 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="l5nW6NXp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B2025F787
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708197; cv=none; b=UYcFs5blt+AIIJLgrOIazfi17HD0VjZfLU34RALaKcPgVrHRgikoVlJyo7+6XxtcGY8/g7+eMAIE3xNBkFAVlabd1jYP94/YLYjClVVIZnXFZj+p71EOwSR5knnF8vWXsU0hEbNRlSjZkFJzIYMIMpT9RtPOLGxoxESnT11pRpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708197; c=relaxed/simple;
	bh=UH7TVHDqiP1UuocCQTquKA8Es4asFiL/ebcSS/Ho8oQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u31ESZ9ls6o3MQdhxW2faSfFxkjZFYlZZPokD+2SKxe7YMi/npifTbO4PVP7yBd+YbpnK4KrbRmICpweWS8kEZ5cuL8r85q61Fg/3zEJMoquMHnHk+TFlA8VkCYwDdH06O3adBWNZckaiyWRwn4wBxhDRR6Ww4A6cbCTrNx7l0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=l5nW6NXp; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 52B7NJK7005365;
	Tue, 11 Mar 2025 08:49:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=0CtSJOc8ThsJf8ORc2fFKFkruWqxLTJPmfNRsKPViZ4=; b=l5nW6NXpdIVB
	CUKYCDLiwbRg3fA/tpcUSlFrOf7+YhJVm/PT0CvGWP83MNQgtzfM+7owYnRJ/BbC
	sJwgoCnK3ZyyIIZZdhHYo9ltNnmBIwKuCh2h+e3AegC6oqmTk5x7TlQghWBgwCEN
	AoUWI2db8XK6iXhWk+NzpNjMFu31tDKFfv7ol03IFY4j+nAABLBqYFehxd97UZbZ
	ohHNGlyW9DQw2g2+ndf1WCty5gIS6EudmRnHQbYpJ/VJU8RIZ9t7pFNieu5zBlvC
	0AwSFeZPlvnlyCw5O2z0f4NgZ2/9npkyvyRFIC8pwq495ztd4cS0Z1bLv34Andad
	7ArD+DJkaQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 45a4880d8g-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 11 Mar 2025 08:49:16 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server id
 15.2.1544.14; Tue, 11 Mar 2025 15:49:12 +0000
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
        Peter Zijlstra
	<peterz@infradead.org>,
        Vadim Fedorenko <vadfed@meta.com>,
        Martin KaFai Lau
	<martin.lau@linux.dev>
Subject: [PATCH bpf-next v10 4/4] selftests/bpf: add usage example for cpu time counter kfuncs
Date: Tue, 11 Mar 2025 08:48:50 -0700
Message-ID: <20250311154850.3616840-5-vadfed@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311154850.3616840-1-vadfed@meta.com>
References: <20250311154850.3616840-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ms3HdZaRua4NY7GhrmlcDPx2JEUycESc
X-Proofpoint-ORIG-GUID: ms3HdZaRua4NY7GhrmlcDPx2JEUycESc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_04,2025-03-11_02,2024-11-22_01

The selftest provides an example of how to measure the latency of bpf
kfunc/helper call using time stamp counter and how to convert measured
value into nanoseconds.

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
index 000000000000..a7f8a4c6b854
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_cpu_cycles.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Inc. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+extern u64 bpf_cpu_time_counter_to_ns(u64 cycles) __weak __ksym;
+extern u64 bpf_get_cpu_time_counter(void) __weak __ksym;
+
+__u64 cycles, ns;
+
+SEC("syscall")
+int bpf_cpu_cycles(void)
+{
+	struct bpf_pidns_info pidns;
+	__u64 start;
+
+	start = bpf_get_cpu_time_counter();
+	bpf_get_ns_current_pid_tgid(0, 0, &pidns, sizeof(struct bpf_pidns_info));
+	cycles = bpf_get_cpu_time_counter() - start;
+	ns = bpf_cpu_time_counter_to_ns(cycles);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.1


