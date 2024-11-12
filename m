Return-Path: <bpf+bounces-44621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCE29C579A
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 13:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38281F23236
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 12:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2381F7792;
	Tue, 12 Nov 2024 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fLijlBNV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945482309B9;
	Tue, 12 Nov 2024 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731414153; cv=fail; b=dZ2FLBZggzozwl8umRN8Y8wiQsthfgXQG9HyA0llUZmvhn46b/D9xauPZmDcP5x5A/Wysb7U1bCJeGT3Q+jd9utnfDtGTymhJVDvEY6H73zhjq6+uez7HWmywHG3XBXcgEsdKGdhVIjfw/G3ceveDi/LsxqnB7vf0UGJg+KIFik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731414153; c=relaxed/simple;
	bh=OYAetaIrHuZM0sYvUx8Zcx16LjlFXBil8Z0HHE1CJ7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p7Nhs2ygYVVahkZr9CU+rSIy7qrf8lTmeavW9fMwd1z48nduybyWJgdXMBGN5I39cZRvPSZISbiD5kObwoyyfqVZ0lwM1ccy/0RyLn3kn8ISMjASlrXdw9yd9hulnAsuN70BSufBXTyiMYm5h2qOUEQznqcNdKyfz1Y4/67w2Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fLijlBNV; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731414152; x=1762950152;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OYAetaIrHuZM0sYvUx8Zcx16LjlFXBil8Z0HHE1CJ7E=;
  b=fLijlBNVGM/BXkt+VTFtwkbJi5FqVji/MY+P7Qktvm0e+QgPHOw7ozoK
   /5JtB8/W7vxYgVzLFp1FWyg07S83CLYMom68zsUCKqBtBdqlS006di2w3
   xqeflN7d3aAabp/WxN2bu7YRswCFwx8/ll3q2g4il4Ra+S+9D3YuYkipo
   6HGyPrlhKfDaYQxN54mBCvtxnFeSXWkMSqx8HNlRB2Ysiwh93cg81XtZk
   99vLPi7F8Fr8YU4ZNqF03jMQiuWvSc85ii8naagcgXDEd+ik4gl7Izey8
   pfvkBKjxJv7Bu3mslqca9OxqOFqmXI6RE+70a316o1yAMNB5XyWmBeQ1n
   A==;
X-CSE-ConnectionGUID: jFe/UL1hTuCm/blXbRgcrw==
X-CSE-MsgGUID: m0kZEkqBQYGfSr2cmIWFug==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="42343206"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="42343206"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 04:22:31 -0800
X-CSE-ConnectionGUID: VDu6idDaRZyNygfXBXFjiQ==
X-CSE-MsgGUID: HRrwMbMMRVyEJ/I26fBxaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="91929332"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 04:22:31 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 04:22:30 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 04:22:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 04:22:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BY2zryx+ZTTHHstiJc6kTTOhuMcs518Fso2zfWPji7QDk5zqoIuTxy3vvYhiCjD+zlK8MCxd5VSRSVbMRs8VdL0v/c6PYhzmBR6W8DTpS18vFZP3Tza4JRfSgSoSC4ZESoXsuiNgM1nnGhLzVCDl4+JQYnSefYhBrelraT8fHz83z6E9e1JHbL6eZHHxjKGxQTbZV+ytRw/9ys9k26ZlYTu8/RMBmRSSeTeATePHMFzk9hhlVhf/1jrQ38z5PAgpudUZS/UcGMqg5BXrKR9YnhQMcThldBjWgQ5dPbz83DFZkUM7JOLgdkkcZ8n1FCxV/74Y1vhGIJaHc+KfiB1POA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYAetaIrHuZM0sYvUx8Zcx16LjlFXBil8Z0HHE1CJ7E=;
 b=FUDNy0fz2L7eSgsF0BCUT4y6N5yyBOPO+5VmQLBHe4guVQyd3sKC8Y1iGImQJjA/TdPzIIajXH/oEY3U0o2dEX66Y8OS3RNChghodpgWL5vBUy8ValLsw1BvW7LGjZ+Qud+Z6wfxfVUx+WYKqpcQ9FF1dvjwj1zXAZkpbZl0//9jm95L2HnwSdIMcy2KBO+ehSV0z53jzOSkVf1IvTpZxTtAQM1OLLW1ESltJSRwYgOjDlv0aSh0PFFKs+BBHREFGd6gBXJy2Znsz9DY2kieBG6XWinueK3CRPlLRYlNawdDumEytnOSprQxBgBlprhDa6k81nybYPzI++A4uBmsxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15)
 by SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 12:22:22 +0000
