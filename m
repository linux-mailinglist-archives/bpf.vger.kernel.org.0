Return-Path: <bpf+bounces-67107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5127BB3E36D
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 14:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88F51899AF8
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 12:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B9732A3E2;
	Mon,  1 Sep 2025 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fv6PGp5x"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559A7320CBE;
	Mon,  1 Sep 2025 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730428; cv=fail; b=ovQkgOsXABfhirLGuTGHpMIA3iFSuefRXn7zSPv9mRBekpQ2uCiZVrdZb3RFOzcPGFYLsV6BZ0+XHp50/wiAm3kTp7klbwld4Oi5xuNDpY8/V6OCInAe7fpbWVTgN1UH+KwwhmY6r+hBEBYLfKc6crX6k2v2p1DGHAWb7v8H/r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730428; c=relaxed/simple;
	bh=REvPx2A1S2cixVCVmwIPBo8PMCE+VQlRERJ7wCnsPPg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hez/XrjgHzm5fNAuecahluLbhZyyEeTwl3QtA/E9oL++B/3pXqCNafjo3n0VW0AShCaKTlNLmp4lFQ22aF/2UPyY9E3K3ffIzDMVPWyQKOEYsMjOB1kOPYhmhyaFdJxqL1UV9DFNz60E9mKdCAx07dmYOHkIu78Him6HsuEOasI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fv6PGp5x; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756730426; x=1788266426;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=REvPx2A1S2cixVCVmwIPBo8PMCE+VQlRERJ7wCnsPPg=;
  b=Fv6PGp5xV5j4gaxHMbLNRjZCw759/4FvO/PCwvA9Yq4xsnSGOnL3Cw6t
   olJ+q5Hhf0HrT32Bu97Ll+lfgVsdY2HfNkTUa6+z0daUnwrU/vH05lc4r
   6gFLS2t6SuFnJtmxIa8lTATwGBW4pHoKxjsWdBtfBkVn3l1ygxXPY5YcO
   ec429n8FJkgURIH57APnpauK6mHYI1o6aRuNKebID5G5zTXxBP4lhWKo6
   qdx9VTcLKZcoiXgsaWlwsM71r+QDtPESa07928PcTv7yiGVIR4bYWAePm
   ylpQN2XgBOPkt2cXvGomhhBklIHePNiODZk6AZP+vBNWc2GWCmEIDwkZC
   A==;
X-CSE-ConnectionGUID: HFksnGRSQqCrGqBYp1F/YQ==
X-CSE-MsgGUID: 5z8OwPBeRjqQagLR6lDMFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="76585427"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="76585427"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 05:40:26 -0700
X-CSE-ConnectionGUID: XzzWosYNT+iwTAfJ75Eg+Q==
X-CSE-MsgGUID: knQZ9F5NQ6yhzxK+VmjvUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="171178227"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 05:40:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 05:40:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 1 Sep 2025 05:40:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.56) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 05:40:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlkIazo3rg059KkYXlMBkrMNcGBsMB43y804MovRtTLwYUKOLYDdc5kjHMV74guiQXrMIvZmstHBtgPxO++cFyvv/k7ADPJyb0zjB64UQACjk4MCrLTTukO0Gwvr/YyYZlvmsBYXw1gPsaCnuoOlWzkF/cHkwZ2ITIT22wbJdULAMR3lO6GpZJnfWQVi7DEC9HZBEt75nXlGBUrigGnK40YTlHaXdfE2nfJEZJSWAgCdxhdm5bTVQiHXpxnOzO4ISTPpSUmXz6vzQTEiBd91zWkXnDowv988H8+ttOVQSsiI+y43r2p2iSGtWjkDIUai0DJ85CM5BEJQJHfCE0g6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkcoHra/N2shpjgGbStLSGtvUzV3QIyd/r6Tcc6KC30=;
 b=yfuMi9Cv0OBteg7gwTxelAJIG2RgUMQ4yk8M65DrsnjvLReInjkdgEeZJPq2F8GzZ1tzBZXDOfN1HxtS6uo3t60e4UBFZaq/OUuJMckRUnErKByauhomgJFY9QjdeT//nC3rblFlIkr4lON9cfcQCC3+kvyYoyV81pZLIbzQ7gOn5uX0ljM8Ngw7fKia+ABS8/fWfNsD0Z0KzTPONod7TkfUjoQ/0AqY59Syx033Yt3Kl0/HKnslBLGEOMezlNXit5Y4uZZXgvO40YL+UePYrNFwpiz1w8eSa5f9N+nTCYL2yVutef58PArEK9s707f1vfDkqgJMRqeEZfShaaKFug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY8PR11MB7826.namprd11.prod.outlook.com (2603:10b6:930:76::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Mon, 1 Sep 2025 12:40:15 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 12:40:15 +0000
