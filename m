Return-Path: <bpf+bounces-38465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E54B096508F
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 22:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702E51F228F7
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 20:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C461BA890;
	Thu, 29 Aug 2024 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jY5IBC2H"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2010.outbound.protection.outlook.com [40.92.50.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC7228685;
	Thu, 29 Aug 2024 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.50.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962431; cv=fail; b=N1Mub3Yx0vZm3VSegxoTCa6Iw3Vf/S7Fonos8jrhDSHfJa6X+fXkTMkRQOFQWsdz4AqdGYIJZ/1BnScAO9BMvGw8cxGPEs243kzOXkHRn6bw5V3QJuCyZqZDXc+WBguOxjzLXfpISdEKKcjctt4RnxqD2JhzJQxtZTTL/tZHo4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962431; c=relaxed/simple;
	bh=A5V5/XbGEc5SroLnclBlFbsD0EJltvVJew9pg2zeQgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MbzORnDa8afOkcDnu400mKi8NqjMXNR3I9ZD32h8e5Ny5JYihgplvc5ENpILedUeZTZPaa70lDarYfR9oKIDXQ18dcQmt+0solNhhZ0wpG6bn+Rx1j/iSAsQc6pzFJrHZh/xfS/HcTECpQsqsCCoSHqU/UmfsvPgzi8TFktYXmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jY5IBC2H; arc=fail smtp.client-ip=40.92.50.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQG3HHF7e4kU6Arey3Q3z/8/Xp8YdOv+81s97zX/WianZGGdz0c4QLJ/DL3jYpA0dgyj6z01Cx6jopaGbUJtVNu4YNMpIWPjiqTBDaNMEfvsyTPK5MIVHq5h9XbzTWA1M6NHSj/Qetq3+M92xMapipgBKD+z/C/5XD95lW+QC/hhXLVA6hmRAKgya8B9jKt8j/q+ed82DB64sIFgBhELWNmlqng+m3ISBUfv5iYMlqdIiukrUU30AXMGzk1Ix5hSYjXm+1sPUbi76DsBaB53Hx5tTNyKBg8mcWxF6Ayz+6PBsCy4EgJ0lmMptmWNHVn4QzJ4low6esRN2aRTm532NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50/Qrmy96M9zZnlXy21WkpIVBslH/oeNbAqqpwnyWxE=;
 b=YVg10+vr61QwapMbDelYIh0Bqkfyjcc1C2vWLqLMMtm+293rgtHh++wBMwoszOhGImVOrNafAZQOWB05rBbFztJ9fhGdaL/5r2Hox9Ny+iEWOu2vIDYLONrU0vbPOoXyNxBAbQaWPNmh69WBc76I2vwpZyoVGn6v8T3g6UDdo2pXGvvhTtWff8mcJ5Lj3PTrNWVWpwsTdEhHbTUvhg5vSlE9aYAR3NRSCs5FSlzangeShd2uUiqUlTN29++QTAb+oIX7Ijag7DWVu1aO6WDw3sdBa/3gK+/MfA7m50dA3308tzeu+tFcieic/sy+Lp2xjy7MznMkLGj43wo//yinfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50/Qrmy96M9zZnlXy21WkpIVBslH/oeNbAqqpwnyWxE=;
 b=jY5IBC2HfHXJeHEU0d2KVB5oq/bw+eUvMbye0gRI2KfEp4rhIj+kB9nOUfFyY7ZfSDXB2ZF3UYQIjYTIfCanU9TyH4ENW2yC2czhHmKqdJW91hDu3p3ld6CCl5oTuNdXu0Upe/wDQHJeNOBjQHMb42YyzJTwYOvyaH3rPAALkVzDzBg/bL0VBrIhxppRu6cIZltjXwIDNkDownnWa28mElDOay/EhpltOAHrB3sg2FDoUgY3cmDSUijz/twtvNhq6vXUb7RK5+Ibf31tH+3/jHaC6hT3SKr+Q7/CnNPNRQPeP6sSzQu3yPOdGK+Dy7SRfNcP7aecJI3RbfIhsVIw8A==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by GV1PR03MB10409.eurprd03.prod.outlook.com (2603:10a6:150:163::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 20:13:46 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 20:13:46 +0000
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
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Add tests for iter next method returning valid pointer
Date: Thu, 29 Aug 2024 21:13:15 +0100
Message-ID:
 <AM6PR03MB5848709758F6922F02AF9F1F99962@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB584869F8B448EA1C87B7CDA399962@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB584869F8B448EA1C87B7CDA399962@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [9jQ2VCKOvvS+5OdNzroDzLQLP0HDjQBT]
X-ClientProxiedBy: LO2P265CA0216.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::36) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240829201315.25362-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|GV1PR03MB10409:EE_
X-MS-Office365-Filtering-Correlation-Id: 0184ef61-8450-4f57-686c-08dcc8671663
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799006|461199028|19110799003|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	cTR7HT0USc1sQYQOo7YEVUEKEn1nTY1KebaL2wTtYvwFnut5Q1L4S3mQ0vXAxqWli6NC3F6S/nojuQGnTbU4H8eqCH7b/skj96DRW3zKnpNN8yTT0fAMUv6xkv2+JaLRTDqTU+uEdNisjGHNF4ZcJew2gY9ylGyqIGtEvD7doilDJvUNVvHluXrgAmuGka6m031jABkQ7skAsts3g0UOZBnUQSzpUmps6ItrodOPkwSWpujUU6tYZb/ISfBzQ7jpHCzhMMm7jHQGaEqU99jiFeKj4SmtvWEUrtvrld29SCRulYFQhtTxhMsUg7RwyMF8URjtoUPrUEjrLXWZidv3RwfK4/VDqSKW+SwxxOFVxHkxVOzAUVWO4ouZ3HLoUxekw5FNCHlJ7qDZrzDZxsnflDmJX6g4yCfdKSXXAJ+V2I3fKHNni+KevOfexTtrW0lFQOgtQK9GNmAHKufQkYyBKBZRQLmtUjOBadIzA9MEKFGZR8uSziOdXs1tnsd//svfgZY4r3AqyvmQO0U7WJWQR3ceeU72TVd1ZUcNLH+Y5K3+KLntTeUlH8RQzdV5ztUOldK+pEA6p8EzcSR+4pptV8uQqmW47b3zasM/CvAkxUrOuBc2dDEzXklsUemrWPay/qpllEwEVaAiK0PiQ5umgQOwdOaOYcU1jHkJBa8kFy1WMDNmwZqmzdqc3C6eRuHdVH59VaBaw9PEY0tySI1GvQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wDoGT4PHmHfwHGawXi6EAiUH0TtX4dWZa3wMmf85e5PpTIPcvdEPh9XEgDvG?=
 =?us-ascii?Q?dDp85DsfrV0N8G6QicTVuY5fshvTCG9zHlcSgQfqm/0r6in3nh1h3pyI56RO?=
 =?us-ascii?Q?RQCgg0h3ZJCQd0yA8lQYIwIw6nOWQT5e5vqDqAXr08ZGBfrEkzznepAFXaas?=
 =?us-ascii?Q?CTCa/SY62P7gP1qL8+kaqzaEhvfYNPvfk+tQxCCvOKH1tcS4rwJrxcWJ2fn8?=
 =?us-ascii?Q?MXcQfdxa1zfiJgLZQXd2PmjUW0dCiB/2T1pQp6wHmSUz29rB9WhAGHzigbjz?=
 =?us-ascii?Q?S6/UQFe3ZDcivVxWqzkFh5gDUqsXIFdD8G34MpZYgYIdcZNAemSp9+szPjV7?=
 =?us-ascii?Q?co1hBpwf99yJOG7kiabVsaD/rlacPIegnkvN4o4R2XwmS1x+wIHlE6xcEGi9?=
 =?us-ascii?Q?SaWzBk5b52Ed5NGRSYMIvCh96+6fUrUkfM9XK0g/fdMRWo2l5mvPaw+owYvD?=
 =?us-ascii?Q?a98ceTZs8xfSprlEDyxU6XWYpVxs+npj7FJnytSOxCIv9P3ppLS2BwUafkL1?=
 =?us-ascii?Q?oj9I9o6aW3tmzcckS43CUn+aA+/mUDysYgDMr7LWn56ryLKI88Apk5lfuouY?=
 =?us-ascii?Q?WKv1GOVq+3Xrk2sHDJWhR6eD4W7KyT86xe61p70ZdFomXjJQdGFLqQi3BWD4?=
 =?us-ascii?Q?Qe0p6zOTuyU+lLvllYN5M5031BN3qdCKAHCkE7DNWmVTEl+QIJxYFvpTS3uZ?=
 =?us-ascii?Q?MQ+RoqBgnEPqn/0t+4HYn2OkBYwz+1q7L9qttHbV0TzNoOQV2HaQ6b3xor1l?=
 =?us-ascii?Q?9gLiIGVyoN0tOIvqKi59mqzeF6rGAjBKmPod98RsB3vxKBUf38JirnHr3v5Q?=
 =?us-ascii?Q?fv4cAeaDCxIzegNDyVhJFBeZafyL9zZYlvaFuntoigMDtRPBjp/wLtX74SGj?=
 =?us-ascii?Q?GFihrH7mLbQXGCicSmN3HzZvA/EfZmFU2RwiMUYvF7u2f3ux/dR83RqsrwB5?=
 =?us-ascii?Q?eR9DCIkzP7jSbu3784fk3U3MJI+dDFvi0thZ8KRN8UudrxbLdh5xGX/+LOwJ?=
 =?us-ascii?Q?xp71fF2/h4Vf0Xa1+PI+GYlHE5NrRTwIDzKNQPn11oFLRzOMzNiAHqik/+CP?=
 =?us-ascii?Q?VyWh6gvB7tYoM2PUAQWpVogjMA1YoQI/tniukDEtcqrJr46aFVEQcQi0wjII?=
 =?us-ascii?Q?4Hn0JDR2blQadGmIKE0huhJYptDViBOX3smVWtSUxu4PquiSHnFl7hs62WC8?=
 =?us-ascii?Q?Ns26YbECfamFzTNpu+9NfDfRQSKib7zBNSVZ1yyWXK/h1YbdBCubDAJcybYB?=
 =?us-ascii?Q?64yiT1WkrDU4mhl7ON4J?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0184ef61-8450-4f57-686c-08dcc8671663
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 20:13:46.4163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10409

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


