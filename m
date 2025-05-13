Return-Path: <bpf+bounces-58124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE643AB57C9
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 16:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1F6860F6C
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 14:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E709E243376;
	Tue, 13 May 2025 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCQ9PXLy"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919411C861E;
	Tue, 13 May 2025 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148363; cv=fail; b=UYkTC88Z87J2CUbVfW6GiOrQNZ0VvBQ1nzYQlKOvRjoLEBlPJTKvy1VXbDKYc+mYnUROLliXY20RET7sVCtT4wA8S7i6cyj24nOGzDaYdw5HAa/vXocvvAylIZOFLf3t15j8IG8P0VVRi9Ed+BomL8GmI99vEYMLM9Bb7/eNYzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148363; c=relaxed/simple;
	bh=aFSjZ0CZTPigteIWr6HOSTMz8/4usK2PmLYia3qGMT4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aMHVBCUX8C/R4EXOA34pGvf4eyS2VfUvotOKhubilqkILdve7OGW/Jsfiy01XB9b032SWHTv4O8dFXQqUiT0xK9NXDmwKUq2jCKPS/GN6B79Msm0T7or4lO5YtVUSN01EX1qwZ6I4yWLBm8YnXFJNeKL60baEcUB3Q0ov+WXCMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCQ9PXLy; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747148362; x=1778684362;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aFSjZ0CZTPigteIWr6HOSTMz8/4usK2PmLYia3qGMT4=;
  b=MCQ9PXLyojIJTgRuHYNxps69CYviAhndT2t55VGgKypJlHJ0onyonZAD
   Dh+IMI5kcCWNdPqnOVy9RIGEvbMLKxWua1vV3Y7ExfVPDhx/wSBU5eY7W
   75YtWVwgukWAGA9KHGi0RE3xzM0SbEL2JmhvCyV1mZT5Ho9oh/Je6aP99
   2Et5JO+6lMmEJCf2iW5MfxVKFKsWTgWr8auWSOjm7GJO87lDdjONuwXkC
   ppyYOdCOYPghd5CMc+xc/mkBJEwv+PwD6WbmmJmk4Nn9OKF5oujIj1+Pk
   3F+5md1I80V+H4g/Vm1SIt/KgmM9pceACKfSYZAd8nZ5gh/rHKiDSqb3X
   g==;
X-CSE-ConnectionGUID: W3udsUstTiagI6Xr5KxCmw==
X-CSE-MsgGUID: 3qAxiIJNRZKcgEYqQv7Dyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="49149360"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="49149360"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 07:59:20 -0700
X-CSE-ConnectionGUID: mXTIOYl7T26847Dma3U3Xg==
X-CSE-MsgGUID: aMCL7o2KSU6gfNL69i6nvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="137469774"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 07:59:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 13 May 2025 07:59:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 13 May 2025 07:59:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 13 May 2025 07:59:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5y6ovEmesauGqDVNuw3dmanlMWG8VUlcX6PUWgmbrQB6Yj6AnBxyAQBBdGBBA1d/q+zOkVQYzaP8CzqBiD6n4wRytiqkVhuQaKxndH9DmFo0o+bqqt7IcKUig3OA++w0FFatCcUixskLUxLk5ARrn+3U7I+VQvqgDyAAl9OObCd6Y3G5oBBiS9va5eo6IBadtRQdC9O6j9rI2af6Fi+I6N+rZQG/4zVOEWPSa/0EWtdWdJNV33RUsl3OrfoGW/hEdspqE9HrHbl8Jr9RblQlRShuBk+0VBgedylCEMtGvOXcFgz5KwMRssJBEGoa/UTcZAxZbQqjjl9T08kCSUSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2kyzruiWYPH2xu8sVAfiFSAoYXhnKzCxRTxptp/Umk=;
 b=shK9V084XJOo0fB4QcW+VHYMa9SnQgCe/XKCYUQgyTsRE24T/E2+Y2WJZu0ZWXCzbq7+ouYs5aEZkwaZn2eCgVR6dN5Q2vC30E406J+pRA5YKDpkvDZpHwpovI8EiHSRTdxTsaW0I++685af3TBad+sBoyHsVXn9KwaJLssmNdEjnrPtlaQNdt77FFwgqw32Z8af2G4xFmelRRmZbF/jDxg5Qn09068mc2zx2keuKSu0epWb5XxbG+OFb6En29s1X+gu8rFzch5/PSuXK+lK7sEFJgb8Q+HJud2ZXppQLuVE5Y4+Nogsc29xdirntDv6QJX8zjkX0gAjPtiQ2OXXTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS7PR11MB6176.namprd11.prod.outlook.com (2603:10b6:8:98::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.29; Tue, 13 May 2025 14:59:02 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%6]) with mapi id 15.20.8699.024; Tue, 13 May 2025
 14:59:01 +0000
