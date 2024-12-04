Return-Path: <bpf+bounces-46083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46FA9E4306
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 19:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA19B60643
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 16:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AFE20CCFC;
	Wed,  4 Dec 2024 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zfyo4wz+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967B34A28;
	Wed,  4 Dec 2024 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330606; cv=fail; b=skfs6nfA1K5bp6en71XNOQOkSd1ZGhf+Ifwsgf7h95T/qNe0G7W8nBxSJ4vWYSIwT+dNAUYE4RGPipPa5hl1qnlKYNbWXQESKng5rwwc3RJXPvWylbyBFl1M9lfDFydjXmACbvV3GwypSN1vaFMZldxQPj2vLHXvOUh+Nk03uGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330606; c=relaxed/simple;
	bh=UTjsial2QuQHOzqs88YojedkzF/TS7kJ2xoYZ+xPcIg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=umabmxPGxQlQsGOfzXhKlpppRrLQaKDh2qL469OSW2NkEb8Ksl8sDVy+Z7fRhN2X0+Ek/WLpKlmnbKu2kmmAOBMJDp0DIGM3QoTvDQdM/MYPu3bECK6gpkQt9REsceOm2q+DxpoUZRx+GVwbEwSmwSSj413cfd5MAz5lCrbJIj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zfyo4wz+; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733330603; x=1764866603;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UTjsial2QuQHOzqs88YojedkzF/TS7kJ2xoYZ+xPcIg=;
  b=Zfyo4wz+BtsNfOHaW4N3Yu5+i4T98aocEW7w6I4GbrsDacn+Lk0eZw9i
   Wu7Bf+LEWU4obk3ee65bTWFNEBZHo3UOsqNCSzSSSuaVHEDzwq00y/749
   +yBgEsokdB4e3I/yIgwA+I/c8eeWnEesvw5wcuD3HK9/QoqygcEzWnQ20
   T730KJyGRXuy1vzmSmSeSRbK7bji5j9rhswaTA2QkwNl0tGz+/1GKqm62
   M0ZibteXM/FbwYdXq9wlRCXXqHRmoP3EuKWDU+6h5092r9cvsofmoKu+I
   ji1ZB5fsrYa9nCXy14qYnWzKs1hd5cT5rztVpveBfarC25hcnPdcogIYD
   w==;
