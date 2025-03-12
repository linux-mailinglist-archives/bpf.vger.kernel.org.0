Return-Path: <bpf+bounces-53911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5690DA5E24D
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 18:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF5C1793EA
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 17:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0B92505BB;
	Wed, 12 Mar 2025 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fpPwGvZV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53421F4CB7;
	Wed, 12 Mar 2025 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741799419; cv=fail; b=OVT/81s07LDofHWERrVsYxAHVweRS7V+ZjjW0yPg3/8B2QINVezhf2GaTd1hAQo+bpe3/waObb8N91PYucKsNfnm7RtK5sHUnCHwIz9HWputNNSS3PucYTwFygQXaQ2MpjYsJEaUMXFlUIU+pM7bLVJYD8RS0yCaBQiw/vDxA9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741799419; c=relaxed/simple;
	bh=6Ad8RYsM63hefPtNu7wxTazb+/SKzmyvWOGnsYFjZA0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UFNr70x6bNasgo5lVmGAATIfSewileNLDDaZmdLhVoRHjPp/mKsF73urLKx5a/R2K0wLSrC9P8jvqrzeMLIYEEeDLbHfpoDJ6LIFxjJVSiwP6r1Il50yzcpmgnuETHTpAf1NZNF/UfcssZXO7lnhNxLpphVmZ4SIOoDh9WyJV0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fpPwGvZV; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741799418; x=1773335418;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6Ad8RYsM63hefPtNu7wxTazb+/SKzmyvWOGnsYFjZA0=;
  b=fpPwGvZVyxpTK/Iu4cZ6R52D7URE5l9n/8NkRre00bV2b8afFBCTOaLb
   gGipCtrwyHGwFkKmlI3ArGK7XobrK8va5+UNHO1hHcNjXryOtQsyaXnCq
   XJNItuBsrRdJKKgMCsD158ZImtYYAQjOj6JtKfX7omJkJevD3p8rgHnLf
   fnTxfmJNCKgAqhlpMbQFoNPTjpDaOsHDXHVod7ehXxjZrv9X8Nza9SKTl
   spiJxrSBFlwgz3P6dNB+MyWxGnbSAh8RZaAOMh+e4lFoDHQQPR1DZQTA1
   ICIuu5b0qjsuEU2okgApcECkrCkN2/LTixnW6b7iW8N5yDif5DRv5+jbw
   g==;
