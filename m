Return-Path: <bpf+bounces-57553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B9AAACD18
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 20:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565D11C40416
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 18:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21160286423;
	Tue,  6 May 2025 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3bAWaqT"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89691917D0;
	Tue,  6 May 2025 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746555650; cv=fail; b=S1ZcrxWMaCySioFZb8YBZI0SMN6E0AMGG9iOYZtxXWnKyPxSOD8lMAI7a9UEuDTvf0ufJM0wsIrPvMc5g81WsH61s91E7olvbRItwg1EpxKixzGcYJZhciNfpyMxHkQWa7vG8hYuJSDobOPgI+ubWXCUt8ea0Ejs+OWJMf7XiL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746555650; c=relaxed/simple;
	bh=cEZRCCc7hzAwTL2SfpDNf6PsvIuh4n7ZTBheBe3waQU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FtZzEZdKbrOg/VraVSIDeomJCXtcG5R68m+eKIQjwJpS30R60/rdsVwsA7EtZmIkEYJA4+CuzmJeQiG3bm5OYOEaDvsW/yqjrR+R4yPnY4Ch3+GdrCbCdG51wKoredKATgChKe8jmKXNpBUEO2vqe3AGho+EtmujJKpopnWAaAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3bAWaqT; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746555649; x=1778091649;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cEZRCCc7hzAwTL2SfpDNf6PsvIuh4n7ZTBheBe3waQU=;
  b=b3bAWaqTmq0Ni/7Sgg8jnkbGRFmu/Hc1AoXDC9SuQbR08TLo9xNuzPQm
   Mb5gRRqwhkf42u+aRqqlDOHQBzJ7jTatqyMQwoWfi4p+Qq1GUdyp/7i5h
   T8LEsxI9Q4kNGgL2e92zJIO19thF0kKXey/MlOFMzCdPQanwZPqT07QNI
   0R5hXyOs7bh1D67iWUfksfXp8/7nUueFO5oxTWzFaKyikE/DMle6ttcrx
   m5oJszEuXDqTZDrge6qzKctmmTZOA8wS/eWRn/Gqz/ANBknVdAY1615yc
   KuF4PJ169r6tj8Avhe6BA2XVIESVPizdPoPKLy+Vn/uSinxZna/xGMmfC
   A==;
X-CSE-ConnectionGUID: GqhMmkyXSJGfKazidIEHDw==
X-CSE-MsgGUID: Z0ChJCJ7R0qN9cFk6yKp4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48383437"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="48383437"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:20:48 -0700
X-CSE-ConnectionGUID: tKHuSQTIQMCYw9uIOZ7XVQ==
X-CSE-MsgGUID: A5x+2wNdSFev2ww4tiG9+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140662454"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:20:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 11:20:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 11:20:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 11:20:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReAbPxuY+HA8ASXz+6jWVVuFcR6A7KONR1wra2XInSyEEQD7RK7XtP4GMb1mNmL70MYtSMjLyjQSwxp+qdTDL2cREp7RtNFXbmcq46u0RfUDYXYxczAFdaNLCFKGzhqq5XaWKzk93jr74l0vt1HIlbBJJooYfvLsmYJlAfAmtd+jDg1c3KAUc6T2om1T1Ebd8+wqMKfrns/R77vRjGUvSFKYq05k+F45xpZbME1y45hEbNjcqLQ7A7TSGeWS0piffSO08pC3W70pOET6yOyghouW6ePKV6QZ4OoQ5xu5NEA1nl19q3XXYW9oJVujPPq+N+yS4lCEgMO36XmC9Ko7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toA7BxI5MuKhLmPuB8d8f97E8BwN3Lnhm0yKTzGCniM=;
 b=GUHmrtOBoN6QPf3SSuzG8RGnJ1c6xkgm19byFk0ABj3gqDPS44TMPPvhCpPbIzGNGV6i579RSaQIH4wcDHWJVDEQ58iXOYU86kZbbfw+tX+6t5MZncZypmtt7jqRaabWAtPFwXq4H1R0bvxxVJYKbf/mA9f0jxXgk2h44DlQId+3VB8P4X2J9WVl8GJNwkLSEEDLeyBuXs8qdgYyNRXyYLpGCZn0dIJYmQKqhJulCcsugU9A5gwDB86sXz4pob4rduVmzwK2k0zYT2XlHrSICo7/iU8Q+NeQdGqP7Z9BqzI+fYf4b/BnFEUABcqqIi7nkaOLl0zfr2AoZwWLAVskyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM3PR11MB8684.namprd11.prod.outlook.com (2603:10b6:0:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Tue, 6 May
 2025 18:20:24 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 18:20:24 +0000
Message-ID: <85c03e3b-1a44-4b96-851f-b1f8a032c130@intel.com>
Date: Tue, 6 May 2025 11:20:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/3] net: ti: icssg-prueth: Set XDP feature flags
 for ndev
