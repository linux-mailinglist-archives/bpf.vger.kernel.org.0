Return-Path: <bpf+bounces-70532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1498EBC2883
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 21:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9A344F22B0
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 19:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73DE2E1C7B;
	Tue,  7 Oct 2025 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kk9f2mDW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1F5221F1F;
	Tue,  7 Oct 2025 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759865983; cv=fail; b=speJipv7OC8v876vQyHVTMMuWy6nhv4bi13BoMO4jhLEsHjz2fm6wz+HwSnwxWTjocgWLacfqnoPJSXiLmViGelFLhNKUyHsjaomL456IFoe1/hYlKbxSx96mdY/DeNhpQBAtBsbOIGAsjXR35/RQ7aSpJwMBnl7jHlvJjml3Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759865983; c=relaxed/simple;
	bh=KrNdT5O4iy8o5XlnMGHMGl7gW1vIvtytYGl35xutQCI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kpu8lMd5TwK666rK5r0SL7cpiS025R3PJOqXeN7rvq1SpAi+AIbrc52khE2hlfjAxAMz1Z+nCJoQE+DKo5l0c7uVoskvkSt6xhNBNkVnnae0uM5LGzCU1F1QCI4L64nXgwjqdbrniQpsN0wb8+OJa/elsgnpgIVrFS7xc9fWlsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kk9f2mDW; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759865982; x=1791401982;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=KrNdT5O4iy8o5XlnMGHMGl7gW1vIvtytYGl35xutQCI=;
  b=Kk9f2mDWBNdyJ17w5cEICFeVv5X0Q65G+tBDXP8XbmqkWXBVCdjO7hFC
   t6uIKKQI1nyrVtk0yBIvidAB4Hq8swibuDSLg6g6jSq7Su1uCTecTJEPP
   rgBpkGtzFYWo2j4v3KRbRSupdQM0VaxRpL2T8jVwLhc5xEdLz4TPm5hWu
   ek5J5QLXcSDgIXraerOWiaH4bg5ZoM+Q+YjLX5yJEjxOkZ1E6bfmqJvmv
   kXnowcSgp5XHpSHkCLaD89yjgvpkT9yl5wimax7qNDY//Nqb6U3tGxOYY
   TdKTe98SD90T0NDgP6BUgOs6hQuAnGjVftM9nkI8D5fO+iF30L+PeZzum
   A==;
X-CSE-ConnectionGUID: 84ON36PXTGOlZSv7pZqAOg==
X-CSE-MsgGUID: W+cdPsLfSJ+lfZd+Ds9BbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61974624"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61974624"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 12:39:41 -0700
X-CSE-ConnectionGUID: sXAPqcb2Q2Cqp0UDT4/jfA==
X-CSE-MsgGUID: 6DA5CIHJTtW++E7kw3zGBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="203960564"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 12:39:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 12:39:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 12:39:40 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 12:39:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5QBzhhiZAn/PflBD9fZzoDJ5Jr7JsD2QWsFSBWktxg0+GFqArQpmmKbN5wJYd2fprp/dby6vXE+vCUE7v14khhAzLZCvNDDVYyBpF74CqlX/TYb7I0EoWmYdRrlhTWgDWlH/OmOnWsTFGdROCsLZkPQdeX37nE3uYArHbznaX7p94Q2pKLIx6G1l4V07gxc8suDFHTXwDNjUW3QrF9L2UPBNdSDDjDbG7HRwfB7PZoA0I2sGBVx3H8c+lZ7c1bvBlJN4xfpy2GAJw9Wu1h1xyOYQi12B95vOhAPji78aOTauZVnU4uvLiz79P/cMX0PZ0YQ8KSPF8SBm4jjPomQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmbm88VLXAv/NTlDodZRvkStegSdRS2vJqpnUMP7/Zc=;
 b=yvCc964UiN1ZaAiJgdgdIhuMWkuQ9t+Z4gVs9ZQO8vtFOZUxJTvohVIKHty1SszYWg/9psGFI5XM554AqKWj4b6mrOw8HOqoDGhdKG1r4pDzemBZmOyhbK/BSa73bZ1rtJnFsbFURcbPbiaOMbuJmb0BiMmcG+jPT1efm777cYFvnnsgXJ4DW/BM3SLBjraOz4claewSbR2s+rkm2hL48BAujTR1IxwFBUlnu0U17r4crTdJNwEXow08vn4J0ptyoC9/LEQB5M+nTx3jfQIbh/Om5fIrgmA9E8qtbMx7yNZDvFbtTiO3yov3+EItpxfFk/I4uw1sgbzIRvVHzpbYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ5PPF263E38237.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::81a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 19:39:33 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9203.007; Tue, 7 Oct 2025
 19:39:33 +0000
