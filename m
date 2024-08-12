Return-Path: <bpf+bounces-36899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFEB94F23E
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 17:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756811F2138E
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 15:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8EE186E33;
	Mon, 12 Aug 2024 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MB0N6lIk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365124D112;
	Mon, 12 Aug 2024 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478381; cv=fail; b=MUGenU1hcdcNK5uG4iLXWHCiUNi8/G0Drd12U7iMcRIkI/7FeYmtBb5dJl1XWAx0Rdd3/mZruH3VHMQmP+rUDp/a/dtEX0Tx/BTCVYM9NzHDb5DYTCgyGh+TAdzUdAVTuafBDP9s1A3IK7zKhPJ9QWSOkBQZPYeOFuOlsdBPDY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478381; c=relaxed/simple;
	bh=IDxHaXjP6Pv2/6Dcg1/cx1KVrCuRP1GOUMuHcvlovS8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iBz4UqXaJ4t0eqbUEM8kH037mnVcsGBqFtwiMyl1lj7JmL7iSJ3bboEo17MMYgvsRfAJpa5HjdGYZY9kAAZIZgBn9DO/Rqdd6ZZgEM/nZFvn5iDnDejI+81fO8d64qQkQMBJDFr+wT0OzUru101HQwKwMIt8QR1Q2ojx5cHzJuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MB0N6lIk; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723478379; x=1755014379;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IDxHaXjP6Pv2/6Dcg1/cx1KVrCuRP1GOUMuHcvlovS8=;
  b=MB0N6lIkaJU1iAV+KVY+Vn/rCjFkAIGcVvNRiI5P0MJWZqVhWZlTHOjw
   gr5L79IqVXIZRMr+JjunmjUcl4lYjk00S6YFGh9D/eX5MCnXNxfTut9tz
   tIvolqIu0kcWN/h41IdxYXs5/2K3aXKIQd3ltqX8bjcfnSnyXN1o0EFKK
   FNGPhuUNqrVGQ3oCqgUjiSqHGOZokRLw3LyjHIwtXxsYYAbYOhpbVTVj0
   EtQNF7KW6CEpFqcArrl1Hq6/53MkMXV+2+c5RJXozcc9fNhWimSpKh4Vd
   AAPzuVcCzJlmvE7NYJ6ADGIgb5Wm6ufu7ZQm/PxFtoQIF3C6iYMHYOFMo
   w==;
X-CSE-ConnectionGUID: B/9uFsLhT4a4lC1s0WBYXg==
X-CSE-MsgGUID: B2oxtUUWTziOT5NDUJ63qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="32219580"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="32219580"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 08:59:38 -0700
X-CSE-ConnectionGUID: GcAEfyxLTeq+o7CO5RGyow==
X-CSE-MsgGUID: KQPSIKw0QWWd8cC9eT5Z0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="58871885"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Aug 2024 08:59:37 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 08:59:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 08:59:37 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 08:59:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzWIPOhDoGRVQBuXyVMB3d3N4bCWmY7H/vfhYYIROzRrVc6tRUh3BfcIXUOllgIClFXnsFGgEneQx2TnVMT3bDtuGd/fA/70Ly/wfr5crbdNmR0+eBIZIk88S3SBLnYDvccqai9Jes0bfxJg8wmGpfdFJCP+XSK2QqjXYgGRaaKjSKPnLeH5Xf8XXBndQ62R0lb9E26wsTm/wzmtocMxO7zMl073S0eq0v4TWWdck0zgCyaxskE62IdWTJwFl2ORMrm9PflvdzuwaM0TRfXAo7S6/GDDjm0IAeJ/HeleLWqm+GW3Y8p/VLVL3+9cXsxdZQamYUg9RtZbKD4qmJXd7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neSzJHdHEH39gLqG79LfptQy1jitNyVi3msh07WtAOk=;
 b=NVvQZdUdm65jFGI2MF1NYDn5Gck+SJY9ZzJA0k+h76UkBF9ZL8f5E9ZvVwlEU6WtfpFqdcyGorVKrA4sAI0XEistklkccPvSpfnK9uDZaI5fZtBhbllLuAaPAfMvDV7uMTM8cvpszfCdY4HoXgg0Ey4b8WVjzVOXah9IYcr5xcCbPTHNmS4PFUOrBqDcx5+K1hbDbFe9+PyfuVBGGNW8NrIGPZBInbfrv1JaE8CADvC8SIFUJ7RJpA7Tp6ENgX+PQnXo7aHXK6JVHAzzlr+1l+As/h7mc6L/HafxnorCTYZnQ1xJj9x4Nvly3NL+cKPOqDoo+gOrtBcLHkLf13IMPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SA1PR11MB5778.namprd11.prod.outlook.com (2603:10b6:806:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Mon, 12 Aug
 2024 15:59:34 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%4]) with mapi id 15.20.7828.030; Mon, 12 Aug 2024
 15:59:34 +0000
