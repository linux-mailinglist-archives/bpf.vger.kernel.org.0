Return-Path: <bpf+bounces-71865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D25D2BFF4E2
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 08:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635B63A620D
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 06:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552C9279324;
	Thu, 23 Oct 2025 06:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bybPLchg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5634227FD49;
	Thu, 23 Oct 2025 06:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199914; cv=fail; b=kpRThna4BcQUTmWc9+G9ak7Jju5QfRtYwxLcAEJv5ZdPj690dZuh3NxFNKM0rwApTaonyh62NFKyHSE1RMsF5HqEDQUxNnMMOKDI0gk1N5TcMKoaVw94rvRgngf4+OoOjkc21dMlO8RHHTh2NGePavBVT+T/RyR6KCZ/5v3EPxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199914; c=relaxed/simple;
	bh=zF/1AfaH5yWtK91o1aSNbqnBlB3PR+XMyJ5B36zrIl8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fNbmReTzOqwOZn5CpajrVllhqO0jZWqF/XLqaeRZs8viTke9DrLansN8KAt/auEA8f7fk6WHHyPqG9S4XTXcGizjvLoNnuWAEPlqIy2kMp7zSc3um9AVguf0HNL/HpW3fE9drDDStIUJFumvZqQ9CJcbZh4wx8AhAI+ZjA43fPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bybPLchg; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761199914; x=1792735914;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zF/1AfaH5yWtK91o1aSNbqnBlB3PR+XMyJ5B36zrIl8=;
  b=bybPLchgSoKqj/roHS9qlQ1VDHpAQbybZ+PB/BWnr6wY06SO8uib2ASo
   gxrJlpN7iphKl2ffG6r8kcZRl6G1z/p/tRsazDQyEyvygt46zQQnTFZ3l
   U6vpjG64RWshhDjD2kcV/UHCbHk8SvkSWem62BmuYGXdB3sJkvn19q6mt
   5EgedS4G2QLEXhZNkO1UNgFaXlrJlREF9JNlwGO8nvJxJXexipU9LwkCF
   1hifg/cpQfIxD3oTvVlPIOFBDnZC4F/pBcKzEJM/moRH3mYujirgAnf59
   z2+3JhjsKjJ+K1Wn9+WBWsS5ZQa3RUzeLOUMlqUf181zDBIAAdzJ96Mzi
   w==;
