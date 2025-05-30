Return-Path: <bpf+bounces-59353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8E3AC91F4
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 17:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180F94E1305
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 15:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA91B235062;
	Fri, 30 May 2025 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y0hW54Go"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25DB1E515;
	Fri, 30 May 2025 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748617486; cv=fail; b=SBfEOZ7583Mm71uuIzOnFqzOwq0c77lL4bNpDcnkT+PVcaDoz8R4saHLS7dtaLc+0/7smuIPPwJ14SiRA5X6eyyM/w9v7AMuIdBBU4iazCnUPFSGzJp3JYVSyLdcUHtA/Qqf/XhUjXFYiHuw8jE/NIOUO8CEI3ql+zmast2EFII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748617486; c=relaxed/simple;
	bh=XGtlWz8rpm/TmZJ0sAJ5XTOCzqOaBI5TNuYCqbfqF04=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VzYMWdk+UoRixFD3xEAyeHn52JgvhrqqkF4mv23kOJ3Qh2TYM9bx/OPZMa6juYbuT3Pr6mH7lD8pe+RJ5nBqb6IfLlbK9ImYuBE4+jjAvZQekYEMwl3SjdrMeVBSz0jEYiYtPqUtnIaYLaqtmN1/TYFhYZEXwYXlExFSXvf5mss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y0hW54Go; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748617485; x=1780153485;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XGtlWz8rpm/TmZJ0sAJ5XTOCzqOaBI5TNuYCqbfqF04=;
  b=Y0hW54Go9/o+6KH9b/NAgjaRfTLif5xdKqNnfJ8aYSbRSDst9KJ3G+uP
   aKWf19lcBsXKSuHf7syk6KuJ/i39GuOefXhGIsiklngzUYIi3p4unfd+9
   ZlGqYmvtpq6VXVPfmDWbRiqy6rwLcz+ToWA+1hQup8jntF5cKbjqy4hwH
   +CTBSGtmQBBp7Qsi8W+H9cUEV1hQ7NoOfD48Kryt9BaUHunAs+MpcmTQy
   QHpqUxAF20mZuU2qqBYxelRSvHtAq3o7ysM5yfXph+wNhkG8ohBq+5HKQ
   hUmscmeINODxOB70tLkFGjjngub4a0rpqBc2shIXjOo9AbaEutOPod26v
   Q==;
