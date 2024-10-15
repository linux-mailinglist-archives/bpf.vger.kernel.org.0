Return-Path: <bpf+bounces-42022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A5D99E955
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9208C1F2113F
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 12:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161811EBA19;
	Tue, 15 Oct 2024 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buS4uZBC"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D4E78276;
	Tue, 15 Oct 2024 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994560; cv=fail; b=QuTQzBkG7RsXZ1yn33zpXcP9a9DK5ug9JHJ72UTjVNqCmnyrOUlRvEM6yCZs9j9ek0jsRoUIvZVVi1U/u7kqQvaU6VNrrph7KJL7renl690pk9Dtvx7j8GdPXLsH3kP0DdS6JDLV8HLJ/7TAlWots2TLawmxCGwHOHWfRYqq/F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994560; c=relaxed/simple;
	bh=gVf98CKHxwFqLFfCzVhYvQlg5AusEiQwHxmSrtOCKDI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AM1lW7FGhlYVUE9Oof9TdXSrijN2ItRmCCllVA3m55dF7JcqqbY4CYM1iv0diIsRGTw7lIJWNv1sT/Ei5NSnS5sgG1sF9kdbr6u7B1Wb6S6dARSZf4T7eHSVgwkxm47+gB7Y1SiFZknbYWv1Pi/q28AXL8kmnq98ZRU1TUpBpWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buS4uZBC; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728994558; x=1760530558;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gVf98CKHxwFqLFfCzVhYvQlg5AusEiQwHxmSrtOCKDI=;
  b=buS4uZBCUIb74gwh4n+w3r4SKsvujw2SeHYpFs8Gl0qvB+5kMNYZjN6k
   Rkb+kMvbzuv5rp4K4W7ERLx/VowaMphf5iB+l6RldB5I7ZDBTKkwJkedF
   YZgY2XOJCD4Vyzp0YpCoF3kts7CPYs7HUQPQHw8PYp2MsXJfYK//fIFYJ
   Gfqh+mP7btKaUb4Gh3LwtBpag7tr6bu4PQJYzUqCso97AmzBH9HN5dgCA
   +//bsyYgIkaHIVny0CfW7Fv874we4UDcR7vIl95LDEEM6hg+NuZ66i9ie
   4Q54P/IVSfMqHbABmECwzaa1DrdSGNNmO090Q2Oc/Q/NBUDeRuxrXsX+A
   w==;
X-CSE-ConnectionGUID: faFxgnF4QmePEPALkmHjDw==
X-CSE-MsgGUID: LG2ALLr5ROGpjftyrqf19Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="32182784"
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="32182784"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 05:15:57 -0700
X-CSE-ConnectionGUID: i9rENB4iSAme1zO/KGjm6Q==
X-CSE-MsgGUID: QrbzLO60Rv6A261npTG28g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="77544896"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 05:15:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 05:15:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 05:15:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 05:15:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 05:15:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0TqOFxdsRsi3BB/UuEYRNEokcCvc9WDa+i5/emHXSqjv4uIIXpw30rrfrLA4mywyE4F3ijosSCJcgvoGV/8twOOkH7rCSkl1frnT2KQiHa26y0cb2zeIIAxLrAFdZCvK1+GtF95dx3xxLMhFXUq7/CF1D4tBNXHlpkZwzNGJofWIiSpXKsYG13bN8XKBwF6xFkSovniSKSNTtOD4G9s/DHvlBFvL74YU7vej0WDQuDYA0KfMv02VwCudGW/77ZdVNMjQQDJbf+YrM8TRngWoWY2N61yxWDiSHUPABqHaBkFJRGoeZMOIKpXS0q3CBDzsI9RxNl5o8BiFTG2H4X6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Br5iTHXY6M6/pcus1JsP+xVdb+Ul981oh4NDY+XAFUM=;
 b=S+qM/RaDQE26zaODylmGsLaNUoG+Eaz9NenYw2SrrdgEOiXPxRbTv7xEa94rnzVID8AnW+e4eNKlJRrgMSAJeLXPP8RZfuf8hAKrmZfyRu2VRvGS/wirm/7wAIPCFZSbjlpAc3vCob7J14v4z+lhWmny3ACKbfVn23uJRe1lOUoNJd0vm76+Uxd1nPUc0TKjkmH0yOp569cGkK2ZtPzRyH1nwJsk1mpZ033ZRkOjFLegFApZ/a0MDK3SI+E3h1j5wuO4cjazAMu8WBx01ZIkoWV1cbiTrbz6C38s+6n223C10IFJrZo+YItlbhCJpyqc1KU8RA8afFtKMtxw7kzFJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.26; Tue, 15 Oct 2024 12:15:53 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 12:15:53 +0000
