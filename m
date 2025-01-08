Return-Path: <bpf+bounces-48244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9B1A05D07
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 14:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF6C3A5029
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 13:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE75C1FC7CC;
	Wed,  8 Jan 2025 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hwBnYkX7"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ACF1FC105;
	Wed,  8 Jan 2025 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736343651; cv=fail; b=otH1tkplDN2W7QtLQSA5iYpABwTlcvXbamuFPdPzZh8Ggvkqf4x0n3XnGrvBD9XgZv/2ElQZhAF1pdF/lMjMMVdnUukeodmTBNjs+4dghG14dUijcesKdQSVds+m8Q8U9ByLXNsQzhlvYU89XQ3SbTwanjtEmG9ieEQnjzIn2Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736343651; c=relaxed/simple;
	bh=yc/9jy5NFEwLjxpYyq4KtyVGLaxt6fLYZz+M4padv2g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iOhbcqh28nhSP+47LBYUPBE2T5ox7d3iWkU3xGA5zFdPpeUUJseJlSGBFIGW4gxbCkA0Q6MGdhL43Kr3oZl4W1S6GNymwlhLwgqLzoDeUyFnxEPuvO24EZ20oxqVKDTiF4k3yToE+bc5eLz25T/88ehvhFmOh1YgQ0HYrxZdvfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hwBnYkX7; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736343650; x=1767879650;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yc/9jy5NFEwLjxpYyq4KtyVGLaxt6fLYZz+M4padv2g=;
  b=hwBnYkX793b0aNLXuXlN34vaqg89AS14QNx0aD7xDAwktbLlGqmTN1lj
   D6s5xtcReMYg0hHYEB938ggDUyyi+m2CqsHW6kRlLTII5fsMYaNPAknpx
   24K9N5Tq8fIdojUjjTEhN8m7fPxNNthFbSC5d4HY83W1cGG7m3kZMptTQ
   DVHMbyQpmHsIprsNNvsPdyW5cViaEhO89mvUUWBpN+1EqQX4IitzvVbMl
   eo/PkqdrjnJv+eaafbwl625KtPGdKAc6+BD1i545JTXw7qe4GbAr+T79r
   0YGPulhjkz0WW7xjCQGCszF+IWEasQQVFgFs0HpYGwW/FOq45JStj5gJD
   Q==;
X-CSE-ConnectionGUID: 59Q0gm62QjOI5w3J6Fo0BA==
X-CSE-MsgGUID: 2MzI24siTbie0BWsH+aD4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="36729893"
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; 
   d="scan'208";a="36729893"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 05:40:48 -0800
X-CSE-ConnectionGUID: lN2IAtsNSMSNZ2ONdz8V+g==
X-CSE-MsgGUID: XPrpWicGTL+ClXGoo4jHDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108197851"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2025 05:40:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 8 Jan 2025 05:40:47 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 8 Jan 2025 05:40:47 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 8 Jan 2025 05:40:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoQNNUquG3kj7AJDr1E/t1cywOdEgzz8NTkm5X3NMdg/TWROoTWO0zkQvfUmlOM0UPsomt+aQjt4kaF98/0gwd4XxpYhR23v2Lohqsl++avIvV+14f9trtra5P/UUanmlTZlDz99bhrwgyETAScyH4j282PNWmdgIQJJeWnytmv3cG0I2aW83UFI3TdM4J99s8JeqzdY44i82ipAfQsENkPlC3h7paJvDTkRjl0Jq+b0O7rMxOsFzPJb9KQ/PBRMvQ0a4WLKsswcDMdUY8dPz8ZSVG/OvVXneNeDjDE1+/bdmTL9J/Yz2CJTkK/XbQquo9EiiCzX47Qd6VWC3dmqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oy++/GTBaDbMBIzQPIkxbE/OX/ft1zkdocD+3Q1UpQ0=;
 b=H0Cg09QQN0hd0911GPO6TZPWuXNwiH/Oj1WMfiE6ofEKlsHCb28Vk/uyVr7NLmSxBFErv4pZxiEH3b6mFo2ILAL5nWUv7b8HZhLkAkpDmjI2I3Y/noEPBVfIyShtcKyN8lIw/xHuFQHTlIS/KaLUQKVAnqu17hDCFq8oAmMHIrVV3iyYAbSLAq3uwBK10nQU9X49XPPw0t3bGrkUaAWo44u6h6wcgogh9PY6iXs0FdIjd+yyDv6BxwW7/NkoJqglP4mX9dzF+Ox59sEtDLMGiMircld0mAaNQG/Sisys94Knb8ibKjFro5bna3IhXi8Zo6JFaDF3M0DL99drLk/ACw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA0PR11MB7910.namprd11.prod.outlook.com (2603:10b6:208:40d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 13:40:07 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 13:40:07 +0000
Message-ID: <d37132e7-b8a6-4095-904c-efa85e15f9e7@intel.com>
Date: Wed, 8 Jan 2025 14:39:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/8] bpf: cpumap: enable GRO for XDP_PASS
 frames
