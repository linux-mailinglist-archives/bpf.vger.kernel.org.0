Return-Path: <bpf+bounces-68749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CB5B83B37
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 11:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7002A6B2D
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 09:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03952FF65A;
	Thu, 18 Sep 2025 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TO/jIQ04"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0F21E3DE5;
	Thu, 18 Sep 2025 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186715; cv=fail; b=AAa+7O+Y+EcL52rM7D6nD9vs7l9uD27GSyy+pLLLAEDWVMNKp16NX3CaipWUYzuYx4NtIRIjWGzisvU1KtWpJl72TqVdtRWY5ueZ1e27hSemQ8Z2Sa0BSma62FUievABNh1xc29yiqjTq42dLLzdfVJyTY0Q5Nl02gLmCjBKUMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186715; c=relaxed/simple;
	bh=mhgcl/XstsZvMGxonTe3xmY8GFGSBj7mezXe57UrNBU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZQei5YINGcnMegO4owV3b/xFEFbYe50c7X3JZ6mFQzuUy9v+fOGrxps4kuoBGP2QWeDqxXKfnkw46/i8t70aEeptd83QZ1wQee1XEhePuUp4csIU7PJtSdZAeeb9yVJvY87pmq8eX4tVvuS51eytq7d+NFls7gD6beYLvOp8xgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TO/jIQ04; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758186713; x=1789722713;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mhgcl/XstsZvMGxonTe3xmY8GFGSBj7mezXe57UrNBU=;
  b=TO/jIQ04564leaXvMC5vFnTOxB/YFYaRbtTnSh+XPx+NvVp7ppftdAG5
   V6xqCGRvZCsak3309MozkF6UgRocrl2XhYmP4Hb1/+PeHG7EZx2D56bUV
   UTA84LTd2xAkGznaIiN4XrHWN+kQnnhcfemkQsdw8HS6sN+B+Mpbm7Fth
   ewlsZJ+1lMY0ZjEqA9F4WnBjv32aT8xFW31a7nfzzW/gOMVZuYuz4FETL
   55LrYkULNpAbdC/LKEuByXee/K384NLVTIknUB7+wHZnGo8YuT9iXwsUG
   vpvybWRtZPeAxTkj0gPPp4Go1XCi0F9fRoKT34rBCKFUyqRyHRdXVQgbP
   Q==;
X-CSE-ConnectionGUID: 9aGlTj+MSA22EaR34UIkzg==
X-CSE-MsgGUID: l6ZoVlJJTDq7iO+qFc7tXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60398360"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="60398360"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 02:11:52 -0700
X-CSE-ConnectionGUID: whm+xoB5Qo6RlQCM0HFUeQ==
X-CSE-MsgGUID: z+IhZ2RpSGWc3SgPNX9MpA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 02:11:51 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 02:11:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:11:51 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.51) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 02:11:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1PRkL5bmp1NZjCf1YuUG4Fiweh7cYeFV4pumjNpiSvn4BTS6DDImrfRhPkrx0nwWsfRKvyhNy5Io/t2pKPKMYD/igSBgqHzd6jQN6U7mAtea50L3w6CwrxWr6bLD83PfOKAqioOUj8DIhReu+DkeR373LIf7zFmBjovOtEFM3b1nKNQ4ymsUmMvkdj8I2ITlP4oPzMUXHLvri1oCMi/6QHLZ9mkJDxuKT8TjiCnfE2cS1alSMPk9sJQsruADjueTP95IrI9plSQJSrJGqOZCysYJwzTrY82BKhknra18XVahTdWaHTO88vOwrue5b2JbbOjXrLjYIBW0k3dsOlJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1FBICQOlcZFyVa1RIXpL6cnkd2pduOERYPBsZmuj+8=;
 b=yuz42vYpBKG1j97UbRJUvkqdwa2H/Q6zzDKvn+uVUiWGfN7SrDyKySjeVm175mc9CodCC9JIgPbk5rpQwZS5UuhYyaoKGWJBm4l9jy+HzKl4w22DJo9aa9xXz0bFPDMo7gtvpzSVpSI3/GpYbhrzU6501xG1ZZ5iOSrrOvmGmDMITYYYDKbET/RRRK6aT/txfMZeYzQraAXnn2Iyg6L778EA/5E2f6EhdKKnlj0aXH138oNsFx6iPgzSgxHcWyVuFF7l1d5Xev+t+15cg1Pax6+5Bqzw85kb8Y00MQk88XCu7b/8qhXFovvXj6bPmXiQWEYJT308oWStFw5TGBfCTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB5085.namprd11.prod.outlook.com (2603:10b6:a03:2db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 09:11:49 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 09:11:48 +0000
Date: Thu, 18 Sep 2025 11:11:34 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Amery Hung <ameryhung@gmail.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<alexei.starovoitov@gmail.com>, <andrii@kernel.org>, <daniel@iogearbox.net>,
	<paul.chaignon@gmail.com>, <kuba@kernel.org>, <stfomichev@gmail.com>,
	<martin.lau@kernel.org>, <mohsin.bashr@gmail.com>, <noren@nvidia.com>,
	<dtatulea@nvidia.com>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	<mbloch@nvidia.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v4 2/6] bpf: Support pulling non-linear xdp data
