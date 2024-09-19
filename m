Return-Path: <bpf+bounces-40080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DD297C655
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 10:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7629AB214C3
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 08:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023C31991B8;
	Thu, 19 Sep 2024 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hy0d2W9R"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010071.outbound.protection.outlook.com [52.101.69.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFB81991D7;
	Thu, 19 Sep 2024 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736187; cv=fail; b=NtxQ3b+MqkQgHPq5iZZygYf40nFUXQ+HVxM2JDR73eAblCWz8BevcdwJYHLkr5sTX89cgrpKE3GYQhx99lqvJSeMjUZOP467NEFyQGcbfKMNq/9sOZBQguPQR5YQXtT3xHPX+XfU8535HMW5K1I/dAg2Ee+zPWJYFLjw+RinZIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736187; c=relaxed/simple;
	bh=aBK5W1y0Eh0vIXTcTK9dHQX6NfM/iSqh53uLVQK5Wmk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Cy9M0+E43yC3wKrCyOwvi631whkWr1sos3mPX5/QGeFCPlVqCnvxkmAXlK4HSkJCNAgEL89G5uqIJycpvjwg0ns8W75eqfyb2otpb4eVf0bAqHAAuDhANPz+5wYRX3WPxFUWP5nPLRd+1KszXzaq34IDs76JnupUzqnuAqfZXIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hy0d2W9R; arc=fail smtp.client-ip=52.101.69.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXQJvpgvtBsUAQvehHTw5VM1i2SCfbIsTPytxP6DmAe6mttKZvRcCCtj+4VI6J+3ztG5Twd8f/bGU4DXigxGEge6VKh0z0l2Yvdg0wxhkO3mU4cuWklSIq7NvIWyAYcitO1rgAMzrRs0yGSe/1jLbEvwD5N+gw4ayYAkMGvgMF/w567E6tIREnKKRY64ZfMa8nw+V1JaKftM86/T3BdA1cala4f8rohcWvv94/gtAuYB3AOiSEILMkJ4j/F6NobRHK3N5iCLurJEYKtlREwCMu87TPfo5Y0K319nRTRHIzdSq0mK/m2JCq+ucLv7m8TARs8rECcSOuuw8CswbAF46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4l/oeTuTU9yGCxRBJaQwH6I+1YI4dIFPi3rZBGvhYM=;
 b=WuQySajEJG8vXYkVXQZmID9RRIPNL7fO9wrpZNT6O/8ObdqHIwFRerXiB7AHfHISuT0NHMJj/PbRamV4LYfv2EMzJK4NXxk8RZaXK0kgwwBeyLr5N3GT5IQdv7pXY/5qfN2usc9DrREaGy1skiGxRr0QBUGi3P5P7GE5z7PDIFsqvDnzgzERCnd/ekHZna3yglcXTLXHWZHUK0hG2JEaedSBpeaLcM4RoFaZ1dQdrAj7uMecefePzqg4FWTFNGAqUw3Y0vZ2K67J9TQLtMEFjYNLrIf67t44fb2oghHN4/9d1JvTUBSNBAkTNyFI/wfbby1VSvkgCrHtlmKP6cuErg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4l/oeTuTU9yGCxRBJaQwH6I+1YI4dIFPi3rZBGvhYM=;
 b=Hy0d2W9RCCZ32sbaPUpVMFgHl+17vx0nezxh63Ckikqucnj96TXaSACC6VyCnXaL3g4YHF+Q5MjcP2/Md6McjwrlWYMqlGeFR5llE3GkcfyQSpyGVZiy9VuvepF4wP8xbevQNSKApOqD/K0pL9d0WyGFTVVtG3oMU/Py1K5vdLBq+SvsFn7WjEJ2+7wYX+uBeonfiOiaJHSivXCTxrJ0AvIW8DfhvDqAY59gfWfP07Q+tRO3qGIzEnl93ZtF5JLTL66nz670Z2HvhTmaVnMfkScu9ivggBkDkc+wHTPDjS906einAGA5ZC8FE/cVuYa4lUTjwnjPpLaPLbyvSj2GLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB10242.eurprd04.prod.outlook.com (2603:10a6:150:1a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 08:56:16 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Thu, 19 Sep 2024
 08:56:16 +0000
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
Subject: [PATCH net 0/3] net: enetc: fix some issues of XDP
Date: Thu, 19 Sep 2024 16:41:01 +0800
Message-Id: <20240919084104.661180-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: ba383c92-edc2-4f51-c517-08dcd888eb76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G5sXKS9XtGKIbDUqCVfwlUbrpO9JzWUUwMtlcmXI7nXq6/13ROmafmTmnR6p?=
 =?us-ascii?Q?HRk0E+kiWzEUCA4f97XcCKnEA+CaqOWKr8I7ewOU2wDn64zt+jWVphy2/vtF?=
 =?us-ascii?Q?vOEGEmFCCR99CLys/7Z8CJCuFoKa8CeJimreluKJAKu+oe01viuK5WfbaWpS?=
 =?us-ascii?Q?8pVFEnpKYVtDqtUQsSzbbQ6GEVDNSIu31O6luFL6EaX5YBfphsJDlfpOJaRv?=
 =?us-ascii?Q?Q9nqd8j3osS+D49j39t0Z+XpkmKuO3wvbjx4TQIkgaBtqG//u6zHVQD4vnQT?=
 =?us-ascii?Q?Qw4kfJaBlYT0uZCJSvMR4vUQlUmNlC/JNiOsa/1mUBpbChvBhJZ/ci2cWlLm?=
 =?us-ascii?Q?pBcIpUbDwoS1/0rtpIvlMmq1EDFW5O5jyxHja9C+GxnLiAIDUdiku6KRGepr?=
 =?us-ascii?Q?fJ6iaAznYo9szD8f/l1LsvIXDMb0E/qIP9Uy/Grz+Xb1KTEWVdPmvALCwxfO?=
 =?us-ascii?Q?9FFz/Q9tnWU6zHDlJW5QSjD8H/31HyGwe6Zu5TJsRXp9fTihoX/QnFKVFa5p?=
 =?us-ascii?Q?nEqsZv0VbyP9xBsDvnTiEG458ER+u5SkPcXQJKOVKjXU80c6KCX5KaH4XZ24?=
 =?us-ascii?Q?u2lDDFjy1T88SVUc9yTDh34RoKNdoeH4lomeJ00tU2TAvxp8U43l/Glb2+fV?=
 =?us-ascii?Q?2btub34q6Ghja6eJHNvgg0rUkqx/5HypSJwqTI7ujUrB4H2+9wEMBIKtAPTD?=
 =?us-ascii?Q?UJ3Ptk5V1ht7W6+ATrrEg8WDSiJdE0ohzvZwgY9avvZVpDS4Dv63Wkpl4XBK?=
 =?us-ascii?Q?elWQPBed6opE/Vo9wb4RRvuKVOQWWGL8fmbKAR365QFZNZGbYKjV7CJmZQGG?=
 =?us-ascii?Q?+Td1mej73aajuOeLpT5lachJEMowt+UICgQ5V+HTfqKryaE73xEfnzfKI4dJ?=
 =?us-ascii?Q?DFTDM40xWhHOhDZdFO3cHVesEoLqHlYYlC6Y4Z/EYU7JkQ04Uem4WTCcTChD?=
 =?us-ascii?Q?4kP2X0xBpuvp3WHo/BK46eIFsmAjlGEhLvIbv1WiREaH9hAepgzRGHEsDPqV?=
 =?us-ascii?Q?CVRP6rJLXkdu9mZBaheAWXPBA1RkZ3X7pEQ8Hm+2sXPAiZRtjIj4vf+CmAhC?=
 =?us-ascii?Q?1DuaC5CxKazcX+YG3dwdoXea3x//AD1E6kEENwJEXFq5k5j8LoRxZjuxnwQS?=
 =?us-ascii?Q?pR3+NVb+OVQ7xo2J10Be/9yqlcpcFkiy7VUQVyGpbdCXL433uIBTKfZidSmS?=
 =?us-ascii?Q?3Tx7BA2w7enEEfCDmIdEgpzz83BvTM1yk441cTTJZruXSp4QuatXzlyydBbC?=
 =?us-ascii?Q?FbT6+moQybr7KP1wX/i0J3ginEaFsE28+bIyyLEmo1mCnqC66PjlHyUlTjqg?=
 =?us-ascii?Q?B8WxTEIwh/3yy9YJXURowkYOdljkKdCQxUOMDMbONOTmnMYDLJZmmzMYO0bm?=
 =?us-ascii?Q?Oh37ylofzWNsA1qSNPMuONq4sHRHzhOSC9MAcowlgYjeF9GTqw1obDIEj8IA?=
 =?us-ascii?Q?bcRwcEUofT4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xf7kwOEy0rlpgWkLNYrHYyjZN4OJaeHHHqw9dYr8iFi5r5MaJN81wOkHIcJ8?=
 =?us-ascii?Q?HLl5AiteOW8059tOjuBbELGX6/sjgIRmUhToJRCcLG92ZF2iV6rsOBH/XZ+3?=
 =?us-ascii?Q?sxTYU4fAvSEJr1sDeYLc5GMiyvXxrvHRZDcmorWLSlQ+at+NjoLeCfhA12r6?=
 =?us-ascii?Q?1byxYDXtg3k0MSOSeqjtXe0NPQO4dVJYmCN6eZgvPc82RHl+nYTfbs3m18u3?=
 =?us-ascii?Q?RDuhLeZxmaaalas47Ng0CS159WRgyxS9bxYyw5FoAikIP2rz9Pj0nzBbzjfg?=
 =?us-ascii?Q?E+OXagNKyfMFJEn3YAfMJekK35JNRxKLalxCjT+YZkb4hSXCQ/34gtFbGfw0?=
 =?us-ascii?Q?E+GkSWSJxhdK4dCk2HWCWgVNwrZZM87w3OZoh2pWPqqdvQwl1T9jgpL5quT4?=
 =?us-ascii?Q?A1x0yZ3c+KPdlB/MLX0w6QG5OJ7ZyIPLRfl1uvfp1Vmb9k4664xCh9xlFbqa?=
 =?us-ascii?Q?d0hgeg/Exp0v8BnRvkcpjqaS79Cmd/48WVhZUNp/JiLN6HYGqMweye9ZkVhc?=
 =?us-ascii?Q?ARCjHsMBmz7Ux3Op6RcbxeJQMcy1TbJy5xxtK3BolTDu5kbfQtFyazfCX+x2?=
 =?us-ascii?Q?YxHPm0aS2hKC1/+kvvlnOofAv0MSKGT6PP/+wHdtKD2SQvgAtPyWjdBDirsK?=
 =?us-ascii?Q?+w4OVeN11xHwwt3AY2UcWfi7QHgD2gXdxNEBY3qF2z/JjJVrAm2YOT2uam44?=
 =?us-ascii?Q?/Y3P0PKF6I0Ob8JfrmGvHAcz6DGHInjg2z6xpXBBy7YtI9j4hG9qUHgIk03y?=
 =?us-ascii?Q?9QFY1W3KM+1hVjsC830ySQ8UVLFQDkSTJIlqkeCM1xx+j4F+kzo4ta4EXfxj?=
 =?us-ascii?Q?TKmU1NuOoTbxx8cpaU5rfS7L41PRote5Rw6BEfyYvntxdYeXX9/E3ZLHaR0q?=
 =?us-ascii?Q?2RMd9riwlCGDw1VG5W3fjj0zHfU4UMB1yJX5+hDaeWHp7weJEZKfWyDMhEfC?=
 =?us-ascii?Q?EAgxZtA8TFN7LBysd0D1N0eYVQW7M+cYLdHXmPG+AIjuBQiomd2vVHlUBo26?=
 =?us-ascii?Q?W1BukGoUImsxCVfhbanKLc0ZSgTkpiBJUIa8x33ALdGMGk0AirJ0lToV7r6n?=
 =?us-ascii?Q?wuTByJ8gMU3FPyGeRE1HpmAj6fdxFuffwF0iLUXxTOrBlOIp6zgRqQ9WFeqw?=
 =?us-ascii?Q?Et3LUKOsN9hBYQoGLZLwREoVY7XdKspB5PbppBs/GraT/54U2k39nFp0NJ56?=
 =?us-ascii?Q?nBw2ZAXaMXugiIFUabr/DMMGtNY0EnvJVjR8XzJ3MBoqiGNkHlChJddewR3K?=
 =?us-ascii?Q?YgukeGW1A7J0hc/VkSKFaWHvfaT14dWj03bdeUHKNFhYYVtftwlfFoBhKGan?=
 =?us-ascii?Q?7Iom29glLqfdfKFkobXBz3uwmSEAaqpk3aCEBdgLkLCZP56+wRwqToGvR7yP?=
 =?us-ascii?Q?diG7wLkF6XG5hASTsNNgvm3v50UM//6EDH4DR9rPDSU78PzqOW74KVcK4/WN?=
 =?us-ascii?Q?ZiDRd19y/v5aRLyzQthviaYvxJoDvqirsgKvNbBo45RVHkC0gAOd5yWJSGic?=
 =?us-ascii?Q?YNYkiocHcM6W1FZdih0CdaAYhaw9yaYQllebET2pUNqakNv581zXFHDXRIDK?=
 =?us-ascii?Q?ayTm9+XxkechvUkUHGF1xgPpINFOSPPAN/e0FWS5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba383c92-edc2-4f51-c517-08dcd888eb76
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 08:56:16.0853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDFrfL8jpDLhg8d6Gdak1fvxD9RCZZnHMbcY5LTeAjLkPBVHQwF91CNu2uu5h78Yx6Dco0Uq1IkJX0tIYAI2zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10242

We found some bugs when testing the XDP function of enetc driver,
and these bugs are easy to reproduce. This is not only causes XDP
to not work, but also the network cannot be restored after exiting
the XDP program. So the patch set is mainly to fix these bugs. For
details, please see the commit message of each patch.

Wei Fang (3):
  net: enetc: remove xdp_drops statistic from enetc_xdp_drop()
  net: enetc: fix the issues of XDP_REDIRECT feature
  net: enetc: reset xdp_tx_in_flight when updating bpf program

 drivers/net/ethernet/freescale/enetc/enetc.c | 46 +++++++++++++++-----
 drivers/net/ethernet/freescale/enetc/enetc.h |  1 +
 2 files changed, 37 insertions(+), 10 deletions(-)

-- 
2.34.1


