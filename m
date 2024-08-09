Return-Path: <bpf+bounces-36770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E471594D0A5
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 14:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5055BB21BCC
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 12:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045ED194A5A;
	Fri,  9 Aug 2024 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cX2pgnBa"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3618193086;
	Fri,  9 Aug 2024 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723208182; cv=fail; b=nGXbSXvVaR+5s++IK0cNoJ/5NCsQD7jxzlVmiI9NSVm8pGvbazEZ7byXYizm5aIfVBZZdgxhwJaHsi1+3P5kUbcMifJu2vU7+Jq0dcJ+Z8E++oVi2DXLsjWjXfEOC0QaQLnSxWzh5Pyqe2nk+pnDEIYUmE+XZP4hwWQ567MOeK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723208182; c=relaxed/simple;
	bh=qur+LIewN2Mb9OMx8DrYuSj/3q5UaYbpl/u2+RqWY58=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ff/xI6LB+I1rPUCv9ebKnaLZYvur+c9HBV1OvYsL4W8AOchnkEZ0yBolGPepJrlcZsy1IDg8OWM86NRVPTh6epnudryBjY6eQHN+eh6zflNNdXvZ0LoAzXLbaWCiQLl01iK9nI5x7WQOIwrhGpMu0GnztU0DC8zdFRPM9bwERBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cX2pgnBa; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723208181; x=1754744181;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qur+LIewN2Mb9OMx8DrYuSj/3q5UaYbpl/u2+RqWY58=;
  b=cX2pgnBaJPzvmkFynX51yOiNVvUyMME9iBocQiGk7A1QEOQ7WAJN3pwl
   Zfe5eNGJmyrr5xu1eeg3mABIFrZ5LkKJ0s9URHiSGIBtHa90a+f0uAqgC
   M2wTxKMQfceX6GH3nHIZhY6EN5s/JXxlF1R8aaVHSSw+fAp47P3soPOa0
   b/fFJILX9o4VmOt8zt0Rs5n1DFwBkJF9k9TwkzZLyHL6GzcnSw26G7Kw6
   dzRysqbBRVmdfo2BRYCddmD2pEi5DdNLDFGvq0HJ77TskHNx7aAAb2f/M
   9vB2EdEU37simFgAPFsEsBceQxQ0I/DW3fIulWdZ7YEEgMPtUyqlMAFwg
   A==;
