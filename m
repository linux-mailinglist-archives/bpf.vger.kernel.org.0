Return-Path: <bpf+bounces-55452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6AFA80C55
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 15:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B104E6093
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 13:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B65B4AEE2;
	Tue,  8 Apr 2025 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mXXEkDB9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD4B3C00;
	Tue,  8 Apr 2025 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118609; cv=fail; b=QN+jMwCesCxxlm4QPYgLCPYM4fa2uBsDXtqlQGR+h1yf7fVS0N/MxpugM4ydYLHHWp+qFMSzJokUIbpWYgfIw6yfYBbkONOTkRq51ewDoxWFQ9+V1AgwfM7vfnTmoujouAAx/1cABqk5NipXpJYTKDa8DlAmAKyNB4uS6HWAy4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118609; c=relaxed/simple;
	bh=5sad7CMSlrL4GLKc64iRejOPHPoJOPNQNnfDN3JjfBE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UHM7KhYYosQc20ietN5/f9/svm6JhnjfQQmaRa40Cvck0B36vc4dXXzhQrLS/1qtH6ASUOMbUwu0H9ZROnJSI07DyTg5KWTM9DwW0kLvBhdwo75Tc65l487ofqls6LlVvacunW3VnsmuD3XshZZMJ+mAznn8TXX7r4LUCiZFTBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mXXEkDB9; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744118606; x=1775654606;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5sad7CMSlrL4GLKc64iRejOPHPoJOPNQNnfDN3JjfBE=;
  b=mXXEkDB9bEceBevT3tNIB0bxkjrDRnrYKm1tQGvcOkGGi0KxjFqx7lo4
   vpnSzdJd5D7C6drJKO+9IYTvSHkzp3fFFfWe0n3YXYvLEVBJUOkF1mIjE
   faRhTlWU5aT4KzGd2lgEbJy55An7OrcRhPtcFOWPr9aMS/fsJilU6GnET
   X7jPqDmgMDblLWFq27aTVH0Ylx6Oy9DONf9rFPewqLt9/OQNOz4AG7YHT
   Bf/HTRJVOZKHkluJD+e+k3eRMchKZ92n9QpyqRV8fsJ0yv0IKxiBToB4a
   mOZoFGAt0c79DhFad8iXv8oSm88TGUaFSdS0kZNIVKXLWu83n/G9DUb5L
   w==;
