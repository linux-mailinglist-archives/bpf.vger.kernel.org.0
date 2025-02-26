Return-Path: <bpf+bounces-52693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34347A46B28
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 20:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B76188AD37
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 19:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45171242931;
	Wed, 26 Feb 2025 19:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="I5dNNmTd"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011077.outbound.protection.outlook.com [52.103.32.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF23238D2F;
	Wed, 26 Feb 2025 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598477; cv=fail; b=T2bJDc8FX7hqAcBP07XYGdFrXOxZyTopRGnIjLDcoo138GG4ums1MzRmhz1ebcxPXdEIOna/KOxSiis5gMS4FbASUfrpESdNLbEVYfSl4VkXSDlSrEKyjsaO7RXGiQPwDXd1snjxtJiFl+2xHDlh29R/apJvw8/qHCBUMdqhvOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598477; c=relaxed/simple;
	bh=ACOFdcjyzEMrrUEVtj8xsPuWQ6feABuf35kwC4CSxHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JIuH69VL9u4dfiSNmQESb6KNpkXpQ3ASgqVD33wLdr+lMM7ocRwIvBE+Mc1EWqOO2Ul04OV7/19pN33WDYhB89RRGfO59rW1+yvTbAD4vVKe/CtzrdehJ/pIxDtJ9bRLTi2slNcfQBodzEg/+sNIw87bEADa3K2WqrDhs0DN4yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=I5dNNmTd; arc=fail smtp.client-ip=52.103.32.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsYMDFX0JD8++LSybR0w/tKbpUdnzt1rbQY+XG1S7PdeY66GEEJa0Ictj8f6I3NVBcn0gk0WHSUW/7lNMqOHn7duXAzcoax2yhK3GOaoomtgyVKQhbMVK+gRzehm7U01vRw6I4U3OugXOqlvFNZV04xfM+bhyUU8r/fbFdpUE9iuU6jqgtNsp8/Ud+2vti4QgRg0dIxPwrym2+TgUHr97hDFN0xV/ii47e7prhKfxdVL2YEHrG1U7whMm1Y5AOS+Kl1w37jnFZpIJ+ulgjQ1ao4L3M336acgyJVUQXpMie43sg/SRplrkTaIf4iorkNiU7yXwWZHrBOynJnbDi8gVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFkNWT9qi7ZMq+d4X59uKo9TPr7WcNyc1CNt4P36duA=;
 b=LOpanNnLwm76m8A3PP/ARFbLk8Zsdkhp9Zu569ST9CYjLzBxrVs9B9kKZ13NYtCxeqkmxVccGrBAApKoz75Ro3uWfXYK8pF63b3oBrUccnveJDhfLAuUOhRlBtaAoG7n791LngoZcc7bnfRL3tHE1eWMNJ7xKkqxsXweVVCsbn/0dWyn6WFCULMsZ8uEBRqht+Yrrsq97pkt11jtHX9CXCTLRmgyantMug/Jx7Pc+H+3hOMk10WApdYBc9Al3LqEMSw73aXH5HNpVffgPPWU/HdCpZRRQyoZH2MGc15J9+xxRqUYbejQvmPfad0FFux67kSqqOokjVlM7PHRUgycVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFkNWT9qi7ZMq+d4X59uKo9TPr7WcNyc1CNt4P36duA=;
 b=I5dNNmTdIC18qBiYF7G4lpleDQiJr6yqojRHtcPxZAF8BlWkSFoApdhJ7bR5xqbnxKpeQsDWuf89pMHzysnEfQC5jDwxBC59TFNJ4zBmQ9NRGNwAkvkC+FgENiffLE1ChxCtdChic/nypnBw4gaGNjuJaEz2XXEJ9vhoMBYwI8+/9dsaAgZeNp+GAZT0dZ1be5RKvq5VkkGVcDJ6wPCVXaNNIhz3MavzY4eXYylUH0f6l68Zudx6XMA7gGced7MptZtCdKbSDyAWwwnrV0P426fWSdOeYCPdWBTdtq3BICq25BIEAuUJjfJXK1RPUqDImz69eGtplrg4z4FnL8rSCg==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DBBPR03MB7451.eurprd03.prod.outlook.com (2603:10a6:10:20e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 19:34:31 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 19:34:31 +0000
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
Subject: [PATCH sched_ext/for-6.15 v3 5/5] selftests/sched_ext: Update enq_select_cpu_fails to adapt to struct_ops context filter
Date: Wed, 26 Feb 2025 19:28:20 +0000
Message-ID:
 <AM6PR03MB5080996A206B9BE042C7C6D599C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0349.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::12) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250226192820.156545-5-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DBBPR03MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ee319f-607e-4f5e-11cb-08dd569c97a9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|19110799003|8060799006|5072599009|440099028|3412199025|21061999003|41001999003|12071999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OLVLa2/MSIDJo/L7uSQ418vgWT6lbHDzJIHObDR/1zu5k2CpOXb0DlNZSXDp?=
 =?us-ascii?Q?2nyWVpSlaMoz7u9bc5EvTMMzmV6uhbjSDJdIbpXYrZ9MG0v/D8TgYhQk0DeW?=
 =?us-ascii?Q?Gy9lgpSMnvBRX/yna1EC+G8c3Jd3uCE6s8BmmTx3qnqXomYRTg5Wrp+ZvaL9?=
 =?us-ascii?Q?OipWlJIgZnHMwvUDIJ/R82Stjsw+Dqo8hVstgzWSLOlbVvP1jRaFoLDXk+Rl?=
 =?us-ascii?Q?vGrbAELFhv5u8ZwwyutVYEwqh0ATlZ21zxwxbneUi7srM+QksWY3poLqheNG?=
 =?us-ascii?Q?GAWCJMhFCpktxtUR10kH7wNqMPh28GhVluVRcO/VnLeCRU8Pah+eNeUl69de?=
 =?us-ascii?Q?Le/DzT/BRrn94eBgIPXT6zaJztkIVCdpwiHmqqOlhWabNGr0SesouBdJg1J8?=
 =?us-ascii?Q?btwR4Tp7zyJmaL1EzIbiyTqXPpF277QClSsNgCahkduRSekQNh7TkACq5hZp?=
 =?us-ascii?Q?Ry0jfyQevVwI1f0PUFZzhv66wjkw5M152gKPcqKdR4MiW1OLw4+Fc8jrK8zJ?=
 =?us-ascii?Q?6232Ie0MPk2PTHukF1MT4uR9jBUGSkldg00OZpXVk9YIQjdozwIa3n65GWHe?=
 =?us-ascii?Q?1QA0p3oWwRCgB8bQrfh3wbCad4nEPEyhBhdzN0Jqr/VAEc739BsHYI8u5L1h?=
 =?us-ascii?Q?2prbG0sDiDvFnbn7IkmMhW6esA2324cLPiXZKN+a2g3l0bH+Ay+tTjlS61Uf?=
 =?us-ascii?Q?VHtArO1I8wRK2WTK6i5PzXQJXS2R2txsf2rzeVDt9vReZurZ7pdZ7X6knDJC?=
 =?us-ascii?Q?6mhu16hDcaYmLJ0Utxw3W03ZDYQLjxUnDwvfpv5oQmjcTIdG4Cu95+2x37D8?=
 =?us-ascii?Q?MlOi6pcUzk1Z8hvadWU5NUpOWYsAIw3rL81xCD4O4uJH6ddZpFe1QI1fqYL8?=
 =?us-ascii?Q?LS7zfGjd5YvrxD/eZigKxS4ruPoYXxHJQRBeL2oaT+B9pfCIiUtL7dziNMrG?=
 =?us-ascii?Q?Xh47JosPHSejklesidZK9rurwpD69GhihcQk6mF6yGjwWLbql8P1NRGozZGG?=
 =?us-ascii?Q?p2h5vOwkiag4w9df9rYAvnpvT2SneJRcAax170Sz9FgkgrD1XmzfDY77uUtb?=
 =?us-ascii?Q?7Ub6Q8kVa4ET66L+Mwck/TZUwHdD7bbF+t7FOKkpBxVtSX7W6KL1zXE/DoS0?=
 =?us-ascii?Q?TeZsjZl3M65olCisDz7aETVM6Y2qEtT7eQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YfyosufItesbFH7StDoM+vNTbL1T3Taj4e3mWidJ3VxS4PGJGbd746VTQFNL?=
 =?us-ascii?Q?UGzGCNYp/+TSh9rSTEQ0jOwzfhbDIrKgWaQr8CKGxpkQvql16JENY3ovlOSP?=
 =?us-ascii?Q?P565l9e1XVuoZF96nhD7nNSeKvCGqXpcuIdpx3lt/rL+S4j6xdtnEjDVkOZH?=
 =?us-ascii?Q?UtlPuP7JJ6X01ZJqXHGQz4+5ymXvUI/PHEyBs7kRJ/uNzyzKcSq3/YjS49bb?=
 =?us-ascii?Q?m4zAlT0GpydsgZLCcRcx4nST6zygZTjniTwRozyH69wT8KyKZU+FBpqaGtMK?=
 =?us-ascii?Q?TBILWYpHlZChqrJ9Nppb+mjR9ligUP4E37Wxp91yU333ZtT5cfh6SvuuPNUB?=
 =?us-ascii?Q?1yLyLeW2r8HoRV0tbbTl8PKMh5CdCKKZZQMjgBtSlz+P/WIlojTrXTcSiOjV?=
 =?us-ascii?Q?GtPq1Xp7b+f8ulfQ3ATZ4oq2YSIcTh2WuU0DeVM1pVYEndgcpYrRAFpELIAB?=
 =?us-ascii?Q?Pd1Bd8a8NkpUaqNhjtzYfo21Z/MKGQAFqqOmYyxWavKPs3pSG0F4yjWB922x?=
 =?us-ascii?Q?93loRfcMKS8Rai91rgIWOksDjf6GYYN8BLL7S0F52QT8v8xK2qQ6ruMhe4VN?=
 =?us-ascii?Q?ExODKaOosR464D8yyDj+i92yT8u0O+ldTi4w9i1qerFgRDo6wFjNqeJUOn7B?=
 =?us-ascii?Q?C71EckY7IcFTqAi8D9Hbhh/pUgMN4Z65jwBK+S6r+KXHAjoapxeDk+ha2lr9?=
 =?us-ascii?Q?b20+3aZG1U0x3xFUjft5DJAIm/iIlOO9t1XyH6kgyeMuQpyqbItAOHUxvKJq?=
 =?us-ascii?Q?dj/zmO11FMzoQhfF9sZQbXY+7EHO06nleizpj1Q+IDS21zgGOb8KV1NHDt+M?=
 =?us-ascii?Q?ornqMuXzbL9eeaIkCFN0dGlRFbSLK60JdoUp1YuN7kl/xSulcin71WWsxHJS?=
 =?us-ascii?Q?p0grIqYhbe6td434Alshrk/OJJDSLxpxh+QtLJ/KsQvHTLbGVikT4vAPskGs?=
 =?us-ascii?Q?pFiG/2KUh5FaWUmEKrfNIlKWzHyGpXyiknm/yR3T0ByvPlI8zo+3h71GtqJh?=
 =?us-ascii?Q?vZqrB/xlG5qt6JAVnAHdq4tp5AqqCOXCLtPGgN3C1lhz32uGWp62f6ejxP/5?=
 =?us-ascii?Q?qZ7nbmmWJD/26oLG0CWiOEL2DUSdegdDS4Z4VTXdnDSIyuSb6yj6JFFFUePV?=
 =?us-ascii?Q?gYB02XXmt1XPn9MhGkFeyP4UBefIlyvpD2cWuvs1OxJ1Nj9aT4REhzBdXkyV?=
 =?us-ascii?Q?AYkI0Bj7z2+zVWpMf9cSvlx0flexcWVTaNNILxhBNcivsKynvpsARq3laDNp?=
 =?us-ascii?Q?BZW0HJakvxduQzCT2fPb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ee319f-607e-4f5e-11cb-08dd569c97a9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 19:34:31.8208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7451

After kfunc filters support struct_ops context information, SCX programs
that call incorrect context-sensitive kfuncs will fail to load.

This patch updates the enq_select_cpu_fails test case to adapt to the
failed load situation.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 .../sched_ext/enq_select_cpu_fails.c          | 37 +++----------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c
index a80e3a3b3698..a04ad9a48a8f 100644
--- a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c
+++ b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c
@@ -11,51 +11,24 @@
 #include "enq_select_cpu_fails.bpf.skel.h"
 #include "scx_test.h"
 
-static enum scx_test_status setup(void **ctx)
-{
-	struct enq_select_cpu_fails *skel;
-
-	skel = enq_select_cpu_fails__open();
-	SCX_FAIL_IF(!skel, "Failed to open");
-	SCX_ENUM_INIT(skel);
-	SCX_FAIL_IF(enq_select_cpu_fails__load(skel), "Failed to load skel");
-
-	*ctx = skel;
-
-	return SCX_TEST_PASS;
-}
-
 static enum scx_test_status run(void *ctx)
 {
-	struct enq_select_cpu_fails *skel = ctx;
-	struct bpf_link *link;
+	struct enq_select_cpu_fails *skel;
 
-	link = bpf_map__attach_struct_ops(skel->maps.enq_select_cpu_fails_ops);
-	if (!link) {
-		SCX_ERR("Failed to attach scheduler");
+	skel = enq_select_cpu_fails__open_and_load();
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


