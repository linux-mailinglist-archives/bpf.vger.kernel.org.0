Return-Path: <bpf+bounces-29770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 411EC8C6988
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 17:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BD01C21207
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 15:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23DE155A25;
	Wed, 15 May 2024 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CZRgH9cy"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F29862A02;
	Wed, 15 May 2024 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786325; cv=fail; b=oMqympTAhT8+ceTej43LP7zPwtezYoaglTQnIPGJlp/We0lxEewHiLAlOAEqEtFc/1IaLa0Lb5k7GIe36ON18BBAu4SrQ1KmeY0NW0w2sMngyDuF00pImFxi6TbBZTPffYs2naYgqEpTLqOD8hnn8PO77rEWX8xX3UNUEEjzYXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786325; c=relaxed/simple;
	bh=ZJ5THLUC+BIz5SvfN3XwIHxzjmHO28x81XCBNR1bVSM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HLE22dzXoZTC54J/iS/ZcsTNhgoR7p1dFrBObNrBVzijsT1JzV+u7pABPUN995/A03XlBLII4l6l6fwNfpjboebT2svgEyQdvfJ4RbMeYbCKUPL8DxIZIGfH9LjWpXKytIF3GTWFaO9wT7btu8vEw6z5bUjvCP6/5+2HUc29oBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CZRgH9cy; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715786324; x=1747322324;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZJ5THLUC+BIz5SvfN3XwIHxzjmHO28x81XCBNR1bVSM=;
  b=CZRgH9cyBQAbpno/0cuSuA21kNOq7vzp4tNTImx7T4sqTruS4i8AOC6J
   n5aJ87Pb0uKCfGymgbQDzxR7ct9Euuz0VYW5lWqpI3BTky7nCziPdHxVC
   wH3UrFHbhn5bNVvyRuoQYRUfCMDazJxUOXaG4EOkmH5dbm+7AXHaHnnnL
   wW/eGhCSmp81zAqK+r/d0jjYagvkvJvk0wCdDyIrc+/BhE3vjC2STn/RN
   dCr7fod+QGxJ/ECTPXfnwZlIZAT3ZugMm8mRdJ+x6mHxMlBLCgvB5SJ4V
   UTBuQ51Ic0JOoPTWLyCphjL0eIJLOB7YGzSQN4VQr5QFloTVHDNDgsoZm
   w==;
