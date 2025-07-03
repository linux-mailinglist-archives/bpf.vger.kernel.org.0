Return-Path: <bpf+bounces-62276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DD8AF7421
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81FE81C227E7
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 12:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5098E2E6D02;
	Thu,  3 Jul 2025 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cj+TPU9I"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30672E6119;
	Thu,  3 Jul 2025 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545790; cv=fail; b=k5Gqk6eztrW5Bgn6gnXw0sMzCOrnxaAl0RevjI8SYGfNjQEBVizJ1r9vQGaY+Vm9E9Um64RIXoNFlJ2279c57CSe+p/HN76R9RCDFe9rKzUff5chbdI+NCM2aOe+TzpqfsnR3G230emdebD19SMW/lhPFLszLRmNhic3kB12FOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545790; c=relaxed/simple;
	bh=m0DVQxaK7EthcfyzGdWn/TBEbSpdox1Tni5/oy41YDA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sPHMhlGjXKTYp1YfZxn6ByeWKOlDJj7+FxY2NQ+i+J7sZZWNd5/r+vzOfdEdiG6y6o3o1LS9PHOekxqxMbePmYc5SpDsYHaHc5IiSYtRfa7S6ijdMzSE/CBVhv6K++xznUA3+ws0jJDgqza/74p2tv1qbge4+GkvLMs20CZsxJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cj+TPU9I; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751545789; x=1783081789;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=m0DVQxaK7EthcfyzGdWn/TBEbSpdox1Tni5/oy41YDA=;
  b=cj+TPU9IxWn21ybfmxV8yaV5GzDYa/cbuaLfvQpX1vP6gw1xp5WFsQ4S
   7IzLttz2KRiwG3qc/oDz3d8Ts8cKoEBBb+ZnRRgHChwbJNZlzaGCqjWHM
   +BcWrg8QIm7olYc521LEArrD/HTeiT+CJhkWj8NRYCP0C2nIj/AUnofxW
   QKqwPtSwAmylvp39X+P4ZGjwAtHfD+P4erpJ+EfBx1mkxZ/4XmLbz4wMW
   1g+kAoWBw6lPT0P+MewyUP3b+NZaby94vYBY4/Sk23QweSyOO2oFfEpuH
   NhAH8arsjTmaGIKDD3vEPPIUgWoOQOk6gGOp5XJqMmYpyXg6VxxRw0cUM
   A==;
X-CSE-ConnectionGUID: MKJFHxxuQBCYfJQmlkA+Ew==
X-CSE-MsgGUID: XKQGQeRSTTy1yzwzA9m0Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="65324005"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="65324005"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 05:29:48 -0700
X-CSE-ConnectionGUID: ZkKuAj5JRfiaumm+hLYwGg==
X-CSE-MsgGUID: jJHGiIQ9S7i8CeAA0QixVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="160053917"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 05:29:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 05:29:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 05:29:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 05:29:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwSrE00swu4rTX2c5XRDofRz4aCG/VUuM7OJ1mBTbctNdNcD+mRbxGs3IatVumJyk2y8wPb80isNo2m5khogbKH4OdD8K9qzKRxHPQB0W9CsAW+rsLrxXiI0zQLcobrBjwzsd6AKELgKav1Rg38dyNm/jDCEkMrOOuOx4+srDcxXPI+qD6QVzIwaVeEKFyQ7PBA5lrcSi4ZkhVI4x4Jgc0b1ktL5oWffJM4tUluo2kNcaqvPTQEIFBv+AQcz6G7GbRCPepVvNmDCtJg0cVdMEZKZzp/LcH5mbn2il8LKSpn/RyOoff610pLoFp+mJkc0byELMnCTh+9G/9qeWDLqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olCd8wHxii+tHAQhxLSXQX5goNbxHK6XspL8vrhpccY=;
 b=iyFs6J7UryrX2bwq51l8qNaG2kFw5GE2cKh3S+lUYhXBthsKKK6D45JHWDAunl5sxbEJPcBTF3MVvlEu9Fh/tZz1xylm/71BqH/TXuZrMIaWGN3y2Te6SFfywGWW0bfKQQsQCS+xi6wpijq1a7Euf1vyECPcZpR4K8PF4XURKFurWM6btUZHDLx6dcUjRD/BZ+L6NT+kvwM6d26/ckEhT0lWbIniZQX+RfIOFIqttrMlHjLzx5P8fEnCpwE0p/bTrnDbsT6ag6TMgfPszfStZ7KAdduUVSt/6xuNl8C+4prKubCParB49N3lN/iuc14ZUwDiOT4BdqafbjekBluxiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH8PR11MB7120.namprd11.prod.outlook.com (2603:10b6:510:214::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Thu, 3 Jul
 2025 12:29:18 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%6]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 12:29:18 +0000
