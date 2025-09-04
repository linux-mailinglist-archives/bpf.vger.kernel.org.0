Return-Path: <bpf+bounces-67462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609ADB4428E
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DB73B4B6D
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 16:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1F8224B04;
	Thu,  4 Sep 2025 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwHSkGwi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19EA1F17E8;
	Thu,  4 Sep 2025 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002815; cv=fail; b=JDWQPx2tO1RWaXgIC7L5Yvy1AKcA3DSiiKC3ZO87iM5VkBiNgHuzLLnyHXgza9rNuRAHf3GYUCB1aunmLwA6Iww40zc1fahqsLZzLYw1AcgOBeECOqHqqW0q7kQW8XVtKTPAOPfukTBCZW7XCI6wdhXES2UN22E+nf0YtdaEvW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002815; c=relaxed/simple;
	bh=EkuBVate4u4jrbgK4WNWU57y0ZriciPzWBd0Uesqs4s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h7klijlnHpYeY8iO8+S3rSrjYoHCP5pXwmyTcCDXbxkXngDFMlIgpMArfWWHYvZVpkdaTjFQITFOMbxj+awhTEMDF9ybC9HYqBq/4gyI86fo2oK9UleWG+OhOQdkno9HNUrGjZxCdr1J1prY+xeT9b8qo7TAkLIsOFLqax55vNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwHSkGwi; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757002813; x=1788538813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EkuBVate4u4jrbgK4WNWU57y0ZriciPzWBd0Uesqs4s=;
  b=CwHSkGwiGdeNkgEshqAh/qg80CPC/gI+y0xThCF0XEe4npF/Xo+n9ptZ
   zYA3QIxzDJFsDdlOlOj8OUlvwifFZJD2kcYewNvsQCUx0lmNUGgD+z+bk
   HpKSlbQyZ0Zutdg8HjEDKOzHVL/1A3X3vGIKqZL8iEabc70ER+qRYyPYj
   nF9uomJYHyLEI0GHg8AAcCH/+Xn7Ez+q+6UFjmeejx3dWrLbmtsROreQH
   4KICOzajm9Gljn+VPWcJrsMhgQAVyPI3NXQt4sSrf5Rz0AjXnK4/b/bIr
   fK1UZsKrJeWmFbZuFd1tPt9z++r9syJF6zpWz2vCiLZh6k0noi9KC85z0
   A==;
X-CSE-ConnectionGUID: 0vdAhvRiRGKN257T380znw==
X-CSE-MsgGUID: dzgkFv2OQXqeGpD6T/jNeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="70725996"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="70725996"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:20:12 -0700
X-CSE-ConnectionGUID: qyCCV0lJSbeCqdkkEKPn9Q==
X-CSE-MsgGUID: GM+RWJXJRzOxUwLMjU1N+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="177159160"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:20:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:20:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 09:20:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.49)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:20:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ak24tnKBYyilBVdyKRhDQAjdvEQJOB5/NxYpB7PLDbr6AWP4I0Smh6MJ2OxZ5RBVOHobIN+vHIWu8ZcYCdT3sI9oeRpTBwf6xK0zJIQTEcaRs5KFEjQdG1FzrYRttMzx26wh+DcjupMbO0COd5N/T/yliUkIDANSvXrTzSxvwbDncn/DeVigTWc7JBgOL8DJCzfV1xf6IqVC+J6tItF5QaU1Gvw6MhuFArZkoReskkRWY/ryTBzQXFmc+scVQI+Ykm5SnWB3/eEyfw5wgZRdVarO7dYUg6UfSYYEvxy5ueWu1uGatdjqANSX78fUAOqdr1sp0xv386sN3wPVSKs8hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0IRA1m1k2r9LeyTQU9KX2UFkj5+aJEFlxEa7xJ0qHw=;
 b=IhSwRrtQrVcKWf2D5MgXyjQLAW+IfdZ416Xf7wgqz+4eIaAeGpo51Uj9YW3y9vjfEtTnyroQVJ6ljaaqCt1q7xbYkOwtXMlYFKoHV2H5mr/aqCYdtPSHELerCizMdNIp9q9WK3HV7U+ZoC6pqzm/mb9DoAG3ITok33Wp1++miIwKkHBZY4+Ir9WTSMKZTb85asPYHiGtEeZz6h7ZI1d44c2rtM0tzp8ZzInlwh7TZoUe+BDDmOwCKVXPdvXmCUFlnJxzanCV1GKaue9+PboT84S/EoCgnSjyXEKa+jGu24vDo9VsDX5gyi5/Es+wuT/jGLk2TWgwRU+nJKByb0Llww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) by
 PH0PR11MB5046.namprd11.prod.outlook.com (2603:10b6:510:3b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Thu, 4 Sep 2025 16:20:07 +0000
Received: from DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425]) by DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425%6]) with mapi id 15.20.9009.013; Thu, 4 Sep 2025
 16:20:07 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 11/13] idpf: add support for
 XDP on Rx
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 11/13] idpf: add support
 for XDP on Rx