Date: Tue, 7 Oct 2025 21:39:24 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Toke
 =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Network Development <netdev@vger.kernel.org>,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, Andrii Nakryiko
	<andrii@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>,
	<syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>, Ihor Solodrai
	<ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Subject: Re: [PATCH bpf 1/2] xdp: update xdp_rxq_info's mem type in XDP
 generic hook
Message-ID: <aOVsbMAkfc5gv0vO@boxer>
References: <20251003140243.2534865-1-maciej.fijalkowski@intel.com>
 <20251003140243.2534865-2-maciej.fijalkowski@intel.com>
 <CAADnVQLGocfOT224=9_nJZ6093QDh1M_EDLQ3cNVQZKEDnjwog@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLGocfOT224=9_nJZ6093QDh1M_EDLQ3cNVQZKEDnjwog@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ5PPF263E38237:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3933f0-458a-4b4b-dbd4-08de05d93d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjJySmU4Z1hOb0pWdjVMTk1hZXR4ZWszR28yeWVvR1RNMHlWcWZKOVFMZldW?=
 =?utf-8?B?bmNEaFZ6cFVoeUtxZ3JUTVZnUVRSMkppQXp5bWYzc1ZnSnFSZzlHWEprMm1L?=
 =?utf-8?B?WDdneklTdDRQMzdqZzErR2lHTkVKcm9ac2l6MElFbnFwU0VsMW9XdjJ6ZXFJ?=
 =?utf-8?B?V1k4eGY0RW9iSnFVdnhMR3Yxdk1QZmFyZktNeGZ0a085a1FuYmxxWUFrVVFl?=
 =?utf-8?B?c3M2eUdSQlVMSDdNOGRJNzE1Zk01K3JENjVPWHIwZmtsUEliTXBEckpvZlVF?=
 =?utf-8?B?NEVwZlFXUDdRUWZxeUdoa0ZzdlJSL3RSZlFxU0FoYk9INGt5QnZXSUwrUXJT?=
 =?utf-8?B?N2ZIRzB1V093YnYySzJVbzd6UG5JMVNHUXhYMExlS1ZvVWtQSVZFSnJNRHNo?=
 =?utf-8?B?Qk96SURMM3dXZmczdTFHSmtFUit1eWFOZmJkbk5DTWlrWDBwNXRsTFhMekRV?=
 =?utf-8?B?OXJZaUlhSUY4ZktVTS9UZ0NWbDNQMWpJcTJCWU55ZlE0M1czRXlFY1RsN2hV?=
 =?utf-8?B?OXJnTE9nT1FiTlhXVERUY2gyQXo2UnU5TDdDQS9qSFNESFpyZkNGYTlvU1pj?=
 =?utf-8?B?L1FQLzJvSEo4TWJjc1Izd0lPK3B6MzlYQ0kxRlo3ekhsVVM4UW5zVnEvTi9B?=
 =?utf-8?B?TzVVYnptY0RLZGZ4Z0lyVWJxVXNrakFZUVRpaDRDSkZyT1V0WXRjVGoyaTZi?=
 =?utf-8?B?SENkYVFtVExoY3BIQlFFTTFKRisrN09vVUpVN1lQY1dvL2h3a2dUVXFsa3FI?=
 =?utf-8?B?THlWbFcyZ3Vzd1VVcTBENTNDZ3lnM1BrT2dJdktXUDllRXI1M3pucWtHZ2k2?=
 =?utf-8?B?Zi8vVm1uVUtkZDJubmdlWUFoWFdtRWlkK1RLTlJabUZGbmNQcnQ5Qk5FdFRj?=
 =?utf-8?B?djlRdjdiM1hEUitkdmkzWHZKZlcxWlVPb2ZYVlRqeFF5Z0FjUzlFYmtqdEhU?=
 =?utf-8?B?SGprdm5FRUJRTWk1ZnN0YUdFeHJUV3BPNXMvemxyWlRheU9kb1IwN1FVVGNW?=
 =?utf-8?B?eEVUamw1cTdKcVpkdlFMOEJ1aGZOTU1YdmxpQXdLcUFYQlhjWW5tK0lsU1No?=
 =?utf-8?B?by9ib0thSTBzbVpvSEdjY1B4RlJCTFFBNFpkU0Vrei90TGJLRjNINnc5VnVk?=
 =?utf-8?B?RWhHOFB0VXBvekZiRjd5UmtXNkNPZjhENitlNWIzcmFVYkJncXZ4OFphY044?=
 =?utf-8?B?SDdMczVRbkQwQktQSmE5MUhWMnRjZ0JHcHhKWGtGbzhvNUZnNlRHNlR1Z05z?=
 =?utf-8?B?SFlsSzlYNUcxS3h0MlRiQXRRb1ovSWtmNS8rb2xOdmE0QVNPZW9PVmdNYnJQ?=
 =?utf-8?B?Mlg5RENidUxpaHhCNTI5QXl6V0lhM0tOVWFxbDZiRjM4UktHeEVhb1lNbTRN?=
 =?utf-8?B?elQxRFNoVjkyNmNiSjdEMW1KTVNtRExGcWtZVFhvcEFqZzdyZ3cxUVplcFFj?=
 =?utf-8?B?S1d2UUN2eHRsS2JqNFlUVVBXK0w3MUhOeHl4alhIdzBicTdFMHFvbDZHMVgx?=
 =?utf-8?B?ODh6QmhMQjdMbmIyR0tkL05BaHo4K0VzSmxXcnVnQ0VlRE5la3FMejJmTFo3?=
 =?utf-8?B?Y0djYi8rQVhhbS9VZ0NBb0lnLzFOUGl2VW1aUXVjWjRMTnVXajFmQ09zdGtG?=
 =?utf-8?B?allpQVE1Mzgzb0dUQWtmK3h3WEl0ZWo4VUZRK092bjJBaHVyV1hvUEQ3eWpS?=
 =?utf-8?B?YWxiN3J0WC93ME92aWRNOTR0eWF6NlAyL2xzVzdjaGVUSVVrb212bjNHdmhv?=
 =?utf-8?B?dGVuQTdYMmpEdGticDdmeWpCYnBtVmo3TlRncXppT0hSRUxRV3hzYVN1dXJ6?=
 =?utf-8?B?bWVpQ21xNytvQ2phQ3E0cEI3c05XclNwMWVNRDNZSG9yaUFjOW9iM2Z4NWo5?=
 =?utf-8?B?Kzh0bWYxdENOTk1wbUZYTE5zbDZlT0NUbE9kYWF6UzVJcmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alUzeTd4ZGNLUllHNHprUk4yZ214TXkrMnI2NkN2MzV5WkxORU9UR1hmaysw?=
 =?utf-8?B?WXpPLzRhMDFDUVNwaGQza3UrT21uQS9WdUVNZERmcEMwTUdlSzdBRnE3L1lF?=
 =?utf-8?B?UGRoUnRPZUZUUXFIa1ByZ0ZaSnVxQ2dKWGF0NUxhTW5WQ2JvclJaWGVxZUtn?=
 =?utf-8?B?Z1kxNmFXWHA1Y3VKN2c4bHZUd2RWbWRqQXBIU1RoWjQ0czdud2R6eStOVTRT?=
 =?utf-8?B?MWEzV3R0Q0NNbU53Y05rUzVlMjFzSXFuRWdQMG8rNDNoVFhTZFZJbVUxUEw2?=
 =?utf-8?B?Yjd3TXE0NFBUckNmTWJPTlJYeGcwdGRJY3dnKzl0UWd5N0hRNEJqQnJjR1N4?=
 =?utf-8?B?RVBsWVhpYXpUU1RDSlZiMHVHMWVBNUQ4RkhaREdrcnBFOXI1U1FQVGRBTFVC?=
 =?utf-8?B?dGxlVWV3R3RNVGRlelBsVEJoUngvYklPcEJiaUVhWEhPV0RmS2IyaW9HZzlF?=
 =?utf-8?B?MUp4Ti90bng2emtGYUdRSW5lVUJma0VJTTQ1YVFuVyt0L01rbmJRRTl4azFh?=
 =?utf-8?B?bG9naXhQL1lOVGVHYnhOclFaa3RUOUlrcEZndmNCK0kzVHRUclNsTWNiV2lS?=
 =?utf-8?B?c2IzL09LNk1pcmZSaXhGQkhlT0llRGIramhuUmZUbUM3bDNJWEVzNGZFV3d5?=
 =?utf-8?B?UDNOMTIyc01uNGdDR3lybXZVclNuQUozbFA5c0h2MzJoZkJFblppbGlRMjkr?=
 =?utf-8?B?OG9odkxEUTJzcFN1SHZPWVVRQ2hkZlkrbHVXQkZUYTJVcThWejBzcUo5cDVp?=
 =?utf-8?B?STVNUU5DRWZna1duTW1Jcmhpd3V4WU9TSU03QVZzMGgwemJCMHpYKzlrbS9S?=
 =?utf-8?B?ZkhtWkQ0c3dDZitXSlRIL2F6a1FablRBclJFa1FoRkFrQVBtLzdKL0pNRk1l?=
 =?utf-8?B?TUtWOEhHR2dTSkFrQU92aW9TWVUzLy9IWUtXUWdoQnYvS1owekcvSEFLcGRE?=
 =?utf-8?B?T0NULzR3bENrOEQ4UFBXS1Fqeis5MG15RGFyMU9VL0dXK2dNTFZnZmpIbFBa?=
 =?utf-8?B?dWJsdEtiU1JKVlJTMTliekRiam12ZkxnUFV5MWtHTUtzZVNWMk01eW9hUTBr?=
 =?utf-8?B?ekg0TzRvMWgvaEhkNWh1QTZSSWh3VGsxalRUSVl5QTgveFl4NldOQUxZUVZV?=
 =?utf-8?B?T3JRL1REMFY2c1p4YU5NaXAxTjJZcEdlM3pBRTNNaDV1U0dVOTQwU3FRM3hz?=
 =?utf-8?B?SHFqMUZDeW5GV0ZoZEZ5Z2JmY2FkaWl3OHdjVTNtcEsycUk1d1FSMkhYZmJt?=
 =?utf-8?B?WFpLNHJnY01DREtpTlUyZFpVSHRPQ2pSUjh2cmVTQlQ0MURDK1JVU296dUcz?=
 =?utf-8?B?RzlLVmFVNDJKbUJNZ1Vyb1pnek5NZTlXbS9mdXRQL3c5N3MvbXgvT0hvNHNC?=
 =?utf-8?B?MjJIeERXV25nTDlzM093aHFZNDdGWnVURzdPcjVIRjViWGZsNHowWTduWnZY?=
 =?utf-8?B?L1l2a3dQRkRCUGErQkpUeEkwWmN0eWwxK0ZWNnJNTU9tV01GVjlIbkhqTkNr?=
 =?utf-8?B?SkRLeU5QN0RCWU5UNkZQZXFBYkdUNE1IcmQ3UmhvVTFyNGpDOTZwcnJsZkdv?=
 =?utf-8?B?cWVxcW1aelFwZFNrUFVCYXIxVHNVZVFwWjV0citNdFJ6MlBSYnFjcEZ2bEpS?=
 =?utf-8?B?TWZjUnlQbWY4Zy9pK0pCYTUxU2NyYkJFNWl4aUFsc3l1N3A2bFVXWG1RUllp?=
 =?utf-8?B?REJ4T0JmVnM5YWVhQmFIejZrbVdQSVZPKzRnQUdJM29TRTNqZWttdUVCbit5?=
 =?utf-8?B?VFVCN2wxRjFaUEVTaUxUSndqZ3pPeVphSnRxaXZsa0h3TkVNUE16UjJTUUJQ?=
 =?utf-8?B?dGhSWXV3UlVUMHJNSWJVakJFZWdWYWRrL2Z3WGlUakdCbnpXaitvYXFDMERM?=
 =?utf-8?B?Q3FURGJPNGt1WGJkK0s0TGphTndEL3dnUUpkQnBPR3RzWXM0RHcveU9vV0My?=
 =?utf-8?B?K3NOWHRWc0trdFp0ZkkreEI0ZmZlQ0hwTDgvMHEzV0xJbnFZREN3Y1F3dU9Q?=
 =?utf-8?B?NDA4eVJacGVaekZ5eUZ5TzVBdTdJUkpXUjZNaVFmN2tUamNWVEtwd0svNFFU?=
 =?utf-8?B?YnBPOGg4WkNaMjJxaGMzZlNhS050Y0pWMW9RMDNnRzJiVmIxR1R4NzFhRldF?=
 =?utf-8?B?R2Z2cklWWHRndkxsOW9la1VkQnEwdmQrVjUwSkl6amlXWkV5RHNlMFArWGJU?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3933f0-458a-4b4b-dbd4-08de05d93d5c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 19:39:33.1117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0B4qVQqFH8pUpRcNhPqqi1sWBFa1+BHVEqNoRg9bM7aQdssMKF3XUZrMG50HrIzVMr+ayTtMUiQz2zFHxMsjOGUfQ0vJBtuhHGhrD07sko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF263E38237
