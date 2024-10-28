Return-Path: <bpf+bounces-43318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A5C9B39B3
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 19:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85700282BCB
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 18:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7153B1DFDB8;
	Mon, 28 Oct 2024 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fE/Gbx/k"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80011DF969;
	Mon, 28 Oct 2024 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141646; cv=fail; b=sv+3fUQemyJhsK7vT+b873BMFCGTq2WFVEwgVXC5LNAz+4AK8E7hM4MO6tZOsFFSpEyI+2rltacEMqpBFNdr3zM3MQGPZuPGsiYOR53eoqXKuYa0gojq6DiHVBLZr7rMpxhskrvBsHrYmxIfzle+CdCXpQU1hghzNVH+vpHhS3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141646; c=relaxed/simple;
	bh=VZ0e1DQ0PMafaMGfDAEc/KikTp4SZDuohQnh0BzK31w=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HtWVe2k30kQnsdvmtw2jcEPAhnEO90DeDWQrR8gtnqb+db28P3qVq6i5v4fjE0nxRLP52ehdUwZP+dhz1P5+FkuI+IuW9S0rCO/Iz8ih9LKwiGFYuBrH66ZTdcmEZBjoBwVBhLbucKT1s4uvsDbs1So70z2RIuSAXc6jCiEXh28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fE/Gbx/k; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730141644; x=1761677644;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=VZ0e1DQ0PMafaMGfDAEc/KikTp4SZDuohQnh0BzK31w=;
  b=fE/Gbx/kODLjkQ9AtQtsmVoWz8vs1BE3bYj5C9G8g0F49UIzrVmHGtkp
   lIOadCqK678qnua71EH96/eSskB+6vwqiC9tQq7pFsTOAc8tCKGaRfycv
   G3Q1UEwAYzbTeWWmJMBuegyTeEouFTz5lCSq0mGidI4ifB3hwavDRsgbZ
   HdG+dbJGMXX9uQH8f8zt2K7fIUQe3yDE4YG3nwY2EFC5S+8SHC4VED0h3
   rYGVLmXDwfpatlaND2NMsfvvmblt1EpLoMM+4vszUYH4Sfi7UY+/dCvL+
   IMAwz3weQ19scplv8Bynx4H27zILeAING0M+DNjid0M7VEWt5sUPS8t6p
   A==;
