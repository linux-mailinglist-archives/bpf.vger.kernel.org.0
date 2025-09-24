Return-Path: <bpf+bounces-69505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8B0B9843E
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 07:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89A21B215B1
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 05:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201052264BA;
	Wed, 24 Sep 2025 05:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4SirxFU"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B448942A82;
	Wed, 24 Sep 2025 05:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758690506; cv=fail; b=cbS/Y4ThJyNbLpSk4IkCJ0LD6/NkxLg+OTuWtIsIYep/GKzNRLgnkcJOjLKPjYZv2nbJRVfrc7D+/qevNDrX3bkBeq///gdYGEhlTedxGIGgvbqcxEvEORpV+1SnGLn6IG3UcDRkBE6gpn7DT21VDwGeix3gi1u5siEDom2MNJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758690506; c=relaxed/simple;
	bh=de84fWlFnMc9r+MYgORisViKIakF/XAEY7m116BYREA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wuortxu0UmR3tSlN6Ff+rmd5CLTUEtjE+of2BVYefouaLaxTQIOfxEQrJisn6UsI68ITXG5jWnkYWKch7FpiI/pVDyOWEOci8J0nomNbXzoX7SFyIs5dcz7nDQHN1IZlRg1WPlbvHStT24ZCupDXSaYztpfqFePQtog5PDjWlvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4SirxFU; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758690504; x=1790226504;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=de84fWlFnMc9r+MYgORisViKIakF/XAEY7m116BYREA=;
  b=g4SirxFUUF8S7WdLPBcNH/3t3ozI2MKrRZ6cBw2TRyn0zpFaBnHoLl13
   nv0kn0OZsOpidLegAxxSvJ+G9+k5if1Cc8ewTNUTb4/7c9N0Cdm5A+wOE
   czweDfjdisDcVXNkF5TrYtcyaQzFtC+J1RcMt5wR8xbbTPkxCDN9sDyFD
   xMd2iveoT/YV7ugF0tg12PwVlATRImod3duQVJqJr3wcMCflixlHM3vRD
   11TyQNGhtLVrVnTI2nrIHkpbQ1GvVshiI/qL2RZhro7f0+caDI0rTiUTG
   zFLH9b/ZuhTJ6WACWaRRJKpINNBxPWdAmV6TI0NBLBaq5TmHbh7M7ljNN
   Q==;
X-CSE-ConnectionGUID: EtRmYHy8ScO5jcHhfHCdnQ==
X-CSE-MsgGUID: +VcqRZDvQomwiFm/5SxLtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="86421079"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="86421079"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 22:08:24 -0700
X-CSE-ConnectionGUID: KK3OcC7sRhWJ1sk0jhJI9g==
X-CSE-MsgGUID: noUrDjc7RIS/dtSkCMHW8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="207687922"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 22:08:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 23 Sep 2025 22:08:22 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 23 Sep 2025 22:08:22 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 23 Sep 2025 22:08:22 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.47)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 22:08:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kV2vQEzwdZc3dt9lY/FF1At9xuxVzxSFToL0xig2X3gj5crAZpKHrwhGsdiVx7bfBosVicGZJNr1XMfWgelBeXLOCPqM4/fgO6+p0Jisbf0vH/7cOYePoTrlBSZi3EYcNiExzvq0xvz1eoWyAKmGdEE7622IgDlMjmYNWGrEOicOrHz+a2YB2ms9f75qBDTPEEYFHBxVr3ISSWQ3e6LR+kos1WRKM5j2xO+0GqAiqWKJKOaKzHGveo7NV6Fi5aVn+R7y1K8tNw0vCe/8A8L3+W7hHxCWC2uTcMEn0cSlkIyarE2jQMayOgyoUwQk5EehpxnwFJpfJQA/pUsH4vS1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVanhLEJq/tMWa8+HXw5JbUrZ6x+JNf96CZnRQS5gj8=;
 b=s7SPpiqrsHWpxF8EecY/X5mKFeuCVfbARqnLIZMZ02P+evZB3yreYn5UUIbMSp1N8n4gbDPff/QljqFI7UdHDr7lnMDXKbsCB3Va/YnWKWZnC76SKGUMbo+IiUj0lLE9eTb8zB4X9IAFPtu+fI/XWNSrQgtHrLvlR3/XvxNbBGisFQgZfWm9URh3gAJBG8nE4IK02x+q3igHwOwn8pfFM1MZoSlyOH+Yo5UnxwM9wxplVQ8ENvCUMjBTU0qzLKU+aqEtS4lXGrzhu0/Pmgi3wH+A1YFwWXQKHs+lJXTQB01aOdmH9xp3rPLc0G9ORMa+RimTzqmqj5xFesxOqkBy5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) by
 MN2PR11MB4663.namprd11.prod.outlook.com (2603:10b6:208:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 05:08:20 +0000
Received: from DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425]) by DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425%7]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 05:08:20 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 1/5] idpf: add virtchnl
 functions to manage selected queues
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 1/5] idpf: add virtchnl
 functions to manage selected queues