X-CSE-ConnectionGUID: 3O7Cf6lQQYaXYMvxNO1lbA==
X-CSE-MsgGUID: oZ3sKAYaRM6Ga32X7SQ1Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56189321"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="56189321"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 06:23:25 -0700
X-CSE-ConnectionGUID: H/nR2Gz0RjmjD7ezUntB7g==
X-CSE-MsgGUID: zqRBxI5xReC7Ate5JOoeWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="151457553"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 06:23:25 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 8 Apr 2025 06:23:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 8 Apr 2025 06:23:25 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 06:23:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oj1Y9GA8JcybfuqtPuxwCTqCWPL1B4G3hdxymaIVRT7GDTwV7rrn5ajqaZDuj5NldQn/sjYqySjfzgDJ5Y7dpfbj1KPoICFBfFkCyYOKUVbg1+jyTuKoQwr6C7yvLyANjIEqbdX1dPwozRFpPzJXxBaEekOoMQDKlALkPRaRQhrGbMkXRsGIC9m5tebEzMbOHuDhV9rRNnbs4KPj/lqNDEq7rgedDiujIHr4sddUEouH2vcjmaebz5IcrrxBc8vHQn1UbSpyc+PBMw6tIFrFewRqczRWleMqWrXc2qip4CO17Ne3cw7bFYJl8Vn+Rvh1H898YtfSoveqzx4YKiP9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+h78xgCM68g3HjAVqp1K/U54tDasXaWCipAUP5H5kI=;
 b=RMrv8VtWLJK3gXhxEQ4bdWcQouZDdfVC6Q0AN0B3Jh79plomW8qDu7WxF+DtqBgJWgz0wb8hNBXpkkS1nfYhZfLMsIAZzOFk3Lr9koz+EfflyBFjnX0Oq8qHEgOhfftsxwql8/tF8HPCQ/pAO3UeaSP49k9AB4o/7qP9A5r2pq4AegeMy0zi3UGWabwGB5VWs5EFskxFPuggBB8NnxOJyfBDXUvD57ei1WLeC7OfdUpNG8LJKctx62LeZms7RQcLKfO2Cy/l7+EfMmyoQ2RVikD+H6de0ytazGShkkO0gMnB3+mOHmPKe7/nRqKO0hZZ50FhJ499KgEqWBis3l62Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB7794.namprd11.prod.outlook.com (2603:10b6:610:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 13:22:54 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 13:22:54 +0000
Message-ID: <cba0216c-c87a-421d-bc4d-bc199165edbd@intel.com>
Date: Tue, 8 Apr 2025 15:22:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/16] libeth: add a couple of XDP helpers
 (libeth_xdp)
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-4-aleksander.lobakin@intel.com>
 <Z9BDMrydhXrNlhVV@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <Z9BDMrydhXrNlhVV@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0036.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::9) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 002b96fe-0336-4b95-a6c1-08dd76a07840
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXpkaW5ZekEwVFFMT2trRzBRNkxWM2ZhcFZsS1FQODVhZ2NYbjdzcm1qOXZE?=
 =?utf-8?B?aFBwSlEyM1RtRU1PaWdIVElEeHpzZUN2MXA3ekI3S2E4em5ZdEEwWGMzZUNi?=
 =?utf-8?B?VHBvRm4wOCtJd1RoUWtCK2ppNk5ndUNXOWQ2SjRnMnlBekpvTGFiMUE5MWNx?=
 =?utf-8?B?SFpNZW9qYXVJK3BiZHhCMFh2bXc4ZXdDUzNaM0JWZmppL3FPdURFMGJwTXpo?=
 =?utf-8?B?ZTdkeDh3NnRVbXdzTWlsUHIwODBzb3RaYXlyeXQrWXc4TEY4TkJtK01RUzJU?=
 =?utf-8?B?ZFRCcDFjRkRwanlMODJ4cm1HYXNJaDJ3NlhrWWdaYWExT2N4M3Qza0E1Mmln?=
 =?utf-8?B?bE9TM3BDSkZlZ3RzQ3hEYUdYUENxSWl2d2hzc1VjdXcrc1FjZXF0eCt3Y3Uz?=
 =?utf-8?B?aVFBakZHQUluazJ5cjExSjVhQkxWWGphR1dDZWcxeVZ1VFRhSkFlMGo1bmZ0?=
 =?utf-8?B?VEZEZGdLVFVhNlJ1cVpPY3VjaUJTT25CSEJCM3ZFaGltUTJsN2R0b1ZLUnhE?=
 =?utf-8?B?S2JDbHdlMlJXU3VHZVpKRXE1NnZ1NnBXUWZ3TnYxUTRxeHZiVFkwbzJrc1NP?=
 =?utf-8?B?UExsdUFxQ2lIaDNhdE9VQkNsSktKcGs2Q2xKUVZqRDBDbVgwWm1UOW5XNGFW?=
 =?utf-8?B?WU12Q25HdnpyZzlpRzdYTytOQUtZNmhQalZNT3doLzl0YVM2ZnY0ZVlVSy9E?=
 =?utf-8?B?RkRVelZCSkRUVFpPc3NNTm5KbUVuc1c2aXV0RDJlY05LM0lySXZIOGtzRnA4?=
 =?utf-8?B?WDVLZkFJZy9oWTdJZVFxbnZLSHlHLzJqeWlLeURUeGIrcXNzUHBiZi83NE9K?=
 =?utf-8?B?N04vbkpvOXVyVU91b1BGQTVFRVFlQlhudk9vcG4ycHY1dXQzTlNub0l4dlk4?=
 =?utf-8?B?d3NVV2ZxT01LY1QxOVlCakdWdWZReUVjQ1lXRitYUnlHcFg3dG0rSm95bkx3?=
 =?utf-8?B?dUFWRDljczA4a1JRQ3VGNEdpM0tod3k5VGVaZEFsZGN3WTRDT1pKTUFUMEow?=
 =?utf-8?B?dnh6b1pmeDM4RlRUcFhlTDc4SWdaWmlWSDNQY090bVc3RnNYSWVBMEVOZUxV?=
 =?utf-8?B?Y3RNZDdmSmpHUGJJY3F5aU84UE5iN0pWTTVVMGoreVJIZDN0MHpaeEcxZk5k?=
 =?utf-8?B?VllIZWxib2NPTHB3ZFh3UUJzNlY5QW9zQi9hemkxVnZLMFN0TnJyWmJHZS9S?=
 =?utf-8?B?WVVtS3lTMnVzNjZKKzFjRDFLdEVGQnhTZkNtMTU3ZkFlVU9mbXc4K3lmN1VM?=
 =?utf-8?B?eTR1OTNyYjkrUzR3T3dWRHhlQk1hYlQ3d0hScm5uTFdvVCtaaUJLSytkMVdR?=
 =?utf-8?B?N2ZycHFwajQ2WnJrczJFM3kyZHM1K0NOM05mYW5wUGM4VVFWc3dBV3hHSDdi?=
 =?utf-8?B?RkM2YXRaSjE3QWN1UGFDT1FUenBXTFZ5M2svbDVuUldXQ29IekUrSFRCQW12?=
 =?utf-8?B?TUhoMlBLbWV5OGVod3dGL1hYRS9DcmZDSmU1ZzJEV1pXZXpXYTU0UVN1bEtY?=
 =?utf-8?B?U1hORjVmOVlpalNGc0RnaHpzRFh3RkpBbTFqaDBCZDkxZW5sRDdmUzBWd2hD?=
 =?utf-8?B?RENzdUNENEMwY0pMVWNEdE1OUWF0WVhyVXVyWTFLL05KM2tGV1d5NkJydjVO?=
 =?utf-8?B?TFRDMXNoaWFmVzJxVzR0ckRZYUM2d1FabXZoVVcrS2ZHNlpXWlloWklaeHMx?=
 =?utf-8?B?YUpMUitjTFgrU25jZG5JaDdzSzdEaFd1VGZTYlRqaW9HR0VEc2Z3anpVQlli?=
 =?utf-8?B?dWZpRklLYUUrbmJOUVE1NWM4R0VhL21YWC9yNFFKNUpsUGd4S3hDbExTZmdZ?=
 =?utf-8?B?QmRDMFZtSit2anF4WUtNWkFTOVhlTWlNT3B6TlQ4dXM0WHRkaWRuWFkrNE5C?=
 =?utf-8?B?bjNFTkFoTEZ1dlhLMjhwQW04QnZjaU1VR2Y0WXNoL293NmxyUmRmYy82L0ps?=
 =?utf-8?Q?di8RVIHxSN0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2RQUTV2TmRUOVV2czBHckZIT2VUU3h0R2hjV0dMUUFabytIS09UK0VMQTNN?=
 =?utf-8?B?RUs0RFdSdG9xNmh0N2hhU0FMSldMMG5mNGlObWo4UXh6UDd4T2Y5WFNxdklN?=
 =?utf-8?B?N0lKdTVQUWw2RVBzSjkxYUVNejYyNFlmaURoYit1d2NCUmxWUForczJpRWkw?=
 =?utf-8?B?anBwRWxUZWtTSnpGVHN4LzJFMVgrSFR6ZEx5bVM0WHNRU1dIOVhWSEs5V1Bv?=
 =?utf-8?B?Znc4c3RDRnFFbHV6dkkzU0FxWlVaTGRPUjJiRmlCYXp2cXRpYjhvSDhsS3kx?=
 =?utf-8?B?SHcvbVMyVHNQdTUyaDhxM3czSC9rYWxGRk1qU2d6YU1NazJRdFk3RHF5QjRm?=
 =?utf-8?B?RERTZmJHWi9NcTVydlp3T1pST0lQWW81UmFEb090K1M1SWZ5MjhvNnVVc0pG?=
 =?utf-8?B?bVE1T3ovT1pFWGg0eDRWOXozZUZZZC9MZEk5UTNLSnRTdy9SYVM3TFVsa2o3?=
 =?utf-8?B?WFVGUk5iRHhtWCtpeXRvWXRGRGpyZ0lneVdCZzJid1I3c1p5N2JpSXJrWG1j?=
 =?utf-8?B?aHpNVGExODN6eDlHb1JCTHAvOGs2QnRRbXUwaGh3cVE5YlBnYWlTb3VMMUoz?=
 =?utf-8?B?RlJyaTVjNmNzYW5BTS84Zm90ZG9QYm1vNng3OWplTUIzTkFaOEMvK085WkY3?=
 =?utf-8?B?VU1ybmJuaFZRckFTczg1TkN4YWp2RndEOFpJaklwOGY4a1RGcDVzU25YTTFE?=
 =?utf-8?B?NFFnZndkeStwYUREZk1Ub3diWlhmOWtZcHIvS0FkQW0yZ0hoWTJrdGQzRVlQ?=
 =?utf-8?B?TnBldmh3ejkwRThsNUdTeksvQnZxdFFPSXBzYkU2QmRJT1ZDOCtZNEwyK3Aw?=
 =?utf-8?B?YWFLejMycHpkcTgzRGdKamJRTHBuTlhyeGpsM3gwOTBBQU4rdk9pdENLdFF1?=
 =?utf-8?B?aWpBbzlJL3N4UlR2L09GcWQ1K215Z25scTV6TFZMTENvYTIxVVoyaHM0UmtU?=
 =?utf-8?B?M2JOZW1aUUFiSk05ZnVKSUQxRFRkZm11ZXEyTGJVcE95MlhGRkZGU0craHlu?=
 =?utf-8?B?MEwyWW95eGd4OEFid0NJT1d6amZ0eTc5V3ZtekZzODFyUFVlQ0JOdEVIQUVR?=
 =?utf-8?B?aXc5cFd4enNXRGRCbXBSOHMvSi9iNjNvV2FZVHFLVkFmNExLamR1ejlDTzVq?=
 =?utf-8?B?c2xLeEpKZHUrU1JmMG1kN2ZCN1RBU1pFbi9sdGY0MFhVaGxPMHlDUjZ4QnlM?=
 =?utf-8?B?SnpwLzNoQzgyQkNWa0pNN29GWVd2YXZZWUF4Uzh4SUJkOXdsd2E0UXVVNVIx?=
 =?utf-8?B?LzdhckpXT3hJclVHQ0RoTlozVjl4RGNybUtsT0lGS0FxWGVDZTU2b3hkdkNB?=
 =?utf-8?B?YXhOWG1VdlBlaERrOXhJWnlvTU1SVHdNcGRqZi91OE1HS0tjUU0yQzMxdldZ?=
 =?utf-8?B?dWcrdGVPdVBGUU1PN2JsSHJaMTlwaG93Zko4Y2VKN2NueFBrSjhKUjBZTFFI?=
 =?utf-8?B?NXNFSFJWOHpCa1g4ZnY1RTNtZjRBWWdaNEZrTVZNUVM5RkNxOHI4MGdzUjE0?=
 =?utf-8?B?YVpmRlBJendXeGxYMm5OTG1rN3JxNFhaT2pCa21pbm1KS0k1L1A5YlJMcllC?=
 =?utf-8?B?cm5nV2FPMnhvdytsNzlLaFFOZHBWTk5uNWV5eTE4bE9sTy9MRXNpNHVSOUFq?=
 =?utf-8?B?bFoySmFsV2dwLzNMODE1ZUFuamZ2NFJrZ3pDbytxN2oxOFdFN0hmcjlNYWtL?=
 =?utf-8?B?RUoyclFsV0cvcWlsbkYyWVJVM2Q0bUZyWGgyZTRDeGxaeWYrSHJTTVVuZGZp?=
 =?utf-8?B?T0YvekdxckcxSVNZR3RQUWtwVDh3VWRpMUo1UVdZdEs1THB2dGZ3ZHRNcUVO?=
 =?utf-8?B?cEp3d1Z1c3lrRjlZV0JoTUdpZi81OEFLUDRkS2JETlVTamo4UTV1ZUdOL3dq?=
 =?utf-8?B?YlhZV2dkY1ptdGptZ3UzS3F6MDh4QVo4ZXRPU2oySXdPa3FOVVJNQ1J0YkJK?=
 =?utf-8?B?aVhnK1dFc004TlJXQzJuUzR2M084TDV5ekcxaGtpYjFEbE5tVzJHTjBJVlg4?=
 =?utf-8?B?T25JOUxPUmtSOFBwNzRidlZVQXdTVXNKalM4QlVxNEhqMWEvRmEwUWxFWjU4?=
 =?utf-8?B?UHd4c0Q5clptTzhtcGdwYWF3QjhJZDBkd2RZd0VaaDJEUjU2SnZFSDJ1Zm5J?=
 =?utf-8?B?MzBBQjhyM3JDWnJ5eEVwN21vSldrZW5IK3F5S2VjWHd4ZFRNc1cyaE50RHpj?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 002b96fe-0336-4b95-a6c1-08dd76a07840
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 13:22:54.3537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qry9qx4y8ZY75/xH7ju3WmnMhQqCNZE3vIx92yrojlWqrfIVkYSOlrPm+iRXm4nSDlESsv06SLm/rUQg4L43lWouZzwKU9mODxy5z+0tqQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7794
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Tue, 11 Mar 2025 15:05:38 +0100

