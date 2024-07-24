Return-Path: <bpf+bounces-35522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F239893B447
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 17:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6101CB241C7
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 15:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA9215ECC1;
	Wed, 24 Jul 2024 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXFIL34m"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F360E18040;
	Wed, 24 Jul 2024 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836174; cv=fail; b=avOgySlQhKrWnLXXZ8cWoBtUbKme8Rybhv6wRoimqznhg9fZdWEAPZNBxn10S/jsNN6Dm3ft+PLFBb/jPOippRIaqOV0/yR+TN9H7o0vFvcX5uiLkhhtE4aValcudgLbPF86aZnDAGq6rqgTcBKvVLWYp+X9C0BPYP45QfWDWZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836174; c=relaxed/simple;
	bh=hnu3K50vnB+wMdbnFFHuePAzZAu+ZXp/1gwP31OemEI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bM+kyeA22t43nVK90HN6AZpa2LVaK9OxmMqbQBonqf2h/xfw6AEUqxHup7LBLx23jLVkSx1igmeIIJ+/oPxOTM+O8wTVE+fIYnJhnCKV0jMKh3NKFwmom8vRcCvEQwXaZQuAY6yy7U/MunVZYgb28WAg77xEpQ1+NBoFKGWrKsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXFIL34m; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721836173; x=1753372173;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hnu3K50vnB+wMdbnFFHuePAzZAu+ZXp/1gwP31OemEI=;
  b=FXFIL34mpxETdqdeiPop9ihom8u0fbbOdjH2+xJAVZvqBcDI7M0szX8S
   gtonbkSX65+PwUGIe41d/UB0rqKqkPQ4J0wPRz1ZAU0Qt7d2SOlcsVFJx
   vuHmKNasLGxEgVholzkSO/dPBz8fZvPDsoTA3dN8mJsk+i0GEYhQgi2ne
   EeJkHlC9mWaRgXE6QSMnW8lZb+TMydpWhP/O8CFTP+o5ZudzCBYpkZ7TO
   eXLfFCH6RWjDetsTlKr1l3g9QecZuR21HXA1MfDr0UjA/UbZnqErFNj2l
   6Ge2Sl/CYkfaUwTRyRfWk/suyE5TcUZX+VNfJEpOX831EKXD4EEWLGpLY
   Q==;
X-CSE-ConnectionGUID: 695zkJp7QGuLb6IxTDE2EA==
X-CSE-MsgGUID: NmCxWziETWu41Wd9Jt7qGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="30669937"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="30669937"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 08:49:33 -0700
X-CSE-ConnectionGUID: zikvfvvkT/2ciAJyOkRqUg==
X-CSE-MsgGUID: 0WMgPUCFS4O9S1+FY8JvcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="52848862"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jul 2024 08:49:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 08:49:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 08:49:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 08:49:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 08:49:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfE5YgOif2HEPyKBP5bHinLZuPLqqCyTVPtVax8ybe553FceQ92vSDY3tLLyapCXgMIk5H84ELtHcRKRs3agUBAzwBCVEzygBVZ8O8LbAAAT79sqjTAZYiXUylo+TKbBZ4T3VHcgC1K7vP3JWNt/164OaW8+9gO4X9dIZQhY5/4H8s9iFQRTZ8FqtrE0fm9cMyf+No6vP/EDBgc+4bPG8w1ybgS4hyqFMrXf4kvk3EM+0Jn2SNlT5EuVkbAOW4Zjik9C1yc5zFW4eDwPXWBsTzYZdYIQnIhtgKH1dwaXffmpb2s7UCbTavdv1sJVvdBo0waYqWmCWYMrbnsLrjCBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IC1kDkRoxJ5bcecqWo2+bckEMBHovkZM9vqizZmd3AA=;
 b=Z1M2aUImkuBBaWPvV62Fs6DP5NsDGlwUhKwBSjUNo5xVyaU61Eml2Jwfnbz/tdRiPl+M+cWl+xbCkm26J15A0uNK1hwXY8HCH9O2xhmGcZ/l3VhgIq8Zr+Vpe7OuMrlxng1AHNjX09fE5d1ZYppO8xn5p6YFJ2ZYbw2/1V25NAb/bzbBkZzJBWnf26Tddh2b/A2MA5h/apU5DNH/q+H1pAuekjdd1k0JgN+HA/9/1gjLYpUfFTtvdu2++QUBTa2M/IzYjY6s7guM15iZgHHa5SN3NK4PnSTBtH8qZY+Qgl2H02syQUlYAp3DVXn7MiNVGmjW4DniU2DjBPzJvXP1LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Wed, 24 Jul
 2024 15:49:25 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%7]) with mapi id 15.20.7762.027; Wed, 24 Jul 2024
 15:49:25 +0000
