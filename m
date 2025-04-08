Return-Path: <bpf+bounces-55443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9F7A7F778
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 10:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A702179A2F
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 08:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A599C263899;
	Tue,  8 Apr 2025 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Hq6EdUkJ"
X-Original-To: bpf@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012054.outbound.protection.outlook.com [40.107.200.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAE817F4EC;
	Tue,  8 Apr 2025 08:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744100150; cv=fail; b=sRhax9JR8qxuyB9dZJBArUfGYOvwAnnT7snR1NhCxas7Kb/5N+LIACeWNQIc5k9iywE6veneHibbNrVHd/g4Nz3rYRWUJa72stFS8qFHvMMT0f+jZPNt23cW/pgPYi8j7y2FSs73RZYw7H2fGnoZnWa3rFIONqcYIa2hoQvHndQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744100150; c=relaxed/simple;
	bh=x7F3U/tDfL/pJ03Vc59F5udBeeLh4oIjKbsnyLiWXkY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jTz/pvRkwZTCLn/GZSKbufxiXFTyVOmQTVLA8dICRzvo0lcDDFoBpgXyUm2K5J1f8L/3XmLcLvpcGvk3GqQ9PjeokUb7tbhCtQAophP4db8LDggHHcvTWooBwpB5kWgcViD4Km43NIWvV+guSBqa3eiLDzKmWQv35WBJQjzRxjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Hq6EdUkJ; arc=fail smtp.client-ip=40.107.200.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgfBKTR2OLdLmldEVVwqtHhrcFy4lhfcOCZWmBk8OT07hNXO8wTRiorFk8ItVaCCkA1oAiK4V8yb+KLRUZjJSUQg6HiR5ecJrXQw+0e3Aj+5iMAqI+CkMSedXbHMCqG09r7Cu70vWubsOlBbvB+hBzMKQ2xGNu6JAeU4z//KrYPzo/5cyjXKXg36ZEWJJwBRxx7rIF4qYlwRJPWp91nJ06xBtxexWWmU2pCm8xOrh24yCmKk167iFbWlUhSi9oru9pA+hC57fl3bPsuB60g78M+nSQ3kpn0KXKQh354il3Sk39gHnkDKEIgB8hbQcj3sHkEXA51hxBXiOdIvhH7/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E92S1WHW4r6OdR+i4/cG2c76Z6KERhbm5lHrsIG6NoU=;
 b=NAcE1BNt3UztFvXTmai8gRvYF7rTpfCLEKtcsz4oY8kMgvz4wddi4Ttc+DwkvQ/z3GfPaxcXFdeHnx0AoFq+82ikhWqm93JlwVfbCfdXUK0dS5Irdjg1T0X9G1lNTp27VsuZsJojHHW0VzICn6JB0NmgkaTsUXXyWaJmIUO9QO3j4IGEOfhwpKYm9qFmrN16JgPgZzYJQ8xjfaJNCTABc7zelR2TN9uSXNNMPnWmKU6ftdWa4/Nf//TqSVpsOVJU68L+dpzSAK9StmNSaJ8xL8uik+qizyZqdTFp9Rjj4QGKxsYVJ5kK0pwKtWovNPM33hJQaCWrpcFxUX3AScBofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E92S1WHW4r6OdR+i4/cG2c76Z6KERhbm5lHrsIG6NoU=;
 b=Hq6EdUkJzFiAHIInATGRoP5uXA82zgzrnJZ4xkJlXVyiGHyU6EMoDTsN//+FwozW+dhoFc3HoNsMOgffkjE4ou9YgOhY63S5sNAktWpI0VkBQrb3tM/alrI+tTSLlqHWld8Lnleb6QIdQbD1hDz9nKmXFU3TF6UMUtBbYjMAify1nuCwi4JXCxU5pcmn8v751mHaeBOLbDmwnYg54Y0rRXktPhPFMQCmgHsLLpC8yQ3fgPE0H5H/6GecnAlb1OPHlX9QfxLKVIHTUrwQ3x36xscA3CnAOG9kytnbaYP+LF7Tr3SSrJVBrsyW8cft8XJpTrhCIoNEAdoiSDjG0dea1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by CO1PR03MB5666.namprd03.prod.outlook.com (2603:10b6:303:9c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Tue, 8 Apr
 2025 08:15:42 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%3]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 08:15:42 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Tien Sung Ang <tien.sung.ang@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>,
	G Thomas Rohan <rohan.g.thomas@altera.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH net-next v3 0/2] Refactoring designware VLAN code. 
