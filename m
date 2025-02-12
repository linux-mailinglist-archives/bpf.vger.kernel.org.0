Return-Path: <bpf+bounces-51275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1F2A32C75
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 17:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311E016A0EC
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 16:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8799B259487;
	Wed, 12 Feb 2025 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A1jR92+U"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD93253B6A;
	Wed, 12 Feb 2025 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379039; cv=fail; b=Wgso3d1CBCEMd+g2bRlUIHUWXteD6K4x+EnHkB9Sr7XUY3f65eeqnCjnmCSe8gMLfiSqkcOFUdyeEdBTREt/0mt4tyP+1igNj+fh6uJrTTVVGs9U3dtiiNTGl1fG+oJj48VsgbtRx46Ilt1kbrQiGLTF2TZWPloWcgT/rOhv+FY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379039; c=relaxed/simple;
	bh=dyDyiMQXFIj5EbUVz9ij2LkLVTxCRUe35svA/ogza1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eeuantySKcJ0yZaX+0NzSOesKirJnr5EbVuqn9Rz551dukErN47M3zo/Q6AxV3KIfbjmswBYqy06E1dKb7qQyNVJCavsTV5TfxgO4yEOrMJVFaFeirSTRxEvHEqjRmMyvHhcSroynhFMexwD1s3IZH6hhV68PEx66zTV+chQxGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A1jR92+U; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcdxpCcpPzPxVzlydC/u/ZZW93So0+suA0iMQN4hyKdBjr9jDEEryPlKv9qDUV3GudjR8V5aYsyS6FYImC3nU3Ow8VtgDsTVY8FsFf+WQ3BVxP3J/PXVqp5/cbrg9BSsnFBA+KhElmpAhUv1lTHa2PtyfNEIskYaOjvSzMfWHtDdkhtcjD4XmTITsSL+8h+6XbpPXcts4niNc/mN4RllRqTuzTEC6xP9IkwiNdB/GKdF3TvSzxVZbwhO1Lz6Tws57pR/CvXllbkd+0BtwxFtao3RLYxSvpLRWd2T2IF1frtGHEu7DlMGGmz/t+St8IB9NCErn+GriO723KLmZXv8sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdRq1ZNStZ53CKJE4oMS4LiLwzVHfnD5bbTdVzuxw3Q=;
 b=xlYbL5psfu89x1SOw9E6b6QeSqzjO3w/LYkdbR3knXOYvweCl5CV6vGQO/lhZI4lvi5iA2+CgtJlQu+n/6mxdS8g9owDlNsaoBLtTYCYqdBXoMjJFJDEOWzGj0iMgYvRHs0GZf8a7IIu0ulzjwTAh+T7QRR4GF8cq7paQKX/urqATERhoctSUp2APOQxf0LGqZFCb2Cp6Hc1Ko5cgAGst4JVGbG6puwO7uMGd/02jTpSNg8Mss/wken7HeNJuJVSrL2PIAjpABe8+Al3WjQxWRriLTT1Rcgi4mBqjqBpQHUukAkJIpnM1vVSW+uukFdaCwMvA2CQ2Orb2ayrQczTPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdRq1ZNStZ53CKJE4oMS4LiLwzVHfnD5bbTdVzuxw3Q=;
 b=A1jR92+UNioFlElIcYhsN1A93H22JLMbkG2Z6ocOr3D0K99OaKY19FnVV3Z1TZCwL3YWJLuWyDQukmjysJYi7tsY44Iw4gx6BQj0NjXDZM+9sg371YUhkGM3n9jtHmCZzfmDvQjH7d1kn5tIthR0GmGVJ/MceWEaEgDFJdpRYv5l+a1zUQAyS/nB4PxAJJtYYaeeHDIHEv8vlKnSX9ncrNcUd4cDHAP8BHvfxnEIy2My+T+QmaGfV0TveOT5A0jxQv1jwSJ8F2vygPwHCHF9F37ndesozoJGOy96uM+nuPzUY/ZKw86qjN10FHNnCmYSla9Gsh0hqqWFsVuErsxxXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 16:50:33 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 16:50:32 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ingo Molnar <mingo@redhat.com>,
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
	linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 1/7] nodemask: numa: reorganize inclusion path
