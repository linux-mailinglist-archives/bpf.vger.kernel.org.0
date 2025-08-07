Return-Path: <bpf+bounces-65193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B78B1D72C
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 14:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407A2189B955
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 12:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDA623ABB2;
	Thu,  7 Aug 2025 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+iqlgrw"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294A81FDD;
	Thu,  7 Aug 2025 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754568087; cv=fail; b=P4Bz44X1S3SnvFYydHphmqB5fIqQYL1GADApnya3Sg5FVQfNmeRsRpzRYCR9K32P7Wl6D7NBh2wyNBEcCXtFYgul8D5yNOalJPEZ+b+F4EURgVDHu/QNHMgTr02abYgCEj16og1liPdPkF7D+agRZaCQZx8zCTT7VThZ5s8dI0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754568087; c=relaxed/simple;
	bh=009CoD0BqMSBxwGHBl25ZQlnrqdNIoCWymwJeg/Q8/U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LCAESLB1s7I4oBYiTTJWkz/GekMVmd6XnZthsMaDIz359osEfLLlKkVI+MfliSh0LJfeM4xCZaM7BVMLmHAdYzQoDoP3DebqT5snJFo9uzxUEsGof+zFfWrcJKxFZmSk9xKojtZvV/U4XKI81e3krhasnSpzGdaB9TgIJjOZSGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e+iqlgrw; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754568085; x=1786104085;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=009CoD0BqMSBxwGHBl25ZQlnrqdNIoCWymwJeg/Q8/U=;
  b=e+iqlgrwY02m5AutU+9Cn5S3qSB5wg5HlCSYTNA81OFtcoooPpf7IXyh
   7P0zWlqkLLf+AeSZAQvXe5cMz4pgSUApNN4/yRNqu4dRz9o7QchEL+p0K
   qDcMvdUkbG8v4HVLcIGh4ZhunVT5DfIz8+/eYo+AMQjzf1smISH4pvXvk
   utXbtFcanqqtf2LDGV+h74WBY8zH2GXF9/4t1hbLvC0U3AtZAcSusDw2C
   d4/6Mc2txOi5zVO0kpP3rv3pYI3IYdIbmjgQnjg4Zl7Mhc/Qfz3NLqXSC
   W2QmPQkpzJricjHTv5d53sSwEbCNImGbbk+1w0gR976MiJCsGn3tfTPkw
   A==;
X-CSE-ConnectionGUID: Qzan1q+YRXeUVFyBYEsfog==
X-CSE-MsgGUID: kg2ofBezQTWAQLPmn6IX6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="44490981"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="44490981"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 05:01:24 -0700
X-CSE-ConnectionGUID: PWdnmCwHRta4gcZ1rymABg==
X-CSE-MsgGUID: Va/AZRQiSb+muf17zmJT5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="169507987"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 05:01:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 05:01:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 05:01:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 05:01:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgJZD9ueI3jiqd+QyhwBXgPkxQC+21fXDqfGJKqYhoStrDaThc7foZoNH3jPE3q5C1QCTWFND6QnIwv3lONe+Pg8/gDVQKst5EQriulOl1T78jE34fMiyl0nJ8j6M1zDLMtpSe7agLugndU2xUn6j52+kyeJOQSwbLqETeLp3hK5bLEhCCaJt9gsNFMQCRJYrB8+Bwe+ihWJ76hAB5uaAFDRXhexBlFSMZoH40GoxpiqkezEZSDI+RuB9xcPzAsyha0LECkt/yMzfwKVzrNo8zkaV8OjV43QeZaGYtKdFdH3nTCC1HyyslDDmE65yks4UzIFqCg83p1tBpxr/8+z1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FPkbJ+8F4SrlGh6FY9oRLld62Q406INYB+Kq2TxU4U=;
 b=qiK55O359BL1g2UABo1sqc8Z518Sz5ZnSnWMFCE8RzL8SqLWslNatK3Bs9HVSEjX+ICoJTKzeRk3RBV86qs6zwdH3UlJHQOkz7ayMSIzcKrgEVUtrSxSHZh8kM+Rd/sDyg2aljexCjmXH/4kbmCy7jw/mBCv0qD7C++dGT7ratj4BBlL+nkRsSMjssVgeIrdkMnUzjzpWfIorMZY39AcdkxmOqiTwD51fjQ0H22L2PCnQu+Nx6TQYBCVmUDPxA8B/b4K8c5QoyWmFvMkC/Cx/AbbKPnK7DCzSw/g4/WMg+2NsY9ItMf39IF3SO44OXfIKZ5Ps4oo7EYdoBQdNq8gWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MW4PR11MB5889.namprd11.prod.outlook.com (2603:10b6:303:168::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 7 Aug
 2025 12:01:20 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9009.017; Thu, 7 Aug 2025
 12:01:19 +0000
Date: Thu, 7 Aug 2025 14:01:09 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<aleksander.lobakin@intel.com>, Eryk Kubanski
	<e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v3 bpf] xsk: fix immature cq descriptor production
