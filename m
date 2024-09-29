Return-Path: <bpf+bounces-40502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816D69895FE
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 16:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 066FBB237B4
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 14:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6132617BEC8;
	Sun, 29 Sep 2024 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fo8rMHLX"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EA01448E2;
	Sun, 29 Sep 2024 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727620920; cv=fail; b=MS89I3g1As3HgUtFVqUoIOy2B8fY6mcA3PBM1fJ/Ot+43ayYtYH1IXWYeNUcQxU7zucIrFQArj5EMIfgK8e/eROBsvmFURLpTaxqRhP2YyiV7xL43eY8hTEDwagDRRbG9izTOp7dEZfIkllh6P2C7HChEagTBHlt8Dd/O3T9B2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727620920; c=relaxed/simple;
	bh=+RG3JaOEJ3wOvMj4RdyHOn2gyFahObe1OI1q5JH70Xo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=R+b209qLollFCrlKFWCn/SW5ZpBJh3tLupz2jAA//PN68C+xPxAqNVwIDYTxg8SmjGuXR83D/au2+aHbRHXQfPdtixZ9rnGQ4+p5RzEg7bpehKfxVYSUojDv5YfTVXYsJMlG+kUfZuVUZugh7Qg9akJmgB7yW4lH7HjmAEww8BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fo8rMHLX; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727620919; x=1759156919;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+RG3JaOEJ3wOvMj4RdyHOn2gyFahObe1OI1q5JH70Xo=;
  b=fo8rMHLXmJdxk4m8ldNoc4RowPIGU/RWXgN8Ohb2Do+H0RoTHoz9+S9b
   Zxd0sm46IvWCaquVO8HnSbCaeBnYLI9YDUXKDiok39PJsxhO0gpJFI/ET
   WRUlTjbi+OJC+Qt2z2gHdfOMAguklmsQiTHjbeUCrJuM3vhSMYjqOCcKo
   QRTuGVdosmvotN/LSM9/p8Qw3Ss4oU5kl0s2nwzUWAHvxRfB2l9mKjPLP
   JlZwrV+VBEn4+ELoT/IGxy+RIXuCHJOPTU5CFPHWrwx3MwzaOo6qv3Pso
   WoT5KpBdR4VC7Vn5nvmOFsQeCBDolh/L5GGk/Oo1oB97aR6O8oIBhyNEF
   Q==;
X-CSE-ConnectionGUID: Ue1rtKc8Ti+sXWJAlnXrgQ==
X-CSE-MsgGUID: HpWajRFuSBa30Bf/yVRvaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="26839433"
X-IronPort-AV: E=Sophos;i="6.11,163,1725346800"; 
   d="scan'208";a="26839433"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 07:41:52 -0700
