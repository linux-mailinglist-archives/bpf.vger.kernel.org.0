Return-Path: <bpf+bounces-64629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FFAB14FFC
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 17:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC91116CB3B
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 15:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1933212FAD;
	Tue, 29 Jul 2025 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O5mN8mlx"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A385C1F5E6
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801682; cv=fail; b=HXHTZW815Z6AaLLxUmEEhv8f63IE8DH8LkmHjDoU3NkknC4m0GrrsxqRaY1uWXE4Vp/3LWS1Yqt1MQGVv1BbU3l1QZvDq/5jLhZ2v1sTehM+RP4Swp5loIvRP2IUNo8T2BQT8SzcJqrlofu7RZIsjNCU8aOrYcHvAiSJx+wBYVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801682; c=relaxed/simple;
	bh=6V7AVFbJI7fN7DYsS8xBmejeqzJ/bhYCaXw0rz2poX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sfWMlPVS+iXLnzUosSW30DiHWZujiSgtoRLC9RIrL1KbMwyszPZzMlwvkd2KdBo0+LyO58nBhXJA+TQOi8b9fgvTklZikb7qZyf6CcqOZdHnK1rTF4nriKqeV0NV3RhnVBucdh+hqzO9W6DA+hsSrWKwZ8sEyiuo2NbWxARasPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O5mN8mlx; arc=fail smtp.client-ip=40.107.95.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7qWNurtZdRbOXkAL9g5FnbQvUZ6beACDJcr3kkca7cZv2UwOOufA5zlpVVmSRH0jBaDEF7HxEyYHXHu6czau1EFq5iWQgQA4IUY1WgCJv40GN33FLHx6035fwGatxvLZ6bbkh3QBe8oUxAz7+IYpzWEjq2cFXo3Kc7Y+QQ2ZscxBwZTbIPCk6bOr3fBuwYhLyG+RS8nFj5FY6k1eXO3sU6v4go1YTmk/IEaHgkdE6k0NDYBL59HAtSDutm3r46hTK4K4Ctb/DAWRmFIf1dm8vqajlAlV7e04HKMUdX1r0ixIa9fqqwV2XBxJKgVVOpBrdlQlaUSWJsU4D+BSh4Flw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgQ6Q101bjf+9aMsyBEe0HD9e9PsDRi+fUIiYOHpkcA=;
 b=ajXmJ1YBVfw/n8Yp03EWredNL5ueOra9biKzgicNPJsxu3SY5AtJZZvODGdbmmc3SvgoFR7WOzPa/hbs6ViwUlmFCMBdT9RtHiQh6epM+O6LJm8kfu+SIyuehmNEfz2y6M8Bewrc0RCR3VKSEoV828EjxQitXuruVeTg9+nKw2jYlJ2IZlrApdJ4iE7RXEgerijO+yIsNpogc1IfAXIk5bOJwelTnNpobgDXyZJyPj1MqmuBNpnQqz8yBfsKlIPB+zf/TLs2frcqCoJzSGAseS1w6YWZzeO3k3zDdkizpWlsG1rTCJPAsjvWOnAYNu9P0VnyfmMLrqXgMnW3ZPiYHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgQ6Q101bjf+9aMsyBEe0HD9e9PsDRi+fUIiYOHpkcA=;
 b=O5mN8mlxw634TpNulKs4iIIWiC/+KX6TI5/f4ATM6Wfy/y8ZrmhlI2ky8DEOSQSNH8X4UNqcY1OwyeIO5CEdpKng6U2nqnnN2WkueSIxOTTQXQ7kcQXs60/M8CIRLCvzHe6/DbcMRpBOry/7XsscmwBwGorUQeUlKKv1QGc+EAuBx2YLtYppsnAotlG96o/n48dimsmWGWJU87hsOR8Z4IqS2ZPrAPulFxthihoK8wfTlhz74WKFFU63jpNe/Y5et70+Nt8h5E/Z6KtYbgeQfXS9vsBp4L2j/TJQW/oCWrXxCqnX/XX3eW4h4c5WkKcdukT3gx/Qnz2sM/LtHb8ylQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by SJ2PR12MB8718.namprd12.prod.outlook.com (2603:10b6:a03:540::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 15:07:54 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%4]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 15:07:54 +0000
From: Zi Yan <ziy@nvidia.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com,
 gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com,
 bpf@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v4 0/4] mm, bpf: BPF based THP order selection
