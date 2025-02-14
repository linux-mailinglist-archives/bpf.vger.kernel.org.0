Return-Path: <bpf+bounces-51596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8247FA366AC
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 21:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA4B188E363
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 20:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF371B532F;
	Fri, 14 Feb 2025 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VuNhWa0j"
X-Original-To: bpf@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazolkn19013078.outbound.protection.outlook.com [52.103.51.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFFC191F7A;
	Fri, 14 Feb 2025 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.51.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739563688; cv=fail; b=WFB5md9QrDTiVoyhmQ6t1kerqxOQgXwxtM1iFqdVo2D7U9nzT2JIhahCyqOZbTWayEU3qnzyAYTqQIN9d2rxwwb2XmiSJGw9LToyJoVJGV9BmHomvYLro1WDXZKBPK+dz28hKVkj1Pwzu5e9e9A/YvvP2aRQW4nGT021IsH+tyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739563688; c=relaxed/simple;
	bh=CEzfBBJjfOdj9dDFbZtK1sQabZ12kC9BTApRqdKX89E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RdS38GY/EpnGzo95hxQSGZJ3lalwrDdvNja0ks1pJ3sk/E7qjUqPxlR7Y4BYn9fMnWoHgA74Q0T35961yzE5QdBz/ELXrdFhZe4m/3KlytB/oedFe1rk9ikZsYLkdMm7coyUbsTVaWb5IW7hLdhaJDbHkxDGm0MS92XR4FHxcpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VuNhWa0j; arc=fail smtp.client-ip=52.103.51.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxhzWT+04bGqmo6RSTjpJsWWTGQaO27Ke+Nj3UhH99uSKwFx3a3uKB0NYLJ5ZMcNJJlQaTulsfn/Pk09H9vhuhFGWfJPpmgblpp1UR/zLmXPdxpZO0Az0j2nTQhNMJ90HICTl5YslTeAarctZR8tbLdeFo3Vcw2FS2/OZNJ+b6cKNaeZcckg1zVFTnmaaTx+kVdMQJX07keacEgDzR5O0VSWoGuHI2bq9fd/bioObEMc5H+0UOecceUjSrSKyqkGq1LEZxlrhKfuqFRmz9GqSA2IQaEp5J5Ncn4bzMjPeZbkqFwE5BxRI62/AHRAGLDIPO0mkCESM4XYvKh+71eTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygKTXfvhpPEZsYnFFgPGOwVJ67ZlDYSvKUXNid3XyoI=;
 b=HAOeVtLBdJdf1Sz6U+OLzegZ6XyzlP6W+8TDZsHyS72BcBUo/wn0DU+y9HbgtxhPemc5BlrbwEjk3SZO360AzF3oW1/bfkcp5106UzcWKyAL3zB8W8jHp6Cg4JFnaYM7WYT4FUEeScW3sPKdliIWiRmf4smsnB1ff8pIbGw5V40M3G0ZNR8B2fttEvQu48wi91w2XJ2Q0eyXdQRIQLQTk1jwg7Hf5sYwv0Szpq+3OeLVFqqMvWIYouXx1UAlxNkmcsdHZQJTx+wQLyIRxEl2x4BLz9xCbtAYdS+S1wsXt+OqrctR6ePkzx3v9Lt/BNpCeqr0UvOtazQhF0b0iHGUqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygKTXfvhpPEZsYnFFgPGOwVJ67ZlDYSvKUXNid3XyoI=;
 b=VuNhWa0jirYOWM/dDQLk79EymdtpZroQHFF4qL3sqXmlgmup0Ktddu5xQG+8sI79+OWmi64UQPpSPx3DG3JFTFLLutx1V3mwbtVFXgo9AE1yJvxfSpXOuDAaIRImds1RvX52j+zlzFkZcjDqMoDkGuRl5R568c2bMhXXMASuz0j1oiBLO7RQy3qOmcJgAa52GCM1AbWvHAnsrOfJkoBR85lDQnZbsPYmxYknj4FiNDytYHr+whTZ5tAurxzWVFQmB1WO00ddwwzRcumTGKquZibtSmN8asnaPj5o7zDoomHFjwPJZgs+XFxckS3rVISaZx0sj92z3imvjrYcVWVQzg==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS2PR03MB9931.eurprd03.prod.outlook.com (2603:10a6:20b:643::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 20:08:03 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 20:08:03 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next v2 0/5] bpf, sched_ext: Make kfunc filters support struct_ops context to reduce runtime overhead
Date: Fri, 14 Feb 2025 20:03:50 +0000
Message-ID:
 <AM6PR03MB5080855B90C3FE9B6C4243B099FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0028.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::16)
 To AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250214200350.190185-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS2PR03MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: e4466af2-4293-42f9-16a5-08dd4d3349c5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|8060799006|19110799003|5072599009|15080799006|461199028|3412199025|4302099013|440099028|10035399004|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ywhd93bAP286qdDbWb6E3B8h7Npmp2gjypjB1AoEIjwQGApJGqs8FUNI3DxK?=
 =?us-ascii?Q?ufsAsT6jeGO9S045nbpFsbX1Pj+eHkibSUGeOOUYP34mxpoPDPGVKp77cJWn?=
 =?us-ascii?Q?+ovUFSaLfPdfdloPDYc+7xt/KOxe2ajPEgSAca+Kd/vjnNkuyJmZTEws3Roj?=
 =?us-ascii?Q?BUPC5HB3EAbBLdHJXTbS+yuxePsikMPKYe0vkhqwSfFr/mE1VkaX7ujAgtKh?=
 =?us-ascii?Q?sHFFDJRESQRNNp8Ucqp9pyXKl+UaOAgjjEENP7I+c1V9Ms0gTDDgQaWuAjxb?=
 =?us-ascii?Q?LzszWJhr7tfZmadeYLHy/byHlTtGTvFy+ZM7wfmwpgq7ixCmEt7ioFlkuif6?=
 =?us-ascii?Q?lok3g6yQccUcC9qz5SFl9EyXGSNgcH2dosL7Euges73izGOVn8m9WCgIS49W?=
 =?us-ascii?Q?xUXLoBNc4qq+YHwv08/WzmclPYthCylt40PmQDtcWU9xQlkpaVPmK62Cyg5f?=
 =?us-ascii?Q?dMiAVY/IhA0Wz3FKvUP7rhDBeWOfVCsmgbS7OhhMlG8hEWtHDa2brASnvv4r?=
 =?us-ascii?Q?hPaRK2HVa/w8mvWx/tZZG1Z9zccV+9kx+0vk38CmL8EZMdtlFjNWrp6OJYdb?=
 =?us-ascii?Q?Uz6T/NygYH4KUhUcCGjtSQs9bV6rVdh1y0SO1eYT18MmYE9RE4ubsYZx+3Et?=
 =?us-ascii?Q?rJwNPUEqHd3mOuwo/HMqBC+x34DP65A7WMKenTfu5syzoadzE5EZX61fiFkE?=
 =?us-ascii?Q?NF4UpwTluulGW+wxjRACqsFK1dlTodXPNgalakDtGLmAgVEm1RdjpHu+3Q/E?=
 =?us-ascii?Q?sRVQ7JINgnAM1/irfV9Gw+G9b1y//Uyv7ZMx21RG7jXQT4cEV9MGGuCM0PqT?=
 =?us-ascii?Q?irDiUEl2Y3h8vtlbF0RpJtYjazQgRej1M7PUeSjmRugZ9r237A+QDaIWIyOS?=
 =?us-ascii?Q?y81L9Zgtu3zXv1BqgK7tuw9xg+ad340mRfLMtiRLZXYq5Wjik8UJFFGzNQ57?=
 =?us-ascii?Q?RDXah/4GgicvqkBvG/IJW5yBMTJwP5WiGs1xJt2slBG1b9NzJdVTGx3QOWsq?=
 =?us-ascii?Q?hRuaVqiGiQyPyY98soKlhnjQkwP+/Hg8kP23IP1D2h50qyWH2pHe07nC5TDi?=
 =?us-ascii?Q?Qv+Xd9FQa7ocl1FeuaizHy5hXOz7MPEgK0Ea4y8v0oi/RD2eoiyIdwya5FYJ?=
 =?us-ascii?Q?7A9bT3Kl+gpaugWPDBHRtWtk2PVdOxhK30F+c7sDzi1ky0FPhi1gtd5gkBrz?=
 =?us-ascii?Q?xbq+tC2bnVREpdiQ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V0hPtVPHxvjJCi6iWaRjjNVCjP1Op+hz+XCeXosf6ilnXq1r8ser6HG9leM0?=
 =?us-ascii?Q?kRfpdmczK0CKqfEYrSFNa2dGkcg4Zs8xaEHZwHi/KPP2YhQ0OmYfOMnCvuBX?=
 =?us-ascii?Q?6jO0rqpqIRyOuy4TZ2hVG5X/NfzNTxXYBFTZwIsXLLXdFgo04OZ2oF9CzEBF?=
 =?us-ascii?Q?b2eq0kj8r03AXdMMoS2gcl9zA6j7GxxaB8/Vd8i1SpjHAtdf1XeXVll9izYy?=
 =?us-ascii?Q?gO9jz+EOFA2aWT/Kspue6g4lz+uy74+lSkSo2r5KAIRIhjowBsOJWHsaKeG+?=
 =?us-ascii?Q?Fg5BvxWubtBp3ztFhQP18SI5B99sgVTbLSAWv19YZvipElSv8xhnm8dTVtIm?=
 =?us-ascii?Q?1T9htLwvo4SClT1/aVy4i48/b3VPGjZJW3op8kjO8T77IPgpMDJj44YrVlcq?=
 =?us-ascii?Q?fF0c1rot9qpkeQxcTakOxB0zmgkpmd9vAR5BK16wwNRpfROWw4NFYCJ27Rh2?=
 =?us-ascii?Q?xdc5Ftz6O0nUZYkSCMhUZkg1Le/zQCZ0GxG8CG7NgPr0vEdlQmQUMQIgjbEn?=
 =?us-ascii?Q?ulB9WLWDGD6IxbAftvdzqMJtbYAB+nRQvHBwT2G6718yJwIJeFo8YIJeho55?=
 =?us-ascii?Q?vGbO0tCea3u4AW5WqxS0wBww098YWip74P/PRDeJ+4G77BiSbANhLMIK+qsk?=
 =?us-ascii?Q?v8auixp7XCIbpfRqMn24OnMPhyHTP2sYd+Bp8d6aAbQ1nN32PLZzAfRinN95?=
 =?us-ascii?Q?9P/P9jbnytOs/XSfZuxhUhyexdUEnON4Z/8P1Q28NppORHHdDvUikzsyhonp?=
 =?us-ascii?Q?Xq3bSHm7+UUIK7sUSf0Gy3nGFeQl5T6Uby6mZXx3J3GII52/kh73e3YmhOLw?=
 =?us-ascii?Q?2GUcMeZ8rKBxL/XOuBej4rZAks9xro6ZeOU6hqvUTsd22IPWR8oWDpo2o1l2?=
 =?us-ascii?Q?RdGfkOzQombl9aIwfL6j+QoXqGzSZPy07wWOOmOVItbUc4HDanZmOsoiWy9h?=
 =?us-ascii?Q?tXQB5rGl6oY0XC04LLd/F5ZJAckJvxFLwP1LwI8M/3ekb/ygBVKvHrFoczNw?=
 =?us-ascii?Q?YlMXMGOjAoubHilX9cyFZUg0VW3/VnMxnMzRz+ZqGHDEUPuiw5/d58K7pzqO?=
 =?us-ascii?Q?eqW1STFnK7o+0Q8mVS5OmfXizzyd1FnlYEnHB5JCbQvmUPNB9O/seJSTb21H?=
 =?us-ascii?Q?QZBoVfcn7iCU1FQFM+X0FX9k9NwowsXqZxEivnRasHuI+nIPJ1TNwI4Eenep?=
 =?us-ascii?Q?QqX4RTCeZbLLxAOU5KEyQL8wpdkgY0mpdNOPalIaN4Va6UpbiCxJLbn6jUML?=
 =?us-ascii?Q?RfFRKkaUcXnX2AyKouTp?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4466af2-4293-42f9-16a5-08dd4d3349c5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 20:08:03.6683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9931

