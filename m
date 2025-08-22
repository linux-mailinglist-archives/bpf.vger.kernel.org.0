Return-Path: <bpf+bounces-66277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52310B31AB7
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 16:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 551E47B2357
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 14:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC3C302CC7;
	Fri, 22 Aug 2025 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JYNz7ovy"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1A62E3B0D;
	Fri, 22 Aug 2025 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871562; cv=fail; b=G85h19Qc8aR8WBocvzPG9CoCtFHjaRCKCNEc0hskxdo9fjvQkh9A3nb1Z2vOfKPPxAgGw/TEgQt4pgPKkuB7Hf2BcIZyGLX9ZHEK7I+FS9o0KYxoTXJ2wY2jVA1ycbY7WdQw++PK0iXlbxeozxqztQOglqE0ENi/o+xTTZurMA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871562; c=relaxed/simple;
	bh=D/48RgtKjrSOqrVvvTSAEtlv29Cro1upvO+MbmTxY0w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tj3R4/KcjEk8fxkM277b3cKj3bJFfjzhoYjw0WKO5pYOJt/zmutM3Py9HLrKlc3XZozDnpJWqCSk1Zf+hZEVQ9BlW23RIjcxCyTTquqCsNLEZK6JDGExylQ9fZoOmv1dYQuKKHnpNySqS0etOHfzWwjB4tG/zAeqJuFio1T7nJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JYNz7ovy; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ls1CN7pC4+wArved8pw/lQc+bCv5eBR6CX2ovFLSnFzA0YLHQraMd5oihGTmCz0SV8NfHgMfnDGZ2nCSbbVhQ936uAXv2lO2IBGhfzlFhE0sLhpU1P1RzaOMTj1dOTAo1e5gR9D1bqg723cSjY2d045AXjL+SBF9PnYK05cWC1OfO+Hzlh+NRO9FGT/bms8pqQtAmleKl/05intvLNq3umJnAH7sAucpYkL5K50MCpNSkwZq7BSDyqcF3irBzGhaTTEF0qb8sV4pqW0fprxk1R5FI7j3Zk22L1sWzKDo4OYq6yd4eGQ2GfbkjwKXojRA/vic+l6yDnuun5FNfRUx/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9UJI/uMMY7jNfqVvyYU1d0CCMjZ+N79ff7Mcf9R7B4=;
 b=GiwAetqygZCYjs3MyjWukIgjDdleuJJQk/xHDnHPtKNkGz7tuklQuZyX4ZxY5B5rmStFqhkGiZGkxZxf3nCHU/uJI8uz+ZLJWRXVC3H8uI2GNdWaGxzGH78tnvvzc7gXIlmBByA+DaJZJq2RHdO1JygROb3WrdbWlAzm7UHG9gTyNxvXJWTJEHGRBqzkhasUaDKiIWilVLRfVXqnVnEtHfpM/8z9U/cYkxPjFEz8helQtisdKo9pCCP+Mul4Atf6rAOxsJ+r7EWfZlUh1w+3AUUApk7jjRGrQgVMmNaT/UNyBi0f5nVF+7NYZC1N93IuXjsXI3x2Ijl9tjKoERB7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9UJI/uMMY7jNfqVvyYU1d0CCMjZ+N79ff7Mcf9R7B4=;
 b=JYNz7ovySCSZbY9RoGiYy8dZi0TYs1kS/Lwfxs5c1H4pd1oH2tktfmYgOUGtFXJgC/owzBY1nRvN+7Kuiw679D+jl3JPhY+3bqLHNs1PuUmyD4UsgEL+0H6Vxffj2UC9kjqhr+42K00XCyBS1H+h+F5mQYkSBFjn8jTyByvVD9WZZJSDxeU4q14G3mMNSePJkqnBG+0u/1YbMf0epFwh/O394gDSTw5pUA6Id0a0Y8NCYIaJgaBcVrD2Xo6lx4RCKj18Tc3pqlN/hr2baeW5sCKqcseK+xslXJ2Mygm3CIkrs6FLXA5O/kDNiNphc5cHiHSBr14LPW3+hmZ/X3JwaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 14:05:57 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 14:05:57 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: Mark kfuncs as __noclone
