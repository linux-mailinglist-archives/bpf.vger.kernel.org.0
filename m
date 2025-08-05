Return-Path: <bpf+bounces-65071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10C1B1B811
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 18:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B83F168CB0
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 16:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E4D28980E;
	Tue,  5 Aug 2025 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNFhDVnw"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B02291C1F;
	Tue,  5 Aug 2025 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410245; cv=fail; b=LpBPlTj0y6XnN2HiVZI5jxtPdNH1LxNgpEOy5X68x1QxhaxeuwE6EKvN10h4BuS8qxvGFQxJz6PmMYxhH7I2MK038t7tHnENwq9JnOLbcW5Ks8RVP0B0GXDn2UyH5Q949EMmxvc5pVecAhRzHPbp0qbWQZbhPgzlh2SETa7Q2nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410245; c=relaxed/simple;
	bh=EHYGJ69k67Jhe9BLfgQIeP0TMe60HZlf70piiGMYI7k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a2OKT+DPxjUaTr3ckAlPxZq8UlvbSX2qShhypP3L7pW7zgpXIrRWFNv5UXYiC5cXnF6EHljDx7armbaM7xxd6GQC+yUkOnm3VIXQ8Rcn6CuvsEeH509utx8ptVcun03U7SctvkBuBnmINUSmIPbKWz82bFEe3M6SknHwZJjE5Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNFhDVnw; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754410244; x=1785946244;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EHYGJ69k67Jhe9BLfgQIeP0TMe60HZlf70piiGMYI7k=;
  b=NNFhDVnwh0DjGxZXLnVPNz7eOW9Rjw1POAuGHXVvOfwAWEV+mI7Zm7re
   NCydpKe4yzwEZxxE0xcXyDE+7qQPIUzOf9fyx0hpXwZV1cQAyFYiMmvuy
   OFmWj3zSrnk0JA0ESwCClbwuddzV7kC9m0ZIqnr/mytd4SIeAHaNVZaA7
   c/fKp6nLJlFNHLD98BtTr7yEBu+OhmBgrWdkLciHGg2A0gI0VtokeE4eX
   OBmgcTsoDim9U5mkOMyjDahsn7akHYgJi1+cayMERCZjBukLW9Ih5yM32
   b2Vv/mSCZxmxXVnLnGcWLsjdEt+ZVlqkzBhVmvzWMsvHHF0w84mIrw4Up
   Q==;
X-CSE-ConnectionGUID: RfJaiZnrQIyTg4jk3glbbA==
X-CSE-MsgGUID: Qdx8vAhvTVqRYJhVEpcrSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56795610"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56795610"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 09:10:43 -0700
X-CSE-ConnectionGUID: YKHcolVLRJmOwBRuJFPRFw==
X-CSE-MsgGUID: gXoaFBc0RlGU3VuItTsY8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="163801919"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 09:10:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 09:10:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 5 Aug 2025 09:10:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.82)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 5 Aug 2025 09:10:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQCZz5fdEUvZ+QDl7M5FBWrFRjDLbMXMTD4Z5MRNoUSwNk7vpXUNG4VlHqsP5pRQiCzJgKQ0laVD2BjgRBwbkiFfjCLjq/S+flyh7P07iQ307Yz3rBsqwrbeiLbkcjS1b3udgPJVR5gEelVNyntiMyQ0dNkdL4h79PYDZeSz5isI2CIIuUp2jC3Pod1iewQtRa/+WPuCL4gfnQTWjKtmI754PoBVfneXR9rHZcU6xV0vW44Z9LYkZuXahl5ChOkSQl6B9PQrdwtgaDTp6uk/v+8+6bkXOS+ecZDjyw6MZnMA3oErXxN+j42Q1xZpv3HTRuXm1emNdYpXcYYxhdbMfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQiaZkL2PygBfQXSAhxtrJwINEb1vzOcNM3eY97Jwnc=;
 b=FlfLgMEFiOzw/eWwI8JYSn9yIR4izS0lSi0HJdTPJkHFGRhKF4uCYD4pvUYwmjLUTyoGeyh7cghcCnQ6MueyehI0+veEN8W94wkreyo7wngvPDhI0Dy3b7VMg2/kW8FiOTplcN29aTc/kZRPgLfc9SEpkfYCeTtdprXPKQsSmIGspGSyZtjWTdjx9VesGtXF9ApWBgrCfCzxFe93zHZ9ctmtgt/pAtDxqNLdn+9tZnLYRzCzB0/zo/HiguIwXEcw00k9fTDIlnyjEffOmQWzHIyPG2Hy48S1/9pEBgPsFKhZG/vJoxB9ODfLRHVtl9NptoIWP9lghWvITgMRVEKOWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB6567.namprd11.prod.outlook.com (2603:10b6:806:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 5 Aug
 2025 16:10:39 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%6]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 16:10:39 +0000
