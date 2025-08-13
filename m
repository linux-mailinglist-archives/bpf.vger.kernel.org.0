Return-Path: <bpf+bounces-65508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E08A7B248D5
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 13:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606123B0FEA
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 11:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1732D2F746F;
	Wed, 13 Aug 2025 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzLYzz/P"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FB92D46D7;
	Wed, 13 Aug 2025 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085671; cv=fail; b=i8F5GwPU0vCn6aMkUsGvpgEMEAiUunAK6SY6YFDek5EE488CEEer0SpSpI5pAKHpZhUKASh0FSsgmalo9B24xH7aomwgj/Ni+/0I4rViqZzFpb3Ph1mnx9LtX9eb0bp7TXwlNii7vfsLEF/86UHOi6rMSUmD42M/JDCnrFG7hRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085671; c=relaxed/simple;
	bh=SisCnn+dbgCkpLcJd4sYylQmkxIAZzh9iDt4q4NiIEw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JsKYOheEoHeJHM1QhzlYnRkxHIlFNYopWwp0kRJe20b86fTm7YoJ0FlIu4LqAQfkvsLrtgM/ePlZz1M0G7VIqgDZtQTzYYjGDHNbu2VWPK5qEi6Xd4UY1NRTdCT6kTr8RON2/M5cOTZNxt56Gpi1GAx4S+mkWI8WdfB02nSAj7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzLYzz/P; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755085669; x=1786621669;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SisCnn+dbgCkpLcJd4sYylQmkxIAZzh9iDt4q4NiIEw=;
  b=UzLYzz/P7ySMr9Z8EqhXub7LT3WN3/4QY4EbEx522jXCrm0Ko8GLQjBS
   vxovwIqcZAjXpzq7hSs+EA6ctItxDNvIK7oBfmLekMpxcOxedAKck5LsM
   WCNtsvyruMMqixdzhECAEJlzitEdyIl1N7ESSRaWo/0GSYR8ehZUFPdig
   NqTI7nhFjKGMg5seNe9vxXtunKketHcyIN28IaIP/PSv4n8uow9BGmsVi
   RUykpV5NAXKla2ktmOUSNXElXaIh25JSwHikE558oPRh8Vw9t+X2G5+Cw
   vtAtF2MsdOtkUdTcD55tixCj9og0OLepl9TfFoJyAoxbSOmeAFr4lBMmD
   A==;
X-CSE-ConnectionGUID: YG9Xz45lRfiE5wBbvMfZKA==
X-CSE-MsgGUID: Yl/GnJB5Szmn00CQ/UAFrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57334994"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="57334994"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 04:47:49 -0700
X-CSE-ConnectionGUID: Q9NmHFzDQrW1lSO0G7pFPw==
X-CSE-MsgGUID: +L2EdtaRQkmildclG946pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="165674242"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 04:47:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 04:47:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 04:47:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.84)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 13 Aug 2025 04:47:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erltYwsUWzS99Wu6NsJQgZ8rOU8eSTp2nqFPOap0XXXK0w4Y8v2XCZlegrN6+u7qOxdUuypUJgiOGZ4OAU92BnjqigUfBQBQ4qKz6maWGA/q1njkVxW7/M0F443Hg68LbYjGYP1sUjT0K3nvqzdleRrF90l3zpRBESQmtckwWUJ4Gk2QYyYeqsYynZeLBvfNBo4Cx5GIKMS63gDA1YoXwX8T3ApFBhq0ZataDzVky3BPxPlzjdHJd19aQTXa5rMxeodguy/VT6aQfrRxVPDenOPtzTde1a/ox1FrSAi6L8aB+RlHuP83vxVi8ANitDxDU+a1WkEjODpBFDLFm8Kjxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLOzJ6ZLJqrRk16WI/vIcEtYnxHPM1RU8gV2BkSFfHk=;
 b=YyRYMVraCXB8fDF83CVHD6oS5Zw4k3qEZCYORNuZrS8nLEZzcHwUXMM5oSlI6K8y+c7JqWqcc26k6f+DkSxUJCOpVd4LMh6/xZpD/TrTGKypLGspFqmYCpCsYxFix3UdcWs2pFoKD11OPUX3b8Rx0tnHLr4J3QhAOSrlhlctj51he15Jt9wlIL9p0v/lmQ3/rggkhGQT+Bj5TmpJ+81yD5y0Z64qzhKXhzP2E+JnMaGuWMSZeTS5weWC7jQbZ5FRSPT3kGPnTx0uz16qH4ypcW9HR/kgB9XNPOJxTh19C3G4eQVRnzsP5bJe+bBfzGRq4OcLZjvZzi9JmFjwwq8qnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CH3PR11MB7177.namprd11.prod.outlook.com (2603:10b6:610:153::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.15; Wed, 13 Aug 2025 11:47:46 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 11:47:45 +0000
Date: Wed, 13 Aug 2025 13:47:33 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<aleksander.lobakin@intel.com>, Eryk Kubanski
	<e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v3 bpf] xsk: fix immature cq descriptor production
