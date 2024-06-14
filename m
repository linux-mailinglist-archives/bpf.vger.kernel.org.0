Return-Path: <bpf+bounces-32158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E33908211
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 04:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFDC284E7C
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 02:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABC4183099;
	Fri, 14 Jun 2024 02:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RdR9mjji"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD11A801;
	Fri, 14 Jun 2024 02:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718333643; cv=fail; b=PAgSDfAsutFsxvsHAaNdjfUaqyY/lNsLcoXDcSPm/bgVAxfwhbNAvU/LEXQDopKC8ZaB2oU49tsITe8readt8jHx5CiCJjup9Btwbht1nW9cGJ4xugxYXEl9b1rEDVMZibWkyPY5SxK5Tffflacx3gnpXmZar1Z+0rqtBMhe8k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718333643; c=relaxed/simple;
	bh=Cwr6fzwIyXe5v586QMF7xiVtHmcJgBVYlGt0HvTZh2g=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=KKtqj0vegoMu7ygwTYeNFf4vIrtlMSxxySr7XS2DLEzLCc1CN1v22x1xvHmo0kT/qQ/yy8KW9Iaa6NMCBK3ocMqZ8UTzAwCHGeRSUpE9iem6UdwtGRV++zkceAi8HvPq9KtiEJgsqYOHjudKLGX/AVqnt7GwCFISrHwFIPfGqE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RdR9mjji; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718333642; x=1749869642;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Cwr6fzwIyXe5v586QMF7xiVtHmcJgBVYlGt0HvTZh2g=;
  b=RdR9mjji0X6cywt2QLsMzoXc5qnOgpSR2kfC7E0l4i5KKVVsjG+Hi37v
   CEr6vMPA9dJH45WboeU6uIIkWwyv1wV38ob8u0B7+BxK0u8/bPOVgPZc3
   pINakbvYdMUp+VJ7x4HiME70rRI0NqIa9MPJAFNvSyHibExH5uaYep90M
   008bSKWxwC8GQukdds8IrKBHWQyT9cXcyxshrpyaw+Rgu+NdARCpqZw4u
   z1CzwYKyASchRkmeDerqol1KtYfYWyicey6Ytu0SEqd25OmmY8k2E3pre
   iF6ZEg0kfm4vQKMoFBGCz3rfIYgfJF5vVR9VZF/rpSQUBxdn5Y2XO5TvD
   Q==;
X-CSE-ConnectionGUID: cfIJQljyQDq3eIPPjS3jvQ==
X-CSE-MsgGUID: O8wwnGp7Qhmttal48qp1YA==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15363265"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="15363265"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 19:54:01 -0700
X-CSE-ConnectionGUID: 4tJMLEIRSUS8stKy/aMFgQ==
X-CSE-MsgGUID: yxEzdNFGRfyjPM0k661kxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="71139119"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 19:54:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 19:54:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 19:54:00 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 19:54:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJy9XuMsHKVwyz0STzTvR9u0ki5gp8n4N3p8NS6Y3ZK7KUj8/OGdO6f2Mhs20VnUOnpX0S+hdz5kgWwE3I3QpcXKZfVY9XwgAkjT4nTLfl91tQVkt28NMsBQV4WzXFxYLtSroGcWZJIJnzXDgY/lM2sd+K0b7AGEKWyxkG4wmjJi7dKvIspnL8CcQL/hESuqd6PwEx/DIiZfIuNqzz5TpEhRvhmUDRqL/o4Fee/g2GoyjjW6z7HPpKqK7mr2oeK3FrXqKpCLSEYEk18n1ydf29JdFdLCYdPtfccsf8mKEBERSxNmaxcZpHrdP6l8MsZrk4d8a9fOxNE1auhcCI8bgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzJpuZXH6TpQYJU/VM5dIh+M30LTENofQRDk6FA+Xb8=;
 b=apC1WRVxED79SGD5OB6eAGXjwGw75HVKzglOH+H54+7qXB0C7nJcySBZM9oYW4IwXNvfMIZcYuJd5feVuthsZhITrfWHz5laps8EZvu7HkAQoJvuJwdVebk1dDXR/V0CueP9ZyOYL6ptmI7TDPHBbuFELZD0hpRxxRpzNkEjzPPlaEMD4DMDvEOFK5thyBxDiTeZa+B7GvVu2s9WuyZeODRbOZz6gcEfu4prnd6vuKYM/OK4kBLtxPnTfavp8PStOztbYlNTUeWr4EVq2w15zV/DWSYy3xjJ2SrxGQ0iiGGJHyDyzJNwl2G24vlrjkXGH5aSvNbCkP+Wrwv4zHwmmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by IA1PR11MB6369.namprd11.prod.outlook.com (2603:10b6:208:3af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Fri, 14 Jun
 2024 02:53:52 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%5]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 02:53:52 +0000
