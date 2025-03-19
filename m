Return-Path: <bpf+bounces-54388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FF1A694FA
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 17:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860881899F5B
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 16:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497CB1E0E00;
	Wed, 19 Mar 2025 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqQGDD5x"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE07E1DF747;
	Wed, 19 Mar 2025 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401804; cv=fail; b=Id6hFM1Q6Bkwme1CZWab4n1353T99SbiSJiKDtNuurX9rKUP4B2pFf70Q6U0GvLeJSMUDaVwV4y2bjh6OvL59rM0rQkFmQmA02oKxR5c3oklw2wPvQ9ItPcZOq6SgC/R/ZCOdFtxMvXq3WrGbkzf0eYlBCjaoTu7BFCRD6ks71Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401804; c=relaxed/simple;
	bh=oSMgqB8UvkJPB1PRaF4xeDeGvA7BqzZ0WhZ1OWM4B0U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VEJWbkAABp3cJBv+NoT9mUrPrq5EVmCF7cOyCxVKlJ2h17nOXJVtmOuRtJj0wrZOnmNw85QnvpGfLLUBqDwKJAIGm7gZ8NnXpdGBh4UldK1nYRmMKwz/8JYUbOk2e33SkYZHcFiv6ZifnwBxFxfmg3yYR6eLMfVwmKUGWz7H1x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqQGDD5x; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742401803; x=1773937803;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oSMgqB8UvkJPB1PRaF4xeDeGvA7BqzZ0WhZ1OWM4B0U=;
  b=EqQGDD5xE906/KiPdSQnTwVhGOzeud3qCzn/P6uCCzZg6WZ4DJDLfFAh
   uh4x53oL9M1xG29nYM5eGAEJ6eYi9SPr3/OenHk1Rqlzs7kbHujfk8EXV
   hB3XKRfdZ6wY3GeR/A7qLO/yFSBhINLSbxmKCogMGvYtAoq6AoUqDRxuS
   Yn4s+v4jXbj/2gEPqP3RNx5nlhzhpTCowTY21BvKx/9Bb63SACVA8D/0S
   vped4ovUMRxYnlH40csqdeRhOMUuKDnIuiKnNopEzHhH6Ac0hNR7bGTYX
   bl5NJxHemcGQlBnAVkHiyrkWr78ArNnqLfSFXtMUu7tlOhE27yBzhq7T6
   g==;
X-CSE-ConnectionGUID: LNn6Dhy2QEyhl+LmjPSIRg==
X-CSE-MsgGUID: Zyc5xZ/MQGapmAoVMpJqkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="61133642"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="61133642"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 09:29:58 -0700
X-CSE-ConnectionGUID: Fv5lhv2MSEawmu0HxwRfIw==
X-CSE-MsgGUID: TNP/h6CaQpeinGdgWaN0MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="123622050"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2025 09:29:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Mar 2025 09:29:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 09:29:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 09:29:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jiFF9XVOU7H5YAXXWq1PGXSl9j6Lmb6EStBhNR4E6DsSzEvunhqwzIm8buDdx5xMUS4+AuDQbfOHiyuRt3eJ8peziLOHUT/BUg8GV5zLByAeigxZgn6gRDsr9MkW60Lapy32ohtnXDBnpGkBhHE1kM9DjJf6lq3sL93r06oRsRtZ47ZDy9b1yTJ5Et/G/2p+5wGFuIBqMukJnTvd5TYFaKerrwhCrhX7+vEF4vxCmBZahUMLpk+O2pXDP0qu5dcswJ7+qSvDUTDxObAq0sT7HPAykPbwQMOIjZmhA1GFUaUP2+weVOZc53BsEsEsBpJW8eF05eaW182cYD2HhE/qgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xV4XHgviiCmh7Y3nyMXwr/P/xtFalVYGFrAxlWS7MR4=;
 b=gD4+jbuKlcHRMYmu2HCiB8mVT+1128nFyCkaTPbQCxROxDFq6YN5lcuwAwVecqr0HtatkXI6E2UXA7Mr87E8eaxd7jc/3UBITToK2vXMKH62Y0ct5Z7BA6be+VIIgq37p+NCOBdPI+Kify4tNZiN8Z0vmVN1ONQcZS0T9dhagaYBpstayzN+HKy6PuYje4oNrjPfJ+lS3kRhO94Pe9Lb/9B7vOfd/oVAIS+BMyUUuYpTyhH2OMCRbZBtAFGLdeZA1JDPbxUf23/4u383KiZvHAYvqREAL3FuT4JStdX49iRCmYnBcVSQeMWvMbQTH/CSqhovYTCChkY/X1seERg2sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Wed, 19 Mar 2025 16:29:46 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 16:29:45 +0000
