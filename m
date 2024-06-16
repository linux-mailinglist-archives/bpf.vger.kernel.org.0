Return-Path: <bpf+bounces-32237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B934909B60
	for <lists+bpf@lfdr.de>; Sun, 16 Jun 2024 05:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD711F22330
	for <lists+bpf@lfdr.de>; Sun, 16 Jun 2024 03:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C723516C694;
	Sun, 16 Jun 2024 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ErZ2rAlO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3D316C866
	for <bpf@vger.kernel.org>; Sun, 16 Jun 2024 03:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718507254; cv=fail; b=XR+xL7ttCV8GavHqTLcb+RQXmmgsDOhnBA5J1zfyVtY3e9YnSYSFcxB3gKlN2401ofHEDh4RZozveqsHmDOPIzsemX1R+sJEJoiUQhCAQqsskNlVnsP7WEH8p79LMtkaQg8dl/rS8zZHXfACpO73kSRvbaHCg0vvT6CDj3v3Vso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718507254; c=relaxed/simple;
	bh=qeSVptxUroh8klbOyz3oSYjyZu0v5DG5Q7zaCmDRC1I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J92lsbJQvyQXkMtMPx23xK2BAoowbRIgFv97cBEUuEdG34LHzWgtMi34W+YVPOK5L06uYIRPtCfbeH/6def1wyVMUeHsXV7tsTxWdMBI2vzqnNcLqEjA3mHFgFPD07qnbSv/0YyoxYQG2Vmv9GtHEV1IArSzcODugK3EzberoIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ErZ2rAlO; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718507251; x=1750043251;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qeSVptxUroh8klbOyz3oSYjyZu0v5DG5Q7zaCmDRC1I=;
  b=ErZ2rAlOlCbKzzPsOjBSs3J2D7F79V8yjWjcmO9LsVq2qdmw89j20AZl
   u9decrso0amkxH4aIbcpp+jMaE+QYZ2lM5cBxCs1pVL5svHga6HLIsLyX
   r32406wm09ik7iGZUgZ+4Tf8zyc51nEP1pIehtxEDj9axx55sNWbGBSut
   KQ81SiBl/od5vqew1CNH9rJoxZIEFZsDsx+DYt2PrjHv2H3NFQMVb1oxf
   8qlbIS3MMbsOP5XgdRHFYJdihwjyMzA/R8tsLCSKy10CYgvFUTn5kie9V
   o/FAZ5yrT2rv0FIuuwA8Lgnxfhpqv70jSBqc9BBmopGLNtxcuUOXkFFV7
   A==;
X-CSE-ConnectionGUID: nGdV4Hm5QGCt1ACuiLAf+Q==
X-CSE-MsgGUID: UiyI/hW+TSmhjiBfvbEZSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="15090940"
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="log'?scan'208";a="15090940"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 20:07:30 -0700
X-CSE-ConnectionGUID: 8uAaFPx/TsG4N9MJSjPslg==
X-CSE-MsgGUID: gEvIRH6fTJKw4sO7wfAdIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="log'?scan'208";a="40750816"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jun 2024 20:07:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 15 Jun 2024 20:07:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 15 Jun 2024 20:07:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 15 Jun 2024 20:07:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 15 Jun 2024 20:07:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mI/9WxPknx4yfm8Ba5/1RipU48wV8FNcJnY5+uQe++gQD+5W3PhcEnIsWi2RXd68jx35opTVWCZLPypxFrkirAZt1KWF1sKAH37pCaew4LpxXcSf89WoCaQ0bmsyGxfLXuIr7XjXaj+AA838E9OVrsE9BckfifAofK1N3whj5bScwMzluCS2Aeui29v5LKZ3/Bdne0+iLcKYUv/vlrwvP2bmNnBo7bFKxG7EwGRtYktHF4xgPiqYle0hi1pkILBgzm9Y8t8tNpm4AK3s3xdAb0lvrIvdzh7CvM6KGgZrGPwUhXL4c5UdLuhr3hALlAWrI01K0vt/OA8UcDGXvz4XAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sojBooseWapwGY8drHXZHJ4jO6qGjVvDOP9JclWenx4=;
 b=iqIBcM9AaFIy5GhTvtsbse01FbV+LcMkHKCsp8sy0A0dDLhXSfFArthP+VjrMF7817pTNvQd/34CqjLVw9oB/WN2D+Rk5PKIJONPYo60QYikEe9/Vu5zvyclx8CJ/YmXNRbhZnY39DuKt4ev6xwyZUsrEmbgRpFS2WX0gInsf6bTs49UHkqo12t7MTr3e5Kj/YqjzaZ3aP9cp74KFYkiaSRcqVKZiNPszzAk44cV7/odITB/ySRthcAvKgIqg/PZer+W18HpGSrI+iLlFrhzZLPmPbq2+EBQK0LLbJ0ZTAakfZZ9eJRKJKo6NqyCDseKbo98lLSV6wuqRQsF/mVGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by LV3PR11MB8580.namprd11.prod.outlook.com (2603:10b6:408:1ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Sun, 16 Jun
 2024 03:07:26 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::b3b:d200:42be:fe4c]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::b3b:d200:42be:fe4c%6]) with mapi id 15.20.7677.026; Sun, 16 Jun 2024
 03:07:26 +0000
Date: Sun, 16 Jun 2024 11:07:51 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@kernel.org>, <memxor@gmail.com>, <eddyz87@gmail.com>,
	<kernel-team@fb.com>