To: Meghana Malladi <m-malladi@ti.com>, <namcao@linutronix.de>,
	<horms@kernel.org>, <john.fastabend@gmail.com>, <hawk@kernel.org>,
	<daniel@iogearbox.net>, <ast@kernel.org>, <pabeni@redhat.com>,
	<kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
	<andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250506110546.4065715-1-m-malladi@ti.com>
 <20250506110546.4065715-2-m-malladi@ti.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250506110546.4065715-2-m-malladi@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:303:dc::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM3PR11MB8684:EE_
X-MS-Office365-Filtering-Correlation-Id: 729611b2-c0e9-4639-6ca0-08dd8ccaab23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2tOQ0d2U0ppU2RXZ1ZnclBUVWVVWXBOejd3U3RDZXVReVkwL1BJRythN1Nv?=
 =?utf-8?B?bkxZTGNjT3RuU0NlN0ZPQ2VwbHpKdnJRbUpGSlY5VTNUY0puOE5nYWNacldp?=
 =?utf-8?B?c2U1WVU0NUJMT2JUOVRIYmIwdzZOQVlkS2NNdGp1ZlFPRmpkSG1ndUl3dHUz?=
 =?utf-8?B?RHNVU3Q3WFVyTkxYbVdmdW5xbmFPNXBwZjJJSmdLb3Z3Vml5SGJmQmw1MXIv?=
 =?utf-8?B?VVJJT28vRHVpZ1BXZ1ZDbjBLaUJwdTR2Ym5xcVM0WGh6aHdNU3pqMXZLZkNo?=
 =?utf-8?B?Vkd5blJ4dDlRVjlNNXdOcFdHMjl3bjdVVmJDdFhIZVBDM2xvckdRRGFFdVd5?=
 =?utf-8?B?Q1pXUXVzNTQvL2pYU1J4ODVuTXk2WTdoOTdONWhDS3BBc0Fmd0l0b1hvUHVO?=
 =?utf-8?B?SDlabElhcmZ2WXJDRlQwT200V09uWVhIZUhkWUNHOERQYlhRM1B4Z3NnOFRi?=
 =?utf-8?B?UW9UL2tncTZkclA5ZmQwaGhkY2dZUXBNNDZSOHRFcFlKeDdKLzRnZjRSZG5O?=
 =?utf-8?B?aE1rYXpLNytnbWRCclF2N2JCeGQwSklqS1RrR2RHSmZ6MTdxcVZQaE90NGJy?=
 =?utf-8?B?aWtWWStieGpDdXdOSHduOFJTamUwNmg2V0daVjEzREJtTk1oSWZaT0NDa2tt?=
 =?utf-8?B?SWV2SEtkbjZ1bHRQWEFtUmtDSGZlNU90aHNoODdweEVESGpxMG0wREFuYXNJ?=
 =?utf-8?B?ajY5TkVzeFdKVUh2N3A3Mk1OaCtqRVRlTXZUQ3RZLzN3VXh1MlFFSXdGVUR0?=
 =?utf-8?B?YVJTTWpZaE9sRitxMS8ydWlNQzlZQU9LRm1oZlpYMk9XV0dxTy9ISUxKN2c1?=
 =?utf-8?B?TklVczhpckh6RlhuN3p5STdPYWt0K3JXdXJIVHFCejV5ek5acHd4bWx5aGFh?=
 =?utf-8?B?dHA2Ylo5Wmk1bnpsUCt5dGtiTG9yWXpkZmpsdmlsWnBWS3dmRXdpazduKzZW?=
 =?utf-8?B?SVVseHhlVkd6ZzFXSUFuanE5N3UvaFVJSGtUZDhySTY5eVF0UjZFdDZ5MWpi?=
 =?utf-8?B?Nk84NHVFcHlmWHBzR0x3Zlp2SmxWM0Rma0hXWWUzWVZPcENFWmZEa0N4STZj?=
 =?utf-8?B?VWVrOXFTektrdTFjZGRpbDZhcXNSTVNmYjliNGhMM2hxUVhIMCswRVlaOUtX?=
 =?utf-8?B?d2RpNnFMOVlicThLVFp2TkJMQnRFQVFNM0NpYlVsUHdKQXdCT21TY0Zuc1E5?=
 =?utf-8?B?c2VqTUl4RlkxaWVzQVMyeEZoc2gvNDhYODNtZnJkbFVCNW91NE5FT3NwVGtW?=
 =?utf-8?B?UnNMVlRiUXp3Umg3WEN3OEhDdzJkZ3FuMC9HU2NTQm5oeS9mRi9xYkpsQW0v?=
 =?utf-8?B?VWZrWXp0L29TWnd4UFpiNXAxYnRuMXp0dGcwcXFLRVRBMUYvNC8yRm5iZnVT?=
 =?utf-8?B?ZjM0eG9TM3VqcW53OE0zbmVXQVhodW5sUHpkbERUL1U1UzRTaVAyTFNJRkhh?=
 =?utf-8?B?K2NZdTBWQ1RkOHJ6aDRWRVBQZVAxUDhDL0dGY1BXbWw1TlZUVWN2ZEM0NkZI?=
 =?utf-8?B?b3ZWZ1BBQnpseXBrRGFNYUdwQ21vdjkyN0VpZEJOVElFY0U5Q0Vrd0pWaWJh?=
 =?utf-8?B?ZkVQTU5TVWgxcmNIY2ZxNHoxaGdLRUhQUVp6dUlHL3RLUzhPSUdvVE41OHpt?=
 =?utf-8?B?aUV1REhRbVpGaXlpUW9IVXFzVjhHVldGaUt5Q2tCTXZZcHhZcGNteTkwdnpF?=
 =?utf-8?B?anFQSVUwamI2WVc1ZkxUSS9rcC9wMXJQbWNoaEZZZTlXeklKMnAyNm5zZXJl?=
 =?utf-8?B?NWQzNlhac0hSWURGOUM3UFlNdlNiM1FtQnk4QXRFamVqaHJIZTVWM3hsLyt2?=
 =?utf-8?B?cFM4MXBzR1JvaXBnWDRZa0F4OG9nZEE3VUQrWlRvTWFIejQ2OU5LK1lHTnNC?=
 =?utf-8?B?MlVzWDdORXRDN2dFOFlCRWlha0tGNVVQQmhoU3ZySlM4Tlo1aktWQUN5cFU3?=
 =?utf-8?B?UjdBNEUvM2ZuREdxVlJaQVJQcFFjSUM1ZFpTa0JUS1FDSG9EbTVVcmZpUzZP?=
 =?utf-8?B?VU8yRlI4bmtBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2FBblpuUjR3YmNidTdjRktPc3ViL2lTWkdIdVl0QUVDY1NHYWNNa2g0WmpF?=
 =?utf-8?B?Ly9JcExYSk5aOWV5bDVpZG1yVFNKU3VWN1d2OEZSRGwxZDNhU3pWOU1ZSzhJ?=
 =?utf-8?B?bmozZ3g3WmRieFpIWVpJdUd6eUZQSUh0MVByNmNxdXJWRjV3VWFiWFZuc0tH?=
 =?utf-8?B?MUVKYXhoRVFHUGlvaG5ZRUw2NkVHQ0xwOWFWOHVLSHQxY3BSYlNiRC8rQSs0?=
 =?utf-8?B?eHVzU2VaWnVGZWlNTGlLOWtrMGgzZkhta1JUM2tkKzc3bzZyTzJJcGtGY2JY?=
 =?utf-8?B?WGROU3VhcWhBMVVyLy9BZUhqZGR1VjR3ZVZ1ZjE0dk9DdkpGbEZFbGFpVFJ1?=
 =?utf-8?B?Q2YwQ09ma3JoaDVoV2xLbnJDcWY2Mk9MS3ZwTWtWSENiVmdjRjhNU1ZFZ1g0?=
 =?utf-8?B?VWROVmJOUDFyUTZtTGx3OHZFdldNQjQ2dVE5VnNsTks0QnYyUFl2bXVRUzlZ?=
 =?utf-8?B?cTZYbk52Y1dYZHMyWVFWUEFPTE5OTTJoNW9rMElPZWJVNEpqcWVWSGlxMDBP?=
 =?utf-8?B?NEE0VS82UDA1SzZjNmJodHB1NGtDN0JNckJhbUNPZWU5ZjhOT1V1U1hrdUlW?=
 =?utf-8?B?MGZrNzYvMW1hTDVPSU14aDdMUlpuVm9BUFErR0kvU2hWZjRHSTQzdkcxRjhT?=
 =?utf-8?B?Qks1eGV4M1ZYTktrOFFTQjV5SmdEdUFyaCtETXZiMmVCMGRMSUpsZXp2YTAr?=
 =?utf-8?B?UytrSDUvRTYyUitXVUxWaFc5b0YyNFkyWTh2Z2xkSjZNMjVpbEd1Zm90THRM?=
 =?utf-8?B?Zk9BVkhqVUNjQWI1cDJBU2FvZ3NPdWxWMHlzSFNZMmtheko5Z1p4ZS9kT1hQ?=
 =?utf-8?B?SG5Zc0JyK2krVTllYUJhNkJONEVDS2EyWUNHS3ZDSml6dm4ySFg2TnBVZkNz?=
 =?utf-8?B?K1JFUzFaNDZSQnc4UHBwalFqRVU2NGFLTHZsSmUrNnFqNXhCclpTZVdiVU1a?=
 =?utf-8?B?bFNTdCswTmhWaEVvOGI4eGlGcEFrMXJSa2VkNVE0dnlaZ0d2ZEMxQVcvY2I4?=
 =?utf-8?B?QitDMWd4VWdMZDNlbmQ3ajc2Mk1LanVmVDRYb2VqSThSZG45VkZ0a3Jjd1Nh?=
 =?utf-8?B?bkZ3V0VyUWVUR2Q4TXRFbTdFM08vRkI3aDZCRFY4MHlwQkZvdUNuQi9oTkw0?=
 =?utf-8?B?SkZ5MXAvOHhMMklhWW91M1c2dVhvb0NkZnNLczYyVWdiampSUVZURG1DZEt6?=
 =?utf-8?B?VXFJWnVxZHVmSW12RjM5YTkrMGc0a0dLV21UVDZHTm1TRlJTQllZS2tyVEEz?=
 =?utf-8?B?eDdiMDZoUmp1UzdPVVFGMmJ2RC95L1FzNGJnREdxOGc4bFFOMitFWFprZDVG?=
 =?utf-8?B?Q3NKdVM0VFpzK2U5Z2srTUdGbXE2UEFacGZBdVE3WHpXSSt0amZWRHJGN0RN?=
 =?utf-8?B?LzJHSDg2SjVKRWlvbUpDS21QR2lwS05jS3VqMGNlbXZpVFdwalZ3bmgwZkYw?=
 =?utf-8?B?ZjlIOTR0VWV2NmdkYVF5b2RwR2pORGFGVGNtcjYvN0RYVFkxOHROVUtwbDdo?=
 =?utf-8?B?ZllWTFpCMHlLYTVpRFo3Z1lHOG51NHl4ZllZNndiMkxsbFIrQk9rcGp6Nm9a?=
 =?utf-8?B?Q1hjZTNIR2E2RGZrOTl1VUpUdUlrK1NnNXhUK3k4dmw1M3lJKzlWdUx6NFZB?=
 =?utf-8?B?SC8wUkJBVnRaazU5c1JJdnhBYWNRdm1pd2E4VEpRZXlUS0owQmxiVFJFeWF6?=
 =?utf-8?B?cnhPRytGbXZRVlZQd3doeHN3VTVuUWVNd1p1b2ZVc21HcEpPSFFqRjRRZ0c2?=
 =?utf-8?B?LzFqVkFlSHJuUnc4RTJJQW5maDcrTGd4SGRzaGsvNTBsUHBaSWh0ZGNhVm51?=
 =?utf-8?B?VFR1SXp1M3ZGQXBmdnY1TTlNUVFDSkRnSnFnMnNiWmNrYVBLWjZCQ3FLT1Np?=
 =?utf-8?B?aTRCVWcrc0lrUGo2YVk4TkN0bzlCOHY2VVNsQ0dpRlQ5SHhLZWJRbWo0RHR1?=
 =?utf-8?B?MFVYM211SDNXMlo2bFhZditmQXBFQ3o1MlBjc1RuU2hQaEw2YjR5NXhqczh1?=
 =?utf-8?B?RjRvZG1OZi92cDh6VnJmVnY5VXl6em45MVhGUW1QV1NWY2Y1OU1SRTk1all2?=
 =?utf-8?B?c3ZXRS83Q3gvS3N0cUNDNVl1NWJHQ05BZG1sYjREUldYWUc0b1A3YzVVNy9j?=
 =?utf-8?B?SDJMaTlzbGRncmhzSEdwNVkwNXVoKzkrUFRWUURkbmFpeDNLU3N6eGhRQVJN?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 729611b2-c0e9-4639-6ca0-08dd8ccaab23
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:20:24.2344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7Q5qJ47ZXKBQ40NzfFblrNL/4X/1nRtn8RheroXA1JqYgwb6udKk3ycSAssfEgiZLUkS72gfMaDI5Ey9kXLy3w6R2oZ3UV02GtJObE5++Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8684
X-OriginatorOrg: intel.com



On 5/6/2025 4:05 AM, Meghana Malladi wrote:
> xdp_features demonstrates what all XDP capabilities are supported
> on a given network device. The driver needs to set these xdp_features
> flag to let the network stack know what XDP features a given driver
> is supporting. These flags need to be set for a given ndev irrespective
> of any XDP program being loaded or not.
> 
> Fixes: 62aa3246f462 ("net: ti: icssg-prueth: Add XDP support")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

