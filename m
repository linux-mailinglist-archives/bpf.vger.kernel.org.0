Return-Path: <bpf+bounces-36057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8443F940EA8
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 12:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E9E1F266F6
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 10:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28443197A89;
	Tue, 30 Jul 2024 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qwc9bgXI"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44350194AC7;
	Tue, 30 Jul 2024 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722334135; cv=fail; b=d0V05vdjeE1be7SLD0uzzRu6K1eoLahj/HIsi9CvwQr9PNTOye0yMuTi4M3APenfV+ug6ngOXKSkl7EOKmuldaKh57NImJ1W8sA0jOFTtb+NDNmRcBmgPFQtsBj6jzZe7tyZEqpe1fp1JY6E+zokG+iO1Hdta9x0oOAOZdRtHLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722334135; c=relaxed/simple;
	bh=EujEODf4z3n1vC1JWOUH2h134M7FoI9+HLTFCUAbRIY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cZa6AHxk3lkHfz2Cnv05YbcqGSUDTspSIoMW4KjZgrDTm8k8d/Uzg56PCRPLQZiydn6vSBlHFMnP/lIr7mU1uTV9QoFy7Rqo9RbuvJqWKVqhVyaN4gV3dCLjmLgeNrCUkj/1mvBzUUtGbPsBYmQeSlEJBp5QHICzxf8ESlmDr6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qwc9bgXI; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722334133; x=1753870133;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EujEODf4z3n1vC1JWOUH2h134M7FoI9+HLTFCUAbRIY=;
  b=Qwc9bgXISr+MxKRlI3XX0ayp0kle91Hz2btOwcKAkH1aQsvSGTmamCG2
   dTHzfsRZj9Bou7E+jm8h4P9Nlcpznxy05IY9Gj7oEh+PUn86+ztk5Gt5K
   1Mr6869mToBROUdXaD10EC9tq7u4I7mCkU0jiDVV/fKclY+5s1PJHDsOP
   w0FL3UA+/WMT7exorI3Kmh+voIHuF+VHXNRphuzav+vHiOC901BFMMIl9
   EhstBkTzddCNhEwZY5OObBZez7rMH9rxc/+JRPJcTZC9yvChmCOaxivM1
   YrqhPXIpVcLICjxnMscWxPbuydTHMCd5pKvpnZvYduNy6vFqZPbkhIaMm
   g==;
X-CSE-ConnectionGUID: RFhKlIaORNWtIDytqFL46g==
X-CSE-MsgGUID: pTcjguJNRky1Tm5tQssuww==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31286639"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="31286639"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 03:08:52 -0700
X-CSE-ConnectionGUID: gkQfb9K6SbyIEIf8j2DS9g==
X-CSE-MsgGUID: FTWGjyulR5CflHZ6Gtya6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="54208308"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 03:08:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 03:08:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 03:08:51 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 03:08:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqM0TNqPZVnzuQfUwr53kb+XOH0XEScH81rhGeS8lgSulP79IXihLR2hCuhquaViWMa935/3aNmlZzw7DBWFcobpnDPsV9v6N4WhfI2i7ASxhpDJGL4U1Tl8Ixm1+ZQ+VH8RlNpTqy2gVrdM7lOv2cy4gYqNTU3UgRZ5sTgQgaiOv8g5VzkbjioLwuMRmG+HxT3/t8wXYLPvFu0BNFLsFiZpadm3EktCCpy8PRUM+xw09T5gch9gQf8IcHyc+xsiVdgYu1Q791PK2MwVn0kE2gIac2TJIX09kuTflMQmr1mfCAdGQOZu8XlCUbFemQAsgh0/0oXCccw7PBliuyRpLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHY/cgubE74mHxZeXsQk47cuxmfhixMaSCLGQTTr7lI=;
 b=R/iKXBXzCe0mg1R7l8YK/JC8P5u/S2mdMlPrq0xx8yaILrjwuGiU+xThWZoR8s2/YvWrRHZQRZ8OvyLgM4AO0Xc2cm0iy/NPXLf4cE6i1EuvGWXLucGD29qZZ21chyfKFBiLSsaHYmfKg+sBFMBdH8FxqZwZpVlpuySxiUc260kmwd18zEEvvXtDz7XhWqd2ifh3i4ybpJu8PtrlH2HqRUyh8WuRYrSYaQHeZ+jSgrrnPoDjRQ76HR5uVzG60bRLvEynRJcajsYnHFLrW6Iz2KfUk5VkFN2OYDGord7EfD18VYpqh6xFcNV979P0S3TI5voh4cspC5fRANPQFIRxGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 10:08:43 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 10:08:43 +0000