Date: Wed, 12 Feb 2025 17:48:08 +0100
Message-ID: <20250212165006.490130-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212165006.490130-1-arighi@nvidia.com>
References: <20250212165006.490130-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 500063d7-1ce2-4cdb-2453-08dd4b855d5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?55YOhRWUvKJdrql5q8YYKxHQM6uwisfTAJd2jXGTMse/kLXUSjTr/T5Tk8yo?=
 =?us-ascii?Q?mdsgjtQxQ7ITB4RqOhHUAH21OaHqpOI/d1we153qI7eBeuB3Ui3Oheo53Bob?=
 =?us-ascii?Q?b9HwppzudB6R2qV/9/9kDV2f/hnZgMHeSuZEBx8i/8rwZPNi26z77YkQsWIi?=
 =?us-ascii?Q?1L7XOghulAeMvjpa9qfDIsY/YmUlVBkUSjBf1N+Jy48aPegt9J9EO7iAhMF+?=
 =?us-ascii?Q?IIHb8HdpV4rFm/yOfS5NdtDwzkJwe7N54TXSQm/U+n322X9YxBaVu2GGRJ+B?=
 =?us-ascii?Q?rEUJiONqRXKnSGWummBvnnTPoVbvmPawLd+BoibqUHp5d+gwUuU64hAeGQOE?=
 =?us-ascii?Q?QC2sBtxhOKBHu8bOFFzrzz7cRB0kkdad8FLki2e5k+EUJg/wIt9OuWbUSOaq?=
 =?us-ascii?Q?/MH0v9zMwx9V/0iCqx24bRmxBQ2B2zNPfqH4BAdCBEFiuYt6pm5KaR1Oy6g1?=
 =?us-ascii?Q?6MRV951i9I0yGYOHoyrh8TtGlPd0lVlutdDDTNUHYstQzPE8Up84AlZosbIQ?=
 =?us-ascii?Q?gawCSRUUISIdYiJjJr0BGf42LUJtTpM2mpy/gKXsY6kiR7ViWuHVmhv9hTL7?=
 =?us-ascii?Q?Ld+vbXtzWaprOjXD54lFbHkF5Gi3SAaA27dh5khdnw0IHa1hTFeYwYxNZ2Vk?=
 =?us-ascii?Q?xSYjYe3rZuqhISmSNav6sGP+EIaE0Axphoy6GFEVsq+mj63VVyBEeZ6KyfBw?=
 =?us-ascii?Q?VFUsQjgoggV6nzF8N4M6Sufld93MhBsJEgynEFzuwNf+cq1z8AGKG/8LS80i?=
 =?us-ascii?Q?DhqDEBSEf4Y4CBNsPgBhiKFoMhCtOGMMEGu0vfow31JJeGSyypgL130R7ji+?=
 =?us-ascii?Q?wno5FV6fcblGu1WXwuyw7FzG7cvn+2P3CWFDlUBkRFjUYi+N+Ubz6xqRKzdg?=
 =?us-ascii?Q?N+5uRk4ZZs6WPdrvOXh7kNtWtTq/jXs8cWG9VgJnbm9BrJza/WXjl94gwkFt?=
 =?us-ascii?Q?lhj4wqP6Nx3305IQDlfneTa5WCG9O/JRgc09wX3aT1JPEocT9pp41wI+zVgh?=
 =?us-ascii?Q?9FTxr8XUiml/A0X19TvgcqQ1R/UW78EaoIUlYon3dp3kUnbtr1gCxysqLhCI?=
 =?us-ascii?Q?hJYMTHB+qANfQdmPefBjjnhTrXluBg5SKXh/LfCOWXoWgwBBA3S2U3lgNRKt?=
 =?us-ascii?Q?bOOSoYCTI7N3YDpbSHg6vE8zy+2MEJ/e34XiUv97e04OEFtkXQd7k7AnUELx?=
 =?us-ascii?Q?sRsNMW1Y+xz/feSxwxSUcUxQ89J6fRS8ILoplyGR38O5Gj4Ty20ary/yhZlt?=
 =?us-ascii?Q?sCfk4JLnaSl+5leAKSiDTPkQ9fnpfZ8MrkcryN1NHe7s6MErSXpji/Md1vf1?=
 =?us-ascii?Q?gE421XfCMv/y35kexOXUGjhXf0w6ZHlVcZXSgk+w6DBdvlN5eT8KxNEifJZv?=
 =?us-ascii?Q?9bZFHAypdG/fZ01Q5n6gncv427oM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M+dYGxJwXD7Iy1xc966KelUzrIQx9sbIO4iQAITvHGnIaFrlcz1GxZF0MRTf?=
 =?us-ascii?Q?Rb4tLhducrOLtG9YtcimuJBYFDTJgD0xHC8QTShxeG+G51D5ARW0V3z1FiI8?=
 =?us-ascii?Q?N3ZZDFE+T7m+wWzkKg0pZHZ89mBcKXHslX7BUN9BxWNGuibss3SY8S1B5bC8?=
 =?us-ascii?Q?Zw/3epsUrzODPDz0h5D6U8LPzfd4zOzxw7It9Lw7LBEcSj0Hfw/Em1p8ep+8?=
 =?us-ascii?Q?DmqeJxgj8haqBBsC1mYjWd9bvJQEcBrFsVBSPxjZEA6cb0vTx1VtBpyt5RP+?=
 =?us-ascii?Q?gJouBAqOsgztC4+LqhhmtzsHUVkugmmIPEGA4PnMXfB/4fiU000nL+6XEgSF?=
 =?us-ascii?Q?eG8bAAlESkcclqpUsSS1I9dcJ+xxRgXOg+x6abqQp9oJxkU8xymqHo3+tuii?=
 =?us-ascii?Q?B4hyRL1SykeNn8KkJWEDn46dCP+0dFrafyZZhpalRnvmd5pwSOGQ8vtz4OGT?=
 =?us-ascii?Q?zhbDli70NjCEd5yIpHoYPYiB+Ve1a5wNU7kPwKF0awfmr2BPasb+hZ7ds67c?=
 =?us-ascii?Q?e0rVIWr/F/IUwpvDQKhdLHffM5EG383fuxHfQ1Ynm69az536Je3wIkgLGk1l?=
 =?us-ascii?Q?DRcSkw1ivfrnR8QkNM9tqj8rWwWk8O701mVMXUBKSDs8IkM5TMM62iBWcm/Q?=
 =?us-ascii?Q?ozCWlk/NkfTIx+eyOcJ1BAckjCet79T+xZ+pmO4q3dRljMUvMza56OxzKvXK?=
 =?us-ascii?Q?1QY6plSLDcDzZFFjX1MKOmWtthnp69C98l/h/19q7/7oQkHkXQCfHVD5wP89?=
 =?us-ascii?Q?hykhIgPFa2s4uhKn99s+MfvkSrHghm6rxAbhYDPt8YryuuCEPz2vdc9V7Tev?=
 =?us-ascii?Q?Iz8Tm+pEw25WMUzes2TQTzvFwKxjzjtO+Pqr66WI2Ga/fDyzwp2bSrdzhofJ?=
 =?us-ascii?Q?nqysysYKzycROw8YNJRyUKCvGqJfwIEUPBQ4rJxMVXsfFG98UdhWhft1f8dF?=
 =?us-ascii?Q?Qkx5SSXMCl3mtQpa5sbIPE6Z/OyiGvCsvmF9x0fsxNacyuEX0dcZ1cw+/ZZl?=
 =?us-ascii?Q?M/q947feUXo6PyjPZOJj9yckqMLj9gzMb4Dpw3dnr4LWR/lLnfJxYr6zVS8q?=
 =?us-ascii?Q?JtUmSyTzfx8OnV5CZwThXLtCJM67jdnqe+uYG7ZRn0OSN30/mLgSrMrrlCSt?=
 =?us-ascii?Q?JczHSVzU8kMGi3KtyxRP+njQnn9+z2dFMnT2RpaY79JbX4BGhh1zl1dqVWj9?=
 =?us-ascii?Q?4wnvBJPQvOVpwsffZ2/32AEk31zENSKCNe4tUPj5JhBg1hukj+Pi8UtlG2Xc?=
 =?us-ascii?Q?hcLIMOseNjPewmAapJ9lNCkywkA1W/y0HR0hG5R2W6+oWHveVhSN6XsNCAOL?=
 =?us-ascii?Q?/uQKH9+Ehfr/RBU1XD52RXEUau7GBsmW+ni8yFWCzzghm0KtYj0/JY9ci5A5?=
 =?us-ascii?Q?hhgMhAXi0qxDDnc3jdDD5nXHV+s/oD35zHp92PNkb3EQ/PTr7LTchiegSls8?=
 =?us-ascii?Q?RMWiT/nWM3ChI2ZtAwNORVERC0OrZEDP3276r9/hCb14rd0tEDhTw72B4ir2?=
 =?us-ascii?Q?ba4Pn544psn+fGQqiPhhAYRIbKTHFq4BP28Yp4yIiG3QrRzEHwW5icNJzOYO?=
 =?us-ascii?Q?B16YoT9UO348hcY2VktWnHuCvzFCaBKFH5hW+dG2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500063d7-1ce2-4cdb-2453-08dd4b855d5f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:50:32.6623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBQ8IPyaCiSveLB2xxgDAvWISfD933GD+ktsEHGs4dSqhpvKn3aqpeg3AIP0UOnczhKnStI6XWwA7KvV4ucJlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177

From: Yury Norov <yury.norov@gmail.com>

Nodemasks now pull linux/numa.h for MAX_NUMNODES and NUMA_NO_NODE
macros. This series makes numa.h depending on nodemasks, so we hit
a circular dependency.

Nodemasks library is highly employed by NUMA code, and it would be
logical to resolve the circular dependency by making NUMA headers
dependent nodemask.h.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/nodemask.h       |  1 -
 include/linux/nodemask_types.h | 11 ++++++++++-
 include/linux/numa.h           | 10 +---------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 9fd7a0ce9c1a7..27644a6edc6ee 100644
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


