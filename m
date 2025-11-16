Return-Path: <bpf+bounces-74676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA91C61BB7
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 20:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B590E4E3812
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 19:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A352405F8;
	Sun, 16 Nov 2025 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G3umut0G"
X-Original-To: bpf@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0432E55A;
	Sun, 16 Nov 2025 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763321263; cv=fail; b=K4o19tM5Pu+JcxF2jFSuCoM6D/8JMp/V88MabNOWZX+7xACSAg3kkl/KN3wdZ150N3GKWzHWDGzUGKqE+E3ox8nPeWCHZWDhNpkzIHjUs9tYMpuE9z5xOT6boXSwk54udxPIdt98+O8Ul/D7LoMzLISV8ix2NT6CEGgDrutiTvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763321263; c=relaxed/simple;
	bh=ChyJxNRsf0pzVy2bgKOHuWQl8oYRUnqIPBXP4VN2Zyo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GmIjGK8vAXyI5UCbI8NFFUiH1RxKivMWcX/cL++Hc/y6P14voLCVdUulAIrd6XWc/E6pgwlb0qbzgZiBO2eHX6WndlMJk+qdJ5uMzJ1BtF+tvHp1T3US0gxehuIj1EUWNlsDuKpD9PmfDHpEpBvemjAkcfuTARbNAqPu6rknEdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G3umut0G; arc=fail smtp.client-ip=40.107.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbi8OZJkexoRJu3EZ2uzIXL5uQQOQSNbNUr7mmNVyZmsA8hKpqq3juPWzawYGbvH9SY88VHv8OtHas6vuc+jH8VLweqJQZKT06Bc2+MoW7Qgi3xS3toIuXMOBerI1vAdxksHbG4+YNQyLsPuAcsFkerpp+DNSNzHeRkpZv0NZ276+YnRest9wctztQX8MGaahCziGE8cW1lr7emI8kDnX9tV4yqbgZ3TYttLNP6pLilDd+0e17ygXWAJatCp7hPEhPHAq2SsQLdqbwigwVLkRuMCLZXGen2XXS7z9i5XWGkPxpl6wjmQ3iIy/YF5oAhfqSvm7BTtU4Q5CdE2xfK2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6fSIxTGbLyzSDvmE7abUWCq/Ahe3N4BlCEx2K5tcAo=;
 b=uba+AHZPiXCwyXxZVERWQp9jmNdgjkbAr2W17xO5RBgPXxmS0Lb9JoFBxpq2awh3d2JGqb7FNcRDAWDT9SXiX0DtNTFOSimLg5TLJR7nadfLMvFU8djkcvOCCfNpRtJZoI6leIRftcFOihlWwsgTiUemG7f3mG1mKW7GzbE86kv9P/wYID74wujMRc72xhfmHh9HAchNqO7nR7WvtwpXylUyVpnWGPyqE2XfJfeU36vAvyTNhONqUCwVcpnSAQnDbjVqRgLianY9TdGa8yDSzxBgbJ2PMSFCqKcQ6hrsDqpRiXtjqAzexlQpxmOdMSTB0BLZl8zhr+Q61g1UecrGsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6fSIxTGbLyzSDvmE7abUWCq/Ahe3N4BlCEx2K5tcAo=;
 b=G3umut0GhtJUEyiyN4BTGAWObi8gvrRfVmfB13m2p/BGFk3hLYQE7Hp3ieRWctM5EWRU8Rg8xAAa7OuqUYicyRQENGGAZOMduD65Y3fiqYI6BjMvukwIDGTzRl52d4vsbH6T9OcNLZbISyKRH06i7EeuBsLaBLtQjUkHkRL/rKrvAxVA3/2nNyQm50QvwUkQbQPWGvomb5nr8hSEh/uii8RmmidFppUZhw9Ud2QhgRChBURCT/TbP9vnx2cMK/OLpxwg40xfajpHc55r68qkKVA+1sDSFjefcBkoajm99UQM2C19YHAKfFU6LQjOJHXqSunbI+4uzeVFPdbC7/9L6g==
