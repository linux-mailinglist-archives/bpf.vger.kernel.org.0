Return-Path: <bpf+bounces-40082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDB997C65D
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 10:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A0F1C209DA
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 08:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89902199FC2;
	Thu, 19 Sep 2024 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nBcRyRHt"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010071.outbound.protection.outlook.com [52.101.69.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08077199E8D;
	Thu, 19 Sep 2024 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736194; cv=fail; b=o7yRuvkNS3yFGucdqOW2x35fTAhNEnK06aAb+zwtqXT8OkG1O+SkiVc1RkTEfL4DL4d3imJzYWWAe0u5IGywYgYFDUaGR6jZVXxLny0udoM9ehepi3k3hpmkZWm9GU7r0e61y54BYn6Y+WIx8ugi8axjYRvZTlKRqQ4Q351YSLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736194; c=relaxed/simple;
	bh=C+eiBjDargBJ4OM1LG70wElM0b1QVFYWDeO4r5FGLNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PjYVrQ/tqYvNoP/OUFujggd9zi4daYkHZBgrm6oglROBlTATQkWqTFxMa/eYgSLa1WqcdqexO72LR9DoclzKquR2EQsvlhrrMQZQ8me8xnNBKvbLlBAjslxJJ3EPtzILIF09Kmi8S9p/WxgXMFdvmpz4i4PoyWL3nZEhmFW7TzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nBcRyRHt; arc=fail smtp.client-ip=52.101.69.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoJZzkCerC2tzd25m2fczTfaF39eNNeYZUk9TTuaW/HyAr0+vPQZYdzWlbmR4BJvHyFixVaNSA+/0ZO/2TvWV3+6kjaEuY1aUVoIol87A5ha2dWpYQJvE3IrYEHv+UeQP5SANtiP9oY9pIM8VVBr0zZViFCxjJHvb8lEIuV96MGS33XiHsZFpc3IDWyvPF79eQ/AT+DEO5uv6vUcGTsWoLPbxWD12m5dYsf6l2btkG0dV1jCdunVZAGN/fA0Ab/t0qIY5+spukwSy0RVHdF+wR9yiALIr8amlEI4To+BXofLTu6unbe1u9aQuyCWrrEcgbn8W4DVBf+Wy24LRKdI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWfIGcFKLgid4Cx4toHmnsPKQkybDSu/i3y6tw5J+U8=;
 b=N5qsXnt/CGR531ESnb64IC1mEvegXxopPJyRnEctPDjo5tWddSvoy6HWT8KeL7AlM87mwVU0Xzk2iAvwWy3WHidH40yL9pqKcwAAgJuO9kQ6ikOxZSlYwFuKyyNcRIQR7IKg3nwbANiLVr49qZ9qMcn8FxgsaUeelldUxHDdeZ63hsg7d4jyl9ktOV3eY/gcjeadQDe85M5rAMFDwVylc7EWKr1a7smaiT6wkVWLovvS0lf8nJJEtOr7ke5yPKTuSQxaCTOVFRysAEj28ze/PtpYUM10X7RkwwUP1G6OfGQKbrbEuvHwmuAB+4X+TiYnLltLSbreX42v4Tv65bM9IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWfIGcFKLgid4Cx4toHmnsPKQkybDSu/i3y6tw5J+U8=;
 b=nBcRyRHtrlFETWUm1itAqjwS0ed3x7qqjavls+xB4NPNtQggYADBw+9ca7z2nmGi6D3wteTJK2gRbAEU1cKI/vO3tr6+nbtYGLZvCOsQl3O0Kw9X3swVozJj7AZnpLuiBesiJezFeD7ErVqZ1KYQovPrnSLyStU6ES1qzx/ntyRGeM/PbT6+gNTq4Q83xJUdrVP/Mt+NjJR/8qpPZw+oPWsG/JECqN7pZYWpA30CypwjPejUHb9ktAbQN4Pmvn+4Y7yz/ElCEoK55XCuJ/YBF5qX8uCfKUz8SgnYaUxAM6p0FFG6+5lZZbe6R2wa61fUiwoBAXgJM5/uo/iEH3hkWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB10242.eurprd04.prod.outlook.com (2603:10a6:150:1a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 08:56:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Thu, 19 Sep 2024
 08:56:26 +0000
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
	imx@lists.linux.dev
Subject: [PATCH net 2/3] net: enetc: fix the issues of XDP_REDIRECT feature
Date: Thu, 19 Sep 2024 16:41:03 +0800
Message-Id: <20240919084104.661180-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919084104.661180-1-wei.fang@nxp.com>
References: <20240919084104.661180-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV1PR04MB10242:EE_
X-MS-Office365-Filtering-Correlation-Id: 403dff20-28fb-4cd3-127a-08dcd888f1dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xQgYx2BKTjBmJhib92+rg7Z6ZCSkBIlIyY3TbpAj0tax9OPrMtoLkIrZapk7?=
 =?us-ascii?Q?zZvucwHFx+vztwgd+Pnyu6NOeQ71eHYaRuLrEnfB6vj90y8aKOJ3QC0KceLJ?=
 =?us-ascii?Q?QuHG4DtaG1FmxZ9dqbjbtsrdYN0c6Wb85NGJE4/TZMOKYHmyJmLNyGlnhb/t?=
 =?us-ascii?Q?qaksf79DlMLuZlSDaO0VOVemTgXCvqIv/SDh36AVRiNWMXSbzb7jquJ8ZuLo?=
 =?us-ascii?Q?sNH3rLVYJxI0uj5ZzjElRt+1D0ckGA1QtDptIPvFTcX6+5lRAjniK3IzPWYD?=
 =?us-ascii?Q?cGHNkXTkXbEH70qsPdiS2uypSUGTU0Z4MoqwrJ8rvyiC7lZVMzw/4nQS0dHR?=
 =?us-ascii?Q?rgfqZnqQA5r3Hc3gkGGdEgsVtabDxQWJNNCI3zt0mObHLMBtdRzWf1KXAq7r?=
 =?us-ascii?Q?4OK8prPZ0ut3tc3M2uVSIexHteCYnDfbi5H+ubshzjlRuQL+VSC7P34T5qY0?=
 =?us-ascii?Q?PLyygn/NukWLvlPgbkYJeTm2iuSQZ2UFHLvtLb17ydUYC+ejNkLGnul8KY3i?=
 =?us-ascii?Q?zuzVjJIr3jK+cVeghjAsVngQvpua7hm9WpALjgqsJeB+H9pnC5za6dIJsFfN?=
 =?us-ascii?Q?uGB+4eX1rmgUBvxkLLcpqBVbYOsEZgIjQbu4hRgkB9YAKhiD+60a1uFJu/FU?=
 =?us-ascii?Q?JXVW1gmSngqK84no+JHeJCld9/87whVYIsfRa/n3xXLZFQ4PCIeWkVfojUxL?=
 =?us-ascii?Q?+oaeK3IcmHrmzywMyzpfm2d7OyJbC+8pRyjdfFw0NdxiTC9lPSfmTw+WXklo?=
 =?us-ascii?Q?Y51rq3TYDDKRWWQ57CN7+ifn1G+jtcNHNRrP62t22ye0ccv2PA/LYsMXF0pt?=
 =?us-ascii?Q?IVwTjmMEOjWhzBE9S+76G6xvz1GRzIDX5O1J7k0GCkm6f7jt6hpaJVC8PB59?=
 =?us-ascii?Q?EGdh0+5Y8cEFXyYI933JIaCS06jqiM+BcPWkUKelJmwzs20//rdltpzPdcIa?=
 =?us-ascii?Q?5wNAULJQZ16kTLrT/MtvfAEleZKh9WLy61xSzrio3nINXVbZIEOaEK72JP6F?=
 =?us-ascii?Q?w6JYaRMUIjE3JZjDJVYqXC52/m3nwpg0jbD7cw3eoymLvvBOeq7xAAHx710s?=
 =?us-ascii?Q?j2RHDuc5ewYw6nbDqOUNxX2YZPD7Fk3WlB7Nje3wJgsPIUvv/lLwRqtiTuoQ?=
 =?us-ascii?Q?KQor6dxI5itVyGjPr2bwVSv10nEmBWGSP1ocLPg70ExRjdCtyn5/vsytUL97?=
 =?us-ascii?Q?oFTdu0q5asM5G6yo5GDihyHLxu236nV3qoeAaIaZ9b9xz0tSY9V6tP2Pn+BD?=
 =?us-ascii?Q?T2lqRshtpJDODNVjgjTr5dyR8NOzcfLj5okbGHkWo8CZumkUoCXLsV6uEBKP?=
 =?us-ascii?Q?dUkxtaUc1ZdjKpxKgGAEjBGIdwlhytBW+fGmT03J5Al/YhpHrs+g5yemuH2D?=
 =?us-ascii?Q?xtyKqmOs2zxu+1ab27KaOKUcAx9b1/pBdfD1cLJPzMDh+rPEjyhlNfrSQ1D7?=
 =?us-ascii?Q?xbgaZ6MMc40=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vFCWc/rMzFN4JjlIWOaEe/P1oZkGlyPtWoMgQos9Fm4PcIh5AMLK0BdZqUpK?=
 =?us-ascii?Q?tMr9TcOdHj9pXhtCQSLX58QE7NoM5Gh79OMapFiSyGsIlIm7ISZefTfmBykW?=
 =?us-ascii?Q?/HrwRp9LPnOotciLoxKVtzAAJUtJFoNLx1e+73dGsipFj4CLHQRz4rsYX0x5?=
 =?us-ascii?Q?A2xZtMKm7FOOjrSpsWuqZXtUP5+7k/yXjD3U5j4SDOmlyMw1gb35fQedE0x5?=
 =?us-ascii?Q?KsTaA97+/S5XkVHkCwVGl33r5xVnLQDlSim74tuzcl3WJTh/nqarcGt0V/ld?=
 =?us-ascii?Q?tnmQKEjqwNFdabcMbkDLUPpe1h8tgljBtMsuBJicJnyN0UefFlQpw+8NQYxq?=
 =?us-ascii?Q?Bokb+IC1hTO0mDB8VwCQOvrk9i1A6uVQmPIbyiwzLFN0GOATWvLu5vxbfYLc?=
 =?us-ascii?Q?YnpqgJuKRfA0wYdoVNkApYrSIkTzFzRX5PEJldsjUruyQwTqqzPC64y5Fqxw?=
 =?us-ascii?Q?YYShRPyNbIB3cJeQFeDpBYTJ8VXpOGL+ELVvN2+WwI4PUwIRo5NkTc1K40Vh?=
 =?us-ascii?Q?SvdCrRE5YHBzCII+C7jqibF7a69cggqjl7nfVcq8YRdGoeSY34eg8+tiWvrx?=
 =?us-ascii?Q?rkDbE8m0EecYB/7S0q4MsIk5SUg+gLrLVIBkmGC7mT8gkTg+ALrhjGhfHiw9?=
 =?us-ascii?Q?e9mhYJXw6BAE00zE/r//IjdplrIzuozX26xeAxwhzHV//cjt6xEwn6iAX0ap?=
 =?us-ascii?Q?3lEE1g4Lo9U8eeK70c5+anIp78YTEluTwiMPrARcDVCUxUIswWUap8DcBuOE?=
 =?us-ascii?Q?6SnXk1EuY4CGM5FAk14RbxR6zYLCrblfDk5sqE0vr547y31TvPrFgaFpeIuA?=
 =?us-ascii?Q?OfnUxDnv+A5vTkLMRmcs3XZdwjMmHR5P3kGFoyP99YBScxlFLXt3qgWbUNk+?=
 =?us-ascii?Q?mpE1wqseYfH56b6cDbedPBLlFjdfXX7qZiDCZOgQf9kdxtDUADX9LWO95Vvj?=
 =?us-ascii?Q?59TZiGT+z1WchB7g01QeboTCi/UIa2T1utK/NWtFbkTJC/SDjg6htHxYpZvj?=
 =?us-ascii?Q?g4tnMJROYQF3kmvDp6gNmUndx4hO5WWkW3ABC8sFONBfhQEAtgvzPvxI1PeO?=
 =?us-ascii?Q?YMrs8kwBbpvDjOTCnXqHNhIc1X9tRBKRJobpIwsQ5Scl2Cuu9rAiYRsvp9Pk?=
 =?us-ascii?Q?e8477Poyr6EahpRz5owM8YaeWU4kfXWEJPN8zjfzonTcKFCdcnD2vRWT1UnD?=
 =?us-ascii?Q?WeQj+FAt0Cncg0urwt8LPpTrVRQP2jk7EUIxsEqpW1s/Q95JiF7T/1UjQc9F?=
 =?us-ascii?Q?T356y0mPepOu/y1z3y0+3TzGpScYKOLPTn3t713Is6J3iVb2F2KTzcqOjxG6?=
 =?us-ascii?Q?bBYLi4QFtcKpWhe/3lTMKMPP1Gu+3qDSKpe6q50AMAEpt9iUtghlZ2GKwO+j?=
 =?us-ascii?Q?7kOqE/SppbWqBqw02SS+Elyzjsg9r3Z40NhivXmL4ZuiQNM7Uoz6rbXaUjlU?=
 =?us-ascii?Q?5oL2KvfOcuRBIByvpfApfeWs8j/lHEM8CDIeeLBcl52Iewb77ROAnHSFWEQ4?=
 =?us-ascii?Q?anFe+DB6Jzn3XzccZckTGubU4SbSSfi/iC+SyqwNhVKc+69X3Rr9KOtfJcJC?=
 =?us-ascii?Q?PZf8kax4/E192az8ZN08L/uNrPtC1rvPwhj0km+9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403dff20-28fb-4cd3-127a-08dcd888f1dd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 08:56:26.8444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sp5XeBLpcWd5s8+l1DrKbp524CSA6/aKDOmIEjICBK5VbcOCL2dUgq/QyGx2j05NDQt4WCefCg317cZKR0vQVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10242

When testing the XDP_REDIRECT function on the LS1028A platform, we
found a very reproducible issue that the Tx frames can no longer be
sent out even if XDP_REDIRECT is turned off. Specifically, if there
is a lot of traffic on Rx direction, when XDP_REDIRECT is turned on,
the console may display some warnings like "timeout for tx ring #6
clear", and all redirected frames will be dropped, the detaild log
is as follows.

root@ls1028ardb:~# ./xdp-bench redirect eno0 eno2
Redirecting from eno0 (ifindex 3; driver fsl_enetc) to eno2 (ifindex 4; driver fsl_enetc)
[203.849809] fsl_enetc 0000:00:00.2 eno2: timeout for tx ring #5 clear
[204.006051] fsl_enetc 0000:00:00.2 eno2: timeout for tx ring #6 clear
[204.161944] fsl_enetc 0000:00:00.2 eno2: timeout for tx ring #7 clear
eno0->eno2     1420505 rx/s       1420590 err,drop/s      0 xmit/s
  xmit eno0->eno2    0 xmit/s     1420590 drop/s     0 drv_err/s     15.71 bulk-avg
eno0->eno2     1420484 rx/s       1420485 err,drop/s      0 xmit/s
  xmit eno0->eno2    0 xmit/s     1420485 drop/s     0 drv_err/s     15.71 bulk-avg

By analyzing the XDP_REDIRECT implementation of enetc driver, we
found two problems. First, enetc driver will reconfigure Tx and
Rx BD rings when a bpf program is installed or uninstalled, but
there is no mechanisms to block the redirected frames when enetc
driver reconfigures BD rings. So introduce ENETC_TX_DOWN flag to
prevent the redirected frames to be attached to Tx BD rings.

Second, Tx BD rings are disabled first in enetc_stop() and then
wait for empty. This operation is not safe while the Tx BD ring
is actively transmitting frames, and will cause the ring to not
be empty and hardware exception. As described in the block guide
of LS1028A NETC, software should only disable an active ring after
all pending ring entries have been consumed (i.e. when PI = CI).
Disabling a transmit ring that is actively processing BDs risks
a HW-SW race hazard whereby a hardware resource becomes assigned
to work on one or more ring entries only to have those entries be
removed due to the ring becoming disabled. So the correct behavior
is that the software stops putting frames on the Tx BD rings (this
is what ENETC_TX_DOWN does), then waits for the Tx BD rings to be
empty, and finally disables the Tx BD rings.

Fixes: c33bfaf91c4c ("net: enetc: set up XDP program under enetc_reconfigure()")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 43 ++++++++++++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h |  1 +
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 56e59721ec7d..5830c046cb7d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -902,6 +902,7 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
 
 	if (unlikely(tx_frm_cnt && netif_carrier_ok(ndev) &&
 		     __netif_subqueue_stopped(ndev, tx_ring->index) &&
+		     !test_bit(ENETC_TX_DOWN, &priv->flags) &&
 		     (enetc_bd_unused(tx_ring) >= ENETC_TXBDS_MAX_NEEDED))) {
 		netif_wake_subqueue(ndev, tx_ring->index);
 	}
@@ -1377,6 +1378,9 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 	int xdp_tx_bd_cnt, i, k;
 	int xdp_tx_frm_cnt = 0;
 
+	if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags)))
+		return -ENETDOWN;
+
 	enetc_lock_mdio();
 
 	tx_ring = priv->xdp_tx_ring[smp_processor_id()];
