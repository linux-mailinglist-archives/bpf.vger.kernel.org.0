Return-Path: <bpf+bounces-29775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDD48C69C8
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 17:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0A01C21386
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 15:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76CC156228;
	Wed, 15 May 2024 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0P3Pgwe"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A146149DEE;
	Wed, 15 May 2024 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715787102; cv=fail; b=d86fHYOJVCckKWoUiJ7Y677ovVnRYRBanEsscm7bgjIgmCNmy1MJ7w4nGPnAG9g6FpxUF7t5cONfSLCyTKB7J/0KC1FzlTnYZHtVmUlg79yIN+NdDQRBSBf8Y31+TkU7Jx3WYpOX+46smJuQSGFCnxAfSp9R56x1saIw02zT0oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715787102; c=relaxed/simple;
	bh=XbwEi25rbEl9YMeHUXQl4cQ7wQVMKaWUTwfI0d2ym6U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K0FTWT6P7rLL8CsCtKhH28ewhRdcy59gkbWst/WnSDe1Qn/msLViePXilu5JYPaTjXZ1/mNbEWrgfGa7eQ/0jwz/DifJwg6mbp1hxJh6nw9pUpYkMJpJOohFk06CXm4BZR3xuew0JttMmd8tmT2eUNQoTahl51kT/CNQSY0kdAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0P3Pgwe; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715787101; x=1747323101;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XbwEi25rbEl9YMeHUXQl4cQ7wQVMKaWUTwfI0d2ym6U=;
  b=l0P3PgweMqB0zYt4LNiDt04RVPdoKOTmFdoxCdA1MnQPdPmUrnEpT0dO
   RXLsxkPNlNA37iEoIV2sxtu2w18QvyJT2PktXh2SY8Qc+4i3x48jQJDi6
   pJtJUKCM//hX5Z9Dq0KLd8/RNv2DxSmrEPB8HCKzyvWGU3I86fvImPicj
   Rc+JdZKtxdynX87RqZga7VBwIX5CarN1dD95229+T7acvV1KCGzCpHb1/
   i01XxoYW9Fd7uhOAWgdWeofKRFQLIEsq8MIln2KKk7GKoRzGe4Hl7JCxK
   XK+dAHQ79xDgm1s1uI8P3hOoGm+8k7twlsGiMaCjqehkKyewt9nmDwdHa
   A==;
