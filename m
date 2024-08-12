Return-Path: <bpf+bounces-36891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948AF94ED9F
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 15:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD1E280DAD
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 13:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD6817BB32;
	Mon, 12 Aug 2024 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DY3EAvGm"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C16175D45;
	Mon, 12 Aug 2024 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467846; cv=fail; b=O/P/1MUh7BFZAlOyiNVQ5QUaeF9J+d6gbZGmBZ79LNIJzT10uNErCCTgV9JkwPAgXF2sDrmhlI5hyxkZdTAPx1V43eBcMqQ6yl8PhGh2tcPdfNEVXe1IKdqrcvJkmQf2TnCrlBOJcrNWThYi1wQGMQCWDIkz4TyTXZxMieqg4ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467846; c=relaxed/simple;
	bh=Zjkrh7ZgZ4Lk6X2et8DX+X0e/5EdMay3TED7wsRcraw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FIj9XOCGKj9DihyIqeeKR1ZvNUptYGe5wPgZ7/14fUs0Y1PAlmSwGSQRFNFuHfqSMRhLnR9yALKBUvYF1mFd4bZT8oXPTX71WfUEK8NzVnXeyQT9B8HrkbvjHaRaMYsN+t18AtE9y2eZrvGjOWZAhZb1gdKmn75UVMqKeykJ6UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DY3EAvGm; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723467845; x=1755003845;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Zjkrh7ZgZ4Lk6X2et8DX+X0e/5EdMay3TED7wsRcraw=;
  b=DY3EAvGmK5fMgfshPAdxySpbqBEyibt8/u9bh/BwF+p1+Hf48IkO3ynA
   hRBUyjo4CnHcVlAe8chGGNbvsHN5kiEWEoHl+J6iue/6ZfLGh1I+WlKBw
   p3Bkvtx2xw/HEbdP8Fd721FIq0syzESGqD+sK1qPfdYwtL6gzXt6DRHfb
   BeH9mdeTcx/yerSXGm2brPJRRVrCEuvIIycLgW/v82+xIEtW0DTWusnXE
   WzI9IZA+TpmxPyHEMBPqFCk49GBoE0/MbXXpyB8qicENkHrPUoeakOYxs
   yfTKhIPSHsk0TAFO5HtDUDNMi5ZPWxveBSrltFIPhr0QFcdUmtqpmMCNe
   w==;
