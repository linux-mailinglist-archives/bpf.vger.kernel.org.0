Return-Path: <bpf+bounces-38466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C23D1965098
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 22:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21935B21D35
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 20:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02C21BAED3;
	Thu, 29 Aug 2024 20:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZzzzo/5"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC21BAEC5;
	Thu, 29 Aug 2024 20:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962557; cv=fail; b=U7Fag0eiMcZV9tYj0EC5dJu1vnZcNUDV3hLm2Fm/0qP+Ziqtv5WBls4l5aj3JK2NZSIdC1aXlyQrWR9zfA3h45v4PysO2nSJeAfI1gL1IoFIeFmWS/Z3Gr04BgQytikX5bfatCDWxjMTqRQ6vSkoWgRKZWwyqvLxQkxbV74gv1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962557; c=relaxed/simple;
	bh=6HXraTLCDcXkruidTeW3Xu6Z9kYrJgPnadtoctlMuSg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jHlg24h3QJVUR1kDQjtr95MdCro0/1o1JipH5dC5e7eGWn8zEmEObCu/rkegIpmQl+6KdEgZWhX0rSzv9VuCbd+d4gHDNRSHhh1k8vzGyOIjDODJWGw0DEMAmS2y6jbDSYBAnEbQvsL8rf2RjeQ0KqmEccN30/yLa660MrkzA1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZzzzo/5; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724962556; x=1756498556;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6HXraTLCDcXkruidTeW3Xu6Z9kYrJgPnadtoctlMuSg=;
  b=dZzzzo/5xzPQKkgupUKUdCxE9pWbZ5X8d0ZS/ialxP3UysHjlBp9YdAl
   clWm54/C70C6rSxJ7A9MsUHMT1G8GHMJ6sriQXj0Z3n5GG3oVxyKeAQRp
   1IMUsAb5Q8ITsTq4Hgcbu3e9Kt//mfOIUZ+FmTHuVjHvG8hUp/70cjTAx
   KOkvUxfS52Q60ig2dq13Q/kj7ZBGbQl3hsMkTuruSnhPduC+/yrlifVFj
   TlNAB29bhkYxfxh3o4DCkEQOZsIqzlIqaVSsEeFFphUWkNvTfxN7vyZ4e
   Hu+pNjm3b3s9phVQOu34nYFrYsF7lHmhCb5smPBoZhz+9VkIHrShTriSd
   w==;
X-CSE-ConnectionGUID: CLJSfdf6TZm+mQEnKNnXxw==
X-CSE-MsgGUID: uD/KvC4UQHmuBA8+RdUJFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23538899"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="23538899"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 13:15:55 -0700
X-CSE-ConnectionGUID: 3jG23o//T46FKqUX/jORug==
X-CSE-MsgGUID: Fm8bK+JFTl6tRG6UCdmY2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63680583"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Aug 2024 13:15:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 13:15:52 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 13:15:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 29 Aug 2024 13:15:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 13:15:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yol9DFkRdeLUbF9hl9mQEBUB/OBk4LbTvLBmpVY00VThunNd9+eYKEiVGt5mYbt5dzrf4wtafhkGd485WeY5WJGdYv+HwyoNX93Ue9+9SELu2zIMpdXszRpuvH6cpnKCKSxPRH7ZmYDJ62p9QzmbPOyi/rctOFfpm7FTVRPEaRKOsCgE+O7tOazuABuTjYsEZcAfJjIr/CaqC2zdIfkDF5UYmKRRbJWNIzbA1sLUY1SHblQOYLfyBxJJj4/dQNM8njxea17zmjpYZ2T53FsSxq7YPZGsnctxSwsYzPeeTk3eJsn3UwEgOY6FQP9683SjsCth+K6uAU3TtiUdxssnNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPi9r3oeu4fvxe10Zj+s8pHPqSc8p92qQaF3JpB2+r0=;
 b=JR2d4TZwZCMvvZqRLInND46ihvPGtnadbJ8Nm4LHLjAQBB/6Hj6j4dc020scngp9AY2T+8Z51OKLmX/5CAh5KuVlzS7kas/7QJebFaoR1SpwJFlr+JUObQmLkxn/IY6+aIpJYiF7Oq8vg/uL8UvkjS1R//eGcebQOR28URnYzruDmZ3X+C513I9UuJL7HbOdzduBnYPIxhq9C2KLR+so7G+VCQQlRXrxNNYaC/1GSoZtcv/c1yyVAW4dCol5CtEHgS4Q8/Ucxzhhknel5nusYaY3f+fNfB4slX4A5EJH/BTIbZJ6hlVFDlk8sThwtqfZgGv3RlQhftcBjfmlmbrtAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB7403.namprd11.prod.outlook.com (2603:10b6:208:431::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 20:15:48 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 20:15:47 +0000
