Return-Path: <bpf+bounces-62095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E45ACAF133C
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 13:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C284E3960
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 11:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB3E26A0E0;
	Wed,  2 Jul 2025 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iTkpJ+TF"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5878A19AD89;
	Wed,  2 Jul 2025 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751454289; cv=fail; b=qMbNPFATL3mxbN4GBld4U3GWVKeFpNbOCTB2I0t2jHm6cuT9ZkICmpg6xClKqpwWVaA8qVU60/vdmH4Yvl/j5VpIMLZ3ZuVWRe34dCUxaTziWBiRwdIUcthIZEGgRP5FIqovRWeoRzYonFEzNGMg+v0Bfgfu1il1SB6awJMmmbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751454289; c=relaxed/simple;
	bh=yVEg5zr2LABaVWXPHabA4WM9jAhOeIEhWnLoMGyBmMM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KS8qXWXfiKvjvBz8LtF616JkjJMTsYqrx/vh6R0pnWUurSo3PwBEkhumkRYdGH9gEe7DxBhSLPmtFupjNpyg2xeriDa33NFhaSUHYr+S+QqvtvXHMWoXDSoXfGEWPdgKBwFdpEKU3RW2o9IyQ+TPYs6QJ+MLgRDG7oiTY4j9mhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iTkpJ+TF; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751454287; x=1782990287;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yVEg5zr2LABaVWXPHabA4WM9jAhOeIEhWnLoMGyBmMM=;
  b=iTkpJ+TFKSzGTBOnAfuop3gGI/cvQVi+r4k7d6As9avBcrrCDqupkF1G
   HuGB19VITB8LioOGcTZ3grhTgOuvRBDs91FxfDDBBsjATCCMA9FpNwZ/d
   SiJNtVHv1jauTaMr71ZTP2hsamXhVSJfAOrXmorm95WhmM2Z95cFKlL8I
   UPkMZUP/xHdOykOnPkQhVqa7Qdu+GPLb7aQ0bD6gm2mUAUHZpktCAYKwo
   wuC9IMa8Nv1RWXD5Zl5yX+N6XHmXzmpqEfvtBXa7ENVwUPG/MdDtcdZmQ
   HMn68tw+BXzvP+yXzKYwqfyEcTU9mv6ffoIXjrupRfI5Y078ow2qlYNit
   A==;
X-CSE-ConnectionGUID: lHMhz7TyQzq0JKHPvRt6Lw==
X-CSE-MsgGUID: dWGF73NXQ6yrR3H3rh+x0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="71171478"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="71171478"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 04:04:46 -0700
X-CSE-ConnectionGUID: d1TMVObOQ0StRX1lVb4AxQ==
X-CSE-MsgGUID: f74x21rlSY6plBcWrornHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="185074588"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 04:04:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 04:04:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 04:04:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.46)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 04:04:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/bmpB4a8OTRbXAwPeNEhQEIT1UdgALWxypS87DlFPQkSfPDnbH9y4xc4DMTXRzzG9fYfyeGadLnoalAsg9JbBartRCfeWJYfOchTrw9bKl54QWVQDgiw7NWk7AKcVuw713F6qbvQF9X1+vY7AuYUwKGDaRcSxGZVulA5vhCfmK+hWvCeGcS86Ei+B1xVgJ1p9bLSc9O221QWCFWKSTGfuH5EiKwSxg4LM5DPY/lyfIFjvpzn9DJeA/t97Itu3lGU/27f0FO65dDapSVdMy7nVSjFgvAA1RkBJrhPDVcHHAp647C1PhTvfCSjzY93uaIFJUNibm4dp/lvi1xv5AMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBMAq/dvUi1j1BXirLbyz5b0uz1XbTn7KRmWZb0VArA=;
 b=F4nZicWrZdL3+De/jcTdiJNUNaClnwsDgPjZeftbFnZkGyzWklbJ98S2Xut0Fm8QbOo7z+9pUf1dxO1zhZOcPqmsOopM/NRrE9t2oG1mtLOXy5DSwaoUHcIQXb9hNNXjq4jEysDHv/gKQyG3KowrpjUNg+ZuBmrchkUV2AxZfRj9cXchNKEojQ6hKwfkXMTExVNz0Jfz9VvJa1FZ4LyE7opfk+yMGU8vA5R3EOmDsM7BA6Wx/L08ylpF4kobXbeaPK4U1jEAU3HOuOSuJ9gpvQ1UII8eTg23+bM720PDZSbglFtdYo5ydKf2BMK/QQwr6sU10+qoXPeLTFD50hBZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CYYPR11MB8360.namprd11.prod.outlook.com (2603:10b6:930:c3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.27; Wed, 2 Jul 2025 11:04:30 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%2]) with mapi id 15.20.8880.024; Wed, 2 Jul 2025
 11:04:30 +0000
