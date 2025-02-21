Return-Path: <bpf+bounces-52178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0637DA3F7E2
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 15:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A4E189F20A
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 14:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5613621505D;
	Fri, 21 Feb 2025 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DKrv6uQ0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9045213E6C;
	Fri, 21 Feb 2025 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149852; cv=fail; b=d2qTBxGtYPuNl8JL96K+WyYcolpJVfGwTD+A+s4DCTgqxRevszgEl7FxddK43GEfxhg3CXT1Oj08ydgQkUDPa8a22MZyswo+ppJZ0laCK8WuVVXRXGwvKcfoCdGl0gLngl0a1iM0A4BARxV85zcEXqAkulWR2+J4XztScbB7cLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149852; c=relaxed/simple;
	bh=ul3Am7jZNTzKqnrjwCUa3zgPL8YH5+8TeLcJdZDQQ0s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XKOpXa/zzykJ/oTItplvohfOTFsGW1IeI+rTYfpuMS6HZWLCuixYx7sxXRjMxPIIP+XYsqcotcGR5m5i8FwxuwaOleSnad+fVSGpM/C2NDFis/ITbv1g5v85ShHxJBExxWqmw8wU5yqxVMqISrTk6vFO1KdGcRwP9tDH+Jt286s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DKrv6uQ0; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740149851; x=1771685851;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ul3Am7jZNTzKqnrjwCUa3zgPL8YH5+8TeLcJdZDQQ0s=;
  b=DKrv6uQ04odSWJwqReaN9Pxd2VNS2vSM1wiT4+Wa3YIqLzJI9yiobwK9
   JZORgEcIkGEmb4CBgFNbS8qvI/i9JfY/YCsJDzWGLouRX5UV5NqGU2cR3
   Jz8MAk8nqAun/65XPXS2gSSKmTopQmdNPIY8vc2bHFPs+t62fkBL8XuHz
   edbMHLcwB8/a2Iew/hOh5Wf/I0CinOQfcAKEP5+Xp/jhuwpk+sbNv/hfD
   v6vhhn1q0riV/09B5Fg5FPtvsrqwwnwMgTAKgk5ciyyMfje5ugkBsOned
   QT3+hPPZkxtzxj0IVREjrPdR7hAQAbx6MbUT8zqQ4LleCsWrCARIMiy4X
   Q==;
X-CSE-ConnectionGUID: tnu/JjBnTJy+a4Whx9eYhw==
X-CSE-MsgGUID: lhsj33MXQ6meEKDVpJnZ1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="40985643"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="40985643"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 06:57:31 -0800
X-CSE-ConnectionGUID: ETLpbOvwRnC5oxYXh4hixA==
X-CSE-MsgGUID: 7LI9OAPbTaCsyEeougZXPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="115106941"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2025 06:57:31 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 21 Feb 2025 06:57:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 06:57:29 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 06:57:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxtWkD7yTPqrBL7a6b8wQJmSTV/DxHAaPDFWxkqG9H8DydIv+0YjKJkEbCXw6EGGvT1AU0eA68bLo1SssFMbVZBKTx4GGsszrAmrPJpIoAArXq0CZnJe08+Y9k3lkcleM9OzgFu6DlshsnZdy/f4qknEt9diFFw3NMiDzKp2/+iWDO39jQcgQDvklVQEQM2eo5H+keEtBZXfn1apf0DesMYgqh5ecCdaPG5W0reSP4QHynWhWITQaRhE8Ak1+mo07PEuknffjdARvBIxG42Ktg5ai3xFyB2xOG6CbNusKibezadNrmB06tb1rEVCsD5th3jiQOFwu8e5EeSnMfW6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iP9gdEM3Jy85c2x0p5ok4pKsLB9GyfFYtrvt7Sgyg+Q=;
 b=GnbT5sABt+e2zGjA4/c4Z3ybFNn8viHoeZ8ZbFhNVbWQ9trnAEyGnf7FQ05u9gNohNNEUvK41k/XPp9aieoRqO/5h6hlCsaT+v83vyy2NYuIKdHhsDokxyW17fdhEpT7G4VFEBZZqH8eFeDkDjqlaQJrsVwnn9HnVg0NowZKGicfhPMOGDy02LuQDd5LkDoczvRNvMRJ9KxmWJTzXL2+hu3C+hWvRertqCO5z/7s2iGAaWRquMEsjWMtGcdVzz0irBZSHGo6dUmSLYuweCMtVx/ZpCWCqK8sfOXrMOI2XDDfoL0oOBKVNB2RbK1wuC5k8zEjuT36wxFE+OVTxxkzqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 BL3PR11MB6412.namprd11.prod.outlook.com (2603:10b6:208:3bb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.16; Fri, 21 Feb 2025 14:56:54 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 14:56:54 +0000
Date: Fri, 21 Feb 2025 15:56:48 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Amery Hung <ameryhung@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next 2/3] bpf: add kfunc for skb refcounting
Message-ID: <Z7iUMK1XePvptYc5@boxer>
References: <20250220134503.835224-1-maciej.fijalkowski@intel.com>
 <20250220134503.835224-3-maciej.fijalkowski@intel.com>
 <0e66379b-3b37-4bbd-9e9d-1f934cb1fdc8@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0e66379b-3b37-4bbd-9e9d-1f934cb1fdc8@gmail.com>
