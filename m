Return-Path: <bpf+bounces-45181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 524069D25CA
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 13:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9341F24D4C
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 12:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5871CC898;
	Tue, 19 Nov 2024 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKBALyI8"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4CF1CC888;
	Tue, 19 Nov 2024 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019322; cv=fail; b=EDZEhWpCvizDyZdr45o04grkz9DFfdx7bL+D1sL8WnHzQffskAOsWtqgFKZMBZb6iA11HAy6/TBR+yWiJClz46vY9FcERzAHH/x/tZ4jns0GbHhZZWMDgSVaA3gJ9N0Hv+cHfbe53GAn04xKF9hexaMIo89Bdmo2Gl/AIOAGB60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019322; c=relaxed/simple;
	bh=1FWP0KIYr5QHYyMMhcBW+HeihRH0x8pwxP1qplXfLrU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QEGFvtucG75P2xLKQphGNz3QWJYrOh9zADHBUvRv7uVx7RMLio1woGWZvwzs2dCgBmWryiEkB0z9Gil+Gj5xXG30W9WyVwvLgiYy9A7Q9Z9EiwZkxH+zoTrRJDG1be8MM+6XqhaL127B9cvb5oL43fyC7jDmn/gWigiVFuc8trY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKBALyI8; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732019320; x=1763555320;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1FWP0KIYr5QHYyMMhcBW+HeihRH0x8pwxP1qplXfLrU=;
  b=MKBALyI8hjnuS7Hvtpc8xFqZp9mknyXUdTrqW3rGD8eaVscvGGNFasNO
   zTvn57A1VwdAGqMOZ4gFOBGcBZtw+3vDHmBrFP/kT3ge3KUFJ5wXdlpOG
   RuAG8CMte8vu6d0nPaj2X7JgMazX9s1bCjYkW2EBFUJWB03bOUSYwcImm
   N3xSaYkcWo/7pXuTZysfxPwZdmkEnwzRoSORKo+aZ/iNCRb2zaI1P/KH0
   gkQEUSWLDYu+lKed8QRSgiM4K+GASzoG1sg1ao8WTnVX6avZSeiglxvIv
   uKZPgLy50F2W1Bn41Gs0hSHGEWNfKnrHhtO4yxPokDgAoMSGYk5dPKAg+
   Q==;