Received: from PH7P220CA0168.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::19)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Sun, 16 Nov
 2025 19:27:33 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:510:33b:cafe::c) by PH7P220CA0168.outlook.office365.com
 (2603:10b6:510:33b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Sun,
 16 Nov 2025 19:27:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Sun, 16 Nov 2025 19:27:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 11:27:31 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 16 Nov 2025 11:27:30 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 16 Nov 2025 11:27:26 -0800
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
Subject: [PATCH net-next 0/3] YNL CLI --list-attrs argument
Date: Sun, 16 Nov 2025 21:28:42 +0200
Message-ID: <20251116192845.1693119-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b01da8-9f8f-4aea-f251-08de254630f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B0o0ynZAp/lfePXruVuDs9T5/nIcbvAu0m9UmjuT6s9pLpmJavbtEdrS5uHt?=
 =?us-ascii?Q?Igc8F2Rm7X6vwuydwwjF0YfiMh09UlYQFQ9TvbbFfFwodMDC6sYyamJmb2iV?=
 =?us-ascii?Q?zQY/sZF3CoLqz99A5O7B1h3bkyh2Mb02rFBH0Az1JBRqKfVPPfySgu+9SfA9?=
 =?us-ascii?Q?0op6PotNkrSRB+hp2rNE98ZqZUa0X4QvAeSZG8IOWhCQnX2gOrhq9NL085IX?=
 =?us-ascii?Q?pPQG6YD3x9taK40CdUDDSALlT3CmRYiINo6ygOTYpnlGaMjW47RGOE9uVlFm?=
 =?us-ascii?Q?VjDnesFS5Z5M+gzJ0nuYQOXIgBWGUqlMFdwZlfwEWJkVGx7h17QE84oxbxzY?=
 =?us-ascii?Q?qBMBUfBRTyVUYlnr9IMpoLC9NZj5xc7KM81Jd2o2izVBnok0D0Vtxej1hhIH?=
 =?us-ascii?Q?3IiPu90DwhoBspZS6s6Y1Gyf0jOTO8J1jw7WrakWJgzkIhQKOGtJzh0OZQcx?=
 =?us-ascii?Q?En64XAwh3dULZ+HKsQLXkvaCmH7kvpDy2CiGyvJv/5Qxm/DlTrtjPBkw0FWp?=
 =?us-ascii?Q?yoMA/2aGmABXM8h8D/cyCxDjZ9NQKVyFEXs+5N3jd3088QYXwHvFQgL/d1hy?=
 =?us-ascii?Q?Emm4LiuHECNfWsAVTiVmAR5sB9Zx3RW4zM9IZlO/tzW3FSyWn1n0KY/69xTu?=
 =?us-ascii?Q?AkMwMtubuyTQU2OL48WpWbKJY89p66YkEk3H723BZQV1Y3elXRqRKOomCjFc?=
 =?us-ascii?Q?kqerp9GGvSA208K7GEC7ZY6J0L5OlQExQM3B1CpeMDJ4SrIy9i6VEKUAcHDG?=
 =?us-ascii?Q?m/2eFk6j9aov5XNFaursx5K4JAkMASQEwjY2psQxV/wgUhvOxMNnxqAANPWG?=
 =?us-ascii?Q?EEc88wYwnbDlbcabDMA5FUom3tQTZE8uThA8uOylHVVfn0TSOcb1gW5iZofM?=
 =?us-ascii?Q?NedmL0M+gUzhVweQTUki0vbS17KnqE2rtjl8i4mX9iV/nII+4X/RNdrQ21xG?=
 =?us-ascii?Q?G8+1ufKx+T4+lSS8EVyQmDAdFG+NY55Rt05g8LOQ55NEcBW1NfUJYbftbz2l?=
 =?us-ascii?Q?WSrWxNrVs/dVfLu6DNkuJjZz5IjfrbYaZHLFzciGd+W2KuusjVCznOJHPo6z?=
 =?us-ascii?Q?uPQIAE5HPCP60frdtXVxbYd4AADc2oS8i6V31iRLDKgs0jCvqu9mpkXJxrsk?=
 =?us-ascii?Q?q+B0StgATKgMcA1fbQz+A271jwkGGY/jRpSYbxWVBoL0wolLMs/EI9Ro7Ifw?=
 =?us-ascii?Q?xMM0EhjCvGV4TUqiV+SJkgMjVeAGuyH7tIAZ9oRf5UxrCZupgjLwoGoojfsY?=
 =?us-ascii?Q?nOFlixLKDIjSpZ53J8GdAaZ3MwPWJWhlkWSHNJRAzT7XokuAy3gpiSoDr5AQ?=
 =?us-ascii?Q?NV8xdzYi6L+SeNfd0ZfSVO4l24gSJbckVlB9kV8wbrCncOMGjDPqZ0zc2ja9?=
 =?us-ascii?Q?1t9HPb+nR84ZwtCfonR6CFCMsbaFiP36nOMj1X4iHuO+bG2Nar7uCZf1F2+c?=
 =?us-ascii?Q?nw3zJKB2bfi/E04jIcJ6O318qoMGvcf/Ta2i+eff8W9OBqQgX3sO4f+qKYka?=
 =?us-ascii?Q?4v4eloBOeaLt7ksd4zvBD+ps8q39IiXQu26h?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 19:27:33.1493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b01da8-9f8f-4aea-f251-08de254630f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538

When experimenting with the YNL CLI, I found the process of going back
and forth to examine the YAML spec files in order to figure out how to
use each command quite tiring.

The addition of --list-attrs helps by providing all information needed
directly in the tool. I figured others would likely find it useful as
well.

Gal Pressman (3):
  tools: ynl: cli: Add --list-attrs option to show operation attributes
  tools: ynl: cli: Parse nested attributes in --list-attrs output
  tools: ynl: cli: Display enum values in --list-attrs output

 tools/net/ynl/pyynl/cli.py | 77 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

-- 
2.40.1


