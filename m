Return-Path: <bpf+bounces-56501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39759A994F7
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 18:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663469C2F06
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 16:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066FF2798E3;
	Wed, 23 Apr 2025 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WsHiy9zU"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD2A27933C
	for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745424091; cv=fail; b=Rm3DfKROiC/WUS62UUKPaU03dvtKqaS+c8t4ZUN+EjTL+Skr2nMiFJPrw8X0yXFvSzMqT5P8A01+2I4au6t3RNekS1kVvCU2wToSEnXWnjfhtXpF+D3/oZj6niwOMkYF2h4C0EM/88fM2mz7Thp69DXCCJn36zwpRsAJW/gCeyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745424091; c=relaxed/simple;
	bh=E3KW2B8B1ivntzLutGvMkfhuYjdJQUSbJOh9a7WA660=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=fMEAyaWHw4n6Mc0MGCMKSa4UlFtFmHsKIYpu25VrRtCj8ji81vjO3RMhrzZLOLmo3fCbjZ/dnVzcpeVmolPtJ0KPOHNV8az9oUDiUP6eOBP/bl2pnJsgkAlAjmSRhLJPLmYus1xjv+Yq9fe3YHi++7iLTh4rGi41l7+Pp5C1S6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WsHiy9zU; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745424090; x=1776960090;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E3KW2B8B1ivntzLutGvMkfhuYjdJQUSbJOh9a7WA660=;
  b=WsHiy9zUTnu+x58c38mKzB41uQ6vaEgJ8H3bXk4xm1rB+nJXzuyW7Ogu
   OGBWhxrdnPZAQcN/FAzgC5+nksaFzacnIuPqp1FTAqk9BW3RzLN9/Z+LN
   bQoE3gLClf6Yw4w57xmItbfVyAYpg6G3/gXJlEVerwmM/Q1pAwDv1LzO+
   pwcqvA24L9QBol0wxcDj91LScAnkakQxwp9V/RtvdJ2cTSfgg6Fvp1Fxj
   ha+YqpBkR3JVdS0rZ+Shx9ydNqzsQBa3ubyNqXBygrIpB+ldt/d0AFtH7
   tlrVmSXxMn08G4FnWhxnivk2RdzAs8MsZTym0KLwM+nOQHktPZDsmQNbn
   Q==;