Subject: Re: [PATCH bpf] bpf: Fix remap of arena.
Message-ID: <Zm5XB5m9Ax66XoJS@xpf.sh.intel.com>
References: <20240615181935.76049-1-alexei.starovoitov@gmail.com>
Content-Type: multipart/mixed; boundary="ucz6PnOwI5rbjgT6"
Content-Disposition: inline
In-Reply-To: <20240615181935.76049-1-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB4844:EE_|LV3PR11MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b1c3c9-51b4-4d2f-48ab-08dc8db1731d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Id6NP9MdYpITuPzHnOpMHRWu+KrOdA8smNMCP36AwcmGbl9r1GkcK8RnIh3i?=
 =?us-ascii?Q?9ZTek/oucbKy5ut6Dvg4J3Bh1r9q9XD56QLpok41tt2UQckoDayiupttYEpB?=
 =?us-ascii?Q?xtmSKLzfEh06+0f2Lpc8FXO8xy22zaic11WXboULaBK74QB/bA1RwTEPqcUl?=
 =?us-ascii?Q?Drlj2ei68mi4l5AHkXMWRwuW3aalNoaxEn2icV/ITQN2a86l1fGncXxO/6Cl?=
 =?us-ascii?Q?p8HDma7Jvc4eQ9qgeuq0Q1yUTvpmuj+MjSI3q/uc4HdqV6UlCyuwrRauSCL0?=
 =?us-ascii?Q?LxcA03Z0SsPXa5rf3/rAm1qjigW3JiExdMbXccavKtJsWhL4hZGPGTA85obf?=
 =?us-ascii?Q?hwgiKGnCMaCNYymV1tUbF54566CmQheZ93haCw9TGdrx7zMPTp129gfpIpfy?=
 =?us-ascii?Q?9SPrJ293CjqrRIlQLwyVrTdNBHjH1OstfuC3vHHhKoUy/DioLVPAK9ZliH6B?=
 =?us-ascii?Q?Lbt9TYdgzHU4IEchaHh5ayzHKos+ij+QmE1s3pn2IAYFGG4q2c/ezIqrXXVk?=
 =?us-ascii?Q?bn5RaKHsrRUPuc4tfCaDSb3YU56sCbMkT/mIoTkxBufX0ZHHGfkJqijDAMJj?=
 =?us-ascii?Q?uOMg46O94Fc7TgQLKbddH5Ndoa+98LZpnyxx8D3iuNLQFyHE0ZxShItQJryF?=
 =?us-ascii?Q?icgDgQYxSEp781gM8mlnSo7TedfiHz0kL+E614AnJm2hbfRdHEt4IsqSCyH3?=
 =?us-ascii?Q?lQf7xiZyuf/SGS62PcRH+iOWIbyAq5+VmkZazB9acyaMa2PNKYK5MjUjOY6E?=
 =?us-ascii?Q?xMXiT0zcuQQqTJZIzU4xtFK5eV+8Rog182Ky049XnhWluqB69isJKiTwfqoy?=
 =?us-ascii?Q?4rdqANENbIcd7EmUgqsO4X4c8Gw0QJcDJDPPjI9sCk7lEJZ6pn7k6BbnyyKS?=
 =?us-ascii?Q?0Gu2qX2myNzUJutMgGp/4v+Ty3BAc678QjIWYTJl8oKxRiTvyvRa+u/0Xs5V?=
 =?us-ascii?Q?NIJE9FCw+bC6lWlnajveGkAylo3DVIEMywg21lrmqXGlFTH0DPgsZiRvv2nm?=
 =?us-ascii?Q?lGBHLX852gJeRQTs5FJYqcwdqeK/3IKrRLnZ/VzeKZbgtKSYSXZ5NjSv/A9+?=
 =?us-ascii?Q?SsINFgqJHQzS1mKK1TKguKseM2H1g+i8uY7U/Tz0EO9oJUrnTS8Ck/rRAq9e?=
 =?us-ascii?Q?x/Siruv+sFS7IzkeUX3IdWZG+E84pL3fjiTEZGUkzNdIPfpfUiYNv91gG1KB?=
 =?us-ascii?Q?CaP0gVWiHy6vbzC5AK2K6thRlQxI8nZBVifhJXNufM+0Cn0dujLeWAzSwEHz?=
 =?us-ascii?Q?6GJaCz1aex5yLPPxReoi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EtHdgmhAQI5Iw2PchU+3p9wVTz9p9WmBB4fpN5xQjUUWOyrgs3QMK/S6VG/D?=
 =?us-ascii?Q?EsvoSeVqiNzGxbX8v+17q+1ayuOeWQTC4hjgWdlmNpJDt70dZUF3yo+Rri+/?=
 =?us-ascii?Q?mkwpgUET3f1MdjCxrvkuhY31y59XPUHs7wmLZDO9VgOXO2h9CZmeza7oUYkx?=
 =?us-ascii?Q?N7sKo3Rg6u0opbOF6g9a0nt53vFMS4CfxX6ggGfSsVx9srkzTyoJYZ4Vjggv?=
 =?us-ascii?Q?5en6QgAU5XlVoRhQTjTYUCzYkGwsSASLQ646bICNPog4MZDEm5OAa8+lVXYi?=
 =?us-ascii?Q?XYvFSatZjX7xmCddhKkCUy8VSNC5/7zTPzFq1jx/7YJK5XRcwVgMlLfyixtY?=
 =?us-ascii?Q?30StixFgV0fkIcTHbtB+O4gzXCqdoCp/UbO4xTlcd3EdvvPzUvPzGmTZPo0L?=
 =?us-ascii?Q?chEhgI3qdQnfBBmV68bl+1uH185O5GLMnxQf80lsWAKgjV/hZ1NVlUiutCVU?=
 =?us-ascii?Q?+WDIaCVMBHkjVdx22NTPyjBvrDG0Zt6iErLKdL1eF7jWbVf+aXcmFWigSakQ?=
 =?us-ascii?Q?3L0BZLLZDt4+3DosxXpk8coXKiJdOEqrXnPckU6HJmGN4jCRKyQ/+l9QwP1K?=
 =?us-ascii?Q?p1WsozQcPIBTFIeSh18MB6JPS88OXHE6Af95vTnc93IiGEnwPhTC8yC10o0z?=
 =?us-ascii?Q?B0SXI6k4JpfuzI8Q58zf7uwbgAOPedBTAmg2r5vdqFv/EzVmhA7e0w8dQ6Ha?=
 =?us-ascii?Q?RRDPFvBy8e+KH0xEAiXyXhly32Lm0T0i+shrLNdAU7xfVPdF+CHFddl5jhxq?=
 =?us-ascii?Q?NF6Ey4F/pRAhfUcG1Kl5KRY2vKtuCAB8jq2d4V5Z/+Xl+dJWTaoTaGxe4XXa?=
 =?us-ascii?Q?q3yeRCud3r3CnV4YeSZnnhS+VYjUq1sya4wuYqdU99WmVgbU6nmkrfcAykZx?=
 =?us-ascii?Q?IubALM6r8rVDqdbuH7Kj5ARTEVaaF06cQVAgnkPIU3gU8MEq+LfNRdz+K/u6?=
 =?us-ascii?Q?L8fVbCSuhqhDbF83e/Ac1Bx+kGvxz1T1qCCt9vhjoQdoJCxkiD5BjJ/CHBig?=
 =?us-ascii?Q?3l1z0WRgo8TNHLAUKH6S/9x+V3PmUIFZUvHxywD3e5/jQhYDn1lQcFQGpNlu?=
 =?us-ascii?Q?lcafcdrYnw8jtgtVRH9o4gcUGLj+RGTOSAT4GLieEGFF3VpL9c2eSpcQjXPs?=
 =?us-ascii?Q?jDg6zXe7fD1NxrHEjjNCi/DF6rWz1Q7kRGTXyWcj607AN+WivbdUUG6QZwNh?=
 =?us-ascii?Q?5hP8fgUaFeVkMMGDCK07QdhyWcAeEtiUB79ehnfWEl1TD+RsG6sadRuRl7nX?=
 =?us-ascii?Q?LlU4c4qvnLzen7vJkxmvZ6GJCuy8YR/Z0Wl4cJlVE/tVoSsa2qOO1mWMyKGB?=
 =?us-ascii?Q?yw8aAdRR1PAKnc028k1cGqnxSYaVasRYcn8jFAWToRgINTgVRhs77xq9OrQL?=
 =?us-ascii?Q?zQAbw+tZMcI+sl++xe95DMGrbLuZn9C0bYbT0qbhe1m7m+i5ZiuLfUwDs5Qq?=
 =?us-ascii?Q?Db9TUY+6JOhOgZvFBMVu1hWymxTky4jEqsO4PwokQELZSvE+EHg/C1RioNaA?=
 =?us-ascii?Q?cD57wzSM2T37FF/+wZR4JlR6gvUKUaCLpJrV9VK8SPPNsaCmoFzE2yrMm6nu?=
 =?us-ascii?Q?BQsA23st57TLpAIFmcg9kvNsaVMt28iuSVnhMwlN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b1c3c9-51b4-4d2f-48ab-08dc8db1731d
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2024 03:07:26.2607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVWrSN97snkGpYkxq+3ltneT5OF9s5Hvd8QAOdsDAniMWBnM7bQ1UTU8Qy0fgKQlrd1P36Og32eoNtknTqVeOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8580
X-OriginatorOrg: intel.com

