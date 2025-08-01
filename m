Return-Path: <bpf+bounces-64892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 874D2B1845B
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 16:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CC53B6378
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 14:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5877E2701CE;
	Fri,  1 Aug 2025 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VdvM60Sw"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7B426C386;
	Fri,  1 Aug 2025 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754060341; cv=fail; b=fvDfO5+K2SVOexNRRGpChOgRicjozY4ALC5Ds6tUfzKwdf/lTMCYu/K4wEIWok6RJGLZRDVebh60OEIRn27s/y+BCZl7+VnqG+zJlo0Oo9uHSiciCxuEA5J3jgVpbqHlDBD4OCEBLFAnX++h7rz+ZH/Rj3HC9tJw9/ZOVhRu4WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754060341; c=relaxed/simple;
	bh=+HqShfTxxf70b+X1rZCoNwbSKG0Snm83F0/Oq5seAbc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EnnEHjy2od0Xmlclnc/KQBNoyVJ/UQRt5sgavsHF2F16LeqNpNQmyK7mYzXkv2Y8QdnLagKjepDbWjuYtgn6uhFK08Y6DYLM5PDYIEVJwKRLVHfsPFvlvop+bUuxIe98X89aC5mTu2PSSVlNl0SkeC/o6ISYtewdhtw9iYTeGE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VdvM60Sw; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754060340; x=1785596340;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+HqShfTxxf70b+X1rZCoNwbSKG0Snm83F0/Oq5seAbc=;
  b=VdvM60Swh0b6orBS1EtkDUteiARMIGIdfUUPgW/+wHtT3egeKjbkyqQo
   HSrPmFJqzZ52fAOGUlTsJwUaNL5YjB6ZwzhwhWTcuDfKMbioJUBso+kSU
   XEU/p2geZN4E2V0T8wCfyNrXiP8yNgwkvMTKIo3Ec/R4meph4th5uT7UF
   cUZZkJ9Z+GrQs4Sy79lVPfElMeRwdt+ly1W9KnK63BARuvuGl76ZaZFqj
   JPhrtIuSKw25dJhId096uF6PLS/Y510PJPYtjavobvmCAwT38OmRS9+aC
   iDb9L7WqBockCV6n62HKixDw5pFn5sJiwsoO/lCUBHrutbPfBbcDe9Qrr
   g==;
X-CSE-ConnectionGUID: fasWMXukR1qeqxhblMDZOA==
X-CSE-MsgGUID: 2sgjk2IdRIiVYPtUCpCNOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11509"; a="56367774"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="56367774"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 07:58:59 -0700
X-CSE-ConnectionGUID: C+vHUESARXqWiG7CdRw2ZQ==
X-CSE-MsgGUID: 0VPFOWX+RfyEbDpotFqcnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="163597921"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 07:58:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 07:58:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 1 Aug 2025 07:58:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.75) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 07:58:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZB02/GUYWeTkDHkmfSrL2js5e7LqsOWxudy1aypa004sEs3fDL6bdxCbt2Tz7Yh/A9PkXox0iB4Y3q2trrXY4zgWs8hw5MqEVOCZ1QjCUBIbvPs8iz+BdBEfDoEE4AJ2QoXiiPjryDqUqxgmWTsClkMrXa6jlQwNpgxX3hGXQGISpKSOrrVQKyRrVORQNcqqy3M1nRMybcrMClAlW8X5iGVT4me5g/EjLxjoXAZQBC1vOJ74Zbz5rVzH1Ovzbx3KEfXOVoUB7CtbnFTi4SFseT1C9a/kF6VOhLYmA0wW6BeBhd56oVxtaaOrtTHfbI2HOwW0+MAiXT/jYZ7LWxxOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjvhiOm4KFoBLzEFr/uEGAFT5Z5K3PLwVYPOq7tRfQ0=;
 b=LAwuJTZ0xdQIp13zq5n+4Xe4WYycCcMIm1yJ9pTTGXqv8716KJnM1ILmPe1mbsFNp6dZjvtQapufEGdvOI5mTfnvWDaCRTalnr0yX6VKmyz8rO2umZx/DJmp2KWvO0HzeT1hBhZ8B9WgsQJoFyH9BDWmQBAvocA+ZMBzbgBu9N4WbuOGPU5YU7moPjnWSJ6iMl0rwJrO7zn9VVNBtVNROtd0dzrz0gEL5HdAymLQ/Qwa0DZzE9xWdg4IBeK8HPx+THhsIuBceXetWzrr33yo5vhACWuE4mwXL2fyziO/JN4zZPzcScFV8hmz2Cvh0UigUHjiS2p4OS/OaoODuoSVXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) by
 CO1PR11MB4947.namprd11.prod.outlook.com (2603:10b6:303:99::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.16; Fri, 1 Aug 2025 14:58:54 +0000
Received: from DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425]) by DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425%6]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 14:58:54 +0000
From: "R, Ramu" <ramu.r@intel.com>
To: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Kubiak, Michal"
	<michal.kubiak@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Simon
 Horman" <horms@kernel.org>, NXNE CNSE OSDT ITP Upstreaming
	<nxne.cnse.osdt.itp.upstreaming@intel.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 01/12] idpf: fix Rx
 descriptor ready check barrier in splitq
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 01/12] idpf: fix Rx
 descriptor ready check barrier in splitq
