Return-Path: <bpf+bounces-37861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C58A495B5FA
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 15:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67901C2340D
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 13:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CFC1CB306;
	Thu, 22 Aug 2024 13:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kfizw5vQ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEA61C9454;
	Thu, 22 Aug 2024 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332050; cv=fail; b=m561eMdiaRwaiMtIMs01vJWHWlzZLNl3mTp74dKkrhBnuof8UYvntXDq9px/0m+TuncxW++M8MsdlPeQMLDGzGpKHiV83L+kpaquip69TcBvVgLtXbqiSW409k1E+OmYAzQuQrF1+XnTcSRbJqdJM9dEMn5v6MUAPdHRheSEuzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332050; c=relaxed/simple;
	bh=atnWrEhI9I15MA3Lp/tIk39t0ZE1V84y+MlZ3WewauU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EW7sNtvuGhXS1mUwvp9ESsBu7ms2gFtYfWXJHEroTYcFPe4c5VuAmtjkoTqR5DglOVXpvQojBy/RA2m2w6G69tvQpeSvfuWwqSXn0toRHK1LgF0d5gJBA6h+/xhzoYEndCqcK92aru0s1z443QYK1HJo4IDZkS9HvjP180jUo/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kfizw5vQ; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724332050; x=1755868050;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=atnWrEhI9I15MA3Lp/tIk39t0ZE1V84y+MlZ3WewauU=;
  b=Kfizw5vQxIJJAzclYCdZV/7aV04PC8WulwHlelYyH/Or/2EhgoqXp03b
   3ed8D2ztboKQAjB82dyEKpcwy6T1NM43jsdlUQ62+jZAVVfqp3jN5y3di
   J4CoBAwApkDfd2/fx5hk7p27xE9zLeVgZVVleluVWjgnaDU+R2gUhRFHV
   nuJVFEepUOT4LQfS31sToTyiaCSTaVpl4nw0E85aCVT2ma/0G3VuKRmZK
   UJ4wUP3lHoES/AZT0BbjpFzsh6ZaAnyis1IEj9TQh/MAZwXZIWIggnRO6
   FW8ORgekcaQ6qYJykHKYM7QjE5BoPzzV6FacjqUSD5Sn6aoopQq5Y+toQ
   g==;
X-CSE-ConnectionGUID: cABJHn3HQEC95wTp4P6vDg==
X-CSE-MsgGUID: 4pp4+OiCTx2m5y2m2IDNew==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22897822"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="22897822"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 06:07:29 -0700
X-CSE-ConnectionGUID: v2i+IcPuSBO6aglXyVuq3g==
X-CSE-MsgGUID: wuxdpV/DRcGtMKqWN56D2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="61973899"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 06:07:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 06:07:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 06:07:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 06:07:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 06:07:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ME6v5UkV2FgdBRsO0bhJi9221/g3xTwuBBw12nbd5ur0ObHPzKepkBh6Q6CjNI65+BXgXlUH18QkJHPVlff3F9SeFMzL2JjgXB0Oaz7SAkm+zgeIvB3jHh9h9DAK4PZQbiAXp36ajwa4bDARRWMmej2Hip2qUlPS+7relCRF1+U+uIRwmqwiAYM/cALplEzXWLq/zVeESdXIvmuq4tk4JGNWmhyYQM7sJ6GyNumtKJO1rgzUkCZnMh2PK0uNm98UFsx5M8R/sQFUgoNixv47lB4FSrxZRTu9wrmqWL4ZrmVigtMmKcpEh7vyQaxjppjRkHXg+PRyQtra8R/0FbLg2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=supaRhUPHaImxBNkyWosCD1I9TdiouO67MKdUguSvt0=;
 b=vu4pz7bWoMuG9gHLDXm+rI4hkSWrDQclo1LG9lYCpjq5iZPAVn7MqUaWowVfH3/lDMAUJzw9iR2UT5uCeZYpEduX2pfvMmQ03diLAIwVRT8FdJ3nw98z6F4rvEc8meJj274n2XD+/4UHYmx2EO99EWA4xer7qkrlh6kV1qokS/oSJXJ1HiGn/Gd5mzqwGI5k5A7x1epvE76g5xslzH6qp/Qufz5RBCjPb3Y0UDLtRTiTmQ1wNBQCKd1ljteP1ol+YsfMKylP2tpOWsxVO03gZt+jUq7jN0e2eJ7rJxHYGXWBDcP0e3KRlPmBmK2PAewnm1wHeHP3k2Oo8NHbfTMxUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SA1PR11MB6872.namprd11.prod.outlook.com (2603:10b6:806:2b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 13:07:24 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%3]) with mapi id 15.20.7875.018; Thu, 22 Aug 2024
 13:07:24 +0000
