Return-Path: <bpf+bounces-46027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DA69E2DF5
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 22:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62C5AB28C1E
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 20:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FBC205ACD;
	Tue,  3 Dec 2024 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eieJWrxn"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDCD1FA167
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258864; cv=fail; b=d454K2vZUFKtJWnBdAd3720g0HVLFwt123df+UcShulsKJV0cfYu9K+MBmEOkrnw67ad6gYnji6QzOzLDcgqIXHAWRdlbc/y3npdc1TDs7thgirPfTrY1chFiYND0/FT3TK4rY4YorjKs0yYtRbuWVY2rkimPKmqJPoHNf8XIvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258864; c=relaxed/simple;
	bh=skdZ657azM4Eix2HD4OFYrR4KRJMS678SgXXj4DO2zk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EKLNq7cUAckn34ihJ0gpzXZ5SyivpqmFRcUQaXs9A+lzktvi87xjX5JM49iOBYShov9+JkrfQ6J0q/MiZXEjUQuRxYqVmAVoItwjPbYScYjU2g5AjOxuCQWOuBDbedAvfano8Z5c5b/cyNgPCWU8sYi5KO8i2WcmhRs4G0p9osg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eieJWrxn; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733258862; x=1764794862;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=skdZ657azM4Eix2HD4OFYrR4KRJMS678SgXXj4DO2zk=;
  b=eieJWrxngsNAGvkRNiYYVejEIoa7Hy3FSyO/1orSDCpGe3k5EmPmSUNd
   MJGkIQZtXV3IoryFgQZU38PaeWfQZfezHCQVYkvkDbT6JY10EBL9wMAOC
   y2uz9tc3/LVToPRu8mvyayMu/00DWTMZ3tmXY3Ohe/K7xJwb2CijNycsJ
   pdm8GyCSJm0npZOona4TVBBTPg5DkaE4ZvvvfE4wZ+juF0ltk2ImmaiXw
   QnoXZd2rxLvHQEWFiNDnj0S9EUC/0CGR6e3Tm8ES/kKUADyZ5oSMbKhSH
   bZfPuOkojKHH7+QVIz9SbqNKgqCjFBAj6mXsflPlMyT4YOfl08M/+lQNH
   Q==;
