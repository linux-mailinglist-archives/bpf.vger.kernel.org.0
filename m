Return-Path: <bpf+bounces-69519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14091B98C6C
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 10:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68EFA7A2A2E
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 08:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFB028136C;
	Wed, 24 Sep 2025 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GaEpQuvF"
X-Original-To: bpf@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5200F26FA6C;
	Wed, 24 Sep 2025 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701675; cv=fail; b=TXqbP27NzVhHZ7oEzG7tyd4RrB2eiFn9O0ZwjRt08DrCrioYo5elPxUs8k+cOSMwBQH1pf0dCoeNfemP/KYlLo/T/Zn07JL/cQW+RjqM4GkyGmney/3aKouF8EvJYT7RIt591H+h7KU2B+vrlf1l0xR/A1siJrOFX0yhTtG1r+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701675; c=relaxed/simple;
	bh=USMoleOMbHlCQLNL0C9SRs2R3cmO5Gkf+pXn9uO9dcs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BaEfNx/Ghhf/2rQjjpN1LKEX1VhbclvOgmI7koCYPbhovX4IvuL6pUp7mtgr7RxRm0H3+Jpnbf41Xx2BgNaT+W3LgcPTqOW9aqykCUSLXZW47EjyaxIe4sgAyrHdqxNXD7BAxRiDQAk+TAQMTjOY94JJKBCFnR3vitmJwD5XQWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GaEpQuvF; arc=fail smtp.client-ip=52.101.52.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDuORx5M9MjD2NetOvQjBjWd7l3dAddBOHbUA8mSLQz1/ZKUZH4XTOqC7tuR2/NAh51AzgiyO1sn6v6SzR/PKzWx4eMhxJhy4FDh7AN3TBmak9NXiwwFRfXzpWGI3woUpLiEc0id9UPCCyfHDxWeleIVP75QrRVGNE7MFbK9exiNq8ffAxwJOKJv5uj8sUefvJs/CfhSL/rRij306HNfu7/5c7tv4XXwUdCttVwu6JSp5iwz5IT8Fa64no5h0LwiJ2d61D3MQj2BI6WskkSbC/Du1Lg2DO0NFNV9jAg5AJA46oe6OrgVWD9+r8hqJFiAc181WGkAD2XZbmEss66nJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zczfvNdyLga/298H4MkX3HTc4ajOqZwedE24ABNNCv4=;
 b=MDMcb7SRvFgDC5fA85I3487ZvYBzOCYLUxKcX2zQSFrGiMPuRIsxFoYRW6oz6oUCMG8uVgD8B80dL0xrvZVFMxcURdm4w9RfsCDOf08XZ+0rSUO/b5eFJi3D1jQYNvXp9rH4oj4OUa6lnZbmVadEqAiW5l7pdtdC6HtHbOhYeVU+7cuP2k3IHhpw660+UG15yEcFs7Z5QTuz/1YMASe+KoVW5KQ/GBdOdUxO6BSnvI/tHG1sfeSHTJcaLC6ow1Yd/IlwMu+yUFstUBnQAHNKMJMD3P9enzqNFAg23GFwvIqPWWOvQSJlzUSts2GaiPawleqWOVJCp3dXJOIF6C0Cxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zczfvNdyLga/298H4MkX3HTc4ajOqZwedE24ABNNCv4=;
 b=GaEpQuvFcArZA/zfsCwvtzjizrH2cEBigf+BNkQkjvKM/fe8flyKLIi/pYpzo5u8z1R1sq2XlhIcI49c8z3sVG/KJXjriD9DSfqtxI0K6oNC8ksFab8WFjB5nOlBElXIEPJ9EN8PzRU3pdbdLHg5XghRPFKpSp0x//m2kYNJLy2VPqgnkraxB1TVNVLW0z7Zvx75MEI59RUTCDDjYZFA4qtZCw5fe7iQAF3AZUn9zLNAbQ38WmZrTgOmPxU/vyJ7zQ/dqqlv17G7nfB/914NAVpBssEqp2eFqa3tWNV+2ADM6TTuBA0aJehHOKUupXGauheJMU1cyLcHt4lxzsclHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 08:14:31 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 08:14:31 +0000
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
	Alan Maguire <alan.maguire@oracle.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 bpf-next] bpf: Mark kfuncs as __noclone
