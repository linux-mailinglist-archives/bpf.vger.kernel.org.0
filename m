Return-Path: <bpf+bounces-51309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E984A331C7
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 22:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C053A81C3
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 21:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE3D20370D;
	Wed, 12 Feb 2025 21:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D2d8crdn"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0B1201270;
	Wed, 12 Feb 2025 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739397259; cv=fail; b=CkE5wZukThzUADpfRisGe397dXKbN1FXYtfjmylv8xz4IP/LSvBRB+G1OmCbLzqMTVKZELG3oBASOaXyKD4Z19+N9ws/5LLWhdHIAmPd7fOo7PkLyZu/DxEtdtl1wJdnAuvoD2nrpEif6bvVre3WRkFjpXbRICItMyX8njPPPwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739397259; c=relaxed/simple;
	bh=/in9waHpwmNS658ead3IIAqBDKaH3T7/hvrEcqfJ+Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jUSejhTUyvzrzy6tVhoRkn+QCF86mvmZbeqXj3z2mxRqGmxtqd2bdcr95xKjiUGUOKeiD+Ik5bUWWTqPF4mX9MQ8ByD/GyE/vuVwwsW84bAIy3D8MzC+f0EvcbfcYYqbZQ7tT9Bf1eADYkW8Yw1wPkmft2blluB5GWgl5WHb4SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D2d8crdn; arc=fail smtp.client-ip=40.107.22.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pg8sHprAi7c/f+ShIzrwgswPWVWfjPphxpaRlZ8wNh8wmMoFE45xZGv6PbdnqyfOUvw3WX5FHkxD3eF0Zz6T9N3oW3y8ABOhNpaIUG6EHaFtArljnTghHXb5Yl2eejL3EKMq6W1kObk8jpEHeXxqffSblo1OUXHj4vWQWnbz1p9/kNVFmGIV1S/5ti8zx/HaXMpA/lHAOElg3t8ZtCqJQDWQq/rcdSryh29Q9B/CLPQZsA9vpLl/UiIrAB3LS3a4oHe2dK2T8J3MwPVlVsCFXMudC70rw11fCBCo2ojPCicmU85Q3zUw9sbk0wQLcnVXbzu9G9FBkqyLV9j8x+FPpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+k+ZJITZxwNPOqA5a2PbrqomdE3zpsMV+KLvrfvVU4=;
 b=ZBF8qzArOWZ4GrWaBmPMbMHDcs402u55yJVDzSGMyDgoe4rdzQ6wFYi7lbB3Oi2Ir/IGtDa0W+UMzVYcGAFI0XSUxRc+MPEx+rBFrBPOjf13iAfDdKR53PkRNEPnC9zXCLfhWvpR9NJCA9oV4jA3KGUCOkUjwfXpA6vrk6PI0vHu/uliWJXlMvJbc0rWOueAWqjKqfYsbfko4HK9ANClqjxBFm9QZwX/zpVXqFCgMfdJ7yq+Uof+TZiPbBWaL0MK89RoCSv4Sz/Q9BaqGUcw1+eTfCT/McljF3NvfW6hVtleptmFC5GU1RcmRLMihxuVtt5zSEQc3jNbGsGmN2JE7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+k+ZJITZxwNPOqA5a2PbrqomdE3zpsMV+KLvrfvVU4=;
 b=D2d8crdndDzSRH+m8dMk0ks2HnKQQ894JolJCMAQipmtdM+l/cix2zabDG7xIKgA51uc//MEJag8DvmxbCSYcWEDJaxBmLf/FIxND6RrJUV+ttxKTXALty15Bnba5sywKGGuaaGF8DPQRu5De4OcsWjsISmfoBpw1cuG/8NqygPQYcWReIw0lsR+gP6DTvBCTqGS4yXlpaJsICd20+zZmnXjSKIvhaWnFBZqMl+a1WZuiDnWBhHmQ2z/q22/Ks8wjTEzlmtU7YS/c4opkvclG+fL+L2A50ISY3OToRuz0xiLcFchXDk96GwhCEcHxmQmpBQoHZ5XDsvXT2SGQJmU1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI1PR04MB7038.eurprd04.prod.outlook.com (2603:10a6:800:12d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.12; Wed, 12 Feb
 2025 21:54:12 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 21:54:12 +0000
