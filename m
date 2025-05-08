Return-Path: <bpf+bounces-57797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAF9AB03A6
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 21:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E711BA7DC3
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 19:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0889228A408;
	Thu,  8 May 2025 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvArplZD"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8152874E0;
	Thu,  8 May 2025 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746732364; cv=fail; b=DUf4498H7rna3VDwdn6QwzDpeaeFIncUPEgxC8llI0NhyPcF6exlJX9dXSo8vkOUNhA4QqDlieJx9jMgEOUKyTa05H2idpCEFJDdZ3mhlLdyX27lPJI+1/xd8C1j87dnlfZbwkgAhw/GM5G2YP6cgElN/QSseovtbbHeHqsfbU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746732364; c=relaxed/simple;
	bh=GsI2S0x1pT0KaOnPqJIZ4D4azFjtTDQV/3zBD1VrHaY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dRvCO2pNpBxoHXfUONC6r3JXYUfBS7UhcHZEbNONWqmp/vAIqYkpBtu75mbegvduxmBeraXjk8E415FczBBCQAQzf5eOeAlMbxW9MDeqX9DyXWbV5pkrXVz+ivCjOmxEtN/o02ql6zjBfGYls+vGH6KI9ysZHkMTrE9ICq43JcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvArplZD; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746732362; x=1778268362;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=GsI2S0x1pT0KaOnPqJIZ4D4azFjtTDQV/3zBD1VrHaY=;
  b=cvArplZDmExlPQyie1yPxeC8NmAZywJAbPMRNlJ5ScKTy5tB9GETpgUh
   a/+h2RGLnV9mW1bX+Pq8mOkc/pxikK8nW0agxlwOuh58zapTSir7mgtv3
   OUL2+uE/Pxc8s1iExryN+O3kKu8imdnf2hSP5erJXO2XGfHalaCHebiX/
   FMOa537j0mg3H8WhQkzHI+QoT7rv0IJriWNJwZfzPrEMLpIu9BaKo1KCm
   uSOl0O0mEilCWSlOsEFx8gl5jnaJEKPhpo4vO0eIBeiqtWDhsDknKVNJa
   CxXQhB8S5QJirx8C0vWrkzMsYlBOouHyXrsO9RcxkJdUFvH1iTZ6Rlj/S
   g==;
