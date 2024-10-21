Return-Path: <bpf+bounces-42633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 594849A6B1D
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 15:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152D1281CC2
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 13:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA90A1F8921;
	Mon, 21 Oct 2024 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ae5CR8bq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8631E907F;
	Mon, 21 Oct 2024 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518866; cv=fail; b=f6a2u0t70SesQUyudg6iNd6/vg1VZ4BVcGPgzRYq/7oys28fuyRDvIHoYYbXNGmmw2zn4TYrnh7ym8UjjjJKSLa+PVM6VyjQNG+KoIFPKoVO6MD5VgjkCGkSj+BNDuiMg613iriX8ds2m8HCaRhr/njdAR68faJbi7bn5lgP2Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518866; c=relaxed/simple;
	bh=nNQVqLKQitOgfgR6tsw/EItvx6vVZ9/2q23Y/a8RqxA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Db5A7La5VXz5SauoQX3l736Q2NNy1sbZsPbf8KvXjy5IcFM2MmjzXIj3CP3bM6/MiZiZyNic7B9zgFDTq7kzOdihhHo5O/3xD442GCo/k+xlB8eAn48pTdBM3tUNwZUhMxbg7toy0XdTNoMVDgDjOS10H1MDpOYKCn4zdtfUrLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ae5CR8bq; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729518864; x=1761054864;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nNQVqLKQitOgfgR6tsw/EItvx6vVZ9/2q23Y/a8RqxA=;
  b=ae5CR8bqT/r5e/pfugx5hUGNXUGYdPL/gql5LzS/8E8giWqnntRUHBKp
   Zw0R2LJ8M57VyTS8urIwEss4JCLJWH7xKxLwUvJ3IdcodThPole99seTa
   4gfjaGvQ106zrVvUGayPDX/IYClfTK9CtBrTfurf7zqhoGtCfmBVJSZo8
   M+XrgEWtquzPgZCXKtZBxETfv/wx/wgcmsqvvAeFzmAh1AoEihJsnFNJ7
   C66T8cBefajIaKlcf+DdV09olSZ49jS8rJfUtB7RQJ066cY/ysvjAI80i
   UiDJ1eD6/5m+B3upHOGSS4B7ZgrWbJ7EpMabqVT7N8S8cydM4vIcX0lhJ
   Q==;
