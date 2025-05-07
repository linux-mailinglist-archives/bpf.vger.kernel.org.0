Return-Path: <bpf+bounces-57632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BABAAD64D
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 08:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D484C682C
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 06:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAE5215197;
	Wed,  7 May 2025 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="OuZ5yaxH"
X-Original-To: bpf@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11011048.outbound.protection.outlook.com [40.93.194.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA55D215078;
	Wed,  7 May 2025 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746599951; cv=fail; b=njkY2Iw5cRUWsk0lInBlxUU9eJlSgQ3estKaeU1w+6wqhNna9WW1ehfYCtPM2sXupdtVrNFAFVqz8uPO6oLIoDJLEhZ9Y+OOUFYctDU8UzgIBk3DncnSxBLcjHggb7nMsItUW/eCY8e2Ej5lVD2qLW5UsY6vyOPh+RcJSJihAjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746599951; c=relaxed/simple;
	bh=GRPFVFV2EdntC+5kNjGlfAahmobY3gcAyV/V8Z23+0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nYekMkrx0SG6KPQloxV9CKo61Th1g+N3DmnXL1nvriJoJ4Z3LhOkmFTTwP9YaYO+JD+uzmfxAT6zQYP41QOLJ+4rnjjIEMcqEhynH2EBkBa+r0UDxQFDDhcDdOkOrRl3EWsUJWUiM4xWsHdjfhQSZAAAYI5qHb/M8/g6WeN5gr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=OuZ5yaxH; arc=fail smtp.client-ip=40.93.194.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=je7DKDeKNdx1JQ5m60hUqRCx5rOSs1SQmz4yv7AdlLjG/gSwLsKxi73LSlVp4AWlTqdl/eHcANBtBhjv0rG4tspC2d1+8gfAp0iaOz1WtfSt2zyPKRkouExH//IP8WgSXohHl+peEvkHLW6A4CHrUXX2g3/CwXHOAKG3hN1edXCd40jLDbxtG6IT6gf6uWfvrUwhdDwRm85/Jop/6HXH86/Vsl0u7sFTlG/DIeH77XfoLbzGS45JvQ+eSe/dSKU/ylygpGOKJ9We4Je5uJtXPo5K7GPAUIPnTSGJeHdf5B+hlWuBkHh+QlDCG8qvZfxZwty/gEBG+0NU/qW17tXUJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbRijd2ZEhTPLvlFVoH9cvOYmwB5ZbM/7EKgZQp3u1A=;
 b=qX2BlARLIWarwzlb9ZOgvUYolgWpMpP3B9ApAIj4Nj/BMpF6uAAxc99gdPiL93U2oJm/i3RZGT5amM5AO2OScxCpgJROu9nSowX67N1cY7pV6WAEFk8U4iAYYsg/AFKBrwZy64rihNP8ugpPbCTSSaKlipBBa/DP2OjiQauH7bGh352TbizMMRYSRVqmq8fpWNdWSPRiuxCh3Tcj20qe2+X8eMMKqLEr2mkEIAwaWP+aHu118MLFKopWGWuSHLXRKUF1sGygKTMGN4IvN+lF2f2u0rl8SrqqVQcBB0S7tEikFUPGIvz9X4T2sAg74SZ5jb4k9g5T3B0RfwHdDThw8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbRijd2ZEhTPLvlFVoH9cvOYmwB5ZbM/7EKgZQp3u1A=;
 b=OuZ5yaxHwcPQMEycbeFVYmY7yQUkW8t05nbsuUL3VU8XLsEoMRXqLLfqhj2VDSvl8zNk98CI+5gmvWRPdKnMhADzwVjNpJH4vvmnplyO2RtfHoiahGMnqna2TzgCIv1MfXTzyzk7N5dcPC9U/H7mRdFUCZqb6xgN1VfkHPJuU+yXb5n23G217T9JGqgHVsdVDNWl+qhNxnAd2EcOpSF/nz7AO856oBuQZWynmCP4k57o7K/v7B7Az9FFkVz1p4dcCU+Pa5kQ3KdQcOKSaVH6Cs9sqfhqJDXj3EjDxwkjpR4zAerVk0qtc5cvGzWf9VVt42TO54RKoIqG1SubQyOWOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by SA1PR03MB6595.namprd03.prod.outlook.com (2603:10b6:806:1ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 06:39:01 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%5]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 06:39:01 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Tien Sung Ang <tien.sung.ang@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>,
	G Thomas Rohan <rohan.g.thomas@altera.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH net-next v5 3/3] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN stripping
