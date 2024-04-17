Return-Path: <bpf+bounces-27036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C121B8A81F1
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 13:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3BFA1C20C0A
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 11:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C0413C9AD;
	Wed, 17 Apr 2024 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kLY1gB4E"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EB313C688;
	Wed, 17 Apr 2024 11:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352802; cv=fail; b=coq/giKvDjlpuRPfcu5xcrPj6GSwe9emaW1i+TAgeny2mTnlnIOG0zMMZCOnJckCwaCL5y1eBh3WPUfE+axonEwpdjgsUPfnkyEFvJLopCFC8rxD75H9VIp8XLLl8WyEQXlUkuKfuJzbUK9ghOF98tdDPYEao35PeEWFfelhde0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352802; c=relaxed/simple;
	bh=mbE7t7Vdct0OK9ENrs75LkNaLW80Fgs3+9C8FQ1U9DI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=COc08LQl3+dc+cfgzTUIQD1KsU1n9TZHRifq1ztT0zXliAA1GfbaL8PwRShUifOuUc//9+7ApZlrOvKCOmSb1ZpOJja1auusgadcEqgkHbByVVrRWTzxl1z5vDHgSKGKe4WhuylVW/nowJaC4GXLlK2khFIjFdZatMp5rp56ZWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kLY1gB4E; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713352801; x=1744888801;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mbE7t7Vdct0OK9ENrs75LkNaLW80Fgs3+9C8FQ1U9DI=;
  b=kLY1gB4E2QuFWqxXY+6zLpbdTSngLG3w92p9TbKPC82421bqWtuVlicx
   50whqcK7OX5U7xYbG5ttRycYJqQbTbYqXXkKakQmEiCKGt6DGWmFgdb2l
   s1mxkVkKjmAePgUV7ixsaJus+mha+PZ+ul9yistci/vDPuekQxe8N9Re8
   tTkt3SF0cN6tzpHUbOwZBnBoCY8caeixpTHLbaaeVOG3Q9cvk9AVxOCFn
   QOoMeuTaqHCFUtbjbN8g2oaknnCWsFOvoDyG6zE4gbMd0qBUfPeoHWDau
   4mFpxBwXm8rgp+2H7U7SbQaDIhV5yzmiTxmk4xg0001oRaM7qlccDj/3Z
   w==;
X-CSE-ConnectionGUID: nYuaD+VkQsmcfUDTIttXZw==
X-CSE-MsgGUID: JTbHFggjR0WXQFc41pnG6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12622231"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="12622231"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 04:19:17 -0700
X-CSE-ConnectionGUID: vGXt9ejqTnmjOOsBTk4QDg==
X-CSE-MsgGUID: 0KAmsj/+Qe2dgtTm2y+vyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="53544596"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 04:19:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 04:19:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 04:19:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 04:19:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nt8FW8PLh/jka9mcK3/kbBnm+VEmRG/G9gCC8Rdcyb0IKAwDtjZ4Ll1Ve9xPGmIeQKa5z5tpnm4li9Y856pVsQDtBn9Zvsg9oumt2juHwGM6PDUpm1sI70q9O6TBW7ADRBAXNgjaL6k9fvpUt1VE5o5qJHKZjSYNUgejwbI4WPLJP5QwKaY0y2W1fJTrlFBj9srtBj3B/m283HYDj0zyLo5OMhwk9sYDuUQij/AdBRPZ9PZTWAti/s/b9vC216swy5PzblrLJNR+A9GdR2s0YRE8dyZNWDHmwOCWi4k8dKPjFFJu+kaUNl8WLJ+SxiHTZvqncN5VRm6u0UcgO6RTFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12qw92P+ehRKXuD7DKx5NDPUrqqCZSP9T48NEs2j/4g=;
 b=fRD52oXXK/7mSZr8QuhZwgGBTlDYOAQ7SkQaM5dFloiB4FWVHdlsPJxfZve7MUcH8/vCS3syMymtdYVabp2lgOenVoAwhEMEPLzmZLh5wWlp7c4viqaVY69g4S+za9fdgHj02eFq7MquhDv5O1GG9CwWcq/J3NCVzJNnFfbJLtK521JxsYN2CJUpQMHT1h6o8LNdDST9GqFUaJQYB0f7PDTim25HqBSXy9/xSs2GgTDgzUgTiXa66UjWp2JoOGY/BWQu3NCtz9xGDP9YKVEBnuDbPg6w3AF6o4Mkj/OgcK6Tfmd3RDA8ZeIlJJ+ahGyos38z/5uw9ZQuejhmYcf3xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB5796.namprd11.prod.outlook.com (2603:10b6:510:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 11:19:15 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7472.027; Wed, 17 Apr 2024
 11:19:15 +0000
Message-ID: <d4991f11-a527-429d-b71f-d4ca3a18f501@intel.com>
Date: Wed, 17 Apr 2024 13:19:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 03/10] net: create a dummy net_device
 allocator