To: Jesper Dangaard Brouer <hawk@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>, "Martin KaFai
 Lau" <martin.lau@linux.dev>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jesse Brandeburg
	<jbrandeburg@cloudflare.com>, kernel-team <kernel-team@cloudflare.com>
References: <20250107152940.26530-1-aleksander.lobakin@intel.com>
 <5ea87b3d-4fcb-4e20-a348-ff90cd9283d9@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <5ea87b3d-4fcb-4e20-a348-ff90cd9283d9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P251CA0011.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::13) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA0PR11MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ebabd4-2404-4056-8d68-08dd2fe9f682
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHBrVjVNTnRvWk8zaFpqYXdoRDNKUTNyWmdad29IM2lDSGtLVW9sRGFOVjcv?=
 =?utf-8?B?SE91Sml1M3pxSnFlWGF6REVMSERCZVduZjRVUUZvcDYvVjZmZmRTWHRpV2l5?=
 =?utf-8?B?MDRQRHNVcC8wbTFjUVNMcUxsdjVCVTQxcEZENDQ3Ym1uaytoTnJnblMrWWFj?=
 =?utf-8?B?MjgxYW5ncm81SmYyZmVNSmN1OHp0czhUVlRXQmhJZTZHZEdrbVFGYUxyUUlQ?=
 =?utf-8?B?Y29SdWVkajRIOGpKOXk0YlZ4WUJJcE1KYU56Si9zK0tEWmdpM2VnOWk4eE9P?=
 =?utf-8?B?YmNHTlpmZ2E4K0k4M2RHTjhIRmZQaHhZU1U3aFdRSzE3YlpYb0FBUTNGK2V4?=
 =?utf-8?B?SmpjTUNqUnlGejJxSktiWFBzUktZMjBiWHNGZTQ2STl4cEdScTU5L3ptS1c5?=
 =?utf-8?B?dHhoVWlXMnZXaEtKOVFtUEdiME52cDRkZFFZRmRrVVNUOUxqK2YvZEJIenZQ?=
 =?utf-8?B?SmYxMVFBc1BpM0JzekoyeWtPYlZiU1dKbUtZb1lTTTRsNHJjcE9vM1h6NHkr?=
 =?utf-8?B?R25vSmZEV1JXM0RSZllZWFNmd21KMUd2SVVYR3JEdDQ3S29Hdmh5RzMyZ21s?=
 =?utf-8?B?VUNtYjhEb2FETU5iNjlEazFUT09hWHJORkdnd1UwK3ovMndua2krY2Jvem1m?=
 =?utf-8?B?MitTc0k0Ulc4QUxTWC9xTjFUanZOakF4K0dqOElyMVdNUXFvVDNHL0tMSkcr?=
 =?utf-8?B?dzg1US9CRzdvSGFYS1hEeDdDT0R3Zk5PT0c5OXBlS2dLaUxlTDdJTjFIRWhD?=
 =?utf-8?B?TE80Zm0wVjB1SWZobGZra1VML2ExbUVmMm9wQjhGdDZOaUR5eHNTVHBvZUVs?=
 =?utf-8?B?bDgwYWVGNG42RXRjbFlyN1M0V3VDTmFUKzlTN2habk9iWkFTSGJKK2pxdnBm?=
 =?utf-8?B?dHZTdDdWN2tFek5lSVhBR1NYOXRwUVVnaHEzZytKeHZtUWw1MEx3ckRHeVdx?=
 =?utf-8?B?bjdSRDZzNFBhbjFpOXlpUmxPUklnMHN4S1Q5TSt6cEdwdTZ3Sno1aDRDM0RF?=
 =?utf-8?B?RStCcCtENkhrMldvL1hWT1p1MEl1WTVuVE9WVnBWdUFGMkdmNG8wYkNJRzl0?=
 =?utf-8?B?Y0VaWkFFRnAzQ09IeVVzblBEbEpzM1JnblZwM3pPbXZhaHAwMndsQW9id2Fu?=
 =?utf-8?B?cHFDbWZxR1hWUHdWVWpQclVaMXQ3M20zYTQ3SFJXbGkvTDVBdFpJWXgwd3h5?=
 =?utf-8?B?YTVMd1ZUSHBxWkExUWpWOVJBU1lPbStYeks4NHh0dkxXR2RKd0NVNEhwWWhW?=
 =?utf-8?B?Z3BrbmdESDRJc21ZdkxZaEp1aGppcnNyTEM1aFA5YWhZdStMdXFWbVFhZk1o?=
 =?utf-8?B?NVROZzF1eDJQeXNtWExuNnVDY0lEYUpEdUFnWGdRRHNZOG5RSXpOb3I3K29j?=
 =?utf-8?B?ZUpVckxDQWQwbi9GNW9nRFUwMDRiYTlpUmJtbzdRdmdveWg3VVpQUmhUZUpa?=
 =?utf-8?B?L05INkVzbkpsMTR4Y3B0VWwvMGluSlhQd285aGJRbzdUVU80QzQzTmVQNTdk?=
 =?utf-8?B?MGYxS0F4TmIzZVd4ZDdNTjlqNUROa2d2Z0huRlNyWlVQRUlWS2cvaUxCVkEy?=
 =?utf-8?B?Zy8yaENlL0lvSjl5TzU1OFlKMFZoLzU2aTl2cWFvUmdSdHFQMDhxUU5nODlh?=
 =?utf-8?B?VU40M2o4ZGlDZU9FL0ErNVJ0SXgyTGxLaEdsL3ZKZ2lqem1uR2RKbUJXWHBZ?=
 =?utf-8?B?RExPMXJOblhYRUVXUVE5N2wyYnlZeW95SmowZUN6OHFUL3l2WkxKZTh4S2I3?=
 =?utf-8?B?QVZYZ2JxM0w4SGRJaG0wUWFTdVZqbC84NTBnK2FIcFVEQktOdDR1RzVsYjNu?=
 =?utf-8?B?N2UvL29YazhKeXByL0ZSeXFSanlGQjFFTW5tN0g1allMeW5TTW1EYkZDMUVz?=
 =?utf-8?Q?A44ssku8wKobv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2dqM2o0ajVlM05keStSWGpDT0dpNGFuYjlsRm1INkVhZlJ2Y1RINmo0U2o4?=
 =?utf-8?B?RUpiTGw4dGowOENjbDQvdUNRbVBZTm9vZlVGMytLRnN3NVZ3SkcyMW1aa1JJ?=
 =?utf-8?B?Y3N2eXp0Y3dOc3RxSnBwazl3UitIVCtEaEFOcFFJUlBpeWNxSzFMSThwbHAz?=
 =?utf-8?B?US9qVlV6Q1UwZFN1VzRmQjYyYjdCZkc1aWQxSUJjNWllL3Z3WWFHRnNRdm92?=
 =?utf-8?B?aUttYWNOYTU3R3BJZzhZSXFaQ0ZFcGduaVFoTGpDYUEwOE9WRTUrMG8zZnN6?=
 =?utf-8?B?dGpLaURxVXhtZ3VRRHBwbnJUVmpWdjBycU9aRnBtVlBSc3l5NXRVcTVjSDVT?=
 =?utf-8?B?MDVQTysxS2xBR0NMeUhDandHVEFxUXZ3eVhMRGRuTG1IRUtFY1pIam9LNGdX?=
 =?utf-8?B?WVhwdGVzbnFSTnNPcGlZL2d2KzBUZFFtcVRkdGRPMFJ3SmJGYkZGWldUKzM5?=
 =?utf-8?B?RzdEaHpCZ2xYN3dOc2VYdDMzSHFyRFA5QUJUTWZQemx1MW5QeGRmTjBLU3JV?=
 =?utf-8?B?eXN5YmVLYVRzRGZ1RGdkUlJTTnYrdzZvLzFmTDd0S1NGakxuTERYeHF3RjFl?=
 =?utf-8?B?VDlWd1Brby9scXgzOTBCMHYxV0JsY2xoWjhvOVVLd1ZzVVlERG16V1oxUkh2?=
 =?utf-8?B?NjZKUlU4ZXFGQ21OQWFzRVdVRDlxeXRXS3F1VnFiRS96ZS9PWUYzK2JxZ05w?=
 =?utf-8?B?TW9rbEVwb1AwQTMzbHo3bWNwblFHVTVZVFJNVVVubzJBL1RlYjgrYWJqM1VG?=
 =?utf-8?B?R1c2Vk5YenFvYUplbjhNNncvRDBYTHBsMllFWWJmTDV5R1NKdGVDTDdwYlFE?=
 =?utf-8?B?TGhCR1MrTjZSSmtiZnBkMmRqeEY5ejJMRDNDRVVmbENiM3IzRzd1alU1TVc4?=
 =?utf-8?B?c3pXelN4VWg3VG10eEVWc29handFamlONzhwSVlqZU0zZk84UUpQdk4yRjhz?=
 =?utf-8?B?YmlUUDRrYVZoaXBkVDZTSWJHSk5ydDJYeDZQQmd4YzNEOWVlUFg5enJWSHFr?=
 =?utf-8?B?UXNxZ1NJVWRwY1VLUmNpVFdzZ3pacFphaHRwTElCY3VOTFQ5VWVEOEFzUXZX?=
 =?utf-8?B?Y2xHSUpLK0Izb1Z2Z0pqUzhPYlRUc0xpemhYMThLL2FScUsxNG5IamxTZjRW?=
 =?utf-8?B?N0puRHM0cytnMHdrLzd6MEZRZXFOdFlmblVrcHJ6bzZ3S1FrSm5jd3Z2NENh?=
 =?utf-8?B?cTJtNUJDanFVQlVQVDVTRk1yYkFNUTZTMS9pL2hmNVloYUdXTUZlOVFubGYz?=
 =?utf-8?B?bHF5UmZSV2RrODZkWm0xQSs2QXVlZlJlUm44em0xTU9HV1hTaUp5dzlrL0JP?=
 =?utf-8?B?d1Y2cTJJcU1JTjFpRWw0UHNxQmd3cWJTdG44cnMrbXRkUExWc21rdDFvazNt?=
 =?utf-8?B?eTluWk9ETlByMXl6eEVHUGEwdFI2Yyt2SlhSYmh2bHZPdUx1R29xV0lpY05k?=
 =?utf-8?B?dEVzQ2JHNFpnYk5tem5rWlJIRm5TN3NaV0VDWW9uNXdlSm9BczJPSGxRODBk?=
 =?utf-8?B?WWgwRktSYmRaTXVTaEEycTJONVN6aC8yVGkyRlpaOWFtOUNTNjM4RHV2ME1V?=
 =?utf-8?B?c3o2bUZIdHFlbXdmRXM2MlJzUHBnQ0o4cmNPdFJvc1lsWm5yeE5BTzFaTC9X?=
 =?utf-8?B?bXNNZGQrRGYwZy80bmJLMjNwbkRzN0pJbjJsZHVXRUxvT0JqZGE4UThOQTBU?=
 =?utf-8?B?RDZFZUEzc2gzOXpZVWQ3c1NTS0NRZXBzaFo3NGEwQTJBYkcwQXBxSnREbG1F?=
 =?utf-8?B?TFVQR0tZVjFwaVl6NXhQV0ptZFBacXhvNEc0Nk13U3J1L2NLTFRkVHBmUXlM?=
 =?utf-8?B?aWd1YkZKY1dLbzl6cFpFV3F2Q0hiQm9mWVZGSUhNY1MyTWFjYmlzWEd1Rjdk?=
 =?utf-8?B?NC84eUN0SDRneUtieTV2dWRNVlNBSEtFUTVCSEhpeXphK2pseVlXbGFsVFRG?=
 =?utf-8?B?RVhUZ2VpZ0gyWlNTbnVpTy9hNnpCNzJWZWI2OExwOGswZ2UzcnNXSlcxejRC?=
 =?utf-8?B?K2MzMExaRWJjSTl4djV3ZDRkanh2TXBqeGNRTDN4SDgrZ3lLQlpGYmdaVHpq?=
 =?utf-8?B?T04rL3NHS2VaeURIc0pRZ2laR0R6RWcwL0JGaWVwTnR4dFRKZUhLZXFJOFVu?=
 =?utf-8?B?TUlMaGhoRm1tL1VqV0p5V1hCM3lpVG04QVhLeUdFaXRnOW5iTFM1Z0xVOGFE?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ebabd4-2404-4056-8d68-08dd2fe9f682
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 13:40:06.9292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZOtyw4kgmjwjMHkPWaMXegj4urwc5vrVh0YFwseOhqTyupm98303EIEuTALdDr4aKuzRi9b4y+TX33zsHT8FCn1ixADNX3uyB3hdG1v5o4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7910
X-OriginatorOrg: intel.com

