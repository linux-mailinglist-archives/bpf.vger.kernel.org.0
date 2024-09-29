Return-Path: <bpf+bounces-40476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9050B9892DC
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 05:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33D91C22ABC
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 03:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0222B42ABD;
	Sun, 29 Sep 2024 03:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dd+wTiYr"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C58B41C92;
	Sun, 29 Sep 2024 03:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727578855; cv=fail; b=CgJko7iv5zUmBmIwvg++vttA+AS2RnbsydXj0onvBOZ0SKPphiHhbKZRKY7CtMK8H/PhS+raoHZfNHGd1o3N0PrRiqfxEz+HJDyueeXi4qp0Z7ew5r1ADsLs26cgb62qfMU8hfhs2VvXU13zmWBDd7EcOrYcnjesmPvM75jWuQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727578855; c=relaxed/simple;
	bh=kzbfzXOJDy0ko4JCER1OHISsxcKN9pL3ycNimm1oQCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vqp8bsIGXph7Im0aJfD+T2Sr+WRjRRaELJBro7d417VkSgBYuMxSFt9mvd4pxeoQSRi2xX14GYR7LuL/PY8YtnDcoXB7SMEHNIlaY1P7SDbFZZwyfkIXQFp2UiyAZ03smtenBhDfOxPb9FMNAI2zzXvWWAUOChXZZrmOTNIUFwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dd+wTiYr; arc=fail smtp.client-ip=52.101.70.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvW/Rtp4feft2aWyErFb1140yHoMwzGAlZZ3PqpCiy6vIzQNZyekwEFt/zO7JgfVCMDORro2H04uT8fUju3WuNMVaa77Lfg18hpB3ybmmxdm+J0HkVcCJXH6kQn9gEKMXobQeGel+tFb19XdB/OsJaV/tZozWTbiKuMs/TbY4aMwaMXotLVVT7ktovc17RtfLk0+7KBDJDeuzt9TOBn7vdtwLJnlOXgPb95aeZ7xiaTTlgSXLoevHvdpS9MzcjLLbaMLaVtyRR4pdPuf2v4/QNbX3MH0hNIfWVu779ufsOj949fQV01OGTzdLWDIprauZ9PE9yN6VIUIACKT11xUMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPt+0ixg7wZ4qD0BhhCyiY0zH5Ea5CUHExmy6K11pFg=;
 b=CNulxPpWn+c5AMtR0sNDw2A5YXss3kwoReY/Czu7IdXPMAHBaA/WddHjOdfeDxhSmLMBIBMeissP3M30IM7J1IqWTobR/acf5CZjteDoT2vnJ051Ypq+ywSq29l99LdHr0XIy1+FapTeoMsilCBi4ZSY/20+JI1jN7kXaDggqiQBqjBUD5/jL8db4ph9MYtxMXuZLiuN4Q6W8WfZ1tsaCb/wMq0+cYDxbq1Q4dlQpCh+Q1tEIEMZuyNXQUfFutrImOzlHoBitwpHmLEquWTs/sHWYNzqG+B3yCJC/2NoDXqgo49NACjXyE80U0Yam9uMGN3NrbAPpu190VjcDb3PsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPt+0ixg7wZ4qD0BhhCyiY0zH5Ea5CUHExmy6K11pFg=;
 b=Dd+wTiYrEVm68nm/0I9wLcI0TqGSR+4emk839XpBMCVcm9wK2dB1tqGRMty0TrBCnYeKIyBMtV5LYoBI4RKpUN9m+fTDQ1JYlBw5xKz5FwVEZioQj45TOGysRBh/Oa7uy4ufF0wmfJe+p92NDphPbBnjYLkXQskHPpk0Q12qWSBS4hBNI35DbTSbLkUsCz8RxZ4pcMBrsXkaQXSLfRY7g+RLOiDIo1LBSMnue1QWBf1rpJpb9Zu2VuGuXddlKCEypzTVgoStye895RzVLtbnl12LSzmAGKd0Ur1DEaYDFTzfcq61q6U0OKgYzqkGUTx0HcCFR3/1VQgyE9IHYh8fMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10690.eurprd04.prod.outlook.com (2603:10a6:800:279::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 03:00:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Sun, 29 Sep 2024
 03:00:50 +0000
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
Subject: [PATCH v2 net 3/3] net: enetc: disable IRQ after Rx and Tx BD rings are disabled
Date: Sun, 29 Sep 2024 10:45:06 +0800
Message-Id: <20240929024506.1527828-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240929024506.1527828-1-wei.fang@nxp.com>
References: <20240929024506.1527828-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0025.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::12)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI2PR04MB10690:EE_
X-MS-Office365-Filtering-Correlation-Id: 113459c6-fdcc-4e23-0104-08dce032ec9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?osfpJ/J0kb3A8OkwhqaLS0r3OxwEEL8NwTolPSWG95daR8a5tOHfIYTQOB+u?=
 =?us-ascii?Q?kCJAYNSk0Lj8OubWHEAV/MZwh3kjLR9C0Ciqt11ok3c8XtQj3LpcO3PTqMIx?=
 =?us-ascii?Q?UqAImQTDyivWO4NgUzkHanFrEgxhdVrAL+4S17MZ54cai9ujLV/vGptj+eie?=
 =?us-ascii?Q?Ru18PsC6xVngqzkkmQlHj8f6/byfWPAR/++1bo54WZz0FoAy7pahcifB8VGR?=
 =?us-ascii?Q?U+htXKr0z6Yd/+RNxdcQyFMQqA3NvAvSmJ8SRVnC3OskBOOWr3y1WajrB5Eo?=
 =?us-ascii?Q?bZjMUalMjvqG/V9ijIU93/b9Lg/7VHHpEQw2EZVJ9kryp+cs4GNmCaOJzYcn?=
 =?us-ascii?Q?MhqsxrcRNc1Z38hRTL+4MGz8ASnkN5OGmfqWQvFJQxgY2peP+kxnRMqZUy0e?=
 =?us-ascii?Q?8pUEQtW1OS/U9PzoOlB2SehmwuKfp8fA7FdSO9EVhyhmWFtDYrnGQS6JGULu?=
 =?us-ascii?Q?pXdHhWWDzk2H7mfVmkdiBsGdgIy3QepwZH1J0Fn7LKJC/IXwKstlLaLRIwyG?=
 =?us-ascii?Q?BjYT3YXGq7F7J3e0Xma6gK4bcVVIwd/UqChJ5LaJAmzZ216uTNg16vwA5SKX?=
 =?us-ascii?Q?nYjInJej9DgjKrRxpqIynH7lWdq/tb9Yf7bbitYwCzu1eN09Scsrl+/Ods0F?=
 =?us-ascii?Q?cdWqHbilIfUPe7oSvuhZAwA4HdmLtQM6GW/3OgD5/+IERFg2RbGEBiIKyPxk?=
 =?us-ascii?Q?H83OcA7dgFutpzYf+etoBSWPTZO4Xi3lmdXGYeRsZvHP3K6+GQi/zr25WoCH?=
 =?us-ascii?Q?ew1lvFhE9WMmYxg24qKvWLKZig48M0PvaDtmN/icrnO2mwBMgqJRqSeM79d2?=
 =?us-ascii?Q?GJn1R7/+4BBpMp/JV49vCB88jwOVogvpcOzchvj0zN62fRJEIJDn+hMuBvOq?=
 =?us-ascii?Q?Kpcy5UST+xzJXo7IYWFK18xLXGD2xNMeS9B73X6w17xkAFTOiWj8HhZCEnvp?=
 =?us-ascii?Q?IwlRoDymoz9MtDeEmV2ZIEJYp7nNn84OHmFBTlzucWDywd+kXcxkAWzUCJ25?=
 =?us-ascii?Q?NV0/rIqqbZHjQsdZ6vWuJYTEBCs5fBg3KAMwL86onmYxOULHOGdtz22eE1iz?=
 =?us-ascii?Q?6aAccfR2YD7pxJZFJIzqu7A2eeT0VRULaDSNIWtMg66inkamY3yV33el6DBj?=
 =?us-ascii?Q?YK0tj0PhhHjihV9KhW8O/CmjkTabNIzpPE1/uovilwau6Zcj77oQt6l84gQu?=
 =?us-ascii?Q?N8yg+UMRhidUsTCqTvX12y+fpJfNrv1GBXtR17JKIbyMkOGegP0jUgm24D5/?=
 =?us-ascii?Q?gXu3Dv/dwuAToIdcVMix4onrIgIkRAH9utc9LFvW8/nqKS/j/6nI+9YjjA3I?=
 =?us-ascii?Q?7NrLXwx1UEFNPqTktGnn2jvPTzwUJWH4+kvhU0g6/SHlgf+i2aEWEOyd/xNl?=
 =?us-ascii?Q?cEnD0k+vvPGy9GF9AeSrR0TexxPBTKvcWwsqazQohVnG7y/6H2uC6cmgf+aq?=
 =?us-ascii?Q?Vz4+hEAYcJc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sDP3mdde6C6dASWNUo0sIVUZvQxuUhjfyW7WWLrSpqzuHA3wVxDR4osMwlNe?=
 =?us-ascii?Q?W7ZQ5+reegqMCrkacAbPhVhHCIhLW92xzGd3Z1o/VUDBuekzZazbBaKK8xse?=
 =?us-ascii?Q?B4FEym4uhlDWC3jQQk3wZSTzfF4OHmFQLvRaLi5Z/CkCA+k58D0JGT5ppXVS?=
 =?us-ascii?Q?ITtfZHu3MNcBS/Js6W157FL03VA1jP+nCp/1pKUiLlw1EYrGPfrwMhitdFlB?=
 =?us-ascii?Q?kle6AmjoEz+xwzQuaObUTcoKeXYxw6ANflnLOQa06HkTb3H072Obm9HC+/cn?=
 =?us-ascii?Q?a+Mou/EIR0broSc2w23D+W+HJprUqedvxBctCBWSanuwlC97kVYtyoGnlSTT?=
 =?us-ascii?Q?HX5DT/vOJArVKbkaH6qOXVtVFp8xiXYT4QpqySjIjjPtWyCDMEhKKPli8dbt?=
 =?us-ascii?Q?c3zzogpXd1MxATK0qjFbm/Z0eBKMiZyyM+QViBqoG0A+rz9cnlBEldCWP1ln?=
 =?us-ascii?Q?z2mRazhPN1hj+c7BF2ijCkMcn1G47+kYYiGXaa0jukQRySPrP+SjIue6PwQ4?=
 =?us-ascii?Q?eO3tLb+/GbkL8X7PwPcELcfAVd3VbkVjeaozsMG5My+FXXykbxnylicl85QV?=
 =?us-ascii?Q?9ZzgAX0wCGrdT6p2QaO52UkvM62zxEt9Lcya3rb9gf98RmOtZbWn7NaiOYRm?=
 =?us-ascii?Q?K9F07jsi/o6g8UVMPtxSDxKyqOs2/wQCCISJOVwaidKGQxR8yzPNjFNOOm3v?=
 =?us-ascii?Q?QgYGl341BEZ48KF1H+zCpIKitGDFReNdq+uhxFTCA27az6w1gGEmH++gk/bf?=
 =?us-ascii?Q?cUnZl1HAdbBSfSw44QiQFgHHrhKSOLEtG/aNUT/udDYI71tUvEqYqzQ+OTnf?=
 =?us-ascii?Q?/tFPnlPBPfyHrqWHPIIDW1og3roTlosOJ7W9XN1OgCzlxYmnFgNvSjaQSL4r?=
 =?us-ascii?Q?ULOlYTMELyc7C0Vu/ROimXcc20Hqx+El3p5+KJcrTSWXjvVqeRoR5UVKBqIO?=
 =?us-ascii?Q?VaoLlYTISzQzsvBm2kizhob2fl/JShUtqs9jSJW2fqXrDpN/ZaGrvKFfYhI4?=
 =?us-ascii?Q?dt36bzVSvt8yePYIaq5L8F1HKQSBrjV8/idPOtw6D/U9XWXgblnJtoAFwNP5?=
 =?us-ascii?Q?RN5YW8ddrh5fcC7NgB7YXxRfUq+vmbvXaOPVRAPcFd9FiEUlYzq2OqaUXCyL?=
 =?us-ascii?Q?xBtKhZc0T/b+KT86uiA8vOAwtnL7PbnFxo+quGWt/xd3w95uxBtNYE6k+vbP?=
 =?us-ascii?Q?czqszzxtsqAbC9g/D0hvNtC09nI5dGhe9nfs4F8vwu1U66W/87y/Z7TtgzFt?=
 =?us-ascii?Q?rDwzHgU6Sr1AJSwM7e3hDrpEJ7UrEvp50ZtUg6bBuCBpdr0zQ890m1qtm+vw?=
 =?us-ascii?Q?Hhvctj7TxbKxOkVFO/QBSRlNhxK8jbZnbeVfnGl1fo8QBwSsxNP26ZflmtGp?=
 =?us-ascii?Q?imE7DfDWFmQORlQ7kX/LPg8C72JuAnqyujiIihA4/DxyqbHKXE/3bXI7qh6h?=
 =?us-ascii?Q?djmXc8dx4CZQ3TOKJ47CBNjI0CKZVno+fJ/a1ggzANhiyrOCkomZmP2YjS9b?=
 =?us-ascii?Q?i56Hu9D4/KlGcpLHTsMfjfTLYyBnR6AUfZe3ezu3vFDu+ckFU2WT4CgN35y6?=
 =?us-ascii?Q?Dll5CO9tUGBJ0BrCeAi6Vjsvdg3CF42gcJOB/vdb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113459c6-fdcc-4e23-0104-08dce032ec9d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 03:00:50.5051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRVIIsRLMOxZCiZeDeCGlPs3Gjq0uXJqm127Bg6dsoWs19RjZFg4TOAYNuUahBDl3c8qSOf2cd38102z+5lT8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10690

