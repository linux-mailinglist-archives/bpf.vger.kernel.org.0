Return-Path: <bpf+bounces-44954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1149CE15A
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 15:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D46F280A61
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 14:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964501CF2A3;
	Fri, 15 Nov 2024 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WEmF4zP3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C873A1BF;
	Fri, 15 Nov 2024 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681304; cv=fail; b=hHBkZ8Bvqrdb0cbH/sMlLAgyhdPtwf4fcvwO4cFiSkmaeo/uL6VHgORfzzEEmf+5ICqstd1CJgvMrdk7iHxhsYKeDlgPY3qvAiKXp3yvOBj0SxtspmR4cQhTC/W2sKcIKUcQuLS2MMTHKGABrPrZyM8QF7oWvEvmOQkSqJgCk5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681304; c=relaxed/simple;
	bh=SZRbohev+iXCC31VYnR2yIl1IMUwa94nTYqRT+TbI9k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RlNCvFXTL13OKOqryVV0Z24VJD0a73GDHP9HnMdSJjr9K8NK2kHyEQomGUV6jPRWciZ4fggumjyfC4zDD0azGHMAclbGj3a1CWRmXgM5hoXlnRtA9ll1pqk3FrrT0icN35G/TFKJo0sA0zfXNwruVWMqrXJLwxZtdZHh7J59VIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WEmF4zP3; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731681302; x=1763217302;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SZRbohev+iXCC31VYnR2yIl1IMUwa94nTYqRT+TbI9k=;
  b=WEmF4zP33nPlVt3OQooUNDZJdQG/AaYVoLNcLG0BZltgNXSJ31sp7sZj
   MiKboDKBX//nGMIdBeVP70IL44wU5prvFC7jj1gJK6tq937Vfcu5gkDb0
   zkB7KkTrGVKNgv37k3SvELZP/On5z9BIRdFXjtqViRfGDYkfzM30mC/hJ
   j2P0wt5zFIGEuBoeiloatKkzbGnGBD1yl5wcEPqzpbx350QOcB2WHEiZj
   Ja7C7A/gqb7ITWIK0bum92+sij2tuamTUcQtKAoFqho2QNeHw9RY47pym
   8h6iDzF1Of3+1GRy4XFmCMqsJdveYfvvUU0InAnBGMOTLwgcqmVEIz5Jl
   A==;
X-CSE-ConnectionGUID: s7tvYj7tQ2WMS60gx11vwQ==
X-CSE-MsgGUID: BG1lAwRMSpK7GoBBNp7yEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="31636812"
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="31636812"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 06:35:01 -0800
X-CSE-ConnectionGUID: w8lrydOeTmeZCxnPRDYh9A==
X-CSE-MsgGUID: 4414Yl/tS3+0AlXwo7NpQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="88332334"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2024 06:35:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 06:35:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 15 Nov 2024 06:35:00 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 06:34:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEQA7xtkfi4t2+CMSKprdgDH4Conxo1m8W1zr/xmZjTSTBJkjEGbOicX3na4oCJcUJeq+8TdGTI0WX96iG7MUAdJAUa/KcrnzzNw49baFe3g1tcwqkdKOgGS9GmXILk79WtD+M7nw8QMIKHiy2dDKxtQkDnp+mCbp3DjenXWpStRz4iMbYODteROEHMULBv52kjiLDN152UjBD0/GRCW0Ssg0gh0JyM1XwP6v6eUU1GR0ToSMp45Bs2AAC0x1mljG4JwxWQSCsbguJLSmIC/cEwK5/Er4U6acYuaYBavoqRuWOUAhnT8XQEid32g5teK6UiUGjBjOzkcTT2DmvYgVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiaSFOhFgyO2AYUbzD0pvbLOYI8jdHwrs7mGX36hrEM=;
 b=uqmuq1794qrhuJNiwlGh0LO2S9oza7rFXZxli6MbtNmbOeEJzNUYeZIXTj56D8+2H/kAmvFaKAJrNkfVRzZTCJ2rXqV5OQRuCth76kmxryx/cE0IujCjMkOuUuXNX6lUZmcMgwLSIq7rQZ/21xrprSGZhBFzRH4FG30g/L96UzmJjVs94d7UTmV75e8WCMI8a61w1iCvI35juifHe7hHbAITZPmwCKWZHEf1Rub7Xp243qF/PQe/UrjRQuDpxueNgMIPFX8VOu9SBiXc366TZenTy/TuY/X1u0a141VQeuwx1pZCpX4thuZluWN/Kz2984iTa/h9haWqElY+LRDp1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB6430.namprd11.prod.outlook.com (2603:10b6:8:b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 14:34:56 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%6]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:34:56 +0000
