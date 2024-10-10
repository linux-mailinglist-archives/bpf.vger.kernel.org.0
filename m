Return-Path: <bpf+bounces-41556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CC6998274
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 11:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3293B264E3
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 09:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66E41BF81E;
	Thu, 10 Oct 2024 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SCsr2laJ"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3A11BC074;
	Thu, 10 Oct 2024 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552960; cv=fail; b=b3hG/9RpauTPyP66GY7CB8TipkHmT+vGQEK6J4a5hMS8JxbY1jnx997BRk9+nhQfUz4aqBnPNkFhBQ/JLK2+8hCBaQkauZxrdcCKOBhrKcXbdVaNjOkvNxn8IVCgt05ZswmPn9/u8xj22tCdPqJHO/KqsoX13+eX22OGo7x1x5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552960; c=relaxed/simple;
	bh=PG5tTHcfBglgmg9je1jOI9O7TLIUnVlIuoVxAEH6Jm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ew81s8MOPjlBLh6Yodqnj5QjrxOxHUh/CkKgrXTh+ZToYwLEsBvt6LAymEZnIoni78aDVKPNsUDnyRcSiYbViOQfpbjBezkG0L5Wa/0ga5OEodYJdHSg3vmv9MiF7yzyujAHFj5VbiC8Q38Zn07ajjwBIilctkBf5mtZghF7sCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SCsr2laJ; arc=fail smtp.client-ip=52.101.70.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DA9yXx3Mn627LNIehy0iBZK8NjyfbgWTcNV0hLxocSq1ssdgjc69G0/MH1p4QWBXTMcjWR5J0Hh17EFbxA38ipcIY1wDFJKPiIDWilhK6ez5sKbeZiQDfC6LCv3MwkCcTcF89hxif6qN9ZwiRSZOujGYewDrmn8KNmDP+7Wv6mc53Vfiyw3ZAReSE/6d9dY8i/WZvjZ8ia9jh/Qwi6UnIVG3BYVJDSQxucg3bXh9kf1JUJiUAXKFxMG4cHWpewmPqucTX0hvZdgxSKpSF4ya/ElSU6V2j3WP0bj+FlnPcl2fviYQ/ZjVGB2cV0Liu5NPIj4KLjt4qakjo+/sL6rKGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yl0RmtvtTuLVkZJv2oC6KenI+lgS4OMopBKhZ+sQYw=;
 b=tLTHd5/ehezSMnUyHx9g00O4sNBkFrNZp5tU+afeJLUK00umyr6A72qpZpBkogTV6sRAxuGTW32AqBKGmOEwnzgET6IGRvinkj8kVNTSFU9X2bf9AUcEnlVjOkB6hj8vvQq43AE6UexpwY7F9RXV1yNjpiZZB3GKmxGbAZBbZvn3XwxVRklYhhPe/jADE0jHS9LG3uTjlrfPq11dDQ1frmENdTYI5zA6AWBaDX3f1TZyZ1tM7An48IMvyCUZUFaAatSA7lAUaEi+3nIh4DLQlkffH6BZXWeCNuOEwvp30OqlFk6VoM0Ib/yi2GqGrAp6OphbARUlHzIGh9rzN8sJFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yl0RmtvtTuLVkZJv2oC6KenI+lgS4OMopBKhZ+sQYw=;
 b=SCsr2laJVdr8+iAzjmMgZ/Y9RAUYeeM+e4V+kyvjAuEtuEeKiyNm8oVr2b/adLy0JEnSayMSLAvByRfFDAtNrKdebrXOf4UFQyTbUfOa7A+nYuXRA9QkWSWrby17ZxrIdQ4C3GT6FpWKr9ru1dtlMAmgQ6GI7pyjkUHHKVfXDE1nqM7pVQdIKsbFgULCO0dvsUBFJfB/3OdmMNx2HuULpO588R4u+7MU4Rowc1fdwb81OugNkSAGfOjCn95r66yVDgw9ESCRcHDgwloghQl/6iCu07HEVC4+3AuH4CmrJ5yvLFR/BihSTSJIVmXzexy+TyDYiW7gRI51XxrZFrumzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10856.eurprd04.prod.outlook.com (2603:10a6:800:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 09:35:48 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Thu, 10 Oct 2024
 09:35:48 +0000
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
Subject: [PATCH v4 net 3/4] net: enetc: disable Tx BD rings after they are empty
Date: Thu, 10 Oct 2024 17:20:55 +0800
Message-Id: <20241010092056.298128-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010092056.298128-1-wei.fang@nxp.com>
References: <20241010092056.298128-1-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI0PR04MB10856:EE_
X-MS-Office365-Filtering-Correlation-Id: b17420ad-cab9-4c02-9d0c-08dce90eec11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?onSs8YqWf5QpQxGoa8MDYjQ33bjn1RzBxGxQ3usxwuc9IyV7Z9d+g9h0TtX5?=
 =?us-ascii?Q?VQLMJ4EGKINiFSeNtfz3opyURGkFPrZQoRf3JRKyat4NA9BxJ05hBnsLqudG?=
 =?us-ascii?Q?pr9Gjm28P/Htdu5Awm5BIRy8asB0S+cVhUJObUzxkhrVVzeg1ndSvZuYxlf2?=
 =?us-ascii?Q?Xtf9e0MNY5evke1YyeMdWitiPtz7uTDRXERd7jCuPw2YbTF2xosyXc9G/LT2?=
 =?us-ascii?Q?e1NSWU4MYrp7YroBIdJrEM4+t038aTc8u+xiP2puHfPs/iK/KygGfevQEW86?=
 =?us-ascii?Q?luh98mK/5SkAut4Lv8nMouPnPE8jKVwG64o5z47j64KnHxWptw3eJG7M2qGl?=
 =?us-ascii?Q?h2V8nK7IVgdJUlJdxtUW1f/ln63tQe7Ws1V5lOytJ7gHNq+Ezs7NYQSWY89u?=
 =?us-ascii?Q?XmYu7paOA42UVfk2bq4AuSe8Ybo9F0CS/GnRmJ9NU2uOOToqgj0z94aumyTd?=
 =?us-ascii?Q?CIggb2bRNYFbSJtTQ4C9iO5Wfui2C5XymU4uxKyct8rFPcsOPwypQdOE8pdC?=
 =?us-ascii?Q?uDc5WMMIb7B6oi2YwBzk1b4mVBCUQ2oUPMx+lYd6Qm7sTqheW+eJjY2Kc+pS?=
 =?us-ascii?Q?Lj4OMtXWZswQ1zO4vVRFL9d8Wv7FpEBGoqg0xeyDMSaxPHxR0Lxwk126dZQO?=
 =?us-ascii?Q?+BnrVunt6yz0c92vpn+q1vv21zBQKLP1/my+YV5thOjMn9fyvaeE09zm2MWg?=
 =?us-ascii?Q?nT+y1PWm2P+0hbhRxyBORd/hw9r0UZ09O5gpZMQmURs3naypFKgQErMyJeJH?=
 =?us-ascii?Q?Xd0nM93Oafjyk6WX2CQjFGsSCSlOC1OXeKL7JIcZQk/Ebd18A3ObkChmrrjN?=
 =?us-ascii?Q?gG22dPIJGIdJOKfq1cDTKnZYgr/vzlNt/OvAdhWigG9iIasQvjcHg9aHoqmG?=
 =?us-ascii?Q?X3uU4nKchqg6T+Z0vy/jluXcDydjjLWQfW7iqQ2HgQpgr/qrbLqjTksnMWIn?=
 =?us-ascii?Q?t6FPjdoXoW51/8dYzhmZuzhOyW4pkDnDazqHqXKzlTbfQ0LoMi1zEy5oPSjp?=
 =?us-ascii?Q?j6bsORuI12RlNb+zbsmG33lpvP4kHf5dNx9zG5p0Mz6+OWi6AOhHfXAfnGW8?=
 =?us-ascii?Q?2AjsVja5Y9P/sUvU1paEEXvP77PxgLwWaLhEldLAB+dQZuSIdsoAt8/XFc5R?=
 =?us-ascii?Q?tw8r4Tl5+WksDi9sqp0RiF1uo2Fi3hn3Qc4WPXWN/168Y1eEhwnQLO6pR7lz?=
 =?us-ascii?Q?a6AC0dolCJnK0RM7xwDD9oN2gVQ6Iqn/dxVFy88wJy/UUfw5j93PEfu7CQkr?=
 =?us-ascii?Q?aDZLKsPfS4ro2DJTiExGyQyonVgHOxc+xqpQ0MkNwlZZAnMG7VAJOc1BnZyS?=
 =?us-ascii?Q?t+tNqGMUNiSTQ4ciyQTSghAO3ihkAdoMs1hgPxcyoezP6bS2i5hf4vm8W44I?=
 =?us-ascii?Q?nfEPdHg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v1lO0y0x1BDkMZH9uAEgpY5lyO1NYBqYG3Yh7R1qEpfs+i+3duO+zff5jKw9?=
 =?us-ascii?Q?iC3Jwds6GzTqzldANk6rcOWht3zkNmGKXqq8kaX9R66ZY/rjKMT5L5F7rJJH?=
 =?us-ascii?Q?vh7zE0o+wBB2n7XxcK9Sv8Xn76l0OKXK0vlbXuAHAu/I08XPIOcKBMGOckL2?=
 =?us-ascii?Q?Hiz1tgfIwS1lWCh1uuOVUwKF2oO4R1Srsm+nmW32VpbxBWMain52sHpw6NhA?=
 =?us-ascii?Q?Vyn941SNjKx7aJxgLRbcyj1sI3ne+WSW1bshNI0O9v6P0Cgdeaf0FAQPr4Ww?=
 =?us-ascii?Q?UDLjPH+wxS49PauELOTlPhQF/5bQTJvjTj6bW6c0aiK/nIOP5x0dcTBA3hyt?=
 =?us-ascii?Q?76PvU3J04HJ8d9LUWxWrlMLxvq/Rlycq9uK+8+IXIxq2IuRiNQyTdc1Qe1ub?=
 =?us-ascii?Q?GYTRYCor+OCKCxH+qT3y1Cshyz5FWiHheatDwd5EMq9B9XP1oqgJHehuoja3?=
 =?us-ascii?Q?ZDICoxFhHn451sjcpB2swxoy4+KJH+5u3AtRSyWfY0xmelqYZYKTSyucloRV?=
 =?us-ascii?Q?7jxvSXDnIQbIRTU3UL8HI3vQ7It5Wf7NvrrPIfv24Qp64rGgHAr7J7SrHcdT?=
 =?us-ascii?Q?4lZxTzdSExeXKyB2cpkoB/rdbEONEXeqjVEq1pejJYs2RLVg4iCgK4zMnTBq?=
 =?us-ascii?Q?5dnoQ12YYLQICATk782r95VAehJ93hmqxCTOyRL6vC01/s/BAFdXt9weO7FD?=
 =?us-ascii?Q?0v/3ieUkn9CDTeATFvJHsziYiXsC/XEJ7wIsEOhVw4u3y/Vr0oI0Y4rqzh9/?=
 =?us-ascii?Q?8oAcxh9/A9QFxcQ35pdxysgzLwFV11YQcE1yUIVfFoOtWFFwLZCDBK155ACK?=
 =?us-ascii?Q?YLTtYhkszOZkgAd9IoOhMIJUnO1ryiuQRhnUxIjMnxC3TVodc1N0c3opZFCb?=
 =?us-ascii?Q?7A44Fu+mu3Ct1GtDZ2z/fdlq/GxqgK3rD9uBL1SotB+Rp1emDSBvWOEGM4yp?=
 =?us-ascii?Q?V6FlvOU9CsZQ/sFUhxq5o1jzZpQ6WhQnoNbJ0S16TPspyg7XhkCtjs8gxrYY?=
 =?us-ascii?Q?KEMesHiY5tuucA+LiRB8ekuC00wssNpUVlrhp2mO6DFNGblC1cS8+QgWGLtn?=
 =?us-ascii?Q?9z8S7rVk7nvYiMxgQsyQ/9BIeFu8SmgpfIlfSbBcugOgGx62Sn7zt8soKNKC?=
 =?us-ascii?Q?WNUrpzsRvqj7L/BndQEoS57FpwVRbN+fipsW2+43jHoKtctFLO30wkssfDQq?=
 =?us-ascii?Q?P9b2gM1FyYQPkPQQlsvv37hSpb9n0bPx3kENg29gAvxvpRhS15QVvLkCGP1E?=
 =?us-ascii?Q?pBqmmSwAHyBKqRZ5plUuFftS1WTuUB4Wy71PuYYTI9yNxQSFlZbpo/FI/U87?=
 =?us-ascii?Q?ZuIh42sOiy+UWJ9ysjhQv2xmeILKjsKGB+PvTlrmN5VHjvCU8HBxkm72blKM?=
 =?us-ascii?Q?p6iP8RwizOB35vcCWiJQFZ6Xr8xgwX9RhYoZPR7IDMaW6zaGA7k0XPicHjoT?=
 =?us-ascii?Q?N8MT/zPDdc7I543WkYKxfjVT5a5UPZgByihZezyDZtQNY9YWIWl/zJP5YhGX?=
 =?us-ascii?Q?z9bYEZQvPM692isqvN9BqdEtNnivyKRn6FXhT+i5VBg9DxVsmnQGWjGKBwPc?=
 =?us-ascii?Q?zv8sJNVuYMgaNPtfX4TMTsVzaOLWI2sf65RI8kZ8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17420ad-cab9-4c02-9d0c-08dce90eec11
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 09:35:48.1094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWgD7vAQd7jU6aWHiMuir3suSaPzP24olaNI0aAZLYkOLyIoZOd1J6nM/fdTvgBLrgvLrjvBYEvO8AQxThRGMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10856

The Tx BD rings are disabled first in enetc_stop() and the driver
waits for them to become empty. This operation is not safe while
the ring is actively transmitting frames, and will cause the ring
to not be empty and hardware exception. As described in the NETC
block guide, software should only disable an active Tx ring after
all pending ring entries have been consumed (i.e. when PI = CI).
Disabling a transmit ring that is actively processing BDs risks
a HW-SW race hazard whereby a hardware resource becomes assigned
to work on one or more ring entries only to have those entries be
removed due to the ring becoming disabled.

When testing XDP_REDIRECT feautre, although all frames were blocked
from being put into Tx rings during ring reconfiguration, the similar
warning log was still encountered:

fsl_enetc 0000:00:00.2 eno2: timeout for tx ring #6 clear
fsl_enetc 0000:00:00.2 eno2: timeout for tx ring #7 clear

The reason is that when there are still unsent frames in the Tx ring,
disabling the Tx ring causes the remaining frames to be unable to be
sent out. And the Tx ring cannot be restored, which means that even
if the xdp program is uninstalled, the Tx frames cannot be sent out
anymore. Therefore, correct the operation order in enect_start() and
enect_stop().

Fixes: ff58fda09096 ("net: enetc: prioritize ability to go down over packet processing")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v4 changes: new patch
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 36 ++++++++++++++------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 482c44ed9d46..52da10f62430 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2233,18 +2233,24 @@ static void enetc_enable_rxbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring)
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
@@ -2261,18 +2267,24 @@ static void enetc_disable_txbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring)
 	enetc_txbdr_wr(hw, idx, ENETC_TBMR, 0);
 }
 