Date: Wed, 19 Mar 2025 17:29:37 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Michal Kubiak
	<michal.kubiak@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 11/16] idpf: prepare structures to support XDP
Message-ID: <Z9rw8ZuoIhuT/dBb@boxer>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-12-aleksander.lobakin@intel.com>
 <Z8r0MagKeUNHwfQk@boxer>
 <a49604cf-0181-4e91-920d-206a799f67f2@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a49604cf-0181-4e91-920d-206a799f67f2@intel.com>
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 108ab121-a14c-4fda-7d14-08dd67034295
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2yoPisEEKFSOM0rmdC3ipnmSnC1pQQTqsflk6ybwQbqjZ2FYoLrSfJp3KHC3?=
 =?us-ascii?Q?XUFl6bQWMfpELGL+wTxFLxz+pjz4zl63ZauFZ1s9S+XvPaBOKzJFHLE+yjAr?=
 =?us-ascii?Q?YNp8j+cSWEntN/VV4jxfEcX0pDCZzZfPq378SFABX9xDJE71nh+XAdZIX4yW?=
 =?us-ascii?Q?MgjsXcVw5e8czd5F1DT3MuiNBLgnPS66s4EoIfCyLRvGXAyvyL5406zjD3cQ?=
 =?us-ascii?Q?9KAhQlPaXIg38lPAyNbwqQ74J3OY2ruov+MvOg88c/gPOyUR1qJuHG1wSUMr?=
 =?us-ascii?Q?we8jUe0jH/YZ5FStuIUkAMHyGZQs/r2eTcvuy5A/4ln9mx8hf/SZ+LRL7qN7?=
 =?us-ascii?Q?HTCR3fb6amhN/bPRRsF+MU0pjvTGJ+vsaNDrylW2d3lQ2et7O0ndPzR287iW?=
 =?us-ascii?Q?Gk/KnCabYRyVwSJTLBRZ2SabXcCPjqJuHhgCblPxzgYiqzF6j6KWEDNK76FV?=
 =?us-ascii?Q?e0iJ2ERq7h3vFk6ML5aGif1rCjFf6E8X4fJf4xGeK1BZ1yasX0Oyv6ij9EHY?=
 =?us-ascii?Q?JTht/q80KrrG6xYhfMXNA+2rXWHmxP3c6+vzTSmXHXho1WGLZsDhjqId4y8K?=
 =?us-ascii?Q?BiUValQW/Zm8g3w2cKqfSSa2XppzIrtySYQ4l4prGF/UQztGGPgmUbYZPvQ2?=
 =?us-ascii?Q?DJE5f/KL/P4iKdCAfeW1WfxfSAKuPRpqjyozihYlyrlQ/ibSVtSmtDGxqkiS?=
 =?us-ascii?Q?fx5ND9qsOIZAMrjPeIYeOeVXaaJpfMn4slwYa+hBOwfp96b9bWl1grvazcHK?=
 =?us-ascii?Q?HRDz87amdGuHz5IfM4TX+XQp4lgSZR4L725WuwnNDRcfZoQhtUOaOqAgikZJ?=
 =?us-ascii?Q?l/kVsuY+Y5Py/7b6Qo/hs9AWboFSlp/5+FpqaEKyAgDsb5D0KAFB4kDjVYbQ?=
 =?us-ascii?Q?lnPJ/f/+zztrn9wonAk3HEh1e84NOUr+QZ8fOorlMGpa0ezpkrSRurCz6s2K?=
 =?us-ascii?Q?qDgZ7BMIEy0uAoAJuo51e6mHgTmZQ+vGEHKzWz0xiCqr9D33/h8nizrVPx6K?=
 =?us-ascii?Q?DQhhc+2iL5hq6RcyptHiR0UaVtRAlaYKf7yMGddI3X5lI0FCeD+IQO+/XAFs?=
 =?us-ascii?Q?FH2gSKoQcuqQvrAQDjy5TV3NPEJHrLFBWl3gXcVWEl/JwFKPAeXt/bOJsvWm?=
 =?us-ascii?Q?/lv8DCaot0ptmBnYNk5xmNa2+FscbKpuYXOYaEbMdb8U0Lh2cAjaauaqtkbR?=
 =?us-ascii?Q?vcX8BKGhh73V6TR+nCMuwekErB8Q2QMxLzC0cjXj3osXpS6EKhttk5n//DNz?=
 =?us-ascii?Q?XKR34mzNvbh5hbrPWQyc6UE9ZaSvwx96w/F/FP6OTQPiHS6PqkBCLD+u073E?=
 =?us-ascii?Q?bm/cgYd0roxzgt9O9gqqPQqjWbY57wI8O9UNDAZNcN6n0jcUx5sXoSnvqaa5?=
 =?us-ascii?Q?mmNT52AUR3ErzHIiyuGiMK8eJutz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SbAOW/12TWhZ133REmu68StdmkRLYSoyOv31jNtTLUiUzdw3qlIs0CrIyM4F?=
 =?us-ascii?Q?g/Y7h/lx3a7cPeO+LJuis6/yZb0H1s6Bz+bs+0VnGFZNLHer02QqofZEsWZF?=
 =?us-ascii?Q?fWczTFLHHT2t9tBt92jVl3JkCWSUuJU0GRs3yZXPBcqqerJnb6ZxX94zBUME?=
 =?us-ascii?Q?r7DSi02g3OUoIxjRBUYCtZ8agpJ3h7+2SyfGh1QMey3MuQUlw9DzRjRQhQCU?=
 =?us-ascii?Q?MZhlSoFBuDnz6TBvVcwsY4TyiseutxOlZ9duy3hQWhrkwDGUwtkCU8pih3RZ?=
 =?us-ascii?Q?gwDlEHyXX83+dR6502ou7cNn9LoQbN6izoQUH0T5EMcYKtGcjoPKNFPp55QR?=
 =?us-ascii?Q?ZidC1Q9+Eq/HHVioe3SDRlvQZVl/1bybpKc4pQGKkCRfKHkhBChZIsPnxoY7?=
 =?us-ascii?Q?DOgZQWfhPSJowxrWoazlGEz8oLzrWK22/usqD30G9BTch1lweg3SLoQXBIYa?=
 =?us-ascii?Q?5z0nn42GRrNxMdFhV8snMQBKkzx+onMWP40yhw1lSnNEqiJDIn+AWhempJtS?=
 =?us-ascii?Q?oJcfXooLxF47Au0xboq35yqE+n6oyEih0I+1YsxJNy6okfR5ClzDFOug/+cg?=
 =?us-ascii?Q?CpFBDpqVYIOczz+ni6qJyeXYXjU7k1Tqq2qtc9n1FcqOFKYNfC7w43htcppC?=
 =?us-ascii?Q?aNCTJ8Q/hBwA3dIAgWVmykT7dfVZY4MEz8fm2UgE8K8ulitfxefm6s4gtNkK?=
 =?us-ascii?Q?FJLAmfv0ISb6xj4KF6Villpp+7AnESlby9/heCP5H0SYdeG5Gq5tUGDei5Tr?=
 =?us-ascii?Q?tM6bz3us4Bj5pwof4q5tVQyZh23vjPMCAOBUMJ0kgLaiIW3ujz6SS0x6kJGM?=
 =?us-ascii?Q?qe4jNByVNx2za9ho/Sb6TtTngVyAGDZVTMpsqAGKhgy5Nk5wIQ4IgNObR0ud?=
 =?us-ascii?Q?cEXN2rfubBkYnTutkfDVHE+BF6BfzOaPfg424nL2cRETTokIm2y0dwNrLjA8?=
 =?us-ascii?Q?Z6JrH6apbQ/RDV2KDKuBgFIUsMfXFtBRdR5+DQpiB2rZ/tkr25NvkatY9DUR?=
 =?us-ascii?Q?yFP2yN3wdQs5FthSbSgRjEcXgBM7ngcU093dILYS/nZ4i94w6UuysbtXw8sJ?=
 =?us-ascii?Q?1jrz+sgqYbmmKA4oJJTGxRAM1oxTHj2W327HTTjEP+Om3QtkCZe/IvhbcAkp?=
 =?us-ascii?Q?rX3UFFGLK1BX2EqLjwSa6m8AYoSsGnT0FEZhtYrAOdSALzWgRHrtd+eUf64y?=
 =?us-ascii?Q?9ZLRL54dmZ20HId1ywvtJ/9ZFqvjzOL4RNcC38d37O/5ZcBP6ZPA8tUZILQK?=
 =?us-ascii?Q?Wv7oXOnjVZ9VdQl++Vq1uY/g7sm6nJB0cS4XXt20baMbjr5Kr1M3eoFhWgEA?=
 =?us-ascii?Q?KtDTtYdokxtPmt2qXN5xeysk/j097tk9AmU4TXh2IofmdwR7YulwjR1Zv2sl?=
 =?us-ascii?Q?+vU6DzAXyhuftJC36nmaTxRAUjcYRAsem6yCV52m20BitmSmtx/+Y5zSRvn0?=
 =?us-ascii?Q?P08bJBkh8m2pRAjjrwOdnozRFCAVvHF0z9YkSgitS98DrUM54vNOcc9tp9jg?=
 =?us-ascii?Q?D2X+xABXiAiLYn0MQePi6HRjRqWNO5ETJVhILxahYrt2g7usCcJxbwox+13o?=
 =?us-ascii?Q?k0Z6ItGd9OzJpMGwrZpCEQAhVXgcEHwfGSmdqy4u9XbsWfGTSAeyYBEbD7B8?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 108ab121-a14c-4fda-7d14-08dd67034295
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 16:29:45.8612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DN4KDlD0LUYr1DUbDVm3byKNQtoVEN1c6ZwUsNVZaoLSwnZ48rntRbFINw+91AzFGq74b/Pkgo/EXRJ1aAV1Q9g8nbOBsjtA9HAc6txZxEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6397
X-OriginatorOrg: intel.com