Date: Mon, 12 Aug 2024 17:59:21 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Jacob
 Keller" <jacob.e.keller@intel.com>, Eric Dumazet <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, Amritha Nambiar
	<amritha.nambiar@intel.com>
Subject: Re: [PATCH iwl-net v2 5/6] ice: remove ICE_CFG_BUSY locking from
 AF_XDP code
Message-ID: <ZroxWcFbhF2KSKeb@lzaremba-mobl.ger.corp.intel.com>
References: <20240724164840.2536605-1-larysa.zaremba@intel.com>
 <20240724164840.2536605-6-larysa.zaremba@intel.com>
 <ZroIF3eSlQuAk9Zx@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZroIF3eSlQuAk9Zx@boxer>
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SA1PR11MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c08d4c-e288-48cf-cb1e-08dcbae7c260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VPoTnj2PUJTfeJsyNymY103nDoNK0rgX/+Kh4r43Fnw+ZMqKQ6fR81ZDtGH8?=
 =?us-ascii?Q?8z6S3vOFy87R9tmcoic/F1WiQp8jTLuxe7V5K2j2NLj0KuDe0FwCcJTvImzB?=
 =?us-ascii?Q?4goQGUcUvCw8pxc9Z4/6PSfXe0AO7olm6LzsX1tGeYl2rZfMCnBjZKUbOuxt?=
 =?us-ascii?Q?XZiDaBBo3oqtH0QAXVlEhq36e1hYBaL+6TriSe12uOh2MaJh4JgOi8TQaiY8?=
 =?us-ascii?Q?v5kY0KQQ/daJbB214Y85C8sJkiwiCJD7jAyc4B6P4nIvqk41JC7CGYbBYUxV?=
 =?us-ascii?Q?BtZjbaFYdcUUg3o7/H1JG3XwtEIWEmXR7PRd2LpmwlrZy6jWF+wwbDsKvIjc?=
 =?us-ascii?Q?cxyrBzeKOUBXRPVbOscLlp/GDzN2BW1Q/32dLgTpRrqplcam723e/2YbD4lB?=
 =?us-ascii?Q?yuU87UC42GUa0vPGkjgta2KcQygNWb5uphpgKlaVD06smMlJWF6ufUrCd17B?=
 =?us-ascii?Q?QgAcvKcXBBisurApIKOnhFZHcwN1qKxw+xMWwnkTY1ncqsGjB6L15TF8YuXZ?=
 =?us-ascii?Q?tLv2+52lqo1Pt4+Cxa0g+f9NtQjwNZWuRPW2Ip94AmzMPOfZlO2WkoEX2zZA?=
 =?us-ascii?Q?TqO6ZEg6wVZ6+NUdN//FMW8ICog0FXdMrSJzTxP+weJ/lVZnOUhCf2JZ/Gv8?=
 =?us-ascii?Q?iEFDJV3NEmGzLXPYya/Fj05HxMKMJYVSVHNTosl0mxD3aCqGCoyKIJZegCm7?=
 =?us-ascii?Q?GLGLhS9cGktk5PfLNQdTF91VixmsrVz6dcioY2AhM7osdpTKOgoaX7qtmPXd?=
 =?us-ascii?Q?CVRG2JPzqXmBEIDHY/bIOkF9oGP+fF11vXimm16egJoy8rq9yreNtcq2nYrb?=
 =?us-ascii?Q?Uy9JXrkWUpJebJ/faEQiefeJkBJBwh7C+CaS32NKDZwJxaDJeM1PF6XwTW+M?=
 =?us-ascii?Q?SUuY/9/CjioxNuhRxY/5pe/xcs+T5ETrh4jCAixFJDRC3QZ+60UE6hC6d1Oh?=
 =?us-ascii?Q?BRVXhUcGzJhY8PKXdudE+SilJwhdLb0Bz90tCT3IK5B3qF4yurLSIj0qQ+dq?=
 =?us-ascii?Q?8fcOh2KXm3swce+KbnZV1AC1utLOU0itfDA8aR6RrgJUxPhpbWynDTlpQ9OE?=
 =?us-ascii?Q?Vx0SuAqPeAXrb2eWSCdK+1txLq4CcIwRdQ2/y1d0z74BYhLMzMHukDwqcwtQ?=
 =?us-ascii?Q?lk9FYFiJCKoRBu7aH2SMoRxY4YOdEzkFkPBmC3FOyKGFaegqME3OLANH3QVa?=
 =?us-ascii?Q?scug0lElL6qrjeu2iAKDtxWx/Ce/yUp52YY94Q/jaImJ6X5A6muvrMH0tlwb?=
 =?us-ascii?Q?PHGbazLB45hFTVQrXnIz+Qs+HOiNljXD7jvjzJre8C0T19/OuskXYo10wr4V?=
 =?us-ascii?Q?WfUjutxtIStr5wDbdMcR1L/H?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d1UWSd6XbCGgqc+eXiquuGd6z/anFea7HnS9G5+BNO9dSScxQtsKs5qY4fxE?=
 =?us-ascii?Q?HvYohNZ+M6L7lmt9+iIvrHR7fbDWYE5P8S7vCstEYTXY8rrq5wCd6gI0JwS0?=
 =?us-ascii?Q?ggVMm/AuZZxratUgSXRvWEY1aDzHgc7LfHVEU4BZHUPo+gYBhU64tM/hmysT?=
 =?us-ascii?Q?OM7J7CpoOM2aKLw91aNcqOpsl9APMoJw98VDyakroyMsbe2wLEBKnyLPU0tS?=
 =?us-ascii?Q?I7v77uuo6Cc3uYohMjpWD2GKZ4kfkdBRAcngzwTYBY8dPhSuxaZnLR37Tl+k?=
 =?us-ascii?Q?j+8oK2pEByc8I/6kZd40HDOgyX5nS/+oZaZdTzSvM9OZMBOYCJFcljb+iGi+?=
 =?us-ascii?Q?Nbi6bJL8DMbcIZdpeaXUtFxazD9JfAW0ftLmDucw5Ky2Fs2bcZ4BnNmYD6oh?=
 =?us-ascii?Q?VwHhpbSA5BhwgtoKqeFZYrK0KkCYwazgcvsRqojS9HNIqcp6txdkPwM9SGzT?=
 =?us-ascii?Q?dKv0CBtt8bLLpdsmWudIQHekyUYfJIGFMl33DYsJUnhUAlZzUIp1y28mCD1q?=
 =?us-ascii?Q?p7GfkP6GoLfZoeNjzndnr4ACe3IndcyXL54wRrfHsh2hVkKxdTuV84rnOAnr?=
 =?us-ascii?Q?YCedGk8FFYG7peTu81qeoLhvZ1CyFzh5enwi3C8i0L7tYXbksSggb1mKkbIV?=
 =?us-ascii?Q?rRzEJ/4S0F7IZakwuE1HcjNxv27OFI65JHmOEK8bl0df+18F4DXewJfp8DKM?=
 =?us-ascii?Q?NrIZWjbj/UHiN3qjeV/kO6RLMTxu55ZnnDmVbLoyKldS/mNV9BXm2lPync2W?=
 =?us-ascii?Q?jPLPBD9/LttKwpALPPaTHYJEiQDxKPnIbtjunFg/2MDrDad1HZbaXLxrx69p?=
 =?us-ascii?Q?5xoY8M4OAVMtvMEqKhh4/gr5wd0E2B5Nfqiys3HR7KugEazfee3eB32Ccf8g?=
 =?us-ascii?Q?/6qdjhUcVZ7Xo5IBiJiGpukVo4pv/TkGzFYD0dIcdoesC/6RG73Si5VKmym4?=
 =?us-ascii?Q?xouWUCOiw8IqX0+lbsQWQ5CPqPHMdFnviez3tukeWyIqRaS1w6emMxzOoFck?=
 =?us-ascii?Q?mEEHewkPefaugLGtguDsjPHLFQ5dbKBOixg9TsMMWazYpA1zFkfE9ulTNotw?=
 =?us-ascii?Q?vaG66XyrPLJ0WQme9UP5scWh9y+TYybCPeszxZO98MVwa+OiDROQtmHWUWSY?=
 =?us-ascii?Q?kmeXofynB7Ih4DQ49osXx38MoriaYQJTgf7Y0w0Tm0XJoWMNAA59XKgHJEoL?=
 =?us-ascii?Q?jKwzJndxgT7sU1GFFMCiwI1RUJ12tUnALWngCEqb8UUhqJZTWaWiUSaECjCd?=
 =?us-ascii?Q?PPR1JgNzxtj61q2NgE7dfhwIuttZFJ4U1fbTJkf7eg3A6IU3+4NHIMCg+YSj?=
 =?us-ascii?Q?IYaYkR97ETdqbkGLhSYov8wep3PD9zQYNGyc9GhcI7aBRx5BH3QeMnzis4ss?=
 =?us-ascii?Q?T3/PQji/8v5MVsgN1ko7WRvNiEfXbEotJe/BPQAdtOmnqShpCbBMvEJ0O2Z4?=
 =?us-ascii?Q?DVW+BWoLl9hjA5qyXoFP5/KUinNSGlzXvxnamJBmpRcLUuQmRj/QNkOJslSL?=
 =?us-ascii?Q?4FNJ2VyzQ+4cXjdKlpWf0qm1HWcJjQ1QeB3BkZLp6rzBE7bReKX15N/9/7lQ?=
 =?us-ascii?Q?9Uo9TjdDXposUzpUSd+OfO6QkPnvr0nREGyHXpP/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c08d4c-e288-48cf-cb1e-08dcbae7c260
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 15:59:34.2692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrQdqA956riHqDUK/U0bcDIlPjWCuBVTu3fKXw9qny10X6r9+yyBS5t1KdwVFA0j7VU3ROOhcjiCCrjp6PF4Bfv+brTBCucIfvTp73Yk2os=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5778
X-OriginatorOrg: intel.com