Message-ID: <171a20b4-0e52-4ddd-a5a5-6f3f3f1d32b0@intel.com>
Date: Tue, 30 Jul 2024 12:08:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next,v1 2/3] igc: Add default Rx queue configuration
 via sysfs
To: Song Yoong Siang <yoong.siang.song@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, "Shinas Rasheed" <srasheed@marvell.com>,
	Kevin Tian <kevin.tian@intel.com>, "Brett Creeley" <brett.creeley@amd.com>,
	Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>, Joshua Hay
	<joshua.a.hay@intel.com>, "Sasha Neftin" <sasha.neftin@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
References: <20240730012312.775893-1-yoong.siang.song@intel.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240730012312.775893-1-yoong.siang.song@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0262.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::16) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|CO1PR11MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f60be0c-c23b-4719-97ba-08dcb07f97ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3hFcXNnakkwRGQ4Q1F1UURiRGZqdmRuY3VITFJiTDZQaTlmSDZsVjd2ZmQz?=
 =?utf-8?B?S0VlS3d5VDZyUWxFcVJUWjdWVFE5UnJkS2NmNnNmL3BaTURvZ210ZTdZNzNu?=
 =?utf-8?B?S05XLy80Z2x6aW1TMXVLVFFldVNjWVYrOW5rdVpBQk5aazhHMGdma2JpVUJl?=
 =?utf-8?B?Ylp6TGJiQkNSMHBNcFhYdms0M1VBU2F4YjZFVWNkcUtnU201M2ZtUTRuejdk?=
 =?utf-8?B?MWxjS1FrU2VKU3czQWxkOTdvSTFDcEJGS2FUQUxwWjNSTlNYbllZUEZ0MWt0?=
 =?utf-8?B?M0NiRmtKOW1yVXhESFpLdDhBQWkvVGZMdFZVZytVWjF0LzM0U3RqN01hTVNq?=
 =?utf-8?B?cUQ1MGx0U2Zkc3RqME82cmtZOFhnVExwS0ZUM3JoUERySVpCbWFGbENkZjN0?=
 =?utf-8?B?c21HV1RObklqUGh5N0duZXB0amdlYVYzM0FyYmdVbFBpZThYdmNReXJxZHJw?=
 =?utf-8?B?M0NXQnI1VGlEbmIyOXM0cW8xUit1dkFuTzhEVXRSSys1Y0VGN0lGQkNMTHFM?=
 =?utf-8?B?WEFmc1lIaFVoekJCMWRtcWtMUVlGUEtTVHVyR29HeHNLdVNWOElyL3N5aTdE?=
 =?utf-8?B?TUpmTkpsZjlubUd5dXU3UDBwaWJvUlJxMWsralYxUm5PK0xuWDdLc2J6bXRu?=
 =?utf-8?B?ZERiTmJlS1ZibjlIcFl1WDZWR3JISmphUnMraDVmL2ZrTFlvL3NkOHZ0cFZo?=
 =?utf-8?B?TklZemtXZXJIdXEwVE9VcGFDQWVNTGhSWDV5MTFDN09XTDllUktueDB6K1dn?=
 =?utf-8?B?eWwvYzVuYllndk4xMXhMMXo2VTJrMjg0Ry9EUEJ5ZThkcUpac25IU2EwbENM?=
 =?utf-8?B?S21zT2t3R21VMVZsN1JGRnVkWFl5QUxQUExoUHQzekROM3dUUHJxNEF1ekFv?=
 =?utf-8?B?V0VyRGlqTCsrQVl4cEhsVjloRWpUeFhJVjlnaGxYVCtQcEhkUXQ4dlNvazVH?=
 =?utf-8?B?RkVWVlJQNzRqaDJuSWI1cDhqeHd3UlpIdzI0eGYrTVhOR3FnMks1dklIcmpS?=
 =?utf-8?B?MVA1d3Jub1lpT0ZOZHUzRVNUUVlMVXFid2RQQlBYMDZmb1VRUTh3ckZPZGxq?=
 =?utf-8?B?NDEzdkRmVk1rUSt4dWQydis0VklqekRudkZ0Z3VEcmJZVS9QRWRMMVF5TzFr?=
 =?utf-8?B?aXBPeTZJMGE0bEYrYmo0RTQxR2ZSUS9FMmlHU0FBS1N0a0ZrZmNEYmw5RUVx?=
 =?utf-8?B?ZERRejB0Y3pDSEtjU2pxT3hOZjZxdWt5b0lMc1ZOZkc1YTJsdkNBdW14RlF5?=
 =?utf-8?B?TnowOFJlM1lDRWVhb0Z5V25Jck1TcjJJMEwxTWN2S0RtK3JuRkF2enJzekZT?=
 =?utf-8?B?aHpCanFvc3BHdmZJaGFIRG80TTJ0cVJud3hWVXliR2hrZ3Mra09hcXBOSG5Z?=
 =?utf-8?B?SGZrbUJmV1VxdnJSRHhHc080ejhqOVFDYk1TWXNUN3hlR29ZU0VZR1lZQnlL?=
 =?utf-8?B?UzlINUQxLzEzZ1N4SWtla0ZtSjJ4UWZ0YTl1V1gxdjJqdGpHQ05WRDZWb1Q2?=
 =?utf-8?B?NnhURUZ3ZTFuWDBJQVZxaWM3TnRlTC80eFY2MnZKOUlwUVhLVS8ycVBYNStM?=
 =?utf-8?B?SnhWYzU3cWc0ZmVqWTNOaHBsUkUxazlmYzlnRXY5b0diWFRaTElhOWV5Q1pm?=
 =?utf-8?B?UXZ3Qk9pSzNjcHBsc201YURsREZ0U3BPK1J6Q1ZMMWJDZXRaWUZEVDRqR2M5?=
 =?utf-8?B?ZnFIS2U4ZE5wWE1hU2lwQnB1NlNMWjdkZlhxb1hqMjlySTNGbDVBU0Zxa0Yw?=
 =?utf-8?B?VnBXOE9lblpYT1MyUytPYWVyT1NubDYwRDhUY1k4bUpGZ0lvUW4xcjZCL0RF?=
 =?utf-8?B?U1pYMnRhYStSZk5MSG8yRUpDNDNXdVN0MmJpUUM4N3BPQ3pTM3k5Y0s1L1JU?=
 =?utf-8?Q?GZvPU7v71e4Ht?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2IvSmxDM1gzL0NGVmRIWFFjK0tDNmZjUUN4QmZHQ04wcG9uVzlnVlE4eEgx?=
 =?utf-8?B?TmpiWVQ1MjBOQXlJQ1JTS3hSMlhZdk9YSGpoaU5oK2JOaGZiRVI3N200RkVn?=
 =?utf-8?B?ZHc2b2k3ZlRUaUJVMWJLcEZCZm9zbjBzRmF2eno5VnZ0NzM2SmxoQzJ0cEhE?=
 =?utf-8?B?UFRNZVVYcmFWT0tpZlVRNFE0YjdBYWUxUXhZL0Vlb1poZE1JaFdsVTlLR3g4?=
 =?utf-8?B?UGxjTElnNjRicXBmRGFkM28zN1ZTVUtiQUdVcEhlVHBSRnF3U05KYUk1VHNU?=
 =?utf-8?B?eDlxZDJ1dCtnNkZVZURKNjVQQzlqTDFZWHhtWVMrUkZXYzFuQVRLRGdaZldt?=
 =?utf-8?B?WkRHSHdRS1BPejdFcUs1c2w3YkczQXBXdDlocExtd2V2NmJ6eVFwRDVlOVNU?=
 =?utf-8?B?a2dwUE9vK2t4OEpQMUhyR1pxbDV4MXdqOGJLRUxvWlNDaElsNW9ORzhVWWJL?=
 =?utf-8?B?Q2lneW0ydCtjbFYxZkZJZEdmVnM4dXJ3cUlKa0xLNkZHWTNuajROTGdXMHVV?=
 =?utf-8?B?QnQ4ZHU3VXBuWms3cURSREtOZ2VkeTF4aUh5d3R4SWlRSldUUmRBUXJYQVg3?=
 =?utf-8?B?bjF0Rk8zZHNZODB5ZHl3Z2JqaXlwN2JDbnRQMytCV05Zdm4xTk9rNml0TFAz?=
 =?utf-8?B?RmRTdExFQjRrcHFhWDZzaVl2eGUwWlhqdXJJbXo0QnpBT3ZWVGxDS3Mrajlj?=
 =?utf-8?B?Z2l5Qi9FMVhFSTFTR3d1ZWZBTGxRQmZ6WmRNOWE0L2tkbDQ3YzdFc3hlR2sz?=
 =?utf-8?B?RHlrS0hoQk5mN3R6WWhoQjltenFFMVA3M0F6Uy9YaForWVlyNU1PVlh1NHU0?=
 =?utf-8?B?aUowVUEwaDZVNkdEc1pwUE8xQ1MvVGNzN3YxcXBoMmpjd3hPdjJ1dG1IcTRi?=
 =?utf-8?B?RTlZV2FON3M3VS96V01mN0dSS3FJZy9HdWtFSGFEb1Z6bm5BdVVJNFV5RWQv?=
 =?utf-8?B?Q25PZzlGY205UnRDaHVsclVTRWpOU3FhV3lnZ05BZUxIU0RadUlTQU43RVli?=
 =?utf-8?B?OFdKcnpKbGxWNDZWaE0yVzJvcUJTWDd5L2FPTXNCNkQ0LzAxWFl5aUFTSXVi?=
 =?utf-8?B?aTZQV0JLTVRoSldsaFZKN0FmTXZBV2VJbGdsakZDMS9KY2hxTXdZaHp5d0Zv?=
 =?utf-8?B?Q2NLK0xQajlZSXdXVFFJKzVWdW9KcWV3R1V5K1UxbFNxejZwOW1nbWlKOEtM?=
 =?utf-8?B?OGw4Z29xWUhQQVI5THk3T2FHbW5nOGdWT3pkUnRTVHBURkFvTVozbDRQaGRs?=
 =?utf-8?B?SVVWaEhHbDQvRnpnRWVFaEdPN3dwam1NSTRvejB3U0ljZUFwclI1K1hWb21W?=
 =?utf-8?B?VFoyZ2QrZE1scTBTek8xNFVrSTZiYTYxM3lJbDRuU29icXUyNmFKREFkd0pi?=
 =?utf-8?B?cnNxbGoxRllkUzlsN3pGQjlIS0FmSWlIQWd1OVFoWDY3VzdHSDFhTitOTXNv?=
 =?utf-8?B?dFl5RDNRZ3FJZU5ENkpIUUtIeExIQ1dKYW53VDlGT1N5eDl3VHU0cWo2REkv?=
 =?utf-8?B?bHZuY3ljT2xPNklId0ZraXR1Z1EwREFndkRsTUZPSzF4bkpzdnhIR2Q1SGtX?=
 =?utf-8?B?WlN6WFJXR1NZT09vc05xWnovTmt5Q3RGaHBUSmFwV2FWd0xPTkUxUkZBeUJq?=
 =?utf-8?B?NkJocStaMlZ1R1h0L2tscHZnaDZiVFBIaHZxZit0aVFoTnIvUHNPcGRGa25w?=
 =?utf-8?B?R0h1UDJzR1IydUI4RS9vcHVpVU12bGtkVjNnd283UDBOWGVXaHFhVXYyak5O?=
 =?utf-8?B?azlzOW5aZFkzc1RTcUJJa0R0MTlyTjdtS0RtL1c1bTFFd0Rha3BuS3VRenFq?=
 =?utf-8?B?UWg0VnNOa0wreWh3ZGpIMDVkRHp0UE95WCtlY0F0YnJhcTl1Q2ZBUlMxWHdL?=
 =?utf-8?B?bjgydnFUU2tEN1dFLzF6Tm5XZDRTbDlrdm1MUTVicm1Qd3RXMkZ1Q09GbmpQ?=
 =?utf-8?B?Wm4rTU9LYTlEdHlSWndaRElSVUVReHZKdGZSeXhrcGJhT25sRUdSQUFCUytz?=
 =?utf-8?B?VFpqZ1JiWHFERmZncTlsTVNReGN5UExZOXlrQkdzcWdUUW13VFhJbk9Qejh0?=
 =?utf-8?B?amVkRGNRWExtcXNTYURtc0FQNW0wczI1MzlsRVhjRkZSaGREYUk4ZHRyYndP?=
 =?utf-8?Q?ubpTuw+ukgdh+HN+8vYNgT2bS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f60be0c-c23b-4719-97ba-08dcb07f97ae
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 10:08:43.4565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmBRhyorsotLcaPLQ73aI7eTde1hIwDLZqeMuIatJwIgE7cbaI9JDIfj4WlIe37FkTg9EvTf3U8DmbVq3HLGbu8rVg/Vxv1hHDfZ39b7oi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
X-OriginatorOrg: intel.com



