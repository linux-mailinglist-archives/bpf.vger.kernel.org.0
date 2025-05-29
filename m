Return-Path: <bpf+bounces-59286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB14AC7C95
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 13:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9604E0790
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 11:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BF928E564;
	Thu, 29 May 2025 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fA5FMqJz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA561E8326;
	Thu, 29 May 2025 11:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748517526; cv=fail; b=CtBG/9ViY9Jvo0jGc8yeM43Wu5lraszS5jNZ4BesFTJqY9lg+9IPV4YfaV7Vtd/kCEntnRrvmtOGhRnXRVJc7fLExnS/o/LvA8C7LAtTIa93+PXOYIIa4Tpd1eaO1X2ZKWd6sxwglexfjTD2gJNwq1X4V7Q0vpYmHs97XYmXotc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748517526; c=relaxed/simple;
	bh=VQANQzH6S+96twLmomcxczyPp79ivmTynHGiZ5ETYvg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PbevUVnVOjqu0VGbWWpSHidLf59W0MLOSzva4rmCAQkOwqAcFl0V1QjgJvWaEABktK8SW1WmiQXJtm3DpKlhaLQUhjRQwIK81jjfXBPnqfQ9N3+vg+voISRle6en/cxsRRRPYhJ27x0/aj7GBocgPKPsbWInWtWjnobyQnUVbyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fA5FMqJz; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748517524; x=1780053524;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VQANQzH6S+96twLmomcxczyPp79ivmTynHGiZ5ETYvg=;
  b=fA5FMqJzuMjLkPxbxfu9kOO6hWfcEgqzORbw3SlzgC1veaWSaHloFt1W
   YvrvRiDDLpvN4JlfTo4/3vSiaK7JmRrLyiSI9zfn7TVXcn4TROZvXMuGA
   FT8zs6eiGoqeglPKtTI4CqhubgYhOJsx4MFHSuzcXcRkgPYTNVeR6P43K
   cKgralJcczfqNaMl1HFRPHbH+/QeP56fbm1CxoWT8uhSCf6T10LHmLfYR
   ESJZBXG1u1747KyhBsykS1qK3QRK8mOhWMwRW6i6Hug/gBf4N636svZWi
   PUiEpM7HQVmInoTqOa1WutNWNU82zATmDQQoOzxgPtXaR5YW8MjxwNwdb
   w==;
X-CSE-ConnectionGUID: 97SCQz2XQhOmA8UR5yiK+A==
X-CSE-MsgGUID: kELAP6A1Q9WiAMVQETH3cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61975821"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="61975821"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 04:18:34 -0700
X-CSE-ConnectionGUID: ZYeJcrPdQlSs0tofNjkSNQ==
X-CSE-MsgGUID: PQGdTB4MSmKGd+QtzJq6rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,192,1744095600"; 
   d="scan'208";a="148576528"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 04:18:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 May 2025 04:18:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 29 May 2025 04:18:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.81)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 29 May 2025 04:18:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+LErL9MBDj0gqI/ycWbfJTcrM/V2BqdbsgvtFxDLvkrv6Xl+mJetxUBYRSDhNwEyRdVufiDTvOu+80NbnPq5OqyppCBcm1mF/fq43TOzi0Qz5zl5jNomJhQbhXeWw7AZTgCy9SHyKoYInnIbMCigPGsoaDfSQIw5Ga2jDE0ABknH6K0igpiGQARkGynTc+m211CwqpVMSjyWMW0+yQUjTnb6yrD0DjDF6/qA6ZCdikir4QZH7bwsIcv3yuiDU4l2/53WVEDHzRSz/b5URPXGfHpdigsfVcUIwuZ3Tl6vcAE9deVSZ3u2WmTrM0c5E08ij7qGzY0ddQ1qrBenPdHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4f2FgLwcruwb/chJDUfA4lZh48LriypO+v0qopRuEOs=;
 b=drRI+/vLCzV1kmqWCMgognCDjhANOPDC7jLVv5EYkSanGh75KwC81hm6MTS5vURbtrGV8eD8Bsqcl+SijiOGRDH3rnWdhecBQwfQ+5+dX07wQAXf/b3cGmJB92FI3tI8JlZ1hgDUnbsn8DutOcF433tLItB8lMHenHCSfOCTAk4e2SckVx+Pwz1au9XiEj1xAgYQNwja84yLToZvsGT55eOZZZUlxh/+KNCYoI2Ka+RDl5Y8s1Sr3RCRqfJpFJ2bQobxoRY+jklFFMA1El0qH9ivvrq6ESc6/GdqaGATT0FDo2MF9gUbOezy+M6YmE1jZCrxbNh9uopoMb9TBxR94A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.26; Thu, 29 May 2025 11:18:31 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8769.022; Thu, 29 May 2025
 11:18:30 +0000
