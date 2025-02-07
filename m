Return-Path: <bpf+bounces-50759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A621A2C21A
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 13:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1DE3AA06E
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 12:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1A31DF260;
	Fri,  7 Feb 2025 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jf4BsAqt"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22D21DFE18;
	Fri,  7 Feb 2025 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929605; cv=fail; b=gz87hjKaZOlwhMFoKlIQymXOpisaZxp9A4Qtkq7D2yWhBvh9v0OEQ02oTp5rlJgABWkz1SsicjqBUCx6WZg1r7IjyEquTktMR0XGtI+PkHVVBDZ25fGbESg7tx4YZ/zrSsdSb0vpRAq28UWOlrAJZvWc6ilEGkj48P3gEdL4Z2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929605; c=relaxed/simple;
	bh=SJt9SEXlmmXgIHT7JSH2bxS20Q8+IIHgOzMWUxJ+QLc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o90efxjwnibU76gJwtvoJCvO75tJLbVzG1moxpffQysshKfXZmkCi4TFZQFkZkqABqBj7jt4STA3ZKqigWrDrc6SBPqajmaCMprmHA7Tt5uU4xY/rZmkfIrRBYr6NJrD491AzwodPftBtWusMuP7wv57u9sbxVFGP9tOPpyI2ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jf4BsAqt; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738929603; x=1770465603;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SJt9SEXlmmXgIHT7JSH2bxS20Q8+IIHgOzMWUxJ+QLc=;
  b=Jf4BsAqtimjUdZ52H8665suC/R13vcrM03mOMi7h7VWfewxmk3M2lSNJ
   DnUEV0xP+CNUsAiVubiu34lMVlfRy3OFvKL8pixZUjgmXmYdQptvyA13j
   hqkngWWZ1ZW5DL3dWtB02gN49hPTPxMytbzB0bxndrBDr3TOsWyK6S+pn
   3PHMryHS+XCv2ACWmBfSzO7Th8eqQmy9nY/byPFz5M+NuUYEFVijnmBzs
   8P4NYVQbppNsS/mLE6OaTgd78UDA/Iqq/YOcsVDtLCkqT/txjuUhQS1ee
   h3Aij9kisOqLV5Z0vk8IB0zDIDdLfDBClqxEMKXUXOsz/PGYOoxykK3Dp
   A==;
X-CSE-ConnectionGUID: gLb/lH13Q5G4VFiL8U3sqg==
X-CSE-MsgGUID: DYjY5bItRqKm6H3BJ+dpMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51001119"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51001119"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 04:00:01 -0800
X-CSE-ConnectionGUID: ZT+bkmVtTDqNOoR/uuxyWw==
X-CSE-MsgGUID: +aBYA+iaQU6cgA62vf5okw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116120817"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 04:00:00 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 03:59:59 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 03:59:59 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 03:59:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eebkaRiWA7Lmedrg3JJeoK6hzUBpwTk9S53DfQYYlrR+qYBAUA5mRX8zV2vBwP4SdrzJeeAOHxlaI5aHuDNBcTMJMEIKcPP90LbEu9lH9BzIhHtyqW3TWUp2YSv5+6zYBfWRqtMLeOI452ATvynoL5BRrrG+JB1NqEzBSiS6J6OhwhyWcdBTd7OUqoysx25BcYaMEWFF57mAW2DRKc3Dk1JsOVTN4REplG0pw9PSOj621cC/yI8HgMiYC0IAk3oSKDNYHSY5U0xBGLNc9F3Si/q7pDhk4T0DBZZ04OFKFaXNTOuILM88ABW+NE+/x23cWNWZpCRxPpcDDJePZbewrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJqCdpdFcP9GefZ2JVjXY4Hz2ScJVOpqkn13DSowhCM=;
 b=wfvuexyPWtU5/y6TViMLGFiVQaZwJE9h4Llww8HGos/b5vt7+ZBEefJ3L6hyCG0b2FPFGPm495WJG1kAHD4neOIH9+9X+1eY7SOqhKX8cJQQ0g17J2dPRD9lZQrqbDxJ6G14haNidfe1xQf6OjvYm0l8oKg361CVm7aq4Xb4TRGNBooSHwwYcu8WM0GhN3dnlx2Hw6hdGkyLkuajHfG4jAR1i6JENifle0puieTiczPvdXyH7XR1jx7tRphTICKex0tTBtNGk/zAsFSo5fgcbMWDSyEUjH4SaPEhA9WmdXK5gIN9GGU/SS0eDEHYAc/qUy6xRBbkEGHjcRua2nQreQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB7490.namprd11.prod.outlook.com (2603:10b6:806:346::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 11:59:57 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%6]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 11:59:57 +0000
