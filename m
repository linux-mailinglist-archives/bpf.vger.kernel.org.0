Return-Path: <bpf+bounces-37940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F56E95CB48
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 13:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48A61F23B42
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 11:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A5E18754E;
	Fri, 23 Aug 2024 11:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z13DDzC1"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88224F88C;
	Fri, 23 Aug 2024 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412133; cv=fail; b=WaeuzkYhyCUZo7jD33B+Y6SmJt8JlNaRb7q8opuCd00a54jnu5Q73e/nBkcHlD9BjsT1B6kgzbQoSMPLpZvwo6kNWD35nwa4HoAemOa9GbTqCFMrxc51TwELGUASeGn4d64xunU+XM39hiC2JO4V4Dd9Dw0i6VqjKfUqyhvL4k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412133; c=relaxed/simple;
	bh=gzg8DkOqa+UVFSTAPuOvTBR18DFRl/g8LPGt4taruzM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hE6FLHsVlAJJ8ETcOl25/dOOOE18AXPr/0X/RTw81Z2q234z7d5GSLsRzkLZ/FdS1rs+OIq8wf5vgQOcNyFAFxAkfY73fJ+Xi65fnMAfAKA75meta7h6IPJXf6UZIBvB/sjHIIvKxI/lzDRTi+PgXuECsQoIeZalQLmKa4dONvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z13DDzC1; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724412133; x=1755948133;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gzg8DkOqa+UVFSTAPuOvTBR18DFRl/g8LPGt4taruzM=;
  b=Z13DDzC1OJvHgpmjgQcmB/VyWTdgaHa8xAS0P2iwtEkcL4vIxlEdEXnI
   /sraY/GQ7uzugeLn3P8sOZ1wzF8u/+IYteAPyT334xQRU3V31d/nY4hu2
   QZl0z5mKkGS7kJyrmCNMYsyNSSlXFSVjwxLo6CKVOq6GflARf7Kshqp/q
   +PBsNI403Pt02rW+rJM337RYz4XWxF456YN+tKbRFDs/aj9RSZvSOl4Wj
   PupQmoYFknfG0a+sYUC1CEzFCchSF+GqqErcs9dOiGGahYx+8gS7bCUlW
   vuGMLFhD9/mAAD95Kgco/24m1Jeol1roA2sHDrYImjLa3ASgRXs/mD3Xw
   g==;
X-CSE-ConnectionGUID: DXK3XFNNQiW0i7R2rpcLxA==
X-CSE-MsgGUID: /lTYkbXiRGie4g7jBRuzsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="23028839"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="23028839"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 04:22:12 -0700
X-CSE-ConnectionGUID: e1VQ1tF0RK6ZN8iWjxLCyQ==
X-CSE-MsgGUID: IRbOaDw6T/WsZ6peqvFIig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="84956127"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 04:22:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 04:22:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 04:22:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 04:22:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCyXVyqCoCcj71zrEzr3VeJk/dtSAHYg/CpaxwH/Uvd0Xu2D4TpSgdVqdQ26mBOQEYqtzWpTN15L51UbvLf1YCeq4si+O0av5DvglwuDoaN8SdGjeC00pxfMT+pOAKsuLm2EEZB7Phqtl3oL9eQVeoaTK0Vt177MTjHqJ7NbO76P5xU0eh6VlZJKbsqF3Ct5BDNEidP/bK/rdk0ZW2GXTGP2xSST6GA6dPwUZ2QePHCKFPVAlj2meZxMAfv4ttG3ipWrOpp3m1P30e1ENF8mtjoOqjugV2EuvtqC4+4eJtHcLkJpHx0SMy9eTddVflpp3XvFXeVDphwkmW+yH0ubtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByMYRL1qGEQZ1UBa8vEb602xT/64D21TcJxEJHJ0D8M=;
 b=ZL4BvQESh+fohTyz7cfdIY+npc6TJ6DNpnNj4JMqhYsRUDNJBW3obyzrbikt9Zaw/ZoSwhhxvmuZi2HzqcNZapRcrD7FSe+j9WRDBhtqdJ8uFNdqg4TLm59b5R+GSWHSYnAdHMaTKAUYnma8dV0gvzaBSWC921oXDWe+SWWHt6jYqN6j8phkXMDjijNPAlbFVrhp9wv3wHE16naifZKkDbkRyjO2IClLbHQgC5H4D/tlc2/i/MtUsXOlbcUgmCf9kpCkLIpkhueuRsanxHgn4PFGleyByL0q6VEl5CAB2SlWJ106ecBzlJDuU//kl3ih20gskBtIU5Rjlpd4H08zLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY8PR11MB7035.namprd11.prod.outlook.com (2603:10b6:930:51::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.18; Fri, 23 Aug 2024 11:22:07 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 11:22:07 +0000
