Return-Path: <bpf+bounces-45647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8428B9D9E4C
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 21:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205A61663CB
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 20:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A981DF247;
	Tue, 26 Nov 2024 20:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yx3DA77k"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB941AAD7;
	Tue, 26 Nov 2024 20:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732652061; cv=fail; b=CjQlwqJH/+bF4rgwlb8PkvUOj8O2+iON9Sfrrcpkh9Vc5onGtbgj+zPtIlfJOUrUaUWioYtPwyU0h+D2WtF8P22UGjeY7xAy3hj9Ww0Xp+D4IQgQJht1o8JGb5VgG53Q37uWNAE5iAMCUKKQZJaNVxdxn//ZptJeGHQBoqsRfk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732652061; c=relaxed/simple;
	bh=MuKlvPW4YmlAhOS1HdUOGCUgxXig/11B79xWkgoqtbM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=bssQWgXrx9PC8uIXQ6EzuL54Niag0Z5U8duqbFORWeyzl4zXHsGfCtsPsurIXUg69cDRaCUlYrLB7E+vfqgNiBa+30BvDtAW03wiQFTfKX6tbbkCOsAvrG/llQm19tQeLeQv+iA4bPiII7hgO4bhzcXXmo0HlstvmUGqL4eQoKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yx3DA77k; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732652060; x=1764188060;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MuKlvPW4YmlAhOS1HdUOGCUgxXig/11B79xWkgoqtbM=;
  b=Yx3DA77kNAu8uh9Z7cUgLhd4wTc4RPk/yXHF4q1NHqQeSTBZ1Q/eAxP+
   iX3rAQ4Gwjc7RoBEDFZ1a9WSkrvSs9g9K1+pFdHEXFU5uj5NCsuwZWwLh
   NVG0kZTE89piMfYkAQA5g5wJ/zbaYu0DFc/SN/F2mbyO+fFjjlPG9rAnh
   oI8gmsESLBtk7mRtxcr7uyAebj3T6YkvTLkwM1UP10I5hDon+jAvJBPSw
   aYfRKvTJl1Z/FGmB7Oi6ggkxJFEVrSsin436AGkJ4n+LfRJRdZ1If/Z/1
   mRzm07ozMrIVNjf7iLbwdVMxpkWlMnel+v+hTfYfFNKwFLXYy5gVBClI4
   Q==;