Message-ID: <f0beb993-e980-41e0-a0b0-7042c276aad2@intel.com>
Date: Thu, 29 Aug 2024 13:15:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] net: ethernet: ti: am65-cpsw: Fix XDP
 implementation
To: Roger Quadros <rogerq@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Julien
 Panis" <jpanis@baylibre.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, Md Danish Anwar
	<danishanwar@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, "Govindarajan
 Sriramakrishnan" <srk@ti.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20240829-am65-cpsw-xdp-v1-0-ff3c81054a5e@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240829-am65-cpsw-xdp-v1-0-ff3c81054a5e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:303:2b::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dfb3ee0-d232-4361-f14e-08dcc8675e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1lEanBxK1ZkMUkxd21HeEhRWWNRMjBrWjJWd1BsRXlwdzQwNlVqdmFGNG8r?=
 =?utf-8?B?WkU5YVdkNzN6ODZ5Q1pnaTgyYVVVQjZJTHBSbThEbjIwdHJ2Yi9zcmJwclQ5?=
 =?utf-8?B?alc4REJaemltbFNTeEVRMTFXUzE4THlvVDNQdE1LZURTSGxXR21KekJzNlRT?=
 =?utf-8?B?alg0QTlVNVlqUFZDS3ZXVkZLRVhsdjBZdlNMaHlLMS9XcnkvMVE0VDc2T2gx?=
 =?utf-8?B?am9xMlJuM1ZMbnlnVWlteTU1b0lld2tuODMrNXozWjk4UkhFRko5RjBiUFhC?=
 =?utf-8?B?OHJObXJQR3oxazdOcXZTamRDUGRHMTNVRDRia1ltWVVtN3VkWHhvdUhqWHZa?=
 =?utf-8?B?ckhJMHB6dHFaVmlTdEdaNkF1czdaM1FtZXdCV0Z0NUtvNWFwSlNhTEVReStQ?=
 =?utf-8?B?Mk5MS0dRS21scU9nWGRpVUxBSjROUTZ6RHlFU3FNSjBNZnY4L3VKb0dUM3Fl?=
 =?utf-8?B?L2dDakpkQndxelpCNFY2NmZGYTQrK1ZxbkU2Mmg2WUpnNEZFcVJMR1FROFRa?=
 =?utf-8?B?ZVBtOG9XUHFtMlBVemYrWFVuMW9uM2d3RUVVRm8rR1o3STVjUmNZeFhoNHR2?=
 =?utf-8?B?Nk1pSjMrdVB0bEQyTFV5cW9xeFNhRVJMQ0xBTzFJd1BCR0dGa3VZV3M3R0ZK?=
 =?utf-8?B?SFMwZDM3bVNXV0dWMFVjYm9CbE1KY0UwTXpVcFMxWHZVaUJWb2dyTVNiV0xL?=
 =?utf-8?B?T0M5WXdQMEJLc3QxdmVnaHhBTEtzek9icERBTWF1WlVNRjB4bFR5U3czWnZy?=
 =?utf-8?B?bVdRck5QZTdscjRWajNXdTlLUkRKaXJ1dFcvZUVXcWNsUkZvRTYrVGpDL3ZX?=
 =?utf-8?B?TjB5SytxK1RQS0pzOVkyVnRpMFFXWWtCaStWT255c0NHaTZPaFkzVmxodXpt?=
 =?utf-8?B?S05qQStXNTdGVHY0ZTlIOHVmTW9kcXpILzYyWVEwU0FkenpkNmR0eVFkMlRL?=
 =?utf-8?B?TmVZOVVBN3V4UHBUVkVJVTR2T0VoVTNBdkJ5d29aOHVXdC80Tm1pd2dGWFdq?=
 =?utf-8?B?SzJCSXpBWDVzRlEyTi9RWE1DV0NtOXl4ZVNQdEsrRHhLZUFxVTkyMTYwTGhK?=
 =?utf-8?B?eS9hZzhKL0MveWQraWpTTTlEcVl4dVM3b1A5b3RXVUg4ajNPMGpKTDQvVXNS?=
 =?utf-8?B?V2Q5NHlZd05zMlNHRGZ5TGJzVVNMUzgwMER3ZnJWZDVkTHZFRVd0blNFRWlM?=
 =?utf-8?B?aFpicGZwY1ArZWh4aHNiTndyRlZFMm4rN2p2VkxMZXlEVm01N2pLVWY5M3JR?=
 =?utf-8?B?TE0vUUJETHhyd00vRk5qV1JUUldmQUxMYXpjd1dtVTRYS2Rlb0F5UHJDSUln?=
 =?utf-8?B?amNoVlJZL0xjazEzY1BvN1QxMXRLYnNMZ3kvdWtXSG1INTB2RS9XSENoMWto?=
 =?utf-8?B?b0JuYi9qeXRwRmVxWkwvcVRVOW5EKzkycVFyckhjTUluRUlTa2VhUmxFZHBH?=
 =?utf-8?B?SnJCVEx2UzdZdWNtQ3FqWDQ3bEdSd1QxR2RySUplR0lwcDh4SlZNWTB5MEZz?=
 =?utf-8?B?WXdWTkFkVzhVb2dZWGFBeS9BRk1xZEhFaEhva0FCaks0dmwwdU9TOXE2Q0Rv?=
 =?utf-8?B?QnNvZ3MvRjJyRGJ2bEZjZmYrN09sWGJpdTE3ZG9IcUo5aEhDYzVDOWk2NUV5?=
 =?utf-8?B?UGx3RlVwQzZUZ1lxVGRPdnJuT2pOVmJFYW5aQWpyVzNadFE2angzbnhqSWtK?=
 =?utf-8?B?U1ovTUdXMTFiZ2FWRnlrc25VeU5yR1lzYjBnazEvV2pxdldIaW9NSEg3Smpt?=
 =?utf-8?B?OE9HdEU5OFl0cEUyVVlmTWtSTk9QbU9FVHlMbWhHMG9KYWVEUjY2eStWTWpl?=
 =?utf-8?B?elBVZkMySXY5c0hBNjBMUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEI0Y2lmS2FuRmFwZzR1N0NBWlM2TjVhYzh5dGtxLzFpS0V2NitTSzc4blhF?=
 =?utf-8?B?bnlCa24rV2dVNk9NeW1oei9KSHFOcm5xWTMydDdKZTRXUFZSTGpNWHRGUGw5?=
 =?utf-8?B?UmpOTXNZcEJ6c2oyeDI3Y1lIdkQ4TUJtcktWUlhkTC9rTWk5NDFKdW01YlZk?=
 =?utf-8?B?b1k1Y2pXb1ROMkV2c1I5bmx4RWR0RTlFWTJWcEgrTm50YjQ3LzI5Y3J0L3o0?=
 =?utf-8?B?ZXpBYTgvaFpSWDE2c1RoQzlsWStLUXZZMmc4S2hDUUNLR3Zjem9ld0RKRisr?=
 =?utf-8?B?T1pCQzR5bk14VHE3bmVDaFVXdEFXdGk3eERCd0MyWEx3NnQ5aHM0amQrZkdl?=
 =?utf-8?B?SmxWVXRlOURCN0xBdndabFp1MHRoVE9SeEpHaml0OUhhNlpSRWRia3pJRWRj?=
 =?utf-8?B?Z3RyOEQ3WndIaStnUzlETTc5a1phejVyRHRmaEhRZ1NZTFZSdWh0WHJVNml4?=
 =?utf-8?B?WWlKbHVzcnNSS1F5NWd6RWJEWjFJdEpMVUY0NjVMVGZLYnFucWxHT0w3ZjF2?=
 =?utf-8?B?dE1SdzBFbWVVQnp5Wi95MkpHZ0EzN2VsTHJCY2RhN0grRmxOMG56MkVuUXYr?=
 =?utf-8?B?Y1VPakhTSWxZeFJyY0h6bTl5Y3JRSFc3aGlqd0svUGZXY1VJQWRkaDRPaXow?=
 =?utf-8?B?TEJXTk9UN3p6VEk2UWdpVHArZE1GWkw0RGNDaDllZ3dZT0NpK2hkaFFQQmlF?=
 =?utf-8?B?OUcvSCt4ejFnZTIxbkJQcndHVE1va2FreXB2ZGZiNjE0YmRlc3JvMUxxUktU?=
 =?utf-8?B?aDVxYWVzcjhQdWhxV0t4MTBtRXEwTWVLdzFJS1FmcDFBT3dSTSsvV0hLeWp2?=
 =?utf-8?B?RERSRDNWbnN4ZEJvd3hIcVBNVU5BNGpJcFMxL3JqTUh6NjMyU2FmOVd0dTlK?=
 =?utf-8?B?ZEFvREgxQ2NjOCtMbCt4YllUWThRWlMza3B2ZmJRcmVRcEtlQjc0dGhidEEx?=
 =?utf-8?B?R0RqcGszekJJZy8vRkNDaE80bDlwQ2tPVUd5WDRIb1pFWWFCZGh1TzlmSnRy?=
 =?utf-8?B?N1p0eGRhejNrSmIvVTZ0RkUzZGx6ckF2UU9aRmFzY2poYXNOalh5UGhaYkEr?=
 =?utf-8?B?RlYrUEZpZVVqeHhyS2JEOHkzaWFEeW5adkNMWmVPOVZWcUw4MFFqeDBwTHhw?=
 =?utf-8?B?L0M1QTlzVjJRQ0RpSEJTQm11a3dyWDJTbjlyOFg2YWZ4ZDFsUmJ5S21vZWRJ?=
 =?utf-8?B?RGk2cTFNTXQ1U2ZGWUxqcFBzRW9TRERybzFHSUlOZnNPR0d3WnpCcEQ3bzY4?=
 =?utf-8?B?Nlo5S0hnQzA1YWRTZ1RDMlU3UHl1SHlXSi9ZLzBDV1FOcnJaeXBiOTNhTmw1?=
 =?utf-8?B?cmRJNkpyZEs0cDdPalluYkkrTGQ3NG9LODBoRjNqNkY3ckJjaURTK0dZRjJl?=
 =?utf-8?B?VXc4cU5RTEFkSHFZd0xScWVBZUpoUFBHY3d2N1JjMmlsMkhiU3FNM0JQM1Zl?=
 =?utf-8?B?aE5LejZJcldWWVJvTm13T04yb1RQL0hKRTVpT0x6UFovRUV5eU5PZ3NzakEy?=
 =?utf-8?B?clR2SG1FUER1RVBoR0tPNGR5V0lwN1R4RXBsRUtNQWRuTVkyL1JFQi9nTjRz?=
 =?utf-8?B?UEpoQW9oRzdFY3dwVmRsUEg2SmVjZHBLWTMySFM5bjR3T2hoU3ZlZkFjZHJl?=
 =?utf-8?B?UW83SVY1S25ucHZrZ1E0eG5Kc2M1OVBWSmlsbzZ4WGZiUmpHZGZKRURIK1Z6?=
 =?utf-8?B?dmlUNm9kcHI0S1BiY2VCakkwOWpLZ3M1VS9taVRWUUZHemNoOCt4UWhFUTEr?=
 =?utf-8?B?TnljZzZQRVkwYUdMVUFoeDlCZ0RyKys3NTN4YjRNaWw0VGw2VWRIM3lIcWNo?=
 =?utf-8?B?TXlTbkhYYzVuS0FuK0ZTZlc0bHdjL2FFTkRKSU9iOVhnc3paOTJrSEp1b2ph?=
 =?utf-8?B?VXhmMjYrZVJ3VXNsK0RQV09MTDRQSlA2ZnVQUWpOTC9Pd21QVUp5VEZnSFV6?=
 =?utf-8?B?b2txTE55M09EalkzOTZNQitFamNoMEJaL3kwN3FWWFhITDJReWhPVVNMZVhJ?=
 =?utf-8?B?MTZ2c2V2a0JVSjhSR1NqR0ROZWdJOGJnQnRoNEF5Szk4c1lpd3JZWDJxSU56?=
 =?utf-8?B?ZVg4TXFHbmhsUm5IMFFuaEh4VHNwenlpOGZPYnRSbGs0Qys0Q0t1ME1pVE05?=
 =?utf-8?B?aXpLdjZaWmVtdUxzWWRVRFB6VThEZlhndlJhQTdZYnNnQTRpOFdXUWI5bWlV?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfb3ee0-d232-4361-f14e-08dcc8675e91
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 20:15:47.9110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkKAhL3An2RyEkCJBshk0gmApVDD2LZQqKcQBqq4vhgQxI2UFe8nUkKnrxsq1kYcNh3fS4R/+33Plvb4il67dL2YGHxbN082ywh/9PQesj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7403
X-OriginatorOrg: intel.com



