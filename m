Return-Path: <bpf+bounces-48683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B18A0B8B2
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 14:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0231687A8
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 13:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E1F235BE5;
	Mon, 13 Jan 2025 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJicj3zm"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA8822CF05;
	Mon, 13 Jan 2025 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776276; cv=fail; b=HXntQgnJ9EAyL2XVuPapEKSg5luqs/+N1dIkt6/N2G0vPBtTukI1MzI8I7wFLrFvqgDW7Ob+0vap9Cs1411L8I3Iyq/tgR4GR3CXRreeLYK02PL2rtQ0ieBapj4XOKVdzMx0aBq2mG8KUlrcEc2BJtOsFhDIOuGBaKHxVujvYy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776276; c=relaxed/simple;
	bh=vvJgCYwcLrDAkrvoW+VXF7ZOjxjKR01QUyy66RkqidI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g661+FLIdUfXQbYIw13TJ8MPPzbj1634I9fxYOgyO17oq2ByMtbqJsxmmWJyhUJJHA0FbatR5le+H73+RmnVo/XK57WaWlrLVsSp1YJ8y/gSgucfPywXtzqaCsnJChFwQT4djtgnphHCfKw96/8XqTFzNFGESsIUI4lKj0M0e1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJicj3zm; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736776275; x=1768312275;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vvJgCYwcLrDAkrvoW+VXF7ZOjxjKR01QUyy66RkqidI=;
  b=NJicj3zmg+nSnW3puubfyQivxuCOy7oD1fnuhPjjJE5Gpot1yL8LXR8R
   ENFyWMcNlJLAX4gFINeJClmeTjcG9C6C4dy3d69sfPUydhq930jjFqwU8
   wMIziOF06/aZteNJ2RKdyNzyfqObIgB9uBFfj7ZEtiOQu4KxTRF1qr7qz
   sTfIx9XQ+9splaldaBHd7spFQEoPwurVWOU0Eh3XLkmK4J4uZuHzHhmgJ
   wahpFdiWul/1UY3GlGvHVnmiFUx/QtcW7vneNgvPKO3kazcwRQgVZQhTP
   yzYuBSkfE8r8UPNWyFWHRvYuyxs4wCsLbF9Q4AhM9crZGAn8KDtn7r8R4
   g==;
X-CSE-ConnectionGUID: z9nJbRBwSeeiblv0ru7y+g==
X-CSE-MsgGUID: ewyQsjyGRDqFOCqvFlntjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37201040"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37201040"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 05:51:15 -0800
X-CSE-ConnectionGUID: cRp8OxcsQkq4dMT4OIYBww==
X-CSE-MsgGUID: HAk7+dP7R8mskF6WMexFjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104443413"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 05:51:13 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 05:51:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 05:51:13 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 05:51:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sygqsytmvd0TBXnw0IUSUPLjuBBg9b8uYLTzlc5TXBetQFRoMFapaAG2k7CdJIRZkAX9vtf2IYJANUSrSdzA0eRDYmyYYiia7drsb/9z7OUIUw1J5mGQE3oBXoTOi7fCLCaWNsz7C+I5UDcWgCqo69TskHSWyUr9ejSw3B9FjqDAMUn3KsY+h/+I+CiW8yBNTSbornBbthYL4xWvOTTK9QkmSYZOMot/xu9YFHC7G6d281DOZ5NvPijwC0BeNMwTvt2Vv+mvmj79DQ+AUkvRhUuvUZg4HWJEvxIsSAAoPMxE0uJB6lYptTNqXQz0o4F84+8s6H3OQ0IlIwkvUkE8jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hL4UgZvdWSIbOriEUpAFKXwUm0fpVkBn+Un3Ugn4pM=;
 b=y5R+pXogYky4BNxu2Y+nUWOZl4UO4eh/kAg7YgpuT82IePnggyA2lcYn//y//i6Sn1789p0kHb0vbDdjkmkt7SnYXp37nBFYo/lEt5w17zWcE2nkPA1gU6BYSR/aCCzWcnZDNE+NNBWeozUEd7viZTd068olnfmIUVfZR4IncpWNSFfb8w0bjhOg1Q4zTt9eIwI2rcnEFdlRPdsO2+jrBaGZq6KWMSV5R2LSuLC3M4gZfS6dctKSKKfDC+xNOq0dVgxiui0lMP2gkXj8GW3RM69LprP7FpBE9WpOZV3WJ/Gb4AWGf4gLf7oTCwPujP1p3Hj7NgXrVa+CGlzFDfOYqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB6267.namprd11.prod.outlook.com (2603:10b6:208:3e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 13:51:07 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 13:51:07 +0000
