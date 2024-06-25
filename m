Return-Path: <bpf+bounces-33077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29138916F0C
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 19:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D521F22B0F
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 17:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1FB17837A;
	Tue, 25 Jun 2024 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KF5Ktdo9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9DB176FB6;
	Tue, 25 Jun 2024 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336156; cv=fail; b=N5FdQG+SCIcQtZmsIZD4IrOxj8bEnojeJsfY61M8nqelyZ81avgSXkl0z6zmyBywSP5H3iQieMsuG8CgMBl6GIG8BpZD6oCxMBwjlg0TnFxN5EwqVYroKZGgXE/Ws+HIwfe5+2yVN3IAtoVFvbWj5VX/7OKmqolkwZ3Cv7/8nEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336156; c=relaxed/simple;
	bh=cYdyUtDr3ZndEBjf4A5jqPMY6YYyF9dJ/3TKiqj6N0w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KXv/Y4u8F2C4BiIF5BvF4ftPw8BGkkvsvaFgKq+5bdoN2MahRq1BOWIlOLRdF7+3/QtADAWgL8HwSD/sibKd7uDi0XITnEG6k0P7ZFrAVkuU1kGHy6Hhhdgaod1Zr6Ai0b2CNlCYbA5Xtzx0OhSgJp0C/3idmEKpXVEI0rurHwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KF5Ktdo9; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719336154; x=1750872154;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cYdyUtDr3ZndEBjf4A5jqPMY6YYyF9dJ/3TKiqj6N0w=;
  b=KF5Ktdo9AthCIBxlWCxtfTgoWP5GmAzVqIbpUZ+vb314mdl4tADJNh85
   1Yntr/qLMLOptOHmq5CrGhnSYbHr1aLGd2zUQxjVNRiJyrMpv0tEak+2Z
   LK0PplqaoDtIh6m7jVKfnLsyMBuiqSGEjZAQZNIpGiHkUTe5eqPw0U/Bx
   0LwG++Qu2BIR0JzpdwJ9ecNm9m/feUBXNl/Y/4glEl/+ywEKD4tPRos0m
   DFX3PvbJkHGIJ14L+hTP4g82NJ6NcLR/5ANVHz/8LPt8YTib4BpVRXMh5
   ZYaktvG9F5wmxXdPv3MMmn/ZCGY50G3ZotRftVAwlvie3teKSx7FPgs+V
   A==;
