Return-Path: <bpf+bounces-54699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C96A706C8
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 17:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B104188BE90
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 16:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B849625D53F;
	Tue, 25 Mar 2025 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YnXqzg1M"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F0E25A64C;
	Tue, 25 Mar 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919842; cv=fail; b=tmIBPew4tEvRlZGWc/Dtff4Sg8aRW7v/M6ZNB6odnCvLJzx4BkbsSFQaH78PaRw5h4S7WX0vNZJJUJjag04sg7P/Vn8weheGFKfQvNIJw50OUQnTYvxBE13ZdXjqR9DvZ+Boa98Uj65QpbA2sUKc90gMaIjZyvsUH4OS1qgmGno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919842; c=relaxed/simple;
	bh=pUUgTOZkxYcnh28MtqacfdbKWZjgGP62HyROMd1HuQQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LCYf8665Oaz8FsJo48M9fdDGZ61aK9wQPKO0LEzePEFUqLwMhf1HLI2zbaasmIuvazAkJDW2osXOQliX4yZZ8o+kxhQgxHSqQ2D648wHrrcFqZ2pJrxPQ4bswcl1XLGp+7V8UJQHpRVuZdWkK6rVUx/+f613WysICd35abyllUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YnXqzg1M; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742919841; x=1774455841;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pUUgTOZkxYcnh28MtqacfdbKWZjgGP62HyROMd1HuQQ=;
  b=YnXqzg1MYUvEiDKy/lWDi7XLZjYjhXsIyvXDd+MBCsgsfU9IzjOP7iaQ
   i2sA9yYgCxIpIwiHXAJSYiJOGjUAj00bTxKYjnAnT5+VYmC8BHTGyw50+
   wfOCuyu+3HaJUgVue8xmiFyRnyPDytypoPYAcTzuKnE33VnAu0vyzsnXp
   zOQNFiIWj/xqAg9LdGP0Or6KD19VAIWSU/1dAHWysisyWtPlhVkMIcYkS
   kGTi3cdFypU/5vDVmPnk5eAMUbJ5GwnEWg/AF6E73IENiKL77S4J36vEf
   Q53EKuJhOBRZ1QAvK3pbmQ5yTQsWTZiXtyZHWnyW867n096lFFIZogSdV
   w==;
X-CSE-ConnectionGUID: 1vo6C4KXRcWh6qOY5c5J0A==
X-CSE-MsgGUID: xmHieUMgR5m/9I2ab5bhtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="44103473"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="44103473"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 09:23:59 -0700
X-CSE-ConnectionGUID: OPeI/42VRKKswKxlaUteTA==
X-CSE-MsgGUID: zbx6EbwHRyqZ0jmHXotVgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="124401400"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2025 09:23:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Mar 2025 09:23:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Mar 2025 09:23:57 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Mar 2025 09:23:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoaCydx3y5/IoAfK1GOcTvACurJXfJmtQ5MwyaS3/lQybyWwGmRkeOs5UksrIOVzKMthKNYHN9KPFEJKNY7DATPBfXjRP9Q2Kyrbmh8LTYvm8VfQ+OFKrnkoVVx6Cet6ihvh/B5Ab8YhCYoSB9/cF2gdnG5UfL9o6FV56l8izeZl5wf5Hkdfg2XVTLiwvJoDiIaYqWpJx5ZCTXIAlfHJrwqkgtvI2u0z4txdl1BJNS5ixm9TVyvKU8jU6AYCJEOwuM4ErFeRMiRUGW4cAXWMy0VMVWHvgHwV4ECwy6rkLlQ8aUS/8Ew98ClcTGras0pkrjXyR3jl0RVdXtHoaVyibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADdlOlIrGiH92yj+8b0xYZe93Pcqr40IKPM/Lp/JSvw=;
 b=ssO9SM+jLrOJnJ26BdfRrTMXHxa8tBDjVlvPZ1vof7oAZu5WR/8yF2ce9fBlUjDhffQhn1TRg88+MWQm+Xpy4GV/8KxGsq/kffSgsBU3L+uJ4LrBaucJOx2UCKAcWkJOXBRks94dR7HYi1D2yi1tYecEDskGDk4EUGKvBEjaih4IFYjeDYlqtYOHlOOl3JIzBgIUpJpyZW8bfL/SNcP9k/+frl38wkbyEg5wd/PB+YOUJxxCODvNSrzlPrIVQFUJpy8HFVjB92NAwAZIhPhIk5yf7RJdSpskv+lOMKE61rIGDe3AdaPsiOEUHgevNSCaNCwHOa9SKnZ1emfKXamWOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20)
 by DS0PR11MB6472.namprd11.prod.outlook.com (2603:10b6:8:c0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Tue, 25 Mar 2025 16:23:54 +0000
Received: from CY5PR11MB6307.namprd11.prod.outlook.com
 ([fe80::1fa2:d2f9:5904:2a14]) by CY5PR11MB6307.namprd11.prod.outlook.com
 ([fe80::1fa2:d2f9:5904:2a14%6]) with mapi id 15.20.8534.042; Tue, 25 Mar 2025
 16:23:54 +0000
Message-ID: <0cee0610-19e7-4f25-9f27-86908834f36d@intel.com>
Date: Tue, 25 Mar 2025 18:23:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] igc: Fix XSK queue NAPI ID
 mapping
