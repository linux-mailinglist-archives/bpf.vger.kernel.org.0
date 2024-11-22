Return-Path: <bpf+bounces-45439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 664F69D56F9
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 02:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D417DB21FB7
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 01:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C5911CBA;
	Fri, 22 Nov 2024 01:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hU1G7SMY"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90098625;
	Fri, 22 Nov 2024 01:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732237628; cv=fail; b=eFAjsvRWi2ogxeahnOjhrG+M0haEEe+9dS2dpz8oeVQ0qJhywAhjgvgvaNZJCNQsccll5987mItHQJaAmkJx+div9l03lAop84cBusRpa+C+zCAqyJqY2K3mRNm5uM5aHSJn1IVbyLZIZuv5/FbaCtowhPSSRX10DL+0Lmhjl/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732237628; c=relaxed/simple;
	bh=+oq2XcE2X2s3+4jX1x17xXO86CR16qeFOIGk94t+Vtk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T8cW/9e9hYJE+810u7XQkTxcqLht8VoFvqspzTzIxni07OmYk35dA5QFLDpTNJmCzHlMmb/Qb/TAVJE4PZfzcXCjFh87qwy6LaXofYA4A7ra7L2LeDINbb4XIpmJCeqkUbzik3BIK9d4ajS+Ac322A4cpAcGjQ6klcyMbjEIgDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hU1G7SMY; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732237627; x=1763773627;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+oq2XcE2X2s3+4jX1x17xXO86CR16qeFOIGk94t+Vtk=;
  b=hU1G7SMYrX15WwhNbKQOS1oTq0Oo7Uvmehta1iH5Usf/FVyu72qW4Vf8
   ghKfI54sZMiCgivKv6li1DZhg6nTTWnH+xLC1IMZ0IKC0beaQR8z8MIdc
   K5D3+8kcB1ddZS8/Wz4kSegSX+Ky/mO+SS1TZVwLQq+RvxuSXjq8/reWF
   f6T/dyKH3VkTRywXwYQuZBEWt6yZjtNwUzYMoLzVK03+lsb883/9fkzOS
   +9EfoEH68Aryen/yEpp4mmEwuLLWmSFTvXfITBV0/OeQ/wz6V7b8+iIL2
   foIjVyfh81yKIAA3UxNkSjADeoxNDdP2sjkci0V9Yqy7lyicgwPf1aH0H
   g==;
X-CSE-ConnectionGUID: xb0ZIG69STGR9iBBJejSzA==
X-CSE-MsgGUID: V04RHv4kSvq5KtphJm5qPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32522955"
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208,223";a="32522955"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 17:07:07 -0800
X-CSE-ConnectionGUID: t5YuGXlURouQrF3ij5V3Qw==
X-CSE-MsgGUID: jh68NFhiRQSRndX/SsqRGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208,223";a="90407464"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2024 17:07:06 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 21 Nov 2024 17:07:05 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 21 Nov 2024 17:07:05 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 17:07:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrwm69Uk4+ZnBTHdejXjbCaP646EE6Wp2f6n6z6mSlvY43LcfywcxAPZpp+KpnWP13K3rQP9I0yu7C155kYjY3+itBU5BomF+JktageAmtiw+RICjPSmJv2GMrxoRLNMWD8f9TqKelneafNWe3sclL+9oSqYWEgJ+DhOIFHlpf7y7fkVQFQYApwZrp621/T35446KfHqMCANHTL1849qbSn+mPCh4wxkeR3t2EK1uqrsEEaODaXKfhIWS4dXzKY+IQRWjxopxXl+39mrLVLJAeSCquAQQqyrLm4XoIvJYJYo6bjQN6wIym1VenPVicZ3QujatzeoID4uSxOk5SDa5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDbHOdayd6ZKfovYOiIbXBMRs8uHHce6yqWiu70YT9c=;
 b=miNL0FaEzeu1ibaJsyGg6G0BsVwTwBiKSBRnCzA0DGQzQNRfvIpiPK/ZWcC+RYJph+x4RMDHkp+L0V41ojHKKc2Fa+YIwdVayfaMIvG0417wUV7yCQuVEqrQQL7ZfFfJhC3xM+pxGWr+bYwkZ8G2N4oAgZxlV8qQ5rsGrGT8P8gHRePLKn0fWBtdQ3BsKzvYIhsgUWrPT6JwWv1N6B2ulpGXRYje5IWmnR/t4iXJjZa7uP3TGYvYEafALKr1qmSZ7rw9+IY1XVN0RXbrYJCZJA3iL6MRrnKpokr9umW3hoRFSGEH4eh4tUMFT3xqoPUp0nJcjSpyNPudRCF1e1pQmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7444.namprd11.prod.outlook.com (2603:10b6:8:146::11)
 by SA3PR11MB7609.namprd11.prod.outlook.com (2603:10b6:806:319::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 01:06:56 +0000
Received: from DS0PR11MB7444.namprd11.prod.outlook.com
 ([fe80::fea8:e53a:7a96:7fe3]) by DS0PR11MB7444.namprd11.prod.outlook.com
 ([fe80::fea8:e53a:7a96:7fe3%5]) with mapi id 15.20.8158.021; Fri, 22 Nov 2024
 01:06:56 +0000
Date: Thu, 21 Nov 2024 19:01:56 -0600
From: "Olson, Matthew" <matthew.olson@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
	<bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next] libbpf: Improve debug message when the base
 BTF cannot be found
