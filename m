Return-Path: <bpf+bounces-61816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F41AEDC3C
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 14:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B711D3A2C37
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 12:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1B428980D;
	Mon, 30 Jun 2025 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dSqpevnS"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDD2257435;
	Mon, 30 Jun 2025 12:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285181; cv=fail; b=QaAGVzz8pnrriR+q8Ve3KTijQEW9gNFJdP1jodv0pPROYJ7oNHe7mKt+RGJqapQafUiAVDgtC62I9D5sAPzjgzPlimNFJej34JVq6e+pdpghpPW6ZERGkJwJUqXNd7NEARV42A5MwuIii/a5tk/tJp41TY9MREStFpw0nfEYIwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285181; c=relaxed/simple;
	bh=jMxug1GXrSg+1fkKoQS1nrNOTsG2HVvNorvDzdYpPJU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y0WlbVciciKOqVZLiMk15wyNkSq6Rjva/VK3d9BVpDrlUQihDY+mivXN7Af6woNG6f9DZy7aQ/nARL25jneAchAFIIw3V9bSyIHbarBGMhxZb8XSqOz9c35+Ut8q/kAkjndSPeRxhxYlhqCWErJZl7s/whO5c9zR6FqGB0qcfmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dSqpevnS; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751285180; x=1782821180;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jMxug1GXrSg+1fkKoQS1nrNOTsG2HVvNorvDzdYpPJU=;
  b=dSqpevnS2uL77zxWMUfqJidJF1Mn5n3YiiMIQuy3s3v22wvGgwvAggEZ
   F7CQsswrytRxtBxLqhf990bN3otEN/V3o1up72Kf6oJ/8CUdbhhzRdoIc
   JUqtuWuWOJKDAiNoGGNOiA0dB1/FWfMBtiTvV4+9LRt7ir9XSCeNzep0A
   UHn5zd7auvPgSAs8F+plm6E0jP1qLgrzARiPtxLjLzS0vOO3oxVb7rGrL
   3pHg361a2u+sSTOHzq7Dpokyo3txYyGslTr7pDl9AkNC2LL8EKds6egPJ
   qGubLqs98BfDiZ4zBj1m8LO82E78u6FNqDvhUYpJmBiapQDZNzTONI9qO
   g==;
X-CSE-ConnectionGUID: OlxvjpgNRDyqNwmhklhVyQ==
X-CSE-MsgGUID: KeLW4qzWQtCUc1630jgUVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="63763632"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="63763632"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 05:06:19 -0700
X-CSE-ConnectionGUID: fzue7+/LS/atYwTabzuNYQ==
X-CSE-MsgGUID: P7udOnBASg+UODUa6YFW9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="153532857"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 05:06:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 05:06:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 05:06:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.56)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 05:06:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFy0LNd8ZLGK4KyM8fQHVcvygGKvpG9PrNHw/2Uv/8tfQDqvARQ68RcAMKRCbBuJVNkbnpZg1GKtsFORdYBXtOrwFiuMwC60HQ7KDiLio/RG8jw1/XNuswTDqUcZzZo1/bZHzXGwhyWHBLmbIFDyNoZZrt6u0J8B5CpISWXbG1GNfwREJzPrfNcCiO1hLEO8Wo9jW0RF3mtde6ilBJ57E2HMHHxTNNoBMwcSmsYJqx/ai1dHv1rOld708FxvrBtaniBv04Dt/fzl0tVQ2NrTHrVLTOsy25Ik4DAb6mxcy0ytki/2186T1GwUpLZ2VZU3zt29sGZ5CJxy+YvayUajPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijJYVpMKDUaWNYdEZba4tO2n3NjZgqsuXMdyagPQuxY=;
 b=JTdFfOGQUwfIvggdhgDf0y06i5W6V5wEbnXbS2oBnWgb7UVSsbf/QPi/+3ZTmEQrUxvidt3FHSv4VyzS7iWhP0DGMhTLbKdMbqcSQWJwUebOoFBCC1lJ/fBghFsBbtLj5B8W3qgnTzuIah6ZMGXHLIxxuoO+qAG7pEIOA2OQ1/h/eb1WL4cx6f8Qu1BXw7KBBMz5mg3S1pICzCJmxunskcM5gVdti9xpRoBd39lM7SMG/I8VKumcMDVWCF6EoPUKepVgHzN/l9OvWX/jYwl+g5Clq13zaHv5WE8o98Lq5LmDTBWHllOYmcSGKCdcrXaJrtS1IMWlfxbtNX9x7BqlAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 BL3PR11MB6507.namprd11.prod.outlook.com (2603:10b6:208:38e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.27; Mon, 30 Jun 2025 12:06:15 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%2]) with mapi id 15.20.8880.024; Mon, 30 Jun 2025
 12:06:15 +0000