X-CSE-ConnectionGUID: k37Nys4XTT+EcnkjOeZnzw==
X-CSE-MsgGUID: 5jTgSVZPQP2Cp/VqTN5jbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="60969407"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="60969407"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 08:04:43 -0700
X-CSE-ConnectionGUID: la32nLoHQjuMBSwOhSnjEA==
X-CSE-MsgGUID: ey/gLyQkSCegLudc9er4eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="143862886"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 08:04:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 30 May 2025 08:04:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 30 May 2025 08:04:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.42)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 30 May 2025 08:04:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvQ8WgowXKPWx+QOvR6YrXiksUThbvYUFnyP9WrO3J/IRjTEY+tzAn+vvC40P9406S4z1rNP1L8wT9vM6Emg5AFvesnOC84V0Zh6VCX7iuTt/sek7TDk3gm2fNA76yWAh/cAhe1RCJ2fvYel3wNB3zl9rHqs+6TDm0eAd32Z8NEPFxxME0PmZGw1JnP+rPQOMFZ0A9Gu0703zyAckTb0aF1nm4bnCPEhsbyGIj75BadK5swIlsyY/IboRHUYt0VIabTe5GmuF1IMcDj3nIzcnulpits2V78qIXjV6UDG2jI4pEPPj2jgacvfefKt1zWlTrDZLfKqgNgayMcoXMobrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCCDxofQAtYyL1MnxOs9FwfR8cI1YEm4JMk6y/dxjGE=;
 b=Xrtx3aOSsjfsyqrhm8JfOA0I1NEX/pxuA9jKw7ivsi/+dO/ujqs2yaN8vpePEJXvLu6eoiT/XXKmx5unvsUJwx+WrOG7Sr8W/7Nc0OXxSsjeF6pm6jwVMMeSc9Ta6k3MiFd4nUFlLGgOKDgOdvEsZnuKs9k7lrYbDVRsei8CBDgSSjX9UtvTT3GzfEIgtZdFCrGYqCoWYlFYCm5EO0+GP8ImlNM4rsOHHk2z3Be8KiyNtCLrqGEN+taUfTqik8xYcX7OK6loPtLKvOWeXUfewARUpRqRtxhtcwE7XRJoVLa1WzMK+d0M/v7/gcG5SwR3bUL+eBjK/pQs9pu9XvjKcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV3PR11MB8507.namprd11.prod.outlook.com (2603:10b6:408:1b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Fri, 30 May
 2025 15:04:12 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 15:04:11 +0000
Message-ID: <cbe284b8-57d8-4096-a0f6-122c50b1f19a@intel.com>
Date: Fri, 30 May 2025 17:04:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 00/18] Split netmem from struct page
To: Byungchul Park <byungchul@sk.com>, <anthony.l.nguyen@intel.com>
CC: <willy@infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<kernel_team@skhynix.com>, <kuba@kernel.org>, <almasrymina@google.com>,
	<ilias.apalodimas@linaro.org>, <harry.yoo@oracle.com>, <hawk@kernel.org>,
	<akpm@linux-foundation.org>, <davem@davemloft.net>,
	<john.fastabend@gmail.com>, <andrew+netdev@lunn.ch>,
	<asml.silence@gmail.com>, <toke@redhat.com>, <tariqt@nvidia.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<david@redhat.com>, <lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>,
	<vbabka@suse.cz>, <rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<horms@kernel.org>, <linux-rdma@vger.kernel.org>, <bpf@vger.kernel.org>,
	<vishal.moola@gmail.com>
