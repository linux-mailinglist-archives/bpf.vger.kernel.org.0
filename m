Return-Path: <bpf+bounces-29204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B608C12AB
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 18:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0AE281512
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A704D16F90E;
	Thu,  9 May 2024 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QO+SKTrp"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B2250A6C;
	Thu,  9 May 2024 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271884; cv=fail; b=NwjKo3KZjWuvur/pDErZz/zF6uJ237EkPXEjOj9EYW1d/8XsK8ZNcJIrRY2g6SnE1/aIdSwiZUscNPwfPhMYJJrybVW6WA143keQG6ZZSV/4ZGjKIcgpZFDwKs51+czEVVG1hvHdtXFe4kM08rWnmr7YCdPcZA14puSllJoHBCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271884; c=relaxed/simple;
	bh=GP8dpDaqTieaeUKSnaJ/QJFBz+ZLmlBz9U62G9f1XfE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LFtK+8+lTZw7l6OhVDv0/E4rvjhjh/kai+VKJMDz0GV8gmrGFbIhCrlt451fd+8TOM2X/kfnURZaaLIeAC58YXzaFq1eFBtgNg/PIAWmUl5L1yk6U/q9jmqS6dautjd8CaZgTy3NmGFJXCC85yyzwjfOrBKr0IKncqGJTEo1hG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QO+SKTrp; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715271882; x=1746807882;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GP8dpDaqTieaeUKSnaJ/QJFBz+ZLmlBz9U62G9f1XfE=;
  b=QO+SKTrprVIeWbGDuy2Pg0o1sp+z7IyqXw2sg47eASHyADwS+Ajo7FTB
   eNs8cRgjac+vbcPdZWgC/I19TUBxhShyvbyBxwYwM/EZW6QGtcxl0bQ0Y
   SOaM8SrTq/WGXvi456pIUQKvXFB/fSmlTUvMvIYoK9DB8EsmPStg8BBdW
   BQUS3dOI5beH7tOyCSQLwg0xXOH2FEANG0Z9gs2PrHiJjBbYWYrlS+tky
   Ufi4GmZh+ZJX+MRchET2551QayPKwGmjMpTstFTjbEq4nEo3CKxZMYC1K
   h0nvMOUrCayGXg1+GX/LznykGLKnLxv3tK5ZyNCYhUo+zX1UIxgEYCNvv
   w==;
X-CSE-ConnectionGUID: x5juNBwuQ8qpY7QnsB3UEw==
X-CSE-MsgGUID: AwiCHKMqTJO7sKvtbfPfsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="14156646"
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="14156646"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 09:24:41 -0700
X-CSE-ConnectionGUID: UAhV9xX6S0Gwsir/oLpzGA==
X-CSE-MsgGUID: vvdDx4IGSFC0RXkEhc74Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="52497006"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 09:24:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 09:24:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 09:24:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 09:24:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 09:24:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6I0PZ4E0R/cl2TpADCXKvab8a6C6Pi6lk0no5eqENN4DiD7xlsET+cFPsAAZFvCGKWkCqCYsbyrgwZ2kSHXAEQYTmMoYKpX58CXk/pkRsU7X0Jzcjwhf87sSG+2QdzkQSUadjb/3v7GMAZaM1X7NFXdEZSBPNLtyk3A5OSxTPrrMTo6iJ7+rSnIqPfIOcPHV7wjtsR1YoDN1AV4GvA/56kbvw56yG4cagxVX7YWe1+bBEC+WkqpmczheKDxKXlIBxhfkSvUmNeznvXZWZ8JZ7mt7sZtGpTbIopg9cCkcjVcSXO4MamLn3c42IZCOs5ho+cSzEcTL9XG+kkjaTOkXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GP8dpDaqTieaeUKSnaJ/QJFBz+ZLmlBz9U62G9f1XfE=;
 b=aW5OndzI3jGcziTPbNVqaOd+6uf98epUcfk+TDVuyMPcLk/2FgU69+AXsZvFIPnEL2IIThuI3PuKm8Cm1F+m+DUnayno6popQCbpmxjucASiXF/1rZAb8yuO+9FT4AOwGwnvXKNyhWxih59WhMkm8GfYGt5vE1DC8C8hPW/5WzMXkAz/k2Fejzkt0Y//7HPlQJGb8vPR2eaNPp8mGwHBaiBB5Np8WASv26sNB1ydr/e9XBCJKqh73VZTf1cwi3PEsAVLxkQpCehV9v+5L4JNwlAgDWmgfuk5/r7v2YWbNaNHkthmpIjVfVh0gQIZ8axGWm8jkMv2qQj7gM2TvJ0pag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW4PR11MB6983.namprd11.prod.outlook.com (2603:10b6:303:226::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 16:24:37 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%3]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 16:24:37 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "olsajiri@gmail.com" <olsajiri@gmail.com>
