Return-Path: <bpf+bounces-79205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C4DD2D682
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7143B30DA633
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F4833469D;
	Fri, 16 Jan 2026 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XVnZdi4I"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBC931AABC;
	Fri, 16 Jan 2026 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549288; cv=fail; b=Ucj8n/XqqsrM0e/x1Xdniz3dijFZWeXnrdArzWg1md+dPLIQB9lHU/ZYQTeKykb9aebE2VRtw3gqbKz8KT+ca0C3Xbw4MVZf17dnaCPr5XyBGdkAuc8qL8mbhZdGw5/mWxX0dM/WSIeoWrkPshx2oR/3PePkHKMhVJ9NRHNaiM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549288; c=relaxed/simple;
	bh=++5BwbXI6gsLka6qAUzrvbfIDIWhlLfuMOnODDgcGVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IvsGGLXeMEjdxXSsbB2d8nN7eYNTSLf29kPft6phqm/Ki+5MEaqdch+XMPC0MxNMLGbRozwaEs9YMRxT0rEUqt59GPJpZJPSN3ARRIFZw4XfMThWRhDddzbFppQK2Yog2vwNT4r6hi1oL6uhzsmA+qOkrILRY7UsHRTei/gZ1EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XVnZdi4I; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lL9yIxkPFAe/cQ8U1sR+9ln7M7bO0DkYqBiCfennYEk9ZAJfmSnWTM0EMRXT3yRONolK5Costu/KoYaVOg1rDOgsiYdSAMbjYN5oowCEtXUTHvWa4io0gstlBnL5bubP+0B1VGQqKokqEWeT1Lpsm3d6/nGufxwhqV7eq4c2XzltJbs1IfJ5Eq3UPWOsS7GZtj59xFrGu3SUbRKeksyb6cw8C0FSysscTG2jKmYyuYdiILoDyvp7tPiX303ArsaZfR0GicA+GXqkzNggO8df+hcIMRzoTcJjYudC4TpAHA3Tu738PMQlrzBFmQ9xD9//TSHdtozvdSmTPwFhe5WCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BkCGt8PQsr6pzPjEl54Zc8fTuQCm8RmbczY/wHYp68=;
 b=b+GahxhmVUOr4NxxHW3Mf3kQiOuZQf2u/nQLcXhnx36tXUdGfGkn1qB2Sij8K1JQaJdaqNI6lAI4X/3O4MPV1ozNc3cnrrnl4OuP/VUC34fQAC3yWXzbqE2NPSCEYzaS4ND5BWqBrf+bIPHe+DWDQplnVabiqaFBWkykc1mrAL7zUNXwajYbPAH6bnGVNelBV+4KWy06B0K+z6CVp8TH1XUmNsyTegJ+GqHel7h2WLZKfnz7t1aAbSuntDQYPCOjITWFroV+MdMkDkLH0qlk0mU+cN3OqhseRin8JoN6/8ThrMoVL82ssIeCqvsp/lvIAKsuYx7od+qqYlGPfiytQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BkCGt8PQsr6pzPjEl54Zc8fTuQCm8RmbczY/wHYp68=;
 b=XVnZdi4IxfO0/NaFac+5qdkL/19g/j6L47qtjvXG0HVkW2BJBjUl6NnH4d4IuEh5P8VpoMM2g5Dva8ulYqvW+2SYGhz9fIo+K25IA5P3pwA9Lo6nuJx8vAZ7gHYCqaGOcTG3qVIiJt7p0KSjpKtZE+VgifTCkXr+miDODJsi/RX2Jrig2qbfuRqbC8aF5VrNnddg5By0pQelyZcW/KY7YxTlAy4Ioc6zYiLe2eq2VsyV+/qKmkOIvdYXAVOzgoeDa1bSEJc7LJ8PH+Esavwy3+BFDW3rSbpcFLyWCwrQEoHsmOZnrXlYGh7TkHUWzNmlpQyRmeRwxQQt3Jhu5SB8oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7390.eurprd04.prod.outlook.com (2603:10a6:800:1aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 07:41:17 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 16 Jan 2026
 07:41:17 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
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
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v2 net-next 02/14] net: fec: add fec_rx_error_check() to check RX errors
Date: Fri, 16 Jan 2026 15:40:15 +0800
Message-Id: <20260116074027.1603841-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116074027.1603841-1-wei.fang@nxp.com>
References: <20260116074027.1603841-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VE1PR04MB7390:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d7e345-baf1-4b9c-d419-08de54d2a25a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|1800799024|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b46f4PZ0Mkc9yNk0PFZkT3L3sa4B6VxT5nN5zlKyaLZc4+Smnqg0U4bZvUvH?=
 =?us-ascii?Q?nMKM2mrZ5ufMzCetMM9+dv6gBZUovaVLKp+3YGzNAS0uxy5Lnm5HVjLOI4mN?=
 =?us-ascii?Q?aAK9QKx99+dm8VOR8cu6y6QbwM+Zd4O6wnT3rTlAadhx20qd0yXCYjy4LRJS?=
 =?us-ascii?Q?b52He7h4yGE+8/F7i7xpCNTyhlI6cycKtgwuv75hD8EvMfxMupgfysltI+mJ?=
 =?us-ascii?Q?M7xy/SEtUMJe3LYdY7cdQ73UfH7WZc26cFjKeH4LHOK0iXoRYU2TYDYeKyDc?=
 =?us-ascii?Q?k0awT/QUxvMbNEIpd7rJRGOuGVnaMM/72ghcl11XsI+oJXp2NGou54YXwvhn?=
 =?us-ascii?Q?RtbmbobQ2RvHBfoa4E/gI4+nu9aveMopcrnq9tamScdPoosTebBtSxTQ1tBb?=
 =?us-ascii?Q?DytB68jjXUXZqom9HVTz7TEWCtbh7PwYACE4k0RrPla/E5s8yZd4hbUfyFCi?=
 =?us-ascii?Q?ia4zPWPJW2E+n/RKyXjTnIz/GBlIwRQqS5MG50VDknMZAloMEnc18TwlJUst?=
 =?us-ascii?Q?6qBhZL7nyZLWSzh2vbDwyjtiiYXXB2Ff+8nD5RfqyQcQJj3nMQNvPSsTt8/j?=
 =?us-ascii?Q?9sSSoJpHuF8RP4mqYcGgZ/ysyb4rDgDYbYEI9bwuw/0+Yjpch8LBJD/08XnG?=
 =?us-ascii?Q?em/fTUZe+w1LBNle7MdBt87Ccr/lqtF/j79ZLlvS99YjzeJX3VhGEvfIKN6b?=
 =?us-ascii?Q?Y1X9yloyintPWcYLc+Fc5WHetWSHGgdvWTgFt2seMlbhf6ukZ385hO7fStWS?=
 =?us-ascii?Q?1UCIUBmRI9dMEtrV7UYzbUYGJZB5GkTiRvGQw5FYBemjRCIu2hapbzIbSWKt?=
 =?us-ascii?Q?6CaAIVrVNe9NLI9Vr0rtmzuQNvhOspjEwFx88SDi2uPpzddZ1ERO8FijHfMJ?=
 =?us-ascii?Q?owOhvsrI60iKTFjLMZQHtNDC10KgHlKFBGeT7W41dse2C1DKYUUNPxvdH86X?=
 =?us-ascii?Q?qdyrdVBVYeej5jTRbo2MFXrbdjUtr2jfnTCz03hQ9V3pW3+PkWCn4MLZ+/QI?=
 =?us-ascii?Q?I/gocYJw6gDWca84Tu31syXicL9aWbdjWXE211SKxtMMtqNfgxR58GVgPKeu?=
 =?us-ascii?Q?5NuSMs9HJ9qtJ5DNlcRrQywk7qenyAlXLzojRxt6haOLsN+KlnpUz0V3PEmc?=
 =?us-ascii?Q?YhjMKC71y0V+v1xRO9urchq/IKphCIXB3zTNOUrod+CbfzKdNlPA/ty+MQam?=
 =?us-ascii?Q?yQULgW7W9MtsSxHYiMiqSRVehghFFEURYoMn6c2hqIL4h1rX8hFh9vO1+bfr?=
 =?us-ascii?Q?E8bRq1cAJq/9AO1DBZJ1B2ddnA0gRvdCw1URfnHvHCaqw/m2NP96+VJ35+cv?=
 =?us-ascii?Q?pwgdRhouXJsRyxkskniOSKRGlAqFnkjbmDOyvPBDFJcawbNTkaB0+AKN0LFh?=
 =?us-ascii?Q?AxbW5+pFB4ILWCiCnLsXaCJNTHSrZ12Bn6TP1lMIqdHR/mdpLLsckZxb8QQN?=
 =?us-ascii?Q?iHa2rpN/irYKgSZ8QRF0yGE2Iddnk7LKjPO6IddIAF45llHePdWFYW9ZL1QM?=
 =?us-ascii?Q?5MQN8f5igEO8jpdDnYSZraqSp1I+7msrsHrjyqVsaTjUTYAS5NIEAEgYnz7i?=
 =?us-ascii?Q?3FZRpjoN1AFFy956qYvgCbZ2ABc2SEmX+SGBJttYKAOAjJ7YBJKbhyqd3xE1?=
 =?us-ascii?Q?U3RymmK9kZU4vxYf+3h7LYNfSKmm47RCGZ4CSfkZBgFc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(1800799024)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WovbWsj96tEt48ssTWkRc2X3/7H2ex6I0bw4FFoqN/8NidI6sF8IZagvuqgg?=
 =?us-ascii?Q?j6WQQNxQL4GuhIvm9IxDG0jXTw/fA73NeM9Kptz8VC46MZV214qDDXXhkml9?=
 =?us-ascii?Q?29GCnnvH1ZdNR3NnuvcPyZ7iPyxEAMzst1bGgqzygoao5jkFmMt3CLVmEfrd?=
 =?us-ascii?Q?R7usyviMGpIIDS4TGhSAprmaWsET32vLikVdLJlvguoOPe1KFruzCIWdQnPM?=
 =?us-ascii?Q?epJLrGVGhnWlikOoKJFE8ihVBnlcD7g/L7mTNWdj6U8mr9kiIKDDDIrZ5Bi5?=
 =?us-ascii?Q?/q7wIbwKH+zxJulqmXnExPMymKVQxvWhBC4jXKQBK6zJY6hzKIWUBgso7gme?=
 =?us-ascii?Q?4McrRoW6uGGdB2VWwQF1+3lo3kt7pL1gqffoDsbQzPxBAgJqvCv+GgeOpY4Q?=
 =?us-ascii?Q?kkHYlyDoXrH45qICrARStyMqYXhWf74C/ADgp+6nqAYFgdTceZXywXCgxsvL?=
 =?us-ascii?Q?rhLJd9TvkV72JJKqfsQgtLl1FDFcyKmxiwH2JDlZXH80w8x6FAJ7dXoOQzel?=
 =?us-ascii?Q?sXqE6jVojfhDXbfdBEzHOzloM1OxSwaUEsg7GG8sPjwNtVMZcYbKPU0ac8aW?=
 =?us-ascii?Q?ai4i1JqM4aJLz5XMxD+z6BONZgCI8Z3qBQkwiTyYJtlF9obtrQXFMRA+4rKk?=
 =?us-ascii?Q?UEbFHH+nTSYdJZfeVybA+73XDyiyjAChpy09IKKCz2odckENOgSXcytmb7Xz?=
 =?us-ascii?Q?RsYV0kRAmdcrZLdhAjS0dDTcYv14Dut6Qxzh4PvMD96FCZmXMjNDoNMlC1lD?=
 =?us-ascii?Q?08n83cG/KuMv9yGEnYXtZKA2qzqCvwvCoEHTM+PjhcDf/f1q7sLtVfIIBwL1?=
 =?us-ascii?Q?EuljdELDLGAoTC/9Ieo0Q9h6cw428n9J3OWaEl2WjvAlLtzetkB00O+oq8Ul?=
 =?us-ascii?Q?N52LKPYL/CG4YdEK7tZaxCfmPVzTfIE8SArZYH1AbuQfpxIDD/P+NEACHFdY?=
 =?us-ascii?Q?i2X8dmbRFhiVkI+AtDW+XOnjg9sodt1BenHxl1kUKJLiKE02iMcFXYc5Wuan?=
 =?us-ascii?Q?VmpBGxGHfhWoJklqewJItTf+rRqOf2s1x29J2eSQrRCf5MpKZ63bvoNHl6yB?=
 =?us-ascii?Q?egGm9SiGJNXh0lobG2T5eXMbwYRmkwz9gQGIUBOGd1Z2sctru1v2cdSpjzHH?=
 =?us-ascii?Q?WZL73Sgu1IRFotNGs9sX+8FyREYRc83zu5slZ1lVDJPiW7TZjIYJ0JtoH1ey?=
 =?us-ascii?Q?JFsTCYWb0O/DCMmiw1sf8uwuA/79diFZGriAshoVztL84tbAnYSMebkRbwi4?=
 =?us-ascii?Q?/be8GdxPwHWgkc9hSAjzRuSz/dB5QMfG/eMzfQaQzlIflWgWgEgvnHUd1e4S?=
 =?us-ascii?Q?e8iZRFyp2XTm+GIiI9PvSzOjfWTrYSWjaqd5aAarPNC7K5TEPH2haEuT2+ZW?=
 =?us-ascii?Q?rki/JrVa1utZaawHt/y7aUjkohonPCanONiEnUOx74a//G95kMlc6aqfOfaN?=
 =?us-ascii?Q?kJ5iEsODbvfiZ9HagQLgE8Q3A37B+BM1AVp0zwEgGoLr64eVwvSwuFIqZl+E?=
 =?us-ascii?Q?Swh91bfybWPA5HgLJ3cLVapAQZsvYnSyGgmItLg020srQ/TnIUlBlyOvquRi?=
 =?us-ascii?Q?QMkypVHtz5CP9TpUDKV9EHwS3CW2arhkC5pnHfL+xeJMtPHvESSd29nh7N/h?=
 =?us-ascii?Q?kizDNf6fEvY7ch8r+7bUJ6AzgLglWDzINS+UsiSLXJfFfMGfpBvW8gnb8s8C?=
 =?us-ascii?Q?RZS/AhtoIDo1NN9YDyMCVU3DquPCuSVVHd4LqATUMf62GUE5jxrpkU9JWuwj?=
 =?us-ascii?Q?tFqNPWXx5w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d7e345-baf1-4b9c-d419-08de54d2a25a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 07:41:17.8381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyLh/mIhBkBG7SRAq4AhZ2/VhP9Ajwp0bwoIGBpXU+VVyV3kUCpxPJNFHszg+Npt5KHKT47JhlhA4nT6XMOIww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7390

