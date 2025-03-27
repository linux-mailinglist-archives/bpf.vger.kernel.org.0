Return-Path: <bpf+bounces-54809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20980A732C3
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 13:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6198A1751BC
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 12:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5577D214A95;
	Thu, 27 Mar 2025 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdbQBna6"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547522101BD;
	Thu, 27 Mar 2025 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743080233; cv=fail; b=UnCrvp53sNuAVwRiVCitMlaxChjKt0M2Mrw8F9eDSAiOB6KTHfBQ15GpRm2Een2KXvvEvNO6uPpiaD2Yf8z5/IbpKsuT0pjIkavcQ0C7VPjAjp0DOwcLk2R/JS/qLpNIKKgFxFuL5/kKXQaMPtB8mA+OsWP975RJdJVfmtZoxKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743080233; c=relaxed/simple;
	bh=Kv1BxaHWSxwAzwFvJ37Zw25vwWEAm92OexOwP0rzKOA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eD3S8NWRUaXQ0YzJAfoYdRS8ikwPxKuaAM5y9y+S3HXVeiu5Q/WRHj71WsJBeUcgQYFHfR59Yq3sSCsphodGg0zcLCR5fP6CisZxrhaP2IHvZg0z3TLUEXq2xcmJQFtkDYE80uHAswn6EpUx45axgMrINMlZ7HmXiVEwRZAUkm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdbQBna6; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743080233; x=1774616233;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Kv1BxaHWSxwAzwFvJ37Zw25vwWEAm92OexOwP0rzKOA=;
  b=KdbQBna6AULOyvWv1YjxOP+E6Z84v++vdNffv5PS84n3yFwaUIca9X7t
   HjQqILG5QEyEcwX6ed9zxTqDDyA6911eeRnW8xt/YMeQJTs+gs9xPH7yk
   tL5asGXNRbSf16CaykmaS6obUcA2gUOXhg0CrZypaa1XpsgNwoWjfmHJK
   DMBGshfwqepxB/ecBHhf3tWyA+j1P8VHra4TODx6zM0v/didJMHR9jFwd
   qlCtciUtX2uuBDMtasciA4Z72qQlOTTSKeFJzTuWGtOxIL23XYKHtrzHs
   VgZBHFTK3ZPaixpBRMT7Ga4HCX6mAZrFD+oB2dNQ52mhigLrvOb5R9Slw
   w==;
