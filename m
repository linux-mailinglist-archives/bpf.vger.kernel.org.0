Return-Path: <bpf+bounces-69238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBB4B921E5
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 18:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062B33AA636
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 16:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCC9310647;
	Mon, 22 Sep 2025 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mqzWSZ/1"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64963285CA2;
	Mon, 22 Sep 2025 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557037; cv=fail; b=IZ9smsFcm5qHEyIbzcsydRwgqjD4uHBafVD+kL2uv6RxtzydfCq7ajAbo1u8Ejx0+bJchdW64+7vhuOw+nDXaFCtoHS/fkgKUYnJTfnNplEVH+aS8Lt6wajS8o3ML654niI3SWbvFkXCJbfrK4QYr6MAST8Jw/5IRlJSG8NzCJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557037; c=relaxed/simple;
	bh=yhmngAfrXmLXod37LQFRSGsMSxgFJbUWX0K/2EtNetk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RZbsJKdcU0zihiAqMvsImg6hlR/6vmW/RFzHqZEiGIIrGO2CYtX0ADwwhuJu/WAmF320zHuQOusXJKDjHCOflx0r4GBFPv6BCZqoW/tAAk7PFLj+fQEUEQ033mG05bWTJ5kHQB/Jn5gapCy20Tqy4Ih9HMKAm1zoDxj74t6wmpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mqzWSZ/1; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758557036; x=1790093036;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yhmngAfrXmLXod37LQFRSGsMSxgFJbUWX0K/2EtNetk=;
  b=mqzWSZ/1x3GWzbSV23QLW7YAe4BWyOXpY8DyyYVdSMXRSvdBEYY7+xYT
   IVvE/0R5and2lNvr1PqREwqqoZsvg4RDLCt2po1aKB3s71Won+eipW+xk
   2BpKgzdDLd4faQGD0Q8QstrGh7bImuN6xOs8SjHtJRh0LL5YubjPJMAVI
   iPqczkVdSKb6fSIOUxoxG7BMiss6U7dYOjUy0qdr29eUrN4sSdUzAZ+Bd
   HsfW/E0DIPcdQTNtyb5nmDRWTHTPvvNViHwPmQyjJ2ro9hiqkh2bJchZb
   +gwrKM4q5oRFd3G9mGlVOr6SIrVw+BTh7zZW470+sY2xW53lcltdOlnyB
   A==;
X-CSE-ConnectionGUID: hjPavfbJTe2kHjrTV4g+8A==
X-CSE-MsgGUID: 53+3rIAwQYSNB04V5AxXMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="59862914"
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="59862914"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 09:03:55 -0700
X-CSE-ConnectionGUID: qc5NR4oRRq+NmhgA6EQjbg==
X-CSE-MsgGUID: xnuAZzIITRivYH05mP/NIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="213653586"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 09:03:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 09:03:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 22 Sep 2025 09:03:54 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 09:03:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGGn1G/2l3dVwrz2sZzzFuowbiB7UjezTAFkUokTMospDHuXZh5nV4P512wOyQZfCkrCO68RK3fxAzS7QhAHr/la9gJZifh4+BAv9uwCjHueZFhL3Bfnntc4WggX98ZP92NW4JVjSFUM03TesbyzA1BwCmrvYfr1o8bYxD5Iwyw48Ni2JKquy1lyM3v15xaveoqsasby+DYLKrXlQ2RsYGhYQOQTvpWsQOAIJtI/CNOOeP/cfAGBhwEoEm7LPOhBZATuOuj9GVF+eYlPScMzydybiW69rXd7+Jdfd8CAz1/cqaAALPCR+op2JxkheyeHdpgOLArs/rnpNe2hdbn1FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqWhYWapKgeuoIx/D86goUfWq4MLURyjVDYvty5EJMI=;
 b=v6iCUsw9d7U0d/WlhbGfnYUSHq4Hplvwic5PX8yDTF0oY0rPCImVwbk1We86Uyx6E+iTW6Cvew0zi3KnDu8v+uONiwCoPPl4QF0Wu7AMKmOyk/YMdBrHF+E4522g9mbIYTrMmBPJEPNXth5kRJB0twFfZIh/0QX77ULiO6yv7LDBDbUdEUEFepfwkKba5RUUtYe4IuWRTeSjmSft48cokP/bcLP6XhGbHDNtjCUYsisJn8eNUrgrk1reZSJH6mUvYlKPnP2ae+KKY7xKVhHM5+VRijyDmSU6a5L2utvfx02GMvzioHjpo1XmalBZoai9RbCvfDMWUx8L0gHJ1pW9jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH3PPF10FBEE80C.namprd11.prod.outlook.com (2603:10b6:518:1::d09) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Mon, 22 Sep
 2025 16:03:52 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 16:03:52 +0000
