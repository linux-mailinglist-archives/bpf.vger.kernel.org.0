Return-Path: <bpf+bounces-56619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3963A9B2A6
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 17:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C658A1B87E2F
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 15:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D51D22A7FF;
	Thu, 24 Apr 2025 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gipl5eJy"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C871A9B23
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509316; cv=fail; b=D2j6e7aY1kWCPhsuhCbe1qMITMtniZkz09O+DZFm5f2SpKzIFXzJjOaEWiZ5Uw0tHfqsUDVz3GdcbmJzjrcw9CFZz58X95GKCSc6sYYyYY5S93nrCD5OMZu8qL7GDnMgMsAeqnT1Ra0D2vR9Nka5S8dIWDbhtJW6j6PBlYktxxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509316; c=relaxed/simple;
	bh=0Frrc05X/uvP7C4ew05dQjbzpshaYnUqmxQL+p1ArLU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uw1rYznrfv3Jnm1hHXVNXEHr47MXu7xN0OGhGTig01G6Io0Hm6/FjLSrPS3T4Z05qVecgJ2+MMLoRMUy0HL7TeQEAJZC4RY7B6uZSghRiEFnUTb8G/AK1CuHkFTJ/R1j64r4mdSBkfZXKmj1+hbXfeDZhyLlTeXPVUtfl7eVycw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gipl5eJy; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745509315; x=1777045315;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0Frrc05X/uvP7C4ew05dQjbzpshaYnUqmxQL+p1ArLU=;
  b=gipl5eJydeqJMYxnk8sp2YH1iOt7xsohoM0YO5/qaukSF8P8szBZUNQb
   Dmvbm1YsMMM01H6ctwCyoOpoL4DhJlY6k+fo8LkTdvTWolXy22A/mV4jp
   yZibw4yUVn3c9Rx0VVDn8jFE02dK2HFcVN5Sq4WcoZ4UBAxedlsiUteUk
   J/V0g2dAavzXKD7rvT1Ayn2fW02HNFMWvi8JOVeSCDT+rVNMrViEkVxmo
   jewqFW5pGebYWUhBalveAfqwrHD7kwUk5IpoZ6rvvPb7ULHYwxvDCeUVN
   p1BdDOw9cy98gkHNaDLww5Pnng1uAygoWSKihWc/oaKo2BYDHF7EiLEyR
   g==;
X-CSE-ConnectionGUID: eD/Uq6PMQOeL4fsU9OJHow==
X-CSE-MsgGUID: MNq/EyVXQIeqZ/S8Y7gPLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="57799895"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="57799895"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:41:54 -0700
X-CSE-ConnectionGUID: ff2MujtrStaPO28jav6Eyg==
X-CSE-MsgGUID: ReISa9cbSlaAX4inqxgscg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="155878788"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:41:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:41:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 08:41:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 08:41:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLE85trz6O4/gqs67Ef38HwhkRfU7fgAd6mDhIbPFuplSnLhXEltRujsti9CuKQgrQg2PNbmRqmrY6hoDTf1DDHR0v81flLfKJ5VRUd+oUvBhwfaI8VwaewAj3HX4q0G1PL+VkP8V5FesBu/Ds8KwlogQLgADwX5PHm7X3stkqs0eK+lxbwtFtgvz1Q/HlEfWa1QKN3h0BNV6h7hhFGMjsikj9/0+e2+ZY1OrkRsDtxa7jyHFBhWvl/NsBIjXTc61xHzYOVFp5tn6dfQdQPssA3q4Kb3uhB6V4FmzliGErcYCykbbfRxBAnYPqSOPymkujXVT1hxrIEv6RoOnwrz5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IokXxq3nKm7J1Sa6KFu8r77ufmlBTX7RGwbkTAxclj8=;
 b=NAOMepT+M3B5am5ywfbKFch2Jzal4Os9oBI2OdSauNMXEeYarFijJVWWOauatN2B3dWEL2tON6kXl5d4Tx7AgvQY20EsTRHdMIsuI8I00+FiXVoKUBTPCPLsKWC3G3qQAp9rw8uJ0ygqIAUbEhuZFwt5XfjJw2CFSc7+vSQr6gahTYa4kAu89oKP4hddVQD4bBWGCfiv5yaU4nse+gRnlOU1728dJhtmh3ozDMaJAsMTN6hIcj8p/dLpRh1JUsNXthEhNgKSmq6w1bwDxns5c4B9BGPk4cfaSD0ULbEFxDr16vf6wmCQ1PZL1G9sFciKZxvajRLUci371upgK6TunQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB7050.namprd11.prod.outlook.com (2603:10b6:510:20d::15)
 by SJ0PR11MB6765.namprd11.prod.outlook.com (2603:10b6:a03:47b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 15:41:51 +0000
Received: from PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582]) by PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582%7]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 15:41:50 +0000
Date: Thu, 24 Apr 2025 11:41:47 -0400
From: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
To: Hou Tao <houtao@huaweicloud.com>
CC: <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 bpf 2/2] selftests/bpf: add test for softlock when
 modifying hashmap while iterating
