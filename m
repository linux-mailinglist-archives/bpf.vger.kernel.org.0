Return-Path: <bpf+bounces-59440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9A5ACB91D
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 17:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130A1172ADE
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 15:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34D12236E3;
	Mon,  2 Jun 2025 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjWvWM/U"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BBE221FCC;
	Mon,  2 Jun 2025 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748879854; cv=fail; b=A1bQkpY54nEiwcmhwvTOcoOsPNUgTQnG+HEHj0O3SwoBVB+UJtk2cIw29nIP1W4k7Bo3fJumTSsv006+4uMEmWOm7bHBIHkZUTMwjJEX+Z6yEbFJi9p0QSri0N5SZqZq8O/dxxvoxyUzIXIoHDKmkQg1z5pLJBATnIHr3y1yLME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748879854; c=relaxed/simple;
	bh=yHkHQpoToEtea5py0KUE+shylHyooukMI9NVXDBE6Og=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IDJXhtTnY8R5ez/mlsrCStaMOKHN4JI3sVSPk8uxIigJ+hMbakOMcxFjnxNXSsGzYLoKGHeHWCyAj7h4lDcRNRWhsnnImFafeqGRk89Wsw0kzUMpCMGLVGHJbMotS0q7IZeFZB0FniFabZOMXpUZrBHr8z8bmUhQ+YUU9m1fFiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjWvWM/U; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748879852; x=1780415852;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yHkHQpoToEtea5py0KUE+shylHyooukMI9NVXDBE6Og=;
  b=fjWvWM/UI32s3aPbtCTL6pVfpRlpDZo/6n1mydOYtgiAQsXJarxIV1pN
   nJsqoOoMiIc3L1h+YtS6l5h8p5WvcoISaF7FEU9VuKuGn06MkN+CUfe1Y
   oD+gyMFbOEJ19ELfPq9DZmAcwMYl1xsiFWS+HzL/ZSpcjnysDo+7sFEcv
   eyN1oGGmyNuUVVXFMhkOjjsxmDmljDLnUNjuUqacxyzP4ynl3XFa8yp4Q
   ZtH+okcZJ7UiqMt2iAndtIH2wszQw2k6aQycwEQPP8QG3xTzFKSnrbwfK
   JdQoqiAOb3IpaUuUE0R1msO6sIvss7TUzd4Qica1V4YTNMJegdwh3TeX2
   A==;
