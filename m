Return-Path: <bpf+bounces-79204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C69A5D2D64F
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79A3F30C6646
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEE93370F7;
	Fri, 16 Jan 2026 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H2ZzA0V/"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E732313E1C;
	Fri, 16 Jan 2026 07:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549280; cv=fail; b=pX2laRChLNo+8usZXz+J/OKUTPbkmpH7fJlPg9uj67Qtoi3PqdSTYBVm34UCOyJpWR2g8TVifmXk0clsAOWIb7gj/3yqn51nlrRjSI+7fdFRlsisS+nNpGkF1qwGTgF7qt2ACFjKXe1JjnAleRiNtuPvF8LK/x8dmX+sYvH2+a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549280; c=relaxed/simple;
	bh=U0A+x8QYh9ktZt48s4Xj/yNkUNriyCjzn/YD/YzIGus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Obcw7iKOUakbQWUH+VDl1QMf+9MjjFPbbNRP776y2G9KL5xrzEg9jhY/8n+KK4O6nwLKCsbji+27kz6HZAYsLscXJMrJxJ1+dWk1Ah/iDwuzlxlxzaMJs38NKc8CSgGBaI+DX3S3TBmoKqlKc5P8ygmcRrdCKl6jL+jr39grLmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H2ZzA0V/; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hS+eZbxvs3ZYgRZNyYXqOTTNNQslYhePpcxR2oC3RlZaXDBvCpRt3iIAbsDApaZsTkZf255uwP7CPCQHXqJuIrpQ+6kVBpjhSo4Mrya2g91bkBGKMNEM8/q9qxg9ATcQku+ShJXoYuiq5IVvyVz6l/10z9oE1sdXqzJU8ySuo+y+LDcgfgl1cVbtiUib8CqQi683E7g+oxdQxamNB+W4TiYhLdlFaooMfk0E4ULrKk8TxVCbBlGnPs7qdy9onHzac3Zj6jCI1LXiieemNGILt5fPFs1LUpC9n9InFcTrrZNl8viSam/cFuMI1rQXjOgGeAhogWzgZWL3MT1hI39R4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJth/+o77dQ5OhWnXLUdF+IpIMi1Eyqp6UHQhKEdstE=;
 b=g4OLbgD83es6MB9amAbd/eLRhKkf6pdeDMcRqZzRdExv/lLvKmd+T5MdO1yg1kL3W5S70VAyWvA1zAb1c9Pbn/6AES8D5hcgp1etox298WU05x9+iHzf220HRM4IbSRoXuZ3z3w+FCaRRy8obNHrM2uJb/x+s5b5sEODS1TAhGmB1JrAUmQAOcqqdqUkk3EEnuuc5PSbZIpm8B5h+F/ghpQ9ojx4rMBs/RGsJt69t/ZqqPrBV0Nu4Md3OPtbHmyqZkodtrtEwjirh7ufJP3oZej9DWIp0U4BplPTlSjEbyhDYCjt2JNK2me+ZUeiTAT1vSRm5d+YVqtQuquEHmXxew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJth/+o77dQ5OhWnXLUdF+IpIMi1Eyqp6UHQhKEdstE=;
 b=H2ZzA0V/+cVpcGQ+FOn/THljFwj0rhxVLOg2DAvSr4eg3JLyGg9pgYj0014bfXbqRLNQxmkYx2a1MruCYlwnChleDDXh5yCfmg0ADMFWOfsnZEHpoIAPhB2whHqr49sA2k7nr42y8sEnBG8LCb/knJ7jrpKZX+HrvcTXVYUjAXpJenPZiPKJ096xPTRx97vic6NrOQ484qU3oenh7AaQk7Pkh1kwU3V2mxF/K4N/kxjOoSQ7DPWaZjngzCBDUcbw+ixuOQr2Pc3knwVJcYysuNUG/fDdaaZfBdr27BASH7CMo6XPU+1MUUvKYqnLiLJZpjYjWUSz4IoQuza0iw4vnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7390.eurprd04.prod.outlook.com (2603:10a6:800:1aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 07:41:13 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 16 Jan 2026
 07:41:13 +0000
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
Subject: [PATCH v2 net-next 01/14] net: fec: add fec_txq_trigger_xmit() helper
Date: Fri, 16 Jan 2026 15:40:14 +0800
Message-Id: <20260116074027.1603841-2-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 846ffa2b-03c5-4193-7123-08de54d29f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|1800799024|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QdvyQZX06vwtHURmbMhDsvefgxAjd/6z1VHLs7ocRMn5hlfPvvnlog7JV2qd?=
 =?us-ascii?Q?YMsKGqRB/v70xFScx4NiLX26D6iTT3HJgIQPH1xVjVj5hDZ2b7VXdmxCBOWt?=
 =?us-ascii?Q?0iIGiQuC4Z7BAzr1dOjMH3n2OsmOUcRFkzyiIJSoSwfQoyLxhiUEjQqTDu7A?=
 =?us-ascii?Q?u7Q8jMVmd1xK9ogyALwFkXxLVTe3CJjC85zyfcvtPDbxdT8nhO1dLuBBWpbY?=
 =?us-ascii?Q?fB+b5b8i2Qp4yoyYBohXBFPgmrHSq3EM3uiJTKMN/z8Y5Ot77XB3gi6MJPIL?=
 =?us-ascii?Q?o0bHvg3Q4KteZ2g5R/KnKmEssjvSTN26vJp39ZjQKEacGEb3gteFhoUYjiCv?=
 =?us-ascii?Q?L9swgblUh1QRuCbveAsGOqq0pKTX6egtW7D7VKnM+xuHPLsV9HctoFpYCDSf?=
 =?us-ascii?Q?x98LsjbcDldxhNpyra/nG3KAC5Uuu/xDdkJxv+bNCadaUSOphlxR5y/FYshb?=
 =?us-ascii?Q?eNZ9djAoLHIbYqZDyvCCXNz0DMNR/ssbWPst+Ex3acTfLw3XoMS14bpUEcSj?=
 =?us-ascii?Q?sd4E3Nug4mpHUq6Am9+s1OggqTbYRXZ2Tz+4v9hayEUxjM2EDABnUaaxw2Vk?=
 =?us-ascii?Q?FWJHxqJnUe8ZT74hs9Xi8Xyuz0vq+hNqkuqs4c6vZQ4EH6Tity7Nsr3Og5n0?=
 =?us-ascii?Q?pitL2N+5GVgHuSdWB3ihfUfdDiksp/g6mljtMXvQDvF+rdd4wvIRhZz8s6FS?=
 =?us-ascii?Q?1KyNKTueyKeB/OT2RTY7a10KcFD+9624NdYhR3laWa/WIWsOItZRc0AE62IE?=
 =?us-ascii?Q?fUBAidkVtt1xdvIKszhcvLtVWXpYfq81qJndNRsFJWrpwnv3G7kl7fuB8yX7?=
 =?us-ascii?Q?3N90eLRRUtHHAEXKdOPr7Sl3TWcTaypKvRokVWL237bQkrE2cjVVEgu7iOix?=
 =?us-ascii?Q?klZU8S9a8Vwmxr4qXSK1GWv3De39F2T8dN0oZLmUnbpPHQJbJz+MvJucP6Nd?=
 =?us-ascii?Q?k/CguYu7F3xe7sQFw7pzs+4FWcZw27I7jTWUWy+Uze6OUEeMF3VrqkNtZwI+?=
 =?us-ascii?Q?huuV4ZFW9SKJRo1cGXg81ttXiZtFXBnM6yNYMdDuvPnuAFqOpeZYrmPG9zb6?=
 =?us-ascii?Q?Dg/G3bT+k3ixUbC9PXJvyK/XlBbKYQ6cMJ+21sfxQw7krJ+bAtsqg8jv+XrS?=
 =?us-ascii?Q?dhTg77qSoj6dj9XyECBYI862AD0yusivsFBPn3OProW1Gp2ZdFKaX47WaifR?=
 =?us-ascii?Q?z+bUvT11b8nRbJjwzkvEahgxeDldZz8e/6GqAy4irAWy+G90/lZ7FJNjlcAM?=
 =?us-ascii?Q?+Yij5jEPJj6yH71+xOjtfDx4n2hz80PzJ9aPx4QtHvbL0cgyqkMXnot5dmYH?=
 =?us-ascii?Q?Bp0618kFf1cOoJulv1swXQXxgZ8MAwdnCSiIRqf1UrViyKmEZ9wbpda04xg/?=
 =?us-ascii?Q?1SKNLA9PkridGxEjJWdPl2n/MfNk7hSAEDTKzxmRJ+EOUFLk7Kd/HPNW62Tg?=
 =?us-ascii?Q?waRwfNynnOpqQ2rfUZM3eizPl4tuNkmqpA18xpmcN/sUnF1iWZDkEKnPs01Z?=
 =?us-ascii?Q?iQG1qR7Mopfa0r9WL7JpQn081ApoCFr6yWyUPQZTgjsjGjDsyYjfKPms00Ui?=
 =?us-ascii?Q?/1sgGmhc//OR6jUw4Rj3v0bHQbV2GlzHSOELfmVMccgAyTmCW6xLYHVtMXsQ?=
 =?us-ascii?Q?Jh+JBC6v7zFEgXhI3URAD6n8wOxteAADJbnQvGaofsUr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(1800799024)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JgCyTCkuvR8Zcqn7Ie9B1s2KCFKtA1x3ZQONdXQ2V3zmuH+aNbdg6TGXcOgK?=
 =?us-ascii?Q?hnrXkVykl8F8uW9A74y+q1ouCy1T0c5fohPXGNcPZH2FLRo3K5LYOewVb4d1?=
 =?us-ascii?Q?miklljFCICf4kHwtT/61PDEScp66bUiw7QWms6TM4acaXo0bWbTIYbmurt/w?=
 =?us-ascii?Q?4GKck5wPLMaj4yrYvgnpowqoRBsqhW5AYO94s3IewTnwc3aY7/UpYe8GSjzT?=
 =?us-ascii?Q?+jbNMu1/gnnvskyESNLz0yUgngjxVI/8zgbd9a76plX/KAXaBWHd7sw1pekc?=
 =?us-ascii?Q?CZzExTBmljAyQC7UvNC82puqFrN9kYUglis/ZYZ9lkk73NImrJmjJMTXtwYs?=
 =?us-ascii?Q?y3nAavFZ9pcTfTO7yBQeT6uv+VZUF4uI9iCVBiLLnLmZeEpvKibA3jw1JMLN?=
 =?us-ascii?Q?JP1rusG85DdQHXVpu7fDcinV/j0VYy4B7dNjFaNDoLIKuFYMingVb95ih0UP?=
 =?us-ascii?Q?qNfo+wogZ6nw4oVpSHJvPVLmNOOpOaWMC8QD9NDC2pY4tO9O/NWd/uHB4DxQ?=
 =?us-ascii?Q?DKR/Jx8liFGvzGdn8TYKXghf0uNw5BIivnhijQcmrdDHnCTQE0oiFEQa7uMy?=
 =?us-ascii?Q?BsRoL2OM5wTIV0ozyNMQtPqjzTcriA37XcoOY4vAgMKUwNzKKO84u0vHI9E3?=
 =?us-ascii?Q?SgHiETDw4RPGVUk6jysYgv5zzCwyQMbcn6qoDceW4+6bIgKiCLwlHtD844G2?=
 =?us-ascii?Q?nJtvPwAS4bwOesLIeprWOn8vIWcAMbirQ63DtslbSCaUZNq/QMTaFr5DzCsC?=
 =?us-ascii?Q?kn+RoHiFnE5JiB7Ox+D8MaDjsTGLbciCLRSKNxFsDww+1vAhGaHQS3ajeBUF?=
 =?us-ascii?Q?AZ2TOQfYQM6A3bymb1N+5/CXZAsqAWS1xdl3Mi3Q2RYpqW9Uq4RuACxIcJeO?=
 =?us-ascii?Q?Ne9Dg0BXEB1Y38dEtPPByKDnKS8wURaBQ+HXPzddMWQdOZsaylkisGE008ML?=
 =?us-ascii?Q?izSxu4YPRAF6rK3829FD8FI+zShtRef83N4f/dNovo1qp4O3d1Ym5THL1Kwj?=
 =?us-ascii?Q?o7TmrE8XvN78ENzU7dNsRmTVpXnkgHd22xHIxg0X34rqMinq4ligvAUG/7Vx?=
 =?us-ascii?Q?NgNbrES1maSX3Fx3KKkyzgCNGhX67RIF1NKLWgjKGSvx+WXNoBb8FvzjkmgL?=
 =?us-ascii?Q?3rWoSpPhD7H8/SBxVfCkGUC2mOKIZA7vflTgEPIhr0DXrEyhKC9OUFJl0ErS?=
 =?us-ascii?Q?f9sD9cJFTOYFYEEf+t5zZ+DbeBvU873irnAuLhUFUxkk5omKpLHHVdeJQS+L?=
 =?us-ascii?Q?QDBooL08xJ4betT+6qbkbrKsSxLEMMUzkfBSJX/z/je3pGABDa5nr9ryg4xn?=
 =?us-ascii?Q?N+scQrALNFYA6AEdAD56VQBUrOSLspVRaOMXrWYuqq0wW30/eI2x1ek1Ufl2?=
 =?us-ascii?Q?3x8XyVGt190L1ZthpnPimMlNTzYJ7DI6RTz/NW5jAa2DgVNERndWjjMuQ4kb?=
 =?us-ascii?Q?dr0QlkscY2mvX3IUszjXQ4zJRs5h+z0jpiImCBcP3AwzspScZ6yRqnkbCxOb?=
 =?us-ascii?Q?nRrDs+OL/IIHGEY5a5bgKoQRZxbKRr2NfuCcGQnMnm/EXeXQoHrPKuvTsrY4?=
 =?us-ascii?Q?PANO7Y4DitxBorxRRAT3WmHaDiEFCdjoZ653EqvBPE6KP9J8rUzz4CBXQ3XB?=
 =?us-ascii?Q?Gy9WvM8rpC4F17KWvtF9+E024m/UrhDLq/VhzvVLkRXbVYUVsraH9mx+VF20?=
 =?us-ascii?Q?24Af8zhDcQBzjCg5L5Oge917bseciQLwkwgvTGI767n1oORo9sFMJCQAYo6a?=
 =?us-ascii?Q?/YImhKmWZw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846ffa2b-03c5-4193-7123-08de54d29f71
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 07:41:13.1268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iz8ZdaziAvPlTsAslT9s5szMWMpDwp6yEx4X//2B2trtpzLdE820CQsgZre80KYTxOgdTzckeFFsDxPxu68zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7390

Currently, the workaround for FEC_QUIRK_ERR007885 has three call sites,
so add the helper fec_txq_trigger_xmit() to make the code more concise
and reusable.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 32 ++++++++++-------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index cfb56bf0e361..85bcca932fd2 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -508,6 +508,17 @@ fec_enet_create_page_pool(struct fec_enet_private *fep,
 	return err;
 }
 
+static void fec_txq_trigger_xmit(struct fec_enet_private *fep,
+				 struct fec_enet_priv_tx_q *txq)
+{
+	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active))
+		writel(0, txq->bd.reg_desc_active);
+}
+
 static struct bufdesc *
 fec_enet_txq_submit_frag_skb(struct fec_enet_priv_tx_q *txq,
 			     struct sk_buff *skb,
@@ -717,12 +728,7 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 	txq->bd.cur = bdp;
 
 	/* Trigger transmission start */
-	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active))
-		writel(0, txq->bd.reg_desc_active);
+	fec_txq_trigger_xmit(fep, txq);
 
 	return 0;
 }
@@ -913,12 +919,7 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
 	txq->bd.cur = bdp;
 
 	/* Trigger transmission start */
-	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active))
-		writel(0, txq->bd.reg_desc_active);
+	fec_txq_trigger_xmit(fep, txq);
 
 	return 0;
 
@@ -3935,12 +3936,7 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 	txq->bd.cur = bdp;
 
 	/* Trigger transmission start */
-	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active))
-		writel(0, txq->bd.reg_desc_active);
+	fec_txq_trigger_xmit(fep, txq);
 
 	return 0;
 }
-- 
2.34.1


