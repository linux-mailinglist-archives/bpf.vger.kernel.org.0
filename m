Return-Path: <bpf+bounces-44011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AC29BC4E1
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 06:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BFBEB21F1B
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 05:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A4C1C231D;
	Tue,  5 Nov 2024 05:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0kq8LPp"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE1D3C38;
	Tue,  5 Nov 2024 05:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730785684; cv=fail; b=KV5mU0fikKm9NXOW3DLcRJ4kXJfVwzuIJdy4QWagRchLtvpIQqy5vPGbe5jXZzEuDuGW1cicgaJv1wHyVAvbus0XdHb5I+hcslLS0ULRgBn3L+TpQyXsIFKktztR+dqa+mL+KwcaWFKJuQkdR5ywMMTTBYuvQi+G3FjM5cboP44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730785684; c=relaxed/simple;
	bh=nKJtk95kPMxXU/CWFCBNaycTykWpoJME0TKUXkE5QAk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OOrtUfM1XV1l0mdTDFGNfGoxch9HtLdpJBSxyesw/ECYuSWGsXBxdtjVFoFk8ZDbaeXqVVQLi7mWl8nTaT+EJFlqOv10aw006CKpI7Ra/EH93OZ2KtXfwsRQbw8FVOzcKQFkdv+KQf6i67Fv4BZyT/EsiK3QQJkwqeOVwqWuklI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0kq8LPp; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730785682; x=1762321682;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nKJtk95kPMxXU/CWFCBNaycTykWpoJME0TKUXkE5QAk=;
  b=k0kq8LPpTkMFId2roS7cU3WwGB2mNpdO+cARDZf5ILgjFRLzjVXeK06Q
   t0/Y1ikKWhQHtCMsQ9SVCVxBxJuYeo3+oPSI4PIt9nMu1Y9qyUClg+IVk
   GlmXB6tvNXdLmJAaL52uaC8JyTW0/AzxF26Zs+EnbNL1tBDonpNsPQhFy
   IfehSbTbuaP8L4by/DXCvI+ZJ+bc0DrMyyzurCiTcGTTzON0cg8c7kqBf
   /OBnKSUqHoFm5gnjuGkHorMF7aLH39PTQ8QgQzhs/yR4Bo5Pa1IANpN1j
   X2LxWKFF5G6lZ9/L6Crwx5vavOv9WVs7XXanUALH1GjWnOyjvHlXKb4c+
   Q==;
X-CSE-ConnectionGUID: ButzIoURQKCrVy4YdD+4aA==
X-CSE-MsgGUID: MnxpGCQ/S8miKN/O6EfH6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30361035"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30361035"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 21:47:59 -0800
X-CSE-ConnectionGUID: ihK5RBf0S6+1877eEIJiMw==
X-CSE-MsgGUID: V7bvncgwTnW5GJrzy4CezA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="121362076"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 21:47:59 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 21:47:58 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 21:47:58 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 21:47:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNnRJw6oAK0S+pBqdrfjv9pegzXzDAbYe/YqhDSyrErVbR1WYj9kK0FSSTt1NKr1IzJPDRFvmGVzIcl8Ms3TJFTJKhtei8+hHMCjp4ZfIYmOEHQUFhGQUYKa8+uPZLBr3RtJyGAVLWUsDmYrCWGUrKc7Dgyky853K/hR0v9VorceSX/bBynuWkg31boxeXgA4QrnQr6bvdjn4UHcH4ZM9OwYCc1pkvawQI11bzH1LebXPgQaFBY0diySTMjo46H3ACErrcFIsforuVGOBwUoYv4aOHsZw/jyzqpTSpvsZ2hpig47E6R/nJIOyEAy/tK3P07LbIsvB+pv5BrGYgBehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rCf3bMlobFIQOa+BXXTDo8tIRPeOBw1luWDLEgPKgA=;
 b=qzw6HDVU3IcsLK7ML5MPBBjwIWW4xNI6IgMLyq593Q0+G02SZIUrTWu27vpqJCHLHMWYglsyqPpJ/ukCLNIGvdXla/bUOejQ7G9w10LR2Dlsbk7w4HVizZqY8mMyfmkbv9gXqaZeZSzHTpHTydaBmB2her/WtrOv5z2AH4TT+6NWuiMnec/zhUav2uBs3CIFcdM6zNx8k9ziS1XNZ5jCQvwhO4aHbQTpS64SNQIxuGyiXxAdn5ahMoSzgKEqN7A8OpTuuLhmoqWV7E11D6ukFG74N+R6zGOstBpEx3W4a2GkmX0Tvw0/hcMc6TBLYoZa+R/tLYgYw8DmXYFOaFjA/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8081.namprd11.prod.outlook.com (2603:10b6:8:15c::10)
 by SA1PR11MB8473.namprd11.prod.outlook.com (2603:10b6:806:3a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 05:47:56 +0000
Received: from DS0PR11MB8081.namprd11.prod.outlook.com
 ([fe80::fdb4:464:5c8d:a54]) by DS0PR11MB8081.namprd11.prod.outlook.com
 ([fe80::fdb4:464:5c8d:a54%3]) with mapi id 15.20.8114.015; Tue, 5 Nov 2024
 05:47:56 +0000
Message-ID: <d97614cb-1798-46d2-a3b8-88fa100d9765@intel.com>
Date: Tue, 5 Nov 2024 06:47:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net-next iwl-next] net: intel: use ethtool string
 helpers
