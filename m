Return-Path: <bpf+bounces-37679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEE99596CC
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 10:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C987283113
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 08:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0257D19993F;
	Wed, 21 Aug 2024 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="josjcw5y"
X-Original-To: bpf@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2061.outbound.protection.outlook.com [40.107.215.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB411BAED4;
	Wed, 21 Aug 2024 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228117; cv=fail; b=nJaQCkgwfqd9lbV708KJfhypVyWk7lHZwunAgH0KAUrry0h6ARTFfMwk9+kYbKgww4qQwguP5+0yG2NJNrCQr3jquac3DCGd9Vo60Qr8O3bXksnwh9dQcMU+rx0fgt/eO5j5BAfBdl9YWWxhN2esUtLQq2i2sX6jwSTVwyciHHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228117; c=relaxed/simple;
	bh=VPNHJhMJ4kBlNlTrukvHo8/r7tJdFewvsR15f3PkISo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=q5U7a55aTYvnB7c7kDmdE6vS+D7sIwvjit/fotsGz1eQ5VfwBm1bp+E1OojUl03PAsQEC8BCYrC10TJKmw+mUG5N6jkCK+E097ZzDVEAX8EbVrp/jAL+UfOiI9eZWPaNiY08glwKd0B/wtpaz1acLkdR2sFcJdyGgFalP7du7ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=josjcw5y; arc=fail smtp.client-ip=40.107.215.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CB5PJwXPxYST/a37vUgxHH31dgnF2jgx7H09nn7CgQR7a7jjsLShd93jOpS1u00r8P0EJpTq1c9wnGj/NrCbAw4kxY2af7Y5Q9Rmio/IN6bFvELZXY4KiZ0hWwi8eEAzRs2hOF7jPB3W2NI2i3kCfuSShu9m2olytbnzvWlc0lBNLTcWassZtHrqJGnYkzPDDU7CLPLKrBjAGar5YIYaIPDXsz14/N9YGvB9MZK2iqF85RBNFTUAwLMhzipdWTxC3e4OJZz1I0LZqvOxFyH7pqOWL/c7vtCIwLYC/AQhXMoTxrPy7jHoak1gQGIiA4Jw4nZh6EOxbjPYUNWhlTLH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXhtocv/kKVIkADhF/Srdj2iArKT2BJoZ3djwagxoJw=;
 b=IeSGF/fd9V5hhRh74/S7kZlxelxGQu/xb/FpI5hqy/uj3XQMSsY//A4FP3T1gd8cK2heKePHam5pQuWAMObnM/Ljsi/41m7zGGx23MYkqQuDIodLv6CReWNpmuGlsfrlf/y9s7t6MY/b/MXjMIDOcoRT7UF7toSICgZzKnJTi1CQiwk4MAjNKNOO4YrnLmhc7yE1DHqFBBPKhzjgHCIvL4n/6UG7ac7H256gX9/F3JKZiD5soKt0WCRf0tQOHHQc7ne/OQF0aT3tZYQhoY6Ie9Ph3EpzreZrxlyJEaBLKamFNiHn17ipHyPcaZlwbgsYUY5K45W0Zx2RNsg1tFHhpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXhtocv/kKVIkADhF/Srdj2iArKT2BJoZ3djwagxoJw=;
 b=josjcw5youlUbgMwoCuZiG/bM1nzxzP7OY+WW7BmgPzKYeTh5Sh64Gc2PaWQjHtTGH61a5CFMIDGFVI9E1OuS9L37unDaSDdiVBvlPpQpi8bqcW6hXghXqc3mWfTPmNpfsEWjmTp3MHDbIbXNjIxwFXO1cFcenq8MnG5MD/aGtHzpBM/1hUtE724aMFK/B8z0KB2QKpxYXCiGoJMimiCyJVvAv4NLv18Vk16dKPCcqTH4f7QrNOwNdg9UZ656LwEEhrE12zyxyoTGFKjb8IIxBg/bMU0YlGyu+MJa95Njb1clnxVQgg06TYVqCPyYj676tXb0Ib0orFl0oB0BjFMuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by TYZPR06MB7144.apcprd06.prod.outlook.com (2603:1096:405:b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Wed, 21 Aug
 2024 08:15:10 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%6]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 08:15:10 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Louis Peens <louis.peens@corigine.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org,
	oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] nfp: bpf: Use kmemdup_array instead of kmemdup for multiple allocation
