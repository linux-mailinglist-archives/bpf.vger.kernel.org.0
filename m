Return-Path: <bpf+bounces-53553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D34A564E4
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 11:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C7F3AA003
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 10:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6858620E006;
	Fri,  7 Mar 2025 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8z1qYrx"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DB516DED0;
	Fri,  7 Mar 2025 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342576; cv=fail; b=JpobsTdLCyh++3S1QpcNmwBZu9jzCqCk5x1V4XFZUXxIbNwDREWZsiU9xY/+rdgNcTKQF8Ry/5H2IVsVmIrEtxdu1rLZZga2upwESMeHOf5FyhzdxiQEl8LjS+HQ+0g9tuKksD3jEgudMWyvhU5ccztS+L6UBqSnuP/LiTxTG5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342576; c=relaxed/simple;
	bh=8QWQrRS4Q8qPV6pK1jIF1UgjvAhI+0DgAijWZGStV1c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LMlg/T0S0yZM15EBmOcLq/35Kh/fFw6gdXj9LzboAl8s1x5zX2T7KMKZ1J9PeqTsdQBvMOAzH9EXN6Px++kLDwrQdiTdkVs6tiWZ4LAk7f+N3TSXBBi9hPQ02chgdN74tQgxPbfMcdkzFElRj4hnfYJLUkVPdT3jyMIIf1zIvhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8z1qYrx; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741342574; x=1772878574;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8QWQrRS4Q8qPV6pK1jIF1UgjvAhI+0DgAijWZGStV1c=;
  b=J8z1qYrx4km/O7Fw3RE1Pqv5aElncSwiJvTXqIMTDdHPB3L1iMCfl+i1
   YCWYjAEUYo67gYTMJjTks8aNbzCUF31VEUA1T4L4JT8I5N/GARj1Dl1qG
   WvhXNt0eNa4PVian7ZbEB6SMqbgXBMTFfu5Yi1Qc6RsfolOtK4zIjwgae
   +9h5pgxkhVezK+Mb0k5YYoovwr0rlUhTTYCQCa5FLr1YqmfD0kCrq3sOb
   IzBYfEKdIbHe3lAfesbB3M1i1OUPCTxHVN4Q1trAfRN0NoV/5Q8Sy6uEC
   nbmwx31OPz/mdwTfBWNj+aQg2gGmBNBlrcgL1T02cijXS1kl1I5XxwD+0
   A==;
X-CSE-ConnectionGUID: 254MWdZzSSac3oRms2nvBw==
X-CSE-MsgGUID: zMofrC+KSQOdhLmrxs+VUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42518179"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="42518179"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 02:16:13 -0800
X-CSE-ConnectionGUID: TivOzGr2RxKGgV5Oh8DIoQ==
X-CSE-MsgGUID: WXlGiQY4SHKrprawclJqXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="119458982"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 02:16:11 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 02:16:10 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 02:16:10 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 02:16:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8e3IIUqGkW21Fs59Q4Lc5U7qo4nnAUvZsmTA9iUI7BqerJS1YdY0h45aXddzdBtThfIHeqSNTnYl75rSJQz6RCLt6e5Wc2AVip5YOEbvSqkl0ebPxzKtuyND/wsk6Vw03dBfx8dXJhqw1a05U7v4lu6w+bgNKdDXD6CdyIQX2J2fgygKu9qYo73kIlenAoLw0QLsTpO9xaPaHVbzu26ThgeTongFunHYapCDmSRv8764rPXXwOttgCScojvrOQkYD6ajOuo4xpDTtzn7x2zgx6Za/R2qQS/isnenxzA8gehGeuR81ZA8xppGpu5D2B7FB1vforOZ6iz+s1W+zakRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpdyrmaIhwSpZUzGcCZPSu6uIuCRLPTA4yOzkDvMaWY=;
 b=PGq66HMzQy5idGkTasrhyeSXDEVybz2pjdwi+i3fZ1WZLDrTjMelTsfV+2Egx7Tn+eO+XBJWL5yWGgoa/ArCxL/CGptVkVp+pU/qLEeiD5Tsaogq5tYesudc5QW0jJM4z7o1qpzqxUUTlodoU4jiNP4XLAbaS0QvGwv2dFXiAhA8ohibIsVvyrBnTO1behS6eVVr4pNZ0UrxWyMK52qmWBftX7WuyUyyRL04j87LkBYyaLKkjyve5u6VIHObnISbw3AAe2V79YBYKDXFmPE9PqBcGmC3crMFye/uhM7bEm3YzCGnjDvNzR3NlW5izxISP1pe1YINuY1EGJwf5SkTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY5PR11MB6163.namprd11.prod.outlook.com (2603:10b6:930:28::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Fri, 7 Mar 2025 10:16:08 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 10:16:08 +0000
Date: Fri, 7 Mar 2025 11:15:56 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Michal Kubiak
	<michal.kubiak@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 04/16] libeth: add XSk helpers
