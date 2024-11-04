Return-Path: <bpf+bounces-43891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D4F9BB802
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 15:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC804280788
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 14:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E4D1AF0A0;
	Mon,  4 Nov 2024 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LBcE+van"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D891CF8B;
	Mon,  4 Nov 2024 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730731106; cv=fail; b=QciKBjlUgmSagj9/g22gwUBOE+cEGmC3zBKC9V1S8x8FFiy3s9DZHB7F1fZq/a4N1/n4iSIHLytrSxeeF7GRGfxBapXl4fHQp+HC2xSzQNPdXQI8jLw15DyF12dH/3ciD+DDYA0WwMvYNoU8gDklSrmwoF7nGPNlmyY1rkhHLaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730731106; c=relaxed/simple;
	bh=Fbh3csbwEABGbrHBk4LSNweH5PxgcrTdLa19fnPUOo8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V5rqLXEdKQdr++mJ5K8oa6hgYKpcJm6YTLkl52YaDT5kRAjd1RebCbYTJZ8i0M62t1iQgw2o75xncJ+Gg3BfT5gKpI4NG/HPtzQ2d+KanwJYUJcU63appmMABZlE/+26vGx3G5+we9RnO8ZGOssf0yJHLblxwjyAq/WEiCA6954=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LBcE+van; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730731105; x=1762267105;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fbh3csbwEABGbrHBk4LSNweH5PxgcrTdLa19fnPUOo8=;
  b=LBcE+vanzchev1hlgmRkryFE2XgCnvDQCV6wwdWbm7qQ2gRc7Md2TQqG
   yFnu7hOqy61P/xyMvh+65LQAlg5vGa59RmCRKcX2fICyQUWFfTTFn1X4P
   3oPk8qldqP53wNFuYLNzo6ZHZ/2qIUMWRlP6SXBU9aEGyIke1wYemjPdu
   BMlQ8rARXrf7+V+tvdlV+Lmiwl5keQjuiJa9/RwjEUZw/YYNOh8IfGFOr
   9ROWjrsmGftaI4Xy+28I9zMjLuOIrLtoPz70CDLVX0Xaogbz2cGSNILNM
   CrUBS8IKU/eOr8VMKW1Zv70K/gVuH1hTVTumCcniN3Q/n0uKgrdOcVHJG
   w==;
