Return-Path: <bpf+bounces-45819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5889DB5DC
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 11:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06FBFB24E99
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 10:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649991925A2;
	Thu, 28 Nov 2024 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYuQNzdz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959EE1428E7;
	Thu, 28 Nov 2024 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732790507; cv=fail; b=HAs0nEsVf1eoAVX1V3borDRYcWL6Yy32/mvMQxoMJks0E7AJc9HMvGdswKy8AUmbDEuUE1ZByL8URJ1SkLXImyNviZ8+j/h5iuit5/JjW+nPT0K9o7Y/YvJouNBvV5pfmXyoOUseoms7y2NLc4Zr5P3+fsONBgYwRfdM9W52yl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732790507; c=relaxed/simple;
	bh=3hW6jJ5CrJvZLCVz4lpQ4n/2Pe5KUxyOedGONbfuCws=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tJtH/7FSBpGyL8YuZj9HFcLoPDKca3ONdYrazDRknxea8aFGjsopjxAKxxLs8vRsKi7ZbNy621acToOlHlQLY8PVfwQmV74fCy8bXQUEkEK6FppdWSKWpYG4SmifeH2aNaKV8QyA6/h3fKewo0H0EXGAOF9tSyYT/4Leqs/AXJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYuQNzdz; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732790506; x=1764326506;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3hW6jJ5CrJvZLCVz4lpQ4n/2Pe5KUxyOedGONbfuCws=;
  b=fYuQNzdzyx2OqLLk/DinMUJ7GYw614XUw605tG/Hr3stD+rs8XAWJ1HP
   FwB7Qg+ui5bTDt92MECIW5/n8BqL9KfwpCfEcKULFF3QzgMlO5ZuImNpx
   gr96N6/ZbD+xKCFx8tXwkd2FwWLzJUWH09NdrOiHeJG2DorEq/AT1N0Mq
   KZH4AwUViik31Y+3yf3gdUw5nPQFy3FqqsA0YV2l0+/l0NJ09qpL91HnP
   Vjsy5sjC43ndHPWPOcY9JM6LF5zeHK1LwCWOL7bkVS3hdaEQccgKRH9b6
   hXg+XaaZUChwTIihpk+1tNqWjbpgIkljkjcITVoDD4gSzj6LQ8yupn3Hy
   w==;