X-CSE-ConnectionGUID: EZgLWh6uTiKi3AaM7UWiJg==
X-CSE-MsgGUID: znHxDlyzRm64c+4yHR/DiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47215201"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47215201"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 11:54:03 -0700
X-CSE-ConnectionGUID: t8F6/5trSrucMDXdUZalQQ==
X-CSE-MsgGUID: v0429yNOQh243m66uSeqoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="81636104"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Oct 2024 11:54:03 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Oct 2024 11:54:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 28 Oct 2024 11:54:02 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Oct 2024 11:54:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNa42N9w1BbkVjOxtw2zWzyM0dvHbHoAcrnLv6blkDaFMOmrCEHon1Rd2qA4nVyScrrbc+IB3Y18jj0Iub1yI05HR81KhWGivexIYRTO/c5BQ5vDPVNn4U6wI9N1li49yYJLocnWLx+QBM0HNehbtm6+vokobI2K2eoqikmsYGI9szdSkXp1xODcIY86Q/cLEFVKXSGwrfm/IxUM9/8A9fn5QTz988PZ0mN1YELmAgwlJsDteNE4PemDiio8+gcwaFdCerksM4Az4sabB2tgV+txrCkGPTZ7M9KwLP8rfXI1TwlQYUR8DVLAV7QPpt65kO8EUvPTCTVsNhik7ILQ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isVGouseWroNVsvsN1h9KwN6LHRPXQezwH+MAB1ChoY=;
 b=lQUbnua9f/ZqR8jJJATh4nawP08J2sSC29NByc9qN4Sxm3HD5RNWP/TodjFAMzXI7zHwty/nhgqhtfcPczcxQ9hgGCJ+DCv8VTBuUDE89KpiXBsIwB5DCWmVPrsDkm8/2y/2sbDLWjJxTRULElJPFOMeKoDLXGqABwPlrufb3GAl8CN0zueBAfnZoGuV1pnoFiwEzS90Or0uuefueOX2Qq37axAd7f4TXwezvPnJFfpmdpe/5fvmp9Ynk2vU/tqlV3N/dUAxZOl2uHSNLKRzuKNbxbs4hkxBsFcjxw1ELu+XulcDhogkvLev1/oWtzHK/r6ksqnK6+CIfUl3IeSxVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN2PR11MB4551.namprd11.prod.outlook.com (2603:10b6:208:269::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 18:53:59 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8093.025; Mon, 28 Oct 2024
 18:53:59 +0000
Message-ID: <529d08d7-94ee-43da-904e-cf89823a59fb@intel.com>
Date: Mon, 28 Oct 2024 11:53:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [iwl-next v4 2/2] igc: Link queues to NAPI
 instances
To: Joe Damato <jdamato@fastly.com>, "Lifshits, Vitaly"
	<vitaly.lifshits@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "kurt@linutronix.de" <kurt@linutronix.de>, "Gomes,
 Vinicius" <vinicius.gomes@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, "moderated list:INTEL ETHERNET DRIVERS"
	<intel-wired-lan@lists.osuosl.org>, open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>,
	<stanislaw.gruszka@linux.intel.com>
References: <20241022215246.307821-1-jdamato@fastly.com>
 <20241022215246.307821-3-jdamato@fastly.com>
 <d7799132-7e4a-0ac2-cbda-c919ce434fe2@intel.com>
 <Zx-yzhq4unv0gsVX@LQ3V64L9R2> <Zx-1BhZlXRQCImex@LQ3V64L9R2>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <Zx-1BhZlXRQCImex@LQ3V64L9R2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0204.namprd05.prod.outlook.com
 (2603:10b6:a03:330::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN2PR11MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: a66eb47c-07cf-4d15-2cde-08dcf781e1c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWZtSDNpaEZtVHBvTVN3Q2xmUkVHUkFYeGs5SndFVExLZUd2RUg0RnBJMnkr?=
 =?utf-8?B?ODd1N05lTzE4R0l5MUxydXgySndWQ1RBOERqNm83cE8zNlBNZnh5eS8rN0d5?=
 =?utf-8?B?VG5VMkdjZkR1Vk5hZFo5OUIrbzY0MEVMUjNZU0p2R2xQclVQVHJEWjRZSFVJ?=
 =?utf-8?B?MER4aklqdnhIL0RmclNmc1JwdUJxS2tPSHVrNGJwc0FNKzB1Mmp2alpiSXpI?=
 =?utf-8?B?UENLbjlsWmVQNEM5NndOaGFRRzRlNWtBS2hreDg0ZHA3SlJ6UjIrN0t2MGUr?=
 =?utf-8?B?YzIwTVNPQkdMMUhCbjRwVDgyTEhjN1lrbnMxblBVNjlIM1kyU3JwN1NxNUZx?=
 =?utf-8?B?ZWhrMGtsaDk5V1VDQkVISDI1TFpEMWhLWk1FSkNFRXBXMnY3V0I5NW1LWisw?=
 =?utf-8?B?SzBneWZHcVJUMjlleHdTd1JrN3QwTmpLSmgxNTZzMGVPN1ZFUXhMNFo3WEJO?=
 =?utf-8?B?bFNFM1ROWGQyNmxTT0NJODFpZ0NpVHBlTFg4eEhmRTZtUzRGUWUwY1ZMWWlT?=
 =?utf-8?B?UERjc1g5WFVMMFJ0T096ZS9pa2NwVElRblU0dEkwNjZZd1Z1TVRrSVJ1clRM?=
 =?utf-8?B?NHRCVE5QSGdiNTd4OG54SmVPZVJkcW5HbWI3L3B0VlBnakR0V0dxUEpEREpv?=
 =?utf-8?B?UFV1SWZWaU55ZGg5M3h1aXhpWkxsUVpCbVYyWXFtV2hMV25pMlBpY1NSOXVL?=
 =?utf-8?B?dzVUN3A1RFlXenRpWnVlbFFFNmZ3dGhmeHhXVFJIb3pvVmM0Z1Rud0duQW5N?=
 =?utf-8?B?M01YVXN1cHFkbHhsYnhlSnB2TWRvbVZxbWh2VzhwV21TWUJVWlYzQlJKUHNy?=
 =?utf-8?B?dWtaUDBPRjc3cWI5VWxIQkI1Q0ZNMVJiTmNXcjg2SkVrRXkya1BoTXB6MW5P?=
 =?utf-8?B?aUNwSlRnV1hGVCtmMnl0Yks3SkMwNFhzV1M5dTU4ajExUEJvVVlTMU9JejNr?=
 =?utf-8?B?VmY2SndIMU02RWdWb2hKUFNGWDRrd29aY056R0lrRmFBdzEwd0xTVFFHL3g2?=
 =?utf-8?B?OWU0M2RMS2xuUDE3b3EwNXhEUTgrSGc1Q0FNN2JYV2cwVjRrUlQ5WmZxL0hi?=
 =?utf-8?B?aHdOY29naG9uODRVL3Zuc2JKakIvdDd6YzM3eW1wK1lxYjdKQ0orZklwVlVM?=
 =?utf-8?B?eTJDNS9Wa1AyU20vU1NZeS95WVJDaXl5aGh0bTZjZEZkaGtvbTFYb2VUQ1Zw?=
 =?utf-8?B?QS9lTDdFa2tJVmVFWDQzT1cvRUgrOWhtcWxvTnJoWGM0SXRYcjc5V2N3OC9o?=
 =?utf-8?B?QzREbHNzSnc0OHVSMnhTWVVMaW9paENDTStQMVhuS1grWmswV2Y4cWVGT1Ev?=
 =?utf-8?B?NUNQT2FPRDhkYmJsVURNbms4U2xvMzgzdmlPc1poZTZHUnk5UVpBN2pGMVBu?=
 =?utf-8?B?dkxucUVhMEIxbjNoU3R3YXFkQXdyaUtma0tHNGNGY0pGK1hSOXpNWm9aaUM3?=
 =?utf-8?B?RzRwcVpodDVGQkVobldRNEtCSjVQTmd4TG5tVDBUWDUxMVQrVWxnSjk2ZlR6?=
 =?utf-8?B?dmoxWTUzYTlQRTZwS1dWTEp5WlMyUmtSU01zS1R5UEl0R1ppMGRRMURVMHI1?=
 =?utf-8?B?SURBZHVKQVFsSXh1N2RWNDVpMzNWYlZUY3BEUUF2ci9MWnVjeFVlc205a3Jn?=
 =?utf-8?B?Z0ZRNFVYSVVLZ25uVmxXNWhYV3RQbFBBSlJhdFhKbGxEcGROREZ3MW5FMjhz?=
 =?utf-8?B?a3VsTTZGNVU4TndqMldoc2doSzdwc01na0RVSHA1ZWJ1VVhISmxuNWllUWEy?=
 =?utf-8?B?Y0pQQTBtN01tOG50bzlzNXp3NDBVTmlRSE1tU3BMV3VyTm5ZR1oybTZ0SHAy?=
 =?utf-8?Q?v6wXpAH39Q64mYPY9WSPYGo6GLYjmK200roQ0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjlQYmljYlNmMTE0TFFXd3pEL1lNUVlsWU94UHNiYkpqSzZ2MXZIQVhBQlAw?=
 =?utf-8?B?Y0RyUjAzTEFVTUkrWUt1d1RTRzVWNXdJNXpMakR5M2Nnc1o3YWtiOUc5U1hQ?=
 =?utf-8?B?dS9xc3czYUZYeVBJM0o3MmtUWWl2cmZlNytJL0ZCdnV1WFh0R05ldWNrY3dI?=
 =?utf-8?B?U0NCeVBqWTJHT0FCQ1pDYjZ2SnlCVzQ3WVRMZDNBNjRkWk9MTEwvTlRWZ0xT?=
 =?utf-8?B?c3EyYzJYTitBUXl3cHhpRDhxWDN5WUZtTlNIeEU4elFzSytrRDZjNmNTQkdG?=
 =?utf-8?B?RGNFaTZwUU1kUE5FUjRyTDFtV1c4YVVEUjVHbnFxS21wbWx3bnNjWUx6eHhJ?=
 =?utf-8?B?QUZVQ2FiVVhaYjBzWHhVdTZnckhpaWlFcm8zdGtrSlFPRjc0UExiZlQxWE94?=
 =?utf-8?B?aFM0YjVTSWJ4bWRMYXN0cXovNmNabkJYdmZLdkpRQndyVEx0bkZUdUI0VC9M?=
 =?utf-8?B?aEkranJFWU50NVJqYm9EYmVweDRTTlNZenJDWFJhYnFyQUVFWlFqR0NCVjcr?=
 =?utf-8?B?eGR0Z0p2bDVuU1A1S21OY1JlMmJVcEY1aFBKODBJNFgwV2dGVi9OQmdqOVpm?=
 =?utf-8?B?WVZwcjRCZVc0eURrQVp3MGVpeVRqS21UMnE5MzZpOGJvdHgydnVkOUg5TTlC?=
 =?utf-8?B?WWd4aHNId09DWitmU01rODlmTE9YcXZtWlZYVFgvU2NBcWI0dGxDblJWbHBh?=
 =?utf-8?B?YURzbXFvMkFCL0RyeVNjTTBOSHdRMnI3eFByNmZqaG5pTzZDeXlKOEEvNTRn?=
 =?utf-8?B?SEw5MzdWWjhTV1d1YlUrRXJMNEJUeisvaE5zbVhaaCs4YzFUWnY2WXl6MGs2?=
 =?utf-8?B?dFZ0bVJjQmxBT3JJdWRZUHYyMFNwOGNISG1rb0tldHFnV0ZMU0V6a3M1Yllv?=
 =?utf-8?B?aGRLQmF5cy9aOEt3WVNGZ2luUnowa1FxblpPSllaWE93RHlwMlhEclFJejgv?=
 =?utf-8?B?bUpCSzVROGNGTXhNNVRleDhycUJrRnVsUUZMUUZ0eDFjWUJJdVRaSXNQaVpB?=
 =?utf-8?B?ZEZjc3VCK0RlUlE1eWovbTNLWFdlOHBmVXhZV1RGeHRodWdFUThDaTZVVzlS?=
 =?utf-8?B?Wlo5ZS90ajlxK3RFQ2RVeWluejVYQnc5Q0kxTGZiOWk4YVVGeG9NYXhsTm1Z?=
 =?utf-8?B?UkRSUXRKbDgzSVc2NmhKVlJxQWpHSzNrYStGc1UwZElybnAwV3o2anc4eG9r?=
 =?utf-8?B?Q1dxTHpKeDNWNjgyQVRVZmdGbzIzVWh5Wkg3dW8zb2RJckJ6aHJ4RDJ3SUxT?=
 =?utf-8?B?NXU0VFdOS2oya0d3YWtRM3FHMERFRkM2SUYxY1FvWEhVdHNwOWRsOFA1TTJx?=
 =?utf-8?B?THRoemhQSUVyTTJocGk2NWJqOFFHL1V3RDhZVjdzeGpCM09zdmNEZWd0QXBI?=
 =?utf-8?B?QStPRmdFaWdXNitmelN2ZDMvOXhSQUNLZEV6V3FRNHcwYmZNUzZFQ2IxN2p3?=
 =?utf-8?B?V2JJK05ZdStDakpSeTZqdUxuMmN6OURUUjEyOTcxY0I2ME5FT09aaGdNWUxZ?=
 =?utf-8?B?bURhTFA2bWVnWDQ0SFpWQm9UVFE3eTBJV2JVbktMRm12QW5qNUNrc2pRWXlu?=
 =?utf-8?B?d3p0b2taN3EvTnc5Y3llbG1EYjZieTJiU0ttSnN6bmlwb090SGEzNWo0U0xt?=
 =?utf-8?B?dVdWU0hNZFhjd2Q4ZndTVUE0ZExGTzFZRDBMQnZDS0o4UEJJamJPSzVlRXp3?=
 =?utf-8?B?UjlIYStyMUs4Zm9UYWlKZXQvQTZxWUFOM2xsdGo1N2RRTWU1bFJpTlVPbHBi?=
 =?utf-8?B?akMzaGl2djBNb0tVd2FFRHQzUlA1OXB2Z0J0aUNqaTlITnU4ZnIzbVNQYnJz?=
 =?utf-8?B?cGZpb1BLL3EwaERMNnd1c1hYRWNsZHRDckVnZml1ZHJTYUNKaHJXUUl6YlNn?=
 =?utf-8?B?U2JDQi9SZ3JlZGd4NVB0Yit1K1J0S2hUaC9ta1Y5QUhPZE9XMFVaNlBVV1h5?=
 =?utf-8?B?QUNyaVhQTkladWtpd0xPczV3d2NYNlpxZEVIVlR4ZVFqUGlVbnQ2dFJoSVY5?=
 =?utf-8?B?OC82WE9EQXVDdHZVSjN2RHJXOWdEa2dRRW1iUVVHelRsL0c0TWdWRWtVTG9G?=
 =?utf-8?B?dGJ6V1Z1ZVZZQis4RmVEN0dRak9XU0R6dGxJcDU1WW90b0hWbjUwbzMzZ1JF?=
 =?utf-8?B?TVFPUkE3cjAzQkhrbkNEMFlJZm4yMG4zdnpxNm13ZEZPRStPbEVqL004aVVi?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a66eb47c-07cf-4d15-2cde-08dcf781e1c9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 18:53:59.1858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6hmPH9u5lZoe2p3fRYtKz4DsO1rJXmaNBf1KTG8yxCossOZwaVmpz4CrV28ujDS8nz8ucVkWHDkJvLDwBH6RWakuITKp//e2Oa83jhRofM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4551
X-OriginatorOrg: intel.com



On 10/28/2024 9:00 AM, Joe Damato wrote:
> 
> I see, so it looks like there is:
>    - resume
>    - runtime_resume
> 
> The bug I am reintroducing is runtime_resume already holding RTNL
> before my added call to rtnl_lock.
> 
> OK.
> 
> Does resume also hold rtnl before the driver's igc_resume is called?
> I am asking because I don't know much about how PM works.
> 
> If resume does not hold RTNL (but runtime resume does, as the bug
> you pointed out shows), it seems like a wrapper can be added to tell
> the code whether rtnl should be held or not based on which resume is
> happening.
> 
> Does anyone know if: resume (not runtime_resume) already holds RTNL?
> I'll try to take a look and see, but I am not very familiar with PM.

I believe the resume doesn't hold RTNL, as its part of the core device
code, which is not networking specific. It shouldn't be acquiring RTNL
since that is a network specific lock.

I believe the code you posted as v5 should resolve this, and makes sense
to me.

Thanks for digging into this :)

-Jake

