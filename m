Return-Path: <bpf+bounces-55660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BA1A84674
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 16:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C55416DC87
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 14:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DD128C5D2;
	Thu, 10 Apr 2025 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a4Fl5PT1"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A0337160;
	Thu, 10 Apr 2025 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295470; cv=fail; b=kzna4xvFaZtQGs0tn/Vx4Rbl+vsYxFLWNXdggXQ7uHXiJ6dOQKr5+y4XmzO1a+4xC5ALF4KMgdTH1O8ErBLDoBoWo5DDjSAu2nXS52iSZPbdNoampiCkvtTiX0b78uudvGFKobtXOGHfgL2FnoNlA67M/SrA8bLDQQtH9N8uGyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295470; c=relaxed/simple;
	bh=QPSSnG9s6ny4CsqmxXzRxbUJHU24bL9tftOUmLjje7U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=phMkfeCt543rtwjrdwDQf8mBJfbRiE670yphJoINplWG+no5Bw0hs8ZV2Z5BI8XA4ySWEz/CO3KlLaWW6lJcHvQTCB5dcFs6o2aFReJfdhLm81UhTRKH+4k6wht9YJtB5drBYl/VqXBUnWXptreQQ7VOI3cVffFyME03a1iItFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a4Fl5PT1; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744295469; x=1775831469;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QPSSnG9s6ny4CsqmxXzRxbUJHU24bL9tftOUmLjje7U=;
  b=a4Fl5PT1ZiVtstmSDGEWwBYFn8PNXBwZlODfuk82scnqrgG15dGJEnP4
   ZWR5GmIHPrRMUDm1BIVj+QPgJL2izZLFZNQzG8OfH+2T7wZGelUXMfxGp
   bQXfN++nLLDVjaO19WvHQBc66BqGR884/1CuPjbZyUcfgpFBDj6k9WBYj
   zG3yTEBXgo9pyuLcStoJhhZ9Y0YuHVzSbnXbIV8DRIF3x8bPTHDPJDzbf
   rQofTtU8TWIwnrh+nIwyRx7/CYHNBhY/PFB/95I2pL+tv3vIb1Op0sEfi
   jf41LVuJtnX1scJDimPUCJdXQfaQplzEOXUyUZbwX/4Kk+1T/giZZh/Zh
   A==;
