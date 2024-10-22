Return-Path: <bpf+bounces-42794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27919AB253
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 17:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CAF51F224A3
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 15:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259BB1A4F01;
	Tue, 22 Oct 2024 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S52lKPhH"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10ED1A3A8F;
	Tue, 22 Oct 2024 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611753; cv=fail; b=ESBamJgMzGLt9KhqFgaIa47fAguKdvTf38/5EUtuQag+NuI0qa6+fdL/C8tapJbRhSdU64tdlq8UKPEGWjAlvNFXOPWIwcLmB/iyUSvVE4Uj4b6GPvsaClMVKFG/vPwf86FnDvBFgvJqYcO2u11tcb9bMsUbyxsInEWrcXw8yfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611753; c=relaxed/simple;
	bh=p8znTkWCOTMsMEuq5NaDiVSXvx3tT+CA4lrCkFYdpio=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MIWM8MbslpD5FH/bNS1KsO/XTl4tgLAyC8MOeE9RjR4b3Mg5maXJwqg0psNBXtyIhBzNVPM3LiC2kiEpBESEaOeAH/8UOEDR6v7ffdWfDxdamS1SMet4ljGsyT/5qnSf1UjOkaN6QAxHRHXMF3DHx6kQxefDw202djfmWlbYZjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S52lKPhH; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729611751; x=1761147751;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p8znTkWCOTMsMEuq5NaDiVSXvx3tT+CA4lrCkFYdpio=;
  b=S52lKPhHrjRbl6W+F/+hfcYGT/re/nW49skK0yj0T6cM4zCjY62KgAak
   CRyvvdG97E/z8V9JnpBC2w6ioeqIB2XQrBTXujozMh2Yt2kSJpP9gsi/G
   aUquYGBIC0XtsVLS0KtiYGepJfclgDwPbI/XPbevosZMM/SeRbhqsGaQq
   NXnCTN2FSe2XDagbqWTloyrCRth5gIM2PIqx6pNXzvaghOSx1XhWZ5LMs
   jrYx9qtmb2h3Jy+Ht/2b8G48bm6AkeowEp0/LqgxJmKO5eYlQ51rZBJwf
   lDVTnqSu0ePLOOPPWa2+rIRlUMwzeKMj65f0Pq5kvPSYrdob/fUJqV4j1
   w==;
X-CSE-ConnectionGUID: hx5+9RdGQZiH8PEV0MyIFg==
X-CSE-MsgGUID: 3m9urmScTqGHV+BLvtfXOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="28592822"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="28592822"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 08:42:31 -0700
X-CSE-ConnectionGUID: UmZS/91VS/23PubkN403tg==
X-CSE-MsgGUID: rZDe9wGORaq+vXeMRHpZ0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="79831450"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 08:42:31 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 08:42:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 08:42:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 08:42:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlsjWmp+37vW8dQ5TYRc/75smWXmkTIw+e0RfvDsGzVjDP/O/5ad8f3ME6pzaZ6R8lbFJMiKahFzy3LcZNfz9cmxJl9oFyT9AKkyBGtJRofPJZ9DI9AG2StjEZBgkx1oxYlsyW9H/t8WgO1obElhbJSdGhoEmdKxPNM4kqG0M5pReoXyHETWV9M8bMsYpDdC8b7d4tQEYqBXc2+Vt2ckU86OkFzUpoddh1skqdQoxtJYq96zZO7WJL5ci6oFSvEWvm7prifefui+7qTMWiuwQDlSyRPeUKWJ5izoPN3c7sWovhfJch5YPGmiwW/NmzbRzY0jSJzgs95IoMZwSm7Wmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65ilzUApj7HEXT8ZlLLW4eZ1tcySdfzas5MCd5DEr7k=;
 b=XgEkZ5/9A+fLbtIVD8b3RSlCI3A6lBxpxsrIYT2ou/gGEnFz7kFkjUDC7Q8fVAuwJAntSDkbt9GisY0XZ7VGqi4rOourAmWQOJFjSCI1pQPx945lQIPpAtMYWX1udmo8k3Znq5WxaU9CMBZ5FMNLdsBFRDrrYvEWR7jkpiPVZcOCk+IRlQyxs5PPWzDKpgZgPqNJPHTOoDcuJtmeh9q7hCA3d6BIBpv5OCmRg7mDw1GYy0T+9Hpwvt13nLattbMlEew9ELMZZceaWSPsam+ijUwjUfRM0xtQBEZEiklPtky8Av1rjqOvWjzoIt2KY/NtD+ZtImfd5IBxCYMgPz3IzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB8092.namprd11.prod.outlook.com (2603:10b6:8:184::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Tue, 22 Oct 2024 15:42:26 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 15:42:26 +0000
Date: Tue, 22 Oct 2024 17:42:13 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?=
	<toke@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 16/18] xsk: add helper to get &xdp_desc's DMA
 and meta pointer in one go