> On Wed, Mar 05, 2025 at 05:21:19PM +0100, Alexander Lobakin wrote:
>> "Couple" is a bit humbly... Add the following functionality to libeth:

[...]

>> +struct libeth_rq_napi_stats {
>> +	union {
>> +		struct {
>> +							u32 packets;
>> +							u32 bytes;
>> +							u32 fragments;
>> +							u32 hsplit;
>> +		};
>> +		DECLARE_FLEX_ARRAY(u32, raw);
> 
> The @raw approach is never used throughout the patchset, right?

Right, but

> Could you explain the reason for introducing this and potential use case?

initially, when my tree contained libeth generic stats also, I used this
field to update queue stats in a loop (unrolled by 4 fields) instead of
field-by-field.
Generic stats are still planned, and since ::raw is already present in
&libeth_sq_napi_stats, I'd like to keep it :z

> 
>> +	};
>> +};
>>  
>>  /**
>>   * struct libeth_sq_napi_stats - "hot" counters to update in Tx completion loop
>> @@ -22,4 +44,84 @@ struct libeth_sq_napi_stats {
>>  	};
>>  };
>>  
>> +/**
>> + * struct libeth_xdpsq_napi_stats - "hot" counters to update in XDP Tx
>> + *				    completion loop
>> + * @packets: completed frames counter
>> + * @bytes: sum of bytes of completed frames above
>> + * @fragments: sum of fragments of completed S/G frames
>> + * @raw: alias to access all the fields as an array
>> + */
>> +struct libeth_xdpsq_napi_stats {
> 
> what's the delta between this and libeth_sq_napi_stats ? couldn't you have
> a single struct for purpose of tx napi stats?

Same as previous, future-proof. &libeth_sq{,_napi}_stats will contain
stuff XDP queues will never need and vice versa.

> 
>> +	union {
>> +		struct {
>> +							u32 packets;
>> +							u32 bytes;
>> +							u32 fragments;
>> +		};
>> +		DECLARE_FLEX_ARRAY(u32, raw);
>> +	};
>> +};