Message-ID: <a151336a-eda4-4f44-9ab5-da79e7712838@intel.com>
Date: Tue, 5 Aug 2025 18:09:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3 16/18] idpf: add support for XDP on Rx
To: Jakub Kicinski <kuba@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, Michal Kubiak
	<michal.kubiak@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Simon Horman <horms@kernel.org>,
	<nxne.cnse.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250730160717.28976-1-aleksander.lobakin@intel.com>
 <20250730160717.28976-17-aleksander.lobakin@intel.com>
 <20250801153343.74e0884b@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250801153343.74e0884b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0106.eurprd09.prod.outlook.com
 (2603:10a6:803:78::29) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e31f6d0-c433-459e-d33b-08ddd43a9e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXFEWmZyWFhmOGcrMjFYYjhTdjFCcEtIVUI5Tm5CV1QzSjFvcUM3RUJnV01j?=
 =?utf-8?B?OUpFelllTEhONXBacmNVMTBvOS9vZm1jOG1XVUFtT1pEUHBBdzlxRlJRT1J4?=
 =?utf-8?B?WmhYU1FzbWNZVVBCYVpNWitMV0hsNlhhRVFHcWJreGttMTMvbEZqYlQyeFFP?=
 =?utf-8?B?TXc2TFZsS0tRSk9XclgrbjNjYzN3TnY2aUNQNm5ad05pMVpMQUpPbGZTRG9H?=
 =?utf-8?B?ODBnMlpuVHZrVE9rK0pWL3hsQU10dFlFUlY2Z2JhRVZCdVpteVpFV01tNTlQ?=
 =?utf-8?B?ZHBEaFlLYlNPb2d0aUhUSnJyTVFtVEhaSzBBeWJROUlteDhBRTBwZ2IrUXpP?=
 =?utf-8?B?K0ZFczBrNmc2ZEVYbGZvdk9malM2a09ZL0lETVFsNENpYmp2bkQzbVhGVVh1?=
 =?utf-8?B?S2tBR0RhclAvVmJXOWtqYVJkZTk1YVF3ZTc1TTZ0WVMvUGFUd1RpaTk5SDh0?=
 =?utf-8?B?VTlBbmRmUGtuZzF5ZHUyejlzbXNJYU5JNHN0U0p0NjFtb0gzbUxMZWt0NEhq?=
 =?utf-8?B?ejQzemxrT2Q4dGVCd1pzT2RuZ1N0a0UvNFZXS2Z6SURYVzhUTVppcmRqbGs2?=
 =?utf-8?B?RFBrQ1gxUjdjWnYxVjFrL29DR0ZGc3VsMlJhRC9ydzJzQzc5NmZsYlVmbFVV?=
 =?utf-8?B?K1ZTcUlaWFVUU1AyL2wwcjVOSnRGMU1Ua1hlQUJPbGhNQVFJVXdJRmVPaXlD?=
 =?utf-8?B?bVFsR2xKNE1XWXBoMElGeCtaTW54Nll3c1B6NUJUVmJYYjlidjl0b21zRHZP?=
 =?utf-8?B?UFpwWU83VUwzZ3VOODZTV1oxMnU3bmFuYUk2SGlDOENpSDBNcGI0MnRtTlJ2?=
 =?utf-8?B?S1A4MW1WdTcvdGh4MmI2ekJjOGJuaGs4eUtoTWgvSW9QWXh6d09HNjRkYVhz?=
 =?utf-8?B?dFdPUTdaMlJOY3l5b0Zma2taeld4ZEdRbDBXcFBNb291NDYrT1Z0VjZWTXZX?=
 =?utf-8?B?V2toWkRBSXU1MUpuL0JVdFVXUlAwbmEzRXVxbEFmUDdEblpqWlUyZGtCN3ZI?=
 =?utf-8?B?TDBBTng0clhZQ0p0em5kbExZUzNVTDNUb0M5VkNiOUUrTmdnT05GZkgyMWZH?=
 =?utf-8?B?SXNSOVNIeXlHR3JVN3J1d0xrTWV2UU9iUExNem80d093amJZdGVlYnJheHNo?=
 =?utf-8?B?V3dZUjJTcjN0U05CM0Q5K0VtOW5ERkRmZkIxUkJLaFFQVVlCb2RORHRWdEY4?=
 =?utf-8?B?TWxyRURqbDkwakFCOXNrU3h0UE1vcnBCSWFKdGl6VkxqMDhIMHgwWFVmajdt?=
 =?utf-8?B?M011MG11ajh5aSs2cGVwSjNONkNTTTdONk5wY25xTjF4bWZSTlZPazdkYkh2?=
 =?utf-8?B?UDBRUnBDeWFja1RLcnk4TUhtSXI3RTZhRVhqNTV5cVJUN2pvVU9ibmJzclUw?=
 =?utf-8?B?WFljVlg2WjNNa1lBTCttTm1udWQ3WEhMV2FlWVJBV1pTRnRVckl0aVVlSzg0?=
 =?utf-8?B?Y1NvSUhyajhrdFgzQWd0a20wNjZTdVA3SWZQUEFWSkp4Ny9vNnVXSHpjTmdY?=
 =?utf-8?B?M0Z6azBWUlFDb1RZeXE3K2RLSG1sSUlwc3RvYisvYldWQXVYWE56TkI1ZStI?=
 =?utf-8?B?bERzWEVCK1JGOGhsRVJJdjJSblh4b3c3bFl3Z3prRERiWjhrUE1RR2JzbVpv?=
 =?utf-8?B?TVRRQ25BU3RmczFIWS9NeWpQeXFYeXFpekdCbkVXdzl4ckMwN1d0MmNZWTVP?=
 =?utf-8?B?d1NKTFZXMEtFNHNrWk9xRDV5bWlsZDdwUWMrZFF0clZnOHo2Um4rcHQxZVl0?=
 =?utf-8?B?Ulp5UXdqYXdtcEhTa3d2aTlkWnk4bjVWS0RzTE00VlBTVXo4cWtDVGFvc2JI?=
 =?utf-8?B?cUM1by9RMUdZQUg1UytBMG45bUpWNDE0UW0rbUlSZzd1N2VSTmFxTGNsRnVX?=
 =?utf-8?B?MFVkeW8xMFdFUFJVS1NEMUo4MCtYa0E0OUpSWGkzTXpISkpxTHBtckNIZmFF?=
 =?utf-8?Q?1u3fdt5qFic=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1hhdjhrWWJ1TllQT1VTbzZDanpBa3grZjM0SjVRWERudEh1UGtEYlNMMGcx?=
 =?utf-8?B?c3paS05YU3FhZVZWdjB3UUhxRlZJbEIrQWE5S25Gb1ZpVTFqZ3d4MzB6WDN5?=
 =?utf-8?B?bldxMDJydjlaeDBlankwcTNpa0Z6citaUWNTMFNWSjRVQ2U4RzBPUXZONDlq?=
 =?utf-8?B?SGE3SnBFOUFTZmg1VUl2aDU5QUFnakVkcGl1Y0tLR0x2UDE3RUJpM2dLUXQr?=
 =?utf-8?B?SFRFWHIra1NkQW13U3NsSXIyQ2QzZXlMSzEwaG1Yam5Fb2JEOElEUTlYMWRT?=
 =?utf-8?B?S1dYOGd5VHZQdXlsVFBacHFVNTNuS1phK3djSS91eHJVVGN1WklWSzNrL1Ni?=
 =?utf-8?B?K3JqMFFVQ2xsc1BmOGgxdW9za1puNzJiN3p5b1N5YjJYeTJBb3l0Vit4RWZZ?=
 =?utf-8?B?RlBxWm9YRWluOUxpRHJqd2liaVZUcXJ5MnhQVTNtRmplVWNRL3B6b0NpQ0ky?=
 =?utf-8?B?WFJOY2VxcEltRlpqRVpwaEx6WnNuRkFjSkIyQmdoTi84dXZFUldUZEQvOUF2?=
 =?utf-8?B?WlViTzBlS1NHUDhsNEptYVlaL2tpVkRWN3ZreVlCbituekRuaXJheTE0SUxI?=
 =?utf-8?B?ZVhWbE0vY24yeTdrbks5R0R1VFpsMVFzUzFsMnRRa3ZZL3E2WTNGbHVBTkdq?=
 =?utf-8?B?VkhxRmFOQXRodXg2L1lpanBiRVV1LzZ5TXZaRG4zdGhsUHEwWlNxSmxiSDdh?=
 =?utf-8?B?bFB0by9uZHkzSHVoT0pTRys5TlMvYzdMMEgwTE5tSG5pQ3JSYWtnSUpqU2FN?=
 =?utf-8?B?MHJpelp0K3lGUEZVNS9PZkkzL2RQOTFCQ1ljTE94Q1hqalJnN1BpV1VkN0VN?=
 =?utf-8?B?Q3ZXeHBmMkF5SkdXU0t0T3k0QTJXeVZRYVM3ZlhNVzIyak93YUdKMXhBUU5U?=
 =?utf-8?B?MWJsTFIxcVIxd0FVSFB2dW5yOURyQzF6SzV0TzV2eERqclpyS3YydlRTVVhx?=
 =?utf-8?B?U3FUUHBYQkRJNnMrbzhlaCtVT1Ezb2x1WEhJMEtMaHA5U0RlYytFai9ZRWFP?=
 =?utf-8?B?WVNiOGNjZUJYeGZnSWhUa09PRkhFRFBOdytyaE9tQmh0TnRQcXEyZzVxWGlB?=
 =?utf-8?B?ZFNRbmp1SUdma28zanJ6em53clN0SStQVEtlaGxOTFZmdklSV1VMblVvV2dI?=
 =?utf-8?B?YWhaSmE5b0FoOG05K29ZTkIzQ3ppZkVhcEJ1L1d5VEJlM0hvM010ZklKYmpU?=
 =?utf-8?B?cEpTOU1hNHBTZFhtYVZXbURldVJuc0VHZ21nOFl1MkxtclQzYkF2a3o5TFY0?=
 =?utf-8?B?dUN0dDJmdWwzU3FXL2Q3bUtYSzhJMURjajFYWUl3bEprWFY4d3BtYzAzUUFa?=
 =?utf-8?B?ckVTQm1ZUkFlZHlqS2hQcSs4L0JrdU9PMGtjRGRsaTUwcXIzQ3R6ZUE0YThI?=
 =?utf-8?B?ekQrVDh4bGlSMVRITDFiWCtKWS9SU1IyazBHaUV4YURmZWI3aktvcEpVN2V5?=
 =?utf-8?B?YTJMQkJyU1JwUUtCd1E0WGdIV0NVY1lmQlFyY3BWT1c4Skx2U21UOW1IWnF3?=
 =?utf-8?B?eWxZQWdNNEFxbENMTjVQMk5QRVljYTdEUTFQNlZZS3Y3ZjhKTER6ME5peGpO?=
 =?utf-8?B?QmVjb1lUV2kxRXdlaVdkR0NQa0NZOVRrOXRpZWJvbDUvQXI0R3pxeFlvUG9V?=
 =?utf-8?B?WkJIakRPdVU0bjVPOEN3c25ZUVJXS29YVUI1akxkWWdzcHMxelIxVzI4L3Vn?=
 =?utf-8?B?L0F4WlU1UWt6eUg4SksrcG5qTVdBbnRIeUNvaDRnWFlrdVFlNnhRZXNzT1Ex?=
 =?utf-8?B?Z2ZIZkZWV1FuZHI4YnFrNldJcmJGa3J1RmhyYS9aL3RRUG1SdDlLc2RxVjdF?=
 =?utf-8?B?VnVtV3hJVTY4eFdORkVxeW9ZRWozR0YwZUl4TEw2M1NuUTc1MmVZMTJGYmJj?=
 =?utf-8?B?TTVUVFo2ZTU2SUt0dGpVZ0dneWMrZjR2b1lJUm45QXI1Uk5BMFJ5WnNxMFh6?=
 =?utf-8?B?ejdNM0dLNkF4K01OcE51TFNzelB1NFM4Tmlid1dDcTduTVQzT0R2cnI0N1l4?=
 =?utf-8?B?Rzl2cXV3SGs1VWNYNlJaZm5VekdGU09hS05hU0thNExuVzg5SHVGcHR4elpU?=
 =?utf-8?B?bUQ2MFp0b1M5ZmRldldKd3QzOE5PWGFjL0lEWkNvSEZaeFpIcjRqOGZsQnp3?=
 =?utf-8?B?c1JoaGhUc0NTNVJXcnNGdi8ycUFDOWpZU3I2Yit1aGJoVmZVdlRQSkZvWG1R?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e31f6d0-c433-459e-d33b-08ddd43a9e79
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 16:10:39.2037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlU3bD9jNWKh+9W/JALcGdw/48FiZkKowa9aPsSBH1sxdsgpz5WXkbTS6d3aQP/WPjCFpGlvt7wfincEnVf415Tc0zt2NbCQdJrTW+swCjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6567
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 1 Aug 2025 15:33:43 -0700

> On Wed, 30 Jul 2025 18:07:15 +0200 Alexander Lobakin wrote:
>> Use __LIBETH_WORD_ACCESS to parse descriptors more efficiently when
>> applicable. It really gives some good boosts and code size reduction
>> on x86_64.
> 
> Could you perhaps quantify the goodness of the boost with a number? :)

Sure, only a matter of switching this definition and running the tests
(and bloat-o-meter).
Intel doesn't allow us to publish raw numbers (Gbps/Mpps), I hope the
diff in percents (+ bloat-o-meter output) would be enough?

Thanks,
Olek