Message-ID: <Zz_YBK3SWnZnze-n@bolson-desk>
References: <Zz-uG3hligqOqAMe@bolson-desk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zz-uG3hligqOqAMe@bolson-desk>
X-ClientProxiedBy: MW4PR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:303:8d::13) To DS0PR11MB7444.namprd11.prod.outlook.com
 (2603:10b6:8:146::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7444:EE_|SA3PR11MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c037c2e-1c61-41c9-3110-08dd0a91f5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eFhlhKetBQ9K/YZjRfCs0qAAdItRtnHbOcXOFvbVlP5WyGvfd/x0x5DHnpCP?=
 =?us-ascii?Q?HHgrCZuBL/hgW0VkzepjDkTcPX3vS4KfssIpcjHhqof63mLla5TQUHZxiBjJ?=
 =?us-ascii?Q?j3KTGcxuk9AOb+G3LFeC9zangHjoNb7fJzd59blmSTEzcbm8+K7SCyGn9iHN?=
 =?us-ascii?Q?mlI1yZVCwjWZwAKtGt3CQGNgm+f5RgI1QSdRCogFV6W9N+KED7bQgk57kiUh?=
 =?us-ascii?Q?JovMEw1MVbv16Z0bmE1R+c1vOTlNKi8D4l+fKhPFuwSuFXDTSAwx7vZN0qEi?=
 =?us-ascii?Q?C/DbxHR66A28DPx0L2XRBzTfIkuIH/Bnn82MDz2PTQRH4ET5875EVMxM8mlA?=
 =?us-ascii?Q?fHe7pOQvk+Yn1Qc0jJq7UXlrumWtRB0gWzDTmSUiEKtzmRe/4YI0iHykIZD9?=
 =?us-ascii?Q?sGgZQVmKpd9Cs8bXrN3zQjgahyMaorCztIViLr9ocrj4fy02SI+Yhp2eVaxv?=
 =?us-ascii?Q?nIOav0laIGLocGjKHsDuOUwnulpEvz5KB6/P1XnTBH+sanrU6YwidjNSEbYR?=
 =?us-ascii?Q?LNSuHal8td5uhr0MhZrn0wSA+vvCfd+4aTgUVXLBevbAnuH7HDJiKxGHAj0a?=
 =?us-ascii?Q?p2uT05uO+meRfddAyd3xyZZds7NxalPgUsnvrMK5nm1K4dgDBkVkEBGYlq5l?=
 =?us-ascii?Q?LjLD5/viI7hhijvdBT2M1tgyDYb5pM2sWoKVnyAzkA9NqCfNjsM09w+YJlbk?=
 =?us-ascii?Q?Py5Mo/M877MYVe2WB0rMe/EA7m4NI7sP0AOsu2KMmb3T9f5syigUjYlY5oE1?=
 =?us-ascii?Q?mlmM5gbqt/qz3KAWVNHrEylQ3vbQHrbOzdLzTshghr4shX/SBZEM+KVH0P7k?=
 =?us-ascii?Q?ry9ksnWH/vzN3crHapTfj8s6efb+iZmJEyrxPVAX7OaQ+CadQlrbB7bWBK1S?=
 =?us-ascii?Q?vIdUesMOYqaH9U7vislN+3gni4poXovQZjcDTc00WA3pujKfik4cJMtw8CWV?=
 =?us-ascii?Q?Ub3ERwCXMHYvyW+fXmsRhVX5jIDtNNCs2oquVst+M7R7tvDlbv8egiXyQeue?=
 =?us-ascii?Q?dXr+YXzE+BG11TpAS9i5FxH0MmVNZSpDiyMH3gfFkppum53I6GScSCILpqbA?=
 =?us-ascii?Q?nYdKClh0VzsFDIAdu/APQA7whfE1vNEQHNHcusF+FTJNX277yHdP03OCbOtm?=
 =?us-ascii?Q?FjxNvsfQ/C/3X3GF+9P05XsTK+k/XHl7hsoaLeVOwJDRZb4dX9krPAwV4BW/?=
 =?us-ascii?Q?dgLMny4xX8r1J0/l/nnxP0RRHZicwb58elg0KBqs0tvAxAhjSoH37hZGbNnW?=
 =?us-ascii?Q?H0g1XlRR7FjLOHkAWw0GyfVZYbUy+DHX4knt7e49Vho4MBdrD9u3cuxy7Pl1?=
 =?us-ascii?Q?QkNSsB54TufDh3jGL6I/Mobp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7444.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A9wm7AaBfpZ15u18yvuCvDlQy2xlMWI5MN0BB0VMW3uzyDJHEjdaSApYyYMl?=
 =?us-ascii?Q?kD1mVuJGH8xAC3MROobYR3/yGo6KaJmYpExZxvJ62s660FSQsgFG61Ywmzqu?=
 =?us-ascii?Q?fKCNoAs64pGdDAts7LyQN7UFSgJ36r2xrtO6X58lJr/025AGoj1zvHJCJ9Gk?=
 =?us-ascii?Q?Stci8SDrrG5fGd7WzWKepMAbVhzvgi98vWtJ1vHNrmEe/4ZkMkwPYZ4pVkwA?=
 =?us-ascii?Q?gjQ81fbNu3WBtJSJkPy38JhghDH/bMjwmVI9w3Id+lurdbFVkWxBHB6r1g63?=
 =?us-ascii?Q?y2WPCLbSb7N2ciHJEKXH3wo+edd/Z5QfHxAp7wixzD2uXWm1+wcAeWNgCjaj?=
 =?us-ascii?Q?z7LZnPqpneZnzXlK8RuGzFAoZ/lL2enBUSHAinT82n+2chTZDtBgu7nZ/SO4?=
 =?us-ascii?Q?knuxG6b5LEpCXQVxPrIh24F3pqRWdCdWHuefMHrDgQLQPv0OgBc84UZpsjoD?=
 =?us-ascii?Q?iLs9tT3U3i6aa+3Twgb+nEGML+ilvW9pC33VIG9Nmnf5Quy3iHlLgU4WTY11?=
 =?us-ascii?Q?ZDgPkfJgbBn88xNS3n9tuyUcdrYEGbupl00WOtFGVJ+rsuOhYxPNc6vU6+qD?=
 =?us-ascii?Q?qOmCv+IXTHqJGw5autriDJs4v25q1GVMKrobT26vitLDexpgZZUUTz9X5Fm4?=
 =?us-ascii?Q?3v/Lc5mk9T7S13IGXnh74jDU7JAvDsTiAWuiyg/F/c7+QbS/esGVtoXMmSwt?=
 =?us-ascii?Q?OwZx5Vx2KOnX/gghDCH7ZblZAcaEF95yCmIsBz35UFMY/c6WiFPQJQvTk/tX?=
 =?us-ascii?Q?lTzVqgPlJgqzO3uf/O1Az47pU9V2wP3kVj6xWk8TZphtitKwQJkXKgv/Vr+9?=
 =?us-ascii?Q?ZXp2ks0cSc5yifR8Ccy6OofRDAv7eW0HLm81+4DIF6HpmJywHqnNetrmPUTi?=
 =?us-ascii?Q?x5Hvgs3ArtHdCiRES3tKeRKBya7JZ3sKDjGb2RvHHbggO06xd0a07XmbCGOu?=
 =?us-ascii?Q?kxsHNAJUzJDuH/v4OR+3Z4iYlbHJtwqS8naLFtFiUyDyjNoDzBdPVtul7VO2?=
 =?us-ascii?Q?pohb2GWy6fo+TSh8AauXlwWw+kO/E9Dx+D2LjP0XDmAvFhYEt0EU9CwW8YIZ?=
 =?us-ascii?Q?ts/72H1nSGmGZZRgA4cuuuZAJ9wQSTd8Mlt1MV6UaK9x4vhUaiTix6frNn1b?=
 =?us-ascii?Q?6ukg6R+jlnsdS3H3yjFsdoa1/XOcopsEReqmLvjRz46gBv+3k1VT/fYhfshA?=
 =?us-ascii?Q?3dasIZKpJXSHlxG4Vtv4XAD0CpQ/5xgtF8QV2BzjUvoQ7BHsX4p+5STjTtxF?=
 =?us-ascii?Q?Xdla467QXz08KLhdNtG8PHWDwD9NBeepu2N8NURtKdSM0nLRVQUl78Yt9KoF?=
 =?us-ascii?Q?DCeWrhvJ8y2X651uItFLGqD74QTV1Cyk9oaTKV5IDA0hFZ2Tiu7EihFkVK6I?=
 =?us-ascii?Q?X6rUXk8ZgAGmXA7zmJdLuynjbYiovNsQd1cJs5QVKsqpnU6AHRpIux6OdXNn?=
 =?us-ascii?Q?LcFXBzxyYbM/Qs6x++pLNJXiEHaX3P1oZfRc1dVeRG6/MHsG29CDgJvS2NQw?=
 =?us-ascii?Q?/rSZu6jLoe4dqvM30O72gBflZDXGCdc0iLKvmxORcKwBJgDkKV2ykDFLdbbY?=
 =?us-ascii?Q?N65J7JeX3fOEli2ZcpcHrepJPTdUAVXdPbzd3G9qo5anKNkKmcNgRw1DKahC?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c037c2e-1c61-41c9-3110-08dd0a91f5ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7444.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:06:56.6211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/w2HNQs0MvrE1Hdd1MsvNpLsyIsX5zi42Op1jlSy5IDpsW7RNBy8x8dz878J+JGCN1Nf9TFknc8iFAz0VOOkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7609
X-OriginatorOrg: intel.com

From 22ed11ee2153fc921987eac7de24f564da9f9230 Mon Sep 17 00:00:00 2001
From: Ben Olson <matthew.olson@intel.com>
Date: Thu, 21 Nov 2024 11:26:35 -0600
Subject: [PATCH v2 bpf-next] libbpf: Improve debug message when the base BTF
 cannot be found

When running `bpftool` on a kernel module installed in `/lib/modules...`,
this error is encountered if the user does not specify `--base-btf` to
point to a valid base BTF (e.g. usually in `/sys/kernel/btf/vmlinux`).
However, looking at the debug output to determine the cause of the error
simply says `Invalid BTF string section`, which does not point to the
actual source of the error. This just improves that debug message to tell
users what happened.

Signed-off-by: Ben Olson <matthew.olson@intel.com>
---

Changed in v2:
  * Made error message better reflect the condition

 tools/lib/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 12468ae0d573..a4ae2df68b91 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -283,7 +283,7 @@ static int btf_parse_str_sec(struct btf *btf)
     return -EINVAL;
   }
   if (!btf->base_btf && start[0]) {
-    pr_debug("Invalid BTF string section\n");
+    pr_debug("Malformed BTF string section, did you forget to provide base BTF?\n");
     return -EINVAL;
   }
   return 0;
--
2.47.0

