Return-Path: <bpf+bounces-50965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1867AA2EC92
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 13:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD3B3A27AD
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 12:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A1522538D;
	Mon, 10 Feb 2025 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LK7d0N+o"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3696221DBF;
	Mon, 10 Feb 2025 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739190679; cv=fail; b=OYfEiSwbxkvOCNR9AquEr7n9v3dS+By+i3meiYPMlfxWojZOGsCHI3I6cLpXtajm67vpSGKtQ9xXUuX+4BJ1FBfd8axLwYTqiAleYvrDDJO9MjpAgV0J8bjcr4NjBd4sWsIqht6jyRuS8sMTSebyZdVzGjSXtgC84zmu+IEqS+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739190679; c=relaxed/simple;
	bh=3biJ+EhcEGaZSMX8dEF7QKZ3FgWQ9phD5XVDbu+1EHk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o8V0QoUpEJg/Bk1i/RfWQLd2prEQxGZ9MXTFqMCh84Rerlib+OvbgFwaLNOInvSjJ76bBOzdMzn7RVjM1u+rU+mqyn55BKAkuqULonTjBBPgU/YJsHH4jFF9KYBMP/N4E8w0wh8zuZ3H4yRkWgqH52vLhD3f7huSPdVgwAFduG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LK7d0N+o; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739190678; x=1770726678;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3biJ+EhcEGaZSMX8dEF7QKZ3FgWQ9phD5XVDbu+1EHk=;
  b=LK7d0N+oMmpoMgGDgc2tzDG865b9jj9toqADSJnA5KviXvcNtxWEkS92
   jJhohYFBwpd9HufcMnNEDslkS0K46nAlRdEs+gH7WqiGjop0M5fHS0Rly
   EXrviv+reFvwuaGbFMrq1oLO7O2OaQLZ3EekOrO/OLOPXUeGw/d2x0aHR
   giXSOuJZw3bpL5sIX+oexARY++IZI7PbAm7CqvaRbCYNSXS6Kh67dSeJF
   LflBp2NHrWHRCuQQNHWj01cfjn4FMdjJiutJtRn4FUPTe6nV8LqVkUuee
   HT3WxpV6BZA+safuMhvdLMD+5nmn3W9+Qd3HHign100DOVKsRZlYmYaeH
   A==;
X-CSE-ConnectionGUID: W2eWzKN8TPKcvlTpfCFalw==
X-CSE-MsgGUID: q1rK1mfCTj+kAttOrfrVBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="62243027"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="62243027"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 04:31:17 -0800
X-CSE-ConnectionGUID: gTCNxh7LTSKjcd0ZWmQV6w==
X-CSE-MsgGUID: mFyJfu3yRzmPjuGlXybhaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117390439"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2025 04:31:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 04:31:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 04:31:16 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 04:31:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=it1OnWPyRoB18ErSBdyXMXREyNTBFR2+RajpRp1BNJ0gD8a8F62E72nL85FRQWzA92sTgZVcEhRolNrwbZ5MxKIncSA9KZT7m/TvuP9g/H3CBmNGr6DTCtAe3P2X8crukG+ay4wZxBTTHsB7I/ULvTDN7V3hDvNnq8+dZsCkXRb5bkvOQ/udv4bCoaWisWMuXgL112Zxk9LWyDk2DjovgoqkPqSP3ri6/FBb6gy84MKQdgW7NO+YreEC8iEXt0k9kdDmmmwkFOIes0mqjccZ77z/+UkKAAa2oGIaW3J9OPaVJerK3TXKCEp4K/Q82FJWbICdMxoA/I2CnpHi9dXLjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9JJU8mbqsMZIIilGObvzRjzW0AViz8cTGfZN7Vh8Uc=;
 b=l44KyBWuj79P4dkZsWlDdelyirCxxX0NZPahtbE1R/oQsCAFScV1L7AoDQzh9SNj+5yMB+vxSFCh51TPw44olsW0G511S4jzDuYlHNkqbsXIONYK7+2gEa/ZPMHvZviUO3r3hrDvvnNSIeMYmVwrVvjWOjdzPa1eOMGzWopa/elI1ziBXy0xMXKdBSEkUDY/NIWEqYEqraDNYzlC/nM+lJis6zulSg3MpTfbwlLXJMgu1mexEt3R1NO5NlUcDZBmNDp3RgkpiQC5DfZ7A/6jpLsreOpFKDvlA9zCIDhVvZhkWNGIiRoqhCuyNdg8arhNotmA/9UWXSPkW8p3bfoplw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB6351.namprd11.prod.outlook.com (2603:10b6:8:cc::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.14; Mon, 10 Feb 2025 12:31:15 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 12:31:14 +0000
Date: Mon, 10 Feb 2025 13:31:07 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, "Jose E.
 Marchesi" <jose.marchesi@oracle.com>, Toke
 =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>, Magnus Karlsson
	<magnus.karlsson@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jason Baron <jbaron@akamai.com>, Casey Schaufler <casey@schaufler-ca.com>,
	Nathan Chancellor <nathan@kernel.org>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/4] ice: use generic unrolled_count() macro
