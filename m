Return-Path: <bpf+bounces-59637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDE5ACE097
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 16:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B99163497
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 14:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046CC290D9D;
	Wed,  4 Jun 2025 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mSMVQqAA"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82691290BCD;
	Wed,  4 Jun 2025 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749048159; cv=fail; b=Hxbmxa5P9zq0YuJGlxeSIK7o4m4WplEbmmXrMoJZWsf3Ig2oBB7wK3sIFYhauSWAe/tO1VklA/YknrdhFy0557Q9mBfkBnoj9f5KSvAPy1UM7ArK+Xg/sHVg+aqEz+fiNJRzCrjJuHzsAfFnWBAnQs8yubiyeC4Ot/a/5A7ASrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749048159; c=relaxed/simple;
	bh=DVd4OliV8Icjn2vBLj7yX0y6fixsduWRVBJo3msmIHc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mSh0kTVCK6l3BWD9JYqXEpmgsd5fZ415G0sXD4EvRhvc6Oxj7iyTk1HEpx1NLOPh4buvE3+OUipdWirIuLnnf/Vmv88mmccZ1cKN9WBZsYwswvBzw8EREXSojO5bZuHVNw0CfPGguzhcOMrevg5M+uzLC7zq+59ews7FjZYnS2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mSMVQqAA; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749048155; x=1780584155;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=DVd4OliV8Icjn2vBLj7yX0y6fixsduWRVBJo3msmIHc=;
  b=mSMVQqAAerZUQoCMraPShtAbiuFALZnB4sYnKkbyFUxTF3Vo2b+csbNT
   r/BjyxXIYSxS+W4bY3kH4xkk/05/7l/VBD6NtCGEK2byDkaF9oFeDFaXY
   FfN+VkHYf9ToxwIa+7/eAvV1ngcgzcPAsv7TVd7TpF3orzRlsVsxYXvYV
   tSDKVX75PhtgnqmLCD+Ss2yXGZDU4xMirbdumHflLUKg7xyIpwka67Yhs
   MZxy3/QRFRVhCAcvnBIGzss+yj+z0NCwYd5g6g8E3aODeJfqC3mBi69ET
   U0SsgATeAGAo4RSkZHElCbHPGy53CWpnbA2idVJ5vLN45rELS604BVdkI
   g==;
X-CSE-ConnectionGUID: EE2fbTa5TR21YM5CgMzdGg==
X-CSE-MsgGUID: bouT34rWQZWCSHqQMvbfHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="53762242"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="53762242"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 07:42:23 -0700
X-CSE-ConnectionGUID: 1l6bGdi6SySVyKd1Kbo19A==
X-CSE-MsgGUID: hABtaQhjS+CdFlFoCfIjpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="146183602"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 07:42:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 07:42:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 07:42:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.58)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 07:42:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEgScpYgdfdw/oj6v5zFHS3nohkRR03l1OE//4Y5D+fI8EKwi8Y7wp5vRStr6A2MPo6VcyYnQJEY3vcfEGdRKB738MpotnOlFnYCx8lmwNNJWlDXOskij8dDs2SRYcWqh7GhBmmbhAp9imV98YjmyAgPvLaMfURrUCysF+g8tY/69Kqf+/U6kCpjFkHUFXQSMeEhWH0YkRxp8Ulplmcnwq3gZZnrAyjbDeKFBHFfk1iwoRFHEQKMuG5I1HhdlIEh8b03sZ4CSXkNLk3AB8H2mEm1QQiG9Y7rSAp8AeGwzKenNXxyiytqkJ0qMo/hwtEmupFCthRKujkA36uXHqgWpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0SbjCu+4uuzawsrwss/eJ+ZGvrtiNmuPzx7r8CO62U=;
 b=nFDx8xmllOQzJkcZXOk1kSKt4V5j/EogbDUtlNc9HI9MSE5/9ZaCOB3VhcDskrMdrO/fS1zfqrUv+zXpupj+hASADTNAqHkatRaQpiqkKasL3dli5YNEeeVteZVd9IQihO/nCZQpd+MJQUp2meWEV+khHRd0bLI8kJ5yGV8FK7kui93a4HfBhi3ULC3y45Xa3XPSapnUvOJVmzHlb/mTtMqFaEIYP5ZxE2E43Ne3JcKCEzpJJKn7ELdq8X9K7cUeP5N1agM22FT/Oj6Ruh6SgN1eKpme62HvzP9iejLzqo/XKgYkUSI0IapkmVnwb/eg8W3JSsyIudg3G/4HKy0WmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7681.namprd11.prod.outlook.com (2603:10b6:8:f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 14:42:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 14:42:02 +0000
Date: Wed, 4 Jun 2025 22:41:48 +0800
From: kernel test robot <oliver.sang@intel.com>
To: e.kubanski <e.kubanski@partner.samsung.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <maciej.fijalkowski@intel.com>,
	<jonathan.lemon@gmail.com>, e.kubanski <e.kubanski@partner.samsung.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH bpf v2] xsk: Fix out of order segment free in
 __xsk_generic_xmit()
