Return-Path: <bpf+bounces-71406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB9BBF2228
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 17:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647A04272F3
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 15:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DC526C39B;
	Mon, 20 Oct 2025 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eXQEQdhV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4618224B09;
	Mon, 20 Oct 2025 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974579; cv=fail; b=IvmDxKDN2OLzqnaik62eZWodic7drMvMckGk0EhDxdos+0KukC26GS+gKwt/NwAmhrB92M1rlkaK+0V5zQbmW+NpjfbAN1c7H6tCO2zbhfD1ilUFV6Jj0BJutxKRet/BJOkutE76cXZib4KI8q0r7AkGgo9f5187trSXttCgQSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974579; c=relaxed/simple;
	bh=5MHtD2vGd/RNDUFXRTJOXRUz5ll+8GUVWxzExpTrZ64=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ba2O5Z42XxdG0UPfdUCjOyVGF+/PqQ559c+xohyn7p79yPgsfxjJP9RnMjMC1WXu3Jtta4LQS/MSGvnmYcb21bw0eUPADHKszHpw9GCmxD2o7+CVyNRDeg1apqFewCLj9iiLyiXyzaw4fg2UlIXZrW/CIfZQSai9SHWNneQAymU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eXQEQdhV; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760974578; x=1792510578;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5MHtD2vGd/RNDUFXRTJOXRUz5ll+8GUVWxzExpTrZ64=;
  b=eXQEQdhV+cXwVRpnIwrrSPFeVCv6ibXbwCFwtO4mU8HEtq7H+8oLkJc9
   8qohncqmUdPGs1n7wH3vosZmdc0vyO/AyK3he4FMCkIS+yXPZ0YsJZ4w6
   jYxz3W79j/ygOW6cAg9MQQ2+ZcW/+3HbvVc0RklXavLNwH46ELhjHE1V2
   K+ncXiI9mI71lWhvAnus/JcwMFllcdLgYa4fQOse2ZEVifF+NwX/Q3rjJ
   DwGnxl8m1x0qWnFbQafuXTLXCtL+cGU0ql/miu0WkgJDmr9KAb5wD7O9h
   gNgM3vCMa4UtjaTUqSiDjEK/meFgytnVz+Q5TizMVk9j0owPmgBXQhzUL
   w==;
X-CSE-ConnectionGUID: 0xLziV37SlO7VTk3GbUAcw==
X-CSE-MsgGUID: 36aT7W9lTNqfJvrGi1zIGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66954089"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="66954089"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 08:36:17 -0700
X-CSE-ConnectionGUID: UHmRdo2PSX+yH8wxDd+YoQ==
X-CSE-MsgGUID: XLdrfp69S6i/y2lszESeZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="213970871"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 08:36:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 08:36:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 08:36:15 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.12)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 08:36:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTh8TNjX1M0PwgtpC++BVdDhgSLLUF3+OLeuUvuik9bx9Q2yV0tZdOJvlxQ2kWH2SvL+6bRJURUkf1zWKBCwY85g4CoEVe1pXkmqCRqmNBZrD9lHRCAzHkYaIS3z3pIAzWsEGFFw6hQHFhtb8+F4f4qnEOOfnjjR/vuiQfih30tw7r/5QwcDC248l/0x0CcJE6yvp2ed869FVeZ+Dn9VYr7n/l0e1UQELJZ7JJChWniLGxHhbhzpFAFfRErpLU7LhtVSjQqDLLXyBVHVcc6Odv1hmBJx7cJpESPJwX/qMjkoxkItaKwVZkXLMkmpSSrahemMz0g9CT404km+oGz3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aI08fZWxaRcIQ2647LdZj8M0fD/ZpEqftsYK5fY9VWM=;
 b=bftI0mHkpdGOuCehLf0DwskejAG4wKjNdLNWf6AR1IrxEc5Jg26mLU4r44xdJT/FiEP4xj4EGzlHcY0ORRdK5p/Lr0ZtQVkN+09a/O0HGIKcfLv+WcSY1mk60xxxTucWIEyVHZx9lf6j9xwiYQWViEJqVWvuDAGNigz8ShIx30G7S8h+PXNpzeESHLNGK1rzjwXq5HJh3sKcoYkQ/ExDq8FC6KC2BCj8jsxikiuf8Iwr6O/PeTprvqZWhA13nYQgQfLVhonY097MOKqJ3lGLHUsGIQUmwP/cS96X+RPzePrla4M81u2LHVZkmE+ucmwMtiA91JSaNxTJdV6hatLGLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB7843.namprd11.prod.outlook.com (2603:10b6:610:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 15:36:13 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 15:36:13 +0000
Message-ID: <025d2281-caf0-4f88-8f31-b0bfa5596aec@intel.com>
Date: Mon, 20 Oct 2025 17:36:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf 1/2] xdp: update xdp_rxq_info's mem type in XDP
 generic hook