Date: Fri, 22 Aug 2025 16:05:53 +0200
Message-ID: <20250822140553.46273-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e590e7d-a544-450c-2be8-08dde1850404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XhOgpDg0QZf4h78cM1L+2lUGMxhPzzwbptJDaEgXWvsgUKbELaLhmOGTriUI?=
 =?us-ascii?Q?H8OBqsYUrg3k51UkQC42vjrvWLwkoCdE2hCOkp5j9mM0gIleJUj6JQvoSUzU?=
 =?us-ascii?Q?MSPEaGFmDCe67JJzUhybK+b5ehjCY8e7q/rJ5BZjOtA/Q9zh3mD2t0F21D1+?=
 =?us-ascii?Q?t4nLmxjEKU/FDMi8eFzBUMxI+EiDYh9P8UGJrXWiu76996jF24ofrenz7ede?=
 =?us-ascii?Q?LYF1MtuDt18DSi7PVsvNFwlBhc/dD5YxVSNXbZ1j76erkeSakwIaKu7Psjp5?=
 =?us-ascii?Q?mrLjIyHDfgt8cdemYRrlr1RtCNkrTrV/EZbDy8/OCMzoiPPCs+4zO/gnr++J?=
 =?us-ascii?Q?gmiTWB2gEg4EkihbY6e5ZJf8kuZkyGQKXW/PlVl6a93ldb46l66kf0Q1QNP8?=
 =?us-ascii?Q?Urs10z7B4vyvIkmxsG6EoQIhehcqUy5/tbFQbEr5o0P2Un5Md0fTe11uZuvA?=
 =?us-ascii?Q?rNwCojGWadyYXXws2jl4Dj492NitLtkN8MMX29P30DOwpBfLMqiHOTZoGsOS?=
 =?us-ascii?Q?+SdfOH3OvDtmG+isY3cjDcySGdDbFxBvgxbRPZykMerMKUAbnhU2y2WzJjkD?=
 =?us-ascii?Q?7WGT7bQPNDTjxMOL3+WMYIrKxc85MN5LgSOx9UEdeH92L5dXGPF/htpLCUsq?=
 =?us-ascii?Q?lIrZd56MA+siNSaunOiMf1+5QhBywyPryfGYcn0fraYVF2U3XXusAXedqIKA?=
 =?us-ascii?Q?lPgcXNzFNQNFvZLvLTGdW8Ah3uIEMNAer20cjQydohtTR1Yk6SG75MRKEjyY?=
 =?us-ascii?Q?xQxLR4DR1vjrInNjKG573TFE2B+UiLWtYV8k4KjO/IGmb2ms/+Rg/R5iYqKn?=
 =?us-ascii?Q?xFnS8nOUOox2jn4kgEwFleA4K32JLHa93i/zKvk7PmzqxbQV7+MC646DyMDZ?=
 =?us-ascii?Q?FW/jvzAguV9kWgGI7NKDSwESiaG6wT229SP3fKwOLgNDVv9tnD8REGZtstEW?=
 =?us-ascii?Q?HmkuOSkQM3+//5ToWpmgweySCjEZQKYtn78mBiCOzhg5EvTKUH8UuVLqD6W5?=
 =?us-ascii?Q?veKfIMlsSX7u3UVsyn91PRMJvCyG7t17wg8OakxKAK+jLtGxEfHfoCAdY0wq?=
 =?us-ascii?Q?hYkp86TfRknmrFXxDnE/tp1m7duLe5738csLCFdSEib2ZRJznRQxwU5sbLc6?=
 =?us-ascii?Q?rLV7lhCSscDPZ65ZBd2ajhdJL6RPJPSW3Pg1TtCFzh5cYp/bnqU6KPf1S5wH?=
 =?us-ascii?Q?DaRvhJkze4XR/TO2C+fbAEo0jOBfsItVs5fyCV4N2wO9xTIrMMxcFVfgpPVv?=
 =?us-ascii?Q?AT/YFFlVn6G4CGw77EarMh8jTwcv8dSXcgVyMnEYn1BfRBx6/ljlKhPgV4Ek?=
 =?us-ascii?Q?Wm8s5DVZKAi67ErUjO65IU3ZjPj3taNcmn6lsCC6u1mGLEFf6ic6Rwdp5GBi?=
 =?us-ascii?Q?OciuwAom96Oni4/GBErF6ZI9bj8/uFFN1X3pGqVlzyY4yq9rz4p2Yb74hhL3?=
 =?us-ascii?Q?KG3Ey8h5bcg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OIVyBSoXRWcZETQWqnLGpt9xtPGbK9w6NzOrgcp8l0yCzvdFV7obGTmGpC97?=
 =?us-ascii?Q?M+CED+hFKpkj9oWsOQnxdpofcm2Rat2kl8K7lZREYFbtZfRkmxzuAgnNtFXz?=
 =?us-ascii?Q?nWhoYBlPCUb3j89NcEMA1CFizAkwSmPzs7BFvXmoDBiPhLhcBoi5sYdpLF4O?=
 =?us-ascii?Q?Y2r6jAA9cpRAbG//k0bX1oT/67Z4LpAg4rhg0+GVQ6YoaeCoilnqbyPrtekW?=
 =?us-ascii?Q?22KN6z6PlMufq66YdKyqup1Ggy8ZejXu1gtwzp0pU7zJx2M7fT5NTKptUnUy?=
 =?us-ascii?Q?o/QntZ4JJKo7ziAfALwc7NUszglfCt0IwKZtzXLnGP0l71IutAtZqpivuoiZ?=
 =?us-ascii?Q?jdRewHLE1SyHd7SESeSUADKI3oa71mPmB2pSVMJJZojc1u6Nh+LK+ophyNAb?=
 =?us-ascii?Q?rz2m4xTzVp59yd6ow8ZEUicYPxfbO0989xlfiquwqh4hxchP4SzdDLeKqevZ?=
 =?us-ascii?Q?NhMVuso8LonmqAjYH0IWtrSbBp/MB4KwGX90cskvry2Cp/3DBvblxO8FnL1J?=
 =?us-ascii?Q?ayxBuNuL33OVAs+8dfmQZZZ+8W48lOBGh8Khw3tZA4iQOR7l+cHKjWQ9IKka?=
 =?us-ascii?Q?Ij0f0HJQyL/zk8KQJ8oGU7XISGgUgPHQOQvyEOJyVO8SVmMkq+0eGYSb38D6?=
 =?us-ascii?Q?KEEP1lRq3dcEqK1QXFG9/AlOaowNh57OoMDNS5oEACgPdFiMhzNadvrR00AK?=
 =?us-ascii?Q?RlnodQDJjgI+unYe5DN+pVwdyv5xvjP46tSKzrCwD5mcLCnSL8zv+WOM31bS?=
 =?us-ascii?Q?FY9bS+AfOXKx6Vy8gtD7M6xvV/zbrum02yo7bXDyQhLjZYafz4qJfQvjRNTA?=
 =?us-ascii?Q?vBWyBZTpm7/VwfWSvGIqUZLY26yr8JA/FTQ1bE8YKLMijTC1OOsVWZLZaORm?=
 =?us-ascii?Q?+IOjn+sCm/vj2KjdSvh4hfR6LgdAIBdK5udMtZPZZAGmhAzK/JP6tGK3N8lv?=
 =?us-ascii?Q?tqHgukNNj89hocRdQRm6f+0QTWWPrfkuAuj8VbTzlfa6AWRagZwFlp6AyvVg?=
 =?us-ascii?Q?N1In0v0w19GX6vrw4LK63U9vRwSeD/NQ1Y5An0FpUed+f78lgAdlgE916giN?=
 =?us-ascii?Q?o3GDKH2i7RIxqYFGHCQtqGXjqZEvQRtDhgtQ8quu+o+DvsdxXWyKwanTpgMn?=
 =?us-ascii?Q?11aESeNGQurq6xeJdnELLaW1rFgnom9anDEZEePOOvvMoxTnjnnkQ8XqVpJV?=
 =?us-ascii?Q?XkGwxnukpPsED8Xum5MS+PSs5i3LXnfvUo8SY7AR56W3siZSnx/GJ3ZS2GQy?=
 =?us-ascii?Q?ouWtPaKHeEYeKSm89aVeTPEtCrabmkH2m7sRCDtuc41+tzabFOv8SxOGMC49?=
 =?us-ascii?Q?2+Oti7GvlmD1NqECfNNE2tSExNggRCn/D6qldWYvx4DVrXbXBlRgNag+RfXH?=
 =?us-ascii?Q?zYeP38+005yPPniTPNfDwfK1yyB3KCqMXGUVB5xafQpLKr7BJ+1Si+E3nndp?=
 =?us-ascii?Q?w9GGmZyf6WQKA52ewsZQvbS5viroC907+Fp4Voi9ijPbzi8a8hcqNul1MaP4?=
 =?us-ascii?Q?uQ5gXNe7bvbS6/oErGVy8Fs4XfFnuidAb1qB09JakIgQcbrn8IKcQ+s4EHgt?=
 =?us-ascii?Q?Gmm3toHax9zZpA2UcNRAWcu+gTXm4YxB+8cQKzt2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e590e7d-a544-450c-2be8-08dde1850404
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 14:05:57.2356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzpRQ9n1tPsYbM6dd9/ChCmJz6mGjKrIbBnqRnlBv95bpYDAHhuMK03Wp+UXkdXLgb1c1rTDZctVsV0c5wKcpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597

