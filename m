Return-Path: <bpf+bounces-52527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E67C5A44521
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 16:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BBAE7AC4ED
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 15:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C52F16A95B;
	Tue, 25 Feb 2025 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDuMHhqT"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CB01547E3;
	Tue, 25 Feb 2025 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499091; cv=fail; b=JcRJpqaG1aTVRWC29kjT7Wy9Sld+/uVaOxR6/g8BhT1ckb30IWmBpoLGB31G07O8XuAtX8UpQrqlgfZlEj/0E2tnqgeHH8WwaLiztvCLQ2l67Q6rpJRqBIFMAlfLHierZDC5zBeVdb0J0J31F1TAiE7vczRbE12GxZbxvpycsNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499091; c=relaxed/simple;
	bh=0AWTJBSWJ/0MS3pnU+V0agEVXm/e3nLqndLH+m5bZw8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h//wQIaMDIr/Thg43oCnIVgDagPOJFpvqgD1xKt3pxb5XZyussc0OozACBz7fX1ZADkp3464Mjj4zONaZ81ZKMx53QHQvgEeaSAduDYBBZxnKjnVKEmyV0SpWqAMe3JNUDdJdOcdDWTuhAL+z10Ly0Hqu52sLbR3cG9VYlhKvRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WDuMHhqT; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740499089; x=1772035089;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0AWTJBSWJ/0MS3pnU+V0agEVXm/e3nLqndLH+m5bZw8=;
  b=WDuMHhqT02NxPRdQEg8qZ5j50zoi6T4Nq3lLrAlUHD7qfujKFX4Woujo
   C1b4swkAYT2QxTor1AnYi9G1ev5lMBh10uf3EPrBclxiaGZJc1MXngMkg
   UECIMsFcvCU2PbyziHjopUvtB3r63YV/f8kHyPjGaSL3AJ+KcYA9EP64D
   K50M2UbvmAtDq/YfHMuOOj8WKa9RgnHeNmljNxWbiZsPV1DUfA9Enmlfz
   NmBWLu46eMZqPuhaHScI1aS6vukLn0NrTi8aRuS7vryRayzngpfRDVZwL
   u0tCfznyxW9d8nWyISbOasrbdNhxLqRnWJhijOlI2JsfMs9FQSLtcAbpL
   Q==;
X-CSE-ConnectionGUID: CqMt+hKVT6C2rD6/si9JCQ==
X-CSE-MsgGUID: PnmzW46tSY2ce6k3bYG8rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41513923"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41513923"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 07:58:08 -0800
X-CSE-ConnectionGUID: YwFyGyc2SXqWRcJTcCEoPw==
X-CSE-MsgGUID: sUXkzHP/SVebpm9RwIk7LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116272602"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 07:58:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Feb 2025 07:58:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 07:58:07 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 07:58:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cr3fe5mNWWRu3xg+GgbwSOxuvhOLevAPBZ1tI9ESpG6y0ZfIoMcUHQKTgMMBlUiicvYcpuVgpB1AxPM6nvUcstpR6TYAo2LE1VNpIKN/12Pn87n5cRyFgdjy5VETziwGd3JT9s/m0AchwjOpKH8fkBH0O+wNBvXUPrmGrpwIHZZdjfKTWYi9hKfsmgkjLcUaA5XCMi5TCJwpnE9G2cASB/difuHDX16QjrA04vdJmPOT8PQY0x9EcmqBBx2plK3ec55tXcVrhuleIfC7SecUdfAcUDFR/3g3diZ/W+ANTfyCLnTLCu0SCuotJROGXiRSWu26kN7JazTm1E8ag72r8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AWTJBSWJ/0MS3pnU+V0agEVXm/e3nLqndLH+m5bZw8=;
 b=ucnOACrEWCL2u2xIs3KaXRUPPn7eGIOL5IcTXwG8/DWC/2XWTbK1MmA4uFiIswth6qOQtyxl0BT+NWh3Z+xsifQTwXhKavqw//N6EWl5VyMDGI4auzMOcDZ0G+LwKWa/8HO+5MfycTgDzZqL2zi0oeBKBOHAOI4OeuAEBoxfC2VuscB35ffwqtHOV2+vtzrlf1s+AFwzIMtZB55uSJ2JjqC94BahlTKgOBCEbJcqXeKEhaJUlwcnSG09tRF8LwXev9C0xPlLso/FAe1RtJLH4am55ckiYhNQkq3is9TutyddTic6H6HgGOl5F57i65Y5q7n2I988Mdqf7FlCQUzHuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6514.namprd11.prod.outlook.com (2603:10b6:208:3a2::16)
 by SA1PR11MB8522.namprd11.prod.outlook.com (2603:10b6:806:3b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 15:57:50 +0000
Received: from IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::c633:7053:e247:2bef]) by IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::c633:7053:e247:2bef%4]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 15:57:50 +0000
From: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>
Subject: RE: [PATCH bpf-next 1/6] selftests/xsk: Add packet stream replacement
 functions