From: Jesper Dangaard Brouer <hawk@kernel.org>
Date: Tue, 7 Jan 2025 18:17:06 +0100

> Awesome work! - some questions below
> 
> On 07/01/2025 16.29, Alexander Lobakin wrote:
>> Several months ago, I had been looking through my old XDP hints tree[0]
>> to check whether some patches not directly related to hints can be sent
>> standalone. Roughly at the same time, Daniel appeared and asked[1] about
>> GRO for cpumap from that tree.
>>
>> Currently, cpumap uses its own kthread which processes cpumap-redirected
>> frames by batches of 8, without any weighting (but with rescheduling
>> points). The resulting skbs get passed to the stack via
>> netif_receive_skb_list(), which means no GRO happens.
>> Even though we can't currently pass checksum status from the drivers,
>> in many cases GRO performs better than the listified Rx without the
>> aggregation, confirmed by tests.
>>
>> In order to enable GRO in cpumap, we need to do the following:
>>
>> * patches 1-2: decouple the GRO struct from the NAPI struct and allow
>>    using it out of a NAPI entity within the kernel core code;
>> * patch 3: switch cpumap from netif_receive_skb_list() to
>>    gro_receive_skb().
>>
>> Additional improvements:
>>
>> * patch 4: optimize XDP_PASS in cpumap by using arrays instead of linked
>>    lists;
>> * patch 5-6: introduce and use function do get skbs from the NAPI percpu
>>    caches by bulks, not one at a time;
>> * patch 7-8: use that function in veth as well and remove the one that
>>    was now superseded by it.
>>
>> My trafficgen UDP GRO tests, small frame sizes:
>>
> 
> How does your trafficgen UDP test manage to get UDP GRO working?
> (Perhaps you can share test?)

