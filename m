Return-Path: <bpf+bounces-40130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E790897D536
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 14:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924671F233A5
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 12:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1D114B084;
	Fri, 20 Sep 2024 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="la8GDvBb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF771428E3;
	Fri, 20 Sep 2024 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726834098; cv=fail; b=cy/eiXI+d1ZPguhn5khZoMxF2cu0MRYVj2BrwxNX/U39IAY5C3y3oiX3SVnRSJQsbRvKWEEWzMUFexu9CCow5IaFSbHRu+xh0ui2B59T2c2tQuJ4KcTTP3cOHmPqcDFEVRHJ65VQMGrIt54UxUBa4i4ubwxn6l9xfIOyIbeIe5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726834098; c=relaxed/simple;
	bh=vW8LIZ+SiWXy2rPAp8qx9EhRLdSbUmFkpR5d4Xq4QuU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BUZWqShYJ7qPx8+5LirdV7V3GcrjfBe1pQiSxW6QDjSryWTBGxqROm4ZLmmBqRmUjA1F+VzNPw6g6Y0ns5DX5bunxrp1bnopYak7rl6fxjDnAQFfZp+sZSJJ+TCgsAbiG0+NLce43FxSavdG5le3gvzBRKq5J2IFUDxwA9S/mIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=la8GDvBb; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726834097; x=1758370097;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vW8LIZ+SiWXy2rPAp8qx9EhRLdSbUmFkpR5d4Xq4QuU=;
  b=la8GDvBbH7j37hTirzpQWw/GUcLIzHXM9OOLLtvjX1HxqSrsq8fec6zd
   jUo9ZZUZiNvbNXov+GbLHK8oPHk+Xw3vBgrxSZcrqjE6EPfn/1BCO6uZH
   p0Iv7Uu3sOnq3lyBlT+Hxcvh8a6fSh4h5Anncx3K2zScfB00yIoAMr3xT
   vofHyaSVLHGq0zu5Urebt4d8IWg5cEthHrgEthDKDwwoVm/AwILf/5+g8
   IuQIv9PP2HlEBpkDG9DQgI03aLeEwT2EPcYQdSd0hDwNUw9Lxlir+L7wz
   6N89icE7dfbwHletqsSSPaGFrtoC1Kwla8B6PkufcO9x3b9G0M1LxHH2U
   Q==;
