Return-Path: <bpf+bounces-53888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF41A5DE8F
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 15:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210183B5A69
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 14:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4145824EABF;
	Wed, 12 Mar 2025 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBExEqOD"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487BB242918;
	Wed, 12 Mar 2025 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741788083; cv=fail; b=robDseD/51tw3LG5/0EaP0QaJFxu0bCSZU3q7m38L4gpZ+D925sDhWcImSP6mUi0xCIqbX0EwNYZQOZou7xCcUAby05S317ZbIxzhJ3mWH8PtTQttgLtIvrLODlT9Hkcga8hLjLJkG51i9B9VzGqVqVSHO+tzmDwEGTtCbO4OQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741788083; c=relaxed/simple;
	bh=BAYXnZxA9ACbSPP+HsxbHYlwzS/b91Q4yBOD6niPKc8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f/uroTJO1/TiqtJ54ep2evqmfbwiekr4E1W1lLSqGbnh48gtqKL5UM/NVY1/QpR9Ncit8ziuk+j3klfmRT4KWci3SWQdfBEhfwB6NpGPEL7reYmu3p/xI3AKd27SRvjiq1MEDVSB5QdWIKK3LtPJZTJkVrj6l4KnfELDTa1L4C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBExEqOD; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741788083; x=1773324083;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BAYXnZxA9ACbSPP+HsxbHYlwzS/b91Q4yBOD6niPKc8=;
  b=JBExEqODX0Zv6jXMN9gt4PYBdIvEtYbrIRtlLs/LNs4GtjoO7hlPFptA
   7YRq7vQaeVEzvmZeCNosti8YIY/+xTYOYmGuPs4JOnctuzhmWwL1Ce+Ho
   F4V16sfHyVR6lqO46xbvNnQkB2EkQ9wuJJdE6lq/Ikf/GoyfL07RVm/45
   eYEGkggKktrOUJXKDccpjqiAZNCJcR/C8pN+3NALDpMl5PxhMo8IGYfFD
   FbVwB0zBSqbiu9JhF1kiNOWF96RCk59vuo5ZvvK1ouhnhCdRbj/gDxsln
   9tJ7oRLcnWv3hW0bS86ALsTpZAyHjyCfNFcVAKwpGOz3ByUwX/Y0mx3dX
   A==;
X-CSE-ConnectionGUID: SXLZhhoKQsmlpqzgCDr5Dg==
X-CSE-MsgGUID: h4spMxdnSXC2phz36Nqk2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="53859475"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="53859475"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 07:01:22 -0700
X-CSE-ConnectionGUID: w5TmrA6MS4qi7XqvUJqeIg==
X-CSE-MsgGUID: ShNyY4rCSOiVoKu0gWe7MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="120598986"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 07:01:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 07:01:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 07:01:20 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 07:01:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+zjHKNcmKg3qZ9+P8QxcZt/WMcGz0WyJm0YWoJDkGP8bPecmkLEdX/vTRQU7not3zNC4cFTwwvBLw7FOQNvXMjnAr/tJgN3epJiYP9FUJ7Aur3O95eNRhuKrHSP88+twv6U+wOA8jlggLqG93qbk8bYwjlW2we6X1BaU7tDC/DDU+gC2W+uUbHbfu+OvmzdxTQKj4GSeQtQSHcB3+jTZzjr6pJ9vkrxMEIZ0EfBqJZ7W4v6ujzetMfTpSBDl3lKkS/+S8k3tcgK7Zt1XAvNOwYbhzU9O2il3Qajb5MrxuW2mHx/l9wXxDSPlIiGkH4gbEylDLwrYX0Fn5YV7lT5GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Idi5fmL4dUxdyp2j2EifGLBEhlsQkPRTLwpESxgWvPg=;
 b=EysdOO7YW6VEnxtTuQRYQPjr9P1U8g0PNNtnbPK1P16qfS7H5sSPMPUS7Tdb857uwxzeqd+tXdRiTw2h4IoWSUv82y3wTQ1UuEI/Bpe1+uRPGKaJ7S6a7MkDdWqslPO8lkaZxgoSwqu2GtYdKsqM5le2jD6kQwCB+KvbcLPfKEk/1r8IVHiZfVGgppvEBwdvyrf3p+DnFo4I+/aU3XyZ4Q9wkFBidRCT1obuZ0bFhQ0IE2MFwZZYFWTWkK+MzxyPJsjftHsmpjpehPBlp3IlF1JvVfl1FfqnCJ/FrVw0k5yZMKR2jGMBUqFz7spjVX5L3oPrzcine676NUzZww1DAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB6330.namprd11.prod.outlook.com (2603:10b6:510:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 14:00:50 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 14:00:50 +0000
Message-ID: <532d9f9b-e4d0-4050-b01d-730259535d5e@intel.com>
Date: Wed, 12 Mar 2025 15:00:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next 11/16] idpf: prepare structures
 to support XDP
