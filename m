Return-Path: <bpf+bounces-43788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 326BE9B99C6
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 22:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A901F22A22
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 21:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251381E2828;
	Fri,  1 Nov 2024 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWwHSUln"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336431CCEF8;
	Fri,  1 Nov 2024 21:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730494889; cv=fail; b=bMCnsGNNrVi6pjPl4rtxFNsHopKVY6zUM9OFtpQDXGRh4mpvpmoTizunYdcEZek1tPfsciMjAiEGIEpsX7mTF0P/QOwhCqFp4Q6zArzqzQz3hlQgm43O3tMKY8f+N+HSnE0o3qobqrAwquyXHAKcBrbLRAGcJQDLwqYIugmCwsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730494889; c=relaxed/simple;
	bh=N1NlbDQygfr65K+bs2rn/AJGBKR/foNSc+PhTxivrBY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jtgvklAEez9ESxCVye0AJpjAo+U5JZd7KtvbFRFvAoiKhx05Zx8eJHp6qHAojlmugrCBH13mDVAupsvXChletqhrnCvWuuUHIPDX/Qkp1U7o2F9YYC8IkYAVkefK7VSOmFz3nACfkSfTmsUbnFlworTbjIzVGUXcDp3bCaqadEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWwHSUln; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730494886; x=1762030886;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=N1NlbDQygfr65K+bs2rn/AJGBKR/foNSc+PhTxivrBY=;
  b=RWwHSUlnVINvTnWN55YhwfDSibZBIHrdCdfOyDj2bYoA+qcyPO6fSTiN
   jAvyaIpSFFvldJ+hJR1QeFDGtzOtnCBLCkhAgzQYU6SdHV/lBTerxRZqf
   720U9+Arg4aC+WNsOHzE5fUSArNAYNjAxTMEwFkh9VzfFtRfuSHHst4MR
   Yu9xnA3JRVdQxYeKr3nLKDXUSg8Q8nTOYKWYjZfxtDBf3vVywb64A3tLB
   W69jE+f74I2r7QNZQldgpOE1O/fW0xcg6+EXchCeFJQOPmcgk79LT89yA
   yIkgwTESwXiDZqnEnsgaacdnC6dV8ygoCZK6AwDn6doAqENICUps80zWR
   A==;
X-CSE-ConnectionGUID: dlXtkhODRgKPwxFntnEOxA==
X-CSE-MsgGUID: z2Hfj1RwQtGZIJwwbQR6Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="29698893"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="29698893"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 14:01:25 -0700
X-CSE-ConnectionGUID: 4blRoqc4RVKs+Qk+Sc0Abw==
X-CSE-MsgGUID: 2Ie0J2hrSF2YbqFrsb3+Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="87890590"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 14:01:25 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 14:01:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 14:01:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 14:01:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/BYIJ8ZS7r6yBuS9I5VvIXt/FyhgSbqKv/UBTr89pFLByjXDullXf2rBl+CX3r2fOiSRxQv4ONe+fWsOWc3GuMJRg1PuUIYv+uLkXhIgfRODLOSCdY+ckw16zi+a7fHO7yHGp4NkXnpi84gPAerSXt8mCe0r0RxjtOktxr240YGPcS0GcCGTIrxYtByy4HOr9d2///3Qbd1OO6bf+OiLymgVNJ8dLuh3d35AJhA/ccM9gkCozoH3yVShRGNlDL5mFSlLSzdLdeJ16Vp8aJqXA7L1sgKJNnM82OYRyM112Oa9qp/y16kHBa7RyYUhBRuyQ1FN2lU4vMSZEM/Tx0Cdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3jWsPuh867Zv7maQ9hrIe/pWNy8pHjWrAL/7L2c+o0=;
 b=Yy4zW4DfqcEhpvd4Q5Wx3T3OpROmtf5Rzb8m+s6x2/CaHcoMzRK2tu61iJa9kStNh0aE4Vc2WRbRHF0e3G5Ew2aE8zNXXfTBJgriGsvc5dj5ItV2bwAvqrva7ccIw2vFx8uOg8swGsANsNdHoU9CWQ361egcO7qB9YxuyxibULhzIInXBbNObSRy7EpGxF5vu7B22fwBDcGQUwe2NnDQU/FNpM0ckbei/ncPEIDhqcda+bTrKu3/vQiJ4zNU/6rwKO70VR91jwqWcj2RL54EAaizeOxwt/WwpTxfqs+w94rPbCGp55c48KfJFQklHfGIOTIKXlD9sEA+SDIaJRst0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.28; Fri, 1 Nov
 2024 21:01:20 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3%3]) with mapi id 15.20.8114.023; Fri, 1 Nov 2024
 21:01:20 +0000
