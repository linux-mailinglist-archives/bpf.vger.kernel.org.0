Return-Path: <bpf+bounces-68773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F371B845F0
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 13:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A2E7ADA06
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 11:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E29305066;
	Thu, 18 Sep 2025 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMfZv4Vt"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE057BA42;
	Thu, 18 Sep 2025 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195250; cv=fail; b=NFgBt2kq/p/NiyHzP5b4M1d0K+2GbNfKe0T+vpL2wDyQ7OL+C81lA5cb5agXuhWNqM3OodzAUoXUaelIRs9Ef3P68FDAtcQ8eUzdRhekvIS69VTuyMkvkT4bUm1nGsQ72F3wR6iJF5Mq/jehY6Ng7DsLI926Xb8bMGZeyr4GQCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195250; c=relaxed/simple;
	bh=G7vlphH2xyvP/NU42el97e5tAS0fQuM+YRUZi+oHLyU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TDaROd5G0Je5mQS68Lx4nsL7IgnrnZzojJhnFl4d0tXUY9vor8NmTbp6bHJKkzPsDVpWNde+Rmx75AdpO/xszjrZAGaymz3X7yquFB5e8eSAKipplREJ5DiaWZTeBwYt41OPoi1mxr/ZhdiRVwXglP9yeCG9RTr4x8SWlknRkC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hMfZv4Vt; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758195249; x=1789731249;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=G7vlphH2xyvP/NU42el97e5tAS0fQuM+YRUZi+oHLyU=;
  b=hMfZv4VtkC62qC8OQsWTRDWdbpieRAVKDAAiw7Bu8zhLMmYjMC2q5kHA
   JFGZI41d0180W/ZjToX+Gv4FnVxBd9fh+3VOF++ahhm45A7gxAVcod6lg
   RPjUVyAsF8igN7Tkh7UwfaoYC2lC1v/HwEcZAGWS5eqCoVkQAluXfctqn
   Y9D49D3PW0N0xoIr6i+cOX0P84TlWAzFMNWjc5ByewMuTOgFaJXQp4tGW
   DnsuAu9/BNEEQIZbpTo77kOpYQglnPFROYQvd0LQkH8r4jz4uZeFoWc2Q
   kLz9DUG+cQrvPpNwFEpZvyR4/kT36X5FWNzvKjT4+wmrjBKjtnpnMmcnk
   g==;
X-CSE-ConnectionGUID: bVmy21wDTw6q+EgBEO+irg==
X-CSE-MsgGUID: 3+iRV9n6S4mxZAA6iOfbow==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60442865"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60442865"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 04:34:07 -0700
X-CSE-ConnectionGUID: 3BMUjTuuTa6jDf1y3a1/sQ==
X-CSE-MsgGUID: RXxS9wA5RtiY0OLaarZJ8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="180798349"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 04:34:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 04:34:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 04:34:05 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 04:34:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzguruWi/IsKAY0lnSRQaqAzv1AvHAJI+xFInR5/jYTew6GYIrbWXNEoZih+H15kgVIMWzQOePPHzHgTr+eScEys5oypbXJbfNTFUuQB5AuJDyxXbcChO5+PNtIffU8hleVr+VnruWtaiV+4wLPv4a45/lgLyX2dbZMP6rBLwadIHc1oL+VU/i9XtFsTX/BQWDfUwpsLDuVtyBqUjl+ulbt0zUtZI9Ewpv61oQBE+qHjor2hLNqa2VGZzNueL94pDP/DMsvIVzBdQCbZucfFJKe/cDbeR6Wri7mx1pwSz5SX5zbO9Bg03t9BH0Bwx2jfjkPyoLmkDye/iefvb8V9uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=am0wZtGJT+GFj7xCEe5LlaP7aqpObUb4laZHom0ZLVE=;
 b=AOJUKbCqpsiWjCnpcJHVGWm/6KeuNIFiTUXlARLZCptvBbKVBlWbkXVt3HvtvPJcYmte9wZrrgoMFpPUwNG5vpnWLSp8GWAIU2hydpux8KoBoKS8Cke+YeICN7qy/0ZxznSty1iCSHfMIg5h2gC5Ptt3CRgLabWq8pZVKDPNSIFUox6iiZAfhpl8Bfl7vVTVKjA59g6PbylYwfv2F6pOiBgggntRR/doIo/EKu8bwhLk+FfaHSzQJHN+YHRR0ZYzX0h2GNvBe7VN4pi4V7HlITA55DjVgwtRmoG44NX2sF1gXgR3z4I/M8heXtr2Su7WJ5iRHt4k7nsTNbxM8OeJvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB6056.namprd11.prod.outlook.com (2603:10b6:510:1d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 11:34:03 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 11:34:03 +0000
Date: Thu, 18 Sep 2025 13:33:48 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Amery Hung <ameryhung@gmail.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<alexei.starovoitov@gmail.com>, <andrii@kernel.org>, <daniel@iogearbox.net>,
	<paul.chaignon@gmail.com>, <kuba@kernel.org>, <stfomichev@gmail.com>,
	<martin.lau@kernel.org>, <mohsin.bashr@gmail.com>, <noren@nvidia.com>,
	<dtatulea@nvidia.com>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	<mbloch@nvidia.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v4 5/6] selftests/bpf: Test bpf_xdp_pull_data
