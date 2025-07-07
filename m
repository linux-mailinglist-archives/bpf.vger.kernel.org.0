Return-Path: <bpf+bounces-62498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD058AFB583
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 16:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59218189D914
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 14:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C62298275;
	Mon,  7 Jul 2025 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EMQQshfM"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1444219F127;
	Mon,  7 Jul 2025 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896907; cv=fail; b=C6aJLpHVSdDe5KmU7f47LxrTgtkxqmud3/c3fp6a/asid/LLrR7XjXZF5nNsCvjaj0RZRhpS9qK771cANFActvio9Jw5ctOHIcR/bXPNBrm7d2PNSWfdsiGrN2B1CGjAqDn3C6rxV7aBDUzK4BdKxfNPWOLOEN2hRW+7b07qnJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896907; c=relaxed/simple;
	bh=UFYaWRQOBFkObcFxXNJ3O2+iDdJgNLJNWd1CA32FFwc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f4sjKf+i/Xr9iMmxAN/1V8GqcpWIU/KyFB2d2AP9gE508XxVwF3sCvs4D1W5w7/++X41x1fZQQ062Ki+lBi3kdwbl5q5wSi8gOxkMalj+8grCaQ7Mh3EpdElCIZDVIwdG6Cj9GCxrpJHfTsKBmxEpMr4D03YrQi6CXebCBYuGD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EMQQshfM; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751896906; x=1783432906;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UFYaWRQOBFkObcFxXNJ3O2+iDdJgNLJNWd1CA32FFwc=;
  b=EMQQshfMXFnJynq6Qbvh57EgNrHCjxs/D/CvsNwcA+7TDmDSCVi8vdQc
   RVaOdmqH691bPWSQnG92R3yD5nFdx6Y9KWDYt+8S/f6CvJpYztDJVW8ee
   cAqlKjKvYPHn38ue6Y+/GCCudwKYgMwIdrC2ZypIWmk0EPQFXkyGjtVYe
   UQGLulhVheIC/l4sp4W8owPaZ+1l7TRW5d9oL3QREIXU+bOuatSu8GHzd
   mq+ls2ri1YTJUf50FiLzydJ+/v8e746oF843M+rQjm1R1fzUmw3KHFm1F
   3PZ4cwzuZtQUqTMIeZ3DkTsFPtFUBu/+8QQXrMuh8JHwzormADde4I4ym
   Q==;
