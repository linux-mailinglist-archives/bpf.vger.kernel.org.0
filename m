Return-Path: <bpf+bounces-28546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 182C48BB4F1
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 22:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7211C23218
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 20:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B6A482EE;
	Fri,  3 May 2024 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iTEQDZkZ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B6923775;
	Fri,  3 May 2024 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714768530; cv=fail; b=HDvSOiuHwYmYGMCv/4UzD73npxv6/GDUZn8Vq3tQcPuqoVXcaZgQ80ET6GnffyHJU9kg/ZYyOWuwn5Fu3klRmbOxw81kJQTOWWBdDA6DeNiuWJX8hAwukAQgLefXklrZsJvS2kP0Vmmn79rVYJs0xBJO+4GogGBC7idDx3fP9sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714768530; c=relaxed/simple;
	bh=q8KhyfWyz8yT5rZMkpGSQrc3r5FxMUXew5jp/zjtSek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RSzVEKl0rEVKCOzFnwEly1XTxgHTL6FK/x3KFhLMEsBNIT5yHYZQT0QLXZa/znvqoEGowjtKiWceXSLoqarRXvqgd1aZ7cyG6RuXDvkb9ugWtvXenC6+XedUuXYKTqlOzy2IWop1Hka05iM70qCoCfjS//zQGFRS3J9MvlzhwCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iTEQDZkZ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714768528; x=1746304528;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q8KhyfWyz8yT5rZMkpGSQrc3r5FxMUXew5jp/zjtSek=;
  b=iTEQDZkZ/pBxGJPaaHj5AUu6sU912sCME6MH848OFdvdky3vLK4wFMQO
   Wcz8hkJjzdaqb8372G8Bj2Fc/bnDEOz9VUq5jURFp0jPyYmodLyTlFkQL
   Qf4vEfdD4y7hg52R8ZrbjI+fUjvYQp6Qq11Hn6FtRc1x3cP8hrsMwHPDf
   oe1yRsEj5NXTi0DGQSDTSmCXqcqLSYAPYmhEJLK0zkghV+CzGWuVxma5h
   xF1Icy4tGseIJofgDrFGKypynSsrRc1YT1A61KP6vbS09Fqh1hh7lUyhw
   3r4B6SnAQz11XoxHz5hmeBUC1RcSOHXzwjWwXuN1TJ3Om+ptzIKjrpm76
   Q==;
X-CSE-ConnectionGUID: +hZrOb9nTUeoYS4lUrvdxg==
X-CSE-MsgGUID: w3LHI89VR/qmCIsrDut+vg==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="21144148"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="21144148"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 13:35:27 -0700
X-CSE-ConnectionGUID: zogSPiF5QleVjqia1RkfbA==
X-CSE-MsgGUID: lvafRQcfQ9unt5xjcmp/xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27960748"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 13:35:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 13:35:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 13:35:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 13:35:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1podxLkWYDlEaHkYsy8Xl+cqwhSDMaAVKFvBWJqtbymm5I29GO/jfY4b0Wck3uc2j1QVaPPgk5gSQD5OH0j2Dcu+wfN8eDhjGvAK6xa+w/+m7+Sjn10iuImMtMTMua5vMCmkgtPamLkpfc3mR3eJAsckZyClo44ypx7EKaeEOeGXCmO7mqwwpiR42LTYL8rzxuQaqCv3Ycb0Ek0nKbmI6TugSdFVPq8qAN/iq/P+rOLsTfC7gtWTChlurvsvOI3BNF2QM3/x2xL7PguZ03B/zWkfP4qSRssn1dMXaqTNyDtSbQL+ixkw2fM7li1Zhp+x6AQMRoI+52yGdx3zmckDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8KhyfWyz8yT5rZMkpGSQrc3r5FxMUXew5jp/zjtSek=;
 b=l8TvDstgC7LkmHf9derQPRu/NZ3yXdlKndL3M7cRE/StpcxFO5cB9wOTBB6rnFS+hyQDTZqHicwH4CBHzYGYzcySSkTiOfZiyvk7P5i6WilSv5ZZWajoaLm+lHGx1KrmN20oO2fworI7eLYc/52XaYmiyjqiuTTUakKBdaVTCzOgfl5Dkm6bsIwkZXgAbPX6sqI6j94P7DMSd7nSL0mhiFCAxkYa9HeohNvXnAFNwYequxGo74qp/+If6JGTZRYOsbzeBt/9nHY0+zPWKnoz9PHJNQDNsFKzEQJe/DHVU/VIZysf6fR4kuwCwJHG/BURw8kxl+Ac2AxDSikbaGwzCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB8197.namprd11.prod.outlook.com (2603:10b6:208:446::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 20:35:24 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%3]) with mapi id 15.20.7519.031; Fri, 3 May 2024
 20:35:24 +0000
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
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-man@vger.kernel.org"
	<linux-man@vger.kernel.org>, "oleg@redhat.com" <oleg@redhat.com>,
	"yhs@fb.com" <yhs@fb.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCHv4 bpf-next 2/7] uprobe: Add uretprobe syscall to speed up
 return probe