X-CSE-ConnectionGUID: RFVI3csKR8+4NZpnZnznGw==
X-CSE-MsgGUID: 76Q3KJW2TuWPH4iEcQEwpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="43355968"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="43355968"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 05:08:16 -0700
X-CSE-ConnectionGUID: BIKsWhHhTYGlElf6TK2uCg==
X-CSE-MsgGUID: Ybigt7wGR5S5MP2XxWL13A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="70149094"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2024 05:08:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 05:08:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 20 Sep 2024 05:08:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 05:08:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMhYEQ40LfxzPYbuCR/hQZuFfxo7CiOPznpbEusJlbpVSCd8adsO1e97fIE7AcuK0Rdm7xZzGeCXa9b2xngARzpRb+7TZg5RLpFjCW2dCn5rr8Txx36qdK7X02vXnBFq9fJzB9v9sUPkY3eb6rRInAb0gK+gyuY4n3vWh1DB8VkO0nkWfBPCgm9rJOtqlnolU9fEAbTXjvOsiED4De3LEZ+WgIQPRi6oo1FzHHQNXnHLRD1Di/FEb2m/VgbZHYw2ssIWYg7UVvXe/19PsAeK59VTKVYBQ+0DqDAmT6ZRN89tP6KYRXpevHhqeZ/GD5PIMeFLACLHBRX/dl3k1+eFUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuwRjVtuDHLj6VtJnMKNIUGMCiWazvmkfc0QVmaUF0k=;
 b=eNJyB/mthe8yKZYCo253bMNd8IP5SxSUCk8sK70zn2Y5eFrpOqO51OYD1vG4QZnYjnF0Kj2h1EektDhrdb67SzcMVuHZZsqT/cdpsozLhyWC3eZBM54m9E0GOnTmW2PndJAruiF0dhQNJA83+bG5Dy0DLztPoFkltP9I4M3mNjgTufzbz8TSva8GVGr5YO/03eqEIyQoCRuH4OmI9Ka8WunILXIW68iG2KXo2m7Wh5GhPxiSv8jcMH6svh1+3JAFJUkCYzqYvauYbft7zJRu6MojVsTl096cOy9G3jRbtlDZG6+zKdyeKTPsBhgXg/SRxjS8NgyCqqA65L3+k7u17w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA0PR11MB7380.namprd11.prod.outlook.com (2603:10b6:208:430::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.22; Fri, 20 Sep 2024 12:08:12 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 12:08:12 +0000
Date: Fri, 20 Sep 2024 14:08:05 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Wei Fang <wei.fang@nxp.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <claudiu.manoil@nxp.com>, <vladimir.oltean@nxp.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <stable@vger.kernel.org>,
	<imx@lists.linux.dev>
Subject: Re: [PATCH net 1/3] net: enetc: remove xdp_drops statistic from
 enetc_xdp_drop()
Message-ID: <Zu1lpVUyiEMtQAlu@boxer>
References: <20240919084104.661180-1-wei.fang@nxp.com>
 <20240919084104.661180-2-wei.fang@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240919084104.661180-2-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA0PR11MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d57febd-b4c7-439c-ae5d-08dcd96ce624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OXKx7e1nykn0R+N6B+bh6VciKUM7X16n0SgB1jusqQgmfH7ax1WjnnHVxb5I?=
 =?us-ascii?Q?8ohmnHBKV/sp2zq4RKvjZrjR7Tc7f8xwx+iN5eSnSpTJeII25oV0TbrH7Iy+?=
 =?us-ascii?Q?kj5AcIQBhPorViRUlWFRjsIf2cA+0Qrxe+FgrQdfMurfRfsdxKZJ+x50lUGD?=
 =?us-ascii?Q?zABVkiFD1UN125ily4KqZBo/WWkKNHRwEWgZZBeAlcmPkaeIEz1cyzjrWKC2?=
 =?us-ascii?Q?IQxQ1QrzX2+mJeFMJstRfGdWPUgPKIepod43OB7PtSEAlNSuvZobetU/j77x?=
 =?us-ascii?Q?K3VNYEFqg/FII3/z/n3iRLOSFREXEvPMn3u+y6QmtWykoQ7BQQqn7ZgbW6Gz?=
 =?us-ascii?Q?9k4TvrrHHX61DsbltABwfM0ElthEn8Ii+k8scEQi5I0LiOVW1ni8KmKkvD/n?=
 =?us-ascii?Q?HCkBRv/iYDd9Gu1z9iLhsx6+fa9uloJ4f78X7VGRGT/FsCg6q5mRk5rRolSX?=
 =?us-ascii?Q?GVG4nQhZ6tPWKQGQFCVSG3tcCW5Prvn/2ISKejFibfaqx4NQ1nY8w0QZusoh?=
 =?us-ascii?Q?ZgF58IMcftlGB/oqyYdrHp/w63QK8ywKw5Ejvs4DcIHCgkQQtUBAL0HTA3bk?=
 =?us-ascii?Q?Bdm37jYzYEnOx0FJe5nleLNj/P0HxN9IxFZay7sNN/4mF7Sgs/o1ImfxfdKd?=
 =?us-ascii?Q?fwmU2uZVMu4a4svUz9ulC8Ab/kVPQ9fWisDFx6rVdnr9YL7Djb4HbAzN3N8V?=
 =?us-ascii?Q?Hkx+h9WeeBzLp9wsQOaKSH8OHcE2nVNhjCs4pkIhLSdqdMi/B4luR1MiYZ29?=
 =?us-ascii?Q?wRgPe09hgs542YRyaRiqKlkYKsSTpOmCxjtxsYAvFJwxeMUZhiiBPIyc1989?=
 =?us-ascii?Q?RIDBXhNidi0orRoqYIFtOr+cB2j7eRB+fk3idYB/9uzfxGNb111QA/1xn3s7?=
 =?us-ascii?Q?BvYHppDuKqEs7DExD/ghYYQpyC/FENfTj29eoT0D7dGqNGpJzd1y+BrGnn4S?=
 =?us-ascii?Q?OCzMUv+Gzbcla6jhbHxqAzJ8vN2GhwQ1yw0pZYMLAuTPLmr+iM+rQ6aNxLqA?=
 =?us-ascii?Q?15Mo7quhdpYrVgChljqsypBn5HmxULMNrH3swGP5gFyDfzuJqemQpWn3ly72?=
 =?us-ascii?Q?pTNXnUq3d/yFuAZdhV8ydtQ4wHwN9XgZNQygSvWBIUwYx7ouGIYaZ77zw6KA?=
 =?us-ascii?Q?d+uVvX5MMtSZld5QktKSQIPfd9VHqDGkzVAfHu31TF2DfVYv7VFVBZqdxF55?=
 =?us-ascii?Q?FYRm2NY9Fo38GIPaR398Dj1xrS0BOUXEfLbYzMxL9Kr0jNvJdimXSx5op32B?=
 =?us-ascii?Q?b2waiw6B4Y6QdHMORZUxaFV/+TV5Hfys97ghJicybA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/6AAgw1gvp25ld70nns2YS7wCEqlGGSrWJKWLZcy6bz+pFTymsiPu3AeqR2C?=
 =?us-ascii?Q?d6NiucEIwK3/7FGNoKMWFWl3VQ9Ddy2fOW2RQfdeu3zXGBiC6BRFn6obAYu6?=
 =?us-ascii?Q?JFYWj0kNmI/ufnIkbUQvp7fU6ay56JbUIzEDFjXtryg4fGRGodtfsYSHIiwj?=
 =?us-ascii?Q?PxeO5cejZTTCte3F7SDVywhvJoKq5UAg1PMbFJ/RW6h7O/IbU3cxlVMg14/m?=
 =?us-ascii?Q?YLLq6CsSsXaBeFYsbD6k0A/DJKLZyWK0zO9cmfogIswvnVSkOKMLyZyU0MMZ?=
 =?us-ascii?Q?X5vE0sNR3QlwZAQLi1NpIUGhHI2Ssxoq+zmsCrPVOmZm3xCH0A4jMo9lV0Ac?=
 =?us-ascii?Q?0a8NY6FL/yJaInmH+BTOE925/tRYAQsiO8oyIGTy0PDZIioNINIrNQ7YVZHX?=
 =?us-ascii?Q?bJ1M9rnqqjUph1mfTbhhsaa1jCkwAS4eKyNZOhwjoM4S/WbTIj9BfbCmVGuk?=
 =?us-ascii?Q?NZQcppr6oVkyKNjgLdDmyYFU++fbfKbyyUgijhfGAGmyc2pGg2BM6v3lVDzx?=
 =?us-ascii?Q?FXx2JqKlzxNXMjD/Qt+m+SGS6nw2rfN0a1SFPs8zjK97qW92tz4Xcvcd0y/q?=
 =?us-ascii?Q?D1TsdJ+7jypXul+1O1izWb0IbHDlsUUepMsOLFf99CILv2+StzN1YBj5BssI?=
 =?us-ascii?Q?h8v8H+gB75H6MbxJLSwBztSs9y90fDMQo2r9qjiXt3P/zQxfVyNeZebhj46u?=
 =?us-ascii?Q?SNESFIguIpy5kYgeE6YHezR5hAyuRtOj1DUFF1nkDVwbnx7IexFVhZ14d+mq?=
 =?us-ascii?Q?3gsSulJHELRYMqkgI1irAD21ViGRAdHGUGx9j8zywkz7MXOTbDkccuk+dSCB?=
 =?us-ascii?Q?QSTNNl0sh306EWWgNWocHjPzZv/8ypU1y1fZC9GdnpOzNxWqn7Z6/HTZd4l7?=
 =?us-ascii?Q?8JpbrwtfvwutQTEMZgZLjVTvqt/RgnXcgWqKSmDP/659lRy03KmoEATmQrYH?=
 =?us-ascii?Q?RTQ7tu2QDBSt2mfSiy31K25zcaquyazQtvYNXUwjtQD/Z6EJ5gnsyRycyV+P?=
 =?us-ascii?Q?XLfFuhg1/jZoxQU6G7lZC+1t6LyOPpLMDz9hOGuzwpZjLbbszJBwJ3HIAqX6?=
 =?us-ascii?Q?sWAYtqU4uITjy+jJ+YcImgDNN5YSrM6jCrfdQxtbTQzH4XCUcqdLp9KmtPo1?=
 =?us-ascii?Q?twFQxGImdN1LryJYPaVgYUxLzbU8EL9YiFlPclZ5srfDMLpUufctHhV3rzpq?=
 =?us-ascii?Q?FuV4aKdkQsNkkSftC8C3Hra19H0rwhsia1b3l/wXeB6MLAD4v3GrAGJbHXiv?=
 =?us-ascii?Q?zNpKQY3eDMkteZcXN5r1z0/kc2Hhv24irfPQyZOYAXpSdMSD0Bf4FzMwDw7g?=
 =?us-ascii?Q?LQPsExD2dxedjSNGn/N6t3Xf7/JN4kbQ6hNw1Xk1BPfCrC4GS9w5IQ6R/Giv?=
 =?us-ascii?Q?KWdZqtNWh68BnjsxLFFED9pt7Uz3Syh6dCXxR4wQn9X7OlmYMaYtNRsZLomg?=
 =?us-ascii?Q?BJl7Gs5Fi19IKPfdxaQrzMabKIrikQka2haodO7uMJsLb5IJ++AFaMbyWWJt?=
 =?us-ascii?Q?Sj4NnL73dlLu2RZOZb4V8akiCV2ENh9Pcc6uOU06pcImcGmahf6o30qHjYs3?=
 =?us-ascii?Q?XI0tosjmJ+dNSiMqr6WvWB3r4tASZsZM+mzWY+sTDVbWhCtE23XADSCfKVgd?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d57febd-b4c7-439c-ae5d-08dcd96ce624
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 12:08:12.1524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Miw4X4bd+qSqDX/vssOsTu32w49/VtsvJuWWixJQP9YXIlWlM3BOdftNbCXAe+TZzrcrSi8QsHgfFq2MZi8gj3D2LBJMPNY3ZI9GDCcRNaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7380
X-OriginatorOrg: intel.com

On Thu, Sep 19, 2024 at 04:41:02PM +0800, Wei Fang wrote:
> The xdp_drops statistic indicates the number of XDP frames dropped in
> the Rx direction. However, enetc_xdp_drop() is also used in XDP_TX and
> XDP_REDIRECT actions. If frame loss occurs in these two actions, the
> frames loss count should not be included in xdp_drops, because there
> are already xdp_tx_drops and xdp_redirect_failures to count the frame
> loss of these two actions, so it's better to remove xdp_drops statistic
> from enetc_xdp_drop() and increase xdp_drops in XDP_DROP action.
> 
> Fixes: 7ed2bc80074e ("net: enetc: add support for XDP_TX")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 032d8eadd003..56e59721ec7d 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1521,7 +1521,6 @@ static void enetc_xdp_drop(struct enetc_bdr *rx_ring, int rx_ring_first,
>  				  &rx_ring->rx_swbd[rx_ring_first]);
>  		enetc_bdr_idx_inc(rx_ring, &rx_ring_first);
>  	}
> -	rx_ring->stats.xdp_drops++;
>  }
>  
>  static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
> @@ -1586,6 +1585,7 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
>  			fallthrough;
>  		case XDP_DROP:
>  			enetc_xdp_drop(rx_ring, orig_i, i);
> +			rx_ring->stats.xdp_drops++;
>  			break;
>  		case XDP_PASS:
>  			rxbd = orig_rxbd;
> -- 
> 2.34.1
> 
> 

