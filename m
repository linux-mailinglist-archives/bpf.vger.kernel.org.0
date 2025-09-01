Return-Path: <bpf+bounces-67105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13404B3E214
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 13:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC791A82668
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 11:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3433218BF;
	Mon,  1 Sep 2025 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EouongX9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05895266560
	for <bpf@vger.kernel.org>; Mon,  1 Sep 2025 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756727645; cv=fail; b=BNXFxcjhxlbdkhp08szJem1b+lPGOec48TKTgAsyfAjOaPghPvpjNF9sG/6/+94f6Cd1iAbpzi7ajShvfIl77Gsz9IKBiWD9TOL2uFXS8WBep/L6pEO2/0ChC6jlJ/9+5nYa0+9WIRifIq+cHsnggqDi2VkqMg7WotYml6aQ9dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756727645; c=relaxed/simple;
	bh=KusI8bodcYQTeYYbW6OAsMt0O4QTnYdw8tyXDsxYMYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cOI0eW/0VsZZZerb+dZOIsTCNGhSpksacKmURJoPrMItB4+N+414Ewe8DQ+7zsF8uTSP/3MBsiZJzkGRLLGNH+Vm55Ij4GKk93i94LbWOaA7FV2lXTLl8kswAXSGi1WfT9ik3z0z5GcWIVxV2qFh+XsiFrkt8/Em1PIIXWVupbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EouongX9; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756727644; x=1788263644;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KusI8bodcYQTeYYbW6OAsMt0O4QTnYdw8tyXDsxYMYk=;
  b=EouongX9vyYX6SEFlrndsoN0oOGjmOJy5n7vg0Xpa6GjBy14tVtcKpxa
   f/hOsnH2M68gXga56h9S1lkkVLm5FJkgAYfTvvH/zT+Kf7NLAsnT2fjbc
   wm7mqEBkoo4ScNo/g0OweEXS8HaZTPFe6M7bztpRzxSOa8UuUixjcuZgl
   9u/Z8zhEwhXaqNOB9TKUeRyeLYPB/Zde/RpBJJ4Gojlb8+5lbriBNkHkR
   i8TnyG8Bh0f0a/NYeT/P6USTROvEvyXE8yNJiCNlDzavLEs/c85O7p3Rb
   ZkOPHhpb2kDie0ox2YbN1zOr2lvgXQBXZopoTvuVCbLjsKSjzgnaKgum3
   g==;
X-CSE-ConnectionGUID: h4DRhhAvQIKckt7CKylQNw==
X-CSE-MsgGUID: xQx4eqwqQY+0DkRCHhHWqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="69690566"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="69690566"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 04:54:03 -0700
X-CSE-ConnectionGUID: /uRhVApATwq7BglJMmYGfA==
X-CSE-MsgGUID: DGATuoFeRpeMg8DgCMvXHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="171452866"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 04:54:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 04:54:02 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 1 Sep 2025 04:54:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.88) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 04:54:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJ/1dMuYJlHgvyRbYlnh6D+Hu5wKPHcYbE17m+wi7JW1PxVUpeRUvIIjmvlQNa7qJIulFMewJGxdZ/XlRy6mV96OYI+VG7yXljYii3q73dznh+5XAJzXtW/q0sptLDjaT2lQj/+zINt6yCqadrE+loqOHNUE0uVeGtPYOIDlYV6Z5M1hb4XLfgtFuBiNcdcHI5TQNJbwHelZPhL7oQG8bWRkamuBMeg6ivXbbRfegX1MasfKmZw7cIsdVwlshiVsQ/sIrXs8U/lrSxZVzVwvJlYXu4kx3TwQxg3g5UZq9La/RoD9VGks1SSFUIfjQNmc7etkazEggKKzUH6wrx9uag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KusI8bodcYQTeYYbW6OAsMt0O4QTnYdw8tyXDsxYMYk=;
 b=jqq8nUfYhIZ6H59KSEJLEFOCdazdnx7/PGaLVTyo1Ta86yKy2LhOsshb4jJVKoK3I4bIuh6863cDtUapM0z5ngSQLmFWhn5rVOUdPqtwpSgEz45C4+jqmiE2oT7sXGXE2wjNz75S28aI4b0U3TAXoUvHMz0qBj1QuHRIDJmooCYLIMDDjQNCH+lW3KYIK7RpQaPBx0ZjtPV6t9J8p741ynF77j7ctyKcmTcFU7w8CZEfdt1Shm56LRtPPMWmVBWQNF0uz1aQSDWM5PMeMuAXFx0jJ6PhUwEPCC+QWwto6I9Ialeps8PY3c+LxmWV5w/OFHDWVdazStMMmr1v0H6HbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by PH0PR11MB4822.namprd11.prod.outlook.com (2603:10b6:510:39::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 11:54:00 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%4]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 11:54:00 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Quentin Monnet <qmo@kernel.org>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org"
	<andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH] tools/bpf/bpftool: fix buffer handling in get_fd_type()
