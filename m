Return-Path: <bpf+bounces-42295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A8E9A20FA
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 13:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171272832B7
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 11:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32B91D517C;
	Thu, 17 Oct 2024 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nw72tAQ/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AB9134A8;
	Thu, 17 Oct 2024 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729164744; cv=fail; b=nh1/t5kdXg5C4xSF5ly5qLpm43xCJvjsKUw2BmBqDOtTQL7Dm0r96BqLvE4LIIcwnDFaoEc8BrWMUOBX8S2mP/nyu5h++cW8cQipYhWbkIQgBIWtVZCwLrH2EsPCCArCr9SIoubmjAZONRci4wE4QheZzEnoFwvepskOWtxTwuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729164744; c=relaxed/simple;
	bh=hTuKHNERsSLQUoYmC0ykC8fyg3+xl0XOs5oF+8YSg9U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DO17bLSgWDFB0yrBZEOoKlws6rcxxVbPZe5FjIpxl6BrdO6tO0M0HcJvT1jFjwPxO7UBHJoeA1MqDx6W6OF824N0/07yO28u1w3hB5Y7/5sAUKihIKcplDJSG0mS2BBms0hBVw+AOxSDK0M8+obsdtSwWgvcquonnP9f1jVWtPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nw72tAQ/; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729164742; x=1760700742;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=hTuKHNERsSLQUoYmC0ykC8fyg3+xl0XOs5oF+8YSg9U=;
  b=Nw72tAQ/D3EGgHZD8yU+a5UuzNLIvbYY7CbkRMllOubjQNSFeN4tIN1A
   6LQOD4KIWLkadnTtRjhzPX4VE0CRcZXMhCQIabXSKzrjOxOiZ331GOLwh
   nP7F0G9PIfWyC5E44VxuziVf8hKxw57ZKUgF8Tv1FXi3gnXtPdHCa/ai6
   z5dg04TrUJreZiTLIJH0j29y2LCTXDe3YVra6D4kodgxZwqyfzGhGfI/J
   cvS8rFA68MuEOlFtAoPwH3kuDpE7TjixCWkdFkobXvMOvb1junV+7DGH4
   eJCi2+LSBamCQ8DAt/hWBmDiQ6S7bAWOtOUXgmlClDE1IijfTsG9pmmNo
   Q==;