Message-ID: <ZxfH1VmjcVdLeKUo@boxer>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
 <20241015145350.4077765-17-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241015145350.4077765-17-aleksander.lobakin@intel.com>
X-ClientProxiedBy: VI1PR07CA0137.eurprd07.prod.outlook.com
 (2603:10a6:802:16::24) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: e34b68c2-9c2f-4141-a8f5-08dcf2b02142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+c7ct68Rvn2NiQ5+7ty2GxB2F5sVrxDhEo7zkIDOaKb6y7h4Z1ExzRdYTH2E?=
 =?us-ascii?Q?kHSX7ZxkAYIWwbxbA9aG/PLGHaVBMINPcJKk24JmtfqwgC9wI3lbH2vYAkzd?=
 =?us-ascii?Q?S4vjzKxoj9ngy7g0RPYzEgrhR0Svl932fIAHb5MmuE3zPc3elkrlgrFCoFyb?=
 =?us-ascii?Q?ownG/bjO22cN00K/x2Sc50tRb6X9bODA1n8UUkJ7hwog7BlLYJn+0b8eAhl3?=
 =?us-ascii?Q?UbPl+CtGGU2CL+DhmVdhJ98cudN7Qj9gplBcV5CjgOFtaUnagvfDGfwPqNPp?=
 =?us-ascii?Q?eBXYLu79QfPvS1LXpSRMmDVdudAExNNyJmgSFPB7DEuh/1zMy7VBDUXjD2xu?=
 =?us-ascii?Q?leENZvATbbXrz1owuZAxWjLmKhMeE27mMPehlRPKJmArKu4x6nLXXvXDgKJZ?=
 =?us-ascii?Q?lIjYfSxGr4cQTsuUipmu6FL10NfJY8L5ylPCehw4mjiWCS89FZp2Vjm9HwdJ?=
 =?us-ascii?Q?zcEmToCHp/SjzEAoJraqmq1YiTiaO5AChPREjRSLt2NwKelhXFBYqaQRu1fL?=
 =?us-ascii?Q?DGpiG+vNtlRGCEERVPRWUnGjT54Q3wGM+47pZmW5KN8r1NteYDw3PBPZ/8tg?=
 =?us-ascii?Q?jE0EbvVmVBX/iEKfOHRgESDuL+ia7OSFmXRNqlAA/qsmYeRQODbBJqj0mygz?=
 =?us-ascii?Q?Xjtf3WG9bbziv9+PV4Sa6YYkuvezUXjwjfRLjkz+LE0ObJ70qZ0FqSpfwHgv?=
 =?us-ascii?Q?ZkHhIJqGnQ0oX2EV4VKrjjOdCV/YhvZcVzp3EQO8HQGWQ9Otb8Ssea7zdC0m?=
 =?us-ascii?Q?7vuhjR5gUYAQzmFHKocnFs8yyRRdaFJbDZvbBxox4wwBXyDvGmEgmOg6KPVd?=
 =?us-ascii?Q?pABvF8bLU1Iiw70h6AC4bDy9aqKX2sffsCDWvibMW2eSceQWeihpA/Pm2vp9?=
 =?us-ascii?Q?nZ/zC0gJOQTM6d7OpCTpLhxcCE7GHfda0eFK4Bu7QLcLGdC5URSVO5WZkDqs?=
 =?us-ascii?Q?4cGLxcmPQ+My8CrMK01oEOT05sQHLrzKxRcz6UzkA4//ufCM75ipl53kKqDm?=
 =?us-ascii?Q?MSfwUiFwy691nQnNSfe+l6RQQxAeJYYwLSccQ06vX7x8xFgtBbQeDVHLbUNW?=
 =?us-ascii?Q?+Cvnyp0FxUQSS94ZbjGIuPldhkSOiQIAtrFEv9UClWwmPmbunVAFTEc/7CIq?=
 =?us-ascii?Q?Z8zIc3MopPC1ZJykfxrzsY4+Sv+DFF3bNWrhTAGPtlH6+2KbFYimKwk6uyNr?=
 =?us-ascii?Q?L0ZzDwCco2p4J1zULG2nTMXQyHPTZVaQwTdNsS019TQyPo8AeRpoxZuOyrFp?=
 =?us-ascii?Q?e67j17l+sjT7m8c6FwbUrB+WXm1lZPVz5YBIPtsRKmgX1ynLHn3iTbBVzfdu?=
 =?us-ascii?Q?b/U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VHIYy9p1MsGeMUBDd4dDXC7CkUfik36sOMXgrjD92l1ce6rz5Ffzg+V6JKri?=
 =?us-ascii?Q?4/heVP7kp0QtJeLOTXMXkImhifmycVQ1EFVYDpfAwxctdAilRJITqLWKym45?=
 =?us-ascii?Q?jG9/hl7UcBxtPIR2sGpR6WSqNfGTPcsF2eXHzfOE1t89PAALhcYubLy5/5pD?=
 =?us-ascii?Q?tIRgsiYVKi0VZoGl7Nq8kJnUnzQ5azni76Gr+yptogt4/Lniij7VzTb0S+4r?=
 =?us-ascii?Q?fIL9iaaedzPOJgsMfYOyu8ve+btYKWF4Pl1nRsf2rbLgNduOZnD51iAG3xRH?=
 =?us-ascii?Q?cpYii8MhXyAILhDd+NjpHbrcDIEIpd/JNezWm7+hpO5Ef4qHaQPnbRrGJ+Iy?=
 =?us-ascii?Q?D1CAtgfSOwuEIDFVcmIX+vfpcHts+6RSSN+XNig7iV3WtKGd52wgPTntgSMZ?=
 =?us-ascii?Q?1DnXrzTS/SKuUu6mALJ/QS5J0+MmA1tX5M3FBqc6WJL6ybVUoY84Pl+uy4Ga?=
 =?us-ascii?Q?DMItFU1cYVIg2pBjJHFADayt9IFPcOdk9Kjp2/f/yIyKLXE8CMKT+2/AUKip?=
 =?us-ascii?Q?iEsC3mz3jiVash9AXY+66tRNjvii2MKfqlUx9haR3Ku9i+S8P8RkWDDtBKk8?=
 =?us-ascii?Q?DWM1RGb4mEepCoQvJ1+TR1h9F+FwYoJnFge4hxhZb81hrYH1JsOZYrbM0RD9?=
 =?us-ascii?Q?VygoChJDcOU9JWPQkUiTrs1lD58tgpoPH9XKhBYVr0nD5zwxF3Ovc2qqSuH5?=
 =?us-ascii?Q?6+FopAM6yGDNMt0ztc8ebrAsQByO5bLXbD9X2M1ujyfqbl3M+bfw+q476Dzo?=
 =?us-ascii?Q?JBuqIU0BnaEBlSn/pRzFMjZl4+2YdizBqPC2nPrh2I6sUjhE6a1cOGC6wXNF?=
 =?us-ascii?Q?sRrGDi61fJ7Oo3x9ZatW1agQ6OWs3fs1oOQzHriQHJx6xvRLIkTDxHIM5IA0?=
 =?us-ascii?Q?0MQYssT3FLMAIKeoY+hVXwprydjqH+sZ1Mo+wSR81NQHEnMb7AUooVDkCCVA?=
 =?us-ascii?Q?cRFv0ly6LaAaD79j1R+TR0/q7EEy5sLJOxgBnsh11Ke859egObXcHAJMWuOs?=
 =?us-ascii?Q?DYqz7bGXGkxG96en2U/dOQi6y1wQpO2PMcNvkEV2pHC75HN2MysFSVmrX8N/?=
 =?us-ascii?Q?jZH0bmxd8urX72tIR5CWutkkI4GWcwgkIl2OI7s1kx/OIqgL3uZnQs+KBBy+?=
 =?us-ascii?Q?UFGV6xunBBNflhcatDX6ORRMk9vMy4iRMPI0uMuSWXUmYK55I8Fy7uk4Lqu6?=
 =?us-ascii?Q?SfV2dHeb8ziUGoRihgeIf0FQnGKg38eE0rBZ7HOM9VOK13/NsGtmZAcI/Kv7?=
 =?us-ascii?Q?PfT0FzceVeEenOmGGlYmizFDj9ORT0IjWFqllI4SIR5rNbVM9dyJsaacGmXR?=
 =?us-ascii?Q?84mx/xdk/Rru1Y8/Jddr7eAcZLVWnDLcpJTj9RD6Ub6SYjE5JRXicrqfVp1z?=
 =?us-ascii?Q?uRX2BWpIMhardlR8AS4zE4G/6thx0sF0RXvDaaJWMJgv9RPXzu+4zzO+pVGH?=
 =?us-ascii?Q?tjVwX4vGaKfpSVxDOuZ04sliBEC6NaFi13HyO23OAZ84EHJ5Wx5IrqM6kjyJ?=
 =?us-ascii?Q?fE+QnhFSx66pP2lDoQ9jy/wo7jieR455duJfB4Vk3GvnxMeuu3JeMeyhF0MX?=
 =?us-ascii?Q?8arOe/FHY9CS2hcbB8M4dn9P/2c79X29zFDcqooxhQTCCTejLbLO+FnYqblv?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e34b68c2-9c2f-4141-a8f5-08dcf2b02142
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 15:42:26.7612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxfneScIiLCPV4b8ptmzvdldGLwBmTzZZ+flrIaew9V62f2EdJhH7eRJFPs2fR9N1s45jVeE7BFJOmeZCeNJx/mQ4IrBNsAl63DtdW/LjjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8092
X-OriginatorOrg: intel.com

