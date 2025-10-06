Return-Path: <bpf+bounces-70446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB70BBF5E7
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 22:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB256189BF7E
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 20:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0A22566F7;
	Mon,  6 Oct 2025 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9Ez7uuG"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB674A08;
	Mon,  6 Oct 2025 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759783688; cv=fail; b=lY6H5LlMt2pjlEHRheNM3t94w9e5PPx/nZKVkFCkI7iH40qi1oRdDtIvAOXcrJSWFURcgL0Fjmme+AivCI8G6S75sQmrF4X7k7eDXLw01jTS/kACAPC6Yh/ICDudyr4fvvAmmLYQLoWm9/ffiXbcptRHlodjYRr33bFBApXCVjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759783688; c=relaxed/simple;
	bh=nPp1qZnuF3fSHTFPiD+CNsjcpk2gBlt9IKlOsPimiu0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZRwTFJVj4skkZvo/sk8HPhnueibdkYfuXOmB0LbqCtlhC/e90uHoqngReL2Aog9sJuE+OL85ZUshbVCuyAfL0cYlFAn/WOU8OM9PHrOjpBdWujcvDyifjKsG0YDg5qiccK+Tf3R/NKpr9QsixOe7MN6fLIagyS4qesxVO9VBiaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9Ez7uuG; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759783687; x=1791319687;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nPp1qZnuF3fSHTFPiD+CNsjcpk2gBlt9IKlOsPimiu0=;
  b=j9Ez7uuGEL5WYL+sFVnAuiinrI90FHvi5R1yMWPAK+/1fXJlMGQNVySH
   lo2wWEpD2y1owe7gxI4Rm4vvvYGl8DHD5X5o6tYirsWmYQ99gowY5HT7o
   tVRdPsnWlvdwSzXmH6zea3BDNX6HyMzPfp79wwaq0X+wyz8HnNbNaStpX
   U4tLjit0pBuDpFDPhmTwDXxspZrDAXLpUYWDu4AE0tK4NC6D2PjDubCxf
   Bk6RFhFvQvzkEi9DgOc7n/t9mDA3vDFv/bTbdVVP6QxbcnFFxmX/gSGrA
   SgbPV8xHe7BhcwRPH+gVJlWZttxQtTUW+9C2+Jms3hkexObyBTJ20DUzI
   g==;
X-CSE-ConnectionGUID: cm0EIMUiQ6maFTlxA7lThA==
X-CSE-MsgGUID: 7UuhePTBTmuotvSw62eNQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61917005"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61917005"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 13:48:06 -0700
X-CSE-ConnectionGUID: JhUhPBgTRMC9eNrJVH/Kag==
X-CSE-MsgGUID: KVXTqGYpTWOv67K//jxQBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="179782454"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 13:48:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 13:48:04 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 13:48:04 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.66)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 13:48:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Byg3DtqwZqtjLveiZproFnoaJoqTh/0k5NCOxOPvh4lDr+U0i5xJ76MwVO3QCsRlzHJy3pm9rUsQ9aRoW7L/NhsgrKdvSLeoBTAFCUG/W9CUeWp3ZcZogN2X3XKLNb4znRkswzOtNF1X9OmOZZ7KzYxeX4hCCtRuucDM5Bw2WQcJIwFIDUlfKcMgy9vJgZ+lpzxDhpjigZNQhIEFwzvtxfanL3FtWs+n0n/MUFy344HObrjUNIA/a2wy4LLHPPltaFLYKljqiXS05wte0yxj1u7QmhRQRHR/PiXgXBSOnHMA7xpnYoFfMzBV9HjlGsXNuf3J4vxaDwWFC2MYOOLhfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPp1qZnuF3fSHTFPiD+CNsjcpk2gBlt9IKlOsPimiu0=;
 b=zB3ffCXVDubd4RCE+Ij8VbAQbMNcnwk5p3ZWbUQXPNZG0aPQWepD+i7HJguPsfZYqNMgnvCC4m3mX7wweI6FJOAglQ8ggQayankgpKcFYCGC6idb4Se/9qKfPI0inmSqQWB2Ca082Ph2TN/DVZ0q5uq8aD5V+j505T/UkFvJxJ65RfsKjx9HKbWzxlnziacmp14jEV4O0mxVVsqAU9GrJvBZpec3T8k1TJy40oAc27vgk/TWTecjAc0ZbS6xzD1WVJJKFGgj9XgCNXBtaHjBpWH6ycW93vLvkr5xc0c2wyLPdSs3nLYjhTt8/EFjq3Zs3fjcW3YXnuADC80TazEBnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 20:47:58 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%3]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 20:47:57 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "namhyung@kernel.org" <namhyung@kernel.org>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "songliubraving@fb.com" <songliubraving@fb.com>,
	"acme@kernel.org" <acme@kernel.org>, "irogers@google.com"
	<irogers@google.com>
CC: "james.clark@linaro.org" <james.clark@linaro.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"wutengda@huaweicloud.com" <wutengda@huaweicloud.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"howardchu95@gmail.com" <howardchu95@gmail.com>,
	"atrajeev@linux.vnet.ibm.com" <atrajeev@linux.vnet.ibm.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"gmonaco@redhat.com" <gmonaco@redhat.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] perf bpf_counter: Fix handling of cpumap fixing
 hybrid