On Mon, Aug 12, 2024 at 03:03:19PM +0200, Maciej Fijalkowski wrote:
> On Wed, Jul 24, 2024 at 06:48:36PM +0200, Larysa Zaremba wrote:
> > Locking used in ice_qp_ena() and ice_qp_dis() does pretty much nothing,
> > because ICE_CFG_BUSY is a state flag that is supposed to be set in a PF
> > state, not VSI one. Therefore it does not protect the queue pair from
> > e.g. reset.
> > 
> > Despite being useless, it still can deadlock the unfortunate functions that
> > have fell into the same ICE_CFG_BUSY-VSI trap. This happens if ice_qp_ena
> > returns an error.
> > 
> > Remove ICE_CFG_BUSY locking from ice_qp_dis() and ice_qp_ena().
> 
> Why not just check the pf->state ?

I would just cite Jakub: "you lose lockdep and all other infra normal mutex 
would give you." [0]

[0] https://lore.kernel.org/netdev/20240612140935.54981c49@kernel.org/

> And address other broken callsites?

Because the current state of sychronization does not allow me to assume this 
would fix anything and testing all the places would be out of scope for theese 
series.

With Dawid's patch [1], a mutex for XDP and miscellaneous changes from these 
series I think we would probably come pretty close being able to get rid of 
ICE_CFG_BUSY at least when locking software resources.