This patch series makes kfunc filters support the use of struct_ops
context information to reduce SCX runtime overhead.

After improving kfunc filters, SCX no longer needs the mask-based
runtime kfuncs call restriction, so this patch removes the mask-based
runtime restriction and updates the corresponding test case.

I added *st_ops as part of the context information to avoid kfuncs being
incorrectly blocked when used in non-SCX scenarios where the member
offsets would have a different meaning (not sure if this is necessary).

This patch series version uses a completely new design in filtering.

Use scx_ops_context_flags to declare context-sensitive SCX kfuncs that
can be used by each SCX operation, no longer need to compare moff
in filters.

Use scx_kfunc_ids_ops_context to implement unified filtering context-
sensitive SCX kfuncs, using different kfunc id sets for grouping
purposes and filtering purposes, no longer need to add multiple filters.

This is still an RFC patch series.

If I got something wrong please let me know.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
v1 -> v2:
* Use completely new design in filtering

* v1 link: https://lore.kernel.org/bpf/AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com/T/#t

Juntong Deng (5):
  bpf: Add struct_ops context information to struct bpf_prog_aux
  sched_ext: Declare context-sensitive kfunc groups that can be used by
    different SCX operations
  sched_ext: Add scx_kfunc_ids_ops_context for unified filtering of
    context-sensitive SCX kfuncs
  sched_ext: Removed mask-based runtime restrictions on calling kfuncs
    in different contexts
  selftests/sched_ext: Update enq_select_cpu_fails to adapt to
    struct_ops context filter

 include/linux/bpf.h                           |   2 +
 include/linux/sched/ext.h                     |  24 --
 kernel/bpf/verifier.c                         |   8 +-
 kernel/sched/ext.c                            | 395 ++++++++----------
 .../sched_ext/enq_select_cpu_fails.c          |  35 +-
 5 files changed, 190 insertions(+), 274 deletions(-)

-- 
2.39.5