X-CSE-ConnectionGUID: sX2EohvVQZm4quVaWlc16w==
X-CSE-MsgGUID: axC2pxNtQHecEco35AukMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33375125"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="33375125"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 12:47:41 -0800
X-CSE-ConnectionGUID: VL3F11JHRu2QUAUGwbVKew==
X-CSE-MsgGUID: ep6CWnrwSGelXOzdjq4LBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="97980520"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 12:47:40 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 12:47:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 12:47:28 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 12:47:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3vJ1EZLfm8RWGCeM36TWHZbRO278xMkNLkj+b9Jj6iJ1QNExe54F20wsOAI0hMGE/GdMfIotDaXqXFK2/CZ7f3vx+9f3qO9zw+v7qS6XchxWRJp+lZycGy5ov7owbJeCNFItaw8Fh9Uq8DDCKmNcsxOzxGpdEzWPEds2PPsXEM4eNXLG7pKCABx1YtLNdm65FDrOc2ntNJadznzo0vdmDxG2lOPtcYfSTywFF5NFYze+4ynHP+sq3/CUCjzQb4HVtAs9msaf6DuJO6jWPYsjFh5wFDFqwFkRdR7nwEgyv6VpeHKwzZSPDPI/wN3hSq/UpfoGPZl2/UW0MNgGLB/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDzNWvWE28ojH2rz1+AepisPUTIbFjo87FuBf1LpgUo=;
 b=XlGWwGqX3u6hAalxbzSOOLBO+nFtZEr4DfJpXd0xwNxpnhgvP/oVoTGNlTh0BJheRfFj+B7pgXcSM/VK+J5Edb8AurDWYkGYh4rJH+3hBAZc9JLk5gu5CMt58mnCXgkm9LKTL1HHvhHw0NwQ6pUA/JOPXikxPYuudPhl8SUObf8CMJ2oo6bpoDXtPkL3aPdDVkQHfnGRQIH2PDi3x/6y7r8dyeutuYZ0DW6ysV7AuAwq4UaXj8BjsHP35JKp/iaXjVX22CxYXlEa2bbgm55sdJkIVFe7Nn/j++tBc8jx3kFRAq+xKitcodWEdFHCjlZ8YT3L2Nwyj+p2tfc9igWkaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MW5PR11MB5857.namprd11.prod.outlook.com (2603:10b6:303:19d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 20:47:11 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 20:47:10 +0000
Date: Tue, 3 Dec 2024 21:46:59 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
CC: Amery Hung <amery.hung@bytedance.com>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <sreedevi.joshi@intel.com>, <ast@kernel.org>
Subject: Re: [External] Storing sk_buffs as kptrs in map
Message-ID: <Z09uQ48lKEsORsS1@boxer>
References: <Z0X/9PhIhvQwsgfW@boxer>
 <CAONe225n=HosL1vBOOkzaOnG9jTYpQwDH6hwyQRAu0Cb=NBymA@mail.gmail.com>
 <d854688a-9d2d-4fed-9cb8-3e5c4498f165@linux.dev>
 <Z0dt/wZZhigcgGPI@boxer>
 <d1e95498-4613-43e0-bc6b-6f6157802649@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d1e95498-4613-43e0-bc6b-6f6157802649@linux.dev>
X-ClientProxiedBy: MI1P293CA0020.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MW5PR11MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c26b02-e94f-4db8-48fd-08dd13dba8ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L7yidxcZxzWeFv7XDQLeahrxDu8iezo6Uzc6kfLj1SKcSKrIbtNr+kV5Mlpm?=
 =?us-ascii?Q?0tk0XBQCCCFfrjYMmgjnMmzQBaYS1ps96iY+5ImemUoPGKzvoLuYgHP4cZfs?=
 =?us-ascii?Q?Q9B8P2dS0ocM9ycGjfe4+om5Nw5WOfDy1dJv++wi1tuFTDaXEsViojsjVIKk?=
 =?us-ascii?Q?P7q8GqvVg22mIt5OrPGzQPDQidwWGflXGmrFd1V0jVPl+EaZLxz1BTRHtsQz?=
 =?us-ascii?Q?1xB9bBU++VtND4IwwmZtnsbkEgIw+0IzHLP+nttaCpkg8MY+WomDY1trpliM?=
 =?us-ascii?Q?ikgCRXB8eeb2VAIgPVPCSn6waFLKPNUjW/iYovs4TwPwt5FSV/X8F+h7gImt?=
 =?us-ascii?Q?ZuP0S5n0hoO0Vw0S7tB4CU0oOkA+ggAjDA050RNajZ2Lo2woHa6/BBqbVDjS?=
 =?us-ascii?Q?gcsFhLTDTLP+PXxRs+D4G6PkGPDN51K4kFkWtgy0QoxbyGhytHk3rLuCKc1K?=
 =?us-ascii?Q?or5nNO4aapTmPJvqNaJFOHCKsBrvfxkyoMs8sULEU0duoNQuzySWa2dXHq6L?=
 =?us-ascii?Q?DI0H9ne9geK6Ci0e4PuY2E3Nose1WroWzEN2p0U5cjMQHRudXPtw0oa8RRyi?=
 =?us-ascii?Q?7s9moWxc7h241NFCqcSvPe/Bxje+u0DHbbNG1n2MMu/fLqq0I4OQZtYTXkzN?=
 =?us-ascii?Q?7eqw/qXyZDYfYK414t8O5HzCEyNmd3CKLCqlCrQ23EdvNmY1R3Cz92Sp+p8P?=
 =?us-ascii?Q?d2lIYwGQE8yIHwt3q3gIn0x9y6ptrnxFCUoJkKbhapD8ws3JXLtutGt327Ka?=
 =?us-ascii?Q?eD7BhLOcONwE+kai3LxHr6qyybF+kjKvhOFFqOPvXXpkAZHh00gGpK1QLhPK?=
 =?us-ascii?Q?Q04P38vs37GlTxLg1jwpdlHhTlnZzp64Oh4j2Vn0tmO2uEgq9P+Q/0+sRAsD?=
 =?us-ascii?Q?mrq//bETlHHjX51WXndEX101CN7oJLpyQOjGaEsPsrmT1DHzMWehVwH9tdkw?=
 =?us-ascii?Q?zwsvGcT7TWZzzV6K/V9rSpC8/jmIL/beZiFsMwWNO3J5HtPQL5v9Mz61jeVa?=
 =?us-ascii?Q?9rbAHddCuBH2q0ZfmvTRx4VKo+4UHcvAn0DX1L71yFlz53kLF54FhV1V48f5?=
 =?us-ascii?Q?X2HG9dkQXfVExRsAtVkUjWZb9v6sin6egC30Au+7Cq4vCOmuZRQj695DgVKO?=
 =?us-ascii?Q?M53FxoS7ZTolXvgJN6cykRfmkbmOTgUCXtfPOaVNiFQLueDQhP9JdbqX52jJ?=
 =?us-ascii?Q?qbhyBxXSFKlBNc7lDRX+QygCsb/ukRvZMFf7DkulP+aZAYa7eUcBHTFD3iJb?=
 =?us-ascii?Q?t3fZ3BKX2Gy6A/hxz3OfB09nl7SANW9WpohUoye03+2tTRs6alqL+Zt1esYS?=
 =?us-ascii?Q?MkbfBK3qeurG4MlCldvfCYnM9AmosbOULe7rpgdxHfTWrPkBF3uMFn7naI+O?=
 =?us-ascii?Q?XuTwfXI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ay029sYBoeGa3g01TVJmPv9xjp65vfoqcdH/cuFkNRurbBmmxW+bhclmwgQ?=
 =?us-ascii?Q?Icm/J4ydPOoKRBb+ohjTcgc3CbVtRctWNUVuS3l6nQi0u1KCY5dXMOEukDFK?=
 =?us-ascii?Q?V6Gc4cU6vPCRCjiWyxITrqkyGBLs3kGlv70TGHB6J6C0l0s0RDNsBdXhYMRg?=
 =?us-ascii?Q?FUOlmbxsx/HZY9aHNYEXi2bpWVfWh3EXBIo943t7XZHj1rLYzk1SJK6AeLze?=
 =?us-ascii?Q?rcoS1D5q3yHYzGjPHmDLhdjuXKHae8pcYx3ICjmpwI+W3t23ar/bQfB+LYhr?=
 =?us-ascii?Q?U9fRxH63a/kdUBC1L0IQhX74ikqByDrYVDEGZm1JBszoien3KTSmoMqQ5HD8?=
 =?us-ascii?Q?UXBGu4NWKGwkv2r0TpJ3YmbM+DldEb9Kzhq+DWBL8MYFb5ZKBuPpXxkCSm3w?=
 =?us-ascii?Q?HyNYJ4355lYvlTgfzyZ+NPAyo5o3591m6XTi2xznalG0pIHjd5jv1DoRtksW?=
 =?us-ascii?Q?70ShyMksbZ3CwIEFzcNZp0nlxxVtr+0o31Q5y8he+pXO5ODknxt559n0bPNp?=
 =?us-ascii?Q?4k7SL4p2W7h6mTgO8ubCLZkSYqo+222pANqXtKtfE+xuRonYRbiJY7eFxg8G?=
 =?us-ascii?Q?muQg+YbW+Gl6vZZMEDXJKu+hrXhQTmEkB0vshTAFMQhCpmgao3ei7qqclWNS?=
 =?us-ascii?Q?qSRnRYIl/tdVv6ZE0ct50tFgqVAOZ131FxBY/7pTzPGRAiPg4vTO5W7RY64p?=
 =?us-ascii?Q?izPp9wsy46LfnFCyKSztGZNdLFZv/j2ZncpaCFtM/xynrbjISBRhMjTpdVLC?=
 =?us-ascii?Q?LgUDTXlZ05sDYDlVOaJdgZt3Rd2YLK90/0lLo34kV2uzVOsS/6QUTnPlA9kE?=
 =?us-ascii?Q?yZf9ktOLnr1qSwUAvEGp6bUm4eTKos7mG95dP4QOEjYpNAtXD/3HBnUCLH84?=
 =?us-ascii?Q?Cvh0r83ojZACw2sWdUTwSFbyv3GPW60ksf7O7aj2MiE58g6pj9k9l/sEYK5N?=
 =?us-ascii?Q?bJaDGlqaYoCN3jzsNZSorTnzKsXdOFjTCdmQLz3FTG7lHpDGUP17CxTrAZQ4?=
 =?us-ascii?Q?NBKPD1WThdzDtAep25z5bCOPSR0GUKJxPwZ1VtnsY6Ly7N1CSPLi1I5btSff?=
 =?us-ascii?Q?gFMuipGLQR1pBUkis8qJEJiojgLXWwxlCvSMEiCL++gNsN04UaiZYc+pScvV?=
 =?us-ascii?Q?aVY1XDPjcJu1jnAA8pcYp21XAT57XYrNZWmoXL7Rl/2BIhbK0EQUg9xK4BJR?=
 =?us-ascii?Q?VL0bmTAoErR/ClwTUotFxknfHUvp6EiAOB4aeDQavLnt2nb/iAA3J0zqhaK0?=
 =?us-ascii?Q?aFZyLKxzR2V3S6rD8yC4Y/zsRyBMjunMbltL9qC73/skS3JaiMVNl+Eui46Y?=
 =?us-ascii?Q?53BBihjxS2L5HJvDkOY9ZkQrfvM0BIE/92AjxXW06Yw8E+Fi2d/ann8T6rRu?=
 =?us-ascii?Q?J2HnJwaeFbnZhZlueXw/w1wZm7LBAydMXBiUZ/DL+DGPgEjWVDTL9MxUdvr3?=
 =?us-ascii?Q?vFMqpozQATnDJkVkdQqKoz5nIy+1OIX7NvlLpUOoomgeo2Q495RoRDisUbdu?=
 =?us-ascii?Q?O0bCOwNb1KYBsOdouXJdDOuMnHRERx86k6YD26x1v5LR5BzRCqdWagmGJrT5?=
 =?us-ascii?Q?+q2UiElcF+BcQfr8b85OldgzaUhAENYmE1FCfYord3Vf09LdNoY8UITNgF8m?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c26b02-e94f-4db8-48fd-08dd13dba8ae
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:47:10.8105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31I8EGNm5zUtOmLWB26c98k2FCLsXJjCtN+0XjhfZIn+tPSqK0L/7P84+oeKL5ir3Efvh0O4fiU+bXeN9w9KoerHHcZ49oixIP8MewCJogE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5857
X-OriginatorOrg: intel.com

On Wed, Nov 27, 2024 at 12:54:41PM -0800, Martin KaFai Lau wrote:
> On 11/27/24 11:07 AM, Maciej Fijalkowski wrote:
> > But kfunc does not work on PTR_TO_CTX - it takes in directly sk_buff, not
> > __sk_buff. As I mention above we use bpf_cast_to_kern_ctx() and per my
> > current limited understanding it overwrites the reg->type to
> > PTR_TO_BTF_ID | PTR_TRUSTED.
> 
> Can you try skip calling the bpf_cast_to_kern_ctx and directly pass the
> "struct __sk_buff *skb" to the "struct sk_buff *bpf_skb_acquire(struct
> __sk_buff *skb).