I usually test as follows:

xdp-trafficgen from xdp-tools on the sender

then, on the receiver:

ethtool -K <iface> rx-udp-gro-forwarding on

No socket on the receiver, but this option enables GRO not only when
forwarding, but also when it's LOCAL_IN and there's just no socket.
Then, the UDP core drops the frame when doing sk lookup as there's no
socket.
IOW, I have the following:

* GRO gets performed
* Stack overhead is there, up to UDP lookup
* The final frame is dropped, so no userspace copy overhead.

> 
> What is the "small frame" size being used?

xdp-trafficgen currently hardcodes frame sizes to 64 bytes. I was
planning to add an option to configure frame size and send it upstream,
but never finished it yet unfortunately.

I realize that on bigger frames, the boosts won't be as big due to that
the CPU will have to calculate checksums for larger buffers. OTOH TCP
benches usually send MTU-sized buffers (+ TSO), but yet the perf is better.

> 
> Is the UDP benchmark avoiding (re)calculating the RX checksum?
> (via setting UDP csum to zero)

OH, I completely forgot about this one. I can imagine even bigger boosts
due to that CPU checksumming will disappear.

> 
>>                  GRO off    GRO on
>> baseline        2.7        N/A       Mpps
>> patch 3         2.3        4         Mpps
>> patch 8         2.4        4.7       Mpps
>>
>> 1...3 diff      -17        +48       %
>> 1...8 diff      -11        +74       %
>>
>> Daniel reported from +14%[2] to +18%[3] of throughput in neper's TCP RR
>> tests. On my system however, the same test gave me up to +100%.
>>
> 
> I can imagine that the TCP throughput tests will yield a huge
> performance boost.
> 
>> Note that there's a series from Lorenzo[4] which achieves the same, but
>> in a different way. During the discussions, the approach using a
>> standalone GRO instance was preferred over the threaded NAPI.
>>
> 
> It looks like you are keeping the "remote" CPUMAP kthread process design
> intact in this series, right?

Right, the kthread logic remains the same as before.

> 
> I think this design works for our use-case. For our use-case, we want to
> give "remote" CPU-thread higher scheduling priority.  It doesn't matter
> if this is a kthread or threaded-NAPI thread, as long as we can see this
> as a PID from userspace (by which we adjust the sched priority).
> 
> Great to see this work progressing again :-)))
> --Jesper

Thanks,
Olek

