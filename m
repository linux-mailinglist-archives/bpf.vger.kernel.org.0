Return-Path: <bpf+bounces-57555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710FDAACD23
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 20:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5E14A7385
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 18:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D7C2868A4;
	Tue,  6 May 2025 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CPAoDHDD"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9D8286884;
	Tue,  6 May 2025 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746555812; cv=fail; b=kFhQT60L85BD/al3O+2bek/ZLWYqreaEWU0IyGcI3aNBzEc7FYkuglNym8ebnptz2mdU6/FQxeEOUH6gqcdDtRt5dWtlm7zontKvGy5TCdJDTX15ETsevWfaUe9qBoeZd6JOPyAhWkd6I0DNRlq865Fkvt5444sSVgROi8eh99M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746555812; c=relaxed/simple;
	bh=yVwAjqZbZntE6o8MwhST33EneM00s+/2ZTGO6vQeLAM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P6EGCTrgAqF8MPW/DOqQ2tfwoZjIW0ShIqeblX/Zh2cyeyC25oOp6KN4Snfsqk3Z1NyZxfnsjAj93saXWdaC3tNmY47+OS47ijBHqgdEOrQlmRkb2wGognzyQlRU5glghP+rEDbe+j9Y42OYp0W53Az2CmVwfPtYlbz+ypjFCyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CPAoDHDD; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746555811; x=1778091811;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yVwAjqZbZntE6o8MwhST33EneM00s+/2ZTGO6vQeLAM=;
  b=CPAoDHDDWcfD+qxajNFA3FfL3FS0Ohhxp5Gw79eoPvD9TkLlEOQHSRE4
   Li4OSthzKyqqx6QuUufdsmYFGmz4tciEVVEIketaQTnDhWYBUheoxeAzs
   56gedYLP05ZgV9txyDa5m0obhoBdBmuBfmGl7XctfZfdRZpgaaQQgmM7r
   DKC7uREOJiaaOjx/oEI3pQ2gDqM6kHf7BaPD5JDgfaZX5KZZMF4kIVKUP
   IAS8dfgwpjd6eplY55gRmvl7kyUsu/0H/fKOCkZ9EwgeEMDbYRwFGa6wL
   A876RSYZuctlPoWdO2RpRnzkgQfj98fgy/a86mQX2wX7EvA2XAWumfx6k
   w==;
X-CSE-ConnectionGUID: uuXOr94QSpelTW0aQT6bGg==
X-CSE-MsgGUID: yQbrT0NVRCSKYFDVllROvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="35873126"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="35873126"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:23:30 -0700
X-CSE-ConnectionGUID: Coe6CdF8RGK5F8AjXkP+Jw==
X-CSE-MsgGUID: uNIFhEw6SwmnSXSQbitjCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="166629173"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:23:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 11:23:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 11:23:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 11:23:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjjZFSAzTH6jQNRAvsd4FIPD/DuthVLLa5Dx6mUCuDZebFctiqAwfLaHxt2Yu7FbVJaWci4PwfAh+k7Tl8le/tqGV2hZOadKjz7HB0cuhCjE1qkp0DHFFacxyj4OfaO8fuCbiElsYj+Hh775hEGY9QezHcZGEiQqokVWoOYC1zrOLdB9W9Fd4+G5PaN8N4bJZE7guBYtmPJeVPkvRwUT765Qx8M9Tafmc/WdHXxgmZvLOWVLgPDHqytIe2Re5B0so+foR0dVzoDfd5eZqJZv+QeDNjQrQC3glyrYkQctWIIAaWgjWDIQVNm9QLg32Q15BM2NJr15GEdSN8gdM10Nxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdXPtpok+5oIf31eXxzR+63jXa3M8WoP8W/Fv5j+Ulc=;
 b=JBFJMEurO7e9VhSXYy98sCPmNuaxWlmD5HBwmQMA5frvQSlA9E5DEdCtHnr8Aq7/0mIl3EqSfuxjPNYZw03weX1GxxOw1SH4PlhEYCV1qipsWDP9iq+gi7tQLZl+SrEboWw/ydm7c/S9ybs0sW2SFbMcr+s3zd+chCsdKtEEP3AnNGyFJ86h/Q1HFOFkMca9zvcRITfuHUu1wIMCgKTzbMsF/0UlgaeBHecVUvcRx4leKVg3NQufMsHSdypt43saIAqau+WWRh+TFMu5Fq35ZB9FZhVCjeWe4EMcAto6KKEOUJ86dxTrLocwjPUhr1vTbyzPK2SVb67N07fl8Z9VEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL3PR11MB6386.namprd11.prod.outlook.com (2603:10b6:208:3b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Tue, 6 May
 2025 18:22:38 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 18:22:38 +0000
Message-ID: <bbd00914-b17c-4f96-b204-21c9bf95158b@intel.com>
Date: Tue, 6 May 2025 11:22:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/3] net: ti: icssg-prueth: Report BQL before
 sending XDP packets
