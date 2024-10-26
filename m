Return-Path: <bpf+bounces-43246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3DD9B19E5
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 18:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B231C21428
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 16:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EA21D0BB2;
	Sat, 26 Oct 2024 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M2y1myo8"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D1F168BE;
	Sat, 26 Oct 2024 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729961677; cv=fail; b=Crpk5wFNEjcTJUEEmQEmoWyaRhZA+rK54JRWMCVHAIeLUUt+xME2wjXvVY9GC9nWUgFSjfWPSjSkU3XmhM0qYEsOnfaOdBBu5oDmZA7ZPlNoPOiBtymYPycZVhizLoMiyQh0cTDs4UM5rh94wOr6C48UpUl353AomCDiaW5Pq1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729961677; c=relaxed/simple;
	bh=ybDnTHr+sIN1Xgvu9MyLBc6lkT0f91xsOLc3KJxjHMg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=czUXRwzWCqEWlQzp7GuWusSxWVovHLqc4329Tow6iL+WQMi8P9W/kx1ISGQnzPtmfagjBjE4iRMcMVHmlULubLo3fNzPEgGyUplNxoc8sfsLdjfM2+ahMSQsJ8yCdFLAqFHUXPUbcQIX6NM0LcDJshfnsEj/ZcSyOsMsOT8vt74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M2y1myo8; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729961675; x=1761497675;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ybDnTHr+sIN1Xgvu9MyLBc6lkT0f91xsOLc3KJxjHMg=;
  b=M2y1myo8qYo011J0OCh4YZlaU1GWFITJG0Q8h/njyTBzM1SfYPPTMpaN
   61/mhyDJt2SQiZaPiTljAtsTgFDE/u5qherLfkVbmxwJJssr2Tq4wLHKl
   S9e8DFaZIivdlUKgLj0R1C8HmycQ9Kp0n2l1XVDUzyY7ZOmbRjNg+i5ZJ
   7//UzJqUsMKzCECd7N+IjIn6Et7i4DfELD+uRJZvEli52b6WCwTCC/SGS
   tOm1dfwNEuam+E11zCoH9PPSl/C3XFMEVFdvAFQ7RpMgSW0r6bfcKiXDh
   CEVKLUtGX8xSaj8ExOAAL6ftIfyY19CL4wEkK7bf9BFcsTgiD1VifEIsu
   w==;
X-CSE-ConnectionGUID: D/xbiwrmStyA7x9IFYlw+w==
X-CSE-MsgGUID: u6gg/+15SgerK40cKFwikg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40719847"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40719847"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 09:54:34 -0700
X-CSE-ConnectionGUID: pEqz/RZwRPuKPRnHsHYRyg==
X-CSE-MsgGUID: 39JeorjqQ3SnkZCM7RoD1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,235,1725346800"; 
   d="scan'208";a="80796980"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2024 09:54:32 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 26 Oct 2024 09:54:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 26 Oct 2024 09:54:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 26 Oct 2024 09:54:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5uMyMKidK2D5Sg04sIQu/2+omlChug0c47/w7H2bVtWK0b7SNlkSkQmrHn8dw7xvqHG0zrw7tVCB5R7y6Eop3hudDf9r5ayQM1KH25kXErk/KqyMqEk2VEovEea6cJlXPLNqEPu2pbG80XmqHglYYJQpkxVdHzGBJQqT42LDiOEoKKeY+nVShxSDmSNcunkXiuB1r5uXIl4Eev6MwQu3e2HDdpmLkzLpk+TLYNzzCVjRe0yVI9fXhKcqkr7MCXA62WFO4NmmfjybEfspXJYQEitoVjB2ASIq6MqDV6SU++ve923rAec65il/1jxoyVG2iAsu1um8i3Q6YSlsLe9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybDnTHr+sIN1Xgvu9MyLBc6lkT0f91xsOLc3KJxjHMg=;
 b=Nkp4JOqoddbBb+cMEQNtX5spwxKuAhCvpIG3TQM68TqT2q7H9B/mprvDKDuZ0wltvWZ/I4ld4Y8S70lD/+KzUlvnvV6Efn6nH1nrjNXt36ZPIedvM9aCzzPlq9FI0SjFlxHAjS48fHIcidzrNF/NwCNytbYX5QC2ZJUKSaUod/3fsD6KlKeSwebCuTBwt/imtwAFcno+201TF63qqb4/93af4OV0f+ggxfxY97UtkM4Ry+JuDCVV+bGyoCSHGQqrD7bANAs6IYQRYyS8jNmlTZqJv2KXDTzMJwxT8ra0PMMB6UznDK76sZs2ev70/HupEgFfoatrb0/DKZjPSTLnmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5144.namprd11.prod.outlook.com (2603:10b6:510:3e::20)
 by CH3PR11MB8589.namprd11.prod.outlook.com (2603:10b6:610:1ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Sat, 26 Oct
 2024 16:54:22 +0000
Received: from PH0PR11MB5144.namprd11.prod.outlook.com
 ([fe80::5889:7208:6024:bbcf]) by PH0PR11MB5144.namprd11.prod.outlook.com
 ([fe80::5889:7208:6024:bbcf%4]) with mapi id 15.20.8093.023; Sat, 26 Oct 2024
 16:54:22 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v9 3/6] igb: Introduce XSK data
 structures and helpers
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v9 3/6] igb: Introduce XSK
 data structures and helpers