Date: Wed, 21 Aug 2024 16:14:45 +0800
Message-Id: <20240821081447.12430-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|TYZPR06MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: 4377fcb3-b796-455b-d306-08dcc1b95fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SlOC8XrhUGt0t5cJaIvgShzKl3ckm5SpT0v+0XzRIugdJRUE+t6tR4eAVt1n?=
 =?us-ascii?Q?eVU9P7YxkwaMzCigywGMDfmq0gB2bS00qaVhXJ4oSMYZ9aouh1pRk+nXeZr/?=
 =?us-ascii?Q?38vzvzEz4HqryS1icNznfGrwRPidnKu8c4DmP1h3uvXxgZtrG4YaGBSwqQVD?=
 =?us-ascii?Q?yxyQCRQOeLLCj3bsgoq/ogA2f7z6prAYebxrq62DFehAjH2NKYODy6Q3WHVR?=
 =?us-ascii?Q?69VmA0eh1rFgte4jxUg4ZrI49Q+xVp/1C1cyDcmcjMcOzjxYNYDyShjex7+9?=
 =?us-ascii?Q?ZReDMu843efsCpkL0IjDYonje9H6C47Bcl8jyUuNuX0JQfIarMnA0KV3gXH9?=
 =?us-ascii?Q?P8wwCcVK7xZvtz3u1O5MXxnUe4NdgMAdjcOo+BQpT/9FoQudCoIQBN90ex46?=
 =?us-ascii?Q?prDgtPB7L90gfIQWTiB3qeEzKjvTl2OoHzgAUABAaVIZPrfcN5LX4H9fMR+9?=
 =?us-ascii?Q?YS7BDlq6fTt8nowpzb6W5hDrmqgLNDApH7DRUzioZeLV5uxWZMtvUs0hAbdf?=
 =?us-ascii?Q?yrZ3wzTHRHDmEuOO2wF/TLlKW2rWODmKYCUCg18zCUgCyZP3LooSPNKtGIAM?=
 =?us-ascii?Q?pVrgbBviHyxcdBfSYfqq8b9rUvj4BloGNCC48/O4zGD9uT/oAQaXmTL4d8op?=
 =?us-ascii?Q?zFgWcxH7IBI6qEE1WvQpVx8kLHfLnzDfhgSJApy3KXCkTVkK6nIDphFNgxIp?=
 =?us-ascii?Q?cdq6aT/r1OG4xQn1wU8aZdjo7VVWYY0fKyew6+YYCfD+ysrg4vUOyZchPgnZ?=
 =?us-ascii?Q?vgaw3dx0KG26TF+IyAOqfA+g09b4GrEpxSwlwBfwlrVZ08qQH02bnRBwWkF8?=
 =?us-ascii?Q?P8tTK2vWjH+D7tdvaEGi+K+nRHg3AH6Mx4hRJQ++AjGLg4R6k/VIsWDoPfUR?=
 =?us-ascii?Q?GD3qPj33AxKBQox/uk4S42R18KSzO60i9qI/CqA3rN11/hWEGglEFVbvNVGG?=
 =?us-ascii?Q?Csc7pnzYUekDE8BR6KEWUguRnxade9cDw25m5f7Y0JyzbJAvKw6LWcftHwCH?=
 =?us-ascii?Q?jbfLpCSfZSfbQRV7xNrzrEK0CqZj8trQVyN+onjJddz6j0s5xTtBjx2YeVlB?=
 =?us-ascii?Q?ktD4OmwMK5CuGwWKVUufeEzZ8f4yZrc+VfmI5TOFiZT2QWX5jN7nLq1xR0gw?=
 =?us-ascii?Q?yFiWDEYr7IvqYwTirMAYLaFX4JG5REigg3Uu6sZp63tk3PdDNBj/7qATcmb7?=
 =?us-ascii?Q?tI+nCPTTYxNKnIoKzf0r/A+OQAYA6kGz+L3eatlf2sp3HwWOVDnBaSPGLm1b?=
 =?us-ascii?Q?tXu2Rn7MWGUB9Km3w//X/g/ty5blvy1fPkMBadwy/Mz2O3CDFIATg+xsdpYF?=
 =?us-ascii?Q?tFYlMyJ9GU8HymHZ8Eh4XoH0QOuT2sKX4LLurgWVXBhfLv0/EtCIZFs1j3jp?=
 =?us-ascii?Q?VwzOvJj8LGpSWHICnldsUvt51s/kNhU9/eqokyksmS3FlOuXUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y8Ebda9nBc4JkFauFxgxuFRIThW7J/EB9Mx2+tF8rDE+9updItHgY++Nl0Bz?=
 =?us-ascii?Q?Gi9pMUvc2RTdwomWPlOVuNRyfIIPfeace6tcig20DCulUmdvR0IynCCmQC+I?=
 =?us-ascii?Q?LQayF7Ob4fR8farFyspFCWjP+fkcMxRMXqk6cl5Dr3bq7vzKxTl8aWCvYhVe?=
 =?us-ascii?Q?BMe9urkc/3fvquZ/cDD8mIhLucUE9/oW7cCIziAEb/4QZvfLwW9rWdI/hk0s?=
 =?us-ascii?Q?608+QI/CoWI3k3iZOiwO7C59+6CmwA7f4cqg10LJ9vn4kN6u6NHF19h1gOuE?=
 =?us-ascii?Q?y6NiMDkZ5SWJuMBPiAmqEAYlKfvHT1ac5zmvmgJrhFGrUoKtgilZwLexzjFM?=
 =?us-ascii?Q?u1i1tYhoO5CHV+0MM+9oaq0KDb50P8Rv28EVUOmR/zIyEQlL8gxNX2tngIMf?=
 =?us-ascii?Q?miH1WsGyfDjyYhw07GIZxoZFoLHxDr6NUOS7ttz32EKnLHQeNHDiV4JfUrbq?=
 =?us-ascii?Q?36WIPDlAh72BzO1kdoc/h6TicRXhTID6bUeSC90DCxfeppivtgHVUxaq8Cgc?=
 =?us-ascii?Q?HfK+ffpIOxb69+BZEDH7HaeKjBGRr0YroaRhujB6fGtkAkYll2lsJleRiurF?=
 =?us-ascii?Q?KhjhTTIJWk1djN3g/hMOklGsMlNKW6bPpKznu6Qsb5ATjoan6I02TjEyPwh0?=
 =?us-ascii?Q?vZOFs00xbbbscUn4KD3Oznh456Zaxe0H3XStZpAWqIeOkV4QiYPKFVmZMW3c?=
 =?us-ascii?Q?flu1j2v2tUlK4MT+i9m6P71Wo7mf+kCs8zEi/4k0dbCFhoWCKoqPVWAER3Mn?=
 =?us-ascii?Q?X94p89BLr1FvRbsqknJ5x5b8+66P/htRlubqqUlt2ub9EtZcRzkn7x5mPyHb?=
 =?us-ascii?Q?LNdjc19NPenizfw1PIK6P/DX5WYoik4rBJMvSZQFWNXcHfvnHXxX/Fddp2cB?=
 =?us-ascii?Q?Heq3LtKRHJpdWsQPicKtBrf72p3obBDVoAvfykR7PqVi2/cpdPpM6UsnHMzi?=
 =?us-ascii?Q?+WGMbpuaXugNUjU5x/UQpHGl2F0vMSNW3Z7V3IHlCAV852mKqw6uRGdrtMNW?=
 =?us-ascii?Q?NuoofKxZgiHMcVw0Ju0cOnMYICEo5viXFhl6x2+CWsfllXIkCawBvFh9Bzth?=
 =?us-ascii?Q?ehYk1KNLfBM5/UtyohK4XvzAMQHQEODRKY/42IzTH15xrDxsBI9vZghdAlgN?=
 =?us-ascii?Q?kYGGYu1EJd+pDWvbgiU1qutnPs5rXlenyGRLigXZtxJRZZIgzdiIXc2TQfZy?=
 =?us-ascii?Q?BKrF5sK84TZnyWMsOV5FfVeG52p5bQQ5OzNPykvOYHZss71gPgqkIhYJGJoO?=
 =?us-ascii?Q?TjcYa035mXoxMSahbZmH4rc8oQ4k3Md/uiy8BbTFeAclAvcdjavA5k8cdyAT?=
 =?us-ascii?Q?CY2MQBT5XnJZ3VT2wSX52EIlQZkWhdLhUqQTrh2PBDzpJhb9Wb6vm/IbEoKg?=
 =?us-ascii?Q?ksdtjOrQH9eU8+3ipJzUb6+IoN2aG9F5Md6bjKuZgqmNbJZ4hzASc9fuAULl?=
 =?us-ascii?Q?A8wCFY8/XHXqK2MTZbOIp7U13TN0O0Ba0NYR9DFNt63eGtNW9AiNT4lh1q83?=
 =?us-ascii?Q?lTivg2IyTa3dGQXja2aLoMUqSxt3ADQrFpsGpSTSVXIY0WPvkVckl2tNJ3WI?=
 =?us-ascii?Q?/0mmhNU9jlBlIKavSpPtJ7NRAYgb6x2COouckGjy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4377fcb3-b796-455b-d306-08dcc1b95fd8
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 08:15:10.2793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFzkItooPwjtRjwrOyRaqsYATpOI31nfT6a0fwGqNsUlpsO2K24mfFmMLjAMFypljTGnfm2GJ8DXH1CT+TQrhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7144

Let the kememdup_array() take care about multiplication and possible
overflows.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 drivers/net/ethernet/netronome/nfp/bpf/jit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/bpf/jit.c b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
index df2ab5cbd49b..3a02eef58cc6 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/jit.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
@@ -4537,8 +4537,8 @@ void *nfp_bpf_relo_for_vnic(struct nfp_prog *nfp_prog, struct nfp_bpf_vnic *bv)
 	u64 *prog;
 	int err;
 
-	prog = kmemdup(nfp_prog->prog, nfp_prog->prog_len * sizeof(u64),
-		       GFP_KERNEL);
+	prog = kmemdup_array(nfp_prog->prog, nfp_prog->prog_len, sizeof(u64),
+			     GFP_KERNEL);
 	if (!prog)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.34.1


