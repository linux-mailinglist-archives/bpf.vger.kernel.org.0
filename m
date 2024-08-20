Return-Path: <bpf+bounces-37629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC57958700
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 14:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C819A1C20D47
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 12:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF2418F2F8;
	Tue, 20 Aug 2024 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6i/m4Vb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6EA28FC;
	Tue, 20 Aug 2024 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724157132; cv=fail; b=GT6A8z+gfo1nYM4Jjosb7mCdVvQs41B+siF5yEWjN75pY6UBZnwU5QiVRKb4faQa6Xem35TeNwHJ0QLYc8tbJ1tXjRLB3w+7xvtT5VYrZ1OIiMpgbBYMwzJoyCVIRMKb7ZG6m5Al9MPbUAnYvOABm0Kg7UXMvIYFmY/Qa27vd2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724157132; c=relaxed/simple;
	bh=pK+ANoFa954jn/j2UiCh2szHMrvJDguk6xCH66rx+gA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TPrdkAi/8kvSVmQTFXsTfHOiiCWyCi46TnkTjj/DWwCFkTuarr6NnUXyl+yHi1ZvbezDaa4p/Ps+0AzC4GZoNUMdaSd7LQK/5MH60jyVvX5aaF93qOOBkgUYNeFD+YS8d0tZSDxp9VpH/diRgaFTkPhIeav07FDDJkxgzPzKuNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6i/m4Vb; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724157130; x=1755693130;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pK+ANoFa954jn/j2UiCh2szHMrvJDguk6xCH66rx+gA=;
  b=c6i/m4VbsHFGUyumBboTMApGlU6rmiVduL9Q7YNj5PbTmWmjmWen/v6w
   E870mZWzii6mVpj5elXI4C55vS4OHEXqURMaPAdIHl8LIB2wwUU7Go8RT
   x9JQuvnhcYtINTa1kzKL6KuaW0zyse2rAvqzDsPuDl54EOxvt54wxtsM4
   wmkv24AUvz7i3J67oS7PnfJQ7qOVUJR1NS4o3zj4RvxjPDiOMj5vrSers
   qmWPDxoaZYo2c9V1VZ2V6sQ+GuJ0cIAoYbct8wYlEOpO2TM+VNlkqVMeS
   j5Bd88aoeJdkj/Lj+itgWvR3MKhyD1LDLsnOVLkR5TA7OG0WZC+9qcQQj
   Q==;