Message-ID: <aJx7VQoyIFHGivfg@boxer>
References: <20250806154127.2161434-1-maciej.fijalkowski@intel.com>
 <aJOGSRsXic53tkH7@mini-arch>
 <aJO+Uq6qNMqTsgtI@boxer>
 <aJSVhY4wWCLQLla4@boxer>
 <aJTWQDcpkz3Q4eNU@mini-arch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aJTWQDcpkz3Q4eNU@mini-arch>
X-ClientProxiedBy: OL1P279CA0070.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:15::21) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CH3PR11MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: aa56fe7a-be46-4f14-cb83-08ddda5f384b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OMX143XQjqzuTK/PNT2u+Z/uKBeERZBGGZL4GjZazQSUMKZAvNS5Tqu7bd6G?=
 =?us-ascii?Q?9RZ/co37jN2a8MXAme1SBr1J4Iyfmncx+/0gtvTLz0aCsZnoKKVITN3rKfs/?=
 =?us-ascii?Q?g6jh7lUH1HSXZVJq+t62HsGsEmv3hzpRmHqOrCxm/EAAl1tdczt5ozUukVis?=
 =?us-ascii?Q?8SeIVfW71A0zXyV/L5DCbJZe1LF4KWIdQXvE7MxSvP78ZnRXWNECW5i+bES+?=
 =?us-ascii?Q?tl1zjzp5rTapfHZv7SuIe0pePW9OQcv2Uv3+34jLgpLZQDbm6WAiMd2qNtm+?=
 =?us-ascii?Q?JzgMSpL48q7tW8qP4Vq8uAxdE2oBfavBGc3UmMysbOGUEcZQusuTnNpkjBT7?=
 =?us-ascii?Q?/jx+SzojnjHJFeh/yNWQVhRJ341iaquFIaPXJ7QEWpl7DdrN/iTlEcVYE060?=
 =?us-ascii?Q?3BgNK5Eoo2Y7/OP+HupLcKkzgk4pjxG4UmEabfvv68uw6wfIr7LID+BmBsZm?=
 =?us-ascii?Q?7S3GkeJlrbJNBh+zNVA+mIc8MuksQXLUAFhomd6/aaTdaJu0fzxhhhqGR1is?=
 =?us-ascii?Q?XNWB9GKZEwsf5+YPl06D/iMnUtL5PNWdZorp94yeXojijb4Wegkm0vaAGFE5?=
 =?us-ascii?Q?sYQZrToOAm7EyLe5dEkn01FDaQqlAZpFqbFGHlfZWcn06nrIA1CZDzCtHpKi?=
 =?us-ascii?Q?WUe4wBEo4XvXfFsjuWmMLTRdvEFbp1uLXMKhIGirxoZgEaM8qokAGmAkJC3A?=
 =?us-ascii?Q?204WQpU6V5IhA2fhn5wvOLaODLdCXZRmAx6Bo7J3aYYZ7zVefcQCeGC2/Lb6?=
 =?us-ascii?Q?HnfU0GcGfrsw4op1jLQ+nNpTLkGdIixKl6jd6jJjEjBFeCdFjtMNc5llgk2M?=
 =?us-ascii?Q?GRXtjOrk6So0xeXvKkqPmp7gDqm3X2cSDhd2308Lwt4LyPv9MyWOwI/R4tDA?=
 =?us-ascii?Q?Y5tVeYAki9MSuct/1ZwFcMOVl3zkDje/vNXhhWM+me0DJpQWrtaoYMzJzzB4?=
 =?us-ascii?Q?2Ya36NwhSD6T2wGBXf0RDQidWT3t7gMXLIIBmsUymRAT9F+wsPc2n3GoAnlh?=
 =?us-ascii?Q?C/PW25ld7U8ZxUQ8C2imtjnP6lXPbdARXEbL6/sPvkOz89WW9/2PXVSAxQf2?=
 =?us-ascii?Q?30lG7djQ47vjbS2lpmQLX3ui/VruCjed8/RlzZJAmP+bg6Rq1TEmpPVYMU0/?=
 =?us-ascii?Q?w8PNIFqoix6i6R1A3YPGPseqeQCwOzGBxNYpegZGvT/cmf4f9PYYobc680mY?=
 =?us-ascii?Q?Z1RekTdacARujko6LEq9Ljg+UjG9giIZBDSOu7awuyTKCZwfy8VB7u2BKtgW?=
 =?us-ascii?Q?QrBGH8CCF/vrmiRORuKRJBx6Yov7YMoH1Z3mYnesbL4oeEMjHz58sCeM8eG8?=
 =?us-ascii?Q?p0uISQnqjZxHIaAraI5gwsKbagF/n8EXtm34y7s1LFBOVAFFCWZjqeGdQ8wY?=
 =?us-ascii?Q?+wKAeWdNmPsgwHAUIriD7B0lXXTOfKErV21mQ9/V4VpOz59n+hMjh5+/va2L?=
 =?us-ascii?Q?/7o+MtwsnA0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fN0GWebJJEdyKT8OMv07aXkJ6KHOterayGy6pKcjqeKlmCSxng3Gv/sm+5Pj?=
 =?us-ascii?Q?G9d45qbhJTy8xH5ynsIGI0j2hxBRI2qau44xYu0okES26WnEnUYP47YoZ+UE?=
 =?us-ascii?Q?fIlO50keYfs5OSA7McumtEA2exa3firdyC2L3nSnpfAcFqQZae7ZiUVvNpVx?=
 =?us-ascii?Q?uz+Jx735ALQkeZbLBXiVI8oEatn02c1Gn4HdHgPufb9AoJQgnn2MtanyUF3o?=
 =?us-ascii?Q?4ahsp8UvYR9klJ9X5+0l4bvj9j3zqmnSy45wW844K9jYyMLA4GM75HU1io2c?=
 =?us-ascii?Q?hamS9U+lsK+/udNj3mYTP/OSXYPCfbI3XI5aWKoHFCa4hX6CToBbOLrA1VM1?=
 =?us-ascii?Q?kDbPUlMjW3WeIF1n+L0NoLTpb/ijzbucFee6CKQImAsD1FV8pSJI7Sk87I2k?=
 =?us-ascii?Q?yGyu+JRLYLTlSi4JmPWDDcMJSiC5tOQgo4a9ri5TPuzJRaySrbFrULyT1RzG?=
 =?us-ascii?Q?yPD94aPkJi64DqHJ++uSrLroKpwR/g1t9x0nEssjng+Li9zpeWcBSF8xdn2O?=
 =?us-ascii?Q?QJ0EVvA9hl4lqUjfGI/ASa6dzBFO69l+FGptsruyaQJT5iEcg8jGhLkAbVaF?=
 =?us-ascii?Q?KjyFV3vGLe3bWY+yTMKKbxVD0MX371dAqTj1zPsalBjzh3fXBSEIBpJVtTW4?=
 =?us-ascii?Q?xdWuNa4YTuV8MGMajEenV5kpJn7Z4boRtR/PLTGQALKCSlkvN7CZfbI4jc11?=
 =?us-ascii?Q?CmMPNrGLqbrnBljlshQh4hOeHS9fuQrgqJuyigUivvyob7FuhAsDzada+ME7?=
 =?us-ascii?Q?KfBWHj2QlHOAE+leplwWpKtslGimtTRy1aqUO4yOyC21iNWLusLVIw97/Llx?=
 =?us-ascii?Q?VIAuHKbbFLF2eWCITFPGh16nsnS5YhMsQrEoGN1W6vhRX5j52/oS3JTIlYHu?=
 =?us-ascii?Q?eCPczjJuOb1IXnRzeB/kg2XFYqBYA/9z0H0iFXVkYqqSjDrb06nxklS3pQjq?=
 =?us-ascii?Q?MyF24OF+jaDeJfEwXBDIzswjX8jMfvlMZ3MeuL3hmpZ7f/EVA7UiWrbiicHd?=
 =?us-ascii?Q?3f8Zrxq0lCcmZoEbJRIugfDaEq2fEckUUHK39WkGiY+7E7dqevjmYw1GTl8t?=
 =?us-ascii?Q?kgciIHGMAcstoiFx7LeNm59E7t8xkAMFNYwTQLtwyaMrS0IYa7qGuuxWjXCu?=
 =?us-ascii?Q?EkJMhX5Fn23/UaVF8RKjvqgbgUp9ZeOBccmsrvVdpjPkt/ZffiBzSC+kAJOi?=
 =?us-ascii?Q?jnwAQtAl7Pi8YgzyLIk3+4sYI3hcOKa8f6ex7i+ddzCt1+0U6+WUTYu34OV2?=
 =?us-ascii?Q?kJugzTSxGgwr4GqaAfybEh9QOKbyDMoPOsTAEDGz1ACoawpHxyRoT2qd38rH?=
 =?us-ascii?Q?z8fFHb4AeO28oIEqK7WlKdTlRBpENfaxliGA3YYlRoIUxjd18FwLga0V4F5T?=
 =?us-ascii?Q?nc0TOmUM4AjPPK+qpy3rUWiqYw/X4/4gsSrrEWmVO3WwbbKWU31SUQjYOWmi?=
 =?us-ascii?Q?bIx2bW9RNdUfIRUkg1QLzNjrwMxSMlgF93+WYfSzB3zYyKwl96a2OJhNETZm?=
 =?us-ascii?Q?9lTxIoHHc12FhIbJLbjLegkCkHZi9kSUNxcoZgE0+oHRYaG+eUakB89x5IVc?=
 =?us-ascii?Q?euO62EU4nvSSFNCG2bWRmJVHlhu6kfZUT2HS0J/jUGgyeCzPL5N8q31KnFDt?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa56fe7a-be46-4f14-cb83-08ddda5f384b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 11:47:45.8886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjU1JUt9fVU+ixQI43kgRq4t3sn8rzVVXDgt9755XMo/xne9/F0Kon40yMdeZ2S0mcmKqwbnGB1PdByryetqxvb0fkXLjEhsYLlmqUJOTk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7177
