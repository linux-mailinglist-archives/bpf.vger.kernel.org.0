Return-Path: <bpf+bounces-42250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0629A15FB
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 01:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2E81F239AE
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 23:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378511D47A6;
	Wed, 16 Oct 2024 23:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cCavskCA"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E011534E6;
	Wed, 16 Oct 2024 23:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729120008; cv=fail; b=KHXSsoyiDHV8KtYjhSI4y+/ql+jDWnHpxLvz9zSbNuugJTEXL4cNne/QgHg6PxLxzn6iiKBELStmSMx42sbwXBQEe4gD2TIJrnmR8twGuHrcRBi6ENvNBR2ejUINYviJLsDxEvu9PZ1h8/qj2d5syL5OgT6yP4z0rbR/rG+l9wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729120008; c=relaxed/simple;
	bh=2d/PHvVqZbWworFyAvJXv9qiY7a6n2dHprncZN8dyUE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M1rFBptb7nuHnrBugvcHQdytwzZ8WVaiX1oCeTe51isjQ/AfFKdbIwyT9QqTCvCBSkym2nAwnKT9Dk3rpT3F25Cc+q2VWrPOSWxmd5XCU3UWEtvQLEaGqWY9E53cUMcN8V7Xn/eyS+1Pe0ndPKzc3tWsaRxdfsdLS0KeTJ0s3hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cCavskCA; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729120007; x=1760656007;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2d/PHvVqZbWworFyAvJXv9qiY7a6n2dHprncZN8dyUE=;
  b=cCavskCA9QaNU54fUqkaOAcTAKBPb6EJ1rpNrvqXEqGyUHllWZzR9sGj
   3nN4+wT+Js2/PJAo5mkK7RDqsmNhO9bBupquv6S2szMIQSLjGhtWmFoqv
   dfBJ41fyfGHysxAQyRt1r8CxTJmIsUuZeg8vKzUwrRawrfigX+XaNWYII
   FPiUQFKBBmvMDhr3O+ZL2sXIiWq3C+g1vJVlytwj06ly7uiilJAmVi1Fz
   oxtuCm/m8HhPzhas1b83YYwY+NzP/BG0ma74nUcB4ztbObFGTxEPVbcqz
   VVMSRkAAYT6JB00gYHXwKxc+hoimx8mzGVtNmhbxtgOrYQwvI88vTepsS
   g==;
X-CSE-ConnectionGUID: ETuK+X7GTWW+oepN1oqpKQ==
X-CSE-MsgGUID: 9xmSSX8rSu2fP8gavyDfuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="54004981"
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="54004981"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 16:06:46 -0700
X-CSE-ConnectionGUID: DsHjK+zqR0+OusCAaAbjMA==
X-CSE-MsgGUID: OEpwSm+aTmadTv4Hn6pWoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="83432188"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 16:06:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 16:06:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 16:06:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 16:06:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 16:06:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDTe+82QDfLfCY3+4D1W5++CNJGfFb7yhNT/QC6Dm0miJsPpV7Te7bUO1YUx5+OTRTvOP1lpQjaE57/sHyPT94yaPq094B+QaM45Y2UNgHbgnSnkxI+VPFiP2z0HuS2gn0XIIeLelVq2d09yECo71PXmPzEMfTJviWu37rdJw15ttIOVPWOuEvV+NQZ/ID2YiBjDqZXVdnr/WREux9kA2nRZgIsSuCiBC2e6BL66b6i4vwaiJjNLtsGNb7WxOphrseZ16RTVtpb++N/3VNuB6DU+1tKL7/oGXymMMDO+I8xPjen3x1KJpxP3TkqGNfYFNZie2Mn+wt/Tt4RltIQhmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiiXZFTZCmOF30S5bLluIxpnF8i5WUEuHuoAW6tRU4Q=;
 b=jzojeVVIfxa8q+TVbTGimBbZq2NtcbRQJXArOTyflDoFdy4j28+VdNx45+zmIffmUVCjcrgSukP0HI5MChrlGQgN34VFSOdX7mO5tQoKDEG1oSTaDd0S5nabUnpxA89TrI8EDoGXbT9ZA8lllYvOEOSyHSHsvLtkmr+aYeTIz04tpTC1lfF5gFWPtR+tHsbbkoMgHOyyJoSEGaRpq99GAq3Ts6PBuwAYnko63z6u1s0wafKFIAV8wI23JTOjB1nmw9qAfrjPiX9C0JHaenBzgddX0I2WVUxAnbSEbOyLte6ZhZZXirWbHNJB1l8s7wvEAvuuaEzpASYnKAYYLaz/ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 23:06:36 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 23:06:35 +0000
