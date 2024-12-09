Return-Path: <bpf+bounces-46391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4339E9685
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 14:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80DB4283446
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 13:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB751A2397;
	Mon,  9 Dec 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0BdYbWo"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CD41A2390
	for <bpf@vger.kernel.org>; Mon,  9 Dec 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750288; cv=fail; b=fojbkPPf/27rMEC4T9P5NeyO4BG/ScJ1LnXLfYY9BYPls9eIcBcYumHwF0dC4qlbCriuf6N5DnZlMV5VGHKXSnymXhhbmQW9jwO7+3vR6KlCZSkPLnu5qWGF9y6P1ZxlzjUyyvyZeg79iqLYJBiUcj0G6XTeWK/0kdZLbqqp6Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750288; c=relaxed/simple;
	bh=MPnM7ig0pE3JUbYUWRjnLrhric5CO1WJ0LUeqnMSt5I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jziH6fWgZb/PuOEHAR7h27QU8KR97DLrT0VKpB1l5jHvG6susixv1/M2Q77R+yXQ1gc34bmOD4E4p1NMYQgxdY2pJhdl9rgxhP7YqH41999pZTZaD9eF4D3SfQQKkFP2QAbiFepBzpc8DwmQrznxwKWUlga9uEtqX0IjJBKFmQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0BdYbWo; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733750286; x=1765286286;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MPnM7ig0pE3JUbYUWRjnLrhric5CO1WJ0LUeqnMSt5I=;
  b=V0BdYbWoxHhKNhuQK4UGJO0lLs06R2EanIVMMCKDz+s8fb3la55PwWMy
   7SWJtIv29Uatz9WZaEzpQc3HT+xJOv7NPfgBu4BKMRtJUknjYSbIzrTFW
   QKQFf4rlEA54wnObxlnpiYxjPO8gItANhgkXsw1Jy6KWd7+4YgPw/cjMz
   JT8xtpMntFNj3UcNYm4h2XJUeYaWGydlHJJKcCIUqY+7EReweWYvulj2M
   h6HIwzdrkEYACr+QO4FbDO0ntE3uhOosF9csjyWZ9M5lfeHyZX2RRG9p3
   AePhHCowVUO9KNhqekxpMUbpoTDwuceHivaJBzKVC2iMSpv2tZIhHvAOY
   w==;
X-CSE-ConnectionGUID: 2mu6Oes7Rsm5AlE6rFDbew==
X-CSE-MsgGUID: uIvQxQclSZ2UH6ErAJFyeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="51459699"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="51459699"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 05:18:03 -0800
X-CSE-ConnectionGUID: T33pfk5ESceNXIC8l2ZzHQ==
X-CSE-MsgGUID: LGPUqIruTM2OzJBBq3I+Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="94870561"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2024 05:18:02 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 05:18:02 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 05:18:02 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 05:18:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aB5CBaUGp6Rtwk7hzQvO7XgshpH+ziANlz4Kli2KT6bN7zQ2LNhEQ3Py2H+PAqSzQeBqxgJcKzSo5CV2cJyklcu6rPbuLLON1ekwNwr2/S+cf3Q0dGI83HyqTOYponrFKRANmfVC7yobrgOqJeqMrFpnLSDnugw0IcKCF1ccuWggjMkpfObUfPvHr3OpnbUBNP0YDFziV4CmO5j3ZhTcQuwdM+3JNI2mEAZJNta7gFMZMg53pCtUlZ6iHViCsSvZKvy5N2/9kGb4OYcCKp6sNv7Eosy81cgEsO9qW5O1IE8zgaM8qKGwG2lAWYmSzXNlwiSqB0SiRuyqQAf9lD9+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBdhmSj2tqs1hF3IRZ76jOHV0ti6tM71EU1zKEeVSs8=;
 b=ocKDi+apvDQQpHbg+YNJwfHaFF2IH9bYGXHRZj53BT0nptZ9vDJuQ6/Fu081q5jS+Mc4Bmt9sHZa9trNtEYmNo9bY3VICTwPtFEdTsqICQjrOPy/sQ+DgzlK3wKYoMOt7gi6gX44/jVpA9GFzGU+dDBwUexg0YgW00lYt/IHf6h+QXjvKzSftGQflWQ+25E+0sZOkVMaE3Iv+Oh4ce4zEPWLXHjMiAlwFBnDjbW0gzPl/N/wHeh5CUacma/VzXJ72Fs5a+3qdjDv1tSXz/1my17CK/RFFOxmTJz/GcxMTT2rqOd//2qFDdffQM3fTZ5guyHo+jDnjwcvmZFeCtEjDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DS7PR11MB7691.namprd11.prod.outlook.com (2603:10b6:8:e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 13:17:54 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 13:17:53 +0000
