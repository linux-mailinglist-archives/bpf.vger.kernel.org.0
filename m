Return-Path: <bpf+bounces-65442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D06E9B22E11
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 18:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860B13B1E2B
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 16:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D8C2FA0D4;
	Tue, 12 Aug 2025 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nugApamg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FE0305E10;
	Tue, 12 Aug 2025 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016832; cv=fail; b=bIbNNwR+GCmb9XaO2GTHGGER6mofvxdbBUVYBCx3z1a1cuWXH2/92f7J0CJpabXn7xoNxf4ABBfgxLgtxuT0fID/TjWmAkHA5aCnRELfi+bYeIkWZLMdTRgQ9iVq/7Cl7Q8Oq/eJV4Bxb3kkLc36D94ejHFdkHNga/rigfbyoYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016832; c=relaxed/simple;
	bh=aUL3HSGBLkf7rrKjSx2imMcFiR+6/EiXt0MjPJj6NTw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fpUqOuDWHJYHqsdWRtmO5ftdS9fC7Dofe44Hd8wCVlFPSnYCun1WTBHLbcfX0cJEmNXJTx/41zKFORJ5xw5rE7AClWYoIrOsqxXFWe8EQYp0+MUYiVMHMi2rtAVXVnqlUzV8kcdXNKMJlI+u6ypv1MAiradEJVlnspOYrGE7nXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nugApamg; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755016831; x=1786552831;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aUL3HSGBLkf7rrKjSx2imMcFiR+6/EiXt0MjPJj6NTw=;
  b=nugApamg3VqHCMCeHHjMdPZjvVlZwaJZRZe32MgOh+kuATaYxlm52hxy
   tjW5Y5qG9+uavt9vgF+wqKQS3sf+ZIFicJm29/dfan2g9hoX3pt/YG+jG
   lUT/ypje15K6iIxXDWyzW1xFZyr/hiksIyBaA2CghJU4jvZozBAnEgmPN
   3/CG/urn+VXqfZo750lId47v0GW97Rx3skN6xO/NqDZPNtWaTU23UREtk
   5/NC089o9Y93p9mejXN27C3VsNzv0k3JGD4OGW0hvYHunDBcckrD1dR3s
   BVrG6Yb1stTHEpBz/rGLuQa+3Hox8WqPDabnR+K1Mb1KtVpWECQY9A+dm
   w==;
X-CSE-ConnectionGUID: 8BV5eEdhS1y1SJ1NDwx6DA==
X-CSE-MsgGUID: ldy5C8pxReGxsJYQ2CiX9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68002616"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68002616"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 09:40:29 -0700
X-CSE-ConnectionGUID: +apM0HgTQ/ej8aDE0myohg==
X-CSE-MsgGUID: SANl3CByTeCc5hRPNHoyOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166244437"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 09:40:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 09:40:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 12 Aug 2025 09:40:26 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.54)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 12 Aug 2025 09:40:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wra3XmWWSoKI7Wy/UnE7sQwZTB7/9tphboPDVYceBeWWISvLdqvXjeRTniVrL4xrNaZJ99N1oRU7xnxed6vh/5UmDrG0ZncM76rA7fz+ED/Vb8m1xF0h1NbYyANJougkEkTrkiiVv3z4XzEzlZemb3QvGPmy09gLw+QZPrrAvX1IWNzkfBrlmSgQ/JPqkOqwo/XInTyrDrm5+EswbJNh3eINHXZsss+/JjsxVv1FQPX/xfQZvztf8CCABa8mu4hVZCUtXjQDfPpl2fMuf7TAXuY8ZrLXgtCUzAGbto59qHEgHLRSAhGzeRQZgtP6HMG5d14UPaBzJDWlaGR5duidUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPQnrJKMhrvWwXzyK/IuoEWPEPY8UEv4d3T4Wgx5jQY=;
 b=MqUZF38rkYIuKJ7cwzIcdDOIhJkfCa7Yw6Kk+UTk9FIu5+jxnsOHDDLvZ423DNBEeUSECddT4Yvu0t3ZbdlM0XJ1ogDlGpaorjYXY4I9ZsONVoNQRA0mTkBu8hrn0exI0co39r2L/aym7r27ZqQZgCR5uTzBqq1yfKVe6iKxEu0xd1dcFdgh8QA07ZDcXg2pvz0wBT7Y4KLyo1jL7TX9YBV+BrAnWGcqal8nuNFk/hanflWsoN2L+ahWkQvT3K6jODpFAHCcou7PSpcCHiR801heza0h7p8AEVaW/hItWqsT3xDCIa+orhKdeBIZ6JDw6prmjI1ddK0vODwEGe1mEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA3PR11MB8003.namprd11.prod.outlook.com (2603:10b6:806:2f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Tue, 12 Aug
 2025 16:40:24 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 16:40:24 +0000
Date: Tue, 12 Aug 2025 18:40:17 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 1/2] xsk: introduce XDP_GENERIC_XMIT_BATCH
 setsockopt
