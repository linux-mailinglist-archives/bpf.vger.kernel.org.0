Return-Path: <bpf+bounces-75328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5AAC7F643
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 09:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C45A3A5B6D
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 08:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98840260566;
	Mon, 24 Nov 2025 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gN8jQc1N"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D65E27472;
	Mon, 24 Nov 2025 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763973188; cv=fail; b=W+g/R7KcIjci/esRCz4xpovgfVupoD20CjzQgTczsOeV9da6rgax/SZ99z9Boj2spfzLZB0JoxyUw7cIatOlqJwOfJnWHW6w194ezAQSNuiL/Xz5EijOygFrT5JKUPTSZ+wOm2MDYRtBeFRE57/xQoCU1qFEZoXsfmcBCVbjxUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763973188; c=relaxed/simple;
	bh=x7HPNsF8eWeyvJoonkc4QivAYcOOjm08CmnvGcH0KxI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ltzKQk/AVsRtcEmPY91VUxJ0r3pvuAYJVPOK/E6aSrpnpH29yFRm4SJm5AQRocWFBOXjrCD5irdk8Y34tuohYyxswJJSgqiTr4IxbqUoo5v8E9hiBbNoGQWlEJyyH3QqFBSUUwFTFzicWDxzLx3/q/k8Ih2H3Bt+QqTK9VuoNY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gN8jQc1N; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763973186; x=1795509186;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x7HPNsF8eWeyvJoonkc4QivAYcOOjm08CmnvGcH0KxI=;
  b=gN8jQc1NBdM/ugLSIWcuzDyF7Zb5clEsBqrZwMjFH50GDKexZPYSfG9K
   ZTg37H4v08iIbcSj4y30EU/laaRN0Beb1rOPDtVDvEssFPg9a1YSp2PG8
   E3Y8qEiP2EDGTonvBtTsnxS0bDfUg8iZYk2YA3LGmdgIEqPqNDBfekRue
   GElFYsgAQLiST0UYhC/ZQkkRfa/nqFHHVXRdYxPU0t+iBbakz4ixNDjLL
   T8hDsXG0+dw9angmmlNGduWbXuNsMb21oTChpqvAMhIYNIpYdpUAry83g
   8IAQBum1Pc2GTnExWBz27qRGNr3cEgqAGqaXHDuHYRTizAt7enLY8fKSs
   A==;
X-CSE-ConnectionGUID: rSoiDDNaSYqqL20dYylcEQ==
X-CSE-MsgGUID: sXkUXOvARuWPkNc+l719WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="65996631"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="65996631"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 00:33:06 -0800
X-CSE-ConnectionGUID: ivValqrZSCa6kqCGlGGcHA==
X-CSE-MsgGUID: W51n9ULmS3e+VRe59LHGEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="215619907"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 00:33:05 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 24 Nov 2025 00:33:04 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 24 Nov 2025 00:33:04 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.18) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 24 Nov 2025 00:33:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BS+1Ut4yoFHFMup6q0A2A3MGPbyNUVABWpbhHBBGfVl7SMS8I1cuYwvFrRwf7Ibqbh0X/9aPHNfcphbwOKALfs87wghCKD77aXeYjukSjNTKp/kMnwfA1PtP6Sd31gvQb0BDOoIj4sy/IdwIb+Y+vdQEgszDamKZ4nLKC4ZD+OVJGUzaBucqrVgwVWj5sYZyBiIJx+33ciiVrC/1gnHGTpKAWRR64LKrJlNtXz9vdp7NqzichFFBbCD14OhLiyUh9dHOD43ta3/M3i2PWsry9/99iVs2akRWjUQgOy4+LdXrKcGFJ7F+b8TFtKMSQ0Bmq/TdzAjft3Dcqb50Ct5lYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7HPNsF8eWeyvJoonkc4QivAYcOOjm08CmnvGcH0KxI=;
 b=L9z/h3fjmSTSi1y+yFofOzAJjQvBTiBI3ttmQVptbVkTIZ1girIEHSgh51EVAOE4ruY88YGmvzjw20d9dmrWg0x70gJOmuZp4fxf+C6SpPfZNEKPkygLEquKDcnJ4mD08J6ZH3c0PpYTn34H4vEsHR6r2XvlgItz852+6quidzBqzbkDF3aOlD+JmApAp6UJ3S03t/FNoSlj1aXgkNAAM3ITQHPXn1LN8yThvPRZK6aryK701+6C49AOzUIHaGZ96WSc1hi34DPbQuZvVeMBWNRJ5r5K+Yf5qKFgKZImCVzDNzy8hgrPIflbZrFtotpWx9spyaZV/UyuSD0kWFaoZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::31) by PH7PR11MB6476.namprd11.prod.outlook.com
 (2603:10b6:510:1f0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 08:33:01 +0000
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::67f8:8630:9f17:7876]) by DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::67f8:8630:9f17:7876%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 08:33:00 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Mina Almasry <almasrymina@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: YiFei Zhu <zhuyifei@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Richard Cochran
	<richardcochran@gmail.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v1] idpf: export RX hardware
 timestamping information to XDP
