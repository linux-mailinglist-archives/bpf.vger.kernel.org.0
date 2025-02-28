Return-Path: <bpf+bounces-52890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FC7A4A219
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 19:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78922177E1C
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 18:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D9C277011;
	Fri, 28 Feb 2025 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UOQrLxVc"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F3E277005;
	Fri, 28 Feb 2025 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768544; cv=fail; b=SQLZMeosysf/bTqK4quhaEAPN+gjvqwnuqQ6N8N9xiVtGwFDkcWh0RopEB7etpB4UyTbIwVoSJG+/WUciBb3s1z0eIYJVXzFUray0c+PcRZkxA/N0dEcO8Z599FK+KfoZ6tVcsHkd/wW95U4zy0PtvcG/VJ0iOKMBUde76vuII0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768544; c=relaxed/simple;
	bh=8yrqqwuyN3eM4jN6VhQin6E4glcnQHObsl36NLA+Ikg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V08BJnnmLu4UL0NcZ9H1NE8amK01LWwMm+dcCyfhhGng2z0C0y3N7f4b+0jaTvcTtl6BElIfqE6FK7UctbPI9+hzuj5Yk15ANZjpUlc6VB6n9m1GhEnSWVX4g6fsfWpRkORMLO+q48IBqXyPvMqbcsS7XIO+2L5S31xXKaJ5v/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UOQrLxVc; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740768542; x=1772304542;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=8yrqqwuyN3eM4jN6VhQin6E4glcnQHObsl36NLA+Ikg=;
  b=UOQrLxVcvjLBaVqATMNbfIDJEzYOTK6B9z1N9dWHIWik8r3TimWV8T5a
   dD9B7zkLsDUrTYDKYemc5i5B0fKhrlbLSKRGYSr5+XXZm9RyHGuFXS+Md
   tf5FuO9cpWzbKLtw2XB/qqwWSDkf2XdqdpHdGirjNSXSjczDgQ8XB2JdI
   QNJGhAfEFb/rsKI/e7tR1EmDB4mnObNBAocEflW06mF0ZJJyKKH/l6sAY
   KHxvSYufR6oHMd+pMcAKfwZ/ztvi7LzTEtvOp2wTfVR60ZP6e2gpIcf0b
   0BtY954JwmBx9kMma4my/PShKRnUzWAIasfXiJm7Mb6oOgklR0xj8Gl1P
   A==;
X-CSE-ConnectionGUID: b9EhLR6NR02aElGMS2mBUw==
X-CSE-MsgGUID: aZBBFeVCQ3Sf73nDSpXq6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41827715"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="41827715"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 10:49:02 -0800
X-CSE-ConnectionGUID: kPlyXOpiRRSHh4bgZ9Fqig==
X-CSE-MsgGUID: gv15dsxHRl6/zIRzJjN56g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="148219935"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2025 10:49:01 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 28 Feb 2025 10:49:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 10:49:00 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 10:48:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXrvAfMYneCDho03LLyB9yzZ+nCgJI1nyJQI09Z9pZsnB9JXzOsdCEMD4wjmCotSLdyc1mST1yyi1iZIMOvIyRZhTyCVaP0+OiF/rFbXKoW8ELTy/MjL1f/fi7a+mCL7fSme7e597BRyfp1seR0pxO3IPhkqPudxeScDUzgpXJkf9JpmydP4bzoF77uEUitn/F1GkZanjDZSKC9QftcOZKnTHsMTljJKfZpjgeA6VtHpfLDhXNlL741UBzCeEPyxDpx3Sc8iyAx3xZ8pPmECNUvQPpvP1rm0xLwOvBjD4/Gecr9l9C6Pc2RYqxpdJVBwWPz8fpNF3YbwMRi5Ka2O6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLDByeTK0tD8pFAwyDmEGYTDZZjhsGNYfLxl9glvq3E=;
 b=TfAExwj9gkVRL4+HpUPsKdvfNcmpWWNbYmDW4m8c3yxF/NBJwX4LpIiKPEQnya7oXFbmmYMbyh0tGQqnbNf6o2DGq4j0zrDtjtvMw4M0kxJlbL4eCs8+pDdGVOFOoovTyEQ6ms8dv5BxSwTFQGHrHiB/Bv65V9k9FomJ7KWTlahlJnCdfCAG57BOyjNg35VFMZVJL3uvlcFcsFS0pvXTl0JNTIfStnyLd61+ww2rtG7lm1r6mocWuioK3T/UvrSU/KiIJkvcdCiNsI2bBVO7WQAN11LX6HJKVH2Tn3bwH/18mpsXxh5dSlx4LWznrZ7RtOSl4GPnbqVKFXxgP9vPFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CH0PR11MB5313.namprd11.prod.outlook.com (2603:10b6:610:bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 18:48:43 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%3]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 18:48:43 +0000