Date: Wed, 12 Feb 2025 23:54:08 +0200
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
	Andrew Halaney <ahalaney@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v4 9/9] igc: Add support to get frame preemption
 statistics via ethtool
Message-ID: <20250212215408.v47eb42zx67ij6vp@skbuf>
References: <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
 <20250210070207.2615418-10-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210070207.2615418-10-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: VI1PR09CA0174.eurprd09.prod.outlook.com
 (2603:10a6:800:120::28) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI1PR04MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f5001c-c2a6-48fc-9441-08dd4bafc911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EunXFcou09PJbceOO/biPL04hOMK6Yuc+uCk97X5sS1yEF7YRgXvnwW2ZAUj?=
 =?us-ascii?Q?xc/nrC2WrAGf9hJPjtR9aH+LN+qXj2y14UXpfDYFDKet3y2wNN0vQbtpIkdx?=
 =?us-ascii?Q?kci1R3oivYwcML9GR+BJJxPoMxE60o4177X0X+ptRsQ+6jC2YYs/3g1ycEEo?=
 =?us-ascii?Q?GeZFpLgTF51jNidrGampMI1+sR6ZAeDTdnDd/IdFrhHRArxup2D7FtKDaaMU?=
 =?us-ascii?Q?EbGn/QFmatwyh03wytRxwEG1Ql4G9nuwSUOUzcXs8jGiTeepUkhT2HARStQd?=
 =?us-ascii?Q?Piy8O5gT/a/QpeFIe9039vedLwMRg7o00WoD8PtH/dhUT0uNoCXPvG140jlF?=
 =?us-ascii?Q?cQBKy7hRaBJaMhxIYL69Sslu0Us4vkBtX0nUhPoQ8plJzNIidvs+cLkoaYF+?=
 =?us-ascii?Q?+XHcEUS0ayJMTJQRbEJ/GZ2c4Wp0eopUdPFft4PyYnu1B2UxjjZoXt+E/dnr?=
 =?us-ascii?Q?MBEiraPRiTqlLqa5QRvimdcIYACWtjrXVHmCABELzh76lbxh9EazvPJCkDwr?=
 =?us-ascii?Q?gJUmrnCO1JM+nutOr4R7tSi3Nf/m7crX8r4R0c4ihlx/FKgpJYH0/kaJqUQm?=
 =?us-ascii?Q?eCEDJae3Q16io4HCWhGB6HUvZ2Wbf16Q/I6K8kYkRZnt/CczwetrAARonksJ?=
 =?us-ascii?Q?P8Z1N4tCGehKzKK2cYBylcznCH+89LZrhXIbUm2v28Gxb97/tdcVyjnpKltq?=
 =?us-ascii?Q?m+Vgxm7RQu9Pkf6DK9VCoWov9moFWIVbJo4TVdbyPqBzjI18cyoAjEj7jBVl?=
 =?us-ascii?Q?W5xYsP6XcFe0K+Jbc8QfFrXdNz9KbHhwFmLSu77OwxzeH06b0em2yw/8rD/Q?=
 =?us-ascii?Q?WqfsLBZeDhI9sn4IbCRVGs+HIlb8ADkMcozCVqXCu0c/vpIhMlSDwtE5dI7s?=
 =?us-ascii?Q?IoMzyE3b/IYL7r9WeybHByx/UyQ6Mvk29MJQ1K7Jy9y4iHB6ogPB2a37kZhl?=
 =?us-ascii?Q?agC5lkqc9i5pBZGexuB1jzPrl5ApF49c90OjpU5cjS/shWLXQ1u6SPyyVaIK?=
 =?us-ascii?Q?ahEI0Y6bb7/PqVOiIemd48F2jqm0MUXEiV0uBieWytv63WgUVdaq0rlzG6VX?=
 =?us-ascii?Q?pxQk5dBcfEcsd6YgXjtO2Mr2WG+hQTrzJGWn/hkNXkWGq9CmlwHRh6LC4Dml?=
 =?us-ascii?Q?qe5qdS1oaHZ4IHZptZV2C966rr0qP6QeMLYRbNoml1KPYbTAhvivlFw8eTxD?=
 =?us-ascii?Q?WYvsVVNklV8NUBZri9XsmgMClWOeLfzZvhPq0gFsn/zvWDKBq/GSmSW1qZc2?=
 =?us-ascii?Q?FOouDSr/xDqZC+WNPf9vqih/IC05qWFQ/FZKXDeBlii0MGnRN4JhM5qFZ7d1?=
 =?us-ascii?Q?3trx2pnJUX8evYaWoRnwqS0GkmorXsvmxoowikI8rwPTTQ6zagKt5ezUQQib?=
 =?us-ascii?Q?GLuXLzKiH2A2kxERMNQFrZ1qWKn2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IkNR7mi0yNtgDYC575XEM1ZVos9WJAD4rbTNXbgu2gTpdsp7THJDkVOK+mRN?=
 =?us-ascii?Q?bvIugxfVO8n5Mw0ynBELRrH7f/l3A3AB/dEQidbSCHt1LEjakaRRVSbr3Zuw?=
 =?us-ascii?Q?yISEvO+ZcstaXZBFvKN5nxgn9iN/1hkx/Q/6W5LFXE0YmEFnf7DxpNHSLXtD?=
 =?us-ascii?Q?mdT4veG5z1Ipxr4h86K7xgD7eW/zbe/h9mzzw1b0wRcdV4TIuAU6KjQJxpjM?=
 =?us-ascii?Q?psR/Yzw3ajhsI1KeAWE3RpqZrpRmqV8yN5ksnP/TfQ2MkMEEkU1G9QqjZd/q?=
 =?us-ascii?Q?kZUfmDqskQH7d4fYTVBCroLTXII1CU7J8t2A6EN9l3AFB01MY/DTEWEsJ9oH?=
 =?us-ascii?Q?6q9knYS4yteTp5Z1TtxtYc8OXnwsINNHQhgnLYVnZ5QFdAWchWLg3daZi32U?=
 =?us-ascii?Q?xisgcY4B3N3KHA1jHHXIpNdjLhE3reHKLnUVPgVujRuDDyXh3kFL8CDGY83B?=
 =?us-ascii?Q?G9TPeCvzo2X/WvkjmMwK0Pdpzn+wsDyczeX/2o7yqTVYKmI5IdzNqLs/NxNa?=
 =?us-ascii?Q?vE3A1fkWt/9/HgOn74FNESaQ38rmb+FVRn2naoqIEFXheDBw/8ALctHJ7ryR?=
 =?us-ascii?Q?UxEi1vW57/nmcmaxQygfG7FhPldGMPDFKCOU7qI5cs6l4McDKZq8FnbAbPp2?=
 =?us-ascii?Q?N1neHHyfDuxlHzZafgcNMRdm6UWjT/CuLO4J8BC7mKOhJ/C67ZX8lIKN+7mY?=
 =?us-ascii?Q?0/VtzyujDilevsKsmIG9gvSqb4QEYe2C9eierNNHZbweOs30E8l0Pa/uMz7Q?=
 =?us-ascii?Q?4suv1rXpHTM/fMZU9QOOsmQXRWyqbYrueJ8e/40kPS4g2IRII8Pk5X3UR0Pt?=
 =?us-ascii?Q?0Oi7aATfUasJfpi83EPeZ51QFYAZ5IS9e8MSsTWUy+nRvSxQfZCN9zEbKS0q?=
 =?us-ascii?Q?kNl/CD26gIGvX7emkju/TZqzyG/dSyixnNNL/sNmzvAKwAnmGI9JU17NrTAJ?=
 =?us-ascii?Q?KXgPvrRJiNDrygMVjCnz1Ny47lWW2tCuhmnNFIQc2l78oh4BFmg+zRLKMKc9?=
 =?us-ascii?Q?FUvMQCBXln2PnVshkbAt/oEf3LZNyM6q/RuUXDrj1bFPcJHghMTN5Vf3S18z?=
 =?us-ascii?Q?PUuRbKLiyAReMozGQpiEtOrV1PixVDcuuDHAGy0f515TBKv3v1j/Iycc29iG?=
 =?us-ascii?Q?+92MoU8Ng3QbrUeC4Oxu8PKMuQJk2ROM3YEiim4auEn+ZQ0G8A71KHOaQOfn?=
 =?us-ascii?Q?bYd+cmApvLci2LY3unuHqvvtCiEVVPiUFfzHh2rQYOzgnxmo3TZ2l9nOFUMP?=
 =?us-ascii?Q?MYhXDXEoFVYpssrjJyLBPOmZZ7esQmE3ms7pw7c96hoKzVDJpZ3KgIiXe493?=
 =?us-ascii?Q?62HlYbS8LbgWRuwM0GTtKcIVxdoAr6i3eWxCdv9ebAMwV7uPLAlF/DSzN2Lx?=
 =?us-ascii?Q?nlT5ON0QuiX65E462+Jg3WgekwtN5KusX2gbx+wp9vlHaZPMlcHNLmr+IB0a?=
 =?us-ascii?Q?Iw2U1B2ppzXP0HP1cFxm5VXLqw+zgpO17lGuJS8J8uzwfPuYyXDo1x2x/Eeq?=
 =?us-ascii?Q?+jHbIvqp7Plv8JgIKUn0XCslGnoNsccEXqiHApdOSjILZ7kojhw6vUc932M+?=
 =?us-ascii?Q?kE7CV3K2oCTOAAO72nm/H0isKQqwgxzU0CDNqOnThy3oioC7c498i1XNFePN?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f5001c-c2a6-48fc-9441-08dd4bafc911
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 21:54:12.3419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+Oqm1h1QLO8X/cweBMwdLmxygVB9laHjA1jxKXq4bitrgslAxYaPP00oSSPuQ1AhJKhuV2gD3B35nC350wbQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7038

