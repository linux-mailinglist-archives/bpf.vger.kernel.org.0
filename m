Return-Path: <bpf+bounces-38384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9098A96422A
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 12:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43ABF283D6B
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 10:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D899D18E042;
	Thu, 29 Aug 2024 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pfOkudcI"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2096.outbound.protection.outlook.com [40.92.49.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDF115AD9E;
	Thu, 29 Aug 2024 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.49.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928467; cv=fail; b=sE9fGT5jP4lwxv28EBJIKwnVscGfF1fdM6EtOK26FEoCyd9FuzVB1fYiaOYxj+ype5kOHalYeEW3woiHzSUw3friOWTTRNJMD+0HkuFbx7Qw8Vdy2EjLSmaZC7Myautr0yZsE1+6TkWbykqp4wxeGvjG0HGng53vKkxdEVS2Lok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928467; c=relaxed/simple;
	bh=A5V5/XbGEc5SroLnclBlFbsD0EJltvVJew9pg2zeQgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B1Lf/sFHGu8IFhP6xKAh+3swZkzQXGCsehWZuA99v4ttLnVhTS2esrDEKi7uupeQ4jaaeTrTaAPGSWPn5BNEfkXEPXg8ul/+G1i2rSSC3n4ipoJCWxc7eTTthZ5aKJAHnRuPqh7o0Y63QcNeIBfb2t7FrphRlEH0W5Mj5ezhLTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pfOkudcI; arc=fail smtp.client-ip=40.92.49.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfK3dp9+pZ+OdlNI1x77S9Zr0dtM5nS08h1r5y3BIPkdRJOG9wVR+o7tKn3TbAfjG4VOY4IoqUAxgnoyeWwySGe+9dwWhRzqySFlXoz4c3yg8oayLako29GUP+KEAqjmAYBYK6+Z4QaHig1sXbcnHhH4bLhE1MEsUHcgI3erJFZLN4k1l06QuKYUm6hGZHXjxa03SjpUkl0aZfYkOd+yLWQRDsdPbZCrCG7gYpCYhTq6xMTKX3D4anU89nNkYS3eXOQo1rm0GqD7FJfY3eLcFVml+0Mt2pKK1STv7CeQr1VM3ZJMxROaU1gOEgSmYDOnTu1d0O71Ovx28eKb/U0h0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50/Qrmy96M9zZnlXy21WkpIVBslH/oeNbAqqpwnyWxE=;
 b=jbG9hoU9TYfFSW2wSb5xkMCFyDB9TiCyeyzs3q0Oq88OeMyi1dnquRlcaGiytMGau7zFmkBpbpvzDAQu9ef0+A49pjAf/hy9iq0JL1ImzvTiu5t1+8Qn798ozjHt2pFhQSe8ccZYvjIrIAxOn5iAc1M2nmg8LLhQEf0OsLWPWWhLnaKVvaVjeNPi7bT/sVJYc1Xx3QvoEqwaMz62uCxU7KZHaKm7iI4CnTVj670IKP6hi6tDHKcqHlHqB/Cno67sPooGWB6SYZLuteQrrL1pkTgKlJDGaX+z/uvKXPU4OP1YkJ4dwaMwQS3EylzNZVsDl92jEVvqfSaooWuf9raXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50/Qrmy96M9zZnlXy21WkpIVBslH/oeNbAqqpwnyWxE=;
 b=pfOkudcIbNhbx1F/JvYeftzLsTexM5Lyxuu9RCJwNSqqpG8Gjq/VYso7abxahKZFsmmQnwHUOv3qUv0etiLc5orOO9IDljVDCgkLnjQamNq99x8oWGoEfzD6IwnyVmsNY+9x1/xJtjK13+7giWXLoeqh4JaMWkWzeK/9MZB4yXRhovzqgqPayU/G01/MKWILQGF9Chd6qkGzJfeOh08AmCHLJig9LVClW3iRo+jrUE3qA8F46QIt8tZDlZx+9kX+r4kE0ViWpr/42HMA1N7TMR7OyXW6TeV19Gv4QgDkdGJ3YBcwftnk8iYcpjbty8M5Hur951DCrQMspkq3YGGFUA==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by DU0PR03MB9125.eurprd03.prod.outlook.com (2603:10a6:10:464::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 10:47:42 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 10:47:42 +0000
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
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add tests for iter next method returning valid pointer
Date: Thu, 29 Aug 2024 11:46:55 +0100
Message-ID:
 <AM6PR03MB5848706D6E610747C4BB6F9999962@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB58482E9A154910D06A9E58B499962@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB58482E9A154910D06A9E58B499962@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ycbscVG2HeRMY2yf47tHAQCVd5riZ8Wl]
