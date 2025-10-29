Return-Path: <bpf+bounces-72719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC52C1A074
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 12:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CBE25634E5
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 11:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72CE32E122;
	Wed, 29 Oct 2025 11:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPwVvRpc"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D682E1C5C;
	Wed, 29 Oct 2025 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737222; cv=fail; b=JFvk9tesrCkV2J1LI31KZ29D/PKidvn1/ARxZUyNMJlHdc5U+wBatfjVEKNH6/RDKzN2gTU72gohM4C/Va3X7zUWaSEYOWN/iXTQapHTpfGuo9vqVtHOO/nrYdiffwLtcIK7MpJ0Gj+3m5QkzTh7j1x6AwqJCiN8jmUvA9BPznY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737222; c=relaxed/simple;
	bh=21ft75Ivqd4Mxx4O1B5GCF77KHJ+VmI23fPZ5Ot4hR0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=juTU3I+ax9JuWMsH1nc7VDP1hDMSNa14j/CEkKaJqYo5aiSRe5g+DJKDA7vWQfqziowZQllAudHbeTb6RO6IHzbIUhdVnAlB0iBf/PSI/aBZjGn1Z+vlzEYF+eUoHupn2+OhYc5r4sCYkASvu5ZD4ARvt99q6BFpg3W6mkW8e4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPwVvRpc; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761737221; x=1793273221;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=21ft75Ivqd4Mxx4O1B5GCF77KHJ+VmI23fPZ5Ot4hR0=;
  b=mPwVvRpcBR79WryJrrKYDeXWbstA1ghjkUo9f/JJBVthCaxkBWOhZYWG
   zbaHQ5qFR2Upwr5RShMKuQ9BiQ6Cl6nMTpGkj00rHP2BKer90qhD5Gv2T
   OExQzArnRD/ZQWopUWx4fb47DO64IQCSrZQZDeL1OoKtdSYR0UsXQLNLS
   OJ1JugPjnIzRbzH64rrGz1WMCHXCWP+PoQYrDx50Pwns9dIuCzL68HxfT
   0OKyjwM9DCi+DAa2P/yaJQcFAIH8q8WhG6sbFyiVj1qx8XleGzSe+tp6I
   M9UULOebsngtObrDlBAyZE8p52hLAxiNTET2kWdXNS50Ut7jZSXpYMjsi
   A==;
