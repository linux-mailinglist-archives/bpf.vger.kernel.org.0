Return-Path: <bpf+bounces-41068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7BC991F23
	for <lists+bpf@lfdr.de>; Sun,  6 Oct 2024 16:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609571F217FD
	for <lists+bpf@lfdr.de>; Sun,  6 Oct 2024 14:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD38137930;
	Sun,  6 Oct 2024 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q4ijN8Ev"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EE21F94A;
	Sun,  6 Oct 2024 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728226537; cv=fail; b=kFOVFgzjmAAm8Y5EtRgVdsc85TfCu0/zbhmKzn09Yqh1lS+mVRUVQCi+yaW8rB/DUPRQwzso6hr0ih4lvXbwlA2o6pToDKutRaKtyjHh/KODSfY+uoKQcYvECYUZdS/14c1AjuMkqgdjATtoLKKRdYgzxc6fGkOD3uVUGGIE9is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728226537; c=relaxed/simple;
	bh=FDbmNA3+oIM0FshO0ZVy+L33Ff+2u6t0zw6wwtp+su4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y0nPwj9yFS4SIhlcxRWAYT5GnHxTTr8qtscDyDx5ecdhy62ldHl3xDW9efwoeFwkZoI9ARpzV47pLqzT9IAQH8lIlBpCheAVuUp2zM4+6Kr0DqzPzqCBfrQiQZMD2WPodd+iOznYXeFNSy0YgQc+kbw78wa+rMM/MVjpsRxb9DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q4ijN8Ev; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728226536; x=1759762536;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=FDbmNA3+oIM0FshO0ZVy+L33Ff+2u6t0zw6wwtp+su4=;
  b=Q4ijN8EvbbWRh/y5/4hWOnSdj5HCk1R+2xRa8PKM/uO/dDeFDnil/mKP
   4XUkfpXa5hl5LWw2Pt0hi9w9G1wb77hG4W8w+1pu7uktOXQ+w8Oh0f/+P
   D8/nKCSKThnnfGJIZyYAebg/W0zlKHicZUrLTZUPlo32mlurOza5y/ijl
   il+ODGRKVovN8yM3S2yawBjdLluqno0h5x8emBSoK7/Veg5yvW8khksTO
   0C+8TK4chkG9IdiITq2Rz+EzcTYpXIbuXER/PjzPMhnPOpHuVd3yLUuGa
   ukqRjWcPpbVtdu8SLJMeOxNK0Y9YYcd9qUW8vyVe8l11k9zyF7oRjiPB0
   g==;
X-CSE-ConnectionGUID: eBifPtG9T8esOwTQA1rKSA==
X-CSE-MsgGUID: jHWdX5HhQfmWqatv/KpFtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="44851737"
X-IronPort-AV: E=Sophos;i="6.11,182,1725346800"; 
   d="scan'208";a="44851737"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2024 07:55:35 -0700