-static void enetc_disable_bdrs(struct enetc_ndev_priv *priv)
+static void enetc_disable_rx_bdrs(struct enetc_ndev_priv *priv)
 {
 	struct enetc_hw *hw = &priv->si->hw;
 	int i;
 
-	for (i = 0; i < priv->num_tx_rings; i++)
-		enetc_disable_txbdr(hw, priv->tx_ring[i]);
-
 	for (i = 0; i < priv->num_rx_rings; i++)
 		enetc_disable_rxbdr(hw, priv->rx_ring[i]);
 }
 
+static void enetc_disable_tx_bdrs(struct enetc_ndev_priv *priv)
+{
+	struct enetc_hw *hw = &priv->si->hw;
+	int i;
+
+	for (i = 0; i < priv->num_tx_rings; i++)
+		enetc_disable_txbdr(hw, priv->tx_ring[i]);
+}
+
 static void enetc_wait_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
 {
 	int delay = 8, timeout = 100;
@@ -2462,6 +2474,8 @@ void enetc_start(struct net_device *ndev)
 
 	enetc_setup_interrupts(priv);
 
+	enetc_enable_tx_bdrs(priv);
+
 	for (i = 0; i < priv->bdr_int_num; i++) {
 		int irq = pci_irq_vector(priv->si->pdev,
 					 ENETC_BDR_INT_BASE_IDX + i);
@@ -2470,7 +2484,7 @@ void enetc_start(struct net_device *ndev)
 		enable_irq(irq);
 	}
 
-	enetc_enable_bdrs(priv);
+	enetc_enable_rx_bdrs(priv);
 
 	netif_tx_start_all_queues(ndev);
 
@@ -2536,7 +2550,7 @@ void enetc_stop(struct net_device *ndev)
 
 	netif_tx_stop_all_queues(ndev);
 
-	enetc_disable_bdrs(priv);
+	enetc_disable_rx_bdrs(priv);
 
 	for (i = 0; i < priv->bdr_int_num; i++) {
 		int irq = pci_irq_vector(priv->si->pdev,
@@ -2549,6 +2563,8 @@ void enetc_stop(struct net_device *ndev)
 
 	enetc_wait_bdrs(priv);
 
+	enetc_disable_tx_bdrs(priv);
+
 	enetc_clear_interrupts(priv);
 }
 EXPORT_SYMBOL_GPL(enetc_stop);
-- 
2.34.1


