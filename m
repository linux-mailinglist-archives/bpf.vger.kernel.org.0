Return-Path: <bpf+bounces-71832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D01BFD861
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 19:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27A904E460F
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 17:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E228274671;
	Wed, 22 Oct 2025 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MsLOSWk2"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B3322370D;
	Wed, 22 Oct 2025 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153463; cv=fail; b=NDFHyP1sOFuEy7qrTduSR3B2ap5qxTl4OW0j2SnFajZR3q/Wz5Ckds1+i4JSMbLo6JnII9vsLhN+AkH8krbUrzqe/vHhJyORyz57WlLUtfM7N4yYWGBNZk0O2S5DqbqkjWQnUv4a1Xf30Z0P3SltQfPGyzbMN56Gd26StALfGCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153463; c=relaxed/simple;
	bh=/pFMaMRJlIMlyhYtpnqOe1webQczZAQnr+kw49XpgNc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aijvPOCIpEAgLsIHhQ1moOxM8UYPAwXwu3nKmNdcUsy3g7GZo3CobZWcFmzFRBqDhFTrxvtnAyjFj415PlMKlL7SETLSmVEp4VAuFZVSMVfdBX20i9V5xwRI6LF5UG8QI49hvQvMpFvoSM8n+8S/GyTBYOOML/jRmNUcW/b0/iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MsLOSWk2; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761153461; x=1792689461;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/pFMaMRJlIMlyhYtpnqOe1webQczZAQnr+kw49XpgNc=;
  b=MsLOSWk2tEnRYiv3rpP4PoxZUN6JYxEfCEShYHog4fTtwGNdrBq1TjvK
   bxpMU2lfoJYUJ8tJQuXAbkdZfbOC2G2LkdDLS1gHrItKFGhlR1PpocG2P
   UdecZ7eVEPrIlGXJcX/ebiL0T9zqMoV+EiyhQ9ylpKgNHuJaURZcVgvXn
   mnyiWCOXkaEcJxjy3hF12c1nJe1Yt7Oii5d2T3+eO10Y2TGlCTs6ofU/+
   Q7xgcevbzT1yCE2VjyorYt3oHYbPKKGUWMCWOvIm/0D0qfF5gINEL6M6M
   J4vq9Fs7yQ6wdKLXkbFXkCdFW/JYxiiH1kftvjRmNVGXl//9tnKlOqq3t
   w==;