Message-ID: <aMvMxrPsNXbTuF3c@boxer>
References: <20250917225513.3388199-1-ameryhung@gmail.com>
 <20250917225513.3388199-3-ameryhung@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250917225513.3388199-3-ameryhung@gmail.com>
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e57c8c-3981-4328-2c12-08ddf69365ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kKp8LaRv85jweaTjrBjZTZ5s5G4H4KKG9Ty2yOjqwib6gDeErPn4oEWbn+YN?=
 =?us-ascii?Q?mR4t8dg1GG4ebBfuaXHIHMOyHAIkmZm/UAxBD9YYYv+kdLhO4Rw8CYDBeJzx?=
 =?us-ascii?Q?IPfcEy75dbsD3P2JZ1HSonuBKCjl3MWvlkLI3TTdS7HrXUrMESZ7cz+J6nDT?=
 =?us-ascii?Q?vgdbB+Oxp+M81F0gZ2pfbSq/mEB2vqXpF7JeO0nVAi1b7whcUpHFloNNUxzz?=
 =?us-ascii?Q?7fV7NAC0a8Fzj+5R4FmIqck0uGtJOq8I0aYSIjy6m3C7JyNyNwVsncUfj8Fq?=
 =?us-ascii?Q?T87utl2NwVSUx+HTW0smPsbrgIg8LBTT5bFas4JPBFwnnIEd7iBz3sK9LpIq?=
 =?us-ascii?Q?GVxt7+8gS2OllPKLW3rgIqhiqXW2SaaVjcp4g+UTwEHlDemB5Ezt+Ld7nQs4?=
 =?us-ascii?Q?LosNszJEOhbd22MjHw35iIoIBF0vuHqbVKF09ilIkLlWFKKMB+/g2fpMPxnb?=
 =?us-ascii?Q?+HFqSOpdDPR4wEz8s8DoLvJjVwqlE/H2sQMkgUoqpYzxgpyM5Oku/RHdWcF5?=
 =?us-ascii?Q?KDAztU4WZHocEhIfBwMQVOUPu1iNAX/AVlKUZfvBK1rOk4rSrVmY5CTDjCS8?=
 =?us-ascii?Q?NRc4QApr6Cjnflf5hZ4gJ6PivdxSO+NGyZd0KFdaZ0G2QipW8w0cxW1AhI+3?=
 =?us-ascii?Q?HmsV5IRaiElQ0AlvwQYvev54ZvJ2klsBP9QJog3ZQqkm9b2SsoD2trO+IK6C?=
 =?us-ascii?Q?uSkb5GJ4sP9zELnPSRZPr5DvDndlPFprsIf7dYArmNaHxbsUQVeOabXM+tfT?=
 =?us-ascii?Q?igszhEWTVphGANhDL26DLLHlZlk6LIzk1mSi3QodecIYWEuO8a7En9TjBPdN?=
 =?us-ascii?Q?0mV6ZV+iW/q+chHGKvmPzZiDxU9MKAKNB5XXl4EzUxE5suXFgQ9faC/7cTaS?=
 =?us-ascii?Q?W/4EJAKxybgMk4ty94nQu90ZCeF/XnBsaWU7y3tgoq17gK/kfEjOw0HOWJxA?=
 =?us-ascii?Q?fMSoHfZeCBAdx+Hu2sqq8GRYsHp8Kr/Hs2BPefl3GAxh9fS/3O3XlSg3g83Y?=
 =?us-ascii?Q?TTiyewTpvTPdJdHJXnGweQQmvn2qizt8nrm4hslLU39b5L7KKC1dhkOMtsb+?=
 =?us-ascii?Q?1PEAe3lyWD6auzV5zle6bMJ48NMQQcm5QpJSO1/uqfEWXB4g3vvKht/xU65/?=
 =?us-ascii?Q?D4n/cCJKC8mM8thtLb3OMQWDc6rbN+IZBDKj3to2KBLZB1oEcW9sPYDqd4T5?=
 =?us-ascii?Q?APcXLXyhpTMFWbLKBjMyMp59st+PqzyKYjG7BYrlhUnljV2KSIL/lcPc1x2x?=
 =?us-ascii?Q?J8ktcB5tqC/2E4VjGxgrAGkq3leNfOwyWKkIH5htO9RyGXGTZlvBp2d/oX8Y?=
 =?us-ascii?Q?BZt5pqt4eGk8XDzRIvKlKjzjBCHaS43PYARNKCwEcXPzkVD+6tVeohInOip+?=
 =?us-ascii?Q?T16u0Z0e+XJWt5tCGbbsrV4rkKdb+wF6/FlrbX1YPv4RC9yooyYtzOhcNt4J?=
 =?us-ascii?Q?aWtnXrRe2P8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CYLcyPNAmBiEJII0EglwbnPosKbd3sDflrKEdRkUz0Aaha4uFEGfYu3Xhg0H?=
 =?us-ascii?Q?cc2COV7aCNt+YcUGjWx53L9PRUt30+rgkGXrLHLSMSY4D2KjaJ6RqgqGQAUM?=
 =?us-ascii?Q?Cz7FUdVwp4zL45w14wiHgsVwZYXxR9V6HYZE5Q+yQH8RUbw/E2XMem/kCCvA?=
 =?us-ascii?Q?Iu18UuXrglFxA4O2wcTi6k8T9erRzs/tdY2AqaQ4z23SmghT4JaN31TsurnL?=
 =?us-ascii?Q?GQDd2fmBrIwONDRZzDdGNareP79tYnS/lR6r3+PGA5iqOJQ5LrahZooNF8MP?=
 =?us-ascii?Q?gp26uGYtwn+A/2aFOxizwFPZRXEG7O0DvIwdNT9NdLjgCcAsXbe13BZ1p+5V?=
 =?us-ascii?Q?rv13sRjxiD8trIWiRd2ccipbHXT4WaWG0GSWRViZ5j23iZSQC9idaOqcbL9g?=
 =?us-ascii?Q?EC7PCFBkhesiE+nDtKsjBiZVh35kwlnwQjVmMhni1OMk46G/vQrTywOFPosK?=
 =?us-ascii?Q?jHH4CPPZmqevlndwyhGR/sqKQ/m/Onz3XcJeqj/r++zQqINl4L1QNGSB/Hdh?=
 =?us-ascii?Q?qxuQQ/L1TX4B3p9AwMEQm5GahesKr8gdGPbDyT85pFXEf2KkPQGOZZs5wsGo?=
 =?us-ascii?Q?Ia/79HAryCtWp47Y4i07ehfV6bHwmPr11WZg9rezT4TrleMl6bs24JpCRPgk?=
 =?us-ascii?Q?PSZqfmerCRjlOAnSjTYKmhX2FC4RNIKUM+KV4HV2vTut0w3nPTTcVV/6d2pi?=
 =?us-ascii?Q?nNdIWSVNNLqm4/wgYL1x8dTIsXrtWxaJ6mwMcKC7me7R+uorcqJeZKWIR8Vr?=
 =?us-ascii?Q?NLurcPIn0J1vEFtfVbFRYWhvM1YO9A6rXW+3PrHU92OGfI2y8iDGEeIf9dXt?=
 =?us-ascii?Q?fjj6b0uwDE6/vwlMV2GJeIrfivR8fur96Gm/WinHakvjIF/EF0KGX1vKAz3g?=
 =?us-ascii?Q?Z4coAZnrThVvNs+jdwbUpp6TK6F9MwVXBchc5an2pQS3yFR4BzsWN4DXpVJm?=
 =?us-ascii?Q?d1i+MoCXvP/o+WBwjUTwrsiSfyZaJdXf3TsIlhOad1CVF74rlDoCu/1Om665?=
 =?us-ascii?Q?8Vlgc6Z6YfGC9wypxo54AwLT6PRrxpDwuB+7foBbW7yo4+kQBj5bljzXq5Qg?=
 =?us-ascii?Q?DbMPiIMVusUItXKELSjn8Cn3DmUjhFbDZUXnUyzRbnTwh2fRoKO7WVwMJKR0?=
 =?us-ascii?Q?WenKmWj+HAxmSgUb1ZPeoSuPMGXFm+Clu7nB62DE1DTdQONNFtTWMmspG9GV?=
 =?us-ascii?Q?0Y7Ql+IJePTLsdSyMV0ESObcza1XcpAprTq2KiQ4GzyYXoIxiAg0x3r03dwE?=
 =?us-ascii?Q?0mNo+Ez/pFCUl8UXj7q8BYhpD+uERZ7LuDhxkpTuh6f0yUSVCNGYRRXGTdOE?=
 =?us-ascii?Q?DyEnRqiFEciFB5pYBPKwSBUzYqlDGx6J3LqUdDarQYKn2cTtliEHG4Jhn9Fw?=
 =?us-ascii?Q?kD8ZtXfOMEgZNTwhLVlbOYR33VVlSxlb4nMKBBRGdSjpFBAVrFvjOghY2u4E?=
 =?us-ascii?Q?BxUO9zhoiWjHHNrTjujoaA2D+k1xE9uQWL/uytIH3Gh23QBbi6ZpXePXz5ZJ?=
 =?us-ascii?Q?uB8S/54N2fVD4OlzOMoa4oAlkpkuUJpQ1iJLBJG+RBesMxrO8aX2HsFFX1/O?=
 =?us-ascii?Q?klAr8g6EaLuJBsOU+TIH9PUU8oANy6XQEdXMGL4MSBzpuV8ShEQOUXRmQ6kZ?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e57c8c-3981-4328-2c12-08ddf69365ea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:11:48.8208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6t9fy4WlVFOrdhyJjld9UnLYBScQqmjYbbQU2khHdQGyqaqnJi6wpblCDbcw2IgmvP6ia9DJfh30RjxLv9Lau6zOgMF2AHlG3bb70VlNYmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5085
