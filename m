Return-Path: <bpf+bounces-48920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8814FA11F28
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 11:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFF9188D729
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 10:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7306823F273;
	Wed, 15 Jan 2025 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2vC8cum"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067321E7C16;
	Wed, 15 Jan 2025 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736936590; cv=fail; b=hICn92b+1FJU9Qk3i8aWSWGLtoN+Bm9wBAc6LklNHZ8B9tvGGfaUJiPNJpa+xwnuMiQp5I2UJLHygimBz7SXS+IV0ag5YBt0PPngCivOqeabVOO1tFhWT7+nriNst7CgQE0dz/6J1T/dpO4qEk3VmDfhvCYx/6yrTTcqvEnBr8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736936590; c=relaxed/simple;
	bh=gPTQS2vMepSoMGNJa2mGHyAqm5yfhC4t7BQS3Y7GBVU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mbXvkQ0fxMMBbuAUz2QkbuBvO4yzpzL5xT5R4A8AiywEcws4Gf0mgMJOAw5rMjjngVARQ0IJlCnnRhh1kgDx57TdVQqwPCBbrM6xGBDdOO7hH9Bb200aOx96YW2am3iqHkKyMzfIm/Gls99SdXqAPxoXxBiQojcQd/qRlJIOjfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2vC8cum; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736936588; x=1768472588;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gPTQS2vMepSoMGNJa2mGHyAqm5yfhC4t7BQS3Y7GBVU=;
  b=c2vC8cumW4Esz8qVFDRLjIevnrj9AYMYW8l+b4VwGUqeH5G5DH94tSim
   BohSybT4lhrEzbkFzornYRLB8c0Ar5xQsAkFCZVWjKYtUx9Nf8eN03SzB
   wBZWouSdMS9V9vpvfxWBKn3lF0vQgF+Fw7PQPW5CRAb5vVTUrYqfpxhfq
   eL5SoBTxeAfEfkBw4IV7mYfLQp6auEUo/km2AMpyFnSzUQCcCnGol9hM+
   GG9gS2eSlEAjFNhpej1R77cSAyqJbjCQ2kifAI0xOfrda7Lvqd6ZOov6u
   0fI4YHlYCGwpXscp2Cp8uZps10S8UEtoTay4rrPsZtc5z+THdIseSe6UM
   w==;
X-CSE-ConnectionGUID: k/yT4rmZROS6yG0Lq7rXtQ==
X-CSE-MsgGUID: BI5u47XSTWGC5FZxwvfJtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37145606"
X-IronPort-AV: E=Sophos;i="6.12,317,1728975600"; 
   d="scan'208";a="37145606"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 02:23:07 -0800
