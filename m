Return-Path: <bpf+bounces-37058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4188D950A2E
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 18:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F320F282A59
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 16:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE671A2560;
	Tue, 13 Aug 2024 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDV5Z9q2"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE2619DF7D;
	Tue, 13 Aug 2024 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566697; cv=fail; b=lgb3taeIGW6L/3fUmpIjfp0O9N3YKo8B0AhTtMEeypem3BrqauqrvC1uZPKsf2CGMNYr6Tr/Xr94yAZS7PJ0D97frtZ0GVqWx8G3T2pu9AGRuTdmuBpJjzu+gay9ckB8uQ7yiGHZSgfnsiHMr/ybd0NKwSb1ctvffPZTlcI+HKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566697; c=relaxed/simple;
	bh=/elfslYXfII7yv06Utb+lL+gVv95k7idYEHDXfJqId4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RaO3+mykoIm5HrrnZBGWtBEIpk6vSkY9RDFF+WABp4Nvu5TVjHv6+SBsgNHyqMdxTnlp5k0yoUzcq+6bm2EYHzrmLr65oPi3g1gUr5h6l3CJHCC7NFfd4c36IsqvIkDzTgE7HbAEzX40tnYYZyi/3Rsl8jdN/2ySr+zt7iZCv0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDV5Z9q2; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723566695; x=1755102695;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/elfslYXfII7yv06Utb+lL+gVv95k7idYEHDXfJqId4=;
  b=IDV5Z9q2zGRyJMptwCSdpLKufHSC6S3EICGuu5pZQUcXOF+OO7/7jAg6
   ZuULHSqArO7lNzFzBp+gKW0buFf3WqZ9xDJvEDht+8Qinja3MCR+TZBLk
   lN5ydVQZTEvoT+QdmTl35LwBO0e8Et1JuZlJWBDeoXdjpC+TV5aLNJrrx
   xpo29FflAQ2j/Rog4GBhpXi4zyUydk5mRgpW6Q76CgzPn90vM3bfoKWg6
   q81sovOb+l4W+XfxtIpeh3lA9y+UceLBcsIpks3fpMP1YhDKS5XMMirWQ
   Jtvd1XPrTkCmZcUWLG4lduB+GN9RKygusPJkrKfmnj9pw8IZQPqPOH/yN
   w==;
