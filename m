Return-Path: <bpf+bounces-38878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2266A96BDFE
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 15:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48601F21291
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 13:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089CC1EEE6;
	Wed,  4 Sep 2024 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gahQFYNr"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6479F1E892;
	Wed,  4 Sep 2024 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455712; cv=fail; b=aIjxmN3uhFK3RR1r01lDPshC9EtKiabY2m4U9TQ0H6y8JDm6X/eaYzd+NgdzStIHcBwBsNz1X9YIPYFe0z1sXO0xagD5L9ayRoa/fQLbDbMwQQI2/X9vrYtJ2Zkt3ZigHOsUHx3nASD5+dFWYsA20ZqVEvcC8kYhawoU1TvrZQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455712; c=relaxed/simple;
	bh=HWW8dtI6t0vViCDviS3FNOaZd6NhTLDtGr1e7pMtBww=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H5bNWkhgwCVssK5tZxGj8T2ULEg9l1m1Xdy5Zgw6qXRbI2IBY+Uch2T+CCMXofoYUIhDjPyWFjPL3ctvAiV5aGhd+QYvzvxz9QXa9V1tnYVQ1i+AjTUxJhzxqzPq6NFgkMwvPS1LdyFBq4NwWRUHzdFovvgBy3+0Fs/bFpQZbB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gahQFYNr; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725455710; x=1756991710;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HWW8dtI6t0vViCDviS3FNOaZd6NhTLDtGr1e7pMtBww=;
  b=gahQFYNrr9xHWKFo3khfhpkbZIOo9gY4OEKho0eF4f9ts05NPDD3lvsi
   4E6TaeKKDBHm4HxXAtJuRUcx4O5T/bhHN3x0oZ8wKRFZPS3gqjn79cEsZ
   GxLG/wCScUhc0gFOgZUylgZFbf2Gi7uTuh9E0MEOwRw1/JFSNphOzrwbM
   rjSEKkmURCAk+Acrjl3McFOsmXpNptM+ZtHxrlWZsqSBLB5pBy41/njwk
   PmoFahQvlbvV/Xern2oY1Itlt/UUehw7RMA44o0U+ZjVWtZ4DX1SkAIcZ
   Oe0nByWcojt7rfXMv/K5CphomP2enIc8xW3l7vcIbtVeEscyQW9gUQaff
   g==;
