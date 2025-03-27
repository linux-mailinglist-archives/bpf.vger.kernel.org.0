Return-Path: <bpf+bounces-54810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EDAA732C6
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 13:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1E0176E9A
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 12:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFF0214A8C;
	Thu, 27 Mar 2025 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qt9v4Xm5"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D02F79E1;
	Thu, 27 Mar 2025 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743080284; cv=fail; b=X6up9QD8WaYfwZHodvd4KBBKwvuPCx2fC7O0o8xqW90HOPIKFkGMaKye8myMjMReD0youQAiaFIpUWekf1+WKddu2T8VtwJUFGAARH9J96Y0G8NfYgfOIUWtS1y/kfNhteefJArj3JZ2w2+LxJNOfqluZFi5XAbOVd8MIocQN3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743080284; c=relaxed/simple;
	bh=GY80lWKMANsdwVY+gYRZmIsNoEnq01wgkUnqbPORhjs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ex/NWwVS3aMbBys0nRCAf06poSIK9TPYsVzm+LD6Un3qexWNw8+2OqqoNnQwQ3VCAh7be1WVu0aypTaIkpkcRUfn7jwG+CYUudh6kx6yDR1vA97nQIShwtUjd02+Y0ZxuL88ckdDA6C0kKsjQ38xsMPlye3J1QegsM6cdSvl710=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qt9v4Xm5; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743080283; x=1774616283;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=GY80lWKMANsdwVY+gYRZmIsNoEnq01wgkUnqbPORhjs=;
  b=Qt9v4Xm5fALZY+mNUGBEr2pij3vJbRG2Rci2iW3MGrIuxp0bOCLdfWwV
   qwkucrhDa94oXolF0/qkmt5nuJy5BBYt/+fJJfdRn452kEYZmxoUciydx
   MVJrPKYKbeudcUQBfo5XxTIfl0TTkski2V43c1ySkQnn/5caxOf+9yhQO
   AGF2vOC85mwQVzYhpKYHm9Wtw/ZpH1ct0aoXK965XUYYimAGCrhPR4vMX
   7iVm6by6+cE66TIxQ/rAgtytu2wGhUK87bmIxEwW8uLyrshpB8+mJErjq
   GazALqOO/CBrUcQbghj/Id9rfo9po+kkC3rVLCNm5OIqJDtGJyWH/b5og
   Q==;
