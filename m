Return-Path: <bpf+bounces-74983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC89CC6A105
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 15:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 61E302F3F8
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 14:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980C43546E9;
	Tue, 18 Nov 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YimM73WG"
X-Original-To: bpf@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEBA30AAB8;
	Tue, 18 Nov 2025 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476294; cv=fail; b=nFd2/CbQ7IyovoW4nwW4aSt8zPR6iIXhZdMhyM3AbsgLcOShdquDja5/UCFlOmKrwAknWsaEpwr7FxOu0rQsOjDEdhbCe3/rWPFdqXVI5r5nDBLL7Ax8jgOaFL6gs0GWpWQtLfJoBEwSyScQqu9+nUhqcTORZUbXvaMdujZQ1Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476294; c=relaxed/simple;
	bh=ITBcYEiJ9KrBmaVbpN/FMUWj+5u6S3geLo5SZ0WB1Oo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iTFoa2RwUbRSoLGUCkuUXrP9IM8XY9O3R46nWyg7RT1N6+HD2cF4q10AQeEbm8jVXgZlQbTFECBzj+qfNHyByvJnEpPkrI4WRoFTv7/11FUDkD13QbPku8V519KhSweDvWazWFZRkcv1r2riu9Bfe3M32A+mWzS258pcm4Fs7fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YimM73WG; arc=fail smtp.client-ip=40.107.208.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZR1rRnr6T1WPCwIb7RztSmugooemlZpDk/sEyzrk8FWhvef1VLWnK5i3nTQUT1nssD4RiuIwS20HLRGMEgKglmCx5JvhPb9C7qrN/3yp8UMyCqyXrqcCKb83RX5lb7aJBBw1WIrrgT6a/gty4mT7mKjMEYBdPg8Sg6XYKIe6mceVpwVM5Ko9G8hNxMNZ3+A4dN0RfAkOybHhcZyoHj4gBoXK4LZmzgczcmPKQuU4sjCOu42vgXUYGhxkpAOA1loEK88cF5uZOZvQ2R0y9sRdFCS52cVa6PPZqXCLwZjjfZP1l77qiZQ4oIodwM4zbkJu+b93Lk4qRGvvnuNfwCZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/lss/7U0Jn93LufNxXrcNE/8ANPUQG9mwTfaJDa8tE=;
 b=kOn/Mx0fvEUMYz3ucL9liieg38jdGm/fEElg+MxGdBcRyp78lG6jNxkG/kW2wnKtLk/2HEVz1XbV8gE5bpz4/IH09ug7JxnTntyB7r2X2QAeANbACC1Q148agN8vMeox5figFvaak1f/CCrVQTurM+CHX1A39uL6nLaVkKC+BguZRu2phpMVhQ2rDCbBYsN9jNKHWLZXdSZXE2x14Lqv8MFHh99coC7JPRxqxa+RYkwndzPodL+VdDcDLAaSZ0XKrVPKqIDi26PJj35iSDcmlf9T/dmO0fXDioayfrXM8LAFdX2ZhRNe2ndrdt2DYjFRrP06x2Khxg1IsVnLLlEFPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/lss/7U0Jn93LufNxXrcNE/8ANPUQG9mwTfaJDa8tE=;
 b=YimM73WGP0ndAw77hj3ilUHRkWWVOZDqEzthECYeDNnXW1i7YV/X/zUmmUupIsj8A8Ko/CGKb6e5RnvO6xzGGH4Fagb/M7tQ82BWuP+71nBDS4xq6Td3qOakx9I+H+uUHADW0MrTcGoQoTgPRtQwdUmgeBb+QaO00nc7R6z6QTCPetHLKC9L8ujx3bAKoqm36WQpuPlDC7dPv9Vjb1MtMVKar7hY9nL6avjcFKYdx62yRP0h4uCWR7Kz809TJff/1XKTF07EHDDAexLuWhHerD3Goq7BY41oXwKfVNe5vSyuJgYheb+YQNY3FAb/PU50kguHLt+xeZsT/qInvOftIg==
Received: from MN2PR08CA0026.namprd08.prod.outlook.com (2603:10b6:208:239::31)
 by SJ2PR12MB8832.namprd12.prod.outlook.com (2603:10b6:a03:4d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 14:31:24 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::c1) by MN2PR08CA0026.outlook.office365.com
 (2603:10b6:208:239::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.23 via Frontend Transport; Tue,
 18 Nov 2025 14:31:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 14:31:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 06:30:59 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 18 Nov 2025 06:30:58 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 18 Nov 2025 06:30:55 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next v2 0/3] YNL CLI --list-attrs argument