X-CSE-ConnectionGUID: 88q23sljQkivzgfwfyXd5g==
X-CSE-MsgGUID: JyC8+IoSSKaU+qI5AhLKXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27780423"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="27780423"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 10:22:34 -0700
X-CSE-ConnectionGUID: kyhV82AfQduOLbjo1p5HQA==
X-CSE-MsgGUID: C2DgocKHS/ydo/O/CdS+qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="43584880"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 10:22:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 10:22:33 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 10:22:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 10:22:32 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 10:22:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5NJuVXmAp9GtswoXhM8opbCXxOytBUBWjaahIeLA2CVqAOYITaHIaWGvXNjGAw5u/guj86MzfLX2Yca6PlrNTT6lx/mvijEyPdjaAv08JpvmaBS7LrQLho6TZ/TNQy8W4kbPp6cGxRi29IIZ98TBF7mDIm74rFOoYDpagF7HUEoFSfE5R+Sj/Bw6R6yHr3rdMdmUjJAsLDYVDFNsY+RvfX3mgMEm5JV0Mdud8DMmqKQeBzH8ZQJgkvqKo82gLXYxV+pKJfGK2qUe3a0RSwILrkVWONiNNA6v8XehL/DpgiutyfHvwAcPBRSwDokyRzgIU8IrUzV21B7x1aVRwQcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j35ugcWkItgW1vpQKwWXSD6ZW6N14/EAwxDc8aZKLVQ=;
 b=GdsPih4m0puH5H5hQRejdDHAIzwSfMzBbnpd9YeaJaVJv+rkgbLwHervUsyaFFT38QEGoGFvdUML68jma0/qafra2+/rp8vIzDD3OSDb2YAMw+OTzxMbZkG3fNsD1vo1mg9mm0zpJrGSDWtr/eQvg+ULzdm2ajkWfad9mHJUwu2Mw40v6yULlYgkOZTgvHuoEW3qtJJn5g2V2suZPSqMvVOnMKzCTpGy3hyLiCO0hGAPxq9BRwR7nqVIbAJtrN68uO+6T30M401uMpjjaZvqKqBbgkP7+uDd79WSfHiYNNNEBQY4eJ3GLugO4Ur4VFgZxsbKJ3vWG2WwapPnzlC79Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB7445.namprd11.prod.outlook.com (2603:10b6:510:26e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 17:22:30 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 17:22:30 +0000
Date: Tue, 25 Jun 2024 19:22:23 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>
Subject: Re: [PATCH bpf-next 1/2] selftests/xsk: Ensure traffic validation
 proceeds after ring size adjustment in xskxceiver
Message-ID: <Znr8z7zbFb+KD1lq@boxer>
References: <20240619132048.152830-1-tushar.vyavahare@intel.com>
 <20240619132048.152830-2-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240619132048.152830-2-tushar.vyavahare@intel.com>
X-ClientProxiedBy: VI1P189CA0021.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::34) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f603038-e622-4e81-f765-08dc953b64a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wvimkc+kKbslIb2Cc9uHI5KG5NGK7vMdrdmheiWtYjPJluyr57sG91vbhxuV?=
 =?us-ascii?Q?KuJtyPpsZgdkOgNjBAybzZ1wzGlcLmDeJYxdYwu0eex93/2qWBA1KIUbewwp?=
 =?us-ascii?Q?lS2Z5QS8wmxU4FnAvKNouiuVU6DxXMo2mzRh1EK+xgOwp8KV/oGOwxnJa//X?=
 =?us-ascii?Q?/qwZl/BK9xM3bjPrxhYzXjP0tEBJBwrt/zJTAShl2+5W4Lx22IVfZmk9IsTG?=
 =?us-ascii?Q?Ie9j7Aj4Xrxv49XVcakTiw3W526hw+Ralbc4gEgNuO6abeCxZ0RyfuP+PCfq?=
 =?us-ascii?Q?IApDQIiDEYB2v1KWTkpkXl1mgcspSZDzqIWSUOxYZkdZb3DWRV4vrn3ffBut?=
 =?us-ascii?Q?AAWM4S1QSVvl3YDhH9v3vo4ADlyUHPzrpmsL/RN2zf84AhV/69x055kpJEch?=
 =?us-ascii?Q?MlmCty9kdpgI+1JnFsMECyBm8ZBoOiMe/ep5vZBSrKTbvXCKBBldhskcoeeZ?=
 =?us-ascii?Q?582uq2ltfqGCTRL/e+82vkwIrEx6fKGW5cvTJl5l5Joidr8UnYm/WG3SOP6b?=
 =?us-ascii?Q?tz71S+DorIYBzvmPhthazmJkAaAx0fbEAkwos/Hrg79cBMW4RVWI/wN9Sa6q?=
 =?us-ascii?Q?RdeD4A3TSZ7OV9XLxyjDnhOqm9T5c3nkJtV8fHOXuQIEZmQvxH/PH8MULhLs?=
 =?us-ascii?Q?WAZ7ir1+TTl0r5ske5fLoR1JG77uEgKCEEzbIrCY7TjbPjWJTX7u1nssmiLs?=
 =?us-ascii?Q?fntCSIHDybeeFn0uR0dqZivZwWoNzKtnqW/3BOhjySP8S6ftJIbrH2/CJQxZ?=
 =?us-ascii?Q?6etTDkivim1Lm9UgE+tx7WsaagROty3M7XWsXkEfsYWJ8AVPcLkMedund+Tn?=
 =?us-ascii?Q?6N79jJ1LcuOKpz+r3RIMVtx7aIZXF9ukAaR+b7O/4kykEGBytiNiqIEUqUJI?=
 =?us-ascii?Q?xiRGMEPaXJggMlN7uqKiqUtvsbSImt8yBDlecvxb9k0Edfru7xMne3gXOHoJ?=
 =?us-ascii?Q?suVvpNp12OJpzq8JzA/2dCjivaDn754Iz+OZlo7Acqh/hqaPiw5B4OwavZ0f?=
 =?us-ascii?Q?AYNji2Sv9sHXDFIFkKf/ccRTmfKGmdUNr2NOn5FlEAIM3/zTiuuhAgCA4V0n?=
 =?us-ascii?Q?kO/qfN6epVaVgcuusZCcl/5ulTbmoO9o9BtzpL7lAcUoshQzCuMDqnmAiwr7?=
 =?us-ascii?Q?228rhOdUAmWDKcKbY8I8KScIztxvlrjzIC6D8wOXB3MxQu5lxl2Ufejs+7ns?=
 =?us-ascii?Q?qoK0KYPM9ZxqrkC31022EnLDeelVmlz3Ok4l01ia/LvHxb53xXsJ9zdvoUfX?=
 =?us-ascii?Q?dX8D1ji7mHTftvzT/w7lOC1pSqH/srgQckDf1bfA76gahN/yS+mMFAdoDd1H?=
 =?us-ascii?Q?k1G6myMIxmE0YQbAn6bCAA+U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z0VG1Oeys41qFdnvGJ0nQF5FsrrLfeBT+qaEBtZvt3B0u+FeXDJxm+g7u078?=
 =?us-ascii?Q?wcj6JG4Z5Vb6pXQztdUJCRaYRtFP+n7LjapIKhpkx6Wz6JPWu0koGdDHJKr0?=
 =?us-ascii?Q?I9AdEuN+dN7bo5GMVOzGnpFnSMJKJP4euxU5RDaMJxSUtkm3AoUL812mCmW+?=
 =?us-ascii?Q?y4/FivpRgF6Ti4IwxVurzN6km5CwtqzWOV257UhHzkm/M5lChD7WVxs2fFPM?=
 =?us-ascii?Q?I/TwDxFwkj2NRCbMGck2walsYoR4Jh1ko59MDsXFv3UXDdlOzgNSYAU91khG?=
 =?us-ascii?Q?pIgOJMmc2MAT1gtdrT/ySwNkCH6AJF5gNYpXatnHZShNlmdNseM0cmBbmv3w?=
 =?us-ascii?Q?++kErbbaQ/wEZkHWAqxMH3cJkAgvhuvXAQ8Y9nIUu5iH/06tl+2pPQQxI8Ep?=
 =?us-ascii?Q?1EQKVXpVy8+J7QfGHTMe+j8phQNxSxVeafICHj+5g+bUF1IhCW4Fsj/KAD1D?=
 =?us-ascii?Q?un6NsyqxPbj6pZyyT4G24eS004I+62vxy53k2Q56Xn1eLSUh2qShSOP8dcOI?=
 =?us-ascii?Q?buaF1V7HLeB6VWDgXNoc36icjV8Xxsrzjzr1/Jdas4U44k28QVKo67zPec9V?=
 =?us-ascii?Q?di1vYTnXMgvRSrtByKIYXRdoG9spYmh7q/7ZOc4e2ObWcfGhgqknIhQlvvns?=
 =?us-ascii?Q?1/f8nH7ga6DYaNzM5OamwOgzg49IMOgCX/l+YsaaFUZg/ZbV/PbbrTC7hjZX?=
 =?us-ascii?Q?RxsIZihY0frTsHe4AJUwQRGfz24/fviOM+EWF3l9++p81Wm7DX+br7cYUVmw?=
 =?us-ascii?Q?Y7BR/XoN3meQrBU7HuPgs9/rQLEgMZFAYZIUAiLnqvQC/PZC1Sdb5Y/5pOMr?=
 =?us-ascii?Q?RPMLsvARYQBCZ64TRMQGhxcvD8bo7RJRk2VYkxuHBi2GZclUgs6G17PA/yuX?=
 =?us-ascii?Q?/dtSJVBF5k8hEJkyF+g6/askGJawXShroWWRBLZ91Tf9iCm7I0yiv4gBQRsh?=
 =?us-ascii?Q?PTwpEgf5PoY5dC7BLNzFZlOTGhKGFX75S5leIgiDG40VBosL0KhjvGoKHFVK?=
 =?us-ascii?Q?YQcK5U8sI9ABu47WUS++R20mDUiBHPbG4OzaoT33zaUaXXeFYoGpj5HV9zxP?=
 =?us-ascii?Q?L0pmJH/klylIVR3TKW9IPL/mfHtpELBw/JGGgH5arO5pQ1+rouhSJr8QvZvS?=
 =?us-ascii?Q?bPMEY/8q12e69oLizfgS7fXeg0JjEAv/8Mp0ld/yz+YH0wFs7VPbRFdusX30?=
 =?us-ascii?Q?Yk3r1HFIkdDdN/JQQdXwuHTZxMM7oOwvXiXAMgy5u5YDtfkp/yMHGYLPq8J0?=
 =?us-ascii?Q?loOxGOPDTMSKOITaiAjjwkQcg1hM4SIRErznybQ5c9awxz+KJXPKFCRQplc+?=
 =?us-ascii?Q?d4P630Jl94GkCTnvebJLlhykBZqcRxPryFIlMExWKd6IJRJZ2k/HwKEmExqq?=
 =?us-ascii?Q?W/QYK6ic0EAqdvI0To52r7WcP75Nv6P8iVLPeyIk0uxpvREF/g5cWHKStyWB?=
 =?us-ascii?Q?ZL0aMWsvA1mKjfBVyUcT2g7iviCpMPE/jWNpDI+buzBx81qiyDpxxjQFSF/Q?=
 =?us-ascii?Q?Ly/S98wPDcMjLo+c8UnCNP0NZQQEttrhoBHdOshIeHuu3jIPcJTBsLPN6E7I?=
 =?us-ascii?Q?h0lqvsy+DnRCOp9hJ5DA93jQ2fEnANRkKHl39Gy32cewZ9Lj0POI4nuUm57t?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f603038-e622-4e81-f765-08dc953b64a6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 17:22:30.5511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: untZSrqjf9Z/LLCv4mJW8CeAadV9H66crwAmr54AQKp4IPKT3BjRlomB390Su8RYAxz55o55RvC3PdR1+Khz9gm2pcgs5hzl/FkPGIorf2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7445