Date: Fri, 28 Feb 2025 12:48:38 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Daniel Gomez <da.gomez@kernel.org>
CC: Luis Chamberlain <mcgrof@kernel.org>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Daniel Gomez <da.gomez@samsung.com>, "Petr
 Pavlu" <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
	"Alexei Starovoitov" <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>, Justin Stitt
	<justinstitt@google.com>, <linux-modules@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, clang-built-linux
	<llvm@lists.linux.dev>, iovisor-dev <iovisor-dev@lists.iovisor.org>,
	<gost.dev@samsung.com>
Subject: Re: [PATCH 2/2] moderr: add module error injection tool
Message-ID: <e6jybeg4y6q6zqyhqma7q4icw7jllieq5rwwi5pguy242wioyp@hkelxx7tnzlg>
References: <CGME20250122131159eucas1p17693e311a9b7674288eb3c34014b6f2c@eucas1p1.samsung.com>
 <20250122-modules-error-injection-v1-0-910590a04fd5@samsung.com>
 <20250122-modules-error-injection-v1-2-910590a04fd5@samsung.com>
 <CAADnVQJ8tYSx-ujszq54m2XyecoJUgQZ6HQheTrohhfQS6Y9sQ@mail.gmail.com>
 <Z5lEoUxV4fBzKf4i@bombadil.infradead.org>
 <qnfhjhyqlagmrmk3dwfb2ay37ihi6dlkzs67bzxpu7izz6wqc5@aiohaxlgzx5r>
 <Z7je7Kryipdq6AV4@bombadil.infradead.org>
 <4xh2oviqumypm4r7jch25af5jtesof7wnejqybncuopayq6yiq@skayuieidaq7>
 <ccofyygi4rerybdmecqswldykihtabx6yco7ztylqnbmw4a5qw@ye7zoq7mcol2>
 <3ehu3r4hlsf7cpptofz2y5aq2bazidq4buxbddqj6gzvzd3eh3@wzlnbvdsc6ty>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ehu3r4hlsf7cpptofz2y5aq2bazidq4buxbddqj6gzvzd3eh3@wzlnbvdsc6ty>