X-CSE-ConnectionGUID: 4WcRfdpWQnqcF75uRp3wrg==
X-CSE-MsgGUID: sfUi6W0GTAiUhq7ziev5Yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="12963174"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="12963174"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 06:04:03 -0700
X-CSE-ConnectionGUID: DlewEF70TquIh4+pNj6Lig==
X-CSE-MsgGUID: BcDYp3XLT/iv0DJjdaVabQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="62386971"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Aug 2024 06:03:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 06:03:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 06:03:50 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 06:03:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l54sRiBNW4jfEsCxfALtZTRXiY7RhDtxlUcW/P0w6LmDB4Ne4NlQCuL/rFVFaYmehyrDaF2MzcyHGW0mgkyESeni/s8U+RjDlXNk4QiJZbBKGsxsKr43iyFyf2iVNnj5hk0BqtJiZiejZB2uufq13woyaI+6gyqPOR8UNUC9DVS4UVKrGIaf5sVOug7NAHbQGRQYcUzfBdCCmDQ8UYJCmRgkvciLOBxplc5KDSAs25UC+9X44tnztfKYOobRnkHN6rDijP/trE+W7B/4vESpfY0iAdJp9CSpSxLCDH4w6+IUMJLYoN+si+ArZvM1A52KbRlRB7Ah36F/8HKPSAMdKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBWtN6EH4yuSKF9KDqcyy70oBbKv9RnOXy3c6N9ibGA=;
 b=i/9vlkuTaM5uBIgS6Sd263IihKVaxiYgJrVuvIuYZDA+KnwLx4cmVKMIDoh/Bv2ZT92qdvW9mmyfo+d2WD26yZDweo7PJKqXuwFLa0fN2w02OuknZDQ++v+uHU9TardvBKfM1bqybZeTl32KXm70LNNeJ85qklnZsxQtFfvjgMrq6fOd9auLzSNXq4onPZVQyOq+N3s7z4XQkDZwE5z3kHWgbxte5mqlhNZJMW/B7gcHrOh1GwV0x/iWp8et5VJiMVlkDPbP+hmv/nQaHDixyiWZ4rMcWDZOhlKlvlzKxCHf5RXfP9qcIJbhtbZrsAskabCaCReZZlE53ybx5qIlTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MW4PR11MB7152.namprd11.prod.outlook.com (2603:10b6:303:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Mon, 12 Aug
 2024 13:03:27 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7828.023; Mon, 12 Aug 2024
 13:03:27 +0000
Date: Mon, 12 Aug 2024 15:03:19 +0200
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
	<amritha.nambiar@intel.com>
Subject: Re: [PATCH iwl-net v2 5/6] ice: remove ICE_CFG_BUSY locking from
 AF_XDP code
Message-ID: <ZroIF3eSlQuAk9Zx@boxer>
References: <20240724164840.2536605-1-larysa.zaremba@intel.com>
 <20240724164840.2536605-6-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240724164840.2536605-6-larysa.zaremba@intel.com>
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MW4PR11MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 64208ac5-afed-4fd7-84a3-08dcbacf283d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1i/wVDaWD858K7lVkvkZTT2+ZhxD/MQ8FJR+Fto6mblYYpuDudcDxEcrZ3GV?=
 =?us-ascii?Q?WVR+T4z+Oufg/oKUyl4DvonCg7BSYC62XFsCucHs0LSvnXy2mv06lNZD3NA1?=
 =?us-ascii?Q?ypNLceUpcyVEbXLzxRZQOpDrMMzPL1VHDnt5gJQsxDfFKU2ZzlFWWoznSrVS?=
 =?us-ascii?Q?7aJklN2XB5EHn59WP7JapIV8DUgsZpCESd3dgFjGISUNTdBU4LuiY0OL70k1?=
 =?us-ascii?Q?Jzuf/OPa92cRBLx8/uO1cbE0cFkP2msxq43JDum0RtxsKf3y5EB7Zyfss5tc?=
 =?us-ascii?Q?B9Mym1+J3qL6wkQ3ZRZk8cpmQhLElbAtQ06gfQttm/DKO9VhpEZ7L+JvUVwJ?=
 =?us-ascii?Q?gj5lltpTNJSTg8vinmlaj0Pe3bZ+O2FqpaoYjHwBHRtvUhNSLHtn1MqOC7K3?=
 =?us-ascii?Q?RcEyAnylTuD+FrZOT1Gg0xfSLgt5J47Bo34Gdu2bNN17/TRx377dQ9iyPIZt?=
 =?us-ascii?Q?o1QQzConteAdeuA+jcjldGu9LIo1yMdMjGvpSg7onqZYNz8MMsTl/i47bhZw?=
 =?us-ascii?Q?baRwSBuA37QXuSIkB9pan5pNQtU1zJs3UNPL/zGwYHKWaCref/bFfF+KpBSL?=
 =?us-ascii?Q?khsFljAu6F0pvQJ6SDRPRH0RBZS9aTxwsebus/eSODEsWEITHQXugfG/EV7k?=
 =?us-ascii?Q?zQLWcFa+zdRxE+VCNVRhf6btYf8ueswhs5XE7xjYTYh3YyuRtMiCodSS4B3g?=
 =?us-ascii?Q?SkUjpbhLnRbok+urPUL+sQ/ZX5vNg0G9bXmlUD4tanjoR+GWEpM99sFF8Q1Z?=
 =?us-ascii?Q?HkEk2EV21tVFwmJQDIPJVNutQRojh2YHosyzQIU4usqoes2QBM00JyGJkrRU?=
 =?us-ascii?Q?VAxYQkZp0dwTMQiMqJ5JTXPOKbYOns+Q7cliaKofdbNL1F3NRCYYJ48PgHZk?=
 =?us-ascii?Q?nRGAveJaLtEJuZlLzoqd6CqlGNVORdJkQZYgawMzCtzjf8Hu7B9VlUyyFk//?=
 =?us-ascii?Q?B9Hgb/kMvbYuBzafD4kJN7u05twzyPSlt+pYusjrV4KxGcbtkFjrF9Ruidvp?=
 =?us-ascii?Q?c609zcGkCqmWlr/tMROcVNFtlpRLBkgxSoD3X2pIiOC6ZQeEu+2AXYCEbgaV?=
 =?us-ascii?Q?nPdtgk3DaIgXIkDuFvZnewG+nsAf24Jqq0wlGHr+w2HMaGBD0Pgg8ic8EBMU?=
 =?us-ascii?Q?nby5OtMgGbXgGDLAz11VeO5Wu1grl0O9J+uM56rz4G9bwon9JqlTkcsBcwnT?=
 =?us-ascii?Q?fzo2a6t/D03BBOPhNkgLTwOxXFtA0ALzoyfsiDq/fpwBiVQu3nMBJE9HKp8I?=
 =?us-ascii?Q?bHBgLDTuPQ4pw74VWYDFNm7WoXIXpaWPLkYWo/VMjy4wPM3CCfjcmVpFEfUM?=
 =?us-ascii?Q?IJVpQ46HECzA4/bBOZZLcco/xiprgZ6bK7CilEYqEANXaw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D3nxdxbUQNZtvTHMjL09SpcjnJzz37BqYCI4eSjHsasXeBfXbqWkK14cCaI8?=
 =?us-ascii?Q?tjwQIWvVU3rZFoHFGvETFtquwMvVBiVp/wQ6sUrPH2XBcosKos/arQJ8C/a6?=
 =?us-ascii?Q?dAyDlHiwsTRfuShboc330JptQYMHrWZU4fB5jw9DmE37mBzsewhXnf4w+zTg?=
 =?us-ascii?Q?y1qBMhFNdDMUOWUw1TQu4xR590nhUJhzkmacmnTb+d95pO1MdyshHxBk3mvK?=
 =?us-ascii?Q?aP7gBvTj13FRdJuJ4I0vqSi+jkpuLsyqzexh8DkTkRzmTHcukaIo2rnmQoEw?=
 =?us-ascii?Q?z26V9HFUDRVPSwUyo4yc6+gIC6WqQHk0lKWSbPb7LujLossJiovSbru3hEsD?=
 =?us-ascii?Q?RR52veAi5m88JU4rdG9fR3xjSetfkF6sJZjWjbGX8wK8FsqY5k5SQ1gtdFuD?=
 =?us-ascii?Q?QLwtvXrtfiM2mGh+pQLYrE09NvmCrqp73aEZ89+9EhlaYeF7pqdgqlgOWoRx?=
 =?us-ascii?Q?U8afIsx/hd+nFjrDh8nw2yoIbT5wZpt8UTzxKUJMHL2CeCEXu9k8i3Go1yCB?=
 =?us-ascii?Q?tzkOJ7mBMb4qT1WJFTTlUUtExW0Mr6fUGMdzkrF35B0xN6lRO2z+E66G9+UK?=
 =?us-ascii?Q?sWApOZiSFhgmzsaIhNtB//5PLO3KBjDWBpEcFzTTafw0dQjcpuHcVcj0hSAJ?=
 =?us-ascii?Q?q7bWP9Vs4Nzd6m6c2MhlR4x5AmpfJIkmjqaGwZB6nGFLmmYs8wvMncnP7BAs?=
 =?us-ascii?Q?wnurQjlYWpSDdVqokU9q4UFfUq3AMkxIYx4bP9EiMAw4PuamYJZ/O4K7NevD?=
 =?us-ascii?Q?1J4tEWOWIKCdq6wsUFMw/NeaH98ytwjg3Izgv8jOqitMysuNK442RztI7Rj/?=
 =?us-ascii?Q?9JfK5ZnWYhMPhu0Xewxc2KjvJTyUL4RPzjNpW3znoqtkqVLw6OmBZVwNsAXS?=
 =?us-ascii?Q?NLwWucI7WOjVpUW+TqQkFbnG0EL9EVrk1hmmPKnTGVJj+MgTGCpeZkfqjASG?=
 =?us-ascii?Q?6mGnQhdSOs6jmmjUYr+UxSN25yeaY47YHHxtljB+EQZWJ0NZK9y+tAhgxt85?=
 =?us-ascii?Q?jIaGFPkJX6X1kmnTt7SjKnz4OwTHYuFcWr5mxyiIpZ3s+V0EiZnMInq8VmTy?=
 =?us-ascii?Q?lInXU17e9CCLuK0hz7XUbRWma6Wm8cBy5ffjSgOEDdXDHGZ6/A9e3ShWPA1z?=
 =?us-ascii?Q?ybOGE5rouFSBnhC5ZR9NRBj82Xw1bk0TgSDsYbhFe9iiFwydX/PAC+yDAp1v?=
 =?us-ascii?Q?nheK11h/5f6XYJlzoCEqwtfNh/34S3ctLf3xLZluSXTFZimLk5HqlprlzB03?=
 =?us-ascii?Q?AIcRLzSOAdko3Gp70enPI+3zXaq3JwQEwCb+6i8QxWjuuWT5Pd9CawYnFA7K?=
 =?us-ascii?Q?ILA/8uk9V7/wSJaZUWllmuog6ClKU+q2jVZ5+B9/ocMmjs4gEY0wNfDhAFW+?=
 =?us-ascii?Q?HyrfYL01IAkfAkm1tuchir1f0bSFCGNOy+C29O8ny71BeZPbjvHM5ObMIhkq?=
 =?us-ascii?Q?m7uDwwza2WeBiMqARy4xTYDJxvnHRsCw2opBZr6ggPpIEGJVD09STY6juLI0?=
 =?us-ascii?Q?yKyQW5na/QYnzzFV+v4o1EuWCP1pcwK05CtW0Y5B5mtywEDjtwfcbszo43JW?=
 =?us-ascii?Q?nTN9L3rvRH3Pw2eIq8xyMWwGqfICfOPaqGvhfQi6b4ndtkGa15a0lQ/0KThL?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64208ac5-afed-4fd7-84a3-08dcbacf283d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 13:03:27.7786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YHe4hKh/fTO7oFySF1j+vWGIfxjQsJ4dYoCqpz4MZr40wk5xybpzodIaA89w5kZB9k8XaKgpShNMzL2g1aFZ0yEcoQkrbRF6n79EHtJogM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7152
X-OriginatorOrg: intel.com

On Wed, Jul 24, 2024 at 06:48:36PM +0200, Larysa Zaremba wrote:
> Locking used in ice_qp_ena() and ice_qp_dis() does pretty much nothing,
> because ICE_CFG_BUSY is a state flag that is supposed to be set in a PF
> state, not VSI one. Therefore it does not protect the queue pair from
> e.g. reset.
> 
> Despite being useless, it still can deadlock the unfortunate functions that
> have fell into the same ICE_CFG_BUSY-VSI trap. This happens if ice_qp_ena
> returns an error.
> 
> Remove ICE_CFG_BUSY locking from ice_qp_dis() and ice_qp_ena().

Why not just check the pf->state ? And address other broken callsites?

> 
> Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_xsk.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index 5dd50a2866cc..d23fd4ea9129 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -163,7 +163,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
>  	struct ice_q_vector *q_vector;
>  	struct ice_tx_ring *tx_ring;
>  	struct ice_rx_ring *rx_ring;
> -	int timeout = 50;
>  	int err;
>  
>  	if (q_idx >= vsi->num_rxq || q_idx >= vsi->num_txq)
> @@ -173,13 +172,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
>  	rx_ring = vsi->rx_rings[q_idx];
>  	q_vector = rx_ring->q_vector;
>  
> -	while (test_and_set_bit(ICE_CFG_BUSY, vsi->state)) {
> -		timeout--;
> -		if (!timeout)
> -			return -EBUSY;
> -		usleep_range(1000, 2000);
> -	}
> -
>  	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
>  	ice_qvec_toggle_napi(vsi, q_vector, false);
>  
> @@ -250,7 +242,6 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
>  	ice_qvec_ena_irq(vsi, q_vector);
>  
>  	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
> -	clear_bit(ICE_CFG_BUSY, vsi->state);
>  
>  	return 0;
>  }
> -- 
> 2.43.0
> 