[1] 
https://lore.kernel.org/netdev/20240812125009.62635-1-dawid.osuchowski@linux.intel.com/

> > 
> > Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
> > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_xsk.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > index 5dd50a2866cc..d23fd4ea9129 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > @@ -163,7 +163,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
> >  	struct ice_q_vector *q_vector;
> >  	struct ice_tx_ring *tx_ring;
> >  	struct ice_rx_ring *rx_ring;
> > -	int timeout = 50;
> >  	int err;
> >  
> >  	if (q_idx >= vsi->num_rxq || q_idx >= vsi->num_txq)
> > @@ -173,13 +172,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
> >  	rx_ring = vsi->rx_rings[q_idx];
> >  	q_vector = rx_ring->q_vector;
> >  
> > -	while (test_and_set_bit(ICE_CFG_BUSY, vsi->state)) {
> > -		timeout--;
> > -		if (!timeout)
> > -			return -EBUSY;
> > -		usleep_range(1000, 2000);
> > -	}
> > -
> >  	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
> >  	ice_qvec_toggle_napi(vsi, q_vector, false);
> >  
> > @@ -250,7 +242,6 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
> >  	ice_qvec_ena_irq(vsi, q_vector);
> >  
> >  	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
> > -	clear_bit(ICE_CFG_BUSY, vsi->state);
> >  
> >  	return 0;
> >  }
> > -- 
> > 2.43.0
> > 