--ucz6PnOwI5rbjgT6
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi Alexei,

On 2024-06-15 at 11:19:35 -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The bpf arena logic didn't account for mremap operation. Add a refcnt for
> multiple mmap events to prevent use-after-free in arena_vm_close.
> 
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Closes: https://lore.kernel.org/bpf/Zmuw29IhgyPNKnIM@xpf.sh.intel.com/
> Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/arena.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 583ee4fe48ef..f31fcaf7ee8e 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -48,6 +48,7 @@ struct bpf_arena {
>  	struct maple_tree mt;
>  	struct list_head vma_list;
>  	struct mutex lock;
> +	atomic_t mmap_count;
>  };
>  
>  u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
> @@ -227,12 +228,22 @@ static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
>  	return 0;
>  }
>  
> +static void arena_vm_open(struct vm_area_struct *vma)
> +{
> +	struct bpf_map *map = vma->vm_file->private_data;
> +	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> +
> +	atomic_inc(&arena->mmap_count);
> +}
> +
>  static void arena_vm_close(struct vm_area_struct *vma)
>  {
>  	struct bpf_map *map = vma->vm_file->private_data;
>  	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
>  	struct vma_list *vml;
>  
> +	if (!atomic_dec_and_test(&arena->mmap_count))
> +		return;
>  	guard(mutex)(&arena->lock);
>  	vml = vma->vm_private_data;
>  	list_del(&vml->head);
> @@ -287,6 +298,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  }
>  
>  static const struct vm_operations_struct arena_vm_ops = {
> +	.open		= arena_vm_open,
>  	.close		= arena_vm_close,
>  	.fault          = arena_vm_fault,
>  };
> @@ -361,6 +373,7 @@ static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
>  	 */
>  	vm_flags_set(vma, VM_DONTEXPAND);
>  	vma->vm_ops = &arena_vm_ops;
> +	atomic_set(&arena->mmap_count, 1);
>  	return 0;
>  }
>  

Thanks for your fixed patch!
This issue could be reproduced in 3s without above patch.
I have tested the above patch based on v6.10-rc3 kernel, and after over
10 minutes of infinite loop testing, the issue cannot be reproduced.

Above patch fixed this issue. Attached is the fixed dmesg.

Best Regards,
Thanks!

> -- 
> 2.43.0
> 

--ucz6PnOwI5rbjgT6
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="v6.10-rc3_bpf_arena_fixed_dmesg.log"