@@ -2223,18 +2227,24 @@ static void enetc_enable_rxbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring)
 	enetc_rxbdr_wr(hw, idx, ENETC_RBMR, rbmr);
 }
 
-static void enetc_enable_bdrs(struct enetc_ndev_priv *priv)
+static void enetc_enable_rx_bdrs(struct enetc_ndev_priv *priv)
 {
 	struct enetc_hw *hw = &priv->si->hw;
 	int i;
 
-	for (i = 0; i < priv->num_tx_rings; i++)
-		enetc_enable_txbdr(hw, priv->tx_ring[i]);
-
 	for (i = 0; i < priv->num_rx_rings; i++)
 		enetc_enable_rxbdr(hw, priv->rx_ring[i]);
 }
 
+static void enetc_enable_tx_bdrs(struct enetc_ndev_priv *priv)
+{
+	struct enetc_hw *hw = &priv->si->hw;
+	int i;
+
+	for (i = 0; i < priv->num_tx_rings; i++)
+		enetc_enable_txbdr(hw, priv->tx_ring[i]);
+}
+
 static void enetc_disable_rxbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring)
 {
 	int idx = rx_ring->index;
@@ -2251,7 +2261,16 @@ static void enetc_disable_txbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring)
 	enetc_txbdr_wr(hw, idx, ENETC_TBMR, 0);
 }
 
