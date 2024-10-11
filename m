Return-Path: <bpf+bounces-41720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF62999CA1
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 08:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0451C23771
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 06:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F9D20897F;
	Fri, 11 Oct 2024 06:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjtVOq/H"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E7D1F9434;
	Fri, 11 Oct 2024 06:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728628098; cv=fail; b=sOx4iecqliUV5XVpp2WNt5MJeaPGPYfzs8YeOr4CAu8sxRU1CpX162SFpxIqfO61FxETZpL8za6Uepl5HNGqUqWQXgz4rdsQyTnc7qDBLPGFgZiVFSI4qkl+LDk73jZ5I+4lNDDmjKmBuD1UTZbUPUYmLpdL/kxG3kdcoiyP3Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728628098; c=relaxed/simple;
	bh=XYwBfpMX3u7GjYnv1lvXsm87uMPIsX/Q9U5RW24jwf0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=iYVaACTctzg2IbNnyw1SybKhhJjhfDL5r8W6jIS5obQ3IUISoazZmgsaKF1AYme3HCyjq+K8P1ac3LtH4fI7dPMSUTW4gjFLsMhf1CsQ2ZRm8uZ4ObN1e69Vbhbc/L4qYQ1JunQFOg1FJGZ+IGMQLmFNNFigO3fawjxJtXC8ieg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjtVOq/H; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728628096; x=1760164096;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XYwBfpMX3u7GjYnv1lvXsm87uMPIsX/Q9U5RW24jwf0=;
  b=gjtVOq/HOmfdege/nYLzTmKdPKG0oZkcEgNE5wQhGc9Q2RnQ7PsTN0dR
   9s0R9Pcn3gJzZypl0tB5DCmKjBC0TAy76Ye7ZclDyJLM2ygJfxp3pJkHP
   AykZN8etO4O7KpF2nPwaOpC+fSahio5Z8Afjw0oSUKJBr/TamEVyyIkKC
   S5Oo4c17ouZkWxwMAqW4bajXuQEIvOR6yBsexcZJPB9x7afUWN/n9M0fl
   T/iO/wNtDQuUPzBFkM9iECYS6eipxI8FABv1hNPEYPYs24QIsvBNaNkie
   L5dMfJg7EztNB7uqzXBEItYPnzViWEH2G0uw/C/9NxtBk0S4IbH5RiqVK
   w==;