[...]

>> @@ -71,7 +84,10 @@ struct libeth_sqe {
>>  /**
>>   * struct libeth_cq_pp - completion queue poll params
>>   * @dev: &device to perform DMA unmapping
>> + * @bq: XDP frame bulk to combine return operations
>>   * @ss: onstack NAPI stats to fill
>> + * @xss: onstack XDPSQ NAPI stats to fill
>> + * @xdp_tx: number of XDP frames processed
>>   * @napi: whether it's called from the NAPI context
>>   *
>>   * libeth uses this structure to access objects needed for performing full
>> @@ -80,7 +96,13 @@ struct libeth_sqe {
>>   */
>>  struct libeth_cq_pp {
>>  	struct device			*dev;
>> -	struct libeth_sq_napi_stats	*ss;
>> +	struct xdp_frame_bulk		*bq;
>> +
>> +	union {
>> +		struct libeth_sq_napi_stats	*ss;
>> +		struct libeth_xdpsq_napi_stats	*xss;
>> +	};
>> +	u32				xdp_tx;
> 
> you have this counted in xss::packets?

Nope, it's the same as in ice, you have separate ::packets AND ::xdp_tx
on the ring to speed up XSk completion when there's no XDP-non-XSk buffers.

> 
>>  
>>  	bool				napi;
>>  };

[...]

>> +/* Common Tx bits */
>> +
>> +/**
>> + * enum - libeth_xdp internal Tx flags
>> + * @LIBETH_XDP_TX_BULK: one bulk size at which it will be flushed to the queue
>> + * @LIBETH_XDP_TX_BATCH: batch size for which the queue fill loop is unrolled
>> + * @LIBETH_XDP_TX_DROP: indicates the send function must drop frames not sent
>> + * @LIBETH_XDP_TX_NDO: whether the send function is called from .ndo_xdp_xmit()
>> + */
>> +enum {
>> +	LIBETH_XDP_TX_BULK		= DEV_MAP_BULK_SIZE,
>> +	LIBETH_XDP_TX_BATCH		= 8,
>> +
>> +	LIBETH_XDP_TX_DROP		= BIT(0),
>> +	LIBETH_XDP_TX_NDO		= BIT(1),
> 
> what's the reason to group these random values onto enum?

They then will be visible in BTFs (not sure anyone will need them there).

> 
>> +};
>> +
>> +/**
>> + * enum - &libeth_xdp_tx_frame and &libeth_xdp_tx_desc flags
>> + * @LIBETH_XDP_TX_LEN: only for ``XDP_TX``, [15:0] of ::len_fl is actual length
>> + * @LIBETH_XDP_TX_FIRST: indicates the frag is the first one of the frame
>> + * @LIBETH_XDP_TX_LAST: whether the frag is the last one of the frame
>> + * @LIBETH_XDP_TX_MULTI: whether the frame contains several frags
> 
> would be good to have some extended description around usage of these
> flags.

They are internal to libeth functions anyway, hence no detailed description.

> 
>> + * @LIBETH_XDP_TX_FLAGS: only for ``XDP_TX``, [31:16] of ::len_fl is flags
>> + */
>> +enum {
>> +	LIBETH_XDP_TX_LEN		= GENMASK(15, 0),
>> +
>> +	LIBETH_XDP_TX_FIRST		= BIT(16),
>> +	LIBETH_XDP_TX_LAST		= BIT(17),
>> +	LIBETH_XDP_TX_MULTI		= BIT(18),
>> +
>> +	LIBETH_XDP_TX_FLAGS		= GENMASK(31, 16),
>> +};

[...]

>> +/**
>> + * libeth_xdp_tx_queue_head - internal helper for queueing one ``XDP_TX`` head
>> + * @bq: XDP Tx bulk to queue the head frag to
>> + * @xdp: XDP buffer with the head to queue
>> + *
>> + * Return: false if it's the only frag of the frame, true if it's an S/G frame.
>> + */
>> +static inline bool libeth_xdp_tx_queue_head(struct libeth_xdp_tx_bulk *bq,
>> +					    const struct libeth_xdp_buff *xdp)
>> +{
>> +	const struct xdp_buff *base = &xdp->base;
>> +
>> +	bq->bulk[bq->count++] = (typeof(*bq->bulk)){
>> +		.data	= xdp->data,
>> +		.len_fl	= (base->data_end - xdp->data) | LIBETH_XDP_TX_FIRST,
>> +		.soff	= xdp_data_hard_end(base) - xdp->data,
>> +	};
>> +
>> +	if (!xdp_buff_has_frags(base))
> 
> likely() ?

With the header split enabled and getting more and more popular -- not
really. likely() hurts perf here actually.

> 
>> +		return false;
>> +
>> +	bq->bulk[bq->count - 1].len_fl |= LIBETH_XDP_TX_MULTI;
>> +
>> +	return true;
>> +}
>> +
>> +/**
>> + * libeth_xdp_tx_queue_frag - internal helper for queueing one ``XDP_TX`` frag
>> + * @bq: XDP Tx bulk to queue the frag to
>> + * @frag: frag to queue
>> + */
>> +static inline void libeth_xdp_tx_queue_frag(struct libeth_xdp_tx_bulk *bq,
>> +					    const skb_frag_t *frag)
>> +{
>> +	bq->bulk[bq->count++].frag = *frag;
> 
> IMHO this helper is not providing anything useful

That's why it's stated "internal helper" :D

> 
>> +}

[...]

>> +#define libeth_xdp_tx_fill_stats(sqe, desc, sinfo)			      \
>> +	__libeth_xdp_tx_fill_stats(sqe, desc, sinfo, __UNIQUE_ID(sqe_),	      \
>> +				   __UNIQUE_ID(desc_), __UNIQUE_ID(sinfo_))
>> +
>> +#define __libeth_xdp_tx_fill_stats(sqe, desc, sinfo, ue, ud, us) do {	      \
>> +	const struct libeth_xdp_tx_desc *ud = (desc);			      \
>> +	const struct skb_shared_info *us;				      \
>> +	struct libeth_sqe *ue = (sqe);					      \
>> +									      \
>> +	ue->nr_frags = 1;						      \
>> +	ue->bytes = ud->len;						      \
>> +									      \
>> +	if (ud->flags & LIBETH_XDP_TX_MULTI) {				      \
>> +		us = (sinfo);						      \
> 
> why? what 'u' stands for? ue us don't tell the reader much from the first
> glance. sinfo tells me everything.

ue -- "unique element"
ud -- "unique descriptor"
us -- "unique sinfo"

All of them are purely internal to pass __UNIQUE_ID() in the
non-underscored version to avoid variable shadowing.

> 
>> +		ue->nr_frags += us->nr_frags;				      \
>> +		ue->bytes += us->xdp_frags_size;			      \
>> +	}								      \
>> +} while (0)

