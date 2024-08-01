Return-Path: <bpf+bounces-36209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A70C944529
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 09:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2273B1F26BDF
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 07:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBC8158557;
	Thu,  1 Aug 2024 07:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YG6fbc54"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048CC18E0E;
	Thu,  1 Aug 2024 07:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722496150; cv=fail; b=SM7GCOzaR0E1xDac8LIzlLxLs2k+pgPKTz7Wny83pUwcUmaqeaX08a2AcYnVCoIXWwtmu319qPsD2r82vFCz8V//5f+P/OVDccAh8Ghnp6oC97Ga05S5Hjd4i8xMiBjENCDGZsxTxW2Oo9zOqSnha17qiqk0UrQPgaB5LK+Fm0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722496150; c=relaxed/simple;
	bh=R4MbIWjZWxjIg/kMO4uZaZtIOfvHhKDY1BW72L0e6Ig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iwQMGZYIkC3YY4+yMoANZsYzBdnMjl+2E7heaw6n2uRjZ5wgdQI9I7jLxi/W4ukcvpoKgKmDFbVVfwEdVxXxHf8RWgufUwz0+m+BcsMgFYsgybl6rXLYgGrIEeiVk833Mt6fWTxS6rwpbHgIyZeKqyxBb1tnThuD7iH5nB91uWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YG6fbc54; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722496149; x=1754032149;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R4MbIWjZWxjIg/kMO4uZaZtIOfvHhKDY1BW72L0e6Ig=;
  b=YG6fbc54OmPLyzB60fA6rvths9XGyZoPBQ+HXo0tu7Bk3vy+v6cgHLes
   m3PJH9se1alKwjA2iXBdmi476vkwtAbhYzbme7G4moiqjkcBPBK/aNVam
   z8AAhI05zR+gPvC0mz7NoNhQyHklGDUB/1EmpOfCTnyVk3BD8PDbcvxq7
   kyRFBVstc4JApZQ+oLeTHFxHiG7egvQXqR/P4zM834pOmB5aljTZUBLM6
   /O6VMZDU1xgUtAqLt390H3mYrnYoDnHc8VjwRcNbVSWNkVjBL7Bg2MI09
   wo9LzHd2QLRI7txHkQrvAkRF+7IuJLXPg+LUSlcx6ta/PhTsnHxzz6kJL
   w==;
X-CSE-ConnectionGUID: 6XzunJOLSfi2+RLJZM+VfQ==
X-CSE-MsgGUID: naIiesirTly7M7SdLc7KEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="31581316"
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="31581316"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 00:09:08 -0700
X-CSE-ConnectionGUID: tCR4lBZrQTi81s6l0ekTnQ==
X-CSE-MsgGUID: 5gRVW/lURjirXsZhON61vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="54848049"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Aug 2024 00:09:08 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 00:09:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 00:09:07 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 00:09:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GslUZUyR7aLOhPrXnS49x+vtQOigF0O6qc+H+7bJO/6VTM6DNTPkgZOseiDT3tAKMFns4N7M/UTq0dTVKDoGstHS6jnxArxOdkGMMxd9f5lHRuwhozf1+yRqmgAfjDV76mD6k2i8ouilKQ0cgvIN8x4JqMzFLtsyrtnlMZ/67ugGUAwUmm5bFoUFEP2fBi/A6+gaPWqaNl9CQ0cabUQSCmyzrfnybLBFcl6CA3MpjxiyHv+FjmaBxhXiH3oZxNCF00eslw0scKXKZznMdKm0JepCHxT1CUhc2SAMvMFsLqe4QwBXKkpMiWmclPTERs9BQwibwG31rCGfVcm9B9oNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4MbIWjZWxjIg/kMO4uZaZtIOfvHhKDY1BW72L0e6Ig=;
 b=aQm1/ya+2mATaRoH23mMI53nG9FvP1dzvBFvVLNyaWrY3wx22HJa58hkYiolLwBu8ea5bCaNNd3pSmO2xAOQNA2iPkbKSDMl5OAmUq4B/vBfgiJGVRo88CFuPIqFEo2atSS+alj2swogopzveX/LBtHHykkjdbTvazOCCBWK3kkiBr3Z5TwBFlJtulqNJyQwGDl+HpkwrrWuRD0Evi9rJ9K/46oVswzl7FkyazXxTwqPtI9l+EapCuTPHdDltoMIUbkzM+InfTHJKYI7n9uge4Z1nfPogGvXJm3ExACTqksG8afC1zQ714s6x8CQyPJrsr9DM74LmGzJCOlS1pTK1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by SN7PR11MB8065.namprd11.prod.outlook.com (2603:10b6:806:2de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 07:09:05 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%3]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 07:09:05 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>
