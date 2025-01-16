Return-Path: <bpf+bounces-49022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F673A1322C
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 05:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3E61887DAC
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 04:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D65145B16;
	Thu, 16 Jan 2025 04:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ik49tTdr"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380CE13B58A
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 04:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737003517; cv=fail; b=V4pMs02bufqeDVps+/fGv0cU7mUXKJ/cJVV9OMGBf/krZ8lxIOhUkQzsznXOZ8Bqoz8iyttjC/ZyfI8+pijvmYnkzZfhl7EJDt67CFhlONurGWyzhtX0bHYArkQ8OKYLK/8ZwrcjiqQiGaOKefamC9n3X7/P9LGijZshsxpSN6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737003517; c=relaxed/simple;
	bh=Yfvjhp05BeMXtyCnRPuKj9HBwxv3SX6PZuVXqlsItuc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LDVDT1r9TrujYgcoVTlqYm+xu0QCZtUhJVBDQtnNGG7KedDyjePw5iGKRGsLkocuI7+ZM7bLr5xPvrLpeUpvwEH9VfREIx04svx1eJ68u1/YH+rb3v2oP9h61Z5u1xT97k+QLs6Wn3Dof/NyzEUahMxfq7tmUTv4y6s6/TlLS1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ik49tTdr; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737003514; x=1768539514;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Yfvjhp05BeMXtyCnRPuKj9HBwxv3SX6PZuVXqlsItuc=;
  b=ik49tTdrtiPiviKIA8F1ydwIbAqhuhDDEr8iY/MZlF9kMTPvPzRNkQog
   EKu15FeZu4WeKbrwBfu/rjOlP/1rCTN8y8lyf4HHmbQ3cLHRFKpvmwO+s
   um4Yc3w720ML519Bx4SYw8axzd7FLU/LR8xDQ20Upe3tND/HilUGZPA1m
   BeT2nVnJtTip2tjwaVtT//mavK34gFc3Jmld8Y/ooEu135R1D2FsDxNXP
   UdAaZcQkyUtWVnHRbwRtGCsLMu2BFIP5TcZj5IySIcmaXiRzfWH/nROgq
   1ypqsbj872mMfUuSPz0xNzGNkIu+GmLkY2VrlYiyMwiRg7sn6T4m5aHBW
   w==;
X-CSE-ConnectionGUID: rMU4qRPpRxuhjar5/Lzl+A==
X-CSE-MsgGUID: kXehzMyyRvKVefvWoaKlFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="62739616"
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; 
   d="scan'208";a="62739616"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 20:58:33 -0800
X-CSE-ConnectionGUID: rJvXy5F3SpK4zxE1dd9eAQ==
X-CSE-MsgGUID: Ckl/+IyhTw23BMXw92UKpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136225296"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2025 20:58:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 15 Jan 2025 20:58:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 15 Jan 2025 20:58:31 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 15 Jan 2025 20:57:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwldaBx8XbcmcUTI4+eQuVh/U6AAp3E7JX9jlPl7n7Xq7mH9+P3YfXUC+JlkgzIIMrLJ+UmfzJCCo+hV73qYtD3cKw+fAwmoZcGBMDEwnzZV4Vkgv54rs6a71jAEgYeOBrDA6hceDYVimDEjhW102N57QTlLdd4xbTfZpyFX6VAhg7WdBMMfXWUvnZ9VPCc/c9mnu8gGLdMas7a7rV4TfR1EOMzatM7QdLqzLKoVWzxIG0++yrnrhpZiCXhnqgqRJ9jYandDi8DPHMYPYCQNULC5zPg0Pzqn4GniNLIBu3kQZP3mK9vtNsFSptthb2wfhgUhUsC0QgFQc1IzQg3rgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHChStEjXaoU4WryMTDi2V6CXnhpR5cVOmgwmOKffcI=;
 b=W79vhaC6TcUb4ofEBIUArYfQjEW7KXVfSn6RI30Q14Pq7Hw/p6/aqO7FJdbOH1RYM45DTmKe4CenDwo+HbPCZy4ijk9167u4i/iaskJ4oejydXY05o3CCEUUIZ3imb+X2w++2jsjsKqjAzhA1KcSv/XX/6qz5Z2o+07oOqCRsSVd9GM3vHADd4O7TcAshh0LK3J1aymmZxpD5d2m+2hAJKV4WHdLXMX1qxapbxSEm8lUE0zk6RfsIEZHW0GlaahB9+GPuLPsJafmgdNc+edgQY47YAz5OKZLYQAj5Z9AUZWrUbfke5M/xrHWgYN27VWp5TYiqqyeAhaCjZLEMilxDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 04:57:46 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 04:57:46 +0000
