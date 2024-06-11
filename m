Return-Path: <bpf+bounces-31784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A22E903478
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 09:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90CAD1F2AC70
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 07:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CFC173347;
	Tue, 11 Jun 2024 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wo3fmeV/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15890172BCB;
	Tue, 11 Jun 2024 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092626; cv=fail; b=Cx7KCeCNUJuIfEfEDTVSr5pUTUDqyEAGDiFlWdV9lnStC/u146caUbVBxRiKyf00cjsLXxHYlU9D4K8XUtxaZGDE/nq+RwT0ewL6Ijw9pXCP0x6a1h+2l2Iflicai+3HHheeVp1sO1nnVcVqfs9wl5bwW7s22iUyNOPCby7/rmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092626; c=relaxed/simple;
	bh=bi+m0LXh/YSZrMN6O+nLTb+NOA9eX95biwZGN+CyHlQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cmX9ine/f8YjRjqYujd2Uc/hRgWF/e7THeKnR0LsNywRrjLlWiqhBq4rH2kXqlZbDP0jjAyyJqjzknQS1j+K5byYop8qFZP9D6c97xSbayX791B+MkNU/ro+50hNhrAa9LwK3wawojs2+vP8ZQWuTu6ZRDorlEW9SZfmIqo8yYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wo3fmeV/; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718092623; x=1749628623;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=bi+m0LXh/YSZrMN6O+nLTb+NOA9eX95biwZGN+CyHlQ=;
  b=Wo3fmeV/nZQFtdlatmq3RaogeSeJ1/rLNJCNlHl72/ED0fsYzzcj4jVa
   YqsDcSvi4KVB/hOtCoUTszR6kbRNRPFW3eZjy5HzhIYyWeEHjqmlcBGM6
   OpnlUc05/sysN43ZqG0Le7VTL7ksCcgLMsybe33gnGKSIt3VELyx9g1bv
   RYkNsCYJ+h/3VBN3zUc1cRYuH/T/IjygdHVRhEd0yBr9JNuWaNWjm/sJR
   03Gv+KjmtHnORmLY9vPLA60qPEArrp8fCqNtcobkiZ5fzIhjBzVcEIio/
   p9YQltu7Fq1jijByWa+vDVhqTVfyqPWCcaFAIdGiVh71ld76LsMcoXRfG
   Q==;