Thread-Topic: [PATCH] tools/bpf/bpftool: fix buffer handling in get_fd_type()
Thread-Index: AQHcGykaAYwY5y1Q8kiFLjvJUN9US7R+M/CQ
Date: Mon, 1 Sep 2025 11:54:00 +0000
Message-ID: <LV3PR11MB876809802D0EB89F504A8CD1F507A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20250901092234.3974937-1-kaushlendra.kumar@intel.com>
 <3035adbe-926f-45dc-a424-ef42b12c1067@kernel.org>
In-Reply-To: <3035adbe-926f-45dc-a424-ef42b12c1067@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|PH0PR11MB4822:EE_
x-ms-office365-filtering-correlation-id: d597b8a1-e172-4949-62d7-08dde94e3d50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NHkxdVZZVXpxd2JGZVJsMmt5Zk54ZTB3VVRXRWdXRDgraytieS9rZTNFTzYx?=
 =?utf-8?B?d1lLbkFmOG9ZeENPMjJSaU5XRDZNMjZjWHBKTEFqZVZiMGIzMUhSSG5jWVV3?=
 =?utf-8?B?UllzemwvVXNlVzNqUG1TVGEwSjVlMHE0eGFEZnhNaTI3dXdmRG0rQVdwdXg5?=
 =?utf-8?B?NTJ6bU1BeWRKMWFnd1dZQjhOMmRyN3ZnSHhMT1RHOWl3MDVCTHEzbGkwK0sw?=
 =?utf-8?B?b2pVYmpWYkhIUVVLS243dFZrOTRKMlpsQ3gyTFpMTjMvL1JsSjFxSnFxVG53?=
 =?utf-8?B?Q3lFeE1aMjBPYVR1VkI3T294Sm53UmlmdmxDVXIwQXR3L2ozZXVVNW12NjVx?=
 =?utf-8?B?NUNmTHBPV1UwbHpuc0tHZzNlRUpoeVJ2RjVyWDBzU0JFdjhNWjhlYTU4MTY3?=
 =?utf-8?B?cFNEUi9EWFJIalNaUmJEWGVzMzJwd2JzbThmV1prS3RYUjNaUWR0Rm1JSXpa?=
 =?utf-8?B?MEl5d2phaElydzR4RTNnYnRXemY4RXRxWWJ1VjdQOE9lTnNpcDFFamlYZHZV?=
 =?utf-8?B?bUY2STR1M2NjYVYyWUZMSVFmempxZ1Iwb0RUZ3FPaVcrdGNYSmlSdS90MGdY?=
 =?utf-8?B?b3dhWkdsN1FxSDFSTXQvNkpWQ0hTUGhNNCt4QzhmV0FqQ2ZMSjE2cCtOcXFk?=
 =?utf-8?B?bjJoMXZDbDNnM3RlNzlFS3JJQzZMcHVrU3QzeENEZk9Xd1EyUGQrZ3hrSDRy?=
 =?utf-8?B?Vk9SZmJkL2Y1ZUVvS0dmQjFoQzA0MjFZb1lWU0VPb0RCN3UzOGZyVjE5c1h6?=
 =?utf-8?B?NDhtMis5eGJpNDdEa1FHaTVLcWNvUVJ3b3ZXZ2pJa1lXRHl5ci91RTZiWHRp?=
 =?utf-8?B?YjFySGt1RWVCUWRhVUppbDZVS01hRkZUeFA3eUcwSW5FWTV0M3BSRVM4S01C?=
 =?utf-8?B?WDhxOXF6OXN1TzhONVRWenFLZVRSc0J2SzVRcGZaRHNMaUZyRjB1WEN6QTM2?=
 =?utf-8?B?cElhV2wvODRUYW4xd2ZUZUtjZElpV0FUZXBnYUpUb0JJaGRjR1Q2SG1LVHdH?=
 =?utf-8?B?QUtWQ2hDRThVdS9QYTJVQkVOMGZFQ3Y2bDRQanE1S2xObEhFVUZPL0c2MjJB?=
 =?utf-8?B?dXJnNmhTc1lQdk9HNXl4RUE1YnIvL3NpYVFyYW0rMmdubUV2Mk5xWVFMWkNC?=
 =?utf-8?B?M3RBZDR3S3lTMVBEd3NOWmQvUGYxRVVFcVhJQWhFeUljUHBVMVpXUG93WU9v?=
 =?utf-8?B?M1ByQTQ1ZldyV2xaM1JROERkTlBGNUhQUk5UNk1LWjJ0SlhDRXBqMTlMTWJ2?=
 =?utf-8?B?WnNHZ0VVNEV5QnQrMGRWWld6OStZbnZVdzZRUm8vWTFOMjI3N0tRTStQTDBO?=
 =?utf-8?B?WHI3dTJWZHE5N2JUYVI2VXRuR3pUUWtOZFFzcXFaNjFHOGIxanlTTTkvMUh4?=
 =?utf-8?B?Y3VTQnAyRGRRaGYyTWt6L1hSTlpLUXI5eVM2M1QxNzhzVWFnZWYzcTZVYk9O?=
 =?utf-8?B?UkhZNi9ZeEJVN01lWXhXQlNsZUlWdUN4ZlZWanRjOFdkL040SkM2VmVpcUlm?=
 =?utf-8?B?dHUyMW9waDhKUml4L1I1R0tGeGVqTFVEN3U1cDhNK05OZEFneHVWeitEbE1o?=
 =?utf-8?B?TVQvWHBxTnBNWUZpcmVINXMwbC9abVQ4RmhKckVyN0RveFZQSDRCZUhQTjRE?=
 =?utf-8?B?U2Rwem9FYTlQLzBiWE5HRUhvY2w3ZTdOZFA3ZkRzMlk2OVhhL1NPaGhrYjV3?=
 =?utf-8?B?cmVORGd6dUkvR1A3eHRIRWJLVmpMdWFIUmtMa2RRRTdEb1RQdU5BNE1EZWZ4?=
 =?utf-8?B?Q05VbXl6UnBNQk83M0FqS1YybGFkWXQxNVdyYzg0T3VLY3NpQlJ5dSsyRjNU?=
 =?utf-8?B?bTJ4UUtkckhVYjFQUkJVWC8xYjEvRkFCeUl5WTlrUUpCVFJGS0tnUmpySnFP?=
 =?utf-8?B?bk9HZHBzeUhtWHAyZUVjQnZ6VDNJNWRScmh2UVJNOXRDYmVveUJJUnlIbkxW?=
 =?utf-8?B?Zm90Qlp1L1hYYlNkamdPbG9oRGlrd1RmUXpEN1dqMFBKQWxpWUd1eGJuOTJI?=
 =?utf-8?Q?J+4cfU8YjUu+bIvY0v6VwIIIsFP0H0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U09xdkNTYTV1Mmk4eGdzazN1eVpIK3F4SGNySHNsajBESWxFclB6SzUyS1E5?=
 =?utf-8?B?ZWkvVDNCaW01UzFEQ1hxRWVHbjRTdHFuRjhUUGtNb0RDU1lyYXlpeUNIbEY1?=
 =?utf-8?B?ME1YVWRLTjd5b3VyN3pPT0x0bEduaUZ2dzl4TFVnNVVRcnRaYzlXZis3dXRL?=
 =?utf-8?B?T2poazhiRlZkZFhobFRrZUs1L2Yzc0piL0RjZENYQUx4SHorTEY1Sk1wRUIw?=
 =?utf-8?B?ZXJQYU5UTzc2N1dJRkFYakhtSXhXQVJzQW5wQmFPbk5pZ2p1WFhpL2Q4ZDZS?=
 =?utf-8?B?ZEM2RDRnUDBzamllUXZ6cnZ1Zzk5ZlVDSjFZUnRsWHh3YWtOL05ZbEZzaHow?=
 =?utf-8?B?aC94MmNOWm92ckwzYkdMWmxhekt5dlpIdTVrSGM5Z3o4RlF2eGlUdDRHcHM1?=
 =?utf-8?B?dTlhUkdybk54ditZNis2aWVGOG5NcVdMMzA2azNpbmUwUFVOMTMzT3A4RHRJ?=
 =?utf-8?B?VkhxODNHK0ZZcG93aGhheUh3dkFmZ0t5clRlS0NDRGlUK3A4akRORS9SVEdB?=
 =?utf-8?B?M0VEQ01ERU5EaHZRZ2poYmR2c2pBSnJweWZjRmt6ZmVsWFdVWE5kdWExTG9q?=
 =?utf-8?B?TUM2UTZ0VTBpcWlLOE5ITG16bEtkcmhRc1F2YSs2YkxoeHhRUzFqZUc0V1hm?=
 =?utf-8?B?cEFFN3JnVzBXVnlHQWxPMXQrZ3NEaTI0TVZrQXlSR1k3alRMelJySElVUElT?=
 =?utf-8?B?b1EySkdDeHVVK0lGTmwxdTA3dkVMOVdLK3FKTHgweWlZYWtxcktRbXg4RnNz?=
 =?utf-8?B?V1ZZZlI4UFpwQlVmeWZySDlYNWdzR2lhVkdvamxNYk5RZ0hlMVY4Tjk2dkRJ?=
 =?utf-8?B?ZzlXVXArcUxJV0JTbCs2cktkZzdwV1ZOc09DV0dTajdSYk1ocnU3TzdhQUN4?=
 =?utf-8?B?YW5MM0dkYzJGc3FUMW8xanhrUlJaRTIvUFFkQzN3czZFV3FDUEtTTUtmTmF6?=
 =?utf-8?B?V0dCKzFRbVJSUDJ6R1JRckdxUzFlUFYwSlY1RFRFY280OHRETGZPWnZYMHhu?=
 =?utf-8?B?K05VeFYxR2tMQnRqKzBEZjZNY0tnOVBLY05iNlpRUFVFS1g2OEliQUZabFNz?=
 =?utf-8?B?ZnpRL2J3Z1JSUWVYTWFuUXpQeGYwbmZRVVlyOGttbUw4S2RFY0VzYUQzRHps?=
 =?utf-8?B?em9EcGNCemhOUmJNYlhDb2xxNWs0ai9Eb2F0Nkx1NjhmWndpTjk5RDJOcWdR?=
 =?utf-8?B?MGxiRDJ1ZENrOFQvd2RDb21KL3Q4OWE4NmZHR1ZCNFZ5NnB6bG1CUFlsaFRj?=
 =?utf-8?B?alNOdmhnWXZmT2NJMDh2dE1jd1dmTktra0FISU1FbnFKK1R2Q2RWK1NWTnBR?=
 =?utf-8?B?MzMwMUJ1Mkk2aW1DVkl3TTFINTZiZTQrTFVxbUlkcjhCLzBUVVdyQzlYWEtp?=
 =?utf-8?B?VUJIU2h0MkFiZ0d2UzJSQSt3MUJYdHFzUUY4ZTVXRFJlWlh6K21oZ0V6UVNM?=
 =?utf-8?B?eEFWbWZ4Ny90VVJuSzVxbUMvd2Y1dmVpRGExQ0pMbTVIMnRKWVdMS0dxZkdI?=
 =?utf-8?B?emh3cUFXZytQdXhIM0hEVm5HdDlBcnRFNW9nNGxGSjBRS0VXOThQcEduemxY?=
 =?utf-8?B?eDhScFlPaHVmQzJjZ3ZJK3l2YWZDY1NGT1RNNnVpdW1QRkR3SzdFR2E0SG5W?=
 =?utf-8?B?ZjhTc0Uxbk1qTzc5WU5FeWpPNFpaRldSanFJa3ZLaDUyZmtPcDhkdEV6VUNE?=
 =?utf-8?B?ZmpZYkFsZWhFU2RqRlFuOTU3STV3QXcrOHcxUUlFUU1FVmRvdm9sRHNOdDZ3?=
 =?utf-8?B?dUQ4bDY4djR5UTNvbW5GMXFlSUNTSkpaUllKOVdDUzdrd1BDRmNaMCtyMDBm?=
 =?utf-8?B?LzdHMjhaanR5cCtScWhqaGoyaGZxekJFVkloOFdMcVY5Szk4MDMzSm1HOSsx?=
 =?utf-8?B?RXdzdFpFSHRScU5XRkpRejRRSmgyUXpDTEkvYkdpVDdxVFZyS1dOUEUyb0Vq?=
 =?utf-8?B?a0I5SDl0bjdOZTk3UHJ5MVZ2aGlYbk5tU0pxb1ZrRFB5bitLa0tXR2QrT3p1?=
 =?utf-8?B?UTU4YVJIazlwNkNYeHBSRVZlZjJmTnNqaU50bGZ6dDBERHozRUdQRXVrOWNT?=
 =?utf-8?B?d2szeHFiRHhPbVBvVENDM2M1MEpNcjhaZnJ4WVc4VVRHLzEyUzVGMDJlanhQ?=
 =?utf-8?B?NnFHMzlzOThrMmlMWGVqQ1hlU1YvYS9EUzNQTDY0L0czZXBDWnhoTzdpclFn?=
 =?utf-8?B?aWV0L2s3V3loKzhBQlpWNklUeC9SQmdKbWw1NTAwdjJZbGNXdVV2SGNhbXRu?=
 =?utf-8?B?Y2o5eFFscjlMU09Zd0t2L2NPakd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d597b8a1-e172-4949-62d7-08dde94e3d50
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 11:54:00.1683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NrN2Nc4+GFYa8XckvZdPZwSrYS7aDawOZOTklPCLc50Gdklb9agTKxNi4Dt43USBjK6GnDDwcuTSn11MA11LCNVtq58OmWlneI6vpogfNRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4822
X-OriginatorOrg: intel.com

