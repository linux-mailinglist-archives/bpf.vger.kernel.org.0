Return-Path: <bpf+bounces-43701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB549B8A0F
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 04:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03A5282CE2
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 03:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F7F144D01;
	Fri,  1 Nov 2024 03:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QyYb2Dck"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D007128FC;
	Fri,  1 Nov 2024 03:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730432839; cv=fail; b=cn2t6+GeCeUMc0P9Zm2GYFvh7WFBQcjxQ7SOBUI3tkxihvPmu01cabLo4t6xY8zQV58evvpNPW9qJlSm1WB7kA6oka1JjY6BkPY4YjyOCXW1BoyFanahyV3u4uHuZ+56OI/euy0k+LD/VEGzMgFYwMlngm0UUZpAj749ptBiPcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730432839; c=relaxed/simple;
	bh=busQLR7otaeWXNCbtoVc5P9C1V6mcuvpvKlwtawqLwQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HhQgGxBaP4BaCjYqqZu13Sw0IgF3dzgJ3233+7/KDiFnChhz9la9wFHn59GgBZQ8n2HqTiosS7DwWGe69zY7qEtNd1/PSzTbs+Q9b/HYChxp9SJ+nYnKlBvUABmCH6lo1Ehu+wffc7a6ZUrfHbvVfReE3CdNrWDUXgkHqs4yX5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QyYb2Dck; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730432837; x=1761968837;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=busQLR7otaeWXNCbtoVc5P9C1V6mcuvpvKlwtawqLwQ=;
  b=QyYb2DckYLRL7I2VLTxm+0wJJPzCOpR37toQVWw5TttjYa/3XzgcNEBZ
   BhCz3InaS5kZ+1V4PGfH4/ifwYJ8CgmTov+VAUzuVccy9V8Pkit2HWrRw
   U14eqgpiWFXfCNy6Gx70qshLtc/VUSdcxdwxOs7fS5b944yvUFTOzB4E3
   GV9AdsVzWF4GBn2D++/zu1mWnE9WPS3T05MmbQGBpket58ITKVUrse/4S
   neNAWfdgK6jh/6KBLTAw0tYGSQr7MeV/MKu0NTb04QyJeMf49/am4aQ/Q
   F84/HQds0w5F8c5rrFH3fCeLlFtTfDNskrsGcPE8M7D1HyXsiAih1yVjn
   g==;
X-CSE-ConnectionGUID: zZkvdI1rQgGWCryzA67W+A==
X-CSE-MsgGUID: tUAiCJEBRziC9K9+iUsiXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30384967"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30384967"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 20:47:16 -0700
X-CSE-ConnectionGUID: CnrrLtjmTNmqCUO9Uzvxlw==
X-CSE-MsgGUID: iy1WUsd7Rgaeg/O3nS7p8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; 
   d="scan'208";a="86784802"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2024 20:47:15 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 20:47:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 31 Oct 2024 20:47:14 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 20:47:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygfjVNYOqygNmNQ7T6SeijiEsS8jhSBzF0/qepYF7/x5J3yc4eVX90bHIt3nrY86e9bltDBE6QjvC9z748VaDoxx6tCesAp6XhliTitc769vkdkc217I1+57NUWsfgXcvd9G25Gcm3rBBmSx6zmuFQfqgUz6GCVEos1JJd16OlCVTilD4kes7Xo4/KpHcSWs4LvsLr13lPrhPl+1wRGLFiHqkHOwvGBSRH+EiUw7LDlTSsdpCZY4GGEssj0b5zFDgOXl7PCueejsydYSBhh/ZdPyIZESfTBROrpyV9Hx+xjUJazZBwkDXpwEwEL9dZuv7laPBaQkb4KC6qx2mSvlIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqvM2tDFMp/+bnePeXmx1CNbMXA8etN34xG/3F+oq6M=;
 b=plnBS/kHquhLVk0bE+ggK4HrsnJEyemy3SHn5ogC/8TnnXnbvNDP0V0UbdBe2GzJtjyFw4FW7KAuwd1rx8Te7l00hySCgRT8FlWrX29AeiKuO+JqbAxJbpKNew9QmpAm0eJe8jmd34sTdLyRBLoyKWja0KvF4kypaROOBuuuyst0XbjnwPSBuP7Zp14tLPinLfS6UYxCpa7gGK4ZzgPp15qVUZHgOXYsVXAyShYvbobZmu812VC2SJ6KmF2DdZ4YieYiMWRKM44utE423ksT7fCNyWlaLmwUbc1xxPYdVezfxMNusg80wB7/VsVYqwKxI7CpynPfyQ8C3apJWZAhdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by IA1PR11MB6323.namprd11.prod.outlook.com (2603:10b6:208:389::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 03:47:10 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3%3]) with mapi id 15.20.8114.023; Fri, 1 Nov 2024
 03:47:10 +0000