Date: Mon, 1 Sep 2025 14:40:03 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<stfomichev@gmail.com>, Eryk Kubanski <e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v7 bpf] xsk: fix immature cq descriptor production
Message-ID: <aLWUIwK7yot1RlRq@boxer>
References: <20250829180950.2305157-1-maciej.fijalkowski@intel.com>
 <CAL+tcoA=9S6USV5EufhtrNuUF=8BHOQk2duqfsUH3uhdrwSAKw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoA=9S6USV5EufhtrNuUF=8BHOQk2duqfsUH3uhdrwSAKw@mail.gmail.com>
X-ClientProxiedBy: VI1PR10CA0104.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::33) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY8PR11MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: c03e8851-e813-4429-9689-08dde954b308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RS8xS1NLenREZmRoQVd4MlJoRmIxUjF6RzlXa2h6QUlLSEhnMnI4dDk5OGZv?=
 =?utf-8?B?c28rbHU0V2ZOc2ZYMXdPMlplZTJwMUQwWlVkSDRsbWRJc1hPRWUrTGpXWHNH?=
 =?utf-8?B?Nm9oemVkc2pYL3lmWmxDZ3dmd3BmbThBY3NjWnZXYVlpckhya1ZXc0cxUG9r?=
 =?utf-8?B?QWR2UVUrejJvOUVodE1CZkxaN1dHWlBYclBDWGNXZXo2UThJQ0l3ZkpIT1VR?=
 =?utf-8?B?Z0NwYVhjUi9jbzdDQldsOUh2b1FFTXVwbnNFVEZlMmd6aVZMWURZelllbEh1?=
 =?utf-8?B?QW9BMjM4d056QU5JZDI5eXMrSW94Vi9jQ01ORWtnSXhoSmk3SXQ3ZUY4OWhr?=
 =?utf-8?B?UXZ4MjFOa3lvM0hTeVc0T3pwUUpJZW9WckplSmdGM3BHUDVkWWtFaERiVGo0?=
 =?utf-8?B?SFFYV3RjN3A0djVmQzgwRE9qMXpEZWV4M01KelRjNjM2RDB3QUJJY00vTHVx?=
 =?utf-8?B?RGttbVdLSmtUMEJEZzJtVGRxTy91allhanBqR0pwU2MyL2NRSlpSM0tWdUNY?=
 =?utf-8?B?ZklqZUhZaENINHU1RFV6Z2gwcHpWaFJwVjlVcVg4VkFIejRrT041amkwM1Zv?=
 =?utf-8?B?QVduNVRxZXBwQSthTjB5T3hsWkR0bE8vSmJmOEpkMFFuWlZlc1QxZEtSTU1L?=
 =?utf-8?B?T0NSdE0vWWhYbXAyUWZMSk95TklkV21EaTBKQjNUYVN0dEVOcEthL0Y4SWg2?=
 =?utf-8?B?a0hJTExhT0JMNHJmcWE5NC9TYnhVZlR1Y00zeEJnUG15V2dRVW01QmllTFd6?=
 =?utf-8?B?L1dJeWQzaUNlMUd3K3kvUEovaXlMK3E2MGplOE54dVZLb29iSkkwWSt5eTZW?=
 =?utf-8?B?Wk9BeUEzeTVIa1NHc2MzNExOaWw1VTI5allsOW85bTd2cHV6VnRhckFaUmFD?=
 =?utf-8?B?U1BvUTBvMitvYzBQd2YyTXkyNndwV2EzTmdxdHRncUpWSHAyMWFGekN1SXFq?=
 =?utf-8?B?R1lpM3Y5eThEZHYyTTFuUUhNQ2VVTEhYZUtZRG96NzBMREF5TERYUmJHZHNp?=
 =?utf-8?B?eFdqMHc3c3JvcUM4dVJxVnFhQ3MxbjdWODhwSjMyNUtCbHhoWm01S3JxYnp3?=
 =?utf-8?B?N1h3TWxxUnlKNkxwQ3MzQU4xWkp5UjVXMmtwVDVQamZGK04zQUplbVRwTTBS?=
 =?utf-8?B?RmQxV1hKNjVnZ0pBV1JGZ0dUc3ZMK3Y1bHExeHRyOWZCZWlCV3hsd3hGd0Na?=
 =?utf-8?B?NlR4RXg5eVorRjF4YnI5VFplVXFlK2c1RDkyZjZoMVpIK1B0Y1FaRnpjeU5D?=
 =?utf-8?B?cm5PM3VCUkVEcTlsMzQ5MHJqZ1I1VmZKQ1FVS2hpblZRQ0c2R0U0d3U2TEg4?=
 =?utf-8?B?R3Q1ZEdyd29YTEZtZ1FZV3hHcUNBa05HVzA5Q2E2VlVmeE1mQUlwSkhXL3Vn?=
 =?utf-8?B?M0QwTHNaenlkYUhBeUIvWFdQMmpnS3pIaW5JRzJGaVptVG83eHNPMjNpbkdi?=
 =?utf-8?B?UmpWenptM1d1L1k1STloQ3J6WVc1N1BORFR0L2xYVGVrNXZaM21sK09lNld4?=
 =?utf-8?B?Z0dKQWVFOEhQVHB6a1MvV0RuUG1ibytabFcvNFhraW1BTlQyUDdLVEpKbG5Q?=
 =?utf-8?B?REJnQ2hVNzRWTzJuNitCSG5VNkNTSWlEaGZZMUpWaGQ1eElUdFBHNVFueW9L?=
 =?utf-8?B?ZjRWakZzam1Ddk5Iam9wbThhSjRvbEhhNjBqa2lPMDdlTmxUMjh4NFJzWlFQ?=
 =?utf-8?B?dzE3V21LMWdGTjZpYlJORGdOTnU3TXlIOVM4VE5zZmtKcUlhL051WEdZeG5I?=
 =?utf-8?B?NUVwcUpMUkltZmd3L0M3dWZsOUNGb3JVSks4bGFIQUg2V2VFNEN0QmsvSnFn?=
 =?utf-8?B?bHJSSGdnQWpTUGhtYzNlcFFPQjhLVUJtTkVGMGlWSklrazZqRkZaL2FtdVV2?=
 =?utf-8?B?YlZ6bkc2K2RPZ2JtbXRqRnpacmV6U0UvdFJkaEgvN2FTY2ZTazU3WWhXcDNK?=
 =?utf-8?Q?KJBz0rZ4Bv8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTZ3SjdHOXpieFFyMDZ6RlpyWHNIWGNaUXVpdWpXRGJKbTZISGNSdVJRb3Yy?=
 =?utf-8?B?SlE4NlV1UWRNQWZhNktEcDFrenRwUGRlQ1lFUzF1OWxBNk9pZGxvZ0xWVEF2?=
 =?utf-8?B?bWxaUEh2N1lXMlNua3VnSE9adXlVS3NkVG9LZHVzU2pqUGxCS0dLOGNURW1L?=
 =?utf-8?B?SGllWkZoS1Y0SXEvZ2FJdE9iYmRYeHlLSldGdGdoYTk2RkZndHhWTVNJc0hZ?=
 =?utf-8?B?UUQxMHZHQ21DeVFIWGNpSzBWRm85U3NhWXNDb1pXdThZbHlIelVrVXZWUWRQ?=
 =?utf-8?B?OXdIcjJXZUpIYWZVaHNsbjY0b2NhUzlGekpQN2RMbDErc0IzSllrb1VhUkpM?=
 =?utf-8?B?KzNycWhFazE1QUFubCtRbjhrWktNem93dVBQNjN2S1dLbmdLdDZZZUR1cXdv?=
 =?utf-8?B?dXZaSGpGbzkrQnZ2QzhENUE1OEpDK1lmSTN0QzdjaS9MZzk1Q3k3QzMveDBK?=
 =?utf-8?B?Yzl2VU9uNWxnZ1pyRW9XSXZEUFhXOGwxRmNhV3F0dWVoY1RiQlJjak43MGZr?=
 =?utf-8?B?VHhQaUp4aFBTeXJYMks2TTVHNkpCNFN1YjBqaFdMWml0NTczajJvbXczVWtp?=
 =?utf-8?B?cTRjRWJJWVBCWnFSQytsRTV0aG55TGgvbVdoaU5HRklIMWx2RFVNZVR5ZDlv?=
 =?utf-8?B?NzZVZVlWQ3UrYVRtWmpIbEp5MHQyODIwVFhnUzNnMklsTktZVTV4TWgreUhU?=
 =?utf-8?B?WFBEMU9oTVRJS1ptSGFjeWwwc29zNWdsR0dlZHFjbVRaMnFXekFKdlNlZWg2?=
 =?utf-8?B?Um85ZVhHbWlXRk9pTnAyU09nZmlPR1IrV3Ztb0lpcmZreFphaUxyZk9YK1dL?=
 =?utf-8?B?UWV2WnNGWWJ3UkVZblc5UVdxaWNuRDZZN0RRNHIzUGhGR1R0cklOYStLdjcv?=
 =?utf-8?B?M0RZbjEwNThLRTUvWUZyVEEyYVpuS1cyZ0pRYk51b01FSkFNanZ2TENWeHoz?=
 =?utf-8?B?T1gxdlVpQmMvVTBTbVUyeE5jZldHQURFNTRoQi9iZVNPM1YxOFFpUEdNQjgw?=
 =?utf-8?B?L0NoU0NPMlRudElkTUlrZnZOTG9yTDFNcjQrYVIxNUFzM2FnQU9qVlphaUFM?=
 =?utf-8?B?UCtiRFdta3E0Vi9idDVsUEtHQWRBOVNjc1Vxd080YjR6WTdWWVcweVBqNGY0?=
 =?utf-8?B?N1R0SmkyeVNndHpCeS9Idk9UOFZrUG1LdncvU3pnMFgrbUFUcTA5RWE3MGUx?=
 =?utf-8?B?VWNGSm9aTXFlKzJjMFkxYkIza0hDWFRLNXF6cW56UzMxUlB6blZZQU9Kc1Rn?=
 =?utf-8?B?dEY0OE15M0ZhSERqcDg0TW40ZGlKdm1oUjVIL1lVbURDeEczamMyb0Qvbmt6?=
 =?utf-8?B?eGowaS8veTViclhuZTFLU0JwVVhHYWtOQi90eXBLa25kWDhRSmxubkNsNkty?=
 =?utf-8?B?bUNkMW5jMGVDR2VBU1d5TEgycnp0OFZxcVZaZitXdnhCK01SNFhZRjh1U0NK?=
 =?utf-8?B?SjVsZVVUMHRXQmNkZXZkOTVpM2dYSUJGSEd0RDh6WVlobTlYTTcwSWZOMmhF?=
 =?utf-8?B?U0FQd0dLYW5BVlN0RURUeE1pQk8vT2RRVzMyUGhoZVhPZjh0REFWWHU1TjRv?=
 =?utf-8?B?U2JnZi9RTk8rS0c2NzdTa2c3eCswc1Uxb3Y2Nm1oWkpRNW8rZ1ozV0JVTEoz?=
 =?utf-8?B?TytxbzZRQkRiTjhVdU9UOWxkTFRMWEFaRksxbFo0dER1blMzQTZIVi9Pd0RC?=
 =?utf-8?B?ZTUyUTN3amw5MlhpMXQxanNTVGc3VFhmeGVTMVA3cGJkcWVSMHRsL2xpTGhZ?=
 =?utf-8?B?V3hHT3FsTHJleEZpdzlDQ1poUFNNdTdkUVVJa3I5SkpKQVNHc3A1ckV0MXZa?=
 =?utf-8?B?TFBLMS9ucTdUaG5peW5mY0lIbGxJNzlEY3B3L0NtekxGaEMzbWdpYzdyZzdN?=
 =?utf-8?B?UzRETUI4QWFySldNcGt2UEx4WFdsaDBueGd3Tnc4UlZVVmYvRXFBR01peGt3?=
 =?utf-8?B?OGRBeHBOdERabUlPVlJ6eXdHTWVrZzA5YXcrTjRuc3pPMHlRcTZHTUR0U3ZD?=
 =?utf-8?B?V3hBc0VBUDZGM29JNnM2NkVySkR4VUFLQkwxUGxkYmtSTGxzNzJpRjNyQTVW?=
 =?utf-8?B?enU5VVl2cW04YnI5R0N0aE83WTdtYjlLeXpxdXVSMWxUamtucnM3TWJITUg3?=
 =?utf-8?B?Yk04ZVlyeTJIelkwVEhYcXZMai8xLzFtR1BTQVNxTWd1RndKVGhvTFNZVjhR?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c03e8851-e813-4429-9689-08dde954b308
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 12:40:14.9604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mD9DEWJSCtdQRAC2EZ8NqyTsPAnwKSjdY7jUnqP5lqEfAE+mLfK+hYRxtRKWjJSp5+Cr6c6ggz/GUrSekMWWS/bVmFNQ4TBobDwXntYm/3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7826
X-OriginatorOrg: intel.com

