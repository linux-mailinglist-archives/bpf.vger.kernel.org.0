Return-Path: <bpf+bounces-46148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FA29E5292
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 11:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CCF21881866
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747811FAC34;
	Thu,  5 Dec 2024 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drxcn4wZ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3EA1F6663;
	Thu,  5 Dec 2024 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395115; cv=fail; b=fDP5lFw93f5RI9/F+385Npyn6pZgZEZzFbIWN1HFsPKOevbnke766SyQVa2+Xpoc05GQ+FtwikQZJpSNvISrfGVh68+yLoAsAkKMTa+zu9+cGEvNraMbtoU6C1ybACaN/HwxYSEoFVz3exMWdldBo0lF7eHDWfNYyK6IwCqxWIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395115; c=relaxed/simple;
	bh=QZwZ05u1iR8hTB+AaJ7bJktK+JB3R8XUE4bpyPMxRo4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z6RBQDUV179psTmhG5G0r1khc4L/we6WJrHHRTdcT0K5VFfweYN9f9L1D5DoREj166vPZW5+AG+TI5/0PtmnCjdgngvjhBBziggo0zX+dORAhpq67cWHcjoXa5v8Efya8qfBJN69gBFweNSpyurk/qXqWbpI33yk0W9PaT3auqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drxcn4wZ; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733395111; x=1764931111;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QZwZ05u1iR8hTB+AaJ7bJktK+JB3R8XUE4bpyPMxRo4=;
  b=drxcn4wZYtWLcIIarWIZ9aubdxBkLz+1f7vXLLrIE0sZOD63KdvapJtd
   dUC6EnAnWHW0pY77f6Mex5aOl4iHCX3UKxD+A0cFNELQZVufAMic/Emef
   ifF9FZUZzWkJmZ6EB4e6R+bS7sEhoMTQocLg/QaVsn8+hEe+7eGroFudi
   DA/ovvuyYEph33ZfgdSd3Eb4G+/uMJeAaNy2t/s5p+JWE/1K4G/kLGjOi
   OoIVeTPyMj+puWpaSGyI4JqS4VDSwGQm8WT9B3WqppJjd9KPYNPpsQkLE
   OvOXG+OhF7BCUeUGMbNdXX7OfGAiKABK0Vwbs6ftJXJU0LkKcg+GsfYSw
   A==;
