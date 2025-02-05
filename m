Return-Path: <bpf+bounces-50562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BD5A29A3F
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 20:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F06B3A10D0
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 19:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457592046AA;
	Wed,  5 Feb 2025 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ULMf2BGc"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2061.outbound.protection.outlook.com [40.92.48.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD461FE476;
	Wed,  5 Feb 2025 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.48.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738784233; cv=fail; b=kI6Y1qXDlX5dDkboTFeDp4KPxfQLXFMaObMuGlMDfClRJ9wkf/xHpouzXjifnw6/ChRGMN0riDo9lpDiUaZEWmWkPx8tkRiXSsmtFW1GnsV6bD0kDLDm2sVaNsiVn8q4nCILw4TToW3E4J1FKgQu1EhL4zHRH5yzsVdy/TX6w8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738784233; c=relaxed/simple;
	bh=ypXZfEqdh4D8qNVzzgsXTGxGo9Tzi11wS6e4bO+4Kk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZD4hVT8AcmnRNRT3VdHCTBsfite2LzUYc3R9G2Z+JeH2dmogw7iqJNnVtciFCRiiL82Q9ylXqI0H3Lj3Vis0GhM0gqrjCN+yfBo/TTCCuAom8rOt5wUhUcJqdy59751DjXaK5kvjk1KMdG08AcccltKwuLm3rrUBPHYsM/HpfBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ULMf2BGc; arc=fail smtp.client-ip=40.92.48.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRycGq+htUygGqaIwNcGd9CpsPjWaoRIbeENbapteYPZG2Tc02bmwJcOCaOb8bKT3gi2b1HYI2lZm1RIr6VdTxppP8e6CIt+2eETvilJb/QbNTpS/iyiE/z5p3HieOHXyfXviioneyqCzsNrXacdhzPX3YxWnE6Ldi7JaE6yhWqCYa2eX5YGQOghiVyXcO4tKCFFKyEPwaU/VPal1OLlPEEo7yUSvJg6X4apxB9E9HImsUpeC7qp8PossFPPXjZvHe0os6+SwF+0gvNJ7VhyrlSbIxA83pr/yMJhK3AklhGCUVIExHRxdEd1C1fxJ5vy9sR6uqp7OvZdSqLAeeAb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRnGQA+nOZThu23j/JO28tYgMaZH4gtrbP64dQJvHRI=;
 b=b+2PUAm20yHGxJfTnwWSlvLAEsYkJTkCZUlAgCNT15+HDHCeWRaMcoHsSlKhQuQlBMv5lAkuuL/sSVT+ItvWAQvHua4Fn0P0NoWfI4REi+GbnkvImw9wrpjQIvf+8EeMkU6f3dGQqdsWo08uZwGtGYsuEJ+PxEinJRvK/CheYn6rmZdI6EswRS+TT+f+8DGqsy7UQ8lVRneSR8hlRTkSaldnnshP+CdFp98nZywgX58K5Qk+B3dVX+YIlUDZo+pujoHy8b6Thg0BE021QeBF1uKtdiLkesE8ABAdW/i3BaxY6bkekn6ciALTv0QM0rD77L1qCbvE0eKWtvnD05f+ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRnGQA+nOZThu23j/JO28tYgMaZH4gtrbP64dQJvHRI=;
 b=ULMf2BGc6RxFRuq0JiIKxKJVx9IfGCJkZ4Ui3EZ0vNEoang4xcgsWdnOV611fYYDdGrQJxTbfO+d9SHF4nsHhUWOU1MY6Tx7oltWuC15x6NACo/6oIzldJJuVSjqdb8tH06LjnguLHNGbvG9GdL8w7DFqHGGMG98AJ9FqBJWvYSJpCOXF0chDLvI/WU5DNDTvdh1XbFbDM32pbVdGJTa5m74nVvKEgu4ZrX3kHGKOtaRTL82kWtK0fJdZg+8+1hdVG9CGqmzkkkvbi7Bl5q64g9b/gwH9U8GomT0L/yHPZNCSuS5CcLUaDkKQYGA35LXr6UTHyCWiwWtqY4YhJEr1Q==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DU0PR03MB9077.eurprd03.prod.outlook.com (2603:10a6:10:464::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 19:37:09 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 19:37:09 +0000
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
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 8/8] selftests/sched_ext: Update enq_select_cpu_fails to adapt to struct_ops context filter
Date: Wed,  5 Feb 2025 19:30:20 +0000
Message-ID:
 <AM6PR03MB508098F557943507B040272399F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0570.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::14) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250205193020.184792-8-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DU0PR03MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 655a7da3-6a71-4853-e08b-08dd461c7a9c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|8060799006|19110799003|5072599009|440099028|3412199025|41001999003|12071999003|21061999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pSri9Q2pMbL0iP+2du9hFE6Z6Fx/FxIw6mdGIT1WFMRzYX9dWUcQ8MBuozmb?=
 =?us-ascii?Q?tQ0n26crTGI2N3D/t0ChZyj9VEGZslFz99zMilsCxQQu7jz21e7lZPb27sEr?=
 =?us-ascii?Q?38NHffbP54V0sz5fc4w4PhHdEQVuqvZei9l54DkcwPv/oX3jGJisRYUGgMud?=
 =?us-ascii?Q?E+d1UIHz8BNrsL2l1qkk+/FB4BATQCe4o2EdI2AKT0ycxhzNzKGVPoY6rdqN?=
 =?us-ascii?Q?CVDUZjN5INKjJldUviiGKF4sa8CHZy0IhtvA6lhrH1c7XssgVksjF89g7ntR?=
 =?us-ascii?Q?PWrN3aJDM0g7fgqb5OqFUudis8LZry3kS+r463COfgJsjm/g6a7BU+DEfJNm?=
 =?us-ascii?Q?XiiTX2vwIB+vTLQAzuTGwg3wrPRxvn0si5jylOdhR2BhGB0t3wuMrxGPeve5?=
 =?us-ascii?Q?6EFB+7gqJaQ/w7gO+9PbTnX4nPo71NVewtCX2aPfYFewERp6rqYB2C8wOP93?=
 =?us-ascii?Q?5rhBTsKTpjrfeW9UPNgZrgtBylPrAsvPTnOjOR57mgm6RV7mL9Wke+srSPWh?=
 =?us-ascii?Q?Hybc0PSo9bmia7jNn86GHu/QhI8YrCI+XlHviZZBifpWac2940bobZg38z0k?=
 =?us-ascii?Q?Mz5iBe52Ysrh6ahwwtmhFCVMk4ZiJ6OFHGKhpMjzkSbxxG2BteYUDUYoQJ00?=
 =?us-ascii?Q?8rqyruPgLa8qMtVb1Tw6XKEeLNw8OEBkcl5cp9/7dtgrMnFD/MtWfWLE0l8F?=
 =?us-ascii?Q?MyxqR9g2tGGqlpREiM13izrIvivfRNuOJWcHyBw/3csZQqIpVmPMFbcS8ztf?=
 =?us-ascii?Q?72NFi19qdDrOgJY5d9WZve3CKr6PgkL+mLyGYWBuNMTpyNmefDl4po85d8CR?=
 =?us-ascii?Q?7XFxQCFgwBp1K7dZMnwBVJxHtcicV1GkhUYK/T6rTTOQCwpMk8pkg2lJ3phy?=
 =?us-ascii?Q?S/FIhyY5z4UbaEfM0v5vEQa+KMN/NZidajJ7jV/3IuLPx0wW1Qg2DyB0E4mV?=
 =?us-ascii?Q?Z0u248Pw6Ejj5/so6Uvokx6j+DB+fL0alSCA6Qg7HlFqmc/tUX/CAl30+DrF?=
 =?us-ascii?Q?rMiKy/sFiY+ETBYzsvFHV9A0NkrEhW21KeVxaPvdmiQdaW2Y4eYb4XZkHL1s?=
 =?us-ascii?Q?0cr+MwAclCPC174GkuoyWNYms2KDoGeu+1KDwUbLirOlAEN1UW2o26/9UO0S?=
 =?us-ascii?Q?T7QpJmyDErCroXaddC+rYyg0vfqq7sEviw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D6x1lJCbbt2wNOx1wvo4d1CLkrMvV1CbBBeBSZ7YntHpvYBahSfXa0LlgZr+?=
 =?us-ascii?Q?SV6sJYMbcIqDxY5WP3vTt9k+Uu7bHVHVWE9jDB2137qhQiwZ7oQ543b6VsUa?=
 =?us-ascii?Q?RjX8ZQwPptxHyXIDFi7LMwFpeqqcFxAiH/SvviGHuTqGKCSxkHygy7wGEJXE?=
 =?us-ascii?Q?Lgpr9Bhv/hAfwlScJ0cjWywfWiG0Q/NBxFv3uPkz3jBFdViJNXw5iKbz3JYW?=
 =?us-ascii?Q?ZAFgokE0XI29zE8KWBP1NC+WV8Tu5fa13QtGwuUs4lF1zvBA0Nw/HstM9xrE?=
 =?us-ascii?Q?LbrFLrGEG14vH6r6bBthHKQNY05hU8t+UncGrb6K91A7aSFf9u7ZvaEalOK3?=
 =?us-ascii?Q?FdSTdV62MZo4gcTTDNctzGKV62y337Up3UoFoAye0lXGrFpXliYJHux/SAjN?=
 =?us-ascii?Q?lJpzMh1kWDHY9aGy3rOVJtxSt4NWzZhz4FXOc7meqkrZ2tc3NIrjRCu2lqo9?=
 =?us-ascii?Q?epq1uykXmDvBkuADHQxHaG2M/z7FSFzceGwy2EJ6zp795MGUqKqA66iy9446?=
 =?us-ascii?Q?DDpfMNwTn/PvNXeJeox/AI5AU7kWFdUUFFrUJvT++XwrjlsXBS0gP8MjImC7?=
 =?us-ascii?Q?iwq++VIvX/aCZ7nOrBn9h2XgGDKWZWQ17IYvCEm/tip+LKvoU0Vv01oHEHjk?=
 =?us-ascii?Q?fm0hfN9wSoXDGml0V2Re3kBqvsA1/h4Esc/sIvCQcgkyiQLMUnr1RbUmc7B/?=
 =?us-ascii?Q?ef72V5+aScriho6FYG4C9wSbmXcU5j1E9DexWmN0X0qaog397NP0OyLn8C5B?=
 =?us-ascii?Q?tR2MpK6zApaxYnBXFuClcXFrqROtwafjMaLkHx1PGRQpTBMPkuO+tUT+AUeF?=
 =?us-ascii?Q?SFlHqa07SHioDMXyn/O2TI1lvWpI8mqAvyxn/rD4K2Y/row7abHvng8xINE+?=
 =?us-ascii?Q?qMjFM1VcmSj2UUlfUcpYGrgmPB0pqhR6HuXgywAzE9ywu/AvC4PR5/0M9IbK?=
 =?us-ascii?Q?JrHV2kpDewf4KGKJVLdUES7HQ8NAglZucwSVc4ZehtCV6zEoqcnJ6LeMQ9L9?=
 =?us-ascii?Q?MuezN+wBiDp7Rsr5mojC7+arL7Ih6ujdQNIuO2JZeEB99tF0MUbb/YNsJgv+?=
 =?us-ascii?Q?aurE5KyLmyCWaXLC6ZvRVn8xwIMrL4msFW4WW+Mq4ok/Y4abAcnh3Oa5OnZJ?=
 =?us-ascii?Q?2zbavTza6cVCTLx84dKAf9ugSvNVAv4wyZ8lz6HxAe/SYv8R1578fR7zxqXS?=
 =?us-ascii?Q?Ly3UrbiRCtoOoSK0chZpGPn2UTyDbtBwsMLaegQ9NvyWZ42ZpM1uJzSY2CHe?=
 =?us-ascii?Q?44dm7ygMdShGpwDgcHOw?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655a7da3-6a71-4853-e08b-08dd461c7a9c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 19:37:08.9487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9077