X-CSE-ConnectionGUID: cMK0W1LBTAO8MkCr7MUbxw==
X-CSE-MsgGUID: llaH3OP+QLSxFvO1z4S6ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63398894"
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="63398894"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 23:11:53 -0700
X-CSE-ConnectionGUID: iRXINAL4TSyuQ1UHe4Xkvw==
X-CSE-MsgGUID: N9fY/ETdTeGqc2EPtbpEww==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 23:11:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 23:11:51 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 23:11:51 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.25) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 23:11:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXHnEiKw2bp4xLdaCnUisR++Cxo7j+o2sE8e/97++XpocQO41+5KVyjsGfTq/F2QQHVvnfh86iJEaQrXFtVVUWpiXVpcPwS3MYJUe5BzF5PBQlBp5cHQPhFARLTuI83Ek2W6AHlQZe07YyLbJIWqJ3cGWAWbHCWCXLBvYIGhsQ4YwntZfUdpAPxi1NMatwk/81KCGmgtyEhJjdYSxs6/bF75rUUEyi/orru+3rMxVj5gWZz11zSgZTILxVFha8/cWDEnI1JbWEYNDRUggatffIwvSnMOiQ1+PndFD0OWevgS9Rj7DeJesXGwooZ2XvVUtVfctAz6ZncqQBsPChpHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q89LMnZpegaGEdaD20s9FdjwKFXrLbvMK1Mw2yRsa1U=;
 b=AovYpK9Gt07Mrtov9whrf9mjcPLuneNQ/1gZ61MzxEakwnssT2QEn3Y2y8BsRSvDNwzRgr/sZSH+jM9asZKr84kCIzYmRlG3680CUJpQET6RwgpNtppvba5xZNv3lsm9tTCoM7cj28NQaXHgMBsxq2kTbUv18yefRcoV7ZEqydubQbgJiFY87PReISCvFLhLERdoTnrufVUPMdQz/hw//odGTCJGt8HLrn59K6BkpCIsBAb9NalXg3E7mntGy8T6x5nyjhaptQkaBxASHzCfhCPll2G7sSTJbHK7yGVPgdiufQUdNv3W0Ex3y1oCliP3BxGPLj40ZOikfQJ05WpwBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6815.namprd11.prod.outlook.com (2603:10b6:a03:484::14)
 by DM3PPF7468F7991.namprd11.prod.outlook.com (2603:10b6:f:fc00::f2d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 06:11:44 +0000
Received: from SJ0PR11MB6815.namprd11.prod.outlook.com
 ([fe80::5fdb:7ce4:1375:3a71]) by SJ0PR11MB6815.namprd11.prod.outlook.com
 ([fe80::5fdb:7ce4:1375:3a71%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 06:11:44 +0000
From: "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
To: Your Name <alessandro.d@gmail.com>
CC: Jason Xing <kerneljasonxing@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v2 1/1] i40e: xsk: advance next_to_clean on status
 descriptors
Thread-Topic: [PATCH net v2 1/1] i40e: xsk: advance next_to_clean on status
 descriptors
Thread-Index: AQHcQrC93ElBT1jzGkCik6J1gjAaa7TNfZuAgAAjr/CAALsdAIAA4wHg
Date: Thu, 23 Oct 2025 06:11:44 +0000
Message-ID: <SJ0PR11MB6815F7E1AD7F8D437C4589F690F0A@SJ0PR11MB6815.namprd11.prod.outlook.com>
References: <20251021173200.7908-1-alessandro.d@gmail.com>
 <20251021173200.7908-2-alessandro.d@gmail.com>
 <CAL+tcoCwGQyNSv9BZ_jfsia6YFoyT790iknqxG7bB7wVi3C_vQ@mail.gmail.com>
 <SA1SPRMB0026CD60501E3684B5EC67F290F3A@SA1SPRMB0026.namprd11.prod.outlook.com>
 <aPkGKqZjauLHYfka@lima-default>
In-Reply-To: <aPkGKqZjauLHYfka@lima-default>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6815:EE_|DM3PPF7468F7991:EE_
x-ms-office365-filtering-correlation-id: 35b333d8-30e4-4825-ba13-08de11fb0a66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?LKcAvUv9UETrUyJSrof56cAiD+YHeXnrf1vZOi0gyURgCD7vFcH3kgQGIQ2B?=
 =?us-ascii?Q?ELdb9UW92rn2DrPOC5cfbwj5T889WoxNp77R7n2TZS0O44r1AO4iwwtf5g9e?=
 =?us-ascii?Q?D6O95gZuU4nlSoCIcJSb6ZKrFEuhGj3lNFU/1o4zMKJ+D7ej36w3MJ+5Ne+B?=
 =?us-ascii?Q?sftKjdXABJP3Oh0RVX9PEHxre0ese14P+pszIV+T92SbGV+u9j5jb4R6rHqW?=
 =?us-ascii?Q?0BMqzptmNXGNFijcYbJOlZ2+ACmE/ZwLeiNWe4hDpOipkqvp3SpU7+uLDEFG?=
 =?us-ascii?Q?0ai/YWNRWpIJ+bikkG0Qc+2G5Xre9zmLR2Z4M1IkUg3v68z3pM9SuISAwJVe?=
 =?us-ascii?Q?QjOh2q8M6xkbIIjXVWTpvt8VzeE7eSf9JvDi0+Ir0aWMGRwLRwfRkrTnySUQ?=
 =?us-ascii?Q?QFuF0TYIHuzDK/MsKV/5MgVKCiBLTm9UTJI2hH51o3ebgXQTO+gKydPRcGOf?=
 =?us-ascii?Q?oc2rAZ+BKJG416OdfdRuLJCaTtKODOADgLnKhyhWThOmsdfZZUGmSZa9GnWr?=
 =?us-ascii?Q?24sZxxygQ40VO5/7QjINFD5dFUOji9mFs5F4I8lCk05uIbKegNt+SOjrq0ge?=
 =?us-ascii?Q?hgDxWQ14U4vCA1JJ0BV1mqWPIz6eZXSLKCdZ4c0/qSCE5yVfSiIG4fp+QH3Z?=
 =?us-ascii?Q?jxQobfl6ZkZgR5gd7Gs+zyy3I79TBnwALrc+L+ciTQNyEHSHoeg5od0T4a3S?=
 =?us-ascii?Q?+zFVNng5jWQkIt5bs9qGd6ME3cmcpZvGl13LC2jgmLTJ6TuD/P9ml2jR/mY6?=
 =?us-ascii?Q?e1zGg3QaRamvj0dAaoh3k9wCTjrvDFq6xDz///n/qToHmJCDhiqWVOCPXzGo?=
 =?us-ascii?Q?VOl+8btBxRc8JzSqeq09O1W+mUj1p4Yu8e/PwgL90ACBbE8EFUBgAy8QVroX?=
 =?us-ascii?Q?gFwTBD0doDELwmt9n/ewKIq7kGbHAEkDTzDqv79jntPHcKMWuHRp+rCYji+b?=
 =?us-ascii?Q?VGKOQBek3+s/n46ZTMkubxjEEL1UYnHWIjUXzdWoU5c8QRMim0EnxauAvuJA?=
 =?us-ascii?Q?FmCOfpujiX70Y0zkr6O5/F8YfgHSzd8TT3HtnHFc/hMyRe9SJbIKjVZI6260?=
 =?us-ascii?Q?FlpM+cXRbGMnJCNrn1dCPSHU1aDj9F6rbWboylDSNOhGUHTx/mul0ZTA1wi+?=
 =?us-ascii?Q?A4bu6UFlcjenMZLw1N4DrKvPDi3kiRiIXcXW2DvcRI1gptxxyjGOUJkOsn/S?=
 =?us-ascii?Q?5Ugm1A/9nsJzO/82OW/u4QyY7refd9ylxDW6xAGXdag+xWuWRHugWrqB0wxT?=
 =?us-ascii?Q?HJJOmlvfkpEY//ubeDYR92SdpwLOxsoMEZSCVuuG/XEn1QhpHBNnX5CIjLvb?=
 =?us-ascii?Q?+xTUjX9fedpjbbQdSgwN8gncMDJ5c8/92UGQ0h2ouLGS2ywAt0j3Djn1vtaQ?=
 =?us-ascii?Q?99aYcSYLLh6g2SBQ2UOGX3LtqZ0uWW2Rqjjw6925eiddVID0Q83xf6nVkh+Y?=
 =?us-ascii?Q?6Nuf5kySauiJyYyQ5h1Yquu7CuxtAVXQHMD3BdYctvOlHTQ+Axix2CTEt83m?=
 =?us-ascii?Q?Kln57U/ONl6FXglbnnoLzmGFUCAEPZrL2e0G?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6815.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hnngl1JPoGPlmsRLLbrLhUsPNE7imGXEJWiy8mgTnEoO/0F0CbLaps48FTwF?=
 =?us-ascii?Q?mub7zNKJ4tbCE9DZRQNTGqEZy6YZUOKcQzONBqGyf4TM3R6I8Vcp4tW/Frsi?=
 =?us-ascii?Q?4uigQ+O+pEDcVremb9rvG7wk6ENgLuzEDIX37ruuz1dpl2cswwCXs967tvAW?=
 =?us-ascii?Q?y1a263RBcH1GwtGRjJuiVz9EURl+D+Z1Mu5zE0+JmGt+uIjgwVWJqp51JaNy?=
 =?us-ascii?Q?WN60+aD9AVVFkNJ0fzP+RQrL8L/AgB7sA7WNjoHOyowMkMlBopLKBdG/iuMG?=
 =?us-ascii?Q?P4cnXgmyt1QjAfKxWnX7ERPB3Au6P7Lm5aVXilBVpEdCKBWVO5tk+7YG6z/z?=
 =?us-ascii?Q?fXuez+teuu9+KvNoIQ0u3lgUqTDA9V1IWfY5nUUzQHmY2dLXTDeX4/oKKBZH?=
 =?us-ascii?Q?kgZ/v+/48r+1GZbff04Uu5SeUZpn2zDgdAUaTpbGKwqiA0XHEyKkWTC7JWId?=
 =?us-ascii?Q?cgQSD+CJCRIIadh4D4Lt8jySyG1uHDQqMVn3vAh94TSUR/+YwlsHtj01Zq+R?=
 =?us-ascii?Q?MDVEHSMrubmDD25dvpjrgr9nHhFCEEoZjUk4ix/N1BehnpM8/0n9DxcTi8if?=
 =?us-ascii?Q?+WY/vqW7vXoB03LLKbu6UV2spUJWZnP69Q2rwx4BnCpE02wSROLGT05nYUUK?=
 =?us-ascii?Q?rQHPZHxq36k+RYWFN/6/41lgr03eaNrwAyIKwCYosJ9lvZQsDPK271WiFgc/?=
 =?us-ascii?Q?T7pYcVIoD28tXIX52ZuqlvXdbhM2TKfSeKyQdBBUUKkg5WnaiQgAzQ0EzCLx?=
 =?us-ascii?Q?eRFyg14rhuGVR9VGRA4BYHIfv3Ac1Cs4NiFvniazbdkp2z+H3xLHzSpJf7S3?=
 =?us-ascii?Q?RqgRRBSdA13tEpyBRVnn0XZ1hQHNorRLqUVl5h36y+YsgY9WvzyGmxGV/Q1I?=
 =?us-ascii?Q?fwrEqcDvvkToci8WQcYHuNFhzyVgLU2DsdN0muD07dvfTFD24Mgah3KZhj1q?=
 =?us-ascii?Q?5rjFCfCGWZhDc270oP9F9gfPKq3QN4J65Pz2GlnLI+NTNQ6keqDtkw5yo0Ox?=
 =?us-ascii?Q?+bia4yTHymLBzeas9D4SqgosJYXPcveoBsmtO3HGAyFKIdW0BG3nuOuxbBBC?=
 =?us-ascii?Q?z2YTetSQXW8ALqCyXB2uv/ZIoGDhRP4wzt3hL0E/NEZokBcSkmp1vDirLjkl?=
 =?us-ascii?Q?0G33fNruior8Z7MCi9eG6WwTLQqleBvPMKp9I+nU8QL2NIwHgFV7PwHJ+jH+?=
 =?us-ascii?Q?ktqP2wUjBi48dftJdK2+/IQ7cj25q5SfiObm/c4iz4JwUsufFLK2xFjlpCz1?=
 =?us-ascii?Q?D/Mm6Bd2ChcGS7tLXnKrEcSRISp1AR5pEm6Asx1OB6Hj9EUuFPD0RTC4w9nA?=
 =?us-ascii?Q?3bC0k4kphlD4dad0O9OoUdsAgEMvsTQsSJ/ET5wjQuL5gfCyKEWRVlBn2tsT?=
 =?us-ascii?Q?YdmJeqGQFpHBXbQltDSsv/aePySn2xn/BySBOYf42RkMxN79XQ/BL4eSXn9o?=
 =?us-ascii?Q?0ZNeXBCDlbczvI1Fb/X+ITsILeDOsbwMID6aAQVgAkHZ1S1+zPWVDN5AwMbX?=
 =?us-ascii?Q?lonUr+x84+d770MFJ6McHryO3xyZhJNH/o5cgDOcmUe8u4gdu3hN+gi4t7if?=
 =?us-ascii?Q?SPpbg9/tGh4m/jWIxFxlavT4DOIRuflckgFhjIZ5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6815.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b333d8-30e4-4825-ba13-08de11fb0a66
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 06:11:44.1766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7P8xHyyFaF/ybd+FL2cN3c/mg+z3oii6d7PA4QKuHVzseeMHlKlVdl9sN5u1GyXrP5BNpXCPkSnpMLCs9tuU0cDUvCzsYPYJJjQi4tJfoZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF7468F7991
X-OriginatorOrg: intel.com

> From: Your Name <alessandro.d@gmail.com>
> Sent: 22 October 2025 21:58
>=20
> On Wed, Oct 22, 2025 at 05:41:06AM +0000, Sarkar, Tirthendu wrote:
> > > From: Jason Xing <kerneljasonxing@gmail.com>
> >
> > I believe the issue is not that status_descriptor is getting into
> > multi-buffer packet but not updating next_to_clean results in
> > I40E_DESC_UNUSED() to return incorrect values.
>=20
> I don't think this is true? next_to_clean can be < next_to_process by
> design, see
>=20
> 	if (next_to_process !=3D next_to_clean)
> 		first =3D *i40e_rx_bi(rx_ring, next_to_clean);
>=20
> at the start of i40e_clean_rx_irq_zc. This condition is normal and means
> when we exited the function - for example because we ran out of budget -
> we were in the middle of a multi-buffer packet and now we must continue.
>=20

Ah, yes. Missed that. BTW, we won't run out of budget when we see status_de=
scriptor or in the middle of a multi-buffer packet since those do not incre=
ase total_rx_packets.=20
However,  if we see a status descriptor and no packets after that (size =3D=
 0), we will break the loop thus making next_to_clean and next_to_process o=
ut-of-sync with next_to_clean still pointing to status descriptor when we r=
esume.

Thanks,
Tirthendu

