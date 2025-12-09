Return-Path: <bpf+bounces-76368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 821CECB01F7
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 14:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B5AD3099D06
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 13:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABC2285C96;
	Tue,  9 Dec 2025 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="arMAkxbm"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0F626ED45;
	Tue,  9 Dec 2025 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288437; cv=fail; b=swI8nwJ6lG7OBWuYbR1Ir54cD3LHEihdp8j3yFNyAL6NQYTrA7ojmSz7UQ2tWNvzaWA9EL+56yMGL0Zb8toAQk7wQiwDX64qhoIqfcnPg/Zns/Q9x317eD2jLkyVtTyh6G+ZWkj18jJoe9TYZikO0/N4HHGp/5cSQ+dHaFQ+f5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288437; c=relaxed/simple;
	bh=kvlWWomwFj1rfrnnY6rB9vGNHMqyRvcNPTqfrHfiXKs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ujoJlvjj89PPHSkJbTUnI5Pa7Uh0mpEMpy/tjeXNsiClTw69MmnOq7oeNUT13YavMZ5o0AJT59lp41HW/y5ConyT0qEO8wMiGkdnNKjMueJua5XCwkskzRxgZnoWyJyyYhdQyVVZhCmgOCAEgxRp0fKUnX/OS69e/TtFjWuV+pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=arMAkxbm; arc=fail smtp.client-ip=52.101.69.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdUiqaeEfx1dPxRI14A4/d6F0IRmlcho4B8N2HXMA5YI576Vnl6Qx3dKNG3DlKepsfcKmU0hH/opWVuqfTgfZGszfYLgzyD0Nki55ibmJ0E4qB8cMv6FLr864gHWuUNbS+M2d786DMuuN6GJxS1Xf7b0y34GrziZQqFxf1qOYyPU22hjIE9gpG8DxnKXxGtbQe1J2+MSf/thBkD2a/Krq+B+xgfhTzisslqQSWING55FRC3NcFlXXykJFkWwY4c/xqjyBsoB9MRNqZ+S3uACUn7wPRrXVCAK4kD1M1PXdsi+dVX44mKftZkZe5OkpScV5QcTDwfYRgOGlDcbcpFbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cDtWJyvq4yxs9ogszWxCwA2S9FuQlfjeSd93SNyUpA=;
 b=HM6Ex2AzJoCoeVaqchilTT6Q+2MaE9YVkOnXtypXrgRLdj1wVfZoRA0abByXFZ13Tbj6voxxSFRIrCNHx0ssYnHedWRQ6VdvjCLfxyRDEOcX+EjPcFdVy4+cJYMlLfXfE0IAJvKZrXIXAwEjmQSAAQmJXrcuUgnnPFy7o13Pmx3vDh4TeHfI6z7BTrH/2+Q4XNBcX/YIF71DFGivtk2rOU/psyuCiG0n4BV2Muj7qfFsSL+SFUlBdIBYZg3dDlO81xc3ygt2iJsQwjx5Z26aJMzek3VRrpQpl1A4Mi2PSG2da924JggrJV2WZGx9lpJhlPHGCFPvR99lzXe7WyYdyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cDtWJyvq4yxs9ogszWxCwA2S9FuQlfjeSd93SNyUpA=;
 b=arMAkxbmTJ7GX6z/OqCROU8niymzqJ3/9U5OMAbnWqCGvlnAy85jLjKvrveemOm4yYTMJM6iejXHqsoNl7uZOQv2kfLYyPxgsHOhNwOe4d6JdZXwXW74+kTL/+BTe/vUrGvhwT4Jn21RAT3uS2gu4ISU860wSnvrQtN7UdQEktOXti75msE8eJChcSjEQsOeIuXMSc5xsUK/JUIl89ITJfx4tYZv/+y7heI035WClY/ToqEPD7T0CvyvwsUgdtsJ1+pVKK2VUlAPADwOQLhSehjkvhj8GBG7MtcIfFLbz1roT3OIU/sBPsjYnOIGq+aTFn02Ak1yiFu9NCzZK/ucrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8747.eurprd04.prod.outlook.com (2603:10a6:20b:408::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 13:53:49 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 13:53:49 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 net] net: enetc: do not transmit redirected XDP frames when the link is down
