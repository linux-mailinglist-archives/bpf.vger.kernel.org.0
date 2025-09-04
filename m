Return-Path: <bpf+bounces-67468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C99B442BD
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26FAC1C85A57
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 16:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F0827FD7C;
	Thu,  4 Sep 2025 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DhOhIcnO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042AE2264BA;
	Thu,  4 Sep 2025 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003293; cv=fail; b=Pnc1liDgmwk23lz8343bkXrd/0ttxGAhqCbZsw2FnaJGXGzHNzJShHM391+5bmCUcH8dVzb1YYfB1rnYPEZibTQtXW5PIYen6hRK/ihTU5FMj3Pspi1NSyOO6fKvyOlC5SGVxedk8+tmGti5I3SkBLJcOI8iJN6y8QzTAZMttOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003293; c=relaxed/simple;
	bh=DkGkP2jGRVe2utfn1swxfiifKLZhVMeA6JyADBGjUnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kIagzYoCgmDy/0bcMrsRwzm9+7JRxMsNMavuOZEExTy7FBe8GzwwW86R4am5MvS+E6sV/fGjKDICnIbNZiG3A0FU12w3Li6aSdVkxU2HdJcxS3/d/dykKjmX0npjFVnAUQRcVg/MZzK4RT1mrXsCVwxwfunQormMFo95H7XsMJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DhOhIcnO; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757003292; x=1788539292;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DkGkP2jGRVe2utfn1swxfiifKLZhVMeA6JyADBGjUnw=;
  b=DhOhIcnOmedOHH710Uc53ZcPT+QZ/ia9SXjMjxKTmtc6BXRmgdjWpyM/
   tVDWuNTzsJsmaJVjZ5CVXRt+IJkdrpqJeEM0foDvpKc2glHWsvl6L69sO
   DWawrdW4+R22tBKHc4zp+wZ3YavMSvQMhBlDVhZZGYm0JdJIPvqvAPNq/
   8k4U4GPhYF3+nBwzKsupA+H4J0RB4aFZWMRDr/xjzwLjXZJtIZSzIRmds
   HO57BoLQuuQuxc0U6TYzdE6qiKYI8DiHeV4eo7dV1/X1HZx90h9PH7Vi/
   PHv9Dj3C7IE9DEP7PFu1du0jMq7qvXUJboN3bjpWTrPvP6w8r/3zMSc/F
   Q==;
X-CSE-ConnectionGUID: dmKezepeRdakcYhYVajq6A==
X-CSE-MsgGUID: OyCv+cSqTD+vHimpYfXACQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="69965048"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="69965048"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:28:11 -0700
X-CSE-ConnectionGUID: Jw8ObeuQRki5+0RTbrY8kg==
X-CSE-MsgGUID: eCoUcU7fTNmOWbW659moTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="172379543"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:28:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:28:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 09:28:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.85)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:28:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyD591RCVKeByIZrvFtqOWMnX9poU4hjQO4S5sVhKbiGsxkCaJ5bZfFLdeY/4juSOO156WbbS2sdQ7MT2mfS8xgdKMPHAeWxQHWi0P732HKBfATCBQQYSKx8KgvShjxDLlph7S0a0PUkZQsByAmDyayvZadiiN/rHHQZqGKmvqx/JB72FQj6sbcr4NCQ4pHL5WnynU7L9812tnLNONj9gp6TUnIaG/yLjjadlHSzFiV47g/4rBrgYtQ8boSV/zlMWbVQ/gTCsfMONkbX3IwhgKQU3HMwA4n4nQhnhbphZnjErlsId63W0V3SqDzXJkmio6C/L+7BcTXqHuH7QqHL3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5QmtK+KffA3Bi8Ls158skESbj8dFQjNvPjqzL5AZjw=;
 b=wFr32rOkq6CRkk1D0AtBQkPgBenIEHOjOWDwm3zPviS0UtqWzooPPT4qjmh3u7rDNX/LWZEKwEaAPv2sZTjKAeFEALN91IClkCslG9zZZwRoZUlIKxLY/DOymu3o3n7d3xQ6l4Y/BuCNhWHpVwE9rY1v5HVUx6RJxOW2w1dVpKXTn3GRZ/iacEeHQTSLh1ihaO8N9oL9QTVVkPCyQThk0jxmuewHKo253kwb3CigsomdPoaOKzkssJNTMkalUGyACSzTvQhk+NSs/Br0kQpBoG3fLDazYTOsluq/ILL9kuWfSMPzAb6be25/xvGdmw6JLbvRdJ1qOFSsu0kEAqyCDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) by
 MN2PR11MB4646.namprd11.prod.outlook.com (2603:10b6:208:264::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.16; Thu, 4 Sep 2025 16:28:07 +0000
Received: from DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425]) by DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425%6]) with mapi id 15.20.9009.013; Thu, 4 Sep 2025
 16:28:07 +0000