Date: Mon, 30 Jun 2025 14:06:02 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<joe@dama.to>, <willemdebruijn.kernel@gmail.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v4 2/2] selftests/bpf: check if the global
 consumer updates in time
Message-ID: <aGJ9qiwNe5HBFxr2@boxer>
References: <20250627085745.53173-1-kerneljasonxing@gmail.com>
 <20250627085745.53173-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250627085745.53173-3-kerneljasonxing@gmail.com>
X-ClientProxiedBy: VI1PR06CA0149.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::42) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|BL3PR11MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dbe0f9e-91ba-4336-ac2a-08ddb7ce838f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IOQfWPrNUFgN1WVhv3c5PHGQKQWmN/sVDWuKXr4sHC0bBxDXTimqpKCCpxom?=
 =?us-ascii?Q?JzoxUINfd860YZ3jtneBo3ZCLt0COMOkWYJInwmlr1IBEHSZNqMnyTD95MrU?=
 =?us-ascii?Q?ADXwvCvB/I5rF2d/39q/Wt33b1DfBLeEtC5+/1GyGHxzw0zoFLp71H0VpBgd?=
 =?us-ascii?Q?iFX/CQpygWxnlWn3H6jx7TUIobFFPYRpMgtP2oSHS6ytOX91nqZ7Xw/1MjdR?=
 =?us-ascii?Q?DnRcntKZga0zDyTomP73fryFDozsUY6nw+oDah+4x0qHdAVdn+50rw1fLF2D?=
 =?us-ascii?Q?KWeAorRoxFgGgKcCZk7+v3+UDsbjewOVYaCHj56uTD387H5wSs8LFkSSElBZ?=
 =?us-ascii?Q?NUqAUo+bb8m4QlaVRtV7HLEtbzLgcVt924cB6Eaz7aPPd21KB/bH4/r8VvF4?=
 =?us-ascii?Q?IgmXTPbkMNdMB3oWunoQFWYVh5sHJSg24Tcg7463tkm1vUuR98qCfcn6v0ak?=
 =?us-ascii?Q?JezPvJ/tTQy5wCIofT104GupLU7WTHenwmHTH6QOjSRQLjx0TiokeCXg9kj/?=
 =?us-ascii?Q?Z2NDAaWv7u2F5rRaR7pK1pJnSLiW8duuzE7NuXWS1xj41bIs0dQnO1d/KdFV?=
 =?us-ascii?Q?g0V9aXUiJ9Lk53PjEnHLlryL5h0tMHwVYw5ibllY9EgPkD1slAGJC4vRw5WZ?=
 =?us-ascii?Q?kBa+KHsp0MwZbmqS+8QC3lhINSsb8KJaZcK4s/8GIVMmAyyXSbHYpDBDAAG8?=
 =?us-ascii?Q?OAmgCeM7cHvmgUv1C+JcKXLEhOyI8afIShwkfVkLiy90uUq0CeunqC++YWHA?=
 =?us-ascii?Q?OEgvaaiHurftFdkrwt/hGlS3FmWVZwETdYilQJ6kksMKiQUMF9uxmHq2TDP2?=
 =?us-ascii?Q?foTH8RdcHpugCN2t0AQ76lkIHTOhlbsnjZh5Cjyp5HPg9U3wuyeVlmVdc9+T?=
 =?us-ascii?Q?3g1nSFgVxyswETHAORl9W2ualX1k1Mof3tvHztONoIs8KaKCJ8ElxR1/Nmoz?=
 =?us-ascii?Q?E4CbFO4VM6yc8hdqUnI35wrNc8LKDI30f2FKmNmM3gb3rgjUlUpi75mxCS7C?=
 =?us-ascii?Q?We+Hg2fWV655JipQ4MWtHBJUlHbQv+prWdscMYLIDYZciHS6Zqkfz2CfJIoW?=
 =?us-ascii?Q?y4zzXSTwoaXLpQgxuJ5gnECKn0pz1AalCVq9QhyNsn3ykmbMQhGMA/NiIhor?=
 =?us-ascii?Q?CxZ1gGoENeheIt1UfVjK1RS36ttR43jtOXZT875R0xS1ExmSJXPPfOqzKlBh?=
 =?us-ascii?Q?W6q+hcT8QP1HGr6GwFmgOJfZcg6Q1TAwHx3EFtQNSFlfqbKt1YPWs5gHR0MF?=
 =?us-ascii?Q?ti8ceCZzoZN2a2qb5F7lFXmbmsCr1CotvgLDd2RYX6JsS/3YGqv6hysotlTo?=
 =?us-ascii?Q?IpqOM7Conj/JiMFce4+kFbA3EoA25w7Ck5431GqVPuHUMK2a2U7P+YYX3bTU?=
 =?us-ascii?Q?Cq57Cg8mqGohlkau/B9BTmkSoJkRzY9/hjMYCU10xSU+47mFNw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dmhbQLQupYbwPnHvWBsYFH8jWLxZerPQo4h1HDktN+DDSIJKsMSO9lurVohr?=
 =?us-ascii?Q?2zrPO5JS9rywtELo7DFASKZOlx2tCszGsLlFuHnod7yey4J/qZgUA1omocnm?=
 =?us-ascii?Q?JB+K+rdutFcCmOY7n5aYm0lpDzklZN0J9KJN/zZKNH5VX14CNc+2HiUWn2li?=
 =?us-ascii?Q?r7KcPANR0oKyIYh0u5EyXs7AY2IoXHL7++5f5tc9MQQMWeyjyjN+DNaaLczO?=
 =?us-ascii?Q?VciQL2QCUm5LvOjP/ZJBEGiDo/driLZGGeSSVi4MGlgZdJOJUDHbZLV/Egnn?=
 =?us-ascii?Q?SxMPVuMkTLQE4KzJ1/7m5TqEooI9GIG/PdoLMJM07s1RCeGW8vly03PSHufO?=
 =?us-ascii?Q?XBEmgFsH8h5IcdYsYTyrYxa4S5Gby4mdwzNIfFvoEBLhDqpxpyaWmnV/Rf5E?=
 =?us-ascii?Q?AXvdZ16D8qKe0E5djHrQtFW9pRU5A5E3fOhmTIEc+HzdyvQAc3ZH3iO0cNFN?=
 =?us-ascii?Q?Phqi5xHArg5m/P7JhhDw23qfSF87GSN+HqmLZlF9abGbCYLUXwOLCHRWQypP?=
 =?us-ascii?Q?pLGEIO0IXfco4AbBVcndrPEt8ujYyni1jGpFN2Fv3OTxNp8USngj0J9oSIh2?=
 =?us-ascii?Q?OjK8uWy1Tis5KyOjsfnLmx8YGYWCANZtrGBfaw2eQsflh0NdAXzGo3YR9jPB?=
 =?us-ascii?Q?wpLl9qrtq5bnW2GzVf4N8N/DVQSYplnVw5SsGwN8sSlZju43KXaqfwzl5+pU?=
 =?us-ascii?Q?vUR3xaloTvkdYmNGgBJdS6I5PAicBG2lxAKE7wtMc3H8udO9z58KMd0WcMIi?=
 =?us-ascii?Q?veBKIguZIKgtQbCyxdZCJYKDaczqfDEqwpO+3UCQG2oFzRZQ6tsB3+IF38lK?=
 =?us-ascii?Q?e5jARGSFnkuRu1b0Y4ZnE9uMn9sqSC0v4fji1VwlDQvu/vtXYDZHZnRS/LuG?=
 =?us-ascii?Q?goLYdBKflJT7cj9EPBXMSztbDrjgfmsPavgWonT5P9V0GxeP5GrssSjOt/gA?=
 =?us-ascii?Q?MHtGogDciz4L0+++Vcmvq2Cc1TQ7EdJk803NVsLMnLqimDKgRGtkRXKVirAb?=
 =?us-ascii?Q?J2K+OpFcv6W8G0DFVipPxJHtK56SQjK7iAWgWjbihxuQ/TmwQUSLt6yylUub?=
 =?us-ascii?Q?kZzgtTz3QmcvYNFSs4bracjRDUQ18FpRlYhRbLwKMgaY/cbikhdLfkjZI1Lp?=
 =?us-ascii?Q?5qnIiucN39kYTDmfZeQe2lY0g0oKUvt0reeQR4MbnYOT2USpWAenYkhUFg+C?=
 =?us-ascii?Q?Q1fdvvK/llECFnWxBX5l4wy5wgQAHe/5WbZKdVWrTWfrlYjz6582stPni750?=
 =?us-ascii?Q?w6JPfa4qmqmOWsfVJz+G70OkjMkfXzvw1+3k3Nt+Bpj/7SHi2eFGNj+zGzZ9?=
 =?us-ascii?Q?b/D9ZdsNN3mpWJ+53JNFeCD548807W/Mb+zCpoCH5Wn2YX6uupu2IugrwF/E?=
 =?us-ascii?Q?T9+NGravKjbwv0vWobtyVhvyJ8kBXErdTKZZy2n3R2HqWPGLv2NMPU1WY91k?=
 =?us-ascii?Q?EIphMrzYwmybiqeCyoB/jDJV6NIBYcmAr8BYbXFkOddk3RNEJqfW2vB+rJLs?=
 =?us-ascii?Q?k/QBN9XIigtDoSN0WFPV3FrvjbRkx1fvRQ+IArrY0HeaSC9r/jn7cejDQGhM?=
 =?us-ascii?Q?TD3gAz5gXsCCy2+91AQA9WdP3zan8qNMzF+XqhdhxfwVg56dDVARMVUzI0+I?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbe0f9e-91ba-4336-ac2a-08ddb7ce838f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 12:06:15.5938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bk9U8dD25GOwV/QFf2lktm7xhPchaZHiF7hWe78Z2mmB+3+yXdbo4BbuckLmKgE38l42lvkDQmzXIU4/XbD4VpXG/ye4T9mC1qByu0B0IY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6507
