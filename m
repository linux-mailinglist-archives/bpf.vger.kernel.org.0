Return-Path: <bpf+bounces-48796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239BAA10D5E
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 18:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 667737A1660
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 17:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFBB1D63F8;
	Tue, 14 Jan 2025 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivYHS4tI"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F3C23245A;
	Tue, 14 Jan 2025 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875082; cv=fail; b=EGcARIfm4A2YjIadzhPk6B1mIlX2PQN+zLYCRw+cpm5cKALyo3KjqpGk9FoKTuZxW75AGrvIBQNri9qrEbmLFzoCHJmb66l/cD+enyV5uzSF2wyh2CbE9kUfQBTQn9Nad8uzA3Lk1H2SlGT8+aGpBH1xPZIk9JYFjEYp/09cnz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875082; c=relaxed/simple;
	bh=TqdRx0qm7KqogfN0KlkyCVR8dxWAEm6uQbW2cftOQyA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MQ+81GbSM6HiXUwyTqvOOX8m/qkCQAha5uvIwWzfv9sdbr7bdqNlW0KWiZxrfHXKm9GWq5wRiQG54oJjdyZ4vKbJ6Z/UC+VCUXA3XGPicYG4UZRy1JbpD2afV/qLxW+C5/TAuYKJu7yRhFyJUKQvOwdk5dLgKcYgCbMEcLTN2XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivYHS4tI; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736875082; x=1768411082;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TqdRx0qm7KqogfN0KlkyCVR8dxWAEm6uQbW2cftOQyA=;
  b=ivYHS4tI1LVW9cHUC/mprLjHLJYIDgsi/pRUnlSO+4ALUpNPJS1nAt61
   SDgkLZPN3AcIGXPYEr6BKW/ZrlwrCJ8r70Ey2++lI6jTwAelYccrAIGsa
   Xmjjeh86B78y6fiYHw5u3XNh4ZFyo2u0RTdpGDU9ykeXqyobWap9zAHlx
   CTTMjpSTGcz6t0G3bX7mWw05Ot0uvvlwkcZexPVNlpKGHOzjak4gnCqa4
   nezD5sBBI1zHM0XhdWqexWnfXiLEdwojBmrZYOsuCcpmIZVd7FE7C8ZQs
   d4beq8XbcJa2Qu6MoNME4GRo+dzV5X5eOBm84mTnNFm9JH1rXAQVidhmu
   A==;
X-CSE-ConnectionGUID: Q3RcfMB7S8KkbjGnGuW8cw==
X-CSE-MsgGUID: FPax0ZX/S2yavES7IH8WzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="24785108"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="24785108"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:17:58 -0800
X-CSE-ConnectionGUID: S+MX+G6ARN2eG841Os2CQw==
X-CSE-MsgGUID: WbGtJH/6StK18nUjQL2/lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="105379185"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 09:17:55 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 09:17:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 09:17:54 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 09:17:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emN5d2npcu/A/xF/KLTtQY2BhC4aPdzOrBIr3cqjGsMpfBlQXKy8yFMh/NedEFGtwd+F8N8TS5Xn6SrTJ6k0ciABOZUBq87+PP5CZdPb0I17Yqa7cP+CXoAchQd73YSASfcJAY1hQLw/QBK2b3XfiOTm5LvU4bhMBGanzj3begvEpHgQQVVLMYtuiLfqgiU0u22bg+9U73p6+o3ZkFrsH8XafMnPug6kEJTYxPBM7VLHNCfPu0LU+edLyEDkeQZjjibCmuTsUgcIvrqunS5Af58GTC1AyZyLC2Evj6n1xbuFWDmycZwYx2kF1nFuIQFoqCTxkOYLjHLyPRoxNpspyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkgvlFZVHNaOkcb3Pl3l44of419ulWCW9AW1mFQNyAM=;
 b=tZcCwfUxHFQB0yC24SiUhSS+0xHxPYdFCv7Z+UcXs+998ymeqKjpOeA4GPECr7UA4toR70zUT0KBSDEOx3IkaBHPjLGqw/CBIcqCXqpTO3fdz6V+yzwUzrx4zuJuMXPuEdQXMRdRIFwkDkSqGFp+C/JBnmD0T8rSzmSSUe5G49WoCsUjq3IAv0pASYR8CVYDPL+vaqnLM8H33QkaA6AP++Zd0UdARgYF4Rlf3VlOQu/ITTsIsnRqh2v7KSiM3w4wOc9VrQhyhSQtvyvYCsKFaOmzLJG0vRLqeb/yzZCzzdZ0EzOmHq1KY+VA1JLXR/TfOqOJ/n5hMcUkUYwKvZ1g9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Tue, 14 Jan
 2025 17:17:39 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 17:17:38 +0000
