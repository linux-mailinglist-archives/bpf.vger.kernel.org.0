Return-Path: <bpf+bounces-56612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D883A9B268
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 17:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47BA37AA237
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 15:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE581ACEBB;
	Thu, 24 Apr 2025 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q4z6v7Lm"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD811A2381
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508782; cv=fail; b=qt0zbgvnpESOUXlwpGkFNq/ErVosDzGg0voZ11DZeHCgKoWXxr5JtKpIBrycevLqNPBswds5ZdCPqH3Ac0mVMa/SihxwW/mc2kzpO3ywceg7rTEijmyJSRcgRJObuDKODXE7D5n5P/DuNH89g3eMj+WK/B53FsO8GOj63J1krJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508782; c=relaxed/simple;
	bh=GuHbYv4LnJMqv/G/E4CfdQNJ9/TP8hv29g1PuX8TsBQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=P3ODhfmOA4Z6DPosLWyCIHm9OuTCMizKbUizsL6PuYxx99gbeWEDJ62kECHtb1WGc0FIt9WqY8cK90gvolUD12pPymDmS+8ev03KqNIJXp3p7ctEczLYizmLzwLchqMaIGSQvZmyL5cJQveEbSLeCYpQlwzEhQ42oGMskZNpJWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q4z6v7Lm; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745508781; x=1777044781;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GuHbYv4LnJMqv/G/E4CfdQNJ9/TP8hv29g1PuX8TsBQ=;
  b=Q4z6v7LmwzGawFDxs8PsCFHiFyB8AmSadHY1xRF6Zgj5I1SW8AK1Edhl
   2uxhnELS2DRWNOg4qwykFU0xnVrPeRzMA6OzCngDDpBFCINWe6NQ8qkYF
   ihCvwbx4b9TKmYZ10jrRoWggjvHh8R/SSv93q3sxcvDvmAsQvqG0FzHMS
   7twXJPV3/zGV7xpLoDb7rbibB9yfUbvEGQDWHmhDTdGX5qOBr3uJqJu5d
   A4htKCFQ6FPdu5yE2DnpDibu2UFT/a3nI2bwsar/tFUmNxPphXSG+Pzoq
   0aCry2wo0SxWdviA9D+aPIQbGqco3Z1/xy8W6qeq5Y3lJFLSZ4MQ3M/DU
   Q==;
X-CSE-ConnectionGUID: g2cGRAzETk2aHG21IqXXCg==
X-CSE-MsgGUID: BYiUAzpWRp2wWpo+0DTPFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="34773063"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="34773063"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:32:59 -0700
X-CSE-ConnectionGUID: gcVu+qyhQ02gWWPxzk7s1A==
X-CSE-MsgGUID: qp/5vlJQQf+NhXreTlam6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="133611556"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:33:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:32:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 08:32:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 08:32:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3PveA19nTsD8pXo6XHrb+6pi5MuMsP2/5ANbie9mTiG5zRyVlfOazpIqUK5DckyP9qnt+E9QU3t5wbtwuUIJ39DHe7zwTB0o6u6ASajPdxuxbc1bpFDNrLnNx9I7Zh8uKC3dqEwjpfLKbHjvJZhQq/Hs3PeeqLyPhb9zSstWWtO7nrd4BmKBfVRu0qR82HxCk7PySeRY+VxZoQl19lAHGPIXjvuipLUr8M8ATVcjHjr9JMW4mhWv83DIHDsvegEG15bdt7C88xhWl9J/LYKA6MLL0R1cAAZUZsTDf092sQyTU0zSYbnaVlMNFC9v5DkEBJxSr93cy6rLYWMG9WA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLVytqRuAebT+7W1InNrclHES3fRkf8QNqT0ZDQ2624=;
 b=vNVadq1E1NbGyWEoHkOgoQ7htStzBWPWUlicsj3T/lfKnp+h3gQU6IrxTa+Hkczau1Q8ONhNd6IWEwW57I0R4nASY/glDr3k0eAuQvRqISqqU6LxtS3tFdG15EfbcV/xZkZY39grcVSPBhUtO422XLmmL49q7uoREIDTLWLUw2Y6fWpyr/kvwqTqX1PvJmNBEZpIzroBgchyWF9TyC6/F8sdR/fKpggrIkwzdbeCWrGWHL1QE2vbxQNh9xVgjNpTkvyI8mOdAZ863gBhRasJYGkBAU2m9jhEMz8a8JroiQrun4MN5CF/v+76E1oP2U0asJnIhgrEUwJPudYl77Ld2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB7050.namprd11.prod.outlook.com (2603:10b6:510:20d::15)
 by MW6PR11MB8438.namprd11.prod.outlook.com (2603:10b6:303:241::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 15:32:50 +0000
Received: from PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582]) by PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582%7]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 15:32:50 +0000
Date: Thu, 24 Apr 2025 11:32:48 -0400
From: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
To: <bpf@vger.kernel.org>
CC: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
Subject: [PATCH v3 bpf 0/2] bpf: Fix softlock condition in BPF hashmap
 interation