Date: Thu, 16 Jan 2025 12:57:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jordan Rome <linux@jordanrome.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <bpf@vger.kernel.org>,
	<linux-mm@kvack.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Kernel Team
	<kernel-team@fb.com>, Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt
	<shakeel.butt@linux.dev>, <oliver.sang@intel.com>
Subject: Re: [bpf-next v2 2/2] selftests/bpf: Add tests for
 bpf_copy_from_user_task_str
Message-ID: <202501161219.c031baa7-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250107020632.170883-2-linux@jordanrome.com>
X-ClientProxiedBy: SG2PR06CA0220.apcprd06.prod.outlook.com
 (2603:1096:4:68::28) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a57050-a44c-4695-d6f9-08dd35ea50d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JQlsI2sSTkCSezJiDMHrjXsKSmjMdL8xrKtXvvWS4CIBg4KIte7J5HM+nXxI?=
 =?us-ascii?Q?GTiOH3el8VFvWgMkwY5NRxEFUWmFIkgxSPhN+zjZ6iGf8MLr/l1aqYuVbwSm?=
 =?us-ascii?Q?86VTjvukuBfX7WL/nnBym2AJvoifdaXuVoBEECBpPNdnAJe1wh5OykqdWod0?=
 =?us-ascii?Q?YvTZsA0se5gipHcyxcm/ONJqL04UsodwtXu2RhMbwVRKXHTkystKDY/tQpES?=
 =?us-ascii?Q?eFo1fRzPIQXBIuAqAQ+B2akn8+zNwag3VVGcVfCT76s9g6W27e9+2LF9vjtI?=
 =?us-ascii?Q?YVpeLMdvuLwOA6RJjTQR0Qi4r7dgknZ+rVZ0RkkmIfsNN1mNM3E1O12KvNoy?=
 =?us-ascii?Q?a/s44OXY8+/LWGthVSg966Acvc0mA0phvd0hE04rlV1dwkcXsvaHsnc+J9rz?=
 =?us-ascii?Q?2rtdCqNnLrUFxqED2rqivpyrDlgVU53jSgpkmw1KOPUSFthedtVNrvDvRatQ?=
 =?us-ascii?Q?kAj0StBnlRMjwectiqKE7R9uFhvKzDlvujlEJVGQYsdn6qZPe6a09l6SUKtw?=
 =?us-ascii?Q?nRxVer8hKY3zAP6U14w4bWbXODsFxQBOR3/mcLPGK7HBbC2O3hPRySB31c6E?=
 =?us-ascii?Q?pLHBxhAFtOdv6+iu6+7fgJEvGCSQBj8wG1H3av9479bCzYHQ+BdDvsPE3GH3?=
 =?us-ascii?Q?V2zpyATVvl4+wdrLondJigvd9GfcoGhF86TdGdWeMdYuyNByAXlqRwk1t2ky?=
 =?us-ascii?Q?cMrGIbB6XPDFScemeHwvq4nUFxFhZCY+fvZwF0y/Deg6kz/SnD3tGgQukSmx?=
 =?us-ascii?Q?2dWcjM2Fjkqn4CgeRGb7lxYN0qjxeLFMG66RIeR/Tx/5HBxlMQUbcHc3jvjX?=
 =?us-ascii?Q?JKg8zLMv2VUiV3kIafrQMFW53Rmt57EbwfBfBMdm+2FfhCkFUWOh4bSt8c8J?=
 =?us-ascii?Q?XCxy2WOU0Wbh+SyoITg/JCS3mJnBTBQNFkvy86itiHjKBvJ12kdJ5+QMKm+k?=
 =?us-ascii?Q?D57zYvaxpKlusNGDNUR78pUz61cwpaUZeu5sYT1jvurKKTr81nWjiXcATcR6?=
 =?us-ascii?Q?saVTwggTAJmWcZ2/qGxNRPk5xViDwy1Ehq+T7L+YfZ8865ougt1TBYmC3T9c?=
 =?us-ascii?Q?Fp0E7o2XlmI1sHL4lXUwxMhIZ3LdJ/5xiiYG8xa2qL+HDbdQWEWhz1wxk+5p?=
 =?us-ascii?Q?OgPuc/OUJd98G1COfQ87Q3VhlLmbCnc95nUQJSe/a3psFTijYCD2efa1mBE7?=
 =?us-ascii?Q?Zbr9zgv9Oo6A+NSd52fql45BhmWHld09abD4QoLwThVt/YRCVeD+pukn4OnW?=
 =?us-ascii?Q?GLFWrnXucocV78f7SHYc8GGT+YF8bQ49zHqjeLgD9RpGXF8gQPFU4Q23qX6G?=
 =?us-ascii?Q?R9QZpJmiV6lV46RkY5w1H/FlV+1VmWzEP6X0l+8yw6jn6w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bsWBd8jx9/QCdAX8h21QCA201fyHoOAKhkdBvmjhXA67BioihchTCMPE5eAI?=
 =?us-ascii?Q?QBuujabNHddK1TvNlEs20/8bFamqZxOEqM2SwW6sxIuXNvoKRO0IW6ZB9UIu?=
 =?us-ascii?Q?8palMSqZl4B55L0TtTrgHqiQmie+jhWZYTaRzP+8v0vT4gkNexO3r87jKuBH?=
 =?us-ascii?Q?yT2OxtgjYszPEgX+RBgsBI74tyVW3+wEJd8Tk1nzqLPcOAKHlW1Ou1MVdGFN?=
 =?us-ascii?Q?P7MN0hTysshta/ow4r/k5+uTzzoLGSoSB6mlCa65S+kkom/QpgWn2caTmCVr?=
 =?us-ascii?Q?agz7ATvRblQJfMRLKId9BT0oCd5Uxhxf5glLw3pgl/3KOehsh8yPZpMDopJ5?=
 =?us-ascii?Q?KsH1u9l/yGXtQgtAAMbrSe0VUYLneljjyIjLMpeaHLipYPFeuIIRLNk53bX/?=
 =?us-ascii?Q?jRRDsfThjdeNzxXm4W+m4vaQ+ujpIp9jWkfcq4o4C/fLMPa3R6D1DdBYpFm9?=
 =?us-ascii?Q?Mbhn1yxhyUL1noYgNuFDwXWEa4IVSMKzkWoFmwXUfjAbXF+DbYLos057Vblg?=
 =?us-ascii?Q?sySHohXDiGZ0bVQ//oVVun5RtUoqiVyvrKKBtW2b6/i8DU9um64AstX85Kk4?=
 =?us-ascii?Q?4sMPdBPcNbOhnPLB8Yqm4Tp4dxs2jaw25+Jv+9vJipLiuYQNuTPBH51zUkDR?=
 =?us-ascii?Q?7MhmZBjLyP1gnJugVE9LyskJ0G316Ck+TE910YR4jVvc0i0s5pkUoq3e0Y/M?=
 =?us-ascii?Q?HJ1WCFfnM8hOHzyhwg8nW7ZJnz3EgA3MaveCByJ/wOGv40YdMFrzB8fRThyt?=
 =?us-ascii?Q?R7siuwxkv88ag+6pSEXx+IbdX9dgECS3FwiKJ28oaLpGrgoVmjEjtrd0JOo4?=
 =?us-ascii?Q?uPK4AuuQ1D6CgG8uofRlvECk3BZriDtkpm0L25LCEREEvHetwu7LOvNYgIIX?=
 =?us-ascii?Q?ZTTM6x83dG8XrQejjanGNngTcaEluOmpusmFq4reYJHhYf91vSTS2JiOBAok?=
 =?us-ascii?Q?oouay+/S1jr6hb8jKXgn/+/qPprmfi53lxcFKPXRfJFQY0yOZaJulkBuLqsj?=
 =?us-ascii?Q?NP24nan72KK4kYyaeHaeBIlarUiCtQMFXL0KfjjnWav/EO3uLtdkNcDYD2qk?=
 =?us-ascii?Q?RtdCvn6xbB3yTGc5EGwvx93mRPgkjDKYNOJkpfMgiMg0ByexIv/YHHTOagYG?=
 =?us-ascii?Q?7gFR0VAsnyz5DpBKBdbrn0vY4G5Ux5d2sDLacMOGgTLzeOAtxLQdDsnYwrsq?=
 =?us-ascii?Q?xsnYmV7l3+uiPLkjRRrTNAuce90rLSv5sTQ0cplLcz9bbryQ5GJeZcVfx2GQ?=
 =?us-ascii?Q?0WC+pdoQRABqV9DA1AoR3QyVyF+90UrGTBiiupP+In7NBb9WisCv4YBGx2iz?=
 =?us-ascii?Q?H38/rRgTMe7chUsLVRQz56hq43VF2cPD1TGFopLffdKzlL65Ge158fbnOjcC?=
 =?us-ascii?Q?rzazsSJaQUpj5AouURfmDZJ/Wv2VUoZPJcrZTGQFzxmn7vDlMNxFC/zKHbK8?=
 =?us-ascii?Q?GBEOdoGIa6PCnBNwSSRZ5wKhdYFWfXKUvLFsHtxoHYR2bj1e9TN77iHxhGkg?=
 =?us-ascii?Q?hnUyuEjCCHNM8kUbWEoRa2SpcD6SXLnb9cpTmWXLayh1XDP28Ie0pNDBRlDi?=
 =?us-ascii?Q?LkElAuWprlExbjnjJhhORQB46FtP7tuDfAETJEtBGPrZM/WU6B7PKQm0zOZ9?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a57050-a44c-4695-d6f9-08dd35ea50d2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 04:57:46.1747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lj8qocguxxt2YKuMLLR5wVAfSQ350c9kFe6lHijriGXayEJekXNuY62oGryXKgrL/S2A3Pc8s9L1t4HcGA1vHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6733
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:possible_recursive_locking_detected" on:

