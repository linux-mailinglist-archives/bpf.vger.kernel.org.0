Return-Path: <bpf+bounces-52687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C730A46AF5
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 20:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CC816E8B0
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 19:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FF822540A;
	Wed, 26 Feb 2025 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aTYn7R6q"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2059.outbound.protection.outlook.com [40.92.89.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDDA239584;
	Wed, 26 Feb 2025 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598012; cv=fail; b=agEqTlpxX7J3mAaNgPcvDhipZpm/gSdCrk/gbyvXdw+oj0TZcy8Q6/B/jizPx3PkQX0X+t+0jI7ohZxbpoE60wYMx6wkCig6s+dAJqFycXhaQcC1VmiwT1wE9h2pAByhfpZoyPzkDG/9PDTznalN+74VYsSU5N/EdiRFm3dI1hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598012; c=relaxed/simple;
	bh=Af9KTY2bExxs4GsOcM16opUp7zlHZT0TBATRehA06S4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uGDG6FX14KXwvJDqk7WRWS1z2Md29N4nUbQ40ChkxVSrmVf/fwYfMAng+S3979IWojFApM+/eCdYa7c6Gm1JFfLJlRrCFjnTLjbDX0FN5YU7sGAoxOKMXerVh1EulMXjO8bVgmsfXB+/Tuv1YhAjk9FgYIdhLhYJSGbqFRiWP9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aTYn7R6q; arc=fail smtp.client-ip=40.92.89.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMOX+VFyGFYsIxmEW15mTe9UO4gMQQMfZaELRnWCsByVFxTNskbt1OX3bDiF73RhXyawoiazDk9Wk2n7RUWPtQZZJ01lvPMq03MiTehspCembHSYOXiBrhHT2dfQeF/8uihYx8m0vgOAdmrtPYTbum1Wc4JZpuG8P+W9e0B4YymsZYwG+sO+bYTZws+kjEiBLqBUJEt5jXbfpk6UvC2vMR3XyiEAX7I9Q+S4tv/91YIGJQtgqpwhn0VZjIEooRJCdxM4haLTKuEWiYengoqtp1vM2Q0U5pRN6gu7uppKbwm6w0arJZSuDrF5wtNJ2QcqsW+a5KXZ4Q1j7nc50oJ4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C28T4Wv1JyXpYIkC39fL5mg3ytRJMXEGoQd7uVrioBw=;
 b=GycJ3YLq+JjTQ0YblrPC848DRNpqgjeTokU4CyOIQQa1PQ/H0uz9TDKYDc696mNntFcC5kr6lQNz7fisv9xZYH3qTAjSKNHgFNUQcK8omRzj9418vQwm7Onf2xWtj0boqZlECiZZBOGLL26RKHZZEKDsn6+hnQvOXaFIi2D6Hs5+KXKK4ML2Zgbz/grsiQHQp3QzeMd6jBdwDjLyROmMVR46IniU2bMNWe0i1F9cJCHnWntYS4UhIDJgwuceFfBdNMsO2H/OF1lrgcxGy2eS2OHOXYIsPQygPw9V2gq9r5IbIESbZ8oacrxd7k3/TNsonWZwEkLa6bNBWDLHaUen+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C28T4Wv1JyXpYIkC39fL5mg3ytRJMXEGoQd7uVrioBw=;
 b=aTYn7R6qoBT2cDxZa7q1ez8CgLCPE5XhhAYWXPH+3Y5ch0CApn01jnARZXDZ3O4cq1952g5p55bAUpf9sjv3IR3Ycg1AUuqj1OAmyhuSMwk4JdsVoHeOZy8kbB+sxWonHeAZE8YvFxSFLSF1lO4UrQMQrAWgLg17ILs7Go5R9X7WImbHa4JlVSe3odJnSMZ9JB9F3YVmAyWs+aS9VahKp+gbfykErchCk9a9m4ANp9reuKQuTGZxn/EVWzVA69O8cwFLq9RVWr+4z10vBBAH5A9B7+qqgwMWr4h9UAfgacv7noVVGJYfDlr2VZtgEGOmyiv9MluFaiN9OnHQZjEVhQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS8PR03MB8858.eurprd03.prod.outlook.com (2603:10a6:20b:536::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 19:26:48 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 19:26:47 +0000
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
Subject: [PATCH sched_ext/for-6.15 v3 0/5] bpf, sched_ext: Make kfunc filters support struct_ops context to reduce runtime overhead
Date: Wed, 26 Feb 2025 19:24:44 +0000
Message-ID:
 <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::36) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250226192444.156274-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS8PR03MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: d0791d99-c7be-4a37-0288-08dd569b8323
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|15080799006|19110799003|5062599005|5072599009|1602099012|440099028|4302099013|3412199025|10035399004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5awweJ53a6DAfij8e/h/Q8P1SQ2SVB49I6wQGOLej5Qg4PqaqG6Un8qBZp20?=
 =?us-ascii?Q?+sNutNucUwVF1Zr5XHWmuLN7fJaP/tDkfsL+zRuBug3WgZS0nDPEEeGZ0hBl?=
 =?us-ascii?Q?xvTzp3p4M56tjd6AogVMM6t2U/dAxJlJEkxtorXYgNnmXTMB2h/pZALkGQl/?=
 =?us-ascii?Q?L2XDHvdFv+1C8ImWDdhci2OPgk7vuIr9tAkB6Xym/qp6momqCLXmptMqEtsH?=
 =?us-ascii?Q?YqS+2iPXDK0sivmGhjUex0YdOQF/F2oXQimcyFszlmyD8d6FAncAf/lNooBW?=
 =?us-ascii?Q?occNATpU3UHO9Waya2xP5au7pG/O4QrV1U64gaXR3M7722TD44+1HjCVZbMB?=
 =?us-ascii?Q?lhz3yaz5s3u9GVhsJIHlEPR7pIJSTpf53AxbA8MwxojTqWjmU8z1o2aoZku0?=
 =?us-ascii?Q?d6tSmi6qjPgVENLlHeaqj0nfBW/HrfhENWDIwR9/nLZU0RYzZDM3Of6fjYDw?=
 =?us-ascii?Q?THaFrmv8gcufQOm4OKVkqVTJ7mDboddd3s8g3iRRizIOhmbYeVOeTRzFe7Jv?=
 =?us-ascii?Q?UIgiQ5LX2yF3XsGw9Amqa5R6s4lHrpNisTLhJm11j7ZpAJkhwFK9+rB1exwT?=
 =?us-ascii?Q?wAt6tb37Lz2uoM8y1MIesfpAL6p3dADkWppZRuC6oHHQ8HYqf8UGlT+41SlY?=
 =?us-ascii?Q?nd+dj0w/eTU5meYhGuRRrmx22QQgqCZXlw9bN73c88/DBD5mAf//Qn2a9ABS?=
 =?us-ascii?Q?7+pgFBzfcSciPnX9Wjy3kK+anGK+eZQjSgsNn94fAvh+RnnphOw8A5m+2kYc?=
 =?us-ascii?Q?Eb0HgrWP3tBvbV8yydnXHaZ9vQu4H4fj8fmp6hNp8jooiuy+z6hiBhuZt1YM?=
 =?us-ascii?Q?EvXWTVO1L5lQyKIWDFTIl0LEGzF15SZquAjArcG79vzGpy6vrfT7vzY4fR2L?=
 =?us-ascii?Q?DUioOZouxy1w38mUiEZg0a6K2r0S15CK26KqLtO+tXzsXaFELGhBIggaHT4O?=
 =?us-ascii?Q?V2e9whjaj1lpNt3UoMalgmy440S2yFwuiz27d5htn69qLZIQ3opuG37G7yu5?=
 =?us-ascii?Q?OD2Hd7QwtxMdAm3YjIVhuwp3u480w3SYiCgyWTGUXEtMdTSp9gas3vZJtv6p?=
 =?us-ascii?Q?FFQmaOjEeCNmyPLzYV4oIqMPDx0xf2Ox4rGStf2/rDu56GmYrkNFM4HMcsXE?=
 =?us-ascii?Q?lnlshnuIp4AFfOL6ZwtnkZF65RyIob0CSjSC5eqj7bhjR1RqNRUlAezX2Cbf?=
 =?us-ascii?Q?FynK0OlSuNgapNNt?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k0M57NJ0RcBszJ/73ZT3EmmS+2t0RM9cAajQUd3ONUYlPG73psA9WSjPXm9Q?=
 =?us-ascii?Q?KagjmKDjoa/ggRiLqP5CpiTMH1+Twxe6R15gIwfXtw9Os2+DY/V33JrnnAYG?=
 =?us-ascii?Q?j2oCiopCdYWgE6QDoxvA0Q8NxnASp5rSX9NRYHLAPUuvY5JBy1mM3QqqQk+J?=
 =?us-ascii?Q?UcF9wLVo6sXQEnYC3crouil7YbVmD7xLWbSgYRWOT1vBZqgvbKkD+0pLjK3s?=
 =?us-ascii?Q?SglW4Ith9V9HdajMSHq6lbI2szi5STbVsdQFAhXvsKXEpY7ZqAugPYYB4IT9?=
 =?us-ascii?Q?ApWE6lFGusamCGpPgB5qqtsX9s6/qLQ4Jnc2c+Ppwr1wwRQSi78dHNDSfSml?=
 =?us-ascii?Q?XeBLnc3EdvXzJElZdwu8lkUp4J2WrrkL28x7shRn7w/1U7eKYT+w3lxWyst4?=
 =?us-ascii?Q?ZoEDDEvldQnZrE2F2Mtvq95rbyH75sfrlfW/EcR5bUKfb9yvNq+thjdb3h9g?=
 =?us-ascii?Q?lshptSnZEwcKAlsCW5DoYkwSpbrR6wQgIKWYIcx16LU3oicldDxtGMfH8hy+?=
 =?us-ascii?Q?U1uZe+LFwsxS0sr3R4veAnBx+vuiEe/ObFoFWHIqQn0ZchQyVeuq/ZeHAL+z?=
 =?us-ascii?Q?B0CLRyBQteXxCaSH549+jiJ0w4+EISn383WrJ1+1QsyGJ4X82OI3dhfvbAmq?=
 =?us-ascii?Q?W4UKYlp25SQ0Ujy2Kt8LbC9x9HmRQxJOWie0kRxOFu6pEXtrxCNa6ql1VVeF?=
 =?us-ascii?Q?kkw/wj0Xiv+TrWLgZLbxhxBKn0Sn9+SLjpbqgh8wKuIVzOtu1mu3Yj1VhQZu?=
 =?us-ascii?Q?0x9qQIhKuvFveyfElH8YFTBi3rIKegG9MZDFnMZRBoSLYFst21k76mPXx+PO?=
 =?us-ascii?Q?CFERaILvbr+isCJUPQQh/aWm1jXDEDyRG1tm51Ug4n6F01IoqDonXnPZmfob?=
 =?us-ascii?Q?bK9tIz320K6+UOtc7LSdcfrHICIKuK5cwh2px0tBhidrV6WO9UN2T0BP121b?=
 =?us-ascii?Q?M+n4dZvQXn23UjDrBg6FVLWGS4h5H27em6E+00jyeZm7y1ss8hi7iC9gCwTt?=
 =?us-ascii?Q?NWqilb0QyrsDiILZSKLxquTZpfJUBOlmFhwJRFqgUeiWwEOmeXIbX8+zwq0d?=
 =?us-ascii?Q?slRQiDhTMMipw7GLJd4rqkgtQIyFKlcl0RXNB6IYxL7Q/s9mbcNGxlEmw8bl?=
 =?us-ascii?Q?CbQ8Vrq1rwJTiCoMDkANzoUY04JgMwriQKh97NXcHDznspPuwpqsy7vf3DFW?=
 =?us-ascii?Q?ILJ+mEeVyPNHiKyNe9UDQy55EAJAJd8eusEnh70102jBMmlqguwon1R3Av4M?=
 =?us-ascii?Q?QJlLOGDsEEZ5Ojluuduq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0791d99-c7be-4a37-0288-08dd569b8323
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 19:26:47.8477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8858

