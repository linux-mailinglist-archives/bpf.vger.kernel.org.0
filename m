Return-Path: <bpf+bounces-28518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE818BB067
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 17:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13FE1C2123D
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 15:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FF1155322;
	Fri,  3 May 2024 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RempPIDx"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAF92E827;
	Fri,  3 May 2024 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714751602; cv=fail; b=u3dUvU4ytC5fX1K4UmAA294+c7AYItsN5ecTq0g4WCZ7REomIHuCu6mOcgJVxglHhjbkBZKQcmmjpYJ1YOJtZPPssmgk0vWJoxx7RzhSLV1wNUGI8IGjMKC8YEX+oiNwGAziq4bB81Jyh4wyPxirhHVdEFbRmRIfueYPdYBCTQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714751602; c=relaxed/simple;
	bh=3hb2WtA5hJ6OGoi9x2VbmpSuzje0wdeLCvjfy3rBVME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gcQGxitDv3X1deFjS2GadfAS+UClpPpwUop4gKjfmvQ7AeQqUxVxWB8JbNj9OS2LZb4Q0B/Y20iyqmtueJ8ijCRFFDhj+iAz3lixtmxRIiSnl+ZZCH61RuYUjsJFAbvXa5RnnxMnMhU/ruAZmlV2gy5Wgmaq68TULof5wFb/WWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RempPIDx; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714751601; x=1746287601;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3hb2WtA5hJ6OGoi9x2VbmpSuzje0wdeLCvjfy3rBVME=;
  b=RempPIDxVXrHAycxO5jDCoYNo04nH77v12ql6G0nt6vKc+DBFV2e6e7i
   1df+uU9IR+XsAbnGNqjt2wrNOJcNmjykq0gE5F104NgE4BqWjQ5bku23Z
   nJUFeSXFXLzzvunfXuWb2e4rEuwgHxTQrLmV/rgqQ0ltlYFyK+VVQ34U9
   vX5G1Oy50whO3XTUhXu76lYQX/0M9CO54rGgN/9zu57ucpfbXMiO6v64a
   UWvd1XfsMADCzn80L98L6fFtkL2h0ImJZfWFTO1COf44d9bcSj3fdAVp7
   SyUL4l7D5LxGvLsSPhFyF/2KDyx9vUKwIM5lnjQUt1th/jiuBmgInEw5p
   g==;
X-CSE-ConnectionGUID: aD/BmzsmT8WQ4wkJ3PbhyQ==
X-CSE-MsgGUID: yKyN3weXTOCW4JU+zlziAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14380784"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="14380784"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 08:53:20 -0700
X-CSE-ConnectionGUID: PibAL8vBQ9uUCJCpLVEATg==
X-CSE-MsgGUID: EeQa/ToFSlWjS5CJAO5XJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27511997"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 08:53:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 08:53:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 08:53:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 08:53:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cp/AnONOPWbAh8/e5vbG0HeJDoYg5X8YwxxyV5QEZQFKO3SWIQwp3eaIZCZocptO9Mluq7EsEBU+/P+sffcml4pbbDdfoAIkCqep1yolA7PVaEOsJhKGgPBR4IG9qwo2N7qq6c9hpJBhTSi9VhN67S8XZJcPzY8lDGCA0h0kce2LxG6NF/H5JIU36CMDtUgmRtQdPYpTunaW1Qd28J5qchDwTio1DKns/1mrNaMMN59TK/Cl0pyzhhb26y4RPsEi81CueGL/hDnsp0mY6xxR8POsVuB7s6rejdL8BTB46tegx5nu7qOdhc/AXVrWkqb5zJ1n8jKJngPyi9o+12POEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hb2WtA5hJ6OGoi9x2VbmpSuzje0wdeLCvjfy3rBVME=;
 b=eC7LG7Rw8BQvoDJn2iwC6u/cBGeDBnGkKP0jgGVUc4Tt+KlN/qbeb2r56YBlGprQeHH9treRfc8kAjpNuJyR5O/iKxweg7kdvzxGeX7wYwXEYtCHbNJ54W9r6565bQ7xn4JmZLIkslWSbfCEg6krJD/n9MXfF6ex/y53xEUmB+AgFgw+Jtik2fu/Wknkp6KQp8UlrDzpxPLcp/h18o9hDrxbferkaurU/02LV1TiAGEiIaC5ZOMTiKAPrXqG24seXSm662XLOm74c5sEgMvg2789QOY3E+xSvSAkl+s0/N33RrAJyjIsm2GBfXjRQeq2FPD9SJqiLrevGAHy5rVpvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA0PR11MB8356.namprd11.prod.outlook.com (2603:10b6:208:486::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 15:53:15 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%3]) with mapi id 15.20.7519.031; Fri, 3 May 2024
 15:53:15 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "olsajiri@gmail.com" <olsajiri@gmail.com>, "peterz@infradead.org"
	<peterz@infradead.org>
