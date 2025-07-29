Return-Path: <bpf+bounces-64633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEE1B1503C
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 17:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976D816FD57
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 15:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F05293C77;
	Tue, 29 Jul 2025 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="us5fwJj6"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B750F4C62
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803395; cv=fail; b=Hp4gbxs1Jj08QyGO3RMhVG+7Rec1UO9enxOZfJzl9IriuRxpTwlo2kOm5RrWoEJxCVRqKKYgk+U8rI+vZmQpPeBKq1WldZ4h8xILMBn4BooC0Z8R0OWyHPqzJZ8EUvNe3P+RjQNW0pR5s04J/Ottm3mlj+ZwMnKd9BU/3YjjUrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803395; c=relaxed/simple;
	bh=WTrnY7goj0a976AumMs+pV5ZXKlVK73KIAiwTY1Qs0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SJ3/JWqf6scdELU8ZqrIOp7Hi4rR8ElnaVKT+GKHP5OM5k21Dn7ZauIIfqe/VyLqL+6emieSkEmlQeHU7KwyY20Q+F5VXX+ZRwZg5gv5YG54gfyniLbU6UecT0xcN0WfRhIPTmO+r8BblkbQVwb9BwJfTbTAhvglotSh23NZLWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=us5fwJj6; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpnL286p/NYU6EJ8mhylfPDueVbqdWG06265KOaoeaUKv+unS45ZSWdWZJsWU+BJC8uoFSjzCADUZ9k93ldRfUB7NJwi+IhLdL8ZB5x2xbnHSRIlc05E/lpKmEXm/nvZDudUfk9NOHrTQObUUGqxOcLT9UpIIDZ7NMg9SvPxySlENXAaXokTAwQdeCxCuqdFWctR2Gf3v0NFSsa8fWZgjcEFJQY8j7cTltq0UQS3AyArbygMaO4eRCeN0X31hXMglkp2C8pJFAikCXnI8RxbeeoCKy2R179Q0o078QqQm7FIClsTGqWnMh2pRxUTmEWdyqYRS8nnwaEEtJu0XFrM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ln6UmBtI8yAcysOdPVy2kyFSY6c/SXtD1JFtbVYSQA=;
 b=yNJ4VAk2UgVFk5x/gHU7kC7tA+Ds8+tG4usCq4wNsuD6Z8KHGbkGo0MY8Es99ZxqM1mr8XI5A8OW34aFskJPW3UwvBAvYGLTN/KPTZBsPiADOMLVp7AfPAoR7WiC24jKeMouboSWFLzrKb7KI2j1m5x/f23ukmktaNinDj0NWEcOManhC5JuBbOjTexMGghprvgYTfrFmCjduOTCXJMZIJc3adA+rMjUTSNN5vILJm+GHCffnPzYHN9vRY+fvuipNG+PYw6YRKJ8utPTO9YZK2yS0A6qVDGMaatrHJvNA2GhyZohI5MoPBoC+jM6XE7r15DWv5Ci8qjHzOlEGOhbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ln6UmBtI8yAcysOdPVy2kyFSY6c/SXtD1JFtbVYSQA=;
 b=us5fwJj6mxodndDkNrMxVTJX/RilmwbmCZiPzPsAmOehgXADMNdi86g6yqHsYzn0Z+f+sE4ZCokDj6Qhas3HzYbQAAorfRxU72skub59paUg9rghIB16PhxmJXS6zaEZHrC73ia/MNDPlMsXpNpEdZvdQANcQ6KDpuqtI119zUp73z4CWhU3xJ6U0pV7vqXQROr3XyTnVTzWEIAXUzy95Pxb9R3K5MgQ/ucFlQEYFpMeFDLjq+VlEUZnKA/pugJexszbcwZS0zpbWsKrxgp4dw2raHh7xUXmQrz2yZBgyo+1iNici7/uID91hk8GeLXpIkksvW4DXrRKm3PQg6EmRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 15:36:30 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%4]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 15:36:30 +0000
From: Zi Yan <ziy@nvidia.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com,
 gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com,
 bpf@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v4 4/4] selftest/bpf: add selftest for BPF based THP
 order seletection