X-CSE-ConnectionGUID: z8HyvculRrmOljglyWehZg==
X-CSE-MsgGUID: ojfT3y4oS7itynpGG1y5rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="135949742"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2025 02:23:05 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 15 Jan 2025 02:23:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 15 Jan 2025 02:23:05 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 15 Jan 2025 02:23:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCZJGVF/s+sExz9tjcp3m5hfw15zSpV3xcrz3OX54IComSyUPurgrGbc/oJHc5DuDs/kyLsgW21lnU2t7JrJCN5xNXkd3dLDxg1OeYCMYu5GDLAkUqSab8/7Jg04YZ5jZhfRwjLOU8HRG5MPmDjhUYjRE77KOUHIHs6r4jAEHjDbvzy9yrxUnlbIBw+tiLfa/vDiACQTnzh8SU7Qj9AoL5zgi4Um8XZVKeiwVYiAjFl2G3I8WZayOdGAUdlGqNFkBQbhPE7zAiFAykduv2TENg0ymQK6dK1TiH8Egdirf70JEaUoT6WXraYDwTdvgbi1g3N3jDiD5esz9ESg/BrCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mO+osTKgmskUAsSblX2nMYXY8Hk3fwjgpO3vILgE4Dw=;
 b=uA9jIlJUnukkMetPn+S67/nqpwpTI/1lsKRY3diorXYun4gJNJpcZEnbFKbW25R/HDAESrXIlv/ofyKohIlW+QyFagfqJyuiJK6trUkQCdMYZoQ3UWRhx4CLBEnGw7zB2XiZjdz25o6VdERMoJra2p+xt/3lUpl0t2bw/3mIDUtWn5gRU6rmw1ObP0hxALeU3O3cqwGbi9vfgSBcp9gBB0sb0Tw9x8vj26CdWuvtW4yT+C0t8y2VhbCiDj90qyZOkJYcOs1tM4Ymx+iOMFEj5hdc3h834O+dXn6+67b77RyDsBPnLMCJrQNvi8F5vK3yfJq+Np1knggSB1IBIJzm/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA0PR11MB8301.namprd11.prod.outlook.com (2603:10b6:208:48d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 10:23:03 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 10:23:02 +0000
Message-ID: <e3412f04-c0dd-409e-88b2-16766d361859@intel.com>
Date: Wed, 15 Jan 2025 11:22:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] nfp: bpf: prevent integer overflow in
 nfp_bpf_event_output()
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Jakub Kicinski <kuba@kernel.org>, Louis Peens <louis.peens@corigine.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Quentin
 Monnet" <qmo@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	<bpf@vger.kernel.org>, <oss-drivers@corigine.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <6074805b-e78d-4b8a-bf05-e929b5377c28@stanley.mountain>
 <1ba87a40-5851-4877-a539-e065c3a8a433@intel.com>
 <Z4ZAMCRQW8iiYXAb@stanley.mountain>
 <ae4d008f-8a70-4c0d-a5c8-c480cad53cf5@intel.com>
 <487897df-7a82-4c36-8dcf-13d1704f479d@stanley.mountain>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <487897df-7a82-4c36-8dcf-13d1704f479d@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA0PR11MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 661fbc46-0ab8-413a-b1c2-08dd354e9753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXJtWnVWcHN5Um5obEwzU1dzNnB1QUZSSGhscktIVWVXVS9BSStjbVIrSGgy?=
 =?utf-8?B?cHB3TDhGSTllZDNRb3JlelBEci8wT0V2N2RqbXdXUmpOdGZVNkpJSW9GYTMw?=
 =?utf-8?B?QzBnenRSdE1RUkVVckFMajhVekwrL21MNDNKSUZXVkFob24wUW9aa3NjaTdx?=
 =?utf-8?B?VitkbG83RGJvSkJtWFMvNlZiR3gxUTI4UllrZ05LTmgzYTI4UWJrV0k3S0RG?=
 =?utf-8?B?ZlpkT01pNzhSR3V6aUx0T2FySzhDYTh2cHdYWmJDTEpoemZ4dmNrKzd1QTVq?=
 =?utf-8?B?YXJ2bmdlQ1p4YllNaGtXMTc2TkdlTmlXdGpzdEU0QW9mWWFkU3RjbTJUYUpL?=
 =?utf-8?B?ZVMxaVdXT2VUQWc0KzBnRlZ3RUM3SFUvcnFhR3o4djh5THFCYkxmaTVwRWww?=
 =?utf-8?B?SThFZWw1RUxua1lmK1IvcEs5UXh0WFhjeXFKcEU5MEQxYTFZOXdtVWFTQkRO?=
 =?utf-8?B?SXoyZmxKbUxDb0JtMWpCZnVNWkFnOXlCNzIrM21RYnpzZlJyc3F0aHA0c3FV?=
 =?utf-8?B?bFdFd01JZ096K1hYRFFEdGpzWE1VSThFZjNuZGlHdzFuRzRMN1NvaEZ5UnNB?=
 =?utf-8?B?UFh2L3pKa3pvMklvdmQvUHlHN3RVUDc2L0p4aS9Ba1g5MnZXOHczcWJNem8z?=
 =?utf-8?B?TmlmZkZYZkhCNGtXZkR6dTU4cXVldjBZMnkwOXRUYkwvVzhRdWpzaFlEejB6?=
 =?utf-8?B?RDZTUW1MYUZTdmZJeEJmOHFJSlU2bGxQbVBodUdmNElqdlFIQjFSRVpQY3Fs?=
 =?utf-8?B?VU1ubno2dExGc0ZsQitOaHZrRXIyQUN6ZGIvTGYyejB5QmZ2ZSsvVmpUbm5L?=
 =?utf-8?B?by9UZGNTeG53NzU3dkh0MEg4RFBDbGNHd0c5WTBPcFJnckkrWFFBQ29LQ1hn?=
 =?utf-8?B?ZDhMcUtLeE1sWmVBQmFMcDFBRzJKWXRKRzFFT29CdzNVSlhiMURCM2JFSFcw?=
 =?utf-8?B?THcza002eTlGWkNmS2RtRU5na1JJL0poeXU0bFJ4NHFPazVYMU9zSWRvZVcr?=
 =?utf-8?B?aXdib2hxcTlFZzFhZmdJZzd6VTBMWmg4WEtYMUVYR084TDU3MEdyMEl0ZkRr?=
 =?utf-8?B?TW1jWTdyQWRqQ3k5YnVpazd3aVVRK0l5RzVKL1JpaTdOTVcva202bk95b3Q0?=
 =?utf-8?B?bmo2aVo4SkNCajNudVgwWlRsZzRpOVB5bFdRMWtSZDExazFvVU1ib3g1aG81?=
 =?utf-8?B?RE5EUE9BTjh5bnZ3dmxheUdIejUyYTAvV1YvaGcrQ3orUU5WOWVMbnNOalhh?=
 =?utf-8?B?Z21jSjZ1L2RBZkJsMGw0ajMwV2JFZ21aeEJ5Z1BwQTNLeDdzTUZXd3hGYVRj?=
 =?utf-8?B?UXEvYXM3ZTdTWUk5U2dQdWQySVkraitQK1YrZ2NLWWl4dWZqWnFxNW1sZnIy?=
 =?utf-8?B?ZWx1c3FHSnNIWFIxcnAzWkpvYXk3blRwZWhvWFJJdkNXMTFmT0Rxek1xZUJX?=
 =?utf-8?B?dWgrdWNIY1grc0tDNVBhNThPa3ZDSE11NXdDSWJWS2pUazRxUURWY3hiWGVU?=
 =?utf-8?B?Q2QyTUgzUGRPTWk4alFzTEZqT0ErNFRWa0V5aU9mZ3lHTHFPQkRhS1kwbnE1?=
 =?utf-8?B?bmZoa3dtSHZ5bEZydDQ3STJnV1NjUHZYVTlpUHp3T1pBWFl4UDJVa0g0WSsr?=
 =?utf-8?B?QVFrR2JwMWY3cCt4b045S1dibWJ6K2tQN1RMd3Zlek9ZVk1KM1gwcFowQ3FT?=
 =?utf-8?B?QmdoNm02SzZXMGo4K0dCWmZXT3QydTJkOWo1NkJQUnpNL0RDNzMvclVYM2c1?=
 =?utf-8?B?Nm83V2lsTnFQeWY0MVM5Vmx1ZkZlbk5DNG03R2Q1cFNOZE9KdFBzbXI0Nk5R?=
 =?utf-8?B?TXQvemt0SURTWlNEdE01MU1QeTNGRTI4UTVlNlV0ZWJMWW8yN0NjQmh5Qk41?=
 =?utf-8?Q?e0scl3B+akXlM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEpYWGpPeVoyUzBhb0hqNzVUdkJRRVQvYzQ2d1VuTnBxWEV4dDljdE9lNE9H?=
 =?utf-8?B?TzZtRWtKbWhoZmw0eC9rUW1DWDg3TjM5VDVDOVlPanlpRmpqOXJ5a1IzUlgw?=
 =?utf-8?B?Nnp4dDdnOHo4LzBiaktzQm1KODM5V2NMQzBvbEs2aU41Yi8xSnBhWmdoSGt0?=
 =?utf-8?B?ZzlDTjB5ZUxPWFRLMzNEdkRrVy91U3ZCVXQ2SkpjYzhjc3hMQ04vbjNuOUpr?=
 =?utf-8?B?aFVCdThuL25IQVdkcUIweSsvdWVaenAvaUlUbHA4VktvQURwbGhVSmQ3R21Y?=
 =?utf-8?B?U0RBQmlGbGtHQ3c1NTgzNDdoa3VqQ1dxcU5JcSs2MEhnVnJaYUhCM0JtR05m?=
 =?utf-8?B?K2VDNk9HY1JLcGN2YnlwUkhKaGxzZDMrRXR0djBoVEl2Smg5TGlyZUpGSWYw?=
 =?utf-8?B?djBEa2xZMHhWU25Wam9Ydm1JZ3dMK1N4ekcvbWl1MHo2RFNLR0N5RHpERzZx?=
 =?utf-8?B?RmFNVjBGM2wrcDZVUTcvS2pxbkUvS3hNN2xVVU83TmlYUlM4YVBIbzlxQzkv?=
 =?utf-8?B?RjBZZjVWOEd0a0xkTk05RkJjdXhYcElpVGN0L2QyK3dzSFIzL2Zna250b0Rz?=
 =?utf-8?B?Q2tEc09VVWEwZE9rRklJSU5pK0xobk1BVkpGQU5wRmRyNm9GdW5HREtobjVC?=
 =?utf-8?B?K1YrOGhUM1RTNWRCUnVlaHQ1ZnRlQlhrekpsYkx0b1dSVWRuVzhTZ3MzQUFm?=
 =?utf-8?B?dWtSeVlIeGRFTnBmMjgxclRnNmpRS1lOeEN2STFlMUU3dzJzaFpKUEZOcEQw?=
 =?utf-8?B?NmdMV3JvZW5lOWZBZ3Y4UDBvYUhyeWl0LzRKWUN0b3hFemZpSTVTdTliWnlL?=
 =?utf-8?B?YTZQZFo2bllMcU0xeGxMVmZhQTFhOEdDNkF4RElxSlFmTzNZQTF6b2lKNFFU?=
 =?utf-8?B?ZUM2TnBKSCtLZUtUTlc4NDE4OTRBVDRqdml4QjBhUklhdXZSTG04M2I5Zk9x?=
 =?utf-8?B?cncxTHVjaWhldEpqd252K1UzUHJrZHREWnRpdFNTdkNZelBxL2hKUWpGV3hH?=
 =?utf-8?B?eFhtUlg5aHF3WndCcmNySGJReW16OHhrM0RXWjJHWTZwZi9hWmlZeXYyampp?=
 =?utf-8?B?TnVQOWhPWExIM2pTcFVPM3pBR3pnenRTVlA2dk1ZTmZNemE0Z0FjMnQwdEJy?=
 =?utf-8?B?dTVqSThxMi9jUmJQcGxISXFIWGtVckNyeEp4TWZQbks3QWowTkVSM0t0L1pI?=
 =?utf-8?B?NndxMzNLbjJ2aUI1alMwSnRqSTJWcmdsY2JqS0FTM0pvQlQyQUwvUGNtcmVi?=
 =?utf-8?B?ZWJaYUhJQm1MVUZ6WUgxaW9ES0RIT1E3c1Q3RnZXeW1Vd0FITXQ1MWJJVmlC?=
 =?utf-8?B?Kzhna1dHbzFpSlN0QzBTUmNwTXJWd1VHRmR5Z1JKdXpUbmkvWkJ5TDVoU0o1?=
 =?utf-8?B?MnhRVi8xV2VQN2dSOHR4VlNtSzBnVmR6WnNOTERFWG9EanpNb0hXYlpBN2N6?=
 =?utf-8?B?OFMzeTZNSzMrOVFtR0x4R05Oc2pRNllxOHVsL3poRzF4M2duR1RqWGhkeHlC?=
 =?utf-8?B?cDRiZitCNThCTU5kRmFOWVVXOWdyeWlnWWJ4YzgxSEFDd2tQbmNkaVF4N2c1?=
 =?utf-8?B?OWp5YnFRVnZ3TEFWYlNLUDlRbFhjcDZVSzRRdkhEWW1tTTZlYkkwNC8vcmV1?=
 =?utf-8?B?WHRvalhaMmg0dlBYUml4K2k4NlM0dHo3RXhkamp2U3VleTB2R2JVTWpuK0FZ?=
 =?utf-8?B?T3ZsRWVJeTAvazRvbVNyY2NXTllJTWs1dU10eVVRTUhWNkE2RTF2aml3M3A0?=
 =?utf-8?B?RGtqMXRucDRvalJWZmhiMUg1Qmd1NVB4emZCUkl1SUF0a2JNSXE1RnkwQ29H?=
 =?utf-8?B?bHU0ZlpPalY4TCtoWXNFY2IyL0R5eWxETlEzYjFMMDJyVnFWZVp3Y0ZiTElw?=
 =?utf-8?B?V2JjT2VnRE5scmFJblRPR0ZUdDdhZmg2dEhjU1Z3Ty84MlljNW8rT3ZxYXh0?=
 =?utf-8?B?RFlzaWJibGhLck56WlJuMlYrYXpscm1SQ3dBVXZVRytHYlBnMW42L2JueUxF?=
 =?utf-8?B?c2pxUWNlNW1wRm9iZ1VTMFBRYnpTY0lHZmF4MW8rQ3o3WlI2Z0d3dHkyWUxC?=
 =?utf-8?B?b3lmNUVQK0FaMSs3K2NnNTVnTUVjODdHTkV1WnEyS3g5M2JnaEhTT1UwanJD?=
 =?utf-8?B?bUkzd3ZFbitZci9wM2ZCdmsxUDF0cThYQnlLY0NWaXBEYTdXMUVMdDRXUWdv?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 661fbc46-0ab8-413a-b1c2-08dd354e9753
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 10:23:02.2028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+Be7uRI5h9UdKKogW8RrLHNAhuRPuNxqIiBLWznRk3UbhImc2a1wuZbtzRt289onibsKkGYOAproBHZ/JQ+8X566IwrOyiw2RvTTvJrzuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8301
X-OriginatorOrg: intel.com

