Return-Path: <bpf+bounces-30078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 328D28CA5C7
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 03:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACEE928158B
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 01:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9E3BE6C;
	Tue, 21 May 2024 01:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MGNnAeci"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD4F441F;
	Tue, 21 May 2024 01:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716255120; cv=fail; b=BymBX4r76y2XH+2r5swd/F9WGmuVaTgZdxnTpfdGRCTzp8/oPSCoI4e0moiexgOt29vUhcNsHNGhWarL1MkaBR2SExv8deusZn3zxtO0PzvlQNb3FpD8GrDwLL609vwCF2qRgRN6s9u2odA763ZHCFv7RaNdYzcK7OekxmxIanY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716255120; c=relaxed/simple;
	bh=iZwPMzq7ibZxQkqjrv6b+QYswRyEBhq+jDU5j3uQNV4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=plZOGfnA2Somu+w/wCmLTxKVhwAwf7gKerqgC0YkpZN/KSCrPnRd/b2b79OaDES4yFmExn3wNuQrkGadZBHIpNvaSViBtYbd07kOR4eRDbPajeQCU83I1NgNkZB2zcwS/HSYTAe1fs91ZNOUSZX6xwvvotpYYiLNnLcaPnKDE60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MGNnAeci; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716255118; x=1747791118;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iZwPMzq7ibZxQkqjrv6b+QYswRyEBhq+jDU5j3uQNV4=;
  b=MGNnAeciGA2oWaApImn3Gu98i3opy2hvgXCrif5h1qenkoybcksTOfIT
   Vl33fXsVARx2kTE3re5s3hHntwOIH7Ctifaj/mIsKSE7ZjIrAUtr8wmll
   bwJL0XajVBWelmWnF6a4+wLbIVQDoAPDXtuh9DEFjLhf4Tspn337GK+qw
   j5teY7xba7c4AnASjYlqhW3OUwzSKYyNHlw0HQcbKgUJpmOOW+JDX/u2i
   57YOYZadvI08l80Gw5JU2QVduL4Jk5dDjVV09OFF3fC6kTVbvXMZD/C78
   e/4pFcZpv1WxjpU7ajywzzIfMFHLWnBBULwCj6JP50oMwjDEt5E1W0TBU
   g==;
X-CSE-ConnectionGUID: 49jHopIDR3aX/Y5g0tkKiw==
X-CSE-MsgGUID: DsK57h0nTrifprFUAXr5GQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12263520"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12263520"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 18:31:57 -0700
X-CSE-ConnectionGUID: E2Zcan3mTgqp2Ugx7W4ydg==
X-CSE-MsgGUID: TBGdJI7ZS4OFgw/HxK+AHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="55975501"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 May 2024 18:31:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 18:31:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 20 May 2024 18:31:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 18:31:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpkUm4BBZYDI2ywz+7cBgR3IXDJbj0WdfwGoFVyumzl9uyDGtx+RTYgX7OJZtQAlom4tGJKkwsESW9RJ4wUazYTF2MYSBh29O1K/6xuZcPtl+Uge1YxDGN7D87kGgMAoxGF+4F2c+wK/ymohBxy5ATLgQuxfw7aEr8olRGEJ+jrb0QV6mzdJlyuNqaRpz2KjT+bpJiyIbNqgsc4AcoBLbm0jeBsWrDzyFN3aYStPZHgxlV85Khpu5SdX9t06nZsa109r4CE0OUcj/FBwAdkrixODueLV0Amk5S7pbDYtqwrcpabqhUI+4dR2mQEDL4JeQLTBG+eGw9yTRQfu+U+Jyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZwPMzq7ibZxQkqjrv6b+QYswRyEBhq+jDU5j3uQNV4=;
 b=UZlhibE1n7cxGU1c65AQYLDsIfCLeO1q7vmcgIwm5o29XbNAQxf3WAvg1jISXfMepXtHtrBc4uhKbvGBpjRPIfqqyigYVCuGRWBzxoja93zXOlGVQ1qYtYT16QYCBnc3q8uzfXMb2+kEfQCLGzhFFKp9o+2X7xnLFgU8x0oxlO1LqXGJzKz2AjiyMw6gXbtIC0M7VxHnEYRy9eCLSQ1q2ZUf9qc3r4Y5OiUDohhAQRtddToyA5EjMeLKPUeHkchdWCdYOiaF3QlOaSsM8iet4NqvL1b/I6f9tL/pUCmbaYCxRHTfJ2k9pBzVC36t7eHKUuyLCWqeUBDfRXHnOD/WUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CY8PR11MB7035.namprd11.prod.outlook.com (2603:10b6:930:51::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 01:31:54 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%3]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 01:31:54 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "olsajiri@gmail.com" <olsajiri@gmail.com>, "oleg@redhat.com"
	<oleg@redhat.com>