Message-ID: <49b932c8-431d-4db1-8675-b5c66461f566@intel.com>
Date: Mon, 13 Jan 2025 14:50:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/8] bpf: cpumap: enable GRO for XDP_PASS
 frames
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
CC: Jesper Dangaard Brouer <hawk@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu
	<dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jesse Brandeburg
	<jbrandeburg@cloudflare.com>, kernel-team <kernel-team@cloudflare.com>
References: <20250107152940.26530-1-aleksander.lobakin@intel.com>
 <5ea87b3d-4fcb-4e20-a348-ff90cd9283d9@kernel.org>
 <d37132e7-b8a6-4095-904c-efa85e15f9e7@intel.com> <87cygvj4xo.fsf@toke.dk>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <87cygvj4xo.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::24) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc2bd45-03ad-424f-e4cf-08dd33d95429
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0tjTWhDVHZKN0UxYUhHME85bHlCUDJZWHNXQ0JNekthQldnU0RITzNwMmNp?=
 =?utf-8?B?MkRyL0RmdXE1YlY2c1o0OWF6aUxJcDU3WHdRdzhKRmd6VzdRczRDRHUxaGwz?=
 =?utf-8?B?MU1GanBXSm90VFJhT2d6czVnc0w3em9XLytDK080a2pIRnJkb0NiaFdXNGxh?=
 =?utf-8?B?Z1ExYVVtQVpNdVEraUdkVVhJTW9UZEdrV3VTbTJ1YTFodDRTcElHOFU5QUlQ?=
 =?utf-8?B?L2xqWXAyakl3SnRmZjFpSlBMbVNNTko2WEg3bXQrM0xLcGZxQUVFcmZiNDRY?=
 =?utf-8?B?dkJLelc5aGxISjBhUVFEVUJtUWhZUmdTVWQ3R3JxZkdxdXlWZDBZSFFUcEw1?=
 =?utf-8?B?RExQd2JXUGwxaWhvaGpKTndwUzZHcWJJSTF5UDNFSmZsR0lTNndBOEVTaWZS?=
 =?utf-8?B?NWQ1YjZjeE85NnBMSWRIZDdNUHU3WGhVeDZtb1BMZ2pHdGoxQVhTSjBuSGt5?=
 =?utf-8?B?cGs0b3FvQUh2aTZRcU8xZFh1QWU4L3dEUVV6WVQ1RkRjY2pCODFnQXRGQXlR?=
 =?utf-8?B?WXBpQ2N6b0FHc3VpR3paSGxOUlJWNFB2Vmd3akxVWWdPdzZaU1VuczRHcnRX?=
 =?utf-8?B?V1BoaFZYcnBnS1hJSmZpZE01OWZPYUw5Vi9lSnM2K1psYk11SXBEZmovdTF2?=
 =?utf-8?B?akVLR3BuMndBZXhXUWsrVnJzTlA5Q1BRM0JCMy9mK3FWTkJFRTh2QkpZcmJq?=
 =?utf-8?B?cjJzbTRTY29vWW84QkFrZzM3eC9vUVZOWWhOendtNG8rV0dlSjg4eEQ0MnZZ?=
 =?utf-8?B?QTZGTzNzRC9sckhhZE0ydW43VnB2ZzB4dHRxNzg1MDU3bU00K2VHN0VOejJj?=
 =?utf-8?B?SkFTSk9PWkdkUk4yaWRiZTBSS3dzU0k1NUtQbG04VHllT0VtRWpoWjZNLy9h?=
 =?utf-8?B?MVRTL01FS3cyN2ViMHBtZUxwVjlCSythYWdiRkpFMzl2cHR2ZTVDZkRMcVJ3?=
 =?utf-8?B?bVI0YktWemZmYXZXZHpRaGgwSnY5Lzdra2YrZ1JVL0VkNDJIOXhZUm43VDlm?=
 =?utf-8?B?R0ZqRG82bnhFWkpvRm5WNFVOOHlHckhnU3ZFdWg2UG9iQ3NEc0lpT1JyeitU?=
 =?utf-8?B?VmpIenRRUVVJYVRMSHlwMjFHcStJRlQzVElHYmZ5d0M2UnIyYnRkU2FvazNL?=
 =?utf-8?B?YWZCbmJEMnBGUUVGaVVVaDVoL1B5SHo1S2ZLY3hJRmxIYWxKZDQ5czZDRnVj?=
 =?utf-8?B?MDRRdGlHZFVMY1U2R3dTVXRiS0lhV3loTUdabDNCbjEzdXlobDhHQkcyVU01?=
 =?utf-8?B?VnRhTm1kK3p6czV5NkNpU3FwaUE1QTY0c2U3MmZGTWZwc1ZsanpZbHFOemRw?=
 =?utf-8?B?cmplcS9hL25UY1lCM1FyVTVpalhaZ3RSOUI4ajBsa2lFMzBiNzhXT3BzbGV3?=
 =?utf-8?B?S1VzVnZITHZHU0ZHSWF5cjkvWjlOemVlcVB6Z0ZVNzZmVVRQUXJucXJOdlJ2?=
 =?utf-8?B?THUzeFVPVXRYeitBN2hmb3JvOFBLSVVpSVQwNVArYWRVRXlrWjYrVHovd1Ny?=
 =?utf-8?B?TlhjTEI5UUJNNW1IUUFOVThJUXpRSHF6eDREcURPYnFOTy9vdmVieit2Ukdv?=
 =?utf-8?B?R2hFbHFndVpnb0pGQ3hja2dvYStYb2xTR1FnRWZDMmlQeG1GUUIvWGR6bk5U?=
 =?utf-8?B?cFIyUTFncVVWNExoVDJrZzZRSndVbVVSZ0FMV0tvRU1FRGRrSTduczVSN1VK?=
 =?utf-8?B?ZTlKakcrRWxUTElqR01kTy82SjlwYk9Vb0FVQ3VJQ1EzYUJ4bklpM25yOTMr?=
 =?utf-8?B?NHEvc0FrMXJFOGY4a2p5UjdhNDg2YW13cm9mZVZXcU5qTk9qVWlZNmk1RnBi?=
 =?utf-8?B?OVFIZGFhbHdPb2hNbE1jVDRycldCUDRhZGxPTnNCOUlMUUNOb0FqbEhXaExN?=
 =?utf-8?Q?e9XTIyX77Gjqf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGZFVGlwM01rLzgwUHJEY0ZLWG9Na0RkUFlZQm0wc3N2NzBkYUEzdU0zNk1K?=
 =?utf-8?B?Zy9Ibkt1QkRXdDB5TnVDUmx5ZTBUSG9SdTY3T1QrSHpQZFMyWFlFb25jYzZB?=
 =?utf-8?B?dlptOGxGNnc0aDNyVnRSNWpmS1BsTEdNMzdmYWNtdnhBZUhHQmMwRUM3QVhT?=
 =?utf-8?B?SS9zK2IwNXhzQjZlQ3NYL3FnTyt3U3Znd1hPMTJlSFhucGhuZmNpbXNBVFBJ?=
 =?utf-8?B?bm1QVlVWdDJBZEVnMG9FbHkrZjcvMVRTNHdIdmFVTkhnS3l5VHlOYmdaUFRG?=
 =?utf-8?B?VXN1Sk50ZkNBazFxMDhaZHVkL25uLzVLYmlLcm5zVHRFMzhaYWVkUWUyVHRz?=
 =?utf-8?B?WXJoczlTU2Y3aHdSV3B3aVcwbVNZSWtXL2ZhbExwVWh5aTVlOHdNcnkweVdx?=
 =?utf-8?B?UFFtNnJRZG1iK1R4eXNseXFBdzRRZWVTZWs5V3krcjZqT0R0STUyb0c3Wks3?=
 =?utf-8?B?VlNkVklwNnpyRkZQbnBUTHAxdWx6S29OODlLd3l2L0lwUFdIdEUza3JxQm5I?=
 =?utf-8?B?Nk84eWJ6RHduSzdLbHMrUWtyK2JVSHpMeStLek90aXdWeTZYYmxuV3hLNlhS?=
 =?utf-8?B?T015RnA3ejRyOEI4MTd3ZTJTcGxid3N4c3pDbjRMRXF6WXRKYVBsaEU5Y3pN?=
 =?utf-8?B?QnRGNVErNUs2U3NQMnNBd2tsZEhnOU1Wa1JCVlFzdWFoRjJQbUFBU002OEQ1?=
 =?utf-8?B?OXZ3OXE5bGVYTTJXdlR6VXBtbU16cWM5QkxkeEZUOEhORW1XR2F2eXFiaFhG?=
 =?utf-8?B?SEtDbUswdElNM21DOE9LeG5SaWFnckV2WGk3MUtScXJUa0pWZ0ROVUxSZ0Q0?=
 =?utf-8?B?d1R2VW5mbVg1T09vU0IyZ3BmRWswdTQzb0dvRDFscUZsaG45TEtLL3ZNRnRB?=
 =?utf-8?B?VUJXY0ZyTDBaMkVHOWhBa0RuMVl4RWxpUko2RE5ZVVJHeXdORGVLS0JvelVL?=
 =?utf-8?B?M1dxS2FhQzA2Z1J1ckZ5Rk9RaFJubUFncGgyWnREZHgzbTBoR3hUZzlkZG4x?=
 =?utf-8?B?aDViZVhCVFljWDlHVEhrYXZZNEFmYzJJNWFJcmR6dk52VGtBN2pOQUNGSWxO?=
 =?utf-8?B?K3ozc3luZGl6SHRMdXI0QkxnUkJ5M240bnU5Nnl1ODFnbjhFcWd6c2ZPWjFq?=
 =?utf-8?B?cmw2K2VXdUZhT1pGakltWDFrZGVveHNLc0FmTlM1RG5LcEdRa0tGWU01SzhZ?=
 =?utf-8?B?cTFwSnNMclF5Q3BTS2w5VFpkL0FDcG9NeUNKQXd2NkE4bXVTNk1wQUh5MWhn?=
 =?utf-8?B?WTdoanBmb1UxWFVrVHA1T3gyNEswTDRXY3lVTnFmK1lBb3JNZmM1V2pmTUZ6?=
 =?utf-8?B?R2Rhb2xPZTNLWHVqNEFiTUd4Z0dsYTNuUDJUb2Qvb1lRSzZlNkxJZmpFUzIy?=
 =?utf-8?B?YmxKaDgvbTJjU1o5Zm1sdGlEYWNNbnVSRkxER1htUE9zTTVvZWR5ckpsTEpx?=
 =?utf-8?B?ZllheERSczNybnU2ZnVJeHpIa1V1RTYwM1o4NThNdGQ5bzQwaUxONnpxZnk5?=
 =?utf-8?B?aVA1SjBmbWszZzBDZ2tDUW4vb1hsR1ZNM05TZEdPRzZzemtYNkN3Zk5TNGZT?=
 =?utf-8?B?THhYT1VlT0l4VS9MUWhpazFUSWtmazArOFpVR2t0Y3RUL1lOYXlTZHlxTUVR?=
 =?utf-8?B?MkZMalBJZks0aisvQU9KUDJLZlNDcnJCRUJqNGdvU3g4a3B6SW5pcWRITjR1?=
 =?utf-8?B?a0FFTlJJZ2M2ZXJzMmpueGFieXNTT1MzK3ZVbGF3dzRMTDZMUFNCcTZMK3hB?=
 =?utf-8?B?MUpmVTJtOXNFUWZtY3daL3RvVVk2L09PZlcrYVp5VjBZRWFGeTNnMUhMZ2Nh?=
 =?utf-8?B?NS9BMnBhV2hHYlRzT01UOS9GeHl2Um1EYnlUQ2lDVjlpcWlOSUxYWVlhZWEw?=
 =?utf-8?B?YzRvWWd5R3VBQVZpb1VNMU1paE5STXVKUUJEUTNIc01VdzRsWGhBYUh2VmtL?=
 =?utf-8?B?ZStFR2dpOTVybW1sZ2ZVcEpRNHNTdm4yRlV3Qm9MaHF0cVRURU85VHJPWHpy?=
 =?utf-8?B?aVdmMzJUTm15N3U4VWdIeHU1T0llK015RHkrWTQ0OHJJd08reWdnR04wM0tE?=
 =?utf-8?B?ZjlUWTVvd1ZQc2pycUg3M1MwcWloVm5XOXdKNjUxT2g5LzFkZ0YrL1JOeitO?=
 =?utf-8?B?d1ZlMHRDNHgwKzNFK1lCL2R6bmFQdExYeHdTVVdMR2JaRDVEbmdwcFVjYVE1?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc2bd45-03ad-424f-e4cf-08dd33d95429
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 13:51:07.2497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +p00DKY+LNRMtC1FNjxG4UsQwTzztiJJr3ZVs6ooM3MUlVZmv+ONEW4Vu6R2QZsSisxhEYXjlZZIa0WGE1lFtH50+g267/m7J8bQwcBGPdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6267
X-OriginatorOrg: intel.com

From: Toke Høiland-Jørgensen <toke@redhat.com>
Date: Thu, 09 Jan 2025 18:02:59 +0100

> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
> 
>>> What is the "small frame" size being used?
>>
>> xdp-trafficgen currently hardcodes frame sizes to 64 bytes. I was
>> planning to add an option to configure frame size and send it upstream,
>> but never finished it yet unfortunately.
> 
> Well, I guess I can be of some help here. Just pushed an update to
> xdp-trafficgen to support specifying the packet size :)

Cool, thanks a lot!

> 
> -Toke

Olek

