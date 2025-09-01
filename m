Return-Path: <bpf+bounces-67130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8432DB3EFC0
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 22:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1533D205BD7
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 20:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBA626F297;
	Mon,  1 Sep 2025 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9hVA+cn"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB85269B0D;
	Mon,  1 Sep 2025 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759041; cv=fail; b=utaATxv3gvT3rWuepOFvGi5Z8O6+Uo8WyszdGu/zGEEnMAkXrRrU9+Zb37Qbavsi0gDBZq09Q5ZpPxrROr8cumDycB18xbHaGxPqZAguCNUvJAL8KHMzya5fRUfYWqaMVHr7323+mXyG5xy/YxBi/AqCslqHRZc7Lf51mVLsNlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759041; c=relaxed/simple;
	bh=HiIkA+Q9r5f1eCDET/zpLPI8NBT3Zz1AS3VnRLvQDbI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JtNfvKpAKtZ3L8+8PeMsuSXiMs20PS51FeSzO9SV/3S5leJiW9+pJXwexkgrAXW1HCJhg6wfiOEbj3Jtx4WfQ73hCnnn8cOBO8WrXSSR1EDs3Vt1groq0wrktyAclSp4J0/11GNutGuVHyVxVqkdmreEFqUS96Tt1vzxlDU07Oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9hVA+cn; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756759040; x=1788295040;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=HiIkA+Q9r5f1eCDET/zpLPI8NBT3Zz1AS3VnRLvQDbI=;
  b=Y9hVA+cnXjkzhfEU4HIbVr/ZxY9XM6z+oDgvFIzM+eCqQ9fK2iEe2C/x
   bbUHJQZkj1y5HfiujCmlLq4tBlfPbyj3PNeENW0D94tRAt2E/nDrkHTSZ
   945XwkK558TVQURoMLIfDs9c0ys95e5Nb8nbxoYgBqt3D9amddpleBd0+
   E3ZnIlAtevodP2LmVfPLPLoMtUAIw6rJlb5i2bsliPldvgRZolDai83Rt
   sbKgZ5uBPrRzlZP2D8vB5nnYtbbvd46wOX/plfzQkFNPaSRAtejlQd3Wu
   7Yb/y7l3PiPDVbUtrMx6JoMyMyxYZ4Y3i0akNezjiu7PTE0U5aHxxLOlf
   Q==;
X-CSE-ConnectionGUID: UyG1OtdUTmG+W2oM4LIvOg==
X-CSE-MsgGUID: QAyaka19Qoi/uyw9M/yysg==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="58951472"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="58951472"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 13:37:16 -0700
X-CSE-ConnectionGUID: lK3xQjw9Q5Wed/esaSjSoA==
X-CSE-MsgGUID: szmAFOVKRZaRKEaWIrk9Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="170370914"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 13:37:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 13:37:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 1 Sep 2025 13:37:02 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.75) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 13:37:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yObsK92nqAoNvBjCr8X7KIhpi6zy1NHkh5YoX3L5462pYQYXBy8Idi/Irb/OItQ5GfpYYQiwMq8Ld90FqA7QhLQw23hWyKtqNVjD0anYmdosKkNXku6s2tf8K2O54KM9PMmTOZb5FAq8fE/HSS4kMM31+eVbCkckq3GDMPNiH5ObTqZ3hQ3rB8Mzaaw6i2Cm+KGwsVI3vccsX/6f8x2+heAJWLIFLBQlVSjQDZ0MP3ORaFlQZXPHlLE7rxGhL3YkrN9rCT4YJ6YL7x4kUARuxA0z2RYSr3D98v0lKQD1Jz3tresy+iV3umCjxWFY3rw2VgesFVymCc15McaKhAyCdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zU5evt45s1MBIgTlpg23yjVDb8DFPd0tE3LsldVnSg=;
 b=hK8tg4LoXfIviczYqrgKMu69vEXnNx874zw/nsOg/QuqjHJztlnM9YCsm3yktQhuQ5IVXdkGMilq5KrqIyJITB94GzHk830i99Ftl2WP59w7LeYNrSjUmD5ozAz9FGeg1ATyGmO/5ISVVnJ4vxU47VLCjcVDcBoH7dCk9n/qDCTlm5bcrgLBq36mqGjpE64ENtCVlb6JxVB91EEc4j10QmTfskB7jNk0TeYoTsjMF8kyl08W2yitRLtMGqOEllyQxyjJvWNxUYNfJc/xn3TyNtl09BQ2NFq0TAtHiw9EvWufgO9skrB686IfywR3SKDOd+R3QmTF5sCCfJpFCHrz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CH3PR11MB8561.namprd11.prod.outlook.com (2603:10b6:610:1ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Mon, 1 Sep
 2025 20:36:54 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 20:36:54 +0000
Date: Mon, 1 Sep 2025 22:36:42 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<stfomichev@gmail.com>, Eryk Kubanski <e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v7 bpf] xsk: fix immature cq descriptor production
Message-ID: <aLYD2iq+traoJZ7R@boxer>
References: <20250829180950.2305157-1-maciej.fijalkowski@intel.com>
 <CAL+tcoA2MK72wWGXL-RR2Rf+01_tKpSZo7x6VFM+N4DthBK+=w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoA2MK72wWGXL-RR2Rf+01_tKpSZo7x6VFM+N4DthBK+=w@mail.gmail.com>