That didn't help, log below:

libbpf: prog 'bpf_tc_ingress': -- BEGIN PROG LOAD LOG --
0: R1=ctx() R10=fp0
; map_entry = bpf_map_lookup_elem(&skb_map, &get_key); @ bpf_bpf.c:145
0: (18) r6 = 0xffffc9000d186004       ; R6_w=map_value(map=bpf_bpf.bss,ks=4,vs=8,off=4)
2: (18) r1 = 0xffff88984ab8ce00       ; R1_w=map_ptr(map=skb_map,ks=4,vs=8)
4: (18) r2 = 0xffffc9000d186004       ; R2_w=map_value(map=bpf_bpf.bss,ks=4,vs=8,off=4)
6: (85) call bpf_map_lookup_elem#1    ; R0_w=map_value_or_null(id=1,map=skb_map,ks=4,vs=8)
; if (!map_entry) { @ bpf_bpf.c:146
7: (55) if r0 != 0x0 goto pc+7 15: R0_w=map_value(map=skb_map,ks=4,vs=8) R6_w=map_value(map=bpf_bpf.bss,ks=4,vs=8,off=4) R10=fp0
; tmp = bpf_kptr_xchg(&map_entry->skb, tmp); @ bpf_bpf.c:151
15: (bf) r1 = r0                      ; R0_w=map_value(map=skb_map,ks=4,vs=8) R1_w=map_value(map=skb_map,ks=4,vs=8)
16: (b7) r2 = 0                       ; R2_w=0
17: (85) call bpf_kptr_xchg#194       ; R0_w=ptr_or_null_sk_buff(id=3,ref_obj_id=3) refs=3
18: (bf) r6 = r0                      ; R0_w=ptr_or_null_sk_buff(id=3,ref_obj_id=3) R6_w=ptr_or_null_sk_buff(id=3,ref_obj_id=3) refs=3
19: (b4) w7 = -1                      ; R7=0xffffffff refs=3
; if (!tmp) @ bpf_bpf.c:152
20: (15) if r6 == 0x0 goto pc+17      ; R6=ptr_sk_buff(ref_obj_id=3) refs=3
; bpf_printk("retrieved skb %p from index %d\n", tmp, get_key); @ bpf_bpf.c:155
21: (18) r8 = 0xffffc9000d186004      ; R8_w=map_value(map=bpf_bpf.bss,ks=4,vs=8,off=4) refs=3
23: (61) r4 = *(u32 *)(r8 +0)         ; R4_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R8_w=map_value(map=bpf_bpf.bss,ks=4,vs=8,off=4) refs=3
24: (18) r1 = 0xffff88984ab8cb20      ; R1_w=map_value(map=bpf_bpf.rodata,ks=4,vs=83,off=24) refs=3
26: (b4) w2 = 32                      ; R2_w=32 refs=3
27: (bf) r3 = r6                      ; R3_w=ptr_sk_buff(ref_obj_id=3) R6=ptr_sk_buff(ref_obj_id=3) refs=3
28: (85) call bpf_trace_printk#6      ; R0_w=scalar() refs=3
; get_key++; @ bpf_bpf.c:157
29: (61) r1 = *(u32 *)(r8 +0)         ; R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R8_w=map_value(map=bpf_bpf.bss,ks=4,vs=8,off=4) refs=3
30: (04) w1 += 1                      ; R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) refs=3
31: (b4) w7 = 0                       ; R7_w=0 refs=3
32: (b4) w2 = 0                       ; R2=0 refs=3
; if (get_key >= 16) @ bpf_bpf.c:158
33: (26) if w1 > 0xf goto pc+1        ; R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=15,var_off=(0x0; 0xf)) refs=3
34: (bc) w2 = w1                      ; R1=scalar(id=4,smin=smin32=0,smax=umax=smax32=umax32=15,var_off=(0x0; 0xf)) R2_w=scalar(id=4,smin=smin32=0,smax=umax=smax32=umax32=15,var_off=(0x0; 0xf)) refs=3
35: (63) *(u32 *)(r8 +0) = r2         ; R2_w=scalar(id=4,smin=smin32=0,smax=umax=smax32=umax32=15,var_off=(0x0; 0xf)) R8=map_value(map=bpf_bpf.bss,ks=4,vs=8,off=4) refs=3
; bpf_skb_release((struct __sk_buff *)tmp); @ bpf_bpf.c:161
36: (bf) r1 = r6                      ; R1_w=ptr_sk_buff(ref_obj_id=3) R6=ptr_sk_buff(ref_obj_id=3) refs=3
37: (85) call bpf_skb_release#102037
arg#0 expected pointer to ctx, but got ptr_
processed 34 insns (limit 1000000) max_states_per_insn 0 total_states 3 peak_states 3 mark_read 1
-- END PROG LOAD LOG --


