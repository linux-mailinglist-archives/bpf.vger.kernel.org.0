Return-Path: <bpf+bounces-44019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BF39BC6B2
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 08:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0732860E7
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 07:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD661D5CE7;
	Tue,  5 Nov 2024 07:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBjturYi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5061B5EA4;
	Tue,  5 Nov 2024 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730790880; cv=fail; b=LOvzzO82S419KtrABzJPGQr2ZePwpHgntI586wO3k9J5SwFu6XHQA6qn0RT666SMZPQ/vsk3sl22TbjzdOHmY+7Y6gPqxhIXQk/btzcCgFnf6E4zw3gcS06Y5gIO/nBkcTYzT1EcUhT2cCEMb0PQG4Y203IvpV74Cdlb8KHg020=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730790880; c=relaxed/simple;
	bh=R1nSJ1QXhYfwYEMw/KqIkz1skm0+EBQxCBN5kOpzINA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=BL1JQFvM+57zfTF5AFq5BboIeMndM7sY4MaL+bxkAVrCmknmzmG0N/bpyOYEJ7qbFxoGgFV7yrbPpiIzlwEJbAcUDbZ4s8YHrx+Y5NShU2n0zgUR0EHWXrFmIzAbFVDZNd9AcRsklKNQuZfmhFTCnxFUhcXbarXpapVMCTv7y4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBjturYi; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730790878; x=1762326878;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R1nSJ1QXhYfwYEMw/KqIkz1skm0+EBQxCBN5kOpzINA=;
  b=kBjturYiwT/dGwV90eiJhEJhqxLEFUlpY7MusBWuEh1TS32RHuZkK9az
   Ar0bOZmf1BLWI6qjU2NWkOMomEBSrqey4KpokJwAF/XEhLp6A9Jhgco/c
   k+d1yz+m+DIjTYSJp7TUh5r5+6les5skjv+4Jc5jxBfL+58hZ9Js3WcZp
   s8BJjKr7pdpM1XLUuwPwgTpOQx8X0jWWXWe+L82tId4G/M8/Wt+V1ozbq
   oKvWbibyLSfdTBN0ct5s21IPR30npePajcKnQ1o4zbK5UEi00/LndcJoR
   Qhkzrtx9GqHvbupGHKQqFnPxPvWQIqAg8I47a+L8W86YoJwln64fQwFbG
   Q==;
