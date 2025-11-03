Return-Path: <bpf+bounces-73341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EB7C2B975
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 13:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6454D4E8E94
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 12:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3E130ACF3;
	Mon,  3 Nov 2025 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rq5Ch6lQ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FF978F2F;
	Mon,  3 Nov 2025 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172183; cv=fail; b=lZdhwTT8Heb20gWTwFdKf08/kRxiheWC9O4Bjs6uNHoyHHGq8p6PEPSDHPIJJI7GjqLqXH/qZwVvCqvhcMnQRc2JTIxGQnEVx84LVUl2JXESPGrV97ZY3dXExv7w1JyOY1txXYo9J3LI/wQmiJctv1njzVCbiW03ZjwkNo+YCP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172183; c=relaxed/simple;
	bh=0r/TOXUWyKw63IjJ47P7ze1c64pFQxd9uaE30FH1Z58=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rkHauEsF3E9Yy3KZ0i2ZJtxrx/547xR+Bv1PJYsu857Sv2PXPlc6WYiMG2QzYDYFr2yyitIJE0We2Vky1gAsQSGC7T/mZ8W3+Ch3PSouRzR4cZ15hB7eQjuLZlVZHOehhwldBiv7iKejpFxWNxdTVwZTLHpdBdI2Yv90CMhkZtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rq5Ch6lQ; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762172182; x=1793708182;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0r/TOXUWyKw63IjJ47P7ze1c64pFQxd9uaE30FH1Z58=;
  b=Rq5Ch6lQOVGVnzbc+I4ld7g+zHy1AKg0L3BvSwV+Xr8baasAomoGzqfX
   ftuK5qwT4VDNKha4EdqxUChrXUjyUrwfBQ8oZpK/lLSoTpOOtHteg6MHZ
   P1N9GSzuGbmwWytV6R3bnaNS+NWp60Ff2HO8tqOCO/K5rFrGqWWFJ/yWg
   bNlkNLbdTlpt544DHoqcg31gBRelDRxsSl6YRbxGw4zr46ASqiAQzX2OQ
   nprMZRu7BSHhIBxV7npwpxxerqTMZh8BRcCh70PbkZ6g5ZwI9m3jDDhkz
   zhz+Wg5IdCfRwu63YwM3royA89oBP5KdneI4YwFyAR3nlIgC5/1Edpbrx
   g==;
