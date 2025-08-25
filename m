Return-Path: <bpf+bounces-66461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E78C1B34DC5
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 23:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB4354E3072
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 21:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B853111A8;
	Mon, 25 Aug 2025 21:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0UWJXym"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D37AD2C;
	Mon, 25 Aug 2025 21:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756156541; cv=fail; b=u79FJynR4CCuTjSuB5V6MKvTEt5utrnxdn5nGkSiJqMMndVS7e/JVL654NPwf5tTlpM2cEcHGBOoQqmJMa9evwqRr7ZsspAESIRyNBqQhWQAEEl8ZpffAMAwcAZUKb0//4rb/7OYukcTcsOCPjG4rYvMrdssUYvyQYwvAXYlNoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756156541; c=relaxed/simple;
	bh=owj4cmMb39od/MH2bPj1cZH8xSyh3d4rh+/VUT42Y0g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CUF67/e4QASlGR0SVpij7NAobo2LRUI9YrisJd8oLJD0sYaYhi2VBy2YbOaXEh0cfW3/K4Kh4YQmtHKjcHG7+HqR3R8gfQbHPn4UL52vVe44dkigyXmknZ7/4crhoSTZ1mSZKlj5qa/+Ei4s/JI38nsRhh7PVuRFStguUVK8/X0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0UWJXym; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756156540; x=1787692540;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=owj4cmMb39od/MH2bPj1cZH8xSyh3d4rh+/VUT42Y0g=;
  b=K0UWJXymQUnGMU6S+AXblkfBtJZ2HgiXD/CRx3fuxqoHE9bSaVAhxfew
   qJusXpdk0lQZIxMUkw0e61TzgVcXqQwgbs51PmhBkRwePQC/03yDIQPrL
   PFxTRskyDEIDYQo0SPYSXW1FDbxvr4rapakbQUdsTtvVR5cS29tK60MUn
   UhgbQ7gHi1vm36nZkMnw7x6+gSgvB24UFq/pd/a4m7THyE7d61YOg6cRD
   Xy9OdLb33urJTtgebkrxww/7oLKvQSftJRn26/jSImVFXbraMX4SAAcfV
   AySB6ieGhbQdght8mtv/H8MMJqo/dDDNHDPBMRv8TU5jjRwPZ/N+6Fbi4
   g==;
