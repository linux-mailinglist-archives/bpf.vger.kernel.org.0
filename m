Return-Path: <bpf+bounces-69226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8315B91DAF
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 17:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91409423AD7
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 15:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B1D2DEA78;
	Mon, 22 Sep 2025 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HNoX5cuS"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C8F27B357;
	Mon, 22 Sep 2025 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553769; cv=fail; b=qSg2pLce4Y0Y2qKyLe7T9GBmFnJgYxS65Itg2zmdbALLyzpXJ/kBO5T+41WrxpM6K9ikuN2A5bFbWFaVJ2IaKc9cORKWS/teVSUeprhjF9nVWvkYPLLvz6gJOfjnHgcf0H0Ca3/W0Vnh58tXOr7QEj6FwFQUbhmVxEHOvBP3F7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553769; c=relaxed/simple;
	bh=0r+AVAgWyqJo3vHSNv7I4Ml1Rjb6dDnu6stzIWaTm0g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kA5kNm8hQovk/GokFzXn7dKoVDRopsIWQvm7N2+aJsUkwADVgIqHQ3TG7IsfO2eHhLKce55rACd/MzqA1fdBcebf0VpEEqyLJh61nSV8TUKB2rZDa+nJgynv9nv1mjKfFtEPoZwAW0R/2qORd6Cl2n9av62zHRipfSBbvkQipII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HNoX5cuS; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758553768; x=1790089768;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0r+AVAgWyqJo3vHSNv7I4Ml1Rjb6dDnu6stzIWaTm0g=;
  b=HNoX5cuSwqOYi05Fg1bBeKjD+cC0NN3yo5O5zmoGugndBTqaN/9rTE5z
   UBu4+M+WAh+2pDid9xNaOo1RBJ4bPg3FBHVRlTgFNZqTC0H5auPv3Q7ip
   htQj6I9svyxNNrQcUqR73Lg242H19Tb0xkdeW+4wgFcncXyCAE7SPLZDS
   4dxeiykFwUmH1bHBdNLxyZBJPoMQ1WXT7Et/Z6XAjuwUVVEzIDiFVwkOW
   AFZkdzWJhCpCi3Vi8YtVWZ5wrgVLJcowcaNqUmzj1Ud62zCUWr8DWa3hf
   DIQZuVB1ee+Zn9MJW3Ttim8w/XN3hgWk10yLjfYk48dZSFEG+/BXRQsL+
   g==;
X-CSE-ConnectionGUID: 0KVyOxkaQxG31e6g6Ok/jg==
X-CSE-MsgGUID: CGM1NEmwTSyjF0rsyVNjfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="48393894"
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="48393894"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 08:09:27 -0700
X-CSE-ConnectionGUID: zlW3f6NbQhyfyrwt9txNlg==
X-CSE-MsgGUID: XEFYAWZXQ42nFoTxN2HvFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="200206596"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 08:09:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 08:09:26 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 22 Sep 2025 08:09:26 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.16) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 08:09:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Br4nRBlH8SR+BfMz/vkDZeD1Ty4YBVomslGG5hfODqJo39Y4fHNo+n+7tLzB9LtCqolpA6EzfFOQNNNil613xD2vXWDv1MhyOMxq2IZbpn1be6yL7PjQCheOVTHcIVXlVEtcDn1009RwEJPtpvdiUBN+VNml6BA1k5t+My4paLNhdq3FtcAdSonnntljOe85hZZPwhbsB516EgzrPfIdMgPxIRh1oz6iN8dZ12OvPtA1AI4j7UWXk39sO0mf/6I5bTUyLFs1X+DpS8rdMOmr3NzjqYO4/gzSQ7j6vT6KSbolmBy/ZgLangE3RmkEqpzCA1aVcA6cE41qujKHenLbLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmGK9G2iodwLmxbTWMN2YFGk5dYjOtbko0ljpSBVQ9A=;
 b=nLuodQTq3tQah8kzXyrJ3XIfqYcN+l9ekEOqVDxfwECvt80xwSTbP1eldjsGmGFR8SInqkigCQRoreXdAoWXbIuSq4d4uipr/UMoF0q0UGVp57jfapEXtmD44wdRLiZ3IxBxkYBMYYc6WZHorZfszXplAQKCTLqfAGRKUZaZ0Vk/HAJhb+dkTKTqyw0SXIVcCaFyh0TzWENK3PrXBTo35gQyFxtiSRiaN2LbhG846buiRIzNaPoVIugZr6iU+gVNun/CzixI33Alwt4abjAajLkMGMAda0umniYo1n+n732GA8n3qnRaSaBAGzopBoU0Mj6U4d9yUe/jso9wDTz+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB7411.namprd11.prod.outlook.com (2603:10b6:8:150::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.19; Mon, 22 Sep 2025 15:09:19 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 15:09:19 +0000
Date: Mon, 22 Sep 2025 17:09:10 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Amery Hung <ameryhung@gmail.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<alexei.starovoitov@gmail.com>, <andrii@kernel.org>, <daniel@iogearbox.net>,
	<paul.chaignon@gmail.com>, <kuba@kernel.org>, <stfomichev@gmail.com>,
	<martin.lau@kernel.org>, <mohsin.bashr@gmail.com>, <noren@nvidia.com>,
	<dtatulea@nvidia.com>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	<mbloch@nvidia.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v6 2/7] bpf: Allow bpf_xdp_shrink_data to shrink
 a frag from head and tail