Thread-Topic: [PATCH bpf-next 1/6] selftests/xsk: Add packet stream
 replacement functions
Thread-Index: AQHbg3c/wyLoJcUTNUWxA7goj0wMj7NQd54AgAe9LPA=
Date: Tue, 25 Feb 2025 15:57:50 +0000
Message-ID: <IA1PR11MB65141726E8FBA7E01DA259EC8FC32@IA1PR11MB6514.namprd11.prod.outlook.com>
References: <20250220084147.94494-1-tushar.vyavahare@intel.com>
 <20250220084147.94494-2-tushar.vyavahare@intel.com>
 <Z7dqTLVxnVcO3YyF@mini-arch>
In-Reply-To: <Z7dqTLVxnVcO3YyF@mini-arch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6514:EE_|SA1PR11MB8522:EE_
x-ms-office365-filtering-correlation-id: c576b934-ac15-4088-4119-08dd55b5280c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d2x2OUZjQnM3bWZWbXpnd2pqQW5sZ0ZUWHB0eUpJdjhtUnBYaThmbnZUaS9J?=
 =?utf-8?B?cG9JMXl2ZVAyWjd1NXM4a3ZBQVdUc3JtaFI1MHM2ZGpyRmx3QnZHZm1WcVl0?=
 =?utf-8?B?bytCUGxiSGRSWWt6OHFwcUVhRUErRXRvYWdRbE0zVDNDR1piMllpVGVobnA2?=
 =?utf-8?B?cS9qczhaamRaV0lIZ0NzMVhMdWN1ajNCTVp1V3hQSkp0MmEvT1VDOW8zYW1R?=
 =?utf-8?B?QnN5SzFxbGpZdGVHTlBqMDNTQVgwNnFDSkpvUW9UR2EybTJadVk3RUhsUnB5?=
 =?utf-8?B?MkRlU0kxRjZnY1haQ3ZzWHVMUGdkNlR2UjEyNnZIZzNaVmU5TFRPcGZTckZ3?=
 =?utf-8?B?d0FHYktObEJjWWtqNVN0ZUxPWUhtbGh4bVVkSFZiTUNOTWFIOHNqY3VBM0px?=
 =?utf-8?B?VUcvMFYvQUY2dVVGSDI5MC9Xd2FBc0w1bHBUSWxkakpmSTRMbW41akVudFdr?=
 =?utf-8?B?VXFsZEpxek53dTVDTENKN2J6c3ltQ3RSK3o0R1NXYnNjRHptQ1hsVk1hZFFW?=
 =?utf-8?B?OFN1YUFLMEp2a0R2U0cxQm1QWExmRjRGaUVTTTh5dzAyVUJiZG43VHVrM0p3?=
 =?utf-8?B?cE9rVWJaNFhJNHFaN2pMVFpBdHo1Mm9PTTUrRkZBbjRhMXVQZ05hWWUrYUNI?=
 =?utf-8?B?bFlkMkpKVzZxQ2xPa2lGR0ZoVE5pSFRGMUR1dE9FV1NHejE5MFRnQUVPU1o4?=
 =?utf-8?B?alNmbTlST1UzYlFSR2VXclBONDVieGhaMCtoa254c1RHNkpQQXIxN0U1YWEw?=
 =?utf-8?B?cXB0Ty9UTFlCaS9SOWU3ZVFsT0F6bWJVNXdocnNxclc3MXRSYnpVT1VwRkNL?=
 =?utf-8?B?bG4zSnZqekljZ0VDVkdSVWNPWHdnOFJwd0VHaFB3UnNhVVl2NmticlNCYm9l?=
 =?utf-8?B?MlliQVV5OGR0NXNPZmF3MFRTWDZsV2JnemtvUXJ0Uk9ITXlnb3ZES3BxdVlT?=
 =?utf-8?B?d25tSTNQZWpwaXlqcUMwaUZ0bUJwTFkvYXlKOVBFaUYrMS8wNFlxSk1FR3hw?=
 =?utf-8?B?cGwyYXltd2NRaDdTZ1h6d2IwanZvSm9FL0JicEluNklCWGI0K0dvZy96RzVo?=
 =?utf-8?B?K1pIQWNUR0lXQzRadXBFRmM1aWlIZCt4a2oxMFJLSGwzck5FakJ1T2lrWkdr?=
 =?utf-8?B?cjF0S0d4ODgvRk00bGRkeXgrRzRFRkYyeDQ3NjFXbFR4QUxxNXpjUlNOR3Vi?=
 =?utf-8?B?UlMvZWpTSXZKRVU3b3Ird1BFYWJidEYvWStNQWdpRUUxV3BndmtvcHROcTV3?=
 =?utf-8?B?TEllMFcrakpjaEpjYWI1MzRtK3lZUFVXcWY3WndoU1RGTFNHWjNpRU5tUWF3?=
 =?utf-8?B?SmNqRWFhMEIrbHVCNW5mblBDS1FpRGY3U1VTK29lYnFDOUNJRnd2Rm5IZEZM?=
 =?utf-8?B?cDUxNWVmbHNROFFtM3luL2RmU0Fqc1dkWmRrdHE5VldacWhLR2ZJdjZTMDN6?=
 =?utf-8?B?eVJxQVM5Qjd4T2RKT2tHYzE1bytycW1ScjRmQ3dvNlpuYU9YTldsa1JXdEQv?=
 =?utf-8?B?ejVOTmdZdCtNeXVxM3hONDBzRTc0MlpmTnp2Ync4Y1BvdDYzS0p4Sm9vZHZm?=
 =?utf-8?B?eGpWTWtrU25FTzBxNkJ6L3NwUEgrU3pxSVdySm5LcGlmTnV2YVZXdEU2VDRJ?=
 =?utf-8?B?NHNFV01HdTExSER3UEJsMnZ0VU5oVVFtTGRwbFNDdFNnd1BVczlBaVcwV0tM?=
 =?utf-8?B?dmtKbDQxV200WnRzZWVIRnpNU2NTQ0djUUZ5YlkxbnBUU0F2K1JWc3JYNHR0?=
 =?utf-8?B?Z01ncHpudzFNWFVTMWhMTjh5NW84R05LUFd3TlZ6cHdxOFVkU2oyaXZHemJv?=
 =?utf-8?B?bXh2cE9hTVRUTUxvN251am9ZN0V3N2RsbS9NdXNqVkszc2xDeU5qcUE5eHJ0?=
 =?utf-8?B?a2orVmJiQ0YraGFUTEZSVmpGOUFRTVZTQSttOHorNGdabXZoZDVmdVVrSjc5?=
 =?utf-8?Q?pxPw3EnLdapyMTs6JUndZs+gwqLxjxXY?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEJGM0l5L0hLOGxKUldtMDlUSWJVK2ZidlIwa2Nmbk9ZLzdFQ1pMa1N4aFhy?=
 =?utf-8?B?NHoxakRTODRQNjZZbWQ1elpMTXNtdFZ4Qk5OUG1hRDI0cktUS0ovZktaaDJm?=
 =?utf-8?B?UVlxN2F0Sy9aYWJMZFFCbjdHZzJYem1GbTRNKzladDFoWHFYa0NFbVpRKy9E?=
 =?utf-8?B?Y2lJZHZMK2l5cy9NTUJ5bGJjcExOd2ZkN0JBTkY5ZUhvekxrYisvRGVoMm1V?=
 =?utf-8?B?azduZ1YxVkZoQ25DRVdGQWJTQjRPblN6NFdRdXptazRBblpNaktBSDBPZGhz?=
 =?utf-8?B?OWFzQzR1QTRHNk14R3JwUVlMQklKVUhUWEVTdjZEQ3FhaTZRa2FFOWorYm9H?=
 =?utf-8?B?LzcvMC9zakR2WW5YT2h1WXVsTHlKMGFPM0NGRGY2TTR1eS81ckpyU0hFcE1t?=
 =?utf-8?B?cVdSYlJBcTRyZHZKYWtEUGdIK0hseG9kZzFUUlZyZmlBZTMvTzJxUVpIdmNx?=
 =?utf-8?B?b282MzN4b0lEbU1wTHUwN292QkJTdWpGT2lYbVVnc2pqTHMzYzdtMlZSb1hz?=
 =?utf-8?B?VHYxWFlFMXhxU2hWN3IvaVEybEZWc3VENWZSalp2RmsraGp1bGhnREM4Q0tW?=
 =?utf-8?B?aWNLWnB2bW5sOE1hQlJweGdsSWY2c1c3Yy8vbXZDbUJiSnRHZXlhdCtNY2pH?=
 =?utf-8?B?Z2NBMjl0SVNQR1hrTHk0eUdwWmlZbjFENVNSRzBBYkZ6U3ZGTmpXT0FneTVq?=
 =?utf-8?B?QW85R2cvY3M4VnRNYmNjcVJSTTdBYWMyMGVDd2RQRmRTM1F4UC82VWhvNkhY?=
 =?utf-8?B?ZFBlazlzRXNtRzFERjFuUklUOFhDRVF5MnJvc05yZkxVTnFzZlVqOGQvT2o5?=
 =?utf-8?B?a0tDOHBZZEtvQTdHVVhNcFBnWS9xRDBaVFFFT0RsT0Jpc0kreVg0dytCZGFx?=
 =?utf-8?B?NWVWMHk3MXl6L0s1dFFWUE5YQ3N6MysrYjBZRG5pSmpDZ3FqckZSTGpVK0RR?=
 =?utf-8?B?WDFiQUk2TGZYSkExRkwrUGs3Qmh0VDZEeHFoUFlRMllnc1FGR3QxR283VUl3?=
 =?utf-8?B?cHVEaGxlSlljL2M4dUo5OFZvQUxvbnJlRC82UmduaUJVUXQzWjdWZFF0OVp2?=
 =?utf-8?B?b1RpcVhmTEVhempEVDM5S0RHaWxkRzRCNWxkUStGQXphZUhsV1ltV3hrRFdK?=
 =?utf-8?B?Z05adTE2dFFZWjBnVS9zdE8yWjJEMmdTKzc2Z2p4anBPNG5DVkFrelFwQ1N1?=
 =?utf-8?B?QkZYdmhjVXhlOEpQbnpySUtxNEdCYWxZOW01N29GTG8ybFJrSTMwand1NEhj?=
 =?utf-8?B?RExRbGhZczd3TlBYZ2FXdjFWaDR2bWdzWnljekNYNlo4NjVOZ2VDTkhPRlFI?=
 =?utf-8?B?MStpRlBFc2ZUUWF2eTlFbS9DT29UbE45U0dVbW53SVczQjNnYXVxOUtWZ2R0?=
 =?utf-8?B?VnprZUFYa0N4NWY1UzRROEJJSnpVQmJtRXRVbFJLUzVEN29aM1o1N05mdnkv?=
 =?utf-8?B?ZWk4c283cFNNWER3YWhOMCtTbHhDRjdsWFNrai9acC9FUHlhVlRWVmo3dDlO?=
 =?utf-8?B?Q0YzRmNuc2tXdGU1eko4TVdOYVVuY2VuZzZGZHZLSUlXUXMrQ2hlOE55OXJT?=
 =?utf-8?B?TTB0N0VxUGd3TnZ1c3VwVDMvaWYxUlFqSWo4TVdRSkVSUkE1dzRWcnBNbGJu?=
 =?utf-8?B?RWx2cjNFMDVKVzB2MThXWFg0TUxmeHNYMU1LazR2aFlYek1MZFkzUmdWTE5N?=
 =?utf-8?B?Z0RuSElMVGFhSVlkeDJKVzB0U1RQZGN6VkVLUi9sWXRnbkZPcG9uNVkzSGhi?=
 =?utf-8?B?NGdJWGJTWTA0MzkvazEveTRDRmw2c0VxV0hvTmp2ZldianE0K2dFRk9nanFT?=
 =?utf-8?B?R1MzMHFMNCtrQ2VYQmhlSXZhUUQvWUtrT2tnRWVhUnNwZ0lZSktsVUxlMVpM?=
 =?utf-8?B?U0t6Y1IvN2ZCd3kwRW1mL1cwNStDUlFmZmg4dGVzYmI5VEhKWTFHU0hYTjhH?=
 =?utf-8?B?bmF0My92Skl2YkE2SmFYS3NscmNxbWRlV0taZG1mQUtUenF5aGV2bXMzMGw2?=
 =?utf-8?B?MHJzV2xNUHJIQmY1a2Z1L0tGU0FCeGo3aDBPc3dHRXh1MWlRZ0g2Ry9OV0NN?=
 =?utf-8?B?YTl6RmliUC82TTYyN0p6eHl4Q2t6bC95eVE2OXhZMUthR25EUUdqVXd4NC83?=
 =?utf-8?B?c3dGZzU5OElXbXVJdzZQNTYrU0dOSXQyUWNmMnZpd0RObFlMejJkR210aTls?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6514.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c576b934-ac15-4088-4119-08dd55b5280c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 15:57:50.5463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6EboKnA9lmSkC/m+cqVL/CAkvR8cjPAXDW/uZaEwAUhLE8lE5GNYZazpPvxIpGOdngPUyH1VWojJ2QluD8/zQBZX0yBIrigTKnd45Ubpok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8522
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RhbmlzbGF2IEZvbWlj
aGV2IDxzdGZvbWljaGV2QGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDIw
LCAyMDI1IDExOjE2IFBNDQo+IFRvOiBWeWF2YWhhcmUsIFR1c2hhciA8dHVzaGFyLnZ5YXZhaGFy
ZUBpbnRlbC5jb20+DQo+IENjOiBicGZAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJu
ZWwub3JnOyBiam9ybkBrZXJuZWwub3JnOyBLYXJsc3NvbiwNCj4gTWFnbnVzIDxtYWdudXMua2Fy
bHNzb25AaW50ZWwuY29tPjsgRmlqYWxrb3dza2ksIE1hY2llag0KPiA8bWFjaWVqLmZpamFsa293
c2tpQGludGVsLmNvbT47IGpvbmF0aGFuLmxlbW9uQGdtYWlsLmNvbTsNCj4gZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldDsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgYXN0QGtlcm5lbC5v
cmc7DQo+IGRhbmllbEBpb2dlYXJib3gubmV0DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggYnBmLW5l
eHQgMS82XSBzZWxmdGVzdHMveHNrOiBBZGQgcGFja2V0IHN0cmVhbSByZXBsYWNlbWVudA0KPiBm
dW5jdGlvbnMNCj4gDQo+IE9uIDAyLzIwLCBUdXNoYXIgVnlhdmFoYXJlIHdyb3RlOg0KPiA+IEFk
ZCBwa3Rfc3RyZWFtX3JlcGxhY2UgZnVuY3Rpb24gdG8gcmVwbGFjZSB0aGUgcGFja2V0IHN0cmVh
bSBmb3IgYQ0KPiA+IGdpdmVuIGlmb2JqZWN0LiBBZGQgcGt0X3N0cmVhbV9yZXBsYWNlX2JvdGgg
ZnVuY3Rpb24gdG8gcmVwbGFjZSB0aGUNCj4gPiBwYWNrZXQgc3RyZWFtcyBmb3IgYm90aCB0cmFu
c21pdCBhbmQgcmVjZWl2ZSBpZm9iamVjdCBpbiB0ZXN0X3NwZWMuDQo+ID4gRW5oYW5jZSB0ZXN0
IGZyYW1ld29yayB0byBoYW5kbGUgcGFja2V0IHN0cmVhbSByZXBsYWNlbWVudHMgZWZmaWNpZW50
bHkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUdXNoYXIgVnlhdmFoYXJlIDx0dXNoYXIudnlh
dmFoYXJlQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
YnBmL3hza3hjZWl2ZXIuYyB8IDI5DQo+ID4gKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYveHNreGNlaXZlci5j
DQo+ID4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYveHNreGNlaXZlci5jDQo+ID4gaW5k
ZXggMTFmMDQ3YjhhZjc1Li4xZDliMDM2NjZlZTYgMTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvYnBmL3hza3hjZWl2ZXIuYw0KPiA+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2JwZi94c2t4Y2VpdmVyLmMNCj4gPiBAQCAtNzU3LDE0ICs3NTcsMTUgQEAgc3Rh
dGljIHN0cnVjdCBwa3Rfc3RyZWFtICpwa3Rfc3RyZWFtX2Nsb25lKHN0cnVjdA0KPiBwa3Rfc3Ry
ZWFtICpwa3Rfc3RyZWFtKQ0KPiA+ICAJcmV0dXJuIHBrdF9zdHJlYW1fZ2VuZXJhdGUocGt0X3N0
cmVhbS0+bmJfcGt0cywNCj4gPiBwa3Rfc3RyZWFtLT5wa3RzWzBdLmxlbik7ICB9DQo+ID4NCj4g
PiAtc3RhdGljIHZvaWQgcGt0X3N0cmVhbV9yZXBsYWNlKHN0cnVjdCB0ZXN0X3NwZWMgKnRlc3Qs
IHUzMiBuYl9wa3RzLA0KPiA+IHUzMiBwa3RfbGVuKQ0KPiA+ICtzdGF0aWMgdm9pZCBwa3Rfc3Ry
ZWFtX3JlcGxhY2Uoc3RydWN0IGlmb2JqZWN0ICppZm9iaiwgdTMyIG5iX3BrdHMsDQo+ID4gK3Uz
MiBwa3RfbGVuKQ0KPiA+ICB7DQo+ID4gLQlzdHJ1Y3QgcGt0X3N0cmVhbSAqcGt0X3N0cmVhbTsN
Cj4gPiArCWlmb2JqLT54c2stPnBrdF9zdHJlYW0gPSBwa3Rfc3RyZWFtX2dlbmVyYXRlKG5iX3Br
dHMsIHBrdF9sZW4pOyB9DQo+ID4NCj4gPiAtCXBrdF9zdHJlYW0gPSBwa3Rfc3RyZWFtX2dlbmVy
YXRlKG5iX3BrdHMsIHBrdF9sZW4pOw0KPiA+IC0JdGVzdC0+aWZvYmpfdHgtPnhzay0+cGt0X3N0
cmVhbSA9IHBrdF9zdHJlYW07DQo+ID4gLQlwa3Rfc3RyZWFtID0gcGt0X3N0cmVhbV9nZW5lcmF0
ZShuYl9wa3RzLCBwa3RfbGVuKTsNCj4gPiAtCXRlc3QtPmlmb2JqX3J4LT54c2stPnBrdF9zdHJl
YW0gPSBwa3Rfc3RyZWFtOw0KPiANCj4gWy4uXQ0KPiANCj4gPiArc3RhdGljIHZvaWQgcGt0X3N0
cmVhbV9yZXBsYWNlX2JvdGgoc3RydWN0IHRlc3Rfc3BlYyAqdGVzdCwgdTMyDQo+ID4gK25iX3Br
dHMsIHUzMiBwa3RfbGVuKSB7DQo+ID4gKwlwa3Rfc3RyZWFtX3JlcGxhY2UodGVzdC0+aWZvYmpf
dHgsIG5iX3BrdHMsIHBrdF9sZW4pOw0KPiA+ICsJcGt0X3N0cmVhbV9yZXBsYWNlKHRlc3QtPmlm
b2JqX3J4LCBuYl9wa3RzLCBwa3RfbGVuKTsNCj4gPiAgfQ0KPiANCj4gbml0OiBtYXliZSBrZWVw
IGV4aXN0aW5nIG5hbWUgcGt0X3N0cmVhbV9yZXBsYWNlIGhlcmU/IGFuZCBhZGQgbmV3IGhlbHBl
cg0KPiBwa3Rfc3RyZWFtX3JlcGxhY2VfaWZvYmplY3QgdG8gd29yayBvbiBwYXJ0aWN1bGFyIGlm
b2JqZWN0Pw0KPiANCg0KV2lsbCBkby4gVGhhbmsgeW91Lg0KDQo+IHN0YXRpYyB2b2lkIHBrdF9z
dHJlYW1fcmVwbGFjZV9ib3RoKHN0cnVjdCB0ZXN0X3NwZWMgKnRlc3QsIHUzMiBuYl9wa3RzLCB1
MzINCj4gcGt0X2xlbikgew0KPiAJcGt0X3N0cmVhbV9yZXBsYWNlX2lmb2JqZWN0KHRlc3QtPmlm
b2JqX3R4LCBuYl9wa3RzLCBwa3RfbGVuKTsNCj4gCXBrdF9zdHJlYW1fcmVwbGFjZV9pZm9iamVj
dCh0ZXN0LT5pZm9ial9yeCwgbmJfcGt0cywgcGt0X2xlbik7IH0NCj4gDQo+IFRoaXMgc2hvdWxk
IGF2b2lkIHRvdWNoaW5nIGV4aXN0aW5nIGNhbGwgc2l0ZXMuDQo=

