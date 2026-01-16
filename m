Return-Path: <bpf+bounces-79207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C625FD2D602
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA5523051FA5
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DDF30B52E;
	Fri, 16 Jan 2026 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QZPXht7Q"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4E6337B90;
	Fri, 16 Jan 2026 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549297; cv=fail; b=BCXqc7ZHOWVufPjOqPIEQNVXXbB878hgtpNruh2jc9tmatuO6vLI0Wj559cnWGyIqWtnGhOFJfogHgqUX+vSufLf8HqFsGoVru9D37Zls7fZ26/4UQAB3RSG/gstWUtHsQ1zd9AOi7UXw8TA1rUeY5v5dHdotmXvSApKsn3jfHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549297; c=relaxed/simple;
	bh=jUgQsJhCMBAxOFG0iTcUZndKPSdDdL/izA8wBc9aApE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X+rcG0zOquDovVygnqr3O9/fMRPXJzaAWMVlK3MOj0V8DNNVxzOTY6c5JLmrD4bCbSTsZdMqlLquTPf2fI5MkKSXvDthbwJjSczJxCsuIt7ogkuMBh7ermnfhx3640I3f5YWcYwMFW4o4sBm8AwTrWHkAarL5JGOPrC90Y4dExc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QZPXht7Q; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcLhlP2TA7eDLY/GyCFoeEOXcHNrlXb08dBBhBBdmQa8jkfJVt7uX00cpEOaATEXgz5/itr6dNmncmpLqgMAZ9vwAzrV/8IAyAbitTL0w9FpmqoU7FC7dT5YVlCM6EcUDsYx/q8R/6QD/CZ6CgplkW4u1hr6xSGYfDd2+EhNlGeU0nnt11lIAT/MDLXd35eA1rzW8CQuxB/s3X5WcSkifEz2BIYwTpZaiRmwAZIHdI6t4Yxghkrl96ey8NPeqjZj59moHuiWdaodLL3DcpaqttZn9u/xKeCWBvw2RBoBm17PueI+JRlCO1s0fUgsfS/9vtgBOPAu5DLeJA4Fk3+N3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynKvqNJPP+ATQir+Qql5fJdNXgSNmh1Jc9x59iaszXQ=;
 b=CZ59TSsp4bUBe98E81PnEkdi4/HcXiTxWfLnmqmJQSOTcy9a/CI4X6Kjfcg8csvvTnL1QFmgYcvi8OpUmOBeUgmCE/7HiKRoMKg8prfsshs6PI+m0/IrEyqBvaf4A4S4fYYtE5vrv2dlNwfNqip9Z7PJyPUJ2R+qVZOWJBM6dh9LmgkTxu4Uxqq5sFbb1tjisK8qzDIGyR18YHs7DfZYChO4/KjFUe3oX8Y5uABMmu2LaZI+E3UCkJoiZhIjrdPzyEljhCEq9QwQmZlMc8oa6KtplH7NXCOiRH2yTcpjwSpa7+oMOc3J7QE0oVI6j0aboNYQP6PTrp9Do3iL3BW24w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynKvqNJPP+ATQir+Qql5fJdNXgSNmh1Jc9x59iaszXQ=;
 b=QZPXht7Qo4pmMi/rLxYpFaBgIK0Hw7HgYH3kYw//GEDQrvragVeYOabiNojnMGZSq2cvJtssQjAcVFGlbvSgKELcwGWgQzeT1iphRVBb+6vHZDtn0+AszYn+ugAa4RFC+o5aut3s/qtt7jBQxd5e02eteJrKEsNhRvgclOi7Vzd2kofWPAolMtLGgKZGouJh/i4ijrcwEGrEKhJPgDvn1tNihntbFHwtQ382bnfUUEiP9W8sOr6fMWC7C/0rRrruXYsEsFLtY7BbpQHVMHXQutYFJZjnOuUjHQDO1DKspdvtRArC14jMl439qzVt/8ghlS1hMm1SA3C8L9Ta8dSR9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7390.eurprd04.prod.outlook.com (2603:10a6:800:1aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 07:41:27 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 16 Jan 2026
 07:41:27 +0000
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
Subject: [PATCH v2 net-next 04/14] net: fec: add fec_build_skb() to build a skb
Date: Fri, 16 Jan 2026 15:40:17 +0800
Message-Id: <20260116074027.1603841-5-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 78017ce6-6d4b-4095-18bd-08de54d2a7ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|1800799024|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FC6e2deiFG/nfDFJYaeV2CvgZlvjauiShDhN2V9sh1NuZ0rJLB9FZCXkNkEz?=
 =?us-ascii?Q?4IDNor4Rjc8t2HVjbxwyf0M/FnMn00p9zFj7Cl3pwpQteCmNqPZHxLkdg9PY?=
 =?us-ascii?Q?5DQLzCcb4RZ2gQ9PgAWyz8ezwsYHtBGHi+DyLdZNSD8kkgFBUqr1HNgOUot8?=
 =?us-ascii?Q?4yH6EB+H8I2tRJ2HNibuqc0RhJGVkDaFtWtXvCkuxEM/EQSEuaTdMropsrxk?=
 =?us-ascii?Q?0/Wz9+bgD1ZdZqw0flfIlxs9v/1NN/y0U4HS97v1COMVtmliY35sP7yZFlV2?=
 =?us-ascii?Q?8+RRQx/NmlLbbZiqdygYq/W4+O6RwADnqC7ESwj9JJiFROrOjoGR1VgStGb3?=
 =?us-ascii?Q?YIzk9V1qnkq8Of2nws7VMvjOfQl7Ef4YLaqGrsHS3ChVmv5cbF/yjHsUsIdn?=
 =?us-ascii?Q?xRhmlgPJHENyIv75nJW30KIA/pd7N1wld/3EOmwp+FtsBBXoSHtP7pyQ/A2m?=
 =?us-ascii?Q?B+1a7p/2W17SWMX3lPT/mcaBJV2mYDabluOZVFpjUvGm/Ci7SoFoYQpzQPd8?=
 =?us-ascii?Q?SujsrgfCXYFzWP+pYfyAApTX5LgyyFjyoSnAxBkr62NNOovJKLgCRPpd39AN?=
 =?us-ascii?Q?iuMPDMKakYNafScwD7KXhcGu9WthlGwCKLrBOoGdNNWrPXeSW0qe2RnMf+bS?=
 =?us-ascii?Q?V8B0kW9oG45HV4xLjtw2ihZrWPkz50afn8Z7MZmpcq6YMT6DYnO7Hu5xBriK?=
 =?us-ascii?Q?IWKV0cbCYu8LdmTePfUM4Ka2QYblqTIJDD15ZWbyiwFA8wa3D/OT/t7ypl5w?=
 =?us-ascii?Q?1iI4D1YSWq0K4xYldOriVFd6uBjh3U7EIgNRhu1wThC6PhNiR4emF2qcUNIX?=
 =?us-ascii?Q?XVOrTbj8FKsz+zjS2WWkMAiCfS6ZNMmKbTaP/fAxKTQhE+KWBk+JbPay7EmX?=
 =?us-ascii?Q?PekwdvMs9b8QYg7NY6ZzmP5XBSc5l17oT31OriaSlYeqzAfMvL2XHNzGzeLE?=
 =?us-ascii?Q?q9TszOPCh4De5MFSIW82NmKYirZnwTb7Wggan/LoI5/B0T7ileEoEiChW4kE?=
 =?us-ascii?Q?ELKOk4m1ygDYO7OQPYqIorq3fq43VqZs3SVSZQj3qK+9avBet1VQ/5TCIFt3?=
 =?us-ascii?Q?VvNo7YBZvjzf0/OpmUdJGUZSGKct1VxLa8wMzXIhjG28CIKOHh0nL/0splT8?=
 =?us-ascii?Q?OCCllA77BJKbiw23JAj8Zr25tE+RyURTAGx77dpCVioUDtoFuhyMPTQXerxK?=
 =?us-ascii?Q?IWsoDSKmQJiUaI2atLAF92bSkzycQgZfFohZJ0wCeDnMCM0iYm6Tfvp8cVZK?=
 =?us-ascii?Q?oo9kz4l9VBw2g5tFQ5gLy5RJ8Hc2frsPzil9ZLaJV7jESIoBiNNL54NJ0dfO?=
 =?us-ascii?Q?QKwQHH+PA9OXZoTmKNch/irWMTMewpnYwTgr3RO/7IruMrqEguK8wg6U6QnZ?=
 =?us-ascii?Q?mS8abJlggw5Dk/sg9jzScjKjBGQ1YbbcniLeTGvRM7J4nA0BygNi0Cs/leyj?=
 =?us-ascii?Q?7Gq3lIQRHMiISIzyQ/Y3z5XQCI/pbCkxdpkje+QY8B5M01K6ow+2cjZFDxYy?=
 =?us-ascii?Q?FE0fZBOqQMXYj8lqtsqvbMVpUAbJ1rL+45jYv6dg0efSgzq67avldCQ2pTih?=
 =?us-ascii?Q?tJ6fQoy9MfmedCJ34Z57mO6xf5Vx1wy8kTdz8ufs1bzWz+cSr+cqkZgPnRam?=
 =?us-ascii?Q?0Sb+m4OexPm6e1p9lSedmrc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(1800799024)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tAXHImVREDXojZSql+d859QkFzRveoH92V/nFjPvFLnPuODr5z6l3mJ2MO/l?=
 =?us-ascii?Q?hds8VH3+eFPyccppFGjxUOO4Omdt+2BuPGEvugJoLXBVKruutuCerrdt6mDj?=
 =?us-ascii?Q?nfh2qkYRsYyBJEPQeQlx2M9i2GSm7QL2f4Mq5QsGGcx0AzMlENqi+lr8SFHE?=
 =?us-ascii?Q?Nhpcejbr3Z67bDbxtBqhQDl3vIfX2xJSMNWcWAxI0nr9dFHhRCdytuaq8mmn?=
 =?us-ascii?Q?gSpPam/ujuPCUF/O9sB4BNRhEW/17jzn5LF9dyFR0X/x+BF/uM2xHN5nr6id?=
 =?us-ascii?Q?XY8ggztGpCMA2dfBuBqEwCIk1HwhasKkb3KJL2hD1+wNlQs1DUzySztFsaZr?=
 =?us-ascii?Q?CZHiedj5PrZXRtFU/fykVYp2fMK3N0bk8ZjTelRw9/w8qdyYxD8+b+4UDlgh?=
 =?us-ascii?Q?vCl5tCK6NnXPgQiWd+wdgBE9ds0FWny0lyXAYITWOSfy0T+I5t2+LqRSyvNC?=
 =?us-ascii?Q?279en93r8iEypJyljKiJSgakT9QJtlOJR9mO92/MYRO3jM8kMSgWRqQBnww0?=
 =?us-ascii?Q?V9lEbuvvXP6DDOFALI85TkatCTFcCabbO+R4FztPoaPgrfezoVuWsYDoMnm6?=
 =?us-ascii?Q?AA4JexLXJs6uQi7fBMat5kI6toReXZX6oovwWc5Z8rSKP7NM6g6XWlCsMiY+?=
 =?us-ascii?Q?0681Qrc2XCwkdpW6UTuyjdAV8b7hz0YI0RkDiFo0pLc4A5eXi/+SZVP9+tc9?=
 =?us-ascii?Q?3/lyjdFY7f3GY+1U5M3WiKI7xGls25zZ/CL85SB6BAxEVmnaNXEdq0Jo8aNJ?=
 =?us-ascii?Q?RxAiBFJR+TJanDgOKps7uZ/aVDXjS9VxUbpI5QyeF9IjBj7LzvA3cnGqJxZD?=
 =?us-ascii?Q?BF5rQCCCegDs97Vc3iLYF7AEULuLd5WnOaGDea+5Phy3Yzmpd/6v0nouNZax?=
 =?us-ascii?Q?bTpwnlxXJhZwRnDjA2Tn/zrgKb+MAqrwsHs/QGoxIsUhJamRtcRd5LbDAyws?=
 =?us-ascii?Q?6X0R3wTe22cTh8KTu25dGseDXh+UmWZjacAEQ6bCAWfcQKWHp+BXYwQvb4jh?=
 =?us-ascii?Q?DH83/+IBXkabOlcN8gSlr202q6E+HjURoF5GG81QKwLY9YbdVVogWpmDbu5H?=
 =?us-ascii?Q?e9pKPWoJoNCLR5OgQ+TTdo+L+/7FXm6FYg4gz2cYnKDTa89yC62S+HkvVwNi?=
 =?us-ascii?Q?2OKDdLtciSIT/sHH/v4Bou46IzX7gPSid5oDaMmm2UnKI98LrTS7rPZBV2hG?=
 =?us-ascii?Q?GTVTSgcBlzdCEIgnY+DIzHyYm6lNuqGkM0G6PNPdaa3HUP41DBt+A0qd6QxS?=
 =?us-ascii?Q?tc0CAENRHLGxC55Fu7Wy+zqkS1VC4UTaGX0u3gpTQhfLLsfVSn+6yFgb+e24?=
 =?us-ascii?Q?ZXpyA+wG+Qfi/4YnNGraHcsPEobiVjmX887VywouK4sT8iTmrEhX6YsyuHxI?=
 =?us-ascii?Q?b0Goi6hTSds6Wnvgu8X1xqht2igpTBnBUv+AhMmmeDMtpoE+8kLqkL0LO3FY?=
 =?us-ascii?Q?Us7oCsb6TPn5zVjENHH8g9wUiiTou2arRMq/DgUkH4sCGwlCFmXyBjr2BHQ2?=
 =?us-ascii?Q?6oVPlAsT2XGjneVOx3/jwzO0HrNKEkKEIKr1TnjCblxQ40TTtlRf9kiK6maU?=
 =?us-ascii?Q?hnQZ0csh9dY60iZwRGtA+aMq1LGtzA16t/vs/X/f1P4f6zlXdstpY2AOycjr?=
 =?us-ascii?Q?+Z43xjysxGYYplyzIJjqnPMtE64x14zOe4oZZiahu5bgD2ukgXQZpuKPUZpx?=
 =?us-ascii?Q?thQXQ+UMKS5OwvlZ2aVrQ9EEP1ErCBSZZQNzRFSDoqd5fHA2QbJDTaxCqi7N?=
 =?us-ascii?Q?PTuFiGF5sQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78017ce6-6d4b-4095-18bd-08de54d2a7ff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 07:41:27.3293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryRaz3LOIWjPerjosuT0kj1uzMFw1hjxwmY7vZzuCeufEqPry9rmq6Ix9qWqKAfxtiA1jw+hVzqyL+rWz5fybw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7390

