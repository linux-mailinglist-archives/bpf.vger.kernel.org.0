Return-Path: <bpf+bounces-48682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F226A0B8AE
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 14:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9752E3A99EB
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 13:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B4E231CA4;
	Mon, 13 Jan 2025 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d9fSqBPX"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC3722CF0B;
	Mon, 13 Jan 2025 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776216; cv=fail; b=apXFVEVvMjoOInvDemfeEOBzMO85u3CjFiQPNvfPdlj6rzB7o2J3kfgG8PGADXQOC2C8Mg3r2H0XFgB0vZU1x4yCI9/nUaLQQl0RD8iPz7GrYXxGHm8rkrDNvmnySdcam3EzoOEPjRlzQT4ysrh6gW91+9/w63724RLiUjtg33s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776216; c=relaxed/simple;
	bh=En9H/rFfnEiiFcN1xq26WIVqgWiWMJ+2WsQIFPwaAOY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eguNVJWM5p1fhZBx2gaf7e1pOlyUxiuQSloSWGeTNPBV3W3DeHhY5tRVDeISPhxoeoBgu0cPkSKi3n8uP5f/LtMhVXQsGdmD3SQI8R7fC5KP8ioomUuNWzr13vqeU47mR4IOyLAyoLd3kaBgKd0vpMGqHrRvWMZ/s/I0oIzUPPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d9fSqBPX; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736776215; x=1768312215;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=En9H/rFfnEiiFcN1xq26WIVqgWiWMJ+2WsQIFPwaAOY=;
  b=d9fSqBPXFHGdQ+u/awufn6Ti+GtGE7RoWblPiLlG1SmvPoN97IGFUURD
   xX2jFhYl8jv5Gnbl9PUnPMNuFBDN15XIYk/ggoiENaayUrn6c/3cJ4eoq
   1T/y5naqrqPhwd9PnPknelN8PWy0xtmtl7fmoFEwGZTc0TNcn8qqnvKIH
   n7f+G/ZNKd4Od98bMa7T3Ws3nFMUxtlvjSru/CfvA4152aA2pfztZswCZ
   m8CDRoiCnSRYybq3fSFpsMCfrYK0lwiJJocLci//ArTe0woK6Zrj3/bYA
   FXAFL1JRCFz+nyH82WJDenZcD4gmbT9L1Se+Y8sedDinTPbJsVI1X3W/r
   Q==;
X-CSE-ConnectionGUID: W0ttBQg9SgCEK4MLtkN2DA==
X-CSE-MsgGUID: 8Cx7ooXxS1m/gzeDSoyc6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="36923860"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="36923860"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 05:50:14 -0800
X-CSE-ConnectionGUID: Zu/IALa9QQKbvS6Pe+XBiQ==
X-CSE-MsgGUID: ynIsjXj+TEy5fAjcwXmy7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104993541"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 05:50:13 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 05:50:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 05:50:13 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 05:50:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYaXWmDn41qvZRSzUlhsnh7p7/yOtnR2Ej2t1fVgrl6HQM0Y6S/4C6O4BAuTG78V8BojPycLoowNKAnKZWzw/tjvNX74lTBKfblLwyPzx+OAHjfbNfxOikubfg5B5GUzpd/sd8dAJKtwCkbitLVK9iVesFv1RZJ+onS91BRncl3WIb6JvJxsPlldKcHBKezK0roZUTEDHj4JWQ9qf6LuV3P3LNnjXIvlsLD7DsHLBrfqyztk2lspVkFv4XL7ddPWhyYuXi1yT6fthB7G/PM1AABxQ8gAa2UDYW9cbsOk803fxRXzJUq4bGbDrJz1uDuYxzFvhyO1UbVjeUXXeUR9+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlJU2MJRbGOm5OhsckQ9eD+0lkbcbuHvtj+CxJJZnJ4=;
 b=fzuuikPKEiPQHaPq5WqNskdQ+Gzvu7nRiAQMF8okkBj6HEeGtXVXj3h3bllMLu2cPSDKI0Tz4qt2F0G7LGtbg9g8OWgYEz6bIgVA/sVQu1aiZE3swJ4A5XjrQOSlThbK6A07S35LrJYjvKIoEN7tuRZaH5xUsURCZdaC44xOufAMYU+pamtvCMnT3C3xr9Z2w63oRznHwGFLwJW6IGQHmJfEMzbkr32uy3pFLJm8lH34bhZCgCzClcVXh5aMiET+Tuy7y8EQHpMpdeC6usf8DWwwA1gZM4MTQlv9LVvsUbOwE3an3Uoo3CBY3G6NUksTY6qbga2NE/ZOF3dx9pe7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB6074.namprd11.prod.outlook.com (2603:10b6:208:3d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 13:50:09 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 13:50:09 +0000
Message-ID: <a222a26b-9b1e-416e-a304-fd9742372c7c@intel.com>
Date: Mon, 13 Jan 2025 14:50:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/8] net: gro: decouple GRO from the NAPI
 layer