X-CSE-ConnectionGUID: 4XxvzTqIQcO3vs8UlsFs6Q==
X-CSE-MsgGUID: TATdTjbZR5mm1Pi0Kg0dAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="58241754"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="58241754"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 14:15:36 -0700
X-CSE-ConnectionGUID: QxXmt5wMTdau0LQ6yKhvyQ==
X-CSE-MsgGUID: RLGpccB0T0etNQTm7bK5tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="168609786"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 14:15:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 14:15:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 25 Aug 2025 14:15:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.41)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 14:15:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ox4Nt2Yc2JNlUvIIbPqVdmxm61c1mWw1Dp20Jg9iSo5INQgnwDc0LqDis+7UoYyzqQWfJxU/roWCFVEcxN+0DI2vtmsyqD6F2dvJgDVPzb2VJgHmLk+lY9xHBt+aHw1z3eRHhP7v/7gP242dbYQP32qlEblKI6PyWAT4s/yk2Er8KvwiVPUD15Cjha+Z5OCZnKxlAVHjPy15JpeVn7M3BWdjzLGHCO8KMluUQ/C/55WaNTmXujiHGOwx1TzmP2j8Mw/OQa61cjGPkV+0TuQCd0oq8LHGPon7EFmAeULbuWBd56bvO2PHbBPaZa9Ntr9XBIf2Fc9nzRTwaix2BbltXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICK1RyAlUORSpyI1A1+r6Ucy8tuo2tlGpeTjzEhO7BQ=;
 b=Axu/jvAaJWzmkRb/AxBdqmv8QepnEKaQqzPEoXy6NMJL1zbjk58fihKsDHbYcXuS207wtMlQmJGlxf90B/UwyjtapUL803AiFSmSbPHRQNnYMIXPkp70GIJMfpkHD1HQBVMKpTfgK2lN2wTuv7UMLviF/QOnuvlf7RKgloYLeBORyVPAoXGdl3Wg8GGFZrmBHpymw2crrUsGp8gunqswuQGJXsfjG/KnzJgimh8HwualYZRQJcNplkYedCK/7S+hR3XY+GYkoxbIgCJIB6TeuyCIuSrKY0OUpOwPO/lLJBb7f68Rh/THfWS/5kymvlsD+8+dFtYgIgjV4/OyScpQQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB4968.namprd11.prod.outlook.com (2603:10b6:510:39::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Mon, 25 Aug 2025 21:15:33 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 21:15:33 +0000
Date: Mon, 25 Aug 2025 23:15:20 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2 0/9] xsk: improvement performance in copy mode
Message-ID: <aKzSaA73Kq3mZ+Mp@boxer>
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250825135342.53110-1-kerneljasonxing@gmail.com>
X-ClientProxiedBy: DB7PR02CA0013.eurprd02.prod.outlook.com
 (2603:10a6:10:52::26) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: 8568d42a-ea7f-4130-6b19-08dde41c86ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vtY75u+2EAr77CWqdwHrph2FUpuIFllrXP06gUXm9e526TGRExKJCoiEygtq?=
 =?us-ascii?Q?uPTY3qF6NI07dq1U18bsnxQaYVLoxaaurlL01LqUDLU7TvRp5cWYqiLNkyM9?=
 =?us-ascii?Q?I0I23nADEiubfGyC22gidj6yjVg+VgF6/B0KcwEGVOSTM1uZOoUVy9jBZgFP?=
 =?us-ascii?Q?GeWWwhrUB3EmR3D0tANXKfpGcJyeIImGb4MavkTNISXpyCmDFTGIRStifZ+W?=
 =?us-ascii?Q?/z4FKHUafiUWIMUJS2PHpWN4d2AdIVTXCFMwTqxOM9dm97+7hG30tXFC/mV1?=
 =?us-ascii?Q?GqbmszCNM0mNwkM4A9YGEiSLYKi0CcKJF5qEmELcu4AsXhcK487JZJkS6mcU?=
 =?us-ascii?Q?kEM6nko6kQFdCqwYo78sOx/yYmupGYqoz81r1oA3QiUS+ygpJPCEImcXBkb3?=
 =?us-ascii?Q?Ttdv8YsfhfXr/dNobVXPPhzDyZkoornO4KtzI3WqY8jDdooUDvG1ffUSKPRU?=
 =?us-ascii?Q?ctbrjabSPs8Ke4srtlZ2PoCm2MdYFGC29cpfmZcNrOU9XhFMxPu4lQ9J9YR9?=
 =?us-ascii?Q?EYK5oN1xz3zgPtTRrDKu1DhGnNpEHVUHZm1l1h75lAK8+twxFjbiHZxuYa1h?=
 =?us-ascii?Q?Dkj4McoreLvA6LnEsP9ASxz4la+TocadaEA8SriFgaZ23+0mo97qjVp6RBTa?=
 =?us-ascii?Q?TtKbPFA6HDrPw0J9suD6fOYBuy2h5FDtxoy6IiFOkacZ0XzzM0CtnIpRVSGI?=
 =?us-ascii?Q?xH2d29ZawJJ5U5ZWzcKXbzjYJxbbo8CWz01jk3MfBmvGeeKg8fs8UWplm6zU?=
 =?us-ascii?Q?FIgXAl88VKeqx+LMaX2lEavsUx6gZ9RwZAvDOfH7/woCk3sfwawpcIc8SD9g?=
 =?us-ascii?Q?3M8N8tN8YL3oVIgB1nAGboPUFeXSIBEM7pWRZ0uOYY/OrcWiPRDu9vtRdXFQ?=
 =?us-ascii?Q?sL59CgXwPRMNtp1EnijAqK9jciiLfihqUDVGuFcvNhFfNq7iM8xDIwMlAGYl?=
 =?us-ascii?Q?7tvoL24OU8NgM5W67sKdhxI0Lg+wzAMp+H0TyuNqv5cdj7Cs5zGAT4FqqdaD?=
 =?us-ascii?Q?AVZ2SlOxjpIlKQp4eLbj1XQmsXeJVESfDTZNebu15ie4bsjefbhDn45zL66V?=
 =?us-ascii?Q?82m9HvG44JzQgDKJ5FU7fHNfLWgtgPS1iVr2fIHCBT5OEOTJT4uT+1AvDGY5?=
 =?us-ascii?Q?3K/IMbBA1zjsDc9RXDC6LqwEJhSAETih5LZI8SOUS2a+NVyzIv0duqUe8d3i?=
 =?us-ascii?Q?T//l7hmpLwQPwv/Zkyb1ldXyyd0BwSIGZuiZ4bnJlljlXGKZAHenrnehNTZD?=
 =?us-ascii?Q?lzlJV0Fcm6WMNRAipUeX8oMn1uIGm/2VuLuUkpXSfX3p0+1BRB1BFmXNd+NL?=
 =?us-ascii?Q?D/kNcVrOKtz8LanKX/STQZsPjoaIul6FES/mpojyoD40vKGOeEedr/XcgOwd?=
 =?us-ascii?Q?L5X2HP0JZmpkbutIcemDNt8hfxeyVBTygUIk0rjgjM/J4VY4cM1nbt81f2Ee?=
 =?us-ascii?Q?vHqZGkM6FYg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TJYIpLtdm6IHr7i8d8ZPFVdrvNfGOjQCjrJviF0w5O7RsPn+o7ec4NffpkP8?=
 =?us-ascii?Q?Dlh7vNxzdQ3u9N3lJwrV9ByWvMDjXCP1oFN6nKvjndL4jZqh82icjbfB3AH1?=
 =?us-ascii?Q?PSUCh9Kfc44OJuK6J6EA1stC1Dt1v9IePWXRxMk4I9D8FdTbf5bcHQtMASFg?=
 =?us-ascii?Q?rEiXHmJJHwlZvPHzEESFd0fI6uuGJbW1yFaQQK4t2/wkVMogJ4QZ+tkWpEjC?=
 =?us-ascii?Q?9r8qilcmAZfFBFmx7Xas+juA7NSF5u4T8ulHkKoeYbSCzWOvvpR+sbjaRRdV?=
 =?us-ascii?Q?aia0eQkay4nyjjQE8FW/nD6ojGP/Owyd229v8kzl35CwUcZvpfryJZk08f37?=
 =?us-ascii?Q?Et25AQyfESouL9lajQMBVt/RehninLRQAAS3zzotw7Vpj9IfNK/OrE2a8Q1M?=
 =?us-ascii?Q?nlWc1QOqdbVqVs/d0tWbyV6Z3IoR/6sGJkq5fobyj2ZiplD/Vsf7dKvHO1L5?=
 =?us-ascii?Q?/7QvBX/NjwQ9y+rsrGCq15kBKpxb1KkEau6LNhuwBYeqdDQCrgy9EwqMdAGa?=
 =?us-ascii?Q?swQrWjbqhMGw2BAv6+ZyNcnZlCtspt66TeRUPY2A34hxAIf3xxETw5dgK7aE?=
 =?us-ascii?Q?ROepRcof6jq+eqzanBLl0eXutXKDpngBOM2Z/XeeOwVk2eR2sRsFvVyxSKMO?=
 =?us-ascii?Q?EUmSkPk79q4uUT2Pat2c/A26KqkcnrrbmmCjsutIY3YHSgIN4oQjNKiULDMk?=
 =?us-ascii?Q?hWs77hAK+jQmIev3ryAmj/hgSwvoBpVXl2RVxh73NEAKdtEQ7rLiZJEbXiMw?=
 =?us-ascii?Q?xOjl0aBd6+B2CjeQiI4GGOoPsBsaY6thRTZxLI2J9HfW35O/jODQG/uZ2Wfe?=
 =?us-ascii?Q?rWiS6hbOhfmZd1C8aHRY/rD39K+vHHsiL1VctatralHkoQuKwLjGsV74c+GH?=
 =?us-ascii?Q?ZH44c6cazAfEakUIiSdjjN9NQnEjssV72r6LzUKUa9cBX73WQ+FrEAOiOqfL?=
 =?us-ascii?Q?tlkiJg0AaJ2IlIuWdHkcho7aRMjfy9A3GF0K7EEU6MajAYhczade6M0xjUVp?=
 =?us-ascii?Q?kbNt7d/N/s7bPEmXDfj7EyDhlut23bwAoM/7pYw2KwVmREAY2P/Jo6H856dL?=
 =?us-ascii?Q?U4wA5cHTm7Zu5XAWQWLzS6BhFBEL/CK77y6bA4er62pO2TA0lrU+OeZyekKF?=
 =?us-ascii?Q?JanhrT47rX7yXIH+z+m1hDzf2lEHxd+sJFT4LnsiiWFRunFm7PVSMYW3lZMU?=
 =?us-ascii?Q?PWTA3N5fwAPLYFBNtPG6gvBqNjlltzK/n0SviruRqORuyhj+ToTVy88KgGwa?=
 =?us-ascii?Q?yBKWtmSNWhws9LvcpffVIDqk3Y9DSMzLc133A8NsTWCJvlCPAM4LWgwXSh3W?=
 =?us-ascii?Q?gHsGdYUiQRDKAPQQDATgiZQedWzZQ7JxJVzwzeJajC6CE6d9pk1kcEhJ3mUG?=
 =?us-ascii?Q?gJWBiwiOu4rwU9Jt2VdbEdWOgaWVBAArVYfN1Ta2ic1tczg82Uq8xhopCcN5?=
 =?us-ascii?Q?hWLOR4rE2p7Kp9xGvYOniYCT/fS0uni+Crw17Gqjv1WvQvfpDMfYlpGkTKo1?=
 =?us-ascii?Q?AY1ScQFBtyn+707TMC0SqGNweCvFTeUU+OjjIgBLX0c5SYrvI42X0DW6kb7e?=
 =?us-ascii?Q?1P2qYQEjp5SEL1xk9GCuze/6ubdUNKFpjHmjVa1D6AP4h2Tiuj3CFAmdOJ7P?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8568d42a-ea7f-4130-6b19-08dde41c86ec
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 21:15:33.1836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWlHpXSosgaqYVbFZXUIvtyQcJ68SeNrZ859LUWLIHBKzS+Z4DxwLWzXoVzDQ2wqE2elMb1378lgviYOnn0jrdOIZiMVKWAe+gV+jwTeXY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4968
X-OriginatorOrg: intel.com