X-ClientProxiedBy: MW4PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:303:b7::21) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CH0PR11MB5313:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b105ca-e18d-4276-6418-08dd58288694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlExb0pWOXZlSU5yWlhNUGZ4ZVBmWGNEbjB2NnA3L2p4UGZNZVpLNzdzK3FH?=
 =?utf-8?B?M25LRlpCaFpySGd2UVFUY05yL1Y5aWlicUNZQk1YZlA1OHlwNVZNNFp6VFNO?=
 =?utf-8?B?aXl2citWek1TaVE1V1M4dURTNlJteDNYUitndjU1ZUhnU3V3NkJNdGJXY2FG?=
 =?utf-8?B?YVYwbDRUR2RJWWdnZlZtVTRDc05nSjFrVHE1VkNXYzFyM3dnYStlTy9XNzJp?=
 =?utf-8?B?R2VnYW5NRFFEY2g3dnpSeG0vWXBCRHJENFB2WVViNkVZQSttOEVRK091b2FN?=
 =?utf-8?B?bWNyVW5LY1doUElTYXJ4S1NvNVlMbVBQWXVYdzltTGRZVEpVb2ZaMm9wT2Nh?=
 =?utf-8?B?cFVYRVZranM5bWlYU1R2WlJXYjk4UjRKVkJiMCtlM0lNR04xUWJQcDdLQzVh?=
 =?utf-8?B?dVI3cFpOclFSblZ5aFFxbkgwaEN4OWlhZWY0YjBHbG93NkZXaE1sVFVNUEdh?=
 =?utf-8?B?cTdiNmdFN3ByMi9yR1c4eEV0UlZieFh6d0c4ZDNvcUxoTExaNlY0RUlFZ2dW?=
 =?utf-8?B?eTZUdG1ncE9JZ2luRmFrYmk4eC92VGwrdlQ3ZjJaRGY1dnBjK3A1RVIreFNa?=
 =?utf-8?B?dm5Ta2FtRkh2Q2RoUTRLU3p0MytaSHdPT1J6Y2FVYXA3dlluSzhxWWhaN0xo?=
 =?utf-8?B?MHRnczVEMWJtd1N4TnJXdjdSRXFVai8yZGZWeDhZazVOWkhHd24ydWVpQXdY?=
 =?utf-8?B?MFRLdGVmcFdBVS95WnlJamV5UUZDWFZZK3h6WFg5blVNWHNKeDh3MVEvSE9t?=
 =?utf-8?B?NlZFSEMvcjlQRFdXOUtRSVdueGp0QWJlYTZ1TGdvMy9SL0NZYkpzS2NJbFE5?=
 =?utf-8?B?UktMM0tSNGVYSEh5d1BjOUZJK0IyR0lwclpYSG15aUxHSlZSY0tqRlRzeEFM?=
 =?utf-8?B?WDQ1Y1hEM21ZS1F2WjdmSDVoSmplK29DL3V0UWF1aVd5WFdseDBURjJId0Yz?=
 =?utf-8?B?Q2laRjVVckV2K2NwTFZNSjZCaWtpM3Z5NnpMVU9reVZGVVRYL2Rid0U5czZY?=
 =?utf-8?B?em5wbVhnUjI3YjlFZWxtVHZBcjN0RHdoU1RUQktwU1R2NzY2OHd1Z0tuYWhN?=
 =?utf-8?B?ZEpRTXV6UElNdUhJWjFZenpKWmNaWTdVaWpOOE9KYzF3UGM0Rlhid2Q1VGhy?=
 =?utf-8?B?dWszUFdseWxyTHB1N1hVeTZZcWRncUM4aU41RUQyeXZuckRCK0JIZGpsa29P?=
 =?utf-8?B?VHJYSjc0Y08yVjM3RnRYSUtxMFJQUEVUMUJ4aW03SG5ZeGY2VWhibldHelF5?=
 =?utf-8?B?VmlSeUpXdVh1Vm5VQ1luVTJxOTh0b01EdnVQQldPa0dMVTVsNWsvZk5OaW1u?=
 =?utf-8?B?OEVvM2JmSno1d1V2bjlNRHl4ajlaUlp4WEI4MVdxVFdla3pKeXN1ZEtwdDhK?=
 =?utf-8?B?bTBaK0hLR25pUmU3RzJBNUIxRzVXaFVSTjhKenVBRkhHbWtSWitEZXBGVUc2?=
 =?utf-8?B?YSs5V2VzK0NnY1I4TFR4TWk4N3gxRnh2c2hxM2JHS3B1Z1B1dFRmUmtTZ3lO?=
 =?utf-8?B?WC93Qkg5ajV4Y3YvbERYMWh6czRhUS9IVlBJNlFPeWdZRDFRWVpFODJSclFP?=
 =?utf-8?B?dHlxeVBlUkNsTkhDN251NHZWNkwxRWpPdERzalZCcldIaWdsSHBpOUI4NFd5?=
 =?utf-8?B?RCtvNHhLczVvWUkrSnJBTC9tNVpoRWZpdFV3QXZ2ZzBtM2Ezd1l1VnBGaXlp?=
 =?utf-8?B?RTV3R2tKT2dDYWlxR0toRGRJYmdXSjVrdHhxYW9iSFcrQkI0QjVRaWJTVHFT?=
 =?utf-8?B?bUg4RzJGY0dRV3E0N1gzelFSL1I0RmRtUmRXYlhHNTFscFgzOGcrVENvZ3Fq?=
 =?utf-8?B?cFNUSllIVHdOVDlyc0ZZdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M25lRW1pNWt3QWY5SUIvNlpHbnJsK1grWVhpOEZUYVlGeWJ2a0svTFNqODkx?=
 =?utf-8?B?aXB5WG0vRHRYalNKdllncWg4dWR0N3h3RG9XOGg3Rm5UWmFpTHdiTkdaR2lM?=
 =?utf-8?B?R0t2bW5YNEszWGhBMER5bzh0a3h2ZFNuNFdqTTk5U2dEUU9yYzFVKzZqajNV?=
 =?utf-8?B?WGljVWFnZUsxRHlhT051RDg2Wmh4cDBHc20vTThLbVZMZUZtbFpPa3F5K09V?=
 =?utf-8?B?VVVwclB1WnMyWTMwVUxRWW85MXhmT0VrQ0NPMzAwWTlkSUJKdTByWElxM0Zo?=
 =?utf-8?B?Z0dldktRVHNqdlF0aklyREd2TEJ5dlRZTWpsbUxxSVpISisvdDM1VmF1WG5R?=
 =?utf-8?B?ZFYySFNOd1ZQaDFxN0RnT0FGYzlneFY1QXkrRzByaHdPNkJaUTA5NXF5aHEw?=
 =?utf-8?B?b3RkbG1maTMwYVZ2UE9lcVVQdmlTNnRwVEZ3UFBTNTdtZEdjUUF1a1pJK09R?=
 =?utf-8?B?UlJFcXNCOHJ0bzVNbFRUNWxEV04xTTVsVEIxcW8yaHMweVI0c1pzLzFzcVN5?=
 =?utf-8?B?UnNCdHM0SGJrZEJBQ1JNNEJKWFpCWTIrWms4MkJBMmxuaXJFSko4MVlneS9j?=
 =?utf-8?B?djZrdSs5NG03QXVPVDBIN3Npd0xEMUpwUE9NUElUdlJKbEVGSzExb3BsZWdU?=
 =?utf-8?B?RWs0N1FHUGhXcEh5T1Y1VjZsS0dVZGZoY0h4VFBweHAzYjVOMzZ5d0VjSGNP?=
 =?utf-8?B?eTcramlWdEE4M1NjYzBqOEtHWmpQZHY4QW9nU2U0ZDFXR2ZWYXVTZjdmS2F5?=
 =?utf-8?B?R2xYZ2RqRFdtV2RndUVBSkp1dEVPNHlycGRSZGE5cFo4VFp6QTRSMytYRnNJ?=
 =?utf-8?B?OWxIbTFDZkRnMlJ0WDYrWndGNjlPbCtGUXBDdVhYTmxSclpKYUhWSzliZndN?=
 =?utf-8?B?eCtURFR4WE1ma2d6MDNPWGtOUmJsb3pwWTU0Y3hmbGIzS1NvZkd5UC9Hc0g4?=
 =?utf-8?B?R0FLQkpxaEQwUG1PQUF3TjlpRWdWMTE3aUpmYUpSeityU1FPblZ6Vjl3WU5r?=
 =?utf-8?B?Qk5xZmE5cFgxRWRxeE1nYjdaK2k3aDlHc1h0Q0kxdmdtOWMzMit6OUZTVWNi?=
 =?utf-8?B?UC9SM0tjV2t2Vk9LOGprblJRSE5HRVdhMjVaS1Mvb01ZdnpaRWR0TVlaWUVQ?=
 =?utf-8?B?Y2pDbENQeHVmU0RxL2Z2RkhUYjhKK0Vmd3RsSUxZMFJVUW5RenlJMnlna3pC?=
 =?utf-8?B?eTg5ajZSVE1hWmxRRVdWUE05WmZKVy9hQXJPTEZidml0c2pOWFplZSt4emI4?=
 =?utf-8?B?OThpeDlud0N3Wm1oZzFmcmFibEVMckVRWkNGQ0JoTitheDBIR0wzc25LRFhX?=
 =?utf-8?B?N0FLakdKZzNKT2t5LytqdWhTUXdvUGNkd1l5T25iUExKUTRpUnppSm1DMGo5?=
 =?utf-8?B?RFBMZHBmaUFxUkdDa1doendyNGFpSXZabnBPWnU2TW9aaDA2ZFkxd295ajN6?=
 =?utf-8?B?ZVZhV0N3Mk1hKzlZRm5DYXRWMnF6Qm0reEtab1RCckVhV2kzZE8vQjFPQ1py?=
 =?utf-8?B?cnRVNGwxTmszaDVMNHc1MVZzVjhHZXZia0RHSkROeFNIKzRkL3J4T2hiazlE?=
 =?utf-8?B?MnVKcXlxdDBab0VUN0UrSnpOektFdjlRdzF6UHNBQ3NqZzNwa1ZzUW4yWm9p?=
 =?utf-8?B?NnJrb0FzdTFCbGF5RTk3Z2ZYaUIxRkUyRTBUbGFsZXpRclNJbUpRWnk2eTkv?=
 =?utf-8?B?WU5nN3AvenNSLzBxaGNLdzl1NnNsbnYrOWJoL2xyUFlCTERlYVlXZTI0dEpP?=
 =?utf-8?B?R2Z5UzRPUXNUOUxSUHZ0b3BoZWQxdWV3QnZ2K2c1cW1ILzVGMUo2bU1lbWJW?=
 =?utf-8?B?T3VydVBHWWl2a3FRWWNZckh2alc2OXJqVFk5SDZjTi83ZElzK2ovc2kxOXgz?=
 =?utf-8?B?ZG1BNXZwdWJMaTNNRDFUdUNkSVp4ZzFTUVcxMmp3Ynp3OHoxYlBDVis5VFpZ?=
 =?utf-8?B?a0JyUVpTZS9FN05uaFd2OFNtei83V0pwT2xNakZrMGN4UzRPVnEyYUtqLzcw?=
 =?utf-8?B?Q2ZkSEYvZmpzSTBHblIwQllUZWNIKzF0c2dJOU8xZ3NDODFYdTlTUXg2MGU2?=
 =?utf-8?B?dVpwbUM0QjBaMGQ0RHlsQSs0YmMyMGZ6N2tZaDFGOFRlVkFDUnRLK1k0cWJ6?=
 =?utf-8?B?MWdZVURCdlJCSWNtUmdMd2lEQStNUjA1Ynk2MWJKUUFPdHV4Z1lUdkRFTVhT?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b105ca-e18d-4276-6418-08dd58288694
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:48:43.8365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oco3BCTr0jHcQAYpFmRQ0lEUpGTzXifbxF4c39bLl7bV3j96wmec65lUxA66dees1ylyu1tgyliXXoDPRbWeYlC9I+ZjFn9NKyyhnNW1pTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5313
X-OriginatorOrg: intel.com