Date: Wed, 24 Jul 2024 17:49:12 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <aleksander.lobakin@intel.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <bpf@vger.kernel.org>, Shannon Nelson
	<shannon.nelson@amd.com>, Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: Re: [PATCH net 6/8] ice: improve updating ice_{t, r}x_ring::xsk_pool
Message-ID: <ZqEieHlPdMZcPGXI@boxer>
References: <20240708221416.625850-1-anthony.l.nguyen@intel.com>
 <20240708221416.625850-7-anthony.l.nguyen@intel.com>
 <20240709184524.232b9f57@kernel.org>
 <ZqBAw0AEkieW+y4b@boxer>
 <20240724075742.0e70de49@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240724075742.0e70de49@kernel.org>
X-ClientProxiedBy: DUZPR01CA0150.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::7) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f07704-e9b3-4ae6-7d76-08dcabf83178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GyXPMeABEg5hcOX3zuJQUEIy34HtLmI9/z0EN5GGSlMN21kr0/m4sj1UMDYa?=
 =?us-ascii?Q?OQzpJIHdtQDRUS7dpc3QAOgcFEa+pjGTEvRXTkkyv97tDpsdHnuEsEru0jra?=
 =?us-ascii?Q?+d6pWCet3LuNQA/koc3h+Yv6loImJVBgZkNI7ctUPlONjkIYJ8RWrg6oh8WL?=
 =?us-ascii?Q?X+B0cnLtp9ZH22yZci1uwIpz2pfPex5yy7Px4R8eoL1PFXPoYViDfbJP0bZH?=
 =?us-ascii?Q?PrAiU0DMUtzvhXu5XNuDd+Rzo3le6j3qjGdRCMw5iek+oRVFdlBN6yIJk/WR?=
 =?us-ascii?Q?DpqpcakXIvy6S1VO/UMIj1Id/0a6MqRV1MiH0B0gqhLSS3JrowfRFuvQ1uxN?=
 =?us-ascii?Q?Z8ZiUHJq9vpJqxHUauvhN1600RELWTh/GRSRUbeTFLBSoxfsUNqa3nEIkdXQ?=
 =?us-ascii?Q?4//XmSiI/AA04l/azufMWlEcs9foWixsymF89fmzKWXHCyApOLbFW/tXeMxE?=
 =?us-ascii?Q?qacCVgufBpPd9e9uFm3UJ/cxWgCgawTsBtc4mm87www1ltOg45L/ELsBatNL?=
 =?us-ascii?Q?PgRK1xYHNIFOTILpctsIkE3WQwthp0BCuiQ/kE+11URighvjRIjpBQY4X2He?=
 =?us-ascii?Q?BnwmozbgamZKtiNoEOM0VUYQWPAfTFiTSJ4kJHwNjJ6lQKm/YEPBpTkus/Ry?=
 =?us-ascii?Q?4k5D1aNlCccVUuvPXBtysheaD1xqShY1wQQnH+/3L0mNxwQ2yq4oStfp2INA?=
 =?us-ascii?Q?k3L8PiBseVt2UXVrj0IDHKFE8P4Bi9b5RRFDlR/2zQoem5rfCtjTFQ+mbA02?=
 =?us-ascii?Q?LNAFlJfD8yqovF5aCTnHfdvsp8gIiR/sQdJOpgDSYozhryXHRoSfIt1T0u+y?=
 =?us-ascii?Q?sb9BnJIRIeWAeq6y4MlmSnTJA5Wk+gdBNdSX+JdslEt/VV64TjbCK/ALCLPb?=
 =?us-ascii?Q?UAXJX9mbQMaU2PIighJ7LjYtTF2AWRwXaorygIK0aoBQhMUyrOpB8gxyz587?=
 =?us-ascii?Q?sXk9tt+JEHTlXmKy+3sdmBqfsaHURLSTxU2v0p6QhzhtpUNNxCt/9GEk0NaL?=
 =?us-ascii?Q?b3nTbmCC4wJKVqjunnF62hWsX2/Vwt+xeFcPJ1yK45eTPXQm2+crVKbZJ2Pb?=
 =?us-ascii?Q?MFV8BRNbosviGIE4PaQ04NSWV0nIalcH9TfujDvrX7lxDla2Pi0rujok0bUt?=
 =?us-ascii?Q?sJ/gVM341+8bYxQOQ3hbQ/qZd9GhQJRD5NhHIULLfKWw8CcuaoQP70f78+LU?=
 =?us-ascii?Q?UOSWvc3aNihYwQoXkTyi2zIwLPRfXSRH68urMVeu8xwWm3YAeXRkKHXd4Thv?=
 =?us-ascii?Q?glKLGjSJ37G/1zrQU6GTindjew6x+Mfe3PWZU2rP2S/vp8+H+vW55vUDJ27L?=
 =?us-ascii?Q?OyaieEHHgqHyGKCwPJjJTeRuwPFAmFKKk2s9MmFaEpUsCg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xhRhyA9QJ0XWc/b/isHVNT5Pq4BnX1HpsB35F1CaZ2xOQOu8C7ktNJ0kT5KS?=
 =?us-ascii?Q?OVYyOpJLglDPRtbI8W5Rqw/1A47MjoBIHcOJj5jhin+pCFVZBJr1YstuF/7f?=
 =?us-ascii?Q?l3YnnXpyU/t4QO7gPDe1YvDJvHtbsU2GPmFgTBgO4971HwF2W25nYSyVM5hZ?=
 =?us-ascii?Q?pHBLdWf67FtFIfLPRjhoTNL2/YFCKG688Dbn2k/tG3KTKbo9Qol+MuLdZusn?=
 =?us-ascii?Q?UZJCcXlbKxWr4Bvt3u++/PAA9++ENg9f9Q3tSS8F3LVFnr0GrlcyFWr9iNWt?=
 =?us-ascii?Q?kVW2MdF1uwjjMJx/R3NX5eYDixPd+uxoEa/21cK+/OPc6wku+dsSJjizq1lA?=
 =?us-ascii?Q?IuadsIYa1xdOtfieKM5VqwyHZ7Cxbl3jxJzM8rAezAwzfJiSXnAPeba9/hup?=
 =?us-ascii?Q?46KV4ECzeqanoJLBhvLafzKFFp/p6iHnHHHdfCEPKYvJi42ilDumHCT3NjWE?=
 =?us-ascii?Q?b2LYpBSaok14kAwdjZS74H1arPCJqpEmMW+m5QHdM84woxq3/iXRfSuhswvd?=
 =?us-ascii?Q?lncYckf3akwV3M1HYnLO5OGNb5T7mUs8bNUnKMFu0a3VdMxsJTQDpyqLaFnO?=
 =?us-ascii?Q?KI3Ro3luSRsMEduxCLGufcrNIh///u5yp06mLoQQkoHtRIaWvYu/J7TEkgPp?=
 =?us-ascii?Q?VJvyZ8a9Zgq/M5HyLyQaDrdcv2cVWPeKVHUK6SaH10hGnqbjoK8gxyp25JQI?=
 =?us-ascii?Q?VwL8Lnx2DgLYKHqR/zdbj9QR5seN+unZibPsBSqhKA9pCiWsG6fk/1ouq61a?=
 =?us-ascii?Q?UQrjpSilzkpPjmFLCVAYSrBlkeuPdGyjCLxVFIT6qnPywWHzeakZrqXdr4GE?=
 =?us-ascii?Q?d7vQZF4QPk6UCVA1xpqN4DotEbi9s7PNbkxQeE4lJUkppyxoRmyzqQRgrP6d?=
 =?us-ascii?Q?aJahavCZ2e1umQ8MYRth/2hFeu6a3oTjZN2BxMzgAbpjiupSvyjv5CF3uwHw?=
 =?us-ascii?Q?8dQ7PoCkRFQiGmximdjc30xwWo/Ds7eVtm4Dc+ymyjj7sEtiEB/1/Dw54L1a?=
 =?us-ascii?Q?PD2cvG1gLdV2rfW4C+OgmRkp/Ygd2Nlxb5kbo1wbUABaM8rCImj7hLvdaq4m?=
 =?us-ascii?Q?x1ZPXX9skagqr3F1ywamS2yd5DEgQ+OIhryc/VepZVQctJUKS3TpERFOw5Oq?=
 =?us-ascii?Q?oMM1BPBK+bxOy2g3tjyTgKOyIB1712wflRzrJnLV1Xz4w8acpR5mv2H1yA0w?=
 =?us-ascii?Q?Fcqjj1OTaT/QMoZ2YhtQk9sT2nOdE9/+M9dXW5UpVgwzpioGH1lg2rYZVRIZ?=
 =?us-ascii?Q?0bIxJlORGksqrjzq9y54CFCD4UyZ+6N8afTRDPRMAFZxofgXaKSjCKtyJ6uf?=
 =?us-ascii?Q?oWBrQlAQ3wF/2UFdPuI2kNz8IWlhuH3qz0q2C8UwFs4ZfmmlpbD0R8ZhWgBL?=
 =?us-ascii?Q?xyrO1gWrwI2cafqrys5VVh5JXfw89YdVNHuEBY4dxk41EOS9hU0RrOwECbP4?=
 =?us-ascii?Q?ocq1AOsPvXfi9GiASBGy2LGhmoDSO8KjJmvrTmlhi9eeF5ozV0IaolnMyA92?=
 =?us-ascii?Q?mihxagviWTjvH0mIiUN5kINRZBoOliXwkMcTktU4ZeAtpFlZU3YHPwsN4+Ol?=
 =?us-ascii?Q?Rre6fnPL4hZBc3KfvFhSKCWzZsoV+3hs/4DnH1CDBIojoF09e933UIgDfY3x?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f07704-e9b3-4ae6-7d76-08dcabf83178
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 15:49:25.1258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70hVRNcoepZ9mRVR8TJL1MUW1ef9hhbL4zDvQcu++oU85fwf3HJQUuP1uBVxQxrWuqwXobtqO22BQ03KUDxIwU8kVVatSizkSgf7f2twKmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5896
X-OriginatorOrg: intel.com

On Wed, Jul 24, 2024 at 07:57:42AM -0700, Jakub Kicinski wrote:
> On Wed, 24 Jul 2024 01:46:11 +0200 Maciej Fijalkowski wrote:
> > Goal of this commit was to prevent compiler from code reoder such as NAPI
> > is launched before update of xsk_buff_pool pointer which is achieved with
> > WRITE_ONCE()/synchronize_net() pair. Then per my understanding single
> > READ_ONCE() within NAPI was sufficient, the one that makes the decision
> > which Rx routine should be called (zc or standard one). Given that bh are
> > disabled and updater respects RCU grace period IMHO pointer is valid for
> > current NAPI cycle.
> 
> So if we are already in the af_xdp handler, and update patch sets pool
> to NULL - the af_xdp handler will be fine with the pool becoming NULL?
> I guess it may be fine, it's just quite odd to call the function called
> _ONCE() multiple times..

Update path before NULLing pool will go through rcu grace period, stop
napis, disable irqs, etc. Running napi won't be exposed to nulled pool in
such case.

> 

