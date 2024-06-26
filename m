Return-Path: <bpf+bounces-33119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B36917619
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 04:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4DB284AD0
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 02:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5162720B3E;
	Wed, 26 Jun 2024 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYgyM8DS"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ABC1C68C
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719368399; cv=fail; b=FP1BKF7twNRoy9TCALVfypUMQPlthjeR9U8Id5ncnQEKe5r7D5T46VVfOf19LJhxXGLkakDQ9Y5VdJxocEr1WdmvnQnXeFIkVDpon4iSlNZLj6Q2Moi4NWrR334r8FurjIWPvmnU/dTRjQMTeaHBChWO9Cqa5r2o9vvinkpPGMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719368399; c=relaxed/simple;
	bh=Mf8GQnhbc2Owkwnq8TIC5Y83hQh73uljNRtAfs74sTU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t8AMiJx+41cCG8AcOw3NNbDyPPjE8N9JD0h3QpMAJWPgesHXuXjJVvVWmEWU1GtptWHTp8xVocEzTlnGe1aQznshdEITSYPMaXon6N8HvMj+aBv/GE+AeFkh1fL1ubaTl8RzVBw7e/6bmmopA2X7jWWHaQ/pOUocUbxpIUB8tS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYgyM8DS; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719368397; x=1750904397;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Mf8GQnhbc2Owkwnq8TIC5Y83hQh73uljNRtAfs74sTU=;
  b=aYgyM8DSbW4eLBJw15uDFjoHEYFSZMmnPS58sQ3A6RGkT/pKkG2uhv7k
   6hI12Bd3GPlDrMZCZy7kr10EpDZNREP/R2sQSLGWZdYMKpWHgEd9A+qyu
   nxC/kOHDclH9/hMRktnL/0IWBjNcu8JEwNv033CMca6vLc1SCgtNUTSih
   hDu32Uub1dKch7V0C1Hw/yrWGuWWEb3obOPtnZ4i2dlAR+ts6Q9pbrSIM
   n/OBNDXYva6W6L5dkVmO8cg9jUZx2W/wAQ9+cLMn5NQLs6MSvY9nTH/6H
   peMSKACMNEWoPIbScwbAEHXeaHobb+L6fBhKEYb4xyOi4EnQXccIodlPc
   g==;
