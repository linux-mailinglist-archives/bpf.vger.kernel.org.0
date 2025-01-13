Return-Path: <bpf+bounces-48681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019EDA0B8A2
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 14:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49EE27A4C89
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 13:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B7923DE94;
	Mon, 13 Jan 2025 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3KoWEaa"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E102D235BFA;
	Mon, 13 Jan 2025 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776097; cv=fail; b=HYgiCP7GhSECNq/kh6bM8KphZ5W1CXCBeexuGt4WrmW5AkP+gpvPoUWC3kmyjWKQ9oTUIqvsv88K5meooax+vpvBB9dNqfXqbwaaLroqZIDoLfIG1TzXKpm0zkHbu7JuOD/MpgH5FrnwJUnQT96t6JEoDrcSkdKLnhUyshCbQOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776097; c=relaxed/simple;
	bh=eYtZnJJFZGfRmWMDLSo/LlSKbPWtM5dcEu43ViIEJBc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=exUIcZPqnwWrRFBRh7PYHIsxaSwAitYr8LNaNp9VCC3yeYL3NpUkZipkooCxKoXPyv39/PyVipSULiS1wKd4sLqzkGvcdD5Bmq/RRa5Hs1kzq8igYXlZfbJpm2ykJ6+Mby7f1hIUR4LTE6y9AAY9OqTb2RyKwu1QYD3i5sy+wQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3KoWEaa; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736776096; x=1768312096;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eYtZnJJFZGfRmWMDLSo/LlSKbPWtM5dcEu43ViIEJBc=;
  b=W3KoWEaaYEZKJmWQ9ftCwK26/7zEAKblmAOO3CaZMymunujlYyYFNrKn
   HuLdZmPS2DsC3WCHZ0SLE7foEh1GmyFivxoLbX5FPue+q6OUGFB7xxlpM
   F5bSObKrrk/1SaJYWbO5y+3W2mzmF8VvIZlVmYsqTpVMHFqtp/KLQllpV
   4l4sA+/rHU2NIFv4TORCoJJT6PereAtE9LJvZKYfg7Ij4ERer2n3650lL
   qclryzXMjOnyZCjdnDrT/fPvj3qoo63RcNvAiwHCcrUWC89kg1nYXxoju
   iw78d0RA1VdKf6SRZQ6jbXERof0FsOvXKcPTKvajfS7U1PM8ux6qZ67vy
   A==;
