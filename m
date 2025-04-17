Return-Path: <bpf+bounces-56125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAF8A91B55
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 14:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12FFC445295
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 12:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C752417D7;
	Thu, 17 Apr 2025 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TX8kjwU3"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013051.outbound.protection.outlook.com [52.101.72.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2101218787A;
	Thu, 17 Apr 2025 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744891241; cv=fail; b=auJg4vyIJBzYpmxxrPP4c5SebzVXyFs3D1o6p6ZX4g+znLN2xm0uxJHssarB7hmDjj4PKaf/Ao7GXb7iTK8WzvGuSYTyxkpBj2cbfbhCag1ul9apv4T/Qs+ZK8ePo2ydATRlPQqvFQUeagQkiAqOSxys9eCNaA4qirefZSWxq2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744891241; c=relaxed/simple;
	bh=FpUsVYzfNCWdQqHGQz+kG+y6d6WAXum4bx57XKsnHrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KzWUep/6tund/HrN4lVsmBfjC6OjA1g8I8yPEEJwbW1eHsXkYlVR0HgBEL/cCmfG2kU40+gOiRlQ8Q1U6teaLnD9Ith+ra/467a8jV+kUDsAQN8tYr6Atc7mJDtBHGl2jB/Giz2Z9JHpIa4T82nxHMO13tfdgxMF9aBvdrXWE08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TX8kjwU3; arc=fail smtp.client-ip=52.101.72.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0fp4TTthnPkDXXkoe/QFIHhuw2plhTEhDM0toECV//W+DexxM6fOZF5SYOtpmckBUk3htXkbDX4+vCQfC87HyhPNBYTR9tCamdLOPSdOC2H5i0OLj24YXChwox0gbN9bkC+GQCAoy2DRDzIxrCpRU4+b+1ks+ocIbtL0iCaLgePYYiaP8qH/VK+BP7LHzymR09PJl6b5I16aT1UEm9K/XC+zlA8+K091cR/PZSYqpmFsPlmTO2MBzdiVOnJEPA1SZSpsg8N3blbWZeR92BORVA1FVamIJdEZfCRtSWa/3YxuBnFhygWKPiB2cqvq9o1wDfC/ktJf89NVJXv+rkQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JstUKZ8C7GPihMUzQMTzBdG+HyCibMP0wcqF/qIjzy8=;
 b=pSqwsxVvF6WUVYxSaZjC6RKqCs4KQm78O05skc1IwhU0XjJJ8OmhK20G1ezdNZv11rjlVpSlXJPljFdbHxKPp1bngci0pIN/rNRwkgHwkRaCwgDY7FvipHdx1mMPkeC9i0IkJC3+iBvKRLxUrkDNwZmu1bM8WK48ZMEs7uIrpbCgF6ccgAp0H5QlFbGS92lvtaenO9etX9GHrGDEqvHXh2qa5MZCN39bY0c1LsklK5AIcZvquwbLIm1ZKBtF5hismrq/lIAmrAICkCiUvhBC849ejL7KbRfV/UKG9GMVL5ou+HsDDrR9n/S8q9+R7De6vVhrYitltZ0sH9AdV/uaPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JstUKZ8C7GPihMUzQMTzBdG+HyCibMP0wcqF/qIjzy8=;
 b=TX8kjwU3AK/qvzSiWtrzYPFT2DY+WpnFi2DA2jqjrGHP8bjBuNLIow0navon+RHqPp6g6WRU/BENDNeN35brMkpTU+QzmXLfhUfY8lN5MnjmaoVMapNrvRTchHbed/RQHM4zRK800R5cPazsCrfDlqxjcMaSphf29oSQuTKjl3h+UWr1M6rMCWHP52wvhTg+25XZpvL6T/ArG+P/9SDMKsspcHTLqmtQGphh4+5XTYUYrUA3yHiqhYv0dG5yifDoFkXk2QwG9ljzjQhIPyytxwYalkdalJYGLUzwKSi4tQ9JQp1Vb6QTMnYkp1UaQnYD7iU+OePEvuHJISVixX98LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV1PR04MB10560.eurprd04.prod.outlook.com (2603:10a6:150:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 12:00:35 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 12:00:35 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Vlatko Markovikj <vlatko.markovikj@etas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net 0/3] ENETC bug fixes for bpf_xdp_adjust_head() and bpf_xdp_adjust_tail()