When running "xdp-bench tx eno0" to test the XDP_TX feature of ENETC
on LS1028A, it was found that if the command was re-run multiple times,
Rx could not receive the frames, and the result of xdo-bench showed
that the rx rate was 0.

root@ls1028ardb:~# ./xdp-bench tx eno0
Hairpinning (XDP_TX) packets on eno0 (ifindex 3; driver fsl_enetc)
Summary                      2046 rx/s                  0 err,drop/s
Summary                         0 rx/s                  0 err,drop/s
Summary                         0 rx/s                  0 err,drop/s
Summary                         0 rx/s                  0 err,drop/s

By observing the Rx PIR and CIR registers, we found that CIR is always
equal to 0x7FF and PIR is always 0x7FE, which means that the Rx ring
is full and can no longer accommodate other Rx frames. Therefore, we
can conclude that the problem is caused by the Rx BD ring not being
cleaned up.

Further analysis of the code revealed that the Rx BD ring will only
be cleaned if the "cleaned_cnt > xdp_tx_in_flight" condition is met.
Therefore, some debug logs were added to the driver and the current
values of cleaned_cnt and xdp_tx_in_flight were printed when the Rx
BD ring was full. The logs are as follows.

[  178.762419] [XDP TX] >> cleaned_cnt:1728, xdp_tx_in_flight:2140
[  178.771387] [XDP TX] >> cleaned_cnt:1941, xdp_tx_in_flight:2110
[  178.776058] [XDP TX] >> cleaned_cnt:1792, xdp_tx_in_flight:2110