Thread-Index: AQHb5SeBM4ANbBUdOEGrullY6ZGxlLRHqvgggAZzUyA=
Date: Fri, 1 Aug 2025 14:58:54 +0000
Message-ID: <DM4PR11MB645575C89CB32AE88D2BDE4B9826A@DM4PR11MB6455.namprd11.prod.outlook.com>
References: <20250624164515.2663137-1-aleksander.lobakin@intel.com>
 <20250624164515.2663137-2-aleksander.lobakin@intel.com>
 <PH0PR11MB5013936858D20BB0AB3BD607965AA@PH0PR11MB5013.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5013936858D20BB0AB3BD607965AA@PH0PR11MB5013.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6455:EE_|CO1PR11MB4947:EE_
x-ms-office365-filtering-correlation-id: 1dc116ff-cbb9-4bf6-0dee-08ddd10bef4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ajps27yV96uk6nnAGYVH+bPbNyVh+oWHcA5KNmtVqum6mCihHEGynOW4+5XI?=
 =?us-ascii?Q?Mbp1rG2E21Xq1I8hvItU8zkKu4275gpDNWdfWUijaD0RSFZgI+7BVaU6bOhf?=
 =?us-ascii?Q?l6iwbikjp7xHoUA5vKOeNSD5rxeSrHz+bhqxBqBXcUN+KV9Okwcj9+7cz6Yv?=
 =?us-ascii?Q?9I1fwe2jgj35Pfv4xHm5IRRzvsKyhGnuOx3IB6D+TTAqaLNYtxIoT3lcyeNi?=
 =?us-ascii?Q?Ky3u1Rl/i7XA5ZE6KPM0S5WT4BIBH9Mi1A/4XgiQ8ZrqgiMySSgK7HCNUzPy?=
 =?us-ascii?Q?f5DJ35WOcCLsu7y9J2Y9qIT+FZq4qpogBO3HLBWDd23t2TO+ZWsNBP/jbhZt?=
 =?us-ascii?Q?MWWy3wD7ZbvtNqwZmsq6ObuS1J5ERGZTpohYtwjp0tzVhjVX8u3c9/5YjPYs?=
 =?us-ascii?Q?c7JxwY7oy+LPgr5T+JzGa6g/VoTyN7kedJsZNWvOxxGW/pnd5iBQ0ZUemRc1?=
 =?us-ascii?Q?pi4Hz207Z5rNWecwqdZj6kc/kVeJ3LC8uKpcYsOPo4OEaCwJBzEpbtYIIo08?=
 =?us-ascii?Q?HLhwKev51CXQ4/78j6H1CIzHqgbPKyznKGkBOYXLAqhvVumxZXqYVYVzSCE6?=
 =?us-ascii?Q?ZGacO2huylYlj3EwUzEG4JAUeRY/6/U3DoRw6mvI4/+oUyrjaovEviEmjTsH?=
 =?us-ascii?Q?xjhdYuK7Q7Nw2XT65AiHpyocD0fCS8/q0np4mOvnRgJVxTGCPSXOKU6Z7/AL?=
 =?us-ascii?Q?gdUGJBYOX9fhkf20/XFZRID+oSrnSWJ/MB13bpBIYZt0L5qzyzRtqQeTUcpz?=
 =?us-ascii?Q?Fsv+y/dAVI1V0DOyAPHTxFQ5t7MpXW2DODruTUb8sDigNTgBffijMwcJfwOs?=
 =?us-ascii?Q?sdXdvDBJmZYVVVS40+ooM5cs0S7vm44ST/cB4Gfm5bdBArKHwqObYGkpeX1u?=
 =?us-ascii?Q?ulLd9cIYNNHT1YhBa8vf5F0NSqNuFvR4S+skMT1mLy4xGZi8aG7bPNWW4Q1T?=
 =?us-ascii?Q?YLNIps3Whob87Os1FxI0eX5dTt4405yamVg6LIEOqJTAX5bpabBmQrbjw6RM?=
 =?us-ascii?Q?4gaHQoh/e8dtAXwccPnuA4gQg4JA9oVBPjvuLWAOAgWoOdw5LMTU7B5qx5he?=
 =?us-ascii?Q?dKaAYf5LD0lQ44XtkaII6e6vilRK8M5l7iTqycjoXQ3Fhmgq/KOvEif/9Eqx?=
 =?us-ascii?Q?KwMxojMBRkqqYltQBaDf5wIRPU7U0hEAu/ysY5ynSMmbDbASBSGx74Gp93kH?=
 =?us-ascii?Q?Zu1DBCd6V9e3xfk+UACVYLEK+FB2IkT7i90aUB3eczG9ncVrsiumTzLJRUjy?=
 =?us-ascii?Q?4jvwBsQrT4923haooXu0iIgYEAnCuOnPmslVmNcFR+uWvmwlf39jRlM5myjU?=
 =?us-ascii?Q?fUd/90MqkbKGOOCzniGVuPiaBlmngE3zm7h+oEa9sKevpuiHr7WIBPpeL9VR?=
 =?us-ascii?Q?09YvA8DaT4nJwlD5oGRPGVSWm8ChYEtY7/PiuBIpcfG1hKKr0Z3H3TPmPV03?=
 =?us-ascii?Q?hwDiADDQvQc8B4eCppODNIXWjRkSHX5LAVSSjR7NPu0fcDIysXKTmw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wCoaO5qNa0jveKYGdTPr8BeCszJaNJ5Yjfbu5Bl7MmYQT4Z0w7r1uY/8iI1e?=
 =?us-ascii?Q?jC/S/hTWbHyH7auCiDc/RWAi+tZDNcYJHwFuKI+shi+8iw24oGWOQ64oU82/?=
 =?us-ascii?Q?3EmnO3V8eCD03cs9Znr8DspBF6JFDl9PVNFm/96QZGZGVJ/bXe/igFt9MbBG?=
 =?us-ascii?Q?H+DuFYAsW8m1pAxRe/fkgf8ZF5GvWVSGftu9bkYNa/yZW6oF9CG1yIAdA6wX?=
 =?us-ascii?Q?7zpPKFXOk78TrJqf+Sq/pWrYOjhGK0FRH2fh0XFLiL9zu/7ao0dSSoyeh2a1?=
 =?us-ascii?Q?ju0tp5I7AkPjrd5tUzdPFefjV+kccJVcdy8d7YEq0QcbnzoEjJeLKBpWVK0n?=
 =?us-ascii?Q?PXJXQLG0SWZt4sE5KdSky0mbDMBsubFQTE39KrVvmA7JjAzAzkE8xPu+Ghz8?=
 =?us-ascii?Q?lfndnbXZBDi6bx8zMmGKE3ELdXlnPMUpcJY3iSNECo/CN+pzr/NioR3wqIuY?=
 =?us-ascii?Q?u2RrDuxsU2KpQ+8P77FrvNrG3go6EMRc3Q7UubbS9IoDlxK3Db0GJsi/JBpu?=
 =?us-ascii?Q?IgcCFdPumXR4laImU27TtG2GqwTiGP1sdv+VD1Bw//LuoniV1lc6OqrbaJZ2?=
 =?us-ascii?Q?sDdJp2f3qXefv9oGdX1Kw79AVWic6LETAtcCne670/dj0eM1Fk09lopTLumL?=
 =?us-ascii?Q?xwRFh9jZeaHYXxZUmdS9ZLF3qsuqKFs7cCRzG1yZO3fkfiC0iGdRetGXJKUQ?=
 =?us-ascii?Q?PV1yka/M215sj+7nS7dttabX7ugjsBZH+QQOCAEv+70dWRTR1A9rcGxu3HaZ?=
 =?us-ascii?Q?Tn7slbJbjdl6nRceDe17wNlg6rbJEmQB/aMylMB99CxhJzGcIkKa7CI/ZIXh?=
 =?us-ascii?Q?owP9YqHbO+3HsYYhtaS+oIeF7fmsYO3/l1tVKvQinML6jCcTGi9kS+VhS3ci?=
 =?us-ascii?Q?9AHeeCVtlnDlOsPFB9i9Ex060Ry6T5pztOkxi0ajSH04z4CbqrB8fG9gmphC?=
 =?us-ascii?Q?oS7uJWIrVHi8HfDXzsIat187GZlqxYFy0ol/ge0OWphS3VdVhZRjGbUhgDfP?=
 =?us-ascii?Q?o+RIraCrBzMmVCXhaTsGKfy0Rxhm2TrfwDwx6oAc1qR7U1/eKut7fLbBcosz?=
 =?us-ascii?Q?gm+KR0EkEXHQkSTrZVtvbcUYCAIO5Q4/8Or5uoiR6E7uOte4GrrxesnbebGz?=
 =?us-ascii?Q?FPAlPGfkVkagyJzAo8JHDysG3c6QwC/rBuP6Ls0za6vU3pOYbWfaviboGwoM?=
 =?us-ascii?Q?/Gzu5DIIlPrVR1fi/ufLVzleXAB20DnKqixDGqDq2h8bx9xsl2tPj/5A0OyD?=
 =?us-ascii?Q?X9rBsBMCwQsxZtyrph+1WhsbEtedvMo8iQAyGVEfVkTrjAmhLaSHya9HavxK?=
 =?us-ascii?Q?2Y1f8HK+AkGcqWauMtu/b/sWGeUPa2PLqigwaKYTmI6gACmFTz0Qb3KDWG6K?=
 =?us-ascii?Q?0vJuG4QpSDymfqo432Nonhezx+l38Jf1R7bxLsrxyWbI8FUMbvn091FavH7e?=
 =?us-ascii?Q?CRmbH80CVzsbgzywMbngpSJxUw3Fe8Uw3ZoU6fgZscfdNk0NOB67Q2ZVjEGf?=
 =?us-ascii?Q?Q+KiDS6kvUaqH+wOHhwLKMqK+GvVtfYaGllmsMYM8j6eIfe1PIOPnB3+6shs?=
 =?us-ascii?Q?bDnOrWn8l1QomC37Z3g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6455.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc116ff-cbb9-4bf6-0dee-08ddd10bef4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 14:58:54.5833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nrfegZtql194lb6dtef6gouebxsFgL/fwxlAo4GZjGadiHo6siS17JIP/AciAprnWE2r1nlwX8LIgPezJEqW5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4947
