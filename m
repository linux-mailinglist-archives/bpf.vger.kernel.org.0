Return-Path: <bpf+bounces-42299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC7B9A222A
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 14:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D50A28357B
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 12:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A237D1DD534;
	Thu, 17 Oct 2024 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjbZd9XG"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB581DBB1D;
	Thu, 17 Oct 2024 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729168029; cv=fail; b=gTKxJ30jSkVBr5r1sfTvGpyl++uhwEwGErqIepJMeaAcLjgz0KqjKw5T5T1BkcrPzCZgGJuESQYTj/5DNvKZhBsXrUOZdtuC5Ogel/N5wMQdtCZrsJ+KnWtf039tkJBlM54jOgMwEiPNaB7yX21HhR3l+48HQMoU3k7PCBls9a0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729168029; c=relaxed/simple;
	bh=NeGsRpVwVV1Hdjpegzlqp0Pl5jrf00Ctw9otsYTuWPo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m9wO3VKQHLZFSiiv1JpYy2wDfNYSohTuBV9AtsSZRij5B6JVdOXADYPKsIHI0qIGZ1YpqDeIaB5RPojKdhjsK8kHPuopTCaGAV+GIqp7RLlRy9U3HeeXeD+MxlP4e4LMxfCDvJ5kQwOfYFb3TllMyH7T322enLFMz51V/+nY37M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjbZd9XG; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729168026; x=1760704026;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NeGsRpVwVV1Hdjpegzlqp0Pl5jrf00Ctw9otsYTuWPo=;
  b=SjbZd9XGgt8HcuYDuKYftiXL+KzLUnqaZHjQKkypYXzLP68rOrbuOQR0
   Nlkvl3BWqnn7gLpXRDS1Cxe0oBMGUiqmsnwcxGKTKRUbqVpMkT/C1uT0W
   m8SRgDXHAsERTPilejLDxvCwgkf65df5+cqKclIlEq8ztTYIs4TR+POxE
   ThXUnkfC6A9JW5ef1ZGtug3BeA1WdGo7nLei85C2lgO918+VP75xMbXzp
   sdQkacU1nptgzmpynSQFtJPWRQbmM9RZHFTidTTXPkse0p0x0PBXhenD+
   jyY3E8FCQXm23zBD/5Acl8+bKHsCKolewRmzknYkMJOI3p3e502qcbygh
   A==;