CC: "songliubraving@fb.com" <songliubraving@fb.com>, "luto@kernel.org"
	<luto@kernel.org>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>, "debug@rivosinc.com"
	<debug@rivosinc.com>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "ast@kernel.org" <ast@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-man@vger.kernel.org"
	<linux-man@vger.kernel.org>, "yhs@fb.com" <yhs@fb.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCHv5 bpf-next 6/8] x86/shstk: Add return uprobe support
Thread-Topic: [PATCHv5 bpf-next 6/8] x86/shstk: Add return uprobe support
Thread-Index: AQHaoGz/NDbwXOtepku5mG5JmKvX1LGMCSqAgAKMVwCAAIRoAIADdFkAgAJm6gCAAHtzAIAARi8AgAKATICAAD0QAIAAB9mAgAa39YCAAch/gA==
Date: Tue, 21 May 2024 01:31:53 +0000
Message-ID: <81afa4ccc661a1598b659958164c7a73cf211d21.camel@intel.com>
References: <a08a955c74682e9dc6eb6d49b91c6968c9b62f75.camel@intel.com>
	 <ZjyJsl_u_FmYHrki@krava>
	 <a8b7be15e6dbb1e8f2acaee7dae21fec7775194c.camel@intel.com>
	 <Zj_enIB_J6pGJ6Nu@krava>
	 <20240513185040.416d62bc4a71e79367c1cd9c@kernel.org>
	 <c56ae75e9cf0878ac46185a14a18f6ff7e8f891a.camel@intel.com>
	 <ZkKE3qT1X_Jirb92@krava> <20240515113525.GB6821@redhat.com>
	 <0fa9634e9ac0d30d513eefe6099f5d8d354d93c1.camel@intel.com>
	 <20240515154202.GE6821@redhat.com> <Zkp6mT2xag29dLTR@krava>