On Sat, Aug 30, 2025 at 06:30:23PM +0800, Jason Xing wrote:
> On Sat, Aug 30, 2025 at 2:10 AM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > Eryk reported an issue that I have put under Closes: tag, related to
> > umem addrs being prematurely produced onto pool's completion queue.
> > Let us make the skb's destructor responsible for producing all addrs
> > that given skb used.
> >
> > Commit from fixes tag introduced the buggy behavior, it was not broken
> > from day 1, but rather when XSK multi-buffer got introduced.
> >
> > In order to mitigate performance impact as much as possible, mimic the
> > linear and frag parts within skb by storing the first address from XSK
> > descriptor at sk_buff::destructor_arg. For fragments, store them at ::cb
> > via list. The nodes that will go onto list will be allocated via
> > kmem_cache. xsk_destruct_skb() will consume address stored at
> > ::destructor_arg and optionally go through list from ::cb, if count of
> > descriptors associated with this particular skb is bigger than 1.
> >
> > Previous approach where whole array for storing UMEM addresses from XSK
> > descriptors was pre-allocated during first fragment processing yielded
> > too big performance regression for 64b traffic. In current approach
> > impact is much reduced on my tests and for jumbo frames I observed
> > traffic being slower by at most 9%.
> >
> > Magnus suggested to have this way of processing special cased for
> > XDP_SHARED_UMEM, so we would identify this during bind and set different
> > hooks for 'backpressure mechanism' on CQ and for skb destructor, but
> > given that results looked promising on my side I decided to have a
> > single data path for XSK generic Tx. I suppose other auxiliary stuff
> > such as helpers introduced in this patch would have to land as well in
> > order to make it work, so we might have ended up with more noisy diff.
> >
> > Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
> > Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> > Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >
> > Jason, please test this v7 on your setup, I would appreciate if you
> > would report results from your testbed. Thanks!
> 
> Thanks for reworking!
> 
> And I see the performance only goes down by 1-2% on my VM which looks
> much better than before. But I cannot tell where the decrease comes
> from...