Date: Wed,  7 May 2025 14:38:12 +0800
Message-Id: <20250507063812.34000-4-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250507063812.34000-1-boon.khai.ng@altera.com>
References: <20250507063812.34000-1-boon.khai.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:254::17) To BN8PR03MB5073.namprd03.prod.outlook.com
 (2603:10b6:408:dc::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR03MB5073:EE_|SA1PR03MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: a47150cf-bcc1-4c66-7277-08dd8d31da87
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r3kYBY4quu9rZVpFx2si5NC97ItV8z94/fyfpoWtbvu7KHckB3PDkj8lBJ+p?=
 =?us-ascii?Q?VatugdALRu7sCTtlV7E2Ps1K31Yjre8stl2aaZIGmgZIxSCkgNCjmF+VC2IE?=
 =?us-ascii?Q?R1Q3n5XtuE/bDlDS4YwhmE3qJ4blJQu02YgTQIH9pODLeiLIwm+jhc8tAYbH?=
 =?us-ascii?Q?LXkgLkgqDe9hUViF+l4mWhK/JmICtMEhZRKdbVB1jU/kJRro/4erI2OZpL+m?=
 =?us-ascii?Q?+9vJxEce+nCTABe05lcOd4PknX59ZZgfkYf0bQFuHjNIK02JezlCOpcfqzV4?=
 =?us-ascii?Q?jK2XLROgKbxO9oadOtSEh1NyM3PocOa60CFx5/0wbiWtk44B2EXKD7MIXqNA?=
 =?us-ascii?Q?qZVel1sR7rmcazF2CG/3NdZGmTmqHOgJXAWgcAtSFdcat9n0Cglpsb1r2WZK?=
 =?us-ascii?Q?iL3uRX+Nnihz/w9zRAyN5KMPw5Aly2fOzIjc/ogspf3ALTU6Q3MaWvYjW9Et?=
 =?us-ascii?Q?Vh28s8fgnEcrt7mCbM2gkcJmIsFZ/3GxO8ClqIvinE3txCad8r8xxoi52eIG?=
 =?us-ascii?Q?NV3oB+NiBEpv3eUbHmebb6bpWD0357DNW3Ea48hOpXXlqVnAnrAu4JzyO/4C?=
 =?us-ascii?Q?86EZq02DmlSQLY55B4LKSlnn6K/7WyHVMAgC7ZYeN8Ig82lo5Ysbg1Z2Fyll?=
 =?us-ascii?Q?d8hBtOTaZ6FTtPnQL9OD5ZYjk+hzlAQ1UKLjeWVJJvo6MLcIMpDkKY8+qYSd?=
 =?us-ascii?Q?es9JVZwu0w2RDwiUJGKCFN8bTAyZ02UQpnByTpyB+HwygxenvNHK5VKSFUw3?=
 =?us-ascii?Q?R1YHLvVGMR60B3f1XA/Qjq2PF4GlAcam2PSEKNBmSwOlIe3ombcWCKyLuF7F?=
 =?us-ascii?Q?/vRKLzLdzWtV46JaUfryV/l3wTQzmTFwaX6UdGh0uRf/RBC8O3vcTcP2Cwo/?=
 =?us-ascii?Q?cr+kmFae10I1oAY311CbjLF4d37GOtJ7FDb5k76YIHtYc4KGq4OnNghi5BCE?=
 =?us-ascii?Q?ZVO487DAvoaEJZreZy57qCqdCJxKwFp5CFBVOSHyvBNL6VHcw/X/PNOypkDp?=
 =?us-ascii?Q?vpKuzkeFtYrPIWSDY5ENbTMBh1/p6zdv31eCeuYV2lFVWd6bzfQEXNFpLX5A?=
 =?us-ascii?Q?TA7C2mm1vx38d9Byy6GslRKOZoge54ASDxO7eva8fAnLsg4AyZJGY9nbNh4o?=
 =?us-ascii?Q?IjoIBppjlPLmZR2ObeHZCQwnN5JVEbMaAyq2UisN0CSFohEGf8KHpczDznTR?=
 =?us-ascii?Q?+8BimkydDw0Bthrh3GCG9RhomtKyb17h9dl9JHDJhqvPCVbnx6PLq+fCgE0T?=
 =?us-ascii?Q?dGubYTjBwg6OjPZZTrAYqE78kLBDgOIzMomUdCS0DaKxteoX5n6PWHhW5lPo?=
 =?us-ascii?Q?oOcnyd2bywCD/bFkcg3HqUU9LjlDWLLf4oe2P2aPqzu8863F75bfDN+ZtZEO?=
 =?us-ascii?Q?sEB33nuumgQfxjYUMX++6IDIiLhq81xGPJ1KcQf+IH0in9x1n8zE1mMrlphQ?=
 =?us-ascii?Q?c2rSoEq+9EQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB5073.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rwz4Zo9Y1mYDDZZXw9hGI3NZexCYsuaPB+Kvl8f1HLb+aNqPKQc8gRCtv0Ts?=
 =?us-ascii?Q?YdPdhGD1VgLo4dP3YuHKD/v3MygDOpqqVX/2aNariebSddmPHv30Ci7LRazv?=
 =?us-ascii?Q?FewBfyHuphZ7es9YlGYVG2QO2/UTAI5RS5FEY9I6L+hFMQV0sSGPTnhlyH4Q?=
 =?us-ascii?Q?ik3dt3/nir6/i1EUXqFVvFjslGiylwl7amF1SV/Hpt3weuWJsxKB8r/DLMUo?=
 =?us-ascii?Q?vUxwqolnpzEziw7vrQnfhhYg4jFxVqea1czd1/q9jkBaxUPrGHpXlzMv8k9d?=
 =?us-ascii?Q?uNoZp5TODvB6adOfXGl2+yOel2y2r7HGuaCwDv/TEp1oqTwaw4G0+Kf8aD8F?=
 =?us-ascii?Q?PxQFxfS4ej96ZsJBp03S9JPrwv/CuYXW38DG+qTEtjUL55gra80Q6MF93yFr?=
 =?us-ascii?Q?9S5CKDusYawD0mYURLyg/O/zo1Yn8kWeF0mRTW+L1GE7//yMPxWGP4sKtkE4?=
 =?us-ascii?Q?Sc6fxcHnyLVFBlgYU4xEcumgv2yW9X4K/EcPpIZB8ziL/2m3fA7B15zcUcKu?=
 =?us-ascii?Q?6GdJMXRCuqbfxdkcyEnYDCsfE43ZvofYmoE7MdP+dJsCtPaDj53PfaCYuVRC?=
 =?us-ascii?Q?RK9kMTSbNTkvRVDqQrRHVRsYs7qbgv4IqsBeQyshzfa01DHXsNWFlElPoYJN?=
 =?us-ascii?Q?51Du/kUZcra2ZCaRNhnh5CIAT24hVsn7xlBALnjuuc88rHWvSmcqZhcnw7gh?=
 =?us-ascii?Q?DJPis1avaaFpn/ujPHyoq8dXbGL5HwVuZaNcXwqTRRNl1rCx6G4EQ/GtPSq6?=
 =?us-ascii?Q?PgBbp/JBo4h7r5r2bNpXV5cWKfjRaoBMVN2eHtiQ5OhTlFn899wiKjHttU8O?=
 =?us-ascii?Q?bbCKYh1TWw9vM3V4lSSEGBR8YTyuOmFYvDTvF92grQkCWdzf/03qENFkX4kU?=
 =?us-ascii?Q?AfstwQJC87AWLCmg5ZbcJ6Uqv0baMRK9/fx3HjUa7pH1PjdPDUX0yIBs39AO?=
 =?us-ascii?Q?JczPZQzzPBzY46NpI0n8FOHVikWxqTx1LMDPxJLIAtKsxhcsorF8aA4BeLxu?=
 =?us-ascii?Q?GkSzdMBYpnbldUn23Vn2nn9E9bjH7t/LlvAYoK3VEq8wrkpY+wkhXWp9+Q+a?=
 =?us-ascii?Q?ECaMsKbSIUelpUdMOcWPvXcIz6GZFWhHqZNEfTxowqBthXlL7woAcznVVvS/?=
 =?us-ascii?Q?SdhMuQVSrY1q50tN7ysZKbBIO+PgftDnJukXJ7qq4loX2PCyZzjolx8fSQ0D?=
 =?us-ascii?Q?6wRErzwfTkXIF/yeq5bEtUcZ6RWTgpSt5NM4JPTNiAZknzE+3qUSeWxF2c6v?=
 =?us-ascii?Q?AlXhfQRtBi+mkC0baR+VRQsQKzlmtBH2O0i+T24keQzuNX64YSlkz1iI++7f?=
 =?us-ascii?Q?uKhdwP1YE8R9V9KeHKs0X69O53HyxwgWAWR+ZFqsaWbwzh0IZ8wEpQ7s37/0?=
 =?us-ascii?Q?YYyK9UByxA4I7alaJy4xM2rCHTGOX5UqsySCEOABxRygffJvgc7uijuGs6uc?=
 =?us-ascii?Q?OirllSlGqpb5Y2Zk0J+FL8GcIil0Mp6Vcuk5Jg9TAfLMsMRGSqL/ki0y7Pgk?=
 =?us-ascii?Q?OrVClUmoB4cAlGt6XhCSHZZZzjMlVcMwtBQo9uFKO0+wGyAFoXbvstm0OJ6m?=
 =?us-ascii?Q?rt++fnQ0CaagT7xtDnf1PIQKivsQW2Og/JqXv8KmMrnffhuZnoyrEs8bxwqE?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47150cf-bcc1-4c66-7277-08dd8d31da87
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 06:39:01.8481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNxJl0RpMnif4sfM9Npy1IM2foAOkmQ0AzIGAnr1rlkWgPa184l88dnox+MkMpztXvwHox/plZq2Cr8vfyjLTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6595

This patch adds support for MAC level VLAN tag stripping for the
dwxgmac2 IP. This feature can be configured through ethtool.
If the rx-vlan-offload is off, then the VLAN tag will be stripped
by the driver. If the rx-vlan-offload is on then the VLAN tag
will be stripped by the MAC.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h | 12 ++++++++++++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c    |  2 ++
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c   | 18 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c  |  5 +++++
 5 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 5e369a9a2595..0d408ee17f33 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -464,6 +464,7 @@
 #define XGMAC_RDES3_RSV			BIT(26)
 #define XGMAC_RDES3_L34T		GENMASK(23, 20)
 #define XGMAC_RDES3_L34T_SHIFT		20
+#define XGMAC_RDES3_ET_LT		GENMASK(19, 16)
 #define XGMAC_L34T_IP4TCP		0x1
 #define XGMAC_L34T_IP4UDP		0x2
 #define XGMAC_L34T_IP6TCP		0x9
@@ -473,6 +474,17 @@
 #define XGMAC_RDES3_TSD			BIT(6)
 #define XGMAC_RDES3_TSA			BIT(4)
 
+/* RDES0 (write back format) */
+#define XGMAC_RDES0_VLAN_TAG_MASK	GENMASK(15, 0)
+
+/* Error Type or L2 Type(ET/LT) Field Number */
+#define XGMAC_ET_LT_VLAN_STAG		8
+#define XGMAC_ET_LT_VLAN_CTAG		9
+#define XGMAC_ET_LT_DVLAN_CTAG_CTAG	10
+#define XGMAC_ET_LT_DVLAN_STAG_STAG	11
+#define XGMAC_ET_LT_DVLAN_CTAG_STAG	12
+#define XGMAC_ET_LT_DVLAN_STAG_CTAG	13
+
 extern const struct stmmac_ops dwxgmac210_ops;
 extern const struct stmmac_ops dwxlgmac2_ops;
 extern const struct stmmac_dma_ops dwxgmac210_dma_ops;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index d9f41c047e5e..6cadf8de4fdf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -10,6 +10,7 @@
 #include "stmmac.h"
 #include "stmmac_fpe.h"
 #include "stmmac_ptp.h"
+#include "stmmac_vlan.h"
 #include "dwxlgmac2.h"
 #include "dwxgmac2.h"
 
@@ -1551,6 +1552,7 @@ int dwxgmac2_setup(struct stmmac_priv *priv)
 	mac->mii.reg_mask = GENMASK(15, 0);
 	mac->mii.clk_csr_shift = 19;
 	mac->mii.clk_csr_mask = GENMASK(21, 19);
+	mac->num_vlan = stmmac_get_num_vlan(priv->ioaddr);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
index 389aad7b5c1e..a2980482fcce 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
@@ -4,6 +4,7 @@
  * stmmac XGMAC support.
  */
 
+#include <linux/bitfield.h>
 #include <linux/stmmac.h>
 #include "common.h"
 #include "dwxgmac2.h"
@@ -69,6 +70,21 @@ static int dwxgmac2_get_tx_ls(struct dma_desc *p)
 	return (le32_to_cpu(p->des3) & XGMAC_RDES3_LD) > 0;
 }
 