X-CSE-ConnectionGUID: 5/voAFYwRBiSrePz9Zmu5g==
X-CSE-MsgGUID: mi/g9AT9Qou/kjiDv83CMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,182,1725346800"; 
   d="scan'208";a="76052596"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2024 07:55:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 6 Oct 2024 07:55:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 6 Oct 2024 07:55:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 6 Oct 2024 07:55:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 6 Oct 2024 07:55:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wg3mCv6hzA/h+SmQhPk1c7xuAKN4dRsYl4HQkl/UdgkeXJyB4DS1KTqu+FFDA6XxKoB1dJZLyCWoRe3QeD2U2hlBezYu2AVUtzDiEI6g2Dff37bm44po2KrOEGCy0TYdXxBahZUg6nUjeNZZLbW1/6vhMay1N/G71s7/2vSBDpvKemunnCwLJPorMvJaxmJ3gn5NqQsby+daISWnIV1Dfu92WSQxu7jFhFynsqhVyIlP9ODH0fZJi1PXLkvToYHyfBwkdyuEHgCto0Bly+iUG2T+Rz5UpdazMJqHNSbgXxVvfKKBUv69Cyo5DG7E2oZ/zM2v91xObTv5KcelPKrq8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rijW1w66gbtiGbhroWPzmWb74NMTNJTerfFmH9e+z30=;
 b=to5hdBkiWfVilQ0VfpEIE6Dd2jv8/w0E+mxPaSA0XHk6eXySJc4g59UrRIzsMfsAuDJHXHmNC2bSKHWeMvno+Bv4ABYp+RmS4VKVAWH9x1lSO9j7bUIStqOT1X1didB5NodCJHSKhLD8AxXIJHonxJt5HWli04X6llR/mgf7PKf7uhqRwKbMGuhAnSOiDgi6e9KuFhcXIqv6aiL8NpIzoBm9jq+SizggMdhTzKwZDFQ9jETHmWowjiWLt31Arqp4+8WrnkCm0BT2SVaat7M7AqHTIPMnmNn249X8qilYcNy75gIaywWj0ks/tgJmpJXByXg28RJM5Y4xLSIy5vka1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV8PR11MB8723.namprd11.prod.outlook.com (2603:10b6:408:1f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sun, 6 Oct
 2024 14:55:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 14:55:30 +0000
Date: Sun, 6 Oct 2024 22:55:19 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <bpf@vger.kernel.org>, "Gustavo
 A . R . Silva" <gustavo@embeddedor.com>, Andrew Morton
	<akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, Philipp Hortmann
	<philipp.g.hortmann@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH] include: linux: Fix flex array member not at the end in
 bpf_empty_prog_array
