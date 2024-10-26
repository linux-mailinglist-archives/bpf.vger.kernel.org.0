Return-Path: <bpf+bounces-43248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DE89B19EE
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 18:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31AF5282842
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 16:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E32A1D278C;
	Sat, 26 Oct 2024 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4YUgcxJ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEACE168BE;
	Sat, 26 Oct 2024 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729961831; cv=fail; b=Y/FBUJ5yPUffRQ/XrFeI9R6UvYcni96Rlv8W8n2LJwX9qQPIPJBZQ4erKQ3go60KMcyJ0/XJ4Lptl4gZZ0SajymqPcy5UITYUKowvxDO4sYZMnEyyNyMvvrg2E+mM6eHNp707J+3l3ugM2fTXVUDl//Fm/1hJVYgAOkkm8RwXNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729961831; c=relaxed/simple;
	bh=0cLE4UK0eyEwRpjHQcCRqVRNAxvC5pJDzu8m5oajVNM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dOKNm7gpes018KAwl44IxyDT+/pfLEMxnitTRM8OpO9FYAgSOnEGNFCkmir7oSdWRJklx462P8SbP6JVw9C2HcZA9Mg6hMN/2RnYRAddwHNklGapwpG9mUU1LhTzin8IM3mtC66PlWABtVgfgzxmIyLDwgIb9+/S8covyZMCb1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h4YUgcxJ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729961830; x=1761497830;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0cLE4UK0eyEwRpjHQcCRqVRNAxvC5pJDzu8m5oajVNM=;
  b=h4YUgcxJzXysREI0LRs2svuQ+dqMTriEQ1YSziQnqs/MfIiKdnkrkMN5
   I/6PSdwmCd/Hzdzz1ImiHHBUNW975KLALfhuXcXREEZchLHYIHtYnHcoD
   YAkUpCytDeKVH8FFWGSd+02qcmnI1LiaL05iJxMvULTqumlIQoNNzT93T
   n5IzObsdG7AAlZZb5KKJulKfbmMc5l9wm7KWuBdLe/ucRPRvIxtneAvDr
   IdJhFgQR4reYG1n2QjgUlX1nP9DTsFa7ayGekJqNF79iozpZSPZR8BFCC
   QHhGOrh0Crk/IPVwHJBeG28/TOHYAOKoMdg42PhNxdDwa3b39a/1GD4MI
   A==;
X-CSE-ConnectionGUID: EKjXSoZATLySrRBb7hZb8Q==
X-CSE-MsgGUID: lG6OOuHeQPCtJ6UiRVBKKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29753381"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29753381"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 09:57:10 -0700
X-CSE-ConnectionGUID: 5Ur3EIX4S3e/Gn6JK1zsaA==
X-CSE-MsgGUID: v5YO+DQHTcGY3bdwZwLW/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,235,1725346800"; 
   d="scan'208";a="81121384"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2024 09:57:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 26 Oct 2024 09:57:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 26 Oct 2024 09:57:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 26 Oct 2024 09:57:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPE4t3xHPtNbPBl02FbrurtU+L7aymL0CesMn7P/vj0G7AfpwsN9DZLAbpe5PqXJt5SQAn5fsPmg0tNZX6v6YyPO+ITTKV7mtIs4QO8vueabsE0RIMqicfiVYKXGwzqZJEQNuYIQCCwmIVCaIfIYQxnzMNBd1ehDHDM9r8OL59C89V+mYT1bVu/ZjDjKY3lzp4MH3iSkJxj2W4ayCsYMuY7Bmsn1Vm/eB8KDybjGjugxZc6QyJBmWqRfjeN3aT0hB5M2+3fNvwDVT5jN2WrsbJZegR+wnK31b599LaOlof0fg2XxKhw20Lrx7I7J7UMg4kAfH2gvGqoE9nBsdXyplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cLE4UK0eyEwRpjHQcCRqVRNAxvC5pJDzu8m5oajVNM=;
 b=AHVTSU91budZWJqSeC74eF1GiJAIPFBfGnrTfAEfLVNxxSoYvqM5w37GJpf6khduakA3JPJQUKgHPmD+GRSlJNKNuI0WkoAQEziT4YhMe262nEjwxi8QmyXMYYhGVs8m9PX1VJTnOTvjqzlLL8g+rUr2FMesumDlQdelvcXSlLlftUFnde9NXEnEbIPYvaFrrkNIgkrF7xzE5YfjPSiN1LGQTvZTOEWiy7/n8/PhfxF/J+2GVtK+n4f0qTREfRPKlfU3TLP+2C795+4EZg3A1NYb9lLCHSnOIq25ljNVayKhQ06xtpXGMM5pwc5OsEzxvnv2vXBHIRO6+DmqWutHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5144.namprd11.prod.outlook.com (2603:10b6:510:3e::20)
 by CH3PR11MB8589.namprd11.prod.outlook.com (2603:10b6:610:1ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Sat, 26 Oct
 2024 16:57:05 +0000
Received: from PH0PR11MB5144.namprd11.prod.outlook.com
 ([fe80::5889:7208:6024:bbcf]) by PH0PR11MB5144.namprd11.prod.outlook.com
 ([fe80::5889:7208:6024:bbcf%4]) with mapi id 15.20.8093.023; Sat, 26 Oct 2024
 16:57:05 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v9 1/6] igb: Remove static
 qualifiers
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v9 1/6] igb: Remove static
 qualifiers