X-CSE-ConnectionGUID: A6tVlpgGQCqDBpeGBSfjSg==
X-CSE-MsgGUID: oXnxCFMBR+i5hXqBgHkdRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="74972709"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="74972709"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 04:27:01 -0700
X-CSE-ConnectionGUID: 6bKadiv+RJSCHWSsVCHkNA==
X-CSE-MsgGUID: uXAl1IHgTQeZXmGtWzzdgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="222847535"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 04:27:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 04:26:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 04:26:59 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.67) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 04:26:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPEXuug88M/q9dxgDAhpKgGST6iJ+DVUMFF4rkcoKRb2C+bkhwC429eAxsJs6gdOOrrsOIM6Tt8Mk2zPju2PQRiWxspp1CpmSPCjdAZoWt44t+VvM3C+qUxfaT6RaLPcx9BTT0pHwZ5qlS1eoMvnx+aB3nA3djVE+DKTZtxFBH3CRQYtaEQTujn9ZMhnZAQQbuMbMsFbthN4mqAHQozEPZPe4veNzEzap0fMM4Y6WFsyDw56BDw/lLfA9tg7fpQbnNNWJ/MXReF7Rlr4NGqjXirtSnaPgLy3OVFhe8RTPJOh3BzzVbKMQLHzFl4rYwSSgpEcBh9g6/huXKqbumGZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkkYCD1oo51r6zgPkA4Q71v9NhTEjGN+mktoXRDFY6c=;
 b=du0M4a0aZRXNKIvNn+Xc6EKnWiwD4X/qsnUMhVzVgkIshi8Dl5ZQ80TrCVhiIYLyOhUwDEEBaBGtGJCq5ZdR5MZNwoypcoxbiL+BhBA3rosNW2HfOunADp2rWSq3PtnvfoVi+JSaaA45b1s4T+JAiUhhjcv30guAy3xun/T7+YgQGpOgEnF+awiOdPt0qQR+hSJq5knnJuvWT4S2SD9x35xPP9zVLsDJXxVWRYSbnvr6GG31cE0iemkmFzHVabvZ5fZaTEX7yaFfIawqArWrzrYB64JfLPSrCX3r5ixbowRC+vUMJtZMCSX0MiWJDVAxe+QhB5aRvbzSASfX/1BjsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB7471.namprd11.prod.outlook.com (2603:10b6:510:28a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 11:26:58 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 11:26:58 +0000
Date: Wed, 29 Oct 2025 12:26:50 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Jesper Dangaard Brouer <hawk@kernel.org>, <bpf@vger.kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <aleksander.lobakin@intel.com>,
	<ilias.apalodimas@linaro.org>, <toke@redhat.com>, <lorenzo@kernel.org>,
	<syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>, Ihor Solodrai
	<ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Subject: Re: [PATCH v4 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
Message-ID: <aQH5+ojHJ1V9jfk8@boxer>
References: <20251027121318.2679226-1-maciej.fijalkowski@intel.com>
 <20251027121318.2679226-2-maciej.fijalkowski@intel.com>
 <11142984-9bbe-4611-bbe7-fa5494036b8f@kernel.org>
 <20251028185314.1ad62578@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028185314.1ad62578@kernel.org>
X-ClientProxiedBy: VI1PR09CA0165.eurprd09.prod.outlook.com
 (2603:10a6:800:120::19) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 295fca4d-3aaf-48aa-87fa-08de16de125d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z4mAR1FNCRFnAVP7ZlBE/dgq3b0s14ITBnJVCUgMPclaYACuxfImRB9tzvyK?=
 =?us-ascii?Q?praIUlq3GBvCoBxFCra1qM4XSfFTeWVGew6Ozt/estAxGDf8M/pypWOkexik?=
 =?us-ascii?Q?/JTLZ/+5gGUrHcUgtZMZIltfR3RURY9PG7AzqjjzRoJ7mE3aYq7OzqQZJAwK?=
 =?us-ascii?Q?zuFBZ9fXkaInaxbLy256NJ7V7sDpgnkLmuh1yKDkQTMhEgdS+tbMCR9bujoo?=
 =?us-ascii?Q?aL7j/tFHzUCF32eaec1DBKsWkhgx7OQuCvVU63IGDOds4M3tP36TAVPqzg0h?=
 =?us-ascii?Q?sqGNhzVM7xC3VG1sDIy9eaJE3rtbV8U6pFfgGPDGGQOJCu5ZNL766ONnYn+F?=
 =?us-ascii?Q?dS+LJQi4YSdKbtyJvzjdgOpZOMyZatSPY/XcvwGt/hOyrmZrEyYPB+W80Elf?=
 =?us-ascii?Q?GyXyUROKAKEBleIFQcw/T2EXzJt5t6NKVOQg/SWdvBUkYVJ22psCY/jb8ssU?=
 =?us-ascii?Q?5fvj3PXHl167mzwZlLGbqGH/vgm73E0CRBmcXbvefAyczEmY5a67nwTn1oqI?=
 =?us-ascii?Q?glFJd4ThKL3X8Q9u/zqzqblaV/5oaZGqdmFlxm9Xvw3pxBk7OoWA/+5GxsLM?=
 =?us-ascii?Q?DY9jh7o0NjBF/boZF+zVZnRYRwZ/q+FljJOzEeZSwUvkRoL1QFJ8iQRdREUb?=
 =?us-ascii?Q?UbLgo5XVLZty5DB1js2E5sLLFCRlYQm3FE9q0ygGtWQAgr3sBblBCIj6Qz/P?=
 =?us-ascii?Q?0w35dFJC0EXfz3OE9DMfE2n5+woCX5oehY+N/y4ZyZdmwdWoxJbuqrQNL3/f?=
 =?us-ascii?Q?aMFrVa+gV6UUEvvVFk6IRnZHsgsn6ukDdWvYB9JsgqBJTd0JWq4NKNn24CZ+?=
 =?us-ascii?Q?ldIO2+A5VX+dcz9CzPBX6PfV8pmto7vsc1//PPGo3acMZssOOyRLa1i0go7j?=
 =?us-ascii?Q?GDtZX6/hyWOIlB/ZRT/SWTLVL2UzN7X5BZdI6vGQHCekP1Y+l2w6ECQCPcua?=
 =?us-ascii?Q?xDQ3La0c4sv3UV/I1JJAgI0F5dfjS6MS0+cZe5vpIfuUntGXyEhf/M6tmQgN?=
 =?us-ascii?Q?8iZfHyiGG6b9OQ4myRzYsCOJGLfkNPQD2cisJs6mj+4HMGuAjKaQYwor0SMM?=
 =?us-ascii?Q?vZT+83ml4IsiczNbNoZVX+7xMwqwctE9/rr69CRZ1DZbu15jWAcOEDqqR3WD?=
 =?us-ascii?Q?8CWw6uGtdRlQUuvLGn6PgWbf0GfRGOtFQW4rVshi0ree8hcrqp5bP26753gC?=
 =?us-ascii?Q?p7U/P+9Tt+HwVbmByzF74vYePIxxyOFFbImD30kZZ7OLWPyahXBH9k2dYWMt?=
 =?us-ascii?Q?QiXmDgUtCBlBT/udnZj50t1L+Dv7AbxXm4VXglvT+5ImY5l/eH0rvT6YhVeB?=
 =?us-ascii?Q?DiF/3+8yL/CpxAeU/JhSgIri0ty/1uEvhuzRLXsk607c4cU5wPBkZpHk2MYB?=
 =?us-ascii?Q?0xQko5hcM9ujg44kNbVKhgIaxo6Jy0ubdfLbs4IamLFrJ03mNTcirX/lqICx?=
 =?us-ascii?Q?FaGR0zOawhY5OXmetKLroGKvTEzK4yQY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IVrqlo8sGpbMutm2I8PmKsVXQ6fZ0uC+opmBDZH0pIkqx5dovSQmAz2HMAsB?=
 =?us-ascii?Q?5NRC4xZs4ZCxnehMm/EY+zbjpp2iqRqB6o2zwI4k/ScZuUu4xctz6zGuuODw?=
 =?us-ascii?Q?RZMAZpCLAS+9AEvP21yg1rms9XfFJoZSc1ft82bm9EwgHtoUeTIpfpc7AfuV?=
 =?us-ascii?Q?PGpOD7RSJfupzGjv2G3HapiKc7kS/K8ZSF1uwU7gV5jTqQAZ17PGgYQdNcwV?=
 =?us-ascii?Q?VGckw7Pk0zJZ+362tWd77wg7D4oBPcx3uhpfkUda8V9+6wdNLyl14qodXOhV?=
 =?us-ascii?Q?UDAotiUz1fUy1gSqVzLAIE0qe0Own6veXOd+lfvG2XhDVmDMjnBkA0qAOFnZ?=
 =?us-ascii?Q?rxPFD6AvnF0rJkk8I7LVuDXEj+KR9agw5WWtXCRkFZCDpTxtMPl4cI1n8jIB?=
 =?us-ascii?Q?LpzQXOE6OxnQPgi1sDGGFwtxxxVN9xAtmLdAVj16M6uvHNSx+/pqVNFLdgxy?=
 =?us-ascii?Q?DThLYtACkfXcTSLBYG7YgHYXkyVrcfGQJvPrsS0gAJZJ/H8mdtE1duihKte5?=
 =?us-ascii?Q?y50ocA+E20GG2rOUouPvmEn3WoU2qpSNgSbdpDWssLEzMdMGLL1AWPAnXezk?=
 =?us-ascii?Q?7YQWNj3Lybq/PEnGtu7l+GPSh5bVMoWD1Cr1n2QsOexlRe9xkMjlo86wxDQ+?=
 =?us-ascii?Q?MSs6b9utlReczoLRb6+s9oMEuwAtLE8HPhrEYF8RL5WO9nPdhenBg4GvRMxD?=
 =?us-ascii?Q?1R4L7cf5JqLqq0s1kJ3oLcxeZF5DjAFZm52wUB9NhlIKeYpcxq8pDBVcEwnQ?=
 =?us-ascii?Q?pwhQ1yMI6sMPjU32LSk/v9Pt58AaQOjI/+0njl2qZzcm/uXq/p3gRoNE/kUi?=
 =?us-ascii?Q?gAnRbQ0LRhLMHQeiaBPmG501xJfFW/VGquuQeBlNqmj5Ejkl0o1Sju0wr7n8?=
 =?us-ascii?Q?Wvzrr6/OkKJnXcf9iaxUgIFgcmuL3MO+DjlPixihXOHNG0Rd5cus1fwR6WQ3?=
 =?us-ascii?Q?P54PC84VxlqUyCQL1HDduQ4rcJV9SAR5PQ/GvCYHES51IBkYZnuV7+M+HomD?=
 =?us-ascii?Q?bczm77Tz4rzWakm6DvAGlz6KTL3yM3GnRrOcixNA4uEDHCyi70gjN8Wk42Rb?=
 =?us-ascii?Q?4ZQJst1EZKwXZM4AHJIHChIXedFYfRzNqKSi7GzpxGNW6lpfRfBZszMX3zyc?=
 =?us-ascii?Q?RZ2bM+e2GG8kaN6KD56WYwnkxZ0GA4+kW8b2cJFcXsVLogQ6rBlTILtS9UkL?=
 =?us-ascii?Q?o0Z7lmxXtSfteocnIPEsi10O4FK0qoP7hq5GoOnzDtjf4K7QZqzEiHPwvQ5J?=
 =?us-ascii?Q?Oi1FxriRX8Y7GdgAEgvEJkdlTtAktAD6BLf0gbq28PHhwOzbXt5t5Eiq8S31?=
 =?us-ascii?Q?8HfDMtl5ik7n6h7TChS2FNqbhv9Oss27ltYq5dcKGgbNpTaWReMTS8NuPlVq?=
 =?us-ascii?Q?d7nwGGSm/U+giLSEaGiMfuGAgtRYxG3VKTOfY0cl1vY7YnryBNGwuybwdQNU?=
 =?us-ascii?Q?BMgpSmnfrp3Z2ujswXmZvemy3gTIe3dXgsyf+Ezzuel8iMVe/cnSzQjYlb4B?=
 =?us-ascii?Q?5/5g+uTf2zQIDrw2vbgBuoNP5H/Ht4iLP7KbmCcLZPgsNVCkQgGJvzRmFHAr?=
 =?us-ascii?Q?ZolQDhhiHP7Qb8kJ42q76YlgSsbjKg78K1c/lbOBmKS4vpxDO1gcqurQcE0X?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 295fca4d-3aaf-48aa-87fa-08de16de125d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 11:26:58.2010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H13zUNlsoKI7yDaNUNHHkovcFrcAYOyo6HN96XCKt/c5il57avHObb26dKJpyJXco46Sn6hEKg4sztsSxoghQe7JI7BEuXaMREzZUJ4zx1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7471
X-OriginatorOrg: intel.com

On Tue, Oct 28, 2025 at 06:53:14PM -0700, Jakub Kicinski wrote:
> On Tue, 28 Oct 2025 09:08:52 +0100 Jesper Dangaard Brouer wrote:
> > > +	xdp->rxq->mem.type = page_pool_page_is_pp(virt_to_head_page(xdp->data)) ?
> > > +				MEM_TYPE_PAGE_POOL : MEM_TYPE_PAGE_SHARED;  
> > 
> > We are slowly killing performance with these paper cuts.  The
> > information we are looking for should be available via skb->pp_recycle,
> > but instead we go lookup the page to deref that memory.  And plus the
> > virt_to_head_page() is more expensive than virt_to_page().
> > 
> > Why don't we check skb->pp_recycle first, and then fall-back to checking
> > the page to catch the mentioned problems?

Hi Jesper, Jakub,

we started with pp_recycle so if we now have agreement regarding its usage
here let me send another revision. My assumption was that generic XDP was
not that performance-sensitive for us, however this helper is going to be
used within {dev,cpu}map, so I agree with your concerns now.

> 
> I still think _all_ frags which may end up here are from the per CPU PP
> since we CoW the skbs. So:

Agree!

> 
> 	DEBUG_NET_WARN_ON_ONCE(!skb->pp_recycle);
> 	xdp->rxq->mem.type = MEM_TYPE_PAGE_POOL;

This has to be conditional as it is fine to use this helper for
MEM_TYPE_PAGE_SHARED, plus the mem type has to be updated per packet.

> 
> ? It is legal to have pp and non-pp frags in a single skb AFAIK.

Ok, but not in this case where data origins from CoW path.

> 

