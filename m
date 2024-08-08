Return-Path: <bpf+bounces-36718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B6294C5D4
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 22:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9933E2833DB
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 20:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744081591ED;
	Thu,  8 Aug 2024 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbJ7VEhR"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD831586FE;
	Thu,  8 Aug 2024 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723149536; cv=fail; b=KCTrC++5eE7DTcRZGpreiYRON6qbhyKWSyIdqpKB11ZdiVyeANGJYV4ysm+Ae3WSKdJagvb+dZwAEmQHFkD+IwREttA8/shXUyrulZlTjUBzVgyMSiFcxCoCFijrDrBFBe6KekZnlmUuL3o6pWHD/jlq8PytYY9Es4XmjGR6Y9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723149536; c=relaxed/simple;
	bh=TDgvse9WL/jBE6D58Uao2+D65b0Cal5kd2mr+lX+gF8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZNvOPq52yVjGPBvCL3wI+JWB0nq5CgC/O1vR0w4NAnO4BUGQ8Ze0igVMMSu1fCFeJpRO6oLVT3DoQpBEW8Z4aza6Zw77eJQHUECfnNkQXSxH/SO0yviXElgAXu8Tx+eYbHh2ndtp55q/869F9glZPwVfc4y8/0PYOU5t2qxs5xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbJ7VEhR; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723149533; x=1754685533;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TDgvse9WL/jBE6D58Uao2+D65b0Cal5kd2mr+lX+gF8=;
  b=UbJ7VEhRRwyhqOIu8IRAVXiPsat93X3bGlKb8uY+JN1usGzW5V8SdphR
   Cl2a40AhxcGhGt2PcHGUVGFsY8RSmI5EhlqDHew3Fpi1/XHIW1j++tVuL
   tqGvIgI1OVjJbLD5pmVFnzzPtN2NPKd/gvqsHHWZT9nU7Ju1NeYYEuQ5A
   5R5rOxdk2A7LJSADxnqHxvepwyjoQI/0EfkE50pTlMyglgoz38P35UVDB
   O6UFEyndoko1geEXNi3M6kng1zUtcn6VOPoL4pRR0E1kegsFUxuLaUoD2
   XVzGjuKro4vnWEMPiB01bYNCbIwueYrUwlmBYS2Ofh7f536dmvRMTVWkm
   Q==;
