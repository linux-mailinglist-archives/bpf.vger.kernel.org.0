Return-Path: <bpf+bounces-61519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9775AE8279
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 14:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7174D1BC03CD
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 12:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D9725BF12;
	Wed, 25 Jun 2025 12:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DtHdAtZh"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB5B221DB2;
	Wed, 25 Jun 2025 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750853965; cv=fail; b=fa468cvnGy5Ss6T8ZVUl5y9Bn4Satiw6hdhjV3Bnws1GlMYZj9YswJsJmwJ1+Hy2y0fIfUMhfMbm5hFLhR/2JWZ8pHt6i3+EFHoGH3pdFjVgYcjJ+d5F5Hwaf1WYaS4TA7MgK3KWeHpbOgwgjw6eMYZMosHIt9qy2dYoqwpMPEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750853965; c=relaxed/simple;
	bh=Ey4YFWFj7nJrvZ9+9FLV9tyoADsdqQAQG7fpovVsnOw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lAkpvN4IPpdQp20QmIgcL2MjYjYqeQAL+3568PH4Dau/usml47m4N00lvygiehgc7crMyGNLH2g4pITc8/MysnRoi2gH9L1Bt/okCoRv+9nU2tG3gjv9EXmYO1kS0VQDqRDqevefsLJOyV+88KHGguYxsNQugaACT/QJh3+YYJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DtHdAtZh; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750853964; x=1782389964;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ey4YFWFj7nJrvZ9+9FLV9tyoADsdqQAQG7fpovVsnOw=;
  b=DtHdAtZhcHL6hJwgvoxPlJAuMUAJ2UiXaxcpUTJE0JmLtjj+efqaFonH
   1tgAe6O70sQxVCXcGCw6NZJaQmB1yONp6OkVXUIGxKKS5uCCcSzSWTgMX
   4h11fapB5oeo0ykg1P9uaGlzsVqhVU4IPcf31CyKbhlBbeVOv9PDpA826
   KRix/s9kPDNv2WInQW0b53XTUdXgvdPo3Whs38iEk+k0URT86VmvKvYSF
   GdQ1jEYBGy/fx7+lFPYmOLO4gGWBUskfMVZE97uX1nAC6E1NR3RbiCIAI
   6ICbe1SffGgkjB4CCXeVHwKeTgzCObUY4o/A4foCF6ITM30hxo5HoziVZ
   g==;
X-CSE-ConnectionGUID: EDi9KjDeRL608FZrWHlXKw==
X-CSE-MsgGUID: JO3Q/I/0QYuZzbwUwLZgzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53257056"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="53257056"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 05:19:18 -0700
X-CSE-ConnectionGUID: ZGArTz6bSxWnLY+dRW1rdQ==
X-CSE-MsgGUID: PVPBaywFT7GcPNrhIA1grw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="152378646"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 05:19:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 05:19:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 05:19:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.69)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 05:19:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2YBc1r+f3v/bpv+IrIc2vNcU1liJfBpec7LGtY01+DnczDFAi9w0ojeL16+RKs52ISKP/KJIW0AS2225J8fZCpDIap2ZXMmvmTJZprSj2j7ZAMe8SwVU4isMgFHA43wVAr/1SvwFOZm8pr35CqpGrJiCYCMeUg4QQvrZppjFDP0P/j8UnG+Te7qxTgFvxBbRukOBcPcHzg04402pHp2rprkr15aeBhqZZsSU5g3vNPzkPS0EHNcxzwSsmeuK7RGMwCT2EPr4vGFRgjBuCe5Q+xHa8amYAnvIIwuWtsEFBCoCWTTv/Thr8ZzlNzhaWHYytpmrgfy+wcxg7suI6NL2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJByjJVL+K2lw/jH6lGu3vC4o+x41d7hGN+zYD0J/vU=;
 b=sUYMxim+MKnJq3aanXzyUWVcqPe9MVA07T3fAAPwNYG1PLQ9wJKf0UPsVBGNxiTYVOGG13i4Po2HnpbQcGu7Mu5Yo5oThRRorQMrEufQw79oFKhQ+PYW/E/lP+ub7Q96rVdS2Ca7a7MWCe6KJfE+KAU4ZDN4geD5rsVfwrpAQAVuT4sAsAgza9NHespDWQrtcZEbAt4Q0ALyD42h6+3W/jDVZn3tM4BMX8znz5sblWXXPC3nOSRCbCgfzMiqWzblVg6XbuJJwLveK9BKchjSKiy5ajVC/Mw6YI55gn/Io9N7JlofTJkgPgyhFjGPLwTS9qVkBGhiA1iHFaf+SBJ2Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY8PR11MB7800.namprd11.prod.outlook.com (2603:10b6:930:72::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.16; Wed, 25 Jun 2025 12:19:14 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 12:19:14 +0000
Date: Wed, 25 Jun 2025 14:19:00 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<joe@dama.to>, <willemdebruijn.kernel@gmail.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3 2/2] selftests/bpf: check if the global
 consumer of tx queue updates after send call