Date: Tue, 29 Jul 2025 11:07:46 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <08D7155B-84F0-4575-B192-96901CFE690A@nvidia.com>
In-Reply-To: <20250729091807.84310-1-laoar.shao@gmail.com>
References: <20250729091807.84310-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:a03:331::10) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|SJ2PR12MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: dfcd67b4-ecc4-433a-c118-08ddceb1b16c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUxkWWw1ckNPT1ZaL0w1blExVm1Hbks1RlI0MzRsamk5Z2xjMC8rV2ppL0JW?=
 =?utf-8?B?YXVza3dZWVVkaG5YSVdXVUduTG1VUVE0Q2tMM0t3ejBxNk1GUlhPQmlvZlor?=
 =?utf-8?B?OHB4VmljZSt5ejJwNWZnUm5OdEtYUjhFMS9naTlWc09GdVdhN21JcWRrU0tT?=
 =?utf-8?B?TjZxaEFiZnByb01uU1JZNE9ENVVCblVFaE1JQkoxMXhLeGthMkZ6cWpCYWkx?=
 =?utf-8?B?ck9qT2J3TlpGV0lDQk0yNDJBRnZCVGhqSmJQUCs5M2NCK3pFRjB0N3BlSDZL?=
 =?utf-8?B?U0FHTHRTcThsaG5vYWtIUFliU1Vhc3FGdFg3bHpJZ2hDU3FQU3lkTWlvc3Fs?=
 =?utf-8?B?OVF1ZWp4eHd2Z0ZLV1NLN2VoS1lldkVKZmlqS29leFlGQmtCdWM2R29reDB3?=
 =?utf-8?B?N2VVbmFmZDZrUGI4eW9vUjB6dHdQaUczMjRJV2pYVFBQS3BWUkpOQm51L2hP?=
 =?utf-8?B?Zml6UHV4aVJvSVBRTEN3b2RUdVl1N1JtdW16ZmJHOHN5Q1pJSEEwVEM4NnVz?=
 =?utf-8?B?WnV4UThWRGxXM2pMRXlsbTU5NjNldU9jcDJYWmo2ZU1PU3JyZ2RjM2pPbGVX?=
 =?utf-8?B?Z25TeWwyQWhITE44R2pQSnVjQUtuT2tsQ0VGQk5PWGgwNjlxN3FtbGZ0OWt0?=
 =?utf-8?B?UnN6SFU4OEJmRzZmV3VFSFdqTEtBbHllTWJQbStrZkRweDU0d0lIT25md1N3?=
 =?utf-8?B?SXZoMEQzUTRUS1loSkhaT1pvREhlcFhReU9ObnlsVVpOVTJBa2pSNlcweVJh?=
 =?utf-8?B?VG9QVGZiV0x1aEVNSnUwaCtlVEowQStlVFBvRUhEVDlEM0ZNWXJmT1lzaGh6?=
 =?utf-8?B?YTREZ3I1bWlJRmtvdEM0ZG81b1hLRHFnWFpiZ0YzQ0k4K21NMEJ1ODVrb2tO?=
 =?utf-8?B?Vmg1VEQwa0VjUVNGMTNndmJ2SEJWTGdoaDdOUlFFYkZBNHNCbG9nY0lHTFlu?=
 =?utf-8?B?SG1NSXNXMUd0K2o4dWtmOE10THR5dXdGaHd1Mm9FcFhMTFNTRnA4RDAzVWxi?=
 =?utf-8?B?YWF5MVlYL3dpaE9pN2Z6TzZJVjc1K3E3SWxtN0kxV2RrbjExYS9TSGl5b1Av?=
 =?utf-8?B?Y2lCQ2txU1g4QVFUVTFGNUpaTDRuWG9lMDhTQU1EcTRXLzVjZ1VzTWorUmdY?=
 =?utf-8?B?TURkK3htaXlETGlxSDRhLzJIVHdaN2p0RDBUYmRKMzdRMVk5SFJEQ3I0UUxK?=
 =?utf-8?B?V3dsT3BSTWg3SWRGS3JXSUVHeFFnV2ZBN0lLOFVvSm9lb0IrMitraTVZeWh0?=
 =?utf-8?B?RHZKYkZXTEV6cmxoWXRoV3piN3ltbFhWdDdoU1V4bWU5YkRSa3YybEdpaUZ1?=
 =?utf-8?B?R21LdHpRZ0sxdFZtU3BPcHpLbW5UM0E1YU9XMWtTNkkxSGVTa0RlNFJBaU0z?=
 =?utf-8?B?bHEwZUFSQ21aZytkbUpHa2Ewb3E4c2R5Z1duK1l5WHRtUU9VUW56NnJVWll6?=
 =?utf-8?B?SS90WVBiN093WS9FenFrblExRHc1T2dlTXdHNytmcVVzTnNQeVdoV1FGb0Uw?=
 =?utf-8?B?YzF6NDJYOEM0YzN3aVp6OWtIcjdzSVRRWTIzNUV1NWFja0d0cllsM2VlRGJ1?=
 =?utf-8?B?R2VUbVpGUFU3MlhRY3dWKzFGbTVPMklJRnhsZ200ODFSUkZ3ajQxcm1OcE9T?=
 =?utf-8?B?U3ovS25ETDhJQXZsWUNoTHN5ZGRpclpLbENIaHd0MFVZQ0FWd0RrNWN5cFNP?=
 =?utf-8?B?d0VPK3JPeE1lcUZMTlBqUFAzcUQ4YkM0VTU1MmdJUVlGQXovQ0NnYmtRR0RO?=
 =?utf-8?B?N0N1MXlVMVlTR1h4a1VwL1pidmtXa0hPbVlDSkNmY3lTQm5rc3U3YVIwSnhs?=
 =?utf-8?B?QVltWDZRME5aTEhSaWFiQytqVzBMRmRTbDZQVnkxZ25EUTFHMmQ4enJHVDJM?=
 =?utf-8?B?SUtMckhxaEhoZ1pWcXhsMFBIaFRsaFVBOTcrMFFlY0hqYmsybUFyVE9NUWUz?=
 =?utf-8?Q?tupE9lh/Hy0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjROS2YzM054TFU1eTBaT25OUTVLVjdCcCt2NTBTbDZvWnlTZVpwTUUrYWxz?=
 =?utf-8?B?R0tKamxPTnVZYXRRdFJVWm9ITkJLa0JkSWFXcjl1TDJ5cVJSVnpFbWMxeHNZ?=
 =?utf-8?B?Vy9YVW5aYkJFSm9kcnpqRlBrYllwU3Z6WnZ5Y3prU2Ercy9VZWZONzFtV0kr?=
 =?utf-8?B?cDlweEVUa0QvQTltR25rajJhR0N5dnB3U09GNjBBUTlvWEUrWHBIRVNTek9M?=
 =?utf-8?B?Qmlzck5oVko2c3J3cUlSYVZaT3k1SW1USzVlckdEbkY2U1ZZYVJsMVVJN2Vn?=
 =?utf-8?B?Q2k1QmNHWEU2N1NQUHlrV0p6Z0c0MVFsOWdQalROYVczUzNINU44Q0Q0TTE2?=
 =?utf-8?B?ZE83RitFU2F5U2hibTNuSmkzOUo2bE1OQjBaTXpPYW5QejlYdDFqSkxZaHJt?=
 =?utf-8?B?WUhhRHh3U2Ura3BWb3dnZytYTDNGQ0JNdi9Xb292dmJVWDdUdGdDSVVCcmdq?=
 =?utf-8?B?bzJWSVRIMkhGTUdGQ1dRMmxQQXhtQS9OeEIrOVJpQU0vQjlsQ0FGdjBkWmlk?=
 =?utf-8?B?TTlSdXFXSnVlWlBOV1dXQldFUXBqeXBFY1ErZHFRRjVFL3FkMmhqYzJialRX?=
 =?utf-8?B?YVNxbXJacWRhVGNTWlhlRk4zdjdudFYwbnQ0UDJXd25aek04L1hEVHl0TjZB?=
 =?utf-8?B?STNQQmNFbkFONXlnQ1pSbUtSUmE1dGVqWXU0ZWk5aWZMVVMrc1JZa3F4WVhY?=
 =?utf-8?B?alorQnpJT1ExeTdpQndGSi9COUxBOVJtQTVmY25aRFZrOWV5Sm1vOGJOblMz?=
 =?utf-8?B?T0RxNUllQkRrUGxaSzZEdXp4b3pyUEkyTmx1OWppa3NDQTdvbEFQM0JnTUJw?=
 =?utf-8?B?MVQyZy8xbXJTbDNpQlFyb0taVlJ2OUpOWVZwNnZCVDZQTStFMDc0ZFlvblcz?=
 =?utf-8?B?MW5kRUdac1U3bHVzVlNzS08rR3k3RnFCcHpPYXZPMkFsV0VJRzdaNXllN2Zm?=
 =?utf-8?B?VmJ4aCtCYTYzeEFYaGd2OUJBNWhhMzVUcWpTMm1aZzJxRzdzVG14UCtWNmZY?=
 =?utf-8?B?dnhTOUFFUXVuSkl2M3JtZTlrQ1NtdDJET21oQzFqaWpTaVBmaEVMRUpENnNG?=
 =?utf-8?B?RGZrdk1NMlhFdzU5bFhxMERsWi9TUDBIUHU2VXN2bmEyZUF5L0czdlNVa1py?=
 =?utf-8?B?UW1JWVpLZmMwWGxla2VWbm5uWlhwY0svMjJzZzd1Zk43c3ZqR0U4UElOaFRW?=
 =?utf-8?B?cmZvaGJpbGh2TU5ERGJsS2hFblMxSklIU0pBVUtMSDRBZEYxSjFUN1lPYk1L?=
 =?utf-8?B?NGZwc3dCbnJsUmpwL1ZtTm1JWUdsazZlaDEwR2VIaFpuUEZDUkhCNUJxRmUz?=
 =?utf-8?B?WnpGNENKU2ZtRkQ0dWRvbnFVamczV1c4UEFhYVJVR1d6aDlYMFRxUXJyTjM3?=
 =?utf-8?B?bGR2emFIUUNrSkZJaE1pc2QrZjFzWW1HbHc2T0RLd2NXR1o4TTVPVms4QXJF?=
 =?utf-8?B?OVNTNHdtREtrVllDMEVUMXE1Y2hoNzZGeVZZVGRQZzdDbmZtalZxWm5xZ1ly?=
 =?utf-8?B?VFd4eXY5WjdmV3ZQSE5ETnNab3RBbEtHbGpNQnRsbjhva1FBS1R0TGVTZjQ3?=
 =?utf-8?B?Qk5HN2UrcE9TdXAwTHZZL01hU3F0Q2N5dE51SXQ1WTRtOUNmbkZPdWxvelp4?=
 =?utf-8?B?MDZYV2ZZM1p0KzE0U3JGSG1SS3RYc3FYcStsZHZUTmZyNEh6OVJQc0FtMlJs?=
 =?utf-8?B?SXdaSHVlZnZHQ3lwNWtySlgvakZXdzd5cnp5ZDRXWGxwUWNJVkVadE5LOEFN?=
 =?utf-8?B?eERTdTdsNlpoUmIxeXVJd1RRUWI4MXkxaWVDVzRkT2NwMFIrWWJwR3UxVDFI?=
 =?utf-8?B?Q3ZyQ25wMkY2KzdRT3dLallLTlB2cHpqVHllVmlMbVBYWDh3QXg3OHJsVFhY?=
 =?utf-8?B?M1lsZW9iUkFmS2tZcCtHZEw5Q0tZSzBHalRNQk1JMERhV0k4bFlPWlMyUlJV?=
 =?utf-8?B?emFScDQ0eEsvVDNYVGNHb2d6ODltbm92ZDNReU5UTFlxMG0wTTlYc1lHbjdT?=
 =?utf-8?B?UHl1aEszaXlvbldhZW44akxFckZrUFJObnh6RlQxNGFvbWk3cUtSZFJuNnFh?=
 =?utf-8?B?ZURKMjFUNVkrbVFhdWI3NnhMTHk3d0JzVy9FMmpId3g3dlk1V0ZnOUt1QlU1?=
 =?utf-8?Q?PJrc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcd67b4-ecc4-433a-c118-08ddceb1b16c
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 15:07:53.9745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayvl+6sLzPIAgE8ylyicmtxSw44pMeCVrZ9Aqw5CxkgmkptBg5nARFe9Tk3AOt7D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8718

