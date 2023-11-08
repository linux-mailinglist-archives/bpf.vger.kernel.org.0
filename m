Return-Path: <bpf+bounces-14481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C03F7E5842
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 15:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6E02814F3
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 14:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A33A199B6;
	Wed,  8 Nov 2023 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WMdK+84s"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E26199AA
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 14:01:12 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210F71A1
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 06:01:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzDc5Ydy6aah3hj7zAdVkhT8jolEu/k/yH7c/5Jd5MOfaZ63eDsME6O9HRZD8BRwIn6qQichRMYp74Oi25zfAVbx16ScuOBjprbG22VgztBF7AiE6kkOIDX8K0/W3K7gBZ3eNP/H6/PuKtqCdKWZtys2fX7AoDN65bk2I5VK2jlxU9QBMqUEoSx3PQ4unNlJDHp1jqENZ9Jblgt+McZjQF+Kk8vghzWfGeJf5D7zg3nADLvS58B/OWHg+do8n2qnw6WTNBQGfKkfz7TqHrGr++QbJfScbNQduWeE/QyWMqEuRzX/1QZjXpjEcKXq6pWFpxT7Hgp5rAmhCUr/GbNLdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0K2qGFNQr6v2imLUtHLG8QMDv4IulzeeaMYGuWfJHXU=;
 b=Jn8ew15FD7argIgPapL8mo2aWe88v62TCljsqHLOLo9xxV8k7eXTDMo/EgMjoOWSX+XobYEi4KbPsltA/0t9KdOxOS/6YPuYIU5IiIMIoe/yyZOc43Lwymganbctcv4MOz4/nR1httBgRkTK6u3Yfit7cxMOdV1URlV+a3E/VQh7VfQQSwKHQVswcfLlaNvu4CZ3dtca/BmNMNfBpr+KwXhSYAYaTA01E07m+fftmFmdSmgSjEYXRw8VagbczdKIqIVX3hPg5j1nRtKdnBgLf70rq/s/9bkYlqECJFfa/Gliv2z1Dz48WIfAXXLDJ4M7VnnzgX8vzM43SI6zbbaPvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K2qGFNQr6v2imLUtHLG8QMDv4IulzeeaMYGuWfJHXU=;
 b=WMdK+84shSKGR52bZYlxhtDoP9eTgZ1x5ki077Fgpvfmrh0RzJA3CYeT/wzEwOGvr2e3hm5byH6FQqX2xWGrNaDsFIa9nyFezBHRbv2V3IxXrA8TbC+VxNSN1nwVnrTK91COf9P2KzSV0Om3BPUC65AP3J1SGRxLwiTYCtT2UT9c29gMFpuF5yU/qMjLCRD7Z70WHm/yUiRCEEHcPEPa0lZrbq++LNQQ6ONv9/AQ4ad1S+7BZzSldj83ov4eSu2/NmXSFBVUka4mZZ6lijbKa1bjpFnvPo28n1dNqSQPhZBnoihxDVNJmGXmOndHVgpUgLzYH3lm+1bIL76aLSLJVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AM7PR04MB7045.eurprd04.prod.outlook.com (2603:10a6:20b:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 14:01:09 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1%6]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 14:01:09 +0000
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] bpf: replace register_is_const() with is_reg_const()
Date: Wed,  8 Nov 2023 22:00:41 +0800
Message-ID: <20231108140043.12282-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::15) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AM7PR04MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3e2805-7843-4fdd-f46b-08dbe06328e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ezj9W1JShTYGXeYc5H6BPsf7stfvc4nPS8Ynd8PiIGAfO/bW7RXIF09SoPI5j1JRivFgkzyQf2vDgfzh9B+T9tryguU7UFcyBw8KbrO1NVZ69LdzCzszL8/RQgzA39meR8qmOmjkHOrjef97RwZ6oYPq9TAWBGpbo7D933Vhz7JKadBZ1pGhfXu2IstGhEfO5Ep7M5BR1JPJqLF7QQ7V8p9cWn3Ua5prGe4KEBe1V7jYKRC7YuDoaWsAMD0vRxAzZS4jSGLZC7j9cLAGZ0LhqNGz/bLe2PWLR0G86jGNqLBIEVBpTxdRxdFfjPoIbVDIL791SfgpAi6aJOUfQMtM0XIOdM6ZxOzAM58UqSR09yl84xReq8wyR7cdnKaNdlmhyznL5/9OjsSyXCMJXMt+R2NX7uJCRG9HR8+IzgjqWovpuh8p/oLoK9N5KWrulao24usEvqtHUe7bejXVYCJUGoTx5UOLWnz4KcwSSL8WVCfAd9Aov8vTU1Hc6syd+S2O6OfxlGCLqFueO9KaHzUZlqrChouKTZihbe3wALctGL7MJWwV9o6WQd2oKL9Hv1E6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(54906003)(66476007)(66556008)(66946007)(6916009)(1076003)(316002)(7416002)(478600001)(4326008)(5660300002)(8936002)(6486002)(8676002)(2906002)(6666004)(41300700001)(6512007)(2616005)(36756003)(83380400001)(6506007)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3PlqYx6o4AHy0D/ZYXEbffFn0wVN3D93O7vreyyJ5PShtV9YqYYlNZ6v5sSy?=
 =?us-ascii?Q?yAPeoixE+tHxP/ExxdJH6zcb4kM9gNhY/CaHOkS1CuJyE7iSE5K6TUYGcdo2?=
 =?us-ascii?Q?mDoaFyd+dGLPBvXmQvplRWhuEMb6k0pBB1sPQCFzJehY/Dc7JE/rQaM9iLDA?=
 =?us-ascii?Q?Rvn8BxhfWjcJ9V9LdjUlOuSMDbHJV4s+DluEcs0b2WWUJfnk5RGOVKUXRH+F?=
 =?us-ascii?Q?++p3Ct25ERuuKxte0wDN8cbUP2lwsKka9+DvnzuqtTfAQckmNgnLp2NZBDCU?=
 =?us-ascii?Q?O2tNhSzTmNNVvRyafYqgMmn3T1sqZNp9O9cCRrJ6elFnjeNhidTYPo+hwe82?=
 =?us-ascii?Q?qcOYWS9+15V5oB3qcJceef9Nqi22Bb/1Wk5Xp5roKHT75r7wukOqSxCXmQsk?=
 =?us-ascii?Q?57GW5/x0N2HPr6aXJWrcWWST7anYJKk14z/R98nQCc2Nl4kIXoCjGCgOq+0I?=
 =?us-ascii?Q?xp7KRbfBfJvhulkUicHX9tBAV5GBGmmcPiwHGgBokUodVVwvmISCWeUm4UE0?=
 =?us-ascii?Q?vKV2YumLjhmG2dWuCAd0xkQ0cYmvnMTy09PPYYxNw9r00sXpSVTI/muMBLpT?=
 =?us-ascii?Q?SsIsjDkIJ+B71CVFNVd9XPiEg7g3f6YtaZw5Ii08UsIe+IuUjYarYV9go0YX?=
 =?us-ascii?Q?J1hlcYSdIHXx7L8YKY3N75zkKETXg4FzsTvSbM7QCApPZPbHjVwSBn8xyTIx?=
 =?us-ascii?Q?oa6ECuZAFt76WfX8mJoqLRixpef+H04CTiCGH9V7p1peIQQFEK6a9pk7rmEF?=
 =?us-ascii?Q?GanCbB7tReDPTStW0VwwbawspcCXkgyXQZYoD+Hw4+2etEJGMy3658E840Xr?=
 =?us-ascii?Q?jDUF9KBAhoDpuzBK5beVldRC1rv05Cz9S+9WsMBXIVDsJqNINrKkoSIN7iS7?=
 =?us-ascii?Q?KSBqk/cMpSVeZSNdFgjQg2s1RzzIbYjJEcsagFkff2uWCi1zzvzwuS+DkQP7?=
 =?us-ascii?Q?nwqia+F5bWKd1SudEVF/Br3nFE3LZk5iwf7pfuebcRZHqCJiVq5xV2aoQ8/U?=
 =?us-ascii?Q?04yiq3yjPk8hCesIzUsxl16Qf/omfkZ75dG0Wh8hZauHCCugiyyNeOiD8oJ1?=
 =?us-ascii?Q?7LIznQZ8r07EO/9pAH1TwSjrsJddCCM8f0ZcSXKXe1O06GYJ5QOGMeW4NgYq?=
 =?us-ascii?Q?PVSmuEt/cmRIHBu6gT4cyTgbLFeA2Us3okv+tgam7JoqehHjk+aISNP/jgjJ?=
 =?us-ascii?Q?veaG414/qeMxqv3B25jE+CUl8BG52l7gsvqYL57FeAPL8037pMXnuMY5ADGU?=
 =?us-ascii?Q?XcC3MjnyVShDh0STx/FEKZrajr7AhDWgy7xqsqlsy9HNIuPsuTcSVXS/ptwG?=
 =?us-ascii?Q?9+kTJAfDEwmmCa0iZ3CA8IJU9fpiFiF4GhMgojmxYImcoZBc0+OvsSFLNLB0?=
 =?us-ascii?Q?R3qxVQMlXTI2SYB0PYDg9U98tlHTcZsYDbcZf4bqZ863XHTeGlienViH7rax?=
 =?us-ascii?Q?qUSqUp757nCdA7MnH12MOUnGNSj3EOLQHbnEhE+9o5Yd6+6Y41zxBsicFvnP?=
 =?us-ascii?Q?n3PADG7bE7MwmxYzvmJZJZyh2acj8NL7xzghCH5QPsErZXp0/1cHketKUoMY?=
 =?us-ascii?Q?zRq/OK+NOgBGgm1IQnSQhCh7O6VN+bqhy8y/k+hfZx3uSfsmMdhQR04CIYVK?=
 =?us-ascii?Q?V28GblLvvO+YSfjci9myCBbKEzliPNQDJ3yzSRCRfKpITeW7BX2GNiDBNiVt?=
 =?us-ascii?Q?/v+1rw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3e2805-7843-4fdd-f46b-08dbe06328e5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 14:01:09.6797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qEbVFjPfhoNVNSZjWPe+b2NgbZ+BTXBAtnYT1qvE9iKlTybMaZ05mKm+H7BkxouSBlaZUxi5OL1dXwc9BAYW2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7045