On Fri, Feb 28, 2025 at 10:27:17AM +0100, Daniel Gomez wrote:
>On Mon, Feb 24, 2025 at 08:43:45AM +0100, Lucas De Marchi wrote:
>> On Sat, Feb 22, 2025 at 10:35:07PM +0100, Daniel Gomez wrote:
>> > On Fri, Feb 21, 2025 at 12:15:40PM +0100, Luis Chamberlain wrote:
>> > > On Wed, Feb 19, 2025 at 02:17:48PM -0600, Lucas De Marchi wrote:
>> > > > On Tue, Jan 28, 2025 at 12:57:05PM -0800, Luis Chamberlain wrote:
>> > > > > On Wed, Jan 22, 2025 at 09:02:19AM -0800, Alexei Starovoitov wrote:
>> > > > > > On Wed, Jan 22, 2025 at 5:12 AM Daniel Gomez <da.gomez@samsung.com> wrote:
>> > > > > > >
>> > > > > > > Add support for a module error injection tool. The tool
>> > > > > > > can inject errors in the annotated module kernel functions
>> > > > > > > such as complete_formation(), do_init_module() and
>> > > > > > > module_enable_rodata_after_init(). Module name and module function are
>> > > > > > > required parameters to have control over the error injection.
>> > > > > > >
>> > > > > > > Example: Inject error -22 to module_enable_rodata_ro_after_init for
>> > > > > > > brd module:
>> > > > > > >
>> > > > > > > sudo moderr --modname=brd --modfunc=module_enable_rodata_ro_after_init \
>> > > > > > > --error=-22 --trace
>> > > > > > > Monitoring module error injection... Hit Ctrl-C to end.
>> > > > > > > MODULE     ERROR FUNCTION
>> > > > > > > brd        -22   module_enable_rodata_after_init()
>> > > > > > >
>> > > > > > > Kernel messages:
>> > > > > > > [   89.463690] brd: module loaded
>> > > > > > > [   89.463855] brd: module_enable_rodata_ro_after_init() returned -22,
>> > > > > > > ro_after_init data might still be writable
>> > > > > > >
>> > > > > > > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
>> > > > > > > ---
>> > > > > > >  tools/bpf/Makefile            |  13 ++-
>> > > > > > >  tools/bpf/moderr/.gitignore   |   2 +
>> > > > > > >  tools/bpf/moderr/Makefile     |  95 +++++++++++++++++
>> > > > > > >  tools/bpf/moderr/moderr.bpf.c | 127 +++++++++++++++++++++++
>> > > > > > >  tools/bpf/moderr/moderr.c     | 236 ++++++++++++++++++++++++++++++++++++++++++
>> > > > > > >  tools/bpf/moderr/moderr.h     |  40 +++++++
>> > > > > > >  6 files changed, 510 insertions(+), 3 deletions(-)
>> > > > > >
>> > > > > > The tool looks useful, but we don't add tools to the kernel repo.
>> > > > > > It has to stay out of tree.
>> > > > >
>> > > > > For selftests we do add random tools.
>> > > > >
>> > > > > > The value of error injection is not clear to me.
>> > > > >
>> > > > > It is of great value, since it deals with corner cases which are
>> > > > > otherwise hard to reproduce in places which a real error can be
>> > > > > catostrophic.
>> > > > >
>> > > > > > Other places in the kernel use it to test paths in the kernel
>> > > > > > that are difficult to do otherwise.
>> > > > >
>> > > > > Right.
>> > > > >
>> > > > > > These 3 functions don't seem to be in this category.
>> > > > >
>> > > > > That's the key here we should focus on. The problem is when a maintainer
>> > > > > *does* agree that adding an error injection entry is useful for testing,
>> > > > > and we have a developer willing to do the work to help test / validate
>> > > > > it. In this case, this error case is rare but we do want to strive to
>> > > > > test this as we ramp up and extend our modules selftests.
>> > > > >
>> > > > > Then there is the aspect of how to mitigate how instrusive code changes
>> > > > > to allow error injection are. In 2021 we evaluated the prospect of error
>> > > > > injection in-kernel long ago for other areas like the block layer for
>> > > > > add_disk() failures [0] but the minimal interface to enable this from
>> > > > > userspace with debugfs was considered just too intrusive.
>> > > > >
>> > > > > This effort tried to evaluate what this could look like with eBPF to
>> > > > > mitigate the required in-kernel code, and I believe the light weight
>> > > > > nature of it by just requiring a sprinkle with ALLOW_ERROR_INJECTION()
>> > > > > suffices to my taste.
>> > > > >
>> > > > > So, perhaps the tools aspect can just go in:
>> > > > >
>> > > > > tools/testing/selftests/module/
>> > > >
>> > > > but why would it be module-specific?
>> > >
>> > > Gotta start somewhere.
>> > >
>> > > > Based on its current implementation
>> > > > and discussion about inject.py it seems to be generic enough to be
>> > > > useful to test any function annotated with ALLOW_ERROR_INJECTION().
>> > > >
>> > > > As xe driver maintainer, it may be interesting to use such a tool:
>> > > >
>> > > > 	$ git grep ALLOW_ERROR_INJECT -- drivers/gpu/drm/xe | wc -l  	23
>> > > >
>> > > > How does this approach compare to writing the function name on debugfs
>> > > > (the current approach in xe's testsuite)?
>> > > >
>> > > > 	fail_function @ https://docs.kernel.org/fault-injection/fault-injection.html#fault-injection-capabilities-infrastructure
>> > > > 	https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/intel/xe_fault_injection.c?ref_type=heads#L108
>> > > >
>> > > > If you decide to have the tool to live somewhere else, then kmod repo
>> > > > could be a candidate.
>> > >
>> > > Would we install this upon install target?
>> > >
>> > > Danny can decide on this :)
>> > >
>> > > > Although I think having it in kernel tree is
>> > > > simpler maintenance-wise.
>> > >
>> > > I think we have at least two users upstream who can make use of it. If
>> > > we end up going through tools/testing/selftests/module/ first, can't
>> > > you make use of it later?
>> >
>> > What are the features in debugfs required to be useful for xe that we can
>> > port to an eBPF version? I see from the link provided the use of probability,
>> > interval, times and space but these are configured to allways trigger the error.
>> > Is that right?
>>
>> I don't think we use them... we just set them to "always trigger" and
>> then create the conditions for that to happen.  But my question still
>> remains:  what is the benefit of using the bpf approach over writing
>> these files?
>
>The code to trigger the error injection still needs to exist with both
>approaches. My understanding from debugfs and the comment from Luis earlier in
>the thread is that with eBPF you can mitigate how intrusive in-kernel code
>changes are to allow error injection. Luis added the example here [1] for
>debugfs.
>
>[1] https://lore.kernel.org/all/20210512064629.13899-9-mcgrof@kernel.org/
>
>To compare patch 8 in [1] with eBPF approach: the patch describes
>all the necessary changes required to allow error injection on the
>add_disk() path. With eBPF one would simply annotate the function(s) with
>ALLOW_ERROR_INJECTION(), e.g. device_add() and replace the return value
>in eBPF code with bpf_override_return() as implemented in moderr tool for
>module_enable_rdata_after_init() for example.

