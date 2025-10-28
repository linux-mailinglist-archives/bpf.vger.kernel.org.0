Return-Path: <bpf+bounces-72478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E095C1294F
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 02:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7911A6768C
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 01:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF6F25D528;
	Tue, 28 Oct 2025 01:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rkFyW4yQ"
X-Original-To: bpf@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2E51C862D;
	Tue, 28 Oct 2025 01:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761615926; cv=fail; b=Halky1zG9Bg0xtUpFo9Iff9g00wYFJ+34nJCDzcAUAQyyNE21A9VRZXxAXqRN+ankEy75k6+0i9vg2R/hY9A6CKEhq4oJwnnMB2MM8d99t4RUowltDuzQHZyfeKtNLPvT9TZ90FsGr4/4OtuxMXWAVA8tapW49zMk6b5efW/Bns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761615926; c=relaxed/simple;
	bh=NUqT/nezGtLdy5IfQVYeWXyY3tqClFHnUUZyltqhbvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F92menANr4bgy50ZROiy0QiQD6GNQgNBeF1YYkW6ByQ5LELsfrRHe8eZ39bln3tf3ytHBCuwqydyaCTuXebp9IPYc4B+jQYH+cPu11rDasFTlPAaSlpCtVBQ6Q7pFQtV8qvk1bVubNDEi5qi5bq68rSyvNJkXlrjkYI7rgSWxq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rkFyW4yQ; arc=fail smtp.client-ip=52.101.53.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSx4oamWJNgfNXm+R+FnTzjIbWgR3ktj4Mz6pYkrPAghMtLVV8VCvLMW9bdm6NXuRG/hQF8mK7uGzlw9Zr4vo6VcLDs1Vgo5oNkhYYKhd0IdRUwLINhcu0SOQtxGcs4osivNJpv7o5e68Q2/OQ2nEAEMhgI94QAYNkz6QEtWKz8kATfJrXODQK2QRVYgTVnox+iJHPYKBqsbtVOx1/aKzeUXQJMQA/KRz+BLSgMv7rI+m90w9GxNOrevklmfNVj8JW+siHIv7sEvnhDcQQFAM6G/27/0bJSNqw/69WYqPMokMPxsGPYDJ/SWyrnAH5Izv5HszvdEWZnmrxhk+CJb+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ud9O1uixdlQe2iCK7qWurbaPA5koJSUBtKJQnyAKLMY=;
 b=zQvUepQFejWxABU5NcW6GTyvHDOFSvHBZZUWYvSUhSmY58f/w/pY1kn9Vuv2ImArhphUd2vTAPVbLkHKD0cB3mpxRFmidWVNeyFFVexTzd+7g6aF8ZZpJNUkRMz3qq4UiEvd9XghxNUa0tq69IGf19VzaIT0WRb6NHFDk2moOhGj4FeiaXa0aLBIhcTze17gwTgdGz9VnbpAFrnNSpEL75IMP7Eu0+9fTDcLfd9ftmXOo4Lfe95c4d/O5WIANbgko14dbYsKURXWLNM7YIFOv+NefqwY0dJRoBw0zPANW6euFI4dVyn1JzyvidfhtUTyfNh+iVIv+u7d8JEH+XshBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud9O1uixdlQe2iCK7qWurbaPA5koJSUBtKJQnyAKLMY=;
 b=rkFyW4yQN6ndwKK5xd/q2mUodbH2WC10IG1RJFZDMDxEThcy+H7dQLbgSj+bcXz7/llGZbTLo1bimMgJ3nfAcDYOWxQfzy4oBjj6XprKqN19DyLR8L1mtrzinTjpZzsNNorC5OUIDy7K5yQGLB8ZGRRJRlCRIlFUtvASthy3wWrO8WfBJsJNjYFiONEEY99w0r5LVxHisHkHXwLfdDcJoaI6YiwKSuox4o0n3D6aYrVGRidew9aND79eK73Cx/IY6lGeDAXKLLlKsRXB4bqgGMySoMWXDrtY2XvNoBqV5ANHT56ynOUXeneJyHZIM9GrGJSiN27IJclhyt7u7Zx4yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 01:45:19 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 01:45:18 +0000