Message-ID: <202506042255.a3161554-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250530103456.53564-1-e.kubanski@partner.samsung.com>
X-ClientProxiedBy: KU2P306CA0040.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3c::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a7f14a9-8a73-4bd6-2c2f-08dda375f7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?/fE7gPQQ7r6937aI32ekv/NFOs4qFbFBQ5CJ1iZkGQQgySWfKZw5FEm7mQ?=
 =?iso-8859-1?Q?s/bhZiQurx+5+gLAQoJgNrE0vo8UQtyFb9PTlOpcYlMudNGmnu/ynqYHBV?=
 =?iso-8859-1?Q?GmhU5NBly2EJy88ccYHsGHZcengguVDeDn8icnYZZQHuIMAKDr5HfhTty9?=
 =?iso-8859-1?Q?m60zVH8On1G52MP6nK7JekRsHAtVjAghjlj5E4hJLY3cUTB6F5xhzu1yJ0?=
 =?iso-8859-1?Q?TE+lCsXT8sGyk32xFVIJX3rxjF0b+uZV++hFml+111EqaV4Q7U3/KnWQtu?=
 =?iso-8859-1?Q?JwTmS4ilMDRIdVi9F33aAij7691oP+ndorzERyEgdm4vvpLx1PS3cToxcw?=
 =?iso-8859-1?Q?cVMbPoAjavIeudZcbvbv/sutmzFKAGPfIxrk56xXjD4zAmtmGIjBCxo50P?=
 =?iso-8859-1?Q?pM2dtwUKkJ/qiU8lZYg5XOORfPLF77hp9FfNJfZfZE6b8aakqDb/eVUSDZ?=
 =?iso-8859-1?Q?R91YbNGKErR4hlINkEWkVoke7QDxtk4OgDs59kpoIBcAKmRLwMX8LBh1G0?=
 =?iso-8859-1?Q?ljOTJedn+2VARow7uWUUtZ+wsm9n1REv/Q5ZsmyMU9rcrFiqYVcNBExaUx?=
 =?iso-8859-1?Q?uJ5aSegQGn05GR8ZOuh4t2iX9iKtjGEykjaDM+KAXVC2w6CGl4qoAMsBSc?=
 =?iso-8859-1?Q?+QqhAY/fXrfb4MKQIvqbBizZpSRLXLCTXYgX36KD/2WyK91WEUuBiQSK2O?=
 =?iso-8859-1?Q?MvXTqqvxrDOGna/2J5y/BqYWkKsv4+ssXZU35L7LtIub6mgXVxQhWZpKP6?=
 =?iso-8859-1?Q?WC7eKstXlXRU3rxaq2EOnphJcGRjQDFolYSI13U8CJQSrNkLrNq6YbhjFm?=
 =?iso-8859-1?Q?gNMJFH6TqOGm3dzAib0yX8tzI9fEJia5CQDltzSVs3Uahw5fc+DmlEkY0I?=
 =?iso-8859-1?Q?z7mpnv+ziZAjNyDN+qX92dVgdF5sGoVXn2/KA8TR7pdjO4bFSbyoejoGtz?=
 =?iso-8859-1?Q?1caYRnWKvsIQx5FciMMJWwW+2Ixx8sOALZ8G9J/z2FZ9Kiup2vntACeKhn?=
 =?iso-8859-1?Q?r1dNmpfPcj5QjvLoifxVbUfV7FEaYSMzB4U2+wdtIoQFcfeYMYFMgKz18a?=
 =?iso-8859-1?Q?nF5PRdFUu7soezpSxbVVLZeK9YezCpf4HcVs+4yjATTjhGSundCc1lI18m?=
 =?iso-8859-1?Q?x8qLgLFNcmm49k8cbOMgYS6XxX5Q6gxLnjMtf+nJtvEPPAv7FNT+XJxQ2c?=
 =?iso-8859-1?Q?LfsMndpl2L1SyERMD6tQCKsMviIZqfptQC2cjD/2GEeY+Vcyy0fDsC0kDc?=
 =?iso-8859-1?Q?pezcuSErJAw6OfsELwhsx/g00NaSzedqUK+JdxAW0PxA0NDHMTaPcotp1y?=
 =?iso-8859-1?Q?zXiSBSm3aRrPEzLnva6f2t4LtDizTwpolgZqrsINjQQbTcGd+PpYvk/iU+?=
 =?iso-8859-1?Q?K1mM9DPj9mr651MTXqbE/8eFMJi8y03u9rTuESfZiM9U2fGIG0fJmADILS?=
 =?iso-8859-1?Q?2pKRGubBDWYsvm2j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?O2cHOXugRbW9lLYVvQfsfIzQu27nD7sOOSAOM5MKf2GQb+tHiPW7IumP3P?=
 =?iso-8859-1?Q?j6xhbjwrK+W19PE5OBKS7bS85ehP+b5URkc0kmCCjn0WtS/F+W7xZomcSM?=
 =?iso-8859-1?Q?4NqGRRnyehB8xgDzLQ8r2sb5qHpF+xBQeiFNSaBm2Ve1kAnSUTp44yWU1W?=
 =?iso-8859-1?Q?80H2R5gLE6cPT0Fuh6FBJUs9sv3iShBeVHO+/0dVzylull7G9d0pWZ90jr?=
 =?iso-8859-1?Q?FgvuJqoo86zepeEs75YnJO+K/WA2BqwYG+rjTHcb2ykZJU2Z+yw/y4QiGK?=
 =?iso-8859-1?Q?0iXXPFGwWjQ4gpe3spJOI552ASjD11p5UiToao1CONtflFCZjpb/DBHflf?=
 =?iso-8859-1?Q?NCqjhqu8xtIIkj7oZ1rBzxfOWyBWYxCwfB/jykjTkRk9VjB6oEiX03I6qp?=
 =?iso-8859-1?Q?iwsxqeZ4wyBi2RLk3wx4D7Vv8B4XUeYDboSd07TKyLjLppdCh0ksbj0hnz?=
 =?iso-8859-1?Q?wDtN4FNRV8kM62iHUkrE95wxrsJj3xznElKukjxLyl5BRjc1nfu2EUXUvU?=
 =?iso-8859-1?Q?Zm9MFjaZKQ8+JpgAvwaz9D+9Zgy/DI8dPbIG7sIyi5ap+WlbXgDtvvkbuK?=
 =?iso-8859-1?Q?ATdr6MNQgsDYAX4M3Z7zVR5UEixiTJq23J417vU6ku6HFKM1IE4IBMgL+V?=
 =?iso-8859-1?Q?aGkEjvWodOTNz970qy4X6556dMVzT2EA8P9Q6sWUQN+mwW8G2afgNDd0eI?=
 =?iso-8859-1?Q?xKX43XSzruUDsiBd6eBMse0NrIFrIjVSSHrMrTsyxnpBaC/1xkQJn1J9Aw?=
 =?iso-8859-1?Q?UuI+z+EceNNzO030c4elw7TvIH5FVgFdjtVoeF63DYHOUkmCGVVeGmlRgo?=
 =?iso-8859-1?Q?4OkeW9c0nrtlMzWYAGMt8EJWt456/mtjJ124BVPAi9J3b/8y/dyflNO2tm?=
 =?iso-8859-1?Q?Ra/C1oMP1qy4sJhEfwzMTA7g6xF8cE8xZtbvMTbqXVWWKbfSnD61O/mQJ5?=
 =?iso-8859-1?Q?T+2yFF8XGy1Ui8jZlE70oz1LHajI2CX0kayz0m/QyJ8h9w4vq/2gGUmfj5?=
 =?iso-8859-1?Q?jKA9ex/ZjttDPAXw/GVirVN48xSdlgcI9j8DQFafQOH0qDN0n620VKXtLk?=
 =?iso-8859-1?Q?iXgx1Z/oc3Q3VSHmVFBAo/BIUox/IEIwoF7KISmpx2yUPLCmroFFvTOztd?=
 =?iso-8859-1?Q?fyDdQwCOHmp6Lcte0MmE3A536T5XZStrcvSDQ/jGL7jQVQiqajxMpQP4mo?=
 =?iso-8859-1?Q?u7vILr+pfGCqTXK3wzyMLCP7XZ19Sq/zhia45ZUSJPn1A8kY5Th743jytO?=
 =?iso-8859-1?Q?A94XfAYy5R5AFv1QtOzgvCGrn45SJqzc4oqXnUUfKyB9GFzK+Fywbh6uhJ?=
 =?iso-8859-1?Q?FpFFyasomJZndAyLc1T76ZNFLIYXwwmFsIyLt4/4Pm5EmGxAG0F7+vsoQ3?=
 =?iso-8859-1?Q?6UHAQYtTMHLbFN0elfCDjQvBCNbZO+9TcExbUVPcVbAVlXNGiG3XTGBztT?=
 =?iso-8859-1?Q?4Id2b8Q/Flyd3yR3S0yA/0z1Q/ge1sBU/dyXvJ0pnX+qpfQJ7Rr43DKpOs?=
 =?iso-8859-1?Q?U+T1nZ0dTzZciAP52r74bOr+/8j99HaKe4nu90dbnNe3Kzs70FVFed5YiM?=
 =?iso-8859-1?Q?jKf0G547+T2p7sD1Up3hF1mJEv3JC94x08KaaLZ9woU74y3p7GTxZGOmqx?=
 =?iso-8859-1?Q?JNyK4+txxzCsBIItVdv6xN3zWLez4mddD1xdBAgBfzziVOF4mteUfOjw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7f14a9-8a73-4bd6-2c2f-08dda375f7da
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 14:42:02.7815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCt2Rh1nEx3RABOku75kSLdihoKSWgO7+z9Z2emh8bf7jggLAgV5D+H5mgzVa3AftpzgfhILkTMApCnjeInD3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7681
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 16.6% regression of hackbench.throughput on:


commit: 2adc2445a5ae93efed1e2e6646a37a3afff8c0e9 ("[PATCH bpf v2] xsk: Fix out of order segment free in __xsk_generic_xmit()")
url: https://github.com/intel-lab-lkp/linux/commits/e-kubanski/xsk-Fix-out-of-order-segment-free-in-__xsk_generic_xmit/20250530-183723
base: https://git.kernel.org/cgit/linux/kernel/git/bpf/bpf.git master
patch link: https://lore.kernel.org/all/20250530103456.53564-1-e.kubanski@partner.samsung.com/
patch subject: [PATCH bpf v2] xsk: Fix out of order segment free in __xsk_generic_xmit()

testcase: hackbench
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 50%
	iterations: 4
	mode: threads
	ipc: socket
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------------------+
| testcase: change | netperf: netperf.Throughput_Mbps 93440.1% improvement                                       |
| test machine     | 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory |
| test parameters  | cluster=cs-localhost                                                                        |
|                  | cpufreq_governor=performance                                                                |
|                  | ip=ipv4                                                                                     |
|                  | nr_threads=50%                                                                              |
|                  | runtime=300s                                                                                |
|                  | test=SCTP_STREAM                                                                            |
+------------------+---------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506042255.a3161554-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250604/202506042255.a3161554-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase:
  gcc-12/performance/socket/4/x86_64-rhel-9.4/threads/50%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp2/hackbench

commit: 
  90b83efa67 ("Merge tag 'bpf-next-6.16' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next")
  2adc2445a5 ("xsk: Fix out of order segment free in __xsk_generic_xmit()")