-static void enetc_disable_bdrs(struct enetc_ndev_priv *priv)
+static void enetc_disable_rx_bdrs(struct enetc_ndev_priv *priv)
+{
+	struct enetc_hw *hw = &priv->si->hw;
+	int i;
+
+	for (i = 0; i < priv->num_rx_rings; i++)
+		enetc_disable_rxbdr(hw, priv->rx_ring[i]);
+}
+
+static void enetc_disable_tx_bdrs(struct enetc_ndev_priv *priv)
 {
 	struct enetc_hw *hw = &priv->si->hw;
 	int i;
@@ -2259,8 +2278,6 @@ static void enetc_disable_bdrs(struct enetc_ndev_priv *priv)
 	for (i = 0; i < priv->num_tx_rings; i++)
 		enetc_disable_txbdr(hw, priv->tx_ring[i]);
 
-	for (i = 0; i < priv->num_rx_rings; i++)
-		enetc_disable_rxbdr(hw, priv->rx_ring[i]);
 }
 
 static void enetc_wait_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
@@ -2452,6 +2469,8 @@ void enetc_start(struct net_device *ndev)
 
 	enetc_setup_interrupts(priv);
 
+	enetc_enable_tx_bdrs(priv);
+
 	for (i = 0; i < priv->bdr_int_num; i++) {
 		int irq = pci_irq_vector(priv->si->pdev,
 					 ENETC_BDR_INT_BASE_IDX + i);
@@ -2460,9 +2479,11 @@ void enetc_start(struct net_device *ndev)
 		enable_irq(irq);
 	}
 