Message-ID: <aJSVhY4wWCLQLla4@boxer>
References: <20250806154127.2161434-1-maciej.fijalkowski@intel.com>
 <aJOGSRsXic53tkH7@mini-arch>
 <aJO+Uq6qNMqTsgtI@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aJO+Uq6qNMqTsgtI@boxer>
X-ClientProxiedBy: DUZPR01CA0328.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MW4PR11MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b156313-a0de-4339-e78e-08ddd5aa1ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dQZOJUF2MibG9e/PsIwWCpxA7iZ9bdTxx3aq1GKUuSlRBdXoO8RLbUtIW2Rd?=
 =?us-ascii?Q?RZfGSMX6BsubbVD2dLcxL/K3Y7YwQWmZ51fBRnFyydnWu3dLr5o2t6/hZ2cn?=
 =?us-ascii?Q?0KN1Q+bPG/2r7YvdoDbp+dbJtV7n1v9VvI0nJ+H5TNZG/hBuUP0mLwqmpDN0?=
 =?us-ascii?Q?IGwAdQRQ0HFGp55wUSzOEmAITWLrTEEMkrfTF/LLYwmx/WVWSxVH6cM2OGHR?=
 =?us-ascii?Q?RtlSh48NKCOXbpyrbvmMM0xE1lLUQYi6FviLrVV5idUcnW+EyYeAaLwDqd2u?=
 =?us-ascii?Q?9zCFmFN+QD1CZskWqykIOsCLWMBWzzApARl8aVKjrTYYndxH5fhM/wtG9s5I?=
 =?us-ascii?Q?gJrcTy6Du5XJ97fXGNQMuqhTrUuRtQ9X7/vC05Yt2sIZY5uMjFFhTGX0cu16?=
 =?us-ascii?Q?8h215oL/lDLtHjsIjf1iDHznknVpAIoxIr37Vr0OzW3Qt7M9vBG16AGD8RNk?=
 =?us-ascii?Q?W+Vni/1zOAkf3yT4Mmi3S/DB+wAGm3TT86CUCeSwZOs2bQ99JhlkPsm9GNQT?=
 =?us-ascii?Q?LAXxnZ0InE3VgpcKBZFVZZmB3hvNp1NNT341GNMAo+Z+9/6OYYgSXTkcMQB4?=
 =?us-ascii?Q?byW3TAqqMUuIypEVb+igBIbx6Gi7bKwI6ZhfvO/iglvxiLyZNb+JQhRLWLOz?=
 =?us-ascii?Q?9qNzuwp54P6Vu2aeA0Pc8io37pLWzAr5mERCBPCmTaf3k/I166U6rFLncamy?=
 =?us-ascii?Q?qkZxIAvkpl4tFFFT6ATRw0E7SNDRXnnObdJQSgElzFDJsyUT47sSN85OGycd?=
 =?us-ascii?Q?BLmG0Ib+GSCwO0VQOqoI9fo+U/c8Cjb4cYBzSDR3aUvYONBKIGqeqJ92xJ17?=
 =?us-ascii?Q?7PPysW6qkBTLwZFYc+SQtMjC2c/kk6cARiSL2VDb4SW2f44kd4KIONMAB8bn?=
 =?us-ascii?Q?fS4mDPuJV77hOYkQrrc5AW3PctEPoiaOxPJVZpg/i9gcVGHlL6bvUdFZjG69?=
 =?us-ascii?Q?/sIu674xz9h6lBLZq+NSEfKuikrqUX78lMAPw7vqGj611m4wEye4tP0eZG9C?=
 =?us-ascii?Q?kfEWvDm9SXd9al5CdQaFpZHyd/UkBoEiECRiW21vzfR/HLBp0C2Vaj+K2RI6?=
 =?us-ascii?Q?FBE1dFXhgsOnOZbrkgPjYiFrCfej07xm0DhGvtQfuhGCpN5zkxwVG1gbUvq7?=
 =?us-ascii?Q?u6WZxw3u6xB8yOIaAoPIpw1RVUh/b/ScKuBfepvwRskrEHWga26zRFu83kA+?=
 =?us-ascii?Q?7BY3rU8z2PHDLGsYorqtGkMkoGNngmgXXkWif0bKpMpzqxTO4yUpHmT+MdBt?=
 =?us-ascii?Q?HcEoBvS54y7EOlKT32cKjelcgjlmWlYu0vUW5r9O2YGBJbJNrdj8Y8v8hKhf?=
 =?us-ascii?Q?jmKOWHFFHOBYZCIzGraRc0fOqVa1eUAbjikljtsELd5/HL5AufUzhCzqJntC?=
 =?us-ascii?Q?oNsT1UGhPff4/4z0jleRpeZyz3WKuakJ9VN4Mz0ew0Llm8qosN70ikNevJXQ?=
 =?us-ascii?Q?VRxlK+pIgxw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6GTfeMU1pYNO1JAKoM3FdO/Vgg8UhuCcqyIlDMCca2H65dhpK5ZJoyI7LfK3?=
 =?us-ascii?Q?WRzO+++MpxNM3jcPnM/y4hxZKpM1yiwtMluBkfNN1GdUhVw39hpPJIBMq659?=
 =?us-ascii?Q?YC4HXe8KtkNEPJRDy/fz1xZupPGwElhpZwGEb37DUCKPGJK+Wim84wtqIGvF?=
 =?us-ascii?Q?iR2nmAmId1XG11nKbvvM9dPMufCY6MiqTnMoIbpsUewkvgxycExRU3LZlF/Z?=
 =?us-ascii?Q?oDkirdLCerjhn3uPT7yfZS+s2D9B2pCrZUCx3aIXGOQwrggEc1GFjMjHNH2I?=
 =?us-ascii?Q?Vs0L5e+cikvPCP0D4utxFoJaJMbH+BAmcHptc4FVzK0XH7Dp5dHwnUPys2L4?=
 =?us-ascii?Q?/5rrJlXz+G8pccavEAc/4BjGozFBuyPXOcvxV21uZQw2OENPWxCI7eJzDBbT?=
 =?us-ascii?Q?6uJn131jt7P7rVqq0Tqpnk2JbBjqr+/RZs8XOsoWyOIr1qBAvkMXBTR8XrCL?=
 =?us-ascii?Q?I+dJZGI1ax79N+U+3pIjkDBjMzKpmWSU7wGYAYDUi8DNxwxzuSRZ9xGY07/6?=
 =?us-ascii?Q?X8Qj1HQD/4SiOAdJBxM7/Y43CR6X8rffsUknzQlQ65VF/UdTJ7qQHMrBZQqr?=
 =?us-ascii?Q?3iaqigRA9RVSFMSW/RZ+5PbcjoCei3H+ZPhmN5BJaa0N+xlZ9Gqe5DM3zfTi?=
 =?us-ascii?Q?7p2G7g7P2ONtdfbmSkFl8Ye40RvhR+RKlTC8W6JoxSZ3lsiWVTmg9kRueUCL?=
 =?us-ascii?Q?Vlo/Uq+QrfBtTpXcA8BZSh9tW5giWxx71plyIivlv80nLJ+DVBHEnxLOEqBz?=
 =?us-ascii?Q?bo/890lWI7q1lnZidpwqOvOo2/WIEd/mJv3FwkdoeY6yRdnW6v1o5hZVZfPs?=
 =?us-ascii?Q?7U2qYK5YTGv4nXZ/wZLIS3y20nB1r4z89/o/yqMFqeuS52D7AWI/mHNV9zcj?=
 =?us-ascii?Q?SVx1hT2CQ+SJ2xM30K0B2i2FXb3dKBbIwkYjxiN3tYFuTOUOsp+OrZUiagiY?=
 =?us-ascii?Q?hCG/fJZErV3NwrSMzGu2Az9JTjmWClXia4tB8gBXMHwX3kdJk6WOwSn3696q?=
 =?us-ascii?Q?OLtcRidGWp5HfywKkbMPwSbk8BUDrf7zFjZclsiLo+Nf2H/OCGHVyc8wRVi5?=
 =?us-ascii?Q?dWxuoCb3Q+rStg4v5R5ubcS66zF0qDox6B/sZld6eVOBP81XDQ20uouMjOWy?=
 =?us-ascii?Q?SsBJmVEP81AE5sLrOvj3luYasUVZ9ddt4u4Xf2DruI8uE8MXTx8TVVcwESUy?=
 =?us-ascii?Q?0VubfvxNZelGRmw832Ngcpvy4B4aTBBdKIRk56qtXMTuHCkLwCkwt1XEmhaG?=
 =?us-ascii?Q?dHCGIo6gCFRRvtxNw7Zq4ZxRnoyjHkcsolINI9L3Oi1Y1T8Je4sdhte4c7KM?=
 =?us-ascii?Q?NAiGaGzJ4+rBosI74DEqGAccJvDP3EtGZfepAcbcGiTeireYLPzcZUgoqKrU?=
 =?us-ascii?Q?8qN1RPCdso32NE1Om4U0MSQzHh4X0ygMIsogCg9SS38EQGdvhHcbPUUxFtCB?=
 =?us-ascii?Q?hqc+u35trv+bY8hbkkdO6F04mxNc7g0VzEX2VrOxAlSRE0tbj2LYx2tHAKTk?=
 =?us-ascii?Q?g+Lxx4f1SKHTniYaAyfeaJhAzg4YXDJJdeGchTfWQOzqpr0aHtpNUqBBvNcv?=
 =?us-ascii?Q?IFLTSac44Gvg9LdVBOKBXzGaFL3soK6CqO1Ij3hmjLAdSMceVxQNzLWGk0a2?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b156313-a0de-4339-e78e-08ddd5aa1ecf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 12:01:19.7985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hm1Ng8vJfegJt04IHUCW4Jfl2hsqhwzMWS3f4x0+j5rMdD6EVacI0ljlxuGPx+MyxEtLExQeutXOQFA+dJL2NAYLr6ZgxWYS+UpETq25uYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5889
