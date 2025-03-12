Return-Path: <bpf+bounces-53903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA624A5E12C
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 16:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50DA6189C1C6
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 15:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1DD2566E1;
	Wed, 12 Mar 2025 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UafPErTR"
X-Original-To: bpf@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00452528E3;
	Wed, 12 Mar 2025 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794892; cv=fail; b=VEt5fwalrHPOAglLbZj9pm8Yv/7T22YdzE8RpCW+wXCVZaiI4+4McDegiCnm+EYWJaaMXXk/HfLRvtvXslbEDqENZvqIsxih4Cgj8U3NN5P42dtCn2LHr6gyaCqcGyxk5JOn01SNzJ5wPzEE8Wu6aL+rTHnTsFoWNWF/R7UNVGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794892; c=relaxed/simple;
	bh=l8DOMDPse33u9PrNkmTWtxrtfOUcR26mvdl/7hCVqgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tmP+duf2j8EhaQv44ql1fggYQbK6vme3wFrci/3/MAmV81296C227rKIp2OqqXGpnQr57Ybr1vSFXuNKrtAanZgsNkQICSvuRB22ILpH6HFA4XZVjJXXv69uyCUiAbIX5kSVSI7LuEpZvPtsxOF+6gXSDAnQa5N4RVLhFUwJ1Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UafPErTR; arc=fail smtp.client-ip=40.107.159.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pktdrc/VmxKbl5EwI5y8erZYtvVnUC03J3+HwxZiJQuKncTXHI4JfWfDvKaRD+EWOuZiy8uQYjXMgbLHesJWYkt+SwwIIVhxhQnUn4uYCalBUdBI0oEN/Qt4aUeOSOmjN0DYYvaQCIdUvcznpieuL0cDRbNdDv5tfngWY7Xx7Edbk7OgldRN8I7KEfSXnkQ+iJ/uajTLpcH8DjP03XW+JdhkCL/lp07luz803uJx/QCvpF443K+4m1+hFSS3KfIkoXKTr5wh1YXtNA7rtRuVLusEPltItuNCDqObUPF9qs9CYnBraBKXmFdgdIYSqluYRSq81Wc/wiv0az+0Hwd7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0d/yDGJSGsDP//ryL5DPeYz2E6S0n8DlMP9MQOBXlEo=;
 b=wOSuqPmJZSCqAmW2uu2aReZ7BzKyzJWUxufnY32fEmHTuHZ3VyD0YAeDFu4T6GwOwDjL48BTH0y/9nhuI0CR/vZAyq68nQXr7/7k4xdS7//6qOhVQHoYJb7KcX09XZQ0TScslM1tSTPYmXPvzF4nO/g+/lgYhdXsSWXcc7TGESion6F9LNfi1HwqkWe8OKxGjXy3whCOfhtXOTLX8lQRu8JGkthpqjwrWgVS/xxfzCt/8iuOYhlGzj6UKi69xmtsxHP3TDyphVbPZGiCY4zC6g+Ps2OE85lopSGG4wUDq8d1s/v+i6jEMjP7BMYKw0k3uIpysaOPC+rMiATJruDWKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0d/yDGJSGsDP//ryL5DPeYz2E6S0n8DlMP9MQOBXlEo=;
 b=UafPErTRPn8AaIa+CtB1ybO4la7+wGPaBmqHfTQe5wZlmsGV85cMfUnTD2+0JPq2MmTYnq2ttTMFiBYuwv469w2/LuJ2cEmXLCC3z3goVX83lkPbCcLxtWRJi0wM3FBcse2/bA3Xa0Yx0Wt//RQFYkfo6dOByZIjMIb5MWHINIRH/SHDEwmFLd7fpuw0vCw9+LDwK03DY6Z1IRujV95O8yEG9heXIV6PQMq4xpEebH0UJQzmZVGo6UPsq38t5zCJDQFY0DCgN/sQ+iZzx3x3JqHSkAWHduRNprgHp8fZE1YzYLIM25YD/yMFnUH0exXLfT6QFRRws7h9ZDH169RUWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAWPR04MB10008.eurprd04.prod.outlook.com (2603:10a6:102:38b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 15:54:48 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 15:54:48 +0000
Date: Wed, 12 Mar 2025 17:54:44 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v9 12/14] igc: block setting preemptible traffic
 class in taprio
