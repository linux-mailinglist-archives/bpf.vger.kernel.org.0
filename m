Return-Path: <bpf+bounces-44735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9964C9C7163
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 14:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55286B2A1BC
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 13:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501E91FF7C2;
	Wed, 13 Nov 2024 13:42:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021108.outbound.protection.outlook.com [40.107.51.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4471B1EF928;
	Wed, 13 Nov 2024 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.51.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731505329; cv=fail; b=jOOic7VCBFG89xD3m8P1NWE9//NtxWn44WZmS3ztB/FTaBvZnIE3l7VXll90dYsRCxHxiaddd0IqSI+NmExzMpktfRM0osBgn5WAZrX0/lMnxwGuoGFXQDaX8mHi44zFkPSJOpv+TBm93YaFSznAwwro90hp7RY8uVJ9Nz8upUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731505329; c=relaxed/simple;
	bh=ES1ovOuy8vKaxhhsARPgAeMu5iCche0mEQJJlebA9fk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U/UEgm0+igjuFaSSwgp+9cjYOmjZldXm+qOo1UNmS9nUTLvb/3/kpS6d9+EICdz/FshkRgJRMA25tinKW3MhTsgzqm0NtJZEN8+I2x8DGuv4QKdCLgkxQymbgKl0U/N+utznWfkbKPBBZgRpNWa+ZSO4J2K3ItXiZgSktKa4lO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.51.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvI6TcBU7r6oMnlbBUDbvuwGxXHsz87RG0uk4PvkSE3Wg8m8TpZ6XsUPuQYIC9pP9lLMNOJl0vCDeTXsQM0VgSw7mhQgwP5SUlp1YwdF16Kx6wggMUZY7JqGEAfKPQuNJynxcin1mdgIeUzvcH4wZM7dlhRM3+nea6IbuK97RuloizQikC3w8lZugDr4XNTYBz01eeEuFQAr0VMST9OkPH0LutNxzNMfu0s/ZyOG1UdOBb6LEX6NF9QXnSl5x7l2+MYPvHSBXOc/WjC1GGL8KqGw/e3pzqAas+M3VtTTxTwFcVB+YQWqAfWEgITZ8MeSt92hrqQAnnk6WZRkhCTKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNr0FCbfp36m9B1IQbVS86qKWwKysSDc4T3DifzCGCY=;
 b=xhGzALELob1iPSesgYqvx/ViqV/SsYg80AGYxJoE2yfXn0KAf18fYQQ1RGaA9rqlh/hFqL5kiNaYJMN8UaUd719LP+xaw4jYWioFfUgMIksdx0HlFfVJwVe//2lJCU+Bl6tXTIu/trVGKMbpXIDFeUEu/QCu3A+jPixSVgb7mdAQK6n58pXks7tSzDOFSeJGlgk7G6NXaxSHRfBvsZeeU8Cd0IKw5Ol7RB2iXL1lQguK+52kuB73gj4dGIuYOo1+1abOBr1YUsIORkQB69FiPsavH413iAxaiy6HSclMmm46xBPbZodasgD+CmGpF5ZHr5qqimzbRbAAAG6yE48q+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by MAYP287MB3598.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 13:42:03 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%3]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 13:42:02 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: ast@kernel.org,
	vadim.fedorenko@linux.dev,
	list+bpf@vahedi.org
Cc: tarang.raval@siliconsignals.io,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Vineet Gupta <vgupta@kernel.org>,
	bpf@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARC: bpf: Correct conditional check in 'check_jmp_32'
Date: Wed, 13 Nov 2024 19:11:18 +0530
Message-ID: <20241113134142.14970-1-hardevsinh.palaniya@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::25) To PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:204::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0P287MB2843:EE_|MAYP287MB3598:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c96ea63-193d-43d3-319b-08dd03e8f4a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2jfGyk+IuSGdqMzvrZZA5q7Qk63jrhKj8rPJQJ6OsliINzF3rD1s7f51UBnO?=
 =?us-ascii?Q?pGeEXs9YTQkbEZ2I4Mdd5s56trcdDGsSjBIZ+GkJfX0gvDuKOQGoZwUfO1f7?=
 =?us-ascii?Q?VqFxmk7PKfflnMfZhrgbyNoQfccIyvdMjiadpbEgil3pJX+AQaUesHWsZt9n?=
 =?us-ascii?Q?OQlHfisMlAqCstiLg/R3eWsZLySK3HYyjT20+s7/oEPdrE6WA2GO0Eix9n5k?=
 =?us-ascii?Q?Z68xk/sQZzfsYq1agUPChNi1UB523w7l/y4by3D0eoLeGFhUfuSITEK+oyCj?=
 =?us-ascii?Q?7IrfIGBh/ZzGgOvXf7v/fvHbSDWvcaNSzNT6Z4KaoVZ/QEnSnZp36ufAnw1N?=
 =?us-ascii?Q?xZUBDyey1gtydo1UJSpXtT6NfB2VZgppCvAtacfRrs0O35x3R/i/Ejbzu6zM?=
 =?us-ascii?Q?6jXgZ2FznppaW2UCtWD5DZCsUVSq+zLpPK0jgfgZK+RcOJQkqXUzOJQ79hp0?=
 =?us-ascii?Q?/AvuHjFz1/yAAqbuyryN+FkCEQeO2sUakK1ghtRexbK5UkwdhZJnXrDMl5hU?=
 =?us-ascii?Q?QByb1BvwdIJlGL7KfuyA+E/HV40gjRSzay9UvVJk3dC5muaxuDmcjEarFr9q?=
 =?us-ascii?Q?0DeT2yu5i//8cjTfiSiSM+GA3wPjyj6aDijPOlowT+els9OKb9tcxZggbX20?=
 =?us-ascii?Q?RAgGyDUNMt7z2To0hWm1xIWOzhKUmvzzLY6C+Q+IcWs2Q6P5PSksK3kCYWxV?=
 =?us-ascii?Q?ya2caDtfSg5c9vG4Xj5fc3j2QuEvxo6sfwb80tu+y6tnIPfd+MnhzV5n1K5F?=
 =?us-ascii?Q?7dbzPip/BKL62lnZ3AR+lpJEEB5eVgxyh2gej6s9u9T7slcn6a+uc0Z+nEej?=
 =?us-ascii?Q?7FH09V43ZmRFW1sUKp0ZF585mXpjVGUiRqs6i+Cl3ecjUuk4+FLP7SIaUOfF?=
 =?us-ascii?Q?SsvxdymIPfNZFY4QpEttcEaXZ38VKnTTogLxw+bm9bjKXHUj7f6K/0FPEDcc?=
 =?us-ascii?Q?zCtpMYJMeg2FX3/LvHxj+AC330YdmfxW/WJZcMTFWXDTUfFksKDDOcBCbmG3?=
 =?us-ascii?Q?24EEoThfUoefUvjLoUDV7KFEwj6UscNjiyaBhzAYJHS4Dvw9sfoIOY//MuNH?=
 =?us-ascii?Q?6+svGmPs5ypQawvoflObLgwfP2lVuJ46VsbfLGnjggVAy+ex1fn7P3skXUEr?=
 =?us-ascii?Q?28c7jDfgmmxHaUubzNt3D7H6qRaMwmeu0rN02W+uykTGZVTCknfQOchnKnu5?=
 =?us-ascii?Q?iGOenEazyqr0pAIXLLba+PbLvnzENfFVBwHSAIiVmnYs9ZKaic2rUTT7cU7M?=
 =?us-ascii?Q?Wa1IZlioiPMvEs1yBHMhghhn1IOUQOQYtVyAtlRfrP8CbRBgwKt1UL4iJynB?=
 =?us-ascii?Q?u0jBJ2wkAxrxypTujUuRfdS+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qpsSLwGweqg+fQJyHkGy4ttJbZn+AucR9LFP6bPqP1IzxV5au3pZEgU1BRmu?=
 =?us-ascii?Q?KaePQd2OEFyFy+jHwwffKJhEFMPhWZX4YNCRkemuqJHl9dqe1G4vrDtsdEvd?=
 =?us-ascii?Q?4vCsmOKmnsUHWjRMH5hduZciJfazwjxq1P6uk5Z1nXswLdsVe+pSkg6eC+KM?=
 =?us-ascii?Q?t1ocbeVRZ+SKH3NHnUul25W13h7s40wQdCPnVO53HYeKvAzFqDszv1apUgcu?=
 =?us-ascii?Q?3opeZT1yhdvNcTY6ux+UxH9bSBdvc2Dq/+KlZp8uv79dODEq9XLmzAunVcWa?=
 =?us-ascii?Q?iPMZQm0RINAqngOnLeTocYhw4nfeKHwKUnxhdE+hMTC8sdPVGOXzUEmf7KcF?=
 =?us-ascii?Q?5dl1nDChsftH3fEoBq1BsTpta8DAQAZdkPWAAu7tDx8SictyZ8osq2Ni8TMT?=
 =?us-ascii?Q?alalxms2AU7DNlrk9VQunQFEDY6b+VNmykku2Y/oINwR502ZID/4L9oZA5pP?=
 =?us-ascii?Q?zHHphqlU6YPcX7rwBUOp3CZx0ng4KtIYZ8X17yc+My/E3VIirM1EYyG+rLaY?=
 =?us-ascii?Q?BErvUW+EDwVv0LBSx4zYjdUyRsFxYONm3wd/APTUcfEpDF7kCMHWPBhplU2y?=
 =?us-ascii?Q?Hgmi6PpbaT2VDvmKLzIe4suMN+f08qyGIiEWWqhtkLOtF0SjHTvspQl2uxu/?=
 =?us-ascii?Q?3lo4DwC3gfdqO2fJFwJNws+yaujImx0otQc07vpfr2gXuVG8/8ic/XscJDOm?=
 =?us-ascii?Q?C9KZi+qU3lI/HcyKzWNXUpzUhE28qKizpXfdTd89yPWzwH0P1Yri+/Avp3vF?=
 =?us-ascii?Q?x7EuztJLFNhjh+UXTgpzQl7XVNvKC+8F4KU3f1g806jZVgtXFS0iNhstiKfs?=
 =?us-ascii?Q?mbKpaS4eqA/b5haPwC16iFN0GZCvAPacYPJTi/mU2jPE7N7aj7jhUHyJoZqV?=
 =?us-ascii?Q?oYSyKWizd0+v5DNsxmR0VG6tMKviUumMP94DmN6z4lcnctOy5qwSqG03RCw+?=
 =?us-ascii?Q?jfp/6WDrUM6YIV3sRH9I9UCE1hSO6hcf2y206AcvfNXgP2K3RCFvlQ7yRAnB?=
 =?us-ascii?Q?41XLVjYaS9LQ5ZAi8Gsz1QeNPsO5iyGiS6B+JyVp4leMRgZSGf33xUKv2PJh?=
 =?us-ascii?Q?9JNkuDsMvzyP7E3QiVjbKq6LxhZi/5fNAhDDaCNrxF/fEUatpE2+7MXMK9S6?=
 =?us-ascii?Q?9mcfR6I5ViSsN1E7B8LmFG+1A1KjSKprkY2hWQNerB8l/12uZsL8GP5vmWZQ?=
 =?us-ascii?Q?TpfTgx/CfWci/Oy6gVMo4WvvTdS5O1QHlRpa0AbEqMi5b3U37h7hcu0yk8JQ?=
 =?us-ascii?Q?80/6k9nkusXL+xMdklQBU6yYLvrhVeSl0KKLmS/JelvPzswWpMjDyajBJHND?=
 =?us-ascii?Q?CjrbZ4ZCrmazm9AvkmoIIxO+6xsldk3D/K/F3OLEzbSZuScKiGG92cJ2JboU?=
 =?us-ascii?Q?xw5s/mrnma4H0OYmghEdqi7Kck5I+XHnRXR0jhILZYF86i0Yc0UBeNFulMx8?=
 =?us-ascii?Q?mkDefoJIZQwVU6uXqXXFLwuFXfhvwpcsKetZ/EYzW2Ep4HIkSZl2IMp2IUuY?=
 =?us-ascii?Q?f+s/TURNw3EIG2I9F4FwGf6yZxQkoj+HZ1qn8avDwJVEf0TcXRnlAB9ajPUG?=
 =?us-ascii?Q?xSMed2SvtWK6lIAieIDRdbMaRKPjl4y+0GG7lmYl1ZUoAc2uRHtbvht5kquq?=
 =?us-ascii?Q?nWLqHBSA0kW/IeuZwwSbYewKClQPX+G4ccsLNlc4SHH4?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c96ea63-193d-43d3-319b-08dd03e8f4a5
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 13:42:02.9525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlkB5Z9wcRQbWr4tusDAGGGWbhLZFYLTr94B+Gx99UNkwdVggKhgFgMNHQUJCpU+7esKaosLEMElPx/o5239KgDefICIBsv5G8efxSI6A9eRuDyUD0oSmWNKxrOgWCdZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAYP287MB3598

