Return-Path: <bpf+bounces-22074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA57856253
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 12:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B7D1F279DF
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 11:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376D412BEB6;
	Thu, 15 Feb 2024 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XCXTNSs4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C519D12AAD6;
	Thu, 15 Feb 2024 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998239; cv=fail; b=ERCeb/9GKao2dZxV3qVUyblLiija+2JqHqF82y+7LLb2KtrO9U++G6f7M7HMPlGdKSq9toEix+CaktXVw8o+FMurT+2iM21vrFgmUwpJm8DEFdzV8+x7/djV1VjwnzYkuCzJuQ0mxuRwwLUD6jR51MP1bydoyEiW7fXYJdvDJTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998239; c=relaxed/simple;
	bh=ge96TLe6FDyQ5PU7oj7K6VGRQ5OqMjxOVIqLLdb8udM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QqWJe3rnBI+6kVu+uQAvYM/Z/4D58n3oFaOfADKHkOBG+LZfOgLRYk4wigUoYB+EeZ5kzcOCSl0RVqZ6PPI1T2KPc+QwekwZAheW9fruTncGdu25JWwqjxiMcyYbE2uNJEmfT335o/kmXNzVwOp6iqNbd+SsU0aQ7SJjk1T6TWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XCXTNSs4; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707998238; x=1739534238;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ge96TLe6FDyQ5PU7oj7K6VGRQ5OqMjxOVIqLLdb8udM=;
  b=XCXTNSs4Q0T78fGwx1/KUFtTXed6eWJZ7Qux3RLF7VX+50Om0Ems39Pw
   jEU2votn1rt2O1NrJ6/Bftl1TXys5eWqVhWvsNBNHk7W6jVpN+JcTcesM
   snEGYC8K8YIuSAKaSCfVwrm6B+dkKzcmzuRIfTfxtGhfv72iHZTOUDdso
   UCFJLaj4etXADku8WdcApQRvb00V5dqxPbTcS64C6eerd9VoKviGVg0hH
   HeXCG8jf7v3ov8YrHDE+p32pExOswKdU+57Qx/Y5+3Q4HvJpuEQoHIRqF
   IhRFg1hDUsMjqK1Pc+vmsQXZpUKJtlMV8WZ3OJq8/PzFP2LodpZGL0Tn0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2219354"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="2219354"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 03:57:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="34557728"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2024 03:57:17 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 03:57:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 03:57:16 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 03:57:15 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 03:57:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHD60cjvwUH11eRCPs7R0hWa457T5JXYQO/JQGdqvfXKj/RFjlrihJeUDs5EBrKSNIQ2nPhNiTLEU8Xp58JK6KWku3Zht8CDEy5d35tfis2FFcvq5PR6hIVTl3yCNGVlyrpBcWrOTovN2mtvnTGFh5NfDEf0ciD1IonngbWELOaL7ePggCmDcQpXUTHWxAktvJ4evCq73AGcXZLdNeCggj0dORlmbr6rMyOODjDn5i/9AXPm6eLkyP5W/FwbxgcySCkDgFbRhbHqcwrAlxrPKnYbEnE5+eSi8OWbAWnXtB3eE/xSCqRuWmPS2Rl5BC2PuSv0q+quj35NjM7jdFe8CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=700A6aPGVsJhBrcaXHVGS+V3+Ke/4JUbBI1p+aQ0tzE=;
 b=NeJefwV6eBRoQlPAv8GDvfXCqWI1l/EmonaL0AVaPTZOaWin4NddkaDKkV2cULWFpwcLA42QbF/bps07UTpiFN+T/tlIRotN466E6Yyh6U7Bpk+2e6Ma0pF4ZwzpP9MlMNBX4ISO4zG7CRj2itAlYq8in3rcnVm//pm1bV7wy7eDGfLZSji1sSOAKAYgCXW1NioHL2Od7+exxRYU5ZaUmsZ5rSqhhGRvSSX/VHSR2eGilakzInQyY8TOo/3rw5FgpguXYxoYdIwMcmzir8y7UfeNQ3rxo0RD++2QNkXTda9EQVn1XaOR8iNIV2KEG3Ch1pkAXmH9B4WIGZ+tcWmDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB6446.namprd11.prod.outlook.com (2603:10b6:8:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 11:57:14 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6%6]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 11:57:14 +0000
