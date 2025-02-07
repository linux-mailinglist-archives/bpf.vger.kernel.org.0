Return-Path: <bpf+bounces-50776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05500A2C6E4
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 16:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28661188F00B
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 15:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E839B1EB1B8;
	Fri,  7 Feb 2025 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gayKAZPk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB0E1EB19B;
	Fri,  7 Feb 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738941747; cv=fail; b=kgf7QiqJGMbjeWZYLn4teqT4H4vaEEGBAKW3hOJfxaXrsnNAl2DiwdlxJZetS8ICV9i4LSaUI95rbf1luQcwg5yns06i16TmQh8698Yvv/klTn9RsFIx3PJu835XS17Wm1/JMth3jkq1vNf3pLtuGAN/4/FfSiJBf4AvEbAB2fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738941747; c=relaxed/simple;
	bh=1ATGdheDnHgfHRDftwaliRq7z6gUiSc0lv6mAtpIMpw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=obA1amw2/X5OAwLD0PYjSauuIDTLhw3glu3ZF5dToLLLekPuPfGXX64hYl3QdfOlDvG7KOS0Asm4JE7X6hopDtv03ImVs/wONKE7GnMJlOcD4mQs1Wf0KOi7tFfp6szWUawh3oQ3GNPJPjKLxASWafFEPfV41rvU7by+3PhmZUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gayKAZPk; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738941746; x=1770477746;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1ATGdheDnHgfHRDftwaliRq7z6gUiSc0lv6mAtpIMpw=;
  b=gayKAZPkaiLyCfT6Od+zyl+tzdQR4gRuFtXtO6XUeqCluagDB/LKvQVI
   mtOwRQL3tNsWr7FplBeNrkmBwfO3891WiBtbiakdhfOENme3IcghAJvdi
   OYco+WZVPZDhFqJgBn6QKQ9wb6Smgd23qNFzXOwFQ29tZSR7K8BcTNs8+
   vdsP/txiIw1z/IZy5kAciW2rjcb4Qp2J7vW4YStp2C8SB0/owRlPnDL9k
   d5mSqN1YCFLJ/M4rR63Bgf07LmdXHUxpIo+e8/TlTIoUtlnlDY3+zSAb5
   5RfIjQc7RQEKeZXiLTIXLg3CTxpyW2vog2OXmKMbYAXCQiUnq2e7wydiv
   w==;
X-CSE-ConnectionGUID: H0cPePMNQrmHJ1QHgkzAuA==
X-CSE-MsgGUID: kap3XUoYRO2PE6s9MkVp+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="64942443"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="64942443"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 07:22:18 -0800
X-CSE-ConnectionGUID: GizOZGd9TqyFuEY/xQKP/Q==
X-CSE-MsgGUID: A3zXNgjDQqKJWRgTupqerw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116754982"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 07:22:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 07:22:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 07:22:15 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 07:22:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gr1j3cy06ZOntfOEey6vMqm4a0VQlpoLTGIswnodUrQSDVkPglJUk32sqIGQ/ggLt1AM4kEjCIBPk8kV+yuOkb6pS5qT7g6hNyBPL91leYz6e1QIkSf1lMib/FpfHjR89AS64Fsd0tDof2qlllegew9cKA5rRfI9GwxCPwqac8rc1ISh0XMABcw2gaUdajvcWqUK9M4IrUO5VeBSNm9Xp8Za/CXBF7dcr1ph8nfD3Xt0BtQqvH9clCfOAu67GrojuSvaT1YMbxAsmYTGTUwVY04hyAWhyWoloJ5+wv3ZE5jNwet4ddMZxk5BC0gUGb6fBxgte5MUxaw9wHIsTSHAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvGlAqiGhjFnrA7gj2lLv51Ag3kOomiuNUgRIX6w9nY=;
 b=QsSM6oGuf3VgyjNqNL2bg9NgBrF+FrPeJ3SSTUw/b+UI+cvTxr0wpJnZ9xiEoxnNnkEP1qRN/vC7fShtLBG8UxlS23DKVfA2qRkw+/zbx49+qR8ZualiS8uuPFHOfDzlf+UC6rnk/8X36+a+6d/W7Ma3710YIokmR8Vo6Sc90ccbCZasQ0Ox5Nj+froOr+uzt4fYunVir7EcbQBQ7ka0b3njAuWq5gROOwKfK94X6M5ntcnRfgq/6vMgWQdsykHjg3I7DpLC0SV2rQn4rtmJXCj5VBOFW9lLE41aLE9q6kgK3wStXfGa7Ez4zrjpA4LfxNKED2fPPoNU0I2TGd4LBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB8489.namprd11.prod.outlook.com (2603:10b6:806:3a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 15:21:45 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%6]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 15:21:45 +0000