X-CSE-ConnectionGUID: scT4V8j5SoOn3thO85kqEQ==
X-CSE-MsgGUID: 6dEcZdtLStmtQxp3HAG3Xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46467595"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46467595"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 06:54:23 -0700
X-CSE-ConnectionGUID: 26RRZ052Tciial0zIGKL9A==
X-CSE-MsgGUID: pSrAJrm3R5KEgA9V2nVxaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="84322236"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 06:54:22 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 06:54:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 06:54:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 06:54:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOWhStP078htzCNQl5gXDZk1OONv/ub/ss0PrEKcquhmdDZZbJ/6LLee1IJ08MEw3gJmaKDMoP7YzVaRBfntLRWMshVy6SrHOunATB/WPq/Swj0+P3/bD+6LZ6xDa921aYCL8PTIVBJKbTxqBRiuMMGpRjEPWPINq3aPhscETTGmBXGCosw6UI268nztkKL4RhjLmPnJ87yuCXi9o+mRws5siAphqN6eEGS0CovgMSaMNV37HuewiH3P3Yt2nijlYNhkUSmKcFexwpKOe/29uSEkcsoLBP05rCt2V32n4fia16uVgWIFxX91sfw4NHsH1FW33ChmGygQGMIsGlVxrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ig2uoQ/aWTk7srKiO9lFwGZDARyVLiEltRuWQMkREec=;
 b=oCk3/NJurOXKfQD2afYnzVgFGqDaB5nOrEHKcAgfCjVjy/f1VKoI2dfHMH30gNb4lZTIS+oX89E9Tcoz5i+g5NVKMMln+SJRGbiggBN9Hnev9+FX+D5Hurxcb3K+2ScnoRF32ADGjie2NBGx2Lb7LpdJVa5/3866I8a4kQQhdaVRtE7h5yUCL2paL/zVl3QtsWEPBYkAJWU7KQPg4W4HlRaUVxdtT29hXW3AxgXI2PXqaAE8yl9MSA4P5ZCie8AzEkEkzH9i4DUjXIYMsoz2kT5Br/G77PsINKO+9PiCr0dZ2SA2yZdvUj1eLPPbhmKGd7w5X1uJ+TiH6dJ05gLMBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB6799.namprd11.prod.outlook.com (2603:10b6:806:261::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 13:54:19 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 13:54:18 +0000
Message-ID: <1fdc9726-e21d-43f4-aee9-59276ddff37f@intel.com>
Date: Mon, 21 Oct 2024 15:53:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 01/18] jump_label: export
 static_key_slow_{inc,dec}_cpuslocked()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
 <20241015145350.4077765-2-aleksander.lobakin@intel.com>
 <ZxDvsSPbnY5iCsAY@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ZxDvsSPbnY5iCsAY@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0058.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ce77c6-465a-476d-f397-08dcf1d7dbac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0dRYUxqVXBtbktGQUhBSDVXbGlRbnJJM2ZtV0xGdjVRQkV0V25vMUFjZ0Qr?=
 =?utf-8?B?S2RRbHdTZVlmR2F6MkZ1K2hTRGd6V1dsZkFuN0Voblh4dWRsOExIUXRGSDhW?=
 =?utf-8?B?ZTZqY3R1cE5tUHhOSVUyUitZVCtjNEJJSnVhcU1wVXNDUzRBd0VtdWJ6cXd1?=
 =?utf-8?B?OUx5a0w0ME01K2d4bHZSWUxwNDZzb0FoYzJtR1c4Z1d5MktQLytVRjJIOXk3?=
 =?utf-8?B?bXRzaGJJRzhxREJnYXRSTS9VMHlESDZWUDZUWlg4QjloanhGeTJCWXBhZmtD?=
 =?utf-8?B?MmJjWE9VTnEwaVFkZ0Q4RytsYkZiQ2FjNElmbmkrQTBPajBSam1Xb3pSVVRy?=
 =?utf-8?B?Vk9samw5aVgxbWNuNVgrZzVwU2JZSUhJRk9qTHVGZmdTNWIwM1gwN2Yzc0tp?=
 =?utf-8?B?dnlKWDF0N2tnVTNrVDM4NUhENnZYYTk3ZC9MSzFMRVpoYzJvUlptYlA0L29O?=
 =?utf-8?B?cmNXNThRNm1na3JhRmljeGhWZmNoWGhBcUQ0RUdINmpEby9ZMU9sMDZpOXZz?=
 =?utf-8?B?dnVhN0ExUzNrSlFjSTdPd202SUxQVk9SY1BUMk92WXJxT1BrSTV0Y0U5OS9n?=
 =?utf-8?B?Z3VWQi9iaS9XQXR2VEpjK0p5bGtEVythTXNyRkVrYWFiK0cxM3RRRVBlNlhW?=
 =?utf-8?B?U2RBT0xLMnZFcWp2TGNwaGg3Q1lBMkdmdndkT3F0UXVqQ0ZvR2VGNFlxWVZZ?=
 =?utf-8?B?NjU0QkdLdXNPODRkbTZjTWlQMDdlWmlNbDBFWW5RSG9jcW9CYmtRUVZmeGxR?=
 =?utf-8?B?U2RzaUI2ejJiR0dicUJrSkdlSytDQnBWbm1IMlI3aWphQ0VEREZmb2FxYWhq?=
 =?utf-8?B?SHl3TWVONU1IV21WQS9nOEJEeXJRcDdCcWtwSEdtRkV2SmpFdWc3aDRRRmJo?=
 =?utf-8?B?SGt1ajB5ZkJOQWhGMEZScXhJa0tRYUUyVEtQRG9WMlBGN2dwR3BIaGFwZWc1?=
 =?utf-8?B?RlFhUEd6TXdGM1VheXhhaGg0K3NXQjArT01GbmFuYlBPY0k4YXprSVBxTTlh?=
 =?utf-8?B?dDJkSWU3N0RHcFU2VHdZS3M3UU0ydnBHUnlDY1N5b2xCYjRGUEU1aEowQnMv?=
 =?utf-8?B?SHhxZ1VYelh4OWQxMS9Wb3BZNndQKy9NUzR6VGNlN1FzK0JCNXJFNlZxeDZl?=
 =?utf-8?B?SWlBWCtaNjJ4V0QzbVlvQUg5b0hud2wxcm1sNm5DTnk5NEg4WDRjcFlwaEtr?=
 =?utf-8?B?amFCOVV3MFJQQWVNRVpiTmJaeG5jeEplVjhBNHpTeUtBWHVXZ0NtdHdseGpO?=
 =?utf-8?B?OU9xU3Zvc2FxbmYzRUwvTU1JWnJVRjlMbGl5eG91NXI5UFdoWmVQK084NHVo?=
 =?utf-8?B?TW0reCtraWgxTU80VWdXOCtzaDRXV0dkekhidzk3K2RoVWxsYWQzc1ZBc295?=
 =?utf-8?B?a1VuV1FQUjZFU3VPSjZSU0huU0pFRUIrVTB5YUJkeXcyellJTHJ4R1o0RXRr?=
 =?utf-8?B?Tzl6cXI2bis3S09KMWZseFA0bmlQaW5nMUp5NTRxOG90UlU5Y0pvTlUrUTg3?=
 =?utf-8?B?Z1kza2ZHNVAxUzNzN1NrOHRGQW5mYkdTL1VWL0FJaGxWZjBwWENrTGdUYTha?=
 =?utf-8?B?dW91bnZJSFUyb05MVWQ5WXFIMVY0UCtrWTdnRzQzT05SWFRqV0EvbzFScktY?=
 =?utf-8?B?b29VYWNhL1Jac1g0bUIyNXdoZ2JqSWtzZU93YjlsL3Evb0tLWExTUTcxM2Qw?=
 =?utf-8?B?ZDdJb1lPMU5BTXM3TGk5QkFwTjJUUnN4aFg1bHV6UllvODRyaEFrYXpIb2VM?=
 =?utf-8?Q?Y/MlM2V2iEV+ia4GNs1neIrl2VV4BE0BuIgFkAX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0RheVF3RnpsNWVVQ3hTTm0vMzhidTVrMWlWZlpwMkNBelpWRGRYMTE1L3Za?=
 =?utf-8?B?cXdtN1BsdVZ1N3l0UVQ2elBReDBIV3R0dzFkQ2txZnhzQzFBNEZwcEhCeFN4?=
 =?utf-8?B?Slg0Tmp2QXVBNVhHTm5sYjdSemxJbWs5RmFtZG0zd0tHWndhZVBPNm5WdVBL?=
 =?utf-8?B?Sm56YjB2Yk9wS3JoZERSOUdnREsweVdYelpIR05qeWFRYmJTTUVXTVF4TERW?=
 =?utf-8?B?dGs5bzZQNExmejYyR0NVM3YrTk1DRDZ0T3g1czlwUUpOU1FtSW9KaUVKTzJ6?=
 =?utf-8?B?d3Fsc3NOZjhlRjViRWNZNnVvTjNJSVlRY0xpczU2TnZHaGFHYndLZU11bzNS?=
 =?utf-8?B?TUg4Z1R4UVRmWDRNQ2ordzljWnVsZ3poZTVtQ0tQT1JteE1TMHMrL29Bc2VS?=
 =?utf-8?B?bFEwNGxYWEdwUjAxcFpobkNOVUhpNm11UVFHcGVKT3ZVZjFjaFcvRTgvcTVB?=
 =?utf-8?B?M0tFb1JUWS9US1ZSTkdBVFFjNVpNdDNPVVB3Z2dxN1lxb1Y5UnJ1U0tsMm1t?=
 =?utf-8?B?dGVRV3BybFJOcytmTUJNSXRaMWtUUHc2VUN1MzVKVU5yKzBlWDU0aUJ0YytO?=
 =?utf-8?B?dWNoM1R4TmNUM0tOYU9MT0ZIRlE4MjY2YU1hOXVlM0k0ZHZHaUZTNk9jNVhJ?=
 =?utf-8?B?eHFxbnZDcGRlZ2Z6bTlZdjM0YnNqazJOMTNoTTR6NEtFU3VIYVRsaDdvN1Zn?=
 =?utf-8?B?Sit2MWMwUjVVQlRJYmdJcVFKQUFXelpDOFlBSkw3czJWTmZ1V0dxTjJSQ0J3?=
 =?utf-8?B?R1ltb1ZBQlQ4eFhiek9oa1UyU3VMdGpqRjVVUXUyR3creC8yVFhtRGhTWnY3?=
 =?utf-8?B?eUg0UFNWbnRHUVpNYStSWE04VjZGU3RialVrc0h3cGNjeklwTzhrZ1hMaUN4?=
 =?utf-8?B?OHNlUkdPdnVNU1lTK3IvQVRHY2lDM0gySzFmSEp4aHNrY09uQTQzY1Rtdk95?=
 =?utf-8?B?NmZ5djZGbnZHYXBzNDdXR3NsUTVGSGwyaTdUdVArdGpBbytJa2ZoZGNGdlVz?=
 =?utf-8?B?ZEtsMmE0ZExuUWNTQXNVNzZ2d0xjQnJQU3R2UEVBTk16RUZwWi84WU5paSt3?=
 =?utf-8?B?eUdIV2hBQ1pqNldJZksyL0ZaNFUwUE5IQStSR09iOG80NFROKzNFVXlmMDEx?=
 =?utf-8?B?aEF2UHdYMmd1dGVqaklscndHNjFRaTNLM25kTDZueVFnWVdONlNjT3dmVGRv?=
 =?utf-8?B?bTIvOW9wTWduWmdsVE53ZWpXeVpXL3hCSHNIRDRySG9EMm16eU5mUHpzcTU1?=
 =?utf-8?B?YSthTnFDazZlQ1gxcjFRbG9zeDEzeG0wNGdHMmpPdkZkSk9NZzhpaDVVUDFY?=
 =?utf-8?B?Z2oycE5VclltL1h4V1V1SFk3RENobS9hN256b3VIQmdRNnMxS1ZKNTd4Q3NO?=
 =?utf-8?B?NU1FQlY2OVRPOGduZnQzT3BXR2hzVmMwdHc3UEsyS2IxKzh1TWhFMGtUaS81?=
 =?utf-8?B?bGxTSnZkQnk3Ulp3VVMxM3lrYWpnWU9IRGdSTDZ2RkFid3MyYlp2eWIzWmox?=
 =?utf-8?B?eHRUcDd4MXlGSHd4NW1CeTRBaHR6a2NrTnR2Skk5NmVXT3RsVXJJTHdVYVhG?=
 =?utf-8?B?ZXN6dmJpNHdRVGZDdU9OMCtEeGVjUDFRWlJxSnFmSkRkbVR5NVFVcFFMbWVJ?=
 =?utf-8?B?NXVqWFBQWTk1VzhsUDJ5TUx6N21oS3pPZTNicytpUmEzS0dqc2dmWXpiZE1i?=
 =?utf-8?B?WnI5akVhYkltZ0RTSDUybHhXWDg1SzBGNFRjUGl6ZUFydXlVYmdMVjRORXBR?=
 =?utf-8?B?ZllWN0xEYlE0b1ByaWtHY2hWRVZMSW9lazE4TWZIQ0JtSGtZcEJ1L3AvUU00?=
 =?utf-8?B?MWtRVEFZYUpxR0ZoM1A2dG9VYUxCYmFJRkZqU0hDUE1sMGlqNDRVM3RjdE9V?=
 =?utf-8?B?WEpKN2lIYzF6TXRkYUpCcFVCSk5aeC9jdlRYSGI2RURFV3cvMXhOdnZ3RnRz?=
 =?utf-8?B?NDRDT3dBYXZDeUZha1FKQk01Y2xWU21pZmRoWDJCUUVNNjhUYnFUaHNMK1J5?=
 =?utf-8?B?dHRPY09PaTg4NTlad2oyeTN4VXlxcmZLZklrNDNZb004VE1HeUY3VVBkM0xv?=
 =?utf-8?B?c051T25BdlZ5Nm0zOXIwRE1CK005TjVXbUN0ZWRCSHNSQjRFRVEvQnBYbEFQ?=
 =?utf-8?B?aWYyK3VFbFdFOXhtSWp3ZEVnRTI4bnJjZFBHT0hETXRHZGZxeFJRYnY3a3F5?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ce77c6-465a-476d-f397-08dcf1d7dbac
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 13:54:18.8369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6mcfuo6q1vbbWhgYcECEtj1qF6OzheQE9wSzGztnQa6dS1aAW83t3huIyhYMmxZ/rF71MHosshURYloXJyYE256ZUyNe+rxgiitjjrPWMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6799
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 17 Oct 2024 13:06:25 +0200