X-CSE-ConnectionGUID: NTPApF90Qnyl2KdvLmYJTw==
X-CSE-MsgGUID: pLzgtMVMROeG6L8+RtIvtA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="29335169"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="29335169"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 08:31:40 -0700
X-CSE-ConnectionGUID: 7lwN7Yw2R16WUS/7IEY7KQ==
X-CSE-MsgGUID: kqDFjijNT9GAZcv0xIgbBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="68554963"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 08:31:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 08:31:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 15 May 2024 08:31:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 15 May 2024 08:31:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 08:31:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrowGEfNmIYyCDDwBeeymdzPNXPQTe1L8A7/exhQr4JOmeATorMg7+DqGk0WNXCQiBFGtNQ9KSTRZMQ9jQK6DI/n9tltx4YYNsohcLAsiLiQzQw0lFUJaS00DJJIn+mBH/MlbQvE3gETn42hlDxQ9Nfph02clRB80MnprzaxJscVivpGXnI+I5DC0sMbStnVar/rmec/fsyJPB4SYDOKSIlwQPMekY309DkqAQIpkGEOc80qN+u0bWoMWM3Euh3ydFppMnUyTyR8wuQRLlNKv4YIPAVIb7WgQuYWGGZadhCUDc18mxdPOm8KilZGk3PfNea8162+6+nrmodg5m8CnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbwEi25rbEl9YMeHUXQl4cQ7wQVMKaWUTwfI0d2ym6U=;
 b=i0I09jdVIXfu/nGQ9BXLkk4UGLZWeEVlAk31NbBI0btO84/iIxN+KNjSnqbgTeT5+DbtyrPEtOm2XuJBCea5Adj6NHDFlI5pv6LarMRCopYxMvffsgkYlCzJIX8Z4HNOIMcnWYTegDSjcRLwOdnmqnNmpV/rwBt43cScqBTDKr+YU13bUQcRcyTiDKuUhd+4q95n6AwOrc5pHNU2crbOXhFfBxAb8gaEsRIowR2j8OzUzGu8L6STXaf1uQSBJ2eZ1ep8uZj9rMEdC03UxWr/tOXwHjb4uHk59t4Y1u2NghNunFfvTbBnD3/84EmpfEWrr22KIJja9wLyPyUC0DP1kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA2PR11MB5129.namprd11.prod.outlook.com (2603:10b6:806:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 15:31:31 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%3]) with mapi id 15.20.7587.028; Wed, 15 May 2024
 15:31:31 +0000
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
Thread-Index: AQHaoGz/NDbwXOtepku5mG5JmKvX1LGMCSqAgAKMVwCAAIRoAIADdFkAgAJm6gCAAHtzAIAARi8AgAHRkQCAAAmlgIAAoJgAgAA29oCAAA4AgIAAAX4A
Date: Wed, 15 May 2024 15:31:31 +0000
Message-ID: <a1c76e622abff15550ada036dba79dd06f564198.camel@intel.com>
References: <ZjyJsl_u_FmYHrki@krava>
	 <a8b7be15e6dbb1e8f2acaee7dae21fec7775194c.camel@intel.com>
	 <Zj_enIB_J6pGJ6Nu@krava>
	 <20240513185040.416d62bc4a71e79367c1cd9c@kernel.org>
	 <c56ae75e9cf0878ac46185a14a18f6ff7e8f891a.camel@intel.com>
	 <ZkKE3qT1X_Jirb92@krava>
	 <3e15152888d543d2ee4e5a1d75298c80aa946659.camel@intel.com>
	 <ZkQTgQ3aKU4MAjPu@debug.ba.rivosinc.com> <20240515111919.GA6821@redhat.com>
	 <ZkTIU1QUAJF0f0KK@krava> <20240515152609.GD6821@redhat.com>
