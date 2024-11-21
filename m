Return-Path: <bpf+bounces-45407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD479D536E
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 20:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EACFB21EEE
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 19:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507401C242D;
	Thu, 21 Nov 2024 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKDIYivS"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F9719D8BC;
	Thu, 21 Nov 2024 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732217209; cv=fail; b=B7TQqNDPPVa+kESw8Xgfm9jvtqjIjLn8WrAvcWLfqFpNOKvYcPlRwlHYstWA4n6QJS6+1NHuLvMyLS3go+M52OYmxq93rlev3UX9t9J6YTdSQejHapISmD2klUUbKcCd/7/KE1FFMb7bwByhgQoqwF8g7GMKSzkMRdi05hDcq70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732217209; c=relaxed/simple;
	bh=Q/dRoZLAposkRPPe28BQ680yjmrrxJSA7kWsREFndMQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uqdUHjhVq72kUvfhz//a53k8bFTuOSb6HwdnuaPaIW6uNx4S7j5kkXa7sgFTKwwyuFgPm/eL2kWZM+o4R4jlZMWqEJr0j2f5m5pSCCBvv6FMYja51t86Mqh5na5su0T2tKbH+jfzwRr14UjpHAyxB/SHGHxTbseYMW0xaGTz2Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKDIYivS; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732217208; x=1763753208;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q/dRoZLAposkRPPe28BQ680yjmrrxJSA7kWsREFndMQ=;
  b=NKDIYivS244pYHnOkf6E1y0GseUlmMw1/i44a61ZOCIRQ8lmKvQ6AFv+
   QSTzaJLPruGptmgj8oG49AlgjBqflzZEUP4q0geOHPoqZkqG+N18cPXIE
   vsRINAbKYEgsuKSmJcyPaPccMTh7f17CIx64eIRqJW0JhQWbTMSoGfhV9
   OV2q+M+RtMewxqs8jTMWw50hC5z6oJMC5DRh7fGTBngaaSrmv+ZaYdymH
   zdze+6VEsW7Le2aA/bQll2jyAclOAVbhOgBzSVYJc9oyqxdOAdadmF2R9
   x5UcyNHGwwhWNq3snfe4G7/ZU0IY3mF3FgiG6MSwy8QwCBUWHxs8mIH79
   Q==;