Message-ID: <f9cfcffb-203b-4ed1-82ba-14fed2252c7e@intel.com>
Date: Fri, 1 Nov 2024 16:01:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 7/7] docs: networking: Describe irq suspension
To: Joe Damato <jdamato@fastly.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <namangulati@google.com>, <edumazet@google.com>,
	<amritha.nambiar@intel.com>, <sdf@fomichev.me>, <peter@typeblog.net>,
	<m2shafiei@uwaterloo.ca>, <bjorn@rivosinc.com>, <hch@infradead.org>,
	<willy@infradead.org>, <willemdebruijn.kernel@gmail.com>,
	<skhawaja@google.com>, <kuba@kernel.org>, Martin Karsten
	<mkarsten@uwaterloo.ca>, Bagas Sanjaya <bagasdotme@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "open list:DOCUMENTATION"
	<linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
 list:BPF [MISC] :Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
References: <20241101004846.32532-1-jdamato@fastly.com>
 <20241101004846.32532-8-jdamato@fastly.com>
 <cd033a99-014c-4b41-bfca-7b893604fe5a@intel.com>
 <ZyRbZpCiANaxNNlv@LQ3V64L9R2>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <ZyRbZpCiANaxNNlv@LQ3V64L9R2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0037.namprd17.prod.outlook.com
 (2603:10b6:a03:167::14) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|BN9PR11MB5289:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a88c3ef-aea3-4271-b7bb-08dcfab85611
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUFreE8razJFKzdlUDQvZHdnK1ArdEw5WFMzUVd3NUZDN0ZuYlhDbmZVdTZv?=
 =?utf-8?B?VjNpZ1FOeCsyY1RyaFZJWkt0K3FjeWIwTTV0c21nbUpMTzd6cTVoTTFNUU42?=
 =?utf-8?B?amZNaldxcGJXS3NXRTcybGhwcng2K2pseDZYQzRZSGFHM0J6ZmdNVHNqUzRk?=
 =?utf-8?B?UExXdEJUVkRlODdESkZCaTljS1Vna1JpbGd2Qmo5K2d4MnRTbGc2ZDdRZTJw?=
 =?utf-8?B?clRNL0Y2Uks2VE11OWo0ZHRuZ25FU0hzY1pJRlRFLzYvQ2krTTBURWxPU01h?=
 =?utf-8?B?NE1BOEd6ajROemZGczdrQVQwWWdQNFFQT2lBb2hDZS81QUI5WUtid3ZDTFhF?=
 =?utf-8?B?OHExVVBZNjJLL2NBazJvSUFEWEpnaVdORmRLbzRHL0lqT2U0UzZzZ3lSYUZT?=
 =?utf-8?B?TFBpZTVVc0ErZ2VQVzFSTVhYUlQraXBudmVWcjBpclYzdnJvRnZWcFZXRElE?=
 =?utf-8?B?a1ZhUmprQUVVaTg1WWR6ajRIWjVEYktaNWtPWVJPYVBBWE9aYktGQ2MxL2s0?=
 =?utf-8?B?c2VvMHdzQ2tTaGxDcGl6ekZhSm9MMEdXdTFwSURRU05KV3hFS1o4c0dTeURD?=
 =?utf-8?B?MGFwb3YxQVNNOWsySlJIQitESTNzZ3FlNkJCZnF6Y0NXVUlFZHNTc2J5ZlF3?=
 =?utf-8?B?aElxUG05TGJXRTdHQU9acGh3czZwaC9pMytteDVlOFNaTXNROURUTi9RY2RX?=
 =?utf-8?B?L21YMTdNNEZXYVVrTjE4YkpIMHVGazFEUnprdG5CL1lhakM0VXh1cFJGV2Ry?=
 =?utf-8?B?MURJbG5RYjQ0YXhTTzBUM1JYQ1h3SHRicjB2dUpzWU9xV0lNdFpEUW13cTQz?=
 =?utf-8?B?NFZIdUFvL0xFUzNQcXhOT2lieHRaMVlhK2hZK0Q1QTFUMk8yaGVZMk5kYVZk?=
 =?utf-8?B?NjFCQWNTZEJNazFVd3Bwd215Q0dMK25FaisybjRJTE92NG9sUTJ2T014TC9Z?=
 =?utf-8?B?RVpWcEo4NkNWZDdjd3l4WFJ3SzlBWUVybFFicitnV2l3T1A2S0J2OWhkTHZK?=
 =?utf-8?B?OTlONTRBS05TU1hVN21CenY2Y0l3dlNkSDVCQzloUmd5dStzbUw1aDlNeUZM?=
 =?utf-8?B?YnhERys4Z3FvNGpRUHNUZFlPYTdGVDhLZElxZ2xPOHBReUxQbGZGSDlpUXdj?=
 =?utf-8?B?Y2wzbDNVY1FVN0RuRUwxZ1pINUdZcFhjWkIzRy9KMUQ4djAvQm91TmhqSE5T?=
 =?utf-8?B?SThZTVowQlNheUNpS2xBUmpGWXNHUy9ESjZxNWY3RFpiRDVmSGh0WUdCVFZp?=
 =?utf-8?B?UnRPdlpHZ0tGOFZaOExuRGlFQldPdTBCK3FhbFNWNnpxRjM5RkE2dG1lbi94?=
 =?utf-8?B?WXN4RDRGUkd5K2NJU0JUN3dwdDh1SkhCUjg3dzJ0YzNVaXY3aUQ0dWRoaHR6?=
 =?utf-8?B?YitoUkh3M0xHRjdJT0YyU3puVkFIRkMrT29EcXFscU5QakRsbWRMc3hHdnpO?=
 =?utf-8?B?ejc2RnlyVlN2Zk9BUnJyOWkzOXJyVUhxQ1pxaFo1TXYwczIxa016dmY1NUc3?=
 =?utf-8?B?dm1nQ21nVHU3RnoxeWRyY2djK3R2VWtFMitld04veWcvZm0waXUva3VxMURt?=
 =?utf-8?B?NzI3a0NGWlBIVjJEMHRiWEt6b3BMRVVDbURUalZqUklHTnM4dlhaQWVwSGtt?=
 =?utf-8?B?R0o3VXFGL2Rub2N0Y2RrR09Gb1ZXQTVFTW1CamNiblJXM3hwZ3pIMHMxb21E?=
 =?utf-8?B?NTlxc081UWNjdlpLaVYzRDlYYnJ0U0NuQUkrb21EMXNjeVVWSjhUNEJYM3hy?=
 =?utf-8?B?aW5SbitDdU5tQXFpR3ZnV2N4bUtOUHdJdzFwVkE2MlZVdDg5Q2NYWFlPcTJP?=
 =?utf-8?Q?KXhrxZWDVGE+t3rcBiv44qmrXDZ9+mM17uZTY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1RNVHE3OG8xaDliU0EwUkVUbnlnMjQ1dER6S1l5K0oyby9CYzVkNWlta0t3?=
 =?utf-8?B?YXhrLzJESjdxSEFPTSs4cFNuVjNYTHd3K1JZOUNQamNyM2xkOHhLN2grRVpP?=
 =?utf-8?B?cDJHQU5kb29pRFhnVkdHemxTTU5MM2xSVGh6OHIyaHNvbkFwN1JjREZMMVhw?=
 =?utf-8?B?K3dPeTVvREw1KzlydE93NUJGdS9LQ2djYW83TWEzWGZjUDRXTmROMkFoSk1R?=
 =?utf-8?B?eDE1WmErVURCUFpCa0ZzOGs5T1hLeml2TmhhSTJUY2NIK21NcHdQNzQ0Wll0?=
 =?utf-8?B?OUcySDdpQi9TbkJLeGZHYlZ3OElrYUFBVGMvVG5CUXNLeHdCcGZpUVZ2Ukkz?=
 =?utf-8?B?RjdjTUIzaVZ4UVVEbDhnNHBnUlJiTXZPbHVqRzBWM0lZR0lMTlFDWEJvSWlK?=
 =?utf-8?B?NkpEMUpIZEdxcHJIbWNyaVZSVGRZaW1GWmxKTytwYXpQOExSeXJlNjYyT3Fk?=
 =?utf-8?B?TFlmaXNUV3BFOGlhQmpaODdDODI3REdZYzErSk1zMytXdFlicHNmVFQ4OG5j?=
 =?utf-8?B?MEdRKzNDdG9rcDNkTUc1NWsrSDFCTkQybkQyYWNFYkJDY2RNZmE0Z3NDemFR?=
 =?utf-8?B?NWZUQzJKOEt2TTVqYjVoMnRVRzFtQ0szWjZWdWt4eWpVU09SZ3RObndsTzdZ?=
 =?utf-8?B?Qkx0NFMyK0dEbjV2U05OR3YyVklmYkhseDlzZUlZSWxLeVlWSzJWT1gwNVc5?=
 =?utf-8?B?SzAzT1JEZWNWQXFzRjNJYmUxeGUwSFlhOEVyUjFCSmxMZXhpalhoVU5lb3Y1?=
 =?utf-8?B?eC9aTlNPdytSQVBGMlJzVXlDd05GRFBVYnAwR2h6RHhmOU9oZGtvNEJRR2Iv?=
 =?utf-8?B?NnkrMDNaSEtiMW43MUVEdWQzWk1aN1pxekpueG9CeXNudHhOb1BsL2dwYmha?=
 =?utf-8?B?V2JYRTQzODBBRWtlSHA5dkF1d25RMEFuZ21UR0h2WXE2SnJvRXIwQkcraC9T?=
 =?utf-8?B?T2UyN1ZtOHBMMUpCaXB4K1VobGRHMno4eGhWWmhHd01maE81elFFTWw2UVdY?=
 =?utf-8?B?V1V4cEd4emhMNDA4ZEhENHZBQ1dKaDVUUmFJaG1BTDRoREVvc1FkdzdoK3J5?=
 =?utf-8?B?ZVVzci9EV2VSRWludDhtTzBacVNVekF2b3M3Z2ludGZaaTdIeVJwS3ZHU0ZN?=
 =?utf-8?B?Q092TEdUSlRpN052Z09DZE81TmdvMDBESVUzWmpoOWtpNDJVbUdHVWdTUWpv?=
 =?utf-8?B?NFlZN1RuT3J4QTZzOW13c0VaRWRPYzNxbmlQcDdSOWN4ejNrWDhGeFltTGxY?=
 =?utf-8?B?YmhYYW5oQ3YxQ29pNFF3OFFrOHBvRmYwVVBocGxWbWJxZk1ONkZvam9IY3Qy?=
 =?utf-8?B?U1RnN2tiY25OcXI0clArRTl2enY1SFY2d3dTUTF6bWtNcWwwbUxrOW55dzV4?=
 =?utf-8?B?YllXaFRJN1Iwbi9WV0o5TXFnajRuNE84eWgrMmxPNXZGc3I2TDdwZDZ6Y1Vw?=
 =?utf-8?B?VzBRVmxYYmlKVFozMzlNd2RyVm90cGpJRXViOWVNenVJd1RSMm9JUmcwOFJB?=
 =?utf-8?B?UUdYanlhYWhaSFR6ZXI1M3BWRGZTK0RENk1pNE12NUdzNjRheEZGdzhxcUNX?=
 =?utf-8?B?U3VIYnFybVRNQnJkUXJhT2Q4TkZLZ3lPN3pJTEFZSzZsNTNTZnN6UGJNcmpI?=
 =?utf-8?B?UjZUWk00dGFYaGt5UTNRaVQ4N2EyNmVEVG82NmgzdXZTeG1EMVU3aXRCeUdO?=
 =?utf-8?B?YlhjTEkxQzJMVkIxMDZkdWJudHdRS1R5ZUJobGdvSTBkajVXZlhWblVncS9G?=
 =?utf-8?B?RE1UTUQ1MGs1bCtGZmRCeS9mS2R5MDdpYmFFSU8xc2h6eG82aE04a1RITEhT?=
 =?utf-8?B?aDZucUZJNEpiMVo3UWZXeVRFVHhvUHNOL1dIVUk4dlk3TW82b2RSQmVzOFIy?=
 =?utf-8?B?OVVyS29EaFA0ZjkyRVI2QU5vWjVmbVBuOU9iRXQvd0hBSk8rVUZXY293MWNR?=
 =?utf-8?B?ejlnQmM2Y0ZPSXZHNFRiQXQyYTlCdFpDeVZKc21qMzVENVBIZWg3aEVJZ0pQ?=
 =?utf-8?B?Yit4eUwxWVU2aTJQd0VLQzVmTHpJUmR2Znp1YVJ0RFZSVWJpSWRKMjlwYjg4?=
 =?utf-8?B?QVhwQThvaXdHcmwyWlY2QkZlOUFPenJnTkg0Q3lhTnFLV3dwZmhBWXBKcUlq?=
 =?utf-8?B?NDlRejJJVzhIbVVvNVVKTEpvSXo1V000SHd1ejB2Q3ZBVW10eHRjR3dDVzZD?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a88c3ef-aea3-4271-b7bb-08dcfab85611
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 21:01:20.6593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tm6KyfMyAABEuJEcMqE93Zp+qBRbg0Ml0bM2hjj/hQzO9wbs6ziphnt+mX5cyOHgHGmL5QNSnPC7lFLKhybC81vKhdaq0w02ZM0ksgy4fus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
X-OriginatorOrg: intel.com



