Return-Path: <bpf+bounces-42816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF38C9AB696
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 21:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C322282460
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 19:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06341CB307;
	Tue, 22 Oct 2024 19:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mnMniVub"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29AB19DF40;
	Tue, 22 Oct 2024 19:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729624637; cv=fail; b=gDluyYDVDVrpKdUCh777FTKPsVexX/t0v+FvHi+8Ber4lpkLQwvvbRHWAdRbU1yXq5rf50+0nE+N0wdtIx46/46y6RwhCvX9jyrMC3WJ/dGx725fRpl1GX9LqrUTr/PZX+nVNzoL0vGBmMr3LCkixKc9XFNe9q9e3YriGBHa9Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729624637; c=relaxed/simple;
	bh=8hRVMT42xmrQCbTw4kKmEUDjchgGapPXx0cKT4XooD0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JWNGh/jChVQtV0TSwSWHPRpgFbdwGqFg+SRfHFGCbeej2twRVsD4i4Wvzx5YlOjhgGRjL3T72Ik/yIot2QL3rSI9WPh5UwfRVoD3RwbexdMk9ZilkAgS0sZDL9Sfg3STSiZiL59FHIgWCoyTQLin8owSKnOyfCCd8pAbK8nHCnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mnMniVub; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729624636; x=1761160636;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8hRVMT42xmrQCbTw4kKmEUDjchgGapPXx0cKT4XooD0=;
  b=mnMniVub9PjP5CXwsD33fr31pODTiDfkYFBShnvuxyz9qt6NwN5yH6nM
   Y3pVsRXPxbDTRTz4GaJB2Ex+vRCwCaRvXh3Tufn15FubcX+v/xPV6Di8n
   n2nQdFzlYsW5BLBjS6PKdt4vRIRysZxfGrqePCxbyh2+4NvETD/2hI29K
   70QkFOTAS7Z7yg6tg7pRvJTcP77sbOStQsfqQA+xPDeMlrp6vMRXJURc+
   LpmgUg1fiOUCbStrHjcZyF7GYjj7iyHbQygyMaRnuEdEBLbd/m16E9Ve4
   +Bf+lfXG9mFAwVYUESOev1L8opyPZB1XDTW99omR3KhgtrDMG46k1NSXn
   Q==;
X-CSE-ConnectionGUID: /FbYTIhbRAayxHy2J0mCqQ==
X-CSE-MsgGUID: Ztek5qarQz2CxAqgKZqc9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29075716"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="29075716"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 12:17:14 -0700
X-CSE-ConnectionGUID: 2KqvepRLQKW0kxQpji/CUw==
X-CSE-MsgGUID: yWUc931BQAO6WNmomrsu6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="84756291"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 12:17:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 12:17:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 12:17:13 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 12:17:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4pzsEiY3Hvnu3j4xp2sRojwjX9NpmP2wCfhYHpm3TK/Ag1RNrWo72GcKUzBIEZAboz/rL1oeddVFjSPZijbnldqMKU3PGUXGi3G1JwgjL3AW939VmXoKVSUfxiHCj7vJklW7bvUysAX/m9y/z56q0XOGcim8EvYIlI3agFk4kljXkNjw9qKur0ALG4vsXE4W9QeXPnv5VVyeZN+agcxyppY8pwBB12nt+epSvadaALJ6h3Cv2ZOJl4fL5s2MkvnaYxMS7iNh/SpogPMsYbAPlWmGwm9xdRc5BJvl+AHJG5dQcHLGvXYxG0loBQYPuTyMAbxAOw6QxSUjyQt57f+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIaEb1Qv0V7psHvbWeRN/4G9xCETpGwkK2NkmG9/9Xk=;
 b=a6WPUGtWSxdgsQUztGJYA0AJ4uC76A9P2tWPd6ZJpUvLfIdpYPI1HkAdJd31D4ymKJoqliGpuDUE8xoc6cRA79+ZIfjNKseoCC8/mnMItQwIRwij+E2QUhHb2n3o/USGTFpzecmYLW0PQMq4T72sS/bPDJYPPLef+nWnfk+hYbVMoNKTvsQW1pZj5r/nRepWIr9pwg0QjYOHxkJtKPMNzgJGat0F3yyZKEHPcSpZdm8BCrplD9Kjs0SzRR1OnFPEg4JVVwgl1CTl79rPFS3H66wHd1URY/Ha7kD4hT30//Ia7QNv+QiOJA929asAGdKUjTrIsWgEzxuAkjMXlOlKVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB6712.namprd11.prod.outlook.com (2603:10b6:806:25c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 19:17:10 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 19:17:09 +0000