Date: Tue, 18 Nov 2025 16:32:05 +0200
Message-ID: <20251118143208.2380814-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SJ2PR12MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: 2234cb13-bd24-47fc-1ee7-08de26af25cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2o9kRZUweLtWUiDXWpc3hlcyPJaEfJvpsaaeEQ9k2hwCsssR1mZsd1DYj92U?=
 =?us-ascii?Q?/7Gx8xkVT2tqfOvSW7aN+m8F43zweVunaXeA8aG0JCMihvzhsVlThA/Depq6?=
 =?us-ascii?Q?dZiQ3vL8MTTMmhPlfQ4v+zzPXyogpMi7IPUk5rjmGzc0VFzml/61uCqvZBZS?=
 =?us-ascii?Q?lx99lQvcCKDqGM56CWnwklBWbSvHYDeV9S48e5UZBUILmxwDnzXG6ptAdcVY?=
 =?us-ascii?Q?i5pz918O3H3pI/tECGobbzrmN/bSKw6W6lVjnbSH7/bL6G91R9WdDYvAZAKU?=
 =?us-ascii?Q?jjlyzal7hALM0YZV9CDV7YKCMHtfpZEiSIpwZzWBobG91TIzBdZeSVfxfmbx?=
 =?us-ascii?Q?OHWyi2Olx4MzrpvM86ucaCzWx5mDfNPQLEq8S4SURlFC+JMYQX21CHhPlFPf?=
 =?us-ascii?Q?o6DfKpWSCJ1P/ZNluDP7SMZYaMMdBbIYmKNYVEVyk65NGr+GAODrLssdx0QS?=
 =?us-ascii?Q?kq4hUUL+yX0tQzZ1xBPjkRkGgSQ5nbExxD54Mm6x6xCRajuN0XKFzEFrZKnE?=
 =?us-ascii?Q?WOW86N1MP1AM3tZqc4myf10W77IhYuC3P+JIhDetISoIv0xts/CflfvZtotp?=
 =?us-ascii?Q?dmaynm150VxQOPg6Hq5K8f9i1gC1VJdewr/aC9WW+p0Skx0oJKmgf9pnyaeU?=
 =?us-ascii?Q?IuFT/l/j94LS7NHcCl0e7HFMq0EBt5K1Lp6KRhqaHwoumPGEmUBaetifYOzA?=
 =?us-ascii?Q?nTkda7otfCGUzsYAUwh0PArZ8dymkThKPggMiFmYuMDd2diVV6mII9w3LLNM?=
 =?us-ascii?Q?gW1k5otWYwxDmGCRZCl9DaLZ7tTC0P1Km3/mkcV9mxoEKBd5RwM4+oeLJ0I/?=
 =?us-ascii?Q?AnHIvnuOqgcz42ElvqGf9Uzcg2hBB4pp7MGLn15hH3b7vulyhPbbW1cUfOHi?=
 =?us-ascii?Q?HLey+uGnZqFYziq+8q6PMxjHmekUXrkmN4U+dl2teGnIOenjAAaux2dIH1o4?=
 =?us-ascii?Q?3ZBDVm757YIvvkqBC3lpi4eXXfvM/67JoCqLesEUlkHm3RFAocbQU4iw3fLG?=
 =?us-ascii?Q?fe+dU4AwPEStZAglAW7nwEBDzc8IgF+9XBRzQjQx5PmlqZv1zproLWJYrF5C?=
 =?us-ascii?Q?eshxmI7jlD5HA8axWPHv1fWM10kVedHcRDRBgtMSiuAaEPuKo4Grtc49lRWo?=
 =?us-ascii?Q?NVhTFmYIZTVUxg80ext0f68EbwMJEW9en2m91JuQ5jAKv8zPjjepEBFBGPZk?=
 =?us-ascii?Q?7IIAnfytaBxxU3A176vnCewBavQCS86rLihu9jSi1X6QGe5wJPPvKRkWoe9C?=
 =?us-ascii?Q?3Dd+53fLyZrTkcyEbwJ1/kxPe34PM8AwtphrIlWzTML4nR5wccsFgXmy/5eZ?=
 =?us-ascii?Q?BVTwG06sdU3jYTyAT2btLwVvA4yERqn2HCR1O65590NLF8lUcSUUCDHur8eX?=
 =?us-ascii?Q?/cptirJraGeTLzeipDq+9bxKAXiUyPoJuCO4X8U12evq1OLuVxF/EGTXnbS4?=
 =?us-ascii?Q?b4C8o8w3w6HFRKPLzla29n/8OqHQ5HhW4cf9MWPuKh3/Um/BA45uOkQdMYmP?=
 =?us-ascii?Q?arwCGjtnMAnrBP7uqxo+87meIcPjL0K24RDim0llKSKqVk4vYPLaOgV3MCA3?=
 =?us-ascii?Q?BwPCaATO4NRhVXeaHgg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:31:22.6641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2234cb13-bd24-47fc-1ee7-08de26af25cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8832

While experimenting with the YNL CLI, I found the process of going back
and forth to examine the YAML spec files in order to figure out how to
use each command quite tiring.

The addition of --list-attrs helps by providing all information needed
directly in the tool. I figured others would likely find it useful as
well.

Changelog -
v1->v2: https://lore.kernel.org/all/20251116192845.1693119-1-gal@nvidia.com/
* Remove dead print in else case.
* Pass 'notify' explicitly in notify operation.
* Move nested functions out of main().
* Fix pylint issues.
* Add a print of the op documentation at the beginning.
* Specify enum vs. flags when displaying enum values.

Gal Pressman (3):
  tools: ynl: cli: Add --list-attrs option to show operation attributes
  tools: ynl: cli: Parse nested attributes in --list-attrs output
  tools: ynl: cli: Display enum values in --list-attrs output

 tools/net/ynl/pyynl/cli.py | 79 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

-- 
2.40.1


