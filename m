Return-Path: <bpf+bounces-44622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CD79C57A9
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 13:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F6B1F2265F
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 12:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2931FA824;
	Tue, 12 Nov 2024 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D6TGqHlP"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AC41CD218;
	Tue, 12 Nov 2024 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731414314; cv=fail; b=AouYXg1UNNERwSFN5hvpNiss9Kc/yJ81FiuGllMDY+Moby3UM1n7EyxnwNZmPdLP7NTLmI6g0G7KIgd+VDSGawpPFjQPuSQBlRskv2i5GwfvMGGkamqcJIYK8VBs/h1tOm/rUOuTm1+joevchzGAJtrzCz/c+xW2tWR94LUHS/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731414314; c=relaxed/simple;
	bh=0x3uPbdA5st9pGcrg9mW1Y8+UjwAB1Qd229UzqikolY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kKLfIxzgTvMO7gchcBnxvrNI+Uxd7J6Bg0gyVpm81KfggwBcCNC8enh4q1VJwZPQzXO9mz45FOZSueKF2TvVKZ8JwndMH/Y2sDwEGmxlomlrx76gFgfRkVyggw4wrAPCz3GzhBwzylgzl2mF4bPTN5AV/+SUDXOHxAK9cymQKFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D6TGqHlP; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731414313; x=1762950313;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0x3uPbdA5st9pGcrg9mW1Y8+UjwAB1Qd229UzqikolY=;
  b=D6TGqHlPSeb3WO1n5xBMLzpwhb7pTXvI2O5QG3w72LWMfuelbN0q5eek
   WUJsk7MfrdnFM0mJmBvLYhi22rwFfyqir6By7Bn3wCyxSOtL6cjBNOUUj
   J7vLEDcCFBGNUGRrDDZRtKfsaO1aHnfn8zQ0EPHBwqO295268GLFC/w8b
   5UGR75LTZxc6c6oivFtj/pHtXmKRK1dpmJGWuuILZynC+Dfh9bGE/VtK6
   nLIqDtx5ZQ04siGRX6aCqhTBx5BAo7ekER+rLCy6Ek4QYvrgRdSMHpyCU
   1rADa2BBbS+PQR6pXt+KUHjlSamPHhyu+2q+WLz94rwqbMldgeW8qaP/7
   g==;
X-CSE-ConnectionGUID: cLOIzXI9TVaVjluSmePeSQ==
X-CSE-MsgGUID: xJl3syxXSpy98HeQdDdYNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="34111621"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="34111621"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 04:25:12 -0800
X-CSE-ConnectionGUID: huvqOgfMSN60F3fxM7EBVA==
X-CSE-MsgGUID: ss5L3xzQR0W+JANWnuFYvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="87606894"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 04:25:12 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 04:25:11 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 04:25:11 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 04:25:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9YT6zEpXgCsC2XLein+IEcafY1jyaURWSDarluWuyU06xfFqfIi9b2iMtNd2Am7fseU4aKxSet1Qg2fuzTcxwqZmbfW4LzBL1zoUKHRRbZ8jitgVzaRTdd1QKqgEbdCkqQ4QgA6fFmZfgHuYDXqIYaYbHrDV0sXzzapjMcX+gyz3dMAzDBmoqfgvAUPuwC7vZxaQTVKqWnPqBCWdLxyermaAdDYDBPp5W3nG3gL5Za0hP/vx1a40S1Vf7nsX16Snu54Cy5MPzjs2y6q2yIrdb0lk/zMn1c+m7B+i7ZY+/amrTTv+GvYUdPylW5ZrA/mpU7SbHvScTOu7urKmYBX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0x3uPbdA5st9pGcrg9mW1Y8+UjwAB1Qd229UzqikolY=;
 b=RkhBmVqOClKL8ufDzApaUUebFOXb9ZpzdKDk7gr+YXr1Y43KdisMfFl06gzIM4uw5iM2UILIXeg6PBED+hyONnouz8xewKFm3lNU6dhAQnWOkwWTTWiTSignCI6iGf0UdAEJyKHWrioTETS4SL6DX91W7jlt8blQJvxxyOIET0z1ut5cJ9at4PSfFFDxn84ucHgBanslwTC1nTT0m+GvGsnOnrOtI7Z69ExFNtbgP9Izc8qMRLL+CJhDP9RDlS1zDL4yazci+Wxs9LkM6tkkd491Mt89oAcFS3tzBjfFAzpy0kXSVuKVbIsOjBs1Jj/+88aweK1yiEgC8xUSAEpLdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15)
 by SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 12:25:08 +0000