From: Zi Yan <ziy@nvidia.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch,
 edumazet@google.com, pabeni@redhat.com, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
 ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org,
 kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com,
 baolin.wang@linux.alibaba.com, toke@redhat.com, asml.silence@gmail.com,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org, sfr@canb.auug.org.au,
 dw@davidwei.uk, ap420073@gmail.com, dtatulea@nvidia.com
Subject: Re: [RFC mm v4 2/2] mm: introduce a new page type for page pool in
 page type
Date: Mon, 27 Oct 2025 21:45:15 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <64E18E02-727B-47C4-8849-486AB98CACD8@nvidia.com>
In-Reply-To: <CAHS8izME4W3ENXNXf4Cxegmk9xnRmKajpRMQ18L0=FGTFebeaw@mail.gmail.com>
References: <20251023074410.78650-1-byungchul@sk.com>
 <20251023074410.78650-3-byungchul@sk.com>
 <CAHS8izME4W3ENXNXf4Cxegmk9xnRmKajpRMQ18L0=FGTFebeaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0417.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::32) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ea4b62-9cbb-4ad7-2cec-08de15c3a64d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2JLUzRUc2sxS1NrZVZBRkQ5dS9FM2lDVVd4ZlhVSXA0aENQWExZQm1TSEJk?=
 =?utf-8?B?Mjc3b2VpZEpaanZ4SVJ5OGxCVHB6MkVlNjRGZXJKTFRhc2lRazZpQmxnMXdH?=
 =?utf-8?B?NWVaZlU4cnFrR3lzQzd5TjNzdit1TCt4bmZ1VWY2OC83Y0pmUTYrTXNSQWZn?=
 =?utf-8?B?bVFHRHNaSURMOVRCaGU5dmlYVVc1emY2VWNGRTA0RjZUaWUrSGI5NWQ5SkM0?=
 =?utf-8?B?b3NMTlZRUXo3U1c5aEZmTUFMRjVvNGovczhoNER0RG5mR3lQbHppcnpaU2x5?=
 =?utf-8?B?bkxKOEdaWEJRd2t5ME5TM0E2bk9YQjcrQVF2UXc2Wm5GQmpPa0Jvb0p4WURh?=
 =?utf-8?B?MVNsMDFSYU1yRGhJbE44K0xzbXZOYUU2Z2p3bTAzUXJ0cWxJdGVSaHhTT0pO?=
 =?utf-8?B?Wi85bmhsNHhUNFhoOVdvcHNlTkR6YTIzT3NTdVdFK3pTMzI1cWpJcnBWT09x?=
 =?utf-8?B?OVdzYlJFb2t6ajFBL0ljbnRDVzM2c1VESU01eGllN2FNKzJrbWhKM240ZEhx?=
 =?utf-8?B?OFRvUWNhZ0NwV2R6b1Qrd3kxZHRRNFpJTXJ2ZXMzdHdKdnd1MFBjWENtZmlT?=
 =?utf-8?B?NW95aUZrRXIrTkRyeGVLTUVTUU9nMWdMTFRrRGhUbzdmdUZsSkxwRnFIQzhq?=
 =?utf-8?B?dWNtMWZsM0FOKzQzeFJmOE1ORXdhelRBNFh4S2E5SjRkelpvdnJibFp6UVNE?=
 =?utf-8?B?UzNpVlpUYy90UktqbGdXWDdOWkJQSnREODJtcTN1eXgvRjVIQ05RMXgyUzIy?=
 =?utf-8?B?S3pBMU42V1cwcWRlT0xVTk5CZHhrdTJ4NytRN2Z3c1ZOTWdnZ0FrRjJuZEJU?=
 =?utf-8?B?L2NlZVNUZHUyMndCWmc2bkpSZUhNbDV5YzRHS3VRUEU4dnBOQTM1NFkwNWdt?=
 =?utf-8?B?Q1pKZTlzMmJwaW1LTVY4ZDlseGQvWDJUOUd1bUxLMDRVbkJoNWNXYUZIQ2c3?=
 =?utf-8?B?Tit2YzBlcEVQQi83RzBSRUk2dnUzTDVuRDlDc2VIaWdQSDNNdGZaTGR3eGxE?=
 =?utf-8?B?YldtWkxidjgzS1FReFlQaCtSR1pwMXpKWkVvMFAzN2s0WnN0OCtMTTRHWXhP?=
 =?utf-8?B?TXA1WDZNNHEzSnM2OE9oc2k0RGIzMjFtaFZ4NDNKaDlPTTRNSUpDUm8ycDd5?=
 =?utf-8?B?bGdQZWk0ZDRpeDhmS2lvd2NIM3RnSGFCSU1FQVJPVTdiNHd3SkVpVjVlMDRU?=
 =?utf-8?B?SHJTeEdNcHJKZ3Mwa3F4NkpUdFJYQ0hxTitBb3kyYmVSajVPeDg5bEVNZWNx?=
 =?utf-8?B?aXoycXpHSFFtQ2hjZjJTZWlGYmpGd2E4LzYvSW9GNTJheFFuUVhvSVJ5c1k4?=
 =?utf-8?B?bU5acXNnczFaWmJDS0c5MlF4M2g5c0dvUEFqMnMrTDEyakg3eVhFKzF2Z0pr?=
 =?utf-8?B?TXFMTHhjdTRBUHhpcFpkcmpxS0ZRTitMQWF2TkJqaGU3VEpwNFloSkU4MTlH?=
 =?utf-8?B?UXhrZzNGZzRlaTF3ZkpScVF4Qy9QbEJDRWFEdnlwVzMwMEMrc0hyTDhoaHkz?=
 =?utf-8?B?K2p6Rjl0UkNVSWVUSTNwOU1UVWp5OE5remU1YnkvZ2hNY2RhcVZJWFZIN2pG?=
 =?utf-8?B?Q3VDSHc5SkhpU1QzVGRBMWxhdjVWbExjOVI3cTJ0QWc4NEVmalRBaWZFd3A1?=
 =?utf-8?B?N3BvVVkwQ2NCdnpzaUdld05FcEpldjVTd0lLM3dneXRPQnRTLzZBOGhpVEpQ?=
 =?utf-8?B?NTREcW1KS2tSNVd1YXFXSFZIbUgzcHk0Q2o1bVNWL29BKzl1cmszenlIQ1Nu?=
 =?utf-8?B?NVNKa295UE1aL2ozeWZ5RTVQb01XL2VlN1JHNERhazBvL2VSa1h3MjZ2c2Y5?=
 =?utf-8?B?dDZMM0k3bFI2WFYxN1FEa3VIYURtMUswZ2ppWE9jYkVuUjVleVVMMjhyRE1V?=
 =?utf-8?B?TUN5YW1PWkV0NjVkMDFZOVhtWXR0UUtxVDdyM2dYQkZFT1AyZkpTZitGRHN2?=
 =?utf-8?B?VVVDbXFGeFJKK0kvYk9OcldWUVZrZXRncUpVRFV5d1BvdnAyemw3cTlKYkVz?=
 =?utf-8?B?UDBTbXN2bTJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eSsxT1VIWTJYSUwzL29OUmNkNlIybjJ5c1M4Z3E2ZjNoV1paWE9oUUU3cHVq?=
 =?utf-8?B?Z2VNa1hIdyt1dlIrKyt3NEZyVk04MVhNTkV6bTZRcUVGZUp5aUx4d3gyeXJh?=
 =?utf-8?B?RmhQWE1YcTJvQzNrcnFVczBwOWQ1MDhoMURqb0dLTU9HdS9jeksxU3Q4L2px?=
 =?utf-8?B?QnNBRWN2a2tjWFdQTVlqN0RRZ0hHdXJBMFpiRUlmMVRSeHNwaTlMYVFaeFJE?=
 =?utf-8?B?V3JSbHBkSE5oNVEzRFkzZmZhdGlEK0xrTS94MFFOSUM1K2lhV3VpSUViUmVV?=
 =?utf-8?B?aDJEQjlIRkg0blVMTDNPeUtWV3NIbm5XbHFrOElDcHpTNlFJaE5NeXFaM2Z4?=
 =?utf-8?B?Qm02ejF4Wi9UaUdIYVdBYW5TMlIyTzhCZXlkdi8ydEFmdVpJTUVuaC9OTGN0?=
 =?utf-8?B?V2dzU3U0K2s5dlNtbS92V3MzUWNmWFJJU0xPc1RPZEhpTTNQdG1tYmhwd2hH?=
 =?utf-8?B?ZUdkcFVQZVJPdjFkb3RuaXd2bGNQM2Vhc3dIYlk2Ky9RQ01RcCt4Zk5GRENK?=
 =?utf-8?B?d1ptVlRhSEFhZzlLV0VSbkRpcWJmZzAvMWU0NkQyMHB0UWJZbjQxdDdBVFpI?=
 =?utf-8?B?ZmFIRTlCdGErbS95bFhZTUpKWFlZc3ovMEt4MEp3SVdYTHNJODNsczN2TWdU?=
 =?utf-8?B?WnRQNm9QRXFGc1pmNHFuenlYK1dDenpZeTBodmFEczZJVDdYd0UwQlM2cnRE?=
 =?utf-8?B?VjNMVXN6bnNzYzVYTkpxVm5TUzhpT1ZwMER2Vis5enZFWDBwVHAvRkxyVWt6?=
 =?utf-8?B?UU1OSEVvWUNrN2h2OVhYTkFDem15MURKa2VucjhWQ0ZYL2xwbmsyM1U3Z2pv?=
 =?utf-8?B?R2xlNXZabzIxdUtFV2JDN0NwL1VlWmRqQngraUJ4V0pHYTZSNEhJaHk4bThW?=
 =?utf-8?B?bU1sckFOKzJFMmJnVXk4c29NQzBJU2c1Rk5aUFN6NzFwb1NEcWNrMUNHemVw?=
 =?utf-8?B?WEx2RXFYYWpiN0tsRWNmdmlxTXhCT1JRcktNUnYvSUpKREZXbjI0M2FKWmND?=
 =?utf-8?B?UTZFdU5LbVBMYjVRQ1dkWDVZdkMrZGY4U1hZSWtBT2I5RE83WkFjL1NLc2Jk?=
 =?utf-8?B?S2pwSVpqNzNNN1hpSWhNSzVtT1FXb3hCWThvMm95NVExMWEzNHlNajdpUEow?=
 =?utf-8?B?WlovQlZDOEpTMnhpbUlzd1Jld1R4eDI0SWFtaUVJdmM0OVluaExwTHd0N0dC?=
 =?utf-8?B?aU1hU094dE9sUUlqRVFUNzdOYjU0bEhjc3ZyTTBuYTM5NHRkUHJWcDhJZkxq?=
 =?utf-8?B?T3ZXd21iUGxVd0xJUkRneGxPeFBxNFRqZ2hWeHRsa1psUFk0MzlIQXdVODI3?=
 =?utf-8?B?ZmtjVzZwVkFHektXQXM1MG14emhuZEZkRkx0bDZrdHdxenpKSkwyMDZ1clor?=
 =?utf-8?B?VmhjZk9PTlFnWFJOQzByODhKeG9qaVViWTdhQUw4M3d6ZC9mUWwzdWV6c3Ev?=
 =?utf-8?B?Q010bnhQUDllZ1o3a21ONXZkT2p6NUg1Y3BrZ2hLdWhKV3lNdmZEUndtUEU2?=
 =?utf-8?B?bks2TUNmaml3MWdxTFIzRm51ZTB3UmpaNnZuaWtBaEVjY1JzZU5OcGRpNXkx?=
 =?utf-8?B?SGY0b1RSTk5oeXFYeDZzWnVuTkcrSVo2UHY5cklPWVVwUzVwOThvWkZPMjMv?=
 =?utf-8?B?OVl2TjhtcWZ0QUhGTXg4R2Vya1BWN0c4eWkwN0t6dndtSnJkWTk4N21xSTJ5?=
 =?utf-8?B?dURNa1hYT2dSMDRBUnZ0VFVSZXBiNllkaGFMQTVUYjhsT0xsQ090SDFOODFF?=
 =?utf-8?B?Zm9LaGp6WVQvdGpzMnppaEFsRFZCazlBYXk3Q09qelZyLzFQTEJLeXlNMVJp?=
 =?utf-8?B?Q3ZrekRmbDFaTlkyOG5hMmkreUlCNkUwTitxeDJDcGNvMTZaNjBpRlBvcFRR?=
 =?utf-8?B?clp6ZWpXSE8xOHhLTGhjdkdMbS9DWVd4eG94ZnlTeEt1S0VtUzBvNmkxcDQ4?=
 =?utf-8?B?M2RDY1l4eldFTFhmcU5uM013Z3M5b05DTVFlK3hrWlZaV1ZlSmhGdjZ1L0Z4?=
 =?utf-8?B?V2NKS1VTTERzUUNiRHYrK0dvRWV4RHRjYzZocUxkYU5EVnhhenE3M2VyNHNq?=
 =?utf-8?B?UXQvNmtGTlZsK2xRZkJxbzJ4ZnNYN0VONUpocCsrc3hySFZMSys4UGRpU0dL?=
 =?utf-8?Q?CvWAsW/ruemfA9Phl7mdkUV6+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ea4b62-9cbb-4ad7-2cec-08de15c3a64d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 01:45:18.7697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pHwn86y9X6+M25hxWLoBxGI82BfjcBqnvat2Hk/mwJLQKOHZYlvbxfW4QAkniO7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301

