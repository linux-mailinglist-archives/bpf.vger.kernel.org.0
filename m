Return-Path: <bpf+bounces-65333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3EFB20907
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 14:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C161881FF7
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 12:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DAE2D3A9F;
	Mon, 11 Aug 2025 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="gO96rdag"
X-Original-To: bpf@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012042.outbound.protection.outlook.com [40.107.75.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7771A3C38;
	Mon, 11 Aug 2025 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916004; cv=fail; b=sO1WkuCECZUC0gsmvX1pmmpM19OZBBWFpONy6eMBIL5EFty5iEMW3tMRfGkpfTTPgS8ajxvdhQzX8AbvZOp8EQc9JvGIW5UkZd2gdZJNACM9E4S00b2vEwJ+pvdiRt8sNDrL/oFTMf1JQE0ZJWeg0QfolH92J6KFBvoTGjtZSRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916004; c=relaxed/simple;
	bh=IZQFnaiTzcuXyE07eLE6hwz85iKCvDNs3qK4j0W5NCA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sKPQYh5AswnwhaYx9tJHU1gpwt9n8Xe5SGljOXiBbpj7pSIGnFqYE6lYAje2kcPbAamFNHGsrwxMxEwRgu3TSm+Y7OIeDz01mGmpdMW0cgeAV2l9pijzGaWndsG18uCqvK27E3w2ViNi3FP9v97IeMrHvYrnmN1aGeiUG3uGxBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=gO96rdag; arc=fail smtp.client-ip=40.107.75.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuvsiCMnapijfZ2s6dx4iR5i3lxiVanL73OrogRgkDlizVdaMW87oAB3IHWrBLfgrBTkUBUsKvXo3tCvm3OfkEPENOjiAwYeM5Jo+t5YnVwhTcd3cZNIXcQ2+AWGMjLZGnQWG6XIR0vDPsLS7pq2PEm+3U0w5V1H69mLC83mDCM0exXT4PUtkg8Phmari9UAXCZBh0Br7n2AA6xROeI+HIwIm4RSFDX27nKaNRO0BQ5KNVpmhZMRHMCrj3/bdOfAL/y1nbBc3wxON0NlEs0QNkxkh1FbFcdawY0hVMFgmRTblLL2vKh9vNrM5b+b4sdDnG6pzovjXYhfCzhjcI1Iwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKWv6bKDlOD+OqIu/MiERHHHMvIEtWGKDrXD3acYZ+A=;
 b=hmmf7aIp6qSoK0kJARfxkbpoRTqCd5ldlQbxHUnbBSxIPgX8qfE78/bvaOeWU29LYwzLgp1OS9m2iPMH4wNbubUT8jOSTGuiGxZS7bx2xkK11CraGEv+VfEYJmJqb61oLXyJfSrPqhCe54a0xwYtDNRmThA+gBaJD77a0WOk9tKfCT8phHl6AiBHZfP14wqtPtNjsB90wxCAaHxySpO9MjcjOmwf56pceISrx3dvy/LEiGwAEoSU1pksnIVghpKga18q/XVm2OIDU5cjlaTsroVGb7FrJtZr4vE18c9EaxHFdUSLBo7FdWfxhJZTJ2hmlOPenA3JPgIfHDyyeOO0AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKWv6bKDlOD+OqIu/MiERHHHMvIEtWGKDrXD3acYZ+A=;
 b=gO96rdagKpW+XyVNWo71kFoixQTrlLMkf10iC+fIYTZdCuO4emJBuZYRVouLjZiczUCYQTwyB7hLMB89pNGOAcREduQlFRdjLAI8i6BHzfYYcLL5xHQp9jugPBbTQdkODTiBEB9VIhvUovGktleo6KUcd5JLOiC7Nol4k/w//E7XtgmjN97GycveWdjDc+Sj4GjqgEuRNYCROvaGkpgLk8dKW6MQ/EknGNGHpYokld/rQDxpyNvvm3uXRpgJTbtX7gf3DMxZ5uV/fXMHnzDw+v7l5UpzO15jZi1oxFn/TuiahrjfLwt9Qgnujtc6J6JhKKNFth6p8lKh7lDsbzYfjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB7216.apcprd06.prod.outlook.com (2603:1096:405:aa::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Mon, 11 Aug 2025 12:39:59 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 12:39:59 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] bpf: replace kvfree with kfree for kzalloc memory
Date: Mon, 11 Aug 2025 20:39:49 +0800
Message-Id: <20250811123949.552885-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a9ffb0-e3e7-498f-3748-08ddd8d42f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PUSuuHYbCE63YrmjXCVPytsLjyjAnrYHX8CTCZjMjPBIFAVCp18eab5805fM?=
 =?us-ascii?Q?Eg/QXJHS5y2aC3AdaSe3npgYf6CF3OgmC11POuB0rvdNggMYaH+AURLPF23O?=
 =?us-ascii?Q?JBcJYO5vxYe17z+LmO+biCMchL1HYeOLXtgAkEbrjfUPOjSKUQ0hPmQJUpJX?=
 =?us-ascii?Q?f18SgFSAvngpmzqOwxE1NvbHR7EPisNZIcP0Jrhit+E4jy+++sJoq4gfo+Rr?=
 =?us-ascii?Q?j1DSj5XWndL0lfW8H9EVkDyfNC5uCd18ysDfrEOZol1OqxpS4dAcIb3Xioux?=
 =?us-ascii?Q?M58MzrIK/b+VLbr5BuuzAKzbaylpWrJK2iggP1eHseC79Edm270qL+RN5o1X?=
 =?us-ascii?Q?FdGBH+SccrQdnIHGEGsmd9Af7FMlf1e/ss6CrqiUtoGz2QIiirqBB4LpP3iO?=
 =?us-ascii?Q?bRVZNm5MS4g9cspwtz+l6UY/VarF3CMkO3R1U38GRyNpPliUWuw/7E14+XhF?=
 =?us-ascii?Q?ZtUep9CbdABe+XMJsTEoesKzu7OhTfc03ROAwNmYuZRHbM5Ks5KAXXamDcyd?=
 =?us-ascii?Q?tJyd42Xu9CWR3+V+DgiUQ00h2Y98Fd3KVV5rY6s6FGnDvcwEPa4Dr5yvAnGm?=
 =?us-ascii?Q?CNCr7S3FAUh2yq8vvkces6lzEgmMgcYfIqCupGTmkdU3i9fZpU6LR45qZtn7?=
 =?us-ascii?Q?bNR2BquHspBWpV+fOqdlbFuIrTkcClV6jYW1mQa1Rq28hkzywsvNHUTYgtBE?=
 =?us-ascii?Q?lHvRhQKOwFl534Xj2n5rboahNYi+CCuhXJZsc8Ai8Qotj+LErTE2UMWf2fs7?=
 =?us-ascii?Q?gQ65NI95H3m5xDHNT+b5C6bCx6S5RMHkVZpWqlSqEAwp8j0j5GOlCgJM34Mc?=
 =?us-ascii?Q?HFoIERW75RkFKkaxBpziNeuSiU7zaN1I/L4/K53pRhpxenUeTfJ9F68OQJaJ?=
 =?us-ascii?Q?100kFG0K0MF5x56KzoLuhTRinavKc0JmUJ7jU4abPa9i0FZzydvTSa3GH5VY?=
 =?us-ascii?Q?FHrjKd5xu1EzmZfFzJ7kvHZsK3/7pOGMOR6yYTqRMLXGykkCNC4faxwWW9xY?=
 =?us-ascii?Q?SECfSyEeeWfywmK8OR5QTsv/Df5jf89qhbZe0nwolIbgcctc25HaFRF6jQ8L?=
 =?us-ascii?Q?GH/NbfBBheyY5e33PCsEYFUuo6VKNd4w30rZfSIYHkaZiZHyTZhfuiFYXiDh?=
 =?us-ascii?Q?mF2Dpy6Xkffwasx9ViUyUbHTLR/uqlmCjcUU7AO2JAZiZ+GeEhazCmvB0kSK?=
 =?us-ascii?Q?q27AlTdeGPQo87dIQZ1+XKmOMYis9r3YHWo4quv/x0k5Xie94yT6iEONelk1?=
 =?us-ascii?Q?UxU6GExLpM195L7WtfJa5ytU6rJFke+dU9Xk4apSs4bCWjtc/qVgOoU+2F2D?=
 =?us-ascii?Q?/cHQ0+Qvei36BZ0DsUABuZaCJAs+1BwL9gT/OIYiyX/JoBItsibF6egef23d?=
 =?us-ascii?Q?Kvemzc9nYbFVP2SvXqjS/T7+2s2QeUwXu3w4jEjD/pwhSn8tXMwu0mLnf6XA?=
 =?us-ascii?Q?B/g4KgpdqKk22ImnwH1GKRC7xINlwCB//zZJ8vJjMU9rXLiShKmFNVWjV7zU?=
 =?us-ascii?Q?PPZAwvXljsqKUWg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4mnT0tHdyD6CBUNf6ZDv8b+SETofhDHEGBN/FvP2yaMBElgVRxBcs9QG01c0?=
 =?us-ascii?Q?4WRXE3sRvj4kjY5jWBGxZkx6/meenIwoATuNoVNaAbtvzzPZ3darIA05FIrX?=
 =?us-ascii?Q?vC4UZGnIQ8UJMxgDN8cPfFJy0X+sCBzSwhQYnxTu6ifXMd0eQD4zoT0HlJiW?=
 =?us-ascii?Q?Ld0I5es8SQbk8twCG+wE8AUrvw8W66EeDIm356zaaIX81v9NdKMoslLEq4jW?=
 =?us-ascii?Q?1tfRChECN3Qh+H0+Ioa7G0u+hyJker+0wHicf/fRcg7LM+1WURYJpQsiIwdp?=
 =?us-ascii?Q?hOD9hR/2np7e0tIPa9XgdWIwfTlNVtIPGC3jvF2h/5eV88sD2z5gIhVycSd/?=
 =?us-ascii?Q?rQvO8tDntRfsNMKwOP/PABtdtx367XbOA79s2/g/yBEfKysoT6hn6ZFxl8qm?=
 =?us-ascii?Q?74M/MbDE2NHskeC1jPtImsuA6xu8OYdixE7PjSWXt1RTJW7nLDvyP4Gk1RNd?=
 =?us-ascii?Q?jS+z/6fNoff5IPNhJSmDJfRaJqWI/WcHU6+QGzoa3MEqHmL5xocrAclAmZr9?=
 =?us-ascii?Q?mqVXSYAnUoKuzHHwkJuxw0uxc9wuaMN7nHFHbTx6gakpf+Yhe8Fh8o8vXg7L?=
 =?us-ascii?Q?1MQGfE8nY5TeFDDvzafLE9oLa4FG1fOtTF0uz8Z92o7aiqQSSxS50DtcLh9H?=
 =?us-ascii?Q?p7pWvJtcqI6+QZlDOUeZDx4PLPdmIwaEKR3QVFnCA9KgEhkTH8fzruXIzCiW?=
 =?us-ascii?Q?WceXNYF2P2diYTDwZ5IRf8y5Ru2ROfr8hT3f+86IuaVPBfayDKowqWfLuBkr?=
 =?us-ascii?Q?IVSiIpgUB8hORUH5ttiEmR4kNYDsUsuNape/iez0bmeCR6Bksisk1LXsABIB?=
 =?us-ascii?Q?Dj+9pMn6ECFJ53AIej7AeEMXcy1eVma6jpzZXJXoxyEIUKWFeHSQztHfyzzs?=
 =?us-ascii?Q?2B9OTXW2uZJisZa5XCuuS35rzzr26F1LQz4qh1QOy6FPGH1J+BWU3Kn3O7A3?=
 =?us-ascii?Q?stLxqJnhJEFwimgxt304/1qdTd6IfsPCAKfbfgq5hVKh6laAOfI62xmc0Pdk?=
 =?us-ascii?Q?7bjQyT/eT7zlc+v4wmDvT+0ZfoIU91QNSfYI4GxcqzWDNVmpdbQUsI+KZJSk?=
 =?us-ascii?Q?9Pb+2Kf5ruMURVvrsKbFUg8qaF0rg+PXXqgtvTgwDynae5nly95ZvmCXLvD7?=
 =?us-ascii?Q?TgW5/CranSvKOPRwUI1kfd7v2lkgoTDKPNaMofVmwjPH4tzUN07aejU0R4iv?=
 =?us-ascii?Q?qAC/fQFdkZEegrgx7izaCAGSZ6njxT41uBv6wM5GePZdzDZXjUxaCEiOMdTj?=
 =?us-ascii?Q?7/4KIWIIT7ojQ6sVC8mDm5bPLoHYS51IOKyNiN9hv/48ekPmBiZdaS+EpMZc?=
 =?us-ascii?Q?8WJrCs8Fo4zHWoQfe2J6pWY3A+02L1IptyNzQhZXyYoEoEXfvvMBoEzRTlza?=
 =?us-ascii?Q?4LJr6R5xAzx2wlDDqY/QWfkn/uLSjUQTf6xy6grKRRJw5ahmgNOTAlli3SWT?=
 =?us-ascii?Q?iIPsFnDOsT/sGHrjwFi6O6KyywOS1cyN3u/yWhoNOqkS+qgikVdN6U2JByqr?=
 =?us-ascii?Q?A76tNwh3BvBNQZqmSYL2ppvBb/ssyNOe5aAZubZp/RyikjR1wS3t8x+gmmXG?=
 =?us-ascii?Q?fSwsm51xLJYNjKO3JB05eoqiJLi4ufHzQ+u3+Qih?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a9ffb0-e3e7-498f-3748-08ddd8d42f4f
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:39:59.7306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGpvxx3LTA4nEx8IYc8lvzGaZOLtveHxmjkmYE8HLFsE2dzLdwY00Lb7CvcJgQ5HQs7jpgXTPYgag8Hih8orRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7216

The 'backedge' pointer is allocated with kzalloc(), which returns
physically contiguous memory. Using kvfree() to deallocate such
memory is functionally safe but semantically incorrect.

Replace kvfree() with kfree() to avoid unnecessary is_vmalloc_addr()
check in kvfree().

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c4f69a9e9af6..4e5de1ff7e30 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19553,7 +19553,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				err = err ?: add_scc_backedge(env, &sl->state, backedge);
 				if (err) {
 					free_verifier_state(&backedge->state, false);
-					kvfree(backedge);
+					kfree(backedge);
 					return err;
 				}
 			}
-- 
2.34.1


