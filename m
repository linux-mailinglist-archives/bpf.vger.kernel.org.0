Return-Path: <bpf+bounces-41374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2974B9964EA
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 11:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A373D1F2156A
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 09:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B3A18FDDF;
	Wed,  9 Oct 2024 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dklhFZ90"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5777E18FC91;
	Wed,  9 Oct 2024 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465516; cv=fail; b=QkzdDsS2V+sGhH3653h/L5rx4dVU+5l82ReVIyNU81OxQOKgcDy3C4hEX/cAC5EIJzTnZtM614lF44KOjrB17/dFhiA278v1hxZljVR9cnp4hzXw5olrN8ID01zDqX3CEch0BigkFKNcgWi5XPBZdUXcpTQln+pXLHaAMi61sds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465516; c=relaxed/simple;
	bh=yBeuD0Iqg/ituMtcfzKkx7tyWqjGcMvm58NKUCp8v1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=koUcJBTJ9dtuHE2tU7o0cwAPVvkxvRKr6yA25p+R7XmJTi2M5ifwqOQAAjK9/AiAWqgUTwxt6HBOooGp5mXRRRbXohhOTy6Z1MhOpPx9cfq6r941zZ8leitePzYJo9r8dVIj6xbKqKa35uGGY7nszfNO0su76oqJa/cqqHJOR3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dklhFZ90; arc=fail smtp.client-ip=40.107.104.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9RSVpJfc69u16ceGOi0+H/Rs+gDyPHlBpTCqp37WZa6NXxp4k9R1eFWPrnpfV9rYT9ALXq8LoDm1U7CCnplR2Ay72U4ChChnAKu9U3ei8o7BmYh02NVxmPVfIhMgkIa/hFh/gWKog80mZCLQSf2NnwKB8vtQFRzo4p1yv4q/kgNR2mXO5nZXeHoetUYvb3TBwjxgbk07hejhniYcJkiSOq0x8Cs1DowZE1S2g+e9dHHJmXeklbFY7nluQ3WKiN8iO8m7bvesQYMQWJpYWHadJTlbRHcSUJaHF1T1UD3jig0vKVjgkqvo6vbSprynyeKre3c7uVmefIVxXXjKYO8Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93Q6bC+rUmekL98GbSB+NnAyTzySjcS7PYhJolkQX8Q=;
 b=ucIpN4j/xY94g9e3CkCamfKHGJS21ZPOkTnv6sJyjDzpB+nNC1GCuEVcV73j8VRH/uNTNK1STWvG3TOeqYaJHotWvLp2wrGP5tTbuoEcmj4GQjlKvfFr08Q0jKhylDCMh5Mw5yTA0MPEjup6op4ztdX9o2R7Mw6Ry8zAzKK990uNk7Yw6AMdiVUYNgHdNY6zZH3QL9JbkR1nubrSLwucFCbQ99Z8tXqPiVdheab7W7lY/W2V/kIUa4BwB57BQWVPPC71AH6ylWiuNZ8q4Jjg4Y9mQHV5ESkofxQvKSDzDzweUlquE869ArRJgtZ/vh32aE9niESyjIK9sr+yxhS9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93Q6bC+rUmekL98GbSB+NnAyTzySjcS7PYhJolkQX8Q=;
 b=dklhFZ902HMWbqYNO8TkNW6+2A/pVg3IynXBPcCYoFYYC4671x3e69JpbSWXtrlReuMkcHJ4UApGLST3+Ov2XqVKQhk7S47LstwlXHc82tKF6LYb2aubFcGPG9u7FSDe/CQwivqRGDnNPARhcI6Zci8UR1TpckEXPRXOocnvxoDZ6P4n4OYW8Lk574GU0LqrtmRpCXiqlGByRjR7PDZQColClGlJ9YNfQUg+fZIVsI8oBqQOe1H/g5Ga19eZcp54lWPxzJGOPThEA3sfq+yz1vTvQaBDP8B9bcrNL3TW2l6RUhApE+X/2a/TYiuHR07LSwHfnczpIzXRBMDL56DYhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9318.eurprd04.prod.outlook.com (2603:10a6:102:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 09:18:31 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 09:18:30 +0000
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
Subject: [PATCH v3 net 3/3] net: enetc: disable IRQ after Rx and Tx BD rings are disabled
Date: Wed,  9 Oct 2024 17:03:27 +0800
Message-Id: <20241009090327.146461-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009090327.146461-1-wei.fang@nxp.com>
References: <20241009090327.146461-1-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: fea24d23-c278-47af-1d52-08dce843576d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d0v4nv8lblXXGpul9clLYdvZpX84FmuwLFGyAkhl/vw9m7arSznJLLJO7KeR?=
 =?us-ascii?Q?lVae7v3HcKK2zXhsaSWaRoIGZWwyep76nTkruxqbKG3bW5XNOSXoxt9ZuJ9S?=
 =?us-ascii?Q?cpxNLBE5ddJbEMo4cli0quHQmn39xxsUwGJlJ1DpFzPPZ+LKYnrJyq5dRKWR?=
 =?us-ascii?Q?3t1e4nPlRxzJY2SPr1rHe8byEbsfUBn1qY5hTLutbVLTFmmJQsqASTUoin+l?=
 =?us-ascii?Q?MVzCYEkmEDUSozEe1DxxS4KN/DtTAEXXzHEb8/0q9Vmk/W8r9siiytNb35iG?=
 =?us-ascii?Q?64XHBA6h2A44R356S3kZy2CcIiPYac6xbaCP4IgLbuOaC/46bobzDpFobbfH?=
 =?us-ascii?Q?QuENHcZszqVERk8asC14sT5/8YnURUc84LRoWcVdxzCIgd6MkDqMjJ98RVQl?=
 =?us-ascii?Q?cu4gXmklrKD2YCb/RtnZiL+mWc2o+wlf08n0Yk9NLlu7xoqpzQbdVsQ629BX?=
 =?us-ascii?Q?0eh8n8T0/HhhwZiQ5NoMfZmUSZgL9cyvgf91cQme4xJ641ZsgeivkFQdON9x?=
 =?us-ascii?Q?txO2mpfnfmdWzPeM1fiV/mtF5xXRfvJYz1+59RDgnTk0+ion8CwETsiUWa+N?=
 =?us-ascii?Q?GjgyNpw+FTY9KJFqiLqRvgeUmiJ+jCeUbqxfmlcjteIUjf+gOmsrfUBOjfx4?=
 =?us-ascii?Q?R4HTn8YYAkdLb7creUutv/73qs1HGts14RWJA/dtygp3p79JSjl2Xw1mO2/Z?=
 =?us-ascii?Q?cU0Grov9kRFG7DjBsbqKYE/q08XNCkfRpP58B+WB8AKqUb+8PxVbTiNStD2D?=
 =?us-ascii?Q?uqBT3Hfhk8cXMVUy3fA3jMAyC+p5/nq12PwmtXHSWU9x33r8xJ6D2X5hjDN9?=
 =?us-ascii?Q?s+okGeAMMxY9pp24X+Hma0jMI3QdHrjEKfsuR7BBNWnPNIOoJlJqombgWKCn?=
 =?us-ascii?Q?5sInUTPX/J8OxwoZZbPc/2T2DmRKEq3N/gHd8KSjGQ9DnoW/y9UK9bETt+om?=
 =?us-ascii?Q?a8A83iw9L1mpAN6tz8jAfzegIrAkEesEoBsBuK7iB1pciYhzfEhGhVmrWhtb?=
 =?us-ascii?Q?wxlo/RWMi/9rMfvlmGUZduHUYxF5TgONmi9kTKBNHm3eqgq1Tl0s3WenWah6?=
 =?us-ascii?Q?pJTo/sdOhGxtmPSqlXA/kD3aOUEICrxlVHlCq82km14OQQy6aN7ny/MIl/H+?=
 =?us-ascii?Q?3UQTW4+4oulUKe7BUeE6xX9SWwvEAranVBUjsAvpM+plmjB4kxwnc1SNmKOG?=
 =?us-ascii?Q?wYwulyF5n3qkF/DiAJbBNUMjPolzUSG0EV5H1ILobcj2oKTNXHWDVT7WS5TG?=
 =?us-ascii?Q?wD+y52mrE2qbNWY0EoFB3zddiHPPZmb7aZZ7DeHnX1iUMWwXiKh8We6u81Fk?=
 =?us-ascii?Q?cxn8nbYJUP2ttkOAHXobS4X7svNhc359wZ/CYNCRqyDhXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VBXhDp1f6ifk6WcyiqiAYsvARP/g+P8yLklBXiwSEKAuqkkA0LUkxrWKHwBy?=
 =?us-ascii?Q?HQBR33h/4O/5NAhxrJ3mlMVv5SMrGBkLgCFSXoFuJmU/8kfsubhh9ocKAg58?=
 =?us-ascii?Q?rzmH2yRVtcVbZ9Auo9/m1wfn8M+Db8vGKCgOGUw0AA4Qm0zBrksGzIugexe9?=
 =?us-ascii?Q?SS/rrPHv8gvzXp3pkW0aA0AZLtKJ2hlAUKSmi2lcPG2czLhMsxJkiBF4Akhl?=
 =?us-ascii?Q?kdyYjsUJDAKuZteuZhuHAI37MpfRzmLmwKdCfD5QNZnZfsLyrint/iR9cV7H?=
 =?us-ascii?Q?2hyHpb8zye7j0GZcPN5JstWlMguPnuKKOQMuevOXjnwVmdGMnWOHBq0jRLlj?=
 =?us-ascii?Q?vtxvHeohY50jsM/kfvyUV0CtbbyD/UYrDLptzJUOdp0FFE5datrglpSAQzfW?=
 =?us-ascii?Q?9nTlOnslsspj20h6xIeoKQe3RBY+MvUQ9r8duIzBvaX9CowWsuvm7k/26ySz?=
 =?us-ascii?Q?pecmOEhI09VEhAfMF45a9WYNuWDC8+0M153BuvEyuGffJ43HJvPryV7obFB2?=
 =?us-ascii?Q?wOuhq+RGcr9k7r3U/pvFO8CcBNm87R1hMNOKn4f9opivH6nwQ9WO23xcvZJb?=
 =?us-ascii?Q?VUxnZNqlQOlTIZxYheLwRmomlvyyFPLzFOhOSURtcue8Bp1p1RfqxEqZwOMx?=
 =?us-ascii?Q?fRDKahIvAHokEc1FxpGQao7n8KQkjrKd4tImyKhEobaC8jgykEu1yAPXJOBL?=
 =?us-ascii?Q?PsKjcuM3p1L9uQcKECaV/GwHyqrbFErVDuGAmWyGB4nnIPblopGvGkqyqOcU?=
 =?us-ascii?Q?mcOv4V6OM0ePWSujd1r4BrM/wsfR3EzouWT5hU13/IYr1XnTG9q5PFlrYT28?=
 =?us-ascii?Q?ehWJWa+ay9Pa2wmiRgg5JxX7KnCROHwBlq2nAVi3vwSFw4bw7j0i2VXCCwLY?=
 =?us-ascii?Q?YjXup4K8pWXicynhQ6GZwQ7jbxIbfShUPvvEpK9Y8fixJdIWjnyJ1POhEMTC?=
 =?us-ascii?Q?/7YE2SxylM9RNbg7DBi8ta4wUqLjS/1ehRN1Zpxnk2qnMIp9+pFiIkJWE3U3?=
 =?us-ascii?Q?ZR+M4yWDTytJ9oKoAtLVWBwCtdL14rGTsz3+7dO/k4hGdSOQU8gMCq6pgKCJ?=
 =?us-ascii?Q?f+62bYAVo4GWl3zczlwH8iwYRiZrCi0JLGukOIzpVstdaGIcdEmQ9W/B9g3a?=
 =?us-ascii?Q?30nCd0ckZsoeCUscEEZNgPcKixXaHWmDd0gCUzARGtgyhDltcusyEMoTafQC?=
 =?us-ascii?Q?W3XUVNC2up+EhWJmSzv3CS+5lWInc9nm3fO/OeK8OwtOht0qigOlb6Ltc2Zi?=
 =?us-ascii?Q?9/p1QV1I+22QFREzNoTb8zss14gn0crn8GgZ9Bzls0k2ieaZX78XS3O/fJn4?=
 =?us-ascii?Q?Kilp8npSBrES1Qmqi74rJGTOAI56NrnyfO4EAjW8K6kz5X4t7b7JlrATjF9H?=
 =?us-ascii?Q?tUKVbOMfe3RbH69SKfuMdtV/MMQjdffhyoBQLwIKOFZZ34CCvoz7EAKCVWi/?=
 =?us-ascii?Q?2VmKVis97it+GKciM2YVYdPfjgNuGsdiytOxSwl9v++BCq4cQHYZX9JvmbV7?=
 =?us-ascii?Q?eclZ0QzzLIg6tRFOWbx15GF7SGDEOxu4wilDkNyP4pciTMwRjpDsF9qziu4n?=
 =?us-ascii?Q?dp0j41N95yVS2Ied0Ssf2Xgk5C32GTTdwnq6mAN7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea24d23-c278-47af-1d52-08dce843576d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 09:18:30.9016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqBjDihGJ9VDb1ecQR89KBwQ+xEXUIADS3le0w3reSfWhw8VqAqrjmjlOb4894oAO/wK0e9Z2SKXhi+2chAKwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9318

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
v3 changes:
no changes.
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 52da10f62430..c09370eab319 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2474,8 +2474,6 @@ void enetc_start(struct net_device *ndev)
 
 	enetc_setup_interrupts(priv);
 
-	enetc_enable_tx_bdrs(priv);
-
 	for (i = 0; i < priv->bdr_int_num; i++) {
 		int irq = pci_irq_vector(priv->si->pdev,
 					 ENETC_BDR_INT_BASE_IDX + i);
@@ -2484,6 +2482,8 @@ void enetc_start(struct net_device *ndev)
 		enable_irq(irq);
 	}
 
+	enetc_enable_tx_bdrs(priv);
+
 	enetc_enable_rx_bdrs(priv);
 
 	netif_tx_start_all_queues(ndev);
@@ -2552,6 +2552,10 @@ void enetc_stop(struct net_device *ndev)
 
 	enetc_disable_rx_bdrs(priv);
 
+	enetc_wait_bdrs(priv);
+
+	enetc_disable_tx_bdrs(priv);
+
 	for (i = 0; i < priv->bdr_int_num; i++) {
 		int irq = pci_irq_vector(priv->si->pdev,
 					 ENETC_BDR_INT_BASE_IDX + i);
@@ -2561,10 +2565,6 @@ void enetc_stop(struct net_device *ndev)
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