Date: Thu, 17 Apr 2025 15:00:02 +0300
Message-Id: <20250417120005.3288549-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0023.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::13) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV1PR04MB10560:EE_
X-MS-Office365-Filtering-Correlation-Id: d9108da5-9c50-474b-526f-08dd7da77658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+GJdCwI2zcYLEu1pMqcwAn6C9Cu3pbwJqeHAqHh+IZjpFkWp/X2nO2eMPrkl?=
 =?us-ascii?Q?uRzUWrfs6xV5QzEbrSei3fe4N4L3m8KDbTPlgRzU16glQN52+zlupiXaR9dp?=
 =?us-ascii?Q?oTh4tXNHMApMx6dvyN4AFOcqEbgQRj72qGoniDOYvPDDGAdzHq+wQJDvorlE?=
 =?us-ascii?Q?9j09kEX0nlsQQWlaOKrSX7P2dosSEBz3F4cHA0bvTQOZfGPCGo0yGs1cbAPj?=
 =?us-ascii?Q?eVNzUJb0cfmbg+Oifdi4lCEuPUXOFwObNgH3G9f+l6lcqQHn0Dks719uOk6M?=
 =?us-ascii?Q?JO16nNKy/B6UPwoZvYk4Fe/mjLWS8Xq55Tp/oXrCzW6iOfXg27cpGTqlUUHr?=
 =?us-ascii?Q?3Dmia5PnBOfx8uOeNLzGiSmPeltQdApCMyr1ArPYv51c16VUGPdaffpmAsdH?=
 =?us-ascii?Q?Dl4J6+keNcyyo8LmJ6yY1TwmYvpAr5Mh1dWT+Y+uEnD9OAKnAEJUautibqe0?=
 =?us-ascii?Q?kkjRj9RN4rSLRQ8l+fkvA4yoE7WVHMT+AQdrIOSWD8hYTeBaiP1KfX5qSsfN?=
 =?us-ascii?Q?Iph38cV4zKwuQrWNGCIuhYBskeml0eTYqOCbNQSYTCmZE9BCfqAGb1RxyATP?=
 =?us-ascii?Q?fzbJuLYJmxTzLOwMi4FzfZiLNu5gm2lLUsZM/i+efl3yOPY5wVyvugvUFU57?=
 =?us-ascii?Q?nCAEAhK8GeDGBJb8s8fSPsVRzaN+gEHuXt4FNrlHuoSOvlYB+iXbBvYf7tyI?=
 =?us-ascii?Q?QUp3htmvSG69mgwVom2kEL6giYI7EVpuhP1jeUdcbLqo4AYh3GrUQKH1La6F?=
 =?us-ascii?Q?YcG8DhdsiBCgRtc/1fXhYamQfEzi+dvHCbAIUE0+1aFWwgMVZWhZgoIoASN6?=
 =?us-ascii?Q?C0477rSQ9QBGgxhZaZZQPMmJSdxL8ftEPWIpbTb6TozfaxUvJj1ZOtOhlyox?=
 =?us-ascii?Q?vcZ/OejaZoqQqWqP0KNzz25kvh5k6jLcuEdXqwkxnY3DOHZPsnZlfG8fizot?=
 =?us-ascii?Q?FsPuS29RSDwN7XbKAFXRxj+9DRYQ2nyUVdQ8w89lFMBdRqy3Ma8eO38F35xv?=
 =?us-ascii?Q?JY4JJWrv/KKm5HSsQbSbOZU5E2YP4O3zVZ38HjrbR/PB8xonb5mBy5rgVBPd?=
 =?us-ascii?Q?vcXeJbBEyFs6VGxuKyo3zRCCQK5CIl6IwKOKLiIzRaeQChBJDPiewMVFy7rx?=
 =?us-ascii?Q?b8ObumdLJVep5jGAAUq5Ma7uKGD42EforBcf27B0tsp4xkyBr3z4Wd/neovq?=
 =?us-ascii?Q?0UWVXTQq1ZDoSFv+OzQDMhozeGd6Ub7oeVS2en3FLnTUs/JIuLhdJ603FBne?=
 =?us-ascii?Q?04G3quRQy4imwL/fOFDITzQYwIMUO4291UHEH8+EPc8Mk1c5fjpShz8jmlsB?=
 =?us-ascii?Q?56HYy5Fz1+tfWAs8Infz55MTUrz5SfRfELaw2MhxzkaK5MF8Pr0uOwZW6bAq?=
 =?us-ascii?Q?MuIbNJsvK8wdfDA1NXzmO0rzCo/DrnPUTzbR1i8CMHj34JAsbta4wycHiWKk?=
 =?us-ascii?Q?swrlcM/mMQaOfxQC1ZZEUGQhCQRuf7DJxx7Kvx33L08BmPYKnRoBCw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bdNLZyww+Ra/011GZplhZNWn05vqABoIarwuDsynqgPYOiTHp/WwO8fE3MeZ?=
 =?us-ascii?Q?Ie4LvHDUQ4hoqtb9Ry5PlHMY+Akn9NAb+WbeqBB+I84wJiWFnfymayrPRC1I?=
 =?us-ascii?Q?4TYHg/o0r/sJZ6KYZHz+8NpakIQGzCChoscLo8UBbOeHMYw1sPgQasMqi5F/?=
 =?us-ascii?Q?TTp7zmXqcM+aACowKPR8AJK2f0BhFbJC6tSVX+vMtHyhEWkPnyF5w3n7g4Cg?=
 =?us-ascii?Q?4NCSoMnspCCmp7v+o8WMOV2OUtSGvigzsgmG9b8bW9G1FUIBLziG4bbBcZmf?=
 =?us-ascii?Q?Cg4l/3WLa1yS34ZS4GDqlOs/7ppOixBqLuxp63j1xHnaQrrI8jnkFFEaNGPy?=
 =?us-ascii?Q?jaHb44Sw+nfC6kXGNisfmn6C6P3oDI4vhCgoMF1IPvaCsa/9v/Y0pXLgqtZa?=
 =?us-ascii?Q?bGKcwgYeyrYMKoqhJybUZa/GiHLCoapgNjEDndA1uv0v2PKSkWrZ84t4HKC6?=
 =?us-ascii?Q?VZ9XfkkQxjgEXNXhjQE4rLJLhJL3g2Wdcj66x4gY9lKsfu/J4F/Cyu36Vc6P?=
 =?us-ascii?Q?m4CnE9kx88w1pouOPL8da0at+VGRYAPr5OXcAZzSbLlaML9GI/rM7lrPb5zm?=
 =?us-ascii?Q?KqQjOX68Pz5eaJYE4cloOHCwnmyW/9cT6+JzkV1tQTxO16Q30V1pYUbyNwsr?=
 =?us-ascii?Q?Zcn/OmqCadNFNVpiX9OkKu3ynhQcyiim+sV5hV1PGx+MzsLjk5YU1gH4/lkg?=
 =?us-ascii?Q?sYGGL3BZkFCWWrRxFAHPvZZxYXzF2++v6I9hsqIzb0ptEeQZe6hSTO4Qh0Co?=
 =?us-ascii?Q?58ViPlmfnK8WBWLYdNqPXM+9TzzfQ21zTF9rHVgYRGTNUrZ3BuJDCDqM3Dh4?=
 =?us-ascii?Q?rKDqK4E6ccliHG+4ZznM8+BJ8z06ofuZ9KRkfeSvJhVXX/DKOglCJDCNrcOI?=
 =?us-ascii?Q?B27x6rJdQGku2xSD17aNco6ZlJttodyW9bYQeJS3qf2FadHeG1q1xDjawPq+?=
 =?us-ascii?Q?/RaCGcSPT9FJAy2th3uvEJwh1K0Phg54f/A71zp3HLyc78raojTylQVF3THs?=
 =?us-ascii?Q?6D6+mXhJXQv5ypX/HPDysInyOZXXqWrU5xtXNP3BttUb/fiwMU6VpCTgpTXZ?=
 =?us-ascii?Q?pMWXuoWNytrTY1Uim5l7IcPDFeZTJ96HwIOIhLVq43syDe7uFIHK2Uo8fN2A?=
 =?us-ascii?Q?Oe2RPnsgbWULn6yJSGmiq8dMxSFcVGC+6//2bp1UVPraiMNX/bik7ycldsIW?=
 =?us-ascii?Q?Tfq54btmEBU8+kqVqU9894ECag7vKv5tnzQhzofdD94ihYBQJzAT9KY5QVZz?=
 =?us-ascii?Q?W6D+9DV5SxLgvXZ8UxFCUndUK+zL+w8vkIWqNjDx9L63owKsNXiJZXY1I1oY?=
 =?us-ascii?Q?0fdIhR9VtciveRqKPA+KF/3p0Kj7Mr5ILuPJ4S8M/OL3mFjaFHHwDIvK1Kh7?=
 =?us-ascii?Q?OlIcEq61Qyd7qlPvrb83c7rP7xQxf4Xe8NkZT9kaBOqRHszGxB5KpEAabASu?=
 =?us-ascii?Q?TJ6cXXUp1I2mxpQWtWRs6h6u0mUMULP4cjKYWSp8FZYXLLLp3cey7F0wW7Xi?=
 =?us-ascii?Q?R/HoyQ9wdpROrqjkXfBjUF0P7Ah/BTdDMWHhVGsZlZ15qj9TXivbV+4m05li?=
 =?us-ascii?Q?Ku92UREoyWkjV8IxN+3NhQb2fbX6oRDoVRQJVsMwZWFmepR+UpxPcKKvonsx?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9108da5-9c50-474b-526f-08dd7da77658
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 12:00:35.7068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYkK30AmJNuqhvjtPEHH4tNTb+235BV89vkp3qJ2c0mry6LPpbclUSOGH7ZgPCyqfwol8qceWJqLVzlkY1ib9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10560