X-CSE-ConnectionGUID: ZmDMfXI5RBiL2X2/R7qdcg==
X-CSE-MsgGUID: uG4u0tJrSUqgf8qPI8JnWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="36684542"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="36684542"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 02:41:45 -0800
X-CSE-ConnectionGUID: jXVSUHQDRXK1dszB3EaOdA==
X-CSE-MsgGUID: U8kGreFDTKicRBXdMAqG1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="91812637"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2024 02:41:44 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Nov 2024 02:41:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 28 Nov 2024 02:41:44 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 28 Nov 2024 02:41:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daXjxjXcbpnQxaQbJ3BncmNT6RkG188Zl97y6pqMPJeeNsFzHgwPFbMwHYOBIBJcs1YINyQVWyTIGA92pfVRtpl9Cx/ZeeWIbh+MkkPri5BoHYf+eoULVn4rUEOUpnheExyCVIHb4FgeU6xECv79k/qwDXm5fZUM4sBrC7mI1gqy/L48/3EqJ4e/cMy/iE8IXiKk2vHdsKd6zS3JIEaKxVtjtJXdiKn3zReruaUOOMQt4WRwow026hPleAPF2ZAFEqKVKPvMQ4Gb1u3fOm6cv1v/Z+WFzThW7k4XOurC97HxJ/ktJ+VJxQby2NFHzml2Ov9O1WxHSlAw7uBbg0PtmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3ix8Kk0KZu0kafLOKDDrTf0HGw1pmIOmdVk0NXCRBU=;
 b=Fa939JNe4OQvOsrUs/XGmvI87Kyjqh/VPIPwefnGto5xhWXxxSUKqR77mE82IbNGjdA+Kp1RxcFPdF6RajUJYVeYyOWs8C570a2ETJg9ID4LBJXSlNPYceYx0IuysZwz1Foi3Ksj4KZDTvTry0v1LqfoRQOypV2pRVKtKvqTURQzmu/6pyGCdLd7w0vaNqcHZZGhqQ4eq3NSKkhvREOpN5kRjvI9t3kDfYQhRsgu/d5rTtf1tYgyG9ZdqZ9dFPyr0evWyysgFUKD6u/M0L7Tm0uiIOkp+BIG9W/Yc7K6Q941OaT7iI0Y0DEjia16ibTvWU+aOH4ZC+iia6l/UGfEhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB5945.namprd11.prod.outlook.com (2603:10b6:806:239::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Thu, 28 Nov
 2024 10:41:41 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.8182.019; Thu, 28 Nov 2024
 10:41:41 +0000
Message-ID: <8d485cfa-eee7-481f-bb73-d00a76d2ab1c@intel.com>
Date: Thu, 28 Nov 2024 11:41:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
To: Jesper Dangaard Brouer <hawk@kernel.org>, Lorenzo Bianconi
	<lorenzo.bianconi@redhat.com>
CC: Daniel Xu <dxu@dxuuu.xyz>, Jakub Kicinski <kuba@kernel.org>, "Lorenzo
 Bianconi" <lorenzo@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, "David
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
 <ZwZ7fr_STZStsnln@lore-desk> <c3e20036-2bb3-4bca-932c-33fd3801f138@intel.com>
 <c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
 <01dcfecc-ab8e-43b8-b20c-96cc476a826d@intel.com>
 <b319014e-519c-4c2d-8b6d-1632357e66cd@app.fastmail.com>
 <rntmnecd6w7ntnazqloxo44dub2snqf73zn2jqwuur6io2xdv7@4iqbg5odgmfq>
 <05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
 <a2ebba59-bf19-4bb9-9952-c2f63123b7cd@app.fastmail.com>
 <6db67537-6b7b-4700-9801-72b6640fc609@intel.com> <Z0X_Qv24e-A4Nxao@lore-desk>
 <3f6e4935-a04c-44fc-8048-7645ae40b921@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <3f6e4935-a04c-44fc-8048-7645ae40b921@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: f6124f92-4295-4334-de92-08dd0f993e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0lTb1cxVVc5VlVBZU8yNlFWeXZmT2M2dlZUSVZvbUczRjk4RFlrK0g4NVlS?=
 =?utf-8?B?dGovam5hTTRTeDFldy9lZi9sSFIzSEdybnNMckc4UTJDb3ZxcUloTmw4VDFv?=
 =?utf-8?B?YXowRWZTTXZTY2hYVjFDeEtpU04zeGtRYmlMRTJidHM0cDFsdlJReFMrT1c4?=
 =?utf-8?B?d2hCZlVza2hHb2xsMUx0RGJSbll5TWFSU0J5TEowQ04xaUNZYzhDWHhvMmtR?=
 =?utf-8?B?aTVCWHp6TFNMc1lkYmdveEt1bzR6MHgydDZ2NGhqZ3BPYkZ3c2lOdkk0d0lm?=
 =?utf-8?B?Z0pqN2xjbWNFbHFaRXQyNm5YWWJjRTN0Zm0rYUl1VTRLS3g3M1M1WmErN2dt?=
 =?utf-8?B?QVlETHNoY2pjd0ZlQ0dwbnpYeDhYUVNVaWVRQXlGd0xrTTZlaW52TlZ2Rzd0?=
 =?utf-8?B?bU5uSHliRWtPS1oyTzBPdE53L0RnSDRTckhjWElPNTQxd3NZeTlNM1BFYnZl?=
 =?utf-8?B?SGJLeFlHMElidVpVZ0pFbjNUTjNVNmxlbTd1U2NyNVUwWDVmcnorU3FkbTF0?=
 =?utf-8?B?V3JmVlhXeEFaWmljU2J0Q3BtV0E5QXFWSitib3U5TUphK3VpWUdUa1FBaERi?=
 =?utf-8?B?YU1qRUl3NGUwQWs1dEw2M2ZNc09VSCtMZHJ4VmMxRk1aU2F6MDFuVmhkQXY4?=
 =?utf-8?B?a3ExZTRxVmZ1aVdEUHJQOC81NU9GMS94cFhKNVB2bXhOZW9CY25EdkdSUGNO?=
 =?utf-8?B?cnRRNFUvNlJoMlZ2em4ramsranY0dGh1TU13dlRhaCtsYXZpSW5ta3dLb2lY?=
 =?utf-8?B?K0F4eG8vR0R4NnhGckhLRHZzUlN5S3l4Szg3aDV1djRKRnBUcEpIazBkVTdE?=
 =?utf-8?B?aEdtenpCVEVGcnpKc0lzYVJwUmp4ZDQvMkkzYmVaWW85TkxOWFg4bzVXcUNP?=
 =?utf-8?B?dVZ3Y29Mc1ZwalNPRnZmS2NUMGVESUNFaHhpMmtLeE1lMFVrM0ZudXN2RXMy?=
 =?utf-8?B?RjZndDZhK3JwWkoyUStqYVJCejgzR0tEcUJyUGdOSjE5dG05aXdMR2RhY2h5?=
 =?utf-8?B?V1Fkdk45Y3diRnhGVDlpZFp3UHdwcVJLZHN6Ulp6UFc2cHJvakk4aXBqNjlO?=
 =?utf-8?B?YnBKdGNuaHB4RnZ2ZlJqZEJXcFdyNERlWUFpL1ErcEs0ZFRocGFhRlZGMGJN?=
 =?utf-8?B?ZlcyUFk1SzdXSElEclBWN3I5d3RIM1lubXg0d3pTV0lZSEJNck1LTUM2R1JO?=
 =?utf-8?B?RTVPRGtHbWpYY0MwMG5ZOXpTY1FjajU4MDVjVnBpVDl6UDZrTFpLUlBKVWt3?=
 =?utf-8?B?ZFpzSXNQWXI2VmlVVG9GaHZiMFZ2c1kwWGQrYnIyVjRQQ1Y1UCtCM2pOYzho?=
 =?utf-8?B?aDlqNFJ5YXhvMGRUQTRBeTQwcHpJcU1PTWg4S2M2eUdoVEZMZVdkMXcyZFZl?=
 =?utf-8?B?V0xyZ09LTTdnd1E3RnpSOHk1RUhJNldQMEt2M283YnIvU2VSTlcrVldVY2JI?=
 =?utf-8?B?MmZSSE5WVzl4cGRUcHVwYytWQS94ckVSajd6ZTJGejVsTjQzdll0bTBwa1pk?=
 =?utf-8?B?OXh5Wkl4djNLVW5TcDVoc0l1L3htNlNCRmc2VHdWanB2VjQ4bVU1MUFjWVdX?=
 =?utf-8?B?cGRja2Z0VElWeXVOa0pMU21DdzhOYWtpTVZmWVZoblVDOGlMMnpRamwxblBR?=
 =?utf-8?B?T1ZwOU5EeFQrWVcrdkJFRTdaalQ0M2FZRHlmMS8vSmZhdCtBYUdkV25wTE5h?=
 =?utf-8?B?aG80N2ZPam13YUNXVjBCK1BTQ1k4VG5NWDM0RENGVlJ2d1dqbWJwTFh5cGNS?=
 =?utf-8?B?VmJUSUVDTTdZckJTaks4dlQxOGQ5dEx4ZWFDNEliUkhrZlFKdmxOb3YrakNP?=
 =?utf-8?B?QTh1dnRraXhMc0lpQWdMQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUxPMHdRZFh5K1drb0pKRDZ4Y2xIUjZ0RmgxM0VBdStIc2I2SGV5OUNsWTNx?=
 =?utf-8?B?Q2pGak9NczhtV3RCQVMrelJmZnhWSjIvUldTRkdDa2F5bURENHcvd0E3UzdC?=
 =?utf-8?B?ZkdLUjBpdHFkZzVrdlllSzBONUpFMzJhMzVobVA5NTBwalU4WitJM083SW5s?=
 =?utf-8?B?cXpIZ05HaWRlaWxuUU5GMDZQak90MEFleGFseWZxOGk3ZFhYMEUvQ1JFamdP?=
 =?utf-8?B?eFNqOWdqcDV4aUdVMWdXUndyOXJicXU3SklEUzlaNUpFbDRPR2g5ZnBmMmtV?=
 =?utf-8?B?b0FKTzJmOGRFZDg2bWNETHZYaEg0d1lFRUNjS05wYmZuZDhvWU15SGRQRTB0?=
 =?utf-8?B?K2FCYmwrTDN0NGppa0tmWjM2ejdjeFRZaVl3OWVndFE4WDFybUxBVzczNFE1?=
 =?utf-8?B?ajhqUEt1MVczYjFPWForRHdkeVRmVW1kYlRVdFptUHBjd0xTR0JlOWVPdlU4?=
 =?utf-8?B?WE1uRFovQ2ZmU0xGRXZPRGJvVWk2d3BJd0JvMGNEUVc3OHdPb0I0QTRDS200?=
 =?utf-8?B?eXNmdUVkdWs4NkRTSlNMUWFOaWozSm1DQWljMWMzWEY5TlRrQ2U1dGVQcEhZ?=
 =?utf-8?B?N29QZVppNEM0ZDE5cGFUVnlsWmtPYUp4SU95bDJWNFNKNGhaZkZNcmdhcDh0?=
 =?utf-8?B?SXZqSEpDZ0duZzVOOWpKS2lBWVpKSTBOUlNBSjI4WldHL0lleGNVSnpxY1VJ?=
 =?utf-8?B?Rk1pdHBUS24zRUZYNTZoRjNGek5OdXJ3MzJUZHNmTDN5SGJNT0tLZTR3US9p?=
 =?utf-8?B?akg1eGFSZ2RGNTJTL2t4S09wTi9SalU0cURBL29JQnpaTHRNZ3hPTUx5bTBI?=
 =?utf-8?B?RUxVZS9KNm5JWlVCcVNVbjMxS1hlQUJ0TUZsZGhBSWR3ZnhUb2JyTkFtbEEw?=
 =?utf-8?B?TXBoQnR1azY2ZnF2MlZPVlZGeTFJenVPelRYeG5PUldRU3ZNN21teHpZc21o?=
 =?utf-8?B?eFBoUUNWZm5UOHI1aTFuV1hQV0dHdGE0dnI2SkRqazBWc0dndXk3T2JvMGpT?=
 =?utf-8?B?UXpON1F6bWplNEg2cnhVZTRNUU5Yb3gyTllDczB0Ylk2RUFNOUJBSENIbjM2?=
 =?utf-8?B?ajFUa0c0RDgvUHdFdTJOWXA4L0xNVUx1dlNXRXpDSFdRZVQrY1M1SGpZZUJx?=
 =?utf-8?B?WXFFR2dMN0pWUy90R1NDWHJsMWJyYkN5VUdqckNmWldWblN0QWRoTGVxd3Jw?=
 =?utf-8?B?Yy9qOHFTdENWZFcvMmNVYkZLbG5JelMzTkczUjBSU1IrRHZ2SDFUbFRZM1JV?=
 =?utf-8?B?Lzlvcy9ZSExRVkJtZW41VUJ1eHNyRmcrRzMyY0lRc2hmaHJ3Y25JalFXNlky?=
 =?utf-8?B?RXhGZEV2eTJvbWJvN25BcG1hYXphTjhCVERwY0hKcmVwMG8wQUNORE9JaUQ4?=
 =?utf-8?B?RWdCVW5EcU5ZUzNtQXpPWTVQWjk0Z2YweERJL2xUeWR3Mzh2bHRxUjZxUVlB?=
 =?utf-8?B?N0FiOEdRSXQzc2RoUlRweDB0YUxoa3ZXN3gxYTJaMnlVWGQxVU5lbFNSYm5j?=
 =?utf-8?B?Mld3ZFY5OWlnbjV4MnBTZSt4blN1SUovK0wvR3NlK2NBV21sVEQyQXVnUFhM?=
 =?utf-8?B?RHVKNVFZM3hpekUvWmQyZFd5TXIrQ2JsQ21xWG4xd3QxZWdMSTNTV2RkOEQ1?=
 =?utf-8?B?U2VZUFdHYnljMVBqaTVLemordnhKcU9rdVlSNzY2NEpxSWIvTWYvNEVpQ0VJ?=
 =?utf-8?B?MG1PNk8vNzBDaUQySWdiWUgxUzd6K2VLWGU1UEVjUmt3RHZRZ29sQ2h3NVd4?=
 =?utf-8?B?MkNjaXlCcUJNNmVud3o2RnM0STliMi84ejc3QmNpa2JKSlBLWlB5bFljYzNp?=
 =?utf-8?B?a0ZrSEd3OHc1K3JLblhkL3lmK3VWeThxZ3FDUEVScXJ0ZnRLNTJsNGUwTThT?=
 =?utf-8?B?WjhZOEhqNGthdTZ1Mzd3NHBxWVF6TGpVVDJpcHJJeHl6V0lqNzlweFllOXRF?=
 =?utf-8?B?SWw4WXhVMkhIa3lVc0tSOVZqNGREVkNQWVMrOFVSckZzeXJMY1lqQ3ZkaHNk?=
 =?utf-8?B?WEMrN28xQ0ppdWkvMVFyM05GMHpsTnlMM3pZZVRmanFiUE44WFVEV2paMCtw?=
 =?utf-8?B?WGhwcGtianc5RmRXanN2UnUrWVBESENzREE1amR3SjJWT2IxeE04Ni9FZENk?=
 =?utf-8?B?a0oyUjVOTC82dWI4cnc2akl0VHZnOEp1OWFCaithSTBiTnFkdGgzck9hdmxy?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6124f92-4295-4334-de92-08dd0f993e59
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 10:41:40.9518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43Zgbixf5WUGLX4wfiSJyWxfSJY7PHNq1Sum4IuKLaoq1SXIwQNldYWoHwEVdi7F7e9Vkp9v02GdgGfH4nvYftQemf72B597ivVxsf11MCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5945
X-OriginatorOrg: intel.com

From: Jesper Dangaard Brouer <hawk@kernel.org>
Date: Tue, 26 Nov 2024 18:12:27 +0100

> 
> 
> 
> On 26/11/2024 18.02, Lorenzo Bianconi wrote:
>>> From: Daniel Xu <dxu@dxuuu.xyz>
>>> Date: Mon, 25 Nov 2024 16:56:49 -0600
>>>
>>>>
>>>>
>>>> On Mon, Nov 25, 2024, at 9:12 AM, Alexander Lobakin wrote:
>>>>> From: Daniel Xu <dxu@dxuuu.xyz>
>>>>> Date: Fri, 22 Nov 2024 17:10:06 -0700
>>>>>
>>>>>> Hi Olek,
>>>>>>
>>>>>> Here are the results.
>>>>>>
>>>>>> On Wed, Nov 13, 2024 at 03:39:13PM GMT, Daniel Xu wrote:
>>>>>>>
>>>>>>>
>>>>>>> On Tue, Nov 12, 2024, at 9:43 AM, Alexander Lobakin wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>> Baseline (again)
>>>>>>
>>>>>>     Transactions    Latency P50 (s)    Latency P90 (s)    Latency
>>>>>> P99 (s)            Throughput (Mbit/s)
>>>>>> Run 1    3169917            0.00007295    0.00007871   
>>>>>> 0.00009343        Run 1    21749.43
>>>>>> Run 2    3228290            0.00007103    0.00007679   
>>>>>> 0.00009215        Run 2    21897.17
>>>>>> Run 3    3226746            0.00007231    0.00007871   
>>>>>> 0.00009087        Run 3    21906.82
>>>>>> Run 4    3191258            0.00007231    0.00007743   
>>>>>> 0.00009087        Run 4    21155.15
>>>>>> Run 5    3235653            0.00007231    0.00007743   
>>>>>> 0.00008703        Run 5    21397.06
>>>>>> Average    3210372.8    0.000072182    0.000077814   
>>>>>> 0.00009087        Average    21621.126
>>>>>>
>>>>>> cpumap v2 Olek
>>>>>>
>>>>>>     Transactions    Latency P50 (s)    Latency P90 (s)    Latency
>>>>>> P99 (s)            Throughput (Mbit/s)
>>>>>> Run 1    3253651            0.00007167    0.00007807   
>>>>>> 0.00009343        Run 1    13497.57
>>>>>> Run 2    3221492            0.00007231    0.00007743   
>>>>>> 0.00009087        Run 2    12115.53
>>>>>> Run 3    3296453            0.00007039    0.00007807   
>>>>>> 0.00009087        Run 3    12323.38
>>>>>> Run 4    3254460            0.00007167    0.00007807   
>>>>>> 0.00009087        Run 4    12901.88
>>>>>> Run 5    3173327            0.00007295    0.00007871   
>>>>>> 0.00009215        Run 5    12593.22
>>>>>> Average    3239876.6    0.000071798    0.00007807   
>>>>>> 0.000091638        Average    12686.316
>>>>>> Delta    0.92%            -0.53%            0.33%           
>>>>>> 0.85%                    -41.32%
>>>>>>
>>>>>>
>>>>>> It's very interesting that we see -40% tput w/ the patches. I went
>>>>>> back
>>>>>
>>>>> Oh no, I messed up something =\
>>>>>
>>>>> Could you please also test not the whole series, but patches 1-3
>>>>> (up to
>>>>> "bpf:cpumap: switch to GRO...") and 1-4 (up to "bpf: cpumap: reuse skb
>>>>> array...")? Would be great to see whether this implementation works
>>>>> worse right from the start or I just broke something later on.
>>>>
>>>> Patches 1-3 reproduces the -40% tput numbers.
>>>
>>> Ok, thanks! Seems like using the hybrid approach (GRO, but on top of
>>> cpumap's kthreads instead of NAPI) really performs worse than switching
>>> cpumap to NAPI.
>>>
>>>>
>>>> With patches 1-4 the numbers get slightly worse (~1gbps lower) but
>>>> it was noisy.
>>>
>>> Interesting, I was sure patch 4 optimizes stuff... Maybe I'll give up
>>> on it.
>>>
>>>>
>>>> tcp_rr results were unaffected.
>>>
>>> @ Jakub,
>>>
>>> Looks like I can't just use GRO without Lorenzo's conversion to NAPI, at
>>> least for now =\ I took a look on the backlog NAPI and it could be used,
>>> although we'd need a pointer in the backlog to the corresponding cpumap
>>> + also some synchronization point to make sure backlog NAPI won't access
>>> already destroyed cpumap.
>>>
>>> Maybe Lorenzo could take a look...
>>
>> it seems to me the only difference would be we will use the shared
>> backlog_napi
>> kthreads instead of having a dedicated kthread for each cpumap entry
>> but we still
>> need the napi poll logic. I can look into it if you prefer the shared
>> kthread
>> approach.
> 
> I don't like a shared kthread approach. For my use-case I want to give
> the "remote" CPU-map kthreads higher scheduling priority. (As it will be
> running a 2nd XDP BPF DDoS program protecting against overload by
> dropping packets).

Oh, that is also valid.
Let's see what Jakub replies, for now I'm leaning towards posting
approach from this RFC with my bulk allocation from the NAPI cache.

> 
> Thus, I'm not a fan of using the shared backlog_napi.  As I don't want
> to give backlog NAPI high priority, in my use-case.
> 
>> @Jakub: what do you think?
> 
> 
> --Jesper

Thanks,
Olek

