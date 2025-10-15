Return-Path: <bpf+bounces-70979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 818F1BDDF7E
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 12:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1804419C0A86
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 10:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3859531C596;
	Wed, 15 Oct 2025 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IFmWoiDr"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C37C31BCAD;
	Wed, 15 Oct 2025 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523954; cv=fail; b=V2rymrTJfOqp0PL3vqdM2ksRANaEGP9c7CnShCzNRdSXUr0KbiX5bdyExdnMLZMJPr8FXBMzNPgh0i5OMKumU6KomOXUjLFHt7iAgYbw0iWzWh1fhVrT+LDqY34wHGxt0IBhdNbZ6wNAazOW+sKH4/ozMULeVPzHeOPYgcCJ5E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523954; c=relaxed/simple;
	bh=NTvcZ5wYaBGJcyPoFM1LMsFcw6E7yjdGN9hz3tCta5c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p16LysVjNlzeEZIRmRHIRvT0eyKGihWwmPo1+SJdyiNRWj/iQu1c2aVYD9q6/QTF+dHjLjUUPZkIFtdDqeWbVxiCcIrk2UDaaeh/e5gxEsfnQ2tx/qAyIC1UdtXeYT0W0fQT4Q0VG+MjV2eaM05dXnZT659tin6BmWm8xRz0T4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IFmWoiDr; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760523952; x=1792059952;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NTvcZ5wYaBGJcyPoFM1LMsFcw6E7yjdGN9hz3tCta5c=;
  b=IFmWoiDr/HpD6PG75dohGlUZk3/le7sp3tZ1HtKzKHz2tNXfKmpEkSyw
   p3pH6L2apILelbswDMKbX+sJAxeN+uFCGSjZ/E0XVMV/tzSRw/F7WEbtG
   UEulk+q/TMYHI8vOWJN/QuCAHplW3y6IgO7chQshdxm7dLs2KdP7x35Ty
   WVjyaOHRPGPLnOBMTDKeeAwMYEhLOMJnf9YazRjLYj0VqZna2WSbo6Pff
   hch6xrdJWJRGpWCsJPhXr9+bKX4QplLpmqtId3qSXk4fvIAl33xviUtNw
   HDCYDngOk7kFqseEKBBH5T5lht2ErMxMJtx6cgczy56dQtsgHp7vAckhA
   A==;
X-CSE-ConnectionGUID: jS9ekBjoT265MvL4eVI+RQ==
X-CSE-MsgGUID: tGKnCuB0T4+H1InGTcubPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="66557259"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="66557259"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 03:25:51 -0700
X-CSE-ConnectionGUID: vJyUGPgjRUaZ1oOSXEBKIw==
X-CSE-MsgGUID: 88cJ/0eGTJ2DjnU1WlKgcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="182083658"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 03:25:51 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 03:25:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 03:25:50 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 03:25:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGzjdOwSnQzblvhyXVK+rj6GRQ9A5Dz8HLUBpCBds8PT03Gx/yGCF7Q4We2ROvFGIXXzHGHkOy6gq9Mw2gK8J0L+V7gwA/sAcMN1Xv6EFVwy2+Jp5VHVSCRfitNJq3yS7a0BXGcN/nU/yb+fyxa0wQ9sZHTzLV6SdZBgslsFeu7B07ccvDZXt9KM0+AW1+VVEoq+XeblNkxRQWlW1pQIYyKMn1ChIac8aCQPWGddTHUox/faY0FO3jXMPN0w4/OC7GjD6WDFvnPmmtnLQ0T2gpO5PnQv/qseG700wXa8zVyzHxq+/57c7tWYijsHnf5Q49BMrQ55TkeybTjqOJTxSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3QAvcvrmZQ3OksNXIGHw/co17UFAAOVdoidvaot0NY=;
 b=IV8sg0QHEGDjED20Wv2Y/z1m1EDt6fX6MCpSWeIW/pMNx4k5b/m4nDZkYMyD7GUh035RJuhIcvgO9evGe7BXr6EJtPsG3GniFYX3o/dS/psCtaMRqbM8nV6j+DiGo13x4r1uD+JxpBAb4y8bTbnT9k3FsPEkCjhUAv92pAAcu8ME6seQuN6Pz81HTLGsZZqJKLevyFoCeHpmGRcg/ehn0Lq1gl6wPvCdaxbKIxUP9z6CtogzX6+G1k5I0V/uuRff4ZlpJgYJRw6ZnbDrVZXU7EMFDVKxLTMHiTiunMmLcWbmlxjTYW/1iEdCAM7LhKYCAeuFdEkEMoWC+BJ8vlSKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12)
 by SJ2PR11MB7575.namprd11.prod.outlook.com (2603:10b6:a03:4ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 10:25:48 +0000
Received: from LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c]) by LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c%2]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 10:25:47 +0000
Message-ID: <2a261520-1d86-43d6-af56-7c5f9366c76b@intel.com>
Date: Wed, 15 Oct 2025 12:25:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [lvc-project] [PATCH net v2] xsk: Fix overflow in descriptor
 validation
