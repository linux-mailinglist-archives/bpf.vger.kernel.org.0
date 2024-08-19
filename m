Return-Path: <bpf+bounces-37498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7329568B5
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 12:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C951F2297E
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 10:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DFF161924;
	Mon, 19 Aug 2024 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="miVRjeOK"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011039.outbound.protection.outlook.com [52.103.33.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C4F161900;
	Mon, 19 Aug 2024 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724064201; cv=fail; b=MIkAvmAfTTEUYqAcEMqqm3cx+At085PbmXj6njaaN7U+Au1WgnxYMjg+g2eEAWgDS4c32c90BOSzHViibHARUH89mxeu6Dws90NAE8FTwrQWrKlLiklxdVTCamz4LgqMDStp/xRI4kweWjVYFNI24GUBwyc01mzLZgQyYMyZiX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724064201; c=relaxed/simple;
	bh=rdaIFE0NiWpP51C0uxD01pnWASTMvM1e6sRI3rnWPsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bW2o91iL3cthPw16Q6/XlHuj7AwhFEKnewirAa+hz+7q8SESjqghIbveLNATuu8h161E4+zTF5tsjYTK+plDrO4uzAXz6OefPgSId2Hj8Gv1xSlUOVn6BYIA5Wzc+EaU26skkszB5VBamD3xaD/0x63UObtaQNVN7C9RyKyJfOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=miVRjeOK; arc=fail smtp.client-ip=52.103.33.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2rRQUJTMJC/26+lEnH+s5cKguoUDJYO9pStgFxudgsVoReG147uOfl14C8NPyASsSwhexGEtqETsDw2ZUaUlKnMaQtpjusqHig13ggPVGSZdk5h1ySi2p1I9X/jSuDB/tTQTyV0ECqxGvvA5oQ2zfKNhTpYVoV3qRTGoLzUEZhknieKK8gH1F9k+dBVjgEYCd9izkUfVGMx+JS02si7LysXAE2MyafFmF7esvmJipBiaw+VkT8HPNNgM2KYd7cReKG6a0BZcrtT8YwSrwTyFhJMs1vakx7KCWXvfLaD+5xyKGw4t/B9Cm1PHSR9IeFC3Jf4Vc5U5pVg6fJUxYOupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lr8RHn1jNbnFR1V9rxx6tiA2Jy6z3HKTSJC8moorins=;
 b=E+sVERavS39Xptw67HlB4XcN0dNqNYpRP9zOhrYWh+29bsG95fWwWtGMT5nFxZvRLhYAk/4qBpTcRlg72zI2qz08wegp0Gam2jkuccwHjwL6VhXhXftFjUWMDkoFb6tSubT/Lh4tbxTonq1DOPZHnIQJksz12TO/ZXtxyfFNf+tSB6wUfFUdLFDKLRWq+gX4+ZCnKjLgk+QfKs+CaBD9GNUUKFax7vPi2K9wPw+iDLEyQ8zsUsrYaXxMOa6UqJk591XTIYTu4t+9HGaV0a4C1vKzHTwqsOOX89RPOynpP0E0vqWNf5Gf4pmsuHye/T2ocSXdpCluTCoaR2y4kQ5n4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lr8RHn1jNbnFR1V9rxx6tiA2Jy6z3HKTSJC8moorins=;
 b=miVRjeOKXwHTJmf0Q9Le4KrPEr7zQKHNuFzx9aj+CpGls3N+S5bqC3CZBAsjUuDcYaNInQWpOfN+WsK1cKJkUVuRKjc9Z8K0s7NYBjf1/XoY9+mdnM5kH3Z+xvhcGPVaQmLlmVCo+F6K9O7V8zqRbY79GAwck2slbFBZkM+9wxC5kL/iOKvhgSJ371G14bCW6IU1RvOtX8GOAIjjfd2fnceGCp5TodSg2NZcLoFCrvLk9+FDi9tGDkJo85XEXh/P5oC38vmYHYazV3E02RrwrlyGPJMzTkgCD8IX/SwwULC2zxmwHwf3mjptOmpq4PkVr5VaoZyMkYsna6rtjROs0g==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AM7PR03MB6401.eurprd03.prod.outlook.com (2603:10a6:20b:1c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 10:43:17 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 10:43:17 +0000
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
	memxor@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 2/2] selftests/bpf: Add tests for KF_OBTAIN kfunc
Date: Mon, 19 Aug 2024 11:41:58 +0100
Message-ID:
 <AM6PR03MB58486DBFF75942D1174DCBF2998C2@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB5848B74668D71BB307BE59BE998C2@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB5848B74668D71BB307BE59BE998C2@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [tLXumzPO+D8h377sEV9yjnBIka084yQd]
X-ClientProxiedBy: SG2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:3:18::33) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240819104158.67204-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AM7PR03MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: bda3fec5-0b6b-4639-0263-08dcc03bbbe5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|15080799003|8060799006|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	0bj0pT6qB3elGbXpSqwpGEwtDRZgdg6sfMwoc2QKshQdcyBuXqgJRC7GN+eU/mtvqzzf4aEAfImNa3NPOGBqUqqiKS7gQanRBVDvnFVktv2+0rHkH/XhLvXbaS2h1PZ7crhVefpEfNxjeE74O+fLVIgt0VDK36mWdRX651hRq9hZerplEHwGpk9p856JA5dEGf5ekQHnfU7COjWL/dESZOyOYBR+zzShEK+Vve1Hyn5WsGuY5rCmYv3M04Nc5I6AUNeM/yoquAUo498W9Z19CHAVcgZ1/G8nGuGBlExsiRCbhIUGmHSlfxSACYHwtITQKfQngkMN1JdybTi1f9j+CUuLvKlY3eqqPsNq9TB1dy6CC/fruq9mNwylfFsv10IVYJia50565TBZR+bkprqhV9ZXlM9wehoQWdShp2ZS/8CoBcBmGSEBogX6J0z/tdgESfBIUsbk5eFam96mtI3bPY4cKUi7HXh/XpD9SbbcOMou1hIXdSF1fSP9LEZlVvKLssbqtbmlocHZ6Kbe5v7ZVLJx/RSSJvvU4LMmqror3+sPyFtkYUlnUrWG93paq/jW1QUIYrPi5J7MZIgfV8Fg4nq5T9ZJNSFkl4N6N2aIbHgFSyQCKTjtfJ7GjeComtKWvVxTWlAt5eTipowStX1HZAKmwx508nLvfpOV/dvlmkjFRmrMNsSRVolAOSw/prfmAjQbL0mNPD+1hRD9neqdwQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yeCy0W4f4xw6+mr00wOcmpBUPHaHOOgyhVhXY6P0u8l56UOm4NyTSzetpF+0?=
 =?us-ascii?Q?wSV9cdK+sdDjgDwJH3ANX86lodbv/y9ZKv/SGpLNmrW3qpBY2zyirY1CvzLT?=
 =?us-ascii?Q?u/1ha3qm86HIDn1OLnRNkt/dub8y6Ow69whawtFQ4j5mxGi30EmjfeFjNaOS?=
 =?us-ascii?Q?7cr6XdueJIHn+f64hWqGIpe0HiJ8LGqR4h4x14Y6C8H+RbdnTOeIa9HBHHEU?=
 =?us-ascii?Q?8Kdybk1GRNgKbyPM2hmDWo3Eh/jEIlFyAXgXjTEBBF5+kgziRkTye+DuHEZ+?=
 =?us-ascii?Q?bpEWiWe166g893Q42mCebF9WkvDIvFlJafqcLUGm1YXLRLUeAaAvtiXug4dS?=
 =?us-ascii?Q?BlCT4Iq1Xcy6x1FEFW+gWGRtYow1pEvpkMUsE/hjp2K8OTIuNrjcBH7Pkr8m?=
 =?us-ascii?Q?i0x53KlQrIRc8yb9AbIykHBWiUm41MY3PQzsyqxbvRk9Z5jMmiZ/0g01BwyD?=
 =?us-ascii?Q?jGTkj+GPKgM24I9UOUcTQp9Li+XhSECfl8a3BdwDo5IHeezo9GB07nCWehGy?=
 =?us-ascii?Q?a5bXdXPvt09t0HCQf44CMRSyW+L16Z2nOz1leEXrlf1Sc+HxEjpKaFszESMy?=
 =?us-ascii?Q?McZeokbKwvLwf1KuaxGUTy8eaW8rGgi8i9zZIXGUMNuvSD8b5lEGsQprqN+W?=
 =?us-ascii?Q?ZoSAqP+ZxFTG+82EtLzmOqEXdQhL0X/KcRNh2XeiLnx30Y3snHkB3aEvYs6j?=
 =?us-ascii?Q?3Jwx1ZvvTjwEqlNtHbtBteqsoI/BYB3ktuOiUNdxIB7Y6aoztmxIxN15x6Dc?=
 =?us-ascii?Q?YOldaMClvvmHse4vcVEMtq+eGNLhmCMcb56iKoYQHNBbc71gFQIVTARryks+?=
 =?us-ascii?Q?EDuoczGQTn3vTnUjWCFUGeYtuzlJJJH4KNzCJJ78XoCQQQ1r68xg+SVrSsG/?=
 =?us-ascii?Q?WgtHMhyk6OQIyDBENzERZkBVLeaYES7O1M2PL0UYTIuP8DHUAq0PRr+khZQ8?=
 =?us-ascii?Q?108KFoBVciJ9CaecT8+urD0i3RNM49voBV58z7dxTicomw+TGk24+tbW/hpf?=
 =?us-ascii?Q?SYWwelXr81aMmk2QHA6zQngo+aSusZGo4cg1k5JLRccDtZr2IBE6kCMPSy3r?=
 =?us-ascii?Q?vMdkcYIRDDUdnKl8b+obpQAnaPG0g7BV9cYSRGZHr0nH1kUgi0crUAWK5j1d?=
 =?us-ascii?Q?ndcRGvNqaOPp+rAyykr2Dp1XUhKlq8CK2YN5HzWm40rxuw/poXnCBfz4ub1k?=
 =?us-ascii?Q?pLYZr/ccuEZtIccAHeV9sVeHrAwfPnTXF1dTflwsMTC1dNLZ0P66gLQyctSz?=
 =?us-ascii?Q?tC+/S1itB+Js5y98wj+U?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda3fec5-0b6b-4639-0263-08dcc03bbbe5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 10:43:17.0228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6401

