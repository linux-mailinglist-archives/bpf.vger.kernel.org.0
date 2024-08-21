Return-Path: <bpf+bounces-37716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DFF959E78
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 15:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3318B23933
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 13:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB1719995F;
	Wed, 21 Aug 2024 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4n4Mbzs"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C966188A33;
	Wed, 21 Aug 2024 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246229; cv=fail; b=bdWzDrZ8imUPor/Io8lPcqpdIsiP9sGLnNMMy8CFTKQOvPKP7LGLsvE1nSwVD7Ouj2vwcXxa65faVYp4GDgnnnzgMFJAmQOhvTBoLfQ0wztKTjEP1PtIvnqw1B/Uv/AM2sqQsJ6gAb3Vt+wj2YRca5mZVm02b9DQIwXOvMPF+HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246229; c=relaxed/simple;
	bh=Ez/DQKKiLrmodG9ojJZO9wnhqAawgX9rqSY0MxbEimg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YAExF09NX6BIypYetjlNKwxwaGrHWpVwr5iry/4ADNgbud6Ch3QFeLnhbDFzxDk2zTpXK5Cznn2HORYxUChN1DGBQmgdxp8rpGbcUdQRTCZSL0CF3/oHxFvFXrvUp8VBznzldi4FYYyFtkLUJ9eqCJA/0d1EoEZSMaTjzLGNXnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4n4Mbzs; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724246227; x=1755782227;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ez/DQKKiLrmodG9ojJZO9wnhqAawgX9rqSY0MxbEimg=;
  b=R4n4Mbzsd1ult7Mo15lmfyc8JcMm6MT0yfRrCpsi6pquPN3ZmZGqEM6E
   azPAQDg6AfyacwVzPI3T+Jdc15egPV+/trouAWb/Fb4nCLcb49p4+T/3L
   5cUhNlwNdJ6oAkAKyDEq7sVqKAoA2Oz8ycTMy8hb+02eX0TTdMykq4pX9
   nBwHJlnHAcUEcPQkmBXkIwZzlO+wUOscBy3sT2sC85CPQ2e68SEWLj42R
   pLzy7RxPpIQdQMlV2YF1bqt+ubIYh+xux5F0UsW9jCWwAsX/kRJWTc3LR
   QUjj0aibUNMLQqE+rzIi5xedxJb4vBtMYJqQRHePUoP9ZMfCUw2FMe7WH
   Q==;