X-CSE-ConnectionGUID: htZ4M1bCTYudnC0sYsKpuw==
X-CSE-MsgGUID: Kf4N1+HvT96qLpqcwFYlfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="44086536"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44086536"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 08:43:23 -0800
X-CSE-ConnectionGUID: 531JMmUBQzixVrLpqYeG1g==
X-CSE-MsgGUID: InYqHhhiQzydNvmkFm3OPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93707655"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2024 08:43:23 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 08:43:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Dec 2024 08:43:22 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 08:43:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doWX6edwjeXkD6W1NhjXRknK2Q4Rb19BfgTktrj0gjWmYVRkrPhdo4ahi6JLXPdnh6stuqsfONZ6+bjD3D31t/4FZYaI659izEUCoTdESduM6e0tXzT4ymYIYVvBARWYoCiJAdyrxYt6/Sj+vTnBDEFM3V2yqYM+f1tiX4saYCG8B/baoj4QOZaBvFrJqzzyivaeETNgpqxoIXcxadTBvqcCrk58jyVSaSQQTX8O6Fdh1XadfxHnx+baZlMXBy2s41MSVLMSqohKW+Ny7Q9KekJIMXyX9zsDDxh1xCU5ytfzbjCNT3f3yyRHd2q0+XGxYuqlFQ3vF+NmJ4xAj8brQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDO3PQ/5Vw4xoPnM3fNvoEN/Df8oNyflrh+XonrpEYQ=;
 b=PnG3AIQEeU5IrAOSbkcEPubHYxhOXm58tEPLOAVfMfOEz6PdR33TqZsYBXC6NKmBXOX0fsCouKrl9ZacxZcoYN2Iaq8B8DHBokwkt34cARVH/E8+qF6BdAlVY7FdbyJ3qZO9cQ2pplpOdZUhVQIr0+iwKL8+mxjB3BrMaW8wG7FX6BwgUN+v13Xw5rZWvRBpRbUE9zZ29v8bU8dkc/lx0s/lwzSybwAHHiHsmv2F8eOmmtaBzrHMkDK16xKtRt6hrcJ+0p2wPSH4pXU8csyfNalRY6DklXYYgteHhZK/UiIkj1y5qzkdl59xhegGj4cFGmAyyePt8NiddMaxSDq2eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB8237.namprd11.prod.outlook.com (2603:10b6:610:154::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 16:43:15 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 16:43:14 +0000
Message-ID: <a0f4d9d8-86da-41f1-848d-32e53c092b34@intel.com>
Date: Wed, 4 Dec 2024 17:42:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
To: Jakub Kicinski <kuba@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>
CC: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Lorenzo Bianconi
	<lorenzo@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, David Miller <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
References: <cover.1726480607.git.lorenzo@kernel.org>
 <amx5t3imrrh56m7vtsmlhdzlggtv2mlhywk6266syjmijpgs2o@s2z7dollcf7l>
 <ZwZe6Bg5ZrXLkDGW@lore-desk> <55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
 <ZwZ7fr_STZStsnln@lore-desk> <c3e20036-2bb3-4bca-932c-33fd3801f138@intel.com>
 <c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
 <01dcfecc-ab8e-43b8-b20c-96cc476a826d@intel.com>
 <b319014e-519c-4c2d-8b6d-1632357e66cd@app.fastmail.com>
 <rntmnecd6w7ntnazqloxo44dub2snqf73zn2jqwuur6io2xdv7@4iqbg5odgmfq>
 <05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
 <a2ebba59-bf19-4bb9-9952-c2f63123b7cd@app.fastmail.com>
 <6db67537-6b7b-4700-9801-72b6640fc609@intel.com>
 <20241202144739.7314172d@kernel.org>
 <4f49d319-bd12-4e81-9516-afd1f1a1d345@intel.com>
 <20241203165157.19a85915@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241203165157.19a85915@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0025.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::6) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: c79adf07-b522-4923-7e94-08dd1482bf1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTE5Q0dEU1p6dnM2ZVVFNkRpM0RZaFg3d2YrdHI4RXVxYnhPYWFGMWJLY1hJ?=
 =?utf-8?B?SUVDbE1lTzZLQWVTdTVac1RIUmN5RUJpNDRpa3ZEY2tQQlg4YVllZEJ3bDZr?=
 =?utf-8?B?T0YvR0ZLM0c3U25UN2FlaEs5TlZ0NGo3RzJtTmlxcVl4TEVWRzZ6am9HTk1t?=
 =?utf-8?B?ZVFjOHEvYWxxbEplNG1Pb1BjOU9FWlRRNEJ5NElUbG9VeFNhNG91U2FhdkhW?=
 =?utf-8?B?bm5qZjdObFl0d3NPdW55ZWx6ekZXNFJLWTg5RG9kVmxBaVpaK0tQQVc0KzJm?=
 =?utf-8?B?Uks3eFMyV2lDakVBR1ljZlp6Mm5TY3dXMEs3MENEMXhvTC9GRDhGYVdndkph?=
 =?utf-8?B?R2VzMTZlc3VFU3VKc1dUSFhyNWQ5UmpTMWFIMFVNeE81aFFjMjdmeUlnMFNI?=
 =?utf-8?B?NDJPQzRocjlOQkJMS1crMEhzOUgwQnNzWUZEOS9Yb1o0TTB3R253RVZkVGdG?=
 =?utf-8?B?TllNVjJNVXBjTnNydE9pem9zalZNV1pEUGZtc0hIVjlNSkFMcUI5bUZ0UE1D?=
 =?utf-8?B?L0NGR05TcEhCWW81VWNhd2szcU1iMFVXVTNRZm1UaFdoOHNMTjBtTGNGTVRM?=
 =?utf-8?B?MUtLMWh2QXl6MmtXVFVXTCszZy9SWGFBdkozdVNBRjhad2l6Z3hEd0lnU0hP?=
 =?utf-8?B?ODc5U0pBWnRhSVBIQ0FNN1BGaVhDSFhrUjZ4MW5QNm5wdkYrb2tQMTVYODZO?=
 =?utf-8?B?SmRRZnJNbUU2aVBZWmhWWTUvSzQzczJFUm0xcDdnNXlFMWZpWW1QVlUyTVBv?=
 =?utf-8?B?c3BrV0YwNFVmRzFWME1KcVlPNGQ2VFQ0WkRXRDJrZzhoZk1kRG0ycE84em9z?=
 =?utf-8?B?ZzFSazlHODN1dWMrbmEzdkhOSjFoYmtYMFVNeWlFQ1RjdllZQ3kyZHhHejJR?=
 =?utf-8?B?R1dKeCtuS3dKdzdJQjE5N3lKRExDVUNPQ1U5VS9CLzd5RDV5Nlk1MEgyMHND?=
 =?utf-8?B?dVNDU1ozNDNjb2JLRXpHZ2VvekIxY2NuZXZVaW02MWhmOGF2SytITlhKckE4?=
 =?utf-8?B?bk0rQ3FmQS9ZZFhDbDhBTmlDZG5vQUpXaytuR3lpbUJ2aFlvQjNiUnZRa29j?=
 =?utf-8?B?VzZiTnRPZTlCVzkxZUJlYmFWNjloajNxM1BkUVpmZ2RBRWVwUVF3NU95MXlz?=
 =?utf-8?B?TDJHMkNuMEM5NDFrUnF0N3FuQkxuNXpYY0dqUkM5dEtwSmZ4ZGF5VlVWOU9s?=
 =?utf-8?B?V1ZCZzhqQjhGSzhKWFZUcU5nbVFDV3FrdWRmWm9iUmJ5OFhET2pBYUMvQnVT?=
 =?utf-8?B?aS9CblNDSjZudEcxWWlSZkJhdU9LbkZGaEpicHUvSEd3VHBISUxvaW9SQzZn?=
 =?utf-8?B?aGVkVVg5bmNyZ0hOSFFEVjk5SHd0WWNEOEE0ejRtZEdWMHFoYXVUTWxsSlZU?=
 =?utf-8?B?YmtrRS9rVWtmYUZrTmN6aTM1K3l6L2ZjQXVVcEIzWndsMkVob1hWYzJqck83?=
 =?utf-8?B?a29tUlpadEwyck9yY2lTY2Q1UUQrZFcwRS9McWZlVTcwRUhIV25qMEZTcGpU?=
 =?utf-8?B?MDcybkdrMTdVaE1hZGc0c0hMYlpRYlY3T1NFeTZ0eSsvakRHQncyZEg5a1VE?=
 =?utf-8?B?cE4zRmRJdFdhS3ZzRzgxUFhVOGpNZlpqa1cvbWFiTitFaFFmbGhiTXN2N1ZT?=
 =?utf-8?B?azYzbElBUXZPU2dvQlhDZDRzc0RVckpHQng1ZVBEdGF0dWpiU2U0VlhSQ0l2?=
 =?utf-8?B?MDZMZ2haNldmL1JNcStTSXVVQ3lWSFhLOGY0TzJCUHpGQ3ZTbEZYV2VYZkpY?=
 =?utf-8?B?L0swS3FGQWRVSHZ5MG5ERk4xMEdQTTZXdDUyeGNUaHlVM2tmdzZVRWVoUGhZ?=
 =?utf-8?B?R0F4TzZQSkNzajUyMGN4Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0xuaWZ1cEFKcVIybFlqUDhDOW9yUThLclNHK1czN3hwTWZwQzFkM2lsWnhj?=
 =?utf-8?B?Y2QyUCthY3MxTkdtc2JJNXpHYmxVQm5raGNpVG4xSnFEWFNUTy9PTmpwNEF3?=
 =?utf-8?B?Qmg4OHBvb21IWVFZaUFqd1hKWGRzUDZ2VHpaZXJBOElsRWlBOXFQUk9BbkFz?=
 =?utf-8?B?bTQ5NkpVSzM2eEFYcFRIT3dCSjBuVUZhc1JaS1E0Vy9DN1VvMktWbmNvQmIr?=
 =?utf-8?B?RExCTGRmQUk3d2RId0tvMmcweUxDdzNwMUV0dGFnckk5c05pQTVBWUxpVWVk?=
 =?utf-8?B?R1dlTXdYWVQvMVJSL2xoUmRhZlU2Q29yNk5HbUkwWEVlTXZjUGNJV3hCNjAw?=
 =?utf-8?B?Y0hacFN4OWdYUk16UWJIR0pXcDJ3SHBEREt2a00zelVEaUxYbnhnY3pneE9H?=
 =?utf-8?B?OTVlaUpZMW9WQXNrRVFWYmd2alpOTUZwaU8xUS9CSlQrNmM4Ymt5V0NyQVd0?=
 =?utf-8?B?bXVzNUFNMG52YldJUlAyMUY2UkJKVENxTEFKRm42VGNweUZsc1A3UlZDQ3RR?=
 =?utf-8?B?QTN1U3QrRTZsOFRka0lxUE9Uc1VGdXJMVUpGTzZYQVRFNHVJWHorYnVIYUpV?=
 =?utf-8?B?NzFFaVlYbG9DdlRmRGk2ZFk2VG5KRzZUeVArSmhkYkF5S1hlcFFvbmxwdmdB?=
 =?utf-8?B?REg2SVplSjI1VTZhNmFkSkVON004amZzbHFWLzlzU1pBS1JzYm9nKy9OM3dn?=
 =?utf-8?B?Z0VhVm1TS3BxSXpUS3lENEk2d3Y2NVRpaWVZb2hZa2JiYjRkYnpVSm5yeE5i?=
 =?utf-8?B?Njkzbml6NFhxcWpCRXhFMVhZNzlsenh3VTN4WTllTUNHM2FVU1N2ZHJwcHpT?=
 =?utf-8?B?NGVia1BwQTMrV05zWUFWTVVwQllzcFk5dnd6cFpBa2NCMjB4NHcxVkk4Qm1i?=
 =?utf-8?B?UUxtUE10WTVRdlZsRmtPUmFwUEUvd091YzZlcFBGT3RBRzNlaDVlSnRHVExn?=
 =?utf-8?B?NGpMdXZqdkVab0E4a0FmeGZWOTVTdzVSelBuRG1FdTNTcThYOTNHK0xubnBh?=
 =?utf-8?B?aWVTdlhGK0dRV1lEVnF6TE1yTzg4V2FVcUFMaDFINDd0T0tKUFFzSk9JMEZV?=
 =?utf-8?B?MVpDcWZ4eGNtSGFzTUlpZVZFbGV1dXZLTU9lRkNzUis5ZmNZZUNYU0xpMzVS?=
 =?utf-8?B?TmVqT3NRYm9CWEgzZ2x1VVdIMTRjWGdNUDVlTmU3OVdLNmUxWlRkS2pyaTFJ?=
 =?utf-8?B?aFpadVhxcGo2aGljaXp1cm1xM29hWDRhZlVURDd3eEpPS1ZHeFJQNXE1ZmVa?=
 =?utf-8?B?eHRjS05mdCtCZFRBVm1SN3ROVG5LdjV4ZFJxWjNPOE5odEdKSEZLU3FPTDNa?=
 =?utf-8?B?cDUzd3hjTmlhNHpvU2dnTG1qVlBHYjAxYTREWHV6Y3dUTitKVllZVU9TL3JM?=
 =?utf-8?B?RUJ4eFhEdXRpNzBMNU9uajZ6SjVzYlZvdWR5Qi9FaWl1ajY5Q3I0UExpVUh0?=
 =?utf-8?B?TnpYOEorUEJHd1NET0FmSkhtUHVKK1NhaFVNc2lOUDlucDk0NU02ZmVNa2Nm?=
 =?utf-8?B?VXNuMjVidXdCMlhDNzEvNmMyZWRMQndMWUU0T2kyK21Xc0R6d1ZJeHhuZDEw?=
 =?utf-8?B?OE85d01mbVV3ODNRSHA5TFpSZksvWlU3L1ZFNW1mUkxtVUc0Wkw5aVRXbHJo?=
 =?utf-8?B?SzhHcGY4UEZtRk5sZmQ4VTR6SjF4bTJRRGUzbGFlOU1CUWpnSnM5cWJWc0JT?=
 =?utf-8?B?Sk8za3RNdVN3RnkwYlFBeE1UTFdTUldDWE5oQlowaElmT3BFQ0h3alFRK3hi?=
 =?utf-8?B?czVHVHo1TnBVNkNnbTVtT2YrRGh6VXl4VHA0TVk3OHNZK05iZTJ1b3J6UXZ5?=
 =?utf-8?B?cHQvb2IvNnplcFlVRTQ1eWNKOENtUE0vQVNKTmdVSU1oNnEzaXFlTVduT04r?=
 =?utf-8?B?N3hZZmpSTHRoRnNoRFJWa2RJOERiNjNiWmFJNlhTSmhLRHFTeGQrRU9jWkV6?=
 =?utf-8?B?N2tUSGtEK0RISGk4SFJ6S1VHT0JxUEU4VjZTVGNrWE03QVRyL0xFc0dqUEhz?=
 =?utf-8?B?dm1YaDYrOGdHZnY3WStGSE1VK3ZORDJ6ZzJTM1J5VHJDSWNVZDFDemhKZ3F2?=
 =?utf-8?B?Y3VxemRiNVphS2NhS3hlQ1gyNzEvUXV3OFd3dTUxbEpYNjZLMEMrMDcrbU1w?=
 =?utf-8?B?UDZwZVNtNTVQelhBYVBSR0FuVHRFMXpHVEdLMi90WElIS0haNUw2enZXVHU3?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c79adf07-b522-4923-7e94-08dd1482bf1c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 16:43:14.4405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfK8P3owStpWNPS1o2j5aO0BUZxrEPhLZFztpF/qrT/FMNmM9VCltkXFr8uLne9uHZoflC1hW0aOIDm7m6RootUKfhOsFRbSfsT3LOOJXtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8237
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 3 Dec 2024 16:51:57 -0800

