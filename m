Return-Path: <bpf+bounces-51272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 049CEA32B04
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 17:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023E91667CC
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 16:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2641F236A62;
	Wed, 12 Feb 2025 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZY4EiLLp"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2DB20C486;
	Wed, 12 Feb 2025 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376026; cv=fail; b=D0qlt/+R59nFKaWW4Cseqec47SshMPtWLTCKjpGNFFpkTztgOg9lBetHulGZtSzW5PdMcnsjnT1AIwcFAv4kIoqCbkutWYEb+ft68i4LCp9yE3Vn4u2jrEmcSPqmzx5pkh7bCeTmibMAZp5FiNw1jyZPYIXd28aXUN1Kwsu1f/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376026; c=relaxed/simple;
	bh=SbUctfLWw09az9C31iYTHhE3xTiuI9s5FpkJixn/AQ4=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IrZemXjBa0Oqeojzzpnf0o8mjdB0DSTOzmJfTKK5VgHyHe47X9cbsB5NR4ScGeHQEx8Uy2p4n7QmczsfizxhmucrhV1sw8AzwRxFSaJnbHsngT6YcocA26siRMB/ccEm95dQ9iSqL6Fiqo8faiH5bv3X50v5dJFn/L93L19pRZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZY4EiLLp; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739376025; x=1770912025;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SbUctfLWw09az9C31iYTHhE3xTiuI9s5FpkJixn/AQ4=;
  b=ZY4EiLLp6jE4Q9g2/5OctRNKxgM/reHoDiBmaMUg8GI3heoSDazNClbC
   u5GZao061ssA4Mt/vqzM2CMQlTl7r0qyjbr9XvuDhYsnKUD1CUi9o3foM
   aJRvHbZorsz4zBMlhBdR2aoPEYMuCDTVAhxBizdYPhCfRhfuZVCDVeVtD
   l4r1uRkMem7d7G/DRqHZ7xP7EjLUlrfVE08O/hsdULfhHuZq6uk+6qYOb
   dawAKjPaA412PFU0F92tzrwElRbkKpl8UF6J+YXt08uS0mIFPA7qmkt3H
   HdwoJ/OabkWJp9Wh/2YNeKmOBzPE/7d5vnugOQcn4kgv8AK/hxGl4n7py
   g==;
X-CSE-ConnectionGUID: Ty8/N3h2QYmfuMAoibw6xA==
X-CSE-MsgGUID: Tx9bd4XFR8OBk9uBQhSTEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="40165643"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="40165643"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 08:00:25 -0800
X-CSE-ConnectionGUID: iSbaA66KRUqpHhJEn+NMWA==
X-CSE-MsgGUID: a8DbFDukRh2bdtAgIZf10w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="113067531"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 08:00:23 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Feb 2025 08:00:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Feb 2025 08:00:22 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 08:00:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIW02PIlZJxVC9qj+zxEIbG9fMxIlUOlwlHGmDxsBCI8ibwaODRVqE/2xPCEVnzO2OMGEqEoxvPC4Tqjm25FLAZS8GWoZ886CGy/DquYs0BK0kLJGlBdO+581g6wwn97o4k6kMojrnE3Xsn1hQsCjVfYwVZ7QVbDymjvSRAZr+O3SArpJUnUBwg+tkBleBgSSkXbPeTQpRTTcrUULGHU1QFA8Qh3IW+DoeGqnwqUl26vLB+vjzJLRz9PNFvSHlnDGtlYRB4xDuydi0FqqoXN6STAwSiTamNLc8753PfrgXu0dtKMB2QgaUvof2E4tkYMhiqMgZ4TjGDp7GDKpf4YSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbWJoor2YeEi8nUywg0/xp8+rKKWrKxTo05URsy0/AE=;
 b=KyHmB6R/eCLT8nQI9/27tM1rnpyF+WiWl65UPeBDZeWrCmf+7YJtcJ0dASzqEeNDOg7l+pIm3+ME4wxqxhIk+zOae7EuXe74mYkRyxLjfEC638FHVBk4GrDbPkWaI4kcxLTYJamy2Xb+iQju1/469ZYa5yqFrokMvTMHkbU+Gprcxc4KD9riwuLLHHrZz7U+4pNcxsB1rD/eQxM5CzyHHFwUE4YpQ9UU+b20nwTEXnOVtKicOljYChTtX3ZKxKH5q4REqmGRIKse8opqpHLAf8bJaLa/NyiQb0QbTy5nnhCU++NXyGO4WUEa1ZalWW/Wkg88qQ1/1lhildX3ZZvovw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB5876.namprd11.prod.outlook.com (2603:10b6:806:22a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 16:00:03 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 16:00:03 +0000
Message-ID: <1dd14ece-578b-4fe6-8ef1-557b0f5d3144@intel.com>
Date: Wed, 12 Feb 2025 16:55:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/8] bpf: cpumap: enable GRO for XDP_PASS
 frames
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250205163609.3208829-1-aleksander.lobakin@intel.com>
 <79d05c4b-bcfb-4dd3-84d9-b44e64eb4e66@intel.com>
 <CANn89iLpDW5GK5WJcKezFY17hENaC2EeUW7BkkbJZuzJc5r5bw@mail.gmail.com>
 <7003bc18-bbff-4edd-9db5-dd1c17a88cc0@intel.com>
 <20250210163529.1ba7360a@kernel.org>
 <0a8aac38-a221-4046-8c8a-a019602e25dc@intel.com>