Message-ID: <8e4ef7f6-1d7d-45dc-b26e-4d9bc37269de@intel.com>
Date: Wed, 16 Oct 2024 16:06:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] igc: Fix passing 0 to ERR_PTR in
 igc_xdp_run_prog()
To: Simon Horman <horms@kernel.org>, Yue Haibing <yuehaibing@huawei.com>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <vedang.patel@intel.com>,
	<andre.guedes@intel.com>, <maciej.fijalkowski@intel.com>,
	<jithu.joseph@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20241016105310.3500279-1-yuehaibing@huawei.com>
 <20241016185333.GL2162@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241016185333.GL2162@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:303:85::31) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL3PR11MB6508:EE_
X-MS-Office365-Filtering-Correlation-Id: f3172e86-b5f2-412d-21db-08dcee372ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnZFdm5pT3VZYk5kYmJWbkVoNFFDeGZNanpjaGxmckliWXhwdGJXRTB1aXZR?=
 =?utf-8?B?TFVRdUEybzRPenFWYnRLRi9BYlY1cjlmcklvTlhqdE5yaDZ6WDc5VzJzZDFm?=
 =?utf-8?B?VnZyVk9vREFoT1h3OGVFblkxYzl4SmQwSlNTMnJQaGNLRkRXWXp2NERBdlB2?=
 =?utf-8?B?K2FEQ2xVdnFDeTN1VkE5OFlwR2NuYnE2aVFsUmkyNnJEUnhDTkJrNnFBK25Z?=
 =?utf-8?B?TGRYMWFCczVJV251ZVk5Um14cFpqdDNkNkpDajg4QkU1cytRall3WGxOU3ZW?=
 =?utf-8?B?T0YxckZxZllaNFlJQ3E2M2FmcVoxMC9CanJXRUxDclFsUlhGbmxFOE1LQmtD?=
 =?utf-8?B?OVg2MmNHUUk2U0Z6cnBJQWpxUW9GSUEyZE9pdXl1WlNJaEs0V1JBcng0UWl4?=
 =?utf-8?B?MEd0KzRsZSs3ODNFdmdnakRGdHg5anpUT2NndDNualFxcjFReDBJN1EyeWxQ?=
 =?utf-8?B?cWJWYlZFc1FFR1dINkMyTVhmM2dEelA1cCtqTHR0Zml5bnRoODJ5bElLcExm?=
 =?utf-8?B?S2d4dDh4NEh3clRMUHphQzJ6TjAzd3FBQXM5SWlPWHVUTEZteVAwWGYwbFph?=
 =?utf-8?B?UHF1SkV4L3ZVZHdTVytZdHdLS2Vid3hMbHI1WklES1NwN0p0YjJ6R3hwS3BD?=
 =?utf-8?B?NmFzenhUT1hqMlo5OUNCc0dPOENtTjQ1Sm5qOXNWdnAzYysxNjNBQlZEaGJz?=
 =?utf-8?B?a3Q2ajQwV0xCZmVEMTRFR3lxZzd3MHh1T0xXMG5UL3Flc0lWQlVGQkhHSVZQ?=
 =?utf-8?B?b3QwbHBDRysrUElzMldsRkQ4U2NxSTJpcjJwT3k5Q0YyN21SR2xrZHhDT2Rz?=
 =?utf-8?B?TVJMa1BZQ3JYMU4yNW4xZ1Q2RXNiK2JmdEt0VzhndTUraDJacXcrZncvcWF4?=
 =?utf-8?B?TnNIdzRiWWZoNU83ZVBFZDg1dzIxVWwra3c3eVc3bE00UG1xYjNBRGtaSGZV?=
 =?utf-8?B?em9oRlNGOFB6dHJrcFJSQk4xUjZKY0hrc1QvY3h1Q0haSTlnc04xRklTaGc1?=
 =?utf-8?B?aXBuNitUbEs0VGlraDNPbUliTWFWeXFWTm0yNld3eXoreXdWbFVJdkl3ZmZM?=
 =?utf-8?B?cGc4T1F0NzI5MDVyTTM0b3lBOGZhZktZb2s3Mit6dmEvZU5NOGNXNU9NMWN1?=
 =?utf-8?B?S2VzUnFnVGFOaTZuL0ttbW1nVWZwTFNnYXRab2JQTnVGeU92MGhGclZSQmtJ?=
 =?utf-8?B?TTBBWHd2Umo5NW5hbC9US0RJdlJ0NWhVUG1jMDI4TXRaVUs3bnFsaDI3d0lF?=
 =?utf-8?B?WlI5RzU1NmtyWnRlVFRFanczRDlxS2NaY2o1dml3ZWlXZnBNWG9EWUdrSFVZ?=
 =?utf-8?B?MXNxWkdScWdzZ3RLWHVXSER0Z0dmMnNpTkswN3J2ZzNVeFNTZlFnSFpBYldy?=
 =?utf-8?B?SjRrZDI2a0RBM2tUM09CMFEyWXM0ZVQ2ZUV5K0wycmE3SERVQURkN3luQVdR?=
 =?utf-8?B?SjNxRERWb0xZRHAvOGgxMDJuazZkTFZMK3hqRGtraEgxS1FPcW5RejlqQ3VI?=
 =?utf-8?B?a0VMdzk3UkhHS3UxUG1lLzZWQVFseXlYNnJsZytJM0V6WUlGTnZmVzBEYWJQ?=
 =?utf-8?B?QVR3ZE9nYUs5bW5MaEpBT0IzQlJ0a0JvcTZFOHR3dUgyTTE3eFN4QTVSd2tY?=
 =?utf-8?B?dFpiS0svMVFsb09Pdyt3VjFzNjh1S3dSZm1aaWFKT3ZWUGlqVFVGVWRST0hZ?=
 =?utf-8?B?Q01YOU5WN0VzYW5Nd0x4NHhyNjNvRUpLTjU1NkFnRVJ3UW53MWw4MFRQa0Vk?=
 =?utf-8?Q?pOENxFFCxRjVoR0cXX34cYZG+ViLoqIiO826nbq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2JjZHF4KzJjQ0ZLa0hSVm5qOHVadWtzS1liQ01VY0M4VkNLODY3cHJRYTdK?=
 =?utf-8?B?RFZSRFhLTzY1RXUvNXdtWmdjUnJDcFpoS2REOWd3VXdGeGFLeXFGMSt4Y3JK?=
 =?utf-8?B?YmVOSmZrVEtHQVR4eWlnSDdTQSt6TWRkZEw5ZU9obzRkVHAyUnFNN0ZFbGpH?=
 =?utf-8?B?d2RRTWJ3aEtoMVlQdERCUGViWlkyNGdVQnU2NVI3YWdBZE4vVkJ3Rm1zWis1?=
 =?utf-8?B?SFRKdDVkODBlZ3NaSi85QUNuY2xNU3JsM3pwcjlPRVhqYThRVUsxQm85VENH?=
 =?utf-8?B?ZEFBNW00Q0k4YlpyeHVMUEM3SXlsMlAzTVdMY3JiQXU5VGtEWVdsUSsrUnF4?=
 =?utf-8?B?YnY5NVZlOGc0Vk96QnNmWG50cHA1TDVMZGFNVVhIZ2NtbkNoanJWbENHcGxw?=
 =?utf-8?B?S203eWc4YnJHOVcrckNuUmRSQ1pXL21xdjVhS0FsSTlkZFcvRTQyaWQ5ZjdE?=
 =?utf-8?B?TWhQZUN3MVpVZDZRZUNmaWxLZkZMSzNYTUFTbG9KODAxcE5rcjUxUGlQTkZa?=
 =?utf-8?B?QjNkNW5HTk95L1lPY3ZYM2svVEFGd3hZOEFoV2d2NXpqR09aZHVjS3NvL21E?=
 =?utf-8?B?MkRvTG51Vy9zQVVZL0l4bmFxWXNzNnVSZitqY3ExZU13VUNCajIzQ2t5YjE3?=
 =?utf-8?B?bTlKOUtGMU5CbFhXZjJkTEJBazM0OUdZZDNwekF2d05DY2cyT0JrMHJ2Qm5M?=
 =?utf-8?B?bTlnWjdrV01LR3VjRWxORnpzYW9Ia0ZvbVFlV0lLSXd4WkVYZ0cxQzlWSVlk?=
 =?utf-8?B?QkdzL05PWmMzeE4rYThGeDJEbkQ5bDk2RHU3NW9pOEV0czBwb3U0MHE5ZXZ0?=
 =?utf-8?B?RzVSYUpwNlVaVjc3R0I0Ri9iUmZyY2t2aHp5Q3VIeWk3S0lua0MxREZ5MW9W?=
 =?utf-8?B?NDY1V040VmpqQUJiOWpYTC9EK0ZzRUNGMU5iUHY3THI5U09GWlhLYWNsaXpW?=
 =?utf-8?B?dy9HQktYRk0zUXVQZmowTjdmSThjc0dwb3dZdmppemliYlJJQmVOUUlneGpQ?=
 =?utf-8?B?Y3NlRkkwNzdhYklYZ0R0V0thUlZpZDF5Z1ovZVlqalZ3cERuNW83RzEwUHdJ?=
 =?utf-8?B?OUpNK203clU1WnVjdGdvODcxT3djRkZrOE92a20vSlNHRmU3U1hvWUU1dy9I?=
 =?utf-8?B?dnEvRmNSbG5SZ2wzczJGbmJpNnBhd1h1cnVVUm80WWcxeitpSCtrNVFnbWR5?=
 =?utf-8?B?SnVIS0k3MldsYlFNcTBidVN1QTFYZ1ZqdEJDVXpwK1lXbENTVVhMTC90TlQ3?=
 =?utf-8?B?N1VRa2QydGlaL0FjZGVubyt0NUdIc2l5ZXZBczlEYkd1L0w2WEt5bHpCWURZ?=
 =?utf-8?B?OEVlWTYxYVRCNHdzb1EyYVNvL29leDN4WEFIVC9SVjVkM0Frb0JNcXhINHUx?=
 =?utf-8?B?SCtWMjMyUXZkYVhGekl1REs2RnRVbG1lMHM2emt3dGM4UkJSaEl5MWZTWjNY?=
 =?utf-8?B?R0JPWDdYSEluYjNvZDRsM2Y5WGIwOXlINU1tWjdrYWt6QVArOTRpZFBZK3cx?=
 =?utf-8?B?elNyR3BjdTFFV1ZFdUs1YW9INHQzT2xlWFdLd3BrdFVRaG1qWkJCbDArc2Nn?=
 =?utf-8?B?WG9JTWNVWFlKN0lzZWtZczUwZG5OMWhVMzg1ZWhVblR4MHpudFJEdFY0dzNi?=
 =?utf-8?B?aDJQQmJRWkxxeUVGTkU3RzRZSE84Vi9VZmdiZXBncGJhM3NsaGY3MDVxb3cv?=
 =?utf-8?B?WElHQ2lxWWp5MUtWN0E1STRKekMzRXlMaWFkWXZDQ2NXSGhOTTlRemxzNmxS?=
 =?utf-8?B?Z1FzT1QybmNCNyttbERsaVJSNWhZRk9hZ2o1VVNLdEFGWVVmNVRaeW9Sem1r?=
 =?utf-8?B?SEorNmNGRVRaTVJzVlkzck1uSW5RRmZsNnZwZTdDeWdRaU1Da0xOQ3R5Nksw?=
 =?utf-8?B?VHhFNk8zb2tLdDJ4VDhCSmxXcFVtaHdrc0NyTXpSWkJCOWI0M2hHcXZXcTNJ?=
 =?utf-8?B?dm85VmtvcGo1azNkNjZpWUhEckNzL3BhenM2SDl1ZnBnVkRld09pbFJYazJK?=
 =?utf-8?B?TEs0RzhPWkMyR0tBdnZBbXI4R0lsSm1zcy9LRDB3eXhCemhFZHpwSE1nSFY0?=
 =?utf-8?B?OW9NNmkxa20rcDg1VmJlbnFHakxid1Foa2lKTTdySit5QUNlc3JHV3VoS2JG?=
 =?utf-8?B?TUVHakVHOUhqcXRBdGh3WWtqYlJjMlpvSjNpeDcwRi9IN3JsOWhSNEtUaFha?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3172e86-b5f2-412d-21db-08dcee372ecb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 23:06:35.6548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ye+n47nP4RxS8G7+uZatiEAVgKWJkLseyR+3lkkzSjkstIG5i/S5iaFinHGzR8+Gmcl8WHj4hcfugUb3TQgaBwLsgvLjiL7nP2Xy7nHwU1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6508
