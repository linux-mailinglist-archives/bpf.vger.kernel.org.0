Return-Path: <bpf+bounces-56127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5120AA91B5A
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 14:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B4A17AEC04
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 12:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EACF24397B;
	Thu, 17 Apr 2025 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pe1p0MmA"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013051.outbound.protection.outlook.com [52.101.72.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8DE242907;
	Thu, 17 Apr 2025 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744891246; cv=fail; b=Ghxv8lqcV0y0HGYis/H3tqFVNcF0lkkvxLY9Lh08H4wIokmuFPrBDZAmgqmSwyvWEjiD0AlyA6/v+ijbuvgwTtmCzo0efET85uyXVHac7YP5Y27B6gvQX9qOhK6ilyZtotB+PzHm+CVGVSxsuG+yRDZJ+hYF39z/yYHzAht6+T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744891246; c=relaxed/simple;
	bh=8S6yUrg1ZvK+Oj38HZYGnZWznYiY4q1yXKwUUX11VxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pig9umvZLw0SIiRcdp/Ra1gXq9oMqI/EyITQiiOZpQyV2BO27nffyMya8e646SOZGxhFBFJhRtoAH6XjgRqyNvk5mx5CZZ7LqIRlZGtahGNrwcdgapv4Rdlwp7kA/NsEIBFuB8lPioNOyRZxjK1TNpXAbz8z0wBrgYnEh8frv4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pe1p0MmA; arc=fail smtp.client-ip=52.101.72.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrT1/RI6doRYvjOZaIfX6QlRCp49vE/Ug9uI02jXtIWRNM5zDcER+jOLg3sTBv0EOLkenxu0lMpcVI6lTaXwbBukCBVeSSuO18sHAKnwQ2YAonsHl8NcIXNXmJOzP+CuR1zelezxaMPwAF4YaiB/e7Z0I9SwpZz+Ez9jqkiCnhNsfr380PZmUAcZK6AAt03mFEA5puybh4/ddP3p3v5cCKjGcn5n66NqCPsfg2d3v1ggmjvA2ROR/pkrpM88ita4br8Ceds84e4lQy+c03NeIQ9D+3QUhE4anwIfcdQfRykGVgQ+aZNFlvQi2q35qpn/Rq77CxEwRZZGiovrBe4r3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qoHc/2FGyWzW+IkjzEmCSmrCo42ed4P3ySwXmq6wbg=;
 b=bPZnlj9Dgu8/O+gbFOHNwN4qhibpBZRybIFIu9m06CDB4EQHvtzJFuzWNWwJwIZw1NApyzel8z37/4Xuon4c4hu3gDju9PEe9dFSCypE840mFActaCSdhGPis27zybn3Tv/BnF+jMqcp+LR+AdkFfsqlrb44L92dt1mVVoHHaYGd8xCSvAUDZ5pc1ywYNYIeFOnw07Iy7cmJ5DTEWKN68adwDSBJAiF8EWTQ4Z/ONtszBjDcu3HR8nIFP056LCJYw1yCoRJrS4BWylwC0XOWZ595G3gKDMYKiYEZyRQx1Tz/MZsQM0qqaoMMSNZy7I7qlo3rcc5ldTq+QVLdVEOFqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qoHc/2FGyWzW+IkjzEmCSmrCo42ed4P3ySwXmq6wbg=;
 b=Pe1p0MmAI1YBYgV4wDFP/k8orXBD/lZnX5QOKzhH5C7giQHhFqcgL/g5j4e6va54RidMi48cSNOj0tOqYS4qYTHZjZ2EVlh0y9PsdhzkxoWxpqYiJYzLehpIy2fNXfLdmhJQXwqY7ezoqhOZfHCUj58jlplSHk5seg4VmnZP44mrrGeAYJXVjB9XXo36rkU2+8bcAvS4cVCAI18Iqw9bA9MjZI6Bksmdw3K8oI0drK75Z0QCn1zjRG//nQhILycG+dU+OBBqfqT6o5rh5j3YjS3wPn5MrZdv2spLwwgrX4YLgvP/V+kmEaqfbDu2rqa4ifaFPg66kME/sh2B8IfzAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV1PR04MB10560.eurprd04.prod.outlook.com (2603:10a6:150:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 12:00:40 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 12:00:40 +0000
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
Subject: [PATCH net 2/3] net: enetc: refactor bulk flipping of RX buffers to separate function
Date: Thu, 17 Apr 2025 15:00:04 +0300
Message-Id: <20250417120005.3288549-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417120005.3288549-1-vladimir.oltean@nxp.com>
References: <20250417120005.3288549-1-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c71d6cfc-2b97-4ac8-a323-08dd7da77806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fm1kKNUJ0eC6fUGuN+y2jbA2v/MKLafNuwNLRR+S6+l48qXE4T8QZB4w6uee?=
 =?us-ascii?Q?M4628dihE0vG5kRHGs2E83NrpFbJMUOhzETqglVPU+rQmt6gyPK1Jf/RWO1L?=
 =?us-ascii?Q?Nmjdw2FqwNaqsbs/ThWgghJPkt4NgqSN9OXrotDJMn4F80BXSMyUhFLnoxTg?=
 =?us-ascii?Q?piRwBGJiwIxhGD305TBNhMsgSMbNN50UyHcLBaaJ6frE+Z6FPXwzCKMh2Fre?=
 =?us-ascii?Q?94n3LQPj89SkLL0x+l1uqsrUxQKgRsyYEvKdDXvTqNyVHSzKcW5b/WnJ2tds?=
 =?us-ascii?Q?qFgMcz3TAbD6RzRZMSgjNB33lriOxOoJWq2c3EfplhEgpEf46/5iUy/HeSZx?=
 =?us-ascii?Q?NcB3u7Qz8xgkEkGPN12WxDhB8I9FIXXAkxaoLpqgLJDpRFtSiYWNq3WFs2fa?=
 =?us-ascii?Q?OO1Q5j7jC2YHoZCvaiONQmihQ30Ka/lqF3GbW0SRcom0HnJby7dqpXNt/cM2?=
 =?us-ascii?Q?N5K6Cbkz+YsFr4ihL3iGUG/svc0imgSRn2BV9+ZuHMd7ZGDOFGXSY7G+lnVa?=
 =?us-ascii?Q?HZ7OOxjugOrUmSvB017qhR1DMig9fOzz6LpY8z5A2cweCwSbDsKDZMruqbbc?=
 =?us-ascii?Q?zD8Xkgso95RVtDlHHVdavwVjPMcZU1KHzQc4R0g80BX85Y7eVPX03ZvvMSkC?=
 =?us-ascii?Q?yq788bf4h1ig/7TDFupAegWdXwze//nYAiVAzY1dKvifdtXIlT2X/RPXbRG+?=
 =?us-ascii?Q?f+K9HMuOdmmL1YqVHG1ZxA+TjqkQlF7iILMLt8Qxc7FyU0/G1hym7eDNeGxI?=
 =?us-ascii?Q?iQpxbwQzGJyQ/9vw4FSSd79EwfHjrCKNYig4VQoWFI40DM/NHpIZ0u73xAST?=
 =?us-ascii?Q?p8SxUXrQ3ODlXvFRK8SvCa2haW/ZqgtMfr5gsSa/G78npkDDxZXpILqLaSY5?=
 =?us-ascii?Q?3xZ+W/l6XAqZcVZ3VhDJ+tjPjvl/F6yxaa6FPwP3yxrQ4Eqrs23zkhpHo+XI?=
 =?us-ascii?Q?rR36abwKkBtk6HTJonge624bKPwErg/HMLeGHKXX3z37jUWx3rSH8I3vD0sD?=
 =?us-ascii?Q?hyXIAVEZXKN6dxqE/qQa54AcXTig3tzP5sXKACFQs6d9P+bb0P0iE/5RqaWq?=
 =?us-ascii?Q?SCEDDMfwRDG8zklbyGllFAVp7quYtbi78/QuskbcF639gw+7u8+YndTHz+35?=
 =?us-ascii?Q?HQGlWJcNcO/B7duTTSL69M88F2gSdTgyEl7O8Z44qpHHBH/+DDKuDanDfOsl?=
 =?us-ascii?Q?n5DvJjS1EZi2aGrjEWomnMOcXjvkdnvLEP13YIFzQrl1EgG5vg9zbvAJuir4?=
 =?us-ascii?Q?QVfRU0tyIJDo+PXUHf3ZvlY6ipWOk/1n3mjSooOfwe13zGN/yIlJgAwMICwa?=
 =?us-ascii?Q?vv6uGyyir8UqaboBo8Ay9XA3KJsJCpB6ge3E5pBTKS0/qFpno4MWCdAiA3AO?=
 =?us-ascii?Q?Dk8KdHUktx1fkazCZl0pE5QR4J8Hk0d40+YU4jD/m/1AxSOzOJlZ5D6U+ULW?=
 =?us-ascii?Q?cksl2RAnzuaaefl9ixOz9uTuAUQcGdxk14zVZehJdAo7d6GxckSCew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7UhDKfuphoxFrsnQF6QQc250XnVKg/XIHN5RJpcqIqtRNOixgMuRLPjS8kyv?=
 =?us-ascii?Q?xTtb4R5utg/VQ3paSyAvVVRV56s+urNhmaB/AMEUr9+jyakDipHf7duMTkld?=
 =?us-ascii?Q?8vl6uukrJXpjH2466aAakd9e29kGrcAR/BjjE82TBSbFRoWca0WeqCFe8GwZ?=
 =?us-ascii?Q?eLzPh10G1Jpk2dJt2i/yDERg0pU0Olyh0aVBTaSu60hwodaBCbhCaqdXcLo8?=
 =?us-ascii?Q?q8rlvQHV7PrZ4FL8/S/UQbx5rAOjdRJKx2n5RShsuJoz9vmyT90MAo84UfFI?=
 =?us-ascii?Q?FBUPvKkh/BX0TMkbU2rEu4uSu+rDcsh6jTVfIfk9e5w6ffr6jY2dEaYTjeyK?=
 =?us-ascii?Q?QSADKnU3K/eVJtqmutbhum9zPdQyA3t+/gjgoDzoKdh8nDkvXzS4e4n9TZc1?=
 =?us-ascii?Q?/Ch/j9bbrwQQR+YKj1nQXN/3+J3/WWkiT9pTIKawicdbeOWQeT6x/r2TXqD6?=
 =?us-ascii?Q?nUUJVPcI4RhtGgcKnpdzpVA9nyYa/lpUJJIsU+mFxYKSeZHkVc3h+PXbabOI?=
 =?us-ascii?Q?YwdQiNgzR2Yp3CIv45j0GtEa0n6EC4YKufV7FWBbwGtwgtZRA9lDdN4REZiW?=
 =?us-ascii?Q?J7FIR9K0kpI3khUUO7fEkD9zQAnnsAaBkzgQjkLRC/XNoCWTuphx173jL0L2?=
 =?us-ascii?Q?Bihls9ayBFpd2EzS4/sOMuqSdwTvn6zTQnvwgMtguYenw+66CnWoOJeois+g?=
 =?us-ascii?Q?PmEBFAgUgWTvcWUMUahv3gaBun+g7llmznCCUb3/ulkYCgkU+xjncnEJedet?=
 =?us-ascii?Q?QnduEgsSJ/54pcXSryKIM0r8WzIPsXsnqUjr4b7x1/OQDXRyEzSdJ0L8VN/h?=
 =?us-ascii?Q?vS01weedVFKiZxgrvJVhh4rblJycejLQoXcNJKVtgX5PUa/E6XD4VapwaDTa?=
 =?us-ascii?Q?ZFuRZSFwimPepRKRkS+bd2mX7e4cAGwWSoVzZ5ViXu8xs8vkIEud/krbShjc?=
 =?us-ascii?Q?ipBszM9Qts1h55Ffqd5nfyXuXpTyPDWTKbJGhtwlnPzLSG0WdJvYhfF5hpJT?=
 =?us-ascii?Q?hlwJKmMkhZtCXION0N8J0Bq076yr4oSRmNIBMIiTJAgAuV+2yvFhuDxbuBgE?=
 =?us-ascii?Q?OLs+U7qzLZIuel9145G8ZtN0oFOiq8Eu2DoL45JNBOrUitOLiNB8KzO/i0R9?=
 =?us-ascii?Q?Xw7QB59wnDnV+XLgV7FH+JCo0QgMW90jOUkdbaiThGy/qtOQ7ks4U0N9s4D4?=
 =?us-ascii?Q?t1uChn8z24LXIQ+N8XFZiVmP977gJdsn+/tgw2c/3fvi0gp1moykCIpEAVpB?=
 =?us-ascii?Q?f6YyXCQPTzW3WBXRIJXG0hlFKlCi2hiBsmpFiaTGEqDmTa9FnIJqdbaCVdEf?=
 =?us-ascii?Q?T8Nq6iOGJdWF33UQ6uDUq6UPLF4ZnJI/t/PXS4f1ouUxphaX9fqfF4d2QOpZ?=
 =?us-ascii?Q?Sv9uj9Ng7+wzxibTemOEpi2nwOFpC1VyXYllbyOHyhVKQH4P+iATGJhWTHkU?=
 =?us-ascii?Q?uCYAhDf4yHZiIVnm6meBOUxKqWFUo0Im7H59AqPdKlXNjB4u5LApKxacbtDa?=
 =?us-ascii?Q?EZ1+sVVTeZ1IrrqpjHxPYvSiU4gMk8molTInAhlbiaKqxNZUfs+rAapVujSK?=
 =?us-ascii?Q?IaoAO+igEw1Ug8jKOa1sQmcPPWzUpE0vPMeEMNQdizf28y/n6l8fmJCRdm98?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71d6cfc-2b97-4ac8-a323-08dd7da77806
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 12:00:40.2927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfgrHlbv0MNqOqFifXHo2OBeAn3d9PzzZZWVFz30D3ZY7R8QsCFXou3Na0ESBsmD3KUgZEklASod9tCbmxBM1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10560