On Mon, Aug 25, 2025 at 09:53:33PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Like in VM using virtio_net, there are not that many machines supporting
> advanced functions like multi buffer and zerocopy. Using xsk copy mode
> becomes a default choice.

Are you saying that lack of multi-buffer support in xsk zc virtio_net's
support stops you from using zc in your setup? or is it something else?

> 
> Zerocopy mode has a good feature named multi buffer while copy mode
> has to transmit skb one by one like normal flows. The latter becomes a
> half bypass mechanism to some extent compared to thorough bypass plan
> like DPDK. To avoid much consumption in kernel as much as possible,
> then bulk/batch xmit plan is proposed. The thought of batch xmit is
> to aggregate packets in a certain small group like GSO/GRO and then
> read/allocate/build/send them in different loops.
> 
> Experiments:
> 1) Tested on virtio_net on Tencent Cloud.
> copy mode:     767,743 pps
> batch mode:  1,055,201 pps (+37.4%)
> xmit.more:     940,398 pps (+22.4%)
> Side note:
> 1) another interesting test is if we test with another thread
> competing the same queue, a 28% increase (from 405,466 pps to 52,1076 pps)

wrong comma - 521,076

> can be observed.
> 2) xmit 'more' item is built on top of batch mode. The number can slightly
> decrease according to different implementations in host.
> 
> 2) Tested on i40e at 10Gb/sec.
> copy mode:   1,109,754 pps
> batch mode:  2,393,498 pps (+115.6%)
> xmit.more:   3,024,110 pps (+172.5%)
> zc mode:    14,879,414 pps
> 
> [2]: ./xdpsock -i eth1 -t  -S -s 64