X-CSE-ConnectionGUID: XsxjqilLSeKIrD83ooqcSQ==
X-CSE-MsgGUID: lORC9ExaS5i8XKlJeCYGgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,163,1725346800"; 
   d="scan'208";a="77123748"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2024 07:41:51 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 07:41:51 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 07:41:51 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 07:41:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 29 Sep 2024 07:41:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 07:41:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xhb6atAfWqP1M1nZiJSFaZfbVnNO9ZyvOEIT08wl3AAK+vhrx8Cdjte18weIJ+ZCdaX3M2dyvxTj4svXsIp1MOQ/RepasuU0cBMGGcKLiuKyhv49tLNyaiSgrn2EG+Cy1rXxeSVtnBH2cDRdqbTLZ8jhhej9X9DSw4OIlyFRHd6ULX6D9DBAkrI4coBFx2X/KVjEZfe1r0eoB8/k7v/6AfBhcNP8vPb04Hb37n0D1riCpps1w5A5jNHLKYx3LYrMYvluHfhuJag9wueeLggNnyqQt3G9T1mOVvmMomdTstKXZuviR1vYLV7u7AGnpw7uSo+dWO2QjStX1qik3jibcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRNNoU3hlWcHnJ/LGoB4higEmpBg4kPgC+70vYTw3bo=;
 b=bfSW4pq/7heNY9Cp2yu5kWDimqFwu6oan1wTtTL1gYUAYL/QU3j+FkowUnv3nGHSs5Xj74WBDwcRa+guCZOB72z3jDGTkEeHbFzTBIm9nIrh1BrlIJy9jhiMrL2HgB6C8ke8Jg5vMIyBgdfiXoi+X8OWakmiWOcpceM/KhlNR10Eu9tNGB1veVc8KgzP+/ydUwsgE7Is2NeDZv20OjKupbMELAjGhTPqiNqtT4rfkkfo1sXd59BRZJNr+Pr/+Ir6ZJ5zj8y4i0VFSMAsk5SS9OVDzDAMIrQoLg7JwB8iXwZWqVDtFQT0a5lxUbiM4opgcvaztkf4EeRYuLVjMfB4rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB7374.namprd11.prod.outlook.com (2603:10b6:8:102::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Sun, 29 Sep
 2024 14:41:48 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 14:41:48 +0000
Date: Sun, 29 Sep 2024 22:41:39 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [peterz-queue:x86/ibt] [x86/ibt]  7674335965:
 kernel_BUG_at_arch/x86/kernel/alternative.c
Message-ID: <202409292243.b563a081-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0187.apcprd04.prod.outlook.com
 (2603:1096:4:14::25) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa29b19-f7fb-4879-1d83-08dce094d8db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FpmeKGE8KNYwRbxGQkJnoVnIhgHrJzfsdKJtodiF6t09/mIL+KHwnMg4k1ga?=
 =?us-ascii?Q?NnS3mZtW6vhVJJCTNM6ZPD7RcByQphqvLG12lmM3KmOQSmMPckwYDVUTsBSE?=
 =?us-ascii?Q?GTpr+1jExWIwng0pAsyH/CdonhkK7883NpgCXQJm0FFW9rV159VE18nFMQ82?=
 =?us-ascii?Q?vTQfXcabrFX8sFP7goSNRn3ZpJY+Xc6oxPujOPbjMPDx/LSeAddXZYusyKGP?=
 =?us-ascii?Q?LFftCGHA0Wob8ms1Ay8uVLLxjPuiBpBVTb+o/O5NULWgvQzSlep2yAzla2Qd?=
 =?us-ascii?Q?hWvuFPaTRNcvEVhKJp537ckdvOR7B781q/E8hOjGHjYPChGBoBlffHc93Gbv?=
 =?us-ascii?Q?oB8IXtOs67u729Q66+6LjEa7zrLbfbdtM6+Td6t9f1hN+K9oTx8YcBSYGRKt?=
 =?us-ascii?Q?Ozc22hTsm7zJY+8cFhsbncwKxeo4EkHE3nWgQ7ogNE/LqNQvb/OLPTtw1ddO?=
 =?us-ascii?Q?LYffzGKAR5gf98S0eBprZrBWLqnfD4PnWjCc7t5JG8O/qnHxvZsHj0+EfLQc?=
 =?us-ascii?Q?8b/aVqyj8QymgXmMtWw3m06UepEj52D/GGb/Vk/3zLhr0UN8N96L605r9K7/?=
 =?us-ascii?Q?hcN+SKOte8KdzHDu4hrJ4mHAOjDR+MO3DSZUqk/hrq8gvLXpBSX7/NpPUAUq?=
 =?us-ascii?Q?vxi+5uZuvpnZwXgwc2Vw6rh7XoSH1Yz6Cfdfq3/18SUP8RA8oYoTrTL2QsGy?=
 =?us-ascii?Q?ENVhjts5Wy4sB/+WNg4Jc+ubx3qLLVBNAIFXPHxakC3EM0EJ7eQ9Br4nO7Qh?=
 =?us-ascii?Q?UoKGjhVDbCnXTG7feoFBBfNxAiVT3hFU9xp62KCJSOYNLYKrMwus1h5xI4ET?=
 =?us-ascii?Q?xQKVEExox1ibpUtsW+J9iO7oEC8Kj/REog/9Raxhn0AVQYkBVjx5ERK4Ndv7?=
 =?us-ascii?Q?e9tWSFRa3qNiff8UTjNYQSKCUhF0iahyZK7OaF66WXPL3Xl2bY7a4OdQSSRk?=
 =?us-ascii?Q?5tmkBJm9GPOUadYJrxQzK+LPF5XLS1N0NPR5u8xlitFwDa3JzfGHDgc7wLZH?=
 =?us-ascii?Q?IPh9bxNgya0xhtMa4/TnQqiJNNKBRJEObZP5MlWWZIO9tUqeGW7ffVZIIX7s?=
 =?us-ascii?Q?JlD4Hkm2HtefjzYJd238kvpqvP3JxxPZhQiWUb7P8F54GzdBdCEi6jHryOzs?=
 =?us-ascii?Q?E+1iE7o7Zir0+F0pm8pu/MXZ92oM+OuGeHSvg8tG8mhMwbjKdauSnJMPvM6W?=
 =?us-ascii?Q?IS3ZjPqwPgFeIHlc5PBlZc5svQkfH4kVo9dQet1XNBYyUMOkBk7BTgqBNnYr?=
 =?us-ascii?Q?jRVjTqq6mRlljhYp8bwS2ou5ego2NO+SLZ6560tBxGR0KFIYiG2sesDRQTYf?=
 =?us-ascii?Q?B4f9Cq4SD24CKaYDUcabF/x7k/+bq2hMkmfsuBlMQhaGqr5kIfk0XUv8YQQj?=
 =?us-ascii?Q?i0tTXXU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bx7qtN64GX2eKhxnN2i1gVgIH8phgIZRgdvvf1UloPPPPkLq2+RfC9nWwllw?=
 =?us-ascii?Q?B2EPHFnf5G1bH/EOhr5UxWCNbjZH0p55jOibiqB+hzfPQ8n7TJqhZktz1n+p?=
 =?us-ascii?Q?6Q5WO6JMHLTctaxn7++mruFElt9xobqKp89gV0OIAM4aOs5NaWtcyuKNWVVT?=
 =?us-ascii?Q?zEBFLTsnn4LWlLEHutqHDagm7MZPlC1QK3P9mvF3eGiaoN948win6+EpnOep?=
 =?us-ascii?Q?90OdNuEbDXZuYSnLngSZ6iekueaz/vET4wAFgMScTc04BeKl8S/mH77nKiVM?=
 =?us-ascii?Q?3yKDmxcv5rvADtrzth4QPgM4wyfXl8dwRojo3lDcMw33ywGmulcSVxwFixEN?=
 =?us-ascii?Q?tps5zSxBLhWT2MN5BoaUiG7vHlyfWuQO5iMQ9tG0Aa6NzfLBqoCbm5lJ7bOG?=
 =?us-ascii?Q?cKPpm0UxNw1jJPN8g+SVzwtkEHo0inRlZKSe/eIAH3SpV5hXEdLSqZzSkx6X?=
 =?us-ascii?Q?tj9xsd6qo7LZC9OAzcsX3bcwamVgeXTdL0vI6WWx877znPFPQ/MCMZkHoZYa?=
 =?us-ascii?Q?BkyupuhMli1MKQD6rRb3BHCdEE2AyVV5/sUjXUNnBYtj+GtVU+XfYKmlLKV2?=
 =?us-ascii?Q?rJvf296a9vvLQeXDanLC4/xyiAU1V7D6GcvRo7GLooie88wDiSWVoWwMPtiV?=
 =?us-ascii?Q?2RD402L8k257/ZjaDpVCbUUnr8wsP3fl7032YUTmnuu2TYmX3EZl6c6bhSms?=
 =?us-ascii?Q?JZWHH8Q2RvW/m5paxratecGhMfKGpy9I+oXNuUibpSLQutHc7QnhFMnemU1q?=
 =?us-ascii?Q?f29/MC43+6R2ipSxCuyn8ca2Qrb5X8tqZZNmI+dzO9CAA/rBq8cmUqoZJAyk?=
 =?us-ascii?Q?Qb6B08AIyHSZBkrrqoERDU+RuP5uKbHN8H+aRV90/A6uyxqIeWe1MBp+vcQg?=
 =?us-ascii?Q?PIfZvqZl8gPOQL+TiwcnSXeeqrThhK+PwoVEl1fT0iCwepW7vT6Z/Wb/RF2m?=
 =?us-ascii?Q?eyLkl4w9fQ+hdq0XvgQg+IQS4EfBW/a7X/hhq5flTL2HCFraOJDN79F6I6Ar?=
 =?us-ascii?Q?cAdxWjnlGXOl+6NBJLHQhdk7X8QCauenkBmbC0q0YOqbzza1sXL2NmXZy0Jv?=
 =?us-ascii?Q?12Tg+787vsvGBfmwNTtTq1DhyV3lZZcjQq4fSrTS5t6NpRMgzrRhH04vVscy?=
 =?us-ascii?Q?Zz1Ten1iIMJY234VB1zFNLKGagk+Fr15qsTk3fIW6BTiE5uKXCP8SyEZ4Sxl?=
 =?us-ascii?Q?7gg4nA1UZNQZQeByD1T0C9mkdlDRBwQTOpDc2Plg1yr0MAqzOmQFAx54mM7i?=
 =?us-ascii?Q?PYyV/C0jkMu9OmsT9X19J8Mi/MJge/YtV0MkBDnJyhC4shPF3ZCBf6mBwrkf?=
 =?us-ascii?Q?YRpEUD/17ouw7OOqY3KjbjtMywxds3iaMw7+woJ0RU+oWnp535BwuUwKShtT?=
 =?us-ascii?Q?cJ2c/H9OHlSLEzwOcqlV3JyMy4FBjJT9+tgaha2s+YNCibbPz5umyqWCpxvB?=
 =?us-ascii?Q?YEjz/5q7/jKLtQCXrVNq21w62tzsDfmh3yCBlAEDXWvv5B1KUJIsG2Ok27eG?=
 =?us-ascii?Q?P+Io0EjTGukSxzH9QFVsibpl/VerPGNyB1Zcyvh3hilFb+rmds4S0GJeZWsA?=
 =?us-ascii?Q?G/5rgQzYzHiaAbcxSH4ANE4KxB7FU4lylDTp4DkIHTrNcoYCA32x0qZLejlJ?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa29b19-f7fb-4879-1d83-08dce094d8db
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 14:41:48.0810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXO2E0puZIlL9XJE9IGoKbinHybhf7WsF50aPadWNmd/WNzJdxSZIVv9Q98whIC3a1aZ1J22IiJ5OFZKNPqQyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7374
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_arch/x86/kernel/alternative.c" on:

commit: 76743359658d730ecba565019069d870d30fe3b8 ("x86/ibt: Implement IBT+")
https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git x86/ibt

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+------------+------------+
|                                             | 89d02f5cc0 | 7674335965 |
+---------------------------------------------+------------+------------+
| boot_successes                              | 18         | 0          |
| boot_failures                               | 0          | 18         |
| kernel_BUG_at_arch/x86/kernel/alternative.c | 0          | 18         |
| Oops:invalid_opcode:#[##]PREEMPT_SMP_PTI    | 0          | 18         |
| RIP:apply_direct_call_offset                | 0          | 18         |
| Kernel_panic-not_syncing:Fatal_exception    | 0          | 18         |
+---------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409292243.b563a081-lkp@intel.com


[    0.484790][    T0] ------------[ cut here ]------------
[    0.485675][    T0] kernel BUG at arch/x86/kernel/alternative.c:302!
[    0.486640][    T0] Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
[    0.487072][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.11.0-09968-g76743359658d #1
[    0.487072][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 0.487072][ T0] RIP: 0010:apply_direct_call_offset (arch/x86/kernel/alternative.c:302) 
[ 0.487072][ T0] Code: 08 43 83 44 2e 01 04 eb df 83 f8 0f 75 0f 80 7c 24 19 8f 7f 17 43 83 44 2e 02 04 eb cb 3d eb 00 00 00 74 a7 eb 06 0f 0b eb be <0f> 0b 0f b6 54 24 52 48 c7 c7 75 6a 89 82 4c 89 e6 4c 89 e1 e8 0f
All code
========
   0:	08 43 83             	or     %al,-0x7d(%rbx)
   3:	44                   	rex.R
   4:	2e 01 04 eb          	cs add %eax,(%rbx,%rbp,8)
   8:	df 83 f8 0f 75 0f    	filds  0xf750ff8(%rbx)
   e:	80 7c 24 19 8f       	cmpb   $0x8f,0x19(%rsp)
  13:	7f 17                	jg     0x2c
  15:	43 83 44 2e 02 04    	addl   $0x4,0x2(%r14,%r13,1)
  1b:	eb cb                	jmp    0xffffffffffffffe8
  1d:	3d eb 00 00 00       	cmp    $0xeb,%eax
  22:	74 a7                	je     0xffffffffffffffcb
  24:	eb 06                	jmp    0x2c
  26:	0f 0b                	ud2
  28:	eb be                	jmp    0xffffffffffffffe8
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	0f b6 54 24 52       	movzbl 0x52(%rsp),%edx
  31:	48 c7 c7 75 6a 89 82 	mov    $0xffffffff82896a75,%rdi
  38:	4c 89 e6             	mov    %r12,%rsi
  3b:	4c 89 e1             	mov    %r12,%rcx
  3e:	e8                   	.byte 0xe8
  3f:	0f                   	.byte 0xf

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	0f b6 54 24 52       	movzbl 0x52(%rsp),%edx
   7:	48 c7 c7 75 6a 89 82 	mov    $0xffffffff82896a75,%rdi
   e:	4c 89 e6             	mov    %r12,%rsi
  11:	4c 89 e1             	mov    %r12,%rcx
  14:	e8                   	.byte 0xe8
  15:	0f                   	.byte 0xf
[    0.487072][    T0] RSP: 0000:ffffffff82a03e58 EFLAGS: 00010297
[    0.487072][    T0] RAX: 0000000000000082 RBX: ffffffff8380369c RCX: 0000000000000000
[    0.487072][    T0] RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffffff81b4ea70
[    0.487072][    T0] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff82a03e58
[    0.487072][    T0] R10: 000000000000000f R11: 0000000000000040 R12: ffffffff81b4e9f0
[    0.487072][    T0] R13: fffffffffe353184 R14: ffffffff837fb86c R15: ffffffff82a03e58
[    0.487072][    T0] FS:  0000000000000000(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
[    0.487072][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.487072][    T0] CR2: ffff88843ffff000 CR3: 0000000002a32000 CR4: 00000000000406f0
[    0.487072][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.487072][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.487072][    T0] Call Trace:
[    0.487072][    T0]  <TASK>
[ 0.487072][ T0] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 0.487072][ T0] ? die (arch/x86/kernel/dumpstack.c:? arch/x86/kernel/dumpstack.c:447) 
[ 0.487072][ T0] ? do_trap (arch/x86/kernel/traps.c:196) 
[ 0.487072][ T0] ? apply_direct_call_offset (arch/x86/kernel/alternative.c:302) 
[ 0.487072][ T0] ? do_error_trap (arch/x86/kernel/traps.c:242) 
[ 0.487072][ T0] ? apply_direct_call_offset (arch/x86/kernel/alternative.c:302) 
[ 0.487072][ T0] ? handle_invalid_op (arch/x86/kernel/traps.c:279) 
[ 0.487072][ T0] ? apply_direct_call_offset (arch/x86/kernel/alternative.c:302) 
[ 0.487072][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:361) 
[ 0.487072][ T0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 0.487072][ T0] ? rtl8169_netpoll (drivers/net/ethernet/realtek/r8169_main.c:4847) 
[ 0.487072][ T0] ? __pfx_rtl8169_interrupt (drivers/net/ethernet/realtek/r8169_main.c:4650) 
[ 0.487072][ T0] ? apply_direct_call_offset (arch/x86/kernel/alternative.c:302) 
[ 0.487072][ T0] ? apply_direct_call_offset (arch/x86/kernel/alternative.c:889) 
[ 0.487072][ T0] ? rtl8169_netpoll (drivers/net/ethernet/realtek/r8169_main.c:4847) 
[ 0.487072][ T0] ? rtl8169_netpoll (drivers/net/ethernet/realtek/r8169_main.c:4847) 
[ 0.487072][ T0] ? rtl8169_netpoll (drivers/net/ethernet/realtek/r8169_main.c:4847) 
[ 0.487072][ T0] alternative_instructions (arch/x86/kernel/alternative.c:1821) 
[ 0.487072][ T0] arch_cpu_finalize_init (arch/x86/kernel/cpu/common.c:2397) 
[ 0.487072][ T0] start_kernel (init/main.c:1073) 
[ 0.487072][ T0] x86_64_start_reservations (??:?) 
[ 0.487072][ T0] x86_64_start_kernel (arch/x86/kernel/head64.c:437) 
[ 0.487072][ T0] common_startup_64 (arch/x86/kernel/head_64.S:421) 
[    0.487072][    T0]  </TASK>
[    0.487072][    T0] Modules linked in:
[    0.487076][    T0] ---[ end trace 0000000000000000 ]---
[ 0.487877][ T0] RIP: 0010:apply_direct_call_offset (arch/x86/kernel/alternative.c:302) 
[ 0.491321][ T0] Code: 08 43 83 44 2e 01 04 eb df 83 f8 0f 75 0f 80 7c 24 19 8f 7f 17 43 83 44 2e 02 04 eb cb 3d eb 00 00 00 74 a7 eb 06 0f 0b eb be <0f> 0b 0f b6 54 24 52 48 c7 c7 75 6a 89 82 4c 89 e6 4c 89 e1 e8 0f
All code
========
   0:	08 43 83             	or     %al,-0x7d(%rbx)
   3:	44                   	rex.R
   4:	2e 01 04 eb          	cs add %eax,(%rbx,%rbp,8)
   8:	df 83 f8 0f 75 0f    	filds  0xf750ff8(%rbx)
   e:	80 7c 24 19 8f       	cmpb   $0x8f,0x19(%rsp)
  13:	7f 17                	jg     0x2c
  15:	43 83 44 2e 02 04    	addl   $0x4,0x2(%r14,%r13,1)
  1b:	eb cb                	jmp    0xffffffffffffffe8
  1d:	3d eb 00 00 00       	cmp    $0xeb,%eax
  22:	74 a7                	je     0xffffffffffffffcb
  24:	eb 06                	jmp    0x2c
  26:	0f 0b                	ud2
  28:	eb be                	jmp    0xffffffffffffffe8
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	0f b6 54 24 52       	movzbl 0x52(%rsp),%edx
  31:	48 c7 c7 75 6a 89 82 	mov    $0xffffffff82896a75,%rdi
  38:	4c 89 e6             	mov    %r12,%rsi
  3b:	4c 89 e1             	mov    %r12,%rcx
  3e:	e8                   	.byte 0xe8
  3f:	0f                   	.byte 0xf

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	0f b6 54 24 52       	movzbl 0x52(%rsp),%edx
   7:	48 c7 c7 75 6a 89 82 	mov    $0xffffffff82896a75,%rdi
   e:	4c 89 e6             	mov    %r12,%rsi
  11:	4c 89 e1             	mov    %r12,%rcx
  14:	e8                   	.byte 0xe8
  15:	0f                   	.byte 0xf


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240929/202409292243.b563a081-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


