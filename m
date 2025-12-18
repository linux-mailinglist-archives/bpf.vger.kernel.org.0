Return-Path: <bpf+bounces-76991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 421BBCCC390
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 15:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDEAC30D61ED
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 14:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31D134A77D;
	Thu, 18 Dec 2025 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/Jsw4+q"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6A334A3AE;
	Thu, 18 Dec 2025 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066642; cv=fail; b=si/xPKfCGKpYxVMvPFqwMCABieyrFQZJB/gma3/egIXN5A2k5RKSEUJ8zUSjjoq8xqsjP6cIf1D8xqt1n6/egs/CQOj0u7gjBSH6lEpsT4vq4EKRfLaMCdD2k+qDbnDX7C9dmPSTXTwtmlGD5AmQ4VaQ1frlZmNFiZRqqINIY7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066642; c=relaxed/simple;
	bh=LV2eLoESOOmegas+t1xBZcLRzjwa3hEznoWRaoJYusI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IxRaNtGvomVn/rawFU7PFKkgaZtpR/r8pUkKm5hbvaCNH0lDOjVcy8ur/ROVJeoHytxbt2a0CDBA8S35WFCQ9cJFT4O+XH1iPuA0I1xGQh+YC4c4tDKcuOy2+Nk1BeEzmPlSZj9iBZT95A2q+dMrVuBgAQ8zXwOlAIfjW3+eDEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/Jsw4+q; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766066640; x=1797602640;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LV2eLoESOOmegas+t1xBZcLRzjwa3hEznoWRaoJYusI=;
  b=V/Jsw4+qkmnLy0C9igI+N9oRM2vKAWz7VXV7bI5D9wsdT83NNppe+ELQ
   3q8C43tL1IVq8qu+vSwzeneQSa28OvS0IYNcvEHILNYd2qgjd1uflh1Y+
   3T98/BjLKCWW/DAz6ylFTgWekJ7SKbYwA0xeq6NgcUkF7aGYXFFM0SuI2
   c829V/1Mn/SRcLXD6G57OagBg3RGr05/jXR0ld04qaSaapjAaiQlNj+xS
   WNOzsj7tx3cs/E5FU4cyefcFOfYTKYHw66ofw7vqQfIyuypEeCD9m0FCk
   yODBlp3pU0c9g76zFV6qmmOYF8r+lnEGBwp/MTVi8X+s0V+CfJf12p2Bo
   w==;
X-CSE-ConnectionGUID: FCdNVh0NSdaPKUZLFR/VqA==
X-CSE-MsgGUID: F0poxxLVR4WcVcLxkvZ5Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="71879197"
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="71879197"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 06:04:00 -0800
X-CSE-ConnectionGUID: J0/lN9WmQp263uzmUR8RtQ==
X-CSE-MsgGUID: WqlKKoBuQaGI7uQo7lbkOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="221998366"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 06:03:59 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 06:03:59 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 18 Dec 2025 06:03:59 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 06:03:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCfc+RJz2km8usXmAMMyPMQnr9//VnSB1Wn7y4CxZNMTRHiSHg0icvXjOxcQbe4HsQP1VQ3vTvAIwrTN1/221s5knfKTztKU4z1+IDB0yyFxzXX521RMrtJ51GJPi4kUoXRVsE9FzG8mYmh+YcYUT/WQuiC0m66/9v7FvE84uhZJEZSZWwOTWsWSbs1cqnGfvVzFuJips77tT+o1iaje8Gl2eqSfGJkJsKgVJIqwnYY9szoYdpslhDYRzTNCbAGzcuJL3N/pzrdprMljWXdwrCsX344gf4vPQBGYrUpvH4KRD6rzqOYJs7vWZ7MNSkQ2EiSYmN5Q62hGHP9BwbEDBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvWrKWRhPN1+Ocb5hqqpIq7iPk2uJ/iymRT5vQHCWLQ=;
 b=YNQUF/vgfXg19Mtq84NF9FzHduTczA3SzCrwNLG07dCJ0o6aX2dLRvhIdDNYxeBmSt5uYPHOeXkk+5zDE33tHd4x+YEVvuZa0PnwdWhhVJp0xL/V8paM57pqyaSPQzRTfhnIjCbB49qJuUWRToxbYOBZ7jQ+HVtEuiEHumQYZSGU6vXBPsLz2XvFRm1JUqKzvF1csm4ddPRQv6bpF1+0UYPSUhzS/74tAB5R2e0vLdu+vS/IGYaF0DY6DAoJdKmW5lwEVPLGMeHAIZPVlCizdty9ctvDtk3siILcMtLs+bnwRNEtIJyrgczkhHEjOjbYjZ2Sz6FIhtnjKNBLn9SQLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MN0PR11MB6110.namprd11.prod.outlook.com (2603:10b6:208:3ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 14:03:55 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 14:03:55 +0000
Message-ID: <73ab2fb8-6676-4d56-a512-24891191940a@intel.com>
Date: Thu, 18 Dec 2025 15:02:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] idpf: export RX hardware timestamping
 information to XDP
