Return-Path: <bpf+bounces-45176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E90D49D2534
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 13:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C5FDB218B4
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 12:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5C81CB302;
	Tue, 19 Nov 2024 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kYHptYEj"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A47814E2C0;
	Tue, 19 Nov 2024 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017829; cv=fail; b=tjS+IXb/Q3P8TwUoAUpez2ozaZGqdbO0P/GSbaYc1uWSvFOyoEToXhd7QjC3GCZDw9IdGNVWkqP1QER6oXLd0inUlJg3jHknpSQ1YbFM87ZH07AUfWVuKakGVfuLbonvY/UgiMHT7VdICVqef2UVENv2szlxi7vwp1F+2MzzT3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017829; c=relaxed/simple;
	bh=bgZpdorx71oCCRZf7rPOYyeEBPogeuU8RaPId13yX+Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IJ5Dn4j+ha2zZ9rvWdNfzeZggYLl+S3YwCwCOjqNA2NhmH2wMr52MhVbGlgPIeuXUU8Bl3I1QmzAStY+dbnKi3ouiuXvjak29mt+GeVlvUQg14ObKiO4CGdhm7weduIkeY+oUmN7P43pYkzmKN321K/O3vbUhusqr9DMMchjwqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kYHptYEj; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732017827; x=1763553827;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bgZpdorx71oCCRZf7rPOYyeEBPogeuU8RaPId13yX+Y=;
  b=kYHptYEjoO7RtW+0kZdKST9yOYKbJ713bgPHz4njSE4DXNaBUetHMX9H
   yNuvOexcAa6Juz9Z+XmxCUwMTfs6lhtiI2n1CEvLbhGoF7NWDLK8evB55
   0v9b2/aJmBJ1p532liS5IOffkx/ndGHSPonaOQhhd/z+qRvT/nn7s7y1B
   5oKLRvS8ZRJmYHWQLmR3x2T4Ebs8s01QlLmBR0vRvgmjkCe3TMzzSejWE
   NMvFxsxoZ3HzMkVNZjzJFQOETTWezNjtTf4xHwGSmn2DjQYBj/MFVI9xc
   oeq+Fyok+dFgEVVPg/w4U65FBequRrEXt0hUV+G5RE/6v9qh+cuUu0N7e
   w==;