Message-ID: <Z8rHXMzaMowRSv2m@boxer>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-5-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250305162132.1106080-5-aleksander.lobakin@intel.com>
X-ClientProxiedBy: ZR2P278CA0006.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY5PR11MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: dee415a1-7ce9-4784-92b9-08dd5d6113b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H+M41cZmXx0bVKBVBafcP7YuM52CMIrA5MNhJ5WNfgTuqATT9iVrO/yrQ7jJ?=
 =?us-ascii?Q?ZYY7QtwUfP9WqMySruBl9FH4k9ld2eqhk3Fq0/v+PyIQLZpm20xtktp121K1?=
 =?us-ascii?Q?88rJdabXUU96HPtmn+5Rk5jcl6LdO3Pr8C5JVAPaBcxi3v5oQJO+Jb6xfCfG?=
 =?us-ascii?Q?vb8cW+9L0r/YESnGO2/W8fOHZF5MqNEeQfCBs++qi6oeYYM+eDwOBZ0oqkPW?=
 =?us-ascii?Q?1JwwqN5G+a0CI/moo2dNvQOKDDwhdUqAMT8c3hn1sJU0Sd1m6mSGNKXO5rM/?=
 =?us-ascii?Q?5OCji9p1bDnu0mqqMfQXqS8DNvWyXh4iZVeullxYYh/B50NVOukOJ8uR96TB?=
 =?us-ascii?Q?bQ8QLoUYBsJHxE3pWCSlwNlH5daGHgHuUB6LIsaqCtjQNF/e1GfRP7JRdKBJ?=
 =?us-ascii?Q?xcrEk0KlAQ6fGYl20PdTO4WTRcYObKMehCQ9FbJu4e5AkHmGtqehMemXggmB?=
 =?us-ascii?Q?pu/RGICVfJvELyQS/9Q2LIexcR/C8/+BC69AZjpxERfgjkSSN/AuIw0QEgPZ?=
 =?us-ascii?Q?X/IxyEIsjVCMP9zI9QaKpefS9iknINfvg/LOxWOPQLOoVJBH4H0a0ETo8wSc?=
 =?us-ascii?Q?aCFWBU7dk6hykhXpPUEnG1bFK/VHe8ci864s5bek6rykvHGW1gwQD9tLK54A?=
 =?us-ascii?Q?KKw4tm28MUsDhTeNbotAvzzhTZI33o4jaBF7cbVjtFbcFPJ+CEid16X+KgtH?=
 =?us-ascii?Q?+Bic3MdxJFaxIWKlrWsduYqJmMU0fQ+2+/FwQWeit7OkzaNmgtLMoFBkDQS5?=
 =?us-ascii?Q?grb0yMxiVb7NesYyjwf+8XKFM2HacDOS6xFc9XLgqmMetts4PIv6d7aU5UtX?=
 =?us-ascii?Q?7+OoAOgNQEg02hRRkKs09KoNh74hXshC6qLx7L65zRcngfkhdtcB4KMUMspr?=
 =?us-ascii?Q?K9llU4uWwDgiqWMqG+Kv0rBrCb9eV1rF+OKXSzEDIZ+ILSLtSNyPGGon46FG?=
 =?us-ascii?Q?9WcNJvCc08m+c1aqOZJb+G8fdyRe+7oKd2Md6KjVceuF91mlOdkfCKb6AcT7?=
 =?us-ascii?Q?xFJ/sIg0OqquTu8taajEbsBLo01uvL3dKe5vHNke8UV4C4JfLHMQu6PMQ1HM?=
 =?us-ascii?Q?9WnglU64fSriUo6RVol27JfwZ+D+EcVJia99Gmtk1SNCtw8rbksnkBJ/GWHS?=
 =?us-ascii?Q?GI7FDfatcrgsQPZ5pys6Pu+HzTCYT58n65oWn+OsqvqAzX5wgCVDDN8KNOVs?=
 =?us-ascii?Q?3lDuNnSYvIqnawXa9sq6Jxt3Uj9Kudb/yTohd2jyqql+/xs7420rMn4wYC+d?=
 =?us-ascii?Q?BDpdQFRjoNVGQ25i1T0JXACBWAfbcjeYMFbxKvPbpGpBRfa7ZQxsqm2ZrY3u?=
 =?us-ascii?Q?GYSCSYXCxLlwMGWvZd0ffu76vhNiuKiqVy4jVjcXnEtVnY2UhW6Tr+8zgAEg?=
 =?us-ascii?Q?5K+88IQoMDkUq4IY7bddcXvnki0V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oGAbc0A0aySKVz7JXOJn0plRbJhFqS/s/tz26YngpM5aJwD51sQj8gjIhjRX?=
 =?us-ascii?Q?ytH1kLv2Aavfqc/1eeD6y+gceXHIDSxGqJwTsE9YuOxxUePgInqT/3uvCuH/?=
 =?us-ascii?Q?b2/R5wztc0qYSWBypeWx4Wd56a701DAdGODP+GqvHUpH3r6AjKbxNx1TC6/u?=
 =?us-ascii?Q?/giR9K8JCSiG/enVfZfKTh4sCQE1QFbpj1di02jZBocwhYPPpbuk6IMeMVC4?=
 =?us-ascii?Q?5s6i0ObUPUhfsFWGZCyLRWQRXSRl/+g51ro6he8braVb2AYSabq0uuFo2yvA?=
 =?us-ascii?Q?k2hndSKgrRhmaz1kwc79nwoS7+pVCKs2ziI8zbo/KwgBNEZRqzKu/sSppkD6?=
 =?us-ascii?Q?kxOvCyO0cFnymcfsjrrT1Nqr0xfKov+1aloc+Rp3eif9G2BKvQlwhoy+TA0E?=
 =?us-ascii?Q?MjvuRDdRl0M8O7B+5FpGtz5TmZGw5xpsoqyYcZE7NnXqihT3rtgCCD06ftAg?=
 =?us-ascii?Q?hLqkGm6pPXedaQGHutMUQ6/Xzcr3wqP374eDrnTnhjAd+d+iV18A2Z/CnGFX?=
 =?us-ascii?Q?bh8VPSBhaZS3eU7phZfTprEtEZu7sYVFAarE9a7AVU3LL4eu2rzt6+zWJQJC?=
 =?us-ascii?Q?Urj6oVSX+yKfKARQ/QBtn1iEXwidtouZ6Q6VvW8mYF95ypCSRAUeDoqmQZLN?=
 =?us-ascii?Q?BPsZN3h+VVZ9CPqvwkVagIvjZbxfE5DdkjPPl1t2eHpFhGGWWyDb9zeflzr7?=
 =?us-ascii?Q?sVJgxtKAtx02Tb88X9GfN1v1lJSk67uPocvO7u5fmX6ZCrqkIzaJFKbSCp7a?=
 =?us-ascii?Q?3XIQsNNgIMP4AVuMx5eljcET1dsBOop2UZEXxzjDnkSnC90Ox7EezUt3h7fy?=
 =?us-ascii?Q?CqIrpwvG/spdrHrvsP4vwl+UNh1+ht20B7flbhI1VmVBrHFRs4g0ZhTlLgFG?=
 =?us-ascii?Q?H+3VVobCgFLMPK1Y0qEwXbm1yvol9GmzdntnTU1pCoUGx4JlY0szZyBdvXtB?=
 =?us-ascii?Q?VCE2ITaWudmQtSbsgjAKnWgMLGHoFh8VUGQy0UpVDhSgYa4Gg65fzYk4KbDh?=
 =?us-ascii?Q?9Y2XmSfwD9xsb6TqHWMctKLddvHxNNK7pps2+UR+VqKHUSajOKcmvG1xxo+E?=
 =?us-ascii?Q?Y2LDswqLDviWjbdjtxvXQX+AnVeepnWIEcblo8PSjb4QD/+XnFiK7FtKuNF4?=
 =?us-ascii?Q?how+6uAwtHKaKqRAr/vFt33kHOrYIzrLzUQtYn1cLpZBDDob3/s0i6mYibuX?=
 =?us-ascii?Q?w8uSDMKh+miq65rsemGDt3UkCWleNUa8iJh7HhxhQubWtXhiB6Q6cFMrQ2Xl?=
 =?us-ascii?Q?XYbVVLjksYs7LAsG1H3K4ehja9uAD4LSIdJAb5a6hBgdDRK/09trJ3nOC2by?=
 =?us-ascii?Q?eq3tJKdK7Y/b1ihzUqvAMiCL6kqUASQb6HBlTKzZQtpdxZ9yaj93irBzaj3t?=
 =?us-ascii?Q?q7Hps9vKTRBZSzFcrP2iWZ/G0Mo31QUnnHOFjTitLURuet4AvcC6WL16Llef?=
 =?us-ascii?Q?fgO2LVKqvHpKkFnP2jEAHZUmv1aaqQ1fDfcpeoZ8RyGsBLaTQGVmFW34VPuu?=
 =?us-ascii?Q?URBNqF9u3ul0qrQw8WGhvJsNf2GyEARrHwNDqHjXnDDxhTiYw0EXzVLa2Xvs?=
 =?us-ascii?Q?ONzdZ5+qhJyzSr713ZN8GOxv/vI1LJUkXb1OTGU6l0gFeADuAHvaTpZCqu/w?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dee415a1-7ce9-4784-92b9-08dd5d6113b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 10:16:08.1520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOBTIFCHSiDZ76bxX/YwdbMpkNU/+6KiAy5JXpeWTm2yOcHU5EseYahBw55UVvPfSOWL3T2nOkC2ByMLaGYHSmPO4FxTA/frXe5M6DggABc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6163