X-CSE-ConnectionGUID: xDTq1RgaS16rk+IM4eBiVg==
X-CSE-MsgGUID: is7wv7S4RDijAipPDP1DNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28127764"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="28127764"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 23:28:15 -0700
X-CSE-ConnectionGUID: LU/C+L1/S6qEA0FQ5SKBRQ==
X-CSE-MsgGUID: XcHHxgTETNmvXouZrdHjyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="107686484"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 23:28:13 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 23:28:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 23:28:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 23:28:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 23:28:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nm7zJh0s/WWYmq34HfqyexKG6TV983GYOUvTJR2/4b1Bq0HZ6BPk2eEAim2Pj1xberLQSUlK1q7S1/yQCXpPWpRYuZkYbHKi38kYLjMBN0ZqqxT9GDptH5CAA+WPBfN+qGK+9ifeaX45A6cqLUmDsA6bNckOMS+g0XPH3qOgSIbFyR0ynUiqXgNjGL2qudJKqjbYTX7H+qNyeM600dvIXgD/gPlGeY+CSOqUzPLCvjfPehkWcQCK2VE/sH8Fm5puhX9/jXq6TY5cshvBE4+XE0rlKKNWG5vuBjc098QivJDUZOnnYwvQj5VB64NW6v8/wYbLoUYQ8ppFrw8yEum7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6q2OJBCuQW7cTFCZgTa9jWvxQcDKue5mHu1tDswsfZM=;
 b=q0/djEJDyxRMUrklzxZ/JDYepSa9B/kyzMggGnUzn68p3gFcV1k8AUixmaA34mGTgPezsXMR9VTTe3E0Xg6bQmabgvL7ZgPNAq8oih3b/EP9z5v7v7yN0BTauwXgce5RKbdcHAPGcrAG7HBpCu8JXYwpXTcBIlwmVNAVEU3keMfDicCM8bhJIPZma2FVZ9/qr6/gQxUsN+ZjKG0TFpME15wVZHVsR9pY4qt8VOI68Mpe2xxAJtQNGqnza8TphcnIA0bLy16HIqsuQ8raP6sp44rnwxDn0cKgFG6a9ytkjg9ROAq8sljAIQh5ZGYD/sV6sQcg05kWkZ5K9QQZZdDq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8210.namprd11.prod.outlook.com (2603:10b6:610:163::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 06:28:00 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 06:28:00 +0000
Date: Fri, 11 Oct 2024 14:27:50 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [peterz-queue:x86/ibt] [x86/ibt]  a512fcf757:
 kernel_BUG_at_arch/x86/kernel/alternative.c
Message-ID: <202410111436.282a8f8a-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: c61050b4-2d12-418f-98b2-08dce9bdda33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sQ3e/3IjywBuaIaadhoI1Gda0B0ELFv7lxoz6uqMdnCDZsDRoZatIbdVftlP?=
 =?us-ascii?Q?7mocjkKq2yHEnEAEKxyEV56K+dOUEPLsPMX4rMmMVhLZPpFzZCkORPVWTq2D?=
 =?us-ascii?Q?ZjVchXJanPZKcnLZvSrS4M5yAVfsS40/hmi35WdgWwvk/SlHR37RxUw2ntoR?=
 =?us-ascii?Q?xX6xBVoHsnX4wvrRZbEnhU7gGTgM755xVgOxOW8lGGFP9I8PPhItU1DMh951?=
 =?us-ascii?Q?toWZbvrRsZ65y5v2yC3SAdjHfTAR76h57wTxJZMycfRVH74FHb32uFg52YBU?=
 =?us-ascii?Q?th6WZIpjFeMF+MuQOq3VgFZspsBDr2qwlgao7epc5jgRgqRP2+nN7vtteUQn?=
 =?us-ascii?Q?+L9UzDre5owK+xJx4DEhG+u9tjSKsD+HjXDYJ8fJqbaBr5uqAYjggiGonDqK?=
 =?us-ascii?Q?DLKb44VJlXFzaJi8ohXjWWgtqET381+IQ2Wo48ESCRtLisk7OtkEmTr50dkB?=
 =?us-ascii?Q?ATyxUIsL1vZI3IYCyFhPto46Em2WxQxqeueQmjafw5Lkwl5SOnpz3L91yC9y?=
 =?us-ascii?Q?lfaqXm4arFGv1rb9dy26HHoj76dkOt1jwKrgB2EXZMfb9w9BI2oKuqphv10t?=
 =?us-ascii?Q?AT8jZc89mpppAaiQA2jm2tth25tkaxbLuAxCv2d0Hm9OIGi4D1+P8ZPAjPGE?=
 =?us-ascii?Q?/NJCg2f51GxGI7xs7I5Vl+YomZfaDsIDwCUGgPQBfEL3UBdQkay/XnmKOd/X?=
 =?us-ascii?Q?LbxmaU8CP5hwQtygxl+VVJG0zxNsfK4i5r34GKv2fSB1jhIdTU0D+BQClENW?=
 =?us-ascii?Q?H/fYFGoSau4/00Ggb8LoACtJh4f1sgFyiKaqNsPZ27es2c0XOts+mZ6KDglA?=
 =?us-ascii?Q?3C6MQLsIwj5QoYy1e/rllHhY5DisZnmoYQdu9U+0zfIsFpjZs5SivaCW6MtU?=
 =?us-ascii?Q?jNuiOLxv8X1lRk9J9cQ688EM/grrsm3iV8NPQ0dbY0xjvMnJTkimqMRgN8Mc?=
 =?us-ascii?Q?/5Snjlq3pp8cC6WOXDFnJE81k3HW4VCYYagV6OPxJ/yluAzSrbr9sK84QbAl?=
 =?us-ascii?Q?IdWw2fZqzELFthjZbDMECaYte+ayEz3Tv/MfCGEeH478/IhvBxKAHzxeG9tj?=
 =?us-ascii?Q?R48LqxGEJxC2UizndmfGESwrxmCsjTLlyaP+kVBwGyQEM9QRjwD+ISsArMIf?=
 =?us-ascii?Q?yHViBURniY1aZmQtimqBV0jxPnUQlFUKCTngIhbOXh/YRk89K51WVTzfVp5S?=
 =?us-ascii?Q?HvzdLAw494Nq1ntp2YyVyliGaZ7lKWqIfX/ClF3AfFzzUaR47a9nFzts8F8?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H7ciWdctWqg46y8tYQ1vwexNFfHWmsRWEsXVuUj5VzvoiBOwyoyw4+zVJlBx?=
 =?us-ascii?Q?PAcI3m52AST+r0kCnFTjAhNrf04eXTWx1AG8vs5GgpnId2MUbOPU5cs9PtmD?=
 =?us-ascii?Q?GJ/E4aPaQaGRwR6soNznKvlMALpBpKVX0Mfhkkd4bUh8M1xy33OhwBsSrBAV?=
 =?us-ascii?Q?Sja7qeS/6jPtzARW3ZcfPoDmW9cT5goImyozzddBbAcy5l7CmvxXHag9W1Q9?=
 =?us-ascii?Q?bkx1LO7oAJ1tnDga2sUo1VNdcG1JHcnu0qW5vfejqpoH05TmUwZ547WFJtel?=
 =?us-ascii?Q?VtWs8jcdUTNpA+HRrED1YCuAUDMLV+ID9WQkiv2zPVO9U0yf3Kh/dPYyfY+A?=
 =?us-ascii?Q?30f9ZiV2z9nGiht3mlShn3iTAUUhxExkMcGwAxNssGu/oyMfTaVD8NLrmCJq?=
 =?us-ascii?Q?tmwK9aGzAugmwfM0oepvkvqR8yBGVsPD+p/H0wpDHE6XMv9UxA13Kjru3gZ2?=
 =?us-ascii?Q?0PIQqv81cijLedAtkPFeAY4Or0URNhIcvKQQQV5x7Gg4o+ck6WFIJ6e/3wi7?=
 =?us-ascii?Q?sqWEnP7c+bjuZ2rkYylwgrCFZNmWNHF8FkEtj/9h/sF3H+2O3fa7V92BTKwW?=
 =?us-ascii?Q?oHcu3CqsIFSxGIc7+ithcK1vC1Q/M5ubY6n2ny9+5lSfG9hB8Lt2G4AzaVys?=
 =?us-ascii?Q?omwopqBW422h/wu+UTWFKNJooUH8S1asFyyLyv5LM6YGNNNQAZTUCDVR4wF/?=
 =?us-ascii?Q?0M4JvuqF+YV6AehSwnSfxv8ZT2QmOANQKlskgBcbH7MVUJF8yQVgMmHzdJy/?=
 =?us-ascii?Q?QSz0Seo7aFldGN/qa6RQKC1fAp8r6Mmu6ZJG1aFgVAcY+nGh/13Gn/s9vo1x?=
 =?us-ascii?Q?uXzi76jYRuSIxrIf6G0N5f5JOK/EUmiIMp6H5T24gxrrBaFevCnszg0OybEa?=
 =?us-ascii?Q?Ey8vbBBlBWd6UW4acsY/YBh947e1xX5LlDzrsK3b9Yna5bTKfs4yOVYiZTkL?=
 =?us-ascii?Q?n/aSQZfJwC/5MGPyDsZetiGcUjE3OmQId7lUWmy4z00eGsl+lHzlW4fKnzjP?=
 =?us-ascii?Q?LjIzxylE0d8SUec2FTGNswFcXkcTiZXegnp79M9HKlZ3m7nGIP8hgt2opEDp?=
 =?us-ascii?Q?XparBNjsz2nTtitROGbTKoq4+NX9nDRre3BakGKWOGbZsB055Ng7XoyzLm3j?=
 =?us-ascii?Q?M3TYdDY9aaGs9BQ8ZWnKUrzSAoVaRyV0oD11QeyCftyu7oP3zk0++oZ8dfUq?=
 =?us-ascii?Q?w06wjf2+dwRyPMR5tfqR5HNrmurqtKhWdJIShl81tnjSwsF3mUfdzO7zxN/5?=
 =?us-ascii?Q?VOiDj8IHpZveeS3yGuyzc/PakHQmQUB8+rgDB+/Cma2OqN4IEj7UXlr3VuzD?=
 =?us-ascii?Q?QSZC1VNoap24qGT1SxUaMN09+Cn3DZvq2GOz5euO+FiNLWH5ce0q2b5ZBUvP?=
 =?us-ascii?Q?G3wbSNT3qEHRcU4DCJtcYBfe5uJzlQ7nzTnBETmbefyqjaI7Xcx+qgMifVY+?=
 =?us-ascii?Q?wNfRg/fRVldfDwAFqETn3tayWpc78tPVGFMQl5ZZgtHYEno7PxUkQXPAxVQq?=
 =?us-ascii?Q?dQe+bbJzSDB5SIQKKgEERIRvTS7/49TW4MXeUjzyaFn9C1vLxcMBbqqBtPHq?=
 =?us-ascii?Q?XUxeNpIhZQFH9UgW9ntw6rIfGNNDuoUBX1Vm3/x4E7X/VS/+nhoYhtSu6wpZ?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c61050b4-2d12-418f-98b2-08dce9bdda33
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 06:27:59.9998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85Su+GmGFPpUpy1D+fUCzbB/uFJ+plB3YhszNf3LUglyXLIqvNTLe0TNRROTbaU89A5mfOX6iiNCC+AVJF+pQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8210
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_arch/x86/kernel/alternative.c" on:

commit: a512fcf757ce329c284853fbe1e8bd9b810fc975 ("x86/ibt: Implement IBT+")
https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git x86/ibt

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+------------+------------+
|                                             | e78683161e | a512fcf757 |
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
| Closes: https://lore.kernel.org/oe-lkp/202410111436.282a8f8a-lkp@intel.com


[    0.596045][    T0] ------------[ cut here ]------------
[    0.596942][    T0] kernel BUG at arch/x86/kernel/alternative.c:302!
[    0.597962][    T0] Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
[    0.599029][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc2-00010-ga512fcf757ce #1
[    0.599197][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 0.599197][ T0] RIP: 0010:apply_direct_call_offset (arch/x86/kernel/alternative.c:302) 
[ 0.599197][ T0] Code: 04 eb db 83 f8 0f 75 0f 80 7c 24 19 8f 7f 1d 43 83 44 2e 02 04 eb c7 3d eb 00 00 00 74 a3 eb 0c 0f 0b eb ba f3 0f 1e fa eb b4 <0f> 0b 0f b6 54 24 52 48 c7 c7 1c 7e 89 82 4c 89 e6 4c 89 e1 e8 43
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
  31:	48 c7 c7 1c 7e 89 82 	mov    $0xffffffff82897e1c,%rdi
  38:	4c 89 e6             	mov    %r12,%rsi
  3b:	4c 89 e1             	mov    %r12,%rcx
  3e:	e8                   	.byte 0xe8
  3f:	43                   	rex.XB

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	0f b6 54 24 52       	movzbl 0x52(%rsp),%edx
   7:	48 c7 c7 1c 7e 89 82 	mov    $0xffffffff82897e1c,%rdi
   e:	4c 89 e6             	mov    %r12,%rsi
  11:	4c 89 e1             	mov    %r12,%rcx
  14:	e8                   	.byte 0xe8
  15:	43                   	rex.XB
[    0.599197][    T0] RSP: 0000:ffffffff82a03e58 EFLAGS: 00010297
[    0.599197][    T0] RAX: 0000000000000082 RBX: ffffffff83803d80 RCX: 0000000000000000
[    0.599197][    T0] RDX: 0000000000000001 RSI: ffffffff81b4e7eb RDI: 00000000000000eb
[    0.599197][    T0] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff82a03e58
[    0.599197][    T0] R10: 000000000000000f R11: 0000000000000040 R12: ffffffff81b4e780
[    0.599197][    T0] R13: fffffffffe35283c R14: ffffffff837fbf44 R15: ffffffff82a03e58
[    0.599197][    T0] FS:  0000000000000000(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
[    0.599197][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.599197][    T0] CR2: ffff88843ffff000 CR3: 0000000002a32000 CR4: 00000000000406f0
[    0.599197][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.599197][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.599197][    T0] Call Trace:
[    0.599197][    T0]  <TASK>
[ 0.599197][ T0] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 0.599197][ T0] ? die (arch/x86/kernel/dumpstack.c:? arch/x86/kernel/dumpstack.c:447) 
[ 0.599197][ T0] ? do_trap (arch/x86/kernel/traps.c:196) 
[ 0.599197][ T0] ? apply_direct_call_offset (arch/x86/kernel/alternative.c:302) 
[ 0.599197][ T0] ? do_error_trap (arch/x86/kernel/traps.c:242) 
[ 0.599197][ T0] ? apply_direct_call_offset (arch/x86/kernel/alternative.c:302) 
[ 0.599197][ T0] ? handle_invalid_op (arch/x86/kernel/traps.c:279) 
[ 0.599197][ T0] ? apply_direct_call_offset (arch/x86/kernel/alternative.c:302) 
[ 0.599197][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:361) 
[ 0.599197][ T0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 0.599197][ T0] ? rtl8169_netpoll (drivers/net/ethernet/realtek/r8169_main.c:4875) 
[ 0.599197][ T0] ? rtl8169_fix_features (drivers/net/ethernet/realtek/r8169_main.c:1689) 
[ 0.599197][ T0] ? apply_direct_call_offset (arch/x86/kernel/alternative.c:302) 
[ 0.599197][ T0] ? apply_direct_call_offset (arch/x86/kernel/alternative.c:885) 
[ 0.599197][ T0] ? rtl8169_netpoll (drivers/net/ethernet/realtek/r8169_main.c:4875) 
[ 0.599197][ T0] ? rtl8169_netpoll (drivers/net/ethernet/realtek/r8169_main.c:4875) 
[ 0.599197][ T0] ? rtl8169_netpoll (drivers/net/ethernet/realtek/r8169_main.c:4875) 
[ 0.599197][ T0] alternative_instructions (arch/x86/kernel/alternative.c:1822) 
[ 0.599197][ T0] arch_cpu_finalize_init (arch/x86/kernel/cpu/common.c:2397) 
[ 0.599197][ T0] start_kernel (init/main.c:1073) 
[ 0.599197][ T0] x86_64_start_reservations (??:?) 
[ 0.599197][ T0] x86_64_start_kernel (arch/x86/kernel/head64.c:437) 
[ 0.599197][ T0] common_startup_64 (arch/x86/kernel/head_64.S:414) 
[    0.599197][    T0]  </TASK>
[    0.599197][    T0] Modules linked in:
[    0.599201][    T0] ---[ end trace 0000000000000000 ]---
[ 0.600092][ T0] RIP: 0010:apply_direct_call_offset (arch/x86/kernel/alternative.c:302) 
[ 0.603203][ T0] Code: 04 eb db 83 f8 0f 75 0f 80 7c 24 19 8f 7f 1d 43 83 44 2e 02 04 eb c7 3d eb 00 00 00 74 a3 eb 0c 0f 0b eb ba f3 0f 1e fa eb b4 <0f> 0b 0f b6 54 24 52 48 c7 c7 1c 7e 89 82 4c 89 e6 4c 89 e1 e8 43
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
  31:	48 c7 c7 1c 7e 89 82 	mov    $0xffffffff82897e1c,%rdi
  38:	4c 89 e6             	mov    %r12,%rsi
  3b:	4c 89 e1             	mov    %r12,%rcx
  3e:	e8                   	.byte 0xe8
  3f:	43                   	rex.XB

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	0f b6 54 24 52       	movzbl 0x52(%rsp),%edx
   7:	48 c7 c7 1c 7e 89 82 	mov    $0xffffffff82897e1c,%rdi
   e:	4c 89 e6             	mov    %r12,%rsi
  11:	4c 89 e1             	mov    %r12,%rcx
  14:	e8                   	.byte 0xe8
  15:	43                   	rex.XB


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241011/202410111436.282a8f8a-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


