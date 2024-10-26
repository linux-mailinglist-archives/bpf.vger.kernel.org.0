Return-Path: <bpf+bounces-43243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0A09B19D7
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 18:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F143028276C
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 16:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49DF12DD8A;
	Sat, 26 Oct 2024 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NwDKn/F8"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3665E2F36;
	Sat, 26 Oct 2024 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729961147; cv=fail; b=TakUmhRPV+7JNIxzfS10MmjM8vRrov5LPE63Rq+NrAqzpcNvrkPIbulNMR7tTNund3Q4lgKbx5GrHB4bYROrq/OS71JZ6qGIj+F1NX3ICj469hAQczdb5cUWhW9bipp0yXR8FkVIOSmxEQD2Tp+lHeGOzAX8LcrfSoE167X+Ddw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729961147; c=relaxed/simple;
	bh=oLTV1TEFfjPOBh3G2JEQrVV6qWrvf3Hr8tOMe51L5O8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BoRt++7SXEhSShIz1FIbYJpoU9qcV8k+B9zwWwygAkSAYPsIkU6OgwuTgS0xzIeJd7LbbQ80bca7M8wZBgp7fBKxQQj7Fq6Zu5QVcYsNhk53tRiI82wZPBvldN99NmcC64uREtgcYDnHJUQZRWaz1P8w7PkacI6WVByJtQ89HWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NwDKn/F8; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729961144; x=1761497144;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oLTV1TEFfjPOBh3G2JEQrVV6qWrvf3Hr8tOMe51L5O8=;
  b=NwDKn/F8mTJ+OBCPIEGM+/okMh0z+Jh7O/10l+Poq9FcGnP7U48/9Q/M
   T+9WsSr4xcDISApYTRgP2gf2BsUoM6OOHuLg17DOUzaeXmoNzIdBOZRIK
   Lxn5cEC85QTn1oEFoxK9awnof8aaHrGlsfeWImjDYRdh/HHaQRzRboAzS
   l0299GqqE+4G0nl2BgMCR1tskZRyqKHr7LLxFQIlvaAsaeoJD2W3zJQu7
   fhEpec2riVT5vm9CmiAPBBhwlgXMZV60VvGc5WF0Djh2WQcymz0tkxL+I
   hMs8NpC8AoeqwxWlV7W5GCOfZH5r5JlBGA19X18aCGpOHQsL2v2s7kAOK
   w==;
X-CSE-ConnectionGUID: JZcNqHiaRUu+8ngfxxX93A==
X-CSE-MsgGUID: Ox3qExT3SwqIU1G4Ls5bAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11237"; a="55024880"
X-IronPort-AV: E=Sophos;i="6.11,235,1725346800"; 
   d="scan'208";a="55024880"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 09:45:43 -0700