X-CSE-ConnectionGUID: 25HzQAqFSfOnhTIXqhAlew==
X-CSE-MsgGUID: OVySZ+WkQpe+7zjhDCdlhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="26357823"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="26357823"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:17:04 -0700
X-CSE-ConnectionGUID: 4SlCxmPjQKmBH0+bOHOVSA==
X-CSE-MsgGUID: eXgxPqzyTmKfr7yEna7zRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="65779805"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 06:17:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 06:17:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 06:17:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 06:17:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 06:17:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3qlyq+SumWDTpjZUogjRmYM+cXxuRZplWb/jrBRYIv86Kb6S6CLh6g8vbVB4L9wbd8PlUvifSZ5cY1yIfwf1i2G+0ShoiX2QB6GyGFPn+JXjChl/zALvPLtzu2+IG7IRA4sWkYMGC+VwvwLkIebx5xyVuWmsElzjP/3J4DVbPDsRucmlp8MDXG4tY3qv0WDp3sMY645wRfUnajvdHYKq9kvew2kc2dwn3H916TH/RUNrzBdJ0l8fwdJP9SYxuJnaTCfGMo801AwoDHNTLg3b5qgohjPlOlL+n+EAJBljoeeOAH48I1I8IXF1ZvC0lNQZH8t+2+dtYYGZvCgSIjFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edA9hRCn+4y7pqrmhySsstwsWxciddFyOdM9ISPBgBI=;
 b=i7NrP/mOJvDMWRanmuy2AzOBJq4Rg1k4eMzl1z/LXOlviJo0aa+3mCG455Wb0xsIk5Bt7irm+rjdlFMjnECqMEgVTXorbBkhtsuvSkx5zdZJeEudIxzMTdsiyyvo7vXt65dYPpLN788Xy+kpjRLHKERW5IcV2ky0pay3h8OVTC8SZN7Q1zxrqpa6Zu4x8vgd0uSc64zfgEFnpbrDpbGOBoaE1GXzb29d9V3CskYylYAU+rYT8ND5+bgm8z01Quq6onIIhHg3G7qUvqWQsokKjx+9cLaJLs/VW0Y8EqbSfRM7wm8bf/yu9wpWsrRT7qXGp5zfqEPpKhsi5WClAaQXJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB7915.namprd11.prod.outlook.com (2603:10b6:610:12f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Wed, 21 Aug
 2024 13:17:00 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 13:16:59 +0000
Message-ID: <7a91042b-4406-4b99-99c5-6ec1ec7b98d7@intel.com>
Date: Wed, 21 Aug 2024 15:16:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch to
 GRO from netif_receive_skb_list()
To: Daniel Xu <dxu@dxuuu.xyz>
CC: Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Lorenzo
 Bianconi" <lorenzo.bianconi@redhat.com>, Alexander Lobakin
	<alexandr.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Larysa
 Zaremba <larysa.zaremba@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
	<bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, "Maciej
 Fijalkowski" <maciej.fijalkowski@intel.com>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, "David
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, John Fastabend
	<john.fastabend@gmail.com>, Yajun Deng <yajun.deng@linux.dev>, "Willem de
 Bruijn" <willemb@google.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<xdp-hints@xdp-project.net>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
 <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
 <e0616dcc-1007-4faf-8825-6bf536799cbf@intel.com> <874j7oean6.fsf@toke.dk>
 <34cc17a1-dee2-4eb0-9b24-7b264cb63521@kernel.org>
 <c596dff4-1e8b-4184-8eb6-590b4da2d92a@intel.com>
 <merfatcdvwpx2lj4j2pahhwp4vihstpidws3jwljwazhh76xkd@t5vsh4gvk4mh>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <merfatcdvwpx2lj4j2pahhwp4vihstpidws3jwljwazhh76xkd@t5vsh4gvk4mh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0043.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: 2595c0cc-6851-4e8f-312d-08dcc1e389f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGZTTTJaMytkNVY4RUtvaElUMjJzK0k2dmNFMi9sTTZsNVNrQXNpUllhd2hy?=
 =?utf-8?B?VFdHbk1UQnpzUG5JUnhScmpZOUU2WVVxQ3NVSnpudXZoRVJmQ24yZmZJaU5k?=
 =?utf-8?B?aG5udDRUUVpYdDN6K1ZRUllrNGZuTGJYWHdycTQrY0ZYYXFBbjNiNEJVQndj?=
 =?utf-8?B?bjNUVndnd0pEanN5SWIxdG1zSytmNFRqdlF0RnVwQWp1V1ZsbmUxZFJMbDVp?=
 =?utf-8?B?Rmd0OGNDdHVKSGdUU1RQeU5hM1BDZGZQdVB3MUVYR3BHYUlaRm9vMExUY3NF?=
 =?utf-8?B?ZzJjTkM5YUpwU1hWcVJTQmtXanlleDFDMzRVL2d0Mk0wVERaV2R4T0xCOWRh?=
 =?utf-8?B?Um5FTGl2VDhQMG9Kek5ybmF0SnFkMlRmRFNBMnNlK1F3YmpIK0hpaDYzSUtC?=
 =?utf-8?B?RXF4L2tsbnR1bEJtYTNwNEdOVW1FSDdWWHVPSmluQU9FZnJlRVA5WW05Ny9k?=
 =?utf-8?B?cUZIaWtQc0pzUms5SDFiS21FeWZDM3FXbDlkZWpaY1dQYkQwVEdGVWoyaDdN?=
 =?utf-8?B?SE9jR283RkVnbjdyNTVJZUFERHZjVld6dlc3YzlRTFhZUGVYTTd5UUxVbis2?=
 =?utf-8?B?d2FZbytMbmROMVN1a2JZeHA1S2lNWVAzSHcvV0tLOG0xbFJyUEpUSW9UNGZp?=
 =?utf-8?B?ODJaeFZ5WFA0Y3pGSDNNVjN6SHRYdE1KTlNzc1ZkUE02RXBQVlBGektHcklX?=
 =?utf-8?B?SytmUFNQQlZPNlRlRW8zK0ZkZTRGcW5OUk1JVlZYSmJMY0h1UWlQZ0ZCSWpN?=
 =?utf-8?B?MkhacTd6c0VLVHFiK2I4VkpuRE1SVnhEQ0FzenoyZWtkaUlraVY1TFRPWjA3?=
 =?utf-8?B?cUUwUVRXcXRFZDVhaWJYb3c4REhUMFNVWUFURWp0bXdqeGpndTV4UGIxNklo?=
 =?utf-8?B?cGdYbFk0dEdaL3NpUXB0SU5KaGVzQlZqbGRxUFJuTmFDUWg5NVN6T0diUDU0?=
 =?utf-8?B?VWxPZmFJc3hyTzRuZlFaTFA3aHpyb0ErS0VUL0V0ZGkrT3Z1TENFdzYyUk9s?=
 =?utf-8?B?QW12SmMvcGdUa0hnTGQxZzVvWVpYaU1uMEQ1OUJicGxrTU95WjR0Q2x3eGtQ?=
 =?utf-8?B?QytGOEZFeUxvVExwcEZsSnZNaDFYckgzNGMzaEZRZlMyS2YxNW54QUVjOFRv?=
 =?utf-8?B?a1cwY3daMzNaZ29kSUhPWjVGT0JIUTZIbUorNW96RXlyaXcrWTF3dzJQNkFW?=
 =?utf-8?B?emlvQVY5VnJMbmlReG95UzFqUm5qMklJOG9hSmhnMlVtWG1sV243cmxycTJz?=
 =?utf-8?B?SWNiSVd5dXlodW1VKytsUFlyeWZYazROZk1LN0lwdnBlOHV4QUlRUUsrV3h6?=
 =?utf-8?B?V2ltMTcwZTJRREpJUHVQWUU2N0ZJNDAyMFlFUmtQNEdSZVJRNzhwNTh0Wk5q?=
 =?utf-8?B?ZWQ5LzhQSHhWZ2ZzN3ZnZ2tXMUpiWFZvbkNsUXVIcWRHakhJSU9mUUVUKzR5?=
 =?utf-8?B?TlNVOXIxNHpoTVR4NWtBM1c3UVhnVHVTOENkMTlKdE5RSDJ5N2dFM2tsQUlE?=
 =?utf-8?B?eTcxYndmN3dwMUNRZzdjOVV5YTVhd1BHdHdsRkxuTXgxVHo2MmFwRUdFZDQx?=
 =?utf-8?B?SzhsTXFTbTN4YlpHODZBQkE0UStIU2NJK2pjdWtXMTFsQU9lSGI2djZGVWYy?=
 =?utf-8?B?ckV1d0pRclN6WlhONzVER2RFaE90cEUyWUV3bHJHYkNWTTl3bnk4SkhqMDMv?=
 =?utf-8?B?dUJIekVGZ085ckZKcGtZQmlkcDF2QnRJUitXUi9maE9jaDNveUFGKy9BUFJv?=
 =?utf-8?Q?CYy8p5fKS5TqRYjgsU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODE3L3lFUGFyak1vd3lVUEk3a21rY3dOZEs1d0tzMmZYaDZHc2hPYWVSZDJG?=
 =?utf-8?B?UmJXMFJLeHVrc3lRV2RWLy9YUnBhalFOMFluTExLUGRBQnQrZWF4bU5kRHZk?=
 =?utf-8?B?V3hseVczSGo2WUl1UkIyMHJuWldadTRWSFFjdThwbk5VbnY2NlV5THh3YXpr?=
 =?utf-8?B?Z0d2Nm9KUHlLYi9sKzJ3MnZyWXhwWnBnNytLMGR6Q2NMeS80NGw5Qi9hbG94?=
 =?utf-8?B?Mk5yMGY1cjVKYlpRSjR0NzdSb0J5a0E5NEtJakhuOVRTZGg3bGYyZU9TTFd3?=
 =?utf-8?B?VCtpSEU3dUFUWjNNMzRYK1BlZkV2SUlsRkRtQkdSM2ZBTE1TWWpwUEVXaW5w?=
 =?utf-8?B?aTFWTDBtTDk0MitldVdzNWpmQysxL1lQaTUyQVZhUzBRclIrQnZlMWdhUGl0?=
 =?utf-8?B?WmFNTktWNVJZcVVnTG1ScmRBR3RjSFVuVEl5bGg5ZUZPVXBEcE00anFNcnVz?=
 =?utf-8?B?Z3hocFNuTTJJcSs3ZmR0WkZ2ZW9YWFVEcnB1aXVwUUV4dGNWNUNJc3JNdUFw?=
 =?utf-8?B?bEVMRCs0QkQ2c3granBHeEFQNzdWT3pyK2JrRlJQcFJDVWJXUlg1bis5VHNH?=
 =?utf-8?B?THlXaGRLWW56WVgrRWp1cllobWhkR2NxNjJOWm1tc0J5SkQ4bklKUWoxYUw3?=
 =?utf-8?B?ZW1uem5iMFU0NHpITC9PV0dFSHNaZnp1OTBFSVZ0bGVuYkRwRlBIanlhNTFD?=
 =?utf-8?B?TW84RWppOUY4dTRWY1RjZ2p5TTdsbXJ3MzlpUzZBKzJpbzl3eVRuSUwvc0lE?=
 =?utf-8?B?U1BaRUhTUjFsMjIzQXlCOEpCQjlMQlVjS3BGT0JUYXB3NEo4cDFOTGo0VTNt?=
 =?utf-8?B?eW84cnB2MnZDbUR5Mm9EanYxOHJWQzlWWFRaeVV2c0p3cTI3LytQMzBrK09q?=
 =?utf-8?B?eE8rSkdjYjZPME9BSUhURVRHSXNrZjE2UGlDeXVpV0FxN1E0Y2s4dmNybnBC?=
 =?utf-8?B?RzFWeGNmcU1LZDBGTXc5TmxKY0xSUENmY1R2cnFkMTd4NWtkdXpaUlNTeitr?=
 =?utf-8?B?c1NYS2hTRFRBTm5KWjA4WlRUTFRJU2Yya1RuQkcxcVV2SjhmTEk5aTc1aEpO?=
 =?utf-8?B?NW4zTXRSaWtkQldWY3RiK2x2OUFnTFBYK3pyZklJeS8wcmpWemlGZGM4aFQ2?=
 =?utf-8?B?MHdPOUJBeHpNVnRld2tNbno5eXcrYnJtM3EwVjYrOXpJeS9xaC9HeFZRZjFZ?=
 =?utf-8?B?SG5Lc2FnS0dwVWdVRWJUNjY5bXMyQk1wcmpmenpmY3RWZWxrMzRZTENpK0hN?=
 =?utf-8?B?bXBndFh1VEttT1ZhaHRQRURwcE5qcmRMNGhRZGdjYTlwSWJWWGtiUk5nczZQ?=
 =?utf-8?B?SE0xWnExUllpTEpXM2dXcmxUeDFIRmdraEFOS2plMG9iV2Z1anlIcGRlUlI5?=
 =?utf-8?B?OXJReElYRlRIcHNQQ3p3NlhsTE8zSW4zdFFCWXVDbWkvK2ZZK2J4TXFTUHBM?=
 =?utf-8?B?MFFCUWllQVNzYWxpdUx6T3hQb2RROUwxK0lxWWo0eEFTN29aODNvdXNnU0g2?=
 =?utf-8?B?TDkzWVZFSDhpQ0FBTmJxY1hyN2I1aUkxbDRreWxpZVk2VGVIcXRDNmh6L2xo?=
 =?utf-8?B?SXNQdTB3VG9pV2JzRG5ROWV1ZVlod2hCN3kwU016MElsL29zbnNrdEUxem1Y?=
 =?utf-8?B?dlppbzdrcElqRG9LSkNCRkJJYmh6djliNU5LR0hjd3NlVzNsVVl5VFdlc2lj?=
 =?utf-8?B?S05iZFl5aDFQVnlNdlhzb1BPY0tSUmYwa3gwcDVnZ1FzZVBzbmtGdmlJaitQ?=
 =?utf-8?B?bTBTSmNSTWFDb0poK1NMa0RQZUJwakp4ZHRTOFBlN3ZTV2YvNG1aTkY1S0Jp?=
 =?utf-8?B?M2RHN1I0VDZDWklyWGE3MEx2ekVrWUZnd1BmYnlIMUxrc1dMaFpxRGFHa3JL?=
 =?utf-8?B?RUorcnNzT1UvRFVYWFM4NEcybUZzTnVZS29OLzdlNDJXYmgwZTRidzVIdjU1?=
 =?utf-8?B?eUN1Q2xkcXZ3ZmFWL0VUMjJ4OFFhb1h2cVA4eGRCRkVOSEN6RE5NWk54c3li?=
 =?utf-8?B?amlLV3N1U1p3MEl4dXpSUGhBaHpnWnJoL1BLaEJXdkZtYUhtSEIwNVJxekVV?=
 =?utf-8?B?dWtLYmtmSzRVQUlxS3UwUkRWN1QrbDQvdnliRTF2aFNvc1pUZXBlUkRLdDFJ?=
 =?utf-8?B?MUhOMkFRdVBiVEVZd3kxeis4dkFiTE5xNHNkaHZ5Q0VGZVpicHhFeE1ocEdS?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2595c0cc-6851-4e8f-312d-08dcc1e389f7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 13:16:59.8721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opKiDt5c8iFOBcXHeG/Xw5aI4ly39vcgV2/4mcyCGfQGz5fsAYocSceWJcxYegIA61Nk5NwV9D1GmgZ9/Q+gu/jDaUiZD53CJE1+n8/Jl+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7915
X-OriginatorOrg: intel.com

From: Daniel Xu <dxu@dxuuu.xyz>
Date: Tue, 20 Aug 2024 17:29:45 -0700

> Hi Olek,
> 
> On Mon, Aug 19, 2024 at 04:50:52PM GMT, Alexander Lobakin wrote:
> [..]
>>> Thanks A LOT for doing this benchmarking!
>>
>> I optimized the code a bit and picked my old patches for bulk NAPI skb
>> cache allocation and today I got 4.7 Mpps 🎉
>> IOW, the result of the series (7 patches totally, but 2 are not
>> networking-related) is 2.7 -> 4.7 Mpps == 75%!
>>
>> Daniel,
>>
>> if you want, you can pick my tree[0], either full or just up to
>>
>> "bpf: cpumap: switch to napi_skb_cache_get_bulk()"
>>
>> (13 patches total: 6 for netdev_feature_t and 7 for the cpumap)
>>
>> and test with your usecases. Would be nice to see some real world
>> results, not my synthetic tests :D
>>
>>> --Jesper
>>
>> [0]
>> https://github.com/alobakin/linux/compare/idpf-libie-new~52...idpf-libie-new/
> 
> So it turns out keeping the workload in place while I update and reboot
> the kernel is a Hard Problem. I'll put in some more effort and see if I
> can get one of the workloads to stay still, but it'll be a somewhat
> noisy test even if it works. So the following are synthetic tests
> (neper) but on a real prod setup as far as container networking and
> configuration is concerned.
> 
> I cherry-picked 586be610~1..ca22ac8e9de onto our 6.9-ish branch. Had to
> skip some of the flag refactors b/c of conflicts - I didn't know the
> code well enough to do fixups. So I had to apply this diff (FWIW not sure
> the struct_size() here was right anyhow):
> 
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 089d19c62efe..359fbfaa43eb 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -110,7 +110,7 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *attr)
>  	if (!cmap->cpu_map)
>  		goto free_cmap;
>  
> -	dev = bpf_map_area_alloc(struct_size(dev, priv, 0), NUMA_NO_NODE);
> +	dev = bpf_map_area_alloc(sizeof(*dev), NUMA_NO_NODE);