X-CSE-ConnectionGUID: ATVU+cb8Rw6W0r+z39t3lg==
X-CSE-MsgGUID: OaN8N3QqSd+0UXOkydX7Mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="31877957"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="31877957"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:38:30 -0700
X-CSE-ConnectionGUID: i+j4KIDpQXG1bzS+2tW7Ng==
X-CSE-MsgGUID: fK1zJAmaSL6Pr7VrB48mYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57321076"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 13:38:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 13:38:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 13:38:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 13:38:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 13:38:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6lEIpYvNlLdOte3o18R+49tCPOlpnfTA9QtzmNko5ZTdCItA/l/60lRI8eeQXoLLqlg52MOXoPsfKjNEn9WC0mbZTD1G756Vu9+5eRKznH6RAuVxDLwjfp4pCiVqhPhGyYPu/VWvsLSIzDF7I7yVCJNXFbKnEYwdZDB2RQP2UizSln6Gspd6ZZ+8qDL4u4qgmG70MOZB1K1fMJ2WMXA23PX1AjwdElfr6I3PUliZWdVnGL6e/6FTV3jRmWFt/QNpG54CDRPyEUjKwCxtbyEsrOcRELdYZXl1XakRNlzpD4SP0C+5IDugXWZaeeMR9qmg4C78W2rlY56A0cOZUCYzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMhfGsb9EGeHpSiW+e4wMvwxs8/aImJz2hxOpt0d5wE=;
 b=gdAAMgUPFNxv1cYqoGaVu2oU8Icbt8xXJW03FHoivZDC1b6UhLUcIgbpV/F65QXbKBgp75rLjzIgjysV0ix7hGRDykMV9hGAbMuy5G+MGdWx8YbjfbBS3JzOHV44c8yb8GLsPa2smUhhtWIUU8sCwCQ2+FckVQq+k+0g7pdBPygYvQ0va3Rv7JiDCRjxROTNbf9yC/WimXH9DV2X5p4+HPUJRfa9DVdNS1ZzEkV/DVkg1uxrYPibXqhGG3yHGM8l0gZAeZdiMd7rffFsOfpfuKI6LeaixBzSUk0IBeNCIGKdTTS1Ad6mA5XGGm9EBJe6DOLBuqJ1Qn/UNT+G5O4Rpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB8477.namprd11.prod.outlook.com (2603:10b6:510:30d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Thu, 8 Aug
 2024 20:38:26 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 20:38:26 +0000
Date: Thu, 8 Aug 2024 22:38:18 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Sriram Yagnaraman
	<sriram.yagnaraman@est.tech>, <magnus.karlsson@intel.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<bpf@vger.kernel.org>, <kurt@linutronix.de>,
	<sriram.yagnaraman@ericsson.com>, <richardcochran@gmail.com>,
	<benjamin.steinke@woks-audio.com>, <bigeasy@linutronix.de>, "Chandan Kumar
 Rout" <chandanx.rout@intel.com>
Subject: Re: [PATCH net-next 1/4] igb: prepare for AF_XDP zero-copy support
Message-ID: <ZrUsuq1vanahPyOd@boxer>
References: <20240808183556.386397-1-anthony.l.nguyen@intel.com>
 <20240808183556.386397-2-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240808183556.386397-2-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: MI1P293CA0009.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::6)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec42cab-b402-4fbd-9f60-08dcb7ea0de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?80pcoxy+Ej3eOgwllYgcKHBDh5orhH0mqlIgxzF3tmj8z7oeBWZEtyh+ziv2?=
 =?us-ascii?Q?QI61Jl6UQf7DWU8D6o2ik6ESm1e5ylL5eQVc7yRTIUSYIqnWWaO5+dpQI1Wb?=
 =?us-ascii?Q?Lc8V2tNormgHSAN3zDZGb33lQTP9TxgIhCwRRUUr53JMO0l0kPk814/Q215p?=
 =?us-ascii?Q?b871k2WAz3Q56tKlXLnnbA/GCrz/OMIhwQl6rUs5VsQLaROoqjnEHTxEJQqw?=
 =?us-ascii?Q?7P4e7pdh95+QXOS7poN4oKFEMnN0i3sRVBfqEQ4xnzFA0VYHXHA1yHZmTG4c?=
 =?us-ascii?Q?aIBE/y5sydZ6hUDzb3kayEqhVIinit6jrftrbXT0aRTzbSxLQg1T1yRo9BqF?=
 =?us-ascii?Q?Tt3z2Uz4+iATFqkTEwIavCnZZMnqKAqglaO2u2z/jIdxGKFLz1xX+TiuGRAh?=
 =?us-ascii?Q?SY+WghHh/tvno42WNl5K+i+9X2R/teew04vlgQcg32Lm+dvmbTlySTFIsndw?=
 =?us-ascii?Q?0qbeXW8DRQl85v8uZpbeDacxrZOsaSkDdZ7PvC9gEIiJHsLEmRbTLGncU2df?=
 =?us-ascii?Q?/qARmWq1gfOh5SIWYajUOVPC/RfKW7CnW8lBeUw415ApvOYzP3o3pvgq/XGb?=
 =?us-ascii?Q?pxFN1e1loiS8o+1EczeM7b3Cmymn27DkuTzyNtl/1sbvPxlOPPtZFmexrxop?=
 =?us-ascii?Q?9u/XxhRtQLQCsIPVwUVvsZMi+8gOguxzepBWimBZwECL+cqKLxOgzQAzYPes?=
 =?us-ascii?Q?FTQm8zMaFQbizPXSt2b+yBwCpfNJcam9l10XSDT8QdTmaFKThyM9G19wTfeB?=
 =?us-ascii?Q?YSsmf7yA/x3Etza+tLn3MgipURmJz7RpuMJAMhDjvNo88H0dsNniRv/jJcm4?=
 =?us-ascii?Q?/mqjLi6RPaMaNa1EWyqLgeaLMH68qfpGYwPGlGC7S77DIRJtZaQVHLlA4vAB?=
 =?us-ascii?Q?qoFPbS7dzCzjGGkGYQ+dQBJnlin9qYZDHU9B5AbhYjM7UQBBUNnck4v0cBBm?=
 =?us-ascii?Q?q555DxJqk8kQXr7Ke1UPf204lU0YuXveg9ZPcJ1+cqNQoPHHT3awYv+dJrLI?=
 =?us-ascii?Q?TyVijLWLG/Oy1lXUVgyiaHT5hBlEDIsyJJxyyb9LuI6FAUEvJzyusp26W+Zs?=
 =?us-ascii?Q?uh1oryBhbH2XJEzuYdltq5AlRuuiGz8deSsVQeYlD2iqBbqqyey+fXDF/xkJ?=
 =?us-ascii?Q?waykcsSwxEfTaT3CZGKG4LSMcOpzSr5cRmxnvoOjJOALsqUwvx+AWRQ1Fih6?=
 =?us-ascii?Q?8r8UW1FglGBhKK9RZfTcdc10iupKVpuCI/XUnDDBVIXUv73p8p++gXwhQawo?=
 =?us-ascii?Q?E3069TbcZASRlNdfLLigqgcU324pQJmAIQyHPAjd2o0viqLD0r1mGZEKn92t?=
 =?us-ascii?Q?uC9LYcGRc8FvfzpPMyW6ALyXhSEXvEymKNxg1vkrod7edA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IVyOXZSUb+PgB8vQpWPlbrikOCu936BNuk5K03kN6EjVRHiTn56E2yC8YY3Z?=
 =?us-ascii?Q?x+jEQIy5uLwlgEMFFW6Cc09f5QgSx+faL6AMPVqxrIwHb+f1Y5OWRKIJ082O?=
 =?us-ascii?Q?8U9g5eDTAlsctzRf+IMw6Dh++eZ28qtIP6i8o4GXalcYY7zKg+Ia9709of3e?=
 =?us-ascii?Q?wNkTUcpjo13bBKEaYGdNYHIqRs8qtul0KwBCj24czChpMYGQYT4/C+FX7iCe?=
 =?us-ascii?Q?Bf+vbabJ8uZcXpO6KQE7dbmChIfaTlfdzjxiKaQJ9B++bxmR+Tue0bj9ZEOd?=
 =?us-ascii?Q?UtSD37bjwk9sMi3NDJj5vbtU+L0vD4AsWaEvl8p+waZ0HYFYmbEhdqftDchJ?=
 =?us-ascii?Q?QcecVDw7PdbwPrDSEypxAdnUMlfTx6EKWk0bo+eVuFgj5oSpGauWNncGGTPq?=
 =?us-ascii?Q?JYJJjRplTlu6Q4B+hq5ZaozogJG02Q1tigtHbMA++SvMnw8oXVIFWR1WXcIR?=
 =?us-ascii?Q?UbOXyU643LKIVmxG/vcK23/8CB2UejKOiipjffXB8TVJzYYkrJthsxlwrtsb?=
 =?us-ascii?Q?F1el4xN7NOj3aKeU6xKPJVAI9skjvyuoCHEXKp6c0WidQZr1aMLvAH5Rncj1?=
 =?us-ascii?Q?n8FbFzfzloE5RTzw7eDjEZiIAf8LOGJyFmMh8DLqtS/F/ZSB2ziM1NDyPKkI?=
 =?us-ascii?Q?MhTgzgDwFB8RojSLj6NJUoQ2Btg76KVsR3PnfotkmxvgC4zetgjs9iGeE/6l?=
 =?us-ascii?Q?ZJNMUQP3vKbxyWODtYtecGXjQAzD1FW2HJuIpwsyavE8/Qi2CZ5KvfLQqRoB?=
 =?us-ascii?Q?PMRiqImxI/uwgPw0p3jaflEuPB3z4+T7cAFHetTanIDG7eW3Byh06y1XMUie?=
 =?us-ascii?Q?2XWGCNrR9b/odltarFcWyHHjwm5IvH2bt3Hw+FnX31zv9OEV0Q5UKpjFUv7t?=
 =?us-ascii?Q?tCFLxzJJfx5X9MCrFUIsNzPI8MccxpGZQif3XIhYJQC6rSA89i1xBHqP8F/Z?=
 =?us-ascii?Q?n36JFi6Tb8FzGTwwY+K6LBnrwJFo/YzT8BPEow16vpgu73iiAsJidOBKfpnl?=
 =?us-ascii?Q?6MJcyEQY8mWKWTVEvNZIPTrDHZWIvX1TSChUohj0O49xkQEeTyS62gfUDXnP?=
 =?us-ascii?Q?UDdlYb17mOtMGbaKABgTkIV1f1t74eXgxfT9yRaBjdDZ7lNUgn64wJ8vw/1U?=
 =?us-ascii?Q?l5OCusVkqaCboWxrmTUTgw45OsoCL1Emk3iLnVJEHFNfJO+63Pw7OOS24LYA?=
 =?us-ascii?Q?u0QxiYxn7hblbna3JJBiIAhS/F4C1lnjeO2q5OOkkf2llN0unoA1bgpsePOy?=
 =?us-ascii?Q?KFTiYgzpaRZr5+NOLZPDZ90ubd96onv1wCbrTNl6GENwLzjher+q1Vd2kSPj?=
 =?us-ascii?Q?YlZfgm45O6V5mxwZnTKgdnD3kgsYjqHHEP9AHl9kDwuU5jKR2TBgT2+LoYYe?=
 =?us-ascii?Q?MBCk0ICWfeh3nHpfXwc+k3wun6c/FwQxi7guLUoZok3oJreC7aFqBdJuB9sJ?=
 =?us-ascii?Q?sd+CuPfi3jRTf0ZyHPFfcXl16SAiBXwsghAz3ZwMMFPgjPoWctFI0w3Q03LT?=
 =?us-ascii?Q?UnofgcTjW1OcTZZDHJC0Qql3IgiceN/vDyK2uDt9SPTJ2qGsFaK6c6SWqaSx?=
 =?us-ascii?Q?PFGAy6cLCyQaD9UAU4EbyvxK4djfpCwHh40/FT4SF5w0C5ki2QmvXrj7DhEc?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec42cab-b402-4fbd-9f60-08dcb7ea0de1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 20:38:26.3846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pr2L4kawuzPdWAsLTpRm5pQQ5VcgqSlN8hsPlJFIo9QV+E6pF+aDTKgAwKVtqIDtncMIvVZ5bcDwjttZa8pcxQDkfjLtx7/cVqkGpQxPQYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8477
