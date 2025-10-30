Return-Path: <bpf+bounces-73072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B40C22393
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 21:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2430634FFA9
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 20:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0123B28640F;
	Thu, 30 Oct 2025 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dpPJ9ceV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63A734D3B9;
	Thu, 30 Oct 2025 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761855770; cv=fail; b=jyWx6BNinYpSXEzDPJip4WI//QUtRffbsZeFOfVU4jLLdUxCkdMwqSDdkahaURKiXYhthPi/wLQeZwPCBUwe7IoHUiGGJvYwXSc/LaMwUa0SXDOdaBv8so9h+0aqzo4VzamiKKyagJ4t7Z4bYUGA07d4qV8BnNBen7pBLr2kFEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761855770; c=relaxed/simple;
	bh=aSeFjK31Tt+rsnIEwrAxi4gAqcecXMVpHsGueF18638=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nfL7w8ewa9lbYkxBKYiq6H9VtVGSR5wuGujCwVibFtJx+cdR79l7eTZQ1eOLolP4RF6LJGbuBBkaJ1ARjavb5TSF7AI5BTuQi2NwgzQswJIoCx0PCHkU5xiw0zIpX/JU0yt1qXePbGHO0vOvPmCWfUQ0Em5G9KoOIcsxHwF4EPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dpPJ9ceV; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761855768; x=1793391768;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aSeFjK31Tt+rsnIEwrAxi4gAqcecXMVpHsGueF18638=;
  b=dpPJ9ceVa+DbiCGIcs1I1MxHSSh2Blb7+XFPsY5ujdub/EE2dMdSorJy
   Fr/1W+OuVyHyQWQim+zNcZf3HMgxzVM8pyG6HZtygtYHokK4Bp86RCrs3
   RTbTDcXzyGp0KN2cw1M31WN1GxdFA5Swjsf4ufOKQEiFv8fqSJ24zPNW9
   Zw9uqx4AGXn30HkQOMSG8Lbx/qVtNdCB3+vT5OIhgAsG27Xu2N4Nmg9Mw
   RRkEzZUi14Z8P8SEIdimOVxncxmzYQGc0u9/lSYcdwcnkc7ljL3DPQ8rb
   8nxW1BKo7HNazXuPrCXYkusAhS8/KtcRmeRVWf1WypZkSNzB1Utip9W4G
   w==;