X-CSE-ConnectionGUID: lNNoISjNTpalBSnjWwAoXA==
X-CSE-MsgGUID: 1uzbZr9uT5SQ11Lqb1wFaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="68443084"
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="68443084"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 08:57:28 -0700
X-CSE-ConnectionGUID: GOulBr8CTuSk1tGMoZZB2g==
X-CSE-MsgGUID: 166kSxy8RTy6NjBwHl960w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="144541091"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 08:56:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Jun 2025 08:56:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 2 Jun 2025 08:56:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.52)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 2 Jun 2025 08:56:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9bkj5ypS4kE6wE/dPXxa7KIAf/EQMiBJOrIsPvkKRBcEZMTBKyA2//nXaZ8YyAQaBaZXxQCaGMiCBcAlS52uGXKeICWTPpkHZTu+0Rsj5TZHCKD7Js69tdODrbnZD4synzgowJuBD7MKzxR4WHMtBCwqUL5nhyM+zpMO13hOKrVwsRQ1uyX+ONF6GFrq9lJ6UMqy3ZjNVrxV9D0Q655cVO3nynku/Y6Zg82LmUQcbgRUOKaGd0KPN8oIAx7aniQ3yvhBZXTvwQqhDpgzaw0sMcjcOWGZR7L+PiedJVi45O46q+szqxF0e4K6asP+n0/fK/ZXZjesfEUtlKVsobbng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tG1Ize7yzN/EJTfvTHqNJTANd/CLb66SPDWBk33/IY=;
 b=ji6v7s6GQHDdCR8j5leOa1S4jVLzCx5WJ4ebrp9CGNG5DHLGk96ZmQ0+ZY9+Std4w1echsePBYL5U9SjYrwcAsNEGlDyw/12pMaI4AQYgy9afBe0GhyptenBiDJq+gAIWAmgSvKVfcY3n2n+KmRSL1pi8Y0jyDILPkHiErLZXtbP5P1z0N5dJ9VvERhaAw6wu4UGnUfAwZnvxLApmsypoHlQcZ1g9KShtuaHk61dqJpJdiFEWoBpe8k9Dz7FEAKYQwNJrgFovq1tfVnCkiuAD9oa8SGTFtu9Gsj9jZi3gD36RkQB5GEwhKIO3SCEA232F8boLf9OKvAp4oolfiUCHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY5PR11MB6259.namprd11.prod.outlook.com (2603:10b6:930:24::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.31; Mon, 2 Jun 2025 15:56:10 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8769.022; Mon, 2 Jun 2025
 15:56:10 +0000
Date: Mon, 2 Jun 2025 17:55:58 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
CC: <netdev@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "Jason
 Wang" <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH net-next v2 2/2] selftests: net: add XDP socket tests
 for virtio-net
Message-ID: <aD3JjgW2oxdal5lE@boxer>
References: <20250527161904.75259-1-minhquangbui99@gmail.com>
 <20250527161904.75259-3-minhquangbui99@gmail.com>
 <aDhCfxHo3M5dxlpH@boxer>
 <fe162eed-fd44-4c18-a541-8243ccfc4252@gmail.com>
 <aDmaT1cmoRa6PaqK@boxer>
 <ef4ac528-3f91-4004-b47b-e758a5712d28@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ef4ac528-3f91-4004-b47b-e758a5712d28@gmail.com>
X-ClientProxiedBy: YT1PR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY5PR11MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 66cc171d-4383-4491-69dd-08dda1edfe5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3iwU209ELA6lFrD34W9WB9m4fgcdKe7tsyAmlC5wh2Fy5trTqje+xc1wFkLL?=
 =?us-ascii?Q?VQ11gSAaFK56WpLOCSktBGR1N//LjNygHJ3lmd78P2ALG1Fx/r2GZyOInINd?=
 =?us-ascii?Q?GMPT39Dxxu5i/0e6HwgXjjtTEEVTrf8xcuvzlkqrrGHGLvPHBJ+kQdz3xNBg?=
 =?us-ascii?Q?YM62tXarjdtHy9vcZxyKOpjOQtdsOC7TCzGQPpveiEp8ly96p39R1Qx1WgE2?=
 =?us-ascii?Q?VeLqMeS6obQizaDkHERmcXHMMcMcYjCQ+Gw3YE8zUvhoeWi93FbaY5eK4z5D?=
 =?us-ascii?Q?qxbay59TbXAQqpGGpKPGPVnJIaFdYDarWvef5C3KpylEn1H2Tz9S93tw67t6?=
 =?us-ascii?Q?tWwsiq1EKvgDCU49qmVcQGq7728BgjTtN5h32HSD5Z26g3xOqJzP9nwUrmQ6?=
 =?us-ascii?Q?Hg6sb5w1ePvK+euSNCjrRNeoYc6FOm7H/UcxaWHDbXhmIj0o3qMUvlCuRbYM?=
 =?us-ascii?Q?PTWChD5vcE6aEAusbAYw8V9EGxLm7d5cmAA13D8bpMbo3iG8aB7tA1ncYKgY?=
 =?us-ascii?Q?euvA/PJFCpb8V/voN2iLcJjQv6CJsrCiyr1smS4rKHcAg3qWTH36t0jaNxwQ?=
 =?us-ascii?Q?c8CiY4R05/3jg1JAIEZPfwfL5+WIAYV5yPwbL/S3oljF4y82qTIVvJOg8aAU?=
 =?us-ascii?Q?Nsp+oOyk44kZBjajlvRpiu09i+2aObyOBwQ+DGyxHgvq2TjmTrDtAy5ZRucZ?=
 =?us-ascii?Q?n+58oDrz5kvBehWjVCK5wVf8+whkiEzJO90kWqhTsqy5/IslafTvBQxDlNR/?=
 =?us-ascii?Q?Y81JbIez8cZGiuvf4PpWR6PviFgNi5LOx/aooCDtHdV87DcZhEqZYhW7fEyp?=
 =?us-ascii?Q?rZ/vnJqV7feYNNS0GvVZJ2kggvIgrH0u3ubZN2DZiyy/zNe1O7IJNkvlsCKF?=
 =?us-ascii?Q?/sAqA6QjiMUcOerl/j7pRXUpobomfZVQJNjs6S57O0gm38EsK6ac1+J1kCMY?=
 =?us-ascii?Q?9lW4Av2ro1hwZdl9u+PALchS2hOth6MZHw6kSTOwaWJGr24aFmQRlh+IEzc4?=
 =?us-ascii?Q?a9qV3a+cK6ty9p4GqIzF8j03baVnNrABZlY9BdH2PTvGuZ84SGllb8G9zxv3?=
 =?us-ascii?Q?u2smNsn9C6MV7sJabxtstimY0O1kifyGyUGFTAeN+YBJ7uyfoh69vl/8Piqq?=
 =?us-ascii?Q?zIEziXFm81l0Ls5B7yvJ4/hnxCHVd4ObjbpL7vJ2Q7wjlGJ/D+hzMSQb1OMP?=
 =?us-ascii?Q?i9x53OHzII0ZVYFnm/1VFi3v01aYZS1889ohMDyzBPUjQCG7O9EsYeL6Rv0L?=
 =?us-ascii?Q?GI/Fs1j1YAZvTaVZKhBeeKxo7Y67sy4AwSo8HivgrSQGwyzaRmW1jOhrh4ow?=
 =?us-ascii?Q?YxF4nmLvovcAT+xofMUHFuFpJgtlLl2aaX6olvWgIjJevla4zO1g6r2h2lhw?=
 =?us-ascii?Q?V2Y2417RhtFbNk/DMJ+ItQRnjkLRR6xXPFVGXpsqOimjgs5J2FlIIH2KNaTv?=
 =?us-ascii?Q?SHhr+cwKqoo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ygw6Cx4wEoUP6Ho3q85jyuuz1hdVnCqXkjEeKbmBNgBSgZMdJEMPHEm7sr7P?=
 =?us-ascii?Q?IEHxYT1Y2fb/CgQGRiVTB80ztUkZTfyYxeBliad2vYMGpudmtGDiiYuhnQfS?=
 =?us-ascii?Q?+nH1wcPYUkptYg5Y/rfHn0D3c8Y3eOXDZdYF+dPSYFb2KrJk6OQaJDkdqoq7?=
 =?us-ascii?Q?BvbrQxHdr7sr9aY1GhNoYMkee3Rw4WxsWBDfTU3E73JjRxThPQGBL8ikvr4x?=
 =?us-ascii?Q?Wjwfuwp8BoburJS9QnRs8fOpQznM2xoKsIefwMQtrs8o4Yj7O4V91cKyfb8T?=
 =?us-ascii?Q?ehrg1i0ABZQsZxYLkP4oLCEXMoxZ0DDuTXnLKoUd8NE+RvUzj+OlxTmB8B50?=
 =?us-ascii?Q?v4NOffY227j1foil1Qx7UmvGPXMzH8PxQYMMxrY2fE+2WBziAPd/vSAWfR+J?=
 =?us-ascii?Q?P56QEFzRFhdESanBxKijPVFDiFj1yn/xcCtuG1VM9ql2kBXt5IBy+t+vnrLY?=
 =?us-ascii?Q?A875rYWLNvhM54HLuL7U1cZ4GnvxrUtZLM0VRzwfW7GKyPvq+RPC2vtqLKYe?=
 =?us-ascii?Q?T0poMmRiIsWSPAxXZFAziq94su/NLDdX2fPy67l2Y/kSzoztaT7D6p7W2OJc?=
 =?us-ascii?Q?ZIQmJ5R/07ru8BATwUEHaImTsMdO5J6xglE8vEKAaoj1otH29pHhUAZ60e3X?=
 =?us-ascii?Q?loQmsDC8acch/U2knM6voKwUX9Z19DKhCVGbc4VJVv9PKZwI3BCRYpE8d77u?=
 =?us-ascii?Q?z00f6r+oXTld79ZNvnq86aP0LJswTZ/eKr4L9D9hMSeF2OqUnJ2lNJMIZ226?=
 =?us-ascii?Q?xs9p2fQruTpxME8aOqo2QF3emJy+/59MwG3qysr7SJ6V0PC+M5far7iXqQMz?=
 =?us-ascii?Q?FQ9Fi6WWALgU4+w5UVCgchx32kHlK5ffztDHj+hrm6Vda/RxN1qWCiob2NMl?=
 =?us-ascii?Q?VLeVoN4HlGSyIXJNJO/aqWMbMWAr6Fh4KcMNRCZwGSsLztevyqAnbucbHzGN?=
 =?us-ascii?Q?Uqv6hTlUFAxjYiosXUUylE0BuL8C7ksZTlzK6b0u7Grv/ykkpLOkX+FjDelO?=
 =?us-ascii?Q?LyJttUqPuRcmmJ7PuzCXjHG2iX25NAf9/k5+gl+tnxko2qtf84i9nvejGQVQ?=
 =?us-ascii?Q?OeYzxDU4Tc65W5xb3ihB+xntWYVPUlK6Hq/XsHAhPLCi9GZb0srUFtgD1wYG?=
 =?us-ascii?Q?xzJ1qN6WmfBDRNHtjUSq5Q8w7hS4fPfLr4Q2pGoXcoUOB17GUZJz9dUH1k3Y?=
 =?us-ascii?Q?ybcyd9fP1i2J6S71vq5f43ia/s97yC36CI8Mt9hUwb78qAuLmszCwXFBNnUV?=
 =?us-ascii?Q?eKTeBjT2UzG99nujHbZQYdS92yxTBGwxmmsmfA74q8IkxJQUA/ODeIWUPwgd?=
 =?us-ascii?Q?DDYw8PO3MZ2mXMdyX+ZeLSuuRQMIwm3v6AF6yUIH95ajstNOlah9T/Y4ujsH?=
 =?us-ascii?Q?pNh23R2yWs50myJAM4HgSkhxF3ZL3WlLzupqAEMfgF/Q3p9bms7BnRjih348?=
 =?us-ascii?Q?KG05ahi69UGsxnb9QklbCsHTAT4kb9dixCOqLhtejsYEYoeuPqbA9BEl9B2E?=
 =?us-ascii?Q?kU825uLevgnDWKBCQOxUsjURudNUT7iHgvGfbY27IcD+y3cPjiI09xD0m9HB?=
 =?us-ascii?Q?bbq4tFmBfgDX+tcGzJbwzwKujcsVM10IgVksDfNXlP6HOPbLnvIR5Zi48OuM?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66cc171d-4383-4491-69dd-08dda1edfe5f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 15:56:10.5530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdWG4wv3QqYQdAL3ZZ+qsTn7OgWUEjUGHNdJ78IkiQNBqD3T/TPdJ2IOPYBVx9e8XQigGac6Kyk9I7pJu1iGAlgDw2LuI4bSTB1pVx8h9aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6259
X-OriginatorOrg: intel.com

On Sat, May 31, 2025 at 03:51:57PM +0700, Bui Quang Minh wrote:
> On 5/30/25 18:45, Maciej Fijalkowski wrote:
> > On Thu, May 29, 2025 at 09:29:14PM +0700, Bui Quang Minh wrote:
> > > On 5/29/25 18:18, Maciej Fijalkowski wrote:
> > > > On Tue, May 27, 2025 at 11:19:04PM +0700, Bui Quang Minh wrote:
> > > > > This adds a test to test the virtio-net rx when there is a XDP socket
> > > > > bound to it. There are tests for both copy mode and zerocopy mode, both
> > > > > cases when XDP program returns XDP_PASS and XDP_REDIRECT to a XDP socket.
> > > > > 
> > > > > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > > > Hi Bui,
> > > > 
> > > > have you considered adjusting xskxceiver for your needs? If yes and you
> > > > decided to go with another test app then what were the issues around it?
> > > > 
> > > > This is yet another approach for xsk testing where we already have a
> > > > test framework.
> > > Hi,
> > > 
> > > I haven't tried much hard to adapt xskxceiver. I did have a look at
> > > xskxceiver but I felt the supported topology is not suitable for my need. To
> > > test the receiving side in virtio-net, I use Qemu to set up virtio-net in
> > > the guest and vhost-net in the host side. The sending side is in the host
> > > and the receiving is in the guest so I can't figure out how to do that with
> > > xskxceiver.
> > I see - couldn't the python side be executing xdpsock then instead of your
> > own app?
> 
> I'm not aware of xdpsock. Could you give the path to that file?

https://github.com/xdp-project/bpf-examples/tree/main/AF_XDP-example

this is our go-to app side of AF_XDP.

> 
> > I wouldn't like to end up with several xsk tools for testing data path on
> > different environments.

