Return-Path: <bpf+bounces-41397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540C19969F9
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 14:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 830A2B22257
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 12:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDF2193419;
	Wed,  9 Oct 2024 12:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BalNQ2W1"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3B5193073;
	Wed,  9 Oct 2024 12:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476886; cv=fail; b=CMoqjfquCWPWDY3GNJL+y0O4+IEk7PPZ6o9Wir58obEKj0IeHoMMVRMVkTxhaxHOP1p/a/UzKcFgq12kHn1PYp176yznVhwiittwYO1bWAIDgOgN4Ysaa0TOz/yXVltGUp7DrxPdWMs1SaE4Fh6P5RPDpDq9GwRpDnMYG/33OFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476886; c=relaxed/simple;
	bh=/qRQOqsPFU7tquLDASFEcyu0+lYNLaq/8HRlqg2W8oE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e04lVXLHpy+iEk/EcVS7uPzSNxUhIb7edVvn6bvsT8QBTqIrjPuiQR/gS8GSYDr+CIbaC82hSeioXF3WIqYEe9Vyqa+iKdpRlTQqKNTA0XYkiDGi8nIFtWbAtSdav0MPFj2D3/aetoI9aQN7/an+2rwxtlPDZM0nhn4XVeHEjlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BalNQ2W1; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728476884; x=1760012884;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/qRQOqsPFU7tquLDASFEcyu0+lYNLaq/8HRlqg2W8oE=;
  b=BalNQ2W1xQ/EazfqjnqqetTzZklRvKX63OO9HeV54v/kRimPMNcnt0ab
   Hw/K3Vg1lUd3e2tb0e+aIj5RbpM1x5Fy3/UoPP/isHIb142iKRMFlsAij
   NYtICHz3oAckdAhE+wmA6qYDIX7XSiFQEfLzaJeKjR1+cFhPxvJODKKzG
   mnbxmPGfFBfZ7x25JWUgq3LIR9N+gR7VZC5IyA54GJIHAM001gjZd0N1H
   k3FAS4EQ+2DYzvLM0weWFSIK+uaxGlxHvXI74XMCF7Eq3lTPrH/eHqB3A
   SVbY0AJcxZ9Tvj4RJrn3hEs4EfVsbLARSCHbMEfa59oqdbzdxBFt1rI0e
   A==;