Date: Tue, 29 Jul 2025 11:36:23 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <BADFCED9-4C30-4ED6-88F3-D8CB7054CC56@nvidia.com>
In-Reply-To: <20250729091807.84310-5-laoar.shao@gmail.com>
References: <20250729091807.84310-1-laoar.shao@gmail.com>
 <20250729091807.84310-5-laoar.shao@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::30) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|DS7PR12MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f72c5d9-cf64-4177-cc4c-08ddceb5b07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Mw0gGxwykOzABN046uPE3NQAzaTd6cjIVs5wp9h4W66lPxwLAEckEwNOD7o?=
 =?us-ascii?Q?pTaDwZsnUNRWggR23TJX3LEVc2yU/qCBKf/Nkjm+3cQ7eLEiJaCWjenegyep?=
 =?us-ascii?Q?VJ2nIb9+4ZzVnN/JiXd0/FGAtB8JtNLcZrPQ/EIf24u9ldjyB7WPhUYnpMXe?=
 =?us-ascii?Q?qcHcMgCIquon0VjnbE2HUREXgRS7lKFd1GH55onfpMyFMLSlsNEiKEescc38?=
 =?us-ascii?Q?tjYCOw02JgfzXV0t4ebCzfOleamBamkTy16jZQb28uoas+zoLxS3NkhJ3SBA?=
 =?us-ascii?Q?r/eSXU3k1u7JTRVNXnlz7Y0MwdhKAoxfSGcIP5ndiSqRg/61669M4vlJur6j?=
 =?us-ascii?Q?tPCyjS0zwcSc5Ci5ljLlz5NwuLXpK2tSgM5yegd2F/xhzT6dbKm4hL/2SKnU?=
 =?us-ascii?Q?LY2DR3mvdvYrSE31d/Qhi25fSzF7QkiEYLT4bN6d9Kr+ck0ohYEQXD5WfvpY?=
 =?us-ascii?Q?M2zhyEbCGi5t3WNUBMg+9BX/MTMq7gry63Llxk2SdK3MRWAOUvq1Jg+AUkEc?=
 =?us-ascii?Q?I8mqxMpYh4T8vX1xKR1iL3tXsronw0Q9F6XDKD5rMJEi1XdOJuU0aLyYkJh6?=
 =?us-ascii?Q?i3SfMZ+NQWomLLAwGBaq/k4d7GKUzOwE67S+lqYJtsXe+dPVdSxTzgWShlGV?=
 =?us-ascii?Q?dSk+1GTexpYq3ud/zIS2CgYVmCcvvppZ2GimOICeaKWDM3zNzCaEu3pYXbph?=
 =?us-ascii?Q?BgQyvNoeleMLu3NJ+JQOi+AzzcQR6r5QzXagsZHmne51PcGdTK/YS2s1uFBB?=
 =?us-ascii?Q?Uhv+42yJQ7/R8nl243ZDTARJMzhuaUXgaAnsUUbq3Ef/IFwYMxO/+4AGXq3D?=
 =?us-ascii?Q?Iz3UHT/xC5IrujrE034Bn9FLdh3Nl1ptblx0RKJq2LiKfBXOhQXZxyrrFKNE?=
 =?us-ascii?Q?GlSiL4aZCNMtuYC97JRgXAMlcjDxgGdd27vbYAnQMEJsNby0zIHnr5rlccTu?=
 =?us-ascii?Q?mF1TCeDPp0enqpJNimCfZCRmbB4eytQ0odH0Y4MPAEp3Bsq620mQm6yHx+mp?=
 =?us-ascii?Q?NoztSB+uc+hnOn5/HBr2BFXqcoog6Iunv/cgmDlTH2jXns8Z5C4m5W+xdFcH?=
 =?us-ascii?Q?0PCb+m/g3xlEgUO9wnoSAQ/g/G0P9OSJBdFt2ATI2Hu8RvSR8Ggj/FdF7q8R?=
 =?us-ascii?Q?B5OW2/l+UOLKwscLiee8RDmg4U2noEPw4Qgs6EWTOmGrueoFXGDDRzfm4a5o?=
 =?us-ascii?Q?HsEN7VlrrjWV2R4nru1wmtSetp2Y78K5szB4Z9DFAHUWyj11EXZlV/aDd02d?=
 =?us-ascii?Q?2qv1lyeTHoRwo8cfjcVKxsCQSQcPOGI/ikpfU7VtCB31kFU6fbB/3XOm53Cz?=
 =?us-ascii?Q?gMsx6IvqP4XrkNHOjmurLHJjBtSdN57Rw24o5K7fgxlsyySxbDpnVyicdMhF?=
 =?us-ascii?Q?KmhBZTxIW0uxEmVbZYpfbav6u2UzZ/7OxJGQmgUt9ToWNiwtX6th2N9482Ik?=
 =?us-ascii?Q?5mSi73tj4LM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Uc3YMTOccrLjbYR/w/hX0N8RJpeqfdK9kRKxiptSyFZ+RJ6zEMLqzbVwZtv?=
 =?us-ascii?Q?y0uaag9BX481yyOOZZwimCdjtQ1GMNa6bjqMESsuo/bcMKYeQXy4H9oD9dgX?=
 =?us-ascii?Q?D5NLgIxTgeVNI63M11uQ+8BpL+BS+UJej1s/ctp9UaAr4b5H6nQNKnU4gdN0?=
 =?us-ascii?Q?5iWJcQWA8f7iCzp2ugk4vJEychcu8h39lbm/oQHMrm8pL8lRlYCdyT3YxeWp?=
 =?us-ascii?Q?+znbA2PccGgyaJbCrY2gHlH51hX6KEIRRBMx6P0FwzoGHmk9KaOs7S3OswUB?=
 =?us-ascii?Q?zSNKXxjMDTWwD2TZhet9FYNSe4mnI8IlzcSwu+0MJ7Uiqb7b/oy2z/4rEedf?=
 =?us-ascii?Q?6E+PoKwgvNuuh89i/nsNsduI6qbXKZwSZ/HgJjHYVB0uzoEXkVRGQfmZC4Px?=
 =?us-ascii?Q?h7uEhk28PVop5g386ZfiXXiH2iQlFxWmCzyVC9s5O8uIrCxvm11e/r+84MRf?=
 =?us-ascii?Q?pWrBOJgVN1ouMjpd+IvPKSvIWf2Ftka9HRi3Z2J2GZ0M6MYe2IYUK2cQDUCU?=
 =?us-ascii?Q?nVcNY+v5GT3bLlZLXpQeVMoOR7wXEwIP90a6mmSqQKvYz2xus5przpQ7OFWN?=
 =?us-ascii?Q?gpwNq1fHUFpWjAlBvAowHFYaq0QaSHvdDwbmq7/i5Mbj2kojSd455okZxIrP?=
 =?us-ascii?Q?wfDyCCNvGKVS2w41js2I3kWXcfHJCmdCybw8AgeCXpHcplWcF5GEuOmSHtVI?=
 =?us-ascii?Q?J+FfVnqgG+/BzP1pjTAyjOZ1LF0eUAoD8Hxjq0QhdwBTDWKEF0vD9lYRcXaO?=
 =?us-ascii?Q?a214bEIH4ujUfZDfoo/scsTjruWm6VkPz0DE1lYPV5OOdTrjMrQ8gS+nvYme?=
 =?us-ascii?Q?7L0NmRGujwUBHc/AdUXF5ShpkmRWz8sKPnzO9URm/je9HBgAlK9U99wl4OV/?=
 =?us-ascii?Q?GJwd/IZQeGoPT5WIlQHr2EKoTuVaUdN0UWS+0qVytK0rOCbIy6Ixk2d5soBo?=
 =?us-ascii?Q?6V/SlG5sMplUhU8SSW3AO4gtmHVpawoA5FapWWLnF0R2BWqXSKMCvd/L/xTF?=
 =?us-ascii?Q?+uM/zAGAOn/UwQEmCPDUJLuG+GpWhJ3LcmUlVPJYooz8/jonxkpQINbEjTcu?=
 =?us-ascii?Q?QB/SzA/OXW3KRbNh+D16P7S1hJvN6WAPNeptkCIINk3Fof4ES8GuaYxKQSLB?=
 =?us-ascii?Q?iaobWHt8f2U2OYEy7XtnqvF4cnkGTOa9UoEHfLOVvuN+C1N8FW1v9no9/Osm?=
 =?us-ascii?Q?SnK/RQ0sivRhdiXryy9AB6tkTY6C5lJz5bthra3suKtL6R3D6AL8tkWYBo3P?=
 =?us-ascii?Q?IrkuWGil3jz2NvDuxsC4mf6dHv5388e2QTA1hY39RH9S/zj1UtO4axTOQKSC?=
 =?us-ascii?Q?OEkUwxOE9T0U1VB09Fjd6q+Q0pFolk7GcZy/1MKncl/KGgALHdIhusBsxuDh?=
 =?us-ascii?Q?QoWamCg/KU+feoRQAjDctV+8Z87oi3XHCKNVKFLLaSIfLDKAap/ERk3GvNMY?=
 =?us-ascii?Q?BUDUy4gjHbklfVU2xqUip6ia5iNVN8VqlpMkuKAofp3sS4yvMpJEYLYCLmxY?=
 =?us-ascii?Q?qWPH3y6Z2qcHpevQsv62GDgVhmdda4aHWl9ih47Vuqk0S9IMRPWAhRadpGGb?=
 =?us-ascii?Q?i3+5umJgFGCcwu6kBFg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f72c5d9-cf64-4177-cc4c-08ddceb5b07b
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 15:36:30.3363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VfuxnOMmyBt4kw39byv0w+Hg+lXoO2Sbs9ePmFXRE/WAb67O/IvehvGoJVC+P13
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718

