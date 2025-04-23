Return-Path: <bpf+bounces-56512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B900CA9961B
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 19:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3378465877
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 17:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7117528A406;
	Wed, 23 Apr 2025 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWZpjFGT"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C115820F067
	for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428342; cv=fail; b=I5aBH5pTII0ccdZTW2sZJWVp3rmbUcZ2+7LM4hQBNmsg8iWN/eh/XwQOH96nl2H6IN645aKqTCqC0ubhgXg9fLvKJeyXLdekLpTlnEG33H9qYArTjQoHHqDU90G1nJmCl+s1JwTWtyDpSu+CdY1Xo+oferRWbDVxN0Ikbd7qzkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428342; c=relaxed/simple;
	bh=2emwSKV/uLvXCeqyBUkBf8q9h3E1e8q/tpyN1HL9d2o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qsMMDgnzDPlYZxMdB34NC6ZXzPgXGtU9WSzDDsRI+fDdFiFxorZoW7XPgbsVs1LuymozJSITxJaWX0ATvzrs9EA5VYfmzWl6WpUpa+JPuF1V+pAdjSRZV7XNygxWUjtyMQIalPf6cq/ifV+/+jQHJ93NOTRtctnUdbaK3K+i8rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWZpjFGT; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745428340; x=1776964340;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2emwSKV/uLvXCeqyBUkBf8q9h3E1e8q/tpyN1HL9d2o=;
  b=lWZpjFGT46OaWs4XZ5SOTENVTjL8z8eZpD5a3zQMPlSG4qaSye0Ub3r7
   8u11/dGNVXHFjXpSV0rDQ02Y848TnC2VSTQTdWpq2r0/o1kA2EWsZksFV
   q2uoGXgWNek3iRwCveSDMoDr9lfCjFuVMgXCZd1+BETR/9D+/0OgTnejc
   3ALjAVjGYMFIG+MdMoLfhCOVA9THwEDkB5wX3C5hvn+RZPPYE9TaUFhWh
   z+pyLuvsHIn78iDo6SHaN2yfW/DpS4ApmNWwIRXDRdFC8n3jANvyK68Ex
   hdv6EVNEmlkx7CAlwC1iHwYq1D0uZu1PSUVnrfJ6fTIKvdHyKb5Peap05
   w==;
X-CSE-ConnectionGUID: XIgve9pjTlC5nTnA5lJh4g==
X-CSE-MsgGUID: sa84THftQ6K2nHGpOfDY5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="58405778"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="58405778"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 10:12:19 -0700
X-CSE-ConnectionGUID: KkGq1ySpQzWO0srGHilcmA==
X-CSE-MsgGUID: +zvWDjNWS06/UjFxG5ClaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132674923"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 10:12:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 10:12:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 10:12:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 10:12:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHZj6SP2Zyxw0BDJ5mCdiJJRBesZ28q3qtGYR6lODKBg1SMK2A0eJoX0dOAEZa9YqaFjA+wK+QoZFHGbiwfSWrwBPwmxuNve8v8bZNrt4kYldjvNIgeO1jPTkK49E8a2mtm1FQ5sdqXThiW4kieOaW/4kpvwn/4TlOW9PMUfyOd7AotE5sjWAwdnKsaVYwGE5pXr/F5khRIzYN4umNq8e667bwCDDrbVQ0m9i0dDcc8tL6xTeOa5ySWIi52BSoQgXcN2jXP+Drpl6YGS1no+SzAWitADP//KRtnbvon4FIAxtHqzqRbmLPsVqEOd9zqVE+rEVbcOligroP5WzWiQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uofvUBNnNyTqpg7acmOadR6sYOMY9Ym2YZky49cuzmQ=;
 b=w2v6iut/i02R9iqOtNTq36TNYx7YGP+DNNWYg1xMi2Zq9c7cHfIrZFMixwBxPThLJ4hki55oYc+l/7SR9oL9fB6Je0c1K2ZgfirOKDTMwTcm39fLRA2nG2vy+TV/+i/y4VssxBf2Dn9rvUY/qQLcREV+6Gj/ltkNNRqAOmAhRnljTTf2YmJOd55uQPDB98Mb3gSdJi/ls3Ng5EG3faTsdKPyMNxcAZuL5fGUv8Y2qBeYuP+NdG/WLG8RrXRA2BxrBxNYTSRWCOp8bhC/33lG916OeuIzl4W/u1/JbP2AhMlfF9r/VQHlOtM+SYEWJOQAVVhnLM15JYkZTf/r9X6w1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB7050.namprd11.prod.outlook.com (2603:10b6:510:20d::15)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 17:12:07 +0000