X-CSE-ConnectionGUID: Tc6kFZ1/SM6+QzTd+UXl7Q==
X-CSE-MsgGUID: xocOMvLwSASzTjP6k1Oq0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="51200014"
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="51200014"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 12:26:01 -0700
X-CSE-ConnectionGUID: tU0IyyyhSWa1x3LdMDRC6Q==
X-CSE-MsgGUID: RwR2it0RTDOJsL6/7WL7IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="141291141"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 12:26:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 12:25:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 12:25:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 12:25:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNDbIN10JGYFLfGVzVYzhR4BZImSZy640Ky4TEQtjmj1e4KaJ427z8JTl3kN/SAyoubcSZPlZWCpHvor85p8NJCX35RxOc4C5ru1ue2Z1Csrs2/c/GGhPeF3/jIk3tKvn5ANL++F+fAId/BIfNfk1E3peI+v34i7wjqHMagDONwtfhiowF7mfE6ocQfNblnG05Qa/sXA/oozwwZEXowFJtF+YfrQpUhhsaytiuhlNcTuyt13TgDrHkOyFcP4C9YdSGi7XP090DdltCzfTqZqj7nFF1I12/C7gW39qVSo1aF7e9OYSjb7kaTF79hq1cZvoTNfriz0P8HHkv10b2Xbfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veGZK08Gho4hYzo+69kBRqoEon0c3lhn9B7SizsH6DE=;
 b=mR9YpayaJXwNZ7mm5Qfjq6MRPmVusvenAiPXB3vrL6o+Rj5Z3kHG/wR7F6OseVPnrjvJMKhL+A4kFqsdn1ga7HYnk13CFEO2H8rJxWzcYT59NXp9USax1kWw+s/nQyqUenSSjdqb567M9eFh6LcGs0fz0tk5Z2dywxDcJh7V5BN7gPa7BjFBSK1A2sLPzXegXbDh6iYXoM6eo6yDa70l5JWczeFFMI2TMLooFLrg5I/OE+G/MV471yzT3q/Rtb700/j8YFAE2yRcI2bXPpJyUhIsZQBMAPohXeMSdZ5PPTQJUnFYwMCEVIeJxBDQhz3JuSlzKQkHoD13Tjtvz9Ih4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM6PR11MB4561.namprd11.prod.outlook.com (2603:10b6:5:2ae::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.22; Thu, 8 May 2025 19:25:26 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8699.022; Thu, 8 May 2025
 19:25:26 +0000
Date: Thu, 8 May 2025 21:25:12 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tobias =?iso-8859-1?Q?B=F6hm?= <tobias.boehm@hetzner-cloud.de>
CC: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>, Michal Kubiak
	<michal.kubiak@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Jay
 Vosburgh" <jv@jvosburgh.net>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <sdn@hetzner-cloud.de>
Subject: Re: [BUG] ixgbe: Detected Tx Unit Hang (XDP)
Message-ID: <aB0FGKnwPq4rqkVq@boxer>
References: <d33f0ab4-4dc4-49cd-bbd0-055f58dd6758@hetzner-cloud.de>
 <Z/fWHYETBYQuCno5@localhost.localdomain>
 <ff7ca6ea-a122-4d7d-9ef2-d091cbdd96d2@hetzner-cloud.de>
 <Z/jPgceDT4gRu9/R@localhost.localdomain>
 <aAEUcXIRnWolGWnA@boxer>
 <b06ede77-541b-453f-9e7a-79f3e5591f66@hetzner-cloud.de>
 <aAkz/+Rx5w3OHH4/@boxer>
 <eca1880f-253a-4955-afe6-732d7c6926ee@hetzner-cloud.de>
 <1713bf39-2bcb-4a43-94c7-a61ff97e2522@hetzner-cloud.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1713bf39-2bcb-4a43-94c7-a61ff97e2522@hetzner-cloud.de>
X-ClientProxiedBy: VI1PR07CA0149.eurprd07.prod.outlook.com
 (2603:10a6:802:16::36) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM6PR11MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f801c9-975d-4d38-aa63-08dd8e66158b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?MJp9rKWNN1VPu+5QSD4MYqjYzmu4iosR0rfSKPUVDtHUNkSPwrOniUVrka?=
 =?iso-8859-1?Q?/RaaF0lFFl6fq13imMX/LbysnLdWEICFdQW5CUJ+TXZqNK41GZFH+t6Lkd?=
 =?iso-8859-1?Q?ryaCWAUHUJ2gZs4boL7pN0VA1F/MCoAODBSNZsHNN3co4Y/616LDABo01F?=
 =?iso-8859-1?Q?/aWgT+llpu21yEgK589pexYaLxl3BqG4I+WIDuULH7jPtgs/ddgXBHym9X?=
 =?iso-8859-1?Q?I9tGgy5ILlIH/z0kkD7Wg0bkVp05W3bV/vVksDhIxnbYejJRYdcV0Z8cSn?=
 =?iso-8859-1?Q?NeJlTkCxMUFh7ncpaDLgWYTGCl2Kr8cSoAqklTK+2z6SA4eLvJISwNhgak?=
 =?iso-8859-1?Q?rmXXPq7HV+PoZYdsN8TFlPwiQ+gUCc+6QaRMZLHa6wwiRfV3jl1kJshps4?=
 =?iso-8859-1?Q?fe9SpBUNT0YbqzgCBqkOJOYWhfxGDNY2BT6viiR7tNOJHXF7RZvgZRkcHo?=
 =?iso-8859-1?Q?MkNs0P2dzhjS+lZpsqWsDtJ3WJ6j9vDL4e/6jgDt09Ci0SGxMZrge4d2tq?=
 =?iso-8859-1?Q?vAzAoiujzNbn5LpAhfraDgpi5fq0toy8KUy0ch13yJvvyzn4eaeTOqAyTU?=
 =?iso-8859-1?Q?GRM9sVdZawnMoHhF7BSNikfbPJu7HB5LnfR1Q2PqhOC1VrBynxHH4veP4S?=
 =?iso-8859-1?Q?r2VmLw/JUKcBZ7DNTQsr1p/P2TYzg1gaA5KPFyJGhAvZl7GcEO6VsFbbaJ?=
 =?iso-8859-1?Q?FpbPEoqZL+4E3nX42daT7/IRepKf2aFONkfY3vYtMIIg4fLl93kdBbTEnQ?=
 =?iso-8859-1?Q?wC4X8l/gRN+CeQEwrTQTr1xFsbSL7t1jnG1Q0RRtKSKjIsD4G99dwRfhMK?=
 =?iso-8859-1?Q?oIdU9E4/bZYRo+S1jBKW65ISvGvwJW3H5UYiVYi6ekQvVdEw3ZJ8ydRvRV?=
 =?iso-8859-1?Q?44dZGKNBzbojvlsmL9x/LPYH3vUVcv5MdSrLnuqHpTiuA802P3K4DjX70W?=
 =?iso-8859-1?Q?x6wfGPws3J/WPnVCJVW0rQk7MvXq6OU4nZ0Kq8qox48Td4CMXVUfgkFVf/?=
 =?iso-8859-1?Q?R5AzeZf4wxhPTHMpV6ecQIp3ltb/TAq55WZehzl9SDCVf6lgDK8eFAmPr0?=
 =?iso-8859-1?Q?HIwozPaWai8zmyxD8eROsVmow/BVZrJCn6BBEhEJRhYcIjIH8CixWdryLZ?=
 =?iso-8859-1?Q?9EaIF4Q9g0y/Y/a8B3PdFVaPY0kLEwT8LjyJQIM9OZ6GSMYfG2xgTWkqhb?=
 =?iso-8859-1?Q?b9J1yxh9mr67E9hZXJJVPdCstJihsYWkgHgcVXRRkrHCuQfLJCTfOJWhmf?=
 =?iso-8859-1?Q?llcTF3LMvlhqB2DUSlpOC2P6SGKJGXT/zPAs+ZG5tDmBkla1m0qMER+t+1?=
 =?iso-8859-1?Q?2jR9sUKGMNBzHIslYGRzQhXLCYIpJKUqA7CJ4bIwk+dAIsfx4Pm/rTdkKc?=
 =?iso-8859-1?Q?oQ90nr0CrA1POgYtzTEt2PvGpAPkGSRNp0i3Aau/B1OHlUupm5ZxtDW+Wk?=
 =?iso-8859-1?Q?IcJY6rM4f++UysdABTcCaTWUxdIYIstNDbICLPczeC3g7s8GcLRl5Ir7vG?=
 =?iso-8859-1?Q?4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?khS217m0MekrjUacZVimlrkRhfs5SvRtL2AEP1p9hoGrj9RlVDblAbhZwa?=
 =?iso-8859-1?Q?Rwlf/+r7bXO0CYpUxntKZviJ5SOqtm25TclTyRwwxyZqhWF8ChAeLEWnAk?=
 =?iso-8859-1?Q?yGl02jWRQO1k/yywBiB40iw8JPrG3Wufu/Y4MnNu79Ox3Tz3mtF/MlyWGO?=
 =?iso-8859-1?Q?Kwl0w5o8nRLrI3Xr4gfZXK/TikY5o0H5miZZ4dR5a/Pa66rUJWPIkbNajT?=
 =?iso-8859-1?Q?rMUYBOxRmQGOXErzff5G7Bmmixk3haROeAP7WOonItlxIi+aDov1EBzfHK?=
 =?iso-8859-1?Q?TyI96euPiu7tYK1D5eQk4ia5emI58S4hKlOE0owB1u6IIolfGe62yjgo70?=
 =?iso-8859-1?Q?5SENRtFQSKlppL7cXCu1cv0oWhieyHIfiDJ2W1AeBlU204W40y+R+onBdK?=
 =?iso-8859-1?Q?MJ6WgFE2jBFhaXs4k1093La7TIEChFwcp81bsyVqaeZQH7mhiIdVpouzzM?=
 =?iso-8859-1?Q?3hHxqRglEKI4BmKueeDAxuNEyVpeJW8r7kuACHR0VBTCSirwrmEbAinWzN?=
 =?iso-8859-1?Q?5PlsQV1nTf75Vkm37XLLRMmDhMhvjBTCxla7H+BDrpCfRNg0TwmBuUXJdy?=
 =?iso-8859-1?Q?DoqoUcw1OhAGM4CFXGalS8qf+DluujStq6KKHMd5tyXkmquHX2B4YS5/Uu?=
 =?iso-8859-1?Q?Enah0zhNGRFL6ESHRdTxonLxf8jWzRklKBX48GNcZklMHthOQ2VPOyPWUu?=
 =?iso-8859-1?Q?yvrjdlw6MpbZhpi+mJCgr3a8NkTXV8dwaMt4OwnFwNJP+Xk+qzj7Sxqb6j?=
 =?iso-8859-1?Q?XJOSDt5zrwnxSd1OFlTuo+OMOog4trl0atiaWUN/sUq20boSe0yqrDCtAi?=
 =?iso-8859-1?Q?4MH18nlL4YkRL8o8mgCztKuSeROsV2qhj6HgYQnbz/n8UugnppYe5fys5q?=
 =?iso-8859-1?Q?u5kMdmED9uGgGfAj5RXtSv1R8uJA+pBdOG3pzGH6Ao5e5s6Hrc2ShuaCD5?=
 =?iso-8859-1?Q?7bkvqGbneVpD+R/db0KxhGevJdMOiYpv2qP/KMMla75FG0uHY6ExYnikW7?=
 =?iso-8859-1?Q?2Souc6OGq5uxTB+TLaBa4Z/aIKhUaqfJTobiCJ9nfcgDl4+HIc3OGjr4zM?=
 =?iso-8859-1?Q?DUjoQm3nm74JxQ7qstRogG39OUj6Rb286VPDVVSr3ewyvZOeFClyUdyMGh?=
 =?iso-8859-1?Q?1GqSaquFlz1LRSoJWHwntohr1ZflanFYAFGEFwY6JeO+G8lYWXoc5uCiCD?=
 =?iso-8859-1?Q?6KwUArGWx/Im/UIQby+jGZFoNGUxmU/uGrsvLy0g0jgvlPHM1ESJndB8KM?=
 =?iso-8859-1?Q?OElhpNwG2xaUsqo6qCE23TfD2Qecm/bJXevr7Hit+dxl7VC/jBQLuC7vvb?=
 =?iso-8859-1?Q?B2LW5SxjHA22i6IRBBqfOYN+hanIa8oNYNwKF8fULdysBHAGOhbLQHzThj?=
 =?iso-8859-1?Q?u3+kIsMK/u3lYeiunyQhq6v0q/oObaEw06IbMiaSa8zxtcNw5OvWneUPeX?=
 =?iso-8859-1?Q?JzCDREPzRHQLIl22Yatj975/cF+oez+kj6tDwTCELMjKiVRKlbPOiyhqOF?=
 =?iso-8859-1?Q?+kSPY7bMpfhDgCI9PntbtpoU/+OgemqoToBA18SLMnOvWpvxKO0nKfkbHF?=
 =?iso-8859-1?Q?bGIg5sBhDzrtCa9K8KbUEgW1V5EISrEzexUcSTFeoOw7C/utDHbDdWOfuS?=
 =?iso-8859-1?Q?wPxVmwK1MApTDQD8s5Dth58sWnKJuMa+iKdAjSky4voFjTv6YKAz0NWg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f801c9-975d-4d38-aa63-08dd8e66158b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 19:25:25.9348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNNXHC4rgyt6M7WZYoA74buoeFPGyVTkEe+bdXNI9ar4bJAbjbzgPsH/0yFp2RiUooOdUDaXu8zWt+LWTc4/6HF1vBsh1Phuo4e4wXR84cU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4561
X-OriginatorOrg: intel.com

On Mon, May 05, 2025 at 05:23:02PM +0200, Tobias Böhm wrote:
> Am 24.04.25 um 12:19 schrieb Tobias Böhm:
> > Am 23.04.25 um 20:39 schrieb Maciej Fijalkowski:
> > > On Wed, Apr 23, 2025 at 04:20:07PM +0200, Marcus Wichelmann wrote:
> > > > Am 17.04.25 um 16:47 schrieb Maciej Fijalkowski:
> > > > > On Fri, Apr 11, 2025 at 10:14:57AM +0200, Michal Kubiak wrote:
> > > > > > On Thu, Apr 10, 2025 at 04:54:35PM +0200, Marcus Wichelmann wrote:
> > > > > > > Am 10.04.25 um 16:30 schrieb Michal Kubiak:
> > > > > > > > On Wed, Apr 09, 2025 at 05:17:49PM +0200, Marcus Wichelmann wrote:
> > > > > > > > > Hi,
> > > > > > > > > 
> > > > > > > > > in a setup where I use native XDP to
> > > > > > > > > redirect packets to a bonding interface
> > > > > > > > > that's backed by two ixgbe slaves, I noticed
> > > > > > > > > that the ixgbe driver constantly
> > > > > > > > > resets the NIC with the following kernel output:
> > > > > > > > > 
> > > > > > > > >    ixgbe 0000:01:00.1 ixgbe-x520-2: Detected Tx Unit Hang (XDP)
> > > > > > > > >      Tx Queue             <4>
> > > > > > > > >      TDH, TDT             <17e>, <17e>
> > > > > > > > >      next_to_use          <181>
> > > > > > > > >      next_to_clean        <17e>
> > > > > > > > >    tx_buffer_info[next_to_clean]
> > > > > > > > >      time_stamp           <0>
> > > > > > > > >      jiffies              <10025c380>
> > > > > > > > >    ixgbe 0000:01:00.1 ixgbe-x520-2: tx hang
> > > > > > > > > 19 detected on queue 4, resetting adapter
> > > > > > > > >    ixgbe 0000:01:00.1 ixgbe-x520-2:
> > > > > > > > > initiating reset due to tx timeout
> > > > > > > > >    ixgbe 0000:01:00.1 ixgbe-x520-2: Reset adapter
> > > > > > > > > 
> > > > > > > > > This only occurs in combination with a
> > > > > > > > > bonding interface and XDP, so I don't
> > > > > > > > > know if this is an issue with ixgbe or the bonding driver.
> > > > > > > > > I first discovered this with Linux 6.8.0-57,
> > > > > > > > > but kernel 6.14.0 and 6.15.0-rc1
> > > > > > > > > show the same issue.
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > I managed to reproduce this bug in a lab
> > > > > > > > > environment. Here are some details
> > > > > > > > > about my setup and the steps to reproduce the bug:
> > > > > > > > > 
> > > > > > > > > [...]
> > > > > > > > > 
> > > > > > > > > Do you have any ideas what may be causing
> > > > > > > > > this issue or what I can do to
> > > > > > > > > diagnose this further?
> > > > > > > > > 
> > > > > > > > > Please let me know when I should provide any more information.
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Thanks!
> > > > > > > > > Marcus
> > > > > > > > > 
> > > > > > > > 
> > > > > > [...]
> > > > > > 
> > > > > > Hi Marcus,
> > > > > > 
> > > > > > > thank you for looking into it. And not even 24 hours
> > > > > > > after my report, I'm
> > > > > > > very impressed! ;)
> > > > > > 
> > > > > > Thanks! :-)
> > > > > > 
> > > > > > > Interesting. I just tried again but had no luck yet
> > > > > > > with reproducing it
> > > > > > > without a bonding interface. May I ask how your setup looks like?
> > > > > > 
> > > > > > For now, I've just grabbed the first available system with the HW
> > > > > > controlled by the "ixgbe" driver. In my case it was:
> > > > > > 
> > > > > >    Ethernet controller: Intel Corporation Ethernet Controller X550
> > > > > > 
> > > > > > Also, for my first attempt, I didn't use the upstream
> > > > > > kernel - I just tried
> > > > > > the kernel installed on that system. It was the Fedora kernel:
> > > > > > 
> > > > > >    6.12.8-200.fc41.x86_64
> > > > > > 
> > > > > > 
> > > > > > I think that may be the "beauty" of timing issues -
> > > > > > sometimes you can change
> > > > > > just one piece in your system and get a completely
> > > > > > different replication ratio.
> > > > > > Anyway, the higher the repro probability, the easier it is to debug
> > > > > > the timing problem. :-)
> > > > > 
> > > > > Hi Marcus, to break the silence could you try to apply the
> > > > > diff below on
> > > > > your side?
> > > > 
> > > > Hi, thank you for the patch. We've tried it and with your
> > > > changes we can no
> > > > longer trigger the error and the NIC is no longer being reset.
> > > > 
> > > > > We see several issues around XDP queues in ixgbe, but before we
> > > > > proceed let's this small change on your side.
> > > > 
> > > > How confident are you that this patch is sufficient to make
> > > > things stable enough
> > > > for production use? Was it just the Tx hang detection that was
> > > > misbehaving for
> > > > the XDP case, or is there an underlying issue with the XDP
> > > > queues that is not
> > > > solved by disabling the detection for it?
> > > 
> > > I believe that correct way to approach this is to move the Tx hang
> > > detection onto ixgbe_tx_timeout() as that is the place where this logic
> > > belongs to. By doing so I suppose we would kill two birds with one stone
> > > as mentioned ndo is called under netdev watchdog which is not a subject
> > > for XDP Tx queues.
> > > 
> > > > 
> > > > With our current setup we cannot verify accurately, that we have
> > > > no packet loss
> > > > or stuck queues. We can do additional tests to verify that.
> > 
> > 
> > Hi Maciej,
> > 
> > I'm a colleague of Marcus and involved in the testing as well.
> > > > > Additional question, do you have enabled pause frames on your setup?
> > > > 
> > > > Pause frames were enabled, but we can also reproduce it after
> > > > disabling them,
> > > > without your patch.
> > > 
> > > Please give your setup a go with pause frames enabled and applied patch
> > > that i shared previously and let us see the results. As said above I do
> > > not think it is correct to check for hung queues in Tx descriptor
> > > cleaning
> > > routine. This is a job of ndo_tx_timeout callback.
> > > 
> > 
> > We have tested with pause frames enabled and applied patch and can not
> > trigger the error anymore in our lab setup.
> > 
> > > > 
> > > > Thanks!
> > > 
> > > Thanks for feedback and testing. I'll provide a proper fix tomorrow
> > > and CC
> > > you so you could take it for a spin.
> > > 
> > 
> > That sounds great. We'd be happy to test with the proper fix in our
> > original setup.
> 
> Hi,
> 
> During further testing with this patch applied we noticed new warnings that
> show up. We've also tested with the new patch sent ("[PATCH iwl-net] ixgbe:
> fix ndo_xdp_xmit() workloads") and see the same warnings.
> 
> I'm sending this observation to this thread because I'm not sure if it is
> related to those patches or if it was already present but hidden by the
> resets of the original issue reported by Marcus.
> 
> After processing test traffic (~10kk packets as described in Marcus'
> reproducer setup) and idling for a minute the following warnings keep being
> logged as long as the NIC idles:
> 
>   page_pool_release_retry() stalled pool shutdown: id 968, 2 inflight 60 sec
>   page_pool_release_retry() stalled pool shutdown: id 963, 2 inflight 60 sec
>   page_pool_release_retry() stalled pool shutdown: id 968, 2 inflight 120
> sec
>   page_pool_release_retry() stalled pool shutdown: id 963, 2 inflight 120
> sec
>   page_pool_release_retry() stalled pool shutdown: id 968, 2 inflight 181
> sec
>   page_pool_release_retry() stalled pool shutdown: id 963, 2 inflight 181
> sec
>   page_pool_release_retry() stalled pool shutdown: id 968, 2 inflight 241
> sec
>   page_pool_release_retry() stalled pool shutdown: id 963, 2 inflight 241
> sec
> 
> Just sending a single packet makes the warnings stop being logged.
> 
> After sending heavy test traffic again new warnings start to be logged after
> a minute of idling:
> 
>   page_pool_release_retry() stalled pool shutdown: id 987, 2 inflight 60 sec
>   page_pool_release_retry() stalled pool shutdown: id 979, 2 inflight 60 sec
>   page_pool_release_retry() stalled pool shutdown: id 987, 2 inflight 120
> sec
>   page_pool_release_retry() stalled pool shutdown: id 979, 2 inflight 120
> sec
> 
> Detaching the XDP program stops the warnings as well.
> 
> As before pause frames were enabled.
> 
> Just like with the original issue we were not always successful to reproduce
> those warnings. With more traffic chances seem to be higher to trigger it.
> 
> Please let me know if I should provide any further information.

i can't reproduce this on my system but FWIW these are coming from page
pool created by xdp-trafficgen, my bet is that ixgbe Tx cleaning routine
misses two entries for some reason.

What are your ring sizes? If you're going to insist I can provide patch
that optimizes Tx cleaning processing and see if this will silence the
warnings on your side.

> 
> Thanks,
> Tobias