90b83efa6701656e 2adc2445a5ae93efed1e2e6646a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      8018           -11.4%       7101        sched_debug.cpu.curr->pid.avg
    195.95           +14.6%     224.54        uptime.boot
      0.01           -16.8%       0.01        vmstat.swap.so
    764179 ±  3%      -8.2%     701708        vmstat.system.in
      2.13 ± 13%      -0.5        1.63 ±  2%  mpstat.cpu.all.idle%
      0.53            -0.1        0.44        mpstat.cpu.all.irq%
      7.09            -1.1        5.95        mpstat.cpu.all.usr%
    558.00 ±  9%     +31.5%     733.67 ± 26%  perf-c2c.DRAM.local
     23177 ±  6%     +17.3%      27181 ±  6%  perf-c2c.DRAM.remote
    161171            +3.4%     166696        perf-c2c.HITM.total
     92761            +4.0%      96435        proc-vmstat.nr_slab_reclaimable
   3143593 ±  4%      +9.5%    3442455 ±  6%  proc-vmstat.nr_unaccepted
   2154280 ±  8%     +19.0%    2563937 ± 11%  proc-vmstat.numa_interleave
   3260150 ±  6%     +63.8%    5339352 ±  6%  proc-vmstat.pgalloc_dma32
     34526 ±  3%     +30.6%      45105 ± 18%  proc-vmstat.pgrefill
   1700255          +119.7%    3735986 ±  2%  proc-vmstat.pgskip_device
    423595           -16.6%     353120        hackbench.throughput
    418312           -17.0%     347114        hackbench.throughput_avg
    423595           -16.6%     353120        hackbench.throughput_best
    408057           -17.1%     338325        hackbench.throughput_worst
    144.25           +20.3%     173.60        hackbench.time.elapsed_time
    144.25           +20.3%     173.60        hackbench.time.elapsed_time.max
 1.098e+08 ±  2%     +17.6%  1.291e+08        hackbench.time.involuntary_context_switches
     81915            +1.7%      83317        hackbench.time.minor_page_faults
     16768           +22.4%      20519        hackbench.time.system_time
 4.043e+08 ±  4%     +24.1%  5.016e+08        hackbench.time.voluntary_context_switches
 4.874e+10           -11.8%  4.301e+10        perf-stat.i.branch-instructions
      0.45            +0.1        0.54        perf-stat.i.branch-miss-rate%
  2.13e+08            +5.9%  2.255e+08        perf-stat.i.branch-misses
      7.45 ±  2%      +0.2        7.69        perf-stat.i.cache-miss-rate%
 1.501e+08 ±  4%     -16.6%  1.253e+08        perf-stat.i.cache-misses
 2.054e+09           -19.6%  1.652e+09        perf-stat.i.cache-references
      1.38           +14.9%       1.59        perf-stat.i.cpi
 3.224e+11            +1.3%  3.265e+11        perf-stat.i.cpu-cycles
    404652 ±  3%     +12.2%     454021        perf-stat.i.cpu-migrations
      2182 ±  4%     +20.8%       2635        perf-stat.i.cycles-between-cache-misses
 2.333e+11           -11.9%  2.054e+11        perf-stat.i.instructions
      0.73           -12.8%       0.63        perf-stat.i.ipc
      0.44            +0.1        0.52        perf-stat.overall.branch-miss-rate%
      7.31 ±  2%      +0.3        7.58        perf-stat.overall.cache-miss-rate%
      1.38           +15.0%       1.59        perf-stat.overall.cpi
      2151 ±  4%     +21.2%       2607        perf-stat.overall.cycles-between-cache-misses
      0.72           -13.0%       0.63        perf-stat.overall.ipc
 4.841e+10           -11.7%  4.277e+10        perf-stat.ps.branch-instructions
 2.114e+08            +6.0%  2.241e+08        perf-stat.ps.branch-misses
 1.491e+08 ±  4%     -16.5%  1.245e+08        perf-stat.ps.cache-misses
 2.039e+09           -19.5%  1.642e+09        perf-stat.ps.cache-references
 3.201e+11            +1.4%  3.246e+11        perf-stat.ps.cpu-cycles
    401515 ±  3%     +12.3%     450975        perf-stat.ps.cpu-migrations
 2.317e+11           -11.8%  2.042e+11        perf-stat.ps.instructions
 3.368e+13            +6.0%  3.569e+13        perf-stat.total.instructions
      1.64 ±205%     -98.2%       0.03 ±183%  perf-sched.sch_delay.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
     65.76 ± 92%     -73.9%      17.16 ± 93%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.76 ± 75%     -73.3%       1.54 ± 42%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    100.68 ±112%    +329.5%     432.45 ± 77%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
      3.19 ±212%     -99.0%       0.03 ±183%  perf-sched.sch_delay.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      1402 ± 35%     -62.6%     524.30 ± 93%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.57 ± 14%     -88.9%       0.62 ±223%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      4.98 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
    224.22 ± 65%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.__x64_sys_exit.x64_sys_call.do_syscall_64
    475.81 ± 41%     -89.0%      52.54 ± 81%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      5.33 ±124%    +628.1%      38.83 ± 41%  perf-sched.wait_and_delay.count.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
     12463 ± 15%     -84.9%       1881 ±223%  perf-sched.wait_and_delay.count.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     23237 ± 16%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     13.33 ±216%   +1085.0%     158.00 ± 54%  perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_read.do_syscall_64
     14.17 ± 61%    -100.0%       0.00        perf-sched.wait_and_delay.count.do_task_dead.do_exit.__x64_sys_exit.x64_sys_call.do_syscall_64
    610.67 ± 21%     -25.9%     452.67 ± 27%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     24.50 ±157%    +597.3%     170.83 ± 37%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1018 ± 33%     -88.8%     113.91 ±223%  perf-sched.wait_and_delay.max.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      1165 ± 29%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      1285 ± 70%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.__x64_sys_exit.x64_sys_call.do_syscall_64
      1.64 ±205%     -98.2%       0.03 ±183%  perf-sched.wait_time.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      7.82 ±216%     -99.1%       0.07 ± 70%  perf-sched.wait_time.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
    224.22 ± 65%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.__x64_sys_exit.x64_sys_call.do_syscall_64
    473.32 ± 42%     -90.2%      46.32 ± 78%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    100.68 ±112%    +329.5%     432.45 ± 77%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
      3.19 ±212%     -99.0%       0.03 ±183%  perf-sched.wait_time.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
    169.23 ±219%     -99.9%       0.24 ± 65%  perf-sched.wait_time.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      1285 ± 70%    -100.0%       0.00        perf-sched.wait_time.max.ms.do_task_dead.do_exit.__x64_sys_exit.x64_sys_call.do_syscall_64
      9.37 ±  2%      -3.6        5.80        perf-profile.calltrace.cycles-pp.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
      5.90 ±  4%      -2.2        3.66        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      2.45 ± 10%      -1.7        0.76        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     47.96            -1.3       46.61        perf-profile.calltrace.cycles-pp.write
      6.20            -1.2        4.99        perf-profile.calltrace.cycles-pp.sock_def_readable.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write
      4.58 ±  2%      -0.9        3.71        perf-profile.calltrace.cycles-pp.__wake_up_sync_key.sock_def_readable.unix_stream_sendmsg.sock_write_iter.vfs_write
      6.97            -0.8        6.13        perf-profile.calltrace.cycles-pp.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
      6.88            -0.8        6.04        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      6.70 ±  2%      -0.8        5.90        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg
      3.73 ±  4%      -0.7        3.04        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_sync_key.sock_def_readable.unix_stream_sendmsg.sock_write_iter
      3.60 ±  4%      -0.7        2.93        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.sock_def_readable.unix_stream_sendmsg
      3.54 ±  4%      -0.7        2.89        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.sock_def_readable
      2.89 ±  5%      -0.6        2.25        perf-profile.calltrace.cycles-pp._raw_spin_lock.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write
      3.40 ±  2%      -0.6        2.80        perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      2.62 ±  7%      -0.6        2.06 ±  4%  perf-profile.calltrace.cycles-pp.fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      2.94            -0.5        2.42        perf-profile.calltrace.cycles-pp.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write
      3.15 ±  4%      -0.5        2.67        perf-profile.calltrace.cycles-pp.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
      3.20 ±  2%      -0.5        2.72        perf-profile.calltrace.cycles-pp.skb_release_head_state.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      3.12 ±  5%      -0.5        2.65        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      3.09 ±  4%      -0.5        2.62        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg
      3.05 ±  2%      -0.4        2.60        perf-profile.calltrace.cycles-pp.unix_destruct_scm.skb_release_head_state.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      2.97 ±  2%      -0.4        2.54        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
      2.46            -0.4        2.03        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      2.44            -0.4        2.02        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
      2.84 ±  2%      -0.4        2.42        perf-profile.calltrace.cycles-pp.sock_wfree.unix_destruct_scm.skb_release_head_state.consume_skb.unix_stream_read_generic
      1.72 ±  3%      -0.4        1.32        perf-profile.calltrace.cycles-pp.skb_set_owner_w.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter.vfs_write
      1.90            -0.4        1.51        perf-profile.calltrace.cycles-pp.clear_bhb_loop.write
      1.30            -0.4        0.91        perf-profile.calltrace.cycles-pp.__slab_free.kfree.skb_release_data.consume_skb.unix_stream_read_generic
      2.28 ±  2%      -0.3        1.94        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      1.86            -0.3        1.52        perf-profile.calltrace.cycles-pp.clear_bhb_loop.read
      3.08            -0.3        2.78        perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kfree.skb_release_data.consume_skb.unix_stream_read_generic
      0.61 ±  6%      -0.3        0.33 ± 70%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule
      3.12            -0.3        2.86        perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
      1.62 ±  6%      -0.3        1.36 ±  2%  perf-profile.calltrace.cycles-pp.skb_queue_tail.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write
      1.28            -0.2        1.05        perf-profile.calltrace.cycles-pp.__check_object_size.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_write_iter.vfs_write
      2.91 ±  2%      -0.2        2.68        perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
      1.70 ±  4%      -0.2        1.47        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
      1.13            -0.2        0.92        perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      1.24            -0.2        1.04        perf-profile.calltrace.cycles-pp._copy_from_iter.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_write_iter.vfs_write
      0.98 ±  6%      -0.2        0.78 ±  8%  perf-profile.calltrace.cycles-pp.fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.20 ±  6%      -0.2        1.00        perf-profile.calltrace.cycles-pp.try_to_block_task.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      1.12 ±  6%      -0.2        0.93        perf-profile.calltrace.cycles-pp.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule.schedule
      1.16 ±  5%      -0.2        0.97        perf-profile.calltrace.cycles-pp.dequeue_task_fair.try_to_block_task.__schedule.schedule.schedule_timeout
      0.84 ±  5%      -0.2        0.66        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_sync_key.sock_def_readable.unix_stream_sendmsg.sock_write_iter
      1.42 ±  4%      -0.2        1.24        perf-profile.calltrace.cycles-pp.enqueue_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      1.35 ±  4%      -0.2        1.18        perf-profile.calltrace.cycles-pp.enqueue_task_fair.enqueue_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      0.78 ±  6%      -0.2        0.61        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_sync_key.sock_def_readable.unix_stream_sendmsg
      0.71            -0.1        0.59        perf-profile.calltrace.cycles-pp.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
      0.66 ±  2%      -0.1        0.54        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_write_iter
      2.15 ±  2%      -0.1        2.04        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      0.81 ±  4%      -0.1        0.71        perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.enqueue_task.ttwu_do_activate.try_to_wake_up
      0.93 ±  3%      -0.1        0.83        perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      0.60 ±  6%      -0.1        0.51        perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.90 ±  3%      -0.1        0.81        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule.schedule_timeout
      2.57            -0.1        2.48        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      0.70            -0.1        0.64        perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_free_hook.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg
      0.75            -0.1        0.69        perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_free_hook.kfree.skb_release_data.consume_skb
      0.58            -0.0        0.54        perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_post_alloc_hook.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags
      0.73            -0.0        0.69        perf-profile.calltrace.cycles-pp.unix_write_space.sock_wfree.unix_destruct_scm.skb_release_head_state.consume_skb
      0.78            +0.2        0.93        perf-profile.calltrace.cycles-pp.obj_cgroup_charge.__memcg_slab_post_alloc_hook.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb
     37.84            +0.6       38.45        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     36.76            +0.8       37.56        perf-profile.calltrace.cycles-pp.sock_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.40            +1.1       36.46        perf-profile.calltrace.cycles-pp.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write.do_syscall_64
     49.97            +2.0       52.00        perf-profile.calltrace.cycles-pp.read
     44.96            +2.9       47.89        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     44.66            +3.0       47.64        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     42.34            +3.4       45.72        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     40.65            +3.7       44.36        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     39.50            +3.9       43.41        perf-profile.calltrace.cycles-pp.sock_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     38.66            +4.1       42.71        perf-profile.calltrace.cycles-pp.sock_recvmsg.sock_read_iter.vfs_read.ksys_read.do_syscall_64
     38.11            +4.1       42.26        perf-profile.calltrace.cycles-pp.unix_stream_recvmsg.sock_recvmsg.sock_read_iter.vfs_read.ksys_read
     37.67            +4.2       41.89        perf-profile.calltrace.cycles-pp.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter.vfs_read
     18.28            +4.4       22.69        perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write
     15.55 ±  2%      +4.9       20.48        perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter.vfs_write
     15.24 ±  2%      +5.0       20.23        perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter
      2.08 ± 10%      +7.3        9.40 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.get_partial_node.___slab_alloc.__kmalloc_node_track_caller_noprof
      2.10 ± 10%      +7.3        9.44 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.get_partial_node.___slab_alloc.__kmalloc_node_track_caller_noprof.kmalloc_reserve
      2.36 ±  9%      +7.6        9.93 ±  2%  perf-profile.calltrace.cycles-pp.get_partial_node.___slab_alloc.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb
      7.51 ±  2%      +7.6       15.09        perf-profile.calltrace.cycles-pp.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      6.99 ±  2%      +7.7       14.64        perf-profile.calltrace.cycles-pp.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      2.89 ±  8%      +8.0       10.89 ±  2%  perf-profile.calltrace.cycles-pp.___slab_alloc.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     12.34           +10.2       22.53        perf-profile.calltrace.cycles-pp.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
      9.02 ±  3%     +10.7       19.71        perf-profile.calltrace.cycles-pp.skb_release_data.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      8.36 ±  3%     +10.7       19.08        perf-profile.calltrace.cycles-pp.kfree.skb_release_data.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      3.21 ± 10%     +11.2       14.44 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__put_partials.kfree.skb_release_data
      3.30 ± 10%     +11.3       14.61 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__put_partials.kfree.skb_release_data.consume_skb
      3.44 ± 10%     +11.5       14.89 ±  2%  perf-profile.calltrace.cycles-pp.__put_partials.kfree.skb_release_data.consume_skb.unix_stream_read_generic
      9.43 ±  2%      -3.6        5.84        perf-profile.children.cycles-pp.kmem_cache_free
      5.98 ±  3%      -2.3        3.72        perf-profile.children.cycles-pp.kmem_cache_alloc_node_noprof
     48.56            -1.5       47.11        perf-profile.children.cycles-pp.write
      6.23            -1.2        5.02        perf-profile.children.cycles-pp.sock_def_readable
      6.60            -0.9        5.68        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      4.32 ±  2%      -0.9        3.40        perf-profile.children.cycles-pp._raw_spin_lock
      7.01            -0.8        6.16        perf-profile.children.cycles-pp.unix_stream_read_actor
      4.86 ±  2%      -0.8        4.02        perf-profile.children.cycles-pp.__wake_up_sync_key
      6.91            -0.8        6.08        perf-profile.children.cycles-pp.skb_copy_datagram_iter
      6.76            -0.8        5.95        perf-profile.children.cycles-pp.__skb_datagram_iter
      3.64 ±  6%      -0.8        2.87 ±  5%  perf-profile.children.cycles-pp.fdget_pos
      3.80            -0.7        3.06        perf-profile.children.cycles-pp.clear_bhb_loop
      4.00 ±  3%      -0.7        3.35        perf-profile.children.cycles-pp.__wake_up_common
      3.87 ±  4%      -0.6        3.24        perf-profile.children.cycles-pp.autoremove_wake_function
      3.83 ±  4%      -0.6        3.20        perf-profile.children.cycles-pp.try_to_wake_up
      4.15 ±  3%      -0.6        3.53        perf-profile.children.cycles-pp.__schedule
      2.47            -0.6        1.86        perf-profile.children.cycles-pp.__slab_free
      4.04 ±  3%      -0.6        3.49        perf-profile.children.cycles-pp.schedule
      3.05            -0.5        2.52        perf-profile.children.cycles-pp.entry_SYSCALL_64
      3.00            -0.5        2.49        perf-profile.children.cycles-pp.skb_copy_datagram_from_iter
      4.49            -0.5        3.99        perf-profile.children.cycles-pp.__check_object_size
      3.24 ±  2%      -0.5        2.76        perf-profile.children.cycles-pp.skb_release_head_state
      3.11 ±  2%      -0.5        2.65        perf-profile.children.cycles-pp.unix_destruct_scm
      4.98            -0.4        4.53        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      3.00 ±  2%      -0.4        2.56        perf-profile.children.cycles-pp._copy_to_iter
      3.51 ±  4%      -0.4        3.08        perf-profile.children.cycles-pp.schedule_timeout
      2.88 ±  2%      -0.4        2.46        perf-profile.children.cycles-pp.sock_wfree
      1.74 ±  3%      -0.4        1.33        perf-profile.children.cycles-pp.skb_set_owner_w
      0.45 ± 26%      -0.4        0.07 ± 10%  perf-profile.children.cycles-pp.common_startup_64
      0.45 ± 26%      -0.4        0.07 ± 10%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.44 ± 26%      -0.4        0.07 ± 10%  perf-profile.children.cycles-pp.do_idle
      0.44 ± 26%      -0.4        0.07 ± 11%  perf-profile.children.cycles-pp.start_secondary
      1.82 ±  2%      -0.3        1.51        perf-profile.children.cycles-pp.its_return_thunk
      0.36 ± 28%      -0.3        0.06 ±  8%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.34 ± 27%      -0.3        0.04 ± 45%  perf-profile.children.cycles-pp.cpuidle_enter
      0.33 ± 27%      -0.3        0.04 ± 71%  perf-profile.children.cycles-pp.acpi_idle_do_entry
      0.33 ± 27%      -0.3        0.04 ± 71%  perf-profile.children.cycles-pp.acpi_idle_enter
      0.34 ± 27%      -0.3        0.04 ± 45%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.33 ± 28%      -0.3        0.04 ± 71%  perf-profile.children.cycles-pp.acpi_safe_halt
      0.33 ± 28%      -0.3        0.04 ± 71%  perf-profile.children.cycles-pp.pv_native_safe_halt
      3.18            -0.3        2.90        perf-profile.children.cycles-pp.simple_copy_to_iter
      1.94 ±  3%      -0.3        1.67        perf-profile.children.cycles-pp.ttwu_do_activate
      0.35 ± 16%      -0.3        0.08 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      1.65 ±  6%      -0.3        1.39 ±  2%  perf-profile.children.cycles-pp.skb_queue_tail
      2.93            -0.2        2.69        perf-profile.children.cycles-pp.check_heap_object
      1.38            -0.2        1.14        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      2.66            -0.2        2.43        perf-profile.children.cycles-pp.mod_objcg_state
      1.72 ±  3%      -0.2        1.50        perf-profile.children.cycles-pp.enqueue_task
      1.27            -0.2        1.06        perf-profile.children.cycles-pp._copy_from_iter
      1.63 ±  3%      -0.2        1.42        perf-profile.children.cycles-pp.enqueue_task_fair
      1.30 ±  5%      -0.2        1.11        perf-profile.children.cycles-pp.try_to_block_task
      1.32 ±  5%      -0.2        1.14        perf-profile.children.cycles-pp.dequeue_entities
      0.64 ± 12%      -0.2        0.46 ±  3%  perf-profile.children.cycles-pp.__switch_to
      1.05 ±  3%      -0.2        0.87        perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.90            -0.2        0.73        perf-profile.children.cycles-pp.fput
      1.50 ±  2%      -0.2        1.32        perf-profile.children.cycles-pp.__pick_next_task
      0.79 ±  7%      -0.2        0.62        perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      1.33 ±  4%      -0.2        1.16        perf-profile.children.cycles-pp.dequeue_task_fair
      0.61 ±  4%      -0.2        0.45        perf-profile.children.cycles-pp.select_task_rq
      1.46 ±  2%      -0.2        1.30        perf-profile.children.cycles-pp.pick_next_task_fair
      1.00 ±  3%      -0.1        0.86        perf-profile.children.cycles-pp.update_load_avg
      0.77            -0.1        0.63        perf-profile.children.cycles-pp.__cond_resched
      0.51 ±  3%      -0.1        0.37        perf-profile.children.cycles-pp.select_task_rq_fair
      0.76            -0.1        0.62        perf-profile.children.cycles-pp.mutex_lock
      0.85 ±  4%      -0.1        0.72        perf-profile.children.cycles-pp.update_curr
      0.65            -0.1        0.52        perf-profile.children.cycles-pp.skb_unlink
      0.77            -0.1        0.65 ±  2%  perf-profile.children.cycles-pp.__check_heap_object
      0.61            -0.1        0.49        perf-profile.children.cycles-pp.__build_skb_around
      0.18 ±  7%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.97 ±  3%      -0.1        0.85        perf-profile.children.cycles-pp.enqueue_entity
      0.74 ±  4%      -0.1        0.63        perf-profile.children.cycles-pp.dequeue_entity
      0.46 ±  3%      -0.1        0.34        perf-profile.children.cycles-pp.prepare_to_wait
      0.61            -0.1        0.50        perf-profile.children.cycles-pp.rw_verify_area
      0.62            -0.1        0.51        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.88            -0.1        0.78        perf-profile.children.cycles-pp.refill_obj_stock
      0.15 ±  6%      -0.1        0.05        perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.59 ±  3%      -0.1        0.49 ±  2%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.62 ±  3%      -0.1        0.51        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.21 ±  8%      -0.1        0.11 ±  3%  perf-profile.children.cycles-pp.select_idle_sibling
      0.46            -0.1        0.37        perf-profile.children.cycles-pp.mutex_unlock
      0.55            -0.1        0.46 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.50 ±  2%      -0.1        0.41        perf-profile.children.cycles-pp.scm_recv_unix
      0.51 ±  2%      -0.1        0.42 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.46 ±  3%      -0.1        0.38        perf-profile.children.cycles-pp.pick_task_fair
      0.44            -0.1        0.36        perf-profile.children.cycles-pp.x64_sys_call
      0.45 ±  2%      -0.1        0.37 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.44 ±  2%      -0.1        0.36 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.45 ±  2%      -0.1        0.38        perf-profile.children.cycles-pp.switch_fpu_return
      0.37 ±  2%      -0.1        0.30 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.36 ±  3%      -0.1        0.29 ±  2%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.33 ±  3%      -0.1        0.27 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.12 ±  5%      -0.1        0.06        perf-profile.children.cycles-pp.available_idle_cpu
      0.14 ±  6%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.30 ±  2%      -0.1        0.24 ±  2%  perf-profile.children.cycles-pp.__scm_recv_common
      0.46 ±  7%      -0.1        0.41        perf-profile.children.cycles-pp.set_next_entity
      0.32 ±  3%      -0.0        0.27 ±  2%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.29 ±  5%      -0.0        0.24        perf-profile.children.cycles-pp.wakeup_preempt
      0.25            -0.0        0.20        perf-profile.children.cycles-pp.kmalloc_size_roundup
      0.26 ±  3%      -0.0        0.22        perf-profile.children.cycles-pp.prepare_task_switch
      0.29 ±  3%      -0.0        0.24 ±  3%  perf-profile.children.cycles-pp.update_cfs_group
      0.26 ±  3%      -0.0        0.22        perf-profile.children.cycles-pp.rcu_all_qs
      0.32 ±  6%      -0.0        0.28        perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.75            -0.0        0.71        perf-profile.children.cycles-pp.unix_write_space
      0.19 ±  4%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.finish_task_switch
      0.22 ±  6%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.sched_tick
      0.31 ±  4%      -0.0        0.26        perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.24            -0.0        0.20        perf-profile.children.cycles-pp.security_file_permission
      0.16 ±  4%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.unix_maybe_add_creds
      0.30 ±  4%      -0.0        0.26        perf-profile.children.cycles-pp.__update_load_avg_se
      0.18 ±  7%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.task_tick_fair
      0.25 ±  5%      -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.pick_eevdf
      0.16 ±  6%      -0.0        0.13        perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.21 ±  3%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.check_stack_object
      0.21 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.18 ±  3%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.unix_scm_to_skb
      0.23 ±  7%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.19 ±  6%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.do_perf_trace_sched_wakeup_template
      0.16 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.is_vmalloc_addr
      0.14 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.18 ±  2%      -0.0        0.15        perf-profile.children.cycles-pp.put_pid
      0.16 ±  3%      -0.0        0.13        perf-profile.children.cycles-pp.put_prev_entity
      0.24 ±  2%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.wake_affine
      0.15 ±  2%      -0.0        0.12        perf-profile.children.cycles-pp.manage_oob
      0.22 ±  5%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.32 ±  2%      -0.0        0.30        perf-profile.children.cycles-pp.reweight_entity
      0.16 ±  2%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.13 ±  2%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.security_socket_getpeersec_dgram
      0.09 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.cpuacct_charge
      0.30 ±  4%      -0.0        0.28        perf-profile.children.cycles-pp.__enqueue_entity
      0.16 ±  3%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.update_curr_se
      0.11 ±  3%      -0.0        0.09        perf-profile.children.cycles-pp.wait_for_unix_gc
      0.10            -0.0        0.08        perf-profile.children.cycles-pp.skb_put
      0.12 ±  7%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.os_xsave
      0.10 ±  3%      -0.0        0.08        perf-profile.children.cycles-pp.skb_free_head
      0.13 ±  5%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.update_entity_lag
      0.15 ±  7%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.update_rq_clock
      0.10 ±  8%      -0.0        0.08        perf-profile.children.cycles-pp.___perf_sw_event
      0.12 ±  6%      -0.0        0.10        perf-profile.children.cycles-pp.perf_tp_event
      0.09            -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__switch_to_asm
      0.08 ±  6%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.kfree_skbmem
      0.09 ±  7%      -0.0        0.08        perf-profile.children.cycles-pp.rseq_update_cpu_node_id
      0.07 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.__x64_sys_write
      0.06 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.finish_wait
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.__x64_sys_read
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.__irq_exit_rcu
      0.10 ± 10%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.detach_tasks
      0.24 ± 10%      +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.24 ±  9%      +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.sched_balance_rq
      0.16 ±  3%      +0.0        0.19        perf-profile.children.cycles-pp.put_cpu_partial
      0.19            +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.css_rstat_updated
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__refill_stock
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.sysvec_call_function
      0.16 ±  2%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.refill_stock
      0.14 ±  2%      +0.1        0.19 ±  3%  perf-profile.children.cycles-pp.try_charge_memcg
      0.34 ±  3%      +0.1        0.40 ±  4%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_call_function
      0.32 ±  5%      +0.1        0.40 ±  5%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.42 ±  2%      +0.1        0.56        perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.12 ± 11%      +0.1        0.26 ±  4%  perf-profile.children.cycles-pp.get_any_partial
     37.92            +0.6       38.52        perf-profile.children.cycles-pp.vfs_write
     36.83            +0.8       37.63        perf-profile.children.cycles-pp.sock_write_iter
     35.67            +1.0       36.68        perf-profile.children.cycles-pp.unix_stream_sendmsg
     50.55            +1.9       52.47        perf-profile.children.cycles-pp.read
     88.56            +2.4       90.94        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     87.95            +2.5       90.43        perf-profile.children.cycles-pp.do_syscall_64
     42.42            +3.4       45.79        perf-profile.children.cycles-pp.ksys_read
     40.72            +3.7       44.41        perf-profile.children.cycles-pp.vfs_read
     39.55            +3.9       43.45        perf-profile.children.cycles-pp.sock_read_iter
     38.72            +4.0       42.77        perf-profile.children.cycles-pp.sock_recvmsg
     38.16            +4.1       42.29        perf-profile.children.cycles-pp.unix_stream_recvmsg
     37.91            +4.2       42.09        perf-profile.children.cycles-pp.unix_stream_read_generic
     18.34            +4.4       22.74        perf-profile.children.cycles-pp.sock_alloc_send_pskb
     15.61 ±  2%      +4.9       20.54        perf-profile.children.cycles-pp.alloc_skb_with_frags
     15.35 ±  2%      +5.0       20.32        perf-profile.children.cycles-pp.__alloc_skb
      4.43 ± 11%      +6.1       10.58 ±  2%  perf-profile.children.cycles-pp.get_partial_node
      5.34 ±  9%      +6.3       11.65 ±  2%  perf-profile.children.cycles-pp.___slab_alloc
      7.59 ±  2%      +7.6       15.16        perf-profile.children.cycles-pp.kmalloc_reserve
      7.08 ±  2%      +7.7       14.73        perf-profile.children.cycles-pp.__kmalloc_node_track_caller_noprof
      6.27 ± 11%      +9.1       15.34 ±  2%  perf-profile.children.cycles-pp.__put_partials
     12.41           +10.2       22.59        perf-profile.children.cycles-pp.consume_skb
      9.06 ±  3%     +10.7       19.74        perf-profile.children.cycles-pp.skb_release_data
      8.42 ±  3%     +10.7       19.13        perf-profile.children.cycles-pp.kfree
     13.33 ±  8%     +14.3       27.59 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     11.76 ±  9%     +14.3       26.04 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      3.88 ±  2%      -0.8        3.08        perf-profile.self.cycles-pp.__memcg_slab_free_hook
      3.58 ±  6%      -0.8        2.82 ±  5%  perf-profile.self.cycles-pp.fdget_pos
      3.76            -0.7        3.03        perf-profile.self.cycles-pp.clear_bhb_loop
      3.19 ±  3%      -0.6        2.57        perf-profile.self.cycles-pp._raw_spin_lock
      2.41            -0.6        1.82        perf-profile.self.cycles-pp.__slab_free
      2.71 ±  4%      -0.6        2.12        perf-profile.self.cycles-pp.unix_stream_sendmsg
      2.39 ±  2%      -0.4        1.95        perf-profile.self.cycles-pp.unix_stream_read_generic
      2.96 ±  2%      -0.4        2.53        perf-profile.self.cycles-pp._copy_to_iter
      1.71 ±  3%      -0.4        1.30        perf-profile.self.cycles-pp.skb_set_owner_w
      2.40            -0.4        2.02        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      2.10 ±  3%      -0.4        1.73        perf-profile.self.cycles-pp.sock_wfree
      2.08            -0.4        1.71        perf-profile.self.cycles-pp.do_syscall_64
      1.92            -0.3        1.58        perf-profile.self.cycles-pp.kmem_cache_free
      1.58 ±  8%      -0.3        1.26        perf-profile.self.cycles-pp.sock_def_readable
      2.60 ±  4%      -0.3        2.28        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      2.22            -0.3        1.95        perf-profile.self.cycles-pp.mod_objcg_state
      1.43 ±  4%      -0.2        1.19 ±  3%  perf-profile.self.cycles-pp.read
      1.41            -0.2        1.18        perf-profile.self.cycles-pp.write
      1.34            -0.2        1.10        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.16            -0.2        0.95        perf-profile.self.cycles-pp.__alloc_skb
      1.24            -0.2        1.03        perf-profile.self.cycles-pp._copy_from_iter
      1.34            -0.2        1.14        perf-profile.self.cycles-pp.__kmalloc_node_track_caller_noprof
      1.07 ±  2%      -0.2        0.88        perf-profile.self.cycles-pp.sock_write_iter
      0.63 ± 12%      -0.2        0.46 ±  3%  perf-profile.self.cycles-pp.__switch_to
      0.94 ±  2%      -0.2        0.78        perf-profile.self.cycles-pp.its_return_thunk
      0.94 ±  2%      -0.2        0.77        perf-profile.self.cycles-pp.kmem_cache_alloc_node_noprof
      0.85            -0.2        0.69        perf-profile.self.cycles-pp.fput
      0.84            -0.2        0.69        perf-profile.self.cycles-pp.sock_read_iter
      0.87 ±  2%      -0.1        0.72 ±  3%  perf-profile.self.cycles-pp.vfs_read
      0.83            -0.1        0.70        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.75 ±  3%      -0.1        0.61        perf-profile.self.cycles-pp.vfs_write
      0.72 ±  2%      -0.1        0.61 ±  2%  perf-profile.self.cycles-pp.__check_heap_object
      0.57 ±  2%      -0.1        0.47        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.59            -0.1        0.49        perf-profile.self.cycles-pp.__check_object_size
      0.56            -0.1        0.46        perf-profile.self.cycles-pp.__build_skb_around
      0.61 ±  2%      -0.1        0.50        perf-profile.self.cycles-pp.__skb_datagram_iter
      2.12 ±  2%      -0.1        2.02        perf-profile.self.cycles-pp.check_heap_object
      0.84            -0.1        0.74        perf-profile.self.cycles-pp.refill_obj_stock
      0.54 ±  3%      -0.1        0.45 ±  2%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.42            -0.1        0.34        perf-profile.self.cycles-pp.mutex_unlock
      0.55 ±  3%      -0.1        0.46        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.45            -0.1        0.37        perf-profile.self.cycles-pp.mutex_lock
      0.47            -0.1        0.38        perf-profile.self.cycles-pp.kfree
      0.40 ±  3%      -0.1        0.32        perf-profile.self.cycles-pp.__schedule
      0.46            -0.1        0.38        perf-profile.self.cycles-pp.unix_write_space
      0.96            -0.1        0.89        perf-profile.self.cycles-pp.obj_cgroup_charge
      0.41            -0.1        0.34 ±  2%  perf-profile.self.cycles-pp.sock_alloc_send_pskb
      0.36 ±  2%      -0.1        0.30        perf-profile.self.cycles-pp.rw_verify_area
      0.38            -0.1        0.32        perf-profile.self.cycles-pp.x64_sys_call
      0.36 ±  2%      -0.1        0.30        perf-profile.self.cycles-pp.__cond_resched
      0.33 ±  2%      -0.1        0.27        perf-profile.self.cycles-pp.ksys_read
      0.33            -0.1        0.27        perf-profile.self.cycles-pp.ksys_write
      0.37 ±  2%      -0.1        0.31        perf-profile.self.cycles-pp.sock_recvmsg
      0.36 ±  2%      -0.1        0.31        perf-profile.self.cycles-pp.update_load_avg
      0.33 ±  2%      -0.1        0.27        perf-profile.self.cycles-pp.skb_copy_datagram_from_iter
      0.28 ±  2%      -0.1        0.23        perf-profile.self.cycles-pp.alloc_skb_with_frags
      0.11 ±  7%      -0.1        0.06        perf-profile.self.cycles-pp.available_idle_cpu
      0.26            -0.0        0.21        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.27            -0.0        0.22 ±  3%  perf-profile.self.cycles-pp.unix_stream_recvmsg
      0.28 ±  3%      -0.0        0.24        perf-profile.self.cycles-pp.update_cfs_group
      0.28 ±  2%      -0.0        0.24 ±  2%  perf-profile.self.cycles-pp.kmalloc_reserve
      0.30 ±  4%      -0.0        0.26        perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.27 ±  3%      -0.0        0.23        perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.28 ±  6%      -0.0        0.24        perf-profile.self.cycles-pp.update_curr
      0.24            -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.__scm_recv_common
      0.20 ±  2%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.kmalloc_size_roundup
      0.20            -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.security_file_permission
      0.28 ±  5%      -0.0        0.24 ±  2%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.19 ±  2%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.unix_destruct_scm
      0.12 ±  4%      -0.0        0.09        perf-profile.self.cycles-pp.unix_maybe_add_creds
      0.22 ±  7%      -0.0        0.18        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.19 ±  2%      -0.0        0.16        perf-profile.self.cycles-pp.update_rq_clock_task
      0.18 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.prepare_task_switch
      0.20 ±  2%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.rcu_all_qs
      0.14 ±  4%      -0.0        0.11        perf-profile.self.cycles-pp.skb_queue_tail
      0.17 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.17 ±  3%      -0.0        0.14        perf-profile.self.cycles-pp.scm_recv_unix
      0.16 ±  3%      -0.0        0.13        perf-profile.self.cycles-pp.unix_scm_to_skb
      0.20 ±  2%      -0.0        0.17        perf-profile.self.cycles-pp.pick_eevdf
      0.13 ±  2%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.manage_oob
      0.12 ±  3%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.simple_copy_to_iter
      0.14 ±  2%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.switch_fpu_return
      0.17 ±  2%      -0.0        0.14        perf-profile.self.cycles-pp.try_to_wake_up
      0.16 ±  2%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.check_stack_object
      0.15            -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.skb_unlink
      0.13 ±  2%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__wake_up_common
      0.11 ±  4%      -0.0        0.09        perf-profile.self.cycles-pp.finish_task_switch
      0.12 ±  3%      -0.0        0.10        perf-profile.self.cycles-pp.put_pid
      0.13 ±  2%      -0.0        0.11        perf-profile.self.cycles-pp.consume_skb
      0.13 ±  2%      -0.0        0.11        perf-profile.self.cycles-pp.pick_next_task_fair
      0.14 ±  2%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.skb_copy_datagram_iter
      0.30 ±  2%      -0.0        0.28        perf-profile.self.cycles-pp.__enqueue_entity
      0.12 ±  3%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.is_vmalloc_addr
      0.11 ±  3%      -0.0        0.09        perf-profile.self.cycles-pp.security_socket_getpeersec_dgram
      0.12 ±  3%      -0.0        0.10        perf-profile.self.cycles-pp.pick_task_fair
      0.10            -0.0        0.08        perf-profile.self.cycles-pp.security_socket_sendmsg
      0.10            -0.0        0.08        perf-profile.self.cycles-pp.select_task_rq
      0.08 ±  5%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.cpuacct_charge
      0.13 ±  4%      -0.0        0.11        perf-profile.self.cycles-pp.dequeue_entity
      0.13            -0.0        0.11 ±  5%  perf-profile.self.cycles-pp.security_socket_recvmsg
      0.11            -0.0        0.09        perf-profile.self.cycles-pp.skb_release_head_state
      0.11            -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.enqueue_entity
      0.12 ±  5%      -0.0        0.10        perf-profile.self.cycles-pp.os_xsave
      0.14 ±  3%      -0.0        0.12        perf-profile.self.cycles-pp.update_curr_se
      0.13 ±  5%      -0.0        0.11        perf-profile.self.cycles-pp.exit_to_user_mode_loop
      0.14 ±  4%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.task_h_load
      0.12 ±  6%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.dequeue_entities
      0.09            -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.wait_for_unix_gc
      0.21 ±  6%      -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.__dequeue_entity
      0.10 ±  5%      -0.0        0.08        perf-profile.self.cycles-pp.__get_user_8
      0.11 ±  6%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.prepare_to_wait
      0.08            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.skb_free_head
      0.08            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.unix_stream_read_actor
      0.09 ±  4%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__switch_to_asm
      0.12 ±  6%      -0.0        0.11        perf-profile.self.cycles-pp.avg_vruntime
      0.09 ±  4%      -0.0        0.08        perf-profile.self.cycles-pp.place_entity
      0.07 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.select_task_rq_fair
      0.06 ±  6%      -0.0        0.05        perf-profile.self.cycles-pp.___perf_sw_event
      0.08            -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.skb_put
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.propagate_entity_load_avg
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.wakeup_preempt
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.kfree_skbmem
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.select_idle_sibling
      0.12 ±  3%      +0.0        0.16 ±  4%  perf-profile.self.cycles-pp.obj_cgroup_uncharge_pages
      0.15 ±  3%      +0.0        0.19        perf-profile.self.cycles-pp.put_cpu_partial
      0.10 ±  3%      +0.0        0.14 ±  2%  perf-profile.self.cycles-pp.refill_stock
      0.17            +0.0        0.21        perf-profile.self.cycles-pp.css_rstat_updated
      0.10 ±  4%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.try_charge_memcg
      0.27 ±  4%      +0.0        0.31 ±  5%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.25 ±  3%      +0.1        0.32        perf-profile.self.cycles-pp.__put_partials
      0.46 ±  3%      +0.1        0.60        perf-profile.self.cycles-pp.get_partial_node
      0.88            +0.2        1.03        perf-profile.self.cycles-pp.___slab_alloc
     11.74 ±  9%     +14.3       26.02 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