Date: Thu, 3 Jul 2025 14:29:12 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>, <sdf@fomichev.me>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <joe@dama.to>, <willemdebruijn.kernel@gmail.com>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>, Jason Xing
	<kernelxing@tencent.com>
Subject: Re: [PATCH net-next v6] net: xsk: introduce XDP_MAX_TX_BUDGET
 set/getsockopt
Message-ID: <aGZ3mJnFSsAxv7z6@boxer>
References: <20250627110121.73228-1-kerneljasonxing@gmail.com>
 <af16a28a-18b9-4d45-9ab9-1b150988b7d5@redhat.com>
 <CAL+tcoDa13Gzdzv7NOSVwWDZV86w7NgJniT1jMqe2FCw1psHFg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDa13Gzdzv7NOSVwWDZV86w7NgJniT1jMqe2FCw1psHFg@mail.gmail.com>
X-ClientProxiedBy: LO3P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::8) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|PH8PR11MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: fe655b2f-b364-449b-68c0-08ddba2d3ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dW9taVdHd3I3aDd6dVFoRU9GdWEwMlJoVlZMZEFza1hVWG91dzRqMDZhdmdS?=
 =?utf-8?B?ajEvemdEcmY1NHcxK0l0K0pqVWp2cVlPT3M4ci90RmpvdXEyQVl6UWI5VC9J?=
 =?utf-8?B?OW9FNzEranhEblZncjd6YW95d1c1enZSTDBXR1FjYUFSSmFqTldubGZ0MXc3?=
 =?utf-8?B?ekJRTEhXcUpWcE9mNFhyaEcyWkdleHdIdEp0ZGNvVkN2enN2T0tubmdhZ0Jx?=
 =?utf-8?B?Y3VTUnR4Sk0xaUhTNTloWUFQdkxtZXhXeDQ0Y0lhb05oRFdMbmhnSGU3Y3pE?=
 =?utf-8?B?U3MvdURpaG1ScitZS0duOHowUjVmKyt3Y0tUb2JEbzB5eHYxQ1BBa1FkaGhG?=
 =?utf-8?B?LzAyN1VlQ2ZteGttUkVFSGRteFZGNWN0L21QSmJPQmtMNGRLTjdXbDVEYkVC?=
 =?utf-8?B?NlpuYXNnUCtFa242d0R2dk11bmFqZXB6eUZjei9EK3Rvc01zU3krYkZOMndM?=
 =?utf-8?B?cW4wamlEL2lPUlR0OUxOSXNXVE5JMi9hVEdLdWtpMW5tQlFMZXdYYkxITS9x?=
 =?utf-8?B?UGRiVm5kUElnV3AzNzlnVFhpTWdzUkZjOXNMMDRGdVNibXdpMlNZT1VZNmRi?=
 =?utf-8?B?anFTQk5PVnVUT01zWEJXS05sNGZKY0hBbjVGM1djZ3ViUVNIczhKS0FrNWQ0?=
 =?utf-8?B?bUZyRWRnUDY3TkV6NmZKbE84bC8ybkI4c1hScDErMHdMelM4eFlLYWNPL0tH?=
 =?utf-8?B?bHpkNHZSWklIK0F6dW5NckdJYXFlb1A4d2czVThqa1k2U3MxWHpwbjJWTVhz?=
 =?utf-8?B?Y2ZQYXRKTjZ4L3BEdC9mSVpWT05LNUJTcFlScHNPdnRSKzJkOC85UUdGUG5B?=
 =?utf-8?B?YXpZQ0ZuTXd0MFN6b0NRVzB6UjBnSzhDb0diMUloM3EwVFQ3SXl0OHlzckJR?=
 =?utf-8?B?elVMNlp1SEttYUZndjVIUGVlcTkxQTdjUXVyZCtRcXhkeEdaWE5yUk5CSEpG?=
 =?utf-8?B?TUsrbWovRjZNZkJ2T1JpanQwYjNUSVVjLzFJK0ZMTVMrZ1dvNVVldGtNYSs3?=
 =?utf-8?B?MHkzS1cxYng3ak45RWxkTXF6SVdnK29RMmxOZ05YTVB1aXIzak1RUUZuRE1K?=
 =?utf-8?B?RjY3UnBpNURudzY1MWN4REd5Q0t0UmdwcHBTb2pRRVJNTC9CaUtDRzdEUko3?=
 =?utf-8?B?SGMvL215U1VtcXppem90YVBsZk9rZHNHaWRkR3A1TmQ0ZlFDRFF2NUNQOGxo?=
 =?utf-8?B?WEt1dXAvUVRVWlRrRDZrRG1ueHZoWksxT1IvU1h1ZVc4RHY5bkl1dXVQSVo3?=
 =?utf-8?B?U1NYOFcwbXBwVEFKV2pGUVBzRWlUdkRDdEI3dm5nd081NGsxZ255QVRJdm5T?=
 =?utf-8?B?UjRRVFRxVERWSlh0MkdsZmJ2Yk9FcEFiZWphQjl4M29nVjFwNEREQWVtTXBS?=
 =?utf-8?B?bksrMEwxVGVGSGd5VG9QL1F1eUwzUFhvY0VpQlJURnRwNmoyTHdXdXhmVTJ2?=
 =?utf-8?B?aFZhYllRdyt1bzRlbUhFS3BrYkVVVy8vTGxDRmowbWx1UXU1dXJBL0pNR012?=
 =?utf-8?B?aUR3bUwvRnBsTTgvcGtKb3JzNlRENDNKejg1UWhBSmQrZFBtNkN4SXN4R05E?=
 =?utf-8?B?MlZteWJwbEFMREJnUzhHRU5LWFNHL05keXVLMzBWTkdNYWFpVVRPT2wxemdR?=
 =?utf-8?B?cW1vN3BESjB2NlAxVlRyb1BqbVBKaWIvV3lPWGlIK2NpSlhETVhrYXlxcm0w?=
 =?utf-8?B?TjBRSEpsT01SUVBRRW9hMktBZVNrd1VMa21qb0ZGcDlSbG9BdkkwbDEzbWRY?=
 =?utf-8?B?ZjBkRU5WYkc5UHN1UGU2cHI3bllRYlljUER1Z1VoRHg1bGtzdkNWcHFJUGY0?=
 =?utf-8?B?LzNleU5UemtHclFxUmxFQnczTFRCUzVRWHY4V0QvRzAyYUhKdW9JL3dQcnd5?=
 =?utf-8?B?WVlwUzFiTHVTMHB3SDZtdW5OKzJ2elp6ZlVRSDRMT3JBTmp6SEtkOHlCN2h4?=
 =?utf-8?Q?zfT6vY5tTu0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2o1RFhkSDhsNDNoYmJYK2JvMk5BV0dvMXpHd29HQTloQXRVd2Z5eEhiNncv?=
 =?utf-8?B?Sll0bENETXhoektLbnc0NlBLUVJud2JNdzhEd0ozdEtuZkRaaDRXTU5QSHBW?=
 =?utf-8?B?dHhKdWtWS21QR1VoMENuSVdrUFZSd0diMkN6YXg5Si9aeW0zOFE4cGlIcENL?=
 =?utf-8?B?QWhDZ0hRazEycmd0eGEzckw2Ykh3UmRFc3Z6WjROZkFkVGNDU2ZjTDhlbm5z?=
 =?utf-8?B?R1NhRFZpK3M4MTloMWFPOFkzZlZPSy80d0RFZWRqbE02VE15N1ZWeTQ5dldF?=
 =?utf-8?B?YkdNenlVWWtJRGNLWjhkcFNwQlNoL0xKZWdtb3NkK1g5VjZidU1WeE9iem1V?=
 =?utf-8?B?NWoza3dyamJTMmtEKzZ1Zk5DcllMbWNvMmhENnA1eS9vRDY4RWthdTF1MEha?=
 =?utf-8?B?TE1QdFhxUHU4SGhpaytoRCtQcndnOWV6RC9HQUVkMDNzTlBBZlNZQnRHelN1?=
 =?utf-8?B?Y2YrR0Z2eE52VEozN0kvREpSQzd4eEVtV25vdU1Lc3h1eDRacUtmdndMU3ZD?=
 =?utf-8?B?Z3lqamRHQm9mbzdGVlU1N1FYVHRRRkgvSE1nV1hBeEx3QnJxTVNFVmtkS3lX?=
 =?utf-8?B?bUYvdFhQUzRXL1JudFd2b1M2aE5JNitjUHQwUFA0WWVNanMxSmFWMndMSDlk?=
 =?utf-8?B?V0pSczJ2UUk3anJOWUhYYXI5a3Bhb2FGYVZBdzQ5Ym9Hdy8vQ2trWEpMczBO?=
 =?utf-8?B?OHVHMzByZzNsTzFtTU9iVWs4dFplL2xOMzdVSHpWWXFvQkhZVXdmWnR3amtW?=
 =?utf-8?B?L0xoZnF6SUJRM3I2Zzd4NFRWQ2VTWmU4VWh1NWZVaTNWTEg4dXRFcjNwY21Z?=
 =?utf-8?B?TUd6ZWhETHdjVjdBdjg4ajJaalgySHlrWDBYdjIxSVQrNzBDL0o3UjluZkxG?=
 =?utf-8?B?QzV2eHEyZ0cvelRKRkdReS9uWXovckZpU3hzUkF0UmwrVG9uL3dqYm9VTFlJ?=
 =?utf-8?B?NlBJSmdzQUpjR3h1cUQwUWVoeXV3T21lcnlEKzZvcFI2VFh2MGltR2FLaXhZ?=
 =?utf-8?B?aExVWkhkRFE3RmtXTHoweWlHVGdwRlhrbnpwNE53VkdYbVFqUnNyeU1sb0RB?=
 =?utf-8?B?a2hIOTVEMnlKRFArdVUySDBFb2NOVC9kTTlObC91K0FyMkpRaTlmK2hvamJ5?=
 =?utf-8?B?dVdjcUJDR2hxWklJNmNXYUZHUGptd2Zia1EvdXVJVEZ6bWpUYUkvWDlZbUJi?=
 =?utf-8?B?dGxoQ3NzcTJBZVFxNkxFNm9GbWtkTVlWK2luUGM2MEJyUEt4Nmd3MzR2cWRh?=
 =?utf-8?B?Qk8wVnVQM3VhR0E4YjNxZlJKaGd5c1JiMzZ4VE1XcWhEVVhiMVpUT1NIQ2tp?=
 =?utf-8?B?bCt2VjkyN0hDN1ppWjNUa2FBdnJET0ZCTkxlR1RnZ1ZRSE8zY1owb0taZEpG?=
 =?utf-8?B?b0xRTXpGejhRdmpHRXFQOU4rTEtmOGpNTmdYR01qYWdRME1qOWlIaytDWXkz?=
 =?utf-8?B?WEQxTC8vQmFyM1ZNcVBiZWRXWk9GUDBLaUJ1TzZ4cnNCaFNIRWFWOUpIRWNC?=
 =?utf-8?B?Q0ZVUk93YVBWVmVuYWRTL0JMRHg3ZlYxcmhpUnFOUDMvdEFDcXBFODU4dEJR?=
 =?utf-8?B?NHNjbmVBMndxWlB4ZFRTM2h4dEJSK2gwODBwN2QraTByOERmK1plYlJjelpQ?=
 =?utf-8?B?aDVYaEwwUDArY1lIa0xMY2x2azZqa0ZoenFVUWJ4Zi9qdVllSkVIdFJscUc2?=
 =?utf-8?B?VHFZWTJ1czc0Sm1HUEhiNkhMQjR6SHF1US9DakE1djJLUVlzcXFNMUcyUFVx?=
 =?utf-8?B?MCtUY2JYMDNlNjJQckx6VEcrQ0tidmMvdUlzQTNBTERmTll3Z0FaYTdVK2pU?=
 =?utf-8?B?dmdvRVBZWCtKSitBTHJQYmxFMTU1U0N0cFM4QjB5SlRzYXZRMHNsK3pGR1pu?=
 =?utf-8?B?R0V0b3BwWUR6VFJWR0Rtd1lGcnE0SzRxcHBLWjFhL1p2UkxmVzJZd3VOMGxo?=
 =?utf-8?B?eGx4a0tFdDRQYTh2SFBCSnNEWHl6UGJjOXRUdU9GSTJzRGYxQk9nMUFXTFpo?=
 =?utf-8?B?WEd3ckNtWkRleWljMHdvQ1ZOWHY5cUJtdlI3a05GeFVnTDdlR0FydjNoQXly?=
 =?utf-8?B?cWlCVjZyamFmUGUwVmhlblRBc1NOd0hkc2J5WUJ5Q0lZS1RkN2lFa044SjF5?=
 =?utf-8?B?Y0pwVlBWUVo0Y0JhUnNjMno5Qm16NkR4YUhvZ1hHUWpkZ3c3R09jSFNjZkV4?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe655b2f-b364-449b-68c0-08ddba2d3ae0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 12:29:18.2016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btlocbZiqStSd/4ZwSXI6vTYJAkG/euWGjUkFg6r1n05n3mLAyaZ6PurkwlWOkAJ6RNgw9uqr8xyKJEQJjNFBOcOceRX5BKKL+FcJrn58Dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7120