X-CSE-ConnectionGUID: uurDOs1ESkCI5CS/1Ln0Kg==
X-CSE-MsgGUID: 6AFeSB1xQ86KBUkss6SDKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33840283"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="33840283"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 05:32:09 -0700
X-CSE-ConnectionGUID: 7qWv80PqQqCdvMCuR/dptg==
X-CSE-MsgGUID: r3GuCBBCQf2LlKinjD97ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="60769826"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 05:32:09 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 05:32:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 05:32:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 05:32:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avDSCejhqvxnp6bCz+bhyYc5FSBBB3tCjOmzZ0+Ml9UF5Fnvm69g8AX4w7qeOAKV3/837eeYLIN63EQvXcjje/QVu7GNVl6O8BIISfZHGLTO7FTHnMc1w5TQM0yAlJGdoxFmaAqXqHf0f/KHvEJTmYBnxvxMBpTjOGb5WbHW82u80Z2akhzfZxNI8flqMEOyCE/7lQkJkdgBbmBwWWnTg/+F2RfeqrdNUApa215JnnM7CsMy5tuz+DKPb22XSdXxnN0cii5xDQ9ouiUjQCtfvDfh8XKRfdqM/xb7pS0T2FJd4dpxN0ke9XXvTepTKfCoarY16XTqWtQnT0Uv00QdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vh49+p4/tflpGp0ZPrAklIwV4q9lxH/LnHn05vvFEq4=;
 b=a++skO1C8Ls4brma5cEydgCh7QjYKOvDxMjCxFlsaE0uNOoz4irrzBiXI9DPX9KPi9iSACLUL6+FrIToUotY+GX6OkfJ+iI95XLo9ljcbAfm/xqtYmLH+G8CfjTG/gKEErq6ixpa+NqPG1JtVQ/20I82Rx8TMr7aoXnDqZgIqRxzwEaJ8R5gwLw0TfU6v+WrhO24yNAZbXib7KBtSnEukJ/oqJRCqFSjqDzPrIe71PLERFaRir/LhSty6ckjWsFgYPC/z5xNZplZD/upvN7uCpHkHQEx2V08wcqSu5DVmpSq5BNknRwBuz/cpgggQGGBsPaqfYl5jJVaOc4YJlH4hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB6194.namprd11.prod.outlook.com (2603:10b6:208:3ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 20 Aug
 2024 12:32:05 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 12:32:05 +0000
Date: Tue, 20 Aug 2024 14:31:51 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Jacob
 Keller" <jacob.e.keller@intel.com>, Eric Dumazet <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, Amritha Nambiar
	<amritha.nambiar@intel.com>, Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: Re: [PATCH iwl-net v3 1/6] ice: move netif_queue_set_napi to
 rtnl-protected sections
Message-ID: <ZsSMt3O4a+Jq0e65@boxer>
References: <20240819100606.15383-1-larysa.zaremba@intel.com>
 <20240819100606.15383-2-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240819100606.15383-2-larysa.zaremba@intel.com>
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: d42b6b0f-0978-44f7-6a36-08dcc114198e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QlgS9izXQ2doUBlqb2k8Mmo7pJcL/IML/nDJRL9lescTg04hyYgY/FOoD37M?=
 =?us-ascii?Q?lDIY8KeCFg641vzfCijio9PV/QOpP2TQdztxTr56nUYMQfnN78Fd+xK1OvCN?=
 =?us-ascii?Q?Vixr7YNrOqi9jlGGyeASD+WVMAgt5PTXHakZD0DgYofnErZ6uhwhDYp4Nsn4?=
 =?us-ascii?Q?r5HmEwiJ0yl0+oXXEGX5t74IJ19LZ1m2QsmUWUkH2JQM+nkwMI1WSyHznu+r?=
 =?us-ascii?Q?nz0aMvuo6Woh2M6pyOFqgH/kJd+ebcuYbWW7sQKdj9kbRVjItDQopDvTq6Em?=
 =?us-ascii?Q?WYLUW56GE10nckG+UMp41VI2JMJBdoXKe2ssxkr08BAgKyhT4gJfaYtEmm2m?=
 =?us-ascii?Q?OUKutWMi6O6Jx6veqY553AXWS1P+h82RU3FZKL6pq0g3N0+kSxtxhc3bfV7J?=
 =?us-ascii?Q?Kx54oCQbiK4FY+SIobB9TW2/EoJC6X4eitSD6BdDFiyIG7EjPwt5EesoBGRX?=
 =?us-ascii?Q?5dwkfpWTw9Jrxk/L52gRKNRgZkHue2GnuDDgZV58t3SPenkEidqwqm4NIkiQ?=
 =?us-ascii?Q?c2N/VnpECIWu8JdADF9TQQbUoYSSSgfA6jzKV5dpVhASGii5oOpbOBJBJhrV?=
 =?us-ascii?Q?mzBOHIe8HyemlvX/2bqC0dKaSpKG9f85o6Cg6IusiDAtZOVHvAhIpnm5oof/?=
 =?us-ascii?Q?QUzvu1Q1cLxxg2y/my/aR2+PdNIMeFsi+ePLwG/MZ6+Szcn6/gdn1eBAfC8s?=
 =?us-ascii?Q?lPe6ChhqWPV2DOjoff8Nk7HgQV1bVNvtNH1TCG3eMVHjo8ebw8MMxqW4kxFo?=
 =?us-ascii?Q?HrwcUGiqQMkxynoRUBdTgEDxM2eS8YkL8c+Z+JfQ5+dx4ik4UDRAlDJRRKMq?=
 =?us-ascii?Q?9z4u9HqOmSbnWjOdOczsMHLZmo3mPetOlDFnZsfrLnknl3l0RxtT24eQWFD+?=
 =?us-ascii?Q?iJxr1hwxAfLnhSScU28ejkgcg9dWtqV1d2LpEJGXrvE4gZ2PBxLeAio0bgUW?=
 =?us-ascii?Q?kwbV7cwjriERE85UseHfvkXULKLGDMakOFm9l2QATZulGX3UJ82z8yShWbxW?=
 =?us-ascii?Q?kUrxZR6xo4HXg8nYbJ69tjBqO6TazrbiaN/afU3Wxv6JP28NjDMlpq2wJC47?=
 =?us-ascii?Q?JN7CppI3TnLxV/VuHLAhbWGqWC45vXcagF+AdT73Hmx/6LOhyERuEdfRKu80?=
 =?us-ascii?Q?+YQ0LsJLeBSn//tIAASZ4/lL5O2f51v7i5XDbhBHreBZMZPpqXZriTGGuXFY?=
 =?us-ascii?Q?IpRgltOQpUG85OZytbnO46ju8GbrMjzJiHaRQX/DqpIBxYazQlHMk7/NRVlr?=
 =?us-ascii?Q?wUUEyJCU9fYbJUpv+JcFh7n7iNuuPV/6umcNN0Tznk4sWP0TT0FK/KgRBe//?=
 =?us-ascii?Q?trYKqx0Av5eCHwXBgICQ8s3sEhtCOkVaYBl3blZb5LvyLQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BjO+U63D/8NXS7/nauKubl4ZlgCCB+gU6tCaSmeGrORkjhfpk2JzgMpZvgoz?=
 =?us-ascii?Q?rIjd9nuzspOSUWRchT6TQGNcxNhvLu4s138A66nFcCEZJ6s8hfuQRwCbsspj?=
 =?us-ascii?Q?v9rz28h6xJRHYIeGgVd/ild8P3A6n0/tLBuXBXwmiHuUF0roa8LtApYii8+W?=
 =?us-ascii?Q?dU6380RkFGfg/Q8nkfbnyvLAUY08D3QIrZNvtNwo17TjQv32FqAYhoxpilpA?=
 =?us-ascii?Q?xUQ9n/t158+FjzfSMJB88OEV9Gu572T0smLYGAWicTRbvLOSrT1hNqj3cZ0E?=
 =?us-ascii?Q?rTSgLzLjFdRrDuSy7dlBL8/QyJ3nHfrY2fWXTelwt8vRGQYjo38P/L/QXj9T?=
 =?us-ascii?Q?xLD6BIazsNQMpjvhpbaCy61QvZ4XYzKD2advhHYunut/S9yuTGOP7A7ysbOp?=
 =?us-ascii?Q?Nuhda36fQZEm3eu99BxL3Mw37ppb8vCb7KVleboxoe/4QtefLLh0B+3XoyhM?=
 =?us-ascii?Q?RP1iq4x9AVvJHta87CGQdMQu5RDKgM9ByiddMXpIMm5DA+L4ARTTmv2WzQz8?=
 =?us-ascii?Q?YgBldy3oFEhBBokDLjsH7SpYTk9GheN9k/EGQ6wYFTtfXYOoCGVAQI0bHgwl?=
 =?us-ascii?Q?mg9HSx5yOMMHJs7YzcQCtpW8Z+/IH81SlDLPsIakEAV6sPoTIL87g0pUL+Z3?=
 =?us-ascii?Q?s2zSlF0Ld7oGLfuG0LN2PF91T+hhkUIhML7/or+dGRCm4sj/iVq8D7L5Sgl6?=
 =?us-ascii?Q?WIjA/TeVpQcHtP96zqB7ohGWWXjaLG4ADCUO0fY06gm3ucb/BrK+8HBA1kMY?=
 =?us-ascii?Q?e5g+VH2+vou0qqsF7jqDUYuM3EyjPOmVhYYqhg0wTn74yehhnBXWjnbH1+kw?=
 =?us-ascii?Q?wA41XnbpPukiYHMJ9PbxRcnWT/kAcoA3lVzEMaviSepjYTHgJwtr/VxdZQAh?=
 =?us-ascii?Q?tkGHIugoOpp+/ZJp7aug2EXHeriNGjX3KGjHi/ulMTySsNQrr9x8oaimktkj?=
 =?us-ascii?Q?6qPVVV8YA6c+3PZei81kd5f/cltLzgOOed3zS7e+NVD63KVt0mjrGE8heGWZ?=
 =?us-ascii?Q?vKmFbIWzuPgE/JOvnJ+GYP/gTMQ39/NZxCXxeipvL+vWW2mRukTOLuIi9H3+?=
 =?us-ascii?Q?MgQ6T3aFLSrETEdZAR0VAg1WBt01oKVnzmOXbMPruSd2/7wNQSzuo1Ssf6N7?=
 =?us-ascii?Q?5JbDaQAaF8LJK0wkx4Yl/9rjxuxxGe0rV1XAkCim3LasqlY3/DQbU597Dpde?=
 =?us-ascii?Q?LG0ttdY7akG8qGHYRiE3dz9Gpat3JbxfFbPsY7s9nOw+IXDeZeQV0e4pCDwr?=
 =?us-ascii?Q?MpWD8jzgBR1PJHhNxA/q7MdbV80DfZsJtG8TrpQNN2ap3EvCwowcul7g0Gvf?=
 =?us-ascii?Q?PXcMPJ8bYOLiH7NRY+ytn03CQn9kbxSLwRLxlqTwabYvvam+jE/M2EASpNFc?=
 =?us-ascii?Q?poVVI+/IZB3jJXI0MJtmkIv81k2Ba0M+7BVlAi0hSShu+byho8be1m/C878V?=
 =?us-ascii?Q?G5QeSRFmjfdEtBtF9KPqYAInUE4e21LjaWeVs7c4e1/L+XhhI18sTOzI4ELR?=
 =?us-ascii?Q?5MsPjcgOxJ/r8bgn6z/guPZQ/nnrZWFja+l4OxGizwEFNJDKc64RDirBSIJp?=
 =?us-ascii?Q?pnvcqbQ0R6bCTqol//nCtQvHEkyvsTocRv91V1q1PYTDubKCve2M7TOBGTka?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d42b6b0f-0978-44f7-6a36-08dcc114198e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 12:32:05.4023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8SRWEdr8EU2Kay7TncQZOEPvTmUy71rVJSN7prYzJrRNzHFuuDzUufGewcs75ajYRSnDsKpNbebyvVIH1Lgt3vIDwgKeJpa2p0CEnt6Wfk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6194
X-OriginatorOrg: intel.com

On Mon, Aug 19, 2024 at 12:05:38PM +0200, Larysa Zaremba wrote:
> Currently, netif_queue_set_napi() is called from ice_vsi_rebuild() that is
> not rtnl-locked when called from the reset. This creates the need to take
> the rtnl_lock just for a single function and complicates the
> synchronization with .ndo_bpf. At the same time, there no actual need to
> fill napi-to-queue information at this exact point.
> 
> Fill napi-to-queue information when opening the VSI and clear it when the
> VSI is being closed. Those routines are already rtnl-locked.
> 
> Also, rewrite napi-to-queue assignment in a way that prevents inclusion of
> XDP queues, as this leads to out-of-bounds writes, such as one below.
> 
> [  +0.000004] BUG: KASAN: slab-out-of-bounds in netif_queue_set_napi+0x1c2/0x1e0
> [  +0.000012] Write of size 8 at addr ffff889881727c80 by task bash/7047
> [  +0.000006] CPU: 24 PID: 7047 Comm: bash Not tainted 6.10.0-rc2+ #2
> [  +0.000004] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0014.082620210524 08/26/2021
> [  +0.000003] Call Trace:
> [  +0.000003]  <TASK>
> [  +0.000002]  dump_stack_lvl+0x60/0x80
> [  +0.000007]  print_report+0xce/0x630
> [  +0.000007]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  +0.000007]  ? __virt_addr_valid+0x1c9/0x2c0
> [  +0.000005]  ? netif_queue_set_napi+0x1c2/0x1e0
> [  +0.000003]  kasan_report+0xe9/0x120
> [  +0.000004]  ? netif_queue_set_napi+0x1c2/0x1e0
> [  +0.000004]  netif_queue_set_napi+0x1c2/0x1e0
> [  +0.000005]  ice_vsi_close+0x161/0x670 [ice]
> [  +0.000114]  ice_dis_vsi+0x22f/0x270 [ice]
> [  +0.000095]  ice_pf_dis_all_vsi.constprop.0+0xae/0x1c0 [ice]
> [  +0.000086]  ice_prepare_for_reset+0x299/0x750 [ice]
> [  +0.000087]  pci_dev_save_and_disable+0x82/0xd0
> [  +0.000006]  pci_reset_function+0x12d/0x230
> [  +0.000004]  reset_store+0xa0/0x100
> [  +0.000006]  ? __pfx_reset_store+0x10/0x10
> [  +0.000002]  ? __pfx_mutex_lock+0x10/0x10
> [  +0.000004]  ? __check_object_size+0x4c1/0x640
> [  +0.000007]  kernfs_fop_write_iter+0x30b/0x4a0
> [  +0.000006]  vfs_write+0x5d6/0xdf0
> [  +0.000005]  ? fd_install+0x180/0x350
> [  +0.000005]  ? __pfx_vfs_write+0x10/0xA10
> [  +0.000004]  ? do_fcntl+0x52c/0xcd0
> [  +0.000004]  ? kasan_save_track+0x13/0x60
> [  +0.000003]  ? kasan_save_free_info+0x37/0x60
> [  +0.000006]  ksys_write+0xfa/0x1d0
> [  +0.000003]  ? __pfx_ksys_write+0x10/0x10
> [  +0.000002]  ? __x64_sys_fcntl+0x121/0x180
> [  +0.000004]  ? _raw_spin_lock+0x87/0xe0
> [  +0.000005]  do_syscall_64+0x80/0x170
> [  +0.000007]  ? _raw_spin_lock+0x87/0xe0
> [  +0.000004]  ? __pfx__raw_spin_lock+0x10/0x10
> [  +0.000003]  ? file_close_fd_locked+0x167/0x230
> [  +0.000005]  ? syscall_exit_to_user_mode+0x7d/0x220
> [  +0.000005]  ? do_syscall_64+0x8c/0x170
> [  +0.000004]  ? do_syscall_64+0x8c/0x170
> [  +0.000003]  ? do_syscall_64+0x8c/0x170
> [  +0.000003]  ? fput+0x1a/0x2c0
> [  +0.000004]  ? filp_close+0x19/0x30
> [  +0.000004]  ? do_dup2+0x25a/0x4c0
> [  +0.000004]  ? __x64_sys_dup2+0x6e/0x2e0
> [  +0.000002]  ? syscall_exit_to_user_mode+0x7d/0x220
> [  +0.000004]  ? do_syscall_64+0x8c/0x170
> [  +0.000003]  ? __count_memcg_events+0x113/0x380
> [  +0.000005]  ? handle_mm_fault+0x136/0x820
> [  +0.000005]  ? do_user_addr_fault+0x444/0xa80
> [  +0.000004]  ? clear_bhb_loop+0x25/0x80
> [  +0.000004]  ? clear_bhb_loop+0x25/0x80
> [  +0.000002]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  +0.000005] RIP: 0033:0x7f2033593154
> 
> Fixes: 080b0c8d6d26 ("ice: Fix ASSERT_RTNL() warning during certain scenarios")