On Tue, Oct 15, 2024 at 04:53:48PM +0200, Alexander Lobakin wrote:
> Currently, when you send an XSk frame without metadata, you need to do

you meant *with* metadata?

> the following:
> 
> * call external xsk_buff_raw_get_dma();
> * call inline xsk_buff_get_metadata(), which calls external
>   xsk_buff_raw_get_data() and then do some inline checks.
> 
> This effectively means that the following piece:
> 
> addr = pool->unaligned ? xp_unaligned_add_offset_to_addr(addr) : addr;
> 
> is done twice per frame, plus you have 2 external calls per frame, plus
> this:
> 
> 	meta = pool->addrs + addr - pool->tx_metadata_len;
> 	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
> 
> is always inlined, even if there's no meta or it's invalid.

when there is no meta you bail out early in xsk_buff_get_metadata() as
tx_metadata_len was not set, no?

> 
> Add xsk_buff_raw_get_ctx() (xp_raw_get_ctx() to be precise) to do that
> in one go. It returns a small structure with 2 fields: DMA address,
> filled unconditionally, and metadata pointer, valid only if it's
> present. The address correction is performed only once and you also
> have only 1 external call per XSk frame, which does all the calculations
> and checks outside of your hotpath. You only need to check
> `if (ctx.meta)` for the metadata presence.

