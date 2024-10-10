Return-Path: <bpf+bounces-41553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DF9998264
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 11:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155CB1F224CF
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 09:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A3B1BC066;
	Thu, 10 Oct 2024 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cy/lSQL0"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF78C33CE8;
	Thu, 10 Oct 2024 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552941; cv=fail; b=Qwp7sOrMXrOR6Un+hbby+XiDkYmYXRhMVPPtBLbPnz9JfTBlDJeTTvR1Ka51XIRkhXnJexvqTSZdpQiISePxftefNTitIVJzhlRW///FkFP830F9kO0K/HMNGmZv2qQ6eR7oEdduNqrgKSPm/19lC5AX6NYcGjNsHugcz75rzbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552941; c=relaxed/simple;
	bh=Xx/1/DAoEsILYc7CvMNPySxSzyCmgZksfKss0ndu/dw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=R7Z5xUtdJa9zvMFhMsNnfZOddTybRQ24D0nPmAK0BdGspqNAvoEoE4vTVlaF7OSi4pTBtEdqHz5kUonkAojkDfHUpDT2WvK4YgmSke0SXKeNMh8Z7Hti5f5PFw8awRfaW4YqYwLjwm+qEoiZR+MGj33xpiUIxB8T/n0OD6K/0+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cy/lSQL0; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xe8X10hTkNYPdqUHeraN8jvekTOeYNFHvQfZNkLzSCAbLQBropw37Zj2BJJYXCNRWRvzG3aEVWDJpC2yJhIQooYSTdVm7eB0k1l3UX8HdPqFntD8B82Yn67ayDRZt+YvK/NCIivN24OuikA+XrW45PC/bUIfJCNTuuFNZ9NjKAozKj6s0nTPUr7q7X/TvM8n+TuEy0z/Spe061nNMyHbN5908PPicMejDmaINsqaCQFRlqDDMyAq5MCE+yH7cuIm14T0Oan1/h37PPiq8r1VjGZG0hn+X7JImsrxrABNf2wRukX1iWghOdbDrrsqBPisnlJEnNVdoRWOES5ybjuT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEgXAnKkTNCv0VXNvbfI9Qzye9kAedYAH8kASB8hW6I=;
 b=Kh+lm2zdRkNe7UCSzrSGlW0HddU/bN2F2t1lZtRYkaRC8U8XhOSiKs6IZmHUeIf9F3WAmhCg1dPNK8sV4jfDJ5BgYFsU8GPZuGnjz+iAF24pVTfZfLAc3vJzL15VqZwN7l8LoxmEiT20BQFKBpfdJulm7gF1v9+sTqIMs0EqfqGXiq+45JbDL5aXZTiglWenqmX01Rn1oAISIebZGTZFu5pC/AGZRajYjFPrdNAkg8LgXMDNo9GRdFooMfoXrWRRXhAPzC3QY4XTb0ANR38f+q36N2p5hjVkOsUjteFAx27X2Ss9zh7sKObCk3nrqYMjJZ2eJF7nJ33+/Eq7PidL4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEgXAnKkTNCv0VXNvbfI9Qzye9kAedYAH8kASB8hW6I=;
 b=cy/lSQL04MvWDyF3EZrjhrIKlUicX6SwiEDpNUcFVpGWex5B3VtpQs1FYCZ3s9nGtuuq8h41Mg7aZp4gqGydqQ2gfMbR9OqZ1Xu4N2GnLzu/+GNM5E0KxTxoPlMbGf/UV+pdrHKnBT+TiY8lfrH4pnncWLutiaLms/hPbbAIc3s5hDAEqLM8YBi7ezSkZh5ImuR3jp+voePKUjFkx1TEV+tVee0kO80a2iHR2A0ajamWGRWkx/Lh6lpLeQzdhDUxdZpqlNkv9KBL+48E24R2inb71MaAcM8nMcPCqYZPgGShvSrxnKWlQAv87/cmb480ZCj6QegNrJwU44/OfQxfyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB6847.eurprd04.prod.outlook.com (2603:10a6:803:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 09:35:36 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Thu, 10 Oct 2024
 09:35:30 +0000
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
Subject: [PATCH v4 net 0/4] net: enetc: fix some issues of XDP
Date: Thu, 10 Oct 2024 17:20:52 +0800
Message-Id: <20241010092056.298128-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI1PR04MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: c2210d8e-902a-49dd-7ff0-08dce90ee157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ydshzWPxV5I2H5JSv7/n+UEuUG25xeocem+EPW9wJgFjeknIMBikF/L6BqX?=
 =?us-ascii?Q?dcVcEvA6vSIdMJJ4FjEgJZFwYNj79Xl9nhrSSahdQtThB+tlEuBfHIjBrzQ9?=
 =?us-ascii?Q?eES+GhyeAigtMh1tqN+CmDXLBXz4mfD0/ziRUDX37nQ0bB/GYgvrWSpMo2fU?=
 =?us-ascii?Q?war1S5tzaKBz7cZo5GO5m/imG9VP2CLHbo6uPLmjW1M+9lYxruZ1GTI3m4eT?=
 =?us-ascii?Q?4ACUYlLE/+TkmllpWSl7BGKPnfiRRZQkeqF2HKnYQXxTHUh0AIKDHpONzza8?=
 =?us-ascii?Q?l5stGFgsBsxgcvIKot2yKth0L0xymYxK2JNU0UFWy41R9LQDSMXo+BFsXVRY?=
 =?us-ascii?Q?BMqTUIVssADutw9fDSBsmYkTSypKCzF+7EOpvfpYc7XXq7qL2ElugOHd1OAr?=
 =?us-ascii?Q?289mc0MaTZO29UOjVjFE7TkPLysDBtXeZdLelep6m29yHpFj8KlOLoDlSreL?=
 =?us-ascii?Q?RMLOdO+5j4dTaT5VXv4qtScH8D1ZXKyjCBL1VTl0op5jUk+RP0Dzi9ldjz1D?=
 =?us-ascii?Q?c6EpCBveIB7BAlPfaH+8bE+J576vHWWUVRBL86yLVRPQpyAACngm99+Vn5lN?=
 =?us-ascii?Q?HhtYucYIue2FaBivNDc6pFXI4xES1adfHQuuqHJ+ZVCyz8ZpICLXp9Im4cIS?=
 =?us-ascii?Q?cY6mCBOU1jafc0M3cDiajBBn2mw3q/OFxQPlH0yE2JBL5GPdXVv4e6Rn4Jue?=
 =?us-ascii?Q?6vIAjYMnjXzL664kA+DYvkXhX4K3UqJh9VkqJhIgXZ1XKMTxqjKAb/Jmx+Uv?=
 =?us-ascii?Q?vFq3NfvMlbITnAMf5Ukym4C0E8kHAYJO2dMDheYRYMvaGsnnKPsPpiMINJCT?=
 =?us-ascii?Q?aBqDLagBxEtSa3GUtSjr46Xc8kyCeMlYbY/2RXv2vvXdRL0vZC59+f3Eajpk?=
 =?us-ascii?Q?ktL3vhSLIhJ6fh33zX5wooihmRc47C/b2MNx7PKH99v2j/ADYyAK7RsDhUrT?=
 =?us-ascii?Q?aMtv3ew/dCYIXnIJL89X/V/81yXfDs1O942eL/t4a4j1q9Epphvr47pFMAL3?=
 =?us-ascii?Q?8Q52hcXdBR+PVioDUvr5HEd3vLnK2hZz4PXYwQfaCEaAfASrXH/RnUPkjYcK?=
 =?us-ascii?Q?U89nKswpUjhs0nAoepVa4028TFtnCdOE48sHIwSMDBjb3oZXZLIpdNyHvdau?=
 =?us-ascii?Q?Q2VHPqWVODfjUh+WrTC1aZj2bVwcJBZYnaEz8c1f1EUt4sLaIJZwhIFT1n9V?=
 =?us-ascii?Q?kT6/TFsegLCge0Vrj2aHQwqhMIu/16Po307DnfkxRTp5PhOg0MC6yzskVn0b?=
 =?us-ascii?Q?MbLWaaEgxwQiGj881psmlb6c9lcpIv8ciwAXc943wvaEavDbtxZHKIT1W+/L?=
 =?us-ascii?Q?rYzhtc7zEnUQ80kZ4gROmHY4wz0GJsJAtTG6xvkOwfxHmURO4+EwC9oJGUkt?=
 =?us-ascii?Q?s9yN3aA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1vGPY/fJaM5uLQ3VNyA1/N53Pb5lYMn6/I3mMm3K0VRBeVkZPpc8RK/viVGy?=
 =?us-ascii?Q?ZX5K4+ydWq8F8VGP/9KU5D+FeMK7sXoz7hGn556bd3EwfJiiBiAgLwZeqFl3?=
 =?us-ascii?Q?r8QQ1z92B/vSI4NUQ6CE60F7vWDK1dhpTuNYzj2vo0gJSZXXbq66JRf2Qn+K?=
 =?us-ascii?Q?ns8Gcrt2qwb/GINBdHeGMfJ5RWWBgivIjkk6veMntgbOPfXXZXgNoCUsi7on?=
 =?us-ascii?Q?/o8KRNP/hgnnbURdkrH6gh4nHqyLY3Xh3ne9NczPBp3dd+ba5RTN5FIVadUH?=
 =?us-ascii?Q?Si/rHDLyw9fIvfcEt/+IIGmd8RxFWSPahYj6n8uGrcE75DFasS5Ct2YcLpQy?=
 =?us-ascii?Q?029ZvKH6eHPz87EAnTHyrPfqlbxhhuKsd3wRwbqfkSQM7IXFuvMpXFRwbEvX?=
 =?us-ascii?Q?zkRC2DFAkaL4LmR28ga3xZJOzNePq/2bXUp24C0kAOpUZ4EXf0NUnyQonLUy?=
 =?us-ascii?Q?DU+ChVDCu0qTc3HsBx0JCmCKCCNKv0N52vLJpIU3PDN9ZHA93N9xBzAqYNT1?=
 =?us-ascii?Q?iGbzDD9oebwN2fhz+y+tO1eP9LVjKzvagplhO31rR/G7o2NPO+NJGEEU5v2Z?=
 =?us-ascii?Q?SFvKkk2wmZcOiTH5tBe80cAbhzPxJXaumBp8t7ZJTugrdUSmBkcjdNKV/r7w?=
 =?us-ascii?Q?8QRSpIzqYhVqPcCvFhtJ4rYGMR1S8bEfC1jNjG2AnvHhwAd6BuzpKbD22/90?=
 =?us-ascii?Q?OVfFDGLBB897XWmunO4EooN0guIM5dBTubosl9ShFbIaArfoIig1GBBHgb9Q?=
 =?us-ascii?Q?2SZDh7RLZJaQtTsjHg538enLq4/CLT9ZHHvN1aVBR9DUYRXxC3uf0SsnOMGh?=
 =?us-ascii?Q?9xonueS+jQdqNftotqhMrs0YKte0k+IOPxZw2JkiAbN9EcUkVUtYL4NHlyrG?=
 =?us-ascii?Q?YugGLdoQQkUSwZeeyOowXq0E1VXRutemla3LHpd3UKj0KYeGjIWfDCtGlL8G?=
 =?us-ascii?Q?vWPIsStLo+WErb6FRWcXt7a4Z8vxVmXtK3ke+AHDn8Aij7MZCqgxPxckSrIZ?=
 =?us-ascii?Q?28HF1OWpsItIQN8s2d/n0FTMB0KtmlgyoaTIFVZ1mL7WCP339QIhQ8D8cr//?=
 =?us-ascii?Q?udRaDtSzrSGBqChCqhtNRZCNRB8qvsOdKCJT/GHxFJSVU9MrkBEjtbB+qGAk?=
 =?us-ascii?Q?xR4iwYAKJnO5aEnonOoppOZSw7K3YtCVqMTQv/uJApNPgpR27ARPfZ032i22?=
 =?us-ascii?Q?kzwkq7PcEmR58cVB1rkKu2rklvmbG6artL4dbzpm5iLJjJpxBM/nBS1hleDy?=
 =?us-ascii?Q?ECc6B1eZPhPKEigcQQ9haahkkpXtXG6KzKhbKSbeXR8kvNqAGDy7Nm7Qzu+o?=
 =?us-ascii?Q?NOFM/qBHijGpwNkZv8IYg2oiP0pgYwCpZEyXSpDXo+r8oR7p3Z9k+Fp9561f?=
 =?us-ascii?Q?IKJCy7+anE8jDptYEjEuZ9MBn4ATsUBMw98oUnwFDQuWRJJPEpQOTxYxAgqH?=
 =?us-ascii?Q?EM2HJGt7Sr0rlNO45zWABGt+QeJbQ2JIOgyIvTAVfQqVteYe8KIvW8KWuut1?=
 =?us-ascii?Q?k6I5LvqIvE5nDts0GkGxpyoaPzPWJoc7W/Gxe8YyAhFPV/WcbpZu9WSQ2JKH?=
 =?us-ascii?Q?IJqrptsX1gIZUP46SPJDUC1Kg6mI0r7/gilLpbq3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2210d8e-902a-49dd-7ff0-08dce90ee157
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 09:35:30.2376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAVewJA7F1vgkFNF9XG57b7g3gZtHH1lWoIU6P9f/UFvwrQkX9c3FamX6XXa2HviswL/g27RhvMXghUII2TMXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6847

We found some bugs when testing the XDP function of enetc driver,
and these bugs are easy to reproduce. This is not only causes XDP
to not work, but also the network cannot be restored after exiting
the XDP program. So the patch set is mainly to fix these bugs. For
details, please see the commit message of each patch.

---
v1 link: https://lore.kernel.org/bpf/20240919084104.661180-1-wei.fang@nxp.com/T/
v2 link: https://lore.kernel.org/netdev/20241008224806.2onzkt3gbslw5jxb@skbuf/T/
v3 link: https://lore.kernel.org/imx/20241009090327.146461-1-wei.fang@nxp.com/T/
---

Wei Fang (4):
  net: enetc: remove xdp_drops statistic from enetc_xdp_drop()
  net: enetc: block concurrent XDP transmissions during ring
    reconfiguration
  net: enetc: disable Tx BD rings after they are empty
  net: enetc: disable NAPI after all rings are disabled

 drivers/net/ethernet/freescale/enetc/enetc.c | 56 +++++++++++++++-----
 drivers/net/ethernet/freescale/enetc/enetc.h |  1 +
 2 files changed, 44 insertions(+), 13 deletions(-)

-- 
2.34.1