X-CSE-ConnectionGUID: FKxawDP1TFeo7lEWmfMQ0g==
X-CSE-MsgGUID: fv37BokKRZCO3/eYtTJn8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28440693"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28440693"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 05:27:05 -0700
X-CSE-ConnectionGUID: t+J0Dh7QTySm5ArXdXKuRw==
X-CSE-MsgGUID: cmtI0lpOQje6C6EprVkAfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="115967563"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 05:27:05 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 05:27:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 05:27:04 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 05:27:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6dyStZCFbGCyZJ/Rbbk8LG9fkcMASG/L1Us/3GhF1JTNywput1sP3c8JkzIWyJrLkIBrhXpYahtg8GLLuArPY6zCzTl5ED8N6fOyFB9pBTuKsraW4QGpCKF4TE5PxUwrAwjmzCCKNbEeNr83H34BJg6T/VariMjmt2IqSVvChJpdV6CTEMUmGvXxIMjCA65wWow+kHugL1vrdnymVJXtKV8sn4kyFC1QtyvxQs0CFPHE2/1zU7AvYKks3btj83OexEDO3XOtlapVzCgu6+zBR46CjX1VZxrc3Z17zA9UfZqlSvTcNYkj21N9gVQ1acQ3dIZ9QEOK6AVz2GIFb26xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z65w4WhLw6xeihnSde8eqnmhj+TFB7jCbWhilgWO5Fo=;
 b=FoC3/fqRsLqBdYU4OO6yusXC17xddnkrvfS9Zw6oTjoyclv8vK9HSbbcXdVgjJLZiLTM0aSf27HLGSGgDLWrt3iUtwVQChyH7u6ecfzmauMPLOZOReiAb8pYjmkgJAwMRjpyiTu4NfWwJhjRPdVVcp87G/cDmQO7oqQxO4fge2oG6m2HbGNUxL53kLs+2k3e7FziEFB7RySrsTOa5NGSPf4tN/EASF8VKsh4xqTdUjB8/CQ/lzneveojNsqJ7xADC2HWuQNrOOI0OYr8SFowj03Po37HH8CxVISPAO3MekbbVsVrokK6JdQ3sWX0rlgG1kcSpVxSK/iCZCK7u4w8fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ2PR11MB7548.namprd11.prod.outlook.com (2603:10b6:a03:4cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 12:27:00 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 12:27:00 +0000
Date: Thu, 17 Oct 2024 14:26:48 +0200
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
Subject: Re: [PATCH net-next v2 11/18] xdp: add generic xdp_buff_add_frag()
Message-ID: <ZxECiKa4a4LSq7zq@boxer>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
 <20241015145350.4077765-12-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241015145350.4077765-12-aleksander.lobakin@intel.com>
X-ClientProxiedBy: WA1P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::25) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ2PR11MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: a16688b3-6e32-465d-94b5-08dceea6ffb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1ML9XAlV8VDdf4sQFECxdpGfAYlppL9kFI+Vj72y7QoMYfyZqtxjoRiy86nG?=
 =?us-ascii?Q?KN7TxhSISTitaLcuuD6rYh2bJyK12zWtB3WsDg95ysqAZ+UPJsgymK5YmPfN?=
 =?us-ascii?Q?IjOivqRK2NvB8lKlLmQbrUPPEnTJHdZzLE53cHIrKTpCFcoTS21pQGRg3W1s?=
 =?us-ascii?Q?cyilNM3T9oKg3kSJRtBoiEKH48VuAQbvQGDFLWlek620sL7wdu13oBTlSPD8?=
 =?us-ascii?Q?mUSELgVsv0yMHSqM7uV7zA2nbkTB1ugkP1uqZ0cNCOpRv7QYW6GhIjvX0P0y?=
 =?us-ascii?Q?jBwnCXF5HoRRODSXv4A5ficVxxk9K0IPMh/ehfJ30+x43PNbWbLDGGr+7rX+?=
 =?us-ascii?Q?hE1pNIarzTMUI8XY3s4YKRYePb+jbQLxYJNWSekP4E6JylA/c1T4vlLk7Zvt?=
 =?us-ascii?Q?p7zNP/cz9+rndzZjA4MdQIelBKMZwDMQGcOWYPHXwpOhkVYeklBqTvbxI5Wz?=
 =?us-ascii?Q?QuMFFE+P2ESjwr4+k3Ou7xtcJ4bG9eqAD04SkDnqIIE2BiB4U186T3DuQ3Oh?=
 =?us-ascii?Q?joH20r8J3khxSuFrGKilW4xcOwJ+bS2EsbGplSfEC00cpxZZyiqnk/NR3RER?=
 =?us-ascii?Q?ycoJxcHFGq241nSPupIQbYK3DNLvPELnXleNtHKWFuORT6WrvXmmYpDsphXf?=
 =?us-ascii?Q?opFKkWCECaleOsMJRArBd/TcRtmnx0tlEKxOToA3R1cgTQZ5yXVo8CUUSwEQ?=
 =?us-ascii?Q?rwIBY8RH46QIrtcz75axM+NR8pcRm0iVhQ3d37zlV0uWydlzZdTbOAX3Ynfn?=
 =?us-ascii?Q?8an99kz64hhbnWSPS2YvSQzwgBQbD6Sin6O+E6kPMl8EitzWRdH6/x3+4d1d?=
 =?us-ascii?Q?mLtGjN9JWi7IhnIRw6xp3oyDm0rVdAc413NSLsaUVi+odWMq7qZbg4/MdQBj?=
 =?us-ascii?Q?0a1QSOnpFzJM0zvLxLzAfx/4E6WLN/Q921WqUjJn6DjiWEMDMdCxc8QLewI5?=
 =?us-ascii?Q?9AfufKnPGoq4Y1//Lr5jOX8s8v08795GyPBzOuoESdjOtIphSQT/pSNEHuFY?=
 =?us-ascii?Q?eya5na0r4elbck3+WMfRsCwYL3KsqAeHwIdR418IyeEEXb8OIbYt/6G6mNnZ?=
 =?us-ascii?Q?9c56TtHk/pU1VsjgStEqTl+aGWcPIM1Dhq/cJx1yjiIpGRivTmvX1lgniJ9i?=
 =?us-ascii?Q?sAlkDjJ2F4CORosxpgt9j09D0OJxD9L6eVAgK2N2dSpB9kgWnhHum2KKe4Wn?=
 =?us-ascii?Q?GT+k1gCyI2QOgbbzc+3Awqv3MXvX5o1QGMaloAKSiVAeff8XcJoJzJ6M8hcf?=
 =?us-ascii?Q?YeCcgki2AGVwqty7Vx6r3+C8UDIqzjq1fTOgqCrHPitS0UYR/KeDsbexoNot?=
 =?us-ascii?Q?QwI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yMZNUeuyNAHEYhWrxUZOybx16x+hrVjqI6AsXI6eyUsZTVxWerFeOL+QJHK0?=
 =?us-ascii?Q?KX0GrPX0c94hSrHNmmlZ4h0L43p1GqoiwZq3mmoJg4WZoc3cqsbEHQ3eWelv?=
 =?us-ascii?Q?L6bQuDXoOMvTGA4MXkp3pj3G7e14a5ZkPw/oI7aucTzthXVgv8LOvShXbdIh?=
 =?us-ascii?Q?9+KYiVk5gMEh0KeWegOaNpT7KBVtiuHK8Wbt6Qi3g44vYCuO0PV7Tfgc3HH+?=
 =?us-ascii?Q?qSaT5MKjNQRR49c0TAgP82a8RUq0KUTbyqsgemIc9h2mVEYXvdnHmwaDg8/7?=
 =?us-ascii?Q?CJ5nnhsutzeuoLTX4KMVPPLTx35tGr88t5VK6eWp7K72ZwR3qqLAosxrnjN3?=
 =?us-ascii?Q?LV9i8qnKyi0QXpinukkiXQtAp8Qhj9YmoZSGqVhGdh0y1caboiREl0OjTHiH?=
 =?us-ascii?Q?7GYI2uyujcDDJaseRk42YZYc7lSdBKoKR2U1nx1SS2LLwQuBa5aZexb4lM3T?=
 =?us-ascii?Q?i0O/LK1ra1yjGQlYmyxnrhYxefwvuSxeU1jsCnTVixf9kfoCXNkhqsUqzoUU?=
 =?us-ascii?Q?MjDJDukIYHYjALKLXgT/5EK8qN+Zb13yfd5uF94DVIKrBDMzlx1W42XcEMU5?=
 =?us-ascii?Q?uJz3mkzI71/dNfIGU+8bJdixSWGozoCKMis9T58fg4EE351fVhxFjoGaDx0k?=
 =?us-ascii?Q?+HkeSg8CLcmmQuA8Bwb7eutqcrv3i16xbBf04VVJyQkOR32ttDimAQOkS7pz?=
 =?us-ascii?Q?di1vnMvX3/9tUzFCe7uSGC1tRQlGhWAQhMWcyxBKl/KLrpOteiW4/bIO0Ncx?=
 =?us-ascii?Q?nAbk9Be3QO9Mtdc8uzlX9HR6KkvxEdJ7YspFYdsTpv4ZBPOWMmPp3NSyoIl7?=
 =?us-ascii?Q?92oHTnCvN/vndc2hQE3RkVAWZVzOeHmJlwU2YoxMqVB3JMfEsm2VtGDwTzoa?=
 =?us-ascii?Q?8vVpu4GWynJCseyx9huOXOEbM/05dWuU1XTFLRqEO6jOSc5X0KJVmx5IGcXN?=
 =?us-ascii?Q?q+KJwMwzQOzGAiQMgSfe6VzGNVvn9S2lydLvBtoDMUs+7MKtBUYn3B1QCASD?=
 =?us-ascii?Q?Ajw6saCs6dZvHaMaCkHM4qO1n9sn831Ddnl+OGk/cArRhsXgkCr6rSFgLYaL?=
 =?us-ascii?Q?EY0GxAaokqi5a1NHkBw4kmzh49pb844FBdke5j6fAzPUhNCcLGmN2gYwYw5K?=
 =?us-ascii?Q?/PxsArTsh437D8UAhFWIzOBOZL38Hbe8GV2SNNHS9q0nwGr/oAERXIb4Krle?=
 =?us-ascii?Q?WDdjsNbM8JcQch6CxXBm6tqwWpPJTCO3mf0tPwh0275QHrpKeccdRz5Gxo2j?=
 =?us-ascii?Q?ZuTcb/SqhBGJ/beL4ic06YUBcbbXJfXgj6K5Eclbk1IBwrLsFEjmZoRKHx3a?=
 =?us-ascii?Q?PECF3mzyjDWe0prBmWGRz1LiHVvLDQXkyLdFP+kldWpme7wQRSsuNNwgZLWT?=
 =?us-ascii?Q?k7vbMkxGe02WD6YOvYeeZgMpBXxxrZ+4ktWgEMrxpuYYxUZISQfZ7U69Ma0t?=
 =?us-ascii?Q?uORgfxAQmZkg2Z0Zv+RMLabHIJO09E5XppnH5CDHemZb/SvrJVaU5uXYedLC?=
 =?us-ascii?Q?slhytsWJnXi1L9jasLSrbbBo4Wya06t8L/HhGwEzp+ZCeAhwLUeymS8aebcS?=
 =?us-ascii?Q?C/pzG2PQrrgvEpmPCmTP0PXS9yQ84hTQxTf4cCIk/KJumNxGbgF4PbjvZIhu?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a16688b3-6e32-465d-94b5-08dceea6ffb2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 12:27:00.3401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CHz8buVexIW/mkTaoK0M48BSm1JkuXFojlz/0zqj34TLlxRXIJ6+TF2Q73JSzkqqSB82MM3hccoG1OvkhgdJaExIiMUAwYww+242MhzQ1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7548
