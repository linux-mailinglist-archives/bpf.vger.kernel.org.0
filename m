Return-Path: <bpf+bounces-53429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F78A50F43
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 23:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6046C3ACA5C
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0306D2661B8;
	Wed,  5 Mar 2025 22:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mIs+mReP"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949AE1D6DD4;
	Wed,  5 Mar 2025 22:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215492; cv=fail; b=glthxS7sM9CQgmGEGpnMx0hM/txT5ROqMJVhJXJAoHi70Q1PW3BgDewr3I39HA3IRyb/aTtexA9PgkLYQGBeLuhEcHxPJnXmiyScGLJM82AsuYn+eqTE1vrYaJSHrmfAv/+vVL8v+JtWa0L2WaPahzroIGftBsonaIP/VW4Fgvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215492; c=relaxed/simple;
	bh=UXtr9ayWZF1wGILiCnd9C64Nd9w8vU/FTvX28v9+S/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UgvabhX9KrAku4+05Pak87AK3Mf3sArzwDgzxZKbCSDPfcAWETQhgkEVSNd0RWWL4518eSptb22bTWuUc7gnlux/YaY5TxeTc+RSc8ABTYYk+dp9xia9Bl0ROBlDeMAWieH9sK1cSlm9ylIhYfGyYDYUk5t0WRzEERox+zCwP4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mIs+mReP; arc=fail smtp.client-ip=40.107.22.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRABUvtC/qc6gN9Gq/lnz5mNF/1D7wXy4vb/I5yVlHLHZDuXHfqO2y+smnSW2IZ8mllJV14uEVBZE767lFrDKqDiC+hZJ4I6yD0EZerJwSfEJMWMg0hgHbvzPjNxfQXop5q0OrVtDAAyH7+yTLllTK//RKbsa0kbyBVpxEzDKptTV2faEcm9oUbExSM/yqvdUsHt+qPUfUJhcK5TR/+DWrGV1Vrpn6hCmxvVoMQ+aWM6+XdAAaoglK8T/WnkoztR/h06cqcA7sw5931T4HMaZ5GVM2DXTZsbExbZxQ+v4HNnL57OVpw4zuP/Q/u53LlaAFM9EJeEtaXCIJj25c+2gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGa4gn8d+dne3qhBeOlV5GNtqaKjv9ENIqtJ2YslewE=;
 b=LXS6X7epTmAYdsUvWtfPgwTcRMS8QsUnTJevmHIYZSo14+OLGZL7BIqzEF0srSAU2Bm9eOeea0GEBbYOIb8vYAjYVDvjtZKN7s2JC4CY+qIkSLsgftEwXCGCt80+gGzuweOb+eH4n38kfqwKiUYGB+vE4vC5qbb70xWYGwWJ7X85utyMy4kv64G5MbnFvRGTopqLxhY0c7FV4IezMYRE2hQuP+otgGyN61j+qGy6zzgg7cZFasOzL+yjQPkF+XRHSCwORBfciaHQ6HGjOvs5l/zzJJJlY0vUPEK8M0zxCxHzzqGYwBVbFunUiTjr+zVfSG2jGj0HshQLhLJ8c0CPfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGa4gn8d+dne3qhBeOlV5GNtqaKjv9ENIqtJ2YslewE=;
 b=mIs+mRePy3ZdAqQyYVvB3GnK0UXJwA96F2MVhpkp2YfZURnBDIL9npwN1A0yPqVg0BnGbQmWtTeM7+HLvGlm/VWVU05yVt+En7EiJySHK8IegFpjWjc0VrCvFnmPh3itIJzvhGuxML8d2nqBBtNMfo5zhCXfOX3TQ8q2HDymBnQwYov5IULwEgTe0Afv4tynUyBDwzBiTrDqaxKe8YIQRaPshztGriFG1BLd9uFlAGIV4gX+ZwWhhaFND/yAn9z6DX09i7b2CF+DJlXj0viTF6ZXqTEyJ59dtCiLVEJT3NswYoZqAuV71LZB7bwYDoWZRrbf8z+Zh3iGe/l09B7Afg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10468.eurprd04.prod.outlook.com (2603:10a6:102:448::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 22:58:08 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 22:58:08 +0000
Date: Thu, 6 Mar 2025 00:58:03 +0200
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
Subject: Re: [PATCH iwl-next v8 06/11] igc: set the RX packet buffer size for
 TSN mode
Message-ID: <20250305225803.kozn26ilnrnjrgbz@skbuf>
References: <20250305130026.642219-1-faizal.abdul.rahim@linux.intel.com>
 <20250305130026.642219-7-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305130026.642219-7-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: VI1PR09CA0111.eurprd09.prod.outlook.com
 (2603:10a6:803:78::34) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10468:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba8d6ce-f410-4265-dc06-08dd5c393201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BBGVyJaPvFasckEp0S6DxFHt+1rKKJxvwY3+5waXAwlX8WexFGiLcS3hoJIE?=
 =?us-ascii?Q?O3AZDWEm3S4u87BXIVUhJD1aevdQRxkxxvUxsukmGyun2BeGdWiy3Qviijx2?=
 =?us-ascii?Q?+fl7nFDn1lccwRvk1VAUOaJT8zfOYGxHf3+Rd2oo7Wksvl49DC2jbex+yDYc?=
 =?us-ascii?Q?9RPYQseceTcW8TMAVBheVP5msgwl4eShK0a8EQP2+lVqNeUr3IL9fUBtpBKG?=
 =?us-ascii?Q?mAZWW4OnjkU4XxavkjmCI5sDAkza06TSzjXersqh/YlXQpMWaB0S5xCuk7cU?=
 =?us-ascii?Q?1f5zsQ7itxDKk4h1fUPdQ4EgbEFWWQXy2WJYZU9l/kzAt/cYWnjDipJ3taDG?=
 =?us-ascii?Q?INtdYFVFM3WfiMSVAMQHV0yKw4KXWEURbNVs5ptGr53f0Xin1E9PJbxv8IgX?=
 =?us-ascii?Q?oG/6OJF/SagsOrh3QakzwOkKzEAiP8ksStnoKf5Z3+MqQgUJrY+zcmd1C6Bs?=
 =?us-ascii?Q?DecxKo6qQsiAYJ4p0l2l+4t5GrFKUJjrbfH+w/mRuwWg1QcDsjZ2UV5XsLbB?=
 =?us-ascii?Q?aot3Fu/W1HMi/1fkcPpEONq7vn8rBBjwp9thpcyMSVDEZnTBW/biwiWwepWG?=
 =?us-ascii?Q?LVGVfYngY5gNODdphxUHSUtLi9ekJ7sU9KFjdZMcG0puilwS5FboWQOYE8Q9?=
 =?us-ascii?Q?QfA8d+mBJj1FJRefNY+fJLJnZCndqXaRE4AHsS9L0b6eNVwiqotPhahGMIjH?=
 =?us-ascii?Q?UqlyYc73gXf4Xy7U8z/XAgG/tY0U01Gd7DsmTOxURfT5N4xn5gjoXFw/ipC8?=
 =?us-ascii?Q?6V42lEulMHzTmi4KrBIFiTu61NGL5OyPn+61cQU4TOgtBXDEy51hvy8Xw0sF?=
 =?us-ascii?Q?AyZFCtmLVFrE8d5/MP8u9RrNCKfN4HP8jJ5p0vfflTY3YQfN9/a1vRbBEW3p?=
 =?us-ascii?Q?qWm6LfoNy7Mq350PN6Exdvtqxm+n92Pt9Lxn+6vIHZw8GwBd5MZg4Qt23KQG?=
 =?us-ascii?Q?cNEbjqIYQvO/V+YJgjrWKD/oehC08v+hs7f6bQtHbYtPgkVKkqs/35RGxavF?=
 =?us-ascii?Q?vOjNvtrGmn6HpJkYbINrTuUYrTCabrwtOj6dVQXPiNwp6TQQ+8Gx44grK/9B?=
 =?us-ascii?Q?AiMx7bwHt16bIHHR46cszNAOgeBTlN13j0FHpmMIQxKbWRL1Sfp8E/dAhr4C?=
 =?us-ascii?Q?gPD8QIpF85ksudfoFwNrcnzFd9bGLgPOjc3pwvGgQkUBlvgSStWqfPdVe1RU?=
 =?us-ascii?Q?6HdkGcnFfC5HCsX1EdbnLkoW6xmI4V/CgILqWvcMKF+cmnax4FZu0favJvXG?=
 =?us-ascii?Q?xahZzaiq8rT2eKbAE8Cy1tr2R67CKo2/1DBNbPhnplwq+WiEmIat0eFcNMZ7?=
 =?us-ascii?Q?X3KyT4EhqAgBBcRHsfAbJv/YBhXtkwir3ji2RevD3j76dmqZoi7cbzgitgva?=
 =?us-ascii?Q?GxkNGb4D7E42/30QI+o4aV73G6kH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D0eNkINfQtwM8hSrsriiIi4IY6igSiZk9NJMXooNPYw7/GkpX3fN5uLnLQmO?=
 =?us-ascii?Q?npYQ+BKJ5zPkfjBIhwXQa1uoiBZDv9SK2WMvVNHNoPvPvcNFWj9bXtbHDNXh?=
 =?us-ascii?Q?u3nosdzrKa6oXlruTpcSg2T9L9ODNjKFx3yUNq345FkK/xU0Sl1j0dcp2Zp5?=
 =?us-ascii?Q?5AR8eeuhuQV4uR7V7+HmWdgipzkZpx2XCIc+KnrdriwmJVbGXByHlLn/jzHC?=
 =?us-ascii?Q?7opqD/yDrKoAnLpuE35rUtr91h9tM2FVrdBeMTjOtzDba7pubVmpTGJ1KCPK?=
 =?us-ascii?Q?GWJnHRWpGFF9uyyCMyGg02QH0DiSZ4URTTp6Scf6THLnBFnMlXhwFSEh2Afz?=
 =?us-ascii?Q?8Q6W/IEEhiyWNaxp140aPAfsnaewr4a9+qkOvTvijYIMh2CunA2E/3Ut8qs0?=
 =?us-ascii?Q?B/iOxwwubetbvnwQbdgP8+eJ1qZ9dw5a8FS1kLf5nJwGm0c8+M8fC+6mYR7w?=
 =?us-ascii?Q?DCGEw3Sz1k5c6NbAu9D49pPv7YWnSlWIMRTliqoChCKtAHtSjGxPgByGEvuI?=
 =?us-ascii?Q?013bkkSmaJpv6WMc81narxdApH4SqyXiRWPnuVq/KKU1fY0MikroC3bTDN6P?=
 =?us-ascii?Q?9Ug7BwjW7QSaDMYnV5t6jKQ9m4wKF4XJTPQOKwjwaXvuBYLaVWPfCAOWhCUx?=
 =?us-ascii?Q?RXnOY66lR1qOO7Qq0NtTcUQjx6AGpeU6hdBaphh5c45LaTUXglnKAYsviD/+?=
 =?us-ascii?Q?Q0hO4pk60qXdgUVXvYqaozbSvL8KRuVNhTzBdYhjYjJJwbEoG6kP7t/ES7li?=
 =?us-ascii?Q?p25FGc03igHg9g06Cfu3bawaPU/r7S4nCvMtBdE/VmPRQke3bLrmNZtFYj0T?=
 =?us-ascii?Q?q/cruPECft0KC7oYPJ0M8zqIBlOSHMemifTdgpRJPv39EgnKEXS7KwcCXLuT?=
 =?us-ascii?Q?IpTgNsdIyGOQdLLIDyJSWY5fjxtclCJenbzQkGJhPkGEyOjd9UXuYyLzEmMP?=
 =?us-ascii?Q?E7VRpFxkFfONlp6d+JL4taPQ81TTmsyFOW+KwT5uq8AMTTSxWBbaFMiXI9Lj?=
 =?us-ascii?Q?OAhjrgolCDrlSrhoTqdvqtv+lIfi2X3hlo8KBz8EpoEOQR8Wh/gIitEE8G6X?=
 =?us-ascii?Q?xB9L4aB542cF3qxvq15Uxgir2MRCxk49qfyLNTjBtQp46WikzqyAPjVJFwl6?=
 =?us-ascii?Q?Wkk1uKrmgn9oJMr9fTnZlHUglzeDGgQ8CWx+OgnQzigpWIP3Zye5LaFjyyku?=
 =?us-ascii?Q?RtIOFPRzbRtGp/DfYLM6ShVsobwHqzTJYmJiwabpa3VcKInVJPqbk7hXfYOC?=
 =?us-ascii?Q?bx2BKFVeZw8d/kJaM1sj8XCA+6CwXreI13DbZZ86ws02rKGbH85cBISVFdqj?=
 =?us-ascii?Q?64T0rnlXUGWTJJ73Z6KO+E3kvi72MiemO9yjIsCnNs++UQU4GSeUgTKxvkz5?=
 =?us-ascii?Q?PU7StpjOXIRcvAuO0lp96dPAdsO/vAaW4lT0nKr4NM2ECXyXNiyUHaBt/iFX?=
 =?us-ascii?Q?+PgVJuBChxidKJh36T91ebWMxvqPSvRmtHbwc1uPnlz/n76g7HusZVFH08nD?=
 =?us-ascii?Q?XVhYyY5g/8fRlILRWJpgBCbC74fnv8CPjC7DOhvsgY7Z3H4kn58Y8wQHhCVt?=
 =?us-ascii?Q?aQVD48SQFacjZj+xh8nZkxxvoP1+LBRqU48Rt4MBeXWrmU7sRqZ01m7YeUTL?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba8d6ce-f410-4265-dc06-08dd5c393201
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 22:58:07.9717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O90YsSiuajvxCDKTolMhKn1TGtID3V/aWv4wp4+kQPgh3RKaxak2+zxrxNdv+T9cpRF98tqC7lPnTz0tmaJstA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10468

On Wed, Mar 05, 2025 at 08:00:21AM -0500, Faizal Rahim wrote:
> In preparation for supporting frame preemption, when entering TSN mode
> set the receive packet buffer to 16KB for the Express MAC, 16KB for
> the Preemptible MAC and 2KB for the BMC, according to the datasheet
> section 7.1.3.2.
> 
> Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h |  3 +++
>  drivers/net/ethernet/intel/igc/igc_tsn.c     | 13 +++++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 516ef70c98e9..b19ac6f30dac 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -402,6 +402,9 @@
>  
>   /* 7KB bytes buffer for each tx queue (total 4 queues) + 4KB for BMC*/
>  #define IGC_TXPBSIZE_TSN	0x041c71c7
> +/* 15KB for EXP + 15KB for BE + 2KB for BMC */
> +#define IGC_RXPBSIZE_TSN	0x0000f08f
> +#define IGC_RXPBSIZE_SIZE_MASK	0x0001FFFF

Does 0x0000f08f have any further meaning, does it represent anything
bitwise? (similar question for IGC_TXPBSIZE_TSN in the previous patch).
I don't see the correlation between the values mentioned in the comment
and the magic constant. If RXPBPSIZE has a bitwise meaning, maybe you
could rewrite the magic value with macros for each field.