Extract the helper fec_build_skb() from fec_enet_rx_queue(), so that the
code for building a skb is centralized in fec_build_skb(), which makes
the code of fec_enet_rx_queue() more concise and readable.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 106 ++++++++++++----------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 68410cb3ef0a..7e8ac9d2a5ff 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1781,6 +1781,59 @@ static int fec_rx_error_check(struct net_device *ndev, u16 status)
 	return 0;
 }
 
+static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
+				     struct fec_enet_priv_rx_q *rxq,
+				     struct bufdesc *bdp,
+				     struct page *page, u32 len)
+{
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc_ex *ebdp;
+	struct sk_buff *skb;
+
+	skb = build_skb(page_address(page),
+			PAGE_SIZE << fep->pagepool_order);
+	if (unlikely(!skb)) {
+		page_pool_recycle_direct(rxq->page_pool, page);
+		ndev->stats.rx_dropped++;
+		if (net_ratelimit())
+			netdev_err(ndev, "build_skb failed\n");
+
+		return NULL;
+	}
+
+	skb_reserve(skb, FEC_ENET_XDP_HEADROOM + fep->rx_shift);
+	skb_put(skb, len);
+	skb_mark_for_recycle(skb);
+
+	/* Get offloads from the enhanced buffer descriptor */
+	if (fep->bufdesc_ex) {
+		ebdp = (struct bufdesc_ex *)bdp;
+
+		/* If this is a VLAN packet remove the VLAN Tag */
+		if (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN))
+			fec_enet_rx_vlan(ndev, skb);
+
+		/* Get receive timestamp from the skb */
+		if (fep->hwts_rx_en)
+			fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts),
+					  skb_hwtstamps(skb));
+
+		if (fep->csum_flags & FLAG_RX_CSUM_ENABLED) {
+			if (!(ebdp->cbd_esc &
+			      cpu_to_fec32(FLAG_RX_CSUM_ERROR)))
+				/* don't check it */
+				skb->ip_summed = CHECKSUM_UNNECESSARY;
+			else
+				skb_checksum_none_assert(skb);
+		}
+	}
+
+	skb->protocol = eth_type_trans(skb, ndev);
+	skb_record_rx_queue(skb, rxq->bd.qid);
+
+	return skb;
+}
+
 /* During a receive, the bd_rx.cur points to the current incoming buffer.
  * When we update through the ring, if the next incoming buffer has
  * not been given to the system, we just set the empty indicator,
@@ -1796,7 +1849,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	struct  sk_buff *skb;
 	ushort	pkt_len;
 	int	pkt_received = 0;
-	struct	bufdesc_ex *ebdp = NULL;
 	int	index = 0;
 	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
@@ -1866,24 +1918,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 				goto rx_processing_done;
 		}
 
-		/* The packet length includes FCS, but we don't want to
-		 * include that when passing upstream as it messes up
-		 * bridging applications.
-		 */
-		skb = build_skb(page_address(page),
-				PAGE_SIZE << fep->pagepool_order);
-		if (unlikely(!skb)) {
-			page_pool_recycle_direct(rxq->page_pool, page);
-			ndev->stats.rx_dropped++;
-
-			netdev_err_once(ndev, "build_skb failed!\n");
-			goto rx_processing_done;
-		}
-
-		skb_reserve(skb, data_start);
-		skb_put(skb, pkt_len - sub_len);
-		skb_mark_for_recycle(skb);
-
 		if (unlikely(need_swap)) {
 			u8 *data;
 
@@ -1891,34 +1925,14 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			swap_buffer(data, pkt_len);
 		}
 