Message-ID: <aJtucfMw+mXp79FV@boxer>
References: <20250811131236.56206-1-kerneljasonxing@gmail.com>
 <20250811131236.56206-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250811131236.56206-2-kerneljasonxing@gmail.com>
X-ClientProxiedBy: DB9PR02CA0017.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::22) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA3PR11MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf448c7-e420-45e2-b1e8-08ddd9beef85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ImKJ9yMqHWzaa4fHTdU2fbEXNjir6MMH1GW0a9Ut/2gu/JbmjkawvTvemD2K?=
 =?us-ascii?Q?6E4Z274LaRy8tIQIc9JGlzg6lHS1EKLK3nDJT5hUjFCKVQ5Nuncf6qoFgNDg?=
 =?us-ascii?Q?m8DVin0MjwEwNB9NjV1ZZT3EkoEcVHQ9EuXllNO6L9fOYwo1nhULXGYLNiPb?=
 =?us-ascii?Q?eAcr24NKZjaGIX32PLGX5L1M2KBgQ51XuHMMlFCmtepk2zm4elQowYl1TzbE?=
 =?us-ascii?Q?rjFBsn/Go1alU4FgWTg5H0RDmGxi7HzaQGLg1FeH0ZmasNtbWH7b4v0WMeGx?=
 =?us-ascii?Q?zvvUrUXsb7rx2KuQAqS5mfTVWtiQW+U/zmNfJlyEZdpcR+EoIXSo+UYpjNnn?=
 =?us-ascii?Q?fF1doc70FF3zzOLbg8vYnpoSplTeptHgMVKsSQ7uHd7XG6rnEiBLPlqjsVsM?=
 =?us-ascii?Q?T+CkaOp9vp3ktJjDxqDxBndTJQyYiPCoxg/ic1v7weoJGEgAuPFtVGisKPdZ?=
 =?us-ascii?Q?HRkjqGS32JBvOmZEZo3MRPsXCI0hdatLqW7JgjVM/68+cSnNhn0L1HfhtnOZ?=
 =?us-ascii?Q?6STCUwvohFZyjJTii9DgoSVX/lLW/X/Y5H1b9icQZwTY1TNFMZ+erTFTqUNy?=
 =?us-ascii?Q?MYT0pFENKPMBRU9KnlAHQ8LitM63nAwgLgSi6Km0/WwkAVKt1eDoGzw7t68/?=
 =?us-ascii?Q?2ISuGuOWQLq3twMTbbqbIT6gY7NixwIupn48UggU9lVTfMRGApucb1rH2BFz?=
 =?us-ascii?Q?WM0X+BWvQIQBSNa/KxubqmXxIh/8tEHTAvBhUEZtJsKogPVxsxGboKDL32vm?=
 =?us-ascii?Q?Vl9aiQYoM5SIBcv1BkF9u4U9rKvVaLaoa+hJOtlZmDtXCkPqKntmg4SnNmm7?=
 =?us-ascii?Q?5KrEwZawOVCh2FHuby3+63BkWlI5kXJ6gGBmt9MyTPFiEdpKreON7M1921EX?=
 =?us-ascii?Q?WbpBJYE8EZx7+ZpQ0CM8BQ1j4JBNmM1d3qF8gNRWS9Z4nnBWkA81Q+UfxQgh?=
 =?us-ascii?Q?Dp9fWzFv/AM6jGQFmSOStzGhMMLzz92T6peCO1K/hlMIr7Lt7GlDYLRtwk2c?=
 =?us-ascii?Q?7iDhrTEg3Rl9kVZt/XwZSC5Bz9np3nw5g6H9R7qOZmSLKBvQcwyjs3Xcz/ym?=
 =?us-ascii?Q?bhq0m56mDRs+WGULBLH6d9IKzGVKeZ+oV8dIrNmUsYCGr3EUMNZrvRhqCqUU?=
 =?us-ascii?Q?gncNKk5AeGJd1znIyDfFN0gsyJ1I1Yux7ELR3cjHsAeilO45E0xr2zObQ7oP?=
 =?us-ascii?Q?bj52BQ/vncz4lX2DBLJevC+8tsllsFcdiwIW8o9KGuvNV26tq4xZkjm5fA/j?=
 =?us-ascii?Q?Acw2RCh+f4HVDc/Y2MAEQ0EeIbRQ3OLD4Lj9XeFZ0EDeFkq0+K3ysXrsM+bN?=
 =?us-ascii?Q?JRN5GYar1zQ1ptCwZ97226F5tnAVNlPpN76/KsSr+wfnRG71oKkwycsHi27W?=
 =?us-ascii?Q?zqAOctyEiNGIO+79H65i7UswzZXTQBFPfBlwldLjGEGXdWYHNsH0a2KKY8K5?=
 =?us-ascii?Q?DBPbUTRPO5Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5BPOepdSbBHuZl1FV1fRPqR2C3SWDOQ/Xq7D8BMsOD7Tph/zYKikL6yLsOHQ?=
 =?us-ascii?Q?iXXIHF67fxAwoxwknwtn/hBqd8uHDPxpg+9bvMMzDHFY3Yyrx+Je2EJ6RCRk?=
 =?us-ascii?Q?g/qOUpq9dDZQI0AKBx6Sai8IzD9qcq7B3qf39D4KHwkj6BFvZAkH1psZWWMI?=
 =?us-ascii?Q?Z+5/o9Xm7Zxr9U71h6G8/zzoZvtC6IUbLTQ/N7oujtcmk8mwCyZiKDVc6Khb?=
 =?us-ascii?Q?AFH6ow2b36DcrjTaochvOT/xll/SBHYPcZfrE1yhRrp5i748RRTsw86qvwpz?=
 =?us-ascii?Q?BRnNFFcleVhQjhUpQ5Q/7MT3x9vV8v6SW81jKc0TtHOTGdRXZzArtHX8OfS6?=
 =?us-ascii?Q?q1CLMkC0ai5w1p0pG0J7Tto+pVccvdCsjdp8/titFxLx/QxA+6nzxYQ5z7xT?=
 =?us-ascii?Q?khGgpV7IO/bxs9g+AmfKPYIDoPODn1q9ghVKPV3DsLdzmS2rwuxmbhTvIqgR?=
 =?us-ascii?Q?C22AISSpsli63KxwWECFl5C75OPzOmVaZG3CFF3Mjv5cb2J2oFf7SHLnKSF4?=
 =?us-ascii?Q?9ld8WON09zpuA47J/XJzGciR7ixLKQf2xqbnnLm/S9SVnJvJ7khxEw3ccVov?=
 =?us-ascii?Q?MwNNp1v1FY4GuSbBHVO3H1ZcxtUDd1TklNJLEeyFvubjwdK0A5sVguumm3cc?=
 =?us-ascii?Q?uHPEVYMhoR7nmC4u2M/am9OV1ff2f3I77tjk6OgBdFiwpiw8jZHUapK9QKRk?=
 =?us-ascii?Q?IUxgxYSgedPVTwC7CZKYXnmLJ/5OcAt94SbuGgF6/57EnQ4NENftQU8IgrZl?=
 =?us-ascii?Q?w3A6kQavZqsn3nPPkry9vFrGD2S3EQ2NNffO0MuIkGIyObCZ1fNMMIUPyjQ6?=
 =?us-ascii?Q?lj4GiOfTNmAFQhXb0rJu1Ke6RRny/IyW85KovwHDHWfd7SWrofbOITY0IhA8?=
 =?us-ascii?Q?UqHYEWra7C+IW8xr4f1WLY+n7TjuCLJ/8TsqdB0DSlEgxu5vNSugbXTbOHO3?=
 =?us-ascii?Q?GtGP7MA7xrWSWaBuB7l69CrVXIAHrQ/MG/RSW+KK1VB3jNmUdESjY29uXTr4?=
 =?us-ascii?Q?9xRYSOjj9B2dEQ5Qr4O/++BV0sSUkrUfQxk7meqfScBlh4+hkMLHaDFW7TOM?=
 =?us-ascii?Q?PoeRufBcGgIDkVNdQqiBmSN2AEWBIrRy5u0Z1XAEsrQ5bE6TYMGTyoHACKAd?=
 =?us-ascii?Q?GytWNvRMKStuyjmRaUHxfwRTbG+vIW/6pyRO9BvM4R8eZisXPBq8kmrD85D+?=
 =?us-ascii?Q?WBMCCVlOeuXRH01uxxiQ4KtmkTK8tHmyCwmy0ru1QNXa/OxsUuXkrqNSGtt8?=
 =?us-ascii?Q?EGsudWbak06B9DEZZwfTmvKNPwocSRt2/R7ClwHF+cNaMkILOJyWFq5OQOgY?=
 =?us-ascii?Q?VFTxLS9dEFwljItp8Y9H2FxMkpOc1gkStaVGxv9WzzLbTxpjaUYHY2foPYek?=
 =?us-ascii?Q?puhAm+HPpZ0yaQJ/VSAaSnEluTjwUfEQKbS6cwpm+aoAhieAEg1MYinRDnAs?=
 =?us-ascii?Q?jQAlSvXrbPVPBZ9n/aLMOTNv4eUAE3OntUIonBVRlmBxf+8JKptGEeV2jPFv?=
 =?us-ascii?Q?Tiyp8Lc/0uZRQj7OGYgFZYl4X1+4vQ8+Ao6AKRUj7LtY1gBMxpiiWsF7By1g?=
 =?us-ascii?Q?0GfxqgEHOEk6jgX3zr8hHu2BMohsfNOGmkFrl8qUKBcEo/1Ol4qMbmaRFEy8?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf448c7-e420-45e2-b1e8-08ddd9beef85
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 16:40:24.3512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: doF8L4rV1hI9D8BW1pxfBpfMT33/rzOs9SfREWJMUySLbdLakNIBe9dWFcyYzkBBz//TmARSAFTBu8Megk0WiDSGNpV1w9loP8x3B5rjeIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8003
X-OriginatorOrg: intel.com