Message-ID: <aFvpNHqvZp0eishZ@boxer>
References: <20250625101014.45066-1-kerneljasonxing@gmail.com>
 <20250625101014.45066-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250625101014.45066-3-kerneljasonxing@gmail.com>
X-ClientProxiedBy: VI1PR0202CA0013.eurprd02.prod.outlook.com
 (2603:10a6:803:14::26) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY8PR11MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: 134ea33b-fd3f-4ef3-a394-08ddb3e27f8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EXzNJhuMb7fWoXJ3nJSCTuaA7+Ce9EshVgaZdL6fw1Y2a3OGYaZ2Xrz8MNz5?=
 =?us-ascii?Q?z8zlMbvQdMz/TEaRXzqt7sMhSoAWiTcc8l2JHoV01iitn4EBHDrHTPlaAAxz?=
 =?us-ascii?Q?HYwH21Zy8nsOWCl0AdcKoa6pifNmXVUCOwBgrEXa1DfpjF5JOndfiooL3NJz?=
 =?us-ascii?Q?cUbzcAl8E4CFoSzfzv0vzKiw5d5qvvEXPL/Y4oVv/vfKKk89p9Q353Z84JIb?=
 =?us-ascii?Q?LNjrrABgMBDMDvXBQj77+KuCLMKnH/yVx1PSFMlYfwziMKL3tnjGX5537D9G?=
 =?us-ascii?Q?zWgOekILS2eiWU4O68ra7wTx1XYu3aibAqtJ00FdmGfEh6bRLAxaDZcQvf9q?=
 =?us-ascii?Q?pE0cyXyB8cyhSQqOS7wSHdilkCLOVwMHPkM6RqowpooQ1L3bi2itRnlF4AnS?=
 =?us-ascii?Q?8h+NAZ9qJ0y+fHsFrvSwQfwklZmgVVlWjoWBmSfHsm/4mCtJgNFW1xW1LhWC?=
 =?us-ascii?Q?j5dl1NhrCzjVj0hdq7G98XlJiYZU8QvT9dJP8SUO0qThh7h2UXiEPmCctInZ?=
 =?us-ascii?Q?V1cnUSFJsN6VtpCzFUi+9Zjvx6LJfY0e2R8no2E3z49aXpPuNX38kxFFgcOl?=
 =?us-ascii?Q?ZHsBzoWPWmcM3l9GvFvroW55uXdwcQIyFwcEZy3bMYkKrcWS7RAwL4SN/rBQ?=
 =?us-ascii?Q?IcB2rDsDOZG2AMFKQ1Y+oT20ScMV2OIErc7yacngqdKIxt4cbYyh4pl41i5m?=
 =?us-ascii?Q?DqwkFEcUu5ciRxZsXseb0NLdror8xBGJ9pb2D3ScDT/ipphrWyZPANZ6On3l?=
 =?us-ascii?Q?+kx4jN3FvIhKGe/UIKrjXPM06twevfQkAWm5rUm8IIgXhCEkppuYq7leD0e/?=
 =?us-ascii?Q?5WdKv2kN5KaOrsXjahTd/nKYXIaJ4HWPWXJjnx0Omcalg5VLiCs+1sQLPX1R?=
 =?us-ascii?Q?Nt8kRW+XX0LhTUSPThCEvCAjoyefm2GkDH36LjELnAsV3+xnqop7TAT//uC5?=
 =?us-ascii?Q?jEPFPfbPZmmnCFrvVb/KOAomYo6xrz7meWMM55w0II+xTadeFcTxZwUj7wqI?=
 =?us-ascii?Q?8iDsKcWGC0fDsMilrPjh5EtCIrJzxCRzIO1VveivzNFD/9LCmcOpF/5zPq+Y?=
 =?us-ascii?Q?Y3GIj7PqNn2kiLRw0pKRM4EniOyPOo8hzTg28BYI3HnvJiG6SeWadYV77aaw?=
 =?us-ascii?Q?7nn0h0LAJougAAyUzdJDxlh/7Lh197inoejhzeWDconrsiomwfMv4j2c/aLo?=
 =?us-ascii?Q?blFksRROZAc8f6lzqQbY1ZbJIEGhml1A75yh0d1ExU2Hr66comdaw/xHRMg+?=
 =?us-ascii?Q?rIqMXSwTmaVPn87DBh4Fmc4LbCzBt0EWEbuKoYlg6XkCZA4q1SwJljJ4clBp?=
 =?us-ascii?Q?l/0hvviRf0Hga4qjDB4tHCim26RGxOQpQ21g2HCKXUUfEf0Akw0eFBWgGA5X?=
 =?us-ascii?Q?zN80FCdBoqsD6B25Y5HZbykiTJaEcNeFzqmSa+8bCbbT8owAFOZTy7H7TPRQ?=
 =?us-ascii?Q?JAas78zp0EE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jzjbVYSwMVcAKguddgI+sovTSaD975QCy/7hHeeRsx1AKQlBFQu8CfAQ/sHO?=
 =?us-ascii?Q?7Ni1UfGbfwYmDl5eQGvEggPm2NVYFB9f63Cf4rPI4WiKVUUKMIdhtv7yqtK5?=
 =?us-ascii?Q?Y2ZhNztipZE1IynM/+/+5VeDit8DV5ifWb8ujAoKlBiidRl8LoMTdCJkP3qi?=
 =?us-ascii?Q?LZYjvtfZpT+dcSkT28rdB0lDxTO3z/YLblkrDv8R6jgKIFJ7ILzLAbIFefOg?=
 =?us-ascii?Q?xYqPlBlaagmRqxsO0bLtueWOrGBvDGg7rvo/77rzMAJj5UKLNu1YZt8++kRm?=
 =?us-ascii?Q?qyCbVglO1jpqstzi7loRgcaOoWBZV4z2rKBbME6GoEyzVeHi4uCOK5II3gLO?=
 =?us-ascii?Q?MMPp8bzP2r/HCzZtzqW6h1FQZwb+lgEKtvHAvrfseMtPqXx4Oq6mKGddaOcM?=
 =?us-ascii?Q?I88h5IPUywMJvnfcsqzYnO83fC7Fsff1985GP/59P3+4cxgbd6AQkvQYLuZy?=
 =?us-ascii?Q?jagPFeOE0OOeqs2HShQ1KFLDiU2RnE+0tEmk0yCp/sUS0F5Zgna4ClJ5q453?=
 =?us-ascii?Q?gVGE4FRqXwbvtGX6AQlcm4ESxEcUPHYxTyZ6I2eAVICCAaITbAv7slq01aa6?=
 =?us-ascii?Q?aU2QLzcEuIR92a4rCK/gsj5i7rC3GAH4KeRq04NkvFebh859Y8X0AnNfFdW5?=
 =?us-ascii?Q?OM48VWv2fEB1yK7yqZGj1LoiYvj2sNZOkHpktFmn8rQ7qPGyiPIjCZXzLzWo?=
 =?us-ascii?Q?XWRftoTvetTBNlQas3XkGwbx7/miCmOE31VTAuxnJ0Xt/Dw+/Vn8eeO3ZJ4W?=
 =?us-ascii?Q?7M4ITorM4aiiDvHQgi8OkVUVRoeCIUYs0f1/MZiRokcTUTyxT9k1iEd5tIcG?=
 =?us-ascii?Q?Q0E5lhV1nyWZBy0gyqUp9wETTJv5j9QDx9d10p3iMH7+oTKe3+RABGGCgx/3?=
 =?us-ascii?Q?kDPo5ECY48+UuEfc5iM/h8F3S4d5hRZKdZigqHgB/mmY7ZkoElRLwZg+al76?=
 =?us-ascii?Q?mSbQgjSR9GRniFipgZsr6Y0ddU1UJHzPl8UMsuknZ4tShsHBCbjzrYwS2/Ax?=
 =?us-ascii?Q?kk9/mRAI/yiEGoca6Hh2ONXn63Ex2d03OUSDJ6uHqmdDTjTQ9k38mRoKQl2N?=
 =?us-ascii?Q?6lWkBUxh7Z/0qEK1F+mRKJrPTEJF35JShYMzScdK+wpgN5d6JeiSpsPvDGxu?=
 =?us-ascii?Q?EexFd1ij5R5gU38kxxkbzYFNgShPhRCqviATWPq9ITshPhMLFex1bfcJgMLp?=
 =?us-ascii?Q?Qh9hZsQKlbz/za8aiEjULDwKgJq6aMfKNA17C0QQxBq1KDdkUIZ6IbUS2nT4?=
 =?us-ascii?Q?mNpu92CjW/dVeg0/EkG7n98WK6HwOilfw4vNHPDLCYHh1/FKSVFSKNAU7K6N?=
 =?us-ascii?Q?fZQ6+apvCVMdReKxwE+fPWAozhRrV3VRNqVpUiBOWJ4aoPlO3ogRTo2/wUhb?=
 =?us-ascii?Q?Y2b1UMrt+oJ2Cjvbpt+w6MjQohc02BVy0cgdq1eUpcL+TfK8TjvZpoq+9ZUg?=
 =?us-ascii?Q?IcNz/4xHWxD460EnaQsuKodNglgR9xSqleqAXqsPJShd90dI50DmleZamngB?=
 =?us-ascii?Q?fhNjjMc+bHwMXU38f9XgnVj+QCn+jvNeqmqZeDTITcJ2hUZhvgkuJEnaMRD4?=
 =?us-ascii?Q?AqOjQvEiSDu6EdvIyGSoPvD1Mcd1dG+akMSmYLVjDNdCOsEtGm/9M5PSUCwn?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 134ea33b-fd3f-4ef3-a394-08ddb3e27f8b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 12:19:14.2382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QaQETpV0YAhMmf7lKBhjxGU/mJIUSGCtq7GPFmKDxMS0pFdPXVozhDMevIpMVFCFVqOZ9DJ3Fpxxo0V1tAgc7tdsvOfkCBsK3gQgVOVgzj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7800
