Return-Path: <bpf+bounces-41371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370489964D9
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 11:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC97E1F26AE1
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 09:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330D318E033;
	Wed,  9 Oct 2024 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WiHlcFxP"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2077.outbound.protection.outlook.com [40.107.104.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5D318C02D;
	Wed,  9 Oct 2024 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465501; cv=fail; b=pB/B+jwl253qcUXEcmH6GUocuB4WlEbKSuXF7HdOJgEKt1RXlxs0fdMp+koz0EVWcPUuPjuc/9qEl5ea9XsX6hq86TSzwd3j/NCVTslKSZhZEG6hlGg0BPz/h1uI2Ra/NIz/hzvNRzNc614vMkBC0zFFW62Sm9kg0oVqYeZcJ5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465501; c=relaxed/simple;
	bh=BLjbsMPzseQDpZHCGU/hEgiVC6mv6H4Qldswi/RsC+0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ik6Zi8l5BTx8kLAEJhobi9xN4QsPIe0+lUtAzopnwRtIj+fl7oxYdf2AMKlzjN9BMex3loLhBE0oRIfa6rbtUUOLFWQ3zFl2EOxxlogX702nUrbh8OkIl9Hj1RsPUJ+7s+FIsW3QYnjo8Pib8TkkK9TXgo9Q0DrWAjy5dVSr9RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WiHlcFxP; arc=fail smtp.client-ip=40.107.104.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eo9XCyDMMU4Wg1WFxtqBSXG0HtOSG1MezKtECMAxUQXGvk5NdK3YYqxx4v9HyKdbbY/K3iIN971QV94VOTh60ZLI7TRtVBGj6JVuLP8GsFGmCgnWN3Vo7whtV7LPwySuocp6tRecpIC/aURuNTneSvoEyxCGJPL9H+5GJ9a18GW0s4gbkQAvbwNBqPYqNvwko3WHz7ZatCz0qttL3LI4FKjwFSuA9oqL8KY7rL9u89bnzIYCBTT1Wm4VfoOiHesRoCdCu38IK5qjulvyBWyrYG3hwvInLJdMzxmboFQpNJtW2P2Wjs8SxMM179RNJ6oIa+zpNwpDPLPfZG2+c0pIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9w8QXRvEQLOx/yJSc60HeObzf57Hd1AZ+bEOGJzJw0M=;
 b=rbK6J/lVRvWRCs0/UI8eW+nvHwsHRC5LnZZAN6pG0IR6lS9H5R2fe6l+UEqnr1FJubO+MF/NZHK0rwGw97vDPKdk2A5R4Xa2q00n4fTDSLzxCdjY0FsEhHzoj1LaFp2QeA5cBK10qoLjwie0L78ryNyQipIpz/LjQiHdildvawq9ZUWZqCc+79hSyJN9y6E2vk81rY5iJ2JjO9NO8gsEUhmwAlb1YFelX4aZ+FilzhMTxRKTYBZYiqywytdntfdv3UqaHOdburKKjtsft8WS4iG2RXRnsT1tLybVpo5USfQRLhclBg5alYrH1nhVfN+I9hxLxflILq3sgSb33+Rlag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9w8QXRvEQLOx/yJSc60HeObzf57Hd1AZ+bEOGJzJw0M=;
 b=WiHlcFxPrPTsp4R/fv1SCVishDNySaTwZSCxfeA5VgWb3SrQcdqvY9yJt0W0dcjUNdB17gk33c5Nc4H5QG53S0a6FidmXoC8BJmv4u6PTzOxpf8UrfNU5ErR8G42kseeBPGBSmXpeEeMbSSVrqEQuxAsU5GUVOSU9UDuHRxpZ6a9n71PBwdu3KXY/mSoIkWEZSicKgeAnHPjYMu5S+Msan9KDI+xH4b8GLDCTttO/0UMKFvqFsCiK2KEkRnoYqTJsjauKZ/1jk2X30vLnTsNaKT0Wi/UUbpCudJKWPZ4TRH8ANDiJ+keKxj/SR8HUkRTRZkZveTR5BItlwQi91nbug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9318.eurprd04.prod.outlook.com (2603:10a6:102:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 09:18:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 09:18:15 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	imx@lists.linux.dev,
	rkannoth@marvell.com,
	maciej.fijalkowski@intel.com,
	sbhatta@marvell.com
Subject: [PATCH v3 net 0/3] net: enetc: fix some issues of XDP
Date: Wed,  9 Oct 2024 17:03:24 +0800
Message-Id: <20241009090327.146461-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0102.apcprd03.prod.outlook.com
 (2603:1096:4:7c::30) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d034d33-eea3-497e-ad15-08dce8434dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0r0pH3e2Mk4nFrelq9PhWn+i5T90Xqi+NtQzhYIJPLkBbFbBMYwKp2Wb7i2E?=
 =?us-ascii?Q?+pLBunUzjhyO6NBuPajD+abfz+2xP9kR3+v6nt/05T5UYdX/xHDPLqtPLpM7?=
 =?us-ascii?Q?qm4B7YPEZex+yo4Qw11RwLEG1Phjhv1Y/hsCaGTwapskRyR577RcwVdm+dGL?=
 =?us-ascii?Q?e2TjsHR+FfmvvRPP+EsIDf8ZX96zzmKq5qmw2PaEmp5pa+AuuDJF6d8gOPtw?=
 =?us-ascii?Q?C2P3bAstniLNDSGgXLKWLfaj3Z+MWd1HgWefo46KFBnNt12ab3KcjlaleN6s?=
 =?us-ascii?Q?SLfaoyMg7mVqsQwOspwihRjLt27cC5UpGkwYTjeutr5nIPOGmtY/SnZwvOdc?=
 =?us-ascii?Q?pV+tMpA7K6zjeqkrb59cByjH3oa1WeUY6fPsCxl6+CUNBHesWVHOWDL5HIZ3?=
 =?us-ascii?Q?lIFB5ue95BePSa1zBxyvyxYwlykYTfcZTDz3HvGNhnTNv+khNFUPea8W85Or?=
 =?us-ascii?Q?FRIsunQDo/pzb/q5KN3eg65G+IsS+XEGdDlmt0apqq2V0bqs8iHyV1Q3X8xT?=
 =?us-ascii?Q?Tuv8omQvshRL6i+uN+zki2t9RFAMbhc7EwNXOIeYfjsWeGEh3JwblDFTTDSv?=
 =?us-ascii?Q?YjfKSfFASAE68MOBrUlttn0xxponCCn9Z8LX1O4J5FARBS3WeYbE0BCsfuZB?=
 =?us-ascii?Q?txi38cwLvlusOSieaomzj8dvDhzrbOrOkTVs9V8mC8uFuSog50M3criNs3bj?=
 =?us-ascii?Q?AsP7Whb6EAmriIKn3L5XvDaQQvBkAF2/3nsSrP5nQ2iy+mHcyLujWhRPpc6A?=
 =?us-ascii?Q?wGqBc2MxAoB2Rycm7mD6c4hdyUEDsKIuzQkrjrqA87XSGER1zA4I7hyknrrw?=
 =?us-ascii?Q?YhfMdC3mAgRICX4yTHjd6HB0ISbAbeXCYNWp8uicRtrx/abDB6EcuXkgVy30?=
 =?us-ascii?Q?hCLhDU/YjVsG7msHDKrP8A8UkOdqVrFtdDq6dgiDHL4+fgKc1WLUbz2Q7ERb?=
 =?us-ascii?Q?vcMdy68CMLi0+6JT9JxQkBGq7wFkCYjpDPwnr4FWSy7GSoaNEo8rkBud3z5q?=
 =?us-ascii?Q?3NrmU/YFqUmZIiMnX5DKmsnsOMSR0cAFfDCIJrOKEd3oWoimgJuImA2CxYvY?=
 =?us-ascii?Q?EhdPfglbdN38TfKjxxvaBzohGDwKsWKZj6xNC/7P3UcOAH71ivTXKU8f5Ls6?=
 =?us-ascii?Q?u/EW31l39/ucKJGjXTWD+kSXwWvUpcZ5GmFJOSNg+cio7poX1yKr0fOHWbNW?=
 =?us-ascii?Q?Y8uxzwbMinAurhO4F1mavUOXffdZTGZ3B/V438U79CynaUwucM5cDNCaHTh6?=
 =?us-ascii?Q?EUFjz5twCP7FuZcRz1i5dS+N9LlYMxD0X/5xIihTexZga4AYNpfuYORKOHvE?=
 =?us-ascii?Q?Bq2ffcLJkcageErfuRWPPJgtU4vLbvk+79r9fpgxgKKOIEOIkYqPxyLPJ/aL?=
 =?us-ascii?Q?fLgZJ5s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PatrWv/4J5LD+iUbJQGozJAKeMWFYBQH9eRQlTt/+j74epgVXm5M1IjtXlza?=
 =?us-ascii?Q?KC+RaGla//n7xd9V7BhhEY/weU4glvzbiTcz1XPH3MWXv3JkRGvEKG1YIEw5?=
 =?us-ascii?Q?L30fDzx6x+gnru1dyq9R5G2/maSF1Xkv/zMPhik+g4EzT7wmKGpPUEMjZFQT?=
 =?us-ascii?Q?pz0QoxxSMf7HEP2rPS+wdCyLIQ4pXslFP5N2vYKuCtD5k1RwFylfMkrfYtLM?=
 =?us-ascii?Q?7hM+GylZnRowDocF7E+j6kh/D4h5KnkcQBSA6KwxJn5eHKAQwtGzB4ZdRuvH?=
 =?us-ascii?Q?SbK/oRgn9cJ271SQLm823dcT7e5zVI0aTz74yy70DYi4mPTB7KkkNX+QrxJE?=
 =?us-ascii?Q?Gd8KSVGdz9IXyISFcztRcVIYMJX4RM2/YPcDB2/cdQBNj5YZR0ToAY126fix?=
 =?us-ascii?Q?4B+kuArQJKK/bqvcFCOWyi7So8s/JwPtFVxk30YID3euDqks8vABOQlCug8D?=
 =?us-ascii?Q?LDrhNU9UjVthiJ+EZ4ttywPFdxqPdqlbsDWxmeMB51DHem11urmnz27z8voA?=
 =?us-ascii?Q?OumFO9rR5kbijGJfIIYkzp7erUgsiRwMHlMQBmth7ATB7E0sk4o3jemGXCNq?=
 =?us-ascii?Q?VgsCC/ubw6coTfYs6y5ORHgqIJEB6wIMs4rXU6cCO50Lmum9/yKS+nnZMHWt?=
 =?us-ascii?Q?xdPWWeGYjS4L75Q5lJ/4wjRepXnU6VAoEQDHhuCQL9bcBfqFqOWFWLPWFw+V?=
 =?us-ascii?Q?OT14RSaLQadRwZQFWBb4Xme0AT22H6XpbVncbvJn1J1rCbplaaf+9QjUP/K9?=
 =?us-ascii?Q?E5myD+BferrhmbYw528sJGPK5M2W3wR7vlge67lRnP/qvFdyzrECqTIvCy8P?=
 =?us-ascii?Q?DMgp64AUEPjWnxViQ+bNoHSsf0KeA3TPtpct1jm3h/zhQpbnZU2cHxIuLIkn?=
 =?us-ascii?Q?t8eh2vgKMMv2uwFFc20Np3dVCbS04uesyPZeVdS46BpEDfU1S3yr3XKgtWzA?=
 =?us-ascii?Q?7Xs1FtAMo+y3Thda+JumLgGMj5wczW63AS2YBEdJrc/stXlclxlN8rp+khl9?=
 =?us-ascii?Q?9dMFl8uTk4hgM7G/spPSp3t6Rx1CorNTUOizgHXe7yFvvgb/5J0DGz/FYADh?=
 =?us-ascii?Q?IhSB3rCpjsShIq+MmhrPxJ7Dr9Z6S9BGx1gX/DTeXIJ2RMl3xeL4OXp5f4vs?=
 =?us-ascii?Q?9g/zQTKCt1mBxtqxcubxDLHZccKrfx7KG3lq0CHaniIOW9V7HHc8V4OVi28v?=
 =?us-ascii?Q?nXVYdE4OdExbymYwvNR0eada7G1VeIqk2SL3KnfDYA/vXQUm2hkFZVwdmJ/O?=
 =?us-ascii?Q?vCDDbH7D/82EkLG/St5ocwCwTc9J5vnPyaeISRZmfPwiash7+SDQ95+rqZYO?=
 =?us-ascii?Q?EO9Iga3BEXJJLFiw5dHd7u5FRwBTTyHQM4dl58R6T3hjBbLPWvB4NXHpKLRF?=
 =?us-ascii?Q?PyeH5gxLX7EjKwHcphFI9JiRMAXZVsjR79LznAtyhsCJCMswtuCyo/DILoHc?=
 =?us-ascii?Q?DV0LM37DTlOCcutlfqYGT8D5qpOGy9phONnxkRvDzqoFxMcU4Jafp+bElOmI?=
 =?us-ascii?Q?X5KMnH+DHaKwQcotkd7ESR9W9zVsJBz125XEKbPWanhPF+fRFirOwE209bHZ?=
 =?us-ascii?Q?rxsPnOf95mXoYuBDImCgiYBBgVa+VY8gNl3BE0/F?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d034d33-eea3-497e-ad15-08dce8434dd5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 09:18:15.1397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ox10HCvyarYz+mV9bS+XBK1iNq3n5s9S3jS8B4dAI/FXh7GT4kVc6cSpIdi3d+MxHh6uCqy2IPnRmCt3ZYgEHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9318

We found some bugs when testing the XDP function of enetc driver,
and these bugs are easy to reproduce. This is not only causes XDP
to not work, but also the network cannot be restored after exiting
the XDP program. So the patch set is mainly to fix these bugs. For
details, please see the commit message of each patch.

---
v1 link: https://lore.kernel.org/bpf/20240919084104.661180-1-wei.fang@nxp.com/T/
v2 link: https://lore.kernel.org/netdev/20241008224806.2onzkt3gbslw5jxb@skbuf/T/
---

Wei Fang (3):
  net: enetc: remove xdp_drops statistic from enetc_xdp_drop()
  net: enetc: fix the issues of XDP_REDIRECT feature
  net: enetc: disable IRQ after Rx and Tx BD rings are disabled

 drivers/net/ethernet/freescale/enetc/enetc.c | 56 +++++++++++++++-----
 drivers/net/ethernet/freescale/enetc/enetc.h |  1 +
 2 files changed, 44 insertions(+), 13 deletions(-)

-- 
2.34.1