X-CSE-ConnectionGUID: gWkdX9qkSFiRATiIy1Sm3A==
X-CSE-MsgGUID: 8ed4n61cSoG+UwIkerBJfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="36134329"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="36134329"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 11:26:47 -0800
X-CSE-ConnectionGUID: sypgz+ZKQXCSjnmaJ7hEfg==
X-CSE-MsgGUID: d10TQFzXTaWUyy4Zlurdpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="94437233"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2024 11:26:47 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 21 Nov 2024 11:26:46 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 21 Nov 2024 11:26:46 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 11:26:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhb5Ra+0VufkJ5zWckHkuV3n1qMKOXpRgM6UR/LWnwdcwzMrdawhp4QWOWrewIcXiU345dVnFXWxGZfCCPew5vuic0p5qNxmIvK1zAwanvr5M1jWZmLVB1Q8xl/VcMjIinOPrydE3+RvTOW8nQvA6q6WZjgXVSdl+TZsWVDu1T5YI9ExCKNAX8L8xA8AIqHnpxZdSk2OfxkYWsIWC75is4aOK4OXAcVCDT1BdmnMkbTZkcDSdAEj16mhuKGKbsOc3gapyabeqAf5ZFj1mk++ZSK9PzzKejUZrzSr2BEpZeh2zrrdvJbAARJSEr6Py3ch7B1ezZWCb56a9T7JKFRJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFLrlJCl3VsujOVyNJkIfEV91hLwVey954Gk5D/pDxQ=;
 b=vY3MgeeGCWPYzJJHMnQgJMhGSMgVGtyTBOI76PrUoNRxHYRnCzkDm/f9epGSx+hCJfyMq/x2L349BdKSIDqIdvlAUwL2GXKG7rzx8YrdFeKU6dQ5YERFYf5GwCV69GtX2y2WBem7Rg2D3X21vA4bnYMXeJZFHLeABRLZaGVkFXxBqKQYigoQCfcqOj0Mzh7JiO2jlmBC2cm7BYafZghiLhCBicMHlFJDxmTOMiOFRwQyA8Bq+PfckAzgBzbK7F65FSXYwQ7m1K1o7Y/U3QUZpL7rg0ZGPhP/KJQ6EL1Frs40Jik4C7kof3+z9W63VhvjEiuDAoGKAbmebzglNKplXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8441.namprd11.prod.outlook.com (2603:10b6:610:1bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 19:26:44 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8158.024; Thu, 21 Nov 2024
 19:26:43 +0000
Message-ID: <da2ab4c9-be5d-43c3-a2fc-2d3d0f227e47@intel.com>
Date: Thu, 21 Nov 2024 11:26:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 00/19] xdp: a fistful of generic changes
 (+libeth_xdp)
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
 <20241115184301.16396cfe@kernel.org>
 <63df7a6a-bb4a-410d-9060-be47c9d9a157@intel.com>
 <20241119062543.242dc6a9@kernel.org>
 <85a32259-d523-49ed-9441-634e4c2e881b@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <85a32259-d523-49ed-9441-634e4c2e881b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0318.namprd03.prod.outlook.com
 (2603:10b6:303:dd::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b209cac-5053-4ddb-3c4a-08dd0a626eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RktNd012WVI2QjNFYno4aXVsczNUTnZoWFV1MGdDTXF2cmJ0UFloZ2RST21K?=
 =?utf-8?B?Q0lOVllmQXJoQlRmUW4ydHVZZFNYRDhSak1PeWxLWmdac2huZ2RWOE5vMkRt?=
 =?utf-8?B?UGJBZEJPNFhoRFFRQzh6WlpSaTBCaFdsbjRyUlJraEd6VXFRMWdiTXkzbkFP?=
 =?utf-8?B?Qmhlb3VJdGtGRk9JWU1GVWpMV2VsR0N6TURpMWZCRUxiR3BadGRueXlFYWpK?=
 =?utf-8?B?S3ZpcWx1Wmx2a01RZTkvMDhCU1lRWlF1T0ttYmxLTTBWc1AraDZaaDFRdElo?=
 =?utf-8?B?WkhpMUhvdVZKVXR0eXhlbG1tUHoybG9FN1FkdVExVGUzWEk0b0tTdlJ5Y1B6?=
 =?utf-8?B?OW5vYlRmcGpjRTMwTHNMTkx6TVYzRmFvT0NuYkM3RHVrVFJ6YjNKRUlDUjRp?=
 =?utf-8?B?MXA3YlJFejJJTWZyK1BkQ1JzUFJaU1Bid1BSVS9KbHpHWmJjQlJGWkdkMk81?=
 =?utf-8?B?d09EQjYyVC9pUTBnZTZLRXordUNyUkpXWFh5RW12dm5aWWdQV0o1bWdqS05U?=
 =?utf-8?B?QUJ1a2JqOXZaQXVWd3p0NWtGQkxuU3hRRlBCaHJvT2dRYzVGTWdHSTNvSXFn?=
 =?utf-8?B?R0JCQWxWOUxLa08rck4wcW5nTG5mQmR6bWx5b1pQQ0QyelVXQ0R1Y1JtR3VZ?=
 =?utf-8?B?dzZSYXRpUmY4QzV2VDV5eVFWZUdCc0NXR01oNXVRYU9UUFdqT2xaNHNqTnhL?=
 =?utf-8?B?QS9UK2FOcEpnN0lqZDZYR1IyR0xRSktQcU9kRG9sRU9DMXJDL0pka00xaTNC?=
 =?utf-8?B?T0JvSWtNSWZ6RG9ZWmlvcDUxOXhGcmhDcUFWZElYZXlxT0RTbmJ3OXBtYnNm?=
 =?utf-8?B?cTl0NFNHM1hvV3FQNStxdFRDRzN5ZnVRODhSYUJFTldoOGxHcHFINU1yL0xN?=
 =?utf-8?B?Z2NDZzBKVkdQdnVmRklSNVppak1WZjdHdXRCallETGVRalpQMkdkQWpLUC9p?=
 =?utf-8?B?ZVpwTWtaSFhKYy93dHFqaEdxNWhpTy83V2ZxamRtZ0hnWnZSVHVtdDNvbDR0?=
 =?utf-8?B?R0VORS9wSStXd29iYm9oTFV2YXcvYmdTQU5kNFY0WFFNRmlRZ1drUklSVjRO?=
 =?utf-8?B?WmJwMFVUdWI3UlJZaDU2Nm9LNlVDY2ljWUVXcEpXRVhFR1pvUmU2ZkZKV1E2?=
 =?utf-8?B?dms3WjNqdE0vdC9LeWtCZWljNEhVQkF2Mkp0QVBKRHRva2ZpekRWdnI2cVdV?=
 =?utf-8?B?SXRiQ2FPd3R3OGFJMmpIM3JGdVlZUVZ1anIySmNKMnEwZmh2dEcvcU11OElC?=
 =?utf-8?B?QnFKcEZYeXFLMVJFaG9RcEljemthTUdYTVlPdG9ZcDRkWnJKbDdGcDRZZ3NE?=
 =?utf-8?B?Vk14OXU2cTBVd21PYmpYTUtuUVVZMEZaeFRseDJBclpHNFVqYjNOVHRXK0Y2?=
 =?utf-8?B?OHNvWDYvUE9pcXlnMnFkZVEvVkNzSnhuMzNRYlpnd0JUWkVWVTdXa2E2YXd5?=
 =?utf-8?B?V2UzSE9DZlV5ZnlWZUtJOTRGeVhTTFJiRjZIRG51VmdoT21vdnhVL3owQ3Fs?=
 =?utf-8?B?azdKVHR4dm1jTWRMNGNWaW5HTjdjT05jQzYzeTJmVndLK0Mxa0dWOFhoREFQ?=
 =?utf-8?B?d1pnd0xGOFR2VkQ0NGRJZWZSUWlhM3dZMVB3cXNOSE85ckRjQ3ZCYXRCYnh3?=
 =?utf-8?B?Y2MvQUl2T2pYNFF6c2FRQ1RCQU9rSDdxZG5PaGhBTnNGVkp1Rm0wUG1KRDFP?=
 =?utf-8?B?dHd5QkNLVFpmcm9Pd0U5bXQxa2krVGd4ZlVIS2R1ZlN3Ynp2RlVrYTRSbWF2?=
 =?utf-8?Q?bA0fW+mZP6NFf6Z6U4Jm3wW2iVbMxmzEhSojlzt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjF4MUl5elA1L1I1VFBsVlZkSmU2Z04wcGtiaVpBdnNtRU5hN1dpK25vZndo?=
 =?utf-8?B?dUlPaE9LeHZYZnVsZ1BpZnhReUFJbmkxT3BRV0NaMEhkMXRIa3IzRkV5L28y?=
 =?utf-8?B?L0pHV1p0Mi93bDltTDFLeTZGWTVFei9uNnZ6K3Ntck52VGNhVTRabHVMQXhW?=
 =?utf-8?B?S09CdjM0WlUyMk11RGRtemJ4SVhEbFpWZ3kxdS9SZmJCNVNvOXErd05QOVN4?=
 =?utf-8?B?dDFKQktDdVBhRkV4dWRkK2dlNHJkWFI5V3kwSDVkUFpJcHRjTE1MMnNaVXF1?=
 =?utf-8?B?VDJOWVJXL3VNaXZXbW9ud24wTmRaM2JidGZiN3pYMnk5TUVGdmY1M0R5aWdJ?=
 =?utf-8?B?U1hxbFljRnplRGlldWY1aWJMV2d6UE0yVmVseWZvUHc5STRhd1MxaVZwN29r?=
 =?utf-8?B?cmtyK0ZkUGRCNHhSN1VXb3AwRFRtcTlBaHV2eFBCanFMSFNKTStidVFaOHlr?=
 =?utf-8?B?NUV3YWFiSjU0UG1nNG80UjFlQzROdVZleHUrZ25menZIdmpjQWJzNitoaTVm?=
 =?utf-8?B?bnpoODEweHFldWcxV3RXR2c5V2IyQVNDVUxhOFhxMFZya0szV3ZhMnE1ZFJY?=
 =?utf-8?B?aWpUTHhPaElRdjhxcy9oOFpSMitRb2lmN1Q5YmxPRDgrbnphbUhwMUIrWTQw?=
 =?utf-8?B?akx3Z2xqNWtsUTFhaHRZcEhockM5U3EwU3dVbVNxN1NGMW1HcGxHZ1lvYTB5?=
 =?utf-8?B?d3g0YzBRN3NKQ0VCcVQvWUhZVk5GRTBQTUVZRlY1UFduekJrL3ZQdUtQcWpj?=
 =?utf-8?B?RndkUjZjN2RYendiS3o5MnpoTmxwakp3Z1oyTkExM0V2L1dDRXU5SDlETnY3?=
 =?utf-8?B?YmxGTUxvcDhtdmIrMnlUdEV2QzNGY09mRWFsMUk3bk11bkgvYlBabEI0M0tR?=
 =?utf-8?B?bXhhRXphK1M4VUZXUCtqMXorVWlLa1U1YXZWT2dwUTMvd1hMRTFsdTNyUFdK?=
 =?utf-8?B?OWpWb3dQSTRkQVJheFNzRHhwUG1IYU9FdTBGcUc5VitaMHNGRmZJZ2lWVG5a?=
 =?utf-8?B?RXVVUXJucUlGa2xCS3VHc1FoaHVnUmgwUTB1V1h1OTdvV0RQMDV5bUdMWmZw?=
 =?utf-8?B?VlFORzV4ZjQ5TjhlcThDMlZ2OVZ0ZFBDQmE0SlU0ekNBM3p3TE9PdzJyMmpv?=
 =?utf-8?B?b0dBK0R0WUtLZEJqNWQrRTg0OEY1WFpJNDJib0JySklmaW5UbjRnMWRNR2Zo?=
 =?utf-8?B?QjQ4ZndkeC9kaG5sT3NSUy9SaUlPcHlsTTdQYjk0M3RIZDNBTWhLV2xGYW9H?=
 =?utf-8?B?cWNkMEhrZWJOSldxMFZ2UTV4OG5DV0JOa0toOC9vVTI1ZVl5UFpUUllwQk9V?=
 =?utf-8?B?VytDOXdQUThWMXlzVEluMGJEZlFycFdnMWN1bEVkLzRabUFJdk13Mm5NbTE2?=
 =?utf-8?B?THpmOW5RUjYyeUZVM0lXcEhycmh6UFRnTXRDd242azNkVHRQbnRMWlh0QVY2?=
 =?utf-8?B?T2lkZ1cyZnlnb1ZSdU94VlM3UmU4RUpMZVU4anQvRFNvTTFwRi9kT3B6OCs5?=
 =?utf-8?B?QVJYYUxkQWdBWVR2K0xLRS84ZEtLVjRKbi9LcG5meEJ2L2lkcXFkdTNXa0ln?=
 =?utf-8?B?VFpnZkhUbEtvRW9zZmUvMXQrQmhYL0pjN0JGZFFIR2MzWG1BTFNST05GbmRl?=
 =?utf-8?B?dzI2bVpIdm1GQy9HbDhWclRNRG1KSDczUTRuYU1vN1lNdllJSUtlL1JvTzlt?=
 =?utf-8?B?R1NOcGVzMEhYZ1QyTEZKN2VKOTQ3QitoOG53UGZuY3c3YndjdFlrR3czSjFl?=
 =?utf-8?B?aWtFZG9LRzNUUVJmVHNyNWs0dTZNQk1XeThCMmFYaGdUaS9nYzNVR1g5WnhC?=
 =?utf-8?B?MmFDRnUvdFNIbkwyNWNHOWh1WGZaanpFUFhJVDhoaENuc1kyR3dwaHpnM3Ax?=
 =?utf-8?B?bkcyRXFpeEs4MTQ1Qll1RVkrZk9COGNMYjNXbGE2OW16WlNhTG1VRUxFdHVM?=
 =?utf-8?B?bUpYUVFobHlWZGVKbkZyMkRSOXg5WHgzUEdiZTJ5ck1mSDFIaWRqUGI3TDFr?=
 =?utf-8?B?alMycXFMVTNFMkVXQmVxRDVJSTRHa055R1lldEsxRy84dTZnMGYzbVBzVHpW?=
 =?utf-8?B?Yjgvc2ozamlIaHVoKzFKZ1ZxUEp4cFREejlnaGUzZEJ6MVVyYUZFNlVoR2dG?=
 =?utf-8?B?enJmUWNvSU9Zd3BFSzZQdjVGUW5kMkMrV2dtS25qbUxLOXV4K3ZIOGZWWDU2?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b209cac-5053-4ddb-3c4a-08dd0a626eb6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 19:26:43.8435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gN4EBc3hCgaEo5dIIL81MxCoY79ZYaDn5ZvF09INHfXaR2P2wwszJ9N0p7SWRGUeUTbPLjwcOx5i8auVFEnVnG9sibpql+iXupEIy1uf9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8441
X-OriginatorOrg: intel.com



On 11/20/2024 6:40 AM, Alexander Lobakin wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Tue, 19 Nov 2024 06:25:43 -0800
> 
>> On Tue, 19 Nov 2024 13:06:56 +0100 Alexander Lobakin wrote:
>>>> This clearly could be multiple series, please don't go over the limit.  
>>>
>>> Sorta.
>>> I think I'll split it into two: changing the current logic + adding new
>>> functions and libeth_xdp. Maybe I could merge the second one with the
>>> Chapter IV, will see.
>>
>> FWIW I was tempted to cherry-pick patches 2, 4, 5, 6, and 7, since they
>> look uncontroversial and stand on their own. But wasn't 100% sure I'm
>> not missing a dependency. Then I thought - why take the risk, let me
>> complain instead :) Easier to make progress with smaller series..
> 
> Sure, I understand. I wasn't sure it's not too much for one series, in
> such cases, I let the reviewers choose :)
> 
> Thanks,
> Olek
> 

15 limit has been the policy for quite some time, and I don't recall
seeing >15 get merged in recent memory.

Even 15 can sometimes be pushing it when there is obvious good
breakpoints for series.