Shouldn't you include:
Fixes: 91fdbce7e8d6 ("ice: Add support in the driver for associating queue with napi")

as we were iterating over XDP rings that were attached to q_vectors from
the very beginning?

> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c |  11 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 129 ++++++----------------
>  drivers/net/ethernet/intel/ice/ice_lib.h  |  10 +-
>  drivers/net/ethernet/intel/ice/ice_main.c |  17 ++-
>  4 files changed, 49 insertions(+), 118 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> index f448d3a84564..c158749a80e0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -190,16 +190,11 @@ static void ice_free_q_vector(struct ice_vsi *vsi, int v_idx)
>  	}
>  	q_vector = vsi->q_vectors[v_idx];
>  
> -	ice_for_each_tx_ring(tx_ring, q_vector->tx) {
> -		ice_queue_set_napi(vsi, tx_ring->q_index, NETDEV_QUEUE_TYPE_TX,
> -				   NULL);
> +	ice_for_each_tx_ring(tx_ring, vsi->q_vectors[v_idx]->tx)
>  		tx_ring->q_vector = NULL;
> -	}
> -	ice_for_each_rx_ring(rx_ring, q_vector->rx) {
> -		ice_queue_set_napi(vsi, rx_ring->q_index, NETDEV_QUEUE_TYPE_RX,
> -				   NULL);
> +
> +	ice_for_each_rx_ring(rx_ring, vsi->q_vectors[v_idx]->rx)
>  		rx_ring->q_vector = NULL;
> -	}
>  
>  	/* only VSI with an associated netdev is set up with NAPI */
>  	if (vsi->netdev)
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 03c4df4ed585..5f2ddcaf7031 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2286,9 +2286,6 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
>  
>  		ice_vsi_map_rings_to_vectors(vsi);
>  
> -		/* Associate q_vector rings to napi */
> -		ice_vsi_set_napi_queues(vsi);
> -
>  		vsi->stat_offsets_loaded = false;
>  
>  		/* ICE_VSI_CTRL does not need RSS so skip RSS processing */
> @@ -2621,6 +2618,7 @@ void ice_vsi_close(struct ice_vsi *vsi)
>  	if (!test_and_set_bit(ICE_VSI_DOWN, vsi->state))
>  		ice_down(vsi);
>  
> +	ice_vsi_clear_napi_queues(vsi);
>  	ice_vsi_free_irq(vsi);
>  	ice_vsi_free_tx_rings(vsi);
>  	ice_vsi_free_rx_rings(vsi);
> @@ -2687,120 +2685,55 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
>  }
>  
>  /**
> - * __ice_queue_set_napi - Set the napi instance for the queue
> - * @dev: device to which NAPI and queue belong
> - * @queue_index: Index of queue
> - * @type: queue type as RX or TX
> - * @napi: NAPI context
> - * @locked: is the rtnl_lock already held
> - *
> - * Set the napi instance for the queue. Caller indicates the lock status.
> - */
> -static void
> -__ice_queue_set_napi(struct net_device *dev, unsigned int queue_index,
> -		     enum netdev_queue_type type, struct napi_struct *napi,
> -		     bool locked)
> -{
> -	if (!locked)
> -		rtnl_lock();
> -	netif_queue_set_napi(dev, queue_index, type, napi);
> -	if (!locked)
> -		rtnl_unlock();
> -}
> -
> -/**
> - * ice_queue_set_napi - Set the napi instance for the queue
> - * @vsi: VSI being configured
> - * @queue_index: Index of queue
> - * @type: queue type as RX or TX
> - * @napi: NAPI context
> + * ice_vsi_set_napi_queues
> + * @vsi: VSI pointer
>   *
> - * Set the napi instance for the queue. The rtnl lock state is derived from the
> - * execution path.
> + * Associate queue[s] with napi for all vectors.
> + * The caller must hold rtnl_lock.
>   */
> -void
> -ice_queue_set_napi(struct ice_vsi *vsi, unsigned int queue_index,
> -		   enum netdev_queue_type type, struct napi_struct *napi)
> +void ice_vsi_set_napi_queues(struct ice_vsi *vsi)

