Return-Path: <bpf+bounces-36660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C767494B4F0
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 04:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58EB11F21370
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 02:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB264C2C8;
	Thu,  8 Aug 2024 02:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="haWhXhHR"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672DA945A;
	Thu,  8 Aug 2024 02:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723083402; cv=fail; b=pJafczIfH7ReFiGlhmS9+qfYtBnl7mjG+npCRnRm6FoiNAxdtWSG3NnPwTjz9smpCMbhIXLCfut3VhWM9kIul4qug3lRTkFOVHRC4SGMmjlePF+snTkeQ/q5O0nA17qqjyIZtC3x8UpQl+ObErZrzHozuTIRPcteEG8ZpEqSI5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723083402; c=relaxed/simple;
	bh=V8zbGBTpIpBDL7W8UgePLWgJVTchmfAyeQmLI2d0D8w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WrmtQIxdOqNmGq2NmVsduPiFTL7Vo8PEnoWVfDNK3KS4ru5GGSimVJGsJIf+y6qlGhyLWunukDLTRXsethOzT5B95rCD7G4BQNyiqhP661NFWBQgCI6id1bRb/pHemxvuq6pJTypyZePPlOpa9iqZw5nHyFU0Mpzx4Gs8Fx2jNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=haWhXhHR; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723083401; x=1754619401;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V8zbGBTpIpBDL7W8UgePLWgJVTchmfAyeQmLI2d0D8w=;
  b=haWhXhHRQ7Nm72jToV7iP/jhInQs/9OOxIEwL+Ty1Q+WsT8yXepQ4mC4
   sXvMSsm4dlMIXMJjMPt76Ns+xgjkiUzV30UnmtUQ4gB+f8KPnk7VR9ox9
   YcCCJAkRl8n5DsOyEK14T5eIg+83CLsOQg5B1y0nf8E6O368rVXRe/HQJ
   ZqqQncbtapTah1B6v6OEoeIzABUPFwYyT0K4dmCNcOUQcDMOvDsi1P0DE
   zUWeu6fqijev2f+PRakKIK0mqBLMBM/FxJBtn4q5M02AkvWhvhT9pRiO8
   Evd5gLDoC7ARYJs7HP4qOiz1u38AfAFTrXuJqEMttBpxjMdTbytPjiEw0
   g==;
X-CSE-ConnectionGUID: peHczsfqRiKJrNeJzRpmIA==
X-CSE-MsgGUID: o7xqovasR/yC6BJmmzmx0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32577940"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="32577940"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 19:16:40 -0700
X-CSE-ConnectionGUID: eP8b0qypQaeHsASYfpVCIA==
X-CSE-MsgGUID: LFIJKF8kS+WxoqOzrqRbdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="80299251"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Aug 2024 19:16:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 7 Aug 2024 19:16:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 7 Aug 2024 19:16:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 19:16:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qz/uT/8qEiqUqva8DgqCTyEfe351eAUFs4dlsMegIcXNpQTs3hwQwrGoIm+xfqxhfB2GJ8asqxkalGUy3Et//Id0pF8ZRbNNqZHQEvx707Vzaf++7RY52tMnVv8HNqbD8IB+ieCCEUliXwP7/JZTuyIi83CYsij2NEAtn2c/QI1AVGxAjn9Ussbz3OgIOfQL4iZsek/2Z5WCE936p8KUx5A4OKR/6fU7/ubcUAa9Tr6rAkkmu812qVuQSE88IH8rRUAExVxQ3t7Rc5UQ03zcvS07z0kZIkvoRfPEjRFvRwOe1H/qsgOaz0o16HYd5liUB7xsxV6fHd1E9+8ceD9xsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A645vquDFojjj+fLG+bibXFdvZMaIukOmxxy9WYXTWg=;
 b=aq/mwL5Gaogwizhfok5hyXdRBpb9/k4RF6OTihx8xKIC4te1+6JpJQLmL2z8lX3aqAR2gMui7qM/pxl3lJ/JkzmIsH27fQ4TQDzZjE8OnaerZ2iiHJLks8GugYdILVAXLAtGbBYyGuZg6zUSUwHATXmZy+rkpLyNDJENCJEg9N4cetBI+CXSqvcapSzLW7hq9r+NPsm2vuJRVG3QlmYukl+f+YvtmrztKPvcl0SEBgL+/i+72iGIt9fin1JktqGbQkKtMFg58eYBJ+g4MYlKuwJwas1CBPwiX8Y5Q8re0BpZRJ1/Qk7OLvWZAWKViXwzemMBHig+giHMAo3oy+0ciQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15)
 by SA0PR11MB4621.namprd11.prod.outlook.com (2603:10b6:806:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 8 Aug
 2024 02:16:35 +0000
Received: from CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3]) by CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3%5]) with mapi id 15.20.7828.024; Thu, 8 Aug 2024
 02:16:35 +0000
