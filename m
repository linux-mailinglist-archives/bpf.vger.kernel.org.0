Return-Path: <bpf+bounces-36834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 774DC94DD15
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 15:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8CA1F21AFE
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 13:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5FC1586CD;
	Sat, 10 Aug 2024 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mb9o/kFH"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028F1282E1;
	Sat, 10 Aug 2024 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723296946; cv=fail; b=Ct5VOQIzo14fF+pfAg6tBGu6M761JpVr1qmxj2zuI26d8DSoOUqscF8IQ0GOVSRIaHnP8LTGM91id9AhmCulnFpRjy7RVYPVXfzywrxhim7U7XNp7VoUaXInvi2iYW1r/gK/l/sZH24/JzoazIU6vMJ6jvEXDUGnRoTPtnHejQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723296946; c=relaxed/simple;
	bh=rCO+dN5Az+lm0ZoKLoCnAaq4Xm5+/qLPcipK9mecvoQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I398OO0AmbzKxizuiMKIpcjnKEktfEjsawPHTg9BtBJ37VcWcjStbSmPvVcNCsgD1psrULFEwSQKeiMktcierwpjHNNIjjGdQRpGVc8lMTGZ+m+H5CBVQkL+u8OBlIh0T1rOirXb01OM45SAOQdC+XSeqNmqA6dpLU8oxpskkHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mb9o/kFH; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723296945; x=1754832945;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rCO+dN5Az+lm0ZoKLoCnAaq4Xm5+/qLPcipK9mecvoQ=;
  b=Mb9o/kFH1rC1KBOPQYO0ErayhODCLokP7F5j0/k4zSFOX779mW3ZcL1k
   BUWXpegwmdkrENVprAhvw6ezeV2X9ZRpcbuZ7Z7jVTCIVTNtjWQHuKzCl
   XbXM42q2XjaIWEuqE9HObH0sUAocuL2BobIaBGBK+Rw3odW2Ulx7V/MOi
   8xLhwYWq9WRmeF5CuIKix3kiYDzPbgjo+SS1ZO/YP2SUDtkKPXqVYzSyB
   efb6u4S56Ncaz1sxMP7y/l9qs0iao4eDxpy+J54pNjNRQb/BxVy3lyrYs
   +n536SaaesFgdzQSDr3ArviXHv9DTHNlIlxhJQUX8ReNvVQ1PRgXLsExr
   g==;
X-CSE-ConnectionGUID: OgjU5TRNSqO8vyL80iCmUw==
X-CSE-MsgGUID: flxQ8+HsSiiCygxgqBUWZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="32039299"
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="32039299"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 06:35:44 -0700
X-CSE-ConnectionGUID: vR0GCACnTRSomeLbX/m92g==
X-CSE-MsgGUID: I6xuZ49qQHqkQ9Iah4VgpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="58531386"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Aug 2024 06:35:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 10 Aug 2024 06:35:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 10 Aug 2024 06:35:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 10 Aug 2024 06:35:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxqrWgCxUS5F6iAzUCTS6CKKeZxR2hep87CsFmvv2Rcnk2Xf07ieo4WYaBXw9V1ROh7F2m1DQ/e7BFFBkkhidCJtwny5xT1qDigl/AtIl7UWU7GF/VlHx9OCNXa3NurStpkU5w+OG2QI+phsAi9JZHjWB3Pwyy6noSxwVKOQTOnpGIdrnXokn6BAT8V4MLTcNfSKGTD6SeYHouCFvT7MmgFQvz3K8oJB2OGfy3GVZSPMbFTw1ZRNGkFUfDyB09ob85y5+taPSyJ8DZX/SC+YLqXlvSBz6thD85CFwuRqP3A8UPwurG21BL/ldlA6+PtS1xqL9vJGeO86xCuLYeNZQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0n4o2mSE6ffT03fd8wJasvdM2tWcUBZWsGo61cRshxQ=;
 b=Xx/HXFvsD3qv5oGnxMcRKvEeEB7cYH+3ejTu/QtZ5wcNfyFn8cFKIj583ipcsVCHmTYTs3PY8VDyq8O2HgTWSJxsGByolDNyuXOj9zwzNICQQ8DXrPUMeGfM6r0GFghKN5vSb1tNhqu91fdGLfwzLjqAjkm7Mn07b5lktd29TrjLC8UsKG8VgERwSV2rMphyaNDd+ZiDE1L179wm//j7QSS0En7xT1LYDZanhKJsb3Ih0RKAjERElXxoCJWzPmJ9HXeU6Z5cOIvGcXUD8Ig7Bpmc57wXCwmnfSrsbOYB+KRb4GGB2NAOQYF2mLm0wosVHyFms90jmpQljcQb/cysGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA0PR11MB8353.namprd11.prod.outlook.com (2603:10b6:208:489::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Sat, 10 Aug
 2024 13:35:39 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7828.023; Sat, 10 Aug 2024
 13:35:39 +0000
