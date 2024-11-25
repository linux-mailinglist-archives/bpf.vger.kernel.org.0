Return-Path: <bpf+bounces-45576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF27A9D88E0
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 16:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A8C162A23
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 15:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E461B392E;
	Mon, 25 Nov 2024 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NtlJZRXY"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94072157465;
	Mon, 25 Nov 2024 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547564; cv=fail; b=p/PurXICcnIZD0A9APecT4m//PS2hJJ5jtTq2BI/1L5fludQrUZOCzhEDYNw1YoeXoHD84OsOiEEYuoIHG0pmh/9BTf/PKVFHwXRc7FHMcwqQWP8ku0QYnYGq2oYllpCcB4R1CIS2LubNC8chSGmDhI1TUIaVL4vZB5zRxI6JOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547564; c=relaxed/simple;
	bh=sXyE44PkNeub8ZY0vuQlJZsB/p9Yd8IJopoDg9uC/os=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qJQn3cC2LcuMqYse743XZxUKSl+9bWcZlqCH698UdFVV4nZuJtaNPnbnjnyKVqS+BuA7WIRtPN4scG3Nt3iyZlsOiMqw1khBWiCn7cJzLQDQSY03lHHM/kV8+5xucWvILbf53kSHdN4Rc4tglh9WD1mYwxPZBrgdMkQW342UUwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NtlJZRXY; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732547562; x=1764083562;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sXyE44PkNeub8ZY0vuQlJZsB/p9Yd8IJopoDg9uC/os=;
  b=NtlJZRXY028/IPJsinTa/gjUWG4BYQ/rQMRLqan4XkFxqbDTpIZzagdL
   TnZkOX/NCzmY4zcVEsIWr3gxHsyIiqLPMha06pXNA+cwbf1NuhX8WReXM
   86pDTTtbuiv5ODqM7mbBDktY4Y14RvMCc63tMppmsYCENN/tN0FHPFnQI
   KT+fzoDLz6D02SjVuJqTTiUJwuqex/VeUmqh2TzLmORPYoGNhpos1vdyw
   n5StvPRzSVg4ghgAlgeOz8c2VLRbQfI93ttTetwr+QTTFTlXSou5XiAKd
   2XUNiLpGZcdwZCh+jLp50ru8xYk1WCqFGliO0q3NVY34ySgV38eVAoYwI
   Q==;
