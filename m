Return-Path: <bpf+bounces-62091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66642AF1148
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 12:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA707441414
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 10:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB7A2517AF;
	Wed,  2 Jul 2025 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Na1HnBgz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B460253956;
	Wed,  2 Jul 2025 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450978; cv=fail; b=jJWJe4YBtGGoFiJuaJ/GMLVVT0TVValS/uIv2SaSBqpuVDwgvuYOqBbeeJjMnLh+pD6sj+wulVVuSUwt4RJtq3b/t3KdbtNx71TlgrF4FAcaCSxjpb8pPhgOYROLZMiyTXROcym9nSNTZLbcWIcjjK/cAhui3yVo2tHJ6nl2UC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450978; c=relaxed/simple;
	bh=ZJqh9Soi5c8MxiyZqLIYs9kxonepwB+Gfb26IBGVbK4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lCys/44Mj3hhit50ql4+F48lxLQJwKPgg3yTDL8LxCmXe6C4QJOoEb0NhZVZAAy1PnilGonLXCjfwm9WvZk8t6ZnvNkLZ7JSM03JG2QLpniIMIwYwIZoS8UHdGuqlovoUMrekS7A+33aNrNHCKRdd4JvkNHLwVSYHjWTQFpVkAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Na1HnBgz; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751450976; x=1782986976;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZJqh9Soi5c8MxiyZqLIYs9kxonepwB+Gfb26IBGVbK4=;
  b=Na1HnBgzFbORV73qIlVX0w7cjX2h5fE9NmKAa+UQispRouXleDixzCQf
   ZVwivLqtYUXq4MX8DxkIi8GHZG3Ra4v6Oh9syDowE9rwFnhBUGZ5tZBv/
   YhpLzWj8cIOvJgbA6o39RuA1mPt3ClZCjL8XUe5Mi6d5UPGrytXQIyun4
   M/REE+pz0/OFVXCvFhV65L6SCij/QWZFMv4/FVTN3TBg7J0vdrQ8Fqbt2
   BCycnIzfxTl2wj5dWoOt62zjcrdi7u5k/sryq+YL+ZyTCHpLQO9e4LO3+
   6opujrJQ56/Y+NKbV+wHocLzl6ef6qJ/VmFE6AtrU0cwRY+EVf9zChxrU
   Q==;
X-CSE-ConnectionGUID: 0mJYCADES8WonY61Egl7bg==
X-CSE-MsgGUID: xSdW1UPVSyyfs7p5okqDfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="76282377"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="76282377"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 03:09:36 -0700
X-CSE-ConnectionGUID: R837vmORRteuKKRV7ejSuQ==
X-CSE-MsgGUID: vAsE4q0cSAmk5LCK97pG3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="185064425"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 03:09:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 03:09:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 03:09:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.73)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 03:09:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hlw9mBN8EeHWO9Fqd8wmPNxJYD8CeHvlWDMEn3hJxuTvKyHk3PrJeRL7bU0JG3uR1WNJcrN3ztYQolxdpBWrS+IQXbwOzTbcbqdZzi4izfpOE42JWyntiCAryRHuHdO8DAzfq6i4zcZoO6nE3JiMrf9Yp420hFirbYqS+CfJqjqLTIUFYJzFEOCl5s5IpC0kUPkXFo4PY5LHRcDuKOifLytUCJyMCbKfys5/ZUSGC318ynoCDhOBf1eNCt10KUOck17deazx2zhsB8Elzw1Zldn9ycOxaF1Tt+wvSsWqOKGAQbYki4c/JoYjB2ln1acMcaR0ZwVKkigg5rxgNyyOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtxbOMpz8Nf51dXgETiBjhU0jDheYIN9eMbnvvpY4R8=;
 b=dLwNQNf91ZHVMSnzHTcxFuRcRD77iF9OWYxikWrJeK+uJvAZEKvypn0YNjzyL5yJ6XXRFpES1Q/y65+Bga0XQ9WDH9pOOb6i/LKvZoebCfg9hM1+QHyGNQXvfXyUQDNVqm2sZPB8CqAjFLXh5ndmjqJb083MJW4IbD8gxgZCepELRmZfAo2asLufWc7YPHMiyCPjkxumX2YxuMlB4vgHrcqyu8AcTa56Iy/OWacnEqeJwb+/IWqzv2EISRLsRJiNxjd6wOYotB95qgDqbTNkrRfLgcBQvgfYBuV5tRTdbWM31vgmaklc/QK/E+381Uh76sF03h5lnG8gzmq2CNjQPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB6807.namprd11.prod.outlook.com (2603:10b6:806:24e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20; Wed, 2 Jul 2025 10:09:33 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%2]) with mapi id 15.20.8880.024; Wed, 2 Jul 2025
 10:09:33 +0000