Date: Sat, 10 Aug 2024 15:35:25 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Sriram Yagnaraman
	<sriram.yagnaraman@est.tech>, <magnus.karlsson@intel.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<bpf@vger.kernel.org>, <kurt@linutronix.de>,
	<sriram.yagnaraman@ericsson.com>, <richardcochran@gmail.com>,
	<benjamin.steinke@woks-audio.com>, <bigeasy@linutronix.de>, "Chandan Kumar
 Rout" <chandanx.rout@intel.com>
Subject: Re: [PATCH net-next 2/4] igb: Introduce XSK data structures and
 helpers
Message-ID: <ZrdsnT5aIs85jyL/@boxer>
References: <20240808183556.386397-1-anthony.l.nguyen@intel.com>
 <20240808183556.386397-3-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240808183556.386397-3-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: MI1P293CA0027.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::7)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA0PR11MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ac76fd-ba61-4f7d-e237-08dcb941527f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/LaFkZ74ZPNzrqPuX0wa9Y0tPackLWRGnbpZLX6Myo7lhZQeDPnnHXqw9wgx?=
 =?us-ascii?Q?rr7WK/YdznZtYIzqb1S/86c0Q3kDG0ryc/Zar4BEr9+wPvlFXnJ8QwPcDllv?=
 =?us-ascii?Q?Xj/eQk5bwx8JoZm2O1tlLAxmhht8OyUdAV55H2Y0ADXHcaIMvuh4IdEz+ppr?=
 =?us-ascii?Q?9mmltv1G+kIeMr2UN5vS1rMtI6OlqfKQZDjPCDstYMefZaKc9Vq2SM50a5tj?=
 =?us-ascii?Q?2dbRz9XBCX1mN0zfmrRi1VW0vXJaCUyyW01i/9HzBp/nVMmvcWNv18b18fA4?=
 =?us-ascii?Q?PXmX8LKgLy0Gy/qHJp7CRZDECoUZMiYQj4vdPQ7tpTY+lOr7Tke0Q/9zPd5J?=
 =?us-ascii?Q?Ug0JbB0vNjpWL+isxdAZUfmhrJf6hmaEKd0IRw3RzKxW81ErFdW1dpfnnKG3?=
 =?us-ascii?Q?DGNdjU0OzZehK6+O98gsyj2Fku7a/e+bQgne9TwVedaQu7ydZ2rfzJy+3qA1?=
 =?us-ascii?Q?8IL6LMhwdOBAaB1E3nP3nbWQwuvgaRx9MuM12VlhRsYXryPUrEl6ZFpEagdc?=
 =?us-ascii?Q?1wMVOmnwqxdzteFQf5/orBFx42XH+3PPfYPPXIjIg6vWT3r5tksGMNbK4qVL?=
 =?us-ascii?Q?UwRFeaYq/B0cnUvPDqjvfn5pj0asU5xbtvJJVzoRF2KgZUJUNU8Q6AVX1DQ1?=
 =?us-ascii?Q?S+H8XmEx7BGwS5vU3ka/ZAh/nfxHFyIPes1py0Tn+yLRjPqdVw1/pyApdJYJ?=
 =?us-ascii?Q?5HJNSdcKx/nJKSqpKjJN8Q1i2mHIkBYeJWb8IgcJ2dG+6KEiDL8hD6fnQaU/?=
 =?us-ascii?Q?8hKoLOmIiBqhJHctwgKJ+OmMxfq2e9AIbLrRis+5VfFNEiyojQe6cWQgfF4k?=
 =?us-ascii?Q?O7wHcGEJ6sDmlrxHls/P3A00+iu4Th6EG35ixZoClo7g7z0advx1BJL2pzZr?=
 =?us-ascii?Q?N9KRu//H3WXFXCtUJZDqrveUN3dgdF/4ZIdq83m4dgbzv1FJobSY7iQHun5W?=
 =?us-ascii?Q?CiCUhCQj7i8CXfQ31d7L1PBhasTrIx8NS2toHBJx5e2KjXUwJHaarBPCyBDi?=
 =?us-ascii?Q?Vem8JXGuYvWXZtXIIi09BsOcNZfvf965FPf76KIqa9J8/IhmPQSwkWvg+yg5?=
 =?us-ascii?Q?uKsahDlC/Rvss7Y0P+yFVwNRi85WibeMevyWVC0JJ7yiGy8nS1UFtK91h/XF?=
 =?us-ascii?Q?XAsEyWs3T6uAU6aNWadsHr4JqoRAiZStZPKsAfRuNLf3UrTelAKwpiXT+ePk?=
 =?us-ascii?Q?W7wykBY7N/tTSfB6PubUcRVh4xtbV58Rudxp9vHGgqW8DdCxNNafyMD/68Tg?=
 =?us-ascii?Q?FNKgZ4yjVxaUoWQcGqu6NBq+VlSdN3oZzmtJ0iRhjOmBNG9BtT6QVGYrEbiT?=
 =?us-ascii?Q?9u1NRc6jwK9tEI3XF6SMmrtb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x81cShVVdsdUBoyUDRm8ANvGLoTFFUj8TOb88BBE3wtJrY/rBy+QjoxcmVDQ?=
 =?us-ascii?Q?ffNWmc4w7OBtC2sf9oQq4KXVe59/XgQe8MLi2ysPQC/Jzpxla4xXtwwtRJvk?=
 =?us-ascii?Q?oj/aj9xeZQT7bx4NeGe6n+IKvYhhOLNjE+HaffzFwOPW7uYVqCkqIQvplYDb?=
 =?us-ascii?Q?pJ/WNXG8HVdAkkszRtYCjShwgsrB+wTvf2120YoThGMDToyYbuQ5xPNmG6KU?=
 =?us-ascii?Q?vetsx4zrHFPnFzX2rwA4LbF0IKiw52DPBVp++TcSl5EGS6OAqdB+K10Fm94+?=
 =?us-ascii?Q?OJQ7Jfd4qHa1kwcO2/oZ2KJa0Ab1epb5YAgmCaPnoOqiws0jdDIWEfPCeY21?=
 =?us-ascii?Q?BoXomV311le7yy1BrNhOxbXWktcdJzJf0LwHCV8qOGelyZ3JZeSr7KePRJi9?=
 =?us-ascii?Q?czHe+dshIw0cDsybGue71l/qGfrZ8Q9JHehuHxg9K2rfWrIjMGX/OzWtnWk2?=
 =?us-ascii?Q?0WbeNUuJVo1WhRvnpUBZT08EOOJpd0O1rnYUAA/9vZAshK3hC8TAPgA6jlsJ?=
 =?us-ascii?Q?gHSYPt+mpa0FlLHpHAGICLk8mBN8v7xPlWFRPeTWcvp1gW1Q2fshpZHFxMy1?=
 =?us-ascii?Q?RhsM/dvf2T0HfC8pBAC9ZU4I8FjgmCQGIr7wpCpumyz5kWasjRb7Qwj0hYos?=
 =?us-ascii?Q?sSNZs/TW8KASavRDw1hxoj6TjyRhYJMihcPh3HgKxzHT5Iv1cUfJHP4doJXU?=
 =?us-ascii?Q?jm/VjM2ncAzF3y2ZTenyW23gra2yet5URhLob5rDRnxFIh2Guj2IrPPdmj6t?=
 =?us-ascii?Q?UVI0TPLWGlpa8pRMeCcMfckpRz7x4eJwgl+JYoSL4X3v+GDXsz9tsPXssL+H?=
 =?us-ascii?Q?FJ2ElvpRcKDpIB6X0Lo8dBfJ0NqRxiak9mwIXna94yInsJvekzZOf/M0/wBY?=
 =?us-ascii?Q?g+3tej04bxRfcElVJWJM1edL34AiIY9ItKAyQHrrtJSV7DgENsfLBAJRYEhY?=
 =?us-ascii?Q?bvnoHxJUJnmKrQ2FkB8N0UiPCe/TEjQXH0xp5n09MW6UHrMVu98ASqCM6qk/?=
 =?us-ascii?Q?a0FAdTLK5bF2JtJsBzN8S/0NzuhmFU5n7b6xuJNsgc3G4BH+r02Ht2Anu/oR?=
 =?us-ascii?Q?rFk7h72//khYc/AH2QxxziH3EZP64eKgslo5j797gKwX6jZOYasky5cI/WAP?=
 =?us-ascii?Q?q2tQXKq1i+4dHGg3Zhg48e7S1Z5Cn0VWr9DjOWj/x4ZftrLiDXkkME+IEkVl?=
 =?us-ascii?Q?gJzrok9BME8NVzvaiJ1I35dNiDJVgsSHYNSReTMLMqVOOXigQxmn7mjCyyCL?=
 =?us-ascii?Q?FvCUusbsgFe6Vrlq5dSjM2QdcjLGGwBDsR9PeguMU6tkJX7naVF2BydeLffl?=
 =?us-ascii?Q?RjEK5IArrdsC9uarLV2X8qNJOrCQzbNEB5Sf68B2Jdi6EBUAxOJi9NkSOXtE?=
 =?us-ascii?Q?s53I/lTn/NGncSM6H2Aeewsmt+mF4oOHgmjssJ/PushN3+vfbZvEflwsQXxA?=
 =?us-ascii?Q?rjfDPQCiF72RblT0q/BAe633SlMywP31YdY+HAq1cHtM8wGp0k3x1jLj0PoV?=
 =?us-ascii?Q?G8bJT4TDvppszQ++yOF993zOym1k8KOct+knSIuM7z6IHq0BChKvpWzJLuqB?=
 =?us-ascii?Q?wl4UEiPfTT8wsOwUhQLJPKZnCF2bfJcw1rqN6P56ZKcW2Yt2E9SD3ySfgUx1?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ac76fd-ba61-4f7d-e237-08dcb941527f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 13:35:39.0571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hd0lkD+7WXxidKJ8rWsCLy7MEGSfXKeB58uZHmJINz9ZQLZms9/DNJ0ENtrg4Bt6cdEyKO0FECbAsLoEW9AewQZLdqtyHeEJB/1XqaShFIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8353