Message-ID: <3decafb9-34fe-4fb7-9203-259b813f810c@intel.com>
Date: Fri, 7 Feb 2025 12:56:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/8] net: gro: decouple GRO from the NAPI
 layer
To: Eric Dumazet <edumazet@google.com>, Kees Cook <kees@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu
	<dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@redhat.com>
References: <20250205163609.3208829-1-aleksander.lobakin@intel.com>
 <20250205163609.3208829-2-aleksander.lobakin@intel.com>
 <CANn89iJjCOThDqwsK4v2O8LfcwAB55YohNZ8T2sR40uM2ZoX5w@mail.gmail.com>
 <fe1b0def-89d1-4db3-bf98-7d6c61ff5361@intel.com>
 <CANn89iJr1R4BGK2Qd+OEgsE7kEPi7X8tgyxjHnYoU7VOU_wgfA@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CANn89iJr1R4BGK2Qd+OEgsE7kEPi7X8tgyxjHnYoU7VOU_wgfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZP191CA0044.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::25) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e5593da-7f0e-486d-d110-08dd476ef100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akdPei8rMlR4dUVSZGNaUW4vZUhoRlJMbU53RU13bWNuZFVaTUpVeVBUVXdH?=
 =?utf-8?B?YkxwQVl2bHBtZ2RmNmF0eVJncG1mRFcwTm1XNEJaaU0weDlGTUlIam54czBT?=
 =?utf-8?B?VWFTTnV2enpqdHJRaUhQWGhGVlNkRHlUZzRlMTVQVEdJalgyWmpJaE9QQ3l5?=
 =?utf-8?B?eHBrRkNuZDFHVm9PTzdMbStHOVROaVdXSmFCb3RFV3pjMjZNYWRoNUdua2oy?=
 =?utf-8?B?OG95MTJRTVgzSGZqS0ZSaEhTdjZMMEExSWo3QTZheS9aNXoxdkFwNC94NzlE?=
 =?utf-8?B?SXA5cS9MYjI4MkFqOEpvZzZNVTRJT0pMWSsxWC9WbG5kZHVqaEkvdm0yclBH?=
 =?utf-8?B?OElOQ3krK25URlZBQUlHVGJZN0VmV1c2ZVFZK3QxUjNhbmlaOUZxK21rRzB4?=
 =?utf-8?B?Z3J4YVRXMjVmazdPUzFnZE9aV3pYM1VrZnl5TGVnMTZqeHhRN0pZSWdwVTRF?=
 =?utf-8?B?SXFUM1RuN2gxbHBDM2JPeXhyaEdsNEg1SlRIS3NHdjUwb3JvdXVZSllicDdH?=
 =?utf-8?B?M3p1T2c0eDliMVdmbTFXbzZQS0VRMk84T29ybEFMMGFKV01pMTZSMDA3cDNU?=
 =?utf-8?B?aVQwaHFtWVRWV3NINFhrUUZQMEZOdndxc3V5N2ZUZDFkQkZCUzdtQmlLZ0JL?=
 =?utf-8?B?OEhWMzN1YTAvMlpocDBaN1ZXOWpPWngzbVNqUGZVd2pvN2g4Tm9iQmhPSlFi?=
 =?utf-8?B?Z2tOQ01lOXhkN3E1MkJabFlRR0YvRFdSZEl1Ym5RZ3ViOWpjWEhjV2tmNmN5?=
 =?utf-8?B?QVJpSnZJdE84Q3F2bXlRQW56N2pvb0lrZmcyV1pWdkI4UXRxTDk0V3UvK0ZC?=
 =?utf-8?B?MHhJcTIzTVU5Q0lvVStnQ01uekhxWXJJMENzejY0ZW12NGF3NHQxTXRJeUlI?=
 =?utf-8?B?ZEcxUVRWMmNuWG5ZQTZzdEpxRHdBNDZFVGxoRWU2OVRLbzdDai92R1p0QVRs?=
 =?utf-8?B?ejBrdmdTV01UQTlteVdrTUdJcTZmdDYzRnN5Z3ovTkZTR0JnUXJObUx6UVdO?=
 =?utf-8?B?bkE2VlVHSmk0d0gyZURSKzRjMGhuKzBnSjRuZDhKMEpobFFUSDZ3QWdUaFpv?=
 =?utf-8?B?QmIxWW9zR2oyNHcyd1VyVHI3cjhTbmwrMS80RUVMSWdSWVA0cXJmUk4wSStV?=
 =?utf-8?B?aThlWWh0NGV0Z21nczZlSUFDSWplUTMyM2xTNjlEL3FjSnNkWlJuamJORzNE?=
 =?utf-8?B?Y3BsS0crb2ZUT3huRkpOaG5vTVVPcVpLYWIwTU1TQWVKU01xK0JXVC85NFNU?=
 =?utf-8?B?dGFVckI4UXI0clkvaXIrYXpVRTRjQVZOQ2NySURMd0FnV2FueFZCYmRZeEhl?=
 =?utf-8?B?TzJnYkgyL005MTNpc0NHbDVRL1cvZWpUb1EvdlFueWdUcndaM25mMWc0V3BU?=
 =?utf-8?B?UG1xdVNLcFdvZE5PM2xIY1BIWi9pWTROUjI1WjZOM25TRk1rVU4wZWJsd0lY?=
 =?utf-8?B?VS9mYmVTakNPZDROenhwTEdqRXlNdWhaTXhwNVdOWUUvQlpqMXBXSUpwR2U3?=
 =?utf-8?B?MkpOWkh0T00rYnhranJBNnMzNEVQdHZsTXFSMjJ5SDRUdEw2ZlA2Mk54NXdu?=
 =?utf-8?B?Wnh4MzZFM0JnL1Qxby84N3pKb1doNkpySTlJTkJkS2tTUS9vRkRzNDk4Um1i?=
 =?utf-8?B?TGJQUDMzTUNRb2s3M3B5cndjVzNGR1NqNGRndTc2OHdPdmNyRUVLWGlvQnBk?=
 =?utf-8?B?L1NRdzdES3lyaGdkd04zTHlVcFdOei9iNXJXWllud0lac0FGM09IRFc1dmNI?=
 =?utf-8?B?L01oZFByVERvM1dmUEZ2OWZ4M2NEWEFYckVvQ2t5TzhHcWZNYnQ2ODVucU9X?=
 =?utf-8?B?dExldlhacXJIUThTbWhqNFBRMkdwUzluWU12d044SnVFbkpvZkJVZDhkRlp5?=
 =?utf-8?Q?DDZ9oEdsJCUX/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUdOVDNHejN5WUo4MjQwUjIyK0p5L2JGaGJXK1p4RFJNQjlSdlFyRmtlMmhI?=
 =?utf-8?B?QzFBYWh2SDJWb2QxVzg5RzlXWFZSN0dxdGEvYUxveVFLMkQwY2o4TEZRRElK?=
 =?utf-8?B?U3FPbVh0UFppUFhOMVl5OEIwenAxYk9JUlErY3l0aDlvdENCL212OXVDT0tE?=
 =?utf-8?B?T2lqaUlhVmh0WkxUOWI0cG13Q0o0bmlxUXRtSENDNnczUU8xZGpPTzhrMS91?=
 =?utf-8?B?TDNkZHhoYWpwRFJ6ay9zcEVqQ1Z1RzM4WTYzY0xFVkRjOU1ZT2U4dGlSeWdo?=
 =?utf-8?B?RkxYTXluRG9aK0o0aW02czBGVnl3d1ZNUjhGelJ4UDZBQmUwdmovaHNMeWd6?=
 =?utf-8?B?bFJRVit5TDk3QUN6N1lid0NEUWJkT1pVekZtblVKT01NVzVKWEh4WVloSzdZ?=
 =?utf-8?B?am9BejRGVE1aeEp2SHFMV2Ezb2NGSHpIUzZpZG9SWkJqTW51aWlSMms4cUhZ?=
 =?utf-8?B?UU8wbU5HMlYwNHVJK01LNzdKQnd1MkVPWkNoeHBuNGx5OW5KS1J6SjlrVTlM?=
 =?utf-8?B?d3VNcGRIWThlQUplNUhuTmZMb0VOZllOYThiMU1BZWk3d3JzSlYzZVAxSUxI?=
 =?utf-8?B?S0pEczFERm83b1Q5TEYrUm9qdFMra0l3ak5nQ3RVdzFMWUI3VTdjMnhFMm9G?=
 =?utf-8?B?TXlqOWZKZklLV05YOUdvVk9hSmw3Wm5DdHRFZWpGY3VreDRlK2VWV1NyS1dF?=
 =?utf-8?B?Z3VQcXBYWFNKa3QyRkl0aFV1V0svSHlvNHVQR2FvaXkxV3VNVlJueVp3cDFp?=
 =?utf-8?B?T3V4UjJsTks3SDNhaW5mN3J5VmtmaU1lV1FONnV1dFU1UFN0UzZuTDAvdzhT?=
 =?utf-8?B?alRNTmZKQlV3ZEs5Ujd5dE1xYVZOakxwdGxUZCtvWVYvaVhZZUJHb3dOTHVv?=
 =?utf-8?B?VW5PQ21qSm1vMEYvMW16eERoRUZNVVlhdnpQTWVNbkpGSU9HVjRRcFFvUnY3?=
 =?utf-8?B?UExNd0FhOUhwdTdyaGFham1LSGl5cUJHdFVvUUdOYlo5ZUoyNzVZQitWbzN3?=
 =?utf-8?B?ZXg5d3dnUENlTDk0Q2RwbklRNFh1UFlJa3ArVnduZGMwTlFDc1A4RmlGN2Z5?=
 =?utf-8?B?eUJmK1JCYk1QUWUxWWxKeU9OdDlQRXRaYnJBalFseXR5N0R0aFJUN2xXcVVJ?=
 =?utf-8?B?ZmVNTVBXWXNzdkpkbVRacnE3MWNCNXNaVWNNaXh2L1pmM2JkSnhqTVRYbW9Q?=
 =?utf-8?B?Z2NxQ0JvdHFEU09laU8vYUZ0MmF0ck5mZ29aMzJ1QWR6YlRCbS91Tjc4SHZk?=
 =?utf-8?B?cWZYUVRXQ2ZtaUpvdXFtS3BxdVQxaFkxb2dWUHZtSjBFRTJrSUFGeGlQZkxj?=
 =?utf-8?B?S2xUanhrdzM5T0IxMDhZRlNROGE5eG1TaVFzTGhRTTFrL0NyTTFPT1BldGpl?=
 =?utf-8?B?QjZKQTBuajRWVkNFNzJiUStLbmZzSEd5Q0VyODl3Q09SdUpscnFFVlVIUEls?=
 =?utf-8?B?MzNVZXNPRjlHM1hnNHI3STNXNDlDY0E2N3IxelM3VzFoNmlVK3JLelB2NE5B?=
 =?utf-8?B?RS9ieTF4VG8vdFE1T01xRnBhU25xUHY4YllPZW01TExITDdHdDFNbG1tMHpM?=
 =?utf-8?B?K0V1T1hkTytTZHFiNWowSkRZYmtPblFqUTZGUTZNdUxEMEtVWjIxci9KVG53?=
 =?utf-8?B?NTZ3L0xNdjhjeDZUcE5VQk5Idlg5cVphSWthN2dPR0E0N2Z3SnZRZ3FIYUtU?=
 =?utf-8?B?dS91V2U5Ym1QM3lYRVQ0LzJqUVovZjRNRXEwVlYyOHNuL0ZwNDVtMW5EcWZy?=
 =?utf-8?B?bnpiYXBBaFBKU2FDWStLY2I4dUExSUhHa3kwNFlFeDlkRXpDNE9zdXE0VlpP?=
 =?utf-8?B?SC83MWZHMWRCRVJEMVFkNXNyK3Y3VXdBL0YwUStLQmR5aldUeXN2cENicndS?=
 =?utf-8?B?ZGkzNUJ1N0loUmR4NzMwZUNmV0t1bFBrOEtZUE1RWVR3S2VuNnlHTXN0c09i?=
 =?utf-8?B?Zk15eGZpYk8xZE1nUDNRWkh6am4rQUNtS2VDVHg5WnJWaURCUDNMdWt0aFdu?=
 =?utf-8?B?TmlIb0RmbUdoMVVMcW4xaEs1Z2dLc2QxYm1HUnM1ems5VUk4dlR1SDY2MGZp?=
 =?utf-8?B?MDJXdE5SdFBLOStGaHBLaFY1SEcyUm9UYmlaQTh1MzRZTmRIakxsM082NmxX?=
 =?utf-8?B?ZGM4WFhnQlJjdXNJbG43NEYxWWZESDNmUW9UeTEzaXVnck9taUw1T0NOc0Mr?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5593da-7f0e-486d-d110-08dd476ef100
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 11:59:57.4161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cM3ZwpB4EdKCKI8JXJ2BGCFGf101XQjUbKaePcac8GwzqSN7X2WZb53pafULg/nmohHDL4g1r6Lgr4XWh1Ue163+LS6Ebz7G1LlyB5yfROM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7490
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Feb 2025 19:35:50 +0100