Date: Thu, 22 Aug 2024 15:07:17 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Jacob
 Keller" <jacob.e.keller@intel.com>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <magnus.karlsson@intel.com>, Michal Kubiak
	<michal.kubiak@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>, Chandan Kumar Rout
	<chandanx.rout@intel.com>
Subject: Re: [PATCH iwl-net v3 5/6] ice: remove ICE_CFG_BUSY locking from
 AF_XDP code
Message-ID: <Zsc4Bazp1yJtH4jT@lzaremba-mobl.ger.corp.intel.com>
References: <20240819100606.15383-1-larysa.zaremba@intel.com>
 <20240819100606.15383-6-larysa.zaremba@intel.com>
 <Zsckdsyjwfglf6RX@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zsckdsyjwfglf6RX@boxer>
X-ClientProxiedBy: BE1P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::12) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SA1PR11MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 7874935c-5709-4af3-6e94-08dcc2ab5d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vx02Sap4y5JC36BCUhRVTH7zuEpK1qSBASGpT0gD8MYCIJnRHQyZaUYYpAXu?=
 =?us-ascii?Q?lUJkTgfzHRURsWVqCkw1tB9NjKVCxAyCJryUYx7wAA7/NYpp6yfqKo7eU533?=
 =?us-ascii?Q?XWORtwOoOH/QRtuNsFlYxQTcRpW4/QnbYOCLhtdCcgKtgXIb1v0egPOak/x/?=
 =?us-ascii?Q?dzddvb4qtw3EmwRmtXOP6VPxzVqc9bGroAVAVgNWYVC0AHR6jBxqYL1GAvIl?=
 =?us-ascii?Q?RPcfebOlPosISJP9O5BPFCqfbxWYeZ3Q68u1WgpZJOXYck+quGhSlWoZyZxk?=
 =?us-ascii?Q?/uKoMg2CWHLWUVOqnyU4HD2RUOAKKqTp/1p+Pn5qJRADCdElGIbTHsVqn4Cb?=
 =?us-ascii?Q?7HSGhZJN7x5/2OGCSeKeD7yz3Z1Rs0lZwYm+GeR4cTjrtqyZPXZMUNbVdEWR?=
 =?us-ascii?Q?TWW3sl4lTi8hv4rw2OSjA7KhKw+ndDdgFv9smL/J2zLEkNVkoMNpPy+BAnvP?=
 =?us-ascii?Q?gFsKAAriQhioXWQTGaG77RcdXvAEIwWLAUcuW79RJxl4QAxRQ8t8301sXd6s?=
 =?us-ascii?Q?FNgvWKmjQw4fvm6xc9ZaA14QtMmmYzoJuUEjvHQ1fZztTmMgGJ2AG6f91hcD?=
 =?us-ascii?Q?D2NOTghdrpPrYMsemIcEWxPauO4cyJcCrA2LtrBYNJgbAGT5FoyOSYM3niIU?=
 =?us-ascii?Q?WD+Bbkv071HvoKtOBTO/aIu6uEvnq1Y3ej9+DstpAAOuzbeaUzT5kIMfO/kd?=
 =?us-ascii?Q?zoU5uY1FCmjxUnqRPxTMWyMiEDk/bvdTkJ5c4DDGuZgPX1ZOxNPqdoEgwOp4?=
 =?us-ascii?Q?T8mtz6NKjkKlAemJs1szJxNcNp++3Djcaip1d+7YfPFROoAI7YYNHDFFjPFW?=
 =?us-ascii?Q?Nw64DkWPZixktz/AQ7o/XhHBAZnDHSkCmdmLWs687PfT9BmtwjUILelqEGrz?=
 =?us-ascii?Q?fzIsgRhuhJZVnLUuCG8frqnY9B8dWQD9BuViVYMf5igYjuSykyA4cMAKxLrL?=
 =?us-ascii?Q?ojbNWFtCTxPDe7QFOdmTbRAy31IFtuJm1VHq8Ap2ZTs3zDD+mR4oSk6zRKcF?=
 =?us-ascii?Q?m9a+UzW5znEq7dAhkyATo5ZgIfKlmenJVgMPUD/o8Hj+1ed51PRI4kWUqRYZ?=
 =?us-ascii?Q?+sCIIixaOwZ4Mqx1+h8nbmFjgMuHOkqJQr49efjc242z+5b70RXHfzsku2X3?=
 =?us-ascii?Q?ix+XkvxRg293OYn5LZ9Rzu0BgY/JkaAXVkiCDAfHoudLr+M/CW714g8p/lPp?=
 =?us-ascii?Q?TaJ6aEkGsoGrQjvtq7dhxaxLd80GAqyL7jvq/0SsEjDbL4E9xcG7sIsMxIb2?=
 =?us-ascii?Q?HWnSeQ/1bZh9irt9aUJH6ywecX49UeFJOCeR8QKYaaF09GiCxKjfG3VTQDcP?=
 =?us-ascii?Q?lJVv963mzI3xpBWrpaFpKI/yOhFjcve41ZKR5ggnZ8C1Wg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KbBcfXU3ik9mJjsKFIO76SorgcqLt4wpuhR0gjdii6n0aER2vFMZOTu6z0dm?=
 =?us-ascii?Q?3NyrKcC8wl/EGOv2RI/X34EWu+FkgAnOi729Eej2C0WV8y6yNr1MVO+TT8sF?=
 =?us-ascii?Q?Q5cNSIkZcLvfdjjj9AQLtHgAIt+cD70xTmaFHoyr3YvIU4dWfqkqyzZO6WbI?=
 =?us-ascii?Q?GwpWD8pPD3p6X8QyKjgbZ613CT3fgrzQMCr4o/61sATIfK2aHyes4jDQ7VfL?=
 =?us-ascii?Q?YaVJaXhbmWsPpUx6rAqhHP9XKCmF/J6cOlakgUs2YRqICN1XanC7pjVGL3Dy?=
 =?us-ascii?Q?PGOkdCUoJaSTko9w0QAR/CSpXtTd4cu48EyjByaFDvw3JuGDwkfY1AufG+Fl?=
 =?us-ascii?Q?CNsrFAbbpK6rIrwMmlJk+QMyoUg7kwtxYBSBFQ1HhjeM3HvrbHQbvAkUtC5C?=
 =?us-ascii?Q?3zBuGzdYJY0f2tBjlq6AfuGfC9TkzRCApbXKrKuf4vDmR5PmkZWoqXQYd2hO?=
 =?us-ascii?Q?j0k0QyxI5lJYQBDmGVuIjkP60Mn4UH/b2PcQUOwDNHv/VdQJGUap5E8diEEV?=
 =?us-ascii?Q?VFxPd3KNXbtKIcPE6Hr/KQHJ5GRcWdGTvY8l7aVm5INVTMjQzdhuu9omp9Xt?=
 =?us-ascii?Q?eFOc7gIKW5Ij43oYlm3YhCHxvdxYAzCC98ZO7apY2ypQEjnbiyQKDmSLHZTw?=
 =?us-ascii?Q?zVHmYmfMCCUKB0/zJraTr9UIVzT6T+BMJTESAOAosGN+wdzTS2QVA241p+BD?=
 =?us-ascii?Q?e+9WXT0JZCEHKso9tsWkRo0DfB7UGSBp+lVQhWrYuDDjP2OOjzZN3vQNtDQE?=
 =?us-ascii?Q?XiRVAlkCggZTTJhhK9PxIfit7Q03WM3oYE15Tuf2QmE7bLq+Pqv1Z6rVgPZi?=
 =?us-ascii?Q?V9cESA41ndG/cfNgnh+UIUIcR2+bdF1GL9UCMp06KK0jf8DEDcEY/EyUgF+Y?=
 =?us-ascii?Q?M5PHR0Hqz7hwq1SrAIRta2CMuB6OXKhoYH3bpkaVkjQrpdrrljfew00Kjta2?=
 =?us-ascii?Q?eTYVWbr9aEGclJe+dJvRPIj+JpSwC0kGyYP8R9F+A/GAWRp9STv5tae0d7Yv?=
 =?us-ascii?Q?D4psRilt4O2/FOljYFXV1X1GPwz9nkC4xorT02zy842bTohGoBI3DMi3ZsiR?=
 =?us-ascii?Q?XjMDB2xZSOcyUtBLRMiGcG7WZRo6+H6jqTD47QQTKog80JlKW8D0iCtJP9wY?=
 =?us-ascii?Q?XV1pI68x2tA7IBPe9CbhTZpz3aijiQRMwffsnzvayA7NxRQrbQzj8AZ2jjpb?=
 =?us-ascii?Q?Lunu/uss16KMorwGM0FRlzpq9BIo5awstvNEjF+vrPMekMjmfNF+mbwJ4Bzi?=
 =?us-ascii?Q?wzpl49Fsyn/m5dgN5uphARUz7s+2js3RLtPohmtfEWcP2f3qxaySFUMXJwQM?=
 =?us-ascii?Q?fbx36+wAPWT+5YlSGM1uAk6O8EEuUdiPXeP/LQtfP6ay0AQYEaXTfERLlb9f?=
 =?us-ascii?Q?kmLzJ2m436YF5LJbQ4fbe1AN1Mnr4P4M/sHDe1XZXL6LHHEiJlU0LlF2hbY0?=
 =?us-ascii?Q?7YBG7b6oLBiqvVRAUQ4r1cWSSxvo38XKD/4DHVwum4BM1yJKp3ggXLYYGSEs?=
 =?us-ascii?Q?j4SZq7nZd3GJiUn8JTFKWAVwkTIGk7ELe6lHsX5SMkppPfp83XEkugfBSj34?=
 =?us-ascii?Q?nxwA7TxStvbrJ4GRXPXRO3HMvSEVmWWwujZpDqG9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7874935c-5709-4af3-6e94-08dcc2ab5d93
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 13:07:24.6158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1B564gUKLMOEmLP6/B39/QEL8GjeZXZ2IVBLMklaljzFQm4G/qVScJtikb7AAZjm5jwfu2ewjIpSvwkZa2ml8cqK8tSILTgrPqirlmBbb/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6872
X-OriginatorOrg: intel.com