X-ClientProxiedBy: ZR0P278CA0062.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|BL3PR11MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dea0b58-d0c7-47c1-6677-08dd5287faeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jZBS0tg+x4E2hEvvIyi7SJp+5Zbh5KNxnG04IISVpAw9nYeM2WeBjHpvcQY4?=
 =?us-ascii?Q?LnyWG5LdXSDN7AvMvrVChTd3dhnh3Qc1rGVABPtG4uJCuXlWnaNNZOD2D4MH?=
 =?us-ascii?Q?hJtYy2yPqT2yFsIyQp0fm2BTDcMdnehsI20hV/13CZhV/oPQfd500GX5HlQI?=
 =?us-ascii?Q?rWRFxnyu6H26xJ858j8lrNCj290FXnrMlquc+EDKrtq6gd0CgaDv3Nchdq1Y?=
 =?us-ascii?Q?BrJw8VKP38iHibGO7ES6bbH08sGSInbztuMmw6lELeTVVXfLlr2Homin6Dzm?=
 =?us-ascii?Q?lr+H5XN+V2eyOPVftp+d3aZqO33559ymDqqSUSLRv9XnDW4Liu3kDpqC0507?=
 =?us-ascii?Q?mEAtaftDI8K4rJ03HobK9Lq4vY3dt5QrjCnCXgYjVlnV9jis739q3kza0jow?=
 =?us-ascii?Q?HgUJpsYaC2ScBH9oia3yJ9YpqV2x7cjrJzoQ3itBHyq1D4p4MZXXH1Dno/Rc?=
 =?us-ascii?Q?MTKVc9H5ViSJUCAFD0fC2Q7AFD2WMvZUO75xlJd22IvNnmz3dp21HJu220Fj?=
 =?us-ascii?Q?V63Z0CECd9muW4fkcR55eYeQJQ9DouRkM90QvSKxZD7qInkPmOZeryYIjzbS?=
 =?us-ascii?Q?U/hraW1kfa3YLdRYG1LhnLhBu+zckmKDeO9MRKRUMdLA1hNrfy18WdgoMDKx?=
 =?us-ascii?Q?Y6U+e7fDAWdwugE9A5cuFInCA88A2m0WXQdLI4fcjQ4oD/UgFKF0jhZPKW9p?=
 =?us-ascii?Q?IzjEhUqK3E/rLPG/kzQH3uJmPjJLYdyHW7pYKLawcUugPng9zWztXGQ2Vn9e?=
 =?us-ascii?Q?7DzTVBtnRuBrXInrOBn/J+R/Wt0SMxxX61tZmkQDm+l/lUpIcYy805NyiHiS?=
 =?us-ascii?Q?EDb2NwVjcB65nunYuMAtp/XIlQXIdvXCdScFcycp6i5C1vx0oncfrsAl009Y?=
 =?us-ascii?Q?bpw3Zrwe2W6pCUXuTsuC/jEi5DvBRCCRCJBzusm/ukaflbn95JaOTVYXYWGa?=
 =?us-ascii?Q?A5sJOPGVUcD+pFQtkMTkY68O7rJXGyqcChDb2TYNhlfXXj+1GAbC7VGHkvzO?=
 =?us-ascii?Q?pIjJuXn6hUvtjVWrWfJ9YPFhYNkreYHW/KE4q9VUCoyLXTG0zxDtEG7UShjM?=
 =?us-ascii?Q?AqeRBXuZf4gvOoFNWSz+yQ4NqNwHsmxVxakHICeziLGK2gGvbMwPjypkW9JG?=
 =?us-ascii?Q?oikC51zNHQXtAUVgKiAOCyMPWvOBWNN8Ysls6nZCHXR9HWSDLloV+DrRXJM1?=
 =?us-ascii?Q?GrLUapVOOBq7OaOQ/bEJljwYcirm2nOu/KEi5qz1u4eRO14La8kvtJef9ppo?=
 =?us-ascii?Q?2noAMG68gfU8F/0zKng3OsjleA+Q7X4bfs6s7Tp1Ru0ssICdbImdo0MflTDv?=
 =?us-ascii?Q?NfFeK+DtFuWyY8BryQ1CLqGmJ0DWbMOUHulA7JCP0WbUdQL19HXn2jI3uwuQ?=
 =?us-ascii?Q?i7LlP39GWjZAhExgEwaJ+EqKhbLh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AS4hEt61M2siK8vxZU0KQfRzD4+8d7SL+pH8w8zNcZIVxDTioNaXBrNMmuew?=
 =?us-ascii?Q?GHqnnyUTtzZPa49JYaF9utaBSQ+qoaHDmdtB1NS7Ym1oKgO67S3BfJE6WQLj?=
 =?us-ascii?Q?qFRGnQ+yhpH0fl6YGzWJetIg33UIU72sCiRAC6Bydg5NL0pYPgRRv4I8gyiv?=
 =?us-ascii?Q?7j1HUyZGI0uUw0YdEwQ94BqMAoRBaaFdd/Hj/94hq/9g8pQYdmzG4DjEi12j?=
 =?us-ascii?Q?XGE/9RPdww1pOvCXQA46TgejSqL/9vM6AnsNWLJfjSCy9Py+3IDHW+jX0b7J?=
 =?us-ascii?Q?FdoeIhTfDHaSokmce90IFfYP1rezQwXgEYCEn8SU3neqAvMGTPa8Q2usyy16?=
 =?us-ascii?Q?AAYV5j/k3n1j/EV48/dZXHzVc0b+iIajNpI/YIfx4IUvjseHyBpQZJuNyGXW?=
 =?us-ascii?Q?KL5c2IqkNeIpfXrYgtsnq2kVZmMPPqQf8qebCc0/qdbrj63I9RtuonGxBFsV?=
 =?us-ascii?Q?5D/0cpxJZI38xkh6pQTHN1CBIq8u1cfXkPrrWVAuGUDM5InK/uJhIB3OnDgu?=
 =?us-ascii?Q?ieQw65AL/7LeiZf+du2pneWyLwKWGsiNjZh/1mAxi/blzEJmFd9dLEpbm5nM?=
 =?us-ascii?Q?QnB9fJJL47cq3SlLNlkM5k3D/kad+361M53xqAnA5nU0oEzqmy+eAtoZvH0q?=
 =?us-ascii?Q?gl/az5egM2eih/jxGoDcxYTmLKFGaHovxR5fR8fRHYpwiPGN1MBPT0qv/Dy5?=
 =?us-ascii?Q?i0Dm408/JHQBJvmfTIE+GpZyO2XD3NMmxnRTq9J/QprxF01T3VwznecClnV/?=
 =?us-ascii?Q?7LgJLl71kmKSf4l8HZdnqB5H2qZ5XejoYKH93qwpABfnx+kOLWgb9cBOa4eU?=
 =?us-ascii?Q?njP2Dc0yzllNizaOP3VlqTh6nyDRkp3dkmnZi+vDTNp/kwBQrdX6daMADXjS?=
 =?us-ascii?Q?wuinnhfZ47P2hw4Oh5SpW2zt5bbR5GiQRxuFBmxWy8uhsze1VcUAF4DrkVUg?=
 =?us-ascii?Q?5kj1UURODuHREDehtNW4me3nmkEH+9jmBE75Xl45Hbb290vGS9F1YVwxG8mB?=
 =?us-ascii?Q?tLwkgUImqM4ljMn8p7SFXUFi96WcjB0WSRoVHO+VKjl+Ab4ASdvMwdXpyHeK?=
 =?us-ascii?Q?URCA97SkeiTTL3qDCqrvyx6ZZ8qJR3HbG2lWCRJwoM6FJlI5a20eTCTUONLQ?=
 =?us-ascii?Q?l3ZfPI0ZTfYpprQ77jKsQcux3DyT1TLpuPcnqTnnGj8/nwLiRvMHuPRWeyZl?=
 =?us-ascii?Q?wy4UbY0hQO60lrqp0HDuA9YMijJwxjflr5tWka4avDQbkhTEEKZqDBw3v1re?=
 =?us-ascii?Q?mJSaV9qnocrBNQ9dxvinzaf3fhvFgb2Xy9DMwUd5GAZgEPxnIxiJJ1SIYZWa?=
 =?us-ascii?Q?043UhDBewElNuysyimuAGL8qCq4brzI4uE54Xjowzn/+FLGqyIv9i+eaKYFK?=
 =?us-ascii?Q?ZZnzb+RoFWvzhXLgwQlfOqzp10ZDXqBEvHYZjqe/pb9/lq0bymgTbWaaPekV?=
 =?us-ascii?Q?3Or9elvSOhrFisKJm7uhxCnCeZJNtHrCcUuXxeDKlaFUQKcw5JYyR8p9RQoO?=
 =?us-ascii?Q?8c16l0lMOBLCM9MgPnR/KFOtWadqmuxAncrO+xqkEcjDMg0SK280PXsGUS71?=
 =?us-ascii?Q?HpFB9uqGV2Mfh+fu8ZtUjrrHKJDMWOvwC77w/A/e8D83NYkbC2G+ZM3JHU0t?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dea0b58-d0c7-47c1-6677-08dd5287faeb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 14:56:54.1379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mbp2x2gFiTgkPlrorwwdL2vW3dzKFz9LuOZw+FdK1ubqwLMtxm8Sq2fhKTFA3xP68iQNcd8oS2t0twpLgLhc6UUarip41nB3QVZDGsSXDWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6412