X-OriginatorOrg: intel.com

On Wed, Jun 25, 2025 at 06:10:14PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The subtest sends 33 packets at one time on purpose to see if xsk
> exitting __xsk_generic_xmit() updates the global consumer of tx queue
> when reaching the max loop (max_tx_budget, 32 by default). The number 33
> can avoid xskq_cons_peek_desc() updates the consumer, to accurately
> check if the issue that the first patch resolves remains.
> 
> Speaking of the selftest implementation, it's not possible to use the
> normal validation_func to check if the issue happens because the whole
> send packets logic will call the sendto multiple times such that we're
> unable to detect in time.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 30 ++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 0ced4026ee44..f7aa83706bc7 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -109,6 +109,8 @@
>  
>  #include <network_helpers.h>
>  
> +#define MAX_TX_BUDGET_DEFAULT 32

and what if in the future you would increase the generic xmit budget on
the system? it would be better to wait with test addition when you
introduce the setsockopt patch.

plus keep in mind that xskxceiver tests ZC drivers as well. so either we
should have a test that serves all modes or keep it for skb mode only.

> +
>  static bool opt_verbose;
>  static bool opt_print_tests;
>  static enum test_mode opt_mode = TEST_MODE_ALL;
> @@ -1323,7 +1325,8 @@ static int receive_pkts(struct test_spec *test)
>  	return TEST_PASS;
>  }
>  
> -static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, bool timeout)
> +static int __send_pkts(struct test_spec *test, struct ifobject *ifobject,
> +		       struct xsk_socket_info *xsk, bool timeout)
>  {
>  	u32 i, idx = 0, valid_pkts = 0, valid_frags = 0, buffer_len;
>  	struct pkt_stream *pkt_stream = xsk->pkt_stream;
> @@ -1437,9 +1440,21 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
>  	}
>  
>  	if (!timeout) {
> +		int prev_tx_consumer;
> +
> +		if (!strncmp("TX_QUEUE_CONSUMER", test->name, MAX_TEST_NAME_SIZE))
> +			prev_tx_consumer = *xsk->tx.consumer;
> +
>  		if (complete_pkts(xsk, i))
>  			return TEST_FAILURE;
>  
> +		if (!strncmp("TX_QUEUE_CONSUMER", test->name, MAX_TEST_NAME_SIZE)) {
> +			int delta = *xsk->tx.consumer - prev_tx_consumer;

hacking the data path logic for single test purpose is rather not good.
I am also not really sure if this deserves a standalone test case or could
we just introduce a check in data path in appropriate place.

> +
> +			if (delta != MAX_TX_BUDGET_DEFAULT)
> +				return TEST_FAILURE;
> +		}
> +
>  		usleep(10);
>  		return TEST_PASS;
>  	}
> @@ -1492,7 +1507,7 @@ static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
>  				__set_bit(i, bitmap);
>  				continue;
>  			}
> -			ret = __send_pkts(ifobject, &ifobject->xsk_arr[i], timeout);
> +			ret = __send_pkts(test, ifobject, &ifobject->xsk_arr[i], timeout);
>  			if (ret == TEST_CONTINUE && !test->fail)
>  				continue;
>  
> @@ -2613,6 +2628,16 @@ static int testapp_adjust_tail_grow_mb(struct test_spec *test)
>  				   XSK_UMEM__LARGE_FRAME_SIZE * 2);
>  }
>  
> +static int testapp_tx_queue_consumer(struct test_spec *test)
> +{
> +	int nr_packets = MAX_TX_BUDGET_DEFAULT + 1;
> +
> +	pkt_stream_replace(test, nr_packets, MIN_PKT_SIZE);
> +	test->ifobj_tx->xsk->batch_size = nr_packets;
> +
> +	return testapp_validate_traffic(test);
> +}
> +
>  static void run_pkt_test(struct test_spec *test)
>  {
>  	int ret;
> @@ -2723,6 +2748,7 @@ static const struct test_spec tests[] = {
>  	{.name = "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func = testapp_adjust_tail_shrink_mb},
>  	{.name = "XDP_ADJUST_TAIL_GROW", .test_func = testapp_adjust_tail_grow},
>  	{.name = "XDP_ADJUST_TAIL_GROW_MULTI_BUFF", .test_func = testapp_adjust_tail_grow_mb},
> +	{.name = "TX_QUEUE_CONSUMER", .test_func = testapp_tx_queue_consumer},
>  	};
>  
>  static void print_tests(void)
> -- 
> 2.41.3
> 

