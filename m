Return-Path: <bpf+bounces-78541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C91D124D9
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 12:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A441301F78A
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 11:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9290B3563DA;
	Mon, 12 Jan 2026 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0KwmMVU"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AF22DA74C;
	Mon, 12 Jan 2026 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768217445; cv=fail; b=spgS/aA78QD4E+oOPqseofgRi1g/I5VCnJsZjmYkJOcDH/uEZ/w1ok8FQn0ZVTJtl/ije1IfIX8dIJWKZzjF99ACGvE4uBX688bVANWKQXyibTblsUfDL/X2aEGJKRyRzvdWwQSzyGljVVW8SqM1Lxn5jjaA+I//rOFCR1Tf1+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768217445; c=relaxed/simple;
	bh=9P6HSHyPkPXGFgC3dl6Ekb/yUhD04/QUirP1waoplcI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NSg+m4AvW3b4rxYal1MMSP233O1mkey3ar7ze33XxuZyonk92asiGp7fyCetIccVRKKfHYhCKpl1SEdW9DihZjCD/5aL9g9sIc8QTqzKHfVaH1eYBflEIHwHURxddzGTDoQ/rRjFzgMIEIbf1/qLUaTYw/q8rUkmXCVd6lYX9+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0KwmMVU; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768217441; x=1799753441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9P6HSHyPkPXGFgC3dl6Ekb/yUhD04/QUirP1waoplcI=;
  b=N0KwmMVU2ah+9GSU1sSIU47lt4tvHpIdw4cZOhVedawKOPOqp54vxCEO
   8Sb5GcVUaszFQ57yuWsMU/PZAxVypaYEVed/U4xl/4jY81kTHP4HRrRUc
   BnJRMQSKA5W4pMCL0w3rrwl35tTQsuMl+5xmCeQvv+GBqQMCZTGyrVN8m
   vTgltHN0S0DFNLcxHdUdkOGPTKvQ1K8jImJpJOof0F+5HZnV1zkY1EpBI
   1QOiioUofGo+HQYS1ckRcrPz1KCYcGo/8b71JQgxP0DN3UCbhpstJEeMM
   G7yLrhODQddBiuxOXh0M6UMwUbO2p+Bf63UvwVZUo8OO0FuxRY16Bi9tZ
   Q==;
X-CSE-ConnectionGUID: /8sznFWLQ9GdGjsslLSgLQ==
X-CSE-MsgGUID: b2780Wy1TJCb/ah623mz4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69565220"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69565220"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 03:30:37 -0800
X-CSE-ConnectionGUID: 7wIRK8U6T1GpJdvTKREIUg==
X-CSE-MsgGUID: erY6Hsk6T2Wh/P1qabayvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="204481861"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 03:30:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 03:30:36 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 03:30:36 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.69) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 03:30:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTuChGnMRwC78+BnWsjU3arjg6gA23p0oMh3CAA4LbJnwChwhGJIS9E19kg+UIBJV9Nkrya2xeDLhLUXp+skQ5G32nWWdl9QJzjOjt5Dfq6b/1ZV0lqwWGtyXWo2UKBc1X3Mx/A3uVA7elBkDRANAC+UUzk70Q/i6/ZKRw0nTDZLJKeeisqJR0T5WzPeYPNKvsATGBnlaXB1gnNbztYdR3afj4Pi86VFZuYhnArhOQDnu8sgnlaKw01JQp72hnybH8vhINLC0TDEmLlhSlCxBrZRhqPLa5TEbbNuZkNxhIK2ChGgDoJmSjSW9MBl3MKbjrSW9WGaAJ6xyawcMyqKnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9P6HSHyPkPXGFgC3dl6Ekb/yUhD04/QUirP1waoplcI=;
 b=Hd8oYPtEXzAkiTNTj16fInhrSgt/3wx7k/rMR4waw8OPIYbeQlTEj8El2eDqRjlIkZydizDvbDM3A/mign22SmYz9CqFDTBONw2feiQCpmsLqVCm2zudsiFLkxWx+DbF/ZHogC6aJTWWfgKWTDFAAoqjBq9t5qCzLQ/S0VjJ/9EeKlVefWnWgfzViMkQJg2mQUhBP+A1zTYjYVjKq2Z6xmO8r6FUdxOFZkpYZ3IxVrOVbvfvro3L9ef6HduEX6IJMMOuMkqnrKk6Cy5tuvqW0B00PsrqCNl/I0hhSkQXmKZLisA5IPQDvMbWev1pTZdupoK5YcuHqre29ALrxKBtVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH3PPFD6B8A798D.namprd11.prod.outlook.com (2603:10b6:518:1::d51) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 11:30:33 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 11:30:33 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Michael Chan
	<michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "kernel-team@cloudflare.com"
	<kernel-team@cloudflare.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next 03/10] i40e: Call
 skb_metadata_set when skb->data points past metadata