X-CSE-ConnectionGUID: fAGTCmWATcS8FACrB9rwkQ==
X-CSE-MsgGUID: Ky0RlNEXTteujT1/v3lkmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47156935"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="47156935"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:01:29 -0700
X-CSE-ConnectionGUID: fpMx9RkOQK6BBjBaoM/Pgg==
X-CSE-MsgGUID: bFh7nooTQDmj6plo2sAPAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="155565200"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:01:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 09:01:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 09:01:28 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 09:01:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1xZiKaM2Hpvll1FsA5aW4IInbnCj7oL66XDXaEkSjQ1dpPg7w8R7hR20pDpv7LrLg61sy+F5ASYmcyGBPS7GAqXlMGR/Aazu/JrBfTYxKEINfwIaeN2JZklphlgRytxqYgsNfQq9LHl7zw+z4OeWzr0mxnYJhkEezlNzr/M/Y2WrbePIc+Sfc1+nKi7dqbk7AdQRHwtOr2x5qlRo8bpg++QkhIUrnOYgrXe2NBv08vl9szX27cymIaYG0+xT+/uEiFTtmD1bnwj9AnmZ0ZfMNsxMryfBZSqRtwOYF4Z4GHAAH/yShNufIGW+stjsUV5I0TqWVw1uPaPoxrucOPccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJw2XxnAJHQ2gCHLtDeZ+hwgjd8KZ4deVqEkWMvA9hw=;
 b=tez6GCGpYatsfumKe8TjcYC2QEb9/wIwHojbQRdq9K57S8HxkLCV0zV2yy7R5hj/dn0lsjE3EtxhVUGPeZqu53m6LRevb32INDnzahYsYXfmNMPY42Dy4KsVwKo+yCfza/O2flpP7Cfv0i/qPZWbMv5SOkElJtzgXIk/jwL1VUY9ogPMHoGjN/6xI4xzpt4Zb/rO5GEUhnnQukpESkHdflF1FDxgm9DaUiAP6lzPDEUMz1vdD35/pQG1ontSI1rJQhxFRN6GmNhMOiD/eJxS177cBsD4d/wvHgCdkm01ybaIRUlBUVubVZWHh/XtQyp5I4n6qfwZ0sVCotMapvuMoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB7050.namprd11.prod.outlook.com (2603:10b6:510:20d::15)
 by PH8PR11MB6684.namprd11.prod.outlook.com (2603:10b6:510:1c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 23 Apr
 2025 16:01:23 +0000
Received: from PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582]) by PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582%7]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 16:01:23 +0000
Date: Wed, 23 Apr 2025 12:01:20 -0400
From: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
To: <bpf@vger.kernel.org>
CC: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
Subject: [PATCH bpf 0/2] bpf: Fix softlock condition in BPF hashmap interation
Message-ID: <20250423160116.120118-1-brandon.kammerdiener@intel.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:a03:331::31) To PH7PR11MB7050.namprd11.prod.outlook.com
 (2603:10b6:510:20d::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7050:EE_|PH8PR11MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ea47d2-c8ff-4ab4-2409-08dd82801811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yJbZrmcBCIkRevDHwRQKXJ0uYRdRedIPvGh3UVeQjJQGlVKSl2SiYlJVTbEo?=
 =?us-ascii?Q?t3RjChIOEMnpGbJJLDT3ZDxH4UbO7qL0qAGP9FEJFY0uUuZlei7bViuYFTfV?=
 =?us-ascii?Q?iQEQUAk59pJDc9+DYk7+YmN/OOH4Cr6rtF0htnRqFecnKNMMzerEWO3/PA+i?=
 =?us-ascii?Q?z6U1AuRl0RFsHmzzuptFBS+K1qP6RCpJf6s0e7vu4b2kvfKoNL4IyyvgHV5I?=
 =?us-ascii?Q?Lbe5vtJXRLzdvwMN2yYj/K4JPtrgM31TRPWtDYcyayMGKIWiIHqkeQVB0fD2?=
 =?us-ascii?Q?6oGR4f5Q2MUi19rAmb/Gs8hqLpZtcmW7KR5keDpXoeRvr2538/5lyBWGE3gY?=
 =?us-ascii?Q?wLhd1DDKG0ewd1RNhOz5Oshiy2A5kQl158EDgioSgR0drlLJZpO272Zl5zPQ?=
 =?us-ascii?Q?+i3NjBmF0xVuH0kUkb46aMCUBmJzjdczAUVWA/roMXEv0O1Cc9PYtqOCFpE2?=
 =?us-ascii?Q?/eX0mIUuc2zynH/mJaybbQi/ccgcb8InWisZ/pOpYVmBLRdFQJ44tAhyHTar?=
 =?us-ascii?Q?Gd0B1uUHWZJlUbepgPipnWPt2NG2QUcdndZj1SUeMxk3KvD17SDtcfmNkhaM?=
 =?us-ascii?Q?8B+BZFY0UN99T/l0meQPbKUjcGfvdIN3l8y0v4K1KfvaVmUS28noo46oT8B8?=
 =?us-ascii?Q?y11kBnMZARaQveHJfOd0Kl33W7SGp5uNtNHhHBRmpl7RuJV8gtLRmLqXlUIk?=
 =?us-ascii?Q?OcVNwHbur0NGIn8BnSQVA5YHG7pEL1pJslSaMQxO0spbMxFCwzsMEse7wgs7?=
 =?us-ascii?Q?YzlDhmOhOEj5s1NjEak/tZly/0zTGjvasObI3nTn01RXeIVQzfwBltQ2ZLWA?=
 =?us-ascii?Q?TziZ71+uQHuEp54z6u1mWiwdJwaq+tyAhAfDze+JLD6f80XzghXzMU9gJR3G?=
 =?us-ascii?Q?JPDZqXTQlZMgLJFyk/GC83nbAJGLCgEeMvKenKQGrgKXlY28fC3ZMv/pqYew?=
 =?us-ascii?Q?yRvJk9KyHkxG6JGgfxyb6r0t50G3l1R2oJf3H4KcdKTjUqjgWomAYBx903l7?=
 =?us-ascii?Q?JryXBYT2RxAJxbmTwLHXH4EzWrhTvvWsVCVt2AGq9JWQ1MNaN5nDBEd47tH9?=
 =?us-ascii?Q?JxlGg0g8ojAFyAMxPaQokBXyhlr+jalfPkED51zZQZ/GhXRZ8t0ZS7W9oQTX?=
 =?us-ascii?Q?1HKBnXslBoGFgxAsi6j1pl08myj/vPe3u3V1VUuWN4YjdruXpK6Jp42TkFBy?=
 =?us-ascii?Q?j5vd49rIzM86qHIHUcsrrhxfhwIpkbo2EdPTlY+jJzHr4JYIJR1aDviQB2au?=
 =?us-ascii?Q?jzrPVkgc07MaF/VNMYpwRLA6rcHgRjuuQXvb++7klsHTskZI80Lc6ZI44LJq?=
 =?us-ascii?Q?HcVmKoqsFWp0ly9949KuAYAZkCBviIhq4wbKImwiqHeS5+jUePrZgA+6p6Wx?=
 =?us-ascii?Q?Sl33eXpadZ+fj5ObwCASp26Pr18pNik7cfqH3D8j4wS4iCqI15Jpi8S7MZMu?=
 =?us-ascii?Q?JEb/YdkntUc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MRH57FY2h2IHuAitA1oDR7xL6Lezk4gCgXwv/VW9KO04lJwP0uMI9PPdiAMa?=
 =?us-ascii?Q?hyGFZvMVq0lDfbLYGqZ774vExZPBGOoOONayuwKCAxYSjY2dMVkGl3XuOFan?=
 =?us-ascii?Q?jcaUvH4cqsgBR4F5NxWXssDdWpToCgKMxgRM010XJJavwKHfUVO7b2mGIHSx?=
 =?us-ascii?Q?4li7lslBSYTT/fM5tBfkT65KoqcsSw98wNhM3ZRpgNFQDPsFhwPN9SN0/e+H?=
 =?us-ascii?Q?cNegwJI0z8XInZAd9wu7scaCE69CcnIYtHeL9vFB155lj9dV/8YiMvnz5/ab?=
 =?us-ascii?Q?6nhFGOrgpoOHc7sO6tGO8L5TC4PV2rtsJqoSRJ9RagubA9IXZxVZyKFbfWLc?=
 =?us-ascii?Q?e5HGXZEcZYMsV/9C5KFlJ6uPYJf9gmCymWSGIsLv/SBg7NMAoL+ePHgNNMHx?=
 =?us-ascii?Q?8rvd2bMIQ4nZvfXNKM1EocNMziW1i8dzbHFhXvEuUosdoNQcilvHFgIV/1mL?=
 =?us-ascii?Q?d05jSYlcgJdLZfje9VMzGRvgvx2MDwI80lJIe1V4AXVX1nbEOCSBvfrS7/ZG?=
 =?us-ascii?Q?RMXfzTzJh/OC4W++wB2JdxreDtBPBY7jo/Ix0cXNy84TMD5hcQkA9uAleBMP?=
 =?us-ascii?Q?Of6AjzCVouHMeda9Aq57Y41S8pENoCKh+VuJEVfa2X+FqoEYnSK8NxO/w7fj?=
 =?us-ascii?Q?8hyuUeNZ9j6ZzTmJcIOpSUlzVxwrIKcX4CZeyiVOd0375qKjevaev6CXFqEb?=
 =?us-ascii?Q?27DQgRI4kqVfhJ7r4P3m+yBgYxKkeMsnxfHyKN+pNPGKNrzCauvwMRZ+0DFs?=
 =?us-ascii?Q?1snNMVyIcsmFWvEVE+hauEpiRQpcJ9JI4JMu5dmuJgNUMdugsbNEXufS1L81?=
 =?us-ascii?Q?L9vMWlYkoHIqwWVCleCu/VvJGpp9HS5Gp/AppuLWWfXF0j4wCbrYOi33S+rL?=
 =?us-ascii?Q?lTM1rugJWLEG7R7yYW4llGR4isaKyqd2yD219Mv+Ymqu3/aMbzTFCiXfxAuG?=
 =?us-ascii?Q?AQQu7hgS7C/QagCXaaWN+23ifiXdNTomlymAhG8AIOu8fKbb9a7f8rcOMhsv?=
 =?us-ascii?Q?qvc4P2FX2DncQCjHDKuNxHma++FXm7onqix15lBEyxM82ryBEd3FgWEyLdu0?=
 =?us-ascii?Q?V81tkr7w7gK++Tn4ymHyWJ7ut8aepM9wgVow7WuIktSoiyNSCO2C8g2waOFp?=
 =?us-ascii?Q?Griviq+DKWwFP8coCvvICIxu02a2XteEJ+q/3Xoho5ziv0YPHP9902EuJww0?=
 =?us-ascii?Q?TDtyAr8ZnZmX27j8Z1GolREbfOd/s1HxKBDU7QKDDug4FHAkCv6WtU6mUqos?=
 =?us-ascii?Q?ZT68YqO+3AgIiUwJqmczJMkiofB+gjigp3xjYm+yYzjZvNWQFueWLCdBQgzK?=
 =?us-ascii?Q?v/U5vT3TfiUhlOWBI4v7b9eT7M1vl1gmmSNv5imYgimhPlEOFFgKwk1WeedT?=
 =?us-ascii?Q?9N40+2GeY4690BhlRyH9+D5uW3yO/QM5ajBTY0elkTxHUxyDw8vls7ufY3rB?=
 =?us-ascii?Q?g37V8DNq2g4DfVo4J+UmWSyBSK+lKtKjIBtIMEmLQkxK+Chfh42CxI6QPDxh?=
 =?us-ascii?Q?n/OfY2YvOqmc4lyjTdzN3nR6KQykhNM73ycoVmpSC7u/kBOKVDWmo0NrKDiy?=
 =?us-ascii?Q?n3MqJZNwKuCBAB7r/5yquQ36IqN5ovl/DVrgDvAQy7lNCD9sfzoUPWPT1ZSD?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ea47d2-c8ff-4ab4-2409-08dd82801811
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 16:01:23.0027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJeUP6qK/JfOvcuL7G39J1rjDi+2CrWns9WrCBsgeKnEY/ZiaWPXFmmPv7RzoewBBrbWoomP+e4vMr+k7SM3k8IX7OW5xFXcQc1oI9/TTF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6684
X-OriginatorOrg: intel.com

Hi,

This patchset fixes an endless loop condition that can occur in
bpf_for_each_hash_elem, causing the core to softlock. My understanding is
that a combination of RCU list deletion and insertion introduces the new
element after the iteration cursor and that there is a chance that an RCU
reader may in fact use this new element in iteration. The patch uses a
_safe variant of the macro which gets the next element to iterate before
executing the loop body for the current element.

I have also added a subtest in the for_each selftest that can trigger this
condition without the fix.

Thanks,
Brandon Kammerdiener

Brandon Kammerdiener (2):
  bpf: fix possible endless loop in BPF map iteration
  selftests/bpf: add test for softlock when modifying hashmap while
    iterating

 kernel/bpf/hashtab.c                          |  2 +-
 .../selftests/bpf/prog_tests/for_each.c       | 37 +++++++++++++++++++
 .../bpf/progs/for_each_hash_modify.c          | 30 +++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_hash_modify.c

--
2.49.0