commit: 974e24f3e253a8e69418b73e486f74c6fa40e449 ("[bpf-next v2 2/2] selftests/bpf: Add tests for bpf_copy_from_user_task_str")
url: https://github.com/intel-lab-lkp/linux/commits/Jordan-Rome/selftests-bpf-Add-tests-for-bpf_copy_from_user_task_str/20250107-100850
base: https://git.kernel.org/cgit/linux/kernel/git/bpf/bpf-next.git master
patch link: https://lore.kernel.org/all/20250107020632.170883-2-linux@jordanrome.com/
patch subject: [bpf-next v2 2/2] selftests/bpf: Add tests for bpf_copy_from_user_task_str

in testcase: kernel-selftests-bpf
version: 
with following parameters:

	group: bpf



config: x86_64-rhel-9.4-bpf
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202501161219.c031baa7-lkp@intel.com


[ 1645.762718][T49812] WARNING: possible recursive locking detected
[ 1645.768742][T49812] 6.13.0-rc3-00084-g974e24f3e253 #1 Tainted: G           OE
[ 1645.776333][T49812] --------------------------------------------
[ 1645.782356][T49812] test_progs/49812 is trying to acquire lock:
[1645.788292][T49812] ffff88815d74c620 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault (mm/memory.c:6852 mm/memory.c:6845) 
[ 1645.796945][T49812]
[ 1645.796945][T49812] but task is already holding lock:
[1645.804188][T49812] ffff88815d74c620 (&mm->mmap_lock){++++}-{4:4}, at: copy_str_from_process_vm (include/linux/mmap_lock.h:153 mm/memory.c:6686 mm/memory.c:6810) 
[ 1645.813879][T49812]
[ 1645.813879][T49812] other info that might help us debug this:
[ 1645.821816][T49812]  Possible unsafe locking scenario:
[ 1645.821816][T49812]
[ 1645.829146][T49812]        CPU0
[ 1645.832298][T49812]        ----
[ 1645.835450][T49812]   lock(&mm->mmap_lock);
[ 1645.839652][T49812]   lock(&mm->mmap_lock);
[ 1645.843865][T49812]
[ 1645.843865][T49812]  *** DEADLOCK ***
[ 1645.843865][T49812]
[ 1645.851888][T49812]  May be due to missing lock nesting notation
[ 1645.851888][T49812]
[ 1645.860086][T49812] 3 locks held by test_progs/49812:
[1645.865153][T49812] #0: ffff88835c5ab698 (&p->lock){+.+.}-{4:4}, at: bpf_seq_read (kernel/bpf/bpf_iter.c:105) 
[1645.873715][T49812] #1: ffffffff84ca6ec0 (rcu_read_lock_trace){....}-{0:0}, at: bpf_iter_run_prog (include/linux/rcupdate.h:337 include/linux/rcupdate_trace.h:58 kernel/bpf/bpf_iter.c:700) 
[1645.883680][T49812] #2: ffff88815d74c620 (&mm->mmap_lock){++++}-{4:4}, at: copy_str_from_process_vm (include/linux/mmap_lock.h:153 mm/memory.c:6686 mm/memory.c:6810) 
[ 1645.893817][T49812]
[ 1645.893817][T49812] stack backtrace:
[ 1645.899581][T49812] CPU: 3 UID: 0 PID: 49812 Comm: test_progs Tainted: G           OE      6.13.0-rc3-00084-g974e24f3e253 #1
[ 1645.910828][T49812] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[ 1645.916848][T49812] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS 1.2.0 12/22/2016
[ 1645.924972][T49812] Call Trace:
[ 1645.928128][T49812]  <TASK>
[1645.930938][T49812] dump_stack_lvl (lib/dump_stack.c:124) 
[1645.935320][T49812] print_deadlock_bug (kernel/locking/lockdep.c:3040) 
[1645.940224][T49812] validate_chain (kernel/locking/lockdep.c:3894) 
[1645.944784][T49812] ? __pfx_validate_chain (kernel/locking/lockdep.c:3860) 
[1645.949860][T49812] ? mark_lock (kernel/locking/lockdep.c:4727) 
[1645.954062][T49812] __lock_acquire (kernel/locking/lockdep.c:5226) 
[1645.958640][T49812] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5851 kernel/locking/lockdep.c:5814) 
[1645.963015][T49812] ? __might_fault (mm/memory.c:6852 mm/memory.c:6845) 
[1645.967479][T49812] ? __pfx_lock_acquire (kernel/locking/lockdep.c:5817) 
[1645.972377][T49812] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:440 (discriminator 2)) 
[1645.977187][T49812] ? mtree_load (lib/maple_tree.c:6337) 
[1645.981563][T49812] ? lock_is_held_type (kernel/locking/lockdep.c:5590 kernel/locking/lockdep.c:5921) 
[1645.986460][T49812] ? __might_fault (mm/memory.c:6852 mm/memory.c:6845) 
[1645.990923][T49812] __might_fault (mm/memory.c:6852 mm/memory.c:6845) 
[1645.995212][T49812] ? __might_fault (mm/memory.c:6852 mm/memory.c:6845) 
[1645.999699][T49812] strncpy_from_user (lib/strncpy_from_user.c:120) 
[1646.004425][T49812] copy_str_from_process_vm (include/linux/page-flags.h:242 include/linux/highmem.h:661 mm/memory.c:6722 mm/memory.c:6810) 
[1646.009845][T49812] ? __pfx_copy_str_from_process_vm (mm/memory.c:6802) 
[1646.015789][T49812] bpf_copy_from_user_task_str (kernel/bpf/helpers.c:3104) 
[1646.021297][T49812] bpf_prog_f57787fdd126684b_dump_task_sleepable+0x278/0x4d0 
[1646.028546][T49812] ? __might_fault (mm/memory.c:6852 mm/memory.c:6845) 
[1646.033011][T49812] bpf_iter_run_prog (include/linux/bpf.h:1290 include/linux/filter.h:701 include/linux/filter.h:708 kernel/bpf/bpf_iter.c:704) 
[1646.037821][T49812] ? __pfx_bpf_iter_run_prog (kernel/bpf/bpf_iter.c:695) 
[1646.043151][T49812] ? __pfx___lock_release+0x10/0x10 
[1646.048837][T49812] task_seq_show (kernel/bpf/task_iter.c:193) 
[1646.053124][T49812] ? __pfx_task_seq_show (kernel/bpf/task_iter.c:193) 
[1646.058111][T49812] bpf_seq_read (kernel/bpf/bpf_iter.c:138) 
[1646.062399][T49812] ? rw_verify_area (include/linux/fsnotify_backend.h:501 include/linux/fsnotify.h:24 include/linux/fsnotify.h:127 include/linux/fsnotify.h:153 fs/read_write.c:470) 
[1646.067035][T49812] vfs_read (fs/read_write.c:563) 
[1646.071062][T49812] ? __pfx___lock_release+0x10/0x10 
[1646.076740][T49812] ? __pfx_vfs_read (fs/read_write.c:546) 
[1646.081290][T49812] ? __pfx___lock_release+0x10/0x10 
[1646.086968][T49812] ? __mutex_unlock_slowpath (arch/x86/include/asm/atomic64_64.h:101 include/linux/atomic/atomic-arch-fallback.h:4329 include/linux/atomic/atomic-long.h:1506 include/linux/atomic/atomic-instrumented.h:4481 kernel/locking/mutex.c:913) 
[1646.092472][T49812] ? __fget_files (include/linux/rcupdate.h:347 include/linux/rcupdate.h:880 fs/file.c:1050) 
[1646.097022][T49812] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:440 (discriminator 2)) 
[1646.101831][T49812] ? __fget_files (fs/file.c:1053) 
[1646.106383][T49812] ksys_read (fs/read_write.c:709) 
[1646.110410][T49812] ? __pfx_ksys_read (fs/read_write.c:698) 
[1646.115042][T49812] ? fput (arch/x86/include/asm/atomic64_64.h:79 include/linux/atomic/atomic-arch-fallback.h:2913 include/linux/atomic/atomic-arch-fallback.h:3364 include/linux/atomic/atomic-long.h:698 include/linux/atomic/atomic-instrumented.h:3767 include/linux/file_ref.h:157 fs/file_table.c:501) 
[1646.118809][T49812] ? ksys_read (fs/read_write.c:698) 
[1646.123007][T49812] ? mark_held_locks (kernel/locking/lockdep.c:4309) 
[1646.127662][T49812] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[1646.132033][T49812] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4347 kernel/locking/lockdep.c:4406) 
[1646.137887][T49812] ? syscall_exit_to_user_mode (arch/x86/include/asm/jump_label.h:36 include/linux/context_tracking_state.h:108 include/linux/context_tracking.h:41 include/linux/entry-common.h:364 kernel/entry/common.c:220) 
[1646.143481][T49812] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[1646.148026][T49812] ? __pfx_vfs_read (fs/read_write.c:546) 
[1646.152574][T49812] ? fput (arch/x86/include/asm/atomic64_64.h:79 include/linux/atomic/atomic-arch-fallback.h:2913 include/linux/atomic/atomic-arch-fallback.h:3364 include/linux/atomic/atomic-long.h:698 include/linux/atomic/atomic-instrumented.h:3767 include/linux/file_ref.h:157 fs/file_table.c:501) 
[1646.156339][T49812] ? __fget_files (include/linux/rcupdate.h:347 include/linux/rcupdate.h:880 fs/file.c:1050) 
[1646.160891][T49812] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:440 (discriminator 2)) 
[1646.165712][T49812] ? __fget_files (fs/file.c:1053) 
[1646.170267][T49812] ? fput (arch/x86/include/asm/atomic64_64.h:79 include/linux/atomic/atomic-arch-fallback.h:2913 include/linux/atomic/atomic-arch-fallback.h:3364 include/linux/atomic/atomic-long.h:698 include/linux/atomic/atomic-instrumented.h:3767 include/linux/file_ref.h:157 fs/file_table.c:501) 
[1646.174039][T49812] ? ksys_read (fs/read_write.c:698) 
[1646.178243][T49812] ? __pfx_ksys_read (fs/read_write.c:698) 
[1646.182887][T49812] ? mark_held_locks (kernel/locking/lockdep.c:4309) 
[1646.187531][T49812] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4347 kernel/locking/lockdep.c:4406) 
[1646.193388][T49812] ? syscall_exit_to_user_mode (arch/x86/include/asm/jump_label.h:36 include/linux/context_tracking_state.h:108 include/linux/context_tracking.h:41 include/linux/entry-common.h:364 kernel/entry/common.c:220) 
[1646.198982][T49812] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[1646.203529][T49812] ? syscall_exit_to_user_mode (arch/x86/include/asm/jump_label.h:36 include/linux/context_tracking_state.h:108 include/linux/context_tracking.h:41 include/linux/entry-common.h:364 kernel/entry/common.c:220) 
[1646.209122][T49812] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[1646.213695][T49812] ? __fget_files (fs/file.c:1053) 
[1646.218244][T49812] ? __fget_files (include/linux/rcupdate.h:347 include/linux/rcupdate.h:880 fs/file.c:1050) 
[1646.222794][T49812] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:440 (discriminator 2)) 
[1646.227602][T49812] ? __fget_files (fs/file.c:1053) 
[1646.232151][T49812] ? fput (arch/x86/include/asm/atomic64_64.h:79 include/linux/atomic/atomic-arch-fallback.h:2913 include/linux/atomic/atomic-arch-fallback.h:3364 include/linux/atomic/atomic-long.h:698 include/linux/atomic/atomic-instrumented.h:3767 include/linux/file_ref.h:157 fs/file_table.c:501) 
[1646.235917][T49812] ? ksys_read (fs/read_write.c:698) 
[1646.240118][T49812] ? __pfx_ksys_read (fs/read_write.c:698) 
[1646.244752][T49812] ? mark_held_locks (kernel/locking/lockdep.c:4309) 
[1646.249391][T49812] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4347 kernel/locking/lockdep.c:4406) 
[1646.255245][T49812] ? syscall_exit_to_user_mode (arch/x86/include/asm/jump_label.h:36 include/linux/context_tracking_state.h:108 include/linux/context_tracking.h:41 include/linux/entry-common.h:364 kernel/entry/common.c:220) 
[1646.260837][T49812] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[1646.265383][T49812] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[1646.269930][T49812] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[ 1646.275697][T49812] RIP: 0033:0x7fdb112fe25c
[ 1646.279982][T49812] Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 d9 d5 f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 48 89 44 24 08 e8 2f d6 f8 ff 48
All code
========
   0:	ec                   	in     (%dx),%al
   1:	28 48 89             	sub    %cl,-0x77(%rax)
   4:	54                   	push   %rsp
   5:	24 18                	and    $0x18,%al
   7:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
   c:	89 7c 24 08          	mov    %edi,0x8(%rsp)
  10:	e8 d9 d5 f8 ff       	call   0xfffffffffff8d5ee
  15:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
  1a:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
  1f:	41 89 c0             	mov    %eax,%r8d
  22:	8b 7c 24 08          	mov    0x8(%rsp),%edi
  26:	31 c0                	xor    %eax,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 34                	ja     0x66
  32:	44 89 c7             	mov    %r8d,%edi
  35:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  3a:	e8 2f d6 f8 ff       	call   0xfffffffffff8d66e
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 34                	ja     0x3c
   8:	44 89 c7             	mov    %r8d,%edi
   b:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  10:	e8 2f d6 f8 ff       	call   0xfffffffffff8d644
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250116/202501161219.c031baa7-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