X-OriginatorOrg: intel.com

On Thu, Aug 08, 2024 at 11:35:51AM -0700, Tony Nguyen wrote:
> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> 
> Always call igb_xdp_ring_update_tail under __netif_tx_lock, add a
> comment to indicate that. This is needed to share the same TX ring
> between XDP, XSK and slow paths.

standalone commit

> 
> Remove static qualifiers on the following functions to be able to call
> from XSK specific file that is added in the later patches
> - igb_xdp_tx_queue_mapping
> - igb_xdp_ring_update_tail
> - igb_clean_tx_ring
> - igb_clean_rx_ring
> - igb_run_xdp
> - igb_process_skb_fields

ditto

> 
> Introduce igb_xdp_is_enabled() to check if an XDP program is assigned to
> the device.

ditto

> 
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h      | 15 ++++++++++++
>  drivers/net/ethernet/intel/igb/igb_main.c | 29 +++++++++++------------
>  2 files changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index 3c2dc7bdebb5..0de71ec324ed 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -718,6 +718,8 @@ extern char igb_driver_name[];
>  int igb_xmit_xdp_ring(struct igb_adapter *adapter,
>  		      struct igb_ring *ring,
>  		      struct xdp_frame *xdpf);
> +struct igb_ring *igb_xdp_tx_queue_mapping(struct igb_adapter *adapter);
> +void igb_xdp_ring_update_tail(struct igb_ring *ring);
>  int igb_open(struct net_device *netdev);
>  int igb_close(struct net_device *netdev);
>  int igb_up(struct igb_adapter *);
> @@ -731,12 +733,20 @@ int igb_setup_tx_resources(struct igb_ring *);
>  int igb_setup_rx_resources(struct igb_ring *);
>  void igb_free_tx_resources(struct igb_ring *);
>  void igb_free_rx_resources(struct igb_ring *);
> +void igb_clean_tx_ring(struct igb_ring *tx_ring);
> +void igb_clean_rx_ring(struct igb_ring *rx_ring);
>  void igb_configure_tx_ring(struct igb_adapter *, struct igb_ring *);
>  void igb_configure_rx_ring(struct igb_adapter *, struct igb_ring *);
>  void igb_setup_tctl(struct igb_adapter *);
>  void igb_setup_rctl(struct igb_adapter *);
>  void igb_setup_srrctl(struct igb_adapter *, struct igb_ring *);
>  netdev_tx_t igb_xmit_frame_ring(struct sk_buff *, struct igb_ring *);
> +struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
> +			    struct igb_ring *rx_ring,
> +			    struct xdp_buff *xdp);
> +void igb_process_skb_fields(struct igb_ring *rx_ring,
> +			    union e1000_adv_rx_desc *rx_desc,
> +			    struct sk_buff *skb);
>  void igb_alloc_rx_buffers(struct igb_ring *, u16);
>  void igb_update_stats(struct igb_adapter *);
>  bool igb_has_link(struct igb_adapter *adapter);
> @@ -797,6 +807,11 @@ static inline struct netdev_queue *txring_txq(const struct igb_ring *tx_ring)
>  	return netdev_get_tx_queue(tx_ring->netdev, tx_ring->queue_index);
>  }
>  
> +static inline bool igb_xdp_is_enabled(struct igb_adapter *adapter)
> +{
> +	return !!adapter->xdp_prog;

READ_ONCE() plus use this everywhere else where prog is read.

> +}
> +
>  int igb_add_filter(struct igb_adapter *adapter,
>  		   struct igb_nfc_filter *input);
>  int igb_erase_filter(struct igb_adapter *adapter,
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 11be39f435f3..bdb7637559b8 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -115,8 +115,6 @@ static void igb_configure_tx(struct igb_adapter *);
>  static void igb_configure_rx(struct igb_adapter *);
>  static void igb_clean_all_tx_rings(struct igb_adapter *);
>  static void igb_clean_all_rx_rings(struct igb_adapter *);
> -static void igb_clean_tx_ring(struct igb_ring *);
> -static void igb_clean_rx_ring(struct igb_ring *);
>  static void igb_set_rx_mode(struct net_device *);
>  static void igb_update_phy_info(struct timer_list *);
>  static void igb_watchdog(struct timer_list *);
> @@ -2914,7 +2912,8 @@ static int igb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>  	}
>  }
>  
> -static void igb_xdp_ring_update_tail(struct igb_ring *ring)
> +/* This function assumes __netif_tx_lock is held by the caller. */
> +void igb_xdp_ring_update_tail(struct igb_ring *ring)
>  {
>  	/* Force memory writes to complete before letting h/w know there
>  	 * are new descriptors to fetch.
> @@ -2923,7 +2922,7 @@ static void igb_xdp_ring_update_tail(struct igb_ring *ring)
>  	writel(ring->next_to_use, ring->tail);
>  }
>  
> -static struct igb_ring *igb_xdp_tx_queue_mapping(struct igb_adapter *adapter)
> +struct igb_ring *igb_xdp_tx_queue_mapping(struct igb_adapter *adapter)
>  {
>  	unsigned int r_idx = smp_processor_id();
>  
> @@ -3000,11 +2999,11 @@ static int igb_xdp_xmit(struct net_device *dev, int n,
>  		nxmit++;
>  	}
>  
> -	__netif_tx_unlock(nq);
> -
>  	if (unlikely(flags & XDP_XMIT_FLUSH))
>  		igb_xdp_ring_update_tail(tx_ring);
>  
> +	__netif_tx_unlock(nq);
> +
>  	return nxmit;
>  }
>  
> @@ -4879,7 +4878,7 @@ static void igb_free_all_tx_resources(struct igb_adapter *adapter)
>   *  igb_clean_tx_ring - Free Tx Buffers
>   *  @tx_ring: ring to be cleaned
>   **/
> -static void igb_clean_tx_ring(struct igb_ring *tx_ring)
> +void igb_clean_tx_ring(struct igb_ring *tx_ring)
>  {
>  	u16 i = tx_ring->next_to_clean;
>  	struct igb_tx_buffer *tx_buffer = &tx_ring->tx_buffer_info[i];
> @@ -4998,7 +4997,7 @@ static void igb_free_all_rx_resources(struct igb_adapter *adapter)
>   *  igb_clean_rx_ring - Free Rx Buffers per Queue
>   *  @rx_ring: ring to free buffers from
>   **/
> -static void igb_clean_rx_ring(struct igb_ring *rx_ring)
> +void igb_clean_rx_ring(struct igb_ring *rx_ring)
>  {
>  	u16 i = rx_ring->next_to_clean;
>  
> @@ -6613,7 +6612,7 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
>  	struct igb_adapter *adapter = netdev_priv(netdev);
>  	int max_frame = new_mtu + IGB_ETH_PKT_HDR_PAD;
>  
> -	if (adapter->xdp_prog) {
> +	if (igb_xdp_is_enabled(adapter)) {
>  		int i;
>  
>  		for (i = 0; i < adapter->num_rx_queues; i++) {
> @@ -8569,9 +8568,9 @@ static struct sk_buff *igb_build_skb(struct igb_ring *rx_ring,
>  	return skb;
>  }
>  
> -static struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
> -				   struct igb_ring *rx_ring,
> -				   struct xdp_buff *xdp)
> +struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
> +			    struct igb_ring *rx_ring,
> +			    struct xdp_buff *xdp)
>  {
>  	int err, result = IGB_XDP_PASS;
>  	struct bpf_prog *xdp_prog;
> @@ -8767,9 +8766,9 @@ static bool igb_cleanup_headers(struct igb_ring *rx_ring,
>   *  order to populate the hash, checksum, VLAN, timestamp, protocol, and
>   *  other fields within the skb.
>   **/
> -static void igb_process_skb_fields(struct igb_ring *rx_ring,
> -				   union e1000_adv_rx_desc *rx_desc,
> -				   struct sk_buff *skb)
> +void igb_process_skb_fields(struct igb_ring *rx_ring,
> +			    union e1000_adv_rx_desc *rx_desc,
> +			    struct sk_buff *skb)
>  {
>  	struct net_device *dev = rx_ring->netdev;
>  
> -- 
> 2.42.0
> 
> 