X-CSE-ConnectionGUID: Yv3dvSifTkeGNyoUB8eI+Q==
X-CSE-MsgGUID: rg9QpEkbRfyfzljef8EHJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,235,1725346800"; 
   d="scan'208";a="80839012"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2024 09:45:43 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 26 Oct 2024 09:45:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 26 Oct 2024 09:45:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 26 Oct 2024 09:45:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFgAWXWOnAHH+CruqNKaS5ItyHAzk1Myb2tq6jsAn2VGCwn+Wgidh1cpHL5pD/k4aBa4c/oRDi0SFhMb1fwpQRlIq1fo1V5Cv8d+WqZnRZKhjTDkkVzlql8/DLDrzBkJI5jrUKRNazKmkZdRmI767ij9xYAMcz2L4Ll8PGbaCzEI3LLgRJux9b6lXpVnLQtPKMTwbtYxrT62GjFn95K+h51ghzxk4IDdEHd6wAmQL12bDsVVLp+z4kIMIqd+Cj/Ms0IfGywP240R86+XR4e3lfaiT9Nqq2w+zFCgHkybipl49MfaYt/X40wBQBg6M5A9QewAWQVLv8KNxycsTmQKyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLTV1TEFfjPOBh3G2JEQrVV6qWrvf3Hr8tOMe51L5O8=;
 b=UwoXNU7zL5l3j3kUZxbx7aVZpCSoijP7SA2NmC5sUmhj9aD5pEHSZPir5/RYjvtyjn6vcAy/SQ0QOZm4jNilexTOuZ+IMsdunb4O7Ey9aKUsQ3SPKz0c57zlNkWm+EpZDomYeB1gXKfYDQ/r3h8DSEKKvZwtJEvx/9BwG89/JjhbPGy/eT8s3LuOsez9+aqH/2SFuGD/vzYSEPaN+25zb73Ya7jp0mHSlh53H/yWeYtZNZtDxAzi0CJxuYxKljozMsfZOAvuwer8n0JSp/vSShwHBqWjDeyhcRi+S6NYgETAgfnqKzfS/sTPuIH+lgslefYfvQuhyeY+xSBhUBSzGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5144.namprd11.prod.outlook.com (2603:10b6:510:3e::20)
 by DM6PR11MB4676.namprd11.prod.outlook.com (2603:10b6:5:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Sat, 26 Oct
 2024 16:45:32 +0000
Received: from PH0PR11MB5144.namprd11.prod.outlook.com
 ([fe80::5889:7208:6024:bbcf]) by PH0PR11MB5144.namprd11.prod.outlook.com
 ([fe80::5889:7208:6024:bbcf%4]) with mapi id 15.20.8093.023; Sat, 26 Oct 2024
 16:45:31 +0000
From: "Kuruvinakunnel, George" <george.kuruvinakunnel@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Richard Cochran
	<richardcochran@gmail.com>, Sriram Yagnaraman
	<sriram.yagnaraman@ericsson.com>, Benjamin Steinke
	<benjamin.steinke@woks-audio.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Sriram
 Yagnaraman <sriram.yagnaraman@est.tech>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v9 6/6] igb: Add AF_XDP
 zero-copy Tx support
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v9 6/6] igb: Add AF_XDP
 zero-copy Tx support
Thread-Index: AQHbITlqAQsFik4ytku6ehK3PCLIU7KZSe5A
Date: Sat, 26 Oct 2024 16:45:31 +0000
Message-ID: <PH0PR11MB51448FE0C7FDD3C1B00D8DC6E2482@PH0PR11MB5144.namprd11.prod.outlook.com>
References: <20241018-b4-igb_zero_copy-v9-0-da139d78d796@linutronix.de>
 <20241018-b4-igb_zero_copy-v9-6-da139d78d796@linutronix.de>