X-CSE-ConnectionGUID: ZRgXGV3WQ1qnepP5baE4aQ==
X-CSE-MsgGUID: 1uVyQXfiR26EIvjw2AIUfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42767321"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42767321"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 10:10:15 -0700
X-CSE-ConnectionGUID: IccI6Vm3T2eVxBARcju00w==
X-CSE-MsgGUID: yD0loA2HQMiLxrc6dy3+9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="151519242"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 10:10:16 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 12 Mar 2025 10:10:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Mar 2025 10:10:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 10:10:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wi38L5FCQIHdIGbX4KMVN01krvj9r9bds7BHArrqGYaWXHeG0gDHoZuXczDeFCvj4Ca135EN/2CnMe2yWKZGJHv09jq+QkJhTIC7HJ+1ciZ9qqSEKwSogbNRWQ5uYv/X+r60lhMyOvakJYGtKJUmRQoib1sX0czSmCOg4On/MGj0YiJRyPoEQAmHv3Y5ut4wkdwBmF5PxpLHCryhzNt5yMpcnlJB5L8f4YRq3fkb82wEwqZC4WRPuy5tlW8qlKXKKi9b4ZYVSNNpyntFQ5I9noKZQrlMSNNi/ScuFaNuVGUkNClBtifRTHKxp4+cdDTpoMX7LK1WZyaztSZT0iJ7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIFM3fJBd9cMFlr4aCDasAa2ePZSrOMVoc4wEt01K2I=;
 b=TPTS5zDO7+dYl3Nxyrp/hv3n5x0M2VNl5pF3uufY1tu0Vge7oCSGkqvVtsmqdiymcBlVaGLkbGAto/itXqpt1a6CZ04MlUbfuFDlPNIFPVvGfVCEb9dhpp4PrFZMaZElf6VzSXbEncKLKw1r9N6NE/xfTDzmYc/mjCXTAA0X6IEDxMvES3K6bLbIG3PDTinyJrcERTAH/vWkdFOgseRM3Bvqy5z52x7cGAbkpAWLXIsqZpIuvt4GROAcjpTXu3GOzDNIsbVwQs+lpQNTdXD3AYVAW0B1KesJmLsXECWzfOwHiUI2dax/hHTUvhEwpCNROlzfoOhbAdnYUBnaEb0ZmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH8PR11MB6832.namprd11.prod.outlook.com (2603:10b6:510:22c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 17:10:11 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 17:10:11 +0000
Message-ID: <b1255dff-91c4-4042-bb3d-78245065c669@intel.com>
Date: Wed, 12 Mar 2025 18:10:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/16] idpf: fix Rx descriptor ready check
 barrier in splitq
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Michal Kubiak
	<michal.kubiak@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-6-aleksander.lobakin@intel.com>
 <Z8rHp046ELv2wrac@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <Z8rHp046ELv2wrac@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::6) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH8PR11MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 93817db2-e105-43a1-76ee-08dd6188bf49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEd5WTNYZzJOZlpDQzVSOHFLcVFVQ3lyQnBhbUx4RDRoeDZOZGJoZ1JaWFZ4?=
 =?utf-8?B?MnFPRGx6bnNtZWhYTlE2U3B5cDVUTDlyMUNZWGlMUlBITXRaRkhUTlpvWWJV?=
 =?utf-8?B?M3ZleEhpVnlLVEx6Zi9GQlRCMTVBTm9EamxVVHhRWlFlczBJb1hldFliMkcv?=
 =?utf-8?B?Sm5UK05STTM5TnVrQ3hzZ1g0Vmgvc2lVa0JINmo1bGM0SG9UZWkvanZxelVm?=
 =?utf-8?B?NDJSYUFkZUhISXkxUmlBZjRTMGptbzhLOU5JT2xPdUQ4VGhZUlp1L1ZJYVRh?=
 =?utf-8?B?Q0xoZ000citabXhFSkczY1hRWnhMcHNnRTRHSHJENzIwd3ZWWFRyNTAzbm1Y?=
 =?utf-8?B?ZExsTmU4amJmNU1xN2g3cUZ0SFM4T0g0a09vVXUxRlNhcGVmNHFaT0FzelRR?=
 =?utf-8?B?bzJFWHZLQmhIckR6eUM3bFZNdzgyUmlCRmw1QldXZjlXRzM1VjMwNXIvanZ1?=
 =?utf-8?B?UFJEVkNrTmI2c0NkOFZoRHB2bzRPZ1RuSUFGUzlxeTF0Y2pZRVZWUDdqTkxG?=
 =?utf-8?B?SGFiSE9HUlp3Y0MrRUJUNmRyVmw4WFV5aWRmUVpDZUgxbFNLUFM0ZEJIN2hm?=
 =?utf-8?B?NmFneFZuT0RJc0prMFVreGpRVXFrcC9NRjRmRlRsMnRocmJMcWVTOUZKa0tF?=
 =?utf-8?B?WjFxWDVIaVpKTnhrci8vcXBaQWcwVWJBWWdjc2VmbmpnZHlGbnhOcDFtdTAv?=
 =?utf-8?B?WEVOUUdvMVRGWWVTWlZlckR5Q1ZWVnZJclZXM053NU1YWFkvRTQ2UzZSV3Ay?=
 =?utf-8?B?TWNvdVNzaExKbTJMYnZRek11cEN2aHB0YSsxMnNIbE1jSnVtSU9xM0NnVis2?=
 =?utf-8?B?cTVYWHJkaEd2ZlFFYTNHMDREdnhCaXd3ZDR4cURYSVRlamdGVXUxMUtRNEMv?=
 =?utf-8?B?Mjg5eURpS2dSNktKbDhRM1p6bEZxV0NsMlN5RFJRQ0pic0FVaVA0ajJ3ZkVz?=
 =?utf-8?B?bTJVbjlXWEZnUTBmWmtPYWhDR0tzZ1NOOHlCTVo0UG5tQnhSZXp4UEJ0TzRY?=
 =?utf-8?B?aGp1TUQrWjB2Ni94MnUweDJrUDdxNmV5aGJ6aE9GZk9STE41WmhwamhYZFRO?=
 =?utf-8?B?d1YrRW16TkY2THl0NDBvbVVrQ0FZOUNiV0pvUC96ZmJ4VythaTVtL1o0ejlu?=
 =?utf-8?B?VXVpNlZINjVlbTZQSEVPSkZlRHluZ3BPcXAvV3BIWmJ5TU1HZDNiUVlQNFBm?=
 =?utf-8?B?ZGtqVVpqek53eitwMlpzeGZzWm9ZajA0cTd6NzJubHgzT0dob3RYRmJFeHAy?=
 =?utf-8?B?aE44T2xJOGhEOXp3TEw5dUcxKzdkRVFRbHQ2bUd1MSs3RlNwMkhqNXJjMEhZ?=
 =?utf-8?B?U3l5eHYrdTlOZDVRRUl1WDBZc0JXaDBBZThnTmlqUldVYXZWR2xzdWgvVEsw?=
 =?utf-8?B?MjF4NnVya245eVNheDJESnlpSEd0RHpsRXhMeXNmU3RiblVSV0JnL3FPMVh3?=
 =?utf-8?B?enJoM0JzWEVGSzRVTkJzcXZkM2ZHc01IckY0UGlISllSeEZkYldsUVhsK05E?=
 =?utf-8?B?Q3hBdlBqRjRxV3RmTENhcno4ZGNFMHNySFB4VUJVRFR6WFBSVEFLRjMvOFFI?=
 =?utf-8?B?Y3pJYXpieTFZN3N0Yk5oUnhGLys1bDN5ZGNXSzRCV1ZRRlBCOGZYYWxtamxZ?=
 =?utf-8?B?cGRKRWFwMldyYWducU01eUJSWW4xR1R4SlUwam5YM3hxMi8wKzRoZnRJc3dN?=
 =?utf-8?B?QjgrUi9xQkg1bUIxVHJkbk4vd1FCSzNZU0VtUTFGTW1zUU9RWXFkZXMzTjRj?=
 =?utf-8?B?WlpaZS9sWmpKQWpLZEtxWG5IYTFOcnF6eVlOQ1dLaE5pZTkvT1RhelRtcVgx?=
 =?utf-8?B?WERra2NSSmZHK3pSREpaNkJjU0RIWncwd0tmR0N0UDVhamtqaTV2enV0ZGw1?=
 =?utf-8?Q?y0CFKMf4fanp9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUNvS2xSc0xYaDZmdk5wUFhZME1tMS83YURpYnYySG9XakwvTGsvMUx2WE5O?=
 =?utf-8?B?Nlh1Tzd3UWgwM015cENabW1RQlNUWmVycG1VcUZCNUpEUHFVbzlMRnhBVHlC?=
 =?utf-8?B?RktpRWRxQ3RFVHJrRzBYam1DU3hVUFhqU3hWcGt1STRqdWsrYzNsTVJFWDNW?=
 =?utf-8?B?RmVBRmpxWC9YY3BZcks5ckQreDFEcmYzN3lNV0VqWkxHaGplUTN0ak92a0FQ?=
 =?utf-8?B?NW52UFB6cGdSaTZManljMklCYlN0b2ZuTnRGRlIzRmlteEdlcTNtVzdKME52?=
 =?utf-8?B?SEsvZE5hZnJjdlh2TXFMRmQwck9rZlRraTBOZDVnTElmeHRDM0NPdGdDeDJT?=
 =?utf-8?B?VG9yV1RKOUpTSy9vbmhtSklrSk1maGF1Y3hDcFBZcWRBRzVDeUpjQVRybFJ5?=
 =?utf-8?B?Wm9UUWU3TDJ1ZXA1eTI3WlhxOXVXdVJTKzZlZXFXN2lCZjVIYWg5TzRMN1R1?=
 =?utf-8?B?dUNXWEF0MFRCaGRqWUZCRVh6dkNNYnRSME5zK0t1azh1UkxZM0gvTnRHTmFn?=
 =?utf-8?B?dTlJNHhoRlVyUFNmdHl6SFZ5Z3hvanFpWUtwd3g4U2JaNVp1MGQwdjh0bHNl?=
 =?utf-8?B?Qllwa1NNTjJ5YVdxeDE1QU1OMGpQakg1akJhSFNRd3lBYmVrdnh4RUZRWVRh?=
 =?utf-8?B?bytsTnE5TEUxOGxiMDhmQUhHOWgxeU9xakJIamgxUHp1M215T1JmL0RHME9P?=
 =?utf-8?B?WEF1SjBscUJBSUpzK0RTZms5enNMMDJsTzFGSGJhdHBUcFBwb05tdUFCSndG?=
 =?utf-8?B?aVJUeHVxc1BtUmloLzI3d1pCMjB3azZuWVdERkxsRjBuSEJuc2VuQTJYamgz?=
 =?utf-8?B?SE9ka2pXQ3ZLTVdBQXNwdWlKNjRjMDllOTdtM0NqY1piRXZGcFJOMTlLTGFK?=
 =?utf-8?B?dVcvYjhzbGFYZ0RUdmVLYlp2NjhYN1RTeitvZDQwMDBxSDAzTkxrWkllN2J0?=
 =?utf-8?B?TWlSTUxiTlpnbWNBWmJtM0Y1cWFvdWZJa2M1c1JDSGg3Wk1ITVNJWW81RWlz?=
 =?utf-8?B?WlNhMmRweDZieDRHOHJ4eFVraVlWNFZUZGxHY1h4dEtTbG1ZbkFabjgrWC9t?=
 =?utf-8?B?VWprbWF2SEp3Szd6Q0swdGhkZ2hQVmlqTnM4RnJ0R0dYZEdEVXBCZHVMME5l?=
 =?utf-8?B?a1VKS2JBUVp5aGFEYTRibDdLOG8reEtqcm9rSzZlb3owVkJGVGNqSjNLM0I1?=
 =?utf-8?B?UCtsajZiWjI4aWJmUEdmVHg1ZUtBQUFOZHFtTDJiL0VmcGVEUHRPZkh3cFRm?=
 =?utf-8?B?Q1dhSGx2c0ZvcG5WdTh3c3g2cWs0cVB0b3R5N2hDbllSNlRURmFoTEp2cXBX?=
 =?utf-8?B?RHVYbUFsNjlRZ1ZYamZJbmZmakNBVFZ4THJORTFGL09oNDRkQ3h4MWo0OFE0?=
 =?utf-8?B?RW1qWDByWTlwTWkvTVMrdk00eHVJUVZKcTdURExzbitDaDlwZERCMFFLVi93?=
 =?utf-8?B?RkFhK3FWeFZHanRmYzJOSnVtRmxqVTc3aVlkbXMrMkRMN1VpODBEdzVOTVIw?=
 =?utf-8?B?aDR2b0pHeHVOMEM3ZVA3OUZSeDFRZHpBOXdMcmI2dnFnSWxhSW9SNHo5dEI0?=
 =?utf-8?B?MzYrelhDTnBLcU5aNHd2YzJ5SHh3aERSVzJOMVFTRmdZcHhDeGdLUGJ0bkEx?=
 =?utf-8?B?UGxDdHdnbkpqTXB5djBjcGxBK1FzVUNTUCtwQkN5a3B2RGc0eVF0cU92T0dE?=
 =?utf-8?B?ajFaVDhLWS9BUGltVldld3U2NDE2VjlzdHVlVEpXOXNBMmUvM0xQbDRCb2dN?=
 =?utf-8?B?d0lyVVpjRmVWQTd2S1VHQmRpelIwTHVjdkV1UXNQKzZ1ak8yOERhYzV0dnBw?=
 =?utf-8?B?dVBTZGpYaFcrLzdkSGoybXY0OHF0aG1xaExadzRUMFNyWjhieFc5YkZRTUtQ?=
 =?utf-8?B?VWpxQk5UblYwd0h5dDlGRmdFZTVTRTh4Nyt2Q3Z2VlVIUkc0T0I1Z0J0cko0?=
 =?utf-8?B?Z2IzOVBMVHJDSU9yL29oQThtRmtuNEp5Z0FJZHV0dHA2dmhMaklrT3QvZVJK?=
 =?utf-8?B?ZTNsRmU0ZUxxOHBma1J4cFU1eGtsYjBCMTdzRXRVUzNtVXN0RHhFY2w2Skk0?=
 =?utf-8?B?a3BXYmhHTWZROURyWG8wVTJBSU9aUkNxMHRLcHlTZUVKK0ZiWUdtTkpZNXlx?=
 =?utf-8?B?M0lWOHBINFEwU2Vaa2F2cFFBYmVGRDlicUlxbk0rSFRTU1NlMklJUmdudEVS?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93817db2-e105-43a1-76ee-08dd6188bf49
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 17:10:11.1930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9CAWYWqNNF2UU0QSiZVGyU7oVttitdHWNyI437ewjdDcoBvR0E2fOol69AQTEIokZ/n9kPyXMzmqY936KRSL7YD9hdep9pW74Mjrgnza8TM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6832
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Fri, 7 Mar 2025 11:17:11 +0100

> On Wed, Mar 05, 2025 at 05:21:21PM +0100, Alexander Lobakin wrote:
>> No idea what the current barrier position was meant for. At that point,
>> nothing is read from the descriptor, only the pointer to the actual one
>> is fetched.
>> The correct barrier usage here is after the generation check, so that
>> only the first qword is read if the descriptor is not yet ready and we
>> need to stop polling. Debatable on coherent DMA as the Rx descriptor
>> size is <= cacheline size, but anyway, the current barrier position
>> only makes the codegen worse.
> 
> Makes sense:
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> But you know the process... :P fixes should go to -net.

The thing's that it makes no difference for regular skb Rx, but with
ret != XDP_PASS it starts making issues. So yes, this is a fix, but
I don't think it should go separately.

> 
>>
>> Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
>>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)

Thanks,
Olek