To: Jesper Dangaard Brouer <hawk@kernel.org>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<ilias.apalodimas@linaro.org>, <toke@redhat.com>, <lorenzo@kernel.org>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<andrii@kernel.org>, <stfomichev@gmail.com>,
	<syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>, Ihor Solodrai
	<ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
References: <20251017143103.2620164-1-maciej.fijalkowski@intel.com>
 <20251017143103.2620164-2-maciej.fijalkowski@intel.com>
 <50cbda75-9e0c-4d04-8d01-75dc533b8bb9@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <50cbda75-9e0c-4d04-8d01-75dc533b8bb9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0081.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::34) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d34068-896a-4f97-f70e-08de0fee667a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTVVWER0Y0JxY2RTNG9vdFNQZURLTXFQVnR3T0hWMHE4Rkdja05nZDdzVnZn?=
 =?utf-8?B?ekxHbHhQOWJhbVF5aEtvaGxBL3UrbmNmMWVxMzUwK2tFajc1VzhIemhvMCti?=
 =?utf-8?B?QTNBc1JiRFBTZ2puZ0JwbHV6UGl2c0MzTCtYY3BJZXIzUDVBL1d6QTgrdTFU?=
 =?utf-8?B?Y1ZQV1ZRSjFaZDlqZUhrV1NWR3Jwdy9lK1RPWGhPZGRoeVN3OHRkZEFnQW5V?=
 =?utf-8?B?QytxTmwxbzRSeSt0YnljRkoxRzJySno1eFZ5OFdlK2lhRVdDWHZIUFZCaURB?=
 =?utf-8?B?czlzcUpYRUVoN3Urbi9wM1Z0NGRQeFFsZXdSMzdnY0puTlJDMWJIa204UlRE?=
 =?utf-8?B?aXo0SCtLNkJNaDJBamtOTkhkTFduOTVvb2M5dmtFZE9HaENjY0lsbkwyRWdv?=
 =?utf-8?B?eGxhTTZ6L2lYZWlKazFLdTVjNTF1Q2drb2NtS0UxU1lIRnpKNk9DUnArVkcx?=
 =?utf-8?B?Q0haZ05mTEFWT2ZKK0drTTEvWEphOE41TmhTcHZMUytWeEp0M1FDakRSeFoy?=
 =?utf-8?B?THQxdHVLNjBkL245Z2E2Mk1peHpQY3RZTW1vajFmclBUcnZOYXdaMGgxYkI1?=
 =?utf-8?B?T2JmdFhwTHlDMERBVFZCQUJ3SUsydThrcithUG1QMWViSUxCeG4vc3VsWGs0?=
 =?utf-8?B?bzRsbGcyaHNISkdFVjhEUnNHMUxhVXpsMTRPMUVqS2U2WnZGOUlZM0tNL2l5?=
 =?utf-8?B?R0N1eGxtdlJSbHVzaUEybmVqbUVtMmZEWk5mV1M0MDk2dzk2NkN6d0d1M25U?=
 =?utf-8?B?Wk5uVENBT2cyMXA1blBxNDhuR2licmE1WkpETGZJYkJOekdaMGRUaytjbkY5?=
 =?utf-8?B?RDkzcjdWZHRUVXF2TkIvczNZS3l0YmlLeWF4cGdBTVJIaTV1RnM3UFA3SW5F?=
 =?utf-8?B?RzRoazhUNVFWWGRmaC85S28rMEU2Sjh5WFlCUFVDK0RPbWo1Q1lqT21Bd2sr?=
 =?utf-8?B?V2xwK1o5bFhWL0s1amE0OHR5SzFLS1o4RTBLcmhxODBjRkhEN1hxbFRnT2Ji?=
 =?utf-8?B?QjQzUlJFNkE0TElTVXAydzE4UXFRY1ZndjlaS0locGJHekNuanlZVHNTeG1z?=
 =?utf-8?B?WFA0cml5K1IxcmpHdW5YcTFKWW1DQ0tuS2FNbDRSSVBQYTZNN1pYZElIN2JQ?=
 =?utf-8?B?MzN6cXBURktlMWpPNTNXQ3J3TmJYU0dzazM5ck5kc2luOEp3VWxtYk5EUnZB?=
 =?utf-8?B?ZDhyN1RuREpTN1lqVVNjUGtjVkQyRzEzSk5Oc1pZRVRxL0c5SkxUd3IrVFhi?=
 =?utf-8?B?TGQ5ZmZCeE5KTWhYckJCK1RpR0plV0YwMm13RkhVSkxZNE9pa3hYTm5IamRR?=
 =?utf-8?B?cHJranE2TVhHQkZBOGtXQXJaRk85QWFveGRQdWRKTlFUbTF0RWorUFlLVWd1?=
 =?utf-8?B?UEhoSlVPR1ZLVmRuNDR3Q0pRZy82NE92V1pPTXB3SlNwMFRaUng4YlZnRVlH?=
 =?utf-8?B?UGpDcFo4ditqTjhGK0xEZHkxU1lxenIxZjZGand2UzNNbmF0SU9UNk9LamlY?=
 =?utf-8?B?U0tyMWlFOVl3dTBjSjlpVHZRcXdtSm5INkJoNklQZU91bDhLVDFJNDJnUERN?=
 =?utf-8?B?TG9Da3FCZ3VzOGlHRmxHMENyWC91aW5ES3J3YnQ5RFdSSHU2dnpsK3JvcERv?=
 =?utf-8?B?UlVJOVNSLysxYTNPRjNjWks5azFRVU9ScFFWVDNPdlRIc3FGRVJCZzJubk9P?=
 =?utf-8?B?QVllMzNxVnY1enZMd3BmRU1VMlQvSHBCTnZqNTVBcXd2MlJVMHIrZzdwbkFP?=
 =?utf-8?B?dTRub3RYRGtubWRLSEtLYUFBSXFlSlozbDdyL2hNYUpZYXVCcEtsbDZXMWlR?=
 =?utf-8?B?Ty9hYXBNN0pEaWVVWFpuUFNGSUQ0TzUxNlFZdzNKdlBSbHJ1WWxhRkc1ajU2?=
 =?utf-8?B?RHh2R3lybVMzYnRpSlV0V0tobHFBWmVDcnEzUDYwb04ybUpicXpXWDUwbkJK?=
 =?utf-8?Q?Clsrpa3DZk7LZ9H77UFnAv4TsIi8rqvP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enFNSVhhMFlHWjZ4SnBPaGlqK3JFazNMazhTcmhNUnJUcks5MnY5eGg2L1Y0?=
 =?utf-8?B?OXNiVzV1TnJQTE1OSHBGaUVBUE9Uc0V2NEpPVW1LZTg1M1MyWVJKMm01QXZm?=
 =?utf-8?B?eVAwdmxpaWFUMmhkZEJraEFBb041Q05XeGxxTmNNMG5TOVZyZVhUVDBvRm4x?=
 =?utf-8?B?bHBWZWxjUWw1QTNYazBZZFN5QmlFejVNNEczVEhrSERRbVhCdjBQNXpLaGx2?=
 =?utf-8?B?dWlrb3FOQlZKcGxobHZrOXJ0RTBXSWZnVGY0NWJhM252NUNjOWNZTmEyWitG?=
 =?utf-8?B?Q1ppNUVZdXFWbjNlRy9hVFJDUDVSbjNNY1RUTTBXQkZhSzcxTzY4UnhKYWdB?=
 =?utf-8?B?Nk9KZ1lQQlRqcWhQazd2NllwU1RxakJxVjRzMjZEd1MvWS82NGhRcGNITEIy?=
 =?utf-8?B?bmxDcVJUWHR3dmFiMTBBZDc3eG5pK1J5dU9SK3gvWVhQNHJTQ2lVNGt5bkdj?=
 =?utf-8?B?VGdweGJ5dVJNWDVNRHF5ZDBWQ3ZFcThYSGNFcldJelJGWHI2WmIyQWwvTDBM?=
 =?utf-8?B?L0thOFI2NTNQQmVkcU9GUFU1azhZTFcwZzloWXhWR1NmVUVlcnZPeVUwbGox?=
 =?utf-8?B?ZDZ0S3FRVXJJTlJXeEl3Z2Rna0Q1UldXQlprRkJrbUNabG55VFYyZFk2R3ZS?=
 =?utf-8?B?NklUWkFYZFBKaHpqWWxtZS9YTmlIcHhVdEl5aUhid0V1Z2grSmFncGx2ODRK?=
 =?utf-8?B?ZjNkTVIwS3k2aElQL3RwbUp2OVpTQlZhUGs0amdJYjVTSkRaeTdVN0N0VmJa?=
 =?utf-8?B?alZGK21mbEQweklqMHlLU2dTQXg1cXhIWlBLTVlvWk8xY1pCUTM0eXpRKzQ3?=
 =?utf-8?B?S200YXgxbElZZkMyUGpzN0dVYmdtMmgyVUUwemxVR1I3dStzR1JmUFp6MWla?=
 =?utf-8?B?YlJJQWd0Qy95ZGdsYVhwbFB6QVpKclRvT1NsQ2FYRmY2NGFSUFVKRGJIWDVk?=
 =?utf-8?B?eG5PUVdkazdqQW05WEl5S2tKY280Y1B5VEY2MDNiVGFiNURlSk9pSERKd2tV?=
 =?utf-8?B?NVROMmFZQW5XVElLRkV6aWJ6ZHpubzVrSmRXd09iblBUN2l2dU9ySXZMcWhq?=
 =?utf-8?B?cnlBcUJPQ3Y1aWdwMzMzaUxic3FPeHBVTk9WeUlVUlNXTWNhTjJzQ2JUV1pG?=
 =?utf-8?B?QVZCME45NFB5VmVIR0dPTmpBRnJjRmdSV3JUT1lRVUx0ZWRpcjVuWmdrVGcz?=
 =?utf-8?B?ODkrTUtoZUhaTmlrVCtlSjgwb0daS3FYVUJxbVJFRERoRVlpMjF0alFhenVH?=
 =?utf-8?B?RDVsS1E2Wko3a01HM3FtN2gyVy9yLzNqWDRMZ3BwbFpwRkRqZHUyT0MwMDNE?=
 =?utf-8?B?cXUvcnpOTWpVbCs4WkFsNkZxNXRIM3M0YUd0TDk5KzFITG1VbytZMENPbjFs?=
 =?utf-8?B?VjYxdUUwTEJLaGhkK0FLMkNIZXlic3Fia2ZyaGMvUFZRSWZZb3o4U1BJeUw1?=
 =?utf-8?B?amhvdEFQb1pTMEJEdU1XWVpROHlLMER6Sk5NNFFxcXJ2ZU9HKy9JbzZ4TExN?=
 =?utf-8?B?UFRQVXFUbENLcTI5aGRsWlBNSnVQanlVWWpoZlNjbjluc2pBSTMzeTVYWHVW?=
 =?utf-8?B?SjYzMDI4VTYvbU1HbWtsZWx4Wm8vbzNNczhjdENKOG5JOFpjdlBVL3kxV1c3?=
 =?utf-8?B?dU9xOC8wQStSdW9CM1J5TUxINjdRZ1lubXZhK2pEMXlnTnNBME5obnlML0ZS?=
 =?utf-8?B?SysyUGsrSEFrTk16ZSt3Tkk0bTlGWThXeERzNnRWME5wV05WRXAvWWVYMTY2?=
 =?utf-8?B?OG1aWXlrTGh1VHhmc2c4YlJDS0liSFQ2VXhzMDlLQUIyMGNpYUdLNWpJMERj?=
 =?utf-8?B?RWNFMXNqUkQ0UXZlOVp6S294ZFd1MWwyYTBSb2dlckgrbWo1NzQwbEMxa1dh?=
 =?utf-8?B?K3ZpTUVoQ1lGcnVOVTJOZlZsZ21FTndvZkM4eWY1ZlVoVTlPVkhOcFFCN1p3?=
 =?utf-8?B?SStmQlY0cmpnQkZydzdobHgzblZvTjkyMTdrRG5KWEx2a2ttb2MzcVlBZW5z?=
 =?utf-8?B?U21IbWk2SkcrRHdwbUVFTE5Oa25QT3RPYnA3Q2VOcTBrNTRXaUdiekI0R3Z1?=
 =?utf-8?B?SVYxb3I5TEZMaDZacURadGV2UnE2bFc4N1BlcXdwNzVZb0VVVVJTLzFYOGRX?=
 =?utf-8?B?N3N2cFp4elhjWkIzS0VoNTlzZjNIY0NOcE9TRVpuenlxc2xlOHRZeS91bWlN?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d34068-896a-4f97-f70e-08de0fee667a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 15:36:13.2760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUwyvj/Ck7tKkk5JFOsdgFhmQVzNaxApymTs3j0IqCU2xt2xXmaLJZsAYNEfDhk+L9Wi1Znqsa5K710RO7HgJvnK5UFxCig2PCddK1GA2Cc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7843