To: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
CC: Magnus Karlsson <magnus.karlsson@intel.com>, Song Yoong Siang
	<yoong.siang.song@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
	"Stanislav Fomichev" <sdf@fomichev.me>, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
References: <20251007140645.3199133-1-Ilia.Gavrilov@infotecs.ru>
 <9e946bb9-2629-485e-ae89-5aa8c4930a4d@infotecs.ru>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <9e946bb9-2629-485e-ae89-5aa8c4930a4d@infotecs.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DBBPR09CA0044.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::32) To LV8PR11MB8722.namprd11.prod.outlook.com
 (2603:10b6:408:207::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8722:EE_|SJ2PR11MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be709ee-af83-40eb-7934-08de0bd534dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjQ3aGwrRW5ReERqeEtzNkRlY21XTE1CdXFTRERLYjRuUCtMRGV5WkdsU2xu?=
 =?utf-8?B?Nm1CaTVUMTZjNk5WM2k2ck91ZVM2Zk5IQ3lzUnMzMFJGWm9lTktvenYweFF0?=
 =?utf-8?B?bUxSRXIxVmY1Q2pkTkk5ekU3UHBPNDF6OSt4ME1zZDFNQnROOER2R2xjbzNG?=
 =?utf-8?B?dkt1dzh2VGtaSGF0NENVUUpxQlFROHZGTWE4ZThUbjg1YlRObC9lYnBJTmxO?=
 =?utf-8?B?MXNaWXpWdTlJQ2xwam1iMERLL05leFZsQStHL2phcnJEaENiU25pL1VqT1hF?=
 =?utf-8?B?WEcwUnkyN090WFhWT1hzZnNUTGM0eTB5ZUVYTWFHMjZOeGc1QW93K1NhQ1FX?=
 =?utf-8?B?Qk15SnhWZ04wa0t4Z00rcnBSRGFXcEtDcFpaQVp5azdMdE9QaFVqcENTSTBP?=
 =?utf-8?B?Y1BRL2E2dnIxdzJ5RHRtWTNLSTdRQnY1cW0yNk93Z3FnNVNycGJTNDZXbTRY?=
 =?utf-8?B?aVhFLzJDOUZiR0ZYKzYrdEtoVDZnMm4rREJPSmFWbmw1Y0lUbmU4OXVLR1dF?=
 =?utf-8?B?VHpnR29PQk5aSzNhUVUwUlNhR2RYbTk0Wk5rNzRSeVFUMmRXWnViTHE5eFZr?=
 =?utf-8?B?MGxIaVVEak1sWWxFZUk3NWNkRHpRQ2dtWE1URjlNNEZ4aWQxWFN1S1diOVlw?=
 =?utf-8?B?d2ZKNTlsTi8yTjh5WDFyNTRDMUprWlgxN2MvbllkaFBORnBQRjQ3WE9ZejdC?=
 =?utf-8?B?d3ozak4xMi9xbjl0MzhwanVWREI3U2NuaS9FTzkxcUcxWm9kZ3c1REpLWlo4?=
 =?utf-8?B?UEFKaW9XcHRYemZDcW82akdOamM4Q1l5SEpJeXZaMXYyOXBTMVBLUGdrM3FO?=
 =?utf-8?B?Q1dsVzdMZW1sUG9iMkdoZ3dvQS9JUDF1SkNpWUhKQ29KL2IwUWdhd1VORXg2?=
 =?utf-8?B?VUVPK0c4MnQveGx3M1BYMm5yYlNVdGpZUjBRYThZbWFZRG9RUC9KZGZSUzNE?=
 =?utf-8?B?SFExa3VEOWc1ZXdiL2pER3l6amJNdTdHT0JaaHpBK0Q2SVFLSmFSNmNNK0R0?=
 =?utf-8?B?QVFENjBnaWRHUVJvWS9taFk5NW9icUsxblJLRDUrQzIvb2JXY2tubXdqQlpz?=
 =?utf-8?B?R2V2QXI3KzdGd3hsMmZ3Y2pUYXhtMnVteUNVQ2k5RU1Pc1c2bW81ZmZwa3FY?=
 =?utf-8?B?OTdIVjFZeHR0RDdRbGc4aHFrOFFoS2NHMW8vQWYrZHJyOTdLQWE0dTZYVGZB?=
 =?utf-8?B?TlRGU1VCbnRQeERuYVZIY3lBMHBvcE55a2U2Wlp2ZTVSUjM3ZGt1Y3JPVGVq?=
 =?utf-8?B?WTFrdWVUUU9zcWNQZlp5Y0tIT29ocVBjMVlNNlhHL1dncGZROThoK296RUE0?=
 =?utf-8?B?d21NbGc2UzB0ZWZWMmYyWGxCNjFHTFhoMkM4ekFUT2d6aEVReWtlWHdqcC9u?=
 =?utf-8?B?cjB0d2wvUjU3WkR5ZG9TeDIwSmszYjFkZUV1RjVsekgwS3Fad2N0aGdEK0dJ?=
 =?utf-8?B?MWoxN0F4cER3SUh2cUtYUFM4N2ZSYWR6UUpyUnBUbGNOWWpFV2FxU29YeUZ2?=
 =?utf-8?B?Um1PSDBrZStObEpqNGx3NUxLOFhOcWx1ZWZqT0hRWmFRZ2owTGZpTVVpWncz?=
 =?utf-8?B?d1VQQ1dVaGNoakloWTcvT1JWVGl6QkMrczNmVlc5dHNKWHQrYTBCNTRWaHRi?=
 =?utf-8?B?RTdSNG5YUUlyeS9VaWxYa081S3lhakR6dDlydmdoODhvSElERkV5cFBJeUo3?=
 =?utf-8?B?U2VRUkdUUlFOd1hyQUcxRmJob0FOVjl6Q1ZZRWl6cFdCVDArZWp6a0dZL3B0?=
 =?utf-8?B?dVNhbHgrSTAxN2R6UGdsWCtGaWtnY2JzWmZkTDJ1NGVjTkNVN1BKZ2k4blBj?=
 =?utf-8?B?cjQ5Q09hVUR2Q1YyejJqd3lyYnYwRVV6TlhINHRZcU90TGpVUHhZSmdmVmFm?=
 =?utf-8?B?UDlSazA5ajhMcHZqWkRTNm1tMUd3S0NiSTRrQXFVaUdiemcwdXpsdmFFa0ZC?=
 =?utf-8?B?TVMzUC8yNHdrNFFDRGVBNTBFcGs5bFFWWk5rajFYZndUdXhpYmc5dXEycDVr?=
 =?utf-8?B?T3AwQzBFaWh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8722.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWhwZk92ZXZoK21mM2ZZb1BrdlU5T1NHajU0RS9Nay9GbEo5Mm12V3JQTDZp?=
 =?utf-8?B?UTRYZThlTmpyR3hDdnBHa05ia1FMTk9EYnY0RHVRWnF3RTRQSUJVd0RnMmFV?=
 =?utf-8?B?b2VKL0EwTDdCUXZTL2lzc1lrUWlFMFA5dUswdWYzOVBQYVhCN3M3aU1salpq?=
 =?utf-8?B?YWZ3bkI2N09sb0ttVWlWbzNHNis4RE1YbE9pQmdEcnpHVGFHMldvUHlZcDd0?=
 =?utf-8?B?VkdRaTdsUll6dEt3VWFBdjIzNnhWQXcraUh6ZXFIUVlPaDA3NU5BNmNyeFBS?=
 =?utf-8?B?OG1NOVM4OXpCTi9UVmptQ2EwZHhKZThNS0Q3KzZoTGVuOGhoSG5yTklZb3E4?=
 =?utf-8?B?c2tpRDVWVHREc2VEekJMNXhJa2h4QTd1UDhpbUJEenFFcXVSRW1mVjV0OE9z?=
 =?utf-8?B?Z2lDMzVmY1ZucTZsOG1vQ1pJamd5SnRJRTE0VWczRVM1Q3gyNkdXb1A3NW53?=
 =?utf-8?B?cS9NVXFRZWVqNHZ1RTJWQ29ZOFZINnFsSE10MmJnL2ExMTROU0o3Y3crVWRs?=
 =?utf-8?B?YWdqSy9ZQ1JtTk9DRlpJY3dLb0Z3dStjZW5reWRGWmNMUENXMEFMc1V3V0cy?=
 =?utf-8?B?aFpTNGRnWXd0T0x2VnN2MHNjWVVrT2NpK3FYOUhZWGhnbWpoWUVLckhld2Zn?=
 =?utf-8?B?WW5xU1cwSWdIa1I0Q1I3OHlRTFpvNEZVT3JubW5VRkIyaHhETG1JYlFNQWtE?=
 =?utf-8?B?RVU0TENSYUZFNXVpeUlYNitjejd1ZkpHbjIwMGVuNE9yTFM5Nzl5RzA2VlZ4?=
 =?utf-8?B?OTlvWDRienQ0MkFJZDBlSHhiZ2I5ck1QV2VUK3dMcVcxS1Z4TUpubldTZmln?=
 =?utf-8?B?ZjlNd0ROOC9ydzVYVXkzMWUxaWxWN2h5eW5qYU5kTzFNWG5ua3FWZk12cUlG?=
 =?utf-8?B?dkZ5QUllR1gzS2JOS2J4SEhvQXBWQXZtK2RYajJDMHptM1FnL0JwY2hrT01M?=
 =?utf-8?B?dmdkMGJqYStwL0JYQnFRbkovZ2NIVHNGM3piOXRFT0Nka0g5d2dRdjhJUEo1?=
 =?utf-8?B?WkdiYkFqd3lSbGJDV1RsQkV4TWJMam1wSXNkTHdMNzJ4VWZIM0xNbTRPK3hl?=
 =?utf-8?B?eDNYRXVnbGdwWVh1U0dnaTBNSUUxWDFJNWtkMTd1eHhlK0MvNjBpL081Mnl6?=
 =?utf-8?B?T3A1b3pqZGFMV2RIdlJZbTRydGhWKzF1NHZDNG9nQk9kTEMxRTdONUZ5SEtu?=
 =?utf-8?B?TjN4c0JaUTNRYzkvQURpSkN6YXlETmFXMkRvcGtWcTZNREdNODJwcWN6Ly8v?=
 =?utf-8?B?ZnFHdE0zUlNQaXZuN3lwWnRzZlJ5VXBpcTdzS1FiU2grS0QxVjNvUEFhVElU?=
 =?utf-8?B?SS8vWnc1bWc5LzlJWGhoNnhrbXEzWHJTU0FFQ3NWV1pPTkdETHFxczFsVGQx?=
 =?utf-8?B?aEVBQ0xtcktXeVpFYVU2SnpVbnpiYmdVNzZsMmc4bTZZMU1VdnUyZlFxSGJI?=
 =?utf-8?B?WFJqa2E4Z0gwQ0dQdmRhazJ1ZHkxSUIwQklrbGlSY0dMMGh0UGZ0NktUZ0xJ?=
 =?utf-8?B?MWNEU0E4RWFDbUJtWXpNRHloWHFpZTRQaGVVOTRCdE9HOHMyUmZwSWc0dnJx?=
 =?utf-8?B?S1FmRDF5Z2tGNTFtcjlYWnhuY0phTlR4VXE0UGhPSnRQZUJkYXBKYlNCWW5O?=
 =?utf-8?B?S2FsVjlwZ3E3aU1BVXdYSjlyU0lTSEFrMThRUmI0NXdIUmY4Q1FsYlFXK1Rz?=
 =?utf-8?B?a2FWaGR3Qkg3dmRlS21DRlA3MTRkeHJFT1pDMTEvckFtTEYvWk9VWmE3bUpq?=
 =?utf-8?B?WTRwcUVOU1FyNkZ3SHFGYjZGUnkxNmNNdDcya2laK3hyUU04bVU2S0JKbkRn?=
 =?utf-8?B?ejk5NXhnb1ErRHJ6L0VGSVpSRStodnNPTUV6RWpnQlo0WUFnMWliWFdhT1hB?=
 =?utf-8?B?Ni9kZ0p2ZzdNVmNHdDhLT3djNU5tcEtwRTQ3R2JWMzN2R3F6L2tsZVhFWWlD?=
 =?utf-8?B?VUl2d2xmMm9FRXZPOXV3eG5nLzJZUVdhRDBkUWhFb1hsQlk1U05QeEpEUkth?=
 =?utf-8?B?M3Vhb25xS0pRblNDaVMxOGhMVE5YWW9kOVhpSHY2RElQRHNObkNmejY5VGlv?=
 =?utf-8?B?NXJvUDlUQUg2SjBEZ3hEWGtRVzh5UzFuZmtwekhFMUtZWUd6M1A3RCtZKzBB?=
 =?utf-8?B?NlRLRU1VWUQ0L2JSNmdLYWtTRDRsMzhneWZ1VTNNMWhIOGtxSEZrOUtDT1hn?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be709ee-af83-40eb-7934-08de0bd534dd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 10:25:47.8447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2nbFvj9sBDIWvPzmYf5G0oAUsTGi/t3JanvV1sc22Fb1a71fGIjvcIDkECXr+oXS5f0gLS//jwnAIg4pJgMmW/s54KysKxLDipCsP10RUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7575
X-OriginatorOrg: intel.com

From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
Date: Wed, 15 Oct 2025 08:12:20 +0000

> On 10/7/25 17:06, Ilia Gavrilov wrote:
>> The desc->len value can be set up to U32_MAX. If umem tx_metadata_len
>> option is also set, the value of the expression
>> 'desc->len + pool->tx_metadata_len' can overflow and validation
>> of the incorrect descriptor will be successfully passed.
>> This can lead to a subsequent chain of arithmetic overflows
>> in the xsk_build_skb() function and incorrect sk_buff allocation.
>>
>> To reproduce the overflow, this piece of userspace code can be used:
>>        struct xdp_umem_reg umem_reg;
>>        umem_reg.addr = (__u64)(void *)umem;
>>        ...
>>        umem_reg.chunk_size = 4096;
>>        umem_reg.tx_metadata_len = 16;
>>        umem_reg.flags = XDP_UMEM_TX_METADATA_LEN;
>>        setsockopt(sfd, SOL_XDP, XDP_UMEM_REG, &umem_reg, sizeof(umem_reg));
>>        ...
>>
>>        xsk_ring_prod__reserve(tq, batch_size, &idx);
>>
>>        for (i = 0; i < nr_packets; ++i) {
>>                struct xdp_desc *tx_desc = xsk_ring_prod__tx_desc(tq, idx + i);
>>                tx_desc->addr = packets[i].addr;
>>                tx_desc->addr += umem->tx_metadata_len;
>>                tx_desc->options = XDP_TX_METADATA;
>>                tx_desc->len = UINT32_MAX;
>>        }
>>
>>        xsk_ring_prod__submit(tq, nr_packets);
>>        ...
>>        sendto(sfd, NULL, 0, MSG_DONTWAIT, NULL, 0);
>>
>> Found by InfoTeCS on behalf of Linux Verification Center
>> (linuxtesting.org) with SVACE.
>>
>> Fixes: 341ac980eab9 ("xsk: Support tx_metadata_len")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
>> ---
>> v2: Add a repro
>>  net/xdp/xsk_queue.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
>> index f16f390370dc..b206a8839b39 100644
>> --- a/net/xdp/xsk_queue.h
>> +++ b/net/xdp/xsk_queue.h
>> @@ -144,7 +144,7 @@ static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
>>  					    struct xdp_desc *desc)
>>  {
>>  	u64 addr = desc->addr - pool->tx_metadata_len;
>> -	u64 len = desc->len + pool->tx_metadata_len;
>> +	u64 len = (u64)desc->len + pool->tx_metadata_len;
>>  	u64 offset = addr & (pool->chunk_size - 1);
>>  
>>  	if (!desc->len)
>> @@ -165,7 +165,7 @@ static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool,
>>  					      struct xdp_desc *desc)
>>  {
>>  	u64 addr = xp_unaligned_add_offset_to_addr(desc->addr) - pool->tx_metadata_len;
>> -	u64 len = desc->len + pool->tx_metadata_len;
>> +	u64 len = (u64)desc->len + pool->tx_metadata_len;
>>  
>>  	if (!desc->len)
>>  		return false;
> 
> Hi, Alexander, Magnus!
> 
> I'm sorry to bother you.
> Will this patch be applied or rejected?

Hey,

We took a different solution: [0]

[0]
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07ca98f906a403637fc5e513a872a50ef1247f3b

Thanks,
Olek

