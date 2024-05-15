Return-Path: <bpf+bounces-29769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB008C697D
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 17:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79A81F228CC
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 15:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29771155759;
	Wed, 15 May 2024 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwVKeOrf"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF0E62A02;
	Wed, 15 May 2024 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786075; cv=fail; b=YML/kGK66g4/fsdG4MMuZNGYsnxLnxN2BoQrSdKqp5VkaZsfstK3yMPkfjkVdiAyk/x/QiZIPJEQ4937ic9jko3WjXZA0gsNdkH0YoKpTXK03j6XkOGQtrZ7ijAvF5aDtgCHijALQquNMkWK2RrCGwzE4zQZmeyE+yk6F6KOaiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786075; c=relaxed/simple;
	bh=2NNRsIgbGLyeaskS5/KWMY1a1tTTFNrD+yhs2v17qgw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kJoURMrEs94u/hkFCUjyGym3yiQYPleDw1oWc6Qn+S7UOZe/LVLdJAirctfQUQtCa0JjRS4spAKJZ6Ntu9H20vua336lPbxuTJnc8sPw/LPx6t+wteuIfP9YVRhpjLqr1aeQZmc48QUprewaNPIEnLHqH9JbUJKGQ9EjDgC2cIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwVKeOrf; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715786074; x=1747322074;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2NNRsIgbGLyeaskS5/KWMY1a1tTTFNrD+yhs2v17qgw=;
  b=gwVKeOrfGkyljY8G1DUV8Qt+WUKjzEwuUovb1DQ24ugW2XbKFTCcbYs9
   rdiUtNV1U2TCbyHaE4PbU7tnAj6LBh7nXMjelGX4EyXr1WUAHCfo5WRb/
   C0nrQi0Ki9tdUAT/DOVM6W4zPmAYMbCiWXS//yF/QXaN1/F66hRsYfKVg
   8Hcijp8iQHTDiCBjuooOrl3/szy/vkKDSjQMTnjjHjzV7ijSh0P1cN3Rn
   grfqCc2lj27d4GZfoSNX5VtnW2B3gEH7KYLlFLpl+kT19WpddCWFtEK0r
   oHUmlgUeU9infanwCav/AFD2iNJwj5BQcLhQm1CiV3QZT+5gFws6Ot6r9
   A==;
X-CSE-ConnectionGUID: +mEVAxzOTRaTM7d262RmVA==
X-CSE-MsgGUID: FNQv9OPZRFGAn74WYOtjPA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15666498"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="15666498"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 08:14:33 -0700
X-CSE-ConnectionGUID: D+BiUWQeTji/hFB/3WFCnQ==
X-CSE-MsgGUID: uAmtV3mfRVeGqRiTvKjgZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="31116167"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 08:14:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 08:14:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 15 May 2024 08:14:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 08:14:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhCwdVfb8aedLBlZetCspHIr5EfpIRbyT8edAyjnifVXgexPBQ6kzxt9XMI343sJhfIpKEpJZxnXuAmMG51RjGOXmQtwivuWzar+AVnHEyiZZmEULLZ9t/Sl3srLTuHt8lv9G8gt1OGvjZoI5LmAnsQYVdNWaZvDaGvRJ2x40VtgUjrVxWUU3yxH8k1ZdSdoLSkKkUcG7tSPwZvLAAPkleTRBg0VxC6Wwdw55XjQP0CnWc+w5x1/Zyi6w83cNf35Korrn7zJQOAiaZlF7xmP0Aiyu750iZohW7miupohN4f4lBztOuIMbHBKhsiNhAE3AbuvXsmOC4SgYhCBF3dnmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NNRsIgbGLyeaskS5/KWMY1a1tTTFNrD+yhs2v17qgw=;
 b=eYwZum4cVTuZX8Vg9D1aPGXjYqaAmYBeAkRYGjPS6Lxvq3gnKyshCvOGh2y0OHNPs3cXGALLTCFd7ce1hwrxaq2tFXjj8fzgLCTABqgO33RDj9o9+aIb/WTh1bfoBC7h1UPAwXEZICARFcklWwFD8tuLOPryoXx/F1bDtxeA7C8U2s5lonyF5fUbHgx2ErmFqPt+oV0ssU50psTVh5i0LJ1U7NZmKzdJG2dJbFR/gixbVu2cubl0QmwVXfEloqF1RKV1w3blDJNO7XebkjIzZyGJL4Nb2TU1VaN9W/h0U2dGDScASznxShc3pDnzFRdSJJ0yOBkQretqlBmOIBIyqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW3PR11MB4665.namprd11.prod.outlook.com (2603:10b6:303:5d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 15:14:01 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%3]) with mapi id 15.20.7587.028; Wed, 15 May 2024
 15:13:59 +0000
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
Thread-Index: AQHaoGz/NDbwXOtepku5mG5JmKvX1LGMCSqAgAKMVwCAAIRoAIADdFkAgAJm6gCAAHtzAIAARi8AgAKATICAAD0QAA==
Date: Wed, 15 May 2024 15:13:59 +0000
Message-ID: <0fa9634e9ac0d30d513eefe6099f5d8d354d93c1.camel@intel.com>
References: <20240507105321.71524-1-jolsa@kernel.org>
	 <20240507105321.71524-7-jolsa@kernel.org>
	 <a08a955c74682e9dc6eb6d49b91c6968c9b62f75.camel@intel.com>
	 <ZjyJsl_u_FmYHrki@krava>
	 <a8b7be15e6dbb1e8f2acaee7dae21fec7775194c.camel@intel.com>
	 <Zj_enIB_J6pGJ6Nu@krava>
	 <20240513185040.416d62bc4a71e79367c1cd9c@kernel.org>
	 <c56ae75e9cf0878ac46185a14a18f6ff7e8f891a.camel@intel.com>
	 <ZkKE3qT1X_Jirb92@krava> <20240515113525.GB6821@redhat.com>
