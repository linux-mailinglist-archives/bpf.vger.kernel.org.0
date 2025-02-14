Return-Path: <bpf+bounces-51589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9A9A3664C
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 20:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A091894D61
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 19:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31AF1C8628;
	Fri, 14 Feb 2025 19:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S3k+uz/D"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C374A1C861A;
	Fri, 14 Feb 2025 19:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562119; cv=fail; b=iSAIJ/6HBoDQuaBXlWg+rOA46nWgUlh2DFjFSeTvXvkHdBgpfG5q0f8AKNQcRKWUxhQO5mHGpgXsL8xe/0KulJptgJEAmEP2b3BazmGyXYfEK1J4Y3jRlf4VfTRMKhPYBLInkZQjcn4aO/CmD+0XEYsPBATfFoBJLctA1iTZlPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562119; c=relaxed/simple;
	bh=abpva88A29q1hGjevOu7GiccEPzOSauBGOJYgyNfJRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GSvzgeDhzoix4Dd39KUxUm0kIi0fQliBz+5C+n47plpawAia5bgp8sgEGe8LPBBKc4laVnyIWSfoLB/3k7ehkJf0S3K3l8PAQm2PCO4ORuWSBA1JIZVbJwUKXDYA2x7oPYqLmIWY7aU+aqyR1TalzNK2Zc6/+Fo/8PVjnTvGrP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S3k+uz/D; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xerXBTrWWY7O26lfyhkoJvI21AW/+bS+JRfxRdqvwSBBs3al3OUeEottNllrLh3MYHgxHByBP8VMhGdBPXBL/vUPANUlC0avhHm2GByu156xrfhMf8Hy4ktW0tL7SZ+lAGWl2MxPmWm5BuxNoiE9olmVI1cm/Mm9zU1HljPMKlUEVERuRiI+eVU587z6TNibU3AF81k0uE8XPDrlVo0L0AB9yd6rdnBtuS+bX2jDnzrW3LwDVtVsy741zFWu5R0ywykvEAxhV2SlpJIifSbMorg0y4qwPPmt8CmnAvRzg2LiTF/nsGjLFV+mXOMn/6KOeYsaOvnS7yOJbCo3G9YfNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcDORQczBswtZLWD4PdRBfrw6VmL3jJuFgNG2lDku38=;
 b=sfSUCYHaUugV+RnIQny6xosM7i1N8AeykStdlCBJD7ESeYQgcNUFmpepxUy43T6pCrMI4UGJPnZ/dhf1e7IqvHs+IMRkNIb5osCt6sBk9msCphFzEwH7QVrpxxIdODNsTCfw8kmrLaxgMV3Or1NbPRyjbbORGkz/RQrHNPuckTjZiv40eV/rwf7lBOm5C1VSApWEcb9eLLS87i5kH1J2uPmDyNVm5uAQgEWix607XqPIjrlo2JgE1fgW62LqwCmlCe9lsQBr3azb8a7fYLeIv16Xt9dHRQMFL7QGQ+G+lD0egG2CyUDWwUjOQOBLbuXu28k+rCWRuOJDljj59EbiXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcDORQczBswtZLWD4PdRBfrw6VmL3jJuFgNG2lDku38=;
 b=S3k+uz/D+0IrcPwnxrZPEmqRgje11412mxNUvgcSCPXNW60nqEqS3YEmSxENZYTCcYipgg/rExc0pvOwDVW6TbynFCxzQjVPI3jLDIBI/IUnH1SqsfWF4pqObsqx1bnSnvj1q2qc+LdZXgDQFNlsRr1GLg5e5KrqNmKhG1hL3DqyczaGJSxcBr0CE5TAPPcW8ImDr2OKUI+JZfCRLD6Zi86mROHf91k7+ITsUn+xlulM5MX3SjRN45zvk1h4TExhC+/AIxjCAFW5nIf8w0SiSuFIaQX7Th/iW0Abg+UdJ1AaqmTyu3sZCAwuGJ/3GrFoS5k2cSrahZUH80PG4bvAPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB7809.namprd12.prod.outlook.com (2603:10b6:806:34e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 19:41:54 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 19:41:54 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] nodemask: numa: reorganize inclusion path