This small snippet of code ensures that we do something with the array
of RX software buffer descriptor elements after passing the skb to the
stack. In this case, we see if the other half of the page is reusable,
and if so, we "turn around" the buffers, making them directly usable by
enetc_refill_rx_ring() without going to enetc_new_page().

We will need to perform this kind of buffer flipping from a new code
path, i.e. from XDP_PASS. Currently, enetc_build_skb() does it there
buffer by buffer, but in a subsequent change we will stop using
enetc_build_skb() for XDP_PASS.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 9b333254c73e..74721995cb1f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1850,6 +1850,16 @@ static void enetc_xdp_drop(struct enetc_bdr *rx_ring, int rx_ring_first,
 	}
 }
 
+static void enetc_bulk_flip_buff(struct enetc_bdr *rx_ring, int rx_ring_first,
+				 int rx_ring_last)
+{
+	while (rx_ring_first != rx_ring_last) {
+		enetc_flip_rx_buff(rx_ring,
+				   &rx_ring->rx_swbd[rx_ring_first]);
+		enetc_bdr_idx_inc(rx_ring, &rx_ring_first);
+	}
+}
+
 static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 				   struct napi_struct *napi, int work_limit,
 				   struct bpf_prog *prog)
@@ -1965,11 +1975,7 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 				enetc_xdp_drop(rx_ring, orig_i, i);
 				rx_ring->stats.xdp_redirect_failures++;
 			} else {
-				while (orig_i != i) {
-					enetc_flip_rx_buff(rx_ring,
-							   &rx_ring->rx_swbd[orig_i]);
-					enetc_bdr_idx_inc(rx_ring, &orig_i);
-				}
+				enetc_bulk_flip_buff(rx_ring, orig_i, i);
 				xdp_redirect_frm_cnt++;
 				rx_ring->stats.xdp_redirect++;
 			}
-- 
2.34.1