Date: Wed, 2 Jul 2025 13:04:19 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>, Eryk Kubanski
	<e.kubanski@partner.samsung.com>
Subject: Re: [PATCH bpf] xsk: fix immature cq descriptor production
Message-ID: <aGUSM6EncW/7j/B1@boxer>
References: <20250702101648.1942562-1-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250702101648.1942562-1-maciej.fijalkowski@intel.com>
X-ClientProxiedBy: DUZPR01CA0350.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::22) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CYYPR11MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca46533-5aeb-4e6b-38ae-08ddb95837a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YK67HFVxvN7dPt6hiDNk7jGnHnRlxF+VTC2uUakyIY5WTkqu1Yr/lptoAQ76?=
 =?us-ascii?Q?jI+Wb1IVzEra8oRabFtI3UmYmAWr+KBl6NYp6mF9pMAxfRJlRyQWV4rhPabP?=
 =?us-ascii?Q?HsRbKX/LJXvZv3Ki9g1TLMdGKFosnwZPeJ8I1qpkxAFomyGxGRDXW2A39g6b?=
 =?us-ascii?Q?VFX28gPIjO2T5Cdp1h8i94zNP4eJNoq02flEFhLHTt7JkD8FkyZW+TCrsjI8?=
 =?us-ascii?Q?2JmcJUkHCcydyWNMbEj0FRT7lTLYHXhFhujPcByR1Mfx+opyWgQwKQxLsFTK?=
 =?us-ascii?Q?yJABxDG7b49Pz3MkniWVpWeHDhhkLdoS9u4wPMeYTMgjutzpRf6KDsy6l83d?=
 =?us-ascii?Q?vzTtTIQnE4kj+vn5IVruTKcE9oz/02Csy9mwVInjtKutWEJmY80s3MD1uE93?=
 =?us-ascii?Q?eX69rpGzQJfWMJLSsNLvdD6bGK4Zj/5Nrr2C6Wr+1wpyOlvhJNVYzVefbtxz?=
 =?us-ascii?Q?k4AmXOIOuIZVNeGPOQYUe1JyeejZRYjEPpETn9BmJsc64axm4P3DMs/AXDfz?=
 =?us-ascii?Q?E5vu596BJCzVyoCcuf+c7O2wjMbqLu/r7s92UDnstxxjZaXKsmfkM6ty9xZi?=
 =?us-ascii?Q?UlDiPQVKZ8DRUO/ANpqvHJNzT9m3L/ObjxvLMBMRML/gBCYX2m9O5ERaGM+E?=
 =?us-ascii?Q?dMGImKkuxiWpZIouw4oDGNUTMYokk1MHBxfPjF8pWO5y4G6TWVqHV6o4NGXW?=
 =?us-ascii?Q?e1TesASG1lYhf7PfK9xDNbVrXgBgnbJBOjtG3xfh8C9lsE6n8rT1dc+8amBg?=
 =?us-ascii?Q?uDDWDDbFAL9ZrtOUa6J+s4iY7IzcUbL7HkghSi4PXwvGx0+/vIUhwhNYN9Ff?=
 =?us-ascii?Q?nNDxh3MxdVPsFRoVWmjNM3IHfxkhG519Yi7gWlh5fdubi6Ef+FOcYvHl0urO?=
 =?us-ascii?Q?/fy1CK7NBvKhikHNGzNnYiyhzQfyJjh/ce1oqWFSAN38TyKQgeSlM4IPfRlc?=
 =?us-ascii?Q?Ni5sK7BcSNlCZbwjgsk6xLfFrRG27O2UFyttsnGNb326VuSbjRqL2kWj8XME?=
 =?us-ascii?Q?LFH4uQyNbqkspqOEJ/MM+U0K8NSC7EcR9w+yb9nH3OaDYwM1b+31Af99VpvJ?=
 =?us-ascii?Q?S7ldTSZhEaZVGl3k2KWo/79ogYDwV0vCmRShGnlX+Pb0wCwXOsBCJuf9pBJy?=
 =?us-ascii?Q?ApUCJTkVTspNm3mHO0WaLHjVvrI2GjxnMZiYsCS8GEExV7o8rGSjVZE5pSaB?=
 =?us-ascii?Q?OlgZUmMHgqbbWEDbSf0CqwGPaPWs1tSFwXpGo2W+VzKIu4WttYGcffyYXKlx?=
 =?us-ascii?Q?15jqd4HmjyINjPZLqsAajtCvL9viI7aduvsqBmuY9nlh+g8TOM0bYxVvAntV?=
 =?us-ascii?Q?5xnt0kQprV5TcdhZhddQVYPbaJ10Ez9bVnefaf8XsLlp09/Qb7xYDhxNvpGs?=
 =?us-ascii?Q?n0lwUjpKarg/wGXmNBmV4XKmmZ2IYdFYJeHe1akUmkIa5iQOc6I32iQ01AF8?=
 =?us-ascii?Q?+nSXoMPXrm4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NX2cA30LCsph6uiFhc/YhMpJQpI97ABGcIomQ+Qit/aD/+aCCB5sQ4FEVE+k?=
 =?us-ascii?Q?xfjE3qp09vnCQ2i7xh02yp+UvGmG6cwDol8rRpDB0+Prg1s7WovfKFHOf1sd?=
 =?us-ascii?Q?jvDPxyJWkmGYuCN4F5UvhVm3QDLmnEbogGfdAVdky5HKGgHUXH9PaIZl8v5T?=
 =?us-ascii?Q?QWSrY/mZ+MKt6+OAO1Qxm2ZWKOFZMzpUtQdHPLp0WqhB20EMYHGtNqqd7YI6?=
 =?us-ascii?Q?j7gZxhumYLnhZROzi+jqyoN6KAr/c1lQT3vNan6bcQkxnQpZ9X96dz8rZDLZ?=
 =?us-ascii?Q?or2JjrGaMAi7HyocEZ6IQR1kTU6y+GUwbOhhy5DA2ETo15jphsrV9KEUf705?=
 =?us-ascii?Q?+jXMSJeowSsNmLtLeJVKVQx/CPkB92RFb5I77qh0M4wEwnv0YEPnck+36mfB?=
 =?us-ascii?Q?KUaM/D+XUExzc9Xu37+paRog3B9vHTS8fkFSvHOibK0LgLF9Oohg/UXPkWPV?=
 =?us-ascii?Q?qnm3KeO1/JyWY3Ab4sbKXS+MnkjkmrSf5X7I5A8LUX2sFBIG6HxchykA8vQz?=
 =?us-ascii?Q?NFrsnv2fTZJY0GqpmLzkoOiqzWxFzfcdZXqIBaNT5QEBdhlXHcoYIvhbYMtY?=
 =?us-ascii?Q?HuTsTXU5USF7hCpdT8Dszn01rrtKlxdJXDev9H6tYLMvGkFqpZPj4D2sQ1eJ?=
 =?us-ascii?Q?WtHuIOOg6pMoR6iv1lcrtyibDDLy/gvuUpiscdh/etF5XzvBRoScKHDSGOG+?=
 =?us-ascii?Q?VMYXmVY7zUXOZeE3NeJIKpzGmgPdIrcusj3yiQMPs78pRUh6q5suPRL18OP6?=
 =?us-ascii?Q?/1DhrJDRZR7+Wt0csxCXxFNSDW08Gtft7LVYJnMIs8EdF0SlFhUWoHw5gdIK?=
 =?us-ascii?Q?KjNO/PU675l4xLnxXgkKTA/w7uG5r7hDxQcFrMOULUteoyQVKgArJ6E/Xqq5?=
 =?us-ascii?Q?vYfemFow3qf4Zj/CbdKdHoFCcF4nHnDOGYAvSK+OXCMIXKKaK4a6ayzOpKl6?=
 =?us-ascii?Q?NDGwq2oWvwymbcZXLCjupgwaCuj8SweYTyPYhLh9nJSlCqz3ihd4fpogTO44?=
 =?us-ascii?Q?uWC4Rz/hWZloFkW0sv5cI+0Q6zjKi51K2LjMp/NLl01Aka/DwpZRDu+kPM9q?=
 =?us-ascii?Q?Hml3+XWNhCuuc7Zim4Gzsp4SDNggECiqb6mG3EY1s7XH72dc6fYwY4dLRSuT?=
 =?us-ascii?Q?/qddNk8tqXD77AHbN4nKZDgfqA59W0DzxIc9Zd+Y3JqQIjvD6SPJFTJke9VE?=
 =?us-ascii?Q?/DzG/GDh/VRYHpOXpjBqRieaxOWleC8bLtmBkh0HjzXpUbVwy7UeO14DXgVB?=
 =?us-ascii?Q?QLLVxF0ASN0f3yCJ375CneyUB1o/03C/dmAS7OGg8z99Ssf4I7mei4E026br?=
 =?us-ascii?Q?uo4SH4FIMN2OGIlrU5oT8OM1tyKTXEemWbcqCVQD/p01creG/CtWXafa5P+Z?=
 =?us-ascii?Q?RRTgOvkc1KnIcQa9Kwhw5Sw2y/F0vEVwm5/6O4WZKkKB8QxpPTdEe9ESnAoW?=
 =?us-ascii?Q?ARvj0cRHgIVpa4KayKWtRVRWLqBxB6AGeGSsOU28MLLt02Hocz2pbDjPTSyv?=
 =?us-ascii?Q?5hFSEGNEom/FbMSPNlir5gLL2/pG++FCctY3JTBiKVN4Ehhi7B+1oFc4SSJs?=
 =?us-ascii?Q?zmpWAo2MPGOrHZwbOr9HUDgAH2iXbboDLYAeurYJmoZ+sne2Ye6alry7fHe5?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca46533-5aeb-4e6b-38ae-08ddb95837a7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 11:04:30.0784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tn4p4aXGH95Qf+zjAbprv+Lh8R46QXI1IsMskuXv9z73GicAsn9rAW1ADPI4zkBnnLLn8bmKX+DC1Lmx4+FSzM974JI4iLqLZO4Ep/fL/3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8360