Date: Tue,  9 Dec 2025 21:54:45 +0800
Message-Id: <20251209135445.3443732-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: 149b9e37-6324-4dc2-6bea-08de372a6118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JWJO2ovvdtV2loMqPRJVf4APGP7T1skHf52ElNAUQwLocSd8CTdRxHOWavuJ?=
 =?us-ascii?Q?EPwMKOgaiSGTfSIcSCzDIoKPCwKqZGWCmjBralctciMw0fvm9aeKwtdjCJoj?=
 =?us-ascii?Q?uitrOXsuQJzpVxcoKv9FP3PP5UOjx75rKR606Zr6G8JNM86SsxrAElMXGJ6a?=
 =?us-ascii?Q?tIYP2iIceaxqdWAlSogpsAg4M1wRHia/AyKym6EJqX8Xus3AdoR0Rq5iyGs4?=
 =?us-ascii?Q?Z6hbPBPVWP8v8z2L04lWpYPvbR98qrliTc2MO5mpTwgU+etdPmsf2CKIFjPs?=
 =?us-ascii?Q?UrrEQamhHGFIGEdRPVXDRgZNjW+gEqUnYxy/i3m0Bzneam4J8r2QYKkOd/+d?=
 =?us-ascii?Q?qn0K3xFBa8I9IZyPjWEZLgVrEnKIfhkJb/sV0PEZWxwpVc9WkJYqqWYh0D0B?=
 =?us-ascii?Q?+nCnhQs6lAGp/3pGwWqONIr2gf6lrl4w1oazMRHD+7BWl8JnvxNxgv0BzUL8?=
 =?us-ascii?Q?5oOozhnJ9Gh0YFRiImOEl5isDoM0czzGAHmC+a6axbWwcel9XjmOLtZ6OLub?=
 =?us-ascii?Q?eM4p8cRCZM/d+uIZAt3a+BKcE2ubhRBEeboyC0XGPW2UjMY9Zio3KjehcPbB?=
 =?us-ascii?Q?5miBH1+Re8gceu74L00Al37LXCWcU744d09ExE2QqWbKnXMcvl0MTcHkTCYF?=
 =?us-ascii?Q?As+QWZYNQE/QXd2U3+JQMeXhSfPMW5uRO0n55d1wJv21eStnjThFXWCA8WfE?=
 =?us-ascii?Q?7WukTdQ06GDiMztvvGMyhkEYk5Is46xyEZipI3tq8vdknOqbAulqxUO7PuQ0?=
 =?us-ascii?Q?SCqoIPhKY/EZLwOG/VZ/dRp2g2fBE9NThVcDu/CpwtmZh8ymZFbAgt/qBkb+?=
 =?us-ascii?Q?wCDK4EZW8QG4CwIOviMgLkmz2bZ0L9a/c3uFBIz3MlbuY8xRVeS5ZlkCDH96?=
 =?us-ascii?Q?vdu6WLXTGKsyIjZ+3Bxq6pVgKc7n4W2zllM698X6SCLnkxoxBKxN2MVQbkkj?=
 =?us-ascii?Q?AbzRvuxoqN5zCtDC6SUhZJAEeAkCt2WqlkRP0uPmZaoo46ooJ2c5Z/niaxDY?=
 =?us-ascii?Q?kzbewcE3pQrx7aWRgWBMInNMGIRAGtqMcGlbGgM/NNjqZbMu3M/84eIITrZJ?=
 =?us-ascii?Q?KxsjDuyO8eZqXSkF0SCIs0xbutdbAoVnprZXuisUJGsUn/+Yq7K9tmIrcJkq?=
 =?us-ascii?Q?EUy6R4z1uvVRznja6Wj29C7mQ6/sZazqQASdaC+ya7QE32j3EoFauB5BfTtQ?=
 =?us-ascii?Q?amfqKkHSTfxMMqS8b3jTvCH6jb1LPWfRjRsNhQPm+s9U81zd/FzBpImwAgyO?=
 =?us-ascii?Q?2gFYVkFPyFuvtrQhHv7OOqk58J8o9b56Hx0QszmEe4Ywo/Mfq/m/sjr9gRG2?=
 =?us-ascii?Q?tJEBfYeuazzSAm1Z/9qZvpKtCB/ukCMMHPSLhhOhSSuCltNIeJ7DckqEeIN8?=
 =?us-ascii?Q?P6It5w2O10FDbui6jenOADl7XwgTER5rT/xH3e1CFbVVxQoiDfVkeM6DFFu5?=
 =?us-ascii?Q?njlKIZfRhWoTSj/QgiJUC4/SqaQPKLycnmJgLysRLe1FM9aZpk7sxBUjaJ7z?=
 =?us-ascii?Q?rvFGqWtAB4efxfe9WH35ZTrr27RKt1If5ORYybuD9Gyf/kdAq83g1M3RYQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CcyO7ZstRNiPtfWY08f+C7PgUOa25pXQuNCwzbT2zy6U5daR3wFmlf2l+s3W?=
 =?us-ascii?Q?B2PHlAnf5rYeJ9o2/KvWig23ZRIBMpRlGvaFeN7k9k7fMOB8rRGXbrgTcelk?=
 =?us-ascii?Q?cP3FWfHKjQTdNSi8EavlA5RIbmiPqjuhiZmI4hR1h5CLNT2GCj0eX09PxCMX?=
 =?us-ascii?Q?+5hcjmMF4Yh/sgC1McQE+AzRdN6BJ+s9kJ+K0i7ZsE5h0DoSUsPZh8DSWFJU?=
 =?us-ascii?Q?fLhuiAVrCNd7v6cLyo6juIrU95RWFNMoE1cwF2SOiJ1ZP1vs9aEt757RidzA?=
 =?us-ascii?Q?CGSr42zbph8Hul81FW9ow2665MR2KSupMCRgDJ06q6WEDKpex3uQqISTjx5g?=
 =?us-ascii?Q?x4VH8y68J6TrnQMkN4ud5jPpgG08TfC4Ka6HKsdkW60OdTC06pUfWcIJ+YCr?=
 =?us-ascii?Q?GS/WGCgQAXw2BI5+jcPRksapVARVu7lLsKJoBQYzJoceRTOHo4hMdiVSE+hs?=
 =?us-ascii?Q?YRFEuQumt9E8VT3t1ecL8U+8y95cZ4ipKjxAIJsBbQwqJZactdhC67aloKdE?=
 =?us-ascii?Q?+dH1wjddC0SfTiVS/0FoQEW+EaNPl3KMKVbqIqPvMvhyVeC4a/B/cfaoPRr5?=
 =?us-ascii?Q?RxWfyPj7TqvKVmCllJhiDINtvHd0mYy5o3kdlCb2uvtVt/d+SbJTFlJD7cTP?=
 =?us-ascii?Q?X2qOxXclPGsfhb+kvAiygZPmfx3QpJWsZMj9R9e1dSMRbAA0aXwoOuLrK6Yy?=
 =?us-ascii?Q?ZQ1NwWIB3KLQb2liQplRu2h6E7gFq6d1/91zcPg44lLKN/Kbad7QmbRm0iAG?=
 =?us-ascii?Q?MSY4JewPYIKJLVqSXZp7GKJNOD10XsHCOEjCyJkmaREEz4jEIX5rAkaC4qkQ?=
 =?us-ascii?Q?KHf74+DrTyktzj/QRH3OMkaFOapb6ZhoG07fOeOjb9aPmVdSBAifZih9zY5D?=
 =?us-ascii?Q?B5AoJPfrJeWCKqIEOqkOLi1Jjr8RQTeNeSbXtH5Ycpaxy5JBGbRVYc4Ubz+r?=
 =?us-ascii?Q?84YNYiuk4JneBKZ1rgvIAk2vbAsFy0+4O8UD0ZnFuHeAP3OSYd7nmKEKMtp6?=
 =?us-ascii?Q?h7BbfQw421M3aDx9VOr7RMcKRaoSi63niumux5Y3RrrWcp1Snt+yMXptokBH?=
 =?us-ascii?Q?/rCpTkWdg3XUFRB5F63MkbFa5LagrcEM7EG58k/Pj34OMyK7HWXqFOrY8/iE?=
 =?us-ascii?Q?vqTPIpf29h12PJgkgkExruZAfQvk93wdbakQyT2rCU+jd4NQZ+lzyv5KPDeM?=
 =?us-ascii?Q?2WTyuibIZr3ZwJNkbqWQnA4UR4+tI/QbEjuVdbqvcX/tWMuANR6TdTKtaF2D?=
 =?us-ascii?Q?KsSkfCLgl4g/Dmf2WISB46GhVdOTkY5V3KQLajkDN6jlPeFCajWGBwgiZxzN?=
 =?us-ascii?Q?NboYXiMGDZi3e3VEXKYvLQR/vT+qX2KhTnfabvKAZ3XO+5Hi78ITB4s9BErR?=
 =?us-ascii?Q?hwYY6bw3e1xcKMYvRdwO9F0ErU38lffvQcHiIk/QLhXbNWS2yKH/2FULpefX?=
 =?us-ascii?Q?+rNQc6jRvVpcaTiOL7eQZc6z7ZgbTvJyFJwMy5bsWqsGwTFwDrlXLtpuv30v?=
 =?us-ascii?Q?IH1uY5nj3nprB71iOrBmSR9YcU1mDyVWA9NTvssDQLwc1nQialCQ9u0zpF4X?=
 =?us-ascii?Q?M0DmrUkHYplv76dGFET7517qaZiJorrOzO2fRcJn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149b9e37-6324-4dc2-6bea-08de372a6118
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 13:53:49.5096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ddkvPiwCowNIpV2AYKLwQbJFWgqKtUAOvvo/ZzVcXVec6t2a9jV4kBO//PF6mWJ9CIjpYEvVKfejcjXTTroog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8747