Content-Language: en-US
In-Reply-To: <0a8aac38-a221-4046-8c8a-a019602e25dc@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c8490a-8c3f-482b-05da-08dd4b7e4fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dG9nc3RwQzdlZmVIdHpQSHo2cFBpMEJZV09WSTNVTS9qWjNUWklUV3ZaM05R?=
 =?utf-8?B?ZlM5MmN6Q0JlNXFMaHd5WlhKTks1dEhQZU01d0F0Sk14UUJpU1pkSkgzcnda?=
 =?utf-8?B?VlNGcTZ2dklKSXNBTDhtQjNOQjhwU3FnZ2lFQXIxN01hMGxhSUwvUmdrbXEz?=
 =?utf-8?B?REpoZTVZZGYxTXBuSWxQRCttL1pIZUdOSlRrV1RtRU5STVBTUVZnWkVmMVdx?=
 =?utf-8?B?MHVRQVNpYVBybTRmVDBsTjNPajE0MVJ5YitHWVpOU0ZQUDdldERPVGh0bmRu?=
 =?utf-8?B?Y2tsdjR4SGg3b096TTdodlgzMzJvL2hQYWhLdytZaUJvOWdkN3JPR0t6ZDlB?=
 =?utf-8?B?UXczeGY3b2dyUkl6WkJ2S0dZMlY5ZXRpNDFZanhVR09qZzA2R2sxcWN4aGpH?=
 =?utf-8?B?b1hFTjVHV0hZVS9CRVFrY3JQNEw1VlA5L05LaU5IaFlPT1YraUl0cEQ3RWpV?=
 =?utf-8?B?U3QxZGJGbTRhZTRxcjVHOWpSNHFFaDFCbXRMaUVxNmQ2TFJHQVZSVlRMMkMz?=
 =?utf-8?B?L1JtZnM2Tis2Vks3clU3SnNEeGFFOUgvOGliRytBLzRvVisxcnVjQi84TDJJ?=
 =?utf-8?B?YWx4L3JXQUtCaWZDUXo1bkxzVTNnU3gzTDg0ZEdVZzcrSFNWVlcxMit2WjFZ?=
 =?utf-8?B?K2pjMjRsN1RhMUppQmN4S0Qxb0xSeTVrL0R1VDV6NXE5U09WTzVHemtDZ3Ru?=
 =?utf-8?B?THB0M2YxeFYwbVFMdExHT3d1VXpaUzNvclVRMTRVWi9ua2RqSU9tTFA3VzY1?=
 =?utf-8?B?UDAzNk5mQnkrUlNTVE5uS1pjVTVJZ09meFpoc1o4eWFBZ3RTRTFLZ2ExZDIr?=
 =?utf-8?B?dU9TYjMzNFdHdkxNM0FKRDdxOEVwc3NkSG5OYmozVVlLRkd1MmdwSG05c2FQ?=
 =?utf-8?B?V3gwanQ3Qm5PSGRwREl4alF6T3RvQ0hxaWsvS1dhU01LaEdnaEEvZnZXWDBo?=
 =?utf-8?B?czRwcHdhdmQ4YmxNVU0vSklNNlZTSk9QRHFTczRicHNiUStySjMzbWxUYUFW?=
 =?utf-8?B?aFJELzJjaGduT2ZPQkxNTWU3aEZETUpLby9nNjFGY25mOUlUQWF4SlRBYnlp?=
 =?utf-8?B?T3JqUFhDdE81enJGRDBURkJvZ0NaTEtDemxYeHBCb3lTQlYwS1NtVlNXdUVi?=
 =?utf-8?B?QUhtaTU3M2N2NEc0eHMyM29DRjFaOVBFNk9tSkVTSjRtSEE0UHl0eE5sTlpp?=
 =?utf-8?B?WVFOaEQvNFpEd2lEMjMzc2VoZFRFVUVxWUgzNkEwekE1cmJiRjZ5VTA5M2Yy?=
 =?utf-8?B?SkN2OUJUNHVnM0I5MC9GRWZ0S3hpcC9mV0ZVWnhPbDNmWU5LV1UyS2RGYkFS?=
 =?utf-8?B?NjFueVY5WHRRQytFemZUcUoxdGUwdHJvUXl4bmY5QUtuNm1PTnJ6R2RqR1di?=
 =?utf-8?B?bjFtU2gvbTA0eG91K3pMZ0VDL242SWJZMGZNcWp2d0NuNlV4SW50d3NBQWoz?=
 =?utf-8?B?aEVBTXVRYlVxUVU2QTRiY0R5NGlHNzR1cXRWeEp3RlEvVXRIajRDcDJvN3VL?=
 =?utf-8?B?REUzVG8xbW9IQ1dPREVyY3ZRTURTYnNqOHNQb08wOEVSemVxZXprRmJDTGlE?=
 =?utf-8?B?OWZKVDg2U3g5QXJaVWVaOUgvWkRtMUsvK1RNZE5WbGF2V0h3aVJEVGRVYURw?=
 =?utf-8?B?d2pOVXdmV2pRcGxyNTBURlp4SU9ScXl2YW02b1RYRUl0S25GRml5YjFBNVkx?=
 =?utf-8?B?ODRzeWlvUDNEZzhvampRYnkzRStWbGVJVEV5WUFOL2JjU1JNSjljWkd1dFdQ?=
 =?utf-8?B?UkI3TkdaZWxqeXN1Z2xzQWpyZG05UTBmRUxqM1kycDdDTHI1dVQ3RlMyeVhz?=
 =?utf-8?B?MUJrRGdtWVFQODJBcGpTTExjWG9rVGRlTmwxRSs1aHI0R2VUcWFWRlpzRlEz?=
 =?utf-8?Q?kXd3dGsIuO/a1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djhCL0tmMTMyb29RdTlwTEdPa25KNnNGRlNCQ0diUlRrOEJ6Um1NYUxyTFJ3?=
 =?utf-8?B?U3R1ekhQdWNRdHRBS1dGR0UxS0dYZjdUNHE3b2xOcnV3dUJPdzhkejNzTGtV?=
 =?utf-8?B?b2E0ZVZ6UXlBNjFxcWI0eG53RUFYM3hiK3JVcnVaWS9hTHZjL1hjOTdZNHB0?=
 =?utf-8?B?TU9SNENXNDdJRUlDdllKZGtIVHhPV1lROUpoU1FqcEpVS3JOVE9vQnMxMTZ0?=
 =?utf-8?B?Q3lUU0lJdWU3aDVoc3M0VENhZ2dCaWMyMkV2RHJWbktLR014SFo4bmdKbFhq?=
 =?utf-8?B?N1FKLzFhaGwzYm9QSUdza3JyU2ZEejFFTGR4UFpYNEtHWXJnVnNRNXp4bWUr?=
 =?utf-8?B?NGlRaDFHZ2pwZHk0c1prYi9aTjZYcGJ2SC9ndmowczBxM0o2TGFadG04cytw?=
 =?utf-8?B?VUJlcjU2N2tJaG9MTjFKdjlFTWovNFlRVkdFaVhubG1pM0pKZkFsVVk5RHdu?=
 =?utf-8?B?czdicUNWdWVveEsyMmtCUlBnaDBlMEcxTU9LQUZYV01iMmhMWkVQclVIWDZL?=
 =?utf-8?B?bU5DWFdkbzdTSEIraHRWRllLejZhdk9Yc09xMFlNbmZUcVloMHNHSlpHUkl0?=
 =?utf-8?B?NVdVV0tVTlZ0TGFuM0J2S1RwWlFWMWlhZkFEZTlrWDVwWTJPSFdqZElXb25R?=
 =?utf-8?B?U25xUU8xUFJENDVHeGxVWCtPeXNDcnIvV0NLcVNWQzNEVzhCMDlwRTJDbUo1?=
 =?utf-8?B?eWFjOWhscHFKaFdHY21oWThKSjFVc1JvVG50R0Exc2ExWWhlT3BQUUhlT1ZW?=
 =?utf-8?B?V3FpYS9ETDhlc2lpMHdPVEJGajU3NXpGN0xNQ0VwYmtoSjRMbDhyb2R4cDFu?=
 =?utf-8?B?SHMvVzBrRTVGTGs5NUhTdVM3OGRPeEVwRjRzVGhEQStmNmJwUDhjTmR1NE5p?=
 =?utf-8?B?TzUySGNNYlY0WVJ4OE1DajFLT0NhU1RQcUdXTnRsNjBjWUl4WXRnNmN2NmM3?=
 =?utf-8?B?cGFIYXhTVCtoRkZoSjRERzhPY2pVRTFzZ2JLd1dxc29tdGlOUTc1bjNDTURJ?=
 =?utf-8?B?Sm4wSWZEQ3VMb0Q3M2orN1FPS3pGdXpITTBQejVjL0lxeW5xMlA3dC9YVWk3?=
 =?utf-8?B?Y3RtZFFHZk5WVWRFSlBZK3JxSE5WbEpsN3RBL0JIUDExZDI5TnB2Sy96MkFW?=
 =?utf-8?B?dzVOVFErK1kxUGRobmFzZTFwRGFaUkpJT1ZEZE1GaWZFbXlYZ3lQbWQ3YStS?=
 =?utf-8?B?UEZFYVQ3T1VHK3U2cEdUbjdRNVArQmVrUldZTUx1V3ZaWk50aW9SbXBoNWk1?=
 =?utf-8?B?R1c2SmplTDVPSkZZYWFkVlFxTHgzS2RiRG9uUzFqYmpBU1ZFZUJZMnJnaCtT?=
 =?utf-8?B?M21xaDRITWhpYXZFdnViVlh4NGVmei9jdzhId3FnV0R6UEVhdklpUms1NGJJ?=
 =?utf-8?B?OCs3bE5xaDg4V0lqWldKMmhJcG5RT0duTkdOOHZyaTM0aHpQUWVoSW9hYmwr?=
 =?utf-8?B?RTAvZ1VJaUZDWEZSbUo0aHZ2dGczYmFqVk9DaU1LUUlrOTNnS1dndTV5OWtW?=
 =?utf-8?B?S3ZTaGdOUEJkbE1VUG5jU2hWTnNIbmZrbENkU2M3N2ROMkZsRXV2bFozZ0dS?=
 =?utf-8?B?ZGJLVVNxS1dIQUpTRzZmRWt3VUpYY0VTcnpqZTM2ZEtnMDRERHRheHZVYkdL?=
 =?utf-8?B?Yzg2eUhxa29KYlk3c0Y1aHpYM3hZL2IyWjBRWTNocnF1TTBzNWdBcW4veE5M?=
 =?utf-8?B?WFJPeXN4a3VGV1NCV0NJbnlORUxKZzdRaHczZURaSkcrSTdaL2x6U3JlYmJJ?=
 =?utf-8?B?MkJnay9xWUk4aUdLdkphZkNSY2d3NGU1MU9pK0prM0dYQmtwemJ1UUttZmc5?=
 =?utf-8?B?YmxZOS8yeTVSenltcHlHa2NodTVtS0IrTXYwbmxrellqS2NjTnRCRFQ2VklE?=
 =?utf-8?B?blVpV0NwR25PMDNhbkNOa2NNd0IwMTNZbERReVBraGoxVnJUdlZoK0RvTFQv?=
 =?utf-8?B?OGt4blY1MGlFaFNHc3l4YXd5aUs3UjhndFg1bHE1UTFrRHdFSmVvcGlScVZx?=
 =?utf-8?B?cjRGdXcySmtxWVM1Y0t1cGplclhING5LY2dDRm90dmVDb2ZBbncvL3gyaDh3?=
 =?utf-8?B?TFFoSW9wSnhnSDV0VzF1VmJZTnRobXpNbUw5VnBmZGVIbndQL1IrQ3VZZDA5?=
 =?utf-8?B?T09xdjQrcXl0L1poeDBiTkIxVndFYVhqa09GRTQ3T2hDVjRJVWFFczJkSU82?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c8490a-8c3f-482b-05da-08dd4b7e4fb7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:00:03.5434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfLVa7M+bo4ohaJskkVpGFzTn38uneySjZV1o/eTvfMWCxdIculXzJnuhB+M/DH+dR7iNybeJ5leTkKcVzaBlxTSY5eJOYtd6GvFMBrsUEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5876
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Wed, 12 Feb 2025 15:22:55 +0100