Thread-Topic: [PATCH v1 2/2] perf bpf_counter: Fix handling of cpumap fixing
 hybrid
Thread-Index: AQHcMv8Vwv+w1xSJXEe8UlFd/9fT7rS1U60AgABLUoA=
Date: Mon, 6 Oct 2025 20:47:57 +0000
Message-ID: <22b536d6e702ca070777f426e4cf8e7c0089035d.camel@intel.com>
References: <20251001181229.1010340-1-irogers@google.com>
	 <20251001181229.1010340-2-irogers@google.com>
	 <CAP-5=fVHetc8DqdqxURJm_VtaH6apJKoyVOSpfQrE2ntkEa+4g@mail.gmail.com>
In-Reply-To: <CAP-5=fVHetc8DqdqxURJm_VtaH6apJKoyVOSpfQrE2ntkEa+4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|SA1PR11MB6967:EE_
x-ms-office365-filtering-correlation-id: c88130f3-65e6-4546-86db-08de0519a1ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QXgvRTJWVXp4YWVHZDU5b2NReStxRERrajdNVHlCSUVZSGJpakJJeU5KZ3Z1?=
 =?utf-8?B?KzJXMCswU09MZ04zMnpOZDAyV0tCblJ3OXdSM1RvdFRURHlTUVY4WnJNUU1J?=
 =?utf-8?B?VCs0NFVULzM5dmlsdXpxMVBocy8yV0FCTEtxNW5BZzZnaUVPNldyeXpLSGxp?=
 =?utf-8?B?MHpSNmhDUnRkM0M2aFdOZ0FibWV0NUkxS3BXdmdsajhQbWFNQXJNNnhwYjBx?=
 =?utf-8?B?K2hRaFAwdmI0NVMzN0VQYTkvaWl3dXVaY0cxUUNTWmdJaUVQclUrR3dWalkx?=
 =?utf-8?B?K2RMbVhwVDJidzI3Z2Z5NDRPZ2pub3NlZ0pOUW42dzl6eW9oVHBLSGFjTU95?=
 =?utf-8?B?YjZscklpTjlHbktJMUVQUjIzbDZiZjY1TjZESkNrcVdVaTBFd1JHYzdpQ0U3?=
 =?utf-8?B?SHZBUnJ3NEVBUEZlSk91emJhMU9lc2xMS0U4OURTNWlkZmNuT2UyQ3B6N1VC?=
 =?utf-8?B?aUJYNGxsMUE0T1RwaTYyNHpCZEpONlZZVTVMMVNNUFFuWkp4QTBEQVM4RTVU?=
 =?utf-8?B?QnBXdFNCRk94cXAyajBvNHB3MTVpd2hZQzZhRnpXWXNEMUtsbzVlWGJ4Nk5U?=
 =?utf-8?B?T1Z2M2hDQzJhbmMyV0F6NisrNnpXQ3dodlcvYzd4UXB3ME5BM0R1M1dZdHJC?=
 =?utf-8?B?Y3luWjZiaXM2aGV4bUxlMGczQ0ZqM0FRZkx2ei9GamVuMXJuaThadEVCbjN1?=
 =?utf-8?B?Q3ZBWW9XbEVrbUhHUzdLYmVsZkk1V1JRVnFlQ2drWnJXOEt1Wjg5ZGp2cjJy?=
 =?utf-8?B?Y1ZtNEYrcTZBRU1xUU9BWEN3TjQzclF0dGV5dXpzWVcrMTczempNc2pqTEZL?=
 =?utf-8?B?YWthanFjd1VsMEtIekdjV3NBcmR6UXNhZkFiR0dmeUVMVEx6QVNEaVZQYjBn?=
 =?utf-8?B?Y3RtOGg3OWl3dHJ6djJwOU9nQyt2RmpLTHB5cHRldkNLTTJzaHNzUGpFVE1z?=
 =?utf-8?B?Y2VESEhXUFB6TmNBTElhcEF4MWMwMHZQckJYMm1wVktmQi9NdEZGRXg2Nzlk?=
 =?utf-8?B?VjA2UVhzZjNIY0YxY2hZMFpMcEtYek1MQkJWNW5vWmRvQVRjT3liRGU0TlZB?=
 =?utf-8?B?MWRnYzF5S0RSOVdMYVZjL1JJUU5ZNno5SUZCdUhUSXZpZFRwamF6bjhQQzJC?=
 =?utf-8?B?c09xS0p4MnRQZFFSU2hNSCtPc2VlQmhSa2JQNWVYMmpCQllyajlmdzFVS0tS?=
 =?utf-8?B?cXhLSERucmplVUkyMldpU0FvUktzR0JLYmMyRGNrRVU0YmljUGYrU3A2SnY2?=
 =?utf-8?B?UWorbUdyamNRYURlTWY1Yk5Yd0NOV0NNVGNUbXRRb2JGSWQxOU95VExiazcx?=
 =?utf-8?B?QXpjUkFyOGc0UmMxd2xvczZVUyswVDJWSmsrZ0VKVDFmNlNDYjRnU2pkcEYr?=
 =?utf-8?B?L0o5c3AzZE41bGNCb0YrNnFQT3dGbWR0MjhuRzd2RmptRVNFVU9hNkFXbGxX?=
 =?utf-8?B?cS9FbVFmWWJjUldzaXBHUHF0ZnBEZDQxVEpSWUl3VGVnaHhiWGFYelJRZGJI?=
 =?utf-8?B?cnZQVlNCMkZnRUJBcjQrNExXbmM5MUQyTDhvdHpxTFQyU1FsSDJpNWFjWGtH?=
 =?utf-8?B?ckJpYXJyajl3LzZtNG9rRXozbHZZZU5YOUhUKzNXZjR5SzZYTWNNK2FhcHha?=
 =?utf-8?B?K2QzQjlId0RNYmFCeWllbzRqYisyZ1NTdHBYaDZrdlFCVXNrOUVmNVNBUlF3?=
 =?utf-8?B?Z3JGV25oOUpYREFscThlRk1GQVRVdTBNQk1RbHQ1Q3RVQno0UFVpa09rQldy?=
 =?utf-8?B?SzhVTUN3bDhxOGdZMDRYV0ZOUm15N2VyV0VIRk5RZWdyRVI3bjcwZU9YVGp5?=
 =?utf-8?B?TUhFUWR0RFRwck1pMFhoZ00zZ2taMFF1aDRNVml6dzJ2Uzl1dGVRN2RGMnpE?=
 =?utf-8?B?TVpjb1F5OUNydnZGOGpwTW5xWk4xTzN3WWExVC92bllNVVRQTGlINU53ZzVR?=
 =?utf-8?B?bDl6YzlkY3BpRk9VNHE0d2RlQW5qL0F2ODhsdjVwK2lyWXp2ajRXeVQ3TjdK?=
 =?utf-8?B?Q2V6MWR5Y2RYUFpHQ0lIVGNycVMwczNpUk81U2FPY2h0YklDbmpxc0NrMS93?=
 =?utf-8?Q?RVxmLo?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTZOdlRFandDZGdZcWlROHVLeUhwakdDTmFuWExoZG5WNE5wbWlzOExpdnNL?=
 =?utf-8?B?dTdpKzlPbEJzb1VZY010UEJEVm56WHV3czRUWE53YWIzVzBWTjRMYkhsS2Y4?=
 =?utf-8?B?S0J2TzJHQ3ovR3c3enlGY01QMDQ2VnpxbnVwbDYxQXNMMnl5dEpIaEN6alI2?=
 =?utf-8?B?WlNUb1BQck41MHkwSmFvMkhuY3oweUVpR3RxdEN2MUNUa2VPMGFWem15QnhQ?=
 =?utf-8?B?aHF1YitDR1g2SVV0OGhnUm5GMHlFNVlDMXpOeklPL21OQll6QXhFZ295V3BF?=
 =?utf-8?B?QkZqd3FHei8zQXV2YzcxT0JPT1Z5RXRySFN1NEp5ZUZ3cng1MVFCMzBlMWlo?=
 =?utf-8?B?eXdkc3MyVlZuWU5VeWtFK291MU9TYWs0bndmWmxXc00xcjQwNjVkU285dzVB?=
 =?utf-8?B?dGdZVS9rdkdleUNZWExoNEdyaDRCS3dUSUNVbFNrWXFBQWFhVHJtWExJSzRl?=
 =?utf-8?B?eGNpSUozVkdSVFlFUFB1ekk1b2ZwVEhjb1Y3TTduNHM5MUpxYmVXU1NuUXJt?=
 =?utf-8?B?UE5BY0NMT3lQSVgrcnhKcE5iL3lOS1BaNkJYSWo0UnpPcjg4TGlMVFNZOGZV?=
 =?utf-8?B?YWlYV1JzdGwwNXZTdGlHWldXOUFaTkwxaGtsTzBWZEE1SDVnN28wOFEzalZO?=
 =?utf-8?B?U0cycGZ4NmR0RzdESjZtQ2EvL1hKbkFrV05UUzJWYzJsa1l2MEowQmZERFRQ?=
 =?utf-8?B?YzRaZEFVWTdZSW5YTlVmU1lzT01NdWpFampnQnZ3T2dxRDJFU1Z2SVJFdUVa?=
 =?utf-8?B?aThWcWUwZHMvNm94VFVhMExTNEU0QTNzUTY2SnZpQnFGWkVhQ3VGWGo1dG9s?=
 =?utf-8?B?bWtJQ1YvZmtoTlV1Q2xhL1kxaFF2cEoyMm5Yc0lFTmFrcWxYK2F2NncyOVE3?=
 =?utf-8?B?bnZaZHBXT2tuUTBVeUczZ25iY01Sa2RUMXEvL3dNTmFmc09DbVl6enppZGl3?=
 =?utf-8?B?aktQWU1TcytQck5KUGFNRlBhd1VhUVliNDVSQ0pkVVJxenBnZmhuQ0NQMVVi?=
 =?utf-8?B?a1NqZFdXQ0haQVpFUEdBVHVSR3ZPU0tUeUFDOTFBeldRR0gwVGtCNU0wbjM1?=
 =?utf-8?B?T1dLSENUc0JLdWtQUFpMUDc2ZHg0c3dwRW5CRkN1ckNFenhJMWVUcFR4Q0Yr?=
 =?utf-8?B?S1d3N25qZnFDbHE1VVZ3VHFrdDZPRUVoSHNoSmh1ekR6bTdrZWxvOVorcURZ?=
 =?utf-8?B?aW92WjVYdEFPbVh4a3Z5RzFPZlZ0S2NxbndvUmZiZFdFeDdMSFE1bDRqL1U3?=
 =?utf-8?B?cGhPOHlDeEJHMERsOUY0c2huRW1ZT3lIK2lNTU9nd0o5MmV6SmhwUk80T1VR?=
 =?utf-8?B?SXhaQ2w4bFByNnRESUtkcFExWVlaR0YzcXVodWliZ09pSi9POVRvZHoyQ3pp?=
 =?utf-8?B?cUhTRHdPUzluRU5NSmFmQ3dxQ2xkRFNjWTM1aHdIekc3UngxOVNrWFBhV2V6?=
 =?utf-8?B?N3huSEdGUmd2SlllTTFQR01oNERmZWdwSURpMEM2MUg5bVZCeS9MbGlCTWtp?=
 =?utf-8?B?RzljenJRR2VCVTJZNEkyTVZrWXlSRkhQaTZmajFnY0xuQVQ2M1BSeXlGbXVE?=
 =?utf-8?B?ajZ0M2g1Q1pqVWM1eGNJL3FyWVdjeFpFN3AxcU9lZW5vaWF1eDhQNEYrcDlE?=
 =?utf-8?B?LzJuVEkwYThSbmV4VTZzaXpOdnNqRFRTcm93Qm53bERkUm1MRGxVajVJMmhV?=
 =?utf-8?B?K3VjSzM3WHJUUXlMWDFPOVY2ejFtM0VvcisrMGVFRVhFdURnaDFuVGVZSnlV?=
 =?utf-8?B?M0xhc25aYzdocE5FUnlyWUloV05nN2J0aTZWZmFTU05vMXFVb2VlZUc0OSt2?=
 =?utf-8?B?N1pySU5yZEk3UEVscjM1bnM3T29YRTR1S0hRWFowYUNIMDhuM3FsWGxtZWpj?=
 =?utf-8?B?MHlyYUxEUjJSazFMM2VWU3ZJNWpLbmhLckdGajA4TkFDVHE5ZXJibGZwZlZt?=
 =?utf-8?B?YmRrbVBSazYzM1FON3c3Y096QllrMzdkTnJHZ1VjcENQWkJjcFB3NUs0bEFh?=
 =?utf-8?B?d1ErOU01RmpLMVZqd1FDMDlNcmtnMXZQc3RDbHFIWllsbllwRUR6RlVCSk5N?=
 =?utf-8?B?RWxZZ0JwaURYbFk5dWU3NVpQMkkxdzRRdnNMbi9GaDY4ZFZDaFRlVXFiQUhu?=
 =?utf-8?B?WnBCbWhNNE9zMnl2OTV0QkRybW5Edm9hN3JqMTlTd2VnU0pBUGJqOVNMbDhm?=
 =?utf-8?B?eS9jeW9WRURLNjBaM0ZwTEg5RDh2YmErSnpxTWNCVHlqSXRsTGZmU1JvaUlQ?=
 =?utf-8?B?RFhEY1FENTAvSjd1ZlAxNFV2RUVRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CC9A467D32829439D0B7724E11F69ED@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88130f3-65e6-4546-86db-08de0519a1ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 20:47:57.8445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 91OlBrT9ODt+hBKZioxA0ioavADtKwNUqIQOprF60F1sTe4EXpsevv3w50cASZnabKnemUKMRMXSfBje8F5O/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6967
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTEwLTA2IGF0IDA5OjE4IC0wNzAwLCBJYW4gUm9nZXJzIHdyb3RlOgo+IE9u
IFdlZCwgT2N0IDEsIDIwMjUgYXQgMTE6MTLigK9BTSBJYW4gUm9nZXJzIDxpcm9nZXJzQGdvb2ds
ZS5jb20+Cj4gd3JvdGU6Cj4gPiAKPiA+IERvbid0IG9wZW4gZXZzZWxzIG9uIGFsbCBDUFVzLCBv
cGVuIHRoZW0ganVzdCBvbiB0aGUgQ1BVcyB0aGV5Cj4gPiBzdXBwb3J0LiBUaGlzIGF2b2lkcyBv
cGVuaW5nIHNheSBhbiBlLWNvcmUgZXZlbnQgb24gYSBwLWNvcmUgYW5kCj4gPiBnZXR0aW5nIGEg
ZmFpbHVyZSAtIGFjaGlldmUgdGhpcyBieSBnZXR0aW5nIHJpZCBvZiB0aGUKPiA+ICJhbGxfY3B1
X21hcCIuCj4gPiAKPiA+IEluIGluc3RhbGxfcGUgZnVuY3Rpb25zIGRvbid0IHVzZSB0aGUgY3B1
X21hcF9pZHggYXMgYSBDUFUgbnVtYmVyLAo+ID4gdHJhbnNsYXRlIHRoZSBjcHVfbWFwX2lkeCwg
d2hpY2ggaXMgYSBkZW5zZSBpbmRleCBpbnRvIHRoZSBjcHVfbWFwCj4gPiBza2lwcGluZyBob2xl
cyBhdCB0aGUgYmVnaW5uaW5nLCB0byBhIHByb3BlciBDUFUgbnVtYmVyLgo+ID4gCj4gPiBCZWZv
cmU6Cj4gPiBgYGAKPiA+ICQgcGVyZiBzdGF0IC0tYnBmLWNvdW50ZXJzIC1hIC1lIGN5Y2xlcyxp
bnN0cnVjdGlvbnMgLS0gc2xlZXAgMQo+ID4gCj4gPiDCoFBlcmZvcm1hbmNlIGNvdW50ZXIgc3Rh
dHMgZm9yICdzeXN0ZW0gd2lkZSc6Cj4gPiAKPiA+IMKgwqAgPG5vdCBzdXBwb3J0ZWQ+wqDCoMKg
wqDCoCBjcHVfYXRvbS9jeWNsZXMvCj4gPiDCoMKgwqDCoMKgwqAgNTY2LDI3MCw2NzLCoMKgwqDC
oMKgIGNwdV9jb3JlL2N5Y2xlcy8KPiA+IMKgwqAgPG5vdCBzdXBwb3J0ZWQ+wqDCoMKgwqDCoCBj
cHVfYXRvbS9pbnN0cnVjdGlvbnMvCj4gPiDCoMKgwqDCoMKgwqAgNTcyLDc5Miw4MzbCoMKgwqDC
oMKgIGNwdV9jb3JlL2luc3RydWN0aW9ucy/CoMKgwqDCoMKgwqDCoMKgwqDCoCAjwqDCoMKgIDEu
MDHCoAo+ID4gaW5zbiBwZXIgY3ljbGUKPiA+IAo+ID4gwqDCoMKgwqDCoMKgIDEuMDAxNTk1Mzg0
IHNlY29uZHMgdGltZSBlbGFwc2VkCj4gPiBgYGAKPiA+IAo+ID4gQWZ0ZXI6Cj4gPiBgYGAKPiA+
ICQgcGVyZiBzdGF0IC0tYnBmLWNvdW50ZXJzIC1hIC1lIGN5Y2xlcyxpbnN0cnVjdGlvbnMgLS0g
c2xlZXAgMQo+ID4gCj4gPiDCoFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdzeXN0ZW0g
d2lkZSc6Cj4gPiAKPiA+IMKgwqDCoMKgwqDCoCA0NDMsMjk5LDIwMcKgwqDCoMKgwqAgY3B1X2F0
b20vY3ljbGVzLwo+ID4gwqDCoMKgwqAgMSwyMzMsOTE5LDczN8KgwqDCoMKgwqAgY3B1X2NvcmUv
Y3ljbGVzLwo+ID4gwqDCoMKgwqDCoMKgIDIxMyw2MzQsMTEywqDCoMKgwqDCoCBjcHVfYXRvbS9p
bnN0cnVjdGlvbnMvwqDCoMKgwqDCoMKgwqDCoMKgwqAgI8KgwqDCoCAwLjQ4wqAKPiA+IGluc24g
cGVyIGN5Y2xlCj4gPiDCoMKgwqDCoCAyLDc1OCw5NjUsNTI3wqDCoMKgwqDCoCBjcHVfY29yZS9p
bnN0cnVjdGlvbnMvwqDCoMKgwqDCoMKgwqDCoMKgwqAgI8KgwqDCoCAyLjI0wqAKPiA+IGluc24g
cGVyIGN5Y2xlCj4gPiAKPiA+IMKgwqDCoMKgwqDCoCAxLjAwMTY5OTQ4NSBzZWNvbmRzIHRpbWUg
ZWxhcHNlZAo+ID4gYGBgCj4gPiAKPiA+IEZpeGVzOiA3ZmFjODNhYWYyZWUgKCJwZXJmIHN0YXQ6
IEludHJvZHVjZSAnYnBlcmYnIHRvIHNoYXJlCj4gPiBoYXJkd2FyZSBQTUNzIHdpdGggQlBGIikK
PiA+IFNpZ25lZC1vZmYtYnk6IElhbiBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT4KPiAKPiAr
VGhvbWFzIEZhbGNvbgo+IAo+IEkgdGhpbmsgaXQnZCBiZSBuaWNlIHRvIGdldCB0aGlzIHF1aXRl
IG1ham9yIGZpeCBmb3IKPiAtLWJwZi1jb3VudGVycy9icGVyZiBmb3IgaHlicmlkIGFyY2hpdGVj
dHVyZXMgaW50byB2Ni4xOCBhbmQgc3RhYmxlCj4gYnVpbGRzLiBUaG9tYXMgd291bGQgaXQgYmUg
cG9zc2libGUgZm9yIHlvdSB0byBnaXZlIGEgVGVzdGVkLWJ5IHRhZwo+IHVzaW5nIHRoZSByZXBy
b2R1Y3Rpb24gaW4gdGhlIGNvbW1pdCBtZXNzYWdlPwo+IAo+IFRoYW5rcywKPiBJYW4KPiAKClNv
cnJ5IGZvciBtaXNzaW5nIHRoaXMuIEhlcmUncyBteSByZXByb2R1Y3Rpb24gb24gYW4gYWxkZXIg
bGFrZQoKc3VkbyAuL3BlcmYgc3RhdCAtLWJwZi1jb3VudGVycyAtYSAtZSBjeWNsZXMsaW5zdHJ1
Y3Rpb25zIC0tIHNsZWVwIDEKLi4uCgogUGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJ3N5
c3RlbSB3aWRlJzoKCiAgICAgICAzNjQsNzE1LDg5NiAgICAgIGNwdV9hdG9tL2N5Y2xlcy8gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgIDk0NiwzMzEsOTU3ICAgICAgY3B1X2Nv
cmUvY3ljbGVzLyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgMTY5LDg0Miw5
MjkgICAgICBjcHVfYXRvbS9pbnN0cnVjdGlvbnMvICAgICAgICAgICAjICAgIDAuNDcgCmluc24g
cGVyIGN5Y2xlICAgICAgICAgICAgCiAgICAgMSwzMzgsNzIwLDMyNCAgICAgIGNwdV9jb3JlL2lu
c3RydWN0aW9ucy8gICAgICAgICAgICMgICAgMS40MSAKaW5zbiBwZXIgY3ljbGUgICAgICAgICAg
ICAKCiAgICAgICAxLjAwMTY2Nzc2OSBzZWNvbmRzIHRpbWUgZWxhcHNlZAoKSXQgbG9va3MgbGlr
ZSBpdCdzIGluIHBlcmYtdG9vbHMtbmV4dCBhbHJlYWR5IGJ1dCBoYXZlIG15IHRlc3RlZCBieSBm
b3IKd2hhdCBpdCdzIHdvcnRoLgoKVGVzdGVkLWJ5OiBUaG9tYXMgRmFsY29uIDx0aG9tYXMuZmFs
Y29uQGludGVsLmNvbT4KCgo+ID4gLS0tCj4gPiDCoHRvb2xzL3BlcmYvdXRpbC9icGZfY291bnRl
ci5jwqDCoMKgwqDCoMKgwqAgfCAyNiArKysrKysrKysrLS0tLS0tLS0tLS0tLS0KPiA+IC0tCj4g
PiDCoHRvb2xzL3BlcmYvdXRpbC9icGZfY291bnRlcl9jZ3JvdXAuYyB8wqAgMyArKy0KPiA+IMKg
MiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKPiA+IAo+
ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC9icGZfY291bnRlci5jCj4gPiBiL3Rvb2xz
L3BlcmYvdXRpbC9icGZfY291bnRlci5jCj4gPiBpbmRleCAxYzZjYjVlYTA3N2UuLmNhNWQwMWI5
MDE3ZCAxMDA2NDQKPiA+IC0tLSBhL3Rvb2xzL3BlcmYvdXRpbC9icGZfY291bnRlci5jCj4gPiAr
KysgYi90b29scy9wZXJmL3V0aWwvYnBmX2NvdW50ZXIuYwo+ID4gQEAgLTMzNiw2ICszMzYsNyBA
QCBzdGF0aWMgaW50Cj4gPiBicGZfcHJvZ3JhbV9wcm9maWxlcl9faW5zdGFsbF9wZShzdHJ1Y3Qg
ZXZzZWwgKmV2c2VsLCBpbnQKPiA+IGNwdV9tYXBfaWR4Cj4gPiDCoHsKPiA+IMKgwqDCoMKgwqDC
oMKgIHN0cnVjdCBicGZfcHJvZ19wcm9maWxlcl9icGYgKnNrZWw7Cj4gPiDCoMKgwqDCoMKgwqDC
oCBzdHJ1Y3QgYnBmX2NvdW50ZXIgKmNvdW50ZXI7Cj4gPiArwqDCoMKgwqDCoMKgIGludCBjcHUg
PSBwZXJmX2NwdV9tYXBfX2NwdShldnNlbC0+Y29yZS5jcHVzLAo+ID4gY3B1X21hcF9pZHgpLmNw
dTsKPiA+IMKgwqDCoMKgwqDCoMKgIGludCByZXQ7Cj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgIGxp
c3RfZm9yX2VhY2hfZW50cnkoY291bnRlciwgJmV2c2VsLT5icGZfY291bnRlcl9saXN0LAo+ID4g
bGlzdCkgewo+ID4gQEAgLTM0Myw3ICszNDQsNyBAQCBzdGF0aWMgaW50Cj4gPiBicGZfcHJvZ3Jh
bV9wcm9maWxlcl9faW5zdGFsbF9wZShzdHJ1Y3QgZXZzZWwgKmV2c2VsLCBpbnQKPiA+IGNwdV9t
YXBfaWR4Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXNzZXJ0KHNrZWwgIT0g
TlVMTCk7Cj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBicGZf
bWFwX3VwZGF0ZV9lbGVtKGJwZl9tYXBfX2ZkKHNrZWwtCj4gPiA+bWFwcy5ldmVudHMpLAo+ID4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZjcHVfbWFwX2lkeCwgJmZkLAo+ID4gQlBGX0FOWSk7
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmNwdSwgJmZkLCBCUEZfQU5ZKTsKPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+ID4gwqDCoMKgwqDC
oMKgwqAgfQo+ID4gQEAgLTQ1MSw3ICs0NTIsNiBAQCBzdGF0aWMgaW50IGJwZXJmX2NoZWNrX3Rh
cmdldChzdHJ1Y3QgZXZzZWwKPiA+ICpldnNlbCwKPiA+IMKgwqDCoMKgwqDCoMKgIHJldHVybiAw
Owo+ID4gwqB9Cj4gPiAKPiA+IC1zdGF0aWMgc3RydWN0IHBlcmZfY3B1X21hcCAqYWxsX2NwdV9t
YXA7Cj4gPiDCoHN0YXRpYyBfX3UzMiBmaWx0ZXJfZW50cnlfY250Owo+ID4gCj4gPiDCoHN0YXRp
YyBpbnQgYnBlcmZfcmVsb2FkX2xlYWRlcl9wcm9ncmFtKHN0cnVjdCBldnNlbCAqZXZzZWwsIGlu
dAo+ID4gYXR0cl9tYXBfZmQsCj4gPiBAQCAtNDk1LDcgKzQ5NSw3IEBAIHN0YXRpYyBpbnQgYnBl
cmZfcmVsb2FkX2xlYWRlcl9wcm9ncmFtKHN0cnVjdAo+ID4gZXZzZWwgKmV2c2VsLCBpbnQgYXR0
cl9tYXBfZmQsCj4gPiDCoMKgwqDCoMKgwqDCoMKgICogZm9sbG93aW5nIGV2c2VsX19vcGVuX3Bl
cl9jcHUgY2FsbAo+ID4gwqDCoMKgwqDCoMKgwqDCoCAqLwo+ID4gwqDCoMKgwqDCoMKgwqAgZXZz
ZWwtPmxlYWRlcl9za2VsID0gc2tlbDsKPiA+IC3CoMKgwqDCoMKgwqAgZXZzZWxfX29wZW5fcGVy
X2NwdShldnNlbCwgYWxsX2NwdV9tYXAsIC0xKTsKPiA+ICvCoMKgwqDCoMKgwqAgZXZzZWxfX29w
ZW4oZXZzZWwsIGV2c2VsLT5jb3JlLmNwdXMsIGV2c2VsLT5jb3JlLnRocmVhZHMpOwo+ID4gCj4g
PiDCoG91dDoKPiA+IMKgwqDCoMKgwqDCoMKgIGJwZXJmX2xlYWRlcl9icGZfX2Rlc3Ryb3koc2tl
bCk7Cj4gPiBAQCAtNTMzLDEyICs1MzMsNiBAQCBzdGF0aWMgaW50IGJwZXJmX19sb2FkKHN0cnVj
dCBldnNlbCAqZXZzZWwsCj4gPiBzdHJ1Y3QgdGFyZ2V0ICp0YXJnZXQpCj4gPiDCoMKgwqDCoMKg
wqDCoCBpZiAoYnBlcmZfY2hlY2tfdGFyZ2V0KGV2c2VsLCB0YXJnZXQsICZmaWx0ZXJfdHlwZSwK
PiA+ICZmaWx0ZXJfZW50cnlfY250KSkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gLTE7Cj4gPiAKPiA+IC3CoMKgwqDCoMKgwqAgaWYgKCFhbGxfY3B1X21hcCkgewo+
ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWxsX2NwdV9tYXAgPSBwZXJmX2NwdV9t
YXBfX25ld19vbmxpbmVfY3B1cygpOwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKCFhbGxfY3B1X21hcCkKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gLTE7Cj4gPiAtwqDCoMKgwqDCoMKgIH0KPiA+IC0KPiA+IMKgwqDC
oMKgwqDCoMKgIGV2c2VsLT5icGVyZl9sZWFkZXJfcHJvZ19mZCA9IC0xOwo+ID4gwqDCoMKgwqDC
oMKgwqAgZXZzZWwtPmJwZXJmX2xlYWRlcl9saW5rX2ZkID0gLTE7Cj4gPiAKPiA+IEBAIC02NTYs
OSArNjUwLDEwIEBAIHN0YXRpYyBpbnQgYnBlcmZfX2xvYWQoc3RydWN0IGV2c2VsICpldnNlbCwK
PiA+IHN0cnVjdCB0YXJnZXQgKnRhcmdldCkKPiA+IMKgc3RhdGljIGludCBicGVyZl9faW5zdGFs
bF9wZShzdHJ1Y3QgZXZzZWwgKmV2c2VsLCBpbnQgY3B1X21hcF9pZHgsCj4gPiBpbnQgZmQpCj4g
PiDCoHsKPiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBicGVyZl9sZWFkZXJfYnBmICpza2VsID0g
ZXZzZWwtPmxlYWRlcl9za2VsOwo+ID4gK8KgwqDCoMKgwqDCoCBpbnQgY3B1ID0gcGVyZl9jcHVf
bWFwX19jcHUoZXZzZWwtPmNvcmUuY3B1cywKPiA+IGNwdV9tYXBfaWR4KS5jcHU7Cj4gPiAKPiA+
IMKgwqDCoMKgwqDCoMKgIHJldHVybiBicGZfbWFwX3VwZGF0ZV9lbGVtKGJwZl9tYXBfX2ZkKHNr
ZWwtPm1hcHMuZXZlbnRzKSwKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmNwdV9tYXBfaWR4LCAmZmQsIEJQRl9B
TlkpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAmY3B1LCAmZmQsIEJQRl9BTlkpOwo+ID4gwqB9Cj4gPiAKPiA+
IMKgLyoKPiA+IEBAIC02NjcsMTMgKzY2MiwxMiBAQCBzdGF0aWMgaW50IGJwZXJmX19pbnN0YWxs
X3BlKHN0cnVjdCBldnNlbAo+ID4gKmV2c2VsLCBpbnQgY3B1X21hcF9pZHgsIGludCBmZCkKPiA+
IMKgICovCj4gPiDCoHN0YXRpYyBpbnQgYnBlcmZfc3luY19jb3VudGVycyhzdHJ1Y3QgZXZzZWwg
KmV2c2VsKQo+ID4gwqB7Cj4gPiAtwqDCoMKgwqDCoMKgIGludCBudW1fY3B1LCBpLCBjcHU7Cj4g
PiArwqDCoMKgwqDCoMKgIHN0cnVjdCBwZXJmX2NwdSBjcHU7Cj4gPiArwqDCoMKgwqDCoMKgIGlu
dCBpZHg7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgIHBlcmZfY3B1X21hcF9fZm9yX2VhY2hfY3B1
KGNwdSwgaWR4LCBldnNlbC0+Y29yZS5jcHVzKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgYnBlcmZfdHJpZ2dlcl9yZWFkaW5nKGV2c2VsLT5icGVyZl9sZWFkZXJfcHJvZ19mZCwK
PiA+IGNwdS5jcHUpOwo+ID4gCj4gPiAtwqDCoMKgwqDCoMKgIG51bV9jcHUgPSBwZXJmX2NwdV9t
YXBfX25yKGFsbF9jcHVfbWFwKTsKPiA+IC3CoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IG51
bV9jcHU7IGkrKykgewo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3B1ID0gcGVy
Zl9jcHVfbWFwX19jcHUoYWxsX2NwdV9tYXAsIGkpLmNwdTsKPiA+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGJwZXJmX3RyaWdnZXJfcmVhZGluZyhldnNlbC0+YnBlcmZfbGVhZGVyX3By
b2dfZmQsCj4gPiBjcHUpOwo+ID4gLcKgwqDCoMKgwqDCoCB9Cj4gPiDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gMDsKPiA+IMKgfQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi91dGlsL2Jw
Zl9jb3VudGVyX2Nncm91cC5jCj4gPiBiL3Rvb2xzL3BlcmYvdXRpbC9icGZfY291bnRlcl9jZ3Jv
dXAuYwo+ID4gaW5kZXggZWQ2YTI5YjEwNmI0Li42OTBiZTNjZTNlMTEgMTAwNjQ0Cj4gPiAtLS0g
YS90b29scy9wZXJmL3V0aWwvYnBmX2NvdW50ZXJfY2dyb3VwLmMKPiA+ICsrKyBiL3Rvb2xzL3Bl
cmYvdXRpbC9icGZfY291bnRlcl9jZ3JvdXAuYwo+ID4gQEAgLTE4Niw3ICsxODYsOCBAQCBzdGF0
aWMgaW50IGJwZXJmX2NncnBfX2xvYWQoc3RydWN0IGV2c2VsCj4gPiAqZXZzZWwsCj4gPiDCoH0K
PiA+IAo+ID4gwqBzdGF0aWMgaW50IGJwZXJmX2NncnBfX2luc3RhbGxfcGUoc3RydWN0IGV2c2Vs
ICpldnNlbAo+ID4gX19tYXliZV91bnVzZWQsCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgY3B1IF9fbWF5YmVf
dW51c2VkLCBpbnQgZmQKPiA+IF9fbWF5YmVfdW51c2VkKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IGNwdV9t
YXBfaWR4IF9fbWF5YmVfdW51c2VkLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IGZkIF9fbWF5YmVfdW51c2Vk
KQo+ID4gwqB7Cj4gPiDCoMKgwqDCoMKgwqDCoCAvKiBub3RoaW5nIHRvIGRvICovCj4gPiDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gMDsKPiA+IC0tCj4gPiAyLjUxLjAuNjE4Lmc5ODNmZDk5ZDI5LWdv
b2cKPiA+IAoK