Message-ID: <65176426-3ad0-455f-8afd-f53f48bbecb3@intel.com>
Date: Fri, 7 Feb 2025 16:18:15 +0100
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
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CANn89iJNq2VC55c-DcA6YC-2EHYZoyov7EUXTHKF2fYy8-wW+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU6P191CA0037.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 428d16df-12f1-43b0-d8b8-08dd478b21fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEZheFRWaHBqTFpQRmZYU1JzYTJ3VmFsSGVIMGtvcStKMXlDUDQzZ2Zmd2RU?=
 =?utf-8?B?dHpFRTBNUjU5YXpwR001TkhMVnhPaWUybzVTZkV4VU1nbjJNcWZSSVBialBr?=
 =?utf-8?B?MStRRGduUVM5RExlK1ZmK0ovb1VqczRSTmJiTlJsUDJ5b284bXRxWXRFcDRy?=
 =?utf-8?B?ZFhLVGJJbGJUY2FyRGVLOE5WcjFFMDYyQmY5d0xBRkt2QlVZZERya0pHU0dr?=
 =?utf-8?B?azVaYkx6dldRQlNLMWF5Umg2Zy9QUFkvMzlPTFJIN2F5cVBMN1BKWUxQbGo4?=
 =?utf-8?B?ZjNNL2NrK1c3SVEwd1ZpWlhsRktCcGZlWjBFcGJMeS92Q3R1THNaNHJFM01C?=
 =?utf-8?B?OWlFMDR6QWNUeXI2UkNLSWlPQ2tpN3k4bzZYYWh1a1JkbFlsOUUvdXE1NFor?=
 =?utf-8?B?RDl5U3JhK3RTRXVhemZiajBnTmRVekE2ZjZJelAxKzhNRjlIb0dPVXRFOGtW?=
 =?utf-8?B?S1c1NHFDWEs5RS9qalZ3Wmt0QzB5dkRMREN0TjZNeHJIcGRuaFZrNXBCK1Bn?=
 =?utf-8?B?K0p3NG9MOW85NkFtYURCWlA1V2ZGT1JDMTNVUDlUTWNvQW9WSzc4Vm5CR29k?=
 =?utf-8?B?L1RhTFd4NGdybE9KY0FMOXNnY29PSUdRWmpUUmdxb09JdTFUNm9nYWFUdzNE?=
 =?utf-8?B?eWdnbkZ5RXR4ZDB4Tk5TKzFLc2toSmpaYUFtSmxDOWpZTzd3bzJXelpZNDBV?=
 =?utf-8?B?VGJ0RW5pSFZQSlJpY3BDVG8ybk1vTkJqNXZMZldtOGxIQWdoaFhlekRsbFZ6?=
 =?utf-8?B?RDQveVZwR0dSalA4NmNlQVowYUNMaDZ6N05MVFVIc0ZxNGFqV1BlNFo3SDY2?=
 =?utf-8?B?N0tlVXM3bmQ3OWwwUkNHOFVNVllNR2F1ektZelA3aSs5WHlRRVpKWlVyN1Z6?=
 =?utf-8?B?OG9QUHoycDdvQkUvYkd6K3EvWE9YMWkzWW9GYWFZaTNoZkRtYXlMWDdiQ29o?=
 =?utf-8?B?cC9OWjdrZmlEa0F1MXZBOU5Jb1ZBLzlXcXp4SUhEb1JKUGo1T0xNbWsvNi94?=
 =?utf-8?B?RDArbXhrck4xUUFWMjBGQ080VldFMk1KWUNuR2lhUS9sUmVuc09yaGJpUFNk?=
 =?utf-8?B?T1diTW1qbzJFVE1ST3ppaVZNcys2b3ZvSHk0c1V2SjZHWTNWUGxZQ3RhV04w?=
 =?utf-8?B?cVRDMktmekcxVUF3dTdwOUp0bHgvMUpjcjZBajBCOFcrSERmaVFWVVNGdGNW?=
 =?utf-8?B?cWpoUk9OenpLaFpZbHdQMExvUTBnZGRsYVBTR01OWEZHT21SUkp6aXhQV2Vs?=
 =?utf-8?B?UDEzMWhEV2xKcnJGZVY5aGlGSGZwOU1mWGxPanprZDYrRWdpamhULzVvNE5O?=
 =?utf-8?B?YWVjbDJZd3F1WlVRKzJaSkVwQzFKS3pMOFhxclJrRjhJdjJ5cE51K09tdVRU?=
 =?utf-8?B?OUplZjRZKys2KzhaY0tQQk1MSTZLRUE1ZmhFSDZtY3kxZjFGbEo2cWM5bloz?=
 =?utf-8?B?UlF1WEx3UHRwZXdqbE1lUzBoUWFGYWI4bEtpN0h3T3RWOHdvY1NnMUhWNUEw?=
 =?utf-8?B?L0NobjRCekJkcWpPNEVhWXJYK0xvN0FiQXFRME5TdG81Y09Ob3kyd2EyK1ZE?=
 =?utf-8?B?VkJXOGNBQVJIWmJXbGhNL052aGovVHhRU204S0FUdFlTSnh5dGN4MC9DLzkz?=
 =?utf-8?B?aTBkMW1CZ1VoRXQ0MktINVJGMEdHU3F6NFVBZTVLVUFGNG1sZ2JWWlVaUXB4?=
 =?utf-8?B?TmVGMWNGR2tVZkUzZ3dLbFM5WHFpcXFOd0laSEZsVE0xUnBkL0FaUnMxdnFn?=
 =?utf-8?B?cGx3cENLRmNaN0swdjU0Q25uN2pxcDFudFljMWhFQ1RXQnNLSXFFTUt2eHJv?=
 =?utf-8?B?Q0xpam5SZ0JZUGFhT3pHZy9RK2NucDZSZTdwUHVPSXhneTRjQ2RGR1Z1WXJZ?=
 =?utf-8?Q?74xtXzJMdz1tS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajlBZVdseXUzTEVHYWpwUHptQ3FaWC9LMlFrMmRMcjhCUmNWNkEvLzJLZGN5?=
 =?utf-8?B?TUFVMXZKTEFVbFRybnhWTmZNYk8wNGpoanQxdDIzNDJOZGoyVG9WbG5ZbXAz?=
 =?utf-8?B?SENianh2aDA3eDZFV2trN0pyWWFyTXZXZjdpOTY1M0VvZExkWGVRVUE5djVE?=
 =?utf-8?B?RldIbk55cEJ4RlFGYkR1SHJrSVZDb0x6TjNvN0p2Q29DYmZ0cGVINElobW1T?=
 =?utf-8?B?bkdjTHZZZjdYTGl0WUhWK1R0K0xESHg1Q0xwWFNpOFlOWEZvcmJWRmU3SUcy?=
 =?utf-8?B?MHdLc1hiZFYvaCtzcmovMmRLMmlaMUJXakhwOUREWjhsRHZxaGFoSC9oRm1U?=
 =?utf-8?B?WEQ1R2ZKa3NJMTZVOEp2SzY2b3RMcnFPSjNjVXVSc2ZxbVhxdHEzbWQ2ZVpH?=
 =?utf-8?B?YlZmbnQ1L2EwL2lvS2tnZU9Ud25CeWVneVlyVG83UEgyM3hpNmFPQTRndVNt?=
 =?utf-8?B?YlpUZ3JtLys3V2V1QU9GSGlZakxpOUVHN3JyVytZbEtBbGNraXJJOEJWNnRU?=
 =?utf-8?B?bDlyMEIxdXcvTTZlaFFkZmExS3lRcXE1am1hTlhOWkRwUXI0ZVlJNlBPYVhr?=
 =?utf-8?B?MGQrWDN6RDZQbWFjNXJzMEZzUmM0YWtnR3NlVytuMFBScXBvR2FyRSsrampB?=
 =?utf-8?B?UmxDQ3VmbDdSa2RXT2t0Z05hcnUvME13WlBrdHlkTWlOWHJ0OStwTjRBdDBF?=
 =?utf-8?B?N20rdjdyVFM0R1B0bzZSQkZ4b1ZPL0dIMjJaN29TcE5OSlU2SmNLMWlXOGtB?=
 =?utf-8?B?ZVF4eWpkSldQZGRJdFBwTUxWZEF5Zm5yR1FDOEVaQTdUMGNiWWNxUkx3blZ5?=
 =?utf-8?B?UzRRV0IvOEx5VzIvdkk1U2VGQXFWOGc1UFY5RExEeEg2LzRBY0lYT0YwSHow?=
 =?utf-8?B?OVhhaWxIRG1CRVlsNkZtUkl3MWVodXhEV1lTbWZQY3BuOUgvbk91VHJ1WXJI?=
 =?utf-8?B?dGZhODIyczJiQkhCZ01HZnNTTTd1ZXhaelozNk5jeVdvM1ZVWWpLQmk4UGNo?=
 =?utf-8?B?TS92TC93QllNK0orcGlOMzF1WnpXMGtLVXNwQkdhaXZCRlIvSG55Y0srdjdC?=
 =?utf-8?B?OGxDS2czbGZqZDZBb1htVDk2K0ZQNmFoU3ZLRkp0QzErOEhFVUIyWjFJTmh4?=
 =?utf-8?B?a1ZnYi9rL2c1eUpIQ1plU0JZRHJCRWk3UERyb3VYVXdhdVRxQkpLMThKOVdB?=
 =?utf-8?B?TnBlT2dwbDNIdlpUSzBXQ1F0SmtaR2tYYmJ6MWdRYW5XR2Y1d3BXeStTdTdN?=
 =?utf-8?B?UHFDZjZPaDMwc3BNRG9DSUN6OXVhanE5SlIrQm9WWS9zcHFaMGZ6SXVoRXFz?=
 =?utf-8?B?REpuSHpza3BQc1ZPL0IyUGMrdUpsN3hLOWJyMFBZUkdPQVZ6RDVsa2RnRDI2?=
 =?utf-8?B?NWdtLzBTaEVBV0VZcDkrVHNrcHhMSmRmcS92UTZ1KytWbVVNR09acGhadnl3?=
 =?utf-8?B?WnhjY0pwOGNydlZnUlREMHYzZEJJTEhHR3dLZnpwZ1lOVkVSaDkwd2NxcTB2?=
 =?utf-8?B?V3BDbnNFSXRkNWFDWDZiZkxpcmZIQWNIMnBxM0x4UGRieElXM1Y2NGlGUG1y?=
 =?utf-8?B?aWJWNU1QaTFrZ1drRUtkUTBXZ0Y4R0hUZUw4Y2FncHE5R2IybHlkSlQrbG44?=
 =?utf-8?B?Mkx6TE1FdWdWMUtSZGZHZSt1MEkvY1orRjl1RU1VYXpsUjZ3aGIwRi9VeUdD?=
 =?utf-8?B?c3R1N09PazRNVXlpREdabnAzalBMRzFHcHNHQnN1RGJGVWgrYzcwMExsTUR5?=
 =?utf-8?B?emJDdXFTZW96OUdxdnA4Sm9OMlA2WkN6bFd6dTdWekh4TWxkblpnTWpyYU05?=
 =?utf-8?B?T1lRY3cvejBRM21KemFyeEtsK1pzU0Y5dWRnZWdkVDBMZk1hdzkzdTN5MVdR?=
 =?utf-8?B?NEhERHM5TStBZTVTZ2tUSnp5anc3YXN4WkE2cFEvcUFLK3BUYmtxbTd2aEZD?=
 =?utf-8?B?SkxscDBOdms0b25PTzFmYk1UYmJCS1ZVeTVkR3dYTFV2OFZOeFdzZEEvRC9X?=
 =?utf-8?B?ams0VE5jTWF1enlJbGppWWJ5RVM2R1VWeEkxTURsTUs1aXpWVEJuREl1amll?=
 =?utf-8?B?K3VTNW9ycUZqUng5UmZJaEhGUk5mcjc0Ull5eDhWbnBZNnFnbTkxMWduV2pL?=
 =?utf-8?B?dVRON0dzUzBLZ3J5eXJwdVM5L0JPWlFuK28wZHdPZStUenBZYS9Eb01GeDE3?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 428d16df-12f1-43b0-d8b8-08dd478b21fa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:21:45.5745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hG7ZIgyFNDNQw+m9SbWNtFahebNy4br9hyhNHgTHC6YIpxESjc4eSKQmy885YL0kxUvLY8P0sd+e4CmXJdzs9bfbQMI4Di8JHfyiBQinENw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8489
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Feb 2025 15:55:35 +0100