It has been reported that on the ENETC driver, bpf_xdp_adjust_head()
and bpf_xdp_adjust_tail() are broken in combination with the XDP_PASS
verdict. I have constructed a series a simple XDP programs and tested
with various packet sizes and confirmed that this is the case.

Patch 3/3 fixes the core issue, which is that the sk_buff created on
XDP_PASS is created by the driver as if XDP never ran, but in fact the
geometry needs to be adjusted according to the delta applied by the
program on the original xdp_buff. It depends on commit 539c1fba1ac7
("xdp: add generic xdp_build_skb_from_buff()") which is not available in
"stable" but perhaps should be.

Patch 2/3 is a small refactor necessary for 3/3.

Patch 1/3 fixes a related issue I noticed, which is that
bpf_xdp_adjust_tail() with a positive offset works for linear XDP
buffers, but returns an error for non-linear ones, even if there is
plenty of space in the final page fragment.

Vladimir Oltean (3):
  net: enetc: register XDP RX queues with frag_size
  net: enetc: refactor bulk flipping of RX buffers to separate function
  net: enetc: fix frame corruption on bpf_xdp_adjust_head/tail() and
    XDP_PASS

 drivers/net/ethernet/freescale/enetc/enetc.c | 45 ++++++++++++--------
 1 file changed, 28 insertions(+), 17 deletions(-)

-- 
2.34.1


