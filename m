Return-Path: <bpf+bounces-30893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60F88D450A
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 07:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458D8285B6B
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 05:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14F4143723;
	Thu, 30 May 2024 05:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OC2Op65D"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41732D792;
	Thu, 30 May 2024 05:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717048530; cv=fail; b=tJ8HMddKmsruWRsKse4eUDeQZzJeRP558+B8sm8Wwz1XFjiZitK/Ie1Jbtjd87/UwAy7aQnZ436Dl7lH96QCdgSrNbEtoqlw4Zlz2mZoYeA8T4MYlbNoYWHm9XJzZOpsrgIaez7a8FMIBNEtdRNnpiQkidp/Zd4WKVHTyCh5fxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717048530; c=relaxed/simple;
	bh=BhEN9WRIsL+98jxHgbofexhtWn5RR5KLM+6ni547/rw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k6kaLNBL1L8fjG/ICz1pc3pRFBW1LtqxVuVfAfbtVhnXIEbIOMwr8cqGgO7a/DTzRyzPJXboyvixC9vScOQhRcUr9r3OAaCLNEvnAh47pNoJr1BvXw6a0b4S36c7TMS15dx0Z3HrfiL5ewqdZ2SAhJYUTRyC8smDNlZOiGkxGvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OC2Op65D; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717048529; x=1748584529;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BhEN9WRIsL+98jxHgbofexhtWn5RR5KLM+6ni547/rw=;
  b=OC2Op65Dwf/RUtQiVhCgmM//azRRr+wete3tjwcgCwd+W1cDJlodcPtL
   IxZbUA8p57CE3RpFQ0IhiTUktqrITXYGlOKSPjyrtr+WHhqMI9rhDa2Uz
   G1m1DGW1vmGRINs7pZ1LV3EAIinindeeCqlVBaqMHDorvweQVPXNdhfkD
   7y1Snl2/2V5BiuGtbQpmnS5M5nV5D5kM4J6ieoGuP8QVjbUMZxpRv/ZQb
   rxb4HPt8/IeZV+0zA6p+LDoIeGVaKsBvmF/h3sLC86KLEQrJQE1KX58wB
   4+gFuFv+/KB0fUL9MUGftOasi31iP8xHvXJCQzpo8xNzWep8xrkmUujc1
   Q==;
X-CSE-ConnectionGUID: 2xDoEXaxSMOQNSlw9TTq6w==
X-CSE-MsgGUID: 3kqJGOwgRa6aL4stqiHf+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13632824"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13632824"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 22:55:28 -0700
X-CSE-ConnectionGUID: OpWny8mYQau3jpSOw7tSMw==
X-CSE-MsgGUID: dN35xzH9TEOicEN2/1vhqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="40566474"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 22:55:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 22:55:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 22:55:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 22:55:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 22:55:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HheinCeraptw4nyY69nWwz2TgtZhPrm6fvMYtXW9/nVzvHG3mFhdzJIOKCNfaLuFQmDJIHerQ9N0FRcIuouUaHTMJCHu54QqZphvixkocs4jV45JORslV0dD0uGLtwmdW7n50kLtEy3QAuqtk2KNQXTsHrhxzdjxNsUBJQT2OX3FlAqZEvBadVCzfNflB1ML0rEkZhaz3i09oXQ1cPWeCPZZd/C0e23Sqqy4M+ELe6SOzee/gpTMxO4YJ2NmQHZdz1JKKku9ciCKc4ndCcSNX5KcGaOPl9dufcjE4DQjWunhwLRs7EiMPkW3U4s5m1ZaNboipDdL8VkO98IlQ46Y9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IuQDAJBvaBhl5j2Yuoe4sCXWUugD7I+j5nTmwYbzdM=;
 b=ZyLo9ximQQ+fTg1Nd2lh7wQqBvyeTsVzCZJN/wovdWI0g/g533VJyRbbLfTqA+QZGECwTpuT5xuqmFuGKfSrCvj+ElLZltYsCXSl94AgGU3ZkdKt2Zgt0FkXd2EoOVBiA9g84xD7YP9nzZWaKXWoMbSe6DtFxZ4OqPu1GBJOOgmHuoPMPi6PP+B5s+8YR5hXgZMtXR7gRsJMmb8ONOUoXNtCuzvOYnAF7BSCcmfV3u0UvOTbPIzEluJCt3MnRTo3usrqWWJnBBYRFwXmN3e8D6ARHOQcKZWRGxjbqMxq95VZ0KvReQzsYvZUl4icYXIGkU20ASzZ1aepNDyJXyV+yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15)
 by CH3PR11MB7204.namprd11.prod.outlook.com (2603:10b6:610:146::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 30 May
 2024 05:55:25 +0000
Received: from CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3]) by CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 05:55:25 +0000
From: "Rout, ChandanX" <chandanx.rout@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>
CC: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, John Fastabend
	<john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Magnus Karlsson <magnus.karlsson@gmail.com>, "Bagnucki,
 Igor" <igor.bagnucki@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Kuruvinakunnel, George"
	<george.kuruvinakunnel@intel.com>, "Pandey, Atul" <atul.pandey@intel.com>,
	"Nagraj, Shravan" <shravan.nagraj@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 2/3] ice: add flag to
 distinguish reset from .ndo_bpf in XDP rings config
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 2/3] ice: add flag to
 distinguish reset from .ndo_bpf in XDP rings config