Message-ID: <20250312155444.366m56g3fsvn5qdy@skbuf>
References: <20250309104648.3895551-1-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-1-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-13-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-13-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309104648.3895551-13-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-13-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: VI1P194CA0048.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::37) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAWPR04MB10008:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d1384e1-9c59-4519-912c-08dd617e374a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z+DbfKRwijd15fmaNihzMnBLLQdRio1/N729mpujQ4vcBRBOOUlHfvzBvFXz?=
 =?us-ascii?Q?KxYFwyAFXAP6WqyuwAnMtgiOK6+UyVdMbKQFRpXwdUU38GffXsEsyaEBTFMW?=
 =?us-ascii?Q?JebWbR47FpcoI6uaIFYZ7Z0xZXkUrv6ioKxqDHzxvZisGd8mIxY7mFMwDXPY?=
 =?us-ascii?Q?D6nSEays70hjBN4ue4ZaGvi8M+fZSBQp3a4HMCiOmTJesvz60wfD3b5KmrLW?=
 =?us-ascii?Q?ZcoxgL2znT7hCxV4pKdpUjKvi7OQ45PGevWkCZE6vnW5QsG+YGUlWA/DBfwa?=
 =?us-ascii?Q?BtDl4gtUDIv2vzoa03lHq+VezEKeZYj84rEoGMtwPbeXcNPYaBMKLM+zq6p5?=
 =?us-ascii?Q?fTA515hOoJ5+W+nY1anh4NzQGyLJyh94F1x+hHgkGcSEDndx4s9vXVivZU2z?=
 =?us-ascii?Q?9SXWH5BiPOvgndyV4qpRYpY3qNu5ousQNQbOHtv+EGMGofDU6XqBaqtezj/F?=
 =?us-ascii?Q?kys5gqx3wrE4v/NNl/A053lIanQ6Zqj5ZcTwLE4y1Xanep1icYhQdUguV0+3?=
 =?us-ascii?Q?QmyJ271Rdn0QOrh+65MJqWh75DMmT37WUj5LFumXCkVbWnJzzQN3spmVCkUQ?=
 =?us-ascii?Q?sGGAq7DXmlaq7dPROJjQtewg4TXwSW1npcxoCRCD8NQNGvczxoxIH+SeUzAe?=
 =?us-ascii?Q?R6t+pLj5aA4qq2cxkA5XLPybYFP0KidsFwnIbdoz4VDTLqExSfYBRS97tNIW?=
 =?us-ascii?Q?CvP1CnHp4UcckPKXL8CZJL1TtfXd7YZR59jtt2l5rYIlDqhzLjEDzjJQ0q4c?=
 =?us-ascii?Q?23yworclpuqP0eAwcjJREILxnmyqBVVVIoqVJisSvS+aVXC8kQlrHssI5r7D?=
 =?us-ascii?Q?9fW3JLOz1NbkI2MBsna9e5nLSTlwbPODNyohCP5XbHYjkdCIVBssj7jutU2A?=
 =?us-ascii?Q?IEDsgkEVu0sUo0mF1G4X9ArVj3q1dL+41Wp9lqCRz9a8DJAEuhnnOEdT+gbF?=
 =?us-ascii?Q?3jyOqH1JZ90ZbkC/CGn830XrGKdetHdu2lT5B/oDPpbd95Qon6Vli6AfkXjX?=
 =?us-ascii?Q?dHqqaBZSvsUKNPfnzlxITbyNIjigdSr45CZBLoaiOwVAniXuLnjGn2POHO9k?=
 =?us-ascii?Q?o+ZxASRqCDCBz1NVDNqTGX6rTUZe8mTDTKkCO6MB2r6BOy7FvpPqhJX+dNuV?=
 =?us-ascii?Q?HGyt9W51p1yEfCisM4Syl2tKXvvI6qX88yP46bxXE/lUXbYZXCnz0F1Uxsb5?=
 =?us-ascii?Q?66dRMYr9JkhGFXIOrt8nujVJB1+obHYma+QFjHrz6CbadyJJ2pVGJzQEssev?=
 =?us-ascii?Q?p+E0rNvjij5jlimaIKzd3N2ZuHrmD3aueOVijfOPzuQ6JPhu6LnOcMn8yoPc?=
 =?us-ascii?Q?eEvyncjV67k5wcvi/KgkhUju+F9iHLSgOBWCbcu2n20/wyX6ZFESxdR6B9JD?=
 =?us-ascii?Q?or48ItmplGX3zX75fYfuJNpDEGwo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yrNgHcNibaVVlLmxVwxcsloWPN4495n9oZ4aUp3ZS4x3kDmIdrUkBSYUE/Aj?=
 =?us-ascii?Q?7Wnzj5ro1PUQWfbJhrBhLmMbZFnA+K9PA/fEUH49tJ8x0tmSe7j5v3V9yyHP?=
 =?us-ascii?Q?3IQB5Wx4jrTA7BXA7MbR3nTna4c7jxuc3nfJ6hWAIL9Jfl5REPN+DQ8J+L9K?=
 =?us-ascii?Q?REttwNpQvnDOpUA15wRh+3DnJ7ITOZdwZNNg6Z/DzSbm1R79SQilgpakQeDp?=
 =?us-ascii?Q?RxGmc4QCOTo6P1nmdM7FKS47hD+o6rR+I+FIDHlHvlJzcal1irasNR54MCgq?=
 =?us-ascii?Q?5/cnAUTsk9ctU6JetPlHiSMVE899laZd3n3TMNvO3vOQixEgvH5tnsax6fgB?=
 =?us-ascii?Q?tGYq9v1AsQ2qzjdAjmfII/d/cSQN7QBLMAFSS4WepDUcURumkkBf93TN4lgr?=
 =?us-ascii?Q?aX7QvUY6Oqzt7bTIJs8AlXRS7dHFdVrtIc40iqcM4xiQf4aH5PfeqISL43Vy?=
 =?us-ascii?Q?YRZyi80uEYLogH4B/7IhFOsw1OKlxm6bwdEhotuq5hY4IwFDZLgyOCGQiTS4?=
 =?us-ascii?Q?5nvBiL5R/qn+VH/Eia/31q+gYT9sLZMWF65WNrWqOBrFT8G7csWErpIZxorJ?=
 =?us-ascii?Q?l/w9cgsveobD80V8kbsfubEANZjHMpsDAbDEAFK5yti6dKTlgMOd5cDvO3Se?=
 =?us-ascii?Q?rlA8XZyOqpj02SUleKNRNoBR6qgK7QREIuNE+ILXp8Pkp2GAgcQPQecz7/TK?=
 =?us-ascii?Q?PAdY3U7hGzsKr33NylqVBzXhTicqR7H3kbLFLX5zaZ67h2DIHeGhreCNn0xm?=
 =?us-ascii?Q?Ov6gxxZ4RuBbzjUbi9vkNbcEBvbOM4AEGe2iBvM2UuJ5toCokJtyTcdr3szu?=
 =?us-ascii?Q?bUlqZtGi54wRzG1uo5063VpgzAmXreJO7ujFVjuVtuaZlI/l/enrPm1ur8pz?=
 =?us-ascii?Q?tMpTVl8UvbJO8SWhrjJ1B4u4HkMI5+VBgl/kQiTtSNHb66PNA0QP9xnoYhqa?=
 =?us-ascii?Q?UYBihacBpeufDdizPRAK8pB09t628OjPoCnqqwZXAGFN2cI5Bna2L+H7liY1?=
 =?us-ascii?Q?MdX8RrSIs5VJKsA26sXynVjyFe9YzTAq3zj7OiXl+ajjZ1ErErrX1bNzUm50?=
 =?us-ascii?Q?j8+le3WyJdzJ43/Myt5FAS3+cOdh/j/cDY4Bub7hoF5Nel9tk1Irq+/e5nVd?=
 =?us-ascii?Q?eToo950mnE2uvix0Do+J2lZjMHaq10hHq28zB+2zj3JDnhAux/AF/WMYpjT8?=
 =?us-ascii?Q?AbbgZHLWuCjXpHcHKp+nq35xVLIKT88lVsfyyEu5BYtu6btYtjjwFONNWz3g?=
 =?us-ascii?Q?RAJHsKQSvW64wsTYGkM5utIc8j2fdX1N8AzjEbveCB5SkvFuXZ1jDfidimkh?=
 =?us-ascii?Q?rxItlr5l+QbGC2NCwtPjvj+BwFjJvPEwVcMEu5YW9J9DLTaRoxblEF+uJqrQ?=
 =?us-ascii?Q?Cn1djXhn9U6tZuYjmofAjYUdtIj9Wc28d4ABKUrmAlKJAsv03GB5cB6f7gTs?=
 =?us-ascii?Q?c4YRdJgFQN2qsSgfOVUuQyAW4cKYM1OH6Ya4tLTHYbtAk58oAec3D1JkuVDS?=
 =?us-ascii?Q?4f+T+9YnmUjtsFg6QP/hX3OHl29S18rbZUN7azBhw7DChpj7Hnfufs/b86F2?=
 =?us-ascii?Q?fmMUAhPk0+lgxZsp6PHs/Mqy2IuFlBxex5R6Y2MBgiYGSsDs+bX02+gls3Oc?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1384e1-9c59-4519-912c-08dd617e374a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 15:54:47.9839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hCH5R8D+u0mcaLIZ2QCvMfUYU+zpWhiVY/Hc+BkJ5RQkgIO5//utXVALrjAQJJgrKJILsu+Q4zCqOTWZZbPpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10008

On Sun, Mar 09, 2025 at 06:46:46AM -0400, Faizal Rahim wrote:
> Since preemptible tc implementation is not ready yet, block it from being
> set in taprio. The existing code already blocks it in mqprio.
> 
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

