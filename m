Return-Path: <bpf+bounces-42301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0C89A22BF
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 14:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC57B23059
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 12:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537951DDA20;
	Thu, 17 Oct 2024 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQjAlqJ7"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95761D8E01;
	Thu, 17 Oct 2024 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729169412; cv=fail; b=YdFqMcv5krdHhAY+l+BTQNF5ZdMBZhVgJ4ohVqqdflklAtMzuphhrvDLZdjaSjk4xYIGSWfkRYRMK6mrdujpFisqS2UcYg8bYjWaRoQqNK2dxrP0iGHKYxaIlJGQMd5+HCLZH/UaepzovQt6LKTm8/U8F+yQ3LZ2GXXaTJG5gZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729169412; c=relaxed/simple;
	bh=jemBiRdR8f27Nu/l/bt7OtxzZWdrx3HeMDqSPKIzX3U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c+nJfskSBmQ+ag5P5+thgtUfZ/b0MocOXARqDlFB1LTtKwZCE5fnSgA53N+zXvR3n4iSUlDjMqnt0kT6p+SatO122OOhpWf1hUS9sHisTA2cixzfWN09oycIBG74DGCd03Kc3TyMMglVVkGOrPaC3ydlNh7QDxXYuszwDjSVnVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQjAlqJ7; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729169410; x=1760705410;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jemBiRdR8f27Nu/l/bt7OtxzZWdrx3HeMDqSPKIzX3U=;
  b=lQjAlqJ7shWxfLKoFt3MdetSNnQR8Q66IeE3peukT18VGAG3jwTZOsXG
   0CMweMWOqjmgjB9UzApvBX074k/uD77rNY9y13rRKxadNHKmpnyhJMFYE
   0aOmWB9zFfmDJzOQaxvS7uKw9kesa12vdBPesX6ldxql6aP+reieZIAag
   u/lYg4URL5nWWEiOtLSkQUcof2QLWKdoULsEznOEWAr8rItQaSx+TIdFM
   of0TIa8WR/9dIcTVT/4AZUpsM3yzVjCF1gFz2tcDvvG1Z8zgLDQBhl+Xe
   ddelJys9JdnLKc1RWgsZ2mCeLcHbj5Hq0N9fETVH4+LP1zAk4L6cHhu6o
   A==;
X-CSE-ConnectionGUID: 5fPxExsMQ+i8KUYKCwRS+w==
X-CSE-MsgGUID: 3WMZ7+7aRVqoDYvo9tC7Cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51196735"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51196735"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 05:50:09 -0700
X-CSE-ConnectionGUID: WaDNSJ6gQR6JfwXi4KS9rA==
X-CSE-MsgGUID: XiK28wYrS9CoLYOXxfUOvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="79366633"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 05:50:09 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 05:50:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 05:50:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 05:50:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lig4e//SHcJPw2AT8hkoNA/shQQeFuAalGJStoLL0X6RxRNLyAgbajMKXbtr42t6u+n56afJ9EZDMySj8DS3H2BPJSqs9xgj/2xm+Z12FsY+w9tFxlWUFBuUzL12BMulI0oZAzmmP6Zuwk447P+YAd9VKUxBimsXakC5P9nZE23/+pOJAGduNqiZL7TIB8msb5MJj8ihwIN0ols0OQuWI9MPRdrUSg+W4CmtppfYOMenQRmSI1RIJEal/+e7SByrPYhmBDfPguPQp+iD2lD7R7lNO3a1Ry7ovKZ0gIdQw35W2z0bBnwQJGfIrrX7GxS3iRsYSdMM5fHzxAxhsm3cDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnhzipI181xKfzeZFlKyEYykJmpumb75+o7+XRFC+tc=;
 b=S5cYYbV1Z5DBZtqFczFnCDNO8I2VEnSjKf3PATMp/srugur4KyWnOi2C13UJLBH19c0AoF+UmxcinGyppbUfkKJ+xZCC0U2rwGc5k85wvNpsavsSoIDoZuKx6s5I8Up2PmLsI2acqJffnV9UXmu+eetZOXpyDtp/31elofaxIpp0SvkVgSCcqUJyxGTIBokvStJuB+rFkvsQNLkH6uRyNzoTiPthLTgppp7a3SWIHVaPfwfGCUBzbtQIRX7nfNQBpll3sOqZdLU8x/hRL1eTruP1LMXz0vwRGRSxVoQcsj/3+3tU31gmRPe0yNSoAyXSLAibvpGtD6y715r74m4OCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH8PR11MB6832.namprd11.prod.outlook.com (2603:10b6:510:22c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.20; Thu, 17 Oct 2024 12:50:04 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 12:50:04 +0000
Date: Thu, 17 Oct 2024 14:49:51 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?=
	<toke@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 13/18] xsk: allow attaching XSk pool via
 xdp_rxq_info_reg_mem_model()
