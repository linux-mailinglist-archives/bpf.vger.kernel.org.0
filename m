Return-Path: <bpf+bounces-42320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D179A289A
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 18:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4090282077
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 16:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDB51DF26D;
	Thu, 17 Oct 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZfeq9t7"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B21DEFFB;
	Thu, 17 Oct 2024 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182350; cv=fail; b=pB8MrvkagpquorwmD0ptVe8rxffYO4c/I72ayC81bd0O0MKAoHjVQ9flZhHlgOD8fRhykJSnrSo+B55ux7rK2uukmW1Jrm92a1yDR1+jdXORaP/6KM4ExYTW2eThcx4fJDA1uIZasdLBY7EjzUXQvqE97QukM3xtKN+6AKobKtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182350; c=relaxed/simple;
	bh=s1phT1es70OK3It4W3GZEA2oFcBCfyD0jdT6tKP3Kro=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G2T8J9F0oT6x5y2qqUFVEt6HDDRISF+TpiAwsReKulSat0NsBC22+NaeVQpVrd1hrnCpmeC1qTt2GHuf2cTdUp0QsJKTeXVb7mlP3AlAggfKoZT6ZqP9BkcvzcPsjOYHL8sTYHWswbPDujmQfPRkXecTVjYGYrUauEUocpRyID4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZfeq9t7; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729182349; x=1760718349;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s1phT1es70OK3It4W3GZEA2oFcBCfyD0jdT6tKP3Kro=;
  b=YZfeq9t7BYEB5wDRbmGT68WUT8pVA6/0XC9NemeKfsLJggDOn8Q3k9cE
   QEfXmIIKofVekYWxCxv8oC/kTvc24Lng0DbuQlTJqMxIINx5YrtSqUFzs
   byptcOxnHydyisk2bF4I0eg53Yoyc+hffbG3sIBeKVLOiwwaBKYyMcEIf
   ePvMXUKJUfpspKfc7tus0b//8esGgD0tAg6JGcEhksDw2oKOn0+SJPhgd
   A+yq7GipvVpiinpptNDo2PfB4n3lUoj3btkgG70EcXjnUPdQeznKda/cY
   WyLVfJfsdFgCZsljmcMBGAXSvdBwvch4ABQPw1fHKm7+auLIjjbUB1QDB
   A==;
X-CSE-ConnectionGUID: FebYTrJWTv+LSDvCYe3Gcg==
X-CSE-MsgGUID: 2te0vYCdSv6/NAC7fW1zLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28153396"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="28153396"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 09:25:48 -0700
X-CSE-ConnectionGUID: ogLNA9CiSUqpiP+84M0dEQ==
X-CSE-MsgGUID: 9G/EUvZpQDSE47AMwGc3rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="78952382"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 09:25:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 09:25:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 09:25:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 09:25:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NaJl8SuLCJojnA9Eu1ckOTov18MC1H0EvyZryPpeHSZ2FgViCslbHO6yy4ETLWDsShUz8n0A3WtMPGNegZkQQXJIFFf1XCMuzkBLL6RE2UMI9XRoJVxiT/A3HQ6pSWC1XC+58fgl/9WM3g/3ghm9OfCDRSLugFRQHV5aBCqIYi9/puqzjH+9ETwHhTNnnV+xQNRjXtO7NYODro4a1q0TO9Et8yQ05dUB8nlDC70jXp7Ls0DZZCI5Y392JxXPQetTcR4fPh3tckNT9he01UHfuaFiLe7OI8F+UzAfiYT6eKsrKCa13exTCDeHTZQxi7rJqy1Uy8HPdPACygKqkTQWDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA4Z8STVkub9pi4HXYFY6+3/MaeBVFafqCt4b/+cWN8=;
 b=fdDNH9qmAe0ULD1Mxfqlp0xvyg8yp30K2tH/d/RUFfVILOJaTl4mOXJe356NQmL4R23Hbk4byGIQlXSiHa8T+hkyNy/2yhe7mduh+4K5Z0WjWRKKeAQXlsFHqhgtjC6+4Hp4N+nbQmKWZCZ1rQ0swYOi2Lkm1bj4oBZPTce5gnN5wSH5Ds0hkZenb3Sk2J9OrZZxZRu5JQ4IeaeAnVtAG5iwwaJCer5XpZnWesI4Ye8tprIgpdNi5D82CnJc8AVs8TQosfJheGbwQPNWyg3XSqQErMYMabUzffTMzHQ2oI2TPVF7Dl+vFkgUuEup5oAoJbnlsz5Vr1mKR4m2RbLj/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV2PR11MB6047.namprd11.prod.outlook.com (2603:10b6:408:179::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 16:25:40 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:25:40 +0000
Message-ID: <e6a69093-3ce0-4189-a0cc-21734feace37@intel.com>
Date: Thu, 17 Oct 2024 09:25:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] igc: Fix passing 0 to ERR_PTR in
 igc_xdp_run_prog()