In the current implementation, the enetc_xdp_xmit() always transmits
redirected XDP frames even if the link is down, but the frames cannot
be transmitted from TX BD rings when the link is down, so the frames
are still kept in the TX BD rings. If the XDP program is uninstalled,
users will see the following warning logs.

fsl_enetc 0000:00:00.0 eno0: timeout for tx ring #6 clear

More worse, the TX BD ring cannot work properly anymore, because the
HW PIR and CIR are not equal after the re-initialization of the TX
BD ring. At this point, the BDs between CIR and PIR are invalid,
which will cause a hardware malfunction.

Another reason is that there is internal context in the ring prefetch
logic that will retain the state from the first incarnation of the ring
and continue prefetching from the stale location when we re-initialize
the ring. The internal context is only reset by an FLR. That is to say,
for LS1028A ENETC, software cannot set the HW CIR and PIR when
initializing the TX BD ring.

I see no reasons to transmit the redirected XDP frames when the link
is down, so add a link status check to quickly fix this issue. However,
this solution does not completely solve the problem, for example, if
the link is broken during transmission and the TX BD ring still has
unsent frames. I think this requires another patch to address this
situation, but it will not conflict with the current solution and can
coexist.

Fixes: 9d2b68cc108d ("net: enetc: add support for XDP_REDIRECT")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 chages:
Improve the commit message
v1: https://lore.kernel.org/imx/20251205105307.2756994-1-wei.fang@nxp.com/
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 0535e92404e3..f410c245ea91 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1778,7 +1778,8 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 	int xdp_tx_bd_cnt, i, k;
 	int xdp_tx_frm_cnt = 0;
 
-	if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags)))
+	if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags) ||
+		     !netif_carrier_ok(ndev)))
 		return -ENETDOWN;
 
 	enetc_lock_mdio();
-- 
2.34.1