X-CSE-ConnectionGUID: xQfT4VlFSkWkLEebFo9Npw==
X-CSE-MsgGUID: NLg5g9PER+mg1cEQyNYRHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55775516"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="55775516"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 05:57:12 -0700
X-CSE-ConnectionGUID: nCo82iL0SgmBWyarDc9m2w==
X-CSE-MsgGUID: bW5M6zQoQ4+SfChchzdHOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="156116858"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2025 05:57:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 05:57:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 05:57:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 05:57:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCG5c29KMZB6N+ad9er2TZRvE+XRoLfbaIAPHdOlsZiJSv0l1pgeaoTCXNi76WHuB01rflzatsX0LsAwYMQD+/PUHJRlWgEMaZBplCU5ptVICF/gg2wQLlG23/PdqPLXzLt1yYTTFHU3n5fglB7DrHy4FuZoND3NUCtDbgfgdXQ4xBPaCx/kqytzhKGUzldnT46MHkbRQ1LeU1zEjmHIEzgECRp14SzPm4pR7ZAQI8BGj+GXY0CdB9oGXCDqM0kVvFE4nw9G5BrjCpmaVdi4hXYtjVbl9IppBzurktKQY7Pp1/giftKuj5Bn1Nkan1qOYefDqWuP+aHM3JEHrNKfuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08uIr9PbDtW2mtVr80RhGWfAP4kcgl77S4OPrE370ks=;
 b=u1BemCSvhd762XPsZ6qKuPWPFBgb1MZClgV7Y+eWOt2sSN2MYQ+a/EiZwWYyhMEsPesmKfSR99kr40JxPcT6lcEoFlogFTReO2CjniqC+CTwlbnYF407m6VULIe+PsZ5Y92fbXFPotwyDeCFKL98nuADJhPMhCanfPeKEMOx+cFGqXXbRUD/IQCtpsqtjN4+C1VexnCHirNgAlUFb9C+XQUlcu1rfaiYwboH/E6hslpqN+974HPD9DWpIpJx5cdiDeP6uF2zhpWDeMZmFaC5Vo/ZbAy+rj5Q14e7c1MiDFQ3TPgV4YZ/zoKmmfkwb2wL1ylya9eaOd5lwy6fxMQoiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20)
 by CH3PR11MB8519.namprd11.prod.outlook.com (2603:10b6:610:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 12:57:01 +0000
Received: from CY5PR11MB6307.namprd11.prod.outlook.com
 ([fe80::1fa2:d2f9:5904:2a14]) by CY5PR11MB6307.namprd11.prod.outlook.com
 ([fe80::1fa2:d2f9:5904:2a14%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 12:57:01 +0000
Message-ID: <0980c20a-597b-4a6b-883f-280db6105eac@intel.com>
Date: Thu, 27 Mar 2025 14:56:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v10 05/14] igc: rename
 I225_RXPBSIZE_DEFAULT and I225_TXPBSIZE_DEFAULT
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Furong Xu
	<0x1207@gmail.com>, Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, Hariprasad Kelam
	<hkelam@marvell.com>, Xiaolei Wang <xiaolei.wang@windriver.com>, "Suraj
 Jaiswal" <quic_jsuraj@quicinc.com>, Kory Maincent
	<kory.maincent@bootlin.com>, Gal Pressman <gal@nvidia.com>, Jesper Nilsson
	<jesper.nilsson@axis.com>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, Chwee-Lin Choong
	<chwee.lin.choong@intel.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, Kunihiko Hayashi
	<hayashi.kunihiko@socionext.com>, Serge Semin <fancer.lancer@gmail.com>
References: <20250318030742.2567080-1-faizal.abdul.rahim@linux.intel.com>
 <20250318030742.2567080-6-faizal.abdul.rahim@linux.intel.com>
Content-Language: en-US
From: Mor Bar-Gabay <morx.bar.gabay@intel.com>
In-Reply-To: <20250318030742.2567080-6-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6307:EE_|CH3PR11MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: c836115f-b150-42c0-ddcf-08dd6d2edd85
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWhzVTBGV3BnelYzbGRxdXRNQnJkaFo0eDhlS2UwcEJQK252dE1CMmV6bkhL?=
 =?utf-8?B?dkJFVFpmdWdOdGxDZWhnM2NuSDQ3dTV4ZTVMNTJwcTRHY2pKUGJ5VU9HOVBv?=
 =?utf-8?B?UGpFZGhVN29GbXlvOFhSdnRsckZKT3lOb2Q2K0EvNUhJWTVYVjZRRGNVQXdG?=
 =?utf-8?B?Y1V5OEJYTG5MTnZCOXgvbGV2NmV4RWNadEJGby8wa3U0RjcwWjZGSXVwd1VP?=
 =?utf-8?B?eDBTSnJicXM1UmxOWmFqQUlMVjZIdHpUU081eCtJQUhLL2tPTjRhMmU4YWFI?=
 =?utf-8?B?QW9vVmZic093d05YN2p6YlEwZjBPdVYzS1RSSzl2VTBmSUFoa0RzOUo2aWli?=
 =?utf-8?B?M1BwWk5DVnc4KzRjS2M5MUdJK2hLMzBXbHJmWE5rVnFJQzRtNWswNGJEQTFs?=
 =?utf-8?B?bitqVFdoZzFjUU1ldGhQUFNLMnltY1d1ZXZScGViaTdRNi8yOGszTWM1YnBJ?=
 =?utf-8?B?S0FYa2YrUVhjWHpmZERUS08yS3pycUgyRW9YTGZ1VHg1RW5JM3pKUCt1U0cy?=
 =?utf-8?B?Y0JIeDBmTlUrMEZOZ1JSRHJGNE9ITXd4Qk83ak9SY0NSdDVXMVgxSE4xbndD?=
 =?utf-8?B?WmtZZ1NMYVNWU1pYWDE5djRiYW12RzFCRitVbkdXYjdVYUU2ZC9UdjR5WUZu?=
 =?utf-8?B?Y1lralhsUEtFSGpBNFlnUEtuTWFla2UvQXhxQXh3VFEwajNJWWZ4U2NONkZw?=
 =?utf-8?B?ckN3VWdPdkRUdDRoWlZKemkzTnpnTlVrampvSXNiSG1PL1plR3JlSzF4T1VZ?=
 =?utf-8?B?UnhSelAyU3RLcmVKNHZLbWZIL3E2YXU4WEFyZWhPdm1QQ1p3SHdvblQ3dWcx?=
 =?utf-8?B?cU1nVnpJZm5xdVpIODNrejZ5Zm53NVVxY2MzVmxSaVpoRzdMTmNZVzQxSjI1?=
 =?utf-8?B?R0hkWE1BNTFKUnViby9IZnN5d3JCVms4cFN3NUNWQmN2ejVPTjNFVFl6V1Nq?=
 =?utf-8?B?Q2FRMDZ6UHdhN01ZSDRGUXRFcXo3cjlWb3JtVzY3ZUFUNE9MTDU5MUxnMlhU?=
 =?utf-8?B?c3hpMTk4MTY3M3c4MnVKdnZWQnRRbHljT2hDdnZxWjlSN0JPSmZxMWVOa3R3?=
 =?utf-8?B?VERJbWtQZy9HUWY2WS92VlRGalBINW9WOWFYbDZlUkpiSXhIMWFzc2ZWMTYw?=
 =?utf-8?B?RVgzNjhiYU9Ob296RTNFeTZibm9wNDVJN21qWVRybkdiVkNhc1ZKRVYxV0tN?=
 =?utf-8?B?OU91aG0vZEFZWjFqREtJQTYxN1NIWjhJSkRGN0w3dmZDdy9PNGdOUFpNUE0v?=
 =?utf-8?B?R1ltSlNLamEvZ1I1VjByV2NIMjlSNEw3QmNvd3plb3RxTjlrRlZObmNnOGdv?=
 =?utf-8?B?N2RiNGZXUG5zZXh2SXg1aG12SGRpc3BiTVpUUjBDZ3FPaTltNjhZa0N1c1d0?=
 =?utf-8?B?cWdnQUsyWWNQajZxRU5QNkp6d0E4UlRqbWxPNTU5YW1pMmQ4aU1iS0crN0N2?=
 =?utf-8?B?Ym54VkpiSzBpa29Fajk1NWtFMjd0K2crNnk3eVExMElycEdxQnlKd3hUaHkv?=
 =?utf-8?B?MEtiVmJpZDdyKzQ3bkFlcFBaOEtTbVhEMW5BZWh1MnpzbVcwaFc1L1krd0Rx?=
 =?utf-8?B?cFRrNi9kMHVTUWZIeVNPVnV3SDVsZERiWXEyNVdzeE5ueWxSYVVHdXpTZ0I5?=
 =?utf-8?B?UmdJZU5FTDVqd2hhMm00VitjcGU2eG5xcmxHRDN5Y2FxZmpZSXRVQjNpNWZl?=
 =?utf-8?B?RVdxNG82R29lVVo0MGxaZHMvRTNuNkgwOUlCOGVSMzJlQ0F0Zy9rbFV0RFI4?=
 =?utf-8?B?YUFuSU5pbEhUbkdKR0VBOUorMnd2YjQwQ1NkNlJvS1AyWWdCcEdINHA5cEtI?=
 =?utf-8?B?K1J4OWg3TVMyc1E1WWs0a2IwTnFOSzFEditoWmVvQnIrRVV4QmFJVVJ1V29t?=
 =?utf-8?B?OVdobFc2TzBMa1FkMTF5U2JpSW96aU82MUVDVmhhVEorNGxCWmF3WE45V1lm?=
 =?utf-8?Q?p7XQJA31Pw8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6307.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3dpQytGQzN5Zi91Zyt6NHlHd0p0cmpMUzEydHl2bFh3SHhCYmNrQUJCdHo1?=
 =?utf-8?B?QzI0d3Q3dTVyS0VhcytmNVJtaldNaVlWNU1xQncxejYxdGI3eU4rOTlhYTIy?=
 =?utf-8?B?b05UZkVLelVuRW5lQmRuRDBuM09oM3J6bVBxRjc0cDUrWGdrY2o4QmltZ3h2?=
 =?utf-8?B?bm0yU0hPaE8xcWxsQ1U2VHRWS0dlc3R0OGU1QkJXTkRic0p4cDNZR1JRYW04?=
 =?utf-8?B?VDR6NW9Gdkptc0xpRUdvUTdUdm52OE1NeFcyTFZSM2JHSjhHWHgvbE5CaWhq?=
 =?utf-8?B?dndvcGdNUmxNT2NtYzNzS01kbG5xR3B0SUlNNGNaS3I4c2liZUF6aHp5QjVt?=
 =?utf-8?B?MjFHY1lJd3N2T2hobUdFRml3aEJvTlFDRW5OcDVrbWxkYnVHZVRJWXpuRUhv?=
 =?utf-8?B?UklNcGpqVGdnQUdXZmNjYnJFaG9sUGdocEZMYWdNbWJoTE1DWHlndzBhZjBR?=
 =?utf-8?B?OFJ2UmY2bDF0K3JQejNCc3FIdWpjRnhveG9SWjNGWFJrRmljNVN1MjFISEI3?=
 =?utf-8?B?V2VSbHpuK04wUDFzNWoyUi9wdjFOWlNORzVrY0t1MG13bnowY1I1OU8wMnho?=
 =?utf-8?B?bituVU5YbzJmS1Nqc3RQOXAyUjIzTkZ2T2phN2tRRU9FQXM2K0llZmdCTE10?=
 =?utf-8?B?RjZxYlN3R01DYUVTSG5yR1NBSlpmczJrTWVBbUNWWGRwT2ZGRlR3YXZVL1hv?=
 =?utf-8?B?RFNhUTBNaXlRVk1DUm5hKzRVbWFFRGNqSkp3ampweWNDWHJMV3dOUFdXS3FY?=
 =?utf-8?B?cUUyQ0hTbjF2TDlVenhmcTVsZGFqM1UvVStUVEJHQk1wbEJ2OWhyNlJHcUg3?=
 =?utf-8?B?YWVOZ3JTQlJBT3NaaWF2Y2RVWWRLZFA1NXNuZExKV3lXbVYrYjRuK3M4VEpT?=
 =?utf-8?B?YXZReHBmNU1PbWtES1BlYTB5MFJXME90dkxUdmFTRnZiZEk3WFE3UXJqVWpy?=
 =?utf-8?B?Y2w0NUNkZ2Jxdkt2ZElDdGJMc0lWakFLS1VjWk05QmkxaHZVSUhwalhDcVI3?=
 =?utf-8?B?RTFoUVdqWGxMLzl3aGROS1BReFhLbmZzVzJtQkxCWWFpRmRVOWVOUVEzY0Y3?=
 =?utf-8?B?VWQ5SU4wejNPcDhTR2svcE1pRE13bkNMaUtkWlZCOFFzRDl1eUhlUTBZWUVH?=
 =?utf-8?B?aHE1UUxFeXZwOHMzTzQ2YVRiVTBMMkNmM0RXZ2RjQ1RGTXR0cHNMZ3Q5S3JT?=
 =?utf-8?B?RnZpelh4NDZJRHROUndSWmg5NkJvNzBDVWtXak5mME9qNWh2UTYvdzF5Mnlj?=
 =?utf-8?B?TFova0lLM3lkQ0NDMHppMTVseGg4c0tnSUVtVlZSZzZVdFJiTlJnTzdBYWNV?=
 =?utf-8?B?TTRjb0dZcm1wa29NS3NXVHNHck9sdzdtRlJ4aGx4aE9iby9QNjI2NHdBcWEx?=
 =?utf-8?B?eFZ6bHVlbjBsRkRPNXZrTFQ0SFFSVEg4REJJaGZjSDJyUXgvaVU5YzZyQVUv?=
 =?utf-8?B?WHAraGJtSDRLczlJMTN6MFZLWnhmL21wM1ZEdVlpWFhPVXhyQWJCcXFuR0dl?=
 =?utf-8?B?UWFyNllBeXNuTDdRRllHaEdpQTJENnNqSlAvMEhzMml5MlNubkk3SFdnZFlF?=
 =?utf-8?B?aFJ1WXpNU1dlaytyckxIZ3MrdDgwU1JZYXUyWi9YQ2F2WHpKNEdLVHlOMDFr?=
 =?utf-8?B?SWhDUGVBaHdSREVTTEdGZllvYTFrLzN4OWNpcGRLQzROazljaHBWcThVSjJj?=
 =?utf-8?B?OHFTQkZJcGN2ZkR4S0dpejdMUmpVU3NPcWU2LzVlT1pwUjNTS0FJWEE1R2h4?=
 =?utf-8?B?NXRKZFNjUy8xSndyNjZQVXFzT3c3UmplcTlBN2l3eHBTYWFVaHdXOEZqODNI?=
 =?utf-8?B?U3B4eDMxdTZxVDJyM2VtYThMNHY4RHFJS00ybVphSXRoaDhrWjRoa2RHNEpq?=
 =?utf-8?B?MVRjVEsweUdHOVB0RHlnTDJVVmVBSlQ3cE5PdFFkNFVGb05hZTREbUFXNWJj?=
 =?utf-8?B?eDlJWUtndXh4RitSSGdlVDQrS202YUNSQlRuRWlSS2F6R3I5S2JzK3VNSU9z?=
 =?utf-8?B?YVdjazdaNW81dS9XZFVPUlJhekNNM2FacFhjTXhsYzRnQVVVZi8vNnJYcUg4?=
 =?utf-8?B?UVE4anZ3bzdWT2JwbUxQN2pqU0laYWM5U054cWtUQ2k3TVNEV1dzR2Z3OU9P?=
 =?utf-8?B?TUI4VVRiOWtKM0g0RWIwMW4wOERFZXNQVWROTkwxQ05jT1F2MC9ydGdVYmRt?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c836115f-b150-42c0-ddcf-08dd6d2edd85
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6307.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 12:57:01.3526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6cHyl6rDPTmvGWbV71SERpTP44Un2oHgBM1U+bt6KFt9JM8nhg6+du9WQvgxDfyEwDmFHEKySk5MZjv0TLUUbPxoBzBNHQlUqHRbIMp6M4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8519
X-OriginatorOrg: intel.com

On 18/03/2025 5:07, Faizal Rahim wrote:
> Rename RX and TX packet buffer size macros in preparation for an
> upcoming patch that will refactor buffer size handling using FIELD_PREP
> and GENMASK.
> 
> Changes:
> - Rename I225_RXPBSIZE_DEFAULT to IGC_RXPBSIZE_EXP_BMC_DEFAULT.
>    The EXP_BMC suffix explicitly indicates Express and BMC buffer
>    default values, improving readability and reusability for the
>    upcoming changes, while also better reflecting the current buffer
>    allocations.
> - Rename I225_TXPBSIZE_DEFAULT to IGC_TXPBSIZE_DEFAULT.
> 
> These registers apply to both i225 and i226, so using the IGC prefix
> aligns with existing macro naming conventions.
> 
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_defines.h | 7 ++++---
>   drivers/net/ethernet/intel/igc/igc_main.c    | 4 ++--
>   drivers/net/ethernet/intel/igc/igc_tsn.c     | 2 +-
>   3 files changed, 7 insertions(+), 6 deletions(-)
> 
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>