Received: from CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3]) by CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3%6]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 12:25:08 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH v4 net-next 3/4] ixgbe: Fix passing 0 to
 ERR_PTR in ixgbe_run_xdp()
Thread-Topic: [Intel-wired-lan] [PATCH v4 net-next 3/4] ixgbe: Fix passing 0
 to ERR_PTR in ixgbe_run_xdp()
Thread-Index: AQHbJ1tHvdON1Zf4T06Qf+s+XEDQaLKzrHag
Date: Tue, 12 Nov 2024 12:25:08 +0000
Message-ID: <CH3PR11MB83134D45BA2928857ABCDCB4EA592@CH3PR11MB8313.namprd11.prod.outlook.com>
References: <20241026041249.1267664-1-yuehaibing@huawei.com>
 <20241026041249.1267664-4-yuehaibing@huawei.com>
In-Reply-To: <20241026041249.1267664-4-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8313:EE_|SJ0PR11MB5866:EE_
x-ms-office365-filtering-correlation-id: b891b1f9-3d13-4879-1613-08dd03150bb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?NCVPDR/rhVoD0Y34FrBA+R4sn/WOPhAsIXC+ILuT7Ij3V+6j0sqZ9u2uA8rx?=
 =?us-ascii?Q?bnRrYwQiHZq4tchm6uf76kxLK4068ZXrlXERKdIwH4gHyxabhG/rmt+UbQWU?=
 =?us-ascii?Q?Li9vVmNXQoc/PQ4zwBk5xfMdvh7is9mwVnNXT6tV2ywp8ZnMPt7Hj80GkQEF?=
 =?us-ascii?Q?3Ig99NAHJVt44m63HaQKKk6fFYybYQeGw3B+FOqeCw9fYkgfollqqbc3AZSJ?=
 =?us-ascii?Q?qQQurUcpFrMifnSrE+9fJBr5j0LK8A/pmGoPtGMYnFRBnhz4ik3eWWjafeCs?=
 =?us-ascii?Q?hhj79s0WISNBT+xiIoLuvy3Jwin2H8ZO9MMdzB/1yDK5yi0/SlbwZyTgUDfZ?=
 =?us-ascii?Q?auXWpLbSBqU/BNs08e+4svHu3aSMPXbx++YSFFtClI3JQUrQxLplmjXXk+r4?=
 =?us-ascii?Q?gCz0lPmSETT7dESRdfXlxoPows2I7+Byr3tYhvGWO2CQZagKf9HNOD7Erb4g?=
 =?us-ascii?Q?yA+BQgFppDK2uNg+AlZRYmPlOk2MrfbKepVCm6lv9BEERbZnCGxtCZ6AfFaC?=
 =?us-ascii?Q?kYKl3E5mfe51ePX4nvy0Wmcn5LnTY1a/euzJXk59nvj40KDeucU0E2KI45Qu?=
 =?us-ascii?Q?eY35yXbEbjqoi5OIrZp3X/+HCWthoDjlCDOazkewn2FE5aKZ24z5zJ91I0LG?=
 =?us-ascii?Q?9XpjBlAMxAUa75KmjWxeqGlW/qXl2vl47DvzhvKAgemfktr//KY6abUmcXtU?=
 =?us-ascii?Q?IzEdTA9TaHFXq7//+EvFGBgkTblhDFCmg+jgQGWy3NuMfrlWD9TtnPLaazoq?=
 =?us-ascii?Q?9N7SMjGlH53wjdXOtWJAebf0cAUDiPjaGMi7ewE0gGIT47gEc5R6WQCzLVwc?=
 =?us-ascii?Q?Hu/vVgu08Qqp1bzNDCJPdnA+BSl08h/jQAkYgZeM3TtinIrMmiQJkbaKxzVn?=
 =?us-ascii?Q?Z9HjWlARXvXWfp1XeKDcobcvqV1PP2HronGyOdPWs/KgSLF0hCKmz4CcxV6H?=
 =?us-ascii?Q?xXC8l2dkAvhpXusmqnn4NnOHRhDhJ8jxHYyBOGk5RD+MMPnvhKvhn+s+7qts?=
 =?us-ascii?Q?7HUOA3wB+8qAEtY0o2SvK30oGZODaYb3Vu8tU8n+R7C0cxZM+RVZl+9rkrri?=
 =?us-ascii?Q?2LWrmVXC6ZxR+3xRPwDDy98n3VXC5uGI7Y0CMJpnE3zMrx+YmVREs/N2Un+V?=
 =?us-ascii?Q?d/qmOgvg2C8P3N+s8bSiLiGz1pzTdzmYIZJLdXD50K0KPNg3qlibb4ZU7bEy?=
 =?us-ascii?Q?Us6RlyTdG+VUTMi5zFd+9UNm+cfVs7iOomV/rpSkJmbdyqJOchk0laM4bHjN?=
 =?us-ascii?Q?sfniL9upUVmzsEwI69CR4/niHW9F4BOaiPdK1acI6cbczRupjPNwgK7rUtie?=
 =?us-ascii?Q?GcgOqU9Dlb/VquYjM9+AFW5xWE3/beYsWGggJ4xbPll090prrva+ZPKMlitu?=
 =?us-ascii?Q?7dhG2lIUMx5AAroGxNx60/sBWeeo?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8313.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wLh+mRVUh4xZ6Ka7uIG5HFZNo1MSyRPqOrpy/KNUMYiutuHEBjvD7VNyBFlP?=
 =?us-ascii?Q?rdyWGV5bhsREdPQc5EoqifbXliOR5W8J61y9bagmRhMkwmTq6RVRFzroE+yN?=
 =?us-ascii?Q?CrlyhfKrPiRnMg61kLqzq2qLZXXeTnWif1feINNlAvImQskQm5YZSQ7ou7dp?=
 =?us-ascii?Q?S6iZN8T0ttDrrTf8WIZI4Qx2FjPI1zSNig8tL9RpKgpTFAOeh4ZfzC2b2vCs?=
 =?us-ascii?Q?XfSVY8gj55jlBh+/mKDiS2HgYBVTypUCxsg73bekqn4iU+IRJNKvJOWeywME?=
 =?us-ascii?Q?1f9wV1NIElY03uptbvXPkNOwgtzzSwwFYb0R5tnI9MlcgXVTMVozQRq0tkwP?=
 =?us-ascii?Q?voV7UmlB/z1bbhqu6c/L4hjnsoTHJzMiqXhGhrpOWPZ5FOi9TkbFuixB0WVA?=
 =?us-ascii?Q?ko0mIz/qgnixmLyxqNXvbw1iIYtJJM2idI3QLyd1ToQDGfBhPTsSkQ68I68S?=
 =?us-ascii?Q?Jhq3BlYMmeKUF6BuPg+Q17zO/TLCcKAogt4N6isOE+/kben6F/BrixkNTF5V?=
 =?us-ascii?Q?gHeLkYqa+zFsEHy9cj7NTThiHKZDbEFdG8Vi+mTnZnNUu7e4giGoorAklCAw?=
 =?us-ascii?Q?rWEMatV4wzRuTAq9cl7ZxwmCy2SE4cTcCgXzEzCp9/I0lkJJn5A2vTZfn1mX?=
 =?us-ascii?Q?BgWDvmvXJfrXBAKKSc6MGmcknNMBYiGV9ImJP08mrdTEORXa/4WzFZCl1hR9?=
 =?us-ascii?Q?tCyVOEK5k5xo018h1t5xtsCdeasUz/3aG6PrCmbFY0qKaNOy+gdGUXtm6R62?=
 =?us-ascii?Q?nFWpeNwpqGC1mcMzBQtXkt3R7F+BEhDRJfm9Q4+BsuQ1CYz98bowALRU0mgk?=
 =?us-ascii?Q?0uyjTVBRHrnVlG6ZJ9byt56qrrg9tcJKSK161RdlKuuaieIFi0TROzXmiNsy?=
 =?us-ascii?Q?KoK7jRDsijFw96+53JVzyDXfbcWBi6PCB5nZYMuHDPvQ3rTkJ7kZf62tJCL2?=
 =?us-ascii?Q?FTEj8H9aBspkbnlxgIiOOAlUJKS6l2yJW0avBIdpzbaxXA7JNvpKLL64rTEM?=
 =?us-ascii?Q?NkZ0hG2RRhKbqBcfxhfS6EPoyxIpPQ7uaJMwOPpiV4dvE07h3Jj0cKF/byLA?=
 =?us-ascii?Q?BDdGWhGyKNjgWlgkd3rNLnxu/oiqZQN7rJwWY5AR0pUzuvi6mPEhfDJSOzty?=
 =?us-ascii?Q?st/a5nW9RGXPyxe6PoNOL6WIqkEC9+1XO5zAOc/x/bNIRbk0PYEbBP7UCy+A?=
 =?us-ascii?Q?A1ppbUbn6A7xGZ1087It3sZ1i78mgVZzNf35DaddNraq54XfOf4SyXUSCsDd?=
 =?us-ascii?Q?43zi/MteEoNMZDOKXUNYqfZ5gC56WamOs+pLlwcDDDQBkGO3WsiQfqEXUyUJ?=
 =?us-ascii?Q?GkkbwFiPkNFtyrRPWbyyJw7TU7TV8fWJo+uB/KzLwyuJS/VA2241s+Ff9T4p?=
 =?us-ascii?Q?8LV+cSPdVMDWlDzWlgs19/Q2jLvYg5CvJJwwZcXkv31+zFV9opLcWeXy44LD?=
 =?us-ascii?Q?5xk/TexXTbcXgeq4405YX81FGOGREBSJH65rj7jmBzSxelGoRZWRef5V5IZ3?=
 =?us-ascii?Q?dSPETcdK9u8yHr1+HvTG374Ahtp2mvnO+/Wgx+E7yEQ31uCz3W8ostouMLDl?=
 =?us-ascii?Q?Tanpp2FacjkZkuAzNZvAm8jMMNR5M/SOamlGlLf4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b891b1f9-3d13-4879-1613-08dd03150bb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 12:25:08.1727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwrCbdksX/mDGo6BIlrbb1o6W35eE0T9jgT6EgUoHBx4EPjsyA+f3lgR/Y0waa9hxZXAfvz532CmjhutrmVICQ==
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
>Subject: [Intel-wired-lan] [PATCH v4 net-next 3/4] ixgbe: Fix passing 0 to
>ERR_PTR in ixgbe_run_xdp()
>
>ixgbe_run_xdp() converts customed xdp action to a negative error code with
>the sk_buff pointer type which be checked with IS_ERR in ixgbe_clean_rx_ir=
q().
>Remove this error pointer handing instead use plain int return value.
>
>Fixes: 924708081629 ("ixgbe: add XDP support for pass and drop actions")
>Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>---
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 23 ++++++++-----------
> 1 file changed, 9 insertions(+), 14 deletions(-)
>

Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worke=
r at Intel)