Date: Thu, 29 May 2025 13:18:23 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
CC: <netdev@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "Jason
 Wang" <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH net-next v2 2/2] selftests: net: add XDP socket tests
 for virtio-net
Message-ID: <aDhCfxHo3M5dxlpH@boxer>
References: <20250527161904.75259-1-minhquangbui99@gmail.com>
 <20250527161904.75259-3-minhquangbui99@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250527161904.75259-3-minhquangbui99@gmail.com>
X-ClientProxiedBy: DUZPR01CA0331.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::24) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH8PR11MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3a6046-d919-4069-26d4-08dd9ea28aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZzV8IuJ1R+fxEaqHVZy02TlBkMJcaneNDE1N2fsHOHfLZ/90j4fxK+yoDyqS?=
 =?us-ascii?Q?RIegls18OsWS6Ixz+mIzLZzYOOlFTKWGQKrIsIkru1sQ/+TaPrwKZmKrRRVO?=
 =?us-ascii?Q?1Yv3lZY732Ch/SLdWxVt/+U8z958IJ7uxHxrCgmv9fJWJkFvvquyZTQe0JA3?=
 =?us-ascii?Q?6hQR5XEsTTe1/Ku7CmMStRWFeBPAPG3RWgmUlS46QAfl5FO00VGYtsoPTNnc?=
 =?us-ascii?Q?mqlwY2ohpZVQW6Bj08kWE1zaPXW0ZbqMBu0Cn1dor38SpSqwmfrScFTaiLj6?=
 =?us-ascii?Q?O8rZZFN+AbKrvGAYyGiaYFrWp4yoCbYFYMvuHqe8C/VJYrI/vxrkfClysxRk?=
 =?us-ascii?Q?Een4xvnmk+k8S5IUWe1iEr9a6gqaSsAmkTC5JIGwhKaJNcyxWphA8qF+0zdh?=
 =?us-ascii?Q?bmXShjR9Z5YRc8pue9O2rC+/xZKuGjXsgPaVnXvzs7xiG4eslcJUaJjcxo3y?=
 =?us-ascii?Q?dwSUEpWYEo8FvR/7LgBB4o8gzCNoWBok9KbcjrFWzoiZNM0zNKAxrivdrceb?=
 =?us-ascii?Q?SHTshbEEzZ+j9D2NYiksnbVmXqHZUZYj4YAHPjuyZOjDrZDcrHyiDY/cdhNt?=
 =?us-ascii?Q?WzyNA9r6Y/l/rgp5/IbuknO7ZQxT5e9E42ajSBqaTxkO4ns1/AxkD8nr3YTl?=
 =?us-ascii?Q?R7CULMCcJssVQnKuQ4ioQfeZV07gyiJN+hWuPTsSj5Oea9uJd/OHyFXesYHu?=
 =?us-ascii?Q?a5J705u23v+pJvewQEwA34pH5biep3PeXQh7dg87fmCq8LxQg6cRcyFwv0oo?=
 =?us-ascii?Q?TiP+kTF7bshFLQ7rJ+NseIFln8ng5UyIGvUIFwE+9qJ4NYTtGq7bL5ZuPDka?=
 =?us-ascii?Q?rG5tJlq56ir5AveSKTgpwhfWWGaAOOBo2G+0EF5UAGbqYHTrRGfSkuzO5Isi?=
 =?us-ascii?Q?v+iDV5GEov8gtvdCL7jnXMDB6jFzTSPyrsrdLyJKM4p4bdY1dnybkfGV0fFc?=
 =?us-ascii?Q?1kau/YPLGZu3n7pLGQs91cbwvlm2DV+J1m+mYmEfM0b2Wy6iBG11Ie1SQUM6?=
 =?us-ascii?Q?PsFSa1xS9evn9AZsMHS1tK5z2FbpvNHxEt2PbMUXXM4VsxlujtVwP8wzxloB?=
 =?us-ascii?Q?wq39HN7vRN/82WygCkGwX0xVkeKacXdfP10elxjnuVpgqbDObx547MBV/MQR?=
 =?us-ascii?Q?FYXfxAHxThJkTpads7H0ivH14KqMaQpVNXQwjm7lapgdH+TxStWhxhfCLdwe?=
 =?us-ascii?Q?xCXGL4owCReIuAzDwlHracxECGRDeY5oFWZOk6UM+YgBcQ5DrjJ4EBoxj99Y?=
 =?us-ascii?Q?/pLbn6yqIvBEeVJF+QkarflUN3EocQos2W/L2ZcD2dw3eIq5jQS5VyjIt23M?=
 =?us-ascii?Q?AkZ2zEwww8tReLh63yk4+YOtAVhMOVleXcPXlIQwY2QYiIAeFtbvyY5qdfnt?=
 =?us-ascii?Q?vjP/l8xRPIVTPzcU6xbngC7m7IfYYgN4HnpNUrApme9DGHEmksJQLnDXHotg?=
 =?us-ascii?Q?qlpmK6VZXts=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nvHvXg11REqA/Cxp/wnkG1agmRRuXHIch6Z5X0XmKxrn161JsmAcW/ZWS/hC?=
 =?us-ascii?Q?BORTUvXdZSgd7YKSScVSL6PtMcCATPnGIL7ZEEGNhzSUMKNsxkCXbUZ8QQqf?=
 =?us-ascii?Q?td+LVElSZksCkxCOwAan02FtuPCuBty6II8TXVZrkoui8aH3ybYuc+s38opU?=
 =?us-ascii?Q?M94hi2iCGmHlF03+8BrkEgPlJWOudzaSzSCP18FPKEgN9pmZ2pRjUdllWu2W?=
 =?us-ascii?Q?HSsZBOJzEfo9zM87zQGT9Ajjb1tAQ6YL6uvRkhacweYE2iC0KOMfbd1Q2OJs?=
 =?us-ascii?Q?B4hch03BWzs4GSlDz5JhzmihMc5V2vsORtroZ30gZGeQB02gFelSqifoxBRY?=
 =?us-ascii?Q?xQV5P2QWs1tfk2Ld1JwpXqAJWiQ5RL3gR5N3oEZAVNgVybs0E9XhLQ9CVNKj?=
 =?us-ascii?Q?D/XUQENq1GBMZnYeme4Gr4LAQ/inRPTa3F+U5ZTpF87Kc0jS+7klIxX0ymaY?=
 =?us-ascii?Q?chK65Bcs19sJZwCF9+cJ6s/XoZXDOO1cv9b+FmXZc+H5m3L8qaw4X419Lcnk?=
 =?us-ascii?Q?2W98sKwjQwTEa+YbrVaBGV2unF5MzZrKB41MM1ogfMaLfVteEU0OpFSUtOTR?=
 =?us-ascii?Q?xxvQKTL6TJ1WIYY6ET2Z7U3oHhSJOUATTdgtO8G1E9kj8AC4LeUk4HBHoVnr?=
 =?us-ascii?Q?u1r62Z0VSE7Uy60+6CxO+E9H3v1SO8Yx9icRHvlJx7oFLqLs1Z0C2TCD/1uX?=
 =?us-ascii?Q?bCStstDsY7kLAsvdqZ2KuQaRnVqefU4LZEAKSZtzkL/eAHCKZR9iedjflVtf?=
 =?us-ascii?Q?K6JfulTLEwY+RwkT0WesNeQwaw12hwYBVlBakBJ8uDRAMiXMohgHi7L6+Kcg?=
 =?us-ascii?Q?N6klETe1pnGvoZKqQ3dws1efmymKocs4sERk9BT5Ww6hjYhzr+BW6jUt6czH?=
 =?us-ascii?Q?jFTRJper+arWvhdwv6GufeB8kWEF8GacvlivQ6a8Gb24HQO1/7JizaB438FQ?=
 =?us-ascii?Q?5BatrpNwXiPA+COUpF/oq8a25oIos07Ev3Mw/p+bjKqy3zdmYsHETlghWI7m?=
 =?us-ascii?Q?B2NkzVYIsfN4jX0oYPY3p8gZxZYFVGW8Q/QZS5x4Y0Kf7Gs6pBi2xlPic98i?=
 =?us-ascii?Q?dSYNpoNlZwea4ubagDNMK83nypJ4rLH31J9ZVOJ+4v0HMB+1yT3FbvVKDszD?=
 =?us-ascii?Q?SD/DHAbDJMsnW9ctCh/klFvke52ebI6ndRLe6ljjdCDHt3+fEKJegAsJmE3H?=
 =?us-ascii?Q?SorUADgIf9/vh6XEqtpPd5OV8mdjYMnGdukguzdE/w0psAA4sgVToIJn2lRG?=
 =?us-ascii?Q?K2NFaza2jrIIjAZyYb2ZQQ5QsuwlS3D4ysD4nq8CcO9gBJ/rLTSyIkhPKUNX?=
 =?us-ascii?Q?hPOcCDnGucaIH7v7HYENH3ja++YjHB78zvKYKtnenvgBov0hiXZDC1v5H2if?=
 =?us-ascii?Q?DyNTnjCFA8eiGpQBczxeuRtY0hyFZRmV3fgbwZuZSHwTCjzvSfg3no4LTIcH?=
 =?us-ascii?Q?cnxFesiUY2CdZTvv0X2zOm1TdjOEYj7OUjROE8LYePkEm+K2UD+HjNll/mmn?=
 =?us-ascii?Q?CWiYpfgx7cE6UvM+5mjk/exRj/tKEfBOPZ1kC7wJIR1EcwJ2wjAS2xqDHNVo?=
 =?us-ascii?Q?SJXyI37KOZeNI7NPC4EDlipps1FwA1jEWIreeDCZaLg0sFdazTFiwNZaerxM?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3a6046-d919-4069-26d4-08dd9ea28aa5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 11:18:30.6100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+XaJyACan3UzRT/BBB10bmhHBinVb6sipOAPrQ6iNIh3TukaDvx509JITVAQSAabvPM2ot+EgTbMKk40x+1x9tHR9z4c8jaql8duJSUcW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8107