X-CSE-ConnectionGUID: 7saFsKYGR4SvamrLHiRJ0g==
X-CSE-MsgGUID: s7MWmYrhQT6zePb9eeAhlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21556625"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="21556625"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 09:31:34 -0700
X-CSE-ConnectionGUID: cKrabQ3FTJKDogFnpXOw1A==
X-CSE-MsgGUID: CsDYyF3HQtaOauHDL4XeEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="63562015"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 09:31:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 09:31:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 09:31:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 09:31:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 09:31:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxjVqpd9iWT04fEF3PDC76/JFr45coOxlwBxRGybDOs1pzLFJk7GDn1fxvTWBfHBlWYfEc6IMYGpwFJcs7wp7Nv7Aad5I2TIj4Q+cneIizm1LV1XHu2JqmNlU7DY9yZDeQcLbru8cgF+U+RhCAPxP/c6+9N699gDWjmJWvmdoWe0fr6Xjyr+AWNTdlyzy/LrkFa4Cx7I6XfXqAD+dIqsAUHIey6tJcBJr1WD+xhnWr44yrqxA1bTpGdZNVgfW53egfces8LQWfFzUWB3P9uxiymJY7Pb0HmNLI3iqfpdsOKXB0fd3lETgg/zh5s2SdtcTZU49MxX5X4nxkKHq068OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKpM6PpHRWRQWyTF0OmA9R1jv/B3Uh39Ged475JJU90=;
 b=NPzLNGrPpHNiel6s7BsSDdfm/rAKRax4bLPEv9Ne7P14np2yNF/tVqw2SrqGAemQNplMw/oXfZXbc72LZYae5el5zbrd/L4LAQqIG48eGGrXAze703C+apOR3mILl6mdntYIEaoLttG3s/7s0rlsfWxi73cz1mBkxOkqxJiu5D7w+5R/mfuMex80+Uhq0Bi6WPbuHYLKgw5FKYBa5P4E2zH24fK5M5xF+63AP4fz4Y75qyhqFw89r/2yiWdzOdI2/mKpIs0F54U5QdH7ttmFqJPFrVrntKMyCpysuhUJEKDHAg9+8xCf61B5Z6r05p6lNVrxGoxxf31wXFUY4EyNSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA0PR11MB7791.namprd11.prod.outlook.com (2603:10b6:208:401::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 13 Aug
 2024 16:31:28 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7828.031; Tue, 13 Aug 2024
 16:31:28 +0000
Message-ID: <136cf827-d1c8-42c6-a661-07f547e82c84@intel.com>
Date: Tue, 13 Aug 2024 18:31:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch to
 GRO from netif_receive_skb_list()
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC: Daniel Xu <dxu@dxuuu.xyz>, Alexander Lobakin <alexandr.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Larysa Zaremba
	<larysa.zaremba@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	"toke@redhat.com" <toke@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
	David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Jesse
 Brandeburg" <jesse.brandeburg@intel.com>, John Fastabend
	<john.fastabend@gmail.com>, Yajun Deng <yajun.deng@linux.dev>, "Willem de
 Bruijn" <willemb@google.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<xdp-hints@xdp-project.net>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
 <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
 <e0616dcc-1007-4faf-8825-6bf536799cbf@intel.com>
 <ZruJfencxeR8XHdm@lore-rh-laptop.lan>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ZruJfencxeR8XHdm@lore-rh-laptop.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA0PR11MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: b87b70fd-ffee-45fa-3314-08dcbbb5616d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTl4ajVuN0ZnVFZvMHJoTStjeG1uWllPQmRvbjdxbHZuRDN2VzdNVno0Ulgx?=
 =?utf-8?B?MThRZE9LZ1FqSWdWMHdJaDMrLy82RVF5SWNlT0dUSThyOXdHSmptY0dRRnFz?=
 =?utf-8?B?ay9hSzJnWlFxSDk5Z3pJc3g3WlZuVU9CTHBEYlp0aWZYV3MxSnZyc3dsc2cy?=
 =?utf-8?B?dVgwVHhSaUJ0UmZnMitiMDd6L2JBazBLZWs4VVcyMmVHNENsRnoraFNNWERJ?=
 =?utf-8?B?Nys0OW43RU1rVWNOa2ljOS9hNFp1YkpVSzM1RVlTTWJzWVNEU3BUOHFkZUpS?=
 =?utf-8?B?cll4RGNJNWt6KzlTaXNpTi8rWUlMb25zU3EyRlJWWEpyWXBFT2VEOTRncHhO?=
 =?utf-8?B?eHZwSHF0V2d3VFo2RjNQV0xPYnVZNFMvOGx5MWJHRDJnK3RDSHh0eGhCMWVy?=
 =?utf-8?B?eHJlbVRWa0NOVXQvTWUwREpZWCt0Q0lQUE5vbWF3b2dFVjgrTXMxU1Rud0dD?=
 =?utf-8?B?L3FubGRjbGFWbzB0dllKT0FSd3c1eldkUGFjdjVtZFhqdnQ1YTRLRGk1MmFi?=
 =?utf-8?B?UTZJTm1RT1JEeS96RloySDlrWmJtZStJTE03dTY2T3Y0SlpORlpQUS84dzhN?=
 =?utf-8?B?NVFEVk0rekxDNmVZQnA3amhvMEtHMS9hTENkOEgwMm1TNHNNWVM4OUxLR3Vi?=
 =?utf-8?B?Mm5DRkZjYU5qYTVrVFFPNzZmdVZIMWhvSFg4cEFHdk53aUVjQ0oxdlJwdjNT?=
 =?utf-8?B?R216ZExNVldtamlNaEU0ZTVnUlNqYU5wNGtYVldzbFR3ZVQ2ZkMwYWxUV0Fl?=
 =?utf-8?B?YVNVM2VyRHFtQWtNYi9wYlhWVDJWMzlZT2QwK1IrZTYvOWdJQ21FNklsT2N0?=
 =?utf-8?B?ZUdBSko2TmpXd1poN1AzZWRWTnM2Nm1KMDFZRTJMdjVXd2kzMkFrNjdCK296?=
 =?utf-8?B?NXpqandyMm1EaXJjRWV4aXdJai9jOWpjL0JsNjBjbTArNFB1QWVmVmNUdndT?=
 =?utf-8?B?YWhpUk5mNmQ4RGtCREZuakpsL1FOdjhKTHM1R0UxSWxCbmFzSmRkUzdTeXYr?=
 =?utf-8?B?ZmtFd09zL2JWQUVQTnZZQ0psRG96cWZ6aXFsZXRJTTNFbFY2NGxpZ0ZnK09u?=
 =?utf-8?B?ZTFEUHY1ZjJOOFlTUmNpeWtpVE9WTWhwVGkxblNzOUxjM3FPWWZYUjZ3RFpp?=
 =?utf-8?B?MDRJRmR3YjlSdEZ0SEd5WlRhT25LUTlSV3ZHTDJLRFdmd0RIdGoweEJrL1gv?=
 =?utf-8?B?dW5lSFdLNDVqUGxuZjZES2xvcFJrWnYrdzE5bDZiYXNNM2xYZyszN2h3cUR4?=
 =?utf-8?B?NTN4YWwydUlqK21mbVFmcjI5emJUSmQ2WnlESWRHVXhMaXdHNXlITW5xLzg0?=
 =?utf-8?B?UVZ1dUxKLzAwL1hVdWVYSHc2YUp0anVQMmdCU0hCN1k5UXB4bGxzR1g1TTls?=
 =?utf-8?B?VXk5QkpNRFJTcFVXdFZrUEI4cWFhL0hTdngyYnhBUjBKOXZkZzNiblowelNF?=
 =?utf-8?B?K0FCS1d4SzZuRTZCbE50N3hGckpQdTZDaHdmRkFCN1RDQjdCZU5lNThKTlNM?=
 =?utf-8?B?VUY2NWFaMmxwVWg4dVdGQVJYWW4zNFg1dlBJUWxuTnRUMnF6MlBLRDRiSEp6?=
 =?utf-8?B?ajlLMEZtU0ppQU1FMExML200NnNMQ01tckhVYjZGRllVVFpRU1FGYUtuRFVp?=
 =?utf-8?B?V0lNUHJGTVo5VkVBUVZVNVFYZytVeUtkRDF2eGhRTUthbTN1eWZRakRiV0pG?=
 =?utf-8?B?UTl1cWsyR05aMjd4dUp0K3ZqaGxyWUN5VDFsdmdMME9JbkhxWTlrR1QrZUZx?=
 =?utf-8?Q?Djd6UOihf2Qn0vojf/xi4XV3Cqav+Y0ffBtDe6m?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDF5UWJ4MGx2Wm1XLyt1dlcyT3JCeldQdzU5b2FQU1pOK2NnTWhoTS8wK0NE?=
 =?utf-8?B?UnRVa1RLbjh1TjRPckIxa25QNEpHYjFoeDRnVlNHdlZVWVZCQ1Y5SEhic01U?=
 =?utf-8?B?eGhkV2lFbmpPRTlzaGw0aGtSenFPMXoyRi9zS284akNXakdQS0lOMmVmeC9J?=
 =?utf-8?B?WUlWQjlBUE5rNGQrbkhod2hKN28wVVVaL0huY3BPdy95ZVVkUXBjMGZ0c1I1?=
 =?utf-8?B?RVpMTGRvVkZFeFZNWE1GZGRCb1Q2VkxpL2hGSmk1Z3F5ZktuTkxMOXU3UmhH?=
 =?utf-8?B?T0lhdXdVSzZ4bUFlMnk1QmxaN1R1ME5DVjlBOGJabDVTaUxqallxLzQvNDlv?=
 =?utf-8?B?Y2xHazRvdHhUc2FBOTNxVDNCL24vM3pSeWNhMHYzZU8rdCtkU09PbGNIYTlJ?=
 =?utf-8?B?dmZ3b2ZERlhzNUJvVzQyVUdCNVdicVlQV00vYVFuQU5iQ1R3bEs4OVl2eXJK?=
 =?utf-8?B?Ukx3cnZ5dGlNYzVzWHc0RFhzUngrdys5SkgxNGh1U05yT0dpVktOSk11UG5l?=
 =?utf-8?B?ZWdXNWp0Q0lUeEhwQm9uU1dvRjV3MnBnK2ZaNjBCVUhkeEo5MUR4QWdhVTdn?=
 =?utf-8?B?SnVCYlhEV29JV1FFNTdkc3czV2Q3UzNIanZIdHBWbXN3SzVneTNtblNXdkta?=
 =?utf-8?B?Wko1UGtodFYzRHdyeWxjQWRFUmIzaFhCSlIzVC9Ua1VheWJDelBtRm11WTlW?=
 =?utf-8?B?anlTYzJTNjNHM2RPMStyOEJxRm16cHA1NFFnWk5rcVBmcHBKenBlaHJPaE1C?=
 =?utf-8?B?ZUV2TmRmWGdOdWQyc0FPbERjZ3lRUk9jbkZDVGM2d1lQZWpObzZTenIreE9C?=
 =?utf-8?B?NUdTUFp4OFRkWnJ0YWMvVFRJYnVtUUdYT2dFTHNoSWljY1NURXEvdjlxb2NY?=
 =?utf-8?B?QTB5cjNPaTJHTGRZVlFNSFZVdHVKK0o1Vjl4NXBqL0plNk1UV0JZUTB6M0p0?=
 =?utf-8?B?MnMvckJ1ZTJBMEtneGtZWitJZ2dvcFVteW92SDhWSlRRUWFLNU0rbXpaWVZQ?=
 =?utf-8?B?RmhNTjlVYVhmMXBxcDIzU3BKdmJSaVpBS2x6dy9ndDYzcWhta3ZRY1FKaGxo?=
 =?utf-8?B?cU9CRUloQU5ON29Udk5xd2hKRlJacFh4dWY5RVFqT28zWmk5NU5jZG5kSDI5?=
 =?utf-8?B?d0IwM1NYNWsvbVVhUVBmMG5uMjhFbk11T1RjUW5FemxKZW11NExVb3AwOHpK?=
 =?utf-8?B?c1d3NEpxd3NlNVFkTThCM01qdTNka1ZiNnExcURlR1I3QTRXdythajFJcmNY?=
 =?utf-8?B?SEhwVVJLdjd5dFdGa1Q0N09Tc0w2REEvbHNSNkhVYmMzLzNXcCtYQUg4ZmUr?=
 =?utf-8?B?bWliMDlBcFpYdXZ1ZlJzOUVTVE5tYlF1RmtVZGx5d2wvZk5uVzRUT3VndVhG?=
 =?utf-8?B?Y0pNaFlnK0FCWmZlaEx6QzYrdElmeXY2R0tvQzc4MSttR2xOaHhNdHpxR1Zu?=
 =?utf-8?B?MXNneGxHajFWNFEyMlpxNWRTUFFHMmpCazR6TENlZjN4TmZOV2FrRVNSSWJw?=
 =?utf-8?B?aGVaM2ljWXhESE9BR3BJeHlucW9YZUVXOEg5TExFV2ZicnluclB0QTVadWs3?=
 =?utf-8?B?dStEd3FUcVR6ZVJFa1dRdGxTVXkyd2drOFk3akEwYTNRbDJpQ00vcXdQazVQ?=
 =?utf-8?B?L0lBZGY3emhWY3lyZE0yN0d1SnpiVDZYMTAwSnZ5QWd0b1QwWTBmUDBuanJk?=
 =?utf-8?B?bXBPblpjN2Q3YWJ3SGppTTBwaVh3QUxjN0FodGNmMXZHMXR3WVhWcWlVUUd3?=
 =?utf-8?B?dG15RG85NVRqT1RWRlpTenNwUmRBOE1OY3lEa1lGMU9XQkt2ZGNYYktQREVY?=
 =?utf-8?B?cDRyTFc1SVg4alJkUGlKd1dNVXVtNXBubGgrRHNlSkZSTFh3TXVUS2VXcWZF?=
 =?utf-8?B?aHhqc1dNRW5MTzcwTnpKaVdTSDZ3dTZmUHNDN2x3NDRXbml1MFVXTHRrZUts?=
 =?utf-8?B?VTFicnF4TXJEbUUwajNwYW1sWXZPaGdYUEwyWEVEVU9JWERHanBpWnMvQVRH?=
 =?utf-8?B?cGdwZzRuWUxzb2Z4Qmc4MU13MmxIM1BKQjZqNTRxbmMyY05hb1Iva3BnQ1NN?=
 =?utf-8?B?aHhtS3VmaUpYMmVuZGlTYXR1RFcxNnRHQUUrVVlXbEx3VFlzQTBKcEVKY2pn?=
 =?utf-8?B?OWxJMG9hVFRjNVVqUVBHdU1DbWJGamVJejZacU9EQnloQ3ZVdUVVeVZINnJM?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b87b70fd-ffee-45fa-3314-08dcbbb5616d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 16:31:28.1062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/kZQg3cEoH4eQ3ocNUNwV+zcxIACqS9oR0IYPQQpPU3f+OpKr+94UZMdBSk6AAtzTeLwZDKP68/Uo/9NaIxr0O6BgDkCLK+cH2YGluitc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7791
X-OriginatorOrg: intel.com

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date: Tue, 13 Aug 2024 18:27:41 +0200

> On Aug 13, Alexander Lobakin wrote:
>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Date: Thu, 8 Aug 2024 13:57:00 +0200
>>
>>> From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
>>> Date: Thu, 8 Aug 2024 06:54:06 +0200
>>>
>>>>> Hi Alexander,
>>>>>
>>>>> On Tue, Jun 28, 2022, at 12:47 PM, Alexander Lobakin wrote:
>>>>>> cpumap has its own BH context based on kthread. It has a sane batch
>>>>>> size of 8 frames per one cycle.
>>>>>> GRO can be used on its own, adjust cpumap calls to the
>>>>>> upper stack to use GRO API instead of netif_receive_skb_list() which
>>>>>> processes skbs by batches, but doesn't involve GRO layer at all.
>>>>>> It is most beneficial when a NIC which frame come from is XDP
>>>>>> generic metadata-enabled, but in plenty of tests GRO performs better
>>>>>> than listed receiving even given that it has to calculate full frame
>>>>>> checksums on CPU.
>>>>>> As GRO passes the skbs to the upper stack in the batches of
>>>>>> @gro_normal_batch, i.e. 8 by default, and @skb->dev point to the
>>>>>> device where the frame comes from, it is enough to disable GRO
>>>>>> netdev feature on it to completely restore the original behaviour:
>>>>>> untouched frames will be being bulked and passed to the upper stack
>>>>>> by 8, as it was with netif_receive_skb_list().
>>>>>>
>>>>>> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>>>>>> ---
>>>>>>  kernel/bpf/cpumap.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>>>>>>  1 file changed, 38 insertions(+), 5 deletions(-)
>>>>>>
>>>>>
>>>>> AFAICT the cpumap + GRO is a good standalone improvement. I think
>>>>> cpumap is still missing this.
>>>
>>> The only concern for having GRO in cpumap without metadata from the NIC
>>> descriptor was that when the checksum status is missing, GRO calculates
>>> the checksum on CPU, which is not really fast.
>>> But I remember sometimes GRO was faster despite that.
>>>
>>>>>
>>>>> I have a production use case for this now. We want to do some intelligent
>>>>> RX steering and I think GRO would help over list-ified receive in some cases.
>>>>> We would prefer steer in HW (and thus get existing GRO support) but not all
>>>>> our NICs support it. So we need a software fallback.
>>>>>
>>>>> Are you still interested in merging the cpumap + GRO patches?
>>>
>>> For sure I can revive this part. I was planning to get back to this
>>> branch and pick patches which were not related to XDP hints and send
>>> them separately.
>>>
>>>>
>>>> Hi Daniel and Alex,
>>>>
>>>> Recently I worked on a PoC to add GRO support to cpumap codebase:
>>>> - https://github.com/LorenzoBianconi/bpf-next/commit/a4b8264d5000ecf016da5a2dd9ac302deaf38b3e
>>>>   Here I added GRO support to cpumap through gro-cells.
>>>> - https://github.com/LorenzoBianconi/bpf-next/commit/da6cb32a4674aa72401c7414c9a8a0775ef41a55
>>>>   Here I added GRO support to cpumap trough napi-threaded APIs (with a some
>>>>   changes to them).
>>>
>>> Hmm, when I was testing it, adding a whole NAPI to cpumap was sorta
>>> overkill, that's why I separated GRO structure from &napi_struct.
>>>
>>> Let me maybe find some free time, I would then test all 3 solutions
>>> (mine, gro_cells, threaded NAPI) and pick/send the best?
>>>
>>>>
>>>> Please note I have not run any performance tests so far, just verified it does
>>>> not crash (I was planning to resume this work soon). Please let me know if it
>>>> works for you.
>>
>> I did tests on both threaded NAPI for cpumap and my old implementation
>> with a traffic generator and I have the following (in Kpps):
>>
>>             direct Rx    direct GRO    cpumap    cpumap GRO
>> baseline    2900         5800          2700      2700 (N/A)
>> threaded                               2300      4000
>> old GRO                                2300      4000
> 
> out of my curiority, have you tested even the gro_cells one?

I haven't. I mean I could, but I don't feel like cpumap's kthread +
separate NAPI then could give better results than merged NAPI + kthread.

> 
> Lorenzo

Thanks,
Olek