Message-ID: <aMvuHBb0+IIiXXuG@boxer>
References: <20250917225513.3388199-1-ameryhung@gmail.com>
 <20250917225513.3388199-6-ameryhung@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250917225513.3388199-6-ameryhung@gmail.com>
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: eece718f-f892-42c1-3bc9-08ddf6a744b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nxnjTi770ullOzjXbqK0zsWkCXvPdvAmqxayoSzC+NKQtdGPmlOjgcMTiROf?=
 =?us-ascii?Q?79gLUhYpu8eVRhvnwTt5JRZbhhcwttpAe3QahkHiA3nJ3rxoS63fHco8cdSC?=
 =?us-ascii?Q?nltKfGyr8wKasoxQoKCemdm/F7LannTgiNU6d9dK8XMkcguINRvzMpOVR3aj?=
 =?us-ascii?Q?b9O0+N8Rsvlbz3O1nj2CW6qrbAqrJMQxJWPUXNQL1AU2KMSrwIXXPbPEM5+O?=
 =?us-ascii?Q?gmYD3oWTVqSaB2xKFnDRx0mAFKe60/x8yPNL4yqjMBK1ra3GG7Vb8CVQFkaZ?=
 =?us-ascii?Q?bUYdI/oS4spw9ntvY5YyTMg0iwyk+FkKR+kWDzy+d866UqWjPKTL8RZSQvAG?=
 =?us-ascii?Q?ZkQaogRZ/WDuDBut966riQv4PYK/nOsfCs1/MalMIVD0mJOvHgNUEGmgJs/r?=
 =?us-ascii?Q?wrojJ7eUkAsYfimlBWvnI+kNJiQAd9thptFPG1s23TK8iHIzU3dnWbmgbiI+?=
 =?us-ascii?Q?ygyTSo0PmYp1F3DFrsu2WDaYJzrWeZCK8uz4uiG0SYU9Q5y2lwMQsrFBs3lx?=
 =?us-ascii?Q?WGJbdEEXFomACzJvCtMdMhTMrNET0Dh9JP1nw8Kz3DPDN1xgAhjQgmla4fnu?=
 =?us-ascii?Q?6RdQAAMrIdKf4kfsSEsey1sZ2o6/73o162DDyskszLnvPWZ1ytRQeGitRgre?=
 =?us-ascii?Q?NCggz5wUJM1n/JSl5R4muY+PhQPERzfbnFtUljI5y0EHLzBDC6e1Fg29HE+n?=
 =?us-ascii?Q?hPeBUx3z7btRGtqov/vXmoQEQaHS1tBxR3G+Gk2FBNXm68/3J0eOr7daDF7M?=
 =?us-ascii?Q?zrAHHDNTndVRD8qiDt17UX9Eci4bK6EzkxnVx4UX016V2VHFI+17i4X3xQPu?=
 =?us-ascii?Q?fQi7tS2OYxE9stP9tPHO/1/I2OcweM9uE/T0sYzksqTYmXJTksO7G8aPHOeO?=
 =?us-ascii?Q?kUAYLCSquh62RxGUA11Px6UNujjVLLSbH4ferStweBRGTh00H0P/Cr9fLD4O?=
 =?us-ascii?Q?NdyS2F9RtDmNawh8jONldXmq0+Ut0+6jz8uMkmpOuWHqekzh9RpLjUG28oe9?=
 =?us-ascii?Q?UgXKytdSF+V3/5UcpEhG3+WKi08Pz8nRFDZayN/dcs0HU8XYcMqcam4jEIp6?=
 =?us-ascii?Q?GIpK8AaEa4Dnr7tMHgAGh7CJTplu35Opx3u70XryL9918WLemIDgCjEL1Ddz?=
 =?us-ascii?Q?OrMXiCPTMqJV+bHeGYHDr0OqzT1yumP0rhuxqMc6xrkvpYw2kEBVvGmGbmdA?=
 =?us-ascii?Q?FKS1sMnosFmAMQ7cCqedRby0ajVT2jBVVclOD7npEnbK//ILYnC4+xwxeOaG?=
 =?us-ascii?Q?AYI008RiAYIaB0fgXzdrvMLPO4+JORr6iqaRnu9eBKXhKPF92mJBWa2JdlQB?=
 =?us-ascii?Q?GshsGpgvzqdvsIadW9H7TEAbqe6vLk+JjxBjHg4IjzRxo4anXL+9geJX4Wxy?=
 =?us-ascii?Q?DvTRjYWPs8jZs4oEfd0olcUmbWbGHqNevfORaAJlKiytD+lWuwCY7IlDstZB?=
 =?us-ascii?Q?LXjDZpiWfn4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?48jegmwr6AwyZ2agSJFAde9BtBopFhOuUI/e35yRqz9mprFTEXkR2eYc9xBp?=
 =?us-ascii?Q?/qHEmnRT3DrdvuDlKZI6HTPuXvfFD3VVEAGIv5KnJ6IwARpAf9BAB6B7Te3a?=
 =?us-ascii?Q?OYQ8YZ9kNv/KketDmwDDn5p9XPoMOVOdF979wWXVl8dgSJ/FOT0sBuKBDvXn?=
 =?us-ascii?Q?wU23X7nslMf0b7VNSoQQKp217WYv975gY8GOs4Gl07ylv426mpsO4WZikg12?=
 =?us-ascii?Q?GeIyFC+bCIj+WYVEXC+myL7zsYtNLc+pKKdCObdv02jVvLQbzDly0xBXVI8B?=
 =?us-ascii?Q?QwHYq+CZDjcRqj+RQ8tcnCNml3ey/jRat0Hy1fvXSnjrSeWZeD3C0wWHG67q?=
 =?us-ascii?Q?KRjQXKCk73d5SDpBgYJDVp1O6BwVdsNIBCqLDvN2qz6hHZGg0WbJhWcxQX8h?=
 =?us-ascii?Q?L8vkGX78Jh46FRI6cT7f3xePCjsI25F2W1Y8A5u1NVeLvR4ibFbVkaDr5F1M?=
 =?us-ascii?Q?L1Jn3h7TeqcvQ35XzBngCMQywXRv91nPTyM/9y+lRWJrWz3NPFllSmq7xFap?=
 =?us-ascii?Q?SVICSE7p/RFq5Da6UPWe+wOMPw6hx9UzwJo0DYwJrEQ5eTox0obJMxxl2ovc?=
 =?us-ascii?Q?nVPWuIeu1TA2v4ohMHLQfOmPhszmGdLKylhZP6BgL+Y7NSVuJ8Td4yn3+9mO?=
 =?us-ascii?Q?EJmX+vDk1Eei2eZuJVg6HIMG5i3qjIoPTBNQaq7wle16lBYH4okHEyzc3EHf?=
 =?us-ascii?Q?6GRor9e/4LvkhvTJhxlAi6Z6AURtC13OiuFS5E4xkrf4tuowa+xkuYetKWHs?=
 =?us-ascii?Q?2QC4+mb2Te4tgB8gDX/CK86jOh7+nwOOOtKhPzv9Ml1VZ2kUNSnN7OwUu55T?=
 =?us-ascii?Q?yDycKgy1nwJLAcZIfr5OxD/ZlnImKuNlm7TI8XramX1RscvXwubVuvuwlnJ/?=
 =?us-ascii?Q?UFPq4obfwBPDvUKvjJYcPaIyJg9YXUhPVWZpxCq+rr6tMhPjXtPZ1yZZnYYr?=
 =?us-ascii?Q?P5vv0OEM0xIhybUhEDgvzlFXBMyyXe/faNl4SvE6ze5n7364tkcBg90ZSWfS?=
 =?us-ascii?Q?K+3ypzh2szO+xKjUosvZ9OyiQVMoMNZQ1tzrMZ5SihbwI9yyhFkemmoaoZAd?=
 =?us-ascii?Q?oJ+Ubg5w5Ke9ztl4PRDdhjO2wrKO2GT7fUkvLycvkCguBKh/Z1G9oIuD+9fY?=
 =?us-ascii?Q?rAr5fgNaGvX4t+gqa6WXstxYXa0vH/eXJ1sBVg1+TZpjAqJb7E7fQUlPqYzO?=
 =?us-ascii?Q?KM86gGnULRoUFjP+7c+AER85kvGqUsE8BF47zNQr8JMlBRNXRF//uAf1HBnY?=
 =?us-ascii?Q?TUZ/7X2J3yslZ0FhL+zfYdNX3Lj7zt5qL2etktMkRdbb0kN1QONPgA37ehRl?=
 =?us-ascii?Q?yqvbviRILKezg/gP06blOPQUgXevBXOW2FiydMNzWBmVMJ5vzzlBaWDaizjV?=
 =?us-ascii?Q?lL3u9snjFqAgXgzqkisw30wvlC8g0JI2u7m/4sCJSAOx0KNn3tSe897sQ6a4?=
 =?us-ascii?Q?T2YKpm2+J6uQD0mdsdbWYdRYzqcO/C+P2wEvdboS/Y0uKSU8ikuH7HL6bC/R?=
 =?us-ascii?Q?h2nBDf5m4phUUjWG3RTgVgDgCDIdTxWqIOhDkT19xfTDQiHLHwgZj/arC5sE?=
 =?us-ascii?Q?IHq55A0wFzPt/5Xkt8EdhiYrDRsQmkzqRuif9qr/HIcdFfas4jIF8/gc5LWv?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eece718f-f892-42c1-3bc9-08ddf6a744b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 11:34:03.0663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j28qsrraoczLXobHZaMK3Oz4nwkpAlnRcHniLtvrn3S+xmWz+snoG+8DoQEC4hxp+Q3OEtFe4QEgSsQ2poiZKQ/eGygZPRniT6f6zFEnSGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6056