X-CSE-ConnectionGUID: JCHNK9NlS6ewf1ZA/i0SBw==
X-CSE-MsgGUID: 0DjH9zNCQ/WDTLCM+d3EKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="48066946"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="48066946"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 05:58:02 -0700
X-CSE-ConnectionGUID: af/ZqnkWSO+H8fIHaezt+g==
X-CSE-MsgGUID: dkL9aQjHQvKDeCEfK+ivpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="124931258"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 05:58:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 05:58:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 05:58:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 05:57:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/04UUE/ahp6n5g0uTk63BiOD3jNxEedM585ZgYF79Sf0fF0wpUn5dMGuWVtHI8bGVJ0MiYMyHg+Eglmh0irx18e9/g2blf4OLQzOyYkTYNuG4CjiWIHlWloQdulnyPrsnXQOGeh1ayinQrvmrL3G7qy6BCHTpjydkQTqKU5Foqud/djhWCT5T6NigQ4+yy7L+h7237KHU0JB9F9Xp6jUH4TFgVmh0IaEdd2j8JLfXMgfM77yBbeuFR+KBQ6Uy4hdzg1mM3nYtdtJf1hRi4iNtTrI9nWv5UhewmP1GVg/H3oCpRD+Z9FBea8zfQzL5/MN4hOoKO2WQ7p90cK+lENcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZzVCTOq3JAkqnrG3tZx957cQHE4Nh6A9V0Iqx62qRY=;
 b=qWbCdCM2YV7KovEuWedBffnYkbirQ6XYLJag9PzwdG2qTSJoOaZjXUxqpt7caU1F0rpUOmTzBG5ctFh3ShbXtmciQXNEAyPYEZzVpdWad5F0kE0H6immAaWIYvNQuMQYxZOI/HGYxkdf5vd/8OaCDf/WBPyWEmj4gN7rVbi4Yt+dBZuAuUZNrT8Ex8UukhIlOSw3AuQ6O0Yv+qvCxXWUH22t5qvUtTIks5haaM7WlkhLRe9mvXUEegC/nANj2JlaSMSgnwr7Fx38tEjYd8AM7k9MmZtHpj2WZC5foJqmg6MlWvqXv6tm44cSiOgGvotPzPPgmJkW0XfNR/kxYx7LSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20)
 by CH3PR11MB8519.namprd11.prod.outlook.com (2603:10b6:610:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 12:57:57 +0000
Received: from CY5PR11MB6307.namprd11.prod.outlook.com
 ([fe80::1fa2:d2f9:5904:2a14]) by CY5PR11MB6307.namprd11.prod.outlook.com
 ([fe80::1fa2:d2f9:5904:2a14%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 12:57:57 +0000
Message-ID: <843919b7-9a2a-4365-aee8-204886e6b65f@intel.com>
Date: Thu, 27 Mar 2025 14:57:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v10 06/14] igc: use FIELD_PREP
 and GENMASK for existing TX packet buffer size
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Furong Xu
	<0x1207@gmail.com>, Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, Hariprasad Kelam
	<hkelam@marvell.com>, Xiaolei Wang <xiaolei.wang@windriver.com>, "Suraj
 Jaiswal" <quic_jsuraj@quicinc.com>, Kory Maincent
	<kory.maincent@bootlin.com>, Gal Pressman <gal@nvidia.com>, Jesper Nilsson
	<jesper.nilsson@axis.com>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, Chwee-Lin Choong
	<chwee.lin.choong@intel.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, Kunihiko Hayashi
	<hayashi.kunihiko@socionext.com>, Serge Semin <fancer.lancer@gmail.com>
References: <20250318030742.2567080-1-faizal.abdul.rahim@linux.intel.com>
 <20250318030742.2567080-7-faizal.abdul.rahim@linux.intel.com>
Content-Language: en-US
From: Mor Bar-Gabay <morx.bar.gabay@intel.com>
In-Reply-To: <20250318030742.2567080-7-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To CY5PR11MB6307.namprd11.prod.outlook.com
 (2603:10b6:930:21::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6307:EE_|CH3PR11MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cfe6659-125a-45b1-7e82-08dd6d2efec9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTNBaC9GSkZJNEpwMnY1RndoOHpJNjRDRytzVWlRQlJyK3g1WG5OM0JsQ3Av?=
 =?utf-8?B?eCtNM3ZFdVdVQmlyRlJNLzhXOTkwcXYwNkxpSW9lRXVMT3poUXl3OVF3UDlr?=
 =?utf-8?B?Y0Y0Y3dMMmNpT09ONVhNM3dNaVNUNmtPYzhJcXpKN2pRUmlmLzNuSTdtQ2F2?=
 =?utf-8?B?QkpTYWlYNDROby9qV21QNUFGN0FDQXFFN212YjA1b3RvVDVrT3JkWGF3Vjd1?=
 =?utf-8?B?aW5Cb0ZCTjM1eFhTWFliZkFZcXl4WjNwL0N5RU0rdHlRMXkwS1BlUnJ2dnJP?=
 =?utf-8?B?cE9uUVZlSE42ZGJpb2xDblYyczFPdlMxWmZsYnBzYjFvTXFEN242RUJvdjht?=
 =?utf-8?B?cmZ0SHJlMFlaU2V3aEo4T09Ga0xjMjBTSnVEYWtBKzRTWHYydjBrOGRuT3lG?=
 =?utf-8?B?aUhQVTZDVFlvUmFQajlTdlN5QjgrQnFzUmx2TjNyd1I1eTlQYnQwZWpQREpu?=
 =?utf-8?B?MWw4UlVMclNuNVFPTnZtVml6T05xZW5QajV5VElOaVlTRWkxakRXRG8xdDFU?=
 =?utf-8?B?K0tCODFZY2tmTWZybzhVdGFKck94QzAwdEdSSDZXOEJRMm5sVXAveHVQSnJU?=
 =?utf-8?B?c2Q2SVNPTzYraTVUWjFlcVg2NEtPRmNHdHpwMDZTQktZckJGbGxhWitvZm00?=
 =?utf-8?B?MlhudVJLMXIzZkNxai9OZW1IUDlValFNcDkycVV3dVlIbURpSUdNQ2RUVVk1?=
 =?utf-8?B?dXJRTU50WkppRmRWMjI1THNrUkxweGRPcGlJT0VLYUpEVG8yNHdiQjZZc2RJ?=
 =?utf-8?B?ZmNvVExJN1lNbnNwRldySTBpR2MvTzg5OTVFanh3R3ZFb2NqMHU5MTRMMjhS?=
 =?utf-8?B?WG9SKzlWSTFaek9sSmQveGgzamNxUUhOYjZJRW91NzUxRU1oL09CTkR0UWtY?=
 =?utf-8?B?Nk5nY2o5dW5VQ0JTVXd5Y3VPRkRDWkorckVxYWpVb3c5UktDWUFaZTA4NGpx?=
 =?utf-8?B?QzRxMEhWS2FhQmRhZlZtR3FmMzYzWnFONThrT1hPZ1cxTmJxeEhtRkpCS2lX?=
 =?utf-8?B?bVZKQ09PbHEyS2l0YjhTdGxFcGsxZk52K04xU1o1NjN6YnF0QkowR1NqSnlL?=
 =?utf-8?B?KzNFZXBiKzJGcWk3YmxyTWVOWm85Sklxb0I0NVBoQ3BRZXNIck9sbG1sQVpQ?=
 =?utf-8?B?QkcwTlZJVUxnNjg4dS9WdVpSNXJ0NHFJTG02ZDZwSFc5cmdCRFBYb3ZiTXBS?=
 =?utf-8?B?WHBFeHdUbXpxNDVUVjRoM1lrVmxqbWZ2TXVuTEFUUWRjV3UzSUpPTXN4ZzZh?=
 =?utf-8?B?VXdpOHVnNDRpU1krZFEwUVlRVElvaVJCV0dUdWcrZ1RUZmJPUzAzcVRaMUZG?=
 =?utf-8?B?ZzJkb1RJT05LWkZwREZZdC9idFBVdVNhSDNrdlZxV2Y4M2xDeWsxeC93cnc0?=
 =?utf-8?B?YlNoVmZNVW5XSWlOVytMQ0diWHdRRjlCVG1IdUtEdzB0WHB4NWhXOC8wYWFU?=
 =?utf-8?B?NU85Ylo0QTZrYnAwd0dYdkwzR08vRTJWN2tKcWJYT3Y5YWhoZ3YzUm9TZzQv?=
 =?utf-8?B?VVV5eVA3eXJ0RXh0eVA3b2J2R0FvQWJUSmxVWWZ5MlJ2SWRUTG5CNkZINTI1?=
 =?utf-8?B?bDV3Zjh2Y3lGOVpleGZPTC9nSFlnS2hkRk5VVlo2b21iY1pCSkVnVmNTYmdO?=
 =?utf-8?B?bDYrbFcwaVdOeGgweEFramhVbHBiVFhBTTQ2RE90bW5URlhISmp2clF3STZy?=
 =?utf-8?B?RU5xaFRQS1RJdjIyZnhVMmdCWnlpM1N5SndoWU40cnVNQVBNMFYvbXRuRTEy?=
 =?utf-8?B?SWp6V0NkK2h0UjJCWFlHSHE4ZGU2dG8zSXZsSDdDeWpxS3VRQStXS1RLMUVt?=
 =?utf-8?B?eTJKb2w4ZnYxVEY3MHI3L0dWdjRFeGx2YitIVGdzSE9tQmRYb295ekhUSXZ6?=
 =?utf-8?B?dE5xTWs4NkJ5U1lpYi8rSldRYTl3Nk5zTTVsdnFPSnZ2MmZJU0VKZzd5TkdB?=
 =?utf-8?Q?AwNXFabWiPo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6307.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWYvRzBiOERlWDBDVkN2ZGxmKzdaY3dPZ1N0U1k3Rk9DVGM1QlAzWkk1N0du?=
 =?utf-8?B?V3hYQ0NqS01iOWhUbGV5MzdTMmErdWs3RlR5MFF0YkFNWEdiSzdnYWl4Nnpi?=
 =?utf-8?B?aC9DVE55RkVRSGovS29JY1M3Wk5JOW5pMzFwUkJrdzZBQ1poSEJCeEovVkJC?=
 =?utf-8?B?bDdLMkQzVDBJZlZLYjZqY2xOWFVXNU1sNWhiK3FFc1R5TFdNNHlNTCtPV3hF?=
 =?utf-8?B?b1kvVUoxbUlzMGZ5aWwvemdzbnltdFhMZXRKZzZqdG9pMXpvZkFOeXlkRlQ2?=
 =?utf-8?B?eWZxVTA4bERSWVJGSWtEVDUzY2VheFlDTGxkV2JNd2VIZmx5MnRQekJlOXMw?=
 =?utf-8?B?aCsxcVk4NDZYcjNPL0U4ZkhxVjJYNDNMM0ZvUllaNXlZRzZWeVN2RDFWUVFw?=
 =?utf-8?B?a093NE5rYVM5YWRzaGhyNFU4ZGxpREttdUd6S2JaNExmREU1T1pTREI5Uk1W?=
 =?utf-8?B?cHdLZUJzSWxEZGsxTWRHTXBjaHlJSVU3Y2tVZUtUOHZoUyttRTArb1RZVGFp?=
 =?utf-8?B?alhKMFJrRlhSUmFFTGx1aEl4eGlrV3pycEZyT0ZIM3hFQTA1VVNPN3ZyOUNR?=
 =?utf-8?B?Y3RWUXoydnhMTHFkdFVodGRXK0c1S1lzVFYrRXlJV3pyK1hjUm1ISURnT29C?=
 =?utf-8?B?RERrcUVvUzNKSUkweFpTL210RWJQdC9pb3JJU2JIb1UxOFVXMTdIaytoUzNG?=
 =?utf-8?B?ajM0dzJKaExhdTJZemFxVXNmVU1XZkkzaHd5WkdWQTJGaWdMR1BrNXR1QzU4?=
 =?utf-8?B?Y3NWZENCVFdnelQ1MjB0VVJmMGxSWmlNRVpwUmgrK0k0N3JwR3graVJWMUlz?=
 =?utf-8?B?YnQxdWxubU9KTFdndkFLMk95RDNUVGhVbzBmNnZoN25qTk1mNG5KUU9MSXJl?=
 =?utf-8?B?UGRvNXd6WDdBclBLSHdJT1E3THM2MFg4dzFLYXY4NGdQSWpMU2J1akJaWXFz?=
 =?utf-8?B?NU9YREVRSTB4cStzbU5kamxDWUx3UHVYckgvSUNYd1RlUlRzbU5kQ1Q5dkRM?=
 =?utf-8?B?Zi9RM25LQlRyMC9POGZNVHJ1c25hZjI4eWJPNnFRaGNORmFuZmV5M1JlRUo2?=
 =?utf-8?B?YTFHT0pXNmRmNWs2RmVOcXV3VkowZlNTSE0zVkpNSmY1VzJHdXU1TmUzRHBa?=
 =?utf-8?B?UkNMa3JDbWlGMWZGNWw1cVl4WGhRZHFweUZqdlZ2RkREVVJNTnNPeXlhWnNO?=
 =?utf-8?B?bHR5eXcrcDdXeHlVd1d1NUxWUFVGN05vakVTWmFveGNISnJXSVh0aWVXdHFy?=
 =?utf-8?B?SVZBYU9ONzluMnVIS1FrT2JEWVQvL1pKS0gyVzVHaUYwdGtkdlpseFlUVlRm?=
 =?utf-8?B?SXJzdmpJUzhudzRPa21xRFBScG5uM1pzb25sK3ZQNi9mcEVMVDFsSTFqcXpS?=
 =?utf-8?B?YU4xSWJHMHdmU3A3WFhzTWhmLzVnYUhuSlFiSUVsWDBYTEwwenByZ2wyWTFp?=
 =?utf-8?B?cXBwZmhhMEpqd2l2c0JjM216WXNJeEpwTVFHdXpjUm1US1EzeGpzMGhFeE1X?=
 =?utf-8?B?V1Q1Y3ZpL2dwMkRsU0JRMEh3TENoZVdwbVQzcEp0UitGZUVENWlaSDVzOTlt?=
 =?utf-8?B?K092MnN6b0dsL211NytvcGZEN2JwK3lKUGx3NUoxWkU1K2xMZWthRjNvN1BT?=
 =?utf-8?B?ODdESmtPRFo1cDdPNVZJeW5kNjk2dTRkYU1BRFpKSTF3VHRPVkZIbWtFTmk4?=
 =?utf-8?B?cGE2M2l6bFp0L2dHUVljMVlmTk9xazU4UlQ0S21oMjNVenpvMW9OWTArTyty?=
 =?utf-8?B?RkxFa1M2U3A4OFNHTGtWeFdCa0I5V29HZUpjTlFYNlFQeDhHTzd1eWltU2R1?=
 =?utf-8?B?RzE4MzdSQjRBeGlURUpqak5Sb3ZydXMwQ0Z6V1FNcnNuWWZFRk5UOFV1cy93?=
 =?utf-8?B?eFVLZE9jR0VWa0N1aUZUOVduai83bDhjSC92alNLWDRONURWMGtWaDVRVmxi?=
 =?utf-8?B?cGc1Y1lGb0xLZGFjdHppMVBPSGw5VUV4blpxbWtFNW42aGNwU3lMMFpWZjVu?=
 =?utf-8?B?dlBhVzlHeWtKTVNzK1ptY2MzMkNScGI1N0twNWYxWVVLMCswYUdWR2VyKzJ1?=
 =?utf-8?B?TVNZZzl2bWM5a1gvT0svVDdmcUNjS0tsbVNCSGJBeFI3dklPb3Z2dFMwQkc4?=
 =?utf-8?B?bjdpbm1ZUGxlYlUreVpoZVpsZzJkUEQvTjI1SjJlQXkzUDhCenQ5MDFkd09o?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfe6659-125a-45b1-7e82-08dd6d2efec9
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6307.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 12:57:56.9641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbWkIC7MD6m6esYCKoWKAi4jbbkZtXlxCNJXW6+9/asQ4dNkKofCuNT+/suvShQYTSpls7J7rH2WfxlbQSziMBOPVPBypgJHOTZ0aIVfyZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8519
X-OriginatorOrg: intel.com

On 18/03/2025 5:07, Faizal Rahim wrote:
> In preparation for an upcoming patch that will modify the TX buffer size
> in  TSN mode, replace IGC_TXPBSIZE_TSN and IGC_TXPBSIZE_DEFAULT
> implementation with new macros that utilizes FIELD_PREP and GENMASK for
> clarity.
> 
> The newly introduced macros follow the naming from the i226 SW User Manual
> for easy reference.
> 
> I've tested IGC_TXPBSIZE_TSN and IGC_TXPBSIZE_DEFAULT before and after the
> refactoring, and their values remain unchanged.
> 
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_defines.h | 23 ++++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)
> 
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>

