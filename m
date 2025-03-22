Return-Path: <bpf+bounces-54570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87345A6CA3C
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 14:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6B3480F23
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 13:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F362222A4;
	Sat, 22 Mar 2025 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KLv2vglU"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718709443;
	Sat, 22 Mar 2025 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742649312; cv=fail; b=Ryvg5cVVR02fQZoMgqscRZBVVdUpApiuNw+BK8KNYZKJEtQESq9nY+ZE4bHfgZyP5PqXLIZ9UXonb4X+TKqy8KhBLCMFORwr1basbrwNtYfaXAoWUkCmHXdQ1jMJ5JIXlQtJQb0uAx9wWjOBmCqPa48vW+vONTqGc0Y87NvUP44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742649312; c=relaxed/simple;
	bh=aFkPb173nGKW8MlD3gdoYABysjaVmdEZNbV8FD85Jvk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JyIOkr5QJ4N9GMjZVI4RgC0dA9G9KJsU1C7Kc12yEpwKjdH+L+Icy0XuQgzYFJYxJBPSGX1ANnfbXORp1XK0T13HGeHHVeueVqrO9Nw3UgEst0ShajygQNxSu3aNX+br8P1SRnC+wKNQY7x8W2wl4zLFetS7goweq+iuTSAlVz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KLv2vglU; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742649310; x=1774185310;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aFkPb173nGKW8MlD3gdoYABysjaVmdEZNbV8FD85Jvk=;
  b=KLv2vglUMO+CPNV465OPlcg1hvEA27imtxluAWij7QYjk61VRFMzQjnU
   z7yXBGr5MvKSr9Q4smXTj55g6kCTPoRlJJX9OI1/DZMtpb4iYP4SWwwWI
   FLN1tJakaFoFjqNr7xDihUcjWiel81k29TYeXB4bF8zvYkaUcJUO98AMq
   wddc1SnbqVwiKHCHOlJL14qeZi7rwY5uH5KbiqHV80RqbKGUoVCC1nYK8
   FcN4SH96qn5ZWCW3pl72BTFSJvCi/BeeH5S1euNX+pNIymOX2eRs8ZMvc
   VWpTIniYIsjph1jSOmA5M4+nfKDe8Ye8D66WSuOK2O/VAr6UsIPsNAq2l
   A==;
X-CSE-ConnectionGUID: TpU8YR0qTRyi6PbzOagfoA==
X-CSE-MsgGUID: 2awIAjk9TEmg1kMGUuV0ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11381"; a="43915023"
X-IronPort-AV: E=Sophos;i="6.14,267,1736841600"; 
   d="scan'208";a="43915023"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 06:15:10 -0700
X-CSE-ConnectionGUID: JNzIoP+aQxKCrCKOHn2pYQ==
X-CSE-MsgGUID: zEMyfjhVQS2MtKPYQEy7CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,267,1736841600"; 
   d="scan'208";a="124091620"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 06:15:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sat, 22 Mar 2025 06:15:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sat, 22 Mar 2025 06:15:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 22 Mar 2025 06:15:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkW3PC4Ve74oLShz1VsLLQVc/2MyoImIqRX4yJhAw4fDx3HMdzSQcoJIXewqeeueeTiKip//wW1uVHy0KLos4SLBClUnpPguenxPlmgXrLvAY7SOpb/bjhVQzlmpN0ve020TRmvdQ5duI/AmjPBf/OpMBNey7E3cZjGaDqaFcglI/MROQlXPnLJCeHxg+BnlWvXy3x2rBhUOIKv/E0etglQRrHbxmCwJPeFPfa+ajRJYgLYHlzCD0ELjMRyPHSllQxosnG5amEl28sLQyyXY0BEI5E5V9NCyUHn/7mk+RReFt1AVnkcG1/SUktVJTPT8NmCzAs0xGzjxRIyeuUR/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69Slj8p9SIZcsQ8Xgnw+e4OaCl/ukNybm/SBftFKy3o=;
 b=apWJDXpUzkPEMegyzicoJZ3lV1lsEsSfbOe2B+0zGeEDtDqRBYRwo6izsr7KDtLxNNPdQ6TRvgg0rQ/WOYULTmgmWRm3o8UWy0Us1x/Lwd7gNm2T/XfkHCwOInUXvcVRBs//yC9g4UZRItTVtZP58GPVpnhQzFzXMoxmbHInbxE/s7xich7nv0vJSUMaoS7uavoOgr/2aEvsVeNJyKGLOQA/5OOPotEI3dIHOAk37WLQlzUJkwGhx62Xa3r40+/FKVdxt6QspdTl1gx9zr+cu9HaoWe2M5QzZNFnKoPifFaKngtiMp8CxbiVv/JBIT52Is20kxgJPwgHN3WoniVJ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CO1PR11MB4803.namprd11.prod.outlook.com (2603:10b6:303:95::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.37; Sat, 22 Mar 2025 13:14:53 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8534.036; Sat, 22 Mar 2025
 13:14:52 +0000
