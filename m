Return-Path: <bpf+bounces-41557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 081FD998273
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 11:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E211F24B66
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 09:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C9D1C1758;
	Thu, 10 Oct 2024 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nlPyGZRf"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1271BC9ED;
	Thu, 10 Oct 2024 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552962; cv=fail; b=tdz5xWlW6o39UvJh9GSrwjQDohvtR2qBxuzWQL2bF+dRd7L04NhXtiRQgjSi99djGjpn0PN4ps1QX1F4xylB4amT4fmnuiUr8zCgNWDwRhwtOcqc4SkuavdP18Og/AAcyo5XnXB2TpDw/MEO2coRFEIZjM3URTD5yky/YbGKVMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552962; c=relaxed/simple;
	bh=W7yEJpYb3Pu9CzMvGRlij/dsgM37cXfZu5kHjh1UUZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QQ8d/+6Oyg9E+lkjMjxgidXGZTkC5zFpZn2HzNne2OUSIcjhs+w1xFj9xlHnOt+fjEfPOfTyqGV414xkgtsuc5LIJdhgbclSJ5CkH+TV8T/gztzSP47oPlMCZWZsCa/ycDM369Nbdct9EXLB0HK53cryK1dMHtDJlf0mUkBDC9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nlPyGZRf; arc=fail smtp.client-ip=52.101.70.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4/Gm/DHIwq4blZakzLofMsD5PG3mCNoRsZql/50b3AOmEjyvzyMZpAEew41M8yySFUnLWxB3exuQuzeSs53eCINnM9JRSf3Kj6h1qNT6lCSAfiZYQVufZqlea+LKeJmY5Jtfhyc6VIH4txSZYlR2JpbHBIReT3uMec1+I3B/kPIJ912DiHPQVd/q+uZLA2QEfmCDMHd14+XRk4jkPN1INn7TFgFc//DF6lwBiJP294O48nqm78+ePM6k0K6J5O+TOzHwPtS/cL3MhFXpbbyx08MrM5y60iKXu8YKM00xuAAmoIhrFEP64ZnPSFBuL04GCNgDWFD70JYvh+MHQecrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5a0+mRL4Rvw6pF64IM1ITWNwXZ3Cwy27hVi6eNOR7j4=;
 b=Ph6NxvjB5b9AwfeIaDxe9fCsrfWWrlhRhhDy3sBfyLrfH9sYQMu31jNI0fBOszV6pF9zgJltxns+/tZqcEqi6rHhotTtYyzc02KVErs7JWPIMdMS7sst9NGiWQyqkB8t7MUmsQbyh2gJtcfO33zSxqxHdy+o2Qiw6QvXdYRMGbfOkFG/K/IWpaJYVcHzV8k82a82A9vrtN7RxImuaSP7QjIErUzMcpcf4/nXkwHxiCtVoauaHfURqplJSGwtBcOGGViXjy4sT5sZTfsAR2KZMmfiDMDIzeIYdAMSivGyTd2TivhRkndDH5zXydZa1n3HbGByQz5rGNysgOIuypvz8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5a0+mRL4Rvw6pF64IM1ITWNwXZ3Cwy27hVi6eNOR7j4=;
 b=nlPyGZRfwZD1A/HSGongaBiF4CB/ZwQWpLNwAmKDOcixAoJYkzJALLGpsI3sGmO2RX8LEtYbZ9p+LYnVu7ZRMYIoBk+6TV2WUBGreLZ+oi6X0GNOE1+QEcjXhBLLBaPWF4wFG6xyMkguPnZECFAPOveHbCO5loV+EjcdMBCilG88gpjj7RepY5bBPZQJh2TulZjHWc0xoVqjzy8lnwYFwWK7sHjlLe+OAmv843ghUk6Pna5LL1tyE3cM4r7E/gxDPDrjZarK85bklF6tq/8sjc/O6G5udllRdk49r16zofuGuSJ2gtTl5I4tW7bWxFUDZpJpPVnIas7JT38BCDW0/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10856.eurprd04.prod.outlook.com (2603:10a6:800:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 09:35:53 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Thu, 10 Oct 2024
 09:35:53 +0000
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
Subject: [PATCH v4 net 4/4] net: enetc: disable NAPI after all rings are disabled
Date: Thu, 10 Oct 2024 17:20:56 +0800
Message-Id: <20241010092056.298128-5-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9818f9c4-8b3c-45ad-5d41-08dce90eef81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wpZFHm31TXjiVFkT2VZayFKNKTW1QK0djibfcOwq/0XXkDwbKMFH0pSNF9qQ?=
 =?us-ascii?Q?yWqyWrjYkOrG4wum8QhMd6irMZnz/iQw80oMgT4uiIldVjzglEv7P2piAfG5?=
 =?us-ascii?Q?Bu57qxCpWcDGmMWOuCOhuxqxs3x8UyLlbt+zeqeoDpK3QZmpAlyhnjkZugNx?=
 =?us-ascii?Q?VDHdnii3W4TUFY1/8jVOOT5XoSdoKhctGrEjAgJs9FZvrDyLBcX5BwzE9zXi?=
 =?us-ascii?Q?OLYprfs7P4ZdgU+Gezu1mk7Ilnz7EJl5WCR90YkSyO/LjXppte14nqD5AC9l?=
 =?us-ascii?Q?icK2dZ+OpcpuO2p/jRe3hFHS16ngVTZxtmxLQthJZhbmiogjgofqmDl1iw4e?=
 =?us-ascii?Q?pevDlp2YTQqiCPakAeizO1UV+yodYUCOyvHUV8VcFuMhVXbReT0oYUVq5Q2q?=
 =?us-ascii?Q?18DUhA4vBq96bJLGpdHwwhS6TN6RqbJuzSJV6+ynxYnxbmX/ozi7uNv/Z4s5?=
 =?us-ascii?Q?x4x0cYRRhoO5SA02aCS3wH4SXQ/+ztTYLuZCJJv4fJoYk5ddX6uQDRSNReMQ?=
 =?us-ascii?Q?XwizbdYP1VGnf+1s2Basl+HsS5IGS/1exkkjQDLRYwt7xcVzoqZVWBNXyqWh?=
 =?us-ascii?Q?gyj444fQxDDVqkeW1gJVbPH9QqZSpgN20megkqOh/PayQFBsCWzc8R/dvH6o?=
 =?us-ascii?Q?WhhArF06A6dQ6M+BvFdcexqeg25McbfVWssDSnj+7nHaKzKZp+jdFCHT7DW5?=
 =?us-ascii?Q?C/t6o1I26QJj9PJWASM09gkeEeJ7Cibozr2ZcnGFlKQr17uPJGRKN2FLkBEd?=
 =?us-ascii?Q?3n5KpSjRI/2lgtwsYOEOj43xXHGTVCePnuSClrknGrL+sSY7WsoeLD+/uFGO?=
 =?us-ascii?Q?cS4TsFgqqHjrK8Pas7oi0AKX2uvWOWS4sqYrPSGJPkcQZKMxVzcYY7yVgpH1?=
 =?us-ascii?Q?YnRPfRFQYi9T9jizfFKSeNYHvX4DYFmU2/qRhHQTtwoRBXCcIAL7ja+oIC5f?=
 =?us-ascii?Q?IAwBprVKN7htgytAl04LyUzMSLWyKhVBtmaz1jE5N6NfXy9YhPIUbS6EUpZh?=
 =?us-ascii?Q?cwHuN0l66WaX9iUmu+/Ge4aBAEOX2gUQ5HCjMzVI4vuzdWu4oZYFYOyqAvAT?=
 =?us-ascii?Q?M76Ys3gAVXfQNPcKqSzNHKXuaRVgihxKrf6YYCfw1Hlxvz61pb9ROtj+6OTN?=
 =?us-ascii?Q?/TSv8jNn06jbXnayCQFpmEVLvwwb+YzWPArRGiyWXKi2BWxioz1du4TAC9xt?=
 =?us-ascii?Q?ATU4wWxenXWTRmpCDxlKCKFVqtBW7kSqufFtQaxduJ/kvcdKNKGQfQJt8gHc?=
 =?us-ascii?Q?diRklU44ds5e8SyShf5i5gawnHn7qeQ4nhBr6sfmDd/Yzqg3vy7ka4tTVsR4?=
 =?us-ascii?Q?n4SOBPXsyK5dkRzhq8PDqZI6L9NDlUhd9gMLtSeQoAtD0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B48Af+RGk5ALOTsJfkxHyNG1hYpftN/ds7h+xJrvPWBO329+zQ5zD2PlTvbV?=
 =?us-ascii?Q?O3O/kbpRAvSzCovQGwK8T8WMrvy53V3DSIGppzigPdeXpstxgJ7YIQMDqVzV?=
 =?us-ascii?Q?VtohEnQG8gaGEQ6jiGAo97QVBo59ZhTW7yfJvuIPhv3pVE+U0UTZ3fhjcEBn?=
 =?us-ascii?Q?yH3YWtBSQZvBOa8wIOSd6tjMCK5f/Y0d40v6/IXdB9lEnk3U9XJ970CkKWCA?=
 =?us-ascii?Q?zIurv0pPa3p9/TRVyH6b1EY7GM0Vty4D2ojOuOxGMZ/yc7jGIPInV0l7OPoD?=
 =?us-ascii?Q?0xQVl6NTXK/4/+VV8Vos79eTyekxRkm21vE5u8klMm6YMr/X3gQ4NXG6s7BN?=
 =?us-ascii?Q?1aHQ+4LW0bG3Kogp7OljyrYXzikl6zTqqoZmvNCmhNEAA2LO9loCQtbeqB98?=
 =?us-ascii?Q?Es7WbpXNQX98bGRGpKgnumtUcOsTm7xvAk/Q56HUBVF0SfhT0spj4QWAYLKc?=
 =?us-ascii?Q?dI8S7XzZcyDQ3h9+4I9Eu+g7KfY57GlqKWR88mi7DRLuM5NONWffBck8dwa9?=
 =?us-ascii?Q?yG2siT0x+2Zl13ZACkD9EZXW5pM59EJSLWCaIQXeKl7C8JgYlHBTLhs1ca8a?=
 =?us-ascii?Q?Zdj6A1LFtai0xZ/8bDuin8/21y8w+Ph6c5osM3tlH5bjdVoj3q9Uw+OsuXVs?=
 =?us-ascii?Q?utmjIHLu/Oyvy5ARbtF86QF/+SUIabkJgoi1MCODm57DgXR7yfHg3Vvkgd/l?=
 =?us-ascii?Q?W0xG0JaPwvlDfXUXfR4Q9t5pGa9El0jRKVqNWQsdqdw2OiNFuv+p5LSLCTTM?=
 =?us-ascii?Q?eB/K0QauZym6pVmC0OhEh/y5sJXiZWZLxGJq5hyO+BKQOlHHxVD5LfHuBdWo?=
 =?us-ascii?Q?Qgpqqs4D4A/QUw1Vxn7F7/BSQOlHIX5K1N/bVhsiwnyVd7VODlYU/qxHH5u+?=
 =?us-ascii?Q?/G4Wh/NDPBnd62Raz4xK+xBKEiIdWbMhnInrxu07RxtAPeFirmp3kdA/NQE7?=
 =?us-ascii?Q?Sc9mK+QIabSltzYwPn6WnU+RH0931TvCgJGSIhp60xfZppx5mRD+WM6Zf9PT?=
 =?us-ascii?Q?bIu2HCNYNQ/8jF27DaxW94wLvi+URZuPvbj/570/3C4mWm3WPXOuHCN6XWQD?=
 =?us-ascii?Q?Ofa/TLK3w3BZKIf9jP6MtLregaWniZgdXVoVkJJ7yEnah3Da7dc2q5J7RMug?=
 =?us-ascii?Q?GNP7i/D8sHoKLv2QYajfYGPUX51NYlDvoKKhN/oimEKGmvAsA+EMs3AZ1xiH?=
 =?us-ascii?Q?VtrygeZSWzNd80SmhkjjKg3Q9nt4OXzPJgr7Tgchl4TiTk53PcDtWbdJLnYq?=
 =?us-ascii?Q?Y68KrkmRpDkDvfL4GP48CDgl4EPP6g8ZzXgaNyXGwaoqN1HgZHLdkjWOipgh?=
 =?us-ascii?Q?1V8znsEkuOc+DTKXq9X+qEqzG0W3rVW5NBO/MnfPhnl7VBfpmakuUo99mIpK?=
 =?us-ascii?Q?maKqoU/4MQZmwCzf+TFgJyyTJ6H7UGX3f/puOasBqyNea+MswlOw2g4avsuN?=
 =?us-ascii?Q?G4Czk/+0mm9Ki0ua0la5FP7t2Jsf8FR42vsHZv17jYpMRE3W+AmpIQ5J1FDF?=
 =?us-ascii?Q?Nu4nIx/ZRCoS8iRsxMMzh/Hk4fM9ecB+H1pfH3jB/F1nGUEh9x1cZZJgbPwr?=
 =?us-ascii?Q?6KFFnYYFY1GeZRYITuT8b5GtJOb6nAaTVAHQvzoM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9818f9c4-8b3c-45ad-5d41-08dce90eef81
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 09:35:53.9062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Y8BrQL1m3jsuCTyKcLY7fl+EfEb2v0TpsbzTXVKToJiVDE11CSHI5ECsPW3vNxJaXlEdYMltFS28sRJVgSK8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10856

When running "xdp-bench tx eno0" to test the XDP_TX feature of ENETC
on LS1028A, it was found that if the command was re-run multiple times,
Rx could not receive the frames, and the result of xdp-bench showed
that the rx rate was 0.

root@ls1028ardb:~# ./xdp-bench tx eno0
Hairpinning (XDP_TX) packets on eno0 (ifindex 3; driver fsl_enetc)
Summary                      2046 rx/s                  0 err,drop/s
Summary                         0 rx/s                  0 err,drop/s
Summary                         0 rx/s                  0 err,drop/s
Summary                         0 rx/s                  0 err,drop/s

By observing the Rx PIR and CIR registers, CIR is always 0x7FF and
PIR is always 0x7FE, which means that the Rx ring is full and can no
longer accommodate other Rx frames. Therefore, the problem is caused
by the Rx BD ring not being cleaned up.

Further analysis of the code revealed that the Rx BD ring will only
be cleaned if the "cleaned_cnt > xdp_tx_in_flight" condition is met.
Therefore, some debug logs were added to the driver and the current
values of cleaned_cnt and xdp_tx_in_flight were printed when the Rx
BD ring was full. The logs are as follows.

[  178.762419] [XDP TX] >> cleaned_cnt:1728, xdp_tx_in_flight:2140
[  178.771387] [XDP TX] >> cleaned_cnt:1941, xdp_tx_in_flight:2110
[  178.776058] [XDP TX] >> cleaned_cnt:1792, xdp_tx_in_flight:2110

From the results, the max value of xdp_tx_in_flight has reached 2140.
However, the size of the Rx BD ring is only 2048. So xdp_tx_in_flight
did not drop to 0 after enetc_stop() is called and the driver does not
clear it. The root cause is that NAPI is disabled too aggressively,
without having waited for the pending XDP_TX frames to be transmitted,
and their buffers recycled, so that xdp_tx_in_flight cannot naturally
drop to 0. Later, enetc_free_tx_ring() does free those stale, unsent
XDP_TX packets, but it is not coded up to also reset xdp_tx_in_flight,
hence the manifestation of the bug.

One option would be to cover this extra condition in enetc_free_tx_ring(),
but now that the ENETC_TX_DOWN exists, we have created a window at
the beginning of enetc_stop() where NAPI can still be scheduled, but
any concurrent enqueue will be blocked. Therefore, enetc_wait_bdrs()
and enetc_disable_tx_bdrs() can be called with NAPI still scheduled,
and it is guaranteed that this will not wait indefinitely, but instead
give us an indication that the pending TX frames have orderly dropped
to zero. Only then should we call napi_disable().

This way, enetc_free_tx_ring() becomes entirely redundant and can be
dropped as part of subsequent cleanup.

The change also refactors enetc_start() so that it looks like the
mirror opposite procedure of enetc_stop().

Fixes: ff58fda09096 ("net: enetc: prioritize ability to go down over packet processing")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes:
1. Modify the titile and rephrase the commit meesage.
2. Use the new solution as described in the title
v3: no changes.
v4 changes:
1. Modify the title and rephrase the commit message.
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