X-OriginatorOrg: intel.com

On Thu, Aug 07, 2025 at 09:37:20AM -0700, Stanislav Fomichev wrote:
> On 08/07, Maciej Fijalkowski wrote:
> > On Wed, Aug 06, 2025 at 10:42:58PM +0200, Maciej Fijalkowski wrote:
> > > On Wed, Aug 06, 2025 at 09:43:53AM -0700, Stanislav Fomichev wrote:
> > > > On 08/06, Maciej Fijalkowski wrote:
> > > > > Eryk reported an issue that I have put under Closes: tag, related to
> > > > > umem addrs being prematurely produced onto pool's completion queue.
> > > > > Let us make the skb's destructor responsible for producing all addrs
> > > > > that given skb used.
> > > > > 
> > > > > Introduce struct xsk_addrs which will carry descriptor count with array
> > > > > of addresses taken from processed descriptors that will be carried via
> > > > > skb_shared_info::destructor_arg. This way we can refer to it within
> > > > > xsk_destruct_skb(). In order to mitigate the overhead that will be
> > > > > coming from memory allocations, let us introduce kmem_cache of xsk_addrs
> > > > > onto xdp_sock. Utilize the existing struct hole in xdp_sock for that.
> > > > > 
> > > > > Commit from fixes tag introduced the buggy behavior, it was not broken
> > > > > from day 1, but rather when xsk multi-buffer got introduced.
> > > > > 
> > > > > Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
> > > > > Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> > > > > Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
> > > > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > > > ---
> > > > > v1:
> > > > > https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@intel.com/
> > > > > v2:
> > > > > https://lore.kernel.org/bpf/20250705135512.1963216-1-maciej.fijalkowski@intel.com/
> > > > > 
> > > > > v1->v2:
> > > > > * store addrs in array carried via destructor_arg instead having them
> > > > >   stored in skb headroom; cleaner and less hacky approach;
> > > > > v2->v3:
> > > > > * use kmem_cache for xsk_addrs allocation (Stan/Olek)
> > > > > * set err when xsk_addrs allocation fails (Dan)
> > > > > * change xsk_addrs layout to avoid holes
> > > > > * free xsk_addrs on error path
> > > > > * rebase
> > > > > ---
> > > > >  include/net/xdp_sock.h |  1 +
> > > > >  net/xdp/xsk.c          | 94 ++++++++++++++++++++++++++++++++++--------
> > > > >  net/xdp/xsk_queue.h    | 12 ++++++
> > > > >  3 files changed, 89 insertions(+), 18 deletions(-)
> > > > > 
> > > > 