X-CSE-ConnectionGUID: qEetyU2nStynltUcMDtBrw==
X-CSE-MsgGUID: OFT1ALLCQvSed6vlyvpX/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33761208"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="33761208"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 02:38:24 -0800
X-CSE-ConnectionGUID: 6jJJtRl0RCKrmB8dMclCWw==
X-CSE-MsgGUID: bkozmDoPRs6lVIBnW0Nw0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="117303439"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 02:38:23 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 02:38:23 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 02:38:23 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 02:38:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wq1zkeXAn/l90vLmYfmR/SgDkzDqzYErgN2E81j53aFHT/QwYBPHyz3YSYC9NbS+cP5TJTXG1nFqMp2SypnygjiXEK8v7hJchw0FncqdHxYO9larJySnvaJFnIc4bEpiCsUQbsClRmZZDWmtIuk2kpf43Zul24j/OhbZkLiGx32QZN3wGd+69ED1yFqG2Gd0lVdRbpOMYyu3c84k/0AJT8zq8wgLl4R4sE76nTwYTDuWklTWqNTeiKE0VBn1d5BjXfpumAG6RvZswOByUf7UyKqYAmPpF8PFVnIAzLLKoKMzIEc3tv43WQxFM9fub3+SSTjVio0Y/sdaba2rDXVzzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTyIRBplNXWDVooZuTyLncgbuU090gmOxLRvggTFdWk=;
 b=rw/+uCWqWqPHBRHOegjptedTP7173T0Wr08Evg9J3ov7NRfQAMuxst2HBI9dJsCkIpK4QBppn+zSXhMcLk0W0xuckOppz9vuEFwrOkg7yLztbAZ0/wr76MUqRI6+M1Q2hLDmTpe5pIrOR/mRQ0w1ZU6Tk+yeXZPnYxGjpM/cqEMQXCTq/hlish70uhh5s8sSyFJFB1BlJyaHvYI1aAuD/21lFObtff9Az0wywaBIbvZqVwpeBG8seWaPaXgSr/TWHJLhfcnw/lnPucGSOr/YqTHr7KdgVfNLFEsHHV6FqUVEenNd3SqYvXJ/dggn5cku0nV/o3oW8IkyFKIa5kiLQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB7417.namprd11.prod.outlook.com (2603:10b6:806:345::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 10:38:20 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 10:38:18 +0000
Message-ID: <51c6e099-b915-4597-9f5a-3c51b1a4e2c6@intel.com>
Date: Thu, 5 Dec 2024 11:38:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
To: Daniel Xu <dxu@dxuuu.xyz>, Jakub Kicinski <kuba@kernel.org>
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
 <a0f4d9d8-86da-41f1-848d-32e53c092b34@intel.com>
 <ad43f37e-6e39-4443-9d42-61ebe8f78c54@app.fastmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ad43f37e-6e39-4443-9d42-61ebe8f78c54@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::13) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: d22175bc-dfdf-439a-5e25-08dd1518ee40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3lrT0xZQzRvN1RLRHh2S2dxUjZQWXBTdVFhUmIzcG5kRUJhcExQY1JPbXBL?=
 =?utf-8?B?YmNSakxrbHo3U2xlRFhSVHNMQk0wL0xlTlhxOU40WGpFTjM1K3YzaVBrTi9V?=
 =?utf-8?B?ZXNZbC95SkFlNHFQeEMwOUZTdEkrdEtUYXZueGwxOXZTMjJlN2V6eDFLOWcy?=
 =?utf-8?B?TUhXdUlDUGl4U1hVb1BzOXYrM213WVpTcUM2R1RZRG5IbmpIeTl4eUpNSlYy?=
 =?utf-8?B?b2Vxc0h2S3pVRzdLUE92aEVxYURKMTZQL0hFdUlPUTVGcW1YaFFVTHpON1NN?=
 =?utf-8?B?b1IzWEVoSHFxSFY2ZGg2SHF5MVJraWQ1VFpiMEtCUzd6SWZKUTg5OUY5Lytj?=
 =?utf-8?B?VUo5aVZoWkpJT1VHU2hudXBSZnl2ZllQS3NMNHFEN2tiME9sSmMrcmpBTDBR?=
 =?utf-8?B?dFZ4d1dpRjY2U3M5VHBCVDgxQTlsYmhhMFdid2J1dldSL3YvSGxSaTdqK0xG?=
 =?utf-8?B?SVE3MHp1dEo2RzZmZ1dKM0h5d1pmcGNxU2lCYlZrNHVkV3IvRXR0SVFYSHJs?=
 =?utf-8?B?d0ZVcXg2TWVFeVRPeG1keUVtbHBUd3V1enRxUWlGOStXaEIzUFgva1dERVJ0?=
 =?utf-8?B?UTQ5dW9HMGVyVlhLNW1LWk9lM2FKSHhHeEo2M2hOQzNJODhKUTFlQWFucjdZ?=
 =?utf-8?B?N2taeUhSMlVDTGw2N1l0QWhybURLY296cXdQbTI2Vk1mNDdGYlVuVXpWc2Rr?=
 =?utf-8?B?THNzc0hTaVJtZW1ramNTajNENVRGQ0ZLTXl1S0FZb0NwckVaeWZiTWJRMTBw?=
 =?utf-8?B?RzhSREpXSHIrYXpyaEY0M3FHSWhqUVpPMDNFUjVFeDM1d3BXbzJxd2R5Snhs?=
 =?utf-8?B?WXVPUXplQXNRS0d6RzcwbU9LT2pjZlNXYnA2azhqWHlYZk4xbGVXdTczMlN1?=
 =?utf-8?B?a1UyOVd5VVdERTdUd0tpUEt0eXRNVi9RM3RROUltMFQzSmdLOEt4aFBsT2Zl?=
 =?utf-8?B?UEEySlowekZFNnA5dDNUNHZqalpHL1JJenQvT1FSNlZDOHgxRFNZNnR0UHh5?=
 =?utf-8?B?U2VuSWRReWxCUkdtUWx4QTA0bjVQWWhnY3U1U0hOQ2cwL0JmT3FVS1JIOWNF?=
 =?utf-8?B?T043YUlYTU1zVjYzdlMrSUFBS25HYVNMTUpINWR4L1IrL3pqclBMT2dabkFm?=
 =?utf-8?B?RHRSZnRUTW80cHdQbVRLSVRpelZzNTZwQU5MMkF2MkxRanpaWEtiMVQ5ZWkx?=
 =?utf-8?B?UjVRR2toTkxQZVFvNG1XY1B1Y2g3YVBtUG9oWXFSSHMzbUZjaTdwdkc5VGRw?=
 =?utf-8?B?R1Z5SGRVNnhGQzV1eUM5R3dmK0VnekhxbDRITisxVkZpTERnem8wTG5ETXJ1?=
 =?utf-8?B?R2V1dmVzY3Noc0hEbEtJTmhEa3BuajY1akd1SXhSUENuOVdjdzl1N1NhUnU5?=
 =?utf-8?B?Q0lGblYrMzY2bjB0VktqSkdUTUMvNXJUYksrVzlmTk5reUk4dTZNUXl1ampo?=
 =?utf-8?B?WjZJaituMXhxU0dWY1lERGtNMEZGeFF1dWJycGgrNmR0dHBKZnVJbHRIM2tL?=
 =?utf-8?B?dGY2dlVFUW1Ic2xvTUNDSFV2ZXlkTjVaa1NBTzk2YnlKWFZVOG5paFZwU3JM?=
 =?utf-8?B?amVBdFovY1prd3FycnlmUEt5MTYwSXZBYndxazRSd0g5VTR0SCtHU1Q1ZURF?=
 =?utf-8?B?YnNMWEtGQTZYWExKajE3ZGxQbjVXU3FWYTdzaFR2MWtDb3o5b3dSTnNGbzZi?=
 =?utf-8?B?Y0IrajFCMVJCeDJteUJYZ0UrYXF6dXJMQUVETWFFT1Y3QldFSFpGOEp0aWp6?=
 =?utf-8?B?ZVMyOUNCUkt2WnlYbkhtaTN1VHZzQlJDSmlIN2t1SVIxSnFlcU1mZ2JnckhJ?=
 =?utf-8?B?VjR1dFkzakFoUGhlOVVNUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjRVYTlGaDVWcUZqQ09hSHZtUlQ0cW92djhkb011SlJKRzhPRlR0azIyS0xB?=
 =?utf-8?B?M3hqdWdORWwrT1BjMmErY0VlOGxJQ3dycjdGejBMdEdSRGJpWnd2b24yNmNs?=
 =?utf-8?B?QVlZb0s0SkJoOWh5Z0t5M1JySERqeVFtYStLWWxEb0FXNFRaUWFZbndSRGRi?=
 =?utf-8?B?WjI1NDI3dlIwMXZjL1lvTk55L1pRd2gvaGFqWlRPRGVESm9YK0RpZnk5OXcv?=
 =?utf-8?B?WGZVUDdpejlkQmMyNlAycExsdmlmWTB0aWdMRE5Wem5wd1B2cklDaVRDRTd6?=
 =?utf-8?B?a3lkZXhmTzVhcVE5Tkw3NlZDMENORVQveFFBYnluWnQ2YlVOUlkzaFROanZC?=
 =?utf-8?B?ZDJBZTB5b1htK1Y0MXhYOFlpV0RsR1VVamZWREtmT2pUMytYNmdZQnEzcUFi?=
 =?utf-8?B?WUFybTVpTkNveGxmRG5ObFdiVHZtNFZEQk4rUGlUeEtseXBHSUgvc1ZjNHhF?=
 =?utf-8?B?WW1EdDYxWE1lR1BCS01LQU1hSHVVbFg2UTVJUmVJZWxsSVRDOWlud0grd05i?=
 =?utf-8?B?NVplL2NwK0duVzdBaUp2UmxhdU1mTTI2SUU1ZUdBNXVodkdUUnBVWG1Gc0Rp?=
 =?utf-8?B?SUNwWG45T2c0ZDEvK0dQUjVjMmZYcHUrcjVlWFlpOHY3MFl5V1FsRFdUYytW?=
 =?utf-8?B?ak5TNnNGK2Z1ZG1lOG5NYTg5cmwxdytIL0dWeUsrZVZVTVdtR0NZRmxKZHdT?=
 =?utf-8?B?NlZJNDBsTVJqWTdNTWNvYUZURm9LZUdnS01YTG43VGVPRXd6S1gzd2R2bjkr?=
 =?utf-8?B?WXNpNWFnaTdJbU9EanBZRGZqVlgzUUMyMVVTaFh6VjFnd1VxWjZiVUZmU0pG?=
 =?utf-8?B?Z3hnRmxmT1hBMkpFNW5MeGFCYWFOUW5vbUs1Y05JSTJ5ZE1iY2c5TjhXbnF4?=
 =?utf-8?B?R0g4SXNMVCtmU0dpTUR0WFhDdTZoSnFLaWVkMmJPdm5MckZQSWJtQW94aUda?=
 =?utf-8?B?Q1dKRWxiSTJpWmFNMldJV1RYVXVobFJCdGhnTlc4NVYxbm5EN1VPZUZHR0F5?=
 =?utf-8?B?TWZCVmJKSmVleFBPUFJyTWZuR0hRQ3NzK1J0eUNGUklKQVFUQmJkbC9XZml3?=
 =?utf-8?B?cVBQeU16WlRpVERMUndxbmpEazlLQW5YYVRjZGVrLytrYzU5VW1GOEN5eE12?=
 =?utf-8?B?NUg5UU1sV29kUjhiNnA1QXlNaW9qUDFVK3ZOYkFtVE1BYmt5d0gvbEpCVkhC?=
 =?utf-8?B?ZDZyb2pEcnU1YWp6RHdmbjduZzR0YTNialZwUW44aE5IN0tDZEdxUWNreWc4?=
 =?utf-8?B?dVBEOFI5WXdLaDhmOFRzS254UHNES0V4UWdCRGZxNnpPUmJkaXNiU2NMNldB?=
 =?utf-8?B?d2hESC94MjgrbDlQdTducjZaSVU1OExLaWxETHBYbFRoakwrRGRSOWVTUk9z?=
 =?utf-8?B?NFg3d3h3Y3BaelVTNDVGY2dZRjR2OFBvYjZnZmJIYzlDekdjZFZEdGlHQmo2?=
 =?utf-8?B?YXdhQWJvS1ZHMldwdjRlVUFBbkV0OGhYMWNhcXU5N09hMFl3aytvWDNrNXVo?=
 =?utf-8?B?VjNIZTlFYm9EVTZNdG9vcXdKd0J1UnhvcGFXa2tOek9TK0xUVVVzUXZXakJ6?=
 =?utf-8?B?RU5TU1NUYmdaSTVpZjJFbFZRa3MvdEVpRnVDZXZhTjhINHpSVzh6b3Z4VktI?=
 =?utf-8?B?RUtRUGZzeVp2NHQreWRqZTBXbVBIdERyK0ZWMXpXNGh2WnBFeDZVbEZieVE2?=
 =?utf-8?B?SHhITWw5MGdxWXJETW1rcFJuVUhJMXpuNjFMSmFYeTFqVlhkcE9RV3ptWTdE?=
 =?utf-8?B?WUx2TGtGTFlQaE5zRjRzc2JIeVQyd256MnAyTTJxL21CTzJYdEgvOE5vTFho?=
 =?utf-8?B?ZHBsZW85QU1UUHJxNjlxOXVVV0JDRUhEUU12cGlyTGN4S1F1eC80bEgzRFJQ?=
 =?utf-8?B?d0s2cjZ0Qm04VWlEZk84dElMYVZIOG9keEI2Vys4a0VHWDhFT2xpa3pqbnRl?=
 =?utf-8?B?dXg2eVZXa0VhbEJnY1g4NmEwOTVMN3JVVSs2RzduVlA2eVdQanBIQktlQlV2?=
 =?utf-8?B?dzBLQXZJcVZHQlZERWxEWnB1SXRreTVlUXp0WXV5dHMwa2czd3FXdEJxb3pi?=
 =?utf-8?B?bGZmd211Y3V4KzVQN1ZLQVdwU3hGakhyK0t4dm1seUxDYjFtTG9aRUpTZG85?=
 =?utf-8?B?SmR0cGJXUk1tcm5JeldJT3lmWGt1eWR0YWdCVUpxSFUwcHpXWllwSk5JUGY1?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d22175bc-dfdf-439a-5e25-08dd1518ee40
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 10:38:18.0034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFKaJCAln6IH5m9qv1nK157rYRAmr0MAjdPcR/gb2EQ9qgBqRLKjEk00emmOxuBbRYyDeBWyyYhVT2BfKWWJ946tuDW4A/49v92NMzrh9Ak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7417
X-OriginatorOrg: intel.com