X-CSE-ConnectionGUID: aDfs5mqFQOKbH5hV61v+Aw==
X-CSE-MsgGUID: soRdwGkkTW6ANuch3PwQxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="41890700"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="41890700"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 23:14:37 -0800
X-CSE-ConnectionGUID: yXfloiSqT9KdHYI7D6sSoA==
X-CSE-MsgGUID: JPrfxD8vS1eOCx8r+GqEhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="107234000"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 23:14:37 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 23:14:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 23:14:36 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 23:14:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkjbbO1keGjCJP1NHdyzTd9xUluGtselJGKByIsh2evzB28pnkDvPtbRfLlS0aKg7SgZu8QTySm3/QyQIY740HM4tPNWJq9yqeWAFBhSjD5wybGjX/OHuEjFHd4scttzFtGg/WmVnbI9FR10kwEpRmic6G9pNDaBQcH/CBX1xr7o9fHG6MmYnC1F3Azv7soydlhF/e/S4qjbqsOLJaRNQVTYEfjPTa4fyLMQ5hRG/x21LRb45mIX/vCsjBJ2ckAQRE1jOewrOLDXeczATcO9sphY50BZK37PFny752uWsiJfP4qU+SAK9/9Lnyd9fzMMlkRL9ujYM5qt4XOh936aKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npIYaTA2hsIeVYSSgBOZSZlWccGBzGybQvL2fA5onMY=;
 b=CmvTaxDu5zRslpjZoz9IlDvyf7tDp4uN96pKM3tfcPKoiflFHX6jWu9yov1tSftHxwMvQ4z5VUQk9IqqACaL0xt0bUfutZ/JfWqgz0GBSh7rdUHC6Z0AMu9MMtYXEL0a/N1AWFQvmiSv/UdyRhY/CLdjy9m8Iwttr7ZzNaaOQ3DMZiaYMCPCqqOzrz0LbIDhO99W4ay2NasEdVav0XaqurWA2AhvcRzblY4NeliH/qpeoVOzo2F8dsgYNyRR4A+zec86uQF8tkUpHsaBV5OcnLQ8M50A4hFu62SvlSCi/u8lJiWW5XF6W0dU5OuMXxwqR7n2XzhxJUCKypOSEYyAkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB4847.namprd11.prod.outlook.com (2603:10b6:a03:2d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 07:14:32 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 07:14:32 +0000
Date: Tue, 5 Nov 2024 15:14:24 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [peterz-queue:x86/ibt] [x86/ibt]  f8c0cdd341:
 kernel_BUG_at_arch/x86/kernel/alternative.c
Message-ID: <202411051556.6b0c4fb4-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR03CA0093.apcprd03.prod.outlook.com
 (2603:1096:4:7c::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB4847:EE_
X-MS-Office365-Filtering-Correlation-Id: 7266ec96-f19f-4d89-fcc9-08dcfd697ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C+D2EmK9abzIEOn2LqYl6czKCfi4Zjn6Hzen4fYhbfci2jFeMCOIEtd+VABn?=
 =?us-ascii?Q?Qaxd5CBu5Vyn85Lliz4LXDn9BSMSlo6sRYl1UoHjs0Js29YDzf5qo5hdSjMM?=
 =?us-ascii?Q?nmOSA1bHjRoa3cCrX8wr5BuO4R552gUb7q+s1DdCjPJYEgHFHQ6yRDDgzUaM?=
 =?us-ascii?Q?uT7RQv7q3/vHcaMoKrNgvw4AmnqM1PF1OoPWxVHRNJ2fv5rbbGOZGL46legh?=
 =?us-ascii?Q?xUcNTi2bfD8SxXds2XicSjExOsH7LL+vBptYAollHBFVUpuZajlOhFljroWv?=
 =?us-ascii?Q?OnyNpzREa596OIcRXx5ExnXkuRBLrjtOIfEci/1LajY86e3rxegcHuVBV8/7?=
 =?us-ascii?Q?wyXPsDc83iJ5puT5r2EfO9wW+FKJprk/Nse2aACUJKwvS8STuH8n8et7wqrd?=
 =?us-ascii?Q?rMVF11Lg89T/ntyXJjcUVvxtlhui23rgxRK6AR0J8HkahvwqnHIRGX2rA1l8?=
 =?us-ascii?Q?qClH7AGJmnpLJCI7EZTGIahfrTeA3pfwW7TR0Mgdhv8NS0DFLipJheJwa1WZ?=
 =?us-ascii?Q?Zz5d62FCkDGGtetL7VcbKvTVSe0XH8wBHc6bG4JFE3L5zt6ZHOGWIcSJCTkQ?=
 =?us-ascii?Q?AxOHRjP1RHYCrDNtzjTUf1nOj0oW6Nv4vkaZwj1yTQH7SLndWANND9mpcJ2V?=
 =?us-ascii?Q?8nPzTqZD6Q9mKdtRnzsbxXdExsd81PRNQXo6c58GMxGY4xqyome3N1CfEy0O?=
 =?us-ascii?Q?Fqglovdw8W3ShSu8CHuj7cUBRQwxj2i2LbfHRQqJ9odHv4TxObZ1KTyfVNl2?=
 =?us-ascii?Q?ngdctdRTD798YovTxUqqrhk2UwaE+GSkMSseGpHYcsKm0jHTwMAjpPoThT+E?=
 =?us-ascii?Q?tBHOGyfezaTradz5I3PSIpS4SQqn/mY+s7O8XfAT8M7ySW2avcW8QrVQZ9jB?=
 =?us-ascii?Q?Lh8i2hX3LF0+nNhLrYESkV9pzKb8jiJAcfiRcOFSa3/Aw4xAndbl0M8HH7EU?=
 =?us-ascii?Q?soaz1Adi75pcpzbg2BWpxbdF4iI3NqyDleFwf8o6T2lN+J+hI1Y0Kyo9Nwnr?=
 =?us-ascii?Q?zo/HypfQ1/vkF2QRi357UIOYd5fwA7afj87Zo4KmqoVF8JRBeRyfsTA2a7pN?=
 =?us-ascii?Q?17XENlGRIaOapMm8Q5n9R8armjfhwNbIRUFTG82awBNFzlZuNy/VtbWjkAc2?=
 =?us-ascii?Q?YsLcjbqyZWm0FpP0WSutNc+duAcHhA8xHejPmHtLK0+8Ydh190W5rRleyD/+?=
 =?us-ascii?Q?Dt4FR6G02l7FYdoUv+mu6OMj6MyQAxPKaGCpfz4djS7omRqHbwfmD9l78J2q?=
 =?us-ascii?Q?97EPh+TX5OAbeUDdX6e8r8gL9+j0iOdZtFydvYH1LQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vxWZrsyHFAXKH5SuioTbpH+C8ykZYkyVIofqyNQKhxtPb17sGpH/3tD/tuA1?=
 =?us-ascii?Q?fq624FafgXVFhNLbei+xiKvKfHJkHa9l53wz4Gm6DFfb5abv7BU7sFlI/19+?=
 =?us-ascii?Q?gsQUdrmgM83lgjkYj5ktn5fzr2Xm2qwfcER7mssfuMxwvhFIOiU1eeYbXWTp?=
 =?us-ascii?Q?n5N3E10ryNFzkVw5RENv54Jcq4PuX1Fg1Kcw1LqCVJI627J3r8EUUZZjJck+?=
 =?us-ascii?Q?1pFFRxGxAp9USgVDBQmnMpjgIuxwvJH4WlkedCCVCmWv/MCvMS/XUhnvgjvv?=
 =?us-ascii?Q?+aLYAEs5WhpabykUNhcNm9myRuMwlrA9yj2YcDcQRGu5xyUBaUtmlNmKPN3K?=
 =?us-ascii?Q?an6qQ4UAiXBwUt3OdOlnHdSlm9cePAQ/YELEod7bE823wZ2e5EKMdPwn7xLV?=
 =?us-ascii?Q?WjepHKtlaVtblL0pP5NDmj+OJw797dZ5VxCNjiztb7OzROM5nK9wSHXjraQm?=
 =?us-ascii?Q?nTviJrX1k1H5eqJQADBvb2ad+Uoc/oF4Gpwksimg+l3fHHDxj5YvXe1kR5Fw?=
 =?us-ascii?Q?/g0iOgHEm2E63X823gRDUU3O6ggm+IPsXX/lTG2HHkRRbJagnDe9AJ/YEuVE?=
 =?us-ascii?Q?3JOMHrY0BIW0Vk8kW4BsSB5H5FC3AYMtZr/k+5oC2cpVUKPWQSVlnUBzkbX9?=
 =?us-ascii?Q?QfTQRlsJEj4upY97SMJiX5wq1tNWA1qPrujg71+sX/uygrWDvrxEH9SaXJJe?=
 =?us-ascii?Q?Qu4xa+qEu5fKfgi/XDYYLi9xxuObI3y9X+3EUsEsQX3hjc728995pNj20Gax?=
 =?us-ascii?Q?+UYakGIjeFEHTnKVbymV8I6IN2kKXtCYZXjYErv7rt5HOGKuC1Lgh+xlTZ/Z?=
 =?us-ascii?Q?VF3GRErrUPPuJT0ULEiNlUpQloKxl0TL/I945T0dHDcszB6lnPrOKgdSenBZ?=
 =?us-ascii?Q?d8nXwh1qEAL3ceFaJrCQW8FHLBqtc/8LV8SJr7qQPbi1bJyaXblNI30pSc1A?=
 =?us-ascii?Q?31TUugIO/aPr0VnRFN3ThVGiXyS0rHafSZ2e85mPh/nECTF1cnUhC1JGNZev?=
 =?us-ascii?Q?EEaRExwaNWy2oOO28i09gLTtaz5Q03PFX45BG06aFXWioLQNmm+vriLRT+t2?=
 =?us-ascii?Q?fIY7Dx3QcbcBEuKIiJP2YUmOJ2P0RtreOWa+Q0zvhBXSe+4YB+xqH9fo3ILA?=
 =?us-ascii?Q?vBTARrnCgxXklC42FiDjmwEhTDiYmUGxAszWeBKwvG0YTM/TQ4Y1Y4yEnEjc?=
 =?us-ascii?Q?+EaPnhe5cKpf0eluLGPK1Rl43E37Ret8+98e5xaO66QZn/a4FH87TsUF7OjQ?=
 =?us-ascii?Q?BEhgtV0xv/B+h2LdDtea5jyl14V2KdQpETXPTUmHwr/3o2L+XnVn12U5x0er?=
 =?us-ascii?Q?xYtArfI5dlXJ49hiRBUpy5qwL+/W5WoT72J5ikg/Hj307/OjsYcnJKJXyXXh?=
 =?us-ascii?Q?bp64qxXmawxVsRKUdpXu/xNrZg1wxZThwXuVrvBe/E4AzwpY7oSpRVtd0Fq8?=
 =?us-ascii?Q?AVD08FP5zQgFJFOZmmIbuV3FONtsXQCQrf+N4jdvE/jedZpuzrBZUTtwDF8m?=
 =?us-ascii?Q?3ktT2w78J0ooJivDcBg5OeYjxf3KJ3dE1eb+OvidDdKBJkJbx3ZYeczxpW4C?=
 =?us-ascii?Q?9mEKOq5dppX2SkVAz8Sg4G/IeHcUbTM5ykZwu2FtufX8sHB1lcO6rzsO5vQX?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7266ec96-f19f-4d89-fcc9-08dcfd697ef6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 07:14:32.6466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZbS0h+EcAS+Il9/HERcYtK+ykdqa8eCwGS/Muftz7pz+kyhsvr3W1k1E9MtpiVq8fQ79KD0pL5v1aKNG3D6Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4847
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_arch/x86/kernel/alternative.c" on:

commit: f8c0cdd341a8c29884b35532fd9638a2b320b286 ("x86/ibt: Implement IBT+")
https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git x86/ibt

in testcase: boot

config: x86_64-kexec
compiler: clang-19
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+------------+------------+
|                                             | 2596165180 | f8c0cdd341 |
+---------------------------------------------+------------+------------+
| boot_successes                              | 18         | 0          |
| boot_failures                               | 0          | 18         |
| kernel_BUG_at_arch/x86/kernel/alternative.c | 0          | 18         |
| Oops:invalid_opcode:#[##]PREEMPT_SMP_PTI    | 0          | 18         |
| RIP:apply_direct_call_offset                | 0          | 18         |
| Kernel_panic-not_syncing:Fatal_exception    | 0          | 18         |
+---------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202411051556.6b0c4fb4-lkp@intel.com


[   12.715992][    T0] ------------[ cut here ]------------
[   12.716998][    T0] kernel BUG at arch/x86/kernel/alternative.c:302!
[   12.718103][    T0] Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
[   12.718706][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc6-00010-gf8c0cdd341a8 #1
[   12.718706][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 12.718706][ T0] RIP: 0010:apply_direct_call_offset (arch/x86/kernel/alternative.c:302) 
[ 12.718706][ T0] Code: 04 eb db 83 f8 0f 75 0f 80 7c 24 19 8f 7f 1d 43 83 44 2e 02 04 eb c7 3d eb 00 00 00 74 a3 eb 0c 0f 0b eb ba f3 0f 1e fa eb b4 <0f> 0b 0f b6 54 24 52 48 c7 c7 e4 81 89 82 4c 89 e6 4c 89 e1 e8 02
All code
========
   0:	04 eb                	add    $0xeb,%al
   2:	db 83 f8 0f 75 0f    	fildl  0xf750ff8(%rbx)
   8:	80 7c 24 19 8f       	cmpb   $0x8f,0x19(%rsp)
   d:	7f 1d                	jg     0x2c
   f:	43 83 44 2e 02 04    	addl   $0x4,0x2(%r14,%r13,1)
  15:	eb c7                	jmp    0xffffffffffffffde
  17:	3d eb 00 00 00       	cmp    $0xeb,%eax
  1c:	74 a3                	je     0xffffffffffffffc1
  1e:	eb 0c                	jmp    0x2c
  20:	0f 0b                	ud2
  22:	eb ba                	jmp    0xffffffffffffffde
  24:	f3 0f 1e fa          	endbr64
  28:	eb b4                	jmp    0xffffffffffffffde
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	0f b6 54 24 52       	movzbl 0x52(%rsp),%edx
  31:	48 c7 c7 e4 81 89 82 	mov    $0xffffffff828981e4,%rdi
  38:	4c 89 e6             	mov    %r12,%rsi
  3b:	4c 89 e1             	mov    %r12,%rcx
  3e:	e8                   	.byte 0xe8
  3f:	02                   	.byte 0x2

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	0f b6 54 24 52       	movzbl 0x52(%rsp),%edx
   7:	48 c7 c7 e4 81 89 82 	mov    $0xffffffff828981e4,%rdi
   e:	4c 89 e6             	mov    %r12,%rsi
  11:	4c 89 e1             	mov    %r12,%rcx
  14:	e8                   	.byte 0xe8
  15:	02                   	.byte 0x2
[   12.718706][    T0] RSP: 0000:ffffffff82a03e58 EFLAGS: 00010297
[   12.718706][    T0] RAX: 0000000000000082 RBX: ffffffff83803b9c RCX: 0000000000000000
[   12.718706][    T0] RDX: 0000000000000001 RSI: ffffffff81b4faeb RDI: 00000000000000eb
[   12.718706][    T0] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff82a03e58
[   12.718706][    T0] R10: 000000000000000f R11: 0000000000000040 R12: ffffffff81b4fa30
[   12.718706][    T0] R13: fffffffffe353c90 R14: ffffffff837fbda0 R15: ffffffff82a03e58
[   12.718706][    T0] FS:  0000000000000000(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
[   12.718706][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.718706][    T0] CR2: ffff88843ffff000 CR3: 0000000002a32000 CR4: 00000000000406f0
[   12.718706][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   12.718706][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   12.718706][    T0] Call Trace:
[   12.718706][    T0]  <TASK>
[ 12.718706][ T0] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 12.718706][ T0] ? die (arch/x86/kernel/dumpstack.c:? arch/x86/kernel/dumpstack.c:447) 
[ 12.718706][ T0] ? do_trap (arch/x86/kernel/traps.c:196) 
[ 12.718706][ T0] ? apply_direct_call_offset (arch/x86/kernel/alternative.c:302) 
[ 12.718706][ T0] ? do_error_trap (arch/x86/kernel/traps.c:242) 
[ 12.718706][ T0] ? apply_direct_call_offset (arch/x86/kernel/alternative.c:302) 
[ 12.718706][ T0] ? handle_invalid_op (arch/x86/kernel/traps.c:279) 
[ 12.718706][ T0] ? apply_direct_call_offset (arch/x86/kernel/alternative.c:302) 
[ 12.718706][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:361) 
[ 12.718706][ T0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 12.718706][ T0] ? rtl8169_netpoll (drivers/net/ethernet/realtek/r8169_main.c:4877) 
[ 12.718706][ T0] ? rtl8169_interrupt (drivers/net/ethernet/realtek/r8169_main.c:4682) 
[ 12.718706][ T0] ? apply_direct_call_offset (arch/x86/kernel/alternative.c:302) 
[ 12.718706][ T0] ? apply_direct_call_offset (arch/x86/kernel/alternative.c:885) 
[ 12.718706][ T0] ? rtl8169_netpoll (drivers/net/ethernet/realtek/r8169_main.c:4877) 
[ 12.718706][ T0] ? rtl8169_netpoll (drivers/net/ethernet/realtek/r8169_main.c:4877) 
[ 12.718706][ T0] ? rtl8169_netpoll (drivers/net/ethernet/realtek/r8169_main.c:4877) 
[ 12.718706][ T0] alternative_instructions (arch/x86/kernel/alternative.c:1822) 
[ 12.718706][ T0] arch_cpu_finalize_init (arch/x86/include/asm/page_64.h:87 arch/x86/kernel/cpu/common.c:2393) 
[ 12.718706][ T0] start_kernel (init/main.c:1073) 
[ 12.718706][ T0] x86_64_start_reservations (??:?) 
[ 12.718706][ T0] x86_64_start_kernel (arch/x86/kernel/head64.c:437) 
[ 12.718706][ T0] common_startup_64 (arch/x86/kernel/head_64.S:414) 
[   12.718706][    T0]  </TASK>
[   12.718706][    T0] Modules linked in:
[   12.718711][    T0] ---[ end trace 0000000000000000 ]---
[ 12.719637][ T0] RIP: 0010:apply_direct_call_offset (arch/x86/kernel/alternative.c:302) 
[ 12.720663][ T0] Code: 04 eb db 83 f8 0f 75 0f 80 7c 24 19 8f 7f 1d 43 83 44 2e 02 04 eb c7 3d eb 00 00 00 74 a3 eb 0c 0f 0b eb ba f3 0f 1e fa eb b4 <0f> 0b 0f b6 54 24 52 48 c7 c7 e4 81 89 82 4c 89 e6 4c 89 e1 e8 02
All code
========
   0:	04 eb                	add    $0xeb,%al
   2:	db 83 f8 0f 75 0f    	fildl  0xf750ff8(%rbx)
   8:	80 7c 24 19 8f       	cmpb   $0x8f,0x19(%rsp)
   d:	7f 1d                	jg     0x2c
   f:	43 83 44 2e 02 04    	addl   $0x4,0x2(%r14,%r13,1)
  15:	eb c7                	jmp    0xffffffffffffffde
  17:	3d eb 00 00 00       	cmp    $0xeb,%eax
  1c:	74 a3                	je     0xffffffffffffffc1
  1e:	eb 0c                	jmp    0x2c
  20:	0f 0b                	ud2
  22:	eb ba                	jmp    0xffffffffffffffde
  24:	f3 0f 1e fa          	endbr64
  28:	eb b4                	jmp    0xffffffffffffffde
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	0f b6 54 24 52       	movzbl 0x52(%rsp),%edx
  31:	48 c7 c7 e4 81 89 82 	mov    $0xffffffff828981e4,%rdi
  38:	4c 89 e6             	mov    %r12,%rsi
  3b:	4c 89 e1             	mov    %r12,%rcx
  3e:	e8                   	.byte 0xe8
  3f:	02                   	.byte 0x2

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	0f b6 54 24 52       	movzbl 0x52(%rsp),%edx
   7:	48 c7 c7 e4 81 89 82 	mov    $0xffffffff828981e4,%rdi
   e:	4c 89 e6             	mov    %r12,%rsi
  11:	4c 89 e1             	mov    %r12,%rcx
  14:	e8                   	.byte 0xe8
  15:	02                   	.byte 0x2


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241105/202411051556.6b0c4fb4-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