Date: Wed, 2 Jul 2025 12:09:26 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<joe@dama.to>, <willemdebruijn.kernel@gmail.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2] Documentation: xsk: correct the obsolete
 references and examples
Message-ID: <aGUFVqgZb6EpvfUh@boxer>
References: <20250702075811.15048-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250702075811.15048-1-kerneljasonxing@gmail.com>
X-ClientProxiedBy: DUZPR01CA0179.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::10) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e32ca6-4a72-4268-4c98-08ddb9508a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xKU2GIbeenqlSWAQR0bZMIqSkcJyK3L1Rcmv/w5lFlSAYsRfGgYgfrpquLsb?=
 =?us-ascii?Q?fqXjBcymBindXUOb6Xn3yEKIfjEU3ex78IX/fyMX+uTZDpUndVKNMl0h7AHw?=
 =?us-ascii?Q?v37Rk0JBbEwfC+rDo68rRR/ASZ8cT5pxlrPgy1l6Mh97XNcDGnTmThzxbaNO?=
 =?us-ascii?Q?kAq9YMASEThYpIeLznBwA4lQb95yRy/qwZHnBgS4DHUdSCn8RXK78zCXPwDY?=
 =?us-ascii?Q?SQb7xzjSx57osYO3JXrdv4LodY9qplViDaL2EgxzJYvspaN+2t4U9Rn8gkDp?=
 =?us-ascii?Q?HHgpiGQ5JygQmcClrIfP2pgbvLkYXk3bGbJXkkrcom+ECyVlMv4e1Cy1hyfc?=
 =?us-ascii?Q?0DCiAwiEWYdAf9acdhZ9wvfvOG7sFsYl+4O7vkPtbiJO4/ANp5Jsbb7jxzwZ?=
 =?us-ascii?Q?pWaVR/e2ASbRaxnGfljfJdldWItVa3haoXTxWcQXRs4okTWm8ejPGxL+2Y3H?=
 =?us-ascii?Q?HNuXWn4qMykqb1CX/UP2x8DXjatRn/v++uc442g98O0c9gc9pdEMQ5zLaZ1S?=
 =?us-ascii?Q?lE7Q6PY5Z7jXEiDF8tCSfBJk75eBLkYW2n5ZMwC6ryOZiMLoHL7uUybH0q6U?=
 =?us-ascii?Q?k5jvgGTqOvbR0dyRFKi+HpifyxZ49I5h2trR5deOfl/EF247xXI9Cl+uHm0K?=
 =?us-ascii?Q?hjW5fGXfUnxCftmxBgoRCgffyzIGsA/glEGjmN/0BLa+gFhnIGmKpPZJrDDI?=
 =?us-ascii?Q?qD9acBYMPJ5KCDmV3anm0X7DE25XeDOUej2JViqPGC4QWHjICJMNzA6+ijMF?=
 =?us-ascii?Q?EE+v6o8cKDE1zBvxiQYzvdtlyM2Bl93/MGpop+zWb0WKn8N0Mq3P9fPnZk3u?=
 =?us-ascii?Q?ADuAPQTiz3ho0fYsiaFCkOrGFAYIl882Y3HmCBT4d35R1tHEqgb9JnkJBDG7?=
 =?us-ascii?Q?3ixp3yOq+z4kuetZSe0EF6zIUHwoSt4esEw5DQvIVClfDfpDI53CZiOFsHWp?=
 =?us-ascii?Q?+rw1mRhi8W2QpX58/XIGxi6FaE2dNwvx+YQLsN6rn0Ei92B/VmpQ8WQuW4G7?=
 =?us-ascii?Q?9T+xTeiMsoeKVYDrWvhlSZpscLFvVfMMLKL1nIRcjDvX3hSlyB0QyipaQhBF?=
 =?us-ascii?Q?UM2lkBsjYu0d2tNIhh6mzndVBx5t1bgSAgzaaDM1YoGrCk08BbPuMC8Rwyu/?=
 =?us-ascii?Q?ElZstzJvnRwx9QcqoSJurdvKIpDJlaJYlPiFaSdngTgjfvWWO9812jf6SRbS?=
 =?us-ascii?Q?Y3IFlCOqiXtvT02kfcP0JuhX21X9q2nGWoGJfiQy5MWkU4rZ7PmeP1MJxweZ?=
 =?us-ascii?Q?X0xSIyUXkBslUWnRg2lxd2BQkhpMn9RQQiScZrUOMrL4XdmMI/+7u/2BkZ4L?=
 =?us-ascii?Q?vYTR5tWRBllQ5NCQKW0Jm96rnuWOHOn7qzlojq2T7/KRmAJyL7F90gxYbc1C?=
 =?us-ascii?Q?gzGewClS9nNeIgtCzxS9XDxMTGWUIMiUzSM1eVO+teIqnTsooFffhOTVQSWc?=
 =?us-ascii?Q?kPXHFkjI+Uk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/LoxAbs6HOOY+ex+gatBdDlOh+Ahhiyz8aIy+YZvTcgtbaKOXHovFibtXWBK?=
 =?us-ascii?Q?7DXXatkano6oc8ay1zccBYfnCISdh7Xxs6D+u9jI85CH+JSCFG1XqlRn+xep?=
 =?us-ascii?Q?9jLSPB95t5SM0LCs9I8Acz3FEnuSP71tIP2OciPt7pezogNmmXl+ikkXKHNI?=
 =?us-ascii?Q?bprZaJl0HhsLUsYhFn+i/8fuXp42Do2zk2kRU69OACVzvQwOugI4cOsCOUDw?=
 =?us-ascii?Q?DCxBX4c92AffLJ+2lhrCk23/P03e1ghoeG9xhIE/EEeLQ9TqsyJbeSdy16g7?=
 =?us-ascii?Q?KnLTZjhXkq9dLDpRJbglO3ksd0mY7XDpcOFryW5DkXcTZL8/2PbsB/V/DwSG?=
 =?us-ascii?Q?ZABbgoMSuKup2IL+u0BnI8GvqPGqKLcXzXd9N2UdHL33EykYi37IE3vi47XC?=
 =?us-ascii?Q?VjTqgoFiXfCRrKGq7C2YWULNPiiXhocMKsStEpC/NwT2m4Rq46OMC9LoNwxh?=
 =?us-ascii?Q?FK4GkaO0cMckL6/19Urk1dSNtSTF4EV4PfKLfYLo9xUrAQPHUJp/dnK7KSZA?=
 =?us-ascii?Q?lUOQjUmA6TXWreH6oNCQp+IjFinf2rVJjn5IRJV9qYgkMef0qa7U/2ubo92G?=
 =?us-ascii?Q?pfRJDEuSacAFszhhCBeTbslJIflBdWQ4pD302K6+HcRWF6ZjwB3INQY8L2yR?=
 =?us-ascii?Q?8O3W9VWrxHYDihvHxAkafk6/arVU5LtxQN+XayeajUfPioQA1zkr+7QD2ge3?=
 =?us-ascii?Q?QUcu3M6RkYV2sebvNXTyvITQWUz0aX0gcCKBQQdSmcNDTRAxki/QyNLvU4y+?=
 =?us-ascii?Q?bzowddSPCVqjuk9N2Qc7gPhnbFQt8MliIGFcD1sUG+TP9e0yfiCzkzmeSNW1?=
 =?us-ascii?Q?VGDStNGXEb3XpiMou6le/nmSR2MMhVSF01j8MHDI9MqJhBwPySz7HWT69wBH?=
 =?us-ascii?Q?8WzogKgblB21mjx2eOlmWC67qdkVC2eaM16FPWkqvgx8e9PsTzo5xF7jdoLz?=
 =?us-ascii?Q?XG1SSew8GOGpfBTlzphMdiyCmUgtvGqOCg/NiATxdQOnWhH15jW29Jky/eCi?=
 =?us-ascii?Q?FH0nBQfci0pVB19XQ9tI27cEj2dJX7NGcQPnI5eGkjTyckPtMvHG2Fby/eiZ?=
 =?us-ascii?Q?pe31k4tGNaVG1TjaqeUxEgiMqhjoCCpT6kINaA7tlhj9la61DStmIBcF5SPl?=
 =?us-ascii?Q?IhoVePx32VjrrT+1STNwrHo6Hn9QChP7c2LAt9gLhapXvacCk7ta2t2SqvTI?=
 =?us-ascii?Q?mIPNhBrf0WElSRE9lPTWma8mlcVTAIDcqAIDiC9K0cVmmxKTgAQKPqjiws22?=
 =?us-ascii?Q?4v+G/B2z1lJeT8hOeWosBLTv/fK1p5ICbXNNQ3dK6LvTv13J1ftrzxiUul69?=
 =?us-ascii?Q?k0+1Pp5TMsn0lzUfj5y73JtLWlPJJR28GE87+IOx7Lz/YYZ0MTgGNAz0+PiV?=
 =?us-ascii?Q?h+0j/tu5P1bmkuO2PvUtlXypeldoWp0FVXmrq/wBubb3IqZwzMkXiupIEk5T?=
 =?us-ascii?Q?pbCywLEt3C2RPwDZlAfzdvGkGIvA/IlYPpnlrvrPwx9+6varXfc/fZMUYMnL?=
 =?us-ascii?Q?w6OMuMbOSDtCIrCoFhb2en06YvtuPidD/Ch2oKVejbXEoOXj53OazqT9KzQt?=
 =?us-ascii?Q?q4AYh6bwqdem/qsHU4xm9U/lQjym1qhAnkP41CJK1UE8POD8Mj0bLct5iy8M?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e32ca6-4a72-4268-4c98-08ddb9508a8f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:09:33.0841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9E/4Jw9t+O4+7P2zVa9Hdm9fFyR+B9AqTE0GQ8rkz6YQIZpixV52csRiVDwasRlN+9OQ+0qPxPvZP7T9jIMGnpPgd3WMlIXUynObdSTYXzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6807
X-OriginatorOrg: intel.com

On Wed, Jul 02, 2025 at 03:58:11PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The modified lines are mainly related to the following commits[1][2]
> which remove those tests and examples. Since samples/bpf has been
> deprecated, we can refer to more examples that are easily searched
> in the various xdp-projects, like the following link:
> https://github.com/xdp-project/bpf-examples/tree/main/AF_XDP-example
> 
> [1]
> commit f36600634282 ("libbpf: move xsk.{c,h} into selftests/bpf")
> [2]
> commit cfb5a2dbf141 ("bpf, samples: Remove AF_XDP samples")
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

