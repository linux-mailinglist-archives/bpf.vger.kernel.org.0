Return-Path: <bpf+bounces-56223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7714A931AA
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 07:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0228A478E
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 05:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E555254856;
	Fri, 18 Apr 2025 05:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SgfBxmNH"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699311CF8B;
	Fri, 18 Apr 2025 05:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744955614; cv=fail; b=S3aNMJBQsDMvxC0UhNcNC7qEj20HqrhrRQXpFyRsRLLINZdbUZzulW4yt97OZW2ZAHWmeBtvJlBS9ehAns472d2uERixAqCu3tHH7X/HxLp6ipIC/CRnXP7JGglIs+9V51XL4x44SpWT3p2Cp37qIe8SUqKZIzb9ewtVtdpr+NE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744955614; c=relaxed/simple;
	bh=ww6J2LdH9iKt/INc3EdUSp/yS7S+oqISNtVH0viO5nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F7X0tWnQrIp0ZxI2oJN7SkMfzd+s09JGhWX9Gm4H+/K874ScsZVAsdD9QsGXP7wGyD7frogFxYIEr0sXblXa1kCG0iAJmMBDF4CRbvtCle3zGpuscSXjn0PvjxIcAZGpyYVApJWBbYTwbOpt+gPgnYanvGdJdhS3ZHlQdrCLVrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SgfBxmNH; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhMM8IaAlpmPf4Dh3TV9G53hiGuZE6vGDlqyRO4K7T1zjHqB1i9BBy+tNai51ySu3wCHbm9eTLWnURe33pCTN17iYOEUh+iTYaGW8XIJtPKfPDTv0ZussCA5GQXGZtWiK0gIbh3htwaPgyfRcJc6UGr05tL81DPhXKFds9tHuOQdIXID343N6eMRIO2BQQPBjaFz0v436LKzOkTGJE50ANKXuB2bwxwzM+AKKxMmchPWDOBlWqp2AcxeG1PyqP0MaWvi9w3zCz4tNfct6fDyjEfQIhItPL+XaMAsggois/IHyzutHoytuuXtxYp+dKPg5MupAQXd7/INmCZ1yJohPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zR7qNOPTxYpmR0b/o/IBZbBJluRNBzRkUbPtqWWfUdc=;
 b=e3tsr24aGcDHHtExCOuJ9tL4fwHaBCl1O+lTCDr44z96wIBWicxik9jtaT7B4jNoSZ45i1sVpXXpvzhKIPGYgfpyKPfypvfjrCmZ4nZzNAxuogiXTl8iA8c+RJU2PbsvNJnt5MyIbsp/8Gnpadcuk/hntmQ91sa1Km1citKGe9GdJZdSJ5EoqGwDsWO7gpbBzdpx6jFRL5QebbVNltgjIq5T+Va+UGnIf+MFDSDX4Z7KthlBrpVJBZOzO3jVnQ2wT2UphFjuik4z8mkUBH+xrpKf9HUR89gZDHF1FwBxVDV68s32POFM7f6KmFaI4v64QdSn398MHrdBDbkRFb4VaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zR7qNOPTxYpmR0b/o/IBZbBJluRNBzRkUbPtqWWfUdc=;
 b=SgfBxmNHzY1wGlZdWQKYXAS2VkgMPQXlGt8BLDwLAESHm9HBrC/8JwhHVQoxM0z0aJCQhQkkZx0bjJrzfX9bbEMZIJHgHY23HcCvdxHyZFH9KtMnmH/gw9QYkF6NzQvd5YHi98HlOtPWCei3GlJkIdFdfKp9hDBr6iCVKwMadOuVdWwXjwqPUwv9LP1JuSN79KFG2fxhKmiaXMec0NG0jnEEP8bTUTV2w/giuRSIPv6a4AJ7TGkzF3d+Hk00ZRbE36ewQxnyQxQzIFSXbNnXlCdONIAdsXNr8Wi/AmPx1nt1kPE4D4/ipOQfJuaBDrjAHAGmXey1UWkGCOzbMow7YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB8178.namprd12.prod.outlook.com (2603:10b6:510:2b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.41; Fri, 18 Apr
 2025 05:53:25 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 05:53:25 +0000
Date: Fri, 18 Apr 2025 07:53:14 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Honglei Wang <jameshongleiwang@126.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, joshdon@google.com, brho@google.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 0/2] rename var for slice refill event and add helper
Message-ID: <aAHoyhfSV1ZUjwDv@gpd3>
References: <20250418032603.61803-1-jameshongleiwang@126.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418032603.61803-1-jameshongleiwang@126.com>
X-ClientProxiedBy: ZR2P278CA0033.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::9) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ba11219-9367-4a3f-b177-08dd7e3d5561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iVjInG9nvn/+WqqLEm7wFfuoio0HU8Jqtlau96wQP8nzOatMRCmXDT7M3Mim?=
 =?us-ascii?Q?yy+iSgdVRLkP+Dk1X1IHkguLPrPnmdovADPZ9h8tt7RZWG5JmO/1NLUus4k6?=
 =?us-ascii?Q?vRI3/8wnNokeyZ3unPIiwgWwvdcZlx+jPbsizJNRrnN7NDeTMBl4LVm3Ktyr?=
 =?us-ascii?Q?NatWDOytbWMdLTQwUMwH3VhmUaVJ+iYf1RvmIgsiclzke3FFbFwHot/Pjqap?=
 =?us-ascii?Q?qfzV044gPMKkpEGrGc1M90mAAzv6wXzD2xDX3vh/gVPbW7Noagdb/Mg10ton?=
 =?us-ascii?Q?U3F2ZplMZMJSpmraRUPrZ3x/H28f+L6PrZw+yZncfzHl9mbDwRRP1hI82XVN?=
 =?us-ascii?Q?NYsBODlD91xdaerGjXWuNzUAJXucf7SwD84mXlchlBM/+0w+zlaIoONB/s7d?=
 =?us-ascii?Q?LEMhZwf6fBOKSPzckDV+JD7nzqE0tRB4+Cr0gRE+U+zN3MYPsbdnSH8dNhId?=
 =?us-ascii?Q?Hktr5O5BRvf10kaqa2xq0U1YyfTOKpaWpudXRWceupezxjyJXSiEpsGvXlw9?=
 =?us-ascii?Q?Gm5lzcy0laN8dwFx2fKmgd3Dhw4W0XOcYMPid7ulZP293Sp88aC2CJgrrAul?=
 =?us-ascii?Q?T8Blpxh+UYFyvLPpeTZsdWGWvz0JFrUS8vSwy8QlcSkoI73UD/UVPwqaypiZ?=
 =?us-ascii?Q?oBE0dfmvMhkD/hENXlbY67ZpG16HhkC93DbDuKBcv+ZFqW89QpaUBbSvQBhl?=
 =?us-ascii?Q?51p+ABT3lQDylgfGW+/8RZpRuYmbdAOieEGR2wRxPSkq2e9NrrK6itpgAhsa?=
 =?us-ascii?Q?EuzGrqoeOcjwpWoFWmNJgZIIjYyFn0CFxzEN6iJ3Oot9Fm8S0W188NcfHmcu?=
 =?us-ascii?Q?uRx8twr+UGd+XEtRyFaVfH3xB1dnHso6mrASickGQrKS/8WUeET1uEnkTbTl?=
 =?us-ascii?Q?hRCZ3cP6bCIKqneZN8CbwLRq2bh4DvkWzc7YABLmBQmtiUtSy/DCM4WFaFY2?=
 =?us-ascii?Q?VBRcjPJicH7OZp+dxHWyrtZPHXoQdz+BTvXjS4hpv9+U5prkposIL4JI8+bs?=
 =?us-ascii?Q?NjP7awyO49tbzAqB0GNphJi3H3jtV+OZeN9VPk0EtKxDUb15oKn3NMSnvTDs?=
 =?us-ascii?Q?IFwgu49itbnrKs6S8AB7bn2WV0h3Lro50OHbK5g24dRU5SdfPQOXsLvHQw2W?=
 =?us-ascii?Q?7mikeJZvVtSwE7hc8z4f4+GCxLFMRMS3WaCjib02HYng6UBoDS8ONXGrShdA?=
 =?us-ascii?Q?cZhWq09VQfkJEln4qkxYdADajlM/gVszXoEIu1YmO57q5S7HKxnTxRaX4iQi?=
 =?us-ascii?Q?3zAun4qwOkhN0UMOD2TmMo+sm61M0vO8lgUx7NN3luX9Lg7tHR+Y1sG1jjkj?=
 =?us-ascii?Q?L6rFab50Hw262Nv6YJ5ntWDvgK9IvekvymYo5eBPrUMABD2gMTmFv0aBeUW7?=
 =?us-ascii?Q?mQgrp9H7LSZlv7MBB9q0c8TxsNQySH4DBcF2DnxF09ftKC/RZga5F8BfUtr6?=
 =?us-ascii?Q?G4g0xDpoTQA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U8jA5Saq/Iq/8wVcPs0wvMFDAnmcQKiUhrvOEhgYkks80WtzpD/X+FB2hz4h?=
 =?us-ascii?Q?DSYgf76o96/jjdZAQQCQQoR8z1bAq+cH3aZlZgA0o8lAioMSSC3j1axpReFm?=
 =?us-ascii?Q?IZ2n/8muX60ZKOToanst8AOKQkgbHxxKgX3s0zhf5PnmZFKe2ZzBlnBi563L?=
 =?us-ascii?Q?v1CaKeG6W/EXTeaOR9jpt0Oq/K1ZsrtuJBCuNTUX9wy7Y0nNW4kyr0IE9H6u?=
 =?us-ascii?Q?hvrzjQUrR/AsYfTrxt6FkaXHeYYySxo+1CD9vtFvM9zkQqpciZsocjtGsdOD?=
 =?us-ascii?Q?ozRZYz+q0Zn9+tZGvpl1F8cTuuwQAMeGbwixEl061it2GX9OHiHZD02uQccV?=
 =?us-ascii?Q?Z/94LJY+EPxqVcvzpbvFJvRmOFni5KAxtUxjbIjDOdHlcDUVthigFYUsHJQc?=
 =?us-ascii?Q?2Ly2Z1+sq3eVU/kCTVr7Xg5VizoZojDi1wzzfW2PernYrbIY0K789Y5mr/kb?=
 =?us-ascii?Q?14QMS6Sr71qBl3BfUMCTh4KniIMRmhsk1Rl0JOpk7PrciL2R/mYiJoYm3SVJ?=
 =?us-ascii?Q?ZcCOazlHWd40geko7Sz4Ur4WO5tEOcRt5axGRxFfGEX3pCQjFLHxu7rtDgVu?=
 =?us-ascii?Q?881iIOdjcxfv6xRyKNwMso+ojs+cpWYPDprwl3nu1R/eQlRozexaInaZjhAl?=
 =?us-ascii?Q?gTYdNOdJ4T3LkKxkKL5aYuHEe86+Y7TGvPnL7bXLxUpUGa5hfHEGsvOSxFxx?=
 =?us-ascii?Q?u87iLRR/FrVh0AvmctDKPHJ1a2HWAwui28+pbLjGeNlys9Bvz+ouOEXOEXsR?=
 =?us-ascii?Q?77Xv3DDhfKfTG3m+mlW1MqEVO7g8aHAMJ5OS3D9SPpAzGUCfnZx+2VD1igUf?=
 =?us-ascii?Q?2Jq6YfiFZtpSMFslpNB3P0San+r7RFQaqkys9HxeIYd5JjT62UD3v8u2YmNz?=
 =?us-ascii?Q?4f5sqgA4nLGB7DLTC+HWnFiI0prTplnkUUE/H99Ja/GrdqifLRMEcXxVQuZ5?=
 =?us-ascii?Q?3KDxcLC/06JZFOdq6tXrVz4Jd38kR+ZaWnSHmL0Z9vMNy7lyd6asGPykW9lo?=
 =?us-ascii?Q?mKKHF/ecF6+u2z68dqayxneiRfJrwb4qLV7Ss25aoc7+RTAA6OTp7XJK5VMa?=
 =?us-ascii?Q?WyKy3pmafJIgM9plMyCXJV4KT2IBMEwcEGTTNbHuirCrl0pWdVNtiJRAFhOB?=
 =?us-ascii?Q?5gEIyvZr1ruo0cXJGnyhxP4ULE+09sq/SZsbXA/4zGVrj0kIjfNWHXCH3pwX?=
 =?us-ascii?Q?O/i4rO+Xr2ZChv6qpPp4U8jqayUsBZYSn1DdpL0GAaUMokdg4m5HOTTF0RlA?=
 =?us-ascii?Q?jGdFIHqTtVLMIFN1XiqBElwO6Zen5WwwGYIJ3D9H740VNoQoApIYWKj2ukHC?=
 =?us-ascii?Q?jL4AhFfWY0mKxW3OFBge2Kgw/DnSaI9RJXcgRnaV5pk6y5NI5X4nnX2qrBOP?=
 =?us-ascii?Q?KlB47xIkrJhGDo+sbrw7SKozNyzgYoDgvskNFayOHzcutMTMyqLp/LS1h3z5?=
 =?us-ascii?Q?DeMWGjs5WjUS5ZPjRcVowKM7C4dGKq8pRvuSuHi1lWpNtVXw9q8+GKeEpAH+?=
 =?us-ascii?Q?UTgbTg35lkTwLTuh3Yn0iTRw6/56HgEadDZ0X0BZk8Q6evLssSrOjo33/mbg?=
 =?us-ascii?Q?CpvA2d/SyKGaDi9CXB2nIIoZVqYgDR38DqOceUCN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba11219-9367-4a3f-b177-08dd7e3d5561
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 05:53:24.8516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAnAwwqkSVZm4PKpjqxyHOhzNSysMsLLmN0LZrZoem+2KdRCxWTveP2sg86b08NrErGlpNTWqh7rHKIEC5SeIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8178

On Fri, Apr 18, 2025 at 11:26:01AM +0800, Honglei Wang wrote:
> SCX_EV_ENQ_SLICE_DFL gives the impression that the event only occurs
> when the tasks were enqueued, which seems not accurate. So rename the
> variable to SCX_EV_REFILL_SLICE_DFL.
> 
> The slice refilling with default slice always come with event
> statistics together, add a helper routine to make it cleaner.
> 
> Changes in v2:
> Refine the comments base on Andrea's suggestion.

Looks good, thanks!

Acked-by: Andrea Righi <arighi@nvidia.com>

-Andrea

