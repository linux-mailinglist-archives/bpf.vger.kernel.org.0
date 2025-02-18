Return-Path: <bpf+bounces-51839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 300FAA3A09F
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 15:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE794188B02F
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 14:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823C826A1CE;
	Tue, 18 Feb 2025 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BY4XQ3/O"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C5426A0D2;
	Tue, 18 Feb 2025 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890701; cv=fail; b=Q7XymxMtY0VlKHUAoBNWamaw7M9eG4sEMlqLv0K7ha2nhRxdJKygp2ctmiFdsYFv/RpqYFERhEdvHmtFqhv4W4CjCEX0Y8GxyM/0Ga5xvjW6JYiHchGlHv3XOk7zxNoWBOv6zbOTFen2J0ZMe6JwJUOTxIAJ+EPgchjY6e7SyCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890701; c=relaxed/simple;
	bh=/B1T2oFhmGSJYNynuyrpqFCixRZXgI7QEakbIwyBO70=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QBM6aovYuIEDCZbFt7F2NWv+CiC0cu+wnEK0XJ7lMRCjuBLUGAYk4MFeZyLhG3GwbFP5ZUNaYIG8yKq/v/7scxIkeuvXtIY7IWFdop5006PamoGx313Aub17bTiR3N8KjK3qEiDh8vkc97q74o04gOEwkKLa1xai9fqClHDTW2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BY4XQ3/O; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739890698; x=1771426698;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/B1T2oFhmGSJYNynuyrpqFCixRZXgI7QEakbIwyBO70=;
  b=BY4XQ3/OnoENwkQbiyBVRm/3R+kW64g63RU7G+FIldBgYCY+iUOpbSKf
   o5iSJS1LwUbwmJjBd92PkZOESL/eZZiDoc5G4TZRj3Gb0wZzIEe8hpAvQ
   NkkHP30CENlHsdt4Nv8P5lZW3TokMuKwWbbxz/ObuH020M6CELJ+M0z6L
   nL237zuMjUD8l9mwObV0Eug90zF7CvSJt92DUH8xwbc4Cw47lD58oPok2
   mCYGUSDpiK9hrXKHdfkt3QxSVrtZDe31F0eA1ntlSy8cy6q/nxTBCHWdw
   ejhvz3zBuu5ZZVM5NovbD1WVqHqBBXg1vHyIFozhJE0OFi9jJoeKuyL2n
   A==;
