Return-Path: <bpf+bounces-32097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B8C9076C5
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 17:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A862B22966
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 15:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B5B12E1C7;
	Thu, 13 Jun 2024 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mE3aEMCf"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9174412DDA7;
	Thu, 13 Jun 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292991; cv=fail; b=BXeEvy2osUHD3vA6ittqnn0cBuZjrkQSEpxywtwCcqPN00r1A/K6xTxyey9A5rZQ8E36llrlZO5fwDKGJiVSKDe45VIYZ5B3hbmAS1EnKM19nDoH4yZu3zNKIp+f0q8/3M/0y64jA3e1xknTWqLPgexuWvhCvEEISE8mX80SXnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292991; c=relaxed/simple;
	bh=Wa1jOAHcQwKMWzYmNBZrVgXYE5dfW7YPY9+xfQT6tPY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nv+WIM+bD6WJ0bs6Qw+fCQlM0xlgVAWNSX4xJ5UZotsUePlsIx1yfRQ9AWcur3SQYGTy/pI2dakD84zP9O92e7++/VvAZMD6kTng8+QUOEC7D0hpnoTPHDs0if0unNjCarsXD11n91dFV+tTfYEbwYU7EFrN48Kp/t0AbIbbM7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mE3aEMCf; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718292989; x=1749828989;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Wa1jOAHcQwKMWzYmNBZrVgXYE5dfW7YPY9+xfQT6tPY=;
  b=mE3aEMCf58zGBZLfcYE6P5Tt8Yo2g4zjbF8g8KqipDBda1WaXzO1Rety
   AA/MGxrCZdVKoVgomE+YgVvN9JrwvJggTJLIUWWfa4sf9HbHg3cThTVeX
   kcauMDy8i/hD7oOc6r3iG8iAAx/lwojrU9hFxh1GWQOpYz7KoRFRb1ZUj
   ou6YpqLOzzqdtXWWzgJaLIxCPnSTeQkTgeRFlV4pRKGSz7SA5+8wZ/Huj
   Rc0slr07beq/duzoubi/YWTiS0GgA8+PBIfO8bTAwAq2iUHV7u8knZnuv
   +0vkWa/pAxpXY1Kzof3woSAbd/QyjaYA6EFMN7lP57E9LPy/x8hfQzFr/
   w==;
X-CSE-ConnectionGUID: 5gsKcdjqS62oEvMcsOiYAA==
X-CSE-MsgGUID: Yd2WMgiISCiD/laaJehuyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="14952158"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="14952158"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 08:36:29 -0700
X-CSE-ConnectionGUID: 4ohUBEpPRBeyukdPt+WyIg==
X-CSE-MsgGUID: fVM6Q7PvTi+J/uaURjeZeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="40659975"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 08:36:29 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 08:36:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 08:36:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 08:36:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kN6c5COL79AwZ0BrhWc6XmwitEv4EWnil2aRq7cvEw7M1q0vuxoy8aPkFy9q/Is7ows//fp5KuF4aTh56vnnKjYCT8wAjTHKo58oPwal37XcRjqDVJhLaJy0Rl2bduKa0qDpP+xirvvlvf6Nne8ynQHLOgQBDnkx2YYNde95TyQS2eZ2CqpZg2V+v3VW8YAglNJQO0pnjdb6Shl5XP7I3GRroC8P63zYhpR+ILXU39IQZ01Wwr6UsG3vPcBRQh2fkG/c1xeHimhsHReQhJ+olYjrlvPoaZfkGuwxjeQwYhYFQRC/kbdt/fo4rqJT5tnNFRdSNKa2Rxf8MsqDA/zPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5RyLUBm4pHdvyMJFaD4ikxgg1ErLBCs2w9ApbFyN8A=;
 b=lL9edvrjqxylllm5dCyfEgOfKVvIyEkCZLZ1rwiisFK2WfPfloNMDbfro+WYh1aN2gkWLGtHqSO42xUp0itbKqnPzIRd8XpKGGlUaY0F//G7Gq1iq/zHATbeXF01kMHyKu0c0BMITQdpGgB8WQwr5La+j06itUsGgrzU3hr+i6zkQnKT9JL72IdjoVbeiUNNLiLoBgEPXnDTo1/FceKbZw4b2LYDlBu0w8qqSHv5guTFat8LIF3VXv44fMKy8sSj8PZEHRmKcjy7A00AJu3f4GANVzVYYZPQZbwFEVGzYooZZ3808zjmo0GPG62MP52WfXGPJV2lVDWquvlpa6assw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SA0PR11MB4704.namprd11.prod.outlook.com (2603:10b6:806:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 15:36:25 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%3]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 15:36:25 +0000
