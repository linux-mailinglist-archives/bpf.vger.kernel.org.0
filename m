Return-Path: <bpf+bounces-66248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE72CB30209
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 20:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E72B687D04
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 18:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4E933A02E;
	Thu, 21 Aug 2025 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cb8Pumux"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DCF2DFA2F;
	Thu, 21 Aug 2025 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800848; cv=fail; b=hYXcFo+MHXUUtjW+PlPqlC3ozPzFbCjXReVBslEepov7BijgN4UQIdgVLm0ZQ9pP4tJJaQvk2gFTaeHkEBXawBLPv47lBWQIlKICRxpFk1Kmy5HrB4Sw0WMY+zwV4rtJFjjvljo6Vr8GE2MPgxbus//z21sXxhX7OJCM/YnFcOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800848; c=relaxed/simple;
	bh=rqKa1/IR4uB6HR3Uo+2BMybaBLOCuHnDOXiB6rLzotU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l+hqxpgWPCVUK28iM8M+CvawvwoiYP32gmW5i9Nj3GgKeKMsj4z7roc9QGKDGCTeVysB/iTHSMz0i2SytS2YUbXvQTKpeLMwkhE12hpETwCJ+7uExPa6IuJZOsO0tiAnlQ8WppasOKPmgUZs5EvdgkVelTcQeJEf8SalakKBS68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cb8Pumux; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755800847; x=1787336847;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rqKa1/IR4uB6HR3Uo+2BMybaBLOCuHnDOXiB6rLzotU=;
  b=cb8Pumux1IIY4Z2dED9bVSWV29ypRKU0ASiGGic09Q4Hi3XJBvI4b54j
   mbqwaA6j5AoMUbOB7+B+8qI78wTNBY2EU3T151LR1FFBRtT8BbvtXqVtd
   QvMg7umvCDKqsR26EoKtAMmxUr3Q0Vq9OLx1PZfzI7ndlQ61mzpWXRC2w
   A0KKOdFBGu7Ukbp0R4UsvGtEV9DYYxdGhj0NGX9sUsYatgUyIgx9f5vqy
   NuvYwSKiIW7bDHXgGmS5koyLZDWbDCO8vIRiALfn1+QUCUBevaBs+A2Oc
   4xmxWFj6TWvi8fu5ma9VaVMkC7nsoCqlyE2Op1iMFUezrOZ/GqAZctVvJ
   w==;
