Return-Path: <bpf+bounces-37369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083DA954B17
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 15:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663A31F23451
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 13:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C941BB68D;
	Fri, 16 Aug 2024 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MpKrGBgT"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2078.outbound.protection.outlook.com [40.92.89.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4803D38F91;
	Fri, 16 Aug 2024 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815022; cv=fail; b=LEXumiWo8AqOgBqsAotRGzsZIkiZW82Bzd3enDYdlpcSYLqgFITU3hf22lfocy4TUar/sibJ/T66bOoUEvdKQh3lRTgl89THVySP4tI5vA2ceiYkVHsTEPJbAJlLJvmlX3v+k06U+D5po7WJs+Tjfu8vFx//bNNXhNET8bnt1zQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815022; c=relaxed/simple;
	bh=W9UUy4sq698REGpFb/ZT/J9nFi34ad5lo3r9ZIEgKr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mhEyjvYOZizuPh7frJV2aHOEJj11vh21j7kYIFpIqpS1aBfLUdAxOSMeu5OU/6YBeM9/3gH43OTIJ0spet0PVq86Y0UHe6S0UXuccl/jtlyJam++9BrFFEXIf+8zT4TkoxaJ7F9JGm2oVwRXLDqMQq1l7OOOgxM2D1oPOXYPvAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MpKrGBgT; arc=fail smtp.client-ip=40.92.89.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnnAoP5Q0lsAPKunOF17eHpBX6hzLjqEWtiM7mBn3buaaLPU0GCUALiJ5v0eGNyq6oPfRlADTXxDG2+6hU9mrLc8/f00LkzZWkqHvqyKFftUdthAreI9F0ldA0+Tefkvu5BckaI/jcFVirFO5Xltwm+l5vJgieUksmqHG4XjN6bM8LGpbC5z4CN77yxywbpDgKHU9Edc+omQizugkNrzp1xfBsI25ORQuyS2qlUnP/Cz/TZFgMk37Do9AX5Sm46ksNcUl6c0NEScYRqg8Nxcm4VWQRhtY2FVpKIZ+L2Q+AkW5j9JFQYomelXI15GQyEeUv6QUSS1iWCKdpQx7MdrBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blutEk5NaIEsjjxv4y8HcBLZ0ek1xwg8JjcdxgqAY/A=;
 b=GpnGistHZN83/3/8RA6gDkYTrAWtWy/QFX3dKtU4DDEtirCWmIb0NvsWNlRX/aq2xT+9tlOvGrraYutrRZyWZfipg8+1HajKOSqffvM96Wn7xkf/Oo9CCg2UD9ShP5PtKmJUjg28bQaKcrB4Ea2hdEOZPC50Cd1ns/iTIlDOX+8GuWmeTh+TFGR7KehQYn+lgSw9BOdMXR6l1na34AHphKBZYOzuC9g7USZYUmJSoerexdtxBDfYhzvrlD0jYss37p3ZfiQFi5FqR8YlUcLqssf6dofnEbF3ecgxT9Vf2m7DKSMSBxf8c89cbY2JXQCFsA6XRoFqc4iNJ84SVjyTYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blutEk5NaIEsjjxv4y8HcBLZ0ek1xwg8JjcdxgqAY/A=;
 b=MpKrGBgTKeSs7yY4lPquqpgj8w2V2cKgG/PlVhtup/Eluu9t7oquMRboAPRW+vl6aDgHAcjp8Goxg8Uop2IUYp9C/d/GeLUv6+c+R0rrp+HFwRmLyeNPd+uRJXS+sIKueUuIfC3xm9fvV4vrSzi7VHIeDaKl4mt4EtZQg4t5eJm44EGf7nBKDfLurYcTtfzaAo8D3NRDrubIDb3GezMgnvBs5inUc8nfu3ZcMJfZinEV1SoJPTZIbJ6nZBgD3KNxcv6E+ASq7KloKmSnb8U6Eob6LnTaqW/2ErCrBGmmfOGNPTnw/aNe8bxmEF55V2TMwY5xvk05TAEVrAiEzkGvmg==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by DB9PR03MB7788.eurprd03.prod.outlook.com (2603:10a6:10:2cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 13:30:17 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 13:30:17 +0000
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test for non-zero offset pointer as KF_ACQUIRE kfuncs argument
Date: Fri, 16 Aug 2024 14:27:37 +0100
Message-ID:
 <AM6PR03MB584824410EBBD3D80F009F5F99812@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB584837A72DB98E45AE595A9799812@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB584837A72DB98E45AE595A9799812@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [EGe+5b4KG4e6ctrVoTJDZAoCPO5aWYhc]
X-ClientProxiedBy: SG2PR03CA0126.apcprd03.prod.outlook.com
 (2603:1096:4:91::30) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240816132737.88005-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|DB9PR03MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: bc4c0a58-b39a-46bf-81a6-08dcbdf790ea
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|15080799003|5072599009|461199028|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	9aawJcROkUuxvAcbPBW1/XzMtVXA3Uh+cs7yp2tPw66BaV9qIKBDyo4teeFb6YIFJLt2A0DQoH9LY8nrGS2fd3ZJMPFh/upzXSIfoGl/dOd9HP2plcrRNAPM7uYFwAfvg34YvPN8AeU7spvC9n1mlYuT+hkxfZItBgdSNV9QBL5s8yxrJ0edE+t4b5CHLojq8/FbyAljYWpFGgq1V7XswiSyaa/CTrm/2kUbsYaj1t2VhfEb4uBJlG7ZyME31/UJewwe4KRdIGCZMz0EaX2HUNLcArDlBPelGDf6hcee+QhvI1jfUONJCTVq8i3DhY7Cz4LGWYLq45+2mtF6JWL9ApSy+8ux6T7CLLiWC8uxUzAHD751MZ/fpwMeNMKJZ4He/6ynZzSXmPall7jwdFx+mkwx5m0prgja/fX7PIlJAmxsp4Vl8loCh435LDJlagmMAi2pcA1dHX6JXd/tMKzbxvnuPOqoKjMGda8dXRQmqsBB/3U0o9IGaAViFPgHYOlYM1qRhNMyn7QcGqyj+yLNKg5qzdpsPbge4lDl/8VsDgaRfn75JHiQEBfgxC6q/pISqTa0QHJUPSzG6Av+zHqVrLW1+ioAbQ5pjfuXi3R3zCwaPfsJl+5EHEeiSgdrfkTlBvE0gef+NUx/tJiJC2FUx8L/lyTgtFzNf2l6Q/pwA77pw9Af02UNBarGHNlBRNlPsSvvlpy62ww904JA6ac12A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MZAjHNs0EMIJNnRHa4UK+eZPDwKtZ1BTuRQ7bFb1+Ry3yWqrSA07nVUoAXHe?=
 =?us-ascii?Q?22CgT0EimMk2es+vj3SK3+5YTh+MX1G1FXIWXvMh9hndEN9Gm3/G1J/qF4mD?=
 =?us-ascii?Q?hNhWbJ06QZNMG7PRcsw1n5G+KmAywAWmK8WmPy3My1m/JMR90jMiKc51yERK?=
 =?us-ascii?Q?7wxmoYYTA0NixDcd58EBA6LfVsYutMjZL6tDDrBQBI0ns16PT/jnX9bTvxK6?=
 =?us-ascii?Q?GvGp5P9jFaItaM2f1eszvYVjv8T2jpCJIOcbJHYuq1Y7XfszU5VlhCEBDWV7?=
 =?us-ascii?Q?7SegxrMfMWPfdFZ2jH66A7ToYzs9OAqAjS3FEe78uHR7/70+QskNax5Ht4FE?=
 =?us-ascii?Q?PrYYMoF4mvaOLBQK1kBFFfF8RmRYBecje/5pacGPWhpBHyXoVCgSBKkzHLK6?=
 =?us-ascii?Q?WbL2PRWKRN8tMJEsvr3IkCqumOc5l7Qy+QZkaWiDT0OPsWG3jF3Ke5NfCVWS?=
 =?us-ascii?Q?TvlzuYxw05atFSsx0Dlu2oLUH9ckzSia5U+zdkBYxh3Znk5AAISkzahQwfNH?=
 =?us-ascii?Q?u2nWzOnEX2nmHM2LZko0ySYLaMPYE9isKBGYYVhZ6kCZnhAQve1xcLpwYGBe?=
 =?us-ascii?Q?qa9LKVOvWLo6EApKLrcGoLngJVCOuKFFs+MIanJzYdIi2D6TUTw6nxUHPwE+?=
 =?us-ascii?Q?eHJaW2uUZYnE9ySkRjyWYfRkitOb0Mf54hQu/9RXy9xZ95qN0GX8NuQswJf9?=
 =?us-ascii?Q?4YMEZJd7FK2StzRr/I9tACvUUP3Ohs9UbfDj3ZRM7THFL6szBD6ViYUaGZWi?=
 =?us-ascii?Q?HA+iz7GiW61Rn79gtTtjFf8HX4Rm+hBnRjcf8oNR1blQNsM69WOuZms7v6yN?=
 =?us-ascii?Q?C1ZTiQNXhlBs7PZdw/1BjPFDvJHgHT0/xifMAlVQapo1mqlKsd0wZYJhqCcS?=
 =?us-ascii?Q?gAC6eGvjSBKlpf9Xt6r2SC+hVV1VVBINBcoVMGTmAYJY1ZBHdwUx+FiU4jBC?=
 =?us-ascii?Q?JTx1CBFeZqJPLj83Rm5LuMH18MbXYUjFyoplaKDV7XVrHIkHpzgPC4yKHWBY?=
 =?us-ascii?Q?ABNT94fEx4RlQrxOR4Y2vwWx84UEFXOKv0i/B4SgQpoke+P6zMSNCRGfvN0k?=
 =?us-ascii?Q?ly9i3b6y4PQiltaTm5yfcY80JZHXsDrfq9BH+BDQmdgHoM3jh3c/J+djSfPU?=
 =?us-ascii?Q?1LOuPPVxG1p4PAmaEcYK7mknw2g0qy4aA8ahR+s9gizKfXFMnDnptpw73c/S?=
 =?us-ascii?Q?Ol8P7mEXIM2bFSd3F7LVZFkpg0KWqwRBSIl1M6w9SjBfu9BZvFg7aHdnAsUE?=
 =?us-ascii?Q?PpVSsa42C3w8bR3FMlFv?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4c0a58-b39a-46bf-81a6-08dcbdf790ea
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 13:30:16.9456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7788

This patch adds a test case for non-zero offset pointer as KF_ACQUIRE
kfuncs argument. Currently KF_ACQUIRE kfuncs should support passing in
pointers like &sk->sk_write_queue and not be rejected by the verifier.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 11 ++++++++++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  3 +++
 .../selftests/bpf/prog_tests/nested_trust.c   |  4 ++++
 .../selftests/bpf/progs/nested_acquire.c      | 21 +++++++++++++++++++
 4 files changed, 39 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/nested_acquire.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index a80b0d2c6f38..d742b91af270 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -176,6 +176,15 @@ __bpf_kfunc void bpf_kfunc_dynptr_test(struct bpf_dynptr *ptr,
 {
 }
 
+__bpf_kfunc struct sk_buff *bpf_kfunc_nested_acquire_test(struct sk_buff_head *ptr)
+{
+	return NULL;
+}
+
+__bpf_kfunc void bpf_kfunc_nested_release_test(struct sk_buff *ptr)
+{
+}
+
 __bpf_kfunc struct bpf_testmod_ctx *
 bpf_testmod_ctx_create(int *err)
 {
@@ -533,6 +542,8 @@ BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_kfunc_common_test)
 BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
+BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_test, KF_ACQUIRE)
+BTF_ID_FLAGS(func, bpf_kfunc_nested_release_test, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_create, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index e587a79f2239..7213d77717c1 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -144,4 +144,7 @@ void bpf_kfunc_dynptr_test(struct bpf_dynptr *ptr, struct bpf_dynptr *ptr__nulla
 struct bpf_testmod_ctx *bpf_testmod_ctx_create(int *err) __ksym;
 void bpf_testmod_ctx_release(struct bpf_testmod_ctx *ctx) __ksym;
 
+struct sk_buff *bpf_kfunc_nested_acquire_test(struct sk_buff_head *ptr) __ksym;
+void bpf_kfunc_nested_release_test(struct sk_buff *ptr) __ksym;
+
 #endif /* _BPF_TESTMOD_KFUNC_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/nested_trust.c b/tools/testing/selftests/bpf/prog_tests/nested_trust.c
index 39886f58924e..54a112ad5f9c 100644
--- a/tools/testing/selftests/bpf/prog_tests/nested_trust.c
+++ b/tools/testing/selftests/bpf/prog_tests/nested_trust.c
@@ -4,9 +4,13 @@
 #include <test_progs.h>
 #include "nested_trust_failure.skel.h"
 #include "nested_trust_success.skel.h"
+#include "nested_acquire.skel.h"
 
 void test_nested_trust(void)
 {
 	RUN_TESTS(nested_trust_success);
 	RUN_TESTS(nested_trust_failure);
+
+	if (env.has_testmod)
+		RUN_TESTS(nested_acquire);
 }
diff --git a/tools/testing/selftests/bpf/progs/nested_acquire.c b/tools/testing/selftests/bpf/progs/nested_acquire.c
new file mode 100644
index 000000000000..5e3a499afd6f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/nested_acquire.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("tp_btf/tcp_probe")
+__success
+int BPF_PROG(test_nested_acquire, struct sock *sk, struct sk_buff *skb)
+{
+	struct sk_buff *ptr;
+
+	ptr = bpf_kfunc_nested_acquire_test(&sk->sk_write_queue);
+
+	bpf_kfunc_nested_release_test(ptr);
+	return 0;
+}
-- 
2.39.2