On Mon, Aug 11, 2025 at 09:12:35PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> This patch is to prepare for later batch xmit in generic path. Add a new
> socket option to provide an alternative to achieve a higher overall
> throughput.
> 
> skb_batch will be used to store newly allocated skb at one time in the
> xmit path.

I don't think we need yet another setsockopt. You previously added a knob
for manipulating max tx budget on generic xmit and that should be enough.
I think that we should strive for making the batching approach a default
path in xsk generic xmit.

> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  Documentation/networking/af_xdp.rst |  9 ++++++++
>  include/net/xdp_sock.h              |  2 ++
>  include/uapi/linux/if_xdp.h         |  1 +
>  net/xdp/xsk.c                       | 32 +++++++++++++++++++++++++++++
>  tools/include/uapi/linux/if_xdp.h   |  1 +
>  5 files changed, 45 insertions(+)
> 
> diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
> index 50d92084a49c..1194bdfaf61e 100644
> --- a/Documentation/networking/af_xdp.rst
> +++ b/Documentation/networking/af_xdp.rst
> @@ -447,6 +447,15 @@ mode to allow application to tune the per-socket maximum iteration for
>  better throughput and less frequency of send syscall.
>  Allowed range is [32, xs->tx->nentries].
>  
> +XDP_GENERIC_XMIT_BATCH
> +----------------------
> +
> +It provides an option that allows application to use batch xmit in the copy
> +mode. Batch process minimizes the number of grabbing/releasing queue lock
> +without redundant actions compared to before to gain the overall performance
> +improvement whereas it might increase the latency of per packet. The maximum
> +value shouldn't be larger than xs->max_tx_budget.
> +
>  XDP_STATISTICS getsockopt
>  -------------------------
>  
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index ce587a225661..b5a3e37da8db 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -61,6 +61,7 @@ struct xdp_sock {
>  		XSK_BOUND,
>  		XSK_UNBOUND,
>  	} state;
> +	struct sk_buff **skb_batch;
>  
>  	struct xsk_queue *tx ____cacheline_aligned_in_smp;
>  	struct list_head tx_list;
> @@ -70,6 +71,7 @@ struct xdp_sock {
>  	 * preventing other XSKs from being starved.
>  	 */
>  	u32 tx_budget_spent;
> +	u32 generic_xmit_batch;
>  
>  	/* Statistics */
>  	u64 rx_dropped;
> diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
> index 23a062781468..44cb72cd328e 100644
> --- a/include/uapi/linux/if_xdp.h
> +++ b/include/uapi/linux/if_xdp.h
> @@ -80,6 +80,7 @@ struct xdp_mmap_offsets {
>  #define XDP_STATISTICS			7
>  #define XDP_OPTIONS			8
>  #define XDP_MAX_TX_SKB_BUDGET		9
> +#define XDP_GENERIC_XMIT_BATCH		10
>  
>  struct xdp_umem_reg {
>  	__u64 addr; /* Start of packet data area */
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 9c3acecc14b1..7a149f4ac273 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1122,6 +1122,7 @@ static int xsk_release(struct socket *sock)
>  	xskq_destroy(xs->tx);
>  	xskq_destroy(xs->fq_tmp);
>  	xskq_destroy(xs->cq_tmp);
> +	kfree(xs->skb_batch);
>  
>  	sock_orphan(sk);
>  	sock->sk = NULL;
> @@ -1456,6 +1457,37 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
>  		WRITE_ONCE(xs->max_tx_budget, budget);
>  		return 0;
>  	}
> +	case XDP_GENERIC_XMIT_BATCH:
> +	{
> +		unsigned int batch, batch_alloc_len;
> +		struct sk_buff **new;
> +
> +		if (optlen != sizeof(batch))
> +			return -EINVAL;
> +		if (copy_from_sockptr(&batch, optval, sizeof(batch)))
> +			return -EFAULT;
> +		if (batch > xs->max_tx_budget)
> +			return -EACCES;
> +
> +		mutex_lock(&xs->mutex);
> +		if (!batch) {
> +			kfree(xs->skb_batch);
> +			xs->generic_xmit_batch = 0;
> +			goto out;
> +		}
> +		batch_alloc_len = sizeof(struct sk_buff *) * batch;
> +		new = kmalloc(batch_alloc_len, GFP_KERNEL);
> +		if (!new)
> +			return -ENOMEM;
> +		if (xs->skb_batch)
> +			kfree(xs->skb_batch);
> +
> +		xs->skb_batch = new;
> +		xs->generic_xmit_batch = batch;
> +out:
> +		mutex_unlock(&xs->mutex);
> +		return 0;
> +	}
>  	default:
>  		break;
>  	}
> diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
> index 23a062781468..44cb72cd328e 100644
> --- a/tools/include/uapi/linux/if_xdp.h
> +++ b/tools/include/uapi/linux/if_xdp.h
> @@ -80,6 +80,7 @@ struct xdp_mmap_offsets {
>  #define XDP_STATISTICS			7
>  #define XDP_OPTIONS			8
>  #define XDP_MAX_TX_SKB_BUDGET		9
> +#define XDP_GENERIC_XMIT_BATCH		10
>  
>  struct xdp_umem_reg {
>  	__u64 addr; /* Start of packet data area */
> -- 
> 2.41.3
> 