Date: Wed, 24 Sep 2025 10:14:26 +0200
Message-ID: <20250924081426.156934-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZRAP278CA0018.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: d5db90f1-eb6a-4aca-2dd4-08ddfb426371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HsrtU0qa53geLr6aZ6a4xYjEH91+JKfLrxVUA2joUMKRa6sFcezMnZ27l78R?=
 =?us-ascii?Q?LGzsQg/McPd7WAQs9eih9xxXblB1fuPOkPRK4KcdLPF+88Pxysa/GjO1SFR9?=
 =?us-ascii?Q?xHZogil+rCwfmYZtndZTvwFoEBnfF9rwcy/ERCubFcehZOLZhZ7jxgFhXJXy?=
 =?us-ascii?Q?/J0+AC/8XUpt87z9CKdiltLmXoXscPDimMEySmLLED8c0GA/tsU7Jm+p/Nnr?=
 =?us-ascii?Q?bDwNXy26KJuIvrMMI0A0bbppBhJZ0mJyQXOrzrLVdXAGo/U3u+zzOCV95ya9?=
 =?us-ascii?Q?p5EGseM2zOFxDfQZ62EECzZe0pFUwxAdpI7QCoQi9sJznnsLuV+oPlj0CJvc?=
 =?us-ascii?Q?EBkn5t3zyGeCt1fp3u3hUOH/mRwiW78xzoOD0b0rzKnhATiq7yqX13QCJ1Og?=
 =?us-ascii?Q?2OhG0mlxdNOUSlBo4MckMJtV+pCRJAe4+wunZDb7ZyT6NrKDf0xBUnX6vyC+?=
 =?us-ascii?Q?ywGbnwrfveaV9/+uyRm4opIOKb7S502N+l/U8l4tfkUkf6ps8YlImF5TpswF?=
 =?us-ascii?Q?p8bxmgHQ6fRJs42Rv0WbnBJ0k2cupmdvXX2e6I8tUTidYD6VBB8bdN5xMCha?=
 =?us-ascii?Q?aSM1egtvjYJZRrRJHktuVw8QHi0hv8Cv+YbgOUQ4rhRjRSiLQFGITzlVb+yC?=
 =?us-ascii?Q?J5lUgMl9jdk9ljPZJrIiqOkMQrO4X9HYOTYG1CJt8KDg47b9cz6CC8gULdKa?=
 =?us-ascii?Q?yoOD2YBiVzIGWvsc3SsQPtCRfISAK+AQzpOQywIaJrfJoWh9n0AEb9iZiguY?=
 =?us-ascii?Q?i3QlRZePwUW6+DV+oiFaM/mxfg+a+0p9fgF/4ZE2tqFeU4KOBg/oFGZQhjfQ?=
 =?us-ascii?Q?HR99vOSePJFHpc63WLyxLTl3GVN7U9M0SWBKN8g51mAdn3X4590S1/AWe7Ak?=
 =?us-ascii?Q?c25PjYEYt7pjUkNmDVDl89SuRJ2EfjmpYqGrOX6G73GQlkNY3iIUlWt2ZW1P?=
 =?us-ascii?Q?nzSTiD9aarw5qtAOQCc5BSHIH+atqREgrI7kWwbQB75ar4pLguDCvZitqzsA?=
 =?us-ascii?Q?MXLc8eO7CyIBmclOMyDNJdzGxlIkwVbdrs+J3UAlvdweNncYZI3xHBmlY+tJ?=
 =?us-ascii?Q?8l7IOi0pLkoSxQ/l04nolsIWf5qh/jHXmxIJxgFouGArn6xV7ADjyliNdToj?=
 =?us-ascii?Q?tbPptcz5h1Z487zHo13uJcS2dTWyqDN6Xcv+0e+TRNNWH8XjNiL1InZXWkOD?=
 =?us-ascii?Q?w0W0Tsb6jw6EaztDocxKgwXImA67g7O0D6FbeShSGw2x9x0decPGZEuh3zok?=
 =?us-ascii?Q?y+hLg+qtHRqyYLP7leGEriDUcs7/y8l9o6BQFtiugpPT3TZVO3OKknuXIYmM?=
 =?us-ascii?Q?z5X4jGRFs8emwnWFxaZR9SN1JoHq4S2vZZcuiY2lUNGiZTMcU0KbHY0L8u+G?=
 =?us-ascii?Q?y2soPlsmJeW1UUAZ2GTxlS4TvKs/h7BRlgw6BsggkeOxA3/4IbhxMCYur1IG?=
 =?us-ascii?Q?WhrT0xsUnh4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pb9PBRsvc6xi7T+F6RCHCmK7ZYUXo9Hr1FHrca8Zu2bf2Jpz+CUXeq3b0DtB?=
 =?us-ascii?Q?izUbK/HtDjsvHq7qgi2wKQUooJkDVuJZWmEnTnuw629vr6hszjiBCpjd8ri6?=
 =?us-ascii?Q?idbpS7Tm+SS2aovVuatf0+RztFlf55lj1JyNs3/RPrN6orqHC69mu9fg2iYZ?=
 =?us-ascii?Q?AIzw3I1d0hnqN4htcjmOq/LYA86ZYVNCa2/JtumBqRXMz3CeZ8eFt6N1f3A/?=
 =?us-ascii?Q?Kd3MYn4us1cioyHhE3+ayFqMnUUOozox36NHBt0N5mJnmPuqDBBgYo8/57n6?=
 =?us-ascii?Q?Djqr7hZ4DaZTE10TdKYDjO1K68Hs8iH2SFdeyKdPLeC1gpUdYl7f0Vfq+oe2?=
 =?us-ascii?Q?dtA+E6GlHRnd0Bt+2XEuv4bMwP2j89ng+JqFDcxVgKaqh6xNANOdeQLQy+2S?=
 =?us-ascii?Q?DO/zvFrkBs0L/EQkxynKKAYBScLnw92bSOhcBv3ylR3DhMsmrm6RZZuyTIkF?=
 =?us-ascii?Q?Zg6dK+X65/ZL7MTAxgzZvNdAodOoEKLEHolBPxPuTjOGDrFrFfqf9cmFvAEN?=
 =?us-ascii?Q?AGkpB6pvGpfOuB9JzzEeMrBHNrHfWjbQAsYKEsCdHXMOKEwmTcjXTZ9STuNT?=
 =?us-ascii?Q?lCDfpHmf1EPVIKJ0maJJj57FfKlyNmkuzo75hfNfz6qRL3ruxVB2dZPyQQwP?=
 =?us-ascii?Q?lDXSd6a4p7qIHoCUdmNax94N5PmjsBg9OLDSLWdMdCsNLRQODWrgMMTw7Pdx?=
 =?us-ascii?Q?adQTVpVWbOCFtxXr4uv4ZaY/Cy9l3lA6qbiFfD1XDOVBhzeqk5rpuqUjetan?=
 =?us-ascii?Q?MAWPhu3bviCoThu1+OpF0g3P9YD+HBDxMiwOFNZ+Gur9nOPiQu3GZEfzCgBS?=
 =?us-ascii?Q?3EtDkIjJW98igidJRr0t6sgAm4K2xBPh5aOzgBG4i3VqhynROPpDnrm/zLcG?=
 =?us-ascii?Q?tVXrwQxDwcCmu73YZySbf1q5ibmgDR/fpD1dC9QvoudgRLqJBMcRm3sJ0kRi?=
 =?us-ascii?Q?KLvdw98tj8vnmWQVWtSS/xNN6aMdxUquMuygq3aZ3Ok5H/rkqQ5MGxXKENNI?=
 =?us-ascii?Q?kc5CMxGIwrOdZCO8paAkTK+iQVSWsDAAAAGhcVx075OsCIUuPHGFSsmj4GFS?=
 =?us-ascii?Q?MitoZtsRl7zjR8HzheL+R8ndpL4pR5MSfC6Ad6ibrPQ+i9qKQb0N6XJUXeO6?=
 =?us-ascii?Q?SZSfbFFtGS3DFquuAlO1GjcBMZhIs0b9myxrzWbjdjb6b6DT6/BDdjqY8hSS?=
 =?us-ascii?Q?SNTwpP3ut3bdqXRnRGghnwutnuftNZAVZxqhVx432/iwr7RvGAbBXYB/j+08?=
 =?us-ascii?Q?VMrH0Lp5ZKQmqeqlb+XP+O8J7c35qmDN2D0u0OEwK7E+3ILX/OV7nDP0DqGc?=
 =?us-ascii?Q?6v5D6gxsV9H0ubiSDOoEGYSXxr9OrCBrn41uICC+EdFOFMStKlgYzskws8hD?=
 =?us-ascii?Q?x4T4msDWL/m758gqTIvNdBL89xa31xoM86WO0x+lDSJ1U64TRuObxhx6KOm/?=
 =?us-ascii?Q?nfYdTAq2Y+jD7cE8/utGLMcHfxwqUhDl4SeTor3sRargzLSv7o2UxGroLG3P?=
 =?us-ascii?Q?CZcCuKYT0pcqHkQY07fB1h+FpxIFdkVvFRgnQvtIkUW5SGx0gsl/idmgiULm?=
 =?us-ascii?Q?vWdPo85/zH0shquZIgZYaNAD5rZ2HTIKM9p8rRk8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5db90f1-eb6a-4aca-2dd4-08ddfb426371
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 08:14:31.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WcxCRxbRV59VlGG8pdOUaQLkqHDWTKMyT8+I9BYwARB+AHN4M6G2Qoop6Q9bECWOx42OYY3dWC4wGd3udJRhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440

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
Acked-by: David Vernet <void@manifault.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
 - Rebase to bpf-next
 - Link to v1: https://lore.kernel.org/all/20250822140553.46273-1-arighi@nvidia.com/

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
2.51.0