Message-ID: <cd033a99-014c-4b41-bfca-7b893604fe5a@intel.com>
Date: Thu, 31 Oct 2024 22:47:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 7/7] docs: networking: Describe irq suspension
To: Joe Damato <jdamato@fastly.com>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <namangulati@google.com>, <edumazet@google.com>,
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
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20241101004846.32532-8-jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::13) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|IA1PR11MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 1379c5a6-8745-4c49-4591-08dcfa27dd2c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkd3NTVUM3BmdTNsdFdodVduVVNNUlgzNStYMUtUREpqK0JwTmR4VFdtSTRH?=
 =?utf-8?B?Um5EU0tvQWF6VVlmc3RaRmRxSFFTTkNrTTRtSzB3K0IwSnd4SGpQTFpNMXVm?=
 =?utf-8?B?MnBzQmdtM1dNVEQ2em1lQkgwaVFKcFJSVk5LTFUyNVQ2ajBvdFNsUHJqa0dv?=
 =?utf-8?B?NmRkS3ZYckhRODA2eENNd0R5MVpCMElGRWlPZzdOTU5CMERqTlJSelc1S1po?=
 =?utf-8?B?VndTbEhLTHhJbTErc2FMeVQ1U3FUWkUvT2YzeTdjbG5OdE5wMkNyZVVEUWtR?=
 =?utf-8?B?Qm9JUWNacmFpTE43L1ZDWU9UbWtqdXV5ZE9Za2hhYkxZN1VIRGxlT3BsT3RX?=
 =?utf-8?B?U2xNL1Y5b3ZDMlFFaDVvZWVXRXFIR1NIWmU0anppdGdsdWxCOFJRUUVhdHNo?=
 =?utf-8?B?bllNa01kaUdyU1BZbTNtQUM0U3hpNnlsczBkblRmaGk5WDdiNXVYRzEvOFdB?=
 =?utf-8?B?MmEyRVpFMysrbjhLbjQwQkZJUEV3RWZ5VVBBMDduS2crOFNYZzRBNnNURzkx?=
 =?utf-8?B?MThGOS91TkdCMFNSRWhzNkVrQ3V1WFZWSnR3UmRVS1BWS3UzcHU4UE1Pd3Ax?=
 =?utf-8?B?Wmt1b0o2d1pJOTZHaER1Q0phQ1MrTytjZENIbCs2SXhQOEZjR3Y0WXpyUVNv?=
 =?utf-8?B?OXV6UnFzQ1pqbFhBczVvSTAxRStnYkZ0MU1nZ2FYMkVFNGsvamsrMC9PYVVH?=
 =?utf-8?B?ZEZ3UmhkTVRpMG45VGdvcE9ZVjhWaXhlV3pZQ0J4azVlQkN3dlI0Mmp3VGlT?=
 =?utf-8?B?aGpjbUpSajlucktVOEZhdXRTdk9WYmcwQ040Q3VrNkUva1p5aWxuSWx6SVJY?=
 =?utf-8?B?R1ZiYng3SUx2MGU5ZVdVN09oRUpMc3JyMUxpZkJBK0ZnSWRjdWI2MHBLemJI?=
 =?utf-8?B?V05NUmIyempuSmkvcjlpOUVBQXVmMW9tZUg4QXg4MCtzNkVrQ1NYeEV5Y2JN?=
 =?utf-8?B?WXh0U1lQWUZVbFBqYXhnVFZYYTRGTU5TMi94MEo2SGZsd0ZzUmFWcjNxeGZE?=
 =?utf-8?B?cVlMbmFieWRWRjRBWEt1ZExTZytuZnhWeVB1U2l0TWNKSDh0N2FMczI1dDFH?=
 =?utf-8?B?SkVrZ1Yya0dGbUYwUTRkOVFmcmcvZFNabnZZYXFCeHl0QXJUaHhJV0VGekJk?=
 =?utf-8?B?Y0ZRRERsVnJkWDBYa2ljNFhmd3ZNaUlVaWMxS0NIVE1ueEJ0S2RVOFpmTVlq?=
 =?utf-8?B?UTdKcHhpTXA3MU1YWFVKazlMdXJGdFozOWp0ZlhsNDM1UGl3Mk1GUmxhakw5?=
 =?utf-8?B?QVNhNjRYbUN3VUw2RDdsY21sNUJScjNtZS9oMWY1RXRuL0FjYmhxeDhhNzFn?=
 =?utf-8?B?TGZaZk5pcmdIc1VQMzdXa0FYbmdiRFE3c3JVUE1MbmhSdGVuTVdmT0hpZjBa?=
 =?utf-8?B?ZWc5eEUzSVRVSjRzQ1AyekMvOGxMSnVJRHRMZzNWbnpJL0w4aTV2N0FjZGxJ?=
 =?utf-8?B?ZXdUbmNsK203cEpiQy9HNkViWDgydGE4bDNTQW1pazZ0VUoyVjNHeG5IZkU3?=
 =?utf-8?B?R1kwSU9DYzhBUG95WTZoNjVieTZwSGI2azBCNmZ6TzduY3UwZFBtWmQvd2hM?=
 =?utf-8?B?Uk9nenpiaCtXeU90TjYrYURxTWVXZGpMYzNxM2pGQnhuTmc0UWd0dUF4UHlM?=
 =?utf-8?B?cnlTa1VuTXpUcXpoYjZDSDVRdVBTYXNHNy9LOW55emp4MHNtbEJpMzUzd0t4?=
 =?utf-8?B?U3hBZUhsdVB5UHNIYmswT1BHQzFtNVFUSEFQdlFJZWJ5NW1uV0NyaHRjQk5V?=
 =?utf-8?Q?soqDzAnEVRFI3jWbPLa0jwLJfxugF0wDBRKOfzA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1lRMEV2TDA0SFhFQXY0U2w4RlVCWkZ1SVRTcVJyUzByWUlXUEFHSGdxLzhT?=
 =?utf-8?B?OHk3Q2dqQkJkNnlXeHBJajVPNDNWbGx2VXVJcXdYSjlzRWJHOEtFN0pvM0ti?=
 =?utf-8?B?b0JoRlVvZm1uc2h2aTJjYkhqcE5CM0JjZXBQZ0xxY2QzYmVTQnZXdU53TXRW?=
 =?utf-8?B?dExONWhoU2o4OVRBNmhrdmdFVEJ2c29JOXdSOW5XWDdCeWR5WFJhWklGcy9V?=
 =?utf-8?B?SzI2YllKT01XYUoxVFZDOWJqczV0YThWeE4za2VMMGNBVGlaOFM2d2VqZnJW?=
 =?utf-8?B?YmpVRENhL0U0elBXYjlEZlhiUnV1MXhrUmliZHdyV3pIMlJpZUJYZG43aDIy?=
 =?utf-8?B?SmkraCs5Y0JZampremxVZXk4Ujl2bGpURFNjR21INFJCREhOYlVvQmV1VU5j?=
 =?utf-8?B?WVdOZzJmdWlOakFndk5ZVEJOQXZxY2xRQmxNM0JIZktGU2xIbi92TVIwWFVr?=
 =?utf-8?B?MHlCVHVPQVNldVpIY3BVTDJzeTJjS1VXY05COFY1Wjc4UmJvazY1eERXdEVK?=
 =?utf-8?B?Y1Bkb3ZLbXpIdmZNQmh5U3NLc3NtMlJldFBtWnhLYmliaFpiaVhpbWp0dUdI?=
 =?utf-8?B?SnpmbGhPSEtmZENUcnNxVVhpbm0xS3hBVzlxOXFqSkM5R2NkUEd1ZHFKUWRq?=
 =?utf-8?B?T2lYNlcwWEZGNVJXYlgxbER1QTdLcTdtYzMvNVp5VmNhQUplaXhQT3AySmQ3?=
 =?utf-8?B?dGJjaUVEcnhpSDU4VzZiTnJrUktXOStNZVljTWNlclRjTXpFd3lTaXUyajJi?=
 =?utf-8?B?QkMxT25iWjgrd1MveTFDamV5N2prVzRwaVp2VEQrZnhSQUVESVlVMmpoVlV2?=
 =?utf-8?B?UzRGUkFWcEZ2ZURJZW8yMms1YmhiSkNvZXNKT2ttTVNNWFRNU0VwYVprb3Mv?=
 =?utf-8?B?alhmVXN2VEN4Zm1EVTRNMnZ2UFh6alZjWHdZQ09TQTB6QTRlRmlYdE9SaHJR?=
 =?utf-8?B?QUhwQ2FXV2V4SFZ6YVZ1bTY4dG5IRGdIYWVSV1RXajBRME9aU1Z3RWJncGcy?=
 =?utf-8?B?QllwV2F5cDByalhsVXpPZGRzdDlYVzRDaUw3a1Zka0pTYzgyWVBuZEJ5dThW?=
 =?utf-8?B?TDlFS2E3NUg4NEplWDRuaTlNa0p4Y1k5VWtFUlMxU2loZDU2OW1iL00zdmVD?=
 =?utf-8?B?bldpNTJiclFlKzRkVU94OFZKQlA0YlRhSysvUHBSZ29leWRnMjZjWGo3S25N?=
 =?utf-8?B?TDBjZ2NCTHg1SnErc280TEFUdm9RNUVVSUlkcE9ITkwxd3NTQUE0bEg0K3pP?=
 =?utf-8?B?SVZyMmtCZTVZYnJ1Qm9Hc2pkalVnR3NNRm1heHI4QURaeWs0TGRhOHBkMDMw?=
 =?utf-8?B?RWcyY3REU1VmWHBMUk9SNDlEaFh5UU16Ylp1MHVpb0JwM05SaTh5SllZTE8w?=
 =?utf-8?B?YTlUWDFRcWN2OFg4RGJYUS9lMXJsU2krRUROYkF2bzlUa2UwY3NnUjg1UkpY?=
 =?utf-8?B?YlRzYmhpeXJuUEw3NTQvZ2paN2IvaERaamE0dmJCRlEwSkw3azZ3SzJwMkJw?=
 =?utf-8?B?L1FMdWVHc3dsaWEyWWd0eXp5dXh0TnkrTWUrS3QyQ3A4Z3BtenhEVk1ZT0lt?=
 =?utf-8?B?andyVHliMVpobkJhTmYvcDdqK3Q3UnNFeDV1ZklnWFNkdzdBRnNEcXcreEx6?=
 =?utf-8?B?REdObG94cVJiMUQ5VW43NHlMbU85TkZoeENrM2lRZHZaSWtBYlJsU3ZYT28v?=
 =?utf-8?B?cklqaGRNY3N3VUhERTk3VDZPdVo3SVRSSER6bHRRYnNYRjJJVE9RQ2Yydmwz?=
 =?utf-8?B?SXo1YTZEY1hlbzdVc2VxZ1ltTlNJYi9TZFhvazZBZFIxSm14SjFUZ2NkNE9j?=
 =?utf-8?B?RkZSK3VFbzVIUitYUmlUbDRScFduUWVZb1c3MUZPM2pMZDkyaVR0OGtLWW03?=
 =?utf-8?B?WGJqK1hYcEo4MGp5cmpMc21nYTNQd0hYOVBLVy9adWwyODNudjRBMFluVWV5?=
 =?utf-8?B?WDRVZktBaldFMnJKWC9nRDZXWlZZRkRaaURLOHliZXQ2VFhlVGdHVStxM0Uv?=
 =?utf-8?B?VTJ2Ulh2djdUVVl3YVU3dzRLcXR3QWNDUEVjQ3pxTjNGNjVFeFd3RzJSNy85?=
 =?utf-8?B?K3U0OG5xenlCWHhvaXNoZDN2dStwcVozYVpCZWs0RVFOMlZhQXFNWG4rQ1lp?=
 =?utf-8?B?aVQ2ZkNPbVFaLzB0eGVsR3ZOMFNxWHUzczU2OHBtMSs4OGFYYW4vV2VNekho?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1379c5a6-8745-4c49-4591-08dcfa27dd2c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 03:47:10.3187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVdLd1JFK2gDoZh9YhiKXDcMwevXlVrEh7epXSLGvfgO4CqBwUcA2//GFxDkjhgHuUGVfRsPb4r3elC+IRIDqQ1IlyahpsJjnrJ4t00CCek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6323