In-Reply-To: <20241018-b4-igb_zero_copy-v9-6-da139d78d796@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5144:EE_|DM6PR11MB4676:EE_
x-ms-office365-filtering-correlation-id: 76999666-a1b2-4608-7231-08dcf5dd9b03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bjdNcXFKSk9NMWF1bFBCMEdFMEVlRFFhZ1dpNEVpSHRMWkkxZkIxaXFqMGZl?=
 =?utf-8?B?Nkh3SHVMZkRVR3ZQUG93TjdHb3BZcnlxT1ZIQW5XRDdQWHNiUUJ2ZW5jelE5?=
 =?utf-8?B?WCtBQmdVYkZNQjlyQVFJdmdnYUNadndnVHVOSElWTDlQSTBFVnFQTG1QZXpk?=
 =?utf-8?B?dmpzRTdlQm1GZmxDQkhzSzBuWWpBRkxNaCtlaFRqVDBlTS9uNTc3VDFHcWUx?=
 =?utf-8?B?RnNkQ01RTWM4ZTgra0dkS3A5Q0hyNEU0MFE4TTl3TGh2ekdtTkVYbW9UcXcx?=
 =?utf-8?B?Y0gxc2l1c2RDM2Z2WHo4NlBFeWNQclBVaU9ORTNzRjhTMk9xbFFKV1hFRWh2?=
 =?utf-8?B?TUd1ZGlDdTM3SW44TWh4S1ZjS095djRVUTlzd1NHeFZxeFpFdkdLbXk1YWJx?=
 =?utf-8?B?Z0d2RWRPWFdYTjZPelVncVNPcHVrZ3NGUFBPK1lCK0syRlQwSTMrREJId0hl?=
 =?utf-8?B?NHF1bDF4Wk5EVGlpNnNmUUVwZmY4NU9heFlFaXNnajBNd1YvTjlJZUlHQlh2?=
 =?utf-8?B?Mk9xaTlFVEZEZ2tyeUU0eDZvT2VvckNEaDJJc0Z4V2hKZXhKMUVPUEJkenAx?=
 =?utf-8?B?cGUwWS9tV0lMNzBiNkM1bHBtbFlqVjdURFd5Yy9aOWZvbXMyVHdvZWUwdTZt?=
 =?utf-8?B?emxld3Z1Tm9oZ0c2elN3dk9vbkUyeS83aEs5YU5weXJHcVhmcm9IU2FKU1Zh?=
 =?utf-8?B?cFRCcHRGczhXU3BEdHNWc21TK1JJdytjMC9XcHFmKzNhbjcxQklFVWhPME9y?=
 =?utf-8?B?YndIaHltUWZYNUdZQjRlSGNOK2laREhwQllYYmI2OWZGUEJCamhZNjI4MG9N?=
 =?utf-8?B?UGRIUHJURFNyK2xmYnU3eXFJbmVjcGxlYVBEVUlWM204OW5JWkNFWlFPQzVR?=
 =?utf-8?B?MXVJdmdhS1A4ZzRMTENjV3VLbnhENEQ1cnNubWVlVGVuMHRCUXlqQXVTZ3hZ?=
 =?utf-8?B?YnQvdFE4VFpoQitSR2lMTWVlQVFWRnFBeC9DOEREaWVNeStUUTA0UVZjVGdq?=
 =?utf-8?B?ZUFLVFoyUjNVODJZUWwxSitnT2JTZ2Q3K3lJNHNhSWdTYjBDZVFiUzQxM3I4?=
 =?utf-8?B?MkluYW9VMTcvR0dndUsycVJaUXhnVUtNc1lBdzFIL0thS1FLb3ZyOXp3bmgw?=
 =?utf-8?B?eTJ2cHNFamdXNDZLNzQzMWhlZ0xDUXdTUlZvYlRJVmZIaU83OFc2RUlFem91?=
 =?utf-8?B?Q0NQNTZnYmQxaDRscFpiRmM1aTU1TmtsR3dNcE5BMStlbVozcnU2T25zZ1N3?=
 =?utf-8?B?OXh6dmpHL3ducTg0UVVFQXlRaGFVNDd6VXZ1cElQZTl1dTJkcnJiTS81ZTQ5?=
 =?utf-8?B?MUZQM2RoQjVlNFg2RmJoaE44OHVvR09MaDIwSFppUXB6c3p3VDg1NXQ3QW1C?=
 =?utf-8?B?V2RxaWJOKyt1bHRRQVlTQ2psOVJmMm8wMGQ3WkM5Ly82bndaOEZxWUJ1Lzgy?=
 =?utf-8?B?Q0lVdVpwNnBSN2hnUTBqRENOeTRmejNjdzZlbHJ5QnEvb0cwbkY4eVE1UExL?=
 =?utf-8?B?bkpHMHFZbVA4aGVOTy9PK2hoejRhT1JEVWhsOUx0eDdVU0ZFMTdvTUNGQUd3?=
 =?utf-8?B?dWZkMjdaL1BhZ1F5Rkp2NVpvQ0FYNDF0cDlzb0xvSXZaUzlvVnh3Qm5jbXNM?=
 =?utf-8?B?Z3RpMGJMK2hqZkoxTkRaWmc0RE5LVEtTb1JxRks3YmZIcjIzbTNaZVU1cTFI?=
 =?utf-8?B?elR3eGVtNmRhcmVJZlNOaDdGc0NVbHAwOFU0RDh4OUl5T2ZlNXI1M1ZRTk54?=
 =?utf-8?B?VWVCajlja21aT1F6ZXBPSEdWMFp0S25Hek5EZkVtWkFWSmdzbnZKbXFHWUYw?=
 =?utf-8?Q?+rgZeO7iiREX0qIR/TH5+UFvVnsUuyz3uMifI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5144.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXNTNisvWGc5dldCUzJRN2ltYXlNclcxOVFKWjZsaXcwQisrZitlMEtLVFhI?=
 =?utf-8?B?Nit2Y3owSmQyMVFCcG11YXBwQmtrNDUvcll5UmNRUFJ3SzROMnczWXBnMGtr?=
 =?utf-8?B?T0dDaVNmajZYd3VMcm8raWR3T0JBL2c0OVdDL1I2czVjN1NXK2IySVlJV0FG?=
 =?utf-8?B?U2RqYlYvSy9qenFUR3Jhemx6aU9maTI1dm1QNVErODRLbmZkRDFwL0t5Kzhl?=
 =?utf-8?B?R1UxV0RDMDFDVXp4RENzQkVVbUNrcll6MVFpbDBENnpMQy9sTElIV0x5bUQ0?=
 =?utf-8?B?SU9qVktTMnhtQ1gwY1JJSmNoZW9YbytVcEN4WjI4dVVDVjNwZGRYalhmVkNS?=
 =?utf-8?B?RGtIbjNIZ3B1Y0hmQzdaT3pDRW0rRjUxYkZOUnNTdkpQbFdYTzNQS29ZRk1O?=
 =?utf-8?B?dUc4Wi8xV2JhRlZiQ1NqNXk0cmoxYlFpV2FwMDJ2UTduSzd6K2drNmQvaUJG?=
 =?utf-8?B?ZEZLQ0d3K0g3N3VGdFN5RDJBZVVIVDFTV3BKV05RMytNN2JOeXJldDNXcjdl?=
 =?utf-8?B?bWlyR25jYkhwS09zSmRlQkpybVJEWnJDRUMxVGVKaTdRUjUyQlhNdlQ3NDQr?=
 =?utf-8?B?b0xoWElJTUZ6VWg5M0U2Uzl5RWFGQW4wckxLL1A1UkNKNnlwSWxlSXRYRkRJ?=
 =?utf-8?B?RGc1dDRpYlJZbWR1cHFuVm5XZVFadVdjblkxMnM4WG5Na3NwN0hhUUhHUVNn?=
 =?utf-8?B?M3ZlOUI4cDNaajZueGNBeEVkMk85RHcrRUczcVkvYzVSYzlvVVBoV1NZZWE3?=
 =?utf-8?B?N2RudHNVdlRrd0pkYjNiZUFqRDlaaGlNTkx2WUxlVmRiQkRKQTJrM3ZKNGhi?=
 =?utf-8?B?M3ByR09VdUsyTjJjbDFKMGxTditoSVBFWHJ5OWdMWG9JM1JSNzhkd1M1bTRu?=
 =?utf-8?B?ZHdKSmFkUnRhbXhuTmhYRkVGeDhMRWJaTGlKbmhZOUVWZmZYMHp0NVMrSzgw?=
 =?utf-8?B?VC90SGFSQWYrM2psRzduaHZua1QwWFExaXFqVG9UVVh3VUIyRE5EeDhEME9i?=
 =?utf-8?B?bFB2dTgwVi8rUWZXeE9IMlpoL2w4YUo2UDVQR1hhMnUvRVdKcE5qY3hVMkZi?=
 =?utf-8?B?RzVoM251QVdLaGl6SndIYXp0bHdxcHhySm1WUnVuL21nQUZsRHRudlZOM3Z1?=
 =?utf-8?B?ZU9veW9UaGducms1b3cyRnR4alQ0L3ZXNEJMT1M2ZTNlazlpa1hJNk84cWwz?=
 =?utf-8?B?WkNKdEZFSEZyYWd4cjBObW1mbnUwWjVkYk1IbllZa1pyaTd3bmxRQ3REdlo3?=
 =?utf-8?B?clh4MXJqdFk1VTljcEoyRVRaUlY4MUxJV0NKTnk2dHE0YlU2eG9tMDY4V2k0?=
 =?utf-8?B?YmxEY2tJNUgwdEFSdk5zeWV3NHVwdGFkYnZQVzRhSHRPUXBVL0tXTXp6Qm5P?=
 =?utf-8?B?SzdkdXh6SzM1OWFWWjRWSVpYck5JcHVlYVV1dUF3YUtIZjRKTjVkYWhGamNm?=
 =?utf-8?B?QW9SQVJYNG95Wk5rY2dmOTI2Y1hmd1g2Nk9JU1RYUWEralp1Yi9YVmRneUpK?=
 =?utf-8?B?c0ZGZVlQR0Y0SWM0OXdYRXUrOEdYeCtndDlFTi84dEVIby94UlR4ZW9ITmU2?=
 =?utf-8?B?WFhlMzVoNVVOdU5XQ21veHRkWGVtdEpiVnc3dURRMTNWd3JyN1pkWVVmRUYv?=
 =?utf-8?B?V29zQkoydnBhNDAzN0h2SERqM1h3Tm9hSEZsV3VudGdqeXZwQjMzNWlsL2Rj?=
 =?utf-8?B?SEZmUUw3b1V1QksvdWoveTRDVDBzTUx0VVh5Q1BDbFNmRyt6L1ZadkVmTmxq?=
 =?utf-8?B?bmhUUVpEeSt1VUY3dzNGRFpuWHNla2lQaTZjcSs4NVJ4Z2xSVlJESEszdDZW?=
 =?utf-8?B?OWp0cG0rck5UYTNVdDhIc1RzQTl1V21HUDBQM2tNQnA1dmdpSkxxYUZ6QjlS?=
 =?utf-8?B?OFI5SlhqejNtK2EzdkZjL0p2ZkNEWWVsZ1FJZjh2Tmc4WFhBY3k1amtGOWpN?=
 =?utf-8?B?Q2pyamM4Q1R1N3crS09CWTJ1MWExSVlOOWdOMW9LNGRuQmFEbUNUc1NBNjRl?=
 =?utf-8?B?cFdIV0toQVNsTEFiRHQ0TGtxQm1ZL3BtSTFGL0FNeDUwQzZjRUtrcnVSZnJa?=
 =?utf-8?B?cysrNmVmQUV1RU05cGx4bm02UldhVldBSGRmVDd4WExCclBxd0oyQ2JlUDlY?=
 =?utf-8?B?WFdBYUVTTXEwU1JZc0NmcmlrUFVUd3VJeDlSTzlzS1lhMTVUVVpMOTF4L1V1?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5144.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76999666-a1b2-4608-7231-08dcf5dd9b03
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2024 16:45:31.6956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kE6dgFZjAbbGTjxsTNPixB9It6iiSHOwwREmV5XsEXuTdoLv/H7RsuTUqTlMoL8rK65yJbw9fcFZq4XrnXtz7v4Q0HMeq/brDeaTPvc70nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4676
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBLdXJ0IEth
bnplbmJhY2gNCj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDE4LCAyMDI0IDE6NDAgQU0NCj4gVG86
IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IEtpdHN6ZWws
IFByemVteXNsYXcNCj4gPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+DQo+IENjOiBEYXZp
ZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQNCj4gPGVkdW1h
emV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8g
QWJlbmkNCj4gPHBhYmVuaUByZWRoYXQuY29tPjsgQWxleGVpIFN0YXJvdm9pdG92IDxhc3RAa2Vy
bmVsLm9yZz47IERhbmllbA0KPiBCb3JrbWFubiA8ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+OyBKZXNw
ZXIgRGFuZ2FhcmQgQnJvdWVyDQo+IDxoYXdrQGtlcm5lbC5vcmc+OyBKb2huIEZhc3RhYmVuZCA8
am9obi5mYXN0YWJlbmRAZ21haWwuY29tPjsgUmljaGFyZA0KPiBDb2NocmFuIDxyaWNoYXJkY29j
aHJhbkBnbWFpbC5jb20+OyBTcmlyYW0gWWFnbmFyYW1hbg0KPiA8c3JpcmFtLnlhZ25hcmFtYW5A
ZXJpY3Nzb24uY29tPjsgQmVuamFtaW4gU3RlaW5rZQ0KPiA8YmVuamFtaW4uc3RlaW5rZUB3b2tz
LWF1ZGlvLmNvbT47IFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3INCj4gPGJpZ2Vhc3lAbGludXRy
b25peC5kZT47IEZpamFsa293c2tpLCBNYWNpZWogPG1hY2llai5maWphbGtvd3NraUBpbnRlbC5j
b20+Ow0KPiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZzsNCj4gYnBmQHZnZXIua2VybmVsLm9yZzsgU3JpcmFtIFlhZ25hcmFtYW4gPHNyaXJh
bS55YWduYXJhbWFuQGVzdC50ZWNoPjsNCj4gS3VydCBLYW56ZW5iYWNoIDxrdXJ0QGxpbnV0cm9u
aXguZGU+DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBpd2wtbmV4dCB2OSA2
LzZdIGlnYjogQWRkIEFGX1hEUCB6ZXJvLWNvcHkNCj4gVHggc3VwcG9ydA0KPiANCj4gRnJvbTog
U3JpcmFtIFlhZ25hcmFtYW4gPHNyaXJhbS55YWduYXJhbWFuQGVzdC50ZWNoPg0KPiANCj4gQWRk
IHN1cHBvcnQgZm9yIEFGX1hEUCB6ZXJvLWNvcHkgdHJhbnNtaXQgcGF0aC4NCj4gDQo+IEEgbmV3
IFRYIGJ1ZmZlciB0eXBlIElHQl9UWVBFX1hTSyBpcyBpbnRyb2R1Y2VkIHRvIGluZGljYXRlIHRo
YXQgdGhlIFR4IGZyYW1lDQo+IHdhcyBhbGxvY2F0ZWQgZnJvbSB0aGUgeHNrIGJ1ZmYgcG9vbCwg
c28gaWdiX2NsZWFuX3R4X3JpbmcoKSBhbmQNCj4gaWdiX2NsZWFuX3R4X2lycSgpIGNhbiBjbGVh
biB0aGUgYnVmZmVycyBjb3JyZWN0bHkgYmFzZWQgb24gdHlwZS4NCj4gDQo+IGlnYl94bWl0X3pj
KCkgcGVyZm9ybXMgdGhlIGFjdHVhbCBwYWNrZXQgdHJhbnNtaXQgd2hlbiBBRl9YRFAgemVyby1j
b3B5IGlzDQo+IGVuYWJsZWQuIFdlIHNoYXJlIHRoZSBUWCByaW5nIGJldHdlZW4gc2xvdyBwYXRo
LCBYRFAgYW5kIEFGX1hEUCB6ZXJvLQ0KPiBjb3B5LCBzbyB3ZSB1c2UgdGhlIG5ldGRldiBxdWV1
ZSBsb2NrIHRvIGVuc3VyZSBtdXR1YWwgZXhjbHVzaW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
U3JpcmFtIFlhZ25hcmFtYW4gPHNyaXJhbS55YWduYXJhbWFuQGVzdC50ZWNoPg0KPiBbS3VydDog
U2V0IG9saW5mb19zdGF0dXMgaW4gaWdiX3htaXRfemMoKSBzbyB0aGF0IGZyYW1lcyBhcmUgdHJh
bnNtaXR0ZWQsDQo+ICAgICAgICBVc2UgUkVBRF9PTkNFKCkgZm9yIHhza19wb29sIGFuZCBjaGVj
ayBUeCBkaXNhYmxlZCBhbmQgY2FycmllciBpbg0KPiAgICAgICAgaWdiX3htaXRfemMoKSwgQWRk
IEZJWE1FIGZvciBSUyBiaXRdDQo+IFNpZ25lZC1vZmYtYnk6IEt1cnQgS2FuemVuYmFjaCA8a3Vy
dEBsaW51dHJvbml4LmRlPg0KPiBSZXZpZXdlZC1ieTogTWFjaWVqIEZpamFsa293c2tpIDxtYWNp
ZWouZmlqYWxrb3dza2lAaW50ZWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2lnYi9pZ2IuaCAgICAgIHwgIDIgKw0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50
ZWwvaWdiL2lnYl9tYWluLmMgfCA2MQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0N
Cj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2lnYl94c2suYyAgfCA2Mw0KPiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDExNiBpbnNl
cnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gDQoNClRlc3RlZC1ieTogR2VvcmdlIEt1cnV2
aW5ha3VubmVsIDxnZW9yZ2Uua3VydXZpbmFrdW5uZWxAaW50ZWwuY29tPg0K