On 29 Jul 2025, at 5:18, Yafang Shao wrote:

> Background
> ----------
>
> Our production servers consistently configure THP to "never" due to
> historical incidents caused by its behavior. Key issues include:
> - Increased Memory Consumption
>   THP significantly raises overall memory usage, reducing available memory
>   for workloads.
>
> - Latency Spikes
>   Random latency spikes occur due to frequent memory compaction triggered
>   by THP.
>
> - Lack of Fine-Grained Control
>   THP tuning is globally configured, making it unsuitable for containerized
>   environments. When multiple workloads share a host, enabling THP without
>   per-workload control leads to unpredictable behavior.
>
> Due to these issues, administrators avoid switching to madvise or always
> modes—unless per-workload THP control is implemented.
>
> To address this, we propose BPF-based THP policy for flexible adjustment.
> Additionally, as David mentioned [0], this mechanism can also serve as a

The link to [0] is missing. :)

> policy prototyping tool (test policies via BPF before upstreaming them).
>
> Proposed Solution
> -----------------
>
> As suggested by David [0], we introduce a new BPF interface:
>
> /**
>  * @get_suggested_order: Get the suggested highest THP order for allocation
>  * @mm: mm_struct associated with the THP allocation
>  * @tva_flags: TVA flags for current context
>  *             %TVA_IN_PF: Set when in page fault context
>  *             Other flags: Reserved for future use
>  * @order: The highest order being considered for this THP allocation.
>  *         %PUD_ORDER for PUD-mapped allocations

There is no PUD THP yet and the highest THP order is PMD_ORDER. It is better
to remove the line above to avoid confusion.

>  *         %PMD_ORDER for PMD-mapped allocations
>  *         %PMD_ORDER - 1 for mTHP allocations
>  *
>  * Rerurn: Suggested highest THP order to use for allocation. The returned
>  * order will never exceed the input @order value.
>  */
> int (*get_suggested_order)(struct mm_struct *mm, unsigned long tva_flags, int order);
>
> This interface:
> - Supports both use cases (per-workload tuning + policy prototyping).
> - Can be extended with BPF helpers (e.g., for memory pressure awareness).