X-OriginatorOrg: intel.com

On Wed, Jun 19, 2024 at 01:20:47PM +0000, Tushar Vyavahare wrote:
> Previously, HW_SW_MIN_RING_SIZE and HW_SW_MAX_RING_SIZE test cases were
> not validating Tx/Rx traffic at all due to early return after changing HW
> ring size in testapp_validate_traffic().
> 
> Fix the flow by checking return value of set_ring_size() and act upon it
> rather than terminating the test case there.
> 
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 2eac0895b0a1..088df53869e8 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -1899,11 +1899,15 @@ static int testapp_validate_traffic(struct test_spec *test)
>  	}
>  
>  	if (test->set_ring) {
> -		if (ifobj_tx->hw_ring_size_supp)
> -			return set_ring_size(ifobj_tx);
> -
> -	ksft_test_result_skip("Changing HW ring size not supported.\n");
> -	return TEST_SKIP;
> +		if (ifobj_tx->hw_ring_size_supp) {
> +			if (set_ring_size(ifobj_tx)) {
> +				ksft_test_result_skip("Failed to change HW ring size.\n");
> +				return TEST_FAILURE;
> +			}
> +		} else {
> +			ksft_test_result_skip("Changing HW ring size not supported.\n");
> +			return TEST_SKIP;
> +		}
>  	}
>  
>  	xsk_attach_xdp_progs(test, ifobj_rx, ifobj_tx);
> -- 
> 2.34.1
> 