[...]

>> +/**
>> + * libeth_xdp_xmit_do_bulk - implement full .ndo_xdp_xmit() in driver
>> + * @dev: target &net_device
>> + * @n: number of frames to send
>> + * @fr: XDP frames to send
>> + * @f: flags passed by the stack
>> + * @xqs: array of XDPSQs driver structs
>> + * @nqs: number of active XDPSQs, the above array length
>> + * @fl: driver callback to flush an XDP xmit bulk
>> + * @fin: driver cabback to finalize the queue
>> + *
>> + * If the driver has active XDPSQs, perform common checks and send the frames.
>> + * Finalize the queue, if requested.
>> + *
>> + * Return: number of frames sent or -errno on error.
>> + */
>> +#define libeth_xdp_xmit_do_bulk(dev, n, fr, f, xqs, nqs, fl, fin)	      \
>> +	_libeth_xdp_xmit_do_bulk(dev, n, fr, f, xqs, nqs, fl, fin,	      \
>> +				 __UNIQUE_ID(bq_), __UNIQUE_ID(ret_),	      \
>> +				 __UNIQUE_ID(nqs_))
> 
> why __UNIQUE_ID() is needed?

As above, variable shadowing.

> 
>> +
>> +#define _libeth_xdp_xmit_do_bulk(d, n, fr, f, xqs, nqs, fl, fin, ub, ur, un)  \
> 
> why single underscore? usually we do __ for internal funcs as you did
> somewhere above.

