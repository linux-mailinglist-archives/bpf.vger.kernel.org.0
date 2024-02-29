Return-Path: <bpf+bounces-23087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4639786D65B
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 22:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F103F284A90
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 21:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BAB6D51B;
	Thu, 29 Feb 2024 21:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fvbX8/O3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE256CBFD;
	Thu, 29 Feb 2024 21:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709243357; cv=fail; b=GjNHEINkAprwX+BRdNcWQ6COTDmB0EfLV2+j7m/7UNeCiZKBdywWxptPNBLUbiyvWiBr1jQJyAT4oCyJWlSsXOpxPbcSsnbegAPXW+wwHDo2WFMGyqS19V8WZ+L5+PLblJpcvkHLk2iIy83sy5TI9D6NcAGsgfa+ZMpUPccl3qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709243357; c=relaxed/simple;
	bh=rKGhB0pFvgIKGb/pA3ilgLlf0RFpTSLL7GfT+OACEk0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QIfGwJH5rlfM3ur9haA9XlDqQh99F2sB/0A35JCaxQTvHtShX+/DxQmp92BNb5K+kxkjSf7oMEYjz+ClyGD0bh8otik6ztFegUBhy1i6IlZ//XmNHVyiq519xTOZrDlL99cywd9L6GJbhT06HFHH5Ja3WHPI3yEKH36cH4E4qwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fvbX8/O3; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709243355; x=1740779355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rKGhB0pFvgIKGb/pA3ilgLlf0RFpTSLL7GfT+OACEk0=;
  b=fvbX8/O3l+hFxcpYPmThU2yVCA5wdb8HorQal47Wi2r3qLlVpjY8R5JG
   Mkd0w4KX4KSoJAj12EgeefXniAs344c+brXTKhPDtOJMpUhkkdcTTo3gS
   tpCK8cfFM5vneRjvG/w+9zbv/Ya4w+wj95Jid+wBcfPmltCLVmqfqwUYq
   q0vD48IMaKedrEO8MyOAXBkn39sMCEzZPifL6mKXyFaUR/6fPHem2+Sqv
   NDgZw1MoeUkgX9W8/QXFPsqsyYHylsQM7YPopnjJ1IlhXdbLy7F/bWcyn
   GeAuSWXzgPSwQM6yTtPtJrieio+cvoA2fEk2MgGoBCqHGnquhvzGfK5Fc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="6708088"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="6708088"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 13:49:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="8216450"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 13:49:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 13:49:12 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 13:49:12 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 13:49:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrWqxw6exrkRQWYfoQ5jv1eL/iT5MLXFwxCrAsKGd9rgrlZHPaDxJ7DWOEkP6PkNShzbjA0Af2R7+ILB+elL254hJQHWlQCgbwUnZXVaUDpmzgj9cziMZLLKIzxPgVd7Rwc+/U+POFbP9/iCo4DtVHlB2XY056BomeGDVaw976jYgAsOkCJUXuvYRl3nEp5Sap7xn99m912kElWy81Nkj5TutSYDZiw/WJ1IxtVNn7/rBunCiZf1Cu/IuML0YZVjEHB/7FdrP35gk7Uvt6V3h4z5QoQvdSev/PwA7hctFqoXdO6WMdc7eBn2Inv9p5oLq8T1Pm4yE2cArcDZ3EK60w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKGhB0pFvgIKGb/pA3ilgLlf0RFpTSLL7GfT+OACEk0=;
 b=d3uGO0dxVYoGn0sf4En2VeBYKJeio7V2FaEP1xbbWyGf5k7hLka8lrk071/esE8laEL/Sl7tre26D32A6j7L5b+6iLwaashPqwsJMyjMtZMhDd5QFPP+L1yf5p1P2lJWWeD+urtqnjkPTE38SDdUtAnauD0IoNqBiXj/GE3TbydYK3ZToupEKJldPqFbXbXrfi/HDgBVljANx7r5WWw/kmBwZ7UV3DJHZ3FTsVIIanHsMWQZ8MwKsmLN4RO3lWWu73hVEOK0WxNWEYBTY0xnWAi8dnzIn8QZ2P3+QfnGIKabLXxOoiQ3A+7gXwU7rkMuEZXtw40JTrjfdw558mZ2zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23)
 by CH3PR11MB7761.namprd11.prod.outlook.com (2603:10b6:610:148::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.14; Thu, 29 Feb
 2024 21:49:07 +0000
Received: from CO1PR11MB4993.namprd11.prod.outlook.com
 ([fe80::d1d:6601:b2d6:d6c2]) by CO1PR11MB4993.namprd11.prod.outlook.com
 ([fe80::d1d:6601:b2d6:d6c2%5]) with mapi id 15.20.7339.024; Thu, 29 Feb 2024
 21:49:07 +0000
From: "Singhai, Anjali" <anjali.singhai@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, "Hadi Salim, Jamal" <jhs@mojatatu.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Chatterjee, Deb" <deb.chatterjee@intel.com>, "Limaye, Namrata"
	<namrata.limaye@intel.com>, "tom@sipanda.io" <tom@sipanda.io>,
	"mleitner@redhat.com" <mleitner@redhat.com>, "Mahesh.Shirshyad@amd.com"
	<Mahesh.Shirshyad@amd.com>, "Vipin.Jain@amd.com" <Vipin.Jain@amd.com>,
	"Osinski, Tomasz" <tomasz.osinski@intel.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"vladbu@nvidia.com" <vladbu@nvidia.com>, "horms@kernel.org"
	<horms@kernel.org>, "khalidm@nvidia.com" <khalidm@nvidia.com>,
	"toke@redhat.com" <toke@redhat.com>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "victor@mojatatu.com" <victor@mojatatu.com>,
	"Tammela, Pedro" <pctammela@mojatatu.com>, "Daly, Dan" <dan.daly@intel.com>,
	"andy.fingerhut@gmail.com" <andy.fingerhut@gmail.com>, "Sommers, Chris"
	<chris.sommers@keysight.com>, "mattyk@nvidia.com" <mattyk@nvidia.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH net-next v12 00/15] Introducing P4TC (series 1)