Message-ID: <25e39e3f-7a3d-4902-b000-0d7f969089c5@intel.com>
Date: Tue, 13 May 2025 16:58:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 03/16] libeth: xdp: add XDP_TX buffers sending
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Michal Kubiak
	<michal.kubiak@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250415172825.3731091-1-aleksander.lobakin@intel.com>
 <20250415172825.3731091-4-aleksander.lobakin@intel.com>
 <aAozJ5Twq7GidhHr@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <aAozJ5Twq7GidhHr@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0090.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::31) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS7PR11MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc18169-f09c-47fc-55f4-08dd922eb215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2NabGRIYkthTGVFTjI0cFVmMkFSTHBDSlMwNVVkZGhiTTlPUHl5Q2lpTkJi?=
 =?utf-8?B?NHpXOHJMNnlHZDZjdGN1cWFhZklRRlpUM3N0ZVdSRVNqTW9nZkNFQm5NNGE1?=
 =?utf-8?B?aDdnc0lNT2FHYytBNG1tTGMxeVV5TnRKemc3SThiZW5iLzdnYlV1UWQ5R2Z6?=
 =?utf-8?B?Zmw5WERYTmloNGF6ejdGMU1hVWpCVnh2N0lKckZmaVR1RTRYSWJqaytEYk9P?=
 =?utf-8?B?UDJOOGtZQWR3VFdwdUN4QU9TNG1TRWZoLzR4UkovRHI3OE1kZ0R5TEJzWWZa?=
 =?utf-8?B?V01SU0I4dlp3QTNOalpvZXpqZnh3VjJoajloY2p1OGUyWWl0N1IxMW5oZFBV?=
 =?utf-8?B?UlB5S2wwemxidnhYRUNVZEdxakxycVM4YUZVMVA5SHh2UmhxK1J2TDU4bkRJ?=
 =?utf-8?B?dGZqNnhtRkliRGxuQjNuaWtEWmFtNlhYSkVCSk1tRXZEaUR6SldNOEIyWHQy?=
 =?utf-8?B?U2VuSkZqNjFzUVI0THZUWkdvOW5Ydk1qUnZreEdCT0Q4VjRZUWxSMXJpdGJU?=
 =?utf-8?B?MkdDTE9heURxWUlCMUJ0MGx2NFNMWk1OVk5lQ2s4T2x2M0hERG9tNzhLYWo2?=
 =?utf-8?B?Q2s2cmFzUXJxbzZJaFNneDZTYjFhRnRjVDVQRXhseGRhdkhzc1dpenNDbnVj?=
 =?utf-8?B?NzZqSWRNUktUMlhKT2pZVXJ0K2xjbkpRbnMzaUpiazVSV1E3WUEwRnE1eWlu?=
 =?utf-8?B?SWlKM2U5ZllqdWpGZVF0d2xVV1VrcVJpSVNlU09sVWVtUXV3MFZISElDbkJn?=
 =?utf-8?B?Sy9BRkdoenJBVi9GYXJpSVMxdEQzOEFiVTNxNkdsbXQ1cThIOTVueS9JNkk5?=
 =?utf-8?B?SmJaTDk4MDBEbEZ6TzZQVjJ2Z0hJeTNYVmsvNm9hS2MyWWhkQkMyS1h5Rk5V?=
 =?utf-8?B?eXpuWUx2MkxtOTJhRUxPcWJsQ1czNEc3azFyMHlDbzdSWFNNZjZtT2RqNW5q?=
 =?utf-8?B?N1VkbVZTVHBxVm9DQWROOEc0aEdPbjR6YktDYzZHb1JBay9pcllmcU9jMDdp?=
 =?utf-8?B?OFBOT1BqQnh2WkVZZVFtanBXeEEwNnVFby9TMmtPK3BtbTdqNHpqejd0NDBv?=
 =?utf-8?B?bCtDRzY4WUhWSlRGUG1yWFJ4L0g0bGp3cXR6eGZaOXo1dDdmSVN4dDlyZk9r?=
 =?utf-8?B?bC9KRXV5RmNqL3VpTW5MSGI5Y3Z4aVZoZkVGcWtRUktvbEZ5OVNpb0JGNWxz?=
 =?utf-8?B?WkppZi9FY2dqaVZ5ZjFZZ0Z1YVZwVDcvNmIxRzBLNHVtaXc1TTVSQjdMT2ZL?=
 =?utf-8?B?cEVMcmc0d0JyUG1xUjZ5azFkVzBHcnhtQkhsTzB2QkkwTktWR0tpWnpYcjRm?=
 =?utf-8?B?UEptUlJGVTJGeU91U3pjbVhnbDRWeW95VkxWT0x1clZaOXJ0UUhXcWRlbzN1?=
 =?utf-8?B?dFVPS2pkYlhUck55SlNHb0xKSGZHNWJJOE1aeG85NVZzUS9nR2tSeWxXM2gz?=
 =?utf-8?B?ODd1cTU1QXJlbE9ab1dncXdSWHVocEk3TmpCRXc0U2VhSU9iMktJbDYzT3B2?=
 =?utf-8?B?U0x6ZnF0bkJyc3FCWnFKY2g1YmRaemZiWHJDT3h2c09veVFFMXBuWUtxUUQ5?=
 =?utf-8?B?ZmRUL081R1E1US8ycE9oVWlWcXYxRk9Gb1hDV1ZKSDByNlFZVDhMZ1EwYW92?=
 =?utf-8?B?NjBNckpIc21EVTVPZ1o2b3dCQnFYTzcvT2hta1VVYkhrRmFibXo1UTJIcWZZ?=
 =?utf-8?B?YlpLY1lpYXcwSDJWUGN6V2hmODZBbjB5ZDk1OTM1MjNXQ044ZnZzRWl6cjYz?=
 =?utf-8?B?RHVRb2l0Q0QzeHIxSnNIRldQQ3R4OEZFcnlqejJtRWFJYVhkaWVsb0I3bks3?=
 =?utf-8?B?RCtYanpGMXpTVXlJV2ZXb1lQMzNqejJhdUhxM2V1VWQ3WWsxdEJLeHNLUXNq?=
 =?utf-8?B?bUxkdHc5a1lJKzI2djZ3NWM5MHVrNWFVQmpXaFhPZEVrS0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2RhMUxQNFA1Sk5peDZqOXk1S3MvTEJBUW5SYnJGNjM0b1Z2aTdsN3hUd0gr?=
 =?utf-8?B?cCtBNHhmdCtkOHh3dnVmTm4xMEtybEkycUwwNm5JeUxZQ3J5dXNlYlFuSktP?=
 =?utf-8?B?VUxtcVpObFdISUdXMjYxbWVZMVFwQno5RmhYcERjamNrWTJ4V0hZTmZSeVpQ?=
 =?utf-8?B?UFZzUHJlTG1aUTcvdmZRUDFZSUI5dHM4cFFJZ2cwTDRtL3lseEZZRVNWR1FF?=
 =?utf-8?B?a0RpaXRaRHdNNEk5U1YzS2dLcFdvaGM2V1lLYkZ1UVRXcWs3NFBMVjdySktk?=
 =?utf-8?B?b242bW9hMktXSmI4ZnJlZXhaa1oxSytLN0hsMVMvMkxnNEtxb0hOdmZrN1FK?=
 =?utf-8?B?QVFzWkYzZ21WcnllTmVnWEcwamVwRzY0K0ExNVlQK2NHdUhucHhpWjQ1NjZN?=
 =?utf-8?B?Z2JsMFJqWDFYVjV2b05mMGtOZnJjVkxZS29DYmlXZHJNenpFa3hGMlF5NnB5?=
 =?utf-8?B?eFloVnNpdVpweDZHY1ljaEVrRGpIa0xNeGZyVG1IcnVocDJGSWZJMzdSSnNY?=
 =?utf-8?B?MjAxa3d0MEdkMW9wWkdjZ0plRnRJQ2l4SWRCTzlOQWZ2TmlCeitVUFQyVnlR?=
 =?utf-8?B?QjVXazg2SUV6akZxb0VudDM4OGwyQk52RS9ydjh4SUZpQkdkL3A2YkFvQ0hk?=
 =?utf-8?B?TE4vTnVIdUluVTdPS2h6Nzh1NlkzdXBuMXBVTVdORDc1WUJCMXFGY1VmUlcz?=
 =?utf-8?B?Vk9kdGIwdFRpRWdaaGVNZDlMUWZhQmIxb2NyS1JNRmxHdk1VZitkSFdFSXQ3?=
 =?utf-8?B?RzlmY3NVd0tNc2hDY0lUbFVJTUQ1RHVxc0YvUnM4Y1dtZWZjTGtlbjZKTTJO?=
 =?utf-8?B?M3pYVE1CZXJpalcyUUEzVlU4U1NGZmowKzlKRWdQVEFBZis3eVM4Z2pFb0pD?=
 =?utf-8?B?Q2dPUVVXZDQwZnE4N0VaU01wL1ZtZmwvRzJmdFk4UlBDMlZkQStQRWVzdnlT?=
 =?utf-8?B?ZzQyWUFyd00rQnJJcnFGYWdGcHdEa2ZwclJyMTBuSS90RDUxV0pPQ01XS01s?=
 =?utf-8?B?LzZSenczN3N3T2poRmVHY3R0cjI0WWVPOEZSV0ZyVEFDcndHWUtDYmF5YWRI?=
 =?utf-8?B?aE1mTThMSi9taWRCZG9oMFI1WFI5djNnOGo4dXI3UnA0YkdQbmQ0NmtEa0Ez?=
 =?utf-8?B?OGNSMnp2TGRVUkpyUFVpdHdaQXlXZk9yN2NuamdMcjdYZUNSVXRuRzVjSVlX?=
 =?utf-8?B?QTU1VmY3bDNmeWpEUm1odkRsQU01UG02TE1kVDROOWRpZXhzUUNhc0k5cEYw?=
 =?utf-8?B?cXlpbVcrQXJ6Y2tmQlVGR3gzUnorVytXeWNXSit2SEVMSjYxVDlROW1aVUhk?=
 =?utf-8?B?NDBnNUF0ZTJIenhENTdoT0twTTVpZkh0UTB5dHJHK3hOby9wVTFGMEdxTUFV?=
 =?utf-8?B?RFJCOUJGYWVpTHNQVk5PUTR4V0JpYjFrQzFmRlYzRmx4dWlVNS8yUHloN0xL?=
 =?utf-8?B?ZlBUMEkwVkdGWi9ldU01blg0K2hYS3QxOFhTM0pVQ0pZYU1ZMDVPUGsvVXcr?=
 =?utf-8?B?aHZhU21iZHpkb1phdnJFWlVGMldoQS9QYXJyV0VKZnlSVTd1eUF1NVVxVGhm?=
 =?utf-8?B?QkVoOWkxczFOWkJqSWxiVitRaDRQWTlkUTFnemxha0lObnFWZlBvSngzRmp1?=
 =?utf-8?B?Vkd2WUFOSnNiRHVnRUZxQ0lZNUNIM01vQkRkOExNMHBqOHN5WVFibzM5aGkz?=
 =?utf-8?B?YWNqWWpLMXc4Y3F6ZTk0ZXB4RkErUGdlb0o3b0J4QmdPeEg1UXFnUnNPc3Z0?=
 =?utf-8?B?dCtMMjBnSmNUNmNib3NCbnRKZmplaHl3TmRJaWtPRUx0d0k3aGxpbTcyNnM5?=
 =?utf-8?B?Q3VseGcvcndIcHZ5a0FxcWF3bmpvQTBDSVZ5QlE0bVBVMHZia3NkMTVmb1Nk?=
 =?utf-8?B?UEtFK1VRbFh4VUNDbnhqdHVRKzhIelZTa1dGYkZsMXV0YUxzcGFrdmV0V1F3?=
 =?utf-8?B?MXVZUG5WdXdYNGVnTW44VFZxK1RwZ3BkeC9zcEw5a1VEbnZTOU90K3hHQUFi?=
 =?utf-8?B?MWlsUk5DcXFvcGJ2K05kVkU5aEZpUXZ2dWpvYjlIQ0RwQVBFMGlDWnBFMG9F?=
 =?utf-8?B?S0Z1dmcrSkJBR1ZqTVFoc2ZHRDZ6WTJIM0Y5MUFJU0FlZ3BBUEFuWk54WkRU?=
 =?utf-8?B?cGY0d21rdzFONjh3b0J3bmwxZUFxNURLVHpwV3Q4dkMyQmpUTUV4cjRheU1D?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc18169-f09c-47fc-55f4-08dd922eb215
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 14:59:01.6153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5kZuaThKN550q0fUdLSZubDqWEndl9cnvNrrCR0uWrATtWowakAQV/n4VdZPh6dn9Q1KforF1mcZ8T40BBWpVia1LVrto5R1u0s2lyFYjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6176
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 24 Apr 2025 14:48:39 +0200