X-CSE-ConnectionGUID: a0luBC+DSkqE94Oc0UnHgQ==
X-CSE-MsgGUID: 1mptFX7mTC22sWiXbns1RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="43080556"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="43080556"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 04:03:44 -0800
X-CSE-ConnectionGUID: aDYpwCzHQkG6DncWEMp9fg==
X-CSE-MsgGUID: 7S22bLNrTLi3KAlhF34ITw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="93605747"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2024 04:03:43 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Nov 2024 04:03:42 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 19 Nov 2024 04:03:42 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 04:03:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzFHCdZ4wv5ZpnrMwremyeE+ElkUFdFISvfxVn2BOWOkRxakDOqGxQopDD1t3WHqLC7bOahEOQOCbCozoTlLpZ0VamKhy5qzgD4dphdqhgenUOeJiCvW/ClJ0AtmNPw5ljkxv+HQP0+pi32ktEm4FzYGeN9tjvmxjsZNnAPVee2UTN/inHyQAo3vaVWekOWNh2puzWs9FYgngIvifryD6z2u9j75kDq8Q8mgHX91NQKf00wltlNam3ayquIAz/pt8cbcE1HyTAt/E860ewAjxGhpI3+ZVrd3//+0/xwaG8t2123MqmmRCmvIkzKKeosXlQ3Mmm7dR7PBoCuvfxD4VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHm13LdnKt7cTl4JLoa9WTctUy0ufB2Um3yb3Y+wicI=;
 b=mbAeTHRPOjHMkL974b5xPMop1Rl2AOFLqSAmTvvPj+oeJgFKWv3r6g4EHl7TfD8y/io9S6cAowEvQvMTfRBd1FfJVa4PdlpafhADoz8EAJ2ugSf+kL4njO8fWipU/V3nKGaCMbZYP5XtpsFKv79G5X85wrHF7chlRpBo+Fx/7kbCav2DplFYGIyzDXNGSPgwNRq1LCpWIccQsEIiHxcfxM/n4yfQMjhkQ5pQuAgMNDiBpcCF17iqkPE4d1P5KkzwnMvCM5fN2PTOyw/kT+2DlQcNfLVHAVir02YP7LKBNcpe1fTRzjUlzzFOivTwtMG4tBYnzcx3vOzYZXjSe9nu5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY8PR11MB7057.namprd11.prod.outlook.com (2603:10b6:930:53::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 12:03:40 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 12:03:39 +0000
Message-ID: <26b6d2d9-0626-4638-abcd-967a7b437165@intel.com>
Date: Tue, 19 Nov 2024 13:03:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 11/19] xdp: add generic xdp_buff_add_frag()
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
 <20241113152442.4000468-12-aleksander.lobakin@intel.com>
 <20241115184059.3b369970@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241115184059.3b369970@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0094.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::9) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY8PR11MB7057:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f10d309-f0a7-40b8-2a81-08dd08923489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3RMOWxnUVh6c29PTFpLaHY2M1VhbytoUC9xUmlHd1VVQlJyZ3JsQmUzbkxC?=
 =?utf-8?B?eTE5dmhQYStSWTVtQUhVTExRR2k3SFJ5dFBUTFVZNDdKYW9QV2c4WTJOeHhy?=
 =?utf-8?B?NGpJZzN3WkF1dzdxb2o3Nm54MTJ6WU1RQlprY0NOaEFNUWs4VVhZVVhBSkti?=
 =?utf-8?B?cmV4UXJpYm5JVnJiNDMreEpOdnFUZXBuSnZhN0VJL2grOUJjWlZxQkpKTk5I?=
 =?utf-8?B?OXgwZnVadHpYdFNMTWE5MzZISi9FQVNwMG9lZjdsWTB1bDlCdlZ6WUpBYysx?=
 =?utf-8?B?cjM1K1RoeFhTWDhoMVdzTG5WUkNKT1JtalFHeitFQXlEK0dlR0FXV24yRlVB?=
 =?utf-8?B?dnpSN3RSSDl3ZnhkTjBpZ05WK0tudy85am41aFJ4dHZlZ21McWhWQjhqT2JL?=
 =?utf-8?B?YnBGc2lKYXhCdkM1VzJqSVJkdFNTR1ZkMmFVQ3Z5REZQR21JNVlMN2VIc05w?=
 =?utf-8?B?elE0aGIybDJ2R3lnUVhWbGk3cHRXWkxScmxqQnYrYjgrb1YrUjJGVkwxVlNB?=
 =?utf-8?B?UVEyR3NaUHNKR3Q5dUNLL0toRnlIVDJvVzJEVVlYSVErcFZEMVJKdUs5a0hS?=
 =?utf-8?B?dnRsT0JmdTVFWDlSV2NLdEtVOEZwUURRTUtqUTFxNmMwUmczeS9wM1ZUTVJZ?=
 =?utf-8?B?TXg5UmgrcWZmUFJCbHVUTlhxN0E4QTZ1UU11d2kyZElPQ3FiUEI5TTVFRFhQ?=
 =?utf-8?B?VDhoUEc4WEZjNytuSWpFVjZQL0JjWng2b2xVNkRsOTNmM0lTQUZWRWRxcHEy?=
 =?utf-8?B?R3hDSmQ3eWJ1SklUWDQ4SlBHWGdZM0hRNXhRTUcweVYzaEEyRFdoTzloM2FQ?=
 =?utf-8?B?YzVaVlJQOXBTU0xwTkpFamhXWDJvb1EzMjNyTlUxSlBRMTVTWDhkOXE4YzFM?=
 =?utf-8?B?OXJKNFR3cm5NWG0xbFR1U2VwYWRWQXhDUStLcEdyNElBYVBURE5NSFB1Um80?=
 =?utf-8?B?QUtqM2k4NFZFVkc1dTA2MGJ4Y04veURYUThqQ2grb3FnVmJCeis3aUM5T0Yy?=
 =?utf-8?B?VGVpU25PdUlZcTZGMloydmpRMzZqaFlpUVFLditic3hCM09KVUg5TllIYlc1?=
 =?utf-8?B?a3p5UUhFOVZnQVM3TnNiU2l4enhDQ0dJSndvU1p1cE1xOUROYlY0VFlTcXZE?=
 =?utf-8?B?T3hhcEI3dHRWNm1hN0FrUDR2VGpzVzZrMzR2SWwySzV3aGNtYmp5QWNEdjhQ?=
 =?utf-8?B?NWtMaWMwdno2Nk94Y0dpS1BnYjM0RWVaNlZUS1VoVVloRlEwSmlNbHhxaWRN?=
 =?utf-8?B?SjMwUXIvZ0J6ekd0cmk5VlRGRkpmcjBnZUYycTNkUGFzbzRBRWhyekRlRGRN?=
 =?utf-8?B?dU5Wc1BudU5xdUFjYTArbW9TVE1uQWdXODRrQXFqbnlXN2ozS295Vm1zb2Jt?=
 =?utf-8?B?SUJaTnlCODdPSmsyMDQxK0E4K1pSSmoxY2d3bGFDdzA5MzhTaXdBcEgvZVpm?=
 =?utf-8?B?ZC9EWUZ2a2RDZ0FOZ2p3K2dTWEdnTVJMejNXQlc3ZWVwWnVJaCtrRE9lQktG?=
 =?utf-8?B?MGNSTE5RWVZiZVpJRjYxQzV0Q2I3ZXJ4Q0RQUFZzTXNQVTlzOSs1YmxJR0xZ?=
 =?utf-8?B?aTdjbjRMQ0xEZUNFYThiZWZpR2NncnNnWW85Qi9GZVBtdTVhYmhteDlGZU0x?=
 =?utf-8?B?UGpCQllFSlR1K3RWRldBZmVHcktHYVYyVjdwOVkrM1duVGFlNm1MbE83MGpK?=
 =?utf-8?B?YUNMUytqU1pHeTdDMi9rVVRqa2Rqc0FvYnJvR2J2c0lEczd5VXJYNGZSd3d4?=
 =?utf-8?Q?hNJ/SH25p+9voflVm7G0qdJCkNPdfZwhIN2VT7K?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0ZYWVFpZEFkRThkbXF5enlGVEllYWJpdzRiQm05VjZBWVE0QVBybncwNWl3?=
 =?utf-8?B?eE5raTUzT0svS2poQjVBOVpEVmpBV0k1Y0hQb1kzeTcxbERXV0JBcnhFLzVZ?=
 =?utf-8?B?djd2K3V0dXdZVDZoaXVXU0o5b1MvQ1NzWUQ5MkpNendheDZyUVhUTFNBRVla?=
 =?utf-8?B?bkFlUE1pS3FUTkFoVXF2c2J2bVFVNzE0WUpUYUZOdHVUR0poWVEwR0c1VXQx?=
 =?utf-8?B?dHJvQ09vWXk3RVJacWlDeC8rSktqOCtXbm5ZYzFHZ1lyY2RhZ3hHSmM2OUln?=
 =?utf-8?B?dUwxa1VQcFp5TWpUeDZISkNsRFVqSnlTSnJSSDRuYzhTdHhONXB2UFJqdFho?=
 =?utf-8?B?KzlJU1c4YjNXc2F2Zk5EMUd0TmdvZHorZlg5WDM3YVJYV2tTYUczWCtKSE1Q?=
 =?utf-8?B?c1A2N2RHMVpCRmVjd0NsQStOMWs1cEVwOVdlZForSEQrNnQvNUtBS2xkR3Rk?=
 =?utf-8?B?aWtzWVVIZXZaWkR4dTJ0RXBBREM1QjUzdTZYUjIySnRWVEl3RHpFT0NuYjNL?=
 =?utf-8?B?MlM4Mkk0Sk1UZnBzaEx6UmtwUzFoMVVjd3kveVdCU1dwQXZ1S2Q2VW53eitE?=
 =?utf-8?B?NjV0ajVvL3JlQTgvazdjeUt6OGNKbU94V2hsWFQyUjZWSUVNWVJVWmFrZjd1?=
 =?utf-8?B?UTlObi9Ibm1QWWlRM0ZKM2tjemo2RTU2RkkxZFBpems0dktpL1R6UFNuWGZn?=
 =?utf-8?B?MEFpTEFMaDc2K3ZhTjV6QWNoV2FpU01uS29sMjU4cTFBMzg5TllFOGJKU09E?=
 =?utf-8?B?MlYyYXJCZWNSbU1VcmZuaFQvcHMzaXZSNFJ3Qk51UFdCRzJSK3NDK3QzM1M0?=
 =?utf-8?B?VWJPdlY2d2tXWGtjeHFwSzFIRk9wdXRiSnJRS2JSS2cvejhhbXZlSjM1aXNL?=
 =?utf-8?B?V1pUL2pxQ1QrMkttR0xFdGxBR1JRZ0pKMFRGL3AzZlFPZDg3K2lLdkRNeDRM?=
 =?utf-8?B?MnlPZnljelZEY3J2VU1MWXhYTzBnR1pkNDNvQ1VtOHlEUU93RVdCZ2V6bndr?=
 =?utf-8?B?aFlQQ001eU1mYzRtKzZsYzNCVUpzd1VVSDYwR09aWWNNOFIyRFZHNko2T2ti?=
 =?utf-8?B?TTdGRWN0LytnS3BXSHBVbXp4NUp6Wm1EU2svdEpVR1B1Rnk1aGduTEk1UTZT?=
 =?utf-8?B?Ty9sWHJvWG1COXlCbkFpSnU1M1ZUUmdwRlR1M3pycnpCaVBqRlc4TUlLRmlv?=
 =?utf-8?B?dW5YbUhXNmFEcE1tRFREVkk0YzZaMis0M2JybGltYjR5QTFsWDJlcnBSb1hi?=
 =?utf-8?B?V0FQWjY5eVhBZVFoNTJmbUVMRlB0VmdLRlpUbWE1eXd4RTgyenFISXFNWnFL?=
 =?utf-8?B?VjZiclFSb1VoTnBPbXdSZ21jWTlLUzlkODI2Tk9NM0dOaDZ1emhiRE5xM1A1?=
 =?utf-8?B?bmRoNW5POVpWWExOOFVXdkdoRi9sZFNMZFZmN1BrWjJYcWtyUTNWQkJOLy81?=
 =?utf-8?B?aEgwVGMyRTladzFDL3ZkaTQwYWMySklxYjFxNHpQSHNBNlVsUEVNWGZPNnd0?=
 =?utf-8?B?SWgyenZGMmVYNXVsYnpYdEpsVXdOSTA3N0FSclo0OTI4YllwOTkwbWFQM0I0?=
 =?utf-8?B?MENzLzk0UFhIL0hxVEdpWWl1OVd4TXNKdHlUK05XbWMwQkxQM3ZDK1YrLzZT?=
 =?utf-8?B?V2l1eTlIM0JMRWdtUzEyWEJWdnlWbStKNHV3TXFGdU9ZY3VYNXFVK1I5R0h3?=
 =?utf-8?B?MGVZS2xYaEk2QWFnaDN2STVEVTRtZTVPandsazR3U201R0pmL2tNaVR5UWxP?=
 =?utf-8?B?aW5HZXZSdU14K3NvV3U4VnJYYmwwU0xSUXZYUisyd0FQaWZXdWlrSzBPbDNO?=
 =?utf-8?B?Q0VIcXZ3bEM2enhKZ1BvNW1xbzZoZ2U3NVBVS3l1c2JETU5qS2hpM3JNR1R6?=
 =?utf-8?B?S1hMNVZReHFlbVdFOEMzTGFScG52bEhYWGJJUU5qL055MTBXd3B4L0hkOGpr?=
 =?utf-8?B?MFIzNDVFcHI5QTY4Rnc0SW80c2N4djRCNnRtdG04RXdJL2ZuNUxTeHg2YldU?=
 =?utf-8?B?cjB3dE1xQnFZVk50cXdEYU5ScTBCMCt5UkhaNFR1R2txamZzQmdnUEtjRkZv?=
 =?utf-8?B?cXpDR2F6aXN5bXJKWEFGNGR3N3ZHNkE3SGhaTHdFZDRmSHIyY1F5MklpNlUv?=
 =?utf-8?B?SjEvL1l6UHFxc3I1ZGg0dE8vUG5nNEJRYktpZDJZbnNWbnFLSHkwWmVPQk9S?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f10d309-f0a7-40b8-2a81-08dd08923489
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 12:03:39.8629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkMxz3zCxLDxnU8WphV/JhxARjlg+39txY8Jnw4j0M2gqDVkIgHJr/YqMIRRGocmPZa0vb+UVjgUc0/u5joX7tOKPA3TDfz0wsoXKSMMLII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7057
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 15 Nov 2024 18:40:59 -0800