On 30.07.2024 03:23, Song Yoong Siang wrote:
> From: Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>
> 
> This commit introduces the support to configure default Rx queue during
> runtime. A new sysfs attribute "default_rx_queue" has been added, allowing
> users to check and modify the default Rx queue.
> 
> 1. Command to check the currently configured default Rx queue:
>    cat /sys/devices/pci0000:00/.../default_rx_queue
> 
> 2. Command to set the default Rx queue to a desired value, for example 3:
>    echo 3 > /sys/devices/pci0000:00/.../default_rx_queue
> 
> Signed-off-by: Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/Makefile    |   3 +-
>  drivers/net/ethernet/intel/igc/igc_main.c  |   6 +
>  drivers/net/ethernet/intel/igc/igc_regs.h  |   6 +
>  drivers/net/ethernet/intel/igc/igc_sysfs.c | 156 +++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_sysfs.h |  10 ++
>  5 files changed, 180 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_sysfs.c
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_sysfs.h
> 
> diff --git a/drivers/net/ethernet/intel/igc/Makefile b/drivers/net/ethernet/intel/igc/Makefile
> index efc5e7983dad..c31bc18ede13 100644
> --- a/drivers/net/ethernet/intel/igc/Makefile
> +++ b/drivers/net/ethernet/intel/igc/Makefile
> @@ -8,5 +8,6 @@
>  obj-$(CONFIG_IGC) += igc.o
>  
>  igc-y := igc_main.o igc_mac.o igc_i225.o igc_base.o igc_nvm.o igc_phy.o \
> -	 igc_diag.o igc_ethtool.o igc_ptp.o igc_dump.o igc_tsn.o igc_xdp.o
> +	 igc_diag.o igc_ethtool.o igc_ptp.o igc_dump.o igc_tsn.o igc_xdp.o \
> +	 igc_sysfs.o
>  igc-$(CONFIG_IGC_LEDS) += igc_leds.o
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index cb5c7b09e8a0..6a925615911a 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -18,6 +18,7 @@
>  
>  #include "igc.h"
>  #include "igc_hw.h"
> +#include "igc_sysfs.h"
>  #include "igc_tsn.h"
>  #include "igc_xdp.h"
>  
> @@ -7069,6 +7070,9 @@ static int igc_probe(struct pci_dev *pdev,
>  			goto err_register;
>  	}
>  
> +	if (igc_sysfs_init(adapter))
> +		dev_err(&pdev->dev, "Failed to allocate sysfs resources\n");
> +
>  	return 0;
>  
>  err_register:
> @@ -7124,6 +7128,8 @@ static void igc_remove(struct pci_dev *pdev)
>  	if (IS_ENABLED(CONFIG_IGC_LEDS))
>  		igc_led_free(adapter);
>  
> +	igc_sysfs_exit(adapter);
> +
>  	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
>  	 * would have already happened in close and is redundant.
>  	 */
> diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
> index e5b893fc5b66..df96800f6e3b 100644
> --- a/drivers/net/ethernet/intel/igc/igc_regs.h
> +++ b/drivers/net/ethernet/intel/igc/igc_regs.h
> @@ -63,6 +63,12 @@
>  /* RSS registers */
>  #define IGC_MRQC		0x05818 /* Multiple Receive Control - RW */
>  
> +/* MRQC register bit definitions */
> +#define IGC_MRQC_ENABLE_MQ		0x00000000
> +#define IGC_MRQC_ENABLE_MASK		GENMASK(2, 0)
> +#define IGC_MRQC_DEFAULT_QUEUE_MASK	GENMASK(5, 3)
> +#define IGC_MRQC_DEFAULT_QUEUE_SHIFT	3
> +
>  /* Filtering Registers */
>  #define IGC_ETQF(_n)		(0x05CB0 + (4 * (_n))) /* EType Queue Fltr */
>  #define IGC_FHFT(_n)		(0x09000 + (256 * (_n))) /* Flexible Host Filter */
> diff --git a/drivers/net/ethernet/intel/igc/igc_sysfs.c b/drivers/net/ethernet/intel/igc/igc_sysfs.c
> new file mode 100644
> index 000000000000..34d838e6a019
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/igc/igc_sysfs.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Intel Corporation */
> +
> +#include <linux/device.h>
> +#include <linux/kobject.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +
> +#include "igc.h"
> +#include "igc_regs.h"
> +#include "igc_sysfs.h"
> +
> +/**
> + * igc_is_default_queue_supported - Checks if default Rx queue can be configured
> + * @mrqc: MRQC register content
> + *
> + * Checks if the current configuration of the device supports changing the
> + * default Rx queue configuration.
> + *
> + * Return: true if the default Rx queue can be configured, false otherwise.
> + */
> +static bool igc_is_default_queue_supported(u32 mrqc)
> +{
> +	u32 mrqe = mrqc & IGC_MRQC_ENABLE_MASK;
> +
> +	/* The default Rx queue setting is applied only if Multiple Receive
> +	 * Queues (MRQ) as defined by filters (2-tuple filters, L2 Ether-type
> +	 * filters, SYN filter and flex filters) is enabled.
> +	 */
> +	if (mrqe != IGC_MRQC_ENABLE_MQ && mrqe != IGC_MRQC_ENABLE_RSS_MQ)
> +		return false;

just:
return mrqe != IGC_MRQC_ENABLE_MQ && mrqe != IGC_MRQC_ENABLE_RSS_MQ

> +
> +	return true;
> +}
> +
> +/**
> + * igc_get_default_rx_queue - Returns the index of default Rx queue
> + * @adapter: address of board private structure
> + *
> + * Return: index of the default Rx queue.
> + */
> +static u32 igc_get_default_rx_queue(struct igc_adapter *adapter)
> +{
> +	struct igc_hw *hw = &adapter->hw;
> +	u32 mrqc = rd32(IGC_MRQC);
> +
> +	if (!igc_is_default_queue_supported(mrqc)) {
> +		netdev_warn(adapter->netdev,
> +			    "MRQ disabled: default RxQ is ignored.\n");

Should we return an error here?
> +	}
> +
> +	return (mrqc & IGC_MRQC_DEFAULT_QUEUE_MASK) >>
> +		IGC_MRQC_DEFAULT_QUEUE_SHIFT;

use FIELD_GET here

> +}
> +
> +/**
> + * igc_set_default_rx_queue - Sets the default Rx queue
> + * @adapter: address of board private structure
> + * @queue: index of the queue to be set as default Rx queue
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static int igc_set_default_rx_queue(struct igc_adapter *adapter, u32 queue)
> +{
> +	struct igc_hw *hw = &adapter->hw;
> +	u32 mrqc = rd32(IGC_MRQC);
> +
> +	if (!igc_is_default_queue_supported(mrqc)) {
> +		netdev_err(adapter->netdev,
> +			   "Default RxQ not supported. Please enable MRQ.\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (queue > adapter->rss_queues - 1) {
> +		netdev_err(adapter->netdev,
> +			   "Invalid default RxQ index %d. Valid range: 0-%u.\n",
> +			   queue, adapter->rss_queues - 1);
> +		return -EINVAL;
> +	}
> +
> +	/* Set the default Rx queue */
> +	mrqc = rd32(IGC_MRQC);
> +	mrqc &= ~IGC_MRQC_DEFAULT_QUEUE_MASK;
> +	mrqc |= queue << IGC_MRQC_DEFAULT_QUEUE_SHIFT;
> +	wr32(IGC_MRQC, mrqc);
> +
> +	return 0;
> +}
> +
> +static ssize_t default_rx_queue_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct net_device *netdev = pci_get_drvdata(pdev);
> +	struct igc_adapter *adapter = netdev_priv(netdev);
> +	u32 default_rx_queue = igc_get_default_rx_queue(adapter);