To: Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski
	<kuba@kernel.org>, Breno Leitao <leitao@debian.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<elder@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <nbd@nbd.name>,
	<sean.wang@mediatek.com>, <Mark-MC.Lee@mediatek.com>, <lorenzo@kernel.org>,
	<taras.chornyi@plvision.eu>, <ath11k@lists.infradead.org>,
	<ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
	<geomatsi@gmail.com>, <kvalo@kernel.org>, <quic_jjohnson@quicinc.com>,
	<leon@kernel.org>, <dennis.dalessandro@cornelisnetworks.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <idosch@idosch.org>, Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
References: <20240411135952.1096696-1-leitao@debian.org>
 <20240411135952.1096696-4-leitao@debian.org>
 <20240412191626.2e9bfb4a@kernel.org>
 <ebe80c29-4884-488d-ab83-c020f9c3bc81@intel.com>
 <e0d5741ee053c11fe078fc8afe6cf4a92e274095.camel@sipsolutions.net>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <e0d5741ee053c11fe078fc8afe6cf4a92e274095.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0001.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::8)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: 609aa0a5-3855-47e5-1709-08dc5ed036c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Awf46Ez1vT7UOAHRKgIzivW8Hk1Fd+bjpS3a6FGZv1cFjlGne/PQNfiTyhs0X8Rgr0sgtU1fAXlrtbpkRclS5DfaKOaoS98BZUpIMe9+qEDfm2+J7W84MxoHSywhZXMYi+4vMW+XA8XUOP4WTDtkxlGUj9nvzu26QHXpuNEGzCPaoGRHM87GdV5PwYO9wo78/0ncqRBWt2/QaQOSW5Oy4Nk9kfw3J9T0x5VLfoJhdvQ1vtcKZaE5/FcmpGZ/Ye/KdgeQjsv4hlWDbfpqvzm3sz+gGLRPtqgNy6hCVx+GO6RUHotxPT5ih3UJcoDaXXoNvvSQVxXUHIWRdCOuhnV+XS6T/WH0OI6dq1343JgZRJQPpuc/BOOD+Ta0EZnVtzTjbTRMkwVu3QDlyM1KoBmPGSIAYUTPYYejLReI67sFAbu38E3FYXp+rbHL8+oY+oGkG6bDNN0onwbfCKIXt9ecX0yEJgnDsrmT7345ano5WLZBdW8Hz5cIIw6QYmWseOomY77P+MioaUMAPzpyvAWSm7ogjR8hzA+dr+qq90VVHXhHaac929b/x/R4/JGhtztrv2kyyoGgK3UwTQ2rvUpGmxf+PUecqdQkQADdLnfXloUAhGO6KwW3phC7OVMWnGapT53GlkvB/HUf5vLAXo7QPS7+wZtrOdz1NzcUSMBYEA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akIvZmNDRElYc1VuL1RqZk55UlVRL2NZS2M1aFF1enh6WVZvMk13ZWNnLzZl?=
 =?utf-8?B?eDd4bU5IbU1YbnlCTTl4dE5xLytLUmZvZ0JhQkY0c2tNTmlEVW9yNW9zYnBM?=
 =?utf-8?B?NDZ5ZllmdlVwRDB1TEIxK2JRd1EycVU3Q0FXMEhwMEl3OTkrVnh5Tm91d3do?=
 =?utf-8?B?SnZUQ0ptcWFybmhyOWpvZFdqYWhQRkR1NU5VZ3N0bzRoMTFIWDlsWktBRDhz?=
 =?utf-8?B?REZTYXNiZlMrOUM5bElXTjNmQ2ZoWkkvaHQ5M0FOcS9BdldTeVl6VXFCVGg4?=
 =?utf-8?B?VGZCWWNRdGNkVEZsNWt5TTErRzd1SjVVVTR1STlUbFlvQ2htQWhsRVlwYVpv?=
 =?utf-8?B?NlNqRXpYc29aaWVraFJxRXhsUThHWndPKysvQ1JNSkFLWGdxd2VWdktsZGRi?=
 =?utf-8?B?WFlIamZRb09VVy9tanJaV3BsZWZGSTFocVlKanNKWkc5SFg1R2RXUW1EWDMr?=
 =?utf-8?B?M2dVUWJHdERocVJnRVNtbEQwNTlwZTlGQkFZOEVYZXJRMjRFK0c1N2xKdTN4?=
 =?utf-8?B?amlnV2thMjVueHZPbWxpREdzZFQyeDdzZUx6cCtGR3orb1hIa3h5dWNBeGRs?=
 =?utf-8?B?V2MrRExFbDREU3pEZWxPdTh3UEJNcC82YUhIYkN2UHNwSXF4NGZ0TDJ3SUNk?=
 =?utf-8?B?WGdXelU1azVmbk1pbk9zTUMzeHZLd08wUVhTVFBjNjA4bGkrNzYxMDZseWZw?=
 =?utf-8?B?LzFEYlNuTDlvdzZCRXVEcUhYejhuRE5kQWJGblc3cThxMS9WVVE3RHdvd0tx?=
 =?utf-8?B?SWhUQWsyOUdYQ2dxbGxXVG1ETXcra2NpNW4xcEtXdnFocXZuV3U2cVYvZmdX?=
 =?utf-8?B?eWVKRzhGZ1Q3bERaMEE4QmFNd2Y2b1NYSHVmclF3TnJLVXV1Y3UwcStnRE05?=
 =?utf-8?B?bkhQWDR5UUZUaHd6Mi9RTnAySG9pWm83dmpzbUpkN1NpV3lTV1lCWjlSOGdi?=
 =?utf-8?B?TFcxVGZzUHd5OXFDMVJyRmJKSkthNWsxT3FERmJXakthalRrWnJtNjN1cC82?=
 =?utf-8?B?cFdYMmVOWHhUK1c5dXdvdjJvMy8ybktoaEdQYjlCd2p0OUNNR2hXcCthWExv?=
 =?utf-8?B?emRvZGtldnhzZFRzd21rcjg5KzYvM3p1SFRoTHVqaHpMZ1E4NExzV1U5dURN?=
 =?utf-8?B?cURzT2dneUZmL09qWlF3R2FXNnVDTUpoUEZpcDlhODNid1hsWllOR2p1Rzkv?=
 =?utf-8?B?N1U4cERQbkgrVCtvU09nV0pFZU5vRDNqTlpwWDlmbXVXZGprakRVK2ZCNy9v?=
 =?utf-8?B?V1BVR1pzWTdhTk5RMjhhUWQwM2h1UnhCVXFacm5OSWlUeFRPbEdXamNraHJh?=
 =?utf-8?B?YnJnZUpUbHZCemlrS0IwczVZcmhVUm9aYXRwdjJOeXY2VzZqUGpOb3RwYkUr?=
 =?utf-8?B?TkdXcEkrN3owSjZjZXJQNjNOWFZRTnFFTm8yMk5nTlFhcmlVT1gweVRLZC9v?=
 =?utf-8?B?d0VVSkZITVI0SDJzb0RkVjd6c2k1M0lGRGR0NEladkxqOW1jTVlaY29rRGE2?=
 =?utf-8?B?T3BhTmR0TlEwSklBbXBjdkM1WW16UXVBRmFTUkl4OTg5RGtrV2JrSTk4MlE5?=
 =?utf-8?B?RUdGY3M2aFBEdmlWbnFtazNDdWNvaW5MOXBKcmZTYlhOR29uRG9MMjhpSlVa?=
 =?utf-8?B?K0NCOHhxREw4VDNWOWQwYk1Ic1p3a1h4ZDR3RmRVc0RCeExVSmtkcjRiZVQ1?=
 =?utf-8?B?WThlOVo2Z2V5Zi9JRW9RZjBWU2ZDZlhnRHgxR3dNc1dzWFROdTNqTlM1WURk?=
 =?utf-8?B?Y3pycFhFS3BCLzgyWTBhVFVueEpFb2hSbi8yWkI0NTNlVmhMUHBRTHRPV1ll?=
 =?utf-8?B?Q0RnaExvWVlGbDRLZDNzSkFTV2Z5V3ZDc2Y1MlUrSGFlamthb0ZkWEU2UUZU?=
 =?utf-8?B?L1gwbU5UMmdQU0x2RkQ3Vml4eHp6cks1dFFOMmRxUzZYNm1qMCthYWF0TUpH?=
 =?utf-8?B?YlU0YUFqM2dUYmxIVnlUUHZybmdxZXBMejhUNVJhQUtQTStWSUJGNUY2cytP?=
 =?utf-8?B?QW5JbUxZdjhKcnhGMC9CcmRYNDhLa2tPSlZwSy85em9sb0pNZ1ZTOXFOQVhk?=
 =?utf-8?B?U1hMMXd6eStGVlp3RDJvMmpycHAwdHlrWnVINGpEdTdsUFR2aGNEdkw1eUtu?=
 =?utf-8?B?d3I4ejNBWkJwN011SUJPZUZidUMwRkI5d1MrcEMyRUI0Q3lpd2RqNlBsUTVo?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 609aa0a5-3855-47e5-1709-08dc5ed036c2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 11:19:14.9519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ho/rNch7z9JcYur1XY9KZUlS2nSeZLLJTSNjn5CJfPmukc1x5tm1EKHd7i3LUcgH4OioA6FwRc1AzvkxfA72padJMSqzNeX5hs9OI58hS7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5796
X-OriginatorOrg: intel.com

From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 17 Apr 2024 13:11:38 +0200

> On Wed, 2024-04-17 at 12:51 +0200, Alexander Lobakin wrote:
>> Just FYI: kdoc accepts only this pattern:
>>
>>  * @last_param: blah
>>  *
>>  * Return: blah
>>
>> NOT
>>
>>  * Returns: blah
> 
> Actually, it does accept that, the regex is "returns?". It's just

Hmm, I was sure I had warnings on "Returns:"... Not sure now.

> documented only as "Return" . IMHO it sometimes reads nicer as "Returns"
> depending on how you phrase it, but ...
> 
> johannes

Thanks,
Olek