Date: Mon, 22 Sep 2025 18:03:44 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Daniel Borkmann <daniel@iogearbox.net>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <kuba@kernel.org>,
	<davem@davemloft.net>, <razor@blackwall.org>, <pabeni@redhat.com>,
	<willemb@google.com>, <sdf@fomichev.me>, <john.fastabend@gmail.com>,
	<martin.lau@kernel.org>, <jordan@jrife.io>, <magnus.karlsson@intel.com>,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 11/20] xsk: Add small helper xp_pool_bindable
Message-ID: <aNFzYE5w8XGEz5Wr@boxer>
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-12-daniel@iogearbox.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250919213153.103606-12-daniel@iogearbox.net>
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH3PPF10FBEE80C:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d23c869-59b7-42a8-ae19-08ddf9f19ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AKr1RrzaXOyrdDA9j33CuIiIrLw2f7lrDqOSCUAJi2zj3eRYBdVezY7Z0NJL?=
 =?us-ascii?Q?DLVxRzeYtahD9XD36mAHYmd20jGoeseyhHisusmxk/md+T/WXj1fIVC/kkvE?=
 =?us-ascii?Q?jlZJVUJwLkxrCBIXkut8L8ADpShrLl3Q+1JiiEnAKggc62cSQiGb6tgzaCwo?=
 =?us-ascii?Q?tjRO0DOZFBvm/cyAWdBbX34m2UstfRHzr4xgIQ6cies9plIlrs0ejEt9Qcla?=
 =?us-ascii?Q?Y74cy7icBPKEQpk5BDluF8WNhSJb35wzF/8b444RbOJNcLdKuhyGDRYjk/z5?=
 =?us-ascii?Q?8rhtOw6VH5ntVokcYSrfCW8zW84M/PzfhFshbeu289jBaxt1bgX+nMjUlVIc?=
 =?us-ascii?Q?uEwhScPvNHrBf5tsEjS1ZeJA+N3qfn0Y7w2ofRj6mBtoF+DdV7tY2sVxErmF?=
 =?us-ascii?Q?qjXSuqFYUzsYWt2ScRmVJmnnKnlbBjc59t97KhyoWEbOfslSQM4pW4Z7ehC1?=
 =?us-ascii?Q?D506NpwGDX2XXQKt44JKBeHJV5HZW9osVz8e75mGpEYLM1VTRVnu34lvfFPA?=
 =?us-ascii?Q?E27eI8nN2cD/BuDadnH1027JQhArs83Ud09dcmRdaVAW1DI/t2VL11z/EHmi?=
 =?us-ascii?Q?S/NHwzEIEJNdaovfQJwVb7tSEO/4pAhIZPqkprqH7gulJ0vm5yBnhHE7Bpel?=
 =?us-ascii?Q?rvqDCbrJx/Ew7j1hcBh1ZYuxFoXBCPz8fSPK3qBnMZBL79HotDpS7PsvwbiP?=
 =?us-ascii?Q?gIX0mamWG0wJn3HtXfktEAhyhAxjknIBwGbY0qlYEhR3Ru8ijRHplAY16wyi?=
 =?us-ascii?Q?CjK2Z8HcHNcH5IrHV1ft+T3RyyEwtDBG3TKvdkufTCCDTlid3IjhXnMKBsq2?=
 =?us-ascii?Q?dqCgCYUkKK4Vl6bPzmGNur58wcyZJDuuh4l1oa+ZKSjVXFO7HX19KVO7fsM3?=
 =?us-ascii?Q?h2juv8ji6dzykGk2s7hMyEe9jlloXhX3rsmz51ibI/8dAKDFlT0Mmthme0Y3?=
 =?us-ascii?Q?51v9jXBoA58i2BhFp19lXOnVQJOMWm9Ie97xbkP7Nz2HeBnRuXdJNg1zjUPh?=
 =?us-ascii?Q?GmJJ71T0GrSh+o9t9SnXzBR66Zrio/yP4DMw8aFEKHb6jkK5T1OkrNlAiOqv?=
 =?us-ascii?Q?TmNewwdyQxUOAbdPzWDIcReBML4W/SpzWwANIDCIRtgzv+AqtHImCSduWd+l?=
 =?us-ascii?Q?ZeqyzshCgRv/Asfdsr24cKL4ZLzB1pacbBxG43cWi+J2rZ5AjuCC5+c5JB4y?=
 =?us-ascii?Q?OlXbwsoxlBeP7Is4UdNlPVt985lB2vPmNKWGgnHsO0CjCJxeEJGhw7r6uWfj?=
 =?us-ascii?Q?mHAnCAdCtqbPk7JShhEjPGmvgGjqzd+GRYkZme/a18FYBB+eoPMKiHAkyI7h?=
 =?us-ascii?Q?SlCnE7000E376dNaEP/BKSwbRTQpaYfo2qdF0e7jcc+wpf2j4qRNC6ouNB+l?=
 =?us-ascii?Q?KsaHSjN5rTx/MC8ZqRRFJYzZGIDSItA7afW+lyDQbLVAJV39JEvX8oFhqCTh?=
 =?us-ascii?Q?ycpXX8txPE0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?awBK6HyOUO+2XU2PCrkP4IDidCP3drgM4RwLio+yDkxP34q6kd9q7m0Rabh0?=
 =?us-ascii?Q?JgCNdnLXVL9nXD31j3e/yWSrHHDJYBT7Yf4tnuwYlI0G7qjmhBUbf7h6hcEd?=
 =?us-ascii?Q?D5S4S1z1+pjRt30R722wBtpZxIYNjvnAWM55BxqJXDSFd+bGVL+uA7m/8Phd?=
 =?us-ascii?Q?jYIKHqzgrlcKY4BLuHKaosbmgxjr5IZt+0fzGAt04UpvBx7ec3ma+AFSyGm2?=
 =?us-ascii?Q?yTBVr60oXKVLq9tiDPX8rh4I7sVKvbFnj0K8W7/3Jvu21MAvllqOHaZ2jfjH?=
 =?us-ascii?Q?ALwDXIIrfI/gWWnr7Ac2EKZxSAl8gF95x4KG1Xikz2YU5aF9Km0xRNbSZXOd?=
 =?us-ascii?Q?YLTn6y9/B4BffIS/O2ixpfPGxwQMnyjaKxWzGuvnQ1eABPTNeimOOn84zZWG?=
 =?us-ascii?Q?2Xcn3eOu7S8y4q5G5UKIcJuPnrP0e321Em7AuUJO7o54JRNPXtvWOL/WKo+n?=
 =?us-ascii?Q?4t8qHiySJYBwTQhKmk+V9SJQTAIJB+TnuK6b1x8NokgCXphXhedBh2p7/+jm?=
 =?us-ascii?Q?t7FkYw6f/mvR7j9Qr5CfJZ62jkU/cxwXbEKwiMf9+4A9tpqPtw34wus7reTz?=
 =?us-ascii?Q?1DHaO4nLPzILz+YwFASfcEYxQCpkU6mOQDHwdc0JZK8SFjE5CMEQJB0pVAT2?=
 =?us-ascii?Q?m3uq7asCcilL0nGJUGV24ZDqEh8ST7bYllxsoHDIbENSlBneG1aoaexihNIm?=
 =?us-ascii?Q?T1/IMteOvDVGiZw8dCk6qA374ljJ6Q65N2voJomwfkzyTQYV7cyi9g4QpE7I?=
 =?us-ascii?Q?GnHNYNP4MorLZeEcI3ss7KKyRdtOIpDGPgEG+csoon+QsBAR0+F8vARYQvB5?=
 =?us-ascii?Q?WL3mYKOSRxS90YZSAM3T+A/lNWhAbN1KmHcdSy1n7OzIDrkNQ4/ontwUfrh5?=
 =?us-ascii?Q?CItvaVNinHO9vF8VS8o30uLtV0syuNdeBBwkRWo2fefuTWx9QBVFLymHu6J+?=
 =?us-ascii?Q?9CbWFZIYmobK5WifR7JHbK2qZF+XbGohxeLggy3WNPgdBuUhTbXr73Ov/cfD?=
 =?us-ascii?Q?N20q9fk7dWC82rf9fuOP/U/DKhS03EMkAmGhO8X2sinAQ8qf1XE43nYO2nbw?=
 =?us-ascii?Q?Qmv3NwbEdDIkTQPyj+A8INoF+jyR8IhPZ0skbAVRUiEi0yBy2xsDUSbjY8Nm?=
 =?us-ascii?Q?4/kMTR/X0IgwWQrJo82vLWcKsuiAcoQ9WrAILJzJN9a8IJI75A658NnmZZUs?=
 =?us-ascii?Q?2NJ1F5QpN/AWlsF4ZRt80CvVEGHuSRF7QbxRmjo6YRxwmFtGYF5tNm/Km4rU?=
 =?us-ascii?Q?BnlP5Tt59iRykHAMSuL09Ap/GbcBNeJiWbN9WdZkucqA3RKyIOvr1uaaQLAt?=
 =?us-ascii?Q?bVydcErfdFz12oIbQIsn416HNYMyvsPDLpD4nI0iZp9RlIy3+ybF+3VQLWH1?=
 =?us-ascii?Q?KaLld+VEM8Bjx83UrvmnBUiEo2kiW5xSVdhzwClqQwEGT9SchcjoblhCTQ+l?=
 =?us-ascii?Q?6xpsjH2kR9OoEII0PpxxdgUqifmvpfDMGWiRVE6JEWPK0h39kD6fYnBmybKa?=
 =?us-ascii?Q?nNi8Scpd00SnoT8oqO6DQq/Sk1nnmvt1nppokWo30VFKcEhFGBy6BL90T0T7?=
 =?us-ascii?Q?yFO4/HvVXnsbQ0vcbRPzCEbGxenij9/Udnd9RrsVMnBaKT0p71X9WqMhPOlz?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d23c869-59b7-42a8-ae19-08ddf9f19ffb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 16:03:52.4614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMEuSrut6OzhI0nY8wFsJGT9iqJvEZt90IEuuDr4U0M66mWSeDqGthdLHlYlXq6dCVtfRwFEQfvtvh2Mbsbr2dOAIvhTux5dMk1fjZU1A8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF10FBEE80C
X-OriginatorOrg: intel.com

On Fri, Sep 19, 2025 at 11:31:44PM +0200, Daniel Borkmann wrote:
> Add another small helper called xp_pool_bindable and move the current
> dev_get_min_mp_channel_count test into this helper. Pass in the pool
> object, such that we derive the netdev from the prior registered pool.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  net/xdp/xsk_buff_pool.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 375696f895d4..d2109d683fe5 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -54,6 +54,11 @@ int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs)
>  	return 0;
>  }
>  
> +static bool xp_pool_bindable(struct xsk_buff_pool *pool)
> +{
> +	return dev_get_min_mp_channel_count(pool->netdev) == 0;
> +}

Is this really a must have in this patchset? You don't seem to make use of
it anywhere.

> +
>  struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
>  						struct xdp_umem *umem)
>  {
> @@ -199,7 +204,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  		err = -EOPNOTSUPP;
>  		goto err_unreg_pool;
>  	}
> -	if (dev_get_min_mp_channel_count(netdev)) {
> +	if (!xp_pool_bindable(pool)) {
>  		err = -EBUSY;
>  		goto err_unreg_pool;
>  	}
> -- 
> 2.43.0
> 