X-OriginatorOrg: intel.com

From: Jesper Dangaard Brouer <hawk@kernel.org>
Date: Mon, 20 Oct 2025 13:20:57 +0200

> 
> 
> On 17/10/2025 16.31, Maciej Fijalkowski wrote:
>> Currently, generic XDP hook uses xdp_rxq_info from netstack Rx queues
>> which do not have its XDP memory model registered. There is a case when
>> XDP program calls bpf_xdp_adjust_tail() BPF helper, which in turn
>> releases underlying memory. This happens when it consumes enough amount
>> of bytes and when XDP buffer has fragments. For this action the memory
>> model knowledge passed to XDP program is crucial so that core can call
>> suitable function for freeing/recycling the page.
>>
>> For netstack queues it defaults to MEM_TYPE_PAGE_SHARED (0) due to lack
>> of mem model registration. The problem we're fixing here is when kernel
>> copied the skb to new buffer backed by system's page_pool and XDP buffer
>> is built around it. Then when bpf_xdp_adjust_tail() calls
>> __xdp_return(), it acts incorrectly due to mem type not being set to
>> MEM_TYPE_PAGE_POOL and causes a page leak.
>>
> 
> Does the code not set the skb->pp_recycle ?

You mean this CoW code which replaces the buffers in the skb with system
PP-backed ones?
Maybe that's the problem (I don't remember the details of the function)?