Message-ID: <202410062215.255fb5b7-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240930181700.22839-1-philipp.g.hortmann@gmail.com>
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV8PR11MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 325faf58-908f-41c1-dbf1-08dce616ebfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tL7qIUXxBYdaIdxs56W3U5Bx5vPWdKngHwVTIixAwjkf3yKJKs5PkPHt2AbS?=
 =?us-ascii?Q?ROdDZyFmyK+OQ3XzwPy8VjzgeXu8H+Rm0ibSn88hfohp6OxTt2u9g9Kc4lUS?=
 =?us-ascii?Q?m0rUjr3Bi1an2nK76NLK+uQzM1Msu0HkU75A/LNJZMPjv140gXTYK1+yX7FU?=
 =?us-ascii?Q?+GjpZaEJB00s4DNeD35vzk2qGEBbgEiH4o/otMtbYglbdtGaNRen5IAybfaK?=
 =?us-ascii?Q?Mb6kX+Xjn7++MwYNN80Ixzx+EWws1kXpQKtKvopd5D92TbK3vcKdslMVA/ET?=
 =?us-ascii?Q?3CEQl6cFVGOliLeKD10VMcvD9s5ASJ6vRRDfuQlTdpECkVcKpKrOrOtse2uO?=
 =?us-ascii?Q?sTvgLdog8e/oLM4BLVN/0toqK5Kep8gWFtkLQHPA3nOovuo78bH9MIc9dxkf?=
 =?us-ascii?Q?VADhoe/cH9w6a9RtTYOzMzbQi3Q4B0YOsIQbMyEGcmXMB/7bu93E1t1Q56Pr?=
 =?us-ascii?Q?KNBDr1fDeMKyYapQk3zqcl4BVSgTY40vJLCbVNFBuZsELZLkH8/JfMzhlp9W?=
 =?us-ascii?Q?/wUxyG/2XeP0jRuVCbCculMO0Q4F2nNa2Jv4u9Wrf172G+HUXK0uPABgLLxD?=
 =?us-ascii?Q?pA/glOeHZL8dRlV0JEyQTWoaIY8VSmOOTJEQ1mZqugO+G0auSlX4y0cfv14k?=
 =?us-ascii?Q?w6OOlKYNkCfk6217qzmIJGwMhrWlN+DMeTvx2qLL+Tin/80QDcG4C0bOLOhh?=
 =?us-ascii?Q?e4llmFTh0Kcl3anXc3tHNzxeyt4+Cw1JBm5QeDJgt5AFD1zK0Ff7WFj7WiYU?=
 =?us-ascii?Q?O5vtACyGaJbDe0mGs1I76x7pBYiWNuzcFRESHkqzk32C6r2OfU6UobgQ7IaI?=
 =?us-ascii?Q?7V8m5+pErEhJ3O8GrmtMbThXcm6vTyEDzCaixteRM+7UkFNxlPkwIJ50EWMD?=
 =?us-ascii?Q?9d2mBpVhrj944HmjsUnokcEIQGcZOiUQQHKllRDxIF2KZvur/ryP10KGCJWK?=
 =?us-ascii?Q?9Y1HAqFckA2tj68Lul82U2VnD4Iq4Y4KF11aWOnv/aNad7+RKxQ3zSJicHKe?=
 =?us-ascii?Q?tNiDjMMQl7UERUktubSfwaG5Ex4/nUe9Z0441utiiJA8BL4/EQHq0JLiStk3?=
 =?us-ascii?Q?7wOJLNix/Hj6YMV0zq3rWWjiScDSJwsbIbwLS4qu6fETTGkDb4RYmFNhMRlw?=
 =?us-ascii?Q?tyCd6x8qXc7Zc8d3dGoGFX/P7XSs7f87VmCPOfFE3XfHDFLxhDho59O9RRZb?=
 =?us-ascii?Q?UPyQ0yO7dA/U+OoqQsCut2jADxuZR3fjm7ueSfhGVHSoI0Hy0C6c0ukK8+c?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yYR5Oos0Z5tjJYjRCcjagGAgBX14uGSP4OiDfNMpXAriU4trEAAYjj2yotab?=
 =?us-ascii?Q?P28w2BnQaF4wcd+h8lhkUJhQpW+D8ZUJTTsnMK17sf2mR9B0H8kF1h3NrRZU?=
 =?us-ascii?Q?JqHRHD8wGSX8h+27Dd3nXz45sfhQ8/0/A0eiR5xQGzPI9/Hgy997hT5a2rhN?=
 =?us-ascii?Q?Q78pDBpDltO3s99oZSoe8TB529U8ZMLp8ZT/FaGmt+tF4BlNHA+9mKEsQUn6?=
 =?us-ascii?Q?26tTX6101w150NwQnJ/Y/KDonM2eOFh9We15KShNsF7tpjhA+NfE4A9ZWTpG?=
 =?us-ascii?Q?TsAtSS1NabH9Ws3zhxLdq+LO9i4LLKGoeYEVOoi7lahE75znGqmdCMu4jKY4?=
 =?us-ascii?Q?A66g0R2iLb3emUQQKLc6DYnVMwZY4JMYKUOM5Su0af01V1gXC0rNd+WIR4Si?=
 =?us-ascii?Q?2dUpHhoZ/CHDRK9qhY0SSu3wacib6BxGKtWCptoDwEj5SJeJjLWSwRdYh0d1?=
 =?us-ascii?Q?yUvgete3sJzco6I5ikZKi0xwEu1ZqZZRcbUdEAcdUFOmoKYgM5SxpN0Odljj?=
 =?us-ascii?Q?BKRpDYxlXqv6ZD3etWU8KTct4yHbNEu2bu9lZtg8oaImGSjq2B/aQHZckYBB?=
 =?us-ascii?Q?bxru4FNB2jXL/lWOG9G1nsKhvKb26Kltpx+31HUcFGB4Pw7GIxzQE0ggvolb?=
 =?us-ascii?Q?R2lXjVSnCBlcss6MgGW9BqSk8mTVk3A1eczR1MZDebB2h0r+NdEPC2az6QTd?=
 =?us-ascii?Q?KXZMuNtXQwjDoeYDu6wmiiSWod8VQwTz+vHEumBgHNpJsrZ9rOJ1OOAXxrOW?=
 =?us-ascii?Q?1+q5QRZDIIQJgQWuAY1x7ncsPI4v4tmldavwt3pUaMlKs6txUMR2j8BzlDPO?=
 =?us-ascii?Q?N4+4a9kHQ57SxKiKbVwtugcHdBXu3b1PUSMGdRCxwqhAbqhCqBJYYDkgXvir?=
 =?us-ascii?Q?qAfESoSX04WeMtjbOGlsXVtHzCPXetO2k9KDhI4cZXHak5yIpKxzbIUV/C2H?=
 =?us-ascii?Q?8OrDfX9Ax+Xyor1bJgZYUAjorCsM5mdj0f81XoHvS9ZCdGFOpAYy5Hn6KFxg?=
 =?us-ascii?Q?JLKB5lxJ28NjXDhcpn3BmlWtY8bpFxMncCLCUufI5au6/Z/jEvnteQVz+ccf?=
 =?us-ascii?Q?cFp34Mew9j53Z8Y2xqkhcjXbZQmF6lYznkmtcVT6FQZRuhLgdpoytP9GLQNg?=
 =?us-ascii?Q?VqogHcaYNf9BmHwl5RXZWEqCKrgCKPv47Jvl5hc+aqqa/y47QOjNmBbwEjZN?=
 =?us-ascii?Q?qJPl7u3HHnnWVml46wou5uJMsnfq4jTROPQIAdlxRf4ODcLk2WunNkOeSG93?=
 =?us-ascii?Q?R2CF7LgVvOK9t/g8kEMpwCLU1tIrb+lzeFkZ+/M/tNs6cTjdueijoQkeGlZ6?=
 =?us-ascii?Q?tJU5qRnVYgE5qyjcSQ/M/Or4+GZIrfJKSbOmA03/8Sh/ItJ4CVWqycDwHnHo?=
 =?us-ascii?Q?NMyhRE0RjNOUzeghhWEiCJD2WQQQa3ozidVA8jUiBGSwtK27sE5ZanARXYS9?=
 =?us-ascii?Q?E49YzAVhoKnyGZ/LohV0JXhleKeVKyuIawhacAN40isDG3p0PnevQ/tKEv6M?=
 =?us-ascii?Q?o91D7F7ROnL3a8i1Ba1/m91neQCoJZaISdBUdMNKxo3lSVy4HCTJPkqk8VZL?=
 =?us-ascii?Q?RvuF3a2xUc3UQiqgxIbdDKvBt6uASiGgTYls8GMFSUb16KLGUciRD5PMcaMr?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 325faf58-908f-41c1-dbf1-08dce616ebfb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 14:55:30.3986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbTvVWB0ho+1Sv4GHvm5cxA/TaJF1vYocktj/xDKGzbVL1pHjk2iczdR+2qJRdDOuHTNyEJ8KYI1XRY7s30fgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8723
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:global-out-of-bounds_in__cgroup_bpf_check_dev_permission" on:

commit: fa410b506a9aa6faf7277cd478e670670d73a206 ("[PATCH] include: linux: Fix flex array member not at the end in bpf_empty_prog_array")
url: https://github.com/intel-lab-lkp/linux/commits/Philipp-Hortmann/include-linux-Fix-flex-array-member-not-at-the-end-in-bpf_empty_prog_array/20241001-022346
base: https://git.kernel.org/cgit/linux/kernel/git/bpf/bpf-next.git master
patch link: https://lore.kernel.org/all/20240930181700.22839-1-philipp.g.hortmann@gmail.com/
patch subject: [PATCH] include: linux: Fix flex array member not at the end in bpf_empty_prog_array

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------------+------------+------------+
|                                                                    | 93eeaab456 | fa410b506a |
+--------------------------------------------------------------------+------------+------------+
| BUG:KASAN:global-out-of-bounds_in__cgroup_bpf_check_dev_permission | 0          | 12         |
+--------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410062215.255fb5b7-oliver.sang@intel.com


[ 23.682727][ T112] BUG: KASAN: global-out-of-bounds in __cgroup_bpf_check_dev_permission (kernel/bpf/cgroup.c:49 kernel/bpf/cgroup.c:1545) 
[   23.683467][  T112] Read of size 8 at addr ffffffffa8495ff8 by task (modprobe)/112
[   23.684089][  T112]
[   23.684349][  T112] CPU: 1 UID: 0 PID: 112 Comm: (modprobe) Not tainted 6.11.0-10575-gfa410b506a9a #1
[   23.685081][  T112] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   23.685872][  T112] Call Trace:
[   23.686179][  T112]  <TASK>
[ 23.686457][ T112] dump_stack_lvl (lib/dump_stack.c:123 (discriminator 1)) 
[ 23.686839][ T112] print_address_description+0x2c/0x3a0 
[ 23.687351][ T112] ? __cgroup_bpf_check_dev_permission (kernel/bpf/cgroup.c:49 kernel/bpf/cgroup.c:1545) 
[ 23.687856][ T112] print_report (mm/kasan/report.c:489) 
[ 23.688241][ T112] ? kasan_addr_to_slab (mm/kasan/common.c:37) 
[ 23.688648][ T112] ? __cgroup_bpf_check_dev_permission (kernel/bpf/cgroup.c:49 kernel/bpf/cgroup.c:1545) 
[ 23.689148][ T112] kasan_report (mm/kasan/report.c:603) 
[ 23.689523][ T112] ? __cgroup_bpf_check_dev_permission (kernel/bpf/cgroup.c:49 kernel/bpf/cgroup.c:1545) 
[ 23.690028][ T112] __cgroup_bpf_check_dev_permission (kernel/bpf/cgroup.c:49 kernel/bpf/cgroup.c:1545) 
[ 23.690524][ T112] ? __pfx_make_vfsuid (fs/mnt_idmapping.c:82) 
[ 23.690932][ T112] ? read_word_at_a_time (include/asm-generic/rwonce.h:86) 
[ 23.691342][ T112] ? __pfx___cgroup_bpf_check_dev_permission (kernel/bpf/cgroup.c:1534) 
[ 23.691867][ T112] ? __pfx_make_vfsuid (fs/mnt_idmapping.c:82) 
[ 23.692282][ T112] ? generic_permission (fs/namei.c:353 fs/namei.c:414) 
[ 23.692700][ T112] devcgroup_check_permission (security/device_cgroup.c:864) 
[ 23.693150][ T112] inode_permission (fs/namei.c:540 fs/namei.c:510) 
[ 23.693549][ T112] ? try_to_unlazy (fs/namei.c:793) 
[ 23.693941][ T112] may_open (fs/namei.c:3365) 
[ 23.694288][ T112] do_open (fs/namei.c:3772) 
[ 23.694638][ T112] path_openat (fs/namei.c:3934) 
[ 23.695008][ T112] ? __pfx_path_openat (fs/namei.c:3915) 
[ 23.695410][ T112] do_filp_open (fs/namei.c:3960) 
[ 23.695788][ T112] ? __pfx_do_filp_open (fs/namei.c:3954) 
[ 23.696201][ T112] ? alloc_fd (fs/file.c:556 (discriminator 10)) 
[ 23.696580][ T112] ? getname_flags (include/linux/audit.h:316) 
[ 23.697003][ T112] do_sys_openat2 (fs/open.c:1415) 
[ 23.697390][ T112] ? __pfx_do_sys_openat2 (fs/open.c:1401) 
[ 23.697810][ T112] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 23.698231][ T112] ? sched_clock (arch/x86/include/asm/preempt.h:94 arch/x86/kernel/tsc.c:285) 
[ 23.698602][ T112] ? sched_clock_cpu (kernel/sched/clock.c:394) 
[ 23.698999][ T112] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 23.699420][ T112] ? sched_clock (arch/x86/include/asm/preempt.h:94 arch/x86/kernel/tsc.c:285) 
[ 23.699793][ T112] ? sched_clock_cpu (kernel/sched/clock.c:394) 
[ 23.700190][ T112] __x64_sys_openat (fs/open.c:1441) 
[ 23.700608][ T112] ? __pfx_sched_clock_cpu (kernel/sched/clock.c:389) 
[ 23.701030][ T112] ? __pfx___x64_sys_openat (fs/open.c:1441) 
[ 23.701462][ T112] ? kmem_cache_free (mm/slub.c:2308 mm/slub.c:4580 mm/slub.c:4682) 
[ 23.701869][ T112] ? irqtime_account_irq (kernel/sched/cputime.c:64) 
[ 23.702291][ T112] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 23.702666][ T112] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   23.703132][  T112] RIP: 0033:0x7efe9635df01
[ 23.703505][ T112] Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 49 80 3d ea 26 0e 00 00 74 6d 89 da 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 93 00 00 00 48 8b 54 24 28 64 48 2b 14 25
All code
========
   0:	75 57                	jne    0x59
   2:	89 f0                	mov    %esi,%eax
   4:	25 00 00 41 00       	and    $0x410000,%eax
   9:	3d 00 00 41 00       	cmp    $0x410000,%eax
   e:	74 49                	je     0x59
  10:	80 3d ea 26 0e 00 00 	cmpb   $0x0,0xe26ea(%rip)        # 0xe2701
  17:	74 6d                	je     0x86
  19:	89 da                	mov    %ebx,%edx
  1b:	48 89 ee             	mov    %rbp,%rsi
  1e:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
  23:	b8 01 01 00 00       	mov    $0x101,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	0f 87 93 00 00 00    	ja     0xc9
  36:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
  3b:	64                   	fs
  3c:	48                   	rex.W
  3d:	2b                   	.byte 0x2b
  3e:	14 25                	adc    $0x25,%al

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	0f 87 93 00 00 00    	ja     0x9f
   c:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
  11:	64                   	fs
  12:	48                   	rex.W
  13:	2b                   	.byte 0x2b
  14:	14 25                	adc    $0x25,%al