X-OriginatorOrg: intel.com



On 10/31/2024 7:48 PM, Joe Damato wrote:
> Describe irq suspension, the epoll ioctls, and the tradeoffs of using
> different gro_flush_timeout values.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Co-developed-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
<snip>


> +
> +IRQ suspension
> +--------------
> +
> +IRQ suspension is a mechanism wherein device IRQs are masked while epoll
> +triggers NAPI packet processing.
> +
> +While application calls to epoll_wait successfully retrieve events, the kernel will
> +defer the IRQ suspension timer. If the kernel does not retrieve any events
> +while busy polling (for example, because network traffic levels subsided), IRQ
> +suspension is disabled and the IRQ mitigation strategies described above are
> +engaged.
> +
> +This allows users to balance CPU consumption with network processing
> +efficiency.
> +
> +To use this mechanism:
> +
> +  1. The per-NAPI config parameter ``irq_suspend_timeout`` should be set to the
> +     maximum time (in nanoseconds) the application can have its IRQs
> +     suspended. This is done using netlink, as described above. This timeout
> +     serves as a safety mechanism to restart IRQ driver interrupt processing if
> +     the application has stalled. This value should be chosen so that it covers
> +     the amount of time the user application needs to process data from its
> +     call to epoll_wait, noting that applications can control how much data
> +     they retrieve by setting ``max_events`` when calling epoll_wait.
> +
> +  2. The sysfs parameter or per-NAPI config parameters ``gro_flush_timeout``
> +     and ``napi_defer_hard_irqs`` can be set to low values. They will be used
> +     to defer IRQs after busy poll has found no data.

Is it required to set gro_flush_timeout and napi_defer_hard_irqs when 
irq_suspend_timeout is set? Doesn't it override any smaller 
gro_flush_timeout value?


> +
> +  3. The ``prefer_busy_poll`` flag must be set to true. This can be done using
> +     the ``EPIOCSPARAMS`` ioctl as described above.
> +
> +  4. The application uses epoll as described above to trigger NAPI packet
> +     processing.
> +
> +As mentioned above, as long as subsequent calls to epoll_wait return events to
> +userland, the ``irq_suspend_timeout`` is deferred and IRQs are disabled. This
> +allows the application to process data without interference.
> +
> +Once a call to epoll_wait results in no events being found, IRQ suspension is
> +automatically disabled and the ``gro_flush_timeout`` and
> +``napi_defer_hard_irqs`` mitigation mechanisms take over.
> +
> +It is expected that ``irq_suspend_timeout`` will be set to a value much larger
> +than ``gro_flush_timeout`` as ``irq_suspend_timeout`` should suspend IRQs for
> +the duration of one userland processing cycle.
>   
>   .. _threaded:
>   


