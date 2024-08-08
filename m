Return-Path: <bpf+bounces-36676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB67D94BCAF
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 13:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5D81C2261C
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 11:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8D618C92A;
	Thu,  8 Aug 2024 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJuEMio+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DF718C355;
	Thu,  8 Aug 2024 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723118236; cv=fail; b=D6iGpYvea2VVwCkOg+Yh29SJY9L5RNgB6NnShBCF1oNvj8AKkr8BNi7ngvF0JzMaKhVTpT1N5H5+wrCu3YC3m5MCFnI7vjVP4ip3cIOie43QZHU4W9DJlGYvMl/VgXcszKjkJfkX0T9qTuK8e9GFOmNxlvD8KdczwdG1bz4tkh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723118236; c=relaxed/simple;
	bh=2P/gfLyXaUe9lFNcZuILFh0SpTHqya/6pXw1qVAa3Os=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rEqlnU0dT2ksj8OOgvfOJYPqolFqSYSycIyuk6931x7ZMiatj6WAUoXwOEox+TUOU/UBOo9zLeQVEtunRxm9ex8FYTa0fdp8Hs99uCXuLtMXzwAMiB7FqPYK6SFllu41bVAYKwmlS2L5azZFclTfwYFb2sS5A2DNMt/uQ/cR6IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJuEMio+; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723118235; x=1754654235;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2P/gfLyXaUe9lFNcZuILFh0SpTHqya/6pXw1qVAa3Os=;
  b=ZJuEMio+ks1EU+yvagCSkkeV2kqvzS7aaCXpgrylOk5zSeSOT69t6Cf/
   HIanKUAxoqKSFppv9q7zm+ju+7nO7knY6ergwlRYfwRu5NeHc42NSFwd4
   zsqp6h+zdCsiH5MnJiWZ8kgL8opm4x2se9bw1ZENpH2tCf9qZa7V5zXm7
   N4Ggt0fs7SaGIOmH7O4hj2433uRdJh833aNt9jaaurEBUXR/A35yFyyFl
   sDe3Tt/StzS1s74bMP7QB0PcJYpuZ1WvSS2SqD8v1BIw920wpKh2Y0fig
   VX/2v52yUk4KsJR0Fbg9vD+RkbDwehxzgsyS4GUP3aI0wOY4FBViktGUd
   Q==;