Message-ID: <ZxEH7/+6sSSTCHIK@boxer>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
 <20241015145350.4077765-14-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241015145350.4077765-14-aleksander.lobakin@intel.com>
X-ClientProxiedBy: WA2P291CA0038.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::8) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH8PR11MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c5968f-8492-4887-08fb-08dceeaa3899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CS7EdENPQbXYzT/qV2KRD+CrNa5gxNue6R/p+tlW80AANu2lt6M0SK1VstNC?=
 =?us-ascii?Q?kQabGP0zkKyjAm2q6c4EkrDjzZIgbaXe4/fVOqX/QuQelBF4bExhTVUvswVa?=
 =?us-ascii?Q?1ijcqgUKDzCAZIa6oiGQa+LcBVrnv0keAgv1rX6XYxLdwWWISS3t0KITLgkp?=
 =?us-ascii?Q?Cwd09uFjCx3jJzxIxaIUUapoAPKh7oI3wrJgiF3V+mFGJx1nwJIY8s8trYQ2?=
 =?us-ascii?Q?PpVwjaR2xsncfeG7Y+HHZ1NPVRe7tWelSlcJc9IhS4GkMA1BOW3jw9kE5ckX?=
 =?us-ascii?Q?t1pUt9/1JZV2uWhJwRb3NB91Re+eDSxvelW+6CXwPAr75TSri1NpRo6Lu7yk?=
 =?us-ascii?Q?rdwoWYLbRvDjg57kH8ptMcWrxbXiSQwluKbCi/gUOpLi/rFav95mI7xWLD12?=
 =?us-ascii?Q?6xGHI6i92cbq5xeM6WR8vrsRpoZ4W9wfhBS25TQAbRxCqqJ7D5uO024GcaE6?=
 =?us-ascii?Q?/bxgJ3/kBWzC+ZfkZnH6DFNYs5qULYum3Pmm8/hUf/pm4bqfjTwdPidNOXmy?=
 =?us-ascii?Q?jUyGSwFvmuPnorVKPYNVwUA06ZtaFm/76EBbFwsCEFmSr/o2H3VNRSocVhRN?=
 =?us-ascii?Q?fl/G2eo67hFrlNRTGnemRMEH0X7hbnuW9vEYflpzlcbuOzzUp2L+l1Hr1jQK?=
 =?us-ascii?Q?D9eAWq3C5gyCjwh2ITc0YeC00HGd5x9lkQZgnJnvNY8iLiZ6LUvPfEd+LFmk?=
 =?us-ascii?Q?S+1iyKx/CSemnGDcilIPfv0ULs9t/m8RJTE4t/PwrCLw4yWnwgmeitzlIzto?=
 =?us-ascii?Q?/Wet2bPrb0eTj6viHCKrqCi91VHruJAU1+WwLMPs6T15LyWbmixWvzUCR+GU?=
 =?us-ascii?Q?FtoRtf74loTt73mmDBNWOu1JVCPN3D2Btyi+U2bg72iZjXIt6qxZ+wxGhD6F?=
 =?us-ascii?Q?9LOhOiOfTRba3XK1XkucNzk4PexqGb56gzjCeYYtPD7qtP5xODBI17LsFrhq?=
 =?us-ascii?Q?2wBRqj6p2JdxiuDRmlgvru768YIFzj4PET8Ug5IpSaj4mIk0bZaNyvgoeplG?=
 =?us-ascii?Q?8IYf39mFQAFaUpR2CP3IWAIENuF76ubjQRKBpZftvVc/E6G0BQpSKRN7LkeC?=
 =?us-ascii?Q?m8G8yK6PgYmG7PqvGmkx0+07HwtT2R2qOMaRct26j7xgsnic2bdRo69hCVgu?=
 =?us-ascii?Q?Zgrv8ZmzairPo5CiSc4k6JbFNyt/1WlmP/GNyIXhPAQl6enZqg8OzU14mSyf?=
 =?us-ascii?Q?l/GYmxMAfTxtvHROOfvRrQdUKeH/QTSQbbJrSrF5tJkJCV/RySqExNTMmDYK?=
 =?us-ascii?Q?3Hdt8hxpYhCkkrqdlghh9bkbFSpyYNr2Bwg+r2ibDwjD2OJYXytgOaU9A+0U?=
 =?us-ascii?Q?xJpH7eSjzzsqB3IeJYPri5LV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NN7dynEWJ21B+DmgZO0S55eFQapReGpP8GiqVt280QyF8gMLpi/4q4gb0g0P?=
 =?us-ascii?Q?HDnpjQqQ8LKo/ppmOULTtjVcBz0z/1egRKs9AvVic1PfQOYjeReyAQeBYmI4?=
 =?us-ascii?Q?dH79iZBdtAb79jxKLnef3mSpDljbUffnN/waNYo40pbtbLGWi+rLsnTE1coV?=
 =?us-ascii?Q?wTukbKddCx8osHqekCUfzvaX7XjFF9zrH0r9mHemAuZKzXtZDr+qG2tics52?=
 =?us-ascii?Q?wdmluqTXdj04/wBEy9v/zClw2g1l00W806vvutee0TnZRswi4brinY9rTV7F?=
 =?us-ascii?Q?SqR4LYYjGETOxJ+5sGDB6LPweVXqcIWDPuNBj7bM/GBdhMNTyaivB3l36SEm?=
 =?us-ascii?Q?57NlGlKkdUVy2L8CR2r/kMjIZhlb0KULDxlwX3DqxalXkkrl3dckckmsYAsq?=
 =?us-ascii?Q?fcJO7u7Nkw9Wsp/ANKUWNHkwb/0BFJoD5KWFZGK9RjYaUYF4z/B4XPME+eqN?=
 =?us-ascii?Q?BAHMKebPnDGNcvxTCA3AgFqRISZxP6dA4/KMNZtvDCU8UvhB4u5J2GGyH+sL?=
 =?us-ascii?Q?kivuSGC2F369wNgJF3N0B2/2DwWQgmzRjEjgeyATPVasIhjzRK3tKYLJdyOy?=
 =?us-ascii?Q?mY7Be9JRIIQYWhzq27USQUl5a29pln6AUkH/mJguMx7PelE2edf+fNGGdwxA?=
 =?us-ascii?Q?xCCP6/H2KlNZV49h2yBr/dukR3i8+8dbRmQEn1R1DViKrw5EXlC7TozKRGfN?=
 =?us-ascii?Q?d3QglY1CuoolS6lqFiwroX74hXkGXLRHHSGip8NVGSMpRZ5nDB5XG/WeTvvH?=
 =?us-ascii?Q?RsR1nhZDqg1sTsGlXNd+DB656G1qJfaPV2I+XBKppinFy8ttQcxcIFp7nLkq?=
 =?us-ascii?Q?A+cwK3oYFryytJnhAPLh2vIU77b/s5R1eOfbp7qysWt/FS/4iteMgXiGPQ/I?=
 =?us-ascii?Q?Hych58h6HCXzbo6IPImHcV/X7ZEMgcxcdgsJoXKffcD/kt5xNRJbsJsQZiS4?=
 =?us-ascii?Q?OEcsbIZ/+mgeAQoMOFZeL6cmwLu8xEEhGvZuAqeiuDV/UVrrYevT2n7mxrbR?=
 =?us-ascii?Q?e92gaBYeXVTSi5r0bToe/U+I8Ful5aH16C+mp7Kqc7z0zM8AL9rEdV+BoWLU?=
 =?us-ascii?Q?HaS1tRXMa7bE4vwF/x+7MP0foC6fcwpsUl+HAQxdhMqyMn8Vb1z44wse9Tsu?=
 =?us-ascii?Q?qiURzuoj0iFQEtvSENbqamy4NXU28I2z+/QKv6kdL60vCDW1VoTrGqCHZaCv?=
 =?us-ascii?Q?vwgpPNI6YMjGBJHOcCYVIej8BAl6zIKpyT5rxzdd3xy2c4J2bCpHV7YJVqUB?=
 =?us-ascii?Q?jKVX8OW5ynpY/mlShRpJdldR0m1h9dutyw7+7kmeHlC4uFEweDbv8Ju9tRGJ?=
 =?us-ascii?Q?4KBdFNDvwRJ76s+Dd6ye2J4KNe7q/CrrZIxOLAhiMFDPG8isacY7rjuMCLHI?=
 =?us-ascii?Q?2j1PRHpVKES/6uaHL3OnbqQD1Mu+o8JN2SNRu0LG2reYCCSzyYSzweGJcq52?=
 =?us-ascii?Q?4i9woBd/QyJoS5dxImJy3FnsORMOeNlhrk9WOHkwBckAN37HARLnOki2jPyh?=
 =?us-ascii?Q?qWJVGs6wIY5rUsoKG69yI/LVRHWnSAWdo+JcGNLsjxFy6qvTDM9e3ymbbWw/?=
 =?us-ascii?Q?9gOxJc8p4sbIZwzVYP3OyiHVajOhOixNONN8qbjgJx8GGKgDUXfxks5W9Xp6?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c5968f-8492-4887-08fb-08dceeaa3899
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 12:50:04.5460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WERFEvU4z3OnTXwtoPE39ZLCr8dIfT5J25u5fvn+GQ7hF0rilVcHk4L9GFtYXpPR/aYfbDJPwtqSKSjljWifSWdBoPcru59djh8dv33/168=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6832
X-OriginatorOrg: intel.com

On Tue, Oct 15, 2024 at 04:53:45PM +0200, Alexander Lobakin wrote:
> When you register an XSk pool as XDP Rxq info memory model, you then
> need to manually attach it after the registration.
> Let the user combine both actions into one by just passing a pointer
> to the pool directly to xdp_rxq_info_reg_mem_model(), which will take
> care of calling xsk_pool_set_rxq_info(). This looks similar to how a
> &page_pool gets registered and reduce repeating driver code.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Makes sense, but why not address callsites in drivers while at it?
Otherwise in case this would be merged this would be called twice. Not a
big deal though.

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  net/core/xdp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 9dc103a09b5c..371c26c203b2 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -358,6 +358,9 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
>  	if (IS_ERR(xdp_alloc))
>  		return PTR_ERR(xdp_alloc);
>  
> +	if (type == MEM_TYPE_XSK_BUFF_POOL && allocator)
> +		xsk_pool_set_rxq_info(allocator, xdp_rxq);
> +
>  	if (trace_mem_connect_enabled() && xdp_alloc)
>  		trace_mem_connect(xdp_alloc, xdp_rxq);
>  	return 0;
> -- 
> 2.46.2
> 