X-CSE-ConnectionGUID: 9d6gngPkS1a1x3I1VpIDlg==
X-CSE-MsgGUID: sbH1uWDZTxuyXnGDjefMtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="50308929"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="50308929"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 05:28:03 -0700
X-CSE-ConnectionGUID: 3x0u1sQhQdKQZn1Wbn+LlA==
X-CSE-MsgGUID: ATPPXDgkQ5ma38xXGo1XZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="80219567"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2024 05:28:03 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 05:28:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 9 Oct 2024 05:28:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 05:28:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bk4v8kbTL7Pl3IRCQZmNfe+lQeBej2okVqDUM71Ro1i3VRXowe2famu+bJ8CVoHWmrR/yjQdlBlSN/2q1sjjKPp87gZnc8eDdi8xWfQJhuEMV9VBRTce9ms/3wYW96NHM7sWAS6Wlu3gVoZHaEJwLT2WjtMf2ugXYE84WvprmFcNDGaoigQUmHgAxqX0uP90qqqKqKEVIQr37lIMK2aHXfu+HZZMXMrD/zurt4rklkAuf3gsN6yorMap1Gi7aTbt4/hBVs5yP5zt4DaqDIZk2MyYglG0jEb9YJH+CSG1MPslCnS0/12vFeai82dtrEuKaFKrjuxkpTUdzBQbyoXy5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+Wd78OTnXIAwlucEg9l/zatLpYXGCDXltVdPmFP/GY=;
 b=Q7mLMmiClDG2ZvAPJR2iDwnANFn0zQTw3KAiaIW70DE1eX3d1ZZeRActyYFgb6jhmn3sNawmfOmTIDOiYunCQM83Wia8HAIRJ1LW/GGFcoJApQpVw3XsyZB5+3C5pPMIwGJVlx1OfnMY8PKWNDILGMaebibSv4gekaGpgGLBDpLzLhvzjCsncjxwcJhCd7Pif0ssJsQoaZyX4YJBwfcf+b1yMCGsp63h0y8L1IDFbUZOnO68qJf6/6GnNu6AWe/KDQnPUZj2IHIU5GAE1yeNNDc+BvpUlgSzX+5ufv2VupTz6kvD5o0ZPSct1ztSek/CbW7lur+eGSfYxcF9efrLZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY5PR11MB6390.namprd11.prod.outlook.com (2603:10b6:930:39::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 12:28:00 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 12:28:00 +0000
Message-ID: <55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
Date: Wed, 9 Oct 2024 14:27:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
To: Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>
CC: <bpf@vger.kernel.org>, <kuba@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <john.fastabend@gmail.com>,
	<hawk@kernel.org>, <martin.lau@linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<lorenzo.bianconi@redhat.com>
References: <cover.1726480607.git.lorenzo@kernel.org>
 <amx5t3imrrh56m7vtsmlhdzlggtv2mlhywk6266syjmijpgs2o@s2z7dollcf7l>
 <ZwZe6Bg5ZrXLkDGW@lore-desk>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ZwZe6Bg5ZrXLkDGW@lore-desk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY5PR11MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: b71d8f5f-22d6-4483-2a82-08dce85dd010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkFRaXM5UExNMWlibzFrT25zS3BFTmR0NkNqZmgvM01NWUpEbG5KYnFkNmVp?=
 =?utf-8?B?QUpsbkdBRytSdjN1ZE45eVZzOWJHRVV3UFY5WGhxZHNlSDdVS3VGa3FYVzlC?=
 =?utf-8?B?MmlsNENZVy9NYTF3VVFYa0tVQVJsY1EzTkpUR2ZjcUpPZ0V6elVDYUV0bWlL?=
 =?utf-8?B?ZlAzaXBjZHZNRk8yODU3VCtjWVBVb1FtOHVxZmE4NlpuaklpNloyM2dQaGhC?=
 =?utf-8?B?ZXVrVUlnYllvNGlpZjMrWmIzMkpqU3FWc0tBTDZrQVBhUVBCN0NkaEdvOWVD?=
 =?utf-8?B?Z1RDMm1nQXF4WU10dWRZc2tJMC85RWc2eGp4aStlZGtVU2pDaG9TdmtVeDdm?=
 =?utf-8?B?T2NxWlNPZmZmRGhydVhpQ1ArcXRJTVhENjlRcy9qODIvaDFnVXFHVDZrUVJF?=
 =?utf-8?B?UGN2ZWlBZUlvSkZlZm9uYXVsSmhieWtjLzNIWGhkNlNOTStmaFBjOEhiWFMw?=
 =?utf-8?B?MWlaajNxcnBGbElyNnRHQ245QkV0OVZBTWVRS2twbnN6UGdkdWh5aFNrNkc1?=
 =?utf-8?B?OVdLK2dyaTh3YW4vMFA2dEVYTTJrSEl6STV6TjFZMU41b1FTRnJrZW1rNkFN?=
 =?utf-8?B?WW5mbDhxWnpVTzMyUHBDSVBMNCtmR2VXaE5TTUIrSWZYWURyY2Y1YUtOYVZM?=
 =?utf-8?B?WHFJL05aY3JZWFM1b0VZYlNoZ0kyelQwd1ZodEN4dDRuL0Y1UmplcGhtTThk?=
 =?utf-8?B?NTdxWnViSkpibVlNU1J4K29mM2dXRG04UElLbEVLVGRTQWQvTmMyVHMweU91?=
 =?utf-8?B?cWI0dFpBaU9HM1lsQWM4WUNxQVptMGZXTHJuTVlsd0RjaVNZdXJCaGE5YmFw?=
 =?utf-8?B?Wmg3MkZKOWd2YWNVSEVjRHhMVzZ3Z2tXeUNtSDlZOFFMcFdVaVhqRWRoMTVC?=
 =?utf-8?B?MGxQbFFxSTF2cUt3aHlxNUl5ZG5Eb1hMUURDWGM5Q3BXNkJNOXM4MkRqSy94?=
 =?utf-8?B?TUJ6a2ZORDNWZ2svNnZSdEtVdzlHLzJpS0tGSFRGUk4zUXRkeTU0R2ZNNzBJ?=
 =?utf-8?B?WnNXVERyWmJJREt5Vnk2REJUUk5SNU02cWRmZk9nWVJoeEdFUjh6dDkxWmlO?=
 =?utf-8?B?U0pPbFA2c1NQMjBwUTNtcEJUWEtWeGR0c1hVUmp6UVNqVGZ2bVdjb3MyMjgy?=
 =?utf-8?B?N0ZNNGhrYzJhdys2Y3FMaUlwQzBXUkZrOGkwY0lSaW1sbjZJRkV6UXVnVlky?=
 =?utf-8?B?dVlZZWpEamdKNmVIaFFjTkl5K2ZQeEdIaytSNitvSitteWdkWC9yTk5QT01w?=
 =?utf-8?B?bzlrYTVNV25IL2dRMVFaUitsQVR2UG5iczZYU1VWTUdOVzg3Q28vVWlPZ1h2?=
 =?utf-8?B?NVlaWkx4U3dRVDY1a0ZOUXBRRkM4VTN0ZFp2N2xxYnA5QVZQbnZxRGZuM3pS?=
 =?utf-8?B?azIyR1dNNjQ4dzA1V0xDQ2JQVTBoR1MxVFJwY3ZjRm1Za1dHaytub3c2Q21l?=
 =?utf-8?B?ci96Rm5lVXVtclg4TGVPeUlPdEVrTTlNUEVIL0NuSHB3MG5uZXc2WDI1TnJx?=
 =?utf-8?B?QjFWUHBxcVp3aEF2RGpkemNMTHlGTGlKOVlHOEZpOCt5bkdCWm9TaGQzWTg0?=
 =?utf-8?B?N0UyWUw1b05IZExwL0dnQXAwTG4xRDMvTTdUdUNDNTRETTAzUUNxL2x5M2Zn?=
 =?utf-8?B?Qll0Z2hnL3I4RTlVd1gvaDJQV0RFUStpSWVRWHFCb0xHV3lldXJsNVZxMy9o?=
 =?utf-8?B?K0MzMTIzM0pPQ1BTUnhMeEZPZ3NTODMzWnVBWUlwbzRSTDNqQXBTTWFRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cllQWS9meTRVY0ZRcFpGRW5ZL3J4YlMzaDFMVklkTGhpTEJsakpBZit6bHd1?=
 =?utf-8?B?bkQ3aE04YllFeDAwS3Q2eVFKa0swR1pOTGdDU1h0MmluR1hseUhmbHBoV3E5?=
 =?utf-8?B?MEVwSU83YmVTb0M1TmxsL01vYVpZKzBtQmp5KzNNbDQyOXU3OGhNZzNNcXZR?=
 =?utf-8?B?dmFJN0h5RkEvWDNMMnFRM1hDSFJxRUhhdUM5aURsbFZRSTUya1JBV2ZzVEV2?=
 =?utf-8?B?OUZrbUVtQklmakNwVkJXY0tRV0lxRHpsd2RrT0QrdGsyejY3ZlNQeXYxQThB?=
 =?utf-8?B?TEdsQmlSVjJWUkFhdi9Jd0djRi8xZ1hLbjBhYjRMSnFFc3ZBN3VwcFNiZlhU?=
 =?utf-8?B?azlCYnZyUWxGTko0OFFlWDhYdTVVeGl6M3BEUUxra2U1NXdtVDI4NHFna3p0?=
 =?utf-8?B?NHdmMFJQeStkZ2dIY3p6TmU5NFkwUEw5bnduNHc5Wk9WT2ZESVg1TjBKWjVR?=
 =?utf-8?B?dWYrUStWaUovYmlaVE0xR2I4WUZJU0Y3QjJkemhKVS9NR2dPcGd2bHkvYnFw?=
 =?utf-8?B?LzF3ODFoenY1Wk1MM0RlSnZNdEF2ZDA2Tm9HM01hK1YxNlljdzRuZkt0b2hC?=
 =?utf-8?B?Z1BSM3hsMGdnVkNFNDVoNm9mV05YWnpodllUVmI1VDdXYVdwQ2tJT0xPMDUy?=
 =?utf-8?B?ZkxVNmVVUHRXM2o3NkZoRVB1YU5raXhFVUdBWE1XTi9Vb2xzS1V4K1lJSi9S?=
 =?utf-8?B?ejJ4VGhYOGJLR0ZObkxtUmpQVUtGUkU2L296Rk1FdmVlbnBHWFFteEwxMEV1?=
 =?utf-8?B?WnFCc2VyeGlUTlFyR0tZVTkyTjdlQVJ0WVVDSFhzdHNidkVSTVBtZGRpTm1r?=
 =?utf-8?B?aTFra3k4cUNDYkVsbUtJVTZEN05STTIxZWsvd1RsbGJTNkRxcDdRV2U5dzdX?=
 =?utf-8?B?N3A0dW1lcyt0UUZ1c3N1SE0rYjhxeTdaUldkTXdkRTRnNjAvUVl2Z1Z5eElU?=
 =?utf-8?B?cStkUk1zeFlNQW1LMEk5cmR1T3lZMEdmeHZndVM5N0JPdWs3MldTcjl2bkdJ?=
 =?utf-8?B?dDJnR1d3U0FLK0YydTE3NWkxWVI5aFFaSGZnRlI3QWJKb0lvTG9DRS9zTXhM?=
 =?utf-8?B?U3dUZU94dHVFTDVDN05FSXRrc2NoQzY2bU5xNGRKSVBUZFNLUGpLR3RhOHZo?=
 =?utf-8?B?RjJ1eFBRcDBSbEN1am95dmZtSTVMaVJUMHFCYUM0KzZRd05nRTFBQjNmOVNs?=
 =?utf-8?B?cHRPVG02NGorNVh6V3g0SlQxdXZrMTdzL1A2eGRqZDZCM0o4d2JmU3ZDNG44?=
 =?utf-8?B?ay9sajkvaE5zNS94QkVRVFFoZXp2dFMxR2xMY3BoeVBJWGYxR0xONU9UNmt4?=
 =?utf-8?B?RjVoaVREVmptRlJVQ0N2VUpjSjRLcTNHNU04RlNxYVRuYVV1ZGgxODZFVDQx?=
 =?utf-8?B?TExCMG9zdUtwbENQamRUcDIwdk92a3R1WXkxWFllVThmWXZLZEQzUGhtMEJx?=
 =?utf-8?B?OGh1SnIyRzVvVFZEcy9IWWVMMWJBSll4NlJ5SHR1Z2dHNjhyOGxiSFBPNk1n?=
 =?utf-8?B?clNVMkJCQnFPNGRvc1FlOEhQeFBVMzYySHA5V016dXF0dzZVUCt6eWtIOFdq?=
 =?utf-8?B?bVZ2ZmtoMGNzUC9sOUFwbENPcXRSTzJFOFpwNW1jTWNQZHRVc3dyRWNITVB3?=
 =?utf-8?B?R0licy9DaTBXODM3bFJBVENTSElyWExFcnZ1WVFHTFFxeXg0bDcwaEZxWTR1?=
 =?utf-8?B?aDRSNkJRTEl2UVlBajFtZGVFTzEzN0NNZmdWb2pQd09oSUJ6UDQwTm1oUy9v?=
 =?utf-8?B?SmIzd085Qlo3RklvM2N6bTRnUks1WitUT2JCQzhwS2NNUnVIMklpZjZENEVD?=
 =?utf-8?B?RUF4L3QvcjZWVW1uRTdiVW1qeld5UlZodjBIdDJrazg1TXpvd2R3RnRjdXgr?=
 =?utf-8?B?d2ZKV1pSbWs0L1B2cEYzVWxPbmg0UC9PbDVVMTY3N0ZjcWFuY0dPY211d2NG?=
 =?utf-8?B?QVNxb01KVUhVVE5GdDJkUTJUUGJRUjY0ekNrOEZTOVpFUUsvb2pONzFvb1Q0?=
 =?utf-8?B?T2NLVk5laUdmaUplVFRIQXpIUm5GYTgrNFZLRVVjYkNDT0doTEdBVm1vOFBK?=
 =?utf-8?B?dlk4d0ttYkU4alQrUG10NGYwTGF1Y2pEZVBPUjRWMjh5SUtzSFBHWXJNQndH?=
 =?utf-8?B?NzFzMk1VajVoT2lscFo3YXBDS05DR3NkRjBMc2V1a2VWUUNJQm1ydk9OSXNs?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b71d8f5f-22d6-4483-2a82-08dce85dd010
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 12:28:00.1099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZbhZWair5rBfCGtJMZIFcuidxIlvjXYLBtV3IHxurLrhJhDy52dNtF6FxyB11v9gPWDY4tg7irhI72nesNrkRf6fNV2oLNzt+NLucamoHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6390
X-OriginatorOrg: intel.com

From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 9 Oct 2024 12:46:00 +0200

>> Hi Lorenzo,
>>
>> On Mon, Sep 16, 2024 at 12:13:42PM GMT, Lorenzo Bianconi wrote:
>>> Add GRO support to cpumap codebase moving the cpu_map_entry kthread to a
>>> NAPI-kthread pinned on the selected cpu.
>>>
>>> Changes in rfc v2:
>>> - get rid of dummy netdev dependency
>>>
>>> Lorenzo Bianconi (3):
>>>   net: Add napi_init_for_gro routine
>>>   net: add napi_threaded_poll to netdevice.h
>>>   bpf: cpumap: Add gro support
>>>
>>>  include/linux/netdevice.h |   3 +
>>>  kernel/bpf/cpumap.c       | 123 ++++++++++++++++----------------------
>>>  net/core/dev.c            |  27 ++++++---
>>>  3 files changed, 73 insertions(+), 80 deletions(-)
>>>
>>> -- 
>>> 2.46.0
>>>
>>
>> Sorry about the long delay - finally caught up to everything after
>> conferences.
>>
>> I re-ran my synthetic tests (including baseline). v2 is somehow showing
>> 2x bigger gains than v1 (~30% vs ~14%) for tcp_stream. Again, the only
>> variable I changed is kernel version - steering prog is active for both.
>>
>>
>> Baseline (again)							
>>
>> ./tcp_rr -c -H $TASK_IP -p 50,90,99 -T4 -F8 -l30			        ./tcp_stream -c -H $TASK_IP -T8 -F16 -l30
>> 							
>> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
>> Run 1	2560252	        0.00009087	0.00010495	0.00011647		Run 1	15479.31
>> Run 2	2665517	        0.00008575	0.00010239	0.00013311		Run 2	15162.48
>> Run 3	2755939	        0.00008191	0.00010367	0.00012287		Run 3	14709.04
>> Run 4	2595680	        0.00008575	0.00011263	0.00012671		Run 4	15373.06
>> Run 5	2841865	        0.00007999	0.00009471	0.00012799		Run 5	15234.91
>> Average	2683850.6	0.000084854	0.00010367	0.00012543		Average	15191.76
>> 							
>> cpumap NAPI patches v2							
>> 							
>> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
>> Run 1	2577838	        0.00008575	0.00012031	0.00013695		Run 1	19914.56
>> Run 2	2729237	        0.00007551	0.00013311	0.00017663		Run 2	20140.92
>> Run 3	2689442	        0.00008319	0.00010495	0.00013311		Run 3	19887.48
>> Run 4	2862366	        0.00008127	0.00009471	0.00010623		Run 4	19374.49
>> Run 5	2700538	        0.00008319	0.00010367	0.00012799		Run 5	19784.49
>> Average	2711884.2	0.000081782	0.00011135	0.000136182		Average	19820.388
>> Delta	1.04%	        -3.62%	        7.41%	        8.57%			        30.47%
>>
>> Thanks,
>> Daniel
> 
> Hi Daniel,
> 
> cool, thx for testing it.
> 
> @Olek: how do we want to proceed on it? Are you still working on it or do you want me
> to send a regular patch for it?

Hi,

I had a small vacation, sorry. I'm starting working on it again today.

> 
> Regards,
> Lorenzo

Thanks,
Olek