X-CSE-ConnectionGUID: e7UObxnHTzqjXWGrbRqLBw==
X-CSE-MsgGUID: Zm9qxjMaRn+PJQBLnbsU+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="25000478"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="25000478"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 04:57:14 -0700
X-CSE-ConnectionGUID: szFIgcQlQICLprqyO5lQSQ==
X-CSE-MsgGUID: kuhJnbB4Rr+wCFGRXKXpyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="61294322"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 04:57:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 04:57:12 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 04:57:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 04:57:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 04:57:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxsFrD418tbK0hEN0UUwU6VYe7LnidVuknH+vMqvg8jzzXvIf/RcsK4JKFGwHCupxA64cszbTJsocjNPQdNDKL3MJEuon1I9/SSykAdHDSyQUz5I+kpsBckBPfLKoJQai3LTZIX7VczPgNbGAqDshEOtDv1s55yfy11Q4Qspz0DMlzHuiQ8efJ9ds6cpmYX2o65vq791tJBeNuA9uHH8kozTVXbtyRhBN4Ab3Gthq5SdKqvHBU2tyfjgugWe78UFHHbvLeIfh8wgFvpCx1IRlUAdMsPthNNCr95sX4E0SPq2rZzVOwkqJIYnVPU/cjzLXRdCr0NvTuiKwvOs81jWAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQ17y1OhumJCtjk8RfhbMMGz8p2BNoMJyHe5HiUuxCE=;
 b=daphEutM3KdKOi1NPzIyBpb+rC9MTBwZSE0IK2liyUQua9O5yl17nFDIRSCk5ZZe2P6ztCVa9tHaNiXqPgGpGY4qj+EI3V0qpr73vx+YGmWoSZ4oeSo4NS7Vo4OEO+eHce+sjBFD/eoVpqjvcI/vB6JdmTRZgVrAEIPBcazQBMMS1OjxbK0cb9HJ9mslPT3zdDW6xmTG2CDywuh0j5eAKrMuY1wo8M6KFpF8Oas3YAm5cIksj8TqKt1cBDjYNQkPZSnrtnDSb/2kxF7ydCZE+sc34ZSLIZ/HnpcY/xa10HKplLbtD5vHJZPPiJ5ZfXnEARnYfI247LOVuqlHOsD8qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA0PR11MB7752.namprd11.prod.outlook.com (2603:10b6:208:442::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Thu, 8 Aug
 2024 11:57:09 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 11:57:09 +0000
Message-ID: <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
Date: Thu, 8 Aug 2024 13:57:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch to
 GRO from netif_receive_skb_list()
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Daniel Xu <dxu@dxuuu.xyz>
CC: Alexander Lobakin <alexandr.lobakin@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Larysa Zaremba <larysa.zaremba@intel.com>, "Michal
 Swiatkowski" <michal.swiatkowski@linux.intel.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	"toke@redhat.com" <toke@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
	David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Jesse
 Brandeburg" <jesse.brandeburg@intel.com>, John Fastabend
	<john.fastabend@gmail.com>, Yajun Deng <yajun.deng@linux.dev>, "Willem de
 Bruijn" <willemb@google.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<xdp-hints@xdp-project.net>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::30) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA0PR11MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 674c52a1-5a3f-45ba-2a33-08dcb7a13b42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3dLVllPNUFHRE1oR3R3b2xYa0V2WEw4L3BHdjFDUkEwMnh4dmwzQjJWK2Nu?=
 =?utf-8?B?c2NieGRRYXE3ejRqbEw0cU5vTGV4Q1FqZW5uZnlBZDg4WjNQUmhPckVQZE9J?=
 =?utf-8?B?YzVIRnFGNStqU2hzWVdkdXJGaWppVXJWVkRITGIvVTY4d0N2N2lBK1NxSjFI?=
 =?utf-8?B?aWYzUTdiNi80MFdvQWRtR2YzT2hma0QvK1BlNUJXUXVmR0JKWUJJc29VME5r?=
 =?utf-8?B?aStxc2diVnUyNzQ4N09mTko4QzNXeFpjdElnTitiNzk2dmd3QzZqeGtadWVs?=
 =?utf-8?B?NUxFVm5oYjlJNVhwc2o1bjZVMEVGUElpYjZqYUQ2QmV5Q1ZjRWNKbkZDeGtM?=
 =?utf-8?B?eHFUTGdqU3YzeFN4dWJMK1Y2aHVTMUYzajlON1hoai9tbFFYR1NiZmsvZ0hJ?=
 =?utf-8?B?K2tHdEE1Yjgwc3R5N2N0NllnaS83VTkzaWpTeDJPbWVzNkdqWEJRUC82YjFy?=
 =?utf-8?B?dzlKYStwaUxmTmhMYkNnNkpkUWIxbVF5TVVhU1M4OXdwUjZlb1g0bU81N0Fj?=
 =?utf-8?B?K0QrdHRvTDJRZWl0ekxMTFJjR2c2QVZNSEhGaGFyNVIrRzhMNjUvdkppdzYr?=
 =?utf-8?B?NUNPZzRESVRLbnpiWUgzRTNUbEt0RThYUndrV1NDUmNSME1hN1kvM01ydm4z?=
 =?utf-8?B?OW1KZUxvNGNjV25oOHI3QmxDdTQ3OVRBWlpWMjhEM0R6SFNFdWpUeGk2QzNQ?=
 =?utf-8?B?NTRxL29nbjlsdGRCYmxheElIdm80eWsyb0RaOW9RYjhqQ0RzNmZINkVqeE9q?=
 =?utf-8?B?ZTJtVjJYdUpwOXZ0NzRoT2UwQmxYSXk1VzBoQyt4ZDZIZnNVcWxYdUg1RVB5?=
 =?utf-8?B?dVlmZ0x2bkRSZHJ4eHhCUm81dDV4bW5lSFpMS1NyV2owaFdrazZvcWswQjM3?=
 =?utf-8?B?TXRFeVdhZk9vcTAweHdEUVp2MkI5KzdlR0c2Z2t5NjNtTmtXSUlFNzBzR2c5?=
 =?utf-8?B?d0hadUE3WkYrOFpPY29rbWEyc3RwWFAwc3JPQ2VYVnUvK2krOTZ4RFBGcVpQ?=
 =?utf-8?B?MTYxcmdUM3FuNWVnckVaTlhwOXdNTFNFUGZYZVhOTno3ZmdVekhuUkx3UVZJ?=
 =?utf-8?B?KzRjZTFZcVRPYldJMmNGMXdQN2tzWmtkc21zeGgrRVdLUnV5di9zKzB1V0Rt?=
 =?utf-8?B?SEhEOUlwV2x4SmI1V1RjU1JRdnJIWG5nNEgrOHlMdFJ0OEl0bmh3UXZLWW5p?=
 =?utf-8?B?Vktabk1oSW9mbHVtV3ZKc29YM3RrZVlhMEhMUWVWcnVNSUpHMG90NENpQWtT?=
 =?utf-8?B?aWVXQXJQdHNWWjRYMmMwbkdXSkNwYlNBOVY5Ung5cjBxQzRtVFpRbFFJU1h6?=
 =?utf-8?B?MUI1TWNuU0U0U2kvVHQ5elJoN0NwVUg2V2JISmgrME9UbUhyL3NEcFB0U1pF?=
 =?utf-8?B?Y0dNSENwQTg5ZzJsWSt5Z2hxMWRTMkxNdUtCS1JNa2drTDVLMDh3ZEhBNVk2?=
 =?utf-8?B?bGJGc0QyLzA5MDUzS3BldkNMbFExV2ZqRHFheGZhRlozQlJ4NU9PczBscjE3?=
 =?utf-8?B?WVpmZE9zem9TTTlzMklzeURLY1h4Q3RMamxRazY4SGo0bXlyWlkwV0xQVWxi?=
 =?utf-8?B?WFVIZU4vdnpaMGNmL1lsTWlkVEMyK3VJTlU1RDJOMm1BZG42cUh5b3NnazNP?=
 =?utf-8?B?dkNaRWd1TW1hc0plMEh1NUN3T3pVbzFCTW5HcE52aXQ5ejF2K3lTcmJKTWhC?=
 =?utf-8?B?STMyTWtheXF6QUVIdzM3OHBlVldVODN0M01RM0JURWNDM2p5bHNWSW9Qangy?=
 =?utf-8?Q?Yxv8qWfeJZz2H1Nu7vWt/Vc8B4OhrAcNY+N7iSp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3haUkMyQmRzSVZ6MyttQ3BtQXZaTTFpbFRtWW5SVlhrOXFGbWw5eHV1VTd1?=
 =?utf-8?B?WmR6dVl0NFVRdTVWSGhheHhxREpDdHJrQ3dpeno3SWpaN3Q5VXQyeDNoOVVN?=
 =?utf-8?B?cXh0UWtNdFB3cXhYWEEvSERuVlhXQXVaaW9TbTd5YjlMU05MZ051WTdueGU4?=
 =?utf-8?B?MGhyRTR2R1k5aW5IOGRmTmIxYURIa3lyWE9JQWdhRHNIMDhkTUt3S0NZYmVx?=
 =?utf-8?B?dGZqWmVhVGVtU0dNY1F5bkVYUDlvK0hobmJ0c1o5bnFqZHY2eUlXa3BnNktQ?=
 =?utf-8?B?MTd3dEx6bk1CL1kzZnZYMkFETm5hUm9saWV2M3JaeDZ1VnU3M0RyTTE5b1N5?=
 =?utf-8?B?K05xcUZUZXhaeFJGZy94aHQ3WE9nN25xMldOWmFPRkt5MnlCYTNDVzd5akJl?=
 =?utf-8?B?a3RxNEt3a3B5UVgxc09BWDBPZXlFaUc4MmJFOW9haFp5cEhWVVdRZzM3WXVE?=
 =?utf-8?B?S2NPS0dEdUkzZWZMTG8wQy9acVlmQllwNWIzQVg4TFFvOGp4bXNZWUI0ZFBI?=
 =?utf-8?B?clRJdmhuL2lVd2RoMEYramxrQUlUTWRBVkhTRGJaNFRSQTBwbm41K0FlZWhJ?=
 =?utf-8?B?NjVoL0hNeStJeW42ci9JQnFBcm1uNjhtd2Z4R1Jic2dPVzM0OVFDVVRZdExO?=
 =?utf-8?B?N0JxV3JSY3YzWnJhNk1QbTFHMDYwdFdGTHVNRlVIc1ZwT0h4SmJndlJOWGNO?=
 =?utf-8?B?c1FGQm4yNllJZ0lNWkdnaml0Nm96VjNjRnNZcWlZME44ZUw3TlB2TmtLRmpl?=
 =?utf-8?B?NzhhTnRENjd1amh3cnpUVzNCMW9HYncxZzFLR0dQLy9EOEZMK1lvUW1GNC9Z?=
 =?utf-8?B?TnhLeVhQTElaYnBTWGdSZlF6enJ4ZDNxQlhjMGFsOHBBdHZNUUh4UFZnVjk1?=
 =?utf-8?B?R2hrWGp1eDNYM0lRQTQzRytQK2x1RDd6YXY4VnpsRkZvQzBmNkwyRlVoTkI5?=
 =?utf-8?B?NkxyS1JLU0x1dW5rbHpGN1ljQnVGNkdjVGlWalczMDVwT00vNHlmd09pTysz?=
 =?utf-8?B?SWtvSGxqM0VBVWN1VE00Ykp4em1kNnhHSHVZMncvZGcyMTh3a2F2enl6b2NT?=
 =?utf-8?B?V3lzUGRzQ2VuYXE2VUY5WGNmUER6UWNONVpBNWl2MTkyZWVObWExYllEOGhX?=
 =?utf-8?B?YjEydk0vQWx1c0hkaEVsNGdVMkZXalpBRFRobVZnUHZVNnM5Z0h2M1U2QU1w?=
 =?utf-8?B?MTlDZzhXTkZBL2xQTFZodFJOL0kvZ3lnYXhZMFg0SE84NmxHV3FKMFNmei9r?=
 =?utf-8?B?K0tCUDhQcmErVlZZRVZTZThmZVVBb0hXUjh4OEtmbmRuZFhVVWFoUWt0V1V3?=
 =?utf-8?B?SUxxMnRYdEw1L1FKTU9Mc2NodU9mZEk2WE9pNUdtNGFQS1JOVFRjMUw2VGVl?=
 =?utf-8?B?V3c2SUNIcFQySy9Ublg0YVNqUThEU0ppYXpxYitCbUZzT0lLaXp5bjFZQWNK?=
 =?utf-8?B?T1AwRnFIV1dmSjJRVGxDZ0c4MXVLMHpMU3JMaGcrd1l2WWVkdjdkaEdDUHMr?=
 =?utf-8?B?bEhLR2poL1dEOGlFWlk1T3pYVlZ6TGFQT3ZEbHM0QXkyYWl2N2lpdFRQeXJr?=
 =?utf-8?B?by9LcFNZMVhLdEY5OGRDdC94SUFsYys0b0I2V3ZEcHJQNVpoODViWFhhQ3lV?=
 =?utf-8?B?a3pBQ3MzWFN6MFdFYndrd1NYRU5sWEE5UGhJOEVONlpoNlJhWHBsa0pzdi9r?=
 =?utf-8?B?M3JFVnVvd05tTkpoMjUxbjdxb1prMjNVRjZZc2U3SWZDbGd5Q0F6MGtyZ2FC?=
 =?utf-8?B?K1FyelRHS2RtczRienVNMDgzeTcwa1UxV1dTYXpkMmV6MlYzdW1NNFl0WHJs?=
 =?utf-8?B?V1hqcnJLVkppcGp6TWRUeElYb1RQVnp6cURVSXZMYVM4ZnNJU0NuTXhLaUd6?=
 =?utf-8?B?dWxYK1VsdDR4ZXdpaWxNVzQ3akFjaFFpNUQ2QngrcmpFeFVqZ053eVFxTllm?=
 =?utf-8?B?WXd0a3hkdXVwRkdxOWtvMi92SHJrendLWXNvMklOeEJPMmJLRVVJelJab3RQ?=
 =?utf-8?B?Ryt5cml3eHk4ejNwK0Z6bGZsWjVKQUJYNkF6akV1V3ZqajdMZzdyd0hseDk0?=
 =?utf-8?B?UklQVVBXeDM1VmhNemhFSW00Zjd1UFdzOU5vN1BkQklJRFF3Vmh0RmlmM25J?=
 =?utf-8?B?aVVZT1pIWXZqTHJ0TmUvdmVza29FY1BpZmdhZkhPSGdrMTY0clluc3UzcFN3?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 674c52a1-5a3f-45ba-2a33-08dcb7a13b42
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 11:57:09.4827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Thpw5rr7d50tjLG6kKqAN/RqOrEZJClsN14m7Av9HhgSETMOVpUoi67IVLa2ydMAzS2U3b6EXJ7mQ2MRb2QfKwgbkiHtTfAlukJSpLCNUyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7752
X-OriginatorOrg: intel.com

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date: Thu, 8 Aug 2024 06:54:06 +0200

>> Hi Alexander,
>>
>> On Tue, Jun 28, 2022, at 12:47 PM, Alexander Lobakin wrote:
>>> cpumap has its own BH context based on kthread. It has a sane batch
>>> size of 8 frames per one cycle.
>>> GRO can be used on its own, adjust cpumap calls to the
>>> upper stack to use GRO API instead of netif_receive_skb_list() which
>>> processes skbs by batches, but doesn't involve GRO layer at all.
>>> It is most beneficial when a NIC which frame come from is XDP
>>> generic metadata-enabled, but in plenty of tests GRO performs better
>>> than listed receiving even given that it has to calculate full frame
>>> checksums on CPU.
>>> As GRO passes the skbs to the upper stack in the batches of
>>> @gro_normal_batch, i.e. 8 by default, and @skb->dev point to the
>>> device where the frame comes from, it is enough to disable GRO
>>> netdev feature on it to completely restore the original behaviour:
>>> untouched frames will be being bulked and passed to the upper stack
>>> by 8, as it was with netif_receive_skb_list().
>>>
>>> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>>> ---
>>>  kernel/bpf/cpumap.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>>>  1 file changed, 38 insertions(+), 5 deletions(-)
>>>
>>
>> AFAICT the cpumap + GRO is a good standalone improvement. I think
>> cpumap is still missing this.

The only concern for having GRO in cpumap without metadata from the NIC
descriptor was that when the checksum status is missing, GRO calculates
the checksum on CPU, which is not really fast.
But I remember sometimes GRO was faster despite that.

>>
>> I have a production use case for this now. We want to do some intelligent
>> RX steering and I think GRO would help over list-ified receive in some cases.
>> We would prefer steer in HW (and thus get existing GRO support) but not all
>> our NICs support it. So we need a software fallback.
>>
>> Are you still interested in merging the cpumap + GRO patches?

For sure I can revive this part. I was planning to get back to this
branch and pick patches which were not related to XDP hints and send
them separately.

> 
> Hi Daniel and Alex,
> 
> Recently I worked on a PoC to add GRO support to cpumap codebase:
> - https://github.com/LorenzoBianconi/bpf-next/commit/a4b8264d5000ecf016da5a2dd9ac302deaf38b3e
>   Here I added GRO support to cpumap through gro-cells.
> - https://github.com/LorenzoBianconi/bpf-next/commit/da6cb32a4674aa72401c7414c9a8a0775ef41a55
>   Here I added GRO support to cpumap trough napi-threaded APIs (with a some
>   changes to them).

Hmm, when I was testing it, adding a whole NAPI to cpumap was sorta
overkill, that's why I separated GRO structure from &napi_struct.

Let me maybe find some free time, I would then test all 3 solutions
(mine, gro_cells, threaded NAPI) and pick/send the best?

> 
> Please note I have not run any performance tests so far, just verified it does
> not crash (I was planning to resume this work soon). Please let me know if it
> works for you.
> 
> Regards,
> Lorenzo
> 
>>
>> Thanks,
>> Daniel

Thanks,
Olek