X-OriginatorOrg: intel.com

On Wed, Sep 17, 2025 at 03:55:12PM -0700, Amery Hung wrote:
> Test bpf_xdp_pull_data() with xdp packets with different layouts. The
> xdp bpf program first checks if the layout is as expected. Then, it
> calls bpf_xdp_pull_data(). Finally, it checks the 0xbb marker at offset
> 1024 using directly packet access.
> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/xdp_pull_data.c  | 176 ++++++++++++++++++
>  .../selftests/bpf/progs/test_xdp_pull_data.c  |  48 +++++
>  2 files changed, 224 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_data.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
> new file mode 100644
> index 000000000000..c16801b73fed
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +#include "test_xdp_pull_data.skel.h"
> +
> +#define PULL_MAX	(1 << 31)
> +#define PULL_PLUS_ONE	(1 << 30)
> +
> +#define XDP_PACKET_HEADROOM 256
> +
> +/* Find sizes of struct skb_shared_info and struct xdp_frame so that
> + * we can calculate the maximum pull lengths for test cases

do you really need this hack? Wouldn't it be possible to find these sizes
via BTF?

> + */
> +static int find_xdp_sizes(struct test_xdp_pull_data *skel, int frame_sz)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	struct xdp_md ctx = {};
> +	int prog_fd, err;
> +	__u8 *buf;
> +
> +	buf = calloc(frame_sz, sizeof(__u8));
> +	if (!ASSERT_OK_PTR(buf, "calloc buf"))
> +		return -ENOMEM;
> +
> +	topts.data_in = buf;
> +	topts.data_out = buf;
> +	topts.data_size_in = frame_sz;
> +	topts.data_size_out = frame_sz;
> +	/* Pass a data_end larger than the linear space available to make sure
> +	 * bpf_prog_test_run_xdp() will fill the linear data area so that
> +	 * xdp_find_data_hard_end can infer the size of struct skb_shared_info

what is xdp_find_data_hard_end ?

> +	 */
> +	ctx.data_end = frame_sz;
> +	topts.ctx_in = &ctx;
> +	topts.ctx_out = &ctx;
> +	topts.ctx_size_in = sizeof(ctx);
> +	topts.ctx_size_out = sizeof(ctx);
> +
> +	prog_fd = bpf_program__fd(skel->progs.xdp_find_sizes);
> +	err = bpf_prog_test_run_opts(prog_fd, &topts);
> +	ASSERT_OK(err, "bpf_prog_test_run_opts");
> +
> +	free(buf);
> +
> +	return err;
> +}
> +
> +/* xdp_pull_data_prog will directly read a marker 0xbb stored at buf[1024]
> + * so caller expecting XDP_PASS should always pass pull_len no less than 1024
> + */
> +static void run_test(struct test_xdp_pull_data *skel, int retval,
> +		     int frame_sz, int buff_len, int meta_len, int data_len,
> +		     int pull_len)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	struct xdp_md ctx = {};
> +	int prog_fd, err;
> +	__u8 *buf;
> +
> +	buf = calloc(buff_len, sizeof(__u8));
> +	if (!ASSERT_OK_PTR(buf, "calloc buf"))
> +		return;
> +
> +	buf[meta_len + 1023] = 0xaa;
> +	buf[meta_len + 1024] = 0xbb;
> +	buf[meta_len + 1025] = 0xcc;
> +
> +	topts.data_in = buf;
> +	topts.data_out = buf;
> +	topts.data_size_in = buff_len;
> +	topts.data_size_out = buff_len;
> +	ctx.data = meta_len;
> +	ctx.data_end = meta_len + data_len;
> +	topts.ctx_in = &ctx;
> +	topts.ctx_out = &ctx;
> +	topts.ctx_size_in = sizeof(ctx);
> +	topts.ctx_size_out = sizeof(ctx);
> +
> +	skel->bss->data_len = data_len;
> +	if (pull_len & PULL_MAX) {
> +		int headroom = XDP_PACKET_HEADROOM - meta_len - skel->bss->xdpf_sz;
> +		int tailroom = frame_sz - XDP_PACKET_HEADROOM -
> +			       data_len - skel->bss->sinfo_sz;
> +
> +		pull_len = pull_len & PULL_PLUS_ONE ? 1 : 0;

nit: pull_len = !!(pull_len & PULL_PLUS_ONE);

> +		pull_len += headroom + tailroom + data_len;
> +	}
> +	skel->bss->pull_len = pull_len;
> +
> +	prog_fd = bpf_program__fd(skel->progs.xdp_pull_data_prog);
> +	err = bpf_prog_test_run_opts(prog_fd, &topts);
> +	ASSERT_OK(err, "bpf_prog_test_run_opts");
> +	ASSERT_EQ(topts.retval, retval, "xdp_pull_data_prog retval");
> +
> +	if (retval == XDP_DROP)
> +		goto out;
> +
> +	ASSERT_EQ(ctx.data_end, meta_len + pull_len, "linear data size");
> +	ASSERT_EQ(topts.data_size_out, buff_len, "linear + non-linear data size");
> +	/* Make sure data around xdp->data_end was not messed up by
> +	 * bpf_xdp_pull_data()
> +	 */
> +	ASSERT_EQ(buf[meta_len + 1023], 0xaa, "data[1023]");
> +	ASSERT_EQ(buf[meta_len + 1024], 0xbb, "data[1024]");
> +	ASSERT_EQ(buf[meta_len + 1025], 0xcc, "data[1025]");
> +out:
> +	free(buf);
> +}
> +
> +static void test_xdp_pull_data_basic(void)
> +{
> +	u32 pg_sz, max_meta_len, max_data_len;
> +	struct test_xdp_pull_data *skel;
> +
> +	skel = test_xdp_pull_data__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "test_xdp_pull_data__open_and_load"))
> +		return;
> +
> +	pg_sz = sysconf(_SC_PAGE_SIZE);
> +
> +	if (find_xdp_sizes(skel, pg_sz))
> +		goto out;
> +
> +	max_meta_len = XDP_PACKET_HEADROOM - skel->bss->xdpf_sz;
> +	max_data_len = pg_sz - XDP_PACKET_HEADROOM - skel->bss->sinfo_sz;
> +
> +	/* linear xdp pkt, pull 0 byte */
> +	run_test(skel, XDP_PASS, pg_sz, 2048, 0, 2048, 2048);