Received: from CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3]) by CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3%6]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 12:22:22 +0000
From: "Rout, ChandanX" <chandanx.rout@intel.com>
To: Yue Haibing <yuehaibing@huawei.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"hawk@kernel.org" <hawk@kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "vedang.patel@intel.com"
	<vedang.patel@intel.com>, "Joseph, Jithu" <jithu.joseph@intel.com>,
	"andre.guedes@intel.com" <andre.guedes@intel.com>, "horms@kernel.org"
	<horms@kernel.org>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"sven.auhagen@voleatech.de" <sven.auhagen@voleatech.de>,
	"alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>, "Kuruvinakunnel,
 George" <george.kuruvinakunnel@intel.com>, "Pandey, Atul"
	<atul.pandey@intel.com>, "Nagraj, Shravan" <shravan.nagraj@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH v4 net-next 4/4] ixgbevf: Fix passing 0
 to ERR_PTR in ixgbevf_run_xdp()
Thread-Topic: [Intel-wired-lan] [PATCH v4 net-next 4/4] ixgbevf: Fix passing 0
 to ERR_PTR in ixgbevf_run_xdp()
Thread-Index: AQHbJ1tLkUVEKt3R2UCYFElWxTyN3bKzqzoA
Date: Tue, 12 Nov 2024 12:22:22 +0000
Message-ID: <CH3PR11MB831393080052C7BED1C8D9BCEA592@CH3PR11MB8313.namprd11.prod.outlook.com>
References: <20241026041249.1267664-1-yuehaibing@huawei.com>
 <20241026041249.1267664-5-yuehaibing@huawei.com>
