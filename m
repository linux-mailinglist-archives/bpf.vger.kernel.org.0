Return-Path: <bpf+bounces-60980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F2EADF368
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 19:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D8A3A5976
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 17:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798AB2ED859;
	Wed, 18 Jun 2025 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NwaZSd0H"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564F72FEE1F;
	Wed, 18 Jun 2025 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750266359; cv=fail; b=VTyNdMQfPSEzD/YXzqd3JsMph7CeexmLvPtMSD96tvKTuMYgDFHEXtY04oANVoFyQ0aAbbw7vPSRKZjASZZuJIA/0761rSqO+/hqcvtN5a91UpKqc+nWLCKOcElHiet0oPMazkt9nTMDeLxXaPeVuJHSSAbZ13eNssQyH4L7/xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750266359; c=relaxed/simple;
	bh=AOyz4g1Cr60+1x3Lf3MDkfi1jC2a6y9rUusb1cdnrEc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NfeA5h2E6GMSw7uk+helRHQh3dCUxQONdxRKv5xfSWoT9Tg58OU0Hlz8gcKlnlJZn17dnm+FhLVv5IReESxl0K857wGNo3L3m+UqMgS8PbrGiW7VlAPs7pVQpsw2a6fEJkBg/FGaSMM7HPgGgQ1blUjIcy6VxaPO8tE8DsheT7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NwaZSd0H; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750266357; x=1781802357;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AOyz4g1Cr60+1x3Lf3MDkfi1jC2a6y9rUusb1cdnrEc=;
  b=NwaZSd0H27ll5PevHwJDHVNvGv0abmx/iqBCgKkdC7OkF/cyU+49xOrU
   2gLmi1AOIK6N/KOVhC4h3z4h8tazrOgAh1SPQIwrSAprbFAQJvoyT527K
   Nuu058XdBRncmLXf8bShTBZLEyl6YGY1/C15Obr8G84jdRxUZkIyuTvPw
   4n17wGW2LcKYjUZbSBxnIEI90lMbyWquv9ySISAnTcwSnZxCYFZb9iEgU
   JZKNVSqFhQSK+bXW/Z7oW0HI/tJQ1FLtMnPLKN/pG1d/Gt174qWy7CSPS
   WnW31ciUQUk9YejL4efKmrUnPONwzPl3ChmnpJC2ICK54EX0GwRQN473O
   A==;