From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Tue, 14 Jan 2025 21:43:26 +0300

> On Tue, Jan 14, 2025 at 06:17:22PM +0100, Alexander Lobakin wrote:
>> From: Dan Carpenter <dan.carpenter@linaro.org>
>> Date: Tue, 14 Jan 2025 13:45:04 +0300
>>
>>> [ I tried to send this email yesterday but apparently gmail blocked
>>>   it for security reasons?  So weird. - dan ]
>>>
>>> On Mon, Jan 13, 2025 at 01:32:11PM +0100, Alexander Lobakin wrote:
>>>> From: Dan Carpenter <dan.carpenter@linaro.org>
>>>> Date: Mon, 13 Jan 2025 09:18:39 +0300
>>>>
>>>>> The "sizeof(struct cmsg_bpf_event) + pkt_size + data_size" math could
>>>>> potentially have an integer wrapping bug on 32bit systems.  Check for
>>>>
>>>> Not in practice I suppose? Do we need to fix "never" bugs?
>>>>
>>>
>>> No, this is from static analysis.  We don't need to fix never bugs.
>>>
>>> This is called from nfp_bpf_ctrl_msg_rx() and nfp_bpf_ctrl_msg_rx_raw()
>>> and I assumed that since pkt_size and data_size come from skb->data on
>>> the rx path then they couldn't be trusted.
>>
>> skbs are always valid and skb->len could never cross INT_MAX to provoke
>> an overflow.
>>
> 
> True but unrelated.  I think you are looking at the wrong code...
> 
> drivers/net/ethernet/netronome/nfp/bpf/offload.c
>    445  int nfp_bpf_event_output(struct nfp_app_bpf *bpf, const void *data,
>                                                                       ^^^^
> This code comes from the network so it cannot be trusted.
> 
>    446                           unsigned int len)
>    447  {
>    448          struct cmsg_bpf_event *cbe = (void *)data;
>                                        ^^^^^^^^^^^^^^^^^^^
> It is cast to a struct here.
> 
>    449          struct nfp_bpf_neutral_map *record;
>    450          u32 pkt_size, data_size, map_id;
>    451          u64 map_id_full;
>    452  
>    453          if (len < sizeof(struct cmsg_bpf_event))
>    454                  return -EINVAL;
>    455  
>    456          pkt_size = be32_to_cpu(cbe->pkt_size);
>    457          data_size = be32_to_cpu(cbe->data_size);
> 
> pkt_size and data_size are u32 values which are controlled from
> over the network.
> 
>    458          map_id_full = be64_to_cpu(cbe->map_ptr);
>    459          map_id = map_id_full;
>    460  
>    461          if (len < sizeof(struct cmsg_bpf_event) + pkt_size + data_size)
>                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> On a 32bit system, then this math can overflow.  The pkt_size and
> data_size are too high and we should return -EINVAL but this check
> doesn't work because of integer wrapping.
> 
>    462                  return -EINVAL;
>    63          if (cbe->hdr.ver != NFP_CCM_ABI_VERSION)
>    464                  return -EINVAL;
>    465  
>    466          rcu_read_lock();
>    467          record = rhashtable_lookup(&bpf->maps_neutral, &map_id,
>    468                                     nfp_bpf_maps_neutral_params);
>    469          if (!record || map_id_full > U32_MAX) {
>    470                  rcu_read_unlock();
>    471                  cmsg_warn(bpf, "perf event: map id %lld (0x%llx) not recognized, dropping event\n",
>    472                            map_id_full, map_id_full);
>    473                  return -EINVAL;
>    474          }
>    475  
>    476          bpf_event_output(record->ptr, be32_to_cpu(cbe->cpu_id),
>    477                           &cbe->data[round_up(pkt_size, 4)], data_size,
>                                             ^^^^^^^^^^^^^^^^^^^^^
> Here we are way out of bounds with regards to the cbe->data[] array.

Aaah okay. Thanks for the detailed explanation! My note was "generic",
not regarding precisely this case.

I think a couple checks here wouldn't hurt, not only for an overflow,
but functional ones whether we have sane values. It's an ask more for
the Netronome guys tho.

Regarding your particular patch, I think it's now pretty clear for me:

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> 
> regards,
> dan carpenter

Thanks,
Olek

