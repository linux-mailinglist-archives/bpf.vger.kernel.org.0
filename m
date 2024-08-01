Return-Path: <bpf+bounces-36211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DF99445C2
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 09:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69D61C210BF
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 07:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943C1158533;
	Thu,  1 Aug 2024 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lm7wdm2w"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA8285956;
	Thu,  1 Aug 2024 07:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722498343; cv=fail; b=uCcKJ/GNXq1EgdPUN/C/q4E65hd87phlIqr4rmkIS2ANkYsfy79xkSsDdj1ffq/FjwtPdCxAHgiav7F92acYNZLQ7C5EiNZASIe2MMePYaWPkDTUicRSJh7Ce11VnKNBuQn8Xd7G2vABeyas5+6PqR7qbDlbWz+59hUWm4p+lO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722498343; c=relaxed/simple;
	bh=mKvEK102HPMjk6CZIOxK5j+YDHCMBL+db7v6fvi7rBM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hcpHF8pIw6NMrBQL75JCy9XmIt2tZeJYXk8I1swgQZH8CgpWuUWMvaJk5F0OR90CB8EpI9YDVz1gN+oArDakBionbbtjgO64YV3hSIqTNTHabpBJeQRjpb6MytV/zsfflwPC20pbMgQAdsBZAJOJlfplXkumfryUge3iWNCzRms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lm7wdm2w; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722498342; x=1754034342;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mKvEK102HPMjk6CZIOxK5j+YDHCMBL+db7v6fvi7rBM=;
  b=lm7wdm2wR+BAqOyicSvITut02S2qqeAKu0+2471lf3BPdX+j2WXdwkJR
   OjT3Qc6Z7bvyvLkV5p1feSPsKGaMydf9k+98aq+tCeg8LpnwVRTe6PeYB
   Np6HhM23TLnzdeq+KyDXfV/p+TfLrmrjqWRZZ0Qq8eXkv7VO72L0PszCA
   ozCdXkHQatdqrn1AFML2mZFDQ7Btkb7rhvKm64ENT15LVL9DVDfrx46UJ
   tbcXkdHengnSCWJMm/OdeVMu6T03kuB+N7ItRzot5NZbjiSnkS7LQWACc
   8jlavR2OMg09cVXgJB4tBPsVp/JhUO4CsH2wsrVg/oL6WebOqUNQAmac2
   g==;
X-CSE-ConnectionGUID: PmO90BjJRE+0z1gS8IYUpg==
X-CSE-MsgGUID: J6yDbjz5THaXzWfEZPeG2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20592754"
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="20592754"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 00:45:41 -0700
X-CSE-ConnectionGUID: MAybUQ/zTe23PD/hnvB0fQ==
X-CSE-MsgGUID: FGFpauYNTMWJo2D4cfznfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="59601972"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Aug 2024 00:45:40 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 00:45:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 00:45:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 00:45:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uY3Bg+wAZCBywskNeWwCITaBXGr5WFJpSuRhGTwL6625loy/XMOLgPCpPVSWxr1srkQWaPRLZJTiLo8xonYZq3zJlTnQo2J29dPEpcEc3EtjMLOyS2ufS62+kYT7+fHXcF1XJf2TsBg7wP1n1+akExRa/D3/Ur/f6eYCseXfYih1KKD98yeRhGdDKMz5n7dMoxqM4QqhZpikN9p0taDt2M82i1H7MGN6R5H5ytQJaFwnNwGEWKoYBa/ijjOSyfKpCYwGyeAu+vC8J2Lo6uJnuj78bzWs1Qi9copNV9A2kYVNcu/LBry3etb7gb+NnEJaIGS/6vu3QfeMPcWPqWfimg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKvEK102HPMjk6CZIOxK5j+YDHCMBL+db7v6fvi7rBM=;
 b=Gmx22REtAf4wWYMMaQQ3g8Sqxaf5cTCmq9AZ+35UPC1wOCeojmQoxJLZa7VOdZCCAKZ0fB2f2EYyWMBh26W8Y/LCswTXXkW1E4d3blg51HlMib1D4cJMKAPKvV2x88fGBG/P+pvKjZGO+qWuY5F49NzeUFcDUKwyTuIG5VFwY2wmIU/DrjT5940sPlIdBHKVNLTOjlGAlayInTtPOwjqTcUC6J1qbVu3hdfKRHq2yHSG4NfXb80E9/VrD4GS7zPD2DUM2HM0b377q4SZI8ZYzX0UYCqptnVGCltfqCltnARGCkiHouMg8v2jkzxQbfSNFQMH78MlmSNtchcIF19h6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by PH0PR11MB4808.namprd11.prod.outlook.com (2603:10b6:510:39::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 07:45:37 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%3]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 07:45:37 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>, Jonathan Corbet
	<corbet@lwn.net>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Shinas Rasheed <srasheed@marvell.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	Brett Creeley <brett.creeley@amd.com>, "Blanco Alcaine, Hector"
	<hector.blanco.alcaine@intel.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>,
	"Neftin, Sasha" <sasha.neftin@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [PATCH iwl-next,v1 2/3] igc: Add default Rx queue configuration
 via sysfs