Date: Tue, 15 Oct 2024 14:15:39 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Richard Cochran
	<richardcochran@gmail.com>, Sriram Yagnaraman
	<sriram.yagnaraman@ericsson.com>, Benjamin Steinke
	<benjamin.steinke@woks-audio.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Sriram Yagnaraman
	<sriram.yagnaraman@est.tech>
Subject: Re: [PATCH iwl-next v8 5/6] igb: Add AF_XDP zero-copy Rx support
Message-ID: <Zw5c6/1bGuoJIy2S@boxer>
References: <20241011-b4-igb_zero_copy-v8-0-83862f726a9e@linutronix.de>
 <20241011-b4-igb_zero_copy-v8-5-83862f726a9e@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241011-b4-igb_zero_copy-v8-5-83862f726a9e@linutronix.de>
X-ClientProxiedBy: ZR2P278CA0079.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e35a289-fa8a-4d7c-dd72-08dced131d18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Rcf90oO+/zeESCmCoY1oUNZRMjbB4Y5Hr92KugaExk5ag3yJ2TnBc/fc7VK1?=
 =?us-ascii?Q?pZten+er8AOj+bgduxdX2IewvDlM2ErP5XhgEJ/5cqsc2PzybQcSQU2lsrKV?=
 =?us-ascii?Q?lGlUJ0J1gRDOWsuCjVBZRxYWpo+LUe0s3SkV2DojmbEwxHqnmLtSjv8AXHpo?=
 =?us-ascii?Q?FX0Os81jsHZ9BC7E/15fQjxyrmzSFfwS6J3B0NkIeoIPW1u8pI8WtSYB/Y0N?=
 =?us-ascii?Q?R/Cj+bo5b1rw4vLxJftfyYg5fSKwAwnhKrwk9MY7gW8LArf9SymMm0gZU6Dg?=
 =?us-ascii?Q?DfHQgLIR3Bz5e18wU7OnkLOSlHL1tCS3KnPVpaYhPbHob0CIzM1PLYnR813v?=
 =?us-ascii?Q?o0YQ3M22NcUGNvL0TXLI0c1s2bDL9Yn4t2WXllsh3ovFIzVoiXmXOrk+fruC?=
 =?us-ascii?Q?XXOr1Zca4jUKIfx0KIqQX2TohJ7skU0knPWwEf0UmuXC9bZTl8RoSZvW0+Zw?=
 =?us-ascii?Q?qiVGB9gW6Zw6Phyr1iqSRErI0acXcF/VXuvcPYi0sZhgxkx79yHPIeow5Dy6?=
 =?us-ascii?Q?LqwGzJxjc4pCc+5NXZkNHjv2qjNmUR/xupAcQncK5bJV4bHlfGdYStegiseR?=
 =?us-ascii?Q?CljgSdOPIijzez7Ij6wSlOalNy4LPD4yDVs7JBEzjaiEI78RetJnRzXnQeZC?=
 =?us-ascii?Q?14/I+FzNpBikrI8IvfqLfMKFDYqRozvuPztlIykDP5XQxyJN4rH120pgMIAj?=
 =?us-ascii?Q?gx0VVwMBbRm8sJlmzfsYMMyetneoIdKOr+wzl/XrfIB+I+pHiGUy/P7HAomr?=
 =?us-ascii?Q?iieSl/U58dHwhGbEnDQ92N5JdIwrWtVzP2YfxBPgxsvUxmP7cI+s2wKs/aDu?=
 =?us-ascii?Q?d2W056p0U/iwkcrAoy3GOtwzPFe2wAipY0ISN0ipoE3Wm7MzN1jQ9aAac7Oj?=
 =?us-ascii?Q?yx2WXWnfgU/aecmk1YOW/1f6MY1hyE4R6KEzRLNhCNZ09Xo24/DBqqfijBJ8?=
 =?us-ascii?Q?fVS+io9hfw1jX7n7RAinndr+sodzxxM9PhCM0AR+i+kbHgZ5a4D6EY2UyW+Z?=
 =?us-ascii?Q?VWPm02t5lv2dQoBDcLsFagGOEDirY/teWt0x5vI9RJF8dr7uVoJJCWPjG6Oc?=
 =?us-ascii?Q?4N/at+B3egTfKiz5oHgCQIpCup5DywCcHbEHVbGyQhfcEViMvz5cEKV7RZQw?=
 =?us-ascii?Q?XTqwo0eLo7rPI2jo/ZxdrbGlZ/TuYVBX9fVRrTdXkp1Tcr4qBup9q9nw5PC5?=
 =?us-ascii?Q?2qwGIWgxCvTw8V5Mj3FQNhgE0xq/2dn2KT/+E1qBrkZLZdOJAwI0HP4A4mDX?=
 =?us-ascii?Q?SRChCFIHz58FPJTUxTDFakUDeEsFEbVLx29Qg94LIQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HhihpZqaovKzKWhYbjPTviMb1FoGtgvs0GGtCKi9Wu5VLfjlTOfP3jMz4lFj?=
 =?us-ascii?Q?7XzqlwPUtPNJ69QE1rbAF3iX1CNtaDYYxYNoemZudyrTPY+N5QcKEvOGJqAD?=
 =?us-ascii?Q?+UypSmpgXqXRHmDY43EhJe0UkUzu5BFgNJP+lRz8HQJgkLapbr7D64YbQ2Fz?=
 =?us-ascii?Q?jbxP4Us6yBVfC/tpZ0jxqbGfUk7Mdv/sugZZIvbzdjojNH4AFYXll5xIkXD3?=
 =?us-ascii?Q?clLRq7JBToGxG7NgB3+hVntohgSenc5RyLDK0roVIcmCW2so2Y5DW9CVGEFK?=
 =?us-ascii?Q?9KuZzWkMjeSDZ5hSVU/EDVA3WFX3xwc8mEVzH/j2wm6BpfAYFXX0mvSP20y8?=
 =?us-ascii?Q?SX2sen7fHT/r7qvIclURJlHfXcNN+Vx5FBmbIvPwxLVTywp7gYYvG0IMBmJ5?=
 =?us-ascii?Q?WhgcvQSsUl5756qJ0HW40D0s/qBAzD+mafmdgUGZLI8X1dDIi/yjoefQ51f+?=
 =?us-ascii?Q?G3SlPHgFhPUJIcnm+MkKrRLUwBTNjFIeWXVMrzCk+l2zNfdoHn9UIQjs1s4s?=
 =?us-ascii?Q?guqdVG3RUx6Jacv+DAJgmE34yVpE+MBUmhYRlXbhQ56u4uWQCT6GnThZO4KD?=
 =?us-ascii?Q?8QRN1UM8uHsB2PWmZL7fe4XNZ49jn7cO9LMrTLdfCE4K4IQHtSGyFkTuWCR5?=
 =?us-ascii?Q?L4KNc5jPHTWmcF3M2P0ScoahrDAvPMfcpPOVb2uN3A8Znfp3aj5SsxqZbXkd?=
 =?us-ascii?Q?ulXnfgBDlJpK7LNEagqRBCoCZHUTk9CE3sOMh+yPWWe0s80ZAs6RM6fbP4wF?=
 =?us-ascii?Q?VEF1nfAvWS6iOxoTsJihbXuH45SBpt8M5o4JFpEPs5PWlBIOCkHqZzztnEES?=
 =?us-ascii?Q?4QpX1av82xsZVTNPWP/MwCNNpGeF8f2sMqbQ2DQBDphgHnDDW0MhpHd495E+?=
 =?us-ascii?Q?pi+PsN5CbbL/4zTU5ou+MmPa+d0v4TClAa73MHZcGt8hSwEYHPDYPADFHApB?=
 =?us-ascii?Q?knWrwIHtfh7qG05F4gXWbXrNckxSgjKHW4l9tah5eW9q9cZ5xI++++k135Fe?=
 =?us-ascii?Q?6cRHM6VLxw1tlOz+dQ1aGM0ddh1+J9smkVz8F4u+W9ZZSeeSuESkLjyqtcr6?=
 =?us-ascii?Q?znOXTlOsJePASXe87cbVlle+Vubu/5mq8eh7iozyfmIVwmOoDz6HoXy6VCBY?=
 =?us-ascii?Q?NXS1DeMDSSJBHVCWqbCQY6tXEokd+PDwSaqYbp8C8GPKAXW7FYAqWyLuAIJC?=
 =?us-ascii?Q?M2fUlnwKNu94HYA1PP98aTWVQbNNt7I3fK1siQXY+FxppBLR811t9JkTS29Z?=
 =?us-ascii?Q?2tNlpbu66NPrvV75EdobJqQz/i1imcAtY7wMxn4i/DWi2x1337uLLt4ClYjB?=
 =?us-ascii?Q?7URcvC1rbnJaRarjc7CNDTngp/iBzp4WeMrsDewtxp6+6pmRlUEiilPJ463W?=
 =?us-ascii?Q?5No+04gM9zcpDjSIRcSkPlHXUpvrLX8rcvdWS/P3l0zJRxz8wq/zSxbPzG32?=
 =?us-ascii?Q?G7K/m7v+FyHXYJCCPahVEnIV7EfugrHIDHCjfip9kWILTd/z1GDe5q22fGbj?=
 =?us-ascii?Q?fBen49fl0Tdj4RP1z+Mr40XwQEHPIIOD2deofZxR1K8u/vfW+3+v3CfClvNQ?=
 =?us-ascii?Q?oe/tLnV2wOVrFvvg4CO8BAReQPQUCAS1jSdJUse0BeI0UyvSWdo7G95nxqty?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e35a289-fa8a-4d7c-dd72-08dced131d18
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 12:15:53.0311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qj//Qr2wxrmiJoX3MKl4/4T2wTTIbXA2LFcHAKl3kXHRu42O/K/VBuFl9edJAs96XdEYQYbGNvlo+SG8k2BchnNoFiVu2gIptvUo0+zMLgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7481
X-OriginatorOrg: intel.com