> On Tue, 3 Dec 2024 12:01:16 +0100 Alexander Lobakin wrote:
>>>> @ Jakub,  
>>>
>>> Context? What doesn't work and why?  
>>
>> My tests show the same perf as on Lorenzo's series, but I test with UDP
>> trafficgen. Daniel tests TCP and the results are much worse than with
>> Lorenzo's implementation.
>> I suspect this is related to that how NAPI performs flushes / decides
>> whether to repoll again or exit vs how kthread does that (even though I
>> also try to flush only every 64 frames or when the ring is empty). Or
>> maybe to that part of the kthread happens in process context outside any
>> softirq, while when using NAPI, the whole loop is inside RX softirq.
>>
>> Jesper said that he'd like to see cpumap still using own kthread, so
>> that its priority can be boosted separately from the backlog. That's why
>> we asked you whether it would be fine to have cpumap as threaded NAPI in
>> regards to all this :D
> 
> Certainly not without a clear understanding what the problem with 
> a kthread is.

Yes, sure thing.

Bad thing's that I can't reproduce Daniel's problem >_< Previously, I
was testing with the UDP trafficgen and got up to 80% improvement over
the baseline. Now I tested TCP and got up to 70% improvement, no
regressions whatsoever =\

I don't know where this regression on Daniel's setup comes from. Is it
multi-thread or single-thread test? What app do you use: iperf, netperf,
neper, Microsoft's app (forgot the name)? Do you have multiple NUMA
nodes on your system, are you sure you didn't cross the node when
redirecting with the GRO patches / no other NUMA mismatches happened?
Some other random stuff like RSS hash key, which affects flow steering?

Thanks,
Olek