On Mon, Mar 17, 2025 at 03:50:11PM +0100, Alexander Lobakin wrote:
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Date: Fri, 7 Mar 2025 14:27:13 +0100
> 
> > On Wed, Mar 05, 2025 at 05:21:27PM +0100, Alexander Lobakin wrote:
> >> From: Michal Kubiak <michal.kubiak@intel.com>
> >>
> >> Extend basic structures of the driver (e.g. 'idpf_vport', 'idpf_*_queue',
> >> 'idpf_vport_user_config_data') by adding members necessary to support XDP.
> >> Add extra XDP Tx queues needed to support XDP_TX and XDP_REDIRECT actions
> >> without interfering with regular Tx traffic.
> >> Also add functions dedicated to support XDP initialization for Rx and
> >> Tx queues and call those functions from the existing algorithms of
> >> queues configuration.
> 
> [...]
> 
> >> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> >> index 59b1a1a09996..1ca322bfe92f 100644
> >> --- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> >> +++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> >> @@ -186,9 +186,11 @@ static void idpf_get_channels(struct net_device *netdev,
> >>  {
> >>  	struct idpf_netdev_priv *np = netdev_priv(netdev);
> >>  	struct idpf_vport_config *vport_config;
> >> +	const struct idpf_vport *vport;
> >>  	u16 num_txq, num_rxq;
> >>  	u16 combined;
> >>  
> >> +	vport = idpf_netdev_to_vport(netdev);
> >>  	vport_config = np->adapter->vport_config[np->vport_idx];
> >>  
> >>  	num_txq = vport_config->user_config.num_req_tx_qs;
> >> @@ -202,8 +204,8 @@ static void idpf_get_channels(struct net_device *netdev,
> >>  	ch->max_rx = vport_config->max_q.max_rxq;
> >>  	ch->max_tx = vport_config->max_q.max_txq;
> >>  
> >> -	ch->max_other = IDPF_MAX_MBXQ;
> >> -	ch->other_count = IDPF_MAX_MBXQ;
> >> +	ch->max_other = IDPF_MAX_MBXQ + vport->num_xdp_txq;
> >> +	ch->other_count = IDPF_MAX_MBXQ + vport->num_xdp_txq;
> > 
> > That's new I think. Do you explain somewhere that other `other` will carry
> > xdpq count? Otherwise how would I know to interpret this value?
> 
> Where? :D

I meant to say something in commit message how new output should be
interpreted?

> 
> > 
> > Also from what I see num_txq carries (txq + xdpq) count. How is that
> > affecting the `combined` from ethtool_channels?
> 
> No changes in combined/Ethtool, num_txq is not used there. Stuff like
> req_txq_num includes skb queues only.
> 
> > 
> >>  
> >>  	ch->combined_count = combined;
> >>  	ch->rx_count = num_rxq - combined;
> >> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> >> index 2594ca38e8ca..0f4edc9cd1ad 100644
> > 
> > (...)
> > 
> >> +
> >> +/**
> >> + * __idpf_xdp_rxq_info_init - Setup XDP RxQ info for a given Rx queue
> >> + * @rxq: Rx queue for which the resources are setup
> >> + * @arg: flag indicating if the HW works in split queue mode
> >> + *
> >> + * Return: 0 on success, negative on failure.
> >> + */
> >> +static int __idpf_xdp_rxq_info_init(struct idpf_rx_queue *rxq, void *arg)
> >> +{
> >> +	const struct idpf_vport *vport = rxq->q_vector->vport;
> >> +	bool split = idpf_is_queue_model_split(vport->rxq_model);
> >> +	const struct page_pool *pp;
> >> +	int err;
> >> +
> >> +	err = __xdp_rxq_info_reg(&rxq->xdp_rxq, vport->netdev, rxq->idx,
> >> +				 rxq->q_vector->napi.napi_id,
> >> +				 rxq->rx_buf_size);
> >> +	if (err)
> >> +		return err;
> >> +
> >> +	pp = split ? rxq->bufq_sets[0].bufq.pp : rxq->pp;
> >> +	xdp_rxq_info_attach_page_pool(&rxq->xdp_rxq, pp);
> >> +
> >> +	if (!split)
> >> +		return 0;
> > 
> > why do you care about splitq model if on next patch you don't allow
> > XDP_SETUP_PROG for that?
> 
> This function is called unconditionally for both queue models. If we
> don't account it here, we'd break regular traffic flow.
> 
> (singleq will be removed soon, don't take it seriously anyway)

ack, thanks

> 
> [...]
> 
> >> +int idpf_vport_xdpq_get(const struct idpf_vport *vport)
> >> +{
> >> +	struct libeth_xdpsq_timer **timers __free(kvfree) = NULL;
> > 
> > please bear with me here - so this array will exist as long as there is a
> > single timers[i] allocated? even though it's a local var?
> 
> No problem.
> 
> No, this array will be freed when the function exits. This array is an
> array of pointers to iterate in a loop and assign timers to queues. When
> we exit this function, it's no longer needed.
> I can't place the whole array on the stack since I don't know the actual
> queue count + it can be really big (1024 pointers * 8 = 8 Kb, even 128
> or 256 queues is already 1-2 Kb).

so this array is needed to ease the error path handling?

> 
> The actual timers are allocated separately and NUMA-locally below.
> 
> > 
> > this way you avoid the need to store it in vport?
> > 
> >> +	struct net_device *dev;
> >> +	u32 sqs;
> >> +
> >> +	if (!idpf_xdp_is_prog_ena(vport))
> >> +		return 0;
> >> +
> >> +	timers = kvcalloc(vport->num_xdp_txq, sizeof(*timers), GFP_KERNEL);
> >> +	if (!timers)
> >> +		return -ENOMEM;
> >> +
> >> +	for (u32 i = 0; i < vport->num_xdp_txq; i++) {
> >> +		timers[i] = kzalloc_node(sizeof(*timers[i]), GFP_KERNEL,
> >> +					 cpu_to_mem(i));
> >> +		if (!timers[i]) {
> >> +			for (int j = i - 1; j >= 0; j--)
> >> +				kfree(timers[j]);
> >> +
> >> +			return -ENOMEM;
> >> +		}
> >> +	}
> >> +
> >> +	dev = vport->netdev;
> >> +	sqs = vport->xdp_txq_offset;
> >> +
> >> +	for (u32 i = sqs; i < vport->num_txq; i++) {
> >> +		struct idpf_tx_queue *xdpq = vport->txqs[i];
> >> +
> >> +		xdpq->complq = xdpq->txq_grp->complq;
> >> +
> >> +		idpf_queue_clear(FLOW_SCH_EN, xdpq);
> >> +		idpf_queue_clear(FLOW_SCH_EN, xdpq->complq);
> >> +		idpf_queue_set(NOIRQ, xdpq);
> >> +		idpf_queue_set(XDP, xdpq);
> >> +		idpf_queue_set(XDP, xdpq->complq);
> >> +
> >> +		xdpq->timer = timers[i - sqs];
> >> +		libeth_xdpsq_get(&xdpq->xdp_lock, dev, vport->xdpq_share);
> >> +
> >> +		xdpq->pending = 0;
> >> +		xdpq->xdp_tx = 0;
> >> +		xdpq->thresh = libeth_xdp_queue_threshold(xdpq->desc_count);
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> 
> Thanks,
> Olek

