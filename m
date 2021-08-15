Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA9E3EC7D8
	for <lists+bpf@lfdr.de>; Sun, 15 Aug 2021 09:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbhHOHHo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 15 Aug 2021 03:07:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15956 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235569AbhHOHHV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 15 Aug 2021 03:07:21 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17F6xqfg026562
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 00:06:51 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aebnwbk5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 00:06:51 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 15 Aug 2021 00:06:50 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 4AA8A3D405A0; Sun, 15 Aug 2021 00:06:43 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v5 bpf-next 16/16] selftests/bpf: add ref_ctr_offset selftests
Date:   Sun, 15 Aug 2021 00:06:09 -0700
Message-ID: <20210815070609.987780-17-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210815070609.987780-1-andrii@kernel.org>
References: <20210815070609.987780-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 9kvXsFwqARqq-Q6wN1IlC-_aIhMlM8pJ
X-Proofpoint-GUID: 9kvXsFwqARqq-Q6wN1IlC-_aIhMlM8pJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-15_02:2021-08-13,2021-08-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108150048
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend attach_probe selftests to specify ref_ctr_offset for uprobe/uretprobe
and validate that its value is incremented from zero.

Turns out that once uprobe is attached with ref_ctr_offset, uretprobe for the
same location/function *has* to use ref_ctr_offset as well, otherwise
perf_event_open() fails with -EINVAL. So this test uses ref_ctr_offset for
both uprobe and uretprobe, even though for the purpose of test uprobe would be
enough.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 39 +++++++++++++------
 tools/testing/selftests/bpf/trace_helpers.c   | 21 ++++++++++
 tools/testing/selftests/bpf/trace_helpers.h   |  1 +
 3 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index e40b41c44f8b..bf307bb9e446 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -2,14 +2,18 @@
 #include <test_progs.h>
 #include "test_attach_probe.skel.h"
 
+/* this is how USDT semaphore is actually defined, except volatile modifier */
+volatile unsigned short uprobe_ref_ctr __attribute__((unused)) __attribute((section(".probes")));
+
 void test_attach_probe(void)
 {
+	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
 	int duration = 0;
 	struct bpf_link *kprobe_link, *kretprobe_link;
 	struct bpf_link *uprobe_link, *uretprobe_link;
 	struct test_attach_probe* skel;
 	size_t uprobe_offset;
-	ssize_t base_addr;
+	ssize_t base_addr, ref_ctr_offset;
 
 	base_addr = get_base_addr();
 	if (CHECK(base_addr < 0, "get_base_addr",
@@ -17,6 +21,10 @@ void test_attach_probe(void)
 		return;
 	uprobe_offset = get_uprobe_offset(&get_base_addr, base_addr);
 
+	ref_ctr_offset = get_rel_offset((uintptr_t)&uprobe_ref_ctr);
+	if (!ASSERT_GE(ref_ctr_offset, 0, "ref_ctr_offset"))
+		return;
+
 	skel = test_attach_probe__open_and_load();
 	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
 		return;
@@ -37,20 +45,28 @@ void test_attach_probe(void)
 		goto cleanup;
 	skel->links.handle_kretprobe = kretprobe_link;
 
-	uprobe_link = bpf_program__attach_uprobe(skel->progs.handle_uprobe,
-						 false /* retprobe */,
-						 0 /* self pid */,
-						 "/proc/self/exe",
-						 uprobe_offset);
+	ASSERT_EQ(uprobe_ref_ctr, 0, "uprobe_ref_ctr_before");
+
+	uprobe_opts.retprobe = false;
+	uprobe_opts.ref_ctr_offset = ref_ctr_offset;
+	uprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uprobe,
+						      0 /* self pid */,
+						      "/proc/self/exe",
+						      uprobe_offset,
+						      &uprobe_opts);
 	if (!ASSERT_OK_PTR(uprobe_link, "attach_uprobe"))
 		goto cleanup;
 	skel->links.handle_uprobe = uprobe_link;
 
-	uretprobe_link = bpf_program__attach_uprobe(skel->progs.handle_uretprobe,
-						    true /* retprobe */,
-						    -1 /* any pid */,
-						    "/proc/self/exe",
-						    uprobe_offset);
+	ASSERT_GT(uprobe_ref_ctr, 0, "uprobe_ref_ctr_after");
+
+	/* if uprobe uses ref_ctr, uretprobe has to use ref_ctr as well */
+	uprobe_opts.retprobe = true;
+	uprobe_opts.ref_ctr_offset = ref_ctr_offset;
+	uretprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uretprobe,
+							 -1 /* any pid */,
+							 "/proc/self/exe",
+							 uprobe_offset, &uprobe_opts);
 	if (!ASSERT_OK_PTR(uretprobe_link, "attach_uretprobe"))
 		goto cleanup;
 	skel->links.handle_uretprobe = uretprobe_link;
@@ -77,4 +93,5 @@ void test_attach_probe(void)
 
 cleanup:
 	test_attach_probe__destroy(skel);
+	ASSERT_EQ(uprobe_ref_ctr, 0, "uprobe_ref_ctr_cleanup");
 }
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 381dafce1d8f..e7a19b04d4ea 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -202,3 +202,24 @@ ssize_t get_base_addr(void)
 	fclose(f);
 	return -EINVAL;
 }
+
+ssize_t get_rel_offset(uintptr_t addr)
+{
+	size_t start, end, offset;
+	char buf[256];
+	FILE *f;
+
+	f = fopen("/proc/self/maps", "r");
+	if (!f)
+		return -errno;
+
+	while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &offset) == 4) {
+		if (addr >= start && addr < end) {
+			fclose(f);
+			return (size_t)addr - start + offset;
+		}
+	}
+
+	fclose(f);
+	return -EINVAL;
+}
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
index 3d9435b3dd3b..d907b445524d 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -20,5 +20,6 @@ void read_trace_pipe(void);
 
 ssize_t get_uprobe_offset(const void *addr, ssize_t base);
 ssize_t get_base_addr(void);
+ssize_t get_rel_offset(uintptr_t addr);
 
 #endif
-- 
2.30.2

