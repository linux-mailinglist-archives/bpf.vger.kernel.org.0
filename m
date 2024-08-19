Return-Path: <bpf+bounces-37502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CF3956B8B
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 15:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD921F22DB2
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 13:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BCB16C680;
	Mon, 19 Aug 2024 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/BhZHtD"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CC1B67A;
	Mon, 19 Aug 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073059; cv=fail; b=KYbRuopy2AehUeXi9KxQOj3AKP7z1jlPwVkGWF7IgNSXQ08IhbQSjUon62h/PPf91MeV+ku+GoYPS3qM2mdw9/Qgke/px1gVs1OMU6/7LS/etTSaIeN7gLKbvkXNQcnKj0vcuzlP9wJLfHnishYtPr5iQAOYCENZp0YPSrZDOjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073059; c=relaxed/simple;
	bh=okEgXgdelVDZceRpRW++wOQbCvkefTyFmpEaNHDg7WQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bk9rFgHz1Tp3Z6+Wb230Asy6Xog+c2cKzaPVz/pdIsTxDnObY8ap70dLyIng7SWqfkzdHw4FukKcgHDb+N3YeL39rZm33h7LLcTzWhbQUUDsHVauMblQWe1qst+o9kuFJOn4j4jQiMO/MnQpFniLpo+/6ds/imXovKFRdqbpDGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/BhZHtD; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724073057; x=1755609057;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=okEgXgdelVDZceRpRW++wOQbCvkefTyFmpEaNHDg7WQ=;
  b=b/BhZHtDWfjSXNNZho/KRg/15LNne9tawPLayPmSf6h67Yjs1r0loBv5
   bdA40z9AWp5LU1AFw0Aqqlr2aToQIOMRUozxBGGcplgODpcAj4uWKHOck
   ITslsrNF7+URQtPJaajHdUoPlY0TYkcH74a+/ZhlF2eDJ6ij5PZlreosA
   fIA4Vv0DiG0fCkooyAiJ9NDi+twEe/pEfWNUp4+bBndH7sqoBUHX9xAcf
   jrfi/cbz9sYH7dkbBGtakbQSvL2JgAFYfR1iPh/cNxkvqSRUZjYGn2uFx
   Za+vOIxHykAQ48r807Kcqo/gN+4e0sZmPxAR+AGrPAB7lEh8KcosbNwO8
   g==;
X-CSE-ConnectionGUID: xu9ki3SSSQWOP1050ZUt2A==
X-CSE-MsgGUID: lJ5hoD5MRaCx++zlT8/qtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22476638"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="22476638"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 06:10:56 -0700
X-CSE-ConnectionGUID: 8sEgBlEkSFyZaoH/l/ov+Q==
X-CSE-MsgGUID: colMvfsYSZO1AQLk85ELyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="64760486"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 06:10:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 06:10:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 06:10:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 06:10:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 06:10:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZ9l0JgF/O8qQGm6Fj41/wzdGFTV5d7HIXlQZ5aUq5DwswKCAEP4O3wGXP74MRbRqo6L8szSkqikTLHRl+lhI0jOsc1dBR7azEYQY7Oa9ZEEkPjEt8KbPkbFn8a01dZmGdRvituNXnkY3Rw/xWmP8VtC806a1rE8DjEdmPmSYSRmu5OTgx0RO3yM4+DSaxI4z7wzEPk8+pT8XwwceNCDFEponrhkieeUuX8PKJVjsDIuRYNpTHPXtwppW+RrCgHrBqijfPIlkVDe4Pifels1wu7ORC9tjL/ZVAOuDA1Nx5C4kxQDjfj9+S8d+MyPlvB4pE3/edLyTrI8TsnWS4dxkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giaYx4v4PdlYrgvMt/e6OviKLGly8oM+ZyfijTr2WH0=;
 b=nDX+BjDx40N5V9R3OKJ3OFgDi0hKAgYTcXZIXe0bVs6KCFUaj8Ha1Y//MtTRcR13FGXKef5G3htR1BqYvzCJfqcvwYvU2qx8zP467but5u6gI4IxAbWrNVaj/rDa1vsNYtAxwDrxEcyHYaex1vuK/v1AzTdMrgruBW8fqVzX1PH5B02ULVfer3sAlQbHQ6hrNCZCbUKKt661BojVgMk6KdlldUZlvFZCr8ZyuiqiSkKFUHpAa2takjaHbvTa9+GAKb4OTEZUK8vWpS6BSsbsCKoy5qnERmcxpM6nodPoxzRJkGOpAaetKeJLRnKqdP1UAWrLWr8WXz0Q/6ARlzpE9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB5054.namprd11.prod.outlook.com (2603:10b6:a03:2d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 13:10:51 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 13:10:51 +0000