From: "R, Ramu" <ramu.r@intel.com>
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
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
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 08/13] idpf: prepare
 structures to support XDP
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 08/13] idpf: prepare
 structures to support XDP
Thread-Index: AQHcFqV6yUv0DNy0s0SawucyXD/UErSDM0HQgAAQTwA=
Date: Thu, 4 Sep 2025 16:28:06 +0000
Message-ID: <DM4PR11MB6455925760757264822902B49800A@DM4PR11MB6455.namprd11.prod.outlook.com>
References: <20250826155507.2138401-1-aleksander.lobakin@intel.com>
 <20250826155507.2138401-9-aleksander.lobakin@intel.com>
 <PH0PR11MB5013D0C085A90142820588F49600A@PH0PR11MB5013.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5013D0C085A90142820588F49600A@PH0PR11MB5013.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6455:EE_|MN2PR11MB4646:EE_
x-ms-office365-filtering-correlation-id: cb1c502e-8fe8-4075-ff5c-08ddebd00796
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?nxlg6u1JnzntohLVM6EnmSmtVREpkWX8SUBRkAW2nuDUS0aVg/HlgBB67eO3?=
 =?us-ascii?Q?a5UaEOhO+v56UMt4+Qyy+F04683WBGaISct/gm67pCkCQ/Er9jq6yaQWnEsa?=
 =?us-ascii?Q?p/BHpu6QP5xsiUMYDo/gs7+gm+JpqsOgx2TJrrD8/wfjOg43Xy/t8jRoZuFw?=
 =?us-ascii?Q?PTByVaeJjZEO0Eq0ywS+IGNSqwmX+xjWi7tBz2w1gLjvaJRHJtgwexAB7ATX?=
 =?us-ascii?Q?ekPN03dOg2+D9Fo81usXuHjD1jvFFAsiNqb21V1ZoeeEWz0VNjhrvoY+MR0a?=
 =?us-ascii?Q?SnCFFSTP9iNMzLEnjhRUGUSnX0yjWmP6Mblv3AMvB3Q0fsS5RRbKodfij74d?=
 =?us-ascii?Q?jdPeylUYe9daEBoq6jJ1PkaeLP0rCGQXXkRuW1RDYBa7zzPPfkt/0n1zJPcL?=
 =?us-ascii?Q?sGoHj1HzreVO302ORI0WCGI6swlQC47y6TPA4WkBdoSDUoCKRqmENfQBgvEJ?=
 =?us-ascii?Q?fF0CjEHXJiRiSFTZOyjY6XXiaAtZfCePQkfvbkJzr0NtRp41NdQGrZcSk52L?=
 =?us-ascii?Q?wenm81fmdu/yaIwu7QVbfxQbabeSeqCfv+mZn5rlUQ2UkrXOSPNvgINAd6mq?=
 =?us-ascii?Q?w7M3hnzGrc1OxTXZrscXzlMo6xTilPsqplnFv0x1FjWw2MKeyEAEb6t9ByEz?=
 =?us-ascii?Q?hRdLbe4RHAJq/d3hP4XXsAP3+n2a9zrRAmgeHTKszy/WOXbxt34BMNUfkUze?=
 =?us-ascii?Q?+M9D+uc9MdHbz/iiiuPjwiqDGNz+bElE7+TUJcgLhoz2e4oXxq5OL6SjvcMX?=
 =?us-ascii?Q?KdGT1ac+UE+YpJG26gQiHGipPaugEFbc58RFKXMKTWYIlCPGrejBvfOZtagI?=
 =?us-ascii?Q?8HXS0IuNuans9cZ/D9ukQV7IcUp/dsRVX48paHfMgF3hc0j0wNNTmj6dr7EF?=
 =?us-ascii?Q?GRYJyze5k8jfQuAyYnjxKVtHaIYVbIjzLJWnF+feVY/1qKED8/rgfel/i/gj?=
 =?us-ascii?Q?C43wQkmQerhIuPaE4xgMK847vHCBZA+SF4r7Db3BJVDK03fCGHIz616WVOiG?=
 =?us-ascii?Q?de4B0gYky3dFJdms1+ZItEbL2xXtUmSLvKS+CbpmVyyVf5tzNRI0kglJzy9h?=
 =?us-ascii?Q?YJJW3pwQWjA4oFU12pVLcr/PvlQkgK1oBS1KNxyQyjR7hTVcLaYMBjA+05Fw?=
 =?us-ascii?Q?JFoAfNzJhb0qLo2ZIVm5ih3cTQuiTHtGyfftjgv7CSsvyX6+xfA7Bc7V2CKe?=
 =?us-ascii?Q?ISg+87KLaxOn++sm5wGhAK1XeB9kdv3s42qynmPEFEgX4Z9Ec0tMjFuyQazd?=
 =?us-ascii?Q?mKHMIN/ut0sfHawc7OlFS8pQkhFYfAl75y9bscKZNIUmwhuk2yZ9xR8Aao0a?=
 =?us-ascii?Q?Dz61GQ0z+A8Vi3l+iWkX7T6Qa3+Mz4jKxv+YyU2vx3tmAS7DTGEz0t21Q/4V?=
 =?us-ascii?Q?PiYmAqXm4KiS/y3u0XrKeofgms90xHpIL0qFdE224RRIEybKDwZDIpnhXaCR?=
 =?us-ascii?Q?MpaIhCYRhSAFiMn+10AMEoibdZPnUFumqb33RKC8olvrWfTrEENCVw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JTsFvKvQIccN3fIMkBLwDgXjEkJzcKsLRw8saBQqKWkbf6voNrsJBSYSMmyX?=
 =?us-ascii?Q?YKySdpelBkaJchWyR3ByH3jTVX/+Co3qnmd5yZc2P2oC1OZLEhe+pVFbi5ha?=
 =?us-ascii?Q?3NyQ+txjpGHs8Y0F3G0Nz/hyQI9G91BFWXTS4+o+180cig+w2ohisAcb8a6d?=
 =?us-ascii?Q?d5mtfiAH5ycll2CufMpmq79YqUV/8qM1cHDmT7U5+rqklIuM7waTVwaLOfTs?=
 =?us-ascii?Q?Uod+5JHJShAopBQ5oKqVWF+EYw5gOma2c141gls2gOksjZqHaqRQVLFcEzqq?=
 =?us-ascii?Q?KcdB9pUTFKCEal4Y3W4sTbplR93+g6TQ1E3QMr0myvL3W662XWlEL/TaZj6J?=
 =?us-ascii?Q?cisFXJclfI6nVIcLtIh+xUwV4Gm98Dbos9JfHqLW4hI4QdyaTcJu6+WpY0ut?=
 =?us-ascii?Q?mmfpS5txkBBI6mh3j7QK3vhnBuAiYb/23/rB9ysZQDe7MXniIiK5dPtN9lAl?=
 =?us-ascii?Q?Lo+FvvH/OcA/MsDqkR0V3zREY9NBSTijagdgyqcj1G08VcMJoTsk1Mxm/++b?=
 =?us-ascii?Q?IcpV2TYkmkVnh+h/bzIwavPGdKXJeyksqOzSp/wDahgs5aNHXhu6KpkjiX4P?=
 =?us-ascii?Q?EB8mwiY0eHixsgC/gjrbrN76U6gRDoCNNBtoXJRXHvihtUzxPn/5xtV+LzJY?=
 =?us-ascii?Q?yyQU46WVW2/XsnJ06u5BbUw0w3iL0yPe6u4W04gulCd73bMdtObO81m+5d4J?=
 =?us-ascii?Q?uITxWtIf5Rs//fAJKg72VJuR96OySSI6Zxxfy60QnlQ4qYRtlmcOgF+wXwbp?=
 =?us-ascii?Q?VV6FCPnS0Qm3/q+Z04Xp7nBSOfXOrWowDTZjT1qpMKMQjwO+1pAXZgr5SLoX?=
 =?us-ascii?Q?adxS1b9dy+8T8qxukKaFmqSxViCaJTFXwccN0+iC35vkHq/9fmhH7puVi5A4?=
 =?us-ascii?Q?MioCtFOqe/JOMmP8dgZmvQt+WSYrAvLGZEDcgcYfHp4ONE7WJFI5H4/JPlps?=
 =?us-ascii?Q?1OgDrM8B4Ute/RDtD4KKgFhWnVsduYo+CSnY/8pYld7CBTm/ZRwmVSyTBgQO?=
 =?us-ascii?Q?ONxmjdXwOEfpkVgL42Keb3BxAA7k/ed9DZ7YX9PtJy/baacJblEpniyW8j5H?=
 =?us-ascii?Q?3dHDP44WJA0sy9idHULzIihVHmDzQVgBib6q1Ed5N8W4K2nUmuQpthvgo/yr?=
 =?us-ascii?Q?cg9jwQ6l0DGg2exWFgxqjNjmzoLOZLU4eBQKLoqWon82WFMiBJIYo+XuXUQZ?=
 =?us-ascii?Q?bZRC+4uiomNLnuK9NE/gu8w9aeIy458fkfrmYF8RHRI86B4qnN9EkM+WxuCH?=
 =?us-ascii?Q?VEhSXcexRFnFS0P2AHHgMEUwFjSYAsYzIPRUGJe6YD9700CV3VPycj3qaGTg?=
 =?us-ascii?Q?HWDOwmST36nR29rV0KE6b81HR1qsKaHpLa+4PSj9EAF4kQAi0WIRxeb+p9+M?=
 =?us-ascii?Q?CftxArN6RX+K94ouDMaj6GcaWK3Dvt04bUtQ6KCTz/5gLFr8mrs7BpnqmY1I?=
 =?us-ascii?Q?2oCSJHHS7GaX3QEEosaFeT0hu9VcSaVBrlczyC0jooirtRTpnLZfOQu5c3AL?=
 =?us-ascii?Q?MyUVuOA27eDF7SutCB3qL+OGHwBXCHi+JhSHvXBtqv7crXO9M5vjovKxEJ4n?=
 =?us-ascii?Q?DvtYpp9s23UM/2lMD7U=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1c502e-8fe8-4075-ff5c-08ddebd00796
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 16:28:06.9005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yBGnCZVWhnargSHH+14bH2mCCMBe+fmLOvGmY7Rq2HFi4qYz8hLFnmCXJxT30pej71x3/kFIXXkPb1PVyZhakA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4646
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Alexander Lobakin
> Sent: Tuesday, August 26, 2025 9:25 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Kubiak, Michal
> <michal.kubiak@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> Borkmann <daniel@iogearbox.net>; Simon Horman <horms@kernel.org>;
> NXNE CNSE OSDT ITP Upstreaming
> <nxne.cnse.osdt.itp.upstreaming@intel.com>; bpf@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 08/13] idpf: prepare struct=
ures to
> support XDP
>=20
> From: Michal Kubiak <michal.kubiak@intel.com>
>=20
> Extend basic structures of the driver (e.g. 'idpf_vport', 'idpf_*_queue',
> 'idpf_vport_user_config_data') by adding members necessary to support XDP=
.
> Add extra XDP Tx queues needed to support XDP_TX and XDP_REDIRECT
> actions without interfering with regular Tx traffic.
> Also add functions dedicated to support XDP initialization for Rx and Tx
> queues and call those functions from the existing algorithms of queues
> configuration.
>=20
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/Kconfig       |   2 +-
>  drivers/net/ethernet/intel/idpf/Makefile      |   2 +
>  drivers/net/ethernet/intel/idpf/idpf.h        |  16 ++
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 100 +++++++----
>  drivers/net/ethernet/intel/idpf/xdp.h         |  17 ++
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |  21 ++-
>  drivers/net/ethernet/intel/idpf/idpf_main.c   |   1 +
>  .../ethernet/intel/idpf/idpf_singleq_txrx.c   |   8 +-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 106 ++++++++---
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  25 +--
>  drivers/net/ethernet/intel/idpf/xdp.c         | 168 ++++++++++++++++++
>  11 files changed, 381 insertions(+), 85 deletions(-)  create mode 100644
>
Tested-by: R,Ramu <ramu.r@intel.com>