X-CSE-ConnectionGUID: uL3D7pZbT6Cdrh3UMAUZFg==
X-CSE-MsgGUID: xGBH1RZfSXqku/XBflivRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40805191"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40805191"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 05:48:15 -0800
X-CSE-ConnectionGUID: vj1N+DMpRN6Ip7ly7rhZhg==
X-CSE-MsgGUID: SlAbEboMSU6Fnqtk92Cv9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109117712"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 05:48:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 05:48:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 05:48:13 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 05:48:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPFcclzLHaXjKCiP4ujbDGfXYf8Cp7i4dFD1C0MoFTcUDp7uLIZaJqDVa/Aypvzypbv3PR5jkcz29QB7y5KFWDNEF/uhVcWIDxGDtTjX11ZNa75FxQ/ZM1rmEsSIbgWEyMErs4MoHJUsa2TrJbkdZEAjpwsEYVhuUa/hT6SPqWNc4cXf9z/VlzrBKV3QD6QhKq9/KKXGwxa5GzqDuWU/+16PB94Pi1kX/7AjTH4PYqLExnJ/LeBJ4Yzuz5hhSMNeGJu/4aZs92BYNElqdQs7Z1/huC2FagHnzbUNbvwMQiKxwlIOw9bVzasH2QnLGwGDNEGG4a3luwsHiLtnl5Fx7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Idbsmwyc509yOdlMDblVwUvQfpiJvXCW7ypITpSKEE0=;
 b=nqB9bY69GQ3uFqDv6yRFGxb8I6nxpBYNk0IoLyUrTDrTw3ZNTKs1wE4h1FUnF4vuDCVXgmyMwDKJfA3wOoYpadtI8cIwuj2DHmEdPeBUfM+qZnWKemVIKRhKxT8rnEEMIEBKbILe8FnV8uWK7kYcXzSdGTtH1Y+UnpYUbge4A5fkAGEtN2N5riJwq113FU5opzf+HULZfo3QglPF7uNpCHggC4JYyin+O7UXtrhjpfX6XzXsB3y0Cnd1+5bD5wKIcwm7+9AMmNl301AnfKMZsS5fza6zN0R6xHZoN6O747vqxrgZjBFt0vfVTplTqS9SqIDu5ZHySzuq140sqYWEPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB6074.namprd11.prod.outlook.com (2603:10b6:208:3d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 13:47:57 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 13:47:57 +0000
Message-ID: <5cde5d32-c077-4323-8be6-1a051e6fbc46@intel.com>
Date: Mon, 13 Jan 2025 14:47:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/8] net: skbuff: introduce
 napi_skb_cache_get_bulk()
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
 <20250107152940.26530-6-aleksander.lobakin@intel.com>
 <d97b6ec6-59fb-4123-9d96-27b9b32dc5cc@redhat.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <d97b6ec6-59fb-4123-9d96-27b9b32dc5cc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: fd274e2f-cd16-4295-0bc6-08dd33d8e2fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWRPSnV1QXFqeW96eTJOYmpoaS9zOGx5VWVESGpVRUNKcWNrSGIzU1EzNWYw?=
 =?utf-8?B?bXVQVkFNTkIxd3dlb1hjOU5HTUhQc2RGdFNubkpzRTlUNzhEUjRBdnlhR0pS?=
 =?utf-8?B?cWVOU1c0R3k3eDdWMnlwYTRNWFJLaDAyL2trREJmVjBqQXJCcThEVklyOXVS?=
 =?utf-8?B?VXJHYVJpZTJBT0sxSEVMR0k5K091cmoyU1FxNk9rMXpScmx3Ykc5NGpMMjFz?=
 =?utf-8?B?ODZBeUx3a0l0YnVIQ3dXY2Y1RVdqOXRRSkU0empvZFR5Y1A2ekVCOEVxdGFu?=
 =?utf-8?B?R1g1N0xzTHRkKy8yVUJtemo3QW01Zzc0bGNXcWZTMXlEYVBzbC9ubFgwYzY2?=
 =?utf-8?B?ckxHL1Q5c3NjZzdBS2lwaE1EQWxqekQ1TGxiK3VPOG5Nbk5iUUFDeXk5bUht?=
 =?utf-8?B?QitUbmdUY1FiVUpRY2hDdzNXWnVpcU9hUHFPTVpUZUpnd1I4c2dUeDZRbUlo?=
 =?utf-8?B?OG9EUmZjSXc5aDFUckxvd25wa25GQkRIck9JUTlRZjhzWHByQTNQVGx0L3Zj?=
 =?utf-8?B?RE5kNHpwekZkbi9EVTJsM2ZaWXFUMURaNnUrTy9tOU9UME03SmlZb1lnUDFR?=
 =?utf-8?B?ZkZvYnJsTHErZUtSNVQyWG5MWEFQaVJVU3NCMVlvbjRvWHlMSGdFTSs1WWVx?=
 =?utf-8?B?MU9WV1dqcTRMSWJXMzlQbUlrNlhHbUxGWEhhaE1TWmEvYUhVendHeThOMTl1?=
 =?utf-8?B?ZXRxRm0yRmxzc0lYc2RHNnNST2JiWkRMTnZ1eDhKenRybXhSWWpqZ0pDbG1O?=
 =?utf-8?B?Y3NFVTFPZW51NGl6MGNPa01uRTNvQUVHQWFJMDV4NjZiOW9jblJTK0E5TDZm?=
 =?utf-8?B?SXpiWUFsbGRCVUdacWxoMCthRVpvbERMLy8ranBWZTc1ZlkxTGpkdGE0ZkhV?=
 =?utf-8?B?QXRjQUZxc0tMVVU3TXpKMndMYVZ4c0JXZFBZT0tidlJYckc2d2gzdVZ3S1RD?=
 =?utf-8?B?MXY3VlVyY3VIM2Q4MWYwT3lXbDUxcncxalBqNGtNeVlaWFlzdjRoTm1Wb3hj?=
 =?utf-8?B?M2swL082RUVlL3BSMXFnbkhWbHM3RUVJQXpsd0gxWHhWQmZzVUlxdVJiRkVy?=
 =?utf-8?B?UEJQRy9UUjA2SnlGbmc4cW0xd3hRMGtKQ05lYTRmbUtaR0FQWU80SGtrSVk2?=
 =?utf-8?B?WWFJUlpDUUJNRUd6eDFNbTY2QmpOWVoxdXExN1Y3dkxpemJ6UGU4L2VVdHAy?=
 =?utf-8?B?RGIrSmRNbEZkWTd6RTJLZGJiVGNFcWtrOFVzcUZCMGpoMkRlaThQVE5MbUwx?=
 =?utf-8?B?OUcvOTJjUG9ibUl6M1pwbFdYL0pDNkk1OER5K0R1aGV5NWd4WEg1aHFkdWN2?=
 =?utf-8?B?U2IwQlcwZi9qYnJqcmdvT0FMQTBOY2xYeWovZWhpZEN2dDE4dGdSSVlReVpo?=
 =?utf-8?B?MWF4MWxtd2ZEMzFTRmkvaHlkd3JBQ3RTR1luZHB4M1RJSU9NZFNRaWh2ZTVJ?=
 =?utf-8?B?NDA4YkVuanl5eEpQWUU5RGMrb2lOTHN4UWdHNkpLM3laVG83bmNYaERDanA0?=
 =?utf-8?B?bWQ3RnlCQUxvVFVndjF5TmR1REFtU3R6ZE5QbVphZ1VmamVaT3BmY0E2MjRW?=
 =?utf-8?B?L3ppWUUvSHRVbW11d21LV3VSbTZreGVYUVMvc1pkVjUyMEdMWVM4K0lTeVR3?=
 =?utf-8?B?SGNmWkdUYjNwZnk2VnI3eTZFT21LQ2VRRnROSnFsdUhyd3ZYY3JOQ2FiTHVz?=
 =?utf-8?B?cCtjdExGc092b084M2gxdmJMVnNCYk9peXlWYnpNamJZR0NnY09XSmRzVGQ5?=
 =?utf-8?B?aUcyMGhRQ3g0ZlR6YmNEbythbjNjaXM3OFhKM0FTR0hhMXNVVlhEbG1wSUlv?=
 =?utf-8?B?MUJiQ1BCV1g3MUhLZ1h0NDBlczdVUlJiaklOVUxSWVdEVmxxRVo5OTFYZElJ?=
 =?utf-8?Q?Sy2LPVxxLvSyO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU9GdEhqYkxhR3FHWjdWR0Y3ZElaNHprV1lSREhXQ1NjNWlrWGFrR0tpUzM4?=
 =?utf-8?B?aDdmSk80eGVUcVU2RHVnNU1hMzlreTdabTRqbTE1TnFFbGYyWGZScFhVdWJO?=
 =?utf-8?B?aU9yRS9CSUJreFBaUEtHb3lobENvL1p1dHlDVWQ1U2R1b1VPL3ljbG92ZXZZ?=
 =?utf-8?B?T2RIb3FKZE1nVkFzV1hlZHJid2dOekV4TUM5ZnNaREI3YWFyQW8rem1pVitv?=
 =?utf-8?B?Q0VZUE5HSFQycHNjclpLOElyOU5qOVR2NzJlbmRsa29aV1ZVN04wRFA1dGFG?=
 =?utf-8?B?Lzd2TzVVblVQMittSW1FSzVqb0dxNzRiS0ljZUZhbmFxV09lbjNZRlJYWk9F?=
 =?utf-8?B?bzF0YWpMNlZFbnFuczZtYXBGZDdBdEZQOWx4L2w2TGdUQThzNU0vSWdNYmdT?=
 =?utf-8?B?NXM0WFdTZkJoTkJyNTh2Y284bFZyWHE2cUtGamNLcEVTQkhtYVg5OW43L2tQ?=
 =?utf-8?B?MkNLZmJsVkJ6ZTRxUHFSWmtyZGFLYlRIdGJBSWZWMkpZRExxMm5xVmlhQmth?=
 =?utf-8?B?OG4wdlYvbEgvaXV4TWpMZ1A1VzNqeTJuQnNQV21Mc0ozc0h1ZVU3QVA4Y0FW?=
 =?utf-8?B?UWMrNVJkMm9xL3J3S2RYVGdLREpkQzIxcW1jN3JwbzBhQVpSNksxTFptaFRx?=
 =?utf-8?B?QmM0THRTWCtNbGg3QXBIUnczTjdjYzhuRVJtY3B3bDhjR0ZMQ3M4TmZCQjlU?=
 =?utf-8?B?eXYrM1orVERiODlaMWhoaDIyVk1nNjN2TzgyRkw0aHpPY01HckJhWkVkSUg1?=
 =?utf-8?B?MjVwdy9wRUE3SytuRkRxdUxMOEVleFM2VW14U3hJb2hYMTVDckIrNEVUdnpt?=
 =?utf-8?B?SUN5ay9ER0wraWFQang5Q0hydkpXZ2pKQXd3TldDSzRYOWhXc1JINitVY0R6?=
 =?utf-8?B?aTFoQzhoNjJyWitPUnU4d0FzcmhXdnVibmNTRi9UMlRVSnVIRHdvZWtkcnZB?=
 =?utf-8?B?eXdvRFRKbW5NbDJoNGVyVlZrdFRkQVh0d1I0WUw4dE5YM3M1UWw0bHF3MUVx?=
 =?utf-8?B?MmNkYWtyemJBZzM3TzIvVGcxUEZocm1Pb0NmdTJjRXdKbHJCOXAvNEJjSkVE?=
 =?utf-8?B?WmcvSWdjYi94RVcyTFB6SXdjM3M4Rk5mYm83R25PSVdsWEYrSzREQ3cxZFYy?=
 =?utf-8?B?Z1Z0Sjdtb1RReElNdlhhdEk0cXdqTGx5V2pMM3ZScy85amxjNlFhVzVSZHpI?=
 =?utf-8?B?UHAza0lITE9neDZUTGM5RitTZTlKQWFqNTF1bGxNY2dxS21nYXl0dEl1cVdU?=
 =?utf-8?B?WUdtcEt3ZVlsUUhIY0JIYUNFYmZyOHZEUzA5Z3R4aWlrWHJSa3pkS2s1aEtl?=
 =?utf-8?B?NFo5UmQyL0RVVjB5L2VUY2Y4MFRaNWFvYnlJaytHU0RGRWllaUZrV2ZBRzYw?=
 =?utf-8?B?SU1ESnQyOExQaXVyaExHVVRxQmxadWgxd2RDQllHOUt4TlFLUjdTaVFoamMr?=
 =?utf-8?B?Mkd5UUhDc0RVaHExTk5pNW1ZbGdxbWZJM2hvSE13MUQ4ckJLTlRNTmxaZFBj?=
 =?utf-8?B?ejA3a3gzVXhmTUZuMlNNU2RSUWtDam5nUE1UOEF1ZUtjRmN0eVJYZks2WFhY?=
 =?utf-8?B?OVl3ZVVMMFVwUmhUWk01eFBRUmxhWDBJSnllZW1IRTN3cmNUWGljckR0Mmlz?=
 =?utf-8?B?cGtVZUJEdEkrd3pxWm16empITU9sNVNFSmR3cTJUNlBobzl1ZGZNL3J6dlQv?=
 =?utf-8?B?ZUp1aklWL2sreTlPTWNTZnlySjQvSTZNSEs5bFNZMzhGTGMxOUxoWWFnZ2hY?=
 =?utf-8?B?Zzk4YlNvYU51VVRRS1V5Y2wxaVU1bG4wVmxyNUVuRnFXT2VRc1c5aTEzcDRt?=
 =?utf-8?B?RU5MbWFid21yMklaSjZYcjA1K0VpT3c0SjdMeTFmdi95WTRZQmFYRWZGZTdp?=
 =?utf-8?B?dG9TbFl1VWdZQS9qMStvb0ZhWm1kZndsMXFzTk1JNW1Cei9FUzZLRW5xS1pu?=
 =?utf-8?B?R0xWMHNJVE9zMXcvanltUnZuMllyQXkyVXQwM0NxUDgzUEFLSTY4OEk5UGI4?=
 =?utf-8?B?UW1nWkpuT0E2aTAxNzFEK2tPb21hUVJMUmZuL1h3b1kzZXhrNzN3Q3FXczJq?=
 =?utf-8?B?eitIWFE5cG5aZmZsVlE0WkU0N0RteGY5cDYvclFEZ281UjQ2Z3VXNDJ6WmRY?=
 =?utf-8?B?SVVOQlBXY3g0VGk3WGFLRW9yc1BvSGlIRE5Rc3hNSmxVcWxSZTZueENuV3My?=
 =?utf-8?Q?VJIZH1LuHNOl9GFm0HVrUlo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd274e2f-cd16-4295-0bc6-08dd33d8e2fc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 13:47:57.3286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3B0SLv+x9W2PzeRySrXIl4QcgIbSzICDOTDacvo2oJjsbtV+WzzgpwORic1iN8nxA4WKKiUTpkATrY1hgUMTvBpkhnyDHHc6rE7Smdb/jws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6074