Date: Fri, 14 Jun 2024 10:54:19 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: <ast@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<andrii@kernel.org>, <brho@google.com>, <lkp@intel.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: [Syzkaller & bisect] There is KASAN: slab-use-after-free Read in
 arena_vm_close in v6.10-rc3 kernel
Message-ID: <Zmuw29IhgyPNKnIM@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|IA1PR11MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f41bc3-4feb-4620-794b-08dc8c1d390f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4mAGdZn2fCYnvPyNOAdC0bKtXz/Fwp1uz+ldS+RDphy15jsl10tBAtT7cpRq?=
 =?us-ascii?Q?xcz3TnP9W1V3U6VC0+2EHNICjOA9APqAh7w3tvp77OXhb+vTK0cQMPJSgB6s?=
 =?us-ascii?Q?5JtoB2SN5C37EibpHeXOH74cyAbsfAKNZSgex8nGXDSic99y37ENyJ8XrEL4?=
 =?us-ascii?Q?TFbXqu4nXKad/8GShswFwSwd4wXHVFbNEHzFleXOn9Hh1mGjGzdCzO2hZ+eu?=
 =?us-ascii?Q?HhcKuHXt0srtHEK706h5luzr1Xi/7ul04vRhC+QxoQgM53TBEDLoYKpxeOtF?=
 =?us-ascii?Q?xe/794SLT3bQlXaLMc1302VsDApwYAWw8TdLJLALJosF7KEpvZIAgk/bXXAh?=
 =?us-ascii?Q?VzElAFxvAE6IY6fjubg0Mrxb1VJFs+tVZU2o6cK+rLWqbmdCR0Ba2n61XkP2?=
 =?us-ascii?Q?MVqOjV8tQzD8NLGcO89eOIEcYwAuKT55TkA6uPQfbX+oPtLQV3UkdzSKZ3Ow?=
 =?us-ascii?Q?GtgO9Pcu1MZC0aA3xgV7Oh9ZsXut70neZnOYh7s4YVuSX1RtkdNlI7tUqKRg?=
 =?us-ascii?Q?Q7ki2IGyMN7S7k8uC/UCTOsgadMCqHmFfh1aA/9elUciEayq+8tKcbI7n/bd?=
 =?us-ascii?Q?EfTwOqIhLEVUP+px0rkTPM8ma2DHxcDg5SAetBumRvcMLHbjVDlOzbNNMkgT?=
 =?us-ascii?Q?PiT3Bi/YY+OgsHVwZT87gJa6H3p5LnOcvlTGu3mU4KQCy+gGBJx+dWG6VEtV?=
 =?us-ascii?Q?Rw9tI5BiBDRv5Wz/bR2XupcbL6c0BpmbBhI9FafnNQSxetak8EgibdLKP+gj?=
 =?us-ascii?Q?j5S5BbgYBiFSt8mRNXJKZodc5KN7LRZmOoUoWsaPRtHLz4CmBGRtohpDSNZo?=
 =?us-ascii?Q?11Ll4Nku01AoO51Vg4oLqv2Kz7JA3ZwjaR74QtOz736EPudFUj77WEr8ePxD?=
 =?us-ascii?Q?g1ohazCeoAvLWUEZo9vo3a60C4DHGj9TKjnP8bvDBXPB/A7Z3+OV0KDqT7Tw?=
 =?us-ascii?Q?K+mKnlP0LMZHksT3yFEDUPSwRfnlFgP7AEHyF/tkapUGyNZSTjYCTo2yI24e?=
 =?us-ascii?Q?XazsW38WBLRuwz5ILPI5/2PKBJPiCTunxNZ0zvYSV5uRsaIDeubjqlFicVsQ?=
 =?us-ascii?Q?YpRmkml2dalibaZizuSAfgbA6cvX8ZaCIYJHMyH8AVR7+o/+QqOGD+aWhZnm?=
 =?us-ascii?Q?sFJYuRAHyxyj6cWnavxBrOMhz+Qxe8HCc5Pw+Vj9MyNZ9ZMMrQpCWg9h5bWj?=
 =?us-ascii?Q?wXf0+VtBczrcXY05POuKXzPwrmkf941ETjIRAbJNEEmXkITO0gr/RD9acq46?=
 =?us-ascii?Q?/qIEugWPRVOwGtC4E3d9xOTH1YfOp9nbqkHjCYLQ9g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W+rjLISqV0o65SDwGKPPNJUXSjuP4wjp19vQFwroSW7eZirKbJ6Xx7F6JqdC?=
 =?us-ascii?Q?k5cJUxui8QDCCIQMfPcoXQANqRztETe8eod9lTOHiE+RfwpVB0ptPKKSLg6r?=
 =?us-ascii?Q?OGy1GPTqrud4TbltS7NR1zq3eEgtmKeYTGxGwXZQtZgVD8fHedw24jP1/GKp?=
 =?us-ascii?Q?EIsHmblwTh60sURdsJIYZ/rd0QNUmiJzhlZNXrSefJdoWOUkTHkDb5IDCOab?=
 =?us-ascii?Q?VZ9uw4a6IpeqmenNHZqZ3R6XHiGdQ8i78srca4z7RJGBvhJ/eW5m/RPDHEWB?=
 =?us-ascii?Q?NqU113rj9/UYoyNv0v9NbpnyZcOtaqFEaIqnhIayXu2oM98wuRE+WZRl839r?=
 =?us-ascii?Q?efLuHGQ4I3eY4Q1CZRFq4WXYrUUy+Y6UjInBY0zLE/hFFGff0ubut2lg7dM7?=
 =?us-ascii?Q?yJnF57oe+++7wbxpf74ZNXwy4zulFViN+VnoZjBdegmlG0c6/5CDWGOuUIyf?=
 =?us-ascii?Q?LbLo/YwhRmfwACixMXjL3D7bgzQNVnq8wkVizajuFk5zJZq2xmJ8LdHvKUCW?=
 =?us-ascii?Q?6W0j+u2Q8JKAoyGJb62SfHlAU7XjI929LEedqQiJh8c6RXVPxcdFBoB35nuU?=
 =?us-ascii?Q?9V3T9QQ3saokseQ+0fyCoW+wRAo3xAskanLg5SK14hxALToWUhJGuWpBNuIc?=
 =?us-ascii?Q?ykq49OLjdhV1+Yo3JGIpaY5gKK3pLaq9KzqAQn8dRZOdst2OjB7wtrduz4GP?=
 =?us-ascii?Q?ka+HGdyQ/25A83mRmGJ0tRAqK9rU4SohPZs1pSvbzLZ0QxH19Y/fpmxI9zPp?=
 =?us-ascii?Q?jI+d/JE0E4SvIOy7jeqHvnVUmSFdgXMqNW23LFzYYQFIiQyxkC7T8VqYmci4?=
 =?us-ascii?Q?0nyfTPI61wPhW0eNAXWWL7J5G7/lnG2Dh7t44Onyfbw0ScCR8V6gTygvtJU+?=
 =?us-ascii?Q?HmCHdrcdz9j8ZSGWODnY1j9ZNyaKIHnm03cuk+BhZlBXkkSoLrTpmdxjzv+S?=
 =?us-ascii?Q?NuJd4BTQd5eKP0qfCsV5lurlKzvspFm7u182fZw29cCN+/HD46X7tqzWU9lg?=
 =?us-ascii?Q?OPQHR3eSPOoBxqpPgpij1Y+ZBR8OKNh2QFYCcjPG+tLr3tPWzbt5OaCb4Xcp?=
 =?us-ascii?Q?oHB/gc45qyQx7Lcq8sGRO2EtFpJXWc8hvq8bR4/WFwqgLbNHIp6L2PDTgkXQ?=
 =?us-ascii?Q?dYfge64+Kufu6k8NjSjvgqsevSKUK1wHvK7KJ8ZUiBaJCHP4ydhWor873mty?=
 =?us-ascii?Q?mSlIMttdydOen6rPyguIF/sbRInvbkB5bmv4/Bub7M6eTvk65vm+3g4EBXG7?=
 =?us-ascii?Q?sjJfoLhifBThhc3Ds3WffOfZOlK11tJ7A/XRZU/Fv5nnR6Fj45MlPzTrsCQJ?=
 =?us-ascii?Q?b/wbbY0TXTsISJaRKSPuY8Eakv309cj5ZTRanw0UK7ExkKeF/uJgU+MHibNE?=
 =?us-ascii?Q?M5FhpnseGSPoCThkJU3CFh0VXG5uulkecrbAd943jzdNOm+oq6VwrsR9SUia?=
 =?us-ascii?Q?2k61Fmyau4N13QXVx74DzFo0R66mSbayhozZ+qsb9ed9A+ythiG7wrxx/aIF?=
 =?us-ascii?Q?cmmZqwMCI5qJnrTGHRpUnthbd0sl3ue74Byk1ywZN2RUPvrRx1JylwcC/+63?=
 =?us-ascii?Q?BHCM0HwW46D63hmNLjn0TuCVl3vijrErFmytGl9M?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f41bc3-4feb-4620-794b-08dc8c1d390f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 02:53:51.9872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45UQTJWCCzxMK4TSlO0J1k654QIYOgEuyYCjsUeGMoUlfHwzcvsFqJlA0a3kC3T8QwaAR8bZbWG1Opodea0d8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6369