X-CSE-ConnectionGUID: 95YTWaBPQ1C145WiUu8Wvg==
X-CSE-MsgGUID: qHuJ14DESQCqImP6B1MdwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58051485"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="58051485"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 11:27:27 -0700
X-CSE-ConnectionGUID: aaenTzI0S5CpKFU+sFzQVA==
X-CSE-MsgGUID: 8l1JewOlRxybkAkOW0Sa3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="172895604"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 11:27:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 11:27:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 11:27:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.86)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 11:27:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1DyAEqmAC0iIKE18WQVk/ILv8i4rb1NkHNrg8vhgXL96E+m8e06AkFnTFZXpQx6mjzq+FCpZ1g0RJ26UD+hXvFQWLBSDKcJ6pd5TZRtvV4neX3YiSxSWT3g8WWq5txa+PFImTE92KTVBL71cMdj8RrL9TbhC5zApJglWUCYVhrAX7vf+dDt40Dqfhbzw5zyYGQDbzpSawFlZWbL31UcMH3aSOrbcpHl1azWDbmTk9C1fw3KsPhykM9hcUJVB9BPuB+pUmq9XD0NHnnjikTh2cwgF0EFvxL+aOLO28HgPR01XWySxtclmsyZmuLo5g/CcWgb8dD1V6gOrU2TKk4iqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqKa1/IR4uB6HR3Uo+2BMybaBLOCuHnDOXiB6rLzotU=;
 b=PbrApaXGP3G9G1QKF/ulI3IcZj2RsRG9rQVTjlVhC1nm8yYFHEI+S/6FhG4+5aniR14czHcQ0K6iULMlRh9dTx05+aCanpL+1JlxRx9PzMi86Eo6NHIBQmBMPSWigqYGY1HUGjthZwQn4r/b8+1SfUmHDurYWUQ80sQ8GQ0jp+MFhFLyj9G+g08F5DExHiGrQgxpoH22+GMX1SxkudDGisnevgCZk8WxIIZKB4AMuzNHQyxHexY6WTdwaaF2pxXIq2RbXru332KjkgNZ583MuwwVvTuqPbXsRMfVTegRYnTYu+SB3q17h6Dr806OmJwQlnOBj73cjl1K0Qdh05LLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS7PR11MB7807.namprd11.prod.outlook.com (2603:10b6:8:e3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Thu, 21 Aug 2025 18:27:24 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 18:27:23 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "olsajiri@gmail.com" <olsajiri@gmail.com>, "peterz@infradead.org"
	<peterz@infradead.org>
CC: "songliubraving@fb.com" <songliubraving@fb.com>, "alx@kernel.org"
	<alx@kernel.org>, "alan.maguire@oracle.com" <alan.maguire@oracle.com>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>, "andrii@kernel.org"
	<andrii@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@kernel.org" <mingo@kernel.org>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "David.Laight@aculab.com" <David.Laight@aculab.com>,
	"yhs@fb.com" <yhs@fb.com>, "oleg@redhat.com" <oleg@redhat.com>,
	"kees@kernel.org" <kees@kernel.org>, "eyal.birger@gmail.com"
	<eyal.birger@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"thomas@t-8ch.de" <thomas@t-8ch.de>, "haoluo@google.com" <haoluo@google.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 0/6] uprobes/x86: Cleanups and fixes