Message-ID: <59d1cb78-8323-426a-b1b5-e5163b29569c@intel.com>
Date: Fri, 15 Nov 2024 15:34:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 12/19] xdp: add generic
 xdp_build_skb_from_buff()
To: Ido Schimmel <idosch@idosch.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
 <20241113152442.4000468-13-aleksander.lobakin@intel.com>
 <ZzYR2ZJ1mGRq12VL@shredder> <ZzYUXPq_KtjpNffW@shredder>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ZzYUXPq_KtjpNffW@shredder>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB7PR02CA0031.eurprd02.prod.outlook.com
 (2603:10a6:10:52::44) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ad4615-1e08-40ff-6980-08dd0582ad1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MldOYWNSN0c0WFg1TWZzN0M1cTNOWURkN3BTYzNnUmxjNTkranFyaGtNL1lC?=
 =?utf-8?B?Y2NsZGZlbE1FTmhYb0VvNVpXSnpXWmdPVUdhR0tuUTFZM2xtK2NZSnVoKyth?=
 =?utf-8?B?L0x3RjlxY0tBamMrUXU3VWF3Vi9GRGNRTkpvR0F6OHRzdzduSUZnbm5VRDNp?=
 =?utf-8?B?aU1NNi9mN1k4bVlpRzZjSnRMMDJpTi9GbDQyU2JvRDhnUlRUN0Juc25mQU4y?=
 =?utf-8?B?cDhIalpWTTdSai9tcHBVQU5GZUozZGJKQ3dIc2RvamJ3cVl4V0g5L1BOMTZW?=
 =?utf-8?B?UGowOE9vclhZa09tTnRxRmovTHM1R1owb0VsbEh1aWxrWXBpTVIzbXNsblhw?=
 =?utf-8?B?TnhKcmhxWjBTMC9WWkFZTUozazl0eERVMkp4NU1Hc3pWZEswY3VwRlVJV1VL?=
 =?utf-8?B?Qk4xWDB2a09QYlpmNVc0VEdXbVpGRGttVGZyeGFDZEU5T2NmSXVXRllQbTky?=
 =?utf-8?B?THJSdmtCYmNaMnZ6MG1meTUwOTAvVmZRTUhGZUsrRWFiN3cweG1DcnphQnkx?=
 =?utf-8?B?V21JMWwzWDJGb0t6c3NNRVphK1Y1aWxpWkJCRWNDakgwaHpXdXYyTGZ6NjdI?=
 =?utf-8?B?U1RUc3BWNlZYcUU3eDREYk10ZklWYUQ5OTZaVFY3ajRYRm9TS2pYTXQ5aDVX?=
 =?utf-8?B?RXF5a3FMbTFwdC9YOUtHeEhtVlo1NVRSUzNCU2RhZTloWk5lTmJjWkw1Zkoy?=
 =?utf-8?B?SU5kNWhsY0MwS0p1UWwwdTlUQzI5ZjFpYkFDdUIxRXhNWWZHYmJBTmZBMTVr?=
 =?utf-8?B?TlhpZ3FEdmt2NktxVjRiYVdqY1FwcUZkNkl5dTlibXpUSmVMN3dlVUNyTDFZ?=
 =?utf-8?B?UjZSdGhReUlMNHlFS1IyZG5Sa1YwcllZMS9tTzhCWnpVZkN2eWoySHRBeGFj?=
 =?utf-8?B?dGVpbklCNXZ3cUxzTGpaUkdOYnFrU29hV0xqQzQ0b0tNcEpOWmkvbEJFOGRK?=
 =?utf-8?B?VGRRcm9rdzhLbWlod1I4em9rb05UY25nc1FHL3dFRXlqTXBrazJ1Q3cwUlVP?=
 =?utf-8?B?SWZPNFQ3RGpPQ3ZqRWVtQzYzaVB6SXhrWDJUZnBFQ1ljQXdQTHJxenMzbGp3?=
 =?utf-8?B?V3RXZXdwcVgxemd1ZnZKd3VldUM4a05sQWdSL3E2am10SkZiQW1JTFZXdmRS?=
 =?utf-8?B?WXEzOStXYnViY3JlMkZuc2tITVNnSDVGd3hjWUxWWk9nZDNXNlVjNGhoYUlW?=
 =?utf-8?B?SWd5Ymx0OVZtRnNMaFhXdHJ1MmZidHNlRm1BbDNTcFRueHErd2twbTRlN0ty?=
 =?utf-8?B?RmlCYTVVZnhySGdyTjJkVk82Um1aSVRaM2oyTnJXN3VZUG43NnlJMTZtZWFJ?=
 =?utf-8?B?c3FoUVdJaFUweWoxMXlDT1lIcU9xeVU1NGxhd0xyektUcm5BM21ielhpcXhv?=
 =?utf-8?B?Q1p0WXdaNkpTdzFwV3JkM2ErNEhwLzBhbStSMGVvV0NMTElnK0NrRFd0d0I1?=
 =?utf-8?B?QjBUN3BidmU0UndRR1lxMjUvTzJscUlWK0k5S2RRclp1WnRoZ0NjZHdoRVl3?=
 =?utf-8?B?T1ZSSGxIQnozdG1EMk1WOHJWTlNOeWUrYWdYcEhEVUNSa204NC81MXpLMUF1?=
 =?utf-8?B?aXlDUkd0K1RpblRacW04VXFPRGhjMGpIS0tHbjdNYVRsaXVhOVBJcDluT0lR?=
 =?utf-8?B?Rk11NVA1MW9JdVFIOTBXUUNCajF1UEVUaTZUSU4xWGZ4aDk4ZnI3YzdSbWV4?=
 =?utf-8?B?c2xtUjRjT3ovL2hGS0ROcWgwaG5IZnhpSUl2S2dFRTZRNEN0dnBuK3J2eHF0?=
 =?utf-8?Q?DNTLWQ1qk6UDTwyLAQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UllkVTFqanJCMmtYZlphdlBRVzdXUnJDS2c1UWpEOVZBaXNwOXV1eS9ZeG1m?=
 =?utf-8?B?VFVrQ09mc01oR1IvV216Q0JCaDJla1lkSGhRWDlhR2JxbXArV1hhNHQ4WktQ?=
 =?utf-8?B?MDk0Z1RJYXE5KzVjSnN3dXdkT205cE1zM1JqK0hTU3U5TEgrTHBjN3hoTzEz?=
 =?utf-8?B?ZmdrY2dmRlM3K1JmLzdTS04rQmNTLzhXUkdIQzZuY2FSVk1mRHVFMmlBaXB2?=
 =?utf-8?B?WGdRbmE0QmpaZFcvSUpEUkExNS84L082RjFNb3Irb1pXOWZ0WEJaQ0pXMmdo?=
 =?utf-8?B?WmN3VENSZEZjeFk5OWVLVjNXZjNtRUdoTFJScWFMem5DRld0WS8xMHdjVDJk?=
 =?utf-8?B?R3ZoYnVwVFluRG1BS2Qyc1B3UG9aRERjRjlSSVVnUzErWmhNZ2NUOUVOT0FZ?=
 =?utf-8?B?c3dsOU1LaXJ3WlFEeVVRcmIrMkhPWVVqM2N5YWhCbkYxRjlGUVhHV0tCUmlE?=
 =?utf-8?B?QnBjSzBnMVVqdjhoS1UwTCsvdjNXUGNKRGp1bHVzVklCQ2FMQ2NkcXZEVEx6?=
 =?utf-8?B?OGpwMUpuSXdiNE5BbnF4K3FxUGdKNkdNRjdIcURIZmtvQWxkckkwOXhuLzAw?=
 =?utf-8?B?ekh0Umk3bVpodzliYXJpdjRYMEdQTENnRjREMWFuTS9BVHYzTVo4cG1Jd1lq?=
 =?utf-8?B?UFhQekxIOWV2QVJGS1JUWlh2MXR5VjQ4emx0U2swZENwTDhBL21xM3Y4bDEx?=
 =?utf-8?B?MUV5UjFMQ21DS3IzWlZ5RGx3LzF0aEFhMkVDWThPT1pxV0V4dFJ5MW1SdXhE?=
 =?utf-8?B?azVVM0VzNjdrbFJXcVVvQnZrUjB0NXpqNm1DcGdjZHNYZnZJM00va3o4UUZu?=
 =?utf-8?B?N1NrOHR0VjRHVFlEaEZneUljZk5FMWNZNGZKZ0pQZVFaQnF4QnA4dkFnRXhT?=
 =?utf-8?B?TzNHU05RbFBWS0RHcEVNWGRoY1FUakIrajQ4T0NFS0ViZlZnVEFOeko5VXl1?=
 =?utf-8?B?d0prTDltS3RxV1huNFBQSGdFRGNDUjZ4YTVSNldKTGQvMUFVdjBjSDhwVnlW?=
 =?utf-8?B?eUtvZHFBdWJLTlNLeUdWUlpNTm1Gc0xraTUvQmZjVm9udUJvMkRXTU41T0Zh?=
 =?utf-8?B?d1BwVTZTM3Y0VGFPSWYxZmp2Z3VLRUNYNWFueFBqWFpvWCtycFp0c3Jpayt5?=
 =?utf-8?B?MHlSUm0ycHY1bmRUck5aR3VPbE9Odmk1aDFnVWhoTDBhMEVKNVRtNnVrV1FO?=
 =?utf-8?B?Y1FqSUZHWm1zcDZQbS9uM3oyalhGMmJXeG45NDY1V29mZVk4T2pZeWF4SlhX?=
 =?utf-8?B?SlBEVVVsWVBZWVMyd2VtR3FBTG5Sc1RqeHlOeE5JUjFYSDNjd1Rzak14T1U5?=
 =?utf-8?B?Y0JER1B3WGhBRVBYMFBWVG00WVYxZ3ZUQlNjcGxiTkRkVHNFT256Qm5oNXh2?=
 =?utf-8?B?aXR2V3VLQjdqelBIcGtlTk41QmdFeDM0eVVDWk91bnVsWXBOQzJua0tsUVd1?=
 =?utf-8?B?aVNJMThLNVFkSGxFNzhuaVdySDNWT2dUZS9KK25UVkZRQys5QU1hbXB4NnVL?=
 =?utf-8?B?Q2NjWWtJUE1PWjVSQnJNV3h0Z2VHcTUvQk1RUGUrbS9NNkZmMmE3UW1CVXNK?=
 =?utf-8?B?eXgreEFkc3cyMTRDNG1tOTBwK2dUT1YyYUlndjRzNHdjVXBFZExFNWRaY1F4?=
 =?utf-8?B?OGRkNEl3RTB0YmFTT3Q1Vnl0TDZFd0ZoZXVFNDlTQXBlcWMvVFJUWWduNk1k?=
 =?utf-8?B?NS9DWXh2ZEt5ZzQxcDVveG5XQlVCMEtqdkdFckMvbUlrYVFDV2xQZ1B3dU01?=
 =?utf-8?B?UGNhbUFHNm5KaU5FOUtsNmVIRGsxK1RXMlRYQjNvNHZKZzl0Y21LQmEyR1lL?=
 =?utf-8?B?Y01GR2NQQjh1TlZOV2NLQTEyR05lRFVOdWNScmxnckhVQUpZRk9US2lLOWxS?=
 =?utf-8?B?TkFnVE9yZjV3OC9TNEQ1QzhlRGJzenRUTDlSM3R2QUhtd2c1b05EYWxLMS9D?=
 =?utf-8?B?WUtScDhpNS85TDBqa0M3WFBvVkE1VUQyOXFROHV2VjRiRDVaUGJESzhSWUV1?=
 =?utf-8?B?Ym15SnVYODltaXNHSTkwVlJXYlNoNmVVaW9zb056TERaSWJGZmpaUVZlOE05?=
 =?utf-8?B?UTg3d1JUWEJ1VUdFSjUrRkkxRjk2bm1ZN1BFQWM5OUZLNUcrQ1I2TnhCdlVF?=
 =?utf-8?B?WWxIT1k3c0dpZnFsWkNhcTlvOG41STZIS3h3S085NmZtT0U4SGE5Zzd0U1hR?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ad4615-1e08-40ff-6980-08dd0582ad1f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:34:56.7060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6EmlkF8uP3jn7cuDDB0f+ivjGBrDcxhfYQIKNDDx5q0v7RIVmKrIJcjbJ47P0TKU4UZBHK3icT4SM3sBGnJetmgEYrN0PKBhO5Ah69pRks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6430