Date: Mon, 19 Aug 2024 15:10:43 +0200
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
Subject: Re: [PATCH iwl-next v6 2/6] igb: Remove static qualifiers
Message-ID: <ZsNEU1OPt6PYhBnT@boxer>
References: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
 <20240711-b4-igb_zero_copy-v6-2-4bfb68773b18@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240711-b4-igb_zero_copy-v6-2-4bfb68773b18@linutronix.de>
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c6a54d-c78e-4a8b-cc46-08dcc05059e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d741HochaFMkLqNByT7mbPZa/zuMPIqq7FUuHu2WwrOmRfU4hPPkLDSgCC/Z?=
 =?us-ascii?Q?048pE4d3bYeNJspxFYgndf498WKDNBIPvMB3+5hg66mD39rjSggujxAq+/jR?=
 =?us-ascii?Q?xgOsgqSvvU3pNntqnZteRlLchFpv2S4Lfbu6lr6WFoZA4+B9fu/Zlx+q92L4?=
 =?us-ascii?Q?cGzRWVkvfoFiXtMV2ZB2Zl0dRKVjGW/m52ME2c8cFS0s+i/Stv28c612/52t?=
 =?us-ascii?Q?45kHOa87jrzY9uthJoN+eAOcRPqf5oksvRPeLxBD/7rZP5cXmRCvnJYRqknv?=
 =?us-ascii?Q?vcpPlfhJcIaYCC/ZMlpnigizbtqKLSjrhXfcNr8OeSipqiaO12NsVuz7fLHV?=
 =?us-ascii?Q?LB/DfCSe0Y1ZCOf57KYLo17zeKpBL8ILy+Mv8pYH2/QknQD+hHoeuugFM3Jw?=
 =?us-ascii?Q?3lTnq2xZpEF40p1Foi7KCJVI3a+X06cMvdROYJRgrICcMKJA1HEw/q3ieXKl?=
 =?us-ascii?Q?Mf8WMaHHYRhqv4IZ6iub9D8pcnk8KUMKKcl7qLPnhDvKwvtXwgSUAptmisEi?=
 =?us-ascii?Q?gKdLHJ2//ko186dBxk4lVYz3RJVKw4bR0cG8pBeDzN/C4qAAOIh9NhgQu/54?=
 =?us-ascii?Q?xsxxzSeVGGxFGvOdSQlteUqbpLujnpwgl7P/GArfMn1LnCAHRdKevoweV0F4?=
 =?us-ascii?Q?OIjb+y3qBIFjXc8jjlysqiTxSNR5iQmAeB1I+2wXpz2FemlZwwMqDWyKP9jL?=
 =?us-ascii?Q?3btkMS6aIp6QEWU2IRpIvdUQ4Gq8FndctgbXSjH54awniAwoGhXv+MuKdZHD?=
 =?us-ascii?Q?v1DSVnFQgJibY6SGn81nOkU3/kR0ddINZHPkw6YcP3Wsij6cLHKRAgE43a/c?=
 =?us-ascii?Q?DYei0T4Xz5vvfGTYV/eqKU+yw2KHcozFwAsyncc69b39ADcJQD3EPTfKPYI5?=
 =?us-ascii?Q?ioB6Nt6BoHgxW6PBGcNbb4l/1LWyEnMTUYqIrfBXFRQh/r93SaetVIgQPb3I?=
 =?us-ascii?Q?XqpPAPlenBjVdkO68vDb7E5VODGYrYMtCZ5pEy0xydsNSCt2Xj1frVgPTf6P?=
 =?us-ascii?Q?xN545F32eBWc4ERYLxjuGv7f7TCsuoVnevADWcq7+dRTNG8L8XZbeIPmgBb4?=
 =?us-ascii?Q?avSJ4+qDbqzaQVm8RCbOyUwLEJTRx2cge/0dvleffvWnviIjwjj5syi9B16t?=
 =?us-ascii?Q?6ybK02CiVJZVIDI7XW97SlnIzrMaO464dNPSuloRwDMJlHaH68o6wCburn63?=
 =?us-ascii?Q?+IZuI9QLvdgZ8t/qEUKIAkQmUTZ03dhiw71JeagJEAonkKiKLAW1qFI6hH+y?=
 =?us-ascii?Q?IFtICiy1qnMKv23juneN3VTC+TinDgkKGYAvVrycrSRMqRAZXGeW+l4Ihmbv?=
 =?us-ascii?Q?73RW3NjyYBt5rQxFc/DmdvL8IOK/Cg+Jsrb6CszOX7jLJw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ETyw3bVwQeKnv4cQ3LkuvNAu6P6mz1QCw4HE4VyYCbVk/Wf4KpMSahxbF9DE?=
 =?us-ascii?Q?WD2f9MJe3wldZOWjtHapf3OJ2IoWNvAPTc4EtemgXTOlyCQLn5PWyQoxKF7t?=
 =?us-ascii?Q?szK5lY/9u8zuPZ9MBgIINky6Q4hqF3m8CGJ/FTvCaJcUfCHjXZEMlFOwah5w?=
 =?us-ascii?Q?7cDvv3Ja7EWf+54y0+keGVSbO3GGhuXHHoWYyt18Z2sxqx86ReLE0e7yIvh5?=
 =?us-ascii?Q?1ZGpngZexcaQ20US7cv2QwHbBKqUj7cjEYc8IHgvi1ozY493Uo2VmHMfnetG?=
 =?us-ascii?Q?4mrEKaZ2rU1z0MKIRMGlrx/zwoImGHXD/kUzbxi616q4mpf0rlq8QK7n0XDZ?=
 =?us-ascii?Q?zwDJDzqVRTugVLb3u4NIzKD8tktJ8QMn2i8F3FVWDJ+7S4XzJMNVVnR/oj0i?=
 =?us-ascii?Q?2yy2LbaCvvjVK8vsM48PxM2WpFl2ZHJVoU4IUXrtzP4wInxdD/Y4oVd5QQnN?=
 =?us-ascii?Q?wNzcHJInKGlJGMOpWOrv6tS1VvB09A/U43q/qPUn2NURHkRVHEW/K4BWHFy+?=
 =?us-ascii?Q?WOGOLl77VVpJjkFSsARS8NTKtiCgFqdctHMcuYNImNkGZHleAYKoORuojCPV?=
 =?us-ascii?Q?m5ErE7lSr1hhxNYzHjQ9pPPyUTG5+woU6pnRxNXIYsxO1ZAyGRj/ZAoOxzGz?=
 =?us-ascii?Q?nUDBOJqtRox5OBZMxjTf++isvbbiwA37uGtngjhij2Mwlo/KOmtys3zlUqRb?=
 =?us-ascii?Q?O8oReDgpoU0eBHW2TElTVpZtoDEz2Duccmt9tI5clwiHYfg2PikUlMYvpafX?=
 =?us-ascii?Q?v2tSaIN53Q5tNSC/XZwshyKZYCmZYudHrzeivws1xhtd9ruTi17k10+ymIta?=
 =?us-ascii?Q?yd1oU2jRTQRgRRQ4eDnLYAZbGDHgwV/OYKIJK+khs8lf1noQs/MlTg5AnaC6?=
 =?us-ascii?Q?WAr5XgyOmoGPZpRsxjI0DfCZukW6h+LvFdt/F0pa/7zOUsd14rov7kZm05QV?=
 =?us-ascii?Q?apg8D+v5My+4VbnrARfHM8Ss9iV/Q7ZEutrjmYPUPoVSJK6zH9TFQpcZ1h9K?=
 =?us-ascii?Q?uppWOX2KgpKUqU7pYH076ktJJznu8ba6AeVYollJwkbY+S61DURS8E7hDyzG?=
 =?us-ascii?Q?/u6yEmfVeIMYk3Et6Jd0KS5DJVRY7DRc1jGMZGiT6aI3nfQMUxOGqP1HAkv0?=
 =?us-ascii?Q?+HuT/URykkGBRpEHPFAn470QjCCdYpKNp2+y/A0DScdEvjjRPuzpHzIw+LKq?=
 =?us-ascii?Q?8YvkcC7758LhU6FImo5/9kysoi5jjr8NR6NSuLUg2kEtFR5APt2ZK1zlmhKa?=
 =?us-ascii?Q?UmUmt0UlKMBA6+9zIpFOAlg5uMoNbebbnyvXePblbFIXFSXfvM81VaISWDmL?=
 =?us-ascii?Q?vtXzQyPyieLYd+HbRy0+ecB6LGkQZOp8/AVO6K9oEvcUEnrMHKeCjl5T1t84?=
 =?us-ascii?Q?54AHXy6DcYTDSpBNHexmUbyUFfJx/Jhdvjo2ze7dXAgcDu5K0wLxasdTp4rE?=
 =?us-ascii?Q?XRIoLKJNJ355RSwun0fhHXIkAEy/Y9fOdJA15n2lFKqM0JaM807iBI+oFTLL?=
 =?us-ascii?Q?O59xV62MP06Q9FBgm2XFisVM5SzgQdB4Fw06K9VOG9KGs3HU7IHc+cVYZpSF?=
 =?us-ascii?Q?Vvaeg2bpVW31P+KkaQtduTHP4H0LMaE8Ye8DEUXSjtyIKAjChIWFJO1S/3+m?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c6a54d-c78e-4a8b-cc46-08dcc05059e3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 13:10:51.8838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +p+JxjGIZp69Niq+1K0MQ8TzznUOjh5Jgof/MkHf6JE/eVAZI4pAqv7O/80aOG0tBO/g3zmxxkdaEtIAcvPdPZ63ga8CQKdf9fxFH38OTF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5054