CC: "songliubraving@fb.com" <songliubraving@fb.com>, "luto@kernel.org"
	<luto@kernel.org>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>, "debug@rivosinc.com"
	<debug@rivosinc.com>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "ast@kernel.org" <ast@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "yhs@fb.com" <yhs@fb.com>,
	"oleg@redhat.com" <oleg@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-man@vger.kernel.org"
	<linux-man@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv5 bpf-next 6/8] x86/shstk: Add return uprobe support
Thread-Topic: [PATCHv5 bpf-next 6/8] x86/shstk: Add return uprobe support
Thread-Index: AQHaoGz/NDbwXOtepku5mG5JmKvX1LGMCSqAgAKMVwCAAIRoAA==
Date: Thu, 9 May 2024 16:24:37 +0000
Message-ID: <a8b7be15e6dbb1e8f2acaee7dae21fec7775194c.camel@intel.com>
References: <20240507105321.71524-1-jolsa@kernel.org>
	 <20240507105321.71524-7-jolsa@kernel.org>
	 <a08a955c74682e9dc6eb6d49b91c6968c9b62f75.camel@intel.com>
	 <ZjyJsl_u_FmYHrki@krava>
In-Reply-To: <ZjyJsl_u_FmYHrki@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW4PR11MB6983:EE_
x-ms-office365-filtering-correlation-id: 3551f087-2df0-4a46-9af0-08dc70448513
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?cyt2WnhiUFZsLzlMQjN2b1c0bW1MZUNlUWVycm1CYTZwNFZIR1ZjbFlSVFl1?=
 =?utf-8?B?OWJ5MmtYaE5EazZ3djdnUHNoandJMUdWYWt0clcxNTZHaXRpTnpCdXZoL1ZX?=
 =?utf-8?B?bkE4VnZkdTFhSXZzOTd0MmJlc2ZXNlM5UnZSd2VWWnF3L1pHV2lVS0Vxa0dP?=
 =?utf-8?B?ZHIzVGtrQlVqWGN6NklzNkJLZXBYUzRCU1NCVjdodTNNOENMdkIxem1oVmlN?=
 =?utf-8?B?aTVFQ0ZaS25ZTzBOYVJDUm5ldUpVeC9NRVdOWWdDR01ZOVNRb0QvdlE0aU90?=
 =?utf-8?B?R2ZYeWxjbVU2YWNENlJkYm9wNFUwTC9sS29ZV2FIdGI1TEVuUWMzelpkSm40?=
 =?utf-8?B?QmNPYWdtVFoxNmJkVCs2N1ZrM1NucC9CVUFSeHJTUnhhL080RDJWeXljdVpW?=
 =?utf-8?B?djZtODJGcU1IempLWERmTHZUTy9EbFhNWWpFdStNUmhFK1FtSU1EV2U0bzJu?=
 =?utf-8?B?TjB3OUYzTjJXQTc1SDc5SktIcXJ2cTAvTXh5L0xZRFRzWmlLeFcrbWFsRTM1?=
 =?utf-8?B?KzZFMnRUV1RxalJwTDBIcTgwWU9MZWlDUnJlbzZtMGxreGp3QWRYTzhzMmkv?=
 =?utf-8?B?ZVdXQmszWUlvSEwzTCtkYmJSRklzMko4WWV1VjRJL25YcjRhZ1hWREhoSlpl?=
 =?utf-8?B?M2Rhb2JtbE0ycWZvTHUzUDg2NE1PUUEzMDZzNzNoNkFONEtYWXVUOENUQStn?=
 =?utf-8?B?cnZ4Y0QwcWIvNHUxMy9tcG9vdFJpb1d0TXQ1YnY2VS9kVzB0RjN3QTZjRzRm?=
 =?utf-8?B?VGNGQVVjRHhTZGNMaDUrbXpNbGZSa1pERDFDWXhIWnQ2djV4bGhjV05HVk4y?=
 =?utf-8?B?RFlTL2RjY2h2WVIwNEpTQ0tGZm9tWDJ4QlVocTl1TmpHREJqUnJVUXU2L1dN?=
 =?utf-8?B?a1pGdFlBRGZPV1NlTU1rZkdnWUl5MSsxOVhlWUZEaHR2TjJzMmtnM0t5bkho?=
 =?utf-8?B?YW5manZXbGpQQy84em56OERpKzVvdGFaUEh4Y25TTnRaU3lPWElRVUxpWkZ3?=
 =?utf-8?B?WUk2V0daL2E2T0hDWUdBVVFVTFk1dUVydkR3TC96SG1JaWYza29nekY5MkRS?=
 =?utf-8?B?VlMrWGVZaFFxNk8rMG5zdS9KRmkweEpLWXJwTFM3MGVLOUg4Mm1yc2M2UFpU?=
 =?utf-8?B?YTBGM3Jzclk1ZEZVcENvQ2tUdVU0dmk5WEFOU3VVV2pmd2g0Nmk4NWx1bURD?=
 =?utf-8?B?NmlncWRFbnQ4VU9zZUYvWGFQTFZES1kzQThLanNVRE1jallTWnV3VFRCYmp2?=
 =?utf-8?B?NEtHU2pCR2dZdFBsYWtZZTJQeWMrNUFzUnZLS3NiQTA5bEUrK21qWVcwQVFv?=
 =?utf-8?B?czBLbllNdlFta21xK090Z2l0ZitQWWVxelZpYVhxcjFDNFgxWldNTzZFRHRJ?=
 =?utf-8?B?cWwvcFFrczNjWkJ4UTE3WS9LLzljV3pjNHQ2R0o0bzMvR2k4dERpNC9pVENM?=
 =?utf-8?B?Z05SdlNYby83QjAyVnN0YTdHNlBXT090MkY5UTZlUG9XNGNmaGh6eFVkbE5M?=
 =?utf-8?B?Z04wWTRKY1ZhSTVFdGJMVStwSVpjNjNZMEdwYTFuK3N0NHFmcUN5Rjc4YnFx?=
 =?utf-8?B?alNBajI3dHp0MWtZVldEMFJueCsyWVNEZ1k2SUc1T2JiNmc0bmExRXcycGY3?=
 =?utf-8?B?Zms4Z1gzWUhRZE5Rdzlia01ST1lOTHVzT1EvSXFGeTNBQ01OelkvVTRmSldz?=
 =?utf-8?B?bmMrOGFsWWUyM0lEM3poNVRrRlppSU9ldzBEMjJVdWtkbm1MVjh5OWtyOCtt?=
 =?utf-8?B?QzRqbDdCcEp5RzdhbHZuRlRVMVFKMGl6VEZSeGk1UEpZT3BNVEg3N2YvRE94?=
 =?utf-8?B?UGppdDhvOHZ0b1ZDdTNVZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZW0rOFZtK01wZHVWL3NpSjZLOWhtODU0QVJRamlWbGpVbFphZzRzS2JVTHJh?=
 =?utf-8?B?M3IvNVlHc0ZDbk04RjBXSTRodzl5aVhmcjdDTE56TmdJelJQNTFzNDNxM21W?=
 =?utf-8?B?VEJHaUZPOEJjVEo5cUtCK2VKbjFhVVpRRmhWUzZjclBQSlJDUkhYQ09ySklC?=
 =?utf-8?B?aXdXVnlENHM0bVluWnVYWVVsZHByWWk2a21ZOHFackhnUGxzMmpJakdRbE1O?=
 =?utf-8?B?L3M5TGxVaDN3WVBvbjVWOHAvMXA4bEFIM01oallhZjl3WHhFckhEd0hVTC9Y?=
 =?utf-8?B?bXJkeUpMNnVJU2xyaW5UMC9NNWVFZDJGOTFCRUV4WnloZ1pFWjRlZm5WTk1h?=
 =?utf-8?B?QVYyVHFrSFVHZjVvVWJoeEpNekRJejBwMjNPbmhjVzBRTEczNWs4UVk5d2gy?=
 =?utf-8?B?dEN2c0JVZUx4S2U3SFVDTlRNbXRSZGcvclZwRVBnUVd6QkNDeDJzTHdNaVhO?=
 =?utf-8?B?ZkZRY3BXaXh3aVYrMVlVdE5reTRrZUcyYWlva3paYVdLT0xZRnVZYW11eDBC?=
 =?utf-8?B?R2N4ZCtEa2ZuamFvNXY4ZU96MHZzMFhRclNPNE5IcnhFREEralhQZE9aUHJK?=
 =?utf-8?B?aEhwS2VuYW90VjRBMEYxR1NCbXRMMnRoaTlRWUtKY2JyWU5JRHR3SlV1YWty?=
 =?utf-8?B?RWJOL3BJVTEzQktmTTAxOFMyUUk0Mjk0S3E3S01mdnN5QndRQXp0cUlvdEgz?=
 =?utf-8?B?a2xhS2g2bjA4cVJKYVpzdE1LdTU4MEdsMHY1Tk00M054STl3T1BYcDVGQkJP?=
 =?utf-8?B?TGdoMnRtZGNpWGdPNlh1dGRaaHh1L2Q1RGlURzNXV1pzTjBRZW93VFVYa1NT?=
 =?utf-8?B?U0xLNzU2a3ZHOUt1Y1NjQkRmTW9URG81SmpyMzdRMDVROVRGdXp0dDRoaUJI?=
 =?utf-8?B?UUJiTGN5QUpRRStLcmg2UFVqdXBENVpNZ3hyb2szd2ZscHpvV2tndVBnZ0Uz?=
 =?utf-8?B?NmIxOWZ1K1JGeG95L2owNkhGUlNiV2tiSkQzVlphb0xHbUt5a2d6RFIrS3dW?=
 =?utf-8?B?RDhDaWsxTUNWWGVGN3JZWC9OSkNCSStETExDbXFUc1JWODFjRGRVbzUvNFFo?=
 =?utf-8?B?Y1hnRm4yeEU3S3hCdFltRUtWdXZFZGFPSTNiaDIvOUU3TERnSDJvUEFpaXFG?=
 =?utf-8?B?TnRQcnplTit4dmwyN2F6cCtUTnpWNm91ejgvWS8ySnlBbzZzOEY0a2ZqdXZ4?=
 =?utf-8?B?ZHBOOXRZN1p1K2xHUi94M2I2ckRTQ0VKQm9XakE0T2lRbGhOYTJ4cTI1Wnho?=
 =?utf-8?B?ZEk4Ui85OW5sTGIzWklqSzhYTHkzNUQrMERQdDF6aWZSQW8xaTJ4ZHdQUkVB?=
 =?utf-8?B?NFdxOERZWGYyaURqWHRhT1Z2dFdEN1NYWnVraUZzaWEwL0FuU0pYeTk5MXZE?=
 =?utf-8?B?KzdsT25hYXArYmsxQ1ZwOTJ2RDBhUzQreG8yR1ZQZW96VEQrTVpRNlR3Umw1?=
 =?utf-8?B?SEJrYThBMFkxMXpmd1ZraG5uUTVKb1NXZlJFK3hteVdxQzVDMWhPQ0pwM3Ry?=
 =?utf-8?B?TU9UcjVqS3k5dlUwSk5PSXllOU5tYTJ4UllsSUx0am1YanN5YUZQL05ZTk5K?=
 =?utf-8?B?UXJKL1o3d3ROKzBtVm1LVFl4YjRtY2k4am5SazZQUDZDOG92WWJnbHRxUHdJ?=
 =?utf-8?B?RFFaWXI1NUNJMkJkWmlJZnorSmZORFRnQzAwTEozY25XRXhHU1J4eE9ydEs4?=
 =?utf-8?B?VGdaNTZUbWdwTStWdnpHLzdHWjRsb0E3YjRadG9pOXMxd0xwc3pxa0o5OUpT?=
 =?utf-8?B?TEF1UzB1TDBvVzNPOG1uU2FLcDlhU3FhQ2VWTExFTmRQZ0ZNZUhHMTFxQlYy?=
 =?utf-8?B?bzZBNHVqZzl3TDFZT0tzZytZeU9OWVJjdXlISXRSWTVrZDF1ZmRjVmpsOHo0?=
 =?utf-8?B?M2M5TUdQQWRFdXV6dkZRYWZYVE4yaDdkWHE1YUU2NFNFS0tLT3Zvc2M2RjFx?=
 =?utf-8?B?RWw2c1lUSjBCdE13N3owcFc3Wi85d2k3U2RxUlVGekhON0FXS0ZhYVZWQkt6?=
 =?utf-8?B?WjM5Zm5Wc2l2SmU3bThzdVFsUjRWQThHai9LNmhmdHdySEZpendJeE1zVjBy?=
 =?utf-8?B?cXBYLzJBN0o2SmJwSXlBbFdIc2FOUWZxODdMWVBDeWcxY0xFdTZCSmVwV2x1?=
 =?utf-8?B?UW82dkJFcDRiVjFuQTVkZWFvU1Y1QmtHQXVGeWZLTk9CN0FYc3BVYVZZUVBJ?=
 =?utf-8?Q?Q+PL75S7GfG2rlmHQNoZuZE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BAE96D65C75534CA48EF4943D3EEC74@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3551f087-2df0-4a46-9af0-08dc70448513
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 16:24:37.2261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6yxT/Wam0lDCJYx1pjZaGQew+Xga2kBJ7PfyenbIy1InWPdzm1iVdPBdd4cABbKbp2UKU1jp5g4/gunCLb1QLUKBfOq9GgRDf/IcBvKa5HM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6983
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA1LTA5IGF0IDEwOjMwICswMjAwLCBKaXJpIE9sc2Egd3JvdGU6DQo+ID4g
UGVyIHRoZSBlYXJsaWVyIGRpc2N1c3Npb24sIHRoaXMgY2Fubm90IGJlIHJlYWNoZWQgdW5sZXNz
IHVyZXRwcm9iZXMgYXJlIGluDQo+ID4gdXNlLA0KPiA+IHdoaWNoIGNhbm5vdCBoYXBwZW4gd2l0
aG91dCBzb21ldGhpbmcgd2l0aCBwcml2aWxlZ2VzIHRha2luZyBhbiBhY3Rpb24uIEJ1dA0KPiA+
IGFyZQ0KPiA+IHVyZXRwcm9iZXMgZXZlciB1c2VkIGZvciBtb25pdG9yaW5nIGFwcGxpY2F0aW9u
cyB3aGVyZSBzZWN1cml0eSBpcw0KPiA+IGltcG9ydGFudD8gT3INCj4gPiBpcyBpdCBzdHJpY3Rs
eSBhIGRlYnVnLXRpbWUgdGhpbmc/DQo+IA0KPiBzb3JyeSwgSSBkb24ndCBoYXZlIHRoYXQgbGV2
ZWwgb2YgZGV0YWlsLCBidXQgd2UgZG8gaGF2ZSBjdXN0b21lcnMNCj4gdGhhdCB1c2UgdXByb2Jl
cyBpbiBnZW5lcmFsIG9yIHdhbnQgdG8gdXNlIGl0IGFuZCBjb21wbGFpbiBhYm91dA0KPiB0aGUg
c3BlZWQNCj4gDQo+IHRoZXJlIGFyZSBzZXZlcmFsIHRvb2xzIGluIGJjYyBbMV0gdGhhdCB1c2Ug
dXJldHByb2JlcyBpbiBzY3JpcHRzLA0KPiBsaWtlOg0KPiDCoCBtZW1sZWFrLCBzc2xzbmlmZiwg
dHJhY2UsIGJhc2hyZWFkbGluZSwgZ2V0aG9zdGxhdGVuY3ksIGFyZ2Rpc3QsDQo+IMKgIGZ1bmNs
YXRlbmN5DQoNCklzIGl0IHBvc3NpYmxlIHRvIGhhdmUgc2hhZG93IHN0YWNrIG9ubHkgdXNlIHRo
ZSBub24tc3lzY2FsbCBzb2x1dGlvbj8gSXQgc2VlbXMNCml0IGV4cG9zZXMgYSBtb3JlIGxpbWl0
ZWQgY29tcGF0aWJpbGl0eSBpbiB0aGF0IGl0IG9ubHkgYWxsb3dzIHdyaXRpbmcgdGhlDQpzcGVj
aWZpYyB0cmFtcG9saW5lIGFkZHJlc3MuIChJSVJDKSBUaGVuIHNoYWRvdyBzdGFjayB1c2VycyBj
b3VsZCBzdGlsbCB1c2UNCnVyZXRwcm9iZXMsIGJ1dCBqdXN0IG5vdCB0aGUgbmV3IG9wdGltaXpl
ZCBzb2x1dGlvbi4gVGhlcmUgYXJlIGFscmVhZHkNCm9wZXJhdGlvbnMgdGhhdCBhcmUgc2xvd2Vy
IHdpdGggc2hhZG93IHN0YWNrLCBsaWtlIGxvbmdqbXAoKSwgc28gdGhpcyBjb3VsZCBiZQ0Kb2sg
bWF5YmUuDQo=