On 27 Oct 2025, at 21:28, Mina Almasry wrote:

> On Thu, Oct 23, 2025 at 12:45=E2=80=AFAM Byungchul Park <byungchul@sk.com=
> wrote:
>>
>> ->pp_magic field in struct page is current used to identify if a page
>> belongs to a page pool.  However, ->pp_magic will be removed and page
>> type bit in struct page e.i. PGTY_netpp can be used for that purpose.
>>
>> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
>> and __ClearPageNetpp() instead, and remove the existing APIs accessing
>> ->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
>> netmem_clear_pp_magic().
>>
>> This work was inspired by the following link:
>>
>> [1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gma=
il.com/
>>
>> While at it, move the sanity check for page pool to on free.
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Acked-by: Zi Yan <ziy@nvidia.com>
>> ---
>> Hi Mina,
>>
>> I dropped your Reviewed-by tag since there are updates on some comments
>> in network part.  Can I still keep your Reviewed-by?
>>
>>         Byungchul
>> ---
>>  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
>>  include/linux/mm.h                            | 27 +++----------------
>>  include/linux/page-flags.h                    |  6 +++++
>>  include/net/netmem.h                          |  2 +-
>>  mm/page_alloc.c                               |  8 +++---
>>  net/core/netmem_priv.h                        | 17 +++---------
>>  net/core/page_pool.c                          | 14 +++++-----
>>  7 files changed, 25 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en/xdp.c
>> index 5d51600935a6..def274f5c1ca 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
>> @@ -707,7 +707,7 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq=
 *sq,
>>                                 xdpi =3D mlx5e_xdpi_fifo_pop(xdpi_fifo);
>>                                 page =3D xdpi.page.page;
>>
>> -                               /* No need to check page_pool_page_is_pp=
() as we
>> +                               /* No need to check PageNetpp() as we
>>                                  * know this is a page_pool page.
>>                                  */
>>                                 page_pool_recycle_direct(pp_page_to_nmde=
sc(page)->pp,
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index b6fdf3557807..f5155f1c75f5 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -4361,10 +4361,9 @@ int arch_lock_shadow_stack_status(struct task_str=
uct *t, unsigned long status);
>>   * DMA mapping IDs for page_pool
>>   *
>>   * When DMA-mapping a page, page_pool allocates an ID (from an xarray) =
and
>> - * stashes it in the upper bits of page->pp_magic. We always want to be=
 able to
>> - * unambiguously identify page pool pages (using page_pool_page_is_pp()=
). Non-PP
>> - * pages can have arbitrary kernel pointers stored in the same field as=
 pp_magic
>> - * (since it overlaps with page->lru.next), so we must ensure that we c=
annot
>> + * stashes it in the upper bits of page->pp_magic. Non-PP pages can hav=
e
>> + * arbitrary kernel pointers stored in the same field as pp_magic (sinc=
e
>> + * it overlaps with page->lru.next), so we must ensure that we cannot
>>   * mistake a valid kernel pointer with any of the values we write into =
this
>>   * field.
>>   *
>> @@ -4399,26 +4398,6 @@ int arch_lock_shadow_stack_status(struct task_str=
uct *t, unsigned long status);
>>  #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIF=
T - 1, \
>>                                   PP_DMA_INDEX_SHIFT)
>>
>> -/* Mask used for checking in page_pool_page_is_pp() below. page->pp_mag=
ic is
>> - * OR'ed with PP_SIGNATURE after the allocation in order to preserve bi=
t 0 for
>> - * the head page of compound page and bit 1 for pfmemalloc page, as wel=
l as the
>> - * bits used for the DMA index. page_is_pfmemalloc() is checked in
>> - * __page_pool_put_page() to avoid recycling the pfmemalloc page.
>> - */
>> -#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>> -
>> -#ifdef CONFIG_PAGE_POOL
>> -static inline bool page_pool_page_is_pp(const struct page *page)
>> -{
>> -       return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
>> -}
>> -#else
>> -static inline bool page_pool_page_is_pp(const struct page *page)
>> -{
>> -       return false;
>> -}
>> -#endif
>> -
>>  #define PAGE_SNAPSHOT_FAITHFUL (1 << 0)
>>  #define PAGE_SNAPSHOT_PG_BUDDY (1 << 1)
>>  #define PAGE_SNAPSHOT_PG_IDLE  (1 << 2)
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index 0091ad1986bf..edf5418c91dd 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -934,6 +934,7 @@ enum pagetype {
>>         PGTY_zsmalloc           =3D 0xf6,
>>         PGTY_unaccepted         =3D 0xf7,
>>         PGTY_large_kmalloc      =3D 0xf8,
>> +       PGTY_netpp              =3D 0xf9,
>>
>>         PGTY_mapcount_underflow =3D 0xff
>>  };
>> @@ -1078,6 +1079,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
>>  PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
>>  FOLIO_TYPE_OPS(large_kmalloc, large_kmalloc)
>>
>> +/*
>> + * Marks page_pool allocated pages.
>> + */
>> +PAGE_TYPE_OPS(Netpp, netpp, netpp)
>> +
>>  /**
>>   * PageHuge - Determine if the page belongs to hugetlbfs
>>   * @page: The page to test.
>> diff --git a/include/net/netmem.h b/include/net/netmem.h
>> index 651e2c62d1dd..0ec4c7561081 100644
>> --- a/include/net/netmem.h
>> +++ b/include/net/netmem.h
>> @@ -260,7 +260,7 @@ static inline unsigned long netmem_pfn_trace(netmem_=
ref netmem)
>>   */
>>  #define pp_page_to_nmdesc(p)                                           =
\
>>  ({                                                                     =
\
>> -       DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));               =
\
>> +       DEBUG_NET_WARN_ON_ONCE(!PageNetpp(p));                          =
\
>>         __pp_page_to_nmdesc(p);                                         =
\
>>  })
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index fb91c566327c..c69ed3741bbc 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1042,7 +1042,6 @@ static inline bool page_expected_state(struct page=
 *page,
>>  #ifdef CONFIG_MEMCG
>>                         page->memcg_data |
>>  #endif
>> -                       page_pool_page_is_pp(page) |
>
> Shouldn't you replace the page_pool_page_is_pp check with a PageNetpp
> check in this call site and below? Or is that no longer necessary for
> some reason?

It is done in the hunk below this one:

@@ -1379,9 +1376,12 @@ __always_inline bool free_pages_prepare(struct page =
*page,
 		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
 		folio->mapping =3D NULL;
 	}
-	if (unlikely(page_has_type(page)))
+	if (unlikely(page_has_type(page))) {
+		/* networking expects to clear its page type before releasing */
+		WARN_ON_ONCE(PageNetpp(page));
 		/* Reset the page_type (which overlays _mapcount) */
 		page->page_type =3D UINT_MAX;
+	}

 	if (is_check_pages_enabled()) {
 		if (free_page_is_bad(page))

where
free_pages_prepare()
  -> free_page_is_bad()
    -> page_expected_state()

--
Best Regards,
Yan, Zi

