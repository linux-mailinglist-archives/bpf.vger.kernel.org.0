Return-Path: <bpf+bounces-44659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F8A9C5F55
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 18:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C03E2822B7
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 17:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E6B2139B6;
	Tue, 12 Nov 2024 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZf3arxF"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24632123CD;
	Tue, 12 Nov 2024 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731433416; cv=fail; b=BLbOwUvM6XEjzK419KM/E6YorxhmW7qVSHf8c0lmgeW+czBFK5Las8WvvZ0kan59Wy5BlpO2oBLcFCv7xRzsWuxGhGruVCaPRz4Oqzehzx/rOn4WIYHfnYs94+zW1o+NfzYpK+tXtfzkKbkDaS5+fZi6H9yCDoo+BApEEVKw6jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731433416; c=relaxed/simple;
	bh=oTB1/bhaAj7YTUZg3+z9TPb2V19Xy0OmoDpA6XscSZs=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=um1bMUcp+dT1KBL3gqRq+OPn+ZEalWfpqCM9Kb1IITFpi9zCPjh6hQLb1RGZkn5SmtxOHABfqkVIoNzg7aKCTzFOmNIs6mUvEne25tb15jJvh+Uk4na0+9n8XB09FsQkhQRGU0Iv0uLDPEjHs9d/ZR3Y8WZvgThExYDeyIBUuWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZf3arxF; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731433415; x=1762969415;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oTB1/bhaAj7YTUZg3+z9TPb2V19Xy0OmoDpA6XscSZs=;
  b=ZZf3arxF7mPtj4A3KJNRlSdO8rhn+OBx6CYwcdvG0X58ziQupFqDkH/1
   5o9Gv7xxDisEh1BSyQntTmgDsv7CKrtxYL8MLutHJcNmQ2ZK3OhbBsdp0
   +ArZuG3+b10Is+4oWThSz8YNnFYJHQLAayqCoe/CrdsDR7gmle25nH83p
   hYg4Hkt10pioa+oJw6YZE57rOWfQlbXzgjB7qfmORV6trSxXOHIDn4Vmw
   8WAECYef/srbj3Sc9MdaZxVzRNqNjm1sZxB+81VFpt7+3j59Sc10FXgCn
   x17Mgo7wISqQXayb2Iw4PlxolTg6gmLASvb5FyKXD01kfSBvX7mhHIm2F
   w==;