Have you tested jumbo frames? Did you run xskxceiver tests?

IMHO this should be sent as RFC. In some further patch you're saying you
were not sure about some certain thing, so let us discuss it and overall
approach.

Besides, please work on top of the recent fix that got accepted:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=dd9de524183a1ca0a3c0317a083e8892e0f0eaea

> 
> It's worth mentioning batch process might bring high latency in certain
> cases like shortage of memroy. So I didn't turn it as the default

memory

> feature for copy mode. The recommended value is 32.
> 
> ---
> V2
> Link: https://lore.kernel.org/all/20250811131236.56206-1-kerneljasonxing@gmail.com/
> 1. add xmit.more sub-feature (Jesper)
> 2. add kmem_cache_alloc_bulk (Jesper and Maciej)
> 
> Jason Xing (9):
>   xsk: introduce XDP_GENERIC_XMIT_BATCH setsockopt
>   xsk: add descs parameter in xskq_cons_read_desc_batch()
>   xsk: introduce locked version of xskq_prod_write_addr_batch
>   xsk: extend xsk_build_skb() to support passing an already allocated
>     skb
>   xsk: add xsk_alloc_batch_skb() to build skbs in batch
>   xsk: add direct xmit in batch function
>   xsk: support batch xmit main logic
>   xsk: support generic batch xmit in copy mode
>   xsk: support dynamic xmit.more control for batch xmit
> 
>  Documentation/networking/af_xdp.rst |  11 ++
>  include/linux/netdevice.h           |   3 +
>  include/net/xdp_sock.h              |  10 ++
>  include/uapi/linux/if_xdp.h         |   1 +
>  net/core/dev.c                      |  21 +++
>  net/core/skbuff.c                   | 103 ++++++++++++++
>  net/xdp/xsk.c                       | 200 ++++++++++++++++++++++++++--
>  net/xdp/xsk_queue.h                 |  29 +++-
>  tools/include/uapi/linux/if_xdp.h   |   1 +
>  9 files changed, 360 insertions(+), 19 deletions(-)
> 
> -- 
> 2.41.3
> 

