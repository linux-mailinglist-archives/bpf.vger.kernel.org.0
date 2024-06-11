Return-Path: <bpf+bounces-31874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6289290442E
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 21:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2EC284BD8
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 19:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1432770FF;
	Tue, 11 Jun 2024 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QtNVYdz/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EE19475;
	Tue, 11 Jun 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718132620; cv=fail; b=lvGgvTqbg0zCDpyNU7BaVbbOQMCxVDzA0IqyBK4v7C78oy+JwbTbNPTEItxwCJpxNcrZduK0IlXWjRgz4h6/UI/aoTAtxR2iEUcRrw75mTezrT5KL0j4WPslCZPZnFionGVQD2yNtdQdyZXo+DxQWDchQgyal4Itj1yKbMZ28gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718132620; c=relaxed/simple;
	bh=DYC6DU4roBPw4Mq7GEy6J8kgM19LNZdvriUrG56k7OM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fe1b9Si3Qz3MujEcggIvtgVdU1B5KGdkHJ+wTpOimCVQB+FfHUg1aicFImG6Wl2USgPAq55twubYBOlsbhQD/u4rIWZsHXbpJDCjyKMupmjA12eYBAK9+w6l3OwGhUCMPy119NkfDCRFt3WvwV7rCz3OBH6X8h22IxLm6mbxRlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QtNVYdz/; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718132619; x=1749668619;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DYC6DU4roBPw4Mq7GEy6J8kgM19LNZdvriUrG56k7OM=;
  b=QtNVYdz/EhaANJipA1DHRTQxhghpj1QKIAnER4wfqze3ZhsoNWUnQBzi
   BH5vXyxOoy2tuDnzReDy2dQRQuHMHbR4NZFE6VEr7ooTCHZv0wSgyIOgJ
   OocKe0U+KvIt+twJXY7nPlnneKa3xIyx0WUAwivcanMf6SFmJeLdcNFfI
   X+weaKTZlzCJOG9HdVsVAlfozwAWgtoixNYWxjULpM/XYBaSgCmcBz95G
   cE4JL41xnpOK3jzXFkuG+n3BBLqjPcKWZF3z3zoZLHQM5nczTSPMJ/8+C
   rOH0xi2YwY6+uO9ImFHi70uruUXrsf3hBPmPaS3Aq4eGSkapYsSk0nUTR
   g==;
X-CSE-ConnectionGUID: cKlgnrhzSHy/bjAFb2Qrjw==
X-CSE-MsgGUID: INs6kpKHTEeU+wuFKKh45g==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="14589923"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="14589923"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 12:03:38 -0700
X-CSE-ConnectionGUID: tfRg6ArDRPOmsiftmoIq8Q==
X-CSE-MsgGUID: igVDE0jyTeWPrg6Yqdcvrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="62707302"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 12:03:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 12:03:37 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 12:03:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 12:03:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 12:03:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ED857QSPQHNUGm0TKNVB3Ox3o75y66kDwUdkwdfypfYhOIFzAL2nAfpmIXG3cyeyKcNmshTv32yfqM3yJJ/DBk+IRnfDvNM9Z6D/21ip04L4seiNFTr1Ve0r+7NNIC7K11syVooFfmMGaY4CcmTBvcIl/XBPSJWGbU5p6B5R6blf3T1alpD9KwvM+nlv0gqVpXmb4Jq2F/oinshV373LUcYDKx/IirNJhao5Sak9K/hMWaWxxjvCIsprsW18LqkZ91aDyAdBPvQAmn3QI2VRZvN34CviuzClcNpgDx1C67bwDOAQcnmr5FcxC+xjDYgyJ/csophxeOvZU7tcQ2pIcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zt1Vuwtp/My/uzsnBO4U0DKNPqgS2stlxPJiZ4U8Ynk=;
 b=n97wEmUzeYJ7hBfzsAQidWDsZwRhJ/6hQiv4V66H9++cbVb1okC3E+ULC8UaFM7UznqJa72oqxuSGcKMOy73WxHux2PyXorylw7QmdgqA+cqgSx6/vPw5JKFSE2hAxAWE0WgbI3TXXkMlGiE7vKEfdajXtnph4bNXItWFf6GzusljwhEZ0Y5ldRmp65J/vA82EfCiGVbP9XZS98NOXY+EhCvoi2h2FmkrUnoS6Ib6fmLSE7J+2LaRlzsK+Ma9pq5wzynQz00HVy/aiW636A0t5Uxu/RCVjGDrxJHDIbkMAIH/O/AZVpKFAWHRl/6AHbgK+jgyvg6IgiOwyLQqDpXYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH0PR11MB5207.namprd11.prod.outlook.com (2603:10b6:510:32::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 19:03:24 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%3]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 19:03:24 +0000