X-CSE-ConnectionGUID: iEAdXMymRsSAzaVKd8ZxVA==
X-CSE-MsgGUID: XfrWFaFTSKWCOblc7yJzWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34990327"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34990327"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 09:43:34 -0800
X-CSE-ConnectionGUID: UB1IirQJQfG1IihraYEJcQ==
X-CSE-MsgGUID: zv6RuR37TwiVkLvpSTIs2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="92527521"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 09:43:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 09:43:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 09:43:32 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 09:43:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyqNBgJ/oDzlNQ9R+SpgH5PyVtthOChluNeV4uTpB7S43iQUP61fHpvWq5/tpYZ/vH18oGHxcV4uOK+qnJb+DD7ylr/3TwYY3IjFmWcLtVmaC0rGzy6iYXZanphiOO501shnVPDQhPlX08YfUius4/cTs8g2/YPLZMagwFjzhyl5f+FmewAHjKyaocP9pyEbcRfba6Gp/rdKXRRfvJPcWeybtcnIoi/Hvl7oedwUb3ZfxLKI6wGLIqorRI0tAZSz/N+a+UNImDjnfhOlx3uOkCDLPmxAmoV/tQPvSto4tJq2UIBwRHHkqB8v+ho7lvXSyEhRePmYWPmkjk6oWQPEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGg8FMkgrNHgNtrFmpCkA5BoAyMimIeTxwc1WWSD+Gg=;
 b=KqOBKb42sDDWsObMKDd9XH79UxV4xdFvGuHD4s2zSY2hS0qLvPcOOuL0MtGyvuWzyvRmM82MV2SB/s2VOt9tyIRclDQzmvbmKAsNLAD646gcFTE2wkV2O4kJrsyaeZL920MB5SkBpY4ATczWSpHcarcrb/zSh5ysdXbxDd9FM771ll6s7+YpPLp7JAfGwna5mpT45GYN4cXIACGmluSRPC576FDIaRCTzhQQkygLvU4IU2fiMxka19YRCW/laYvMvPDaudT3bxQZc0vMD6uZnmnIo0YUZTdNoBCt6ZcoOF1ObbZmtegm8tMJ9b5l34RNxLTbgHGK2LJsa7g2EMw8Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB6873.namprd11.prod.outlook.com (2603:10b6:806:2a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 17:43:28 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 17:43:28 +0000
Message-ID: <01dcfecc-ab8e-43b8-b20c-96cc476a826d@intel.com>
Date: Tue, 12 Nov 2024 18:43:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Daniel Xu <dxu@dxuuu.xyz>
CC: Lorenzo Bianconi <lorenzo@kernel.org>, <bpf@vger.kernel.org>,
	<kuba@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <john.fastabend@gmail.com>, <hawk@kernel.org>,
	<martin.lau@linux.dev>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <lorenzo.bianconi@redhat.com>
References: <cover.1726480607.git.lorenzo@kernel.org>
 <amx5t3imrrh56m7vtsmlhdzlggtv2mlhywk6266syjmijpgs2o@s2z7dollcf7l>
 <ZwZe6Bg5ZrXLkDGW@lore-desk> <55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
 <ZwZ7fr_STZStsnln@lore-desk> <c3e20036-2bb3-4bca-932c-33fd3801f138@intel.com>
 <c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
Content-Language: en-US
In-Reply-To: <c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR06CA0032.eurprd06.prod.outlook.com (2603:10a6:8:1::45)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 70dbb082-b1e5-49c6-b1e9-08dd0341843f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N21MMXhxV1lnOXBXWmt1UnRtUVVjWGNHZ3lVVnVuQ1lOQWFaNGVlNjVoOXBL?=
 =?utf-8?B?T1h2aGxTVzE2SDljRXA3RXU5em00STl0cmxDek1EVVF2b3h0NkJYR3ZheTRu?=
 =?utf-8?B?OXFuUUNSVk9zZlg2bWVndUMxMFQwRVFIdzhtR1VQRUIxL1JGc3FvZ2lONExR?=
 =?utf-8?B?Q3BSblB6L2pqUnBZaUtWNzN0amUyY2lPdTZYTUszdFl5dXZYaFhlajJPdllK?=
 =?utf-8?B?Q2pqNmZUaHQwZERJNk9iS2c2M3JJaDJ2RHlEaVdPcXp1VmFlMmZ1cDVrMUtl?=
 =?utf-8?B?b1pYc3dDWFo3VENod3lHeHZXc2g4dTYxY1FaUHVWQWFmSHJUUWMvNXFyQXBq?=
 =?utf-8?B?R1F3dm4zNGtuSjMzSWFGRHpwc2JobW03MFNGZzIrZi8wTW81cUtlOXlxeG5p?=
 =?utf-8?B?eHhaYXY5TDBkMVR2UGpnTkFRSnpScjE0M1dpQ0JtMHpTS04rZWZUZjRnRnZC?=
 =?utf-8?B?R1NteEE5c3pGTWt4TGdBK2Vyejh0Mjc5T3VGVU5OSElZYnBjUkZRZU9oUENE?=
 =?utf-8?B?QVpXOWpSd3NyV1BRSFU5N1h1MkZKNzlNYlJnK3dOV1d0YWFlQVFUNmx0RE1s?=
 =?utf-8?B?b0xXZnRCRVY2cFZ4T25HVzFhYWQ2U2FMVGlwTnpjYnh5UWE4VFpheWc4SFRh?=
 =?utf-8?B?bVlJTlZJVXNCS1djRHdLazZyRi9ET2NiY2hVclBzQ2RSZW5aRmNNLzJtVXlR?=
 =?utf-8?B?WW8xQ1RWWmUvb2toQm8rWENGODdOL2FaS1FrKzJPOHRRQjNWY0Q1SGhWUG1y?=
 =?utf-8?B?N3A1QXA4SmtONHNBa3JmamlwZ0xCTUpsRFJTb0ErbHdoWnpLWWVOdnV1ZEZR?=
 =?utf-8?B?K2RTYUo3QjUwN3FUREt5bzZzTkduNWdlTjEyNXpwdmJNQ3J3eUVXdm00S09G?=
 =?utf-8?B?bUgrWE5SUGRtSTErelVFR29waHFuR2c1QVNRU2U4YlNtcU96VXdaZTNMN09F?=
 =?utf-8?B?OUV3emdqK3ZXdXpObDAxRDd6SFd5ZjhBNzVRemNzbGpmRmc3czMwVWtUTEVs?=
 =?utf-8?B?YXhnSngxdVVaTWE5ZzlISEhqY3N5L1hXRmd2YkdlZWRYd0VpZzg1T1QrK2lF?=
 =?utf-8?B?Z0NBUVI5c2V1NjNTVndVZWZlRGJFcGZ3eWd1ZS8wcFVoSUllRzVqVS9MVnJC?=
 =?utf-8?B?alFXRC9IMXM5c2NDOGZPOHN5MDd3RnRVTnVNd2JlVU43TFMvNTZsbkxhRVJs?=
 =?utf-8?B?MDlwaVpaSEZxdUM4YTlXcmxWd3hIVGpTWUMvYUdQUkhvaXNpcGxET3FiZFhS?=
 =?utf-8?B?T25xVXpHMGM3eWEzamcydU5qcjJiQjNBWEZYakFmM3JtL3g0OWlQMUZzamdr?=
 =?utf-8?B?QjFwcUhSOEhuRlpsOGFCNEZBS3V6SzlWL3pFT0dXQ0ZPamN4VDJRMTJycGpz?=
 =?utf-8?B?RytsSmR2TDY4SW5TbzUzKzNwYUJTclRqWGlXU2RGNlZ0MWRmUG80NmhpOTRX?=
 =?utf-8?B?YzR6SWF3KzJMY01rVXVpTDJ6T0dyZUV5bFo0czVtTWdUdFpka0kvV2p4d3NW?=
 =?utf-8?B?aS9TUEFydkRKbDBlUFZxRXQxY2o0SnUyYVlINFFCRmg1cFFRa1VtWFpHMkxB?=
 =?utf-8?B?dzZJc0RZbUZ2ZklpL0k0dS9rZ1hZMTdtVDJCRGVhK3IrbVdPMUdnak9YYzZ4?=
 =?utf-8?B?VkUxeTcvOHJtNURSUjc5cTdkMWpOYW1INHJ1TG1XWE1uTEhqTEpabUZKRjNF?=
 =?utf-8?B?eEU2U0hVSVhrZWtLNFVFamVJY1lVWFplbEtVVVA4Z3JqcVBXK0NmMTNHR3N6?=
 =?utf-8?Q?uPu/tGBiOpYy6SqPRwIDgQTNSrsES/5DlKxEcjY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE5DdFFpYXNzcUpUY2ZZRmNvNElXSGpsNUJTaVpxTVU5YmQ1RUlmZnhxZ1FU?=
 =?utf-8?B?STRuNWdyUGtQVDVwRjhWb0tLWUl4d1pHZmM3Y0FJRU5GS1BIR3pDWE1qNFpS?=
 =?utf-8?B?bnB4TEV5eDc3bnN6bjNDSTQ0U1lUaHB1eTg4bGFxY0V3eVhqSG96RGdnOHJG?=
 =?utf-8?B?Z2VBOGZDenIzRDk0dksyb1l5eWxtMnU4RS9KVEk1RVRvYWhkWCtrM1Q2Z3Zj?=
 =?utf-8?B?bXBJWXJUTGV2UUo1TERZUGNGejliaSs5bCtnZ3VCZDdkQzRlZndYZEtLUmRL?=
 =?utf-8?B?VFhmOVhyd0ZxOXZQb01qTG1oRC85RmxzUkpwOWUyUkV6cS9OUkxLcWY3bk9z?=
 =?utf-8?B?T0xhSzJBY1pFTG9PRGg3cU9Ob3FrVldGc3ZzOXZjOWNES3ROM0Z2WTlEREdX?=
 =?utf-8?B?Q2ZsSE12Y1pWT09CeVg5ZmtCQjRnR3ZrbGdJOUp0WFFMSXNSWEcwVUFVbWc2?=
 =?utf-8?B?WmpEdithZk5Nb0dwZ1VwQ3BqZVlMMTk5STRxM0wySExpWUNyMUIyRHYydXlU?=
 =?utf-8?B?NTlOQ01naGRzbUczb1hvZ3hvbllqSkVtUjlXci9vOGdnWkZoL0NOZDkxb1JK?=
 =?utf-8?B?NTk2NFFRSncxRHZZejhVSFkrbm1UNHozZEpGWllLSFhrVkczYWk5Y0hwUEg3?=
 =?utf-8?B?bW0rR0RvWkNZTU9TVFVDU1dXZXR6Zm8zdms0Y0FUalRKR040eTl6eDY3SVRm?=
 =?utf-8?B?RnYzMVd1ME40SGdia0IyNXRjOEF2RlZpdFJ1T0RPVTFCQ041ZTRSRUEyQ01w?=
 =?utf-8?B?WVJFdHN3MHU1Ky9BZDZKOW1sb0ZONHpUZFhWb1ZsdHc2Qloyb0YzOXJNa3pl?=
 =?utf-8?B?MXJLdmFwMXVhdVJmbVZjRzRBbElZNFIya05hT2RuWDliVlhaZHRJcm1qNUlT?=
 =?utf-8?B?VGRYNVptWStYRDlPalZZUHl4ekJXREUzZTBEWWZNZlNleTZabUZoVFlacHNT?=
 =?utf-8?B?NmJkdVo2Yk90QURMK2ZBS0xWNlpnR0svSWZMOUpSWDdjUXJwM3k1SEVaemx5?=
 =?utf-8?B?R280S1JzNzNMTVJhQm41T01qd1l2aVAremNxZHNYdTJIc0NsYml0NVh0QjNX?=
 =?utf-8?B?MEZXUUY5ek81NnBNblBwUGV4Vm9RR1FycHhqOFdmWFpqN3BEK2dRZ1ZCaXNO?=
 =?utf-8?B?ODBVbERrc1RSZGd4KzR3NXlzRXJMVUVGd0dHVklsV1BjQjhvWFV0MmhHVG4r?=
 =?utf-8?B?VU1Sa3N1UWhzZVpVY2tyVlVaRWdXaE1nSFIvaEVxWjhhVGszMlk1MWJVK1hx?=
 =?utf-8?B?czM0ZjhzN3k4WWRKZlVESURvVEc3b2VhbXNGc0tHUWQzNzA3eVB3RUdYZG80?=
 =?utf-8?B?aW9ieW5oMy91TUd1UnFDMWgwSmYyN0FkanBCZlhlY1RZZS9taWpsQVphNnNM?=
 =?utf-8?B?bGc1d0VTV3Zpa3RqTnpERnhSZ290TnhLdFNCNlB5SURjWjZqNUZjKzVYaHdn?=
 =?utf-8?B?S21XWEdMay9XK1hibkdDUjFuMUdjZG04VEFmOFFHN015T3JWRjlmNHBLRmw4?=
 =?utf-8?B?MXBYbUNLMEo1Sk1EOUM5d0Q1VUpISC9HclZxT0dtVnJTaU96SU5XSThHOEww?=
 =?utf-8?B?Y0lTMCs5MklqMmJqSlVNNlJ6Q3BGaXh0c0VteU9DZUthaWpwUGtaNnZ0Smsx?=
 =?utf-8?B?LzNuUDNiNFo4SXlMTXVQRmJDQkVYWjdjc0VJYU9YUWxEUnBNekRoeENuTDJT?=
 =?utf-8?B?NDVhajk2VDJtSnl0c25qbGVZTjJSU0FNbTR5QTE0emdqeXZSRE52aW1JTkt2?=
 =?utf-8?B?SjB4bk5CQy9uQ0Z1OXFpK0lrcndtT1VKMC9vQWhDRFlsVXhpUFMyMXhVUGNq?=
 =?utf-8?B?bDJURE1MTy9KcElOZWwyVGVOZWxsaEJmTTBTUGpvOHYwODQ3MVlmcURPTVpp?=
 =?utf-8?B?emJOazJ3czZ3ZTI5bWRxemVRVVRlNzJzSlFLUXR5YVBoTTdkV0wySEV3UlVE?=
 =?utf-8?B?T2JxZmIvaFNFcmF3MFR1a2ZhQXpQdjJqYnBxNTNqT3FCaXpzVlAwYlBuZTJF?=
 =?utf-8?B?bXg3V0d5c1dNMXNEa0dBSEVkTHpXUGFMWk1hMlVsalJFTnpyR09jMTV2U3Z5?=
 =?utf-8?B?Z1hUSjA4L2U2VmlvR2RMbGlkRnpKb0NlcEhITWRNc0g4Vi9qR1hYQ0Y0ejFL?=
 =?utf-8?B?NTczU09ibXdNdTUxZlo2eWk2VzVMQUltWUJyV2VMWTNJaTZ3cjVkL2VpajFk?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70dbb082-b1e5-49c6-b1e9-08dd0341843f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 17:43:28.6582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5OD7C9Nrt+AqdmXoEluN0Cx3SePQBbVIlyxBGceatkz12GP7orrPYTxNwHvzTD4jSQR7iEIasOqdA1MFYgYHDGaK1Jzb3aUziW6dNhtTxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6873
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Tue, 22 Oct 2024 17:51:43 +0200

> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> Date: Wed, 9 Oct 2024 14:50:42 +0200
> 
>> From: Lorenzo Bianconi <lorenzo@kernel.org>
>> Date: Wed, 9 Oct 2024 14:47:58 +0200
>>
>>>> From: Lorenzo Bianconi <lorenzo@kernel.org>
>>>> Date: Wed, 9 Oct 2024 12:46:00 +0200
>>>>
>>>>>> Hi Lorenzo,
>>>>>>
>>>>>> On Mon, Sep 16, 2024 at 12:13:42PM GMT, Lorenzo Bianconi wrote:
>>>>>>> Add GRO support to cpumap codebase moving the cpu_map_entry kthread to a
>>>>>>> NAPI-kthread pinned on the selected cpu.
>>>>>>>
>>>>>>> Changes in rfc v2:
>>>>>>> - get rid of dummy netdev dependency
>>>>>>>
>>>>>>> Lorenzo Bianconi (3):
>>>>>>>   net: Add napi_init_for_gro routine
>>>>>>>   net: add napi_threaded_poll to netdevice.h
>>>>>>>   bpf: cpumap: Add gro support
>>>>>>>
>>>>>>>  include/linux/netdevice.h |   3 +
>>>>>>>  kernel/bpf/cpumap.c       | 123 ++++++++++++++++----------------------
>>>>>>>  net/core/dev.c            |  27 ++++++---
>>>>>>>  3 files changed, 73 insertions(+), 80 deletions(-)
>>>>>>>
>>>>>>> -- 
>>>>>>> 2.46.0
>>>>>>>
>>>>>>
>>>>>> Sorry about the long delay - finally caught up to everything after
>>>>>> conferences.
>>>>>>
>>>>>> I re-ran my synthetic tests (including baseline). v2 is somehow showing
>>>>>> 2x bigger gains than v1 (~30% vs ~14%) for tcp_stream. Again, the only
>>>>>> variable I changed is kernel version - steering prog is active for both.
>>>>>>
>>>>>>
>>>>>> Baseline (again)							
>>>>>>
>>>>>> ./tcp_rr -c -H $TASK_IP -p 50,90,99 -T4 -F8 -l30			        ./tcp_stream -c -H $TASK_IP -T8 -F16 -l30
>>>>>> 							
>>>>>> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
>>>>>> Run 1	2560252	        0.00009087	0.00010495	0.00011647		Run 1	15479.31
>>>>>> Run 2	2665517	        0.00008575	0.00010239	0.00013311		Run 2	15162.48
>>>>>> Run 3	2755939	        0.00008191	0.00010367	0.00012287		Run 3	14709.04
>>>>>> Run 4	2595680	        0.00008575	0.00011263	0.00012671		Run 4	15373.06
>>>>>> Run 5	2841865	        0.00007999	0.00009471	0.00012799		Run 5	15234.91
>>>>>> Average	2683850.6	0.000084854	0.00010367	0.00012543		Average	15191.76
>>>>>> 							
>>>>>> cpumap NAPI patches v2							
>>>>>> 							
>>>>>> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
>>>>>> Run 1	2577838	        0.00008575	0.00012031	0.00013695		Run 1	19914.56
>>>>>> Run 2	2729237	        0.00007551	0.00013311	0.00017663		Run 2	20140.92
>>>>>> Run 3	2689442	        0.00008319	0.00010495	0.00013311		Run 3	19887.48
>>>>>> Run 4	2862366	        0.00008127	0.00009471	0.00010623		Run 4	19374.49
>>>>>> Run 5	2700538	        0.00008319	0.00010367	0.00012799		Run 5	19784.49
>>>>>> Average	2711884.2	0.000081782	0.00011135	0.000136182		Average	19820.388
>>>>>> Delta	1.04%	        -3.62%	        7.41%	        8.57%			        30.47%
>>>>>>
>>>>>> Thanks,
>>>>>> Daniel
>>>>>
>>>>> Hi Daniel,
>>>>>
>>>>> cool, thx for testing it.
>>>>>
>>>>> @Olek: how do we want to proceed on it? Are you still working on it or do you want me
>>>>> to send a regular patch for it?
>>>>
>>>> Hi,
>>>>
>>>> I had a small vacation, sorry. I'm starting working on it again today.
>>>
>>> ack, no worries. Are you going to rebase the other patches on top of it
>>> or are you going to try a different approach?
>>
>> I'll try the approach without NAPI as Kuba asks and let Daniel test it,
>> then we'll see.
> 
> For now, I have the same results without NAPI as with your series, so
> I'll push it soon and let Daniel test.
> 
> (I simply decoupled GRO and NAPI and used the former in cpumap, but the
>  kthread logic didn't change)
> 
>>
>> BTW I'm curious how he got this boost on v2, from what I see you didn't
>> change the implementation that much?

Hi Daniel,

Sorry for the delay. Please test [0].

[0] https://github.com/alobakin/linux/commits/cpumap-old

Thanks,
Olek

