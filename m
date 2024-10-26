Return-Path: <bpf+bounces-43245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDAB9B19E2
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 18:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0288128280B
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 16:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4011CACF7;
	Sat, 26 Oct 2024 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Izr91eUb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454D02F36;
	Sat, 26 Oct 2024 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729961598; cv=fail; b=QJcCm2lB9S5084EgNGOIEDDRysYcV2j1rRbL08a1LDnjfbyeUQ+MT6wQ+hCEK8di6g/8L/3qRipUiYd4Rmx54Lh3S3bW1C/V0td/1u/e6wt6Tj1FwvhuttB24kvaCD25QQq5oTpS+TQpxFMNzHlSE8jC4BMT272sGW5wKTjPcuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729961598; c=relaxed/simple;
	bh=TwKOmau0FtPhMDNmlJ5mzBaEeHUaFejB2t4l4Xw+Oec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G3AAflZl4VQSSKkFGp8g2PEPa7aW3+E8PSZtEw4Cou4EgcSid5jwBgt9FLoFYWav993TZyqc76klMVz0Y6rxsIWjDL5aNmabKj9DoQZCiNlh7YiXZzp7Pg1sdf/HHK8bATY1HNUU6nh/noYStsyNoe85Uj8iINlWTU9RktwZUfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Izr91eUb; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729961596; x=1761497596;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TwKOmau0FtPhMDNmlJ5mzBaEeHUaFejB2t4l4Xw+Oec=;
  b=Izr91eUbviHJVkZ4CD10Hz3jp7ywTRWNiiOSCd4/HoErFygjS0lh9/DU
   jdW7l33ODqwUo6tMEzCTIlcVaz+jQ5hY++EmGn6uwC+iSuEUjLl96KbyO
   EKluLE/DKw1+nCoRusV92cRnaYS/QhzbBhY+NkwQy/Z+B9pSYqZVH8f++
   6oEOxeAeMxIqAKf6ybaKknGiI9ktVeTVefAPL6npx/nt2Nrea0LYlF9LC
   k2scb2IEuZdvs9LyME5fhhoIfLGsrlvzXKKcaCaetlRaJGELahRcEUqlf
   Xjmwsd4/tvNxfE202Yfg13tdfwEKYFTBTDDnPvl61Vx3NbWG1ZbD5iMoQ
   g==;
X-CSE-ConnectionGUID: 0YQUT24qTgSPGm0XGsk4xA==
X-CSE-MsgGUID: KxIQQVBXTHOa9vC/pB6kuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29475318"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29475318"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 09:53:16 -0700
X-CSE-ConnectionGUID: W/GPjdatQJ+TUyLOr+BOpQ==
X-CSE-MsgGUID: 4Ip/FosJTZm8X3JTinsx5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,235,1725346800"; 
   d="scan'208";a="81248086"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2024 09:53:15 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 26 Oct 2024 09:53:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 26 Oct 2024 09:53:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 26 Oct 2024 09:53:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+6R9vDmLUH83kHRUUzQ3PE0Xotq8gpf754GLvM/nQMzSGOVTlrqfRfN5dVkJpaYSNc2N5tNfWGOhLC5D3GP86Hj6DmfG1+Y0HL84bmzByWMVSvXHpjsJMNoD2x3siQINH1cZJAIgS27dyWPfabnaIK+7JwslApURlZvTGQIawsOltHGzOc4tmfju7y0+UVfXSH9XObCxRyqGF48y29lwh3ntMTQNzbXc+7PtlCpE4YvN+lejKXXY2NmBF2CgltoPJt9qwmD8c0kPZBc+uwKbXZA3VsksdyOzTH6NTeE2JHm1TN95HRqffxHnUYrQwPB1hUSQzUBt64f52DuSZ0MTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwKOmau0FtPhMDNmlJ5mzBaEeHUaFejB2t4l4Xw+Oec=;
 b=wOkChPWUR+aiyoOIHP5d7CHy9qUwiucShfDY/tBvEb+ccOx7IlijLy/ydr4FKhcYcpKrXZNAX+y9Yz+SSAFMr1S9RHRUFMTI5ohD6E9sGJvOgPvCsRcJ93wKCu4BMDuc412b/4U3jx4uO89eMG6tj8MYMFTqAbiLsoS6252yV6oVUocjE2YoR/s/sovWb5RFS8PiM73B1BzGt+l67gyT1xUkUjLvmEiqYKQGC3kuQ88ZmEuFbH/Xb+KATl4lbW371IHXoqM1qG5lzRxQilKc1lWA7XF4j9A+KLfRlWxjJTOStp2fWjuwGMqNdaXs+yxT5OQF2BuAcBOqrum8k+XK4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5144.namprd11.prod.outlook.com (2603:10b6:510:3e::20)
 by DM6PR11MB4676.namprd11.prod.outlook.com (2603:10b6:5:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Sat, 26 Oct
 2024 16:53:10 +0000
Received: from PH0PR11MB5144.namprd11.prod.outlook.com
 ([fe80::5889:7208:6024:bbcf]) by PH0PR11MB5144.namprd11.prod.outlook.com
 ([fe80::5889:7208:6024:bbcf%4]) with mapi id 15.20.8093.023; Sat, 26 Oct 2024
 16:53:10 +0000
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
	<netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v9 4/6] igb: Add XDP finalize
 and stats update functions
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v9 4/6] igb: Add XDP finalize
 and stats update functions