To: Rosen Penev <rosenp@gmail.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, "moderated list:INTEL ETHERNET
 DRIVERS" <intel-wired-lan@lists.osuosl.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:XDP (eXpress Data
 Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20241031211413.2219686-1-rosenp@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241031211413.2219686-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0046.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::15) To DS0PR11MB8081.namprd11.prod.outlook.com
 (2603:10b6:8:15c::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8081:EE_|SA1PR11MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: 91924698-e4a2-4d87-4b43-08dcfd5d65a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnV2VS9SYTJ3ZXp2L0poaE1YdS82UHdJbXExa0VmTmRrNXNyRjFjeWVDODdw?=
 =?utf-8?B?aGJHNVBlMmRRdHgwVStkN1paZmZsclh0OEpackJjWDkycWhQcGVSQ0hCQ2hj?=
 =?utf-8?B?dTlGNForZ2x1QW9PVkNzbUVQL01iZzQ4dWE1ajdrMEZZbElyUkt6N2JJS3Fz?=
 =?utf-8?B?dlRmZTZXQVg1a1RKcUFmUnhBb0xHYWloL2JETUZUU2FOWUY3dmRGQmJJSnpK?=
 =?utf-8?B?bDl5djEwVWc4SUZUV0RRb3pIbE9zL1BnVWtjMVl6amdVV2ZvaFc0YWdxeXVr?=
 =?utf-8?B?eTM2akx6Smp0TTlJVU5rY2FIZjY1RlZnMHhGeUhSOFpvNUJYcUtZNUZ5Njg3?=
 =?utf-8?B?d28zU3hScmN4YzdQdTlDaDlIb3FTaHhITWgwUGhVRXE4aUVsTUhWWWhlNit0?=
 =?utf-8?B?WStjSTk3OG1GcE1LSTBUeGZsNVd6ZHA4MDNjcGV2MC9VWUJSV3orRkF4Nk1U?=
 =?utf-8?B?UUpZVHNabXdqVlhBVERydEVKMFVoUlRQMDZFQzJhd09aY2ZqU2ZTcXZwQldB?=
 =?utf-8?B?RFFleFlDSzhUQlVGMGdEUlo0ZDZTTXZvNmlEUjI4RzdFbmNyeDR0d0NVc2tn?=
 =?utf-8?B?UWk5TklzNWdPaWNzc005d21VZ1BjQy9nNEtBYjUrL1VDd2U5UnNpWkJ6VjB1?=
 =?utf-8?B?M3pWNVNLbGMwYmxtNk5PUHJWSGkreFlrSjZ4eWdaMXcxZDFDTTRZZHhnQ1ZQ?=
 =?utf-8?B?YVlsNHV4WEJpa1A0dy8zT2tPT3VRUjYyMXdKRHl3d3dRYWU4RCtxc2o5eS9a?=
 =?utf-8?B?b2cxZHpiOER0aGtUUGtnOTVMWmxiYXJVOTBlWlJrbFdFeGJUYU5vVkwxK1ov?=
 =?utf-8?B?SGU0QVhpT1lnZkc2Nmk3NUQwY1dXbHRkRWF5VzFyQUh1MTNPY3VGZXFhdmNi?=
 =?utf-8?B?UXlaZXR1UFFBWGpNSDNuNW5OSnVXOUhHVFYzRHBsaGZZOVF0Q2NscCtBSlN0?=
 =?utf-8?B?TGZCT2lqbW83NXJ3dUlwcDFRLzhEcXd3cVZKTjFjOTY3NlQ2VU91VTR6MStT?=
 =?utf-8?B?eDlIVDlsT2o0UTV3a1dCRGRNNGpQMENUdFRhK1duMythYXBJYWZjUVhiSzN5?=
 =?utf-8?B?R1Jjblk1TjJWNW5IM2JKNUlyT1NPNnRDS2JnMHpSUlNxTDV6TVJjem16VHBw?=
 =?utf-8?B?WHEwTUlBclpwSXFSM2RsbGJKVEExbk1YMGI1eTJmVjFQT1hFUlVrMW90Y3RU?=
 =?utf-8?B?b1BPdlNoUGN0UnJINVNxQ0xPVm5tZDZ6NCtKZGhVcWNWazhvY2VYb3ZSRGEx?=
 =?utf-8?B?ZlpodW9aa3hQZUhieG9OTXFtTDJ6aXNtbWh3MFhlV1I2dUxWcUZ5M29aV1Zo?=
 =?utf-8?B?Y05wR3IxSHcrKy9KckZ3S1JmUGEzRHZ5VTFhR2dTNVBjMS9MUGttQ0JkRFVP?=
 =?utf-8?B?ZWsvdGY5a3JOYWw4cDZFUEI1b1JMQzdXbGViR0VidWVxS2lLYmxGNGRhQWMw?=
 =?utf-8?B?ZTVaK2lZaklBL1p1OCt5RnJjc2dSVXFpdnRCM3R1NUJvNWdXcVZzT0V4L01k?=
 =?utf-8?B?V1ZVUm9QQytDa1Q0ZVp1QlJUVm9ZWWJ0T0lkMEZtQ1p2VnVTWitlcnMzeE5t?=
 =?utf-8?B?TFh5c2ZKTnE5bmZpdnFmRWxOYkE3T2pkMVBsV1NIRENRbDlPd0puTERCUkxp?=
 =?utf-8?B?WGNmY2FvU2RBSWVQaTFvSDVUY2NnSkdjTTZLRDgxdGRyeDJScTZmeWtub052?=
 =?utf-8?B?bk8xdW55NlJsbSthWjRxenNuS0lsKytDVkdPYktUY0VmWWRKNlBvY1plRTJ6?=
 =?utf-8?Q?QAfee8szvtSRRbRG+IkaZV3FjVADd3rVpfFH/mb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8081.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm96eFgyM04xM3FJbkRtYisybmc0d2VDTDdhcE9lT28zM2tuK2pQZit0SDJo?=
 =?utf-8?B?V2FCWXlIOWVOM1VxTXJWdGxUVHdza3BvSUhVMmg4UlQ2SldiL1VRQUZiblhj?=
 =?utf-8?B?OUpIa0JJS3Q3Z3pIbmgzSkhLUzZ4bEdaSFpyTm1nQmRlWDhxZWwrL0Rmb1pN?=
 =?utf-8?B?Y2tkUGpTSGpCazdBUERDU2Z3a3dMelZFbnFOQ2JZRlNDWDZ5a2pvRGVVNGds?=
 =?utf-8?B?M3F6bG9qdGlRY09lOHkyckFSMDdBSGg0bU9lTER4Qk1hT3V0NEFOc1Z6WHFu?=
 =?utf-8?B?OFcrejdsRStFVndIaUNnSEV1a0UrNit2bU1JdmlscE84ZWtUMjhVUFF4ODUy?=
 =?utf-8?B?dloyZlUwOHltSjRSN25JbXh4dFNXdlBpRXFpVzRmOHdnd1ZEdlNwTWNzbGw3?=
 =?utf-8?B?MmtVbDQrK2ZLYTRqNWh2UmpLM3I5MzFLZVpEQlZ2Rm9CUkdNNEVkbzJHRk1F?=
 =?utf-8?B?RUJCcmpwaC9Ha3Z4THV0SGh0NFU5T1cvYk5zYVI4blQxeE8xcWRGZE9MZkNB?=
 =?utf-8?B?YSs5RGc5UWhuTHV6NlQ1MEdDRmFVV1BqNlNjTm1jem9aTVpRajgyL1J5U3pr?=
 =?utf-8?B?QXNUVGpxeWFxeGVtb2o0d1BjNDlsRjdpMlRyQWJqMjRxdW5RaFFmR3ljVW1y?=
 =?utf-8?B?YTE3MHBtQU1Keld6MHJ0Q1h4TmNEQ0JSWitDTFR0UGd5RUtDS2R1b2hhVlg4?=
 =?utf-8?B?UkErUkY4VGJ0VlpudXNNWk55NzNiRmRnR3RHb0RjZksvbS93SkNpZEhONXdi?=
 =?utf-8?B?cmZCYjhTdnY3MVZIMldiOGJoRDYyczZIMEZFRE0zZVhaNzJxV2tCaytRa01t?=
 =?utf-8?B?dUVlbnNWL2k5Vm9WeWZCekI1ZmFMZmlGN0szeEtlRW5DVWRYcURraEFXdnNu?=
 =?utf-8?B?dUhUYlE4M1lZV0xIYUljNGNYSm10YktwTzBDdUFxMHVaRHJWSXpxZHBlSTMz?=
 =?utf-8?B?blE0aGkyUGpBdFdlUUY2cFBuSlJicU1Wb3loeTRZKzNuejNWaUNQeUFhc0hx?=
 =?utf-8?B?UC9SUzA2SW54Vk0xOW5YUmRKRHlCRVZJbU5YTFQzazJKdE1iRHY2VjZvSk5W?=
 =?utf-8?B?T1U4NXh6aS9NYTlVaVh6ZFRqOWxacU54N2VmVG05TTZ3V1lhNWJqYkJiR1g0?=
 =?utf-8?B?dDlkOFVUdXBVdHFwU09LSkw4eEhhMjB3YzZBRjZ2WmpvS203bExqTTNFWkZ0?=
 =?utf-8?B?c3RjVEV3Q0tzMThFRUVQWUlYQksrdEE5bUVVTHhKdjBtaGtWVitvS2YydFRK?=
 =?utf-8?B?djVJbkwyQ3lKUFpLR0pubDl3dzBwcWNnd3pjNXhPb0NFU0ZvQlJ5VFVnWXN1?=
 =?utf-8?B?SlRUa2JFSW81anNUcGxvNjZkdmdzQjRpNDRiM1QzbFpZSXAyY0VkaWZaT1Vw?=
 =?utf-8?B?RXNrS3FrQS81QzRueVRhR2lHOVZEUjA4YkJ6czhUMEQ3NE9aQmY3b0JaRmxw?=
 =?utf-8?B?VGUyU3M3eGlCSmhETjhBL0JqV1AyMzltTzVRQUpzZ1IvWHRuVkZiS1RJeE5I?=
 =?utf-8?B?WmxVYmdTb2djOUhjQkVLTXErL3hvdzFmeVVzRVAzS1lOckFHSVRxWVdSVDFr?=
 =?utf-8?B?NCtYWk5QaWRqbDVDOUpneGo5ZlBTZUlQc0pJZndFQUY2RXlhaEhBN1g3UUZR?=
 =?utf-8?B?ajFHKzU0cTBlTWRVcHZDbzhTemNobHhiMk9SNFIzSkk1d2VsL3pYVmxIcWhw?=
 =?utf-8?B?bXhrQTVNWC9vZU44MjZLN1o4TW5JelBmSERIQWUwZFhQZkNaNXJkajdkQ0g4?=
 =?utf-8?B?V0VJTWlmazFNWkxlbUFGVVJPallyM1RXTG5XdGgrVUQ1WlJUZFVSSWhlVmRt?=
 =?utf-8?B?NUFWb1l6aTlGUWxVZHZGak5OVUdLdnBNUlZBVHI0REJSMGI3WUJ4dW5hZXNV?=
 =?utf-8?B?Tjl0eWRQanQrc3JQOTJ1Mnp1ZW9ZZUM5OTN1YkJHYndUVkxCTXJPSDRYU004?=
 =?utf-8?B?ZnhsQ3ZKZ0NiTVFudDkwQTBPeGRMOWtaZjZ5MnNLdzU3OVNOampBd2J1a1B0?=
 =?utf-8?B?Z2JYOTBuWFVuZUdGRWF4dW1wU0pDWTBMZy9iY2FGOW9GN1ZaNEZBZlpqYk9E?=
 =?utf-8?B?eGhOK2RMM0Fid25uS2p1UXMrTVJnRFRuSGRDcVBJalp6cG5YV2Z0NzBQcGlu?=
 =?utf-8?B?MEJNZ1pBS2NvRkl2MlFPVFJyVGl3QXNOK0V1L2N4bUN1MzR6bElydFhvY2w5?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91924698-e4a2-4d87-4b43-08dcfd5d65a0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8081.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 05:47:55.9708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmDXaVDkGP8YMya6q3ma+5PpQJxxiJJOWfwpt4KY9gcy8BCo5B557r+hhPMqjqn4TucLldq5DRBHRnBIFTPQ4bEY6fy5tD04mPLLbGtm/Tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8473
X-OriginatorOrg: intel.com

On 10/31/24 22:14, Rosen Penev wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer. Cleans up the code quite well.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   v3: change custom get_strings to u8** to make sure pointer increments
>   get propagated.

I'm sorry for misleading you here, or perhaps not being clear enough.

Let me restate: I'm fine with double pointer, but single pointer is also
fine, no need to change if not used.

And my biggest corncern is that you change big chunks of the code for no
reason, please either drop those changes/those drivers, or adjust to
have only minimal changes.

please fine this complain embedded in the code inline for ice, igb, igc,
and ixgbe

>   v2: add iwl-next tag. use inline int in for loops.
>   .../net/ethernet/intel/e1000/e1000_ethtool.c  | 10 ++---
>   drivers/net/ethernet/intel/e1000e/ethtool.c   | 14 +++---
>   .../net/ethernet/intel/fm10k/fm10k_ethtool.c  | 10 ++---
>   .../net/ethernet/intel/i40e/i40e_ethtool.c    |  6 +--
>   drivers/net/ethernet/intel/ice/ice_ethtool.c  | 43 +++++++++++--------
>   drivers/net/ethernet/intel/igb/igb_ethtool.c  | 35 ++++++++-------
>   drivers/net/ethernet/intel/igbvf/ethtool.c    | 10 ++---
>   drivers/net/ethernet/intel/igc/igc_ethtool.c  | 36 ++++++++--------
>   .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 32 +++++++-------
>   drivers/net/ethernet/intel/ixgbevf/ethtool.c  | 36 ++++++----------
>   10 files changed, 118 insertions(+), 114 deletions(-)
> 


> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 2924ac61300d..81da126f83db 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -1478,51 +1478,56 @@ ice_self_test(struct net_device *netdev, struct ethtool_test *eth_test,
>   }
>   
>   static void
> -__ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
> +__ice_get_strings(struct net_device *netdev, u32 stringset, u8 **data,
>   		  struct ice_vsi *vsi)
>   {
> +	const char *str;
>   	unsigned int i;
> -	u8 *p = data;
>   
>   	switch (stringset) {
>   	case ETH_SS_STATS:
> -		for (i = 0; i < ICE_VSI_STATS_LEN; i++)
> -			ethtool_puts(&p, ice_gstrings_vsi_stats[i].stat_string);
> +		for (i = 0; i < ICE_VSI_STATS_LEN; i++) {
> +			str = ice_gstrings_vsi_stats[i].stat_string;
> +			ethtool_puts(data, str);

please keep code to have "&p" where it is, instead of changing it to
data/&data

> +		}
>   
>   		if (ice_is_port_repr_netdev(netdev))
>   			return;
>   
>   		ice_for_each_alloc_txq(vsi, i) {
> -			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
> -			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
> +			ethtool_sprintf(data, "tx_queue_%u_packets", i);
> +			ethtool_sprintf(data, "tx_queue_%u_bytes", i);

ditto

>   		}
>   
>   		ice_for_each_alloc_rxq(vsi, i) {
> -			ethtool_sprintf(&p, "rx_queue_%u_packets", i);
> -			ethtool_sprintf(&p, "rx_queue_%u_bytes", i);
> +			ethtool_sprintf(data, "rx_queue_%u_packets", i);
> +			ethtool_sprintf(data, "rx_queue_%u_bytes", i);
>   		}
>   
>   		if (vsi->type != ICE_VSI_PF)
>   			return;
>   
> -		for (i = 0; i < ICE_PF_STATS_LEN; i++)
> -			ethtool_puts(&p, ice_gstrings_pf_stats[i].stat_string);
> +		for (i = 0; i < ICE_PF_STATS_LEN; i++) {
> +			str = ice_gstrings_pf_stats[i].stat_string;
> +			ethtool_puts(data, str);

tmp variable "str" makes this nicer, but is not worth changing in
otherwise big patch as this
for separate patch it will be too minor on the other hand

> +		}
>   
>   		for (i = 0; i < ICE_MAX_USER_PRIORITY; i++) {
> -			ethtool_sprintf(&p, "tx_priority_%u_xon.nic", i);
> -			ethtool_sprintf(&p, "tx_priority_%u_xoff.nic", i);
> +			ethtool_sprintf(data, "tx_priority_%u_xon.nic", i);
> +			ethtool_sprintf(data, "tx_priority_%u_xoff.nic", i);
>   		}
>   		for (i = 0; i < ICE_MAX_USER_PRIORITY; i++) {
> -			ethtool_sprintf(&p, "rx_priority_%u_xon.nic", i);
> -			ethtool_sprintf(&p, "rx_priority_%u_xoff.nic", i);
> +			ethtool_sprintf(data, "rx_priority_%u_xon.nic", i);
> +			ethtool_sprintf(data, "rx_priority_%u_xoff.nic", i);
>   		}
>   		break;
>   	case ETH_SS_TEST:
> -		memcpy(data, ice_gstrings_test, ICE_TEST_LEN * ETH_GSTRING_LEN);
> +		for (i = 0; i < ICE_TEST_LEN; i++)
> +			ethtool_puts(data, ice_gstrings_test[i]);
>   		break;
>   	case ETH_SS_PRIV_FLAGS:
>   		for (i = 0; i < ICE_PRIV_FLAG_ARRAY_SIZE; i++)
> -			ethtool_puts(&p, ice_gstrings_priv_flags[i].name);
> +			ethtool_puts(data, ice_gstrings_priv_flags[i].name);
>   		break;
>   	default:
>   		break;
> @@ -1533,7 +1538,7 @@ static void ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
>   {
>   	struct ice_netdev_priv *np = netdev_priv(netdev);
>   
> -	__ice_get_strings(netdev, stringset, data, np->vsi);
> +	__ice_get_strings(netdev, stringset, &data, np->vsi);

turns out that we gain nothing by double pointer, as @data here is
single one, I would rather revert it too

>   }
>   
>   static int
> @@ -4427,7 +4432,7 @@ ice_repr_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
>   	if (repr->ops.ready(repr) || stringset != ETH_SS_STATS)
>   		return;
>   
> -	__ice_get_strings(netdev, stringset, data, repr->src_vsi);
> +	__ice_get_strings(netdev, stringset, &data, repr->src_vsi);
>   }
>   
>   static void
> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> index ca6ccbc13954..c4a8712389af 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> @@ -123,7 +123,7 @@ static const char igb_gstrings_test[][ETH_GSTRING_LEN] = {
>   	[TEST_LOOP] = "Loopback test  (offline)",
>   	[TEST_LINK] = "Link test   (on/offline)"
>   };
> -#define IGB_TEST_LEN (sizeof(igb_gstrings_test) / ETH_GSTRING_LEN)
> +#define IGB_TEST_LEN ARRAY_SIZE(igb_gstrings_test)
>   
>   static const char igb_priv_flags_strings[][ETH_GSTRING_LEN] = {
>   #define IGB_PRIV_FLAGS_LEGACY_RX	BIT(0)
> @@ -2347,35 +2347,38 @@ static void igb_get_ethtool_stats(struct net_device *netdev,
>   static void igb_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
>   {
>   	struct igb_adapter *adapter = netdev_priv(netdev);
> -	u8 *p = data;
> +	const char *str;
>   	int i;
>   
>   	switch (stringset) {
>   	case ETH_SS_TEST:
> -		memcpy(data, igb_gstrings_test, sizeof(igb_gstrings_test));
> +		for (i = 0; i < IGB_TEST_LEN; i++)
> +			ethtool_puts(&data, igb_gstrings_test[i]);
>   		break;
>   	case ETH_SS_STATS:
>   		for (i = 0; i < IGB_GLOBAL_STATS_LEN; i++)
> -			ethtool_puts(&p, igb_gstrings_stats[i].stat_string);
> -		for (i = 0; i < IGB_NETDEV_STATS_LEN; i++)
> -			ethtool_puts(&p, igb_gstrings_net_stats[i].stat_string);
> +			ethtool_puts(&data, igb_gstrings_stats[i].stat_string);

same complains for igb as for ice

> +		for (i = 0; i < IGB_NETDEV_STATS_LEN; i++) {
> +			str = igb_gstrings_net_stats[i].stat_string;
> +			ethtool_puts(&data, str);
> +		}
>   		for (i = 0; i < adapter->num_tx_queues; i++) {
> -			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
> -			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
> -			ethtool_sprintf(&p, "tx_queue_%u_restart", i);
> +			ethtool_sprintf(&data, "tx_queue_%u_packets", i);
> +			ethtool_sprintf(&data, "tx_queue_%u_bytes", i);
> +			ethtool_sprintf(&data, "tx_queue_%u_restart", i);
>   		}
>   		for (i = 0; i < adapter->num_rx_queues; i++) {
> -			ethtool_sprintf(&p, "rx_queue_%u_packets", i);
> -			ethtool_sprintf(&p, "rx_queue_%u_bytes", i);
> -			ethtool_sprintf(&p, "rx_queue_%u_drops", i);
> -			ethtool_sprintf(&p, "rx_queue_%u_csum_err", i);
> -			ethtool_sprintf(&p, "rx_queue_%u_alloc_failed", i);
> +			ethtool_sprintf(&data, "rx_queue_%u_packets", i);
> +			ethtool_sprintf(&data, "rx_queue_%u_bytes", i);
> +			ethtool_sprintf(&data, "rx_queue_%u_drops", i);
> +			ethtool_sprintf(&data, "rx_queue_%u_csum_err", i);
> +			ethtool_sprintf(&data, "rx_queue_%u_alloc_failed", i);
>   		}
>   		/* BUG_ON(p - data != IGB_STATS_LEN * ETH_GSTRING_LEN); */
>   		break;
>   	case ETH_SS_PRIV_FLAGS:
> -		memcpy(data, igb_priv_flags_strings,
> -		       IGB_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);
> +		for (i = 0; i < IGB_PRIV_FLAGS_STR_LEN; i++)
> +			ethtool_puts(&data, igb_priv_flags_strings[i]);
>   		break;
>   	}
>   }


> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index 5b0c6f433767..7b118fb7097b 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> @@ -104,7 +104,7 @@ static const char igc_gstrings_test[][ETH_GSTRING_LEN] = {
>   	[TEST_LINK] = "Link test   (on/offline)"
>   };
>   
> -#define IGC_TEST_LEN (sizeof(igc_gstrings_test) / ETH_GSTRING_LEN)
> +#define IGC_TEST_LEN ARRAY_SIZE(igc_gstrings_test)
>   
>   #define IGC_GLOBAL_STATS_LEN	\
>   	(sizeof(igc_gstrings_stats) / sizeof(struct igc_stats))
> @@ -763,36 +763,38 @@ static void igc_ethtool_get_strings(struct net_device *netdev, u32 stringset,
>   				    u8 *data)
>   {
>   	struct igc_adapter *adapter = netdev_priv(netdev);
> -	u8 *p = data;
> +	const char *str;
>   	int i;
>   
>   	switch (stringset) {
>   	case ETH_SS_TEST:
> -		memcpy(data, *igc_gstrings_test,
> -		       IGC_TEST_LEN * ETH_GSTRING_LEN);
> +		for (i = 0; i < IGC_TEST_LEN; i++)
> +			ethtool_puts(&data, igc_gstrings_test[i]);
>   		break;
>   	case ETH_SS_STATS:
>   		for (i = 0; i < IGC_GLOBAL_STATS_LEN; i++)
> -			ethtool_puts(&p, igc_gstrings_stats[i].stat_string);
> -		for (i = 0; i < IGC_NETDEV_STATS_LEN; i++)
> -			ethtool_puts(&p, igc_gstrings_net_stats[i].stat_string);
> +			ethtool_puts(&data, igc_gstrings_stats[i].stat_string);
> +		for (i = 0; i < IGC_NETDEV_STATS_LEN; i++) {
> +			str = igc_gstrings_net_stats[i].stat_string;
> +			ethtool_puts(&data, str);
> +		}
>   		for (i = 0; i < adapter->num_tx_queues; i++) {
> -			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
> -			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
> -			ethtool_sprintf(&p, "tx_queue_%u_restart", i);
> +			ethtool_sprintf(&data, "tx_queue_%u_packets", i);
> +			ethtool_sprintf(&data, "tx_queue_%u_bytes", i);
> +			ethtool_sprintf(&data, "tx_queue_%u_restart", i);

same complains for igc as for ice and igb

>   		}
>   		for (i = 0; i < adapter->num_rx_queues; i++) {
> -			ethtool_sprintf(&p, "rx_queue_%u_packets", i);
> -			ethtool_sprintf(&p, "rx_queue_%u_bytes", i);
> -			ethtool_sprintf(&p, "rx_queue_%u_drops", i);
> -			ethtool_sprintf(&p, "rx_queue_%u_csum_err", i);
> -			ethtool_sprintf(&p, "rx_queue_%u_alloc_failed", i);
> +			ethtool_sprintf(&data, "rx_queue_%u_packets", i);
> +			ethtool_sprintf(&data, "rx_queue_%u_bytes", i);
> +			ethtool_sprintf(&data, "rx_queue_%u_drops", i);
> +			ethtool_sprintf(&data, "rx_queue_%u_csum_err", i);
> +			ethtool_sprintf(&data, "rx_queue_%u_alloc_failed", i);
>   		}
>   		/* BUG_ON(p - data != IGC_STATS_LEN * ETH_GSTRING_LEN); */
>   		break;
>   	case ETH_SS_PRIV_FLAGS:
> -		memcpy(data, igc_priv_flags_strings,
> -		       IGC_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);
> +		for (i = 0; i < IGC_PRIV_FLAGS_STR_LEN; i++)
> +			ethtool_puts(&data, igc_priv_flags_strings[i]);
>   		break;
>   	}
>   }
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index 9482e0cca8b7..b3b2e38c2ae6 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -129,7 +129,7 @@ static const char ixgbe_gstrings_test[][ETH_GSTRING_LEN] = {
>   	"Interrupt test (offline)", "Loopback test  (offline)",
>   	"Link test   (on/offline)"
>   };
> -#define IXGBE_TEST_LEN sizeof(ixgbe_gstrings_test) / ETH_GSTRING_LEN
> +#define IXGBE_TEST_LEN ARRAY_SIZE(ixgbe_gstrings_test)
>   
>   static const char ixgbe_priv_flags_strings[][ETH_GSTRING_LEN] = {
>   #define IXGBE_PRIV_FLAGS_LEGACY_RX	BIT(0)
> @@ -1409,38 +1409,40 @@ static void ixgbe_get_ethtool_stats(struct net_device *netdev,
>   static void ixgbe_get_strings(struct net_device *netdev, u32 stringset,
>   			      u8 *data)
>   {
> +	const char *str;
>   	unsigned int i;
> -	u8 *p = data;
>   
>   	switch (stringset) {
>   	case ETH_SS_TEST:
>   		for (i = 0; i < IXGBE_TEST_LEN; i++)
> -			ethtool_puts(&p, ixgbe_gstrings_test[i]);
> +			ethtool_puts(&data, ixgbe_gstrings_test[i]);

and same complains for ixgbe as the other three

[snip]