Double-underscored is defined above already :D
So it would be either like this or __ + ___

> 
> also, why define and not inlined func?

I'll double check, but if you look at its usage in idpf/xdp.c, you'll
see that some arguments are non-trivial to obtain, IOW they cost some
cycles. Macro ensures they won't be fetched prior to
`likely(number_of_xdpsqs)`.
I'll convert to an inline and check if the compiler handles this itself.
It didn't behave in {,__}libeth_xdp_tx_fill_stats() unfortunately, hence
macro there as well =\

> 
>> +({									      \
>> +	u32 un = (nqs);							      \
>> +	int ur;								      \
>> +									      \
>> +	if (likely(un)) {						      \
>> +		struct libeth_xdp_tx_bulk ub;				      \
>> +									      \
>> +		libeth_xdp_xmit_init_bulk(&ub, d, xqs, un);		      \
>> +		ur = __libeth_xdp_xmit_do_bulk(&ub, fr, n, f, fl, fin);	      \
>> +	} else {							      \
>> +		ur = -ENXIO;						      \
>> +	}								      \
>> +									      \
>> +	ur;								      \
>> +})

[...]

>> +static inline void
>> +libeth_xdp_init_buff(struct libeth_xdp_buff *dst,
>> +		     const struct libeth_xdp_buff_stash *src,
>> +		     struct xdp_rxq_info *rxq)
> 
> what is the rationale for storing/loading xdp_buff onto/from driver's Rx
> queue? could we work directly on xdp_buff from Rx queue? ice is doing so
> currently.