In-Reply-To: <Zkp6mT2xag29dLTR@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CY8PR11MB7035:EE_
x-ms-office365-filtering-correlation-id: 8b3f2de2-c7e6-4150-c2ab-08dc7935cbdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?SWZzQlVOcDFkMlRROUZMMnNDYjZmVGtDTzFmSXRhbXNaUjNsSDl2WktydmRR?=
 =?utf-8?B?UVo1VVJNbTZpMlVwcGtmb29GS2FSM1ZhRTRKQjNpS3luT245LzlKL0pSa0xO?=
 =?utf-8?B?a3hNZFpabDVLdVllMW1ibkJKNnV4dlZydWNzM2Fxc0RTQTIrTlNnbjZaQXdl?=
 =?utf-8?B?Z28xM3hycWIxdTBzTHhHVEYvalRiTVJDc0FHNWlSK3RpZm1qYWhJdndLZlc1?=
 =?utf-8?B?L0JqTzR4dWRFTjYrZTJRT3c1di9ndXdpZVdEOVM2MVNuc0Z2REZFeEJ6MHFQ?=
 =?utf-8?B?R1NkU1FoMmFKeWVhNXFPd0NUT3FMczVvTzV5SEF0SlkxbmpZNFJqTXA5VWpK?=
 =?utf-8?B?VlduVmc3QW0yRm9HZkFRL3ZUbkNEOWdYa1NLZ2prM1hjZGMwanp1MHJYY3pP?=
 =?utf-8?B?VkF0UlZvVWhUeGdIZVNGS2tFU1MvMGVpUUVZSm9sSXpIQktmNlpZdVZZVmtB?=
 =?utf-8?B?ZEVqMTNWTFphcmJ4MUNjeVlCSWJQekgvcHlRd0lHZFZLaXhVRkplaHhuMnBK?=
 =?utf-8?B?L1Bxa3d6ak1NanNhNW81R0YycnB4dTd5T2tmUURkK1ZiZDFHL1FuRlJIbmZC?=
 =?utf-8?B?RjNZREtCUWwvcThxMnBSVU9CamZubW5xSHNXSjVXZGk1WjNvWmZsVHpnWVZ2?=
 =?utf-8?B?ejdjc05sYXVBK0VEdWxubHBPczcwdmtpUkJDajRJR0w4Sy9CWHRrektDaWJC?=
 =?utf-8?B?M1RvNXZhM215alpSRXFGaDNtOEtWaU45bVlLV3ZjKzhvUmNIRzhBalJSVVNk?=
 =?utf-8?B?QnZvRXNEVHBIdWU3QWhzQys5QldvaXNCVEhxVFRGbEpGOWQ1QTluM3NyNmNn?=
 =?utf-8?B?aEQvelMxSEVSMVhDbXJoSTVRWThoSS95UENaVGZyRThqM2tKWS8rTUQ3OHh2?=
 =?utf-8?B?Ry91cHU5c1FsQnRSNWR5bnBuNlZBa2lTRmhrM3EyZkExdkpGcTdZNVZ0ODZr?=
 =?utf-8?B?WC9OVkpDd0hob3RLbFNTeGxVN29qVzFkTlppVTVsQVo3U1dNSEZWNkNxakt6?=
 =?utf-8?B?ei9lNFJ1Mm5QRVBpbnp6cGtlZm1ZOTY0ejVGNE5xbTF2NzgwZ0RhTHd3MHlM?=
 =?utf-8?B?bmJVcVVQSXhLR2htb0xJQWpUbmFLVGpjdnNmbS9QSG5rTVkzSjQweHZhL280?=
 =?utf-8?B?a3VQRCtKMGI0NHZxd1lZTXZkNXN0TStnNmhVVzFUaGJ1dXlhL0ZuNFJSYnZF?=
 =?utf-8?B?V3dYNitpKzFuUmZxcTZnZEFwL2gvZllOQ240NllNaVZlakdOdloyQjVBd1Bk?=
 =?utf-8?B?Sm9qS3YxcEV2c2NvSlNFNitRb2h3SG5NL0M2eDV0MXo5L2IvckVIeCtEVzBv?=
 =?utf-8?B?NWFZRFR5a1lqYUs5cSt1VThzdkxEMFF6eUlkYXo4NFpJTkY5U0hNMnlCMmU0?=
 =?utf-8?B?NUQxbnByZjFON0RwSWMzVDVhUlZCb1lFbXdZSlJkN3RVOXZWdkRGTVhnZzVk?=
 =?utf-8?B?bncxNktvcmM0cStjOVZDdTRMWHZ4cTdGeW5IcG45YlpEVEswWFdLMnhTak4r?=
 =?utf-8?B?eVp4dnZObFh1Y2tDS250T2UzT2poZ29XQy8vWDNSRWVZbU96eHJVUVA1QXJI?=
 =?utf-8?B?RzVwMnFsYTFQc1V6OHNWSTd6aFVsaldEKzRNNXlwcHVtcCt3Vy96eStSNGJo?=
 =?utf-8?B?SHZTTG1hVEFVUUlnWmUzUVFKOEt1bXdJaFJjclFMREdaZENlOFBuc2lnSnFP?=
 =?utf-8?B?QXI2TTlNZWJMUXFMbDNDQ0RneCsrbGduSXlYOXpjTUlzeEZJRFdOeVV0OUdR?=
 =?utf-8?B?U0QwckFNK21LVEtFM1VQOTg4TDNzdHlDZEoxUUJnenUxNEx0YXdFL0Nqa1Z3?=
 =?utf-8?B?eVAzRnhmRXcvSVh1eklsdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkVndHJZK0RSUDRhZUZ1aWoveSt2N25lazdWQTRkR1VWcVFTV2Fuc1c1SDFa?=
 =?utf-8?B?a0dmNlBHNGgxY0pVWUFYV09DaWd5R0NBQTh0dkZXbmVuTXNmQUVPN2JWcWhu?=
 =?utf-8?B?ekNDc3o4aWRycHlYRXo1dTdmV3ovc0szNGNyREU5RC93cUdZRTZZYWpLU3hv?=
 =?utf-8?B?NnV1ZjliaTVua0xmNzc5eE9vbm5oVG9mOWlDbHl2Y3YyaUM0WlV4ZkJXSkZU?=
 =?utf-8?B?ay9tSCtPY3dUT3hKa0wwbERDUGUzRWdzTmMwVnc3b3h0Q1Fzcng0ZmU2OUtX?=
 =?utf-8?B?RnBBMWE5eDlwdm1VU292cDZDdS9TbDhLNEwxZUJ4c1htanBrK2RzWWFwREk1?=
 =?utf-8?B?NFh0dmFkWUg5clM4RXlOVXIrd3lTbTE2Zm1SQ3ZsSzA1SXVIODZ3dSt1ZzBh?=
 =?utf-8?B?bFd6ODFEUnJIY0JCTXBoVlI3dFpLTjhFOXZKNHlZQjcrR3dMbXI3czZwSUdw?=
 =?utf-8?B?cGxTTE1GVlMzYnZpWGs3UDVPMTRUTDl2QVU3TG5lYXg1OXZUZFNQV0RZdncx?=
 =?utf-8?B?SHRUeTczUmx0aU9RUWg0WHZRUjNNb0ovc3gxRVltbmtjaTNQazVJd252NHFi?=
 =?utf-8?B?ZzE3TTlwRE8wRElBSkZmVlpXUmJQNVhiK0dwbE5uRGlnZVVmK05SNUhma1k4?=
 =?utf-8?B?VGk0MlB2MElLNDBQaVdrOUtwL3JWVXpueW80cllma1JaRStaSFlEOHFOWUk0?=
 =?utf-8?B?Tk0wK1EzL2tCRGNZa0VxVXZISG83UFNQelB0SFRNWlBDV3B5Tk5WQUhkTUFH?=
 =?utf-8?B?c2JUTXVDNy9JTjFGYnNiUFF2d1lxMGdjN29kZVo5dUFmS3JIRERDQlNIOFNh?=
 =?utf-8?B?REwzNXdpSWc0WGJ1Y0lvZ2IzVUlITWpKejJNZnZNSnp4UGoyWFI5QWZVWUtk?=
 =?utf-8?B?TGl6Y3hoblRNcVRUSXYrZFEwNEZQQ25qcWNyUDBEWm1WRTNUMjhsdCtRTjc4?=
 =?utf-8?B?Nzg1UlIxT3U0L0k2QWV4OXI5aHdyb210azdrRUhEV21sdk5QbytWK0VNalNL?=
 =?utf-8?B?clhtVE5nVG1mTm5lOXU0UFJyWngzRlRWUkJ2eWlFendyWXRTNndUVzJDL0dI?=
 =?utf-8?B?cUt4VVZCS21zRysxUzB0Q0k5MXN4akJSMFBUZUpOdXlKLzZuS0oyL1VNZnJ4?=
 =?utf-8?B?YTZob294NzNPallDZEJSTlRMcURRNTl2Z2VzUS9KU2F0cC9TT3g3QmhwenJ6?=
 =?utf-8?B?Mng0UDBCbG5iVkZ2ZXJFVVJEQWI4RVh0TnI5MUE0elU1TDNpTjk5TzhDNzFF?=
 =?utf-8?B?RHNNVHQ4WGt3WHJ4elVvZDF4blpFZ212Sk9CbzEzd0lUTzJCM2c2NnlVaHNh?=
 =?utf-8?B?bklvK0hYOVBqVmEzNjdMbTlaU1RobHhkcFZ3VFRSUno4UXBKODYydk10REFI?=
 =?utf-8?B?UVZIajQrbmZOK0dnUXp0cnp2WGtoTnRybnZlUkFrdzdwZUV6ejF3d1U2UXZZ?=
 =?utf-8?B?STVDSkg3SWlQSFpTNlVNTWRuV1BWenZwVjlXYzE3d295Z24yaEs3d1VxcWhS?=
 =?utf-8?B?QjJ4RllLQjM5UXhBNFRLSTk1TVFTYXE4SS9QMWdVQTdLcnBEYmRzbVFTSnB5?=
 =?utf-8?B?eWFNNmpOQ0Y4dVdkMFVVQlhUekJCYXd2Z0kycmJuc1VBM2dNZkYvMjFrUWtq?=
 =?utf-8?B?QitkRnlqMVFIZWlLM0RuMG9zSnFyeGJkRlBzZVNXbHBta0xPU3pCUUJqTEtq?=
 =?utf-8?B?enMwNGVQelBtRm5jVkplbXZCVFEvYXJUTTRPV1lzYlRKUzRnTStpbU9yL3Zh?=
 =?utf-8?B?MlZmWW1VdUh4azhpSGNTU0JZWThBTkpEVkt6ckRUWkhPeFZ2b2JBRDVEVU4x?=
 =?utf-8?B?TW1uVE1xRS8yNGM5T29hRlBqeGM3UUp4cFRGdlpXOE9mWmdEbWsraEpJVGhY?=
 =?utf-8?B?ZHhIQXArZjdWQTFFT3dsa0h1MjlSemFySFlOdEQybUpFYU5OSzFHRlpxSm9l?=
 =?utf-8?B?R2FVMk9Fakc1aEZ4aDA2aGRDTDkyS21yRkFYRnpFUTE0S0VPa0p0YUVUZFVQ?=
 =?utf-8?B?VWN0YVhxaFpWOEhyUEltRFRncXRKeThDM2hEenRhUk5LZ1grOExQSm9QV1Jj?=
 =?utf-8?B?cGNUc3lpaXZ0U0VkWXVid201UXZTcUN3UFViSEI5L2VQN1c5TlU0SHZFWncz?=
 =?utf-8?B?Q0NkelFCdnhXNDhlT0tMSzBCNTNrVy9jV29vUU0vdTNPTWZjQVBWY0xFQk56?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA5A079AFBCFF34195BB41F196481A6A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3f2de2-c7e6-4150-c2ab-08dc7935cbdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 01:31:53.9604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SfAu+vA6nVSl9FjBrbkxzH1j8HsMZVaomYHWePR89hz1Qd8Mvs1sLWszJ6wM4WXl2DIWlJ8bi+NEQ2/Ipqt1BiFdmIgCxCDSAo9kxTI32y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7035
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA1LTIwIGF0IDAwOjE4ICswMjAwLCBKaXJpIE9sc2Egd3JvdGU6DQo+IGFu
eXdheSBJIHRoaW5rIHdlIGNhbiBmaXggdGhhdCBpbiBhbm90aGVyIHdheSBieSB1c2luZyB0aGUg
b3B0aW1pemVkDQo+IHRyYW1wb2xpbmUsDQo+IGJ1dCByZXR1cm5pbmcgdG8gdGhlIHVzZXIgc3Bh
Y2UgdGhyb3VnaCBpcmV0IHdoZW4gc2hhZG93IHN0YWNrIGlzIGRldGVjdGVkDQo+IChhcyBJIGRp
ZCBpbiB0aGUgZmlyc3QgdmVyc2lvbiwgYmVmb3JlIHlvdSBhZGp1c3RlZCBpdCB0byB0aGUgc3lz
cmV0IHBhdGgpLg0KPiANCj4gd2UgbmVlZCB0byB1cGRhdGUgdGhlIHJldHVybiBhZGRyZXNzIG9u
IHN0YWNrIG9ubHkgd2hlbiByZXR1cm5pbmcgdGhyb3VnaCB0aGUNCj4gdHJhbXBvbGluZSwgYnV0
IHdlIGNhbiBqdW1wIHRvIG9yaWdpbmFsIHJldHVybiBhZGRyZXNzIGRpcmVjdGx5IGZyb20gc3lz
Y2FsbA0KPiB0aHJvdWdoIGlyZXQuLiB3aGljaCBpcyBzbG93ZXIsIGJ1dCB3aXRoIHNoYWRvdyBz
dGFjayB3ZSBkb24ndCBjYXJlDQo+IA0KPiBiYXNpY2FsbHkgdGhlIG9ubHkgY2hhbmdlIGlzIGFk
ZGluZyB0aGUgc2hzdGtfaXNfZW5hYmxlZCBjaGVjayB0byB0aGUNCj4gZm9sbG93aW5nIGNvbmRp
dGlvbiBpbiBTWVNDQUxMX0RFRklORTAodXJldHByb2JlKToNCj4gDQo+IMKgwqDCoMKgwqDCoMKg
wqBpZiAocmVncy0+c3AgIT0gc3AgfHwgc2hzdGtfaXNfZW5hYmxlZCgpKQ0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZWdzLT5heDsNCg0KT24gdGhlIHN1cmZhY2Ug
aXQgc291bmRzIHJlYXNvbmFibGUuIFRoYW5rcy4NCg0KQW5kIHRoZW4gSSBndWVzcyBpZiB0cmFk
ZW9mZnMgYXJlIHNlZW4gZGlmZmVyZW50bHkgaW4gdGhlIGZ1dHVyZSwgYW5kIHdlIHdhbnQgdG8N
CmVuYWJsZSB0aGUgZmFzdCBwYXRoIGZvciBzaGFkb3cgc3RhY2sgd2UgY2FuIGdvIHdpdGggeW91
ciBvdGhlciBzb2x1dGlvbi4gU28NCnRoaXMganVzdCBzaW1wbHkgZml4ZXMgdGhpbmdzIGZ1bmN0
aW9uYWxseSB3aXRob3V0IG11Y2ggY29kZS4NCg==

