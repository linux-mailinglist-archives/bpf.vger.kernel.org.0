Return-Path: <bpf+bounces-62297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64461AF7B76
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 17:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E183648643B
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 15:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAE72F0C7B;
	Thu,  3 Jul 2025 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+AlMU7n"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7722EF9B9;
	Thu,  3 Jul 2025 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555754; cv=fail; b=ILIbWiY5UzbQ9sTrC/eD8lOvC+E/bzisvEI9LFSz15wn2Qoj8xT4hDtXpnQhjrmlAUmMfjdlcF5KCLu7WV4ArS8sIBjaG42nHyF/1UrXCIy1wQJLT1aT+PanfWoScotTJ453VKiBsv9DIopQG2N6B5843UKIsgYM7CMlleBU9hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555754; c=relaxed/simple;
	bh=2vd58OctDBJfHyFkKWb9y3UiSqaEJ8Qyc6Sylf9uHP4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vGoO8wrvmO8FbiYjzPq6Yi/pPdlGthrkQsSAu/LC9U4cjNp7jpIc85VrUTvg0aaMHFeqGbVUoHaJWEPXE4W/IyNePalM2mDMCUGA8gXjdRCB/3wVJQIH0tF6kw+mLbrGCx95bAPN5bxktEafLgHzxcfuFD+Ob3IhaQkbUNPWPNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e+AlMU7n; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751555753; x=1783091753;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2vd58OctDBJfHyFkKWb9y3UiSqaEJ8Qyc6Sylf9uHP4=;
  b=e+AlMU7n0MT3YbV8EivFTm5xw4QvTl38p6OHfQowq7QsfzanVBDILhbq
   9eFF7obytxxQtzOch0dcachL14ffN6nt7aeEOjXIVS8FvCcjv58jbQxP2
   M+tJHJ/MrAPvYxsv+f0XRB0UIIWL9vak77aL+SvcUjj8FQEUyl8FdHgd8
   xi060czRXdWvQMLT5X1nY0yPisbwXY1qapuANif4Kbz0n+WQftPB5foD0
   FEFAapmgheYuC/jYRLO5CiTJ0+Pvlcd1CpBT51Jyaskew+0YqiDiazwbV
   4uIaZlQifgFVEO4DgTV5H1YMKR/97NG9R1fcoIrDpaD+Vrhx+LITiSO3o
   w==;
X-CSE-ConnectionGUID: LEq7tANiTemCqBobADT3Yw==
X-CSE-MsgGUID: jTt8HekCRP6UWmDG74Xg0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64580225"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="64580225"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 08:15:52 -0700
X-CSE-ConnectionGUID: L2NjA9KlSpa8HVFgov3lwg==
X-CSE-MsgGUID: 8UchspSLSbKpV6c0UGwAPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="185408645"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 08:15:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 08:15:51 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 08:15:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 08:15:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HedX0TD5fHJyRiBtHUuzWzRbXqVpFTtaZXKl30Nvm43FIbyBGdPJulxLWYO/ayF3vplu36VoSr7waMwVtwnzuysn6ULXBaR0p7Q/N2xhqUwbnb6S88mv+Ao4XPh/V50eFVlDaE+1Sn6u59h1C0b3XGcJONvoyrqe4i85gabA39ymRzL4dT+9PodhdsM68mLwyYzJT7mRniopaq+mTyTQrDGRYkP+jpwKu4FqrbiccWkFtO/hhiU6U/97TuP0iY4vEdsE1R4xSmBuNEyC0kkFxNxn26kyl97KXKRR6ZbXRLOocdA2UXUqWDe1/55OFxH8B0eV3xhibetXsomozsQ2ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PWS2nSEziHXzZdoe0aWIqwRrk9kga0VYpincXm/7lw=;
 b=E3Ej7sndwPb/pQvYPNOoRpZkNhtbQOAbtKF8vwMTyt2WIyuSqNCvocfV30NaprZd7lwVfvQ7HENL8dbywABy5Ye/i02BFmN+r0I6qIHnTaEgo0eF6pI+fGcnbB4OnizCySZguNkuP78rwhoSHvS85EF5aL/aQMW/dSwqE8RAQLMIgp61u3/UAdRl5KwCU6vM+t54kmFZCvs/oGlD3gcrZJsJ3eHba7ubpmtMYnD0S6eBPSc5BYLVEdywAXVhDyz43H83qSMU1wh9ALNDY9w2EoNMRuyhhVO0qjLAbVwfKcaHjqaicQ34ARcXS1kldmJsYAWAuK0rQk6TsojfijNhFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SN7PR11MB7489.namprd11.prod.outlook.com (2603:10b6:806:342::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Thu, 3 Jul
 2025 15:15:49 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%6]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 15:15:49 +0000