X-OriginatorOrg: intel.com

From: Ido Schimmel <idosch@idosch.org>
Date: Thu, 14 Nov 2024 17:16:44 +0200

> On Thu, Nov 14, 2024 at 05:06:06PM +0200, Ido Schimmel wrote:
>> Looks good (no objections to the patch), but I have a question. See
>> below.
>>
>> On Wed, Nov 13, 2024 at 04:24:35PM +0100, Alexander Lobakin wrote:
>>> The code which builds an skb from an &xdp_buff keeps multiplying itself
>>> around the drivers with almost no changes. Let's try to stop that by
>>> adding a generic function.
>>> Unlike __xdp_build_skb_from_frame(), always allocate an skbuff head
>>> using napi_build_skb() and make use of the available xdp_rxq pointer to
>>> assign the Rx queue index. In case of PP-backed buffer, mark the skb to
>>> be recycled, as every PP user's been switched to recycle skbs.
>>>
>>> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>
>> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>>
>>> ---
>>>  include/net/xdp.h |  1 +
>>>  net/core/xdp.c    | 55 +++++++++++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 56 insertions(+)
>>>
>>> diff --git a/include/net/xdp.h b/include/net/xdp.h
>>> index 4c19042adf80..b0a25b7060ff 100644
>>> --- a/include/net/xdp.h
>>> +++ b/include/net/xdp.h
>>> @@ -330,6 +330,7 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
>>>  void xdp_warn(const char *msg, const char *func, const int line);
>>>  #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
>>>  
>>> +struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp);
>>>  struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
>>>  struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
>>>  					   struct sk_buff *skb,
>>> diff --git a/net/core/xdp.c b/net/core/xdp.c
>>> index b1b426a9b146..3a9a3c14b080 100644
>>> --- a/net/core/xdp.c
>>> +++ b/net/core/xdp.c
>>> @@ -624,6 +624,61 @@ int xdp_alloc_skb_bulk(void **skbs, int n_skb, gfp_t gfp)
>>>  }
>>>  EXPORT_SYMBOL_GPL(xdp_alloc_skb_bulk);
>>>  
>>> +/**
>>> + * xdp_build_skb_from_buff - create an skb from an &xdp_buff
>>> + * @xdp: &xdp_buff to convert to an skb
>>> + *
>>> + * Perform common operations to create a new skb to pass up the stack from
>>> + * an &xdp_buff: allocate an skb head from the NAPI percpu cache, initialize
>>> + * skb data pointers and offsets, set the recycle bit if the buff is PP-backed,
>>> + * Rx queue index, protocol and update frags info.
>>> + *
>>> + * Return: new &sk_buff on success, %NULL on error.
>>> + */
>>> +struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
>>> +{
>>> +	const struct xdp_rxq_info *rxq = xdp->rxq;
>>> +	const struct skb_shared_info *sinfo;
>>> +	struct sk_buff *skb;
>>> +	u32 nr_frags = 0;
>>> +	int metalen;
>>> +
>>> +	if (unlikely(xdp_buff_has_frags(xdp))) {
>>> +		sinfo = xdp_get_shared_info_from_buff(xdp);
>>> +		nr_frags = sinfo->nr_frags;
>>> +	}
>>> +
>>> +	skb = napi_build_skb(xdp->data_hard_start, xdp->frame_sz);
>>> +	if (unlikely(!skb))
>>> +		return NULL;
>>> +
>>> +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
>>> +	__skb_put(skb, xdp->data_end - xdp->data);
>>> +
>>> +	metalen = xdp->data - xdp->data_meta;
>>> +	if (metalen > 0)
>>> +		skb_metadata_set(skb, metalen);
>>> +
>>> +	if (is_page_pool_compiled_in() && rxq->mem.type == MEM_TYPE_PAGE_POOL)
>>> +		skb_mark_for_recycle(skb);
>>> +
>>> +	skb_record_rx_queue(skb, rxq->queue_index);
>>> +
>>> +	if (unlikely(nr_frags)) {
>>> +		u32 tsize;
>>> +
>>> +		tsize = sinfo->xdp_frags_truesize ? : nr_frags * xdp->frame_sz;
>>> +		xdp_update_skb_shared_info(skb, nr_frags,
>>> +					   sinfo->xdp_frags_size, tsize,
>>> +					   xdp_buff_is_frag_pfmemalloc(xdp));
>>> +	}
>>> +
>>> +	skb->protocol = eth_type_trans(skb, rxq->dev);
>>
>> The device we are working with has more ports (net devices) than Rx
>> queues, so each queue can receive packets from different net devices.
>> Currently, each Rx queue has its own NAPI instance and its own page
>> pool. All the Rx NAPI instances are initialized using the same dummy net
>> device which is allocated using alloc_netdev_dummy().
>>
>> What are our options with regards to the XDP Rx queue info structure? As
>> evident by this patch, it does not seem valid to register one such
>> structure per Rx queue and pass the dummy net device. Would it be valid
>> to register one such structure per port (net device) and pass zero for
>> the queue index and NAPI ID?
> 
> Actually, this does not seem to be valid either as we need to associate
> an XDP Rx queue info with the correct page pool :/

Right.
But I'd say, this assoc slowly becomes redundant. For example, idpf has
up to 4 page_pools per queue and I only pass 1 of them to rxq_info as
there are no other options. Regardless, its frames get processed
correctly thanks to that we have struct page::pp pointer + patch 9 from
this series which teaches put_page_bulk() to handle mixed bulks.

Regarding your usecase -- after calling this function, you are free to
overwrite any skb fields as this helper doesn't pass it up the stack.
For example, in ice driver we have port reps and sometimes we need to
pass a different net_device, not the one saved in rxq_info. So when
switching to this function, we'll do eth_type_trans() once again (it's
either way under unlikely() in our code as it's swichdev slowpath).
Same for the queue number in rxq_info.

> 
>>
>> To be clear, I understand it is not a common use case.
>>
>> Thanks

Thanks,
Olek