X-CSE-ConnectionGUID: bSTzkijqQdaIy4dJOtwpNg==
X-CSE-MsgGUID: khVKMfXPSc2LwCEBMTOsyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56458030"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="56458030"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 07:31:07 -0700
X-CSE-ConnectionGUID: uSxuKT4TR7q0uIcI6h7auw==
X-CSE-MsgGUID: m3Ip2n9mTbSMUxw/TlfN8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="134033829"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 07:31:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 07:31:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 07:31:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 07:31:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGcove0C+xkaLwzH2KQ9LHu1B4yzMyuuutbZ3EZ6ph061DSg1sbeuqTYaoIeZg21XB/rlUZHNdTbtmEbOzbHLPXMz1RV1C94e2nCXt1MCpW4Ho35PsXZjoQJfx7ncM085fnADQ63tw2QCSesSt/EX8Tc6qglj4qXIJK0MtUjbbONa+3Dru1g4BUozE0GRQH+XD0C3lo3RzmdrVLHUaTBYhIit/bnWoL2HOIN1/FKPPofk7HZYddoKPrXN3G5tEa8erOfAgEiZEmWkKoUYy000rtsNpFVpz5XHAGFImak2PVFbGsJETET/Mur2NYM7gu2mqXyVQVgFua3BxUiVkne7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3Kd69JWMgkM/s6m93qr53wqAUJ7r5Y12hZBRWiMeN4=;
 b=MbBihQf5ZdjKutCBExbGySzaMUGM43s6hk3aGhLTzx2y6nK60tnBTNjaj5C3PO2ExQ8WEu/FxAhh24OwlWOFXIsMTXIi8tw7Ov6QYt8FN9f6oXHq2XOA5zUbNo3ZnuORoJPYgYk301xo1n99VcYPllmAbeXJxrSvT6x+0wXNHwq/xIgeNUoPdZEF3mVQtLD7g5nATeGw8m+aVyU4T5/TCUdQ9EjZYxzLEbXWqYhNj2vX3rWXWsFgSVYpz84JpJCdHRmH5OgOfB0YGK3liW+2MvykYdf133qHwIvtNf3qSxTgf+wElEYBj8+wni5LmnHE/TbVzfZ57VXS8ESiMH+LHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 PH7PR11MB7663.namprd11.prod.outlook.com (2603:10b6:510:27c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.29; Thu, 10 Apr 2025 14:31:02 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 14:31:01 +0000
Date: Thu, 10 Apr 2025 16:30:53 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Jay Vosburgh <jv@jvosburgh.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sdn@hetzner-cloud.de>
Subject: Re: [BUG] ixgbe: Detected Tx Unit Hang (XDP)
Message-ID: <Z/fWHYETBYQuCno5@localhost.localdomain>
References: <d33f0ab4-4dc4-49cd-bbd0-055f58dd6758@hetzner-cloud.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d33f0ab4-4dc4-49cd-bbd0-055f58dd6758@hetzner-cloud.de>
X-ClientProxiedBy: DUZPR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::17) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|PH7PR11MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c448054-fdd5-4861-202f-08dd783c50eb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vkArScg9rtyo6uTStYvX8mJKghHISnILqy5dvikYInlhgfrhrzX/UGmFIyT9?=
 =?us-ascii?Q?uvxXo3ggH6GWxFqn8QpO7+GPs4z9dxzjnUAEWAqW0HHaVted7RNNgQHWMENl?=
 =?us-ascii?Q?1j1H47apEq/5miaMFDlschMuUJ9kGBWApzKpwl5WEUZFf3eOtxUGeNzijwaJ?=
 =?us-ascii?Q?fgAgepxcoSG+V6goR/swaJuiwUAObnvGZcq2QyO40kL/O+eLqIHvlyKo9coq?=
 =?us-ascii?Q?fxhKDPg3qgv/oFd6HXc/fGGALVUH7VhIp8nSh23diZQfYTbmfaqRHPRYVDre?=
 =?us-ascii?Q?6MqcMqavXbnJtaG4aK9iRNOrGi/k4J/uU3ytX1onT5/ex9bRjHHH0tFKq+My?=
 =?us-ascii?Q?1dk1mMBsZaGS2o8HlmrdqsLLOXwBcVg9/BFlA6AooYbsFlsSzOVtUTPUB2W3?=
 =?us-ascii?Q?YXbByE4xvbj4ODaRP1Ta7jR0Q7J0t5L5FUeUhWDahGj7Ny/Z68B1EQKVOSGs?=
 =?us-ascii?Q?8PItghjfBUuoK/MGIaACxtVAGDG/PS6AVkNbJW7uIAan7a+Au5hCjjVaLvh8?=
 =?us-ascii?Q?MSo3T+8Ev7M1c/15uMmkWxFUEVdY/Vw6dUQmdj3F+IEt1cX7OQ6DmYoGzHWr?=
 =?us-ascii?Q?2GL4ULu8hYng654BqXna1+c6uBBWgTqZ0D/vbF74RFHyRQ+cg9J8Snw34whi?=
 =?us-ascii?Q?33hcUiZDzMDB8IyFPG8rNj3hUpgkgebERzLdcryvC4az6r4Q4DnuyOZUexKM?=
 =?us-ascii?Q?yE5DOfp1NJPUeoZB/w0pHqMEcuvts7g3roLKTUTYczikV3XNUHN4SslgiQm3?=
 =?us-ascii?Q?QPLwzdMmLDmdkEP+0ViF2d+Yqm2897oMkqt0Kyb6I5xbNmpLivIek7r2ToJt?=
 =?us-ascii?Q?RrvWD+OsGRbAnVlSjvnGRp3ZjZVeHGRbwEVaIAE2UxvVExLgo6y/Pau0uF9n?=
 =?us-ascii?Q?Hz8+0kGf2zpwE3KS0gkBC5f0NiUPnzOSq010BvRPvmebwMKMb+WB8AOawgsO?=
 =?us-ascii?Q?IWVtA0mgZ1p4EnGxzMHlbrAySmV4isU8r9Tqz8DY2qqUwz9FbjBvY/HB45um?=
 =?us-ascii?Q?Q6tpL7agnF95kjCVjUNR5pAeVacX2BxbLNScFdLIDPEuVpXqGg6QDaYUcRB4?=
 =?us-ascii?Q?xQoWwjR16DqCutVigrxDW7UuMAgvQbwzxwPtv3khmPDbowlWlazaEuKLz+ml?=
 =?us-ascii?Q?3e+yLTECL38TEOFCegzfrm7DWTkQKmyyL4u3V/2kR/iij8yJULJDK6rIZGnj?=
 =?us-ascii?Q?Ma6AB4F8T4q/F+BaQOHAgi8Kb77koW6XHeC2q6m/+eeDBXTJ30o/nYjph0IX?=
 =?us-ascii?Q?heYTdd1tI3mKoOzksaDWDPXEIyumubYhhaDht193x4LvKEgJLgBRlgs1zkRX?=
 =?us-ascii?Q?Bov5PgvbWVOZvyQcblrsDd+45GM3538W0wV7lVCf2W14Y+EpSSaPx45v0qlm?=
 =?us-ascii?Q?XiZBZCnV4BmOYd4eTPlPFLeIonzP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KWFlnUbIjt5W4atqeOKOs7RvEJjgUnJb0G58YGLrvhdhk1eyR6kUQ3HQzUtg?=
 =?us-ascii?Q?XqE+1SirdaFxT3p9/XoUsp2z3w+7Rc990yGLKKa1w4DrVuf2F4UzDMU2H36L?=
 =?us-ascii?Q?8cXumO/tW8g3NMZze43rcGkp2N4g+281XJ8KZp8zWin0Y9eU6mOM3Ac+KxAm?=
 =?us-ascii?Q?+aF+d8AwclKEg+aXzjI30LW3IgeBkKVpSW2Mvo2IefOagg4ZsxbNwHD2Tj0a?=
 =?us-ascii?Q?2YAW8mV3duu2Ls7pEfhDmswJ5QlCMQdiNrW7XoHmeG0jDIyrCvp9rFkwz81L?=
 =?us-ascii?Q?V3dU72S5ehyReEu8cM6JDZIoD/vkP5KB5+3NlVPgDrOfCRXqtj5xOekp4o2W?=
 =?us-ascii?Q?DrGFqf714LD9EHM5Ylbh8p5y74fVk34i+cL1JjbaiX0xP0CtMBkPHuLmgqR9?=
 =?us-ascii?Q?D0+CF0gGtwpmBPbz3DooQ0XIbvE7nbf+nn6jhmPCsUpuBPRRlFYEk/IOchZL?=
 =?us-ascii?Q?zFquaGASK1XFanOqqr0LhyAeY4mjLiFiDaup3gwmqfS64FrEkA5AHQk6/gG3?=
 =?us-ascii?Q?j9ABLwFJqDfa4kgCXanlWyLORtxi3vDBzRAGEAbcAYzoxXdCJJxFd8FdjyXo?=
 =?us-ascii?Q?BwRRBrnMoadetaMXuiW8VKY5wl+FnUdmBQfocxYFRDOktArbOy7/O9hJijce?=
 =?us-ascii?Q?qGlGyZ9f6XiN2qnHKXlT262IjZZxWPilFdVtHvf2jZMjsd//fCfOy5Uym2Jg?=
 =?us-ascii?Q?4Kk9V9jv1fDa2yyQSRwECb1HxMvoGlkpKiTkZ0ELpjxiX6/kVm4QsHh80rgu?=
 =?us-ascii?Q?BUiUEWlHTwcawDjis9WvCjfO53QVScTVK5xw+iNfWdZqQTnyGPimghqDWzL8?=
 =?us-ascii?Q?2mJIx2/KNaZKKnmfbpGHno3qiNUo/c3AFwynX5iw/19ZwHblk0EQ0DWoiy7E?=
 =?us-ascii?Q?Y39KgG4NThyWcPOcd8VixrSUF20MX43MD2U4pvxbkNDohrCRQEFRuBzVD/Pq?=
 =?us-ascii?Q?ir71QjrFXLP56Denfr90rN/ZgAkgU/+Sqi7wrkHP2Zaru6LanZCupUEiiQP+?=
 =?us-ascii?Q?ux2WuB3i5kGcbjVampeBaHnRGlnOcSJPvmfZcqXVHLp6S7JM6c72fhte2Rza?=
 =?us-ascii?Q?laJQ3g8ngH3CxPLI2D3C2VFhGPj2se+tfpjBPa5BSkfKIJscaksHgN561PUV?=
 =?us-ascii?Q?m06hU0pM/k7Ul+HO4u4EZEXdz/Uwf6lzeyWrwdDWIr/ZELmYFjHg8Tdib5Or?=
 =?us-ascii?Q?hr0EoIokrqz2X69x247rVnHHt7qx9cJ6BTC5VS5bEDvhZukTG0p679KZGyxx?=
 =?us-ascii?Q?r2hm0r8UyhCblaeMrx5vxbQ10Sl/g7dc1NaGs7e+mACiTfwTwJJh5geRWVQd?=
 =?us-ascii?Q?+LKHWcp5VjYr3CdsIUAzIeNDRq2ezN1EYTrOsoH0bsb++P05K2aTqhSAqyWV?=
 =?us-ascii?Q?jKlkpoTT4MQniTTn3Tm5WdoVh1sIjmr9iV11yTWBDATEtZGVJkhwzKLay/Dk?=
 =?us-ascii?Q?CXYnj03fLBatQf6Q0qEN11xhfqmPE5bDCfG4D8LTKDK9MTVYYACMwpRgdH5a?=
 =?us-ascii?Q?mUKRxAkYQwMpxQ1+cBY+TpDONjV8hkhm+5WmZKHD9sN3ksjUHbVNM4XLLVgZ?=
 =?us-ascii?Q?cGlxnNC7iIfzGra41Ef7EF/IxUgopUAglJU1t/BWM/6Od1AUvAhXv4KIWJfi?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c448054-fdd5-4861-202f-08dd783c50eb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 14:31:01.0060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QnWfSPio7b3rIWtSUmkHmDTtWLUbaD8truN7kl+gA7hEjtrnbMe3627+l8FiDiphP8bDCCu3HWFuQv7z5Mnyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7663