X-CSE-ConnectionGUID: 34AZuMd9SpCA69O2QDfEMg==
X-CSE-MsgGUID: oI8ocsBvQ3iOlCed+S60Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54241709"
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="54241709"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 07:01:40 -0700
X-CSE-ConnectionGUID: bEBKSZR8S2OF0zL9CxyGaQ==
X-CSE-MsgGUID: XsiV7ZV0Q+ShgzuYxu+LIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="154646969"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 07:01:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 07:01:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 7 Jul 2025 07:01:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.55)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 07:01:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LG00RYPT2kgzBkWSd8ijLC1B4JBgkkfDqApKLshxs6eQHXj4uZm7ILztTR11nlZnTD/iCMHB586k+zzrK1JER3kaartG/rj45CLZWaNbrtljLJGdhxLcDxWj/+S/VQy6XFwg2gLY47pSKOaI7CaRST6i3NXZ7Sz2rwF5Ki/VC3bIzEsh4d1T5F1AEwTa6CUdD58+DSs4M2eW/DBqY9FNPtrv3IVcQxPthoxE3WqQwt05PsXMPLcCy0C+S1VomvJobWLF3T3kBH4wv9a8P64t41TmFp0QFxXfJCu0IxIvYKEV+NnvVApHaemPnWuQGd3xPz0v5XQ/PXYHEHH6TbDAAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U49csTtogKhRTrN/qzu4NbFA7KCGyP8Ftko9aVfB4q4=;
 b=lC9k2vYWJUAhT9iZRD2VjEUBAB0yB0uKyypIHac0egWKdk1thWI/QYY6rfES4axBwXbFETtJuagypI/BrnnZoPwmMBETnG1xrH2lX8V0EdT5ETw4XEXk0nzciaZHG7Cuxnz4ID73BAO4yKuUhKL7yqglKlvbG78oNTl5skJxbM4bUMBGxCW3Scgm52i5/H/lNhiMltY5KXoM5GRhUKIEefdHsi6XXvNcbJ+XOPF5sN47a1xx3rRiBicJdaCH6SFVP/fTJgkPvXGybI1+FAn71voaq5SUvTKJ55bTBpJ4Ea+jOB/AVCAnY15sDVttdswuwKPE74gOmCzGTR+f2XPBHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY8PR11MB7947.namprd11.prod.outlook.com (2603:10b6:930:7a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Mon, 7 Jul
 2025 14:00:50 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 14:00:49 +0000
Message-ID: <d0e7fe46-1b9d-4228-bb0f-358e8360ee7b@intel.com>
Date: Mon, 7 Jul 2025 15:59:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf] xsk: fix immature cq descriptor production
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<stfomichev@gmail.com>, Eryk Kubanski <e.kubanski@partner.samsung.com>
References: <20250705135512.1963216-1-maciej.fijalkowski@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250705135512.1963216-1-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0257.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::29) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY8PR11MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: 4140d52f-c2e3-4fa5-cb1c-08ddbd5eada8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmVZS2p3T2pTVEFOcm9iSzVHSlhlTGVPL2ZsVUNjQUxOblBlbkRNVFJ4ekdI?=
 =?utf-8?B?ZVFpSWprR2podDZGRFA3b0kxTVBGV1k3cmNZMFo1eDltYjYvNFJodWY3cUxz?=
 =?utf-8?B?ZkxGUTl3WnhRRTVWOXBwdWVBMGlNQmZxQmdoQzZOR0NXeGxLem41L0xpZjYr?=
 =?utf-8?B?T2FhclVFUlhlNEdEYXA0Ti9iSDdRZnJZTVpNTnNxVFhORS9hMUpUY2hiQ2NL?=
 =?utf-8?B?N0hISFpEbExWT2piSjNvNjRzZTRZeVRRSGNCTjNaUFZxT2hFZzlaR1dYcFQw?=
 =?utf-8?B?VUNvd2hBc2pSemliM1NPcHpjU1NPQmFvRXlsUnpub0tkWEFJZXVPWUVxQjcr?=
 =?utf-8?B?MkdIbmY2ZXFOVllxTWlMejhtc2FMMForQ2NQWWMzYk9OSkh6cVdSaUZzeTJI?=
 =?utf-8?B?ek9leVZRd3JtU3U2REtYY3FaZ2JvQXhPdjd5ZlNHQlFnU1hVRkVKS2FsWXJS?=
 =?utf-8?B?YnJOUTl2UEEwWDR1MTBPU21jUkw5dWpLbzNsc2ZLeVJlQzNjb1VFNVVpeEN1?=
 =?utf-8?B?bGtDNVlOMDkwOXRUeDdTdGhlODRUejlTQUxpa0NKWklBVm9IL0E0RExHZy9G?=
 =?utf-8?B?NEkyTDd2NmxhWWJtRHZtMDdQYXM2YUx0dndQdTd6YnErVUFZZlM0L3BxQ2VZ?=
 =?utf-8?B?MDFaL1dKY0ZMQUtxYTQ1cllIdVU0UkM2V1pvMTBuZXRDa0JXQWN0bVFGZ3Ja?=
 =?utf-8?B?elZpM0NvdUFXTEd0OForM1V3cFdoVHJwajJRMERmbUJYU2g2SU1McjFhNHk4?=
 =?utf-8?B?T1d1aERDV3d0L3NKZSsxT0dDd0wvSWxBdG15U0M2TDFoVkxzNjhTK2YwanBN?=
 =?utf-8?B?RHhyV3Z1MWNWOTlxR3M5QkU2ZnZxRGFhNmhQdkVhYllMbHpxOW1ta1RQNFhp?=
 =?utf-8?B?eHBsQ0pwRDMrZ3d1WWhhY0NmelJMbXlzYkF5R1p5eG1aOGw1OWdiTXRWcFVu?=
 =?utf-8?B?QThtb2p0ZWxPQ1JuOE54bGtqSUw3QlhmeXlZbDFUT3R5VUhER3czY0dzMTgy?=
 =?utf-8?B?bXNzY1diMHY2YVk1aUtodkNsVERnZWVySWxvWDFWT0s3R0tCZlZ1a0YxQzl6?=
 =?utf-8?B?N2hiY09ucmtGdlY5MkdGeEVyZExCdzJ0TGVvbDRRYzJxVGtoZkF1cFBpcDhv?=
 =?utf-8?B?dVRiTDZGb1JYbmIyT0FRaVg1U0tPTmJwelFKbzZncU52OEJMODhlbUlncmlN?=
 =?utf-8?B?VjlrdDE4ZjNTbHZ5UWV0aTRHZE50bFJNUFlPQWhNMXZrN1B3MS83U3NLVUx4?=
 =?utf-8?B?clhSb09xUWkrRzllY1dOS200TzJtRnBsUUVrSXB6dm51SjYxQVF5K0tsY3ZM?=
 =?utf-8?B?VFJYMXJrblFWQkhwcjRFZi9nZ2RzaGMwQzJFTjR1aW1jYzExUVlMRGdBUGdt?=
 =?utf-8?B?Wm9oa0hiMkY5MnludDFjTmZkZUZnQ3JLYUoyQzZPblc3ZmpKUERUMjhKQ25h?=
 =?utf-8?B?enRzVGNHWXp6djVLa09kUllmcFlhVXA0SWtJOXpQUUF2Qm9RTjVCbmJUc1pw?=
 =?utf-8?B?S2Rac3pQZlFlNTRjdThuRmxmTC9PeVFPL1haWUpSbVNkb0d5NU1mMmtGTGFi?=
 =?utf-8?B?bHpHYWp5cTZiYyt3a0lEODdEcW9oWGx5SklKUFJPRkNPZ3VIU0lra0tWc2xz?=
 =?utf-8?B?QjZ5V2ovdDNJamxFYzJTYXpYM3dmelZQNjVOUGRUelFWcVQwZ2ZnWktsVFEy?=
 =?utf-8?B?a2VmSEZpa01Sdk1lRU1kQWFYODZ0YmFNZ0I4SmRPL1ZTVGZPbTdhRG9FUlVU?=
 =?utf-8?B?bmZtZU5XSHlEMjRhbGhnbkhvUzNMZDluLzEwaWZST1lGRENOdUZDUWFYN05p?=
 =?utf-8?B?amRqZ0E0OS8xNGVwMGZUSlN5cmtrMUhLZjBkS01GM2ZpUysvYW5uL2FldktX?=
 =?utf-8?B?cm9lVEhwTHR0eXRDSlI2YXZJZ2ZjZVhOOEE0VzN6RzdmOFhFZkNEVXhuSTY0?=
 =?utf-8?Q?7Z41AiGq4C0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGhRUlA1ZXlseFBHeCtCZ3dJVTB0OW5qTjhMSnJOZk9sTCtPZncyOVBQVjdX?=
 =?utf-8?B?WERHRUhSclhIbmpUbC9WWjJrSkRIOXBtL05JNVhXSm1NeFk1ajFxYzZGZUZK?=
 =?utf-8?B?bXUwZ1JxQzUzc3Yxd2pMc3R2K1oyc3RwbGRoSXg2M054aEFZU3JvYjFDb2hh?=
 =?utf-8?B?RVNoZEFlZW9zUGh5c0RLUmhKRVFPY0VxTUt1cUhmU3hQSW45dHJHbnkvc3U3?=
 =?utf-8?B?Y0FpekFpaVdmbWh4Um1Lc0ZEanlZcUFaL3NVNnJFQUtnYmZEZEYvQ0FEU29Q?=
 =?utf-8?B?U0w4LzBzSkExM3ZHcXBzU2QyNElqMTRoM2xRTWViZ0tEQlRaRGcxT2d1KzVa?=
 =?utf-8?B?UFRyRjltSUlncXlkUWNOaTUxRjdPMHBQU09QMStDejV0cjJFT3A2VjZSa3J3?=
 =?utf-8?B?dlhrVkJwOERjdDd0OEluY2FTNXlSc2tVby9MNlppRHpiaythcDdxcXJkMHg3?=
 =?utf-8?B?SitvSjkrZTdFYVY0Z1ExZjE3V0JmS0t2c3Q2R2dLOC93UnR0bzdZeTV2MXFV?=
 =?utf-8?B?OE9heEFFOXhHVitkZ21xM3dlb2FyZkl0UW9qcmlMbGNzNFpMUys1aHNpaWx3?=
 =?utf-8?B?VXcyY3QwWUdpQnpmVFBxZmVVeDNscmJRUnNQZXlPUDdraXgrK3pETzhHMnBq?=
 =?utf-8?B?TkVBaVBpOGxFbHowWkF1aG9xU1ZSWGdGUGh6cjZQS01HRmJiSit0SWQyTk00?=
 =?utf-8?B?WTZWZEgxSVQ3dk5oazJ3bWg2UmhIRk1PNk9GZStjQVNrQVhKR0tqU2FvV0Jq?=
 =?utf-8?B?MEJPREh6cEMxR1lPY3Vud2R5QllOT3NaSUh4a3ZzaHFwK1F6NkgzYjdQMG5V?=
 =?utf-8?B?SlJoL2VlMG1HQWxCUVBmcEk3bzNTLzQyTjUwRTd2bHRRdzJZcVN2VHE3N1Iv?=
 =?utf-8?B?NDIrWWFmSVFYWnFVK0U0cWEyOVVXTkJmOTR3UGsxc1RMSHFjbXZZMnV6Qmlw?=
 =?utf-8?B?ZnJLN3ZUSU1WYkZRZ3dieGtEVm5DMkR4d29rNVMxNm80OStTZmpoeXNOMDJr?=
 =?utf-8?B?a3VaWmYxWjFubVpUOW0xZzBCM1E5dnVuUytkUFkrTVlONkNLT0tOMmVIYUxX?=
 =?utf-8?B?VFhYeVNmUlBkM2NsVEhhelREbnJHaHA5RGFFOFJRREdmZEttdkdqQW9xa1Np?=
 =?utf-8?B?M25sNzNTVHFEQ1cvM0NCbEc0VW0zaEE4ZHU4ZEtHa0pxNmhBb25kUUFBR2ZB?=
 =?utf-8?B?RVB3Ump6d1poS0Q4d1hKRk1Od1czeGtJTTZDUFhaQ2gxRXdUanQyNlQ1Z1Z5?=
 =?utf-8?B?ZUR4NTkxSEx3UnYzVjNLTmVRSmhiYklhV1lGYjdpak4yK2VKaFdSNzg0S3Ax?=
 =?utf-8?B?QmZnSkU1NVlrSk1YS01qV0pncnZ3eWw4aEEwOGN6Vk52ZkI5UUwvVXkxRkhz?=
 =?utf-8?B?SkIrSTlWbHNiVTJnLzR6OFRuaVRzQTJ2UG9FdkRLT1N2enR6WFhRcjE2Z3ph?=
 =?utf-8?B?NFZPZ04zNUcwK20raEh1TWVOMXJ3WWh3ckdKbnczRld1bHNiYndHSktlejVk?=
 =?utf-8?B?WVExd1BNWllyTUp0aDk1REhhaXpLTjQxYjdzbnlUWXF0L2NhbWNqMWtsM3g2?=
 =?utf-8?B?bGNkT3lHbmxyVmFpQUd0M3ltbFo4eFB2SzR5UzBxQ2ZuUEw3VldKV1FpUXRG?=
 =?utf-8?B?ejRCS1Z6bXg3QUxzTnVpYnVzUVhZVHZWQ2N5N0xQc2NKVUQ0QUZwTTJOWnQ3?=
 =?utf-8?B?bXVNeWUxTk1ncG05K2tWcVpRQTdBNFJUcjdNNkxydlg5Ly9PRi81Z2FrTnY2?=
 =?utf-8?B?bm41QkhWWkNob2RDZFp1MTZGRXdPbCsyS1U2OTJ0cCtDblR0QnNOZWJ2OFRv?=
 =?utf-8?B?Z1lZUFpWVFdjd0dRakZzSzJaOXRVc2xVa2VkeHRBaGtyZDR0WTkyaEFRcEho?=
 =?utf-8?B?ZzBvWUxLVXA2eXBHd3UveDlpY2M2TEZoZlVPV09SUC9TZTJwTDFraTVsL0Jh?=
 =?utf-8?B?OVJxTXc4NXpMMS9QYVN2dU9iR2lrcGl6VXdXU1ZqMythYmFjKzlwOWJ1K3M1?=
 =?utf-8?B?aEFQS0FIYVkvaXh5WTJxOS9nNTVOMjgvVEJjNkJRY1J0T21GQno4Z1gzd0Q0?=
 =?utf-8?B?L1VUd213Z1MwYU9ycDIxR3NGeDRNT2ErQXdlbW5sMjZ4RTRnSzRQM3F6eDNX?=
 =?utf-8?B?WHBBYmdSMHhmQkw1TjF2STBlMmlLbVNtaVBPUnVqMlVuWkplNyszYW9mZENO?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4140d52f-c2e3-4fa5-cb1c-08ddbd5eada8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 14:00:49.7945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNpd7S0ZMvWZcrv5ExPb9knNefccoA6g3hxNonjrgKERYGS/X8Y0yNbmZJdT61giJEn3MPApIIh1ywrhLpK+myOxjJSn19QwZ36w+FQHAvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7947
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Sat,  5 Jul 2025 15:55:12 +0200