X-CSE-ConnectionGUID: MX/Uj/MjT6ip1F3dGkDiiw==
X-CSE-MsgGUID: RQ2xhLV3S1S2VeSP0L3DcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32330447"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32330447"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 04:32:21 -0700
X-CSE-ConnectionGUID: 1uRv30pnTKqAvVSa3Kh9Tw==
X-CSE-MsgGUID: 4edgkiImSUC9gFSiM1IwDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78560723"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 04:32:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 04:32:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 04:32:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 04:32:19 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 04:32:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/kZAupyV6kMphBR1wCWtFOD+dG5o4NmAiHDnqqfPjYG5CEV38ra3C1i4UiFUyZ1dC4CY7aBkJvTDBWh5gZooGvdb+BeQLf2NB3qwQtmVrti9EXbwN/QjQdQ2OYuxEhYMbf0I4Ted/tMqDSJz7sa6zEwKzvNAqzQUqV6JWBBsEjeoqtjyY3py+3cQEfgD2opAYFe+rHGGcZkOvIvNOwJx1ClHgwP3LNjJyc240rlmkJsKnH5a3bbsaOJCWxXq7j7qVlNLY6+8SAo4zz5jw9kIwpsXUXlsam15lqABPGRfutJXdv9zd4ouEGwM2Zll/kyi0QzR3IZPQzztcoNI3noww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/i1HN0VaqteQupCQbgBQv7kpNzWCq6LPrLOWA38RQBQ=;
 b=V6ill74J7cpM2wG3HS6SGIoNsTjwXRhsfzwmV1djAhxW6eoh2CQIih97+PMomsKI22MQUSE9StMeoEZbJzV3CDSTFuviZKFxB9J/lDJaae8CXe49AeaRyhWpJS00e8pxsDKBSteDpN2fQYtJYv6xapIEaX8SOdROlpC7LPHvePNI8Crr9MZzalugKc9c+A7dSHY/akmTmM+w1FJSR1OMeI6osS10bXzmwbDYXTerXQh3IbMASE0pCIPf+C+bApPqeBQgQ+zIy56P5QptYKsv4wNUsIGBxC8sBqvGRLn/9A+QrrbIY4tScs+ZIy29Urf73bepzDdaOqlYC7lcprHHKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB4774.namprd11.prod.outlook.com (2603:10b6:510:40::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.18; Thu, 17 Oct 2024 11:32:16 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 11:32:16 +0000
Date: Thu, 17 Oct 2024 13:32:03 +0200
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
Subject: Re: [PATCH net-next v2 07/18] net: Register system page pool as an
 XDP memory model
Message-ID: <ZxD1s0UOJy11wt55@boxer>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
 <20241015145350.4077765-8-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241015145350.4077765-8-aleksander.lobakin@intel.com>
X-ClientProxiedBy: WA2P291CA0039.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::25) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB4774:EE_
X-MS-Office365-Filtering-Correlation-Id: 350a8c36-6843-406d-6f97-08dcee9f5a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?AV6ube+Vq5JMYBVPuvkVznLER0L89ozaPGT5piv68NEWSe49jHYH1wo1Ui?=
 =?iso-8859-1?Q?Wc4H0jzhD+uk9GlO3bLRMy7QLsAUFP0n7tlLcuFjbsWMIa9rbJt8DkdBzU?=
 =?iso-8859-1?Q?+MDwtlmK43ZRUi/oeFFnVBMJ8h0n+HFLef8KSXv8PcxvMLBJA77xmltI8C?=
 =?iso-8859-1?Q?a7y3VANP+H9E3u0oMLBIrfQOuXxXsjcbQgLTcIPuvFipSez6iiOemgTSfK?=
 =?iso-8859-1?Q?nr2aNhJKEoPCxTFSF3t7RWlLTH/nkLue4f3j4eiMJ17SdNsm7BNXrMizCX?=
 =?iso-8859-1?Q?w3T7pSowcrZSLL1C7BA7pvKUP04tdUKZ4hCvf9QJgE6VxkWxrcR00IbvUq?=
 =?iso-8859-1?Q?a69UdRDoVHRMqxaDk9/LRndsCSNri1uQZv3ycxfV58+EnXCbbXwu5ugTJJ?=
 =?iso-8859-1?Q?orDkwv6VqFlNm7mIswdNBRVDoxyGVQT0JmgM8U8/O0Y1s9Ki8zv/RHyh1m?=
 =?iso-8859-1?Q?Wzn88w47o/QwMgEILHAuXzP7RGJUxVyAzdB1uQCvQYslqYpAyYqH1oy+Dy?=
 =?iso-8859-1?Q?TT3EO0pIzviZ3OmNNoHRUnnBEZzTAMF/aAyNYJb6LOC8A8xqL8E8GqsABT?=
 =?iso-8859-1?Q?axA2FO2S+HKkUP0adrDqRK+0Urs9sba6lZYWC+Gnef4DChGBz3SiC+Xyxm?=
 =?iso-8859-1?Q?xlbRAK0V5cFx7ECsvutA5O9PBGVK8OiTJpMwEzf3vkGwIYb/T2f6RxMilx?=
 =?iso-8859-1?Q?uakmmGic+Z/+UgK/Zctb7gntVqE/NqRUcSsOxGOpt5/9LkGV6CquuoOti0?=
 =?iso-8859-1?Q?+qE4CSd+tlI49wYUd9O6+UVzM0Zp2DsSqRhZ0l1DLEX/zNH9ky4Lj7B80g?=
 =?iso-8859-1?Q?mDh/onRptgNJIBal5nzw1LpZkQ0+jtNKSzkVNiEtX5esfTB8MIkkEJdMDa?=
 =?iso-8859-1?Q?YnoEKrhk3p0uAxdosBLjhi9QH6/mvY56gbjNNB7or6gAA7qe+/qQpxU5M0?=
 =?iso-8859-1?Q?uvLJkPDwMea9okfdNK7NGIBxGKrEgOjj1PqIvAbartM2v4tC7GSaCqWLpj?=
 =?iso-8859-1?Q?n4WDarsbTAoQmenJyxtR2Rt/5brRziRbdB9jNUttjognTyJRUDG2hc55xt?=
 =?iso-8859-1?Q?wUf1f2v6KkZP5bbU9bNDVF/EgiJBvzLxxbFKJ2r+cqL+CrnurCW8zl/MbO?=
 =?iso-8859-1?Q?YEYgPb+c6OSy9FRTyWIgBHmGYmG6U0nVABmqzp2Z4XEFoYtQgYKPW9oqWp?=
 =?iso-8859-1?Q?tr0tX536HNcl9pvl3PAbtqzJyV9jED3zzikj5TReZo+Kc2ycujjwn7sUsk?=
 =?iso-8859-1?Q?8Jk/IFUldtblSvAsbN6j6PBtwBTFJ0R1+UwdjmFh82Nydsl2AKw/7CocWd?=
 =?iso-8859-1?Q?wHe0cn3PSWQ0cE6yCwEJXsgA7hylPLS4wJ4b36ywCZoViMmcxO53ZIIeRy?=
 =?iso-8859-1?Q?qBOgXcP3ms?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?rpRdISLvZQkvViNqCLiBR1Pf2ioWMAy7Kx2aWp4WP37cq/208G7elTnltK?=
 =?iso-8859-1?Q?qR/EOAsqXkzmudSrD+zYRsXR2zjg8eyF7HtsmDnYIIM2CDHRoXHdgLgClm?=
 =?iso-8859-1?Q?5Y4v7HLyo++emXHFW4POm64wZkrpazwcamtK/Xyk7/UYHmU1Ys09QqE3h6?=
 =?iso-8859-1?Q?/XR/YBhF3g0LVV4cG9ROqe7ENAXJLOQxvQi0IOYGcRUkwXGIrYAKBe6y7g?=
 =?iso-8859-1?Q?GnqjUvFVAqhAWhSYl1JHHOwzuWjmNt7wyLszt6y51kkUWp/mywJqt+HhjF?=
 =?iso-8859-1?Q?pXyGKFS0wIgqgJWtmf5Pfm6pGwgSrxlKKapI5aRF9COVgoimftV0VxLNL/?=
 =?iso-8859-1?Q?flAQby/XEMnVOifSyNVV7dVdtDW8VU9hgq5DWvBbhjaD6YcUMuFbZHFPgh?=
 =?iso-8859-1?Q?AsqHrMtL+FNezpprlRvW5tIGbdrVP4LDlWqpCBu8jGbGtSX72ef/a2PIsg?=
 =?iso-8859-1?Q?WsXevye27NvGX6HFDmKUGSJBclHttYhvlYBWeod2FB5jjFPU1IPSR75zBY?=
 =?iso-8859-1?Q?TKllmGhpljETbzQpSPTEAWas9FiuHnw/hJu+j3+4MPCjaBB6kyk38GBECv?=
 =?iso-8859-1?Q?kXTKkwJlna3z8zCN/d52kNpfgCCrlX0tbUEqqAX5+77ZnQUIyeSHWVatup?=
 =?iso-8859-1?Q?GXnFOT0eWy0mjAKbqVlD7muEgkDFJBIiEFztbp89Db0iJyXo7sdQMx/abG?=
 =?iso-8859-1?Q?mrlHP2E3ffkyhoAHZiVvQNbY67sC0Lvkgke/KdPJ54uBnzxuLbVyG8IbnD?=
 =?iso-8859-1?Q?WBKoIWMEZhe3oxrkqJ7pQGyK1YVFpwTc3HK2qkRTgIV70LoHea5udXHXNT?=
 =?iso-8859-1?Q?ZwTxRTWweDvMrbIGCDfv56PiKhuDNyzVohgCJIeEAuriEuEfJfzuFrba2V?=
 =?iso-8859-1?Q?ZsUquBxt8IRBLDXWHsZ8jXv02PDKQAA6U2VlDFoPav7EHOPbgxI1c9h7Q3?=
 =?iso-8859-1?Q?JDuqrQHK9CgEy97CS2ADbbNXAwpOl9JbVzjNUITVnOZW8firZCMhrGQjw2?=
 =?iso-8859-1?Q?JWPugkGtPDTfJ0VQjxDzBCZydl5o+rDXfuuoApbxHTwNZrKhpAamVVk6ZD?=
 =?iso-8859-1?Q?FBdA2mvfFnfzOWlDHjtmpMXNwikTjehhLBNc36j2rzUt9TfELHpIPsCesH?=
 =?iso-8859-1?Q?RioUVGmkLu9Sv+JPQYFOuqq4O26eZ1K4nFLSiWuUoJgOOQlM1Yu89AAEc9?=
 =?iso-8859-1?Q?/2gfrX0DhNM7q3blYa/eCBIjlLbQwGv7RC2OJOzC33DxsUxMZX9TyElRIz?=
 =?iso-8859-1?Q?FR+idr/gmVN2HOcT/lV8Q76AmPHZUApgtrFrw7zZ2VBoQiPMlITdLy0lQS?=
 =?iso-8859-1?Q?l1TiOra4n82Mp9IWxnCHsnS4gRV/Mh8C7TI3jM+IywgX3pJkeQz8RAM1Im?=
 =?iso-8859-1?Q?igWxLiE5HnyVaRt7J7SNW0Sg4/7Ig6w5BJml+KDt1Q/4VIwddhAzQ3s5MO?=
 =?iso-8859-1?Q?ZhHJbrn5HF1Ru0wJ4UVZclirzTG8qfa2x5ZSZ59Y2wszqGAIAvNE2J6qBI?=
 =?iso-8859-1?Q?juuC9Z9lu9Wn+Ky2gU/co9TRbuRyE2dc3lQz88P+gSQnSI7kCcmoxlSwf9?=
 =?iso-8859-1?Q?Ov2D4bMaI68vYCuuFYSrcekK+ZBzdsTq4GKRhUMi0CEgC/hKUt8cCqksf0?=
 =?iso-8859-1?Q?3UPTWWCPK08MdONYSoyzUlaJvT2SLZpsBrF9Cs7tdDS0qCiWhYEYsvhQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 350a8c36-6843-406d-6f97-08dcee9f5a67
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 11:32:16.4897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4CuQDKM1j8MJ6Y50tbHSi9uupO1yeNKDte95HeJXzPccMZNny/bs2IAbszS7Ky8SGeXlKmKF8T1NR17oRtizHsCGwNS9Egxdv4YYfblrMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4774
X-OriginatorOrg: intel.com