> 
>> Pull out the existing code from bpf_prog_run_generic_xdp() that
>> init/prepares xdp_buff onto new helper xdp_convert_skb_to_buff() and
>> embed there rxq's mem_type initialization that is assigned to xdp_buff.

[...]

>> +    if (skb_is_nonlinear(skb)) {
>> +        skb_shinfo(skb)->xdp_frags_size = skb->data_len;
>> +        xdp_buff_set_frags_flag(xdp);
>> +    } else {
>> +        xdp_buff_clear_frags_flag(xdp);
>> +    }
>> +
> 
> The SKB should be marked via skb->pp_recycle, but I guess you are trying
> to catch code that doesn't set this correctly?
> (Slightly worried this will "paper-over" some other buggy code?)
> 
>> +    xdp->rxq->mem.type = page_pool_page_is_pp(virt_to_page(xdp->data)) ?

BTW this may return incorrect results if the page is not order-0.
IIRC system PPs always return order-0 pages, what about veth code etc?

>> +                MEM_TYPE_PAGE_POOL : MEM_TYPE_PAGE_SHARED;
>> +}
> 
> In the beginning PP_MAGIC / PP_SIGNATURE was primarily used as a
> debugging feature to catch faulty code that released pp pages to the
> real page allocator.  It seems to have evolved into something more
> critical.  Someone also tried to elevate this into a page flag, which
> would make this more reliable.
Thanks,
Olek

