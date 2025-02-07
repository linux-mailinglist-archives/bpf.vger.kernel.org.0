Return-Path: <bpf+bounces-50780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AD0A2C7CB
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 16:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69AB118875BE
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 15:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0648724819A;
	Fri,  7 Feb 2025 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3K+oeNQ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445F42475CE;
	Fri,  7 Feb 2025 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738943217; cv=fail; b=oHpDdpB8/ctWXRPN60n8N0/Jafnfs9sHhORl0AX4BWHs9iLrdrbeAhSr4dk4P2FZhb8R+RVaA3XSC9n+HRUILvM2F1T5KMVdLnEbElJOMpbOQMRN6pN1Vl/cJwHRNFse9rxARLhMv+3950WkhJBJ2u+RYXLh3aU6lKn3quoBFPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738943217; c=relaxed/simple;
	bh=LaUFH5tQMLYxm6+re67HvrdiVogQKtuuhh/3qKNAI8A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IjOJMrWylKXLiToihz3VNrqxpt4khqW/e5vIYERh2DS/9Izm1lhyza1U8llB/wqP3mNNr2nIEu6oDA7jQSaVPakjdZqKI1zMGDVij+8v12eadsW8qdoHzH2pKmgD/+FnU1yf4B0GPFscSxPMFNgSdBG39d6KB9xkqKJpGjq14y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3K+oeNQ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738943215; x=1770479215;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LaUFH5tQMLYxm6+re67HvrdiVogQKtuuhh/3qKNAI8A=;
  b=M3K+oeNQI7RhWVM+NOc0F6mXSh2QNInq/WE+/0gGgPkMWQiGbY5WcRW5
   c/+8wm/Fel92um5NUfgbjLJInk3Dy5pRQp7lIUt72NeUDZVqYGWrfdlwx
   /rIvLNz6bEnmFUJZbW/eapnhzSaH/IStQd8KrkCOFl6t6YYGuiSL4/aKS
   9NA8GLOtO0wWJRxMfo4gYCR3zlJ1k2UGRYPfsdrU/o5wADts4pvx/Q+82
   lkp5d/jO10v1yCZbOFBmZg5DLnXwjzDPcna2M/+CqHQe+n1AAWCH6Rpb0
   RrPC78o50M1v6dkLqJaWqrAjiLNr4ofl/0hltei7zylAcQvEy4uOWlDc8
   w==;
X-CSE-ConnectionGUID: DxczygNhTV+xqFX+Ao6ung==
X-CSE-MsgGUID: eenwZHjmRoyYdX4tLVXRSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="62064771"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="62064771"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 07:46:54 -0800
X-CSE-ConnectionGUID: LgoAG+znSb6uCBW5/yubEw==
X-CSE-MsgGUID: 4CGKy0IRTCWX0cPAKwMSQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112452869"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 07:46:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 07:46:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 07:46:53 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 07:46:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjyWY+w9A45nfArMFBf6D0HcyHRxKxUMIgAQCnYOU0pOor3i61g3kmtN8b/9lSBbolz8+IarJCd5f+C/YHMe8+Fo5EchMuZ8ZfeQuKIM6t4PPjLZuFe4l7uKXO2UZ0dInsfsUmDqKNmkJ2kVezy+8xGaMvFF8hwdc/0WoJOL624LADCrDQda/YnYqOUVnxXvjtKE15u7WgOhpUgKBGv+ng3E9XfykPlffwvdgiMdcAUFW3sB3l54xYvKE3cSiY77rezAORDMBBlfV4yctNMfYBRPez9YNnivZJ6NcOaAX+FwU2voOrnAlzxBGCAPhjW/lk3DSaxEkb1GcrbOHmokjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaUFH5tQMLYxm6+re67HvrdiVogQKtuuhh/3qKNAI8A=;
 b=rNUOYXUgGb8V6gRe/UzPQF5E74cBMTK5wr3CtrSQ43fxkozz+t5yXtAYGqTWRMfC01pedqATARW85D66VZk2YD7EWLmoLLoCXxE5SLa+O3Nm8r1Pem13PJ/z1FTTKcTVfI65xHrL3FiJcOXvAQMfcOAd0JkURljy7dSnIZ3jBbLiZQQjVZ+j5DQ+OSfK9NdR4fL33yoPdNo/crklk0RHgPycrvm40bfkBV4idxkiw/jQPqGo5+TO8vBgHpM7uMNnSq4+7rA01MzRTQapbe1/MWZShyc/mDHnUQVcfo1jQp9xvAzABItEyHuunA3MKrs+0aQCFcJGof0agVh+l/F4MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA3PR11MB8075.namprd11.prod.outlook.com (2603:10b6:806:303::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 15:46:50 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%6]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 15:46:49 +0000