Stack vs heap. I was getting lower numbers working on the queue directly.
Also note that &libeth_xdp_buff_stash is 16 bytes, while
&libeth_xdp_buff is 64. I don't think it makes sense to waste +48
bytes in the structure.

Load-store of the stash is rare anyway. It can happen *only* if the HW
for some reason hasn't written the whole multi-buffer frame yet, since
NAPI budget is counted by packets, not fragments.

> 
>> +{
>> +	if (likely(!src->data))
>> +		dst->data = NULL;
>> +	else
>> +		libeth_xdp_load_stash(dst, src);
>> +
>> +	dst->base.rxq = rxq;
>> +}

[...]

>> +static inline bool libeth_xdp_process_buff(struct libeth_xdp_buff *xdp,
>> +					   const struct libeth_fqe *fqe,
>> +					   u32 len)
>> +{
>> +	if (!libeth_rx_sync_for_cpu(fqe, len))
>> +		return false;
>> +
>> +	if (xdp->data)
> 
> unlikely() ?

Same as for libeth_xdp_tx_queue_head(): with the header split, you'll
hit this branch every frame.

> 
>> +		return libeth_xdp_buff_add_frag(xdp, fqe, len);
>> +
>> +	libeth_xdp_prepare_buff(xdp, fqe, len);
>> +
>> +	prefetch(xdp->data);
>> +
>> +	return true;
>> +}