X-CSE-ConnectionGUID: BauoXSuNQaun+8MKri0tZg==
X-CSE-MsgGUID: jAtdch7zRjezOmO2bFSYyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="35475723"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="35475723"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 06:15:10 -0700
X-CSE-ConnectionGUID: H/z7svUuQaWY5QcAzLSO3g==
X-CSE-MsgGUID: OSp7EVWPRnmsktrzxoQmnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="65308558"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 06:15:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 06:15:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 06:15:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 06:15:08 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 06:15:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6NnwzBUUxOR2WrfbCHTg3JT/moXzBYfRpsHJJ6ecPx6G7D0Ql0oQHF9ijN8nyXlo+8o6sCDmYAt2xoYnjQWzahXpBZEKUxKFVsIbeS6HnrNiFgTwyFBkdNDzYKS+phGH89Sqe929/9BuyJHEZ6MS9MD45JUKf6bzWC9XGmu5zOMWkrOrEAdJ3kCroOhw0iOwZhZjJSEX/nMSEwKOOGZ+wC1kPFRHut197zVaqLmgBs/+Q11gsAHjV5MUimWG2z2o6wsnAiPUNfvUTKqTH9ox6oO0uphdzFF58h4y4tKXHBTd8kUXZZ4k2+kpk7VSui7FKqtdFqLeQAfyQZ73El+/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9u+QClXbnhaRELEVs2IFqduMYtFPqvpP4oSLm51UUZY=;
 b=muah3J+SBjnl77clnT2i3ni5V3Wnr2yHWjy/LNCg4QqZNHDFMR9C5dBlipEuLcXbGRc8Ft6YWIljpe/WauScrZVm9qc/EHYIp5CT8IfQ9Ts8csPh0UrX3P6bpoqu422JpTUtCvaBQ5WQkmTQJB2sTr+c4f/y7EEy8YPtPUp9PcOR2ACoCLhLrvVqNcnRoJ+6Qy4z/PDhPfou5smEYeoeFeosNLbg9ERtQ7qxENiyZWqHpZNd+geKTCYz2YhQoabLfvZhAfk+yrQfHO5Iu0ctA5R8FvYdRNvYLRBIOhnU78xqGw8a8+C8Qk0gqmRWXE2G2GL5PeqFvP/c7lARxCGXLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV8PR11MB8698.namprd11.prod.outlook.com (2603:10b6:408:205::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 4 Sep
 2024 13:15:06 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Wed, 4 Sep 2024
 13:15:05 +0000
Message-ID: <f23131c1-aae2-4c04-a60e-801ed1970be8@intel.com>
Date: Wed, 4 Sep 2024 15:13:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/9] bpf: cpumap: enable GRO for XDP_PASS frames
To: Jakub Kicinski <kuba@kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, John Fastabend
	<john.fastabend@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
 <20240903135158.7031a3ab@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240903135158.7031a3ab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV8PR11MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f288aa-5d7d-41d9-34e4-08dccce397c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amlFdS81RlVhaHFtdFhPZ0YxdUpYZ2U1eFppdHV3WnAzSjBERHZQTVR0Q1RK?=
 =?utf-8?B?emFwcXh3eTFqYzBVWHBVY3NwTG1CeG1lMzZUVlJGenpoTzIwb2loK0tOOGFt?=
 =?utf-8?B?RHkzS2xHNVBHRmFCbVhEbGlEMm5sLzlYVG13Wkpma2ZEcGJpeTkrdVgwQVVu?=
 =?utf-8?B?WTI0aDRpR2lGOTZGTnlqWENWV3M2dHVLRnNIUjd2TG9jT2ZvZHJiSWxJTEV2?=
 =?utf-8?B?U3hDWnUrMUZnWlZSL244UysyWm5NaVU4bFh3UG9Ec1hacHBORkVjWHZQMW14?=
 =?utf-8?B?U1pNQ09XK201WDlVcG1XMlRjaHJwcnpXU2lqbUdXQjltUlRUZFMvL1BQYkZj?=
 =?utf-8?B?NEpqL3VrczJ1TFdrQjVGVXhoVGpPRHVFakN0S2N0SW9NK3JkSTZ4eEZuQitF?=
 =?utf-8?B?ZTRINVliaThMVUc1SDNCUVF2ZXNCbFpyM2tDaFB6bzcxbjJROVAxL3ZJWmFW?=
 =?utf-8?B?dFR0MGNzWjBIL3Q4TkxxWlR5ZW52NXpvaTVINUg0dHVmUTlORklwMlJ3ejVN?=
 =?utf-8?B?QkJ3ZVFvbk1pWFJ4WkNGNDFwcmFvRlJIelB6dFZuQWF0dEVOcm9xcTNFa3Fk?=
 =?utf-8?B?dVQ1UCtySjdYRmtLRkVsNDYrLzYrZnBGbGNoYklCd3daaXBHTExEOTRGdktr?=
 =?utf-8?B?N2pqUjRlNFFVME4vVmV2ZlJUeHN0S0prVHo1RHlGZCtzcWloOUpnMWFMNkxu?=
 =?utf-8?B?UjN5WFNyYXJKR1B4SjZ2VXV5QWh0L1c4dUhyYTQwU0l0UTdtR3h4dlRnUnQ4?=
 =?utf-8?B?SUZmaEVBMXl4YXdnbWFrL21LODZLdDNvTXN5N2Q3STI1UWVTZENkSTNseHBD?=
 =?utf-8?B?Nnl2RmVuU1JoOFlKTkIzTFA4cExnSHFwL1Q3N3JnZHUvQ2RTYVNpUmd4ZGdW?=
 =?utf-8?B?UUVDc0JzdGV3MjE1RXRoUVdqRm1rQThucVRnSTNUaDgrd3FocFNNN1RQV05S?=
 =?utf-8?B?MytoMlM5bTNpMHdyeVFudGQ5MUN1b2VVK3U3dktJTmpwRHVzSythcW1hd1JS?=
 =?utf-8?B?bFNYZFYxOVFsYmF2R3EvWWRKdjJOWW9UYldkeGRjL29YaDlsLzF5cC8rdWs4?=
 =?utf-8?B?NlMxUjZpUnZ5cG5YazkyQWhqREk0UkN0K2UvdVowNEhjOWNaUHN3U0YzNVRX?=
 =?utf-8?B?eDhTMHVMV3M1Z1VYRm4zekowUlpSaitlSnpSMU1MVTZVTjlnL3NremxSZEVL?=
 =?utf-8?B?UVVxY3lzV0VnVjhweklRSWt5NnFnQ0h1SHhlTElybEdoeXlEWFZRc0tGYWVV?=
 =?utf-8?B?MlQvQUpVd2Flait6T0NNL2l6NlNHdmJ1aFZuTFBGTXRqN0VRTHQrMC8rOEc2?=
 =?utf-8?B?bzdWVmtUT2FIQlc5QTArQ2h4TXYrOEp0OWMwOHJuMlEvQnRNOHBSekdIWVI0?=
 =?utf-8?B?a0xQUHpTUTJmWEk2QlZ0ZGZ4a1ErV0Q1REc1dVN5YzNZejBZVUdRVDdPanJs?=
 =?utf-8?B?akwzMGRIMlpmWjNWczMrWEpPSWVOcEE4NCtuWG1XYVUwNGFqSTFnQjBmQXJq?=
 =?utf-8?B?bzBDSjYweitvSlh0M0hxV1FvNG5pNyt6Mmc1RVdHWmpncStFdTY1WUNBOHRV?=
 =?utf-8?B?a3hxNFBIU1l3bzhlaFBJKzhPOVR2ZFdsODZ3WUh6Q1BnY1JQYWVwUExPYjRa?=
 =?utf-8?B?UnJFZ0NtdmIwVkZEMTVMNzlxRWVGOXUzZk5jME9PZ1RkMmtYQ0NsS1hIdksr?=
 =?utf-8?B?ZW9CZElUcUNFV2ZMTXFvbitkQzZOZEZrSTBlYkJnbVIyUlNVbi9YY3pLYlBS?=
 =?utf-8?B?K1FiL29VUXZKbVEzKzloR0ZvRU1jVzcrTUNuQnBZU1hHOHcyZVd4MU9pTDFG?=
 =?utf-8?B?VmFSSG5senM1S0ROUHBNZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFN3ZTBPUk1lb1hJaTRlU3k2Y0dwTTJaMUZHZkpXSFgwYTY0N1BJNWgyVjJD?=
 =?utf-8?B?VHZiUW14ZGlxdFkxVFBTVlEwcHNmRnY3UXgxM2RLTFcrcWF4VERKWC9rMmtt?=
 =?utf-8?B?dGxZbisveS8rRVdMZUNZZHFyQS9zSncwN3ozU011bm90ZEJvRytzZWNabjlE?=
 =?utf-8?B?MWVrWm9LSEpRQjRXOHlQdll4QUVDbFB3WG53dzd5MldaM1ZoM1lQWHB3c1lK?=
 =?utf-8?B?cWF0YlE3MGhCcUhqd3dlWUxiU1FybkN3WGRCWFVwbUJRZVlwNzY3UzdmYVc0?=
 =?utf-8?B?TGxrRm5LbHR4cjlDdlAxSEFjSVM3WUgwbHdCQzFrN3hERmcybzNSNDVCSG5x?=
 =?utf-8?B?TW56c3hrT3pjQjFYK3hZaGFqUzJFY2hncTNWU0lSZU52Tm8yS05odWFEM05z?=
 =?utf-8?B?ZWk0N3NDdUluTEx0UTJUZDNqUS9hTExOMmlwMng1NzN2ZmpuZHF5eXFxcytU?=
 =?utf-8?B?cVR1cnZpMThpSTluR2Q3Y0VtZElUc1d5b2FJVmFTcjdrZitUS2I1OXVCQktK?=
 =?utf-8?B?d21lMHc3ODlyU1NBemZKRDJyMW1jdEl2UEQyRHZsZmhjM2NLTS95Y1pseWww?=
 =?utf-8?B?WnFYVnBaRi9vQmNMZll1VVp0bHpMc01BUEJYTGlYTm43V3R1TG80dXkwMkZ0?=
 =?utf-8?B?ejh5elVlMjhYeDgvSFp3S1RHbDI4ZVFtSGgyQ0VLMUwyRU1sTmc4Q3JmbFY1?=
 =?utf-8?B?SGk1aUJsNE1RcURVbXFHNnpxTSswQUpmQTlrcEhRZmIxcXJkQ0JFVkxkSWVK?=
 =?utf-8?B?NDIrUjlRc1NDMTJiWWVKZUIyaUg1V3N3YVN0c0psZ216b2ZIYU16ZWplWDY0?=
 =?utf-8?B?UU1tS2NIMGdNc1pMZTQ4Rnl6ZXBKU20vMS9LdUxoZmF1QmdYVDIwdW5uNlNN?=
 =?utf-8?B?SFdvc2ltcnRlaUFwOVVFZGV6M2E3aTh3VFBVSWQ2dlpRVmkyaGorMGFIMW5w?=
 =?utf-8?B?SEF2RFNVNHN6dGl6K1BxeE1ZbGpheEU4L3hodUlFZ2wyOWdRbXp1ekt4TEpO?=
 =?utf-8?B?d21sM1hoUzNTeTV2a3VTVFR6LzZRd2cxTXhqY3dqMzU0ZDl2S3VDdjJsVFdW?=
 =?utf-8?B?UHowNHhwcGQwL2d6ZDRMcjhidk8xOXYzK1hjWi9JNUtvS3RSSmNWMnk5M1Z4?=
 =?utf-8?B?NFNIY1h5N1dCdWlPMWJQczROMEdtNUZhL2lFQmtLRXk4WWxQMHE2b3l3VFFp?=
 =?utf-8?B?WjliTnFtUm5pUXJwbWFEaXVUTkZvUlBVQzBpSy9ZdmRkOWFNbzdBV3ZSNy9R?=
 =?utf-8?B?aE5pVVgwMFE5V1E0VnJnODdJNzB1bWdkQWEvd3FDaVg1ZlIzcHp2NHRMb2JF?=
 =?utf-8?B?TmY5OElEbWNsdE1GbFplZmp0UUt0NUtFRS94ZFVubjZFWGNERDZaRFE2dmJQ?=
 =?utf-8?B?ODN4V1VycDh2SEhVVWkySDN5MlQ0WHJNZ21tNUFaYW00YTNhR2NabU51L21X?=
 =?utf-8?B?elkzWUZaeGZ1K3Q2RFhGVjJFaVEyMEJTN3N2K2xBRXVlREluaVp4eVJPckVj?=
 =?utf-8?B?NnlWc1hGZzVCYmJCdldwOU1QVVZudUpObGdoM29NWjhCY3cvMnFTaVgzdm1x?=
 =?utf-8?B?b1ppUDlzRkcyTzZoU1llNzFHcDZucUhyN1M3K1lOb2EyVXpqemJ6WTdhTm9w?=
 =?utf-8?B?MVVIcys1STltekdyZEwxY0E5elloUjBPQWowQTBtWUYxdGlDblZTWE9VMHpO?=
 =?utf-8?B?dHZNc2hFZ0dieXNJanlFeGRGZXZHS1FNaWc4RTFEMlRvemNUZ01IQncrQnNp?=
 =?utf-8?B?N0pGcGp4UHhYY2Qxam5iazV1NTBpM1dPajNuc0N2Y2dBeER2OEtRM0RIcGF2?=
 =?utf-8?B?TnMyVDlOM3pRNEJLdVloMmw0K09yazRuQ2dOdDR1TWlwMkpnR3ZnN3NYSFBZ?=
 =?utf-8?B?M0IrNndDaWIrMjJFcVBuYmRiZVlBeWJScjNweU12TTBySmgwSU1UNll1cVcv?=
 =?utf-8?B?bnpSV2lQdHVzMXkraS9kQTRscXBaa2czZ3gxdlBGOWZCOUNrQkN0NC9vNDU3?=
 =?utf-8?B?ZGNUMFFtb25Ra3RrZ1E1aExKSW1oQVRldmRkTTdkNzhtaVphOVloYWc4WkRw?=
 =?utf-8?B?NlEzeCtCdjMzcXZyM3RKRkp2dUJvajE2SUtoTkc1K1R2RlZyS3pENHNsdksx?=
 =?utf-8?B?SVp1S2tmWFNneW05Qlh3SHNSRkExL3pPOWI1UTBlSGV0VHBGd1JHcTI2MDZB?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f288aa-5d7d-41d9-34e4-08dccce397c5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 13:15:05.7200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3Vu+6aX72IvL0Q6gNBmmEr5svsW6gFnaUoEila4K7VdMg4wYNOM9B8o3DqNdDJcCKBZGqOUVV/zOtlFi2DUHJSF3A/uhv4lCiht4kt5l6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8698
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 3 Sep 2024 13:51:58 -0700

> On Fri, 30 Aug 2024 18:24:59 +0200 Alexander Lobakin wrote:
>> * patch 4: switch cpumap from a custom kthread to a CPU-pinned
>>   threaded NAPI;
> 
> Could you try to use the backlog NAPI? Allocating a fake netdev and
> using NAPI as a threading abstraction feels like an abuse. Maybe try
> to factor out the necessary bits? What we want is using the per-cpu 
> caches, and feeding GRO. None of the IRQ related NAPI functionality
> fits in here.

Lorenzo will try as he wrote. I can only add that in my old tree, I
factored out GRO bits and used them here just as you wrote. The perf was
the same, but the diffstat was several hundred lines only to factor out
stuff, while here the actual switch to NAPI removes more lines than
adds, also custom kthread logic is gone etc. It just looks way more
elegant and simple.
I could say that gro_cells also "abuses" NAPI the same way, don't you
think? But nobody ever objected :>

Thanks,
Olek