-	enetc_enable_bdrs(priv);
+	enetc_enable_rx_bdrs(priv);
 
 	netif_tx_start_all_queues(ndev);
+
+	clear_bit(ENETC_TX_DOWN, &priv->flags);
 }
 EXPORT_SYMBOL_GPL(enetc_start);
 
@@ -2520,9 +2541,11 @@ void enetc_stop(struct net_device *ndev)
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int i;
 
+	set_bit(ENETC_TX_DOWN, &priv->flags);
+
 	netif_tx_stop_all_queues(ndev);
 
-	enetc_disable_bdrs(priv);
+	enetc_disable_rx_bdrs(priv);
 
 	for (i = 0; i < priv->bdr_int_num; i++) {
 		int irq = pci_irq_vector(priv->si->pdev,
@@ -2535,6 +2558,8 @@ void enetc_stop(struct net_device *ndev)
 
 	enetc_wait_bdrs(priv);
 
+	enetc_disable_tx_bdrs(priv);
+
 	enetc_clear_interrupts(priv);
 }
 EXPORT_SYMBOL_GPL(enetc_stop);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 97524dfa234c..fb7d98d57783 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -325,6 +325,7 @@ enum enetc_active_offloads {
 
 enum enetc_flags_bit {
 	ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS = 0,
+	ENETC_TX_DOWN,
 };
 
 /* interrupt coalescing modes */
-- 
2.34.1