From: Daniel Xu <dxu@dxuuu.xyz>
Date: Wed, 04 Dec 2024 13:51:08 -0800

> 
> 
> On Wed, Dec 4, 2024, at 8:42 AM, Alexander Lobakin wrote:
>> From: Jakub Kicinski <kuba@kernel.org>
>> Date: Tue, 3 Dec 2024 16:51:57 -0800
>>
>>> On Tue, 3 Dec 2024 12:01:16 +0100 Alexander Lobakin wrote:
>>>>>> @ Jakub,  
>>>>>
>>>>> Context? What doesn't work and why?  
>>>>
>>>> My tests show the same perf as on Lorenzo's series, but I test with UDP
>>>> trafficgen. Daniel tests TCP and the results are much worse than with
>>>> Lorenzo's implementation.
>>>> I suspect this is related to that how NAPI performs flushes / decides
>>>> whether to repoll again or exit vs how kthread does that (even though I
>>>> also try to flush only every 64 frames or when the ring is empty). Or
>>>> maybe to that part of the kthread happens in process context outside any
>>>> softirq, while when using NAPI, the whole loop is inside RX softirq.
>>>>
>>>> Jesper said that he'd like to see cpumap still using own kthread, so
>>>> that its priority can be boosted separately from the backlog. That's why
>>>> we asked you whether it would be fine to have cpumap as threaded NAPI in
>>>> regards to all this :D
>>>
>>> Certainly not without a clear understanding what the problem with 
>>> a kthread is.
>>
>> Yes, sure thing.
>>
>> Bad thing's that I can't reproduce Daniel's problem >_< Previously, I
>> was testing with the UDP trafficgen and got up to 80% improvement over
>> the baseline. Now I tested TCP and got up to 70% improvement, no
>> regressions whatsoever =\
>>
>> I don't know where this regression on Daniel's setup comes from. Is it
>> multi-thread or single-thread test? 
> 
> 8 threads with 16 flows over them (-T8 -F16)
> 
>> What app do you use: iperf, netperf,
>> neper, Microsoft's app (forgot the name)?
> 
> neper, tcp_stream.

Let me recheck with neper -T8 -F16, I'll post my results soon.

> 
>> Do you have multiple NUMA
>> nodes on your system, are you sure you didn't cross the node when
>> redirecting with the GRO patches / no other NUMA mismatches happened?
> 
> Single node. Technically EPYC NPS=1. So there are some numa characteristics
> but I think the interconnect is supposed to hide it fairly efficiently.
> 
>> Some other random stuff like RSS hash key, which affects flow steering?
> 
> Whatever the default is - I'd be willing to be Kuba set up the configuration
> at one point or another so it's probably sane. And with 5 runs it seems
> unlikely the hashing would get unlucky and cause an imbalance.
> 
>>
>> Thanks,
>> Olek
> 
> Since I've got the setup handy and am motivated to see this work land,
> do you have any other pointers for things I should look for? I'll spend some
> time looking at profiles to see if I can identify any hot spots compared to
> softirq based GRO.
> 
> Thanks,
> Daniel

Thanks for helping with this!
Olek