On Thu, Aug 22, 2024 at 01:43:50PM +0200, Maciej Fijalkowski wrote:
> On Mon, Aug 19, 2024 at 12:05:42PM +0200, Larysa Zaremba wrote:
> > Locking used in ice_qp_ena() and ice_qp_dis() does pretty much nothing,
> > because ICE_CFG_BUSY is a state flag that is supposed to be set in a PF
> > state, not VSI one. Therefore it does not protect the queue pair from
> > e.g. reset.
> > 
> > Despite being useless, it still can deadlock the unfortunate functions that
> > have fell into the same ICE_CFG_BUSY-VSI trap. This happens if ice_qp_ena
> > returns an error.
> 
> I believe the last sentence is not valid after our recent fixes around xsk
> and tx timeouts.
>

Yes, this is no longer valid, I need to remove this.
 
> > 
> > Remove ICE_CFG_BUSY locking from ice_qp_dis() and ice_qp_ena().
> > 
> > Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
> > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> 
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> > ---
> >  drivers/net/ethernet/intel/ice/ice_xsk.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > index 8693509efbe7..5dee829bfc47 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > @@ -165,7 +165,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
> >  	struct ice_q_vector *q_vector;
> >  	struct ice_tx_ring *tx_ring;
> >  	struct ice_rx_ring *rx_ring;
> > -	int timeout = 50;
> >  	int fail = 0;
> >  	int err;
> >  
> > @@ -176,13 +175,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
> >  	rx_ring = vsi->rx_rings[q_idx];
> >  	q_vector = rx_ring->q_vector;
> >  
> > -	while (test_and_set_bit(ICE_CFG_BUSY, vsi->state)) {
> > -		timeout--;
> > -		if (!timeout)
> > -			return -EBUSY;
> > -		usleep_range(1000, 2000);
> > -	}
> > -
> >  	synchronize_net();
> >  	netif_carrier_off(vsi->netdev);
> >  	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
> > @@ -261,7 +253,6 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
> >  		netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
> >  		netif_carrier_on(vsi->netdev);
> >  	}
> > -	clear_bit(ICE_CFG_BUSY, vsi->state);
> >  
> >  	return fail;
> >  }
> > -- 
> > 2.43.0
> > 