> From: Jakub Kicinski <kuba@kernel.org>
> Date: Mon, 10 Feb 2025 16:35:29 -0800
> 
>> On Mon, 10 Feb 2025 16:31:52 +0100 Alexander Lobakin wrote:
>>> This was rejected by Kuba in v2.
>>> He didn't like to have napi_id two times within napi_struct (one inside
>>> gro_node, one outside).
>>
>> Do you mean:
>>
>>   the napi_id in gro sticks out..
>>
>> https://lore.kernel.org/netdev/20250113130104.5c2c02e0@kernel.org/ ?
>>
>> That's more of a nudge to try harder than a "no". We explored 
>> the alternatives, there's no perfect way to layer this. I think 
>> Eric's suggestion is probably as clean as we can get.
> 
> You mean to cache napi_id in gro_node?
> 
> Then we get +8 bytes to sizeof(napi_struct) for little reason... Dunno,
> if you really prefer, I can do it that way.

Alternative to avoid +8 bytes:

struct napi_struct {
	...

	union {
		struct gro_node	gro;
		struct {
			u8 pad[offsetof(struct gro_node, napi_id)];
			u32 napi_id;
		};
	};

This is effectively the same what struct_group() does, just more ugly.
But allows to declare gro_node separately.

> 
> OTOH you gave Acked-by on struct_group(), then Eric appeared and you
> took your ack back :D
Thanks,
Olek