Thread-Topic: [PATCH iwl-next,v1 2/3] igc: Add default Rx queue configuration
 via sysfs
Thread-Index: AQHa4h84HPiCRxyxF0yMxQmh+zwEy7IPDJ4AgAL1wOA=
Date: Thu, 1 Aug 2024 07:45:36 +0000
Message-ID: <PH0PR11MB5830008CD236D81B7224A05FD8B22@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20240730012312.775893-1-yoong.siang.song@intel.com>
 <171a20b4-0e52-4ddd-a5a5-6f3f3f1d32b0@intel.com>
In-Reply-To: <171a20b4-0e52-4ddd-a5a5-6f3f3f1d32b0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|PH0PR11MB4808:EE_
x-ms-office365-filtering-correlation-id: be802663-33a2-4946-9bc0-08dcb1fdeeba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?MzNmYklSdmZUS2hXWDZpcDV5TGtCbHpiM2MxYjVZQ3ZLTmFQSDdTL0lxaTBU?=
 =?utf-8?B?SG9EbHVvTFRLeTVjckJZQlhPdzJJYzc5bkFiazNuVEE2bStpYktVMXZGeFlo?=
 =?utf-8?B?Y0lReWVCb0ZCNUJZWnVKQ3g3OUJtSGc3cHZYaTdlMFVsQTd3a3dQVm9nanRv?=
 =?utf-8?B?Tm11VjBKaUFjSVhCdnFtd0NZV1cyN1pVRmI3UUUvcmNrQ2hGeFcyYnVvc3Vy?=
 =?utf-8?B?Y1h3KzVya3Fyb1RRelIxeVRiVDQxditwNWloZGVoR24wUVNOblEyTFlpR0JQ?=
 =?utf-8?B?eEFOeUdJV3hPQWVhNGVPSGMrbWdFTHIrdC9NRGJ4citPSzZZYXhGR29xODVu?=
 =?utf-8?B?dkJMTktiblpNZnBpclBGd1dWSmxGVGsxQmQ2TjBEeW1VZHBNZXo2dnBSL25T?=
 =?utf-8?B?K3JpLzI3YVFGWHZpSSt5TGFuVyszVTliQzdSV2ViblVXbjNDNTF0b1czZk5m?=
 =?utf-8?B?SWNxWTR5V20wVFRieEhZRTNMbEtGM1ljWDkzR0JqUnZ1dnc2QkIrS0xZOTFP?=
 =?utf-8?B?TzFtRGFFTlJLb3ROdy92OWtOUUhzOG0xRm1GS2J3NHV5WGpORm1LK2lxb0d1?=
 =?utf-8?B?Tnp3M3dOdU9nR0NtTlpBWkJUczNXeGZySytBS0tIL3AzRnFocHJwM1ZtaFJ2?=
 =?utf-8?B?cERITmxqSEFaOUxqVFJEdWFrTGdqTlBLeDhTZVdleTd1S3lHc3A4c2d6TlRI?=
 =?utf-8?B?TTNaK01mY2R0anc3QWN4S00yQm9QWm5ndFdFNTBORUJaSndQbnpVY1FiSnpj?=
 =?utf-8?B?cW5wbVFSWFRGYmlhOU1xaTNRNEx6SDJBTno5YXlsREZUS0NCWTVxT3psSW1v?=
 =?utf-8?B?K1dqSWYzT0ZKTnZ1VjZLRjVQUFhpbGg5eXUyYUpoc0IybHJ4bi9jUUdDWFFs?=
 =?utf-8?B?dmUrcWk2OFc4Q3pCMG9UREdSYmY5eWEyMVhWU21jZlNJVzNLS05KeFl3blR5?=
 =?utf-8?B?dVVySko2RnkyOVhpeEhCVmVEdS9RY0RxUk1VYkVxbUZwVWNYYWdwMHphSUxn?=
 =?utf-8?B?Zi9WRktlc1orRXRPZVBtQThXUlU2THVGczlzL1N4MHhsaUlRcGJVcFVqOXNi?=
 =?utf-8?B?cUZDcWN3d0FLczBtOVI3NWFRU3hUOXJTM29hWTBhcGRoL3JjR2dGeldHeFcv?=
 =?utf-8?B?dTdoaW1oNlpsQXRndEFOanVzOHFhZklvZGVJYnUrWk95ZGdVWnlvMDIxb00r?=
 =?utf-8?B?TVV4NkhsV2ZEcVF3SG5MNEpzUDR4RG5rZ0ZpRDZPWXpLQU13N00wdHRnQk5j?=
 =?utf-8?B?SVBoeGY2eGdoWmhQTzZ4cGJJT1BhNUE2UFhWZVZPVnEzajdEY1FOKzhiM1BM?=
 =?utf-8?B?dURNdm9va3Q0cWdtTEkyalNjNGlIY3phak1VVzhnaXlwS3BYWHhrQWJSSDBi?=
 =?utf-8?B?MVcvMXNRaFFHcWRvOURaWDVEME9JQnBQZndTUDd2elhhQmJ0WGpITVlCUG1G?=
 =?utf-8?B?anc3ZHczOGY3d1VqVzNJTkFRUHFEUHZRL3ZqcTlOcjhKNHNXMDJxVnp6cEtv?=
 =?utf-8?B?NnhDcjExZHpYL2pXQ1JMelFOSFd6Y3RVVm56aTBnYnZwdEdZNVRuQUJZNWtI?=
 =?utf-8?B?TGZIREtPeTVDVFpia2Qyb1VPRHV2SEoyMC84Mmw5UXpGaUtzSmR2MnFKUDlU?=
 =?utf-8?B?WXhNajRCWHdIR2FPeEc5SGt5REFCSnNWNUV3eDZDRlM4N3hKT3d0ZFZ0Ykpw?=
 =?utf-8?B?MU1hNitkUXhndE1jd0JUVVF1SDdYQkFTeXRlY3VZREZmWTZTN3cvNVVvUzBK?=
 =?utf-8?B?bk1jczdNU2F1SDR0QmdJYnV2YlkxbERoaXl0N2wzY2U0QlNYK2wvOHZOVVp5?=
 =?utf-8?B?WS9DVStnVFRSNndUdkV6b2JsOENHTG1HZFhRa3Q4TTZscjRBODE4U1hsOGhl?=
 =?utf-8?B?andSV3g0OG1NUWJCNTlLaU9XaE5NM1NWM1FxL0F5Um1Bd0RYQ25TVzFsbjdy?=
 =?utf-8?Q?1wSlsN0aiBk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3dEVTVEZDQ2SXlwNURQU0hwM1ZGbEZsM0pidVdXRmhPMHRYaklvL3huWlds?=
 =?utf-8?B?c1JKdnRvYUVOOE5pM1BKeEpUQjlkRXFZeUxHcy9mL2pBOEVUaGxEYnU0dXdO?=
 =?utf-8?B?TEFKSXhMT1RZZUFlZ1c4aFN6S1VMckl5cWxFNE5uN0hJWmQva0ZwN0RMU21J?=
 =?utf-8?B?TGhpcHJLenBjbGQ2c0Y5ZW1NZzY4b3hMeTdCWnpZcXpXNURTSW80bWIxVUV1?=
 =?utf-8?B?Zlk3bmFXc2VvSUdRNjJCeUMvNWRTbU15OGFlcnZHWWtqMXNNRm5GMWRrbVk5?=
 =?utf-8?B?dHBJZVVBUjFEanIwcWduNm5UUzNMSk0waEtHMVFqeEtzQnRvSlk4VkpBK1Zp?=
 =?utf-8?B?eEdJSmZreFhhN2JNc2QxTUdPM1hBV3dLYTg5VmRCMXFVQTF0aVh2UjgrbHNG?=
 =?utf-8?B?NDN4ejdRVkhZQUhGaVpBUy9wSUpNdXk1MjlCSmIya1RaL0dJc0lpMWFtbk9W?=
 =?utf-8?B?U0ozbHpXMlVKSkpQY1k2RFBqWUNBbWJPa1pOR0h0b3dvUDJjd1dIY3Y5ZG1i?=
 =?utf-8?B?cWdIZ3lacVJ0a3Exc3RLd0Y2SzgwMEZCZCtEMzBzMyttZUM2WFE3VTh1V21M?=
 =?utf-8?B?d1RGUG5OWnRaYnlvbU9BYmlqUkYzdWNnL2tNU1RpTldnTTBER1VjeEtubFBi?=
 =?utf-8?B?aklKK0tWRGdpdk5JOWd0VmVVN05ZaXRNeDk4TUMrQTkrYU9LMHIyMGRRZnVn?=
 =?utf-8?B?bVg5dS8ySjg5RVNGTEZ1SnBTMVowU01ZbG5GVksrT1FHZDkwam55ZmVNVHJP?=
 =?utf-8?B?T1l1aXhaYlpRN3JvUHF2YVNSbGIzRkdTUkhmbmhuWnMrK0RwZ0xtZG1uczJq?=
 =?utf-8?B?SHFPcHR3VmtOS3QrbFhFakJpbHIzYzY0SjlZWVBBVmdrWE5TQU1SZ3QzVzA3?=
 =?utf-8?B?M05lOVNaMlpTNXlnWU01NkFCTFNoRzFTajYrQkhMby9GbFJ2MGJiRHVYTWpa?=
 =?utf-8?B?TXE1bkxpSndDVEFLdkNpZ01XbHFpci9PeUJIS3oxZmpJb0srVS9MMXNXNENT?=
 =?utf-8?B?RDg2ckhZQVBHK2o2UXVUenUxeDR4NitjZXBYNStZR0s3Zjkvc0lhNDVjNWdh?=
 =?utf-8?B?emV1bXZpR0RVOVRYeEV1NzRFOGticzVWaXB1MjBFeDNDMTJidkZzYWw2eGVI?=
 =?utf-8?B?SlU2Y0hkSk5uSjZudVk3bUVWMjM5elBZemRCU0dqZXBsM3pmbGxwei9Ua3Vy?=
 =?utf-8?B?YkdEa25GOXB0Mys1a2g4N2JCUFBRV3FaVk9CamcwVUlBUUZaeGh0SmQrd1pX?=
 =?utf-8?B?YWZDZTU5ZU4vVjBpemt3NFpGUzFMVjdQTFBRaW9SVHVpSjNsN0p4OWZiSE43?=
 =?utf-8?B?Zjhtb1FBbWFGenFVaE5vUXpFQ244WHAreWpOdElBei9LVWIvdkdncHBmdE9s?=
 =?utf-8?B?TG95cks0L3JKUjVBRVlBdXV5clMvVGQ1cUY0ZUdSM3ZKWFg3QjEvODgxam0w?=
 =?utf-8?B?RndNUXNNSldhN3RqY2xTOW16SFY4NWVFSzdHeUM2MjR5ZVV4dld5NUVXYVFY?=
 =?utf-8?B?bytEaG4wQXBvaWNRL1pNY2gxNXBjaUJ4bEx0aHprclMreVBtYnVWU1BaTFRs?=
 =?utf-8?B?YVlNNUlwMWcyMml3NGxHemV0RzB6YS9Lc2MzcGVhRjBGT3lVcTV5NUo3eVcy?=
 =?utf-8?B?bzcrR2F5UEFtYWtRL0pkdjMzTXU3Z1ZsYktrTG9Cc3N4ZnMwekt5YUhRZEcr?=
 =?utf-8?B?K2xNQXlVbC9xK1lXeXh6UGNsR3RONDRKY211M0RkY09wTkdLT1J5SVU3ejBp?=
 =?utf-8?B?Q29xYkF0ZHVQUnBLWXVYSTVRL29oMXQ1S25oTHJISGJDcUo4Y2txM1k3U24x?=
 =?utf-8?B?L3Y2T1ZQWElOL015QlgzMnZhelphKzdWUzdXSTNQZVBuUzRuMWtXYVI2WXZq?=
 =?utf-8?B?Qm8rNDVjTHlzenovRm1NNFEvdzBwKzYxc1dOeVR4ZlNkWmFrMWFORmg2elBJ?=
 =?utf-8?B?VVROTE4yNldLdjVQcWJlTVdsVFRxanhXMmRpYXkwVHY3OHA2TE1YOGM1RUdJ?=
 =?utf-8?B?Z2Y5SEJVdGk5TmZMWkcwRlBlUDRpUHYydDFVRjJoaEJYNGovdEYvQnhsNmVU?=
 =?utf-8?B?Y1BnaE9NVFdjUXd3Q2FINXNoUTByR1BPS3RKMmpXMHRGSWI3RjFnTkFheFo1?=
 =?utf-8?B?bVNSVjVkdXVUVENhTEVxdnBKekRPajVaMnlOYzJPai9qakpad1VCYkliZ01M?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be802663-33a2-4946-9bc0-08dcb1fdeeba
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 07:45:36.9703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tbjKYTmDS8o08O2KVt9LzRLpTW5AXhN2n1mQZCnCrpqF9JSGiz8/uWxSiiE4kktNuOiDJ7iCV03iYXyvdQI4eoELzpZrmdAYS0oYFc0Mv2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4808
X-OriginatorOrg: intel.com