On Tue, Oct 15, 2024 at 04:53:39PM +0200, Alexander Lobakin wrote:
> From: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> To make the system page pool usable as a source for allocating XDP
> frames, we need to register it with xdp_reg_mem_model(), so that page
> return works correctly. This is done in preparation for using the system
> page pool for the XDP live frame mode in BPF_TEST_RUN; for the same
> reason, make the per-cpu variable non-static so we can access it from
> the test_run code as well.

Again, to me BPF_TEST_RUN has nothing to do with libeth/idpf XDP support
:<

> 
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/linux/netdevice.h |  1 +
>  net/core/dev.c            | 10 +++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 72f53e7610ec..692f21c28ea5 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3308,6 +3308,7 @@ struct softnet_data {
>  };
>  
>  DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
> +DECLARE_PER_CPU(struct page_pool *, system_page_pool);
>  
>  #ifndef CONFIG_PREEMPT_RT
>  static inline int dev_recursion_level(void)
> diff --git a/net/core/dev.c b/net/core/dev.c
> index b857abb5c0e9..773388f26d4f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -460,7 +460,7 @@ EXPORT_PER_CPU_SYMBOL(softnet_data);
>   * PP consumers must pay attention to run APIs in the appropriate context
>   * (e.g. NAPI context).
>   */
> -static DEFINE_PER_CPU(struct page_pool *, system_page_pool);
> +DEFINE_PER_CPU(struct page_pool *, system_page_pool);
>  
>  #ifdef CONFIG_LOCKDEP
>  /*
> @@ -12103,11 +12103,18 @@ static int net_page_pool_create(int cpuid)
>  		.nid = cpu_to_mem(cpuid),
>  	};
>  	struct page_pool *pp_ptr;
> +	int err;
>  
>  	pp_ptr = page_pool_create_percpu(&page_pool_params, cpuid);
>  	if (IS_ERR(pp_ptr))
>  		return -ENOMEM;
>  
> +	err = xdp_reg_page_pool(pp_ptr);
> +	if (err) {
> +		page_pool_destroy(pp_ptr);
> +		return err;
> +	}
> +
>  	per_cpu(system_page_pool, cpuid) = pp_ptr;
>  #endif
>  	return 0;
> @@ -12241,6 +12248,7 @@ static int __init net_dev_init(void)
>  			if (!pp_ptr)
>  				continue;
>  
> +			xdp_unreg_page_pool(pp_ptr);
>  			page_pool_destroy(pp_ptr);
>  			per_cpu(system_page_pool, i) = NULL;
>  		}
> -- 
> 2.46.2
> 