X-OriginatorOrg: intel.com

On Thu, Aug 08, 2024 at 11:35:52AM -0700, Tony Nguyen wrote:
> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> 
> Add the following ring flags
> - IGB_RING_FLAG_TX_DISABLED (when xsk pool is being setup)
> - IGB_RING_FLAG_AF_XDP_ZC (xsk pool is active)
> 
> Add a xdp_buff array for use with XSK receive batch API, and a pointer
> to xsk_pool in igb_adapter.
> 
> Add enable/disable functions for TX and RX rings
> Add enable/disable functions for XSK pool
> Add xsk wakeup function
> 
> None of the above functionality will be active until
> NETDEV_XDP_ACT_XSK_ZEROCOPY is advertised in netdev->xdp_features.
> 
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/Makefile   |   2 +-
>  drivers/net/ethernet/intel/igb/igb.h      |  14 +-
>  drivers/net/ethernet/intel/igb/igb_main.c |   9 +
>  drivers/net/ethernet/intel/igb/igb_xsk.c  | 210 ++++++++++++++++++++++
>  4 files changed, 233 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/igb/igb_xsk.c
> 
> diff --git a/drivers/net/ethernet/intel/igb/Makefile b/drivers/net/ethernet/intel/igb/Makefile
> index 463c0d26b9d4..6c1b702fd992 100644
> --- a/drivers/net/ethernet/intel/igb/Makefile
> +++ b/drivers/net/ethernet/intel/igb/Makefile
> @@ -8,4 +8,4 @@ obj-$(CONFIG_IGB) += igb.o
>  
>  igb-y := igb_main.o igb_ethtool.o e1000_82575.o \
>  	 e1000_mac.o e1000_nvm.o e1000_phy.o e1000_mbx.o \
> -	 e1000_i210.o igb_ptp.o igb_hwmon.o
> +	 e1000_i210.o igb_ptp.o igb_hwmon.o igb_xsk.o
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index 0de71ec324ed..053130c01480 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -20,6 +20,7 @@
>  #include <linux/mdio.h>
>  
>  #include <net/xdp.h>
> +#include <net/xdp_sock_drv.h>
>  
>  struct igb_adapter;
>  
> @@ -320,6 +321,7 @@ struct igb_ring {
>  	union {				/* array of buffer info structs */
>  		struct igb_tx_buffer *tx_buffer_info;
>  		struct igb_rx_buffer *rx_buffer_info;
> +		struct xdp_buff **rx_buffer_info_zc;
>  	};
>  	void *desc;			/* descriptor ring memory */
>  	unsigned long flags;		/* ring specific flags */
> @@ -357,6 +359,7 @@ struct igb_ring {
>  		};
>  	};
>  	struct xdp_rxq_info xdp_rxq;
> +	struct xsk_buff_pool *xsk_pool;
>  } ____cacheline_internodealigned_in_smp;
>  
>  struct igb_q_vector {
> @@ -384,7 +387,9 @@ enum e1000_ring_flags_t {
>  	IGB_RING_FLAG_RX_SCTP_CSUM,
>  	IGB_RING_FLAG_RX_LB_VLAN_BSWAP,
>  	IGB_RING_FLAG_TX_CTX_IDX,
> -	IGB_RING_FLAG_TX_DETECT_HANG
> +	IGB_RING_FLAG_TX_DETECT_HANG,
> +	IGB_RING_FLAG_TX_DISABLED,
> +	IGB_RING_FLAG_AF_XDP_ZC
>  };
>  
>  #define ring_uses_large_buffer(ring) \
> @@ -822,4 +827,11 @@ int igb_add_mac_steering_filter(struct igb_adapter *adapter,
>  int igb_del_mac_steering_filter(struct igb_adapter *adapter,
>  				const u8 *addr, u8 queue, u8 flags);
>  
> +struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
> +				   struct igb_ring *ring);
> +int igb_xsk_pool_setup(struct igb_adapter *adapter,
> +		       struct xsk_buff_pool *pool,
> +		       u16 qid);
> +int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags);
> +
>  #endif /* _IGB_H_ */
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index bdb7637559b8..b6f23bbeff71 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -2904,9 +2904,14 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
>  
>  static int igb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>  {
> +	struct igb_adapter *adapter = netdev_priv(dev);
> +
>  	switch (xdp->command) {
>  	case XDP_SETUP_PROG:
>  		return igb_xdp_setup(dev, xdp);
> +	case XDP_SETUP_XSK_POOL:
> +		return igb_xsk_pool_setup(adapter, xdp->xsk.pool,
> +					  xdp->xsk.queue_id);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -3033,6 +3038,7 @@ static const struct net_device_ops igb_netdev_ops = {
>  	.ndo_setup_tc		= igb_setup_tc,
>  	.ndo_bpf		= igb_xdp,
>  	.ndo_xdp_xmit		= igb_xdp_xmit,
> +	.ndo_xsk_wakeup         = igb_xsk_wakeup,
>  };
>  
>  /**
> @@ -4355,6 +4361,8 @@ void igb_configure_tx_ring(struct igb_adapter *adapter,
>  	u64 tdba = ring->dma;
>  	int reg_idx = ring->reg_idx;
>  
> +	ring->xsk_pool = igb_xsk_pool(adapter, ring);

use WRITE_ONCE()

> +
>  	wr32(E1000_TDLEN(reg_idx),
>  	     ring->count * sizeof(union e1000_adv_tx_desc));
>  	wr32(E1000_TDBAL(reg_idx),
> @@ -4750,6 +4758,7 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
>  	xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
>  	WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
>  					   MEM_TYPE_PAGE_SHARED, NULL));
> +	ring->xsk_pool = igb_xsk_pool(adapter, ring);

ditto

I was recently addressing issues around xsk in ice, see:
[0]: https://lore.kernel.org/netdev/172239123450.15322.12860347838208396251.git-patchwork-notify@kernel.org/

>  
>  	/* disable the queue */
>  	wr32(E1000_RXDCTL(reg_idx), 0);
> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> new file mode 100644
> index 000000000000..925bf97f7caa
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2018 Intel Corporation. */
> +
> +#include <linux/bpf_trace.h>
> +#include <net/xdp_sock_drv.h>
> +#include <net/xdp.h>
> +
> +#include "e1000_hw.h"
> +#include "igb.h"
> +
> +static int igb_realloc_rx_buffer_info(struct igb_ring *ring, bool pool_present)
> +{
> +	int size = pool_present ?
> +		sizeof(*ring->rx_buffer_info_zc) * ring->count :
> +		sizeof(*ring->rx_buffer_info) * ring->count;
> +	void *buff_info = vmalloc(size);

You need to take into account the rx_buffer_info_zc in the memset in
igb_configure_rx_ring(). Also why vmalloc?

> +
> +	if (!buff_info)
> +		return -ENOMEM;
> +
> +	if (pool_present) {
> +		vfree(ring->rx_buffer_info);
> +		ring->rx_buffer_info = NULL;
> +		ring->rx_buffer_info_zc = buff_info;
> +	} else {
> +		vfree(ring->rx_buffer_info_zc);
> +		ring->rx_buffer_info_zc = NULL;
> +		ring->rx_buffer_info = buff_info;
> +	}
> +
> +	return 0;
> +}
> +
> +static void igb_txrx_ring_disable(struct igb_adapter *adapter, u16 qid)
> +{
> +	struct igb_ring *tx_ring = adapter->tx_ring[qid];
> +	struct igb_ring *rx_ring = adapter->rx_ring[qid];
> +	struct e1000_hw *hw = &adapter->hw;
> +
> +	set_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
> +
> +	wr32(E1000_TXDCTL(tx_ring->reg_idx), 0);
> +	wr32(E1000_RXDCTL(rx_ring->reg_idx), 0);
> +

synchronize_net() to let the napi finish its current job?

> +	/* Rx/Tx share the same napi context. */
> +	napi_disable(&rx_ring->q_vector->napi);
> +
> +	igb_clean_tx_ring(tx_ring);
> +	igb_clean_rx_ring(rx_ring);
> +
> +	memset(&rx_ring->rx_stats, 0, sizeof(rx_ring->rx_stats));
> +	memset(&tx_ring->tx_stats, 0, sizeof(tx_ring->tx_stats));
> +}
> +
> +static void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
> +{
> +	struct igb_ring *tx_ring = adapter->tx_ring[qid];
> +	struct igb_ring *rx_ring = adapter->rx_ring[qid];
> +
> +	igb_configure_tx_ring(adapter, tx_ring);
> +	igb_configure_rx_ring(adapter, rx_ring);
> +

synchronize_net() after updating xsk_pool ptrs

> +	clear_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
> +
> +	/* call igb_desc_unused which always leaves
> +	 * at least 1 descriptor unused to make sure
> +	 * next_to_use != next_to_clean
> +	 */
> +	igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
> +
> +	/* Rx/Tx share the same napi context. */
> +	napi_enable(&rx_ring->q_vector->napi);
> +}
> +
> +struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
> +				   struct igb_ring *ring)
> +{
> +	int qid = ring->queue_index;
> +
> +	if (!igb_xdp_is_enabled(adapter) ||
> +	    !test_bit(IGB_RING_FLAG_AF_XDP_ZC, &ring->flags))

See:
[1]: https://lore.kernel.org/netdev/20240603-net-2024-05-30-intel-net-fixes-v2-3-e3563aa89b0c@intel.com/

how to avoid the introduction of IGB_RING_FLAG_AF_XDP_ZC altogether.

> +		return NULL;
> +
> +	return xsk_get_pool_from_qid(adapter->netdev, qid);
> +}
> +
> +static int igb_xsk_pool_enable(struct igb_adapter *adapter,
> +			       struct xsk_buff_pool *pool,
> +			       u16 qid)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	struct igb_ring *tx_ring, *rx_ring;
> +	bool if_running;
> +	int err;
> +
> +	if (qid >= adapter->num_rx_queues)
> +		return -EINVAL;
> +
> +	if (qid >= netdev->real_num_rx_queues ||
> +	    qid >= netdev->real_num_tx_queues)
> +		return -EINVAL;
> +
> +	err = xsk_pool_dma_map(pool, &adapter->pdev->dev, IGB_RX_DMA_ATTR);
> +	if (err)
> +		return err;
> +
> +	tx_ring = adapter->tx_ring[qid];
> +	rx_ring = adapter->rx_ring[qid];
> +	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
> +	if (if_running)
> +		igb_txrx_ring_disable(adapter, qid);
> +
> +	set_bit(IGB_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
> +	set_bit(IGB_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
> +
> +	if (if_running) {
> +		err = igb_realloc_rx_buffer_info(rx_ring, true);
> +		if (!err) {
> +			igb_txrx_ring_enable(adapter, qid);
> +			/* Kick start the NAPI context so that receiving will start */
> +			err = igb_xsk_wakeup(adapter->netdev, qid, XDP_WAKEUP_RX);
> +		}
> +
> +		if (err) {
> +			clear_bit(IGB_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
> +			clear_bit(IGB_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
> +			xsk_pool_dma_unmap(pool, IGB_RX_DMA_ATTR);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int igb_xsk_pool_disable(struct igb_adapter *adapter, u16 qid)
> +{
> +	struct igb_ring *tx_ring, *rx_ring;
> +	struct xsk_buff_pool *pool;
> +	bool if_running;
> +	int err;
> +
> +	pool = xsk_get_pool_from_qid(adapter->netdev, qid);
> +	if (!pool)
> +		return -EINVAL;
> +
> +	tx_ring = adapter->tx_ring[qid];
> +	rx_ring = adapter->rx_ring[qid];
> +	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
> +	if (if_running)
> +		igb_txrx_ring_disable(adapter, qid);
> +
> +	xsk_pool_dma_unmap(pool, IGB_RX_DMA_ATTR);
> +	clear_bit(IGB_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
> +	clear_bit(IGB_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
> +
> +	if (if_running) {
> +		err = igb_realloc_rx_buffer_info(rx_ring, false);
> +		if (err)
> +			return err;
> +
> +		igb_txrx_ring_enable(adapter, qid);
> +	}
> +
> +	return 0;
> +}
> +
> +int igb_xsk_pool_setup(struct igb_adapter *adapter,
> +		       struct xsk_buff_pool *pool,
> +		       u16 qid)
> +{
> +	return pool ? igb_xsk_pool_enable(adapter, pool, qid) :
> +		igb_xsk_pool_disable(adapter, qid);
> +}
> +
> +int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
> +{
> +	struct igb_adapter *adapter = netdev_priv(dev);
> +	struct e1000_hw *hw = &adapter->hw;
> +	struct igb_ring *ring;
> +	u32 eics = 0;
> +
> +	if (test_bit(__IGB_DOWN, &adapter->state))
> +		return -ENETDOWN;
> +
> +	if (!igb_xdp_is_enabled(adapter))
> +		return -EINVAL;
> +
> +	if (qid >= adapter->num_tx_queues)
> +		return -EINVAL;
> +
> +	ring = adapter->tx_ring[qid];
> +
> +	if (test_bit(IGB_RING_FLAG_TX_DISABLED, &ring->flags))
> +		return -ENETDOWN;
> +
> +	if (!ring->xsk_pool)

READ_ONCE()

Also, please test this patchset against a scenario where you do Tx ZC from
every queue available and toggle the interface down and up. We had a nasty
case that [0] fixed where we were producing Tx descriptors to wire when
interface was either already going down or not brought up yet.

> +		return -EINVAL;
> +
> +	if (!napi_if_scheduled_mark_missed(&ring->q_vector->napi)) {
> +		/* Cause software interrupt to ensure Rx ring is cleaned */
> +		if (adapter->flags & IGB_FLAG_HAS_MSIX) {
> +			eics |= ring->q_vector->eims_value;
> +			wr32(E1000_EICS, eics);
> +		} else {
> +			wr32(E1000_ICS, E1000_ICS_RXDMT0);
> +		}
> +	}
> +
> +	return 0;
> +}
> -- 
> 2.42.0
> 

