Return-Path: <bpf+bounces-33960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E016928A71
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 16:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DF928672E
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 14:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941B41494CC;
	Fri,  5 Jul 2024 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y4uigKUc"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E731494C5;
	Fri,  5 Jul 2024 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720188863; cv=fail; b=iTIekZTmgoNDaxO3Lk5ck+5+2H2EzhVrdcRv0a+34CGcztOEhUNPoZPMp75niQF3OQSEDqUa+X66cedLfG/JHS3BDV+8SpXiOM1KTyt1eXNW7qstNHTMfmT00bJ6Eph4UDxSeRSXeeknbsGGU4W+5N3kidLwyrTz3Qe0d7Cm3Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720188863; c=relaxed/simple;
	bh=o2+95vC0x6cbWLz92/pyAy9itEbc05hW/cVERLW6ito=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J1LqQhWtH2SYXgs98neNLAkaWPHEX24ZOif6jt161bK1H8XaGPnlDaPgV+a2o1O9YhJ3RtnO5kYVwGhSYhU84zRAIwgpI0BUxvmA4aUwKueY53muJ+k9/xFTJFJj+DwKTYkEvEtnHWRE1Aj90VH5InDWjDgkSYr9OBPsKUvNKUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y4uigKUc; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720188862; x=1751724862;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=o2+95vC0x6cbWLz92/pyAy9itEbc05hW/cVERLW6ito=;
  b=Y4uigKUc8F6vyu1vg860a/tbu9XrVNFiDwGOw92po2ZLdNj2u3HLQUc9
   CdFZcbI6Qfpj4+fTaQCGRxQN7z1RkaCevKMLL0lCz2FZIctRKvKpR1q1i
   Xnv2wgesHKjrbsGEpAUNzR9KvXIMB4gvA/T3pSfyqGYUwktDQJXxIWjFm
   YnnmLSek/qqeMakW/jrYpcG9n+UBfaOuaTPZsAAfmOsNsnNni4hHOHgaU
   ea7W3UA/Dqth52XFid+vbJp06KzlKKFzDujskXm+o3N9e7L70emm/MZXq
   EIfWZoFscIzdydWTUVU6lqijKKGNAedpMCG9ALFfF7DjLS971Fk77V+2n
   Q==;
X-CSE-ConnectionGUID: dUCax6PIQMKeE4B2Z4Qkrg==
X-CSE-MsgGUID: /C+SApwwQwWWVLVPwBsWrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="21354462"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="21354462"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 07:14:21 -0700
X-CSE-ConnectionGUID: wA8OdM2yT7uKQeO3MYzQpg==
X-CSE-MsgGUID: mpqgCimtR/y9scqOb2FlCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="84443064"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jul 2024 07:14:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 07:14:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 07:14:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 07:14:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eduDABFB9h/h7sfEAkd2xTOS0Tpwm5LB+CaMGu8OCBinqzdx9EWdYWM7mQG6IER/TVaoVu7XvMtyXzSoRap2hupjc0hjQ7gdWrew3CFJL904E+C9tXLFNWPzmqadAtcuvPDpeGlgFRpHetz9r2+NiPv5JRI6QqFQwaQy3whGeRoQRa8mFjRVgWawYrrwXEgyypvP6sdH7T3m9gewe3l01KQMzlN3loK1h4w3dvvAXUgAFx5JdiWhmOBA7qIJh2xBVDjBjD9I2xzCuT8yoiEWHQs/NKz6A5yYC7BWx0Y5xwbVHN1Yehzq8B0RS8+kNVM2RTqsZfdVbuBQE5nh7WD12A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3PNm1WrtzsSpHq2uwypVEu5yVPqAabxdU7CXwlRgYo=;
 b=FGKzWUNc8GbHTI0CIp0kzGQWljYPfI2hgIUFvdPilLFbc/bvaId4BVK+jcT2VHmkk96SQryffZRKmyevNFG3cqcuKdEfmnW+PCNPHTP5zbHo007DQLjOYNtKK5GqmOPEypSUf9OALRwiMW3L3jC7WmsKIocA4Wav6/zynrn/guJ6syp8/X/BaMhwDK49dB7RBSh5tB2iYjx8LPrDsJ2856jzr9AYG6yLCPAszJlzAMWnCIokNs9Q+oq8uwDrcPS0bVDm0t3NX2R9OKNEPAZtRrw42s+zCZ3vGyheyaGdWlRti8vOaDMH7v41hoXSgRNQJMPDBcJa8baYfh/Oq5X99Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Fri, 5 Jul
 2024 14:14:18 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 14:14:18 +0000