CC: "Neftin, Sasha" <sasha.neftin@intel.com>, Brett Creeley
	<brett.creeley@amd.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Eric
 Dumazet" <edumazet@google.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Blanco Alcaine, Hector"
	<hector.blanco.alcaine@intel.com>, Daniel Borkmann <daniel@iogearbox.net>,
	Jonathan Corbet <corbet@lwn.net>, "Gomes, Vinicius"
	<vinicius.gomes@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, John Fastabend <john.fastabend@gmail.com>,
	Shinas Rasheed <srasheed@marvell.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Paolo Abeni <pabeni@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Hay, Joshua A" <joshua.a.hay@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "David S . Miller"
	<davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next, v1 0/3] Add Default Rx Queue
 Setting for igc driver
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next, v1 0/3] Add Default Rx Queue
 Setting for igc driver
Thread-Index: AQHa42h5Fat/ksCit026eH0/dvPCNLIRgrOAgAB2s6A=
Date: Thu, 1 Aug 2024 07:09:05 +0000
Message-ID: <PH0PR11MB5830C9CAFB74EE045B8FC1A7D8B22@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20240730012212.775814-1-yoong.siang.song@intel.com>
	<20240730075507.7cf8741f@kernel.org>
	<PH0PR11MB5830E21A96A862B194D4A4A5D8B12@PH0PR11MB5830.namprd11.prod.outlook.com>
	<20240731074351.13676228@kernel.org>
	<d805bea3-cb2f-4e2c-a07a-27b8b4c5f294@intel.com>
 <20240731165253.2571b254@kernel.org>