Message-ID: <20250424153246.141677-1-brandon.kammerdiener@intel.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: BYAPR11CA0086.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::27) To PH7PR11MB7050.namprd11.prod.outlook.com
 (2603:10b6:510:20d::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7050:EE_|MW6PR11MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: f9491871-7021-4107-5cd7-08dd834545b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u4PuZaOR1+WYU8/mXMQqnw+fl11Npu/M20stL+kZ1/uQyNvB+60asq7xZ9Zb?=
 =?us-ascii?Q?O2rW/8O5OiyLBwyNtMx3pb+W3tDN0QGxszMAIbkv19gRRsbfl6mvo4HHrunr?=
 =?us-ascii?Q?vyyrIMi2inACF9hjAcCkjf9DljhXTfejLEjAmaaZhPuhsWJBo2UkBzlZu5Ql?=
 =?us-ascii?Q?KcnOzsaG7KYc1dZM6B9Ulnxi2m76uSD+sDmBx6yCiAdiLg+fSo5/fBSZRBVm?=
 =?us-ascii?Q?yFLNJWTi6zlYBXWOpYPKpOuN3oGfuLbF6EkzwznShs50AkMUTI7VmIckYANX?=
 =?us-ascii?Q?DjRMqT4SmlX5bO8J6akKfs4ADyo7vcYUMtBKiKCk7DEP+5wXJFErpwdYweWB?=
 =?us-ascii?Q?LSeyOvZbm34+gugHVujyQwyP/RfS7o6UsIiT5+e4TKdVOsrf+fxmN1QUY0EF?=
 =?us-ascii?Q?hYaKtH1Q4V9/5KJlAt1rR040Rv3h+Q33PZRHzQoiFW0W2uz44QypOCDNLzwE?=
 =?us-ascii?Q?2pWYY+KMXc06AosrOLasBgpJUUY1SsCMUdjCPM/8z+P0ctVdM6l//KM5ezj8?=
 =?us-ascii?Q?ynHgOKbea99p8bO3ounNiEKxqZvkjhvf3/ahia/8xpouANnJDH/uarM4SrY0?=
 =?us-ascii?Q?MHwoJ8blPlHxtmvWLbyropn0PGM/HekIdIZrXCOvu+fbGtcHkQGAWJIuAPE7?=
 =?us-ascii?Q?//OVhl1tHhn12TtDZ7s8Fd40RmeZ9W8DubpG6JMYsFZDLjwi30ynteafFlov?=
 =?us-ascii?Q?yGPjfHD4XW8cQ9cxp40fjK4IX65HKPeC5YMTUTQ1KvVNP/dKETKQhcxFns/j?=
 =?us-ascii?Q?ogomc5QmDR3r75PhBX46Xb7HkZVlh5OpImIM4dsuvqRnpekQElXMoxGKNLFj?=
 =?us-ascii?Q?uCFnkf/pbdDZCn1cAG+pXbSE6Hsm0rqXVpr3fNhjXexsvKNuG+PLQL/4LI5V?=
 =?us-ascii?Q?SOfF2qtY7yvgoIhjwVIKpZMQGtQx3VKGH5XULsoPcoPcl65LRg3PqXTck/7c?=
 =?us-ascii?Q?cFYE175A/elh6E0nIvdcZ6HmLicuTKLVNQtveGtmyQs87Ab+doza+YxDLql4?=
 =?us-ascii?Q?K1vXtTw4MRfFNaKfkOGR3622HxNkYeTErvLu5yNhp1SDIihiSvWl/guXbB1X?=
 =?us-ascii?Q?14QxGOwxflD2kHI9OTshwSVOv2hhOtqmtli0QurRL13NDhLJBWJPBdY3jfld?=
 =?us-ascii?Q?e2sbtpIq3sphtrhOnw4yP7FazSQXBvFSi9mg2Tge1ETd9gy6Ve9yjzHoKfDC?=
 =?us-ascii?Q?ZKeix/Ypr/ZTtHuKHaFKVPEQqEbJoHoxn7Pd1TXr/BaSi3PCCNwZVhk3T5C5?=
 =?us-ascii?Q?vwyt7I+KnQDBRerThiXwV+kbUTQvr1t4j9VtrQ1p6i6sz+l+/S6SdrgjwOl9?=
 =?us-ascii?Q?uGHfCajbHhYW+b3yMgdd+S3uc/TIbdDTQxocHmZIqwrcGqtjRzJ+xOhe82Z/?=
 =?us-ascii?Q?vWQ9m/ehmFL3RGwAgLukrDlDcAjjI50kzIQdqsHV7o382X5lfjKalesl37PR?=
 =?us-ascii?Q?WDmJpeMWLUQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W/VgMF4kCl6w7IpbEoVFZyKw7r/0eFnbG9Grj9X7mySp+nWb5URDYmkiYDnR?=
 =?us-ascii?Q?6GfcWPf052kOUxvYgbMCZB962w50mH4kLNekIm/tMVyUpe+h/ErtnJUBCX8F?=
 =?us-ascii?Q?4OBmemLXjq9Ra4ZQiA2/+/YzzyHi3svQ5+twJGjH+6zvTo35bC3B7vpctY25?=
 =?us-ascii?Q?FCOYY+/hs7z7ij7T3/o2gWBMIfvF4qgZHwysnL06Ll8lOcklqkOeIaMBcroW?=
 =?us-ascii?Q?qMK/eTBTy5K0C8/tmY4PQydfdz73YthKAQABML/WF9TGcol+JhYhxWv/l2pv?=
 =?us-ascii?Q?zqxa4nq22XIVva0daio705N8pi0V+vp8rG+xh54dl9X8dtc88FJajrPrk6Ax?=
 =?us-ascii?Q?ozZn8ivs3CK/dK5a1s6dzurRUx93rMcnyN6pA8v+UzrvL6gTJNg9Gu9m6Z96?=
 =?us-ascii?Q?qKbkaSIJt9Kt0FSJcoBNqKGerFNN2d1Xgo51zpDYGLcptQskQ5K3BybXCyat?=
 =?us-ascii?Q?tLkhX1tbcFO0L0qYqnmWYLUkhC6cGq8Qj0isHq5Ab24PrDmfIAMqSXUv+p6S?=
 =?us-ascii?Q?Cne+AyTr59gkRV73lfTfPN30dtRU/HuhqAjCN49ILjRrsFYCI+l+35PDoNF9?=
 =?us-ascii?Q?tTZ16HDxKn5+kMtVFdYfHxoYne8W7WTgHqFMcnBGwUvex+0qaEgw2ZfgOfVY?=
 =?us-ascii?Q?InPCmiZmkWjpHuIfYZse9+3XDqLpz2cs2DSeA5yLqp8UqDJvA3sfuuTv0dps?=
 =?us-ascii?Q?d7rdSujUdG9d7RScD2KQn7rz+DAZq2hpD3fT8Z7euO/E3ajXRxrv7YPp5V12?=
 =?us-ascii?Q?GHnNO/l1kWcsDGLqUrBy7cmO6n/E+egmNYZq9DTuSuW4ymvk2v0KAW6sVG0E?=
 =?us-ascii?Q?od5rUa+Q4PehFG1haqsV5o4YFkbJfEIe6985+UqCguV8qXTGc7WVbTdloS+M?=
 =?us-ascii?Q?h9VoY8cDJpWfNsionMxsT104AwPgFB6qZOuPQMmowkQ/yr4XbMAaLz4kknkf?=
 =?us-ascii?Q?32TU1wd7kCPVFhH2iFBlK97TzClV35D6u+L2tA3B4sfBJJd4eqYrLeq+IS7V?=
 =?us-ascii?Q?ccQI5G86/O4Xh7tSp8X1wluWfVmfSQq2J2/dyjZEDhSxgxR4qQJL+CeLbCK6?=
 =?us-ascii?Q?mq51jfHuyLVQ2ppCfcLeF86ry0kDF4ZR5OlTWBlLpBoE1JGdo0nYGRj/eWy5?=
 =?us-ascii?Q?xBt76t1h2LkVxSqJJB3137bLsRARcFZhxQkLS7g8VYQrBfuwO4dR056CIL06?=
 =?us-ascii?Q?27NfenbyAoEHYKCNxfcgEel8haJnve/uG3y35K5wmL2OyatWn2VsfzY4AWyr?=
 =?us-ascii?Q?ASnKTdWfOfqGsm7wqxJw0JuA9W9QlR8OneXaVYRPHiHxcEjRE3JWZ80YjDai?=
 =?us-ascii?Q?teYf80FYNC+t31auAQ8FgkZeGG/HmaoVCAYkN4xEk5OPgMMXrtHn67TPUoJX?=
 =?us-ascii?Q?H93XYF4tU5oLvlFDzptq/FVbRrIhmfmnRG/ya4NXVLpyqJovlGF2AJtjIsDF?=
 =?us-ascii?Q?YobTK4gsbVdF+FjsoooIoCkB6WJLQBo5Qdu4CEPfAN4r4OneaT3eDrqzrrUq?=
 =?us-ascii?Q?GKbwRRhRkR0bsKKCSRbNf47qCoT1gKluDlOj2rcFHUTRBeN1seZSYrjGzjL5?=
 =?us-ascii?Q?mfV0QoLW3mFkaCLTHMIsJqJLnmT59YgBZTr8kz7xqiYQDgp8wDdwveVNi7vq?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9491871-7021-4107-5cd7-08dd834545b1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:32:50.5010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvy7O0nh3U0iMmGnhLkQ5l3SrTNu+VycxnT6i3gijbeHpjeSU9cLHMgh8rqnrKX3QRfOk3Kxg78Jowku2GK5BAzpwPtzTmqC5v/an84fvcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8438
X-OriginatorOrg: intel.com

Hi,

This patchset fixes an endless loop condition that can occur in
bpf_for_each_hash_elem, causing the core to softlock. My understanding is
that a combination of RCU list deletion and insertion introduces the new
element after the iteration cursor and that there is a chance that an RCU
reader may in fact use this new element in iteration. The patch uses a
_safe variant of the macro which gets the next element to iterate before
executing the loop body for the current element.

I have also added a subtest in the for_each selftest that can trigger this
condition without the fix.

Changes since v2:
- Renaming and additional checks in selftests/bpf/prog_tests/for_each.c

Changes since v1:
- Added missing Signed-off-by lines to both patches

Thanks,
Brandon Kammerdiener

Brandon Kammerdiener (2):
  bpf: fix possible endless loop in BPF map iteration
  selftests/bpf: add test for softlock when modifying hashmap while
    iterating

 kernel/bpf/hashtab.c                          |  2 +-
 .../selftests/bpf/prog_tests/for_each.c       | 37 +++++++++++++++++++
 .../bpf/progs/for_each_hash_modify.c          | 30 +++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_hash_modify.c

--
2.49.0