On 8/29/2024 5:03 AM, Roger Quadros wrote:
> The XDP implementation on am65-cpsw driver is broken in many ways
> and this series fixes it.
> 
> Below are the current issues that are being fixed:
> 
> 1)  The following XDP_DROP test from [1] stalls the interface after
>     250 packets.
>     ~# xdb-bench drop -m native eth0
>     This is because new RX requests are never queued. Fix that.
> 
> 2)  The below XDP_TX test from [1] fails with a warning
>     [  499.947381] XDP_WARN: xdp_update_frame_from_buff(line:277): Driver BUG: missing reserved tailroom
>     ~# xdb-bench tx -m native eth0
>     Fix that by using PAGE_SIZE during xdp_init_buf().
> 
> 3)  In XDP_REDIRECT case only 1 packet was processed in rx_poll.
>     Fix it to process up to budget packets.
>     ~# ./xdp-bench redirect -m native eth0 eth0
> 
> 4)  If number of TX queues are set to 1 we get a NULL pointer
>     dereference during XDP_TX.
>     ~# ethtool -L eth0 tx 1
>     ~# ./xdp-trafficgen udp -A <ipv6-src> -a <ipv6-dst> eth0 -t 2
>     Transmitting on eth0 (ifindex 2)
>     [  241.135257] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
> 
> 5)  Net statistics is broken for XDP_TX and XDP_REDIRECT
> 
> [1] xdp-tools suite https://github.com/xdp-project/xdp-tools
> 

Everything in this series looks good to me.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