Use RCT rule

> +
> +	return sysfs_emit(buf, "%d\n", default_rx_queue);
> +}
> +
> +static ssize_t default_rx_queue_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct net_device *netdev = pci_get_drvdata(pdev);
> +	struct igc_adapter *adapter = netdev_priv(netdev);
> +	u32 default_rx_queue;
> +	int err;

RCT

> +
> +	err = kstrtou32(buf, 10, &default_rx_queue);
> +	if (err) {
> +		netdev_err(adapter->netdev,
> +			   "Invalid default RxQ index. Valid range: 0-%u.\n",
> +			   adapter->rss_queues - 1);
> +		return err;
> +	}
> +
> +	err = igc_set_default_rx_queue(adapter, default_rx_queue);
> +	if (err < 0)
> +		return -EINVAL;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(default_rx_queue);
> +
> +static struct attribute *attrs[] = {
> +	&dev_attr_default_rx_queue.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group attr_group = {
> +	.attrs = attrs,
> +};
> +
> +int igc_sysfs_init(struct igc_adapter *adapter)
> +{
> +	int err;
> +
> +	err = sysfs_create_group(&adapter->pdev->dev.kobj, &attr_group);
> +	if (err) {

no need for brackets

> +		netdev_err(adapter->netdev,
> +			   "Failed to create sysfs attribute group.\n");
> +	}
> +
> +	return err;
> +}
> +
> +void igc_sysfs_exit(struct igc_adapter *adapter)
> +{
> +	sysfs_remove_group(&adapter->pdev->dev.kobj, &attr_group);
> +}
> diff --git a/drivers/net/ethernet/intel/igc/igc_sysfs.h b/drivers/net/ethernet/intel/igc/igc_sysfs.h
> new file mode 100644
> index 000000000000..b074ad4bc63a
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/igc/igc_sysfs.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2024 Intel Corporation */
> +
> +#ifndef _IGC_SYSFS_H_
> +#define _IGC_SYSFS_H_
> +
> +int igc_sysfs_init(struct igc_adapter *adapter);
> +void igc_sysfs_exit(struct igc_adapter *adapter);
> +
> +#endif /* _IGC_SYSFS_H_ */