On 29 Jul 2025, at 5:18, Yafang Shao wrote:

> This self-test verifies that PMD-mapped THP allocation is restricted in=

> page faults for tasks within a specific cgroup, while still permitting
> THP allocation via khugepaged.
>
> Since THP allocation depends on various factors (e.g., system memory
> pressure), using the actual allocated THP size for validation is
> unreliable. Instead, we check the return value of get_suggested_order()=
,
> which indicates whether the system intends to allocate a THP, regardles=
s of
> whether the allocation ultimately succeeds.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/testing/selftests/bpf/config            |   2 +
>  .../selftests/bpf/prog_tests/thp_adjust.c     | 183 ++++++++++++++++++=

>  .../selftests/bpf/progs/test_thp_adjust.c     |  69 +++++++
>  .../bpf/progs/test_thp_adjust_failure.c       |  24 +++
>  4 files changed, 278 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c=

>  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c=

>  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_f=
ailure.c
>

The program below will only work on architectures with 4KB base page
and PMD order is 9. It is better to read base page size and PMD page size=

from the system.



> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftes=
ts/bpf/config
> index f74e1ea0ad3b..0364f945347d 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -118,3 +118,5 @@ CONFIG_XDP_SOCKETS=3Dy
>  CONFIG_XFRM_INTERFACE=3Dy
>  CONFIG_TCP_CONG_DCTCP=3Dy
>  CONFIG_TCP_CONG_BBR=3Dy
> +CONFIG_TRANSPARENT_HUGEPAGE=3Dy
> +CONFIG_MEMCG=3Dy
> diff --git a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c b/tool=
s/testing/selftests/bpf/prog_tests/thp_adjust.c
> new file mode 100644
> index 000000000000..31d03383cbb8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <sys/mman.h>
> +#include <test_progs.h>
> +#include "cgroup_helpers.h"
> +#include "test_thp_adjust.skel.h"
> +#include "test_thp_adjust_failure.skel.h"
> +
> +#define LEN (16 * 1024 * 1024) /* 16MB */
> +#define THP_ENABLED_PATH "/sys/kernel/mm/transparent_hugepage/enabled"=

