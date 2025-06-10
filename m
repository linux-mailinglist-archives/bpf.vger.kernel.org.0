Return-Path: <bpf+bounces-60179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BC8AD391A
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 15:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED3D1BA015E
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 13:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDE3246BD4;
	Tue, 10 Jun 2025 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EL5PZ3Fo"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C76246BB8;
	Tue, 10 Jun 2025 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561427; cv=fail; b=tAjXReLqoUQfn8FvzMfI7MCnY+GgrrMjloNvD/wLCNdY9EjfD1SRElvftdg1b+1vDyj+yh9TUo8/y7Ze4Z6IgZBrs12IRBdOVYSu1sQ5UHJEzwUq0RDVrG02KmUTzWwOsXCQq1k2mZZqGyKwEB1tkffPkb968NB9xgZ8JcLtqhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561427; c=relaxed/simple;
	bh=WfGsBstOg5dcA890iXtFeCD0LIJtKi0V9CtCdEititU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I4zPar1L861szI0NZxnLeXJBrOadPpgrQxwTO3RgasPqg7wlCNDNv6cxpn++FGTUEVAdcn4kjRtJgduEwPWVP+bJtNTrEfKMOSUUOHuA8j//rnNqoPyv0Pvvxj2ykLxiGB6ytKQ89VBwehlcU0l9nonM09mUu5znB1dIjNrR75A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EL5PZ3Fo; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749561426; x=1781097426;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WfGsBstOg5dcA890iXtFeCD0LIJtKi0V9CtCdEititU=;
  b=EL5PZ3FokISsgweX3vGIHTNc8sCDB8w7p61hnTYC285qCdRjMYEEB7wH
   xLwscxu593hvKq9aQM24HUYmfuERlFajogOD+fQP+cx+u2El9/jzIIjQS
   q5im7k3ZX5k4lLA1ioUsW7JeEid1ilThH3WI24/+oL4CJ2Ua2uZ5ZS2bP
   EbP2hfd88/dM9LSsygtcfJ4LVZkk0s/uJszqsiS9iqiLOfd2g4t3l+xNU
   v6yik9i6sB8eUaHgn10EtogalKp4NvFWb+3WP8tOGPMROY5i9X3oGrK1k
   Wv6nT2Q3/8LZf3EwpTugDnS+4aY76MZA0c1Wyk6kdGrmc5/jidbGlz1OC
   A==;