X-CSE-ConnectionGUID: tFeS/g1ZQDaB4DcTF6hDVw==
X-CSE-MsgGUID: afIptz/JQUGoZl5+4C4fNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27822623"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="27822623"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 19:19:57 -0700
X-CSE-ConnectionGUID: Jvg6HQfuRuS7vJoDFizurQ==
X-CSE-MsgGUID: Ez4eMjJmQOOVu/aE9BcCzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="48824343"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 19:19:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 19:19:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 19:19:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 19:19:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqd0Nae136HR9xEdIlhCawKlfofybSO5ykNJOmvKVzLQDEN5+UhmGhGdLiIzsXbFUv/UbICDPu1lZHJCKmQH2367SXZ6D8FE4B19kVoLs7514xaxs1d+dQiOqkkH0iUPSrMfC62uhhja1nlw6eIWdxvGvX3SCvtqyAMuBeL2hwHNzygBfXqkw/7adShJ6/9p/Z9GF7lmBQPSjs/l4OFHMQ0T7nzMHNIxNWxQoeKW/ElWyh+L5RQeEn9gsKbGGCJ93Bdx9xqyIhpcId1tHRn8qXm+diOqy0CPRwWMz0pPGwJzkZfy0IoIGhYAPrIPHmjDmERKSHd6U6B6cTvnxAWOtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Xy8MLExQqLD62TxygSjcMQlJuji99vAvmWY3cLF/IQ=;
 b=ipiAuaFfPpdiv5AAUIqeYm7Zbn7/s9Z4fpEy3NWBpvPX+Ur+FOBdUcb5icBFTSCbJD+DKg4ReDlb3Fn842V09DU0+RogWNHT7F8evj41KFqcmxCB4sk5VssbJ/8YcJ/IhmbXUwcI8U9M8+RwPLlxOcPlWqnHwjSEsj8vg9vN2JTIVJ5EkN3ou0mRkGpBGk1Qz9dUwjGdOY8Gt0g8Ij/OlWrwmGmFMSDryg7mW/Fj2DeHCh/gqamJ6mOutUCYFaUy5nTxqXeX6JUilPilc+wxhaZkzrDELsMFk4+VzTh/WrHL3u9vmxnA+3H6bScHTwWgsLym13cn+/p5GDr9aLfqlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB4847.namprd11.prod.outlook.com (2603:10b6:a03:2d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Wed, 26 Jun
 2024 02:19:52 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 02:19:52 +0000
Date: Wed, 26 Jun 2024 10:19:44 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Leon Hwang <hffilwlqm@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Alexei Starovoitov <ast@kernel.org>,
	<bpf@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [bpf, x64] f663a03c8e:
 test-bpf.Tail_call_count_preserved_across_function_calls.fail
Message-ID: <Znt6wPH24lQlbYrO@xsang-OptiPlex-9020>
References: <202406251415.c51865bc-oliver.sang@intel.com>
 <ac402815-923c-49ec-b027-4f99b55c895e@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ac402815-923c-49ec-b027-4f99b55c895e@gmail.com>
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB4847:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b53ab27-2ad8-43c3-48fc-08dc95867687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c5GP6XZvUvzzoIn5yUQl5pgpR4TFInTJbmMbRgaISQ5B3jjqPB0+FAFb8ITn?=
 =?us-ascii?Q?aMHnPinvBVLReAMFFGHEOJbNmk+XUMq73ZtbGRygcvBTct2ZdE+nFNkd4kg+?=
 =?us-ascii?Q?9ETnMVJNp3JQi7ocMOxjnqNRsImeDwwmQBuuNREk/P0T8UltS0LcSSlMVfZn?=
 =?us-ascii?Q?YlE60VdEzfWdggYUvON938LK2uzPRfDhVp2DM8JDbtUSYyGSDYXrMGa61reh?=
 =?us-ascii?Q?fOimLKRO2Nx7iqWdERo3Q/16HgG7jm1HF/LEKwYxjVzPf3+q1bg7OtszIt4L?=
 =?us-ascii?Q?IQtRHG50CVPsv2rviUkkdnp2rEI11dgQ74EZPHL3SMdCbMUbeB/A9CRFHS8w?=
 =?us-ascii?Q?/ZWDXM6P4ieOSg8vVR5T0MtuwouJMphZXuq1s/hskmksxs2tQaRFENjnvQZn?=
 =?us-ascii?Q?KVz/McoVujljc9BZNoPOtVsCvS1ByU4QMCJFH0ALn3RemsXdQxh6hVBT1H2V?=
 =?us-ascii?Q?MSB4nd30HGfjK30X5fR6o9c573xcJ8HcbbfRvm09E3lFi3Kki4IJ2tNj1lq1?=
 =?us-ascii?Q?kg3Mm/QRhUSv5Zm/8LRXq4Cr2xeJovuMJ7UWwHiymerXVJk2HiPka5NbCQMg?=
 =?us-ascii?Q?4BgaVA+uplVu+wNVblXzM8lu0j7uWhWcmJgPysudpFYZJxSLlAncogMDmnxC?=
 =?us-ascii?Q?f0tBCBfMP4YBkK3qNq/HPd1X7FVi5NPQhUp3OjRKz8Lx2CpQZWUCFnz9Fieu?=
 =?us-ascii?Q?yvP3bFnzrNhGUJWekpS0d66Ain7P6Dectw3QUkVSbqbLfbqzsSQ0qVwJUM6U?=
 =?us-ascii?Q?2A5kDKrwxRO1oq+FrR0+g3MoZseinX7IKpIIBuVHNf/ggKvwBwxSW9TJP0X9?=
 =?us-ascii?Q?rjgnfbdio3/626kFbbB4oPPVGOT6M06+G+z02luRt52eV7Kb+/a5JbH1abS4?=
 =?us-ascii?Q?bfpZzpGyNH48d4TPvL0Yp8NX986l98lhNruaXjaUW0RL8gSkvCz1KPB76gSe?=
 =?us-ascii?Q?UVTKHEehJfSoSm9XIZ4dkPK8ooDuN50jdfpuJ2qev58I5gBucU86O4NX5wi8?=
 =?us-ascii?Q?cwFwaDAes+VW8AfSbwq17i39mzDTQWWKzXgDzjQoEO9BvhI3uQtJ4VypLtTN?=
 =?us-ascii?Q?FWIqW7EN05X+B+PbEhL8vsueFU8R99DUYKJ+GGrlKgTWvSsm0x4afsJrt/6B?=
 =?us-ascii?Q?r2oGT2fCqZoZbZczvl5kqEnif9QShzxUmRuZb28C1Yo5iY9Bo8nnfIA/OCak?=
 =?us-ascii?Q?CSHPzZUtA1/y6/a5vKtcPTEINSbERm7TtqqjFnxmtL7DOApbSBsyo1eql87V?=
 =?us-ascii?Q?3jWinkMLrlc6dzHl2ZFz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KHy0OW/ciXv5xyNY2RNpNQTpU2y2xBEKXX2E4CMsp4X3FRth/Y6V5Qst8Nnx?=
 =?us-ascii?Q?M+hDNQlpUNgldqBM2Pff0ImBG/VpqUqfj93SoEYTeCSRal4Gdy+wBi8H77hn?=
 =?us-ascii?Q?n2lyr7czZVCReN5Ty73BCMWliu0cNF7mWVqVnq1rinEhM9eIVhGMKvAOYeBY?=
 =?us-ascii?Q?FpYb4ZbaIKgWgLf90xLFhZ7CSuL8ZN7YNstnujxN7aZVSinbd1sbwzgPvfyL?=
 =?us-ascii?Q?ky1aQajOvlmDHtaxQ4hMTdeukL8aVlf8xnUxWtPdQLXdRvIcVATnuEWIR0nB?=
 =?us-ascii?Q?T4O5tsvD0jfGVwHiFDeVO30jCfitxYP0EIMspbiCRB7k5KN5z5S8fS9j1nST?=
 =?us-ascii?Q?wsQAl1wQmw89dpQHP3LHzax+IcpX2NPNH+XnMBKYrwEiZWkHZTjbI4IXh4HP?=
 =?us-ascii?Q?O3oCDEmtJdnsLLQYk4LPIIKumB6RImWa/NZnEdLTXu+t7/krCXoFuLH96PRd?=
 =?us-ascii?Q?EPKe9Ia0PeQGtQ0seEexJdHe9AKluxjwNOCXz3jgOO5GTFTDHOgzwe4zXiM/?=
 =?us-ascii?Q?wrCtjRBnceRg9UwWfkUisK732SnMO+OfXhaFySrMAxE9VUc1dPqpWnH8AAGN?=
 =?us-ascii?Q?JpTBSpqJTe6DajG8QgJipH0x99JIiGn28IgcEusXjt8YnkpW1nY3ZhwMVvCd?=
 =?us-ascii?Q?SbqIFgts72WlG9GHk0t6vlzHyp9x1Hh3Le0EqbD+U/5yOme/WTrmjbAkVe6G?=
 =?us-ascii?Q?Yj3B1IaNaMq/G+4lAyI/9ZUX3vju8QtIYJbSoJptKtzOHlr12hPTqGxYwspr?=
 =?us-ascii?Q?qaMffqvFw0F2yDWBcPq5EeTczcQRLV7OrXJbcb3XY2bbW+RQ9uqt31u59gPV?=
 =?us-ascii?Q?tAIZartMPy5C7qZrPXvTlAK/8/xVGSogUz/J++d9eGp3i5wrzxb+A+AD2PG+?=
 =?us-ascii?Q?gANnvIsYAhw0fdxlHcXIN6qquW61yXIN5UM35GnhPnZf7fT6A9go03PwPvhC?=
 =?us-ascii?Q?eahZhS0/7S0hbiCt1VG4Xq9IFksODpzdaaOfdVNFDPpxHoSw7kq4sUqWE3D5?=
 =?us-ascii?Q?l7ED7Xpc4Nkzl5A7jC3qIhlBqwM+e8GpATclEnWP5rIzJKtxi+mFgrCDFUPJ?=
 =?us-ascii?Q?JNW8df/X9e3xKDekFY9DBvG1LHblABvkzVOZqcezARiwm8vGeElcsMGSW//7?=
 =?us-ascii?Q?qnkZl1si4zIlm6TWGrTsrM0k/IKKIMUov/60ohooO93RlDemd0zklzP61N1a?=
 =?us-ascii?Q?ReqJmb0WqDDaPOk43LK5IvL4g4Ur5O+84wRjHXYu865ALkNxweMNsvCysvwx?=
 =?us-ascii?Q?IcgBcp3qbnZlXFGEQwglyLyTnR5Intx/TFV4IvhsWL6eaLr0N9JRxMjW3Q5M?=
 =?us-ascii?Q?UwQDKdUKxJkh+UdNooHznCTubvHPxixQl+6x7LFrC6aKd7APRwHqhL1CK7o2?=
 =?us-ascii?Q?GL/NTSS+Epys6EsnI9TVdmr7SlsQvigkklqOHg41dSWaF0SFiUNXenT9xJoR?=
 =?us-ascii?Q?uxuS4cnJWyZgBnzStbk6WqUs0R7R01m/6X62A+++A7G8QqjNLa1jRnBAwrwb?=
 =?us-ascii?Q?jhJAeuqVO3XtNL1cZGf5veK8KVZ545gFJjBdDTpyEzmtgOWW3ApoL0iIAbDI?=
 =?us-ascii?Q?Qz+qPtg9FLua0idpX292X++GfTWU87xz9unvytKvwD3rILpYZV7WpEh0+aVw?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b53ab27-2ad8-43c3-48fc-08dc95867687
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 02:19:52.7501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIh7Kfc8/CR9jRelZ39D54Bpnw/nWB9LiFl2r0De6eV94q9xEra+mW3O0eCmJmom/mS5MlpLtKtc31O9GMqEKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4847
X-OriginatorOrg: intel.com

hi, Leon Hwang,

On Tue, Jun 25, 2024 at 04:25:00PM +0800, Leon Hwang wrote:
> 
> 
> On 25/6/24 14:55, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "test-bpf.Tail_call_count_preserved_across_function_calls.fail" on:
> > 
> > commit: f663a03c8e35c5156bad073a4a8f5e673d656e3f ("bpf, x64: Remove tail call detection")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > [test failed on linux-next/master 62c97045b8f720c2eac807a5f38e26c9ed512371]
> > 
> > in testcase: test-bpf
> > version: 
> > with following parameters:
> > 
> > 	test: non-jit
> > 
> > 
> > 
> > compiler: gcc-13
> > test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202406251415.c51865bc-oliver.sang@intel.com
> > 
> > 
> > 
> > [   43.913560] test_bpf: #0 Tail call leaf jited:1 5 PASS
> > [   43.913572] test_bpf: #1 Tail call 2 jited:1 ret -1 != 3 FAIL
> > [   43.914138] test_bpf: #2 Tail call 3 jited:1 ret -1 != 6 FAIL
> > [   43.914756] test_bpf: #3 Tail call 4 jited:1 ret -1 != 10 FAIL
> > [   43.915374] test_bpf: #4 Tail call load/store leaf jited:1 5 PASS
> > [   43.915993] test_bpf: #5 Tail call load/store jited:1 ret -1 != 0 FAIL
> > [   43.916636] test_bpf: #6 Tail call error path, max count reached jited:1 ret 1000 != 34000 FAIL
> > [   43.917319] test_bpf: #7 Tail call count preserved across function calls jited:1 ret 1000 != 34000 FAIL
> > [   43.918799] test_bpf: #8 Tail call error path, NULL target jited:1 5 PASS
> > [   43.919720] test_bpf: #9 Tail call error path, index out of range jited:1 5 PASS
> > [   43.920474] test_bpf: test_tail_calls: Summary: 4 PASSED, 6 FAILED, [10/10 JIT'ed]
> > 
> 
> Hi,
> 
> May I request the source code of these test cases?
> I do not find them in lkp-tests.

test-bpf doesn't have source code.

you could refer to
https://github.com/intel/lkp-tests/blob/master/programs/test-bpf/run
to see how it runs.

then
https://github.com/intel/lkp-tests/blob/master/programs/test-bpf/parse
to see how the results are parsed.

> 
> Thanks,
> Leon
> 
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20240625/202406251415.c51865bc-oliver.sang@intel.com
> > 
> > 
> > 