-		/* Extract the enhanced buffer descriptor */
-		ebdp = NULL;
-		if (fep->bufdesc_ex)
-			ebdp = (struct bufdesc_ex *)bdp;
-
-		/* If this is a VLAN packet remove the VLAN Tag */
-		if (fep->bufdesc_ex &&
-		    (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN)))
-			fec_enet_rx_vlan(ndev, skb);
-
-		skb->protocol = eth_type_trans(skb, ndev);
-
-		/* Get receive timestamp from the skb */
-		if (fep->hwts_rx_en && fep->bufdesc_ex)
-			fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts),
-					  skb_hwtstamps(skb));
-
-		if (fep->bufdesc_ex &&
-		    (fep->csum_flags & FLAG_RX_CSUM_ENABLED)) {
-			if (!(ebdp->cbd_esc & cpu_to_fec32(FLAG_RX_CSUM_ERROR))) {
-				/* don't check it */
-				skb->ip_summed = CHECKSUM_UNNECESSARY;
-			} else {
-				skb_checksum_none_assert(skb);
-			}
-		}
+		/* The packet length includes FCS, but we don't want to
+		 * include that when passing upstream as it messes up
+		 * bridging applications.
+		 */
+		skb = fec_build_skb(fep, rxq, bdp, page, pkt_len - sub_len);
+		if (!skb)
+			goto rx_processing_done;
 
-		skb_record_rx_queue(skb, queue_id);
 		napi_gro_receive(&fep->napi, skb);
 
 rx_processing_done:
-- 
2.34.1