Still the same problem. Also even it would work it was not very convenient
to cast these types back and forth...I then tried to store __sk_buff as
kptr but I ended up with:

"map 'skb_map' has to have BTF in order to use bpf_kptr_xchg"

which got me lost:) I have a solution though which I'd like to discuss.

> 
> Please share the patch and the test case. It will be easier for others to help.

I have come up with rather simple way of achieving what I desired when
starting this thread, how about something like this:

From 0df7760330cccfe71235b56018d0a33d4a3b9863 Mon Sep 17 00:00:00 2001
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Tue, 3 Dec 2024 21:00:44 +0100
Subject: [PATCH RFC bpf-next] bpf: add __ctx_ref kfunc argument suffix

The use case is when user wants to use sk_buff pointers as kptrs against
program types that take in __sk_buff struct as context.

A pair of kfuncs for acquiring and releasing skb would look as follows:

__bpf_kfunc struct sk_buff *bpf_skb_acquire(struct sk_buff *skb__ctx_ref)
__bpf_kfunc void bpf_skb_release(struct sk_buff *skb__ctx_ref)

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 kernel/bpf/verifier.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 60938b136365..b16a39d28f8a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11303,6 +11303,11 @@ static bool is_kfunc_arg_const_str(const struct btf *btf, const struct btf_param
 	return btf_param_match_suffix(btf, arg, "__str");
 }
 