> On Tue, Oct 15, 2024 at 04:53:33PM +0200, Alexander Lobakin wrote:
>> Sometimes, there's a need to modify a lot of static keys or modify the
>> same key multiple times in a loop. In that case, it seems more optimal
>> to lock cpu_read_lock once and then call _cpuslocked() variants.
>> The enable/disable functions are already exported, the refcounted
>> counterparts however are not. Fix that to allow modules to save some
>> cycles.
> 
> Hi Olek,
> 
> can you explain how is this at all related to the patchset that it
> contains? AFAIK I don't see it being used in later changes?

See libeth/xdp.c in patch #18, it's used to enable XDPSQ sharing static key.

> 
>>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
>>  kernel/jump_label.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
>> index 93a822d3c468..1034c0348995 100644
>> --- a/kernel/jump_label.c
>> +++ b/kernel/jump_label.c
>> @@ -182,6 +182,7 @@ bool static_key_slow_inc_cpuslocked(struct static_key *key)
>>  	}
>>  	return true;
>>  }
>> +EXPORT_SYMBOL_GPL(static_key_slow_inc_cpuslocked);
>>  
>>  bool static_key_slow_inc(struct static_key *key)
>>  {
>> @@ -342,6 +343,7 @@ void static_key_slow_dec_cpuslocked(struct static_key *key)
>>  	STATIC_KEY_CHECK_USE(key);
>>  	__static_key_slow_dec_cpuslocked(key);
>>  }
>> +EXPORT_SYMBOL_GPL(static_key_slow_dec_cpuslocked);
>>  
>>  void __static_key_slow_dec_deferred(struct static_key *key,
>>  				    struct delayed_work *work,
>> -- 
>> 2.46.2
>>

Thanks,
Olek