X-OriginatorOrg: intel.com

On Wed, Mar 05, 2025 at 05:21:20PM +0100, Alexander Lobakin wrote:
> Add the following counterparts of functions from libeth_xdp which need
> special care on XSk path:
> 
> * building &xdp_buff (head and frags);
> * running XDP prog and managing all possible verdicts;
> * xmit (with S/G and metadata support);
> * wakeup via CSD/IPI;
> * FQ init/deinit and refilling.
> 
> Xmit by default unrolls loops by 8 when filling Tx DMA descriptors.
> XDP_REDIRECT verdict is considered default/likely(). Rx frags are
> considered unlikely().
> It is assumed that Tx/completion queues are not mapped to any
> interrupts, thus we clean them only when needed (=> 3/4 of
> descriptors is busy) and keep need_wakeup set.
> IPI for XSk wakeup showed better performance than triggering an SW
> NIC interrupt, though it doesn't respect NIC's interrupt affinity.

Maybe introduce this with xsk support on idpf (i suppose when set after
this one) ?

Otherwise, what is the reason to have this included? I didn't check
in-depth if there are any functions used from this patch on drivers side.

> 
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # lots of stuff
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/libeth/Kconfig  |   2 +-
>  drivers/net/ethernet/intel/libeth/Makefile |   1 +
>  drivers/net/ethernet/intel/libeth/priv.h   |  11 +
>  include/net/libeth/tx.h                    |  10 +-
>  include/net/libeth/xdp.h                   |  90 ++-
>  include/net/libeth/xsk.h                   | 685 +++++++++++++++++++++
>  drivers/net/ethernet/intel/libeth/tx.c     |   5 +-
>  drivers/net/ethernet/intel/libeth/xdp.c    |  26 +-
>  drivers/net/ethernet/intel/libeth/xsk.c    | 269 ++++++++
>  9 files changed, 1067 insertions(+), 32 deletions(-)
>  create mode 100644 include/net/libeth/xsk.h
>  create mode 100644 drivers/net/ethernet/intel/libeth/xsk.c
> 

(...)