Message-ID: <cacb1118-44aa-8d87-5b9a-7faa2e35326d@intel.com>
Date: Tue, 11 Jun 2024 12:03:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net 1/4] i40e: Fix XDP program unloading while removing
 the driver
To: Michal Kubiak <michal.kubiak@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>,
	<maciej.fijalkowski@intel.com>, <magnus.karlsson@intel.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <bpf@vger.kernel.org>, Wojciech Drewek
	<wojciech.drewek@intel.com>, George Kuruvinakunnel
	<george.kuruvinakunnel@intel.com>, Simon Horman <horms@kernel.org>
References: <20240611184239.1518418-1-anthony.l.nguyen@intel.com>
 <20240611184239.1518418-2-anthony.l.nguyen@intel.com>
 <ZmieBWzCg1yR7R73@localhost.localdomain>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <ZmieBWzCg1yR7R73@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0006.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::19) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH0PR11MB5207:EE_
X-MS-Office365-Filtering-Correlation-Id: f3babe47-8ef7-4daf-47b0-08dc8a492b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006|7416006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rnl5dFpBSTZQUUU0dy9SanFFU3RnN256R1RDNi83MDZSdkFJUXJVY0VvVGlL?=
 =?utf-8?B?Z01sL2M4akFkcHhVL05PUDVrYVU2REZKVmNHcENGWnp6eGh2MXlsOU5NOFFI?=
 =?utf-8?B?QkRCQk9MaU82L2VsdXBmWTMyUWN3V05tQjZVVGltbStEdE5wK1VjNmZSc0ZV?=
 =?utf-8?B?UWl3azNodWJTcGZaTnFhTWNSVFV2TGExeXo1VG9pdjZwZkdzazdWL3l6L3N5?=
 =?utf-8?B?NXFVclI1R2hlL1ZaQ1VBMlVjMmZ6VjM1TThuRkNqOVUzOGoxTUxqU2dYdzBh?=
 =?utf-8?B?aHMvbllYT0UyTFZzYWtLeTNpcFE1R2htSUZXWXk0MGlPUHgvTDBUejJ2akNw?=
 =?utf-8?B?d0xYZGVUS1RQSE8xRkV5V1hFcFdMaHkrT015c3dTWmJ3dklXb0ZTbzlubHBh?=
 =?utf-8?B?YS9sRnRlK2NnVVpmZTN3MTdDcDhuQUV3MzZyOHBIb0hqcTc0WHBXNmQxQjVI?=
 =?utf-8?B?YmhScGJqZGdHU2NYNld5aitZM25nWFlFVUxOckVIWjQ2bHNrWkR1dU9ZTkJH?=
 =?utf-8?B?S0l1a1hGY1VHWno1Uk5nay9ycGxReFJVUkRGUllsdW02ZUFYdHRyaTVaMXll?=
 =?utf-8?B?eWx0dk4vN0dlV3Z2RjBTZ2R3V0tpNjVSZ0JLdnZURmN1aWZIVDYxV0NjZzFM?=
 =?utf-8?B?bFcrdUVDcHVnM1hCR1hjeHV0cnE1QzFCOEF2MFZFVmk0SU91VWE3US9xK1FW?=
 =?utf-8?B?K0swNVlmZjl1bUhwajVBNnZkN1dTYnFvK1p6SElodVRYNlRrQThzZUJkbjdH?=
 =?utf-8?B?UmZhd0VqY21nN0xIdk1QMXp2YndmdFltdnNPdXExUmVjZkczY1lyd1JLMmpF?=
 =?utf-8?B?WXVad3REZmFxV0xYS3NmU3JxbFpXU0xUcmlZYVAwdDkrclpjTSs5T20yYzZN?=
 =?utf-8?B?NFRqQ3p5cGFHSTU1bDJkZEdhUndYd3dodzFiVTVRNk50VnFSKytWRU5WOU0x?=
 =?utf-8?B?ck9BMTJ3SXQxdjNlWFl4NnlaV2ZxRHZ6SnhOcHFqQVpQMzExNTNWNVRmdnE1?=
 =?utf-8?B?SFV5cHFJUmg0YTVqdzFnUTF5QXpyRllESXZtcTBZYnluZjQwUHlFdG5Hdlo4?=
 =?utf-8?B?UEJPN0g2Yk1rNXgxcjBOVWJpZTY3Nm9iZFFmT0NzWkJRWEF0Y1poVkRTcnBa?=
 =?utf-8?B?N0wyb05jSlUrc2V4VzNRNHBtaGZacjlrajc1VUhUV1d1QTZ3KzNWZkI5U1Ju?=
 =?utf-8?B?OEYzOEV0Z3BtMG1VU25MczRFa3hPKzRFVitFMEdzN2ZWMDlOdFA2T1g0T1Rt?=
 =?utf-8?B?aDB6eHRYLzFYV2U2NWs2dStZdGw3SGV1M0k3ZGo3VFJnSVVaNjl6STcwZ1Q4?=
 =?utf-8?B?ejlTd0Q2ZGRHQVBsZEtVa0c3Y28zSk5UK2o5cG5Od0JFNnlVUVE2WVZWUXdp?=
 =?utf-8?B?bXdrcFk1YVNhSW5EcHQ2ME50T3l4QWM3dXVZYWdIaE56cFlITzNmU2VLUHBY?=
 =?utf-8?B?aUVXZW1xelJtTDJYcjAwVXRkYld2bHovVFVOUzN6T2Ryc3Q0RUxmWEF5b2sz?=
 =?utf-8?B?d09tdmp1ZWR1Mmt1bVltUXlGRGJseVRmWkxBSUFkTVNFazJkWE5GajgzOXU1?=
 =?utf-8?B?T3dnR2hHUGtrQ1g0V2dJbEk5VzhHLzhpSWpNbHduZUVZOXQ4dENzUWxFL3Fq?=
 =?utf-8?B?Z0pnUnRUbloyR0VOd1MyU2toSVU3dndCRjd2WEtrOE5STkNKZFBiK0o5ck0r?=
 =?utf-8?B?N2RtRlNGRzlNWVBnS3l0S3k0cHpHRE9NMmVWUDFrZW4yZERQRnp6ajdTc1Ez?=
 =?utf-8?Q?wxGJ5WxDXSErIQ07Jo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006)(7416006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXNTWGFtdGRlOGVmUkV3QU9HcWhJN1NRZUFSNmlGamFSUnJaa1lNa0JVS09H?=
 =?utf-8?B?a1RZSkNWLzJxMG1OcTZpeThnd1pHR0lRSDhqdm5GNUVPY3lINHhzWUV0UkpL?=
 =?utf-8?B?aitVZG94OFRwdFlSSkFZVHBVS3VmN1dUcklFYmdJQytwWm5ZOW5LVVFiK1g4?=
 =?utf-8?B?M1JrclJhQk53dTZoZzQ5cVVDTWZ3aVFWNWt5bno3OFRhOEFvR1hrS01wVXFP?=
 =?utf-8?B?UjFGYjUyQ2FEWkJLTzV6aFFIQlVlOVVJREluL0JFdjRxM0oxMmk3VE5IYm4y?=
 =?utf-8?B?Vll2YWlzMFpiR2xpcC9yN2tFSDdZYzUwKzBLdVdlQk5HditrYmlyRDBESEdi?=
 =?utf-8?B?U2E3dnZsNllQWkZkbndHbWRHNnVIZmxuRk94dmduMjJEaDRkQU1IVUh1clBv?=
 =?utf-8?B?U2pTR0lzb3Y4RDEvbnVDa3ovbE9EYy9GenNIL1RRNG9KN0JZYUVYZ2QralNk?=
 =?utf-8?B?VkwzS3pleUdYeTdIOWlUWWdyTUs1RHBhZ1E5U2U1bnBZQlR4OUp6dzNEclVK?=
 =?utf-8?B?UmtqNkVhSUVsM2F5ck1hMHVueFJ5QzdLMGJRK25FR2N2SEJNaWFBOE95MUlV?=
 =?utf-8?B?TEZYMkNmQzZoWTdOYm5USm1JZjV6dFZwWU5acDVpYjMzS2VhbHNYY3lPdTBB?=
 =?utf-8?B?ZmEwd1ViRThSN0t3U2JsZTIvblNRY0dkVHpGajFOTFZFNHFPUmlhK1hibmJP?=
 =?utf-8?B?djIyNG5WbE83TzMyREpnZTN0dC9VaHFJU21wL25lQkNkNnZwc2pBRWo3djVm?=
 =?utf-8?B?RGRES3ZSdU1LU003Zk5VQWVkK2ZRS2NkM2dTYnFYcnNDYkxNMDNQZnVpMnhP?=
 =?utf-8?B?dFhjdUpnVDhycjMzSXowOFR5ZDB6SGljZXdSVkd3LzZNbVVqaDFkZUlvZGtU?=
 =?utf-8?B?L2NodnJTS1A2L0JnR1BWU0dSRXM0ZStjK1pmSE5ZL1dvZlJVS0xucW0rTTNJ?=
 =?utf-8?B?OXNoUXVZdEpjaE1LeUpsY1dKME1PK3JNWGpsWGY4QkpQUjhnUy80TCtqZU9R?=
 =?utf-8?B?V09XSWd3dVJsMlFvbmFLRnlsQ2p1SEo4R25xelRvTXhDMVNoQkdYR0J1SEdX?=
 =?utf-8?B?cE5odzRzRS9FQUhUSzM3ZHA5UUdUa0VGL29rcG5JTC9wTVh2VHZaOWRNZlJO?=
 =?utf-8?B?dTE5dGhsL0x1SC9iVVNseDdoZFhURGZFSDN6Y3lhQ0hMaTFlVVVTQVlBTWdr?=
 =?utf-8?B?TmpYZ1N3UHAxV0NtemVpb3RNbDdKeHRSY2Y2VWJQM0JGdTdBL285WThWWnhp?=
 =?utf-8?B?TUFteHk1bStidHN1d1NqdEpMenVuVmlYQjNlSXdwcFR2a3QyelNnZXpLdlhZ?=
 =?utf-8?B?cy9TeU5BTlN0Zm1aQW1YUit1dDdqNURVS0dLcjI3R2t2eUE4amdmdUJORnNj?=
 =?utf-8?B?TGRGRXpxTFBqcEtZbUdNUno2U3YwaXh4MmF0SXZxZXBjTitiWTRibUhFSFo1?=
 =?utf-8?B?L3RDK1MxWWpHUEV5aWZJekNOS2VUaTg4MGlFRnZkcVFWUDYrSGVaSUkvTmtP?=
 =?utf-8?B?WlQ4WHEzZEVUdEN2MmNFV3I4UXdGQy9HRmNvYStUck5SaHg4ZlNwOWNjWGlq?=
 =?utf-8?B?M1FZUGlSTnJuajB5aTdwa0FXSW50dkxHOWJwZXUyVXZTaEIvdDN2TmxQTXBq?=
 =?utf-8?B?Ulh0SnFPRDVrRlpmd0pyQTB1NkJXTDlKZUdxM0Q5Q3M3YU1aaUJJS3VWZkcv?=
 =?utf-8?B?VGtCRWh2RUN2MStIMk1QWmxFN2lLQzBZblh6MCttQjNvSjVnMlpBNlQ3MkN5?=
 =?utf-8?B?S2dZVEtDek1YTGZqZEY3KzF2cGRBazJTekZVK0NLZ0RFRkcvRll5ay8yTHlv?=
 =?utf-8?B?VGdmK2J5N0tQbXhObnVZVHlGeVExOXBMaGdPdUVJRlRYdE5rampiWHFNV3ZF?=
 =?utf-8?B?Y0NhVTM4ZzRqV0kyMXN6aG95Q3ZFVkpoMEh2OTlwZE9aYTFSeXpzWG5aZlRr?=
 =?utf-8?B?YzJpTm9ZYnFnQXE4dGdLcy9CTytQdzJ0U1diZjBRMERsc0l3UUpmVHl2eDBI?=
 =?utf-8?B?ZUJZNXRBUFUyL3k0V0ZxMFZJeHpLaE10NFdnWm55TFd2NFJWK2gyeVVHc2lH?=
 =?utf-8?B?MWFLajlPWGxiQ0VmY0tUSFV4c2FlNGZQNEpQZXVKR2FvQkUwWlNlTFRla05L?=
 =?utf-8?B?dHFoVVFZb3ptT0tiNHdJRHRLMWlvVll3WU9UL2llT2h5NUgzTFFmSDhOSkp5?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3babe47-8ef7-4daf-47b0-08dc8a492b24
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 19:03:24.2519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwLtdMocxtTw+yZ7TTWIEGVhKVdzehjgXLpfB948eYyGKRPnx1FVsfuAA/PbR5gC3JShevoYM1dpDVcOJzIt/BS2ex6f8vz9sXKCkB0Hi18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5207
X-OriginatorOrg: intel.com



On 6/11/2024 11:57 AM, Michal Kubiak wrote:
> Hi Tony,
> 
> After my conversation with Kuba in a separate thread, I analyzed that
> patch one more time and it seems the fix can be implemented in a simpler
> way, so I am going to send the v2.
> Therefore, please ignore this patch.

I found that conversation :(

I'll drop this and re-send tomorrow.

Thanks,
Tony

---
pw-bot: cr