Date: Fri, 23 Aug 2024 13:21:59 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Jacob
 Keller" <jacob.e.keller@intel.com>, Eric Dumazet <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, Amritha Nambiar
	<amritha.nambiar@intel.com>, <przemyslaw.kitszel@intel.com>,
	<anirudh.venkataramanan@intel.com>, <sridhar.samudrala@intel.com>, "Chandan
 Kumar Rout" <chandanx.rout@intel.com>
Subject: Re: [PATCH iwl-net v4 4/6] ice: check ICE_VSI_DOWN under rtnl_lock
 when preparing for reset
Message-ID: <Zshw1yW2mjEKk3aO@boxer>
References: <20240823095933.17922-1-larysa.zaremba@intel.com>
 <20240823095933.17922-5-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240823095933.17922-5-larysa.zaremba@intel.com>
X-ClientProxiedBy: ZR0P278CA0145.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY8PR11MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ec3382-5a48-4491-f71d-08dcc365d283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AFFuYeDLBffDLZE0OZxLO5iBI+NjASCZeHfwDJhq7E5cdm0qWR8v+FZVuBtu?=
 =?us-ascii?Q?dCNcSKCvByvB0aKw4ube0n8RamrzJlB+c/+NihUEIN6BWejrrCsFU/O4nOYm?=
 =?us-ascii?Q?vm92/lWLQ1RBFrqtP0t9Q2q5l/w5LSvN5wKFG/mqU6tKiGSAP/sRt3U22DqX?=
 =?us-ascii?Q?KrYU5LK3Tz00lJntwaeDeAcYIzKm+Iwc3OKi+egUq58tQho3TiLN+eK+vQ4G?=
 =?us-ascii?Q?RXIzJDtG3TtCSz6znGEZ0HG8A6bn33Qo6DKUFGWKSrK9co4ZSv3n69tG92Xu?=
 =?us-ascii?Q?t9quxJ5sGO30VvmEFVi9Xw9Efw89EUNGvNYqp9GPHoPGyRYTKSA/xwB0pUdk?=
 =?us-ascii?Q?ktU1KVf6P30nc44zz1W1DX4OqO53oXSmUXIMRAgL/QRnc6DXuEAnQ8yRw1wL?=
 =?us-ascii?Q?5dAsNpkQY0UukB5vH3KH5dkE5zw+JfAIQW70fgY0hLp3nMySQ4PrRq9EwB51?=
 =?us-ascii?Q?fBcr02MvIlwcNUj2qyc4rnb6PCJvHCQDgUC+K6oHnzgsqOeLSzrwXP6G52rt?=
 =?us-ascii?Q?mXRTz9XZAIxUna3zHzgtEhX4pNfj1Kita7tFaB2Bj/LvgEe3PuNmwxuAzrwJ?=
 =?us-ascii?Q?orkKTcJgW2dzPjeaoXYyvqeZyLUo+jvD4X+AaQW8J+ddUGxw161ySg6IQCBh?=
 =?us-ascii?Q?EJVnwaJoqay96r7aaV4wCx7y/PvqIPK5eu7qRYycgEH/eWJG47oMyoNommM/?=
 =?us-ascii?Q?lRsQWT+sE5o8KV74fdXtGsa+5InWidYD3f96W76QJZiwAStq09QaS3keGDlH?=
 =?us-ascii?Q?Vhe5tuJJrEuPlSd7xVsxKtwNYxdSytSIc58+4uUpL9ww1n83IkiXozgVntud?=
 =?us-ascii?Q?Yo8rW/+U8ALvfz0AH4VbuSXFSsoE8PENZNe594qnNYxGkraWuG8FKQZS1Xnr?=
 =?us-ascii?Q?QX9FvHn2bwt0VFz+9sGH8COOtGd8qcVy+DJ0ETC/efWRtm5cM4bFvpOrNTP7?=
 =?us-ascii?Q?YoGYOmBHFq5DPVrfvjzh+ODFz8B7v498TtHnpOs4ygLwbVlLfVXbstfwDhkI?=
 =?us-ascii?Q?O1YiM+VkOfdsUuXpei17uV3iiKq5jp3LomVxFbL694E5PYDFkQtdaOOXfimM?=
 =?us-ascii?Q?9+VW5Htn5uu7J3sy4BAbfh5Ar9dxAQcAkcp6FqHSpC0dAiKKS+czI/J1DAuj?=
 =?us-ascii?Q?BBUPQgfUHm/XU0UPEuJG8Tiu2914beWXfbcFh3jfOoYF4yrqPwrG6S+KQB8X?=
 =?us-ascii?Q?tXfd8FqrHUahgk1QM0B5dWM2/+D0pXAe1WfJLYXoxhV+bgJzS2YpTN9ncN02?=
 =?us-ascii?Q?dQmo6yUvR4LjbzwIs0dZQ2g3Z+qxUTf9NXywvswe8TUJ2gTiKgcZ45N9qt5O?=
 =?us-ascii?Q?RZy+N8tTn58MWUjgcZLy9zm7koFZcSXQJnZiSGgKxN/6IA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o1tTc7nYR48wpS/Ng4BNcISI70oEVy5FXXT0iuk7YOkUImzgQBGwCok8XUXh?=
 =?us-ascii?Q?8d5CyxnpNBzt9rQUBlHapfSnriU2KxPAgrYdnYTNBMCLEDQJmdTgYzd842Q4?=
 =?us-ascii?Q?f0yo4JJMEKzcBoU6P7M/081kRGupYUexeaXsaY0M2tXEzsHumH+LXpK421yA?=
 =?us-ascii?Q?PT/qbWHhMAkUZbOnKaxXeL0RGHat7TSv40RHIVvwVYW8tUnlYxoOB2WV1rKk?=
 =?us-ascii?Q?jkyKg7utqHgWPjfhu8s604jZL2D/McLrP52lUEo7V4YQyFPqtKD3/XUk8D8f?=
 =?us-ascii?Q?3UGc7N/pUto25FI2Ng4hfVjGLEJnu/sUiwYIuLhDZ/b/sh1tMeg1ubo/pDNw?=
 =?us-ascii?Q?ZOPdDDc+4F4i3RzvcvEgUT6CTEcghB5Z/4yaYblwbnBeiToOojdleY/w5oUV?=
 =?us-ascii?Q?ZgdleleYSie0doJTvFB3XPod9JNTUV1WbOJNOVM2oLb7NGEFa7f0blWPzTGi?=
 =?us-ascii?Q?vpiDc4L4xaYOTonEJDGuJ/e0jUjmfk5887KZb1aAj5bM9i029yhGHdRqcJcF?=
 =?us-ascii?Q?h2XL4AmpZQ5GdzZjrGIeTZVtr+Z5qA0WGpQ7F6FNK0EwyTcsbEKO9Pw0u3X4?=
 =?us-ascii?Q?vK+a1Yxx6fRij/N0dLuzoupRK6sKc5o8urAceJX+vQfBNR83/LofGrjYBjKP?=
 =?us-ascii?Q?rrZLot94zVm5oaW18v6U7aXGwjag3Q/XRoflPtKPUaJzDt8JSqFMElTyCxvA?=
 =?us-ascii?Q?s3dN0zrnsM3zYr8ghaok0oxqDE4VkaPtvwNAVlHehkk+LPm+JOQ2UaNWQ48J?=
 =?us-ascii?Q?S/GGQN6YpY4I3TJ0hcxFKy562gZvKnD6umfwTIDa60NBLoqE/Xiot7/ihpUI?=
 =?us-ascii?Q?WuenTgLxK2M+MWy0PKnPoVkgoJM5xVPVsbMkJErMCskDi7/Q4U06qM6qFbXu?=
 =?us-ascii?Q?0c/U7aHsfOrIMWry4J+JnVTlXcjciG8OHCx/u8OC5UlRfmBZ+A/+7jF70py1?=
 =?us-ascii?Q?TCLV43oOOrDkFlGJlyNR8tnhHMaJBXa5wu0WNznc4X2GWjwnvfsvFjyxbxNk?=
 =?us-ascii?Q?G9/gFen7uICp9WawmUWvMww6qXxaJy9arFhhlZR2BFJh5+P5syYMyt/7F1AL?=
 =?us-ascii?Q?6IY93ycmF/UyjkJsRo6Om8A8ODRdxIxscUrm9Qk3pou+wMX9vFafBgyO8vl9?=
 =?us-ascii?Q?C/jGyKUjk6DMcoOz/kc7hTc0gKAh4GOVvn4Tmb371LiCEz9U7vISrh6kDZ1A?=
 =?us-ascii?Q?VsYqgvLY8cP3NUZlqYub/qgcxgnn8Qi+8Rf9bqC0R3ud4luFmX8Mly4h0f7p?=
 =?us-ascii?Q?KdUg7E85cuSFg6h9znBblqM9TPLrWCj/qY7QTaYFmn0ouuyKoj+nwU2AkHHz?=
 =?us-ascii?Q?JM89uDZmGlG71CEb+FBCR4qjkjmw3tIc+Qk5Jj7Q/o9utIUwjkI+VQEE/il7?=
 =?us-ascii?Q?0ZafunCh/i9Lk2GvekM+njiIc0m1m5TAEyWaENrVMDMFyeaku459DXJh8FpR?=
 =?us-ascii?Q?dRexPmF8UuFU24kZl0Cw6jlmE7Bv3Qvci19guwIy1bOVT67fLYME21O8guTG?=
 =?us-ascii?Q?2WMg2hpw6CdV/R2+gTLUcklwJszJ6Vbm22iPL4SMueDUoBrMfW3JhWgkioYP?=
 =?us-ascii?Q?5dyW84oagNj0xzwDC8I6CaMsm7LbJb2ISoSh9qfYZGpaqfGHcxyKQ+/YLgm1?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ec3382-5a48-4491-f71d-08dcc365d283
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 11:22:07.2038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4lCug8UN4l4LFwwccAyO3iErJcsd9sH2dcc48stfAO1iprZ2qlmDASXPJ7ZyQgaKmY7kkE01LvDIuujnNQirLmMPAuDbiyknUiJC62+0BE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7035
X-OriginatorOrg: intel.com