X-OriginatorOrg: intel.com

On Fri, Jun 27, 2025 at 04:57:45PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> This patch only checks non-zc mode and non STAT_TX_INVALID testcase. The
> conditions are included in check_consumer().
> 
> The policy of testing the issue is to recognize the max budget case where
> the number of descs in the tx queue is larger than the default max budget,
> namely, 32, to make sure that 1) the max_batch error is triggered in
> __xsk_generic_xmit(), 2) xskq_cons_peek_desc() doesn't have the chance
> to update the global state of consumer at last. Hitting max budget case
> is just one of premature exit cases but has the same result/action in
> __xsk_generic_xmit().
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 60 +++++++++++++++++++-----
>  1 file changed, 48 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 0ced4026ee44..694b0c0e1217 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -109,6 +109,8 @@
>  
>  #include <network_helpers.h>
>  
> +#define MAX_TX_BUDGET_DEFAULT 32
> +
>  static bool opt_verbose;
>  static bool opt_print_tests;
>  static enum test_mode opt_mode = TEST_MODE_ALL;
> @@ -1091,11 +1093,34 @@ static bool is_pkt_valid(struct pkt *pkt, void *buffer, u64 addr, u32 len)
>  	return true;
>  }
>  
> -static int kick_tx(struct xsk_socket_info *xsk)
> +static u32 load_value(u32 *a)
>  {
> -	int ret;
> +	return __atomic_load_n(a, __ATOMIC_ACQUIRE);
> +}
> +
> +static int kick_tx_with_check(struct xsk_socket_info *xsk)
> +{
> +	int ret, cons_delta;
> +	u32 prev_cons;
>  
> +	prev_cons = load_value(xsk->tx.consumer);
>  	ret = sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, 0);
> +	cons_delta = load_value(xsk->tx.consumer) - prev_cons;
> +	if (cons_delta != MAX_TX_BUDGET_DEFAULT)
> +		return TEST_FAILURE;
> +
> +	return ret;
> +}
> +
> +static int kick_tx(struct xsk_socket_info *xsk, bool check_cons)
> +{
> +	u32 ready_to_send = load_value(xsk->tx.producer) - load_value(xsk->tx.consumer);
> +	int ret;
> +
> +	if (!check_cons || ready_to_send <= MAX_TX_BUDGET_DEFAULT)
> +		ret = sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, 0);
> +	else
> +		ret = kick_tx_with_check(xsk);
>  	if (ret >= 0)
>  		return TEST_PASS;
>  	if (errno == ENOBUFS || errno == EAGAIN || errno == EBUSY || errno == ENETDOWN) {
> @@ -1116,14 +1141,14 @@ static int kick_rx(struct xsk_socket_info *xsk)
>  	return TEST_PASS;
>  }
>  
> -static int complete_pkts(struct xsk_socket_info *xsk, int batch_size)
> +static int complete_pkts(struct xsk_socket_info *xsk, int batch_size, bool check_cons)