Thread-Index: AQHcIzh0ptTesmkgz0i/kck/mvy2IbSggFZQgAFaItA=
Date: Wed, 24 Sep 2025 05:08:19 +0000
Message-ID: <DM4PR11MB64558771E00F6F7214202E4C981CA@DM4PR11MB6455.namprd11.prod.outlook.com>
References: <20250911162233.1238034-1-aleksander.lobakin@intel.com>
 <20250911162233.1238034-2-aleksander.lobakin@intel.com>
 <PH0PR11MB5013B3080461D0FC356662C4961DA@PH0PR11MB5013.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5013B3080461D0FC356662C4961DA@PH0PR11MB5013.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6455:EE_|MN2PR11MB4663:EE_
x-ms-office365-filtering-correlation-id: b8679385-a2f3-451c-f309-08ddfb2860e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?MTH/D+Qtj+hUh55yRLWaAzUVCSFch8lAqEiBkm6BBCRhxewMi7V+YNwkRmfz?=
 =?us-ascii?Q?RqlI7S6PHjJVGuwrxyKvJc9QuQvmHYjeyQHkOdzRumdGfHn+3uC3wJJDyrQu?=
 =?us-ascii?Q?/CgTpG77XGV/6gsdYgnQF2SrEDtu115HWx0hvIp/6f2uh+f3oXFHdRxeECBm?=
 =?us-ascii?Q?9jJZMs13BCo/WBYWTsEcx2+tMLkWeguSJ3k2hNm5DeTY1vFJUFN3FXHAUm6n?=
 =?us-ascii?Q?lWlfGJ1AQrAcMx+Tlnbp4FbW9hMfmIPm/u3cC3tXMREc9XYMBvsen/i7CiSj?=
 =?us-ascii?Q?38NTG//6eocC4WSnbwWB2LuPq3z29HUZtrTa56k8KxsPb7kws8XbRzCbd6Iw?=
 =?us-ascii?Q?k7tV27QdUDh5gI14gbDgKUZEnDq9rFqAGxEEgbJkBdeirKtG6UyIISQlv8BZ?=
 =?us-ascii?Q?bwgRN5qqB4aDKbxZd/NlE5qHE18GDFYJhOVA5Ea9UUrgLJvi2S7Mo+zQxq07?=
 =?us-ascii?Q?O9ePakytmG7FxJ0DZv3O2E7XKhTLfUhHQCF+6FIUq3zVFJ2Kuaa4Mz6hI32N?=
 =?us-ascii?Q?yik0qbF/79SxzV9lBdSyPVYDX/iE5AMUYw4vCrYg1nAf1Uylg+vldlEB235t?=
 =?us-ascii?Q?e3Ba/hcIIurkCF2B4v8mGFGoSQa2UDrvSAKUAENJdTAaF3z1BLfZ3tXW1ZxP?=
 =?us-ascii?Q?mmRsXM2T2Gr9RZtMJowc+jNc5ow6uQwZ2cfWgddsXhcEEfBZIFQXZXiO2/qz?=
 =?us-ascii?Q?nGJ1DETmpCi8vE3QzIaM0P/VZXG9DMUVE63TQRC1BOTpx/dpwR90romqjFrc?=
 =?us-ascii?Q?eYMiBdshWTyV3NFK7QtqrhNhHZC2kZGm0Y48lGarIlL7DZiWjF09YNxTN9yl?=
 =?us-ascii?Q?gm3nY4Nid8X/ZkLB7kGaYt2oGjb4QtIM4fih8Sp+liTOPTA0LDHSFcan6jpI?=
 =?us-ascii?Q?n+arI/QgGYsgLrabex8oDnud3MMyi8ZiVugLzIelIGtUjjKnbkQrnyGhjyL4?=
 =?us-ascii?Q?hbnUexi2XuNigxFej+Xk9sEZXluLef0IioMcqQqPF5Z9AZB6r1mteZa3rqBs?=
 =?us-ascii?Q?b6og6EVWrF8ps1/ncNA0IlBxR7AbBxBsRQKJ0QVV8li5tgat4Cw6RsFjHrBc?=
 =?us-ascii?Q?4KUpO/SjuA4ecqWY+FiAN1IsBENq8ThIWcA/lD00yaZ/JTiKQ7pSL+2sRhA0?=
 =?us-ascii?Q?2IMMs/I5BTjwQbKFYMLf7NU7wDKH3cL8pd3VkpW5vAPowKVF9iFujqMvux7H?=
 =?us-ascii?Q?OOD0TQjFBw1YOcsWPtN1l9C/cNZvYl3VihPIlMCCDB4G9CKTWphKr1bWLd8f?=
 =?us-ascii?Q?90IqXEdpdQH67AhWLpwqKa236Qoe/dRd0SwPgoRBkbEP/ryN9ymA2g4tTT+q?=
 =?us-ascii?Q?vEWrSdZAC6BIlFJlxcHHHfS8pi/2IaDaXoUKq9UlD3/DoE1gnTJPvKylzW9f?=
 =?us-ascii?Q?lVNZPWFLxcIeAbV5/F9IzQFLsELuwkph7Im0cG2sl/Ck1MnUYT3nPR5LPsvS?=
 =?us-ascii?Q?+9ERFJ+sg4iStipthKd4ehcTXHqTBZIM8e2jBDlhb8ZnujjH68hgIUyNufWI?=
 =?us-ascii?Q?HEVPtHbdbw0r0Eo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kD8AxMrjwJ2TtOVt3T4fY3DuueYIlASyHn+cuqUl8izlnqvhEMoSrHNIMaYW?=
 =?us-ascii?Q?7EAQzwH9+dNWcnjm3bs/5N48uym+0zVtK13nIOHGmA1krG8I72pgm/0V7FI1?=
 =?us-ascii?Q?tKBkVGJRXVeQN31aE3oBH5Mdkzr5Tsq8Hqn8pbuCUY/tfLL8lWSj2Tj3NwyY?=
 =?us-ascii?Q?6IeqQoWk9vqB52AModzFmGs3Yv8iNSZZL6AntpMWZChQg58A092FfnyBe5Ry?=
 =?us-ascii?Q?tt8U+cpJ1t8wECF/lQyk+C0Aa781iv6xt2d9qNAmEW16TmlCwkzsJuFZ3Ps/?=
 =?us-ascii?Q?2gwuR+1/YPH1vhNpX6exynsdxjarSS5Ro9iCv2NFPcn+OtsnFOVc/X5E1ZlT?=
 =?us-ascii?Q?3mecNFCNmYr8rJXglZm2+QBAAEluaC4t+5dL/lDU5+CLI8ndIVARSQirts37?=
 =?us-ascii?Q?mUB6cHTrKzM8IK0AGQw5W0obV065UxsgjWtjA2yEwnlSgC1wmCHTa0HfvrdB?=
 =?us-ascii?Q?MAxe/uFU5j1TA6kMU6QiI1nVX325C4+LaLKRe+QqD+NJF6I13GCDbLOZLT0r?=
 =?us-ascii?Q?xbPkNoq6yUB20CvAIAq+zL60b9mGmZrQzPPn7lItcLrUIZdsoC7P7Vn3krs2?=
 =?us-ascii?Q?qBxY/2/nliFInyZuaIePh/3kgWriEiEroQTfwUILjjrncdvNNLqoPOf8ay5W?=
 =?us-ascii?Q?pG7nyVpsR9SSfGzxnkwvn6h0U4al6ihyEUt0MPDznPNfGyajrDz8Ccure/7A?=
 =?us-ascii?Q?I7MGH/g6EW/J12P3s8V98Xck+edOyblSIgP7zRHthjW03WyHqZPFhhKrWUim?=
 =?us-ascii?Q?PjG3h92iJ0SlsMn5cENgBHXrRICOwLnIpvlUu4noKqKq2IXY/EOp2i8+3pZx?=
 =?us-ascii?Q?Rb0Oz2mrEA+f7Du45Z18OeP8rVyAJDEpY4UiKp+i6Cp4J3XJ/ghrzv1KMTzN?=
 =?us-ascii?Q?qEcvsIMBJ2kK8/0vVdgrwBMtMux8vclLzdXcsubZbIcZwb7StDDsxprP0Nk3?=
 =?us-ascii?Q?Q8WxmkfyTE9aC6u3/h+gFV3cxvIyCcwCMr+D792jiYCKUtVaXGYml1sX0U2o?=
 =?us-ascii?Q?xU5W+SA2CcusCy7C4kMmjl2AdF7210i7LdX5kYupviYkDwPzqDX38GWlD9ZI?=
 =?us-ascii?Q?b1REdKE1hBjUmb3cyIpOCAJHkYRsD8lNLmpf9XaBp4TDBOFfBJR695YtUS6y?=
 =?us-ascii?Q?PmBFeSdHPQZ/LlMN9FGlx5V4HnP9wPY7POMuE41EP0raYuCrPABk0eTGoIxd?=
 =?us-ascii?Q?Iot7jh/iYsNT3ZgjUsWcYSMP4xud9MTzckTQ4O8bHXyE9BePPEAJrmp19q0m?=
 =?us-ascii?Q?w4Dovl0A/g1rIgCyhKATk2/yQOuM4qBovkp9QAljCukJY1b20U/eiiLHHO1o?=
 =?us-ascii?Q?Ui0wG/2TOQSN+MIVPNCrfCse421MIflNdOc8ei6Dqb4sxkr4qaWz9YshyZpm?=
 =?us-ascii?Q?sRTb/fKfV9UdsJbcPl2ZPfnp5JomNQ0U7d3q8Me5SC74LxTfqZ7vigu4ybi2?=
 =?us-ascii?Q?W2/AtqBHBY6kIi7pc5MldZ+L8ZztFMdpB3N6SJF6UnI+ovAftrDKVjgUWo4i?=
 =?us-ascii?Q?mEd6qGaBzT3SBbXJioQtgQ/haSotuNA7UM6Yvpy7VJbrtOLBlKUbkfy6Aft6?=
 =?us-ascii?Q?oy20EqTcI8Ryy0XoUhM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b8679385-a2f3-451c-f309-08ddfb2860e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 05:08:19.9568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d0w92ZRIJUc3PQ4CzLbdCSdVTFP7i+Vf1yJsSn4lkDhRuoJmeHSsE0wD6AjrFas05rxZEnWSRMHxZj23KRk6Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4663
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Alexander Lobakin
> Sent: Thursday, September 11, 2025 9:52 PM
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
> Subject: [Intel-wired-lan] [PATCH iwl-next 1/5] idpf: add virtchnl functi=
ons to
> manage selected queues
>=20
> From: Michal Kubiak <michal.kubiak@intel.com>
>=20
> Implement VC functions dedicated to enabling, disabling and configuring n=
ot
> all but only selected queues.
>=20
> Also, refactor the existing implementation to make the code more modular.
> Introduce new generic functions for sending VC messages consisting of
> chunks, in order to isolate the sending algorithm and its implementation =
for
> specific VC messages.
>=20
> Finally, rewrite the function for mapping queues to q_vectors using the n=
ew
> modular approach to avoid copying the code that implements the VC
> message sending algorithm.
>=20
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |    3 +
>  .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   32 +-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   |    1 +
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1160 +++++++++++------
>  4 files changed, 767 insertions(+), 429 deletions(-)
>=20
Tested-by: Ramu R <ramu.r@intel.com>