X-OriginatorOrg: intel.com

On Fri, Aug 16, 2024 at 11:24:01AM +0200, Kurt Kanzenbach wrote:
> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> 
> Remove static qualifiers on the following functions to be able to call
> from XSK specific file that is added in the later patches:
> - igb_xdp_tx_queue_mapping()
> - igb_xdp_ring_update_tail()
> - igb_clean_tx_ring()
> - igb_clean_rx_ring()
> - igb_xdp_xmit_back()
> - igb_process_skb_fields()

How about inlining some of these that are small enough?

- igb_xdp_tx_queue_mapping()
- igb_xdp_ring_update_tail()

> 
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> [Kurt: Split patches]
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  drivers/net/ethernet/intel/igb/igb.h      |  8 ++++++++
>  drivers/net/ethernet/intel/igb/igb_main.c | 18 ++++++++----------
>  2 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index 3c2dc7bdebb5..c718e3d14401 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -718,6 +718,8 @@ extern char igb_driver_name[];
>  int igb_xmit_xdp_ring(struct igb_adapter *adapter,
>  		      struct igb_ring *ring,
>  		      struct xdp_frame *xdpf);
> +struct igb_ring *igb_xdp_tx_queue_mapping(struct igb_adapter *adapter);
> +void igb_xdp_ring_update_tail(struct igb_ring *ring);
>  int igb_open(struct net_device *netdev);
>  int igb_close(struct net_device *netdev);
>  int igb_up(struct igb_adapter *);
> @@ -731,12 +733,18 @@ int igb_setup_tx_resources(struct igb_ring *);
>  int igb_setup_rx_resources(struct igb_ring *);
>  void igb_free_tx_resources(struct igb_ring *);
>  void igb_free_rx_resources(struct igb_ring *);
> +void igb_clean_tx_ring(struct igb_ring *tx_ring);
> +void igb_clean_rx_ring(struct igb_ring *rx_ring);
>  void igb_configure_tx_ring(struct igb_adapter *, struct igb_ring *);
>  void igb_configure_rx_ring(struct igb_adapter *, struct igb_ring *);
>  void igb_setup_tctl(struct igb_adapter *);
>  void igb_setup_rctl(struct igb_adapter *);
>  void igb_setup_srrctl(struct igb_adapter *, struct igb_ring *);
>  netdev_tx_t igb_xmit_frame_ring(struct sk_buff *, struct igb_ring *);
> +int igb_xdp_xmit_back(struct igb_adapter *adapter, struct xdp_buff *xdp);
> +void igb_process_skb_fields(struct igb_ring *rx_ring,
> +			    union e1000_adv_rx_desc *rx_desc,
> +			    struct sk_buff *skb);
>  void igb_alloc_rx_buffers(struct igb_ring *, u16);
>  void igb_update_stats(struct igb_adapter *);
>  bool igb_has_link(struct igb_adapter *adapter);
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 4d5e5691c9bd..0b81665b2478 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -115,8 +115,6 @@ static void igb_configure_tx(struct igb_adapter *);
>  static void igb_configure_rx(struct igb_adapter *);
>  static void igb_clean_all_tx_rings(struct igb_adapter *);
>  static void igb_clean_all_rx_rings(struct igb_adapter *);
> -static void igb_clean_tx_ring(struct igb_ring *);
> -static void igb_clean_rx_ring(struct igb_ring *);
>  static void igb_set_rx_mode(struct net_device *);
>  static void igb_update_phy_info(struct timer_list *);
>  static void igb_watchdog(struct timer_list *);
> @@ -2915,7 +2913,7 @@ static int igb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>  }
>  
>  /* This function assumes __netif_tx_lock is held by the caller. */
> -static void igb_xdp_ring_update_tail(struct igb_ring *ring)
> +void igb_xdp_ring_update_tail(struct igb_ring *ring)
>  {
>  	/* Force memory writes to complete before letting h/w know there
>  	 * are new descriptors to fetch.
> @@ -2924,7 +2922,7 @@ static void igb_xdp_ring_update_tail(struct igb_ring *ring)
>  	writel(ring->next_to_use, ring->tail);
>  }
>  
> -static struct igb_ring *igb_xdp_tx_queue_mapping(struct igb_adapter *adapter)
> +struct igb_ring *igb_xdp_tx_queue_mapping(struct igb_adapter *adapter)
>  {
>  	unsigned int r_idx = smp_processor_id();
>  
> @@ -2934,7 +2932,7 @@ static struct igb_ring *igb_xdp_tx_queue_mapping(struct igb_adapter *adapter)
>  	return adapter->tx_ring[r_idx];
>  }
>  
> -static int igb_xdp_xmit_back(struct igb_adapter *adapter, struct xdp_buff *xdp)
> +int igb_xdp_xmit_back(struct igb_adapter *adapter, struct xdp_buff *xdp)
>  {
>  	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
>  	int cpu = smp_processor_id();
> @@ -4880,7 +4878,7 @@ static void igb_free_all_tx_resources(struct igb_adapter *adapter)
>   *  igb_clean_tx_ring - Free Tx Buffers
>   *  @tx_ring: ring to be cleaned
>   **/
> -static void igb_clean_tx_ring(struct igb_ring *tx_ring)
> +void igb_clean_tx_ring(struct igb_ring *tx_ring)
>  {
>  	u16 i = tx_ring->next_to_clean;
>  	struct igb_tx_buffer *tx_buffer = &tx_ring->tx_buffer_info[i];
> @@ -4999,7 +4997,7 @@ static void igb_free_all_rx_resources(struct igb_adapter *adapter)
>   *  igb_clean_rx_ring - Free Rx Buffers per Queue
>   *  @rx_ring: ring to free buffers from
>   **/
> -static void igb_clean_rx_ring(struct igb_ring *rx_ring)
> +void igb_clean_rx_ring(struct igb_ring *rx_ring)
>  {
>  	u16 i = rx_ring->next_to_clean;
>  
> @@ -8768,9 +8766,9 @@ static bool igb_cleanup_headers(struct igb_ring *rx_ring,
>   *  order to populate the hash, checksum, VLAN, timestamp, protocol, and
>   *  other fields within the skb.
>   **/
> -static void igb_process_skb_fields(struct igb_ring *rx_ring,
> -				   union e1000_adv_rx_desc *rx_desc,
> -				   struct sk_buff *skb)
> +void igb_process_skb_fields(struct igb_ring *rx_ring,
> +			    union e1000_adv_rx_desc *rx_desc,
> +			    struct sk_buff *skb)
>  {
>  	struct net_device *dev = rx_ring->netdev;
>  
> 
> -- 
> 2.39.2
> 