On Mon, Feb 10, 2025 at 02:02:07AM -0500, Faizal Rahim wrote:
> Implemented "ethtool --include-statistics --show-mm" callback for IGC.
> 
> Tested preemption scenario to check preemption statistics:
> 1) Trigger verification handshake on both boards:
>     $ sudo ethtool --set-mm enp1s0 pmac-enabled on
>     $ sudo ethtool --set-mm enp1s0 tx-enabled on
>     $ sudo ethtool --set-mm enp1s0 verify-enabled on

For the record, all these can be enabled at the same time through a
single ethtool command.

> 2) Set preemptible or express queue in taprio for tx board:
>     $ sudo tc qdisc replace dev enp1s0 parent root handle 100 taprio \
>       num_tc 4 map 3 2 1 0 3 3 3 3 3 3 3 3 3 3 3 3 \
>       queues 1@0 1@1 1@2 1@3 base-time 0 sched-entry S F 100000 \
>       fp E E P P
> 3) Send large size packets on preemptible queue
> 4) Send small size packets on express queue to preempt packets in
>    preemptible queue
> 5) Show preemption statistics on the receiving board:
>    $ ethtool --include-statistics --show-mm enp1s0
>      MAC Merge layer state for enp1s0:
>      pMAC enabled: on
>      TX enabled: on
>      TX active: on
>      TX minimum fragment size: 64
>      RX minimum fragment size: 60
>      Verify enabled: on
>      Verify time: 128
>      Max verify time: 128
>      Verification status: SUCCEEDED
>      Statistics:
>      	MACMergeFrameAssErrorCount: 0
> 	MACMergeFrameSmdErrorCount: 0
> 	MACMergeFrameAssOkCount: 511
> 	MACMergeFragCountRx: 764
> 	MACMergeFragCountTx: 0
> 	MACMergeHoldCount: 0

nitpick: mix of tabs and spaces.

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index f15ac7565fbd..cd5160315993 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -3076,6 +3076,7 @@ static bool igc_clean_tx_irq(struct igc_q_vector *q_vector, int napi_budget)
>  			break;
>  
>  		if (static_branch_unlikely(&igc_fpe_enabled) &&
> +		    adapter->fpe.mmsv.pmac_enabled &&

This bit is misplaced in this patch.
Also, both conditions, being repeated twice as they are, could be placed
in an igc_pmac_enabled() helper function or similar.

>  		    igc_fpe_transmitted_smd_v(tx_desc))
>  			ethtool_mmsv_event_handle(&adapter->fpe.mmsv,
>  						  ETHTOOL_MMSV_LD_SENT_VERIFY_MPACKET);