> On Wed, 13 Nov 2024 16:24:34 +0100 Alexander Lobakin wrote:
>> +static inline bool __xdp_buff_add_frag(struct xdp_buff *xdp, struct page *page,
>> +				       u32 offset, u32 size, u32 truesize,
>> +				       bool try_coalesce)
>> +{
>> +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
>> +	skb_frag_t *prev;
>> +	u32 nr_frags;
>> +
>> +	if (!xdp_buff_has_frags(xdp)) {
>> +		xdp_buff_set_frags_flag(xdp);
>> +
>> +		nr_frags = 0;
>> +		sinfo->xdp_frags_size = 0;
>> +		sinfo->xdp_frags_truesize = 0;
>> +
>> +		goto fill;
>> +	}
>> +
>> +	nr_frags = sinfo->nr_frags;
>> +	if (unlikely(nr_frags == MAX_SKB_FRAGS))
>> +		return false;
>> +
>> +	prev = &sinfo->frags[nr_frags - 1];
>> +	if (try_coalesce && page == skb_frag_page(prev) &&
>> +	    offset == skb_frag_off(prev) + skb_frag_size(prev))
>> +		skb_frag_size_add(prev, size);
> 
> don't we have to release the reference if we coalesced?

Correct. I realized that when replying to Ido =\

> 
>> +	else
>> +fill:
>> +		__skb_fill_page_desc_noacc(sinfo, nr_frags++, page,
>> +					   offset, size);
>> +
>> +	sinfo->nr_frags = nr_frags;
>> +	sinfo->xdp_frags_size += size;
>> +	sinfo->xdp_frags_truesize += truesize;
>> +
>> +	return true;
>> +}

Thanks,
Olek