IIRC, your initial RFC works at VMA level, but this patch targets mm level.
Is mm sufficient for your use case? Are you planning to extend the
BFP interface to VMA in the future? Just curious.

>
> This is an experimental feature. To use it, you must enable
> CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION.
>
> Warning:
> - The interface may change
> - Behavior may differ in future kernel versions
> - We might remove it in the future
>
> A simple test case is included in Patch #4.
>
> Changes:
> RFC v3->v4:
> - Use a new interface get_suggested_order() (David)
> - Mark it as experimental (David, Lorenzo)
> - Code improvement in THP (Usama)
> - Code improvement in BPF struct ops (Amery)
>
> RFC v2->v3: https://lwn.net/Articles/1024545/
> - Finer-graind tuning based on madvise or always mode (David, Lorenzo)
> - Use BPF to write more advanced policies logic (David, Lorenzo)
>
> RFC v1->v2: https://lwn.net/Articles/1021783/
> The main changes are as follows,
> - Use struct_ops instead of fmod_ret (Alexei)
> - Introduce a new THP mode (Johannes)
> - Introduce new helpers for BPF hook (Zi)
> - Refine the commit log
>
> RFC v1: https://lwn.net/Articles/1019290/
>
> Yafang Shao (4):
>   mm: thp: add support for BPF based THP order selection
>   mm: thp: add a new kfunc bpf_mm_get_mem_cgroup()
>   mm: thp: add a new kfunc bpf_mm_get_task()
>   selftest/bpf: add selftest for BPF based THP order seletection
>
>  include/linux/huge_mm.h                       |  13 +
>  include/linux/khugepaged.h                    |  12 +-
>  mm/Kconfig                                    |  12 +
>  mm/Makefile                                   |   1 +
>  mm/bpf_thp.c                                  | 255 ++++++++++++++++++
>  mm/huge_memory.c                              |   9 +
>  mm/khugepaged.c                               |  18 +-
>  mm/memory.c                                   |  14 +-
>  tools/testing/selftests/bpf/config            |   2 +
>  .../selftests/bpf/prog_tests/thp_adjust.c     | 183 +++++++++++++
>  .../selftests/bpf/progs/test_thp_adjust.c     |  69 +++++
>  .../bpf/progs/test_thp_adjust_failure.c       |  24 ++
>  12 files changed, 605 insertions(+), 7 deletions(-)
>  create mode 100644 mm/bpf_thp.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_failure.c
>
> -- 
> 2.43.5


Best Regards,
Yan, Zi

