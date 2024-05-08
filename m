Return-Path: <bpf+bounces-29072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C24C88BFECE
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 15:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E321F267E1
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 13:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EF07C09F;
	Wed,  8 May 2024 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NmK+XTqB"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A128878C85;
	Wed,  8 May 2024 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175357; cv=fail; b=NcBznXpgPnjzVc4BAHJSCIitMIWdVfLe8VvMyeyA6xNcgK3DJH+y0WmPAC/hI8u30iarKZzmYLhNXw4uCwjzWYfFC02CB5GT72kLmxFLDFE+0XMLT2uAOKpvplOxCHeMVrYYrPmFwcRhnt/88go/MmDWFnR3o9dDd++sVPZ+ovg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175357; c=relaxed/simple;
	bh=dX4SHF94og3hMTQPoVfq6ZrMltz+ahXi8x4H7yJ9XxU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=twVoXfkpOEDgD4jlWiXu2pfH3rnUK3RjySuD/vArzQB7XqYEPGG8lxm67WNM3yHuY2zZkwBkfuFtYWFMrdDciZsthjRSHvY65lPM/wYk46RpHel3+Au38cR4ncZlpIIxAzFBSnJYXAGB2HK12t7QYuHE4rxZA0kmngN2jLoTa90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NmK+XTqB; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715175356; x=1746711356;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dX4SHF94og3hMTQPoVfq6ZrMltz+ahXi8x4H7yJ9XxU=;
  b=NmK+XTqBu6aHJJ15EiUCCC2YuhVSPum7Mo4qL6WDwNho9bhyMeW26dOe
   HbrQo66MHCd4S9HJbLBg6y5DVZzZwH6w49Jcp7DhI0QgiSC6t0RbGEKbC
   N8DSBDoDCpay1S5GRKA/fn2UVfvGAN3egm+8osiUl+pzYYj6EHN5I5vee
   t36xHsSGAcRdrN33HvvoN7PP2HI830VALoaiK1yEBczp9csrdvYv0ZZBi
   VeGTReDETRXq4cuFOY69+BtXCUUivzLXlK0dPExwzVlg7tQXdhQByovOT
   BL2AE9V+glERp8Pg4Die5KkDoZq4vZxVdnt/gJYXWZfeNcMOj4SDJQMKq
   A==;
X-CSE-ConnectionGUID: +H8HZ1zQQcSzyhd3miW4oA==
X-CSE-MsgGUID: zAtAT01QRD2DJi27paMdxw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="21635261"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="21635261"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 06:35:55 -0700
X-CSE-ConnectionGUID: yCXHWt6WRFCIqdgW2e9rhw==
X-CSE-MsgGUID: lTQVzzqnRD+ffIJYZDkx+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28763414"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 06:35:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 06:35:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 06:35:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 06:35:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XM9nqkc35CGVcR0aikji2+viBf/GareMGkcvHpf/9tXxj9Y/e86z6gb2yyXrSQgCXzBB5AYMZ3qBPO5OylegnLiDYWlZqvrExsRQIXr0nmo5UIp+5GlZuxCReORuJ44IGk00z9QMUxgABQI7UtW8oHFWCYYVXYV2rPGW2U6EsfUhBNVsXqWuvVN0hXK5/5yxTaJ1C108ZacafI3iRfw0sH5k/FNeKrqhCEm3QWBa0IvIo3IEt4fIiQmqN2hHvuuScr5Si0uJm0tfrtLVLsv8B4jx1RQnpyq8ITuycPYR6g4guIxBsyRkd7g82XhWQdkTEHtxtHSgozyVYz9CCLROrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqWsqt1FVKG9j02i+BMRoZYlwqQlTGZ1rKQqeWTBwo4=;
 b=CLa8dCSsYTo4YXPt79Ld/LGuTIa6SO8ZHJM7VA2OC1PlHkDTdiF4w54qH902XKaKVSaSXs41B1d6uA7yutc7wbV40vumx9YjPsnPlfRN69d6oSp0E217rLpXZtXA97rOj4OgIhcgfNYVYM+nRz3OuD+l2BQQbXVScLG7jBJqHyfXcb/1xZWkVc0p5Jtj/9YCH3tnzjWaXCMUEWSggvAJYlzjVy/7w+RlkB2QOdx7DG3ivhRtxzh8e0vaB6T7rJ9W4PvgkMDv8sgqJJM5chGLMvYQkWgfsUm7MK9Dp80k5kkjR4WowDTi1UTc5l0DcZd1yVV4nHP4Yav136J0g4/GQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 13:35:52 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 13:35:52 +0000