Thread-Topic: [PATCH net-next v12 00/15] Introducing P4TC (series 1)
Thread-Index: AQHaaAtnKRSRfkPj+EuTtMRdZsG4iLEhlUYAgABKhJA=
Date: Thu, 29 Feb 2024 21:49:07 +0000
Message-ID: <CO1PR11MB49931E501B20F32681F917CD935F2@CO1PR11MB4993.namprd11.prod.outlook.com>
References: <20240225165447.156954-1-jhs@mojatatu.com>
 <b28f2f7900dc7bad129ad67621b2f7746c3b2e18.camel@redhat.com>
In-Reply-To: <b28f2f7900dc7bad129ad67621b2f7746c3b2e18.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4993:EE_|CH3PR11MB7761:EE_
x-ms-office365-filtering-correlation-id: e4b4b7d9-1c7c-4326-f1e5-08dc39704137
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bdm7Z3EADC4Hmd3Q39L1EXDKmbXo69ypzKwXXg+uBA9WU1eBBC1Yz7MPs1PdBiNoTg/DUsJ62dNxGXkLpvbjvUEP6Y9XltbBRBZRSTjYZwQBY7a7v3qvlkxTLneUxJY8PegC+WHI4x1SNT+gdB8gJecM7ylmxWZGyS1YEOmxHHk+w7cQKKGbgj3ja3G+Fz2WQxH2n4kybkRjEPcIKXyPJHRoLWmvQEZD1TUL6gXTgN9592UEhMdOuPPSl1L/6TWmQ3M/yoNMD2NClY2chcjZ6p6lCKOGs/FuiBhJeArTTXjuBeiRFG77RMt+bWffqXwR7VPPC41F//PdtbImOrV/z+qgTHnyoxOIR82yjTjjvmfJhPIiX7WxjqgJj00ey7Haf1D+G5vpPvCsKht6ukFY0d8k4FTSmc7YCICa2s3+/6T7YTUM5JCNXOoiDeJ+tZygrW0UaZeySzutd8j9PqcC4//CeJX/tmnIoG/6dwv+pCqzbfkHKRG5fWx4ir7KukoEK7pr3GB3BHDZSCHUOLojkisMsgOrMd0GnsZUP1cJPJrUPDiboUQQhXx6WGn6N6LmzZb59tV8IwZyR5DYWSvw3qr22Nzth7YQtcfVm/EXOeayK89TSKzr/28IPusDgT7SwW14htrLMb5eFJCfllbdhjQUHir5MYB8lOo6I7FHR1gjAKf+xI9z/oaQha0hQxrgqVice5px4F2FXXAuJua8zFxzDibvyspKn9hSw9/6+oI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4993.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1d2Mnd3WjBMTGR6elFkc0FQbUR4NUhEQlp3KzZ5UXE2dGNrTXB1SzBoT1hp?=
 =?utf-8?B?UlZQVUxFRDRFZEc3MFd3MCtoM2sxY1FoY1NibG5uNndVSkJZaVF1ZXNqeVdX?=
 =?utf-8?B?WGtXYmVCcTE3b2tpTjFFUnE0VG9HOElvOEd0VmNxMWtjT09FSERRcWtwK2t0?=
 =?utf-8?B?Ynl0cnU3V1BtYi9wTFdwTzBISi9FVDZWOUVHT0NJZFdnZVpkQmVPbHlBakRZ?=
 =?utf-8?B?VlFpVkJCWXkwbDkwTVIvTStCbkJrTDdJejdmbkV4WEdoeDFQb3hKb2JXVFZN?=
 =?utf-8?B?c0cyVTJCaENvcTYvbklxU0ZLcnZKdm5UMWRXNmx3Mkprc2lVS1ZyaE9mWnVM?=
 =?utf-8?B?NmsyaFBMOHQ2S21xdXNFSit1OWF4dWlqaXBqVGFyRTdxZiswVEl5bHR1YkU3?=
 =?utf-8?B?VlZEa1FUZFpmZ2pBNXM1d0x3enUvN245d2JlcmJpS0FncnYrZzVHTVIxQ3Nq?=
 =?utf-8?B?bitieURlVU5BenFEb2hZMVlJbXV5S1podjU4TC9YTGNnUCtXWWpNVWxPR2FZ?=
 =?utf-8?B?TFNuekVCUmY2dVpJM0VuQmhUVHpIRFJpc2xQZGEydDh2Vi9KUlpITUluK09X?=
 =?utf-8?B?TGVsRlFEdmRpTDNLeUVpdDRlb0RGRjVJZWdpT0tTb1I4RkNQNHBIcmlaWCtk?=
 =?utf-8?B?WTMybCtwSTdDN0pxbWZ5dGhPVVdKK1RhZWl4cGRrZHZWZDA0SnNxZ2VMRlVh?=
 =?utf-8?B?VTUxL1NOZlptRlczN2xDdnNkZkM0L2w2UmswWHFnaGJWYmI0aHdKOU0rMnBI?=
 =?utf-8?B?bWdncjYrSTJIQ05ETkw4UXJ6RHc1dnRoZ2FJdkxlWTNSeDFLRnBLWHBLemFF?=
 =?utf-8?B?YXJxOUtpYTlQNW03QWNDR0ZvRTlPZk5ZWXFNY2RDTm9rbDdSY1o2TGlKcld4?=
 =?utf-8?B?OXBicExtSHEyTVAwK0xSaWpLSjFlenNlVXFiSTlGSjI4ekFsZ2Y3WlNyeWFM?=
 =?utf-8?B?Nkk3eDlWamVrOGt2aG5LVE10c1ptZWVWU2p2SVF5dTZjUnJQWlpBdFJiMGI1?=
 =?utf-8?B?VjZhN3B5TS9pc2Y3dWJ6bGFXRFIwcjRTOVFJWkJBcS9LdU1pU2RwaTR6REto?=
 =?utf-8?B?eUc4ZDIrVlgxbU1GOG55c2NVSVozMlkxMzBTZGZXNGhKcHZWUXVUUWt2ck9u?=
 =?utf-8?B?TDI4YndxR2E1NW5HYk83RDVNNDVueDFRbkhmRDBQYmd4MmtoaDhrT1dJVFhM?=
 =?utf-8?B?S09Eb25raTFxWXdjTlNzdldhVnRFWm5mNFI3NHN5L0FBZDB2YTdOSDdqRUJy?=
 =?utf-8?B?T0VOM05XRWlUd0pOdXVCdGlqT1ZQbjJzOEdXZ1o5TWpudWRZTS81QXlRc1Ro?=
 =?utf-8?B?V3VLQ055eW1zSGlacWZYU3pkc204K3VRcFQ2amFGQm4yQWNsR1dBRGFXTU9k?=
 =?utf-8?B?L0paeGNvZmpuNWl5VW9VMUI1eS9aTHl1dTVxU0VYMkZaWW5BcnZjNWk3UVFn?=
 =?utf-8?B?N0Q0UEo4U3dpVE9VblBhVHhrVEZCYnFUWENnUDdhRnk4UHNrVjZCZFYraEd0?=
 =?utf-8?B?R0ZSay9md1FDUnFSUFEyTXhpZ2NscjdEdTVQbkNYOE9xNyswREFNamxlZHBZ?=
 =?utf-8?B?T3IxMWhrREhJS2hRRElKR1Q2WG1aNWoyTXlaejd5YVA3c2pGM3I3QXIyWDBZ?=
 =?utf-8?B?ZEdQOTc3dU9vMDlMbUMwMGg1U2czSUJibjdzejREVlIxakdvOWI5L0ExdkJp?=
 =?utf-8?B?VzExd1EvLzFRME9zNXd3eEZtNHRvQ0JJTXRPTnMxTkdwd0FEN3RKVE1iUTho?=
 =?utf-8?B?Zmora2MzQ3l3NXd4U2RQVzdIck9HV0pjSlQwSVYxYnhxRlNtTmdLejE4Rmhx?=
 =?utf-8?B?THlCZ3VhMFFxLzN0elBIVEd2TTVnMDNNRTZzQkZ0UEZIbTIzZkFRUFowNk1G?=
 =?utf-8?B?MkpJQzYzV1FwTW1laVVRWDl5b21TdWdUV2dnZ0lMYlR5b05NQ3krNVNSZk1k?=
 =?utf-8?B?N240aDRlazRiZVI1akQ1bDhRY2dTbFQwSGY1ZldYVTdlWnkweHV6VlBjb3JP?=
 =?utf-8?B?UnFWZFUxTDd3cW5SdGtmUzVKUHhkYUxZMWQzQ2xEMkZNLzZkUUs0b1NnQlRP?=
 =?utf-8?B?SHBIbVJSRnhvQkwvV0U1K25yczlCdjZmemtNSDRHVlFBRXJ0TFE3ekpuaWU2?=
 =?utf-8?Q?huWJfkDa0wpW86f31DTeWb5kq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b4b7d9-1c7c-4326-f1e5-08dc39704137
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 21:49:07.2829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k696CI6trsIYPnfbGvClyKndIvHDIU3rJGSE5LeD9KRMolm2tgpWMjSZGp0SDiifGyouyAvqm3hJ4dnVSpObHVw5UBwq+b3ENhfD3TJIq1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7761
X-OriginatorOrg: intel.com

RnJvbTogUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPiANCg0KPiBJIHRoaW5rL2ZlYXIg
dGhhdCB0aGlzIHNlcmllcyBoYXMgYSAicXVvcnVtIiBwcm9ibGVtOiBkaWZmZXJlbnQgdm9pY2Vz
IHJhaXNlcyBvcHBvc2l0aW9uLCBhbmQgbm9ib2R5ICg/KSBvdXRzaWRlIHRoZSBhdXRob3JzDQo+
IHN1cHBvcnRlZCB0aGUgY29kZSBhbmQgdGhlIGZlYXR1cmUuIA0KDQo+IENvdWxkIGJlIHRoZSBt
aXNzaW5nIG9mIEgvVyBvZmZsb2FkIHN1cHBvcnQgaW4gdGhlIGN1cnJlbnQgZm9ybSB0aGUgcm9v
dCBjYXVzZSBmb3Igc3VjaCBsYWNrIHN1cHBvcnQ/IE9yIHRoZXJlIGFyZSBwYXJ0aWVzIA0KPiBp
bnRlcmVzdGVkIHRoYXQgaGF2ZSBiZWVuIHF1aXRlIHNvIGZhcj8NCg0KSGksDQogICBJbnRlbC9B
TUQgZGVmaW5pdGVseSBuZWVkIHRoZSBwNHRjIG9mZmxvYWQgc3VwcG9ydCBhbmQgYSBrZXJuZWwg
U1cgcGlwZWxpbmUsIGFzIGEgbG90IG9mIGN1c3RvbWVycyB1c2luZyBwcm9ncmFtbWFibGUgcGlw
ZWxpbmUgKHNtYXJ0IHN3aXRjaCBhbmQgc21hcnQgTklDKSBwcmVmZXIga2VybmVsIHN0YW5kYXJk
IEFQSXMgYW5kIGludGVyZmFjZXMgKG5ldGxpbmsgYW5kIHRjIG5kbykuIEludGVsIGFuZCBvdGhl
ciB2ZW5kb3JzIGhhdmUgbmF0aXZlIFA0IGNhcGFibGUgSFcgYW5kIGFyZSBpbnZlc3RlZCBpbiBQ
NCBhcyBhIGRhdGFwbGFuZSBzcGVjaWZpY2F0aW9uLg0KDQotIEN1c3RvbWVycyBydW4gUDQgZGF0
YXBsYW5lIGluIG11bHRpcGxlIHRhcmdldHMgaW5jbHVkaW5nIFNXIHBpcGVsaW5lIGFzIHdlbGwg
YXMgcHJvZ3JhbW1hYmxlIFN3aXRjaGVzIGFuZCBEUFVzLg0KLSBBIHN0YW5kYXJkaXplZCBrZXJu
ZWwgQVBJcyBhbmQgaW1wbGVtZW50YXRpb24gYnJpbmdzIGluIHBvcnRhYmlsaXR5IGFjcm9zcyB2
ZW5kb3JzIGFuZCBhY3Jvc3MgdGFyZ2V0cyAoQ1BVL1NXIGFuZCBEUFVzKS4NCi0gQSBQNCBwaXBl
bGluZSBjYW4gYmUgYnVpbHQgdXNpbmcgYm90aCBTVyBhbmQgSFcgKERQVS9zd2l0Y2gpIGNvbXBv
bmVudHMgYW5kIHRoZSBQNCBwaXBlbGluZSBzaG91bGQgc2VhbWxlc3NseSBtb3ZlIGJldHdlZW4g
dGhlIHR3by4gDQotIFRoaXMgcGF0Y2ggc2VyaWVzIGhlbHBzIGNyZWF0ZSBhIFNXIHBpcGVsaW5l
IGFuZCBzdGFuZGFyZCBBUEkuDQoNClRoYW5rcywNCkFuamFsaQ0KDQo=