+static u16 dwxgmac2_wrback_get_rx_vlan_tci(struct dma_desc *p)
+{
+	return le32_to_cpu(p->des0) & XGMAC_RDES0_VLAN_TAG_MASK;
+}
+
+static bool dwxgmac2_wrback_get_rx_vlan_valid(struct dma_desc *p)
+{
+	u32 et_lt;
+
+	et_lt = FIELD_GET(XGMAC_RDES3_ET_LT, le32_to_cpu(p->des3));
+
+	return et_lt >= XGMAC_ET_LT_VLAN_STAG &&
+	       et_lt <= XGMAC_ET_LT_DVLAN_STAG_CTAG;
+}
+
 static int dwxgmac2_get_rx_frame_len(struct dma_desc *p, int rx_coe)
 {
 	return (le32_to_cpu(p->des3) & XGMAC_RDES3_PL);
@@ -351,6 +367,8 @@ const struct stmmac_desc_ops dwxgmac210_desc_ops = {
 	.set_tx_owner = dwxgmac2_set_tx_owner,
 	.set_rx_owner = dwxgmac2_set_rx_owner,
 	.get_tx_ls = dwxgmac2_get_tx_ls,
+	.get_rx_vlan_tci = dwxgmac2_wrback_get_rx_vlan_tci,
+	.get_rx_vlan_valid = dwxgmac2_wrback_get_rx_vlan_valid,
 	.get_rx_frame_len = dwxgmac2_get_rx_frame_len,
 	.enable_tx_timestamp = dwxgmac2_enable_tx_timestamp,
 	.get_tx_timestamp_status = dwxgmac2_get_tx_timestamp_status,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 28b62bd73e23..a19b6f940bf3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7653,7 +7653,7 @@ int stmmac_dvr_probe(struct device *device,
 #ifdef STMMAC_VLAN_TAG_USED
 	/* Both mac100 and gmac support receive VLAN tag detection */
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
-	if (priv->plat->has_gmac4) {
+	if (priv->plat->has_gmac4 || priv->plat->has_xgmac) {
 		ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
 		priv->hw->hw_vlan_en = true;
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
index c66233f2c697..0b6f6228ae35 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
@@ -335,6 +335,11 @@ const struct stmmac_vlan_ops dwxlgmac2_vlan_ops = {
 const struct stmmac_vlan_ops dwxgmac210_vlan_ops = {
 	.update_vlan_hash = dwxgmac2_update_vlan_hash,
 	.enable_vlan = vlan_enable,
+	.add_hw_vlan_rx_fltr = vlan_add_hw_rx_fltr,
+	.del_hw_vlan_rx_fltr = vlan_del_hw_rx_fltr,
+	.restore_hw_vlan_rx_fltr = vlan_restore_hw_rx_fltr,
+	.rx_hw_vlan = vlan_rx_hw,
+	.set_hw_vlan_mode = vlan_set_hw_mode,
 };
 
 u32 stmmac_get_num_vlan(void __iomem *ioaddr)
-- 
2.25.1