Thread-Topic: [PATCHv4 bpf-next 2/7] uprobe: Add uretprobe syscall to speed up
 return probe
Thread-Index: AQHanU4GpcFda+6iuUm0ZMN/pIdOBLGFejyAgAAvKwCAADlUgIAABY4AgAALAYCAAATygA==
Date: Fri, 3 May 2024 20:35:24 +0000
Message-ID: <d2e0e53581e26358ee0b3d188a07795878938d2f.camel@intel.com>
References: <20240502122313.1579719-1-jolsa@kernel.org>
	 <20240502122313.1579719-3-jolsa@kernel.org>
	 <20240503113453.GK40213@noisy.programming.kicks-ass.net>
	 <ZjTg2cunShA6VbpY@krava>
	 <725e2000dc56d55da4097cface4109c17fe5ad1a.camel@intel.com>
	 <ZjU4ganRF1Cbiug6@krava>
	 <6c143c648e2eff6c4d4b5e4700d1a8fbcc0f8cbc.camel@intel.com>
	 <ZjVGZeY-_ySqgfER@krava>
In-Reply-To: <ZjVGZeY-_ySqgfER@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB8197:EE_
x-ms-office365-filtering-correlation-id: 1b7ea6da-2428-48a2-3f25-08dc6bb08f81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZGNzT2lEY1lYTHQ0SUhuTmE4a3NXUTFjdWN5VzhPczdzZUs0YWk1WWpsK1BL?=
 =?utf-8?B?dS9uU0pBczZNcnFOUXJ1UXRudS9iTXpzcVM1TjRZdWdCNklPL1hMS3RvUXp5?=
 =?utf-8?B?SnVVd0lFRXl4V0JSMnU4dzRTSEdRcGtSOFBEZkFZWktRTnF5UmVrYjJva0pI?=
 =?utf-8?B?bXBMS1d0QlNaVmNPRWtzQ2JHelZKUFcyZzA1RkdDcHVGc1g3ZHhINlRwcEp0?=
 =?utf-8?B?Y2RSUTVYNk4wZXI5ZTdnaUM3MG1VN0k1Tkp0M21uNTlISUFIZ28zTWpTMi9h?=
 =?utf-8?B?OVN5WDBveEN4QWllSlJxU281WHJTY3J5RklBZjdESzhoWVRGMm5QT3NXd0pV?=
 =?utf-8?B?NUlSR1hlVy92OHo4aEM2NlJHV3ZHb1pFcnJRaDJxZGdyWkNwNUw1d3o3Y05C?=
 =?utf-8?B?WlpUKzVUTWFTRnVSMTdhcEM3MWxjMUNDM0kyaFRTcmh3bnFuazFmVXRvVVhn?=
 =?utf-8?B?bHNXVktNUHBGaGVFb3hrelVFRTJiVDBoSlU3cytsQzdhM1FVZmk4NHFLN3Fn?=
 =?utf-8?B?YTZPU0h3Y1lnWVh5dmNvQ3ZmOTZDQW55bjFnZ0Vxb1MycVhSQzJqWWtRNmxJ?=
 =?utf-8?B?aU43NDJ3SlEyUmlCNWtlQ2pjUmhiU25RbVo1TmdFbHdsRzAyeG56NmY0Z01L?=
 =?utf-8?B?TXVMckEzZmtTZEdnK3NNcnZNTHFHVmVhaDdKdDhDWU5BZ0ZMRW5RcGU2UVBa?=
 =?utf-8?B?bFh2c082M1QxR1pZUXBUWVlQWjVGaldsdzh3UkdOWTdNMWk3UWIzaWtVMlhZ?=
 =?utf-8?B?VGZDZ1hMSityZ21YSG9wNGRVazI0QVk5cVByNEw5dklUcmpSbFd4SGtwOUVX?=
 =?utf-8?B?cm9wOE1QSWU5cTlIZnNLL3V3OUVheFZSRmd5bjlvWWJTa3hiT1pOY2p1dUY4?=
 =?utf-8?B?NnVRU1lWU3JzeXhIelJvUnRmbjBDaSsxRFN2MUI3K1dCRTVoQU9oelU2TzJl?=
 =?utf-8?B?bERqbWdtU1A3QUZJb0xsMEovU2U4N2ZudklweXk4d053NEd5NDF2N1VPOVE2?=
 =?utf-8?B?V25Rd0VDN3k2Qm9KWnRQdmVoQUE4N2lXaFh2TGdEMHdlOUVhT3c3cmZ2R2Ir?=
 =?utf-8?B?ZEpMdXFOeEV6Ri9QWXVEaUEwMnRJdFpBWWsyWlVieThLOTQ1QmdqdjlKUFJG?=
 =?utf-8?B?Wi9zczZlZkFEY1N6UmgxVk1Makxoa2tpTGw5TThlZ1RxV0FqaXlLc0tSaDFF?=
 =?utf-8?B?Ky9FUlFyQ2UwRTBwb0I1clFCYWVQYVFXQ2hHeXN6NE5lYlJ5U1h0VlppSlZr?=
 =?utf-8?B?dU02S1NDUHljMjUyMVE5aVIvTHA4MFJ1YzJ6VkhsaC8xWWNsVFhQMWZhQTlS?=
 =?utf-8?B?ZHZYMGkvVFU2bmNQckFRSkVxdzJJTlpES1NhTFQ4UThmSCt5d0VYN0JzZzlK?=
 =?utf-8?B?NTFITXdBZFlPTERRSGhTT2JHWDlGOHEvL3RTM0N3aXpQallXTDJCUG5COHFJ?=
 =?utf-8?B?c3ZSZzlCc1pHcDRSQjVkM2pQTnl4NEtTWHc5ZU1aNWl0a2RvTitleVpsdkM5?=
 =?utf-8?B?U0ZMSS8zUWVXbnBKdlV4ak5vSVJITEZ3TWZoOGxIaGxNbi9NQlUvNGZqYjdy?=
 =?utf-8?B?WElRK3NpMFJ4c1JhOFNZMXo0ZlFZbno5Q0c5YkZLdEVFdUIwZHJzT0QrVERp?=
 =?utf-8?B?MUlZTFZoWXpHM0FFUUM0N2M2eDBrSnlnVVNCYmJtakVteHNlNVQ3VnBHdmpi?=
 =?utf-8?B?VUF0bFlESXljY1dydldHS0RNYSt5UHYzajk5QU9IeTNBRTcxTW95UHVIdnJj?=
 =?utf-8?B?OXhibUllcHR4Zi9hOTlEV0NIdTRFaDh2Szh2eFYvZlhFREwvZWpMdDRUWDlK?=
 =?utf-8?B?aUNmMHE0amdhQ0dBN0JMUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmM3cFhZR1c1ckdicnB4elErQ0hMOXpjdUxRZ1AxQ2VnaERGUmt1NGl5d2JQ?=
 =?utf-8?B?M2lTRXZQMHoyb3I3eERGQ2ZOSEQvL2JXSGR0WmJvczZ4SERMemw2WVU4cCti?=
 =?utf-8?B?ek50aFppSGswRHJBaHpDVTZHZTVCRUE4eGVaZU1palZmRlA4RzFtalZaK1dr?=
 =?utf-8?B?TThMTHozM2JBZURxdXJDakxjeTF4a0c0Ymg3V1crRi9uanViWFFZdjByL2ZL?=
 =?utf-8?B?SmZZQ2RLYWZrTmExVDBiNjdONnVIUDFkUUZBVTB1V0VucVowOUp2QTluUVB5?=
 =?utf-8?B?ZDZtSHM2b2dRcmUrNUg4NlBtY2J0cUFGaUVVdFY4Vm82Ti92Yy9ycWhWclow?=
 =?utf-8?B?WUdyMEM3VVFpYm03OEtMTklCSUFVRytzSVR3cXA2alhqUzU2TmIrVVNOd3hj?=
 =?utf-8?B?SDVaV1ZSS2FLMGh3Z3JGSndRRzZCNE5qc1pVSzh5NU9VZ3BiMUNxVTF0cjk5?=
 =?utf-8?B?YmZIM0F6TE1FS3ZuU2VqTzFCSS9iN2E0NHBiWm5BY1hQZE9vQy9wMDE5Q2c1?=
 =?utf-8?B?QjFGck9ZTW9qcGZnelFXdVRzNXVHVnBzdCsrK1RrR1ZQaFQzZkdpdXJ3aGlT?=
 =?utf-8?B?Zm5FVFNKZVpubHlzUzYzRDJLcThZS0l6cTQvWTI4c0lLRUZZVWUzQXBKc2RK?=
 =?utf-8?B?SDNKK0VjN2htZXZZdW4vS2UwbEZMc0FWaFJCd3FOU1BrV0NZT3oxWC9SckR0?=
 =?utf-8?B?UTdmRDZYWHZVTDE2T3dzYnVMRGRoaDBZYU5iMU1Wc0s1akRPeFdjdlF4MWx5?=
 =?utf-8?B?QS9pcFllTWRtdVhkNXRCNFhidytibk80OC9YVUZxdDlXZ2dyRGFva1g5NVhY?=
 =?utf-8?B?Q000THgrdGt3MlFueUFCeGJZSHNVeFVWSlEyTjJEVGZxWnRMTC9Nekt1Ky9p?=
 =?utf-8?B?YTAyQ1dTY1ZiOXRnRjdTaW5hZ3Zsb2twbUs1SUs4WUNqaWdzNVoyVGJONFJo?=
 =?utf-8?B?bndXUmh0Z1duWU1VRExXZElCWklnWFVYbWZYdkd2OGlsZ1UwT1J3WDczNTBB?=
 =?utf-8?B?ZkxTMExlWUZDQlh4ZG9kNHBYMnc0TE81bk9FaTZ6Ymt6SXBrN3RRK3R2UEM0?=
 =?utf-8?B?TGV6a0U2M0VGSjc2WU91MEZweGpwWGV4Z2Y0SDZyWmlvckNocmU2bngrWkJH?=
 =?utf-8?B?bld3NElSV3JsbFhhK2t3VjNJYkRrQkJDRzRRc256c2lOdlZnYTBBY3Fwb3Nr?=
 =?utf-8?B?WEFLTElLdm5MZEVjZS9rQkRYdkhIQU9RRDdxNDZCV0RYQzR1cDJRaGxSWEdk?=
 =?utf-8?B?cE10NEtncU9Vc0F6eFJOQkE4SElwMTZRcHpPRjErQUkwRU55bWxrUUNjN1Yw?=
 =?utf-8?B?V2lqSHFFOVBiSzBwUnNPMWZGcUVZYk5WTThYcXJCL2lNUkt4elVWSTBJOEow?=
 =?utf-8?B?VUh1UFNIRkdLSXYwYjdiK0kyUW1XOXkrU21RUlBWZzFCNGJiT1BIb2lab0JG?=
 =?utf-8?B?S3grVjMwVW5COGZza3ZjRjJqdUYrN25pNWM3UzhyQkhMMnIva2lqSWdhNkda?=
 =?utf-8?B?d0E0eWRGYXRPK3g1Y0F0aHMyRVN6dDM1dEd6Nm1kTkFFNGl6R3g2Mkl1eDJS?=
 =?utf-8?B?eWdzaXRaVUUrRGJFVW1ja05iRWJOaHhFc29WekZtdnFLQ2Z6cHVTNVVqT1Iz?=
 =?utf-8?B?dzRINHBPWHlnMjhPMi9oMzdzdkdyM3NETGN2b2U4REUwNk96WjlzZnhtQzBT?=
 =?utf-8?B?T2YzZDd5TEVacmpIMnorYUVqSFNCM0pSSGxoTnZIMVM0Zm0xWVU3ZHh2OTRP?=
 =?utf-8?B?a1dvdno1dDh4cjRDZTZkVWhONUpXYkpiaEhHNVplR1NxVGZWb29FTm9DMVBu?=
 =?utf-8?B?a3ZleXA4OUVsYVhvQ0VVYWorU1gvWldCaW5uZElvUFZBNHZUZDhBRVJaTm0x?=
 =?utf-8?B?SElEUjB1NmlhUi9XTjVsQjZUR3B4UVdCaGRVSjU1ZFpzVTlFb0tEOTh2dmNX?=
 =?utf-8?B?Z3hrYWVKMmVPVFBkQnhzT2pUREVrVEZkUDQwMW01c2I4aGV1dkxaTmpENEFz?=
 =?utf-8?B?WXV1SGxZV1JTRXduSUNXT2FkTUp0UFZqTklmWWFVeU02QXpCZm53enpDbTFX?=
 =?utf-8?B?NndpYlMwNVF3VktuQ09nT1l3eE5mRkNBZy8xb0lIOFBXby9sY21kbFJHV2p6?=
 =?utf-8?B?TUNrc0Qrb2hTTE83dEFLU2k3c1NpdEI0dCt5ck1QTFdKVlVSRFhjcUpabXJ5?=
 =?utf-8?Q?y6zzJNuVNZvm5lSvhRWtg78=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <001D037FBFDECD408C8CA8B0C4866DA3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7ea6da-2428-48a2-3f25-08dc6bb08f81
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 20:35:24.5484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vRCc32et4/DvGsm0bZvl7Hlc5fY7eLWDBP+4FVgOg2v9oXweDyfb4dAhhQLMbSghHwx5kH4K0W9gQ0ICWm8aIv6i4YzYZ1/C68USb1wdf3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8197
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA1LTAzIGF0IDIyOjE3ICswMjAwLCBKaXJpIE9sc2Egd3JvdGU6DQo+IHdo
ZW4gdXJldHByb2JlIGlzIGNyZWF0ZWQsIGtlcm5lbCBvdmVyd3JpdGVzIHRoZSByZXR1cm4gYWRk
cmVzcyBvbiB1c2VyDQo+IHN0YWNrIHRvIHBvaW50IHRvIHVzZXIgc3BhY2UgdHJhbXBvbGluZSwg
c28gdGhlIHNldHVwIGlzIGluIGtlcm5lbCBoYW5kcw0KDQpJIG1lYW4gZm9yIHVwcm9iZXMgaW4g
Z2VuZXJhbC4gSSdtIGRpZG4ndCBoYXZlIGFueSBzcGVjaWZpYyBpZGVhcyBpbiBtaW5kLCBidXQN
CmluIGdlbmVyYWwgd2hlbiB3ZSBnaXZlIHRoZSBrZXJuZWwgbW9yZSBhYmlsaXRpZXMgYXJvdW5k
IHNoYWRvdyBzdGFjayB3ZSBoYXZlIHRvDQp0aGluayBpZiBhdHRhY2tlcnMgY291bGQgdXNlIGl0
IHRvIHdvcmsgYXJvdW5kIHNoYWRvdyBzdGFjayBwcm90ZWN0aW9ucy4NCg0KPiANCj4gd2l0aCB0
aGUgaGFjayBiZWxvdyBvbiB0b3Agb2YgdGhpcyBwYXRjaHNldCBJJ20gbm8gbG9uZ2VyIHNlZWlu
ZyBzaGFkb3cNCj4gc3RhY2sgYXBwIGNyYXNoIG9uIHVyZXRwcm9iZS4uIEknbGwgdHJ5IHRvIHBv
bGlzaCBpdCBhbmQgc2VuZCBvdXQgbmV4dA0KPiB3ZWVrLCBhbnkgc3VnZ2VzdGlvbnMgYXJlIHdl
bGNvbWUgOy0pDQoNClRoYW5rcy4gU29tZSBjb21tZW50cyBiZWxvdy4NCg0KPiANCj4gdGhhbmtz
LA0KPiBqaXJrYQ0KPiANCj4gDQo+IC0tLQ0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVk
ZS9hc20vc2hzdGsuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3Noc3RrLmgNCj4gaW5kZXggNDJm
ZWU4OTU5ZGY3Li5kMzc0MzA1YTY4NTEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3Noc3RrLmgNCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vc2hzdGsuaA0KPiBAQCAt
MjEsNiArMjEsOCBAQCB1bnNpZ25lZCBsb25nIHNoc3RrX2FsbG9jX3RocmVhZF9zdGFjayhzdHJ1
Y3QgdGFza19zdHJ1Y3QNCj4gKnAsIHVuc2lnbmVkIGxvbmcgY2xvbg0KPiDCoHZvaWQgc2hzdGtf
ZnJlZShzdHJ1Y3QgdGFza19zdHJ1Y3QgKnApOw0KPiDCoGludCBzZXR1cF9zaWduYWxfc2hhZG93
X3N0YWNrKHN0cnVjdCBrc2lnbmFsICprc2lnKTsNCj4gwqBpbnQgcmVzdG9yZV9zaWduYWxfc2hh
ZG93X3N0YWNrKHZvaWQpOw0KPiArdm9pZCB1cHJvYmVfY2hhbmdlX3N0YWNrKHVuc2lnbmVkIGxv
bmcgYWRkcik7DQo+ICt2b2lkIHVwcm9iZV9wdXNoX3N0YWNrKHVuc2lnbmVkIGxvbmcgYWRkcik7
DQoNCk1heWJlIG5hbWUgdGhlbToNCnNoc3RrX3VwZGF0ZV9sYXN0X2ZyYW1lKCk7DQpzaHN0a19w
dXNoX2ZyYW1lKCk7DQoNCg0KPiDCoCNlbHNlDQo+IMKgc3RhdGljIGlubGluZSBsb25nIHNoc3Rr
X3ByY3RsKHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzaywgaW50IG9wdGlvbiwNCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2ln
bmVkIGxvbmcgYXJnMikgeyByZXR1cm4gLUVJTlZBTDsgfQ0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94
ODYva2VybmVsL3Noc3RrLmMgYi9hcmNoL3g4Ni9rZXJuZWwvc2hzdGsuYw0KPiBpbmRleCA1OWUx
NWRkOGQwZjguLjgwNGM0NDYyMzFkOSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL3No
c3RrLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL3Noc3RrLmMNCj4gQEAgLTU3NywzICs1Nzcs
MjQgQEAgbG9uZyBzaHN0a19wcmN0bChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2ssIGludCBvcHRp
b24sDQo+IHVuc2lnbmVkIGxvbmcgYXJnMikNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gd3Jzc19jb250cm9sKHRydWUpOw0KPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJu
IC1FSU5WQUw7DQo+IMKgfQ0KPiArDQo+ICt2b2lkIHVwcm9iZV9jaGFuZ2Vfc3RhY2sodW5zaWdu
ZWQgbG9uZyBhZGRyKQ0KPiArew0KPiArwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nIHNzcDsN
Cg0KUHJvYmFibHkgd2FudCBzb21ldGhpbmcgbGlrZToNCg0KCWlmICghZmVhdHVyZXNfZW5hYmxl
ZChBUkNIX1NIU1RLX1NIU1RLKSkNCgkJcmV0dXJuOw0KDQpTbyB0aGlzIGRvZXNuJ3QgdHJ5IHRo
ZSBiZWxvdyBpZiBzaGFkb3cgc3RhY2sgaXMgZGlzYWJsZWQuDQoNCj4gKw0KPiArwqDCoMKgwqDC
oMKgwqBzc3AgPSBnZXRfdXNlcl9zaHN0a19hZGRyKCk7DQo+ICvCoMKgwqDCoMKgwqDCoHdyaXRl
X3VzZXJfc2hzdGtfNjQoKHU2NCBfX3VzZXIgKilzc3AsICh1NjQpYWRkcik7DQo+ICt9DQoNCkNh
biB3ZSBrbm93IHRoYXQgdGhlcmUgd2FzIGEgdmFsaWQgcmV0dXJuIGFkZHJlc3MganVzdCBiZWZv
cmUgdGhpcyBwb2ludCBvbiB0aGUNCnN0YWNrPyBPciBjb3VsZCBpdCBiZSBhIHNpZ2ZyYW1lIG9y
IHNvbWV0aGluZz8NCg0KPiArDQo+ICt2b2lkIHVwcm9iZV9wdXNoX3N0YWNrKHVuc2lnbmVkIGxv
bmcgYWRkcikNCj4gK3sNCj4gK8KgwqDCoMKgwqDCoMKgdW5zaWduZWQgbG9uZyBzc3A7DQoNCglp
ZiAoIWZlYXR1cmVzX2VuYWJsZWQoQVJDSF9TSFNUS19TSFNUSykpDQoJCXJldHVybjsNCg0KPiAr
DQo+ICvCoMKgwqDCoMKgwqDCoHNzcCA9IGdldF91c2VyX3Noc3RrX2FkZHIoKTsNCj4gK8KgwqDC
oMKgwqDCoMKgc3NwIC09IFNTX0ZSQU1FX1NJWkU7DQo+ICvCoMKgwqDCoMKgwqDCoHdyaXRlX3Vz
ZXJfc2hzdGtfNjQoKHU2NCBfX3VzZXIgKilzc3AsICh1NjQpYWRkcik7DQo+ICsNCj4gK8KgwqDC
oMKgwqDCoMKgZnByZWdzX2xvY2tfYW5kX2xvYWQoKTsNCj4gK8KgwqDCoMKgwqDCoMKgd3Jtc3Js
KE1TUl9JQTMyX1BMM19TU1AsIHNzcCk7DQo+ICvCoMKgwqDCoMKgwqDCoGZwcmVnc191bmxvY2so
KTsNCj4gK30NCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC91cHJvYmVzLmMgYi9hcmNo
L3g4Ni9rZXJuZWwvdXByb2Jlcy5jDQo+IGluZGV4IDgxZTZlZTk1Nzg0ZC4uMjU5NDU3ODM4MDIw
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvdXByb2Jlcy5jDQo+ICsrKyBiL2FyY2gv
eDg2L2tlcm5lbC91cHJvYmVzLmMNCj4gQEAgLTQxNiw2ICs0MTYsNyBAQCBTWVNDQUxMX0RFRklO
RTAodXJldHByb2JlKQ0KPiDCoMKgwqDCoMKgwqDCoMKgcmVncy0+cjExID0gcmVncy0+ZmxhZ3M7
DQo+IMKgwqDCoMKgwqDCoMKgwqByZWdzLT5jeMKgID0gcmVncy0+aXA7DQo+IMKgDQo+ICvCoMKg
wqDCoMKgwqDCoHVwcm9iZV9wdXNoX3N0YWNrKHIxMV9jeF9heFsyXSk7DQoNCkknbSBjb25jZXJu
ZWQgdGhpcyBjb3VsZCBiZSB1c2VkIHRvIHB1c2ggYXJiaXRyYXJ5IGZyYW1lcyB0byB0aGUgc2hh
ZG93IHN0YWNrLg0KQ291bGRuJ3QgYW4gYXR0YWNrZXIgZG8gYSBqdW1wIHRvIHRoZSBwb2ludCB0
aGF0IGNhbGxzIHRoaXMgc3lzY2FsbD8gTWF5YmUgdGhpcw0KaXMgd2hhdCBwZXRlcnogd2FzIHJh
aXNpbmcuDQoNCj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZWdzLT5heDsNCj4gwqANCj4gwqBz
aWdpbGw6DQo+IEBAIC0xMTkxLDggKzExOTIsMTAgQEAgYXJjaF91cmV0cHJvYmVfaGlqYWNrX3Jl
dHVybl9hZGRyKHVuc2lnbmVkIGxvbmcNCj4gdHJhbXBvbGluZV92YWRkciwgc3RydWN0IHB0X3Jl
Z3MNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gb3JpZ19yZXRfdmFk
ZHI7DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqBubGVmdCA9IGNvcHlfdG9fdXNlcigodm9pZCBf
X3VzZXIgKilyZWdzLT5zcCwgJnRyYW1wb2xpbmVfdmFkZHIsDQo+IHJhc2l6ZSk7DQo+IC3CoMKg
wqDCoMKgwqDCoGlmIChsaWtlbHkoIW5sZWZ0KSkNCj4gK8KgwqDCoMKgwqDCoMKgaWYgKGxpa2Vs
eSghbmxlZnQpKSB7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1cHJvYmVfY2hh
bmdlX3N0YWNrKHRyYW1wb2xpbmVfdmFkZHIpOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiBvcmlnX3JldF92YWRkcjsNCj4gK8KgwqDCoMKgwqDCoMKgfQ0KPiDCoA0K
PiDCoMKgwqDCoMKgwqDCoMKgaWYgKG5sZWZ0ICE9IHJhc2l6ZSkgew0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHByX2VycigicmV0dXJuIGFkZHJlc3MgY2xvYmJlcmVkOiBwaWQ9
JWQsICUlc3A9JSNseCwNCj4gJSVpcD0lI2x4XG4iLA0KDQo=