Date: Sat, 22 Mar 2025 14:14:40 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>,
	<bastien.curutchet@bootlin.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/xsk: Add tail adjustment tests
 and support check
Message-ID: <Z963wAD8HhOKdcAG@boxer>
References: <20250321005419.684036-1-tushar.vyavahare@intel.com>
 <20250321005419.684036-3-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250321005419.684036-3-tushar.vyavahare@intel.com>
X-ClientProxiedBy: DUZPR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CO1PR11MB4803:EE_
X-MS-Office365-Filtering-Correlation-Id: 081546d4-73e4-4c7c-f8ca-08dd6943883f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vU2LgyDfNZPRd9dopYtboqfWJJZSx36LLqe9tsdFMmNyn3ly2UUDwgDtSKHa?=
 =?us-ascii?Q?j0WryIcNv1H//NmLjNtNjHyo143t8tQbdjg2ft3qAnQu277AzkRGov+1feCc?=
 =?us-ascii?Q?uC0+rDEWLoXlApHC2cnqvP9duW+s46VPJt6pOS5p6jEHopP54EBWlaqQuWsI?=
 =?us-ascii?Q?d1sz02rCUtyR1RB7HKJI1bfnapKaeQiCS+H5KYqXhDveyex7a6AJBqtqDkQi?=
 =?us-ascii?Q?zrmfjzxflSkvW/EmfR/Q9kIaAQ6+jbxtussSGIRY6aS1DygJFQcuhERgNCVj?=
 =?us-ascii?Q?ky8VSPECueci8DKV+D71yLH6smDlnMiyXFNKMDNVUd3MS7qXAL/e67cC0f9I?=
 =?us-ascii?Q?uECsfS3FMN42yb2Z1vmGFjdGXWlhvByqUgxtL1hSiDyMnDmw7nzzxXQ81dYw?=
 =?us-ascii?Q?RYq0EtNVNgBScmBRHZLWQ6zhD6EINBuUZraCESQERylybo5/WmV1Iv2QsyyQ?=
 =?us-ascii?Q?O2TZUwpvPU/OaS0mg0XrGAyzuft+kqJ5r7ActQ/duNz8ukR+nVuP5WaljI8+?=
 =?us-ascii?Q?l3Ytx16xpfujebduIvNibP2SrjKi5nqRDLBDX6J7IQyBTNd5m1Xdqf9k0mK4?=
 =?us-ascii?Q?V/Auib/TG3vyjpV4PY+B3LjLLAnVCPdWhEmOxQqpd4Y/Qc1FY9P/GvRVOqJi?=
 =?us-ascii?Q?Qp2/uMiafAEjQsZRMUXK7sdgxTGIfi77JKwacNKascX2HY+dgUOMd0QnWZ6E?=
 =?us-ascii?Q?sVipbULZSTsniC7u8I62ri1lkomb0YgmcUZ4BZ3oXuojx5kf3cbOZDb6GR6I?=
 =?us-ascii?Q?ynvKCpOHQ3Nu1xm7azCAzAeUw/Ai7i52TFVJoXFHFpppcdmjo+fRCBczm7Dk?=
 =?us-ascii?Q?9hu7X8iCymJrOKLpaHYfmYQxneMzIUfXZOz8r2SkQDPvLmykDzR/E6J0JCDD?=
 =?us-ascii?Q?zhd12bRE/+uVMajbFyb01/bgcTluVZY4jMAWlRnc5eV1kVW7P992/a2ResZo?=
 =?us-ascii?Q?9fmKeoCGB+nOWIHOlieNtLujqG3yqs1Ta6OuRzeedx3RpJOd8Qya2yj4QlYH?=
 =?us-ascii?Q?inZHEbLYcwqMz8ZV1pfx1iDxjYndtmuunTYaaRwg5Yq/JPZjj40NTBb8nQ1J?=
 =?us-ascii?Q?8lMSY5gejo5b+EVnWtAwV0W5GqeHkQ0JIxs8e2edei9RsLP3iVpImVjW8F+r?=
 =?us-ascii?Q?31ljFCHkFROFHXyZdVEUFug6jeUd4BM1ul8Cixf/H2Wzft8QvvQJYd+7FvDl?=
 =?us-ascii?Q?uSurrZmhZNFMmnKxWde+NhZbX+rM4FiAQM/Bnz97W5QCU6G+KhAtQ2q26+vz?=
 =?us-ascii?Q?i+orj4QM1SqmRtuhdtkTtD8+BPx9YYfj7eF/VNHeLYQuyuHKXglN2DUhjaQV?=
 =?us-ascii?Q?Zb/Raqyw+CKA4w1e3IM8hBqsuTDbXmu3e3M3umJVSpOega3V1RfDTj6QaZVX?=
 =?us-ascii?Q?wLiOcB0LKpNu/gfLmkiY1ma8jlay?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/z/ziIdoE6mTdI/9RJ1yOzrhyc6IZ7Y3dgBEi9OC5xrIuHqLvWYAb54R0y38?=
 =?us-ascii?Q?6Yd9CTQPuYCdlbwJSTad3CLSPdbA6NGfH3fB5Rj1V5MYU8QNKsloJoCoeEQs?=
 =?us-ascii?Q?79Sa+kGCmH0/Bp2Zrl7EvaA+eDzUp0ZA9PZ/Xow5AIAcmQG49ZOpN4ce7Jjq?=
 =?us-ascii?Q?8tYYS32MT0nJAkXZzQGX0vCQVfElfZ/jgzRHXxeoqYl0JcG34hbAZ4yPUEbl?=
 =?us-ascii?Q?WiOd/06WqTwtPtwe7i+CnDh7UP9ugPK37QAjIDUwdA8ixuelOxhNMr5qqfxZ?=
 =?us-ascii?Q?7nsct8iArCN9PRlgpDhitcvmUDS1tXw4utQy1wcL9d4etwZUiqvBUTm8e4Yz?=
 =?us-ascii?Q?IS+pUxFbGjTODQye5Klbdmbg7GUVBp1tFKFmVkCkNFZT4pC9blu8K8/2BPqU?=
 =?us-ascii?Q?HiJfz0Ljibymta0j3tqzcLcQCoLONWnJ/GUbHHjSOwNfa3I2gBgdEuXsy3AS?=
 =?us-ascii?Q?qzi0prS9Pkb0gO/unPgjvEHcQJHIOVVvKoSokWyuwVbXs9e/hKiod8n2HR5v?=
 =?us-ascii?Q?Wb5orZfRiAhFFFKQVhCnQNMNNBkzTe9Ap4A5kkKsY9uGYesvjO25WDDAQrk3?=
 =?us-ascii?Q?DdhpmtjFK/0Q5LOx51wYBA+pAIt0GgpZ1HEq0dckZ3lMDCzgPkaTS8vBeJ2k?=
 =?us-ascii?Q?Nqr5FkDbWSLLw8xZsDIPyVd0MzCSAdCSlTohJeTEHDpQjqEQup4CVqxvSMk2?=
 =?us-ascii?Q?EW471VxEMX4wgGH7fgiqidqbHLs9UD9OJLNerAEBHmj8FlOKo3MyoBP2Fb4q?=
 =?us-ascii?Q?4QuHXqdpeugy7Y9KSn5UEHQEU4s9pAIDkRf7Js+SHKtbHau/SvB71YstTnP9?=
 =?us-ascii?Q?K2WyuZhpGbrOklAqyRob0SaI4WjMzO8TDr4WW4rnBNqAe9Si8jGIkvg4BMxt?=
 =?us-ascii?Q?x6nOG68JGlbgEz/Nme3qUb/piSiysfeJ3IvaUq9Vh3+iLHOipCrkM3MOSSpS?=
 =?us-ascii?Q?je60QSqXTso+FhwZ9bCpfQuhm6blYC3dVSJCico6uT5pkZqL59lzn3O84MDe?=
 =?us-ascii?Q?Jo1eZcItKNgF9aODvZZDFFp941ZARzGJvOJjwzqjr/78DcmtkkHCluDm2Im3?=
 =?us-ascii?Q?bMVR1afqGlDBQ1LNDbW6DvKrSZyW84FkMfAwzEaplpWtT0oYe7SqRXe/eYHa?=
 =?us-ascii?Q?4vIHz8iS4K7uNDBF5+7bciHvoA36Wyf4hX18Fo5SU4CWnC3UmDZnOmaBWKAK?=
 =?us-ascii?Q?QyaRPBWv74pTIZe7GdB7afymSTdnq8I4jxR5Sb4csPU5q/GHoRb1T19BG7kU?=
 =?us-ascii?Q?5VezHILxBQrctwa844PkqwYZZqmI4dYFgLkoyFB5gLK/68krilJF1vmuYWbL?=
 =?us-ascii?Q?X3iIX+bOfxbM/Hh8cUYZQ1YeeizT5WCVPyZdhRQXHKTBpE8ItvSBC0YfZZpF?=
 =?us-ascii?Q?JcCxOlUjs7fVZK3VD5BAwNceMdf3YtlABFfXRrv0/3gBqz5t6wQKDftZ5yUg?=
 =?us-ascii?Q?T3acseT+c64W23XVoF9at3j+/Xksuy1MFP7OuMFTdsdE970xOKXHqx0C4azm?=
 =?us-ascii?Q?IUK0tIbt13/oC11o13IOuhGOALm/1Jxrw3ctq+TEIU40douOorT79HeT6jeV?=
 =?us-ascii?Q?BwrYYlL+dks28UWX2QV2wmQC9BB3AS2tDeDQiTdjSyZi2ioyRYqReYCE2D1r?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 081546d4-73e4-4c7c-f8ca-08dd6943883f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 13:14:52.8341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoLXCTBkhKiqn8TY/RwGTlGYJkmvmXqzGOpzbK+f9hv5MofapY5r/Pgm0rULMVCpU9fYPzxTDSOGmTrg2L3wTUi3QDZZ27kH/26TJ1ddI7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4803