Date: Fri, 14 Feb 2025 20:40:01 +0100
Message-ID: <20250214194134.658939-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214194134.658939-1-arighi@nvidia.com>
References: <20250214194134.658939-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::16) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: 2882b00a-b830-4a76-5fe6-08dd4d2fa2d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cmxXnvDF4Fe005C7LmuJoPgOyNFJaFZJ7Gu+LzBpLrDulQpaNGFsWo3MoZ4A?=
 =?us-ascii?Q?AVUyRza6kecaRk2Jp1Us42o/NvSA/91TJ3KggOR6AYLJ1ACy17YVuKxAxKUH?=
 =?us-ascii?Q?BIZYZr1W6lGodZDN6X+rhFeHCap4oE8x2lBFhELYlutl6Iw9FSSPmP3snOA0?=
 =?us-ascii?Q?yFOJSkN055tn97mDKKI1vugnDFfCX5LUNb+qLP5xMWvMYNvpw2r5/GJTXOcx?=
 =?us-ascii?Q?eRlUM3RcT1oE7kz4YqyEL04zhV/fHfUQGDjihBYImqiD15x8yHhCjqP+ImhV?=
 =?us-ascii?Q?osXkXHgnz9ba4Aoz0xnWCk0dxZN5bRCEpMbVY5t04+X6Ea4IyAJSbEmJ/uTJ?=
 =?us-ascii?Q?JCPM0rZhQ6euuiFlIZAIH8OGFfC3MtTvm6JtV1ZrpPFTdSO3NkPyDlfEvZ7F?=
 =?us-ascii?Q?FKaKWzH3q9BdT+60PujEC7JDEYzR/HQLmNOSNkTFQpK4iNhlyUOta51ugxyF?=
 =?us-ascii?Q?uQ7hWeqgLcnxICRnqfZrfIEYICOfUvG6aurC/wXVMQeF5dkh8MqYsHmF3W+l?=
 =?us-ascii?Q?X9XRE7Pi6dxvcWtY9YvTD7V0baDKzv9SydVMdOCirw6HH0gCcwvVar3RQIIT?=
 =?us-ascii?Q?99SxvOmboZriBBzhlrMbKGr+dHkNOutyrs7EDS48J1mdIdZUK4YoS7iYwcFX?=
 =?us-ascii?Q?7SheoOvsXJahI5jaW6ua/dcAXVmOkkFrqYBUJmf9KyzpFmEOnKviAVlHl7bL?=
 =?us-ascii?Q?AFbN79pqPzmsoIk5FVba9sn+FWBjzF9Bv0JPUJyqoWkDwWkyXVk1qe9Pcl9/?=
 =?us-ascii?Q?cppDGYikuT6bs2SjEmojS4vFE8oRBYLBHPshotVvd/yG1bNufXUary9oVcyG?=
 =?us-ascii?Q?yimx9jajm2y99uDoCPS9gIxq+ZO6Fp5PS/E9mj68/7yHxRiwSN4Ki549p4Yx?=
 =?us-ascii?Q?6CJ2f50tCj+L10J0pdP+CFx3u1a/BGYtzwRufL19w+szQieOPM7HY3VONIYN?=
 =?us-ascii?Q?MhI7rsmZE0TlW/qB4Txwui10Qme0nyZCKRCqfxJiDipzjvjf1v/SxcrwrzIN?=
 =?us-ascii?Q?QhJbbiZh9RI3CHhlwGiiO1Jh46RkrjuRzDOvEdNcuVmj5gv1vf5x5CvLgcgS?=
 =?us-ascii?Q?NOT2E4P0CCAnKq6FRqUfiHjNhgbmY+q5o5KCsSB3OjskXW5gXtJ34BvPLhCj?=
 =?us-ascii?Q?yglc+JNA/l1Pmk+h2Hr+P8Bo9sDA3RnC/FAEkdOTLkxT2URcG6RQvy7m/TWq?=
 =?us-ascii?Q?bCyMoA+ffwZ+kqefynDM4bocImnBodbq4GVUHSd+QoIMuNrZaSaixTcgXz2c?=
 =?us-ascii?Q?NFGOXKj9W3mhg4uTWMK9J64tn9vMm/Fh5LzfN9Yc0JeGgwGAKbgwqIm02F0t?=
 =?us-ascii?Q?RJe7KS0KX2AvsxvPru6bRvx19428JInV2FJfW3XCxafBC+vwTHCideAGNVFt?=
 =?us-ascii?Q?IxHOp28DFUk3dYMBS9G2qQuukHky?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uthDUXcYcKy9a4/pjadTNu0SJDlw5hwjCEqU2aeYDXnJ18EGj24D7kG7vF/1?=
 =?us-ascii?Q?sOnUreEktQRy+iZciDNp5Jfxn6uOLpPmcMk1lPa1p8NfCr9KfdqwGS1KGAYf?=
 =?us-ascii?Q?83QrRinj5l8At4rNaOXFQwat0bi3q+XKYPgupt77jPIbCBS/e+cMyZnqZull?=
 =?us-ascii?Q?nbISk7JsDyLat2+OK5U2KgxS/J7/+V1fv848HOa6qzuzKerRI57e36rT4SDJ?=
 =?us-ascii?Q?AQhbfYRB6la4xAQZ0i+5/a83oFe3eBbtbn/oVC2+xChyji/TFngTm940N05J?=
 =?us-ascii?Q?h/HjGHWrbJeisbygzmnwbk4Pt8ynDdasmIjAXVzBV+Rxm2qbqirR5xO/Z3zl?=
 =?us-ascii?Q?cvYoyvtb7zTP1TPoV0XaPiqbmJwAgcqQcMbrZXQTJGcdP7Vo2YzD5kdj6A1j?=
 =?us-ascii?Q?k5MLrgzNT+7NAa8ZEulnEd+0xxzqEuLM1SN7UXUBkAhMP/b4Yaujvy16PvlW?=
 =?us-ascii?Q?0CyI5zXk106HfeQxFjFrr7ePlI4e7otv/dqTgITnJa/QoIn9yG2FKmVI+kau?=
 =?us-ascii?Q?oq0CriZ3w60jJ5ckh/fSgsbFFWFqA4B5bnb5sd80B3OO+YzG+5uqc9q0tZ1H?=
 =?us-ascii?Q?PUtxa4oD6SeyH+Yp+B2TKt2ONDErS85q1V382GaHiboMLXkelp70/GB0XDpW?=
 =?us-ascii?Q?n4z8ZuEOkHEjf2YSMyjoPJUgKRMpMYchHnLeJWNm1p24nu9/SSq33hX345+C?=
 =?us-ascii?Q?1YTQA+N24xsHcYjrceGX4K2FZLF7uCDM1S/RaP/s3hA3odVjcEH/GNKTQFUx?=
 =?us-ascii?Q?e6x7cTDEkYXfbN30u0QlEzp+eu2ZvoebHcfsltzKtPC44Ew1K0CaYrqybZ4F?=
 =?us-ascii?Q?fuz0Aas4yaiSPG9mLHwNpVowYJXR9NEIxiOIQaFVFK5CqeAy1xpRU80AgCey?=
 =?us-ascii?Q?pbwFIDr31Y7MMHm/fmTZ3j4XjeoJGXvg4eNx029m3HbF1U3sCxGQQETgEh9F?=
 =?us-ascii?Q?yOMDPBn3oTaO7r8Dt2Hw2rTPe14WNdQYiD0i0hNomwrxY3iNllRBxy82XvGK?=
 =?us-ascii?Q?f4wrYkkYfyoP9Pp1MbGrUTpivWK78tJAuZwdIGP9mORo5DGWr6xikVgDxXDU?=
 =?us-ascii?Q?zmp9hw41dHLxS3ntlsl6+asfWbwXVayDWttkGvG9og+kT0/RR812PyCECSIx?=
 =?us-ascii?Q?rvg/3WnUJhu4S1lDItna22hGKNm9YdeiK5hIKGhEr1Goi0wCzgVRj2zQNSgu?=
 =?us-ascii?Q?fqy4fxxttbqiD1YyjZhMhRSqrHVKuU7e/Fgrc2KiJIGfIS/KYQTHtFyvc9nL?=
 =?us-ascii?Q?RLeZ6IPh11as5fJv3QmJOmJIkG/JUQFwWKAZK0lzWJ0zHgezKw/O0wybpjy7?=
 =?us-ascii?Q?6RJ+vKteTGK/7pyyjN6eLQEOGKWGFwfoDVTT9N7u4LJgty/V0VJrZvjpHSqF?=
 =?us-ascii?Q?ihooPmCMSysnXtUwyzwJ8TcJxkOh2C+xD2X3lh3sVULOje/QJ2MqFF4AcXAT?=
 =?us-ascii?Q?VEcWHexbeTa/M9GYh59U4cMSJqEh6WWfHjBDHeb3lMOdzgFXMU/Zjo6BMwLr?=
 =?us-ascii?Q?Uo8O4MAzJmG8IyPKZx9FSQbtCZBRJtSLH6NXzmrA3Bhf3y1gs/ZdyB/XHTrv?=
 =?us-ascii?Q?kK54gkt6cr3zBKkXF6vaez+ShilgKNH1Q34UkvRa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2882b00a-b830-4a76-5fe6-08dd4d2fa2d8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 19:41:54.8288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qeJaAy5wtX2VliysgkpgOSNg5yU1C55kEiC6o8OXawol4VpzfXRqA8+ZYa1wIFHUPxyriBCl8VQlharV3X4p6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809

