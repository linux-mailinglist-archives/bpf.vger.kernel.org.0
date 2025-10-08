Return-Path: <bpf+bounces-70587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C33BDBC45A7
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 12:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A110E3B1B3E
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 10:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F56A2F60A4;
	Wed,  8 Oct 2025 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lizUzmee"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261D02E8DEA;
	Wed,  8 Oct 2025 10:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919859; cv=fail; b=nF4B/5SsLGyjWIZVYUtYaQxCD8zKTTWq+2oBwJMh3CWEfF3up4fIj//f5UNsFrhXeARqLJkX28yOP5JUwHGNivA4c66fa9Y1yaaXy0MRXjkkEv/LwJRwIty0kRHyL7R6Gh8YVf1j6svWukKv/UnYuaeihw8rxp9hI6pFLiITTJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919859; c=relaxed/simple;
	bh=3LzZkDBjF8jIg+XZCj25U8E+VPulLIQD4wyUtoXRorU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UYA0jkJAy4JWxuNgIHrZ7kZBh1ug21aRP550VfHn/KUXlY03YYNuzlYI3gSD3fcfrZBZhk+VhYS82PiHhdX6bq2UuA5WvGW3gqdTAkRPoPSogc63dkS2vcqr+E5rIAfws151JaRcG3noeN46OujZAYJvrbf8Pm4q53+beck28as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lizUzmee; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759919858; x=1791455858;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=3LzZkDBjF8jIg+XZCj25U8E+VPulLIQD4wyUtoXRorU=;
  b=lizUzmeeXqzA+9wbOQDcVQux8qlS4EmkSkudLGO+yPKdJttWMtIUULdn
   yuCwa758hNjbD43s+dqQJ4k47aN+kP+ncM7lA8z1c5VWJR9fMHLBDrV2c
   d6IKyVOP2DUV4vaqZ6MrQAE98FCfOrsagDaI0gQfhfqdDpv3fHWUR9SCZ
   OA9pFqCAZrf0q7xYUrgO+bqog682V1P3dld3pWyRmM6K+OPWshvNNhj7n
   8+29aKro+yQK2II1tAohh9Bh9vIBgsu8p9fwt++xssc1uG017Rq7oMEvc
   X3XYNW8YnxrpaCQbOZ7XTfEpHaQ2wJB2ACKMXr7Hh1eiEzaJS3ilIAW+f
   w==;