Hmm, it will allocate the same amount of memory. Why do you need this?
Are you running these patches on some older kernel which doesn't have a
proper flex array at the end of &net_device?

>  	if (!dev)
>  		goto free_cpu_map;
>  
> 
> ==== Baseline ===
> 	./tcp_rr -c -H $SERVER -p 50,90,99 -T4 -F8 -l30				./tcp_stream -c -H $SERVER -T8 -F16 -l30
> 
> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
> Run 1	2578189	        0.00008831	0.00010623	0.00013439		Run 1	15427.22
> Run 2	2657923	        0.00008575	0.00010239	0.00012927		Run 2	15272.12
> Run 3	2700402	        0.00008447	0.00010111	0.00013183		Run 3	14871.35
> Run 4	2571739	        0.00008575	0.00011519	0.00013823		Run 4	15344.72
> Run 5	2476427	        0.00008703	0.00013055	0.00016895		Run 5	15193.2
> Average	2596936	        0.000086262	0.000111094	0.000140534		Average	15221.722
> 
> === cpumap NAPI patches ===
> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
> Run 1	2554598	        0.00008703	0.00011263	0.00013055		Run 1	17090.29
> Run 2	2478905	        0.00009087	0.00011391	0.00014463		Run 2	16742.27
> Run 3	2418599	        0.00009471	0.00011007	0.00014207		Run 3	17555.3
> Run 4	2562463	        0.00008959	0.00010367	0.00013055		Run 4	17892.3
> Run 5	2716551	        0.00008127	0.00010879	0.00013439		Run 5	17578.32
> Average	2546223.2	0.000088694	0.000109814	0.000136438		Average	17371.696
> Delta	-1.95%	        2.82%	        -1.15%	        -2.91%			        14.12%
> 
> 
> So it looks like the GRO patches work quite well out of the box. It's
> curious that tcp_rr transactions go down a bit, though. I don't have any
> intuition around that.

14% is quite nice I'd say. Is this first table taken from the cpumap as
well or just direct Rx?

> 
> Lemme know if you wanna change some stuff and get a rerun.
> 
> Thanks,
> Daniel

Thanks,
Olek