Thread-Topic: [PATCH 0/6] uprobes/x86: Cleanups and fixes
Thread-Index: AQHcEpkjDd6hPInHJ0SrykSo1ewNHLRtJ52AgABFqoA=
Date: Thu, 21 Aug 2025 18:27:23 +0000
Message-ID: <a11bdc1f59609073f182c2c04dbd72cecde61788.camel@intel.com>
References: <20250821122822.671515652@infradead.org>	 <aKcqm023mYJ5Gv2l@krava>
In-Reply-To: <aKcqm023mYJ5Gv2l@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS7PR11MB7807:EE_
x-ms-office365-filtering-correlation-id: 00db18e0-cb7e-4327-5218-08dde0e05fb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TE42c1UrdlJXZ25meUlwanFGSkpjL0l3bnkvTCtIN2E3bkJkS09FZ2ZkbWJN?=
 =?utf-8?B?WHF3L1hKeUxkUjdHT2FmakhXRlpOeklHeUtxZzRUVXJYUW51RXRkRjFSNnMv?=
 =?utf-8?B?Umc4K0xkNzlpakdXT3RCYXJXaVdXR2w2ZzhTeENPVUU1SCtjMFEvSFhvdFpj?=
 =?utf-8?B?c1ZjL2Nndnd2c1pGeEtHMEdsb01TeTdGSUxIRnQzb0ZKb0ZpRkJ0SGJPWFJN?=
 =?utf-8?B?RkpGSENmMjNnTm5RNnU0cUVBd3FXNFF0dTVxVkV2RnliNk9oQzRQSmtoRUdR?=
 =?utf-8?B?RzkwMUllU0dQTHpRTUkvV1dFNTdpUkVHU2M3VmFIK216NmxnNnF0YU5vZDR2?=
 =?utf-8?B?SUQxc0doL3p4SGFyNFphVWkwMmxickpIOWtCeGgzVUlxSW9EaHdwUjFWQXFk?=
 =?utf-8?B?VkQyWU04MjZHbUtVdFN5Y1NKTEVqemVzY1BXc1ZCcUpGb2pBTTY5Rm1nd0NE?=
 =?utf-8?B?UnUwRTkxbVNJTE9JZ1BCS1VpTjZBUzR1dlovbFJCVVZ0S0pYR3FYcERmUjFo?=
 =?utf-8?B?T1gwUXlwYm9Bc1d0TDVTNGNFSGNaRXZKTlEydXhEWmRsc2p6a2VlSWJJMTE0?=
 =?utf-8?B?NU1Ia2xubDFzam1acVdCSGlOdDVla0lxTkJMUCtUSThBS0l1ZUVacGhCeE9w?=
 =?utf-8?B?RnJyRGpJbGtPbVIrcnlCbmU1VFg4Y0wwb3dBam81d0gyRDdpWmpKM2pZYW1O?=
 =?utf-8?B?Z0h3cG9pV3Zvc3FrNDNEbGVaK2E3b3ZKRjJ4MWlKNmFkZUFmTUxoVGtjSmV2?=
 =?utf-8?B?R2lpZkc1N1hNZzQ5RmpPaXRXSm45ZHpQU0ZPMXJKUWxNWGxDQWVoZXptaTZX?=
 =?utf-8?B?YjNaajVJd0xXN3BHaUpHcVdBenIxeml4SE9UNWEyQzE2b3lwTlhnWWFlSXI4?=
 =?utf-8?B?M3d1OEhMblBTeGtRTFpDZU5FNmJ0L2RoVzlBZjZwTmNPMCtFaE5SamRham56?=
 =?utf-8?B?WVRWbWRqUjU4QitRbmtUOEdPS1NRdjBEeXZYdFJQNUdkQWNWTEVsRVZJY2k4?=
 =?utf-8?B?SGhualFwcExwRzlSRFUvYmhtaEpXcW5QZkJCV24zRU14Q2c1ZERXbTZ5OXZM?=
 =?utf-8?B?QU1FaTBkU252aEtuSTZHR1hvdHRXVzlsQmVuNTRobG9KTWFLbDkrY1dWVHJm?=
 =?utf-8?B?YVZRNEtLcnphNmY5U1BnL1ExMk9lMkFwZm9FdU5OYzRoUDV3c21Tbmd3cGE3?=
 =?utf-8?B?NEJNVW1SMnd5cDYzVjl5bUlZOW01MU1hbjlaRTh2Q3UwcVBvMmVNN1JNcUlL?=
 =?utf-8?B?a0JIbUpwZkpWWmNXNi96VVRsa21HL2JWekxSMHNxTEVJRlJ6bWlFMWZSb3Za?=
 =?utf-8?B?SlRObkdaRGZVNHRTUDZubjR0QnYwL3hLOUhybzV4OWYwblhXYk9DaGxPd0Jq?=
 =?utf-8?B?MEV5dVVXY0JKZGcvQm96WStqQ2w0OXNMOHZWM2kzaG55U1hWbWlVSVRKcVQ0?=
 =?utf-8?B?WlJ4Q3ZiZy9hR3l0TmpPQkFWbFh6WWVkNkdPZnVhT1lhWjJuaWZLcFdackd6?=
 =?utf-8?B?SVVZNWtjNGdrOXpwVkQyLzBjaUE5SjcveUZ6WHdIVnBDdXkrM3FBdmlhQ1I3?=
 =?utf-8?B?YUw5NVVIVm5jOS80cStBakxrSnFNMXh1UGFLKy9ZWUtYcm56eE8xYmJydW9B?=
 =?utf-8?B?UGhscENqdXNGUjBzWGRpQ0lBUEkyYkwvR2M1OVEyWFk5TmUzY1dZVG5RSklK?=
 =?utf-8?B?SS8vWFBpZ2NydEQrOVY3OFdCTUZuRFRqZDRTS2t3VjI5WW9tc09WZjhiSDV3?=
 =?utf-8?B?WnFpcGVSZ0xoSjRpSytkSzJsdnArWUNPREs3dmNxUUpXMzRUNFkza2FDbGRJ?=
 =?utf-8?B?MzRoak5EdnNvU0s2UEovNnRRakJvQTNhRnk5YndHT2k2NEdZZWVwemtSK2h5?=
 =?utf-8?B?ZUlqTWRZTTZaWm55QXptWTJDbzc3WHM1MnltbVU0Rml3bWlnSjN6MFE3UE1Q?=
 =?utf-8?Q?HL13+2xhx5xzW446rya/rgRgQv0xL1vz?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkVaTEgrRGw4R3pSMkhPTVVkZURnYWhoNUlLK3dPOGpGbmJZY0ZXVmcwQ3NH?=
 =?utf-8?B?dWhRSjNwZ0MvWHpwSitsc1Y2cXBmU243MVFueHp1cmJGYkdyRnVqZUI1KzRV?=
 =?utf-8?B?ZmphUjBZRlBxR1lyak9TN2k3OFhnSEc5Wko5YldYbm9pbUFVYTRBNDBRN29a?=
 =?utf-8?B?Sms3eFJmT2NKRUNsY1UwakY5eDdlZS9SdHZXWS9DdC9vOVA3ZktISDBpanJP?=
 =?utf-8?B?Ny9DSnpFSkVDYzE0M0Z3dTNxNTRDTThXSFowdzkzd2paUklkTVZYU3gyK0Mx?=
 =?utf-8?B?K1RQdjVLRnlhSVZpa2hYSk9qbHc3MDNvK3NIdFp1UUUzRlB6d0dlRUVBMXow?=
 =?utf-8?B?MzdhMVR5MVl3VGdvR1A0TmRIMURNK1ZaNmtNY0VYbkhCSjcvVEZQc0RFamg3?=
 =?utf-8?B?ZTVVNW1taUVEVmxEdDhLY1RpeE1SMWVPRUpkN2dyYW9EaFZhZXRJTnJFS1dx?=
 =?utf-8?B?Q1l3dTBzSDlXbFBDSnNyOGhNdjNLbHJEczB3R2FkZTJ5dit1cC9sMXd5Si9w?=
 =?utf-8?B?WkdIM3JDTUJaT0xrU2c1Mm5JS0Q5SFlWa2JWa1Y0SWhETzhKeUpnSTFxVS8y?=
 =?utf-8?B?TnFHV2d0Yzdsc3FwRVZJNEVMM1plb1p0cTlEc3YxR09JS3cxS2JySWxCdXln?=
 =?utf-8?B?TkhwWW4yNHYvL2dWUlZoTU01S29tVVlHVXZkbGIySFpDRm5YOEp6T21Eckp3?=
 =?utf-8?B?dmxPYWNvRnVaMGlNNFVUMU05V1VXSlhWZ0ptMkxFSzArcXkzUTNYK0tJVXVs?=
 =?utf-8?B?WnFFZ0xHQlk1cW95MCswUkpTVUpVbGE2YUZiY3Ura2c4TmpDUXA1SzJjK0dz?=
 =?utf-8?B?a21jcW96cHM0RWxoMUtyV2QrSWd5YkZ4RXNTMTlGUDhTMGpSUzAza3duR0xR?=
 =?utf-8?B?bFlnM3pFZWlQSWpNNld3dXhBdnVNeS8zeEpMdytiUlp2SmYzTGxwWGN2THND?=
 =?utf-8?B?UXlWNUlBVVA2eXU2Nm9OQUhxejUrMXJHTUtUZzZGeDBHaFMvdVBhQ1ZCZXJP?=
 =?utf-8?B?Q2VLSU1BOUF3am92TjFuWTcwKzBwVUtNc1FZcEdJU2ZIaHU5aWZsOEE2U2lv?=
 =?utf-8?B?eDVWaHpmcUZTajBwdlBVQXVvS0xEZTZCUEhBTmlkQW1Ea25qWjFHZTZ0N2ZE?=
 =?utf-8?B?UnhqYzQ0YWNaOGk4aW5ubVU5UmlXdnNHcWlUekMrTFlqUXJYRFBvR3pqZUlV?=
 =?utf-8?B?a0ttSHdscEpuNFZwZThxYkdtc2lDYWRzcEFjQVRRck0zamdTYnpCbXhmNTJx?=
 =?utf-8?B?QnRqWngyeGNDMVBRZG8wV2tFM1YzaGlDclBkRitiSmNwdTJSRllUR3QwSFRO?=
 =?utf-8?B?dHFwRkpRL291M0ZNSERJQXlCejBNQi9PUHVoakp5a2hPcW9ZYUZsdWE2OWlx?=
 =?utf-8?B?TGpqRVplckl3aEc1RXNpNnVqY0ZLd3Y4UFIwY3RqbUdJSkxwMW5HTzFnSWNU?=
 =?utf-8?B?dXpabmdUSC9FUXFmRHpieElqWTBEMXFtRHoyVjBXRkhUMG5MT2ZVTk43ekcy?=
 =?utf-8?B?MVFSNCtwcTl1WjNVb1FvWWtUSThSOVFJL1pKd3VTZVF6WnZhODRYY2dRVDNM?=
 =?utf-8?B?UjQ1aWpNT3N0d0YraGQ3T1pic2Evek9YQXRWTjBlUjF5ejdXYWo0QTZvWFFL?=
 =?utf-8?B?NmZTSFNEWUdGa2tUU2pva1BjaVZhMS9kTURlMSt4RjcxVzYvckxlYkpQL2JM?=
 =?utf-8?B?QWQ2NjlOK3pGK3FJNnExMjZOS0F5YkgvdHVUdGJUekEyRXN2dXR4aTQ2WWRJ?=
 =?utf-8?B?TjJvcnE0V0MrWHBTZG9TZmpIdExFMTk2OTNqenF3UGFBSUQ4b3gwWnBJWE5q?=
 =?utf-8?B?UGp3UTNFUE1MeUdJYTVUV2IyS0JWQWhadGNBdHh6YVA2M09MV0wzSTZoUzFr?=
 =?utf-8?B?RjhyRUI4aitNd2swZTVMbU53SjNmMCtJd09uSDVXdm5rUVA5TFIzRmc1MHhZ?=
 =?utf-8?B?em82cER6amhwSlliN1k5Yi9lUzJqZW8vdkZSYnNqWEVNWmtiV0NPa0hLSjlE?=
 =?utf-8?B?NVNpUHJwaHNxMDFVYURsZ0NBTlBoaTN1UGY1UThnMUdRVFpHcDRVSnJac09r?=
 =?utf-8?B?SDR0elRhUU45MjF0ZFJrY3l4M2EybzF3QVUxK1ZneHVlYUI5SzkxUWgxT0sx?=
 =?utf-8?B?UGtUV1ZBamp1eis1V1o0S1VhZ1hFejRlaDZaSlpxRElVMTA2S09BSDJlSUVl?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB4B500A43F6A843BAA61389E205981F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00db18e0-cb7e-4327-5218-08dde0e05fb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 18:27:23.8951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JibeYTATSKGWahhYvIdqqaLdVzu5rUT6L6E1mOhFpJGXMI/UjGuuPOugac6I0Y7W1P4n9rZck/TN7Iet7t06gSszLjej1kud6+Ecycs2n3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7807
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTA4LTIxIGF0IDE2OjE4ICswMjAwLCBKaXJpIE9sc2Egd3JvdGU6DQo+IGhp
LA0KPiBzZW50IHRoZSBzZWxmdGVzdCBmaXggaW4gaGVyZToNCj4gwqAgaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYnBmLzIwMjUwODIxMTQxNTU3LjEzMjMzLTEtam9sc2FAa2VybmVsLm9yZy9ULyN1
DQoNCkkgdHJpZWQgZm9yIGEgYml0IHRvIHJ1biB0aGUgQlBGIHNlbGZ0ZXN0cywgYW5kIHJhbiBp
bnRvIHZhcmlvdXMgaXNzdWVzLiBEaWQgeW91DQpoYXZlIGFjY2VzcyB0byBDRVQgSFcgdG8gdGVz
dD8NCg==