To: Meghana Malladi <m-malladi@ti.com>, <namcao@linutronix.de>,
	<horms@kernel.org>, <john.fastabend@gmail.com>, <hawk@kernel.org>,
	<daniel@iogearbox.net>, <ast@kernel.org>, <pabeni@redhat.com>,
	<kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
	<andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250506110546.4065715-1-m-malladi@ti.com>
 <20250506110546.4065715-4-m-malladi@ti.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250506110546.4065715-4-m-malladi@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:303:b7::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL3PR11MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb0e754-6343-47e8-586e-08dd8ccafaf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXRTS0phTjVwWEw2STRVY1RHb3VQMU54eXVIaXQ5a01qYmovcEkxWWh2ZmY4?=
 =?utf-8?B?dUlwWld1Nkt3TDJzc2FSZEJEMENlcGM0ME1DUHU4OTFtcDRLc2R3Y1pySGVG?=
 =?utf-8?B?eXZ5aFM4d09Xb1BEdVI3ZXBJSlZhN2VkYUhvd3RuRUlVVXFLeURPeklrMk9E?=
 =?utf-8?B?b2ZFbU1kTEZodWh5TlhmTEgrVHZIc0orRUhUdFJzOFB3MEZEN1VVNGRTVUpm?=
 =?utf-8?B?MnIza2NPVVd2ZC96T2dNeStSbURURXdTREpHN091NnlxVDl2SHZsQU1GUnpM?=
 =?utf-8?B?dDExa3BCR1VUbHA5NENrcEJWWWlqVElDR0R3dlRPRmRoZGRLZnhpeDJpN0o5?=
 =?utf-8?B?THQ0SzVMV2RMbW5tazQvcnYyelZkRXJTUmZWM3JCb29jVjlUQlpIQnEvZGlR?=
 =?utf-8?B?OGU5QnZ0MHdONWp1UU9SUlN0bU80TEV6cUpmVmd4ZHNUZWs1bDk5YUdTOVVN?=
 =?utf-8?B?c3NCNXhjdGduTFdRWVJaR3dMR1VHNXlISkFIa09aSE1XTVVOeUJ4OWNGeXdl?=
 =?utf-8?B?Sk92azlDTThlU25NR2ZpOFhqeFZoNDRmNGo5VWpPMmlQa0paR2pVaFZGQzlv?=
 =?utf-8?B?NjNWVU53eE9KemZSUUxoeHdiVmxRZFhiOElDMG1ESkNHUlA1RkRoOFdlZmlF?=
 =?utf-8?B?bHJQQ0RHU1RQVHdTZG1hKzgxRlhXNEt1cHBFa0syRlc1T2hwQTJKd1pkVm5F?=
 =?utf-8?B?aG5BeENrYkVNYytpbjZTZ2poK25CNjZqR2pWN1A2bEYvR2NablRHdDVzVDd6?=
 =?utf-8?B?V2s3R3lmQXlMaVVhYjdXUE9hN1hRV0kzN0xRSndVcitKUm1GaWZZdTlkZ0NN?=
 =?utf-8?B?ZDVZNGRzQXdGUnFFNUtYYStTZmQrVlNNVGhPVXRoVXNTcFRQaTBNQjZCRmhy?=
 =?utf-8?B?eUZWRm53Y2VhNmdQS0xnSU50MjZyb29VT004NHRyK2VjYXJrdU9UNzQyN1Jk?=
 =?utf-8?B?Q0RWYnVHQUVMbHdNZktBUnQyQVRPcUZRNDlJQkNNa0xqUFB0NHNYQ0JISFEz?=
 =?utf-8?B?NjNMTlBpM1NEOXQ1bno2L2czUGE3bnVDVTdBN09PdUxPaENaTW1qM0JySnU4?=
 =?utf-8?B?ajFWSDdrQkRhYWVCTm0rMnFEd0RvOUFGVTJiZGNGd2ZpQTdHSU85Mk96U1Jm?=
 =?utf-8?B?WThJMTMrblNKUkxiWnVhazVMY1djdjR3TUphd21mRkxQM2FUOVY1OHA2T09Z?=
 =?utf-8?B?VTlLQmNkMjBqLytFVDZtd0JDNTJxa1lSZ1J5SDJtbmllZEJjeFBudUYxcUln?=
 =?utf-8?B?WWdLL1QvSHp2dE1XWm5mV204RURHbFpLckh1L2NUNzRWK3QwMDM5Y1hiMkN4?=
 =?utf-8?B?NFp6QVp3NDVONzZDTTQ4QmYvaWVXZDFwbVlSNnROZ3ZXaFBEZ1M5Vkh5YVN2?=
 =?utf-8?B?Mmx0NjdpRXNiSXBmVDNiNVl3WndhS284RXQyN1RqOTFNWHI3MWJpL0haZlZy?=
 =?utf-8?B?Z3YzaXJGNHh3d0orTjV5Ylo0VDQzeHV3T2RHa2hFQi9Va3Fpd3A5WmV3SlN3?=
 =?utf-8?B?aEtWL1JiY056V2lVYThia2lQRlpCUkk2UjlFZW1YdEpFVmgyRGoyWEh5bjRL?=
 =?utf-8?B?aGZYWHZ5L3U0cGVTZmMwRkxFdmtsbm5Bc3JGSmhyNU51Vy9hOWJwVFcvT01F?=
 =?utf-8?B?eHdKWm5YOWJDUlE3RVVjckdOTHRLK21Vd2Y0ck5kcTBFRU8xOFNDMU1ZekJj?=
 =?utf-8?B?SWVId0dNUVl1Y21DT1dJcUxuSkpSZFdCd2k1Y2RlVlRqaHlDc0tpNWNVNFlK?=
 =?utf-8?B?Zy9NcFhlMFozVVhwS2orTnU0eXVlaDBDZXZNNUoyMTFCUHZrWlNjdXZnL0Rm?=
 =?utf-8?B?bExudWpiOGIwWmpTRThGZEs3ekQva3BRMlUybGNRVThEaGI2NGNEVDZpSlRH?=
 =?utf-8?B?WHFWZTlOejZTaUVsOWI3aU1yV0dHVnJYUUpWdkZMMFRQNVBId2lwMGRwYS9y?=
 =?utf-8?B?YjlZMlNKbkppa0U3bGIxYzFBM3Q1a2ZhOFEwejZHTytERTlEUzVLUkVjNmpD?=
 =?utf-8?B?YUJyNlRVTW1RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0wrWVpTRmFZRExCNTRTWkI2UWphbHFMcmRYN0c3WDk0enM0bEh5UkkrVTFN?=
 =?utf-8?B?UWZVNmpOTDlqYkpnc0Y2ZjhXU1RwUUhPbkV0bkFUTmpEZTRsL3FsRml0eUxH?=
 =?utf-8?B?eE1hbURNUDl1SE9uY0pZalF5UHNYOTJ6MEltdDRsaWxtT3V4ZWY0akZHODVl?=
 =?utf-8?B?dkJUQytjZWJOM2VLRjN6TkpxSlRKUnVHMmNJRlVnMHlKek1hb05xaWhxREVy?=
 =?utf-8?B?MEh5dDIyNzNOc3d4ejZPZDk2bzh1T0FuZVgxY04xWWVXMHRiY0FmMDdid3dH?=
 =?utf-8?B?NEdEdFR6ZXdDTzUvZnNDK015UzJRQzVmdWRWUTlvR0h2K0RmTnh2bUl6QWZx?=
 =?utf-8?B?VnNhN29zVTd6TDJtNCtOczFmNnpoeGZaQW1YUUpWTjM0VVE1TWtKbHcxMy8z?=
 =?utf-8?B?YXR6NFpEbEhYdDJkUlF0UU1QeFBhZ3psS1A3emZwSUdzdUZnWkUySWxmVHpk?=
 =?utf-8?B?ZmxoSGFCMTRod2NiV1htdkRsS2JHRFZhallXM0NSdERyK1NTTUN0U3hrWGFI?=
 =?utf-8?B?M08vbTJ0M3lORkNpTjlrblhwZmx0TG1LeWpLSkpFa3lmYVJYOEdqT2xTaFFN?=
 =?utf-8?B?bWhrUmNmWGNnY0FEYVBnYzhobmpTZkh5YTJQcGdXalk0TURJMVo0aFhoK1J5?=
 =?utf-8?B?dTVQSW9IYVJxVXphaWRQRThvVWFORDVCR1ZiTUxZdmN6bFc4RGlyL0hLYUhK?=
 =?utf-8?B?ZzdTellOWXh5MDJJN3VwbTdrNE0xRnkwQUZHczlEUmZVRndUTG03d0pFalND?=
 =?utf-8?B?eVhMV2lUVy93WWJXTER2cno4MDNUZ2hkTDFHL3ZnNnNhc2FTajNIRVkzcE90?=
 =?utf-8?B?cWplS1JZUWdTUVdNQmZPclk5aCtOQ1JNYzZHUjRPY1hyNkFwY0d4cE5oVlhh?=
 =?utf-8?B?YVI4dlMzdnF0bnFlNDFqYzRuRXM5WHRzOFRPRDRSNEw1Mi9uQ0VFMEZaaDlQ?=
 =?utf-8?B?VWxQNit6TDJBd245aFlpM3Vqck8ydXBvdTZOcWljaDl5SWt3ZS95RW1ndjVV?=
 =?utf-8?B?Q1FkZ2NCdi8yMkZDRE1rcU9Wa0Z2MXhMdjJOTExnbUxHNlFOa0dLQURkSElV?=
 =?utf-8?B?NGtqZ2Z1aVpOYWx6a2xuZWNnUmpaMTdwWFJXczdTZTVTQzFvc1FjWmdmcjRk?=
 =?utf-8?B?c1ppNGpTT3Nzc09rNXhNc2pIWHdtaDN2Q21qN3dXUzc2QW1PRm5nTUtWNWNq?=
 =?utf-8?B?Wm5ma0dhdHozb3dRNjRwck9mSEdoUWlwaU9lK3lkL2Z3ZHRIdnphUVRlQ1Bq?=
 =?utf-8?B?Q2IyeVRLMGpoMmZrNEoyU0RsbWNuTzFtZUpEU0pjUGhtb0ZOenNLbmxLR3FZ?=
 =?utf-8?B?bVRnUnk0OGxOTS9WSWZhOVVKZHhxN0VJU09acnlhcEJnd1AzL1N1OU95dVB1?=
 =?utf-8?B?UjBwZUhDVUprOTVlSWRxdk00dnJTTFZVRGRsZUI4UDJsbFBHSUJnTW9UeHpS?=
 =?utf-8?B?NW8yWTlYanpZbDlvYUI0ZnA2KzRFMHI3OFhnUGlzN0N1ODBHc2VqMzZIbndl?=
 =?utf-8?B?VFY1c2dFR2M5NzJ4S1RmdGlEb2huc1lLbWNmQUJuWjNLbjFRN3I1c2MxWklV?=
 =?utf-8?B?ZmtYdUhsVGxKY3ZsYUxRMzA5Y1FTUm5odmdVcmtnSmpPT3NOYmhHcFRkd0dE?=
 =?utf-8?B?WG1VTC9wSHh0STJJcmJHaEYxbDlVM3lSVXlYYWp6clFUb2hkdVZyTWZqbG9B?=
 =?utf-8?B?cDBPZ1F3NW9UVDJIMk5tb2hOSFRwc0VXNStpTzdpNGZMWHZOc1FVcjZRTDNv?=
 =?utf-8?B?YTd1bTlCdi9EUkpYTjVnNjBYZldTRzFsOVZ4MUtuVUQyYmF5Ym8zMElvaXJF?=
 =?utf-8?B?TzQ4WFFPdlFsempiYzhLMWY0YU96YTRycHRzNDBUYVJmK2ZBY1VVNDRObXpy?=
 =?utf-8?B?cW92TW8ydlJSVzFjcWUzaG5sMWxZbnQya3pWUWcyYmg2QjNKem8xL0sybWRi?=
 =?utf-8?B?MDBFOFdKamszeUNqUENlSHdodTJsYzNHN2t3bzh4U01tRWZXSTBTNnZpckVy?=
 =?utf-8?B?U0Nvai92cjkyWTdJcHRLY2tjWUg3TzFFdEdubU9rWlp3RjlTa251UTFaWG95?=
 =?utf-8?B?VGhCbkFvbUxzdVJ6MW5HbWEvcnBRcUMrNVpsZW5HTDR3Zms4b0Riem5yNTA2?=
 =?utf-8?B?ZHNXTFRHM0ZKR1FVcXRhZ1VSR1VXSXpKQzlQZ0xMSTE3VkN1blJxRGpqVUFp?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb0e754-6343-47e8-586e-08dd8ccafaf0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:22:37.9420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUb00LkP/0tirNDq7yovb2ZZjClFD1mPkV24/46c7ktYvxQgF/j6VzwxVt/BOAfAKw87Kwdn1UT8UZke1kfz6CGN19S7I8MxUz4FOYOjFF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6386
X-OriginatorOrg: intel.com



On 5/6/2025 4:05 AM, Meghana Malladi wrote:
> When sending out any kind of traffic, it is essential that the driver
> keeps reporting BQL of the number of bytes that have been sent so that
> BQL can track the amount of data in the queue and prevents it from
> overflowing. If BQL is not reported, the driver may continue sending
> packets even when the queue is full, leading to packet loss, congestion
> and decreased network performance. Currently this is missing in
> emac_xmit_xdp_frame() and this patch fixes it.
> 
> Fixes: 62aa3246f462 ("net: ti: icssg-prueth: Add XDP support")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
> 
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