To: Mina Almasry <almasrymina@google.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, YiFei Zhu <zhuyifei@google.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
	<intel-wired-lan@lists.osuosl.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>
References: <20251218022948.3288897-1-almasrymina@google.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251218022948.3288897-1-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0055.eurprd09.prod.outlook.com
 (2603:10a6:802:1::44) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MN0PR11MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: 16471549-0fc9-48cc-5489-08de3e3e47fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmlrd2ZHTjdvbVhlbUdLa0I2Szk4cTdtaytMZFM5c3U5ZHAySGFhVDBaSUh1?=
 =?utf-8?B?T3J0TFh5cFNyTHN5elAyR2xpUFBRTnptK1dSL1dKT2xyemx4empBS3pUZlJq?=
 =?utf-8?B?QTNYTVE2enUrZXhJOWQxNTNzeVVuM2hrTlZxMmVORHBTOTcwenY0Wm9weWJp?=
 =?utf-8?B?bGp6RVhneE82OGVUSmZhNzdJaG9vWkZROXRRYkZwRG56WDRaRGlOaUdmdUI1?=
 =?utf-8?B?SFpVMHdsSFdHU29jQjZiSnRXMzFFeTlzOWRlMlMrTTNhc1F5VFkyYnJLQlph?=
 =?utf-8?B?bDZLTEU4MVFwT0xPcXdiN2czN1FmdHFsZ0E0S0RXN2hpYjdPaHdrSy92eDFq?=
 =?utf-8?B?M0ROYVNraStyU0dLQXgybGgvM0R5UkpwOHlPa2xKM0p3R3QxaWJGSjg2MzVo?=
 =?utf-8?B?QS9rbUFsTmZYU1VVam9YbVppc3ZlaG9Ockx5UFU1M1FnNkVnNWtpeUpSazUz?=
 =?utf-8?B?a0I5cklPU3hScExjajBoNHdlbnNMd0tMQWhFQlFGYUk5eWpKT1RNSG5uNVow?=
 =?utf-8?B?ZXg3Y3kyZjBIaEloTE5KeTZCaWJsUVZ4MFpDU25HcjBXQ0xaQitITG1pNUk5?=
 =?utf-8?B?Q2F6cGJmc3RnL2dYdG1kMVE5RmFDQVMrSzlENi9lQzlUdkllaEFsMWx6M0to?=
 =?utf-8?B?WXhBK2J6L0lDREc5TmJiWnRQUStHc0pxaGpWZXJJTnh6N1lBSUhiSk1FNWYr?=
 =?utf-8?B?NHlNZmx0UzdkMHBBZ1poenpLY0VCbjhDZmRaeFRRNFlSQlRiVmJHSmJwQ1k5?=
 =?utf-8?B?a0JuenEzd0xtYy92NkJ0cUhOZkM5N0JESWhialprdGRJQmh1THpNU1BjQ0x6?=
 =?utf-8?B?NWpvL01ZQ2FJdkVTRkVhVDVQb1EyUTdvUjFCQkh6eDNMN2l0bngzMmkrREE5?=
 =?utf-8?B?YmU4dFZSbnpvYy90RUZCQS9uTU55eG80cGgycDRzblZFRGZzeS9pdno0bkpp?=
 =?utf-8?B?VmtnRDBxb2pSMkc2d3JNdEFsL0d5bDZnZkRRd053UnF4RmswRGRlazhQOTY1?=
 =?utf-8?B?RXA2TnNIdHNnRlJHaEhWMGJOeFV6SGN0NHpDdDIyc2x0R2JGeVEydHh5UDFw?=
 =?utf-8?B?MzZ3bXphbzlFVlZtUVF6WHBFczJGdlN3N1dtNVpYd3Y2MmNuNWN0eUZhdU9J?=
 =?utf-8?B?S2RseWNvblNHRUZFZDhUNmJVSzhrcnp3NFdjWjl5YSs0eCt4elNJMHV3aVNo?=
 =?utf-8?B?UG5aZGNWc0dLZ3UrMjlFQXJiN1VqZUtneTQwU2dZQzFlL3dzVU4zcWpJZko4?=
 =?utf-8?B?eFJKd3pyM00xNDJ6RytYN1VGMDcxaFg4ZGpnU0RRNlVNWThHUzhTN0pUZ0xG?=
 =?utf-8?B?VnNCcjdmdkw1UU9uNW15ZVR5aEdXa3JSY09uVExnNzZWbjd4M3hIODd6U1N4?=
 =?utf-8?B?aTFtZDBmS0gzNEVvZktEZTNiTTFaSUc4R2RReThNRW5SRE55QnBPSlBocEw0?=
 =?utf-8?B?UVVjcXdWQWVQU1loTnZ4TFpYUURrQTdiOWFNU1Zrc25DVVJqVTZPcUNzVk9o?=
 =?utf-8?B?aFNvcVE0ay84SUlVS0huVnhyMURVZHFoUjNTUjN2OVNzTG8yMVlvNWYzeFpO?=
 =?utf-8?B?cXZkSEVXM3R5UWs1enhPVUFrbHJzS3RNd0N6RitRYXdabithQW5XeG92OE1s?=
 =?utf-8?B?WTBFUitIRkFZMDRDdlNOQzRxUGpjcEQxVHIvWUlnY2V0NGdnditZTXM4a0ZY?=
 =?utf-8?B?KzZWZVBSUFRBMTNFMThaM3VCakxCdStuQStEaVpIN1lWT3p4dnZaM0pDbC8r?=
 =?utf-8?B?TDNWZEZRbkxTd0IxUHBQVGd1dE1JTVdMV2VyQU1ZbnpTSENiaXhleFBMSVp0?=
 =?utf-8?B?NFk1eHVuellobG5vVUYwelZKVDlJeUNWb0t3OHFYNkdSaTZHalo5ZlJFRU5Z?=
 =?utf-8?B?NnJlTHQyTWVJMGNvMFU4KzJ1aFhTQjVGaWtvWWl5OHNRQks1ckdZWlR5VnZP?=
 =?utf-8?B?a0N3Y2orZ0FzQzEzdmZJVnlRb2ZBN2owWUsremVNZDlqYnJSN21hWmIzNHdB?=
 =?utf-8?B?enNoNFRDM0dRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUc3WUlYNWpKT2FFemZpWERWU2RNWjdpV2RQZlpiTFpZWTFRNjV2T3U3eWFs?=
 =?utf-8?B?a0t1bzVYNjRCdEpSQVBQY0ZhaGlRNHU3ZW1ZQVB0cmhKb1p4WWJqSkFkZG9q?=
 =?utf-8?B?b2xsNU1PNWJaSkdCL25rSlIyZlpEUnB2b0xTQldSZE9QbEhySzZDTFVWWEFZ?=
 =?utf-8?B?TkhzWnk3a1JvS1R3L1JGMGZPcDh5Zi9LK0EvZUhWRGpNWHdUdnhJQkJzMXFq?=
 =?utf-8?B?VGxUR0FWZlkxZTZHSXdTZ1gwcTUzVG5nYkxBUmcwQUVTd0R1RWhTbGNYc2ow?=
 =?utf-8?B?TlF0b1RZNkJMeWZLY3dheUtIL0dkNncyNm5JWmhhUHFvZHdndGZlY3plNEhD?=
 =?utf-8?B?Snl0amp3UmJwSFpaRk54bU5iTUg2b084RUgxcTZVVDZrcm90RkFmUUlVSmx5?=
 =?utf-8?B?YmZiQXd3cDdPbjd5NlBhWVlCRzFNWXRiaFlXajRqT3FZQVNQSksydG5lZVpE?=
 =?utf-8?B?NEtXN2FGSml3Myt5VzFHVFBBZGxVUk1KNHh3RjdIaGVYUDNiMXNrMjk0NFkx?=
 =?utf-8?B?SWtCV04xbDduMWpPMzZJWmpTMjZ5bFhRUFd2VWNXeEJyTWR1SDMvZU0vbXJx?=
 =?utf-8?B?QmtTT1MvVzVrU3dwaXZwY29abEZzNnhhKzdLV1BBdjI1UzBuWEVvR3daREMz?=
 =?utf-8?B?dnU1VkQ2SzMyaEZ0M0xOR1lUZnNiTWlYUVZqK3ZtT1dkR1Y1aDZOMkExSm9Z?=
 =?utf-8?B?TUJQazNTUzFpUDhsKzNnc0tvcjRnbVhJZ3hvZXFvTWJwemduSVpiSlh2T0NH?=
 =?utf-8?B?V1N5ZXB1MGhHS1FZcUZRMVhVdEVDMEFuVXgrQ0FYb0hJYzlHUEo3dE1kSTY3?=
 =?utf-8?B?OEZvM0ZPb2xnTGRUWU12QW54RlRHcDdrUmRta2pyam1VeEQwRUlObkZDa3FW?=
 =?utf-8?B?ZlI2THR1ZWRkd2RpTkRBY1Bhb2VSMlBLaUZGczgyWUpJbmxRRHErZWs2Tktn?=
 =?utf-8?B?eC8ramFqRllrUjQyUEhwZ3pYK0RmcEpMOTZJamdXdUVlRTdheTFpTVV2cFVL?=
 =?utf-8?B?RUFyekM5d0dMVExzWnJrWnM2dzhyUURzK2hGV1Zud3pIRndjUjF1OW1nSnk4?=
 =?utf-8?B?R3hFWm84cHllZ2JhQmJsTi9ta0RxdmpyMjNrY2tudFprSmJNME1VMS9NbXc0?=
 =?utf-8?B?ZzZsc3FDVzZoYlZJWUpoeFRvY0N4cGtSRlFGRUh2QjVzSzgxVXh1K21pZVZV?=
 =?utf-8?B?UWpxM3J1NFJvY2JVN3VOS1BBblJlRm96S09IZjhVNHZkQThKRStNdWNpZndv?=
 =?utf-8?B?bGJnaWpDZ2ZEeHhqOXVYRVV3ZTZVdEk1b3JyVFhMQm5RajJuRWZXUzR5eEhM?=
 =?utf-8?B?dnlUQTdldUsxeU1TSGRJekFnSC9iaUdyUzMxNkpiTkNCcEtZeEoxMjNnZUJF?=
 =?utf-8?B?bDMvM3o2ckVPcDRLdGEyV0tGNzlXemlCaWpFcHBKU21KbU5RNnNIeklieTFv?=
 =?utf-8?B?Y0czN1hlMksvaWtuNGxlZUlicCtCejNvUU5XMDMwSVg5a2crMnNNczM3VjZ1?=
 =?utf-8?B?bWRERTlWRGdwZUV1V0RpVmZobmpQcWJiRXp5a1hCUDdMWFEwdWpiOHdpbHgv?=
 =?utf-8?B?ZWF0RTNZVDBrZU93Yjl0di9OL0xUMjZTV2c3SVVoa0pOT2NpbmhSUWJPZmVm?=
 =?utf-8?B?N09xVlErWkhTK1RtbzBEY01qTzBWekpWcEwxenR3SGZDMGlPdVl3czMwd3Zh?=
 =?utf-8?B?UFBVUTZESE5WcTE2SWdRUm1Kc3VXQ0xtTWZlZ2d4U1JxWUplTnJuMjJ1WFRj?=
 =?utf-8?B?ZGxEK2tKcWVVVWNjN3RucWRBT1NMZGFYK2NMRDYrMVFOM1ZhK1pWbXdTcXNx?=
 =?utf-8?B?cGRhTXJ1aEUvMDluUk56SzEwVXF6Z08yQWVNSVpodXhsdXIybFczUEwyaUpD?=
 =?utf-8?B?OEozMU9maEZCVk5HdW9NeVpRRWwzanNhSGVvcEZjZUFjWWluTVY1L1M1bzNW?=
 =?utf-8?B?NjlIeEdjcHVLVWZvNXBZY0YyUmFWYmJhakJNa2tzWmR6aStOVVN1WFJWN1RB?=
 =?utf-8?B?ZzhCRHBFVnl6LzArYTZQZVRvaDQzN1dka1JhYklZQUtmWDNaL29XVTdvSS9u?=
 =?utf-8?B?aG1ZNjhBd1N1TFkrWkUyZHhVMEZyTUZhaFNuT0cvYThGbkdLbWR4V0VHZ0Ri?=
 =?utf-8?B?K1cvY1hRamZ2RTBYamdYdjcvNTFSdnlDNERPUHBoRUxWRFZWWlN0bVgybkV1?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16471549-0fc9-48cc-5489-08de3e3e47fa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 14:03:55.2460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTOrUeRxe6zm6XfT3p4y9zX/B7JxE8x5yusBAVcfY4SZB/vPwF/ITA7eB7vebz90sF3Nw1dpAsVhU1J0aOriemTFybksxisdoOJVIOAJzvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6110