T24gVHVlc2RheSwgSnVseSAzMCwgMjAyNCA2OjA5IFBNLCBEcmV3ZWssIFdvamNpZWNoIDx3b2pj
aWVjaC5kcmV3ZWtAaW50ZWwuY29tPiB3cm90ZToNCg0KWy4uLl0NCg0KPj4gKwlpZiAobXJxZSAh
PSBJR0NfTVJRQ19FTkFCTEVfTVEgJiYgbXJxZSAhPQ0KPklHQ19NUlFDX0VOQUJMRV9SU1NfTVEp
DQo+PiArCQlyZXR1cm4gZmFsc2U7DQo+DQo+anVzdDoNCj5yZXR1cm4gbXJxZSAhPSBJR0NfTVJR
Q19FTkFCTEVfTVEgJiYgbXJxZSAhPSBJR0NfTVJRQ19FTkFCTEVfUlNTX01RDQo+DQoNCkhpIERy
ZXdlayBXb2pjaWVjaCwNClRoYW5rcyBmb3IgeW91ciByZXZpZXcgY29tbWVudHMuDQpJIHdpbGwg
aW1wcm92ZSB0aGUgY29kZSBhY2NvcmRpbmdseSBpbiB2Mi4NClsuLi5dDQoNCj4+ICsJaWYgKCFp
Z2NfaXNfZGVmYXVsdF9xdWV1ZV9zdXBwb3J0ZWQobXJxYykpIHsNCj4+ICsJCW5ldGRldl93YXJu
KGFkYXB0ZXItPm5ldGRldiwNCj4+ICsJCQkgICAgIk1SUSBkaXNhYmxlZDogZGVmYXVsdCBSeFEg
aXMgaWdub3JlZC5cbiIpOw0KPg0KPlNob3VsZCB3ZSByZXR1cm4gYW4gZXJyb3IgaGVyZT8NCg0K
WWVzLCB3ZSBzaG91bGQuIEkgcGxhbiB0byByZWZhY3RvciB0aGlzIHBhdGNoIHRvIHVzZQ0KZXRo
dG9vbCBudHVwbGUgbWV0aG9kLCBpbnN0ZWFkIG9mIHN5c2ZzLg0KSSB3aWxsIGNvbnNpZGVyIHlv
dXIgc3VnZ2VzdGlvbiBpbiB2Mi4NCg0KPj4gKwl9DQo+PiArDQo+PiArCXJldHVybiAobXJxYyAm
IElHQ19NUlFDX0RFRkFVTFRfUVVFVUVfTUFTSykgPj4NCj4+ICsJCUlHQ19NUlFDX0RFRkFVTFRf
UVVFVUVfU0hJRlQ7DQo+DQo+dXNlIEZJRUxEX0dFVCBoZXJlDQo+DQoNCk5vdGVkLg0KWy4uLl0N
Cg0KPj4gKwlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRvX3BjaV9kZXYoZGV2KTsNCj4+ICsJc3Ry
dWN0IG5ldF9kZXZpY2UgKm5ldGRldiA9IHBjaV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4+ICsJc3Ry
dWN0IGlnY19hZGFwdGVyICphZGFwdGVyID0gbmV0ZGV2X3ByaXYobmV0ZGV2KTsNCj4+ICsJdTMy
IGRlZmF1bHRfcnhfcXVldWUgPSBpZ2NfZ2V0X2RlZmF1bHRfcnhfcXVldWUoYWRhcHRlcik7DQo+
DQo+VXNlIFJDVCBydWxlDQo+DQoNCk5vdGVkLg0KWy4uLl0NCg0KPj4gKwlzdHJ1Y3QgcGNpX2Rl
diAqcGRldiA9IHRvX3BjaV9kZXYoZGV2KTsNCj4+ICsJc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRl
diA9IHBjaV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4+ICsJc3RydWN0IGlnY19hZGFwdGVyICphZGFw
dGVyID0gbmV0ZGV2X3ByaXYobmV0ZGV2KTsNCj4+ICsJdTMyIGRlZmF1bHRfcnhfcXVldWU7DQo+
PiArCWludCBlcnI7DQo+DQo+UkNUDQo+DQoNCk5vdGVkLg0KWy4uLl0NCg0KPj4gKwllcnIgPSBz
eXNmc19jcmVhdGVfZ3JvdXAoJmFkYXB0ZXItPnBkZXYtPmRldi5rb2JqLCAmYXR0cl9ncm91cCk7
DQo+PiArCWlmIChlcnIpIHsNCj4NCj5ubyBuZWVkIGZvciBicmFja2V0cw0KPg0KDQpOb3RlZC4N
ClsuLi5dDQoNClRoYW5rcyAmIFJlZ2FyZHMNClNpYW5nDQo=