> On Fri, Feb 7, 2025 at 1:00 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Eric Dumazet <edumazet@google.com>
>> Date: Thu, 6 Feb 2025 19:35:50 +0100
>>
>>> On Thu, Feb 6, 2025 at 1:15 PM Alexander Lobakin
>>> <aleksander.lobakin@intel.com> wrote:
>>>>
>>>> From: Eric Dumazet <edumazet@google.com>
>>>> Date: Wed, 5 Feb 2025 18:48:50 +0100
>>>>
>>>>> On Wed, Feb 5, 2025 at 5:46 PM Alexander Lobakin
>>>>> <aleksander.lobakin@intel.com> wrote:
>>>>>>
>>>>>> In fact, these two are not tied closely to each other. The only
>>>>>> requirements to GRO are to use it in the BH context and have some
>>>>>> sane limits on the packet batches, e.g. NAPI has a limit of its
>>>>>> budget (64/8/etc.).
>>>>>> Move purely GRO fields into a new tagged group, &gro_node. Embed it
>>>>>> into &napi_struct and adjust all the references. napi_id doesn't
>>>>>> really belong to GRO, but:
>>>>>>
>>>>>> 1. struct gro_node has a 4-byte padding at the end anyway. If you
>>>>>>    leave napi_id outside, struct napi_struct takes additional 8 bytes
>>>>>>    (u32 napi_id + another 4-byte padding).
>>>>>> 2. gro_receive_skb() uses it to mark skbs. We don't want to split it
>>>>>>    into two functions or add an `if`, as this would be less efficient,
>>>>>>    but we need it to be NAPI-independent. The current approach doesn't
>>>>>>    change anything for NAPI-backed GROs; for standalone ones (which
>>>>>>    are less important currently), the embedded napi_id will be just
>>>>>>    zero => no-op.
>>>>>>
>>>>>> Three Ethernet drivers use napi_gro_flush() not really meant to be
>>>>>> exported, so move it to <net/gro.h> and add that include there.
>>>>>> napi_gro_receive() is used in more than 100 drivers, keep it
>>>>>> in <linux/netdevice.h>.
>>>>>> This does not make GRO ready to use outside of the NAPI context
>>>>>> yet.
>>>>>>
>>>>>> Tested-by: Daniel Xu <dxu@dxuuu.xyz>
>>>>>> Acked-by: Jakub Kicinski <kuba@kernel.org>
>>>>>> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>>>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>>>> ---
>>>>>>  include/linux/netdevice.h                  | 26 +++++---
>>>>>>  include/net/busy_poll.h                    | 11 +++-
>>>>>>  include/net/gro.h                          | 35 +++++++----
>>>>>>  drivers/net/ethernet/brocade/bna/bnad.c    |  1 +
>>>>>>  drivers/net/ethernet/cortina/gemini.c      |  1 +
>>>>>>  drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c |  1 +
>>>>>>  net/core/dev.c                             | 60 ++++++++-----------
>>>>>>  net/core/gro.c                             | 69 +++++++++++-----------
>>>>>>  8 files changed, 112 insertions(+), 92 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>>>>> index 2a59034a5fa2..d29b6ebde73f 100644
>>>>>> --- a/include/linux/netdevice.h
>>>>>> +++ b/include/linux/netdevice.h
>>>>>> @@ -340,8 +340,8 @@ struct gro_list {
>>>>>>  };
>>>>>>
>>>>>>  /*
>>>>>> - * size of gro hash buckets, must less than bit number of
>>>>>> - * napi_struct::gro_bitmask
>>>>>> + * size of gro hash buckets, must be <= the number of bits in
>>>>>> + * gro_node::bitmask
>>>>>>   */
>>>>>>  #define GRO_HASH_BUCKETS       8
>>>>>>
>>>>>> @@ -370,7 +370,6 @@ struct napi_struct {
>>>>>>         unsigned long           state;
>>>>>>         int                     weight;
>>>>>>         u32                     defer_hard_irqs_count;
>>>>>> -       unsigned long           gro_bitmask;
>>>>>>         int                     (*poll)(struct napi_struct *, int);
>>>>>>  #ifdef CONFIG_NETPOLL
>>>>>>         /* CPU actively polling if netpoll is configured */
>>>>>> @@ -379,11 +378,14 @@ struct napi_struct {
>>>>>>         /* CPU on which NAPI has been scheduled for processing */
>>>>>>         int                     list_owner;
>>>>>>         struct net_device       *dev;
>>>>>> -       struct gro_list         gro_hash[GRO_HASH_BUCKETS];
>>>>>>         struct sk_buff          *skb;
>>>>>> -       struct list_head        rx_list; /* Pending GRO_NORMAL skbs */
>>>>>> -       int                     rx_count; /* length of rx_list */
>>>>>> -       unsigned int            napi_id; /* protected by netdev_lock */
>>>>>> +       struct_group_tagged(gro_node, gro,
>>>>>> +               unsigned long           bitmask;
>>>>>> +               struct gro_list         hash[GRO_HASH_BUCKETS];
>>>>>> +               struct list_head        rx_list; /* Pending GRO_NORMAL skbs */
>>>>>> +               int                     rx_count; /* length of rx_list */
>>>>>> +               u32                     napi_id; /* protected by netdev_lock */
>>>>>> +
>>>>>
>>>>> I am old school, I would prefer a proper/standalone old C construct.
>>>>>
>>>>> struct gro_node  {
>>>>>                 unsigned long           bitmask;
>>>>>                struct gro_list         hash[GRO_HASH_BUCKETS];
>>>>>                struct list_head        rx_list; /* Pending GRO_NORMAL skbs */
>>>>>                int                     rx_count; /* length of rx_list */
>>>>>                u32                     napi_id; /* protected by netdev_lock */
>>>>> };
>>>>>
>>>>> Really, what struct_group_tagged() can possibly bring here, other than
>>>>> obfuscation ?
>>>>
>>>> You'd need to adjust every ->napi_id access, which is a lot.
>>>> Plus, as I wrote previously, napi_id doesn't really belong here, but
>>>> embedding it here eases life.
>>>>
>>>> I'm often an old school, too, but sometimes this helps a lot.
>>>> Unless you have very strong preference on this.
>>>>
>>>
>>> Is struct_group_tagged even supported by ctags ?
>>>
>>> In terms of maintenance, I am sorry to say this looks bad to me.
>>>
>>> Even without ctags, I find git grep -n "struct xxxx {" quite good.
>>
>> compile_commands.json (already supported natively by Kbuild) + clangd is
>> not enough?
>>
>> Elixir correctly tags struct_group()s.
>>
>> napi->napi_id is used in a lot of core files and drivers, adjusting all
>> the references is not what I wanted to do in the series which does
>> completely different things.
> 
> Leave napi_id in struct napi, it has nothing to do with gro.

Do you read commit messages or reply just to reply?
Have you read previous revisions' threads (links are in the cover
letter, as always)?
I recommend doing that, and then proposing a solution that will be as
optimized as this one in terms of both performance and napi_struct layout.

> 
>>
>> Page Pool uses tagged struct groups, as well a ton of other different
>> files. Do you want to revert all this and adjust a couple thousand
>> references only due to ctags and grep?
>>
>> (instead of just clicking on the references generated by clangd)
> 
> I obviously can not catch all netdev traffic.

I didn't say you should. But I'm 100% sure it's not the first time you
see struct_group() usage, so why complain only now? Esp. given that the
whole series is reviewed in v1/v2/v3 and there were discussions
regarding all those things you mentioned and I explained everything in
details both there and in the commitmsgs / cover letters?

Thanks,
Olek