Date: Mon, 9 Dec 2024 14:17:42 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
CC: Amery Hung <amery.hung@bytedance.com>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <sreedevi.joshi@intel.com>, <ast@kernel.org>
Subject: Re: [External] Storing sk_buffs as kptrs in map
Message-ID: <Z1bt9g5q22aYF1t/@boxer>
References: <Z0X/9PhIhvQwsgfW@boxer>
 <CAONe225n=HosL1vBOOkzaOnG9jTYpQwDH6hwyQRAu0Cb=NBymA@mail.gmail.com>
 <d854688a-9d2d-4fed-9cb8-3e5c4498f165@linux.dev>
 <Z0dt/wZZhigcgGPI@boxer>
 <d1e95498-4613-43e0-bc6b-6f6157802649@linux.dev>
 <Z09uQ48lKEsORsS1@boxer>
 <ecd47c2c-7b34-4649-ad97-3988c7644317@linux.dev>
 <Z1MlVa3OXQJw0VXm@boxer>
 <176ad1b2-034b-4b10-93cd-f03391820e24@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <176ad1b2-034b-4b10-93cd-f03391820e24@linux.dev>
X-ClientProxiedBy: ZR0P278CA0095.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::10) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DS7PR11MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e9cd69-6c63-40a5-8174-08dd1853e39a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aoqJxZcBU2BlN9c320v85n/JqaoNc14vYotMcKwW23uwj++bV2Xz8L5A73sa?=
 =?us-ascii?Q?vxMR3HHfHhwjJTGoUM5JppjCaMi1wEXtefb8MXkI93knol1E0BvLARM0bpJ+?=
 =?us-ascii?Q?YthoZaqC2cfKXNKg/8Z4pM4tN7VDRLocTZ6fqZt+wW4wt0LwPj/l6q6qWvKW?=
 =?us-ascii?Q?3jRd5IoufIcNiieGySn9/PecNrAPy6WqgqcsjxqCsggCSWjqF6+4TO6grc/k?=
 =?us-ascii?Q?AYEcTl645GSbSUecKLQbUFTLRlMFSN6JTUeVPOsV9XsZS6oG8RTFNVDknE6r?=
 =?us-ascii?Q?V8yyg3d+qV4j/goPcIRQ4nceT+f9rLNBzOFuMKqctbJDvPvh3HtLDzxUIsBn?=
 =?us-ascii?Q?SZpZQJZ9Wx2ytFvM2PnhZTIZ88OiO89R/21vkIXkZB563EaLbwi56r6ZU270?=
 =?us-ascii?Q?Dh9uxpyv9sAHBvF3HGv2CtuUm7MYz5Tm3jrmRuO1QSlQcg2Yro++uK+r1STH?=
 =?us-ascii?Q?QhjnOEe2+0bxwaL8v4ZDplANcY5mqahUveekqht0VQ0yCwnnlUVLbVnDbdet?=
 =?us-ascii?Q?GrbV9FICJi9pvLVgmuxdvMwQ8XwTeRa9FHWPYEAhcW5Z/Mv5uxtE8qCiHfxm?=
 =?us-ascii?Q?bCnuu0ZD0WMKO3pGXCytNSss0x3+kqXmO7cLKB/Q8M2g12KsRbfIeLJrOR1y?=
 =?us-ascii?Q?KIGMmHYfnVQzvRTQ02m48pr06tUNGYvElrJVSRYfleq3F0qp9V69R740xxW/?=
 =?us-ascii?Q?Oq9kQt6vdAG9QeMuyFInOz/SBI+oLUih8C1gO1QXoNfbmEPGw5fHwPj3xHzz?=
 =?us-ascii?Q?W4dvBi1yWEqfnbsyx05xctOBPpes6zTFaKt5WFdgZiNT8NRH/detRERThcWC?=
 =?us-ascii?Q?pvVML4fayUXUN0Zji4pwhi6BbEJ12/xvZBwWNEyXQBPcmy5tZGA1a4Tu/Aq5?=
 =?us-ascii?Q?1lxENS1Y8skazrrzafQE7+U3Ig5kA2gLfpSZqRGJPdb2dRJgyopeyPKUVh5R?=
 =?us-ascii?Q?P7gLrZtL6d5fG+NuoB2yNqSVzqEvDRhrCqGq4CLEggljKiGxloTLNC9YmLcQ?=
 =?us-ascii?Q?zutGS5gsfVgU/mD1gueOT+4YvbVfDcW9GkUcNFKbSdNEu7yDdcbT92M46rqS?=
 =?us-ascii?Q?PB+72ZvbhCKYa7KF6Yo2ucALOXSgV1MGzDj99hdKjHih4tR16G3kPefzAjkx?=
 =?us-ascii?Q?VrRysfbvQC6lH8wMevsEPltJ0ApSctmdJ1nvge0turXjrJjL0pnCNiPuN8X7?=
 =?us-ascii?Q?hsS0VUydWHDlQmFusZInlPXQgiO4KIDPE+Zs1VSA5TmgRtZnOWCw+wmCC0jt?=
 =?us-ascii?Q?W+mow3Fa4o7F5RJTZKwrsSXuqxq+0LGaAaiVgCnv+7iJqz5ZgbDRJmMHa9Ar?=
 =?us-ascii?Q?pYmIm2y+Be+jKrbIyZQHRgOsGRzk+tKe696jPk8Pr2Qjug=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ioh4TyXXS6jSC6+Q0LoXu5WUPHJKpTsNZUT7rp/QgNrFKoDh0stk2Rsxvvo/?=
 =?us-ascii?Q?tFJaY8Dvc67pKntU2f66CTgcQOm9IOZXUyQ/l7LERLpPIS+eSX5CH1tAq30V?=
 =?us-ascii?Q?Rht7tft1U8vAadI/2n27RZ8GS1U3mnmYjn1dx+3b6leFbOXF4Kh7GVznd8BT?=
 =?us-ascii?Q?BnMfa9i5cpCrKyw4uw8IJRSoZtB7FjW3Ess+2x9t0rxEd73ggjTIFtraro9N?=
 =?us-ascii?Q?ASmCpsTvX6SvRRUCC/pBNqU2fzjA0ALnpnHyEYPETPtgI+qQ1m9UfxsBOWBf?=
 =?us-ascii?Q?BD2ZMFJ5G3MpBphb7FNMVoV09LIItJ6ddSj1E4tztI0eCui86pxgTrpeeaP1?=
 =?us-ascii?Q?9aK4bTQwERRqFZs2ADK9wSJPhM+T0vIB3R6+dv5PE0aBagCgqD3xL8Yllm7t?=
 =?us-ascii?Q?PsNoQLIQvYKH+VPa9zqNBKzefAp90wXtnB8tthj3g7sQZzVEBxF66PKkRnnP?=
 =?us-ascii?Q?ShXXyDYV2R3M7jcFDa1r2vusorbrF4poi7s16bHaq+LqJmGmAtXuXpC/B3Li?=
 =?us-ascii?Q?QxiwPDYPoJK95lZufrMc0V3J2jwpeBu7T8iUuz2sX/q9uDaFn8CJi8fxwI6B?=
 =?us-ascii?Q?Dd2shK4zvlkrI/t2vqPiLxtiPTe6L70jeebhgQQPKGHMoZNIyHaYVcUoty3j?=
 =?us-ascii?Q?vb3LjD3KdZ4a/TbKeL2dY61Gl8TRAvI2PL34XDRSJNJnM9ABbgtEIRx8PMIA?=
 =?us-ascii?Q?5w1Kh8rx9YjyclYw/lgA1PCeja2d4CLtB5D2KglzhZn8r9w/5wJP0ZXaj+Vd?=
 =?us-ascii?Q?w6RBKxGQUaVNB20cGvxRns4cNprpHCqW/qkgKjYTXfkYxtKboC2BpnDVkDMg?=
 =?us-ascii?Q?XwtHWfnvPw6Hf6ksJZDSPlihvv/OTN7QOKDrUsLx1jCt2Yy/Er4kVXvydLTw?=
 =?us-ascii?Q?iC8h9By9r3Vh1pNHTuZLtAW9gBiAljRQxIDZbEixKabf0jJVRO/4k8XTIupm?=
 =?us-ascii?Q?fbPAC5OSCCIQC3l+eJlmyYe+Ajxrk5MPu3x4MWVNyWouBQ5FJyz6ywDl+/0K?=
 =?us-ascii?Q?TX49iDXko0NEZqqZgPnP6U6Pl4fK4ZYoF988xeXQQTU9WrYypxyfZhIj3pTb?=
 =?us-ascii?Q?XfpywQGY1NkGknr+0V6gW8jQCcFlge1BY/sQWRtY/lKaVq3vUIlrxD8qIW/3?=
 =?us-ascii?Q?IdDd83dur9WgYK/IJRK6T4JnVpxDyxCVOedO8WXaDjSTRZPJaEXNNJ4JxFIw?=
 =?us-ascii?Q?NxFiXCKjdbDU4OqaC1kVRPIQlWqzADTKI9Q/ASWNeSA+T4ZtUVDGplD4oUum?=
 =?us-ascii?Q?qvSNKlZYwHeBm3V0NB2Xbb2/3ZduCBQfEmramg7oXcThjAupZvwxGCj60H7f?=
 =?us-ascii?Q?zcgsDpQI+dwavTfgULfFmH7k/posEKeC5xsHnfJGQFf4e0IZc47Q0kzev2v+?=
 =?us-ascii?Q?bqihj11pah/Pd2rcz9IWe9ktxaoMsXCyyXvQt5AjL3eduiI3GlDY75i3+3TB?=
 =?us-ascii?Q?JNJIGP3YflBCGxXkTzugIRGpPAzBInKcylvmo0gMuxGbetd9doKpP5lGhkUi?=
 =?us-ascii?Q?UbaQNzUZ89qRMsjcnbokw6JEU6zGx64Vs1ej9TpjGKTdaMLesLqNKg2DcUzQ?=
 =?us-ascii?Q?ZhThd1oiccRN8a87bcRNi4R1WImBPYRy3R5Nfzmb7ejZTBn7nKfhEzDCouqD?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e9cd69-6c63-40a5-8174-08dd1853e39a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 13:17:53.8244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWoRtH4b30MB5uUFDTWVs2GkQlAHpib2gO7jcaPnOTkRos/m/qRr6RoW5laPlgR9xUdMVPVv3QtdzSlt1Xcwefjv0WvYGXCG96dXr0jQ2LY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7691