X-ClientProxiedBy: WA2P291CA0031.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CH3PR11MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a381ff5-43a5-44d3-2653-08dde9974995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlI5Q3c2WVJyOStUYjZEb1UxZDRuVFAvWHdyZUNVWkdJQ3NXVlFQd0UySU50?=
 =?utf-8?B?N29kRUNqS1Y4cHR2b3pWMFFoQzRiaGttc2RSOEpLdEo5c0FVc05WMkJxRjYr?=
 =?utf-8?B?RmN2Q0laZXhDenZhMmtXdkVBek9uSmZLbTdJb1MvME9HTURuU2ZCWVczUGpI?=
 =?utf-8?B?cllDK1ltd0t5ZjMyRVZ0VVpxckJNV2k4dXFiZ0lLT1MxalpZUjVpQ3k1UW9r?=
 =?utf-8?B?dURoZWFKRzNDWUNackQySnU2VDFES3hvR3orTEx0ODl1Sk5oY3YwOEFzZVVQ?=
 =?utf-8?B?Ynhra2IvWHJXeU5TQUZBTXdvM0JMWTQxVXdhRHphOGVJSm1qbEc1OFFZUkZZ?=
 =?utf-8?B?V3lkcVZHSDBSUG1nenZQQVlvU1VZbXVhbUQzelFTUlp4cXNRbjV2Q3A3alpp?=
 =?utf-8?B?MFNabEhmdGx2UmoybXZLc0NQeVMxMHFLQk10YXhzWFJqcXJhLzJGMitpYko2?=
 =?utf-8?B?SFdva1B6bXJYZHp1TnVQSFNXRkIwM1VRWk1FT3BxenlzU1JNNkgxaHZmcjhL?=
 =?utf-8?B?NmpQaVE5S1ZaY0hhQ29LRzRUVjA4OEtmMDVyRDRURHFObmdURkxybm5TeTBL?=
 =?utf-8?B?Qm5NZ0ZGYnF4YTZ1UFkzeDBGcHJsZ3ZVWitFNmF5T3ptYmFEUzJUQkVsUDF2?=
 =?utf-8?B?MVBxNGx1QktWdW44SElnSldoUzZ0NmFTVU1wZ2d1d3VvQTVwQktHNC95MkRE?=
 =?utf-8?B?Z2pyT0UxMVBrd0dDY1IvNTBzWWxHd2VPWGZXSnpuaHFBaTFwbFpXS0FZbUVV?=
 =?utf-8?B?c0lBU21EbVhaRXdlUEJvNjFqKythdDRkT1A4eEhiZWphTTJuckxvTytDYkda?=
 =?utf-8?B?VkVxQkpZcEw2VXo5cVhCN2d6Q3ZraHdiTlNPTXRRTy9mYjc5Q29FaFpjSkVR?=
 =?utf-8?B?Z0VhdUl1UjZ1WnZNMlBNS0ZXeUNFWmVkQ1c3cHpVbm1pZkRLUUJYaGVIWXhn?=
 =?utf-8?B?cDQxV2p1YTArTU9YOEFaMDJHcXFmVXdwM0RyTGNWRWJmRS9oYkZBcXZmTFJn?=
 =?utf-8?B?aEhrSWczb0NHZ0ZaVENrY1lBVUw0VlFteTI3YmFvVmg1ZCtWMjhUNHRaVmw3?=
 =?utf-8?B?N3RLY0lqQko5VVhvMDBralR6QkVvcWRSbk5zejhPcndvdW51QzdCaEhLTU9r?=
 =?utf-8?B?R2RkTkxmSWFMRmlrQW9DNjJWZWY5cU9ka24zaUFkaEhDR0cxcllSbUp5cEgv?=
 =?utf-8?B?TlFhOUpKTTdEUWtaaGJWVlE5eDN3dzVmb2FZMUl2WnMwb0JJNjVjQlpHM2Vy?=
 =?utf-8?B?QVFSdzdtSEhPNVBpRjZYYnZISk5tNHlMa3U0OTFkLzh0UUhZY05qak9QS1Yz?=
 =?utf-8?B?cFFTSmNoeU9TQ01RbndFdEVET0U0aWdnL29sZkQxQXAwZi9zMFRGbitNcjB3?=
 =?utf-8?B?TDlVK3hsZFV1L2VheHVuMDh2VXEwRWNMRm12T1kwZzViVjZianN0YzRQV2E5?=
 =?utf-8?B?OE5jTERTSXRsUWVHdWFwd0U3SDdZUyswekhqQkJ0bjlIY2dyL05iT3lwK3g3?=
 =?utf-8?B?VitOR3dyWDdrZTRCQkY3b3hDYUtCK0lTRUg2djY4KzhiK3BuMEZDeEFWQXBh?=
 =?utf-8?B?UjJISTNMdjhUKzJ0dnhuVExZd0RNdzYxbzdCWWVHUS95dTNyYzJTRVZEbjF1?=
 =?utf-8?B?V1JvclVnN0QrcTZXY2R2cEtiUkF4SWFvSzgzK3AzUW1BZlRlUlo5TVpReU4x?=
 =?utf-8?B?UHRrQVhxdWYvYzMxdEM3anpjanlKMUh3bzlTZUprRWJ1ZUpRUWtySU4wNGJ4?=
 =?utf-8?B?SFF6Rm4zaCtFVldDWHZMQ296emJ0RSt4Y2hEZGh3cFBoa0s0bUVOR2tCa1Jq?=
 =?utf-8?B?L3hmVUZaSjhjWjg5Mm1sQkNXOWtzWEVzMGFydlZiYTE0Si9uYzJWK2tXSDVW?=
 =?utf-8?B?VUgyZC9sb3lmK3VLYXNkOEE5SE9Qd0JRWWlzK296NTVCbmd3emhxWGhEN0hW?=
 =?utf-8?Q?89YznQrUFrw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk15UU5LbEp6L1VzMEliYi9ScTViYldZWURVdDMrNHRVa2duZERUUU5rVUFM?=
 =?utf-8?B?TjBRV2NDS2NKamNhNVN1MDcvRzRqalFXK2hhbStPSldoWE81WFhFdkhVdnhu?=
 =?utf-8?B?S2JQUThzekdqcXZWWG94STUvd09iRU9BQ0dKaDlTeG1vVWRsMmVSMlh6T3ZK?=
 =?utf-8?B?TmpMcUIwWGxqanJZK2srU1RBTEhlckpzekZTWmlxeGdLMWUzQ2pZb3NBTjk1?=
 =?utf-8?B?TktRVzRFNFBZUmxQSllsYkVUVlJ5U1BsYUdjdExVcWIvdUh4MlcweVpMdnBa?=
 =?utf-8?B?R20xczQvWlRPMTdkc3pMNmdDVVc5SlI1WWRMOGI3aGF0aklSbFJkS1hqTlBV?=
 =?utf-8?B?eXdwY2M3Q0htY0Y4azYyYUMrTFhPUFAvRS9scXRzQmJGcnZaRnRma0VlZW40?=
 =?utf-8?B?Tk1jbzFVT2pmbGxRc1VVdEV3S0dKRzNaNmIrTU1ROUEvQ3R6LzRGb0VEVVNJ?=
 =?utf-8?B?MWhqQVd3N1RXMDR1ZUY5UnFZVGlDblZvaWtOdVJDQjRoNzkway9ka1l4aXFt?=
 =?utf-8?B?aWVGbUNwekU3ZGlRMkJoMmJ4d3RQY280RGFlaWVWbFkvTFRCcmhwcG02V3hR?=
 =?utf-8?B?cEE2dkxBR1ZrazRwK1Q4QmNuaTkycUJUektKREZIUnVyTThWbk1vSzNZOWx1?=
 =?utf-8?B?blExZnJ5T0ZjeERLNVk3TUk2aWJPSlJ6Y25BdmJCQzZ5aFN6VThqdU04a05O?=
 =?utf-8?B?bi9Ibkh4REJOL1JYODVXbG50alFiRjVUWTZNVEFEeHZYSzZhVGE0NlpNYll2?=
 =?utf-8?B?RVhERnNhd2NkdWd1WDFYbmFidUNlZEVTdmNJTXpSdlc4NE5EOEtNQ3BJNWls?=
 =?utf-8?B?L3NPZ0lLYXRPMXRpQUhzY3B4K1duejFSL204eEpqZThiMlNhL0ltMWF6K295?=
 =?utf-8?B?NXRTdnRqVkk0Qkd4VTB2L2tVNEFJRmRWczlGUG1vTXJrUUJsd0FTeVZnUGpt?=
 =?utf-8?B?SENnVElBOTFaYjF6NERLMkEwTXIvN2RzSWsvR04yc3pITk96M0xVNUorMVNZ?=
 =?utf-8?B?aUYrSUxOZ3FJSXREajNFN3R2VHZmSUIyS2V2c3o3RW9UQ21EeHZBaXJ6WTNk?=
 =?utf-8?B?OW1zeGRNc3VEWXRqSmE0cjh6RHhmR2ZNMnYzL0ZEWVRkL2dKTzg1eHprSlFU?=
 =?utf-8?B?dTE3Vk1rZDl1aG9FRGwvbkRjVkVBME9wRTlBUEsvSENocUhwNmVPS2kxZldK?=
 =?utf-8?B?QTZpMUlTVjM4OGZNS0lkZHgyQUxlTC9GK1VUZVhuZWZQN2FPMEhRbDQ4MHAz?=
 =?utf-8?B?YTBvUml3NWVzanJMTURva0xySHFKeDI3bEpDSkRYQktPM1hvdXB4emhVMTdZ?=
 =?utf-8?B?VlVVVDVsemNkOUg3UzNYYXpKaDZzL2k4OGh5bmRXZHNCQXVkY3lNODV0Q0JE?=
 =?utf-8?B?SUNFRll5aWo4QW9vWUZUakZNMzByZmZENmt3WEJKU1dFcGNiNHNrK0dNaTR5?=
 =?utf-8?B?NFVQRlVUMm95QkY0ZjNFV3VpamgzUVhNV241VkppdkpNai9lSzgvZVlpbjZR?=
 =?utf-8?B?TGdndFVqRjk2ZGRGdHBRS0E1bDlmMDcvclN0c3RqaVRGUnhPYXJEYkQ4UXl4?=
 =?utf-8?B?TGRxTWh4REVOQ3FxMTZiaDRIc3B0cFdZNXdFZFlIK3ordkJYNHV3a3A2Y3Ur?=
 =?utf-8?B?cHc2a3Y3R2NyY1lOVVYxMGYrZVEzUm55eXFOVkxLOTR3MElKMFRJeVhDTUhD?=
 =?utf-8?B?TkxxMnBLeHBtR3QrcTJvcTJpU1pFWnROejdEYUlOdDZWNnV6REwwWXNXdEZN?=
 =?utf-8?B?V1BaeW8wZTQvMlU5eW8vQnVNc2dwUFA3c3VUak8yM05CQTE2L1pZWVJxZlk2?=
 =?utf-8?B?VmdrdEJydWFqRlFXb2dWWDJqcVpwWk9zdmd2Z0h6anQ3RC84aFpUK3JuY1py?=
 =?utf-8?B?UVhWdkg3NmxHUXAwbDNqdXJIbmdjb0V5a0RrRFNBL3dxL2dMZmFHanlnRWRG?=
 =?utf-8?B?eTJFNVBibGgzUEhWVEZtaWdCQ3Vibkk1RGkxOGJpM3hLZ1BacGttSXdiYTdk?=
 =?utf-8?B?Zk10VFR3RDY1dkxRWDQ2ckFKaUpRV2Nmb1llcXk3amhwYjhTUHBVcmZQaU5H?=
 =?utf-8?B?WjZ1VW90SVo0U1pTdTZjbWNmbDNGWkJELzBGRjJSVHRQdHFTVjVFdE0vWm41?=
 =?utf-8?B?UUdoRGJvWTBEdG9KamRQT1FnOTZuY0tla096VElDZ2ZuSldHQnlWWjhYRGQy?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a381ff5-43a5-44d3-2653-08dde9974995
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 20:36:54.3013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2udfJLsIDYMY2VbzjOLk5UvlGML1nzPyiXYWE3JWekpesYog6no5ier6BEjUgnrDB8R7GRpDsY+ouodyG+B/PpUcmfbDR+l1Se/ZSsUEp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8561
X-OriginatorOrg: intel.com