From: Yury Norov <yury.norov@gmail.com>

Nodemasks now pull linux/numa.h for MAX_NUMNODES and NUMA_NO_NODE
macros. This series makes numa.h depending on nodemasks, so we hit
a circular dependency.

Nodemasks library is highly employed by NUMA code, and it would be
logical to resolve the circular dependency by making NUMA headers
dependent nodemask.h.

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/nodemask.h       |  1 -
 include/linux/nodemask_types.h | 11 ++++++++++-
 include/linux/numa.h           | 10 +---------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 41cf43c4e70f2..f0ac0633366b9 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -94,7 +94,6 @@
 #include <linux/bitmap.h>
 #include <linux/minmax.h>
 #include <linux/nodemask_types.h>
-#include <linux/numa.h>
 #include <linux/random.h>
 
 extern nodemask_t _unused_nodemask_arg_;
diff --git a/include/linux/nodemask_types.h b/include/linux/nodemask_types.h
index 6b28d97ea6ed0..f850a48742f1f 100644
--- a/include/linux/nodemask_types.h
+++ b/include/linux/nodemask_types.h
@@ -3,7 +3,16 @@
 #define __LINUX_NODEMASK_TYPES_H
 
 #include <linux/bitops.h>
-#include <linux/numa.h>
+
+#ifdef CONFIG_NODES_SHIFT
+#define NODES_SHIFT     CONFIG_NODES_SHIFT
+#else
+#define NODES_SHIFT     0
+#endif
+
+#define MAX_NUMNODES    (1 << NODES_SHIFT)
+
+#define	NUMA_NO_NODE	(-1)
 
 typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
 
diff --git a/include/linux/numa.h b/include/linux/numa.h
index 3567e40329ebc..31d8bf8a951a7 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -3,16 +3,8 @@
 #define _LINUX_NUMA_H
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/nodemask.h>
 
-#ifdef CONFIG_NODES_SHIFT
-#define NODES_SHIFT     CONFIG_NODES_SHIFT
-#else
-#define NODES_SHIFT     0
-#endif
-
-#define MAX_NUMNODES    (1 << NODES_SHIFT)
-
-#define	NUMA_NO_NODE	(-1)
 #define	NUMA_NO_MEMBLK	(-1)
 
 static inline bool numa_valid_node(int nid)
-- 
2.48.1