X-CSE-ConnectionGUID: a2tPV9M1SXCY8Q7ULlm8aw==
X-CSE-MsgGUID: q284wFlCRkmhKnL5J2LoXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="31942303"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="31942303"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 04:28:39 -0800
X-CSE-ConnectionGUID: wa2fFh7bTUqnmog1zhNEJg==
X-CSE-MsgGUID: JrEQvghJS/+3k3y085lrBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="94583479"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2024 04:28:39 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Nov 2024 04:28:38 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 19 Nov 2024 04:28:38 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 04:28:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9fP4WhZEpBXyx2tWGoXUWfncpVWNdVOGbyszxHi0mnoRG8klAtbfe9QAs0qIA+NFNOcCgurfF3uAwfGEH1TtQlSxrJB5WZ7LYJBiyVXKoJcFhS53WFg0QvrUFZ7UGUObLQXvY/ZGr6vn1T/Bt9vQWpc68B8GwsvCEJuycxsuEPj/AKunun/9QjMc/ray+ktZnYH5QS4UqkCLLrOz+gk84nlUBzOZH5wINu1cx8CjWwPeuWVaHdKfW90qZJF6JU+l85R/t+3HY6SmIuZZxTThm4MBlnv1tp0t/ij6bQsJZ8DM7LvtF6RR51l6G05kCXAq251bLerTXa9YMDRshLBMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PRKNDkB8CS87VZ2vn3tzQ84cWDH3ax9bf+ky/UvoCw=;
 b=VBP4S3tfaxoXyBjqAviXeMdHhJFt6wRdxPk26Aj4RamUORMZrPvpjsN4rwfXb2qn+IpjgMfoekz41gnVT9jLTvJffHYLw8ob1xp+sd2QdMopbbxZcytMZzGZ5QjMDBSJMT5gtA0FqwNsKKhYCdFWrba1Auw+h7TG5MqPOsnC4MMIBM3NmJFiifdYqbi+ckHb12TIhQD+M7xhP8i94rBSS3YDsd7W1j6x+JgLwW1rMSqR5VuRgxfo1L8nsUr2vrZMp3Wf/gwhKwhtZLaamikHiaKM0tfT4cvJja/JGZMRmBClA5KtZAuC/RTR1aF4Hb+js2Q52Aa74F9V7U5/ffO/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA3PR11MB7611.namprd11.prod.outlook.com (2603:10b6:806:304::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 12:28:35 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 12:28:35 +0000
Message-ID: <52650a34-f9f9-4769-8d16-01f549954ddf@intel.com>
Date: Tue, 19 Nov 2024 13:28:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 00/19] xdp: a fistful of generic changes
 (+libeth_xdp)
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
 <20241115184301.16396cfe@kernel.org>
 <6738babc4165e_747ce29446@willemb.c.googlers.com.notmuch>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <6738babc4165e_747ce29446@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::13) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA3PR11MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 293b4958-6b2f-47d7-fd4a-08dd0895b002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y21Mdndiam5OUkxmNEg5bG5KdzFWc1FpSDFzZE5JTWROMnZPUlo1S0h4SStw?=
 =?utf-8?B?OTJXaUt3bUhvbzd2UG1zaEo5NnVERXZrVENlRWY0Qm5sdXZMTnp4TzJ2bDlQ?=
 =?utf-8?B?Vno3MnprWitibHlQK0xxZ25BaVBFK25UQ0VmejhVSXR3Y0RNSytWeVN0Wk5u?=
 =?utf-8?B?STFzM2QzZGFqeHhJZGdZR1JrRzFvQkxaZVBRS1ZURFdnbU1hNWlzYVBjTy9l?=
 =?utf-8?B?aC9NNzVWM1RwT0tqRFNuTzMyMXZFS3FUOTlCc2ZRUCtnK09MZXRTK0hRcjYy?=
 =?utf-8?B?WmZWWFc4S3J4bkRjeW1Fei8yU0d0VlNaY3F5WDdiaG85ZnppbVBEUkg1b2E5?=
 =?utf-8?B?SDdNSkZENVd2TlNwNTZQdFE3bXMxZHdCYnRjdUVQQzd5b1h3MURObVROc0d2?=
 =?utf-8?B?bmx0TjkwUHdZSGR5VVZnUC9ETWl3T1VMNC9VVW5ZL3pxTG54VzREdWh3d0tW?=
 =?utf-8?B?elVTTzM4ZldLNGd6bnhwTGJKblFyZlRtZnJJdHEwN0xXSUd6c3FkK2p3Qmxu?=
 =?utf-8?B?VXVyWlo2Y1R1dzF4MWNLT3Z2TVdrL0h4eVgrS3R4MFlJZ0I3cjJlZE9vcnU3?=
 =?utf-8?B?cGJyQlpxU2J4SUNnM1NRVU1MRlF5ZzBJQW1WSEkrR2JKQWdvR05oUlNyVzVU?=
 =?utf-8?B?eDJ5aE9MdElhVW43QVpodjFJdDd0MlpGa0Qvcm5wd3dMTjQ1RjI4MEZ5S3R4?=
 =?utf-8?B?ekF2Vi9qY3JJVWFycmNUbTU2SmpGZTMyeWtQNGQ5RGJXREJMOEEwR3JIWmdG?=
 =?utf-8?B?aEF1bFUwZGNwK2l2WHNBM2Z6U29zYlhNa0QvWUJIT3dpcjVHdHJoWjU0Q3lv?=
 =?utf-8?B?YllYNno5alB3eERncFZzUDVYZ3pBWUFlOWZET3JDVlcybFFsSXZ0cDhyenhw?=
 =?utf-8?B?TnJtQW53SlI2VE9KUTVtNjlaV1A0TWJjV2lhN1NxUWVBN1VtTFk0RGJhNm0y?=
 =?utf-8?B?NmF0WGVjd04xRURqaGJMQkpjL2V5cmloY0xxQmZmcVlaK3g2dWdGZm5aYWpK?=
 =?utf-8?B?dk8xbFc4RVZDODhicmtyUXZCdTUwWkhuYVNWc0Zsd3RoakVLU3Nqb3ZFSXpQ?=
 =?utf-8?B?NThQaHNuVE9rTGJ4cEVYWU1uMnB6eXVXVmFIRnVRQ0FpbVdpSUhFN2ZRNjFQ?=
 =?utf-8?B?cGdBc3BEdHprMHl2QWd0a0RhUGJCT0ZFb1RBRE9oeUwwNXpsa2ExVC9rdzBq?=
 =?utf-8?B?aGptbXJjWmY0eXFrdmgya0kxdDRVT1RvM1pxUER4YzNWSldncERsWFlBQlZt?=
 =?utf-8?B?WGFaQlBzSmpUc2pxT0llcERaNFZrRDcrY0prU0w4MGh1enRndGVSZVhYZmlD?=
 =?utf-8?B?cXdZYkNzVTBSVEZTVWVVUkZENllZb0xEdENUSWJCdTlWYjdlVGh0YnRxaXJ3?=
 =?utf-8?B?WDRGUnJnVDhFK0crSENOZk1hZEVHRTY2OENwVzNMMzZlTjFKc3kvREZNVG8x?=
 =?utf-8?B?MUdJdFJNditPS2dqWTRRMUwweEpKaWlFOXJDdWg4M1FxVTZkUWZKWjE1ekQ3?=
 =?utf-8?B?K3VHVy9kdDhmSzNoNitZV1hsd3NaTGFyYkRJTXA0L3lYMkMyc3VmQ0Z6Q0Y5?=
 =?utf-8?B?UDFJbGw3OGp5SnE5Q3QvbVlRajR5NWhybHVwRXFjZXpGY3hDaWFlM1FWU1oy?=
 =?utf-8?B?dWFnZk81T2FnN0lzVWFOTXg1M0ZYUVB5QS9nWXY1VGt6T1VlMHR4UTV1NC92?=
 =?utf-8?B?K1dncUo2OW1sbWdCQmdYZ0VKUXRYMWI2em5pbFduYWNIeUFLMWl6MGVYMTI1?=
 =?utf-8?Q?CgPqqZH44iMD728I16ukN6l/P96JWteLl9KnxvH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWpJU3MxeWcydmJ0cFZCMzBLUWV2VHM1RE4rV3NVTWJaWHBuOWFobURtRDF1?=
 =?utf-8?B?SzM4VHZReDJJVmtNQlhuT2VRT0NoSUVyU2tIY0l1c0hRTmJwUkZXMUhLSG1G?=
 =?utf-8?B?ajhvQzZSc2NweUNic1VlZDhORHh6OE5Tc3NRbTVBT21oL08zYXUyM1FkVkFy?=
 =?utf-8?B?NXVJS1pRbzFiVFRaOW5ia01iSytySTU5SHZoZmw0OWUxakVicGFjQjJBdWVx?=
 =?utf-8?B?MnV4V1Y5bXlicm5seDBwSnNlM0gvVlliR1NzbHlnV25HMU9maWtUMkt3VlIr?=
 =?utf-8?B?MFI3REU2V2ZiV2RYN2hTUWkrV0ZNZHNqS1dvSUhWbjdYbk5abGpPT1Qwb3gr?=
 =?utf-8?B?eHJiQURNbjNYcG1MWGpCUWtqVmpZeVdldmgxS3A5MWdYd21IQkdlbnk3Sktt?=
 =?utf-8?B?czIyYXczSlF5YjVnaUtWdDUweFVuVlBuVXlScWxUTEg1R0IwZWZzTkZzb3ZM?=
 =?utf-8?B?SHVNT0dKUTZPeTRSeWtleERaOEVVcVVBWk8wM1hPRDk1VkN5aldKa2dXZUpH?=
 =?utf-8?B?SnJoTkpOTjROaEZBYnhLc2orZkpZOHBFQnZZY1hWMVg1RHU1cUtIS0VaZmg0?=
 =?utf-8?B?U20vN0twVHBOd1JkVkVBZzA2Nk40c0FMd0dqSnc3UUdvWUV0bE5hK1BRVERk?=
 =?utf-8?B?V3FsU3ZXRFV6Mjd4SjlXcnhsZVI1c3Qrb1VpUWhiU3l4VGNZR1ErZVhhdDFx?=
 =?utf-8?B?dm1PU25NTHFoZmxqM0lhdWd3cWFMaExmVXpLN1Vpa3hVSTRxNzRVcWJ2NEhk?=
 =?utf-8?B?eE9UV3A2T1VTWWFaN0dYRVZjMFVvM0licGdiVDJrTFVvSGY3aVYzdGx1ZEY3?=
 =?utf-8?B?VGRlNjk2SktXbzNHU3k0Wi9pVU5qdVM3SW1qSk9yb0dmU0lMWXNpR2JIZEND?=
 =?utf-8?B?S0xxbExUdE96d042ejZ4bDZaV3A0TmdlQjI5MGVkRGFFeWVCNlo4MjVXTTFw?=
 =?utf-8?B?cVNwTUpFL3VjRWY2dnBwMWhTeVZCR3pHeSsxOS9ERjJtRndpRUF5TnI1VjNt?=
 =?utf-8?B?MkZ3bnpRZVBkNlNVMXgzZ21OZ3hCYmhNYlB2MUoreHNSMkZFcTBTQWRqVWU2?=
 =?utf-8?B?dzJEUWd4U01jV2I3LzVqZXhYUUo3bS9Tc1J4Ym82L2tJM0p0eHZ2Y296R1Zz?=
 =?utf-8?B?TjdaRURUR2l3aE93OVVjTFRENTJFZDN4MVllVG5uVS9XQ1c4bEFCRVU5bXhG?=
 =?utf-8?B?UXFRMUxXZjdzY1lyWm9mMHRqcDY1VkFDT2VhcXJDTnNqWHE2WVo5U3hvOS9w?=
 =?utf-8?B?VXJKUmZtOXYzYUMya1BzdUZiTTN4N3BaMFRKanFyQW9QbGtwZ2RpT0xFSlJH?=
 =?utf-8?B?M3Y2WlJzTmNuS04zOVF6RjdhUXBlb2ZNeitsOVZTTHU2VmpONGtWNGNtcTFn?=
 =?utf-8?B?Z0tRVHhlTWxIOGxZSjY0TDFwblNYWjFDOUJESDVXWElPMnNpY3g4Mmh3ZU1R?=
 =?utf-8?B?Uy9mbUYxWXVCeG1IbTIxbE9PTE5iMy9OU0Eza3dOeE9BT0xpU0IwYThLN2hC?=
 =?utf-8?B?bnNFNC92ZHp1YWlzTWpDaVBhMmZ6WmdUYXZScXNyRGorS0drcFZ3RXdxRVB5?=
 =?utf-8?B?THM4MXYvL0c2c3U3MzV3QzJvV1FJU0M3Ykpwd1RHZnYzYkhGUGNzdndROFNP?=
 =?utf-8?B?K3BURG9sOG9QK0JXYnFnZTBhR1VqNytFUXpaNHZnMDg2MzZlcDdsOFFyWk93?=
 =?utf-8?B?b0pLbE52Y1dtSnhFbkxNS2NBa0hBeFJNVTFJSlAzWmNqRnhwM3d1MXkvSVQ3?=
 =?utf-8?B?K2s5ajZhdndXZEYxbk03anNVcHRsSDNQWnFVdjFVcHVkU054djQrRlNBSjI3?=
 =?utf-8?B?N0x5SmVEZWY0ZnhMdlJzMHRqT0NBS1pwWGNrWkpJWVRsblJUUlVJcjlaOWoy?=
 =?utf-8?B?b3ErM2d4SHo4YXQxYU5hZ051WXFEQ2hWdVJtYk5jelJkTXhZK0MrcUpEbTR4?=
 =?utf-8?B?b1k1UTdmSUdJaG1NTnA4a3lUM0ZtamxScjVvdWxya09JczhSSmo4RkljZ1Fa?=
 =?utf-8?B?VnV0aDVTR2orc1J6clJ6L3VsMXpuejYxUThxRFpmQ0NCRS9qWEg5SXZvWnZv?=
 =?utf-8?B?SEpia2p6Vm9kaFZOaWtJL0VLT1dpb3QzUndyYTFZM3ByR3dtWFdScFBNZ3A3?=
 =?utf-8?B?Ri91cEpqcDNncVMva0YxSjRtTVEvNDEvNG0xa3VnU2k1b1JsWFRONnVWK1JC?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 293b4958-6b2f-47d7-fd4a-08dd0895b002
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 12:28:35.4776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPXMdsdXwSIMzcBlInb+pXT3C5DAvyKw+dEQbMPal7OCwy3g2QXSMI2MZIBKVyFO//v+40wfxmEQuNWFuJ25a9woQ/jVt9S3mv3t9rbbFYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7611
X-OriginatorOrg: intel.com