Message-ID: <aNFmlj7mU3S+JPCx@boxer>
References: <20250919230952.3628709-1-ameryhung@gmail.com>
 <20250919230952.3628709-3-ameryhung@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250919230952.3628709-3-ameryhung@gmail.com>
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f61067-cdd4-4d61-17ec-08ddf9ea012d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uu7oqiwQc5/+Z5+meFyPFuTDoeo3ZuRrNClygvwVj6UIzglWJTm8IAUN7Pie?=
 =?us-ascii?Q?ewbl/SbTOOxxyMpXF8BGhPRmMTZvc3PNGgK7NgPmcUKLobPzRSDZOOazBtnU?=
 =?us-ascii?Q?3QATyBtiOzsgDP+5fOx5zRsOaJMe/3kwEBsSVuoMkP/qSjIMgWJhdzQyPQMm?=
 =?us-ascii?Q?IT4wjZwFyLb8hkdHVrvL4/SqaIbXJJOZUcMF6vLYsX6yZf5+nMA9eAlzu3ow?=
 =?us-ascii?Q?LGy0aZXpNEj+Zl89f4nyQZ9GowiUZUt45Cadlo3cZsyeLVhVIcQHhAS5HWAc?=
 =?us-ascii?Q?83Qsi2ZeEMooTQeCU4sCKChX3uSBabzXrC3R0LGbzftSGN8QhQY/sp1VJm/9?=
 =?us-ascii?Q?mFHj1uVKqWbHYmXvzBHbLALJ3PaLeI/cJkA8+wOW2TJ+OPN1ZN3DTGG69Bfa?=
 =?us-ascii?Q?c4utp1lXPCSHDP0wrTy+pJ0WQS1QUmYSfLyulHAIgPwkHjeT7efdAwnu0Its?=
 =?us-ascii?Q?Bvd5gWj88vht8GhaNU4bRZpDMvgGtJWNgFs/89K4QKBqgj6JrWSG9BNYxZvg?=
 =?us-ascii?Q?/UL1p82qCMfnnGtQmOGqBeXQIJBOgE/ylZy0xi2xRuWUEtSA9vdJ63sDzD/1?=
 =?us-ascii?Q?uORgF/+Y4ckfWyqKHVb6OGtJA6n4y+nzQYR0oeWTZ80uxMHe202gnEI47sn/?=
 =?us-ascii?Q?1SjpeLujdjqQbWskaceICg73vEiYHKzNAQ9/++VNy/ANwun7NjzxdUMnXUIk?=
 =?us-ascii?Q?0n/HQzmUJMnw9MHKdfXjWWD1Tt2LZpeBftvlPNp00t/Ge26UdlnHzf8JIds7?=
 =?us-ascii?Q?9PehB7Zq6mrk3fx6pkX3igJLYf0kr2OG44GY0ibdGPNu3mL3TuYfx/ciJShe?=
 =?us-ascii?Q?cGeZFkFDEvzy8+1pi/wW1LfcysEB8ClfZ4BazDyJoz2CTxXHnKYpvuBXouKu?=
 =?us-ascii?Q?T3GE85jVnG9i4w3ZVyXFR2NGf0bnYx5VWy3ny3d3KzVuZotcLG8ZHv9ccvcA?=
 =?us-ascii?Q?crpigiLvSBzaRxjxlG/rrGkULyh+5JKvNgd+eshqgbfWRJBu07cgvw94n83G?=
 =?us-ascii?Q?QEsgUNJLb15LMwcZhR34CEoMrhHfDQxGNbbw2zbumwWkM2vz14QkWZXSuygh?=
 =?us-ascii?Q?jbun5KbdoyPznZxeO5cIYX6lEwHBHyeHcKECsJxwzDrrKW0Y/t2AU/CCw+6M?=
 =?us-ascii?Q?FJGSo68smYzEnF/IWSXV41z5B6rGHAwNk0/6HXAU50pGj3Tpx0E1sYJ9W9VJ?=
 =?us-ascii?Q?QPTSXuW2gNMeWFKYu1tRGGtpnxRJ19FZWuMMDa//TrAqugwskF1Qj3o+mx8W?=
 =?us-ascii?Q?a7i3d4a2iitSj+1s4UqSw06vsOKejj96DvX4W3G89oBUzHIPu8qJ8ETQlPrf?=
 =?us-ascii?Q?qDLkZME1suzOmb0Nfl08vaX1jxKCA0BD6G4CgapXJdP+ImQufdeNv1IhFWBk?=
 =?us-ascii?Q?+Sp8sRuP9AeXmW4o882V1iNnXw44lq3BKRJyOMv+gACI98HNgC2mUKZVkDcg?=
 =?us-ascii?Q?Gh7gLlWZzjE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rNr9YisFVYsXIwCKSuB2owdE/9ZD53Csa4FyGZwsvf2r8vlASvtq4HGz1sGq?=
 =?us-ascii?Q?1HN/XievumyPahpSEFB9mCXFJ0nHs16zAFN76jxq/2E9XpGe4/A50AYSbEgO?=
 =?us-ascii?Q?3X2qDAqQWVtBbHAFZDU/f8ytvu+GvwH2VZwVTu/4hSYXJkoJ21ijBN4gT8zA?=
 =?us-ascii?Q?HDXTeRkQxuCVsD95TZEaCpKvwcjz4XZW36mc/4xfjBazCSFBR9LFwMC+1g0l?=
 =?us-ascii?Q?T8B4HxBMuSvMnDdPrKyPury0VTvrJ9h4YhsmOxNQDQn0SmZgEmsLQS+Sr6m6?=
 =?us-ascii?Q?Ei9txTp45xs4PybjUEElbIjphIBspVUXIYLJyJ1Gz9GMYzsA0PtpmZ3Wlqsq?=
 =?us-ascii?Q?ThI3c76vjO5S26gPu1pX8FjttxbsTLepB8MXOxOT+PCBSStNU5oUoVVmIX59?=
 =?us-ascii?Q?epXSuLH3lI7Q0oh/yU4uIoEgf5HpctmNeIMI/TDOmOifr6OJpSe02MsbC0QW?=
 =?us-ascii?Q?6XMz1hvitc4G6qGzaUzGY2t2opnqHyBbtxt+YqaiqmX7JtAFNH7geoJoHu/d?=
 =?us-ascii?Q?CY2wv9vYSbW/TjK6TQihbFNqCis9lJs4STzue3L+f/OvktE0UKjga5vtz6Co?=
 =?us-ascii?Q?9CESPCW+gQxKeVwG4o/e28JfJrT08MCSwQ9wUMy8jmIrf2vGPNJV9xim1a4P?=
 =?us-ascii?Q?0mMEoVZ8lYZZ8v4GJJc/Rwv/uiY5mx3N44TfoaLZxHrf7cXaqjCDk24NjNtS?=
 =?us-ascii?Q?ygMWu5okI8zTdKK/1f8obZ5cl1Hk4lalQoL5Bskp1RmbO6fObQRnxP3fNySn?=
 =?us-ascii?Q?oSqJQhUwwEHd5b8+kE0drFVjC1QX203/SNa8lKxEYZsSzAreYaQrCShB6qXq?=
 =?us-ascii?Q?J7SQolEfIQoQrj/0z//DxKxx4cwg1BcA2i9UjEsdHVmkuUHweN80K1URm0sC?=
 =?us-ascii?Q?YKrCVZr8qxt39In41aWRxCFbZ2oXxhNrL03zLPpiYXDxk7vjHP2PP84X59RS?=
 =?us-ascii?Q?FHGtuLg/PkJP5BJXJ53YWqBYbPJJ1bL9Cbh6LJQX4GOvD0Ix7tYs9cYSoF7F?=
 =?us-ascii?Q?gRuiCCVWnA1glUHcprxkDBAGmT5zuCpVWdtbjrJ7+sWtf/Y9fQeh9hOm2zhn?=
 =?us-ascii?Q?OTm2hqxjrT9DfG3qAFae95IQf/2NiuzIsZYLrA2wN26hwZASkyyGp4Kyao+c?=
 =?us-ascii?Q?Zdg/gepyTRZliMgreQSE7RTfel+tdlIpvqR3YHtc4ckofnq1MX0E+ZNqI7/t?=
 =?us-ascii?Q?FbJDiXH7tHPwclV4ToZACg3DpqfSy82eo3OnqrgQ/NwORDd7AWsICu7pZurT?=
 =?us-ascii?Q?j08VKMoNk4Akt7x18THDbJWcT7ouXE3A/t49PPU7WtDBwmgq+v5ev+CkF2+j?=
 =?us-ascii?Q?2iYq5XGvqUHAiESTYmnBD27KHi637j3RZO+hy0oJCueGFvyQezAaBgudt1Cq?=
 =?us-ascii?Q?+8g2tzF6So5gPz+c5MSTi7ZgXYFSu2xUpbWvC5I8b+qmvqVEQBjAHmUxzv2R?=
 =?us-ascii?Q?LshGSjZCFcNZw/SGTc4uOUrqo4btooJrAQqo9RxBagEkYI0MIzUmCVa/xTcq?=
 =?us-ascii?Q?MHVzVQ5hrnZ16QTVKJZvVFYJlYszUrhsuKYbJ1BlFDNm8sQWT48ManF+k5SZ?=
 =?us-ascii?Q?vL1z2Pj6wPYt+McQyyMrNXdNIai5aT7OseLcsXWhJI+tgOzqKMz1COB3cdxW?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f61067-cdd4-4d61-17ec-08ddf9ea012d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 15:09:19.5213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4WFS0lI5j4eemi3UkIQTVqS2UbHthl9UtRwVHZ8jL4MF2TZMrgWixv20fHu8C4+OP6ejXsj6L7lZVmsdwWQJJPJF9iF4evQHdEZYas7bhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7411