X-CSE-ConnectionGUID: U3ICf2YXQjK2yJaAJN0QLw==
X-CSE-MsgGUID: e5UbJ9CMTGadcD+p/98GnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63350306"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="63350306"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 10:17:40 -0700
X-CSE-ConnectionGUID: 7X5h+/nPS4us2tUIYOxwTw==
X-CSE-MsgGUID: uuby54MZRC6iRQW3j3Q64g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="214869711"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 10:17:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 10:17:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 10:17:40 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 10:17:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jG5xuCmixiHA9HerKVBN89K40m4Bsa4wdKLfH29LIY1o5XaednA1tUj0T7lUJoILlLABzFUkSen3Gjf1CgaCZUYnuDOrkFg/0cdI7yf60fLwO5OygezgoZOZfs2r2i3ndo0patHnPRtUodmsR6KQuAkQSV5lkbDW43EA1XeZ2OPRDDb8gjyD3lT83Njy8yo4AQgR8KaOniock7OMC8IFq6z2+lCmiKxHGvTIKQm9aL8xFpMo+ebGYmi7ZB6b9XJQDxsgDt73A5LPv/TnCdWs8FlDjOsJXrppIseQse8NdEd0680W3OGGWdSePz/G9dUqofX1RtEfYxdjS04ATFx2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VpOUZBuHXohPSXTp9YY9QkzHMzHClDaH1RvSVtzskI=;
 b=mrCTEAlrY7BRQAo6LWEw8dBhifr2201nJtk0SzQMx7J+2fVuvr4Hd8VqU3jvZXtMoChiNSNnBmLy8BR9YDk1OG0Ia48TkaVMkSuGvSykfEhXvJP2lNsLJKz7LU8zcOQwk7fANMfzD6iREgF8QIBJKJX7GHvW3SqB/5i55iNUu7jEuCWqj5ClxUnsShKdX1sUhVsnRsqREKNT5/WiGUvoLSta2PeuXE3M00AtWS7M1XaYBxckBras66W/xquRV2uV+16vRIO3U5UoTOIGcLNTRnKPAFyr6e8HWDcxUJw7KuN14FJ/e/vJnkLnJc2tdBbjs3YTMrf4xWVcEGM6m5PXuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH8PR11MB6831.namprd11.prod.outlook.com (2603:10b6:510:22d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 17:17:37 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 17:17:31 +0000
Date: Wed, 22 Oct 2025 19:17:20 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alessandro Decina <alessandro.d@gmail.com>
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
Message-ID: <aPkRoCQikecxLxTS@boxer>
References: <20251021173200.7908-1-alessandro.d@gmail.com>
 <20251021173200.7908-2-alessandro.d@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251021173200.7908-2-alessandro.d@gmail.com>
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH8PR11MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a1f191-549f-47e2-0966-08de118ee212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dPWOnTMtVQKhx1Hgi013P2prqoFKs/Qz7H9RYrNfUiYDdryVA3ZJm1IZ5SZD?=
 =?us-ascii?Q?RD42B6gTd2CY4jzKtGEpY95o2GObMGjWwXt+ZDFzVoVhqIBIgfm0NcPYI5kq?=
 =?us-ascii?Q?FWp5ksK0beJOIHYuGMa2+R/jRbU1gmfPbWb3vDzPK/EqMU0wMxjSg8dSEQ3p?=
 =?us-ascii?Q?zogzB1e+CPcT59KpkzRUynAD12+WwwrOqeb8SGqrAIn65+MC4C6ISgdXh7WE?=
 =?us-ascii?Q?3zahmEGMF/538Eu0Hy4gaGO3oTvD8e0HPHenA9XvNZWMRAVuX0phukR3pEe1?=
 =?us-ascii?Q?chDfRson9C37vnSjArMkL+35n2wDsukrV14EenX9debqn5r6UcfMIXtfcsIT?=
 =?us-ascii?Q?QVPwKnJ5anFc+3/epixs9m5XC/rMncsFOb3vMadO5gCUjoZKpW2R4WJjbLC9?=
 =?us-ascii?Q?IJdP7xNePUmY4ZkXp1biyEE5VxOYqAa27XCdneK/2OiKE5zPgvmtDiVVGKKi?=
 =?us-ascii?Q?y/Wo09hkcWj6ZwTQaU+MWiI6hf9johaJOYslAEKHu/lsKvNjTx5MmT/TB11W?=
 =?us-ascii?Q?1cWeLuEYJOzzwUyWjictFPVXpKkhb1HY5nGKxoA1pulsdVzy7kdC3Cy509d2?=
 =?us-ascii?Q?4cOAJgVkO6LIFbzc7xhfynBJY+qvuQLEaUEqMfOJCvyXLz4zoUBnDqn57lYU?=
 =?us-ascii?Q?OZHD/jGHXp0DDCSIZnS4nPgAaO7lmh8fjhqEy3Ic827wNts3IDYnq0ajRHae?=
 =?us-ascii?Q?7W3VebploGWqIv55MZh4wq8/iUpQ5MjQReZBn6YPWPOE+LjtaRdTpeXclpId?=
 =?us-ascii?Q?5rdo5PRs40Jedkpy0ok+Yy0D36zfassrzID+HSbnyJs4C0oFS2UdnT5DOoTe?=
 =?us-ascii?Q?naCbNsZIGcHPRCCgoq0eULH7C1LpIT2zlUvB9Ap/apzaISAUk4NYnIfafarZ?=
 =?us-ascii?Q?ZebDaIyCgTsw66Ly1w/JRSpuQTl4zVOZODkXVU6REfeDkA3qyBtD0kaY7Z66?=
 =?us-ascii?Q?CqwgSOzZbR/g/isUHoZSR4c0mMDjUPyljd2ZKn8KL4Rg9cn5USbiRNfLyB2n?=
 =?us-ascii?Q?jMCOPNCXpTnO4p059uNQR0BJjeFo9ONsGzd0Xq6W3kAjRdZEaj2V5kv2dwX0?=
 =?us-ascii?Q?lBTPoQknotkLMPfruore2NMlJNLZeMYs73H6FRkYxrG4wBhs4sn8EWThL2CN?=
 =?us-ascii?Q?8Q5wZfJ5vEOiGxkPAgF3W1K4tPFedc5U0sbKVkxV5KoOUiBoyZTq1ekPvWG7?=
 =?us-ascii?Q?fiwWIvcMujx2UDxBAR1fcu6DMvhezWOcoQ9ZEAK9JrnVKbU0i1nQ1IY7f1cg?=
 =?us-ascii?Q?iE23/ksIsau0HbWPdPVgojHHMvBW6szjLqdTMACRtJo+MaYESmy879ZfxG1a?=
 =?us-ascii?Q?k6kue/cMhLNVJQi/iZiM6ALE3Y7lX/qQW3OibiZdSI/vYi8ivcyCMbxJzXol?=
 =?us-ascii?Q?Jm1YhG5VMAWMmjKPMCbvijL2e2EzOIG9A5qac3/9phQDTA4dfcPNcVJNedgH?=
 =?us-ascii?Q?79MA109pJpiQZLnKIpVrBMYo7nd1gCyP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+GXizAcnzRzU10o7IWgtC3AcbCvkARQv9nhgXrWWgPNFwYFFsTxuSTNukC/i?=
 =?us-ascii?Q?oquwAu1sNVnSNjX7SqA8WJJhfDfrrwrW7m/XeXs72Wa1eq9f8AEpUWnEgrvq?=
 =?us-ascii?Q?j6j38wGD3nbZfj6JR7+7lF2eD5vENAwPMEO/7rG5qD/la37NwpZoVVefJBN2?=
 =?us-ascii?Q?1W1lQcFb6cd/NVHatRzIPCdhGerkhQQwXpBnPX9alqULzb941CZlPX1rDgY7?=
 =?us-ascii?Q?hTJ2MPkgBcsQ/6kyMHAzR1BnrQk15oopQl3H+NUlZYHJRq84fgj3DE40Cioa?=
 =?us-ascii?Q?pYspmzJoVPLdNd4YexajPvsQVN8H+QP7gnjBFTzuphKmR2oQKG/DhU/vJq2+?=
 =?us-ascii?Q?8QiqvvLGIB1z6/ME519BlkbHYiXidYnQpqUOj9oOXvMMcTt2YkRTql2xoI/j?=
 =?us-ascii?Q?toz0ZVAFWYlmTjl7jWDvWiGRIGKTJFlyiTleT4EaRmZnhb4KsemaC/k3t817?=
 =?us-ascii?Q?DWTnE+GAoZ6KFZF+bW3K8BW2u/9UxJ8KeLlta3JFbw8q2/RsYesSdyf98FOA?=
 =?us-ascii?Q?d3IEO64YATd7caUCjaI6f+3X3GfHMm0sJkyqqnmhhxd1dhj/RhnPu2MvimKt?=
 =?us-ascii?Q?uWSY/QdfX+vMLlfqz1SqC4W9cyG00/msmavX92OqaER8LDxQ7E8h8WYPiIyn?=
 =?us-ascii?Q?sUduBYBN0KRayPVF1nLDi6APROxXRRym1JueXOP4LClIUFZANI2L2oTUhpyt?=
 =?us-ascii?Q?9DncsfkXJWQg4wkrxySc0nmDCRRBzg1r5BoK3jeUxnrQHjXmgKvOaxfGRHQz?=
 =?us-ascii?Q?/zUuYGd+WiwIA/GltkLIZclN+t6yNwe5ui497xpE2VY+zfLwxC9MjqLq8x0w?=
 =?us-ascii?Q?s04bQGx4bhMXHg2SzSLv7clZKqj+2RpMp0POnBH0BzZv+h/Sh1GdqM3fbL++?=
 =?us-ascii?Q?/yiCkmvhpczdjw7DifQM0AWODwGeEQ3D28LqOxaDimz42YE0ssiiHjRQp4Xr?=
 =?us-ascii?Q?WL0X9qTInoEZbT2PZLwmtnEmgjAvYtIEq5Jvz365gDg8ASBjd+DP3x0zr4lx?=
 =?us-ascii?Q?3tQnoRoVFGpAzPdEUhMVS3MFWTYhCIDTbwvhDc/aOnyHeuaeNxYyoV1qZZWP?=
 =?us-ascii?Q?qM5PTqFhvAZFyHyIWVPJRy6q+hkxij/6gAhI7/FwtjfnIo8G2PjrPIjGIl4w?=
 =?us-ascii?Q?U4jZnTOfwqDwj/JXMy2PkVRmzVFvcJGQyIzLrQ7YJGtQIPmL4IMDDHbrMNuo?=
 =?us-ascii?Q?2fS7nvRnHBvUd7T+OL98K+jQbyxSNIkXGvgx0AYhPNT5nmYz4sux0ZedawGS?=
 =?us-ascii?Q?4kZHsYaIwXpMF+XMshymxK8y57Xd7YrBabodlhUUPYC7cUlQduin6DjRLmb0?=
 =?us-ascii?Q?bd8DpTFzkByW5VP72vUr2eymk6VBFqmQEzfp1QeWCVGS5JjHAvvWVTHDK3fY?=
 =?us-ascii?Q?pXwiNH83yojEMUv4ZA4/iQmqPjfYQDD/skhsj/C3pyG1fSARhQR1IZdVgyfP?=
 =?us-ascii?Q?pjg7Mk9rA/2rNubUMO1I9o0DAKGn/uCzzHzuoEKfR/NLzU9bdEvfATZ3gfqd?=
 =?us-ascii?Q?XELliE4KRHXTwUwpAPPZ9YBVsfSIHrFj0FmoejRgCO73jM9X4PTcljxXaxMh?=
 =?us-ascii?Q?wX6/IQKx/43CKlpvGUT+zI4RifONm7aEQfIDU6fRtjpzf4uUP/YrqHzwFi2G?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a1f191-549f-47e2-0966-08de118ee212
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 17:17:31.0189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9a4vMc1jcHNSv6CLLUQDByXNhL1l1gzpLl08g3ub9zI+B2Zh/OX1M1NXO51TbuYt7A6HlQKUmiLn6A0udVbrHTdTHjKSs+g19HGjsKaAyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6831
X-OriginatorOrg: intel.com

On Wed, Oct 22, 2025 at 12:32:00AM +0700, Alessandro Decina wrote:

Hi Alessandro,

> Whenever a status descriptor is received, i40e processes and skips over
> it, correctly updating next_to_process but forgetting to update
> next_to_clean. In the next iteration this accidentally causes the
> creation of an invalid multi-buffer xdp_buff where the first fragment
> is the status descriptor.
> 
> If then a skb is constructed from such an invalid buffer - because the
> eBPF program returns XDP_PASS - a panic occurs:

can you elaborate on the test case that would reproduce this? I suppose
AF_XDP ZC with jumbo frames, doing XDP_PASS, but what was FDIR setup that
caused status descriptors?

> 
> [ 5866.367317] BUG: unable to handle page fault for address: ffd31c37eab1c980
> [ 5866.375050] #PF: supervisor read access in kernel mode
> [ 5866.380825] #PF: error_code(0x0000) - not-present page
> [ 5866.386602] PGD 0
> [ 5866.388867] Oops: Oops: 0000 [#1] SMP NOPTI
> [ 5866.393575] CPU: 34 UID: 0 PID: 0 Comm: swapper/34 Not tainted 6.17.0-custom #1 PREEMPT(voluntary)
> [ 5866.403740] Hardware name: Supermicro AS -2115GT-HNTR/H13SST-G, BIOS 3.2 03/20/2025
> [ 5866.412339] RIP: 0010:memcpy+0x8/0x10
> [ 5866.416454] Code: cc cc 90 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 48 89 f8 48 89 d1 <f3> a4 e9 fc 26 c0 fe 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> [ 5866.437538] RSP: 0018:ff428d9ec0bb0ca8 EFLAGS: 00010286
> [ 5866.443415] RAX: ff2dd26dbd8f0000 RBX: ff2dd265ad161400 RCX: 00000000000004e1
> [ 5866.451435] RDX: 00000000000004e1 RSI: ffd31c37eab1c980 RDI: ff2dd26dbd8f0000
> [ 5866.459454] RBP: ff428d9ec0bb0d40 R08: 0000000000000000 R09: 0000000000000000
> [ 5866.467470] R10: 0000000000000000 R11: 0000000000000000 R12: ff428d9eec726ef8
> [ 5866.475490] R13: ff2dd26dbd8f0000 R14: ff2dd265ca2f9fc0 R15: ff2dd26548548b80
> [ 5866.483509] FS:  0000000000000000(0000) GS:ff2dd2c363592000(0000) knlGS:0000000000000000
> [ 5866.492600] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5866.499060] CR2: ffd31c37eab1c980 CR3: 0000000178d7b040 CR4: 0000000000f71ef0
> [ 5866.507079] PKRU: 55555554
> [ 5866.510125] Call Trace:
> [ 5866.512867]  <IRQ>
> [ 5866.515132]  ? i40e_clean_rx_irq_zc+0xc50/0xe60 [i40e]
> [ 5866.520921]  i40e_napi_poll+0x2d8/0x1890 [i40e]
> [ 5866.526022]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 5866.531408]  ? raise_softirq+0x24/0x70
> [ 5866.535623]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 5866.541011]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 5866.546397]  ? rcu_sched_clock_irq+0x225/0x1800
> [ 5866.551493]  __napi_poll+0x30/0x230
> [ 5866.555423]  net_rx_action+0x20b/0x3f0
> [ 5866.559643]  handle_softirqs+0xe4/0x340
> [ 5866.563962]  __irq_exit_rcu+0x10e/0x130
> [ 5866.568283]  irq_exit_rcu+0xe/0x20
> [ 5866.572110]  common_interrupt+0xb6/0xe0
> [ 5866.576425]  </IRQ>
> [ 5866.578791]  <TASK>
> 
> Advance next_to_clean to ensure invalid xdp_buff(s) aren't created.
> 
> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> Signed-off-by: Alessandro Decina <alessandro.d@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 9f47388eaba5..dbc19083bbb7 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -441,13 +441,18 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
>  		dma_rmb();
>  
>  		if (i40e_rx_is_programming_status(qword)) {
> +			u16 ntp;
> +
>  			i40e_clean_programming_status(rx_ring,
>  						      rx_desc->raw.qword[0],
>  						      qword);
>  			bi = *i40e_rx_bi(rx_ring, next_to_process);
>  			xsk_buff_free(bi);
> -			if (++next_to_process == count)
> +			ntp = next_to_process++;
> +			if (next_to_process == count)
>  				next_to_process = 0;
> +			if (next_to_clean == ntp)
> +				next_to_clean = next_to_process;

I wonder if this is more readable?

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 9f47388eaba5..36f412a2d836 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -446,6 +446,10 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 						      qword);
 			bi = *i40e_rx_bi(rx_ring, next_to_process);
 			xsk_buff_free(bi);
+			if (next_to_clean == next_to_process) {
+				if (++next_to_clean == count)
+					next_to_clean = 0;
+			}
 			if (++next_to_process == count)
 				next_to_process = 0;
 			continue;

>  			continue;
>  		}
>  
> -- 
> 2.43.0
> 
> 

