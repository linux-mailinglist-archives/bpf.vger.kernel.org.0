Return-Path: <bpf+bounces-63416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CEAB06F5B
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 09:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2DE3BC3F3
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 07:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1B628DEF9;
	Wed, 16 Jul 2025 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NK13OmB8"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F305285CA5
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652090; cv=fail; b=C5JX9XyrSuIPZUcftPvXdC4CxqyCiDTm3mHR+jHEfQDyAkWm/BLToRKHe0e71I69GZeGIpUzyuppNgc7JWj2bziefGVNKDbOprqqR4WZb+lBxpRJt7D5iIOuSratA8NeFH6Xyd+5qAyZfPavFRY4eDwiiNrC8Bb7zQroNts7cSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652090; c=relaxed/simple;
	bh=cSaV5ROkkT5KwNYxZ7ZwrkovY/gC+onrzNmjBLR2QoM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=c1KFyymjb6c9ihAQK5iWbgcAowh0DNuShXt3QJuf5P2NCKIoUfN40S0rj2jLdq4bGjYJ7gbNeOOcproet0pJyZAbzu0SuJvBPpbe6LyKcTS81Hs53p1jL+nfKFZWrWDk2uzra1kWuF4n8tKXwzOqLSVsseHdOCR6/BOmi/Hmz18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NK13OmB8; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752652089; x=1784188089;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cSaV5ROkkT5KwNYxZ7ZwrkovY/gC+onrzNmjBLR2QoM=;
  b=NK13OmB8Z5ry2iSQynZn+bh9dOtfbOcNlpMHGUQR9uCJKXanPhjA7k/p
   sTlGIc0W6htmmG1jCPkzWMh0UoTLocArq3MaO/+2gBHS0kxLEMBHH2i6s
   f4Po98aPVfpDC1OaWOlo20ufTNHjzHjO+0ZZRN6K0jRv5IJ5wWvPuT//8
   HWlOMGDg6XbY5/ZwUPIjLSHdJ8TFfBm6yBuDZvgejFjEZDfAemjM9Tcg8
   UJiMiDAsSGmoDZEbpN7du9DZlsO0vxQkToCDajeyvXbHfTgNVwig+DN2k
   zec4y2Gy8HdjQyPmoBH909pkfsidUjSrh/64hv836EiQOmrjlNzRdRG9M
   A==;