X-OriginatorOrg: intel.com

On Wed, Jul 02, 2025 at 12:16:48PM +0200, Maciej Fijalkowski wrote:
> Eryk reported an issue that I have put under Closes: tag, related to
> umem addrs being prematurely produced onto pool's completion queue.
> Let us make the skb's destructor responsible for producing all addrs
> that given skb used.
> 
> Commit from fixes tag introduced the buggy behavior, it was not broken
> from day 1, but rather when xsk multi-buffer got introduced.
> 
> Store addrs at the beginning of skb's linear part and have a sanity
> check if in any case driver would encapsulate headers in a way that data
> would overwrite the [head, head + sizeof(xdp_desc::addr) *
> (MAX_SKB_FRAGS + 1)] region, which we dedicate for umem addresses that
> will be produced onto xsk_buff_pool's completion queue.
> 
> This approach appears to survive scenario where underlying driver
> linearizes the skb because pskb_pull_tail() under the hood will copy
> header part to newly allocated memory. If this array would live in
> tailroom it would get overridden when pulling frags onto linear part.
> This happens when driver receives skb with frag count higher than what
> HW is able to swallow (I came across this case on ice driver that has
> maximum s/g count equal to 8).
> 
> Initially we also considered storing 8-byte addr at the end of page
> allocated by frag but xskxceiver has a test which writes full 4k to frag
> and this resulted in corrupted addr.
> 
> xsk_cq_submit_addr_locked() has to use xsk_get_num_desc() to find out
> frag count as skb that we deal with within destructor might not have the
> frags at all - as mentioned earlier drivers in their ndo_start_xmit()
> might linearize the skb. We will not use cached_prod to update
> producer's global state as its value might already have been increased,
> which would result in too many addresses being submitted onto cq.
> 
> Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
> Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  net/xdp/xsk.c       | 92 +++++++++++++++++++++++++++++++--------------
>  net/xdp/xsk_queue.h | 12 ++++++
>  2 files changed, 75 insertions(+), 29 deletions(-)
> 

There's a CI failure regarding xsk metadata selftest which I didn't run on
my side, I focused on xdpsock+xskceiver, so I'll be taking a look into
that plus I think we can avoid skb headroom hack by allocating struct with
num_desc + addrs array and carry it via destructor_arg.