Message-ID: <c7d4902b-593e-46d6-9ecf-bc24986c244c@intel.com>
Date: Thu, 15 Feb 2024 12:57:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf/test_run: increase Page Pool's ptr_ring size
 in live frames mode
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Jakub Kicinski <kuba@kernel.org>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240214153838.4159970-1-aleksander.lobakin@intel.com>
 <87cyszdnrz.fsf@toke.dk> <87y1bmd4zg.fsf@toke.dk>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <87y1bmd4zg.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::6) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 79929fbc-0200-4841-1c52-08dc2e1d3fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9EvoOYHBrql/JX52t82OTMrPmQno/uquTm1RopdrEl5lLasX0j47cMhRmHRwmC2TaxLFKqA3yankmhVu4s3uQcBZAqFe1ocenpeZV1cNacJahjn+WzkjriF9qT1AcNGPk7+P6v7gFUeu3TW2qcQKqGuOf/lretGNh7QHo09kM3ffYc1KngWwhgHIpxHUonmyzDVQ1DXa35wL4BQiOSBoRSoVxYcbBSH9R6lJPEvbUH/vbBDzZuFa4inIPM9GKgGi6R2xwqpHXKbNXIg6LRjlDVZIdpEe1HjcTZFX5T1DRYMAaG6kilEn6r70yYBKsExpHhsoZJRzls0mChx2SRzGSQRcpl97YuD8JHuXrIO3kzCgl1/gj434UVPRSjp2OpYypg4ECW53cRoS5wMKDV/r8yC9vtCjhMyWOUgFi8qvtUmXgW1M06lmJ0X4LqO1O3zZr7X7sUXph6z4VLetH1yEEOKl7P7sOqwSk8smIn0TIV/S4csZPo7NsA9PjO/AtAPRDyvrx1Ezu+OoZ7oqA+xwwpfBNsTZj7xIbwcu4oveIeo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(8676002)(31686004)(41300700001)(26005)(82960400001)(6506007)(38100700002)(6666004)(36756003)(2906002)(66946007)(4326008)(316002)(5660300002)(8936002)(66556008)(6916009)(66476007)(54906003)(66574015)(478600001)(2616005)(83380400001)(6486002)(6512007)(966005)(86362001)(31696002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1QrZnJXMmo3Z2lBc0huQ0N2SVNjeFYrdU9Hdi9CR3doWmt6dmowblM0Q3FN?=
 =?utf-8?B?NHg4Z3RYei9tWXRKbkJoQUpYRDA5S1NkSVFKK3lHNnJPS3dZbkp1WHJLd3kw?=
 =?utf-8?B?c0FGR2Z1STY1aVo0bUhUd3pRb2NEVTVnUkRHdHNPa2JpeWptNk0wOGRMUHRn?=
 =?utf-8?B?UmFRS3ErSHR6dWk3NmVHK0R4Vzl0Z25rZ2dCYnZyWVBLT25sQ25ZTFY2Zy8w?=
 =?utf-8?B?bE53MnFZdU03RGJvNjlPaXhrRy9FWHVjdFp6anpTMGIrcTlaZ2l2S2pMWVNH?=
 =?utf-8?B?Q3lvSU1CemdDMUtMeWpKQkdtV3BWc25IaWt1dXlQVXZ3T2tHYXRDUzA1eCs2?=
 =?utf-8?B?NEdvRUNzTkhzeW4yZFJCdWhmdEMyNXhPTUdDeFV0VWNVNnFiRVd0MHVIK0l1?=
 =?utf-8?B?UDgwTWowMUh4eTkzall6UW1kNkpnUEdHYjJITG1YQk5kK1BHYTlScVd6SWNs?=
 =?utf-8?B?clFlaXAyZElGUmhWbHBPRkFEcnVCNnNCaFlJN2IrSCs5cStWcFdjd3YxS25V?=
 =?utf-8?B?MW5PTmRKdjA3dm9HdG8yTk5XcEZiZVVJL3VVZTY3U09vWDFFT2U4amZQYmJ3?=
 =?utf-8?B?eGN2TE0yQ2d0empma3loY1gyUlR6a2w4ZlFBc0UrdEREYmh0TEswWWNBczNr?=
 =?utf-8?B?TEU0VDFvMlhRRHBlb09sLzRyeXpNMnhmVVljdkFqVjlFeFpYU295d2xZYnoy?=
 =?utf-8?B?Sm9RdStXcHJpZXZYajlrK2Q5SVB1OVVnYW5sbmJkeGRZSVJBaHdCaDNpOEsy?=
 =?utf-8?B?bmVnMENvY2ZtcmZYem5XcWluNi8xUGpSNTJyc2tQbSs0TFNYekNrQjNvZmkz?=
 =?utf-8?B?aTNSMm5vR1BwWEMzaExrZCszZG95TGx3RTlLYys2RDgwUFRBcjlpUHNKT3RZ?=
 =?utf-8?B?TFdWbFdIV1FFWGd3S0hYOHBUYkZBTlJybTdKdis0VDNDTmg2NXNHWiswaTA1?=
 =?utf-8?B?aDJ3c3BOMUNoSkdzenk2SXR6RS9mL21CUEVqUWtvUGk2a2pvTlNscHVvM3R4?=
 =?utf-8?B?WGFNQmpOSml6U3Rmd3VKR0Y0bDduWXQ0WVh4NUFKRzhWbzhHaUV4ak5UNUNP?=
 =?utf-8?B?QzhpelNNRDdCaEdaQWpRYmRzR2dRMWtHQmZQQzJEdnhjeW1PTWlHMXU0MzlH?=
 =?utf-8?B?OGtDWjFLWTlZMUxFZ0ZoaVo4M0Jpc1NweklqVlp1WjErRWt2SFRYejU2UTV6?=
 =?utf-8?B?V2tFT3JZbEYrQzJ2bzhic1doZDZvMmc0NmdLMXJWS0NNNExNMVMzOGw2Q3pi?=
 =?utf-8?B?d0F6Z1k3NnJQSktTV0M1Z1d6QUxQYUJFUTVjQXU4QUJwbUhCcW1lV3YveWJE?=
 =?utf-8?B?QlhldmhpY0NkUFZDdDI4Q2lzV2V4cTZVblpsMzEyU1NGNmg2NmdPTFNjZDdK?=
 =?utf-8?B?TGk3SXBOeXphUDMwVGsxVVB2elhRalNBMXFlYWYrV3lEei9DM3REN1Rhamhx?=
 =?utf-8?B?RGtjU29GcURkcWhSYmtQREY4a3E2SnhBa1pkU3N3TWhSWUFTbTUwdGdMdkxk?=
 =?utf-8?B?a1ZYdXRZaml1LzQ2eGhKNEphQTgvQm9JeDhmQTZSMWZIQ2RzLzNnR2ROMHc3?=
 =?utf-8?B?Nk9OOUR5TDZPdlJJNHVJT2ZjRW9YZ3RuQUNSS0VxdEljekRNaVZlS0xRTUVU?=
 =?utf-8?B?a2ZqZVZncERheWJlc0Z5SFE3dks4VU44WFo3dkNMMTNvQVlFNGxLRXlVblNJ?=
 =?utf-8?B?SGhWZHJIMURjdjEwVWtWS0UrMkYva1RiYzhlVWM0QmRCcDFkZHRGRndEdmM3?=
 =?utf-8?B?UnQxM3VpL2hibUMrb1RocW9rREQyOURiZDk0TTI0UTFERElPd3ErMHNaM2Rr?=
 =?utf-8?B?YWwvcFZyYVpnSiswanZLOXNUMVdTUkZaSkJLSEFBTTNPVFYyWGducWR0bjFE?=
 =?utf-8?B?OWE3LzgrNElycktSaDVVcW1WandTai9KOS9pZVFWeHE4TGJQSG5GYUM2VTlm?=
 =?utf-8?B?MmtRZE5JVTBIZmF4VFJGVXhaSm5ORHZWMTJ2MlhTMUZUTVVoRU1hektnN05z?=
 =?utf-8?B?U0U3V0ZSTGVnOU5tMXFZSHFaV0YwSmo3YkpUeDYvdVNRWGdhWHV4d2Z2Sy9S?=
 =?utf-8?B?dTZ5b2MrSUt1OHMxK2F1eVhXcU84VWUzcVJIc2sxejJub3ZFRGk5YzAvL29y?=
 =?utf-8?B?T2drS0dlN3NQREltU0pEM0pKaElaV2RFdjlyMWIzT1hzMitkTXZFWTNDcFdQ?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79929fbc-0200-4841-1c52-08dc2e1d3fbc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 11:57:14.0341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8N4gH5YExIBruza+p6NgeKabJWv0iswPDwgqmAdmm8zbtRSR5jFDl6QeKsiP3zHAlelp5PnTPFGXAPxeYGHDyHnXv832ndDMIpGBnBcdOtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6446
X-OriginatorOrg: intel.com

From: Toke Høiland-Jørgensen <toke@redhat.com>
Date: Thu, 15 Feb 2024 00:02:27 +0100

> Toke Høiland-Jørgensen <toke@redhat.com> writes:
> 
>> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
>>
>>> Currently, when running xdp-trafficgen, test_run creates page_pools with
>>> the ptr_ring size of %NAPI_POLL_WEIGHT (64).
>>> This might work fine if XDP Tx queues are polled with the budget
>>> limitation. However, we often clear them with no limitation to ensure
>>> maximum free space when sending.
>>> For example, in ice and idpf (upcoming), we use "lazy" cleaning, i.e. we
>>> clean XDP Tx queue only when the free space there is less than 1/4 of
>>> the queue size. Let's take the ring size of 512 just as an example. 3/4
>>> of the ring is 384 and often times, when we're entering the cleaning
>>> function, we have this whole amount ready (or 256 or 192, doesn't
>>> matter).
>>> Then we're calling xdp_return_frame_bulk() and after 64th frame,
>>> page_pool_put_page_bulk() starts returning pages to the page allocator
>>> due to that the ptr_ring is already full. put_page(), alloc_page() et at
>>> starts consuming a ton of CPU time and leading the board of the perf top
>>> output.
>>>
>>> Let's not limit ptr_ring to 64 for no real reason and allow more pages
>>> to be recycled. Just don't put anything to page_pool_params::size and
>>> let the Page Pool core pick the default of 1024 entries (I don't believe
>>> there are real use cases to clean more than that amount of descriptors).
>>> After the change, the MM layer disappears from the perf top output and
>>> all pages get recycled to the PP. On my test setup on idpf with the
>>> default ring size (512), this gives +80% of Tx performance with no
>>> visible memory consumption increase.
>>>
>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>
>> Hmm, so my original idea with keeping this low was to avoid having a lot
>> of large rings lying around if it is used by multiple processes at once.
>> But we need to move away from the per-syscall allocation anyway, and
>> with Lorenzo's patches introducing a global system page pool we have an
>> avenue for that. So in the meantime, I have no objection to this...
>>
>> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> Actually, since Lorenzo's patches already landed in net-next, let's just
> move to using those straight away. I'll send a patch for this tomorrow :)

Keep in mind that system page_pools do direct recycling based on cpuid
and for now, memory leaks are possible. Pls see my patch[0] for the
details :D

> 
> -Toke
> 

[0]
https://lore.kernel.org/netdev/20240215113905.96817-1-aleksander.lobakin@intel.com

Olek

