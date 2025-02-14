Return-Path: <bpf+bounces-51601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3DCA366BF
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 21:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609CF1893E98
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 20:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690F21C8613;
	Fri, 14 Feb 2025 20:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DWEe7gkH"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011023.outbound.protection.outlook.com [52.103.32.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C4D1C860F;
	Fri, 14 Feb 2025 20:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739564060; cv=fail; b=qOxpWtxxdUgII+FCSzXlofHeQrH5wiUhZ2+/uKlDrIfpnOdbCHu5XPUzlBsSm1qf9yyAEc2J+WmqDg/Fo6y9A57yeB2HWINkqF+Fh6AoltsUv366+fnl/ln3fxx4c/Z4MEXVyooRs/Rxd2OnWh5vd9qOT2cMZzX4E3WpYIElrRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739564060; c=relaxed/simple;
	bh=ypXZfEqdh4D8qNVzzgsXTGxGo9Tzi11wS6e4bO+4Kk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rs068gO682lIhDz2jf5uNRl0O3PHPUtv0nXdBz1esYVoC1nfU/BHQf44c+S2h1bf+F594CVg/VqjrK1W+caXDOs9ZzJ5KMRCpXCMAhuSfmOJfQXaD+0gi/ADwVYlOTZqAzl+elvE98B28raxmd1l51pC/4ygalrJZdmXaZ/v8GY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DWEe7gkH; arc=fail smtp.client-ip=52.103.32.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7RAV9EdojyxYCRkorudhA3wm1kFz5FZ3+151MUDmYIHbZS1IKUfHbKKcg+HYDdezHUwzhkxeNYYdDwTeBLaOlYOHuyTBe+0w8gvBIntueJb/wY1kHoCl2So2tANCieyRzawfURQ790GMn/uuwC6TV/ZSRboJaG83N8lBnP1/iYvCA+udu/oa7visRND00o+BaFBUb/VtsR/Hw0dpTr5NNTbIr9eNEI4z6eQKIipro0uaDDPbqV4yLGRvSLFvktsl/u2kqjYPS3ll8TaVEByW+rJ99e8EQ42SbkuSWQwwKBLVeJfqvtyUCav0xt2dkNjIH4V1uBAhyKdBW/L+4WCpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRnGQA+nOZThu23j/JO28tYgMaZH4gtrbP64dQJvHRI=;
 b=AE1Kkpmkg+4uIh1mG29pKwEDOayModpYoFTDGFL2H0WDwBW71qBhu9colTOWT+Zk5kx+iQ1o0H2FwgYnAce+dLJ5zYAduaRg5EoF1jBNIxX1xx42h5FExk2Xf+mGD/9Ay+NTWwdraOzyKDDCV+E8jrC1SypqvJCP3R2KqrT5WRc0Zs+Gw7JGhTFwrRUCp3VqPeYwdN3zHrE4nbYzee/SNE5mX+WwUgt8cW8GlFruQg21VtaNWHyNLaovHlBaFuvSj09/Xa4DEfnHpJKlAInKWjUtcfHAJ34FWS4Fjr0D+zvSBBmhlYc8KPsljpe6oIIDQkVTTovwjqQ3yzxH+H46aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRnGQA+nOZThu23j/JO28tYgMaZH4gtrbP64dQJvHRI=;
 b=DWEe7gkHVZt68ZcWY/T16+U/5E3QVfy3UyCF9fm2ori/UBREee3ZNvL9mFFdP4VEth6nAy1fm/bsR6A2SgK/gqGVu+vwwWfrXxku8kHfcU29tZnehcmxafhttAVUXAHVkvhAaB7fVnhY7EPBqalP/zPAczA0MbrmuOrwH1LMG/lOh3BRYL7zOvvTdTspFE5LYnGwymAhepXXo/laFss7tlCXcM929BFvP9aE5Ttl7WmENXd5xHBvWDsr+InkpFVP6SPe1RQayhVf8cYJX/LQvSokIlYbFNMIYHGHuKe5IjdLy0GkMig+PbNVvfWFa+pyu4KHmltA0oZ8hHNnqRdTMw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS2PR03MB9931.eurprd03.prod.outlook.com (2603:10a6:20b:643::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 20:14:17 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 20:14:17 +0000
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
Subject: [RFC PATCH bpf-next v2 5/5] selftests/sched_ext: Update enq_select_cpu_fails to adapt to struct_ops context filter
Date: Fri, 14 Feb 2025 20:09:29 +0000
Message-ID:
 <AM6PR03MB5080BB301B84350BAD3698A199FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080855B90C3FE9B6C4243B099FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080855B90C3FE9B6C4243B099FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0277.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::12) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250214200929.190827-5-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS2PR03MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: 51fc57a3-cf03-48ed-4516-08dd4d3426e4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|461199028|15080799006|8060799006|3412199025|440099028|21061999003|41001999003|12071999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ks1DE/1JZBmg+iJQ1y3+igQB3w8yyXYYUwltYxjbOrLSDJ4ebVKYHVBbLrKD?=
 =?us-ascii?Q?+Y831lDoBNn0vuQF1uBl86BzE51JDabCqoo79uF/qCkZBnttPJ5fbtWABS3A?=
 =?us-ascii?Q?omaINSSjbxi3kEDS0hFa6cib4sHaX5xAg0+ZLRg4RQoOdQoG4mKfIPcnbbGj?=
 =?us-ascii?Q?QvssLIb36l+CHkEw8MVO0nvD0a/J//eRdGAO56sJlxeZSWr4KiTv/3jcfcZy?=
 =?us-ascii?Q?MaBI2b4Ov+4ufYkuKYk73I1uv30paXtw8HHeoBh7jaEjc3we36Ykeh1gTHR0?=
 =?us-ascii?Q?5SmcqeCG4Rp/r/uxUkXpifiSoubJS2pxecGm6LMbZiNvEOJasefVuUVknQph?=
 =?us-ascii?Q?2+JYorO0Ai49NI4exyBxuWKXw//5nu2iVjSmP5iSlHHgFcwq5mVj76/qJv2b?=
 =?us-ascii?Q?U91Ly76upmWr9n/tttJcvjLGeMXYbiX1O9DUJcQoSjeLWR2NXkzv9XACwb3a?=
 =?us-ascii?Q?xsaMI8G+UI4LL18B7JncYWBXFxM13C5i59Pt0vRhSPs271f65rbBkX6vOY6l?=
 =?us-ascii?Q?qm/mHoe6QMmC53afPlaIfSzzZc3NO3n5Di7Gi3HsVqOzAo2/J7LuicIKUibX?=
 =?us-ascii?Q?glmoTGRWqVv/dT43bUCa6uo4j5eiS9Bs7OhpongS8cYH2hKQPd2oIi1H/Bzz?=
 =?us-ascii?Q?6k1lcb2hliiUTaBzt7ATnZ7Qixg8jCvE37QWHbYv9kBWlGD5SI+rBBgX0t83?=
 =?us-ascii?Q?JUJ2nWhm1l9z1CIyPFrAgZzM+GmeZwHdcDizaUCjhnyy3U0yJ3t3QSFvwpnI?=
 =?us-ascii?Q?bJoWlA4BGBZ2R9uKkjU/45AwL9UCbAtyglMu8J8SZlJfy14icEShSQh5PX0w?=
 =?us-ascii?Q?EXJ0wYxKeim+ojdjtiUXoNyQiUHYMUUplRUXMcKBIEqMxghIyswiHfmzBfqC?=
 =?us-ascii?Q?ikPkJYrnGQBUFHW86B9+dbMvD7/ibwizQzIcPmAXK91qcMAzmJCzJ7kc8CXd?=
 =?us-ascii?Q?xoTT1q0RVUiifqCeLXYf8bbycsHGdi5awoK+4ssT7A078YZM+fYw+exaUHVD?=
 =?us-ascii?Q?EcbOQN8MAS3IkUDeifE+6/tfSFSZGbVY3QslzXRnUdgTYZ3/Nxe8c7CK4BTd?=
 =?us-ascii?Q?Il6WF3G7oxL3vbaqXYEa8zJCOB3icePZl7c5Lh28SrL8tdRv5Cb02QbUAIwg?=
 =?us-ascii?Q?nFf8aegLglM2Aan7FwuTmPcJB09RcGt3nw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yVhxt29k53ZoMfrVAYUzC/wrdu+Pn2FaXiSW90rN0PSkfPoN4ugVTV11C1Jj?=
 =?us-ascii?Q?/EwfWSe5ag+l8nAczw9t+tu2lbPKzhzmuqAh84eOlphqwGPaNE5WWrTcpo9m?=
 =?us-ascii?Q?DcXwFMwzyN4gm/dVZ3dLDKQflHTLhIdNI1RSQoEKtsPv6tXAXHZEXxiVRuP5?=
 =?us-ascii?Q?Ke4v4sKXE3qsqnBrpk6b8D18iMULS5/LtUGS9Uqsk3tiTiyFUuEdueI6lVnv?=
 =?us-ascii?Q?t374gw+DopT4zJDgfx8X7FVt5pTxQ7AQFJa5LUlVo9etr91ujarl7diwE/2W?=
 =?us-ascii?Q?At1/LEz1y+1U7nxYET+eNnYfbZ1MIf6MSewTGsb3RP8Tn8AZDJuXY9ZBssu4?=
 =?us-ascii?Q?6nr/fRnlw9y9G0U3d8cB0UbzLl7r+tHo9UOSRtcDv9vouK/PmRJFyiVBEbI1?=
 =?us-ascii?Q?DrG/at6wsW2jH3HwXgSHudRH5I+47yaCkcRq3OL0l22AROQVPGAd47Qloypp?=
 =?us-ascii?Q?EFfIY8XknQ1Ila8IyarIZjRhPbpbYQkpFmS3NzDR1H4usPDsdkz0ZllzlKmc?=
 =?us-ascii?Q?n8cwyoTkmW75ifGVzn6iy/6bHFUjRBZHUX1PJ7wq4ich02qnREfD3Vw44E6t?=
 =?us-ascii?Q?GQTpghXkHI323AZDh5QJgzAjcbXJA7ZhfukA4LYGnWidpuCMQxRPlQxTyny7?=
 =?us-ascii?Q?839bpKR5TsbsldBqbOGG8EWukESYoonHUJ5vUf4Cf9f6N8fOAfZGOd0+R48w?=
 =?us-ascii?Q?ogd4duZi06EJcjfhpVZAY7tsgCyuCwZT8ckWTll3zwcVDfTcVISYaUQMXELL?=
 =?us-ascii?Q?it6Pl2BwMvI7WKV5uKCrqL9tn6hW3ztahASdqeDOf63vAxs/1Dtivp38Yu9c?=
 =?us-ascii?Q?7EAi6Lf/EiGY4+PZ2DNq6zcrwcD8ROx7UEe5rGQD+wrcD566GIbH+vGPdJJm?=
 =?us-ascii?Q?ivopX+Pk/v1kGzKuoHT4kaE9DK8sGe4J4gF+X8Sv41nUyVCze97TxhFznZgP?=
 =?us-ascii?Q?zzyetv2hemalYWn80ACujyM64MDMRI/5icdwM0Wyn/S6WDtWnSFPWKgjX7lV?=
 =?us-ascii?Q?hHF0f2lZ7NWjdzIDKk1/bacS1NSU8cA+8NCl8uLPeIemAR6RsZCKSbi9ele5?=
 =?us-ascii?Q?lfaSKWylutUsGmfgoBA5MBoEmreQp3lXMJ8WdcOpiiTlGq60zYZgc8U4FJUb?=
 =?us-ascii?Q?yviqAHa/49yEUJOVQt0UPipU3Epu5JIXRKnlQJKcziGrMLM+7EGxifQzV9ty?=
 =?us-ascii?Q?dgBm5ExtY6ruZNQSTIZk/nqM4WVZcGishKYfUth1vYWQe5EbudYw99bh5CdW?=
 =?us-ascii?Q?uVOQBB2/4kAl8UpNX+/Q?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fc57a3-cf03-48ed-4516-08dd4d3426e4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 20:14:14.4963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9931

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