This patch adds test cases for KF_OBTAIN kfunc. Note that these test
cases are only used to test KF_OBTAIN and are not related to actual
usage scenarios.

kfunc_obtain_not_trusted is used to test that KF_OBTAIN kfunc only
accepts valid pointers.

kfunc_obtain_use_after_release is used to test that the returned pointer
becomes invalid after the pointer passed to KF_OBTAIN kfunc is released.

kfunc_obtain_trusted is the correct usage, valid pointers must be passed
to KF_OBTAIN kfunc and the returned pointer is only used if the passed
pointer has not been released.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 12 +++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  3 +
 .../bpf/prog_tests/kfunc_obtain_test.c        | 10 +++
 .../selftests/bpf/progs/kfunc_obtain.c        | 74 +++++++++++++++++++
 4 files changed, 99 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_obtain_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/kfunc_obtain.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index a80b0d2c6f38..2e8a72d94c28 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -176,6 +176,16 @@ __bpf_kfunc void bpf_kfunc_dynptr_test(struct bpf_dynptr *ptr,
 {
 }
 
+struct mm_struct *bpf_kfunc_obtain_test(struct task_struct *task)
+{
+	return task->mm;
+}
+
+struct task_struct *bpf_get_untrusted_task_test(struct task_struct *task)
+{
+	return task;
+}
+
 __bpf_kfunc struct bpf_testmod_ctx *
 bpf_testmod_ctx_create(int *err)
 {
@@ -533,6 +543,8 @@ BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_kfunc_common_test)
 BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
+BTF_ID_FLAGS(func, bpf_kfunc_obtain_test, KF_OBTAIN)
+BTF_ID_FLAGS(func, bpf_get_untrusted_task_test)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_create, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index e587a79f2239..cb38a211a9f3 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -144,4 +144,7 @@ void bpf_kfunc_dynptr_test(struct bpf_dynptr *ptr, struct bpf_dynptr *ptr__nulla
 struct bpf_testmod_ctx *bpf_testmod_ctx_create(int *err) __ksym;
 void bpf_testmod_ctx_release(struct bpf_testmod_ctx *ctx) __ksym;
 
+struct mm_struct *bpf_kfunc_obtain_test(struct task_struct *task) __ksym;
+struct task_struct *bpf_get_untrusted_task_test(struct task_struct *task) __ksym;
+
 #endif /* _BPF_TESTMOD_KFUNC_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_obtain_test.c b/tools/testing/selftests/bpf/prog_tests/kfunc_obtain_test.c
new file mode 100644
index 000000000000..debc92fc1acc
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_obtain_test.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "kfunc_obtain.skel.h"
+
+void test_kfunc_obtain(void)
+{
+	if (env.has_testmod)
+		RUN_TESTS(kfunc_obtain);
+}
diff --git a/tools/testing/selftests/bpf/progs/kfunc_obtain.c b/tools/testing/selftests/bpf/progs/kfunc_obtain.c
new file mode 100644
index 000000000000..8f0e074928ce
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kfunc_obtain.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* The following test cases are only used to test KF_OBTAIN
+ * and are not related to actual usage scenarios.
+ */
+
+SEC("syscall")
+__failure __msg("must be referenced or trusted")
+int BPF_PROG(kfunc_obtain_not_trusted)
+{
+	struct task_struct *cur_task, *untrusted_task;
+
+	cur_task = bpf_get_current_task_btf();
+	untrusted_task = bpf_get_untrusted_task_test(cur_task);
+
+	bpf_kfunc_obtain_test(untrusted_task);
+
+	return 0;
+}
+
+SEC("syscall")
+__success
+int BPF_PROG(kfunc_obtain_trusted)
+{
+	struct task_struct *cur_task, *trusted_task;
+	struct mm_struct *mm;
+	int map_count = 0;
+
+	cur_task = bpf_get_current_task_btf();
+	trusted_task = bpf_task_from_pid(cur_task->pid);
+	if (trusted_task == NULL)
+		return 0;
+
+	mm = bpf_kfunc_obtain_test(trusted_task);
+
+	map_count = mm->map_count;
+
+	bpf_task_release(trusted_task);
+
+	return map_count;
+}
+
+SEC("syscall")
+__failure __msg("invalid mem access 'scalar'")
+int BPF_PROG(kfunc_obtain_use_after_release)
+{
+	struct task_struct *cur_task, *trusted_task;
+	struct mm_struct *mm;
+	int map_count = 0;
+
+	cur_task = bpf_get_current_task_btf();
+	trusted_task = bpf_task_from_pid(cur_task->pid);
+	if (trusted_task == NULL)
+		return 0;
+
+	mm = bpf_kfunc_obtain_test(trusted_task);
+
+	bpf_task_release(trusted_task);
+
+	map_count = mm->map_count;
+
+	return map_count;
+}
-- 
2.39.2