X-CSE-ConnectionGUID: C9ilgez0R9WdDpDECqEoEA==
X-CSE-MsgGUID: RIFOYMz+RHC6cUiUXGyvlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="89707271"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="89707271"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 04:16:21 -0800
X-CSE-ConnectionGUID: 9bxOnmgyRqOKdP2OARzUmA==
X-CSE-MsgGUID: /A+2Wf0vSc2EHQEQUbpufw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="217678340"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 04:16:21 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 04:16:21 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 04:16:21 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.40) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 04:16:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhI3SFvsvvKRLoldWZhC47PBwg0dhogWnGnalZUgdrsmuv2+j745nJ1E++7RnX0797lnu5eWhZFbpbfKdvbuQvs4kKtYglag3Xj2rWm0zzidTjR3V0NUW++vIWJNeEv6zfsC6mEHtC6nX+Kg2jzBj+dtqMQLPLCDsmP0UBNkQRcS/MB6cb3CvVKtRHL0sm8yUjqHBX0awpHX6PJEMnVw2NVn4yj+cPJmWASKuobsalveN0r1bN6Oy7x8QxRx5AjMgVGTmANoeKXhw9WTmvkKjPDO4Sa++KX19CpFomruiRfFIXv6FhTiU0VAuM58054r05sZrES5D94hA678so5QPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0LKKijwLepWf+3vYmb2MdlCG1xp88hHiJto0x0lE4o=;
 b=QyxKUOH7vcCPvR9uGSKjwXOn+693WE2hCimvL6fGqPMJ7sIE7iZe4YZPRR6D7MXX+MMj7p1QyDG8/vcimGc3Msf8UsFaTflFNC8THFYdYjAY9S8RADwBg38JWzIx45QBFAzWJEBh1Oe2WVd0/3Hm3qBWHhvyRV/4waktc+rdebkV4SjgXiXgq21UujuueDtEoQyqols9sXZWIOvslK1RzXkRT1tFpJx8Q7Y5D1nraCF6aYRrFX6BdD4qc1kXFrzZKd3ta/9CK1G/pGQRu4+wqJNkz+ehU4ZTwI1Ww2XtEC6ktYiCc7dSIrAuCjbG8LCcpVMBah9J64quUibUO8iTCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB6348.namprd11.prod.outlook.com (2603:10b6:208:3af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 12:16:18 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 12:16:18 +0000
Date: Mon, 3 Nov 2025 13:16:06 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<aleksander.lobakin@intel.com>, <ilias.apalodimas@linaro.org>,
	<toke@redhat.com>, <lorenzo@kernel.org>,
	<syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>, Ihor Solodrai
	<ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Subject: Re: [PATCH v5 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
Message-ID: <aQidBn22H1UVxST5@boxer>
References: <20251029221315.2694841-1-maciej.fijalkowski@intel.com>
 <20251029221315.2694841-2-maciej.fijalkowski@intel.com>
 <20251029165020.26b5dd90@kernel.org>
 <aQNWlB5UL+rK8ZE5@boxer>
 <20251030082519.5db297f3@kernel.org>
 <aQPJCvBgR3d7lY+g@boxer>
 <20251030190511.62575480@kernel.org>
 <aQSfgQ9+Jc8dkdhg@boxer>
 <20251031114952.37d1cb1f@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251031114952.37d1cb1f@kernel.org>
X-ClientProxiedBy: BE1P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::8) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f6b9f6f-9294-4721-e042-08de1ad2cad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Lw3Wl0fWBEp9nYyYmoq78eVj3NXW2A1nMo7mpmAVz3XLOI5ik9qFcPmNrLgm?=
 =?us-ascii?Q?cRx42VD105mz/5tUzjzMIQeqdX5rHj32nyCfVj0X/98C4/tymG9d4YqJ7lrM?=
 =?us-ascii?Q?ferqMVTpi5hfDf3u7UMxU16z6AfcEHPWp0fohxasuSjrWrJlrl+u2XD7CGbX?=
 =?us-ascii?Q?yT3cf8E4/ZWkjqncNOlQmxcH9xbX26MMwn2Rs0pSU8LayjfQ8WEVE8BK4CRD?=
 =?us-ascii?Q?bVERdbFNY9Mzsb2cPMNiYm3RkAcXZgLK6D1+2fJrgEMIwI1PZ4j5dR4GcV6p?=
 =?us-ascii?Q?lDZMW2OOCRBSl9Tfa3vHojom2jNu5/aJyCn3/kkZwqukbFZTteWQEbSWDI1n?=
 =?us-ascii?Q?cImKm8IrkgEXFYak2sFohNkPmgJD10w9F7PoBGoqIK1kUzJaW4x/oJexbWzB?=
 =?us-ascii?Q?3JfxTWgKrONpoKwj0rm+uybUwA50HDcq1MPcqlnNnhBZ+viT5EdyBKAnD+CS?=
 =?us-ascii?Q?8voOoUzYIS2lzXvNmxbOstBNAdA8SgKYY84Vn8zFWMmz0+GwaxTVXzyVLQYH?=
 =?us-ascii?Q?MiJ40rwKlHA1LgH2hUQmYBjup+tBKdNmEq7/V2dE+uKRd+3oWmBydkwxDleF?=
 =?us-ascii?Q?LYLu3fjFupAGKq258E9CSBmX6hqFEmvZK+DbvrLvV+y26fOD3hjltAKTmDRy?=
 =?us-ascii?Q?5iG6xOd0nTqFbF0hXJOlwgLzZsuqPNC9aTIsSElLIGZlLxgtPxbp/whTIG73?=
 =?us-ascii?Q?cpuhoVlCEI2Bn7Q9W4EGDpmEaUzI/oRUQUaKknqqokAPncX+EYwbJ8n5Q6Nh?=
 =?us-ascii?Q?0wXUvZTZhMvTWiTl7zN6k/1ZH7P+ghzEDisG9+Al0dZd5q31KAISW9coTq3k?=
 =?us-ascii?Q?nvX+RjKGgp4NlRMyJsFtONP62JxbMtIvY2mHhQ9JEMZfqx+dufcPKnOgr29w?=
 =?us-ascii?Q?fOB1pIgE21PEus6lLv5T0wdJnu7gXT4tazym1y+NxaJ8S+yl6kRTaUSI2scQ?=
 =?us-ascii?Q?wgUXFGycAbg6Wc27V7t0kOgkDuwg+lE/U/TV36kEMyM6CrggLHY7Wfql87Xo?=
 =?us-ascii?Q?tUdyu5qNhuIqI3uhvZM7NDmyD36HKpXkRuxhGKpyevNb8SA3gvL9xfRsLmZX?=
 =?us-ascii?Q?q4VO4SznSkJLKE787Zh99HrFx2vqpQXwH7n5yd+11SaNPu9Qdc2ut/IKJpZD?=
 =?us-ascii?Q?az4EadCQAv5snQClw4BkYb1L0m6yXPjH85LikRzgf9Pv+att28GY2qI7ZJBO?=
 =?us-ascii?Q?0w4ivSTwRKKF8tLqx7RW50uakeubRhs4eqGkmbUBnLuBDDXVKhmWafZlyqPU?=
 =?us-ascii?Q?5wtMHGv3gopUKEJsjCdNa8ISEGdp5oXR06PjQ0dtuD0AwA9HuPRcpLyZBUYP?=
 =?us-ascii?Q?QpduAi8A/2V8Cm2nPFqoSH/Oi/J+Yis2ob2r9itcgFwPpQuSPYfzLYqz3h4k?=
 =?us-ascii?Q?EhgLkd4dG3FsFyFn3+oBXHwF3F8xONbLiOrHCr4aE/h7jtES6v01ksZ5o3SH?=
 =?us-ascii?Q?c+MmGlx+Ci6J77wRCE76Np5aOwCqPUNO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aR/5ZGDXPgfdEms72QuTac35BAF4IX6L/AotASRW7+3RmWYyP+VPG/yWUcOm?=
 =?us-ascii?Q?fl7p4zlvoMpDms5zM50aal/7YODXjJbA6L8wVSAks/mFLOTDc0ExxOv1yTd+?=
 =?us-ascii?Q?RYgjeITEefWkeQFCmS0PAhbLp9Y1an5Avm/FF1iFY7FnaiWqaTXdw7jsOP7V?=
 =?us-ascii?Q?S7KtYAb528DxWMsVW01fc7l8O+FxcLM5/CnPPpBNUmnEKR4jeCFYRUskHlSi?=
 =?us-ascii?Q?b+MWe+irNN4wyD2jW+ak3FfxJKKLLRuX4mvXTo30NrHQ6gBhSQxsSQY6oN/t?=
 =?us-ascii?Q?2bNrgAsucUNRpJP3wyhEcQpu5mWRcDpFfgfgiecyNbTk5t7wOTon8BCrBijl?=
 =?us-ascii?Q?4rSmMVjGOtfhs93B1jMTrBYwzAspiOKdH0Cyna1G8RUy4cDHlCraExYw0eif?=
 =?us-ascii?Q?aqU62NU3AeJ2JXFAuFsgomupttCgko2bII0uPjMAaJaXjwlgvwejaVAK4Bjv?=
 =?us-ascii?Q?1vtNmsEZuCkZL2Ex4ZocKUeAudaHyzTmteJhf0ztaRk6Luuzm/2Cvb/IWRlE?=
 =?us-ascii?Q?O3DwLvBvJw4S8zTb1x3f8r5fKg3fzlqwcKaCtEOVpctHPNNj5Q9KqCu6TPEr?=
 =?us-ascii?Q?T+VajgYXwRNNmAj9A+LggdD8XpGqjL11KyOutRRV6Ua0vcU45mWyG30LOV/m?=
 =?us-ascii?Q?eRMGn2cn/z4Xg2jSa4v+eAnT2FNLzl5QMObWJoPQp7zGN+nphlYChHdXMvxZ?=
 =?us-ascii?Q?r6xGRNJ3zMIlm0SWyariywIdqRMTzuLQmvyvz8ImcIdYS3th9SwH9EvfCUPa?=
 =?us-ascii?Q?qQhBfiQ4FrAjALd3PthNvQ7R0uMyc9kySZAnXYMUZD8jrZunzWOonVSHHtYy?=
 =?us-ascii?Q?I0mHcaedlOD/qXDdbMPobnUREAoXWaRXnxtntuHLIokhKoJOg9qulcRRzped?=
 =?us-ascii?Q?c/R+kogXxLTqFb5MlRsOwYhS01CijnJG9vfx6znO7k8SlgsXUIbsBhMnXbcG?=
 =?us-ascii?Q?i1kvdIkBByLjqtFzPlhjSjhBBSuMK5zK5mQGP0gZJFaEAtXcUtMNTlyqTUEL?=
 =?us-ascii?Q?TWH+CWCkqgIvsQjyebX61z4IgldCwGgZMSCgzlElAf1qtDLMiWqGpLowvwUA?=
 =?us-ascii?Q?ep/kdoG3s3aGTPl4Ytp7ywTKtJqtb0BvXFI2T5NQJzpkO9cLlpqtdR0nRple?=
 =?us-ascii?Q?ZSVnmI+i7Nx424tKEQYuKlZD4YuhALHeXIbiEGFvcxzKVpOF1HZFlGUgcthw?=
 =?us-ascii?Q?8zwCu7Jr2KcRctspXZ3EXRIRgBRh0wKWoulcb0GXdExWf7C4QebFcmAAwAc8?=
 =?us-ascii?Q?Qcfgvkog5wOZM9AWUaoj70/m08YvxaC9KCMOg7NF4NDSCD7QEs1roJjxhTxS?=
 =?us-ascii?Q?7kLQii4HVYNUYXKlJ5cwIzNEb8Iu1uTCdmn3IdBV46ztDwD+YN9L7pk/IUFS?=
 =?us-ascii?Q?QgQCn52FqgvItw7pR4jOhDjUi1K370O7sn13l25JV1bFppuJAtVnXzMz3ySA?=
 =?us-ascii?Q?2Hxdg77b/VNi+diIHcNFVJhE1Ovd8RYVSDFtO0uK0gNBEoDxZmnWnuYuQ0Tc?=
 =?us-ascii?Q?XQ1JrazJrguIW7ci+WcYJweU0VptCmTjFSBn+B0Bb0lkHqseEbWHGIQNvBRd?=
 =?us-ascii?Q?4GzxyvL4PqBNSIvz8DNedCQIe2VZTTZLBDPQFdTMl4DEPMCv+6L6SV/JJ58/?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6b9f6f-9294-4721-e042-08de1ad2cad3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 12:16:18.3030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0LgKSyhhE/vaiL4HXyufcpWMww7i/MV2nxXwGIoWr8OuXi/139V6hf9mRJB1OcjTkfA3TElAy1ST2JzY8Jve2aHH+W8K8I6liwRNQMaA48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6348
X-OriginatorOrg: intel.com

On Fri, Oct 31, 2025 at 11:49:52AM -0700, Jakub Kicinski wrote:
> On Fri, 31 Oct 2025 12:37:37 +0100 Maciej Fijalkowski wrote:
> > > > would be fine for you? Plus AI reviewer has kicked me in the nuts on veth
> > > > patch so have to send v6 anyways.  
> > > 
> > > The veth side unfortunately needs more work than Mr Robot points out.
> > > For some reason veth tries to turn skb into an xdp_frame..  
> > 
> > That is beyond the scope of the fix that I started doing as you're
> > undermining overall XDP support in veth, IMHO.
> > 
> > I can follow up on this on some undefined future but right now I will
> > have to switch to some other work.
> > 
> > If you disagree and insist on addressing skb->xdp_frame in veth within
> > this patchset then I'm sorry but I will have to postpone my activities
> > here.
> 
> Yeah, I understand. A lot of the skb<>XDP integration is a steaming
> pile IMO, as mentioned elsewhere. I'd like to keep the core clean
> tho, so if there's some corner cases in veth after your changes
> I'll live. But I'm worried that the bugs in veth will make you
> want to preserve the conditional in xdp_convert_skb_to_buff() :(

Probably the conditional would cover these corner cases, but I am not
insisting on it. skb_pp_cow_data() is called under certain circumstances
in veth but I have never seen a case on my side where it was skipped,
mostly because of headroom size being too small.