[    0.000000] Linux version 6.10.0-rc3-fix-dirty (root@gnr-800442) (gcc (GCC) 11.4.1 20231218 (Red Hat 11.4.1-3), GNU ld version 2.35.2-43.el9) #1 SMP PREEMPT_DY4
[    0.000000] Command line: console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0 thunderbolt.dyndbg  plymouth.enable=0
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai  
[    0.000000] x86/split lock detection: #DB: warning on user-space bus_locks
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007ffe0000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] printk: legacy bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[    0.000000] DMI: Memory slots populated: 1/1
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000003] kvm-clock: using sched offset of 861180996 cycles
[    0.000502] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.001949] tsc: Detected 2995.200 MHz processor
[    0.010447] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.010468] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.010490] last_pfn = 0x7ffe0 max_arch_pfn = 0x400000000
[    0.011042] MTRR map: 4 entries (3 fixed + 1 variable; max 19), built from 8 variable MTRRs
[    0.011793] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.022771] found SMP MP-table at [mem 0x000f5ba0-0x000f5baf]
[    0.023369] Using GB pages for direct mapping
[    0.026030] ACPI: Early table checksum verification disabled
[    0.026556] ACPI: RSDP 0x00000000000F59C0 000014 (v00 BOCHS )
[    0.027089] ACPI: RSDT 0x000000007FFE1951 000034 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.027861] ACPI: FACP 0x000000007FFE17FD 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.028632] ACPI: DSDT 0x000000007FFE0040 0017BD (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.029396] ACPI: FACS 0x000000007FFE0000 000040
[    0.029818] ACPI: APIC 0x000000007FFE1871 000080 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.030578] ACPI: HPET 0x000000007FFE18F1 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.031338] ACPI: WAET 0x000000007FFE1929 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.032090] ACPI: Reserving FACP table memory at [mem 0x7ffe17fd-0x7ffe1870]
[    0.032709] ACPI: Reserving DSDT table memory at [mem 0x7ffe0040-0x7ffe17fc]
[    0.033325] ACPI: Reserving FACS table memory at [mem 0x7ffe0000-0x7ffe003f]
[    0.033938] ACPI: Reserving APIC table memory at [mem 0x7ffe1871-0x7ffe18f0]
[    0.034552] ACPI: Reserving HPET table memory at [mem 0x7ffe18f1-0x7ffe1928]
[    0.035166] ACPI: Reserving WAET table memory at [mem 0x7ffe1929-0x7ffe1950]
[    0.036306] No NUMA configuration found
[    0.036647] Faking a node at [mem 0x0000000000000000-0x000000007ffdffff]
[    0.037256] NODE_DATA(0) allocated [mem 0x7ffb4e00-0x7ffdfdff]
[    0.039478] Zone ranges:
[    0.039703]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.040249]   DMA32    [mem 0x0000000001000000-0x000000007ffdffff]
[    0.040793]   Normal   empty
[    0.041054]   Device   empty
[    0.041313] Movable zone start for each node
[    0.041693] Early memory node ranges
[    0.042007]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.042552]   node   0: [mem 0x0000000000100000-0x000000007ffdffff]
[    0.043100] Initmem setup node 0 [mem 0x0000000000001000-0x000000007ffdffff]
[    0.044101] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.045023] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.123265] On node 0, zone DMA32: 32 pages in unavailable ranges
[    0.506291] kasan: KernelAddressSanitizer initialized
[    0.507069] ACPI: PM-Timer IO Port: 0x608
[    0.507483] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.508097] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.508749] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.509317] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.509907] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.510499] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.511098] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.511707] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.512285] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.512759] TSC deadline timer available
[    0.513115] CPU topo: Max. logical packages:   1
[    0.513526] CPU topo: Max. logical dies:       1
[    0.513981] CPU topo: Max. dies per package:   1
[    0.514397] CPU topo: Max. threads per core:   1
[    0.514849] CPU topo: Num. cores per package:     2
[    0.515282] CPU topo: Num. threads per package:   2
[    0.515775] CPU topo: Allowing 2 present CPUs plus 0 hotplug CPUs
[    0.516423] kvm-guest: APIC: eoi() replaced with kvm_guest_apic_eoi_write()
[    0.517094] kvm-guest: KVM setup pv remote TLB flush
[    0.517557] kvm-guest: setup PV sched yield
[    0.518006] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.518680] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.519346] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.520011] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.520694] [mem 0x80000000-0xfeffbfff] available for PCI devices
[    0.521230] Booting paravirtualized kernel on KVM
[    0.521657] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.522587] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.524816] percpu: Embedded 84 pages/cpu s307200 r8192 d28672 u1048576
[    0.525549] pcpu-alloc: s307200 r8192 d28672 u1048576 alloc=1*2097152
[    0.525567] pcpu-alloc: [0] 0 1 
[    0.525691] kvm-guest: PV spinlocks enabled
[    0.526116] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
[    0.526805] Kernel command line: net.ifnames=0 console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0 thunderbolt.dyndbg  plymouth.enable=0
[    0.528505] random: crng init done
[    0.530231] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.531820] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.532834] Fallback order for Node 0: 0 
[    0.532852] Built 1 zonelists, mobility grouping on.  Total pages: 524158
[    0.533897] Policy zone: DMA32
[    0.534170] mem auto-init: stack:off, heap alloc:off, heap free:off, mlocked free:off
[    0.534939] stackdepot: allocating hash table via alloc_large_system_hash
[    0.535618] stackdepot hash table entries: 1048576 (order: 12, 16777216 bytes, linear)
[    0.640196] Memory: 1616716K/2096632K available (75776K kernel code, 14376K rwdata, 17064K rodata, 15256K init, 21276K bss, 479660K reserved, 0K cma-reserved)
[    0.643125] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.643683] kmemleak: Kernel memory leak detector disabled
[    0.644396] ftrace: allocating 71617 entries in 280 pages
[    0.680035] ftrace: allocated 280 pages with 3 groups
[    0.684906] Dynamic Preempt: voluntary
[    0.685955] Running RCU self tests
[    0.686253] Running RCU synchronous self tests
[    0.686649] rcu: Preemptible hierarchical RCU implementation.
[    0.687140] rcu:     RCU lockdep checking is enabled.
[    0.687552] rcu:     RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=2.
[    0.688127]  Trampoline variant of Tasks RCU enabled.
[    0.688541]  Rude variant of Tasks RCU enabled.
[    0.688907]  Tracing variant of Tasks RCU enabled.
[    0.689306] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.689943] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.690592] Running RCU synchronous self tests
[    0.690974] RCU Tasks: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1.
[    0.691571] RCU Tasks Rude: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1.
[    0.692205] RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1.
[    0.741264] NR_IRQS: 524544, nr_irqs: 440, preallocated irqs: 16
[    0.742578] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.750755] Console: colour VGA+ 80x25
[    0.751241] printk: legacy console [ttyS0] enabled
[    0.752020] printk: legacy bootconsole [earlyser0] disabled
[    0.752950] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.753575] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.753910] ... MAX_LOCK_DEPTH:          48
[    0.754253] ... MAX_LOCKDEP_KEYS:        8192
[    0.754617] ... CLASSHASH_SIZE:          4096
[    0.754987] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.755376] ... MAX_LOCKDEP_CHAINS:      65536
[    0.755830] ... CHAINHASH_SIZE:          32768
[    0.756219]  memory used by lock dependency info: 6429 kB
[    0.756804]  memory used for stack traces: 4224 kB
[    0.757244]  per task-struct memory footprint: 1920 bytes
[    0.757856] ACPI: Core revision 20240322
[    0.758850] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.759838] APIC: Switch to symmetric I/O mode setup
[    0.760420] x2apic enabled
[    0.761036] APIC: Switched APIC routing to: physical x2apic
[    0.761498] kvm-guest: APIC: send_IPI_mask() replaced with kvm_send_ipi_mask()
[    0.762096] kvm-guest: APIC: send_IPI_mask_allbutself() replaced with kvm_send_ipi_mask_allbutself()
[    0.762838] kvm-guest: setup PV IPIs
[    0.764411] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.764929] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2b2c8ec87c7, max_idle_ns: 440795278598 ns
[    0.765810] Calibrating delay loop (skipped) preset value.. 5990.40 BogoMIPS (lpj=11980800)
[    0.766607] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.767248] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.769838] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.770372] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.771088] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[    0.772021] Spectre V2 : Spectre BHI mitigation: SW BHB clearing on vm exit
[    0.772600] Spectre V2 : Spectre BHI mitigation: SW BHB clearing on syscall
[    0.773179] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.773666] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.773796] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.774428] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.775133] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.775840] MMIO Stale Data: Unknown: No mitigations
[    0.776302] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.776958] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.777796] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.778350] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.779018] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.779551] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.780084] x86/fpu: Enabled xstate features 0x207, context size is 840 bytes, using 'compacted' format.
[    0.916492] Freeing SMP alternatives memory: 56K
[    0.916941] pid_max: default: 32768 minimum: 301
[    0.917682] LSM: initializing lsm=capability,yama,ima,evm
[    0.917840] Yama: becoming mindful.
[    0.918612] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.919265] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.922612] Running RCU synchronous self tests
[    0.923020] Running RCU synchronous self tests
[    0.923840] smpboot: CPU0: Intel(R) Core(TM) Ultra 7 155H (family: 0x6, model: 0xaa, stepping: 0x4)
[    0.925772] Running RCU Tasks wait API self tests
[    1.025981] Running RCU Tasks Rude wait API self tests
[    1.026909] Running RCU Tasks Trace wait API self tests
[    1.028162] Performance Events: unsupported p6 CPU model 170 no PMU driver, software events only.
[    1.029990] signal: max sigframe size: 3632
[    1.031037] rcu: Hierarchical SRCU implementation.
[    1.031762] rcu:     Max phase no-delay instances is 1000.
[    1.033966] Callback from call_rcu_tasks_trace() invoked.
[    1.041385] NMI watchdog: Perf NMI watchdog permanently disabled
[    1.042179] smp: Bringing up secondary CPUs ...
[    1.043689] smpboot: x86: Booting SMP configuration:
[    1.044179] .... node  #0, CPUs:      #1
[    1.045988] smp: Brought up 1 node, 2 CPUs
[    1.046722] smpboot: Total of 2 processors activated (11980.80 BogoMIPS)
[    1.051723] devtmpfs: initialized
[    1.051723] x86/mm: Memory block size: 128MB
[    1.066617] Running RCU synchronous self tests
[    1.067012] Running RCU synchronous self tests
[    1.067387] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    1.067387] futex hash table entries: 512 (order: 4, 65536 bytes, linear)
[    1.067387] pinctrl core: initialized pinctrl subsystem