Received: from PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582]) by PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582%7]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 17:12:07 +0000
Date: Wed, 23 Apr 2025 13:12:04 -0400
From: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
To: <bpf@vger.kernel.org>
CC: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
Subject: [PATCH v2 bpf 1/2] bpf: fix possible endless loop in BPF map
 iteration
Message-ID: <20250423171159.122478-2-brandon.kammerdiener@intel.com>
X-Mailer: git-send-email 2.49.0
References: <20250423171159.122478-1-brandon.kammerdiener@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250423171159.122478-1-brandon.kammerdiener@intel.com>
X-ClientProxiedBy: BY5PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::16) To PH7PR11MB7050.namprd11.prod.outlook.com
 (2603:10b6:510:20d::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7050:EE_|CO1PR11MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca3794b-453e-4d36-96ec-08dd8289f9f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T1jpvetuCCDaaLP3WlWEnUcniVcdCy05aPoxNMko44WpLPIx0970Kb9Uq+FX?=
 =?us-ascii?Q?FewbbhVvPY79ilTA02jgJ76aZxhXktl/DTi+AeR+BH13qMxRxrc8K/oZYhWn?=
 =?us-ascii?Q?YOggXA41mcs1kcpK6FvPN3vAAeCtmQZnCzzkuW3KijHuaaGYdmDKvw3mnA06?=
 =?us-ascii?Q?P1hBr3tJpSw0O9ZSV248NytLhQ+/3PBvBr+n07f6c3KWNkAjGgHwlBHt6L1z?=
 =?us-ascii?Q?K3AWBcSH/JIlqGkKU+Lj7gPvJVPqbXXb/RJjKQKj791tWqckOon+aozRGd9u?=
 =?us-ascii?Q?wnA6rGItY8/I9wnmDf+zsZzAt1l9iSJT3/QOiuhVZmjhIAtfdxTVgi1NV9Z7?=
 =?us-ascii?Q?UP/u440yIcfAQ8IHBvLBrotSTc5HyJ4zTXZLwY3RnsL8Eb9CGreexrQo424d?=
 =?us-ascii?Q?7T4GFiFi+pXVsed8Ux8IPS8vWCdbtqRHzpGH6kdMjM3Pr0q9zxCIigkCW8rI?=
 =?us-ascii?Q?DXqtUOFC6qae7tQamm5w9z5HcKGeuu7pWsQ9m5fWYannz3pxwJvBNoDYOhwU?=
 =?us-ascii?Q?+LghMLBXnUiSkzZP36DJJZY7ClzftZJXULWZrOMpju8zF16pe3Qd925sqWBq?=
 =?us-ascii?Q?eXYZpvZaw3el2behnpojkYTgvC4pFynBhB+U5G7t5XsRBg8YDa//Yic3PHY/?=
 =?us-ascii?Q?/uw2owB0NXq8X/CmIt8BkonP3PL5m38whbFhgiXDWQV5wdOAd6CU+6IiOgIm?=
 =?us-ascii?Q?JTXwfNIDVWB12WFjCEM6G4hQYpaMYkkzHDD6AK93Y28zOw0/VGJGEXWecMQQ?=
 =?us-ascii?Q?+0JNuzqPmdNp4ZakbedyCYchVBdLXGAxoyR4Qi0gTEn/Get7T8MIiqbB0MVS?=
 =?us-ascii?Q?zq5A69DZmAka+bu+b79Nl4gUYVpF97sWJXXd07Mb65lIrkvbTm03zTGnV5mI?=
 =?us-ascii?Q?8kKI08kduEf/NS35fQMPpUFxv6AlFEjiLFBqdkMe6CfrV4SCzZSBHLh7/22+?=
 =?us-ascii?Q?j/TRrpkB6FxPi2lTa4EuXrCOYuXY4qWG/HAacKBdrenJSKKJy0aqXKzNJg7p?=
 =?us-ascii?Q?XxgDLxfq2JiPYq1co+w10Prb+Q6gVmOYRYdjChyfXUjxSnLWFMAGAbzoUwKN?=
 =?us-ascii?Q?T4EHfF6B8ftw5nBS6nuGw+gQnX/U2izaVwK+h6r2/Duva1k7I+ZneNOpgcJj?=
 =?us-ascii?Q?CtdoPIbeHfakZC/IFtRJnSfif9Kks5YxsruBRwuuude4nMrJq5Q/LF+y1rk5?=
 =?us-ascii?Q?fr7U+fddWgJrljM3nhfvTXjKvAdk+C6K9bevzm7Cr3Zo4Ie6Su5loGSWIIDb?=
 =?us-ascii?Q?Wb3slAPOil8aZ/yzJX3Ns7Qm1J1CS2g6yAFeovDtRC5A9dDLGMJYJ3inpmRt?=
 =?us-ascii?Q?NPMN8q01a/4UWzuSrweLTSMs7Fu1uDbhN9gmTEbw84Ok4DQS+LedobNmg9+Y?=
 =?us-ascii?Q?qHfteTrugefItL4w1+zUopWwzb8pU4JO9o/Jp4Y3J9FxHJV3pQ8DUa3EOl+x?=
 =?us-ascii?Q?+Ko0GYCUxtM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VE/0hJzMHzVkj+JxXYiz2UjMQUbOD563c/Vw0XiFeK4eb2WI/4Q5k0A2Rb9L?=
 =?us-ascii?Q?GL/qMHMAiRggYIFBOo4E9hTm7EFttgX7UxVpakOpeVZmIyYHZYoWQqZ7P3VV?=
 =?us-ascii?Q?4RBFxW4DrLYgjXNnPgyuEkOICd1e9w4+8LWoMromtDr/2/v8R7oH/t8qpwqT?=
 =?us-ascii?Q?NGgDJMGDvJ4El4VpSOyM/I3BV58wbP8csI8KCuoOIJsKvJDvDFYPvZycTmIO?=
 =?us-ascii?Q?CprKetSWewcNsCeuGA1xbagzUzLpzfotZulMVG9fDmJWJxwTzZpZPB8vK+Db?=
 =?us-ascii?Q?XpcLsJl8+MmFGC1CrrfLuDzjdDEOHZJKgxRyIp1uOi5N9OnOM5jWRWPCqCeM?=
 =?us-ascii?Q?QjPT/TGVcU44Zef9bdoHFvA7m6AFmwBajWVJVgyTRX6N/bJQhW0FV3Ho4JDj?=
 =?us-ascii?Q?NoCpI85tvTjHZvGI4iCXHhxX+wbiGrKtsj8DD0ZsfUO03LJUOk6VK6ZlX6sx?=
 =?us-ascii?Q?knNEH6Y0Q+7Toy7Eiz657IZ0N+ys1jy0rBVlHknTYutKbDgWQlTpznCFYU2v?=
 =?us-ascii?Q?F+xVViG+Gq/3Bsb8/GECcgkwSf6q5zdn3Iq9q+UdPe/BVSNHEbGGTEdmjNFL?=
 =?us-ascii?Q?cgOeaxybPBaM3T1rgaRVIDg+3LtQrT2rbFmF6WbYAMYOl/x1PjQYHGkUfHZP?=
 =?us-ascii?Q?BJveA7MVIBkVTdNfB9aqsHUhg+tCrkBj3YP2nmMEqFyphVB/qIrgRWV9Fw6l?=
 =?us-ascii?Q?BNMk+rFsRVC2bryOWCcWQjKV75SFrRo8NCEKGnmah6DA27SH6m0LXXdn8Lms?=
 =?us-ascii?Q?TvWT5yJzKTCiAJ2r/tGt53r2olwUR+JmTDjb5PKOaEUv2rXi+soYfSedwm7F?=
 =?us-ascii?Q?NwuPjeeG4xnYPqmNqTqIX5ujjQ4UzO6yyj5KKJgmnW2uwK4job1Qh663H6GS?=
 =?us-ascii?Q?FOkhqs46BsczAW7oqXk/HBEbfmpUqkaHWZLz3Q8o5+4OkQ9u7pzqJNgzpXX9?=
 =?us-ascii?Q?a0RZ6EiNmfJfVc5Yh1jlS44Ufu7LoBXnSl/Xa5RPlV82fsiAgXWFz8LSPRo/?=
 =?us-ascii?Q?icu72i3a+yyH6a9uFngcIbcXM0wKkfzBDV4I4Onn6jOFlnuFXeyTeEW0Akya?=
 =?us-ascii?Q?RoiyGG/5d5k2LLi1oG4ab5h/Co4HewZR6pflABrPZr8c9LWE1AjhiqC5k7UP?=
 =?us-ascii?Q?FvedenQ7IV8DGSJdKutnNJMm/O19YYmtBq7VFYncHBmAczLzDpLes/4OvfPd?=
 =?us-ascii?Q?tXTq01XZoiTgqf5d9TyyWZ094YYSiMIawd4YMyR6DdTUdwvht+Jw12bnYuxt?=
 =?us-ascii?Q?1dzhUR1/OzDp6LEBhJv5CSz+9Y1G9lCcgw4t2fCDF8JA8+T4sypfhk1IspZX?=
 =?us-ascii?Q?yZdd9WNNxR+msOwd3OxeY+bc0zhl9NIdaO7BttCzD+QqzYD1C0jFk6O8pRUf?=
 =?us-ascii?Q?RpSGzjQG75FIoGPehZ3zqAMRu8UUeWWnICnGJN0bW1Xe9Ljcysvza1wroEfw?=
 =?us-ascii?Q?eUABBJ/6mNPlq8vrJCBSwAgMS3dXe4YT5Eww+n/8ItCIErqFhn6cQb4OVNBc?=
 =?us-ascii?Q?QMs+mXo2Nsb8gSXpkW/tD/9prPuiCqFBwUBf/OmZkxnlJOsaORAXXQDvqE96?=
 =?us-ascii?Q?EdWC26rr1OvcH+3uON911MFAR6IHoT4fgIAIqCO0RkGTqIuOB20c3qRy+CzH?=
 =?us-ascii?Q?AKkQhEFq7FG9hYmWJsAtW5A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca3794b-453e-4d36-96ec-08dd8289f9f6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 17:12:07.3989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTmxaGicSgyigwnYFYOJntsoGZltt/WZ/u31o1GTssS57t9PoSbT1j+L2BCabmM9DlUWmnVroI8CX+TcfOo/HodNtr+bPctv+ooOMM2DX+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
X-OriginatorOrg: intel.com

The _safe variant used here gets the next element before running the callback,
avoiding the endless loop condition.

Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
---
 kernel/bpf/hashtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 5a5adc66b8e2..92b606d60020 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2189,7 +2189,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
 		b = &htab->buckets[i];
 		rcu_read_lock();
 		head = &b->head;
-		hlist_nulls_for_each_entry_rcu(elem, n, head, hash_node) {
+		hlist_nulls_for_each_entry_safe(elem, n, head, hash_node) {
 			key = elem->key;
 			if (is_percpu) {
 				/* current cpu value for percpu map */
--
2.49.0