X-OriginatorOrg: intel.com

On Tue, May 27, 2025 at 11:19:04PM +0700, Bui Quang Minh wrote:
> This adds a test to test the virtio-net rx when there is a XDP socket
> bound to it. There are tests for both copy mode and zerocopy mode, both
> cases when XDP program returns XDP_PASS and XDP_REDIRECT to a XDP socket.
> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Hi Bui,

have you considered adjusting xskxceiver for your needs? If yes and you
decided to go with another test app then what were the issues around it?

This is yet another approach for xsk testing where we already have a
test framework.

> ---
>  .../selftests/drivers/net/hw/.gitignore       |   3 +
>  .../testing/selftests/drivers/net/hw/Makefile |  12 +-
>  .../drivers/net/hw/xsk_receive.bpf.c          |  43 ++
>  .../selftests/drivers/net/hw/xsk_receive.c    | 398 ++++++++++++++++++
>  .../selftests/drivers/net/hw/xsk_receive.py   |  75 ++++
>  5 files changed, 530 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/drivers/net/hw/xsk_receive.bpf.c
>  create mode 100644 tools/testing/selftests/drivers/net/hw/xsk_receive.c
>  create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_receive.py
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore b/tools/testing/selftests/drivers/net/hw/.gitignore
> index 6942bf575497..c32271faecff 100644
> --- a/tools/testing/selftests/drivers/net/hw/.gitignore
> +++ b/tools/testing/selftests/drivers/net/hw/.gitignore
> @@ -1,3 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  iou-zcrx
>  ncdevmem
> +xsk_receive.skel.h
> +xsk_receive
> +tools
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index df2c047ffa90..964edbb3b79f 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -1,6 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0+ OR MIT
>  
> -TEST_GEN_FILES = iou-zcrx
> +TEST_GEN_FILES = \
> +	iou-zcrx \
> +	xsk_receive \
> +	#
>  
>  TEST_PROGS = \
>  	csum.py \
> @@ -20,6 +23,7 @@ TEST_PROGS = \
>  	rss_input_xfrm.py \
>  	tso.py \
>  	xsk_reconfig.py \
> +	xsk_receive.py \
>  	#
>  
>  TEST_FILES := \
> @@ -48,3 +52,9 @@ include ../../../net/ynl.mk
>  include ../../../net/bpf.mk
>  
>  $(OUTPUT)/iou-zcrx: LDLIBS += -luring
> +
> +$(OUTPUT)/xsk_receive.skel.h: xsk_receive.bpf.o
> +	bpftool gen skeleton xsk_receive.bpf.o > xsk_receive.skel.h
> +
> +$(OUTPUT)/xsk_receive: xsk_receive.skel.h
> +$(OUTPUT)/xsk_receive: LDLIBS += -lbpf
> diff --git a/tools/testing/selftests/drivers/net/hw/xsk_receive.bpf.c b/tools/testing/selftests/drivers/net/hw/xsk_receive.bpf.c
> new file mode 100644
> index 000000000000..462046d95bfe
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/xsk_receive.bpf.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_endian.h>
> +#include <linux/if_ether.h>
> +#include <linux/ip.h>
> +#include <linux/in.h>
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_XSKMAP);
> +	__uint(max_entries, 1);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(__u32));
> +} xsk_map SEC(".maps");
> +
> +SEC("xdp.frags")
> +int dummy_prog(struct xdp_md *ctx)
> +{
> +	return XDP_PASS;
> +}
> +
> +SEC("xdp.frags")
> +int redirect_xsk_prog(struct xdp_md *ctx)
> +{
> +	void *data_end = (void *)(long)ctx->data_end;
> +	void *data = (void *)(long)ctx->data;
> +	struct ethhdr *eth = data;
> +	struct iphdr *iph;
> +
> +	if (data + sizeof(*eth) + sizeof(*iph) > data_end)
> +		return XDP_PASS;
> +
> +	if (bpf_htons(eth->h_proto) != ETH_P_IP)
> +		return XDP_PASS;
> +
> +	iph = data + sizeof(*eth);
> +	if (iph->protocol != IPPROTO_UDP)
> +		return XDP_PASS;
> +
> +	return bpf_redirect_map(&xsk_map, 0, XDP_DROP);
> +}
> +
> +char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/drivers/net/hw/xsk_receive.c b/tools/testing/selftests/drivers/net/hw/xsk_receive.c
> new file mode 100644
> index 000000000000..96213ceeda5c
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/xsk_receive.c
> @@ -0,0 +1,398 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <error.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <poll.h>
> +#include <stdatomic.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +#include <net/if.h>
> +#include <netinet/in.h>
> +#include <arpa/inet.h>
> +#include <linux/if_xdp.h>
> +
> +#include "xsk_receive.skel.h"
> +
> +#define load_acquire(p) \
> +	atomic_load_explicit((_Atomic typeof(*(p)) *)(p), memory_order_acquire)
> +
> +#define store_release(p, v) \
> +	atomic_store_explicit((_Atomic typeof(*(p)) *)(p), v, \
> +			      memory_order_release)
> +
> +#define UMEM_CHUNK_SIZE 0x1000
> +#define BUFFER_SIZE 0x2000
> +
> +#define SERVER_PORT 8888
> +#define CLIENT_PORT 9999
> +
> +const int num_entries = 256;
> +const char *pass_msg = "PASS";
> +
> +int cfg_client;
> +int cfg_server;
> +char *cfg_server_ip;
> +char *cfg_client_ip;
> +int cfg_ifindex;
> +int cfg_redirect;
> +int cfg_zerocopy;
> +
> +struct xdp_sock_context {
> +	int xdp_sock;
> +	void *umem_region;
> +	void *rx_ring;
> +	void *fill_ring;
> +	struct xdp_mmap_offsets off;
> +};
> +
> +struct xdp_sock_context *setup_xdp_socket(int ifindex)
> +{
> +	struct xdp_mmap_offsets off;
> +	void *rx_ring, *fill_ring;
> +	struct xdp_umem_reg umem_reg = {};
> +	int optlen = sizeof(off);
> +	int umem_len, sock, ret, i;
> +	void *umem_region;
> +	uint32_t *fr_producer;
> +	uint64_t *addr;
> +	struct sockaddr_xdp sxdp = {
> +		.sxdp_family = AF_XDP,
> +		.sxdp_ifindex = ifindex,
> +		.sxdp_queue_id = 0,
> +		.sxdp_flags = XDP_USE_SG,
> +	};
> +	struct xdp_sock_context *ctx;
> +
> +	ctx = malloc(sizeof(*ctx));
> +	if (!ctx)
> +		error(1, 0, "malloc()");
> +
> +	if (cfg_zerocopy)
> +		sxdp.sxdp_flags |= XDP_ZEROCOPY;
> +	else
> +		sxdp.sxdp_flags |= XDP_COPY;
> +
> +	umem_len = UMEM_CHUNK_SIZE * num_entries;
> +	umem_region = mmap(0, umem_len, PROT_READ | PROT_WRITE,
> +			   MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> +	if (umem_region == MAP_FAILED)
> +		error(1, errno, "mmap() umem");
> +	ctx->umem_region = umem_region;
> +
> +	sock = socket(AF_XDP, SOCK_RAW, 0);
> +	if (sock < 0)
> +		error(1, errno, "socket() XDP");
> +	ctx->xdp_sock = sock;
> +
> +	ret = setsockopt(sock, SOL_XDP, XDP_RX_RING, &num_entries,
> +			 sizeof(num_entries));
> +	if (ret < 0)
> +		error(1, errno, "setsockopt() XDP_RX_RING");
> +
> +	ret = setsockopt(sock, SOL_XDP, XDP_UMEM_COMPLETION_RING, &num_entries,
> +			 sizeof(num_entries));
> +	if (ret < 0)
> +		error(1, errno, "setsockopt() XDP_UMEM_COMPLETION_RING");
> +
> +	ret = setsockopt(sock, SOL_XDP, XDP_UMEM_FILL_RING, &num_entries,
> +			 sizeof(num_entries));
> +	if (ret < 0)
> +		error(1, errno, "setsockopt() XDP_UMEM_FILL_RING");
> +
> +	ret = getsockopt(sock, SOL_XDP, XDP_MMAP_OFFSETS, &off, &optlen);
> +	if (ret < 0)
> +		error(1, errno, "getsockopt()");
> +	ctx->off = off;
> +
> +	rx_ring = mmap(0, off.rx.desc + num_entries * sizeof(struct xdp_desc),
> +		       PROT_READ | PROT_WRITE, MAP_SHARED, sock,
> +		       XDP_PGOFF_RX_RING);
> +	if (rx_ring == (void *)-1)
> +		error(1, errno, "mmap() rx-ring");
> +	ctx->rx_ring = rx_ring;
> +
> +	fill_ring = mmap(0, off.fr.desc + num_entries * sizeof(uint64_t),
> +			 PROT_READ | PROT_WRITE, MAP_SHARED, sock,
> +			 XDP_UMEM_PGOFF_FILL_RING);
> +	if (fill_ring == (void *)-1)
> +		error(1, errno, "mmap() fill-ring");
> +	ctx->fill_ring = fill_ring;
> +
> +	umem_reg.addr = (unsigned long long)ctx->umem_region;
> +	umem_reg.len = umem_len;
> +	umem_reg.chunk_size = UMEM_CHUNK_SIZE;
> +	ret = setsockopt(sock, SOL_XDP, XDP_UMEM_REG, &umem_reg,
> +			 sizeof(umem_reg));
> +	if (ret < 0)
> +		error(1, errno, "setsockopt() XDP_UMEM_REG");
> +
> +	i = 0;
> +	while (1) {
> +		ret = bind(sock, (const struct sockaddr *)&sxdp, sizeof(sxdp));
> +		if (!ret)
> +			break;
> +
> +		if (errno == EBUSY && i < 3) {
> +			i++;
> +			sleep(1);
> +		} else {
> +			error(1, errno, "bind() XDP");
> +		}
> +	}
> +
> +	/* Submit all umem entries to fill ring */
> +	addr = fill_ring + off.fr.desc;
> +	for (i = 0; i < umem_len; i += UMEM_CHUNK_SIZE) {
> +		*addr = i;
> +		addr++;
> +	}
> +	fr_producer = fill_ring + off.fr.producer;
> +	store_release(fr_producer, num_entries);
> +
> +	return ctx;
> +}
> +
> +void setup_xdp_prog(int sock, int ifindex, int redirect)
> +{
> +	struct xsk_receive_bpf *bpf;
> +	int key, ret;
> +
> +	bpf = xsk_receive_bpf__open_and_load();
> +	if (!bpf)
> +		error(1, 0, "open eBPF");
> +
> +	key = 0;
> +	ret = bpf_map__update_elem(bpf->maps.xsk_map, &key, sizeof(key),
> +				   &sock, sizeof(sock), 0);
> +	if (ret < 0)
> +		error(1, errno, "eBPF map update");
> +
> +	if (redirect) {
> +		ret = bpf_xdp_attach(ifindex,
> +				bpf_program__fd(bpf->progs.redirect_xsk_prog),
> +				0, NULL);
> +		if (ret < 0)
> +			error(1, errno, "attach eBPF");
> +	} else {
> +		ret = bpf_xdp_attach(ifindex,
> +				     bpf_program__fd(bpf->progs.dummy_prog),
> +				     0, NULL);
> +		if (ret < 0)
> +			error(1, errno, "attach eBPF");
> +	}
> +}
> +
> +void send_pass_msg(int sock)
> +{
> +	int ret;
> +	struct sockaddr_in addr = {
> +		.sin_family = AF_INET,
> +		.sin_addr = inet_addr(cfg_client_ip),
> +		.sin_port = htons(CLIENT_PORT),
> +	};
> +
> +	ret = sendto(sock, pass_msg, sizeof(pass_msg), 0,
> +		     (const struct sockaddr *)&addr, sizeof(addr));
> +	if (ret < 0)
> +		error(1, errno, "sendto()");
> +}
> +
> +void server_recv_xdp(struct xdp_sock_context *ctx, int udp_sock)
> +{
> +	int ret;
> +	struct pollfd fds = {
> +		.fd = ctx->xdp_sock,
> +		.events = POLLIN,
> +	};
> +
> +	ret = poll(&fds, 1, -1);
> +	if (ret < 0)
> +		error(1, errno, "poll()");
> +
> +	if (fds.revents & POLLIN) {
> +		uint32_t *producer_ptr = ctx->rx_ring + ctx->off.rx.producer;
> +		uint32_t *consumer_ptr = ctx->rx_ring + ctx->off.rx.consumer;
> +		uint32_t producer, consumer;
> +		struct xdp_desc *desc;
> +
> +		producer = load_acquire(producer_ptr);
> +		consumer = load_acquire(consumer_ptr);
> +
> +		printf("Receive %d XDP buffers\n", producer - consumer);
> +
> +		store_release(consumer_ptr, producer);
> +	} else {
> +		error(1, 0, "unexpected poll event: %d", fds.revents);
> +	}
> +
> +	send_pass_msg(udp_sock);
> +}
> +
> +void server_recv_udp(int sock)
> +{
> +	char *buffer;
> +	int i, ret;
> +
> +	buffer = mmap(0, BUFFER_SIZE, PROT_READ | PROT_WRITE,
> +		      MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> +	if (buffer == MAP_FAILED)
> +		error(1, errno, "mmap() send buffer");
> +
> +	ret = recv(sock, buffer, BUFFER_SIZE, 0);
> +	if (ret < 0)
> +		error(1, errno, "recv()");
> +
> +	if (ret != BUFFER_SIZE)
> +		error(1, errno, "message is truncated, expected: %d, got: %d",
> +		      BUFFER_SIZE, ret);
> +
> +	for (i = 0; i < BUFFER_SIZE; i++)
> +		if (buffer[i] != 'a' + (i % 26))
> +			error(1, 0, "message mismatches at %d", i);
> +
> +	send_pass_msg(sock);
> +}
> +
> +int setup_udp_sock(const char *addr, int port)
> +{
> +	int sock, ret;
> +	struct sockaddr_in saddr = {
> +		.sin_family = AF_INET,
> +		.sin_addr = inet_addr(addr),
> +		.sin_port = htons(port),
> +	};
> +
> +	sock = socket(AF_INET, SOCK_DGRAM, 0);
> +	if (sock < 0)
> +		error(1, errno, "socket() UDP");
> +
> +	ret = bind(sock, (const struct sockaddr *)&saddr, sizeof(saddr));
> +	if (ret < 0)
> +		error(1, errno, "bind() UDP");
> +
> +	return sock;
> +}
> +
> +void run_server(void)
> +{
> +	int udp_sock;
> +	struct xdp_sock_context *ctx;
> +
> +	ctx = setup_xdp_socket(cfg_ifindex);
> +	setup_xdp_prog(ctx->xdp_sock, cfg_ifindex, cfg_redirect);
> +	udp_sock = setup_udp_sock(cfg_server_ip, SERVER_PORT);
> +
> +	if (cfg_redirect)
> +		server_recv_xdp(ctx, udp_sock);
> +	else
> +		server_recv_udp(udp_sock);
> +}
> +
> +void run_client(void)
> +{
> +	char *buffer;
> +	int sock, ret, i;
> +	struct sockaddr_in addr = {
> +		.sin_family = AF_INET,
> +		.sin_addr = inet_addr(cfg_server_ip),
> +		.sin_port = htons(SERVER_PORT),
> +	};
> +
> +	buffer = mmap(0, BUFFER_SIZE, PROT_READ | PROT_WRITE,
> +		      MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> +	if (buffer == MAP_FAILED)
> +		error(1, errno, "mmap() send buffer");
> +
> +	for (i = 0; i < BUFFER_SIZE; i++)
> +		buffer[i] = 'a' + (i % 26);
> +
> +	sock = setup_udp_sock(cfg_client_ip, CLIENT_PORT);
> +
> +	ret = sendto(sock, buffer, BUFFER_SIZE, 0,
> +		     (const struct sockaddr *)&addr, sizeof(addr));
> +	if (ret < 0)
> +		error(1, errno, "sendto()");
> +
> +	if (ret != BUFFER_SIZE)
> +		error(1, 0, "sent buffer is truncated, expected: %d got: %d",
> +		      BUFFER_SIZE, ret);
> +
> +	ret = recv(sock, buffer, BUFFER_SIZE, 0);
> +	if (ret < 0)
> +		error(1, errno, "recv()");
> +
> +	if ((ret != sizeof(pass_msg)) || strcmp(buffer, pass_msg))
> +		error(1, 0, "message mismatches, expected: %s, got: %s",
> +		      pass_msg, buffer);
> +}
> +
> +void print_usage(char *prog)
> +{
> +	fprintf(stderr, "Usage: %s (-c|-s) -r<server_ip> -l<client_ip>"
> +		" -i<server_ifname> [-d] [-z]\n", prog);
> +}
> +
> +void parse_opts(int argc, char **argv)
> +{
> +	int opt;
> +	char *ifname = NULL;
> +
> +	while ((opt = getopt(argc, argv, "hcsr:l:i:dz")) != -1) {
> +		switch (opt) {
> +		case 'c':
> +			if (cfg_server)
> +				error(1, 0, "Pass one of -s or -c");
> +
> +			cfg_client = 1;
> +			break;
> +		case 's':
> +			if (cfg_client)
> +				error(1, 0, "Pass one of -s or -c");
> +
> +			cfg_server = 1;
> +			break;
> +		case 'r':
> +			cfg_server_ip = optarg;
> +			break;
> +		case 'l':
> +			cfg_client_ip = optarg;
> +			break;
> +		case 'i':
> +			ifname = optarg;
> +			break;
> +		case 'd':
> +			cfg_redirect = 1;
> +			break;
> +		case 'z':
> +			cfg_zerocopy = 1;
> +			break;
> +		case 'h':
> +		default:
> +			print_usage(argv[0]);
> +			exit(1);
> +		}
> +	}
> +
> +	if (!cfg_client && !cfg_server)
> +		error(1, 0, "Pass one of -s or -c");
> +
> +	if (ifname) {
> +		cfg_ifindex = if_nametoindex(ifname);
> +		if (!cfg_ifindex)
> +			error(1, errno, "Invalid interface %s", ifname);
> +	}
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	parse_opts(argc, argv);
> +	if (cfg_client)
> +		run_client();
> +	else if (cfg_server)
> +		run_server();
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/drivers/net/hw/xsk_receive.py b/tools/testing/selftests/drivers/net/hw/xsk_receive.py
> new file mode 100755
> index 000000000000..f32cb4477b75
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/xsk_receive.py
> @@ -0,0 +1,75 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# This a test for virtio-net rx when there is a XDP socket bound to it. The test
> +# is expected to be run in the host side.
> +#
> +# The run example:
> +#
> +# export NETIF=tap0
> +# export LOCAL_V4=192.168.31.1
> +# export REMOTE_V4=192.168.31.3
> +# export REMOTE_TYPE=ssh
> +# export REMOTE_ARGS='root@192.168.31.3'
> +# ./ksft-net-drv/run_kselftest.sh -t drivers/net/hw:xsk_receive.py
> +#
> +# where:
> +# - 192.168.31.1 is the IP of tap device in the host
> +# - 192.168.31.3 is the IP of virtio-net device in the guest
> +#
> +# The Qemu command to setup virtio-net
> +# -netdev tap,id=hostnet1,vhost=on,script=no,downscript=no
> +# -device virtio-net-pci,netdev=hostnet1,iommu_platform=on,disable-legacy=on
> +#
> +# The MTU of tap device can be adjusted to test more cases:
> +# - 1500: single buffer XDP
> +# - 9000: multi-buffer XDP
> +
> +from lib.py import ksft_exit, ksft_run
> +from lib.py import KsftSkipEx, KsftFailEx
> +from lib.py import NetDrvEpEnv
> +from lib.py import bkg, cmd, wait_port_listen
> +from os import path
> +
> +SERVER_PORT = 8888
> +CLIENT_PORT = 9999
> +
> +def test_xdp_pass(cfg, server_cmd, client_cmd):
> +    with bkg(server_cmd, host=cfg.remote, exit_wait=True):
> +        wait_port_listen(SERVER_PORT, proto="udp", host=cfg.remote)
> +        cmd(client_cmd)
> +
> +def test_xdp_pass_zc(cfg, server_cmd, client_cmd):
> +    server_cmd += " -z"
> +    with bkg(server_cmd, host=cfg.remote, exit_wait=True):
> +        wait_port_listen(SERVER_PORT, proto="udp", host=cfg.remote)
> +        cmd(client_cmd)
> +
> +def test_xdp_redirect(cfg, server_cmd, client_cmd):
> +    server_cmd += " -d"
> +    with bkg(server_cmd, host=cfg.remote, exit_wait=True):
> +        wait_port_listen(SERVER_PORT, proto="udp", host=cfg.remote)
> +        cmd(client_cmd)
> +
> +def test_xdp_redirect_zc(cfg, server_cmd, client_cmd):
> +    server_cmd += " -d -z"
> +    with bkg(server_cmd, host=cfg.remote, exit_wait=True):
> +        wait_port_listen(SERVER_PORT, proto="udp", host=cfg.remote)
> +        cmd(client_cmd)
> +
> +def main():
> +    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
> +        cfg.bin_local = path.abspath(path.dirname(__file__)
> +                            + "/../../../drivers/net/hw/xsk_receive")
> +        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
> +
> +        server_cmd = f"{cfg.bin_remote} -s -i {cfg.remote_ifname} "
> +        server_cmd += f"-r {cfg.remote_addr_v["4"]} -l {cfg.addr_v["4"]}"
> +        client_cmd = f"{cfg.bin_local} -c -r {cfg.remote_addr_v["4"]} "
> +        client_cmd += f"-l {cfg.addr_v["4"]}"
> +
> +        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, server_cmd, client_cmd))
> +    ksft_exit()
> +
> +if __name__ == "__main__":
> +    main()
> -- 
> 2.43.0
> 
> 