Thread-Index: AQHbITlpT64oy5r5aEOHsdYswW/p8bKZTMHg
Date: Sat, 26 Oct 2024 16:54:22 +0000
Message-ID: <PH0PR11MB514419E81D61FD0AC3704CF2E2482@PH0PR11MB5144.namprd11.prod.outlook.com>
References: <20241018-b4-igb_zero_copy-v9-0-da139d78d796@linutronix.de>
 <20241018-b4-igb_zero_copy-v9-3-da139d78d796@linutronix.de>
In-Reply-To: <20241018-b4-igb_zero_copy-v9-3-da139d78d796@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5144:EE_|CH3PR11MB8589:EE_
x-ms-office365-filtering-correlation-id: 7fcbf1ec-6396-4cec-0b07-08dcf5ded738
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cVBsS0VTQ1lyUEczTUVqNnNHalFKVm40SThqSXNaZmp0NHJ2RTRQbWJNZWpv?=
 =?utf-8?B?ci82M3ZoamI3bFFIUkV4dGZNOUpINUF3MzE4M3lKdjhhNnlualJBRnRVZlVm?=
 =?utf-8?B?MUNXS1NXMCtGbDV4WEE1M0Zza0dzdHlVWGxvUnZMNkgrQ2h3emM0S2xEN0tt?=
 =?utf-8?B?ZFh6RFp1cmdONnlYN000UDNRZExkV254RnZXVVY1Nkc3NjZyU3VYamN6Q09E?=
 =?utf-8?B?LzRSTHBZWnd0d2ZIbEtvUEQwd2FjS1pRSHZ0Q3djbkJVaGNhOUtzWG5SaTcy?=
 =?utf-8?B?eUlNc3Bhd213UnJvZkExS2lSeVRrNmJrdW1vK1FZek5Td0dyTE5FbnJERGZ5?=
 =?utf-8?B?Y3hCbDF5dnlvMm9FcEhyQWk0YVNGYWc1eFcxc1NvRkcxdytSWWp1Wi82WUZD?=
 =?utf-8?B?VmlrYUljVjdvQnlOUHdBblVFRWllbjV3Q1A5WDUvS3JJQ0tFR1p2TGxRNkhP?=
 =?utf-8?B?SHBmbXR0cERjbkI5WWdmcXhrc0VoUFJ5aGVkUkFsRWg2RDZnSWtkbGJld0VS?=
 =?utf-8?B?Wk5JbjF3cWQzZjBKaWwySVBlb0tNZldKZFpMc21CY3FBaXN5bDFQUGE2OU92?=
 =?utf-8?B?b0Z3SVVwTkxEYmFQVDF4bW80d3FuUkJGanEvY0tuN1pVTHY5L3hiRU9ucnBa?=
 =?utf-8?B?RWhJank4Y0tlN1lsM3ZIV1N3WkFidkQwY0g4UjliMFBUWWdsaDl4QWFZbm8y?=
 =?utf-8?B?MWJpVCtTTHZKZ25OWXF6MURLMURYQWt3RDJseWp2OFpLNk9HcjZsR1Y0WFQ1?=
 =?utf-8?B?N2VsTHdUK2FxWHQxRm53S0x4MWVoWmcwWWJSd3FIR0RYRHVoTnk0aGM1RDVp?=
 =?utf-8?B?VkUxSExBRUdxbGd3VXhZaHhSWWkvMzQ2cnp3dk5RVncyWEVkNGw1WWpmdzNL?=
 =?utf-8?B?SldkQWZCR04xOEtlZ0wvdlRWOTFQWDdNd3hQbWt6TXVkSmNBRVFCeDJWemVt?=
 =?utf-8?B?bnRXZjEwYTN2TWhmbTlSL1FLZkhod3lGQUZEdjdFVHlWdDBYbm9UQXdHd0hV?=
 =?utf-8?B?bVRlakFYWHIzaXlaamMvaFVNYk9vTHpGZW1YYVNsdTd5S2pYeC8wa1hVanRQ?=
 =?utf-8?B?RTFLME1pcVIrM3NpRyszUnhnQVpNOWMyc2Z2OTJPbUJpbHVkMVdoZFEzK2Q5?=
 =?utf-8?B?VXJKM3FhaFVPQ0E2alhPa3VyVkVjZGtjbUMrVVpDVDZKNDU2QjZVbW05Q2Ux?=
 =?utf-8?B?T2oxSVFyV0pPOWF4NkRQQVgxOWlkcnJhTlMraGtVNjZtaFd0cWhXMzF5VXVB?=
 =?utf-8?B?YXpKR1NmUlNrMlRoVjZQVjE1a2QvaU5XNnNJRmlYYkJ6anUrS3QwT3FMRllX?=
 =?utf-8?B?YXFsaS9PanU5RmIzVnE2YUVDSldSdjFSbVVaNkdseDZGemxlZElZQzNvd0FC?=
 =?utf-8?B?bWczTmV4QVFvamloTG9Nd0RvejZVZnliUVhYR1R3SHhqaTdJUEw2S0d1eHAx?=
 =?utf-8?B?WXFrdHc5WTJOWXd2QWdPT3d6T3A5eXZCd056SXBNQTNXbFNLM2dkZEZXclZy?=
 =?utf-8?B?Mm1pU0lqanVWRzZmZzgwRGNNWjUxd0svSlRBRzZSdmRtUHJwRUJJZ2N3NDRU?=
 =?utf-8?B?ZmRGRXdzQjFyNFZ6Ui9KNDFQL3ZPRXZuREpzVU56YS8wdkt0QXJhTWl3RGYw?=
 =?utf-8?B?SzY3UUxHUXVaeGpMbytqc2FmMC81bTlHdWFJb3NrT2lER0JrMzBhWFNGTEt3?=
 =?utf-8?B?ZWNmQjNxNGQ1ekJIc0srTENQeFFBbENJM0tFYUMyaHkwOW5LY0IzcnVJTFdq?=
 =?utf-8?B?WjJidXBQekpLcHN3VXJyTzEwT3FOeGlQbVc5UkxEcm51NXdTd3B4cHZabkJp?=
 =?utf-8?Q?g8g1ZwzjwCo+Bn6ZfbMF4oBhWfbvvpg2LzjR0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5144.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVRPeXpDMytlQ0FTd3hKS2JwVGpPV0o2dko0SWFZMk4va0ZOcURGN1BlMlJT?=
 =?utf-8?B?dlczY3hqbHZKZi9TUTdWcWFSbjRTUEFhek9wOWFRQytXOTc0UjV1MG9JNEFB?=
 =?utf-8?B?c2hJOTcvbE5jMWdPaXBSMDdzN25TeDhVdmVPNGgvbENCNjVybWFqenRRSkc2?=
 =?utf-8?B?aGdWdmNXNDdWQXBrRURtcERXbzhVOUZYRWFhM21qL2RZKzJUQ3lQTHdUcDlW?=
 =?utf-8?B?WlBmVDh5cmFsTDVJdlJtUVFQdFBzSXBxR3hGeEM4Nkx4RTlQT0RqU3lXZGRn?=
 =?utf-8?B?T1kyQkhRRHA0ODJKM09OWFZsMDliMExTeEIyc3VVMnRWMk5EaUo4RjcxUXNX?=
 =?utf-8?B?b0NOc21SUnlZV1NycmlSbEJFMHdQbHhteWg4SkE1eXl1dFlzSndXM0tjdWZI?=
 =?utf-8?B?ZmVGUnlKM05sUWc0VXBVMEh0VnlzcHFVaU9NeUE5aDBiUlo5OW1lZGVzUHc3?=
 =?utf-8?B?Uy91MjRWdFI1b2NheDVLUWZPdHZucVBVMFFzMlNOa0didTdaR2lUVzlqb3Y1?=
 =?utf-8?B?RTZnTnpJeWVqMGVkMTkzV3F0NnJTU21PQ3p3MDZaUzVEb295eUlFOURBRFd3?=
 =?utf-8?B?eDU5MjRJTE5nbkg2S0I3L0svSHFmQlNPZCtqSkQ2QkVITVg4L0xoRG05WjNG?=
 =?utf-8?B?NGh5Qm0veW5tTjJsM0FxVFZQMElRSThvNXVjZjBsUldMbUFqemoydFg3dXdw?=
 =?utf-8?B?cnVHOXFPckc5ODMydmZZRHlTM29kZ01NL0VNblZZUWFZeUxldmpncDQraHBh?=
 =?utf-8?B?MVdiUXVzeW5VU1Nsd1dxYUx6UzFTaTBXTTFJSyt1a25jU3pUaVFkbHE5RzF2?=
 =?utf-8?B?Vkp6K1k0b2ZIK00xdFlZZWlkckRrRmNjNmhOTHhPSk5IQjR1NnJCQzVHejZv?=
 =?utf-8?B?WHo4cXdlNHE1Rit0RFBZOGpFMmRjMVViMGtPVVNLdm1vQWlHbjFyMmlXb0N6?=
 =?utf-8?B?ZEFBbStacEI5Q2ZwNENDL0Zoam5FbWY1ZGN6cHFScmZFbmd2QktSUWFuNlkx?=
 =?utf-8?B?Sm8zdzNySkc1ZzJmUGcycVJLTENYdVJkZzhESWpsYkU1WDBBY2ZSTkxaVkov?=
 =?utf-8?B?T3N0STJuajNxc1I3dU02WkVLTHkyb0tGa3VHT0tobUtyeHJNVEUxclBSNUVw?=
 =?utf-8?B?WWJFMUQ2bG92ai84UWVYVC9DUUI4M3pIN056ZFB4bVNFZlVYT01nRTdGUVRR?=
 =?utf-8?B?Vm8wQXdRRm1pNjZJMHV2TjRjdEwyQWFrbFdvd0RKOFlFSUEwems1YXRPU1ZO?=
 =?utf-8?B?L2lSQks1UWRzTEhkd2RJZVVNaHVaVFpPZ2ZlZmo1TWE3ZU55M3ZWa1hmcW16?=
 =?utf-8?B?WU1idit6ajJ3OHlZVXgwNEF2UC9seXd4SVZkMTQ1QmZxSVZGNVRiUlU4eWhO?=
 =?utf-8?B?bEI1dDBoOFBaVEdLL3RXY3NXWERWSlN1RGZldzlWN3ZOSG5lbE9sb0hDN3VV?=
 =?utf-8?B?cFhNemRqV3VVZGlXaXVIMUpOeHFSSGtYVnBqYnpnT1EzWlNWQ2I4K04waWh2?=
 =?utf-8?B?RjV5Nk4wZWpRVmNvY0JMTVJpVzIyYThna2V0V05jZFRhclplcWxCNUVhZ3lu?=
 =?utf-8?B?OUNEN05BcTZoekhtTjJKTFNBUVpIVkVmUmlMdnRoRUQ3WUs4SnF1ZWNVV25O?=
 =?utf-8?B?eno3eW1rVVdVb2dhc01BSThHanBuSktxY3piS1BVWEdOWXZVRHFKWXQvVjB1?=
 =?utf-8?B?M2xrckx4ZXNaTHJyN0lMWXJBTGJkNlpYb0sxNkJDMHArTm4xTVJoR29ndUpN?=
 =?utf-8?B?dnN6SXZha2crdWVYS2dsYU1TV3FlSUZjeGJjRVJjOTFIeXFyQTR4NmR2dERl?=
 =?utf-8?B?a3dGb21rRlZCeU5LbDVnaDdaTVZKd3pWeXoxbk1WUmZKNE82NjlTc0xxV1J4?=
 =?utf-8?B?eGJMa1ZFWUpNaWs3eG5SRE5sbk0wcDNMeDFtK3V6V3k2YnNwTW5QcWU4RWMy?=
 =?utf-8?B?czJmY0cyUktnWEJyaGo0UjlUS2ZYeW1uQXlsY055T0svVCtyYUFFMy9LdTYv?=
 =?utf-8?B?RVo5cGpzUVVhYzJIekhIM3plMHY2eGF0Q294aEhUNEdCT2UzakJ0Z3BiMytv?=
 =?utf-8?B?UzZnSlFuOEJNREREVmVWWGlqMlV0RUNzVTl4UUNOQ1dCQ2lERGRQOWllWk9H?=
 =?utf-8?B?YjMrRkQrRTZ1YURVbmt3dzFPUDNNZ3lKaGNVbk10MnU1ZDk5cWdPTzZPVzJz?=
 =?utf-8?B?SVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcbf1ec-6396-4cec-0b07-08dcf5ded738
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2024 16:54:22.1629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KaixpIhAq6RR4x41tsYXzDANt0/zTQrLvQplALOWY8mrxNFk9sazkMhB5lmIhHpNnKBxMQlF2OLAVdde3qd0bEj1Ermr280StioKgskWjEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8589
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
aXguZGU+DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBpd2wtbmV4dCB2OSAz
LzZdIGlnYjogSW50cm9kdWNlIFhTSyBkYXRhDQo+IHN0cnVjdHVyZXMgYW5kIGhlbHBlcnMNCj4g
DQo+IEZyb206IFNyaXJhbSBZYWduYXJhbWFuIDxzcmlyYW0ueWFnbmFyYW1hbkBlc3QudGVjaD4N
Cj4gDQo+IEFkZCB0aGUgZm9sbG93aW5nIHJpbmcgZmxhZzoNCj4gLSBJR0JfUklOR19GTEFHX1RY
X0RJU0FCTEVEICh3aGVuIHhzayBwb29sIGlzIGJlaW5nIHNldHVwKQ0KPiANCj4gQWRkIGEgeGRw
X2J1ZmYgYXJyYXkgZm9yIHVzZSB3aXRoIFhTSyByZWNlaXZlIGJhdGNoIEFQSSwgYW5kIGEgcG9p
bnRlciB0bw0KPiB4c2tfcG9vbCBpbiBpZ2JfYWRhcHRlci4NCj4gDQo+IEFkZCBlbmFibGUvZGlz
YWJsZSBmdW5jdGlvbnMgZm9yIFRYIGFuZCBSWCByaW5ncy4NCj4gQWRkIGVuYWJsZS9kaXNhYmxl
IGZ1bmN0aW9ucyBmb3IgWFNLIHBvb2wuDQo+IEFkZCB4c2sgd2FrZXVwIGZ1bmN0aW9uLg0KPiAN
Cj4gTm9uZSBvZiB0aGUgYWJvdmUgZnVuY3Rpb25hbGl0eSB3aWxsIGJlIGFjdGl2ZSB1bnRpbA0K
PiBORVRERVZfWERQX0FDVF9YU0tfWkVST0NPUFkgaXMgYWR2ZXJ0aXNlZCBpbiBuZXRkZXYtPnhk
cF9mZWF0dXJlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNyaXJhbSBZYWduYXJhbWFuIDxzcmly
YW0ueWFnbmFyYW1hbkBlc3QudGVjaD4NCj4gW0t1cnQ6IEFkZCBSRUFEL1dSSVRFX09OQ0UoKSwg
c3luY2hyb25pemVfbmV0KCksDQo+ICAgICAgICByZW1vdmUgSUdCX1JJTkdfRkxBR19BRl9YRFBf
WkNdDQo+IFNpZ25lZC1vZmYtYnk6IEt1cnQgS2FuemVuYmFjaCA8a3VydEBsaW51dHJvbml4LmRl
Pg0KPiBSZXZpZXdlZC1ieTogTWFjaWVqIEZpamFsa293c2tpIDxtYWNpZWouZmlqYWxrb3dza2lA
aW50ZWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYi9NYWtl
ZmlsZSAgIHwgICAyICstDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2IvaWdiLmgg
ICAgICB8ICAxMyArLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2lnYl9tYWlu
LmMgfCAgIDkgKysNCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYi9pZ2JfeHNrLmMg
IHwgMjA3DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgNCBmaWxlcyBjaGFu
Z2VkLCAyMjkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQoNClRlc3RlZC1ieTog
R2VvcmdlIEt1cnV2aW5ha3VubmVsIDxnZW9yZ2Uua3VydXZpbmFrdW5uZWxAaW50ZWwuY29tPg0K