Message-ID: <Z6nxi9Ogdv0pxrQJ@boxer>
References: <20250206182630.3914318-1-aleksander.lobakin@intel.com>
 <20250206182630.3914318-4-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250206182630.3914318-4-aleksander.lobakin@intel.com>
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: 432cbc78-1bb8-42d2-2d5c-08dd49cecf5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K7SXTmOqQALrN/2zUBx3AGHul1aez5cFT2EcaLI1aScT00cbGiiQMvqDHoYF?=
 =?us-ascii?Q?JZw8B+/2/0iGcNeiWZxLLPjYw67S+SZjqMRfScKue8xrY9AUzCF80kKD9+4D?=
 =?us-ascii?Q?mfqSS1+M3vyPVTDEB3NzI6mJsbj36TzfqPgw1K8p3De3WOflX6j8XJZH2LMh?=
 =?us-ascii?Q?ZukpU6rrB6B3BsHFqMnnP0J8LDINRQFUVFX4RYz+jgEcxgGm57GCyokmeNjq?=
 =?us-ascii?Q?aiFQvjiEuBi9+1+Z7XLyCscHSf1+q6cjDqOS2yFWjDha/Lhvuw1zPxcH2Jjt?=
 =?us-ascii?Q?Se+z1i4pkirwVkfjJylP0xVCxVaeelNCDj0OTr4bf1etj3lzcXa7DSIUZruU?=
 =?us-ascii?Q?Cr5ojsmRYovfTyF4Fr6NbcJthv8K81eANMVC342sA3IV5Z58hSHXUKidfCU9?=
 =?us-ascii?Q?+qrYLCs4qBekYj4s7KZziOijUNYEPaMbiHZSvYNrxXQ++pMyFxCyfTxVtDYY?=
 =?us-ascii?Q?iU0d2wvnEmxWCFo9iRrQ1k9tABdtvLnANFKkhoB+RpBXNddEHwknTUdR0hL1?=
 =?us-ascii?Q?9yBD7Ezyjgw+4U584hMpanYEhtUs+P4LBesx1JxmVllOLDA8SvIrCdrOy3j7?=
 =?us-ascii?Q?d6momPquyWHjUlxE3mwXPyMePpYAbeWE0J8MPxIeghzxbS6qhNpbQK5Edjlm?=
 =?us-ascii?Q?5q61cAHc0zYAz689Aa0w9tFEm2XlB8huy04M0KQYo6bN0gzxHjzkGXG8gKhU?=
 =?us-ascii?Q?2m/iiD75x9pxP6A6Ffd0F3rIS0hV3/WT7HxboiwcYae7vyzx/Iu3ydlnjglC?=
 =?us-ascii?Q?uzxXTMAK2mtC74502WfRrF5stEJO9N3WCefkTa2DiWUa7wVtXt4F9MNHW6vV?=
 =?us-ascii?Q?U40i0Hjoadufkzyzs5kYAhsCi2+TbiZKv1cChFqDgpODfy0vkNz8CSceB2At?=
 =?us-ascii?Q?JQFsl9OD8MOkm2DtBU9MB/H4KjBu3K7c9n+uyCYqA8tDgYrXZaL2+elezlEW?=
 =?us-ascii?Q?jvCrj+30r7EHD60MktfByOmzPuo79nDlbDq+YEs57vtrQd2W7VvWa9vQGSvs?=
 =?us-ascii?Q?VNo7TzBbwPK7Fgmgy80MfteIcuPnDN0EDOH2ljThef+fmFhDDVvC2uaY6B2O?=
 =?us-ascii?Q?3/6csZAV9k1UP0YpprBi+aSEWZp/rFC+3xGFTBDHB7xH705kI79ukd5iPodw?=
 =?us-ascii?Q?Evp6tR3z5HT4uyiT6yZqWQgaVc+RtKfZs+/le+ogRbZWJXRDiHLxUNX6Xupb?=
 =?us-ascii?Q?+Hex8fh3QmqHC1rHdXBbCE+kzTNbjHANQduU40EfT6FMoPe2jUyDfJVaoQkb?=
 =?us-ascii?Q?PA3onZidd7owfmLH5DyOjhMGCKBH8e7s0rZ0eainhVP/5GroFH8xoiruw+5i?=
 =?us-ascii?Q?1BlqN1qS9M2reJhjNW3oddA0odAzX3pMvqBt6Kgk8LwgKrx6EzImxe6XOsOR?=
 =?us-ascii?Q?QXVGVUSQwYdpJQMqdly5Bs5Pxj3O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kzBObgVDBJZOztSVhu0WOEIorh9CF0IasJh/PT7J87SEHHK1G5uupev7eF/J?=
 =?us-ascii?Q?MF9nKbuaGil3w7c4fWY6wjivBrCOwQA5fOxCga1gBohf+IdtTnZcFJLG4su2?=
 =?us-ascii?Q?lz8uNSSbb/IL6fxD7A44e49C78YMDTRUpS5Zu/pFHBlMEpGwDDOGcs/Vcc6X?=
 =?us-ascii?Q?WH4Vo9kqikVf7BC+K+pJNUjUBASBfNOndeBImUVy6d4cIDyX6fIkDZyF5Kdz?=
 =?us-ascii?Q?fWczhKzMeD0rOlKiiRjzoiol/eLI06Udol2CtAEw2oYepWrQjWkCAe7AUJzR?=
 =?us-ascii?Q?WaeDiP2Jc1+Xml1eJ+E6YbSVfSkKnSRKUWARgUTfyJUew8hgSpENI27A612R?=
 =?us-ascii?Q?ndR54gfBVbGthv/ZIToGRfgbwLyiQh+KLheydevT181SFki7gZRnqW2f3XVW?=
 =?us-ascii?Q?jWBIB1tibFudMrrNEbZ/3UHlbY8YuUm95sUFdo0v17R7yejzFwlYLglKHf6I?=
 =?us-ascii?Q?S6zDKdy6S/nQJaLPWF8+AyXVIRxmlYG2KvUWFgi+Bf7/D3yyoUsYwlXVcyFO?=
 =?us-ascii?Q?8ZwjZocBiEW91cZkIzPXWj7FG6wa8mXzcBZR2zk0F8tgu+aEW0m7rQ9xjmUh?=
 =?us-ascii?Q?MaTAO8ztnDasaKPR/UBNMNKtIbqLrdmIkkc75iIGA9w4JaS7qOPnd6PwdTRC?=
 =?us-ascii?Q?NJr+fzTZTf8ld//7n7Qv78A2mSdVtbWpOl28jzXwCsQv0j35UTpg0J53xC/h?=
 =?us-ascii?Q?NCkpmykHEpwl75ClyyqCqyuaIFwKheNNiCjQynm4/GjKj5HSoqxR8P7+mILA?=
 =?us-ascii?Q?2Tm2cENKveUOtNXtX5tUf9RfL+aOsK1F+zZusmsunx5Ki77+CqzLLC2hXa8Y?=
 =?us-ascii?Q?JLNSim+tueHVj+4zHBwLf84mmCPH3QGeRCeYngFPQs9nuCNOBMTlPpSF1XXz?=
 =?us-ascii?Q?0eJQ4ZhrkNOFdP5r1EnJjY1BaspbITV2XnTB2xThpjSDcN4ecpfpKqL28+ic?=
 =?us-ascii?Q?l3BCYdjz4i+QGkhnSlca/VQqP0L/bgBqoxJ1F43s8j1nkcEBPjNJH2ETZAly?=
 =?us-ascii?Q?1uYQq0Kbjh+8920zpF6V2UJFk3jav1Lz7wJuSld3lreVM4Q5pq2/vOST1H1c?=
 =?us-ascii?Q?gZfmrArYv/JG9w6Ujb3OjbKd+zRvY9hIm0FO7FZS5OqjyJXnqUhdyOaF0vTF?=
 =?us-ascii?Q?VxZhkJ7EbBpA4f7bFeaJxu0ojDnNb2EcV9hzO7DqP1OnJauA6rL4srMrN6aC?=
 =?us-ascii?Q?yBdMD34ndtGZv7V/CCl8epnTpt9KRrjWfzSR97MPHAR46htbPZI3k5Sjw/VQ?=
 =?us-ascii?Q?GCJb7n8A+eH3wikQM6syyV71k1zPqm1WWkQRnLx6Gl3maF7KMmlnhZ2GoDqN?=
 =?us-ascii?Q?iEg2XvLA3X5JGSam5IhisCRo/oz33pHRE6zBtg9T0ZesMA54LjQ2JMqXOJyx?=
 =?us-ascii?Q?g4rzYhogTOkrUrRplifUM6BCBBymmI4XLxtEgOsTwXwDt2+2+RO+o0wwwdto?=
 =?us-ascii?Q?ac5x1US36mkFlAxMT7VgYo7k86pRGxng4X3baBwsD/V+4qb78E0uAfodkqA3?=
 =?us-ascii?Q?PFjn4hc+Fe8BAC32jlLPb3P1JGPEFjS6whPx7up5pdH1HIqpn6bikCjqt820?=
 =?us-ascii?Q?e5I99A0JTFpoBLH3Nk+9A685iiTEQMLOmPVQvuim5VOF8Tp7va5yMYzJsALV?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 432cbc78-1bb8-42d2-2d5c-08dd49cecf5f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 12:31:14.8678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcbPFeVnJCDinmVeCGE0wgDtAe20qZvX4QPFJHRPGcel9+7PPMYKGX/CLo/Q9B9tUdUQnSYNKFyLjYZU/KL3ylphXU6C05oWEXYPHTreu1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6351
