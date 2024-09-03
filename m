Return-Path: <bpf+bounces-38845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D806796ABE7
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 00:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D555B26933
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 22:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C691D79A2;
	Tue,  3 Sep 2024 22:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Oy83z9Hs"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19013070.outbound.protection.outlook.com [52.103.32.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D085F1D799E;
	Tue,  3 Sep 2024 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401474; cv=fail; b=u8s4T//LLGnqjXEjie1njPMoZkTTrbTy+F/yon62mm12OzJ2Kc08Y8Qwrq6Ii7WuSQ89QB9UuKFHtFGW1BXigy83DUAFoNeqCsLb2q66yeXh5jMjGtUkgUgrUrZQO47dc+HZDq7oz7IHuYhotHZEJQPvP2QYa1PnCb5LdWhg1lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401474; c=relaxed/simple;
	bh=VRMyYiFADntRaYWKa8srLMLo4ImNH1x1utvG5R4gPlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l/VXWKjH32SVKy36onLNNepwDfUFV83++bYA/hX+aL/9z5Pe4WExYt63qUpTSDQ99hhCRZYsbANMEhWVKKODTbnoyPmoRwTZv0g0ARwO7cKJHd5NpDpQMTM14dKa03jV1Y9zWAfw5c8dWE0ljS3F5q8FGa2ew08Il5WHExFkzlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Oy83z9Hs; arc=fail smtp.client-ip=52.103.32.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBYN9x/nR+byNJkRZKy7NekzX/HwjJ7IsJ2NjaZOqambGpTpnUrjRODDdymtKPgY2qQRzPLF9NxZi9IwCwOw6z9lZQ5tXQUqWzeAN94czY/xMIAv5JPm19x9B80TNwMJbV7dT/Fbcfr37i0ISnNUDBPxbxLU113m3w15PlUcWHQrNVAttSZoScprjkOeCbyt1kpaXk7KZgQJooGy9Ybq3EtwzVeaQ3HR+GYnGK7y9kugyVXfcjkhJG5ZIdyYUu362Cjwun5F7PrFrLd3qoMfnAmLEz1YWmFPmF3ReqEa7VjrJq+o7QRrCzgs3XDGXFAtmiEcw7cXfWlNGpfC6+Bplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItkT1Oe88otzRYEIKE04ZEPRro7q4zW7CYtVfDyCBIo=;
 b=hmtOa1+/UuvnkTMRRH2mL9/4ikAVJgN4R8HVQ56smpJcEMcmvO54PdC9teWigxb+Jy6n8EvCXDZekDdj8z9qZrmEEKKHaN0tu0VaaQvQZR2YhDaR0K8K4dxXUG5IoUeqd2hYsJ9P3AhHwZmpOptRQoMD5Smgo+ZGIbKKDl/C3dwhRBCThBlIgScW6sMyHg4jIqA4Ui4LwltwnZ6VZzvqFx+TNZeM2Ljjd+cSRFZXPpTkt7ZKYY++Jow3LhYNMhXeraDjI3Ca1B2Rbf7B2JR1SUzUy4GXo1Y7a3bcUvrflylTJpP7xax9sJ9GALsOGH22jflnqJHQRJhSfaA+bkEvog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItkT1Oe88otzRYEIKE04ZEPRro7q4zW7CYtVfDyCBIo=;
 b=Oy83z9HsUyEfOCswvKwMlGseZTFXesq/oGbNEE7dl/qTJp41TEOdCxEwcDF9Prwb6/8akIBHGFUlUciAH0igasapmmGW2q8jWoOt8wqaRxBMN/38rOpZTIWkEhmR34wYREyUKykT+EyrtzKjVePlU2GxcsfGJhCvfi+2Xrjm3u2bmftMY/IbKYIs6yshqzWFGPOR4BtrGQgnixu+2wHIR+DY4Lpe9bNpIGrUmLpySfXZ21x6zk5LXSb8NbxCpya63i6/hss8+36egnfCgb6L75ES4bRYnSLOFp6lGtnDJtJJv9lbmqV/cfRN3B4YLKfFKwNYvXJmcuEmV7xstZb8LQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by VI1PR03MB6335.eurprd03.prod.outlook.com (2603:10a6:800:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 22:11:04 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%5]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 22:11:04 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 2/2] selftests/bpf: Add tests for open-coded style bpf dynamic pointer iterator