Date: Thu, 13 Jun 2024 17:36:16 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, Michal Kubiak <michal.kubiak@intel.com>
Subject: Re: [PATCH iwl-net 0/3] ice: fix synchronization between .ndo_bpf()
 and reset
Message-ID: <ZmsR8F9GFgxgBXfV@lzaremba-mobl.ger.corp.intel.com>
References: <20240610153716.31493-1-larysa.zaremba@intel.com>
 <20240611193837.4ffb2401@kernel.org>
 <ZmlGppe04yuGHvPx@lzaremba-mobl.ger.corp.intel.com>
 <20240612140935.54981c49@kernel.org>
 <ZmqztPo6UDIC6gKx@lzaremba-mobl.ger.corp.intel.com>
 <20240613071343.019e7dca@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240613071343.019e7dca@kernel.org>
X-ClientProxiedBy: VI1PR04CA0132.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::30) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SA0PR11MB4704:EE_
X-MS-Office365-Filtering-Correlation-Id: 262b516d-8e4d-4978-7c71-08dc8bbe95f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jBKZUM+OefX1eYVudVjNhTOb7p1L9L/zjN8h1yVfO4KF0fH6VWu0CZATgkrq?=
 =?us-ascii?Q?zLZaL+h0ljnv+9Al3QwLZ/cqmEfzT5wkcV+2csYDwmecgJ4gS+TBgOhnSmRW?=
 =?us-ascii?Q?fbKXtfSyxj8GljqcK+iv0uxfRM55DHBGc4hh65Pjah6LhbI6O/iPbAAA0Mlw?=
 =?us-ascii?Q?gloXK652Byd90fSJu3rjIurshIW7Mf4sFuK9ZDVQV5P1HUDkzxUFmPqFWo93?=
 =?us-ascii?Q?68Ss/CKLEZHtjtqvLV1uXphk82AybRKxxKPJ4Qr1w5aKkNVNXDlNkomKdwRK?=
 =?us-ascii?Q?fAG/+5bDSRaoj1IjlmXc8VTouOsCIV5UUv080KMqK9GTcCfiBc5+DdmKiojp?=
 =?us-ascii?Q?l136tdqpYi9hUkid3kcBHuNbUzSSCzWQh98WmZnd5YIGlBzBaOV9k3x408jN?=
 =?us-ascii?Q?E/21JP7OezVhUVJpSa8XYbSop91naze6PJLMS0BjTHoSKoJzwUrxEdxy1mAX?=
 =?us-ascii?Q?HZ/BS9cEgtOxGwhvKmCQkrw17Ea9jiH4iGSBYsfrFrtU3EwEArPFku5ohPA5?=
 =?us-ascii?Q?8i9r/fjQdtNQ+oZbwx7fd4au7mlnxE3lxNrG/upklV9YqMwL8M0mpuWvlmS9?=
 =?us-ascii?Q?IiDBpNV9CaalKxI6mDFEDzZP8fm1CO4sAWytOw2DXAxH8zx2vMB5uuxeWi4F?=
 =?us-ascii?Q?DF9H+bHPMSQsc7iGPgnbMUPUhfZMxNxZX4CAb+So9uxyPbRsAbYJcrrdBqT0?=
 =?us-ascii?Q?rnKS4pGrlDCRh3Wgktto1Ru1KAKqK32DPWjoXFLecjseoPLqRlISr0xf1Qv3?=
 =?us-ascii?Q?DQzK3MuJA0m69IWJJJU8rhZUPcZ/EJpM/u3RqqC4hUDS4lLS2LZNUOierzU/?=
 =?us-ascii?Q?9UbxP0VbGkfAfHYbN9Vb112AabcAUsFIbWclrTUJENTDkaX932k6un4YINmC?=
 =?us-ascii?Q?z8lUGPSF0cEYFAxt+kZaXQzoQwX8MMPUHAO2Clokw5EjrSgiB473aMcbWWJE?=
 =?us-ascii?Q?KNW7/Cz8zSe6XmCBeiZxC/tyt1kTXc5OJnn1zLg6HmcnvhJP4fCH4864udiZ?=
 =?us-ascii?Q?did2vWLVwuN8fA95Q7f+PyGVojufCxPwyeIRGKcZCej3/pKLDMFXObiEeiRS?=
 =?us-ascii?Q?nTt59GM69SsmgP+ErkPCPxIR4fzDWLEkDP7EkodS9lw1BxEITrWzc88kwXv1?=
 =?us-ascii?Q?5pLrg1jUdxx0Coqhh4ETl/hDEBobEbCOHTFdP7muwwJ/RSmVFGRYMachHclE?=
 =?us-ascii?Q?g+jmg0xhckQu0kbbgHl812qIQ2VwWZRJcIvMp/5s8oUQqFHVNYp0XZKa3fOU?=
 =?us-ascii?Q?6uUsRaduYGskbIom6tIBd1EeVQK/WC4BKWgXRP2VMYUcx2Mmxoou+wt+GLQ1?=
 =?us-ascii?Q?El+9ryEW+/pdmoCqzT6BKylE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eyfcm9ViYICJwCXqe3UHmmkgwbqi78s0MUEmS015D/lQDen7IISy+FYRjk5+?=
 =?us-ascii?Q?5S5Fa4VPAs37DzVsuvk+OeeztigIRi1w/sh1el1pW287pb0y88NFpIvxOLJO?=
 =?us-ascii?Q?UptOzo45jAxciyWrq35uQ2gc9H4dwMvpZFrzHtG5ibcAMuyhPGljrmMzPu5R?=
 =?us-ascii?Q?5Il8X7EJz/vCNbeIhi+kcaUYhe/RVZEmm01cUe3q/dc/IeWlMZpXavuby2Vm?=
 =?us-ascii?Q?cuQ75oOB5S0WI7mLoLw+5g3/5Zzp6wtkV2e9J7Q6vVhNk51OreZX01zHvkul?=
 =?us-ascii?Q?O9449Fq6QjFoId0lmwoXkD45vL7xKSUqj7jP87nLUpWZPp65mGtJaFtW+RRm?=
 =?us-ascii?Q?CMixqRggVl35nuhWxzschJ6depzZomvK7LCYkvhvyPREXOuP2f1/wzd8J2xz?=
 =?us-ascii?Q?eSiRvQRYwasPA/VZYb0vEidqq+T4zHa1c9/j87mSvls31EVLTIJRelClYLR1?=
 =?us-ascii?Q?uIb5y4DB4d3oYVr7uzgYbDnn8ptZgalCcsPWmyS5arH32+hdfo/kY27bKGHB?=
 =?us-ascii?Q?gbssqZByNrnATQ5Vq7X3ZJuJbjN/4ATflbo4jn4n24sySKgTl1NYyA6wBosp?=
 =?us-ascii?Q?mYtV7RVJP4Y160AUd5efGpgTPoU+zrWxfSC6uJKrbbhNcuXdRfaTJacUiGMF?=
 =?us-ascii?Q?wJVW3/8oFuNr2fjuvUflA9joPuF+0TAOG52OMG13S2RsUdGU36kwj8HvjRZR?=
 =?us-ascii?Q?D4hXwVzKmhy3kZhdQ1EENWhQGYEbqEfUHP+4fXO1mYobiriMyFi55N2EgcCS?=
 =?us-ascii?Q?6xFwEU0R25Hhqh4cs/2scpcP0Ch4mUAH5+1IjWU3DvLW948J5+ZWQWJIccw6?=
 =?us-ascii?Q?lgdo4ZVOxhx6Ou7ewkouY42F+PLK33NHztY8l/Hr9QuiK6ZbagnWPPvYYW6Y?=
 =?us-ascii?Q?AeoxT/ejIv/IjHdFOmvDUIZU7zZLDkrGfRWcewYeQAJIhhi09ZQcvun8m1YV?=
 =?us-ascii?Q?pqA+gWC5ATXfgqnjMtxHbrYJXvzBte3626HOuKKjUMOMsQO3Jcrxvc6D39PF?=
 =?us-ascii?Q?dlmsKvrfIxoxuQlM5axgKOV3g7BqQ0/NhPpM6f1XEMofp4M0QHEGhuMha2NX?=
 =?us-ascii?Q?Cz744pTGVzjrAzhIM/sO5BEe/P160qXz5n5aKooA+qCBcGUfOMrCt1NxwnI0?=
 =?us-ascii?Q?f0cp6AVAO0DvhAIoUypKoLCa0kpOqgczqLqKC0x2sGeYEmCobMHAUUrVrw1Y?=
 =?us-ascii?Q?Ckc3jFj7lwLqAUq87nkINHMA43k+6pQe9iFqXTcDe/4gmLYDijrXRMB00Chq?=
 =?us-ascii?Q?YrayZamw/xp1ttuEzuPNtnwxAa+AvsbrA9DcD6GXLHVcxECmb3eONTrBXOCV?=
 =?us-ascii?Q?QwI3Jl7F465CCrp8BNP+gxQNdk/q6VBLAZsqvy05lhYHHRUHeO2kXm7q1tEE?=
 =?us-ascii?Q?3QoMBLauxCntiNtoUDdhx5aNl8ln3pzpKgjdsT9AMibuEk8pIqnRzyArnqgC?=
 =?us-ascii?Q?RxtNqSdVn6T+XtBrBJZRAmCscVFpBXQZru1AXgsvYm1pmrXgFR5ER/zmcpU1?=
 =?us-ascii?Q?MBm10Z/mwIeM8dyW/eurgwFU63NXbGETjKEmJ2CysK/PE9YqsQ0IERL2SQRZ?=
 =?us-ascii?Q?9kshLagF0NT1uq2SCrhEIRN9IChy+Lfip+9HDUQGTbyeOsGe2qG52hm491gV?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 262b516d-8e4d-4978-7c71-08dc8bbe95f0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 15:36:25.7235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoBxkWFm8eUdNYVGQwIUAVgzqprQbX3CxRxXZaEp48z6axxj8ExIXj9Ne8qWtYiKTPooG15Qtauwl/t6bVMW2N8XQBc+Aplaz4aRLANCdOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4704