To: Simon Horman <horms@kernel.org>
CC: Yue Haibing <yuehaibing@huawei.com>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<vedang.patel@intel.com>, <andre.guedes@intel.com>,
	<maciej.fijalkowski@intel.com>, <jithu.joseph@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20241016105310.3500279-1-yuehaibing@huawei.com>
 <20241016185333.GL2162@kernel.org>
 <8e4ef7f6-1d7d-45dc-b26e-4d9bc37269de@intel.com>
 <20241017141624.GO1697@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241017141624.GO1697@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0350.namprd04.prod.outlook.com
 (2603:10b6:303:8a::25) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV2PR11MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 54808168-2f7b-46fe-a6b5-08dceec8570b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elVkOVQ4TnN3ZlBBLzh3S3o1M29nd3h6b0U4V2Y0OHJLVVBhVXpKOFFLNHlI?=
 =?utf-8?B?MndHSmgwLy9LSXU5U0xrYkE5M3U1V1MzdFNMc0pJeTRuLzZYUU5VVjI3VG55?=
 =?utf-8?B?YzNIY2oxNWJob3J0UklVN1NVODlIejV3b3VTWC9Ea1ZHREZ3azVLMWZzRUQ2?=
 =?utf-8?B?TmlaSHY5ZVpkbExERUUwNzdnVTIxRjBsbWlieUNTbFc2ZjBiOUVLaVlNOVJX?=
 =?utf-8?B?eU9DM0hjcGRRSVRNQXB6THphaDhhYUhvUk9wVytWeDZqSHl5OTBXMldFNWdt?=
 =?utf-8?B?Wk51Ynl1VHRodnc4MmFZNndMWEcrWVhaSDJwa0hJRVJRdjAxMG5UYkdWNUx6?=
 =?utf-8?B?RXMwUGMrZ0ZUeDh2UjdvcTdTLzZhWEJkcDI3WEFuajVSU280N3ExUFNHdHZn?=
 =?utf-8?B?KysrMTdNMmNvS1o3WUJkd3E5NjFvaW9uK3RZM1pUOHpyQUN4SkFpVTJVOUhs?=
 =?utf-8?B?dE5nakltTUsxZittN29vUi9zOHZudjRNWGFtRm04S1BFM3NSVXJTdHQ4Vy9M?=
 =?utf-8?B?OFdUVFNPM2R4ZGswNGZ2RkhSb3pHZzgwMVR4WDQwY21yNU9ZQU51b0hkUWtT?=
 =?utf-8?B?ZVhiWUZwYTBWazBGOFlFdlpYeEJDcytqd3UyQnh0R2FsNlBHbklqcGlqa0Zj?=
 =?utf-8?B?SlBLRVpmVnRURDFjdkQyRFh1QzdLSVRIQVk5bHZseHE1RHh4UlJyR1ZycW1I?=
 =?utf-8?B?akI4REdybDU2Yit6RHVYcGRiL291cnhPSmpQOVNxazRIYzN4K2xNWjZzYisz?=
 =?utf-8?B?QkpxUWE1aFRwRTZiTWFvNVNWZDEzOU5xWkYrcmVTMlIwNTJIMjRBK3FDRU9I?=
 =?utf-8?B?bjlrOW51eG8vYnJPM0czU1F2b281MHR3ZWp2YjJuazNzVUc0MWx4Uk9TazNV?=
 =?utf-8?B?WnRuaVc1RjhpTDFsVVA2V2tRZ1VZaGFycTJxZ0JPY2pPYlRTWVRscGwraUdy?=
 =?utf-8?B?SUNBSnR3OXZCd1RCSitWMTNoOFF6ZVVYQ2RTOHVvR3pxR1FSb3drOUlldU5X?=
 =?utf-8?B?WjYydEdlS3R0SVNFS0ozblZMNkszZlluNFpDVEswV1ZKNlZzQjZRblovdko1?=
 =?utf-8?B?K3Awb1UrSGxFNXd3TGhrdjZMYjU2U3JhSit3ejZkMC9hQ3JFeEFWVFlLdDNV?=
 =?utf-8?B?Um52Q3pTc0RJc3pBNXczYmpXaXVPU3pObjNwUFI2MGJBRjkxTmtXMnRuNWxn?=
 =?utf-8?B?TW9hbDk0SGFVN3lUQndFNU9mM2hYNjZiTGdCTjNYTXV5MzdjR1ZvWW9hYVQ4?=
 =?utf-8?B?bU1pY0NaNGhNYzR2NlpPcUUva0xBakFBcG9QOVpKMXU4ZU0rYm83d3RxaTVi?=
 =?utf-8?B?bGg0dXFqNkpQUVQ1U1FrK1poRVd0RlYramJwdnJPUk9zL1plUlNRYzBTYnA1?=
 =?utf-8?B?cEJtTS9tR3VrRzRtaTQ2U2Q5ZndPcHVudDI2eVdURW1xejl0bUhMaFdXY2cz?=
 =?utf-8?B?dS9SY0dQeDdzQmM4bDlhUksvbzMzTmdlR2RuTkx3bmd5ODhjalc3V3pjcWV3?=
 =?utf-8?B?dkVTWUZ5UStkYVF5RFJYMVFJZlhkNC90c2gvdFRlSEZPWStNQ1pUV0twT3JP?=
 =?utf-8?B?SGUvOHpVRlhKOURPMldyZ2JsSEhyRGVnbER3TTluVGhucVJNWCtWbDZGc2xT?=
 =?utf-8?B?RlZ4ajRwNDZYRUJPZ3JLT3RSZEZGclhkdmNjbTJhUXNDT2RIRXhuNjlRcFow?=
 =?utf-8?B?SDFkMDZhYzJKZXQrZTVyUWx5L0pTNXJ0Z1JNUDU1UXVDaW5NSmY3aUgweG1a?=
 =?utf-8?Q?CaU5SiaGb/Zx4SOzdlg80mnIwydw4V805fUyI3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWdGWTloanBUOGd3QlpCenFJZnpjUzRUQkMwWWNWeHQyS0c4bksreCtHbERD?=
 =?utf-8?B?MDFlRHNWZW12bFQ1YmNqZk1tbUcwRzJIZmRkTlM4bmphc2hod3BVdWFZWUcv?=
 =?utf-8?B?czZ1QUhzYzZjSVFCYzh1QXlGMXNZRlZSVUpoeVdzNGdmdWlZRXJvOTA5Yi96?=
 =?utf-8?B?MHc4Y2V5cWhpd3RKMXQ2RGUrWVhuSjRkdGRzRElnMmg5ZFZxdFhSSTc0Nk4w?=
 =?utf-8?B?VExuZUpXcDhMMHMwZGx6UU9sVExwanhEU0ptd1QvdG9nUHcvTmtGQ3cycTRz?=
 =?utf-8?B?bGNXekwxR3BWLy9UdGxOQUUzcGpyY2xjSGpOMEo1cmdTU3g5M2l4NEZ1ejZ0?=
 =?utf-8?B?TmlIUllQSnU5ay94QWY0NDhYbU5ZT2RJYk8xMHA5YXVPQ2hvelFQSCsxbDBQ?=
 =?utf-8?B?OWZFejlCeWlMVFIvbVFtT1kveHR1c2UzVDIrcVRORGJlS2NyYTMrczQxd0Z0?=
 =?utf-8?B?cnlydFNObCt6RXc0czZDcWo4L3hXVFk2NlpCNXlWYW9VUzBINERlalkrLzNa?=
 =?utf-8?B?L2FQYU1xTnBvZHpITDVWUXZMNHkxRlgrd3owMDZVS0E0NmFaVHhOaFBub3Ry?=
 =?utf-8?B?dHBVN3N4WkY2SW9lTGNLeGxwWHcvZzZ3eGdtS1lwbGprWDM4WUZkRDZOZmE2?=
 =?utf-8?B?aWFOM1hnd0IrdkNlMmZTSXFaVVk2SUdFZEl0TTI3Mis0TDFva2tyY2J2L0xM?=
 =?utf-8?B?UlRENlFFTHVhd3ZMbTVMaXkvNy82VWRSem1Sa2RpQlFpZDNlakl3MjFQZWJl?=
 =?utf-8?B?cXNnZHJNL0h2UGdtWDhBSlo1UHF0ZDZUVC82YXhEbFk0QTVsU0x5eGZhb2FT?=
 =?utf-8?B?SHBPMkFKakE1SllaYUZpNit2NW55dUNWY2RsQ1ZpdGZEam1QdHA4bEFSamsw?=
 =?utf-8?B?V1Nnb3hpN3RpZTV2RjRoREMzNGtBUDlibUZZMmhzTGpURXljMVdiUjhQem04?=
 =?utf-8?B?Yk0vVFRaejdFMWFpSGNyV2V4TFM0c3R1UDdaY2dLSUZ5Uk9WUlV3enVRS0Y5?=
 =?utf-8?B?ZGhOMTlOaHBlY1pKbWdjVDlhR0pxbEMwV2xEYVA4azhtSXFFN3AxekNpSm51?=
 =?utf-8?B?WG1zaEU2TU1pY0hPd0pKYmowMUFSRkJ4U2c3Y1ZZK2JCbTd2K2Jka3BxUCtX?=
 =?utf-8?B?MDJSM3ByT1pCbE1UaXZzNUtYWWF6YVRLbE55U1oxSlVQMHV5MnFnanJyRGJz?=
 =?utf-8?B?dGc5RWVJL3ZuVG5wK2gwMlJKeHFxYkdDcmwvMEZNR1hzS3lpcTVlR1E3TzF5?=
 =?utf-8?B?VzVKUSszK3hBNnhNWHg4RGwrRWxzQ2M1VWdCR0dGQ2pSZnc5RVhKQzlNaktE?=
 =?utf-8?B?dkNmcFZSeFpRaWRtRGs1QVR1L2lkdVpvRmY5RHZ1YzltOVA0azJRMGc3dVNL?=
 =?utf-8?B?MlpjWERMcnk3K0lKTWs1L2ErS3pMTFgrVGxUTUwxRFFVY1J3cUt1cUI0WUlw?=
 =?utf-8?B?Y3dka2l1SDUyK0NkREN4b09XYk83TEVQMjJCV2lQRXpNOUxoNmlsZDJ3ZU1w?=
 =?utf-8?B?UGRraWZoekpMUkRjWUZtQWQ1L1NkaVVhV0RiMmVsYnpHemNlQmk5Q214Wlhk?=
 =?utf-8?B?UHJhSWRSYnBSdnk5V05pTGxMaldMUkhydzlZRFB6NWlJWEl0b1FRNXc3bDFM?=
 =?utf-8?B?VVBZemxqWXpab2R1Zk85Ri9sTXNEeHVWbjcxT3ExUi9tSnVwamJkTmp6cDNj?=
 =?utf-8?B?cldyc1JRRkI3Yk5LcHdhOG0yaTg3alR3REtlZjBLVGF4SmtUNE5CTlN3blFP?=
 =?utf-8?B?UktqWUFkaVRJclJZMmJVU1E2Mk1MRm1ZSXpzRzlnMDBTaldDams1SmZDTVR3?=
 =?utf-8?B?K1Y3dVpEMmVkcmM4WnpMbk1vNXVsNDJTMWQySFFpamZBMEtZVnJtQWgzS3FW?=
 =?utf-8?B?ZTU5NTlCK1RmblNaWS9wSXR4ZHZLRm10RjRjSmxVRDlmbVA3T2JjRjJ5Ny9F?=
 =?utf-8?B?S2F3NkYzMUc2VTVTdjYwajNtb2VFRGEvWjZxdGx1WEt0VXJEU0pCU1ZwU2hJ?=
 =?utf-8?B?SjZxRE5oQUFkWmx0M3pVeS9SMXFtQXZxc0JOdzJ6bmNibHJtN3N0cUNISHFU?=
 =?utf-8?B?QnhWTUNYL1lqTHdFamprUVp1STdYUlBVL2lreThaUnRDazMrVUF5ZGtZbzA4?=
 =?utf-8?B?VExYNlJMemlydXp0TVRrclFIT00wRDg4cmRTNEFjMTcyYmxHaTBOdXNKTG5V?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54808168-2f7b-46fe-a6b5-08dceec8570b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:25:40.2719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yToYXlntajphp9gzJzwgVQxNFxKlmxiO9RDNM1B38twb+whHBU7O4LDsAM7P4Yh9C8rTD4hNr7XCl5oShRLge1fOFLDCMlnFgfuJR4Qeu1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6047
X-OriginatorOrg: intel.com



On 10/17/2024 7:16 AM, Simon Horman wrote:
> On Wed, Oct 16, 2024 at 04:06:34PM -0700, Jacob Keller wrote:
>>
>> Not quite. PTR_ERR_OR_ZERO is intended for the case where you are
>> extracting an error from a pointer. This is converting an error into a
>> pointer.
> 
> Yes, silly me.
> 
>> I am not sure what is really expected here. If res is zero, shouldn't we
>> be returning an skb pointer and not NULL?
> 
> Right. I think the whole point of the cited warning is that it highlights
> code that is often buggy. I think I may have tried to address it in the
> past, but if so unsuccessfully. In any case, I do think it would be good to
> dig into this and either fix it properly (or understand why it is correct
> and note that somewhere.
> 

Right. I think we identified the correct fix. This same code was in i40e
and was removed in a better way.