That's acceptable IMHO.

> 
> >
> > v1:
> > https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@intel.com/
> > v2:
> > https://lore.kernel.org/bpf/20250705135512.1963216-1-maciej.fijalkowski@intel.com/
> > v3:
> > https://lore.kernel.org/bpf/20250806154127.2161434-1-maciej.fijalkowski@intel.com/
> > v4:
> > https://lore.kernel.org/bpf/20250813171210.2205259-1-maciej.fijalkowski@intel.com/
> > v5:
> > https://lore.kernel.org/bpf/aKXBHGPxjpBDKOHq@boxer/T/
> > v6:
> > https://lore.kernel.org/bpf/20250820154416.2248012-1-maciej.fijalkowski@intel.com/
> >
> > v1->v2:
> > * store addrs in array carried via destructor_arg instead having them
> >   stored in skb headroom; cleaner and less hacky approach;
> > v2->v3:
> > * use kmem_cache for xsk_addrs allocation (Stan/Olek)
> > * set err when xsk_addrs allocation fails (Dan)
> > * change xsk_addrs layout to avoid holes
> > * free xsk_addrs on error path
> > * rebase
> > v3->v4:
> > * have kmem_cache as percpu vars
> > * don't drop unnecessary braces (unrelated) (Stan)
> > * use idx + i in xskq_prod_write_addr (Stan)
> > * alloc kmem_cache on bind (Stan)
> > * keep num_descs as first member in xsk_addrs (Magnus)
> > * add ack from Magnus
> > v4->v5:
> > * have a single kmem_cache per xsk subsystem (Stan)
> > v5->v6:
> > * free skb in xsk_build_skb_zerocopy() when xsk_addrs allocation fails
> >   (Stan)
> > * unregister netdev notifier if creating kmem_cache fails (Stan)
> > v6->v7:
> > * don't include Acks from Magnus/Stan; let them review the new
> >   approach:)
> > * store first desc at sk_buff::destructor_arg and rest of frags in list
> >   stored at sk_buff::cb
> > * keep the kmem_cache but don't use it for allocation of whole array at
> >   one shot but rather alloc single nodes of list
> >
> > ---
> >  net/xdp/xsk.c       | 99 ++++++++++++++++++++++++++++++++++++++-------
> >  net/xdp/xsk_queue.h | 12 ++++++
> >  2 files changed, 97 insertions(+), 14 deletions(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 9c3acecc14b1..3d12d1fbda41 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -36,6 +36,20 @@
> >  #define TX_BATCH_SIZE 32
> >  #define MAX_PER_SOCKET_BUDGET 32
> >
> > +struct xsk_addr_node {
> > +       u64 addr;
> > +       struct list_head addr_node;
> > +};
> > +
> > +struct xsk_addr_head {
> > +       u32 num_descs;
> > +       struct list_head addrs_list;
> > +};
> > +
> > +static struct kmem_cache *xsk_tx_generic_cache;
> > +
> > +#define XSKCB(skb) ((struct xsk_addr_head *)((skb)->cb))
> > +
> >  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
> >  {
> >         if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> > @@ -532,24 +546,41 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
> >         return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
> >  }
> >
> > -static int xsk_cq_reserve_addr_locked(struct xsk_buff_pool *pool, u64 addr)
> > +static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
> >  {
> >         unsigned long flags;
> >         int ret;
> >
> >         spin_lock_irqsave(&pool->cq_lock, flags);
> > -       ret = xskq_prod_reserve_addr(pool->cq, addr);
> > +       ret = xskq_prod_reserve(pool->cq);
> >         spin_unlock_irqrestore(&pool->cq_lock, flags);
> >
> >         return ret;
> >  }
> >
> > -static void xsk_cq_submit_locked(struct xsk_buff_pool *pool, u32 n)
> > +static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
> > +                                     struct sk_buff *skb)
> >  {
> > +       struct xsk_addr_node *pos, *tmp;
> >         unsigned long flags;
> > +       u32 i = 0;
> > +       u32 idx;
> >
> >         spin_lock_irqsave(&pool->cq_lock, flags);
> > -       xskq_prod_submit_n(pool->cq, n);
> > +       idx = xskq_get_prod(pool->cq);
> > +
> > +       xskq_prod_write_addr(pool->cq, idx, (u64)skb_shinfo(skb)->destructor_arg);
> > +       i++;
> > +
> > +       if (unlikely(XSKCB(skb)->num_descs > 1)) {
> 
> IIUC, the line you lately added is used to see if it matches the case?
> But the condition is still a bit loose. How about adding a more strict
> condition: testing whether the umem is shared or not?

This is a different case. You have to be able to deal with multi-buffer
frames regardless of shared umem setting. Checking shared umem would have
to happen at bind time and then we would set up callbacks appropriately.
These callbacks would be about work done against CQ in xmit path and
destructor.
Since tests on my side showed acceptable impact for multi-buffer traffic,
I decided to go with a single data path approach.


I wrote a paragraph explaining it a bit in the commit message, let me
paste it here for some attention:

Magnus suggested to have this way of processing special cased for
XDP_SHARED_UMEM, so we would identify this during bind and set different
hooks for 'backpressure mechanism' on CQ and for skb destructor, but
given that results looked promising on my side I decided to have a
single data path for XSK generic Tx. I suppose other auxiliary stuff
such as helpers introduced in this patch would have to land as well in
order to make it work, so we might have ended up with more noisy diff.

> 
> Thanks,
> Jason
> 
> > +               list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
> > +                       xskq_prod_write_addr(pool->cq, idx + i, pos->addr);
> > +                       i++;
> > +                       list_del(&pos->addr_node);
> > +                       kmem_cache_free(xsk_tx_generic_cache, pos);
> > +               }
> > +       }
> > +       xskq_prod_submit_n(pool->cq, i);
> >         spin_unlock_irqrestore(&pool->cq_lock, flags);
> >  }
> >
> > @@ -562,9 +593,14 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
> >         spin_unlock_irqrestore(&pool->cq_lock, flags);

(...)