X-CSE-ConnectionGUID: Rq8ZORFqRh+Zp85O+u2vFQ==
X-CSE-MsgGUID: 9XMsct49RaOeaZ59lhGziA==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="32968845"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="32968845"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 12:14:19 -0800
X-CSE-ConnectionGUID: 3IrdW1IdQ/S94AlTM5uv8A==
X-CSE-MsgGUID: w3NEie+vQy+ZBGMF8PXkXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="92181701"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Nov 2024 12:14:18 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 26 Nov 2024 12:14:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 26 Nov 2024 12:14:18 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 26 Nov 2024 12:13:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrENEYQa9/eL0942b/tzY4w47Si5CpOls6owJvksLG7V+pMOP0Wvwu6h1tasvFuiAh4/17glLi517eZZr7uhzo1MzgWbqXGx2ofOcv4IvNWpLmqnxTEPpd4cE1tTIfpOl1bdIzGAJlEWT2ofkSISWMRDr0lkK9DKpyET0Km64xNDR0R6wumstKEAGSiE1rYkBMkpAYll0Pse4ZV8ZwA0CX+EAlktjzqR6M1GdE5eWuR+2/cey5P42i4VZ1pZlA9vdJpd8XBqEz1Ca3SjrcPcA0x+DJ987Awv67kIswHP9R5RohFZU4mYGJFrJmCD+sIUcuZFOWu5UL8uPT/bA7yD6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epTLbuB9BLQ4N7kdzeTNIidD7l4SQ0/aVpS5MEGQd38=;
 b=ZX2JtMT4aPNIDB1KI8VVMMOqWYpdalBBWWVZgD2sPV92g7HnATFQQJUQH91WyvgP7suHGtDZe0bhqFNRTAzrKBuiqyYLKR6PmVOP8FyUZsVmo6guqNjtnY/JVRwGgZs9zqfucd06qqISegkDQYY1E6wn8EFTQZEVnqKX/2QSHZQNolposNLSnUJ5XwQ+HxJMuJsRgOXMYeXl53EDMt14dv33dWNPxX20f655bcHVVEn2k5Le2Gzm309+ELEIqBC7CtnlHABJ4sPGfgDl8KA+/APuDkMvNw04HjJk25trK3VAJqOpaIFUWjT/E3zjvwkc/xXMEigT/IML6P7/Y/9fGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7446.namprd11.prod.outlook.com (2603:10b6:510:26d::5)
 by SJ0PR11MB4960.namprd11.prod.outlook.com (2603:10b6:a03:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Tue, 26 Nov
 2024 20:13:51 +0000
Received: from PH0PR11MB7446.namprd11.prod.outlook.com
 ([fe80::ee69:297e:231d:4d3a]) by PH0PR11MB7446.namprd11.prod.outlook.com
 ([fe80::ee69:297e:231d:4d3a%7]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 20:13:51 +0000
Date: Tue, 26 Nov 2024 14:08:45 -0600
From: Ben Olson <matthew.olson@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
	<bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] libbpf: Improve debug message when the base BTF cannot be
 found
Message-ID: <Z0YqzQ5lNz7obQG7@bolson-desk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SA1PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::27) To PH0PR11MB7446.namprd11.prod.outlook.com
 (2603:10b6:510:26d::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7446:EE_|SJ0PR11MB4960:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b79173-a2e5-4398-8bde-08dd0e56d7d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0kAt/VpWpjsnjetcgRixOQrfm9MfQuWH8Hsax0psZJAZWSWbOkE4Kz6jj1W+?=
 =?us-ascii?Q?C77pCkHZptL3yL+XGz/kN8QVF61iakhKp82cNpGU68inIsbzc27jn9oLqpn+?=
 =?us-ascii?Q?EtDo7MjrQEfYwsp8FXGx7L5IFLlUPbOk4CYjp5+iI3hTXzAqoOmXGSa/rqNc?=
 =?us-ascii?Q?zcl3fq3wjY287+rt5AiXymVHHVpde0Fpo6zRrmIJfd4BgYgUwFBT82AhH+9j?=
 =?us-ascii?Q?o7kXRi4wGyAc+TD8sJRK1fUKS8lAVXc7qIUOEXtFYRwQgxXMX2xlV+s6CuAy?=
 =?us-ascii?Q?welAihAvEsk+XaNMtkeEg7gaCKFIdki6jOydV5h++NPxds+L2tBGks09rCkR?=
 =?us-ascii?Q?W9qWYnNQyfhKuyU4eOS0S7QXB9m4BKZ0QDCez3jMUU3f0Eh+h/eb6bxWHESE?=
 =?us-ascii?Q?fx4Jx3tC4S3b/SDbDyq/ZSGrixdtBoh5sMGw7J2AILeNwBuARF8oGy4BJEC5?=
 =?us-ascii?Q?ur85SQEADReaa3gUwVKUhNSLM2/4Z3dC+kLkfr2ie1nMrJsZ99x2sdM8Qg4+?=
 =?us-ascii?Q?KFFE4pziIkYXvr4fkvocSOcNbmCZdprqGEtVnAZWVDdFtKqa3o+AhPaRoq6k?=
 =?us-ascii?Q?x1CogdG12/YAyUVTSedjfRUG3sG1t4Z/ADmB6qFBud5CiWYxYHcrMu3+O581?=
 =?us-ascii?Q?RfS0ATVE9a+g5pTtsA1AuOTwD3VQEYrVV+EP6ZnCOLpXHW6vh0e/ZSkjeZfX?=
 =?us-ascii?Q?DYUwpRiyTokkphopRBuuUG1uckuzmqKYnp3pmG8K0BqPbpldz3mvQvMVy23g?=
 =?us-ascii?Q?p5r/PHhdP7q40GXkLUQJ98dOULlula/xqyp0e46pNAXPvwgx5/jm/L+STi53?=
 =?us-ascii?Q?6DbhcPZ7ocwH3XfxynOZMWRbwWiUz8bkoac4Lvzw72z3jEeBSpqOy7dsEQGu?=
 =?us-ascii?Q?nZ8WXyydwDaWZJjA+twXsOGq5v1iVz/axN33PnYLIFHFj9da0izGE2H7p4cQ?=
 =?us-ascii?Q?PDd1Jy4XOW58XKFesVgkAcquplpxdrXLNFxCJDnVGDIDKR6FvesJA1G0zJbn?=
 =?us-ascii?Q?hvr/WWKUKtMAPiwnoG8z3MstwIFHzecLVtkP0V2WzyS4FT6RucBEIIClsLrC?=
 =?us-ascii?Q?p8r7skOg9pfL8h3dfHqn+MnAc99WZzxOfBkP8EbvGuaug7VSpGyuv07BfnsQ?=
 =?us-ascii?Q?3a5XSaVaF3/bDrjBV2vBi/48Wlaaw++m1CZsd+RmjG+L/X5Rp6s9/wgmTX8E?=
 =?us-ascii?Q?3XI+ywy3KyXfkfvdDLOsvrpVG7GODntIfIt3CAQvOKK23iEygp1p7xAVgVdI?=
 =?us-ascii?Q?JX/1fTL0zNb02bQ37nvw/yLNy3rLV45/U7SBLkeR9e6YfAJnJmbOfzBlQ6RQ?=
 =?us-ascii?Q?IlCZWKirsCCL2uYD2DZFqnbyp5JPM6YLp5fVjiCI0MSU+g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7446.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xILTd6j3jvUjYSZjZwO6Rz2MBPUgSUZmGtaoFhShiZ8Txgpfy3G75EznxLbx?=
 =?us-ascii?Q?4HAZKIV8ii4RgyooHuBaeHsIcYoXGaWTUp4e72ReGpR/rDq+gP2kYytg0I9w?=
 =?us-ascii?Q?VcA3Z/qFGVqLBPeHf7ytaD75JMdRHiScvXruIM1qCKfDuufb9BFHwNMgGdOb?=
 =?us-ascii?Q?ZP+mSeE5OZbUdLHRkadKJMtpMBBxlo/e/0M5zII88DDX8scMb1n8NTt+TBYC?=
 =?us-ascii?Q?c5DsuWsnLo6c92lWdTVY+l91F6VJkVDErpZZY2pMxElnHAYQv3CighYkE9ve?=
 =?us-ascii?Q?b86S/fvxa/B0q8I1V3bDZj6Kw60yutyLV6Lot7nAjXwQ7S4gNxDeTF4JCr8L?=
 =?us-ascii?Q?+NeWbnsNvDnVP9tOT2ig5w10t/VQ43X5xd8DN6CjtXckU8V9cRGbfUu9YPGb?=
 =?us-ascii?Q?A6abQIm72g8NB27I7L6eUMgEiRyL0nwiFf4I5Dgj+hef8mdqSfMPPf/RxylV?=
 =?us-ascii?Q?pesvNNEzJNnQP3fsTE5v16Gl2D1jXuflgW7t5DiUvFnuujtkS8zcEJ0hDQvp?=
 =?us-ascii?Q?3mLroO57NeOUlzJkKYUz66HLXbsarSNhYPyY2KQhkgJEKpHZIY3PKts4il7N?=
 =?us-ascii?Q?tfQZglBIsoBUD5I6Z14tvIdl1oKTlPMbTqMrLrsC5eOTmDGGIsMNnR1Z2+2d?=
 =?us-ascii?Q?hM+2ssm7awi2OMwRUmaGBpEHw8u43qglKB7CAdGbJnE+FinNprEO3/ZRWCDV?=
 =?us-ascii?Q?x3FV1WQYbD0z8PzasSMndUGoiadaInD5ELnnaDqbhwTycrXPcMTP5po3Yxo+?=
 =?us-ascii?Q?/D8FKTU+Q5JoYMg8Kw38SA7UhD7/AAQIdkfWO1dR/wG3WEPibQOmGlngCUbT?=
 =?us-ascii?Q?aERKgGLjrd0LkKQlYch2oLEa/0XTwD57KLWAOpALwxUji6o2NYn9O7BdGc+l?=
 =?us-ascii?Q?bQxpA2uUsA28mmNYZDbh6/afNTy0EkuxWtt5Lhn01+O8A7sgqvbfyvFflne1?=
 =?us-ascii?Q?HjnH8621ZUL2JvDl1kYIjFD+xDJZ/oqPI1Jt17ufFSlky3nTIxF8vCik4Mz1?=
 =?us-ascii?Q?dhsfWxtFzg/q2mU1F74OdZsxYjQrauuFz25C9gUiE/rSYdazNcnp01tfoiti?=
 =?us-ascii?Q?Fcn69YoHaCbJyi8UtFIYOz7Q0x55jdsBZx60ytUYC2RehItEQwSzhXO85BON?=
 =?us-ascii?Q?ntlTRqf0eRiWfprx6zH++eKtvA1Uk+DUx+hK4txbtVV6GEdKtRU3GM4rx/xz?=
 =?us-ascii?Q?piOnhjspo6kBs4kY1l8oLjX81Djk4Wp2Heqy63e8Cl+EEKRLNZqTOtWAjRrU?=
 =?us-ascii?Q?QhvQTk76ia537x3UgM32jaDSZdPtjR0dFKH8bvYYSg2dwriQhQxHIuSKRcEx?=
 =?us-ascii?Q?qa876hu2vBu0V6ziBgeK4cmvpRLEvwHG/YfVlENiBwg9zIpYZN8XknYzF527?=
 =?us-ascii?Q?s8fKhA1jHwdtZQLLP4nsvsdu4uj7qnf+mEj1RL7RoXoH31TMULxtubr1oPvg?=
 =?us-ascii?Q?Er0hVQz+ugu9uGkxeOgRnO4bL958i39GrHR8+RWyzGx39ri8pSvBq77R0CLW?=
 =?us-ascii?Q?BQBseswux00nRhfr5LGY/3yVqxYRt6rvQhvX42qB+MZLdxaoQUQcjqTtzCr1?=
 =?us-ascii?Q?ahzYlrSU9meg6kjcgcQeypPGUvsrEVYeQDa4xFXZDsk0s/4Y4UEd/sD5keaE?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b79173-a2e5-4398-8bde-08dd0e56d7d5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7446.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 20:13:51.0393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YiR0XnWoXt0lDjdDkyre6WUDouSc66wOn+YkN+JgWbGserC/cvV8Mr1mkMN1wTszfaQ6rXs235AdPHo7kibAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4960
X-OriginatorOrg: intel.com

When running `bpftool` on a kernel module installed in `/lib/modules...`,
this error is encountered if the user does not specify `--base-btf` to
point to a valid base BTF (e.g. usually in `/sys/kernel/btf/vmlinux`).
However, looking at the debug output to determine the cause of the error
simply says `Invalid BTF string section`, which does not point to the
actual source of the error. This just improves that debug message to tell
users what happened.

Signed-off-by: Ben Olson <matthew.olson@intel.com>
---
 tools/lib/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 12468ae0d573..a4ae2df68b91 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -283,7 +283,7 @@ static int btf_parse_str_sec(struct btf *btf)
 		return -EINVAL;
 	}
 	if (!btf->base_btf && start[0]) {
-		pr_debug("Invalid BTF string section\n");
+		pr_debug("Malformed BTF string section, did you forget to provide base BTF?\n");
 		return -EINVAL;
 	}
 	return 0;
-- 
2.47.0