(...)

> > > > > +	xs->xsk_addrs_cache = kmem_cache_create("xsk_generic_xmit_cache",
> > > > > +						sizeof(struct xsk_addrs), 0,
> > > > > +						SLAB_HWCACHE_ALIGN, NULL);
> > > > > +
> > > > > +	if (!xs->xsk_addrs_cache) {
> > > > > +		sk_free(sk);
> > > > > +		return -ENOMEM;
> > > > > +	}
> > > > 
> > > > Should we move this up to happen before sk_add_node_rcu? Otherwise we
> > > > also have to do sk_del_node_init_rcu on !xs->xsk_addrs_cache here?
> > > > 
> > > > Btw, alternatively, why not make this happen at bind time when we know
> > > > whether the socket is gonna be copy or zc? And do it only for the copy
> > > > mode?
> > > 
> > > thanks for quick review Stan. makes sense to do it for copy mode only.
> > > i'll send next revision tomorrow.
> > 
> > FWIW syzbot reported an issue that "xsk_generic_xmit_cache" exists, so
> > probably we should include queue id within name so that each socket gets
> > its own cache with unique name.
> 
> Interesting. I was wondering whether it's gonna be confusing to see
> multiple "xsk_generic_xmit_cache" entries in /proc/slabinfo, but looks
> like it's not allowed :-)

I played with this a bit more, side note is that i have not seen these
entries in /proc/slabinfo unless i provided SLAB_POISON to
kmem_cache_create().

Besides I think a solution where each socket adds its own kmem_cache is
not really scalable. In theory, if someone would have such a use case that
would require loading copy mode xsk socket per each queue on NIC and there
would be multiple NICs that require it on the system, then you get a
pretty massive count of kmem_caches. I am not sure what would be the
consequences of that.

I come up with idea to have these kmem_caches as percpu vars with embedded
refcounting. xsk will index these by queue id and at the bind time if
kmem_cache under certain id was already created we just bump the refcnt.
I'll send a v4 with this implemented and I would appreciate the input on
this :)

> 