Extract fec_rx_error_check() from fec_enet_rx_queue(), this helper is
used to check RX errors. And it will be used in XDP and XDP zero copy
paths in subsequent patches.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 58 ++++++++++++++---------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 85bcca932fd2..0fa78ca9bc04 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1746,6 +1746,41 @@ static void fec_enet_rx_vlan(const struct net_device *ndev, struct sk_buff *skb)
 	}
 }
 
+static int fec_rx_error_check(struct net_device *ndev, u16 status)
+{
+	if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
+		      BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_LAST |
+		      BD_ENET_RX_CL)) {
+		ndev->stats.rx_errors++;
+
+		if (status & BD_ENET_RX_OV) {
+			/* FIFO overrun */
+			ndev->stats.rx_fifo_errors++;
+			return -EIO;
+		}
+
+		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH |
+			      BD_ENET_RX_LAST)) {
+			/* Frame too long or too short. */
+			ndev->stats.rx_length_errors++;
+			if ((status & BD_ENET_RX_LAST) && net_ratelimit())
+				netdev_err(ndev, "rcv is not +last\n");
+		}
+
+		/* CRC Error */
+		if (status & BD_ENET_RX_CR)
+			ndev->stats.rx_crc_errors++;
+
+		/* Report late collisions as a frame error. */
+		if (status & (BD_ENET_RX_NO | BD_ENET_RX_CL))
+			ndev->stats.rx_frame_errors++;
+
+		return -EIO;
+	}
+
+	return 0;
+}
+
 /* During a receive, the bd_rx.cur points to the current incoming buffer.
  * When we update through the ring, if the next incoming buffer has
  * not been given to the system, we just set the empty indicator,
@@ -1806,29 +1841,8 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 		/* Check for errors. */
 		status ^= BD_ENET_RX_LAST;
-		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
-			   BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_LAST |
-			   BD_ENET_RX_CL)) {
-			ndev->stats.rx_errors++;
-			if (status & BD_ENET_RX_OV) {
-				/* FIFO overrun */
-				ndev->stats.rx_fifo_errors++;
-				goto rx_processing_done;
-			}
-			if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH
-						| BD_ENET_RX_LAST)) {
-				/* Frame too long or too short. */
-				ndev->stats.rx_length_errors++;
-				if (status & BD_ENET_RX_LAST)
-					netdev_err(ndev, "rcv is not +last\n");
-			}
-			if (status & BD_ENET_RX_CR)	/* CRC Error */
-				ndev->stats.rx_crc_errors++;
-			/* Report late collisions as a frame error. */
-			if (status & (BD_ENET_RX_NO | BD_ENET_RX_CL))
-				ndev->stats.rx_frame_errors++;
+		if (unlikely(fec_rx_error_check(ndev, status)))
 			goto rx_processing_done;
-		}
 
 		/* Process the incoming frame. */
 		ndev->stats.rx_packets++;
-- 
2.34.1