On Tue, Sep 02, 2025 at 12:09:39AM +0800, Jason Xing wrote:
> On Sat, Aug 30, 2025 at 2:10 AM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > Eryk reported an issue that I have put under Closes: tag, related to
> > umem addrs being prematurely produced onto pool's completion queue.
> > Let us make the skb's destructor responsible for producing all addrs
> > that given skb used.
> >
> > Commit from fixes tag introduced the buggy behavior, it was not broken
> > from day 1, but rather when XSK multi-buffer got introduced.
> >
> > In order to mitigate performance impact as much as possible, mimic the
> > linear and frag parts within skb by storing the first address from XSK
> > descriptor at sk_buff::destructor_arg. For fragments, store them at ::cb
> > via list. The nodes that will go onto list will be allocated via
> > kmem_cache. xsk_destruct_skb() will consume address stored at
> > ::destructor_arg and optionally go through list from ::cb, if count of
> > descriptors associated with this particular skb is bigger than 1.
> >
> > Previous approach where whole array for storing UMEM addresses from XSK
> > descriptors was pre-allocated during first fragment processing yielded
> > too big performance regression for 64b traffic. In current approach
> > impact is much reduced on my tests and for jumbo frames I observed
> > traffic being slower by at most 9%.
> >
> > Magnus suggested to have this way of processing special cased for
> > XDP_SHARED_UMEM, so we would identify this during bind and set different
> > hooks for 'backpressure mechanism' on CQ and for skb destructor, but
> > given that results looked promising on my side I decided to have a
> > single data path for XSK generic Tx. I suppose other auxiliary stuff
> > such as helpers introduced in this patch would have to land as well in
> > order to make it work, so we might have ended up with more noisy diff.
> >
> > Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
> > Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> > Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >
> > Jason, please test this v7 on your setup, I would appreciate if you
> > would report results from your testbed. Thanks!
> >
> > v1:
> > https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@intel.com/
> > v2:
> > https://lore.kernel.org/bpf/20250705135512.1963216-1-maciej.fijalkowski@intel.com/
> > v3:
> > https://lore.kernel.org/bpf/20250806154127.2161434-1-maciej.fijalkowski@intel.com/
> > v4:
> > https://lore.kernel.org/bpf/20250813171210.2205259-1-maciej.fijalkowski@intel.com/
> > v5:
> > https://lore.kernel.org/bpf/aKXBHGPxjpBDKOHq@boxer/T/
> > v6:
> > https://lore.kernel.org/bpf/20250820154416.2248012-1-maciej.fijalkowski@intel.com/
> >
> > v1->v2:
> > * store addrs in array carried via destructor_arg instead having them
> >   stored in skb headroom; cleaner and less hacky approach;
> > v2->v3:
> > * use kmem_cache for xsk_addrs allocation (Stan/Olek)
> > * set err when xsk_addrs allocation fails (Dan)
> > * change xsk_addrs layout to avoid holes
> > * free xsk_addrs on error path
> > * rebase
> > v3->v4:
> > * have kmem_cache as percpu vars
> > * don't drop unnecessary braces (unrelated) (Stan)
> > * use idx + i in xskq_prod_write_addr (Stan)
> > * alloc kmem_cache on bind (Stan)
> > * keep num_descs as first member in xsk_addrs (Magnus)
> > * add ack from Magnus
> > v4->v5:
> > * have a single kmem_cache per xsk subsystem (Stan)
> > v5->v6:
> > * free skb in xsk_build_skb_zerocopy() when xsk_addrs allocation fails
> >   (Stan)
> > * unregister netdev notifier if creating kmem_cache fails (Stan)
> > v6->v7:
> > * don't include Acks from Magnus/Stan; let them review the new
> >   approach:)
> > * store first desc at sk_buff::destructor_arg and rest of frags in list
> >   stored at sk_buff::cb
> > * keep the kmem_cache but don't use it for allocation of whole array at
> >   one shot but rather alloc single nodes of list
> >
> > ---
> >  net/xdp/xsk.c       | 99 ++++++++++++++++++++++++++++++++++++++-------
> >  net/xdp/xsk_queue.h | 12 ++++++
> >  2 files changed, 97 insertions(+), 14 deletions(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 9c3acecc14b1..3d12d1fbda41 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -36,6 +36,20 @@
> >  #define TX_BATCH_SIZE 32
> >  #define MAX_PER_SOCKET_BUDGET 32
> >
> > +struct xsk_addr_node {
> > +       u64 addr;
> > +       struct list_head addr_node;
> > +};
> > +
> > +struct xsk_addr_head {
> > +       u32 num_descs;
> > +       struct list_head addrs_list;
> > +};
> > +
> > +static struct kmem_cache *xsk_tx_generic_cache;
> > +
> > +#define XSKCB(skb) ((struct xsk_addr_head *)((skb)->cb))
> > +
> >  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
> >  {
> >         if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> > @@ -532,24 +546,41 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
> >         return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
> >  }
> >
> > -static int xsk_cq_reserve_addr_locked(struct xsk_buff_pool *pool, u64 addr)
> > +static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
> >  {
> >         unsigned long flags;
> >         int ret;
> >
> >         spin_lock_irqsave(&pool->cq_lock, flags);
> > -       ret = xskq_prod_reserve_addr(pool->cq, addr);
> > +       ret = xskq_prod_reserve(pool->cq);
> >         spin_unlock_irqrestore(&pool->cq_lock, flags);
> >
> >         return ret;
> >  }
> >
> > -static void xsk_cq_submit_locked(struct xsk_buff_pool *pool, u32 n)
> > +static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
> > +                                     struct sk_buff *skb)
> >  {
> > +       struct xsk_addr_node *pos, *tmp;
> >         unsigned long flags;
> > +       u32 i = 0;
> > +       u32 idx;
> >
> >         spin_lock_irqsave(&pool->cq_lock, flags);
> > -       xskq_prod_submit_n(pool->cq, n);
> > +       idx = xskq_get_prod(pool->cq);
> > +
> > +       xskq_prod_write_addr(pool->cq, idx, (u64)skb_shinfo(skb)->destructor_arg);
> > +       i++;
> > +
> > +       if (unlikely(XSKCB(skb)->num_descs > 1)) {
> > +               list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
> > +                       xskq_prod_write_addr(pool->cq, idx + i, pos->addr);
> > +                       i++;
> > +                       list_del(&pos->addr_node);
> > +                       kmem_cache_free(xsk_tx_generic_cache, pos);
> > +               }
> > +       }
> > +       xskq_prod_submit_n(pool->cq, i);
> >         spin_unlock_irqrestore(&pool->cq_lock, flags);
> >  }
> >
> > @@ -562,9 +593,14 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
> >         spin_unlock_irqrestore(&pool->cq_lock, flags);
> >  }
> >
> > +static void xsk_inc_num_desc(struct sk_buff *skb)
> > +{
> > +       XSKCB(skb)->num_descs++;
> > +}
> > +
> >  static u32 xsk_get_num_desc(struct sk_buff *skb)
> >  {
> > -       return skb ? (long)skb_shinfo(skb)->destructor_arg : 0;
> > +       return XSKCB(skb)->num_descs;
> >  }
> >
> >  static void xsk_destruct_skb(struct sk_buff *skb)
> > @@ -576,23 +612,32 @@ static void xsk_destruct_skb(struct sk_buff *skb)
> >                 *compl->tx_timestamp = ktime_get_tai_fast_ns();
> >         }
> >
> > -       xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb));
> > +       xsk_cq_submit_addr_locked(xdp_sk(skb->sk)->pool, skb);
> >         sock_wfree(skb);
> >  }
> >
> > -static void xsk_set_destructor_arg(struct sk_buff *skb)
> > +static void xsk_set_destructor_arg(struct sk_buff *skb, u64 addr)
> >  {
> > -       long num = xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
> > -
> > -       skb_shinfo(skb)->destructor_arg = (void *)num;
> > +       INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
> > +       XSKCB(skb)->num_descs = 0;
> > +       skb_shinfo(skb)->destructor_arg = (void *)addr;
> >  }
> >
> >  static void xsk_consume_skb(struct sk_buff *skb)
> >  {
> >         struct xdp_sock *xs = xdp_sk(skb->sk);
> > +       u32 num_descs = xsk_get_num_desc(skb);
> > +       struct xsk_addr_node *pos, *tmp;
> > +
> > +       if (unlikely(num_descs > 1)) {
> 
> I suspect the use of 'unlikely'. For some application turning on the
> multi-buffer feature, if it tries to transmit a large chunk of data,
> it can become 'likely' then. So it depends how people use it.

This pattern is used in major of XDP multi-buffer related code, for
example:
$ grep -irn "xdp_buff_has_frags" net/core/xdp.c
553:    if (likely(!xdp_buff_has_frags(xdp)))
641:    if (unlikely(xdp_buff_has_frags(xdp))) {
777:    if (unlikely(xdp_buff_has_frags(xdp)) &&

Drivers however tend to be mixed around this.

> 
> > +               list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
> 
> It seems no need to use xxx_safe() since the whole process (from
> allocating skb to freeing skb) makes sure each skb can be processed
> atomically?

We're deleting nodes from linked list so we need the @tmp for further list
traversal, I'm not following your statement about atomicity here?

> 
> > +                       list_del(&pos->addr_node);
> > +                       kmem_cache_free(xsk_tx_generic_cache, pos);
> > +               }
> > +       }
> >
> >         skb->destructor = sock_wfree;
> > -       xsk_cq_cancel_locked(xs->pool, xsk_get_num_desc(skb));
> > +       xsk_cq_cancel_locked(xs->pool, num_descs);
> >         /* Free skb without triggering the perf drop trace */
> >         consume_skb(skb);
> >         xs->skb = NULL;
> > @@ -623,6 +668,8 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> >                         return ERR_PTR(err);
> >
> >                 skb_reserve(skb, hr);
> > +
> > +               xsk_set_destructor_arg(skb, desc->addr);
> >         }
> >
> >         addr = desc->addr;
> > @@ -694,6 +741,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> >                         err = skb_store_bits(skb, 0, buffer, len);
> >                         if (unlikely(err))
> >                                 goto free_err;
> > +
> > +                       xsk_set_destructor_arg(skb, desc->addr);
> >                 } else {
> >                         int nr_frags = skb_shinfo(skb)->nr_frags;
> >                         struct page *page;
> > @@ -759,7 +808,19 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> >         skb->mark = READ_ONCE(xs->sk.sk_mark);
> >         skb->destructor = xsk_destruct_skb;
> >         xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
> > -       xsk_set_destructor_arg(skb);
> > +
> > +       xsk_inc_num_desc(skb);
> > +       if (unlikely(xsk_get_num_desc(skb) > 1)) {
> > +               struct xsk_addr_node *xsk_addr;
> > +
> > +               xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> > +               if (!xsk_addr) {
> 
> num of descs needs to be decreased by one here? We probably miss the
> chance to add this addr node into the list this time. Sorry, I'm not
> so sure if this err path handles correctly.

In theory yes, but xsk_consume_skb() will not crash without this by any
means. If we would have a case where we failed on second frag, @num_descs
would indeed by 2 but addrs_list would just be empty.

> 
> Thanks,
> Jason
> 
> > +                       err = -ENOMEM;
> > +                       goto free_err;
> > +               }
> > +               xsk_addr->addr = desc->addr;
> > +               list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
> > +       }
> >
> >         return skb;
> >
> > @@ -769,7 +830,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> >
> >         if (err == -EOVERFLOW) {
> >                 /* Drop the packet */
> > -               xsk_set_destructor_arg(xs->skb);
> > +               xsk_inc_num_desc(xs->skb);
> >                 xsk_drop_skb(xs->skb);
> >                 xskq_cons_release(xs->tx);
> >         } else {
> > @@ -812,7 +873,7 @@ static int __xsk_generic_xmit(struct sock *sk)
> >                  * if there is space in it. This avoids having to implement
> >                  * any buffering in the Tx path.
> >                  */
> > -               err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
> > +               err = xsk_cq_reserve_locked(xs->pool);
> >                 if (err) {
> >                         err = -EAGAIN;
> >                         goto out;
> > @@ -1815,8 +1876,18 @@ static int __init xsk_init(void)
> >         if (err)
> >                 goto out_pernet;
> >
> > +       xsk_tx_generic_cache = kmem_cache_create("xsk_generic_xmit_cache",
> > +                                                sizeof(struct xsk_addr_node),
> > +                                                0, SLAB_HWCACHE_ALIGN, NULL);
> > +       if (!xsk_tx_generic_cache) {
> > +               err = -ENOMEM;
> > +               goto out_unreg_notif;
> > +       }
> > +
> >         return 0;
> >
> > +out_unreg_notif:
> > +       unregister_netdevice_notifier(&xsk_netdev_notifier);
> >  out_pernet:
> >         unregister_pernet_subsys(&xsk_net_ops);
> >  out_sk:
> > diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> > index 46d87e961ad6..f16f390370dc 100644
> > --- a/net/xdp/xsk_queue.h
> > +++ b/net/xdp/xsk_queue.h
> > @@ -344,6 +344,11 @@ static inline u32 xskq_cons_present_entries(struct xsk_queue *q)
> >
> >  /* Functions for producers */
> >
> > +static inline u32 xskq_get_prod(struct xsk_queue *q)
> > +{
> > +       return READ_ONCE(q->ring->producer);
> > +}
> > +
> >  static inline u32 xskq_prod_nb_free(struct xsk_queue *q, u32 max)
> >  {
> >         u32 free_entries = q->nentries - (q->cached_prod - q->cached_cons);
> > @@ -390,6 +395,13 @@ static inline int xskq_prod_reserve_addr(struct xsk_queue *q, u64 addr)
> >         return 0;
> >  }
> >
> > +static inline void xskq_prod_write_addr(struct xsk_queue *q, u32 idx, u64 addr)
> > +{
> > +       struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
> > +
> > +       ring->desc[idx & q->ring_mask] = addr;
> > +}
> > +
> >  static inline void xskq_prod_write_addr_batch(struct xsk_queue *q, struct xdp_desc *descs,
> >                                               u32 nb_entries)
> >  {
> > --
> > 2.34.1
> >