X-OriginatorOrg: intel.com

On Thu, Jun 13, 2024 at 07:13:43AM -0700, Jakub Kicinski wrote:
> On Thu, 13 Jun 2024 10:54:12 +0200 Larysa Zaremba wrote:
> > > > The locking mechanisms I use here do not look pretty, but if I am not missing 
> > > > anything, the synchronization they provide must be robust.  
> > > 
> > > Robust as in they may be correct here, but you lose lockdep and all
> > > other infra normal mutex would give you.
> > 
> > I know, but __netif_queue_set_napi() requires rtnl_lock() inside the potential 
> > critical section and creates a deadlock this way. However, after reading 
> > patches that introduce this function, I think it is called too early in the
> > configuration. Seems like it should be called somewhere right after 
> > netif_set_real_num_rx/_tx_queues(), much later in the configuration where we 
> > already hold the rtnl_lock(). In such way, ice_vsi_rebuild() could be protected 
> > with an internal mutex. WDYT?
> 
> On a quick look I think that may work. For setting the NAPI it makes
> sense - netif_set_real_num_rx/_tx_queues() and netif_queue_set_napi()
> both inform netdev about the queue config, so its logical to keep them
> together. I was worried there may be an inconveniently placed
> netif_queue_set_napi() call which is clearing the NAPI pointer.
> But I don't see one.
>