This patch series makes kfunc filters support the use of struct_ops
context information to reduce SCX runtime overhead.

After improving kfunc filters, SCX no longer needs the mask-based
runtime kfuncs call restriction, so this patch removes the mask-based
runtime restriction and updates the corresponding test case.

I added *st_ops as part of the context information to avoid kfuncs being
incorrectly blocked when used in non-SCX scenarios where the member
offsets would have a different meaning.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
v2 -> v3:
* Change scx_kfunc_ids_ops_context to the more descriptive
  scx_kfunc_ids_ops_context_sensitive
  
* Change the target to sched_ext/for-6.15

* Remove RFC tag

* v2 link: https://lore.kernel.org/bpf/AM6PR03MB5080855B90C3FE9B6C4243B099FE2@AM6PR03MB5080.eurprd03.prod.outlook.com/T/#u

v1 -> v2:
* Use completely new design in filtering

* v1 link: https://lore.kernel.org/bpf/AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com/T/#u

Juntong Deng (5):
  bpf: Add struct_ops context information to struct bpf_prog_aux
  sched_ext: Declare context-sensitive kfunc groups that can be used by
    different SCX operations
  sched_ext: Add scx_kfunc_ids_ops_context_sensitive for unified
    filtering of context-sensitive SCX kfuncs
  sched_ext: Removed mask-based runtime restrictions on calling kfuncs
    in different contexts
  selftests/sched_ext: Update enq_select_cpu_fails to adapt to
    struct_ops context filter

 include/linux/bpf.h                           |   2 +
 include/linux/sched/ext.h                     |  24 --
 kernel/bpf/verifier.c                         |   8 +-
 kernel/sched/ext.c                            | 385 ++++++++----------
 kernel/sched/ext_idle.c                       |  13 +-
 .../sched_ext/enq_select_cpu_fails.c          |  37 +-
 6 files changed, 194 insertions(+), 275 deletions(-)

-- 
2.39.5