CC: "songliubraving@fb.com" <songliubraving@fb.com>, "luto@kernel.org"
	<luto@kernel.org>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "ast@kernel.org"
	<ast@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "yhs@fb.com"
	<yhs@fb.com>, "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCHv4 bpf-next 2/7] uprobe: Add uretprobe syscall to speed up
 return probe
Thread-Topic: [PATCHv4 bpf-next 2/7] uprobe: Add uretprobe syscall to speed up
 return probe
Thread-Index: AQHanU4GpcFda+6iuUm0ZMN/pIdOBLGFejyAgAAvKwA=
Date: Fri, 3 May 2024 15:53:15 +0000
Message-ID: <725e2000dc56d55da4097cface4109c17fe5ad1a.camel@intel.com>
References: <20240502122313.1579719-1-jolsa@kernel.org>
	 <20240502122313.1579719-3-jolsa@kernel.org>
	 <20240503113453.GK40213@noisy.programming.kicks-ass.net>
	 <ZjTg2cunShA6VbpY@krava>
In-Reply-To: <ZjTg2cunShA6VbpY@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA0PR11MB8356:EE_
x-ms-office365-filtering-correlation-id: 168cb15c-4df3-4d37-9493-08dc6b8924e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MzlhNllNKzQ1bEZZNG56NzRzVlFFbnRmTTQyakovWUI0a3hnSTZCSWZnL2dQ?=
 =?utf-8?B?aXkrdGtHUnlhTWFiNWt0b3dGMEVZRkpCbW5ZbGFnWTQ4K2U1WnhLek94TGtV?=
 =?utf-8?B?TjdDbFREaGlDbHNOK0pleDBvcnNEMWxGUnc3emE5b2ppU1FvNU5pYXpvSVpT?=
 =?utf-8?B?T2NwTURsbkV1M3BPM3pEb0tSSGZDZFRHLzlnb09GbEZSeUtoTHpJaUtBVzAw?=
 =?utf-8?B?YitXRStUVUI0Rnh1bTVia2loRTJ4VWo5b0M0U3Q4YVNScUlpNkdJTFA1WGhl?=
 =?utf-8?B?eDN1MEJPSHdBbVFHZTYxSC9VNnBYT1RjaTdWMWZ5RjhMS0psdGY0TjBkVElI?=
 =?utf-8?B?VE8vTGxxOE9tclZmZDFuNDBkR2tZd2NIUWtmR1ZNcm9DM0VHd0xERjYzcnY2?=
 =?utf-8?B?Um9Dek92UjBZVWtFSTN1eE9iNzY5alpmMGNkZHJSb3FoVkE5R1ZaMGIrM09h?=
 =?utf-8?B?bkhVd3NaTjQ3WG9GTzFqR1VCQU10bEplMlY1TE1PRkl5UDVobHk4ZjJKRXhx?=
 =?utf-8?B?anFDMU1VblEwSEl3a3FINDdhbU5HbHZzeVp4R05aWHlJMEo1L0ViQmdwN3ph?=
 =?utf-8?B?ekY0VzJhK2RCYkFjUlJKbU1aTDNxdmtLNjBwamtkR0dvK3VQeGt2MjhDd0xY?=
 =?utf-8?B?N0F1MXR1SmtnSGJQMmpNd3NxdGFGa1A1bkRxYTVDK0I2eGdnNER2M1BNd1R1?=
 =?utf-8?B?TlN4ZUxGQVNoNWUvYm1iT3lZS3FlWWhTa2hFaHlyL0dwOFlIQ3JyUTVSdUhN?=
 =?utf-8?B?OW9yeVRmRGJHQjlJU2F0QXJYeWlPajBQUS9ZNWFoWlY1b0Z6QzZxdU9uZmwz?=
 =?utf-8?B?SVlqSzVLVmtVRjJMZzY5KytFak9Nc2cwMWRYSThpOHpLcEVNeFNRalRvQ3du?=
 =?utf-8?B?Q09jbTNsYVhDdTd5WFFGaHdrekhET1pvRzFUQ0k2UFoxVlh0aTJpZlViQU42?=
 =?utf-8?B?d2h6SHlsREwvWFZ0aEUzZzBsZzFzZjhpMlJnWTIrN3VZd1RGdTNtRWFlNHdq?=
 =?utf-8?B?dUJBVTNZZC9yeE5iL1J3YTJDbWZ0SXdXSC9zZ21RaVFsSEFhQWdlZk43cHJw?=
 =?utf-8?B?UjdBR0pwTWZ1YWNwcmNZVnZiU2lqemJXTlhKbWxjR2dtVDZqZGF0TjkvZ29W?=
 =?utf-8?B?eDdPRGljL2RwVFl3VzFPTG9ta2RrbjFjV01NY3NTclF2alNjQXFGbzVMZWpM?=
 =?utf-8?B?b1RucitBclZQV245Vjg3eVNrRlJiQ0IvdklaQnZDa0JTeVAzRHAxWmo1T1Ja?=
 =?utf-8?B?SyttZzc1MTZNMXJiSTFTK2UzUHcvSkR4ekJjZWpJTlhYM0xUYk56THluMlA5?=
 =?utf-8?B?OGJYbXN3Q2thblJqYTRhYS9CM1hEcDZVb0M4cW1Rbi9GT1NONmNvYU5oQSt2?=
 =?utf-8?B?Y01nRzdBSjV0ODQrd3NzYVZ0SVR5USs0R2NUb0RzbFZVWEJWN3o2SkltMEZj?=
 =?utf-8?B?UEZ5bExqSTBLMXE5QW5UR1lHVW5OUEU0aWtWeDRUMm04TjJ1dllvTU1rakpR?=
 =?utf-8?B?N0lpUFJPajRSK1BoNW5CVXpiY3NJMndCQVRZRUNpRnVtdGlnS2NvTGtBK1k4?=
 =?utf-8?B?azYxamtRSHcwU3NNQ2NTQ3ZjeEhEdXhRNXJWeG5Ob0tLdk5BcjNHZnFHcjk2?=
 =?utf-8?B?YkRQTHo0RFVTWTNKY3gzRTJTQk94aXFWeURZbkhIaXVXbXE5dk1XU2czbnUw?=
 =?utf-8?B?d0g1QVE5TzZJcjRRZ245K1pNMTQyc1hIWVNJbGtpRU5MdVcvVTEzaUxvRTZh?=
 =?utf-8?B?cXY2clhkTTU0ZDk0LzJjZXhnME9CSGM0RXFiU0tQMS82QUJrSGYwNnBtd0Nl?=
 =?utf-8?B?ck9oTlZlVWhoRFVjNjB4Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0N5eXZKVzNiMzE5dk5UemNpUklEUnhMMnNWSkpYTUFMbzgwSkdrOENIN0Qv?=
 =?utf-8?B?TTJ4bktObFhBMElFcUgrUFBBa09HREppd1gvaFRITlJVcUVpTWZtWW1RY2dI?=
 =?utf-8?B?YSs2ZGxHT00raHV0U3VBaW5uMUlPRTRLdWlRalJGYTBXQldYM0NtcEtUTDlS?=
 =?utf-8?B?aEFBNmNDWXFzKzg2Qmh4V1dkUHZBdFk4THN2N1ZDak1NejQ4czEzQnhGc2E2?=
 =?utf-8?B?UmpidEtpMWprTUovWE42aVRtZ1M5eW9VcnZlQzJmeGJkVzJGRGIvN01hamhO?=
 =?utf-8?B?MlN2Uk03bjU0bnZ4QVF4ZWNzSFZDeVVDME1SY1RWNUgzWjE3SCs3Zk1yRFZB?=
 =?utf-8?B?ekdyMkZTUW1LUHB5ZU9LaEFzR3ZwQXZwUE1hUWlERDI5OGZ4c3A0ekd5NHNH?=
 =?utf-8?B?dFJyNjRJM2Mzd2EwTFBlMkZGdEVoQUM2VnVvRGtLT2l2cW1YM1Nzc0syYlFw?=
 =?utf-8?B?WDBTbGdLMDgxck9rSUZ0OWxSZmxiK3FGK2xUR3lBOWFENmUwSDlmTm15RXJH?=
 =?utf-8?B?NTk4QThrbk91d3BRTkFzaXFpektPTnNtMHA3WVpZeFI4dVNLVzV5eUNKRmRL?=
 =?utf-8?B?SVltVExkeFZHditMak9ORVpqU1BPTCsxcTFqajg4c2YrdUV2cnRtRUJONTlZ?=
 =?utf-8?B?RDFhWmVTNjJid0NrTlJ3WCtyTGwxMWtXZS93KzJibmVWOFphNWRHdnFwYy96?=
 =?utf-8?B?WHlMMjhiVVVPWHcyb0t6WmxZSlU2WTN5TnQwNzBlajZOMTYycVZheWo5Q0ky?=
 =?utf-8?B?YXRwZjJJZkJYblNOaEJBQ1pvN3lNV2VnemxHNThubE5JV0dHa0xiOExUWCtH?=
 =?utf-8?B?R04yRVI3QWxubWtodTAyV0xOZUtYUzI5N0V4eklsSmdxdGRiWjRrTUpHR1V0?=
 =?utf-8?B?SDJWTi9tTUF6aElWakNYZXovK3FGL01rUExrM1djWThXdk0rb0FWTG5sSXQ5?=
 =?utf-8?B?c1hNZThCaGVrUGUwZGhWVzNuWE45MHlJdHgza3ltVW9oUE1UcHpad3hnZTUr?=
 =?utf-8?B?UkJRYzFuOGwxYlV2QnlmRnhESXFHNFprcDA1a2huSGdlZjhhTXBwdklxYm9P?=
 =?utf-8?B?Y2djRW1kdStTdGZkcnB6ZU92ZVdKMzBSWG1BZjBxZkxOQ2Vmb2oweitvRnE1?=
 =?utf-8?B?cFlNQjgzRzl1bkJVSUg2aUc2WEJZNjdaU2ZFVDBKZS9RWXBGVDNrc1YrNFhQ?=
 =?utf-8?B?Z3lwNFl4eDhreU9zOWx3djlSajdoRFAyTUZKMnM5Q21DMjZ3TDJvclU2ODRt?=
 =?utf-8?B?K1dEazZ5QVFKcTFtVEFMV2QzNi80ZUNiYldYaHh6b1NOeWU5TG44T3JxMDk3?=
 =?utf-8?B?VStOUTRJQ2I0aFNPRlRhcGZmR1Vsako1SXRGdTh1U3pCUEY2c0o3MEJ3RlVv?=
 =?utf-8?B?TVExRlYwcUg3UVVDMUkzdkVhNi9VNHFiTmNQRmFsc3RVTUxqLysrOWh5KzRO?=
 =?utf-8?B?YkcxWGlrbEFyNzBmY1krdEhHRVZxcHdUaW1KUjIyYjhjMHlteVRQdDliV1lx?=
 =?utf-8?B?ODlkSVNEeWVhR1FsakwzRjdoTXJRMWpVMlBhZVhzWE9JV1lYNlhZVTRNUitF?=
 =?utf-8?B?RjMyRFJCZllMRnBUY2l5QXZvSzdmSk1HWkNPU25Fb3k3by9UaVBOZUpNRGFO?=
 =?utf-8?B?RDg1aWpvbUhITkRsU2lvSzd5YWZQaTZCSXhTdmV1bVFCRzhmZ1RDTEx1L1NT?=
 =?utf-8?B?L0dNREt4eG4xOGJMMlFCbm9sZFdDbnlYVVZzb1JjYnVkNFA5am9PNTloaHFF?=
 =?utf-8?B?eDk3YTlyZGthbi8vaXg4dnJwUnpHYzlzTVlBbUlLYWc3OXJaR242TGVacHo5?=
 =?utf-8?B?dFJ2NmtUZ2hsdHRrRDQvcTZIcUprVmEvQ2dPM0ExZFRBVFNhZDhmT3ZaWDRr?=
 =?utf-8?B?aXg5WGJSWkp0WmxlckFFSVBHZWlWZG1Pc1d1UzNtK2s0R0tUbU9vNlIxM0dq?=
 =?utf-8?B?UTgyVnF5d3REakcrTi9haDBDL2JvQ2pBTEtVK2pXSk1CeFRub3N1eHdNZ2Ra?=
 =?utf-8?B?L0FXSGduM01nMU1kMDMzeUtiaHBIVHV5NmZ4aCtUcWNaaU9HY2dxY2pxaG9F?=
 =?utf-8?B?MW5ienorTHJyRGU3bnVzOEpMTXowV2NvcjVrYWdsTDcvOElaZEl2MVVYSFl2?=
 =?utf-8?B?eFhCTlBxNlFyemhqL1o0NDM5cllHT3dlN3RzSmNNMXU1eVpUcWoxZEJNNGFN?=
 =?utf-8?Q?litxHD6K75zeISj+2ppE4T4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BF7B4CFEA904947B3683E601F166815@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168cb15c-4df3-4d37-9493-08dc6b8924e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 15:53:15.3280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mzll0ORspFPK9pSSRvicq3+L/NzRXMg7cRQOsHgz8RUYIbPMTJw1+LeUbmsiONy7WBWHWFvd+SAGethLOfCfNibMj/R2P1Zh4sT3smWmOR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8356
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA1LTAzIGF0IDE1OjA0ICswMjAwLCBKaXJpIE9sc2Egd3JvdGU6DQo+IE9u
IEZyaSwgTWF5IDAzLCAyMDI0IGF0IDAxOjM0OjUzUE0gKzAyMDAsIFBldGVyIFppamxzdHJhIHdy
b3RlOg0KPiA+IE9uIFRodSwgTWF5IDAyLCAyMDI0IGF0IDAyOjIzOjA4UE0gKzAyMDAsIEppcmkg
T2xzYSB3cm90ZToNCj4gPiA+IEFkZGluZyB1cmV0cHJvYmUgc3lzY2FsbCBpbnN0ZWFkIG9mIHRy
YXAgdG8gc3BlZWQgdXAgcmV0dXJuIHByb2JlLg0KPiA+ID4gDQo+ID4gPiBBdCB0aGUgbW9tZW50
IHRoZSB1cmV0cHJvYmUgc2V0dXAvcGF0aCBpczoNCj4gPiA+IA0KPiA+ID4gwqDCoCAtIGluc3Rh
bGwgZW50cnkgdXByb2JlDQo+ID4gPiANCj4gPiA+IMKgwqAgLSB3aGVuIHRoZSB1cHJvYmUgaXMg
aGl0LCBpdCBvdmVyd3JpdGVzIHByb2JlZCBmdW5jdGlvbidzIHJldHVybg0KPiA+ID4gYWRkcmVz
cw0KPiA+ID4gwqDCoMKgwqAgb24gc3RhY2sgd2l0aCBhZGRyZXNzIG9mIHRoZSB0cmFtcG9saW5l
IHRoYXQgY29udGFpbnMgYnJlYWtwb2ludA0KPiA+ID4gwqDCoMKgwqAgaW5zdHJ1Y3Rpb24NCj4g
PiA+IA0KPiA+ID4gwqDCoCAtIHRoZSBicmVha3BvaW50IHRyYXAgY29kZSBoYW5kbGVzIHRoZSB1
cmV0cHJvYmUgY29uc3VtZXJzIGV4ZWN1dGlvbg0KPiA+ID4gYW5kDQo+ID4gPiDCoMKgwqDCoCBq
dW1wcyBiYWNrIHRvIG9yaWdpbmFsIHJldHVybiBhZGRyZXNzDQoNCkhpLA0KDQpJIHdvcmtlZCBv
biB0aGUgeDg2IHNoYWRvdyBzdGFjayBzdXBwb3J0Lg0KDQpJIGRpZG4ndCBrbm93IHVwcm9iZXMg
ZGlkIGFueXRoaW5nIGxpa2UgdGhpcy4gSW4gaGluZHNpZ2h0IEkgc2hvdWxkIGhhdmUgbG9va2Vk
DQptb3JlIGNsb3NlbHkuIFRoZSBjdXJyZW50IHVwc3RyZWFtIGJlaGF2aW9yIGlzIHRvIG92ZXJ3
cml0ZSB0aGUgcmV0dXJuIGFkZHJlc3MNCm9uIHRoZSBzdGFjaz8NCg0KU3R1cGlkIHVwcm9iZXMg
cXVlc3Rpb24gLSB3aGF0IGlzIGFjdHVhbGx5IG92ZXJ3cml0aW5nIHRoZSByZXR1cm4gYWRkcmVz
cyBvbiB0aGUNCnN0YWNrPyBJcyBpdCB0aGUga2VybmVsPyBJZiBzbyBwZXJoYXBzIHRoZSBrZXJu
ZWwgY291bGQganVzdCB1cGRhdGUgdGhlIHNoYWRvdw0Kc3RhY2sgYXQgdGhlIHNhbWUgdGltZS4N
Cg0KPiA+ID4gDQo+ID4gPiBUaGlzIHBhdGNoIHJlcGxhY2VzIHRoZSBhYm92ZSB0cmFtcG9saW5l
J3MgYnJlYWtwb2ludCBpbnN0cnVjdGlvbiB3aXRoIG5ldw0KPiA+ID4gdXJlcHJvYmUgc3lzY2Fs
bCBjYWxsLiBUaGlzIHN5c2NhbGwgZG9lcyBleGFjdGx5IHRoZSBzYW1lIGpvYiBhcyB0aGUgdHJh
cA0KPiA+ID4gd2l0aCBzb21lIG1vcmUgZXh0cmEgd29yazoNCj4gPiA+IA0KPiA+ID4gwqDCoCAt
IHN5c2NhbGwgdHJhbXBvbGluZSBtdXN0IHNhdmUgb3JpZ2luYWwgdmFsdWUgZm9yIHJheC9yMTEv
cmN4IHJlZ2lzdGVycw0KPiA+ID4gwqDCoMKgwqAgb24gc3RhY2sgLSByYXggaXMgc2V0IHRvIHN5
c2NhbGwgbnVtYmVyIGFuZCByMTEvcmN4IGFyZSBjaGFuZ2VkIGFuZA0KPiA+ID4gwqDCoMKgwqAg
dXNlZCBieSBzeXNjYWxsIGluc3RydWN0aW9uDQo+ID4gPiANCj4gPiA+IMKgwqAgLSB0aGUgc3lz
Y2FsbCBjb2RlIHJlYWRzIHRoZSBvcmlnaW5hbCB2YWx1ZXMgb2YgdGhvc2UgcmVnaXN0ZXJzIGFu
ZA0KPiA+ID4gwqDCoMKgwqAgcmVzdG9yZSB0aG9zZSB2YWx1ZXMgaW4gdGFzaydzIHB0X3JlZ3Mg
YXJlYQ0KPiA+ID4gDQo+ID4gPiDCoMKgIC0gb25seSBjYWxsZXIgZnJvbSB0cmFtcG9saW5lIGV4
cG9zZWQgaW4gJ1t1cHJvYmVzXScgaXMgYWxsb3dlZCwNCj4gPiA+IMKgwqDCoMKgIHRoZSBwcm9j
ZXNzIHdpbGwgcmVjZWl2ZSBTSUdJTEwgc2lnbmFsIG90aGVyd2lzZQ0KPiA+ID4gDQo+ID4gDQo+
ID4gRGlkIHlvdSBjb25zaWRlciBzaGFkb3cgc3RhY2tzPyBJSVJDIHdlIGN1cnJlbnRseSBoYXZl
IHVzZXJzcGFjZSBzaGFkb3cNCj4gPiBzdGFjayBzdXBwb3J0IGF2YWlsYWJsZSwgYW5kIHRoYXQg
d2lsbCB1dHRlcmx5IGJyZWFrIGFsbCBvZiB0aGlzLg0KPiANCj4gbm9wZS4uIEkgZ3Vlc3MgaXQn
cyB0aGUgZXh0cmEgcmV0IGluc3RydWN0aW9uIGluIHRoZSB0cmFtcG9saW5lIHRoYXQgd291bGQN
Cj4gbWFrZSBpdCBjcmFzaD8NCg0KVGhlIG9yaWdpbmFsIGJlaGF2aW9yIHNlZW1zIHByb2JsZW1h
dGljIGZvciBzaGFkb3cgc3RhY2sgSUlVQy4gSSdtIG5vdCBzdXJlIG9mDQp0aGUgYWRkaXRpb25h
bCBicmVha2FnZSB3aXRoIHRoZSBuZXcgYmVoYXZpb3IuDQoNClJvdWdobHksIGhvdyBzaGFkb3cg
c3RhY2sgd29ya3MgaXMgdGhlcmUgaXMgYW4gYWRkaXRpb25hbCBwcm90ZWN0ZWQgc3RhY2sgZm9y
DQp0aGUgYXBwIHRocmVhZC4gVGhlIEhXIHB1c2hlcyB0byBmcm9tIHRoZSBzaGFkb3cgc3RhY2sg
d2l0aCBDQUxMLCBhbmQgcG9wcyBmcm9tDQppdCB3aXRoIFJFVC4gQnV0IGl0IGFsc28gY29udGlu
dWVzIHRvIHB1c2ggYW5kIHBvcCBmcm9tIHRoZSBub3JtYWwgc3RhY2suIE9uDQpwb3AsIGlmIHRo
ZSB2YWx1ZXMgZG9uJ3QgbWF0Y2ggYmV0d2VlbiB0aGUgdHdvIHN0YWNrcywgYW4gZXhjZXB0aW9u
IGlzDQpnZW5lcmF0ZWQuIFRoZSB3aG9sZSBwb2ludCBpcyB0byBwcmV2ZW50IHRoZSBhcHAgZnJv
bSBvdmVyd3JpdGluZyBpdHMgc3RhY2sNCnJldHVybiBhZGRyZXNzIHRvIHJldHVybiB0byByYW5k
b20gcGxhY2VzLg0KDQpVc2Vyc3BhY2UgY2Fubm90IChub3JtYWxseSkgd3JpdGUgdG8gdGhlIHNo
YWRvdyBzdGFjaywgYnV0IHRoZSBrZXJuZWwgY2FuIGRvDQp0aGlzIG9yIGFkdXN0IHRoZSBTU1Ag
KHNoYWRvdyBzdGFjayBwb2ludGVyKS4gU28gaW4gdGhlIGtlcm5lbCAoZm9yIHRoaW5ncyBsaWtl
DQpzaWdyZXR1cm4pIHRoZXJlIGlzIGFuIGFiaWxpdHkgdG8gZG8gd2hhdCBpcyBuZWVkZWQuIFB0
cmFjZXJzIGFsc28gY2FuIGRvIHRoaW5ncw0KbGlrZSB0aGlzLg0K

