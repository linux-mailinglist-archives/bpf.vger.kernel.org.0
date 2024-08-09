Return-Path: <bpf+bounces-36772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC75D94D0EC
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 15:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CBDC1F220E3
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 13:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F4A194C71;
	Fri,  9 Aug 2024 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="flgtPmZr"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFCA194C83;
	Fri,  9 Aug 2024 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209281; cv=fail; b=hVyH1L16tnUoyNSaSqH4UK65WQdqU9DAaY3sdVkM5iS7FaaRw3ONTKzNg2Q/ZDGuZ1ot8HbUXTcGCoNK7hmWcHkeKEAsxMY7b/1/SLwSAU54/bs5AuXGNSuEylqbZq3YxMyA/QbWzRpvdX/C6e1OM5721Ohdn4iBhOH9cc+xjAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209281; c=relaxed/simple;
	bh=J+ms4fEJPjje+2craC0oZPwvxViKsV2BMSJmayhQZw4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rCtP1dPF3amSKgviRitWV+n35d7CsHvQFMfZE64poMkHBDSYy/7LrC/O+C13Jo+3MbrM1RKdnNT7HATHwTXHkQ+Xrz6nNHXt+RXAVMn34B2zvlVMwIVU4Gr04SFmN/R9Rk7e6lGmDm5LrDm1kyu0jJT++kQN+XjFwVOJGd+yEhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=flgtPmZr; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723209280; x=1754745280;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J+ms4fEJPjje+2craC0oZPwvxViKsV2BMSJmayhQZw4=;
  b=flgtPmZrp2FZjvCfXXOCBCu4ZeEPk9/AraIWA/0m0dUuzmLs2yCVTupB
   IXoOUQ2VblFEbyPR2EGr/6wLaVAEQmZxSrTaDmvtGIWxrXb4Yu5vllG9y
   8ynXVYpqOQVLIEWlNNAQv6OAwOsTWx5VU3fzVRi6MeLAQ4Sv2N4JNHlCC
   CYEiizV/lbWFrD97sbAz1peVH6zfTIEm3CcET0UQ6sgqfUx8uY4NrXS5w
   0PJa0mHXn74RV2x2ZaH1BtfIqoCDzZRoIudKdFPJg9puvw7uj+Q1uuvNI
   qd8Ck+ba9ytNaMIPLUbMFKxeYhc/PYvFVtj7KJTk+hEEl+x8H/eNcAL9Z
   Q==;
X-CSE-ConnectionGUID: X508J3qbSVuaXj/hNLUmxQ==
X-CSE-MsgGUID: +NFgDuYTQ9uGJZHCi/YKJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21541352"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21541352"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 06:14:39 -0700
X-CSE-ConnectionGUID: CU2W4xunSU6t2MwZZH496g==
X-CSE-MsgGUID: lKRrTL+bRBqqhbq8/aVUNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="61970667"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 06:14:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 06:14:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 06:14:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 06:14:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 06:14:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYgVz6rjlOqtduBUb5Ixp7ijehUWr6UsHnd8ltGN6h12Ze0NyzrQCyf0qViTKUhMfTwBNEixaZq9a1KOqfv3jlDTiw4jZU27+knyEU5TRCf1Jgp6jvgZkXAq5mEvoBg6LNWhxrLu/5p5DWjlA4IEXw28wnFeyCOIRG+6RPLWs07NFVdezRTLVNXkUXtAEYDhcGj82G0qq7BDTZNS7YyMpiqVHbxarTbv4TReU1Gwsaul2VzeguxWGGKbhoJ0A0Xw8+RScygNaXZSCVGSjFb78Pj3lWBlDN4ELRgxRHG3Hr+KcY4nmRlM4bMMmx6z4KfduEtKxzvrwDq8QWgNcFxP0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1T5/LV8gCb3Few2tX2LvXmpxeUSv/QyZwd68hKpj7k=;
 b=H458NdQSxii6RVKCH19CE9JHbPLT7L2GGBOJHsMlDnDFTfbarMx44DFj5783Mbeq9uxEE0yxAPo/1+zwnDpEOC2jaqPGJGv62S33KyMSTu48xDamENetI0znKH0uxQAtoR1O5h4dAlrvDaN0MZRaOVoBHtVfIS5YwW5YHEVfZNl5nuc+Fjr2v2SJxR4fYccnBK31XmsWli/gw+SkEMhL8oRDvo04bLbi2uuJ0zWlhV2VxkapQMsU8/ixA1+d4TR8kNU8vvk4PjlqAbdPDJuaNIYfSRwULnyRDpIGmYR26ixX73Nlu5H6/tiaw0PWBStVW99XuFD+4Yd1NWRRhyHlVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by MN2PR11MB4535.namprd11.prod.outlook.com (2603:10b6:208:24e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Fri, 9 Aug
 2024 13:14:35 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%3]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 13:14:35 +0000