X-CSE-ConnectionGUID: L4ASgllrTI+zEk21Ir1lYQ==
X-CSE-MsgGUID: 33rrBcPwRcG3I9WA5D8tUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="26199727"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="26199727"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 00:57:02 -0700
X-CSE-ConnectionGUID: pC8ElvNjQeOMQaGdEPjCLQ==
X-CSE-MsgGUID: LpkOiQ1kTMqEC2Et3N8CSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="70517771"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 00:57:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 00:57:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 00:57:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 00:57:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3ISeR5WC/I35PxZTm6RST0QJ9UMwFDwJsEBytgoTnDQrdax7mgQlLkvTS7tf7PntagoLWx8GtO/E0V+bVYWeXfhGsQNYT6Zlfx7E9rDhL6xpjFRFyyKHaLbeCsT0I3mLBbxdXMnROoVDoOx10NPYwIRuC89KFX+ub6srIChZOOZ9sPLNw0TQb4cCUyvIo+1KuvnRA3u+mdzrinvDjGiRwqpL56W54gL69DC6xY2T+Fd0GTm9/3M972XJZzl4UvyRXNVZlDorZZg3Fp1HV3hsSsf6WgKFih6qTzUcZSJMQq4oS2yS9+F10Orzmc/63UCaqVpf78qbhGuQdaIBw7ubQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU61R8jmgCgNhMYi1IXtQxSFUVGf/slt6rOEfMpsKvw=;
 b=hrv8NZk8Pk/TbqceLwXeMcILuE5h9In/ygxcWL2hVZoMQkcnkSIC1oUM4oTblnTEOayJRsfC/K+8Ru7l9OvGMIvSljhyOtAZct3lsEKkaUajybwdbZg8o1yo+XqNlIUtR5vvtD17wS7aOjHVUdlVb94sDL4ESvHXVEs9SRrgOcqFR2nMCvB1AcKp+gkgmHUbdbq1vKI6pCPbfmHYEIN/q9Gw0DjTi9s7NrDoz8XnES1yuXOLY1tsuWMwJ6zcjvwv3a9FgBlMUI8M605y1RHvGWSbAsqgvmeOK6GNoxls3E/fBEIgMoDoSAo7Z4NTStruzuVpFtpG2GidpCEuFwXBLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BY1PR11MB8054.namprd11.prod.outlook.com (2603:10b6:a03:52f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 07:56:58 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 07:56:58 +0000
Date: Tue, 11 Jun 2024 15:56:46 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Luo Gengkun <luogengkun@huaweicloud.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<pmladek@suse.com>, <mhocko@suse.com>, <lecopzer.chen@mediatek.com>,
	<yaoma@linux.alibaba.com>, <linuxppc-dev@lists.ozlabs.org>,
	<dianders@chromium.org>, <song@kernel.org>, <bpf@vger.kernel.org>,
	<npiggin@gmail.com>, <trix@redhat.com>, <naveen.n.rao@linux.ibm.com>,
	<kernelfans@gmail.com>, <akpm@linux-foundation.org>,
	<luogengkun@huaweicloud.com>, <tglx@linutronix.de>, <oliver.sang@intel.com>
Subject: Re: [PATCH] watchdog/core: Fix AA deadlock due to watchdog holding
 cpu_hotplug_lock and wait for wq
Message-ID: <202406111537.dd9d27e9-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240606153828.3261006-1-luogengkun@huaweicloud.com>
X-ClientProxiedBy: SGAP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::25)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BY1PR11MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a7555a-72f3-494d-e785-08dc89ec11ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CRsqZ7lVLwoGsm/4+7nWukfP7c2FU7o6GnFH9IaDPboS3ldjkd+T4EBeBsdd?=
 =?us-ascii?Q?85BH+eRvYPqAK498qB+7Z8uPlkpvNynsUTbqsO+gbNueshvQbimTCarESmqe?=
 =?us-ascii?Q?MgeRrfcdULIevz8MECjgTUVGXc8z2VvG0KaWL26nOwMKiIIMd+VXDfZIiIim?=
 =?us-ascii?Q?mSYFk6BEos6xtM11Lgtj8Tpk8oFDqg+YgSY/qwSVKB8vlDEXtSwE/MpNOJjR?=
 =?us-ascii?Q?x1IpMzZMkfXZ31/1JS+QiiPyigXvKez9JN068ycnlKUwntEQTWuxd2IXeLBZ?=
 =?us-ascii?Q?PD5bdROWERtrmA+leTAkO6nrvAonoR66D7gggYnR5N2yL/+Kd6m1lwvGmlh0?=
 =?us-ascii?Q?xjFEl+CjV2/+Jx4kEaywNQZ/pOT0sIk1+WCk4IHN5y7ZZaa9i94OfHwfefyG?=
 =?us-ascii?Q?7xCK0bcj6/clYPzVgKd1AiLE5yrFu9AuI31yMaVXpMeRjh69d+Lq1LCQSrPK?=
 =?us-ascii?Q?nD86pV6VzX1JM6V2em/yv6L3ax6ud4W7+zG8XPE1A8e+iFTdLGWGYpAkp4Hq?=
 =?us-ascii?Q?ktz1EWl6SHgFHEDUPiI6RO/xGMa/SgWwffEACRsKEP/lTnqXvrPZxyEbGNzk?=
 =?us-ascii?Q?hjti2c0TI8gz9Kk/oUPe1fnAiIsYUSTnBEkvx9iQyJxSrtp/yBdoCtSUoKU/?=
 =?us-ascii?Q?mQjWTqf1me4cnGZRiUUfV3OaIyz0g/HLUcrtA0epM8ADosYU9/OmH2hEGOc/?=
 =?us-ascii?Q?nDUeYqGEWvdU3LRobdXYEKPSmeI5YqTzYVtN8UIE5tEhwA1s5lEURUGEXilf?=
 =?us-ascii?Q?LMypn8Tjs0+7a8fUBu6JyhuYU6UXJW8GVBep//3aEIUDYcBbb40Zb5Pn8a58?=
 =?us-ascii?Q?z5nYJWs5KZI/Oj6uKHuvpjxMGutHs13rkNRBODssRaI3q0UHoRQGAR+OaibV?=
 =?us-ascii?Q?l+u8rY4O/zVE+C54/DMB9eFHNu7vDjZhY4ItUalo/5OU/YhojqS2/5/6Uemw?=
 =?us-ascii?Q?sg1tDuU0aYtPVud/nZjEhyRqe9muf2QduANh9pELmdiUGxolzmo8OqqRZZUm?=
 =?us-ascii?Q?4zeQ9Q6LkGBN45S23Jzj/m9w9093Qq5NBvsSlKLSDbyzPn+3n1VkxjyG989t?=
 =?us-ascii?Q?rRK339d1C9qQRLiUUaLt9vyD1M3pu5nMuyH3xBNLJOmVmazvgZft9oMIjYdN?=
 =?us-ascii?Q?IejwMH/MKXWC69vXpeU2cu3hiDNKlkwH0wWW2jf7b0/zZE+K5AOxXM7iBR5+?=
 =?us-ascii?Q?e8b+RxEibSeXBfVBqBl8WGCJ6f0LDqoX26Q8r6loLf9/bOFFCFKxhYAAPxnn?=
 =?us-ascii?Q?ZTMQPLG5RYxwDW8JF+2RAwmJWsWdUIMNaiixNp4NLQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F535OEJ6jeDSnuzAn61CVNrRNEXkZoNN44zTAGycVFvA4ileeqqx8N6lPSgM?=
 =?us-ascii?Q?ZtFzbI+a4jU2PWXJGdq0auxI0rZ3n0A/ynCH3kwvZ31zN6D7xG4za5CVXgpc?=
 =?us-ascii?Q?GPVqoKkbRPymsOfH/KSFEPEwR/l6aSdMqoP7w66A0Bt/kbfTsIz+gzUqFI0+?=
 =?us-ascii?Q?vj1zrPWf2Go0m4d2PQu2x5YvhI6FOM+nthhJ7iFAD3hlTifNOn0Rl2vc2epG?=
 =?us-ascii?Q?zoP6ikqLJeetV/B/3/yVIoOc1Gyhs/ECwWHxmGLRDkZiD9daEF9yOrovKBRs?=
 =?us-ascii?Q?Vi9YKkX1JBh4rcGQZINfQ97zJdEOdioK1M5B69ysSYz2mHnMFB6Abyp3oI87?=
 =?us-ascii?Q?1GIi5lotMumreyjXqhcKeCCgcBHQpTckXG/hKMe1bd7Qr/7BNpPyC39beSVO?=
 =?us-ascii?Q?vmrrHSMWwHJ7GfZhE+mNyyOUK8opyq6A0OgazzODUr/am2XJi/cLuJVALF7R?=
 =?us-ascii?Q?0ctwj4IIac5NjvX8YmsSdkYsFMtippM3Yiu1NVeF4BQPFEZnJiwxDl2bkIqz?=
 =?us-ascii?Q?u7TCAj8+EtsAVUWENhxRE4ikE248/4nHuOF5XbdBDYzxNEXw1lNQpjQSjXu5?=
 =?us-ascii?Q?VjHA7eu1abJwJ4rlzqj+g+OyPOTayps+jo5JNL5iDiclzPhHZCeN+z/dQrJ8?=
 =?us-ascii?Q?VofOn7FVaMksM8dQWmWImZhX00v8ZuDujRgBz0517/1/XqjhCuqV0r3lF6FL?=
 =?us-ascii?Q?WCGditgaLerP1qnqqTPxLFt4ucqcmc2O+ixqk5HhxOvCeOTO0ewgj9OPCsEb?=
 =?us-ascii?Q?N/751/sDqk64OzJ0aBMMPN3sDpB5eYGJezxaXPAlt7kIkvSCs5cdCyKKwG9/?=
 =?us-ascii?Q?WBi5SGRTSlf5Vvu564CAMI8nskNVQcIH6knqqXrhqFuVcezGNEdTjEG3E/rD?=
 =?us-ascii?Q?3UZezG4zufQUaNze8/E+4PbPMeYHmKa90x3yLcRSr/bVYH4Z1/TB7LYNeWg1?=
 =?us-ascii?Q?ZzvA5yNPwMBf3D7JyqpaTVWmtKc0lJuX5qrnF/zeatL27Int2X19poWwx1Og?=
 =?us-ascii?Q?MO5soLG+Dt/GtX/iwZntynjh9FV/ivR2egenmrSb/RgfVvLrr3MVLHF8FmVc?=
 =?us-ascii?Q?CqTN/2y1VWu4gFjSzHPwqGUGJQPiKthYUyI8574HjMRQKD3mVFqenmT1XwAu?=
 =?us-ascii?Q?B1AhSor/3iJ5z1McMoECBJ3j6ElBTupFAwUhCZgZKDwbPPcHtzVapJMkcN10?=
 =?us-ascii?Q?0hTKNQnGGF0jRNw4K6WPCAuagwJEuLCLRwmZsLzxiLZ9L6qz2SUx+hg0XuLE?=
 =?us-ascii?Q?isUX4HUxQHiaP5Nozcu2aHlIXrW41qa5xscPFqML9rpXfKB+Q1rNnJHf25fh?=
 =?us-ascii?Q?s0kVEYubhnUCLD8T8doj9zW8/ZO7ov+NJMipTNbsEoAOfM3IVqYus6Zz1gh9?=
 =?us-ascii?Q?nnFZeTKhQ9X+Z8JPopGln6lyl1mdOAWMQshaYECqarligWsF1k2KFY4h0agl?=
 =?us-ascii?Q?UTVXGYUcQlQSSQXELHET3gjX0Btd9SKky9Vc4EEpyio1cUKjnUHyh2pn+ccb?=
 =?us-ascii?Q?+QZMwMScTODi33BlKKYOJ2NlpiWrrDep0JQNzeVriUnzerRPnAzesLlCm+ms?=
 =?us-ascii?Q?68AND7mszjOxu/v/Ej1w2hpTs7Ns9Lq6p5HboVJHvQFN/J2FKc723L+7tZEE?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a7555a-72f3-494d-e785-08dc89ec11ea
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 07:56:58.7342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeGVYwa+PvWSyAnF9zO2KpCT+fPGOJbaiqPa7qaWZttOwEg4LXNR3Jv60b+cDFnBBNf5CPNpJZxTVLB4/BoQFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8054
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:

