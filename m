Return-Path: <bpf+bounces-59145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910DAAC6567
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 11:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D861E3AACA3
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876BD275852;
	Wed, 28 May 2025 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="INJun3pA"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628A0274FEA;
	Wed, 28 May 2025 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423601; cv=fail; b=egcr21x+Kds/GtMD8In2e4vV0mOr3q3V6+8d73mth5No6S3vYQUI7b3I894x8ewnqir4zWXH7LPJAofLVh24ZxO7+Mhjex+47n5ZVUz88hPjIf3xL8DJpy03nO6mo7mV3VHuToXy1bvXkaJUkwbyPiSF1X05hr+mo2s72vDamPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423601; c=relaxed/simple;
	bh=1BQgb7hzO07Poz9qIsEJDHbVDcYj7o0Nwx+eAGbISZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mbfz0ixsTjJ+mFuYQSs8mwfouJN7TKgClRJ/qVJKsj18i2hZP2H2m3/3gQB1SfSMQTw6y6MkhCR+rAjZp2MdTLgqibn3br1Wlw3wRXFD64z//16vav2H/JaXHUbD11wXK9ITvJrYi7Ez8sIFJoz5DEd+QJuWZ9h2aNX2sZADcbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=INJun3pA; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJnSkd6Nlj4MOPcTwWSWaRCYhA/wLceRa4MQasat6cAAvwTvKd9f0QXcv+JY0e9V2ZhV+E4AsYF303TYO70lccswb4GNfmSZIaaURrj7x2EbUzq+v01oqbpAzaOFCv5ush3nXRQuzEA5CkhSIQGQNrq+NCxDGjQGdDFpfIu3Bqy8aFugprphvxIQyBrt4Y0jPL65hmJVubvXpJShj4rx1uJaLWkCSDW0I6eWNFGvHXK1tpKRV+vrElzEusWrDbk6xfzjum8R6TzyQamqKyV1yjY+gmoZtBU82iTYld+onHxnRPQjlW9dNHwJPENQa5UisWx6o5YWQRaY08D/SAdUDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFZid2xbbXr4p3MH7mXZ5s5Vt3KbDn49G6w+tYv4ZXs=;
 b=Xg9n285vwtJqosts7S1OGKSwy4XpSYpj+ItLl36j9Jd+YZlrEagJsWDUWtoQWED6T4+JW+5/CjWyOEsxQjZblXx2MY+/9i81GwBf8lEVw+cbDsKmqnMF0CZ02Y35LkAmgySrosrxw1VJSvrnamsd0Yb0TmukFHe5pzvy9DYf3e0xZgqgWdy5pDcsXSOLuoWwKQy6cSfarMixh8CtxESnqPQlPyAG6g4P279jq+QaA+5ziLEvX50+exP0QlW5eNQtXuE2Wl8Bu9HxiqJPg9XXc0KZ9fnCmvPMplgKfT6uha1xlnE+EaSn2CiQGUi4XH9q+T7MhJ7wXG3A4FOFgqsO8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFZid2xbbXr4p3MH7mXZ5s5Vt3KbDn49G6w+tYv4ZXs=;
 b=INJun3pA2eTchwwngI3+p/WxZr86VyQOkH4ujiQOqLXqdQ6jGsdZpwOnzAjuplP/wxCcqok3ENGuA9e4oHSJZo023JwAtFRqb829t4CnmkaIAlC5kO7j1boKpDYV7lIz3n8XWEbp69iroaBzRANp+xH8WQbO7/2OocfjOhJRIAeTSO415pFXsnYhLGQJeTPESELgmXHgEKUsRuz6Cyir9G1fPRHBMg92Bb9Xa7rQiMY5yYSkLUXKCi1vrqmJpFdYhx/0vKleClKpTu5PHvK+SeNmIE38ZCeXgM0BmHN4tkYz3pfEkypuJZh8to13Ko2o9nEKd6DNZDg6Fu2EA+IeXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 09:13:14 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%5]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 09:13:14 +0000