X-ClientProxiedBy: LO2P123CA0097.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::12) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240829104655.10791-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|DU0PR03MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f67f2b-edb1-4ace-3abc-08dcc818021a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|15080799006|5072599009|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	BweUasXYzkyNqMBRKUKGNpjo6JxBqYDk38XJaQeu3zVETgGe09+NpjYX5nslVjlhNdzoeSuBgNe5qfLfzwhA9CMl3K0k+G/2glH+Vq0ZjVXtEjc+GE4hLH+bqU/FPm38nq+3ZYz/SYoV6lVgnisOWkheXujOQpBRfb6wjXekUj6jIp1rF5u6Sod2bgpUh2sF2Xnhh5yrJ2SaeZcx8QCz1nwRwTwM2At+Hpu5S9XOtPLkshqAKYr6AmWkem5j6i/MQU7+XAUL6von2PRuQPwhN3h8PS+ZPlF0OvCqCxLAhOa0GQsz0/h3VxVvjx/RwnhCnD1i/Ie3oaSxcD2UHHyBFXTXIN0qEDXayiuYzy83ifgxvLePjeOmNeMANvR2HovkG/AFcxjA5LbKCh0zEjciCMVA9GY4CoDdUtmrmUBNUa1ytJOhTF5OkSSZDgmxqp0fvNt24sQ1HuUoJ1C1SHuZ+u2Vv8i73/J/ty8sa56Df3WfQdosCXe7C8r+qsxFNrLQlPvMs/hwcKUP271BYuTX/ivzCf98Quxm2a9TyGMXNHTNZncztzFijF16xp+Y/EEe0Vsob79jo26LzseiM6OOL3BHMT7BJGfSslox7yC03Ahgs6bZXX5u6fEpeFffmsod1IAhrQiZq/7yVUZKJxG+JxMJ8wqNhVY4KksCF+o+09+uA1i2++pYXS56iCjeSec84C3ZTEP6yfnYPayn7llOig==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dk+h7mnZaGXop2fVvIAxuXsamRsIJXFXZRU0Z+kkZcJFndsyU9JkOybT8UhA?=
 =?us-ascii?Q?zJILXGebBfZ2bNN+ZdsK+i/6OA/uBf4V0qCCl43rBu15T0V2+exeGaEJN01I?=
 =?us-ascii?Q?7LEu1IzoYDzHXa80MSP3TmITEzXAUQSJkWVY0qLAtLfEYn2DyNACfT5DnX4Z?=
 =?us-ascii?Q?az3tg+0BVwona0o/c2aW51l+CmX031yT+8YIQ9YvFvvwiNPyYvuBLD6tQZps?=
 =?us-ascii?Q?AmDUlfPMO6MyNgr9y5NOEIjefWSzn+e8ZBDBcRA0B1JoJwwUmf9LyB95DJqj?=
 =?us-ascii?Q?q72crWAuBs0CuKo7nEslzofDvE1NUwh7KLTR2on+TGJiPCCTf6stWwqoLl9W?=
 =?us-ascii?Q?POPjs+CAR5vhZTEP95sU+vqK/a2sgec/tgIfSToRt0LMO4FubqcE45W2qfsC?=
 =?us-ascii?Q?191ydQLjamoyIF8eoCJLThAESijtfwUMr42JbzkAQBfoKaeXcfrHu3OkQ9fW?=
 =?us-ascii?Q?ET5m6PbB4pE2RsmKVrKtME8e707HST+dOdxaWN9vKOAKLoiJH1EMdhKvdZ/D?=
 =?us-ascii?Q?mhwEEhsATcI31af7ug1BO/21wN1JGYJ6iacawRn8q1sGC6bqKSf/VXpn3LCJ?=
 =?us-ascii?Q?jLkHwQXcD+l6K7eQuNHYfK289MrJm4ivzSCxIMYM0IrrLAirCCqCo6mTZnHa?=
 =?us-ascii?Q?G/iF0pFPXS9Gwk/eJg8tC0jUJaKEjBp7MGCVghRagbqyvz1Aam6z82YT+6Ik?=
 =?us-ascii?Q?+JiY4fk90jdIWBy2FKXec/gWFAcxV70hiH+ZXGuneYmh/PhzofHgQRTRbwMp?=
 =?us-ascii?Q?NRs57jcVBvsPyOQcWWrsIZ+jy8Ndjfv/m10iGpfGCpJnDJ3LbAqdF8YDI2Fk?=
 =?us-ascii?Q?3ifDVLVYhmGFl0a69RApurwMsqsI+eE62b8Zwh+AA6e0t3sUb1wlzpJu2Ed9?=
 =?us-ascii?Q?9YhzlEHYD+y+7neJcCR/v9OGv6HQ2lV+IwCdHc7SSxsig1ur3rKP+UYtCaxk?=
 =?us-ascii?Q?I4Ov+lcpPFHthgKqBcm/nhirxkcPrxDHyaH/ExS4rDQH8G2rECft3qH6ejPI?=
 =?us-ascii?Q?DIvOjLGPfxnWJDK8q39tzxIT2N276kAjQw+blQ4BfoWBwoZDuv9KlteKYMux?=
 =?us-ascii?Q?KN+4Ec97M2j7fZnVchVvRQrH2vh6efGQyCfG2dy5Gv6A5SAziBbg2mkcYb3J?=
 =?us-ascii?Q?fOxmU8YAQDXDMR8C6WenXoaVZK5nqNGO2DeWNS4HcNOfXpRn4T9nwEq5fkRQ?=
 =?us-ascii?Q?KUgSvgzrhUlq+wIH3REdsR0rwQevWvuu+WlsdAOidtyHUveRQxcTl2wiIfD/?=
 =?us-ascii?Q?0aOqm5gIJWOLEtOZZ6HP?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f67f2b-edb1-4ace-3abc-08dcc818021a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 10:47:42.3893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9125

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