In-Reply-To: <20241026041249.1267664-5-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8313:EE_|SJ0PR11MB5866:EE_
x-ms-office365-filtering-correlation-id: c219b2f2-213d-439a-c3e6-08dd0314a8e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?ilItUwGQ4KglJe8OFLclyirP4rxTdWJpxzrgJ3D1607gaLmBlScpze3Uyf7o?=
 =?us-ascii?Q?MGFdH3RPp6mE5UsQgamBFdTEUXT3Z1v3OUuxS2BxPt71mW7qF0l74BgmzYwQ?=
 =?us-ascii?Q?pOgpnnvj+sK8QEgSv0QJCa2OH09AY+7D0b614yPI4gQ0OkWOeYNu0UFMJtNe?=
 =?us-ascii?Q?RKpvw07EAmCWdrAZZz6yztIGPsfmJ+1npzQBbYmKPgSaKhSLAucUK3R5uFb3?=
 =?us-ascii?Q?sP3wcXDvYjQu3qtsXXpKE9qBB0u1eicCfqD7h4xYcuEScv/HWwZenyBEIv2R?=
 =?us-ascii?Q?n2eDWPb4509eWEZqthRiTW7CspFMsCp1b5GU9Kprfm2/y2eomv33pBPgn60Q?=
 =?us-ascii?Q?x9GBbnqOlrYZcyNTZ9TNnExd4q0GQEXUK4Mkkgsq1B6BG1Ave89T6ok9oMQT?=
 =?us-ascii?Q?aG/Z6wwdFUQCrStXRdMy3H8gm53gOqjzadg/oo15HvQrxpuvyyoqNAtxuOWq?=
 =?us-ascii?Q?drHXjiF2Yg5stlQ294SNrUCryhCwzhYA6TJhtzQ8XSMtSu6jicTAP4JKERja?=
 =?us-ascii?Q?fN6nFmCYuJwbMzK44DreqIAwlan9BT0l2QuJrEbGHwn0QV9OyW5Wb9lK58Is?=
 =?us-ascii?Q?uqGR7tIH60kHVnsmsIKnt6QULQFlzzZaT0SUi1z4bYHXupmZ+iYJhWK0NAgK?=
 =?us-ascii?Q?Lce4PG2tnJpwRU66q5ilbps8xYV9OXAO8gfaU1Xh4xJQZJDIOPqnbbh7jUwR?=
 =?us-ascii?Q?LYnKqcOuB1CuH8YCBOgM8SsQAF3i72WOxhshRxf1e9JowYTa1fC3VAE9/btA?=
 =?us-ascii?Q?r/Ahv/1E7pvHV75dBjt9JRZ1B/WIuQqd71Fptk63P6EKeDwVqLN0Yl5mqdkK?=
 =?us-ascii?Q?MZxTKkHrnlsngMYlReQzLs0ta2xDZkU5FWpiBEJBxn8rwJcRTkU94Aa/xS24?=
 =?us-ascii?Q?emIn3003YjG9r06VFxXC72fRj2IvJ3yalhsKAmts+6TJ4Eq100lIKB16bTA6?=
 =?us-ascii?Q?IuBuefm1Q6iPpgHe4qEbPCn//sQ6uTmYris46P/JeM7VXYZmnVVT8iXpchtE?=
 =?us-ascii?Q?Wl6x50kxR0ITxBUscNoHn2ke68pq20GqNM9oDYgKmSSpeW/vccx83FyTXJSr?=
 =?us-ascii?Q?Nx9R0i/o3AWhiL2OCp28vh5P9bad8wdQ9M1IF0OnJuFlDUb01xpThr+MTTRw?=
 =?us-ascii?Q?thw+qMflaco1OCpwq84tn99axLxr48ShbT4Kp9CU5eCF1Al3rlf5z8q60Xse?=
 =?us-ascii?Q?kHP/o0V+//QVoyPoFW5cFSO8XHNbExykvi/JGZqFoF8em8vM0NGBn2Tm1rd6?=
 =?us-ascii?Q?An3FCp6ql2JdYfQwXaL1Gq1WKX7pGr8uubxr3z13Jry2BiR9y3JaPHDp3MGG?=
 =?us-ascii?Q?P7P4tTH/46p4O6qXHxxMBpfQMiEnj75ejZl00WwtFiYR57Y+P4wzl5M/z72+?=
 =?us-ascii?Q?ZzrXz0WRlKSNW7NFsH8esAYHQN2K?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8313.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tPoet3Wbbkd2Um9+xsJ/mxboaWKfnqie8fUDJxaj2mAb/FMdZ+CkqmhxJWr/?=
 =?us-ascii?Q?OrAKSFUiCzMtugYJ487Ip8bwCCcOth8suqKw06l6BWB4lgk3JpEFid6hFEuf?=
 =?us-ascii?Q?uso92Sd1uUuv6SlRtzzSLXmwSDiS6HSKQpMI+uYQ4DCZllJfIPCyWMhJkX0p?=
 =?us-ascii?Q?857IxWTQpUMhCz7Aj1oBP+HUSe69FB6uIEToh4n1XNAbD7utBi0q/yon7St1?=
 =?us-ascii?Q?NA4glvfKyCd/fum9wKhr1tIJtwEyX7khE7HDdDOMMCx/xCRKriik4b1S/JJd?=
 =?us-ascii?Q?Qrpx1upDuJp8kNj+7iIXmJumOS/MyKeuDfjWxRxgSrAUS+2aOt09bGdPsvr/?=
 =?us-ascii?Q?JtnTHgRIpz/MFFkjp26W/C3cA8F+REwQ2/nlq6LFWwKIfmuOTUklxQ9MjZKq?=
 =?us-ascii?Q?TyM25jo8joX5KlrYkHbDe6yzPU57fB+cKHxfZDW4TBC/pGfLZZYeXY39FE8E?=
 =?us-ascii?Q?m2hruv1mNetxMWaW6APp+XSlzW9ny6JcL0eeSzIddrhJgkuefldNeZ2dTT68?=
 =?us-ascii?Q?EcdycSaN1LjMxa6pgMI9qnN03suhISGvRrJt6F5pcb8FOcl2WgTWMpGNKgK3?=
 =?us-ascii?Q?wkfCgcFHJ0q3melseXu2fG9k6igGQPr6i8LYxdAoTXDcdN2YAZayFAphn71F?=
 =?us-ascii?Q?Nl9fjRW1owa59VK2IHzw55PC55Y+demXw3Wu+NK6JZVbUJkhtvlVpxDql9x1?=
 =?us-ascii?Q?J+x/XCGVJwsNOj+nDDsuguOuoTUEDgP48AEkvyx/o61sZDWg76wVGYc7uul1?=
 =?us-ascii?Q?/HjKGrtDnlhyhH0JdWGiDZMH0jPUM3+imjwZc8uMAkeydVe4FChJ6tOBrE2v?=
 =?us-ascii?Q?8h4jodeGmIL/8WAjxf+msZWnYKqOezhjARv0jBl89zxgesDKFCEkiCVlxKZG?=
 =?us-ascii?Q?EQ24+vx/qO1QqYoDTnPiYUqvkBK4ztXLFNlz6YkSAQ3inMdSCABz5PMPwdd7?=
 =?us-ascii?Q?NBna3xeIcTQT6530j3hTmXN9Kn+QtsZs5nMyD+RYTpxo5y0GjmDhRleOFomL?=
 =?us-ascii?Q?7Q9NYqfPiGGm0XP5PbKSjecRXv6mLOKE/R8Dqs3G8cyVsDwUEl/35DFX1lXi?=
 =?us-ascii?Q?4q1hpwzu5GFLY3XWBkR3wMbNfZT9LF2K9TTTwwjSSb0md4meC1IJDNCQsef2?=
 =?us-ascii?Q?yPfbrOFoGt2QWC5Qq1h8af9dK2joVF0CNc+A2H+DmmDhmJuD7xQC5Jq7XswW?=
 =?us-ascii?Q?IsC4WUdkQe3sbcn78zinF7CNKYEIjZ+lEtVIRmPX0RFwbP6BQt4ceRBJX+oe?=
 =?us-ascii?Q?T4r/kfeScvq16Imn+8dCpE9nborlivy5kX3N1Y+SpMS3ABVeJB9QbX80UxEK?=
 =?us-ascii?Q?NjEDoYKUlsRzZFk4kBF3WMA+PtrWCCqZcylFcTYTK0RqoXt+4P71wQg2Gb+K?=
 =?us-ascii?Q?W1Dv1y1bnT2YbE7+uznXfTbEjVKYeXLRwI/QQLsjIExhZNfsh80CzDs4V8nW?=
 =?us-ascii?Q?bC0fKLchUI8UJm5WrEpFN70CfzOtwMPqKZq4fii/+3smRUt37p4LuyjF2Nsy?=
 =?us-ascii?Q?m0RkujXo/c6SxBiqpxz4jn0ZCA0VwgYNNWWJLsi7UUeqX+k3D9NIB7uMhi6Z?=
 =?us-ascii?Q?B9QSQ/iqzKqp1r+WboH1KO5qKaS/HqPLB/GCDOvD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8313.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c219b2f2-213d-439a-c3e6-08dd0314a8e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 12:22:22.3949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYYd5DfCI+j8b6BnH9jMVxjl84pMzdYnmKB3Sc2A2rhHVI8wbMNFyni7o2lCAM+nKoiYCuAhdBZXtSqyCigvLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5866
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Yu=
e
>Haibing
>Sent: Saturday, October 26, 2024 9:43 AM
>To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
><przemyslaw.kitszel@intel.com>; davem@davemloft.net;
>edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
>ast@kernel.org; daniel@iogearbox.net; hawk@kernel.org;
>john.fastabend@gmail.com; Fijalkowski, Maciej
><maciej.fijalkowski@intel.com>; vedang.patel@intel.com; Joseph, Jithu
><jithu.joseph@intel.com>; andre.guedes@intel.com; horms@kernel.org; Keller=
,
>Jacob E <jacob.e.keller@intel.com>; sven.auhagen@voleatech.de;
>alexander.h.duyck@intel.com
>Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
>kernel@vger.kernel.org; bpf@vger.kernel.org; yuehaibing@huawei.com
>Subject: [Intel-wired-lan] [PATCH v4 net-next 4/4] ixgbevf: Fix passing 0 =
to
>ERR_PTR in ixgbevf_run_xdp()
>
>ixgbevf_run_xdp() converts customed xdp action to a negative error code wi=
th
>the sk_buff pointer type which be checked with IS_ERR in
>ixgbevf_clean_rx_irq(). Remove this error pointer handing instead use plai=
n int
>return value.
>
>Fixes: c7aec59657b6 ("ixgbevf: Add XDP support for pass and drop actions")
>Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>---
> .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 23 ++++++++-----------
> 1 file changed, 10 insertions(+), 13 deletions(-)
>

Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worke=
r at Intel)