X-OriginatorOrg: intel.com

On Fri, Mar 21, 2025 at 12:54:19AM +0000, Tushar Vyavahare wrote:
> Introduce tail adjustment functionality in xskxceiver using
> bpf_xdp_adjust_tail(). Add `xsk_xdp_adjust_tail` to modify packet sizes
> and drop unmodified packets. Implement `is_adjust_tail_supported` to check
> helper availability. Develop packet resizing tests, including shrinking
> and growing scenarios, with functions for both single-buffer and
> multi-buffer cases. Update the test framework to handle various scenarios
> and adjust MTU settings. These changes enhance the testing of packet tail
> adjustments, improving AF_XDP framework reliability.
> 
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

We carry the description of executed tests at the beginning of
xskxceiver.c and you have not updated it with these adjust tail tests but
it's not a show-stopper to me. I'm okay with current state of this patch.

Bastien, you probably would want to take into consideration these changes
if they go in before your bigger work.

> ---
>  .../selftests/bpf/progs/xsk_xdp_progs.c       |  50 +++++++++
>  tools/testing/selftests/bpf/xsk_xdp_common.h  |   1 +
>  tools/testing/selftests/bpf/xskxceiver.c      | 105 +++++++++++++++++-
>  tools/testing/selftests/bpf/xskxceiver.h      |   2 +
>  4 files changed, 156 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> index ccde6a4c6319..683306db8594 100644
> --- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> +++ b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> @@ -4,6 +4,8 @@
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
>  #include <linux/if_ether.h>
> +#include <linux/ip.h>
> +#include <linux/errno.h>
>  #include "xsk_xdp_common.h"
>  
>  struct {
> @@ -14,6 +16,7 @@ struct {
>  } xsk SEC(".maps");
>  
>  static unsigned int idx;
> +int adjust_value = 0;
>  int count = 0;
>  
>  SEC("xdp.frags") int xsk_def_prog(struct xdp_md *xdp)
> @@ -70,4 +73,51 @@ SEC("xdp") int xsk_xdp_shared_umem(struct xdp_md *xdp)
>  	return bpf_redirect_map(&xsk, idx, XDP_DROP);
>  }
>  
> +SEC("xdp.frags") int xsk_xdp_adjust_tail(struct xdp_md *xdp)
> +{
> +	__u32 buff_len, curr_buff_len;
> +	int ret;
> +
> +	buff_len = bpf_xdp_get_buff_len(xdp);
> +	if (buff_len == 0)
> +		return XDP_DROP;
> +
> +	ret = bpf_xdp_adjust_tail(xdp, adjust_value);
> +	if (ret < 0) {
> +		/* Handle unsupported cases */
> +		if (ret == -EOPNOTSUPP) {
> +			/* Set adjust_value to -EOPNOTSUPP to indicate to userspace that this case
> +			 * is unsupported
> +			 */
> +			adjust_value = -EOPNOTSUPP;
> +			return bpf_redirect_map(&xsk, 0, XDP_DROP);
> +		}
> +
> +		return XDP_DROP;
> +	}
> +
> +	curr_buff_len = bpf_xdp_get_buff_len(xdp);
> +	if (curr_buff_len != buff_len + adjust_value)
> +		return XDP_DROP;
> +
> +	if (curr_buff_len > buff_len) {
> +		__u32 *pkt_data = (void *)(long)xdp->data;
> +		__u32 len, words_to_end, seq_num;
> +
> +		len = curr_buff_len - PKT_HDR_ALIGN;
> +		words_to_end = len / sizeof(*pkt_data) - 1;
> +		seq_num = words_to_end;
> +
> +		/* Convert sequence number to network byte order. Store this in the last 4 bytes of
> +		 * the packet. Use 'adjust_value' to determine the position at the end of the
> +		 * packet for storing the sequence number.
> +		 */
> +		seq_num = __constant_htonl(words_to_end);
> +		bpf_xdp_store_bytes(xdp, curr_buff_len - sizeof(seq_num), &seq_num,
> +				    sizeof(seq_num));
> +	}
> +
> +	return bpf_redirect_map(&xsk, 0, XDP_DROP);
> +}
> +
>  char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/xsk_xdp_common.h b/tools/testing/selftests/bpf/xsk_xdp_common.h
> index 5a6f36f07383..45810ff552da 100644
> --- a/tools/testing/selftests/bpf/xsk_xdp_common.h
> +++ b/tools/testing/selftests/bpf/xsk_xdp_common.h
> @@ -4,6 +4,7 @@
>  #define XSK_XDP_COMMON_H_
>  
>  #define MAX_SOCKETS 2
> +#define PKT_HDR_ALIGN (sizeof(struct ethhdr) + 2) /* Just to align the data in the packet */
>  
>  struct xdp_info {
>  	__u64 count;
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index d60ee6a31c09..0ced4026ee44 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -524,6 +524,8 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
>  	test->nb_sockets = 1;
>  	test->fail = false;
>  	test->set_ring = false;
> +	test->adjust_tail = false;
> +	test->adjust_tail_support = false;
>  	test->mtu = MAX_ETH_PKT_SIZE;
>  	test->xdp_prog_rx = ifobj_rx->xdp_progs->progs.xsk_def_prog;
>  	test->xskmap_rx = ifobj_rx->xdp_progs->maps.xsk;
> @@ -992,6 +994,31 @@ static bool is_metadata_correct(struct pkt *pkt, void *buffer, u64 addr)
>  	return true;
>  }
>  
> +static bool is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx)
> +{
> +	struct bpf_map *data_map;
> +	int adjust_value = 0;
> +	int key = 0;
> +	int ret;
> +
> +	data_map = bpf_object__find_map_by_name(skel_rx->obj, "xsk_xdp_.bss");
> +	if (!data_map || !bpf_map__is_internal(data_map)) {
> +		ksft_print_msg("Error: could not find bss section of XDP program\n");
> +		exit_with_error(errno);
> +	}
> +
> +	ret = bpf_map_lookup_elem(bpf_map__fd(data_map), &key, &adjust_value);
> +	if (ret) {
> +		ksft_print_msg("Error: bpf_map_lookup_elem failed with error %d\n", ret);
> +		exit_with_error(errno);
> +	}
> +
> +	/* Set the 'adjust_value' variable to -EOPNOTSUPP in the XDP program if the adjust_tail
> +	 * helper is not supported. Skip the adjust_tail test case in this scenario.
> +	 */
> +	return adjust_value != -EOPNOTSUPP;
> +}
> +
>  static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 expected_pkt_nb,
>  			  u32 bytes_processed)
>  {
> @@ -1768,8 +1795,13 @@ static void *worker_testapp_validate_rx(void *arg)
>  
>  	if (!err && ifobject->validation_func)
>  		err = ifobject->validation_func(ifobject);
> -	if (err)
> -		report_failure(test);
> +
> +	if (err) {
> +		if (test->adjust_tail && !is_adjust_tail_supported(ifobject->xdp_progs))
> +			test->adjust_tail_support = false;
> +		else
> +			report_failure(test);
> +	}
>  
>  	pthread_exit(NULL);
>  }
> @@ -2516,6 +2548,71 @@ static int testapp_hw_sw_max_ring_size(struct test_spec *test)
>  	return testapp_validate_traffic(test);
>  }
>  
> +static int testapp_xdp_adjust_tail(struct test_spec *test, int adjust_value)
> +{
> +	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
> +	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
> +
> +	test_spec_set_xdp_prog(test, skel_rx->progs.xsk_xdp_adjust_tail,
> +			       skel_tx->progs.xsk_xdp_adjust_tail,
> +			       skel_rx->maps.xsk, skel_tx->maps.xsk);
> +
> +	skel_rx->bss->adjust_value = adjust_value;
> +
> +	return testapp_validate_traffic(test);
> +}
> +
> +static int testapp_adjust_tail(struct test_spec *test, u32 value, u32 pkt_len)
> +{
> +	int ret;
> +
> +	test->adjust_tail_support = true;
> +	test->adjust_tail = true;
> +	test->total_steps = 1;
> +
> +	pkt_stream_replace_ifobject(test->ifobj_tx, DEFAULT_BATCH_SIZE, pkt_len);
> +	pkt_stream_replace_ifobject(test->ifobj_rx, DEFAULT_BATCH_SIZE, pkt_len + value);
> +
> +	ret = testapp_xdp_adjust_tail(test, value);
> +	if (ret)
> +		return ret;
> +
> +	if (!test->adjust_tail_support) {
> +		ksft_test_result_skip("%s %sResize pkt with bpf_xdp_adjust_tail() not supported\n",
> +				      mode_string(test), busy_poll_string(test));
> +		return TEST_SKIP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int testapp_adjust_tail_shrink(struct test_spec *test)
> +{
> +	/* Shrink by 4 bytes for testing purpose */
> +	return testapp_adjust_tail(test, -4, MIN_PKT_SIZE * 2);
> +}
> +
> +static int testapp_adjust_tail_shrink_mb(struct test_spec *test)
> +{
> +	test->mtu = MAX_ETH_JUMBO_SIZE;
> +	/* Shrink by the frag size */
> +	return testapp_adjust_tail(test, -XSK_UMEM__MAX_FRAME_SIZE, XSK_UMEM__LARGE_FRAME_SIZE * 2);
> +}
> +
> +static int testapp_adjust_tail_grow(struct test_spec *test)
> +{
> +	/* Grow by 4 bytes for testing purpose */
> +	return testapp_adjust_tail(test, 4, MIN_PKT_SIZE * 2);
> +}
> +
> +static int testapp_adjust_tail_grow_mb(struct test_spec *test)
> +{
> +	test->mtu = MAX_ETH_JUMBO_SIZE;
> +	/* Grow by (frag_size - last_frag_Size) - 1 to stay inside the last fragment */
> +	return testapp_adjust_tail(test, (XSK_UMEM__MAX_FRAME_SIZE / 2) - 1,
> +				   XSK_UMEM__LARGE_FRAME_SIZE * 2);
> +}
> +
>  static void run_pkt_test(struct test_spec *test)
>  {
>  	int ret;
> @@ -2622,6 +2719,10 @@ static const struct test_spec tests[] = {
>  	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
>  	{.name = "HW_SW_MIN_RING_SIZE", .test_func = testapp_hw_sw_min_ring_size},
>  	{.name = "HW_SW_MAX_RING_SIZE", .test_func = testapp_hw_sw_max_ring_size},
> +	{.name = "XDP_ADJUST_TAIL_SHRINK", .test_func = testapp_adjust_tail_shrink},
> +	{.name = "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func = testapp_adjust_tail_shrink_mb},
> +	{.name = "XDP_ADJUST_TAIL_GROW", .test_func = testapp_adjust_tail_grow},
> +	{.name = "XDP_ADJUST_TAIL_GROW_MULTI_BUFF", .test_func = testapp_adjust_tail_grow_mb},
>  	};
>  
>  static void print_tests(void)
> diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
> index e46e823f6a1a..67fc44b2813b 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.h
> +++ b/tools/testing/selftests/bpf/xskxceiver.h
> @@ -173,6 +173,8 @@ struct test_spec {
>  	u16 nb_sockets;
>  	bool fail;
>  	bool set_ring;
> +	bool adjust_tail;
> +	bool adjust_tail_support;
>  	enum test_mode mode;
>  	char name[MAX_TEST_NAME_SIZE];
>  };
> -- 
> 2.34.1
> 

