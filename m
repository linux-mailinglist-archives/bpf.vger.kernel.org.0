Return-Path: <bpf+bounces-73360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC09C2CBF7
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 16:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDA7565847
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 15:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4423161A0;
	Mon,  3 Nov 2025 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f84g/fgj"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7EF314B63;
	Mon,  3 Nov 2025 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182889; cv=fail; b=ctjZX9t5FNx1xluhKglHzs+bYeWcETimOxTD1roRtVFfBKyBQ1pUZrHBg+i6Sh19OlvIhIUGTKQrbo0dNjHrTP0Fc4VbGAvUJg9w7GM9JFlQfMyhAWyDBg1iwaCWkhVL+XXeloGzMtB0I6K1mUCxdgSt3h0xc4skKmaFJTbdCDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182889; c=relaxed/simple;
	bh=l0NQChHeUFJywsn/xaJ2JqCI1srQ9xWemeBJSLcb97Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bUEqZtLaKdaKKP9GLByT+12+cUE9u7qQ9D1c0nWZ6QoKosDxx0wWm8kqiH8oTWOzZrGhCJ7RSB7+KOKy7APMxm+elHul8onriBrxwKikqudOOXPCBMXMKkFce0dev83NQM8EW7u9BOj7zYi3TVigmdL0AcuErmMJP62rnO0oVpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f84g/fgj; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762182888; x=1793718888;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=l0NQChHeUFJywsn/xaJ2JqCI1srQ9xWemeBJSLcb97Q=;
  b=f84g/fgjrLMBdq0Iup6xCfAxGVoZ5zVene/TLWYXfM3qKYosgR3lpaMI
   dhR/7RZEC+59ZMr8eqhcH37gdTz3SIXu38JXHu2gp6t+ctUunacn7RUMQ
   WPBumaW0SFHrJtFGPPBC5/wzTJWNanRpWJ9D76yxvV1bXjNcV2BE8P3jU
   xRGOj/2P1JJg99ZGBID0mlEO9PbZRWM2aYwH169MTJdJCKaTBPTAdiwyF
   myCTt9qPn1DpMkM1lEcO6aVj3jDUs/WGjMz0T53xEHRGz5ghZNVvlYYib
   4mqJQjSCwyZ293YnHoTA8tz2OhpwqBAbHBl5L+exWLv7VGsoylTu0HWXZ
   A==;