Thread-Topic: [Intel-wired-lan] [PATCH net-next 03/10] i40e: Call
 skb_metadata_set when skb->data points past metadata
Thread-Index: AQHcgnTkth5KM449ykuSGYIioMilMLVOaL8w
Date: Mon, 12 Jan 2026 11:30:33 +0000
Message-ID: <IA3PR11MB89864ACF712750EDB72BF228E581A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
 <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-3-1047878ed1b0@cloudflare.com>
In-Reply-To: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-3-1047878ed1b0@cloudflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH3PPFD6B8A798D:EE_
x-ms-office365-filtering-correlation-id: 33e82047-e2ca-42c1-02d0-08de51cdffc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UHJ4eko0OTZ1V2Mxd1hPRTFGcHZKZThpQlVkUUU1bGJFN290ZTM3QXA3MFda?=
 =?utf-8?B?d0RlVWFraFp1b1dDS3A5cUdRb2FPbHJuVFFUNGxBdEVnTEJXeHloSmZLRTRE?=
 =?utf-8?B?K3M2ZXJnMm4vWlJZOS9rd1pmVzZjV3pJT291Z3VUM21UeWdYNy80M292Z1Zn?=
 =?utf-8?B?azZrcHRiWkR6dU9pOVRnRzFnY0JtN3FhUTRidzlvNmZjOHUxZWkyYVF5dFBQ?=
 =?utf-8?B?OXZucm9JTWtvSEV2NE9scHVaUzM1ZXE3MjkxdDc4RFVIL0xxOEJkWWJWd2Yy?=
 =?utf-8?B?dFdQR0djZEtVdXNTUk9XdkJuOTlyVzRoejZsd2RXeEFBYWE3U3lxQVBCQlVj?=
 =?utf-8?B?RFl0anVmM2IxV0t1NWNlbGp0SmRCQ0R3ek9RbEt5bjJreFl5a0lPMEhqcEoy?=
 =?utf-8?B?clp4Uyt5WnFlOXpiTUJnakhoZ0hrRUhBS3J3bTJBN2xqR3p3SEc0QVhqSm9n?=
 =?utf-8?B?djFwd09Ldm0vK2NSQUVrWnRhREF5eW5XeHFHR2dKcWsrckQ3Q01wRDlDNWRJ?=
 =?utf-8?B?ZGFJRVJHVGtNMk1QdUxmYjBBbEx3ZFlRK1pQY0FaK0JHbTFyVVdabG5lZzFK?=
 =?utf-8?B?akVWeHNHZUcyWE5ZbE9lUjBFcVk1M0pULzl6QnVWaHU3UUppT3FoWWk4RXJJ?=
 =?utf-8?B?TnVmVStoSEp6U3pQV2RDREtjNFhCOUJ1SjIvSGZHd0hvTXdKOE5mQnpvVlhZ?=
 =?utf-8?B?VkxDbisvNHFaL1Y1OXlxM0ZOdWpuTytrYWY1OGJEcTF6MTBLaXJXNDRjQlZQ?=
 =?utf-8?B?SWhoT2FLa1NxWXhpY0dBUFd6M1NQbmVuclR0b3Q4TXNydGZGS3ovb0VWeHhm?=
 =?utf-8?B?MGZPdnp2cElPS0RsWHlpL1FwdVBkcUlGVHkxZmVScjJubEkxbnBDNDl0MGUv?=
 =?utf-8?B?SmRuQ0RzbzVoK1V1RS9ac1lmK2tnRXZRdU5icExkaHFELzFFdVF6Q1B4UTF1?=
 =?utf-8?B?QStSR3ZudTBXYjd5Ly9xanJkSjlCMmFsQmpZUG5BZ1FUdFlqcEo1a0JTQzU1?=
 =?utf-8?B?WHNPaFVoRGxWM1Z2MnQxeGNmRmU5clp5T1g4QUJvM0d0cGhQNEdPd0hQTkMy?=
 =?utf-8?B?aHE5NG5yZHFudXdjNkNoSlJ6V25FY3lOZE15ZHV1Q3pKMmd3SWlWRWNOajBG?=
 =?utf-8?B?VHN2WTIxckd3Lzdka2o0ckU5ZUdtRjJKWHhxdEZHaVFpc3dMV0hrTUZjTEdS?=
 =?utf-8?B?VklGVkNiTStsVWVyY1JkeW9XSFA4RFNzdTZScUVOakRCcGs2SnlRaVRxRjJF?=
 =?utf-8?B?Sk1ONEhOSWJZQTRLVjY1aTdJRE1oRVR3V25yN2VtY0FxL2J0Yk1wTXU5SzlI?=
 =?utf-8?B?RXBvR081U1lTaFJnalNzdmVxWE5QR0kxYjRVOGQ2dGVUT1lhRFhQWFNldUtY?=
 =?utf-8?B?SC94aytCNUNtempjZmM2eUpZZWJZQUh0N1B2dHBWd1BLdGFRa0NISmNQeXhj?=
 =?utf-8?B?dnQ5bE11TjNxM3FCQ3F6OVQzaTh4c0FEemxMNDlodXpFb2lrT2xUQVVJWVBY?=
 =?utf-8?B?cWZJOXZmTzJhMHFyYk9kMXBneUtaMEY4TmxBWnNYZ3FFVXJHWkt1MG9HL250?=
 =?utf-8?B?NU9pVzJMcWZ2Q2p2amNDUjBlMDJEOVVacUtiWXd4YmpodFc3czRNZVBib25a?=
 =?utf-8?B?VHhiK3ZSWDJHdktsU2VrNXJJTDFHaHZOdXI1SHNVKzRndWZ5RTZMMy8wVzBo?=
 =?utf-8?B?K09KWG92THJ5MlB1aTNYa3pyV3JuN0lQOUJ0a1NYRnRZem1tZ01vYkI5Zitl?=
 =?utf-8?B?YlluTmZSZCtvZXFkcU5UV2JBTUhLTW83SEFmZjJWTmJTWGZnMHp5bEJadWFX?=
 =?utf-8?B?QnBCbHd0L3RMN1dna25BNlZQR3BPTTZLM0ZlRi9yTHB3VHlPaEJIWFh6ZUhJ?=
 =?utf-8?B?Y01JSEFndTFEZ2gyaEZVdVBWME45L0RYY3hjVHE2YmZaWUE1bkVRVFRFYzR1?=
 =?utf-8?B?WDUvaGZCaUQ4NXhBcXZBcUpLRHV3bzJyc2VZSDBrZWZOWitRNWo1NWJHY0hZ?=
 =?utf-8?B?NFRNOTF0eGE1V2hGYmpLTXVQaktNWDF1L3lBMXQ1d2JMc1FyVGhEWDBFTWlz?=
 =?utf-8?Q?Eaj62O?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnFsZGRtaTM3d0tITFpKQ0wzUldqTEd5OXBiM2xra2NYaERqaGVGYTVybUNE?=
 =?utf-8?B?TElhQVBPTW9jRVN6ZmNPVWZBMWpvT2t0Q2JoRHJKUnNYNFovTUdQV2lKa3pz?=
 =?utf-8?B?akU2RC9wb3RxZS9CU2M0VGlic1dZbk16VGFPTEtja2ZHZlhaMHRoY0JNTS95?=
 =?utf-8?B?VDc2dFVTdE1LdUtTUVVMZHNFTzBGVEdMZ1R3alRlQnR0djVWYS96U3FiZWZz?=
 =?utf-8?B?UlhWWFJ4Y2dOb1huTUprem1xVlk1cVJkMmt1VC9SbXNiekdJd1VHb2pmMmtQ?=
 =?utf-8?B?MVhhZi82a2pBcHFtbDl4dENicjk1L2JtU1BWZEcxWm1ESUZYejhDdmVCV08w?=
 =?utf-8?B?dXY3KzhLMG1uL0kwdWxmVzZhaFNZMW1EMTZ1Uzh2eERkOGowcWIwbkZsc0VV?=
 =?utf-8?B?T2REM0kxdE9wTjMxdnlsMmtwQnJua1ZDU2pNNzgrQUhRYmxkckZXc1I1aHdD?=
 =?utf-8?B?Y0w5OExQZnFkMXRRYnh5a00rYW1FaWVmZ3ZsZVF1ZEg4T0pSWDIrVHUrMzcw?=
 =?utf-8?B?cDhyS0VaOGd5MHVMeENKSUM1TDlCa2RxdE04UElmb3RMc0NsZUF5THRsOW9V?=
 =?utf-8?B?d3l4b2Jta2g5WHByRTJzVzdtNzg4YVNuNWZRODR4dzNvbDBJVG9pejF0Vm5Q?=
 =?utf-8?B?ajIzeFJ6OVdGYVhaR2ljd0t2ODIzSVhpSVFBRUFhMTBkVFlBS2s1Y05IemFy?=
 =?utf-8?B?elBLUXFaMVdiZkdOTXZyUEVPeEI5LzlRZU96ajAvZlhsekNXdm5TeSs4bnlq?=
 =?utf-8?B?dDhudmlwckRRYWNlSWJRSmNBYmtJdEV1dzJlU1NIY0hWT2NlSG82UmJSR1lT?=
 =?utf-8?B?RS9PSFpCZ1A4bkNieUlkR2FlMzdySndYSkRMMk1TdE5BS1E2NE9odlNKbTNT?=
 =?utf-8?B?bit3dmQybitVVkVBd2lCdEVVY1o1NEhabjh6SHZoa0owSnd5VnNFTWxIeng1?=
 =?utf-8?B?SkVRQlNLaDhCSVNBaFF3RjA1cGhBVEhXcmllbXUrMG1oeWd6OGhaVHI0bFo1?=
 =?utf-8?B?Q2V0amJaQzhCeXRqK3Qrb2NaLzBHSmQ1VnQxQXRLVlRxM0xrbjVzS0lMSXhJ?=
 =?utf-8?B?QVdtUHoyS0I0YlEvOU54Y094S1FGNWZOVnRoVkVqcjV3cGFmckFEU3BBNi9i?=
 =?utf-8?B?dWZST0NjSUN5d1RKRjc1RG1Vei9TV3BYMHZ4bVZsVVo1RHQ2UVBhd1owUktN?=
 =?utf-8?B?dUhTTEFneW5ldjBIWnpvYmh4S041NFJjSmwwaTJkL1JhMnV1VnQ1NUtvekcr?=
 =?utf-8?B?TXhqdHBpQjRaekJ1b0RvWDlWY2hZNjNCWnJwdXlBUExHbVErOThWN2tDQitj?=
 =?utf-8?B?dmNnMXpjQXJJOXVYa0twVXdOSXAxZTgrMkdmcVVsMHR6ckp5T1Q2ZFpSSUlY?=
 =?utf-8?B?RjE2SXh6NkowSkF3UmhTc1g0Z1UwcWo5cUtGelNVclRuVGlZMzVrWjNzdHJk?=
 =?utf-8?B?SFZqUDE0cVRWZ0RCTHc2QzVPSWpvUjBZNXdIK1hSZ01Jall0RHpKRVRsNXZt?=
 =?utf-8?B?UEZydDg5cGdpOTh1d3RpRGdNb3NXWlkrRUpYYUtpcFFPMTAyMUdid09mc3lD?=
 =?utf-8?B?R3lmVjh0U2dFbXE5SUdEZ01jdk96VU80YXRVUjZoVVI0VUp4VG1TYVpBbkxy?=
 =?utf-8?B?dkNscklQOXNjVm85WnNRNmk4RW5JUUJqd1VXc0ZlQkFpOUE3enRFcS9DU1Y5?=
 =?utf-8?B?dTRrOUdjR1VmcVR6TGw2ZXRsTnFYaWpjWFIxTkdEekUwOENQWmsyMUpxRXdh?=
 =?utf-8?B?M0VFVHJSVnUzNG15TTluakdYUjNoSlEvbzdnOTkwM2ZzTXEyUnZNWTBKS05s?=
 =?utf-8?B?Tlk0bHBSR2dRZDlreEk0NlV6N05IMFM1ek1PdnhsWDRGcWFrTi9TWmxNZ2xi?=
 =?utf-8?B?UnVUejUyY2oyQURaWVhKMVQrQWJXVVpjbm5ySjczbHZYbkNRNFVPcTR4QjBk?=
 =?utf-8?B?TnJ3ZithdGlVMFdBeUhuNXdoMkRSU1UyYVNZZmhSbm44Ni9YcW5ZbkUvZHNj?=
 =?utf-8?B?TEQwVmV0NVFsM3B5QXQweVgva2hyQ2pWalZueUZKZUthQ1gzQmFvMG13RTBZ?=
 =?utf-8?B?S3NtSGVvbVZVMVNyMUE3cG5FVXdWcldRUlVyNnJnVlhoMDRCMVF4NGxRcEd4?=
 =?utf-8?B?dmZ3U1h3UitJcXc1aXJKNTdUQzZrZ3o5a0IwMFViYWdpOHJNNEV6VHdyL2dV?=
 =?utf-8?B?S05EQVducTlsZHFrOWpyYURiYVJVRGJhYVBudzRnNVFxemh0aXdWc2dMRmN2?=
 =?utf-8?B?cUx6Qk54UEV3ZGJoVERGVCtWTGVQcE5IbVNKRWttRFZkbWk1QllDVU9kNEVv?=
 =?utf-8?B?akhkZzM0enpMemdCRkNUT1EwcjRURk1wa3hSYnN4Q3RmYXp4a20xZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e82047-e2ca-42c1-02d0-08de51cdffc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 11:30:33.3976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YUR3PEKlw+FnAWrJJdawr6AjeFEQ9DArZXnsfI8suUq7zxvgIh0Fb2HHHP55pVn69YgmwXXdSQmWAfTnzlWAv+R+jYlMdItJa5JTLz9KG4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD6B8A798D
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgSmFr
dWIgU2l0bmlja2kgdmlhIEludGVsLXdpcmVkLWxhbg0KPiBTZW50OiBTYXR1cmRheSwgSmFudWFy
eSAxMCwgMjAyNiAxMDowNSBQTQ0KPiBUbzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBDYzog
RGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxl
ZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBh
b2xvIEFiZW5pDQo+IDxwYWJlbmlAcmVkaGF0LmNvbT47IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2Vy
bmVsLm9yZz47IE1pY2hhZWwgQ2hhbg0KPiA8bWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbT47IFBh
dmFuIENoZWJiaSA8cGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbT47DQo+IEFuZHJldyBMdW5uIDxh
bmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBOZ3V5ZW4sIEFudGhvbnkgTA0KPiA8YW50aG9ueS5sLm5n
dXllbkBpbnRlbC5jb20+OyBLaXRzemVsLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6
ZWxAaW50ZWwuY29tPjsgU2FlZWQgTWFoYW1lZWQgPHNhZWVkbUBudmlkaWEuY29tPjsNCj4gTGVv
biBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+OyBUYXJpcSBUb3VrYW4gPHRhcmlxdEBudmlk
aWEuY29tPjsNCj4gTWFyayBCbG9jaCA8bWJsb2NoQG52aWRpYS5jb20+OyBBbGV4ZWkgU3Rhcm92
b2l0b3YgPGFzdEBrZXJuZWwub3JnPjsNCj4gRGFuaWVsIEJvcmttYW5uIDxkYW5pZWxAaW9nZWFy
Ym94Lm5ldD47IEplc3BlciBEYW5nYWFyZCBCcm91ZXINCj4gPGhhd2tAa2VybmVsLm9yZz47IEpv
aG4gRmFzdGFiZW5kIDxqb2huLmZhc3RhYmVuZEBnbWFpbC5jb20+Ow0KPiBTdGFuaXNsYXYgRm9t
aWNoZXYgPHNkZkBmb21pY2hldi5tZT47IGludGVsLXdpcmVkLQ0KPiBsYW5AbGlzdHMub3N1b3Ns
Lm9yZzsgYnBmQHZnZXIua2VybmVsLm9yZzsga2VybmVsLXRlYW1AY2xvdWRmbGFyZS5jb20NCj4g
U3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIG5ldC1uZXh0IDAzLzEwXSBpNDBlOiBD
YWxsDQo+IHNrYl9tZXRhZGF0YV9zZXQgd2hlbiBza2ItPmRhdGEgcG9pbnRzIHBhc3QgbWV0YWRh
dGENCj4gDQo+IFByZXBhcmUgdG8gY29weSB0aGUgWERQIG1ldGFkYXRhIGludG8gYW4gc2tiIGV4
dGVuc2lvbiBpbg0KPiBza2JfbWV0YWRhdGFfc2V0Lg0KPiANCj4gQWRqdXN0IHRoZSBkcml2ZXIg
dG8gcHVsbCBmcm9tIHNrYi0+ZGF0YSBiZWZvcmUgY2FsbGluZw0KPiBza2JfbWV0YWRhdGFfc2V0
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmFrdWIgU2l0bmlja2kgPGpha3ViQGNsb3VkZmxhcmUu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV94c2su
YyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQw
ZV94c2suYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV94c2suYw0K
PiBpbmRleCA5ZjQ3Mzg4ZWFiYTUuLjExZWZmNWJkODQwYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX3hzay5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV94c2suYw0KPiBAQCAtMzEwLDggKzMxMCw4IEBAIHN0
YXRpYyBzdHJ1Y3Qgc2tfYnVmZg0KPiAqaTQwZV9jb25zdHJ1Y3Rfc2tiX3pjKHN0cnVjdCBpNDBl
X3JpbmcgKnJ4X3JpbmcsDQo+ICAJICAgICAgIEFMSUdOKHRvdGFsc2l6ZSwgc2l6ZW9mKGxvbmcp
KSk7DQo+IA0KPiAgCWlmIChtZXRhc2l6ZSkgew0KPiAtCQlza2JfbWV0YWRhdGFfc2V0KHNrYiwg
bWV0YXNpemUpOw0KPiAgCQlfX3NrYl9wdWxsKHNrYiwgbWV0YXNpemUpOw0KPiArCQlza2JfbWV0
YWRhdGFfc2V0KHNrYiwgbWV0YXNpemUpOw0KPiAgCX0NCj4gDQo+ICAJaWYgKGxpa2VseSgheGRw
X2J1ZmZfaGFzX2ZyYWdzKHhkcCkpKQ0KPiANCj4gLS0NCj4gMi40My4wDQpSZXZpZXdlZC1ieTog
QWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo=

