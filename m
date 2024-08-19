Return-Path: <bpf+bounces-37496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E22095682E
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 12:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4EF280A89
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 10:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E668B1607BF;
	Mon, 19 Aug 2024 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="laEeXnMW"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19013064.outbound.protection.outlook.com [52.103.32.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A5F15F316;
	Mon, 19 Aug 2024 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062853; cv=fail; b=VqaSYsmbilaun5PR8PHU4DD4d/u2GkElkJ2Et3auicwpLLDJ3TT7jiaKOlTZlmxdk7naXm79dJW72OjLUSBD6Q75iiJwlexFBd52vz0BfRrwpC6E7q3cTuCfrQKsUhiwYQ0QIcuPkJTW7Zgof96U2stQTxm0y33tuYtPZa4trF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062853; c=relaxed/simple;
	bh=Dhefy81E9cEfL5ord7aekh9E3am4uKx5YuQdieh62WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X/3rWj1oWw02ond61+vUlWnpRiKXl8cIxH/z7/1ynR4ngaoJBbx8DRvtqKayGFDNnONNXfkVvvO44NwKmXy8V4xvxXKQMU+WdYh6ZK6YFbpVrVzvxj2/VxD6Ksa+DXGJpyzkpD3H947nodHL91v/N085Bi69IRvCYn89OCNpc7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=laEeXnMW; arc=fail smtp.client-ip=52.103.32.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TetdGcdSMxyDnyMaiG9OJKY4gMocDs7Ss6RDVGdNJI1w33mKdfWFdXLWgguc1UFJrUEz3gxC/Qlnnap1EyNP/BmB2f7MltLWt5D77DcY17MqlSfrlJIO8Wp+2EbUKfKfXTsUNjsnWIa3ryqMzE3VUbCmtk3tHvGBSY5BpfiFU7117tX6eatmViYBJDVTSUZoMe5xQYwMD4yHkpkkJmuBlp8eXXzes66CXzcp4sHpAe5d5norz5wm9/EnAU/f5EyMPMFJwpDrhYXokigHL7foaka2JZubPkDfrtT4dTNDChdbuvfxEZkJQ/A+C1zFN1Ikx7PEz58xmHyXBuyV4i7FxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qa5XMel2MwKksBCeE0KrhC1Jb3sMC7a7F8FMvWelbvs=;
 b=JbOy+hErI55yS2bxFmi6DMSi/z4iWPUfQgbNHg55l12atT1gcSBqObJmvjJv+YvpGW4PoEVJ2RstuBkKgpkV1TiRMZNUiFpQJOEXIAl2uB+ksFcV0QYl63rokKOmnT87MalCHjnwrlpIt/OC9ONDpMvtoAFG0F1rQ3+stX245fbuSJPZylrpuO+Vovh72YfFoOxVX3lQtlhRWCRCu/dzCD6iA+oAjRynRf1UXRenyDspYt0c6PV0jzLwe8FnZ4oUzFoGCH8Sr0rrzb3V5p48UvFu3seHpjy6NO851L3a8k8aRjf6I+2vmVFfBCMKvARDlEyoGYtAp06K1ZIYPXT5Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qa5XMel2MwKksBCeE0KrhC1Jb3sMC7a7F8FMvWelbvs=;
 b=laEeXnMW1+jU3fb+P/Hy0NZyOzHfo1zj4DSukGDuZJqp6teZ0ZjxtUr5VCaotXrOv+U4ie9gliD99DOQoX+UvhKsI0vh+4j+8Wg96u5gQ83Cs9zk7LY/oaAxsiH/YTE6erMjve47oKZPzQoMIyoX2m+UuQNGmgRuooUcPe7Y41O59Bwz+AFsrdoXe3vInS8Br1jimKaX3MgqNrZo7RVamGVJBvDR43TWk5kCfQt/4wNP26Df4sO0GZpc82nk9+CIWsvTplKZzb5d6g+KURz+iW66O/+RwPss2eEG4b45XGUE2tbQT5CML9g64DqkBpjo+3nMrp0YHMWmY5B78niIpQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by DB9PR03MB7291.eurprd03.prod.outlook.com (2603:10a6:10:221::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 10:20:48 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 10:20:48 +0000
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
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for iter next method returning valid pointer
Date: Mon, 19 Aug 2024 11:19:21 +0100
Message-ID:
 <AM6PR03MB5848FC9C400BC2B645276674998C2@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB5848FD2C06A4AEF4D142EE91998C2@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB5848FD2C06A4AEF4D142EE91998C2@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [C1wkyTxqE+d32M78Y2MqmRlFaEVz+h8V]
X-ClientProxiedBy: TY2PR0101CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::25) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240819101921.63606-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|DB9PR03MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: 3beb64e6-ecd2-464b-fa7e-08dcc0389815
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|15080799003|461199028|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	WKO5n526cj1NKZ97tLBXtSjDsmoJtcnqjErEo927Hd9kOlU10eKK5jatNKpb2evYovPoNl64KKcBSXzIe7l2nTkc/6VX0y6uiIx0SAO3pdEUAUHJZNjo6L8/VwNyYxIgQbHsTaKp+ViLIOzGic8KOswHMh2dbK6xJZ8/oTI826Pm6HgwphNYhM94+DgDr/0We4uwbaw5mFajleRlb491kC0Tkv25IvDMavBOt8WkI4SunC21MUW0zJNqEppqsH2LQJj4+jqGNKtIUQ/2Hii+29dZiN1zhismzJ8TQtDK1i/w5XIuFcnFX3uxKCxSMNZZHnEfHJcKDdTymKd+JpihLE4F6LioMnIMWsWGbH/uni+0lzf4LlBCwNAUvugo4bcgM3tmcCVEP3fizHbwjQVS1FUaTEf2XTocldz2W2UedWkmRZK2LIcscXpjxs9BM5jpuK/CjVm1Lwr41szDi8ugsvMkbqIYtJawDBK99lMknV42kwqZ0dFLl99PG01qpfgZ1RAJI/YdDsCTl8xj1ZgOB1s+UYPJjEhwViV4DdyndZupXnTfxiUjiSSTJsRzG4mmbGfU23E0X/o7F9RY+QDtq9/kM9qjr0DayCnuHo7HmRy9/vqThfKFBswHU2Y5zCcvoo31hrFdDN1gDPxUVc+wT56l05uRMwkrnedl1zL167iWsBc1HsiXOXZhnnBj+CT4Uv+Uky8wB/yO6V1Y4R2j7Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Xad8LP72fzDvdPoJcR2MfIAz3IdcJ28ZglN4sXsWSzWUvK0bVpJBWZuGV8f?=
 =?us-ascii?Q?JgV915Dgd4T8DTiXoR7KsWnDnkicn6P4fY9Ca1ZJM1IHklJuLRb8P0u68gF0?=
 =?us-ascii?Q?Knyheod8xiey5dtFcWx/278FFR3g5s2EQIceuqUmeNAMZo6k1Dvw/zBAo3aH?=
 =?us-ascii?Q?CNgZ2axl9O9fQLOs6RLJkxmiR5okG6rYVh23igw0gkwNAwyVy/qHagbH8gAy?=
 =?us-ascii?Q?O8/fd3p6mDVc6sjwRWqmV87CvPY24WjvifN2NLTH1Y6j/kq1wt/QbNSYa9lH?=
 =?us-ascii?Q?WCLGy8zv6dhx51e00dMqHWJeRpEnH6bXz1tAYkG2CSQg4P/kTGideZue61uL?=
 =?us-ascii?Q?15GzwzEr4uS1f8ALgBW2RXcLPCoDVeqlJ+k+0UNJ7AIugpRk17p/yNHIZw6J?=
 =?us-ascii?Q?LRFw6utSTI37CKTJr37bm2ZAkyKToCOwoW4daRPFpQHsi65IjgjNmwNuxcwZ?=
 =?us-ascii?Q?2P+3hKeujjypJOG+1iI2VaqsrmZazekl1Bniy97P4yGRCRUjSvWwpwAB3/fV?=
 =?us-ascii?Q?FnTJK0jnf7P9P/JLX0nxiWAPPEztlZHeEOqLC9wxqVIyF5RyCNM6kwyZBwEm?=
 =?us-ascii?Q?QYE//7Wy3DKjOOvOFidjvof+4c/fur6/ObY7Z86iltoSdtn7e4Cc1+gkknWo?=
 =?us-ascii?Q?8UwkzBocR417HmfdoKpIW0KNwSCvr71gLMjLPptD64D2bqpuBtnYMUtrX3b1?=
 =?us-ascii?Q?AqpDOZKp4SAzU0EHIFzlNE4ufRz7j+5etBYsqNGo2r5dr8j/ETeX4QBISzbO?=
 =?us-ascii?Q?RQQdTtJv/moSNNc3wSXzlCGyUid33N3pXkMnJ5IsyQCnPp1NRgOQbBCytb8H?=
 =?us-ascii?Q?p+l3AsDw63Mj4ZVCDlY3bxcoBlUepF5Sh1C7bDyJJHy7YP3+L4OxQuuo/DjQ?=
 =?us-ascii?Q?D2JkuwAdGmnrncNe5QO7EWIaOhQ/LpAsh3Jv/JugWQ1ae0oCjgd97Hu068Yi?=
 =?us-ascii?Q?bCrauC4D2XCLaplgiX4DQU9zDpigEQpPh73Zb4t8gSADZnTCw2q6BRNa2uYA?=
 =?us-ascii?Q?RdtedgOs1xKBx8IDFV+D5c/6VmqF2liPnjol5E9B7X68GEz/a9AK38ZhUNK3?=
 =?us-ascii?Q?VY/YHsxFHhQsNOJmTxg1lDJINo0DuqClZyjSRGYccCj+vKkS+sp2AuQu5XR5?=
 =?us-ascii?Q?v4NuS+gUnb5LkRgxj9+hFTzsP40HcEEFv1KOMlx46rfSK4oHDW5euHIhMutf?=
 =?us-ascii?Q?z6JzSFCiHBZxNQK9yQ8CoxD6rj2AamK3uftjCTkYBiLgqd4ZrjHhP4PGOKGU?=
 =?us-ascii?Q?MFC/OP45Eb1tg/Vmd6FT?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3beb64e6-ecd2-464b-fa7e-08dcc0389815
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 10:20:48.6216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7291

This patch adds test cases for iter next method returning valid
pointer, which can also used as usage examples.

Currently iter next method should return valid pointer.

iter_next_trusted is the correct usage and test if iter next method
return valid pointer. bpf_iter_task_vma_next has KF_RET_NULL flag,
so the returned pointer may be NULL. We need to check if the pointer
is NULL before using it.

iter_next_trusted_or_null is the incorrect usage. There is no checking
before using the pointer, so it will be rejected by the verifier.

iter_next_rcu and iter_next_rcu_or_null are similar test cases for
KF_RCU_PROTECTED iterators.

iter_next_rcu_not_trusted is used to test that the pointer returned by
iter next method of KF_RCU_PROTECTED iterator cannot be passed in
KF_TRUSTED_ARGS kfuncs.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  15 +++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |   4 +
 .../testing/selftests/bpf/prog_tests/iters.c  |   5 +-
 .../selftests/bpf/progs/iters_testmod.c       | 105 ++++++++++++++++++
 4 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_testmod.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index a80b0d2c6f38..2cf0716ec64e 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -176,6 +176,18 @@ __bpf_kfunc void bpf_kfunc_dynptr_test(struct bpf_dynptr *ptr,
 {
 }
 
+__bpf_kfunc void bpf_kfunc_trusted_vma_test(struct vm_area_struct *ptr)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_trusted_task_test(struct task_struct *ptr)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_rcu_task_test(struct task_struct *ptr)
+{
+}
+
 __bpf_kfunc struct bpf_testmod_ctx *
 bpf_testmod_ctx_create(int *err)
 {
@@ -533,6 +545,9 @@ BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_kfunc_common_test)
 BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
+BTF_ID_FLAGS(func, bpf_kfunc_trusted_vma_test, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kfunc_trusted_task_test, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kfunc_rcu_task_test, KF_RCU)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_create, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index e587a79f2239..db657f7a7802 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -144,4 +144,8 @@ void bpf_kfunc_dynptr_test(struct bpf_dynptr *ptr, struct bpf_dynptr *ptr__nulla
 struct bpf_testmod_ctx *bpf_testmod_ctx_create(int *err) __ksym;
 void bpf_testmod_ctx_release(struct bpf_testmod_ctx *ctx) __ksym;
 
+void bpf_kfunc_trusted_vma_test(struct vm_area_struct *ptr) __ksym;
+void bpf_kfunc_trusted_task_test(struct task_struct *ptr) __ksym;
+void bpf_kfunc_rcu_task_test(struct task_struct *ptr) __ksym;
+
 #endif /* _BPF_TESTMOD_KFUNC_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
index 3c440370c1f0..89ff23c4a8bc 100644
--- a/tools/testing/selftests/bpf/prog_tests/iters.c
+++ b/tools/testing/selftests/bpf/prog_tests/iters.c
@@ -14,6 +14,7 @@
 #include "iters_state_safety.skel.h"
 #include "iters_looping.skel.h"
 #include "iters_num.skel.h"
+#include "iters_testmod.skel.h"
 #include "iters_testmod_seq.skel.h"
 #include "iters_task_vma.skel.h"
 #include "iters_task.skel.h"
@@ -297,8 +298,10 @@ void test_iters(void)
 	RUN_TESTS(iters);
 	RUN_TESTS(iters_css_task);
 
-	if (env.has_testmod)
+	if (env.has_testmod) {
+		RUN_TESTS(iters_testmod);
 		RUN_TESTS(iters_testmod_seq);
+	}
 
 	if (test__start_subtest("num"))
 		subtest_num_iters();
diff --git a/tools/testing/selftests/bpf/progs/iters_testmod.c b/tools/testing/selftests/bpf/progs/iters_testmod.c
new file mode 100644
index 000000000000..570dfadd4648
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_testmod.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include "bpf_experimental.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("raw_tp/sys_enter")
+__success
+int iter_next_trusted(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct bpf_iter_task_vma vma_it;
+	struct vm_area_struct *vma_ptr;
+
+	bpf_iter_task_vma_new(&vma_it, cur_task, 0);
+
+	vma_ptr = bpf_iter_task_vma_next(&vma_it);
+	if (vma_ptr == NULL)
+		goto out;
+
+	bpf_kfunc_trusted_vma_test(vma_ptr);
+out:
+	bpf_iter_task_vma_destroy(&vma_it);
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int iter_next_trusted_or_null(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct bpf_iter_task_vma vma_it;
+	struct vm_area_struct *vma_ptr;
+
+	bpf_iter_task_vma_new(&vma_it, cur_task, 0);
+
+	vma_ptr = bpf_iter_task_vma_next(&vma_it);
+
+	bpf_kfunc_trusted_vma_test(vma_ptr);
+
+	bpf_iter_task_vma_destroy(&vma_it);
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+__success
+int iter_next_rcu(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct bpf_iter_task task_it;
+	struct task_struct *task_ptr;
+
+	bpf_iter_task_new(&task_it, cur_task, 0);
+
+	task_ptr = bpf_iter_task_next(&task_it);
+	if (task_ptr == NULL)
+		goto out;
+
+	bpf_kfunc_rcu_task_test(task_ptr);
+out:
+	bpf_iter_task_destroy(&task_it);
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int iter_next_rcu_or_null(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct bpf_iter_task task_it;
+	struct task_struct *task_ptr;
+
+	bpf_iter_task_new(&task_it, cur_task, 0);
+
+	task_ptr = bpf_iter_task_next(&task_it);
+
+	bpf_kfunc_rcu_task_test(task_ptr);
+
+	bpf_iter_task_destroy(&task_it);
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+__failure __msg("R1 must be referenced or trusted")
+int iter_next_rcu_not_trusted(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct bpf_iter_task task_it;
+	struct task_struct *task_ptr;
+
+	bpf_iter_task_new(&task_it, cur_task, 0);
+
+	task_ptr = bpf_iter_task_next(&task_it);
+	if (task_ptr == NULL)
+		goto out;
+
+	bpf_kfunc_trusted_task_test(task_ptr);
+out:
+	bpf_iter_task_destroy(&task_it);
+	return 0;
+}
-- 
2.39.2