Date: Fri, 5 Jul 2024 16:14:04 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: <netdev@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "Jason
 Wang" <jasowang@redhat.com>, Eugenio =?iso-8859-1?Q?P=E9rez?=
	<eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, <virtualization@lists.linux.dev>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v7 00/10] virtio-net: support AF_XDP zero copy
Message-ID: <Zof/rP1Tn2bsWYBO@localhost.localdomain>
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com>
X-ClientProxiedBy: MI2P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::9) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|CY8PR11MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: e425511e-9e79-4ee2-2a96-08dc9cfcc1f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9a2ne/pgSwkVno72sRxcsznrVR4leMgQpKcVh7wUuIGnh0dqADd9ZfEm+95c?=
 =?us-ascii?Q?VnqcdAfXCEkcSCKXQ7+YxhRw6blhZIKO16aNhu4s7DGnLrNSBPkC5/OHrKu/?=
 =?us-ascii?Q?BT5qEryuSQbFXttTri++MvvofON8eA6XDb94SFbES78Uymx9Xuw1ZJv3uPDW?=
 =?us-ascii?Q?WeAJI3D1epJzkroCo+SKx7jaBkOvgRf53iRYG/dNXFOhIBziL6V/UcD4V5/X?=
 =?us-ascii?Q?sONToQoI2gU+K1FIj2gliJSN/NDcC1trDH5Q2IvsHoRb4il5hW6FGG9iLK0H?=
 =?us-ascii?Q?nofWXgqAF8KP87S/rOGeXA380jLdFQPnq5k1G71Bg95lyNqz1o+XaBm+ztQK?=
 =?us-ascii?Q?woi5yj4ue8P3DSqGPrb4VHwkhzDNfGhe6RR96JbH7SzVlNkxIpCP7nEiSw+R?=
 =?us-ascii?Q?0xbZROTY70HiTmGAUa1ZtdWXyNC6vM6xzDNJopJTX+hal9kFbzy+y0vK0nnq?=
 =?us-ascii?Q?c0gG8DycGF0Z6idYIF3AZq3/tjK8bA0h4a7LNo3N93+EUAYeeu+xbTbgU2b2?=
 =?us-ascii?Q?UWTzPcfvGz4kvl7lnqA4DNeQSgbrU7zSwy7qpjRcHbOvdMgfCGW3ln4YoC0K?=
 =?us-ascii?Q?1HdXPp3S6dl0LSXjGAo6nqu1/bN0bgcuKBg1nRyzxiBo8eNxaDhG72q5Budt?=
 =?us-ascii?Q?Zsd6CW3f7otwpKq2VKPjP9ywN4R2ugFmmfCsBASRbCmxO4B6erwjIlplHFbm?=
 =?us-ascii?Q?FKbLvi4raWdwJStYLJNBrNopOJAl+0nQCHWYtb02AfhiyprN8aNa46K9u78P?=
 =?us-ascii?Q?hICLx3Pbu52hs5ATTnFrZIkNinALZwj0t8rEx9cgVw4TwJMMt3HmKke9Mgnp?=
 =?us-ascii?Q?+KE1zuhCZrBaO8EZa9jTqABvdiuKBL2sThGFsoOLV9z2mhnq3OHLy+trunOM?=
 =?us-ascii?Q?KBe/1Gy7nz3QdhJotXFXT3W8Bf31etjrBQsvW1F3XsVqMrWuPj4ED/Pt/eqV?=
 =?us-ascii?Q?4g++4t+wxXOZO5MKv1H5puOB7H8iR0W/kyHKao+ekdbGsUSHQnfTT+yy8PNY?=
 =?us-ascii?Q?3Kd9cM9WeAiD9sc0/Ii9bVtxfgiLhg0EflD9tc8mDTVRea2xViIn8K0ZJgLj?=
 =?us-ascii?Q?Cl9+Gv2Z1rYWGPNOF8FluRILMwFmwNHAFdFRte9RKgk2tgTEbyff5xg3l3h8?=
 =?us-ascii?Q?lHcIGGiSIjeX6JEuIGfWT6qObeqlc9eEjiCQpIXfll5GgEdXWjUtQJg+JDs3?=
 =?us-ascii?Q?RBO4iYdi8IWhl507MhqMKf+OrK+wc345xxb/EY44mQM4iVFa56E378ZxLas/?=
 =?us-ascii?Q?pMArSJ19T29LDmHUBrk4C2MhHiHybmg0hA+KOyECurM16emsMS0xA4QkEA8k?=
 =?us-ascii?Q?g/Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qnEQGk8bHgaIz+SyWgSisyLnmROk2EmPFridqrvdXDqUvKsSwEvFaNihXFys?=
 =?us-ascii?Q?uVHYvOqG3ClTUYqY8f+T+URmKU/9l2kXbf7VooRHxGCQRVN6zjEHJALxmRH4?=
 =?us-ascii?Q?AE+ZA4zH6aCzvsxBxXUd11mv0C1VK89vUHpsgkr1OeCyzM00sNV95c/sQCm8?=
 =?us-ascii?Q?vL0mwfytzdlRSO/837xlRPskYsGLMSZZf5FjT2dpQQDLXc99dO+rROW1gyO/?=
 =?us-ascii?Q?7zKn0gooEURjqGPqVe+TutRos6oSyplmAKJ06C8fytkjVQiTMOWIV+H/KBJC?=
 =?us-ascii?Q?dMF4QDOWK3ZeR07juMJs/Uryoi7DeuktdAfDomtWYokfM7Xz2Vg0GCrwPUzL?=
 =?us-ascii?Q?STqdxikrVnupSOhg9TdoG4OwZ1xAjaDGBAPsVb0nAO8MAkkvBgVPxZ6EXp0/?=
 =?us-ascii?Q?uZO34nR1wB8BumXAuCf/adxXmsW9rYbcJCFSev9q0QWJp79ldakiZy/Hw/4g?=
 =?us-ascii?Q?Rn4AxgfXEJl95uNq1u+KCXqsmQ3i6Dykia0nNhTgAYzFqDIRYBCpqJ1McNd0?=
 =?us-ascii?Q?xuGtzoA1dxI/VIoO7bo3FZRhpklc4yco/LwGO+cej3TSkEUQED70r/EHg92g?=
 =?us-ascii?Q?8MvcgbyaESKUju/7hw+xZMp4I3vGoMjWLJ7+AmbicZ1TVVH6pQE/qcKGBIfh?=
 =?us-ascii?Q?nfBotjPrT499ibqg2xFPU2G6+Y1/oYycwIAimQ1Yz0LNs5Tr83LGaQOb/JBC?=
 =?us-ascii?Q?cqidbWeX1mG2apnSdrblTK33v2KqRBQz1A8aKyvKY7sl9Iqx6AFG6NGK75un?=
 =?us-ascii?Q?qAUXdELUZcpYusYVFX5cKo7eRZkCTA0TM3Y/pCCaNgvuH7EbjHATZbeyDCYJ?=
 =?us-ascii?Q?HnbJS4dLXCbtueQkl0+oqdg1OyN76IltDmlAA34nflfSr9SfrrfZ5WHBvqiw?=
 =?us-ascii?Q?ZWASdHOeamjS11fyKE603q3N8jKwjiwxhtjw1vp7aLBhjg6q1vf7837f+/0I?=
 =?us-ascii?Q?uQOF2lbFZbKYSbHmnMUhB6WXcntepM0E+LVv5YtMQuFFE8dvFtBKbX0+OhQW?=
 =?us-ascii?Q?PPu+4YXqczfGJ0NEVc97x4H5tBSzsFU9kuctkGvKkZr4AWTir94/JY92qMRU?=
 =?us-ascii?Q?eNX6WXfdUNZE6aczDlY+y7A/+GRdnvpP1VzmjH5d34kF3l+wYSWhiMlLpeob?=
 =?us-ascii?Q?+WpckoacWFEBFYpUg+QzXLbG/KrxmryQ5JpYI0IANuyyKQrw4GtkMFixcZLZ?=
 =?us-ascii?Q?F73/jL0JQrM8sv9+NcitbzVxHKJEX1V/U9NxQJf8ZW4vzB7SW4zZt3qkvk1A?=
 =?us-ascii?Q?iMTjxrIWILP+eqJKz8Kj98Q+GUwD9iu9wV5Ah/aihujzTTbpY/N6syvRv2WF?=
 =?us-ascii?Q?L4gnrK3GIPbcuJrh4Rcy325pOneVr1Koi4uWmIeHj0zjD/8s7sVq4hdoLU7H?=
 =?us-ascii?Q?mqCWYkFYwv3hI/oiUa4vttJ/fUv07eCIneM4PHaGtBpXyzNcD1CUQW47gb0y?=
 =?us-ascii?Q?FCKA2X26cE/ISq4sUhTFl0T7+0kB0NVeqFYGzsnwtFkkeDi36aGG1SsSLCeb?=
 =?us-ascii?Q?iYT+xBniMmVPWrMBRkNMlKui+46YdrsuS9xd+9QuPk0GHoPDFb1uBpq8A3nE?=
 =?us-ascii?Q?A4pqLT3JgxRxldEIOPrbuS+my4UdI4gQlbh37PgQSH/jSm0MCKmJNOlkFevK?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e425511e-9e79-4ee2-2a96-08dc9cfcc1f9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 14:14:18.1420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sa0iiwiC3Ws2i/uWItHEyO3m4iaeUNf4GP+m085AGvOphjd1X+2OTPzrbw+mOOzfyb0S9KBfCNnRU8pGpLPzbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7846