[   23.704934][  T112] RSP: 002b:00007ffdf04d5790 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
[   23.705595][  T112] RAX: ffffffffffffffda RBX: 0000000000000100 RCX: 00007efe9635df01
[   23.708307][  T112] RDX: 0000000000000100 RSI: 00007efe968bd74b RDI: 00000000ffffff9c
[   23.708942][  T112] RBP: 00007efe968bd74b R08: 0000000000000007 R09: 000055d1f2bf6cc0
[   23.709571][  T112] R10: 0000000000000000 R11: 0000000000000202 R12: 000055d1f2bf6cc0
[   23.710203][  T112] R13: 000055d1f2b45540 R14: 00007ffdf04d5d50 R15: 000055d1f2b42520
[   23.710833][  T112]  </TASK>
[   23.711116][  T112]
[   23.711351][  T112] The buggy address belongs to the variable:
[ 23.711816][ T112] bpf_empty_prog_array+0x18/0x40 
[   23.712227][  T112]
[   23.712471][  T112] The buggy address belongs to the physical page:
[   23.712963][  T112] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x17e695
[   23.713649][  T112] flags: 0x17ffffc0002000(reserved|node=0|zone=2|lastcpupid=0x1fffff)
[   23.714299][  T112] raw: 0017ffffc0002000 ffffea0005f9a548 ffffea0005f9a548 0000000000000000
[   23.714968][  T112] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[   23.715641][  T112] page dumped because: kasan: bad access detected
[   23.716134][  T112] page_owner info is not present (never set?)
[   23.716613][  T112]
[   23.716851][  T112] Memory state around the buggy address:
[   23.717296][  T112]  ffffffffa8495e80: 00 00 00 f9 f9 f9 f9 f9 f9 f9 f9 f9 04 f9 f9 f9
[   23.717932][  T112]  ffffffffa8495f00: f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
[   23.718573][  T112] >ffffffffa8495f80: f9 f9 f9 f9 00 00 f9 f9 f9 f9 f9 f9 00 00 00 f9
[   23.719207][  T112]                                                                 ^
[   23.719841][  T112]  ffffffffa8496000: f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9 04 f9 f9 f9
[   23.720480][  T112]  ffffffffa8496080: f9 f9 f9 f9 01 f9 f9 f9 f9 f9 f9 f9 00 00 00 00
[   23.721119][  T112] ==================================================================
[   23.721795][  T112] Disabling lock debugging due to kernel taint



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241006/202410062215.255fb5b7-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