From: "Rout, ChandanX" <chandanx.rout@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Drewek, Wojciech" <wojciech.drewek@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, "Kubiak,
 Michal" <michal.kubiak@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Nambiar, Amritha" <amritha.nambiar@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, Jakub Kicinski
	<kuba@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "Kuruvinakunnel, George"
	<george.kuruvinakunnel@intel.com>, "Pandey, Atul" <atul.pandey@intel.com>,
	"Nagraj, Shravan" <shravan.nagraj@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2 2/6] ice: protect XDP
 configuration with a mutex
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 2/6] ice: protect XDP
 configuration with a mutex
Thread-Index: AQHa3erT3sVEOoMbP0K1EnGOC6zDcrIctd5A
Date: Thu, 8 Aug 2024 02:16:35 +0000
Message-ID: <CH3PR11MB83130BDD035505D436CBA050EAB92@CH3PR11MB8313.namprd11.prod.outlook.com>
References: <20240724164840.2536605-1-larysa.zaremba@intel.com>
 <20240724164840.2536605-3-larysa.zaremba@intel.com>
In-Reply-To: <20240724164840.2536605-3-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8313:EE_|SA0PR11MB4621:EE_
x-ms-office365-filtering-correlation-id: ed1d3b7a-d590-461f-78f4-08dcb75020df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?T7Byu1sYXo6eTvTt4h1zB/0FFjZrxDbA0+2sr6O0WonJ0YJqIsS7KE6kXlua?=
 =?us-ascii?Q?lVCsu9Dfxgnl3iCJ7RXCGFCagP4aZxwvjp2k44WLjnOvqBzG+Jeg59+7xZzM?=
 =?us-ascii?Q?sMel+QuCdECwKqDp9pGo2QdtyUUHaMsbike3/VJldrwIGJODvZajEUV0hFfD?=
 =?us-ascii?Q?8yXTU6UNX/S1QuAQQC7TRdyQ4MP40MBC1sngab+mUwy12g0nqniw4ae3Ir1J?=
 =?us-ascii?Q?B+znZWPo8CkGiUyBsU0vT0c/w9SnSCIlvLFEIhfp/piTgZ+ar7idK4G/9C/f?=
 =?us-ascii?Q?1SxGvqxhLNd7bzHAPbdcv0x0QWrm9dGtQ6qvD6H1pIymcAOyYy8Wh5V6D6zj?=
 =?us-ascii?Q?ckQUlHNLCfneIcC6Xlvc4LFX2ZtW1fVHwgB73qN9LQQJCrMUyQ18NEYBsc2j?=
 =?us-ascii?Q?1KCyKV1WzUlwLZ7rUprYmkKl97s48V08DVZGv89J0UIq9tQoOaqnE/Iv+ohU?=
 =?us-ascii?Q?c+VfV+rt+ANoasBkWSkwAt2Oykk5jxQymXbkDWaaeQR6XvvTpwDxk7vyLcPB?=
 =?us-ascii?Q?dxO5cvbNx2UEEtY7dzWSBpoxGKsEWSROIBcqzVBxD0VunsGpH12IxKu55lA8?=
 =?us-ascii?Q?V0Idzjy6oq0lMbi84CksHfX59ttc87SuR/TXxac7WZW9z3+nFvqpsr4EolMo?=
 =?us-ascii?Q?Lq9aC56uXH8S334bS6jmKJmrc7/BdoWH/eiySmTc0c7WMlyep2obyN54SEVh?=
 =?us-ascii?Q?I8NV459yuPvzl4ncfhdoTJOINUy5UEE8S8pAiqsZ7EiqijmLSpMJ1s8NJGov?=
 =?us-ascii?Q?4OLmxEcqeUTvOahz6IPVsB9GZM4ZQd/H0VH7kbj85QZeWdkvYwfr5/2ibmdk?=
 =?us-ascii?Q?dTPkEEwR1h/1XhKbrvmdmASHi/8GYY7qGsgp1PaYHLYYt+pFpn9qb+KWg9me?=
 =?us-ascii?Q?h5nXlV647dk6FZgHOr+zipxFTNBysEy0QAU/iUMaxmDXpLQOMXOF13Sv6ELp?=
 =?us-ascii?Q?cMmvUA/AYKD4r7QS211kxQYaJAqMBZFCrc/ZLmE2aP0PGahmp3YDC9c39cB3?=
 =?us-ascii?Q?DRFGHMtWlF1lQGdzYgH9R+zdOFD3KZohc93jU5i06W1z1Y8XTJg6r7uKylL9?=
 =?us-ascii?Q?CUOkTzYUXjgjNtlhA0L0i4Eo4Yl5s9TbGT2IyS0Uhro5vp5dYfmVAdjCAHVa?=
 =?us-ascii?Q?iYhtxOFgAjXFygWwLu8OK0kFd5I24GYtAdLqYWIhYL9vvaG2XYV2Yhoumiya?=
 =?us-ascii?Q?ESW/L60uxEno+WNKWWs0dCBci0/2fo2zkIdtyJELwA56uk3+WZUdDNf6KKyW?=
 =?us-ascii?Q?v9jCm5bUL9stnE/HurXpzHilPJ/BWdzG/Dh9CGLEZjeJkQbM/KX7tlrun8Fp?=
 =?us-ascii?Q?/s5q6TJgYiziU0c+64RoNpmph9ROyLgAVkOgt6n2OVIjIpiHEtQ560d0IrBv?=
 =?us-ascii?Q?XpaDYj1sGKB93yWVNsWuiYmatl5iDSBLJT2I2BS7/VPHRo4Hxw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8313.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uvIbSLAuzIuPFy3W5FzEAa7NUHzBJns2dL1n+gOpioO1+DU3OjmaWl8ixITG?=
 =?us-ascii?Q?z3ZPrqO9uVDzCWh1eWAxA8lxxK5cPC/ceWlGBWLjtRVEx9Dkbbo4IBHGoDfY?=
 =?us-ascii?Q?6XYTlLMO/W9SFuF3e8dqH/Db3b0PJ25qUPR5T2Cx87J04xu99b/yPjOMZuic?=
 =?us-ascii?Q?JBujgZGgKg9PgoKECcFm3KCzs0zHASDG0wMKJr1QG446Dkkg+rZ4Rzr23TdP?=
 =?us-ascii?Q?x7eadL2mMNgnjppZDdANQUr+9ZyCLVaHu163t4uGj9k19s3Q84xA3aKRyijV?=
 =?us-ascii?Q?eMcDbfFuEcqBpL/5YDxvb5LPIB7FwEim3sW5RoPgAZui7zCpzgXj8sr8OPYh?=
 =?us-ascii?Q?ZcESZ2E7AJ3jIyOBlzjW6t+6cYuGDkPyb2udeCO2dnamxOiSnGjUiDiY9qNN?=
 =?us-ascii?Q?OnCdmfZMklSPnNAJB3ZUDsyavKfq57O4eQcgG/Ee6+QAGzoFp5qxrynE92Tz?=
 =?us-ascii?Q?ND9+Bb1yMNYypyzDodRJwfy8GogfFEZhY2+DejRbcoqT9pXgZdnj1AKdmCYh?=
 =?us-ascii?Q?9LhkSp/n8EjyVGdj7cELlgNE97n5LV/d45pGOfdnhck4+Ub2WriaaLcgYa8s?=
 =?us-ascii?Q?+Dw1PEbXw1szm7bt0V8QRj7LXrZoqBEnAKkI6QLAYIMb6YjtFl9k00VBsPKe?=
 =?us-ascii?Q?/pSPavNDwEnnUDahJO66XnZQiS7xIWF4CLnBQ5fe4vgDiNzBmgvrH/vE98TH?=
 =?us-ascii?Q?39u1eioakDy3AxZ6oyf7JicKQI/uzmtPMoGX0Fo/KumewDGGIaLUVRENZ9uL?=
 =?us-ascii?Q?4CIrRM1Zs8c/DuETY4IuI+yBLY+OJ9ojDacUguIxogF9TBFMVzaw1U/j5kls?=
 =?us-ascii?Q?pzTzRB8Ps8rEZEKQEBPw0KH4M59OVFZ5TR+xB0f0AGHFpTJMRH9Je+c56GaE?=
 =?us-ascii?Q?cBJdUEap4VQO2h76Hu7hbeZkYeS6ysIkOx7SJHU4EJ4hDEJP6TY2/6zh42lx?=
 =?us-ascii?Q?tgP7a2NZUc33Rju1nB38S4jaDZ41yVpf+cCADUerz8O4z0rpxUT5Hcj2/mGl?=
 =?us-ascii?Q?sFpeD83GVmFhv7t7COY9GuR0hM2OhDlZQcYarQg9rD6qz7PSHxodyRuoU9qo?=
 =?us-ascii?Q?m+jSVm3qtwm5DCTf106qsW1/+BkSX7fl1iHbKYIoSIs+jC/ZieRqNgqPHOYj?=
 =?us-ascii?Q?qrz1//Gp4JctucxDKXiagsf05m44z2O8Yix/XgYl57NVEx/Cvwgg5ZxKRc7p?=
 =?us-ascii?Q?wWQvVeD45OgC67vRD362m5vDvl2y0yu5YGvWZzFGOgpep8x+MTuq0ZFjJdUq?=
 =?us-ascii?Q?B1h0E95IuzcLbfIib8RWlyp5wFftcJJHnff4o3tva7FUwfn3rlpjnsmHNCJ5?=
 =?us-ascii?Q?ZVNAgsz3GjS+XTnd0qXcOT/HVnexm83q5GGxk6edn54LbpoI6ZGOx5xS7Gkl?=
 =?us-ascii?Q?nPtXO8arjSu/4dct700j03uA0yFFYK+ad4sDGupsPyOVdFbOfGbJtvd/MXOC?=
 =?us-ascii?Q?U5iaX7laQoBEW2wqFWU+cnfbd/gygnzJiTkQz3LWnUja4wNZJiihEwOI/YOV?=
 =?us-ascii?Q?szMNB2yHrVPhQLCjqerItDZAmYRQBti1g9hucmD6ohlYp5c24xMZe2ewMu3f?=
 =?us-ascii?Q?rcUR2JCjwplI5/HpxjqylFxoqMRz5EwbAxsywlnh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1d3b7a-d590-461f-78f4-08dcb75020df
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 02:16:35.6064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xWL3FeNgONr/v+2wlltZDWbGH47XjuwDI7QxmDTrgoZkdoZXFi8aP5CNdFBedNQJ38rkm0m+a7z7AAqJun8vAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4621
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Zaremba, Larysa
>Sent: Wednesday, July 24, 2024 10:19 PM
>To: intel-wired-lan@lists.osuosl.org
>Cc: Drewek, Wojciech <wojciech.drewek@intel.com>; Fijalkowski, Maciej
><maciej.fijalkowski@intel.com>; Jesper Dangaard Brouer <hawk@kernel.org>;
>Daniel Borkmann <daniel@iogearbox.net>; Zaremba, Larysa
><larysa.zaremba@intel.com>; netdev@vger.kernel.org; John Fastabend
><john.fastabend@gmail.com>; Alexei Starovoitov <ast@kernel.org>; linux-
>kernel@vger.kernel.org; Eric Dumazet <edumazet@google.com>; Kubiak,
>Michal <michal.kubiak@intel.com>; Nguyen, Anthony L
><anthony.l.nguyen@intel.com>; Nambiar, Amritha
><amritha.nambiar@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
>Jakub Kicinski <kuba@kernel.org>; bpf@vger.kernel.org; Paolo Abeni
><pabeni@redhat.com>; David S. Miller <davem@davemloft.net>; Karlsson,
>Magnus <magnus.karlsson@intel.com>
>Subject: [Intel-wired-lan] [PATCH iwl-net v2 2/6] ice: protect XDP configu=
ration
>with a mutex
>
>The main threat to data consistency in ice_xdp() is a possible asynchronou=
s PF
>reset. It can be triggered by a user or by TX timeout handler.
>
>XDP setup and PF reset code access the same resources in the following
>sections:
>* ice_vsi_close() in ice_prepare_for_reset() - already rtnl-locked
>* ice_vsi_rebuild() for the PF VSI - not protected
>* ice_vsi_open() - already rtnl-locked
>
>With an unfortunate timing, such accesses can result in a crash such as th=
e one
>below:
>
>[ +1.999878] ice 0000:b1:00.0: Registered XDP mem model
>MEM_TYPE_XSK_BUFF_POOL on Rx ring 14 [ +2.002992] ice 0000:b1:00.0:
>Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring 18
>[Mar15 18:17] ice 0000:b1:00.0 ens801f0np0: NETDEV WATCHDOG: CPU: 38:
>transmit queue 14 timed out 80692736 ms [ +0.000093] ice 0000:b1:00.0
>ens801f0np0: tx_timeout: VSI_num: 6, Q 14, NTC: 0x0, HW_HEAD: 0x0, NTU:
>0x0, INT: 0x4000001 [ +0.000012] ice 0000:b1:00.0 ens801f0np0: tx_timeout
>recovery level 1, txqueue 14 [ +0.394718] ice 0000:b1:00.0: PTP reset
>successful [ +0.006184] BUG: kernel NULL pointer dereference, address:
>0000000000000098 [ +0.000045] #PF: supervisor read access in kernel mode [
>+0.000023] #PF: error_code(0x0000) - not-present page [ +0.000023] PGD 0
>P4D 0 [ +0.000018] Oops: 0000 [#1] PREEMPT SMP NOPTI [ +0.000023] CPU:
>38 PID: 7540 Comm: kworker/38:1 Not tainted 6.8.0-rc7 #1 [ +0.000031]
>Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS
>SE5C620.86B.02.01.0014.082620210524 08/26/2021 [ +0.000036]
>Workqueue: ice ice_service_task [ice] [ +0.000183] RIP:
>0010:ice_clean_tx_ring+0xa/0xd0 [ice] [...] [ +0.000013] Call Trace:
>[ +0.000016] <TASK>
>[ +0.000014] ? __die+0x1f/0x70
>[ +0.000029] ? page_fault_oops+0x171/0x4f0 [ +0.000029] ?
>schedule+0x3b/0xd0 [ +0.000027] ? exc_page_fault+0x7b/0x180 [ +0.000022]
>? asm_exc_page_fault+0x22/0x30 [ +0.000031] ? ice_clean_tx_ring+0xa/0xd0
>[ice] [ +0.000194] ice_free_tx_ring+0xe/0x60 [ice] [ +0.000186]
>ice_destroy_xdp_rings+0x157/0x310 [ice] [ +0.000151]
>ice_vsi_decfg+0x53/0xe0 [ice] [ +0.000180] ice_vsi_rebuild+0x239/0x540 [ic=
e]
>[ +0.000186] ice_vsi_rebuild_by_type+0x76/0x180 [ice] [ +0.000145]
>ice_rebuild+0x18c/0x840 [ice] [ +0.000145] ? delay_tsc+0x4a/0xc0 [
>+0.000022] ? delay_tsc+0x92/0xc0 [ +0.000020] ice_do_reset+0x140/0x180
>[ice] [ +0.000886] ice_service_task+0x404/0x1030 [ice] [ +0.000824]
>process_one_work+0x171/0x340 [ +0.000685] worker_thread+0x277/0x3a0 [
>+0.000675] ? preempt_count_add+0x6a/0xa0 [ +0.000677] ?
>_raw_spin_lock_irqsave+0x23/0x50 [ +0.000679] ?
>__pfx_worker_thread+0x10/0x10 [ +0.000653] kthread+0xf0/0x120 [
>+0.000635] ? __pfx_kthread+0x10/0x10 [ +0.000616]
>ret_from_fork+0x2d/0x50 [ +0.000612] ? __pfx_kthread+0x10/0x10 [
>+0.000604] ret_from_fork_asm+0x1b/0x30 [ +0.000604] </TASK>
>
>The previous way of handling this through returning -EBUSY is not viable,
>particularly when destroying AF_XDP socket, because the kernel proceeds wi=
th
>removal anyway.
>
>There is plenty of code between those calls and there is no need to create=
 a
>large critical section that covers all of them, same as there is no need t=
o protect
>ice_vsi_rebuild() with rtnl_lock().
>
>Add xdp_state_lock mutex to protect ice_vsi_rebuild() and ice_xdp().
>
>Leaving unprotected sections in between would result in two states that ha=
ve
>to be considered:
>1. when the VSI is closed, but not yet rebuild 2. when VSI is already rebu=
ild, but
>not yet open
>
>The latter case is actually already handled through !netif_running() case,=
 we
>just need to adjust flag checking a little. The former one is not as trivi=
al, because
>between ice_vsi_close() and ice_vsi_rebuild(), a lot of hardware interacti=
on
>happens, this can make adding/deleting rings exit with an error. Luckily, =
VSI
>rebuild is pending and can apply new configuration for us in a managed fas=
hion.
>
>Therefore, add an additional VSI state flag ICE_VSI_REBUILD_PENDING to
>indicate that ice_xdp() can just hot-swap the program.
>
>Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
>Fixes: efc2214b6047 ("ice: Add support for XDP")
>Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice.h      |  2 ++
> drivers/net/ethernet/intel/ice/ice_lib.c  | 26 +++++++++++++++--------
>drivers/net/ethernet/intel/ice/ice_main.c | 19 ++++++++++++-----
>drivers/net/ethernet/intel/ice/ice_xsk.c  |  3 ++-
> 4 files changed, 35 insertions(+), 15 deletions(-)
>

Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worke=
r at Intel)