X-CSE-ConnectionGUID: z5EjB+xZTfybfvS1vP25eA==
X-CSE-MsgGUID: m2EGHDQPQ1ub7sqXFZP0rg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="23243985"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="23243985"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 08:18:43 -0700
X-CSE-ConnectionGUID: BwmNn6ZvQq24alG3MHHRuQ==
X-CSE-MsgGUID: 0+GoGj8LSFeFu9jxVALlPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="31185768"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 08:18:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 08:18:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 15 May 2024 08:18:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 08:18:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cU1vQMNHQTXx6irDcZsBLdoVMfEgSKg1mmJKXgPwUyYKLMTXLgPJjrBX3vJoalyl6JgDFoBUeYiADQEji6Nx7MT1rdxBBjsqZbi0nVp5YtARMwoItmPjF87hDlPcS7KQDWKOQ1E82BPvWBn7nD5uW+imizqtjosXXBOFhto91NviNQTITTy++Q9DdGV8l+SjbCXm+IL+DJ86wG0ucruyXKnuzJbBwurY7kLazL/nDk8CFlP+BjQcv378dxdZ/kMYCGSgOFXbVhtjiss6R7JlHlFowzuolHoTC5VVqh/1mdZofsqZJqEtNHTSq2dgKBPiKiEFKYcUBANoqBelL2KZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJ5THLUC+BIz5SvfN3XwIHxzjmHO28x81XCBNR1bVSM=;
 b=iykKlf63QeH1PZ4xfcp9rFBFBss5vE2mVhfdRWEvdJZfNXC/OCg/Fmi22eGgbpjBgfB6Xv2LBQvQQBWso4pbYqhtylXF80T29gFCrvpDTMTqfv372fFufh0SzemsGIQQJL3mGFtLGrmwfzmG937rGbhmWzIW1PLCA2ZmpiBf7NgAVCQXFOrlpj4YdgP5P3ZY/9MNoIQQB8s/T5LRzJlV662DZsHt8CDfZRIS8XnuHqg+LXUD1clRoTzPm4lZCmSQwMU1HqcX68W3Lfv9GDEZCwEdtAICrCTiBVB5vlxuOQfB29EcH3xRCjd2swy3nNKNVrKd9/CA//FofG2L4f0+Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SN7PR11MB6850.namprd11.prod.outlook.com (2603:10b6:806:2a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Wed, 15 May
 2024 15:18:39 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%3]) with mapi id 15.20.7587.028; Wed, 15 May 2024
 15:18:39 +0000
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
Thread-Index: AQHaoGz/NDbwXOtepku5mG5JmKvX1LGMCSqAgAKMVwCAAIRoAIADdFkAgAJm6gCAAHtzAIAARi8AgAHRkQCAAAmlgIAAoJgAgAA29oCAAAvmAA==
Date: Wed, 15 May 2024 15:18:39 +0000
Message-ID: <5ed6178867d36ae1bd133935f066c40daab649d9.camel@intel.com>
References: <a08a955c74682e9dc6eb6d49b91c6968c9b62f75.camel@intel.com>
	 <ZjyJsl_u_FmYHrki@krava>
	 <a8b7be15e6dbb1e8f2acaee7dae21fec7775194c.camel@intel.com>
	 <Zj_enIB_J6pGJ6Nu@krava>
	 <20240513185040.416d62bc4a71e79367c1cd9c@kernel.org>
	 <c56ae75e9cf0878ac46185a14a18f6ff7e8f891a.camel@intel.com>
	 <ZkKE3qT1X_Jirb92@krava>
	 <3e15152888d543d2ee4e5a1d75298c80aa946659.camel@intel.com>
	 <ZkQTgQ3aKU4MAjPu@debug.ba.rivosinc.com> <20240515111919.GA6821@redhat.com>
	 <ZkTIU1QUAJF0f0KK@krava>