commit: d362c5c67bb96ccdc4dd34a781d23348d927392d ("[PATCH] watchdog/core: Fix AA deadlock due to watchdog holding cpu_hotplug_lock and wait for wq")
url: https://github.com/intel-lab-lkp/linux/commits/Luo-Gengkun/watchdog-core-Fix-AA-deadlock-due-to-watchdog-holding-cpu_hotplug_lock-and-wait-for-wq/20240606-233305
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20240606153828.3261006-1-luogengkun@huaweicloud.com/
patch subject: [PATCH] watchdog/core: Fix AA deadlock due to watchdog holding cpu_hotplug_lock and wait for wq

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: busted



compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406111537.dd9d27e9-lkp@intel.com


[   87.506482][    T9] WARNING: possible circular locking dependency detected
[   87.506854][    T9] 6.10.0-rc1-00236-gd362c5c67bb9 #1 Not tainted
[   87.507186][    T9] ------------------------------------------------------
[   87.507554][    T9] kworker/0:1/9 is trying to acquire lock:
[ 87.507861][ T9] ffffffff84305f90 (watchdog_mutex){+.+.}-{3:3}, at: lockup_detector_cleanup (kernel/watchdog.c:937) 
[   87.509166][    T9]
[   87.509166][    T9] but task is already holding lock:
[ 87.509550][ T9] ffffc9000009fd58 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: process_scheduled_works (kernel/workqueue.c:3207) 
[   87.510129][    T9]
[   87.510129][    T9] which lock already depends on the new lock.
[   87.510129][    T9]
[   87.510660][    T9]
[   87.510660][    T9] the existing dependency chain (in reverse order) is:
[   87.511125][    T9]
[   87.511125][    T9] -> #2 ((work_completion)(&wfc.work)){+.+.}-{0:0}:
[ 87.511584][ T9] __flush_work (kernel/workqueue.c:3894) 
[ 87.511849][ T9] work_on_cpu_key (kernel/workqueue.c:683 kernel/workqueue.c:6693) 
[ 87.512120][ T9] cpu_down (kernel/cpu.c:1487) 
[ 87.512358][ T9] device_offline (drivers/base/core.c:?) 
[ 87.512631][ T9] remove_cpu (kernel/cpu.c:1522) 
[ 87.512876][ T9] torture_offline (??:?) torture
[ 87.513217][ T9] torture_onoff (??:?) torture
[ 87.513535][ T9] kthread (kernel/kthread.c:391) 
[ 87.513777][ T9] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 87.514035][ T9] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[   87.514311][    T9]
[   87.514311][    T9] -> #1 (cpu_add_remove_lock){+.+.}-{3:3}:
[ 87.514727][ T9] __mutex_lock (kernel/locking/mutex.c:608) 
[ 87.514986][ T9] cpu_hotplug_disable (kernel/cpu.c:555) 
[ 87.515271][ T9] __lockup_detector_reconfigure (kernel/watchdog.c:871) 
[ 87.515599][ T9] lockup_detector_setup (kernel/watchdog.c:912) 
[ 87.515914][ T9] kernel_init_freeable (init/main.c:1570) 
[ 87.516213][ T9] kernel_init (init/main.c:1469) 
[ 87.516467][ T9] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 87.516727][ T9] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[   87.517002][    T9]
[   87.517002][    T9] -> #0 (watchdog_mutex){+.+.}-{3:3}:
[ 87.517415][ T9] __lock_acquire (kernel/locking/lockdep.c:3135) 
[ 87.517695][ T9] lock_acquire (kernel/locking/lockdep.c:5754) 
[ 87.517957][ T9] __mutex_lock (kernel/locking/mutex.c:608) 
[ 87.518215][ T9] lockup_detector_cleanup (kernel/watchdog.c:937) 
[ 87.518518][ T9] _cpu_down (kernel/cpu.c:1450) 
[ 87.518768][ T9] __cpu_down_maps_locked (kernel/cpu.c:1463) 
[ 87.519065][ T9] work_for_cpu_fn (kernel/workqueue.c:6670) 
[ 87.519333][ T9] process_scheduled_works (kernel/workqueue.c:?) 
[ 87.519648][ T9] worker_thread (include/linux/list.h:373 kernel/workqueue.c:946 kernel/workqueue.c:3394) 
[ 87.519915][ T9] kthread (kernel/kthread.c:391) 
[ 87.520157][ T9] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 87.520415][ T9] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[   87.520690][    T9]
[   87.520690][    T9] other info that might help us debug this:
[   87.520690][    T9]
[   87.521221][    T9] Chain exists of:
[   87.521221][    T9]   watchdog_mutex --> cpu_add_remove_lock --> (work_completion)(&wfc.work)
[   87.521221][    T9]
[   87.521963][    T9]  Possible unsafe locking scenario:
[   87.521963][    T9]
[   87.522347][    T9]        CPU0                    CPU1
[   87.522624][    T9]        ----                    ----
[   87.522902][    T9]   lock((work_completion)(&wfc.work));
[   87.523191][    T9]                                lock(cpu_add_remove_lock);
[   87.523569][    T9]                                lock((work_completion)(&wfc.work));
[   87.523984][    T9]   lock(watchdog_mutex);
[   87.524212][    T9]
[   87.524212][    T9]  *** DEADLOCK ***
[   87.524212][    T9]
[   87.524628][    T9] 2 locks held by kworker/0:1/9:
[ 87.524885][ T9] #0: ffff88810007cd58 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works (kernel/workqueue.c:3206) 
[ 87.525461][ T9] #1: ffffc9000009fd58 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: process_scheduled_works (kernel/workqueue.c:3207) 
[   87.526065][    T9]
[   87.526065][    T9] stack backtrace:
[   87.526372][    T9] CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.10.0-rc1-00236-gd362c5c67bb9 #1
[   87.526839][    T9] Workqueue: events work_for_cpu_fn
[   87.527114][    T9] Call Trace:
[   87.527292][    T9]  <TASK>
[ 87.527451][ T9] dump_stack_lvl (lib/dump_stack.c:119) 
[ 87.527691][ T9] check_noncircular (kernel/locking/lockdep.c:?) 
[ 87.527955][ T9] __lock_acquire (kernel/locking/lockdep.c:3135) 
[ 87.528218][ T9] ? lock_release (arch/x86/include/asm/bitops.h:227 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:228 kernel/locking/lockdep.c:352 kernel/locking/lockdep.c:5436 kernel/locking/lockdep.c:5774) 
[ 87.528466][ T9] lock_acquire (kernel/locking/lockdep.c:5754) 
[ 87.528703][ T9] ? lockup_detector_cleanup (kernel/watchdog.c:937) 
[ 87.528991][ T9] ? lockup_detector_cleanup (kernel/watchdog.c:937) 
[ 87.529293][ T9] __mutex_lock (kernel/locking/mutex.c:608) 
[ 87.529530][ T9] ? lockup_detector_cleanup (kernel/watchdog.c:937) 
[ 87.529817][ T9] ? mark_lock (arch/x86/include/asm/bitops.h:227 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:228 kernel/locking/lockdep.c:4656) 
[ 87.530047][ T9] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:?) 
[ 87.530361][ T9] ? _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 87.530635][ T9] lockup_detector_cleanup (kernel/watchdog.c:937) 
[ 87.530911][ T9] _cpu_down (kernel/cpu.c:1450) 
[ 87.531139][ T9] ? process_scheduled_works (kernel/workqueue.c:3207) 
[ 87.531440][ T9] __cpu_down_maps_locked (kernel/cpu.c:1463) 
[ 87.531716][ T9] ? __pfx___cpu_down_maps_locked (kernel/cpu.c:1460) 
[ 87.532039][ T9] work_for_cpu_fn (kernel/workqueue.c:6670) 
[ 87.532285][ T9] process_scheduled_works (kernel/workqueue.c:?) 
[ 87.532594][ T9] worker_thread (include/linux/list.h:373 kernel/workqueue.c:946 kernel/workqueue.c:3394) 
[ 87.532839][ T9] ? lock_release (arch/x86/include/asm/bitops.h:227 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:228 kernel/locking/lockdep.c:352 kernel/locking/lockdep.c:5436 kernel/locking/lockdep.c:5774) 
[ 87.533103][ T9] ? __kthread_parkme (kernel/kthread.c:?) 
[ 87.533365][ T9] ? __kthread_parkme (include/linux/instrumented.h:? include/asm-generic/bitops/instrumented-non-atomic.h:141 kernel/kthread.c:280) 
[ 87.533629][ T9] kthread (kernel/kthread.c:391) 
[ 87.533846][ T9] ? __pfx_worker_thread (kernel/workqueue.c:3339) 
[ 87.534117][ T9] ? __pfx_kthread (kernel/kthread.c:342) 
[ 87.534361][ T9] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 87.534597][ T9] ? __pfx_kthread (kernel/kthread.c:342) 
[ 87.534841][ T9] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[   87.535111][    T9]  </TASK>



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240611/202406111537.dd9d27e9-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