X-CSE-ConnectionGUID: zZWcnU7HQ6KGVAaw+Qy95Q==
X-CSE-MsgGUID: 21fYPnY2RZGqyPm/7sJ94A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65935260"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65935260"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 03:37:37 -0700
X-CSE-ConnectionGUID: 3AdjusMmQTSKO+KXJTUbHA==
X-CSE-MsgGUID: /1/cbkjSSWutUIEi4Gf/EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,323,1754982000"; 
   d="scan'208";a="184442935"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 03:37:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 03:37:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 03:37:37 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 03:37:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCS4FIOFFuqXQ7jRuobq4oBJfZxdKFaulBQeLbZ+c2KKKj/rq+bntZypnidlSQEcLdwIwBMmrbL0tGT8eMH6QnQqejjEMm49Iq0fqF3tZ/C4Qg985Uf4d30jTBElUFbpv304DAtxBgcYCcYHuGT+/D8ADCSYT/7Z/J6PyPWO22ldHjDRnuidQav95GfaQAAR1K/U14m5y2SoHmHP/EElj0rmdCguDEb5bw325aD8kiBIRUX7qp2sj+VmaFPhgFQScoEokggbKYnS2WbrjvPdL29d/VbFVPj9o/8B87vqViLNba2KiUF6aEtfnCs6lGW+RlEb+hezGWjpTs3MHscPwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fL2lSAGE2a3OALSMzQykQ90d1vbWVcCAfWIFSKs+pr8=;
 b=KrlYEHkhFO3gxqNk7fFniM898MHx9Ca2cR78wTA1Vyf2IzMh79IobhaQLlmk0f43AGzFx3ZVWR4lX2tMYaBN/zwy59zs/cuayAXh6y+Dca2syBseeCkus7ZIYXvkpcAqkIYqVENxzplHeBQ0V+TO0jSrIhVSYMKXF0cp9a2GHhaDjWLLJoN+s5LwLq20MQ68p6rz/lwS63eRslSwQmCCIx7So/ntuC1niiTtPkN4HMRpVxudP7Iw4pQjbC/vcoEfx87zRk7Rq3jZOafygULQnD3/3JKcpZZoeWdtdUlv5yP4WpP4b91qHkaJmiPctcK35SWIQCk+/fe5SRBnxh5ENQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS4PPF6915D992B.namprd11.prod.outlook.com (2603:10b6:f:fc02::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 8 Oct
 2025 10:37:35 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 10:37:35 +0000
Date: Wed, 8 Oct 2025 12:37:22 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <toke@redhat.com>,
	<lorenzo@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<andrii@kernel.org>, <stfomichev@gmail.com>, <aleksander.lobakin@intel.com>
Subject: Re: [PATCH bpf 2/2] veth: update mem type in xdp_buff
Message-ID: <aOY+4qpQ+tzIWS5Q@boxer>
References: <20251003140243.2534865-1-maciej.fijalkowski@intel.com>
 <20251003140243.2534865-3-maciej.fijalkowski@intel.com>
 <20251003161026.5190fcd2@kernel.org>
 <aOUqyXZvmxjhJnEe@boxer>
 <20251007181153.5bfa78f8@kernel.org>
 <aOYtUmUiplUpj2Pj@boxer>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOYtUmUiplUpj2Pj@boxer>
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS4PPF6915D992B:EE_
X-MS-Office365-Filtering-Correlation-Id: 330b551e-9a13-4107-810e-08de0656b1b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vm4yU0J5Z1I2WFQwaHNrVkx0elFLWXZwaTU5bEloUGRkQmFYV1RVcHRXNHBY?=
 =?utf-8?B?MnN2ekRydS9ScVJtOXY4UWhBZDNVOUlzMVRRNmFGTUlZSnFoejBBa2N5bE94?=
 =?utf-8?B?aTRVaW5pY3ZhbnZzcmdUNHozcld1Q2VROW9OSlZrTzJOWkNUOUtPTTg3OEtt?=
 =?utf-8?B?QVpuNU54NWQrY205dHF4RHlQL3hiZkUwdDQxMUQvZVA1TklkSjF3ei93aXha?=
 =?utf-8?B?Vk8yZHdlaHJPNEZJeEYvYUlCWi9LNnp5RVpUQUJhR2tYL29QNjNpMk1ZUEdH?=
 =?utf-8?B?TXdyVmNtZzFWSmdUbFB6bDJNZ0s1dnYzWVB4bEtlUjdNdUt0N3QwTlVjMlBv?=
 =?utf-8?B?NnBsNTBCcFcrUzBFTnI4cU1yQ2g0Q1pEb3N2Wkp2OUZxWjF2MFhxNG9yZEJy?=
 =?utf-8?B?RlJXd09RWC9Lekc2dlYrdXlUd2RrVUpGRjc3OEF1WFNPZ1hpdEtsUUpCMUZU?=
 =?utf-8?B?YzU3Wjk0aHFjSklnYmtHQUVXMDFkdHVUQ29uS2dpK2tRT0J1eHowSDludGY3?=
 =?utf-8?B?T2EwQlRsZllxZzJMSzBEcEtNUzdXc2JUaUozcTg3LzdEb0lPQ1RQclM1Tzdy?=
 =?utf-8?B?SE9SNlg0bmxhMExLTmFJVFFFTjR1ekV5a29reVgzMmlhdU1KL0VkWWd4eVNQ?=
 =?utf-8?B?ZmI3T3RPRlI0QXZOdWJRemhpek9kQ01xVDVZVmV4OGZFNXpuTThHZklYUUFZ?=
 =?utf-8?B?WlFlZnBtOVFRZWt3dmFEZ3g3YWpoM2NIWVFEdThxbWwyZHlNUmNCYXhsYll1?=
 =?utf-8?B?RFVrcWxUQXFuUUd6eWpCZzBkTjlmeS8rN1AzUXNGaGFpV3g2bTZsZktDRlVZ?=
 =?utf-8?B?em5PMHBZcXRnYk9BVjhwYVdmSFlwUmdCTVdHYUtNb2x4OTlITmVrK2hjMkJt?=
 =?utf-8?B?Um1PcTVlRmRYdUpJaFRFaDVYbFE4MUpEdVFEcVRmQTd1QWZLNkQzTytMVERn?=
 =?utf-8?B?ZVBNbHZ6V3JkU0JxcUxXaEFaTkh0VER5eVVTdXdWZDJnUTRzTDdBQ282UVFx?=
 =?utf-8?B?VkI4d3hBKzJoZXB5YnNUVnZsWTAzNWR4ZmZkdFZTUzFtL1F1N1Zwa1A1L1ln?=
 =?utf-8?B?NFIyZThtcCszb1d5aG8yVzBHS1l5Qi9adHdxem12OTlYSE0wZS9XcWlOcGhG?=
 =?utf-8?B?c2FheS9ZRDdCNmxucC9kQ1BCL1pSUEtQUGFLcEpnNlNxclJuUFdIdEdBN21j?=
 =?utf-8?B?YnB5UW95bjNtdVRKNWVobkpuMVJ3MTVodkJvYk9OcGgyOFYrU0E3WnpvaXJX?=
 =?utf-8?B?TDdxaGdvakVabmF2Zit2TTdQWFc4WldScVJ2b1U2cFM3L3A0UFloS1Q5bDdw?=
 =?utf-8?B?d0xvRHN6K2VhS2J5dnN1UW1TbEJySXVlbmh2WlNieGFCazF2VzBlcFdNZHhF?=
 =?utf-8?B?U1NvS2RhNW9ubkdhVWNtekVIRXQrMEtSaXFNZ1B5V05McU9vUTFjYzAzUVpr?=
 =?utf-8?B?bHNSZ1p2QmRRUUVJNVVSdVBMZmw4YUFTOW5jcE8wU3duaHE4NWxTbi85MlNm?=
 =?utf-8?B?Z24yZEc3a1R2UlcxUUhKM0JtV044K3h5N3dxc09WMlRYNHV2M1Y2OWt1am1r?=
 =?utf-8?B?c244dFN4QVQvL2RXYTl5QVpEcUJ3QXhLZ3BvOHNuSnlsMXZEMWxyUENabExw?=
 =?utf-8?B?d0c0ci91NmN1OUNtZ1VWL1NIbWdHdnM5UHFxUzdnQ2hDZWlYdEtaQUFNaFRz?=
 =?utf-8?B?RjBWT2RXc29vOVhCZGdsVEUwOXdlNEFyT3poLzFCNnRxTXRkVXJHZFd4b3Z0?=
 =?utf-8?B?NXF3WmRveDdnZ0RWZVl1OGpQNG9HUnBSemplYWNRUGJudFZSOGdXU1ZEUjFY?=
 =?utf-8?B?S05PTUZRUkFOSFFNZUJieHVGSFlPN3dTdFRNOWpzejFCdGtXQ3ZjTjM3TDNO?=
 =?utf-8?B?V2x1a254L1lrOFdaOEFqTGc0ZVhHbmM4TDkveWhrRC8zUTBpRW5tTXBJeWJI?=
 =?utf-8?Q?Kzl64MemRxTf8LgH9Lo9zx+Qi94CZNw8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkswWEVuU0U4MGVFNWlieXBYRlNFN2NpYkdrOHFtNnBUVnBFMTN6ZXYzTUpU?=
 =?utf-8?B?L1k2YmpOdTVQOVdjRzRwTFFlN0RXbEVRRHlndWtSazRlVWJoVU9PWmJqVTRr?=
 =?utf-8?B?NTcxWGN6MFhYVVJwUW0rV0NuVy9uVlQ1Tit5U0VZS0J1ZDVpVmowYTV2TEZL?=
 =?utf-8?B?OVRoUzUzUllia1lVM3BlZmhQc2diTkxJMjdlZVZ0eXBtZTRaa2JQa3Z0anlp?=
 =?utf-8?B?cHF5bmFHekJwUUJMYk00RTZVc09jSWV4MjNLRzFQbGN0SDRpbGY1OWlhdzVi?=
 =?utf-8?B?SWtrU1p1MEVvYVI2VHJCeVNFUVdpRnVTdWZNa2R5UEhiRUU2WVdGR2VyNyts?=
 =?utf-8?B?ak5hbDk2QjlHWjUweGVjOTFCVDBHZzZhMkxiYmw4NFMrSTNrNVJLakV1OHpL?=
 =?utf-8?B?VENseStoTHc2VlhLemFpNUZvbE1UVldjcWJnYjFtYmJrMFNiYkRUdlg4WFJF?=
 =?utf-8?B?V3JUVkowL0ZNYTJoNGo4MFlBb1JaUVgrUDVOcXJTNk1TYmJsc0Z4Z1RsWVdw?=
 =?utf-8?B?TXNGT0VvcjR1L3NkSjAxQ0EzeE94c0x3OENHM3RrUkVDcGpaVHZkMFUvM2E3?=
 =?utf-8?B?eWgzekxsMDBiS1hQS1BlSk0xRmhabVIrTkp3VVo0Njh4Q2lCbnRUdU5XSWZZ?=
 =?utf-8?B?a3IwY3REWEhpQlAzT0JjNjc5NS94Q0VZV0JMK1UrcFA1Z2dUZzI4bDVtM3BK?=
 =?utf-8?B?bzZRdTJUSDNtbUZsOG9XTysyano3eEFyT3NwMFRBZWxzeThOUFpSQWNzbEwv?=
 =?utf-8?B?SkFPckZvSTlLTWdIME5kb1VJaS9CS3RCVkluelB0dXZKdlZoUzdqZHVlTHFD?=
 =?utf-8?B?VkxFd0FWVXBBcTlsTFNIWkdWNlFWdmJRSE9QSW82UnhNNjIrRkx4MEdIUEND?=
 =?utf-8?B?bWZaSllISnVlVnUrRDZZcE51b3U2NWhnMkxwUS96SWNnZWZJaXBpT2plU3dP?=
 =?utf-8?B?dTdaQk5GcVExOTc2TjJiZHB2MEMzdHRIeTRpa3NYNXJZRDhFOFhDSVAySUhG?=
 =?utf-8?B?SU9IbWNJdkVFZ0tOd0hZQ1ZmVGl5YWdSb3l3UEhRR1hYZ2J2ZDB4azJ4SXJK?=
 =?utf-8?B?eVFIRXJ2Y2p6bjBBeDNMZXJWVjlUZG1pc0NRYTVvWkNoM1QwUmFkZDNmNGly?=
 =?utf-8?B?Skh1bmNYM2xWV3NDZUpmZHNKR3FFOHBiZnU0RWhIdW55TkJZalZMdHBpRW40?=
 =?utf-8?B?ZVY0VTBHNGh2V1czSUUyalhvVlFHQ2hsMEhvc3pBdXhyaVNaTXFiSGxHQmNG?=
 =?utf-8?B?dG9RRmRNTi9VU3JUMGdFTGV0NWxWS1gzQ0FqUzVuNEFZbkFiL1Q5MkZ2L1g5?=
 =?utf-8?B?MVN0MDNHZS9hOE82WHlMeEE3Mk1GWnhycERYMm9UK1FJNmxDb3lQdWxOL25S?=
 =?utf-8?B?OUpnWEtPZS9tNEhuNENFaTE3cVVCMkx3YUduVm5ZWjhsbG9XZUIra29JWEhU?=
 =?utf-8?B?N2s5bVJOLzlGRkJWNEpSUWJMNkZVZm40bXZlODZ1U0NIK3R5WFIyZjJDSzFy?=
 =?utf-8?B?NFpqMWJTbC9vYmlPNWxuSUxpSnZ4czFVQzlsRXdITTgzNVhLSDZHcmhUeHFn?=
 =?utf-8?B?c0xFbE5LY25wMTVmWHBDMGV5ZHRoMWNVMC81V2xtcGM1TmR2bVBqR0VrLzlW?=
 =?utf-8?B?TUF1K2VXVDNvTWtyT1FTZjNubDhra1dKRUtVWWJ2NWZmRmNoT1pqelRtK3hI?=
 =?utf-8?B?NDJ0UU9tbjBxeWRUOXRFdHVqNzkrenFIbWd0NDFaZE4wMG9ObWoweFI3QTR3?=
 =?utf-8?B?WjNRZmFmZTdPV2Mvdm51UURWVHRPRkwxWXhxdnExZCtrVWd5TlFDaHpFMHBR?=
 =?utf-8?B?eE5OcmRaMVRvR2pISi93b3U4L3VmakdTQzZhdnVzK2lWRUo2Z0FCcGZRZzBH?=
 =?utf-8?B?SEdHUEZ2SGk3U0JlZXlmNTc5UXNJdU9LdXFZV0I1NGw3RzYzOHZYekdCemow?=
 =?utf-8?B?VlJVc1NKT3l1TjR5VUJTMmdCWGk0OTNheWFNeUVYcVFIVUJwTGNkTXNVeHBP?=
 =?utf-8?B?YnYrNjcwdmd5aHNvZVoySVI0YlJoNjd4WkNnMUN2SGpJVzQvMTBKcmtqeWFS?=
 =?utf-8?B?b2NGWkpObzgrZUtkMWtadUhqQk1vSllMSTl3aTV3WWFoc1A2SGcwOEljQ1pR?=
 =?utf-8?B?T2dBKzVCK21qSXNkK3VMemJscnlFZDZ4VHgxY3N0RnhSTDdnZEpXOHZuelAv?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 330b551e-9a13-4107-810e-08de0656b1b0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 10:37:35.3068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMAkPXVZgmltUrxw4yR+T1olksuKebNSv7XyaiGXw4iKteBSQXIi1ZKe6mUHX4TcIr76DVSzB7wU38lH3MuSKk+n1ilNAYErFyHvotL0xGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6915D992B
X-OriginatorOrg: intel.com

On Wed, Oct 08, 2025 at 11:22:26AM +0200, Maciej Fijalkowski wrote:
> On Tue, Oct 07, 2025 at 06:11:53PM -0700, Jakub Kicinski wrote:
> > On Tue, 7 Oct 2025 16:59:21 +0200 Maciej Fijalkowski wrote:
> > > > My thinking was that we should try to bake the rxq into "conversion"
> > > > APIs, draft diff below, very much unfinished and I'm probably missing
> > > > some cases but hopefully gets the point across:  
> > > 
> > > That is not related IMHO. The bugs being fixed have existing rxqs. It's
> > > just the mem type that needs to be correctly set per packet.
> > > 
> > > Plus we do *not* convert frame to buff here which was your initial (on
> > > point) comment WRT onstack rxqs. Traffic comes as skbs from peer's
> > > ndo_start_xmit(). What you're referring to is when source is xdp_frame (in
> > > veth case this is when ndo_xdp_xmit or XDP_TX is used).
> > 
> > I guess we're slipping into a philosophical discussion but I'd say 
> > that the problem is that rxq stores part of what is de facto xdp buff
> > state. It is evacuated into the xdp frame when frame is constructed,
> > as packet is detached from driver context. We need to reconstitute it
> > when we convert frame (skb, or anything else) back info an xdp buff.
> 
> So let us have mem type per xdp_buff then. Feels clunky anyways to change
> it on whole rxq on xdp_buff basis. Maybe then everyone will be happy?

...however would we be fine with taking a potential performance hit?

> 
> > 
> > xdp_convert_buff_to_frame() and xdp_convert_frame_to_buff() should be
> > a mirror image of each other, to put it more concisely.
> > 
> > > However the problem pointed out by AI (!) is something we should fix as
> > > for XDP_{TX,REDIRECT} xdp_rxq_info is overwritten and mem type update is
> > > lost.
> > 
> > > > +/* Initialize an xdp_buff from an skb.
> > > > + *
> > > > + * Note: if skb has frags skb_cow_data_for_xdp() must be called first,
> > > > + * or caller must otherwise guarantee that the frags come from a page pool
> > > > + */
> > > > +static inline
> > > > +void xdp_convert_skb_to_buff(const struct xdp_frame *frame,
> > > > +			     struct xdp_buff *xdp, struct xdp_rxq_info *rxq)  
> > > 
> > > I would expect to get skb as an input here
> > 
> > Joł. Don't nit pick my draft diff :D It's not meant as a working patch.
> 
> Polish sneaked in so this got really under your skin :D
> 
> > 