On Fri, Oct 11, 2024 at 11:01:03AM +0200, Kurt Kanzenbach wrote:
> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> 
> Add support for AF_XDP zero-copy receive path.
> 
> When AF_XDP zero-copy is enabled, the rx buffers are allocated from the
> xsk buff pool using igb_alloc_rx_buffers_zc().
> 
> Use xsk_pool_get_rx_frame_size() to set SRRCTL rx buf size when zero-copy
> is enabled.
> 
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> [Kurt: Port to v6.12 and provide napi_id for xdp_rxq_info_reg(),
>        RCT, remove NETDEV_XDP_ACT_XSK_ZEROCOPY, update NTC handling,
>        READ_ONCE() xsk_pool, likelyfy for XDP_REDIRECT case]
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/igb/igb.h      |   6 +
>  drivers/net/ethernet/intel/igb/igb_main.c |  79 ++++++--
>  drivers/net/ethernet/intel/igb/igb_xsk.c  | 298 +++++++++++++++++++++++++++++-
>  3 files changed, 364 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index 1e65b41a48d8..e4a85867aa18 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -88,6 +88,7 @@ struct igb_adapter;
>  #define IGB_XDP_CONSUMED	BIT(0)
>  #define IGB_XDP_TX		BIT(1)
>  #define IGB_XDP_REDIR		BIT(2)
> +#define IGB_XDP_EXIT		BIT(3)
>  
>  struct vf_data_storage {
>  	unsigned char vf_mac_addresses[ETH_ALEN];
> @@ -853,6 +854,11 @@ struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
>  int igb_xsk_pool_setup(struct igb_adapter *adapter,
>  		       struct xsk_buff_pool *pool,
>  		       u16 qid);
> +bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring,
> +			     struct xsk_buff_pool *xsk_pool, u16 count);
> +void igb_clean_rx_ring_zc(struct igb_ring *rx_ring);
> +int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
> +			struct xsk_buff_pool *xsk_pool, const int budget);
>  int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags);
>  
>  #endif /* _IGB_H_ */
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 4d3aed6cd848..711b60cab594 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -472,12 +472,17 @@ static void igb_dump(struct igb_adapter *adapter)
>  
>  		for (i = 0; i < rx_ring->count; i++) {
>  			const char *next_desc;
> -			struct igb_rx_buffer *buffer_info;
> -			buffer_info = &rx_ring->rx_buffer_info[i];
> +			dma_addr_t dma = (dma_addr_t)0;
> +			struct igb_rx_buffer *buffer_info = NULL;
>  			rx_desc = IGB_RX_DESC(rx_ring, i);
>  			u0 = (struct my_u0 *)rx_desc;
>  			staterr = le32_to_cpu(rx_desc->wb.upper.status_error);
>  
> +			if (!rx_ring->xsk_pool) {
> +				buffer_info = &rx_ring->rx_buffer_info[i];
> +				dma = buffer_info->dma;
> +			}
> +
>  			if (i == rx_ring->next_to_use)
>  				next_desc = " NTU";
>  			else if (i == rx_ring->next_to_clean)
> @@ -497,11 +502,11 @@ static void igb_dump(struct igb_adapter *adapter)
>  					"R  ", i,
>  					le64_to_cpu(u0->a),
>  					le64_to_cpu(u0->b),
> -					(u64)buffer_info->dma,
> +					(u64)dma,
>  					next_desc);
>  
>  				if (netif_msg_pktdata(adapter) &&
> -				    buffer_info->dma && buffer_info->page) {
> +				    buffer_info && dma && buffer_info->page) {
>  					print_hex_dump(KERN_INFO, "",
>  					  DUMP_PREFIX_ADDRESS,
>  					  16, 1,
> @@ -1983,7 +1988,11 @@ static void igb_configure(struct igb_adapter *adapter)
>  	 */
>  	for (i = 0; i < adapter->num_rx_queues; i++) {
>  		struct igb_ring *ring = adapter->rx_ring[i];
> -		igb_alloc_rx_buffers(ring, igb_desc_unused(ring));
> +		if (ring->xsk_pool)
> +			igb_alloc_rx_buffers_zc(ring, ring->xsk_pool,
> +						igb_desc_unused(ring));
> +		else
> +			igb_alloc_rx_buffers(ring, igb_desc_unused(ring));
>  	}
>  }
>  
> @@ -4405,7 +4414,8 @@ int igb_setup_rx_resources(struct igb_ring *rx_ring)
>  	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
>  		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
>  	res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
> -			       rx_ring->queue_index, 0);
> +			       rx_ring->queue_index,
> +			       rx_ring->q_vector->napi.napi_id);
>  	if (res < 0) {
>  		dev_err(dev, "Failed to register xdp_rxq index %u\n",
>  			rx_ring->queue_index);
> @@ -4701,12 +4711,17 @@ void igb_setup_srrctl(struct igb_adapter *adapter, struct igb_ring *ring)
>  	struct e1000_hw *hw = &adapter->hw;
>  	int reg_idx = ring->reg_idx;
>  	u32 srrctl = 0;
> +	u32 buf_size;
>  
> -	srrctl = IGB_RX_HDR_LEN << E1000_SRRCTL_BSIZEHDRSIZE_SHIFT;
> -	if (ring_uses_large_buffer(ring))
> -		srrctl |= IGB_RXBUFFER_3072 >> E1000_SRRCTL_BSIZEPKT_SHIFT;
> +	if (ring->xsk_pool)
> +		buf_size = xsk_pool_get_rx_frame_size(ring->xsk_pool);
> +	else if (ring_uses_large_buffer(ring))
> +		buf_size = IGB_RXBUFFER_3072;
>  	else
> -		srrctl |= IGB_RXBUFFER_2048 >> E1000_SRRCTL_BSIZEPKT_SHIFT;
> +		buf_size = IGB_RXBUFFER_2048;
> +
> +	srrctl = IGB_RX_HDR_LEN << E1000_SRRCTL_BSIZEHDRSIZE_SHIFT;
> +	srrctl |= buf_size >> E1000_SRRCTL_BSIZEPKT_SHIFT;
>  	srrctl |= E1000_SRRCTL_DESCTYPE_ADV_ONEBUF;
>  	if (hw->mac.type >= e1000_82580)
>  		srrctl |= E1000_SRRCTL_TIMESTAMP;
> @@ -4738,9 +4753,17 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
>  	u32 rxdctl = 0;
>  
>  	xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
> -	WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
> -					   MEM_TYPE_PAGE_SHARED, NULL));
>  	WRITE_ONCE(ring->xsk_pool, igb_xsk_pool(adapter, ring));
> +	if (ring->xsk_pool) {
> +		WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
> +						   MEM_TYPE_XSK_BUFF_POOL,
> +						   NULL));
> +		xsk_pool_set_rxq_info(ring->xsk_pool, &ring->xdp_rxq);
> +	} else {
> +		WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
> +						   MEM_TYPE_PAGE_SHARED,
> +						   NULL));
> +	}
>  
>  	/* disable the queue */
>  	wr32(E1000_RXDCTL(reg_idx), 0);
> @@ -4767,9 +4790,12 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
>  	rxdctl |= IGB_RX_HTHRESH << 8;
>  	rxdctl |= IGB_RX_WTHRESH << 16;
>  
> -	/* initialize rx_buffer_info */
> -	memset(ring->rx_buffer_info, 0,
> -	       sizeof(struct igb_rx_buffer) * ring->count);
> +	if (ring->xsk_pool)
> +		memset(ring->rx_buffer_info_zc, 0,
> +		       sizeof(*ring->rx_buffer_info_zc) * ring->count);
> +	else
> +		memset(ring->rx_buffer_info, 0,
> +		       sizeof(*ring->rx_buffer_info) * ring->count);
>  
>  	/* initialize Rx descriptor 0 */
>  	rx_desc = IGB_RX_DESC(ring, 0);
> @@ -4957,8 +4983,13 @@ void igb_free_rx_resources(struct igb_ring *rx_ring)
>  
>  	rx_ring->xdp_prog = NULL;
>  	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
> -	vfree(rx_ring->rx_buffer_info);
> -	rx_ring->rx_buffer_info = NULL;
> +	if (rx_ring->xsk_pool) {
> +		vfree(rx_ring->rx_buffer_info_zc);
> +		rx_ring->rx_buffer_info_zc = NULL;
> +	} else {
> +		vfree(rx_ring->rx_buffer_info);
> +		rx_ring->rx_buffer_info = NULL;
> +	}
>  
>  	/* if not set, then don't free */
>  	if (!rx_ring->desc)
> @@ -4996,6 +5027,11 @@ void igb_clean_rx_ring(struct igb_ring *rx_ring)
>  	dev_kfree_skb(rx_ring->skb);
>  	rx_ring->skb = NULL;
>  
> +	if (rx_ring->xsk_pool) {
> +		igb_clean_rx_ring_zc(rx_ring);
> +		goto skip_for_xsk;
> +	}
> +
>  	/* Free all the Rx ring sk_buffs */
>  	while (i != rx_ring->next_to_alloc) {
>  		struct igb_rx_buffer *buffer_info = &rx_ring->rx_buffer_info[i];
> @@ -5023,6 +5059,7 @@ void igb_clean_rx_ring(struct igb_ring *rx_ring)
>  			i = 0;
>  	}
>  
> +skip_for_xsk:
>  	rx_ring->next_to_alloc = 0;
>  	rx_ring->next_to_clean = 0;
>  	rx_ring->next_to_use = 0;
> @@ -8177,6 +8214,7 @@ static int igb_poll(struct napi_struct *napi, int budget)
>  	struct igb_q_vector *q_vector = container_of(napi,
>  						     struct igb_q_vector,
>  						     napi);
> +	struct xsk_buff_pool *xsk_pool;
>  	bool clean_complete = true;
>  	int work_done = 0;
>  
> @@ -8188,7 +8226,12 @@ static int igb_poll(struct napi_struct *napi, int budget)
>  		clean_complete = igb_clean_tx_irq(q_vector, budget);
>  
>  	if (q_vector->rx.ring) {
> -		int cleaned = igb_clean_rx_irq(q_vector, budget);
> +		int cleaned;
> +
> +		xsk_pool = READ_ONCE(q_vector->rx.ring->xsk_pool);
> +		cleaned = xsk_pool ?
> +			igb_clean_rx_irq_zc(q_vector, xsk_pool, budget) :
> +			igb_clean_rx_irq(q_vector, budget);
>  
>  		work_done += cleaned;
>  		if (cleaned >= budget)
> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index 7b632be3e7e3..22d234db0fab 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -70,7 +70,11 @@ static void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
>  	 * at least 1 descriptor unused to make sure
>  	 * next_to_use != next_to_clean
>  	 */
> -	igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
> +	if (rx_ring->xsk_pool)
> +		igb_alloc_rx_buffers_zc(rx_ring, rx_ring->xsk_pool,
> +					igb_desc_unused(rx_ring));
> +	else
> +		igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
>  
>  	/* Rx/Tx share the same napi context. */
>  	napi_enable(&rx_ring->q_vector->napi);
> @@ -169,6 +173,298 @@ int igb_xsk_pool_setup(struct igb_adapter *adapter,
>  		igb_xsk_pool_disable(adapter, qid);
>  }
>  
> +static u16 igb_fill_rx_descs(struct xsk_buff_pool *pool, struct xdp_buff **xdp,
> +			     union e1000_adv_rx_desc *rx_desc, u16 count)
> +{
> +	dma_addr_t dma;
> +	u16 buffs;
> +	int i;
> +
> +	/* nothing to do */
> +	if (!count)
> +		return 0;
> +
> +	buffs = xsk_buff_alloc_batch(pool, xdp, count);
> +	for (i = 0; i < buffs; i++) {
> +		dma = xsk_buff_xdp_get_dma(*xdp);
> +		rx_desc->read.pkt_addr = cpu_to_le64(dma);
> +		rx_desc->wb.upper.length = 0;
> +
> +		rx_desc++;
> +		xdp++;
> +	}
> +
> +	return buffs;
> +}
> +
> +bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring,
> +			     struct xsk_buff_pool *xsk_pool, u16 count)
> +{
> +	u32 nb_buffs_extra = 0, nb_buffs = 0;
> +	union e1000_adv_rx_desc *rx_desc;
> +	u16 ntu = rx_ring->next_to_use;
> +	u16 total_count = count;
> +	struct xdp_buff **xdp;
> +
> +	rx_desc = IGB_RX_DESC(rx_ring, ntu);
> +	xdp = &rx_ring->rx_buffer_info_zc[ntu];
> +
> +	if (ntu + count >= rx_ring->count) {
> +		nb_buffs_extra = igb_fill_rx_descs(xsk_pool, xdp, rx_desc,
> +						   rx_ring->count - ntu);
> +		if (nb_buffs_extra != rx_ring->count - ntu) {
> +			ntu += nb_buffs_extra;
> +			goto exit;
> +		}
> +		rx_desc = IGB_RX_DESC(rx_ring, 0);
> +		xdp = rx_ring->rx_buffer_info_zc;
> +		ntu = 0;
> +		count -= nb_buffs_extra;
> +	}
> +
> +	nb_buffs = igb_fill_rx_descs(xsk_pool, xdp, rx_desc, count);
> +	ntu += nb_buffs;
> +	if (ntu == rx_ring->count)
> +		ntu = 0;
> +
> +	/* clear the length for the next_to_use descriptor */
> +	rx_desc = IGB_RX_DESC(rx_ring, ntu);
> +	rx_desc->wb.upper.length = 0;
> +
> +exit:
> +	if (rx_ring->next_to_use != ntu) {
> +		rx_ring->next_to_use = ntu;
> +
> +		/* Force memory writes to complete before letting h/w
> +		 * know there are new descriptors to fetch.  (Only
> +		 * applicable for weak-ordered memory model archs,
> +		 * such as IA-64).
> +		 */
> +		wmb();
> +		writel(ntu, rx_ring->tail);
> +	}
> +
> +	return total_count == (nb_buffs + nb_buffs_extra);
> +}
> +
> +void igb_clean_rx_ring_zc(struct igb_ring *rx_ring)
> +{
> +	u16 ntc = rx_ring->next_to_clean;
> +	u16 ntu = rx_ring->next_to_use;
> +
> +	while (ntc != ntu) {
> +		struct xdp_buff *xdp = rx_ring->rx_buffer_info_zc[ntc];
> +
> +		xsk_buff_free(xdp);
> +		ntc++;
> +		if (ntc >= rx_ring->count)
> +			ntc = 0;
> +	}
> +}
> +
> +static struct sk_buff *igb_construct_skb_zc(struct igb_ring *rx_ring,
> +					    struct xdp_buff *xdp,
> +					    ktime_t timestamp)
> +{
> +	unsigned int totalsize = xdp->data_end - xdp->data_meta;
> +	unsigned int metasize = xdp->data - xdp->data_meta;
> +	struct sk_buff *skb;
> +
> +	net_prefetch(xdp->data_meta);
> +
> +	/* allocate a skb to store the frags */
> +	skb = napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
> +	if (unlikely(!skb))
> +		return NULL;
> +
> +	if (timestamp)
> +		skb_hwtstamps(skb)->hwtstamp = timestamp;
> +
> +	memcpy(__skb_put(skb, totalsize), xdp->data_meta,
> +	       ALIGN(totalsize, sizeof(long)));
> +
> +	if (metasize) {
> +		skb_metadata_set(skb, metasize);
> +		__skb_pull(skb, metasize);
> +	}
> +
> +	return skb;
> +}
> +
> +static struct sk_buff *igb_run_xdp_zc(struct igb_adapter *adapter,
> +				      struct igb_ring *rx_ring,
> +				      struct xdp_buff *xdp,
> +				      struct xsk_buff_pool *xsk_pool,
> +				      struct bpf_prog *xdp_prog)
> +{
> +	int err, result = IGB_XDP_PASS;
> +	u32 act;
> +
> +	prefetchw(xdp->data_hard_start); /* xdp_frame write */
> +
> +	act = bpf_prog_run_xdp(xdp_prog, xdp);
> +
> +	if (likely(act == XDP_REDIRECT)) {
> +		err = xdp_do_redirect(adapter->netdev, xdp, xdp_prog);
> +		if (!err) {
> +			result = IGB_XDP_REDIR;
> +			goto xdp_out;
> +		}
> +
> +		if (xsk_uses_need_wakeup(xsk_pool) &&
> +		    err == -ENOBUFS)
> +			result = IGB_XDP_EXIT;
> +		else
> +			result = IGB_XDP_CONSUMED;
> +		goto out_failure;
> +	}
> +
> +	switch (act) {
> +	case XDP_PASS:
> +		break;
> +	case XDP_TX:
> +		result = igb_xdp_xmit_back(adapter, xdp);
> +		if (result == IGB_XDP_CONSUMED)
> +			goto out_failure;
> +		break;
> +	default:
> +		bpf_warn_invalid_xdp_action(adapter->netdev, xdp_prog, act);
> +		fallthrough;
> +	case XDP_ABORTED:
> +out_failure:
> +		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
> +		fallthrough;
> +	case XDP_DROP:
> +		result = IGB_XDP_CONSUMED;
> +		break;
> +	}
> +xdp_out:
> +	return ERR_PTR(-result);
> +}
> +
> +int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
> +			struct xsk_buff_pool *xsk_pool, const int budget)
> +{
> +	struct igb_adapter *adapter = q_vector->adapter;
> +	unsigned int total_bytes = 0, total_packets = 0;
> +	struct igb_ring *rx_ring = q_vector->rx.ring;
> +	u32 ntc = rx_ring->next_to_clean;
> +	struct bpf_prog *xdp_prog;
> +	unsigned int xdp_xmit = 0;
> +	bool failure = false;
> +	u16 entries_to_alloc;
> +	struct sk_buff *skb;
> +
> +	/* xdp_prog cannot be NULL in the ZC path */
> +	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
> +
> +	while (likely(total_packets < budget)) {
> +		union e1000_adv_rx_desc *rx_desc;
> +		ktime_t timestamp = 0;
> +		struct xdp_buff *xdp;
> +		unsigned int size;
> +
> +		rx_desc = IGB_RX_DESC(rx_ring, ntc);
> +		size = le16_to_cpu(rx_desc->wb.upper.length);
> +		if (!size)
> +			break;
> +
> +		/* This memory barrier is needed to keep us from reading
> +		 * any other fields out of the rx_desc until we know the
> +		 * descriptor has been written back
> +		 */
> +		dma_rmb();
> +
> +		xdp = rx_ring->rx_buffer_info_zc[ntc];
> +		xsk_buff_set_size(xdp, size);
> +		xsk_buff_dma_sync_for_cpu(xdp);
> +
> +		/* pull rx packet timestamp if available and valid */
> +		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
> +			int ts_hdr_len;
> +
> +			ts_hdr_len = igb_ptp_rx_pktstamp(rx_ring->q_vector,
> +							 xdp->data,
> +							 &timestamp);
> +
> +			xdp->data += ts_hdr_len;
> +			xdp->data_meta += ts_hdr_len;
> +			size -= ts_hdr_len;
> +		}
> +
> +		skb = igb_run_xdp_zc(adapter, rx_ring, xdp, xsk_pool, xdp_prog);
> +
> +		if (IS_ERR(skb)) {
> +			unsigned int xdp_res = -PTR_ERR(skb);
> +
> +			if (likely(xdp_res & (IGB_XDP_TX | IGB_XDP_REDIR))) {
> +				xdp_xmit |= xdp_res;
> +			} else if (xdp_res == IGB_XDP_EXIT) {
> +				failure = true;
> +				break;
> +			} else if (xdp_res == IGB_XDP_CONSUMED) {
> +				xsk_buff_free(xdp);
> +			}
> +
> +			total_packets++;
> +			total_bytes += size;
> +			ntc++;
> +			if (ntc == rx_ring->count)
> +				ntc = 0;
> +			continue;
> +		}
> +
> +		skb = igb_construct_skb_zc(rx_ring, xdp, timestamp);
> +
> +		/* exit if we failed to retrieve a buffer */
> +		if (!skb) {
> +			rx_ring->rx_stats.alloc_failed++;
> +			break;
> +		}
> +
> +		xsk_buff_free(xdp);
> +		ntc++;
> +		if (ntc == rx_ring->count)
> +			ntc = 0;
> +
> +		if (eth_skb_pad(skb))
> +			continue;
> +
> +		/* probably a little skewed due to removing CRC */
> +		total_bytes += skb->len;
> +
> +		/* populate checksum, timestamp, VLAN, and protocol */
> +		igb_process_skb_fields(rx_ring, rx_desc, skb);
> +
> +		napi_gro_receive(&q_vector->napi, skb);
> +
> +		/* update budget accounting */
> +		total_packets++;
> +	}
> +
> +	rx_ring->next_to_clean = ntc;
> +
> +	if (xdp_xmit)
> +		igb_finalize_xdp(adapter, xdp_xmit);
> +
> +	igb_update_rx_stats(q_vector, total_packets, total_bytes);
> +
> +	entries_to_alloc = igb_desc_unused(rx_ring);
> +	if (entries_to_alloc >= IGB_RX_BUFFER_WRITE)
> +		failure |= !igb_alloc_rx_buffers_zc(rx_ring, xsk_pool,
> +						    entries_to_alloc);
> +
> +	if (xsk_uses_need_wakeup(xsk_pool)) {
> +		if (failure || rx_ring->next_to_clean == rx_ring->next_to_use)
> +			xsk_set_rx_need_wakeup(xsk_pool);
> +		else
> +			xsk_clear_rx_need_wakeup(xsk_pool);
> +
> +		return (int)total_packets;
> +	}
> +	return failure ? budget : (int)total_packets;
> +}
> +
>  int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
>  {
>  	struct igb_adapter *adapter = netdev_priv(dev);
> 
> -- 
> 2.39.5
> 