you're passing pg_sz to avoid repeated syscalls I assume? Is it worth to pass
prog_fd as well?

> +
> +	/* multi-buf pkt, pull results in linear xdp pkt */
> +	run_test(skel, XDP_PASS, pg_sz, 2048, 0, 1024, 2048);
> +
> +	/* multi-buf pkt, pull 1 byte to linear data area */
> +	run_test(skel, XDP_PASS, pg_sz, 9000, 0, 1024, 1025);
> +
> +	/* multi-buf pkt, pull 0 byte to linear data area */
> +	run_test(skel, XDP_PASS, pg_sz, 9000, 0, 1025, 1025);
> +
> +	/* multi-buf pkt, empty linear data area, pull requires memmove */
> +	run_test(skel, XDP_PASS, pg_sz, 9000, 0, 0, PULL_MAX);
> +
> +	/* multi-buf pkt, no headroom */
> +	run_test(skel, XDP_PASS, pg_sz, 9000, max_meta_len, 1024, PULL_MAX);
> +
> +	/* multi-buf pkt, no tailroom, pull requires memmove */
> +	run_test(skel, XDP_PASS, pg_sz, 9000, 0, max_data_len, PULL_MAX);
> +

nit: double empty line

> +
> +	/* linear xdp pkt, pull more than total data len */
> +	run_test(skel, XDP_DROP, pg_sz, 2048, 0, 2048, 2049);
> +
> +	/* multi-buf pkt with no space left in linear data area */
> +	run_test(skel, XDP_DROP, pg_sz, 9000, max_meta_len, max_data_len,
> +		 PULL_MAX | PULL_PLUS_ONE);
> +
> +	/* multi-buf pkt, empty linear data area */
> +	run_test(skel, XDP_DROP, pg_sz, 9000, 0, 0, PULL_MAX | PULL_PLUS_ONE);
> +
> +	/* multi-buf pkt, no headroom */
> +	run_test(skel, XDP_DROP, pg_sz, 9000, max_meta_len, 1024,
> +		 PULL_MAX | PULL_PLUS_ONE);
> +
> +	/* multi-buf pkt, no tailroom */
> +	run_test(skel, XDP_DROP, pg_sz, 9000, 0, max_data_len,
> +		 PULL_MAX | PULL_PLUS_ONE);
> +
> +out:
> +	test_xdp_pull_data__destroy(skel);
> +}
> +
> +void test_xdp_pull_data(void)
> +{
> +	if (test__start_subtest("xdp_pull_data"))
> +		test_xdp_pull_data_basic();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_pull_data.c b/tools/testing/selftests/bpf/progs/test_xdp_pull_data.c
> new file mode 100644
> index 000000000000..dd901bb109b6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_pull_data.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include  "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +int xdpf_sz;
> +int sinfo_sz;
> +int data_len;
> +int pull_len;
> +
> +#define XDP_PACKET_HEADROOM 256
> +
> +SEC("xdp.frags")
> +int xdp_find_sizes(struct xdp_md *ctx)
> +{
> +	xdpf_sz = sizeof(struct xdp_frame);
> +	sinfo_sz = __PAGE_SIZE - XDP_PACKET_HEADROOM -
> +		   (ctx->data_end - ctx->data);
> +
> +	return XDP_PASS;
> +}
> +
> +SEC("xdp.frags")
> +int xdp_pull_data_prog(struct xdp_md *ctx)
> +{
> +	__u8 *data_end = (void *)(long)ctx->data_end;
> +	__u8 *data = (void *)(long)ctx->data;
> +	__u8 *val_p;
> +	int err;
> +
> +	if (data_len != data_end - data)
> +		return XDP_DROP;
> +
> +	err = bpf_xdp_pull_data(ctx, pull_len);
> +	if (err)
> +		return XDP_DROP;
> +
> +	val_p = (void *)(long)ctx->data + 1024;
> +	if (val_p + 1 > (void *)(long)ctx->data_end)
> +		return XDP_DROP;
> +
> +	if (*val_p != 0xbb)
> +		return XDP_DROP;
> +
> +	return XDP_PASS;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> -- 
> 2.47.3
> 