> On Tue, Apr 15, 2025 at 07:28:12PM +0200, Alexander Lobakin wrote:
>> Start adding XDP-specific code to libeth, namely handling XDP_TX buffers
>> (only sending).

[...]

>> +static __always_inline u32
>> +libeth_xdp_tx_xmit_bulk(const struct libeth_xdp_tx_frame *bulk, void *xdpsq,
>> +			u32 n, bool unroll, u64 priv,
>> +			u32 (*prep)(void *xdpsq, struct libeth_xdpsq *sq),
>> +			struct libeth_xdp_tx_desc
>> +			(*fill)(struct libeth_xdp_tx_frame frm, u32 i,
>> +				const struct libeth_xdpsq *sq, u64 priv),
>> +			void (*xmit)(struct libeth_xdp_tx_desc desc, u32 i,
>> +				     const struct libeth_xdpsq *sq, u64 priv))
>> +{
>> +	u32 this, batched, off = 0;
>> +	struct libeth_xdpsq sq;
>> +	u32 ntu, i = 0;
>> +
>> +	n = min(n, prep(xdpsq, &sq));
>> +	if (unlikely(!n))
>> +		return 0;
>> +
>> +	ntu = *sq.ntu;
>> +
>> +	this = sq.count - ntu;
> 
> maybe something more self-descriptive than 'this'? :)
> this is available space in sq, right?

