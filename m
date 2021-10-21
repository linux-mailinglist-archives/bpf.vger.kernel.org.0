Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F8A43586A
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 03:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhJUBqv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 20 Oct 2021 21:46:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16772 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230363AbhJUBqv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Oct 2021 21:46:51 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KN9n93021428
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 18:44:36 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3btnf0vca7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 18:44:35 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 20 Oct 2021 18:44:34 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id BD71B6E3E1D4; Wed, 20 Oct 2021 18:44:30 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 bpf-next 08/10] selftests/bpf: demonstrate use of custom .rodata/.data sections
Date:   Wed, 20 Oct 2021 18:44:02 -0700
Message-ID: <20211021014404.2635234-9-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021014404.2635234-1-andrii@kernel.org>
References: <20211021014404.2635234-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 60guNWSTzdf9xFT4TivThEWBwaN7Isec
X-Proofpoint-GUID: 60guNWSTzdf9xFT4TivThEWBwaN7Isec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_06,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 clxscore=1034 mlxlogscore=999 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210008
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Enhance existing selftests to demonstrate the use of custom
.data/.rodata sections.

Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/skeleton.c       | 29 +++++++++++++++++++
 .../selftests/bpf/progs/test_skeleton.c       | 18 ++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/skeleton.c b/tools/testing/selftests/bpf/prog_tests/skeleton.c
index fe1e204a65c6..180afd632f4c 100644
--- a/tools/testing/selftests/bpf/prog_tests/skeleton.c
+++ b/tools/testing/selftests/bpf/prog_tests/skeleton.c
@@ -16,10 +16,13 @@ void test_skeleton(void)
 	struct test_skeleton* skel;
 	struct test_skeleton__bss *bss;
 	struct test_skeleton__data *data;
+	struct test_skeleton__data_dyn *data_dyn;
 	struct test_skeleton__rodata *rodata;
+	struct test_skeleton__rodata_dyn *rodata_dyn;
 	struct test_skeleton__kconfig *kcfg;
 	const void *elf_bytes;
 	size_t elf_bytes_sz = 0;
+	int i;
 
 	skel = test_skeleton__open();
 	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
@@ -30,7 +33,12 @@ void test_skeleton(void)
 
 	bss = skel->bss;
 	data = skel->data;
+	data_dyn = skel->data_dyn;
 	rodata = skel->rodata;
+	rodata_dyn = skel->rodata_dyn;
+
+	ASSERT_STREQ(bpf_map__name(skel->maps.rodata_dyn), ".rodata.dyn", "rodata_dyn_name");
+	ASSERT_STREQ(bpf_map__name(skel->maps.data_dyn), ".data.dyn", "data_dyn_name");
 
 	/* validate values are pre-initialized correctly */
 	CHECK(data->in1 != -1, "in1", "got %d != exp %d\n", data->in1, -1);
@@ -46,6 +54,12 @@ void test_skeleton(void)
 	CHECK(rodata->in.in6 != 0, "in6", "got %d != exp %d\n", rodata->in.in6, 0);
 	CHECK(bss->out6 != 0, "out6", "got %d != exp %d\n", bss->out6, 0);
 
+	ASSERT_EQ(rodata_dyn->in_dynarr_sz, 0, "in_dynarr_sz");
+	for (i = 0; i < 4; i++)
+		ASSERT_EQ(rodata_dyn->in_dynarr[i], -(i + 1), "in_dynarr");
+	for (i = 0; i < 4; i++)
+		ASSERT_EQ(data_dyn->out_dynarr[i], i + 1, "out_dynarr");
+
 	/* validate we can pre-setup global variables, even in .bss */
 	data->in1 = 10;
 	data->in2 = 11;
@@ -53,6 +67,10 @@ void test_skeleton(void)
 	bss->in4 = 13;
 	rodata->in.in6 = 14;
 
+	rodata_dyn->in_dynarr_sz = 4;
+	for (i = 0; i < 4; i++)
+		rodata_dyn->in_dynarr[i] = i + 10;
+
 	err = test_skeleton__load(skel);
 	if (CHECK(err, "skel_load", "failed to load skeleton: %d\n", err))
 		goto cleanup;
@@ -64,6 +82,10 @@ void test_skeleton(void)
 	CHECK(bss->in4 != 13, "in4", "got %lld != exp %lld\n", bss->in4, 13LL);
 	CHECK(rodata->in.in6 != 14, "in6", "got %d != exp %d\n", rodata->in.in6, 14);
 
+	ASSERT_EQ(rodata_dyn->in_dynarr_sz, 4, "in_dynarr_sz");
+	for (i = 0; i < 4; i++)
+		ASSERT_EQ(rodata_dyn->in_dynarr[i], i + 10, "in_dynarr");
+
 	/* now set new values and attach to get them into outX variables */
 	data->in1 = 1;
 	data->in2 = 2;
@@ -73,6 +95,8 @@ void test_skeleton(void)
 	bss->in5.b = 6;
 	kcfg = skel->kconfig;
 
+	skel->data_read_mostly->read_mostly_var = 123;
+
 	err = test_skeleton__attach(skel);
 	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
 		goto cleanup;
@@ -93,6 +117,11 @@ void test_skeleton(void)
 	CHECK(bss->kern_ver != kcfg->LINUX_KERNEL_VERSION, "ext2",
 	      "got %d != exp %d\n", bss->kern_ver, kcfg->LINUX_KERNEL_VERSION);
 
+	for (i = 0; i < 4; i++)
+		ASSERT_EQ(data_dyn->out_dynarr[i], i + 10, "out_dynarr");
+
+	ASSERT_EQ(skel->bss->out_mostly_var, 123, "out_mostly_var");
+
 	elf_bytes = test_skeleton__elf_bytes(&elf_bytes_sz);
 	ASSERT_OK_PTR(elf_bytes, "elf_bytes");
 	ASSERT_GE(elf_bytes_sz, 0, "elf_bytes_sz");
diff --git a/tools/testing/selftests/bpf/progs/test_skeleton.c b/tools/testing/selftests/bpf/progs/test_skeleton.c
index 441fa1c552c8..1b1187d2967b 100644
--- a/tools/testing/selftests/bpf/progs/test_skeleton.c
+++ b/tools/testing/selftests/bpf/progs/test_skeleton.c
@@ -5,6 +5,8 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
+#define __read_mostly SEC(".data.read_mostly")
+
 struct s {
 	int a;
 	long long b;
@@ -40,9 +42,20 @@ int kern_ver = 0;
 
 struct s out5 = {};
 
+
+const volatile int in_dynarr_sz SEC(".rodata.dyn");
+const volatile int in_dynarr[4] SEC(".rodata.dyn") = { -1, -2, -3, -4 };
+
+int out_dynarr[4] SEC(".data.dyn") = { 1, 2, 3, 4 };
+
+int read_mostly_var __read_mostly;
+int out_mostly_var;
+
 SEC("raw_tp/sys_enter")
 int handler(const void *ctx)
 {
+	int i;
+
 	out1 = in1;
 	out2 = in2;
 	out3 = in3;
@@ -53,6 +66,11 @@ int handler(const void *ctx)
 	bpf_syscall = CONFIG_BPF_SYSCALL;
 	kern_ver = LINUX_KERNEL_VERSION;
 
+	for (i = 0; i < in_dynarr_sz; i++)
+		out_dynarr[i] = in_dynarr[i];
+
+	out_mostly_var = read_mostly_var;
+
 	return 0;
 }
 
-- 
2.30.2

