Return-Path: <bpf+bounces-35629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D287293C0D6
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 13:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881CB282CBC
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 11:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9C1199239;
	Thu, 25 Jul 2024 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WI21nj7+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76BC1991CF;
	Thu, 25 Jul 2024 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721906947; cv=fail; b=S4OQ4S1DcHkZr8KyTb+IpPZOA+g0kGFaBbHNfOzgIVBha9//tSTSgjGlGBK3zM4fuu3YOk4lnV09nmNsRCgACAhTOVGRO5I1qV1w2GuT16upsMpKDTG3L5F6Efx5GtP2B/OMY6sY1mqYkOB8SBOL0CLHpoNu73OUaXTEYdrt1+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721906947; c=relaxed/simple;
	bh=i6WIZRtwOR8MOCm9LEmKIHDvKdZPWZGXroq6czyHU9I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LdeMtmhXlGM4rqsmsqyKGzR7mmEzmrBkPi77Kc8dWNiHvT4kxAjmFrqDfHfy8mDa2BIMzS8KjC4s5Y0WQLh9KBy1fC5IEoVnIxaXZWDrcGUCZFmVCgEtDeVPFOS1A3DD9+ycl6O8SRHu85qjTCElnZ3ecAkO1jthbUAcA11lytI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WI21nj7+; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721906946; x=1753442946;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i6WIZRtwOR8MOCm9LEmKIHDvKdZPWZGXroq6czyHU9I=;
  b=WI21nj7+5fHpoRj98HZ43YXoBMxfEcrhyyVyOR+c6ecRznegEHN0F/ft
   /zQGrY5ITGBtR+BQ86FF1gD8von5dIfjXV9vhRoPp5m1Aqqr15XQOUODm
   P1ubaZwvMzlf29WJey6rsmkZUeNaL926Ul1zorLpRSSQdg2iqqG53Glob
   CPlPJBWllOfEALQJxg6y/iaSlOFiUEZx3uyCqvYmqVwhN7ZkzBczhJBkM
   DzmJatuydv+RXjBOLd+LkZBDnZ/bHHjOcUUG76Og6qM/8dbTpY3DNNRRU
   thWGkVFc9gw3F/YieIAVHhSQ8iBtJ/UHyhg0OzA+LrPISaj+TftcAt+1q
   Q==;
X-CSE-ConnectionGUID: oLsRE/7XSSWlvffn9ztxOA==
X-CSE-MsgGUID: WBMKI/DgSVikhnDCLla9Ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="37091102"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="37091102"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 04:29:06 -0700
X-CSE-ConnectionGUID: CS2q9FhmTmu28j9OIMwvlQ==
X-CSE-MsgGUID: yiIJ7sxHTIqVoPC9gFtL/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="57702627"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jul 2024 04:29:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 04:29:03 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 04:29:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 25 Jul 2024 04:29:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 04:29:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyeFI1lxDhtG5u487U97E3ZIfm7+NlsvSHf/YP26MPZc6Wvn7sGEDvEAZEx83CZiFHgmq52B7pPG9JI5d5S0jhpjv9E8DMgIzXJGDnF4u7/9L5K9+VR/Dl/47V6SrSaoolX8pnCyiyNZ+VZ4Rv+NAJmgPuDV0PEYXMdfWSMkRdBYnm7Sfb3qeASJ+XYYrFNUMDdxg9N04FGYlBq4SBrKiIgaJpIYv3J5fsmJeaXrkBKQsjugy0GS71Zm3fEDSCVZ9RFFh7YOeO6Ol4BbHDp4YqxJUaw5r2pO8BK5B4+9PjtngJ4ZRgplRGWSOlB+tw9o9otJNH4LCqqA5ZRz/VIjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tBdQUknU3wu41OlIH2dpiVuEq4DENoRunqjqvgUAq8=;
 b=sp0DO69P6tDF3T2szWhaDkrPmNxWVLSFzdaI5LhdzthIjEe/2GDDKpBAwV/D5LR7LU/XSswit27kKD/vR/uEjNg+XXjnpHp7kxUW+EP0Utnhwvv7O1tRlzd8yLeHiDq6zk81F7MekYvvMW4v1fVbRiV3pmnyqtRtNn5cGS6BjFzcKO3RIH7WwYhIBRbbKkscc6aUbSyq+sjGSMB+nluwDLxufq6mbJ7gUHlupynQg9fC1fo0wZVCSkH9QDflYNcRCmf1T17zXd+EBA0nHeogGpx7veMfGMSBrJ+EEK7D64iaBE0uPGqsi4J+qvd330ZIHME4kjn3og8HNFbfNJexSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA2PR11MB5017.namprd11.prod.outlook.com (2603:10b6:806:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 11:29:00 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%7]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 11:29:00 +0000