X-OriginatorOrg: intel.com

On Fri, Dec 06, 2024 at 04:36:03PM -0800, Martin KaFai Lau wrote:
> On 12/6/24 8:24 AM, Maciej Fijalkowski wrote:
> > > I think we can remove the projection_of call from the
> > > bpf_is_prog_ctx_type() such that it honors the exact argument
> > > type written in the kernel source code. Add this particular projection_of
> > > check (renamed to bpf_is_kern_ctx in the diff) to the other callers for
> > > backward compat such that the caller can selectively translate
> > > the argument of a subprog to the corresponding prog ctx type.
> > > 
> > > Lightly tested only:
> > I tried the kernel diff on my side and it addressed my needs. Will you
> > send a patch?
> 
> There is no real kfunc taking the "struct sk_buff *" now. It is better to
> make this change together with your skb acquire/release kfunc introduction.
> You can include this patch in your future set.

Ack, good point. Will do as suggested.

> 
> > 
> > > diff --git i/kernel/bpf/btf.c w/kernel/bpf/btf.c
> > > index e7a59e6462a9..2d39f91617fb 100644
> > > --- i/kernel/bpf/btf.c
> > > +++ w/kernel/bpf/btf.c
> > > @@ -5914,6 +5914,26 @@ bool btf_is_projection_of(const char *pname, const char *tname)
> > >   	return false;
> > >   }
> > > +static bool btf_is_kern_ctx(const struct btf *btf,
> > > +			    const struct btf_type *t,
> > > +			    enum bpf_prog_type prog_type)
> > > +{
> > > +	const struct btf_type *ctx_type;
> > > +	const char *tname, *ctx_tname;
> > > +
> > > +	t = btf_type_skip_modifiers(btf, t->type, NULL);
> > > +	if (!btf_type_is_struct(t))
> > > +		return false;
> > > +
> > > +	tname = btf_name_by_offset(btf, t->name_off);
> > > +	if (!tname)
> > > +		return false;
> > > +
> > > +	ctx_type = find_canonical_prog_ctx_type(prog_type);
> > > +	ctx_tname = btf_name_by_offset(btf_vmlinux, ctx_type->name_off);
> > > +	return btf_is_projection_of(ctx_tname, tname);
> > We're sort of doubling the work that btf_is_prog_ctx_type() is doing also,
> > maybe add a flag to btf_is_prog_ctx_type() that will allow us to skip
> > btf_is_projection_of() call when needed? e.g. in get_kfunc_ptr_arg_type().
> 
> It is pretty cheap to do the btf_is_kern_ctx().
> 
> I don't have a strong opinion on either way. may be a "bool check_kern_ctx".

It's just that this flow to retrieve both struct names is duplicated,
below would serve the same purpose...but I don't have a strong opinion
either:) anyways, thanks for discussion!

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 4214e76c9168..3c6acb993d5b 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -577,7 +577,7 @@ struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf, u32 btf_id);
 bool btf_is_projection_of(const char *pname, const char *tname);
 bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 			   const struct btf_type *t, enum bpf_prog_type prog_type,