The addition of is_reg_const() in commit 171de12646d2 ("bpf: generalize
is_branch_taken to handle all conditional jumps in one place") has made the
register_is_const() redundent. Give the former has more feature, plus the
fact the latter is only used in one place, replace register_is_const() with
is_reg_const(), and remove the definition of register_is_const.

This requires moving the definition of is_reg_const() further up. And since
the comment of reg_const_value() reference is_reg_const(), move it up as
well.

Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2197385d91dc..a7651a861e42 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4685,9 +4685,17 @@ static bool register_is_null(struct bpf_reg_state *reg)
 	return reg->type == SCALAR_VALUE && tnum_equals_const(reg->var_off, 0);
 }
 
-static bool register_is_const(struct bpf_reg_state *reg)
+/* check if register is a constant scalar value */
+static bool is_reg_const(struct bpf_reg_state *reg, bool subreg32)
 {
-	return reg->type == SCALAR_VALUE && tnum_is_const(reg->var_off);
+	return reg->type == SCALAR_VALUE &&
+	       tnum_is_const(subreg32 ? tnum_subreg(reg->var_off) : reg->var_off);
+}
+
+/* assuming is_reg_const() is true, return constant value of a register */
+static u64 reg_const_value(struct bpf_reg_state *reg, bool subreg32)
+{
+	return subreg32 ? tnum_subreg(reg->var_off).value : reg->var_off.value;
 }
 
 static bool __is_scalar_unbounded(struct bpf_reg_state *reg)
@@ -10030,7 +10038,7 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	val = reg->var_off.value;
 	max = map->max_entries;
 
-	if (!(register_is_const(reg) && val < max)) {
+	if (!(is_reg_const(reg, false) && val < max)) {
 		bpf_map_key_store(aux, BPF_MAP_KEY_POISON);
 		return 0;
 	}
@@ -14167,19 +14175,6 @@ static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
 	}));
 }
 
-/* check if register is a constant scalar value */
-static bool is_reg_const(struct bpf_reg_state *reg, bool subreg32)
-{
-	return reg->type == SCALAR_VALUE &&
-	       tnum_is_const(subreg32 ? tnum_subreg(reg->var_off) : reg->var_off);
-}
-
-/* assuming is_reg_const() is true, return constant value of a register */
-static u64 reg_const_value(struct bpf_reg_state *reg, bool subreg32)
-{
-	return subreg32 ? tnum_subreg(reg->var_off).value : reg->var_off.value;
-}
-
 /*
  * <reg1> <op> <reg2>, currently assuming reg2 is a constant
  */

base-commit: 856624f12b04a3f51094fa277a31a333ee81cb3f
-- 
2.42.0