X-CSE-ConnectionGUID: Z3Trl/n2SQyvsdTUeQ0HiQ==
X-CSE-MsgGUID: P+Ua3PULRM24R9DLqwruYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="41820799"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="41820799"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 06:38:25 -0800
X-CSE-ConnectionGUID: 1dLdP+icRuONaYdTaVkV+w==
X-CSE-MsgGUID: 4v9fdCd3S/y/gPPIPbI6Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="83195889"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 06:38:24 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 06:38:23 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 06:38:23 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 06:38:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3vCRvYPdD26dXdnudb8w0y1HOoOC9SA5qIjIoF75fmDWsXwEGCNeOhNPqQumaai8GLQ4mxgQJK1jweh9va0P37D/Qdk7Xv/qcfwelX/kXVbihyS15IfsCH880RkJwIGX5JbPH8LViMuDjpXqagLhtCd/NzozLtus5T6V+O93wCa0mgoBAIEulyAoWoywBq0+UjyzQWEAk7WwfgzaNNulwgWfqyoDGoC5yB9XjsYuh7g4Sx8cRDZWbspFS4vOWLEwKw4nBlNdLl4CyY3JFv+Usdsgrbh9JWmfKY4T3eRrqcXG8xU+9+ozqoD0B1EJdsR6xXWVDQYdC2OKOQoPVuS3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0/dcl7wesCQatH5cZkRnaGB7oAxYULDKWPm+R0/p94=;
 b=qhBET6Hubm8pg2IwtdP0D2txGIfe+TOBEGTvRVEkZD4xqivEGc21EpefhRBsFCB2VIuapl6Hk4gAJn9sUjEiYO0rzYMehUue31DSj3Y4lfaU4Tk51UCT+C14o5TAjmjJkzSkNzhHBL2xxpnNvgVdeGK0Ao5+4J44P6S7P3SsbpLa7pGpTjHEeb5iJgFNRiwmye2MqMzSgctt2HxOqX1X4yEmhpGxIhMqZeL7nP1zu7uRlUFjRIcCvuDfQt1qeJU2mlUehx92+Nq02GzqErqRlsm+I5yhZNr6wDhR940TkxyQVVbWcU5qQ1K5mX3TaIFeMlv+RK1B5BOEH3K1jSnsuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB8435.namprd11.prod.outlook.com (2603:10b6:610:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 14:38:20 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 14:38:19 +0000
Message-ID: <4068b108-bd5a-4d09-97e9-4f9196b35eca@intel.com>
Date: Mon, 4 Nov 2024 15:36:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 10/18] xdp: get rid of xdp_frame::mem.id
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-11-aleksander.lobakin@intel.com>
 <20241031174107.02216ff9@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241031174107.02216ff9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0060.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB8435:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1a3217-61ce-42c8-4b2d-08dcfcde539f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDduaHJJR3RpeDVETCtNRDJWWGRmcG1BRWkwNGlEdjlmK1RCZ2xVWThBTzFK?=
 =?utf-8?B?OFRwa0NwM0I5eDg3aWJUTlR1UFRKOWVpOEtUS1lrc2ttdjN1czV4K0ZWNlYr?=
 =?utf-8?B?Y2VIdkdDYlhBa3lEdzVkbEJRaXhuR0tiMmlNNnJ4Rlh2VGY5dFEwYXR6a2xr?=
 =?utf-8?B?U2YxZ0Mwc28wQVd5VE16eTZZU0cybzl0TFhxQkV1ZldXOUE0c1Q4YXl5ZFJh?=
 =?utf-8?B?Q09PVC9tZ2ZRZDYzV0NEekU0RUpvRVNZNWg2QWMxcGhMVTMrNFRINWljSnhw?=
 =?utf-8?B?ekgzcWgxZ2R4cUlFYnFmaDFWaGhDeUJOMmtTM1B5M00wK0pwaTBTQkRTTUtq?=
 =?utf-8?B?N3cycGdzcnZiYnJWWnlPVGU2QklPSW04M2pGanpVTUhaQkdxOVpYbzlYOG9U?=
 =?utf-8?B?c3pvMzlCSWtaV0prOHVMckNTdHUvdG5aYSs3MXc4TXJwMW5uQ29BZ3JDdzNH?=
 =?utf-8?B?M2pWdlRzMzNmMmFIdnpQRnpQOWQzYi9saVI1N3ZPQy9Sb0UrN0tEbGpXUVpZ?=
 =?utf-8?B?eXVwN3lpZ1loZ3dDdVRUQTEreGFhbHVsdEM1cEtlN0N5d0FaTFBmZlJlZ1NP?=
 =?utf-8?B?WnNVc05hL0x6amt0UEdkbWdlSDA2emVrZyt1bkxCVkl6Z2hkaWNheExyRzA5?=
 =?utf-8?B?Y3NuQ1JTY2hNYlE2K1lSMFRuM2lGVU1BVnZBUmt2SndXWDFTd0paUGV0QlU0?=
 =?utf-8?B?cEgvMzhIVHFNY1gvM3ROZE1YZWVTOCszSWhTS1VRcjloY3JuNWxOU01VOWZk?=
 =?utf-8?B?S2taczhtTVdJQUM2QitOalNNL094Zk84ZVRFSEJuV3lKNmNYSy9PZFIvUlRN?=
 =?utf-8?B?cm5hTGx2M2hiTVBYTlpVVnkzZkF1L0xjWXRCTGtjTXhtV0c4OFZYQ3FTZVJm?=
 =?utf-8?B?aXljL1JGZnJGTjVyaXF1aWVuWmplQ2lZRnBzTnR3TXgxalBqNTFCRDFnTGtu?=
 =?utf-8?B?SmtGN2xUbytJcFBSYjFKaWMzazczbzRNdjJxOU8wTWIrVmxGNnVxK2ZyWG5P?=
 =?utf-8?B?K0VEL1MvYjZ2U2ZPdExUVlFIUGJNcCtEdm1IOTdIS2s0N1N5WWJHMC9uSzJT?=
 =?utf-8?B?UElHR1NSMld5cTNTM0NuRXB3ZlB0WTNIdFlQQUtuVW1FOFh5UWNGQ3pEb3d4?=
 =?utf-8?B?OG95WXYvQXNVRTNzcXlSSkdNWVpoOWYzOWFIWVY2b2NBVnZQV3c0NWpOSTNI?=
 =?utf-8?B?OUx3cTVCOVM4bjUyUHRwc21BOUhjWXdyYWkzRGJhRXlWbzBtYWsyNENQczFZ?=
 =?utf-8?B?VUs3Tnp3a01VR0xZSk42clZoY2t2RGE5OXEyN3RkbStiMXJtOVZLSEc0QWhG?=
 =?utf-8?B?L01QdElHZ1hiNHVaQmZuV0doNGVuR2lzL2FjTzMzRng3QjhSWmMrQmRaWnpp?=
 =?utf-8?B?N3BWaWdCcmtNSXV0eEZYUzFDU1kzV01aLzk3dHNJQUlrQm1yTkkxY1dhald5?=
 =?utf-8?B?eHdpUDkvWTZjVHZyWU1tMC92OUdZakE2enk2R0hpWXV5OU40d2dRRDdkVUky?=
 =?utf-8?B?Z1FQREZUVHZNc1VFbXBwa2srYVJaSW5PZXVkaGhYUmNpc01KaXIrS2V4OVhB?=
 =?utf-8?B?M3YzWlNtNk1LcDJud24vRUU1OFdoU1RxcTNXZU1TS3VXNWZraUFWR2c0RDJu?=
 =?utf-8?B?SDdVdmRuaytUVEhpUDNsU1E4aStCb0JScVNTVmFybmpaTjJ3czFkckJKdnBI?=
 =?utf-8?B?eCtNWEFQcWNBWXN6ZU1ZRHkzZzhtQ3RsdGxoK3FzcVZVdXJvTG1qMUJwaEJG?=
 =?utf-8?Q?1Jl4bSSBPM7qOGFV7jOP5x3Q/qWs1F3WdIwAC6P?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3dpV0F2bjFQMVpHK1RpaUZVSkdibUtBOXpIT21waUdFZHRLZjZrTFZUZ0s1?=
 =?utf-8?B?OGlnT1FiYlgxNkZReGx1cGtsUFJhMWFzU2NlU2ZUTWFyVkdOemFlQ0EwU1ZU?=
 =?utf-8?B?KyszRWU1WVF1UE9RNHN4SThXcXduRStlTTJ2MFNLcVFydnU0QWxhU3dMWHVq?=
 =?utf-8?B?SFVWbTVSLzY1ZzdUNWlCVXFUSFZWYUw3Y2RwNS9NMDFpTHErUUZ6MlRUOXNM?=
 =?utf-8?B?VFdsWkpNeGpiU1BQdi9yVlBLSkFGSFpoVHpxR01ET1Z5ejM1eENDMWs5V3RI?=
 =?utf-8?B?QU8rYmRZSTlyTlNmKy9sVmVYc09UZHdTUmptdHRxbUxXTWtCdUh0aldHNzBQ?=
 =?utf-8?B?UFNaMWpCZU1pVG5aU3ZzTHIvSEo5NWJLU09UZDhCN2RmWE96YVJ3aWY4VHV1?=
 =?utf-8?B?aXlNL1ZOd0tudUQzOUVOVU1PQmY5anBxM3hiQVJjaG5ZMFFKR1Roc01vVGlz?=
 =?utf-8?B?S29wRVNkRlJwZzNmTmdRY1JES2pHRFZKcTMxK1N5WmE3MTY0aWpidGFoRHBr?=
 =?utf-8?B?aXNrTFkzaDNuWmEzVDM3eWg4T3JUTWxlM3VreU5ESFV0QWE4OVlFRHJsSFB0?=
 =?utf-8?B?MUpjc1ZGU0hScmpPUEd1Y08xS21jZ2sxRTZFZ3dGZVNUMnRBUUJteHc2d285?=
 =?utf-8?B?ZUhKVjBXUmxiQlN1MTBkN3dKaXJrc1RRbEVqeUNyQXlFdktUYVBQeHN1NENX?=
 =?utf-8?B?Nks5QnRnUG5RNHI2UE50b1cvYUY1WnlJQ3ZmejArcTkyQStzT0lDd3Fjb1NN?=
 =?utf-8?B?SGRsOUFJVGxtZSt3VXErTGRTczV4RGIrQXd1SEZWbWU3RDlOR3VJeFNwUnZI?=
 =?utf-8?B?TE83M0FUbi9qb1l3UXMxd1BrV296QWRPdjdzcGZlQmptcjBZd21UbG9pRkZm?=
 =?utf-8?B?N3QrQzg3RHpiV25TdDFwb0hrODZJVEdtMHVWWnBoOXZKdm1YWHFkUzJ4YnBz?=
 =?utf-8?B?Z3MrUkJGUkF1cEJuczhtbHVSdllEc3YwTm8rdHloaFhvZllZWGY0VzBleWpy?=
 =?utf-8?B?TmQ2MVhpQUJ6akNBV3pnMmdGbWRweEI0TFVJTVFoc29Kd25YYlU4eGkwSU9M?=
 =?utf-8?B?SDM3RmpBQjR3ZXpRRUplSmI3VXoxRnZabWtUTWlDdmVvUkhTbnpuV2RBbW94?=
 =?utf-8?B?bVlabVBwYnFLbVBSbzUrTkI1SlVObHRvUzZ2T1RYMFRIZVcvN2lOYW9QVWxv?=
 =?utf-8?B?Wkk0RlRoNmVCWXhuQytEZkJaWkYwV210WnZDc3JMcmZPajBNNVhNakpINFNk?=
 =?utf-8?B?MFBMMWp5SzRqdlI0N0c2VWlxamhBT2tvSC85M1pjOTVOdHQzZmhBeFBFcE1l?=
 =?utf-8?B?eVFmZU90WXZSaytMYlNNOVpMVVlYaGl2dTlLY09RSUZXaVpWVkttUnpmN2x6?=
 =?utf-8?B?YWVMWDVoUWhGYzRKV2s0RHFjb3lRKzNmQU9DWFVEN3dxaFU0NThWOWZSclB6?=
 =?utf-8?B?OTEwVVA5TjRkK20vUkZGbFZHVUpMaTRGVTd5cjFvUm91L3NCb2RMM3gwYWRD?=
 =?utf-8?B?UWtWam0yWFhYVm1PaGJKY00rVlJibExDdGc2ZU0yVjhKcDJyNnJoL0JxWDg1?=
 =?utf-8?B?MHVuUldZVnBraTN0Uk83azJna05mekxQbm5Qd1dhdUNKOTA2RTk3a1NWTFdP?=
 =?utf-8?B?eWZNc2JreTFRaXB5WE5XTTZtYk0rZlhRVXBPT0YvZFNZMys0cG9TUGJlVEJw?=
 =?utf-8?B?ZkRrUC9RL3lpZXBKOUpyMm1KVUV2dEU3U0VtbG53Y2JSL2I3Qmg3R1JZMGtB?=
 =?utf-8?B?LytrNTkrejZZSndhZDd1L1lMblJuZFgrdEI0ejJyUmpSYWRUK0h5WG9BeVFa?=
 =?utf-8?B?Wi9kdVNRT3VkZWdZdTdjYnJjSWZ6amhNQ1d6aWQ5V2MwdmNnM0t6cUlmQU5w?=
 =?utf-8?B?MlgwYUltR1FhTEJ6dGZWMksxNmV1SW42OUg3V2xlR0JBTHZ1WllSMXdtRDdG?=
 =?utf-8?B?OWpZTXNqeG1hV0YzcDJXOVdwU0cxeGxHcWlWa0UxTGFROXB0ZGhhYlFsdzFH?=
 =?utf-8?B?VU9JUy84UlBXTE8wRGhOODlOMGtjQ3NjdXlLaEhnSHYyenNjZ0ladTNXQmpi?=
 =?utf-8?B?QWZYMGxHeHpBTlJpNU1kTjFsRVI0aXFJbDZ4MG1tM2V4TnR1dnBRWGtTSERy?=
 =?utf-8?B?cVJRbnoydnNDelgxZDFyTWw2TGFuS0piQXF6WmxGbFA2Qzc2dzRnTkpQUlZ6?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1a3217-61ce-42c8-4b2d-08dcfcde539f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 14:38:19.8899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pV05Rm4QFQ9quEriTGvgDeIVn0+ePwlCxGbki5gVwtvg9LCji5YIR4ICO3y6wtRqm6d8C6+aImRVgYtGCV3LztYOGnHe7G1YuIbyc3O1qB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8435
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 31 Oct 2024 17:41:07 -0700

> On Wed, 30 Oct 2024 17:51:53 +0100 Alexander Lobakin wrote:
>> -	struct xdp_mem_info mem;
>> +	enum xdp_mem_type mem_type:32;
> 
> There is a new use of this field coming in from c40dd8c4732
> Can we wait for that to propagate to net-next ?
> I don't have any great ideas on how we can conditionally apply
> a fix up in the CI infra..

Good thing it happened already :D

Yeah I only need to assign mem_type instead of mem in that new place.
linux-next handles conflicts, but not our CI...

Thanks,
Olek