-			   int arg);
+			   int arg, bool check_proj);
 int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_type);
 bool btf_types_are_same(const struct btf *btf1, u32 id1,
 			const struct btf *btf2, u32 id2);
@@ -653,7 +653,7 @@ static inline struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf
 static inline bool
 btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 		     const struct btf_type *t, enum bpf_prog_type prog_type,
-		     int arg)
+		     int arg, bool check_proj)
 {
 	return false;
 }
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e7a59e6462a9..dd27eb35b827 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5916,7 +5916,7 @@ bool btf_is_projection_of(const char *pname, const char *tname)
 
 bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 			  const struct btf_type *t, enum bpf_prog_type prog_type,
-			  int arg)
+			  int arg, bool check_proj)
 {
 	const struct btf_type *ctx_type;
 	const char *tname, *ctx_tname;
@@ -5976,8 +5976,9 @@ bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 	 * int socket_filter_bpf_prog(struct __sk_buff *skb)
 	 * { // no fields of skb are ever used }
 	 */
-	if (btf_is_projection_of(ctx_tname, tname))
-		return true;
+	if (check_proj)
+		if (btf_is_projection_of(ctx_tname, tname))
+			return true;
 	if (strcmp(ctx_tname, tname)) {
 		/* bpf_user_pt_regs_t is a typedef, so resolve it to
 		 * underlying struct and check name again
@@ -6140,7 +6141,7 @@ static int btf_translate_to_vmlinux(struct bpf_verifier_log *log,
 				     enum bpf_prog_type prog_type,
 				     int arg)
 {
-	if (!btf_is_prog_ctx_type(log, btf, t, prog_type, arg))
+	if (!btf_is_prog_ctx_type(log, btf, t, prog_type, arg, true))
 		return -ENOENT;
 	return find_kern_ctx_type_id(prog_type);
 }
@@ -7505,7 +7506,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 		if (!btf_type_is_ptr(t))
 			goto skip_pointer;
 
-		if ((tags & ARG_TAG_CTX) || btf_is_prog_ctx_type(log, btf, t, prog_type, i)) {
+		if ((tags & ARG_TAG_CTX) || btf_is_prog_ctx_type(log, btf, t, prog_type, i, true)) {
 			if (tags & ~ARG_TAG_CTX) {
 				bpf_log(log, "arg#%d has invalid combination of tags\n", i);
 				return -EINVAL;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 60938b136365..bb636f53dfc3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11604,7 +11604,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	 * type to our caller. When a set of conditions hold in the BTF type of
 	 * arguments, we resolve it to a known kfunc_ptr_arg_type.
 	 */
-	if (btf_is_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), argno))
+	if (btf_is_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog),
+				 argno, false))
 		return KF_ARG_PTR_TO_CTX;
 
 	if (is_kfunc_arg_nullable(meta->btf, &args[argno]) && register_is_null(reg))
-- 
2.34.1