[...]

>> +/**
>> + * libeth_xdp_run_prog - run XDP program and handle all verdicts
>> + * @xdp: XDP buffer to process
>> + * @bq: XDP Tx bulk to queue ``XDP_TX`` buffers
>> + * @fl: driver ``XDP_TX`` bulk flush callback
>> + *
>> + * Run the attached XDP program and handle all possible verdicts.
>> + * Prefer using it via LIBETH_XDP_DEFINE_RUN{,_PASS,_PROG}().
>> + *
>> + * Return: true if the buffer should be passed up the stack, false if the poll
>> + * should go to the next buffer.
>> + */
>> +#define libeth_xdp_run_prog(xdp, bq, fl)				      \
> 
> is this used in idpf in this patchset?

Sure. __LIBETH_XDP_DEFINE_RUN() builds two functions, one of which uses it.
Same for __LIBETH_XDP_DEFINE_RUN_PROG(). I know they are poor to read,
but otherwise I'd need to duplicate them for XDP and XSk separately.

> 
>> +	(__libeth_xdp_run_flush(xdp, bq, __libeth_xdp_run_prog,		      \
>> +				libeth_xdp_tx_queue_bulk,		      \
>> +				fl) == LIBETH_XDP_PASS)
>> +
>> +/**
>> + * __libeth_xdp_run_pass - helper to run XDP program and handle the result
>> + * @xdp: XDP buffer to process
>> + * @bq: XDP Tx bulk to queue ``XDP_TX`` frames
>> + * @napi: NAPI to build an skb and pass it up the stack
>> + * @rs: onstack libeth RQ stats
>> + * @md: metadata that should be filled to the XDP buffer
>> + * @prep: callback for filling the metadata
>> + * @run: driver wrapper to run XDP program
> 
> I see it's NULLed on idpf? why have this?

Only for singleq which we don't support. splitq uses
LIBETH_XDP_DEFINE_RUN() to build idpf_xdp_run_prog() and
idpf_xdp_run_pass().

> 
>> + * @populate: driver callback to populate an skb with the HW descriptor data
>> + *
>> + * Inline abstraction that does the following:
>> + * 1) adds frame size and frag number (if needed) to the onstack stats;
>> + * 2) fills the descriptor metadata to the onstack &libeth_xdp_buff
>> + * 3) runs XDP program if present;
>> + * 4) handles all possible verdicts;
>> + * 5) on ``XDP_PASS`, builds an skb from the buffer;
>> + * 6) populates it with the descriptor metadata;
>> + * 7) passes it up the stack.

[...]

>> +void __cold libeth_xdp_tx_exception(struct libeth_xdp_tx_bulk *bq, u32 sent,
>> +				    u32 flags)
>> +{
>> +	const struct libeth_xdp_tx_frame *pos = &bq->bulk[sent];
>> +	u32 left = bq->count - sent;
>> +
>> +	if (!(flags & LIBETH_XDP_TX_NDO))
>> +		libeth_trace_xdp_exception(bq->dev, bq->prog, XDP_TX);
>> +
>> +	if (!(flags & LIBETH_XDP_TX_DROP)) {
>> +		memmove(bq->bulk, pos, left * sizeof(*bq->bulk));
> 
> can this overflow? if queue got stuck for some reason.

memmove() is safe to call even when src == dst. As for XDP Tx logic, if
the queue is stuck, the bulk will never overflow, libeth will just try
send it again and again. At the end, both XDP Tx and xmit calls it with
DROP to make sure no memleaks or other issues can take place.

> 
>> +		bq->count = left;
>> +
>> +		return;
>> +	}
>> +
>> +	if (!(flags & LIBETH_XDP_TX_NDO))
>> +		libeth_xdp_tx_return_bulk(pos, left);
>> +	else
>> +		libeth_xdp_xmit_return_bulk(pos, left, bq->dev);
>> +
>> +	bq->count = 0;
>> +}
>> +EXPORT_SYMBOL_GPL(libeth_xdp_tx_exception);

Thanks,
Olek