Date: Wed, 28 May 2025 09:13:09 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next V2 02/11] net: Add skb_can_coalesce for netmem
Message-ID: <2bbqwlwi2b5pzd4ndss77xvomug5uihql45ctnpvn3r5k2b6f2@xxqv4bkh5vbw>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <1747950086-1246773-3-git-send-email-tariqt@nvidia.com>
 <CAHS8izOUs-CEAzuBrE9rz_X5XHqJmWfrar8VtzrFJrS9=8zQLw@mail.gmail.com>
 <c677zoajklqi3dg7wtnyw65licssvxxt3lmz5hvzfw3sm6w32g@pfd2ynqjkyov>
 <CAHS8izMM9Hgk12zhoc+ify1MBwepqByHKC3k1gB5daH=ancgqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMM9Hgk12zhoc+ify1MBwepqByHKC3k1gB5daH=ancgqA@mail.gmail.com>
X-ClientProxiedBy: TL0P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::18) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aff3af4-03e9-48d5-8d19-08dd9dc7e02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTYzNXpOZnBDbEVFeWQwZ0Z5RzZuRERJMTU3QlM3MFVCRzNCL1pVZ0ZJaHJp?=
 =?utf-8?B?NUtONGlZQ2FiNjVldnU5Yi9ycER1UVRCK1JrS1g3d25BblFHOTZsU3RHN3VT?=
 =?utf-8?B?S2UweExqS1dPUE90WVBKQ2swK2M0eEZ5bTIzZTNlaUNTdFdYa1VGMzkxcTRW?=
 =?utf-8?B?OE1iaCtxUk9SdlR6cTZJVXlNb2RPV1FJbHpPaUdCayt5bzlrVEltTFZGQ0Nq?=
 =?utf-8?B?MVpkdVNNN2NzdENXTU4xOVljSktyZkRSUnh4eWRLc3lXbXRNcGZoNjc0VlU5?=
 =?utf-8?B?blVLRE10NG5FU1g1SUJjM0RKUU1QODlYQU85a2wvV1JucnVOVFBNd2tVK01u?=
 =?utf-8?B?OUhFNzVrQ2M0WWJoSlR0MlJURnNwRlhzeDFvOEJLVjRtT3p1a2xjNzltV0hX?=
 =?utf-8?B?VnhKQlpNeWJzUCt5amwzTlNzVFo2Zytsb05YeElxcWJEc3FRb250bjZZUEZP?=
 =?utf-8?B?WGRkV2NZSTNPTENRU0ZEdDgvYnplUzhNYm9IbFh3TmNjYm9YcGRkVjNCWERT?=
 =?utf-8?B?c2MrMTVtMFp4WXZxVXJ2WHBYdEhxQ01XSWlxalBrSjJVTHNRMnVOSzVSYVNu?=
 =?utf-8?B?eUlMdFJjb2Q3TjlySk1GQStFeXloWlBMV2RmOW9GNmIyMW9ZSnpEdUpLVEsw?=
 =?utf-8?B?RTJzQ3ZUemdJajAwUnIyVkpQNUxCUGh3TWRVOXRTRG9GdHpMZGZoV0lveHVP?=
 =?utf-8?B?TFphMnV4VHJJc1BmbVJ2VDdFdW5ncnlZUUc4dUpKUjd6MmtRTmxMWXo0dTgw?=
 =?utf-8?B?ei9ham9KeDNjSFUzc3h0L20xa1g4UlUzbEVuQ2EyaXB6Y210ck1DdE9EVG5o?=
 =?utf-8?B?T2RzaGtrMEdqZVBjb3NhV3hIOFNDYmZNNjFYMjA1em91SkFuaUN1YWt4dW9F?=
 =?utf-8?B?dVZqTDBmZGo4RVovWkdDeXlzZisxYTNLNWwybzNJMGZ5bE1wMzRHSGJRelBM?=
 =?utf-8?B?NGlIdUI5VFhsZ1FlYWpJaVgrZ3N6YUtzdHN0Q0VPOUFpK092MWExbGljaHMz?=
 =?utf-8?B?ZEF6eUl6UG9SOXZLVWwxNFhLMmZtRHJnakVaMnR3YWxvVGFyNWFNZWNaaWVE?=
 =?utf-8?B?MDd2anFzZ2xuMys5N0VHeFN3dU9pZG51YTVhNGMvTWFIWjVySTN5OGZ2QStJ?=
 =?utf-8?B?emw0SEpGYkd4bWRIcHZ5NmM3VVg5SFdpVXNmckRPN2J6T1A4bThZb1FkeXVz?=
 =?utf-8?B?bzdmN3p3eTgraDVZTWFQUUtlcXhGTVBRQkhJOGFvR2FzWitNWFRaSVhsdktR?=
 =?utf-8?B?OTU5ZFF4Z1FtZ1RoVWo2ZitJSVhhdmptQ3F3VXgyVFZGeUJJNmdqWXBXVk5M?=
 =?utf-8?B?TXp5ZUh4emNIVWJ3YkRBZDZwaW5ZZE1CVDZST2RrOXQybDBQZm9uUy9jbzdi?=
 =?utf-8?B?cU9QSUZlUVFDVEF0OStQWG9mRHI0am5aR2pkZnNSUzcwekJaenRrdHptS2lR?=
 =?utf-8?B?SHVkeEx3NGpPZWpVRHc3M21YSDlLVVpFWDZnZXBMeUVYOXlUWHhUalBGckVk?=
 =?utf-8?B?akp5U2Vvd1BaVngrcy9zVm0wUHdWZUFDQjd5Z3QwRVIxZ01FNDlaQjJyTUVk?=
 =?utf-8?B?RGwxMjRZeFMyUzFzVGNVL2V0ZlRIUSsxN3ZJRmxqTEowcm90ZysxVmVTbldM?=
 =?utf-8?B?RXF4VVcxaW5vSzNFaGRBYVpuTFduaExtTFRhTjVNdWlzVFJBVnFVQlQ1RG83?=
 =?utf-8?B?R2g5cUozWXpudUtiQVV3dE0yMjkrcjF5VU9lV0F3UXMzb3lnWFBYeW5KRy9G?=
 =?utf-8?B?bDhzeHFDT2pnRkN0cVIrZTRaaXpQaElnclBhS2FNUDFYdDBBNGE0NDdnVWE1?=
 =?utf-8?B?OTROakxEckxBQTcxR3BjeUZXQWtiQzBxZFY3M0o5MVJuL3BsMnlhYWIzK2lx?=
 =?utf-8?B?K080UkJ3M3JJL1c4SnUwMEJBbmRtZ2FISzFranVjVnlnWGs2SkJzV3VsLzRn?=
 =?utf-8?Q?WuQ7/9avS1A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2w2QXlTUjI3M1VVVWo2elF2Y0hDZjBveGg2UEtMTU9NT1BvenNURzJWTXFh?=
 =?utf-8?B?K29raW1hT25RSUw5S08rUFZxUTl6SGJqWURLM2FValQ5aTRGUmRVUVdocGRR?=
 =?utf-8?B?MGE4NGUxbVNHSnhDdHUyWXV3L2FzUm9US1I5ckpkeXJJdWorL1NmRUgvZzZZ?=
 =?utf-8?B?cTR0ZEgyYVRpSDVOZTFNMndOUW4yTDc1VFFlbHdseWpQV1Q5TEpCVWpFZ0J1?=
 =?utf-8?B?TnBCL2JYa2c0QlM2OGlxS0oxS0JnTVlaWTloZW5YV1gzdXBNbUtzZ1JMOTdr?=
 =?utf-8?B?SnBEeDk0Q1c3bzliK2pIaTFDRVVXcHhScGVDSWZuQjYvREN4TXp3eUF6S2Zp?=
 =?utf-8?B?TDI4VUJSdXVySXNqSVZqWHBydEdGcTVwOGJvMWh5bW5pSTh1R2piUmNqczZM?=
 =?utf-8?B?cDcyaUhFZmo2NGVIYU1kZGhsWDZFaEx6bWhkQThwOS9LMmJTamFYdnRnSUhP?=
 =?utf-8?B?RUJPUjZrOFJ5REVDZURLMHl1elc3cmdrdXcwM0NOQmVOaTdwY3N3OUxuTisx?=
 =?utf-8?B?YzdSMFR3Z2I1MExKZ1pmUjFMTWtmbTg1N05RaUlSb3A3T3BHQkkydEFEL1Fz?=
 =?utf-8?B?QW4xdTdMNFJKTThSekZFZkp2RjA4SU9iQTl5eXNxRmw4YysyK0tjbWtNUi81?=
 =?utf-8?B?a2NZNjRCanV2WFE3ajVJc2JUd0czN0ZVVzF1V2h3c3hqK3ppT3RKMUNZWnpu?=
 =?utf-8?B?OFA2RDhDZGZpR2RzU0hSZXpPVlZGMnl4WnFkU09oUVBQcG5pWUVDSFVqVWdN?=
 =?utf-8?B?enZRclVZNFlwYjlaUnhsMkxibWRHWURNanpoNlA4M1FrZzFqS2YrbW5CeEFs?=
 =?utf-8?B?N2hIMlBmWjdMQjUzMHJuQUdoL3FrSGpRNG1INmwrS3NZKzhlWG5sVG9nV09M?=
 =?utf-8?B?V1JxcEpQc3hHdGFqalFFdUxTdTNJc2plTmpmNTQvVXFMQU10aFg4Qlo3QVRu?=
 =?utf-8?B?V2dxU0JvMzR2YUdjMXZqMktHRWtROGd5Q0g0eXZZcHBBZDRqazB0UTJtN3lO?=
 =?utf-8?B?ZWhuaDFmaW9PeS9aQ3hvdGt5TlM1Y2QvUklFWG1jQWJIZHNoZ253Ymc4alFJ?=
 =?utf-8?B?eW1NaEFTYTFCcUkzb25uc1R0VnBVOFJKR1JTM2tZMmdtaG9LWXE3ZlE0cklB?=
 =?utf-8?B?bWE5SDNEZVRaeXFBQXNJUDlqWjVwK1ZidWZCNkZ6alBpVUZDaFd0TDJoWGFQ?=
 =?utf-8?B?VnVaMVU2Nytpd1dHaGZkcFVIcXNWQUhQaFhhdHp0OVZyWndqa1pnaEJOMms5?=
 =?utf-8?B?UEZ0ZWtpYnR1RFhxanZSZXRnNGFjS0lLVEV2RXp6dEhXdTZveFNMdllTSUx4?=
 =?utf-8?B?TTVCbzY2TUZxcXdLY1gzaEhWWHRCYXF1VHphUHRwKzh3aDJjTktnTmswVVRK?=
 =?utf-8?B?TUM2cGxqTGxpa3RtbHZGcXJPZ0gxVHdNUEhNcU5ocC9oN3FNZ0dSNEVrQjdn?=
 =?utf-8?B?NUlpbUlqQllEdUYrVXBIU0JDOVkxVEZOeUNqbVp6NmZQWU8zMTZPcGNCT0RZ?=
 =?utf-8?B?ZFRkZE1TeWlKOVRoYThPVGlpQmU3elQrL1p1QnpmL3BuamdSalNlMFRsU0hw?=
 =?utf-8?B?UXRBNExBTXl2V3BzMFZ3V0ljQS9aRXhoVVNtNmVRM3hjVlJiRk1hVVNTbnJQ?=
 =?utf-8?B?VU5ZZFUwS2tnOGZQMzlTSGlDWXlPNW5wZXBrUFhYRUYraHlZMmhyUE5mYUJK?=
 =?utf-8?B?UTdSZTBhWlpxbVFUVFJaMi9ycHQwN0RBYS9mdjlrM1VEeitTUis5cXA1cXgx?=
 =?utf-8?B?VEtMNnVLejJGQVJ5RStYU2tmdld6MURYeEZnTkpxampoQm8xOXk3aDhHNjV0?=
 =?utf-8?B?eDlMd2tEcWg4RzJidThZb3QzYlp0WTJQdkdJcU9DRE5HSDZMVkR4ZHdpenJu?=
 =?utf-8?B?OFhTSDY2MzJCenFEVEh4TjA0L0NYd1VHZFZwcU9UZk9aWSt0WWpQeTE0eU1h?=
 =?utf-8?B?NWNqY09EUzFYOEZRN2FvZzZzWmtSMEdRckJKQjRCZWFpQVN0b0VKRGNYWDgx?=
 =?utf-8?B?UjZXWWcvdlRWV3ZTWXdycTN0ZVhHWVdGUi93MzdIeVppL3FsNHhSNmV1RTh4?=
 =?utf-8?B?NXE4NG9CUGh4anRPclREWUVreGRLei9reUsxWWZRQktDRWpsYUp1dXJMSEVy?=
 =?utf-8?Q?e1483u5WPYNKcWmgf6q/pehJ4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aff3af4-03e9-48d5-8d19-08dd9dc7e02b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 09:13:14.4328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kN1eHhTM4q7oCdtYQVIeZq++ns+iK2F70y/Jqg4a/PoX28lmfmOeSRLNn6cJ0SnPs9FUbaEZNf1f2i3QWY3tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564