Some distributions (e.g., CachyOS) support building the kernel with -O3,
but doing so may break kfuncs, resulting in their symbols not being
properly exported.

In fact, with gcc -O3, some kfuncs may be optimized away despite being
annotated as noinline. This happens because gcc can still clone the
function during IPA optimizations, e.g., by duplicating or inlining it
into callers, and then dropping the standalone symbol. This breaks BTF
ID resolution since resolve_btfids relies on the presence of a global
symbol for each kfunc.

Currently, this is not an issue for upstream, because we don't allow
building the kernel with -O3, but it may be safer to address it anyway,
to prevent potential issues in the future if compilers become more
aggressive with optimizations.

Therefore, add __noclone to __bpf_kfunc to ensure kfuncs are never
cloned and remain distinct, globally visible symbols, regardless of
the optimization level.

Fixes: 57e7c169cd6af ("bpf: Add __bpf_kfunc tag for marking kernel functions as kfuncs")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/btf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 9eda6b113f9b4..f06976ffb63f9 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -86,7 +86,7 @@
  * as to avoid issues such as the compiler inlining or eliding either a static
  * kfunc, or a global kfunc in an LTO build.
  */
-#define __bpf_kfunc __used __retain noinline
+#define __bpf_kfunc __used __retain __noclone noinline
 
 #define __bpf_kfunc_start_defs()					       \
 	__diag_push();							       \
-- 
2.50.1