Date: Tue,  3 Sep 2024 23:09:49 +0100
Message-ID:
 <AM6PR03MB58485BE1C0964BFD3C3657D899932@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB5848C2304B17658423B4B81D99932@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB5848C2304B17658423B4B81D99932@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [trO/xc8yGqM2LWABVX792NIo30jo1n3y]
X-ClientProxiedBy: LO2P265CA0498.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::23) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240903220949.82946-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|VI1PR03MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7ff9e1-d6b5-4357-cfff-08dccc654d23
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|15080799006|5072599009|19110799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	L9jSLmbIMOvCKFVyCrmQ8iaiTj3fulaBVSmZWx9+xVu2uKV9CY37WlQVLLhcNhVmGM15Q+KBWvLHneby2lGhyVRd7aEshheaUGmTfiiTsQ++jK4ORPoRkwwmoryE6rfUur+a3jrmALNYmxCLoIDc7tIIl+hIrTG9jq1+R5/AM6SP0KeGhwAJQ+0lvS41jOtQMQHzpXh731ZhS2fAHIuJ+5A3QV5+9wbAgnv1kN5NPW1fbLw+ssM85qGZ+ozBQQzlmB2qI01rrXrqXahXGtL5pN1oqFJ0khGBgE0rmdPISzGP/+gVcLy56F6mAxtaDdVc5Ks2T3T03wK9YScu9grsP38AnHEnZF2UBAq88IrY5xLNLt+Z4iStGcUyNpLQ4Y4lRtfdqOP+gStl+Ve00/p0KJbU5s1M3ck/IycxFIeHluwD4toOm7WbQns1SGkZWpYj32RHN0a5Zu4jPwpwTTImasSKl42Bz5+LVfVgjEMOKKHZUO1D9WH6AuK0hQXTcG5snxEavSF4ecjeSL3rghJRHOe7snGDSqAOvnqkDQGIbJwR3b8IB0PO90oC3SVFOcFd2gmc6+G2Dcb1KYw8T1EORig0IViY7re0PhkgeVl0/vACoTBa0deNDa5LvqVG2J0SCV4wb/hEJPpkbNuMuA/0QLOYuzmtu+nt5jG3XsV/Pz8LzVipae+60yw4KtatEYmQ30iDmTe8oyDPmzjY8Ie1JA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j/8f3lkBz+sHtFCcE+zKabo3OwHaahx08/cekcVCAH6s2f4UAs4JsxMSwHcU?=
 =?us-ascii?Q?MFCXnaOfOtQ9YnHUQoI+B/8cTlKdQvrITmDpfpDfrslVKs4+nTMRJOQV5dVL?=
 =?us-ascii?Q?E3Noi8XTGouZZUy2vShT3T6UO5eNhfudrx0AtmPFIdB1Tqbxlw6S7Z+ZPXvB?=
 =?us-ascii?Q?NnbY+huR3g9Sfj/Le0hsN2lRppqns1Ryg33nqUDEGpkBQiC3E1eZZTVkcJsn?=
 =?us-ascii?Q?eLIif/E/v4rTblE6vcFL2zVw1SbVG4g3QFNHr5y0Noji9vTl1UDsa/D8Pki1?=
 =?us-ascii?Q?EphIgKsPwb0CIBJzU3Puta3TTt/Qmj9H41719FX/fkHxdvKv+5np6VGYg2+i?=
 =?us-ascii?Q?akq7lwQkc6UDVLzazrIkAjhJVwb75elRezmvQgytsi5DKQB6GW/zfr84cGhV?=
 =?us-ascii?Q?ptqFZktQraFJtMalkP/XPZJrMHjWmoq/+71y3YdvHf6gzfecP/mgOLahHD4i?=
 =?us-ascii?Q?vk6kt3E2zWiqx5W5jRk7VVaw0nhOgUtZGSif5W6RbbJxrPrBrzQQxk4fgkAI?=
 =?us-ascii?Q?nk236ojmFh0rGjfbYlXwnpmegKo36p1ujBju4a1OpYJcIwhoHAXs2UJdeXfc?=
 =?us-ascii?Q?Zgr4eCJOhzKq1t7h5PtB+kpelT7yjyhoCm9pYjkkGjFKvZlQavAtPu58dybK?=
 =?us-ascii?Q?XBN/vLrn6zDpvhWa/VN0l2p2XLib20Gj3Z+ETjVu6bLN5kYdC8+xSXpmks45?=
 =?us-ascii?Q?lDIlbQRnz0Z4x6bCfK7aFqBBwu32BykOV2uW1TcHGEAlt4xQwDR6JK09GBqm?=
 =?us-ascii?Q?Lw6acR1TVl8NabSROT7mfkkCK++BN838OE/bg9asyBS8bf1aNoi1iB3uYnRp?=
 =?us-ascii?Q?lEH5duOL5kMRex1/zhrvZqbuMzSBYHAz2mD/NsFA0A8g/8dmTUKsh45W18cM?=
 =?us-ascii?Q?foMkxcEWRbzaTupW+AO5gdBBS8wuUGCekhr15shqf6LTLW0Gdb/0M01gMr9R?=
 =?us-ascii?Q?NBOljvvEzPNsTr2Z5zqJa/7aFoZ02VnOG872nb+BfGDOYIDpLVQ91xIrGPpv?=
 =?us-ascii?Q?Vhvb1hVAkkIGPdZ+/k1H3XCm+Qlgwr55DMi4J5tHTNc3mft4YayXmMrsHTTE?=
 =?us-ascii?Q?CrQTazFCgMJmrSp4iJu0VHWaom3fp/YwIZh8ldx9GzAcVQTYjwVjpmJ3U3Xf?=
 =?us-ascii?Q?GiIB7r27asMBRY2vtc+LFpQgj1mixhmNJtHk6cSrfqh9QoQrYAm/TFvl7QcM?=
 =?us-ascii?Q?FTDurU74XbGErSQGRlOKvhWT8nQZqS7qhkg1oolH4zV0S+pAtafdd22KZRXd?=
 =?us-ascii?Q?/AZVUBn8VwkEsUyB65nz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7ff9e1-d6b5-4357-cfff-08dccc654d23
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 22:11:04.0069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6335

