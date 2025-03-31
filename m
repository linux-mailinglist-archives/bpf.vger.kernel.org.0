Return-Path: <bpf+bounces-54979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBF1A76C0B
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 18:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB3B3AC497
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 16:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F158621507F;
	Mon, 31 Mar 2025 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dphqu1I3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8475214A96;
	Mon, 31 Mar 2025 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743438952; cv=fail; b=nBIJriQjXgoDPSunnnVoZL7PLdt3IkQsvpKTKJi67E8oh0K+G8qqTBGMvgSL3D5As7d/l48uqCvjaQ8KKqtpPybfroiOtZuSSrWnTKfaMRfapexdUE6TlyEErwTsSCJTO8a9ufa+IO36QeTMolzcy0nrLnmWXdIYxFqIbyLkDJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743438952; c=relaxed/simple;
	bh=eE2EAiFIzTEgWOgo1Hb8EKpGYmi/hGqygNrKHMUP9m8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j35RnZ/0h9tAo0uVC0v2OhJ77f2scGU1sIcvy71MeAQkrI1FbzAfIk8ofURJxGdysq8qMnf4oiNO704N78irNvZlLC5Uwkh+f0cdU7BfAkc9HnM2N6+JrZyOu8SXxtG/HBbllidTuQVk9RHR+gdH/JGLIuaBn4wbXj1RBn/W9zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dphqu1I3; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743438951; x=1774974951;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eE2EAiFIzTEgWOgo1Hb8EKpGYmi/hGqygNrKHMUP9m8=;
  b=Dphqu1I3quK16jfMhX5vw+zf5axh0NjqUnthyEvBjMcqyJ6VQZ7j/GHT
   /AgP2jjOQ6+c9P7CPDn8ySORFyyIgOkh2oKWWCGk00F62/VN2C8vwaKWW
   ajsgAkT5t2PVJoHpdxyVehHD1c5V8kpwoL2VNCxeurrfe48sYZ2AOcewY
   a97ZPhfdj7VMHNefb3J+V0+7HP3Vx3bMZks6AGzeXBm4Z7H4CZJMuHDVE
   cryxI6Au0bkvQVca48frPrD8V6p6OvecxznuJPkFfe1XVSbAOcaN5V83f
   YKU+jHsNF/VFqvN2vVBJu44or4t3bzlkugGkz801J9AFWY2Bn4Yr+ksrm
   A==;