X-OriginatorOrg: intel.com

On Fri, Sep 19, 2025 at 04:09:47PM -0700, Amery Hung wrote:
> Move skb_frag_t adjustment into bpf_xdp_shrink_data() and extend its
> functionality to be able to shrink an xdp fragment from both head and
> tail. In a later patch, bpf_xdp_pull_data() will reuse it to shrink an
> xdp fragment from head.
> 
> Additionally, in bpf_xdp_frags_shrink_tail(), breaking the loop when
> bpf_xdp_shrink_data() returns false (i.e., not releasing the current
> fragment) is not necessary as the loop condition, offset > 0, has the
> same effect. Remove the else branch to simplify the code.
> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  include/net/xdp_sock_drv.h | 21 ++++++++++++++++---
>  net/core/filter.c          | 41 ++++++++++++++++++++++----------------
>  2 files changed, 42 insertions(+), 20 deletions(-)
> 
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 513c8e9704f6..4f2d3268a676 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -160,13 +160,23 @@ static inline struct xdp_buff *xsk_buff_get_frag(const struct xdp_buff *first)
>  	return ret;
>  }
>  
> -static inline void xsk_buff_del_tail(struct xdp_buff *tail)
> +static inline void xsk_buff_del_frag(struct xdp_buff *xdp)
>  {
> -	struct xdp_buff_xsk *xskb = container_of(tail, struct xdp_buff_xsk, xdp);
> +	struct xdp_buff_xsk *xskb = container_of(xdp, struct xdp_buff_xsk, xdp);
>  
>  	list_del(&xskb->list_node);
>  }
>  
> +static inline struct xdp_buff *xsk_buff_get_head(struct xdp_buff *first)
> +{
> +	struct xdp_buff_xsk *xskb = container_of(first, struct xdp_buff_xsk, xdp);
> +	struct xdp_buff_xsk *frag;
> +
> +	frag = list_first_entry(&xskb->pool->xskb_list, struct xdp_buff_xsk,
> +				list_node);
> +	return &frag->xdp;
> +}
> +
>  static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
>  {
>  	struct xdp_buff_xsk *xskb = container_of(first, struct xdp_buff_xsk, xdp);
> @@ -389,8 +399,13 @@ static inline struct xdp_buff *xsk_buff_get_frag(const struct xdp_buff *first)
>  	return NULL;
>  }
>  
> -static inline void xsk_buff_del_tail(struct xdp_buff *tail)
> +static inline void xsk_buff_del_frag(struct xdp_buff *xdp)
> +{
> +}
> +
> +static inline struct xdp_buff *xsk_buff_get_head(struct xdp_buff *first)
>  {
> +	return NULL;
>  }
>  
>  static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 5837534f4352..8cae575ad437 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4153,34 +4153,45 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
>  	return 0;
>  }
>  
> -static void bpf_xdp_shrink_data_zc(struct xdp_buff *xdp, int shrink,
> -				   enum xdp_mem_type mem_type, bool release)
> +static struct xdp_buff *bpf_xdp_shrink_data_zc(struct xdp_buff *xdp, int shrink,
> +					       bool tail, bool release)
>  {
> -	struct xdp_buff *zc_frag = xsk_buff_get_tail(xdp);
> +	struct xdp_buff *zc_frag = tail ? xsk_buff_get_tail(xdp) :
> +					  xsk_buff_get_head(xdp);
>  
>  	if (release) {
> -		xsk_buff_del_tail(zc_frag);
> -		__xdp_return(0, mem_type, false, zc_frag);
> +		xsk_buff_del_frag(zc_frag);
>  	} else {
> -		zc_frag->data_end -= shrink;
> +		if (tail)
> +			zc_frag->data_end -= shrink;
> +		else
> +			zc_frag->data += shrink;
>  	}
> +
> +	return zc_frag;
>  }
>  
>  static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
> -				int shrink)
> +				int shrink, bool tail)
>  {
>  	enum xdp_mem_type mem_type = xdp->rxq->mem.type;
>  	bool release = skb_frag_size(frag) == shrink;
> +	netmem_ref netmem = skb_frag_netmem(frag);
> +	struct xdp_buff *zc_frag = NULL;
>  
>  	if (mem_type == MEM_TYPE_XSK_BUFF_POOL) {
> -		bpf_xdp_shrink_data_zc(xdp, shrink, mem_type, release);
> -		goto out;
> +		netmem = 0;
> +		zc_frag = bpf_xdp_shrink_data_zc(xdp, shrink, tail, release);
>  	}
>  
> -	if (release)
> -		__xdp_return(skb_frag_netmem(frag), mem_type, false, NULL);
> +	if (release) {
> +		__xdp_return(netmem, mem_type, false, zc_frag);
> +	} else {
> +		if (!tail)
> +			skb_frag_off_add(frag, shrink);
> +		skb_frag_size_sub(frag, shrink);
> +	}

Thanks!
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

>  
> -out:
>  	return release;
>  }
>  
> @@ -4198,12 +4209,8 @@ static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
>  
>  		len_free += shrink;
>  		offset -= shrink;
> -		if (bpf_xdp_shrink_data(xdp, frag, shrink)) {
> +		if (bpf_xdp_shrink_data(xdp, frag, shrink, true))
>  			n_frags_free++;
> -		} else {
> -			skb_frag_size_sub(frag, shrink);
> -			break;
> -		}
>  	}
>  	sinfo->nr_frags -= n_frags_free;
>  	sinfo->xdp_frags_size -= len_free;
> -- 
> 2.47.3
> 