IMHO adding this might confuse future users which approach should be
preferred.

Thinking out loud...couldn't we export address correction logic and pass
the corrected addr to xsk_buff_get_metadata and then add it to
pool->addrs. But that would require modifying existing callsites +
addressing xp_raw_get_dma() as well :<

Standard question - any perf improvement when micro benchmarking? :P

> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/net/xdp_sock_drv.h  | 23 +++++++++++++++++++++
>  include/net/xsk_buff_pool.h |  8 ++++++++
>  net/xdp/xsk_buff_pool.c     | 40 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 71 insertions(+)
> 
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 6aae95b83645..324a4bb04431 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -205,6 +205,23 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
>  	return xp_raw_get_data(pool, addr);
>  }
>  
> +/**
> + * xsk_buff_raw_get_ctx - get &xdp_desc context
> + * @pool: XSk buff pool desc address belongs to
> + * @addr: desc address (from userspace)
> + *
> + * Wrapper for xp_raw_get_ctx() to be used in drivers, see its kdoc for
> + * details.
> + *
> + * Return: new &xdp_desc_ctx struct containing desc's DMA address and metadata
> + * pointer, if it is present and valid (initialized to %NULL otherwise).
> + */
> +static inline struct xdp_desc_ctx
> +xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
> +{
> +	return xp_raw_get_ctx(pool, addr);
> +}
> +
>  #define XDP_TXMD_FLAGS_VALID ( \
>  		XDP_TXMD_FLAGS_TIMESTAMP | \
>  		XDP_TXMD_FLAGS_CHECKSUM | \
> @@ -402,6 +419,12 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
>  	return NULL;
>  }
>  
> +static inline struct xdp_desc_ctx
> +xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
> +{
> +	return (struct xdp_desc_ctx){ };
> +}
> +
>  static inline bool xsk_buff_valid_tx_metadata(struct xsk_tx_metadata *meta)
>  {
>  	return false;
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index 3832997cc605..6c540696a299 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -141,6 +141,14 @@ u32 xp_alloc_batch(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u32 max);
>  bool xp_can_alloc(struct xsk_buff_pool *pool, u32 count);
>  void *xp_raw_get_data(struct xsk_buff_pool *pool, u64 addr);
>  dma_addr_t xp_raw_get_dma(struct xsk_buff_pool *pool, u64 addr);
> +
> +struct xdp_desc_ctx {
> +	dma_addr_t dma;
> +	struct xsk_tx_metadata *meta;
> +};
> +
> +struct xdp_desc_ctx xp_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr);
> +
>  static inline dma_addr_t xp_get_dma(struct xdp_buff_xsk *xskb)
>  {
>  	return xskb->dma;
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index ae71da7d2cd6..02c42caec9f4 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -715,3 +715,43 @@ dma_addr_t xp_raw_get_dma(struct xsk_buff_pool *pool, u64 addr)
>  		(addr & ~PAGE_MASK);
>  }
>  EXPORT_SYMBOL(xp_raw_get_dma);
> +
> +/**
> + * xp_raw_get_ctx - get &xdp_desc context
> + * @pool: XSk buff pool desc address belongs to
> + * @addr: desc address (from userspace)
> + *
> + * Helper for getting desc's DMA address and metadata pointer, if present.
> + * Saves one call on hotpath, double calculation of the actual address,
> + * and inline checks for metadata presence and sanity.
> + * Please use xsk_buff_raw_get_ctx() in drivers instead.
> + *
> + * Return: new &xdp_desc_ctx struct containing desc's DMA address and metadata
> + * pointer, if it is present and valid (initialized to %NULL otherwise).
> + */
> +struct xdp_desc_ctx xp_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
> +{
> +	struct xsk_tx_metadata *meta;
> +	struct xdp_desc_ctx ret;
> +
> +	addr = pool->unaligned ? xp_unaligned_add_offset_to_addr(addr) : addr;
> +	ret = (typeof(ret)){
> +		/* Same logic as in xp_raw_get_dma() */
> +		.dma	= (pool->dma_pages[addr >> PAGE_SHIFT] &
> +			   ~XSK_NEXT_PG_CONTIG_MASK) + (addr & ~PAGE_MASK),
> +	};
> +
> +	if (!pool->tx_metadata_len)
> +		goto out;
> +
> +	/* Same logic as in xp_raw_get_data() + xsk_buff_get_metadata() */
> +	meta = pool->addrs + addr - pool->tx_metadata_len;
> +	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
> +		goto out;
> +
> +	ret.meta = meta;
> +
> +out:
> +	return ret;
> +}
> +EXPORT_SYMBOL(xp_raw_get_ctx);
> -- 
> 2.46.2
> 