X-CSE-ConnectionGUID: AR3IXT2ZStixxkpdIYoPMg==
X-CSE-MsgGUID: 6PeBw4PoRoCMsscgNgGP0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="66624807"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="66624807"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 13:22:45 -0700
X-CSE-ConnectionGUID: C98oSqv7REqhllFoMmBvFQ==
X-CSE-MsgGUID: C9vAws7CRzWjqV89DqIouw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="186490785"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 13:22:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 13:22:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 13:22:44 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 13:22:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AieUbf0a9TuXMyPbIelv762mDysOjNFOhVa/tvVhnEPeRlIN//WcQIyPihqm7FhO19Elysjg6BAbEM78S8MzNvalRWfpzykoKDzGJEoqhkVzvg8Ta8d7Td2hmvaFj0XhlXKTN6Vo5bg2S0qYPZLxEDvN5S1+e4E+14Q7O6Drv8uHyaz15n5fS1WhoUqBwUNoblVTxcdvKBBUme/nwfnwknzV/L22rAYDq/i1nSZqfjQr629i2j3i+l9KvawZjK04C8TM/WMWR2FGszHUkeyfM9FQW797ntDmBvocY0fi9KGrCNjgXKPtAzDKytwHbZWSJlZJWnlRTj3xHlRSue3/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNNYpIrE38Q44KUIGz1XL/hYo5H1GZbcATENPntieFg=;
 b=cgmin9y0ZoFvmhhriySmAQEbr/kL3N5tSUIkoNQWi65OblXRWVExX5xVnnIP6lzmW6mi3+qT4/ZghRAeEqqDV7h4KYks5Gi8wRUxXW2GFYKdLQnlArmGiIkdBQPe3iYgQHteLxVMeW2kWMG8rM1mFtLEEmDb6kDdpIir9EgVxkX2i9wy5F8bwQk4kZPX8yYE7NNp15POpI/FMMafwGOWLng7UthP0oNjQlYSji4iZQr5DLD5fdAAtfieW+YZC2Wkfjy3+4OzDIUFkn2hG7Oa/6QOXvTFDNWmrJs+aYUAXMKWyN3t34JtQdLVAzw3t4tjeJHoEv51m3IhyQJWknHi2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MW6PR11MB8338.namprd11.prod.outlook.com (2603:10b6:303:247::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.13; Thu, 30 Oct 2025 20:22:41 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 20:22:41 +0000
Date: Thu, 30 Oct 2025 21:22:34 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<aleksander.lobakin@intel.com>, <ilias.apalodimas@linaro.org>,
	<toke@redhat.com>, <lorenzo@kernel.org>,
	<syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>, Ihor Solodrai
	<ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Subject: Re: [PATCH v5 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
Message-ID: <aQPJCvBgR3d7lY+g@boxer>
References: <20251029221315.2694841-1-maciej.fijalkowski@intel.com>
 <20251029221315.2694841-2-maciej.fijalkowski@intel.com>
 <20251029165020.26b5dd90@kernel.org>
 <aQNWlB5UL+rK8ZE5@boxer>
 <20251030082519.5db297f3@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251030082519.5db297f3@kernel.org>
X-ClientProxiedBy: VI1PR04CA0121.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::19) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MW6PR11MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: b987e6a3-67f5-4489-406b-08de17f213cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R55NtJ+jbjnmhG4ycuMW8r0t67QWqpRHE/oPXR2+Jf6r2jGMhtCUKPdgQwAB?=
 =?us-ascii?Q?+Oglamn26SBtmwan7fXmm047KE1/tvEnoxLX9Vn2PV/Jpokuu150K5/Lf14N?=
 =?us-ascii?Q?iWe7nCzkvjRknX7WAvHpo7aOg2CrNnPFyVLsKoCD1q9MsRCT8t1nxR7ozvHn?=
 =?us-ascii?Q?g83UM0q8/Md54i1KaHIH2onrPVypBana6+lEji9WkN039a4201Rdle97LVv/?=
 =?us-ascii?Q?7f7xXUGED5wcDLX0HTX7rYW86PAmEMtmSRUiQ7zHN0p7bBJV2t/nQ+myPUth?=
 =?us-ascii?Q?/0TTy/92nIG0VUyVkKtumGrIPUqt5eO+3YmloiF6ew3e+vrWCxEj9qOefjBX?=
 =?us-ascii?Q?cyJ3IkdmGQHqEkWKzxOrNwnRoEzhSyBjkgqMSfQav4Imjb10mgI3+iPvPpqN?=
 =?us-ascii?Q?aZbF+xG7esOldhQw+byP/QEz49pe2GLBgXF9qMnvA85j4eVEf0ESZ1px7KDC?=
 =?us-ascii?Q?Zk56DTHJPfEF7RM3fFYPkGo/PFxjnLllcul9/i/yhafHJCLTGOGZSx8hAtgb?=
 =?us-ascii?Q?K+q5g1BikEayloRfmX4oMGwj4dJmvPkABMqw4uM0MrB2qJx8SZO4pC/ReeEg?=
 =?us-ascii?Q?+xggK9m7ZJbpluuIjUNEB765kj0jtRhXgoEpeoKTG4Uir//kt4L8XgnD9toF?=
 =?us-ascii?Q?hcn9v9UmN/1i9lpML/GFJT4KYMSWFo1YFKvfYX2x4IhRtfClikR6oEFvRWMu?=
 =?us-ascii?Q?QqE48nxYH41jplgKwUSlcbv1BNsCLHdqXWDnJV+NBZ1M2PBLHuOS8eU5+7w1?=
 =?us-ascii?Q?EwIZVFYOkAETFtImRIeF8HQDDUfv/xyDmxPgjcxtnf1tGZbowbQc0LTtuwdK?=
 =?us-ascii?Q?1N/F/EWTlm2H4fESCg4cfVA/O20NCU8UbRtOX3QP3Pzc0JfhbHCRiKO66dMK?=
 =?us-ascii?Q?O+42p6REeipHuKADaJ6LGB62wQFCd3iv3cKN80laX2mbzQGflfjWAcixfi/N?=
 =?us-ascii?Q?G8WS5I1nw+qFBiy7qEAZjX973hcf72eFhb6hLbB2+oWQFXNrS/BEQerFdFXL?=
 =?us-ascii?Q?nmo30o/DXFihCgEz8PG0cyqG/OMYH5LA5BvJSqVTlmE/JCKfF1VPhvoTpdG/?=
 =?us-ascii?Q?SnMVmgH5YgAQP5ymP/llQEedDo27I9/xPPQgwFqxnGtNsYW6O0F02GhIEiwR?=
 =?us-ascii?Q?1FGeC5D06eYMImyl7YHWZwGc8W7F2uUwrkVRwPkmgMXGysU1rvR0P75Qsniz?=
 =?us-ascii?Q?EbcfOsqX3mSTHmPJWYrUnj7cPNzme6LHEqzs51idzIVSh7aSvVQD/c35WAmy?=
 =?us-ascii?Q?zhtTBHIJtpdRwkAATYAv0RiLqtTbm2LWUi0ciqzPRTYNzKVP4jLa3g1XEBF2?=
 =?us-ascii?Q?BiCUjuO50ssud0rRLev5jwHdBuBMQZzqFH2FyJ4HGR6/L09H/YDOOfTTFbQt?=
 =?us-ascii?Q?WgMQuzKE5b1sRPIlXHIXv9R+AyY9cpE8G7/538MdRr8/6p1gqLt1uDPxWwai?=
 =?us-ascii?Q?srm6XZvZg0VBSWrUEp2Xp/m9ttEpedKd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BWsHdliSYQ43rZzDY5aP/A5hJBjqzuS3gNytJUv78FsxOfCgqYb8TgRPDouA?=
 =?us-ascii?Q?qikSHo2Hp8MIkxuxEJGr5sRxHUkEIkG0ZSnMVn62IS9SNFZOLk2FbvxI79EF?=
 =?us-ascii?Q?RjlSZsfVtueFJr0DZE2SI9umtreUguMloFYNDuQuDybeWoLe2kHyKU6Z8r5h?=
 =?us-ascii?Q?v+w5vfSHZxYFvjrxXA8RjM3WpGF1zV2csWXf/reliLmHu9DAKosrcnJRG1QT?=
 =?us-ascii?Q?FLHakTvBwUAHWoo8k8LYKf45JO0yf+LRqqzyIDz2B4WGabacVbl5UiYD0ElB?=
 =?us-ascii?Q?OyDUUQ2HFI3vGnFaltPGm3nGM2i+/TYaqf6Fqi9tby0iCBsOlrA5ymLodtHK?=
 =?us-ascii?Q?Ap+DzD2/foz0g6e13PQvUL/pvLTUDmjcTRLyceh7gA9Sod2TgfcKATQjOxjn?=
 =?us-ascii?Q?J7nR9cifM4KlJK6XqRvLCwZ+98GhaSBO4KI6VEv3Ji7bFxi2gsroq4//1QF3?=
 =?us-ascii?Q?/94Zn2mGW8aaNEgHSszQhq5Vh4gIuOslQe5d9YqvOW7XmodbrDTgOv6MBPka?=
 =?us-ascii?Q?D+gPenvcELI5Avxw5IDt4PWgtY7XvXRll/qVTJLOyAnswheF6nUpV02Yihpv?=
 =?us-ascii?Q?Sq3W0YJNgnQU4hs/JmEsu4/4ySQkahCIegfmi1UHf12u5puw52CPsg72h7Xl?=
 =?us-ascii?Q?k6K2CxRx/ynDCQhagFCvlJqbXexX8un2lQGuVvhzODzzpC8cwdRJA2zRr26P?=
 =?us-ascii?Q?8/ZPL42epa6juEjVK3PllJ/CNW5dJ2WBWwgFnf/BvxzyJe16+bBeKs6g50E7?=
 =?us-ascii?Q?DoEFXVrYO+GViczwHyt7KRUcHVYseSsfKQQajl3D6B5EPgYTMVNiqxPos/0i?=
 =?us-ascii?Q?w9O97E2r8ExsFbcLrpRJkZlDfF5MTDjByk0Gs4V3Tq3Q9cpws0gJC4UV3x5V?=
 =?us-ascii?Q?XgxYnZwya7yrlYNzCAto6FuVLxKZNpvg3DItb9yb+KvzNgBWmVf71smz4NHo?=
 =?us-ascii?Q?03oUNl7MlvBnMjhUttFDWohVj4bkQKwuhRIVChc6okKn8NcmbR/wmFHZPXIw?=
 =?us-ascii?Q?3KUvf91p3ekS1HcUcRg+WeHA5DKbzs/m7jwOwbr33mlsukIg2Gj2Jtcv35ZW?=
 =?us-ascii?Q?u8VJOrVpjF1pycAPePf4CMl/56k5wbMWOJKUkENldmDFM/430cfgzDI6lhrT?=
 =?us-ascii?Q?2y+tUepzVwp1oDnXxHrfeln8ImZWS9JytXInSnBw+uJCCgfY3dHCaqmo0CD9?=
 =?us-ascii?Q?IRedJ89eK04kEaYF+0wtQdBwvPEmhb1/on1fXxhk5nq60hIDOvnHSvkVDuqX?=
 =?us-ascii?Q?nBYNbY2PJiwwNI+Rw7/XybqxB9ra9gxycqzDIxhJ/UJ6rwmuCmlLJTNeqSs9?=
 =?us-ascii?Q?AJDnPiaG0yP5ViaQ1c39uZI3GvBzF5EZ0MBUpGvuL375oYknw6qQHH+/7uDg?=
 =?us-ascii?Q?lDvm08ZO1BFQMPTOdoZTBZkqxVsFTcBI1IQ4haanbSeUiwnZAEEJKFQS6BeV?=
 =?us-ascii?Q?76Qqmdfo2ya/jYCviwyje4H/JkqCDC7HbCaJOtBSvUduMPr1MGjEZ6s5a7sa?=
 =?us-ascii?Q?IH8NXxGWihsAYq9NplS1Cif0/C2mPxWwhY1xvJV7u8HIU4RCGfg3Z9PaHdYh?=
 =?us-ascii?Q?pv+jBzfPjLXr1NGganqiuGYICgM4jGXIswi9NhJe7FYn4yv5n0eT7ST5vC6B?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b987e6a3-67f5-4489-406b-08de17f213cc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 20:22:41.7036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skOqd9NagILZNudVk4SLZXvnPtuXrhQXUsxBthvORLpILiA2FPOdiOPC9TGEmV7Lo7dwuzyaJeR8R1EV10LkUFQO4+kO30fnhavDgyTuQ7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8338
X-OriginatorOrg: intel.com

On Thu, Oct 30, 2025 at 08:25:19AM -0700, Jakub Kicinski wrote:
> On Thu, 30 Oct 2025 13:14:16 +0100 Maciej Fijalkowski wrote:
> > On Wed, Oct 29, 2025 at 04:50:20PM -0700, Jakub Kicinski wrote:
> > > On Wed, 29 Oct 2025 23:13:14 +0100 Maciej Fijalkowski wrote:  
> > > > +	xdp->rxq->mem.type = skb->pp_recycle ? MEM_TYPE_PAGE_POOL :
> > > > +					       MEM_TYPE_PAGE_SHARED;  
> > > 
> > > You really need to stop sending patches before I had a chance 
> > > to reply :/ And this is wrong.  
> > 
> > Why do you say so?
> > 
> > netif_receive_generic_xdp()
> > 	netif_skb_check_for_xdp()
> > 	skb_cow_data_for_xdp() failed
> > 		go through skb linearize path
> > 			returned skb data is backed by kmalloc, not page_pool,
> > 			means mem type for this particular xdp_buff has to be
> > 			MEM_TYPE_PAGE_SHARED
> > 
> > Are we on the same page now?
> 
> No, I think I already covered this, maybe you disagreed and I missed it.
> 
> The mem_type set here is expected to be used only for freeing pages. 
> XDP can only free fagments (when pkt is trimmed), it cannot free the
> head from under the skb. So only fragments matter here, we can ignore
> the head.

...and given that linearize path would make skb a frag-less one...okay -
I'm buying this! :D I have some other thoughts, but I would like to
finally close this pandora's box, you probably have similar feelings.

So plain assignment like:
xdp->rxq->mem.type = MEM_TYPE_PAGE_POOL;

would be fine for you? Plus AI reviewer has kicked me in the nuts on veth
patch so have to send v6 anyways.