Ok, will do this in v2. Thanks for the discussion.
 
> > > > A prettier way of protecting the same critical sections would be replacing 
> > > > ICE_CFG_BUSY around ice_vsi_rebuild() with rtnl_lock(), this would eliminate 
> > > > locking code from .ndo_bpf() altogether, ice_rebuild_pending() logic will have 
> > > > to stay.
> > > > 
> > > > At some point I have decided to avoid using rtnl_lock(), if I do not have to. I 
> > > > think this is a goal worth pursuing?  
> > > 
> > > Is the reset for failure recovery, rather than reconfiguration? 
> > > If so netif_device_detach() is generally the best way of avoiding
> > > getting called (I think I mentioned it to someone @intal recently).  
> > 
> > AFAIK, netif_device_detach() does not affect .ndo_bpf() calls. We were trying 
> > such approach with idpf and it does work for ethtool, but not for XDP.
> 
> I reckon that's an unintentional omission. In theory XDP is "pure
> software" but if the device is running driver will likely have to
> touch HW to reconfigure. So, if you're willing, do send a ndo_bpf 
> patch to add a detached check.

This does not seem that simple. In cases of program/pool detachment, 
.ndo_bpf() does not accept 'no' as an answer, so there is no easy existing way 
of handling !netif_device_present() either. And we have to notify the driver 
that pool/program is no longer needed no matter what. So what is left is somehow 
postpone pool/prog removal to after the netdev gets attached again.