Thread-Index: AQHbITlp5NKMCsmueEqX1rqFhPQXlLKZTHlQ
Date: Sat, 26 Oct 2024 16:53:09 +0000
Message-ID: <PH0PR11MB5144BD20B1A88F5CEDE926F8E2482@PH0PR11MB5144.namprd11.prod.outlook.com>
References: <20241018-b4-igb_zero_copy-v9-0-da139d78d796@linutronix.de>
 <20241018-b4-igb_zero_copy-v9-4-da139d78d796@linutronix.de>
In-Reply-To: <20241018-b4-igb_zero_copy-v9-4-da139d78d796@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5144:EE_|DM6PR11MB4676:EE_
x-ms-office365-filtering-correlation-id: 0dac0654-1f25-4fb6-e5e3-08dcf5deac29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L1VsTzhOeVM3amxvemhkV1FZSWtnSmNrT1ZHOWI5aXhNQ2xyVDkwSStNWkZ3?=
 =?utf-8?B?RjIzcDhpSTBaZG9pOVNhc3R2cmFuWkR0VkJlY1dIakE5azd6bXlQVmZXNFRL?=
 =?utf-8?B?TkhudkhHZkU0VlkvcU1CS3czb05rK2cwSDJWejhmdDJJK0VLenRsbzRwSU4y?=
 =?utf-8?B?SjFGVXpPb0lvOTFwbnFONnRrRU1EcWRSSyszV3QvcElGcGFtL2d4NjFaVXBn?=
 =?utf-8?B?UU9kbnVtQThGeGl6STFaNmpkM0V5azFGQVM1L3NZQXNpdkdpejBnRDdxeU5W?=
 =?utf-8?B?eHlRdjZVck1zVHNweGd6SWJnRVdhQ1JaUUYzYnVEU2tLSFFnVk1uUkthN0xv?=
 =?utf-8?B?S29KMkNxUlhFcjVpRmFhMjRnbXJtdlgvNk1oa3BvY3NpQnBTeXdYcXFFK01P?=
 =?utf-8?B?TXlXNCtzT3FwMlJXSjNNSi9VSFZ0RmwrRURTVEh6YzVKZXdPU1ZmUDNSRWxD?=
 =?utf-8?B?TkxrdklTR0lrd08rNUxuOU1xb2hSK2ZRK05tTHE5amlJUS9xZEJNbmxCQ2Jp?=
 =?utf-8?B?NkhESUxQNXNHZkxiR3pid2c1VXlDQVpSTFNPZlRESHlkRTAzai9JMmxOTEF6?=
 =?utf-8?B?R2xCMXRhalJoN3RJWWs2SllxUHU5NXJaaTZZaExzbytuUURuQ3haQklvclBR?=
 =?utf-8?B?SmlBaVBDZzZuUWFXSmQwQjdSS0JST3E3SjJHemZvT1dZZVI4aG9yeW5QTEFO?=
 =?utf-8?B?VGxGVk5HdUZaaVU4dVZva1gvU0Ird3Eveldqdkt5Q3dTWVdkODlrSjlydDZy?=
 =?utf-8?B?VUZWdHVNa0d3M0JBYzZsR1g1c1VPUmhMNSs3ZTNmbXdTSlI4SElMcHJLYXhC?=
 =?utf-8?B?VWQxeWpwNnFtVG8yVHVuOG5lc3J5NXpFdzFrdjlRUzJRaHZzRC9xeXRMMDA5?=
 =?utf-8?B?eFg1aGRiVW1QdzBtVnF6cVo5Mzk2UDdmSnMxTG1IbWkwYy8xdnZPVDZJNCtu?=
 =?utf-8?B?RHlldloxSWlKSEhxdDN5NU91MVh1bEt6MU9ZOXJlQ2NZcTJDQktmclY5ZVRz?=
 =?utf-8?B?eVZQSkZoY1NvRzVVbFIwTDl3ZU1lK0hrZy9hYnoxVWxVK050QTMrMTdzSmVM?=
 =?utf-8?B?UGRtVGk2clhoVEViMStPL2Z4RUx6aEkxUlNqazZlZEsrZ01pdWxBa01DaXd6?=
 =?utf-8?B?K3RyckxxUXVkSTAyVG1waVJ6dVpmRlVmclhCSFhxVkw5dXdvc2xIR1Vrejd5?=
 =?utf-8?B?MzN3TDBKT0xyci9IRFhuZjVzbGFRYnNzUUkxRS9SMWduS01VVUUrOVB4Y1A2?=
 =?utf-8?B?Z0JnOFJGelBDa0Q1Z3orQ1BxckEyOVJLcGhncGNDK21ub0xwWFFBMlJlRG9p?=
 =?utf-8?B?ZmhRK0tWM1YwaDRKSHpmK3ozS2k0UDRYRTlNbmFrMlMvc1JRU0xEVkJYOHUy?=
 =?utf-8?B?UlUyMHQ3V080RzN0VUF0b01JQjFKRXptazFjVk9UVWJmeVV6VG0zYXlkUmln?=
 =?utf-8?B?bWV5QmlmRStIZGg1emZROHRFeXBITkRQYTUrVmtWbGkxR2dRMGFTb2xQYUhp?=
 =?utf-8?B?dXJJeVFtckF3UXI0SGtzSG9kb2VVZWg4M0toTWdWVlQxbG5yNzE3VjI2ZXh3?=
 =?utf-8?B?eDgvbURuWUFKVnVmVFFCdTBET2JyNS96T1lpVWYya3J2UGl4NzlkM3hLTk5w?=
 =?utf-8?B?Ujcrd1VZS1JiUW42TVRiYkJWYm9sTWQyOWQyREl4UytqRXgzUlBneFFKMGJD?=
 =?utf-8?B?VjVzZWlmai9qc1VwMG5BZXlidEliN0dZeGRRZjJsRGJFM3lkdmsxcVg2ZmJv?=
 =?utf-8?B?M1RQY1ZISUppV3YyUnZLcXlSY2l3bmpzVS9VRzZBVzNoQTJBbktvb1ZsTUdT?=
 =?utf-8?Q?sG3aF1mT70jR+uQTnT11oBsYlGthQeAtvpqgM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5144.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGdRSVZWUHRZRklyaXcrSWtjRE05NnZaKzh1SlhXY3dxcy9CTzlVUzQzc1Ju?=
 =?utf-8?B?R1VrWnk3VUh4VXdydEJ5MDcyb05RSk16R0cra0EzZ1l0YTZ6ZUNCY0VxNzg5?=
 =?utf-8?B?aWFTQVpIMEJGSGtXQUt5QzEvbEF2VG1wVFR1d2g1SDVVbXVTcU9lUG1jbXV1?=
 =?utf-8?B?Q25wR3lJWUJpNFdSdlF2MmFEd3VNK2Q3cjY4UkdhbkpTUDROQTJjUGpBM3lr?=
 =?utf-8?B?UUc4aEdZTngxWE8xTkljVWJvRXNQTWxVNXYyQmI3UkV2eUg0OHpORWJsSHVH?=
 =?utf-8?B?OWxzd3FJZ2JuWkJUa0Q4dVF3STRWZ0JIa2NJeSs0SUU5TTVjWTFGdGlkeTl1?=
 =?utf-8?B?TkFpSGtIVzZmeG5SYUI3Ukt1VGtab1lQZktRRXYwTVJFdDk1MHRzSUg2aWRa?=
 =?utf-8?B?UTlYVUh4SS9JK25KbVFSTGZTc204czhiTjJxUHgvVHhaOFl6aWV6YmpDZXkv?=
 =?utf-8?B?MXlLaVFZaFU1WVkyUFBTbkptZ3hPZEMvN2VmR2tVSzJGVzhXV2NQL203RUVM?=
 =?utf-8?B?ZDFFelhnWHErYWFPeUhaZUh2N2ZuWUdyUTcxQmRJemppckVhd0R1MnNNNFVB?=
 =?utf-8?B?NDFmbkU5NXJldHFCaXhQa1pManpvL0wrZFh0QXNGd1RLWHFlcEV6RWVUalpJ?=
 =?utf-8?B?S0NkQ0VpM05jRVVML3RwN1FsbWpncjR4ZUVpbE5hRm5xNTdrelY1Q3hCR3JL?=
 =?utf-8?B?L2NzTkd5akpLUTVzc2I0OEFlSzVWR09naENYSmFkQThXcnNWRCtvUDNZLy93?=
 =?utf-8?B?VUVXd0dlNmVhaVRlQWM2Q2drY0ZBa0RjZlhoeDhUZ29QelNZdEJSZjFYaHR1?=
 =?utf-8?B?b2FGM0lLdm83eWFWRVRlcVJsZkJDVkVnK295ZWZMQnFNVFZjTjZtVmt4S0lC?=
 =?utf-8?B?dFhVRGlUOHIrd1N5RjVBT3VHY2ZuOXRKbEJDZ3RGVFZBLzcvVHpCSGxpZDhS?=
 =?utf-8?B?RkZWV096bmdlSmoyQlhpNnRHMzBacjlramhoV0lUWTJuYjdLcWg3Z2ZQRGo2?=
 =?utf-8?B?WVM0R0tZUUx1dFRBTmV0cXdReURZbVpHdmgzUVExMHM2K1gwK0pzbzNlR200?=
 =?utf-8?B?Z2U1K3pwZU10czQ1aXR5TFk3cXZaVlhrSnBtK05MaFZMOEpJWnFnMlNPajJM?=
 =?utf-8?B?bEY3NDlIM0s5TDg1QzdMYVRka3VPR21qRmZkWEt4QWFiQWFza0NVMTBRb3Jo?=
 =?utf-8?B?QSsvOVNzRk43ZWwzbUc4SEtpMnRCMGM0WElybmNFT3hiUW9XaXVQVW9WL1Vx?=
 =?utf-8?B?Vit5TStrS2JFWmg5bXM4Wk1mSDNHaWNvckJmRG1RanFjQ2tMWVlQdy9xdjR3?=
 =?utf-8?B?TlN1N09NNjNBV3RRZm4yU1NUbzUyYlNwclhOV2dIMlhiV3BIVVhlSTRtSHNX?=
 =?utf-8?B?NGY5bmc4TUFoZ2ZabmFrbEwzbUl1dEVScUUvL0V2RkdSeGJBMFJqTmNkdGR6?=
 =?utf-8?B?NWYvTjJUSmhFNVhXZmVCNWVnb3JVeisrRkFXTWZYWG5XdmhLaytxV1dsd0M5?=
 =?utf-8?B?SDYvVmFNa1ZBY3Q3MUc5ajlNTG4vMnVRSW9HTTFyd2M5ZXljclhOVUllQzZ1?=
 =?utf-8?B?b0YzRUhRaG5UcGFKYmVMWVRjcXo5dTVOTDBiRFJhT0dUTTUrUUpJSDF0N0Jx?=
 =?utf-8?B?ZGtaR3RTV2tHWUh3Z2h6RStpelhWaFNQUDFvdmxVYlYxTnMvTHdMYVk1ZUVQ?=
 =?utf-8?B?cXRMVkZnR0xtRXU4UVA1Nk5qeWRjaUVLdEpDdktBOWZJeVFTeVpQWGdvaHM4?=
 =?utf-8?B?YzJKamx6OUIveSs5MDljWXZIeVQ4VmNhSFFjYU9WMjJyUkZQYVZ4YkVDU3dG?=
 =?utf-8?B?N05SRUYxeXpHMlgyMVM1OGlTcmI2RVdoVGtIWURIVzhzN0NJT3laUkI4S2tJ?=
 =?utf-8?B?b3diTnBtMk4vMGRvdUluQi9YeVFja1NFZ1lYWXE0Sk02TlBnMUxxOStzQnVZ?=
 =?utf-8?B?WGIyL2MzWkFPYk1aaVh0a3kyVGpWT1RLNWFvdEYrRWo3ZlJETWJ6WnlMaHlU?=
 =?utf-8?B?SlFVS09ZdVZoNUhRTUtVWXd4RmhWTTBQRU1yT2Y2NzhFOTBneTNGTG5sM3VQ?=
 =?utf-8?B?aVRJN3VRREt1cTRNZE1lbWtJenc5eURhZ05pUUIvbTJhbVRwZDF4Rzc4ZlNh?=
 =?utf-8?B?ZXVjRkF6NnJpcXV2Tm1NUTMyQzFuWkQra3hTOGFxdjZvVlE0dWFYTys3clVT?=
 =?utf-8?B?cmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dac0654-1f25-4fb6-e5e3-08dcf5deac29
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2024 16:53:09.9185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lf5MAZRjOCEdESDRZoOp5DoeRBWRKengM0aPX/FN7VxZmSxRtiTwLEAYtd6IFw0VMNiJblV7TNn5Ifon+BFv5L94iiloHKAwltrnFDFJJtk=
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
bmVsLm9yZzsNCj4gYnBmQHZnZXIua2VybmVsLm9yZzsgS3VydCBLYW56ZW5iYWNoIDxrdXJ0QGxp
bnV0cm9uaXguZGU+DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBpd2wtbmV4
dCB2OSA0LzZdIGlnYjogQWRkIFhEUCBmaW5hbGl6ZSBhbmQNCj4gc3RhdHMgdXBkYXRlIGZ1bmN0
aW9ucw0KPiANCj4gTW92ZSBYRFAgZmluYWxpemUgYW5kIFJ4IHN0YXRpc3RpY3MgdXBkYXRlIGlu
dG8gc2VwYXJhdGUgZnVuY3Rpb25zLiBUaGlzIHdheSwNCj4gdGhleSBjYW4gYmUgcmV1c2VkIGJ5
IHRoZSBYRFAgYW5kIFhEUC9aQyBjb2RlIGxhdGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS3Vy
dCBLYW56ZW5iYWNoIDxrdXJ0QGxpbnV0cm9uaXguZGU+DQo+IEFja2VkLWJ5OiBNYWNpZWogRmlq
YWxrb3dza2kgPG1hY2llai5maWphbGtvd3NraUBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2lnYi5oICAgICAgfCAgMyArKw0KPiAgZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2lnYl9tYWluLmMgfCA1NCArKysrKysrKysrKysrKysrKysr
Ky0tLS0NCj4gLS0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAx
OSBkZWxldGlvbnMoLSkNCj4gDQoNClRlc3RlZC1ieTogR2VvcmdlIEt1cnV2aW5ha3VubmVsIDxn
ZW9yZ2Uua3VydXZpbmFrdW5uZWxAaW50ZWwuY29tPg0K