X-OriginatorOrg: intel.com

On Wed, Aug 06, 2025 at 10:42:58PM +0200, Maciej Fijalkowski wrote:
> On Wed, Aug 06, 2025 at 09:43:53AM -0700, Stanislav Fomichev wrote:
> > On 08/06, Maciej Fijalkowski wrote:
> > > Eryk reported an issue that I have put under Closes: tag, related to
> > > umem addrs being prematurely produced onto pool's completion queue.
> > > Let us make the skb's destructor responsible for producing all addrs
> > > that given skb used.
> > > 
> > > Introduce struct xsk_addrs which will carry descriptor count with array
> > > of addresses taken from processed descriptors that will be carried via
> > > skb_shared_info::destructor_arg. This way we can refer to it within
> > > xsk_destruct_skb(). In order to mitigate the overhead that will be
> > > coming from memory allocations, let us introduce kmem_cache of xsk_addrs
> > > onto xdp_sock. Utilize the existing struct hole in xdp_sock for that.
> > > 
> > > Commit from fixes tag introduced the buggy behavior, it was not broken
> > > from day 1, but rather when xsk multi-buffer got introduced.
> > > 
> > > Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
> > > Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> > > Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
> > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > ---
> > > v1:
> > > https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@intel.com/
> > > v2:
> > > https://lore.kernel.org/bpf/20250705135512.1963216-1-maciej.fijalkowski@intel.com/
> > > 
> > > v1->v2:
> > > * store addrs in array carried via destructor_arg instead having them
> > >   stored in skb headroom; cleaner and less hacky approach;
> > > v2->v3:
> > > * use kmem_cache for xsk_addrs allocation (Stan/Olek)
> > > * set err when xsk_addrs allocation fails (Dan)
> > > * change xsk_addrs layout to avoid holes
> > > * free xsk_addrs on error path
> > > * rebase
> > > ---
> > >  include/net/xdp_sock.h |  1 +
> > >  net/xdp/xsk.c          | 94 ++++++++++++++++++++++++++++++++++--------
> > >  net/xdp/xsk_queue.h    | 12 ++++++
> > >  3 files changed, 89 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > index ce587a225661..5ba9ad4c110f 100644
> > > --- a/include/net/xdp_sock.h
> > > +++ b/include/net/xdp_sock.h
> > > @@ -61,6 +61,7 @@ struct xdp_sock {
> > >  		XSK_BOUND,
> > >  		XSK_UNBOUND,
> > >  	} state;
> > > +	struct kmem_cache *xsk_addrs_cache;
> > >  
> > >  	struct xsk_queue *tx ____cacheline_aligned_in_smp;
> > >  	struct list_head tx_list;
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 9c3acecc14b1..d77cde0131be 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -36,6 +36,11 @@
> > >  #define TX_BATCH_SIZE 32
> > >  #define MAX_PER_SOCKET_BUDGET 32
> > >  
> > > +struct xsk_addrs {
> > > +	u64 addrs[MAX_SKB_FRAGS + 1];
> > > +	u32 num_descs;
> > > +};
> > > +
> > >  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
> > >  {
> > >  	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> > > @@ -532,25 +537,39 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
> > >  	return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
> > >  }
> > >  
> > > -static int xsk_cq_reserve_addr_locked(struct xsk_buff_pool *pool, u64 addr)
> > > +static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
> > >  {
> > >  	unsigned long flags;
> > >  	int ret;
> > >  
> > >  	spin_lock_irqsave(&pool->cq_lock, flags);
> > > -	ret = xskq_prod_reserve_addr(pool->cq, addr);
> > > +	ret = xskq_prod_reserve(pool->cq);
> > >  	spin_unlock_irqrestore(&pool->cq_lock, flags);
> > >  
> > >  	return ret;
> > >  }
> > >  
> > > -static void xsk_cq_submit_locked(struct xsk_buff_pool *pool, u32 n)
> > > +static void xsk_cq_submit_addr_locked(struct xdp_sock *xs,
> > > +				      struct sk_buff *skb)
> > >  {
> > > +	struct xsk_buff_pool *pool = xs->pool;
> > > +	struct xsk_addrs *xsk_addrs;
> > >  	unsigned long flags;
> > > +	u32 num_desc, i;
> > > +	u32 idx;
> > > +
> > > +	xsk_addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > > +	num_desc = xsk_addrs->num_descs;
> > >  
> > >  	spin_lock_irqsave(&pool->cq_lock, flags);
> > > -	xskq_prod_submit_n(pool->cq, n);
> > > +	idx = xskq_get_prod(pool->cq);
> > > +
> > > +	for (i = 0; i < num_desc; i++, idx++)
> > > +		xskq_prod_write_addr(pool->cq, idx, xsk_addrs->addrs[i]);
> > 
> > optional nit: maybe do xskq_prod_write_addr(, idx+i, ) instead of 'idx++'
> > in the loop? I got a bit confused here until I spotted that idx++..
> > But up to you, feel free to ignore, maybe it's just me.

ugh i missed these comments. sure i can do that.

> > 
> > > +	xskq_prod_submit_n(pool->cq, num_desc);
> > > +
> > >  	spin_unlock_irqrestore(&pool->cq_lock, flags);
> > > +	kmem_cache_free(xs->xsk_addrs_cache, xsk_addrs);
> > >  }
> > >  
> > >  static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
> > > @@ -562,35 +581,45 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
> > >  	spin_unlock_irqrestore(&pool->cq_lock, flags);
> > >  }
> > >  
> > > -static u32 xsk_get_num_desc(struct sk_buff *skb)
> > > -{
> > > -	return skb ? (long)skb_shinfo(skb)->destructor_arg : 0;
> > > -}
> > > -
> > >  static void xsk_destruct_skb(struct sk_buff *skb)
> > >  {
> > >  	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
> > >  
> > 
> > [..]
> > 
> > > -	if (compl->tx_timestamp) {
> > > +	if (compl->tx_timestamp)
> > >  		/* sw completion timestamp, not a real one */
> > >  		*compl->tx_timestamp = ktime_get_tai_fast_ns();
> > > -	}
> > 
> > Seems to be unrelated, can probably drop if you happen to respin?

yes, i'll pull out this sophisticated change to separate commit:P

> > 
> > > -	xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb));
> > > +	xsk_cq_submit_addr_locked(xdp_sk(skb->sk), skb);
> > >  	sock_wfree(skb);
> > >  }
> > >  
> > > -static void xsk_set_destructor_arg(struct sk_buff *skb)
> > > +static u32 xsk_get_num_desc(struct sk_buff *skb)
> > > +{
> > > +	struct xsk_addrs *addrs;
> > > +
> > > +	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > > +	return addrs->num_descs;
> > > +}
> > > +
> > > +static void xsk_set_destructor_arg(struct sk_buff *skb, struct xsk_addrs *addrs)
> > >  {
> > > -	long num = xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
> > > +	skb_shinfo(skb)->destructor_arg = (void *)addrs;
> > > +}
> > > +
> > > +static void xsk_inc_skb_descs(struct sk_buff *skb)
> > > +{
> > > +	struct xsk_addrs *addrs;
> > >  
> > > -	skb_shinfo(skb)->destructor_arg = (void *)num;
> > > +	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > > +	addrs->num_descs++;
> > >  }
> > >  
> > >  static void xsk_consume_skb(struct sk_buff *skb)
> > >  {
> > >  	struct xdp_sock *xs = xdp_sk(skb->sk);
> > >  
> > > +	kmem_cache_free(xs->xsk_addrs_cache,
> > > +			(struct xsk_addrs *)skb_shinfo(skb)->destructor_arg);
> > >  	skb->destructor = sock_wfree;
> > >  	xsk_cq_cancel_locked(xs->pool, xsk_get_num_desc(skb));
> > >  	/* Free skb without triggering the perf drop trace */
> > > @@ -609,6 +638,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> > >  {
> > >  	struct xsk_buff_pool *pool = xs->pool;
> > >  	u32 hr, len, ts, offset, copy, copied;
> > > +	struct xsk_addrs *addrs = NULL;
> > >  	struct sk_buff *skb = xs->skb;
> > >  	struct page *page;
> > >  	void *buffer;
> > > @@ -623,6 +653,12 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> > >  			return ERR_PTR(err);
> > >  
> > >  		skb_reserve(skb, hr);
> > > +
> > > +		addrs = kmem_cache_zalloc(xs->xsk_addrs_cache, GFP_KERNEL);
> > > +		if (!addrs)
> > > +			return ERR_PTR(-ENOMEM);
> > > +
> > > +		xsk_set_destructor_arg(skb, addrs);
> > >  	}
> > >  
> > >  	addr = desc->addr;
> > > @@ -662,6 +698,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > >  {
> > >  	struct xsk_tx_metadata *meta = NULL;
> > >  	struct net_device *dev = xs->dev;
> > > +	struct xsk_addrs *addrs = NULL;
> > >  	struct sk_buff *skb = xs->skb;
> > >  	bool first_frag = false;
> > >  	int err;
> > > @@ -694,6 +731,15 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > >  			err = skb_store_bits(skb, 0, buffer, len);
> > >  			if (unlikely(err))
> > >  				goto free_err;
> > > +
> > > +			addrs = kmem_cache_zalloc(xs->xsk_addrs_cache, GFP_KERNEL);
> > > +			if (!addrs) {
> > > +				err = -ENOMEM;
> > > +				goto free_err;
> > > +			}
> > > +
> > > +			xsk_set_destructor_arg(skb, addrs);
> > > +
> > >  		} else {
> > >  			int nr_frags = skb_shinfo(skb)->nr_frags;
> > >  			struct page *page;
> > > @@ -759,7 +805,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > >  	skb->mark = READ_ONCE(xs->sk.sk_mark);
> > >  	skb->destructor = xsk_destruct_skb;
> > >  	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
> > > -	xsk_set_destructor_arg(skb);
> > > +
> > > +	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > > +	addrs->addrs[addrs->num_descs++] = desc->addr;
> > >  
> > >  	return skb;
> > >  
> > > @@ -769,7 +817,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > >  
> > >  	if (err == -EOVERFLOW) {
> > >  		/* Drop the packet */
> > > -		xsk_set_destructor_arg(xs->skb);
> > > +		xsk_inc_skb_descs(xs->skb);
> > >  		xsk_drop_skb(xs->skb);
> > >  		xskq_cons_release(xs->tx);
> > >  	} else {
> > > @@ -812,7 +860,7 @@ static int __xsk_generic_xmit(struct sock *sk)
> > >  		 * if there is space in it. This avoids having to implement
> > >  		 * any buffering in the Tx path.
> > >  		 */
> > > -		err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
> > > +		err = xsk_cq_reserve_locked(xs->pool);
> > >  		if (err) {
> > >  			err = -EAGAIN;
> > >  			goto out;
> > > @@ -1122,6 +1170,7 @@ static int xsk_release(struct socket *sock)
> > >  	xskq_destroy(xs->tx);
> > >  	xskq_destroy(xs->fq_tmp);
> > >  	xskq_destroy(xs->cq_tmp);
> > > +	kmem_cache_destroy(xs->xsk_addrs_cache);
> > >  
> > >  	sock_orphan(sk);
> > >  	sock->sk = NULL;
> > > @@ -1765,6 +1814,15 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
> > >  
> > >  	sock_prot_inuse_add(net, &xsk_proto, 1);
> > >  
> > 
> > [..]
> > 
> > > +	xs->xsk_addrs_cache = kmem_cache_create("xsk_generic_xmit_cache",
> > > +						sizeof(struct xsk_addrs), 0,
> > > +						SLAB_HWCACHE_ALIGN, NULL);
> > > +
> > > +	if (!xs->xsk_addrs_cache) {
> > > +		sk_free(sk);
> > > +		return -ENOMEM;
> > > +	}
> > 
> > Should we move this up to happen before sk_add_node_rcu? Otherwise we
> > also have to do sk_del_node_init_rcu on !xs->xsk_addrs_cache here?
> > 
> > Btw, alternatively, why not make this happen at bind time when we know
> > whether the socket is gonna be copy or zc? And do it only for the copy
> > mode?
> 
> thanks for quick review Stan. makes sense to do it for copy mode only.
> i'll send next revision tomorrow.

FWIW syzbot reported an issue that "xsk_generic_xmit_cache" exists, so
probably we should include queue id within name so that each socket gets
its own cache with unique name.

> 
> Maciej