Thread-Index: AQHcFqWG56OfQItKFEi8SaipCJxm17SDM2QggAAOGkA=
Date: Thu, 4 Sep 2025 16:20:07 +0000
Message-ID: <DM4PR11MB6455AF2B4F45AF33B52DAE509800A@DM4PR11MB6455.namprd11.prod.outlook.com>
References: <20250826155507.2138401-1-aleksander.lobakin@intel.com>
 <20250826155507.2138401-12-aleksander.lobakin@intel.com>
 <PH0PR11MB5013E983FC06BF5A751C1F4D9600A@PH0PR11MB5013.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5013E983FC06BF5A751C1F4D9600A@PH0PR11MB5013.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6455:EE_|PH0PR11MB5046:EE_
x-ms-office365-filtering-correlation-id: 703c248b-da93-42d1-98ad-08ddebcee9b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?gUsbCjcWMkQSh6eoy+iSsHbiojsPCikgtGL45SP5uSX+vHArfm3bwUkIaARR?=
 =?us-ascii?Q?4e3XeNA2fGluUnUBD+nSFl+RlWXWYcbh1q7WJwyDXx/4jQvloaYe0Be8PLLW?=
 =?us-ascii?Q?gUWeQX93Oh92BsSEiwT2zlQ+XPNckK1rhNi5Wq2Ry35v6HuLZLJUwMTuZQXb?=
 =?us-ascii?Q?Jb7HKehT+ZSpRyVxYRfUYvbXZXbrtuzM3K9dVlKjFk9NapkJSd1oeIzo+rpO?=
 =?us-ascii?Q?zVsApz9CS1sUZgTyT2lEgnRPs/S23BVb5UVgyAWWH6WsDoYmdi9yB7n+j+z2?=
 =?us-ascii?Q?yrz2DuKdExsORYCuOs/tV2Pw57yibPOzj4vqmczswgoQPtLtleKscP3w0oLA?=
 =?us-ascii?Q?nrmCIR2ie2tjRF/g+cU2ME83+R3IsEhnApvfZUQfYl9UYHK7sS4N0kuB2vBl?=
 =?us-ascii?Q?/apRg8biKSJ5BgbENqI6Nmg4wYHS6GTsEnO5EnMD4gLShmzw8zsAYX24vvl1?=
 =?us-ascii?Q?dEW87opDrtrGgYgJFTESox3JjB+rqAhzgQJ0olmAsJxINUWCyh+px+u/O5yG?=
 =?us-ascii?Q?N2JPqMzfUX7sZrluG0s9mZpBoeVk6CgRc31Vbsvca9UXBp7JY2OsQ1N9/DIK?=
 =?us-ascii?Q?3H+UnB51MTVTW9zFNtPCc77gMzv0P6rnvDewXUf3iJN5UFck0sSOzVXRqONP?=
 =?us-ascii?Q?fGVkgzrtGyrbHAHdLlThUPA+ekaoTNYtvCURTFVekizBKxMy+lWEXoCI7/te?=
 =?us-ascii?Q?Sy58XU8UAKiocy643xC67nCkPLzHi1fV54fnqQ2X8giHxwYBZzU5R805Gufr?=
 =?us-ascii?Q?8gvL8V+t1oMIb2qrRJTBd2GCfgQV6fehie7NvxgZeYQvuP/dPTObBiTMqYuf?=
 =?us-ascii?Q?QV46YWwPLA8UQXhkdxVkrUEwrx9eh6y0fHjbjZfmOwAbxP+HjA75LYyiwJr5?=
 =?us-ascii?Q?0sG4XBaUxZuLNc3KGdg5Vmn9om7uIpu5x2YXkYaXyZbjpmY+PE2sffwmZE/s?=
 =?us-ascii?Q?CMBfiixdhNACv53zChu9dWo6bS5Vc6XhCC9vig6DSsvl2F6kFGmPWrPsD3V4?=
 =?us-ascii?Q?LX1uju34yijLo4RUEiMcz+Zn86zyZmbYPFSHolwReW9lLToJLv+mxaV0/nMi?=
 =?us-ascii?Q?ecQn9+BtonmtiCmjkAu+KjGrK207UNogoxBu0WdsH+wI7hKuR23aJLqrnazd?=
 =?us-ascii?Q?462K/0zO4MM0CatI3B1a9AE5if4ku2AZ5Z9WbRDp0Xq0Dxo1w64mDd5Dyqnc?=
 =?us-ascii?Q?8O5chwgejfvUgoGYn4N+ycN9fbIvk+UY+YTSvqLMa+eGwxeib8I39YPNJr61?=
 =?us-ascii?Q?IDJXGob/WsXEEDt3a/BJVOipk8TDQ3SBwx+MBu5xvW2peYq3qVreOUjSdD4X?=
 =?us-ascii?Q?GlyMFSRDhMaXBNNf/ZOxfHFXuI66e2QSk2bzyFv2jIHJrjfbcIUyvjP8C6La?=
 =?us-ascii?Q?U1v2judQpG0dti3GljXV9kY61eDIJO+9Dl8AHlllePOrOo/N1k0BNYdWbjQu?=
 =?us-ascii?Q?jPnrFuP0UkwRvSKWK7VigP48POh9dq6S3UzCyLthiIdZLLrdWhMXnw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4kye12WzRTFAVV2vvjpdUBS+NHtOo45+fmnv3bNiRBrARDLnN7mzP/uSx4bI?=
 =?us-ascii?Q?gSU0Uy6V2g4hlo2v9Q70enU+MnYXX2uIWE/efCwI8M3R66ZPooSmGYRJomPh?=
 =?us-ascii?Q?S7PQ3FN9sdqg8q02CTGzOhAI/rmL7GOD80Ag9ajJyroooGyHfZnlfeAbn4NH?=
 =?us-ascii?Q?R5akiPd1ZJTqYSLNxfLZ1fF+JOoOQWI4moXrSH4Mx0Wp74Jh8u+EC4ouiSKD?=
 =?us-ascii?Q?/8Zt2JwDrlhy9P/vMSJR/0nwxT05BlJ72UM1We9a59FJNwwMOkxwUifxO0FX?=
 =?us-ascii?Q?kXLIjxrhK4NKU0wZdUJQa4XhPQiDLZHj9nUMSF7qeSC7v17wvxllWWiC78gM?=
 =?us-ascii?Q?IHnNuTVJbjUBCyrKsg3+zABjd5lMyNdHmhWjS+NAGaGRUMEFLJfBMFaL5d8w?=
 =?us-ascii?Q?pKnjl8/8TjpuDKoj1Xhl+aw88G55rJ3aqCVzVOQHXhJd6sv6h7oSvdVcdILS?=
 =?us-ascii?Q?QHaS1Z8wuxLJwmeC3x7ORHZVKrpy4TmusRPpKyn6uPemcBFF6nG61+D5UbCs?=
 =?us-ascii?Q?ESMzL+mgOtsYv/GKYNqWKmQ6g4uSFk4OqNcqhqk3GIcXMMkxHDn69isyGRsP?=
 =?us-ascii?Q?g487eJhe/dVCFqoDSxWBRSM1F1ELj70Zirk+Rq25n9fXoOIytr2Z83KLXVXX?=
 =?us-ascii?Q?WlpiibxEqo+g5VYDW6mIrE2N7XftDNfAArtptDkul6M9CrOVrYQWHip9vYKH?=
 =?us-ascii?Q?5NkIj2S0G8V385/1soginmqw+hrcJ6Lw8RbWxEx4MFY8h1pU0Uz2YGrvaN2l?=
 =?us-ascii?Q?7USz6UqOkrJgtehFKR+wQxu56LUIBr8+1CY1XF2nV/cphxzDuPgR4Bacfuq4?=
 =?us-ascii?Q?86FhRm7sG+ECgLnK03bCiQBq2LNX0saaWegECJLJagKR/RK/cyrjkcRkGfrL?=
 =?us-ascii?Q?fO1YMXZSk91/pV4/A4bs8iX9+qrnywkC8+CNVd8YaUTSHunIjntn91ynrLq/?=
 =?us-ascii?Q?XvcrB6ffvj1mDS+e1y4E32y1LUdT7TFYa96URqWPR8CdqCzbdFSk1nsbOjfs?=
 =?us-ascii?Q?Fu0hGxxJt0TxJgvvYAsARYUxFKGhvb8BYHLWlVs5C8UZcmHUdrrZ3B+tdXCf?=
 =?us-ascii?Q?HSlH6IFZprHfWM/iyq9Y9alM0HB7qqdcdCBprSrkYhwmi6ZkM2w2q9+j+qGb?=
 =?us-ascii?Q?ZW5PCXNboXMUzaC+0xeDf0nTiLR2U2RySokzSfCdz5QXNEyuarLM7vz2LdWz?=
 =?us-ascii?Q?GekMpXpyK631HyS2vixun8+WZHFTNwx41qoUI/aITNlcxmHFqGOiqHnnK9zd?=
 =?us-ascii?Q?iPWzIexvajLuuc3G/t4rHp+DhijgO3kVVYThAxxXZPNnRnYg8tesyojlAiLd?=
 =?us-ascii?Q?9xTVd394t0BpIjkreAkgp4kzuSNGs89jHVzLonqewncUa54pgqZ2HVShyPuA?=
 =?us-ascii?Q?aD4TYG3z39Q6JCBOLO52R0F25HLWA5X2Rneri+jZQrdqd/c29spSF12NLbjf?=
 =?us-ascii?Q?spGiIDepNKsvrPQsnsJLD1TCATBIO+leRaGbf6rWAefOO2wZKRoVKQktzm9u?=
 =?us-ascii?Q?K75pd1KbkU+FKx5dlVEwZvd6scUdlKNPdpydrxKEp8Feq5A4/Afo5F/VWNqW?=
 =?us-ascii?Q?GbX64cWb6rTgEHvTaus=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 703c248b-da93-42d1-98ad-08ddebcee9b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 16:20:07.2460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mCVrHjSfuE8NmePHu3dn+exepo/3aP2JP3KSsO2Tb0K6dTuynCHIommjjxK5UhGqx608enrfmyCv86SW5x3Q8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5046
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
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 11/13] idpf: add support fo=
r XDP
> on Rx
>=20
> Use libeth XDP infra to support running XDP program on Rx polling.
> This includes all of the possible verdicts/actions.
> XDP Tx queues are cleaned only in "lazy" mode when there are less than
> 1/4 free descriptors left on the ring. libeth helper macros to define dri=
ver-
> specific XDP functions make sure the compiler could uninline them when
> needed.
>=20
> Use __LIBETH_WORD_ACCESS to parse descriptors more efficiently when
> applicable. It really gives some good boosts and code size reduction on
> x86_64:
>=20
> XDP only: add/remove: 0/0 grow/shrink: 3/3 up/down: 5/-59 (-54) with XSk:
> add/remove: 0/0 grow/shrink: 5/6 up/down: 23/-124 (-101)
>=20
> with the most demanding workloads like XSk xmit differing in up to 5-8%.
>=20
> Co-developed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h |   4 +-
>  drivers/net/ethernet/intel/idpf/xdp.h       |  92 +++++++++++-
>  drivers/net/ethernet/intel/idpf/idpf_lib.c  |   2 +
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c |  23 +--
>  drivers/net/ethernet/intel/idpf/xdp.c       | 147 +++++++++++++++++++-
>  5 files changed, 248 insertions(+), 20 deletions(-)
>=20
Tested-by: R,Ramu <ramu.r@intel.com>