In-Reply-To: <20240731165253.2571b254@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|SN7PR11MB8065:EE_
x-ms-office365-filtering-correlation-id: b8b55089-60cd-475e-25fe-08dcb1f8d459
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?elTHaqj0WdSB6mkqnLcN888l95yfvTPHskSF8lvZyt9+b62kFhgcaQTwe9RS?=
 =?us-ascii?Q?RnejPVf7DDNgW2lxRkfJMw2JZGRTPhNGnvA4HEuGX1exYYuJoXqK03h5nWYU?=
 =?us-ascii?Q?9xF3I/R9QhI/lYpihwQ5ZxxIm9CvUejAChcug21yqazRZG3qhEsSVaG+ueDI?=
 =?us-ascii?Q?i7PX/FySSVpJAaA2ONzLSg5dWXO5T3X0cpUDd5YRGXcN3in+mSjpjCKIDuYT?=
 =?us-ascii?Q?+fh1niicJT2GNP9phk8zRg4vdUN+e6ZwID5lSai/GOZ6RVSH30qgt0bad1T1?=
 =?us-ascii?Q?nP4bxnYw/s4/omjRHPbeLAThulc8O64sHJm6bKZgFSNcuNSasMK2BHneBrBC?=
 =?us-ascii?Q?sqf8xi+g2W/vzrwBCcl+1omQvnD3RDXAFr5miUlSXAtWQEvwusljYrzRttEi?=
 =?us-ascii?Q?1Fo0mhAbX++l/o2aFyx1ilJLExZXq9+14BfRRJJ/0EfJoOEYV/U1zCHEZz2t?=
 =?us-ascii?Q?ZgmeRBwBYe7dXlsomja0KkIJPBd2WEQhK4exUSrmyJ185HygTBFX5s3+beU2?=
 =?us-ascii?Q?gkIG4vgckUJ57fqgqogWzegiFvjneg1tAp9AwYqQXYjoqqwMzYV29rfaC7ZH?=
 =?us-ascii?Q?t01+Up7CbWJVARhxayEIctiK2xERVgdE5oH2z2telwb4H7rYIdAuN1sagtad?=
 =?us-ascii?Q?e37tiLDuCk2C5kK9rcevp7jOnzD3kGZANRZAqaEqEQrzWgS9DnoOxDN2rsU0?=
 =?us-ascii?Q?mIiQRV+TgCsqtluH8cc4xHqq67rHnSfo9yv8tQRnZsxx8gR2nd8oxDPOTde+?=
 =?us-ascii?Q?7myIsJIy/imT9J5A6X7vSmJOHc0eNfhNAFqbEgCauI716QFEQuXkckmFcQjF?=
 =?us-ascii?Q?4cUdNIMIjyySme2DhI6LWhQcuyYAT5Kfzdrcq+k69KLftsoKoCFFVyqEk+Q7?=
 =?us-ascii?Q?IoKH2IlUbX1ZlTZPdr+OeudG+awhWOFblMvwqt1g6dLpcg2eippN54CL1JBH?=
 =?us-ascii?Q?ZmKnLKViXVkUOCiOhKttAEGh7irDC17PGD4TVStdN8d4tfTsdpeNQQr45CgH?=
 =?us-ascii?Q?ZARpf0qp3ag5YrYTRFyj8MN0N79L5cLNkaz4Zz+r517DNzBb3000886WDJd1?=
 =?us-ascii?Q?c8QgVInHYMWfLmteqMSQ2Z3+Fxmq6+FXFKWyLULUbzcNKefDt29VcsYsDCJA?=
 =?us-ascii?Q?9/ew68mvpz3hlhx6VR/LtEAy3GYa0LpwRURczm4xYH9GWhi/1+rjV6e+fWxI?=
 =?us-ascii?Q?lfk5MHzexzPKyGDN8Es2rI5q9QJeugOk84hqFYJHWKT4OE9/sK8V8ctmWN9e?=
 =?us-ascii?Q?zWyJPKmEDyncY6LzdeuTHBMtzb4h6lHZnEGDf6H1WO+A+5oiguYHtgtT7Ty0?=
 =?us-ascii?Q?oXEZ3BmK2nbuAUnmFywXI1bKvQXvTEvkco/7cTaMth1Kls46KprX7cTVJLVX?=
 =?us-ascii?Q?RTmnXzZ2pp4MtyfMVDMA/X2vsHIDC21m6GgItJcIqrAJ8cRDbg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jMmm9FboVCwd5c/GMFsR96fSYjufOHLh8GkZkMoke492qZns3nKzat8iRNyZ?=
 =?us-ascii?Q?SbrQeuonMmalKEiqGl4+8t0rvGZRtBXQ5Vq3HHwezfylyig1KfRFmPvahHKJ?=
 =?us-ascii?Q?dvsmjsHUjvbHVr4Poghy9TpWR/kG7if0ATBmKXdziBXwmGvXNIDfH2JMQDYL?=
 =?us-ascii?Q?P+ME5Uo8OulFYYDLEW+TYUPmzHYp4mQZStT8ExoduxcYXYk7yXyhgs5vBekd?=
 =?us-ascii?Q?q7ygFbmp21MHsvp2M8wUCvkVlaVXbyOpl8vPCJaxAEbB/rK0uGSJO8/7vfFh?=
 =?us-ascii?Q?S6aTVZNxDNOCiSlLMP8FNxNwtNyxDAozrcrlGaB7FTReesNtpjXoWY8Y/xVx?=
 =?us-ascii?Q?3DVRzeokly9tQMQyQkg/FblJgZU4463e9b70jLvDbjujWgQBgmwIQUVBgklX?=
 =?us-ascii?Q?vah2tgHO56SulXhrQ4g3pGVSp3UHIThWJjQLSsbEeGg8vmyUXK5QZvPrH/sZ?=
 =?us-ascii?Q?K34lgUHH4Vl5OIV/3VeiPy7eG5ISGctWXKXiEBsvLTiXqZRCxjleSQghR/MD?=
 =?us-ascii?Q?5Mf42iiGDn94rT6wJcSWqZPvcC0oY340JkfPuiuO1NfsghHqS+QVJCWO+Edi?=
 =?us-ascii?Q?2nmxbUoDr94e9p/nGEGHxNwtPhjV0oIO9kpbY2W+Bkw+SPLBgckczyR5eX86?=
 =?us-ascii?Q?DdTumc81b2xSrCD4nBMC+XooaNOc35qb3VflVzwfT6B9D/c9est40n5gno3r?=
 =?us-ascii?Q?wJH6opX4ejvgf8MHLJ8ncXREvafsITVIHL9tnvhGDSOCjv9iPw5YMFsAMTNr?=
 =?us-ascii?Q?qIt3+shICwMIrH5H0AgTPm/6uL6mEN/yCPyP8RJdANKHKoqG7dyhfRRg8x9u?=
 =?us-ascii?Q?tkbssKWb0gJrQ1BawksFPeBQYhPRkWNr8AJ8gRetYCB4AcOsJxvt94fyXR9L?=
 =?us-ascii?Q?t/bIALq0XaZqau4LDNZKUT4yuV9ztDqS0a9TIZVTSE3ILBKbOmkb77qTxc2/?=
 =?us-ascii?Q?7buTt5TMx7fWDtYitcNL7UYEvMhiSnFQ3qy/nZfSmYSeQcF8UqPlhF7+U1Fs?=
 =?us-ascii?Q?aX5x126nvFGshkEXLKmMM28buqqL1XgvJBA411L9wOAiuDO4nDK6oqfgcb9G?=
 =?us-ascii?Q?G8hs8tJVnYBZWaNGw56ZUjVL25R/bo8iFGPN9iYpZj4g3xNgG6w0rbBoo8GZ?=
 =?us-ascii?Q?oqam6+i8DUKgpqdywdNvQl4P6QIep3p87/0beo5a8C6R6zjAEGfB8LB2sUNV?=
 =?us-ascii?Q?thfBK2SopQDqhHKp5cdq1U1qrgn1Dnywws3MoKJCucH0sRdD90Wt7JDEjpeK?=
 =?us-ascii?Q?3V5HZ7n0nI23WJjpQH4K3ZmFv3J86opHrnss4xVxZfscO9ARRPskRDwajld3?=
 =?us-ascii?Q?+/wE7l5gBGdpCZSJTc2njQbXIZeJMiiO4cMbAabFmfXsGkGrPb+y4n/ENQkD?=
 =?us-ascii?Q?IHoVG/Hf07hVjcY0TVNf41XzKrKXJ3Jj2lVvVkLrfwQBhyi5dq7v8xrifXZB?=
 =?us-ascii?Q?iK1sQM/UqvHRkmo/j6ElrZPkJNu1nCifU6AtdnOTNy1ry9bETfmOKEbIzfMF?=
 =?us-ascii?Q?KJk88JwvTZN3KuUbZKQ3LdtWzS4am27tGc+QdcYCl2CAHobCaSxubRUROzEF?=
 =?us-ascii?Q?EtBgoPbtxY+QNxKGJR0Y9zho8o1Qu/On468ZOH05GUv6qBRkzMUCGs0OD2CU?=
 =?us-ascii?Q?PQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b55089-60cd-475e-25fe-08dcb1f8d459
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 07:09:05.1838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mzctpUv5VQsVKFSbmfA1sLOuy+m1mVOZ0sB0jkdZUtqIGfysoD3gVQbgIKQyb2moDgSunACcUWsNXFFZEeX5kVE8c1fuqAwFfEHK+JcImAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8065
X-OriginatorOrg: intel.com

On Thursday, August 1, 2024 7:53 AM, Jakub Kicinski <kuba@kernel.org> wrote=
:
>On Wed, 31 Jul 2024 09:41:16 -0700 Jacob Keller wrote:
>> In this case, (I haven't dug into the actual patches or code), I suspect
>> the driver will need to validate the location values when adding rules
>> to ensure that all rules which don't use the default queue have higher
>> priority than the wild card rule. The request to add a filter should
>> reject the rule in the case where a default queue rule was added with a
>> higher priority location.
>
>Maybe I shouldn't say it aloud but picking a "known" location for such
>a wildcard rule wouldn't be the worst thing. Obviously better if the
>driver just understand ordering!

Thanks Jakub Kicinski and Jacob Keller for the suggestions.
I believe that it is a good idea to validate and ensure that the
default queue rule is located at the lowest priority location (loc 63).
I will go for this direction on my v2 submission.=20