Date: Thu, 3 Jul 2025 17:15:42 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<joe@dama.to>, <willemdebruijn.kernel@gmail.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v7] net: xsk: introduce XDP_MAX_TX_SKB_BUDGET
 setsockopt
Message-ID: <aGaenppmVd+ChH9J@boxer>
References: <20250703145045.58271-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250703145045.58271-1-kerneljasonxing@gmail.com>
X-ClientProxiedBy: LO4P123CA0477.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::14) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SN7PR11MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6bbf80-5268-4e71-7535-08ddba447d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G4//haeIMqSxcNgeLsTED3/jOhQa61B8wStrgrd24yx/yhQxynE8no91iJep?=
 =?us-ascii?Q?nfr3l8VskBKj8oK1MHkrJLev8cjdQ582hPxBkBfAmAqBKQCot7W7vHWdvTaU?=
 =?us-ascii?Q?wvAksxX/RFKJ6MYDoJRAx6apwkNywP7RTzIO+qnnroGDRM/FMb80odtBJP+0?=
 =?us-ascii?Q?aCMlL5tR5wguXZlCOxY3fYKozl5iJzqcm/1mcnYdEh4i9bYBM29Fe/YmPlpJ?=
 =?us-ascii?Q?YCZAfTIImTVDLeqz+YIxzy7a3r5roaanlLJMq/x4bmQEHG5CR27N1r43D95i?=
 =?us-ascii?Q?7uK7zf0pwpYBqjpoOmPTcbpW0FTdIPFIRN3On2yRrwjukUSO2P7XuQD3RCcF?=
 =?us-ascii?Q?76KqhKZweu8rlK4FLZ0wha2MrSFuoKWQ+ku2kmXid2ehfJ73qQF6ZUve1h9r?=
 =?us-ascii?Q?wH9NSG1XZqvl/ZM1JaCknImifmC3nDOZ0lnIRIIOs7lkGvw8sGS+N/q3f5/n?=
 =?us-ascii?Q?rF8VcfCN/uzeRbxDztLhM1ZfeTXZ66usVqgN/+0tOjYDg0jh2ozg4JPOSpjy?=
 =?us-ascii?Q?cnA3pYipjpnRgX3FYSSUbn0/G+9IavGbT0ony6/uK6mO8YExKGVb4sPEHn43?=
 =?us-ascii?Q?p0vKXXHr07FK9X60Pa2/MoYKe7eBYnVPPhj0P5Dj+ud70nWQY//oi9lanIDS?=
 =?us-ascii?Q?AmSR8WlVyP+5zzIl9pU1jlsZme7KD6inToNUmT0DEDEhyCz/N0s64ivD4dIz?=
 =?us-ascii?Q?18S/2r20QFcpMT9XxDDrZZYtPoF0L8i+hkJJ68iUjPGGV0Hn4QR3pOt4M+Rn?=
 =?us-ascii?Q?Myy+dwD9zYpf74N9pvjkK5tvPhsKR7FJV/bAS3+VLAusHNBCR9eES4yoMKgb?=
 =?us-ascii?Q?Svtid1JBr/ObLZ7B2vhyRv4U52wjOW1z75GIKZ6utC0eNUwI8RBhVYlhN9dn?=
 =?us-ascii?Q?z8lRBshgB3d18DgW0vIe3GKKYjG2F1YXZbdXHZf9BxtNEJyljn+0sMD2oNoj?=
 =?us-ascii?Q?oTVjP1moh95kphIvivCBWIYMvhOGiSi5SPMB79Ok+C+uaMDcn56WNRDQBSWo?=
 =?us-ascii?Q?fROQFSeYh71uEOI+BhX0kMwnPS11QOssLZaiWc4/nCL8RvZ+Efxs/GmG8Hp3?=
 =?us-ascii?Q?pSdmllkA68Dzt+omx+tPxnpMHV4aZj8ZFs54lPPsKoIZZN8O7dZwVDoMgoYc?=
 =?us-ascii?Q?Eb+v70RfG2SBf+83H17sUmLMpR10eG5OiyNltsmJQG2+CGGpvFvQoJ3FEsTP?=
 =?us-ascii?Q?zUysq97fQrpmsDIyagFYBYVzVH9ubzZ5gH4fS3y3R1CAITI1Z4/oyFZauerK?=
 =?us-ascii?Q?kX5FMzWzPXbbQVcZzHx1pJ8Bv5jutyDT8sXrcSWGCAt5b0zn2BTX/a9TJPqj?=
 =?us-ascii?Q?5mvZMWdavn7768vljjCBFnmLCSS9Lad5ak+bpZotzEJG9Q+FJe1w1Xj57mOr?=
 =?us-ascii?Q?TLazN3dTco2IqAWjNSui8xo0CJT5g+3A0kV1DDhiiCA8R/5ZCOye2f4LTG3D?=
 =?us-ascii?Q?xay5A4sEGVE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oPLCQjkyIYkhCJrkbZskjzEL4zMYJWjTRX9R9O+XtdWzW/qYUs+TqaEBGVIk?=
 =?us-ascii?Q?0ldQtSal8D70NlqL3gv1TWp8NL3Ln5hUTBM0wkY/xyhBTKjIqplYgOuHHRsX?=
 =?us-ascii?Q?+VkuKianUusXHAYQLe7G6WjdHuOnxcRFdiS7M/3U55KOdKBmX+4mZ6tRI03E?=
 =?us-ascii?Q?eR2uzTIm68IdVSHMyUmhyMkfSewEht3JqgVkmGP6xKxskYY3EUWWuAa02gXZ?=
 =?us-ascii?Q?WNyHNiwoov+FCPdhX62j9c027BLKJzvd/BXFEgIIdn5JydJvzasYIAM0/YdC?=
 =?us-ascii?Q?SNa4adCRDTBgCQMTE0g6JyjZq+ttRpvHsTKwRJUCTIGSWHBmnPG13OWmhhYz?=
 =?us-ascii?Q?zdyzy3A4IP6fyNBsM5pNXfM5MLI/qASOQUOdO2uST/nQ+oDUWEi1NxxrZK7d?=
 =?us-ascii?Q?KEWr5cW2ImPyLf3tK1HuVLxeKPT+1XCy2JOip7McxDpssxxxpCPuk39i6xjM?=
 =?us-ascii?Q?J+yHeMhGVQcrks8reiMMf9PItpB8gi5XePqTOpdiJCRFPSgoVD9MWWIMYqhj?=
 =?us-ascii?Q?z1ctze4dRBF4QB5SB2+Gi4p49ezXk0s1ZuDeRd2Ex1skxgXhfcDoVnx5fao7?=
 =?us-ascii?Q?Na4RwRpNS2OMBOZ6PjVh3xSn3Y9FGjlAXJ6AllGvc57ofSkxZtE8tpe+U2OX?=
 =?us-ascii?Q?JKGEXa1waq7liagIr240YbFBICQOmj2Ukt+ssDr0GCt/TXJOHxCqCq+7vkFj?=
 =?us-ascii?Q?WzYdvjM4D3VxmjoFuLtkcp58foeRgKnQYqSgpcotHGUB927Azqx5fPZ94yax?=
 =?us-ascii?Q?1jCuifHafCdlsswlWPnb8a5hY8fyvv5LgClXamwZhJkB9LhQO59e6xGWaHnk?=
 =?us-ascii?Q?oSi1AyY9RXtBsxZSG+4Kj4Q2cKEAXFkXMHkM0dRkglu6r8/RsebCTY5o+no9?=
 =?us-ascii?Q?MVzcpcXSPaJFYAUM+Xqp0Ecf95BkmcWgYOr+EoZTU2ZjR2IC3NMsMP/Hkq51?=
 =?us-ascii?Q?AVcyGEMnSmfxaJKnyZCYy4SDMXZ36jq5LfxSHBc4bIezDxD8XvFnSp9T2+k0?=
 =?us-ascii?Q?ThRBmXxuHXN/MkoRRCjkAFxDpGJvuwvlPY5Xf6OkX7bkAt/z97jZRo5tazpu?=
 =?us-ascii?Q?+TbRQONxVpDIfnR3evk6CmXr617snGwE5z3KA4qtE1y7hNb0BWvwSSLk+km4?=
 =?us-ascii?Q?BAmG3J+LMlYdvY1jJN5D5We/jQa3+wktefOpTvT5GI8P/he2zAFrWw/cCAkS?=
 =?us-ascii?Q?pMzKvjR6Ou7wawyE+uCFnslDQeOG6plsUDfxPDy5LNnYpfN9OjroR8UkLSWy?=
 =?us-ascii?Q?QWOI8Uj+X0tO995Nac2XwwWAViuNyQ06xJjUTQhBvxuTRNqRzTer3G0vVp+m?=
 =?us-ascii?Q?o8mXeoNxBdo+20HDZLidiWqoiMvGBfz1zpq5ks0J/w+oJQ6hGs+/wNwP4NUF?=
 =?us-ascii?Q?mE+0rBdd1W7tIAAryC4nV0FGvNUqtaaFAY5uQRi21NbdoI6yU52pHto2AkDj?=
 =?us-ascii?Q?94SmMwXhtQDFhYngqgpExr4VOF1/TazvnZiELHG/2M9Q9CJLpXwqZTfkSFfl?=
 =?us-ascii?Q?zij0RzLyQOSaWUnwRAotJiXi4/s2Ln51hnKBQREVV+uZwF2FXrfXlTJ62w1G?=
 =?us-ascii?Q?3gtB5Je5u5XHFvmAu3TMLbb6GKBWKndGN4ejaSutwdA7gB/K9l/PtSFgIllG?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6bbf80-5268-4e71-7535-08ddba447d9f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 15:15:48.6146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItLvJMxTWtWvi1nWQKRUSdTs1QVgqa3pOrjM2pzUU7CAjVA6ei/+A/gG4pxn3pNSI3un3JbE+cFaGoYYgG5DabNXFjyLzYwvKLdqip49GhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7489