References: <20250529031047.7587-1-byungchul@sk.com>
 <20250529032903.GA14480@system.software.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250529032903.GA14480@system.software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0203.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::28) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV3PR11MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 973f97fb-8fc3-41cf-4b2a-08dd9f8b3c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1kvcUdpc1RoQ0d4MkNvQlV0SDRXSENsRHlVcHF3V2NncWNsYlEwb0ovaGJu?=
 =?utf-8?B?WjhYRlFad2tDV0IrRmN4NUNELzFJc2d2RG95bDBOc014N1dZYkdiSlpiY2FP?=
 =?utf-8?B?ODFZWWw5Nkw0SjUrTmhMTzlTY2t2aDlKYmkwY2dKYW5ldER6R2dnSHJnMHhu?=
 =?utf-8?B?TUZuWHJ6aVRMQ3NFdkMzT2RvWnYzTnlUSUdkcytOZWtldlRsR1dteXp2Qncr?=
 =?utf-8?B?L01DanllMk02WVVoNUE1SUI5RXdqMEIzUWhseE1HWW1QbDkzNVcyMktVZmtD?=
 =?utf-8?B?cVorbFVJRlJRSWhTeVNJYkJYbTBnWmhqcGhiVjFWKzJZTnpkeC9xQ0pZME82?=
 =?utf-8?B?VVY2L1ZEbXpiYkUzTm9jMHNFeGxNbVY4ZDk3ZDJBcEtFRng4b3RkTkx2eXJx?=
 =?utf-8?B?RjE0NGVrWDRNMXBBNHo3ZUVYS1ZvVXFrSE4vb00yZ2Nyd1lkbnBmNndPRTFK?=
 =?utf-8?B?MzZtQkFCN1RmN3R1M1NBTGZYRUJNeTJqdERrZUhnRDRmZU9jOS9BT0VTenJM?=
 =?utf-8?B?bUg1UzQxeDZEWWt5M1VuQjFxcVpKTnlONS92T3lLbEZZdDh1aGE2UUhERERu?=
 =?utf-8?B?OTBhdmk5bzdqK2wwYy9SWUdVWXU5M0VFZnRLd0R4MERlV2lsbEQ1RVdxSURL?=
 =?utf-8?B?RFRuUVcxTVJrT2NMWTJ5UzA0dTJyWmhHT21LOEN2dXpEby9BK3ZocnAreExm?=
 =?utf-8?B?Tnpsb20vOTVVYzV4Vm44VTJ1NXlUdHYySHZ6ZHZob2o3YmF6YTFWYTFWSEJ6?=
 =?utf-8?B?bDR4OWxPMkc3WUMxMml5RjlSVnZicVR0Q1QwZ3MvR1dnTGJOVmNCUXJndDZp?=
 =?utf-8?B?RVN5RytOZlg1OElMaisvYmJreGtMUTJDdkdVZ2xiOGU5cmxiY3E1SFBqYkhr?=
 =?utf-8?B?VUtWUEhXTjFBazluVVFxbGxhdWkwOUFuZk5hRXc3TC9JNEZya0JHM3NlYmgw?=
 =?utf-8?B?ZndLRWluZEJ2bUs1TDQyK1Y1VXhFZzVYa0dRQ3R0RWhSaFFOdC9XaTVkeDYw?=
 =?utf-8?B?VkUrTStSYllaMFh5aG8zMjJKdlMzamdqZkhkaVJXK2tZTU9DdnN0dkticGlC?=
 =?utf-8?B?Qzh4NkhnbXRBTENabVhBUFRJWm9aSUFWZ1RnWktWeFVuSnRyWXFTL2w2aDRp?=
 =?utf-8?B?T3JpNmNXdERwMEtxaTNrT0l3WE5lejN6Wmh0YXhTb3BZSFErd0RycDVzYU1i?=
 =?utf-8?B?b3JuRENwWUIvZWh5bjF2OFdiWEROcTVJN2hOa0tkNWdodXJLRTEraTdQUkZC?=
 =?utf-8?B?L1JhL2xWMjNDb1FVTCtVR2dhaHhCOUxtaFJHYkozaDRmYXpzTCtOdU1EVjEv?=
 =?utf-8?B?RmJTZEMyZ1F3dWVlbzNxSm9iYW5ZQTdsdVVvd2lZakpCckFrSVBGc2U1TmM2?=
 =?utf-8?B?c1NPb1ozeTExNkJaWGJHa29NQmQ0S0NCU0tFZUlJbkhDUEpkSmlKU1pFUk9w?=
 =?utf-8?B?RkZUcDFGV2lMak1NZmhLOXNqbHkxemh2NHVxV2k5RWNWRS9tQ05Pc0ExZ2U4?=
 =?utf-8?B?a0lJcENDSGhGblpKUW5qaTZJcUZEenFCL3JLNEJOOUNDa21zaE80Q2huRzc3?=
 =?utf-8?B?RG04OWJhK1VCTlBSbi84U2hBR1lGMFpSdVp6ZG45Qm9qOENYVWF3MjhZaXdp?=
 =?utf-8?B?bER0TlhyUlF2cUROL1ZxMFBSOUd0bzBsU29CREVNZWtHNWlSSW9QZGpOM2c5?=
 =?utf-8?B?YjBXek5zbjlLdS9pdVpVNnB1QVpsZG0xMEIwVjVpQmQyQnhLL1oyRU45Q2pk?=
 =?utf-8?B?OXRmYlh2aDVITmFRa0JBaWlJbjdHQ0pwOCtqdlc0OGVlTW11aU0xU2RtTk53?=
 =?utf-8?B?THJEMmZqUThPR2dwTDVVMm9QYmpYM1RmT2trcVFjeDFYbHo5UGdXUE9xNTl6?=
 =?utf-8?B?UmdBV1VxMy90TnNIWDZNMHBEL0hMam9UcFBWaFhKeFJpdzZwOHRUcmhQMHR2?=
 =?utf-8?Q?7jOWgpcA4bw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0lwc0dpNUZSTXY5Vmx0ZUdkQXZDTm9qR0xGY3ZuQUh0eEtyekFDdkhkUllN?=
 =?utf-8?B?dW5Obi9CblErOFJ6V0d0U0ZaYTNTbVlHODRiVDFva29JODZSd2t5K1RBbDFy?=
 =?utf-8?B?NlQxOUdJekJEcndzS1FHSm9EcnM3T2RxRWkvYmFkMVFqNkhiTGlvNmNqQ2ZR?=
 =?utf-8?B?NE1jWFBIQnk2WEpyVDY2OWZ4cWJhVUlPaURPcUFwU0ZjNFRBZGtHaWdRbldX?=
 =?utf-8?B?YjE1ODEwL3JxVnNWOGRaUkx1aW1TWVBoTTNZS3N2d01JMm1RcnZGdlE2R1RO?=
 =?utf-8?B?SHdYVXV1b053Snk5b0l4T2M1YmxPcnlzV1pDZkJLbFlYeDNCSzhkT3hvUjUr?=
 =?utf-8?B?SG5CVXRNVnpnRTV5TWo1U1hMSXdnT3NPRTJXd3lWdFRFTXR1bzNmbFA5NGxn?=
 =?utf-8?B?em4wMWhlRnZ5ald5bDZFNFdubnRmUFpBSm9JQXB2SkxNN2tlTUhuekdMbVRa?=
 =?utf-8?B?dHN1NVNXUjVYSUlYbGlENDB1QlBnZkdZVm9KOGJJeFNMWHIxMlpwQ05PVzZp?=
 =?utf-8?B?ellXVXduN0dwWFBneENCenBuNHFOWS82R1BNOG9KUFFBRWRLNzZBREprSHM2?=
 =?utf-8?B?VU5TdnV1ZjFjc1prOFZKblhOTGlvS3V2MDBqd3d2OXd6OG5VbTFIei84ZVA2?=
 =?utf-8?B?K2UwditiSHU3YTZPemZPbjBoMG81YTgrbzhpNDdzZjAwVkl6MFdncDhXNUx2?=
 =?utf-8?B?aEhKU21HTjFpWFMxbTdNVWVieFNxdTNqZVMydWdjMSs3YjN4NDJrc0JuT3BK?=
 =?utf-8?B?ek1QNyttV250MENuR3JNamYzaXY5ekFNZVBzb1ZvV3BZbDB2VlUzMGdCSXF2?=
 =?utf-8?B?b0ZXVFFRcG5TVnZZVEIzYlBncS9oNERuSWRFMVZxM0ZyM1BBRG1mV0xzQ2dB?=
 =?utf-8?B?UEl5MHp6WGVNcXFvcWF2Y3Bxb2pURXpyaDFoNVRoeWpleWUySFhEajdRN0Nl?=
 =?utf-8?B?T2haMzV2c0FVRjhnMzllVTJXcmZBSHFBTFBVZDZ1dC9Ba2FGTjR3RHhmWmth?=
 =?utf-8?B?U0U2ZjVYek1BbU1qNGh6WFhCRm1RRkxoSnc4V1lpemVoUHFFbjRyM0JxQU80?=
 =?utf-8?B?cWg5VkZzZGJLRFZKbTRnenJXVzBSdDNNWm5DL01CRUJUM2FxNzFpcDdNLzd0?=
 =?utf-8?B?L292MDhVRnRVU0c4dE5Ib3pVeUlvdEUxSUNUUjJ3ZlBvMzdvV01SdHNVbEJ5?=
 =?utf-8?B?K09HVFU1WlBQVGFhV1FpQytyMmtjYXJRMUU1QzBKd1g5R3UwdXN4RERieTls?=
 =?utf-8?B?UEVLZ29tb1F3cTJ1Nkg1NXhhcENhenFnMGxFME9LUXlhTDFWQmVFWnM5djJt?=
 =?utf-8?B?QjBkQmNJQWdEdUdqZFpiU0d4cUo4L1ZIb1hsVTMyMGdaUGM3K0ZIWlkyVStN?=
 =?utf-8?B?dWd4aWVzWnpuZFVpS1RIaG9PTlpWSW83OVVVM1N6YWsvNWJPOUZSWmU5M2hr?=
 =?utf-8?B?by9LbG9pSGltWnlpOGh5MmtYdStwbnlBTTRkVnRMdWVWK3dId2ZYUUxFREdF?=
 =?utf-8?B?VDBjdFQ1ZlFUamNGdm9tSUZQY1cwc3loQlQya3FacmFGNFlEYXBPYytXMjFB?=
 =?utf-8?B?OTVuNytSQ2ljU3VyQjVDMXFjMlJWZUJ1MnFBY3MvZnhOTzBqQXdhY0thQ2dL?=
 =?utf-8?B?Nk82TXdiU3h5aXZSdkdBLzdKcW9kNDdTR2RmVzN4TU9RRmcwTXZhVFkxRGFp?=
 =?utf-8?B?VG9jaU84RU43Y0pVazVROWRRMCtIeDM5TVR0Q0VZNklSeDFxMjlYMzZMT3pn?=
 =?utf-8?B?TTV2eWtQSHNXRytveFU1OFFDU0FOODlsWmh6WXNLZ2NhNmNoTjA4TzN4SHNs?=
 =?utf-8?B?ZitvVk9leWxKZVVJdXloQ0dTZXlvU2IvUkJCNkRJQ284QkhCQTZIajljM0Mz?=
 =?utf-8?B?ZnpKQi9rbVMzT2JqYzFyNUZwM3BPdi9JaVk1TWdQNlJERXlvMFoxNEJRTnl5?=
 =?utf-8?B?b1ZZZk12cjhkczRMTTRmRnZXMWZWOWpWbGxkVlpMZzJ2NXJ6NC9aRG5SRi85?=
 =?utf-8?B?clBjTXlacHdWQkloRkJxemM2QkNNUjNLYms2RUd6ZXR1N3IwblNTWVhDWjZC?=
 =?utf-8?B?dFFzejFmZy9kLzV6RWlUM1pubnlJU0ZDREp2N3hGeVlDSU5VRjlTSlA4WEtn?=
 =?utf-8?B?K0ZrcmE1cVpDcWNHNC9xSDZYY0hrcXhSWkdFekVSVkErU2hKYVBURENYODJv?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 973f97fb-8fc3-41cf-4b2a-08dd9f8b3c1e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 15:04:11.8768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Toe0k8hKuKvoWZmJ5ZqTmkcOzzG2TCmWb/1yjKa7w7bqB2374dZ26Gpy3lYzQIdMu7MStmaMyU864+B8UTsUzvW0BGyVE/rmgGAUoKw8C0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8507