'this' means "this batch", IOW what we'll send for sure this iteration.

> 
>> +	if (likely(this > n))
>> +		this = n;
>> +
>> +again:
>> +	if (!unroll)
> 
> who takes this decision? a caller or is this dependent on some constraints
> of underlying system? when would you like to not unroll?

XDP_TX, ndo_xdp_xmit, XSk XDP_TX wrappers pass `false` here, only XSk
xmit passes `true`. In cases other than XSk xmit, I had no positive
impact, while the object code bloat was huge -- XSk xmit doesn't fill
&libeth_sqe, only a Tx descriptor, while all the rest do.

> 
>> +		goto linear;
>> +
>> +	batched = ALIGN_DOWN(this, LIBETH_XDP_TX_BATCH);
>> +
>> +	for ( ; i < off + batched; i += LIBETH_XDP_TX_BATCH) {
>> +		u32 base = ntu + i - off;
>> +
>> +		unrolled_count(LIBETH_XDP_TX_BATCH)
>> +		for (u32 j = 0; j < LIBETH_XDP_TX_BATCH; j++)
>> +			xmit(fill(bulk[i + j], base + j, &sq, priv),
>> +			     base + j, &sq, priv);
>> +	}
>> +
>> +	if (batched < this) {
>> +linear:
>> +		for ( ; i < off + this; i++)
>> +			xmit(fill(bulk[i], ntu + i - off, &sq, priv),
>> +			     ntu + i - off, &sq, priv);
>> +	}
>> +
>> +	ntu += this;
>> +	if (likely(ntu < sq.count))
>> +		goto out;
>> +
>> +	ntu = 0;
>> +
>> +	if (i < n) {
>> +		this = n - i;
>> +		off = i;
>> +
>> +		goto again;
>> +	}
>> +
>> +out:
>> +	*sq.ntu = ntu;
>> +	*sq.pending += n;
>> +	if (sq.xdp_tx)
>> +		*sq.xdp_tx += n;
>> +
>> +	return n;
>> +}

[...]

>> +/**
>> + * __libeth_xdp_tx_flush_bulk - internal helper to flush one XDP Tx bulk
>> + * @bq: bulk to flush
>> + * @flags: XDP TX flags
>> + * @prep: driver-specific callback to prepare the queue for sending
>> + * @fill: libeth_xdp callback to fill &libeth_sqe and &libeth_xdp_tx_desc
> 
> Could you explain why this has to be implemented as a callback? for now
> this might just be directly called within libeth_xdp_tx_xmit_bulk() ?
> 
> What I currently understand is this is not something that driver would
> provide. If its libeth internal routine then call this directly and
> simplify the code.

XSk XDP_TX passes a different callback here :> Anyway, all callbacks
within libeth_xdp get inlined or (sometimes) converted to direct calls,
no indirections.

> 
> Besides, thanks a lot for this series and split up! I think we're on a
> good path.

Thanks,
Olek