X-OriginatorOrg: intel.com

Tested-by: R, Ramu <ramu.r@intel.com>

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Ale=
xander Lobakin
Sent: Tuesday, June 24, 2025 10:15 PM
To: intel-wired-lan@lists.osuosl.org
Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Kubiak, Michal <mic=
hal.kubiak@intel.com>; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; =
Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemy=
slaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S. Mill=
er <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinsk=
i <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Alexei Starovoitov <a=
st@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>; Simon Horman <horms=
@kernel.org>; NXNE CNSE OSDT ITP Upstreaming <nxne.cnse.osdt.itp.upstreamin=
g@intel.com>; bpf@vger.kernel.org; netdev@vger.kernel.org; linux-kernel@vge=
r.kernel.org
Subject: [Intel-wired-lan] [PATCH iwl-next v2 01/12] idpf: fix Rx descripto=
r ready check barrier in splitq

No idea what the current barrier position was meant for. At that point, not=
hing is read from the descriptor, only the pointer to the actual one is fet=
ched.
The correct barrier usage here is after the generation check, so that only =
the first qword is read if the descriptor is not yet ready and we need to s=
top polling. Debatable on coherent DMA as the Rx descriptor size is <=3D ca=
cheline size, but anyway, the current barrier position only makes the codeg=
en worse.

Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethe=
rnet/intel/idpf/idpf_txrx.c
index cef9dfb877e8..0ba766fe4f26 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3376,18 +3376,14 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queu=
e *rxq, int budget)
 		/* get the Rx desc from Rx queue based on 'next_to_clean' */
 		rx_desc =3D &rxq->rx[ntc].flex_adv_nic_3_wb;
=20
-		/* This memory barrier is needed to keep us from reading
-		 * any other fields out of the rx_desc
-		 */
-		dma_rmb();
-
 		/* if the descriptor isn't done, no work yet to do */
 		gen_id =3D le16_get_bits(rx_desc->pktlen_gen_bufq_id,
 				       VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M);
-
 		if (idpf_queue_has(GEN_CHK, rxq) !=3D gen_id)
 			break;
=20
+		dma_rmb();
+
 		rxdid =3D FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_RXDID_M,
 				  rx_desc->rxdid_ucast);
 		if (rxdid !=3D VIRTCHNL2_RXDID_2_FLEX_SPLITQ) {
--
2.49.0