X-OriginatorOrg: intel.com

Hi Alexei Starovoitov and bpf expert,

Greeting!

There is KASAN: slab-use-after-free Read in arena_vm_close in v6.10-rc3 kernel.

All detailed info:https://github.com/xupengfe/syzkaller_logs/tree/main/240613_011057_arena_vm_close
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240613_011057_arena_vm_close/repro.c
Syzkaller syscall repro steps:https://github.com/xupengfe/syzkaller_logs/blob/main/240613_011057_arena_vm_close/repro.prog
Syzkaller report: https://github.com/xupengfe/syzkaller_logs/blob/main/240613_011057_arena_vm_close/repro.report
Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240613_011057_arena_vm_close/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240613_011057_arena_vm_close/bisect_info.log
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240613_011057_arena_vm_close/83a7eefedc9b56fe7bfeff13b6c7356688ffa670_dmesg.log
v6.10-rc3 bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240613_011057_arena_vm_close/bzImage_83a7eefedc9b56fe7bfeff13b6c7356688ffa670.tar.gz

Bisected and found the first bad commit:
317460317a02 bpf: Introduce bpf_arena.

[   25.142953] ==================================================================
[   25.143738] BUG: KASAN: slab-use-after-free in arena_vm_close+0x1b1/0x1d0
[   25.144474] Read of size 8 at addr ffff88800d3c93c8 by task repro/728
[   25.145091] 
[   25.145266] CPU: 0 PID: 728 Comm: repro Not tainted 6.10.0-rc3-83a7eefedc9b #1
[   25.145942] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   25.147003] Call Trace:
[   25.147256]  <TASK>
[   25.147482]  dump_stack_lvl+0xea/0x150
[   25.147883]  print_report+0xce/0x610
[   25.148267]  ? arena_vm_close+0x1b1/0x1d0
[   25.148668]  ? kasan_complete_mode_report_info+0x80/0x200
[   25.149168]  ? arena_vm_close+0x1b1/0x1d0
[   25.149555]  kasan_report+0xcc/0x110
[   25.149904]  ? arena_vm_close+0x1b1/0x1d0
[   25.150246]  __asan_report_load8_noabort+0x18/0x20
[   25.150616]  arena_vm_close+0x1b1/0x1d0
[   25.150922]  ? __pfx_arena_vm_close+0x10/0x10
[   25.151266]  remove_vma+0x95/0x190
[   25.151552]  exit_mmap+0x4bf/0xb00
[   25.151834]  ? __pfx_exit_mmap+0x10/0x10
[   25.152110]  ? __kasan_check_write+0x18/0x20
[   25.152405]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
[   25.152768]  ? mutex_unlock+0x16/0x20
[   25.153024]  __mmput+0xde/0x3e0
[   25.153262]  mmput+0x74/0x90
[   25.153471]  do_exit+0x9fb/0x29f0
[   25.153705]  ? lock_release+0x418/0x840
[   25.153983]  ? __pfx_do_exit+0x10/0x10
[   25.154239]  ? __this_cpu_preempt_check+0x21/0x30
[   25.154561]  ? _raw_spin_unlock_irq+0x2c/0x60
[   25.154858]  ? lockdep_hardirqs_on+0x89/0x110
[   25.155157]  do_group_exit+0xe4/0x2c0
[   25.155413]  __x64_sys_exit_group+0x4d/0x60
[   25.155697]  x64_sys_call+0x1a1f/0x20d0
[   25.155965]  do_syscall_64+0x6d/0x140
[   25.156220]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   25.156566] RIP: 0033:0x7f1343d18a4d
[   25.156817] Code: Unable to access opcode bytes at 0x7f1343d18a23.
[   25.157221] RSP: 002b:00007ffdc66dc268 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   25.157713] RAX: ffffffffffffffda RBX: 00007f1343df69e0 RCX: 00007f1343d18a4d
[   25.158174] RDX: 00000000000000e7 RSI: ffffffffffffff80 RDI: 0000000000000000
[   25.158634] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000020
[   25.159092] R10: 00007ffdc66dc110 R11: 0000000000000246 R12: 00007f1343df69e0
[   25.159557] R13: 00007f1343dfbf00 R14: 0000000000000001 R15: 00007f1343dfbee8
[   25.160023]  </TASK>
[   25.160176] 
[   25.160287] Allocated by task 728:
[   25.160519]  kasan_save_stack+0x2c/0x60
[   25.160782]  kasan_save_track+0x18/0x40
[   25.161043]  kasan_save_alloc_info+0x3c/0x50
[   25.161330]  __kasan_kmalloc+0x88/0xa0
[   25.161588]  kmalloc_trace_noprof+0x1b9/0x3c0
[   25.161891]  arena_map_mmap+0x232/0x7a0
[   25.162156]  bpf_map_mmap+0x4b5/0x9a0
[   25.162412]  mmap_region+0x5f7/0x2740
[   25.162666]  do_mmap+0xd6a/0x11a0
[   25.162898]  vm_mmap_pgoff+0x1ea/0x390
[   25.163155]  ksys_mmap_pgoff+0x3e8/0x530
[   25.163425]  __x64_sys_mmap+0x139/0x1d0
[   25.163691]  x64_sys_call+0x1922/0x20d0
[   25.163950]  do_syscall_64+0x6d/0x140
[   25.164200]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   25.164534] 
[   25.164647] Freed by task 728:
[   25.164854]  kasan_save_stack+0x2c/0x60
[   25.165118]  kasan_save_track+0x18/0x40
[   25.165389]  kasan_save_free_info+0x3f/0x60
[   25.165668]  __kasan_slab_free+0x115/0x1a0
[   25.165946]  kfree+0xfe/0x330
[   25.166157]  arena_vm_close+0x15e/0x1d0
[   25.166420]  remove_vma+0x95/0x190
[   25.166654]  do_vmi_align_munmap+0xc02/0x11f0
[   25.166949]  do_vmi_munmap+0x22c/0x420
[   25.167206]  __do_sys_mremap+0x7db/0x1830
[   25.167481]  __x64_sys_mremap+0xc7/0x150
[   25.167755]  x64_sys_call+0x1c50/0x20d0
[   25.168014]  do_syscall_64+0x6d/0x140
[   25.168265]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   25.168601] 
[   25.168712] The buggy address belongs to the object at ffff88800d3c93c0
[   25.168712]  which belongs to the cache kmalloc-32 of size 32
[   25.169492] The buggy address is located 8 bytes inside of
[   25.169492]  freed 32-byte region [ffff88800d3c93c0, ffff88800d3c93e0)
[   25.170253] 
[   25.170366] The buggy address belongs to the physical page:
[   25.170726] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xd3c9
[   25.171234] flags: 0xfffffc0000000(node=0|zone=1|lastcpupid=0x1fffff)
[   25.171656] page_type: 0xffffefff(slab)
[   25.171923] raw: 000fffffc0000000 ffff88800a041780 ffffea000028cc40 dead000000000002
[   25.172421] raw: 0000000000000000 0000000080400040 00000001ffffefff 0000000000000000
[   25.172914] page dumped because: kasan: bad access detected
[   25.173273] 
[   25.173383] Memory state around the buggy address:
[   25.173697]  ffff88800d3c9280: 00 00 00 fc fc fc fc fc 00 00 00 fc fc fc fc fc
[   25.174162]  ffff88800d3c9300: fa fb fb fb fc fc fc fc 00 00 01 fc fc fc fc fc
[   25.174628] >ffff88800d3c9380: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
[   25.175092]                                               ^
[   25.175456]  ffff88800d3c9400: 00 00 00 fc fc fc fc fc 00 00 04 fc fc fc fc fc
[   25.175921]  ffff88800d3c9480: 00 00 01 fc fc fc fc fc 00 00 07 fc fc fc fc fc
[   25.176393] ==================================================================
[   25.177020] Disabling lock debugging due to kernel taint
[   25.177414] Oops: general protection fault, probably for non-canonical address 0xe095fc1e8000005c: 0000 [#1] PREEMPT SMP KASAN NOPTI
[   25.178167] KASAN: maybe wild-memory-access in range [0x04b000f4000002e0-0x04b000f4000002e7]

I hope it's helpful.

Thanks!

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!