iter_next_ptr_mem_not_trusted is used to test that base type
PTR_TO_MEM should not be combined with type flag PTR_TRUSTED.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  20 +++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |   5 +
 .../testing/selftests/bpf/prog_tests/iters.c  |   5 +-
 .../selftests/bpf/progs/iters_testmod.c       | 125 ++++++++++++++++++
 4 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_testmod.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 8a71a91b752d..9cbcf1b06d6f 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -197,6 +197,22 @@ __bpf_kfunc void bpf_kfunc_nested_release_test(struct sk_buff *ptr)
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
+__bpf_kfunc void bpf_kfunc_trusted_num_test(int *ptr)
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
@@ -558,6 +574,10 @@ BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
 BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_nonzero_offset_test, KF_ACQUIRE)
 BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_zero_offset_test, KF_ACQUIRE)
 BTF_ID_FLAGS(func, bpf_kfunc_nested_release_test, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_kfunc_trusted_vma_test, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kfunc_trusted_task_test, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kfunc_trusted_num_test, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kfunc_rcu_task_test, KF_RCU)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_create, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index c6c314965bb1..8f58a6f94bef 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -148,4 +148,9 @@ struct sk_buff *bpf_kfunc_nested_acquire_nonzero_offset_test(struct sk_buff_head
 struct sk_buff *bpf_kfunc_nested_acquire_zero_offset_test(struct sock_common *ptr) __ksym;
 void bpf_kfunc_nested_release_test(struct sk_buff *ptr) __ksym;
 
+void bpf_kfunc_trusted_vma_test(struct vm_area_struct *ptr) __ksym;
+void bpf_kfunc_trusted_task_test(struct task_struct *ptr) __ksym;
+void bpf_kfunc_trusted_num_test(int *ptr) __ksym;
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
index 000000000000..df1d3db60b1b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_testmod.c
@@ -0,0 +1,125 @@
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
+
+SEC("raw_tp/sys_enter")
+__failure __msg("R1 cannot write into rdonly_mem")
+/* Message should not be 'R1 cannot write into rdonly_trusted_mem' */
+int iter_next_ptr_mem_not_trusted(const void *ctx)
+{
+	struct bpf_iter_num num_it;
+	int *num_ptr;
+
+	bpf_iter_num_new(&num_it, 0, 10);
+
+	num_ptr = bpf_iter_num_next(&num_it);
+	if (num_ptr == NULL)
+		goto out;
+
+	bpf_kfunc_trusted_num_test(num_ptr);
+out:
+	bpf_iter_num_destroy(&num_it);
+	return 0;
+}
-- 
2.39.2