Thread-Index: AQHapuJXNPjM2NT7gkKDMqhdOCS6ybGvXd1Q
Date: Thu, 30 May 2024 05:55:25 +0000
Message-ID: <CH3PR11MB8313799A179A9AD7037D5BFCEAF32@CH3PR11MB8313.namprd11.prod.outlook.com>
References: <20240515160246.5181-1-larysa.zaremba@intel.com>
 <20240515160246.5181-3-larysa.zaremba@intel.com>
In-Reply-To: <20240515160246.5181-3-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8313:EE_|CH3PR11MB7204:EE_
x-ms-office365-filtering-correlation-id: ab26c806-ff07-47df-48d8-08dc806d19fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?6RvFG7pPHeSol1HFypSJln4oCOpMxfYJ0rd+UQiUOxK5h1Jx5sSusoXhsv+n?=
 =?us-ascii?Q?ZdLrQGVr8VbWsfTvdMapYDpUtCwrh4XkVC1APEdsqejgaoZ1zHwBAOFD5j+q?=
 =?us-ascii?Q?9Vm7dLv2mc7tvsHo48T58dT/G5N7GMly3qkNUurkI18qrh3P/grXfnQDAtgu?=
 =?us-ascii?Q?XPye7Ljt4x2aIt3sYtD6aDi6eYWYu9JKnukhRMtkbu990mM3DCMM3EQE/Yp4?=
 =?us-ascii?Q?eeEHIC1V9f7OY82wPUUNgAFlFdbxCQpKHQMLyQ7agzfL8IuPfup5dYGiI/V9?=
 =?us-ascii?Q?LwR2gJDqSprDYlY79DkSDhHMysqIQs9Re3Vh/MKhRPzsCXbop+7uZrvwfVV0?=
 =?us-ascii?Q?xXxBPErb8UJmK9vrY/WoVQ9ltS5Jvyl66o4pzVcjVhiu6wsrIKokUm5Iq4KF?=
 =?us-ascii?Q?MlPYLD3UEvIWKAHUdW/01Npk0SYhRil6kgsJrum7XZ0rpXfYF+nSCIqt9wNT?=
 =?us-ascii?Q?MhXAmbRMfLlTxtRJNypsbPes9Ov7Pj3hZMbWG0H17dXagPRRMJ4i1rRm7/rf?=
 =?us-ascii?Q?2uYSQpY2Xj91qRefxSNGWDLDJZU/z8EacCyx68DuJ+ubJzbERj87dDL8lFgo?=
 =?us-ascii?Q?COJnPa+xxI2Bk1ODymXO5jJNiAlXF0jbHb8Gnonr5K7/3vNKI7xJi6tK5tEZ?=
 =?us-ascii?Q?UKIF0QmqRsidvgZvNgAGSa+i7h7odTTPxyw95meR0ra3w/lXfgVK6D6Eahgj?=
 =?us-ascii?Q?fQQbG7ogVwcS6g9MIVZ+nHBjUmSfhdRrnbjCgb04bQRzYnhQg35CyxHiM3yk?=
 =?us-ascii?Q?bHidwpUtREgKaTIe94W8N7/5scGhwu8o+9MhP+UNqDCkDauhN/dKEdFfHjZG?=
 =?us-ascii?Q?1avXJzlMmN+KOk5kgeO2Vh/1goliQ/kcaRG1BqhZnOtuS39Tp/Qb5qq6VCDk?=
 =?us-ascii?Q?fdFvA4eXKIFVYHUZ6YpfzdDBqSt8wZdSAR2oQy2AiMiB0DMDNJuaGWL78aA5?=
 =?us-ascii?Q?cqs3k+JeIjKtFupXiFlwew5TCuVYyYwCjzZ1kXBZyhmzRKLPTX1SDt72M5gR?=
 =?us-ascii?Q?iBqTqP6anOs/GQOiuPqFSBIprWkpTT4mw8eP2N/m7p+d1RzJ+RVbkKhcKhUB?=
 =?us-ascii?Q?UVumkLzCmmucDA/lpT76dyp3q3xS94M0aS+Q/6RmvqG5Mn2gTU3eHR3S4w/R?=
 =?us-ascii?Q?4GJZuSlXTo+ZUn7JjQgJLvV5r2tH7rRZiul6My0sLpOUwYBw42duE5wkATCo?=
 =?us-ascii?Q?20eCfxTh5jFB9+a//Cnt+tB8Ogqc94fnt49WLTqDFdPW7v3ec85S6YluK9bS?=
 =?us-ascii?Q?wDugg6QWjkb0aU/71N56qHrW1EfL60rpZXHI4Bn9DriyPSUxHSsquIfTyWd0?=
 =?us-ascii?Q?ATgjynIH0daO4ARZOYoM6fbsiKMZ3az6Vba08QvRPZru/A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8313.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B9tgF4wLfiYrpAuFnSqOfeNmxFpuoEkF+lbVcusDiVENaFPrdMKCCSvTtk1D?=
 =?us-ascii?Q?nlaYAjHLClALCIEw3eT4w4cKjXzkQ1wzxrkl0VgybD8L8BrZYowKGUcq7sFz?=
 =?us-ascii?Q?5TrkiS3EkKo8xy4g84e5pGphFKEYfdOh2dbc2G7nUIMNJAbMHJxg/4BxDumC?=
 =?us-ascii?Q?3RpGA5L9TU7SI9mAjGTirfGOVafLsewVA8EBVWBCSrB9DCusD7EjuS0LGUpM?=
 =?us-ascii?Q?K2cWmNCXUiAVU86nb77u/G5mH1v56om2BAciYmeoQ1R5Jzsj45Bp2P8zRwNt?=
 =?us-ascii?Q?ILaM8u1FHeFjSEQNPciMKfokh+llHDYKUo+nMr7S9zGDptecOUruA5KQL9HT?=
 =?us-ascii?Q?x+ckZy5/23UMApwrvPJlBDAhUDOxvC9PkpHViD1THQU2IzH30GqYzvVxjRw0?=
 =?us-ascii?Q?0M1IYB4XSYDkDwbs1t6CZi9js6x/DZ53Wug/QtPMsRcpRR7ioHQZ68RJN0Q1?=
 =?us-ascii?Q?Cxf05JlhFT8mxA1ViBsL9raGEBA16U0WqR02yqYYTbxxz8guyTla1SToC+G/?=
 =?us-ascii?Q?V6QqO/Xvw+tU6oV0ODLq9fOnhMvoUbFqpd2FX1DDq/4HHPNKX0yGoOW3HA6e?=
 =?us-ascii?Q?FJ0T9MXcfcM1Vtrg8b496HiIZanx6mRa5mx2TfKkXkoob1nB5nqecXl521+e?=
 =?us-ascii?Q?H0QXyM0o3Xco1DN6UGKPdVvuV4XO96tTLGRTj5QPhh57sYGIIaiopJ9xSbpo?=
 =?us-ascii?Q?8lBLqwY2IC7xrsjT/W2gPaUIeCv9DX3wg+E6B+uo5Epo3OIddrX4irYGDEV5?=
 =?us-ascii?Q?95Ab+WI2+xwhrTGmIbhuM/GQeUTzuau1ZT7yjsappxeYCHqFEXVByvBUBNG3?=
 =?us-ascii?Q?4EpN7dJWn70wjuHyOSL1075AvO0G3ndH6KsUGpwbR35tLnEC3/JGbGn/OMjg?=
 =?us-ascii?Q?4m6URzwDv/Vw9drbYXG14+NsV5tPnVnYf9unE42jjtK9GNXeFdXLCt3ZjWJ5?=
 =?us-ascii?Q?nXa+zYPQ7Hg2zw3V5z5j4ZLGl6Umakao3zqDS/GvILwSpUX/ueUjr7VWI5KO?=
 =?us-ascii?Q?oj9EzrTDUIVq+9LI23oSPhMxsVSQCDJn8sOvNbdmw6tQ03EDD2GndvEQZhAa?=
 =?us-ascii?Q?IOfPcJkF6EhKeKNZyvOmy0+6wY4YnYyP0QqGPZjx5TWOu4eq94arpPTYARnp?=
 =?us-ascii?Q?rDBLA+W1XyA3gVHBUTHfXxmw/ga3/HE3duc8hIujZm8JENETLc3KpnMw3UZy?=
 =?us-ascii?Q?obdJTdLKFzoBxuzaHyiIO/tjH7TXixB+4Vb3w0617sgW6BolBuF+MSCroFtU?=
 =?us-ascii?Q?E9z8K5SeVA9pU0mugw9hwSABujT3LznmZCa+4Y+mmSCGCWloKK0o9YxkfaVW?=
 =?us-ascii?Q?F9EnpoTcUNmAS18PNQ6ECkgAimqSkk3IpIbhG4sMGGNObqUo0sn0539MskUh?=
 =?us-ascii?Q?J8B/4jY6XnjXa7qWBXEivg5EEP0LVeQrl24l+Cl04IDQucQSr7zF26yFfb/v?=
 =?us-ascii?Q?fU1AdOpDofheQjbv3PS6Zhu8lVf5xG8Eqla3Of66uB4KIMzfUasEWhOXRkwZ?=
 =?us-ascii?Q?NP45Iz5HX9QAYujAnc6xF4qEsNGSvYb7NkPJeFa06xE3D0jQRUmw4Vm0UiNc?=
 =?us-ascii?Q?yjb47mzJtaCo4bphJMYSRQXSUhHs2Zevhieq1gm7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ab26c806-ff07-47df-48d8-08dc806d19fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 05:55:25.5027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EhuWnfCBAGejk1uaD8v8NWKVP5kC4WSpySpCblePK+706LCof63j7jEPcK2Wu8KdGhDeZoHW6yZWLc+HXNBiDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7204
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Zaremba, Larysa
>Sent: Wednesday, May 15, 2024 9:32 PM
>To: intel-wired-lan@lists.osuosl.org; Keller, Jacob E <jacob.e.keller@inte=
l.com>
>Cc: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; Jesper Dangaard Br=
ouer
><hawk@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>; Zaremba,
>Larysa <larysa.zaremba@intel.com>; Kitszel, Przemyslaw
><przemyslaw.kitszel@intel.com>; John Fastabend
><john.fastabend@gmail.com>; Alexei Starovoitov <ast@kernel.org>; David S.
>Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
>netdev@vger.kernel.org; Jakub Kicinski <kuba@kernel.org>;
>bpf@vger.kernel.org; Paolo Abeni <pabeni@redhat.com>; Magnus Karlsson
><magnus.karlsson@gmail.com>; Bagnucki, Igor <igor.bagnucki@intel.com>;
>linux-kernel@vger.kernel.org
>Subject: [Intel-wired-lan] [PATCH iwl-net 2/3] ice: add flag to distinguis=
h reset
>from .ndo_bpf in XDP rings config
>
>Commit 6624e780a577 ("ice: split ice_vsi_setup into smaller functions") ha=
s
>placed ice_vsi_free_q_vectors() after ice_destroy_xdp_rings() in the rebui=
ld
>process. The behaviour of the XDP rings config functions is context-depend=
ent,
>so the change of order has led to
>ice_destroy_xdp_rings() doing additional work and removing XDP prog, when =
it
>was supposed to be preserved.
>
>Also, dependency on the PF state reset flags creates an additional, fortun=
ately
>less common problem:
>
>* PFR is requested e.g. by tx_timeout handler
>* .ndo_bpf() is asked to delete the program, calls ice_destroy_xdp_rings()=
,
>  but reset flag is set, so rings are destroyed without deleting the
>  program
>* ice_vsi_rebuild tries to delete non-existent XDP rings, because the
>  program is still on the VSI
>* system crashes
>
>With a similar race, when requested to attach a program,
>ice_prepare_xdp_rings() can actually skip setting the program in the VSI a=
nd
>nevertheless report success.
>
>Instead of reverting to the old order of function calls, add an enum argum=
ent
>to both ice_prepare_xdp_rings() and ice_destroy_xdp_rings() in order to
>distinguish between calls from rebuild and .ndo_bpf().
>
>Fixes: efc2214b6047 ("ice: Add support for XDP")
>Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
>Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice.h      | 11 +++++++++--
> drivers/net/ethernet/intel/ice/ice_lib.c  |  5 +++--
>drivers/net/ethernet/intel/ice/ice_main.c | 22 ++++++++++++----------
> 3 files changed, 24 insertions(+), 14 deletions(-)
>

Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worke=
r at Intel)