+static bool is_kfunc_arg_ctx_ref(const struct btf *btf, const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__ctx_ref");
+}
+
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const struct btf_param *arg,
 					  const char *name)
@@ -11599,6 +11604,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
 		return KF_ARG_PTR_TO_CTX;
 
+	if (is_kfunc_arg_ctx_ref(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_BTF_ID;
+
 	/* In this function, we verify the kfunc's BTF as per the argument type,
 	 * leaving the rest of the verification with respect to the register
 	 * type to our caller. When a set of conditions hold in the BTF type of
-- 
2.34.1

Then below example progs store the skb on TC tx and retrieve it later on
when TC rx hook is called. This is a ping-pong of packets between veth
pair interfaces. We start with Tx on interface with progs attached and
then receive the packets back. I have stripped the other logic so that we
focus only on kptr storage:

-------------------------------8<-------------------------------

struct sk_buff *bpf_skb_acquire(struct sk_buff *skb) __ksym;
void bpf_skb_release(struct sk_buff *skb) __ksym;
void *bpf_cast_to_kern_ctx(void *) __ksym;

u32 key = 0;
u32 get_key = 0;

struct map_value {
	struct sk_buff __kptr * skb;
};

struct {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, int);
    __type(value, struct map_value);
    __uint(max_entries, 16);
} skb_map SEC(".maps");

SEC("tc") int bpf_tc_ingress(struct __sk_buff *skb)
{
	struct map_value *map_entry;
	struct sk_buff *tmp = NULL;

	map_entry = bpf_map_lookup_elem(&skb_map, &get_key);
	if (!map_entry) {
		bpf_printk("no entry at get key %d\n", get_key);
		return TC_ACT_SHOT;
	}

	tmp = bpf_kptr_xchg(&map_entry->skb, tmp);
	if (!tmp)
		return TC_ACT_UNSPEC;

	bpf_printk("retrieved skb %p from index %d\n", tmp, get_key);

	get_key++;
	if (get_key >= 16)
		get_key = 0;

	bpf_skb_release(tmp);

	return TC_ACT_OK;
}

SEC("tc") int bpf_tc_egress(struct __sk_buff *ctx)
{
	struct sk_buff *skbk = bpf_cast_to_kern_ctx(ctx);
	struct map_value *map_entry;
	struct map_value tmp_entry;
	struct sk_buff *tmp;

	tmp_entry.skb = NULL;
	bpf_map_update_elem(&skb_map, &key, &tmp_entry, BPF_ANY);
	map_entry = bpf_map_lookup_elem(&skb_map, &key);
	if (!map_entry)
		return TC_ACT_SHOT;

	skbk = bpf_skb_acquire(skbk);
	if (!skbk)
		return TC_ACT_SHOT;

	tmp = bpf_kptr_xchg(&map_entry->skb, skbk);
	if (tmp)
		bpf_skb_release(tmp);
	bpf_printk("stored skb %p at index %d\n", skbk, key);

	key++;
	if (key >= 16)
		key = 0;

	return TC_ACT_OK;
}
char LICENSE[] SEC("license") = "GPL";

------------------------------->8-------------------------------

> 
> > I tried to simplify the use case that customer has, but I am a bit worried
> > that it might only confuse people more :/ however, here it is:
> 
> No. not at all. I suspect the use case has some similarity to the
> net-timestamp patches (https://lore.kernel.org/bpf/20241028110535.82999-1-kerneljasonxing@gmail.com/)
> which uses a skb tskey to associate/co-relate different timestamp.

I was aware of this work and I will give this a deep look, thanks.

> 
> > On TC egress hook skb is stored in a map - reason for picking it over the
> > linked list or rbtree is that we want to be able to access skbs via some index,
> > say a hash. This is where we bump the skb's refcount via acquire kfunc.
> > 
> > During TC ingress hook on the same interface, the skb that was previously
> > stored in map is retrieved, current skb that resides in the context of
> > hook carries the timestamp via metadata. We then use the retrieved skb and
> > tstamp from metadata on skb_tstamp_tx() (another kfunc) and finally
> > decrement skb's refcount via release kfunc.
> > 
> > 
> > Anyways, since we are able to do similar operations on task_struct
> > (holding it in map via kptr), I don't see a reason why wouldn't we allow
> > ourselves to do it on sk_buffs, no?
> 
> skb holds other things like dev and dst, like someone may be trying to
> remove the netdevice and route...etc. Overall, yes, the skb refcnt will
> eventually be decremented when the map is freed like other kptr (e.g. task)
> do.
> 