Thread-Index: AQHbITlkbS0tf38hZUSIYJWqivcPfbKZTX8w
Date: Sat, 26 Oct 2024 16:57:05 +0000
Message-ID: <PH0PR11MB51440034677DA8138777D9CAE2482@PH0PR11MB5144.namprd11.prod.outlook.com>
References: <20241018-b4-igb_zero_copy-v9-0-da139d78d796@linutronix.de>
 <20241018-b4-igb_zero_copy-v9-1-da139d78d796@linutronix.de>
In-Reply-To: <20241018-b4-igb_zero_copy-v9-1-da139d78d796@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5144:EE_|CH3PR11MB8589:EE_
x-ms-office365-filtering-correlation-id: e4b429c6-5b0d-47ad-5f6c-08dcf5df385b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NThtUUxacDY5Qnd2R0lUbGpJaTJyRWpES0ZFb3dhZm8rZmk1U0FXa2JKM0tZ?=
 =?utf-8?B?VW43WUFOTm5sRnk5SEdPR2V3a25PT0R3NFhOemp1YnJHQXdsQXkvcWdsYWVL?=
 =?utf-8?B?WlNEWmR1Rm9VSlVYWUk0WjU3NG1YNEFNVzVGZTdnQnVEdkVCeVVsR1VvajRl?=
 =?utf-8?B?RHJKK2oxZzFqNzYzZ0x6QkZCb2lNRHU3NlJiQ3NVZTJrUmZZeU5KSXNXQk1Y?=
 =?utf-8?B?dWQ2emNRQnFja2VWWVI1R245QUhaMmhyb0lCT1M0dGRveFpydjI1SFhTcWpB?=
 =?utf-8?B?UUVXS1ViUC9adVhsUzFINVp5TkJlbUdPd01kZUhqTnQ3ckpKMkpWbHMxVmF6?=
 =?utf-8?B?MnYxQlRXRnZuZFNvSlEwYzVPMUhJeU1uaGJwV25CdlBDOVlOdGhWVWNHSU1T?=
 =?utf-8?B?WVhkL2NEeVJ0U3Z1RFBIdk1rQVA0QVlNQjlTOHJoNWxKZk5XdXNwNlNNc05m?=
 =?utf-8?B?YTRYb1BsamtOV2ZjSGxneXdSQ2NoaUpVelpBS3ZGcFNaRTlnblcyZTRuMVRI?=
 =?utf-8?B?YThDVmYrTWU0RFFNRDliaHl2bW9aYkdNcWdiV2taT0pMV3NUWDV0VStSQ0xP?=
 =?utf-8?B?VWx1b1ZMY2RSR3lvU0tsRkQ1c2lBQTRCdVVxRytwUlM0QUMvSU9JQzFyT0ZI?=
 =?utf-8?B?K1RUb0VEMzI4K0gwRndReS9xRXBaYkVZMms0ZFNSNnI3c0xHM01FZTU5UUFK?=
 =?utf-8?B?aWwyZGlBMHFHeVNadm1PTCtuK0dSRkE0cVd0TkwrYnk0aGFxMFdZRFJtYVZU?=
 =?utf-8?B?R0htRHFINHpnOVBTMzlWL25mNGozUEF3RWUzTmRTM0lBbzRtWmJYQnNOcWpo?=
 =?utf-8?B?VUtNbTgyM0JKUktHK0UxVFlnRkRhaEc0c2pZMkdhUVhaSHgwaVRCM1FoeENK?=
 =?utf-8?B?RWJkaFV6NlM0NkRZQW9YbVJoR05xakNtN29WakdDN2N3OHJUczhiQnRhanZ4?=
 =?utf-8?B?d3BBWVRhc0dSV2pPL09QblRpRXRRUk9rR3kreHVoVkJ5QUxSaUdLM3ZSWXhn?=
 =?utf-8?B?dVZ6djZ6SWswS1JzSVJjMU1HMVFpeU5LbFJkd0ZNWm15NDlXR1lEWUVlYUkz?=
 =?utf-8?B?VU9ESVR0ZE10UTJsUi9LSG56amxydUcxUGdueWFJMDM2Tlh3aHFwVmtGOEJq?=
 =?utf-8?B?MExWSkpyb3ZKTFIxbm1QWEh3TnZQOExBbVdRWTlwd1FJQ1h6aElrWmpXTjQ1?=
 =?utf-8?B?Y3luangyNGpSQ0FFOTc0N2IwMG5PVUhualI0VXNIZUZnUDJ3VDhOWDUwc3k5?=
 =?utf-8?B?Nnl3VG8xNXFuMjg2RDRpZzk1dlNCOVRUbmh3a2FiQ2p2SncrbkF6L2pET2Vp?=
 =?utf-8?B?Z3hGZjNQVlJ6UXZhNEIrWkY0MGVnWkV6R0VvRnZQZHRPc1QvNDI2NHZ5bFpx?=
 =?utf-8?B?QlFPYXNTYUhYY1NTb2IrM0ltTTFGVG9sNDFRV1JGeXBaTmk4TkdDUGdvQ3Np?=
 =?utf-8?B?THBucTBtMWFTL0NqMm81bkt0U1VISnVRYituUWFuVGdZbDMyL3FVZUwxcDNp?=
 =?utf-8?B?REpHUHdtNDlHSWdmNXlWL3YvaWNlTWJVSFJSdVBRMCtielRHN1VSM05ZQmNN?=
 =?utf-8?B?UGNhUVNsTTFia0QrRktJRDk1WXBUR2hEUVlTdTh1WXI4bnVWeWxDaytvRmQ1?=
 =?utf-8?B?c2EwajlETkVkNjRMa3VVaURxZE9NSFFOemt4bWlpUlRDcjV1b09ZNUVqMU5z?=
 =?utf-8?B?dEtUSHdnNVFxL2ZkMkpveG1INXl1OXZNU3ZCbExJdVJ4eE5FYWh0SzkxRUln?=
 =?utf-8?B?N3pDS2FRTmhLS2RZMitWVHpzSFM5SFFpN1ZBeHgycWdxV1kwTEtzejgzRVR2?=
 =?utf-8?Q?ElOQEYj8peA+Tv761OocxlH1WVQRakD01o5sM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5144.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVBjUUZQam43Z2p1VUlpME42VklyWnRjV0VjVlJlejZtbEhVOXBETTlQZEVi?=
 =?utf-8?B?eTBUbWVDUjk4VU8vQXY1RGhMQTlnZFZNKzdVOXAyWUJrbE8wMFJtVVl0YnVB?=
 =?utf-8?B?YTZkeUs1T3B4S3pCYU9wRDZCSkVycGQxMzFCVUpLT3NyZUswU2p5SSsrcEZi?=
 =?utf-8?B?ellHenRLdDY4bHcvM2l4aDh1WTQyMHIrNHlwbkNpWG5xbVAxREtvN1Nrb3V4?=
 =?utf-8?B?a1pOTFNTN0o2RzZIaFcwSTYrRGRvNEQyTHlnTXA0VGlyUjA1U3hYMWd6ckVa?=
 =?utf-8?B?UFZpdVBETmtTbEttNmwyaDBrbG5GMEVpNWNpM2p6UTY1bFpxUk1iblh5emtS?=
 =?utf-8?B?WDhRa1JwaGp0UFIvR281M3hCZ2gzMUcxd2IrKy9tYS9Ec0NCZHlZK09qa1ZY?=
 =?utf-8?B?S0xrSjNROUZ4eXdBLzRRdEZubHlDVVFhbS9xVjBRUEh4RkxSMjNIYjJGTGdO?=
 =?utf-8?B?QjN2LzdwVFArd09zV01PeFFBTndQaHNjUjVMSFBGR3N6a0tTNUNqNlpEL1hY?=
 =?utf-8?B?NEJqZjArOG43NVBaTnYyWU1Qck1NSlFuSW5CY3VhU0szcFl0cE1yN3B6a2pq?=
 =?utf-8?B?QmNPQnd0ZDB5dCtYbWc2TkdiamJIcGJyY1hsZDZYaDZ4KzB3UUtjTzRrZXdt?=
 =?utf-8?B?VGtyS2NvT0ErL0k5dzljemJRSTlqZUFoVS9lelQ2L1gvZEc0eEFKZzEybkQx?=
 =?utf-8?B?Ymp3b2R3dndzYU83MWVheXNIeWJDK0lvZXdoV1lxNTkxL0x3Si9MVWFSODhr?=
 =?utf-8?B?a3Y3bGFvNFNFU3pNb0c4UkFndWYzZkF6ZzZ5bTB5RDIxd2pHaXkwWGZ3NUsz?=
 =?utf-8?B?aEFlZ1ZDNDYxUzdsVndnb1ZhZlp4eGJESTRacExNZVRTanVFSGs3V2FnNkxV?=
 =?utf-8?B?SWEzSWt1T1E5c2ZObVl6QkpIWjc4N0NvMVhNVjJGZUlXcDVtbGlRL084dTV4?=
 =?utf-8?B?L1VTQWlhbnkxTDdrakJPU0xGWURLd05IUmltVTZVczRuU3hhRGxXaDdDYzhv?=
 =?utf-8?B?OTlrcDhUcWVhc2ZldUFWUURXT0NNQTViQWo2bWdrREJISFBSNDJ1YnRHTHJk?=
 =?utf-8?B?bmF0WCtpLy9jazBRTHB5bWFiaFRGYnEzeGNtQkorYzhyN3lQUXF2YmdRRkJy?=
 =?utf-8?B?SGU1U1BEeGxQWGNoVm15SVNzQXFtU0xXa3NDc1dWYlByNU5TUkxhNkI1YnR2?=
 =?utf-8?B?TGRkUHUvUlJTK0NXekZ6V1JtWGFRanlUWVpZNElrdDM5U1UrUlZrRUQrTHl2?=
 =?utf-8?B?Qks0Wk80ckttc1hsMitsQ29vcWJNSzRuSk1YeEtZSERFN3E5Q2x0V2J0N0Nj?=
 =?utf-8?B?VXFtVWVteFZpQU84OEoxWHNsUGllWjhrUnloQjVqd3prL3pWUDdJQTV0ZE9B?=
 =?utf-8?B?RjJscGZYM3BoNlk5andHNlpCVFBYamNGQ3JmVUs2a0QxSDVDckp3S2NScjMz?=
 =?utf-8?B?R09sOGNWZVVvbi9neDlTcEI2ZG1wTGVrTFBVckJPNkRVSllZd2Zuc244dWhM?=
 =?utf-8?B?d0JSMnJ4dzhvOGM3dytqc0xMN2xHQ0ZPZ1R6RmYwVDBCc25TcWtFUStSMmVF?=
 =?utf-8?B?emNJalNxN3hBMmdaWW9Eb1k5aGFGMVY2cEhUczloV28vdWJ1aWlDN2dzdDJT?=
 =?utf-8?B?enJqUFRQMXZrcXMrM1pHU2p3UFliSkt5MWFsQzZsMVp2U0ZERi9tVE16b0Yx?=
 =?utf-8?B?ZlF0UUlCU0M2MVBraEZWSmgwK3ZTRkNjakxtalExYUI0T0R5U0xNWTVPZHBK?=
 =?utf-8?B?M0hNeXA2YStoSlNweVRBaHNDVUkxeEs1SHBPaFhQYzJSWFRVa3FFVXV2bHJl?=
 =?utf-8?B?bG9mWFM2WDI3Mzgxb3hrMTU5Znd6MFpybDI3dVJneWNXMFNqalR1WUtDSWxJ?=
 =?utf-8?B?NXNybkZXT2NvV1AyMFZzaDk3V3FGMktVdGtXZjY0WDAwY0dnelJzaENudkFK?=
 =?utf-8?B?UWZteUZ3cXE5ZDVtR0VtWnI5cThxd3htWjFzeUpzbjYyTUZvTldIcGk4dllQ?=
 =?utf-8?B?YmhqTFA0YkJVd2k2SzRzQlNwN0htRGxxOVpNRUk5UXZzK01Idi96eHBNUHRm?=
 =?utf-8?B?WS9iM1ZjV08rUGY2KzJnVURwYmFmazBiOVlQdkxnMERRM1RheU5KdFFNclFN?=
 =?utf-8?B?bGlhd1UvQVVPUW53SFlRWk5ZdnU5bWFEQWtNR3AxWGwvNFRWNm52UzFwL1dI?=
 =?utf-8?B?REE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b429c6-5b0d-47ad-5f6c-08dcf5df385b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2024 16:57:05.1602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EYAs4u0lR7cBG3vJiKuUwausp8AGtLFlTWcKR/5jlFg3feCKwy7n0saaTjGG1rrj2xd5BBpm18e0btZ2Gcf0Vi+Z84N1dKhXPkO6hust1EE=
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
aXguZGU+DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBpd2wtbmV4dCB2OSAx
LzZdIGlnYjogUmVtb3ZlIHN0YXRpYyBxdWFsaWZpZXJzDQo+IA0KPiBGcm9tOiBTcmlyYW0gWWFn
bmFyYW1hbiA8c3JpcmFtLnlhZ25hcmFtYW5AZXN0LnRlY2g+DQo+IA0KPiBSZW1vdmUgc3RhdGlj
IHF1YWxpZmllcnMgb24gdGhlIGZvbGxvd2luZyBmdW5jdGlvbnMgdG8gYmUgYWJsZSB0byBjYWxs
IGZyb20gWFNLDQo+IHNwZWNpZmljIGZpbGUgdGhhdCBpcyBhZGRlZCBpbiB0aGUgbGF0ZXIgcGF0
Y2hlczoNCj4gLSBpZ2JfeGRwX3R4X3F1ZXVlX21hcHBpbmcoKQ0KPiAtIGlnYl94ZHBfcmluZ191
cGRhdGVfdGFpbCgpDQo+IC0gaWdiX2NsZWFuX3R4X3JpbmcoKQ0KPiAtIGlnYl9jbGVhbl9yeF9y
aW5nKCkNCj4gLSBpZ2JfeGRwX3htaXRfYmFjaygpDQo+IC0gaWdiX3Byb2Nlc3Nfc2tiX2ZpZWxk
cygpDQo+IA0KPiBXaGlsZSBhdCBpdCwgaW5saW5lIGlnYl94ZHBfdHhfcXVldWVfbWFwcGluZygp
IGFuZA0KPiBpZ2JfeGRwX3JpbmdfdXBkYXRlX3RhaWwoKS4gVGhlc2UgZnVuY3Rpb25zIGFyZSBz
bWFsbCBlbm91Z2ggYW5kIHVzZWQgaW4gWERQDQo+IGhvdCBwYXRocy4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFNyaXJhbSBZYWduYXJhbWFuIDxzcmlyYW0ueWFnbmFyYW1hbkBlc3QudGVjaD4NCj4g
W0t1cnQ6IFNwbGl0IHBhdGNoZXMsIGlubGluZSBzbWFsbCBYRFAgZnVuY3Rpb25zXQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBLdXJ0IEthbnplbmJhY2ggPGt1cnRAbGludXRyb25peC5kZT4NCj4gQWNrZWQt
Ynk6IE1hY2llaiBGaWphbGtvd3NraSA8bWFjaWVqLmZpamFsa293c2tpQGludGVsLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2IvaWdiLmggICAgICB8IDI5ICsr
KysrKysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdi
L2lnYl9tYWluLmMgfCAzNyArKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAyIGZp
bGVzIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDMxIGRlbGV0aW9ucygtKQ0KPiANCg0KVGVz
dGVkLWJ5OiBHZW9yZ2UgS3VydXZpbmFrdW5uZWwgPGdlb3JnZS5rdXJ1dmluYWt1bm5lbEBpbnRl
bC5jb20+DQo=