Date: Thu, 25 Jul 2024 13:28:53 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Daniel Borkmann <daniel@iogearbox.net>
CC: Stanislav Fomichev <sdf@fomichev.me>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, Julian Schindel
	<mail@arctic-alpaca.de>, Magnus Karlsson <magnus.karlsson@gmail.com>
Subject: Re: [PATCH bpf 0/3] xsk: require XDP_UMEM_TX_METADATA_LEN to actuate
 tx_metadata_len
Message-ID: <ZqI29QE+5JnkdPmE@boxer>
References: <20240713015253.121248-1-sdf@fomichev.me>
 <ZqEcim8E0qK8MRQO@boxer>
 <f30e6532-28e3-dca8-1274-e6b31531b84e@iogearbox.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f30e6532-28e3-dca8-1274-e6b31531b84e@iogearbox.net>
X-ClientProxiedBy: DB3PR06CA0017.eurprd06.prod.outlook.com (2603:10a6:8:1::30)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA2PR11MB5017:EE_
X-MS-Office365-Filtering-Correlation-Id: 908139cd-3630-4645-65a5-08dcac9cfad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fyvM/WINZdtXWUhcqoVA1fH57eSH3na9ik2xIggjn3UX93zVMCKVH4TMKv4L?=
 =?us-ascii?Q?pZUoWzmQ3E9xNtk4kAoHXeZegZyX8Pg1gbwUikISWr7mp/PCQ3Q5SbHtwbKE?=
 =?us-ascii?Q?RssjH/uP8N0VBtVRIJ3+HuzI/U/m+mLdVU59qDCt2ak7VDMbbCYLVpRnvpTO?=
 =?us-ascii?Q?0ltwNgtXfz3JXIrvjOA2nB8s/jxRZpXhStQDrL/MwhHHPnF+BB+paKoIvcu3?=
 =?us-ascii?Q?Wi+eidVDtGSVtq4uJrqWRg78WzZPsj3nESm2qfaQKxJPT56DVKPDaseRtkBy?=
 =?us-ascii?Q?14EsEnOXDu7jgqbdro0/UQGlJqZTUIziAp7W1ii3oO/ebU+fKbruFwXxcnCm?=
 =?us-ascii?Q?Oj1uSZXGaSfmj1aG6SZD/HWHkFvo6aZ8omzWIYwmHm+VGz5LgiP+inbunMGn?=
 =?us-ascii?Q?G/Te8f1JQ3nxRtK6QKe293fyWyqmW8J3nwPqgeSir5tHrZJ1dQ3rjQH59kkb?=
 =?us-ascii?Q?KmPeQkDikn/ICN1ZWY/c/wlxRPIJGx64qDln1cTAJW4JqnNbcnwCvfMJwtH4?=
 =?us-ascii?Q?pxXSDcvkqo3ZjOAFO51Rs9tc7WB6i41Lt9mCuJiT3rRzSVVefgTiStw3qGyT?=
 =?us-ascii?Q?308bGedQD5hYNN0OCtF0rkdHqyOMEoT+RK4DTh3RahPkp3ac6m/qoURBsUs6?=
 =?us-ascii?Q?0jwpxLjontUEP25CzWdZP5TD0IucBQdEhltEqf+mwojQ1vGe4AW5PBG2RjIK?=
 =?us-ascii?Q?F9rOEg/NpGRvyKWUIWWCpLdrWlJhY9MIhErd6Q85FxAbXW4/vbG6qeLjwUMY?=
 =?us-ascii?Q?5xV2Omsf1h6hkNf/sLPU6ZAmv1KjjRK+Jm4d7o/EjFPhG9KnNsTxVLxi/2z/?=
 =?us-ascii?Q?n92nBU+AQ1YATZqJ5AYiT+VHdFO/jPG3RiwFGsjhjXFiJke8tyLRPQG2qxeA?=
 =?us-ascii?Q?9+yIuzxm3q1dqlIwhfJxc8J60fIOCzGM7nvt3ZGtMmCaLEkXNecTQ4W7xzXG?=
 =?us-ascii?Q?VWAxY7IMgMaLtnw+pkU5XnDbsSpAKDRoUESyT/lllOYUYNbfU0rQtyoITZrO?=
 =?us-ascii?Q?Iz0tTy7M+1Ey0EPTdR074yGhmlCTbXbpGm8mg/Qw5/lVivg97O4FKadRiG3L?=
 =?us-ascii?Q?+ZJ3wYmjKAb+CgD4mFXm+9xuwVfw55IZP0cXJM5tE1/XEXJa2odT9+M6UfND?=
 =?us-ascii?Q?USQEZNjjF6DWsqSJB99F16uEQyVJIWE9CQ7JXlsf/XyTIsfBFteUiEqCwHhf?=
 =?us-ascii?Q?iaMeRjrpqyfxoRw8sGJ0hNW0WqCCNUQD4+9Jg6/M6ANHqh+Y0pzi3J7TPM0z?=
 =?us-ascii?Q?Jl+5oPh6OQj1WdnWkDGw615OCRhA31Qicr0HBa8k+cD4BTbkqkbJrEiKiICe?=
 =?us-ascii?Q?IKNYNjeWovzmkQQJyQrNMRQlohq/92/AgSwQLLD1whnhiQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/cb4r4uhfJkNP5hnmmQ8nV//ClsknScDVStV3yJmgbp7B4tWS2PQlYUusffU?=
 =?us-ascii?Q?J4QST8BUzYqyN9F71NIRpa/oCQ0+Mh78st4WJG4NqbBG+dApqR4zfQ9gUrk6?=
 =?us-ascii?Q?pEcfB+uoRSyLoqq5aWES0cg6GQslujw2MX+CJd6ZnVSU/j2U9bN5qs0CtW73?=
 =?us-ascii?Q?KTaZqfJxTUm5lKidVFi9+R7nZIXS1VxvKPbHYBVmXxaaT/zBmOuVoCJnqFLj?=
 =?us-ascii?Q?/hXN06Qvgwia/BJ2ui2QD+XXOsqDWbRTw5CQZB/Kl053XfTjnbSq1/+OYbPQ?=
 =?us-ascii?Q?yNtIz/jiX8L12dUAla30arTe0oIwZwvuERXg2pOeKusk3q6vHDtnIP/5kcRX?=
 =?us-ascii?Q?7Q6jZVVHdmddulH2fqLyBx8c0wxJ1f2LPuWYGPZCv+DrYZ5cEsH2Aw0vyJgd?=
 =?us-ascii?Q?tnFaNNkNkLf1h/P76tZXR5YkSmWz6kA1qol6/b2PCyWOhSGadQ2516XQwCzx?=
 =?us-ascii?Q?yjdsuIbP9l/l0oaCOlJfKDAjVQx12hsI8Ij3IS9TUinkOa/XEUWnikulhsFW?=
 =?us-ascii?Q?uoPCDmAIN2c7Tsp+P/0EiLwZDrXYCF31lr1rJjK1qcLIqfIxAlB/pQx0Lv0B?=
 =?us-ascii?Q?bnmSjrlMTEc/ySPOWUhd2kt8w5i+fbvm6ttxjog6kFon/pTrcszB2lb5o/nx?=
 =?us-ascii?Q?x7kDtEAPsEIyIKP9vIjcIetXsaWE06K3bLqXMjRIk3JqCOEOzrsbabT5dQSr?=
 =?us-ascii?Q?fSEEtVIIYcRJJF8pqyjKUc7tlf7H6YfeP5LqiFi5DDaTZhTWOhTjXVfFs4lZ?=
 =?us-ascii?Q?tyCxVdsVon2QqKQe6bpmTstPYsAyPzHRoJA/8nVTrVzVvgwHkO3jDSlhLXZc?=
 =?us-ascii?Q?Uj/U+SXFSdD1O376q1tOUM6oN8RdSSosbqh4l2gDrcUd1xC/3blccJ5hbziB?=
 =?us-ascii?Q?YrKxgN4DALaO34CSh0Ce1373axU/v6ak1Vm6dWofyL8cd7FeBsAtXeLmVx8s?=
 =?us-ascii?Q?haOEvpiXsQSM9taE6CXaPh2V+JXnctsqyq5upOQrz4dpXimk6CF5ZPD2tzOr?=
 =?us-ascii?Q?YmStUlqQm6XmW51VISOsMGBI4CJ3QNXdonnvVTXNg1orUPJVuNnOvXbog8RJ?=
 =?us-ascii?Q?jLWbw04wsUfVs+R/7ErxFiiB+YLl7hkJz+B75W3733Qmhf1VtOM2ze27iJm1?=
 =?us-ascii?Q?h7J+kH37eb5HrJVn+zAxnIbZhT2zfJGSTvjMfoQ3MtkM1F939M2S6on9JHOE?=
 =?us-ascii?Q?8CD8+/vsX58Q1CFAUigAZQiZUqXi6r+Eu7BW03tkzoMd8t+25MpHNVcnuG5f?=
 =?us-ascii?Q?lH8Z96xOz6eB2rc5Jp6CXuUclAl37AaQl5/GzMGWHkUM1Wf5z7jbOOykXu1q?=
 =?us-ascii?Q?4Xwb2i6n6cshSQNL0iEWb4UL8abxuc5BI6vuCMec8fRQ12S/F1lNx95Xgetj?=
 =?us-ascii?Q?cJtqecjToE2DabdnsgTZ0647Cl/6gedaCv92VUE7qYnFSImxMBJJGPXGD0ba?=
 =?us-ascii?Q?TtdlhpE8NB4SHS5cn5x9qP06ddaBIUY+HaRrcxy75yrzxPi89GQm/aRsDQYw?=
 =?us-ascii?Q?+WP9siKLssllYqn7hv6bq8/Dlt6UQP79WZM9NF7Q58JEpCZoMcpIBL4f2O7Q?=
 =?us-ascii?Q?ObKPqbhakVG/bA4hRoE7aysAo6hmZ5kKZiYS+blzkaV6m1tbTu9zRxBWbl38?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 908139cd-3630-4645-65a5-08dcac9cfad6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 11:29:00.3962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gujvnEe5lJ+GGC2P0e3k841matj0GHHd7Dl+CgFsw9DBeaXjRGjr7fj6rvCdW5Ikt+3tEoyvrSLn7sdfpyK7fCLRVCrloXrW1QyMLwEhmsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5017