This patch adds test cases for open-coded style bpf dynamic pointer
iterator.

bpf_iter_dynptr_buffer_fit is used to test the case where the buffer
will be filled in every iteration.

bpf_iter_dynptr_buffer_remain is used to test the case where the buffer
will be remaining in the last iteration.

Both of the above test cases check that the offset, read data length,
and read data content are all correct in each iteration, and that the
iteration loop ends correctly.

In addition, this patch adds test cases for failures caused by dynptr
uninitialized, iterator uninitialized and buffer is NULL.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |   9 ++
 .../testing/selftests/bpf/prog_tests/iters.c  |  50 +++++++
 .../selftests/bpf/progs/iters_dynptr.c        | 140 ++++++++++++++++++
 .../bpf/progs/iters_dynptr_failure.c          | 108 ++++++++++++++
 4 files changed, 307 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_dynptr_failure.c

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index b0668f29f7b3..acbc6a1916bd 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -575,6 +575,15 @@ extern int bpf_iter_css_new(struct bpf_iter_css *it,
 extern struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it) __weak __ksym;
 extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
 
+struct bpf_iter_dynptr;
+extern int bpf_iter_dynptr_new(struct bpf_iter_dynptr *it, struct bpf_dynptr *p,
+			       u32 offset, void *buffer, u32 buffer__szk) __ksym;
+extern int *bpf_iter_dynptr_next(struct bpf_iter_dynptr *it) __ksym;
+extern int bpf_iter_dynptr_set_buffer(struct bpf_iter_dynptr *it__iter,
+				      void *buffer, u32 buffer__szk) __ksym;
+extern u32 bpf_iter_dynptr_get_last_offset(struct bpf_iter_dynptr *it__iter) __ksym;
+extern void bpf_iter_dynptr_destroy(struct bpf_iter_dynptr *it) __ksym;
+
 extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
 extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
 extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
index 89ff23c4a8bc..7c17ef8eea70 100644
--- a/tools/testing/selftests/bpf/prog_tests/iters.c
+++ b/tools/testing/selftests/bpf/prog_tests/iters.c
@@ -21,6 +21,8 @@
 #include "iters_css_task.skel.h"
 #include "iters_css.skel.h"
 #include "iters_task_failure.skel.h"
+#include "iters_dynptr.skel.h"
+#include "iters_dynptr_failure.skel.h"
 
 static void subtest_num_iters(void)
 {
@@ -291,6 +293,50 @@ static void subtest_css_iters(void)
 	iters_css__destroy(skel);
 }
 
