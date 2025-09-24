Return-Path: <bpf+bounces-69502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425D9B983EF
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 06:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A8C2E6319
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 04:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE26A21FF29;
	Wed, 24 Sep 2025 04:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+YrM3D8"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79880199FAB;
	Wed, 24 Sep 2025 04:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758689648; cv=fail; b=fbYBIhOUZgKSV26uNSXfmSUSgxF4NpnIAudn8eJaOKSrSt1zZiUZmuRAMVFQ+kH0BAojBgcpqzukSgRHJYH6jlxthnViyXhZunRjTFQKktUtTjxAjYPQ4z7QS0YZOO45oS1RYHFmZS7Yd+fIVvU1EVrVhfbsyHDBGc7vADi6Gmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758689648; c=relaxed/simple;
	bh=zZ72MvbTfAr6WLUkyKkWLxNQW9s70o4yGZN5wzGUcU0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dLDoqaK3FzYYTX9MDz9A458lotdiQWcu+CNGR6nerz/hoi6UM1LLgOq+ikPoHPeyJKOBsfiNPj6TqiNtpf7AUaloOoDNGmJqidnt1lxZyL4GPVaWczykqNXwWUYRE+tNF5i9pGZXv2odL/eHktnls59LsZf4U8SGcdtPWs80Ktk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+YrM3D8; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758689647; x=1790225647;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zZ72MvbTfAr6WLUkyKkWLxNQW9s70o4yGZN5wzGUcU0=;
  b=P+YrM3D8C3iDjLLD0GNfgTR57kbUO/nieFbPaGfSuzFO2AH6mMEcZ0pX
   aqGZq+HNIiY+RAiA4RRL00RcU6jJn8Vf/h1eWcoBmf9L0JUyOIKy2cmwC
   AUftuHnGVUPtj8xhcvelMWQJ24ecENFM1JFeUnyU66JtCIpB29IECSqjv
   0qyUobGAxARzqbprMz3Lil7wtTBrovXhGBHXqF15mK+5E3wXA//6NZysL
   OMe1H3I0fbOqDun0qa9bjRHMAEjplU8FHHC9ttkG1a5qftRdZKy8/vlGd
   Z5eaKRgjGvjPNDnovHloiy+bAbdUPD/TdaYBeJx9T15mXmJnWpzjPs3Go
   w==;
X-CSE-ConnectionGUID: q/BsEH13TH+H4QZddU8l/g==
X-CSE-MsgGUID: bMHYfXSQTquz3DzcIVm8sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="72403553"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="72403553"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 21:54:06 -0700
X-CSE-ConnectionGUID: rhqMEFuaSx+31hVrmdX/0w==
X-CSE-MsgGUID: jaFueDnURsKnvFh3xA1pjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="176223826"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 21:54:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 21:54:05 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 23 Sep 2025 21:54:05 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 21:54:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lsz1typhUyW5S5z+bRceUNrzD/8zbMAHcvQOB5oMroEdrD6LCZgY8tFWmiN2uTehVZZQ7f18Fl3J+6qfm6X0RRp71UDoQC67n49cxDXq/BPClihMStOA/+JneyewQ9/W22dHXT3IcSlsLIGrdd33CKcuNN0DqkSF4M4Kixxizgsm798md+u00U9UmYLY7y0gKGFQJneqm8Te9Zlgi9lt4QtB/aSaIkASgbNCv+KlkLquJt3xujJLwsXNONI3BiR801DLXjne/o/B4w/XTvw4bR4VZ6b3pcBPJFgcGTXhWpTikFw1dlClYCtc3p7DfhrdIvz77Ifz7JAoDsrfzhO7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNTIgOjwZDsjiJJu0h5tK2azSsCJHn/Ou/C2YuoVzUU=;
 b=Vh5aELgA2gSwgSthDT1wfWypJdthSRWLWlDQKqod9tV76PwJfQ54Hau1+eBb/UHfqUJDIt8RsPuKzRYOgcCjXwAKwaGuPLSErK/Ua+YazCCnW/JS75IJ555gZoT1sA7RZ7q+VM49t86kxboh2iT40cJDS+jEgYq2PhFfKYdUqJzK4M5IKuBHDMQiIbveUovtwhTC9sC0U1WtuBOn1puiquVkXTM9THDyN3344rFKTlfOVa7AuwBgp+BYytxnbwS5KDlcms+Rosmw5K+4xmatOYyR3vCPiUieWjph2eit+xoTr0TmBDbZIzw/aC5UmL8+Gq5XCHDNZ4f59hASDM9fWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) by
 CH0PR11MB8087.namprd11.prod.outlook.com (2603:10b6:610:187::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 04:54:03 +0000
Received: from DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425]) by DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425%7]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 04:54:03 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 5/5] idpf: enable XSk features
 and ndo_xsk_wakeup
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 5/5] idpf: enable XSk features
 and ndo_xsk_wakeup