In-Reply-To: <ZkTIU1QUAJF0f0KK@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SN7PR11MB6850:EE_
x-ms-office365-filtering-correlation-id: e7e221b9-71a3-40b8-715b-08dc74f24c75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?cEVVTnM1TWk3OGNmTWpmSUlOMTJUUW9MRzBJT0JHdXRzSlFnMTlyZU0yOUQ1?=
 =?utf-8?B?UnBhVUlNejJkT05OUzA0NzFIdTZ2MFE1WndETWdyWkRkK213b2hFSFBwVzZS?=
 =?utf-8?B?M25MZU5YcjM0cVAvNHQvekdXZ1hoeHdsem43VGdCSzFuZFJkQThid0pxSFBU?=
 =?utf-8?B?eGdxWlpsdjdrYnFvSE4ya1JiRCtnWDFLdjdteUlEMlBoUzZxVXlmK1VFNnVC?=
 =?utf-8?B?NUpyYXk3bS84c0lVWXRNeXN6Z3pTaUNtODZ5SVMyazloT3c3V2ZmbzJHMnJ2?=
 =?utf-8?B?VWxMcTFRQVRXVGFJZ3UrbFlySyt0WEl5OU9Db00xUTlEYVV2MzZYWTBlVW10?=
 =?utf-8?B?R2FUcE8yOUR2ckROWldac1I1eWx1cTJQQ0dXZ0JjTXlNUVlyblJXWDJydG54?=
 =?utf-8?B?c2tKMUpTdEpoVVY0Z3dvdDRGbmJUZ3lXdEZMdnRacWd5Yktways4QkJtbEhF?=
 =?utf-8?B?Vm8zRDkxTU1yUi9peWpkZ1hLWG9YWlFtWnhNbFovaDF4Uk9EZldOZERuZDNt?=
 =?utf-8?B?UXpJWkVjUllMTmpZSkJoYmJ4UjJGVHFxNk5MeWFPL0hxUUxnSTkzL3BhT2dE?=
 =?utf-8?B?MnRXbmQ5VlJUcUVuZWVaTXZ2STNoalM2MFU4V3Nsd1NrNERXVjhscjVzak9P?=
 =?utf-8?B?cTc4MXlrS2NwUGkvSEZSRHE1NHpFVDBOdHdCdWxyZGZIOUVBemxxeHEvSjB6?=
 =?utf-8?B?Y2ZWZ3VFNnUxYW1vdVZaYVUwaVJ2NytXVlJJL1FoaFYrQ2h5eDVoMG83SnJO?=
 =?utf-8?B?VzErZTkyb1B3Ukl2SklnRzBTa2NiQ0owdERoelVmV0dua3c0Vm5XYXVmRW84?=
 =?utf-8?B?TEd4anluNVVYM1BjQUdTTzJWb1Z5bi84U2NBYzRCQWNTNGxoRkJGOVNKSklw?=
 =?utf-8?B?S3V3UldKT0t5QWwxdDA3cFZTZWIzMzBJb3hVRzAzRHA1Y1BEYnJVTmx2bGpY?=
 =?utf-8?B?N0FzL1ZSZ0dBZExvUmNmUWFrVGdmWU1idVVZV3BHY2lYa1N4SzFoSklETFNk?=
 =?utf-8?B?REVUUHIyRGQ1S3VOcEpOME8xQ0Jra012OHFxcmtqdkxrZTlWemJySDBqaXdG?=
 =?utf-8?B?QnQ1QkhFVUs2YkxHMTFhY3Z0TnFlZkdDa1dyb205R3Fnak84MkJRZ2h6VWpq?=
 =?utf-8?B?bG82Njl1Nk92MXFYWm5TRVB4MllxOGVsTmtLdVZLQmZNQXNYcy9LYkoxeWk0?=
 =?utf-8?B?b21uNXVEbjRDdUU5ZVpYTXJYTm5wdXhMNVRNclc3SnhXQllqaU14TnIrVkNJ?=
 =?utf-8?B?dGpJbXZsdDBZR2FzOWJNY0g3ZWNRd2FCaGZYR1NFOXdSbm9UNDZkQ2k3akpF?=
 =?utf-8?B?M3JSbmFRQmhRVFZyVDFtc0M4ODJyNThwQ1B5dFB6N01JV2lVdFBnUjlSc1dL?=
 =?utf-8?B?S0pZd3R0TmdLVkc0TzJUWmdaekg4QVBQVDN3eDdWNTA0R2RwdiszOERIang3?=
 =?utf-8?B?TjNGeVJveDVpbGhTWnJ6bVBLVmdRZVdxS0ZtTlFMckRCOEk1ME93L2Fuclpv?=
 =?utf-8?B?dkdKOU1MaG4rbUZZcExCVHkxQXdRVGhyUVREVzZIOEZ5dytoRVFRSnJMU1Q5?=
 =?utf-8?B?K1RMcFJQU3FYV2tRVTh6NWZLL2RMcGRMaURPRkxWTmFvRzkwYWxtalg5Tkc3?=
 =?utf-8?B?TlBsRktBZVp2MUN6VjR4NWdhaERUQVBHL0sxYmRwa1UwclhacnFYOXl2Smhn?=
 =?utf-8?B?ZnZtQ0FKOWd1NGV3bXlhNnVsY2R6ZVlLbXpLOEUvZlc4STZFTVVJbTRJMWUr?=
 =?utf-8?B?VXZQY0ZHcFdCVXlrNEJqcmtOdzhqQWlNSW1GWUkzaXNad29Jakp1eGtmMExv?=
 =?utf-8?B?VzRheWZDUHhlWjZrVmUxUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmdWTy9NVXlINTlNZ2p3NVRIVUo4TjYzOXc0ZWl0aHVkNk1vVmpRaFlJenpa?=
 =?utf-8?B?bDlUb001Ukx2UlQrMko1VzQwVkpJY2IzWjIySG1Oc3JXTStodThVU3cvam02?=
 =?utf-8?B?SUFSMkxPbFdZckFVZDVxUGtzRHU4TW1WTjZ3L3I2ekNiUHRmQUwvMXp2T0Mv?=
 =?utf-8?B?RG1qSFJkUjh6TmlTOUU4NWtYUDRqR3Nua0N6S3l2VklPK1NxWjZoQmVTODZv?=
 =?utf-8?B?MEVNTDluaDhYT2pKOXZmNWF4Tk9lYnBxY1ZyS2pobW1rUDFodkVBdFUvWUtO?=
 =?utf-8?B?WExLbUw3UVU0VnFhaTA2OVZzb1BnbjBiZUQyMmhxdkVKbERpaXZUd0dzQmNs?=
 =?utf-8?B?VFNqcHNGbXUxMjhRZ0tEbTBsWHVSbyt6b3o5UzBYendrUXZYMlBMemlsTllZ?=
 =?utf-8?B?S3owcG5UYW9SQnRXMVVnT2VyaWlHUEVyY0RUa3R2NVlLWXV0c2hJOCtKQ3Fj?=
 =?utf-8?B?ejIyUmJwUFA0SVFybk5VaXVZWEFIQkZGWHNISi9FS3RZbWlxQXpGKy94WWRo?=
 =?utf-8?B?ZlZKNFUzcGdFUGhpY3pVcHc3Q29DWUxEZFpRQ0paRzBBc05pbVlvNkJ6T3lO?=
 =?utf-8?B?OU8wZEplc2xNQ1llaWJKTHIxR29zYnd4YmUyYUJRQTZwTldOOHZENDZadnQ2?=
 =?utf-8?B?VTBvSHh0Y292VkF2cFFCTjl2WXJUT3ZaWi92MW0rbGVEZ1lteVFRSC9ESngv?=
 =?utf-8?B?aitSQmk0T0cvODRFUEY1MnlrYlRXWU1hdGdWQ0l6ZWVXdk5OWDJyR1NUZWdl?=
 =?utf-8?B?YS9pSEVTZHhwUXcyZ0NidUpDeGJtYkZLRDVIa1BiVVhwRVUwTUx2cFF2VUFI?=
 =?utf-8?B?S2UyY3BiVG5MaEhscjFIV0R1NEhsSHQrY0o1ZjN1ZkgraWFwd3VhMDg2bG1o?=
 =?utf-8?B?NlRXVDhENHU5KzBnbUFvK2kxdU85ajZrSStydlJkdll0bVJSQmNRZWpvS2Q5?=
 =?utf-8?B?eXFOOFZqR2JDcjJqeXlaaXJFakhzRFNna2w3OEFwY3dlWlQ5UklxSlltaHB3?=
 =?utf-8?B?N3IzajZsWndxL0ViWlRvUHV3MmZ2SmpWVHY0QlpnemN6SUh2dHhPdmlrRmha?=
 =?utf-8?B?Q1FuWE96QzhOSDVlaDdLWmltKy9rTVVFRDNzK3A4M3oxaWxTT2pYRUJ0cnpJ?=
 =?utf-8?B?bTFPdFk3OUNaYWlrTm5xMHI1STV6NFBzdGM5U1k5V1p4WVErTDhXWGZMR3Ew?=
 =?utf-8?B?TEVPbTdEMzdoWmtsVzJZclM1c3BGUjN6dW5FRThLTXNlUGxMU3B2L1dMOUJj?=
 =?utf-8?B?dzBYc3d6SVVCR1N0aXB0amhmWjE3TDBXZ1FsZVNYV1Rkdk9HZUp6U3JWU2xO?=
 =?utf-8?B?dGJRY1pPRmlFTXd1MWk5VE5yS3hXRFordlV5UWFFTkJBMlJVNFlwc3JvLzVn?=
 =?utf-8?B?MzdqNVluY0tIRGFQdzc4eU5QS014VSs2RVllSCtBbDA0aW13Q0VPbVdTTks4?=
 =?utf-8?B?WHRDeGtJdFpCSzM2enVQazZzRXdhcmFXaHJTYU55Vy9RZjdzeUJpNGpmYXFa?=
 =?utf-8?B?TTZNN2hKMHYyZ2hSeklFTVBmYzVzaUxVdG1iWVBtYWVHYlJtbVF0aEF0Q3B6?=
 =?utf-8?B?czc2SnQ2YWpmTUZmb0xucmtLcld0V1BMN2ZydHJwaVlJbHk0UERRcGM4aU43?=
 =?utf-8?B?SGpiWDZEd3JRM3paSzVPVlppVHhPcGkxYzZ5NVlkTDJqUVduVlNkY1krMnRY?=
 =?utf-8?B?QUNJNWNLV09aNlN0ZGc5d2I2WVk4SktYNlJuMm9MdGtQZXVnT2IwQURmMkZs?=
 =?utf-8?B?bE80RkM3bktLWThxVW1GUVVSQXk3U0gzbDlFOElyKzdIZllEZFZTUGdUUUVa?=
 =?utf-8?B?a3ZwR2p0UlZiMnI2YnVKZHZzSGR0VFZXWlo0RTRhQkRLc29vVjdVT2h4S3c2?=
 =?utf-8?B?SGgwQzhNMXRoUVN5K2dkbVJOLzZJSWlHOVpTQlI0c25LSDVRMENsTGhqUUY2?=
 =?utf-8?B?VU5OT1hBU0daa3EvWElqUlRPQnc5YXFMK3RQcVRjczVGbnpWQUpwS3lWMXVk?=
 =?utf-8?B?WW1KOHhRb3J0bnFRWGpmR3k1RE1DQk16Znp2a1dnRWtxQnVlR1d3RVVySjh3?=
 =?utf-8?B?MWgrMHhaNmdzYlR5VnhORkFoY3cxK29RbTZRZkpsU3E3dGJQV1dwb3lWVkZI?=
 =?utf-8?B?MUNMaWp2cVJvMTllbWJEWDRwQ1ZHeHgvdzRnM3BGR2huajdzUUtrZzhzcW9y?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A175F678022A741931BE7663FC6E800@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e221b9-71a3-40b8-715b-08dc74f24c75
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 15:18:39.3037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aLXeoNTvy5PkWrKsglzrxNkUZTPftfyOk90kwuVHo4fr5RpwCFruVguP33tKQWQH6w6wBq/USeTRqvBcL6yFmHShh/at9+M1U9u4IXIPyYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6850
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA1LTE1IGF0IDA4OjM2IC0wNjAwLCBKaXJpIE9sc2Egd3JvdGU6DQo+ID4g
DQo+ID4gTGV0IG1lIGFzayBhIGNvdXBsZSBvZiByZWFsbHkgc3R1cGlkIHF1ZXN0aW9ucy4gV2hh
dCBpZiB0aGUgc2hhZG93IHN0YWNrDQo+ID4gaXMgInNob3J0ZXIiIHRoYW4gdGhlIG5vcm1hbCBz
dGFjaz8gSSBtZWFuLA0KDQpUaGUgc2hhZG93IHN0YWNrIGNvdWxkIG92ZXJmbG93IGlmIGl0IGlz
IG5vdCBiaWcgZW5vdWdoLiBIb3dldmVyIHNpbmNlIHRoZQ0Kbm9ybWFsIHN0YWNrIGhhcyByZXR1
cm4gYWRkcmVzc2VzIGFuZCBkYXRhLCBhbmQgc2hhZG93IHN0YWNrIGhhcyB0aGUgc21hbGxlcg0K
YW1vdW50IGRhdGEgb2Ygb25seSByZXR1cm4gYWRkcmVzc2VzLCB3ZSBjYW4gbW9zdGx5IGF2b2lk
IHRoaXMgYnkgcGlja2luZyBhDQpsYXJnZSBzaXplIGZvciB0aGUgc2hhZG93IHN0YWNrLg0KDQpG
b3IgdW5kZXJmbG93LCB5b3UgY2FuJ3QgcmV0dXJuIGZyb20gdGhlIHBvaW50IHdoZXJlIHlvdSBl
bmFibGUgc2hhZG93IHN0YWNrLg0KQWxtb3N0IGFsbCB1c2VzIHdpbGwgZW5hYmxlIGl0IHZlcnkg
ZWFybHkuIEdsaWJjIGxvYWRlciBkb2VzIGl0IGJlZm9yZSBtYWluIGlzDQpyZWFjaGVkLCBmb3Ig
ZXhhbXBsZS4gVGhlIHNoYWRvdyBzdGFjayBzZWxmdGVzdCBpcyBub3QgYSB0eXBpY2FsIHVzYWdl
IGluIHRoaXMNCnJlc3BlY3QuDQo=