X-OriginatorOrg: intel.com

On Thu, Jul 03, 2025 at 10:50:45PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> This patch provides a setsockopt method to let applications leverage to
> adjust how many descs to be handled at most in one send syscall. It
> mitigates the situation where the default value (32) that is too small
> leads to higher frequency of triggering send syscall.
> 
> Considering the prosperity/complexity the applications have, there is no
> absolutely ideal suggestion fitting all cases. So keep 32 as its default
> value like before.
> 
> The patch does the following things:
> - Add XDP_MAX_TX_SKB_BUDGET socket option.
> - Set max_tx_budget to 32 by default in the initialization phase as a
>   per-socket granular control.
> - Set the range of max_tx_budget as [32, xs->tx->nentries].
> 
> The idea behind this comes out of real workloads in production. We use a
> user-level stack with xsk support to accelerate sending packets and
> minimize triggering syscalls. When the packets are aggregated, it's not
> hard to hit the upper bound (namely, 32). The moment user-space stack
> fetches the -EAGAIN error number passed from sendto(), it will loop to try
> again until all the expected descs from tx ring are sent out to the driver.
> Enlarging the XDP_MAX_TX_SKB_BUDGET value contributes to less frequency of
> sendto() and higher throughput/PPS.
> 
> Here is what I did in production, along with some numbers as follows:
> For one application I saw lately, I suggested using 128 as max_tx_budget
> because I saw two limitations without changing any default configuration:
> 1) XDP_MAX_TX_SKB_BUDGET, 2) socket sndbuf which is 212992 decided by
> net.core.wmem_default. As to XDP_MAX_TX_SKB_BUDGET, the scenario behind
> this was I counted how many descs are transmitted to the driver at one
> time of sendto() based on [1] patch and then I calculated the
> possibility of hitting the upper bound. Finally I chose 128 as a
> suitable value because 1) it covers most of the cases, 2) a higher
> number would not bring evident results. After twisting the parameters,
> a stable improvement of around 4% for both PPS and throughput and less
> resources consumption were found to be observed by strace -c -p xxx:
> 1) %time was decreased by 7.8%
> 2) error counter was decreased from 18367 to 572
> 
> [1]: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxing@gmail.com/
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v7
> Link: https://lore.kernel.org/all/20250627110121.73228-1-kerneljasonxing@gmail.com/
> 1. use 'copy mode' in Doc
> 2. move init of max_tx_budget to a proper position
> 3. use the max value in the if condition in setsockopt
> 4. change sockopt name to XDP_MAX_TX_SKB_BUDGET
> 5. set MAX_PER_SOCKET_BUDGET to 32 instead of TX_BATCH_SIZE because they
>    have no correlation at all.
> 
> v6
> Link: https://lore.kernel.org/all/20250625123527.98209-1-kerneljasonxing@gmail.com/
> 1. use [32, xs->tx->nentries] range
> 2. Since setsockopt may generate a different value, add getsockopt to help
>    application know what value takes effect finally.
> 
> v5
> Link: https://lore.kernel.org/all/20250623021345.69211-1-kerneljasonxing@gmail.com/
> 1. remove changes around zc mode
> 
> v4
> Link: https://lore.kernel.org/all/20250619090440.65509-1-kerneljasonxing@gmail.com/
> 1. remove getsockopt as it seems no real use case.
> 2. adjust the position of max_tx_budget to make sure it stays with other
> read-most fields in one cacheline.
> 3. set one as the lower bound of max_tx_budget
> 4. add more descriptions/performance data in Doucmentation and commit message.
> 
> V3
> Link: https://lore.kernel.org/all/20250618065553.96822-1-kerneljasonxing@gmail.com/
> 1. use a per-socket control (suggested by Stanislav)
> 2. unify both definitions into one
> 3. support setsockopt and getsockopt
> 4. add more description in commit message
> 
> V2
> Link: https://lore.kernel.org/all/20250617002236.30557-1-kerneljasonxing@gmail.com/
> 1. use a per-netns sysctl knob
> 2. use sysctl_xsk_max_tx_budget to unify both definitions.
> ---
>  Documentation/networking/af_xdp.rst |  9 +++++++++
>  include/net/xdp_sock.h              |  1 +
>  include/uapi/linux/if_xdp.h         |  1 +
>  net/xdp/xsk.c                       | 21 +++++++++++++++++++--
>  tools/include/uapi/linux/if_xdp.h   |  1 +
>  5 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
> index dceeb0d763aa..95ff1836e5c6 100644
> --- a/Documentation/networking/af_xdp.rst
> +++ b/Documentation/networking/af_xdp.rst
> @@ -442,6 +442,15 @@ is created by a privileged process and passed to a non-privileged one.
>  Once the option is set, kernel will refuse attempts to bind that socket
>  to a different interface.  Updating the value requires CAP_NET_RAW.
>  
> +XDP_MAX_TX_SKB_BUDGET setsockopt
> +----------------------------
> +
> +This setsockopt sets the maximum number of descriptors that can be handled
> +and passed to the driver at one send syscall. It is applied in the copy
> +mode to allow application to tune the per-socket maximum iteration for
> +better throughput and less frequency of send syscall.
> +Allowed range is [32, xs->tx->nentries].
> +
>  XDP_STATISTICS getsockopt
>  -------------------------
>  
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index e8bd6ddb7b12..ce587a225661 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -84,6 +84,7 @@ struct xdp_sock {
>  	struct list_head map_list;
>  	/* Protects map_list */
>  	spinlock_t map_list_lock;
> +	u32 max_tx_budget;
>  	/* Protects multiple processes in the control path */
>  	struct mutex mutex;
>  	struct xsk_queue *fq_tmp; /* Only as tmp storage before bind */
> diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
> index 44f2bb93e7e6..23a062781468 100644
> --- a/include/uapi/linux/if_xdp.h
> +++ b/include/uapi/linux/if_xdp.h
> @@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
>  #define XDP_UMEM_COMPLETION_RING	6
>  #define XDP_STATISTICS			7
>  #define XDP_OPTIONS			8
> +#define XDP_MAX_TX_SKB_BUDGET		9
>  
>  struct xdp_umem_reg {
>  	__u64 addr; /* Start of packet data area */
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 72c000c0ae5f..07ee585bec7a 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -34,7 +34,7 @@
>  #include "xsk.h"
>  
>  #define TX_BATCH_SIZE 32
> -#define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
> +#define MAX_PER_SOCKET_BUDGET 32
>  
>  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
>  {
> @@ -779,7 +779,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  static int __xsk_generic_xmit(struct sock *sk)
>  {
>  	struct xdp_sock *xs = xdp_sk(sk);
> -	u32 max_batch = TX_BATCH_SIZE;
> +	u32 max_batch;

still rct is off - this is "reverse christmas tree" which refers to a
non-written rule for networking that we organize the declarations of
variables from longest line to shortest (so it looks like RCT...).

Maybe maintainers could fix this while applying? because rest of the
changes looks sane.

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

>  	bool sent_frame = false;
>  	struct xdp_desc desc;
>  	struct sk_buff *skb;
> @@ -796,6 +796,7 @@ static int __xsk_generic_xmit(struct sock *sk)
>  	if (xs->queue_id >= xs->dev->real_num_tx_queues)
>  		goto out;
>  
> +	max_batch = READ_ONCE(xs->max_tx_budget);
>  	while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
>  		if (max_batch-- == 0) {
>  			err = -EAGAIN;
> @@ -1437,6 +1438,21 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
>  		mutex_unlock(&xs->mutex);
>  		return err;
>  	}
> +	case XDP_MAX_TX_SKB_BUDGET:
> +	{
> +		unsigned int budget;
> +
> +		if (optlen != sizeof(budget))
> +			return -EINVAL;
> +		if (copy_from_sockptr(&budget, optval, sizeof(budget)))
> +			return -EFAULT;
> +		if (!xs->tx ||
> +		    budget < TX_BATCH_SIZE || budget > xs->tx->nentries)
> +			return -EACCES;
> +
> +		WRITE_ONCE(xs->max_tx_budget, budget);
> +		return 0;
> +	}
>  	default:
>  		break;
>  	}
> @@ -1734,6 +1750,7 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
>  
>  	xs = xdp_sk(sk);
>  	xs->state = XSK_READY;
> +	xs->max_tx_budget = TX_BATCH_SIZE;
>  	mutex_init(&xs->mutex);
>  
>  	INIT_LIST_HEAD(&xs->map_list);
> diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
> index 44f2bb93e7e6..23a062781468 100644
> --- a/tools/include/uapi/linux/if_xdp.h
> +++ b/tools/include/uapi/linux/if_xdp.h
> @@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
>  #define XDP_UMEM_COMPLETION_RING	6
>  #define XDP_STATISTICS			7
>  #define XDP_OPTIONS			8
> +#define XDP_MAX_TX_SKB_BUDGET		9
>  
>  struct xdp_umem_reg {
>  	__u64 addr; /* Start of packet data area */
> -- 
> 2.41.3
> 

