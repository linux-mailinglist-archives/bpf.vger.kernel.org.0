Return-Path: <bpf+bounces-56316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD089A9540F
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 18:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A621730C0
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 16:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA2E1E4110;
	Mon, 21 Apr 2025 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="oosA5z4V"
X-Original-To: bpf@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11010055.outbound.protection.outlook.com [52.101.51.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E771E1DF1;
	Mon, 21 Apr 2025 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253012; cv=fail; b=S8FMfcPceCCsbMJL2y3GuWGEE1UzGp6+9buLK1Iy4THu7hN38+dn1Wk/hdRkmIg/rZ0GmWv3uot8kbA7ibOTZhx4EQK+IT6O6z3yH1MJkoeDD2wuQ+IhPSFF+v6MqViKZLuFqaD8hq/IqROrMb8EilZ/81dadpqhTOY+inF56pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253012; c=relaxed/simple;
	bh=J9jp68wAWyJ5V9lPak4CmtwskftfJMqWnfzy1/uAFK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hKEwqNOFPbbbW6BCVwYO27J6XH5wwuQ5u7tqq/eb6qN4IlFtvNuvHl32icvA/LLLxK/8Y9CuuKPQwDAm5dFo9hhXm6b1uFWVwFT+yxo9Ukxgk69gcHOt5+0zJNyePmYuk3U2RngxF/s3wUPmHa18QH50ViOgk/qHsFmk29nMYZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=oosA5z4V; arc=fail smtp.client-ip=52.101.51.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BujbxKhryo7Y6/Ir/rMiMq+kwhQfXwIgW32NJ3Gppk3BvRkAMrDBV24T1d7DYUdp/TBUyUncgHyOT1puYAREbqtb4u9E0Je8hn2ItqI8FfQ4e8NAtfURAgdQWspoB62mAlg9SpaGRTYwXmD8QYMip3cRFaXjGRvuU0cHH/4b89bC5qzqDoZDQwp6VwlqPlAE6Ie2U0LueD1LdlszZtoA+6YCwtr/1frIO0+wLPy79MkDtjuGx7V0qyvAfXgkEuRch9upyZj9qSNurYqpi2Rnux/Z4sHMxbzqIOgl930QfiQXHtNdKPCoK9345nlHAf+n7BAdg/pydpkeyiOnd/YeTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w88+bWduci5r+pVCuoKtYoF/TREg3LKGNJSQRE2bVZk=;
 b=LarlgcYM39BwKIaOUGbF7c3mY4ueZK+hOKOCu1FdUmuP36vmfGPGAPG7vBEWAHmSo1IvCQTUdUE0y392+IjbmhXQsFEo4FSNZ9JfBwwMGOVbUrHEpJ3enmyPjhZKSG4KmVpk9tjvgV7E4E56W4kNWnRdF/lMfiouT1pVcs4fxvhgtZ4ft+IdtpFSiONn3gPQAD84/6QngvPdOUzM6P9BtTVi5Yabj4Y7/aapDnbfKBJ3DEhrYiull4rvNySKEptVcLkp1MvXO4jQS4scoleB20zHrngOSgeb3/i+h+22K6r4ASzxFVPnX/WAemxa+0AHZaxXhm03IAna73CW30HdBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w88+bWduci5r+pVCuoKtYoF/TREg3LKGNJSQRE2bVZk=;
 b=oosA5z4V65qd1Olp0mHLmUo1DOFYpV6s/fMsvd13bj2yUD/PtWDZh40KYLOYKletLq8UG6a5/+P49xl3v4v4fmicwn3qpcSQ26i/ipWMf8fcHXpEG20upStnGP96ZlUqHBwp1o2SfCdnCoyI8lzB3qlazv0M/v5ATRPgCYonY1qW47SlxLRQ00VbeFtKLUrH0i0aW4O4ZxnHRgB6j/UQoO+3/ZDQwp2R7KcEprf8/hDoy52cfaNCKC2QQm0S7VfSvtK8YLaBEc3K23foxhVIepOGKTCwrYfDwXTSnQBzqqM1Z0XxsieRD+OyDBWCGD9PjgBCheZOKS4Ci4TPaoXwMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by CO1PR03MB7987.namprd03.prod.outlook.com (2603:10b6:303:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 16:30:08 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%3]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 16:30:08 +0000
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
Subject: [PATCH net-next v4 2/2] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN stripping
Date: Tue, 22 Apr 2025 00:29:30 +0800
Message-Id: <20250421162930.10237-3-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250421162930.10237-1-boon.khai.ng@altera.com>
References: <20250421162930.10237-1-boon.khai.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::26) To BN8PR03MB5073.namprd03.prod.outlook.com
 (2603:10b6:408:dc::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR03MB5073:EE_|CO1PR03MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: fc764ee4-07fe-4c74-6aeb-08dd80f1c760
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zu2MhCBD+5g/QFM+0a3wcUOIX5LFa3lpAWFklDNgI5N4bgSKG6om9VhQpd/s?=
 =?us-ascii?Q?gjSjZX+SqFn3wJK7ElxWjxRp70F7YIAd3xM1ZLfaH0xiK8gcmteP19HlooNT?=
 =?us-ascii?Q?bb9zJIMQZvjyNMrpT8pQ3dwxyHEnhgjZy5M9VTHmaymChji95y8/qVtbhJER?=
 =?us-ascii?Q?V18GErqX92kvrqPAyQ7tU05zDB7QGUJxotoLoi79I0b090Z20tpYli076iXm?=
 =?us-ascii?Q?rIGRFg/NeTr5FGXyl8WdcN7szym+HXbQma0zdw5sw4L/bYfMq/KXBkrQwTU9?=
 =?us-ascii?Q?mst5bujajlHkq7RZB8Kwz/f0YMb0bXRnVW3efxNNjG+i0mZo5OFZNl1W1UFA?=
 =?us-ascii?Q?0/lw3rA/DOZoygwYVqUBYz5XDxTrteIJNtBkMJvEzgVVxGV4BzyAar3Ie7Od?=
 =?us-ascii?Q?HmfHETe4s5tm0mqWurVCL/pazxRCzDVXQEfogFTIUgyXoDxX5YolLqelt3kz?=
 =?us-ascii?Q?3NpQIT7zzGGHdrG+WBkqXjyXfRg6ao4nJlnLb5xayOnC9yX5E0lGTC99M6S1?=
 =?us-ascii?Q?o0Yh9VC7C7BuuEMPgIQQz/TDPuYCue56rNxyFejiX8Gf/+Ba1FMFkoFLW5/C?=
 =?us-ascii?Q?XI9woPW3aYGDLh9bFAaePiWEa2G0JTT97wh9pFvcT+fh1N6THwN1Giyyz+op?=
 =?us-ascii?Q?UZZxkvFBFZafcPmwT8LDdMjMN+tCBRn26p6LRjKaOTxhk2R21GLhHmqYM9ON?=
 =?us-ascii?Q?n2FM8WGPfbu08olob9DjnKadPPqERgyElW17XiswFs5yauJ0SpXYe0b0lGAW?=
 =?us-ascii?Q?prFU+Uxe/xw9pl2uywADUKuO26f++6l2r/l08kvOBc/IPJj/4rLN+U22cUqS?=
 =?us-ascii?Q?V381OkcumIkqmkaI+LyOAfUn1Tyzft+0Ua0iP6ssPDcqqjYG7IYqIy5JGije?=
 =?us-ascii?Q?cNh7RoD21W8ZH50p9c1QH5DwYc9L69G3meulihmLraGfcYH0TZfKYEbUF9tW?=
 =?us-ascii?Q?vB5qTwCuHQppD5bJaZuB7e/wz35J3n+caQ+uhRYnm70juTAam3Y5MXr92jqJ?=
 =?us-ascii?Q?4ddq+zfTToQcoeMhzcokd9/Mgm4LEFRgCtiCHN/WXwA6iuAFOqtC+g2EYnPn?=
 =?us-ascii?Q?qc8WsytU2HvYWYfoW7w9yPM5vsrx04QsqiyHjiqIRNrBgvqyNPt1wQDzpoo6?=
 =?us-ascii?Q?SLxMpG9JUyFgiuoCKb2NNA7jX5SG2F8fWuLoxKH5U3GXG8bahwhkmV+SPEm9?=
 =?us-ascii?Q?bci2T5Hge0owYQDmb+lJAtgmy4pPD4utbgAoouCjshmY1A7gawMmTby6Vkam?=
 =?us-ascii?Q?f+lRET/litkGhVUzXDcqeJRRbfsZTWhAS1r+nHcsPFVzMKRl/pkllwPBbDWG?=
 =?us-ascii?Q?dt4uVp8KVN7Hh+9tXEE2h8YYHDs6rDwYbUFb4Cg+rWsPw5woArMNP8LU9oye?=
 =?us-ascii?Q?6fRi6BoIgcD3HIrcriXwFOF3X4I9qcaafLZEp2jk6d+UKlol+1/1I+VNcsip?=
 =?us-ascii?Q?Qid3K//K7vM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB5073.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G2Ath4UJcRasrbnI8rg1j1HWVYT4wz+rGej34ppb+ZEMm2twBpHJ6DhaR+OT?=
 =?us-ascii?Q?PpGoAGJ168bq/CBAo794q18VjN605t6BQZUY95wZytcvM1mJGiHP85PI4MHm?=
 =?us-ascii?Q?JCddeS4C4ZT+hk+NLB+z4MPNV4nqfqZcatRITD7cuVU3QWFOyCrjc5yfwDkG?=
 =?us-ascii?Q?uchOiukJ1OJgEdDo7CudOYpKYoRbUiwHjsI8IRfRoJAm9/sx/oNTHUaU91jv?=
 =?us-ascii?Q?LHg+rf9jPpSQK8B61tA38dev3wq2dfexW6X3jwVCk96k/QiySMBEr4+70VMi?=
 =?us-ascii?Q?dTdg1/EOWGrJ6K5REmUSlCOVLYz4wKs5OJbOpdPXH8+SfuiAS5Yg61Iyc13q?=
 =?us-ascii?Q?fytigqYCsNTuUBwWaPxk/iEGpk4A5wBQTBFewTOSf5WZjX3ZSa7gHNs3gagz?=
 =?us-ascii?Q?HNPVWAo/osgYVHPbsfQRnIyMtP79cD4/HEJMXB4Qtf89w9Ln/SAuKJGOScrY?=
 =?us-ascii?Q?wMW6KaeMgFMXX3it8v7rthF0396WFrOq8tG0iGRemUMuXilIwH7dd5bnUonS?=
 =?us-ascii?Q?yJmXf5okGk527iVzW0yI2zx2rzxSfIiwjYidjsbjS62ZPeF2NxTKf4DT6/cl?=
 =?us-ascii?Q?8QxL0p8tZWQwKiaz1ihDkcjXLskkoCAOR79PKcBo42mXyEnu1lOPjSdQcnyZ?=
 =?us-ascii?Q?X4F3zrjWMszvYAMD6UiHHFFW9C23Zqp6UqdiHfAVg+osx4mAmpnEcRn8pQ7g?=
 =?us-ascii?Q?nboDrtTMu7XrwXOlZc61QBPgwBDgPac+AClUE+8GrcxEjxhuJdA963gAKesU?=
 =?us-ascii?Q?cKdiSbmz7IzjJRkw2wJBdlM9ahxjsHHK2wSdGY7q5bl+tIK5rP5d3B8peO7t?=
 =?us-ascii?Q?ytydycn4QkZe5g5ubI/Crcozi1GzwpnYcABE0eeS4cIrhzm/3oNb5nvJkDwu?=
 =?us-ascii?Q?jM355D5iIfkWG5ZHo1VP//9JTyIdM8Ur7Yh8dYZL21WDCZzCk6TE6xYWhdvp?=
 =?us-ascii?Q?I/QMJmB4wFHkjB6YXzhIKLHkJW4Kj7CkHGvS2gDtLvp0i2du0KVbK1bPFaY2?=
 =?us-ascii?Q?WnpJQn/KMxyF+V/XAdnYUUHBJjYghL6oYxHGmIM6+DlB6h1/OZNfLv+niv4w?=
 =?us-ascii?Q?iU6GbBUIr6Pf9weIuU4gPQ7gqQJWB1vf7IBH8EoT54HMeWVG5ZRZpP6SnHpF?=
 =?us-ascii?Q?nTkiNm4vWvKJPpKrW9uxhwBbZWefsrJjV/woWUu2JDejz861HG+GN/Jqmp7Z?=
 =?us-ascii?Q?OM8wBx7XfOnXlBfsUF6lin3nGeJ6Z6Nq1Vcq0PRgqVu8QSI9f7SodNsVwu2v?=
 =?us-ascii?Q?Ok6Zmqqxz52SGvX81skb7oWbOC/dxc7Ds0dplXa5Bx3t67JD/564fwuFcRpI?=
 =?us-ascii?Q?h2hwvr03kz3MPd6RFkqxueDj8cJ2Q9dlUt5mbHROiQheg9iCFKQ3/ZPf5ka8?=
 =?us-ascii?Q?LktBaP1vsgjSIEP5jM0Bmt1pJQg2p5ipLUMB9QQMMXmXFZf0xq86WRZVpfat?=
 =?us-ascii?Q?Tmn2MfJmhZa+f7p9y8VUntDuFT1d2HZ9nC1HjjcuJ2cs7dCBToEC8TutRDk1?=
 =?us-ascii?Q?Kc6wRhXOATOkQiQpEdMUiwbkGrkCaLyzPk1Wtv9EKbygO77TRCsFwt5sxW0+?=
 =?us-ascii?Q?hXL4F2xSS609KzKG28klWz3iNLfkvGzkBEgWcsGY?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc764ee4-07fe-4c74-6aeb-08dd80f1c760
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 16:30:07.9855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yiVCrVpu9WfDe25uuxuYSOF9PSkCLrFLuZWrgMRG0wwx0QTRGIS++/6B9XGNZdg/cwGnecTcScvSamtJ+M0GEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB7987

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
 4 files changed, 33 insertions(+), 1 deletion(-)

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
index 389aad7b5c1e..55921c88efd0 100644
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
+	return (le32_to_cpu(p->des0) & XGMAC_RDES0_VLAN_TAG_MASK);
+}
+
+static inline bool dwxgmac2_wrback_get_rx_vlan_valid(struct dma_desc *p)
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
index 59d07d0d3369..2b1bba5e8d26 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7644,7 +7644,7 @@ int stmmac_dvr_probe(struct device *device,
 #ifdef STMMAC_VLAN_TAG_USED
 	/* Both mac100 and gmac support receive VLAN tag detection */
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
-	if (priv->plat->has_gmac4) {
+	if (priv->plat->has_gmac4 || priv->plat->has_xgmac) {
 		ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
 		priv->hw->hw_vlan_en = true;
 	}
-- 
2.25.1