X-OriginatorOrg: intel.com

On Wed, Apr 09, 2025 at 05:17:49PM +0200, Marcus Wichelmann wrote:
> Hi,
> 
> in a setup where I use native XDP to redirect packets to a bonding interface
> that's backed by two ixgbe slaves, I noticed that the ixgbe driver constantly
> resets the NIC with the following kernel output:
> 
>   ixgbe 0000:01:00.1 ixgbe-x520-2: Detected Tx Unit Hang (XDP)
>     Tx Queue             <4>
>     TDH, TDT             <17e>, <17e>
>     next_to_use          <181>
>     next_to_clean        <17e>
>   tx_buffer_info[next_to_clean]
>     time_stamp           <0>
>     jiffies              <10025c380>
>   ixgbe 0000:01:00.1 ixgbe-x520-2: tx hang 19 detected on queue 4, resetting adapter
>   ixgbe 0000:01:00.1 ixgbe-x520-2: initiating reset due to tx timeout
>   ixgbe 0000:01:00.1 ixgbe-x520-2: Reset adapter
> 
> This only occurs in combination with a bonding interface and XDP, so I don't
> know if this is an issue with ixgbe or the bonding driver.
> I first discovered this with Linux 6.8.0-57, but kernel 6.14.0 and 6.15.0-rc1
> show the same issue.
> 
> 
> I managed to reproduce this bug in a lab environment. Here are some details
> about my setup and the steps to reproduce the bug:
> 
> NIC: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)
> 
> CPU: Ampere(R) Altra(R) Processor Q80-30 CPU @ 3.0GHz
>      Also reproduced on:
>      - Intel(R) Xeon(R) Gold 5218 CPU @ 2.30GHz
>      - Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz
> 
> Kernel: 6.15.0-rc1 (built from mainline)
> 
>   # ethtool -i ixgbe-x520-1
>   driver: ixgbe
>   version: 6.15.0-rc1
>   firmware-version: 0x00012b2c, 1.3429.0
>   expansion-rom-version: 
>   bus-info: 0000:01:00.0
>   supports-statistics: yes
>   supports-test: yes
>   supports-eeprom-access: yes
>   supports-register-dump: yes
>   supports-priv-flags: yes
> 
> The two ports of the NIC (named "ixgbe-x520-1" and "ixgbe-x520-2") are directly
> connected with each other using a DAC cable. Both ports are configured to be
> slaves of a bonding with mode balance-rr.
> Neither the direct connection of  both ports nor the round-robin bonding mode
> are a requirement to reproduce the issue. This setup just allows it to be easier
> reproduced in an isolated environment. The issue is also visible with a regular
> 802.3ad link aggregation with a switch on the other side.
> 
>   # modprobe bonding
>   # ip link set dev ixgbe-x520-1 down
>   # ip link set dev ixgbe-x520-2 down
>   # ip link add bond0 type bond mode balance-rr
>   # ip link set dev ixgbe-x520-1 master bond0
>   # ip link set dev ixgbe-x520-2 master bond0
>   # ip link set dev ixgbe-x520-1 up
>   # ip link set dev ixgbe-x520-2 up
>   # ip link set dev bond0 up
>         
>   # cat /proc/net/bonding/bond0
>   Ethernet Channel Bonding Driver: v6.15.0-rc1
> 
>   Bonding Mode: load balancing (round-robin)
>   MII Status: up
>   MII Polling Interval (ms): 0
>   Up Delay (ms): 0
>   Down Delay (ms): 0
>   Peer Notification Delay (ms): 0
> 
>   Slave Interface: ixgbe-x520-1
>   MII Status: up
>   Speed: 10000 Mbps
>   Duplex: full
>   Link Failure Count: 0
>   Permanent HW addr: 6c:b3:11:08:5c:3c
>   Slave queue ID: 0
> 
>   Slave Interface: ixgbe-x520-2
>   MII Status: up
>   Speed: 10000 Mbps
>   Duplex: full
>   Link Failure Count: 0
>   Permanent HW addr: 6c:b3:11:08:5c:3e
>   Slave queue ID: 0
> 
>   # ethtool -l ixgbe-x520-1
>   Channel parameters for ixgbe-x520-1:
>   Pre-set maximums:
>   RX:             n/a
>   TX:             n/a
>   Other:          1
>   Combined:       63
>   Current hardware settings:
>   RX:             n/a
>   TX:             n/a
>   Other:          1
>   Combined:       63
>   (same for ixgbe-x520-2)
> 
> In the following the xdp-tools from https://github.com/xdp-project/xdp-tools/
> are used.
> 
> Enable XDP on the bonding and make sure all received packets will be dropped:
>   # xdp-tools/xdp-bench/xdp-bench drop -e -i 1 bond0
> 
> Redirect a batch of packets to the bonding interface:
>   # xdp-tools/xdp-trafficgen/xdp-trafficgen udp --dst-mac <mac of bond0>
>     --src-port 5000 --dst-port 6000 --threads 16 --num-packets 1000000 bond0
> 
> Shortly after that (3-4 seconds), one or more "Detected Tx Unit Hang" errors
> (see above) will show up in the kernel log.
> 
> The high number of packets and thread count (--threads 16) is not required to
> trigger the issue but greatly improves the probability.
> 
> 
> Do you have any ideas what may be causing this issue or what I can do to
> diagnose this further?
> 
> Please let me know when I should provide any more information.
> 
> 
> Thanks!
> Marcus
> 

Hi Marcus,

Thank you for reporting this issue!
I have just successfully reproduced the problem on our lab machine. What
is interesting is that I do not seem to have to use a bonding interface
to get the "Tx timeout" that causes the adapter to reset.

I will try to debug the problem more closely and let you know of any
updates.

Thanks,
Michal