From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sat, 16 Nov 2024 10:31:08 -0500

> Jakub Kicinski wrote:
>> On Wed, 13 Nov 2024 16:24:23 +0100 Alexander Lobakin wrote:
>>> Part III does the following:
>>> * does some cleanups with marking read-only bpf_prog and xdp_buff
>>>   arguments const for some generic functions;
>>> * allows attaching already registered XDP memory model to Rxq info;
>>> * allows mixing pages from several Page Pools within one XDP frame;
>>> * optimizes &xdp_frame structure and removes no-more-used field;
>>> * adds generic functions to build skbs from xdp_buffs (regular and
>>>   XSk) and attach frags to xdp_buffs (regular and XSk);
>>> * adds helper to optimize XSk xmit in drivers;
>>> * extends libeth Rx to support XDP requirements (headroom etc.) on Rx;
>>> * adds libeth_xdp -- libeth module with common XDP and XSk routines.
>>
>> This clearly could be multiple series, please don't go over the limit.
> 
> Targeting different subsystems and thus reviewers. The XDP, page_pool
> and AF_XDP changes might move faster on their own.

Reviewers for page_pool, XDP and XSk (no idea why everyone name it
AF_XDP) are 90% time the same people.
Often times, you can't avoid cross-subsystem patches. These three are
closely tied to each other.