To: Jakub Kicinski <kuba@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, Michal Kubiak
	<michal.kubiak@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-12-aleksander.lobakin@intel.com>
 <20250306171208.3162eb97@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250306171208.3162eb97@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 740500ad-c9e8-41aa-d6a9-08dd616e4ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFNzSWhsUXhQZSszSzV2MFhsSEE0TFBqS2VHeHpjZmtVTFBiUDJHRlpOdkRO?=
 =?utf-8?B?N1RpSkRMK2NvK0ZxbmN6cVlIdGY4VXdHa2hOeUdibWdUL3VmS0tEUFN2WVVG?=
 =?utf-8?B?S3VvRlVKZlgzYlNjZ2Q2Yll2Yi9PY1hpU2lQL3lPS1lsUk43Y20raVJNeENS?=
 =?utf-8?B?K3RKMHM2OWxvRXdBMVZnTlBkRlliQ3lZSlRySm5FbzZPY1J2TlQ1OEFjM3Zn?=
 =?utf-8?B?c1JNZFNLeVBoWXpMQlRqT2VLZVVwOW1BMS91U0hkNWNrcXNmYXVNZzFBZVRE?=
 =?utf-8?B?a0QvRk1ldTc3TmZGVzhDZUZoTkhuQTdiWEZoVG16K3llYVFDU0R2WE5sNzNx?=
 =?utf-8?B?UnVYWkg4QWZjOHlpRmMrRE1uNUkrYWhpTHVKbkkyejJrQlo3cFNVRVQ4OGRB?=
 =?utf-8?B?SUxFeVFrK3I3M1l4RmxmTTQ1RDVtaEgyWndrOFdTSytzOEdFZ1pxU25CUUtG?=
 =?utf-8?B?M0lmUG85K25hQktvM1dpU1BCVDFEWXRRb09DQW04UVF3U0dWS0JRTGwxN2NY?=
 =?utf-8?B?UWhXRTFodUs2WDZjTFkzbHFnM0ZzTjhkZkczYURwTXo3UXRHa3JSTS9XczZl?=
 =?utf-8?B?WWIvNmF5aDdkRkEzOVdNejhhOVdOVFYrZEIvbktKenJTUUJrWG5uZWY4N1hM?=
 =?utf-8?B?ak9wZi9nYlVUTGVyTUlSZXRoTzAxaUZ6ejF0M1pZWCtyL1FWY205QWVPUlAr?=
 =?utf-8?B?KzlqYktQWlNVa1FUM1prK0RVeEkrUXZEMkM3ZUtiWmM4ZVNJRWxkL0Nqb2wx?=
 =?utf-8?B?OExLNW03Y3NHSWphRlh2cWY1dGtaWkpFWkdaVmRkcGxuYnBvYmlQR3QyT2Fz?=
 =?utf-8?B?VlhVKzN0T1dCemU3Z1F2VjdvSWZvWkRmRythVDJydkRYSloxaklUZ3VBN1Nm?=
 =?utf-8?B?UjF0cTJ5OSsrdzRYMFMvMW1yekM3d093djl5ejF1ZHFvQThwYnU1SlVmN1BB?=
 =?utf-8?B?cWV6bWRLcEc2SDZrUzk2V3p6dzZqUnJDVStwQmJuTWVGNnc3RmNTQ090eDly?=
 =?utf-8?B?bGkweWRWZjJiZU9wZXUyemVaMHZHRTBlMTlJWHFVK04zaEF5Nk1McFpPRkdo?=
 =?utf-8?B?L0M2LzRQM2VQSHkwSlFqS2FwNmxZc2hvUVdIczJGWnA4NU0rVDlRcDVjbnoz?=
 =?utf-8?B?UUF3MGZnYldsUHMvUGpsYVRVNnkrQi9QN2xUNUVNdzl4NEJxS1FDODJtVXQ5?=
 =?utf-8?B?SGhXS2d1bTczYXdFME5XOU1IdlQwTE5ybThvOWt2eUFITTlOQzlOaW5RZXh6?=
 =?utf-8?B?eFVGTzdFczM3UUhwdzVmaWQwTUVFT0VrN0lkNHJoSzdaaFUvelNrNjVyWm51?=
 =?utf-8?B?NENLa2hGUEhFSDFDVHIvNmtNRGpsZ1V4V1dibzFUa1g4MTFrUEpNVlFrNnBu?=
 =?utf-8?B?YVVUOVduU05ER0xsQkt5SU9OQVprZHk4Y0VpL0RHZGtkL0Q2aG5xVk1YRmVw?=
 =?utf-8?B?UDVvSUxHS292UXpQaDFLSzRpR3FValc3VFVzWEgrTm1QYnI0blkzRk5sKzFr?=
 =?utf-8?B?YXJOYkxwOGhSV21US2ZPUzhMbzYrU2VWMUxna3BBMVhUVUpFZFpPNEJkZGU2?=
 =?utf-8?B?Z3BTUlhsbmluMU5qeSt4NDlGY1ppa2pWOS82RU9FVkk0ZG1ReHJOZVFQUjV3?=
 =?utf-8?B?dEdtNG5jV21sOGt6TExHMWZSWmNGMFd1UHlMTDNuWUtBWE1YVWFWeVZMMFFh?=
 =?utf-8?B?YmUrQVV1czBBY0M4QXR2RVhlMC9vS3NjL2ZlcFNhb3VPY1U2eWxNd09oNFlW?=
 =?utf-8?B?dXpRQVRvTmFkZEtydlhJRnBKd0FleTEyL1AwclFMSWd1bG5aOXNqQnJxVERW?=
 =?utf-8?B?RHM3ZnVuK2dCNWJXdVRUWXBUSnk1ZFphcGhzODdRVUp5UFRlQWlhNnVraHM1?=
 =?utf-8?Q?AiMx8Qt+928Ie?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWlmTzhxT2FUejFGbHdZaSsyL2hmVDYvcXBiQ1M2Y2Jwbm54aDNXRUg4SzQv?=
 =?utf-8?B?U2I5WmQ4bVRhckZ5a3BMU01xMDUrUFpZNnRLa0dpa2NMTzBOK3NrTlduRTBZ?=
 =?utf-8?B?a0RxZ1VsVGpLWVh6a0FZVSttL3dLNSthVmZiSUNFNkc2bVFSVkxjS01IcmlR?=
 =?utf-8?B?RWRGdDZRT1lHRzc1djNJMUw5eVpqTXJiNkRrNDVNWmd1R3ZIQ0ZwL21mV3BC?=
 =?utf-8?B?VU04VkUxYUJnT3NhNndCZTNYWStaeFhEMkNMRzQ0TlZaMUlCOFlWS2JCMDFj?=
 =?utf-8?B?M1ZTYVdWV21hLyt4SDcybTVWbkV6Nkc5ZnprVWVDS0hONHBldDlDaGJUdmlo?=
 =?utf-8?B?bmRPQ3JyMUI5MVEwTEx6UVBrN3BwWTd0M3lqcDJuZ296YnlBOU5OSmVCdC94?=
 =?utf-8?B?VzFBVGswR01uY1hMMGhtcFNVR2JiemNsTm5FaTJoU2ZidS9LL2VJWTg4TnpI?=
 =?utf-8?B?Mlh3anFTMnNKc0k4cDhmVEJwOElqWmtXWlJ2aUNtUHhQeG8rUTN2ZHpXc3Fy?=
 =?utf-8?B?NlpqNjhiWm10UmMyamZoK0xsVG5TRWxNdmFpUWE2Z3ZydHNuTkpJeTU0TDA1?=
 =?utf-8?B?MjdYR2V1dXo1K1RqTlVsOFd0Yk44TG1adldlbE5aT0REbjRLMVhUNktrUyti?=
 =?utf-8?B?NUtGTThxeDIxYnNCSHJyRDY0TVd2Um9MRkxoZ1M4VFpJQUNhd00yalNPSGcz?=
 =?utf-8?B?cnNiaUhQZkZLSEFPZmdPa1l6Q0lRNUpzaEVBNitaVVIzUFRtYmphc1cxK3ZC?=
 =?utf-8?B?aVd1SW5Qc0JzSTdGTUw0emFnMHd1RTdvOG02Zmw4anNQQ0NQdWgyUGJMLy84?=
 =?utf-8?B?ajRCRDlKQlNMK3dHMHYvUVdvclFqMVBnYVpXUno3T3BNbFdkQVExYk80V25B?=
 =?utf-8?B?ZWlWckRwRGhwTjc0MlpmSUZ0YjdmWjNVNG1laWYzOS9Ja2Q3Q1lpU2ZIaDdp?=
 =?utf-8?B?SHBiUWlvNnIycE84V1NibXhyOEFvM2tYVW94dnJqZVZxUGwxemlpTmExZU14?=
 =?utf-8?B?KzNnd0dSSkpJSlNCQWNCUld4T1hrK084elg1bVhtWXNuRVAzbXhZemhMRXh0?=
 =?utf-8?B?UzVlMTNjeS85cnlWNlY2aXQ2dFB3OG9FSEVqVGsvdzhhTFBHNUN4c084MkZh?=
 =?utf-8?B?UUdFbjNhc1B6blNnVXJXQXNzSUZwREhFNnNvRENrb3pLQStyL25Wcml5TFpX?=
 =?utf-8?B?UFFFdHZoNzFPU2U3dm0xZ1RvcCtabEV6QzRYT1RxYnl1b1hhcTFXcitTL2dJ?=
 =?utf-8?B?dTI5UW9BaEVCRVhIaUExd3p5ekpwaGwvTVkzQ1l5V21yZWlGQ2pLZ0wxYlgw?=
 =?utf-8?B?Mk1xMGVBQy9sNWdFUUl1UGk3RlRyZzRNYXBNTm5UU3pGK1lSR1MzelVOY2hy?=
 =?utf-8?B?dW1qaUorVlFpMUg0VkQyd0hEdzg3Vnl0UC9YcEJMeEpQVXZ3bXdNOE1GV0Yv?=
 =?utf-8?B?S3F0eWU3b0RVZDJFLytPaUxCanVNdnRUMC9JREh1VjNrWCtHbEdtbUxMR0dl?=
 =?utf-8?B?RHRGbjNjYi9mS1NEeFoyZnk5cTJ5aU56TGpwaDkyRlJHUWRQVnR5elZjaUlz?=
 =?utf-8?B?U3hqYzhCa0lOai9lV214UVJHdVVHckREVXRneEd5U3Mzcmc2L0hMRnArTCtZ?=
 =?utf-8?B?YW5qSUlZRzZNTjRYQTcwb0RsZWxVakhRK0s0ZDhwcUVzRVRTMHl4b3VLSUg3?=
 =?utf-8?B?U2pYTnVRdWNpbkJLaHVUR2JFSmlGOXRPWnpnVlcxRU5BRlcyZGFTK3h2VVBn?=
 =?utf-8?B?b3hmYlBIVkVKSEI5ZkdoR1lXalJ4Q041RERjeXlIWVNXTkVSK2RueXdPcVZi?=
 =?utf-8?B?VUhUVGY1RHBzZ3JGbDkyQzJLbXVWdzB6M1dnWjBjNy9qQ01hRUdlSHN0b2lS?=
 =?utf-8?B?bXVKMFdrS1Ixa1VWSHNIcGxEM2VEWXFMaklYa25zODVFaW83TjV1VjZqUlB2?=
 =?utf-8?B?akQwa3lVUUFsdzQrTmtOSmdTTGFoNTQ3bGQ4RDYzUzk4eTdSR1U5VjVOLy9X?=
 =?utf-8?B?QnFCd2pBK2x4ZWdJWW9BWm1ucHFyK3puNTF4UFY1bkhGcGZoNDFIbENVcHRR?=
 =?utf-8?B?MlpMYTBvUUtaVUlCWVhpY09jYlRBRnBEcTMzYmZPc0ZlWGsyZzR5VE5PU0Fw?=
 =?utf-8?B?bUNiRThVNEx3ZVFrRFhxWWNGajFKYzdlYWNQa0lBejdFQXZqTm1CL0xTc3l4?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 740500ad-c9e8-41aa-d6a9-08dd616e4ba4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 14:00:50.3382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcdQe4ardtveeyp5OlVpQDmBmNwf9D2WHahJNikm2fTLYf/QAa8ClOc+7ODUBBIMSMtaXkJNTG6pl+EWcS0gu63iX0/X6npP75PIsQGoVdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6330
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 6 Mar 2025 17:12:08 -0800

> On Wed,  5 Mar 2025 17:21:27 +0100 Alexander Lobakin wrote:
>> +/**
>> + * idpf_xdp_is_prog_ena - check if there is an XDP program on adapter
>> + * @vport: vport to check
>> + */
>> +static inline bool idpf_xdp_is_prog_ena(const struct idpf_vport *vport)
>> +{
>> +	return vport->adapter && vport->xdp_prog;
>> +}
> 
> drivers/net/ethernet/intel/idpf/idpf.h:624: warning: No description found for return value of 'idpf_xdp_is_prog_ena'

Breh, I swear I ran sparse and kdoc... >_<

> 
> The documentation doesn't add much info, just remove it ?

Ack, agree.

Thanks,
Olek