To: Paolo Abeni <pabeni@redhat.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu
	<dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250107152940.26530-1-aleksander.lobakin@intel.com>
 <20250107152940.26530-2-aleksander.lobakin@intel.com>
 <4669c0e0-9ba3-4215-a937-efaad3f71754@redhat.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <4669c0e0-9ba3-4215-a937-efaad3f71754@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0003.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::7) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a6d87b0-05f3-431c-1896-08dd33d931bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2g2SlUwdndoM3MxMWRZaWdNbWovM0hUWTk5WkhsbCtRbTdtT1pRMlhGVURh?=
 =?utf-8?B?YWVHRTFDek8rcnBubHFDQ1BRenFXdldXcTR3ZW5ndXV6QllPTkZCZm9FazNR?=
 =?utf-8?B?NzUvVDNKL2pDcUEzcmhGQkJTN3FsdU15b2ZYOFhvUEYrbm9ONDNHZHhNZEs3?=
 =?utf-8?B?aEhYZWVoamdYNkJ5QldEYmtaWFc2WjIzdWU2ZzdjSUJIRUJ2NmdWRXB4Umhm?=
 =?utf-8?B?RVkxS3ZtZk5EOGZKZnhMWnZIVitsZ0RWSW96cnZObUNKakpxSGJhUWxkWHAv?=
 =?utf-8?B?b1ZlSCtXVGdnODRMcGg3Z29JeFBaeWt0NjJsZkZ1ZmdmZkowZUFRMXYrcVVm?=
 =?utf-8?B?bHhJMDQ1cC85Uk96VWxlYUVqUFlabGZudUhLWVZVczJiczMrZDJ1MzNLRUQ3?=
 =?utf-8?B?T20yZzBaeFpZajFHTmpIb3F3L1pDcmNNa3QrZW1NUFV0S081dklHRkMvaDR0?=
 =?utf-8?B?K2pCSVpYTlJndkdpRDBkdzEzM2lNam5BWnZ1dWEyZjQwblY2QjNlWTVvMW15?=
 =?utf-8?B?RnNxUlpBVk4vVm9oc1BiVnByNDg2Ti94YnNINmFPUmZQTnVVMzlUMDZqVzIv?=
 =?utf-8?B?Tlh2Y0NxQkpTRVBvei9ZME1wWXFaVGc4OEMrWFBEZjRyRTVFRjJ6ZXg2S0dv?=
 =?utf-8?B?d2JaR0FLM1MrSHlGc3V2RjE5UXJJNjA0Mm5ybWZHYkZIRHllVCtCdm5zcFJn?=
 =?utf-8?B?TTNuSVRBMysweEpNUnp4a0o5U28vOENuaHc5SmxuT3lYSERkSkRzbnE4N0ww?=
 =?utf-8?B?VkorNUFyaExCYXI2TDJrWVdLdUNoa2FvRE5xcFdGT1YxUzU0eGZRd2hRMWtr?=
 =?utf-8?B?S3lNank2NTY5MHArLzVFcllzOW5WSEd5bFNvUVdFeUluZFY1YlJENnZRclNR?=
 =?utf-8?B?ZTZJd3BzVUZyNWNHcmNjSlBSNElIcWcxaGIrcFRYN0ZuenhZc3hROU5SbDli?=
 =?utf-8?B?MVh1T3hHOThoaFYzTk9ROHVOM0lqNzdNS2FDR0NIejdmVHdobVFGMndXSVV5?=
 =?utf-8?B?cWRKd05LbStEcTFISWd6cVFmZFBSeGQxVlZRcjlxQ0ZRYStnR3dsRm1DeHBq?=
 =?utf-8?B?YU12R3N3UkRMclhjS1JkNE5nRTFmN3hPZ3FZQ1RCaXk2VnQvUXBUWXJtdktF?=
 =?utf-8?B?ZDRUT1NTTWRxSjVxeTFjN2IxUmZnSjJMVkRCQXRrNTB6STN4Z3dEOTBNVS9h?=
 =?utf-8?B?SS85WDNzbGEvcktsbDlKd0VNYW80M0U0V3d1TzZKMTN5ZjVLcEZ1MEoza3Fn?=
 =?utf-8?B?eWIwclluYmdFS21tWFd5djdLNDdsQlhUOUwwQlArcXRCZTBJUWJhUVYxT3py?=
 =?utf-8?B?TW9YMy9SYWkrUER5WXdLaXhOZFRxU0lwQ1JKbDNVYnZEdXJ0dC95V0JtaWp5?=
 =?utf-8?B?R1V4MGZ1ak84OXBGMmtQc1JyRzU2ZnQxNjJrUXdSZ0hqdTl1ZTJ4MnpNNGJm?=
 =?utf-8?B?ckh5WmM2T0x5eFZtekdVWXBIMFF6ak1hSEd3SWt0Zy9wdEV0MVJQdHFRRkY3?=
 =?utf-8?B?OVhhYnlPQUE4TlNuUWhGQ1VXcGxHTW1VS2xRRGtEbjBpbzhXUDdoWVFqSE5s?=
 =?utf-8?B?NS96ZkoyV0hXeHhXRUoxNnNjWFBNU1JIdW91V3NnMnprRit5b2t3Q1Q4YmN3?=
 =?utf-8?B?WHdqcmNTc2lKTUEyRUZaSHFrRit4eUJiY25vR3NPKzNCejdncWx5UnUreE9W?=
 =?utf-8?B?ZWZYK3JmUXh2dkluZW9PNEs0TlIxc0R4K3FXeUhDczRFTEI3K1RVZm9VSVoz?=
 =?utf-8?B?YVMyWW10ZU10L3ovRkJLWjlhWHg0RXg5RjYzSmVRdkYvMVFrakUrTUNUamcv?=
 =?utf-8?B?YTdxbG9lY1JlNjcwQTI5eVk3ejgyeVJvS25WUWI3di9ROVJzZnJBU3FZMjFG?=
 =?utf-8?Q?4lkvpXkv6f5St?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGFXcm9ocEdJN2RLSzRQd1JyeGVKTGZ0Q05ERXlOdUo2bUVxMGpmRU5zZEYr?=
 =?utf-8?B?eHl2ZGpwSGtLWDNWcHN1OXAwL1dNbXBkcUJmeVIyYzVoK3gxYXp0V2pKYlUy?=
 =?utf-8?B?U3VpS05pOEYwK0pmV282M0JUUjI0Q29XdnB5Y2huTlZlN2t5MUNRUnVpdDBL?=
 =?utf-8?B?MlZlZ1BqcTJEZGxWU3RXRnlwTHA2b2Jlb3ZCU0JiTWhlRDZFZ3lDN2VETFJD?=
 =?utf-8?B?a24yb3JVMDVYRUpuNnIwNVdyVHJDZmxxdlEvQnU0VDdUVUFLWEFtMDA2czZn?=
 =?utf-8?B?dFJzU2gvTDRPOEFSbWRxVmhvMGlKWmY2OE1qS1dUbFdYMFRROThGQUlwWFhu?=
 =?utf-8?B?SncwdGdjQktyMFgyUC9aMURnUmlGcEluaGFHVDFFbmxSUHVFRXU2aGJ1aTBv?=
 =?utf-8?B?Y0x2bGZRMklaNkVPS09TYUNMTFZIQ0pwTDNKV3gxdE5iSnkzanFqcUxzbGRU?=
 =?utf-8?B?eDJqVy8wYTJRSGpJUFdOL3Zpd1JXbGxhTUNjZE9WeGxpY2tValBTdG94NWJF?=
 =?utf-8?B?NFVLeFN1ZUpybnpHU1VLMkgwZDFyaE8vQWgrM0hDTTJJWVFoOG9MTGhzQXlO?=
 =?utf-8?B?NVk2eHNlT0t1bnFPUk4vZTRiQldselRJWENRSVVmT1d3ckQ2VGdaNWgrVGRK?=
 =?utf-8?B?cFdXYkNDL09Db2ZBWkFSd2pzSTNkaVcxMG41bURQNVNsZ1BSY3pVVkpJV1p0?=
 =?utf-8?B?MEVsZENoTEhWMVBQbk82bGREM3VDL24xZ3h1a1V6R0YxKzhaWjJGMVNLUjhV?=
 =?utf-8?B?ZnVKcndTcmhhcnorUmNSQzg2NGhRTVVKcXI5dGVHSElFa1Voa1lOM1hXSjRO?=
 =?utf-8?B?RTRIam5GWlF2WFFjUlRNNCtKNm5Sd21aV2RzaWs5bU90U0dlUFhJcyswbkNZ?=
 =?utf-8?B?dG1mQXhtdTRZbmdWaTM5c3hKZHQwY28vN1l6ZFlEdCsxRlZDR05LclVEd1lE?=
 =?utf-8?B?S21nZ0c1TS9YTFVOcFFpZzUxckJVa0ozNUF4aVo3dVhEK2lxN2NVWXVlRnJQ?=
 =?utf-8?B?ZUQwdSsvY3c3QjF6NnpOR1F3NW9lQWFvWjFGVmo2alJIWllkK2xNTW9JY2RC?=
 =?utf-8?B?VUVPQld3NUJzL0ZJc1hXSWVxTjRNWjM1L01odG5VNXRnYUJydjZURGw2UXoz?=
 =?utf-8?B?ZU5tZVhnTFh2UE5pWDMwNDFibzZwaUdWYUtxaDVYMzhubmljU2hzbm9FVEVY?=
 =?utf-8?B?YmxRTitiS1Uwdk1BR0JzSVpWaktycTNDdVVScEhENEVhTTQwbHVXK2pTMXRP?=
 =?utf-8?B?bC9UQ0RGcmRibmxNTy9xTEUyZ2kxVTNFZHYvamI4OTZLY09mN1kvd2tjREpi?=
 =?utf-8?B?T1hUaWhxU21DT0IxYWFyM1hMYlNNUEo4TUtpdDhSditYdFdHWkxjK2RNcDMw?=
 =?utf-8?B?MXRSZVpWb1pDUXlsWU5pY1JnUkJ0QVVSNVZLMWo3NE4rUXg3UU5QSHJ2YnFu?=
 =?utf-8?B?SzFSbHk1bnVNZEpIM0NtSXhjaHk0YU56M1JuSDBsYVA2K1A4WTVTVWNLaWZF?=
 =?utf-8?B?U1FyWVJrYVJ1a2tIZTdINEkwL0N1YTh1LzJ0d2xwdk9SMWZkS1YwQnNSSEpQ?=
 =?utf-8?B?d2pIYWNiS2ErbXQ4OXNaTGVZeDFmamE3b2hBbFI4TFZMV1ZJSkJjNzkyUWFG?=
 =?utf-8?B?WWRzNGhkQ0YwTjBmanMxSVdjaHBxZjI0UU1jd05Jby84Z2UzaTBYb2tXZnho?=
 =?utf-8?B?amFSaWJ1Y09yeUtKeEdOYmltd3RMd2lsUWtINkNQb1ZRL29VNHg1WEd5RGsx?=
 =?utf-8?B?bUVpdzNDVG1sRGtRTm1rYWZQR0VoZXZSeDlMN1dnaEhycUVPRXdDbmFQN1ZT?=
 =?utf-8?B?Y1kzLzBjWnpROXZNZDl4RUwxaVlDYmU0dTRRYlIvd3NkK1VHMFNOdHlLSjN3?=
 =?utf-8?B?SUpoVnBBeEhOQnZCZHV1K0xHbnVOY0pJdVVYc05UNDlkckFhbWw4Q041ZVQz?=
 =?utf-8?B?WGFGVkxDczkyNGUyNC9MQ2pBbjBscHdWTVRoWEJkUHJpVUROMklzRHBEYmxR?=
 =?utf-8?B?TXNrVUZqZmZDYkg4N1BqRzhYZ2V1ZjFZUnN6N3Ztd0RBNVhZcC9SZTg3cTJF?=
 =?utf-8?B?ZEMyeHJVYy9MYXY0c0NURmlsdkdPYmdiaEh2a3QvVTJFWHBML1gwZXMwMHly?=
 =?utf-8?B?WitWMnlJY3g4RzBucDc5M2s4SWtOeHJ3bnk4MFVXZlN1OHlVSUpYTnB4RjF4?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6d87b0-05f3-431c-1896-08dd33d931bc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 13:50:09.4637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B49vKXrOJgRIBsnYByPYret+5lK+Nqcybh2M2h2bwwIJfN9iOKoBsNb/0vkM6cYQUs/+nTZPJ/DKVtWb7IX8t0emLEnaFeEV3YJs4hJHXfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6074
X-OriginatorOrg: intel.com

From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 9 Jan 2025 15:24:16 +0100

> On 1/7/25 4:29 PM, Alexander Lobakin wrote:
>> @@ -623,21 +622,21 @@ static gro_result_t napi_skb_finish(struct napi_struct *napi,
>>  	return ret;
>>  }
>>  
>> -gro_result_t napi_gro_receive(struct napi_struct *napi, struct sk_buff *skb)
>> +gro_result_t gro_receive_skb(struct gro_node *gro, struct sk_buff *skb)
>>  {
>>  	gro_result_t ret;
>>  
>> -	skb_mark_napi_id(skb, napi);
>> +	__skb_mark_napi_id(skb, gro->napi_id);
> 
> Is this the only place where gro->napi_id is needed? If so, what about
> moving skb_mark_napi_id() in napi_gro_receive() and remove such field?

Yes, only here. I thought of this, too. But this will increase the
object code of each napi_gro_receive() caller as it's now inline. So I
stopped on this one.
What do you think?

> 
> /P

Thanks,
Olek