> +
> +static char *thp_addr;
> +static char old_mode[32];
> +
> +int thp_mode_save(void)
> +{
> +	const char *start, *end;
> +	char buf[128];
> +	int fd, err;
> +	size_t len;
> +
> +	fd =3D open(THP_ENABLED_PATH, O_RDONLY);
> +	if (fd =3D=3D -1)
> +		return -1;
> +
> +	err =3D read(fd, buf, sizeof(buf) - 1);
> +	if (err =3D=3D -1)
> +		goto close;
> +
> +	start =3D strchr(buf, '[');
> +	end =3D start ? strchr(start, ']') : NULL;
> +	if (!start || !end || end <=3D start) {
> +		err =3D -1;
> +		goto close;
> +	}
> +
> +	len =3D end - start - 1;
> +	if (len >=3D sizeof(old_mode))
> +		len =3D sizeof(old_mode) - 1;
> +	strncpy(old_mode, start + 1, len);
> +	old_mode[len] =3D '\0';
> +
> +close:
> +	close(fd);
> +	return err;
> +}
> +
> +int thp_set(const char *desired_mode)
> +{
> +	int fd, err;
> +
> +	fd =3D open(THP_ENABLED_PATH, O_RDWR);
> +	if (fd =3D=3D -1)
> +		return -1;
> +
> +	err =3D write(fd, desired_mode, strlen(desired_mode));
> +	close(fd);
> +	return err;
> +}
> +
> +int thp_reset(void)
> +{
> +	int fd, err;
> +
> +	fd =3D open(THP_ENABLED_PATH, O_WRONLY);
> +	if (fd =3D=3D -1)
> +		return -1;
> +
> +	err =3D write(fd, old_mode, strlen(old_mode));
> +	close(fd);
> +	return err;
> +}
> +
> +int thp_alloc(void)
> +{
> +	int err, i;
> +
> +	thp_addr =3D mmap(NULL, LEN, PROT_READ | PROT_WRITE, MAP_PRIVATE | MA=
P_ANON, -1, 0);
> +	if (thp_addr =3D=3D MAP_FAILED)
> +		return -1;
> +
> +	err =3D madvise(thp_addr, LEN, MADV_HUGEPAGE);
> +	if (err =3D=3D -1)
> +		goto unmap;
> +
> +	for (i =3D 0; i < LEN; i +=3D 4096)
> +		thp_addr[i] =3D 1;
> +	return 0;
> +
> +unmap:
> +	munmap(thp_addr, LEN);
> +	return -1;
> +}
> +
> +void thp_free(void)
> +{
> +	if (!thp_addr)
> +		return;
> +	munmap(thp_addr, LEN);
> +}
> +
> +void subtest_thp_adjust(void)
> +{
> +	struct bpf_link *fentry_link, *ops_link;
> +	struct test_thp_adjust *skel;
> +	int err, cgrp_fd, cgrp_id;
> +
> +	err =3D setup_cgroup_environment();
> +	if (!ASSERT_OK(err, "cgrp_env_setup"))
> +		return;
> +
> +	cgrp_fd =3D create_and_get_cgroup("thp_adjust");
> +	if (!ASSERT_GE(cgrp_fd, 0, "create_and_get_cgroup"))
> +		goto cleanup;
> +
> +	err =3D join_cgroup("thp_adjust");
> +	if (!ASSERT_OK(err, "join_cgroup"))
> +		goto close_fd;
> +
> +	cgrp_id =3D get_cgroup_id("thp_adjust");
> +	if (!ASSERT_GE(cgrp_id, 0, "create_and_get_cgroup"))
> +		goto join_root;
> +
> +	if (!ASSERT_NEQ(thp_mode_save(), -1, "THP mode save"))
> +		goto join_root;
> +	if (!ASSERT_GE(thp_set("madvise"), 0, "THP mode set"))
> +		goto join_root;
> +
> +	skel =3D test_thp_adjust__open();
> +	if (!ASSERT_OK_PTR(skel, "open"))
> +		goto thp_reset;
> +
> +	skel->bss->cgrp_id =3D cgrp_id;
> +	skel->bss->target_pid =3D getpid();
> +
> +	err =3D test_thp_adjust__load(skel);
> +	if (!ASSERT_OK(err, "load"))
> +		goto destroy;
> +
> +	fentry_link =3D bpf_program__attach_trace(skel->progs.thp_run);
> +	if (!ASSERT_OK_PTR(fentry_link, "attach fentry"))
> +		goto destroy;
> +
> +	ops_link =3D bpf_map__attach_struct_ops(skel->maps.thp);
> +	if (!ASSERT_OK_PTR(ops_link, "attach struct_ops"))
> +		goto destroy;
> +
> +	if (!ASSERT_NEQ(thp_alloc(), -1, "THP alloc"))
> +		goto destroy;
> +
> +	/* After attaching struct_ops, THP will be allocated only in khugepag=
ed . */
> +	if (!ASSERT_EQ(skel->bss->pf_alloc, 0, "alloc_in_pf"))
> +		goto thp_free;
> +	if (!ASSERT_GT(skel->bss->pf_disallow, 0, "alloc_in_pf"))
> +		goto thp_free;
> +
> +	if (!ASSERT_GT(skel->bss->khugepaged_alloc, 0, "alloc_in_khugepaged")=
)
> +		goto thp_free;
> +	ASSERT_EQ(skel->bss->khugepaged_disallow, 0, "alloc_in_pf");
> +
> +thp_free:
> +	thp_free();
> +destroy:
> +	test_thp_adjust__destroy(skel);
> +thp_reset:
> +	ASSERT_GE(thp_reset(), 0, "THP mode reset");
> +join_root:
> +	/* We must join the root cgroup before removing the created cgroup. *=
/
> +	err =3D join_root_cgroup();
> +	ASSERT_OK(err, "join_cgroup to root");
> +close_fd:
> +	close(cgrp_fd);
> +	remove_cgroup("thp_adjust");
> +cleanup:
> +	cleanup_cgroup_environment();
> +}
> +
> +void test_thp_adjust(void)
> +{
> +	if (test__start_subtest("thp_adjust"))
> +		subtest_thp_adjust();
> +	RUN_TESTS(test_thp_adjust_failure);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust.c b/tool=
s/testing/selftests/bpf/progs/test_thp_adjust.c
> new file mode 100644
> index 000000000000..bb4aad50c7a8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +#define TVA_IN_PF (1 << 1)
> +
> +int pf_alloc, pf_disallow, khugepaged_alloc, khugepaged_disallow;
> +int cgrp_id, target_pid;
> +
> +/* Detecting whether a task can successfully allocate THP is unreliabl=
e because
> + * it may be influenced by system memory pressure. Instead of making t=
he result
> + * dependent on unpredictable factors, we should simply check
> + * get_suggested_order()'s return value, which is deterministic.
> + */
> +SEC("fexit/get_suggested_order")
> +int BPF_PROG(thp_run, struct mm_struct *mm, unsigned long tva_flags, i=
nt order, int retval)
> +{
> +	struct task_struct *current =3D bpf_get_current_task_btf();
> +
> +	if (current->pid !=3D target_pid || order !=3D 9)
> +		return 0;
> +
> +	if (tva_flags & TVA_IN_PF) {
> +		if (retval =3D=3D 9)
> +			pf_alloc++;
> +		else if (!retval)
> +			pf_disallow++;
> +	} else {
> +		if (retval =3D=3D 9)
> +			khugepaged_alloc++;
> +		else if (!retval)
> +			khugepaged_disallow++;
> +	}
> +	return 0;
> +}
> +
> +SEC("struct_ops/get_suggested_order")
> +int BPF_PROG(bpf_suggested_order, struct mm_struct *mm, unsigned long =
tva_flags, int order)
> +{
> +	struct mem_cgroup *memcg =3D bpf_mm_get_mem_cgroup(mm);
> +	int suggested_order =3D order;
> +
> +	/* Only works when CONFIG_MEMCG is enabled. */
> +	if (!memcg)
> +		return suggested_order;
> +
> +	if (memcg->css.cgroup->kn->id =3D=3D cgrp_id) {
> +		/* BPF THP allocation policy:
> +		 * - Disallow PMD allocation in page fault context
> +		 */
> +		if (tva_flags & TVA_IN_PF && order =3D=3D 9) {
> +			suggested_order =3D 0;
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	bpf_put_mem_cgroup(memcg);
> +	return suggested_order;
> +}
> +
> +SEC(".struct_ops.link")
> +struct bpf_thp_ops thp =3D {
> +	.get_suggested_order =3D (void *)bpf_suggested_order,
> +};
> diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust_failure.=
c b/tools/testing/selftests/bpf/progs/test_thp_adjust_failure.c
> new file mode 100644
> index 000000000000..b080aead9b87
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_thp_adjust_failure.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +SEC("struct_ops/get_suggested_order")
> +__failure __msg("Unreleased reference")
> +int BPF_PROG(unreleased_task, struct mm_struct *mm, bool vma_madvised)=

> +{
> +	struct task_struct *p =3D bpf_mm_get_task(mm);
> +
> +	/* The task should be released with bpf_task_release() */
> +	return p ? 9 : 0;
> +}
> +
> +SEC(".struct_ops.link")
> +struct bpf_thp_ops thp =3D {
> +	.get_suggested_order =3D (void *)unreleased_task,
> +};
> -- =

> 2.43.5


Best Regards,
Yan, Zi