X-OriginatorOrg: intel.com

On Thu, Feb 20, 2025 at 03:25:03PM -0800, Amery Hung wrote:
> 
> 
> On 2/20/2025 5:45 AM, Maciej Fijalkowski wrote:
> > These have been mostly taken from Amery Hung's work related to bpf qdisc
> > implementation. bpf_skb_{acquire,release}() are for increment/decrement
> > sk_buff::users whereas bpf_skb_destroy() is called for map entries that
> > have not been released and map is being wiped out from system.
> > 
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >   net/core/filter.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 62 insertions(+)
> > 
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 2ec162dd83c4..9bd2701be088 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -12064,6 +12064,56 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
> >   __bpf_kfunc_end_defs();
> > +__diag_push();
> > +__diag_ignore_all("-Wmissing-prototypes",
> > +		  "Global functions as their definitions will be in vmlinux BTF");
> > +
> > +/* bpf_skb_acquire - Acquire a reference to an skb. An skb acquired by this
> > + * kfunc which is not stored in a map as a kptr, must be released by calling
> > + * bpf_skb_release().
> > + * @skb: The skb on which a reference is being acquired.
> > + */
> > +__bpf_kfunc struct sk_buff *bpf_skb_acquire(struct sk_buff *skb)
> > +{
> > +	if (refcount_inc_not_zero(&skb->users))
> > +		return skb;
> > +	return NULL;
> > +}
> > +
> > +/* bpf_skb_release - Release the reference acquired on an skb.
> > + * @skb: The skb on which a reference is being released.
> > + */
> > +__bpf_kfunc void bpf_skb_release(struct sk_buff *skb)
> > +{
> > +	skb_unref(skb);
> > +}
> > +
> > +/* bpf_skb_destroy - Release an skb reference acquired and exchanged into
> > + * an allocated object or a map.
> > + * @skb: The skb on which a reference is being released.
> > + */
> > +__bpf_kfunc void bpf_skb_destroy(struct sk_buff *skb)
> > +{
> > +	(void)skb_unref(skb);
> > +	consume_skb(skb);
> > +}
> > +
> > +__diag_pop();
> > +
> > +BTF_KFUNCS_START(skb_kfunc_btf_ids)
> > +BTF_ID_FLAGS(func, bpf_skb_acquire, KF_ACQUIRE | KF_RET_NULL)
> > +BTF_ID_FLAGS(func, bpf_skb_release, KF_RELEASE)
> > +BTF_KFUNCS_END(skb_kfunc_btf_ids)
> > +
> > +static const struct btf_kfunc_id_set skb_kfunc_set = {
> > +	.owner = THIS_MODULE,
> > +	.set   = &skb_kfunc_btf_ids,
> > +};
> > +
> > +BTF_ID_LIST(skb_kfunc_dtor_ids)
> > +BTF_ID(struct, sk_buff)
> > +BTF_ID_FLAGS(func, bpf_skb_destroy, KF_RELEASE)
> > +
> >   int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
> >   			       struct bpf_dynptr *ptr__uninit)
> >   {
> > @@ -12117,6 +12167,13 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
> >   static int __init bpf_kfunc_init(void)
> >   {
> > +	const struct btf_id_dtor_kfunc skb_kfunc_dtors[] = {
> > +		{
> > +			.btf_id       = skb_kfunc_dtor_ids[0],
> > +			.kfunc_btf_id = skb_kfunc_dtor_ids[1]
> > +		},
> > +	};
> > +
> >   	int ret;
> >   	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_skb);
> > @@ -12133,6 +12190,11 @@ static int __init bpf_kfunc_init(void)
> >   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
> >   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
> >   					       &bpf_kfunc_set_sock_addr);
> > +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &skb_kfunc_set);
> > +
> > +	ret = ret ?: register_btf_id_dtor_kfuncs(skb_kfunc_dtors,
> > +						 ARRAY_SIZE(skb_kfunc_dtors),
> > +						 THIS_MODULE);
> 
> I think we will need to deal with two versions of skb dtors here. Both qdisc
> and cls will register dtor associated for skb. The qdisc one just call
> kfree_skb(). While only one can exist for a specific btf id in the kernel if
> I understand correctly. Is it possible to have one that work
> for both use cases?

Looking at the current code it seems bpf_find_btf_id() (which
btf_parse_kptr() calls) will go through modules and return the first match
against sk_buff btf but that's currently a wild guess from my side. So
your concern stands as we have no mechanism that would distinguish the
dtors for same btf id.

I would have to take a deeper look at btf_parse_kptr() and find some way
to associate dtor with its module during registering and then use it
within btf_find_dtor_kfunc(). Would this be sufficient?

> 
> >   	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
> >   }
> >   late_initcall(bpf_kfunc_init);
> 