Message-ID: <q7dufnvevblcewyafaqujpkqcvphokv7qpk2igdtukaockcazy@zaszgtxzjs7e>
References: <20250423171159.122478-1-brandon.kammerdiener@intel.com>
 <20250423171159.122478-3-brandon.kammerdiener@intel.com>
 <ae6599f3-fbe6-8c79-eba2-c43e1461d814@huaweicloud.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ae6599f3-fbe6-8c79-eba2-c43e1461d814@huaweicloud.com>
X-ClientProxiedBy: BY5PR20CA0020.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::33) To PH7PR11MB7050.namprd11.prod.outlook.com
 (2603:10b6:510:20d::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7050:EE_|SJ0PR11MB6765:EE_
X-MS-Office365-Filtering-Correlation-Id: efbd6be8-3e32-40c7-a338-08dd834687db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UBedKhNg7nDWo7DgSXxBHT3YSnquEuwddephGpEKEH5aJAoZRlwb5/DizFrw?=
 =?us-ascii?Q?fDlIXqCZiNiKZDYKmdZJONeKnsDegRWAmnu0pg3GeLtaS3vBM3FXByctgaMZ?=
 =?us-ascii?Q?cPQFYOKzAdoFmz36BO+BqpT0GNdBYrHb/SufL+/sF5vQuUwmlZ2GWTd22jNn?=
 =?us-ascii?Q?i6p4NIPR5wkVUbDOa/77SOTo6I+scaqy2HTH3t+ripTdwMJxPxn61jS2IEly?=
 =?us-ascii?Q?t5PRQXbvl5z+x6Rf1jRmgC0EgPOU8CxeJ2U5wRcAYxPn1IyuvdL0FEH5/6pg?=
 =?us-ascii?Q?RpBi/11ZXkc2rN8cse9H6yVd4EF/vKem48ZTfyEheG3QDg3z/SNJAc1pgCj5?=
 =?us-ascii?Q?67GGaGRj2QkThwMSolDWXFI5uTtTAaTROO4QTGd4HI2eG+GLNshXUwdiofTH?=
 =?us-ascii?Q?W6evR2err71yIHSBZh0ARJprTvINiFRldKk7oT6Uj7wYfq38xn/l1x3scCin?=
 =?us-ascii?Q?yEdjsKLj4n7GcGtywTnIhf770b6sWA4OFbvREY2FAmI1pSd/dCzBxI6SIBjr?=
 =?us-ascii?Q?IPFZR0gQCJAa9IPW/PEQX1e300RbjV2g+dpoRsyFftVjHYyLWCdKn8AYVuJ0?=
 =?us-ascii?Q?UNSUQGKM8rxcaoCY4clT8d5CoOod8mNBXSqhVzet7tEDlL+FtpxEMePWCRKW?=
 =?us-ascii?Q?RaMhi3wRISCVSRTKmId/2aJde2sk/m+o14PyVgH6sqTM5WwlFjXwHLxr8tQ/?=
 =?us-ascii?Q?l8P3RC/aNH0n5QlD0fBqs4LZoEyvKScrBcm6H790HCdJwyY8vF4C96UYAhL/?=
 =?us-ascii?Q?Dp3IbUHBbyK/uvrnELa00MLNvY466L3oWNAdm/Y7UT+sVSQA6bVim0BKPPcS?=
 =?us-ascii?Q?P2WwiHvOrZ+xtOJWIKuyA7MtgUMtnXnbsBESJPfhdQMhfa6cjL3PBxlmXRpC?=
 =?us-ascii?Q?QjVTcsQ5w7AKA8tjQ/OiReEFVhY8YmO7Yw/+Bf5LTLtw1wvWGup8L5kyZo7F?=
 =?us-ascii?Q?yRPIbSfnWU19QJZ/AfO/2EKHglmtnJKQ6lmdAum9z0NjZgjPdNkeh1br7S9b?=
 =?us-ascii?Q?2J14oiV1x1Df2oBIraOwYZPZbwjAo4KJLoqNXpJOABxlK3IIZ7tQdywTTJU1?=
 =?us-ascii?Q?gVCDKQwf4uo/no6q1SEuJFm768EnhsWiWVQj3HczNFq3cgI3fZNVyqg8k+Bo?=
 =?us-ascii?Q?9kaFmMFZsVOqMcaEmHFN00nLvKBrKxvrDlLCCwAilXJjsBEe5jVTcWfnn6Xz?=
 =?us-ascii?Q?XWMuSLPACWFj0HB7+NvctgiDG+K4phg8QJc6xM6V7Eq1YynGiC97lZYShr9w?=
 =?us-ascii?Q?wQeh7Ze9Psq7Dy7BxoS8vI2EaH26eEIOHBQW/IeHcw6tGGS83TJxjUkT9t6M?=
 =?us-ascii?Q?+TupA0LBI953sQEIgoSu8YuvFKGzUGufATLj8TyIDwA+7bK0jPv0DnSHXKlO?=
 =?us-ascii?Q?k8JrYoSo3dGC6uzoKgs7Q8lrFIP6OmaVUhVIH/+DJa0EH2aOJ0gArkx0ExsG?=
 =?us-ascii?Q?+9jSflEWJbE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q9FmWTF9sy6kVlRldaMkQ68lc/2VFYRUCkEA/kku0EqAkGt6EBmNy3TyMIKN?=
 =?us-ascii?Q?yGUY87Lgu+El/PceRvLW50Y7S2Qkezs/DuJlpZfgYVtOU5WOaCcf7SG0g9R1?=
 =?us-ascii?Q?ko7+rgt1AMDGbwLGUNEiRKVA+Zi6EcF2zoSKCM8XmsKIV4h8eb3Egi/QZs5p?=
 =?us-ascii?Q?l4SC+A8IaBeN6ZM5hKBfX/5Ts1iBYwQ34ZFwrSgaFIwnXkMV3J0FnY+u9Kb4?=
 =?us-ascii?Q?qNf72OLovVoAnx9IOYrj9e4sQsf+hFuiyYHvcjDLYkhqS9P0pe/QxpKidCmn?=
 =?us-ascii?Q?zsjf4NkJFOVEVQjqwKwFtD/qZ9okbP/R9KlLkyj+qetAHtVC41LcFHF3suAV?=
 =?us-ascii?Q?EZ5bY9wI8JvFTaEBG/KKtSxvZaXIGVNw77t2NxZqdo9NMFrf7migA+/ZT7d4?=
 =?us-ascii?Q?JoXJdiHT579me+x8FVCzF2PAC3wAazzwe5bEanI0fjptNdMncoV8X1V5yakG?=
 =?us-ascii?Q?m/y3BEHxMq6ZxPOUvSzIkxYWqIGohX7URe9GNSwVzOYntqyWaE0Wu2cWkpAC?=
 =?us-ascii?Q?PQc/dQCPPwGY6eE75JbQxb+djY74G/THRowlE4bytVdu2P4EOrA31SrlwNzf?=
 =?us-ascii?Q?2tq/qeeVwiLvBzTTJl9tHMYvRLTfEnDxPe46PpHq30xpu3/hjJLWL52F1A3u?=
 =?us-ascii?Q?ERkeQkMhrAjC8PI7iXVaaNUclgLVWE2bSXkKvRtnM4UL4NIzWbFRNKc0/JRo?=
 =?us-ascii?Q?SOiRucy++3JfEnlgc6UUEfaYYPHfmsMkhYDlUjitQLxmkrKFlikQ7HUaWBJu?=
 =?us-ascii?Q?5VQZmy6cib3jl8T5ZdZOiPGcR0LnveFadZIS9pBvipQ5qnSmK8sB9PsgKjef?=
 =?us-ascii?Q?cCI9QfZv7eSeiiRQl7rJXBQEeDU414QAqBfZO0hwG2g32klpDOIOl+XaBXsH?=
 =?us-ascii?Q?6lNkzpv35bjRhciw9EAood2/FqQ2ZVXXPNKhF+afb/JcVlGrf2Bplc6+eL7g?=
 =?us-ascii?Q?HsG1RpjNicbV1hehjei4G0yfGPRFIT35s4LcWxfgTwkyINQ6Q/Cbu4ZzpGQz?=
 =?us-ascii?Q?c0gcOLwKbOmnTigDVi6cUJaAlX1GUkQCxIX8k856mDx4h5KlZjfRzE+uiOr5?=
 =?us-ascii?Q?+v5NtNtLAPYGLC1g43R3vFzA/EKbxGdL7d/lISs1cMDsIzZmtrVxCSjI2qgr?=
 =?us-ascii?Q?Vk1K2adVWPCPM2tv1Y9y3dblPjlO/jxeTPOCq+5DsbpHhIGkcO9wlPF9vqO9?=
 =?us-ascii?Q?DssxAamIiYGAnEVObTgJufCHtLz3Uw6ZpaOAXUHSnGklFcoB0AjL9VMBjEDY?=
 =?us-ascii?Q?S3HRf/BLkCL3ZjGatd9V1etTi2UpH00IRgbcmO9STHeowZ47QctsGszM1Hwb?=
 =?us-ascii?Q?OTBQmsCeDANwjBm/Zh7u8805Jij5d1TZ5aCSvyMxQX3+Z/iztQvh/6SqJ+fN?=
 =?us-ascii?Q?z7LolYcxbm4fKg5mCqMeqZ1tIBQqDTeSR8ewfWYblXuTVDCwc5WgQ2UAVdia?=
 =?us-ascii?Q?+K4r9WswtwWC3vjSlA0Aa9EMs3GK/JeBWyImhzmpRB5NrbPn8fO06CpvqSBo?=
 =?us-ascii?Q?ncHBDLA3tHcql5H5v1Uo8SNsniagMXz6AC2uchCp/dyMK5a2Mg/3FzeswNjG?=
 =?us-ascii?Q?dSu8Ustpdztnc23SYeP39ka7yM4tD1gAWBYaipU+P3iMYmLaVS8n1e8xeHmR?=
 =?us-ascii?Q?lYJkonwaV1A6KnNTVkqCYIw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efbd6be8-3e32-40c7-a338-08dd834687db
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:41:50.8310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gznjsv/Mrv9DScwUi4/rx7dLAHjInXaBkbohHviBZb3N+LcrWTMxcu93nzD618t9LzfUFWYOjLw3rw+TAcILAk5tObYPWTq5+ybPICBbvDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6765
X-OriginatorOrg: intel.com

On Thu, Apr 24, 2025 at 09:38:34AM +0800, Hou Tao wrote:
>
>
> On 4/24/2025 1:12 AM, Brandon Kammerdiener wrote:
> > Add test that modifies the map while it's being iterated in such a way that
> > hangs the kernel thread unless the _safe fix is applied to
> > bpf_for_each_hash_elem.
> >
> > Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
>
> Acked-by: Hou Tao <houtao1@huawei.com>
>
> With some nits below.
> > ---
> >  .../selftests/bpf/prog_tests/for_each.c       | 37 +++++++++++++++++++
> >  .../bpf/progs/for_each_hash_modify.c          | 30 +++++++++++++++
> >  2 files changed, 67 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/for_each_hash_modify.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/for_each.c b/tools/testing/selftests/bpf/prog_tests/for_each.c
> > index 09f6487f58b9..f4092464d75e 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/for_each.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/for_each.c
> > @@ -6,6 +6,7 @@
> >  #include "for_each_array_map_elem.skel.h"
> >  #include "for_each_map_elem_write_key.skel.h"
> >  #include "for_each_multi_maps.skel.h"
> > +#include "for_each_hash_modify.skel.h"
> >
> >  static unsigned int duration;
> >
> > @@ -203,6 +204,40 @@ static void test_multi_maps(void)
> >  	for_each_multi_maps__destroy(skel);
> >  }
> >
> > +static void test_for_each_hash_modify(void)
> > +{
> > +	struct for_each_hash_modify *skel;
> > +	int max_entries, i, err;
> > +	__u64 key, val;
> > +
> > +	LIBBPF_OPTS(bpf_test_run_opts, topts,
> > +		.data_in = &pkt_v4,
> > +		.data_size_in = sizeof(pkt_v4),
> > +		.repeat = 1
> > +	);
> > +
> > +	skel = for_each_hash_modify__open_and_load();
> > +	if (!ASSERT_OK_PTR(skel, "for_each_hash_modify__open_and_load"))
> > +		return;
> > +
> > +	max_entries = bpf_map__max_entries(skel->maps.hashmap);
> > +	for (i = 0; i < max_entries; i++) {
> > +		key = i;
> > +		val = i;
> > +		err = bpf_map__update_elem(skel->maps.hashmap, &key, sizeof(key),
> > +					   &val, sizeof(val), BPF_ANY);
> > +		if (!ASSERT_OK(err, "map_update"))
> > +			goto out;
> > +	}
> > +
> > +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_pkt_access), &topts);
> > +	ASSERT_OK(err, "bpf_prog_test_run_opts");
>
> Also need to check topts.retval.
> > +	duration = topts.duration;
>
> The "duration = xx" statement is unnecessary for ASSERT_OK macro.
> > +
> > +out:
> > +	for_each_hash_modify__destroy(skel);
> > +}
> > +
> >  void test_for_each(void)
> >  {
> >  	if (test__start_subtest("hash_map"))
> > @@ -213,4 +248,6 @@ void test_for_each(void)
> >  		test_write_map_key();
> >  	if (test__start_subtest("multi_maps"))
> >  		test_multi_maps();
> > +	if (test__start_subtest("for_each_hash_modify"))
> > +		test_for_each_hash_modify();
>
> Considering that all these tests are for_each test, I think it would be
> better to rename the name of subtest to hash_modify just like other
> tests case does.
> >  }
> > diff --git a/tools/testing/selftests/bpf/progs/for_each_hash_modify.c b/tools/testing/selftests/bpf/progs/for_each_hash_modify.c
> > new file mode 100644
> > index 000000000000..82307166f789
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/for_each_hash_modify.c
> > @@ -0,0 +1,30 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2025 Intel Corporation */
> > +#include "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +struct {
> > +	__uint(type, BPF_MAP_TYPE_HASH);
> > +	__uint(max_entries, 128);
> > +	__type(key, __u64);
> > +	__type(value, __u64);
> > +} hashmap SEC(".maps");
> > +
> > +static int cb(struct bpf_map *map, __u64 *key, __u64 *val, void *arg)
> > +{
> > +	bpf_map_delete_elem(map, key);
> > +	bpf_map_update_elem(map, key, val, 0);
> > +	return 0;
> > +}
> > +
> > +SEC("tc")
> > +int test_pkt_access(struct __sk_buff *skb)
> > +{
> > +	(void)skb;
> > +
> > +	bpf_for_each_map_elem(&hashmap, cb, NULL, 0);
> > +
> > +	return 0;
> > +}
> > --
> > 2.49.0
> >
> >
> > .
>

Thanks for your feedback. Sent v3.

Brandon Kammerdiener