On 10/31/2024 11:39 PM, Joe Damato wrote:
> On Thu, Oct 31, 2024 at 10:47:05PM -0500, Samudrala, Sridhar wrote:
>>
>>
>> On 10/31/2024 7:48 PM, Joe Damato wrote:
>>> Describe irq suspension, the epoll ioctls, and the tradeoffs of using
>>> different gro_flush_timeout values.
>>>
>>> Signed-off-by: Joe Damato <jdamato@fastly.com>
>>> Co-developed-by: Martin Karsten <mkarsten@uwaterloo.ca>
>>> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
>>> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
>>> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>>> ---
>> <snip>
>>
>>
>>> +
>>> +IRQ suspension
>>> +--------------
>>> +
>>> +IRQ suspension is a mechanism wherein device IRQs are masked while epoll
>>> +triggers NAPI packet processing.
>>> +
>>> +While application calls to epoll_wait successfully retrieve events, the kernel will
>>> +defer the IRQ suspension timer. If the kernel does not retrieve any events
>>> +while busy polling (for example, because network traffic levels subsided), IRQ
>>> +suspension is disabled and the IRQ mitigation strategies described above are
>>> +engaged.
>>> +
>>> +This allows users to balance CPU consumption with network processing
>>> +efficiency.
>>> +
>>> +To use this mechanism:
>>> +
>>> +  1. The per-NAPI config parameter ``irq_suspend_timeout`` should be set to the
>>> +     maximum time (in nanoseconds) the application can have its IRQs
>>> +     suspended. This is done using netlink, as described above. This timeout
>>> +     serves as a safety mechanism to restart IRQ driver interrupt processing if
>>> +     the application has stalled. This value should be chosen so that it covers
>>> +     the amount of time the user application needs to process data from its
>>> +     call to epoll_wait, noting that applications can control how much data
>>> +     they retrieve by setting ``max_events`` when calling epoll_wait.
>>> +
>>> +  2. The sysfs parameter or per-NAPI config parameters ``gro_flush_timeout``
>>> +     and ``napi_defer_hard_irqs`` can be set to low values. They will be used
>>> +     to defer IRQs after busy poll has found no data.
>>
>> Is it required to set gro_flush_timeout and napi_defer_hard_irqs when
>> irq_suspend_timeout is set? Doesn't it override any smaller
>> gro_flush_timeout value?
> 
> It is not required to use gro_flush_timeout or napi_defer_hard_irqs,
> but if they are set they will take over when epoll finds no events.
> Their usage is recommended. See the Usage section of the cover
> letter for details.
> 
> While gro_flush_timeout and napi_defer_hard_irqs are not strictly
> required, it is difficult for the polling-based packet delivery loop
> to gain control over packet delivery.
> 
> Please see a previous email about this from the RFC for more
> details:
> 
> https://lore.kernel.org/netdev/2bb121dd-3dcd-4142-ab87-02ccf4afd469@uwaterloo.ca/

OK. Thanks for the clarification.
> 
> In the cover letter, you can note the difference in performance when
> gro_flush_timeout is set to different values. Note the explanation
> of suspendX; each suspend case is testing a different
> gro_flush_timeout.

May be you can also include a test scenario in your perf results  where 
gro_flush_timeout and napi_defer_hard_irqs are not set to show that a 
non-zero value of gro_flush_timeout and napi_defer_hard_irqs is 
recommended when using irq_suspend_timeout.

> 
> Let us know if you have any other questions; both Martin and I are
> happy to help or further explain anything that is not clear.
> 