***************************************************************************************************
lkp-srf-2sp3: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-9.4/50%/debian-12-x86_64-20240206.cgz/300s/lkp-srf-2sp3/SCTP_STREAM/netperf

commit: 
  90b83efa67 ("Merge tag 'bpf-next-6.16' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next")
  2adc2445a5 ("xsk: Fix out of order segment free in __xsk_generic_xmit()")

90b83efa6701656e 2adc2445a5ae93efed1e2e6646a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     97891           -14.8%      83440        uptime.idle
 5.813e+10           -24.7%  4.376e+10        cpuidle..time
   1432696         +8071.0%  1.171e+08        cpuidle..usage
      2.67 ±129%  +13268.8%     356.50 ±106%  perf-c2c.DRAM.local
     36.50 ± 97%  +1.7e+05%      62210 ±106%  perf-c2c.HITM.local
     57.83 ± 96%  +1.1e+05%      62785 ±106%  perf-c2c.HITM.total
      7646 ± 24%   +3575.6%     281040 ±196%  numa-meminfo.node0.Shmem
    352954 ± 57%    +397.3%    1755395 ± 35%  numa-meminfo.node1.Active
    352954 ± 57%    +397.3%    1755395 ± 35%  numa-meminfo.node1.Active(anon)
     24856 ±  7%   +5388.7%    1364277 ± 33%  numa-meminfo.node1.Shmem
    900437 ± 18%  +33130.0%  2.992e+08        numa-numastat.node0.local_node
    980894 ± 15%  +30412.3%  2.993e+08        numa-numastat.node0.numa_hit
    843029 ± 20%  +33579.9%  2.839e+08        numa-numastat.node1.local_node
    960593 ± 15%  +29466.0%   2.84e+08        numa-numastat.node1.numa_hit
     99.95           -26.6%      73.35        vmstat.cpu.id
      1.43 ±  4%   +3253.2%      47.88 ±  2%  vmstat.procs.r
      3269        +21229.7%     697353        vmstat.system.cs
      5726 ±  2%   +7837.1%     454486        vmstat.system.in
     99.91           -26.7       73.24        mpstat.cpu.all.idle%
      0.01 ±  2%      +0.3        0.29        mpstat.cpu.all.irq%
      0.03            +6.7        6.71        mpstat.cpu.all.soft%
      0.03 ±  2%     +19.7       19.68        mpstat.cpu.all.sys%
      0.03            +0.1        0.08 ±  3%  mpstat.cpu.all.usr%
      1.00        +15883.3%     159.83 ± 57%  mpstat.max_utilization.seconds
      2.31 ±  3%   +1565.7%      38.48 ±  7%  mpstat.max_utilization_pct
    827685          +197.1%    2459378 ±  3%  meminfo.Active
    827685          +197.1%    2459378 ±  3%  meminfo.Active(anon)
   3564506           +45.3%    5177743        meminfo.Cached
   1002604          +162.8%    2634788 ±  3%  meminfo.Committed_AS
     73396           +27.4%      93496 ±  3%  meminfo.Mapped
   6584486           +30.6%    8597070        meminfo.Memused
     32406         +4978.1%    1645637 ±  5%  meminfo.Shmem
   7674969           +22.1%    9367878        meminfo.max_used_kB
   1475286 ± 37%  +10036.1%  1.495e+08        numa-vmstat.node0.nr_unaccepted
      1910 ± 24%   +3574.4%      70214 ±196%  numa-vmstat.node0.nr_writeback_temp
    901028 ± 18%  +33108.2%  2.992e+08        numa-vmstat.node0.numa_interleave
     88219 ± 57%    +397.4%     438783 ± 35%  numa-vmstat.node1.nr_inactive_anon
   1466007 ± 37%   +9598.9%  1.422e+08        numa-vmstat.node1.nr_unaccepted
      6201 ±  7%   +5398.9%     341002 ± 33%  numa-vmstat.node1.nr_writeback_temp
     88219 ± 57%    +397.4%     438783 ± 35%  numa-vmstat.node1.nr_zone_active_anon
    843731 ± 20%  +33552.0%  2.839e+08        numa-vmstat.node1.numa_interleave
      4.10        +93440.1%       3835        netperf.ThroughputBoth_Mbps
    393.60        +93440.1%     368173        netperf.ThroughputBoth_total_Mbps
      4.10        +93440.1%       3835        netperf.Throughput_Mbps
    393.60        +93440.1%     368173        netperf.Throughput_total_Mbps
     48.00 ±  9%  +1.5e+05%      71216        netperf.time.involuntary_context_switches
     36976          +109.6%      77489        netperf.time.minor_page_faults
      2.00        +89408.3%       1790        netperf.time.percent_of_cpu_this_job_got
      2.65 ±  5%    +2e+05%       5407        netperf.time.system_time
     70144        +75110.0%   52755811        netperf.time.voluntary_context_switches
     69331        +76173.9%   52881525        netperf.workload
     18597           +20.9%      22487        proc-vmstat.nr_anon_pages
    206982          +196.9%     614442 ±  3%  proc-vmstat.nr_inactive_anon
    891142           +45.2%    1294018        proc-vmstat.nr_mapped
    130794            +2.6%     134152        proc-vmstat.nr_slab_reclaimable
   2940843         +9808.2%  2.914e+08        proc-vmstat.nr_unaccepted
     36043            +2.6%      36994        proc-vmstat.nr_unevictable
      8116         +4963.7%     410990 ±  5%  proc-vmstat.nr_writeback_temp
    206982          +196.9%     614442 ±  3%  proc-vmstat.nr_zone_active_anon
      2758 ± 12%    +466.4%      15626 ± 11%  proc-vmstat.numa_hint_faults
      3103 ±183%   +1123.1%      37957 ± 15%  proc-vmstat.numa_hint_faults_local
      5180 ± 88%    +991.6%      56556 ± 10%  proc-vmstat.numa_huge_pte_updates
   1746716        +33285.4%  5.831e+08        proc-vmstat.numa_interleave
      3103 ±183%   +1123.1%      37957 ± 15%  proc-vmstat.numa_pages_migrated
  22862693        +81149.0%  1.858e+10        proc-vmstat.pgalloc_dma32
    962895           +11.6%    1074237        proc-vmstat.pglazyfree
     42493           +28.3%      54507        proc-vmstat.pgrefill
  22791848        +81398.7%  1.858e+10        proc-vmstat.pgskip_device
    199829            +2.3%     204523        proc-vmstat.workingset_nodereclaim
      8.77 ±  2%     -96.3%       0.32        perf-stat.i.MPKI
  77235971         +7812.2%  6.111e+09        perf-stat.i.branch-instructions
      1.93            -1.4        0.55        perf-stat.i.branch-miss-rate%
   3411141          +880.6%   33448138        perf-stat.i.branch-misses
     22.30 ±  2%     -21.6        0.71        perf-stat.i.cache-miss-rate%
   1665598 ±  2%    +511.2%   10179755        perf-stat.i.cache-misses
   7250815        +31692.2%  2.305e+09        perf-stat.i.cache-references
      3208        +21832.1%     703722        perf-stat.i.context-switches
      3.61           +37.5%       4.96        perf-stat.i.cpi
 7.967e+08        +19662.7%  1.574e+11        perf-stat.i.cpu-cycles
    268.09         +1572.7%       4484        perf-stat.i.cpu-migrations
    470.08         +3392.1%      16415        perf-stat.i.cycles-between-cache-misses
 3.771e+08         +8315.9%  3.173e+10        perf-stat.i.instructions
      0.31           -33.5%       0.21        perf-stat.i.ipc
      2789           +12.7%       3145        perf-stat.i.minor-faults
      2789           +12.7%       3145        perf-stat.i.page-faults
      4.42 ±  2%     -92.7%       0.32        perf-stat.overall.MPKI
      4.42            -3.9        0.55        perf-stat.overall.branch-miss-rate%
     22.97 ±  2%     -22.5        0.44        perf-stat.overall.cache-miss-rate%
      2.11          +134.8%       4.96        perf-stat.overall.cpi
    478.64 ±  2%   +3130.5%      15462        perf-stat.overall.cycles-between-cache-misses
      0.47           -57.4%       0.20        perf-stat.overall.ipc
   1638835           -88.9%     181352        perf-stat.overall.path-length
  76999412         +7810.5%  6.091e+09        perf-stat.ps.branch-instructions
   3401355          +880.2%   33339495        perf-stat.ps.branch-misses
   1659790 ±  2%    +511.5%   10149201        perf-stat.ps.cache-misses
   7226565        +31693.0%  2.298e+09        perf-stat.ps.cache-references
      3197        +21832.0%     701377        perf-stat.ps.context-switches
 7.941e+08        +19659.7%  1.569e+11        perf-stat.ps.cpu-cycles
    267.21         +1572.9%       4470        perf-stat.ps.cpu-migrations
 3.759e+08         +8313.8%  3.163e+10        perf-stat.ps.instructions
      2780           +12.7%       3133        perf-stat.ps.minor-faults
      2780           +12.7%       3133        perf-stat.ps.page-faults
 1.136e+11         +8340.5%   9.59e+12        perf-stat.total.instructions
      3740 ± 12%  +29693.1%    1114329 ± 10%  sched_debug.cfs_rq:/.avg_vruntime.avg
     56542 ± 15%   +2339.5%    1379378 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.max
    369.53 ± 16%  +1.6e+05%     579756 ± 20%  sched_debug.cfs_rq:/.avg_vruntime.min
      6898 ± 20%   +1820.7%     132511 ± 26%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.02 ± 12%   +1118.1%       0.22 ±  6%  sched_debug.cfs_rq:/.h_nr_queued.avg
      0.13 ±  6%    +212.0%       0.40        sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.02 ± 12%   +1116.5%       0.22 ±  5%  sched_debug.cfs_rq:/.h_nr_runnable.avg
      0.13 ±  6%    +211.4%       0.40        sched_debug.cfs_rq:/.h_nr_runnable.stddev
     14.16 ±132%  +48472.6%       6875 ± 21%  sched_debug.cfs_rq:/.left_deadline.avg
      2717 ±132%  +27785.8%     757891 ± 19%  sched_debug.cfs_rq:/.left_deadline.max
    195.63 ±132%  +35354.2%      69359 ± 15%  sched_debug.cfs_rq:/.left_deadline.stddev
     14.11 ±133%  +48627.1%       6874 ± 21%  sched_debug.cfs_rq:/.left_vruntime.avg
      2708 ±133%  +27874.6%     757818 ± 19%  sched_debug.cfs_rq:/.left_vruntime.max
    194.99 ±133%  +35466.9%      69352 ± 15%  sched_debug.cfs_rq:/.left_vruntime.stddev
    618037 ± 36%     -66.7%     205834 ± 48%  sched_debug.cfs_rq:/.load.max
     51379 ± 30%     -57.6%      21767 ± 30%  sched_debug.cfs_rq:/.load.stddev
    687.50 ±  9%     -64.9%     241.44 ± 24%  sched_debug.cfs_rq:/.load_avg.max
     83.99 ±  6%     -49.9%      42.10 ± 29%  sched_debug.cfs_rq:/.load_avg.stddev
      3740 ± 12%  +29693.1%    1114329 ± 10%  sched_debug.cfs_rq:/.min_vruntime.avg
     56542 ± 15%   +2339.5%    1379378 ±  8%  sched_debug.cfs_rq:/.min_vruntime.max
    369.53 ± 16%  +1.6e+05%     579756 ± 20%  sched_debug.cfs_rq:/.min_vruntime.min
      6899 ± 20%   +1820.7%     132511 ± 26%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.02 ± 13%   +1109.9%       0.22 ±  5%  sched_debug.cfs_rq:/.nr_queued.avg
      0.13 ±  7%    +210.9%       0.40 ±  2%  sched_debug.cfs_rq:/.nr_queued.stddev
     14.12 ±133%  +48603.5%       6874 ± 21%  sched_debug.cfs_rq:/.right_vruntime.avg
      2710 ±133%  +27861.0%     757818 ± 19%  sched_debug.cfs_rq:/.right_vruntime.max
    195.09 ±133%  +35449.7%      69352 ± 15%  sched_debug.cfs_rq:/.right_vruntime.stddev
     35.41 ±  6%    +493.0%     209.98 ±  5%  sched_debug.cfs_rq:/.runnable_avg.avg
    685.83 ±  4%     +35.7%     930.48 ±  5%  sched_debug.cfs_rq:/.runnable_avg.max
     83.58 ±  4%    +188.8%     241.42 ±  2%  sched_debug.cfs_rq:/.runnable_avg.stddev
     35.30 ±  6%    +494.6%     209.91 ±  5%  sched_debug.cfs_rq:/.util_avg.avg
    680.17 ±  5%     +36.8%     930.40 ±  5%  sched_debug.cfs_rq:/.util_avg.max
     83.16 ±  4%    +190.3%     241.37 ±  2%  sched_debug.cfs_rq:/.util_avg.stddev
      3.01 ± 38%   +3061.8%      95.09 ±  7%  sched_debug.cfs_rq:/.util_est.avg
    249.27 ± 31%    +131.8%     577.82 ±  2%  sched_debug.cfs_rq:/.util_est.max
     23.40 ± 29%    +671.1%     180.43 ±  2%  sched_debug.cfs_rq:/.util_est.stddev
    968260           -56.6%     420088 ±  9%  sched_debug.cpu.avg_idle.avg
    134682 ± 51%     -64.3%      48084 ±  4%  sched_debug.cpu.avg_idle.min
     94988 ±  6%    +233.8%     317085 ±  8%  sched_debug.cpu.avg_idle.stddev
     10.48 ±  2%     +16.1%      12.18 ±  2%  sched_debug.cpu.clock.stddev
    526.86          +230.8%       1742 ± 13%  sched_debug.cpu.clock_task.stddev
     67.14 ± 12%   +1549.7%       1107 ±  5%  sched_debug.cpu.curr->pid.avg
    652.41 ±  3%    +205.6%       1993        sched_debug.cpu.curr->pid.stddev
      0.00 ±  4%     +15.1%       0.00 ±  5%  sched_debug.cpu.next_balance.stddev
      0.01 ± 20%   +1565.3%       0.22 ±  5%  sched_debug.cpu.nr_running.avg
      0.10 ±  9%    +286.8%       0.40        sched_debug.cpu.nr_running.stddev
      3400 ±  5%  +15458.0%     529068 ±  8%  sched_debug.cpu.nr_switches.avg
     54421 ± 22%   +1031.5%     615757 ±  7%  sched_debug.cpu.nr_switches.max
      1015 ±  7%  +26519.5%     270329 ± 12%  sched_debug.cpu.nr_switches.min
      5199 ± 22%    +721.5%      42712 ±  6%  sched_debug.cpu.nr_switches.stddev
      0.01 ± 17%     +60.3%       0.02 ±  5%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.02 ± 17%     -39.1%       0.01 ± 17%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ±  5%     +31.4%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
      0.04 ± 75%     -66.8%       0.01 ± 13%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ±  4%     +30.9%       0.01 ±  4%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ± 88%    +375.6%       0.03 ± 54%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.02 ± 13%     -47.0%       0.01 ± 20%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ±  7%     +38.7%       0.01 ±  9%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.02 ±  4%     -28.6%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.21 ± 62%     -96.6%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg
      0.32 ±138%     -97.7%       0.01 ± 10%  perf-sched.sch_delay.avg.ms.schedule_timeout.sctp_wait_for_sndbuf.sctp_sendmsg_to_asoc.sctp_sendmsg
      0.01 ± 26%    +334.9%       0.03 ± 11%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.05 ±217%     -98.1%       0.02 ±  6%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ± 20%     -54.7%       0.01 ± 17%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.12 ±147%     -85.3%       0.02 ± 11%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.02 ±  9%    +235.9%       0.07 ±112%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.03 ± 41%  +2.7e+05%      68.69 ±222%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 86%   +1267.4%       0.10 ± 65%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.04 ±  6%     -50.8%       0.02 ± 22%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 10%    +139.2%       0.03 ± 61%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.03 ± 22%     -48.7%       0.02 ±  3%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    207.81          +150.3%     520.18 ± 46%  perf-sched.sch_delay.max.ms.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg
      1.79 ±118%   +1020.4%      20.01 ± 62%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.16 ±103%     -95.3%       0.01 ±  6%  perf-sched.total_sch_delay.average.ms
    252.56           -99.4%       1.56 ±  2%  perf-sched.total_wait_and_delay.average.ms
     10166        +15987.4%    1635446        perf-sched.total_wait_and_delay.count.ms
      4984           -15.6%       4204 ±  7%  perf-sched.total_wait_and_delay.max.ms
    252.40           -99.4%       1.55 ±  2%  perf-sched.total_wait_time.average.ms
      4984           -15.6%       4204 ±  7%  perf-sched.total_wait_time.max.ms
      7.83           -55.1%       3.52        perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    184.60 ±  4%     +14.9%     212.10        perf-sched.wait_and_delay.avg.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
      0.47          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.60 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    199.50           -99.8%       0.43 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg
    381.71           -99.9%       0.43 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.sctp_wait_for_sndbuf.sctp_sendmsg_to_asoc.sctp_sendmsg
    604.00           -77.6%     135.41 ±  4%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    797.02 ±  3%     -18.0%     653.44        perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    217.83 ±  4%     -13.4%     188.67        perf-sched.wait_and_delay.count.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
    126.33          -100.0%       0.00        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     88.17          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      2310        +34913.6%     808931        perf-sched.wait_and_delay.count.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg
      1157        +69710.6%     807941        perf-sched.wait_and_delay.count.schedule_timeout.sctp_wait_for_sndbuf.sctp_sendmsg_to_asoc.sctp_sendmsg
      1600          +346.1%       7140 ±  5%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    723.83 ±  2%     +60.2%       1159        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      4984           -79.9%       1000        perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     16.98 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.23 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    209.37          +491.8%       1239 ± 31%  perf-sched.wait_and_delay.max.ms.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg
    417.22          +155.0%       1063        perf-sched.wait_and_delay.max.ms.schedule_timeout.sctp_wait_for_sndbuf.sctp_sendmsg_to_asoc.sctp_sendmsg
      4122 ± 10%     -35.0%       2679 ± 17%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      7.81           -55.3%       3.49        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    184.59 ±  4%     +14.9%     212.09        perf-sched.wait_time.avg.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
      0.46            +9.9%       0.51        perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    375.09 ± 24%     -99.7%       1.19 ± 48%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      4.04           +10.5%       4.47 ±  3%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.60 ±  4%     +11.2%       0.66 ±  3%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    199.29           -99.8%       0.43 ±  3%  perf-sched.wait_time.avg.ms.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg
    381.39           -99.9%       0.42 ±  3%  perf-sched.wait_time.avg.ms.schedule_timeout.sctp_wait_for_sndbuf.sctp_sendmsg_to_asoc.sctp_sendmsg
    604.00           -77.6%     135.38 ±  4%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    795.97 ±  3%     -17.9%     653.42        perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      4984           -79.9%       1000        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      2.23 ±  6%     +21.9%       2.71 ±  6%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    209.31          +408.2%       1063        perf-sched.wait_time.max.ms.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg
    417.20          +155.0%       1063        perf-sched.wait_time.max.ms.schedule_timeout.sctp_wait_for_sndbuf.sctp_sendmsg_to_asoc.sctp_sendmsg
      4122 ± 10%     -35.0%       2679 ± 17%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