Thread-Index: AQHcIzh+KxY8Qi6cXU2x7Z5i1dLtQ7SggYRwgAE7UCA=
Date: Wed, 24 Sep 2025 04:54:03 +0000
Message-ID: <DM4PR11MB64554763B7A8B947638BDAB0981CA@DM4PR11MB6455.namprd11.prod.outlook.com>
References: <20250911162233.1238034-1-aleksander.lobakin@intel.com>
 <20250911162233.1238034-6-aleksander.lobakin@intel.com>
 <PH0PR11MB5013765265A0F4D41210A437961DA@PH0PR11MB5013.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5013765265A0F4D41210A437961DA@PH0PR11MB5013.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6455:EE_|CH0PR11MB8087:EE_
x-ms-office365-filtering-correlation-id: b87ad3df-2376-4138-f7e2-08ddfb266258
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?ywD1dwmx3fJ8H1Fxlou2/fa+9hjaQceTi09f+FjYdqmcRP+sXRHMvhucKug5?=
 =?us-ascii?Q?NBpzhNcZhOClxQvTWePY7TnOncvMwwI/WGKpRmRxB6EIZGjZq4ltkds6Sf9Z?=
 =?us-ascii?Q?MnAk8XNqFgjKDGee3QQShlec4nqK21b+9aHElrw9MQ1UuHQaSOhT9NNx7ZQc?=
 =?us-ascii?Q?gUEUisLxcfefMZFI6YAzsFnskRLaVtInuvwfA8gFuLr7poA5mbD9CFKBsNJ0?=
 =?us-ascii?Q?im3w82Ipm5zBxB7XaKV0yOWQPkBhzepmmQmxgxkQv7fbDzrYgHJzBSQH9pm5?=
 =?us-ascii?Q?cl0cc8ISo1kJiaRmpxbvTZh+/MZ8N+2paPd3rVdAam9aqR6zogAtQUFcjVfi?=
 =?us-ascii?Q?PpYGK1Ydj+GwF2wWMUL7MdJGja85m50fInX+gvHYcLOwIUlReJ4S4i9yfybw?=
 =?us-ascii?Q?TRk8eve4chCiB5AU34Ol4IjM1KCxt0N0z4Hx0mFRwzq6L/9Fv6fnQVldghbT?=
 =?us-ascii?Q?DyNGzdxiEK12N578jLO7bB5OSZutvzqdLudoQjt6To982m3MC77eNJxx7ROs?=
 =?us-ascii?Q?wozKAIAzEB8wSXKIYUXQek1V9OGvkgzOS1pEzW9EpKl+MuZq09PE/y4ccvLC?=
 =?us-ascii?Q?Agv+no9bVuR3ClvldkgL4ws3MBS23dksJumFZRxQr4AEShm86g3E0ucXo+LU?=
 =?us-ascii?Q?Mwb9VuLrmeka+wIt7fxgqjXMq1iwPSVLN4FERfqMcQ0FjXhg2FhRhvmv6YcI?=
 =?us-ascii?Q?Qm/6t9JyjVGYGJ3zwQtEyuz7gc+jYuI04asPe+2AsmkROvywq+br6KaOoSHv?=
 =?us-ascii?Q?SAv2ggpdbzmuoHnLwhh5uWXIzteiawCgRwm48VirXt8gJeD94+TTynTLEozs?=
 =?us-ascii?Q?ZGzRoUEQ5n9glvc4VtbvLUSjjo7uWicM18CY1hqSzR1QKNjJhJVxIL4RwMqE?=
 =?us-ascii?Q?/kdSpANSHMUWDeEF1u6jHIktvbjjZBU20MkuIaVakHVc56LxuQJSKRGefgOQ?=
 =?us-ascii?Q?rA2smrKQsH9cujiswX6IpzeNp1XMCmFsMVNUylXZtHwPYBGnxYi6dxa0LJQq?=
 =?us-ascii?Q?CyPJhIvFVe1XIlXyh8jzuwljwUjsDFwAHUOt13SgRJhr1je1jnEoZk67cH0w?=
 =?us-ascii?Q?AMD9iOJgF4ueefLRaAkB++HepJmqZxUJaWzkD1WLEg+nXztnGsppoxnSsRia?=
 =?us-ascii?Q?hahRY1vE+w3gffqR6+WRcEh4sOh1ASFPvTdZiIeuKeUrYFhwzDFXr5lzXc4B?=
 =?us-ascii?Q?ihY4Hgnd3wI0Ib+AFWTe7sOB9JpN9jLvQCr6oSDIEJEArKtzCDoEaT6bChBN?=
 =?us-ascii?Q?+rZc3ngGwTCVYU40q7Wk1gQmH7cM9cY2M6gkWR1YEzHldqKlAcMUnWl3FjLr?=
 =?us-ascii?Q?9YzjEzjhTAnf3PyYYKGWZB4hiZTcukFviu4c4htkuVNFtdoAo0dlkv3QUtke?=
 =?us-ascii?Q?nNd/T/VXX82JRLPZ4pJTPNVTe7Z0YTOeZMnIQeUsdZjpQILNDB17qdaYJp1e?=
 =?us-ascii?Q?ag+O0v6sZrey7KwpUmHc1gs8hloO9frb1ZZLoC/i1aCa0CJkqz48Vg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F5CEUHJKhQroZws5ROkTucUqmZckPY6INO2Ct2mRZs5ti8J6sjc5Cqz4/CaK?=
 =?us-ascii?Q?+LrBbGmQ/NggPli6zHIikq2x3Qn2lWzv4gGTUSzIfJPqO9IBi9AYEQ1bXmIR?=
 =?us-ascii?Q?AZEV6SoWWZq7cx0/wS77dwJ7xRrBgJPI1xQUqEwbC6Y0LgjtKZAiZ+PbXxso?=
 =?us-ascii?Q?5ajWVyiwXffcPReNoOQNOdTWoO95radIUutULDdvTFGNAX0CdsOQAjOnItXM?=
 =?us-ascii?Q?TpBwLUzTi+pW6ooJi91UBUupYbwx6ULFuuzqqFdMbiD9hWzL91ggDJ1OtY/s?=
 =?us-ascii?Q?jOMq6J0Zvcjrhm/SQG0YthsInn4ZSIai5BTKfaCh6A9ko7u7ySDQeB2VSCTf?=
 =?us-ascii?Q?V3mioyqdSg/sjpqFlc1FY5ipzpDGKBAYZ/ddfi6hQrK3hcc8nOFtclMiJHru?=
 =?us-ascii?Q?JiUpafgkrnVtggDYD9rPfB7LESKj+dsWm3RZg4wuYCrWoNEDGnJb9tA30mSQ?=
 =?us-ascii?Q?e/KogWEMtMdeeqpoDWg0mQ0WtSsfPTrYbkC5XxuaYBlAzFqnVmwWG9U7tCDo?=
 =?us-ascii?Q?zNXFhDM6L1NhnxKWhAMqQEhCxxI/BKnP8kq5jtDDLrOVc8TvvhnKeC8OFvEu?=
 =?us-ascii?Q?Ic80sJHwWlt8JR70uQNbnZFNPA2GA7NBN6L+iesg0GLJQlPzapoqordBmK/b?=
 =?us-ascii?Q?jQ+ayInWYI1SRuqwCmqN3SviGYiy3Gn+e9JydnwaD5tgCB9dODHV6DdEeomo?=
 =?us-ascii?Q?4nTLUBNQDet1y5TJRvYbP1y8F/7iBFDSAkfLIzyQrAIgzRHuSts1eAwC4Yac?=
 =?us-ascii?Q?u1H51nJHcLWGTMQCdf+gmpLh/fNevKX9RdEbSLfnOsNwbb+zi/BlUKBrK3pk?=
 =?us-ascii?Q?6kIkqK9XAV3F4XpjJGlt/tzeV3cdfh65gwr+FtIL3y7w24DorCnwM9gQWaIM?=
 =?us-ascii?Q?FdbVmY5b73CkbuUk+4GUvRIp2hjUr9pVlwejnHaRYsMVosi+mn2Cm45fPLhm?=
 =?us-ascii?Q?RK0wJw9MjBDYp78k8BssH+qwSwfMhBPGCg9pLADFToN8cF+J8gMMitqMWCXH?=
 =?us-ascii?Q?/JB71SMWNLWziak/5r3q7vB06SsD7eh1c60f9HDsjw9oQk1ZKprNbS0a+FsW?=
 =?us-ascii?Q?GCC9YO58vYj8IVioo/s/beTgo/BT440chgv8yHu0Gg1ZK13mm/RSrzUljEKC?=
 =?us-ascii?Q?Ls57d/x5XCGAimdCPTGf2Fqc8mI/E4DpOw2GW1K0wMyPF90xIB3VUKbPa9Fa?=
 =?us-ascii?Q?oYwkukgS1u637105EYg+JkMt0hmUfuMp4B4jLk7F0bJSRIZiQtohhXB5qHwd?=
 =?us-ascii?Q?0zHeXvo3XV1edNf9c5r4MKuRYuuq9zNgyAmkybX5R6/Yiw7ZDjDYb8Os2H+S?=
 =?us-ascii?Q?2M+BQaECIhUQBN6O0CJMqnbcnYvOlQQNBS0TEftUPsCMW/0SJi5W/bFNPfL7?=
 =?us-ascii?Q?nMEf+lAfgB6wvw4UPdD2Drf9vVomx1gLc1bR5GAakFI0Kaj2SjuqD6hFGCXL?=
 =?us-ascii?Q?NNBPGmqAJaelzz9T4meKzghHy1Jgq5aRaE3IQ+cWIlTXCk2sWzO1u7Q8Mnre?=
 =?us-ascii?Q?Tbj4S6CiTn23apGYSI53lmSRLbpp3oYYFkYzBHvetIVkywou9bf2VkM9x5zo?=
 =?us-ascii?Q?kfo7FDDM+/LseyKsA9M=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b87ad3df-2376-4138-f7e2-08ddfb266258
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 04:54:03.3530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lSiSZEtbjMgTucfWrU0MjBXRG1TnlvBuX4PdOfQX4QEBXv3d3RbRPWV/+1tBqj164cEiJXL7BRUtVKZTFLtdAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8087
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Alexander Lobakin
> Sent: Thursday, September 11, 2025 9:53 PM
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
> Subject: [Intel-wired-lan] [PATCH iwl-next 5/5] idpf: enable XSk features=
 and
> ndo_xsk_wakeup
>=20
> Now that AF_XDP functionality is fully implemented, advertise XSk XDP
> feature and add .ndo_xsk_wakeup() callback to be able to use it with this
> driver.
>=20
> Co-developed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h      |  7 +++++
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h | 10 ++++---
>  drivers/net/ethernet/intel/idpf/xsk.h       |  4 +++
>  drivers/net/ethernet/intel/idpf/idpf_lib.c  |  2 ++
> drivers/net/ethernet/intel/idpf/idpf_txrx.c |  3 +++
>  drivers/net/ethernet/intel/idpf/xdp.c       |  4 ++-
>  drivers/net/ethernet/intel/idpf/xsk.c       | 29 +++++++++++++++++++++
>  7 files changed, 55 insertions(+), 4 deletions(-)
>=20
Tested-by: Ramu R <ramu.r@intel.com>