X-OriginatorOrg: intel.com

From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 9 Jan 2025 14:16:22 +0100

> On 1/7/25 4:29 PM, Alexander Lobakin wrote:
>> Add a function to get an array of skbs from the NAPI percpu cache.
>> It's supposed to be a drop-in replacement for
>> kmem_cache_alloc_bulk(skbuff_head_cache, GFP_ATOMIC) and
>> xdp_alloc_skb_bulk(GFP_ATOMIC). The difference (apart from the
>> requirement to call it only from the BH) is that it tries to use
>> as many NAPI cache entries for skbs as possible, and allocate new
>> ones only if needed.

[...]

>> +u32 napi_skb_cache_get_bulk(void **skbs, u32 n)
>> +{
>> +	struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
>> +	u32 bulk, total = n;
>> +
>> +	local_lock_nested_bh(&napi_alloc_cache.bh_lock);
>> +
>> +	if (nc->skb_count >= n)
>> +		goto get;
> 
> I (mis?)understood from the commit message this condition should be
> likely, too?!?

It depends, I didn't want to make this unlikely() as will happen
sometimes anyway, while the two unlikely() below can happen only on when
the system is low on memory.

> 
>> +	/* No enough cached skbs. Try refilling the cache first */
>> +	bulk = min(NAPI_SKB_CACHE_SIZE - nc->skb_count, NAPI_SKB_CACHE_BULK);
>> +	nc->skb_count += kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
>> +					       GFP_ATOMIC | __GFP_NOWARN, bulk,
>> +					       &nc->skb_cache[nc->skb_count]);
>> +	if (likely(nc->skb_count >= n))
>> +		goto get;
>> +
>> +	/* Still not enough. Bulk-allocate the missing part directly, zeroed */
>> +	n -= kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
>> +				   GFP_ATOMIC | __GFP_ZERO | __GFP_NOWARN,
>> +				   n - nc->skb_count, &skbs[nc->skb_count]);
> 
> You should probably cap 'n' to NAPI_SKB_CACHE_SIZE. Also what about
> latency spikes when n == 48 (should be the maximum possible with such
> limit) here?

The current users never allocate more than 8 skbs in one bulk. Anyway,
the current approach wants to be a drop-in for
kmem_cache_alloc_bulk(skbuff_cache), which doesn't cap anything.
Not that this last branch allocates to @skbs directly, not to the percpu
NAPI cache.

> 
> /P

Thanks,
Olek