> Eryk reported an issue that I have put under Closes: tag, related to
> umem addrs being prematurely produced onto pool's completion queue.
> Let us make the skb's destructor responsible for producing all addrs
> that given skb used.
> 
> Commit from fixes tag introduced the buggy behavior, it was not broken
> from day 1, but rather when xsk multi-buffer got introduced.
> 
> Introduce a struct which will carry descriptor count with array of
> addresses taken from processed descriptors that will be carried via
> skb_shared_info::destructor_arg. This way we can refer to it within
> xsk_destruct_skb().
> 
> To summarize, behavior is changed from:
> - produce addr to cq, increase cq's cached_prod
> - increment descriptor count and store it on
> - (xmit and rest of path...)
>   skb_shared_info::destructor_arg
> - use destructor_arg on skb destructor to update global state of cq
>   producer
> 
> to the following:
> - increment cq's cached_prod
> - increment descriptor count, save xdp_desc::addr in custom array and
>   store this custom array on skb_shared_info::destructor_arg
> - (xmit and rest of path...)
> - use destructor_arg on skb destructor to walk the array of addrs and
>   write them to cq and finally update global state of cq producer
> 
> Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
> Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
> v1:
> https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@intel.com/
> 
> v1->v2:
> * store addrs in array carried via destructor_arg instead having them
>   stored in skb headroom; cleaner and less hacky approach;

Might look cleaner, but what about the performance given that you're
adding a memory allocation?

(I realize that's only for the skb mode, still)

Yeah we anyway allocate an skb and may even copy the whole frame, just
curious.
I could recommend using skb->cb for that, but its 48 bytes would cover
only 6 addresses =\

Headroom is no that hacky; we even place &xdp_frame there :D

> ---
>  net/xdp/xsk.c       | 79 ++++++++++++++++++++++++++++++++++-----------
>  net/xdp/xsk_queue.h | 12 +++++++
>  2 files changed, 73 insertions(+), 18 deletions(-)

[...]

> @@ -619,6 +646,12 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  			return ERR_PTR(err);
>  
>  		skb_reserve(skb, hr);
> +
> +		addrs = kzalloc(sizeof(*addrs), GFP_KERNEL);

Are you sure you can use sleeping GFP_KERNEL here, not GFP_ATOMIC?

> +		if (!addrs)
> +			return ERR_PTR(-ENOMEM);
> +
> +		xsk_set_destructor_arg(skb, addrs);
>  	}
>  
>  	addr = desc->addr;

Thanks,
Olek

