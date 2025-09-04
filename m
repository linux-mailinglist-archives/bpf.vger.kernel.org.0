Return-Path: <bpf+bounces-67476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350A9B44384
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3403BFBEE
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 16:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA8D2F3C38;
	Thu,  4 Sep 2025 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hs8omudL"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37572D739E;
	Thu,  4 Sep 2025 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004304; cv=fail; b=JSwQgZAlA/Wt6QGImmVRG+dVPQHmNAX/g3dXiMfvyRdhMgpDpsAjiSl0usuwc5yg2RHp5/cwpODmul/bPO36ofWwcT/6RSS8LXDlX1OZbJnke45suQjxerWCJAtsi36H/1VF6zTteAuyzgQRa98uk9ZtXkX3Tv1FLvOyljzIfq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004304; c=relaxed/simple;
	bh=XxIHWWpbjn8PjZNF1GlCJdKMFpsa+l71XoEBPCUSs3c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PezTxma73h+0TtlgCiNOofuvhYlJ6VSOvL4y66pNACkY3Vp+qzOIV2seosSw1r8cwze3SurQUV8dOTf7TZrEPV/IwzLjcjjydraVEXbBcUBSPxdQVmo7g9kok4ao982o0nRvBaT7XhlU4lT/U/jL6rX9LefsDJ6UQilLEeVknMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hs8omudL; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757004303; x=1788540303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XxIHWWpbjn8PjZNF1GlCJdKMFpsa+l71XoEBPCUSs3c=;
  b=Hs8omudLPlg4Q3OJ+PscB6wUCs9oES7mdwvNXUPHmhctgy1SGOzonqGc
   IisLSLrDFfoP0cQeFFdy+mABp//KtXbawZhH5tTddfYS16KVJtvztOTz9
   R+TKsgFOAQZWRvT4o/uyzjGd2zVtUE6INv2pYzsKv6v+qbOoLCNvEdJjg
   jx+xZo1/ZrOnMgLB7mFroyDaAntG1XtJeKFmnee1f5c2ktFlerNTzXxaf
   pB/ZwiyCf4JaWUekkXj3MmD3G9CHRGROumTqtE/DAQongh22ODstLJKas
   6u2IqfVC2iAi408vfFkj//TJSAeuiqRmTtAN8UR6Y8xULMCcmdLOmjGPF
   w==;
X-CSE-ConnectionGUID: IqLh4l2DT5CO+VjW9LmmNw==
X-CSE-MsgGUID: d/n09y7lSlOdM2xQwKSuQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63181197"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63181197"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:45:02 -0700
X-CSE-ConnectionGUID: CxbQ7jFrQwmFG4h+18VJ4Q==
X-CSE-MsgGUID: U+G1ousDSJysxQM4nmCSYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="209121371"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:45:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:45:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 09:45:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.55)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:45:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCXdzsmE6NkQRjn1W7mFRgdszRlf7VIHErPK8Wc/gPF04SJoR313mQiY9JHVWxkoPJ99uab4ef30FfBX7OM6hcZihTQfEW8dG06X1/cpvwsp4MP8FuOyCPAra78KkobysMHhafAPirlG71dm6AJhiBU0gz+El3hfp99voYc+WxVDFcSg6RKsnTR2r9CMRnOOxL/JP72oT8YpOYGa+g3ni5Cc6lfiS/lPwHYs8kNrmW68Fm2Cg2SCMTt1Zn0YlMdqCmb39UNao1wCAh+H7RvNw8+5ZHIFjqLQEQDs5qu0t1G6hB3jqbVKODDQOb8sWJ+tBUq9No0RlCLH1b8AuWiXow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTAUF1HWx4cESZ9gFNeK90ATUVokXj2DsmHnfYJ4t/4=;
 b=dEFK8tH+r8eFXi0o10F/tCjeOaDXxx2ExzzEFSM3h+NmTemk9J6hG6BWziWALimtw8705QmFCzlDVZLWEGoJfUjNdA+AwWkoSpNr7oFGUscPZf/A9FGNMjTj51FjTZmkIr9/TJG0Zh9rM4L/lV4PklKuPNTbIxKCuRNXF2IDTBZ8vMQCUH4m2q/LGPF4wFhQP633CrJGlo7jmOWF+Gsbou4kEJeAQWw4iyZL53EVdRAE3eXQOEPno08ud38sRGdrMAOYcBduZ/NXVHHO1fHG3GL/eElXrSzTxf6vjWfiwB3wK5BsqJTtwaqYjz6DS13/tf5liG7j6xTkrLLosIvfCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) by
 PH3PPF9E162731D.namprd11.prod.outlook.com (2603:10b6:518:1::d3c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 16:44:55 +0000
Received: from DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425]) by DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425%6]) with mapi id 15.20.9009.013; Thu, 4 Sep 2025
 16:44:55 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 01/13] xdp, libeth: make the
 xdp_init_buff() micro-optimization generic
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 01/13] xdp, libeth: make
 the xdp_init_buff() micro-optimization generic