X-OriginatorOrg: intel.com

From: Mina Almasry <almasrymina@google.com>
Date: Thu, 18 Dec 2025 02:29:36 +0000

> From: YiFei Zhu <zhuyifei@google.com>
> 
> The logic is similar to idpf_rx_hwtstamp, but the data is exported
> as a BPF kfunc instead of appended to an skb.
> 
> A idpf_queue_has(PTP, rxq) condition is added to check the queue
> supports PTP similar to idpf_rx_process_skb_fields.

Much better now, one nit below.

> 
> Cc: intel-wired-lan@lists.osuosl.org
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> ---
> 
> v2: https://lore.kernel.org/netdev/20251122140839.3922015-1-almasrymina@google.com/
> - Fixed alphabetical ordering
> - Use the xdp desc type instead of virtchnl one (required some added
>   helpers)
> 
> ---
>  drivers/net/ethernet/intel/idpf/xdp.c | 29 +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/idpf/xdp.h | 17 ++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
> index 958d16f87424..7744d6898f74 100644
> --- a/drivers/net/ethernet/intel/idpf/xdp.c
> +++ b/drivers/net/ethernet/intel/idpf/xdp.c
> @@ -2,6 +2,7 @@
>  /* Copyright (C) 2025 Intel Corporation */
>  
>  #include "idpf.h"
> +#include "idpf_ptp.h"
>  #include "idpf_virtchnl.h"
>  #include "xdp.h"
>  #include "xsk.h"
> @@ -391,8 +392,36 @@ static int idpf_xdpmo_rx_hash(const struct xdp_md *ctx, u32 *hash,
>  				    pt);
>  }
>  
> +static int idpf_xdpmo_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
> +{
> +	const struct libeth_xdp_buff *xdp = (typeof(xdp))ctx;
> +	struct idpf_xdp_rx_desc desc __uninitialized;
> +	const struct idpf_rx_queue *rxq;
> +	u64 cached_time, ts_ns;
> +	u32 ts_high;
> +
> +	idpf_xdp_get_qw1(&desc, xdp->desc);
> +	rxq = libeth_xdp_buff_to_rq(xdp, typeof(*rxq), xdp_rxq);
> +
> +	if (!idpf_queue_has(PTP, rxq))
> +		return -ENODATA;

I think this could be optimized a little bit by reodering,

	rxq = libeth_xdp_buff_to_rq(xdp, typeof(*rxq), xdp_rxq);

	if (!idpf_queue_has(PTP, rxq))
		return -ENODATA;

	idpf_xdp_get_qw1(&desc, xdp->desc);

to not read the desc if the Rx queue doesn't have the PTP bit set.
Apart from this, LGTM.

> +	if (!(idpf_xdp_rx_ts_low(&desc) & VIRTCHNL2_RX_FLEX_TSTAMP_VALID))
> +		return -ENODATA;
> +
> +	cached_time = READ_ONCE(rxq->cached_phc_time);
> +
> +	idpf_xdp_get_qw3(&desc, xdp->desc);
> +
> +	ts_high = idpf_xdp_rx_ts_high(&desc);
> +	ts_ns = idpf_ptp_tstamp_extend_32b_to_64b(cached_time, ts_high);
> +
> +	*timestamp = ts_ns;
> +	return 0;
> +}
> +
>  static const struct xdp_metadata_ops idpf_xdpmo = {
>  	.xmo_rx_hash		= idpf_xdpmo_rx_hash,
> +	.xmo_rx_timestamp	= idpf_xdpmo_rx_timestamp,
>  };
Thanks,
Olek