+static int subtest_dynptr_iters(struct iters_dynptr *skel, const char *prog_name)
+{
+	struct bpf_program *prog;
+	int prog_fd;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		return -1;
+
+	prog_fd = bpf_program__fd(prog);
+	if (!ASSERT_GT(prog_fd, 0, "bpf_program__fd"))
+		return -1;
+
+	if (test__start_subtest(prog_name)) {
+		bpf_prog_test_run_opts(prog_fd, NULL);
+		ASSERT_EQ(skel->bss->iter_step_match, 0, "step_match");
+		ASSERT_EQ(skel->bss->iter_content_match, 0, "content_match");
+	}
+
+	return 0;
+}
+
+const char *dynptr_iter_tests[] = {
+	"bpf_iter_dynptr_buffer_fit",
+	"bpf_iter_dynptr_buffer_remain"
+};
+
+static void test_dynptr_iters(void)
+{
+	struct iters_dynptr *skel = NULL;
+	int i;
+
+	skel = iters_dynptr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(dynptr_iter_tests); i++) {
+		if (subtest_dynptr_iters(skel, dynptr_iter_tests[i]))
+			break;
+	}
+
+	iters_dynptr__destroy(skel);
+}
+
 void test_iters(void)
 {
 	RUN_TESTS(iters_state_safety);
@@ -315,5 +361,9 @@ void test_iters(void)
 		subtest_css_task_iters();
 	if (test__start_subtest("css"))
 		subtest_css_iters();
+
+	test_dynptr_iters();
+
 	RUN_TESTS(iters_task_failure);
+	RUN_TESTS(iters_dynptr_failure);
 }