From: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"hawk@kernel.org" <hawk@kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"sriram.yagnaraman@ericsson.com" <sriram.yagnaraman@ericsson.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"benjamin.steinke@woks-audio.com" <benjamin.steinke@woks-audio.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "Rout, ChandanX"
	<chandanx.rout@intel.com>
Subject: RE: [PATCH net-next 1/4] igb: prepare for AF_XDP zero-copy support
Thread-Topic: [PATCH net-next 1/4] igb: prepare for AF_XDP zero-copy support
Thread-Index: AQHa6cHmDNXZGyOZG0a40HNFQVyac7Id0kkAgAETwwCAAAJt4A==
Date: Fri, 9 Aug 2024 13:14:35 +0000
Message-ID: <IA1PR11MB6097C23D38FDAEA5B6A72E3882BA2@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20240808183556.386397-1-anthony.l.nguyen@intel.com>
 <20240808183556.386397-2-anthony.l.nguyen@intel.com> <ZrUsuq1vanahPyOd@boxer>
 <87bk21hmnl.fsf@kurt.kurt.home>
In-Reply-To: <87bk21hmnl.fsf@kurt.kurt.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|MN2PR11MB4535:EE_
x-ms-office365-filtering-correlation-id: 50a7e24e-4bad-426c-4121-08dcb87536e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Qt/kF1iQ6KWqdqghKYcCakt+LuQvRggFW5MPbHLPITDsvamGkHo+DdU0T0GK?=
 =?us-ascii?Q?H0OSysou6eX70MXIHlZv8Xiyl/FQf7zI+in4RMsVDKEZ5dcT4+I95lJOaKtg?=
 =?us-ascii?Q?DKgO1iEAHSQYuSk06vcuZ9oEYOlu78i7343J/QBfoC2jduhtre+aYzjSNgUe?=
 =?us-ascii?Q?UgLmADnZC++PZf53ySv3acPVk4SQ8G2bqYWrOCv6p/50tQ497BYHUf/glHbH?=
 =?us-ascii?Q?Ra6RUKry3BhbsnrYJYpBaPwiU62VuQAhDAB2aONNhMD8EEPMq/3o7s9UhdsJ?=
 =?us-ascii?Q?vUsAScyU73XNhyKoycwyGZyXMq+dVE/1Q3R+lo37j8b9N9J/Q3wOze1achEe?=
 =?us-ascii?Q?e4gpAtulqCZGmpNZj63MGTvWi2D3Yc43/8zpHRBquxyAjEhuCUo+8XjodSBI?=
 =?us-ascii?Q?QrUt0noWxN3EiSnZq0E2fwTQikACR66Wp4i2w9YnZ3YLsQejFG4hqIb5zWSh?=
 =?us-ascii?Q?L670yLsZbXFELJtPPwVN6roycoKjdDKq2nVhbJVyBp/81kztxIWJQqrlvJoJ?=
 =?us-ascii?Q?9LgN7cjTPfV1F6oQmYULlMlcROVTVLHr5LKLwv9c+21ccx+u5DginWlxmFfW?=
 =?us-ascii?Q?fU9nKbnlJZDraPyYsbMH1sHanm9ACYDQfCexinJH6n9V/Zapb0q1ZOHLlgDn?=
 =?us-ascii?Q?EExsdJABL9wL9gBTpKrG2pxyE9rAN23XZECmDtHyA3+jGDKwP/yHmTlz7mMv?=
 =?us-ascii?Q?ggoiFPISnoZrcBH52G6a+Lvu22u3u3Pimb432SmYE1BGdGSXT4w4pYT2mYX5?=
 =?us-ascii?Q?eTSCQG3lq9CaHcAVrU/XUotZ+VVM/SVRe9BaZ3DPsYK/Z4GyckSng16sj/o7?=
 =?us-ascii?Q?20TzvU4t1/TeoSuCDjoKg8vkKttDMdaBOq+zDOceS7Pt1sgpJgW/rQb30jhg?=
 =?us-ascii?Q?ybVhPujMEmqBm7uOSRjz0I6cUTHa7ttouU6UuPp/+OwbNq/nci5UAZDih3Ze?=
 =?us-ascii?Q?vENtZ00833ikGMO6VRoXC8LwSUG4E3bW7CjxCStvSb2r299r3Wt9Hfb2Rxy2?=
 =?us-ascii?Q?h0QHlFsskYoTYRXd9NmZoDl5uZ8PDnKETrQlhSYAhBCb8mveTS/dvnrJn1rg?=
 =?us-ascii?Q?pBFbf3Hn+jciSV0WmaQ7Q5UFZUjtKDy8cufrSfT/1tnv7K6nkX1GH7IPuUIn?=
 =?us-ascii?Q?Ukn6+Fbn7c8xhjEGwZK8xhWFUAhfBuYhz8eSbx68yYvoGD/WD8phIY+/mr/B?=
 =?us-ascii?Q?1bFDMM0H9VFtrLwtZb5NmuIvBFuDMJvDdu80dblDlI4oUrsPFY+uhjXwU+Mk?=
 =?us-ascii?Q?nPPSoFszywem/lxzLqvDKutCogDqHYNnq7kT6jGL9H1OLKZBmlg/iedF7V10?=
 =?us-ascii?Q?xSZ4CvIgGqKRor4XDJaI4AyQvWM3/jJMYVOUX8qDYDUa0Se7LigeEc6CH6bG?=
 =?us-ascii?Q?HMVLdOYiScbDehAs0Leag4M5mQ91FG+/NQe78lXB40ae29FZGA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7BL/GBNyjxG4/KyR3XRA6io5JmTrtkJt2T9+3skaprxbUUPvE9ip+VlAd82s?=
 =?us-ascii?Q?F1OtV5waJOZv7nqw83kKT0KAxe6S5s9rbwZ62sI2SPKCd6Wwm+0qW/JcbBcx?=
 =?us-ascii?Q?OV2QzjEP61TuQ+yD2u887B8xcEcxFGo2TnmjM/hXDnnNsxX/0iH2ra30F7Y/?=
 =?us-ascii?Q?IPgkCCrUc2cnkxWgtJ3ztIGzIZHc6K65e0Ez2OZu7dRVH7HT8QzeshRh58Sy?=
 =?us-ascii?Q?sjx4fpA39efXtgSP1NiUWAM4T9InIFnbZtzL87wirTtqwBXQvl/+zg21ISsj?=
 =?us-ascii?Q?SXnos1jvoasDUzWufqLDP60Wc+GmXgYMhnfh7HjlKLOE+YIYz3UH0Dpzyya0?=
 =?us-ascii?Q?gLvQo6et1C3zBy8AOiH5rHPCsWkijFG1tmIGca+sNUSzm3mx2PnR8odh7eRx?=
 =?us-ascii?Q?Ix+XHnpfutvyMqja0BFJJccfipRqNy4f+0CUyhbLMRC6NBEv2TJQSizSytRp?=
 =?us-ascii?Q?PKUrWduLdKtmGT2McpWaSh1rFeAVNyVI2Po0pPFjPlc6C8RqD5zL13jQKbre?=
 =?us-ascii?Q?mpRYkYeEfsfWqMa1vjtd8wPkR5PQ+Wk4/jmDxlRpG5vaO6t09xqdYjrLmfgx?=
 =?us-ascii?Q?g3hj6jAfFCndsm6Vy40cFWHluVq/Xz7nhi5tpA77WeBc7aQ8ualoWY99xIlb?=
 =?us-ascii?Q?CMh53mw/6aeFBqs1KbUwGWTSc1k+F3Q8/WZH4PnBuG12RvrNVexCZ0mHEPkW?=
 =?us-ascii?Q?GKcjWZsLZl7lp+rvnZHjRlkB6r4nP7Dd5KDKr6h2zEpvsLhJobtCJ5l65aoR?=
 =?us-ascii?Q?cecLdLKH+IuijveNR//D7rIlgI2v1OJ5GvcjK7s/wvm1rJdzR/rQbTtmRzEc?=
 =?us-ascii?Q?wG6qozxYVTmxE/JSG62ZbQfJ1MZsexA3Q/XziTD2gQo1FIuDVC4Jh0wxOdCD?=
 =?us-ascii?Q?z2bxPd4FKDwMjMnzJhJagBur47QxE9QDI9PK9//TOBfpc1KNczoqIICH/aLg?=
 =?us-ascii?Q?aif2CnaAqpBV1Y7AlBGfdzL28c8GCl9kowAIKMiy9EXPZcY1EcWMe0uBu/jF?=
 =?us-ascii?Q?y3OPtBDiJKxkF6tyDOTKXtjZBxvaQ89QatMbrJoC8uSZLZoW9S/e4ViQ/HL8?=
 =?us-ascii?Q?RcWuVRB88wFhzPOVo3pt55EMa6fOUxq/1tU6fTx+lJqRE77pFHTlZ+jlEGRz?=
 =?us-ascii?Q?TKUalnnQ2RbaP37JiBK7DhJQo8xZYEunXpQuE32MSZrH1h5wNFLlZyf2CxDd?=
 =?us-ascii?Q?srtGX41eBMfpuQxZYNsMQmp1zQQ33TLsn62SAiCyt5VQxP7HvNx7vocUWkQE?=
 =?us-ascii?Q?So5C8t3Bf17/yNYA5iHvh1dOAgrqCfKPw4n7dyafFQfyCQ63sUfJ6PnA1Cs5?=
 =?us-ascii?Q?XPshsvXE832VTiTEdhYF2VSSG/M2xsgaQvRPP3YVeuYGwpnT6P9k0xBQ/tmY?=
 =?us-ascii?Q?VrIhXYtTVcAbiXyX4aqe+U0zzm6lP30CboMDQAgfvgkwXhmL9cOq0AMkl2jo?=
 =?us-ascii?Q?jSoFXafXW3u8UWftNd0MVxV9VwepxbUT2wVF0IdDV2cP3SeOwgjxwpi/khwN?=
 =?us-ascii?Q?8a4lOVzMHJw3qX3tO9JKEUnTjfRTV5dOefxC+vyIJk3Bktlonzmdrad66hQm?=
 =?us-ascii?Q?Cz+mybykbL3ZwY/i0ImyZXlB7XLcPLoXK5Tkr7kW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a7e24e-4bad-426c-4121-08dcb87536e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 13:14:35.1159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W9iH8/VfSJweNtzhkGcwy8MPYReDtkf+7Wtr9sxbgf6ZnKYo3kce210Nab8s5TjKGm3DaeG406rypnRpv98gGhi5fyTQtGEvdeaAAeoyJbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4535
X-OriginatorOrg: intel.com

>=20
> On Thu Aug 08 2024, Maciej Fijalkowski wrote:
> > On Thu, Aug 08, 2024 at 11:35:51AM -0700, Tony Nguyen wrote:
> >> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> >>
> >> Always call igb_xdp_ring_update_tail under __netif_tx_lock, add a
> >> comment to indicate that. This is needed to share the same TX ring
> >> between XDP, XSK and slow paths.
> >
> > standalone commit
>=20
> Ok.
>=20
> >> +static inline bool igb_xdp_is_enabled(struct igb_adapter *adapter)
> >> +{
> >> +	return !!adapter->xdp_prog;
> >
> > READ_ONCE() plus use this everywhere else where prog is read.
>=20
> Sure. I'll send v6 to iwl then.

I'm in the middle of going through rest of the set, will finish today.

>=20
> Thanks,
> Kurt