Message-ID: <ae4d008f-8a70-4c0d-a5c8-c480cad53cf5@intel.com>
Date: Tue, 14 Jan 2025 18:17:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] nfp: bpf: prevent integer overflow in
 nfp_bpf_event_output()
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Jakub Kicinski <kuba@kernel.org>, Louis Peens <louis.peens@corigine.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Quentin
 Monnet" <qmo@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	<bpf@vger.kernel.org>, <oss-drivers@corigine.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <6074805b-e78d-4b8a-bf05-e929b5377c28@stanley.mountain>
 <1ba87a40-5851-4877-a539-e065c3a8a433@intel.com>
 <Z4ZAMCRQW8iiYXAb@stanley.mountain>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <Z4ZAMCRQW8iiYXAb@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0021.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: 201526c8-33cd-452d-6669-08dd34bf5891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1B5R3hwT0dBbFdwc3ljcXNJcEZyVDgwUVA5Y1VlZCtlV1lOOWI0Ny8yYUQ5?=
 =?utf-8?B?TDJPUnpSNTUvazN2ZWRGbUhKMHloOCtVN3JDM3hhZXRyNm5FMHB4RDQyQ0xk?=
 =?utf-8?B?c1YwbTF2bDQ5bzJxVkw0bEMxVDhyazJrR2NQOUxBQTRiM1NYNDk4V0c1SUIz?=
 =?utf-8?B?YzJJZGl0RFJoeHp4cFFKTFNCa3ZuTlZqL2tpM1lzaE9NUkdUbmY2VXVHKzdy?=
 =?utf-8?B?cmhLZnhEYzhGbjBiWHdoODdpQ2N2V0duS3hKd1lvckNjOWVlSjY5WWw2MnZS?=
 =?utf-8?B?YjZuZEJxTGtoejl1Yno5Mk9kUjBXMlB4ODJ5QTFteUt6dTNRZE1CdGo1emFl?=
 =?utf-8?B?akF1STYxeHJ3S2FuSTRUd2JNZTI2ZkhnUnFMU0hoZ3ZpU3JRSWcramRHbEh0?=
 =?utf-8?B?VURSZDNuaGJLd09lWXl6KzVOMjVnYS9aOTRzQk9GR1lhNmIyTm9QWXV1YkpN?=
 =?utf-8?B?ZzFiYk1laW05U0JydllvZkloQUlLWXE1ZElWWWJ4WitQa0pMb09LcHliWXpm?=
 =?utf-8?B?TjBYTVBRK05rZG5XWkdVQVZZaVdLdVJnMk1RNDVHN1RPUXN2Y3dUYm1FcExa?=
 =?utf-8?B?V1FTUUoxdXFIMURhNEdkeTZqVkU5aTRDL3AvZFR0Y04waWNHR1o3OFI2VVoz?=
 =?utf-8?B?cDZNdkhPSEtrUXNsbEowS3ZTOVVpdlB2UnczVE12NUdMUDE0RlZVNm9lS0pJ?=
 =?utf-8?B?MTJpbWhtNGtJOTU0dzNPQzV3UmxmZXFBb0VObTZidWo1RWxsWENLWHF6dHlQ?=
 =?utf-8?B?dVBQU1plRFJySkVTTE42dS9YcjdkSkVZWlJYbDhHRml6VWF5YlJyOXlpZFlr?=
 =?utf-8?B?Z1VUS1gxeGhqQmxFU0JlMS9oUEtvTHYzSFZNQStUWUNDVnJPOU01T3lXMFRq?=
 =?utf-8?B?MmRXYzFJTGZSbzJMcUs4NnM0V3dtTnhtTlJhTTdvWWhOQzFLZ2pNMGN2cG1Z?=
 =?utf-8?B?M1IzZGRRZzBYMjlQSXNQV0JNY0lvQVdLTTMvcjA5WkpybmpNZXhFNlF3Ri92?=
 =?utf-8?B?SG00c3FRbGttaXRvZzc2QjF3NHNCVTBXRUtXSkdjRWFVSVhkdjlzZjdXQ3Jt?=
 =?utf-8?B?K1RPL2kvNktPdndRbk45ZmpuQU1nTGdHaUdDK3lySGp2WFN6OEp5aEViNHlm?=
 =?utf-8?B?SDJUSTd2MmdxRGJYYTZvN1lSZFl0cVV4VHBIOXdPcW94UjI3SW9CUEcvSWJo?=
 =?utf-8?B?SENjWDU4bEhKL1lNcWxnOUtCbThzZTJyWFdjQ1hPbnRYN1lZVWY5YjlhaU1x?=
 =?utf-8?B?Nm1aUlpnN2F3UHFZTFZPTTJzSDI4d3NtWmpreDA2WWxIejhNTGhMZ2VqTDJ4?=
 =?utf-8?B?bVZTMFV2YURJNE9jYzg0aDNuRTlKZEdqR05rNll6U2s1cWtWdkFIRHMvUmhl?=
 =?utf-8?B?MktNVXFFd0xtK3BudUpscGFWNXZzYnJrWXhtUHlFZWxZenVFUWNRSlN4Y2xY?=
 =?utf-8?B?ZjV2NFdLK2Z5WEc3ZlNVa3RmWWNic0tjZktSWVBOUWRuR0lHTUQrNkM0RHAr?=
 =?utf-8?B?YURQUXk4VDJ0VDMrRVNreDR2UHQzTXhjSm1uRXYvUlFNNXRHTzlpVEYwb3M1?=
 =?utf-8?B?UXd6Uk9tTWpPS0JyaC9jckFoVExCdUNWdE9aTVZobGppZ1cwREhpRHhmWjhT?=
 =?utf-8?B?dEdmeDFEOTBld3RIOXV3ZVNmaDBpLzRGNm5CdUtra09KZWVYbUNRR0NTYmNu?=
 =?utf-8?B?MHhydm9zVFJNaGJJS2FzV0YzZC82a1Q2c1lDQ2JhNDF5c2xTSGFqSklLU3ps?=
 =?utf-8?B?S2hsZzNiSnFod1duVHhtNDZSZktieVBSR0YvVmdaWFZuSXVESTNrTmpZekdo?=
 =?utf-8?B?KzVXRytpSUdwN1RHZ1JRY1JyUXZBSVBXQUUrRUdVOFF1ME10cnBrcmo1N1Vo?=
 =?utf-8?Q?n8XwAzTGw8p54?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGtMb0VFZGxEdUsybU1QMXN5Yy9lU0gvS1lZcTRIRnVSZ2JDVGx3Qzk0Vkhz?=
 =?utf-8?B?cjcrcFczNjVPUlU4QU1icEQwU0RuejJBeDh2M3kxSitRM0Jkd1ZwdkxuM0FX?=
 =?utf-8?B?Wm4zTWJCbWEwdTdnVmJXTXM5ajVYTlVlU2FCNmhLUHV0YjV6ZlhPd2pSdnhJ?=
 =?utf-8?B?WU1vMEQ4VFZvVC95TFlzZTNJZVhSUmhMTHhVZnBodHlWQ294UW5CSklOYWNM?=
 =?utf-8?B?SmlPcFRCWXkzd1pEeG0vMXNSN2kvYklKK0x0d2RDNnJmaGNzL0FPcnpyNENx?=
 =?utf-8?B?YWQzR1NNcEU5cEk5ZlcwTmU3MXFaNFdONElrSVA1VlFtWFh1aURiWFlkYXJv?=
 =?utf-8?B?QUk2SUk0bFlmbUM5QkY4N2Ywck5LazluMGN1dUZmbWJYWmdkTUpHNFMzZk4x?=
 =?utf-8?B?MER1bE4xcVZrTi9pNnVnTElTUk5QQ1ovRjVYbVR5aStocm9GOEpMNlFacXZQ?=
 =?utf-8?B?Y3Rad2haVHl3V25HM3hHWHZYKzN5andpNG5LazJzeUUxUWVxUXR3YjhNYkVw?=
 =?utf-8?B?WGpKbDB0RXQyRDBQYnFVUysxWWN4Y2s5Rk1OdEhVQVozS2lrdWtvZVM5b3Jo?=
 =?utf-8?B?aUVHZTdtVk80dTU1UGJ4NXpxU2tmQ3UxTllQYmFiamc2blRPc2VkTkRxOFlW?=
 =?utf-8?B?WDNGV0dOdzJnQkd4eVVXN0lTSVVRblk5R3Y3eHQ5UXdMaDhHcWlZLzdoaSs1?=
 =?utf-8?B?Um1sSzhjY2dEWVI2dUp4cENnRHJ2Tk1ZdzZjcHRaYTUzY2NhN0NUaUFiNlNy?=
 =?utf-8?B?SHFLWUI3WkRhQmszejUwY2tGSWV5YWgzS3BhVEZtT0NmZXJnNlR0WkN4OGIv?=
 =?utf-8?B?YWdBZlFkOGJGR201MnBQRllHRGhzQlpHVW5peHp6czNCcDhMMHZLM3lLa0lw?=
 =?utf-8?B?RkR5RkJxTE1LNmdoT1BWSklkdUtESlJtTEErK1JSL1lWMWhycmZIUWxYMnEr?=
 =?utf-8?B?UVY5UTA3WWh2Y2RNNm9ZUTYyMTVuY0tuRTRhdWtSMmNPb0oySGZNNy9qdkll?=
 =?utf-8?B?K3JZRUVaOXozV2lacUtjTGJCU3JzUmtJTEhJbjlsOHZzNjkyRG16YVlHTjRy?=
 =?utf-8?B?YnRTaXZickh6b0lYQTlFWlMvS0lVSW5XbVRocUVTWmlmY3dFQi9IQTJzNENo?=
 =?utf-8?B?OGZKSWRIdm14QmgySmJBOFpndmlVN2V4VHJxWkR4cVBNb0R4bWFDSktWVEph?=
 =?utf-8?B?eEZaUC9GL0c5WURZMTQ3d29UMDQrZUpvUjFTRDlqK2p4eHBadnFJUnFNWVkw?=
 =?utf-8?B?c0NVWlh1dFFNODErc0VzTG90UTBLQ1ZKMWxERTdRL3N1RURLNnFKaFRiT3lz?=
 =?utf-8?B?N1BYOWk5ZTR3Y3ZHMFNxcUxqVmVuSFp5STZ3MkR2OXRKZWRjTlY1Snh6VEdH?=
 =?utf-8?B?ZDRkMHBUMmcwNDJINkx0bVMzMXM0bnNkM0g2Vzdkd2szN3hqRzJCc21GQ3Rx?=
 =?utf-8?B?L3VteTZnVmpmTjVxYlNKR0d1NC9sd0hNVUxvMEh3SDJzTnc1d3VuL3NQT0xl?=
 =?utf-8?B?TklYaVhaV1l1L0ZIWXZSS2VPRXcvNGMwS05sV2hacmlwdTVqSEN6bjRNcU5L?=
 =?utf-8?B?NzdrRUlncmYxWjBRWmUvSW5qOXZjbDFxV3NndFdTa1ZYUUp5Y2FHUzZnWE5E?=
 =?utf-8?B?elNTV3p5ZjU2ZzAzU1BSWGtvTTUrdVhIZHJ2ZjNSL2diZnJGMnRjMGg5ZzRR?=
 =?utf-8?B?b2gzOFVEdWt3RkVpTHVlNUZ0d0ZrUHRIU1NaSFZZenZjN1Y3ZkJmaE9KYzQr?=
 =?utf-8?B?dW9ZdW10V1NHbk4zNENRelJiNml5RnBSYUIxU2hSaHVndTk0ODdPd0R2RWpZ?=
 =?utf-8?B?cHBzdTlOOTlxL1dGdTdjVytPYjhockZiQ1drbTYwdmNBb0pkNlMzQk4zZnNi?=
 =?utf-8?B?K0JPTlRaQ2R5VkJIamd1a0Vqa2wrZko1OS8wTG4vem1RWTJTbUF3cFhob3o3?=
 =?utf-8?B?NHh1MkFEZVkvOThobU5SQmswbitTTnlTVHJMbm1NM3BBaVdSekRMTWRuR1NQ?=
 =?utf-8?B?Q1hqQ0RLanorT0o3UVl4NUljZ0s5OVRFZDVtdVhQVkZTNzdGUTBVaHhYZkQ3?=
 =?utf-8?B?YW5jSHAwekFjOFNaVXBCcElZUnpPSk5CTGY0bkZueXJzbC81ZjlIOWhLRlNR?=
 =?utf-8?B?a1QyMDMzSEF0UHRQTGM1UXExUk9VQ241Q0daUVJ2Z0gvYWsyZS92QlZIREU5?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 201526c8-33cd-452d-6669-08dd34bf5891
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 17:17:38.8552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/S5QQgfHL97hcKZv19WX9YCUeBfHNoc1Al4mRs3nG7DQR0tGCj+OQMvgRgNxeWJu9yQj9FcfJC8BWON7jQZ0E7RrRGEfhYbgMSfu49MeqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7420
X-OriginatorOrg: intel.com

From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Tue, 14 Jan 2025 13:45:04 +0300

> [ I tried to send this email yesterday but apparently gmail blocked
>   it for security reasons?  So weird. - dan ]
> 
> On Mon, Jan 13, 2025 at 01:32:11PM +0100, Alexander Lobakin wrote:
>> From: Dan Carpenter <dan.carpenter@linaro.org>
>> Date: Mon, 13 Jan 2025 09:18:39 +0300
>>
>>> The "sizeof(struct cmsg_bpf_event) + pkt_size + data_size" math could
>>> potentially have an integer wrapping bug on 32bit systems.  Check for
>>
>> Not in practice I suppose? Do we need to fix "never" bugs?
>>
> 
> No, this is from static analysis.  We don't need to fix never bugs.
> 
> This is called from nfp_bpf_ctrl_msg_rx() and nfp_bpf_ctrl_msg_rx_raw()
> and I assumed that since pkt_size and data_size come from skb->data on
> the rx path then they couldn't be trusted.

skbs are always valid and skb->len could never cross INT_MAX to provoke
an overflow.

> 
> Where is the bounds checking?
> 
> regards,
> dan carpenter

Thanks,
Olek