Message-ID: <584b87a4-4a69-4119-bcd8-d4561f41ed53@intel.com>
Date: Tue, 22 Oct 2024 12:17:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net 0/4] Fix passing 0 to ERR_PTR in intel ether
 drivers
To: Simon Horman <horms@kernel.org>, Yue Haibing <yuehaibing@huawei.com>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>,
	<maciej.fijalkowski@intel.com>, <vedang.patel@intel.com>,
	<jithu.joseph@intel.com>, <andre.guedes@intel.com>,
	<sven.auhagen@voleatech.de>, <alexander.h.duyck@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20241022065623.1282224-1-yuehaibing@huawei.com>
 <20241022073225.GO402847@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241022073225.GO402847@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e59827-28ab-49f3-849a-08dcf2ce202f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjQ0M0srbUIxTlFjcVhLZlQ1cnQ2YUZWUHlDZTlKeXgzUVo1Mk9XUzZKY21O?=
 =?utf-8?B?VWl5WEM2ZWt4TGl1cVhlN21ESlF5M3p1aGQ2M2NUSk1IZm9VdU9NZ04rRkVm?=
 =?utf-8?B?RytoWGIrK1M2dndHNGZvbllDUnZSZ3hxUFBwMDB1bWZKdWdzV1U0REpnWWgr?=
 =?utf-8?B?TUNBRnRTWmk4ekJxWW1uUDZ1OVBvQ0xudE5MQ3FPdjlOTzdPZ21Bcm1oc01r?=
 =?utf-8?B?Z1RJNVhUREFjc1A4RE1mRThuSkREaUloQnd4MXlyM1g5bzJ2WlZEOVlSd1ow?=
 =?utf-8?B?ODFROU1TdnJ1NXJweDcza29Pa0VLaElBUlJxemkvYXRoV25tUjRWblRJMVNM?=
 =?utf-8?B?Z09RYStNUW05UmlZTmN2MEVHZXBid1RzRnRIbmQxWjVENHBVWHlzK3lxNTVC?=
 =?utf-8?B?UTRQUFNNeVZCaFpzVytBbDZIZXp4WTBVTHRkMldyeUg3bXU2QWR1WEVIek5H?=
 =?utf-8?B?L04veTZOZWMxQ0xjTzJDWFFuSEkyekxkZTNPSW5kdHhGNnd5US9rOG9JdkdT?=
 =?utf-8?B?WEo2a0pLc0pxdnR2aGNKMDJJdStNTU15bWV5RTNNSnZPdmowaXl6YWxKNEM2?=
 =?utf-8?B?bkFNUzlRWm1XU3VrVzlrM3p4ZUNEYjdEOGRhSlJMbFMwTEhlcTZOT2FGM3Zn?=
 =?utf-8?B?SlBwS28yYkN5UXVlVitIY3VwN0syQkFNRURDbW1JbDlYUkk3TlpvY1EzL084?=
 =?utf-8?B?N3ZKY1NrK1hUWFRmUlhVdEkyZ1VDTEpqREZwZnZycmpmVVRwaTh5K0lML2NL?=
 =?utf-8?B?N0piUjF5SkU1Z083WTNYZ3B6UytpaU1UV0QxSGhGYjM1NVhtVmpJRC9zWVVo?=
 =?utf-8?B?Z2RVRDgvU2I4OERaTzlYKzZ2aXpvd2ZmWit2RmhVUmRtbGZldlVEZFZsTWxa?=
 =?utf-8?B?RC8xNDA0UUFXeUR5TkRXOTZlY2F5SHRYV05QUTAvUUhrZVFETm1NZWtzTjA3?=
 =?utf-8?B?MXBreUFWUWxTOC9jNGxMWnFSQXVTM0Jua290VmljQ2d2UGxqajBsTC83eTRW?=
 =?utf-8?B?blBJdXJtUmdraTQ2bUZKTERoMlpJWGU1bWwwOE1QaXYvYTZ5eHpVaWZ4SnFC?=
 =?utf-8?B?YjZkYmdSTFhNc21JTVZZT0trYXl3RW94N1pDVjI2MGo0WDg1TVd6VGI0c1lM?=
 =?utf-8?B?M0lCbjhVNllNMUU4SkF3clQ2am1YWE02MmdxQ0pmOVJpNEkyOWFwY1VNd2lU?=
 =?utf-8?B?TXR5TVo4QTVtR0lRbW1PUUM1c0RHV29CRkkyTWFkYStNbmh0TUdWbnlCTjRq?=
 =?utf-8?B?NFlTQ1ZKTXIwRkRIT0I2SnFBQXhFK29BejRVSTNsaHhjL0NhaHBQbVR6b09O?=
 =?utf-8?B?ZC9oT3RNKzhRUW9sLzB4RTJKSURibGM5Q0pBMHNwZXR4Z0hEQ2hJSXllelkz?=
 =?utf-8?B?dFVlMktFc0lyTG5kR2MvRUpEdndQbVdDODdUdnFpdEQ5YkxYNHRST2F0TVBs?=
 =?utf-8?B?L0EvcEZVeDlKZDJWQ2JmOVlxUFF2bkVIS2tCb2d2NmhGRllJRk9rdmMydlRt?=
 =?utf-8?B?L3dhMVRpVEdtVzROeW85MTB4c05NemNKU0ZFYk4xb1FHekVJVm4zU2t3bmJQ?=
 =?utf-8?B?QnJ2dUM5TkY2QkVPVEZGek83RDVaRDllOGtPSXpxekRMUlhzb29jbng3SkUy?=
 =?utf-8?B?Z3Zvc3pObVBpa1NkV2s3N1FqY1Vsc2M0TTN1NGxveHJQU2Fpb3h1WnB2dU1v?=
 =?utf-8?B?c09WbHpSdTk2WFB2TDBFbkpWMEg0N1JDdUR5TkF3N3MrVkxKUG91T2RnSlMr?=
 =?utf-8?Q?dbkefxp0KO4E8OgadMCTsECnqwJ4VjVOHoIfmz9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjFqODh3ODN2STVEQnAxU2MzQnpjdDVEVENGcW02ZlpMK0J3NlJpZm1yWjVY?=
 =?utf-8?B?blEvTlN0R0pTUkJNREdnUjFRZWZyNHRUZHl6ZGI1QUFHK3FoTEtOTGJYK2VN?=
 =?utf-8?B?U0dUVVJkTWJtUGNodEFuQkRSbjVtVXg3SUYyWkkwRGtUUlp3ZXZVeDRzT1JN?=
 =?utf-8?B?RkNoMVZtQmNra1NpeGlISFE3dHVuOEM3OENWdUJ0TEo2WVBVTmVjdEZqTEVR?=
 =?utf-8?B?Ny9UU0NJQ1BzbitJN0h2L3NUNlVmNTJBNEJNdmpxZW54MW1iV09oUnlmMjlq?=
 =?utf-8?B?bXk5UlNlYVVQMkVvOE1na2pkYisyWGdWRlFxUFBVMm5UdkRIZGY5ejB0eU5H?=
 =?utf-8?B?VytQcmNNTUQ5WFc4OTJtd3o0OEc0dHp5Ukp3VUZkbEpCUk9DaWNVV1NZTlIr?=
 =?utf-8?B?YU1mV0IwTFNsczNxcWRpVm5tTlo3YmFNakpPZndYU1QwdDdwY3Rzb1VCUTZa?=
 =?utf-8?B?UHVhZEhGR0hDWG9TMjJ6Rll6UHp4cmlodkRMbkd2eHk1aERaRDVlOTJpWHlZ?=
 =?utf-8?B?clIvbjZuSVJncExlUkhiQndBUkkrRTkvbVNlQ3NhN3o3SGtVSUxlMGdlNjhS?=
 =?utf-8?B?VTFpcW8wQjZLbzdnSGNUNWkxYkdzM25VVTYyRUZwZ3d3RzVoZGxOa2lDTnFO?=
 =?utf-8?B?WnBlOGszczkrc3Q0ZEFHLzhPbUYvMkY3N09VNnlwaUdIZ1huZVZ1WWd5cjFu?=
 =?utf-8?B?MDNGZjJwbmFjVks0M3hPTFJvOWN3ZHZPMWxrVk5ZRHp1UjNoSmNia3dDbmQx?=
 =?utf-8?B?R3ZOem14a0NBTUtxaldnL2FucEtGaHhKNU1aaDNxSXVwMHlPSzQvMUlPQVZU?=
 =?utf-8?B?N05rclR5SkhBYys2akp5d2liM1Vtc0Fqb3c4VjN0eFBnQ0JXSkE2WUtIZTZX?=
 =?utf-8?B?dE5XdnZJQUprbDZ1QWgra0t6U1FydXI4ZDZSaGxybUJ6eGpKdTM2V1pZYmg0?=
 =?utf-8?B?eU1EOGRRTXdLblY1dTRXMHhCM0VUd1NZNnJyai8yeXVTUmxzdGNzaWpUWitj?=
 =?utf-8?B?c0ZLK21FUTZQamtxdTRBYWJPd3lrTlBrMWJoWVh4bkQ2bG9XSWFFMXRyeE85?=
 =?utf-8?B?eGpOaGgxVk9sL1VtRERXekxQTWRmVEk5ZnA3enlxWkhHL1NaZjJMRGU1MXpl?=
 =?utf-8?B?bmpEZWp2VkxoTXdpdHUyYmlIWnBsVk1LOG4yaVc4endPUXVKOW1rb0s2Z1Bj?=
 =?utf-8?B?djNPQ1EyT2lHdDFxVC9pU05PUUlHT25WL1VoMXdRZFdrMDcxZUplWHNLVlhF?=
 =?utf-8?B?Ky9TalJ6MVFlS3c2N0c0b2lMa1NESFJVMzV2Z2FnUjI4b1dyNmwvRjR5VTVG?=
 =?utf-8?B?a0w5TVRqbS83UGROOE9WdHlrTEpIRGJXOEVrSFpBVnF2dG0vbXNBSzMvdndj?=
 =?utf-8?B?b3F0U0xjN1VpV3VNNXczVUlMTGdFY2o2OVdLQWlBSnlLS1g1OXNGMXRaZjNK?=
 =?utf-8?B?UmVtT3hKMGFTclZ4cGd3UWh6ZjFJdHlQRU83WVZNSjMya0RTVXpoTDJXMWlj?=
 =?utf-8?B?b1FSN2tuNWg0UU9PNW1HODJhUzlOMDM3a29PdURpTlFEbXBWNkxLbmZXUXR2?=
 =?utf-8?B?VnhHei9aVVZPTmFrRlAzaXBma2VMeWpwbWU2WCtpOElsY1dySWxSM3JWUG1G?=
 =?utf-8?B?aWU2NVNVanFLZWh0ZXRnREtqclZYWDE0UmcyMlMyTi85VUVxSXozMjRvb1Bp?=
 =?utf-8?B?aG15RytycUFOZ3Bxc21KbGJiQXNTMkNKOUhKVHllV2N2cEdwK1ZLbFB3THRo?=
 =?utf-8?B?b1BLak05ZWl3aHNUKzQ4NGExL0t5ZWdmREh5ZkpOZ01yZG5BUjZVT1VJWFVl?=
 =?utf-8?B?M2EvQmNzQ0MxT2dTSUVVc2dyRjNVYTV3WTJnMUtSeUNzamtJTGt5SzRsa3Bz?=
 =?utf-8?B?MVBock9RM041bGN2YnEyemFlMktGcDcvUTV5QVRpL2I2M0h3WGdLWFhTc2Jo?=
 =?utf-8?B?dFNHYVFXc3Zqc2wrSE1QZGxBNVp6UWlld1E3TnVhOUlnSVIvRXVLNEI0TmtC?=
 =?utf-8?B?UksvbXEvOU0xL2JPeFM3VXN0czV4V2c3Q0E5aWhLNGh1T3VNMStKVUEvelJZ?=
 =?utf-8?B?SDg3ZUR5QVhMNllpN1NJZk9YMFBrSXNPZ1RjUHNwRW5kbVMydGpVZFhUb0tt?=
 =?utf-8?B?MHkxRkRLTlUxUGFNWVNoWncyUnEyQjE2RDMzNlJBbG1NcXRtUWE1STVqWHNO?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e59827-28ab-49f3-849a-08dcf2ce202f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 19:17:09.8390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONpT5HSPTRyEF/auNFek+TtGvG0z+App/pXis3+THzMfTjgXP9Dz5oWbRiK9dna2kWGNFhd4D2BmguCadapiGkUTGAhKEQbFvCdS18255Og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6712
X-OriginatorOrg: intel.com



On 10/22/2024 12:32 AM, Simon Horman wrote:
> On Tue, Oct 22, 2024 at 02:56:19PM +0800, Yue Haibing wrote:
>> Fixing sparse error in xdp run code by introducing new variable xdp_res
>> instead of overloading this into the skb pointer as i40e drivers done
>> in commit 12738ac4754e ("i40e: Fix sparse errors in i40e_txrx.c") and
>> commit ae4393dfd472 ("i40e: fix broken XDP support").
>>
>> v3: Fix uninitialized 'xdp_res' in patch 3 and 4 which Reported-by
>>     kernel test robot
>> v2: Fix this as i40e drivers done instead of return NULL in xdp run code
> 
> Hi Yue Haibing, all,
> 
> I like these changes a lot. But I do wonder if it would
> be more appropriate to target them at net-next (or iwl-next)
> rather than net, without Fixes tags. This is because they
> don't seem to be fixing (user-visible) bugs. Am I missing something?
> 
> ...

Yea, these do seem like next candidates.