X-CSE-ConnectionGUID: h/CBHfc6SfOHZsSaZXaulg==
X-CSE-MsgGUID: wlgeU84iT5WSBNW/8Nl79A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64164151"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64164151"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 07:14:46 -0800
X-CSE-ConnectionGUID: ubfWHu1MSQOOAegC8De9vg==
X-CSE-MsgGUID: uPooLfRhRaWt/IH6crr8yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="186758066"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 07:14:46 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 07:14:46 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 07:14:46 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 07:14:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVszONWfMkyzb5Y7IKZkqrEfV/Dt6osjk/5Gy/Dy3BAzDBabKT9ulERxdN9Rri7oPgw4JPMf826cCj//qwdRLp2sl7WgMUejrRN9XvJKaxNmWImEgqlGfdGY4ng12TwEQDuQV+/8UYLIHMl5jYLYuhcQTOFyL/+B79rwCcGHx0mDP2J2CVaK0XZT9hCd7WRdjZi8P+2/Ulli/xClU7UedWRc4cjFLvx5qqBsAsmik/RlINR37MSEqYhl2vG9irYpgPexmqIO/c+66ORhWmbPCMtGq42juJuknBXoMj5Yikr0/W7hKblUC/o6f2HyxdzgbUQ4QSty05wuS1bK1RrtWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jv9XxTkx/+HIjJ+NF0A4IXMpAuboJBdcwPP35LDDETw=;
 b=mTgOVDRDP3wnkh/zJGinZaiUJYaUTzLyg99Wzza3wA0QVkEtOUbKFe4g8n7+64yyniKCVoSV2EXd0poo7xcVSn2nQc9KvXtojZgbFQPiiSBlEnQ34k0deA2AxzLCjkfNcM5wm5iksSb2aJumUoE22PyfoLOiTykvA530BRN22eGSXQFqVBReG4PSUbgI6dL7MyIqXhQs9Upe8mWhqd/7xCIOg5PqvOx6uVWGoKUQrsOIel1jVVNz8CA/TXQZwV5ucX/xTcQXU4CHMZ3MuYf65sczYsjTyVrtnvG7g/0nxyxPbf9j3Z7lZJnOS+p5TTMnPulDfFQYeXDJJBeYE2JOEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN2PR11MB4696.namprd11.prod.outlook.com (2603:10b6:208:26d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:14:43 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 15:14:43 +0000
Date: Mon, 3 Nov 2025 16:14:30 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Your Name <alessandro.d@gmail.com>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Alexei
 Starovoitov" <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Tirthendu Sarkar <tirthendu.sarkar@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <bpf@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 1/1] i40e: xsk: advance next_to_clean on status
 descriptors
Message-ID: <aQjG1jnPmLlROQh9@boxer>
References: <20251021173200.7908-1-alessandro.d@gmail.com>
 <20251021173200.7908-2-alessandro.d@gmail.com>
 <aPkRoCQikecxLxTS@boxer>
 <aPkW0U5xG3ZOekI0@lima-default>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aPkW0U5xG3ZOekI0@lima-default>
X-ClientProxiedBy: VI1PR03CA0071.eurprd03.prod.outlook.com
 (2603:10a6:803:50::42) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN2PR11MB4696:EE_
X-MS-Office365-Filtering-Correlation-Id: 64345bf0-ff7c-40da-f8e7-08de1aebb752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hl5o+yPA9C9yxQQhRRPbRaSCJRxJuid18ghISJxT3To2CJuxA6PIykIW8LtE?=
 =?us-ascii?Q?C/v8YAnYD09m76nbExbXzoPFsUidLMylXK92YQXibyVV7YUz36DwC3BDL1ug?=
 =?us-ascii?Q?n6g3Nb79mq9DZd5Y4Nxui1E62tsZL9ByyjR22iL+kACvQGHqwwzadKIh3GZr?=
 =?us-ascii?Q?aF919wkDZ5g8fUbB5/NbLS1raDj6mAf5wg8aJrNDvcB4dtQZLsiARJfXCjBp?=
 =?us-ascii?Q?JG3PN6/vIa1LmMlNOM1TkwM3TGcdjAb77uOW64ImDEYSgmEDb3TUtie4/frV?=
 =?us-ascii?Q?+zhoqwIyzGS8+ZUsKBIhEztHPBuRkwv5vIjv3RfnqR12JLAxW5ZfVkR1An6q?=
 =?us-ascii?Q?XO56pk1qj3egCvsrBvgQhxOsjGln9w9cUv0VFmEDF/Nc0snmEDn6WnC/7TOr?=
 =?us-ascii?Q?6uRYkAXldfKjqoY4EpS0YkS1upw+Vi2w9tsfMMexNn0ub5Tyn+472TtWRBQ1?=
 =?us-ascii?Q?+bL9zuTiwblDPFKa7l30qaN4TOKV752a5xgZ0dh0snz97ryIZ5zDYoEX+/jl?=
 =?us-ascii?Q?SiDppmNFupuH/v50kuG2v93HF2CeGte01Es2wHsXxPhcJm2I3FuxLjb2/OBY?=
 =?us-ascii?Q?ceAqD0t5DUpj9MflLEsM48xiMXEpY/jgOQb8IMneYtBzA/xmxuj91ENysrFR?=
 =?us-ascii?Q?CXmHrIqMEIzWGBL2hkTftQxLAcG9+KFIpUCK/MQc/TeBt3GYjJYx6g76fBYw?=
 =?us-ascii?Q?oIxbaNx5xlj2O+0BqDVZs2NWkQcmjbHcg0BfXvNRIlIk9GciS71z/0hQZ+Mj?=
 =?us-ascii?Q?Zl7HX9Zo2fnRc6cJe8yrpYxWJRPPcni3gUndIpH0DQmMjq6p38A3L8qN/4+Y?=
 =?us-ascii?Q?Iq39HZHHC5S5YYjPtIeo1BxcEBuFiE3Fxsx8CYERFxJmKgSsc2WVw3AWkeGf?=
 =?us-ascii?Q?f0i8kOwfrydIaE2gGhR8P5vn+In9iogigMg4kRFWa+CBwBe8CALLPrieRsNJ?=
 =?us-ascii?Q?Dsl2qVdX5qD2zSR6L1MjI6k/aBQwWuXD7yfjhtKullGPNqi0K05l46lhO27c?=
 =?us-ascii?Q?/1yaBwdqboZ59JLr/AFwNWmYuz96mVQAqa59vOYbMmw13W/K+hpUrHgzN5j7?=
 =?us-ascii?Q?rXlbiZvWd146tvnpIvRq7p9HbCpfywrShv6wGfCnjEyo20qFXG9vv70HKA3k?=
 =?us-ascii?Q?57alJ3UOD085LZiNCZ636NYu2rttyssmNKXLNaqBiVRTmSjn8nqa3Eyl1XWr?=
 =?us-ascii?Q?AMPjl2AK0hVgbYu+AO7FFKTZ+Xd5XgykAwo+jLPcH9hAMnxBrTChxlJw1eRl?=
 =?us-ascii?Q?4Ve20dwqlCJIfj2sAs6Sv6wIMVXREGSnBUbSNTbowPfO1g7sWZPPxeMojwTm?=
 =?us-ascii?Q?S6zDcZFr3QEEXHP0/kPk3bDGaJk2Je7zsGPfN3444phzt8BO4dwS06VOoXd4?=
 =?us-ascii?Q?GbipeGiAtOi49vpR4dPFeFaxYxF+WWDwmZSEThsHsJH5p0iriSvoIzjx7V25?=
 =?us-ascii?Q?BzVc/Nt7xog7SEhZ/0XOCqcbS38uAWYJlcK6vxVoBxMt2CsbeessGQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xNYlXVZwHTZlW8U75Vzj5FkwIYZ5493LQWmwY384B/W0zXMY4+zv/BCqHPcS?=
 =?us-ascii?Q?Kf+lSz00I4R1QABYgQdYd9RjWwu0sJ8QDEy9pd9dN41nEZh/s2csKHHvDit7?=
 =?us-ascii?Q?EoX+R61A+JnDHgsaZHIGtY3ZsWZ4SnecMxjSCdpaU/hPHe0SV3aJbFtWXqxz?=
 =?us-ascii?Q?WHPpe8+VFlTcvOR1wVOafLfpJXzgKWr8UI9eq2zJ+Xy6Q3oJrbSKuKtTtQGo?=
 =?us-ascii?Q?4j+paPOyRTm9yb+jjVz7ykjMEeoQrxHrpvVrTFaBU4urFEsnADO1fFsqTnKF?=
 =?us-ascii?Q?xIYsKjDxsWPIuxtu44J0jNyiMWaYFJTUsfuKr9sIg3gbxMr9z4pO0I2jAWYR?=
 =?us-ascii?Q?p34/88/TTH8nHcI6Jk4T70L9FE33k5hO6/II3L07fHi+rjT3xlIGnQR801dq?=
 =?us-ascii?Q?MmlxjlW/XWZl/wLz5tDzAbfQ9k0Qel+c5xqqeXHvFV64+GlZU02Jw/OMRXpd?=
 =?us-ascii?Q?wu1Yx5FQkzSRQKJ3SfLyX+rA6Imm1iL6M3FniHTjvSHWj0Jj8zn2aepNwETb?=
 =?us-ascii?Q?kSLeJpO8rEQMF3FuKIdr7s7Wo1nKC4nhr+4RL2AOV1SDbzjiRlKToNVIzhH5?=
 =?us-ascii?Q?0PV4ZN6CXDJiW3BIMkRg++1JN3W4clhb+0n1YVnEFPDiu3Z1Wc4a36oUjdur?=
 =?us-ascii?Q?YCOdk4IClcDO4T7SvBye9NnktJFMhoNd7kE8xUM87BvNXSorN4A3dGIafNGn?=
 =?us-ascii?Q?1R1ls7q8xFMknYE/lxZbrlZzvrYdILErG8wOrMIo7ZrpVUTycJkno1N+LqD0?=
 =?us-ascii?Q?c3GhEmvU8MHRV8oOs0sAkB5JOq4TnxQs7uu6FCNUSYEuVZz52zEAngycmU5Z?=
 =?us-ascii?Q?JPVLz0e3iO1AXye6HlOaUGyd8cmf1YJWSzmAZ6FuUqfinNGqDuYXlqHymQlm?=
 =?us-ascii?Q?P9QShub7NhqLHXFWW8ClzO9/Cs8X2+TTLiP6wfN2+9KG6i1k3ctADkkYnLIm?=
 =?us-ascii?Q?nc+6qDHhQfiie48Y2jXXWPHZmCdENrdWctXdNd9v243nTn4JG1iV8iafnh8/?=
 =?us-ascii?Q?RKDZpUAieDHS8WDisiaFrU5Qah2H/GDYJ/3KzQleq7jxc38dtrQ1EOFoly4E?=
 =?us-ascii?Q?zHKIBdmbFNDIAPy/ApwkMpc8bdaffTUJ/h5eIdGG1kgql8YLTb6EEShPjSbU?=
 =?us-ascii?Q?06DCg3/zzXO5Wmguk/vf1N/tTQ672XWw3DpVThyTB/lVWWSZETD8H4+woM1R?=
 =?us-ascii?Q?Qv7ZUiu0hZ/FfF7chJtb8BtT4FpSwOvvpyWv1JEpUhmF4UTe40k3WEG9e/Fz?=
 =?us-ascii?Q?SGl5rYBEC4gWtu3rHlS1p3pV0Qmt7gazBTdxMkqpePqIrhYLYyDUJEE1xOH7?=
 =?us-ascii?Q?Ef0UTX7PH1RiFBOPA0hes+xlfsaTud14KDpaNv97FMsRrcjmHPDXmknoWUj5?=
 =?us-ascii?Q?PZMKMVsOVFFSPvHpze5MUF+f6dcEGMg81Nit5sKHmMcyIeg21VrDE/HTyKnn?=
 =?us-ascii?Q?PVyKUk7Lo9QclRolXiZnQV9D6yBcrGHAkcg1El1i2fQdvHE7i0HxZ759+9qB?=
 =?us-ascii?Q?6kbfTYBzTmoeOIt/5cDzRFKXNpeuTzOEilXhkFsUHYDrGnuICDo4X/f4jPZs?=
 =?us-ascii?Q?YBLg+ofNP7shuuAL9N/+XV6lx+SncedoZpOh6oDa54h/ZND5XVJsH8UEfxuY?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64345bf0-ff7c-40da-f8e7-08de1aebb752
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 15:14:43.0319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7q0cR/FbTnofhDvWD1vHsVF/cHUSuICLFvCOJEWWsgBrbwAn7xKpCQDokMoGWQVUYNeaNOdJVryE3x+lLUeJPnz3AwQToYBogpNvlbcxyYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4696
X-OriginatorOrg: intel.com

On Thu, Oct 23, 2025 at 04:39:29AM +1100, Your Name wrote:
> On Wed, Oct 22, 2025 at 07:17:20PM +0200, Maciej Fijalkowski wrote:
> > On Wed, Oct 22, 2025 at 12:32:00AM +0700, Alessandro Decina wrote:
> > 
> > Hi Alessandro,
> 
> Hey,
> 
> Thanks for the review!
> 
> 
> > 
> > > Whenever a status descriptor is received, i40e processes and skips over
> > > it, correctly updating next_to_process but forgetting to update
> > > next_to_clean. In the next iteration this accidentally causes the
> > > creation of an invalid multi-buffer xdp_buff where the first fragment
> > > is the status descriptor.
> > > 
> > > If then a skb is constructed from such an invalid buffer - because the
> > > eBPF program returns XDP_PASS - a panic occurs:
> > 
> > can you elaborate on the test case that would reproduce this? I suppose
> > AF_XDP ZC with jumbo frames, doing XDP_PASS, but what was FDIR setup that
> > caused status descriptors?
> 
> Doesn't have to be jumbo or multi-frag, anything that does XDP_PASS
> reproduces, as long as status descriptors are posted. 
> 
> See the scenarios here https://lore.kernel.org/netdev/aPkDtuVgbS4J-Og_@lima-default/
> 
> As for what's causing the status descriptors, I haven't been able to
> figure that out. I just know that I periodically get
> I40E_RX_PROG_STATUS_DESC_FD_FILTER_STATUS. Happy to dig deeper if you
> have any ideas!
> 
> > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > > index 9f47388eaba5..dbc19083bbb7 100644
> > > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > > @@ -441,13 +441,18 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
> > >  		dma_rmb();
> > >  
> > >  		if (i40e_rx_is_programming_status(qword)) {
> > > +			u16 ntp;
> > > +
> > >  			i40e_clean_programming_status(rx_ring,
> > >  						      rx_desc->raw.qword[0],
> > >  						      qword);
> > >  			bi = *i40e_rx_bi(rx_ring, next_to_process);
> > >  			xsk_buff_free(bi);
> > > -			if (++next_to_process == count)
> > > +			ntp = next_to_process++;
> > > +			if (next_to_process == count)
> > >  				next_to_process = 0;
> > > +			if (next_to_clean == ntp)
> > > +				next_to_clean = next_to_process;
> > 
> > I wonder if this is more readable?
> > 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > index 9f47388eaba5..36f412a2d836 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > @@ -446,6 +446,10 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
> >  						      qword);
> >  			bi = *i40e_rx_bi(rx_ring, next_to_process);
> >  			xsk_buff_free(bi);
> > +			if (next_to_clean == next_to_process) {
> > +				if (++next_to_clean == count)
> > +					next_to_clean = 0;
> > +			}
> >  			if (++next_to_process == count)
> >  				next_to_process = 0;
> >  			continue;
> > 
> > >  			continue;
> > >  		}
> 
> Probably because I've looked at it for longer, I find my version clearer
> (I think I copied it from another driver actually). But I don't really
> mind, happy to switch to yours if you prefer!

Hmm. After taking a second look, how about we make it into a common
function shared between i40e_clean_rx_irq() and i40e_clean_rx_irq_zc() ?

> 
> Ciao
> Alessandro
> 