X-OriginatorOrg: intel.com

On Thu, Feb 06, 2025 at 07:26:28PM +0100, Alexander Lobakin wrote:
> ice, same as i40e, has a custom loop unrolling macros for unrolling
> Tx descriptors filling on XSk xmit.
> Replace ice defs with generic unrolled_count(), which is also more
> convenient as it allows passing defines as its argument, not hardcoded
> values, while the loop declaration will still be usual for-loop.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/ice/ice_xsk.h | 8 --------
>  drivers/net/ethernet/intel/ice/ice_xsk.c | 4 +++-
>  2 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.h b/drivers/net/ethernet/intel/ice/ice_xsk.h
> index 45adeb513253..8dc5d55e26c5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.h
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.h
> @@ -7,14 +7,6 @@
>  
>  #define PKTS_PER_BATCH 8
>  
> -#ifdef __clang__
> -#define loop_unrolled_for _Pragma("clang loop unroll_count(8)") for
> -#elif __GNUC__ >= 8
> -#define loop_unrolled_for _Pragma("GCC unroll 8") for
> -#else
> -#define loop_unrolled_for for
> -#endif
> -
>  struct ice_vsi;
>  
>  #ifdef CONFIG_XDP_SOCKETS
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index 8975d2971bc3..a3a4eaa17739 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2019, Intel Corporation. */
>  
>  #include <linux/bpf_trace.h>
> +#include <linux/unroll.h>
>  #include <net/xdp_sock_drv.h>
>  #include <net/xdp.h>
>  #include "ice.h"
> @@ -989,7 +990,8 @@ static void ice_xmit_pkt_batch(struct ice_tx_ring *xdp_ring,
>  	struct ice_tx_desc *tx_desc;
>  	u32 i;
>  
> -	loop_unrolled_for(i = 0; i < PKTS_PER_BATCH; i++) {
> +	unrolled_count(PKTS_PER_BATCH)
> +	for (i = 0; i < PKTS_PER_BATCH; i++) {
>  		dma_addr_t dma;
>  
>  		dma = xsk_buff_raw_get_dma(xsk_pool, descs[i].addr);
> -- 
> 2.48.1
> 