X-CSE-ConnectionGUID: 5QSXatrHRSW+Oyxsi8UNYw==
X-CSE-MsgGUID: FxutcxH6TMyaPsoPl62xvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44238852"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="44238852"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 06:58:17 -0800
X-CSE-ConnectionGUID: d9z5WzkiSMmI1p/1K9k0WA==
X-CSE-MsgGUID: 5Qqal0fwRG2UDEF7YIZ2XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="137658514"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2025 06:58:16 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Feb 2025 06:58:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 18 Feb 2025 06:58:16 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 06:58:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuMeunyqxvrMki5XZHJ4ITiGjBDD7RNj4zjBn+U/PF8n3kYZhGNwq6PnnvkA2gN/xhH4HKEnShQgS83rnTWY4f+LubaYeYGSbfqYPOly8+mf7lOr7GitsRNDSZEGRbI8duGelMlqvDlMC5svgDIJ/14bWGjmRLjsqmWnWCOY1v6+cKMV1SzpfbhZ6InzteOHUp4N//7aCSBKs28yHFIF1aOZ6Ydql1U2ufM5sYc7y10HxsLnIWiOQU/z0Io5MCPA+RGPzOOHhP8a+gQLARqprMZphtRkZb5eFe4EPMaTjopYZSQX1XeCMacA6s/QBcPGH8jzfn++9EAl/b8c7v9oJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMXhWpITjfXU8SvNA8b71E9dmkGXKXMF0wLQlLjIP50=;
 b=kQg1phIV31/i5DJm+YtE7L6xb2vHGyOK0noSMQVzST6kcZxCB+FCGZ7qE7YZROVlj+NnqdrU9krzEQ5WWNWHCKulqoaj613ZUMAHZoo2t+U01I/RWYmHiz8k3lBMEiLXHX1cLzG2RPWBbwN1SqHVyvut3VlmPSIl2ZXl5s3A578y3ZL0h2MI/S2tPKXx1j2BjP81ch+uyFgNQYz78aqA+WcJJb1aUPBIzrbPb+kBF7OtHqSASQwLrlP5iTlGYORqQXlRcC6x+ebmSQv1biSCfdacbdDrAyZnWc3mvl9fGy4LamY1iw04vf02uQqmR8dmVDdfR8ZzuA1m6daWYk/IWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by IA1PR11MB7726.namprd11.prod.outlook.com (2603:10b6:208:3f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Tue, 18 Feb
 2025 14:58:10 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 14:58:10 +0000
Date: Tue, 18 Feb 2025 15:57:57 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Suman Ghosh <sumang@marvell.com>
CC: <horms@kernel.org>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lcherian@marvell.com>, <jerinj@marvell.com>, <john.fastabend@gmail.com>,
	<bbhushan2@marvell.com>, <hawk@kernel.org>, <andrew+netdev@lunn.ch>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <bpf@vger.kernel.org>,
	<larysa.zaremba@intel.com>
Subject: Re: [net-next PATCH v6 3/6] octeontx2-pf: AF_XDP zero copy receive
 support
Message-ID: <Z7Sf9VksFLFq2GwA@boxer>
References: <20250213053141.2833254-1-sumang@marvell.com>
 <20250213053141.2833254-4-sumang@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250213053141.2833254-4-sumang@marvell.com>
X-ClientProxiedBy: DB8PR04CA0008.eurprd04.prod.outlook.com
 (2603:10a6:10:110::18) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|IA1PR11MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 84754a92-e390-414e-05c5-08dd502ca93c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b6l5oEb02Pk6Of1adovYsEx3Gs1USAbwI7VhG28E98fEW9gTaIIMLvXRutPN?=
 =?us-ascii?Q?qJJQYHuW2z40RaDhBjZ51yPhyRLKb/RmAn99/yrpvmhH3uH1zfnXBbzkeoxH?=
 =?us-ascii?Q?6t8dQozu4xT0n1XSneuxrG5dT88TCuSaAsVQLLGWpgHYJaUiVgoqj/fq3tz9?=
 =?us-ascii?Q?GwMlv9jzUmgeesWA4uRuP/7HgOFlz+gY6CFO2oR3Z/1svNo7rDQJUaVf3uLW?=
 =?us-ascii?Q?FQeEHE4hzHbQy0SUA9PEAdGzRdp+QlnRJAFX9FyqceQCQUHPWsvKeedflUrX?=
 =?us-ascii?Q?nOokB77hXZc4kp5B+ESsfxhPQHTFIhGw1FGpfpFT9vfsbPLv8nDdYysuS+iT?=
 =?us-ascii?Q?mUvqdoXLcmHDkBMf9JDOu07cYm3jRw3N6bNKS07Z+/LLWaxuTLB2zSNl5ipJ?=
 =?us-ascii?Q?WMm9etDdkElRKTHmEeaFrEGntzbaIjel3jqKEzxVQ9AET81mOstvqmb4ejDV?=
 =?us-ascii?Q?HkYOKZetJ7jmaWsqs8/mhYZqk9td7xlBJ1CslvsnKNMaZnXcjMrYok33CaJ7?=
 =?us-ascii?Q?Sg9Ot98QuiIA2UgJRXYnEhlHyLjUPmdij2sEWy7QuTgy/xtrygX0kP/g3bYS?=
 =?us-ascii?Q?3BSh5tYGZDG0A7lBeoapRFL+3D3wlf5A/dI/UEvq18gYLxO4ZvJQ00dKvCW7?=
 =?us-ascii?Q?TJpAHLhxM+/VrqSZpEyByvCh9pegXebDI6kUlfwFMl7QoIqmJlRR8SrCn0PS?=
 =?us-ascii?Q?iSRuFWRhTOKyQlRoOrXKFvjeuL4HK5fVC7/ew4s+UGkd6ll1bH0tk9IK2f3x?=
 =?us-ascii?Q?H6jRjt0hOF6Le4OPc7qacG4GLSz6PfuLTq3+qf/HTSJJyYt/Vss7oEGOY/T6?=
 =?us-ascii?Q?VZv/7euCNRH7+nvAl/ODQTNIzMAveAfiv1RUXF18L+LbLc+1cimszhC7R0Nb?=
 =?us-ascii?Q?31H/JJGxM9FlyTifqViIoYR7+ynOIYzBZsa+vwxXS0zVrcmJc/fwmu8s841M?=
 =?us-ascii?Q?5md25b23kV9vO86TUzO7g7SF3nLP2asMp+4t0zSJCSBUGItNn/wq631dKhjJ?=
 =?us-ascii?Q?CpbA/BoLl/+5s6kGX73XJfc3dZ+Y2+fN4rjlXc1yxUVjSN7heVjwkPRBMJKH?=
 =?us-ascii?Q?DzCnsZM0wTqHCkoMJHy7xeOdV7d2paj9NEVTyqGUWBnf5p5ZAaGyrYG/xF34?=
 =?us-ascii?Q?JfDW2uyHLxw9m8pTk/DR+j/iy8lWKvKXhZWBidGEXu6IVR2ztC0+VERFFVnE?=
 =?us-ascii?Q?G3k7iwlnhXrBiLMD/Rapk2wv+TeD37rZQJr2vtmVeejtFcfTWVBvudu4eFMJ?=
 =?us-ascii?Q?nOofyPm5pN+Uh2sYGWIl19Q0/QIaSJzukvORM9D2yv4ZY39jhctOpjreGscB?=
 =?us-ascii?Q?8ZYG4bcpk5Lr0wVsqtVFT2I07LMBz4GoDkO7kaM0osWHkQTRba5AysbSjM9J?=
 =?us-ascii?Q?UGyFG2CojLhFLzu+6etwgaZtj+4J?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RyG71yimxu7d+0MpGHon8mCYrwq3m8NNG9tZJMJBmQaYrk0odLrNiAGjbraF?=
 =?us-ascii?Q?1whu4moDEug3vTfakndJPD9Ueo30nfn+Pd2O5CUu0Uw/81lClyZxozVpdDDm?=
 =?us-ascii?Q?BjmJFaw4zZDm9zWusByb6cs5XwnFcHbw5uxWTLZWRIE9VuOVEar5HODkxI8c?=
 =?us-ascii?Q?LXoski/ycpVVA1QlJ8nXq7pocT4nURVInqK4qd2iTflSlNGDEEPRhL4xPOlb?=
 =?us-ascii?Q?aXRU8PWtbugxc/vsmL6XtpKqcFUPQVtExfpxtLtlyWh7zZfcvoZ+Ro36KXlz?=
 =?us-ascii?Q?iQ7t6H1gMZyEMh7tiRH4qcQsza+OhCigq0Jr3BcgTmq+V+b3lOcnZmTqrjzy?=
 =?us-ascii?Q?lAMQIXA299xVzItNGHABzLjSMBQTAs44Ep6Qt9XTXCp/uDdgBTz1Lu5owTg9?=
 =?us-ascii?Q?bmCc5Bg+/6ry8987y40601/cdY4VHZpN9KQ2N5aqz4mtl7h4QOklDZN8Muq8?=
 =?us-ascii?Q?VWzs7g8rnTq02Fh3CCTZUcilRbLel1dzMk6wRcCjFa0AHB2fkZcpsA46NAOR?=
 =?us-ascii?Q?zJuYKr0rEt+3OomQ0ymXVNve8EkQStjB7PLGZkPj+cTuKi+vlMgabFTpF1L2?=
 =?us-ascii?Q?NhQqLL65BBvthuHas+ZKVKbXBNrUhGmkqbg8CHZcY2VmDjGf+/sl6T2wtx8S?=
 =?us-ascii?Q?AgzAyDc3f8XVq6zTKG2PbDIXJ79HeWsX2S8y1yu5Q3LkGm6BgLPyNabzxWdv?=
 =?us-ascii?Q?LZ3ZG/9IcOS9+6lXNto2a0Dp83wqJmfgZLkt71mzNVL3oixC65Ok9WIoazGE?=
 =?us-ascii?Q?CTL1knwBcxDGJMR15xZu73zN8d8wOO6T/b937pF58RsWrIOZ7kQHUEhJtC1q?=
 =?us-ascii?Q?LMZ7X9Je6+3HYuERa6UjtNGiEtYC7gjEL0vFPwDwYXe8Z7SKzVbEIOCM665q?=
 =?us-ascii?Q?hx05aG+vUsbiMzY7KeVr6KKgrUQOV9Ut+VhRvJHOvymDSnRTarzlpcrMuNv4?=
 =?us-ascii?Q?Ei8ZYwleeH3y3fPuf2nQw5pWas999Xb01kQr4tXHwhJ+HOUoUoTfwfCmnaro?=
 =?us-ascii?Q?BGwyuzD3hhYNIdsCVe9vG0sBQ07S+HwwgIqRw8/1WB9HoSMY6IRxhpgyXwmX?=
 =?us-ascii?Q?uQFj5Y71X39nuOUNcWGk2PB27zKuxdy1gIoGduIrDh5KLyf1adQkO0sHba6G?=
 =?us-ascii?Q?FBMxUP59HnwyIkhoTUQ3dsN5DJdncTLZ6g9WBGP8a5uFsRf7j/0CYfRX/D8w?=
 =?us-ascii?Q?4+0Plt3x92tgfNFhCBJpv+aw+hkGzrQVxRLiCApOlht7GGyMgkGdnSzuhXDq?=
 =?us-ascii?Q?bDDFni+88ucZUpNWgbxiTVuuY0Kh9d7MG1FPaGLGhQvDbwL5tmdKOF7Kwd5F?=
 =?us-ascii?Q?FBSkadurMM4vumdyrv2xN6fs1OsJQ4AMPVNqfu3SDlK1I//i/Yapm0C3TBQX?=
 =?us-ascii?Q?10jPrHSbRmf5MnlFpqjjCDmk9jw8l3qwZGGOAZkSiZlYUSczrpAYTXkO1rNF?=
 =?us-ascii?Q?1yRtRD/g9BX0L6kM4F/FHq8lQ2IE15QX1z2feu08M3RHjNzjzSd34FPMm1Bq?=
 =?us-ascii?Q?H5xtJBpSBXcWUlXtLrvwFaXe3m+D/BFYDb5rEz3OclARxw0wLrjzNSGd8qO1?=
 =?us-ascii?Q?9voXjD+TdhIBT5HSw81Gzh+ULYg6r8h70/oO1SsDlqTCb0+QeEEUVILzx4i9?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84754a92-e390-414e-05c5-08dd502ca93c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 14:58:10.6622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJEjRyZfEEmSSEizXyYZFxx6C9Rdrv75gXcLA1Q+5sUna3seJI3IX1scFayDwEW3Cx/porWPTIkwkO4Z+pSI/pczvCntTAaYGNq541QQCt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7726
X-OriginatorOrg: intel.com

On Thu, Feb 13, 2025 at 11:01:38AM +0530, Suman Ghosh wrote:
> This patch adds support to AF_XDP zero copy for CN10K.
> This patch specifically adds receive side support. In this approach once
> a xdp program with zero copy support on a specific rx queue is enabled,
> then that receive quse is disabled/detached from the existing kernel
> queue and re-assigned to the umem memory.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
>  .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +-
>  .../ethernet/marvell/octeontx2/nic/cn10k.c    |   7 +-
>  .../marvell/octeontx2/nic/otx2_common.c       | 114 ++++++++---
>  .../marvell/octeontx2/nic/otx2_common.h       |   6 +-
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  25 ++-
>  .../marvell/octeontx2/nic/otx2_txrx.c         |  73 +++++--
>  .../marvell/octeontx2/nic/otx2_txrx.h         |   6 +
>  .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  12 +-
>  .../ethernet/marvell/octeontx2/nic/otx2_xsk.c | 182 ++++++++++++++++++
>  .../ethernet/marvell/octeontx2/nic/otx2_xsk.h |  21 ++
>  .../ethernet/marvell/octeontx2/nic/qos_sq.c   |   2 +-
>  11 files changed, 389 insertions(+), 61 deletions(-)
>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.h
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
> index cb6513ab35e7..69e0778f9ac1 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
> @@ -9,7 +9,7 @@ obj-$(CONFIG_RVU_ESWITCH) += rvu_rep.o
>  
>  rvu_nicpf-y := otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
>                 otx2_flows.o otx2_tc.o cn10k.o otx2_dmac_flt.o \
> -               otx2_devlink.o qos_sq.o qos.o
> +               otx2_devlink.o qos_sq.o qos.o otx2_xsk.o
>  rvu_nicvf-y := otx2_vf.o
>  rvu_rep-y := rep.o
>  
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> index a15cc86635d6..c3b6e0f60a79 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> @@ -112,9 +112,12 @@ int cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
>  	struct otx2_nic *pfvf = dev;
>  	int cnt = cq->pool_ptrs;
>  	u64 ptrs[NPA_MAX_BURST];
> +	struct otx2_pool *pool;
>  	dma_addr_t bufptr;
>  	int num_ptrs = 1;
>  
> +	pool = &pfvf->qset.pool[cq->cq_idx];
> +
>  	/* Refill pool with new buffers */
>  	while (cq->pool_ptrs) {
>  		if (otx2_alloc_buffer(pfvf, cq, &bufptr)) {
> @@ -124,7 +127,9 @@ int cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
>  			break;
>  		}
>  		cq->pool_ptrs--;
> -		ptrs[num_ptrs] = (u64)bufptr + OTX2_HEAD_ROOM;
> +		ptrs[num_ptrs] = pool->xsk_pool ?
> +				 (u64)bufptr : (u64)bufptr + OTX2_HEAD_ROOM;
> +
>  		num_ptrs++;
>  		if (num_ptrs == NPA_MAX_BURST || cq->pool_ptrs == 0) {
>  			__cn10k_aura_freeptr(pfvf, cq->cq_idx, ptrs,
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 161cf33ef89e..92b0dba07853 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -17,6 +17,7 @@
>  #include "otx2_common.h"
>  #include "otx2_struct.h"
>  #include "cn10k.h"
> +#include "otx2_xsk.h"
>  
>  static bool otx2_is_pfc_enabled(struct otx2_nic *pfvf)
>  {
> @@ -549,10 +550,13 @@ static int otx2_alloc_pool_buf(struct otx2_nic *pfvf, struct otx2_pool *pool,
>  }
>  
>  static int __otx2_alloc_rbuf(struct otx2_nic *pfvf, struct otx2_pool *pool,
> -			     dma_addr_t *dma)
> +			     dma_addr_t *dma, int qidx, int idx)
>  {
>  	u8 *buf;
>  
> +	if (pool->xsk_pool)
> +		return otx2_xsk_pool_alloc_buf(pfvf, pool, dma, idx);
> +
>  	if (pool->page_pool)
>  		return otx2_alloc_pool_buf(pfvf, pool, dma);
>  
> @@ -571,12 +575,12 @@ static int __otx2_alloc_rbuf(struct otx2_nic *pfvf, struct otx2_pool *pool,
>  }
>  
>  int otx2_alloc_rbuf(struct otx2_nic *pfvf, struct otx2_pool *pool,
> -		    dma_addr_t *dma)
> +		    dma_addr_t *dma, int qidx, int idx)
>  {
>  	int ret;
>  
>  	local_bh_disable();
> -	ret = __otx2_alloc_rbuf(pfvf, pool, dma);
> +	ret = __otx2_alloc_rbuf(pfvf, pool, dma, qidx, idx);
>  	local_bh_enable();
>  	return ret;
>  }
> @@ -584,7 +588,8 @@ int otx2_alloc_rbuf(struct otx2_nic *pfvf, struct otx2_pool *pool,
>  int otx2_alloc_buffer(struct otx2_nic *pfvf, struct otx2_cq_queue *cq,
>  		      dma_addr_t *dma)
>  {
> -	if (unlikely(__otx2_alloc_rbuf(pfvf, cq->rbpool, dma)))
> +	if (unlikely(__otx2_alloc_rbuf(pfvf, cq->rbpool, dma,
> +				       cq->cq_idx, cq->pool_ptrs - 1)))
>  		return -ENOMEM;
>  	return 0;
>  }
> @@ -884,7 +889,7 @@ void otx2_sqb_flush(struct otx2_nic *pfvf)
>  #define RQ_PASS_LVL_AURA (255 - ((95 * 256) / 100)) /* RED when 95% is full */
>  #define RQ_DROP_LVL_AURA (255 - ((99 * 256) / 100)) /* Drop when 99% is full */
>  
> -static int otx2_rq_init(struct otx2_nic *pfvf, u16 qidx, u16 lpb_aura)
> +int otx2_rq_init(struct otx2_nic *pfvf, u16 qidx, u16 lpb_aura)
>  {
>  	struct otx2_qset *qset = &pfvf->qset;
>  	struct nix_aq_enq_req *aq;
> @@ -1041,7 +1046,7 @@ int otx2_sq_init(struct otx2_nic *pfvf, u16 qidx, u16 sqb_aura)
>  
>  }
>  
> -static int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
> +int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
>  {
>  	struct otx2_qset *qset = &pfvf->qset;
>  	int err, pool_id, non_xdp_queues;
> @@ -1057,11 +1062,18 @@ static int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
>  		cq->cint_idx = qidx;
>  		cq->cqe_cnt = qset->rqe_cnt;
>  		if (pfvf->xdp_prog) {
> -			pool = &qset->pool[qidx];
>  			xdp_rxq_info_reg(&cq->xdp_rxq, pfvf->netdev, qidx, 0);
> -			xdp_rxq_info_reg_mem_model(&cq->xdp_rxq,
> -						   MEM_TYPE_PAGE_POOL,
> -						   pool->page_pool);
> +			pool = &qset->pool[qidx];
> +			if (pool->xsk_pool) {
> +				xdp_rxq_info_reg_mem_model(&cq->xdp_rxq,
> +							   MEM_TYPE_XSK_BUFF_POOL,
> +							   NULL);
> +				xsk_pool_set_rxq_info(pool->xsk_pool, &cq->xdp_rxq);
> +			} else if (pool->page_pool) {
> +				xdp_rxq_info_reg_mem_model(&cq->xdp_rxq,
> +							   MEM_TYPE_PAGE_POOL,
> +							   pool->page_pool);
> +			}
>  		}
>  	} else if (qidx < non_xdp_queues) {
>  		cq->cq_type = CQ_TX;
> @@ -1281,9 +1293,10 @@ void otx2_free_bufs(struct otx2_nic *pfvf, struct otx2_pool *pool,
>  
>  	pa = otx2_iova_to_phys(pfvf->iommu_domain, iova);
>  	page = virt_to_head_page(phys_to_virt(pa));
> -
>  	if (pool->page_pool) {
>  		page_pool_put_full_page(pool->page_pool, page, true);
> +	} else if (pool->xsk_pool) {
> +		/* Note: No way of identifying xdp_buff */
>  	} else {
>  		dma_unmap_page_attrs(pfvf->dev, iova, size,
>  				     DMA_FROM_DEVICE,
> @@ -1298,6 +1311,7 @@ void otx2_free_aura_ptr(struct otx2_nic *pfvf, int type)
>  	int pool_id, pool_start = 0, pool_end = 0, size = 0;
>  	struct otx2_pool *pool;
>  	u64 iova;
> +	int idx;
>  
>  	if (type == AURA_NIX_SQ) {
>  		pool_start = otx2_get_pool_idx(pfvf, type, 0);
> @@ -1312,16 +1326,21 @@ void otx2_free_aura_ptr(struct otx2_nic *pfvf, int type)
>  
>  	/* Free SQB and RQB pointers from the aura pool */
>  	for (pool_id = pool_start; pool_id < pool_end; pool_id++) {
> -		iova = otx2_aura_allocptr(pfvf, pool_id);
>  		pool = &pfvf->qset.pool[pool_id];
> +		iova = otx2_aura_allocptr(pfvf, pool_id);
>  		while (iova) {
>  			if (type == AURA_NIX_RQ)
>  				iova -= OTX2_HEAD_ROOM;
> -
>  			otx2_free_bufs(pfvf, pool, iova, size);
> -
>  			iova = otx2_aura_allocptr(pfvf, pool_id);
>  		}
> +
> +		for (idx = 0 ; idx < pool->xdp_cnt; idx++) {
> +			if (!pool->xdp[idx])
> +				continue;
> +
> +			xsk_buff_free(pool->xdp[idx]);
> +		}
>  	}
>  }
>  
> @@ -1338,7 +1357,8 @@ void otx2_aura_pool_free(struct otx2_nic *pfvf)
>  		qmem_free(pfvf->dev, pool->stack);
>  		qmem_free(pfvf->dev, pool->fc_addr);
>  		page_pool_destroy(pool->page_pool);
> -		pool->page_pool = NULL;
> +		devm_kfree(pfvf->dev, pool->xdp);
> +		pool->xsk_pool = NULL;
>  	}
>  	devm_kfree(pfvf->dev, pfvf->qset.pool);
>  	pfvf->qset.pool = NULL;
> @@ -1425,6 +1445,7 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
>  		   int stack_pages, int numptrs, int buf_size, int type)
>  {
>  	struct page_pool_params pp_params = { 0 };
> +	struct xsk_buff_pool *xsk_pool;
>  	struct npa_aq_enq_req *aq;
>  	struct otx2_pool *pool;
>  	int err;
> @@ -1468,21 +1489,35 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
>  	aq->ctype = NPA_AQ_CTYPE_POOL;
>  	aq->op = NPA_AQ_INSTOP_INIT;
>  
> -	if (type != AURA_NIX_RQ) {
> -		pool->page_pool = NULL;
> +	if (type != AURA_NIX_RQ)
> +		return 0;
> +
> +	if (!test_bit(pool_id, pfvf->af_xdp_zc_qidx)) {
> +		pp_params.order = get_order(buf_size);
> +		pp_params.flags = PP_FLAG_DMA_MAP;
> +		pp_params.pool_size = min(OTX2_PAGE_POOL_SZ, numptrs);
> +		pp_params.nid = NUMA_NO_NODE;
> +		pp_params.dev = pfvf->dev;
> +		pp_params.dma_dir = DMA_FROM_DEVICE;
> +		pool->page_pool = page_pool_create(&pp_params);
> +		if (IS_ERR(pool->page_pool)) {
> +			netdev_err(pfvf->netdev, "Creation of page pool failed\n");
> +			return PTR_ERR(pool->page_pool);
> +		}
>  		return 0;
>  	}
>  
> -	pp_params.order = get_order(buf_size);
> -	pp_params.flags = PP_FLAG_DMA_MAP;
> -	pp_params.pool_size = min(OTX2_PAGE_POOL_SZ, numptrs);
> -	pp_params.nid = NUMA_NO_NODE;
> -	pp_params.dev = pfvf->dev;
> -	pp_params.dma_dir = DMA_FROM_DEVICE;
> -	pool->page_pool = page_pool_create(&pp_params);
> -	if (IS_ERR(pool->page_pool)) {
> -		netdev_err(pfvf->netdev, "Creation of page pool failed\n");
> -		return PTR_ERR(pool->page_pool);
> +	/* Set XSK pool to support AF_XDP zero-copy */
> +	xsk_pool = xsk_get_pool_from_qid(pfvf->netdev, pool_id);
> +	if (xsk_pool) {
> +		pool->xsk_pool = xsk_pool;
> +		pool->xdp_cnt = numptrs;
> +		pool->xdp = devm_kcalloc(pfvf->dev,
> +					 numptrs, sizeof(struct xdp_buff *), GFP_KERNEL);

What is the rationale behind having a buffer pool within your driver while
you have this very same thing within xsk_buff_pool?

You're doubling your work. Just use the xsk_buff_alloc_batch() and have a
simpler ZC implementation in your driver.

> +		if (IS_ERR(pool->xdp)) {
> +			netdev_err(pfvf->netdev, "Creation of xsk pool failed\n");
> +			return PTR_ERR(pool->xdp);
> +		}
>  	}
>  
>  	return 0;
> @@ -1543,9 +1578,18 @@ int otx2_sq_aura_pool_init(struct otx2_nic *pfvf)
>  		}
>  
>  		for (ptr = 0; ptr < num_sqbs; ptr++) {
> -			err = otx2_alloc_rbuf(pfvf, pool, &bufptr);
> -			if (err)
> +			err = otx2_alloc_rbuf(pfvf, pool, &bufptr, pool_id, ptr);
> +			if (err) {
> +				if (pool->xsk_pool) {
> +					ptr--;
> +					while (ptr >= 0) {
> +						xsk_buff_free(pool->xdp[ptr]);
> +						ptr--;
> +					}
> +				}
>  				goto err_mem;
> +			}
> +
>  			pfvf->hw_ops->aura_freeptr(pfvf, pool_id, bufptr);
>  			sq->sqb_ptrs[sq->sqb_count++] = (u64)bufptr;
>  		}
> @@ -1595,11 +1639,19 @@ int otx2_rq_aura_pool_init(struct otx2_nic *pfvf)
>  	/* Allocate pointers and free them to aura/pool */
>  	for (pool_id = 0; pool_id < hw->rqpool_cnt; pool_id++) {
>  		pool = &pfvf->qset.pool[pool_id];
> +
>  		for (ptr = 0; ptr < num_ptrs; ptr++) {
> -			err = otx2_alloc_rbuf(pfvf, pool, &bufptr);
> -			if (err)
> +			err = otx2_alloc_rbuf(pfvf, pool, &bufptr, pool_id, ptr);
> +			if (err) {
> +				if (pool->xsk_pool) {
> +					while (ptr)
> +						xsk_buff_free(pool->xdp[--ptr]);
> +				}
>  				return -ENOMEM;
> +			}
> +
>  			pfvf->hw_ops->aura_freeptr(pfvf, pool_id,
> +						   pool->xsk_pool ? bufptr :
>  						   bufptr + OTX2_HEAD_ROOM);
>  		}
>  	}
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index d5fbccb289df..60508971b62f 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -532,6 +532,8 @@ struct otx2_nic {
>  
>  	/* Inline ipsec */
>  	struct cn10k_ipsec	ipsec;
> +	/* af_xdp zero-copy */
> +	unsigned long		*af_xdp_zc_qidx;
>  };
>  
>  static inline bool is_otx2_lbkvf(struct pci_dev *pdev)
> @@ -1003,7 +1005,7 @@ void otx2_txschq_free_one(struct otx2_nic *pfvf, u16 lvl, u16 schq);
>  void otx2_free_pending_sqe(struct otx2_nic *pfvf);
>  void otx2_sqb_flush(struct otx2_nic *pfvf);
>  int otx2_alloc_rbuf(struct otx2_nic *pfvf, struct otx2_pool *pool,
> -		    dma_addr_t *dma);
> +		    dma_addr_t *dma, int qidx, int idx);
>  int otx2_rxtx_enable(struct otx2_nic *pfvf, bool enable);
>  void otx2_ctx_disable(struct mbox *mbox, int type, bool npa);
>  int otx2_nix_config_bp(struct otx2_nic *pfvf, bool enable);
> @@ -1033,6 +1035,8 @@ void otx2_pfaf_mbox_destroy(struct otx2_nic *pf);
>  void otx2_disable_mbox_intr(struct otx2_nic *pf);
>  void otx2_disable_napi(struct otx2_nic *pf);
>  irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq);
> +int otx2_rq_init(struct otx2_nic *pfvf, u16 qidx, u16 lpb_aura);
> +int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx);
>  
>  /* RSS configuration APIs*/
>  int otx2_rss_init(struct otx2_nic *pfvf);
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 4347a3c95350..50a42cd5d50a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -27,6 +27,7 @@
>  #include "qos.h"
>  #include <rvu_trace.h>
>  #include "cn10k_ipsec.h"
> +#include "otx2_xsk.h"
>  
>  #define DRV_NAME	"rvu_nicpf"
>  #define DRV_STRING	"Marvell RVU NIC Physical Function Driver"
> @@ -1662,9 +1663,7 @@ void otx2_free_hw_resources(struct otx2_nic *pf)
>  	struct nix_lf_free_req *free_req;
>  	struct mbox *mbox = &pf->mbox;
>  	struct otx2_cq_queue *cq;
> -	struct otx2_pool *pool;
>  	struct msg_req *req;
> -	int pool_id;
>  	int qidx;
>  
>  	/* Ensure all SQE are processed */
> @@ -1705,13 +1704,6 @@ void otx2_free_hw_resources(struct otx2_nic *pf)
>  	/* Free RQ buffer pointers*/
>  	otx2_free_aura_ptr(pf, AURA_NIX_RQ);
>  
> -	for (qidx = 0; qidx < pf->hw.rx_queues; qidx++) {
> -		pool_id = otx2_get_pool_idx(pf, AURA_NIX_RQ, qidx);
> -		pool = &pf->qset.pool[pool_id];
> -		page_pool_destroy(pool->page_pool);
> -		pool->page_pool = NULL;
> -	}
> -
>  	otx2_free_cq_res(pf);
>  
>  	/* Free all ingress bandwidth profiles allocated */
> @@ -2788,6 +2780,8 @@ static int otx2_xdp(struct net_device *netdev, struct netdev_bpf *xdp)
>  	switch (xdp->command) {
>  	case XDP_SETUP_PROG:
>  		return otx2_xdp_setup(pf, xdp->prog);
> +	case XDP_SETUP_XSK_POOL:
> +		return otx2_xsk_pool_setup(pf, xdp->xsk.pool, xdp->xsk.queue_id);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -2865,6 +2859,7 @@ static const struct net_device_ops otx2_netdev_ops = {
>  	.ndo_set_vf_vlan	= otx2_set_vf_vlan,
>  	.ndo_get_vf_config	= otx2_get_vf_config,
>  	.ndo_bpf		= otx2_xdp,
> +	.ndo_xsk_wakeup		= otx2_xsk_wakeup,
>  	.ndo_xdp_xmit           = otx2_xdp_xmit,
>  	.ndo_setup_tc		= otx2_setup_tc,
>  	.ndo_set_vf_trust	= otx2_ndo_set_vf_trust,
> @@ -3203,16 +3198,26 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	/* Enable link notifications */
>  	otx2_cgx_config_linkevents(pf, true);
>  
> +	pf->af_xdp_zc_qidx = bitmap_zalloc(qcount, GFP_KERNEL);

if this is taken from ice drivers then be aware we got rid of bitmap
tracking zc enabled queues. see adbf5a42341f ("ice: remove af_xdp_zc_qps
bitmap").

in case you would still have a need for that after going through
referenced commit, please provide us some justification why.

> +	if (!pf->af_xdp_zc_qidx) {
> +		err = -ENOMEM;
> +		goto err_sriov_cleannup;
> +	}
> +
>  #ifdef CONFIG_DCB
>  	err = otx2_dcbnl_set_ops(netdev);
>  	if (err)
> -		goto err_pf_sriov_init;
> +		goto err_free_zc_bmap;
>  #endif
>  
>  	otx2_qos_init(pf, qos_txqs);
>  
>  	return 0;
>  
> +err_free_zc_bmap:
> +	bitmap_free(pf->af_xdp_zc_qidx);
> +err_sriov_cleannup:
> +	otx2_sriov_vfcfg_cleanup(pf);
>  err_pf_sriov_init:
>  	otx2_shutdown_tc(pf);
>  err_mcam_flow_del:

[...]