Message-ID: <6ac025de-9264-4510-ba7f-f9a56c564a80@intel.com>
Date: Wed, 8 May 2024 15:35:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/1] net: intel: Use *-y instead of *-objs in
 Makefile
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Jacob Keller <jacob.e.keller@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Richard
 Cochran" <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
References: <20240508132315.1121086-1-andriy.shevchenko@linux.intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240508132315.1121086-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA2PR11MB4874:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb82ca4-316c-4f8d-5efd-08dc6f63c782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjA3em5tdDNHNWRyTlZ2ekNGK09PQkZybmFoeXU1N0lSWkhMekROQzVOcUpo?=
 =?utf-8?B?ZXZkNmpsTDVIUFZML3kwS2o3ZERFRzNKdHFGdk9jaFhQbFgzaEtUNGorTGkv?=
 =?utf-8?B?a0cxbFZPaU1zTVF5Qm5oWjdYMC84VXJxZHF0K2ZkVHhjTU5idk5kNWl6OWJC?=
 =?utf-8?B?TGtGMmFrcmYzZEJ4dW9xZGpINWxReWJmaEVjTmM2cThvN01XNWFXNVR2d2JI?=
 =?utf-8?B?MUNtWUUwSlo2VEV2RkhWMVBWUFZyaThFbFcwdCtDN1EyTllYd1VkREM3aHda?=
 =?utf-8?B?QkxrNTRhWklna1RpY2p4SCtyaWgwQ3YwOVBZa1EyZUhkdUtGZDFwUkx2V203?=
 =?utf-8?B?eXN1ckJhL1IvVU92b2I0UmRaVXZqTTNVQUVadWNBWDd3WEFMNkpNZnNGbUxz?=
 =?utf-8?B?VS9hUkdpL1JXYnBXSE9kbjV1Lzl5OFZjYXUxYmFxLzRYdUNCazFYYk5QSWhF?=
 =?utf-8?B?V25DalZ4cFdIbXFQRURLTFpoYnJPUVVSQjdGRVhsczZkSURxWnZYZGdZeHpk?=
 =?utf-8?B?eFJaUVpYWXM4aFBhYkNYN3J6aFFZTjJldlBzT3FlajUxS0NIUkkxR3hRakY2?=
 =?utf-8?B?VUE1YzZkQlVQZjJSYkJ2c2hZUlk5emV5K0FhUXozSXB2ZlJWSlhxVGJwWHYr?=
 =?utf-8?B?c0hpcUJUYkhoWVNRcWJaWmZKUWpwYktjZlVKOEZMc3IvZThxQ0ZycWRVRWNO?=
 =?utf-8?B?WU9yVmVCb1dlbDdRaGIrTEhsNko3c1NnQVgzeVJsR2s2NGJaWXUvNFlDaDBD?=
 =?utf-8?B?NTYycWJGeEV4Wkx6WENGdFFybkw1bjNaT2lMcUJheVhVUGNyVi9PQ3BMYmQy?=
 =?utf-8?B?RlJQbm9Yd2p1REx6WmxPNnFzckhzRGsxZ004bmY3OFRmNStPcGxrZFZ2bjFn?=
 =?utf-8?B?S0xTSC9BY00vblZjd1BYcjNkQThQSWFCZ2ZEL0Q3Ryswc1NXVWxsc3NJRlJ1?=
 =?utf-8?B?Z0dKV2ViY0VFVUNwYlVLVzBtdkx5bk9jRms1bXFUaVFNRDMyVkE4bnVQZFM4?=
 =?utf-8?B?QW8xTUJETlJhTllNeExEYTBTV2tZWmFOT3RLTGVJVHgwcnMrb0E3TVdyckU4?=
 =?utf-8?B?WjFGd05HcVVWMEQrTDlKSHdmL2JCMlBmZU5CdUlRZTIzVWVEOVRrOTVIUElp?=
 =?utf-8?B?TVl0eE1zOHcrSjdtS0pOeGMrRlhQOFFYNWNOeWxFelI0WVB1SWNRekFzOEhk?=
 =?utf-8?B?eUpNMXZVaHFIY3p3ZWM1Y2VhbUJtUUg1Wi9wL2MxS3Z6dCs3Q3I1b1l3SnBZ?=
 =?utf-8?B?ZXhoMnk3WVI4cm5STzZIQ0twT3MzR1ZieG9JdG41SlBFQktpTTRsanA3aStq?=
 =?utf-8?B?MCtKNExzbXZaU0J4ajFTVmlVcTJReVNsUFlqNGgzZ20yRnVHMGhaSGhBRCtI?=
 =?utf-8?B?M29TU0I2Y2NndGtHWVhvc0tUKzcxRWNXaHpUL3hKMERWR0phK2MyOFVuMCtD?=
 =?utf-8?B?aU1aZGIraTcvUE16V2xiM01pVDF1UnVzeHNXci9NcW4vMm8zYnhXWUxReExX?=
 =?utf-8?B?VTBFUzg5eGw1MzhBOVVNajBaSTJMV09IdFRZcHZhSERJWUk5OCtPM3h0aXk0?=
 =?utf-8?B?TmRhNlZJYWpZd2ZFVkhTSDhQWjlxUTlIcUdPVnBPZkVXWnR2SWJTZnN0Mlpy?=
 =?utf-8?B?VDA3SXdWV1AxZGFuaDZyelNoSys1UE90Y1l3cUpJYmJDMVp1aEYzbVlPK1pa?=
 =?utf-8?B?WkJROTJFRnJCSlRucGRFMkhqVmdzTFVZS3EwNEw2WU9XRHB6eTdmT1pBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2pvcnNqRDBUZUMzNjhvTU13OVRKQngzd1hiYW5iWjZpeGhVNnFUUGtHc1N2?=
 =?utf-8?B?YU1XMk1wZThPVmorS1BpYWlJM1ZUbUxVdGlYMUQzdWJxcG0rTHIrRWdnU2E5?=
 =?utf-8?B?T21SdW5PRGYxQkhQNFJ0aUZORW13b0U3N0dkSDhVdEJNTmh6RGpISm1US3NU?=
 =?utf-8?B?T2xDWHg5Q0d3T0tlRlFZVUZheXY1MzNSMVp4VHhBUWxzb08rZDlUdXlJR3g2?=
 =?utf-8?B?SHNhQ0N2RUJsZDUxV3prRWhSZEsyUWdJaTJ6OUkxdVBKcjFHMk02TFN1L1gx?=
 =?utf-8?B?Ty83RXFoTTdwcTgya0lUNHhJT29vMVBaOG82TFlQVEdrd0Y3UDRPWTZueEgr?=
 =?utf-8?B?UEJVcSt1akVxQVc3TmkxcDZOUXEyWGtkcWN4QTI0ZWhHSXpTYWc3YnQwQm1J?=
 =?utf-8?B?R01Od25jajYreHhsYzczSk9WR2E5QlZuci8zWHgyVUkrNW5PMmU4bzdzczBK?=
 =?utf-8?B?WjM4S2ptT0NqWU80eXg2ZmkzVENNZEVUOVR2YWhaSGtqOWVXS0p0TTFrRDA1?=
 =?utf-8?B?M3JJcXZPUHA0NHF5UGs1WmpRNk1pN0R3T3lVajRhbTFpODQ3KysrVU85eHpR?=
 =?utf-8?B?MWQ5UVJFMkhkbVAyMXllVzl3di80aDg0bUtGeFRMU0VyeWpLNlRqS05rOHJo?=
 =?utf-8?B?cnBJTlNMeHl0MHNYNmJleXlLajhxb3dESzUzcnl2c3I3RThoektrRUVQcGxm?=
 =?utf-8?B?eS9uZmpiS0tSZGdvanpKa0NuT3hNWUdHb0dDekxMdkNSakRlemMvdGUvZUxB?=
 =?utf-8?B?dTlTVm05M3FnYkdORGttbDUxdDdjTjFPR2NaYTVScHhoS3F3M2REeFRJaTFi?=
 =?utf-8?B?a0NJMlZuOHZ5NDZhMHNWcElKdnh6SFhEN0FQc3B3VzNZcFpFVVVscDRFWG5h?=
 =?utf-8?B?TjBvbFJOejFzWmNBRkVkMS8rU0Y4REpwUUZtSDJHYkx5bzZGc2RtSWlVeDA1?=
 =?utf-8?B?MWdFTVlJUHZydy9qSE1McklTTGltdVdQZDk3SW5pSlVJakp3L0FIc1o5OGZS?=
 =?utf-8?B?Tmp1RDRrcWtKdDFDaUJLcFd2Qkd6SEVKbnEvb1R5K3crU2dCaitmSHhXOWVS?=
 =?utf-8?B?N3kxNnlGSkRtbndrd3VTcHFlaVB2U3BKbHNzcGxORk5yenR1YlpqTlBnMENt?=
 =?utf-8?B?TXZOSzlQcmR4anRCdlBKSWc5UVNVRUxTeXBPeWowRDBUZ3lCc2JpZHRCbHpt?=
 =?utf-8?B?Z2cvYXNZeEoyTDQ1N2dJY0NHaVQ1WFZzV0FzOHVUeUFJWk4yNzIwTFhHSDFk?=
 =?utf-8?B?TENZMHI1VEp2T3ZsWmxMWHljdzFYQ0l3ajlRYWV1Zy9xNUdyS1lub0FnVnRE?=
 =?utf-8?B?UVZjMU40eEZ2Rjg5WldReG5aNk9sR1hPam5NTW5LOUxjZStRYUo1cXNxT3Br?=
 =?utf-8?B?TStraGF6RWw4aXZ0dUtPVEdJbXI0QnhKQ0pzNG9OWmVzd0p3am4zZXRxejVX?=
 =?utf-8?B?SlRabmp6bzNkSU5McTNReVFQZ0tPYzJRVXliaHAvM1NJR0VJNUhaYUJZTjNs?=
 =?utf-8?B?bTBxNVJZUmdQT1A2K0tFOXdpWHd5TmczeFNKSm9qaXg3dnE4TmdnblFPbzlm?=
 =?utf-8?B?cG5HbXdCSkkwV25NMmlMa2sraWFReHFHS0xsMWRPMzB6ZWdxeUQ2M0NKSW9l?=
 =?utf-8?B?ZG1ic25BZDk5Z0VzNzIxeGRsWDhQREtUdzhTNmlxZG00YWVrMHJOdkRpQzRk?=
 =?utf-8?B?QzJ5dnp5dUZyZVJERlY5NDFkaGtlS3VCMmR2cXp3Rm9Mb0hEZktPMXZnMjVp?=
 =?utf-8?B?VlZGS0ZBd29RQjVLWDJka1ZrdXRVeFlYYkducGFnWmJqR04weWlveXg0Rm5E?=
 =?utf-8?B?c3diMnpIOVFmS0F3dDREcHVESEJZc2FVeUN4bkFhZ3Z6NVpqSldMNXpWMEhv?=
 =?utf-8?B?am5ERndCTmdXWmwvR0FaVUtOZ3phWFlGMXkwQmNaU0cyMkNudzRxemZiV095?=
 =?utf-8?B?WCs2c2hMMkxMUzJsQUJrSktyN1Q5Y2RMRTRxZXk3VmJ3ZkhKMHNOZ1U3U3VX?=
 =?utf-8?B?WThxWnQ1Y3J2ZzRPemFZcDMrVlI0TjFoNEFaT2lKcnFXTjBkUFMyNmZpbEkx?=
 =?utf-8?B?Q1JUNlE2S2lOZHZ5RlZyYWRFRzlWeVhHMUFCZ1ZYVFdnQTR0YStadGxWT21q?=
 =?utf-8?B?YUhteS9ZUlZ3N1ZDWDZrMUF1S3ZrYTF5WkNrMVF3UEJ3UGRwaUtlbEJBOWtW?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb82ca4-316c-4f8d-5efd-08dc6f63c782
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 13:35:52.1930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7l6ps/GV4pDCDm9SbPVee6gQJiPrF8ogL3h0UH03TQwws5vcwiIc6y53XSCMt38oERgZfK0gCzHPe8rNfKoIH+T9GzjIBiwzNe7wzC6nn80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4874
X-OriginatorOrg: intel.com

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 8 May 2024 16:23:15 +0300

> *-objs suffix is reserved rather for (user-space) host programs while
> usually *-y suffix is used for kernel drivers (although *-objs works
> for that purpose for now).
> 
> Let's correct the old usages of *-objs in Makefiles.

Wait, I was sure I've seen somewhere that -objs is more new and
preferred over -y. See recent dimlib comment where Florian changed -y to
-objs for example.
Any documentation reference that -objs is for userspace and we should
clearly use -y?

Thanks,
Olek