To: Joe Damato <jdamato@fastly.com>, <netdev@vger.kernel.org>
CC: <vitaly.lifshits@intel.com>, <avigailx.dahan@intel.com>,
	<anthony.l.nguyen@intel.com>, <stable@vger.kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	"Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, "open list:XDP (eXpress Data Path)"
	<bpf@vger.kernel.org>, "moderated list:INTEL ETHERNET DRIVERS"
	<intel-wired-lan@lists.osuosl.org>, open list <linux-kernel@vger.kernel.org>
References: <20250305180901.128286-1-jdamato@fastly.com>
Content-Language: en-US
From: Mor Bar-Gabay <morx.bar.gabay@intel.com>
In-Reply-To: <20250305180901.128286-1-jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0006.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::16) To CY5PR11MB6307.namprd11.prod.outlook.com
 (2603:10b6:930:21::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6307:EE_|DS0PR11MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df74bd8-8566-4e83-6fec-08dd6bb96f45
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjA0MjVkeVd1QXJHM2dINjJxRXJ2OTAzb1htNmd0SWRTMEdFL0VvajUwdDNm?=
 =?utf-8?B?bFFGNmFucHZ5cmxpKzd5cTBhTVJYdGlPalZSOEhTR0Uxdi9uQk1iczZQNzZ4?=
 =?utf-8?B?UTJtR3dmSWRaTWhpWW1jZkRuSWgyMEhOM2FBVUdxakI3L2hhdkhpK0pKK0ox?=
 =?utf-8?B?UmI2TEVnNis1Q21mdkhCZk9BZE5ZbWFXR0lQRTJSZ3ZEK2YzRmxQMlB6RjRs?=
 =?utf-8?B?NHpaT2NJOEJjNUx3eDNibk9oVCtqWkJkNTIyR2pLWDlpdDF1SmVUK0tTeWtT?=
 =?utf-8?B?dnV2WTg1SGNFcWtpTlVkVzZ3elJWV3kzQnVxNTBsdXlNQzBNK0VLZTZBTlJB?=
 =?utf-8?B?elFvd3N0SnFDQVpMWjFVOHNRNTl3L3NxYURLSnVRNm9oTWk2QjdpLzU4RWd6?=
 =?utf-8?B?YVJVK0lWY0tuRmJzNU13TU5Yek1mRDlWYUI3TXhlZktJcEFsUi8yK2dTSGhl?=
 =?utf-8?B?QjEvME5xbk93c2haUTZ3aitxYjJzb0hQNWMxZVdBbnpSMjRhQS9rMFpwaTFj?=
 =?utf-8?B?VVZGb2orbkZ0M2VobWplbDJKRk5TSzBycE81N0ZubWVhc0IycFN6dGFlRE9r?=
 =?utf-8?B?M0FzRWxYbWloTlB5eS91NDNVOW05bWRDYVhtVENDQktCY2dFSWlrVWQzRVR4?=
 =?utf-8?B?eFIzV1h3RENiUGRxRExYN2tlVXR1K1NoODBieU9TVWx2OXJvSlVlcHlmZWt6?=
 =?utf-8?B?L0orZlBpQ2RSUmU1OWxsTDFHdmRjNmdQL29JcVZiR3psQUdkU1IvZjZLVUxI?=
 =?utf-8?B?SnFHMDFzWnpBVVoza1A3b3BwSW5ERXBjVWNzSmVSZ3BnMDVhK1lhZFY3SGpy?=
 =?utf-8?B?NXJZYmdDY1Q0WXpiU3N5VjlWNUZLeXJzOFJTM2dzUVJMeHZsNlVzam1SeFZR?=
 =?utf-8?B?OGdibHFNbGJsTWF0NGtRaFlRSktibEdYdnhGcTQzTHNEQzdnVVg2NnU5MGhE?=
 =?utf-8?B?a2pRd3krWFpKYVlzc2txeU5oZWdsbTRacnlNMU5lOVVCQTYrKzZsY3BvR25L?=
 =?utf-8?B?OUkwOU40ZVZwR212N0xreXVtMVJKSVJDdEtzKzR6ejd3NmFnK0dXcFQ4dVo0?=
 =?utf-8?B?bjRya3FSMFJZYis5MERnOCs1b29vTWdhUkpNa3JhYS9kL0pVM2VJT3doMS93?=
 =?utf-8?B?Q3crV1c3L25VWkVJV05yZDNrdkNxcTFGUTlCSkdHR3p5L0pNTTI2ck5BaVRz?=
 =?utf-8?B?NjRCYkNpSXNaZEpxcEZaeWhad3M2U3hNd0ZSUnVWQ0Y2QlJ6OEpvZjM5MjJH?=
 =?utf-8?B?L29sYTB3azdZeGYrenpIZDM4WEJGOWFLTmhwMTVMRzZPK1hGOW4rMWp3cVA1?=
 =?utf-8?B?REgxanlDVkF0MzFWMmNEY0dFUWNxcEJPVXVJSi9HZEs4REpxQ3hXWllPRUNu?=
 =?utf-8?B?V01sSlUxVXZ2WU1QNlBGUGRRWlN4dTNrM0MyQ21FLzhxZHB6cURXQ21PSzV4?=
 =?utf-8?B?OHNkdktQbXBFK2NaT1hHbVU3bTRQMk9jSFI5RkFQZnlhdERPOFR1aDF1Q3Vw?=
 =?utf-8?B?OUNvU0ZLaFBvWUVTd1BydnZwSHBuVEtMZkQralN0Z3hHVU9mbnhSeWJZc0ZQ?=
 =?utf-8?B?MmhJYkNUU05EZDFWN0NxamtGZ2VQaWpmemc2OTNwVkQ4K3QwREVFYkpDS2Ft?=
 =?utf-8?B?aURXdzQwMlZYMjZnVmgzMndrd1pwbVZqQ1pDclA1SHhkQ3B5aTVuNFEvZlJj?=
 =?utf-8?B?bFRvYTRXeUM5Z2xYN3VHS0JnUWE2WVFQVUdNTk5RL2JXK1ZJR0E1eTkraXFF?=
 =?utf-8?B?bkNlb0IxaFNaQmF5Y1o5SWhyRjArNldUbm0yOVJxd0IwcDVvZVV0T1NQbVMx?=
 =?utf-8?B?bGFKRGE3djFKMGU0Ulh5K25XbUtGVHlOL0drQnpHNm8yS3p6eU1QYWhkZGNm?=
 =?utf-8?B?UEFtUSt1ZTVCSFQvVWN1cGZmb1hGZEhaRkRnU240YVpYUm55Mkc5MUJBS3Iw?=
 =?utf-8?Q?91Q2OntLpNA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6307.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDNGTnVLMjNiaEdPSDhWdldEWWZuWGgzOUhmY1pYeG5ydVBOTUkwdUltbXVu?=
 =?utf-8?B?ekJvN3V2bnRzZzJuRG85RDZjNHZBWTJ6ZTYvd3k0UTFvYnFWTlhuL0x4YkRm?=
 =?utf-8?B?TlJYTFFpaTcxY0lPSTRiYjh4V3AvK3JGdTdSdUhUNHV4d2d0cGtSWTVEMi9F?=
 =?utf-8?B?aUdxa3dQa3ZwQVlmR0FlMTBjMTExV2NMdUhRWUdSOUNMRTI2MVFKQkpBQ3o2?=
 =?utf-8?B?RVRtaCtwc0NzYzhqQjVqaVlLdWJyRXlUSVhsYkNCdXVDYzhNOEprRm96Mkwv?=
 =?utf-8?B?dnFQN3grczBBT3NRZ2U1aGE1Wk16dTFWUUhBYnZzOFZNUlRYem5nK2NCdms3?=
 =?utf-8?B?RnU4N1dIZEp3ZS8wZU5oeTVBbnN1VE5pcTJIMGkvRlBPWUthaWF5QW04MmFw?=
 =?utf-8?B?Q2dlaDc0Q29XT2pXbXBlanY0bzBPR0l6NGJBYWh1WFVxeFlTTk5FaVJocVI1?=
 =?utf-8?B?QnVvSTExMEtxWFJoamlaMVpNVERwNldNdXFyNzhDTHhsQXNyeUptTGFwRTBs?=
 =?utf-8?B?dzZia2d5bHRGRDFTYUN2eUNKSHpuWWI3aFlCUWJLVDgvZFFzRk91bTlkTURo?=
 =?utf-8?B?dnQ0T09PY1NidnQrYjZMSTVHYTNPOWVuNCtGKzlUR2hCa1NFbTZLYmJudE1X?=
 =?utf-8?B?dVplQ0pucXVhTE0rTkpLNEp2UjBMVG9kSGY3U3NqdDhqc0RZbHhJZ2tOeWhB?=
 =?utf-8?B?bVQ3bDVuZVg4MWR2ZkNZZGY4dGhDTUhYTmU2Uzk5VVhKeDcvb2J2cUtJSm5l?=
 =?utf-8?B?K3RZK2FCWCtrZnh3NVl1UURwQUxVcEFvUnU3SjdIb2VqUU9iSFoycVNhSEEr?=
 =?utf-8?B?MFNKT0JyL21HUWFRVFFCVTdwZnBlaWNWOW9xeGZqV3ZmSGUvWFRUWlF5Rnln?=
 =?utf-8?B?SHVWdWIvZklBOFhGb0I4ckJrSVhJRU1tc3FEcWk5VVRmbVRQc0w2bEFvUTZl?=
 =?utf-8?B?YkRaTHFvMHJRekQ2R3NPWlJYdlp1UlJwOXBneDhITGVQOUtDVkV6WGNVcjh4?=
 =?utf-8?B?WnVsVVdING5ESnFEemdua1I2RndYTzZLaE41WkZhdUlrU2xNY2J5azdBdmRI?=
 =?utf-8?B?SzVkWlh6MGJ4WjRnMXVlRHByRThoNHVmZ1RPU1luMmFhdy9SQ09oM1dXaGpl?=
 =?utf-8?B?eXFrdmEvOWplWGlhRW56TzJnN2hoMFkrS0lvRGNzaTc1eDlzUEk2VEtkME5H?=
 =?utf-8?B?aXIzUUpXTkZjYXlpNk9VSjh3TmpHd29WVWs1Sm5XdmN1NjNOZGRudksvdTlx?=
 =?utf-8?B?ZGk2aHVYSC9ScXc3Y3Q2dHdxcVo3OHk5Wk42K2NRc0ErakhkUDV4SlRWb2Fw?=
 =?utf-8?B?U0h4bWhFenN2MzhCdkFGNWtET2NFSXMyank5RVI4TlpkRU5ZUC92TXp2dkRF?=
 =?utf-8?B?M1NOYTlGUTRnUUl4S1VuV1JkcHgwVFNxN2lGRi9uN3dUZFZiWGNYNFYvRnpJ?=
 =?utf-8?B?Q3RMY3ZaeTJqazZoeEh5SXlUZXhCc0dFYitXeFM2OTI5T3BlaTlYQkFOamNV?=
 =?utf-8?B?NE9WTXhxVGErNlpBZjV2bUF0bDN5SUpuVll4NFdtMnQvQnczTFdvcUZZSVli?=
 =?utf-8?B?RTNxejVDamVBUVBTaThxMnhiemNKTG9HZkJOK29QMVNJaFhMemxLS2g3MU5v?=
 =?utf-8?B?RmhzM1FMSlVUQURPM2owSGVURTBKK3RvOG5LNnNNSnBibEd3S3ZBMUh5Z3Fj?=
 =?utf-8?B?VkU5bXgvZlBxbzVEZkd4TG9lV29OT1Fxa21aWDljVVhHN0ZzSnVWUEo5b2Zp?=
 =?utf-8?B?dkZpNXcvNmJBa3h3VVNnY2prQXVJQ2ZUUzFGa21samQvMUtKZWUyMUdxazA2?=
 =?utf-8?B?aU5yTFcveDN1QmYyNWVqQVl0Q29XUGVjc3FtZFhiQUg3Qm9qRWF6T3VTdDR5?=
 =?utf-8?B?cGg5QlVhWG5FMGZKWHdRZVhhd1FmUk5FMXVxeWZVMTlsY2hEdURGSmNOVzdQ?=
 =?utf-8?B?Y3YrdnNxeEtiRzFTQ3IwODFsc2cvaG1ZaS9jVERnaEJyUmxlV2ZXZUVSekRi?=
 =?utf-8?B?SytQUnpXRndiUjVOOC9MaDRMdWVPTW1pS1h6OGVJQ2xWMWJBMjJycGJhUG5o?=
 =?utf-8?B?enFWdUJZM2lWb3AvQjhGWFgzLzRDRnhlUFFvNjdaRFRGUm1kR1BRZS9OWi93?=
 =?utf-8?B?YmFzbmlna3NaQ2V4WGFVWUJic3FoMkxpbHZkdCtDZlQ2MTFkSmRNNUU3L2Rr?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df74bd8-8566-4e83-6fec-08dd6bb96f45
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6307.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 16:23:53.9273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PUX5UoaSxGFuMw3g3rUsVQWUPGLqYpRvwJQniZTo8XrpUZEcK0Q5yTf+3QEagK8U5NPkW+9EMsyYvsts0lGH2KqkdAPNC/Hri8gzDFJN/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6472
X-OriginatorOrg: intel.com

On 05/03/2025 20:09, Joe Damato wrote:
> In commit b65969856d4f ("igc: Link queues to NAPI instances"), the XSK
> queues were incorrectly unmapped from their NAPI instances. After
> discussion on the mailing list and the introduction of a test to codify
> the expected behavior, we can see that the unmapping causes the
> check_xsk test to fail:
> 
> NETIF=enp86s0 ./tools/testing/selftests/drivers/net/queues.py
> 
> [...]
>    # Check|     ksft_eq(q.get('xsk', None), {},
>    # Check failed None != {} xsk attr on queue we configured
>    not ok 4 queues.check_xsk
> 
> After this commit, the test passes:
> 
>    ok 4 queues.check_xsk
> 
> Note that the test itself is only in net-next, so I tested this change
> by applying it to my local net-next tree, booting, and running the test.
> 
> Cc: stable@vger.kernel.org
> Fixes: b65969856d4f ("igc: Link queues to NAPI instances")
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_xdp.c | 2 --
>   1 file changed, 2 deletions(-)
> 
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>

