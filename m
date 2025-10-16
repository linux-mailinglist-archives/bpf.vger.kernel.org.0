Return-Path: <bpf+bounces-71143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCC5BE549C
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 21:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB0D24F3EC7
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 19:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDC12DCBF1;
	Thu, 16 Oct 2025 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ILFHLKrl"
X-Original-To: bpf@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011056.outbound.protection.outlook.com [40.93.194.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9D52D9ECA;
	Thu, 16 Oct 2025 19:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760644598; cv=fail; b=Xfk/7vehr/E3oXROPPlOngq2n/QoTVXrE2egKcEWZgRcqp08xMCrIfSu9EQ5LPMpSzSDYzJvdVArhrGhooBYN+ztNuv+usKTae8PX8f3c+qKZH15YGmgdHn4g/bX96T7KeDMKeDQyxlF9AduN/OjUDJmHXJ6Y27TW+B1U1rj3RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760644598; c=relaxed/simple;
	bh=BYm55Ra5kDvEnQoorZ9vas9/DC93g7/FqnfuPF/JDZg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=leYWzfri2GD0Mxotz/vWhekxSy9QDq2VzkD7F49BINQDyZY+8vI+q2s16zFN9aC9xqNJTN8dxnq0ABMpWTsSQwqhJYpUl7xc2sqyYPdaWWmIABMYW6EhgG/c6WjtshxRfU0RiOSGwVRQJnIgOQYlqy3nlHf8t2/AyiKhiRcZHyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ILFHLKrl; arc=fail smtp.client-ip=40.93.194.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKgvxWdI5CFWLtSVajiej9XqmGZMVKYXlrNbTh1TPihuXQIYPtkNGqBQrawYc3E8rZJKIyNuUQgHZlPfwUEtn7eAuTBPdEDEXRLNv5/iLsko/IkToxwrlPgm+b7OmQRs7bhPc4F2esWXudLCmGs4+NHVQAF/3yyej1lMg/aJ+gO8FhnINV4A/4NOY+SImC110K727NsHQDlgNr/jDdZvRSI8fFMlknRRjP3T2tcKOFdng9Ag0n++rb0+WWbZArHvOsM3532RIRHECWMBtWIQhe8/mmPrfrBhcSPM3w/M9yrA5iPQR3Pz4SJC6HNCaadZiFaRAocXatHC/nR2CSpSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAnl+O9VatNgsGISK+XsQy0dPcj1GXlFNAVbcr3kGvg=;
 b=HLlWmjp9Pi2pPXoxYBU/BQOg+m+Jjcc0gymfIyB7i9/tCb2RkiFO+Es0OdBi45Osrmjg1Y/8P3povQXlOqICYJrOskwDrJeqaJBCRFxheLHrrRLzOzfJ+gElEUB4ey/9pY+wiBCrlHsBjSrbq7tKaSmDvCIKFmzhxJ39J6qSImXfLk+ofuVQVTbEE4hnDnG9vjc7UkeOW02CooVh9Ib4TO3kzwxzK+Qn+WiF9lHSZRCJWQ6QEZUieB3/PnUxR6TUCfuT/xtS4D2n412zG0zDwBKne+5zIRDJfX8U7o1fCU7qnDc7lnHtCaaWGGVQzJoko1V9E993HOBiflSLfF7NCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAnl+O9VatNgsGISK+XsQy0dPcj1GXlFNAVbcr3kGvg=;
 b=ILFHLKrligVtsgDJvFECYIXJ/fxJwTfDCXYmqvo3EHlj6eDXXURam/HlSUZidiSDlj23W603uDJvgfmymeukIwDVMLDmCxZHv2TnmQtJi2khae1dMYSK4FX0SwZcbx9GNAyTh0h0g79fLdxvgbZIiWTGRcs2ctVL61MN+IA/cehLJe2HQTMiOAYO3lSRKLC4aLHU6ZND4u26KGlrFK+cWWC5DBB0p6UBKHBWvA4UEDv2lWweGnRKgoWCGfObiwJdCqOn/ZgsX626wO9R6EXrllJ0hYXzJ42smCvtgyCpsWg/J5UOHZvaqV8Q94AqVfm5w0ga+snHkKsZH98v8aHMrA==
Received: from SJ0PR13CA0185.namprd13.prod.outlook.com (2603:10b6:a03:2c3::10)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 19:56:34 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::1d) by SJ0PR13CA0185.outlook.office365.com
 (2603:10b6:a03:2c3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.5 via Frontend Transport; Thu,
 16 Oct 2025 19:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 19:56:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 16 Oct
 2025 12:56:14 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Oct
 2025 12:56:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 16
 Oct 2025 12:56:07 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Amery Hung
	<ameryhung@gmail.com>, <martin.lau@kernel.org>, <noren@nvidia.com>,
	<cpaasch@openai.com>, <kernel-team@meta.com>
Subject: [PATCH net V3 0/2] Fix generating skb from non-linear xdp_buff for mlx5
Date: Thu, 16 Oct 2025 22:55:38 +0300
Message-ID: <1760644540-899148-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: e57a7f62-74cc-44e5-acd2-08de0cee1bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MCx305qZQJyt/yVjpgXyqdpK6KFOzE20pkf47VB/eLWzKe6w7++zubMZeyAr?=
 =?us-ascii?Q?EnACr/xe+R2qYZ6FelY0RT/RVaWkwO70QxOTN8nE0roghqed1Ov64eCmaw0u?=
 =?us-ascii?Q?McXBqmV4FlwiZqJgvHZVCTNti7SeROEcnERCdX8Q12N7RJpbF0oAArNflFLN?=
 =?us-ascii?Q?fFF/BzBxJ01YR6hPE7TihSPUEEhuB5N53OCNqfb5dkjqPZgBDIX1GnEdJqX4?=
 =?us-ascii?Q?/mn5kgH/mjYBnnkQhgnl6yLb6bHnrQHNH3AKBislzK9rdrGsa2xZcQtmawJ5?=
 =?us-ascii?Q?0v2BY7Lgiu8dobRrRblTwUQiBCk+8fvr582ddlCkHOeEKrA+x0OwTBs4tyi/?=
 =?us-ascii?Q?LM/X1QlF0G388FULT+5HoFS3o5TIxszRIt7c131Gi0Z4a9Bp2cemTtlM/Yo4?=
 =?us-ascii?Q?egrfcSfdsy7I0pKvVzoaoEcU7E92ULVW/JdFemxLxbDGb3W/FeFvtdHVqa5P?=
 =?us-ascii?Q?VzYtSi2ZDAhM1LgOTCAvTzfMcgj/YVXaaJ20HsmXMi9dbeAzz94KziQtVmvL?=
 =?us-ascii?Q?5OkAHkaHWm1MztRty+L6YiMX6zAK75lsXfPZ58DrhRqkVX2LnCH+Rc95ZymJ?=
 =?us-ascii?Q?Ze1naRG05/+DkI5aAniKzna5uSR2dPq+TpD36fkwRfQjGje5PSZwJd94T0Iu?=
 =?us-ascii?Q?uw75kvYf9v6QbFaF6m15rHXn68ODh/oT6PFn3NZ7E1H+5vxAB532obGwHtX1?=
 =?us-ascii?Q?WkrP9Jyx64AH//y6f84fpu8mfRlpYNxVDeBIGZWVwea0WBEkOA2uuNaDj5xF?=
 =?us-ascii?Q?V9u8f82utiAXvGOuUJhgPM6izSXGxeNkBwWX2y8H/OWaFY40q6lQMB2ufxMq?=
 =?us-ascii?Q?Y9rIUddUdW7Mpw9Ns0EyCJrAFqfx6QsNbxQJB4QKw1jFZ8Ra4cL8/mhiPUVt?=
 =?us-ascii?Q?hJYBcgphBOir1cs2oe2J2jUStG2PHbeTiLJW6xHXokeMyu8gStaaZRdPM2Hv?=
 =?us-ascii?Q?UINUwkm4iuE6m/LtL6W9Usi7gBikbhGVU0MIUP4gi5Mrg81XCnqiOTiGZwO6?=
 =?us-ascii?Q?aJ9tQOJhX4KlHqDAPOaTbLAGvwZ3+blhPOoiizCQqQRIX2FcfcUnfi+61OMu?=
 =?us-ascii?Q?ENBu4hpysTakK60PgaVxkS7itOBb3ixFSyRRw6t3csUZR1VbDNyIRXBTcURZ?=
 =?us-ascii?Q?eMPGJPMyQzpQvv+CBPUU5yJITreRJCOYL0KZHSiJylQJv7uB0Mm/qP2vl+wM?=
 =?us-ascii?Q?FsnRpVftAwmzIJm9FVoEQ1BgKRPqfsqCadv8To4lHYonXabqSLklWZLJ4WsC?=
 =?us-ascii?Q?yxmoBNNZegd+1xu7ERJqMJi5YXDPJO9yLo8DlLSNF3vBJkxTu197+ufwKUz3?=
 =?us-ascii?Q?qw8eGyplHV+3iEAz/+vbST1KwRBbWkErts0B9WhgNQzB7nd7iybGlAzsrQ7A?=
 =?us-ascii?Q?FiE6mtkGcXdNPYPSUKUgkH3UhTHMAqbwSElxVceH5nQVgzNhMhxAUVPFZPVM?=
 =?us-ascii?Q?Lb8C/lSVJXwFiFLcpEhh9mRpNnfc6f7NIAptpp34Fn6tQ0TBGt9QQpPUHDSO?=
 =?us-ascii?Q?Oyi9LNRwjb/5R0icyXpjsf2e+Yf1BouOFYLpRD+tpWV0i57ntmVUeWEm4ZqN?=
 =?us-ascii?Q?CgX3RGyIQ6n0cwdFDloHqOBj1JeWF0XN2XHVgDUf?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 19:56:34.1047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e57a7f62-74cc-44e5-acd2-08de0cee1bdb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573

v3
 - checkpatch fixes

v2
 - Simplify truesize calculation (Tariq)
 - Narrow the scope of local variables (Tariq)
 - Make truesize adjustment conditional (Tariq)

Link: https://lore.kernel.org/all/20250915225857.3024997-1-ameryhung@gmail.com/

v1
 - Separate the set from [0] (Dragos)
 - Split legacy RQ and striding RQ fixes (Dragos)
 - Drop conditional truesize and end frag ptr update (Dragos)
 - Fix truesize calculation in striding RQ (Dragos)
 - Fix the always zero headlen passed to __pskb_pull_tail() that
   causes kernel panic (Nimrod)

Link: https://lore.kernel.org/bpf/20250910034103.650342-1-ameryhung@gmail.com/


Amery Hung (2):
  net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for legacy
    RQ
  net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for
    striding RQ

 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 51 +++++++++++++++----
 1 file changed, 42 insertions(+), 9 deletions(-)


base-commit: 634ec1fc7982efeeeeed4a7688b0004827b43a21
-- 
2.31.1