but that is all that we need with the fail_function in debugfs too:

$ git grep ALLOW_ERROR_INJECTION -- drivers/gpu/drm/xe
drivers/gpu/drm/xe/xe_device.c:ALLOW_ERROR_INJECTION(xe_device_create, ERRNO); /* See xe_pci_probe() */
drivers/gpu/drm/xe/xe_device.c:ALLOW_ERROR_INJECTION(wait_for_lmem_ready, ERRNO); /* See xe_pci_probe() */
drivers/gpu/drm/xe/xe_exec_queue.c:ALLOW_ERROR_INJECTION(xe_exec_queue_create_bind, ERRNO);
drivers/gpu/drm/xe/xe_ggtt.c:ALLOW_ERROR_INJECTION(xe_ggtt_init_early, ERRNO); /* See xe_pci_probe() */
drivers/gpu/drm/xe/xe_guc_ads.c:ALLOW_ERROR_INJECTION(xe_guc_ads_init, ERRNO); /* See xe_pci_probe() */
drivers/gpu/drm/xe/xe_guc_ct.c:ALLOW_ERROR_INJECTION(xe_guc_ct_init, ERRNO); /* See xe_pci_probe() */
drivers/gpu/drm/xe/xe_guc_log.c:ALLOW_ERROR_INJECTION(xe_guc_log_init, ERRNO); /* See xe_pci_probe() */
drivers/gpu/drm/xe/xe_guc_relay.c:ALLOW_ERROR_INJECTION(xe_guc_relay_init, ERRNO); /* See xe_pci_probe() */
drivers/gpu/drm/xe/xe_pci.c: * ALLOW_ERROR_INJECTION() is used to conditionally skip function execution
drivers/gpu/drm/xe/xe_pci.c: * ALLOW_ERROR_INJECTION() macro but this is acceptable because for those
drivers/gpu/drm/xe/xe_pm.c:ALLOW_ERROR_INJECTION(xe_pm_init_early, ERRNO); /* See xe_pci_probe() */
drivers/gpu/drm/xe/xe_pt.c:ALLOW_ERROR_INJECTION(xe_pt_create, ERRNO);
drivers/gpu/drm/xe/xe_pt.c:ALLOW_ERROR_INJECTION(xe_pt_update_ops_prepare, ERRNO);
drivers/gpu/drm/xe/xe_pt.c:ALLOW_ERROR_INJECTION(xe_pt_update_ops_run, ERRNO);
drivers/gpu/drm/xe/xe_sriov.c:ALLOW_ERROR_INJECTION(xe_sriov_init, ERRNO); /* See xe_pci_probe() */
drivers/gpu/drm/xe/xe_sync.c:ALLOW_ERROR_INJECTION(xe_sync_entry_parse, ERRNO);
drivers/gpu/drm/xe/xe_tile.c:ALLOW_ERROR_INJECTION(xe_tile_init_early, ERRNO); /* See xe_pci_probe() */
drivers/gpu/drm/xe/xe_uc_fw.c:ALLOW_ERROR_INJECTION(xe_uc_fw_init, ERRNO); /* See xe_pci_probe() */
drivers/gpu/drm/xe/xe_vm.c:ALLOW_ERROR_INJECTION(xe_vma_ops_alloc, ERRNO);
drivers/gpu/drm/xe/xe_vm.c:ALLOW_ERROR_INJECTION(xe_vm_create_scratch, ERRNO);
drivers/gpu/drm/xe/xe_vm.c:ALLOW_ERROR_INJECTION(vm_bind_ioctl_ops_create, ERRNO);
drivers/gpu/drm/xe/xe_vm.c:ALLOW_ERROR_INJECTION(vm_bind_ioctl_ops_execute, ERRNO);
drivers/gpu/drm/xe/xe_wa.c:ALLOW_ERROR_INJECTION(xe_wa_init, ERRNO); /* See xe_pci_probe() */
drivers/gpu/drm/xe/xe_wopcm.c:ALLOW_ERROR_INJECTION(xe_wopcm_init, ERRNO); /* See xe_pci_probe() */

That is different from the patch you are pointing to because that patch
is trying to add arbitrary/named error injection points throughout the
code. However via debugfs it's still possible to add error injection to
the beginning of a function by annotating that function with
ALLOW_ERROR_INJECTION. If a function is annotated with that, then if you
do e.g.

	echo xe_device_create > /sys/kernel/debug/fail_function/inject

it will cause that function to fail. There are some additional files to
control _when_ that function should fail, but I'm failing to see a clear
benefit. See this example in the docs:

	Documentation/fault-injection/fault-injection.rst:- Inject open_ctree error while btrfs mount::

Lucas De Marchi

>
>New error injection users such modules or block/disk would benefit of the eBPF
>approach with having a more simpler in-kernel code for the same purpose. Current
>users of debugfs/errorinj would have to remove all the upstream intrusive error
>injection related code if they want to adopt the eBPF approach.
>
>Daniel
>
>>
>> Lucas De Marchi
>>
>> >
>> > >
>> > >   Luis