X-OriginatorOrg: intel.com

On Thu, Jul 25, 2024 at 12:06:22PM +0200, Daniel Borkmann wrote:
> On 7/24/24 5:23 PM, Maciej Fijalkowski wrote:
> > On Fri, Jul 12, 2024 at 06:52:50PM -0700, Stanislav Fomichev wrote:
> > > Julian reports that commit 341ac980eab9 ("xsk: Support tx_metadata_len")
> > > can break existing use cases which don't zero-initialize xdp_umem_reg
> > > padding. Fix it (while still breaking a minority of new users of tx
> > > metadata), update the docs, update the selftest and sprinkle some
> > > BUILD_BUG_ONs to hopefully catch similar issues in the future.
> > > 
> > > Thank you Julian for the report and for helping to chase it down!
> > > 
> > > Reported-by: Julian Schindel <mail@arctic-alpaca.de>
> > > Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
> > 
> > For the content series,
> > 
> > Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > 
> > However I was not sure about handling patch 3/3.
> 
> Ok, then I'm taking in the first two for now as they seem to actually
> address the fix and the 3rd seems like an improvement which could also
> get routed via bpf-next. In either case, if one of you could follow-up
> on the latter, that would be great.

My first thought was about squashing 1 and 3 but I hope Stan doesn't mind
sending 3 solely to bpf-next...

> 
> Thanks,
> Daniel