X-OriginatorOrg: intel.com

From: Byungchul Park <byungchul@sk.com>
Date: Thu, 29 May 2025 12:29:03 +0900

> On Thu, May 29, 2025 at 12:10:29PM +0900, Byungchul Park wrote:
>> The MM subsystem is trying to reduce struct page to a single pointer.
>> The first step towards that is splitting struct page by its individual
>> users, as has already been done with folio and slab.  This patchset does
>> that for netmem which is used for page pools.
>>
>> Matthew Wilcox tried and stopped the same work, you can see in:
>>
>>    https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infradead.org/
>>
>> Mina Almasry already has done a lot fo prerequisite works by luck, he
>> said :).  I stacked my patches on the top of his work e.i. netmem.
>>
>> I focused on removing the page pool members in struct page this time,
>> not moving the allocation code of page pool from net to mm.  It can be
>> done later if needed.
>>
>> The final patch removing the page pool fields will be submitted once
>> all the converting work of page to netmem are done:
>>
>>    1. converting of libeth_fqe by Tony Nguyen.

libeth_fqe will be fully converted to netmem when this PR is accepted:
[1], see the first patch of the series.
It didn't make it into this window as Jakub had a couple last-minute
questions, but I hope it will be merged to net-next in the first couple
weeks after net-next is open.

>>    2. converting of mlx5 by Tariq Toukan.

[1]
https://lore.kernel.org/netdev/20250520205920.2134829-1-anthony.l.nguyen@intel.com

Thanks,
Olek