Message-ID: <19f5473b-e7a3-4d39-a534-6ab2da2b16cf@intel.com>
Date: Fri, 7 Feb 2025 16:43:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/8] net: gro: decouple GRO from the NAPI
 layer
To: Eric Dumazet <edumazet@google.com>
CC: Kees Cook <kees@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu
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
 <3decafb9-34fe-4fb7-9203-259b813f810c@intel.com>
 <CANn89iJNq2VC55c-DcA6YC-2EHYZoyov7EUXTHKF2fYy8-wW+w@mail.gmail.com>
 <65176426-3ad0-455f-8afd-f53f48bbecb3@intel.com>
 <CANn89iKSw2QOeOzP8dke0X7cHheKdx=T9aQ7q7d8OemMNN8u7g@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CANn89iKSw2QOeOzP8dke0X7cHheKdx=T9aQ7q7d8OemMNN8u7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0006.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA3PR11MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9267f0-4800-4a8d-5cae-08dd478ea291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vy9DUi9qbnNwNUNsS0JCd1VLOE9yUkwyOFlwYy9hMXJPSnlXaUVVMlZPN3NG?=
 =?utf-8?B?NWYzVzBQMjFIOEtxdUFFQW1SaEVUMjMvWi9WVUZ2TGZkWDM5Vk1wbHIyUlpF?=
 =?utf-8?B?MzQvVXB5U3JYUnRxVkIvSGVjSHM2U2Y4dHErWFlwcjl5Rjl5d0NweVMwcjhs?=
 =?utf-8?B?NXQ0Qk9qd1E0b0xsYUM0V3c2bHFiVFBibXZRT3R2dkxnL0pXVlI5ZTUydFdn?=
 =?utf-8?B?dWRCSHJJWkpWN2xXYTBNT0JxK3JkeDAveVJ3WExhRnY5cUZoZHZVTjh6b05U?=
 =?utf-8?B?K2tmZkJ2empvK1J1eFFuSVJFK1RTWVhpbGtOSDVtL3kyTlRaQzBzRXd1M2t1?=
 =?utf-8?B?T2ZYWWVvRHJ3ZUwxV3hCVStSNVNZRHB3aVF6ZXVac0JPbVNWRVJTd3ZwVXJW?=
 =?utf-8?B?NnBPMXJzNWxPMFJOd0NhMzQwRzJ2K0NpZ1I4cWtyMy92bitlR0lzV0xXa3Fy?=
 =?utf-8?B?di84TnpPaWh4UStwQlBMMm9xOWNBZ2pqUmJSWS9YRGVBMFNRZk1tN3lyMC9z?=
 =?utf-8?B?NDhXSDVBeTNKbitoaDNDUkp6MmZMOStqNU4wOFRhZFBGQ3BSVWFPcVZMVG13?=
 =?utf-8?B?QWhLYzdnbmtDcjQvUHR3a2tKSkNzaGlscm9PUEhIMDQ0UGMwajZIRTBsMy84?=
 =?utf-8?B?U3JnUXkzWmljanNpYzhMbkZaMSt5NUtVTis2bWdBR041UlNDYm9QbzgvVjZZ?=
 =?utf-8?B?QVpTb3dtWWEza0E1YmtRN0w1cUl0SGcyWjhaVEg5N1JQNWRIS1A4dy82UkR3?=
 =?utf-8?B?eVFBRnlOekdVazh0TXYxWXlDdFg4TDFEdFV2R1d1clFrd3g0V1BGQWp6cGtT?=
 =?utf-8?B?dlFKdm1hZVA1MmJOejk1UThjcXJHWFcweEU4bDB4ckNUMk5HUlhDRlZUNkFi?=
 =?utf-8?B?azE1U2NzN1MrOGRDdGFQQkJOSHE2RjNWQTBhZ3hKRWQrRk1yK2lTVDJhdTYv?=
 =?utf-8?B?K09ZYTAyT1ZFQStwYlhMbnNSbHB4eHFkQm8rUFQ4MzhxWXVFWWR2NmFUc0ly?=
 =?utf-8?B?VWtNR1dvak5YS3hRUllyQWJvUkxoUnlPNXYwbWM5WFpRWEp1TnpHS250K0hW?=
 =?utf-8?B?QVhTN1JjQlZ1cUc3VXA0WSs4eFJjQ3Jmek5UV0UzNGViUXlyNG9sTHFSTG9T?=
 =?utf-8?B?UHRkeDl3OWVFOXNGaHphZEl0MG1vRmdxdGNTSFJwK3o3d094bjlnaGRPY3hj?=
 =?utf-8?B?a3FzWGs4Y2plMURkeFprcWdlcnZtdjVXRndTSGc0djgyZVlEVW13SklGVzYx?=
 =?utf-8?B?K3Y0M1BHTVY4RDFGci81SzNURnN4Zm5DaWtvdDlkL1g2YUp3SDVpVGhieWND?=
 =?utf-8?B?eVVOeUhtV2FDYlJxWjVFZG1FYVdQT05nOVhFOFliUGhwcWc3dzJFdEFhQmZ1?=
 =?utf-8?B?NVlPc0VaaHJYa2k3WWwzTDdtT1AxTkFOQlpOR1hYV1N3SDVjTUU4QkZQQVNn?=
 =?utf-8?B?NzBvbkMxSzE3QUtTdlV3R25seWlSbHRHTUZhYi9FUXJ3aUhqNDVHanIwSS9w?=
 =?utf-8?B?L2hNQjN0cHZwajdNUDB3WXVKTHo3Nnc3MzFVd3N6UksrNHpJNUZJSFF0bGdr?=
 =?utf-8?B?bFBpeDJncWlzajF4UkpZTUdWTjNHZkpGZGtqTncrVzg1SlB1RWtRWGxNeGZT?=
 =?utf-8?B?WWJ4YzNVYkNqS09FNXpnUTdMdHowSWRVTWxtMVF3VjRUNkNhcnVWQlJPcmNj?=
 =?utf-8?B?VU9wRk0vdGxOZHRFbHY2bjhndlMzT1NFVVlURTI5bW9vK1kwU2FCZVpaR2hK?=
 =?utf-8?B?Zmlhdkg2NXUyU3IrUTVhc0hXZ1pOSUdBVXFTYTNZSUd4WUtUd2hZR2g5Y2Ru?=
 =?utf-8?B?NWpERmtBRGVRbm5GWlRTdnh3Q2VyZkpMOGQ3QXRKaXBHaHBKMWp2dkhzSEdm?=
 =?utf-8?Q?H57t9pG9z/3xI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnQ3MUZrTlhVWGNCanQ5MXlMcEZ1aGd3cFoyaDNkTlpCRHpVd3FBRVJVYnUv?=
 =?utf-8?B?b3F2dHBSY1FlRC9iWXpzMTBVRUQyMUY4eXovZHhTRGhzM0NUUmFVWFRmM25v?=
 =?utf-8?B?UVBXWVNYOVM1a3VLVVFwZ0RkM2xmbTRUaWZpeFVRbnJUS081MWdzbThXYk0z?=
 =?utf-8?B?Q0JwRlRGQmRGUHJFTGVFTlZuaXJqQVEvbEZudU9LaE9PTnFsajJSYTZFWGI1?=
 =?utf-8?B?YUhVcjlSM3BaL0pUZEF1TElldSsvVmY1UmVKRHN1bWE1Q3NtN3dYeitSbmxL?=
 =?utf-8?B?ekpiSUZrdWJIckw4R0VrZHBQck5laU9NdmdQNERrd0ZvaStvMlVqUXhNMmgx?=
 =?utf-8?B?TnVoMk1PdDVPM3I4aU5PWnkvbjRJcXVLWlBSRzZSOWU4ZDMwV1FZNVJMSGJ1?=
 =?utf-8?B?TmJvUGxMNmRJbHAzbDg2MDJOQ3NDY1dQaHBPMitKK3RZTTI3dnBwNE5CSEl4?=
 =?utf-8?B?TjROcjdBeTFMREMxSWRuWUxPSWlzQXNVUVFhR210eEhObDk0TTBXUWg2YVJp?=
 =?utf-8?B?dXlkb3BRR1kyeVJmWFVoQUp0MC9obVVucWZCdUdjVGYyalBCWTdYTytHeE8w?=
 =?utf-8?B?cU5KM2ZsVnkrZnhTdjZ3bExLTWN6WTRDRTM5TWdjYXNnaXAwN0xaM29QOWZ2?=
 =?utf-8?B?RmMvN3JzMGdWM0dRYWY4UmdjVytvemUyTVJ4dy84SDNLQXUwTWxOOW5nWUlk?=
 =?utf-8?B?aWJSSnBhVytFSUM5VnExanpXeWpFRUxFaFRTWHpIQ3ZwOUM1ZnJLMjBpbDRn?=
 =?utf-8?B?VnhOYzlreUJlcWpzS3pkWUpHOFRGN01vNDNlVmlHSHY3ZG1MVERQUFZXWEJS?=
 =?utf-8?B?UVovMTA4S1A1WFQ2NlJZWGxwcEtRWURFRmIvWGdHT1dLUDh3bXdoWFB0Tk5W?=
 =?utf-8?B?MUJ4UjArdG5OTVdFUXhsVGNTdkg1ZW9pUHdXb2tFKzNyb25oY0V2a0NGU3hK?=
 =?utf-8?B?ZDhRMDVRNjlYcXJreEhKQllzWlF3cm8yTjIzNnRiYTJ4czhSUlN3VVFrYXh3?=
 =?utf-8?B?M2lPVTZodHBBT2dLemgxS1RsL2VPT2dyMExkRHBkM29tc2p0VDZVMTRlb1Q4?=
 =?utf-8?B?Zk43ZXR4eWpTaXdraDNBbm5ocURJT3lzaTVOTlNtNXkrVHY3TlI0QmtsRUs2?=
 =?utf-8?B?N21heGpLYlR3UGt2aHV3aE5UWDdacnBHSmZmTTZqOGhYRTVqTzVhV2NiWUo2?=
 =?utf-8?B?RnQxaUxaczBRSFJOVGxIVllNOVBjMFFiYkY3ZEtYVTZwTG84M3Q1VDAxcEhX?=
 =?utf-8?B?Q1FHb0luNjl0bGRzcFBTRS9sNWcxcE01TzJSQzNIbUtJcXExM0pVbWV3aEYr?=
 =?utf-8?B?WnFnSGYxQmk0SndoMHpNeWluOXkzRjU2dG5KMGw0K0V6eTl0RE1YZHpxOVlr?=
 =?utf-8?B?bS9QODlvNmZYZzFCa1QwYWk4VkllQWEyc1A5bmszb25aYVhnWkFHMHJwRExz?=
 =?utf-8?B?alFZRUQwN3B4RngrcEwxazJoYTN5a2JwMkhTcUgyRmdobG1zV01GYmNDQVJ5?=
 =?utf-8?B?UXdiNllLdVBhSXZGSHBpelFvOWhzbis3Wk0wZTZHWlRsRDJTcGxHRi9KcDlp?=
 =?utf-8?B?RXV6dndhMVdLS1lycFNKT1RSRUdBZUpYR1dZVmZuNUpqUkU4WEdEZnA2QWVB?=
 =?utf-8?B?ckhBeEM0V3JaZ001dXdncWp6TlZ2VVM2QkdzVVJOMFB4NlI3VG5Sb0NZVE5m?=
 =?utf-8?B?Z1JqZXFwRGpuQkxQcGlaVWIwTXF4TTlLcHZabHJBb1puSlI4TTJ5ajBmem41?=
 =?utf-8?B?cUFjSWwzMHpOVkx3T001QU9nRFZyVUcxUktFUU5QQTJBRklqYzZHRlAxQzFK?=
 =?utf-8?B?c2VKK05zN1o3eHVWZUNuOEhsNmRBV3RVaXVOakhZcVh4MjNKb01YM05scnJo?=
 =?utf-8?B?WjZqdFlaUW9sT01pTVhjNVhKaWUrNStIb2RzQkg1d21FTEJUNFdKYWhQT1FU?=
 =?utf-8?B?ZXh2bkowcTJ0S2RzWWtiaytJTXREU1diSk90OGlCeHdjVkVxdmVNZVE4S25n?=
 =?utf-8?B?S2hZVGg5S1RBZkhhQXJORTc2cnJnL0tNNHVyODN1bWhuSTB1YVNFaEl6MVM0?=
 =?utf-8?B?MnRvS2JPbTl5VFpZeUVSRGxwdWc5Y0x0MFliaDN0U281RGVEQlViSmJjZG1M?=
 =?utf-8?B?N1gzSzRoNi9EdGdSR0NubVRiRGFyeWZJSVZQRXJ3bk9xcS9JdUl5di80RHh2?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9267f0-4800-4a8d-5cae-08dd478ea291
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:46:49.7539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNVEeFTg50NPgLJSrP1+K6ovxee2wIYeUbe3dQSaULDJ1orC+3q6KWMYvD1jYSOlRJ+BqXMDSoa1OWH8Q8cHIpmr2F9/sYR2ozG/fJmWQHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8075
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Feb 2025 16:28:05 +0100

