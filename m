Return-Path: <bpf+bounces-41554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3D9998268
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 11:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED441C23A6D
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 09:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDC31BDA84;
	Thu, 10 Oct 2024 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YB6Z8Wpz"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B16B1BCA07;
	Thu, 10 Oct 2024 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552946; cv=fail; b=aNDNwKDKS1o2uGH6UOylxQEPVa+0oCZo8hmD1zs+OLITOg4Gizym1lfdswW/Ce9ceTOf5mKNPE3xKVz2d/Qhw3tTl6FY6+LWMl54Kp9bS9nHP23cxm1p1hQjIdSaEq8YUXJllhqSCXl97GklAYYoWJPDZQBw1LaZOhhc8h7Cbso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552946; c=relaxed/simple;
	bh=BNp1PPLf7Itya7K86iPb9MexCuPDtFACR9SLTG5S7Nc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JzoRL9rKASDGcD6xvAdbMDrVJZHc5nD9IaLFp9Gv6dRpQBCdXQ7MntVQQIgP/t/YaIXPfv98wo7BgVWOSLySGahopni+i/rS7U50+ukrDJn2urS7o54SrgyAvJXCFmqzPKBBfG/TB+ol1g5jUGl+RSrsxQI87pc8gnHppcq2Je8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YB6Z8Wpz; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSAjQSKb2LCd7YGCjxKNA1eE81LCbk645o3uxF0PmwV3JlADUTU/B5uKV5c/vNm/os0QC3ESmR4mr1Lla8NAb85YdjUq3oblb5hDRco6joiYXlALHkhgK/vLOoKq7GZ9i4qK29eftE6Vj6V2dto6mP5oYyAS5n6mHKVL+q8+tJg4ZU/IDJb1mZQHLRspsrVgsQc2+k6TzkCkVFCAS9TKl5TmOlJ1+ZGJdI1sLkUrP0v2FQa8ZB+emDThxiXR3tgFOhIGgywMyI0dDbDJeqv6P2r+e1JEVEPUFqXwuZumxH1CL17BJvZn1+JcPvxRy4hQtoBzbuGNO2uWY+Ms40m4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbgL4c98ZuZs8xDtLLH0rxBccZgVRUIlsAB8EEj4Ibg=;
 b=Guc091hOgUJVbmvFhIIVwLTWWMCtIu5VcXo4o7N43YtV23V7Wvhh6/oicn22HQMi9W0qCkyrktYkpVA1Ey0C5zUAuwFuEgWvDUkuyBAbZDXUG6SDTyR+CoqykDbMJgJGJoKOVA4jo2kbYgUEvWOVlisjU8mnDY/P2FhA64vH4WMefzOCjYuv/vqwx7Jv2ovpZt+FWlGAIzM5fK9i/cx9tgbn1W4NkX1GZKbpIMuu+ymc4YK0e5TigPZagm6qfjmsR/J5Qp3j3H6BtzfkWHEHxiw1aNhyGZ4fgYlmOPlyFdcLHTuRwNWFAXxXreTwF437Sa5V3cqxvO9bxiKzI4SYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbgL4c98ZuZs8xDtLLH0rxBccZgVRUIlsAB8EEj4Ibg=;
 b=YB6Z8WpzjR9qDMMhyVGZU5KBH6vUR9frIrWyZ6Lzfw/15WsNmegkWEHwJZHl67cFreY3FzBRJT0xJzKKN2iH0YX8vfg+/G/FaB5TDfkBgy7/6AcTfPczyRzbzfEySyfRlnovirQ8lV7UxWKNiB9s+jTGSe+zjQW7skITsdfOIHW/CjgP19Sodr3sck2FHEYsZMJW/spOXooUxDuE5GcdQ8Tn0MYlr+npNL0KeIlzrc1R6esI4ke9RchizvzF6Dqlkb201yTnnRNZQ7W6NVzfAOKXsJhf4zZ1bQO8deLYn2yJjSzaLuChqBA3qj74IbvdNHlNyHuxrZym45WPF5s0eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB6847.eurprd04.prod.outlook.com (2603:10a6:803:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 09:35:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Thu, 10 Oct 2024
 09:35:37 +0000
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
Subject: [PATCH v4 net 1/4] net: enetc: remove xdp_drops statistic from enetc_xdp_drop()
Date: Thu, 10 Oct 2024 17:20:53 +0800
Message-Id: <20241010092056.298128-2-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI1PR04MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: e0eac67c-5eee-4530-1efb-08dce90ee4df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+XZdq71yckMDv6ymBXth1L3eMBqjY+lyvoQTuidjWBhzUSUSb1t6tWvxljxl?=
 =?us-ascii?Q?G2B3nrO+bSmJy3Fsq3AmkpXRc7NnHOKpKQdIY85ND1H2rkEEAXKi9kvDPAZQ?=
 =?us-ascii?Q?mhz7NeDK4Z8mehJ3mOAXxfaZQl1uf2x8IIqvSJaix1ia0w9YGdv3xqWfwoEx?=
 =?us-ascii?Q?d4tt8wAbt0CXfCxiRoGHPeaiZxWD3YxDkC8KW+hvAjfTfSIEmQHNFlb/gjIx?=
 =?us-ascii?Q?7b/3ZOIzibLd+zrstWw7Ht/6cAMNOuzc+0Dftva0XD/sfPl6m2xFokvL9xdq?=
 =?us-ascii?Q?g8Nf198wW5XJAbdOVN3GgcFCkjxNrbe5G1KExaYFpDrm6oKHKs6AgG0CufdW?=
 =?us-ascii?Q?GC3XswmC8C5zoGeYVGZgj2eT8Qv049xNl+VKlKohCDlj4cYZfvXBFT9txipF?=
 =?us-ascii?Q?HFvlTSpNCYgx+pg45rqMvD9pKXNs5xpmOsC4dPYU/xPtIg9FOayLcH1lIQt4?=
 =?us-ascii?Q?SCFEcCnFfRm/gLY/YB5RAQ8Vwzt9k/61sHKlucxXEzFBlrvVO+bRXLcDeir5?=
 =?us-ascii?Q?fgb0DObh3UeRHbAe9QsdY92UkWQ/EN0ZV74s9pdGuf+46h0Xmv4f9sR13Rv0?=
 =?us-ascii?Q?Vv9pkvmRdQ6X50adjHPJLCBZpEvMgMIA1H9uUUuj+YaZcR4lWGzEqEEnYifV?=
 =?us-ascii?Q?By4Mna5AeI1OS5a+IeV/D98Ca4fGlZXJhoJsMrFNCvJQZcRIjpHJ3uylyZRr?=
 =?us-ascii?Q?vQBeI6MB26ldgUJRsXRCL+ZoreiKN6ZAbkwx/PhBgE6MU3srtk5Vt2gxfkvI?=
 =?us-ascii?Q?NxnKjSO2WaSnf15qw9+PnGPcAR37s7A4iW5xM53jO8kVPDWmjAox4Yxtdh0L?=
 =?us-ascii?Q?tcbcum4v3tLzyxZ1lV87oKRFlZS8mnzYzInGil1nEHi+/HUPNG1USVWE/xtO?=
 =?us-ascii?Q?Eae39Kzm/nD8kafIayforyGdyxGNOyCE1DeDLHnIRMGQz5iI984h09KXJaUZ?=
 =?us-ascii?Q?2ENz/5QWGnqRiZoQKPsVPNc57dePZ/eXkeHVie6/MMUKbbQZZWyEf3D9cnjP?=
 =?us-ascii?Q?2UF378C1nbIHdjln2YaTv0WY0egp4drACj/u1ISRswqpE62L3Dj9I4+E+yiC?=
 =?us-ascii?Q?H1lmmbuZMcvWivkx7riJI7wUfviHD3nDvdTi7t+ImHUM5oEGtWkwkjjpiuvo?=
 =?us-ascii?Q?oXteDcqd3nn5HsSL/RyDoEPdb7IAaLDh8v0+0jW+HGU1D1WTwVqwtCAqDt44?=
 =?us-ascii?Q?CoRGqxS+G0G4Od4d+2UPQU56RBb3M780nLIrp/agJkriIMl2n440nuJak7gv?=
 =?us-ascii?Q?73FJ+Ul/AzdUhIf7boE4vsAMwck2kzgNj+l/GJ3mJQ2Ey3tasK1ktqp2pCQs?=
 =?us-ascii?Q?m7cwrSOonJlHQ84ymFjK6+15RCrhJCtLd6SOKcR0NyqpXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wxXQo3kBsx2+d87WxDs8JUUyl5tkxLZXrYsTqZ7VM2JqxLgaQOFan7FPTAXD?=
 =?us-ascii?Q?vFTnjzbkgqgpRzDXORtkf9MLaAd7aTPnMby1viQ+IxBUyJI8leQBIn0jQTP9?=
 =?us-ascii?Q?OE5QX2Yp7LQ1Kk2PihZelAhUJ11hgICeaV2afkkpxW+W9CXH/NYb2C3H0YS5?=
 =?us-ascii?Q?cxlW6zN05zXUhuaoIj6LO6+zcO2uYhdttnYHMHaHNFhCtZn37lYTzePKaRph?=
 =?us-ascii?Q?6M/6D7yaMWo1nKn4Z96VC7O7y4nNHkzT3AnWkTKRq+JgGCgzFDE5SAKh22tr?=
 =?us-ascii?Q?auhzj3/VzZ9IbiK34kQGVm36VVlW6b/MVLGnLLtJnbuVW5vctVfrf9x0cBpd?=
 =?us-ascii?Q?kAO0cSUyqyeHLfScKMnU2RwWytS9xnMLeXDW6GIbNYsiHFWZcQciXYMH49CO?=
 =?us-ascii?Q?JqsaEONSza8AwndhRllgbhsFdLa4/RiI+5pGS3c/GvLu5JEBRlonni1z4X+j?=
 =?us-ascii?Q?BWBd9nMYn1Ex7oVeMhKml288iOnW+HRtsKZX6PrQe8k/HbSAY89/ElsJQZ53?=
 =?us-ascii?Q?bB4yB2Aea2oJo1CSCIVrJycRF3J5kQor3QtYQvivTiKLsXQi0/6f8wsg3s1o?=
 =?us-ascii?Q?pckL/95c/Lb/189wcXYHhdm+8yxSRVKdUOTGt/Tztl0TeXBWlqcxHJwCtzL9?=
 =?us-ascii?Q?8Ex944E4hKKk9h8nRHphjhbg8bPl4wUQB/GVF8ERjY6fbuwhBWhBog+6tqy9?=
 =?us-ascii?Q?XikN/t1S77PTC0FEoCWOcWx+3qcjPlu953fX+ec3eptWhAAF+y2R+IZRHvPG?=
 =?us-ascii?Q?SMfu8vskjmI+kXagM3I+fPt6DJ8Juf2Xya5xfLq8ugI00eP3o+r7qppj2Wtu?=
 =?us-ascii?Q?ZTDiZkyZqfIb+d6Yv3sW8TkoUnI9iZZ4/6wROXTbOyiVuKI8FGz7tNH5waoN?=
 =?us-ascii?Q?cso1MUacaJKF+FDZ9qGqfBJwcI7fjCY/bDqVL0oxw4r4peo5ZyQjYZ7uISEi?=
 =?us-ascii?Q?iNDdPgXDyuxMYY3E+L0KcH4+F+oKWEIgMNz/hrLvhpVAxMLCSDt6baAUnscl?=
 =?us-ascii?Q?ZvMWziDYDwzcgf9WmOLpAi9abvezhqCUBGT216a6N3YXLUpBL2d8Cs7yolt6?=
 =?us-ascii?Q?8H1F6dBHzoqQTLWbIld2E6qMT0DZ4HMYSDZ2YCPPXtys9V34dTygjCpuKMLD?=
 =?us-ascii?Q?at9/hcj75Dzxs78r5UgDzeBDEf2KIPr3LVsazJYRSOKZzwKrF3Ygqewstkwh?=
 =?us-ascii?Q?ihbmNUgW20Vq1EC+N5tIi7r4UcBrA1Ji5uoXx2cS7SDA8cv0EhPcka4sCBz8?=
 =?us-ascii?Q?xG6s2yboKUPbnXfhe/xDcAdAXHd5QKwnpNbcfAS0N2eNZIDkh3u/v/6g9Jw1?=
 =?us-ascii?Q?xVDlMX10URvU2JnMZveC06UIVmg2sKsuPI6R26q5Kcioypdoa6g/JFov6uts?=
 =?us-ascii?Q?VRrQ9lw+tZ2R2yeV5p/wN3QOOLAMpV4o+FVDFe7MW9lkSW2AXcs04cKEZSri?=
 =?us-ascii?Q?Hmmt17r4VIrJ1dGzOalzuxmOaK3SDRhSj/zP1beszH8xQueXM4j/0qFU+7ko?=
 =?us-ascii?Q?+KkH/6vs3DqB93wZG3l5qDzllQ052r0PwrfrH9aoK8bjSxBoerwvRiSXxRR4?=
 =?us-ascii?Q?ToH2+qYwLwFQ/f7urceDJNv4ab5kkGcBaDw5B4fS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0eac67c-5eee-4530-1efb-08dce90ee4df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 09:35:36.0940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SrVtQwpwgdYoMdzBcKQ6RXTFCGpiKjP9NiUZFtHGMVs8KvwO6MvVYShjZM26Hpw+XiMW8iNMt86qMwmqa+j8XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6847

The xdp_drops statistic indicates the number of XDP frames dropped in
the Rx direction. However, enetc_xdp_drop() is also used in XDP_TX and
XDP_REDIRECT actions. If frame loss occurs in these two actions, the
frames loss count should not be included in xdp_drops, because there
are already xdp_tx_drops and xdp_redirect_failures to count the frame
loss of these two actions, so it's better to remove xdp_drops statistic
from enetc_xdp_drop() and increase xdp_drops in XDP_DROP action.

Fixes: 7ed2bc80074e ("net: enetc: add support for XDP_TX")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2: no changes
v3: no changes
v4: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 032d8eadd003..56e59721ec7d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1521,7 +1521,6 @@ static void enetc_xdp_drop(struct enetc_bdr *rx_ring, int rx_ring_first,
 				  &rx_ring->rx_swbd[rx_ring_first]);
 		enetc_bdr_idx_inc(rx_ring, &rx_ring_first);
 	}
-	rx_ring->stats.xdp_drops++;
 }
 
 static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
@@ -1586,6 +1585,7 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 			fallthrough;
 		case XDP_DROP:
 			enetc_xdp_drop(rx_ring, orig_i, i);
+			rx_ring->stats.xdp_drops++;
 			break;
 		case XDP_PASS:
 			rxbd = orig_rxbd;
-- 
2.34.1