instead of sprinkling the booleans around the internals maybe you could
achieve the same thing via flag added to xsk_socket_info?

you could set this new flag to true for standalone test case then? so we
would be sort of back to initial approach.

now you have nicely narrowed it down to kick_tx() being modified. Just the
matter of passing the flag down.

>  {
>  	unsigned int rcvd;
>  	u32 idx;
>  	int ret;
>  
>  	if (xsk_ring_prod__needs_wakeup(&xsk->tx)) {
> -		ret = kick_tx(xsk);
> +		ret = kick_tx(xsk, check_cons);
>  		if (ret)
>  			return TEST_FAILURE;
>  	}
> @@ -1323,7 +1348,17 @@ static int receive_pkts(struct test_spec *test)
>  	return TEST_PASS;
>  }
>  
> -static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, bool timeout)
> +bool check_consumer(struct test_spec *test)
> +{
> +	if (test->mode & TEST_MODE_ZC ||
> +	    !strncmp("STAT_TX_INVALID", test->name, MAX_TEST_NAME_SIZE))
> +		return false;
> +
> +	return true;
> +}
> +
> +static int __send_pkts(struct test_spec *test, struct ifobject *ifobject,
> +		       struct xsk_socket_info *xsk, bool timeout)
>  {
>  	u32 i, idx = 0, valid_pkts = 0, valid_frags = 0, buffer_len;
>  	struct pkt_stream *pkt_stream = xsk->pkt_stream;
> @@ -1336,7 +1371,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
>  	/* pkts_in_flight might be negative if many invalid packets are sent */
>  	if (pkts_in_flight >= (int)((umem_size(umem) - xsk->batch_size * buffer_len) /
>  	    buffer_len)) {
> -		ret = kick_tx(xsk);
> +		ret = kick_tx(xsk, check_consumer(test));
>  		if (ret)
>  			return TEST_FAILURE;
>  		return TEST_CONTINUE;
> @@ -1365,7 +1400,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
>  			}
>  		}
>  
> -		complete_pkts(xsk, xsk->batch_size);
> +		complete_pkts(xsk, xsk->batch_size, check_consumer(test));
>  	}
>  
>  	for (i = 0; i < xsk->batch_size; i++) {
> @@ -1437,7 +1472,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
>  	}
>  
>  	if (!timeout) {
> -		if (complete_pkts(xsk, i))
> +		if (complete_pkts(xsk, i, check_consumer(test)))
>  			return TEST_FAILURE;
>  
>  		usleep(10);
> @@ -1447,7 +1482,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
>  	return TEST_CONTINUE;
>  }
>  
> -static int wait_for_tx_completion(struct xsk_socket_info *xsk)
> +static int wait_for_tx_completion(struct xsk_socket_info *xsk, bool check_cons)
>  {
>  	struct timeval tv_end, tv_now, tv_timeout = {THREAD_TMOUT, 0};
>  	int ret;
> @@ -1466,7 +1501,7 @@ static int wait_for_tx_completion(struct xsk_socket_info *xsk)
>  			return TEST_FAILURE;
>  		}
>  
> -		complete_pkts(xsk, xsk->batch_size);
> +		complete_pkts(xsk, xsk->batch_size, check_cons);
>  	}
>  
>  	return TEST_PASS;
> @@ -1492,7 +1527,7 @@ static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
>  				__set_bit(i, bitmap);
>  				continue;
>  			}
> -			ret = __send_pkts(ifobject, &ifobject->xsk_arr[i], timeout);
> +			ret = __send_pkts(test, ifobject, &ifobject->xsk_arr[i], timeout);
>  			if (ret == TEST_CONTINUE && !test->fail)
>  				continue;
>  
> @@ -1502,7 +1537,8 @@ static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
>  			if (ret == TEST_PASS && timeout)
>  				return ret;
>  
> -			ret = wait_for_tx_completion(&ifobject->xsk_arr[i]);
> +			ret = wait_for_tx_completion(&ifobject->xsk_arr[i],
> +						     check_consumer(test));
>  			if (ret)
>  				return TEST_FAILURE;
>  		}
> -- 
> 2.41.3
> 