X-OriginatorOrg: intel.com

On Thu, Jul 03, 2025 at 04:22:21PM +0800, Jason Xing wrote:
> On Thu, Jul 3, 2025 at 4:15 PM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On 6/27/25 1:01 PM, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > This patch provides a setsockopt method to let applications leverage to
> > > adjust how many descs to be handled at most in one send syscall. It
> > > mitigates the situation where the default value (32) that is too small
> > > leads to higher frequency of triggering send syscall.
> > >
> > > Considering the prosperity/complexity the applications have, there is no
> > > absolutely ideal suggestion fitting all cases. So keep 32 as its default
> > > value like before.
> > >
> > > The patch does the following things:
> > > - Add XDP_MAX_TX_BUDGET socket option.
> > > - Convert TX_BATCH_SIZE to tx_budget_spent.
> > > - Set tx_budget_spent to 32 by default in the initialization phase as a
> > >   per-socket granular control. 32 is also the min value for
> > >   tx_budget_spent.
> > > - Set the range of tx_budget_spent as [32, xs->tx->nentries].
> > >
> > > The idea behind this comes out of real workloads in production. We use a
> > > user-level stack with xsk support to accelerate sending packets and
> > > minimize triggering syscalls. When the packets are aggregated, it's not
> > > hard to hit the upper bound (namely, 32). The moment user-space stack
> > > fetches the -EAGAIN error number passed from sendto(), it will loop to try
> > > again until all the expected descs from tx ring are sent out to the driver.
> > > Enlarging the XDP_MAX_TX_BUDGET value contributes to less frequency of
> > > sendto() and higher throughput/PPS.
> > >
> > > Here is what I did in production, along with some numbers as follows:
> > > For one application I saw lately, I suggested using 128 as max_tx_budget
> > > because I saw two limitations without changing any default configuration:
> > > 1) XDP_MAX_TX_BUDGET, 2) socket sndbuf which is 212992 decided by
> > > net.core.wmem_default. As to XDP_MAX_TX_BUDGET, the scenario behind
> > > this was I counted how many descs are transmitted to the driver at one
> > > time of sendto() based on [1] patch and then I calculated the
> > > possibility of hitting the upper bound. Finally I chose 128 as a
> > > suitable value because 1) it covers most of the cases, 2) a higher
> > > number would not bring evident results. After twisting the parameters,
> > > a stable improvement of around 4% for both PPS and throughput and less
> > > resources consumption were found to be observed by strace -c -p xxx:
> > > 1) %time was decreased by 7.8%
> > > 2) error counter was decreased from 18367 to 572
> > >
> > > [1]: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxing@gmail.com/
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >
> > LGTM, waiting a little more for an explicit an ack from XDP maintainers.
> 
> Thanks. No problem.

Hey! i did review. Jason sorry but I got confused that you need to sort
out the performance results on your side, hence the silence.

> 
> >
> > Side note: it could be useful to extend the xdp selftest to trigger the
> > new code path.
> 
> Roger that, sir. I will do it after this gets merged, maybe later this
> month, still studying for various tests in recent days :)

IMHO nothing worth testing with this patch per-se, it's rather the matter
of performance.

I would like however to ask you for follow-up with patch against xdpsock
that adds support for using this new setsockopt (once we accept this onto
kernel).

> 
> Thanks,
> Jason