X-OriginatorOrg: intel.com

On Tue, Oct 15, 2024 at 04:53:43PM +0200, Alexander Lobakin wrote:
> The code piece which would attach a frag to &xdp_buff is almost
> identical across the drivers supporting XDP multi-buffer on Rx.
> Make it a generic elegant onelner.

oneliner

> Also, I see lots of drivers calculating frags_truesize as
> `xdp->frame_sz * nr_frags`. I can't say this is fully correct, since
> frags might be backed by chunks of different sizes, especially with
> stuff like the header split. Even page_pool_alloc() can give you two
> different truesizes on two subsequent requests to allocate the same
> buffer size. Add a field to &skb_shared_info (unionized as there's no
> free slot currently on x6_64) to track the "true" truesize. It can be

x86_64

> used later when updating an skb.

I also agree that xdp->frame_sz * nr_frags for truesize might be an
over-assumption.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

two small nits/questions below that might be ignored.

> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/linux/skbuff.h | 16 ++++++--
>  include/net/xdp.h      | 90 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 101 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index c867df5b1051..6ec78c1598fe 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -607,11 +607,19 @@ struct skb_shared_info {
>  	 * Warning : all fields before dataref are cleared in __alloc_skb()
>  	 */
>  	atomic_t	dataref;
> -	unsigned int	xdp_frags_size;
>  
> -	/* Intermediate layers must ensure that destructor_arg
> -	 * remains valid until skb destructor */
> -	void *		destructor_arg;
> +	union {
> +		struct {
> +			u32		xdp_frags_size;
> +			u32		xdp_frags_truesize;
> +		};
> +
> +		/*
> +		 * Intermediate layers must ensure that destructor_arg
> +		 * remains valid until skb destructor.
> +		 */
> +		void		*destructor_arg;
> +	};
>  
>  	/* must be last field, see pskb_expand_head() */
>  	skb_frag_t	frags[MAX_SKB_FRAGS];
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index c4b408d22669..19d2b283b845 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -167,6 +167,88 @@ xdp_get_buff_len(const struct xdp_buff *xdp)
>  	return len;
>  }
>  
> +/**
> + * __xdp_buff_add_frag - attach a frag to an &xdp_buff
> + * @xdp: XDP buffer to attach the frag to
> + * @page: page containing the frag
> + * @offset: page offset at which the frag starts
> + * @size: size of the frag
> + * @truesize: truesize (page / page frag size) of the frag
> + * @try_coalesce: whether to try coalescing the frags
> + *
> + * Attach a frag to an XDP buffer. If it currently has no frags attached,
> + * initialize the related fields, otherwise check that the frag number
> + * didn't reach the limit of ``MAX_SKB_FRAGS``. If possible, try coalescing
> + * the frag with the previous one.
> + * The function doesn't check/update the pfmemalloc bit. Please use the
> + * non-underscored wrapper in drivers.
> + *
> + * Return: true on success, false if there's no space for the frag in
> + * the shared info struct.
> + */
> +static inline bool __xdp_buff_add_frag(struct xdp_buff *xdp, struct page *page,
> +				       u32 offset, u32 size, u32 truesize,
> +				       bool try_coalesce)
> +{
> +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> +	skb_frag_t *prev;
> +	u32 nr_frags;
> +
> +	if (!xdp_buff_has_frags(xdp)) {
> +		xdp_buff_set_frags_flag(xdp);
> +
> +		nr_frags = 0;
> +		sinfo->xdp_frags_size = 0;
> +		sinfo->xdp_frags_truesize = 0;
> +
> +		goto fill;
> +	}
> +
> +	nr_frags = sinfo->nr_frags;
> +	if (unlikely(nr_frags == MAX_SKB_FRAGS))
> +		return false;
> +
> +	prev = &sinfo->frags[nr_frags - 1];
> +	if (try_coalesce && page == skb_frag_page(prev) &&
> +	    offset == skb_frag_off(prev) + skb_frag_size(prev))
> +		skb_frag_size_add(prev, size);
> +	else
> +fill:
> +		__skb_fill_page_desc_noacc(sinfo, nr_frags++, page,
> +					   offset, size);
> +
> +	sinfo->nr_frags = nr_frags;

is it really necessary to work on local nr_frags instead of directly
update it from sinfo?

> +	sinfo->xdp_frags_size += size;
> +	sinfo->xdp_frags_truesize += truesize;
> +
> +	return true;
> +}
> +
> +/**
> + * xdp_buff_add_frag - attach a frag to an &xdp_buff
> + * @xdp: XDP buffer to attach the frag to
> + * @page: page containing the frag
> + * @offset: page offset at which the frag starts
> + * @size: size of the frag
> + * @truesize: truesize (page / page frag size) of the frag
> + *
> + * Version of __xdp_buff_add_frag() which takes care of the pfmemalloc bit.
> + *
> + * Return: true on success, false if there's no space for the frag in
> + * the shared info struct.
> + */
> +static inline bool xdp_buff_add_frag(struct xdp_buff *xdp, struct page *page,
> +				     u32 offset, u32 size, u32 truesize)
> +{
> +	if (!__xdp_buff_add_frag(xdp, page, offset, size, truesize, true))
> +		return false;
> +
> +	if (unlikely(page_is_pfmemalloc(page)))
> +		xdp_buff_set_frag_pfmemalloc(xdp);
> +
> +	return true;
> +}
> +
>  struct xdp_frame {
>  	void *data;
>  	u32 len;
> @@ -230,7 +312,13 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
>  			   unsigned int size, unsigned int truesize,
>  			   bool pfmemalloc)
>  {
> -	skb_shinfo(skb)->nr_frags = nr_frags;
> +	struct skb_shared_info *sinfo = skb_shinfo(skb);
> +
> +	sinfo->nr_frags = nr_frags;
> +	/* ``destructor_arg`` is unionized with ``xdp_frags_{,true}size``,
> +	 * reset it after that these fields aren't used anymore.
> +	 */
> +	sinfo->destructor_arg = NULL;

wouldn't clearing size and truesize from union be more obvious?
OTOH it's one write vs two :)

>  
>  	skb->len += size;
>  	skb->data_len += size;
> -- 
> 2.46.2
> 