After kfunc filters support struct_ops context information, SCX programs
that call incorrect context-sensitive kfuncs will fail to load.

This patch updates the enq_select_cpu_fails test case to adapt to the
failed load situation.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 .../sched_ext/enq_select_cpu_fails.c          | 35 +++----------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c
index dd1350e5f002..a04ad9a48a8f 100644
--- a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c
+++ b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c
@@ -11,51 +11,24 @@
 #include "enq_select_cpu_fails.bpf.skel.h"
 #include "scx_test.h"
 
-static enum scx_test_status setup(void **ctx)
+static enum scx_test_status run(void *ctx)
 {
 	struct enq_select_cpu_fails *skel;
 
 	skel = enq_select_cpu_fails__open_and_load();
-	if (!skel) {
-		SCX_ERR("Failed to open and load skel");
-		return SCX_TEST_FAIL;
-	}
-	*ctx = skel;
-
-	return SCX_TEST_PASS;
-}
-
-static enum scx_test_status run(void *ctx)
-{
-	struct enq_select_cpu_fails *skel = ctx;
-	struct bpf_link *link;
-
-	link = bpf_map__attach_struct_ops(skel->maps.enq_select_cpu_fails_ops);
-	if (!link) {
-		SCX_ERR("Failed to attach scheduler");
+	if (skel) {
+		enq_select_cpu_fails__destroy(skel);
+		SCX_ERR("This program should fail to load");
 		return SCX_TEST_FAIL;
 	}
 
-	sleep(1);
-
-	bpf_link__destroy(link);
-
 	return SCX_TEST_PASS;
 }
 
-static void cleanup(void *ctx)
-{
-	struct enq_select_cpu_fails *skel = ctx;
-
-	enq_select_cpu_fails__destroy(skel);
-}
-
 struct scx_test enq_select_cpu_fails = {
 	.name = "enq_select_cpu_fails",
 	.description = "Verify we fail to call scx_bpf_select_cpu_dfl() "
 		       "from ops.enqueue()",
-	.setup = setup,
 	.run = run,
-	.cleanup = cleanup,
 };
 REGISTER_SCX_TEST(&enq_select_cpu_fails)
-- 
2.39.5


