Return-Path: <bpf+bounces-40083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0238D97C661
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 10:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A071F25E95
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 08:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B4C19A288;
	Thu, 19 Sep 2024 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hhPVwu03"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB6F199FCC;
	Thu, 19 Sep 2024 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736198; cv=fail; b=O3KgG3zhnqvF/Q4eO5/2FPE+0vcFTLU+rQpmLV9yb4b5UmE9AADej7T9X3EF9ey/CLrM2ANy5G0xVks/XhCveuNq9uuEFQ2l2Sjd5O4AA7xA9FPcinvmiJHbhgAedSHipuysWE62jzwQIIBC4/l+aEGM6SHcJeVV1WTncDjs0cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736198; c=relaxed/simple;
	bh=9Rh+rUmzy0C7oq95npDG1YWIvHqAMKFRjI3hPK8DO1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sXd7wIu2mlZvZeoGWoU+Yy1rzwqdVdTbInu3RIQ2Ya2M3b+sgP1AmJnZYtUNAEcZJCmP2jjcXkGtx8lpvY2dnp7tenmpjSlDh/nIMWaKrRrc39nrfFqJZgT1LPqVX4Uog+FUZOhx/UFLZQGGOF0CmvClAQ2z1HWKfk3qm2BMS1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hhPVwu03; arc=fail smtp.client-ip=52.101.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtQXnUoRIi6BkmlNPEUHEYPrLpk1ijLa+v8ZlH4yy1bkesM5CTLwQiQeaWJjmvpBGDGltRPKQ2/BEFnrvz3nIrgTtnELlGc6iZhQ25GKWgURVqi7tf7AI/wSGVgFiD9oYMRlh0n+zLYoP/OzYYlKt+IH9S4YINnXeIj+gva7JWmGOfDNugbY/c3i2frelQQj3+4k9neGlljxvFB4ss2PeaD3W82/nWNyL6p2in+rtnR7D8JPU501CDGby7DrTlOeHdUemG8gr1be6fGUTB9YmwpV4dr318tHPDPtMrM9/GK5o1uclrztW4iczoZHo0BNKQIefoylJdsBwLRBnfgH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXqv+sdVIr3z3O07cuBTJ+KGD392tNhRET2iee9VYFk=;
 b=lrQW+g9qvpgCeWsEt4wtwl6hfcaFmU127fbIgm9ypjoPv1uF2wjUfniJB0RvwSgI8bSfCutgw06vYm0mR5BqGKqB4x+D5ZxtaOpwwqxAZ9SDF57+StRTztOPZmEJ8T2sicOhg9KM8XwM4bgatVw9Fails3+u5lvwfODX8OJdaPeSeatg21oF5jdvcx9SMGbH4k3H1LNPlPKVsagYJRe2DXcxB6mCMBYtMxyW18qE7FmpSopNkGybsuOE0hNju/qV2ityB5YPO88bk5PZ7ai97HN5cwZKgvwXHTghYpSR5LnIs2JUVzFFwG615f6FF8nLylzXmz+APGGYO8Tb/g8OJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXqv+sdVIr3z3O07cuBTJ+KGD392tNhRET2iee9VYFk=;
 b=hhPVwu03wSfc07YE8VXN9xrAc/igmqEcsDI2VhSJpWmFuKHTlaSzhnHtg97DaYA/T2/31kDz7n1y+EP+GUHSSm7PQd+RSh0UBVpm8rNkTqktWD7iQho26ioMgZF0yC/RsoO4mYb11i9ml8fwjTINDUfhXk3g1MwpfqjMBxzfc1EslRnw4+gLreIVHeP0z+tQUcGkQoxcUTVuOb9vRcg6ShQZzpO7cB6adWU1kXmei6QYPIphDzkLN6rvNAv+aun9aBd/vMocDo67NqCJ2YAtzXrsng/l9ENP6GXWl6gxbyCwf6X2tRmyZBrMgbZPer14LFXhVx8JMJ48C34uSquFsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB10242.eurprd04.prod.outlook.com (2603:10a6:150:1a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 08:56:32 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Thu, 19 Sep 2024
 08:56:32 +0000
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
Subject: [PATCH net 3/3] net: enetc: reset xdp_tx_in_flight when updating bpf program
Date: Thu, 19 Sep 2024 16:41:04 +0800
Message-Id: <20240919084104.661180-4-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 12ce09aa-ae1b-4ecc-6591-08dcd888f565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jAq+TMt2opBkoJEEw8D7ZT0w7NyQKRrsm82BuyhnnVbFv6g50Igub58OgOMx?=
 =?us-ascii?Q?ZenOD4xA8EoabV1foqACGzHicsx+iv6cji7LQNCF7J/eNpnpAYsmV5N5u6iw?=
 =?us-ascii?Q?1XXwYyHj4sd9dw+DPNsAfym1p0ioQw7yypL5QXIOjZW1MxkZ1ZNBcuq1iPJQ?=
 =?us-ascii?Q?6MXX/eAzvoPGv9QYgbQzn6Fjgm8xE4JTXjY+j9ybKGmT5bwl13IKRi5usw68?=
 =?us-ascii?Q?Y3oVRCywRAHcvnlnrxtGgRbaObfSHad+C3Fwx4Ow/CVGebd3bqPalwZFyGyt?=
 =?us-ascii?Q?+L/vfuLg0lzI87bOMkqHqkfPieaXZ02cwQuSvsAg8iSUFywKWiY21r0YULBV?=
 =?us-ascii?Q?Ydla8tqjeSYgvSwUn55twOqPkbnPkHU+eRIA4KRt1wX64LNHJpBnM4CKlNNq?=
 =?us-ascii?Q?xA2SwgMS4haeGj3Bip0KdzBlVdrc8rbHwouuRPfCaYMrRtDVc40ggeyLlLkZ?=
 =?us-ascii?Q?Di1dS9/mlQg7E/zMlgBFUyJEVGDecg+sbF0Vk7i0iibRRGZO2VS1wBNgvxaX?=
 =?us-ascii?Q?6elNs2N0OK4B5NFlf78HiWtJGGxQoe0c9evCpVdPpzIwpuIkLWvN82g1KLbr?=
 =?us-ascii?Q?S3DzcaSZL50D6UIC/iO0Z4TWtdtmJz/FsgK5MZswbsKqBrf9a1gdxqmtOZb9?=
 =?us-ascii?Q?dq/crRTcLSTwa+zFewshCxwu8mpYwUaJM/0EQ3O+K1nqYG8xL9Du9lpJETyy?=
 =?us-ascii?Q?N/LQNyaaiaQYtDgw22q9kBXrsrdGYw745bL2af9U/rigYIpSKmGscBSUFHsd?=
 =?us-ascii?Q?qxW77yX329ulqGCrkZdo2j9lhWdxn53wsChjEsCtO1WrzoBo6J0ntSbDyc6n?=
 =?us-ascii?Q?TQWZeO/KGUO8G2V7/arEo0u87vUjAJpUU4qqrtczQQzFo8yEmAvOsqOH+iHU?=
 =?us-ascii?Q?svgi9Rs6zf2MBqa08XSXwkVi/gCyxGzwm00yodGrcJue9cizPhr8KaiBbKL6?=
 =?us-ascii?Q?zHyA6uMx5SBJBdUusHzfhn8f8WRx7Yc1HMz/ruhUMFfVeU3MRQyHEZqP8BNS?=
 =?us-ascii?Q?AT479JrJrIG2lFxZG8xEqLoiG2qfgkmW+llD9CBNE4+wUi/oygzeijRm1Tmk?=
 =?us-ascii?Q?8V9pE59FN44w+I1JJmhJi2H5y0gH934SnjPLLBQ3h6dex9A7xwGXu/Jr5lvr?=
 =?us-ascii?Q?9WCujlGIk41rTzD6FEUYuIF6O5i52DwJOB9R169eXqjcn1RfGGJySU9c+86f?=
 =?us-ascii?Q?SeMh5/BrkUKw85biZQTsr0N6X+shKEjEcDJRUl0jbOC2IF4VPbgjRrVsq/Br?=
 =?us-ascii?Q?0Ps8z8Uiykmqz6yf9xw9iIamkNSnL0wc+2F4/rsfjt4wVlCEdrBuRs8EYoBE?=
 =?us-ascii?Q?Zi74yHZX5J3sVg7Pt4Cgfx4Jg6dQH/mhaez1eVVODQFGQHVfCZB5tVTxbLJc?=
 =?us-ascii?Q?/tcFgFA21h+1TAJgUTlvx00xvqiZ/UQgZiOWUes4coYWEIHASC5owhCSyt/s?=
 =?us-ascii?Q?iARl3+W8mlU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MKfb1jD0GxF76HMZ3pUh+8360jO6Y5Cs0sjPwHoG505lY0dLQhPbWCyvfakZ?=
 =?us-ascii?Q?HUN9nVqSYlL7Px2pS7Cw/OTPPlbVkg6A5Fkk0+rURsdmj9W3oyipTxSdU+yo?=
 =?us-ascii?Q?tSxaH2Ywb6JZ3A3VPE08pV0f7aOmYHNBvEF58FpZv/DuoNrgIPuCFfaksZd9?=
 =?us-ascii?Q?3rlRYzeUnhxUonpOXMeokE4eOF4N9enrM0boxUQE9hG8Mm3RfDTksooG2jEi?=
 =?us-ascii?Q?FuAtikfNxnrhhx/WDm62j/kRckwRchVZIf6AAFG/UDfDxTLqLSY6BUduxM1P?=
 =?us-ascii?Q?HVoZUkhtb2VnRgtvAPw6X+4U/+zqtvRtSvjQROCitQtgCd5ubumH9sUM23Di?=
 =?us-ascii?Q?Wnh4hbrEMnNwveky1s0MUKI5kA10ubkBvfBfAjYGXpw8QGZmca1F/1K3kUoZ?=
 =?us-ascii?Q?ebssDuJ5xgXUdZOlNO1t8jUKYlwRpk2fbZDAPO9g3EZ8ZFS2wPS0Ei1BR5Mo?=
 =?us-ascii?Q?9Hpxd2JvQiTHtPSxU/aA4MX4wIvWxjx29ighAOJRFNCugU8zZAYFYBsdtmhF?=
 =?us-ascii?Q?9hxT/SuszSHGhxVGeV908J1sjkhS+2gtlirrvTkdX3vlHedvaxtNiu3ZmjLW?=
 =?us-ascii?Q?k8CjKxJDB0fz36jQjzoBe9BiKH0Mb3bzgpOjCAkzoRTOSSJT8Qgzu4oGaSML?=
 =?us-ascii?Q?VwGDF5QxjBbKR2d8ZXLUDw6n38dZYP3a4yzO/sDLXLlc3aLePqEZDj/Skfms?=
 =?us-ascii?Q?2adYP7uJt0TzWOIRwC2xpD13RLqFisesO8vAEgOFo5eYkEIHsedXXS/tunlq?=
 =?us-ascii?Q?U3Ja+IyYk2GdU34GjnCm3Dbi8f0CQ5ow3YTR0NOxlIDf6Zn65o6Xd6jqqxlr?=
 =?us-ascii?Q?gV0/WK3g5VenkotekrKBAZJSDsjt/tiPH9E1fsUvW8ZcmsrmzgO99HfPHwMU?=
 =?us-ascii?Q?Ab7CE+2aeE5Ws5Xe8tV/SMOgfLRN34CEjgdkgpN+xGy9YMN9VW2NHuZskHQB?=
 =?us-ascii?Q?/4NE65k4+mjFIQwKr4a9wCdK8rWiJ8h3uusk9lGr6hGLVPHDLKBnPmINtp92?=
 =?us-ascii?Q?oYr2YHCOQaZ7GcxSn48L9ESf/fXLrJp1NY4jEAeYIUGswb06E8mnpvtML4No?=
 =?us-ascii?Q?bYHgK7NocZvkYESOMqD/IGhwmX8bFTyd1eOwRuXWRwvegj/T+JqALeh5DUQP?=
 =?us-ascii?Q?l74iT+crEemdeZ3vpm6E8h+WCSHui0gLZ6JjA6oCMFltheEB0u2f/WiXCZu2?=
 =?us-ascii?Q?R9ts3xnCavnSL1QHbI1LYMcF7QNuNRjdydf7xhhi9XNaoPmgWVYhQzt5VjHJ?=
 =?us-ascii?Q?ISCLIhW4+xOeq7amX2MUg2lvbXvGX41zN0FxMHGUlQT33wHw1lbPIfk0ettx?=
 =?us-ascii?Q?IcClkC7KNcy4i17w/Om4lsMgakVvlP6reICGf+IKqw/fQ076t2jnrUYp/LPN?=
 =?us-ascii?Q?kjFl3YJW/Fz9+Q6r9dyxurAy4NSaFvWbmQD2TvIFPeUu5eKy9QVVdy5SOnDn?=
 =?us-ascii?Q?NdvtcF1U6B2rgsiQeB1E9vRZwEVdn0HNbTlmc6aaa+//7Z3/90Ff1hQ5Ti/m?=
 =?us-ascii?Q?MQcHFmXN+4z1Xi7fx/OvHhqUojhRrSv85qtYqNkQ2XiZvQrqCEhWTw7oIHAr?=
 =?us-ascii?Q?h+im3ei3DSnIhk9pbFTgWPKo/20y13jjMkQOaaVJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ce09aa-ae1b-4ecc-6591-08dcd888f565
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 08:56:32.6610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECr/6kdHmRrmkfPiY+raD1YKCoiHHteyr8VZ7gYNIINFvYEQSbnlhKhebdm4gyIT1/tCiQ6R/sNITtHIWAiZyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10242

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
is full and can no longer accommodate other Rx frames. Therefore, it
is obvious that the RX BD ring has not been cleaned up.

Further analysis of the code revealed that the Rx BD ring will only
be cleaned if the "cleaned_cnt > xdp_tx_in_flight" condition is met.
Therefore, some debug logs were added to the driver and the current
values of cleaned_cnt and xdp_tx_in_flight were printed when the Rx
BD ring was full. The logs are as follows.

[  178.762419] [XDP TX] >> cleaned_cnt:1728, xdp_tx_in_flight:2140
[  178.771387] [XDP TX] >> cleaned_cnt:1941, xdp_tx_in_flight:2110
[  178.776058] [XDP TX] >> cleaned_cnt:1792, xdp_tx_in_flight:2110

From the results, we can see that the maximum value of xdp_tx_in_flight
has reached 2140. However, the size of the Rx BD ring is only 2048. This
is incredible, so checked the code again and found that the driver did
not reset xdp_tx_in_flight when installing or uninstalling bpf program,
resulting in xdp_tx_in_flight still retaining the value after the last
command was run.

Fixes: c33bfaf91c4c ("net: enetc: set up XDP program under enetc_reconfigure()")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 5830c046cb7d..3cff76923ab9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2769,6 +2769,7 @@ static int enetc_reconfigure_xdp_cb(struct enetc_ndev_priv *priv, void *ctx)
 	for (i = 0; i < priv->num_rx_rings; i++) {
 		struct enetc_bdr *rx_ring = priv->rx_ring[i];
 
+		rx_ring->xdp.xdp_tx_in_flight = 0;
 		rx_ring->xdp.prog = prog;
 
 		if (prog)
-- 
2.34.1