In-Reply-To: <20240515113525.GB6821@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW3PR11MB4665:EE_
x-ms-office365-filtering-correlation-id: bf4e2646-08fc-4b83-2415-08dc74f1a59c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZXF3SitWbjl0MHJKQzBISStPSFU0RkMrd3hnS3FZeDc2MVVTVDNkQis2YVJJ?=
 =?utf-8?B?NStqUHlpQUtCOEVkaTZBVXozNjNZSnhoakRUUVNaeklhckw2bkpLcUFQaVhN?=
 =?utf-8?B?d0YwUDk1cTJ0L2RHMFFsU2pBYnV5cDJKSzRYL0dDYlYxa3YvdG9OR0lTVWRv?=
 =?utf-8?B?OGkzMUFwb2Z3MFZMRnN4M3ZmV05FS3RYajFQeHRLcU4rWWovaFYwRGw4NXZD?=
 =?utf-8?B?cm5IZHNJUmltTytJdmZzeWJjakQyVC9HaGx5NzQveVd0U2oxNjg3MEhxR3Nx?=
 =?utf-8?B?NDM0bzZhczJJM2llYWZWNVIwR2lHQWxjWEd4SkdHN2o4bm5CRTl5VkJlTldv?=
 =?utf-8?B?c0xGSlZDazU5UjR1WVFXWmtnSWY0MXRvQlZhM3QzeU1ZclJpdGg2K3JpL1Jp?=
 =?utf-8?B?Sk5tMnZ1dVUwVjc0d3FvaDNTaEJ2LzhRUlpnazUyUzYxV2tUR3dDRFduTWpj?=
 =?utf-8?B?OFo5bWFXVmZYYWlGRzVvZXdkdWZMWnp0ZytzYzVzR1poV2VPQTZYd1o5aDFm?=
 =?utf-8?B?cjJBczR4QUZjUU5pRjBuTzdTYVJRZWhOWEJ3RUVJYk5ZSVgxK0syNXZlOTRI?=
 =?utf-8?B?SGVob3ZqejREQlJubTNHMFdzUTBKK3F6Q1BReXlSZ2VONEJXQkFaVkRIbUdy?=
 =?utf-8?B?Qk9YY0t3UWhsM25WZUJMTWdMUERjcFRHaUovU3pwTWZKSEVDdmUvZFdTeUpU?=
 =?utf-8?B?MnZRd28wV0ZwQ0RlNit2eDcyZ0htQlFBWWg5SjVCa2FhQnJzNkNvSEc1c0c2?=
 =?utf-8?B?UTE5cmNGa0R1bmlLWXMxQmRvZ01XVEE5ZWwvd3JBNnRFb0pKNkRxVkRzcGFN?=
 =?utf-8?B?eVNjTStUQXIzazlBdVZsbEpRZVMxTGhSUDdEM0Y1a01NTUdUalU4T3JBWElh?=
 =?utf-8?B?MDdoVzFjYnlnNTI2ZFYvOXUyTE5IaTh1THVJUURqSkMwRG5ZMmxLYUF5MzBx?=
 =?utf-8?B?U2JoejZFUGlQdTAxOUtuSGt3aGNWb0pCUmhQS2ZlRngyQjd2cFEwYVVldEYy?=
 =?utf-8?B?bFBXK21aWHJ3RjR5ekt2MGR2bGMxeitIckRQR3J1bzU1czlRd3ZCaXExdU1S?=
 =?utf-8?B?WVVwUUNxL3p3QTF0YUxlZzlRY0g2L0tDU2Nvc3FrS1oxdSsyanVSN2VXUlkr?=
 =?utf-8?B?N1kvOGV1eThYTWFob3JiMk5zR3kzK1NNaWY3NTZhd0FvYTVHSjM2ZHUrL3dN?=
 =?utf-8?B?RnRYMDd3K0ZINmt0SXFBZ1MrcDB3S2ZpNElNK3h4MUhlRUowVXlYNCthaHV2?=
 =?utf-8?B?Qi9NbUU3aERIekRVYy9rS2dxRlk3TngxUkZPSXZVR3RsQkFUbFJjK1ZpWXhN?=
 =?utf-8?B?MEY1NHV2SjBLVm1UMDgwQTRXT0FlSFVJUFNnOEdSektkNlZwTGg1R0xPTkdE?=
 =?utf-8?B?SzM3Q2ZRYXRyZFNVdHdVS2VaNU9xMEpCMitXNGNnbkR5N05aamw2WGkxR0xI?=
 =?utf-8?B?bFFBMWI2amNEaE5ZUWR6V1AvNVFrQlcrZ3RvU0d2b1hFOHprNkVYMUNjbDVF?=
 =?utf-8?B?QzNaOVVZTzVzK1hNRHVNdTZBTTNBZis5K0syaVRWWDVjSTJHa01pYmtxTjcx?=
 =?utf-8?B?Z2RpNGIvTkxsbzNXS3lOZkcyUGFORjNHVzltUXQyV2pkWWQzWVozNzdycFpP?=
 =?utf-8?B?VzgwRzIrVnZ4TkdpRExTblhuQzhsRlZIYmRpRmM1M0RZZXY2OVJ2TGphWDVM?=
 =?utf-8?B?a0VyenNwdUk1WkN6VmIrWHdvcVVUMDVRVUY1MUx3N2FRUHR4cllTRnFsYytQ?=
 =?utf-8?B?T2l6N0xBUVlsSkVJd3F3bE40eWcrTkFYQkhyc29Fb3FtRDNLbVdVUEYveC9m?=
 =?utf-8?B?UmdTZFJmREJSTURxT0sxQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWpkUTVOYmF5VGErc21KUVFwUlNCMk1KZXZaZjFEcXJtbmEzcTFpMC9DSThy?=
 =?utf-8?B?OWpKOUhTSVBwZ3dsdll3Yll2Z0JXb3RqcFBZbmFHOTgrZk9uTXZ6WWFIdW9v?=
 =?utf-8?B?bmU2bnIyRkZ6Y29SR2M1NE1teHNBbndrYkFWNFR0WnROUS9GTkJyaW9VS1N6?=
 =?utf-8?B?WUdyTmlDT3AxVnNDRTVKOW1IRXZZYVpGZlo0cGRwOGd0NXVkMjFMdHo4SFBR?=
 =?utf-8?B?dVh5TDV0NitHWUZRSCtQTXA1WE1wcFI5ZVRLNVgyUGFZQVhyYlpKbFhpWFZn?=
 =?utf-8?B?MjMrZDh2dFN5dnI2cW1va2ZqbkJFSmZkZnVqbjRtbFBjelo3VzlUeGtESnEz?=
 =?utf-8?B?VjFVMFlYY3Y0TkMyTDFRWTVaNjB6Y3Q4Y3Q3NHBpaDIzalVtSmluajZDaG02?=
 =?utf-8?B?QUpDZWdDME5pZ3RwcGUvamlJQmU5ZCthdldZTVdRYjNXaXBFMGdaWUttT1dB?=
 =?utf-8?B?SVNMMDY4MnB0bkZVUUcrRUNOUUF1bHBHQ3pORkN6T1puMG5Sa3UwQ1IvSHpC?=
 =?utf-8?B?b08vVTFsd3EzY08ycTBpdEtZZHJuMmxSRW42Vnc2RXhGdUxSR1VLQnY5WHZC?=
 =?utf-8?B?cjdxblFxVURMeUNUL3p1V1QrU0lzc2M3ZFN1WXJNc2lrdng3Z051ejFUdkJ1?=
 =?utf-8?B?blIrU3NONW9GWGNBYm96aGhibVNLTUQySDVYMUhMYUd3T1QrbU5DOGpnRncz?=
 =?utf-8?B?Rk5ld1BDbHA1bEFWT1R6Vm1Qd09Belh0aitrTkpnck5PYldVMVgzSGt4VW1r?=
 =?utf-8?B?KzBQWEczQzlwUmZXQS9leHk0Yy9xZEc1QVpIekFmd1ZlRFZER3hpa0xXZmVa?=
 =?utf-8?B?allnQTFsT0twelpFOUc1eTVhMmlrSFBLVUFEdkJRQXA3bEJ5bFhOL2FLeUs5?=
 =?utf-8?B?VzBCZFJIMC9USFVrQ2VRNXB6d2Z4aW82Y3BPdHYyQnZJWWtoVnY0U3YyQW1o?=
 =?utf-8?B?SjZxczZxNGM5Z1FWOXljZlBjUVNZc2RSR3FMOHlMNWJlVzU1dnRpRi9Vb0xm?=
 =?utf-8?B?VGRacGU0bWV3ZzY4ekRjejByVi92MUMybFdULzRkUllCRlZadWVjVW14ZW82?=
 =?utf-8?B?cEdIdmMrODRXenFVQm44a3VjLzArS2tSOHVHRVErOGhMQnVPNzBCbnRTRGNU?=
 =?utf-8?B?WEtNTkE1UytVUlZzQ24zd2FzUkliTnpRL0hReEVBL21Tcnh2VURsNE9mQ0N1?=
 =?utf-8?B?VFY4TXlKaE1ORjJWeHluK3B1U1VJUDR4V2hyMXBnN3dUdGxLaTZDaHM1NlVZ?=
 =?utf-8?B?ZDZiUjArOE1aVEZEcktSZ01lbkpzZU5JSnIyU0lwdHVKeWN6L0QrTmlQcmFH?=
 =?utf-8?B?VUpRTy9CRXBFL0ZlMXhuaHZmYzR1cXFlUUw0SkRhV0IxOVB1ZlVNUkgzK1Vi?=
 =?utf-8?B?dHJIaGltMHZzV3pWUXdSVVhENWM4UG5mZXpscFNDcUptZVRQelJxOExvSjJj?=
 =?utf-8?B?Qzc2MHgyNW1FcmU4S2JtRGpjUjN2Z1M0YkZsYVVkelBDdlZpL05JMTBVVTFs?=
 =?utf-8?B?MUV5SW5pWlo3SHhPZ29MSVozOHpGMnBhTEd1VldZUjlBYkJ6dzNON0t3L0lv?=
 =?utf-8?B?dG5iWVF5SVovMVZOVTNhYTNhWW1CRVRFeFVtdjdrVndleUoyNjJLd0w4TUZo?=
 =?utf-8?B?ZDFIT3YrK3Q0ZlNsRU9CSjNDSUk1cllMMlhodE9KaTZ1RzEzSVhjUCszNUR5?=
 =?utf-8?B?U0J6Q05rbEJrZjc2WEpGN0FmUWN4am1ubFpMNDZMQTFMTFdmQTlDU1VhUWJN?=
 =?utf-8?B?SWJERlI4dGFyaW1MV1d3bk1iOGJsTEd0OUV5RFhDOW1VdDc0Y1hxY2Y1MExy?=
 =?utf-8?B?VnZxYjZwand2OUQxczF3bzh0Q3FhNzBJaU9kWW15UDB2VDJuNUc5b05tT2Nt?=
 =?utf-8?B?aVo1NHBDcWE1V3BpMW15V1REcndjMTBSanNoL1ljc2d2OVpHSFVXcWo4b3E2?=
 =?utf-8?B?REhCM05OaHNsM21QblNZMGZqcUIvajlpOU9UanJFUkZzNVBKeGpBaHBhTFNu?=
 =?utf-8?B?Y3gyWjNySURsR1NjQTN2QjhQQURLOGxuMzFkamhEelR3WlhabTlVREEwMitK?=
 =?utf-8?B?R1p2VkVsWjJJYXlKYkFGejVQem5XTldWeFNsWlJ1VjBLWnZOa2VBVUdSKyti?=
 =?utf-8?B?VGVhSEVreWVDNjZQTVM2RHRBZzB6Zy9EVHZoU2kyUzduS0F4VU45ZUF4L0M1?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3752079A8F023144B12E26D180002270@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4e2646-08fc-4b83-2415-08dc74f1a59c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 15:13:59.3799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 55N13vXhDMkVb2AaxbHeaP3YGocEerdK+q1YMTIWlF21oNbYMn+qvoSj4IO1FPQBkkkca5rn9O7Zs9vtL7kNCZthfelHeaTtKz+e2viaCq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4665
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA1LTE1IGF0IDEzOjM1ICswMjAwLCBPbGVnIE5lc3Rlcm92IHdyb3RlOg0K
PiBMZXQgbWUgcmVwZWF0IEkga25vdyBub3RoaW5nIGFib3V0IHNoYWRvdyBzdGFja3MsIG9ubHkg
dHJpZWQgdG8NCj4gcmVhZCBEb2N1bWVudGF0aW9uL2FyY2gveDg2L3Noc3RrLnJzdCBmZXcgbWlu
dXRlcyBhZ28gOykNCj4gDQo+IE9uIDA1LzEzLCBKaXJpIE9sc2Egd3JvdGU6DQo+ID4gDQo+ID4g
MSkgY3VycmVudCB1cmV0cHJvYmUgd2hpY2ggYXJlIG5vdCB3b3JraW5nIGF0IHRoZSBtb21lbnQg
YW5kIHdlIGNoYW5nZQ0KPiA+IMKgwqDCoCB0aGUgdG9wIHZhbHVlIG9mIHNoYWRvdyBzdGFjayB3
aXRoIHNoc3RrX3B1c2hfZnJhbWUNCj4gPiAyKSBvcHRpbWl6ZWQgdXJldHByb2JlIHdoaWNoIG5l
ZWRzIHRvIHB1c2ggbmV3IGZyYW1lIG9uIHNoYWRvdyBzdGFjaw0KPiA+IMKgwqDCoCB3aXRoIHNo
c3RrX3VwZGF0ZV9sYXN0X2ZyYW1lDQo+ID4gDQo+ID4gSSB0aGluayB3ZSBzaG91bGQgZG8gMSkg
YW5kIGhhdmUgY3VycmVudCB1cmV0cHJvYmUgd29ya2luZyB3aXRoIHNoYWRvdw0KPiA+IHN0YWNr
LCB3aGljaCBpcyBicm9rZW4gYXQgdGhlIG1vbWVudA0KPiANCj4gQWdyZWVkLA0KPiANCj4gPiBJ
J20gb2sgd2l0aCBub3QgdXNpbmcgb3B0aW1pemVkIHVyZXRwcm9iZSB3aGVuIHNoYWRvdyBzdGFj
ayBpcyBkZXRlY3RlZA0KPiA+IGFzIGVuYWJsZWQgYW5kIHdlIGdvIHdpdGggY3VycmVudCB1cmV0
cHJvYmUgaW4gdGhhdCBjYXNlDQo+IA0KPiBCdXQgaG93IGNhbiB3ZSBkZXRlY3QgaXQ/IEFnYWlu
LCBzdXBwb3NlIHVzZXJzcGFjZSBkb2VzDQoNCnRoZSByZHNzcCBpbnN0cnVjdGlvbiByZXR1cm5z
IHRoZSB2YWx1ZSBvZiB0aGUgc2hhZG93IHN0YWNrIHBvaW50ZXIuIE9uIG5vbi0NCnNoYWRvdyBz
dGFjayBpdCBpcyBhIG5vcC4gU28geW91IGNvdWxkIGNoZWNrIGlmIHRoZSBTU1AgaXMgbm9uLXpl
cm8gdG8gZmluZCBpZg0Kc2hhZG93IHN0YWNrIGlzIGVuYWJsZWQuIFRoaXMgd291bGQgY2F0Y2gg
bW9zdCBjYXNlcywgYnV0IEkgZ3Vlc3MgdGhlcmUgaXMgdGhlDQpwb3NzaWJpbGl0eSBvZiBpdCBn
ZXR0aW5nIGVuYWJsZWQgaW4gYSBzaWduYWwgdGhhdCBoaXQgYmV0d2VlbiBjaGVja2luZyBhbmQg
dGhlDQpyZXN0IG9mIG9wZXJhdGlvbi4gSXMgdGhpcyB1cmV0cHJvYmUgc3R1ZmYgc2lnbmFsIHNh
ZmUgaW4gZ2VuZXJhbD8NCg==