X-CSE-ConnectionGUID: kdyw566xQ4au10e+G7Ki4w==
X-CSE-MsgGUID: J5Pb5DSOQsG/defkqvCDTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="51605155"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="51605155"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 10:05:55 -0700
X-CSE-ConnectionGUID: BVYY4WL2RNySOq7j9iGZPw==
X-CSE-MsgGUID: tr+1GacTS6eskw9FlY831Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="154495568"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 10:05:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 10:05:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 10:05:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 10:05:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7ezl9xWpFm1q4f4O0soCIDH4gnOIJCj92ZLwimvHCHjnNgwTnTXbNW/qHeKIviGzQOF8ewmRhQRroi19HQwWKENnxwFlQcOQ5Bbvz8lcob6/sGFFEpQZuwhlmTrQ4BSFsR5pMouIa9AJIXLSwxPw0Fo5DC538WQqsAbBMWwVcrW0w+ZQAHwf//i/NjJjLMjiItsZQar56y4Q4Qwj8d+T6csAKzkIfP4/+KC8sM9IY+lUwBAsOsax18ZkKX+c6Oy2/fltVzokNlNKGkqyW6Ov6aAmax6lelsU9MQ792oO/0vi/UwIFH1pFesB5DQGe/yCZTRU9YKypAJGeynG1lZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3B9SW+7+T8zWEsbstqQLcynXjtYvlIfNk7HbwYmUUW4=;
 b=L4HNdqGLvhnxtlGE0qCIGhBFPoDDnWzALBU3v891Jm7hpXfH0LCTbccV+i4g5pBn/7A8v2GimlZAN1M3k4R7TZnwUxCRgqpbIL2Lvd+9SnsjUEfIKRjLGq6TenUIj0jgo/EYnXPNVC0ZSLx41yTwIUD7e/NDxUgecbvsI4MjOx3gv0hR2CaAuI8cJuhbUP8hjtTZkDMMs76isXctwrL/AmxJSHLIntowvnOKcbnHZa3edoiWvtoxSDwXJY00ZmNxPQZxhiiC938s4E3G2n8zkoEgmy62mB56fvtyl5xqBlXlYSkqxBlQAB1nip/SrKkj+1X81j9EMziyjCRQyPZ5Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB7263.namprd11.prod.outlook.com (2603:10b6:8:13f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Wed, 18 Jun
 2025 17:05:36 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 17:05:36 +0000
Message-ID: <f96dc789-dad6-47d8-805d-db77ed57eb4f@intel.com>
Date: Wed, 18 Jun 2025 19:05:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ethernet: ionic: Fix DMA mapping test in
 `ionic_xdp_post_frame()`
To: Brett Creeley <bcreeley@amd.com>, Thomas Fourier
	<fourier.thomas@gmail.com>
CC: Shannon Nelson <shannon.nelson@amd.com>, Brett Creeley
	<brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Caleb Sander Mateos
	<csander@purestorage.com>, Taehee Yoo <ap420073@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20250617091842.29732-2-fourier.thomas@gmail.com>
 <3b19f145-8318-4f92-aa92-3ab160667c79@amd.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <3b19f145-8318-4f92-aa92-3ab160667c79@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P189CA0016.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::29) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: ae4c7b9e-a5d9-47f2-1c3d-08ddae8a5807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2huTmxhRDZUTm9uRWhPVmpFOERHVVRmRDZlUFlIZWVUWDI3b3FRTjIzUjRh?=
 =?utf-8?B?ekxMWklRRm1zdDZBSmpGZG5uK3g3TGpvWTZjNU5IdDltbUFLQi9vcFN0TUti?=
 =?utf-8?B?Z2lxTlA4SGdqQWk4NGJLaFpqZDJWY0tXbytBc0pHYmVqTzgvam9GRFFFR0F4?=
 =?utf-8?B?WGxTNG5FUk96R1NHa3E1R3RERVl3V3FUSUNKc2RtNmE1MG85Nm9LQmRXSU9x?=
 =?utf-8?B?NkE2NlBlZmNUSC9BNVppVk9FTHRBaFgwSjJET2tiN3M1SVV4dGRIU25ZTllx?=
 =?utf-8?B?M3ZabkZXOElPbzlDU0V3Q0o3NHBxZjBBNGx4WU1NSkFyczY0ckR3SExseVU4?=
 =?utf-8?B?cFFZNkRJckgvdk9mbjVPK1RIK0Jqc2RoNnRYNjRqMjZjOHdWdWx1QlBtVUtW?=
 =?utf-8?B?SW5MdXdjbkFMam9SaGh2SGRtZklJK0Q2SVQwVHRzNmhUVnhwUS9Rc1F0T1dh?=
 =?utf-8?B?R2s3ZU0vdUpRT0Jxa25ldmZ3dEZkb0tBd0FvbitaRklDSkNZSjVIOVZpdW5a?=
 =?utf-8?B?R242bjFIODhkK3paWWlmRFczMmhKQzI4dXBTM0w5b3QxU3pZdXptVFZ1dnMy?=
 =?utf-8?B?RWNQS2pSeUU4MEgxblRBZjg0Tm1jaFo0Y1R5eXBnSlpiTFkvQzV0VTd4TWtx?=
 =?utf-8?B?eFRJdlZoZlRrS2toY25pM1BSWG5PMzNhOFRFRjRCdk5RT1JpcFlBYXp1SnBk?=
 =?utf-8?B?WXV6OGRMNDFubDR2QnlIRkxuNlF0d28zWE1nYkdBQ0x6Zjg5bXNvaW55a21m?=
 =?utf-8?B?ZG8rYjNRaXExd0FyMEw4SUZQNkcxdkE2WUZrMXlRVVc0a3VvZDhXYUZ4Nlo5?=
 =?utf-8?B?Smp2UTE4K2FrSlh0amZoOGg3V3hmOGxYOVlEbDJKRHhVdUJGMjdWRTNxWW8r?=
 =?utf-8?B?U0V2WFp6TVBVZVlRNWR6ejAvdkpWRHVOMU1HbTBJdDkrdFdkQ01kdHp2MnZJ?=
 =?utf-8?B?NG5OWFd4bDlYMzZWdzJJallRNm1iZThCNG9XMjVUOWRCcWpTc1pmSmVPM3pt?=
 =?utf-8?B?bGRaQk9LY2p0S0dLcUErTkxaS3dNcG9rMlY1cWRhZWdtcWdtRkNYWHJQbG1W?=
 =?utf-8?B?bllrT2pFWlRNQWUwbFdkaG1QMlM3L0lINlJGd2gya1cvelFQUWltK0hORTli?=
 =?utf-8?B?QUxXVmNFNkROeHd5SUIrMFlrR3NCek9QOGdMb0RBdzAybEJwMjZNSnNtYmE5?=
 =?utf-8?B?aFZNejlzeHh0Tk8ya2VsYUxXL3ZoYm5yNTU5RHNreHlPdnNHU0J4MHAvay9r?=
 =?utf-8?B?Z0JwWHVkbVdxOWlTMDErTlgyUEdqdWFQUkNidUFUUnFyMDgyclkyaGE3enVH?=
 =?utf-8?B?bnU1a0l3ejNKSVE0T3kzTWsydkhjeWR4Q3VwbGhnUGdESCtwS1E0TUYvemtP?=
 =?utf-8?B?Y05lTHdkR3RDWDVLZllGeGxKbHUxdXRVVHpYME5RYkZYbHJmNWd6MmxyK2NF?=
 =?utf-8?B?M1pCeUVydG4zQktFTk5NVldWYW9qc3NkcEQ5NTUxM0hjb0d3a3kxTlhLNmFr?=
 =?utf-8?B?UGFRbFBXVFZYcTg1QUNybHpVUHUvVXlHUElGUVFxU2hsSWU5cmxmNDBrbEZR?=
 =?utf-8?B?MGd4RWdQa1VFMHN2OXBabzN5TGttendKN1VYVm93SmI4WDhVeXZRZENzR0FI?=
 =?utf-8?B?UUR3UU5KbVZqRUp5SnV2QytHVUZWWEtsU3crUWgzK0hvcHZhSXNFbVdtN1ZQ?=
 =?utf-8?B?dUhEV2lVcUVCYTdwNml1Z0Fka0xhLzc1NVcxeXFEcXZuMzhRb3FOQlJUK3JU?=
 =?utf-8?B?UzJqV3N2cktXMlhST0MvcndicldHMjdrMVBrR0M5bUlEcU9pSjhaOFZkOUJ0?=
 =?utf-8?B?akxKM21KM05JckREMkp0dWFmaEFpcHczOGVZTXc5SnFkSmJFWTRMa09ZRGlj?=
 =?utf-8?B?TFVnNkZTaXRiUmtQc20vV2lVZHlqSGdsdnpkSmUxNHFwWWJEMU51SjhhN1VG?=
 =?utf-8?Q?+ztaBSreYSY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGxjNnlnejkramgxYzIwSU9lS1kwTmxEVHJXdDVRWVlKWEhrajgyWURBd2tt?=
 =?utf-8?B?OTVWR0pnR0FydzJrcE8wYjFJSE5MYUpUbmdoVnhSNWg0SUl5a1hQT2ZqK09N?=
 =?utf-8?B?ckJ5c3RTRXN2U1YxYzN6MXpNeVhSVm55SjVtL3htUVZTazFPTUdaVmpYTHVi?=
 =?utf-8?B?TjJvcVZQdEdKcXdxYkNnQ3loZUZmYk9KYmtLbFBKTU1oV2RYaXhFUEorckd6?=
 =?utf-8?B?eEJwYWxyOGlhdmlibHlYTFNXV0U3T1JqNXJRUnovOUdPdXhyMkJiM3BMVmZY?=
 =?utf-8?B?SW1JTkNvWnE4OVFqY21pOFBsQXNLN2NvVkRwbm0wRC9hRnU1dGtRU24zQk95?=
 =?utf-8?B?Y2V2VktJTit1MkE5UWdTZkpXTjVOMjh6U0tvT2xrUWRyanlzaXRCSzdqekQ5?=
 =?utf-8?B?TGN2Z09WdW5tMS9KVFBZeDhBK1ZzdTg2R1lLY1VZNU9uNG5oZGg2c1hidUJi?=
 =?utf-8?B?enNtRnAydFdNTWFjbEhnTEpOcTRFY0czWWpGWENqbTVoQ3Z2WmJseS9yeWlN?=
 =?utf-8?B?akoydjJZdEFFdDhabnZNeVZPejRKSlVjeU1wbW1uS2h2N0tTbkQ3OGcwVE1Y?=
 =?utf-8?B?dmVRVGdkajRBMlo5Qlp0a3FKbmVkSGc1QlZEWW9iUHdWSU42QzhWRzVzbVhZ?=
 =?utf-8?B?eTZORVZzUGk3THJQUi83ZVFFWmdRcVJmbDBZT25GUE1RMWhzd3FKYVVtODVw?=
 =?utf-8?B?UFhWZi9zYk5kZnN3YUhaS3pOYU84bDFzc3F2RTdqUkk3NjN1eHZ2cVlPYVBv?=
 =?utf-8?B?UUIwcHlrdGxmeEtZa2hHbUNyWlE3UjBsMmV1S2t1eWhhVTRwVk5KVFh4MWtS?=
 =?utf-8?B?YU80MDY1dHQ5UHRlUlhEK2JqU2x2ZEdRSTFEaEtKUXZXY05KOGVkUWdKdWNt?=
 =?utf-8?B?TzlqWVI3Q0RxQWhzcnEvTXk0Tk55emxIMzEyNmdlS0pWeTF2c3NTY1kreFJN?=
 =?utf-8?B?NzAxQlNIVk9VZ2I5RVd0S0ZSc3o4cVI3OG5vWjJXNTRYSmRkMnhldnNaMVNM?=
 =?utf-8?B?VUJkNWIvbWxQWkRwNGxPS1ZFQmxQZnI3KzNhYkFXTzdRN3VSc3NBZ1NCOXht?=
 =?utf-8?B?VVlhUytjM0JnRURhSEt5VEVwVHVCeHJpMExVUEJUSHJadDRhcVdBU0RnRVhV?=
 =?utf-8?B?Kzk4WnhsdXZETDRPSEZjbks5RjIxZDNCMVkzUlFIaWpwZWZUcEIxYkt1UG13?=
 =?utf-8?B?aFU3RVVSc2x5c01TSFdXaThkV21FbjRVQ09jNVQySnhEWnBMMzVucDlZMGFM?=
 =?utf-8?B?cUpuN09MYnhYVUhlYjFwak9WT01zOUNHa1YycE5Na3ZPc2dkMCtJbjBnOUJV?=
 =?utf-8?B?WE5lTmtrdnBqQzRDcW96bnVrU3d0ZS9PekR3QUJQUzMxTE1RZ1lQRHh5QVp2?=
 =?utf-8?B?c2ZtM0VXU1ZtdDlVTG1SMFFwOHg3eFNSMFY0bkhoMGY4aWE0U3VFZ21RRStz?=
 =?utf-8?B?RTd2NndaNHZmbHRaenNzQjRVM3FmSi9Ra2FQSmRNRERybnNzeXRqMXZ4V3ZS?=
 =?utf-8?B?Z25LTTQzZStEUmJESFFvTzlzUUpoRWdBUms5L1FDZEVIME0vRWhDSUlYN25K?=
 =?utf-8?B?cUJtaC9DazBIMzVWbldhbXZKK2pucFpCdUd2SWJJZVFuVkhiMjFVRmJwRUFL?=
 =?utf-8?B?QWlNQWVUL3hyMmlrN3lHUW9kMXI2SHg3RFEvakU1TDNsQ083SU9kUlk4S3pZ?=
 =?utf-8?B?TGtBVFg0Ynk0V1ZXYk5MTmpzWU1ydnRpa0ZRMUNlM3B5Q3JqMmlkLzEzVFlD?=
 =?utf-8?B?WW1Pd1M2anBFa1FtL0dnemJNL0lMc01waE4xaWlNcXZYaTd2blhRcnY0a05u?=
 =?utf-8?B?Nzc2VE0xQ0hMbHBreFFDbm9NcVl1eWpxdlhpY0FyYkdha2JBZ3hONEhuYnZi?=
 =?utf-8?B?NG1jSGZ4NStlZ0lYeEEvb0lITUNnNkg0dVNDa05Sbng0T2pNdlBkdDJEQTV6?=
 =?utf-8?B?dWFWTU5ZNTJqVlJJQzNiSEVsRlZkeHZoSlNZRThLYmlNMy9BQ0Y5MU5iY3Y5?=
 =?utf-8?B?SklyVUIvdDZpekIxNWdaSEVaWmJqejVJZjdQWktRbjJnMTFobXJlL0RWMmxW?=
 =?utf-8?B?QnNGUzhwYnJhU2dtRUg3MGFhZGlrL0tUaisyckRUSGthT0xXU2JNVmEzbGp1?=
 =?utf-8?B?bWZBMTNIaFBaT3JMVzBBNFpEZUk5UzA0ZGJiYmhnU3dlMDVwcThhV3BTR3Ra?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4c7b9e-a5d9-47f2-1c3d-08ddae8a5807
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 17:05:36.4839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMkLhASfFlOZFb5ANPBQ3+uJzFiHzlfDGoeI6DMZmFOHc1+HohMg4Afb7LFT6799bNaaQ8o2O3VboPixXHqA6OXLpkTxryd/4eTAtYFx6o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7263
X-OriginatorOrg: intel.com

