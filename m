Return-Path: <bpf+bounces-37015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B389A9503BC
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 13:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D088B229A5
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 11:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A531991D8;
	Tue, 13 Aug 2024 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KgIJJH5n"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4736F1990C7;
	Tue, 13 Aug 2024 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548740; cv=fail; b=LqnIDjY0BVbXjtcB1hX0D6l5IbLUYO+lBA57SBJGVQZYwp2gUTB61gJJyNxRTFHjauskjiYQqbTZwv263JBxzhRqSwXyWGdNSyhVEmjCGi1WUNRzpSxolWiKoG+LkOymphHIKaZj2b7xuB96BYwAMEqKqAEOwCR+vFEfSn6KWjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548740; c=relaxed/simple;
	bh=qgXvjQ920Rd/N9kr7hcc5NdzY7h0Elwt47iyHz/Mx+M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=flaqOu3M3UQGF6F0PQOTntiG6VPqTve3ccDFQQqUpH8+/GFTrgD1M7O4SH/babx8xnsrLUp+xjDMhLCHVZkccPCASZ07eIc9vbCO1NHCxt9Zo16BsmoxaEx2hP/kr8wM7hg4Aa6yYFS1Ll6qphi7tmKlCMinlLGm8e5wQiUZfBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KgIJJH5n; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723548738; x=1755084738;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qgXvjQ920Rd/N9kr7hcc5NdzY7h0Elwt47iyHz/Mx+M=;
  b=KgIJJH5ng5Sxhm5U8o8sHhiz2qEmcfnnhoEB9i7LjrNzzZIL2gi+2UAJ
   lUedIznH94lNOTu4s9QksU3v+XiKld33IBqbo8LnsThp6UIJR4ckhMmLv
   3ah0fDqzrW2+8f2lL799p05ZnGtI3ZBjQb6gnW0THiawsP6I2B6H9K22x
   OuFiBR2pY6GT6EQphh+/zEECju+DZdZyrMDmfJapJo37V72xFlLkNYVSL
   O4wF+6WebiBh7X33RD7EmPCpeqxgk/mKqwiybWWGGbxH5NxUBR65CC/Nz
   vjQMxt0UwHFys1hfdpsuML5m4N/93Ocgju+1x7zgogU+rodtdjgVAO2Bi
   Q==;