X-CSE-ConnectionGUID: VMsQPK11Sp6Z74/eM+9HPw==
X-CSE-MsgGUID: wVMaDHQmRqe2WTbtqNmeRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="32518441"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="32518441"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 07:12:41 -0800
X-CSE-ConnectionGUID: f2homQeGSkSbmBbuRGOeQg==
X-CSE-MsgGUID: u225VIotQ+yqqYxMQI6Onw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="96360466"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Nov 2024 07:12:41 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Nov 2024 07:12:40 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 25 Nov 2024 07:12:40 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 07:12:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drvpFp4VijcUFtQVGD8+gwc56oP8sgbVkL2KDEiJiUbUuhD/0cA8nwaI5hoC7sRIwunAPQ4R/HtLB7zarpXiaolnNVkODm3vX5EMv03gDmdnQ0wfjzQnCRHwHxK+ZooniAzoxjeqazGP0Q6oaIwSDGyfDPSZNNDUpJOycO5vB+Od4Gdi0YRaxqXxb9PwC9UxoWRj73qVGo3JxZE4OB4nHbcJ8CMc1yjmMZauhnKjyJYFO8LZ7Lf8izApgUctzxcxCZuOc438Nk0RgC/gWhseBe4Nzd5A9ZLdpdCcqOeJbQwBbofTScoLiw/8uq4TAilH7l3qzgOhKSCLgVh68Zxndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJgu+OOcMmeIAtJDMMSWRuAYNpY8OPFHcCwXQ5j/06I=;
 b=W4Peo+tm7yXNegKn2aZ7Wz/r5tkQb9rCBUCvmOLlZiEgcyQr1tumMFUZSlBcrppZxnZTCp5fuW0OFtIDRRQjq0Y5m4cmGjel5wbFz7HTQKiTdUCLsK4SnHG/mG+rUCpsuRvv7YSxJ6Iq8jgs1HnjInGSa9i9VeG2sMJzZ9GWRO9IBU7b/EuHuPJLxeefdfdN6lylXGssbRQPO3RSmQ0bpeEDMKI8rNXf/WksTSOwY+YQ/GCO9D369FyAekQuav+m09IXhY4d35mqKxQLfaS/MojnCFiyTLuz/14HyWskr75SUl5Nqk76k3jG1Rn012459OAywZu4wZ+8AYExI+5Unw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB8597.namprd11.prod.outlook.com (2603:10b6:510:304::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 15:12:37 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 15:12:37 +0000
Message-ID: <05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
Date: Mon, 25 Nov 2024 16:12:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
To: Daniel Xu <dxu@dxuuu.xyz>
CC: Lorenzo Bianconi <lorenzo@kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo.bianconi@redhat.com>
References: <cover.1726480607.git.lorenzo@kernel.org>
 <amx5t3imrrh56m7vtsmlhdzlggtv2mlhywk6266syjmijpgs2o@s2z7dollcf7l>
 <ZwZe6Bg5ZrXLkDGW@lore-desk> <55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
 <ZwZ7fr_STZStsnln@lore-desk> <c3e20036-2bb3-4bca-932c-33fd3801f138@intel.com>
 <c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
 <01dcfecc-ab8e-43b8-b20c-96cc476a826d@intel.com>
 <b319014e-519c-4c2d-8b6d-1632357e66cd@app.fastmail.com>
 <rntmnecd6w7ntnazqloxo44dub2snqf73zn2jqwuur6io2xdv7@4iqbg5odgmfq>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <rntmnecd6w7ntnazqloxo44dub2snqf73zn2jqwuur6io2xdv7@4iqbg5odgmfq>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: 4564548e-71f3-4ed7-af30-08dd0d63988c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHNOUG9yWUl4aXF5cWtDVGxYdzRDODBKdjRqbjFDMVh3cHRUS0VsVzNybnVx?=
 =?utf-8?B?bVRsZVlwMnFEOFpoUENKQnprNXQ1ZktYNWFLaVpQTmpEVTMzdzlNZ2tmT0Iw?=
 =?utf-8?B?c201c2VkdlA2M3hIM0R2dFVjWEZmbVlMcVJ5Q1ZmSXZMcDlZM1UraG01czJ5?=
 =?utf-8?B?QitQYUpOYWtsb2VSdGtHeFlDTnNCRUxZTlVKL3ZFUnQ5NXppZ3piWmI3bU1E?=
 =?utf-8?B?OTZYdWI1NzJ3Wk4zcnoxUjQyejVaRUZiQXFmeHJxcHA0bXdDQUpWTmhLSnNh?=
 =?utf-8?B?aXJYNlFRclFQd3NlYjZ1bzQ0dWMzUWNvc1hOSU9kdzZqcldvMHloaWRWc1p6?=
 =?utf-8?B?MXdJQjJhYVhFSHNDcmV6V2FnZm5FR29ua2lOZ1pCQk43ZnJ0Z1ZkVkE3bmhx?=
 =?utf-8?B?MTY4czZNSGRzWnRGQm1BMlc4UWpMNlNaWHVweHVDOStRQXp2TGl0L0QrYmpH?=
 =?utf-8?B?S1Z4REdTRktvcngwTk81Yjh6NHB2QWp0SmNaOSsrOU9qTWFqZVdGamU5MDAz?=
 =?utf-8?B?OEszU0ErQnNTNmhENm5XcFk2Unlyd0RGeGlzUXZ5MWcvS3VVWFBFMVhzKzRY?=
 =?utf-8?B?eDlEd2J1bjVNVUZrYi96N29EdGdEUGJRQ1BZdFBFL2g2QUZLL2N2dU9ycGhP?=
 =?utf-8?B?dVcvUExWcnFSRTJpekNzaHdHSXdGUVNIblErNWtucnZ3V0p4cmxqYVpaVC80?=
 =?utf-8?B?bXF6QkpwSk5GMFUvZ3UrdEhaRy9tRUkrSjlubkdNQ0pFYml4R2xSYlIveDRO?=
 =?utf-8?B?dDhyQXJObXdMMXBxRUVhSFZSWit6akJzSDNmQk9nVWxOcTcvaFRRTEc5NW1p?=
 =?utf-8?B?bkZUaEx2VTFmL09pZFVxNzBjbUtjaW12TnNtRTBPOWpZTlJZeXdwVytzNWNY?=
 =?utf-8?B?UlJSYVVOakNPNEVvNDVNd21NbW8wKzUvVzNLTjNTNm9MQjNNK0M5UWNXbFRp?=
 =?utf-8?B?YndGNTVCbGdXQmlSN0tmMTcydHl4aGdjdkF6eUxYZEZqWk9MM1JiQ2VReTlU?=
 =?utf-8?B?cGduTUQ4c3c1ZVJPU3hTOG5YcUhVRmpCVnp5cU9mMUFuNGtxUWxWUEF3KzVE?=
 =?utf-8?B?alA4SW1OU2lIY3N5NTZHbVpKc1RnSHZ2NW8yQ3hvZFM0OXdSaHJsWUNPeVF4?=
 =?utf-8?B?T3R6VlMxV0V5VVBId1d0MnY0cWxKSlNOYURIWHp1WjcrZVVoTGkwYWdpMUFX?=
 =?utf-8?B?QlJUZlI1eStzWkxVZ1R3V3pPb0dGdk1tWmRCVTBSL1Y0T2VlWmZNTXdGdzBW?=
 =?utf-8?B?T3NvZ1g4U1pvTHFldFFRd2NUM3NvMHJmQStRMlFsSVM5VmtxK2NRNEhiNy9L?=
 =?utf-8?B?Q0ZOdTU5RjRzeSszRnpsNllLZzlacEJtZWxZczhReWJnaW13SXBnK2NyQjNZ?=
 =?utf-8?B?eW1JKzgvbnY0SUtpZ3FsU2ZUMWxnamZpMTVpekc3L3JCMFlHdkY2MnBpaE5V?=
 =?utf-8?B?TXVFaGlFaWgzajR2WTJxZ2FKVHdXMlQyNHM4N25LaGVZb0hSM2crNU40Q1dD?=
 =?utf-8?B?ZDVWdTNGOThDMWZpQ25RWkhFQzlwRDIxVjRrR2FLQWxWTVZKVWVqQ2Ira2hU?=
 =?utf-8?B?RklrNUZRbVBFOXV3ZklmcHV5azRJcUc1ZDJ1T0k4amZiMUo4eEJoY2Z3RWp6?=
 =?utf-8?B?eVhDbXFlL3Y1WmJjL0VFM0dCdEdkSUlkQ0g0MFRhUy8vM0hFQTJoak8wTEV6?=
 =?utf-8?B?L3hhRTJWZmdnRkFkVjRBb0xiTHVJd2hqQzZ3RTl0aU9rbkJTeXh3QSsyTzZw?=
 =?utf-8?B?TEtmUXBlNVRsalA4YlVaVCtHNlp3ZlE5Q1VpRlRGT0prWGU4UHB4cXErTllt?=
 =?utf-8?B?RFFFT3BQdDNwdjE5U25QQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmMzbFZBbW9rM0s3SnpDeFlQYlYrdWlyMmFrNW81UXdVNS9uQ0t3RUZyajVq?=
 =?utf-8?B?S3NacXNUTU1zTnBYZXRnbEFqWEE1LzNkSzVZeFduYTU2dFVHQkNCTnB5a095?=
 =?utf-8?B?VFBQNTV0TnBFYUNMOXZ3U2tXWWkrWE94VUd4dGtBMWJjWU5qSURLTXJuSzl3?=
 =?utf-8?B?SWJ1RHc3TFpWRUh5YXowK2dDT3htRGNQcy9Fa0dIL2RnT2djTFZVRzJyRkw4?=
 =?utf-8?B?WXRWZnBNaFpGa3dzSVlnc3ZGc2U0VkxwNWhVcUwyZ0hhaGVEa3VMNzBhTmdy?=
 =?utf-8?B?WVZyUEtqNzJyblI3T29RaTRlT3ZnNVBOWVE4RDBZOGpvK0txR1JOSGluOGtI?=
 =?utf-8?B?YWVBanFleHowaHBvVjVaWUVSTXJoMitQbHhqWGJnYXRHMnZacC94MTBxQ3Jh?=
 =?utf-8?B?S0haYkxKYUtXNk4vUDdnUUNFd01XdVVhQUdHdTY2aVpDeXREZkh6V0djTU5N?=
 =?utf-8?B?RTFQVFNDdHAweWZtK3Y4c1lrRnJRdjVCSlZVZFVTbGtIYm9zR3hpNlVvOFdM?=
 =?utf-8?B?ZUtVNHNvZlZSb1ZFRDlyVll5V0syZlppcGFBbkdyTjRpNG44MW81dUpVMVFG?=
 =?utf-8?B?YkM0bkFXcTZpd1FieXVwT2hpQng5aEgzak82eW9Sd1luNlNpZ2tmbXJnMkRo?=
 =?utf-8?B?eU1PZXJ0R2dyUmE0dHMvRFdVYmUwTW55VTFqUHdTOUdEb1hndlMrVGFML0pN?=
 =?utf-8?B?UlA1YU9HcTJHYWMxWnIwNHVJU3ZuWkcwNmM5N2g4SEc3L2RJR3MvZ25SM2lm?=
 =?utf-8?B?ajVod1I4dk14TlZYQW9uck0rUkJ4cGR5Uk41a2lFRDVrd1puZHAwNG1JVU04?=
 =?utf-8?B?bm1IcnROMnhTaVBpRmZzbXk4d1IwWTlMbHAyYWk1ZjhHb2s1M1BCMHh4c2o4?=
 =?utf-8?B?ZnMzK2F3TkZMWVVscXJPaG9UV0REbGdZK3lNM2s3MkFlVFl4V3VRY082WVVM?=
 =?utf-8?B?d0JodnhPTnl5UlBoS0g5TUoyWEw2MnJxaGJ2QUpuM082OGg5VWN1aldLSERy?=
 =?utf-8?B?UnN2c1ZVTlpMSnhTdzU0cFJ3WnhKbjFTbStUZ0hrU213YzRCa2I5T3k4QUlt?=
 =?utf-8?B?eG9lYUZUUDBUaUtlbGtoNGFvdnZKN2VSVkgzTW5XRm9NajFYekxWWkVyOEJO?=
 =?utf-8?B?eTVPMnlQWS93dGc4czJ6QUZCY2dvSHNmWkMrdmE0U20vQklNOEpZb3N4ZUoz?=
 =?utf-8?B?RzJpaVNzWVRBZEtKZnkvd1dacXZvRDJqK2JpSnorS2lzMVhMcXlDOThhVnVR?=
 =?utf-8?B?dGduMlNoaDVmNm9YdW01WTl1VUVzUGdIMXprOXp6VW95dVFPVm93azFpc3Y0?=
 =?utf-8?B?R292R0l6eWVsZVd4WTMydHJtOTUzK29xNjVqVjBZY3IrejA1N21SN0tLbHUy?=
 =?utf-8?B?MmttbnNoTFBOQzdsM0cvZkdHV3p2bENSSGp6bkZvUkhZQmIxMDlDTVNJMWMw?=
 =?utf-8?B?Vm5LT1h1TkdVOHE4N2liMXhYK1F5UDNQK1hMQmVCUkxORHMzTFVaOGQreTZM?=
 =?utf-8?B?dFYvLytPSlQyNisySGtmVm1IWU4ybEJ2QStTM3FaRXF1OW1lRW1ockw2REhq?=
 =?utf-8?B?cDB4YTV6a016eEYyckFtNFZZQXM2eGhPS3FUQ3lzN2JjaktNdTAvYUd4OUV0?=
 =?utf-8?B?VTR6UVdXbWQrdEpsOG1HMStOVHFYcWFDSGk2UUtGcDJleitqdFBHZDFtb2R6?=
 =?utf-8?B?Mmx2L3duVDV2alBROVRPWngvS2puSXRkcXV6bEUyc3F4cVVRMDdSSjFURlJ2?=
 =?utf-8?B?NXR4YWh1VFZNb095dnlLeTh1R3JEVzAzL3NNT2lsZ1BOKysrWGdRVUFzRWVX?=
 =?utf-8?B?R3E0S0pGMFJ2ZStKNGp2NmlOTEVPQjBEUTRnV0FhUVdXbmRBb3pvRzhyKy9Z?=
 =?utf-8?B?QTNNTG1nMWo3cTd2QzZYOGJwd3pNRG5KNDR1N3dwUWRBS2ZVeVE2QWxpVlBL?=
 =?utf-8?B?VFlLdUVFVm5mOXp4V1hvZnhPcllDYzczd1Q1Zno1YjJ3ZDRhVWdVSUdPTTI1?=
 =?utf-8?B?QnpwUzZYN3MvUy9naVdQMUg3TmJ3Y1RxeGRWcHBaSVpsSVRkSjhFN2hzaldU?=
 =?utf-8?B?NGFKSXd4MHZXSWN5TTFXU29CWmpFbE9yZmtVVDRMWHF6M2UzRGx2ekFsNzg3?=
 =?utf-8?B?eVpDcktDd0xFUzRVWitoVDZiRUsrTVJOaHJMN0JuUFlwVVdadjBPSlpKTmw2?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4564548e-71f3-4ed7-af30-08dd0d63988c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 15:12:37.1664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQAaUfYrVL0v8mRootdAFHv9tJI91t7wZXUZr3sEim+NAKJG9cmIhky8kaZUBEX3hCXBQnxDNDUtLXuJuM8gFkeLXElZELq5AjmkixcbvxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8597
X-OriginatorOrg: intel.com

From: Daniel Xu <dxu@dxuuu.xyz>
Date: Fri, 22 Nov 2024 17:10:06 -0700

> Hi Olek,
> 
> Here are the results.
> 
> On Wed, Nov 13, 2024 at 03:39:13PM GMT, Daniel Xu wrote:
>>
>>
>> On Tue, Nov 12, 2024, at 9:43 AM, Alexander Lobakin wrote:

[...]

> Baseline (again)
> 
> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
> Run 1	3169917	        0.00007295	0.00007871	0.00009343		Run 1	21749.43
> Run 2	3228290	        0.00007103	0.00007679	0.00009215		Run 2	21897.17
> Run 3	3226746	        0.00007231	0.00007871	0.00009087		Run 3	21906.82
> Run 4	3191258	        0.00007231	0.00007743	0.00009087		Run 4	21155.15
> Run 5	3235653	        0.00007231	0.00007743	0.00008703		Run 5	21397.06
> Average	3210372.8	0.000072182	0.000077814	0.00009087		Average	21621.126
> 
> cpumap v2 Olek
> 
> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
> Run 1	3253651	        0.00007167	0.00007807	0.00009343		Run 1	13497.57
> Run 2	3221492	        0.00007231	0.00007743	0.00009087		Run 2	12115.53
> Run 3	3296453	        0.00007039	0.00007807	0.00009087		Run 3	12323.38
> Run 4	3254460	        0.00007167	0.00007807	0.00009087		Run 4	12901.88
> Run 5	3173327	        0.00007295	0.00007871	0.00009215		Run 5	12593.22
> Average	3239876.6	0.000071798	0.00007807	0.000091638		Average	12686.316
> Delta	0.92%	        -0.53%	        0.33%	        0.85%			        -41.32%
> 
> 
> It's very interesting that we see -40% tput w/ the patches. I went back

Oh no, I messed up something =\

Could you please also test not the whole series, but patches 1-3 (up to
"bpf:cpumap: switch to GRO...") and 1-4 (up to "bpf: cpumap: reuse skb
array...")? Would be great to see whether this implementation works
worse right from the start or I just broke something later on.

> and double checked and it seems the numbers are right. Here's the
> some output from some profiles I took with:
> 
>     perf record -e cycles:k -a -- sleep 10
>     perf --no-pager diff perf.data.baseline perf.data.withpatches > ...
> 
>     # Event 'cycles:k'
>     # Baseline  Delta Abs  Shared Object                                                    Symbol
>          6.13%     -3.60%  [kernel.kallsyms]                                                [k] _copy_to_iter

BTW, what CONFIG_HZ do you have on the kernel you're testing with?

Thanks,
Olek