Date: Tue,  8 Apr 2025 16:13:52 +0800
Message-Id: <20250408081354.25881-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0089.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::30) To BN8PR03MB5073.namprd03.prod.outlook.com
 (2603:10b6:408:dc::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR03MB5073:EE_|CO1PR03MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d046386-abe8-4889-c3eb-08dd76758de7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fvevObgTgs9PEl2IcMo8LJmtEQhsgsjmCzmpcT/WrHSwWSZMcRsxnsrm5q7T?=
 =?us-ascii?Q?ff1JCC4tnZCR0xCZWjUIbGOOHJ8lcMCcGjOgzk/RKoLHKnf21n3Suytgnq/F?=
 =?us-ascii?Q?E9TQQNU2gPfu1enn+yC7cz//hkwQS0Guemcl2Z1lwNQVTiM7YNL1NrXoKjBZ?=
 =?us-ascii?Q?44SzUrfxdv5Vid122wddztF9JeHcbqmUEt/cIyjutqsNsrPk2rNnkB/jhSzp?=
 =?us-ascii?Q?rFGQ9W9STz3E/vituBhMxe38PHpFBq/Ud518AMWJpsE+UxAeNCG63IcP+yRx?=
 =?us-ascii?Q?Og2XbbV00QOWuDPuPqUFCDoZy39hFc/opDqj3FGvV6Bu3gXo6PF/wCAlHqqj?=
 =?us-ascii?Q?0SNyX9DFcxNK7HBq5yu4SeIxjPvWGcTq7i2hktcvF/mgf3WooBEQ6UYdk2Rn?=
 =?us-ascii?Q?6rgqltYtNhYFHFmsGApS/yyu1Q0T4R0QTblLfB/qF1q2AAGwTsDJiaYXjefj?=
 =?us-ascii?Q?IM90SD4I0WRQtz5rCjf4iyJkk48sCg/+LcPIZELYm046uRAkg0ezaz9SR1Fv?=
 =?us-ascii?Q?OjgJxM9bVUcdyM1vkeFEdpDBjWtxV9VbhDXswDZoRlT/Qnd0wK0G1NFQGpKv?=
 =?us-ascii?Q?VPf4OUjSZNpGECjcNVTdgw9333uGNR4DHRvBJun7asX5KcmTNVLlKBy/vmNs?=
 =?us-ascii?Q?WFrVirJRr9lIDHR58lpYfjn1jrv8bRb+9OQcCaKm3grqXnKE5F8HedbFecIt?=
 =?us-ascii?Q?mcOBF3KYUtP2hs7TYokCzUn0hvj3PLBzE9fYvdM8/XvDztqDp7QZhY4goaOr?=
 =?us-ascii?Q?BWk1UmPp7l3T62MkFSgl7fhR/17Mt+im2a8tWy2kOBN4tUIVueTQkjUdx3at?=
 =?us-ascii?Q?6Qa54N4JEn9Z5EYoCtiiwImXzJ6+4mZ8Y7cet2bsAj3er4SEle9S9mCiOxtY?=
 =?us-ascii?Q?JXSt+2OK67IjGHDHrgE7KDRm64dnzsw2hnacAKCRsCi1mCLCM5pK9tNRKBDl?=
 =?us-ascii?Q?1jCfCWXiXne7GAZhd7s9FnOAHGtZVj1VIEyxCsYIg0uyMHzTyifEM5lQC9YT?=
 =?us-ascii?Q?CfSMcixgKjkzPgTGovWkA3IIr3LbmAMUjx1KyATwRZwzEool7Wi2WeFKYwVY?=
 =?us-ascii?Q?Em1gDFMrHpYeRK/fAwLR8cl4eZy7/84V+SJEKxeArOLkXwhj1AX0LKXR+Q6Q?=
 =?us-ascii?Q?Ou8kiFx1NeBa0IF0y+XW2mTjnxN8ewyQ0Wp4enLXecw9J1wrWBC6f9IPEh+Y?=
 =?us-ascii?Q?08QPXtMPjRDLaQpISV0t3CbbeFVb+BXVtayAfWbghc4oohjTTL4xTguqa5sm?=
 =?us-ascii?Q?kVWJsrZzYJ5qi37CJ49KmBwznUpIRC4PmTuzydH151grhlHQqpTl63sWxq8j?=
 =?us-ascii?Q?8G6fmnr6tnvDjNn/E0Fje0xQdQBv36yfp0H4Eg9xk0kH2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB5073.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fQBuoqeO9HS6KJtMeyx3FbFrBskjo7t5pQYM2GUJcrHs0K71E3KxZnWUBJ/k?=
 =?us-ascii?Q?LsrEQfNic0TYMXx+T6Tz5lMof/kUYPQsD7N5oeLql7O7pba/1hbAXCXqajQm?=
 =?us-ascii?Q?xCPMLRyB0fxv1UxdzdOY1z++fjJhcMmmV2bE/dw9RMxNPyw0Og35hxax+lye?=
 =?us-ascii?Q?tRvRwZIlGMR2dWYa4j7epwB7mDOV7lGz/hrndJeUA8fVbVziVHzW5hUsbFf7?=
 =?us-ascii?Q?lC0IS5LK3Ey0BJhDUDte+9kskeiGy0RhSMMkHREC5ZP1odfUh74LfFq0YtI2?=
 =?us-ascii?Q?X8FsD9XnQfnqaFlEgB8zHPYLMtnSKjEI4N8WOEiXvxd35OgKYrvUPHopU4sr?=
 =?us-ascii?Q?oDMjQhlVIVQKyR1P2gmE4OLORRvyt/NXCWOveOgqQ5Q+cgOgXGp+SAF1PSn1?=
 =?us-ascii?Q?DjkBBW2jvRZncDvJzBRvsBqv0GLsz4GB63h1fLZpZZ9j2FWEAGIuD+fiRsDb?=
 =?us-ascii?Q?iK6tSq0y7gxfSWCGNDJHjb9UL9asdYQgJIUPrBzMiQKEaESmYI0LXMeRk65q?=
 =?us-ascii?Q?qm6SQJi0AlNpjeMxL4otv9oTHMG9MAH89wR22E4cmgxH0a6kfiHYnmtoNTrJ?=
 =?us-ascii?Q?CJ17l6LerIh/yNAA5LkFiqW55cGNLjt2HtBWM7ZA5WkpjRx5jm5aRu6iqpY2?=
 =?us-ascii?Q?UYh+brPjsXYbTwUrhw1raZqMutJE5c+LcaWka5bjHigJ+NOrb0TD1c8hNl15?=
 =?us-ascii?Q?Gu2Y08QmBfw7ZAapbqGABru2S7jy9oqZVrc5Xfa7Thq1GFViduB3qF7QRJ3v?=
 =?us-ascii?Q?k/StI4K0SnKNCwjSX+cqRUKItQRPe7CilUlxmJ2Hd4P4uSb4WBRDkh98gfJE?=
 =?us-ascii?Q?SS+OJ8PD4C56I9G8LJidgnIKHXDB+7+fbxBem2vxaZPqcOLFTAPngRTsQor2?=
 =?us-ascii?Q?i718F6JOWNq7n5Xl0+U6xzFxmxZFHvUYUJqY83MsInvOfdtPDHbMFDuvdPum?=
 =?us-ascii?Q?2pmIRQf4CqMD25LFmkF7pE0HxoWawBLehIkkQUz8DoIbJKDP1gkV5xcp/xUe?=
 =?us-ascii?Q?6ciLODITtG73XPd4nQ5QuGRfz73zxRT8kPTJIKJqDsTkWeSQz+ZcGxrhGD+H?=
 =?us-ascii?Q?Y5zFTGNgeXc2do0ozNZGKds4k6dCHQLfEf1m0TGJG2/vkIUwkhl26ecaVVS/?=
 =?us-ascii?Q?HGkRzAnY2MLkvoDxOzKd32N5firp/XLGmwTzTKEAenzXx9BdnR3B+BkIQktZ?=
 =?us-ascii?Q?DZ3SVeBRvJXc2mPYETwoWLN6CNRxWfZpDhg64qgHy33uPwd5bxZPkFifWEYw?=
 =?us-ascii?Q?KO+RGKr12xeRZyx6gyOUq8HFqOMCprSiHbWeZLNrVznV1IJ/S3HSWSckH8/U?=
 =?us-ascii?Q?yGtpXJ5RR8AyvRcmkk7twe4+y2JZEBedhrov0sgWmmY9RYY9QPC4gTnP3tce?=
 =?us-ascii?Q?5JeWWzwIJ0bCkvuAWV9F+BI8mbo9rP7vilCjxdZkJ6IM4LJnstqrI1qVJ23t?=
 =?us-ascii?Q?cdYknAQhyUgZaZCiZryMGwc0SZBWedggsjRAbaCYCzLgCDHGuTwjLl3RZHkl?=
 =?us-ascii?Q?ceJRHn7nWnuZDNih2CK6mPT4rjixTb2vEzIE8tB84y0mgucYNcAVmelMFYnv?=
 =?us-ascii?Q?A9v2eR/ZOl+tsz4ZJWWvJ+dGf9wJIXZINpDkk2hqYA1toN6WfK9NUStzghue?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d046386-abe8-4889-c3eb-08dd76758de7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 08:15:42.4664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zpb17DGc74kzrsG452BMriDy9+vcktx69RT3ftj1nLm+/m2WOALzwlQGjAup1gE5DPXJWMMi3k2VPIc5Xz8w9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5666

Refactoring designware VLAN code and introducing support for
hardware-accelerated VLAN stripping for dwxgmac2 IP,
the current patch set consists of two key changes:

1) Refactoring VLAN Functions:
The first change involves moving common VLAN-related functions
of the DesignWare Ethernet MAC into a dedicated file, stmmac_vlan.c.
This refactoring aims to improve code organization and maintainability
by centralizing VLAN handling logic.

2) Enabling VLAN for 10G Ethernet MAC IP:
The second change enables VLAN support specifically
for the 10G Ethernet MAC IP. This enhancement leverages
the hardware capabilities of the to perform VLAN stripping,

Changes from previous submmited patches.
v2:
The hardware VLAN enablement switch was detached from the
device tree source (DTS). Instead, the hardware VLAN enablement
is now dynamically determined in stmmac_main.c based on the
currently running IP.
Link: https://lore.kernel.org/lkml/BL3PR11MB5748AC693D9D61FB56DB7313C1F32
@BL3PR11MB5748.namprd11.prod.outlook.com/

v1:
The initial submission introduced hardware VLAN support for the
10G Ethernet MAC IP.
Link: https://lore.kernel.org/netdev/DM8PR11MB5751E5388AEFCFB80BCB483FC13FA
@DM8PR11MB5751.namprd11.prod.outlook.com/

Boon Khai Ng (2):
  net: stmmac: Refactor VLAN implementation
  net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN stripping

 drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h  |  40 ---
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 295 +-----------------
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  25 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  89 +-----
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |  18 ++
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |   8 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  61 ++--
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c | 294 +++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.h |  63 ++++
 12 files changed, 434 insertions(+), 464 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.h

-- 
2.25.1