> On Thu, Feb 6, 2025 at 1:15 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Eric Dumazet <edumazet@google.com>
>> Date: Wed, 5 Feb 2025 18:48:50 +0100
>>
>>> On Wed, Feb 5, 2025 at 5:46 PM Alexander Lobakin
>>> <aleksander.lobakin@intel.com> wrote:
>>>>
>>>> In fact, these two are not tied closely to each other. The only
>>>> requirements to GRO are to use it in the BH context and have some
>>>> sane limits on the packet batches, e.g. NAPI has a limit of its
>>>> budget (64/8/etc.).
>>>> Move purely GRO fields into a new tagged group, &gro_node. Embed it
>>>> into &napi_struct and adjust all the references. napi_id doesn't
>>>> really belong to GRO, but:
>>>>
>>>> 1. struct gro_node has a 4-byte padding at the end anyway. If you
>>>>    leave napi_id outside, struct napi_struct takes additional 8 bytes
>>>>    (u32 napi_id + another 4-byte padding).
>>>> 2. gro_receive_skb() uses it to mark skbs. We don't want to split it
>>>>    into two functions or add an `if`, as this would be less efficient,
>>>>    but we need it to be NAPI-independent. The current approach doesn't
>>>>    change anything for NAPI-backed GROs; for standalone ones (which
>>>>    are less important currently), the embedded napi_id will be just
>>>>    zero => no-op.
>>>>
>>>> Three Ethernet drivers use napi_gro_flush() not really meant to be
>>>> exported, so move it to <net/gro.h> and add that include there.
>>>> napi_gro_receive() is used in more than 100 drivers, keep it
>>>> in <linux/netdevice.h>.
>>>> This does not make GRO ready to use outside of the NAPI context
>>>> yet.
>>>>
>>>> Tested-by: Daniel Xu <dxu@dxuuu.xyz>
>>>> Acked-by: Jakub Kicinski <kuba@kernel.org>
>>>> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>> ---
>>>>  include/linux/netdevice.h                  | 26 +++++---
>>>>  include/net/busy_poll.h                    | 11 +++-
>>>>  include/net/gro.h                          | 35 +++++++----
>>>>  drivers/net/ethernet/brocade/bna/bnad.c    |  1 +
>>>>  drivers/net/ethernet/cortina/gemini.c      |  1 +
>>>>  drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c |  1 +
>>>>  net/core/dev.c                             | 60 ++++++++-----------
>>>>  net/core/gro.c                             | 69 +++++++++++-----------
>>>>  8 files changed, 112 insertions(+), 92 deletions(-)
>>>>
>>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>>> index 2a59034a5fa2..d29b6ebde73f 100644
>>>> --- a/include/linux/netdevice.h
>>>> +++ b/include/linux/netdevice.h
>>>> @@ -340,8 +340,8 @@ struct gro_list {
>>>>  };
>>>>
>>>>  /*
>>>> - * size of gro hash buckets, must less than bit number of
>>>> - * napi_struct::gro_bitmask
>>>> + * size of gro hash buckets, must be <= the number of bits in
>>>> + * gro_node::bitmask
>>>>   */
>>>>  #define GRO_HASH_BUCKETS       8
>>>>
>>>> @@ -370,7 +370,6 @@ struct napi_struct {
>>>>         unsigned long           state;
>>>>         int                     weight;
>>>>         u32                     defer_hard_irqs_count;
>>>> -       unsigned long           gro_bitmask;
>>>>         int                     (*poll)(struct napi_struct *, int);
>>>>  #ifdef CONFIG_NETPOLL
>>>>         /* CPU actively polling if netpoll is configured */
>>>> @@ -379,11 +378,14 @@ struct napi_struct {
>>>>         /* CPU on which NAPI has been scheduled for processing */
>>>>         int                     list_owner;
>>>>         struct net_device       *dev;
>>>> -       struct gro_list         gro_hash[GRO_HASH_BUCKETS];
>>>>         struct sk_buff          *skb;
>>>> -       struct list_head        rx_list; /* Pending GRO_NORMAL skbs */
>>>> -       int                     rx_count; /* length of rx_list */
>>>> -       unsigned int            napi_id; /* protected by netdev_lock */
>>>> +       struct_group_tagged(gro_node, gro,
>>>> +               unsigned long           bitmask;
>>>> +               struct gro_list         hash[GRO_HASH_BUCKETS];
>>>> +               struct list_head        rx_list; /* Pending GRO_NORMAL skbs */
>>>> +               int                     rx_count; /* length of rx_list */
>>>> +               u32                     napi_id; /* protected by netdev_lock */
>>>> +
>>>
>>> I am old school, I would prefer a proper/standalone old C construct.
>>>
>>> struct gro_node  {
>>>                 unsigned long           bitmask;
>>>                struct gro_list         hash[GRO_HASH_BUCKETS];
>>>                struct list_head        rx_list; /* Pending GRO_NORMAL skbs */
>>>                int                     rx_count; /* length of rx_list */
>>>                u32                     napi_id; /* protected by netdev_lock */
>>> };
>>>
>>> Really, what struct_group_tagged() can possibly bring here, other than
>>> obfuscation ?
>>
>> You'd need to adjust every ->napi_id access, which is a lot.
>> Plus, as I wrote previously, napi_id doesn't really belong here, but
>> embedding it here eases life.
>>
>> I'm often an old school, too, but sometimes this helps a lot.
>> Unless you have very strong preference on this.
>>
> 
> Is struct_group_tagged even supported by ctags ?
> 
> In terms of maintenance, I am sorry to say this looks bad to me.
> 
> Even without ctags, I find git grep -n "struct xxxx {" quite good.

compile_commands.json (already supported natively by Kbuild) + clangd is
not enough?

Elixir correctly tags struct_group()s.

napi->napi_id is used in a lot of core files and drivers, adjusting all
the references is not what I wanted to do in the series which does
completely different things.

Page Pool uses tagged struct groups, as well a ton of other different
files. Do you want to revert all this and adjust a couple thousand
references only due to ctags and grep?

(instead of just clicking on the references generated by clangd)

Thanks,
Olek