Thread-Topic: [Intel-wired-lan] [PATCH net-next v1] idpf: export RX hardware
 timestamping information to XDP
Thread-Index: AQHcW7mOEioV57xnd0yuKi6/nWj2urUBgcBA
Date: Mon, 24 Nov 2025 08:33:00 +0000
Message-ID: <DS4PPF7551E6552ECCF95AE9C177DEF07F8E5D0A@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: <20251122140839.3922015-1-almasrymina@google.com>
In-Reply-To: <20251122140839.3922015-1-almasrymina@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF7551E6552:EE_|PH7PR11MB6476:EE_
x-ms-office365-filtering-correlation-id: 85139f40-8a59-4729-1d2c-08de2b3413e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TE9yU2l6WlNCeXhsRFM1QVBTQ05zWkt3R0lrTE0xVVF4VVl3N3FQdks2dXZr?=
 =?utf-8?B?eE4xMnRoL2loaHV1OERyeEh4NTZ3UkFsd21Nd3JCYjlxNytoMTZtbFZLZ1ha?=
 =?utf-8?B?UExhQ1NxdC9yVWYyOVZZTlhQQ1pGdEluMzBNMXEwV2N6dCtjeGtzbUNHOXJL?=
 =?utf-8?B?eEV6TG1jcTd0dnhIeFFramJNSzZSbDBNcjZDR3ExdjhUZUhqUER5K3hSSlRq?=
 =?utf-8?B?SWRlSmlWLzJkNVZHMHhQY3pBVFlMR29HV3ZCS3BxWXdoQUN4Ti9iVGxlWXRt?=
 =?utf-8?B?QjN4NGxkd2tHQU81K3JaWEtXWCtGUWM3V2lsb295ZU5ZUjBDVW5pL3dqbmJl?=
 =?utf-8?B?T2pPNUNUUEV6K0NveXBLU0tKTHZYdDdGVFp5U3FoR3dSSlpNd0hEL051L1E5?=
 =?utf-8?B?Y3NFbFVIbHdwZENwcnJWL1B0Mmk1a0ZvNnNGcUEycEJVd1NtWDJIL0JudVZ3?=
 =?utf-8?B?R0FjU2d3TjJYN2pOcSsvVHZRYTBtSFpyWWRycFlicHBhdjdwYThRdlZHcS9w?=
 =?utf-8?B?K0N1bEFqMlJEK2hiNThCUXRvdUMvTERrY042NDRYWUpWbEJlQTh0Z0p3MlNw?=
 =?utf-8?B?ZFUraEZ5Z0ZMSlZHVk5vdUpmeCs1dnh4Q25KUzUzVnlvWWtzZmMwQnd6QjMw?=
 =?utf-8?B?dUhzVmlXRlVndTlmaEI0RGxPUkpLMXZRd0czaUxjN2pZWXhBSTZNOWh1MW1D?=
 =?utf-8?B?SjlFelJyZ3kwbVIwSkdzek1yemI4SFYvWlNIVmhhdndZWjJudjNPZWRlVHly?=
 =?utf-8?B?MUttb0d6ejVnRlJXVDZaRmRQeS83TWhSYThLbVd4ckI4OVZPTDdadE44b05N?=
 =?utf-8?B?VmJkU1N4RGhQekJYT01xNlAzUnJEbnFnM3dLN0I1VGRaMWtCWWF1VTFRaFRK?=
 =?utf-8?B?YmJxTDcxNzhYNmFhOXl3bXVCRnlQOCttUG5QT2dDdW1HTnd3TjZuUnFMdVdp?=
 =?utf-8?B?S3l0c0dDWE9ZM3p0YjlMQzB0WmZwM29FUmJNaU13RER5NmhmMWNmUFBCTDNm?=
 =?utf-8?B?eG90N1A5Uk1PL3ZxZ0dEN25TcDNZS00yWGphaUJIQk1NanUwOTg5TVlPNE04?=
 =?utf-8?B?anAwcXRqcmQvQXFhQzRGbkhQcWJEejFZM1NkZzltSHBPcm1wcUdURVdCS1Vs?=
 =?utf-8?B?TTFuckUyWUVHSUtqMFNQdnVRTDU3RElKOFFMOUdzVEdIbGhUQ3VsSkdVTnZv?=
 =?utf-8?B?d1RGcjF0aGI4eEtwUmJUYVZFaVprdG9ZMFpjMmVYTjVvRWFyRFphQjBUWkNE?=
 =?utf-8?B?YW9FWEVqUXgvQTFxVWQ1VmMxNXNmOFhYOHFVL0MxZVJ6ZS9IS3hsL2kxTUlm?=
 =?utf-8?B?dHFhSG5uZFdFc2NoZGxFYUVCRzFiNUw1cG4rVVJXNmNaTC9FemRrSlQyWUVG?=
 =?utf-8?B?S1Fta1pic2FGemsxVEZTTlpPajZBbElmaTFpWjR2bjQzZTEvWExUbjdKcnlT?=
 =?utf-8?B?LzRQMnREcklDRERTbFVEd2RVMmZ0NjVwZGlHUGliMDlOOTRZZHRNSm1MeWdY?=
 =?utf-8?B?ZnY4MlFTZkhZY1VnUWpROWNUVEZJb08zb1Y4YldFR2ZudGZxemdweWVlNFZB?=
 =?utf-8?B?MnZHUVZxZ1FnYjBPM2ZNZHZNYnV0cHRsUlZNUUtkYVhoWHVYbnJ4WVJpeWsv?=
 =?utf-8?B?WGNRcktQRE51V25PRFl2S0MzTEs1WnVwWHRTK2FsNi95akFhdEh5Z2l1dnpT?=
 =?utf-8?B?QVhPeVV0YWZYNU5uS3F2dVJrYmdoNUFRdFhOOXZOR0NMbzI4M1U2UDZESStL?=
 =?utf-8?B?dWEzWFo1V2VLai9ZdWR1MkhLMUt3UE8yS0ZZSys2dkVTUFFmSjZOOU9EdVpW?=
 =?utf-8?B?emlQOXlVMTVmSWJodU92QklldUN0WEFzZ3Uvd0FEUVFqVGdFOWxhRmMxUU8z?=
 =?utf-8?B?eks2SEIySUNiQmZsbHpZdk4zbUJseXRaYytKb29xb0xBK01QVnlPNE9NZTZE?=
 =?utf-8?B?N1BFRGQ5NVZOV0tWc3FYZS9Tc3BFU2R5MnIzYnhUOTcrMEdNZFA2RFlqK3BO?=
 =?utf-8?B?WGZZZFVpWlZiVHpRQmcxeWhDTzZZRm51N3ZXeUxmU1lzczFzQklHaDZUNU9J?=
 =?utf-8?Q?+PDVS9?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF7551E6552.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEZSVXRVcjBxWVRWUkQ1dGNHNGlHWGJIOWo3QmhuaGFqeHZyTFA2bGhJc3RB?=
 =?utf-8?B?Tm5mMG1xY05Nam1LbmR6Mno2b1AvSUlZbE9OdWlNNDkyOVR2YjcvMm9VVENY?=
 =?utf-8?B?TEZzQVl2d3F0aFBuL244RDdRMHBxYnJSTkpUOWt0MU5yaGNMQnRGTm01UUo1?=
 =?utf-8?B?RE9sOUVvdUNoWm01a3o0RE1UYUxqSi9yeE1FeHVnSXhnekRVaXZEdUhlN05m?=
 =?utf-8?B?RE5xRndnYlE4amw0SGdHWFBneDAvOVlZL1BmaXY4Z2lsa3JyOUdXeXBMdXpn?=
 =?utf-8?B?RkFRdjF5aTJpOGJReVl3dEJqOHZPSElzUTBCdlR6RkxjLy9CY29oV25YRkJh?=
 =?utf-8?B?Z0JzajVBY2VSUitTRkZvbHJFUG1qNUtPMk1nNG1aVGF1T2Fzd0R0Vk9yczNB?=
 =?utf-8?B?MkE5WDVtZDhrc08xaFpSWWxKWU02ZVhrV3E0R1JPNEMyVmcyclpVWUNVV2dh?=
 =?utf-8?B?aHdWMG42RGVPMlRFQmtraExtUTlkNExVS1Q5S2wybFV4dEJzUlJDNThLeGRs?=
 =?utf-8?B?aXFRYXlya3g2VGF6VDVueHZhdmtpV0NaaUZkK2VjUWhRYnNUTXRYWkVzUEhJ?=
 =?utf-8?B?c3drUWh5ejMyU0hQN29IbnFhTEFVbnNoY2pwNnQvN1RHTmhLVUlsbnFzcll2?=
 =?utf-8?B?TUFuZzNHNHd4bEl6QzZPWm9oYVZsRU1MS25hVEtqVk14TlIxajdramZ5dktX?=
 =?utf-8?B?RktiaDgvcFQ2SEpOSjNYdXd3ZUJxcnRkWUM4dW41M2greEJiMTJDb0hqN1pQ?=
 =?utf-8?B?S1NwbHV3Z3JuQ2tvUWJnZE9FbzYwZHRiWWFUb0xHNUlROFJ2R0RVQTRrQkw2?=
 =?utf-8?B?VGRYOTZ3R0xYanEyTTJibkgwS1hHTFk5VUlCZFM5TVBaL3o3aDlhdmdSSFV3?=
 =?utf-8?B?V0NsMVN3eUNZQ3E4Z2V4c3NrYVFENkhHMCszamJWRkRGOXZJUWRIZnExcHpV?=
 =?utf-8?B?d0RaWTNuSmRIaElwamtKSTRNeTU4UWh0R0JSUzRMTFJEcDh1WEY3K013cWRx?=
 =?utf-8?B?dmFHY3lHYzhrVHAvSmNveFJqa0tIK3ZnSDVFS2Q3bXJSRjZWclgvSExzOThk?=
 =?utf-8?B?bHM1YWgza1hIekJLbjc5L0JSUkg0eEIrOEZEWmhXek8vcHZxdHpGZmZmTFZj?=
 =?utf-8?B?cGFqTDhsNG9YYUs5UzJjM0FBMmxMZy8wcFNObWdaNUJaM1ZkWHlaWDRmTjR2?=
 =?utf-8?B?QVdZMGlmcUtkSnhuOG5NSmx2ZDNudXVuRUtrZUtrRDZadXZFZlpvYzhVMm5q?=
 =?utf-8?B?blJmbURWT3JYN01ObUplMnlRK1hDcWNzM2tlYVNZMy8xT2JhSnc5eGlqK1Zo?=
 =?utf-8?B?UDN4TjdxOTF0YjU4MjlPR29pak1ZY0VEMzVxTmlXclNxYytKdUpUUm1LSlZU?=
 =?utf-8?B?NlhtR25Od2U5NnduMzIrUktxbythNXlJT3pQbnBHYjA2a21GbnBpZ2VIZWIx?=
 =?utf-8?B?TThDaXl3bUI1THFpY0Rjdk8zRUgyWFNwNENFUWh1OHBjYkJjMEtPbks2MSt5?=
 =?utf-8?B?aUdVQS9VR3p2STVpT0F6a1pSUlYwenczM1pjNk5LUzRJZEtINXFJMm5xNlg4?=
 =?utf-8?B?a2dibXZHdkJkNlBqU0c3K1g4QUw4ZmdiNjNLT1M1dncxbkZLczNHczZXL3Q2?=
 =?utf-8?B?Q0hpcHZCY1l6ZVZwSTBoSWlzVGpaZXBRK1NhUUNIN0pqRHhPRUpULzRGOFoz?=
 =?utf-8?B?MVlXcEVwOUN2bUtTUVI1VktPNkY2bnIyWWlsY2tOdjNFSFJMcG04cUFQV1lR?=
 =?utf-8?B?bFN6T1dNTmxRNUwzUVA2eG9tcDVsTlFEWmpWbFNjTDRlQm9jVkROcU4wM3JF?=
 =?utf-8?B?VGEvVVZTcDZzQ01vOFhtaUhTSG5tMVdGSlpROGNram9iaVU2QXRkRTgzSVN1?=
 =?utf-8?B?UW8vMmRmRWZ5SSt1M3REY1RIelRkZnpVdXIxeGc4NlduY29rVUgrUGkrNDlq?=
 =?utf-8?B?WE5ETHlqUDlEWk5laGRtRVo1MlNRclhzVkFKNitEQmxqU291WmhKNjJjbENn?=
 =?utf-8?B?U3UwMHlOOUcrL3JvZjlkaTJtb2dsTG9FL2dFSHZ0OU81ajA2aDY2b3Y3QVl1?=
 =?utf-8?B?ekxWUk95RFZFM05mSlZMSG5PMnhEVEcybkozbDlwblVCU0l4cVQyZzNzYjI4?=
 =?utf-8?B?NXhJUDhZNHNGYXBGT0R0YnA3SFNjc2REV3RQcnp1Q2dHbGhobmQ2U1V3WlFQ?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF7551E6552.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85139f40-8a59-4729-1d2c-08de2b3413e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 08:33:00.4841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LnysII36QAjpqdYljupd8+IsimrHJrBvb87/XrqeBthoejHY65FdVaMHV8l15tHQL6gt5gFNu631l1Tkg+fmK6/yp0qJ1QrxJVcsZVBRSsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6476
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgTWlu
YSBBbG1hc3J5DQo+IFNlbnQ6IFNhdHVyZGF5LCBOb3ZlbWJlciAyMiwgMjAyNSAzOjA5IFBNDQo+
IFRvOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBicGZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogWWlGZWkgWmh1IDx6aHV5aWZlaUBnb29n
bGUuY29tPjsgQWxleGVpIFN0YXJvdm9pdG92DQo+IDxhc3RAa2VybmVsLm9yZz47IERhbmllbCBC
b3JrbWFubiA8ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+OyBEYXZpZCBTLg0KPiBNaWxsZXIgPGRhdmVt
QGRhdmVtbG9mdC5uZXQ+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgSmVzcGVy
DQo+IERhbmdhYXJkIEJyb3VlciA8aGF3a0BrZXJuZWwub3JnPjsgSm9obiBGYXN0YWJlbmQNCj4g
PGpvaG4uZmFzdGFiZW5kQGdtYWlsLmNvbT47IFN0YW5pc2xhdiBGb21pY2hldiA8c2RmQGZvbWlj
aGV2Lm1lPjsNCj4gTmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29t
PjsgS2l0c3plbCwgUHJ6ZW15c2xhdw0KPiA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47
IEFuZHJldyBMdW5uIDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+Ow0KPiBFcmljIER1bWF6ZXQgPGVk
dW1hemV0QGdvb2dsZS5jb20+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+Ow0KPiBM
b2Jha2luLCBBbGVrc2FuZGVyIDxhbGVrc2FuZGVyLmxvYmFraW5AaW50ZWwuY29tPjsgUmljaGFy
ZCBDb2NocmFuDQo+IDxyaWNoYXJkY29jaHJhbkBnbWFpbC5jb20+OyBpbnRlbC13aXJlZC1sYW5A
bGlzdHMub3N1b3NsLm9yZzsgTWluYQ0KPiBBbG1hc3J5IDxhbG1hc3J5bWluYUBnb29nbGUuY29t
Pg0KPiBTdWJqZWN0OiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggbmV0LW5leHQgdjFdIGlkcGY6
IGV4cG9ydCBSWA0KPiBoYXJkd2FyZSB0aW1lc3RhbXBpbmcgaW5mb3JtYXRpb24gdG8gWERQDQo+
IA0KPiBGcm9tOiBZaUZlaSBaaHUgPHpodXlpZmVpQGdvb2dsZS5jb20+DQo+IA0KPiBUaGUgbG9n
aWMgaXMgc2ltaWxhciB0byBpZHBmX3J4X2h3dHN0YW1wLCBidXQgdGhlIGRhdGEgaXMgZXhwb3J0
ZWQgYXMNCj4gYSBCUEYga2Z1bmMgaW5zdGVhZCBvZiBhcHBlbmRlZCB0byBhbiBza2IuDQo+IA0K
PiBBIGlkcGZfcXVldWVfaGFzKFBUUCwgcnhxKSBjb25kaXRpb24gaXMgYWRkZWQgdG8gY2hlY2sg
dGhlIHF1ZXVlDQo+IHN1cHBvcnRzIFBUUCBzaW1pbGFyIHRvIGlkcGZfcnhfcHJvY2Vzc19za2Jf
ZmllbGRzLg0KPiANCj4gQ2M6IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBZaUZlaSBaaHUgPHpodXlpZmVpQGdvb2dsZS5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IE1pbmEgQWxtYXNyeSA8YWxtYXNyeW1pbmFAZ29vZ2xlLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL3hkcC5jIHwgMjcNCj4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYveGRwLmMN
Cj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL3hkcC5jDQo+IGluZGV4IDIxY2Uy
NWIwNTY3Zi4uODUwMzg5Y2E2NmI2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pZHBmL3hkcC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lk
cGYveGRwLmMNCj4gQEAgLTIsNiArMiw3IEBADQo+ICAvKiBDb3B5cmlnaHQgKEMpIDIwMjUgSW50
ZWwgQ29ycG9yYXRpb24gKi8NCj4gDQo+ICAjaW5jbHVkZSAiaWRwZi5oIg0KPiArI2luY2x1ZGUg
ImlkcGZfcHRwLmgiDQo+ICAjaW5jbHVkZSAiaWRwZl92aXJ0Y2hubC5oIg0KPiAgI2luY2x1ZGUg
InhkcC5oIg0KPiAgI2luY2x1ZGUgInhzay5oIg0KPiBAQCAtMzY5LDYgKzM3MCwzMSBAQCBpbnQg
aWRwZl94ZHBfeG1pdChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCBpbnQgbiwNCj4gc3RydWN0IHhk
cF9mcmFtZSAqKmZyYW1lcywNCj4gIAkJCQkgICAgICAgaWRwZl94ZHBfdHhfZmluYWxpemUpOw0K
PiAgfQ0KPiANCj4gK3N0YXRpYyBpbnQgaWRwZl94ZHBtb19yeF90aW1lc3RhbXAoY29uc3Qgc3Ry
dWN0IHhkcF9tZCAqY3R4LCB1NjQNCj4gKyp0aW1lc3RhbXApIHsNCj4gKwljb25zdCBzdHJ1Y3Qg
dmlydGNobmwyX3J4X2ZsZXhfZGVzY19hZHZfbmljXzMgKnJ4X2Rlc2M7DQo+ICsJY29uc3Qgc3Ry
dWN0IGxpYmV0aF94ZHBfYnVmZiAqeGRwID0gKHR5cGVvZih4ZHApKWN0eDsNCj4gKwljb25zdCBz
dHJ1Y3QgaWRwZl9yeF9xdWV1ZSAqcnhxOw0KPiArCXU2NCBjYWNoZWRfdGltZSwgdHNfbnM7DQo+
ICsJdTMyIHRzX2hpZ2g7DQo+ICsNCj4gKwlyeF9kZXNjID0geGRwLT5kZXNjOw0KPiArCXJ4cSA9
IGxpYmV0aF94ZHBfYnVmZl90b19ycSh4ZHAsIHR5cGVvZigqcnhxKSwgeGRwX3J4cSk7DQo+ICsN
Cj4gKwlpZiAoIWlkcGZfcXVldWVfaGFzKFBUUCwgcnhxKSkNCj4gKwkJcmV0dXJuIC1FTk9EQVRB
Ow0KPiArCWlmICghKHJ4X2Rlc2MtPnRzX2xvdyAmIFZJUlRDSE5MMl9SWF9GTEVYX1RTVEFNUF9W
QUxJRCkpDQo+ICsJCXJldHVybiAtRU5PREFUQTsNClJYIGZsZXggZGVzYyBmaWVsZHMgYXJlIGxp
dHRsZeKAkWVuZGlhbi4NCllvdSBhbHJlYWR5IGNvbnZlcnQgdHNfaGlnaCB3aXRoIGxlMzJfdG9f
Y3B1KCksIGJ1dCB0ZXN0IHRzX2xvdyBkaXJlY3RseSBhZ2FpbnN0IHRoZSBtYXNrLg0KT24gYmln
4oCRZW5kaWFuIHRoaXMgY2FuIG1pc2RldGVjdCB0aGUgYml0IGFuZCBzcHVyaW91c2x5IHJldHVy
biAtRU5PREFUQS4NClBsZWFzZSBjb252ZXJ0IHRzX2xvdyB0byBob3N0IG9yZGVyIGJlZm9yZSB0
aGUgYml0IHRlc3QuDQpTZWUgZXhpc3RpbmcgSURQRi9JQ0UgcGF0dGVybnMgd2hlcmUgZGVzY3Jp
cHRvciB3b3JkcyBhcmUgbGVYWF90b19jcHUoKeKAkWNvbnZlcnRlZCBwcmlvciB0byBGSUVMRF9H
RVQoKSAvIGJpdCBjaGVja3MuDQpBbHNvLCBwZXIgdGhlIFhEUCBSWCBtZXRhZGF0YSBrZnVuYyBk
b2NzLCAtRU5PREFUQSBtdXN0IHJlZmxlY3QgdHJ1ZSBhYnNlbmNlIG9mIHBlcuKAkXBhY2tldCBt
ZXRhZGF0YTsgZW5kaWFubmVzc+KAkWNvcnJlY3QgdGVzdGluZyBpcyByZXF1aXJlZCB0byB1cGhv
bGQgdGhlIHNlbWFudGljLg0KDQo+ICsNCj4gKwljYWNoZWRfdGltZSA9IFJFQURfT05DRShyeHEt
PmNhY2hlZF9waGNfdGltZSk7DQo+ICsNCj4gKwl0c19oaWdoID0gbGUzMl90b19jcHUocnhfZGVz
Yy0+dHNfaGlnaCk7DQo+ICsJdHNfbnMgPSBpZHBmX3B0cF90c3RhbXBfZXh0ZW5kXzMyYl90b182
NGIoY2FjaGVkX3RpbWUsDQo+IHRzX2hpZ2gpOw0KPiArDQo+ICsJKnRpbWVzdGFtcCA9IHRzX25z
Ow0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IGlkcGZfeGRwbW9fcnhf
aGFzaChjb25zdCBzdHJ1Y3QgeGRwX21kICpjdHgsIHUzMiAqaGFzaCwNCj4gIAkJCSAgICAgIGVu
dW0geGRwX3Jzc19oYXNoX3R5cGUgKnJzc190eXBlKSAgeyBAQCAtDQo+IDM5Miw2ICs0MTgsNyBA
QCBzdGF0aWMgaW50IGlkcGZfeGRwbW9fcnhfaGFzaChjb25zdCBzdHJ1Y3QgeGRwX21kDQo+ICpj
dHgsIHUzMiAqaGFzaCwgIH0NCj4gDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHhkcF9tZXRhZGF0
YV9vcHMgaWRwZl94ZHBtbyA9IHsNCj4gKwkueG1vX3J4X3RpbWVzdGFtcAk9IGlkcGZfeGRwbW9f
cnhfdGltZXN0YW1wLA0KPiAgCS54bW9fcnhfaGFzaAkJPSBpZHBmX3hkcG1vX3J4X2hhc2gsDQo+
ICB9Ow0KPiANCj4gDQo+IGJhc2UtY29tbWl0OiBlMDUwMjFhODI5YjgzNGZlY2JkNDJiMTczZTU1
MzgyNDE2NTcxYjJjDQo+IC0tDQo+IDIuNTIuMC5yYzIuNDU1LmcyMzBmY2YyODE5LWdvb2cNCg0K