X-OriginatorOrg: intel.com

On Fri, Jul 05, 2024 at 03:37:24PM +0800, Xuan Zhuo wrote:
> v6:
>     1. start from supporting the rx zerocopy
> 
> v5:
>     1. fix the comments of last version
>         http://lore.kernel.org/all/20240611114147.31320-1-xuanzhuo@linux.alibaba.com
> v4:
>     1. remove the commits that introduce the independent directory
>     2. remove the supporting for the rx merge mode (for limit 15
>        commits of net-next). Let's start with the small mode.
>     3. merge some commits and remove some not important commits
> 
> ## AF_XDP
> 
> XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> copy feature of xsk (XDP socket) needs to be supported by the driver. The
> performance of zero copy is very good. mlx5 and intel ixgbe already support
> this feature, This patch set allows virtio-net to support xsk's zerocopy xmit
> feature.
> 
> At present, we have completed some preparation:
> 
> 1. vq-reset (virtio spec and kernel code)
> 2. virtio-core premapped dma
> 3. virtio-net xdp refactor
> 
> So it is time for Virtio-Net to complete the support for the XDP Socket
> Zerocopy.
> 
> 

After taking a look at this series I haven't found adding
NETDEV_XDP_ACT_XSK_ZEROCOPY flag to netdev->xdp_features.
Is it intentional or just an oversight?

Thanks,
Michal

