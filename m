Return-Path: <bpf+bounces-37505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C728B956BBE
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 15:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFF928424E
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 13:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FEF16F298;
	Mon, 19 Aug 2024 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWk5RGTL"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D2216C857;
	Mon, 19 Aug 2024 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073614; cv=fail; b=hCZX/wEOi8khbZECfJ/BjofukrT+iPlYQZre5aWj/ARFaMGjed6LCiAhXqzWnzSp2wlQ9lV9zAgorgXNI4RnAUXA7CsOes0GvRtcZzt5qmBTUrxtdJDt7Zf/31CNmq93TIs7/uTiBmQ6IovX0PHjvJ3kHB0E1XA4f0APSunhDGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073614; c=relaxed/simple;
	bh=xBdj2T/vzHtEWfSwaUt2EtENoFawOoK5zCYkDtrbceM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uas1AXo5MFU2H48NvvzkOuMVwpjuZq/KIjrXkej1fm7zSYBkelP9YDXVxgNm1L6zbK5AXhK4HawawHxLj/NpcIcIBcF2RD0jGnzwGPbj8yEVSRoPo3pTC/EeD0/BiTQzZ4eyat+vI+IBzkVai+oimg5DPXwe723KuLIoPFz8h8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWk5RGTL; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724073613; x=1755609613;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xBdj2T/vzHtEWfSwaUt2EtENoFawOoK5zCYkDtrbceM=;
  b=QWk5RGTLSbaOuYxtOibWFkegVh1SG5v2rVjw1Hh7fGLhk8U8okBn8B/X
   gR/ofTlX+wbwn/ZBuJ4Jc0QPpY5+0QSOtpVnFz03a5NpyQmkM6np7kjUs
   0mf4aZ8jnsTlFFPifv/btLpuIkZVvesVYqsEiLur9jdYJ0/XejweWaUre
   b/hYgaTjtJmEG406z1G35WwSq9Hhc4SVQvm+FDTjAImGZ4O9altlMHUUa
   jbn8MQ7mGDe7AWNxr+nQtZ6QpyWHzutEzP5PAUpaw1pAQL0xnbdjd7I3l
   sdlrh+Ze2PEAnQYFK52lGhWOyn9V3z16GENRte3q5AO1jvEboC9P6KUVW
   A==;