diff --git a/tools/testing/selftests/bpf/progs/iters_dynptr.c b/tools/testing/selftests/bpf/progs/iters_dynptr.c
new file mode 100644
index 000000000000..29a44b96f5fe
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_dynptr.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} ringbuf SEC(".maps");
+
+int iter_content_match = 0;
+int iter_step_match = 0;
+
+SEC("syscall")
+int bpf_iter_dynptr_buffer_fit(const void *ctx)
+{
+	struct bpf_iter_dynptr dynptr_it;
+	struct bpf_dynptr ptr;
+
+	char write_data[5] = {'a', 'b', 'c', 'd', 'e'};
+	char read_data1[2], read_data2[3];
+	int *read_len, offset;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(write_data), 0, &ptr);
+
+	bpf_dynptr_write(&ptr, 0, write_data, sizeof(write_data), 0);
+
+	bpf_iter_dynptr_new(&dynptr_it, &ptr, 0, read_data1, sizeof(read_data1));
+
+	read_len = bpf_iter_dynptr_next(&dynptr_it);
+	offset = bpf_iter_dynptr_get_last_offset(&dynptr_it);
+
+	if (read_len == NULL) {
+		iter_step_match = -1;
+		goto out;
+	}
+
+	if (*read_len != sizeof(read_data1)) {
+		iter_step_match = -1;
+		goto out;
+	}
+
+	if (offset != 0) {
+		iter_step_match = -1;
+		goto out;
+	}
+
+	if (read_data1[0] != write_data[0] || read_data1[1] != write_data[1]) {
+		iter_content_match = -1;
+		goto out;
+	}
+
+	bpf_iter_dynptr_set_buffer(&dynptr_it, read_data2, sizeof(read_data2));
+
+	read_len = bpf_iter_dynptr_next(&dynptr_it);
+	offset = bpf_iter_dynptr_get_last_offset(&dynptr_it);
+
+	if (read_len == NULL) {
+		iter_step_match = -1;
+		goto out;
+	}
+
+	if (*read_len != sizeof(read_data2)) {
+		iter_step_match = -1;
+		goto out;
+	}
+
+	if (offset != 2) {
+		iter_step_match = -1;
+		goto out;
+	}
+
+	if (read_data2[0] != write_data[2] || read_data2[1] != write_data[3] ||
+	   read_data2[2] != write_data[4]) {
+		iter_content_match = -1;
+		goto out;
+	}
+
+	read_len = bpf_iter_dynptr_next(&dynptr_it);
+	if (read_len != NULL)
+		iter_step_match = -1;
+out:
+	bpf_iter_dynptr_destroy(&dynptr_it);
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
+
+SEC("syscall")
+int bpf_iter_dynptr_buffer_remain(const void *ctx)
+{
+	struct bpf_iter_dynptr dynptr_it;
+	struct bpf_dynptr ptr;
+
+	char write_data[1] = {'a'};
+	char read_data[2];
+	int *read_len, offset;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(write_data), 0, &ptr);
+
+	bpf_dynptr_write(&ptr, 0, write_data, sizeof(write_data), 0);
+
+	bpf_iter_dynptr_new(&dynptr_it, &ptr, 0, read_data, sizeof(read_data));
+
+	read_len = bpf_iter_dynptr_next(&dynptr_it);
+	offset = bpf_iter_dynptr_get_last_offset(&dynptr_it);
+
+	if (read_len == NULL) {
+		iter_step_match = -1;
+		goto out;
+	}
+
+	if (*read_len != 1) {
+		iter_step_match = -1;
+		goto out;
+	}
+
+	if (offset != 0) {
+		iter_step_match = -1;
+		goto out;
+	}
+
+	if (read_data[0] != write_data[0]) {
+		iter_content_match = -1;
+		goto out;
+	}
+
+	read_len = bpf_iter_dynptr_next(&dynptr_it);
+	if (read_len != NULL)
+		iter_step_match = -1;
+out:
+	bpf_iter_dynptr_destroy(&dynptr_it);
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/iters_dynptr_failure.c b/tools/testing/selftests/bpf/progs/iters_dynptr_failure.c
new file mode 100644
index 000000000000..97bec2f39f62
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_dynptr_failure.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} ringbuf SEC(".maps");
+
+SEC("raw_tp/sys_enter")
+__failure __msg("Expected an initialized dynptr as arg #2")
+int bpf_iter_dynptr_new_uninit_dynptr(void *ctx)
+{
+	struct bpf_iter_dynptr dynptr_it;
+	struct bpf_dynptr ptr;
+	char read_data[5];
+
+	bpf_iter_dynptr_new(&dynptr_it, &ptr, 0, read_data, sizeof(read_data));
+
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+__failure __msg("arg#3 arg#4 memory, len pair leads to invalid memory access")
+int bpf_iter_dynptr_new_null_buffer(void *ctx)
+{
+	struct bpf_iter_dynptr dynptr_it;
+	struct bpf_dynptr ptr;
+	char *read_data = NULL;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 10, 0, &ptr);
+
+	bpf_iter_dynptr_new(&dynptr_it, &ptr, 0, read_data, 10);
+
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+__failure __msg("expected an initialized iter_dynptr as arg #1")
+int bpf_iter_dynptr_next_uninit_iter(void *ctx)
+{
+	struct bpf_iter_dynptr dynptr_it;
+
+	bpf_iter_dynptr_next(&dynptr_it);
+
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+__failure __msg("expected an initialized iter_dynptr as arg #1")
+int bpf_iter_dynptr_get_last_offset_uninit_iter(void *ctx)
+{
+	struct bpf_iter_dynptr dynptr_it;
+
+	bpf_iter_dynptr_get_last_offset(&dynptr_it);
+
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+__failure __msg("expected an initialized iter_dynptr as arg #1")
+int bpf_iter_dynptr_set_buffer_uninit_iter(void *ctx)
+{
+	struct bpf_iter_dynptr dynptr_it;
+	char read_data[5];
+
+	bpf_iter_dynptr_set_buffer(&dynptr_it, read_data, sizeof(read_data));
+
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+__failure __msg("arg#1 arg#2 memory, len pair leads to invalid memory access")
+int bpf_iter_dynptr_set_buffer_null_buffer(void *ctx)
+{
+	struct bpf_iter_dynptr dynptr_it;
+	struct bpf_dynptr ptr;
+	char *null_data = NULL;
+	char read_data[5];
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 10, 0, &ptr);
+
+	bpf_iter_dynptr_new(&dynptr_it, &ptr, 0, read_data, sizeof(read_data));
+
+	bpf_iter_dynptr_set_buffer(&dynptr_it, null_data, 10);
+
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+__failure __msg("expected an initialized iter_dynptr as arg #1")
+int bpf_iter_dynptr_destroy_uninit_iter(void *ctx)
+{
+	struct bpf_iter_dynptr dynptr_it;
+
+	bpf_iter_dynptr_destroy(&dynptr_it);
+
+	return 0;
+}
-- 
2.39.2