On Fri, Aug 23, 2024 at 11:59:29AM +0200, Larysa Zaremba wrote:
> Consider the following scenario:
> 
> .ndo_bpf()		| ice_prepare_for_reset()		|
> ________________________|_______________________________________|
> rtnl_lock()		|					|
> ice_down()		|					|
> 			| test_bit(ICE_VSI_DOWN) - true		|
> 			| ice_dis_vsi() returns			|
> ice_up()		|					|
> 			| proceeds to rebuild a running VSI	|
> 
> .ndo_bpf() is not the only rtnl-locked callback that toggles the interface
> to apply new configuration. Another example is .set_channels().
> 
> To avoid the race condition above, act only after reading ICE_VSI_DOWN
> under rtnl_lock.
> 
> Fixes: 0f9d5027a749 ("ice: Refactor VSI allocation, deletion and rebuild flow")
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 14257e036d4b..2405e5ed9128 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2665,8 +2665,7 @@ int ice_ena_vsi(struct ice_vsi *vsi, bool locked)
>   */
>  void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
>  {
> -	if (test_bit(ICE_VSI_DOWN, vsi->state))
> -		return;
> +	bool already_down = test_bit(ICE_VSI_DOWN, vsi->state);
>  
>  	set_bit(ICE_VSI_NEEDS_RESTART, vsi->state);
>  
> @@ -2674,15 +2673,16 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
>  		if (netif_running(vsi->netdev)) {
>  			if (!locked)
>  				rtnl_lock();
> -
> -			ice_vsi_close(vsi);
> +			already_down = test_bit(ICE_VSI_DOWN, vsi->state);
> +			if (!already_down)
> +				ice_vsi_close(vsi);
>  
>  			if (!locked)
>  				rtnl_unlock();
> -		} else {
> +		} else if (!already_down) {
>  			ice_vsi_close(vsi);
>  		}
> -	} else if (vsi->type == ICE_VSI_CTRL) {
> +	} else if (vsi->type == ICE_VSI_CTRL && !already_down) {
>  		ice_vsi_close(vsi);
>  	}
>  }
> -- 
> 2.43.0
> 