X-CSE-ConnectionGUID: x1jMsWw7QFKD+ZvO5kRXOw==
X-CSE-MsgGUID: Ne/ECT0ZTkKMdd589WKI2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21522408"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21522408"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 05:56:20 -0700
X-CSE-ConnectionGUID: npzZCW+ATFeQkC3YJKmKaQ==
X-CSE-MsgGUID: oKl+2FBbTk6dorDlmu9quQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="62403644"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 05:56:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 05:56:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 05:56:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 05:56:18 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 05:56:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pl2DPmaAzlHrrcthE8+/FNXUoAs2IyfkHJIJPg+u2Q5v+t5BoOMuudrVumXmSIr9eYdCBZxPwjNJdj1hWHYsB85zUTHE26eibNjC5PSoXG1mzt3KEIu/ek0xFpjr/mAxdRB6vjP2pk92czhi8SPwCS6xxObL1Lfu2HfXggUKcvSRGJQP7mR47s8npDCUS5i9OQ+asgqDOH2Hx8pWVi9qIrD9dI0PJixYY4HT94pdCZgVJFl5x7Q6UWYGZTB+w464Jsn/rjgaEXIJeMfrxyFqsfxgfBaWUQuplTxTHhF9yig7E9ScSDgrg4EPEotrnrzwkVYhPp9Fy8/zXLdsMmz+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBHQPMychk0aQWUKA7uKpU4VfczBxWliCO1sTpon8gg=;
 b=R1lQx+13Mo3GjBbr7gezN8ZXs+E55HpyCeUQuLqLIdXZxEPeXdV7RCUZrwfAIFF1jPDfe/1BTu0WDvPK4U1qit69OpqtmckGFKaQUntBKkHP34kIv7W4QLlk7r1jjCsx0zNbqxbuQjQtzs8HIcMgSpJlpoO+de+rLCU0YIUzOdtZzgBj2JmT/Uo9i/TKxLRelALdZQACPoqT7UlNQ7/JIJIB3IX+GjUOg6iDVfrzZoJnHv+Vl0WAYS6AlBzDgH1+692+Khkt2UFgr/uSLugYPw65NEHTNmKSxMyoPKNr82eoxr921SoayUcs+kl/UaUXPLrtLhysmGQ25AGbFE61Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB5827.namprd11.prod.outlook.com (2603:10b6:806:236::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Fri, 9 Aug
 2024 12:56:15 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 12:56:15 +0000
Message-ID: <22333deb-21f8-43a9-b32f-bc3e60892661@intel.com>
Date: Fri, 9 Aug 2024 14:56:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch to
 GRO from netif_receive_skb_list()
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
CC: Daniel Xu <dxu@dxuuu.xyz>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Larysa Zaremba <larysa.zaremba@intel.com>, "Michal
 Swiatkowski" <michal.swiatkowski@linux.intel.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	John Fastabend <john.fastabend@gmail.com>, Yajun Deng <yajun.deng@linux.dev>,
	Willem de Bruijn <willemb@google.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <xdp-hints@xdp-project.net>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
 <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
 <308fd4f1-83a9-4b74-a482-216c8211a028@app.fastmail.com>
 <99662019-7e9b-410d-99fe-a85d04af215c@intel.com> <875xs9q2z6.fsf@toke.dk>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <875xs9q2z6.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e8bea51-0c04-43d1-9461-08dcb872a727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHhudUtVZTE2N3hKREc1cEVxbW9NNXpqTDVEWWFGWm9vUEV5N1NGSzcrRVQx?=
 =?utf-8?B?SEQzVXRpNlRRdkFhaGJ6Zi96ZnlmZmhqeWNhRFM5NjBCWjBCWHJybnplbjBX?=
 =?utf-8?B?Z0UyWmxqbmR0RTFZekV6MStBaFhLa29XWTd4RkYxdFczV2NwbkhjaERROGdO?=
 =?utf-8?B?NG5kTTJESlVsNFNML0ZTYnBQMkVjWnRsb2hNK2ViUVYyRlRTOE11amJQdW1p?=
 =?utf-8?B?SnV0eVMzUzlwdlhrTk8xRlNPTTJyVHVrVW5XVmN4clp5cHF6aUNKem5XMnlx?=
 =?utf-8?B?cHQ0MEZ6QzJQMktuOUx1dUxkU2M0NnIxWUhZMHhWbzBqTGdIcm15STh4ZUpF?=
 =?utf-8?B?dzVxWTdjQ3c2L3NQNjNGMDNJcDQ0RXZvb2w4ZXQvbFZiakJRK1p2UWxLc1dV?=
 =?utf-8?B?Nm1qVFF3bGttWUhsdTJRZ2Qzd1lVNWZwSGdZaStUOC9qbHJjaE42RFFMUUQ0?=
 =?utf-8?B?V3RubkhwWHhtRjYzTm9HYTNKenlJekRWY2dGNkVycXdWSXlmTitZdExlQzR2?=
 =?utf-8?B?bEE2M0RpbVl2VVprY1g1ZytFSzNjSHlZRngyNmJBdnp3UWllZjFhTXBPYlZp?=
 =?utf-8?B?YXlyZ21aZDJnYXFkMXQ5QkkrUXNKNWQvZmJscXZiQlNIeVRtWHUvZUt6c1lX?=
 =?utf-8?B?cmRacU52NUpJYTBzR2I0azNCSFZXaktsNDAxbjZuM1ZlTTRTQkdXQWtnZ0tU?=
 =?utf-8?B?VURvamt4b2NXQVBISCtjcWJMRHlMWGVaSkFFZmsvRzkrNkc2VnJmc0FXOWtx?=
 =?utf-8?B?ekhoR0NLbW5Oc1RPWDlGU3AzUDA0cmdsOUZNSC9iOEs2T2hDVVM2Vk1lcmJU?=
 =?utf-8?B?RXdzMXRIV2R2OXBWMWZsVEIrSU5SR0NVdDgrUVVDTDlJaUY5c0pVOE5CU0Q3?=
 =?utf-8?B?TkhhVVpsVTJTVHFRZHMvek9JTmFvSkZ1SitzSHFuWlVrMmdIUTNSS1pHeW0x?=
 =?utf-8?B?ZVlBYTE1RWJFOU1IV3QyZ1hibjhJbUJwemRSd1FXUDVFeU1RWGtCR25rbGVH?=
 =?utf-8?B?SXloc1FhZ3N3bzV5TWZjR01mMVgwLzh6VVFUbjdQenRUUHpRaU9JMXVNNFE5?=
 =?utf-8?B?WUNsTmVPRGYvenJwcWhnbk91SmtyNFV2Tmw2MkhDOU9YckFWd3dOWGZqMzVj?=
 =?utf-8?B?SE4zTkVqTzZTUnJSWVFKOXpoUEY3ajBKU0JOS21zYU1WcFlWTitHOXhZVGJs?=
 =?utf-8?B?M3dZWEM0VzJHVVpyMVUxV2hrc0xpWGNSNVpWM2o0czk0Y2V6VVNRVmdEdFd2?=
 =?utf-8?B?bW5NT3V6bWFVcUZWZjBIR3p1UlJZSUZNaGRCYmgzNmk0SERzeHhIdmJZaG15?=
 =?utf-8?B?YmpkdExOUHJtQWRtaWtTdG1EekVUcjIrT1I0a0FzYXYwM3VTTktUZnBSc0tE?=
 =?utf-8?B?NVExRVlveFFDTDNSRWxqSHA4UTVDWTlldGlXMFdEbnEwZGw1KzJIcGRFNjRS?=
 =?utf-8?B?ZTQ1RUpldjA1YmRScjgxb3N3UUpsVTd3UTg5R1JyMmhLVGdubDEwTkN1ODlX?=
 =?utf-8?B?OThrUzNVS0ZsdlV6WXdtQkZ6QWxmZDFwbnFQN1dLUWxMS2RZMWtiMisvQ3pS?=
 =?utf-8?B?OFpKZmhVc1E5YXhubitLeEE1K1hxQ3Zmb1R2SXRaK0tJbTRIRWVWZVpRQ0ZW?=
 =?utf-8?B?NEZ3VlZ6VzBRaU1YN0tzUGNOR3dSdkQzeWQ4TmkxSWFzNEF4cm1lNnZWSnFr?=
 =?utf-8?B?VUVzY3ZhUEs3RHRlMGlMN2JYZm8vMThmakJZSkNWcFdoeG5UMG0rZk84V2lI?=
 =?utf-8?B?UzIrbU5COFpOZmNsVDR2UUtRQmFXSGd5UGR3MlpENVpXNmhSRkpVcjZ5TzlN?=
 =?utf-8?B?R2grT0ptUHA2NmJYT3EwUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTM5NEhZb1ZNRkJYTmdDY1hqRTI0cmtKcTFpa0VHWFoxREpHdElGSWJ3S1RO?=
 =?utf-8?B?eFZGTFJEVVJXSGtoLzhVZzBrakdZM3RveEt2UEdsdnNZUGhuOHh5c3pUK25H?=
 =?utf-8?B?RGpxWVpqd0dvSG1YOG1SUzF3WTV6c0F0WUQ2T21YSGtpc0ZKNmdPSmEyQXBB?=
 =?utf-8?B?ZUNtOWpDMWVadm9WVjkzMmtwdFVvWXBteHl1THN5eXhKdktXWVFhRU9rTGZo?=
 =?utf-8?B?TFI5ZVFXNmZBREpvYWJ4VHdrdkpCYWs5aHRocjVRMHpraGxQS0hyYzIzR1k4?=
 =?utf-8?B?M0xrT1M0MnVSczlPdlpFQm1LZis1UmNPRjNjcWtNbmRad0hkWG8xMmlNVE92?=
 =?utf-8?B?ZjZBclNDSm1EUEFKdDNBbDJGWXExTVVEWkNpK3FhMGk3TkthbnFkb2Z4N216?=
 =?utf-8?B?ZXg4d2EzYSt5TGxtSTd3ejByTFIxTWZZdFo1Yi9zMXdlbG15cWcwNUNiSkxN?=
 =?utf-8?B?TFRvemVvWkJvUUFFMHBoZkoxa1dMaGJvcEJZZGhKRUc0THNWbHd3VHlMbXAx?=
 =?utf-8?B?UnM0eUl5cEdCZzNQb09qbmZGMng0T3o4QVkrQU1uVVVVRmZ3dktaUEpKYng1?=
 =?utf-8?B?VUx0T3ExMzVYWHQ5eUZqTFhlNVhBbytSL1FZN3lTMHF1TjB6RkRuVEFNd3JR?=
 =?utf-8?B?dGUvQXFJT0dlS0ZpakM3L3doR3hFa3BPVEoyUXpubnJzaWdyblJCSHNITnBW?=
 =?utf-8?B?UGJkb3B0RysyQmdxSUloWXJ0dGhiSGNZbFBteHIyYUR2V0k2WXJpNU83bW5Y?=
 =?utf-8?B?TGwrMFJ6RVo2c0JadkhibFhVUmxRK0NMUXlMdjFQTUdYSGgyaXd2b0Nic0F0?=
 =?utf-8?B?b0dITjFGR3YrcTF0RHMwaHF4NDYzR2RrRSt6VDJla3hXcElvT0kvalY5U2xu?=
 =?utf-8?B?M3R4Wkk4b0hrbjRoRjZmbU9hS3pyRlJTZVZKWTA3Qm9lL3JoTVNvTTNtVzFU?=
 =?utf-8?B?MWNSRDNxMEkwVzFXbUU3MGI5ZkU2WVgybjdFRG1XWlcrZFBScjd4cnd2UlBE?=
 =?utf-8?B?dWJBVkdNNU5lOVZYNDhNNTVOZDFQMm1TYUhPQ3RrQW1BUDBoM3dCUUU4VlFQ?=
 =?utf-8?B?djJqZGRHY0xBZlBzQ25GUkp5WEk4OGNMTVJvd3ZWdXdrSkNuVzdEK2NUQzFp?=
 =?utf-8?B?MVF5a1djKzJtMkd5dG5VbThDV2h1YzJhYmQ1ZzRZeUlBbU9teUExa3NTdlcr?=
 =?utf-8?B?c0F3NVI4dGNKMjdjRU5OdWo1R1ZjNG0xK2lKYlUwNExMUUt2RXVWZHQ5RFZv?=
 =?utf-8?B?SGpnTW53NlBJbHFYUTZnZDVpSDF4UFAwSEdVSWtORytRSDRmYXA1VUN1bmlq?=
 =?utf-8?B?dFh2eW55SG9hSmtxV21rZS9pSDRPcnNmVzR5SWxud1VkNFd2TE1BRS9zdVNi?=
 =?utf-8?B?Z2VPUHRFR0I3cGxHZm5vaXNpWWNsVlYwbmpzZUd4NG90b1pjTElOZng4OWdG?=
 =?utf-8?B?MzdoYkpGMWM1anlvb3pJUHFRbHVtdDB3S1BFcEUvM3NtVlIydjl5dk0zN0J5?=
 =?utf-8?B?TTNHNnFUY3lOeFQxcFZmSmQwb0l2dFJVY0Q5dTdESzhya3huOVZXWnIvZHlm?=
 =?utf-8?B?UlNyVVozVmFHTVRZVVFSM2pLR0ZYSVVheEQwWDJwVzIzRHJvUUJrRVF0eXp1?=
 =?utf-8?B?ZzNUMGZSV21BaHVSQzg0eHV0YlcraEVFelpOcTJqK2Z3MU5lai9zV2FyWnl6?=
 =?utf-8?B?QlFyazZpNng1QUpiOEtSTmU2dWtHaThpZFhvV2FDUjFtaHc2YXNTSENTUE5z?=
 =?utf-8?B?eE9QZzg4L2NsYlV0TjVIUE14RWN6dGY0aU83TVZmWVhzUUE0R1hVRGJuNFd2?=
 =?utf-8?B?bVhNbEgycjRkbmo3TDhzNlBkVGc1RFcraU1YZGJWaWRNVmY1ZEkxSlRMaDRR?=
 =?utf-8?B?ajJxVVdiSHZWbzBaYmFQMXpwZkpHbnpreWdlMWE0ZVNOVUJCcVBhRjIxWlRL?=
 =?utf-8?B?cFJCdU5QV1lOZ0dNOTU3TDRpU1o5bEVxcUkvWDJiZ2RpeGRxUkxaUUx5bzYr?=
 =?utf-8?B?SkhQYTJiZnVmOWdITnhNd1ViYlFOazU5aHNadGJqUHdUclZwMWUrdUM3bHJ6?=
 =?utf-8?B?ZzRMQ2sraEpRR2ZHNjlDYXVmcnNhVDY0Y0p4RHhTL3lXTkcwY1N0ejdnMXNR?=
 =?utf-8?B?eXRRRVRldVQ2aW5PN2xOdWlWYnF3WS81M3NnR2F5Y01iUHFwcmthV3A1NFhj?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8bea51-0c04-43d1-9461-08dcb872a727
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 12:56:15.1324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEUGHF9JufciCnjTRMKnY1Zzo7KF+ZAesSnCHvMW1e7+DRBKz/B+iuiMYc271a/+OcWG0Ba63pG9PSGUlBvUAlr2pfQEvlSFF2/4f3wD1f8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5827
X-OriginatorOrg: intel.com

From: Toke Høiland-Jørgensen <toke@redhat.com>
Date: Fri, 09 Aug 2024 14:45:33 +0200

> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
> 
>> From: Daniel Xu <dxu@dxuuu.xyz>
>> Date: Thu, 08 Aug 2024 16:52:51 -0400
>>
>>> Hi,
>>>
>>> On Thu, Aug 8, 2024, at 7:57 AM, Alexander Lobakin wrote:
>>>> From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
>>>> Date: Thu, 8 Aug 2024 06:54:06 +0200
>>>>
>>>>>> Hi Alexander,
>>>>>>
>>>>>> On Tue, Jun 28, 2022, at 12:47 PM, Alexander Lobakin wrote:
>>>>>>> cpumap has its own BH context based on kthread. It has a sane batch
>>>>>>> size of 8 frames per one cycle.
>>>>>>> GRO can be used on its own, adjust cpumap calls to the
>>>>>>> upper stack to use GRO API instead of netif_receive_skb_list() which
>>>>>>> processes skbs by batches, but doesn't involve GRO layer at all.
>>>>>>> It is most beneficial when a NIC which frame come from is XDP
>>>>>>> generic metadata-enabled, but in plenty of tests GRO performs better
>>>>>>> than listed receiving even given that it has to calculate full frame
>>>>>>> checksums on CPU.
>>>>>>> As GRO passes the skbs to the upper stack in the batches of
>>>>>>> @gro_normal_batch, i.e. 8 by default, and @skb->dev point to the
>>>>>>> device where the frame comes from, it is enough to disable GRO
>>>>>>> netdev feature on it to completely restore the original behaviour:
>>>>>>> untouched frames will be being bulked and passed to the upper stack
>>>>>>> by 8, as it was with netif_receive_skb_list().
>>>>>>>
>>>>>>> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>>>>>>> ---
>>>>>>>  kernel/bpf/cpumap.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>>>>>>>  1 file changed, 38 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>
>>>>>> AFAICT the cpumap + GRO is a good standalone improvement. I think
>>>>>> cpumap is still missing this.
>>>>
>>>> The only concern for having GRO in cpumap without metadata from the NIC
>>>> descriptor was that when the checksum status is missing, GRO calculates
>>>> the checksum on CPU, which is not really fast.
>>>> But I remember sometimes GRO was faster despite that.
>>>
>>> Good to know, thanks. IIUC some kind of XDP hint support landed already?
>>>
>>> My use case could also use HW RSS hash to avoid a rehash in XDP prog.
>>
>> Unfortunately, for now it's impossible to get HW metadata such as RSS
>> hash and checksum status in cpumap. They're implemented via kfuncs
>> specific to a particular netdevice and this info is available only when
>> running XDP prog.
>>
>> But I think one solution could be:
>>
>> 1. We create some generic structure for cpumap, like
>>
>> struct cpumap_meta {
>> 	u32 magic;
>> 	u32 hash;
>> }
>>
>> 2. We add such check in the cpumap code
>>
>> 	if (xdpf->metalen == sizeof(struct cpumap_meta) &&
>> 	    <here we check magic>)
>> 		skb->hash = meta->hash;
>>
>> 3. In XDP prog, you call Rx hints kfuncs when they're available, obtain
>> RSS hash and then put it in the struct cpumap_meta as XDP frame metadata.
> 
> Yes, except don't make this cpumap-specific, make it generic for kernel
> consumption of the metadata. That way it doesn't even have to be stored
> in the xdp metadata area, it can be anywhere we want (and hence not
> subject to ABI issues), and we can use it for skb creation after
> redirect in other places than cpumap as well (say, on veth devices).
> 
> So it'll be:
> 
> struct kernel_meta {
> 	u32 hash;
> 	u32 timestamp;
>         ...etc
> }
> 
> and a kfunc:
> 
> void store_xdp_kernel_meta(struct kernel meta *meta);
> 
> which the XDP program can call to populate the metadata area.

Hmm, nice!

But where to store this info in case of cpumap if not in xdp->data_meta?
When you convert XDP frames to skbs in the cpumap code, you only have
&xdp_frame and that's it. XDP prog was already run earlier from the
driver code at that point.

But yes, in general we still need some generic structure, so that
generic consumers like cpumap (but not only) could make use of it, not
only XDP programs.

> 
> -Toke

Thanks,
Olek