X-OriginatorOrg: intel.com

On Wed, Sep 17, 2025 at 03:55:09PM -0700, Amery Hung wrote:
> Add kfunc, bpf_xdp_pull_data(), to support pulling data from xdp
> fragments. Similar to bpf_skb_pull_data(), bpf_xdp_pull_data() makes
> the first len bytes of data directly readable and writable in bpf
> programs. If the "len" argument is larger than the linear data size,
> data in fragments will be copied to the linear data area when there
> is enough room. Specifically, the kfunc will try to use the tailroom
> first. When the tailroom is not enough, metadata and data will be
> shifted down to make room for pulling data.
> 
> A use case of the kfunc is to decapsulate headers residing in xdp
> fragments. It is possible for a NIC driver to place headers in xdp
> fragments. To keep using direct packet access for parsing and
> decapsulating headers, users can pull headers into the linear data
> area by calling bpf_xdp_pull_data() and then pop the header with
> bpf_xdp_adjust_head().
> 
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  net/core/filter.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 0b82cb348ce0..0e8d63bf1d30 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12212,6 +12212,96 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
>  	return 0;
>  }
>  
> +/**
> + * bpf_xdp_pull_data() - Pull in non-linear xdp data.
> + * @x: &xdp_md associated with the XDP buffer
> + * @len: length of data to be made directly accessible in the linear part
> + *
> + * Pull in data in case the XDP buffer associated with @x is non-linear and
> + * not all @len are in the linear data area.
> + *
> + * Direct packet access allows reading and writing linear XDP data through
> + * packet pointers (i.e., &xdp_md->data + offsets). The amount of data which
> + * ends up in the linear part of the xdp_buff depends on the NIC and its
> + * configuration. When a frag-capable XDP program wants to directly access
> + * headers that may be in the non-linear area, call this kfunc to make sure
> + * the data is available in the linear area. Alternatively, use dynptr or
> + * bpf_xdp_{load,store}_bytes() to access data without pulling.
> + *
> + * This kfunc can also be used with bpf_xdp_adjust_head() to decapsulate
> + * headers in the non-linear data area.
> + *
> + * A call to this kfunc may reduce headroom. If there is not enough tailroom
> + * in the linear data area, metadata and data will be shifted down.
> + *
> + * A call to this kfunc is susceptible to change the buffer geometry.
> + * Therefore, at load time, all checks on pointers previously done by the
> + * verifier are invalidated and must be performed again, if the kfunc is used
> + * in combination with direct packet access.
> + *
> + * Return:
> + * * %0         - success
> + * * %-EINVAL   - invalid len
> + */
> +__bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
> +{
> +	struct xdp_buff *xdp = (struct xdp_buff *)x;
> +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> +	int i, delta, shift, headroom, tailroom, n_frags_free = 0;
> +	void *data_hard_end = xdp_data_hard_end(xdp);
> +	int data_len = xdp->data_end - xdp->data;
> +	void *start;
> +
> +	if (len <= data_len)
> +		return 0;
> +
> +	if (unlikely(len > xdp_get_buff_len(xdp)))
> +		return -EINVAL;
> +
> +	start = xdp_data_meta_unsupported(xdp) ? xdp->data : xdp->data_meta;
> +
> +	headroom = start - xdp->data_hard_start - sizeof(struct xdp_frame);
> +	tailroom = data_hard_end - xdp->data_end;
> +
> +	delta = len - data_len;
> +	if (unlikely(delta > tailroom + headroom))
> +		return -EINVAL;
> +
> +	shift = delta - tailroom;
> +	if (shift > 0) {
> +		memmove(start - shift, start, xdp->data_end - start);
> +
> +		xdp->data_meta -= shift;
> +		xdp->data -= shift;
> +		xdp->data_end -= shift;
> +	}
> +
> +	for (i = 0; i < sinfo->nr_frags && delta; i++) {
> +		skb_frag_t *frag = &sinfo->frags[i];
> +		u32 shrink = min_t(u32, delta, skb_frag_size(frag));
> +
> +		memcpy(xdp->data_end, skb_frag_address(frag), shrink);
> +
> +		xdp->data_end += shrink;
> +		sinfo->xdp_frags_size -= shrink;
> +		delta -= shrink;
> +		if (bpf_xdp_shrink_data(xdp, frag, shrink, false))
> +			n_frags_free++;
> +	}
> +
> +	if (unlikely(n_frags_free)) {
> +		memmove(sinfo->frags, sinfo->frags + n_frags_free,
> +			(sinfo->nr_frags - n_frags_free) * sizeof(skb_frag_t));
> +
> +		sinfo->nr_frags -= n_frags_free;
> +
> +		if (!sinfo->nr_frags)
> +			xdp_buff_clear_frags_flag(xdp);

Nit: should we take care of pfmemalloc flag as well?

> +	}
> +
> +	return 0;
> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
> @@ -12239,6 +12329,7 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_skb_meta)
>  
>  BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
>  BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
> +BTF_ID_FLAGS(func, bpf_xdp_pull_data)
>  BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
>  
>  BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
> -- 
> 2.47.3
> 