X-CSE-ConnectionGUID: FrTIqReWQFiS89zOW+OdSg==
X-CSE-MsgGUID: fhoUrM4uQ2G1bcDreKb6RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22289395"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="22289395"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 06:20:12 -0700
X-CSE-ConnectionGUID: s3FddzGQSke7JJdzQ8sIVg==
X-CSE-MsgGUID: j4HzbIEPRTKqcbNGmQD7jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60948302"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 06:20:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 06:20:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 06:20:10 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 06:20:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVMV5I6fhRRDy7CGc6YExjUKFaS36hPRtIItvLIlFTdBbCFxRk5ZbEBVbwcSekm0czyvAoKTK65cIJMcI0xvt0CkYAI4W+7qjLoUI9LyVwGAmGATSov7Be+OqLnpuwX9ZZMLwcQEPWA3GZcbEnuACTOOQrkNklHUNOle2w6uJ8Bql1CEgpxySKEP9yAwPH90QE4+3lOJGOMz3t21yTu1B6HqEKOWo/XtTXu+Q1T75v3leNzIIyRE+CTo6dRi5l2pQW11TJQJO5S2EP9ddj0+IVLptrfIF6ew7neQb9e1HhF+GCamNA7zZtF0DHJ/DThvzFBPZsyajxCrZFvJCMY5DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=327gZP345rp+c6LR5a7qlYTlIPWtKfEz8FCaxRyyZZs=;
 b=wR3hPIpT1wo6EhH2EQc+HRyCRK27ndJ2cx/3ejYvVMKG3mDTYC7gSUXDlCrTDCxoqTaE14U3e1Kv+JhgMTpHNA9Ezp0rgD0SM87fzz9KQjzRBIVLcRFnlOnSzfZK9P6ijN245alSFHnOb6uGGc+MihXNrvM/qAoIjcZyQLUeWaC6IMSGyvXdBlUKNv/bJEGy7aswlglb2vsmsehWLJOiYtdMkGTzONkvDEk+5S7qaY2tnKBey6DZFfTFZRNxFUgA3Z4NLx/TAWPm7lPZc7eTmb75KNtMl9hpA2hmq5jPSiFoVyJkQikbaAB76JnVAyK3d+mmtO6wafSmFgmGtBmlAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB6321.namprd11.prod.outlook.com (2603:10b6:208:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 13:20:08 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 13:20:07 +0000
Date: Mon, 19 Aug 2024 15:19:59 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	"John Fastabend" <john.fastabend@gmail.com>, Richard Cochran
	<richardcochran@gmail.com>, Sriram Yagnaraman
	<sriram.yagnaraman@ericsson.com>, Benjamin Steinke
	<benjamin.steinke@woks-audio.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Sriram Yagnaraman
	<sriram.yagnaraman@est.tech>
Subject: Re: [PATCH iwl-next v6 4/6] igb: Introduce XSK data structures and
 helpers
Message-ID: <ZsNGf66OjbqQSTid@boxer>
References: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
 <20240711-b4-igb_zero_copy-v6-4-4bfb68773b18@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240711-b4-igb_zero_copy-v6-4-4bfb68773b18@linutronix.de>
X-ClientProxiedBy: MI1P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: c4db995c-d0ef-4dea-8c5c-08dcc051a4e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j7BOWv3L2O8H2vPmZ8AV4RNtOmzzbcgmWQK/tHAZm6Iw349605zJq66Mkgcj?=
 =?us-ascii?Q?tf5IVs6zbgX/vR1N56F1+M0x51NuvvRycGd4OwvBVqN+NIfXZhiGOkKPzUn3?=
 =?us-ascii?Q?aomFI51iFkTaQW6FwLDxi8n09zu0UBpDbOehNONXBlbjybsdpz2q6xJi4pM1?=
 =?us-ascii?Q?e0DCWIh4PNiis23iGz/XB635EFFKnkiDu1NoQetD80iDOLmlcf5EGnEG6cSJ?=
 =?us-ascii?Q?StA3LwUmG0YhTvUGTUdCgzq0YlLVhvGOpcjiUQqazD5Hn4XdxAYpzCTEgHNl?=
 =?us-ascii?Q?ioP9YvTlUnGWgcMsCAzvccekpIPD0Qx+Mr3/QhJ1rbUC4WyvdvXA1Ztg32rg?=
 =?us-ascii?Q?JAGyq1UYaQ43qbjdafU9Qr+a/VXeV4XVyyJMzd/xFYlIwDUFxm/dDWR1CXKX?=
 =?us-ascii?Q?e+P4cGmt5Jc2O3t0A7obcWeSgaClCeg4TpB2yVJRBRXcaGXLV1BM2yZaFKXF?=
 =?us-ascii?Q?z7KOu2+jjbMoJiiXXvjHznf+QUOjtqF3WWEC5Y85oGZw+X9lGFeLAErKwLIR?=
 =?us-ascii?Q?R59Ys28/tmq6ovq0iZGkGhuiQ24flQQvmbrqFdbZkgMlM/cqBMKF/A4EC5NU?=
 =?us-ascii?Q?oN3vrcECTLLNUM2oRr8Zl5Wqdn1rf8vp7wXYSLqR1ZKw9y3z3nZd0qH3lKML?=
 =?us-ascii?Q?ZwovASgkA+PI0WuikzyJYxxc8uUtB5QEXNLuWT6/gfxfRtoHaWUb01h4KYhF?=
 =?us-ascii?Q?wLo8bm4zfjyh6Ip7vrf+X13ZrDvAcjMfSo68/CqNmctvuplQ8DdDzt4g6xis?=
 =?us-ascii?Q?G8QbjLyYY0GLUrSX48bPoF7a7J6XsD/o8o2cV6ZRWnWibPip7Q+DhCBg+gaH?=
 =?us-ascii?Q?KQ1iXMhClBBy6ESC2osr8sbfcV00DxFdBT00IQZnHXAnpvc1gh5NzR2SqXE0?=
 =?us-ascii?Q?z4tLnfByrcXAGy8vHsfaBMAEm/ZQcBrQWzxE8ajEOLKmM9j8NNcuIpnrrrkK?=
 =?us-ascii?Q?JyqaZhlBCypIJ3E45hZ6wqCE2giXB03I+v61bwhDqzqPPBmC6pO1plD52D6c?=
 =?us-ascii?Q?OTCKsKYnpl7BR/SziQi1fxQTBu0w1H4MaZh8TtGKPQTkBT3q5ks1LCBAPeZY?=
 =?us-ascii?Q?znZKDtZwC2z1g42PkcENccPFjvThs/ajVSJ39buopQrZNG/57Ks4RSrEjn7k?=
 =?us-ascii?Q?CymNu9P2mhoE5VSoZOjMsqEklVJDYXfRVBHZRfJeLIv1ZdGHekrGWcmpL5Uj?=
 =?us-ascii?Q?Vbh4xMQGorucnj55vuF5CIBrqf9VEcs0UrHyqSstRZkwKGcuCf8ScI/68lkL?=
 =?us-ascii?Q?oGOPrsNkixz1Q+sP+n9bCt0Jf75dX/E92QR/ReMTGCKTajT1wYySKGS2p4Oo?=
 =?us-ascii?Q?BAh6d157iVekals3FtUWMwlGNYHQ7p09gLHB4c7SWdinuw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5XxtzEHHgF3rz4onsTezG+vZWfGD9djSpBzvPByBJoLK54/59Erv4gnw14Zi?=
 =?us-ascii?Q?XYvlKz0N5tDuu+8/B5GQsdTW+gxI3GMoOBgSbhu895W/4v7qz4HEVPsACsJx?=
 =?us-ascii?Q?gwYnpr6L7JveSAsEgmm8mgycnziQtv3diH1C+3dPlb/EC1TCV3b77XM1f5Qh?=
 =?us-ascii?Q?s2o5ds7ZWV2nIiEd3aUfuF2fJomjitGRtvcfU9Bipd1EF6f2QH/EMiKH4LXU?=
 =?us-ascii?Q?D4QjBrVF88KvWO9+jY41ANH9S2OAZsmwr61bnQ2DswmMB5K51gXyR86SkZyF?=
 =?us-ascii?Q?N2SznW2mgrCKMjuJGB0M7oWm0RWDtyfN2yDS4rLC9LDDxQoEJRDujuMiTwyd?=
 =?us-ascii?Q?OeEGNuBEh3Bie5m69949j1S7Y+LhGLSlM2AOelOdTdt48SqViIZYjC164njM?=
 =?us-ascii?Q?zVe2NvCUHQcQfw9Z/pCg9e7v/JW3dKPU41QZvwPOsiHhavNpJyhgjLTBosHc?=
 =?us-ascii?Q?SJQQt9KkrmHEeiLoHbnrcbsze/92c00N1QJj3ioZmxPsCo/E8fdG5XSnHkYN?=
 =?us-ascii?Q?StJjghcaV47FH+4C4uQey/SZMKSzUKumUlcdtSjR6XIBkw73xEE/Qw1DWJba?=
 =?us-ascii?Q?elW6a06mm/0DYlIpovZBAAA/bV5nwGRkzYxn0FOx/br73IIMykpWNvFiYifa?=
 =?us-ascii?Q?SXv6IVPbGRXYSmW0aMTMOzPHbRVyHqPAyw0kK/eMtkYKI7xBtLQaVIX6P330?=
 =?us-ascii?Q?wkuZwXPRopM+HvV0biK0WdgjorsGvq1qQBWUiAlzLzMMCTmMmVKS/oz9l7pN?=
 =?us-ascii?Q?e+P4sDzZjUKWjkqoHw1Eybn4YuLNmAMCCeW+z+gR6KpqeskjEgha5SweF1oj?=
 =?us-ascii?Q?rRpMpnCdoCQ9IuPeH32PSZVw/oCzyW+n525BTSQwZ86IWUUBkShxI06DvqRX?=
 =?us-ascii?Q?0GuSf4tSzFBoDMs+c7+3PtPFdMrHVPzgVvm1jw7dd7AmTTvKGx/wv0fQ1AAb?=
 =?us-ascii?Q?cA1U1jNgbtwBe3BX3C/efFz84XFbjs/0pZCuSlQX3LIJ6EzqQOOHyy5rjCPy?=
 =?us-ascii?Q?npAKZ5SwjAS3ozVHpjD4J7kbCAxczBeOgDdDfw7jOeADrwJ+p+xptItw+qmD?=
 =?us-ascii?Q?gFZVJsSZrCGiqoU5nrqPuAAvP7s51/fm4KAGXt47Yqicbr/W5hSAE+QiwwPd?=
 =?us-ascii?Q?VzuCQcIgWAiKbomCzfx8I2copga+y6Wb4STCl3K4sSt9UN2YlaG1NuAPN/Ew?=
 =?us-ascii?Q?kihQmXlJvQMfOgPF2F+ybasWEn+pL6RNANRuBIqfhMyMVeVM/sojVrzCdGnZ?=
 =?us-ascii?Q?WZIlU/KFpgjX/AXCrnuAx20Jt7Xgp6G2kh2N04Ysn4F1zVyr39Q890ZXevlU?=
 =?us-ascii?Q?+9BHmUb+3CFitiyPF8A0X5DIAV6CbmC0pYO0Gp7k9faCd4LDA3AEL19tKVXR?=
 =?us-ascii?Q?IHDaNP7us27Sx/4FrJdoytj+u0WCRe0RHGFDD7i7xqxtyB4sFhP8UAjT5Bpx?=
 =?us-ascii?Q?gXAh6fOVye5EkT126R3UmtVrvMByG/oeNMG2FDDlo7yo/o/mZ8d1SV3uyH/E?=
 =?us-ascii?Q?olginIOrYnBX3r/ESUbp0TNR7+BjOphLSU6/d9/G5ldSv+wfk/X/C85KRD7H?=
 =?us-ascii?Q?0xd3edj8DUMenJtf6HLlTLcMK77GSmbaa6RKurN1cUN1jMLyItac4f5eJHKk?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4db995c-d0ef-4dea-8c5c-08dcc051a4e9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 13:20:07.3681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRZm3Yl8o0pGH76iitIBFSO6NFSvjrTrO4+toH+bCCM/20DXZtMiJOPYExp5++yEJoy3kRe3m18vcQvupE48Y89kgJnvF4NhYqycSg5krKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6321
X-OriginatorOrg: intel.com

On Fri, Aug 16, 2024 at 11:24:03AM +0200, Kurt Kanzenbach wrote:
> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> 
> Add the following ring flag:
> - IGB_RING_FLAG_TX_DISABLED (when xsk pool is being setup)
> 
> Add a xdp_buff array for use with XSK receive batch API, and a pointer
> to xsk_pool in igb_adapter.
> 
> Add enable/disable functions for TX and RX rings.
> Add enable/disable functions for XSK pool.
> Add xsk wakeup function.
> 
> None of the above functionality will be active until
> NETDEV_XDP_ACT_XSK_ZEROCOPY is advertised in netdev->xdp_features.
> 
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>

Sriram's mail bounces unfortunately, is it possible to grab his current
address?

You could also update the copyright date in igb_xsk.c. Besides:

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> [Kurt: Add READ/WRITE_ONCE(), synchronize_net(),
>        remove IGB_RING_FLAG_AF_XDP_ZC]
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  drivers/net/ethernet/intel/igb/Makefile   |   2 +-
>  drivers/net/ethernet/intel/igb/igb.h      |  13 +-
>  drivers/net/ethernet/intel/igb/igb_main.c |   9 ++
>  drivers/net/ethernet/intel/igb/igb_xsk.c  | 207 ++++++++++++++++++++++++++++++
>  4 files changed, 229 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/Makefile b/drivers/net/ethernet/intel/igb/Makefile
> index 463c0d26b9d4..6c1b702fd992 100644
> --- a/drivers/net/ethernet/intel/igb/Makefile
> +++ b/drivers/net/ethernet/intel/igb/Makefile
> @@ -8,4 +8,4 @@ obj-$(CONFIG_IGB) += igb.o
>  
>  igb-y := igb_main.o igb_ethtool.o e1000_82575.o \
>  	 e1000_mac.o e1000_nvm.o e1000_phy.o e1000_mbx.o \
> -	 e1000_i210.o igb_ptp.o igb_hwmon.o
> +	 e1000_i210.o igb_ptp.o igb_hwmon.o igb_xsk.o
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index dbba193241b9..8db5b44b4576 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -20,6 +20,7 @@
>  #include <linux/mdio.h>
>  
>  #include <net/xdp.h>
> +#include <net/xdp_sock_drv.h>
>  
>  struct igb_adapter;
>  
> @@ -320,6 +321,7 @@ struct igb_ring {
>  	union {				/* array of buffer info structs */
>  		struct igb_tx_buffer *tx_buffer_info;
>  		struct igb_rx_buffer *rx_buffer_info;
> +		struct xdp_buff **rx_buffer_info_zc;
>  	};
>  	void *desc;			/* descriptor ring memory */
>  	unsigned long flags;		/* ring specific flags */
> @@ -357,6 +359,7 @@ struct igb_ring {
>  		};
>  	};
>  	struct xdp_rxq_info xdp_rxq;
> +	struct xsk_buff_pool *xsk_pool;
>  } ____cacheline_internodealigned_in_smp;
>  
>  struct igb_q_vector {
> @@ -384,7 +387,8 @@ enum e1000_ring_flags_t {
>  	IGB_RING_FLAG_RX_SCTP_CSUM,
>  	IGB_RING_FLAG_RX_LB_VLAN_BSWAP,
>  	IGB_RING_FLAG_TX_CTX_IDX,
> -	IGB_RING_FLAG_TX_DETECT_HANG
> +	IGB_RING_FLAG_TX_DETECT_HANG,
> +	IGB_RING_FLAG_TX_DISABLED
>  };
>  
>  #define ring_uses_large_buffer(ring) \
> @@ -820,4 +824,11 @@ int igb_add_mac_steering_filter(struct igb_adapter *adapter,
>  int igb_del_mac_steering_filter(struct igb_adapter *adapter,
>  				const u8 *addr, u8 queue, u8 flags);
>  
> +struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
> +				   struct igb_ring *ring);
> +int igb_xsk_pool_setup(struct igb_adapter *adapter,
> +		       struct xsk_buff_pool *pool,
> +		       u16 qid);
> +int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags);
> +
>  #endif /* _IGB_H_ */
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index db1598876424..9234c768a600 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -2904,9 +2904,14 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
>  
>  static int igb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>  {
> +	struct igb_adapter *adapter = netdev_priv(dev);
> +
>  	switch (xdp->command) {
>  	case XDP_SETUP_PROG:
>  		return igb_xdp_setup(dev, xdp);
> +	case XDP_SETUP_XSK_POOL:
> +		return igb_xsk_pool_setup(adapter, xdp->xsk.pool,
> +					  xdp->xsk.queue_id);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -3035,6 +3040,7 @@ static const struct net_device_ops igb_netdev_ops = {
>  	.ndo_setup_tc		= igb_setup_tc,
>  	.ndo_bpf		= igb_xdp,
>  	.ndo_xdp_xmit		= igb_xdp_xmit,
> +	.ndo_xsk_wakeup         = igb_xsk_wakeup,
>  };
>  
>  /**
> @@ -4357,6 +4363,8 @@ void igb_configure_tx_ring(struct igb_adapter *adapter,
>  	u64 tdba = ring->dma;
>  	int reg_idx = ring->reg_idx;
>  
> +	WRITE_ONCE(ring->xsk_pool, igb_xsk_pool(adapter, ring));
> +
>  	wr32(E1000_TDLEN(reg_idx),
>  	     ring->count * sizeof(union e1000_adv_tx_desc));
>  	wr32(E1000_TDBAL(reg_idx),
> @@ -4752,6 +4760,7 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
>  	xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
>  	WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
>  					   MEM_TYPE_PAGE_SHARED, NULL));
> +	WRITE_ONCE(ring->xsk_pool, igb_xsk_pool(adapter, ring));
>  
>  	/* disable the queue */
>  	wr32(E1000_RXDCTL(reg_idx), 0);
> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> new file mode 100644
> index 000000000000..7b632be3e7e3
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2018 Intel Corporation. */
> +
> +#include <linux/bpf_trace.h>
> +#include <net/xdp_sock_drv.h>
> +#include <net/xdp.h>
> +
> +#include "e1000_hw.h"
> +#include "igb.h"
> +
> +static int igb_realloc_rx_buffer_info(struct igb_ring *ring, bool pool_present)
> +{
> +	int size = pool_present ?
> +		sizeof(*ring->rx_buffer_info_zc) * ring->count :
> +		sizeof(*ring->rx_buffer_info) * ring->count;
> +	void *buff_info = vmalloc(size);
> +
> +	if (!buff_info)
> +		return -ENOMEM;
> +
> +	if (pool_present) {
> +		vfree(ring->rx_buffer_info);
> +		ring->rx_buffer_info = NULL;
> +		ring->rx_buffer_info_zc = buff_info;
> +	} else {
> +		vfree(ring->rx_buffer_info_zc);
> +		ring->rx_buffer_info_zc = NULL;
> +		ring->rx_buffer_info = buff_info;
> +	}
> +
> +	return 0;
> +}
> +
> +static void igb_txrx_ring_disable(struct igb_adapter *adapter, u16 qid)
> +{
> +	struct igb_ring *tx_ring = adapter->tx_ring[qid];
> +	struct igb_ring *rx_ring = adapter->rx_ring[qid];
> +	struct e1000_hw *hw = &adapter->hw;
> +
> +	set_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
> +
> +	wr32(E1000_TXDCTL(tx_ring->reg_idx), 0);
> +	wr32(E1000_RXDCTL(rx_ring->reg_idx), 0);
> +
> +	synchronize_net();
> +
> +	/* Rx/Tx share the same napi context. */
> +	napi_disable(&rx_ring->q_vector->napi);
> +
> +	igb_clean_tx_ring(tx_ring);
> +	igb_clean_rx_ring(rx_ring);
> +
> +	memset(&rx_ring->rx_stats, 0, sizeof(rx_ring->rx_stats));
> +	memset(&tx_ring->tx_stats, 0, sizeof(tx_ring->tx_stats));
> +}
> +
> +static void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
> +{
> +	struct igb_ring *tx_ring = adapter->tx_ring[qid];
> +	struct igb_ring *rx_ring = adapter->rx_ring[qid];
> +
> +	igb_configure_tx_ring(adapter, tx_ring);
> +	igb_configure_rx_ring(adapter, rx_ring);
> +
> +	synchronize_net();
> +
> +	clear_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
> +
> +	/* call igb_desc_unused which always leaves
> +	 * at least 1 descriptor unused to make sure
> +	 * next_to_use != next_to_clean
> +	 */
> +	igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
> +
> +	/* Rx/Tx share the same napi context. */
> +	napi_enable(&rx_ring->q_vector->napi);
> +}
> +
> +struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
> +				   struct igb_ring *ring)
> +{
> +	int qid = ring->queue_index;
> +	struct xsk_buff_pool *pool;
> +
> +	pool = xsk_get_pool_from_qid(adapter->netdev, qid);
> +
> +	if (!igb_xdp_is_enabled(adapter))
> +		return NULL;
> +
> +	return (pool && pool->dev) ? pool : NULL;
> +}
> +
> +static int igb_xsk_pool_enable(struct igb_adapter *adapter,
> +			       struct xsk_buff_pool *pool,
> +			       u16 qid)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	struct igb_ring *rx_ring;
> +	bool if_running;
> +	int err;
> +
> +	if (qid >= adapter->num_rx_queues)
> +		return -EINVAL;
> +
> +	if (qid >= netdev->real_num_rx_queues ||
> +	    qid >= netdev->real_num_tx_queues)
> +		return -EINVAL;
> +
> +	err = xsk_pool_dma_map(pool, &adapter->pdev->dev, IGB_RX_DMA_ATTR);
> +	if (err)
> +		return err;
> +
> +	rx_ring = adapter->rx_ring[qid];
> +	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
> +	if (if_running)
> +		igb_txrx_ring_disable(adapter, qid);
> +
> +	if (if_running) {
> +		err = igb_realloc_rx_buffer_info(rx_ring, true);
> +		if (!err) {
> +			igb_txrx_ring_enable(adapter, qid);
> +			/* Kick start the NAPI context so that receiving will start */
> +			err = igb_xsk_wakeup(adapter->netdev, qid, XDP_WAKEUP_RX);
> +		}
> +
> +		if (err) {
> +			xsk_pool_dma_unmap(pool, IGB_RX_DMA_ATTR);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int igb_xsk_pool_disable(struct igb_adapter *adapter, u16 qid)
> +{
> +	struct xsk_buff_pool *pool;
> +	struct igb_ring *rx_ring;
> +	bool if_running;
> +	int err;
> +
> +	pool = xsk_get_pool_from_qid(adapter->netdev, qid);
> +	if (!pool)
> +		return -EINVAL;
> +
> +	rx_ring = adapter->rx_ring[qid];
> +	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
> +	if (if_running)
> +		igb_txrx_ring_disable(adapter, qid);
> +
> +	xsk_pool_dma_unmap(pool, IGB_RX_DMA_ATTR);
> +
> +	if (if_running) {
> +		err = igb_realloc_rx_buffer_info(rx_ring, false);
> +		if (err)
> +			return err;
> +
> +		igb_txrx_ring_enable(adapter, qid);
> +	}
> +
> +	return 0;
> +}
> +
> +int igb_xsk_pool_setup(struct igb_adapter *adapter,
> +		       struct xsk_buff_pool *pool,
> +		       u16 qid)
> +{
> +	return pool ? igb_xsk_pool_enable(adapter, pool, qid) :
> +		igb_xsk_pool_disable(adapter, qid);
> +}
> +
> +int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
> +{
> +	struct igb_adapter *adapter = netdev_priv(dev);
> +	struct e1000_hw *hw = &adapter->hw;
> +	struct igb_ring *ring;
> +	u32 eics = 0;
> +
> +	if (test_bit(__IGB_DOWN, &adapter->state))
> +		return -ENETDOWN;
> +
> +	if (!igb_xdp_is_enabled(adapter))
> +		return -EINVAL;
> +
> +	if (qid >= adapter->num_tx_queues)
> +		return -EINVAL;
> +
> +	ring = adapter->tx_ring[qid];
> +
> +	if (test_bit(IGB_RING_FLAG_TX_DISABLED, &ring->flags))
> +		return -ENETDOWN;
> +
> +	if (!READ_ONCE(ring->xsk_pool))
> +		return -EINVAL;
> +
> +	if (!napi_if_scheduled_mark_missed(&ring->q_vector->napi)) {
> +		/* Cause software interrupt */
> +		if (adapter->flags & IGB_FLAG_HAS_MSIX) {
> +			eics |= ring->q_vector->eims_value;
> +			wr32(E1000_EICS, eics);
> +		} else {
> +			wr32(E1000_ICS, E1000_ICS_RXDMT0);
> +		}
> +	}
> +
> +	return 0;
> +}
> 
> -- 
> 2.39.2
> 