X-CSE-ConnectionGUID: eTr/PoTRSHa4I4gpWrvwag==
X-CSE-MsgGUID: Hj2jFWStRaWk0XAy4tzLqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21873552"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21873552"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:32:16 -0700
X-CSE-ConnectionGUID: MiMOdURjRlOxvdCBFi1iNA==
X-CSE-MsgGUID: +KU7AP2sSaKh5Q7VzTt0XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="59208959"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 04:32:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 04:32:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 04:32:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 04:32:14 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 04:32:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ES0XdC4HasWLOG1UhW//+fTu7A/YfVVo7qsfZjr9OGYD/vtg99EoNI6QoalwbaLov9pRSToksMvGaoiew7P4sfH5OC3rpqNbmE4ekMXFLhcaoNod9VhJ3B6GJ286raO7EMzeIKqfrN3g+PMDoAFrLYzpAUBecg439uo/GLm5Ya+7dSaZhrRA1LfGZZhdztLeTvulHeSzbqElOgT+6JmOcUqAyv1IFlsHGfZkmLsbwnqjgew/y/9v4x3BT3lOC29cBl2wgH6U+4T90YC6e5/9tRqwEBYJHhuDB/XUZSDUN3kJxc2jgnpFm/2/pKiqBTKnpPveocB/vKBvLpJ9KDtMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWhXb5zgsYPs14vsbGtc8EIHmhyNEDuCyQW0obv088k=;
 b=feZKIOc0HfpcPwsRRIpMJL3ea+cw0lHBCd+PUoKfKoKKqlx2gswAfT9wJzMyKWqotUxIbiD8ut57KvbwgWlpm2md+51KqcXF4JD/gW7ieggtxj7Hmo/4INaaWfTQDAAktgz7xXrtA9VXExjbAXG4E8L2h6KqcTGrmD6fuKaAn4To2hKt96LO2ShkTagJdKd4fKPLjgBnregwUbgn19OxRgjBhl6wQ4V+gxPxca2TcX5D5aQuf8aBE7T0KZyKEvXR7R/bndECmItdL0qGAvlacvRqD7gl1pgbsjV7fsSRnew6jN4qoa4e+prGGKnVEGNj2dp/FBml8MvDrvbjv4Y9SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB7412.namprd11.prod.outlook.com (2603:10b6:8:152::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.32; Tue, 13 Aug 2024 11:32:12 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7828.023; Tue, 13 Aug 2024
 11:32:11 +0000
Date: Tue, 13 Aug 2024 13:31:57 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Jacob
 Keller" <jacob.e.keller@intel.com>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <magnus.karlsson@intel.com>, Michal Kubiak
	<michal.kubiak@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>
Subject: Re: [PATCH iwl-net v2 2/6] ice: protect XDP configuration with a
 mutex
Message-ID: <ZrtELQV3zZENOvn+@boxer>
References: <20240724164840.2536605-1-larysa.zaremba@intel.com>
 <20240724164840.2536605-3-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240724164840.2536605-3-larysa.zaremba@intel.com>
X-ClientProxiedBy: MI1P293CA0021.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 204facf3-fbde-4659-e63b-08dcbb8b92ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cCFs0LcxfgkgzpQLFNSVwX458aU1/RCWQWAEqQ3YiCq/YwLbzshRfwcwTeje?=
 =?us-ascii?Q?jpT9Tls2iUBu5sAf5n5tUrSt8L5aVFUWPu32Pw/tgv654fSgSoblDnLTvrEs?=
 =?us-ascii?Q?YqO40brkYC1EKdb21fuQc8L2srcdLUSvfoxQJ8NhG2IxRqyffZOfa+mtg0gk?=
 =?us-ascii?Q?gEnlq4ld/bkl16asOr6iZeDKk62BGg9iukLu9XHs/ptMUxB9hZ7Of45+NQry?=
 =?us-ascii?Q?/U0q6BtAMw7GkUz0vl37SOI7oLAghJadnWj0pusKDdLPrdfQginVuWIicAg6?=
 =?us-ascii?Q?kvfKAwHyKT68OyARa3/LGzS9AEqs3o4tqXfDE2YOYPC/5vu1N7fNoOfZgirU?=
 =?us-ascii?Q?revlih40NrAmqzABBYmnMc4UpSxhswzoYGjgU+gcEXhkBK4GwwCZZc5gLDOC?=
 =?us-ascii?Q?p2a70hcIyuPBktQIutjQ7SjUEFn3SWjFWa5Wy1qzUx3vHQ26LZNt44cLHjk5?=
 =?us-ascii?Q?UqjvwL5HUM5hjAN0yY6MZw8FsQZLoGIHozciGK9SrPM82rbRKTZkYqYaFc/f?=
 =?us-ascii?Q?l5balBNtktLCrsI8oJR0CJlgoVt8jzL4BBicbhv9CJeXLKjL0i04AEMc6hpw?=
 =?us-ascii?Q?isctHcRKjToVD0NATj42BS1SGTP4QfTPGlcKO3gSiQ0D4rZfySoKyaQin4wt?=
 =?us-ascii?Q?0nNooybIJ89CmGZD0A5xrysSWztNSeylQD0WSP1nt8c+dV+FtlcZ/A18TQKt?=
 =?us-ascii?Q?TmdQZUcZOkyoJcT83orSmDGEa0cM5B1R34svvqS2uEz/aFYpmfkv7cyoR2oF?=
 =?us-ascii?Q?SaR+xknkDTlWKh7Frj5glTiJkDijb8erymUrSsyQhevYfnyAyWfexceOPlcx?=
 =?us-ascii?Q?SnRjC+9x3SLQhCCsAzroVOZ5ercvuTuTO9M3WMr1HALrlP5qjdk2gIKXMfQz?=
 =?us-ascii?Q?ncSGpA0TNaR7fRcWVNNYrZEvKF7TrBrFQ8EUdLs+SiFTTJE9FVtfvmMU/Zht?=
 =?us-ascii?Q?i47TQdrUrsD917tUukgHTWs4sJn5ybWotBT8/q9U7f3TfAZlLzVgoABlZeAm?=
 =?us-ascii?Q?SiHi/vPrDQ5rYvAQtM9kNAA3DSPNVoqxmlgjkhcYT99V4770/io0HOzWtyE/?=
 =?us-ascii?Q?d8hIvvsXbmfz1sU84mNRpJzUuPfzL2qCRTY4k9LydJqS/CIPNTRSD2Wc5Q45?=
 =?us-ascii?Q?lomckq+TGJpaMvC8qY5gMtFcC7Mm/LHmZjOOOMf32DUYAbKCimlnC9Tenai+?=
 =?us-ascii?Q?2NsvmiFNICItm2Kq7dhzegxSN/XnbRfxe8u1XAvHQ7LDjsbhjGpm+E3rCyrL?=
 =?us-ascii?Q?Y7SqqFdMTLMmL+Sa03bTfDI0/xc2KsPg/qTM7iPDIqV/gf5KP+OGm78HZd1B?=
 =?us-ascii?Q?kNkNVDGsq95z681EWpPhofdMgSS1y5ny6zH1inTKtpOxBA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bnc5VtJfPntqVFaKRz4rPQZY39HpDajck7q4MNc5RGCuTWDuL/48sEmj5gtv?=
 =?us-ascii?Q?LTWvpvtkopYeyinpU2F4si229vNHuHbV7i87bOZ324LbDtfMNN3Afx2VFfg8?=
 =?us-ascii?Q?9Z2ot/90XXZty7NCGAQ14nuMi8razwLW+PBAT0fydSvM6Z/WcxupMkMzUKW0?=
 =?us-ascii?Q?CvxYxnhvphDvo1gAVb/Vlw0vzlF35xQFxZhaMj6P4aulmF9IqwVeaS1BsVUv?=
 =?us-ascii?Q?E66LPKPnop7Ge9nuxtIgsUmw+kleFHQ+4IevXzIZI8+Gm+THwsez/hNB8DfX?=
 =?us-ascii?Q?7Mur4UgfF+D/CLChczuME0+FyXQPCtH715jiyl5654WJlxyYjz5zCJpKJSJp?=
 =?us-ascii?Q?puUb1NznxsVPfBZiK81HhpoK8NwM/4WjzjfkSS1PYXsU5OKt3j3kEBpLrsQg?=
 =?us-ascii?Q?zFoM16Gma96BuVnab10iIFY5SmlkFvXvX2efu03j1sqBfxbiqFKT/CuNa40j?=
 =?us-ascii?Q?ykdO9udz03V0ePaSPomveTCS++q4SCWHWdxf9WmP23O5BEA3cRa99IxjaOVN?=
 =?us-ascii?Q?d0taD6fm+/qpiJBwDAWySzFqL6IAwicf4XF72CUcS0XBSV+KOaPaanVHSUoi?=
 =?us-ascii?Q?6+QtLz+I903Zf+p7fc4f1UlqaQ9NeYvW9Xy4nsyfWUD2wdCa5BqG/aEzG9CY?=
 =?us-ascii?Q?W6BLtOmwyCQfoo5JIUU9rig5wL4e/1lyZu4GLa+koiEAX9Pm3E2UGSb+uT1H?=
 =?us-ascii?Q?O/9Q/5lo4oZ+Q4uMYquBUhhGVP8A/JDMF9joJuEpZg4gDoggVWrV8dusr4af?=
 =?us-ascii?Q?EMNSv8uKk8EvT9T4rtCaaEO8x7/4iAR07EQdt1rxyAnCX/7+FqA5UvqmLtRC?=
 =?us-ascii?Q?Hj48OAPCHsvtwi6R0xO2ks7RZN9XMygKp/E3YzQzynYmA9R3hgBm/p+tBueh?=
 =?us-ascii?Q?GOc6iQcY4pYjbeOVPr+jUllrvzcmv69Lz4dB5XZ6IlsTFmp5Xlox8HgSyfwe?=
 =?us-ascii?Q?fkenFmZdXk/z+CceG7Yd0rdYPtWLESMQa04RTyPUuvPcGudx09FkKkHVoJ8g?=
 =?us-ascii?Q?PI0LzIk3FPhvJ40pG3zwKPC5yeWhbWaIYU+JrSjAhGbnheRpV3QsFTs3YD+1?=
 =?us-ascii?Q?QmFNoF9ZAntsC4K8Yaeslc/x8sa4fJzQxdj7QC36nAuMXEJ/oUdl9a7ZIsJ2?=
 =?us-ascii?Q?VFYNOnzT0Htqb17vphbYB2tCeMIN5uufvC5cDcMfupk14xcNtvMtRGQ1rteG?=
 =?us-ascii?Q?UAv/w55lcuXMFvi9pf5RGG71oxg88T+ssqtp4pcH8Nl6ivuPtg9v+fVLX4lB?=
 =?us-ascii?Q?CeHremrgMhwm8dqFxV91d8i7ORgnTqghIVVUxCS+QLtxwNgX0qtmXC4PU5Mb?=
 =?us-ascii?Q?/ECTo4M94Y6AXce2ppsXMbBhHVpipfm/OjjdpP6G9SPNMVAxOwJ5BnnPz4TP?=
 =?us-ascii?Q?DnJRH3ILmtUHGLRfKpuMrOTI7hlZL1J01isrANBGDBfmyN5YCh26cUVKzS+P?=
 =?us-ascii?Q?dJX3v20FIm+IObQiRRcN/QgJBZMvMArSsc1yWUQ2DPVWsZsGyXshMa5y3H/v?=
 =?us-ascii?Q?DuY5LbeuL9gh2CHhqmKEp3WfZw8nnM+rqAUaC2ji6bCP2SSxzUKN0yAzpjZt?=
 =?us-ascii?Q?nfC9tz/NtLRIxOw8p9GQDmtJ79eLnpegPjb0XLWAVKfbuo0rFjgi2YYvhSrl?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 204facf3-fbde-4659-e63b-08dcbb8b92ad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 11:32:11.7946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipSMOl+nyBE0dk54ndE/LzIoDcE/nwTzofCZe3IYfW99lTIfE2ujyM7NbTVrBCMhcMv2rL2qHk1DWzDymA3IVi5yDdIgAiJJBbD2fp8025Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7412
X-OriginatorOrg: intel.com

On Wed, Jul 24, 2024 at 06:48:33PM +0200, Larysa Zaremba wrote:
> The main threat to data consistency in ice_xdp() is a possible asynchronous
> PF reset. It can be triggered by a user or by TX timeout handler.
> 
> XDP setup and PF reset code access the same resources in the following
> sections:
> * ice_vsi_close() in ice_prepare_for_reset() - already rtnl-locked
> * ice_vsi_rebuild() for the PF VSI - not protected
> * ice_vsi_open() - already rtnl-locked
> 
> With an unfortunate timing, such accesses can result in a crash such as the
> one below:
> 
> [ +1.999878] ice 0000:b1:00.0: Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring 14
> [ +2.002992] ice 0000:b1:00.0: Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring 18
> [Mar15 18:17] ice 0000:b1:00.0 ens801f0np0: NETDEV WATCHDOG: CPU: 38: transmit queue 14 timed out 80692736 ms
> [ +0.000093] ice 0000:b1:00.0 ens801f0np0: tx_timeout: VSI_num: 6, Q 14, NTC: 0x0, HW_HEAD: 0x0, NTU: 0x0, INT: 0x4000001
> [ +0.000012] ice 0000:b1:00.0 ens801f0np0: tx_timeout recovery level 1, txqueue 14
> [ +0.394718] ice 0000:b1:00.0: PTP reset successful
> [ +0.006184] BUG: kernel NULL pointer dereference, address: 0000000000000098
> [ +0.000045] #PF: supervisor read access in kernel mode
> [ +0.000023] #PF: error_code(0x0000) - not-present page
> [ +0.000023] PGD 0 P4D 0
> [ +0.000018] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [ +0.000023] CPU: 38 PID: 7540 Comm: kworker/38:1 Not tainted 6.8.0-rc7 #1
> [ +0.000031] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0014.082620210524 08/26/2021
> [ +0.000036] Workqueue: ice ice_service_task [ice]
> [ +0.000183] RIP: 0010:ice_clean_tx_ring+0xa/0xd0 [ice]
> [...]
> [ +0.000013] Call Trace:
> [ +0.000016] <TASK>
> [ +0.000014] ? __die+0x1f/0x70
> [ +0.000029] ? page_fault_oops+0x171/0x4f0
> [ +0.000029] ? schedule+0x3b/0xd0
> [ +0.000027] ? exc_page_fault+0x7b/0x180
> [ +0.000022] ? asm_exc_page_fault+0x22/0x30
> [ +0.000031] ? ice_clean_tx_ring+0xa/0xd0 [ice]
> [ +0.000194] ice_free_tx_ring+0xe/0x60 [ice]
> [ +0.000186] ice_destroy_xdp_rings+0x157/0x310 [ice]
> [ +0.000151] ice_vsi_decfg+0x53/0xe0 [ice]
> [ +0.000180] ice_vsi_rebuild+0x239/0x540 [ice]
> [ +0.000186] ice_vsi_rebuild_by_type+0x76/0x180 [ice]
> [ +0.000145] ice_rebuild+0x18c/0x840 [ice]
> [ +0.000145] ? delay_tsc+0x4a/0xc0
> [ +0.000022] ? delay_tsc+0x92/0xc0
> [ +0.000020] ice_do_reset+0x140/0x180 [ice]
> [ +0.000886] ice_service_task+0x404/0x1030 [ice]
> [ +0.000824] process_one_work+0x171/0x340
> [ +0.000685] worker_thread+0x277/0x3a0
> [ +0.000675] ? preempt_count_add+0x6a/0xa0
> [ +0.000677] ? _raw_spin_lock_irqsave+0x23/0x50
> [ +0.000679] ? __pfx_worker_thread+0x10/0x10
> [ +0.000653] kthread+0xf0/0x120
> [ +0.000635] ? __pfx_kthread+0x10/0x10
> [ +0.000616] ret_from_fork+0x2d/0x50
> [ +0.000612] ? __pfx_kthread+0x10/0x10
> [ +0.000604] ret_from_fork_asm+0x1b/0x30
> [ +0.000604] </TASK>
> 
> The previous way of handling this through returning -EBUSY is not viable,
> particularly when destroying AF_XDP socket, because the kernel proceeds
> with removal anyway.
> 
> There is plenty of code between those calls and there is no need to create
> a large critical section that covers all of them, same as there is no need
> to protect ice_vsi_rebuild() with rtnl_lock().
> 
> Add xdp_state_lock mutex to protect ice_vsi_rebuild() and ice_xdp().
> 
> Leaving unprotected sections in between would result in two states that
> have to be considered:
> 1. when the VSI is closed, but not yet rebuild
> 2. when VSI is already rebuild, but not yet open
> 
> The latter case is actually already handled through !netif_running() case,
> we just need to adjust flag checking a little. The former one is not as
> trivial, because between ice_vsi_close() and ice_vsi_rebuild(), a lot of
> hardware interaction happens, this can make adding/deleting rings exit
> with an error. Luckily, VSI rebuild is pending and can apply new
> configuration for us in a managed fashion.
> 
> Therefore, add an additional VSI state flag ICE_VSI_REBUILD_PENDING to
> indicate that ice_xdp() can just hot-swap the program.

couldn't this be a separate patch?

> 
> Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
> Fixes: efc2214b6047 ("ice: Add support for XDP")
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      |  2 ++
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 26 +++++++++++++++--------
>  drivers/net/ethernet/intel/ice/ice_main.c | 19 ++++++++++++-----
>  drivers/net/ethernet/intel/ice/ice_xsk.c  |  3 ++-
>  4 files changed, 35 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 99a75a59078e..3d7a0abc13ab 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -318,6 +318,7 @@ enum ice_vsi_state {
>  	ICE_VSI_UMAC_FLTR_CHANGED,
>  	ICE_VSI_MMAC_FLTR_CHANGED,
>  	ICE_VSI_PROMISC_CHANGED,
> +	ICE_VSI_REBUILD_PENDING,
>  	ICE_VSI_STATE_NBITS		/* must be last */
>  };
>  
> @@ -411,6 +412,7 @@ struct ice_vsi {
>  	struct ice_tx_ring **xdp_rings;	 /* XDP ring array */
>  	u16 num_xdp_txq;		 /* Used XDP queues */
>  	u8 xdp_mapping_mode;		 /* ICE_MAP_MODE_[CONTIG|SCATTER] */
> +	struct mutex xdp_state_lock;
>  
>  	struct net_device **target_netdevs;
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 5f2ddcaf7031..bbef5ec67cae 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -447,6 +447,7 @@ static void ice_vsi_free(struct ice_vsi *vsi)
>  
>  	ice_vsi_free_stats(vsi);
>  	ice_vsi_free_arrays(vsi);
> +	mutex_destroy(&vsi->xdp_state_lock);
>  	mutex_unlock(&pf->sw_mutex);
>  	devm_kfree(dev, vsi);
>  }
> @@ -626,6 +627,8 @@ static struct ice_vsi *ice_vsi_alloc(struct ice_pf *pf)
>  	pf->next_vsi = ice_get_free_slot(pf->vsi, pf->num_alloc_vsi,
>  					 pf->next_vsi);
>  
> +	mutex_init(&vsi->xdp_state_lock);
> +
>  unlock_pf:
>  	mutex_unlock(&pf->sw_mutex);
>  	return vsi;
> @@ -2973,19 +2976,24 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
>  	if (WARN_ON(vsi->type == ICE_VSI_VF && !vsi->vf))
>  		return -EINVAL;
>  
> +	mutex_lock(&vsi->xdp_state_lock);
> +	clear_bit(ICE_VSI_REBUILD_PENDING, vsi->state);
> +
>  	ret = ice_vsi_realloc_stat_arrays(vsi);
>  	if (ret)
> -		goto err_vsi_cfg;
> +		goto unlock;
>  
>  	ice_vsi_decfg(vsi);
>  	ret = ice_vsi_cfg_def(vsi);
>  	if (ret)
> -		goto err_vsi_cfg;
> +		goto unlock;
>  
>  	coalesce = kcalloc(vsi->num_q_vectors,
>  			   sizeof(struct ice_coalesce_stored), GFP_KERNEL);
> -	if (!coalesce)
> -		return -ENOMEM;
> +	if (!coalesce) {
> +		ret = -ENOMEM;

Knee-jerk reaction would be to deconfig things that ice_vsi_cfg_def()
setup above.

So I think the order of kfree and ice_vsi_decfg should be swapped,
something like:

	if (!coalesce) {
		ret = -ENOMEM;
		goto err_mem_alloc;
	}

err_vsi_cfg_tc_lan:
	kfree(coalesce);
err_mem_alloc:
	ice_vsi_decfg(vsi);
unlock:
	mutex_unlock(&vsi->xdp_state_lock);
	return ret;


or am I missing something?

> +		goto unlock;
> +	}
>  
>  	prev_num_q_vectors = ice_vsi_rebuild_get_coalesce(vsi, coalesce);
>  
> @@ -2996,19 +3004,19 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
>  			goto err_vsi_cfg_tc_lan;
>  		}
>  
> -		kfree(coalesce);
> -		return ice_schedule_reset(pf, ICE_RESET_PFR);
> +		ret = ice_schedule_reset(pf, ICE_RESET_PFR);
> +		goto err_vsi_cfg_tc_lan;
>  	}
>  
>  	ice_vsi_rebuild_set_coalesce(vsi, coalesce, prev_num_q_vectors);
>  	kfree(coalesce);
> -
> -	return 0;
> +	goto unlock;
>  
>  err_vsi_cfg_tc_lan:
>  	ice_vsi_decfg(vsi);
>  	kfree(coalesce);
> -err_vsi_cfg:
> +unlock:
> +	mutex_unlock(&vsi->xdp_state_lock);
>  	return ret;
>  }
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 8ed1798bb06e..e50526b491fc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -611,6 +611,7 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>  	/* clear SW filtering DB */
>  	ice_clear_hw_tbls(hw);
>  	/* disable the VSIs and their queues that are not already DOWN */
> +	set_bit(ICE_VSI_REBUILD_PENDING, ice_get_main_vsi(pf)->state);
>  	ice_pf_dis_all_vsi(pf, false);
>  
>  	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
> @@ -3011,7 +3012,8 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
>  	}
>  
>  	/* hot swap progs and avoid toggling link */
> -	if (ice_is_xdp_ena_vsi(vsi) == !!prog) {
> +	if (ice_is_xdp_ena_vsi(vsi) == !!prog ||
> +	    test_bit(ICE_VSI_REBUILD_PENDING, vsi->state)) {
>  		ice_vsi_assign_bpf_prog(vsi, prog);
>  		return 0;
>  	}
> @@ -3083,21 +3085,28 @@ static int ice_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>  {
>  	struct ice_netdev_priv *np = netdev_priv(dev);
>  	struct ice_vsi *vsi = np->vsi;
> +	int ret;
>  
>  	if (vsi->type != ICE_VSI_PF) {
>  		NL_SET_ERR_MSG_MOD(xdp->extack, "XDP can be loaded only on PF VSI");
>  		return -EINVAL;
>  	}
>  
> +	mutex_lock(&vsi->xdp_state_lock);
> +
>  	switch (xdp->command) {
>  	case XDP_SETUP_PROG:
> -		return ice_xdp_setup_prog(vsi, xdp->prog, xdp->extack);
> +		ret = ice_xdp_setup_prog(vsi, xdp->prog, xdp->extack);
> +		break;
>  	case XDP_SETUP_XSK_POOL:
> -		return ice_xsk_pool_setup(vsi, xdp->xsk.pool,
> -					  xdp->xsk.queue_id);
> +		ret = ice_xsk_pool_setup(vsi, xdp->xsk.pool, xdp->xsk.queue_id);
> +		break;
>  	default:
> -		return -EINVAL;
> +		ret = -EINVAL;
>  	}
> +
> +	mutex_unlock(&vsi->xdp_state_lock);
> +	return ret;
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index a65955eb23c0..2c1a843ba200 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -379,7 +379,8 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
>  		goto failure;
>  	}
>  
> -	if_running = netif_running(vsi->netdev) && ice_is_xdp_ena_vsi(vsi);
> +	if_running = !test_bit(ICE_VSI_DOWN, vsi->state) &&
> +		     ice_is_xdp_ena_vsi(vsi);
>  
>  	if (if_running) {
>  		struct ice_rx_ring *rx_ring = vsi->rx_rings[qid];
> -- 
> 2.43.0
> 