this appears to be called only in ice_main.c. It should be moved there and
made a static function instead of having it in ice_lib.c.

Unless I overlooked something...

>  {
> -	struct ice_pf *pf = vsi->back;
> +	struct net_device *netdev = vsi->netdev;
> +	int q_idx, v_idx;
>  
> -	if (!vsi->netdev)
> +	if (!netdev)
>  		return;
>  
> -	if (current_work() == &pf->serv_task ||
> -	    test_bit(ICE_PREPARED_FOR_RESET, pf->state) ||
> -	    test_bit(ICE_DOWN, pf->state) ||
> -	    test_bit(ICE_SUSPENDED, pf->state))
> -		__ice_queue_set_napi(vsi->netdev, queue_index, type, napi,
> -				     false);
> -	else
> -		__ice_queue_set_napi(vsi->netdev, queue_index, type, napi,
> -				     true);
> -}
> +	ice_for_each_rxq(vsi, q_idx)
> +		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_RX,
> +				     &vsi->rx_rings[q_idx]->q_vector->napi);
>  
> -/**
> - * __ice_q_vector_set_napi_queues - Map queue[s] associated with the napi
> - * @q_vector: q_vector pointer
> - * @locked: is the rtnl_lock already held
> - *
> - * Associate the q_vector napi with all the queue[s] on the vector.
> - * Caller indicates the lock status.
> - */
> -void __ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector, bool locked)
> -{
> -	struct ice_rx_ring *rx_ring;
> -	struct ice_tx_ring *tx_ring;
> -
> -	ice_for_each_rx_ring(rx_ring, q_vector->rx)
> -		__ice_queue_set_napi(q_vector->vsi->netdev, rx_ring->q_index,
> -				     NETDEV_QUEUE_TYPE_RX, &q_vector->napi,
> -				     locked);
> -
> -	ice_for_each_tx_ring(tx_ring, q_vector->tx)
> -		__ice_queue_set_napi(q_vector->vsi->netdev, tx_ring->q_index,
> -				     NETDEV_QUEUE_TYPE_TX, &q_vector->napi,
> -				     locked);
> +	ice_for_each_txq(vsi, q_idx)
> +		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_TX,
> +				     &vsi->tx_rings[q_idx]->q_vector->napi);
>  	/* Also set the interrupt number for the NAPI */
> -	netif_napi_set_irq(&q_vector->napi, q_vector->irq.virq);
> -}
> -
> -/**
> - * ice_q_vector_set_napi_queues - Map queue[s] associated with the napi
> - * @q_vector: q_vector pointer
> - *
> - * Associate the q_vector napi with all the queue[s] on the vector
> - */
> -void ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector)
> -{
> -	struct ice_rx_ring *rx_ring;
> -	struct ice_tx_ring *tx_ring;
> -
> -	ice_for_each_rx_ring(rx_ring, q_vector->rx)
> -		ice_queue_set_napi(q_vector->vsi, rx_ring->q_index,
> -				   NETDEV_QUEUE_TYPE_RX, &q_vector->napi);
> +	ice_for_each_q_vector(vsi, v_idx) {
> +		struct ice_q_vector *q_vector = vsi->q_vectors[v_idx];
>  
> -	ice_for_each_tx_ring(tx_ring, q_vector->tx)
> -		ice_queue_set_napi(q_vector->vsi, tx_ring->q_index,
> -				   NETDEV_QUEUE_TYPE_TX, &q_vector->napi);
> -	/* Also set the interrupt number for the NAPI */
> -	netif_napi_set_irq(&q_vector->napi, q_vector->irq.virq);
> +		netif_napi_set_irq(&q_vector->napi, q_vector->irq.virq);
> +	}
>  }
>  
>  /**
> - * ice_vsi_set_napi_queues
> + * ice_vsi_clear_napi_queues
>   * @vsi: VSI pointer
>   *
> - * Associate queue[s] with napi for all vectors
> + * Clear the association between all VSI queues queue[s] and napi.
> + * The caller must hold rtnl_lock.
>   */
> -void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
> +void ice_vsi_clear_napi_queues(struct ice_vsi *vsi)
>  {
> -	int i;
> +	struct net_device *netdev = vsi->netdev;
> +	int q_idx;
>  
> -	if (!vsi->netdev)
> +	if (!netdev)
>  		return;
>  
> -	ice_for_each_q_vector(vsi, i)
> -		ice_q_vector_set_napi_queues(vsi->q_vectors[i]);
> +	ice_for_each_txq(vsi, q_idx)
> +		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_TX, NULL);
> +
> +	ice_for_each_rxq(vsi, q_idx)
> +		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_RX, NULL);
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
> index 94ce8964dda6..36d86535695d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.h
> @@ -44,16 +44,10 @@ void ice_vsi_cfg_netdev_tc(struct ice_vsi *vsi, u8 ena_tc);
>  struct ice_vsi *
>  ice_vsi_setup(struct ice_pf *pf, struct ice_vsi_cfg_params *params);
>  
> -void
> -ice_queue_set_napi(struct ice_vsi *vsi, unsigned int queue_index,
> -		   enum netdev_queue_type type, struct napi_struct *napi);
> -
> -void __ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector, bool locked);
> -
> -void ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector);
> -
>  void ice_vsi_set_napi_queues(struct ice_vsi *vsi);
>  
> +void ice_vsi_clear_napi_queues(struct ice_vsi *vsi);
> +
>  int ice_vsi_release(struct ice_vsi *vsi);
>  
>  void ice_vsi_close(struct ice_vsi *vsi);
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 66820ed5e969..2d286a4609a5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3537,11 +3537,9 @@ static void ice_napi_add(struct ice_vsi *vsi)
>  	if (!vsi->netdev)
>  		return;
>  
> -	ice_for_each_q_vector(vsi, v_idx) {
> +	ice_for_each_q_vector(vsi, v_idx)
>  		netif_napi_add(vsi->netdev, &vsi->q_vectors[v_idx]->napi,
>  			       ice_napi_poll);
> -		__ice_q_vector_set_napi_queues(vsi->q_vectors[v_idx], false);
> -	}
>  }
>  
>  /**
> @@ -5519,7 +5517,9 @@ static int ice_reinit_interrupt_scheme(struct ice_pf *pf)
>  		if (ret)
>  			goto err_reinit;
>  		ice_vsi_map_rings_to_vectors(pf->vsi[v]);
> +		rtnl_lock();
>  		ice_vsi_set_napi_queues(pf->vsi[v]);
> +		rtnl_unlock();
>  	}
>  
>  	ret = ice_req_irq_msix_misc(pf);
> @@ -5533,8 +5533,12 @@ static int ice_reinit_interrupt_scheme(struct ice_pf *pf)
>  
>  err_reinit:
>  	while (v--)
> -		if (pf->vsi[v])
> +		if (pf->vsi[v]) {
> +			rtnl_lock();
> +			ice_vsi_clear_napi_queues(pf->vsi[v]);
> +			rtnl_unlock();
>  			ice_vsi_free_q_vectors(pf->vsi[v]);
> +		}
>  
>  	return ret;
>  }
> @@ -5599,6 +5603,9 @@ static int ice_suspend(struct device *dev)
>  	ice_for_each_vsi(pf, v) {
>  		if (!pf->vsi[v])
>  			continue;
> +		rtnl_lock();
> +		ice_vsi_clear_napi_queues(pf->vsi[v]);
> +		rtnl_unlock();
>  		ice_vsi_free_q_vectors(pf->vsi[v]);
>  	}
>  	ice_clear_interrupt_scheme(pf);
> @@ -7434,6 +7441,8 @@ int ice_vsi_open(struct ice_vsi *vsi)
>  		err = netif_set_real_num_rx_queues(vsi->netdev, vsi->num_rxq);
>  		if (err)
>  			goto err_set_qs;
> +
> +		ice_vsi_set_napi_queues(vsi);
>  	}
>  
>  	err = ice_up_complete(vsi);
> -- 
> 2.43.0
> 