X-OriginatorOrg: intel.com

On Fri, Oct 03, 2025 at 10:29:08AM -0700, Alexei Starovoitov wrote:
> On Fri, Oct 3, 2025 at 7:03 AM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > Currently, generic XDP hook uses xdp_rxq_info from netstack Rx queues
> > which do not have its XDP memory model registered. There is a case when
> > XDP program calls bpf_xdp_adjust_tail() BPF helper that releases
> > underlying memory. This happens when it consumes enough amount of bytes
> > and when XDP buffer has fragments. For this action the memory model
> > knowledge passed to XDP program is crucial so that core can call
> > suitable function for freeing/recycling the page.
> >
> > For netstack queues it defaults to MEM_TYPE_PAGE_SHARED (0) due to lack
> > of mem model registration. The problem we're fixing here is when kernel
> > copied the skb to new buffer backed by system's page_pool and XDP buffer
> > is built around it. Then when bpf_xdp_adjust_tail() calls
> > __xdp_return(), it acts incorrectly due to mem type not being set to
> > MEM_TYPE_PAGE_POOL and causes a page leak.
> >
> > For this purpose introduce a small helper, xdp_update_mem_type(), that
> > could be used on other callsites such as veth which are open to this
> > problem as well. Here we call it right before executing XDP program in
> > generic XDP hook.
> >
> > This problem was triggered by syzbot as well as AF_XDP test suite which
> > is about to be integrated to BPF CI.
> >
> > Reported-by: syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/6756c37b.050a0220.a30f1.019a.GAE@google.com/
> > Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
> > Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Co-developed-by: Octavian Purdila <tavip@google.com>
> > Signed-off-by: Octavian Purdila <tavip@google.com> # whole analysis, testing, initiating a fix
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # commit msg and proposed more robust fix
> > ---
> >  include/net/xdp.h | 7 +++++++
> >  net/core/dev.c    | 2 ++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > index f288c348a6c1..5568e41cc191 100644
> > --- a/include/net/xdp.h
> > +++ b/include/net/xdp.h
> > @@ -336,6 +336,13 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
> >         skb->pfmemalloc |= pfmemalloc;
> >  }
> >
> > +static inline void
> > +xdp_update_mem_type(struct xdp_buff *xdp)
> > +{
> > +       xdp->rxq->mem.type = page_pool_page_is_pp(virt_to_page(xdp->data)) ?
> > +               MEM_TYPE_PAGE_POOL : MEM_TYPE_PAGE_SHARED;
> > +}
> 
> AI says that it's racy and I think it's onto something.
> See
> https://github.com/kernel-patches/bpf/actions/runs/18224704286/job/51892959919
> and
> https://github.com/kernel-patches/bpf/actions/runs/18224704286/job/51892959937

How do we respond to this in future?
On first one AI missed the fact we run under napi so two cpus won't play
with same rx queue concurrently. The second is valid thing to be fixed.

> 
> click on 'Check review-inline.txt'