PiBIaSBhbmQgdGhhbmtzLCBidXQgSSBkb24ndCB1bmRlcnN0YW5kIHRoZSBjaGFuZ2UuIE9uIHN1
Y2Nlc3MsIHJlYWRsaW5rKCkgDQo+IHJldHVybnMgdGhlIG51bWJlciBvZiBieXRlcyBwbGFjZWQg
aW4gdGhlIGJ1ZmZlciwgd2hpY2ggaXMgYXQgbW9zdA0KPiBzaXplb2YoYnVmKSBpbiBvdXIgY2Fz
ZSwgZ2l2ZW4gdGhhdCBpdCBzaWxlbnRseSB0cnVuY2F0ZXMgdGhlIHN0cmluZyBpZiANCj4gdGhl
IGJ1ZmZlciBpcyB0b28gc21hbGwuIFNvIHdlIGNhbiBuZXZlciBoYXZlICJuID4gc2l6ZW9mKGJ1
ZikiIGhlcmU/DQo+IFRoZSBjdXJyZW50IGNvZGUgbG9va3MgY29ycmVjdCB0byBtZS4NCj4NCj4g
RGlkIHlvdSBhY3R1YWxseSBoaXQgdGhlIGJ1ZmZlciBvdmVyZmxvdyB5b3UgZGVzY3JpYmU/DQoN
CkhpIFF1ZW50aW4sDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4gWW91J3JlIGFic29sdXRl
bHkgcmlnaHQuDQpJIGFwb2xvZ2l6ZSBmb3IgdGhlIGNvbmZ1c2lvbiBpbiBteSBjb21taXQgbWVz
c2FnZS4NCg0KTG9va2luZyBhdCB0aGUgY29kZSBtb3JlIGNhcmVmdWxseSwgSSByZWFsaXplIHRo
ZSBjdXJyZW50IGNoZWNrIGlzIGFjdHVhbGx5IA0KY29ycmVjdCBmb3IgdGhlIG92ZXJmbG93IGRl
dGVjdGlvbi4gVGhlIHJlYWwgaXNzdWUgSSB3YXMgdHJ5aW5nIHRvIGFkZHJlc3MgDQppcyB0aGF0
IHdoZW4gbiA9PSBzaXplb2YoYnVmKSwgdGhlcmUncyBubyBzcGFjZSBmb3IgbnVsbCB0ZXJtaW5h
dGlvbi4gV2hpY2ggaXMgYWxyZWFkeSB0YWtlbiBjYXJlLg0KDQpCUiwNCkthdXNobGVuZHJhDQo=