The original code checks 'if (ARC_CC_AL)', which is always true since
ARC_CC_AL is a constant. This makes the check redundant and likely
obscures the intention of verifying whether the jump is conditional.

Updates the code to check cond == ARC_CC_AL instead, reflecting the intent
to differentiate conditional from unconditional jumps.

Suggested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
---

Changelog in V2:

- Changed subject line
- Updated condition check to 'if (cond == ARC_CC_AL)' instead of removing it

Link for v1: https://lore.kernel.org/bpf/e6d27adb-151c-46c1-9668-1cd2b492321b@linux.dev/T/#t
---
 arch/arc/net/bpf_jit_arcv2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/net/bpf_jit_arcv2.c b/arch/arc/net/bpf_jit_arcv2.c
index 4458e409ca0a..6d989b6d88c6 100644
--- a/arch/arc/net/bpf_jit_arcv2.c
+++ b/arch/arc/net/bpf_jit_arcv2.c
@@ -2916,7 +2916,7 @@ bool check_jmp_32(u32 curr_off, u32 targ_off, u8 cond)
 	addendum = (cond == ARC_CC_AL) ? 0 : INSN_len_normal;
 	disp = get_displacement(curr_off + addendum, targ_off);
 
-	if (ARC_CC_AL)
+	if (cond == ARC_CC_AL)
 		return is_valid_far_disp(disp);
 	else
 		return is_valid_near_disp(disp);
-- 
2.43.0