X-CSE-ConnectionGUID: 3Vyg7DUpQ4uNY0g585emrQ==
X-CSE-MsgGUID: ahOCFTp2QGW+4jHkZc9hdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54743123"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="54743123"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 00:48:08 -0700
X-CSE-ConnectionGUID: JQ10H4fKTrCsZoB32HTbDQ==
X-CSE-MsgGUID: spUXqdvfS8ewGW7lgPbpiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="157524531"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 00:48:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 00:48:05 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 00:48:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.79)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 00:48:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1GlXQfh1Wlw5+AJoVOPGxmPlUXcuFxU9/qle64oDCYwN8apgtLV6rF6jgUC7T2hHdXLDOdzUdaoVhofM3AAc0aba5XPsz5rLR7QWHhb2erQM2LRKNIKyxJvfZVBOLg346FgiuaQge3c2cueLrNbCLKr/vcNkk/sin1PbdGTZgC4Ldxhiveqi2a2s3MjhN3/QQJW+LnlwWklcEcYl5VsU2xISV96VGowt7jlRrX43bjQonQk3V4M7hUjw6FCrpkB8uheLNGsLUljXZ45U1M0jRh9Vve0IDSTpYLCJxCubPZ2PCqF7LfsMwYXE6fQ98YbWBdW0aIJeeCafiPcj2Bchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aynuFHRVmafd7ky+zJ1PkbA6fNbLmGQcZheyLIJujxQ=;
 b=I7pF0+OLicdPxsV5rKn/TCI13Lo0zGtnc9d6gVJ16FtEoERwn0rKdPzdmRkybTEzauxnl3z8kzktEjoELzwX7QIymo+p7z5958oIsV+vAQZ24PSqI72d7wd3VtTu09Nu8WaOmPYsk8KP6QlOY+tY2JhKJXCnSeYmfUwQrUuN6/78ohA/shNi5YlaB3WY0k9m1wjT69FJCGp85uz2AsLfb5uc4XBvdTmapMPSd0Xs30FNsEOZMKWlF7Y7CamNVIIaeFdJdbuW+Y2na5EhzdqICnJYAQMIcj7yxy3YJhPCVB4Me7Nu+VIVkgxt2Fn6l41H3olrQ9vuj3x7hQ2pf7qpBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL3PR11MB6314.namprd11.prod.outlook.com (2603:10b6:208:3b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:47:57 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8901.018; Wed, 16 Jul 2025
 07:47:57 +0000
Date: Wed, 16 Jul 2025 15:47:49 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, <bpf@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [bpf]  0df1a55afa:
 WARNING:at_kernel/bpf/verifier.c:#do_misc_fixups
Message-ID: <202507160818.68358831-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0236.apcprd06.prod.outlook.com
 (2603:1096:4:ac::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL3PR11MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5d1ca5-85e1-4ea0-9da7-08ddc43d14a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MNC/B9iVuvIiH+GnFp3EMk+G8+gsvHYUGALZOZs0Vq9HnNCNdLI930GjOVj8?=
 =?us-ascii?Q?XUdju49m75fJKJjbvfogUZCPmzUzXt4BmD/cKQcSoqRwI42Kj/Y2WF+jpYRV?=
 =?us-ascii?Q?kn8diDqvW7g9IAnYJZBCLnhHiAxdvYTsI2wakX91A4PfyFtN2VQbo9U5xXd7?=
 =?us-ascii?Q?rVSOOksBq+0uOHMoEXLtQxRQA6rHMQT64hz1M1mP8J1Lc3dScRQHgk3JdNdx?=
 =?us-ascii?Q?Ls2U1lmHb1f86IyTraCIAq1w4UY538gx8SUo8gs8KP4yebDJOAWW5VFtRVub?=
 =?us-ascii?Q?QjqhlPsEVt4FlO0yXq47onh0ytKIlchr1+BoiCPf87jDlQ9XmcZcEyE9X9yw?=
 =?us-ascii?Q?WE/cBTMBYq6Wcyc8l56eFf0ukNokQMRNl81RVLyYS6z1RKnwWpo60JfFPSVE?=
 =?us-ascii?Q?ac4nYpP7swDs7yMBOFtXfnkcU1y8G13Tb7oOu6QrCxASvuyiiN7Gggh7Id/I?=
 =?us-ascii?Q?Opw5e3YoG0ov07P9AWDfwykK7RikR9r6kwDIPBTSv50JaphqQ2PP76sUYHPE?=
 =?us-ascii?Q?B4RIXriWRIR8hevTRv1viJkWv2S/ai3NobUntuABQH3hEpW+d7aO1ZI9bGED?=
 =?us-ascii?Q?J37iTUDRtYHS7fbHqsUa/12baKukQy8aN9ltCwOvja6IRWEHMt6GzaNAvWx1?=
 =?us-ascii?Q?y8vAelVl7ZCxYsWi1pVRitgp61nBFg9snJcsTKheGaXTNdUGsyxSoPl+nv09?=
 =?us-ascii?Q?S9Rz40Hk6jMZ9ok00Ln2Pl1DiCiCABMY1ApuiKSYMtd7NJbjr5cd/t/e0rwv?=
 =?us-ascii?Q?tLGq3Ac/f03TzcVPmzmqMnDf3qf1Y9WlovSCnBbuCtCPRO5j7qUhbIRDDIyw?=
 =?us-ascii?Q?nsYIEvlyfanM/Okyg1RxCYy6oePAxikaD34PFoH7VjeuaYmO8DVmkWjRnqss?=
 =?us-ascii?Q?qRkb3ZtsXnBWuE7owEKkgaLr5TzW8XnDjLtqkhXnX5xlxAQFF4Zqm9z9zTJj?=
 =?us-ascii?Q?MF0bto6p5ptwImytq/8VqIB8mUSrSTgb7uOu0aRUCjHS64nGkIZk8smewwFf?=
 =?us-ascii?Q?Yaubds+NmcmuywjZWpZDtVlx39uF3dNeJfJOBgSUtne9MNzSFn095fUdU70U?=
 =?us-ascii?Q?eJB1v+DqhAMqF63pN/nQw1z2c7kZK9gldNvD5KuXqLk1746/Mtqxa0Cx3NIX?=
 =?us-ascii?Q?h4N5CBQ61Q6xdKW80tFyeoHFpR46FpdnmUh+pzUaFRAkfPBaIfMg7fTuIwDw?=
 =?us-ascii?Q?f3n3RtFXEhOGN4AonAPTwjKBQZHdpFVO6POKR1i1KphctVYjBQExNZcEsjLA?=
 =?us-ascii?Q?LAX80NAcSnPgBFqMyUue2jZpTcf255tmImDkJNWNer99/wEwBbpfORzTXo4R?=
 =?us-ascii?Q?6v2GupHm622bj14cRRrOaBfOQMxBdA3gI5zonQw4K22P84HoJD4p7654mJAT?=
 =?us-ascii?Q?GtaG6jY8hnpJmcnCI3b2dqqvCWPl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Er4dPozGjvpyZh8SOp/hbBrAwiQd08NaoBEoFXAhYbcPilPAeZVLzlxL9MPA?=
 =?us-ascii?Q?A7ir81QoNkmcQrZI/iffKHCHT0joBbkymksy0X810TFxFgcT3FMwnw5usX5j?=
 =?us-ascii?Q?XFIxvhYETQ4zvI1b0VHFHcFamsB+k+Dd+6NAOby9yOOppftfylmMylfH0Hwy?=
 =?us-ascii?Q?y92NT8SO19NpNqHkTj2pA6Pe/3E6OGGtr6+TPD8xmwBRc/Rwq+9yNJa4BgOZ?=
 =?us-ascii?Q?ZZ443t019VxezSSrHzAzdcR74jgBnG82BYWkgGVg3ZQ5gvtNNUTsccbe0dcj?=
 =?us-ascii?Q?BfPS2fj1EUj7P2kX3VQpJHxafGOPQrr63AVe1KA2tEaJux0vjrvxoKVyrdRL?=
 =?us-ascii?Q?nPZIYDGJ2AvErx856ZGrFWSisRv0MNujD+sLAPBXe/x1D1E2nyo1N3LcVJWq?=
 =?us-ascii?Q?qysjeSBoba5EvJYlAnKFhj82Ij+IS4VF/rx1KMEIcBfyVcl08PZL7XUWvrZB?=
 =?us-ascii?Q?PNB9v9ggEDhm6AwsU/KMWXKLu93MqNwr1MNGTdRuLEwZAUCafodhwq+wRJiA?=
 =?us-ascii?Q?lfhnS7fjY350kL1X0GYDVb+h2GCZDBRdI8bAneaA4P/d8JnKvLZLCk9EO0zK?=
 =?us-ascii?Q?6NlE3wvOiZEdVW74fIsxl8PQmo4bfHDeD1NgsSK5FvqLQfCoK1/lU/0iuRzN?=
 =?us-ascii?Q?9Td2WteFah/RXTpFu0xXJLfu2IL6DMmU1rYMQGMMXfkR80sGaNs5llG3ACT7?=
 =?us-ascii?Q?SqpbaANmLoNXx0hVJ781VHtBVXag4ffOOhbkZJSNfui1PRS+tM7P0ffZoWuE?=
 =?us-ascii?Q?DO0wpZB83vUPh/tHWA1iIjfdnh+z2rSqFofxUe4iSzbY6qrKfIvV7M4pR3cz?=
 =?us-ascii?Q?PEzkQFIMjgyjjFjWT0aXl//oBM6eXKQzoc5kQFjvccwkFEBe7ZoOa4cILkfK?=
 =?us-ascii?Q?lxcQpAhC4unAR1tnll9qqR2kFB5GFPe3+F9d1H4AwRet651lavjAa+qdpVob?=
 =?us-ascii?Q?j2StdDKl5+fFDFaNUzmDYGvU4LiRe76tH5yHLIcipRIPzJQX8ukNWa2nJUIb?=
 =?us-ascii?Q?+rq3DU56mVeMnrCzZ5sJjeAMF8QlQQJA/oy+b7V3HDcQu7+q18tKgMUgCYUS?=
 =?us-ascii?Q?nZgQf7DCjSqm0UZl8rcToivLT5ZdN0MuRr+yRIDBc1gKtdZsJMj014czzfAC?=
 =?us-ascii?Q?W890bKflCm3EKjnDLdp/cS3Y9DAJs5PpFavqD1VQBM3OpTp5PjKz/qvQDkmq?=
 =?us-ascii?Q?xT6KubyXJVU82RvD/VgmGsTLq6gn5WZtLOlAHDYmrpxIBi1nBzUEcqp7Bp9u?=
 =?us-ascii?Q?YJwfH2YqBJHXVNoHoz0/JulYq9UZGzxMhzprWi6zd5Ii188SWamNvC4jatde?=
 =?us-ascii?Q?R8VezCsD77hlfKOcsxRJLhqpVckzq64F7f08JR1WM4acjUfUaCSENjzt5iak?=
 =?us-ascii?Q?2b6Eh0Wx/FXyvJcEU5HJbgqm1VNYHoo4g3m0ifnTIHn8wctnJQWAn8aiq09z?=
 =?us-ascii?Q?kvn1vuaNF2im9hIYgQEWKpFtv7FcSoJKGvNmpYuDGWwuI9+k8gYb9mAWTkcJ?=
 =?us-ascii?Q?QVM+yqRbelFbA2FLhYTwqviGKuPhq5VSkOU5z5lJI8DsqSY3KdY/o5T3wcMB?=
 =?us-ascii?Q?CM6tN+FsZZiimlBTReSALl56nI52P7Dh1uipmwbYsX8DUUUT0TZ55ZQrWWrS?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5d1ca5-85e1-4ea0-9da7-08ddc43d14a6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:47:57.7257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: on7U+t2J7yjRP9VOzlmzywxABf7rOH6e6nOXNhe8mNTqeWoBqPItDPRSy3p9TOgYQNzneOmqRLlA/6OcoTAHuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6314
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/bpf/verifier.c:#do_misc_fixups" on:

commit: 0df1a55afa832f463f9ad68ddc5de92230f1bc8a ("bpf: Warn on internal verifier errors")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on fix commit 032547272eb0884470165e6a8fd73b80688e847f]

in testcase: boot

config: i386-randconfig-061-20250713
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------+------------+------------+
|                                                  | 26d0e53246 | 0df1a55afa |
+--------------------------------------------------+------------+------------+
| WARNING:at_kernel/bpf/verifier.c:#do_misc_fixups | 0          | 12         |
| EIP:do_misc_fixups                               | 0          | 12         |
+--------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507160818.68358831-lkp@intel.com


[    2.211140][    T1] ------------[ cut here ]------------
[    2.211550][    T1] verifier bug: not inlined functions bpf_probe_read_kernel#113 is missing func(1)
[ 2.212237][ T1] WARNING: CPU: 0 PID: 1 at kernel/bpf/verifier.c:22761 do_misc_fixups (kernel/bpf/verifier.c:22761 (discriminator 5)) 
[    2.212914][    T1] Modules linked in:
[    2.213195][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper Tainted: G                T   6.16.0-rc3-00236-g0df1a55afa83 #1 NONE  1dad33d35aae1f1fd176527507541458de5ac423
[    2.214260][    T1] Tainted: [T]=RANDSTRUCT
[ 2.214566][ T1] EIP: do_misc_fixups (kernel/bpf/verifier.c:22761 (discriminator 5)) 
[ 2.214935][ T1] Code: 89 bd fc fe ff ff b0 56 e9 bb ed ff ff 8b 5e 04 c6 05 fe 6c 42 c4 01 89 d8 e8 28 88 02 00 53 50 68 70 29 9e c3 e8 fc e7 ed ff <0f> 0b 83 c4 0c e9 ba fe ff ff 8b 85 ec fe ff ff 83 e8 19 83 f8 01
All code
========
   0:	89 bd fc fe ff ff    	mov    %edi,-0x104(%rbp)
   6:	b0 56                	mov    $0x56,%al
   8:	e9 bb ed ff ff       	jmp    0xffffffffffffedc8
   d:	8b 5e 04             	mov    0x4(%rsi),%ebx
  10:	c6 05 fe 6c 42 c4 01 	movb   $0x1,-0x3bbd9302(%rip)        # 0xffffffffc4426d15
  17:	89 d8                	mov    %ebx,%eax
  19:	e8 28 88 02 00       	call   0x28846
  1e:	53                   	push   %rbx
  1f:	50                   	push   %rax
  20:	68 70 29 9e c3       	push   $0xffffffffc39e2970
  25:	e8 fc e7 ed ff       	call   0xffffffffffede826
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	83 c4 0c             	add    $0xc,%esp
  2f:	e9 ba fe ff ff       	jmp    0xfffffffffffffeee
  34:	8b 85 ec fe ff ff    	mov    -0x114(%rbp),%eax
  3a:	83 e8 19             	sub    $0x19,%eax
  3d:	83 f8 01             	cmp    $0x1,%eax

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	83 c4 0c             	add    $0xc,%esp
   5:	e9 ba fe ff ff       	jmp    0xfffffffffffffec4
   a:	8b 85 ec fe ff ff    	mov    -0x114(%rbp),%eax
  10:	83 e8 19             	sub    $0x19,%eax
  13:	83 f8 01             	cmp    $0x1,%eax
[    2.216327][    T1] EAX: 00000050 EBX: 00000071 ECX: 00000000 EDX: 00000000
[    2.216830][    T1] ESI: ef95c058 EDI: ef95c000 EBP: c5d19bdc ESP: c5d19abc
[    2.217332][    T1] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010296
[    2.217883][    T1] CR0: 80050033 CR2: ffdaa000 CR3: 04568000 CR4: 000406d0
[    2.218388][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    2.218897][    T1] DR6: fffe0ff0 DR7: 00000400
[    2.219229][    T1] Call Trace:
[ 2.219463][ T1] ? lock_acquire (kernel/locking/lockdep.c:473 kernel/locking/lockdep.c:5873) 
[ 2.219792][ T1] ? lock_acquire (kernel/locking/lockdep.c:473 kernel/locking/lockdep.c:5873) 
[ 2.220118][ T1] ? find_held_lock (kernel/locking/lockdep.c:5353) 
[ 2.220449][ T1] ? free_to_partial_list+0x12b/0x1b0 
[ 2.220904][ T1] ? __lock_release+0x58/0x180 
[ 2.221290][ T1] ? verifier_remove_insns (kernel/bpf/verifier.c:20889) 
[ 2.221727][ T1] bpf_check (kernel/bpf/verifier.c:24658) 
[ 2.222043][ T1] bpf_prog_load (kernel/bpf/syscall.c:2972) 
[ 2.222379][ T1] __sys_bpf (kernel/bpf/syscall.c:5978) 
[ 2.222681][ T1] ? kern_sys_bpf (kernel/bpf/syscall.c:6116 kernel/bpf/syscall.c:6164) 
[ 2.223010][ T1] kern_sys_bpf (kernel/bpf/syscall.c:6116 kernel/bpf/syscall.c:6164) 
[ 2.223320][ T1] ? kern_sys_bpf (kernel/bpf/syscall.c:6116 kernel/bpf/syscall.c:6164) 
[ 2.223640][ T1] bpf_load_and_run+0x116/0x250 
[ 2.224068][ T1] ? __kmalloc_cache_noprof (mm/slub.c:4354) 
[ 2.224448][ T1] ? crypto_kfunc_init (kernel/bpf/preload/bpf_preload_kern.c:75) 
[ 2.225339][ T1] ? crypto_kfunc_init (kernel/bpf/preload/bpf_preload_kern.c:75) 
[ 2.225698][ T1] load_skel (kernel/bpf/preload/bpf_preload_kern.c:46) 
[ 2.225996][ T1] ? crypto_kfunc_init (kernel/bpf/preload/bpf_preload_kern.c:75) 
[ 2.226345][ T1] load (kernel/bpf/preload/bpf_preload_kern.c:79) 
[ 2.226596][ T1] do_one_initcall (init/main.c:1274) 
[ 2.226933][ T1] do_initcalls (init/main.c:1335 init/main.c:1352) 
[ 2.227254][ T1] ? rest_init (init/main.c:1466) 
[ 2.227555][ T1] kernel_init_freeable (init/main.c:1588) 
[ 2.227918][ T1] kernel_init (init/main.c:1476) 
[ 2.228224][ T1] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 2.228558][ T1] ? rest_init (init/main.c:1466) 
[ 2.228858][ T1] ? rest_init (init/main.c:1466) 
[ 2.229159][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 2.229528][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[    2.229864][    T1] irq event stamp: 1526545
[ 2.230176][ T1] hardirqs last enabled at (1526553): __up_console_sem (arch/x86/include/asm/irqflags.h:26 (discriminator 1) arch/x86/include/asm/irqflags.h:109 (discriminator 1) arch/x86/include/asm/irqflags.h:151 (discriminator 1) kernel/printk/printk.c:344 (discriminator 1)) 
[ 2.230809][ T1] hardirqs last disabled at (1526560): __up_console_sem (kernel/printk/printk.c:342 (discriminator 1)) 
[ 2.231440][ T1] softirqs last enabled at (1526510): handle_softirqs (kernel/softirq.c:426 kernel/softirq.c:607) 
[ 2.232094][ T1] softirqs last disabled at (1526499): __do_softirq (kernel/softirq.c:614) 
[    2.232689][    T1] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250716/202507160818.68358831-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