From the results, we can see that the max value of xdp_tx_in_flight
has reached 2140. However, the size of the Rx BD ring is only 2048.
This is incredible, so we checked the code again and found that
xdp_tx_in_flight did not drop to 0 when the bpf program was uninstalled
and it was not reset when the bfp program was installed again. The
root cause is that the IRQ is disabled too early in enetc_stop(),
resulting in enetc_recycle_xdp_tx_buff() not being called, therefore,
xdp_tx_in_flight is not cleared.

Fixes: ff58fda09096 ("net: enetc: prioritize ability to go down over packet processing")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes:
1. Modify the titile and rephrase the commit meesage.
2. Use the new solution as described in the title
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 138c0a36f033..906f0edbfef8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2468,8 +2468,6 @@ void enetc_start(struct net_device *ndev)
 
 	enetc_setup_interrupts(priv);
 
-	enetc_enable_tx_bdrs(priv);
-
 	for (i = 0; i < priv->bdr_int_num; i++) {
 		int irq = pci_irq_vector(priv->si->pdev,
 					 ENETC_BDR_INT_BASE_IDX + i);
@@ -2478,6 +2476,8 @@ void enetc_start(struct net_device *ndev)
 		enable_irq(irq);
 	}
 
+	enetc_enable_tx_bdrs(priv);
+
 	enetc_enable_rx_bdrs(priv);
 
 	netif_tx_start_all_queues(ndev);
@@ -2546,6 +2546,10 @@ void enetc_stop(struct net_device *ndev)
 
 	enetc_disable_rx_bdrs(priv);
 
+	enetc_wait_bdrs(priv);
+
+	enetc_disable_tx_bdrs(priv);
+
 	for (i = 0; i < priv->bdr_int_num; i++) {
 		int irq = pci_irq_vector(priv->si->pdev,
 					 ENETC_BDR_INT_BASE_IDX + i);
@@ -2555,10 +2559,6 @@ void enetc_stop(struct net_device *ndev)
 		napi_disable(&priv->int_vector[i]->napi);
 	}
 
-	enetc_wait_bdrs(priv);
-
-	enetc_disable_tx_bdrs(priv);
-
 	enetc_clear_interrupts(priv);
 }
 EXPORT_SYMBOL_GPL(enetc_stop);
-- 
2.34.1