Thread-Index: AQHcFqVrTZiegyG6SkyNo0ajjtWdFLSDMsfwgAAWCsA=
Date: Thu, 4 Sep 2025 16:44:55 +0000
Message-ID: <DM4PR11MB6455F02DDCD8FB0084D10BA49800A@DM4PR11MB6455.namprd11.prod.outlook.com>
References: <20250826155507.2138401-1-aleksander.lobakin@intel.com>
 <20250826155507.2138401-2-aleksander.lobakin@intel.com>
 <PH0PR11MB5013AB6B0FE10D9986EDC1909600A@PH0PR11MB5013.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5013AB6B0FE10D9986EDC1909600A@PH0PR11MB5013.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6455:EE_|PH3PPF9E162731D:EE_
x-ms-office365-filtering-correlation-id: 50dc1dd5-32a5-4385-6de7-08ddebd260bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?qcixBulG/dHRpD04Z5LzWLCEdQgbaJigigVDo4o+m3hT/iB0O6G7Uceak7Pv?=
 =?us-ascii?Q?u7jUVgtMW/2ruFWvqEzeLZjM1QIaRXAvH4duJygvQ0LSAzL60AX3x9p5iecC?=
 =?us-ascii?Q?rpCBy6CIEPHnaTDPisARjG+uq9cAONNwPBFoIApRI8cdgPt6bQbTnYYEXGqw?=
 =?us-ascii?Q?Oa4sMZXeFTylMzE2+5JBOnT5kdafGb7rI9kffD7vdh1YgiHFoE5SNoJIGcvO?=
 =?us-ascii?Q?NxDbN3UiC3rp3XGyIb9EQvp0PXCjJ3hnRjZK9cIR7kon/f/X9zo97bcHtVKg?=
 =?us-ascii?Q?ti4ri4ue0SUTNPtaSSy9PebK+ULmpBtGjHENS/5TO/pknhm4ICnOfs/aApYi?=
 =?us-ascii?Q?GpXPAb8wfF5yIivwk3CU/Z470c2H62Ql6cqlUSGAcoNXa1vp/MTWJ+pb+jm/?=
 =?us-ascii?Q?2BPs0xEwv5TWvmX9rvayN4+BudTvl2pZp9xu2/eyjyrbXDSjBEW6WSKYdmKa?=
 =?us-ascii?Q?c6T/VT6VpnItLP+8y4GFxW3OIIL7DTjs/QxDlLmIK3KWC3HwAAb4NLUc1sR8?=
 =?us-ascii?Q?2BbnFy0JNmLcXwcn/VEVW2pFOSa6YrAkTvg4PcOTDh0I7Yt3TFpCfsOC6wpC?=
 =?us-ascii?Q?cXH6PxbQbn3B3q7L3sJsWLT/Xpkrl+kfT91SjAqcr/57+5pFQu6a/xmfld8x?=
 =?us-ascii?Q?gA0mE9ynHwQzVmFTyTQ3+O7WHcI6D4NhhbY8S9kxUEFoRv3tVyW48rl3i4kw?=
 =?us-ascii?Q?XMDWfX+l8IiCTdXZn63NU/laTJEDyiUCmQ63AtMOW23Tfrg7jZaI/P675Ug+?=
 =?us-ascii?Q?JNMcFeVKGWj2Xc/4V9sBMN+7joVv+65IbSvoTtzQ8A1A8h+jwvgRv2qAE3+q?=
 =?us-ascii?Q?I6o/X2r0ys83nk72y5Vv74zf0PhqtT/BxxWL+3tmjxzK9rMtOaRYQ1iKChPv?=
 =?us-ascii?Q?S9vCphmowWII8NpJAniEhs7Oq0k+7NYFo0l8xEpOX3//gA/Rhmr3s9GMCy60?=
 =?us-ascii?Q?AyyQfwVkTmgsTg1qBtFKxQG4SxHblQqk9mV/OekrHq0bGolKp2dJ7rb2/nDo?=
 =?us-ascii?Q?Eelftb1VRIbYWshZfisdkj2L7X42uIE+EKxMHH06KlD1PFzJE+OgnIXXuaOl?=
 =?us-ascii?Q?xrAaKXWL+zd2Zs7i4jYGn9r3AF237pZTiqtRsNcZ8hOelQeOEcGNZSoJP9iy?=
 =?us-ascii?Q?mUuQBf30/pLGJn9EaPZEzStYp54VbSnDo/b0qCEg4kRqf6QGSXByxoGYV8Y5?=
 =?us-ascii?Q?OVsUj2Mk8jiGw9UdGfIgZFBaVMDiLWSZ1trVprnut9KTEKX9RKl4ZDg1Xy6+?=
 =?us-ascii?Q?fR5WOu8ET+xP24uSSCi5OoaCVWZsJ2AIFGgPR+RrIf1wn+w4V96e6h/PXmaW?=
 =?us-ascii?Q?xi/ZusZ8rkHQ8Z+CFbTPpPcnUBdZm+4ANOlAn64P9tLfiiLJYsBI9PNzmnFq?=
 =?us-ascii?Q?8PmdsYjnuUC3ECs/TNpK46p9V3BXYEY9Isj9K+LIXQIGGswIdoBW/N6fcnOx?=
 =?us-ascii?Q?RS+dVaMbXEH/qmQK8XH6/xMOwNoT7hzEnlMA2u5FLble5jXJplDY9A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tD3QiAQKddU1pcUVq2QAqzNZsEc6HX3yu0wDSyl0Ofklk8aFvPtkvRcCct07?=
 =?us-ascii?Q?+6L/dSRuPJyjusTZKGaNXqrdSdNYkShVJfYTGKxNtKLihhaVq6efAhG8ODLQ?=
 =?us-ascii?Q?FmLaENk5q1vwL20YkH80Pu5VTXRmjioV2atdNMOau/gn6A3UyUmspSxqkkd8?=
 =?us-ascii?Q?/wtutVQvTbQ0GUMVq2svB8jsjfmam3zZip3fEIa4IbuJwR6A+1VvDLOlFDed?=
 =?us-ascii?Q?akQJgRmG/gE0G6YxmvXejuRRDT/WOIjmV33+t1ZoONIr7+EwC/x+V1IwnVfI?=
 =?us-ascii?Q?xg96bekZQ4MkgPN+lc1LjeVqFX8syS2D+R3eV9MiMKYyxrTCMfA5GUSXIXFm?=
 =?us-ascii?Q?bhqIV/nT/1eB0ZX7GMvGq/1VLbdgaxHfFng2ziReC0Y2be3+5mEbt9x8TGwD?=
 =?us-ascii?Q?WFKrqKqt9oLcNCnjNGy6iOAB5QN4hq79qtY8OcITf2SaSgs/BXvgmI5Hc7S1?=
 =?us-ascii?Q?8lYWVYR/giBBnTalQOazT6ZQVwGA0kOGXtGOa83t7TBbaWfPABJztF8xYbwz?=
 =?us-ascii?Q?dIRVIbrGtyOTMw86bEwInXPn6WxRmHv7nXp1uigmzRYU1aT/7uL0prlqyI99?=
 =?us-ascii?Q?lt6AvYUPRIte60Tca4qbgCHtwRgqdA6kg9GfmBv4gdy3UdxGeYTX9mpetOph?=
 =?us-ascii?Q?LmsQ9bxwDJP7L6kwzZ2hDcvpueF5jlV+6XZh+i7+F9w8J2oK5b9km1PmPO9S?=
 =?us-ascii?Q?ksNQnBYwFNpHRKS68wEmelyecmuBHs4sCycwWj5SVxBwL7Yz152155nYymdu?=
 =?us-ascii?Q?Pj+h//fOidZaCumsN1/jw5TzU3imBjtDOOncYQQWvap0o929FZ0UeL8vm6FA?=
 =?us-ascii?Q?EzktkVG+66WXiAcj6Kh2P7ss79rnn2rvhOAEKx1igib2nspjw3AExCsp5w9e?=
 =?us-ascii?Q?KEw50hkdc42b6jFXtY2w2m/INOftj0yS76KRvXXcGsoTL4tlVbxlHdapsmlR?=
 =?us-ascii?Q?Dbmm0WfDhAk2CbR7lasK6NofAUI3bVZgWVkpF606V/o+cV8t67C2RoaO0DyG?=
 =?us-ascii?Q?nylIeAhsWMYqNR1tG0jjlTqe0wOsErLLNVC3XURv0FlG3gU9JvwZTGCs1a3A?=
 =?us-ascii?Q?e0NFDoyr2SwvJSiDhiRcmNAxKJkWudneFTitzMaYSilNihnTFpv3AMIj4GUq?=
 =?us-ascii?Q?O5cNY9JHjqctpGhfVEr6waGR6ii7g0BdRCMfWY411SKOl42wy3rYgqSse7Hy?=
 =?us-ascii?Q?W/PZUYEQUIzbaJwAnHDKPvBdJgX8kSwElLzu9apF9G631puUwLKYcNQcKPLf?=
 =?us-ascii?Q?dmJttiA6D8C9To7TdFt9VjQkJaGChCh07Ve+4sglXHSYjAZW2IfhPFLvevl8?=
 =?us-ascii?Q?wuy9yLRyU1pQ0yStTTOykGIJ12ZOeZW9L81XcqpabRK6FM6/hrsXhuRGEQhk?=
 =?us-ascii?Q?CuWXfNqbpPdrJHyPdr87r8GVmEV0i75ftQv0k2f4788qYkeK/1PPgCbwhf8F?=
 =?us-ascii?Q?ztS2X/CuWA5I/52GbDx1XvcpWhUthmRN1KPYkwHCRmR5vHdvrF+KOU/HIhje?=
 =?us-ascii?Q?B2rh5pisDxopLwjANSjpnbc16Hsfojn56RbAug0gL7dF6IekcHMnD5TOuvE2?=
 =?us-ascii?Q?fhAGdWnffRJdiZjwI30=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50dc1dd5-32a5-4385-6de7-08ddebd260bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 16:44:55.4698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zMU0i1hvDi3SHp7YmgwldaqXnjrkfonZBXQ2yaqr75gNU/6q1uiGAj5Nld2638cDEpiT+814Cigwrfz3skjkew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF9E162731D
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
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 01/13] xdp, libeth: make th=
e
> xdp_init_buff() micro-optimization generic
>=20
> Often times the compilers are not able to expand two consecutive 32-bit
> writes into one 64-bit on the corresponding architectures. This applies t=
o
> xdp_init_buff() called for every received frame (or at least once per eac=
h 64
> frames when the frag size is fixed).
> Move the not-so-pretty hack from libeth_xdp straight to xdp_init_buff(), =
but
> using a proper union around ::frame_sz and ::flags.
> The optimization is limited to LE architectures due to the structure layo=
ut.
>=20
> One simple example from idpf with the XDP series applied (Clang 22-git,
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE =3D> -O2):
>=20
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-27 (-27)
> Function                                     old     new   delta
> idpf_vport_splitq_napi_poll                 5076    5049     -27
>=20
> The perf difference with XDP_DROP is around +0.8-1% which I see as more
> than satisfying.
>=20
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/net/libeth/xdp.h | 11 +----------
>  include/net/xdp.h        | 28 +++++++++++++++++++++++++---
>  2 files changed, 26 insertions(+), 13 deletions(-)
>=20
Tested-by: R,Ramu <ramu.r@intel.com>