On Sun, May 25, 2025 at 10:44:43AM -0700, Mina Almasry wrote:
> On Sun, May 25, 2025 at 6:04 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> >
> > On Thu, May 22, 2025 at 04:09:35PM -0700, Mina Almasry wrote:
> > > On Thu, May 22, 2025 at 2:43 PM Tariq Toukan <tariqt@nvidia.com> wrote:
> > > >
> > > > From: Dragos Tatulea <dtatulea@nvidia.com>
> > > >
> > > > Allow drivers that have moved over to netmem to do fragment coalescing.
> > > >
> > > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> > > > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> > > > ---
> > > >  include/linux/skbuff.h | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > >
> > > > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > > > index 5520524c93bf..e8e2860183b4 100644
> > > > --- a/include/linux/skbuff.h
> > > > +++ b/include/linux/skbuff.h
> > > > @@ -3887,6 +3887,18 @@ static inline bool skb_can_coalesce(struct sk_buff *skb, int i,
> > > >         return false;
> > > >  }
> > > >
> > > > +static inline bool skb_can_coalesce_netmem(struct sk_buff *skb, int i,
> > > > +                                          const netmem_ref netmem, int off)
> > > > +{
> > > > +       if (i) {
> > > > +               const skb_frag_t *frag = &skb_shinfo(skb)->frags[i - 1];
> > > > +
> > > > +               return netmem == skb_frag_netmem(frag) &&
> > > > +                      off == skb_frag_off(frag) + skb_frag_size(frag);
> > > > +       }
> > > > +       return false;
> > > > +}
> > > > +
> > >
> > > Can we limit the code duplication by changing skb_can_coalesce to call
> > > skb_can_coalesce_netmem? Or is that too bad for perf?
> > >
> > > static inline bool skb_can_coalesce(struct sk_buff *skb, int i, const
> > > struct page *page, int off) {
> > >     skb_can_coalesce_netmem(skb, i, page_to_netmem(page), off);
> > > }
> > >
> > > It's always safe to cast a page to netmem.
> > >
> > I think it makes sense and I don't see an issue with perf as everything
> > stays inline and the cast should be free.
> >
> > As netmems are used only for rx and skb_zcopy() seems to be used
> > only for tx (IIUC), maybe it makes sense to keep the skb_zcopy() check
> > within skb_can_coalesce(). Like below. Any thoughts?
> >
> 
> [net|dev]mems can now be in the TX path too:
> https://lore.kernel.org/netdev/20250508004830.4100853-1-almasrymina@google.com/
> 
> And even without explicit TX support, IIUC from Kuba RX packets can
> always be looped back to the TX path via forwarding or tc and what
> not. So let's leave the skb_zcopy check in the common path for now
> unless we're sure the move is safe.
>
Makes sense. Will be done.

Thanks,
Dragos