> 
> If pulling those out into separate series, that also allows splitting
> up the last patch. That weighs in at 3481 LoC, out of 4400 for the
> series.

1500 of which is kdoc if you read the cover letter.

libeth_xdp depends on every patch from the series. I don't know why you
believe this might anyhow move faster. Almost the whole series got
reviewed relatively quickly, except drivers/intel folder which people
often tend to avoid.

I remind you that the initial libeth + iavf series (11 patches) was
baking on LKML for one year. Here 2 Chapters went into the kernel within
2 windows and only this one (clearly much bigger than the previous ones
and containing only generic changes in contrary to the previous which
had only /intel code) didn't follow this rule, which doesn't
unnecessarily mean it will stuck for too long.

(+ I clearly mentioned several times that Chapter III will take longer
 than the rest and each time you had no issues with that)

> 
> The first 3 patches are not essential to IDFP XDP + AF_XDP either.

You don't seem to read the code. libeth_xdp won't even build without them.
I don't believe the model taken by some developers (not spelling names
loud) "let's submit minimal changes and almost draft code, I promise
I'll create a todo list and will be polishing it within next x years"
works at all, not speaking that it may work better than sending polished
mature code (I hope it is).

> The IDPF feature does not have to not depend on them.
> 
> Does not matter for upstream, but for the purpose of backporting this
> to distro kernels, it helps if the driver feature minimizes dependency
> on core kernel API changes. If patch 19 can be made to work without

OOT style of thinking.
Minimizing core changes == artificial self-limiting optimization and
functionality potential.
New kernels > LTSes and especially custom kernels which receive
non-upstream (== not officially supported by the community) feature
backports. Upstream shouldn't sacrifice anything in favor of those, this
way we end up one day sacrificing stuff for out-of-tree drivers (which I
know some people already try to do).

> some of the changes in 1..18, that makes it more robust from that PoV.

No it can't, I thought people first read the code and only then comment,
otherwise it's just wasting time.

Thanks,
Olek