[    1.069910] *************************************************************
[    1.069975] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    1.069975] **                                                         **
[    1.069975] **  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  **
[    1.069975] **                                                         **
[    1.069975] ** This means that this kernel is built to expose internal **
[    1.070323] ** IOMMU data structures, which may compromise security on **
[    1.070844] ** your system.                                            **
[    1.071363] **                                                         **
[    1.071883] ** If you see this message and you are not debugging the   **
[    1.072404] ** kernel, report this immediately to your vendor!         **
[    1.072923] **                                                         **
[    1.073447] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    1.073798] *************************************************************
[    1.074396] PM: RTC time: 02:32:39, date: 2024-06-16
[    1.078658] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    1.080698] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocations
[    1.081282] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    1.081829] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    1.082581] audit: initializing netlink subsys (disabled)
[    1.086212] audit: type=2000 audit(1718505160.694:1): state=initialized audit_enabled=0 res=1
[    1.091671] thermal_sys: Registered thermal governor 'fair_share'
[    1.091685] thermal_sys: Registered thermal governor 'bang_bang'
[    1.092228] thermal_sys: Registered thermal governor 'step_wise'
[    1.092734] thermal_sys: Registered thermal governor 'user_space'
[    1.093382] cpuidle: using governor ladder
[    1.094186] cpuidle: using governor menu
[    1.094633] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    1.096696] PCI: Using configuration type 1 for base access
[    1.098024] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    1.204406] Callback from call_rcu_tasks_rude() invoked.
[    1.205504] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    1.205804] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    1.206361] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    1.206929] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    1.208029] Demotion targets for Node 0: null
[    1.213541] ACPI: Added _OSI(Module Device)
[    1.213817] ACPI: Added _OSI(Processor Device)
[    1.214198] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.214597] ACPI: Added _OSI(Processor Aggregator Device)
[    1.246846] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    1.253062] ACPI: _OSC evaluation for CPUs failed, trying _PDC
[    1.257463] ACPI: Interpreter enabled
[    1.258012] ACPI: PM: (supports S0 S3 S4 S5)
[    1.258398] ACPI: Using IOAPIC for interrupt routing
[    1.258976] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.259756] PCI: Using E820 reservations for host bridge windows
[    1.262306] ACPI: Enabled 2 GPEs in block 00 to 0F
[    1.332266] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    1.332878] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI EDR HPX-Type3]
[    1.333567] acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    1.334129] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
[    1.343564] acpiphp: Slot [3] registered
[    1.344162] acpiphp: Slot [4] registered
[    1.344763] acpiphp: Slot [5] registered
[    1.345903] acpiphp: Slot [6] registered
[    1.346567] acpiphp: Slot [7] registered
[    1.347163] acpiphp: Slot [8] registered
[    1.347776] acpiphp: Slot [9] registered
[    1.348389] acpiphp: Slot [10] registered
[    1.348982] acpiphp: Slot [11] registered
[    1.349571] acpiphp: Slot [12] registered
[    1.350045] acpiphp: Slot [13] registered
[    1.350672] acpiphp: Slot [14] registered
[    1.351272] acpiphp: Slot [15] registered
[    1.351870] acpiphp: Slot [16] registered
[    1.352469] acpiphp: Slot [17] registered
[    1.353126] acpiphp: Slot [18] registered
[    1.353736] acpiphp: Slot [19] registered
[    1.354046] acpiphp: Slot [20] registered
[    1.354641] acpiphp: Slot [21] registered
[    1.355259] acpiphp: Slot [22] registered
[    1.355853] acpiphp: Slot [23] registered
[    1.356446] acpiphp: Slot [24] registered
[    1.357044] acpiphp: Slot [25] registered
[    1.357659] acpiphp: Slot [26] registered
[    1.358059] acpiphp: Slot [27] registered
[    1.358652] acpiphp: Slot [28] registered
[    1.359243] acpiphp: Slot [29] registered
[    1.359924] acpiphp: Slot [30] registered
[    1.360562] acpiphp: Slot [31] registered
[    1.361088] PCI host bridge to bus 0000:00
[    1.361473] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    1.361806] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    1.362407] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.363071] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfebfffff window]
[    1.363741] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17fffffff window]
[    1.364433] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.365251] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000 conventional PCI endpoint
[    1.388007] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100 conventional PCI endpoint
[    1.391136] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180 conventional PCI endpoint
[    1.393471] pci 0000:00:01.1: BAR 4 [io  0xc040-0xc04f]
[    1.394441] pci 0000:00:01.1: BAR 0 [io  0x01f0-0x01f7]: legacy IDE quirk
[    1.395036] pci 0000:00:01.1: BAR 1 [io  0x03f6]: legacy IDE quirk
[    1.395576] pci 0000:00:01.1: BAR 2 [io  0x0170-0x0177]: legacy IDE quirk
[    1.396167] pci 0000:00:01.1: BAR 3 [io  0x0376]: legacy IDE quirk
[    1.397445] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000 conventional PCI endpoint
[    1.398193] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    1.398836] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    1.400142] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000 conventional PCI endpoint
[    1.402331] pci 0000:00:02.0: BAR 0 [mem 0xfd000000-0xfdffffff pref]
[    1.405406] pci 0000:00:02.0: BAR 2 [mem 0xfebf0000-0xfebf0fff]
[    1.410354] pci 0000:00:02.0: ROM [mem 0xfebe0000-0xfebeffff pref]
[    1.412337] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.438299] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000 conventional PCI endpoint
[    1.439944] pci 0000:00:03.0: BAR 0 [mem 0xfebc0000-0xfebdffff]
[    1.441217] pci 0000:00:03.0: BAR 1 [io  0xc000-0xc03f]
[    1.444809] pci 0000:00:03.0: ROM [mem 0xfeb80000-0xfebbffff pref]
[    1.485791] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    1.488611] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    1.491307] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    1.494041] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    1.495474] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    1.502095] iommu: Default domain type: Translated
[    1.502590] iommu: DMA domain TLB invalidation policy: lazy mode
[    1.507477] SCSI subsystem initialized
[    1.508281] libata version 3.00 loaded.
[    1.508766] ACPI: bus type USB registered
[    1.509473] usbcore: registered new interface driver usbfs
[    1.509961] usbcore: registered new interface driver hub
[    1.510558] usbcore: registered new device driver usb
[    1.511495] pps_core: LinuxPPS API ver. 1 registered
[    1.511961] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.512840] PTP clock support registered
[    1.514172] EDAC MC: Ver: 3.0.0
[    1.515063] EDAC DEBUG: edac_mc_sysfs_init: device mc created
[    1.520190] NetLabel: Initializing
[    1.520543] NetLabel:  domain hash size = 128
[    1.520968] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.521788] NetLabel:  unlabeled traffic allowed by default
[    1.522889] PCI: Using ACPI for IRQ routing
[    1.523319] PCI: pci_cache_line_size set to 64 bytes
[    1.523440] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    1.523467] e820: reserve RAM buffer [mem 0x7ffe0000-0x7fffffff]
[    1.523847] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    1.524453] pci 0000:00:02.0: vgaarb: bridge control possible
[    1.525003] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    1.525805] vgaarb: loaded
[    1.527283] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.527789] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    1.533966] clocksource: Switched to clocksource kvm-clock
[    1.537298] VFS: Disk quotas dquot_6.6.0
[    1.537756] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.544977] pnp: PnP ACPI init
[    1.546795] pnp 00:02: [dma 2]
[    1.552755] pnp: PnP ACPI: found 6 devices
[    1.581964] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.586173] NET: Registered PF_INET protocol family
[    1.587348] IP idents hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    1.590267] tcp_listen_portaddr_hash hash table entries: 1024 (order: 4, 73728 bytes, linear)
[    1.591201] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    1.592025] TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    1.593361] TCP bind hash table entries: 16384 (order: 9, 2359296 bytes, linear)
[    1.596661] TCP: Hash tables configured (established 16384 bind 16384)
[    1.597664] UDP hash table entries: 1024 (order: 5, 163840 bytes, linear)
[    1.598493] UDP-Lite hash table entries: 1024 (order: 5, 163840 bytes, linear)
[    1.599912] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    1.601957] RPC: Registered named UNIX socket transport module.
[    1.602555] RPC: Registered udp transport module.
[    1.603026] RPC: Registered tcp transport module.
[    1.603480] RPC: Registered tcp-with-tls transport module.
[    1.604007] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.604760] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.605383] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.605974] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    1.606644] pci_bus 0000:00: resource 7 [mem 0x80000000-0xfebfffff window]
[    1.607306] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff window]
[    1.608615] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    1.609229] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    1.609922] PCI: CLS 0 bytes, default 64
[    1.610579] ACPI: bus type thunderbolt registered
[    1.611612] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2b2c8ec87c7, max_idle_ns: 440795278598 ns
[    3.410242] Initialise system trusted keyrings
[    3.410937] Key type blacklist registered
[    3.411711] workingset: timestamp_bits=36 max_order=19 bucket_order=0
[    3.412368] zbud: loaded
[    3.415514] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    3.418104] NFS: Registering the id_resolver key type
[    3.418581] Key type id_resolver registered
[    3.418984] Key type id_legacy registered
[    3.419426] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    3.420072] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    3.421114] fuse: init (API version 7.40)
[    3.422162] SGI XFS with ACLs, security attributes, realtime, quota, no debug enabled
[    3.424692] 9p: Installing v9fs 9p2000 file system support
[    3.438307] Key type asymmetric registered
[    3.438724] Asymmetric key parser 'x509' registered
[    3.439443] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    3.440479] io scheduler mq-deadline registered
[    3.441040] io scheduler bfq registered
[    3.442816] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    3.444634] IPMI message handler: version 39.2
[    3.445194] ipmi device interface
[    3.448411] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    3.449888] ACPI: button: Power Button [PWRF]
[    3.452360] ERST DBG: ERST support is disabled.
[    3.454480] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    3.457194] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    3.490933] Callback from call_rcu_tasks() invoked.
[    3.498394] Linux agpgart interface v0.103
[    3.502603] ACPI: bus type drm_connector registered
[    3.536423] brd: module loaded
[    3.558994] loop: module loaded
[    3.574213] ata_piix 0000:00:01.1: version 2.13
[    3.580026] scsi host0: ata_piix
[    3.582167] scsi host1: ata_piix
[    3.583190] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 14 lpm-pol 0
[    3.583887] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 15 lpm-pol 0
[    3.586516] mdio_bus fixed-0: using lookup tables for GPIO lookup
[    3.586554] mdio_bus fixed-0: No GPIO consumer reset found
[    3.587878] tun: Universal TUN/TAP device driver, 1.6
[    3.589002] e100: Intel(R) PRO/100 Network Driver
[    3.589449] e100: Copyright(c) 1999-2006 Intel Corporation
[    3.590046] e1000: Intel(R) PRO/1000 Network Driver
[    3.590529] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    3.742981] ata2: found unknown device (class 0)
[    3.744467] ata1: found unknown device (class 0)
[    3.745955] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
[    3.746550] ata1.00: 17196647 sectors, multi 16: LBA48 
[    3.747582] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    3.750600] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
[    3.754492] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    3.755387] sd 0:0:0:0: [sda] 17196647 512-byte logical blocks: (8.80 GB/8.20 GiB)
[    3.756281] sd 0:0:0:0: [sda] Write Protect is off
[    3.756729] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.757821] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.759712] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    3.761734] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    3.775074] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.785826] scsi 1:0:0:0: Attached scsi generic sg1 type 5
[    5.665934] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    5.999746] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[    6.000422] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[    6.001265] e1000e: Intel(R) PRO/1000 Network Driver
[    6.001717] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    6.002370] igb: Intel(R) Gigabit Ethernet Network Driver
[    6.002876] igb: Copyright (c) 2007-2014 Intel Corporation.
[    6.003671] PPP generic driver version 2.4.2
[    6.006151] VFIO - User Level meta-driver version: 0.3
[    6.008026] usbcore: registered new interface driver uas
[    6.008626] usbcore: registered new interface driver usb-storage
[    6.009643] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    6.011532] serio: i8042 KBD port at 0x60,0x64 irq 1
[    6.012056] serio: i8042 AUX port at 0x60,0x64 irq 12
[    6.014286] mousedev: PS/2 mouse device common for all mice
[    6.016769] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    6.018595] rtc_cmos 00:05: RTC can wake from S4
[    6.020095] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input4
[    6.021953] rtc_cmos 00:05: registered as rtc0
[    6.022515] rtc_cmos 00:05: setting system clock to 2024-06-16T02:32:44 UTC (1718505164)
[    6.022612] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input3
[    6.023318] rtc_cmos 00:05: using ACPI '\_SB.PCI0.ISA.RTC' for 'wp' GPIO lookup
[    6.024043] acpi PNP0B00:00: GPIO: looking up wp-gpios
[    6.024054] acpi PNP0B00:00: GPIO: looking up wp-gpio
[    6.024062] rtc_cmos 00:05: using lookup tables for GPIO lookup
[    6.024071] rtc_cmos 00:05: No GPIO consumer wp found
[    6.024453] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
[    6.025260] i2c_dev: i2c /dev entries driver
[    6.025806] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    6.026942] device-mapper: uevent: version 1.0.3
[    6.028241] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
[    6.029049] intel_pstate: CPU model not supported
[    6.029815] sdhci: Secure Digital Host Controller Interface driver
[    6.030360] sdhci: Copyright(c) Pierre Ossman
[    6.030948] sdhci-pltfm: SDHCI platform and OF driver helper
[    6.031726] ledtrig-cpu: registered to indicate activity on CPUs
[    6.033019] drop_monitor: Initializing network drop monitor service
[    6.034204] NET: Registered PF_INET6 protocol family
[    6.043776] Segment Routing with IPv6
[    6.044224] In-situ OAM (IOAM) with IPv6
[    6.044685] NET: Registered PF_PACKET protocol family
[    6.045815] 9pnet: Installing 9P2000 support
[    6.046398] Key type dns_resolver registered
[    6.050271] IPI shorthand broadcast: enabled
[    6.117411] sched_clock: Marking stable (6096007791, 18617877)->(6165692732, -51067064)
[    6.119737] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[    6.121166] registered taskstats version 1
[    6.122540] Loading compiled-in X.509 certificates
[    6.188408] Demotion targets for Node 0: null
[    6.191164] Key type .fscrypt registered
[    6.193057] Key type fscrypt-provisioning registered
[    6.198808] Key type encrypted registered
[    6.199274] ima: No TPM chip found, activating TPM-bypass!
[    6.199795] ima: Allocated hash algorithm: sha1
[    6.200317] ima: No architecture policies found
[    6.201025] evm: Initialising EVM extended attributes:
[    6.201521] evm: security.selinux
[    6.201816] evm: security.SMACK64
[    6.202106] evm: security.SMACK64EXEC
[    6.202431] evm: security.SMACK64TRANSMUTE
[    6.202802] evm: security.SMACK64MMAP
[    6.203127] evm: security.apparmor
[    6.203452] evm: security.ima
[    6.203715] evm: security.capability
[    6.204030] evm: HMAC attrs: 0x1
[    6.208417] PM:   Magic number: 12:887:510
[    6.210433] RAS: Correctable Errors collector initialized.
[    6.212332] clk: Disabling unused clocks
[    6.213145] PM: genpd: Disabling unused power domains
[    6.215289] md: Waiting for all devices to be available before autodetect
[    6.215890] md: If you don't use raid, use raid=noautodetect
[    6.216399] md: Autodetecting RAID arrays.
[    6.216749] md: autorun ...
[    6.216987] md: ... autorun DONE.
[    6.235957] EXT4-fs (sda): mounted filesystem 088740a9-c8b4-422c-999d-a804eb68a4da ro with ordered data mode. Quota mode: none.
[    6.236805] VFS: Mounted root (ext4 filesystem) readonly on device 8:0.
[    6.240506] devtmpfs: mounted
[    6.265401] Freeing unused decrypted memory: 2028K
[    6.274983] Freeing unused kernel image (initmem) memory: 15256K
[    6.275472] Write protecting the kernel read-only data: 94208k
[    6.278097] Freeing unused kernel image (rodata/data gap) memory: 1368K
[    6.348805] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    6.349252] Run /sbin/init as init process
[    6.349493]   with arguments:
[    6.349499]     /sbin/init
[    6.349504]   with environment:
[    6.349508]     HOME=/
[    6.349513]     TERM=linux
[    6.531730] systemd[1]: systemd 252-15.el9 running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CU)
[    6.533651] systemd[1]: Detected virtualization kvm.
[    6.533973] systemd[1]: Detected architecture x86-64.
[    6.542075] systemd[1]: Hostname set to <test>.
[    6.949802] systemd-rc-local-generator[129]: /etc/rc.d/rc.local is not marked executable, skipping.
[    7.291255] systemd[1]: Queued start job for default target Multi-User System.
[    7.331202] systemd[1]: Created slice Virtual Machine and Container Slice.
[    7.340947] systemd[1]: Created slice Slice /system/getty.
[    7.346450] systemd[1]: Created slice Slice /system/modprobe.
[    7.352485] systemd[1]: Created slice Slice /system/serial-getty.
[    7.363341] systemd[1]: Created slice Slice /system/sshd-keygen.
[    7.368912] systemd[1]: Created slice User and Session Slice.
[    7.371548] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    7.376256] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    7.378936] systemd[1]: Reached target Local Integrity Protected Volumes.
[    7.381072] systemd[1]: Reached target Slice Units.
[    7.382749] systemd[1]: Reached target Swaps.
[    7.384250] systemd[1]: Reached target Local Verity Protected Volumes.
[    7.387105] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    7.390801] systemd[1]: Listening on LVM2 poll daemon socket.
[    7.393048] systemd[1]: multipathd control socket was skipped because of an unmet condition check (ConditionPathExists=/etc/multipath.conf).
[    7.497163] systemd[1]: Listening on RPCbind Server Activation Socket.
[    7.499976] systemd[1]: Reached target RPC Port Mapper.
[    7.505568] systemd[1]: Listening on Process Core Dump Socket.
[    7.507355] systemd[1]: Listening on initctl Compatibility Named Pipe.
[    7.509449] systemd[1]: Listening on Journal Socket (/dev/log).
[    7.511270] systemd[1]: Listening on Journal Socket.
[    7.513247] systemd[1]: Listening on udev Control Socket.
[    7.516240] systemd[1]: Listening on udev Kernel Socket.
[    7.543160] systemd[1]: Mounting Huge Pages File System...
[    7.553868] systemd[1]: Mounting POSIX Message Queue File System...
[    7.567603] systemd[1]: Mounting Kernel Debug File System...
[    7.580774] systemd[1]: Mounting Kernel Trace File System...
[    7.583596] systemd[1]: Kernel Module supporting RPCSEC_GSS was skipped because of an unmet condition check (ConditionPathExists=/etc/krb5.keytab).
[    7.584559] systemd[1]: Create List of Static Device Nodes was skipped because of an unmet condition check (ConditionFileNotEmpty=/lib/modules/6.10.0-rc3-fix-d.
[    7.597390] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    7.608120] systemd[1]: Starting Load Kernel Module configfs...
[    7.618758] systemd[1]: Starting Load Kernel Module drm...
[    7.643495] systemd[1]: Starting Load Kernel Module fuse...
[    7.655436] systemd[1]: Starting Read and set NIS domainname from /etc/sysconfig/network...
[    7.679999] systemd[1]: Starting Journal Service...
[    7.709111] systemd[1]: Starting Load Kernel Modules...
[    7.732110] systemd[1]: Starting Generate network units from Kernel command line...
[    7.771262] systemd[1]: Starting Remount Root and Kernel File Systems...
[    7.773168] systemd[1]: Repartition Root Disk was skipped because no trigger condition checks were met.
[    7.811373] systemd[1]: Starting Coldplug All udev Devices...
[    7.856443] systemd[1]: Mounted Huge Pages File System.
[    7.863926] systemd[1]: Mounted POSIX Message Queue File System.
[    7.865939] systemd[1]: Mounted Kernel Debug File System.
[    7.871467] systemd[1]: Mounted Kernel Trace File System.
[    7.879847] EXT4-fs (sda): re-mounted 088740a9-c8b4-422c-999d-a804eb68a4da r/w. Quota mode: none.
[    7.882753] systemd[1]: Finished Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling.
[    7.893596] systemd[1]: modprobe@configfs.service: Deactivated successfully.
[    7.896909] systemd[1]: Finished Load Kernel Module configfs.
[    7.900679] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    7.902423] systemd[1]: Finished Load Kernel Module drm.
[    7.906384] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    7.908411] systemd[1]: Finished Load Kernel Module fuse.
[    7.911719] systemd[1]: Finished Read and set NIS domainname from /etc/sysconfig/network.
[    7.914104] systemd[1]: systemd-modules-load.service: Main process exited, code=exited, status=1/FAILURE
[    7.917276] systemd[1]: systemd-modules-load.service: Failed with result 'exit-code'.
[    7.919276] systemd[1]: Failed to start Load Kernel Modules.
[    7.924415] systemd[1]: Finished Generate network units from Kernel command line.
[    7.929832] systemd[1]: Finished Remount Root and Kernel File Systems.
[    7.934224] systemd[1]: Reached target Preparation for Network.
[    7.955216] systemd[1]: Mounting FUSE Control File System...
[    7.986896] systemd[1]: Mounting Kernel Configuration File System...
[    7.991177] systemd[1]: Special handling of early boot iSCSI sessions was skipped because of an unmet condition check (ConditionDirectoryNotEmpty=/sys/class/is.
[    7.992391] systemd[1]: First Boot Wizard was skipped because of an unmet condition check (ConditionFirstBoot=yes).
[    8.007240] systemd[1]: Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
[    8.018385] systemd[1]: Starting Load/Save Random Seed...
[    8.076470] systemd[1]: Starting Apply Kernel Variables...
[    8.078351] systemd[1]: Create System Users was skipped because no trigger condition checks were met.
[    8.095098] systemd[1]: Starting Create Static Device Nodes in /dev...
[    8.114083] systemd[1]: Starting Setup Virtual Console...
[    8.144271] systemd[1]: Started Journal Service.
[    8.287060] systemd-journald[147]: Received client request to flush runtime journal.
[   12.630906] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[  619.067050] test_finished

--ucz6PnOwI5rbjgT6--