In-Reply-To: <20240515152609.GD6821@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA2PR11MB5129:EE_
x-ms-office365-filtering-correlation-id: 280aaf37-398f-4b25-37c7-08dc74f41898
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?SFNQYXp1S1Btd1ExK2srV21nYVFwSGE0aFVkYkdPODNHdW1KNzlFaVRVK1Jo?=
 =?utf-8?B?S3pXVTFVN2t2TjF5M0VUNjJHZmJsNng0MjRKRnl6N2RaSlB4V05pemZzdmNI?=
 =?utf-8?B?M1RINHdISFFueWs0bEZqc25mbWRuNkhnVEh3K2U2aFJod2tvR0hEQXZCQ3Y4?=
 =?utf-8?B?c2NVZnBEOEc1cmljT2UrdW1EUFZ1dC8rSndNRE9FOU54Qjl1a0NqU2tmcnlv?=
 =?utf-8?B?UjY5UGk0RkJhSGdleEc3OE5LUSsxUkRZcXBrTlNhbS9mZkMvcktPSVYrTC95?=
 =?utf-8?B?SDJrKzlkSFJDdEUxMmFKaTNHbExEUzdpZmRQUS90SmFMV25sRExXNzVXN2tG?=
 =?utf-8?B?U2dSb0d0blFxenpHMUFuZlhSdWI3QnFlUmFnUXdpNEwrYXA4MGQ4QkJtcjll?=
 =?utf-8?B?dS9WWEcrZGJKQ1R2dk9wV21QNEEraVYvS1JzaUc4S0dSNmhzSXJpVzd3QzlB?=
 =?utf-8?B?Um4rUjNPbnF4NW1SNTFqOFFHUmlxRndBSmFYTmZGZE1OM3RMS2VqbG90Mytr?=
 =?utf-8?B?MlkxTk5kSDJBRlNlNlBuNUlCYk9FK1Z4a2RzcTBra2x1UDdqZXRxMVdTQnRk?=
 =?utf-8?B?KzM0VDUwVTZJNWoveC92dy9Jd201VW1OYXJ0cERUaUZ3d1h1Ymg2OW9EWXdm?=
 =?utf-8?B?OXpwRW1NK25HTnJQU0lubzRxZWR3cWRPby9UTTE0TjJSSkdVYTZoelR6YXFI?=
 =?utf-8?B?Z1hEbXZKbjFnUGdxbldlQnFZcWFBSzFOUzVybmczY3JvcTdwbmlYOGFibStv?=
 =?utf-8?B?akxnNm8wYkRNUk1PS0FObnRJTHJvVVJoQ09NRkhucmFBQkM5UTFEQWwxL0ts?=
 =?utf-8?B?eGIxRmxaNmZzZ3RZTUpURWhYRC9PaERZWWpiS2V2dkw0Mk5pdms2Q2NKdjhm?=
 =?utf-8?B?a2VuOVd2RFF3bDgyN0lvcDNOMGIxZncvRWdaemp6dVJ5UktubFppWnN2Unox?=
 =?utf-8?B?ZDdvVTB1NHBCU0dna3AzQ0F1dVhOb21TV2FCNXRMSCtCZ21XTGxqL3ZtZ0ZP?=
 =?utf-8?B?VXFHOGxTMXZlWHQ3Wjd5cDFVM0dCMnU1NW1xMk0vQVB2RlhlMkI5VDFNOVY1?=
 =?utf-8?B?NTAxWW1vK1MvM0M3eWV4ellKeVBlLzFSMzA4YlBQcGlIUlZBQzBUU080Nis3?=
 =?utf-8?B?QkQwd3BkZFppQ1hRY0dWMDYwbHg1a1NiRXg0R3hCNm9jVG1XSkhpU1BnOHlS?=
 =?utf-8?B?bkNLcUxNazNFMjlOUkZ4ODZIcnpESE5PbVdsY2tBTExVVzVhZVRMVDRxcUxF?=
 =?utf-8?B?WE5sYi84OWFhNDBMOFRwRkZ0TEUxRk4rNWVvTnQ0NnJRTHRZVGZRcHBPWUpY?=
 =?utf-8?B?NGxyNE5aRnVmalBhTm41OWYrK3I3TGdGTmhSUjRsdGkrR1EzdDI4c2RYdjNL?=
 =?utf-8?B?ZW1RbERDeG0yb1dSb1MrSlQ0Q1RHSTM2ckFCanJlcWJNeEhnOTg3RnI4OEs0?=
 =?utf-8?B?REhnR3NkUnZValliMnNESElWVGxMaiswbmtsSDc1RkVWakRWaEI2amFpc0l3?=
 =?utf-8?B?YVRhT1JvMDBURnAvaktJVFA2WlpKUEhWbkZtOS84Q3BxMzZBVXZQRUpQTFFp?=
 =?utf-8?B?aHlPM0xDL2lCNDBmdE9sUmw3ZVVHQzRRUkM5VVVwRHJQbnd6Ym9RV2IzQkg1?=
 =?utf-8?B?bDhQWDBsMDFodTM4R0lSeVRLT05lUWVsS05aWktoN1BMWWFmTG1DS2ZJNzJM?=
 =?utf-8?B?TEtBTm14ellOTnlNRzJWMFV5MlBwZ2hYcGFTRXZad2R2K2h3NFAyNC8vdVI2?=
 =?utf-8?B?ZjBRdXpLTFhoSDFCU3poK2NPYUtWUTdFeFdoZ0hUZytsaUFlaU5Ya1R3M3ZN?=
 =?utf-8?B?UEQwWFlMMlpSRUsvOFJtZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alllVDlLT3IwVGp2STJLS295MmtwN21TcjdFQUVvZitCRXNpVGRvMFVCemdp?=
 =?utf-8?B?Mmt5L0FLSHRmOVBLQzlIcFJlMURqTVNGWUNzL0l4UTZwZUxtTHdOcnlPZUJZ?=
 =?utf-8?B?aGtpNHlRcTBjbS8yT2JkNThXMHhsRFpxUlRWUTFMem11WEEwSExlcVJuNGtj?=
 =?utf-8?B?RkZrNTQvSnMwaFZtVW1CNVBDdkdEZHFTQjhMTmtkTUxVbS8xVDIvTXVsejVm?=
 =?utf-8?B?NUlKTkNGVFJ6SmtCNnBVZ3VYMEM3YVdOUzVYZVVrTVJyRHcyYytxam5yREhS?=
 =?utf-8?B?d002TGFVR1o5dWloUkhjZEF4ZEZQVHZFUytSRXlKeTV1TlpRTitqNlFRcEF5?=
 =?utf-8?B?ZFNKeVBMRUl2cWJ0N0ExNjVwMjlxTFJqYjJWSjRsdU9EOE5WWkZweS9veVNZ?=
 =?utf-8?B?VWtFaFVXTndqS1FHdVJub01vQVFXM1hFVDRkLzVwbnpFZnlLMjViSGZ2WUJN?=
 =?utf-8?B?dm96Z1o0eFo4TmlIa1JqMjZUOXFZV2xPcFcvWU5uOVlLZUJJc1EyenlEVW0z?=
 =?utf-8?B?UmRhYWdIZmxmZDlneDlNTDVYUjI1b1NDcVJaVGsrQVllb25RbXBJbUY0YjB6?=
 =?utf-8?B?RFpjd201Y0VrMzh2MCtyNnA2Q1huVnJGNmJSMmZ6U2tGakJRR0tsS25Nc1hO?=
 =?utf-8?B?dlEveU54cEVDM25GSzh3aDZmaytHaFlocjlkTmJlWmRBVUlVUXh6bGptRUFU?=
 =?utf-8?B?djRYaE1kTllkTURsUG5IQjNwTEROVVZ0UWErbU9uSTNnTktrb25acVNSUUsr?=
 =?utf-8?B?UDdrQlRiS0xDV0N3ZjUxcC9aaXIxWFRjTFVoQWJtWW45dFhDRm9YbVk4ZzJr?=
 =?utf-8?B?a0taQlhoaUZVdjluald2RjczTUZ1Tm1mWndQSXV3RTFxM1YrZ0REQ3Nsak5i?=
 =?utf-8?B?cXd6NklpUEUrTUhWZEtPWWJ0K2ZZL2dGdzhXTVlVU3IzT1RKelZrekE5WjN3?=
 =?utf-8?B?YkZRck9MNENONENYdUt6bTFBcC82OXVLdEhqeG9Fc3J0UFMwWTlJZU5Cc3ht?=
 =?utf-8?B?d1J0ejk2ejM2akorSXFLbDllNlMyb1daQmcxR0FTNUp4ZWFETEpNOTJuYlcy?=
 =?utf-8?B?V2tya1lTbWtJWXo5dHNLYTJOREZlZWV3MzdsdWFtSDlFMmQ5M2dOT0JYNWxn?=
 =?utf-8?B?ZFBBZWtJN1NRSzlmY2FzVitQTm1OOEVPTHg4Sml6aFRqUzJyTytHeERWb2JG?=
 =?utf-8?B?VG9Ya05heERQdndSNEpjN1dpSjF6ak1LeXNRMzh3TU5ISDVHamU5d2Ryb2FQ?=
 =?utf-8?B?RzRsSEtrUGJTRTlwaUR0c1hQcVBiclVMNU1DQVBEWEwxaUVCTTZaT0cwMWFo?=
 =?utf-8?B?OGVoanJUOHMwSWVWZ1VBSXhRdWJuYlgzaG1uZGhmTzdnam5NY3NOdVVVdGxo?=
 =?utf-8?B?VEFPWDJQZkZSL1dyQU1xVVIveU9rM1BoN3M5RGhUZCtrbDZLTElneGE1WHNO?=
 =?utf-8?B?b3BxamJQRkdHdUhYcXJQd3F6OHpIblBURTYzYWxlWjhGSmNGTzJ0L0h4WExJ?=
 =?utf-8?B?czBNb0lQTDlUbjhyeU9XcHNERjlWdVpobTFJc3ExN3l4V1lmMjR1QU9ycmxr?=
 =?utf-8?B?OXJjWkIvRWhXb0RFNWRLdXp3SFBrNGhRYThNcUI2WUFVNHg3UHlpSUpWMHpw?=
 =?utf-8?B?bVYwbmIxbEhOdUl5OEtDS2xjVnJjeXhvNWFFRFYxUWVxNFlEdTZKYStIYmVa?=
 =?utf-8?B?b0RPMEtBc2pUK0s2QUw4UXpqTkxJUW5PUkdIMzdMWnpiRjcrNVVvQzIrTytx?=
 =?utf-8?B?NDFzTVlaRXhkbXdTdEo5U3UyUFdPdDF0d2p0cGcvNkQ1VkE3SEdoaWM3eFRY?=
 =?utf-8?B?VDB1QnFJU1lRV0VsRlRVSzZlYVk1UHlBb0RUa1VIclozMWtMYkhiOVJqU0lX?=
 =?utf-8?B?RWJNbVJXUS9zVGgvYVJYSGVNUXBUMVplTk4xb2lWR3lmVDNOKy9RMUIxN1B1?=
 =?utf-8?B?L2N5V21uTWVkMjBzMEhEZ2taeEc0K01zbTlKeHF4clQ2eGlxRW5Xc05sb01s?=
 =?utf-8?B?QXRiZWJMTUhTeFRQS25kemRUN0VwdWJKa2Z2bUlxMFBCcHl6Vk45TVNHeGRm?=
 =?utf-8?B?T0RYaTZWOUN6TFFDNG1oZkVXK3N0emRQclVmYVpUQjQrS05iNlhKUDh6d3Zx?=
 =?utf-8?B?ZDVxbW9ESEtIaWtOZmVZY3krVTBZL0NZV0djY3VmcUczYlpYRmM0SVRnQjh2?=
 =?utf-8?Q?kGZ98PQC5tBj2Y8ZTTv4an4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD662FFBC9F994488C7DBA09A1E42645@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280aaf37-398f-4b25-37c7-08dc74f41898
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 15:31:31.2715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LrLqXNWDxQ4AHDHW1iioR+uQN1RFfWRazKXOQLUISuylDoG3cA13U3CpQhVthVWBIOnxsh4dyzuNomopK908ld7V+rVhbMpfcOeisT4EgOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5129
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA1LTE1IGF0IDE3OjI2ICswMjAwLCBPbGVnIE5lc3Rlcm92IHdyb3RlOg0K
PiA+IEkgdGhpbmsgaXQgd2lsbCBjcmFzaCwgdGhlcmUncyBleHBsYW5hdGlvbiBpbiB0aGUgY29t
bWVudCBpbg0KPiA+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3g4Ni90ZXN0X3NoYWRvd19zdGFj
ay5jIHRlc3QNCj4gDQo+IE9LLCB0aGFua3MuLi4NCj4gDQo+IEJ1dCB0ZXN0X3NoYWRvd19zdGFj
ay5jIGRvZXNuJ3QgZG8gQVJDSF9QUkNUTChBUkNIX1NIU1RLX0RJU0FCTEUpIGlmDQo+IGFsbCB0
aGUgdGVzdHMgc3VjY2VlZCA/IENvbmZ1c2VkIGJ1dCBuZXZlcm1pbmQuDQoNClRoZSBsYXN0IHRl
c3QgZGlzYWJsZXMgc2hhZG93IHN0YWNrIGFzIHBhcnQgb2YgdGhlIHRlc3QuIFNvIGlmIGl0IHN1
Y2NlZWRzIGl0DQpkb2Vzbid0IG5lZWQgdG8gZGlzYWJsZSB0aGUgc2hhZG93IHN0YWNrIHRvIHBy
ZXZlbnQgdW5kZXJmbG93Lg0K