X-OriginatorOrg: intel.com



On 10/16/2024 11:53 AM, Simon Horman wrote:
> On Wed, Oct 16, 2024 at 06:53:10PM +0800, Yue Haibing wrote:
>> Return NULL instead of passing to ERR_PTR while res is IGC_XDP_PASS,
>> which is zero, this fix smatch warnings:
>> drivers/net/ethernet/intel/igc/igc_main.c:2533
>>  igc_xdp_run_prog() warn: passing zero to 'ERR_PTR'
>>
>> Fixes: 26575105d6ed ("igc: Add initial XDP support")
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>> ---
>>  drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
>> index 6e70bca15db1..c3d6e20c0be0 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -2530,7 +2530,7 @@ static struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
>>  	res = __igc_xdp_run_prog(adapter, prog, xdp);
>>  
>>  out:
>> -	return ERR_PTR(-res);
>> +	return res ? ERR_PTR(-res) : NULL;
> 
> I think this is what PTR_ERR_OR_ZERO() is for.

Not quite. PTR_ERR_OR_ZERO is intended for the case where you are
extracting an error from a pointer. This is converting an error into a
pointer.

I am not sure what is really expected here. If res is zero, shouldn't we
be returning an skb pointer and not NULL?

Why does igc_xdp_run_prog even return a sk_buff pointer at all? It never
actually returns an skb...

This feels like the wrong fix entirely.

__igc_xdp_run_prog returns a custom value for the action, between
IGC_XDP_PASS, IGC_XDP_TX, IGC_XDP_REDIRECT, or IGC_XDP_CONSUMED.

This function is called by igc_xdp_run_prog which converts this to a
negative error code with the sk_buff pointer type.

All so that we can assign a value to the skb pointer in
ice_clean_rx_irq, and check it with IS_ERR

I don't like this fix, I think we could drop the igc_xdp_run_prog
wrapper, call __igc_xdp_run_prog directly and check its return value
instead of this method of using an error pointer.