From: Brett Creeley <bcreeley@amd.com>
Date: Tue, 17 Jun 2025 09:56:55 -0700

> On 6/17/2025 2:18 AM, Thomas Fourier wrote:
>> Caution: This message originated from an External Source. Use proper
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> The `ionic_tx_map_frag()` wrapper function is used which returns 0 or a
>> valid DMA address.  Testing that pointer with `dma_mapping_error()`could
>> be eroneous since the error value exptected by `dma_mapping_error()` is
>> not 0 but `DMA_MAPPING_ERROR` which is often ~0.
>>
>> Fixes: ac8813c0ab7d ("ionic: convert Rx queue buffers to use page_pool")
>> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
>> ---
>>   drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/
>> drivers/net/ethernet/pensando/ionic/ionic_txrx.c
>> index 2ac59564ded1..beefdc43013e 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
>> @@ -357,7 +357,7 @@ static int ionic_xdp_post_frame(struct ionic_queue
>> *q, struct xdp_frame *frame,
>>                          } else {
>>                                  dma_addr = ionic_tx_map_frag(q, frag, 0,
>>                                                              
>> skb_frag_size(frag));
>> -                               if (dma_mapping_error(q->dev,
>> dma_addr)) {
>> +                               if (!dma_addr) {
> 
> Thanks for the fix.
> 
> After looking at this and Olek's comment, I think it makes the most
> sense to return DMA_MAPPING_ERROR from ionic_tx_map_frag() and
> ionic_tx_map_single() instead of 0 on failures.
> 
> Then any callers would do the following check:
> 
>     if (unlikely(dma_addr == DMA_MAPPING_ERROR))
>         /* failure path */
> 
> Another option is always returning dma_addr regardless of success/
> failure from the ionic_tx_map* functions, but then I'd be inclined to
> use dma_mapping_error() again in the caller. This approach seems wrong
> to me, especially when CONFIG_DMA_API_DEBUG is enabled.

Yup, I'd agree that dma_mapping_error() should be used only for checking
return values of the generic DMA API functions and only once per one
mapping. Otherwise, it's fine to pass DMA_MAPPING_ERROR and test against
it directly (after dma_mapping_error() was called already).

> 
> Thanks,
> 
> Brett

Thanks,
Olek