X-CSE-ConnectionGUID: nSCyMgcgTrO5u8OHCychBw==
X-CSE-MsgGUID: OLXI9DyCT2aUe+JVM1wByg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51581308"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51581308"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 06:17:05 -0700
X-CSE-ConnectionGUID: XU0MfwpCQ5i8pZXCV3fJxg==
X-CSE-MsgGUID: EVlFSdntSfCJShIqIC6yqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="147343282"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 06:17:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 06:17:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 06:17:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.61) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 10 Jun 2025 06:17:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gn5dV3halVF1v0tsWEjnb7al0aXKSY7RPyNw3dlEUSnt6J3nUuH3/LcFzjkj321kcqB32pYHr3rnpxtf+heQJYuWzW8e+Mxvlg+S+15PyyyAdQQ997xK0jQIW/g8yI8sCvrXe0376k7rKwzFH3HLFh2/vZQ1lNTdyrPV+jiN1/bLk9lSpJAPznVx7mTtLlJCj8MkIGQTxvFtz29AmElPcbXNgjPF2X2F/94NcypZRFbQ109hwzbo7lKqgPwov0XDxOF6zCV6uACjgk5qzHrcMxo0jMT5qBw+AqKbFiV/Y0X5vat3y2/49zC9j+Z0Xa0Vh1sEfCRy6m0FMFnRmNUDSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ctC+VeOEUEfFrQtXxXZ36BZXVh03P5JYKiNpNJWsiE=;
 b=laUT0xtWRYPTQAnnytnzx/gB2ao3fJ+3+uBFDx8JNP/Vsw+wVVm7WcA9Y+N6nx61z1x2jL8LRFA6EzfmD5Ck9sb2PnYabsEXQBz4SqvgfbsAQK9ruK0UCz0iKBzBrGaSKZ9rkyYuhdz+CAYUMH5IQ87ueVg9TkIwGnlAkOOUx2NKnLLEM+v04KZkRveICuCXoQBqqnP6dJQVZ9CgL813cs2L3TVA2sT40ETnWvgVAljphkmSBnADB0EG/LWZEjh0jQeKe/VU1l6OkvL+XTP4IpRnduCoKTer2W0v/jHCoAe4p3gxNDZsjuynAHIjq7gbCU9krYsEgrgu2UPIkj+DVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB5085.namprd11.prod.outlook.com (2603:10b6:a03:2db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Tue, 10 Jun
 2025 13:16:03 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 13:16:03 +0000
Message-ID: <05305f84-37ff-4345-803a-85c2025dd67b@intel.com>
Date: Tue, 10 Jun 2025 15:15:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: cpumap: report Rx queue index to xdp_rxq_info
To: Ujwal Kundur <ujwal.kundur@gmail.com>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <davem@davemloft.net>,
	<kuba@kernel.org>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <eddyz87@gmail.com>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
	<sdf@fomichev.me>, <aoluo@google.com>, <jolsa@kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250609173851.778-1-ujwal.kundur@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250609173851.778-1-ujwal.kundur@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0075.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: 588aae2a-ec37-41a8-ad2b-08dda820f365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEQ4Z3hqL1NPdXRrOW4xTSs5eSswYThyMGxsM1V4ZEdjRWpmSWozOWJNMXZQ?=
 =?utf-8?B?QWlOT3Fyd0JpUHVJZzVhRmtwSXdldi9OeDQvMEc3UVlpOEx5ay92a3JJVGZ5?=
 =?utf-8?B?c0F4dy9EVzFOdER0dHE0Y3k0ZnYrVW9NTzlGczRIVkhEblFZcG85MG9ua1Ay?=
 =?utf-8?B?WHFnd1NYQ0FRQTRuNy9HeS83TCtUdGplNXRQRGErcE5hVW1ieldNcS9zd2JZ?=
 =?utf-8?B?N3U5QVQxa21keW1zNFVoL2lQZEdUTGlhVzM5STdMMUlYYUwyMVVFbVo1RUZF?=
 =?utf-8?B?RlpYb1lSbjNWd0hpMExrVkRkUmMvdTJnR29jZXZqVUt0TC85aHhGMlV0ejdm?=
 =?utf-8?B?TFRwd1NvS24zSkZwKzFhRTQ2S1pVeVNmVXFCanVzQ2dJcW11WjVKdkdVS3NH?=
 =?utf-8?B?LzQyT3pCcFd4N0trc1Fvdmp2RXA5VEFMVTA0U0JHQnRKSWN0OHgxaXMrRWFs?=
 =?utf-8?B?eWVKSDZBNlNGVjBORXd5c0pRL083R1A2Z1ZPelRKdk05YXAvanpLWTczcm5h?=
 =?utf-8?B?VGhybm5keGRDNWx6bjF3VGZSZFJNd0ZILysrQTZUNUxMdjV3Sko4ZE05eTVl?=
 =?utf-8?B?VmF0YWlHazg2M3hZWlJHRFVLMjVCdW90Q3AvZHAxcjNRRXA1WnV4cWFMeEg5?=
 =?utf-8?B?QkJRaG9MN1htcTFna0ZpanNZQkRxTGFSaHZCdlk0dVVmL2MvVzV2N0V3UVdK?=
 =?utf-8?B?bk5tVnR6VXp6eXZRQy9wazVQbkRkbzZIMVQrcXU1OTZyUXlnS2lFaHExYklD?=
 =?utf-8?B?VmI2SnhpK3pDcC9xa09UUkVzcjh3N3ZhdzRPQ25wQjJkd0p1TlZKU2lkaHdP?=
 =?utf-8?B?WFRJekNSaWVFbFROc21zTENhdVFqZUFVMmlRSmk4R2xlL1VEME5OZDI0ek9j?=
 =?utf-8?B?a3hTNWdHamVOYVRjTzNWTWFQSHd1QVhjdWFFdVI4YTMxdjRPU0pIdTRjMmR3?=
 =?utf-8?B?VFMrZlU0bFh0OUFVQlBFcWhSeGJ2OW1ObENOVm9TRmdaYlpQa0VZMDhaSHNz?=
 =?utf-8?B?U2R4aHRrVDR2N0lyNlBJblhFTFRMam5ZNk1OMEdrQ21nTCtXSlV1ejRQV1pt?=
 =?utf-8?B?WkxCbEFrNEF6b3ZpbUZIT1E4K1NFK2JRblBPUTJVTXpDSldPMDI4QnFFa1dT?=
 =?utf-8?B?ajZSUXd4RGNUOXN6cS9sT3ZGS2R5aitqN0NhcU44QzVYdVl3U1JYVStnN3FX?=
 =?utf-8?B?S3VaVW1STEtDRFUwcTdqYk84T3E2MTA4QTQ0eXovZkxxL0U4SkNqNVpZSHht?=
 =?utf-8?B?SFh5MUR3ekx6c3pGKzc5Z1hGNVdXTVhETXRMMnZkcC9UK2t5WkRnYzFKQk5w?=
 =?utf-8?B?eHYySnBWa2UyakM1aEJFS0ZPOXpXT2N2Y0pSYkNhMEg2eTJ3TUVTOHFWdjlK?=
 =?utf-8?B?bjZlZWpUMTVWUFU0WVVBYStseWVza2VUc0hxREhKdVpwU1dMZXBvOW1MT3lS?=
 =?utf-8?B?LzR4Tm9ZdTVzTCtCWmVTcjdhRUtwdE1oeE5tMFpUZUVRaGRPTktFeXdtaEdR?=
 =?utf-8?B?OTl6Tm80a2lMTjlYLzBNSU9nM2Y0dUxQcVpKM2Z6MUY1RzZ4MlFUQVEySlF5?=
 =?utf-8?B?VEZJbWhib2haZyszQTFwUXJ2aHl4RlNNSWZhK1gxcUxZL3VHL29weTl3RmNl?=
 =?utf-8?B?cHBHZ1BVSlIvYS95aC9rWDY1YzdCelhRV25hK1VxdnA4QzNST0FwSzdjSk1K?=
 =?utf-8?B?d0hWcHRSd1lkWDhaZFRmR2puNG5OUWJ2VzQzNHdDeHRMcUM2b1oxRFA2R1dV?=
 =?utf-8?B?VXZTUGNDZ2xQRnhMMzUzK3MrbDRjbldyaWozZ3FlUS9jRWxNTHBSTkJZWkw1?=
 =?utf-8?B?SFVCVUxlQ2pMVkFnaVRvQ2F0TU1YL1Uyam8zcU9VVDRLZngzV1hZR1drRDNn?=
 =?utf-8?B?V2V3eTlJdDNhaUgwSnZCVmRYVWZzeGtFWWwxWGN0cTVSY1lyaktBR2wxZ0R5?=
 =?utf-8?Q?sRmyp+OTwE8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0dCcndTSnQ1OXNDeE5NaGVtTjBZNlJSSTlVOGM5VnEwNVp4N2lLTldwNXU5?=
 =?utf-8?B?MkxWNzVFWExuRTBLdXRGQnhnNy90YU5UYzA4dUhmWGNLUHNKd0l4WFpsSU8x?=
 =?utf-8?B?WGJjTmhWQzZTRjE1NzlSb05BcWluRlNrbGQwU2FuWjQwRVJmOC84R241UTFo?=
 =?utf-8?B?R3MydzYvMHExMzBNN09PeHhzR2RhVk81VUdzU1Z6cFJycExmdGVzclpKSUg2?=
 =?utf-8?B?VWkrc2xYU0d0dTdObm9vcjZIOU0vTmRNa0xib3BqKytPUlk2ZUk2QmRPVXF1?=
 =?utf-8?B?M3BnK3hCaEhmV3p1VnFIWjMzZ3dxYTVjOUxFRVdXMmpqV2JIN2NqVzdjTkNV?=
 =?utf-8?B?VTU1TElaNVdsTUFMSWd1Q0ZTQU9RM1FSakFuS054MElYNHJQelhUaWFkMjE2?=
 =?utf-8?B?SkRYMG1FcjFRZ2RIQ0VCc084Rjloc0VZR3BrcTlaOTJUV0FZU0JIYk41VkRX?=
 =?utf-8?B?VmJiWWgzTWlJb3BNWXFYUmRPTlFKQkZGbmlLc2xjWS9NQW5TUTllQzJydXpT?=
 =?utf-8?B?ODZzalFWTG9Ua0JBcVZ6b2g4d0xPVjJ4TTVGME5id3RWSU9wRmR1WnIwc1pX?=
 =?utf-8?B?ZUN1REFrV1ovSkVWMVpJdWw3MjQ2RDJ6MmNmQy9RT0VRUnFQamR4Q2JkNm01?=
 =?utf-8?B?a1cxVnk4TE5zaHhiaGZwWTdwYVFJU2wzTi9odXZNUzZpTTVqSFJneCsyNnp4?=
 =?utf-8?B?OWlReVBKbnhEWGVCK0hLb0pDakFvSTFiemFsdDVKemxCcCsvZllMQnI4TWwy?=
 =?utf-8?B?clVodFlWQUNDSERNMTU2bjJVS2VUaTlhQVp2RUFEd0JwUWJZcVZ6TTkwZ2dp?=
 =?utf-8?B?aVRlRzBML0R3WkEybitjUFhZYTFka0RabzdldmhjTEFRSkEyM2xBbVpYaTE2?=
 =?utf-8?B?dUVYTDFWb21Fak15YW13VnFJSnVwYlJ6UXRyS0NBSlBuN0pGRnF6bGRXRFZr?=
 =?utf-8?B?OUtxVlQ4ZWRQRkRyWWN2c3JWZWtCWmVZTXRJNVl0cEZZWDZEN0ZUZ0REdjcx?=
 =?utf-8?B?SlVWVUp5UE5CMHB0NW5ERVJwRjFkWEV0cFJLTWovcjFCWVpqenpTTzJQY0Fy?=
 =?utf-8?B?L0I5dUNKSjVHVVptSkExekt2Z3duNkQyaU9HWXhKM3NET3IxMDBCaE9YTStE?=
 =?utf-8?B?UHp5RmxscGFSRTdWTHQybVJzUjVpY1J0Y1ZKOFBPbStrTWVGOVlSdVREcEpQ?=
 =?utf-8?B?TGlPWDY5bXJHb3NDWHcxTmdFdEdXbk55Z2Jpc3RDdVVWUmJVUkk0UkV1dFlr?=
 =?utf-8?B?ZTJ3czYyVzdzeGVra0ZnNHdvak1nL3ByWitUSTQ5OFFWRDhIV1ljcEJ1MTQ3?=
 =?utf-8?B?YWtNNTdQSXN2cTMxNmNGZkdrdzZKVWV5eHhJSjRpRmtXa2FjS29USUFvWWcz?=
 =?utf-8?B?OXI4VzdMenBRRlN5SE4ra0pWQTdXUk5IN0hvUGtGcVR5TE5PV1FvUjM1akhp?=
 =?utf-8?B?NWREVDNNeVl5cVVUamFJdURmY211NWhQN1NtS1ZheE8rTTg4RmphNE1TZjcy?=
 =?utf-8?B?akEyTWFNbGJyekRHYzZ4RkErREFQMDg1eTYrSWJqb2h3eE5abTBEUGc3UHV4?=
 =?utf-8?B?N0JSeEdsZGNNdFpsUlZ4WTFPZmU0RG5NdHBldEs0SHUrRnB6MGFnNjJRWE9V?=
 =?utf-8?B?SDI1R1VYa1hoZ3ppczFjV2RZM3g1SG01Mm5sTDIwTEgxZ21FTkYxNjRkQjVB?=
 =?utf-8?B?WmhucHFQOGdWNlNxeU51NDVHT0JQWEx3eHQrK2QwUjk3d2NoeWd5cEFjQU4v?=
 =?utf-8?B?TFArWDdnSmd2Vnc0SVdXQmZnKzdzMGhBbkpyd3JkVWhaaVVNQnNGL2Q1cm43?=
 =?utf-8?B?NHlBUHNXMlU2T1VMcFNMNWM3aTZyWEtBWnJUZG56ekhPQUVtZFl4SitLWDRC?=
 =?utf-8?B?NGprRUsyN3U4bUxtZjJXTCtXV291Zm5pMXhsZUUzL0dUekM4b050bTIycHJJ?=
 =?utf-8?B?cVVHT3N2M1VpRkZXNDF4SFhKQ1hnbnVvNDBoUm1lU2RnVFQvNGZTejlpUW9s?=
 =?utf-8?B?MmhuaVB3akVaSmIxOVFUMUx1TjNnbTNNSGJHbFN3QUVFenhHRncybFMwYnQx?=
 =?utf-8?B?VGFLVGJsM2RmcUNjZmhYR3I0OE5yTEZHQ0JVd3JpdFA3RUQ2b2E0SjRBaWI3?=
 =?utf-8?B?R0ZpTTYvc0JVTU56R2tZVHloYW9NZ0pQd2NlVWJlS2w4aHovOGh6eTJ1SlU1?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 588aae2a-ec37-41a8-ad2b-08dda820f365
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:16:03.5768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/AdFM6ZxD+JyZoJOe/QOduUZndxgMVd6wKep2wx+SCVUxGXEAYOYn2jdqWZf/Jy2anbMEuYPYVq36CuDMKStPJfpRcpsYiNwFHfznGd0jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5085
X-OriginatorOrg: intel.com

From: Ujwal Kundur <ujwal.kundur@gmail.com>
Date: Mon,  9 Jun 2025 23:08:52 +0530

> Refer to the Rx queue using a XDP frame's attached netdev and ascertain
> the queue index from it.
> 
> Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>
> ---
>  kernel/bpf/cpumap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 67e8a2fc1a99..8230292deac1 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -34,6 +34,7 @@
>  #include <linux/btf_ids.h>
>  
>  #include <linux/netdevice.h>
> +#include <net/netdev_rx_queue.h>
>  #include <net/gro.h>
>  
>  /* General idea: XDP packets getting XDP redirected to another CPU,
> @@ -196,7 +197,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
>  
>  		rxq.dev = xdpf->dev_rx;
>  		rxq.mem.type = xdpf->mem_type;
> -		/* TODO: report queue_index to xdp_rxq_info */
> +		rxq.queue_index = get_netdev_rx_queue_index(xdpf->dev_rx->_rx);

I won't repeat what the folks above already told you.

I'll just add that you may want to take a look at Lorenzo's series[0].
Rx queue index is sorta HW hint, so it shouldn't be a problem to add the
corresponding field to xdp_rx_meta.
Then, you can expand cpumap's code to try reading that HW meta if present.

>  
>  		xdp_convert_frame_to_buff(xdpf, &xdp);

[0]
https://lore.kernel.org/bpf/174897275458.1677018.15827867832940584671.stgit@firesoul

Thanks,
Olek