> OK, it seems there is not much to say.

I just asked for reading the details and my explanations, which I gave
several times, for your arguments and propositions for improving the
code. You know better than me that single a "I don't like this" doesn't
work here on LKML.

Since for now this is 1:1 disagreement which you don't seem to want to
resolve, anyone else can join this discussion and share his vision
(again, with arguments and propositions what wouldn't hurt hotpath).
I'm always glad to hear critics and improve code I write (I never mind
sending v5, v10 etc., which sometimes happens), but only when this would
actually give benefits to the code / perf / etc.

Putting gro_node out of napi_struct, moving napi_id back to napi_struct,
different approaches to handle fetching this ID to the skb we want to
pass to the GRO engine -- I tried all this and each of them hurts.
I don't mind sharing bloat-o-meter, pahole output etc etc, but I thought
the explanation in the commitmsg and the discussions in previous threads
explained enough.

...

Off the topic, but back in 2020 (or 2021) you were very against my idea
of using NAPI percpu caches to cache struct sk_buff there to lower MM
layer pressure when calling build_skb(). Convincing me that it doesn't
make sense, doesn't give anything etc. Now grep for 'napi_build_skb' and
look how many vendors/drivers use it. IIRC Mellanox reported +15%
switching from build_skb() some time ago.

Thanks,
Olek