X-CSE-ConnectionGUID: iy5R5ZMhSYiwbc5nwffzxA==
X-CSE-MsgGUID: VEAptkhDSNO8ZxdRjRYQIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="44744875"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="44744875"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 09:35:50 -0700
X-CSE-ConnectionGUID: dfPKLSQzQXqssOgO3POtTQ==
X-CSE-MsgGUID: z4ESekVqTjGUsIy/KOJIog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="127047356"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Mar 2025 09:35:50 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 31 Mar 2025 09:35:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 31 Mar 2025 09:35:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 31 Mar 2025 09:35:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0lZKoAnao+BBTKgPKjSgiUw8etTrq4AWwgsgcYvjH24K4blUtfL+B6xrERR2alN7rUjMn3KsLCQcNlzw4kOrT0OxJsosegKe+yq07ZiAnI4H/DvDLarcIRt+RIQrV1cx1jD3TOFVwctgbfAUZpBhrGfQbHiUf4NH2Y66W0htwkoLJx6blkd/KtE+oG4NoJ/QSNxpMeXwCE3n6WQkA5P5Bk9PgS0DHdsVtAvy1OXkcm0/Liens5z+pxfIWA5tLBZksiGMIEQKoqN/H1pC9izZItRPaiHkkvt+7Odq/YOa28viUpQearGlOs/yXLsrU0hnGfBlwzDRgGR3228p8Vupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uD2vEFiT69eJ5Nj6kYCqrRQZjVVMRxZH8/RboJdT3uo=;
 b=x/DR8OrUZLazEpqcYUsNwi9pAjgCaMLMr7mvm+CiprROZD+HkJvHKeSH9jqFU+bFzHS4y0ogQuLmzCxnS1fDtpsrNwKS36LgGQW4RUePs9ikzE+KF0ocr9dy5/400GlijL1e6Xr3IkYMYK2mc+3g+2ah0NrPYp2OgfdwPf7lkdsatGdCMn51wS8yPGTXf+TC8O+EighgfB0/RhFZg4AM0aimlUh5TuQalOZk1f8PhKsS/b11aAFsdFElzBZ6LselFSGlkpi2wYkgImTYLlGaNGtAhjRS8zonsBNK+l4F8EpWkS876R4qivR3apFx0cgaYdK/l52wb5B3BfrALhEVyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB7091.namprd11.prod.outlook.com (2603:10b6:806:29a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 16:35:43 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.8534.048; Mon, 31 Mar 2025
 16:35:43 +0000
Message-ID: <aaf31c50-9b57-40b7-bbd7-e19171370563@intel.com>
Date: Mon, 31 Mar 2025 18:35:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"Simon Horman" <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	"Mina Almasry" <almasrymina@google.com>, Yonglong Liu
	<liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Pavel
 Begunkov <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>, Qiuling Ren
	<qren@redhat.com>, Yuying Ma <yuma@redhat.com>
References: <20250328-page-pool-track-dma-v5-0-55002af683ad@redhat.com>
 <20250328-page-pool-track-dma-v5-2-55002af683ad@redhat.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250328-page-pool-track-dma-v5-2-55002af683ad@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0119.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ae434c-b576-4422-9474-08dd707214c8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c09LNS9yYmw4MlozdDdDOTQzU3ZZMHNmQzFwYVdmK0d1ZjRUWjB2SG1kRW5W?=
 =?utf-8?B?QmpGd0J1YklXL0c3bkhVNElkWWwvRWpGWDQ2NkIrUXNIZFJnOTNRT3pxL0NG?=
 =?utf-8?B?RVU5cnJ0NW93UzVPckViTUE4ME9yejJ5Y0NJZzVuZmx2NW52NFlsMldNWEJk?=
 =?utf-8?B?SlFNMzJJNGNBWHJZNERQdUJpejFyNjZaSUVydkhOWWhEMkhyakxwUDRUNXdD?=
 =?utf-8?B?ZlZzWTJuSnY4U3oxYjlWRG1NQmxqMy9IUlBrWU1OdytmanpKeWlBYko2cXhU?=
 =?utf-8?B?Qk02T1pPSEt4d2t3dlpMM2V1elJMd0dQUzF4clkzNVdOUEw5cWJMVGNLN3JJ?=
 =?utf-8?B?d0EzTXJSelprS0ZyM0N5MlVFVTVsZkFDWEVvZTRXSmQzUjNYS1pSS3d1RlhG?=
 =?utf-8?B?SU5yK0lWREFsK1REaWx2bk1oNkFCOWs3WVpROWxtY3NPREJJaVpVT2Z0bTBt?=
 =?utf-8?B?YkVISnhoZUFxM2hxaDNkVjZPQnZhYzh2UVhQTytFOFlKdktGQWhPZC90ZFpo?=
 =?utf-8?B?N05IbHNHMUNmc3NMdHo2VnJPdVMyNzQ2bjNnVldqOUhtZUJlRThLSGkxUzZE?=
 =?utf-8?B?a2FFbVNIV1B0by8vdEFPamF2SUtOZHd0VGVZWEluQi9DWDBsMjBlYmZ0TU1q?=
 =?utf-8?B?aHFvNDB0Y1lzeUYrSFkxbUJqdVgxQnZ1eUh2WitGNjRaNmdzcFE4SXdUUHIr?=
 =?utf-8?B?UDU3VW5hYTBjOHVRcnJaNmVmbTdpSGNtTVY0MzVLZkNxd1k3ZUx2VmdMSXpY?=
 =?utf-8?B?amo5dnRTd0dtM1pqRFMwRkNZdjh2U1dZRXphL1ZTT2F6RUErd1VhZ3R2dUdI?=
 =?utf-8?B?TTBtZU9JVVNhSmNJZ2ZrN0VYeGxiSmpPaVdCLytTTUV2cGZJRm5WajRIcVUx?=
 =?utf-8?B?YmUzVWZudmtOVVBBdDRSR2p5YUwzNFlHNEk1TFVDRkt0UDJreU02T3oyVVln?=
 =?utf-8?B?c3oxaGxqV1B1elhWSGxPbGNBdldnbEhDNnBuanJhU3l6cXovbWd1UUlHSUg1?=
 =?utf-8?B?R0I1Q1ppUnZ0WExLbUQyb2NmazJoVU5hMlhQR1NIcC9GNUZsa0R3elFsVmU4?=
 =?utf-8?B?bHJFQ2lhR28zcmZ1alpPS1h0Q0JQRmY4WWkxS0FPOWFVc1dBdXBkQlRMOFpz?=
 =?utf-8?B?YkkxcVlHNXVsUlNGd2lxa2VyT2I0T2p0cS9WaVFLTThkUkVkRGJvR1RHZnNX?=
 =?utf-8?B?dmtLSERzckU4dE9wK3p5RjBIK0hOeEhhZG5uZ1UwcG9nUHZvNXArbmI4MkJV?=
 =?utf-8?B?a1FmemM2eGtxdjcyTkxvQ0ZIUHhnbXFBbGJ1blhnSTZTWWk1YklrUkZrSENO?=
 =?utf-8?B?TXF6U1ZVRjBLTkFicXhmRGNWZGhWSU1TZk1STWt6OThmUkwwWmlmdjBoZENO?=
 =?utf-8?B?UG4vdEZ0aXVrT0VWWCtoMVRyeVpMZ0pBNGZpQVFRLzRIZ3p6clZqeEFWdTg5?=
 =?utf-8?B?WURIUFQ0TUxDU0IyMTRwR0VOM1FEMWxKMEN2ZzUzVjd2N05uaElMOG1CeTNm?=
 =?utf-8?B?Qk9YSVY0dzVMY3ErTEVEU01MVU10bzJhVklFVk9UZmJBRlVJYTVJY1ZKbUpa?=
 =?utf-8?B?d0UzMG45ZUtac0ozWHdyZXRRdkp6c0Zidm5ZTFNKOXpVSGpXWDhIR2YxNVNT?=
 =?utf-8?B?cjV1b1p0UU4vbFJsOXNsYzhvR1UvVDQ0ci9qQ0s2Tk5oc2poT2pwMk1EMmVq?=
 =?utf-8?B?V3Nzb2pXQzFGMENicnA2THNVZFpDU1REZU5nM0NuUVVvVEZmam1MMmxQOWlV?=
 =?utf-8?B?TVBwTnFxdmowejd1YU54Mkx4Q2x3YXBQTmVlT2M4aW9FNVp5SHEvczUxMm4x?=
 =?utf-8?B?Z3cwdk9Da1BxbjBhYllOWlZsaEhic0d2Q0lhdEEyWG1CWXVXWGRXVERUSGla?=
 =?utf-8?Q?6yX/XjoW03aV+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elc3Z0ZUNHFsQ05HUDBGY3llWWd4Z1FJb2dBeFlzd01pN3FjQTdINFp3MENC?=
 =?utf-8?B?akVwekRiSk9DWnBZelYrQVZzTkw4aVR1a0k3UTVzclNzaVZTNk1ibXpBYnFy?=
 =?utf-8?B?bDFKNjdEZzVkbFdxRGRYTGd0R044WTRpRUhNMFg3clJ1MWpqRWhNVWFhNXdo?=
 =?utf-8?B?Z0FtWDRzSjRSLzlNSUFGazI2K2pDUGR0K2toN2pBTVVhTkJOWms5T0I2NjNM?=
 =?utf-8?B?QklwMnk2K0tUbE9RT1BLeXBsSXpIS2lxZ1BteE9VM0NsLzRuelA4cDI5V2hh?=
 =?utf-8?B?TGhhRzI2cXZrSDBVbE52OWloTGh1VnFuS0FJdkwxZnZMcVlyWmNDd0U5T3p4?=
 =?utf-8?B?YUJNaWxKTGkwRW1SOUxxRHI2MDRKYUtDYlovV1BnR0FuODk3VnNFb2JFclJw?=
 =?utf-8?B?MXVOVjZwajhoZm9CdG5EQ3lqZzIxZ2ZNdU1pSkEyZVdtTUdrV0I4VFRGRWxM?=
 =?utf-8?B?N0FleUQ3M0YyQTlIUXZiaDN2ZjV0MVc1cy83R2ZlcUdwQnc2ajVLdm5pc1ZI?=
 =?utf-8?B?WXdOK0NrSVBEQm1oNlU2cEFYSmxBcVNGbTBpYXZqbWN3VTZWYWswWDdTY1dG?=
 =?utf-8?B?Z2dXcDVnQ3BnU3owNHdxaW1WMFp4MS8wOXlYcTZWZEpIMTZ3cmhWYlZzcE5F?=
 =?utf-8?B?SzhQTTlyR3hMVUdMN0NXSFBXNGdXODZWazlCWmVaSGZDdlc4VTEzVUNWNlFw?=
 =?utf-8?B?VnRzWXYwbGxCLzBTa3A4UDk0WjdSQWNFb2NmYXVrRTZGUEYrM2w4QzEzMzh1?=
 =?utf-8?B?ei9oTUdvdVR3bFRCWk1RODRLTEF1cUtJeEdJVGNkYWpxZ0d0RDN3WEdnQ3lj?=
 =?utf-8?B?MnZTMWVrN1c2all3MWJVOC85Wmt5N2VSZlJKaUpBVDJIOUxneVhBQVFOT21L?=
 =?utf-8?B?cWVYdDJWem5HY3VnTVFocjhIcUdpQkprVTI1OU1rNElxSUVhOHpGdXdOMm5a?=
 =?utf-8?B?RDlDcjdPc0VZQWlLMU1zY2kvNFNpd0c1NjF6ektxNlBNY2xvNmwzekhGQ1pQ?=
 =?utf-8?B?aXJtZVZ0NzZ4N1lRbVRxQ3ZMS3I1Nnc3VkFtSVRwNjF1WWw3dFViU2E4M2to?=
 =?utf-8?B?Qmw3V2RFWGJkTUFvQlhsMUtQR0VrREorQkNhSTZhZEl3Mmp2TnRaczNPTHhh?=
 =?utf-8?B?NHpzTlpyTVB0T0dreWpxZ2pMdFpzMGtnWlRUWFNVNHJiM0M3dktpZWloTk5M?=
 =?utf-8?B?ZGhFY09UWE9iTnZ1RlZUQ09XUU01aXJYUjRkWHdkbG9UY2pjNm1pazk2YXdw?=
 =?utf-8?B?MFdzaTlFS1RPZTFUZnFnZGNFbTdmOVhxQTdLYjQ2TFdhaUk1YUN6T0ZOZEo5?=
 =?utf-8?B?S3pZVnJva0VqanRjdHEwTmx3Rlo3d3BMVjFzcms5czlnT1dFV05IU3Rkek9s?=
 =?utf-8?B?cXJUZ1NPSURoMk13Tmd6Y2QyU2Rjd2RmelUxRW44bDhtajVmTUxLTkp4VEFX?=
 =?utf-8?B?OGZQVVQraDVRTXpoMHVQaFk0Yk9DQ3VPcEF0TmJxMk9ObGpmQVFnK09jRVZ3?=
 =?utf-8?B?RmhtNEdhNGN2d2QvK2pnM0JyL0xrTC9INitESlNzR24weFF2UEc3WFNQeFQx?=
 =?utf-8?B?YldtSXJCaFEzeFpMU05nNk15c01xY2puR1Rxc1lXODFJdEtueEp2c0gwYjV6?=
 =?utf-8?B?VzNyeVpoWG9scHpJV0NxQWlRdFhKR2Z3bkk2L253Vmoyckg4SHBJbUJiZmR2?=
 =?utf-8?B?eWkwbUNyZlRJa3ozcFpRSU4ydnBqQ0FJOHRNSXZUcXlPOFdBazNNZUpob01V?=
 =?utf-8?B?cll4RmFZYUhGOUdYMHllejZtb2tWeDQ4b2huY3NJaHZTY1FXR1ZjSEFxRmYy?=
 =?utf-8?B?aEtUdVpuSmxLSnFlZVVlZ01jL1FVNVE0dUlhR1pmM1Q1U0VkY1B2eFliZC9S?=
 =?utf-8?B?U0syOXA3Q0pjMHNPSFViTm40SEhpSVlaUk95emd6dE1XYzVYVUdPSG5HajBS?=
 =?utf-8?B?T2k0ellRdUdmVlNQSkRRZ0h4My9jRW5PQS9MamxvaTlOck8vd2cyanBtM0hU?=
 =?utf-8?B?Y1FkaEhHSjVsdHlzTlFCK2dmZXFvNTRFTHE5V3Y0SnQzMWdGYW9RZ1hqeERl?=
 =?utf-8?B?MVFsYlV6R3JkSmhid3VsYUFPMmVMaGpveG02aFRiOUd5ZUxaYXJxaUZyYnRC?=
 =?utf-8?B?dEhzbUxsMEdQMGZta1lMQmJuMkpKVGJNZmthTFVkdzFmRCtEclNCZkR4bHRO?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ae434c-b576-4422-9474-08dd707214c8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 16:35:43.7409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mr6+NXJDaRXh97d1oMdnFyjae0wX1571zqE8ptOBNAAmfYMDuCYUyNi45AhYpluPzcx4T+22EkJaz7XjK5UfLmuSdbaqdTMRZKGsHvDv0hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7091
X-OriginatorOrg: intel.com

From: Toke Høiland-Jørgensen <toke@redhat.com>
Date: Fri, 28 Mar 2025 13:19:09 +0100

> When enabling DMA mapping in page_pool, pages are kept DMA mapped until
> they are released from the pool, to avoid the overhead of re-mapping the
> pages every time they are used. This causes resource leaks and/or
> crashes when there are pages still outstanding while the device is torn
> down, because page_pool will attempt an unmap through a non-existent DMA
> device on the subsequent page return.

[...]

> @@ -173,10 +212,10 @@ struct page_pool {
>  	int cpuid;
>  	u32 pages_state_hold_cnt;
>  
> -	bool has_init_callback:1;	/* slow::init_callback is set */
> +	bool dma_sync;			/* Perform DMA sync for device */

Have you seen my comment under v3 (sorry but I missed that there was v4
already)? Can't we just test the bit atomically?

>  	bool dma_map:1;			/* Perform DMA mapping */
> -	bool dma_sync:1;		/* Perform DMA sync for device */
>  	bool dma_sync_for_cpu:1;	/* Perform DMA sync for cpu */
> +	bool has_init_callback:1;	/* slow::init_callback is set */

Thanks,
Olek

