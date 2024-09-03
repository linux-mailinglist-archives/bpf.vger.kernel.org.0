Return-Path: <bpf+bounces-38769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BAB969D7D
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 14:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F01EAB21B3F
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 12:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDD51C987C;
	Tue,  3 Sep 2024 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XY3pleoq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34A11B12DE;
	Tue,  3 Sep 2024 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366427; cv=fail; b=EdPlhYOHYyS7HBX8+aEng41yfUBHHFWWtsJPWT3UvtJTdc4WalkqbCBRJ5R9O7XoH8I6s+LPFYvmk0V1akK34FdsHTe9cvKaQoa9INIj15868AcHd055PwnqWPIAmaGtY49WJwqgxGXMS4XcNeQQJrERmSLb4TRgtRjQN4v2yaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366427; c=relaxed/simple;
	bh=CHyXAfsNa9bbrrPXLLY7La91QnfmVYu3XuXVfYF1Bqc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WDOkWx1P6+YDjDq2ORC3qOrLo0D2v3Pt0hwZumUS6OM1xE7zg5rto/0ViecSrkq/eGC7MN0lDJ2VYtUuCqbopVLxz4vWsBr8FPF7a03+QvHAK+IW6mUSUkNGGYurIMZacxF1Vd8ruHY5ne6ynFTx7AqoGabjzG5Fu2HfYeAxoxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XY3pleoq; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725366426; x=1756902426;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CHyXAfsNa9bbrrPXLLY7La91QnfmVYu3XuXVfYF1Bqc=;
  b=XY3pleoqrtHVHTFIVD1xfsYCVncLLR2+sEACT+KJ6V1dvUY1UMqBel8n
   4+6etgGccnX7z+XeNFlrNLeEVDbq+ssJaS+YUP/UvLqovmVe3qjQAY258
   Z9LhY+pay4Q5C/w+PHZpgACp9kAMsdZP9GFtg8iGJkCd42x9TlWheAY2v
   NrUNgtWBBVBrETY22nPwo4Esi+1lX3lSBY34u+TtSj7sFR0BrXQFoWoiz
   jtKYL7rQAVuXtOhXuRT6Fy+4kmbv0HPQzeaqhc2i2zq9YY2/FkW8XKRnO
   OKcPdqb2h58ATVilGo/G566dWfADLAyEAt0+qdNKOVBeIvMLT/NEFsJMY
   A==;
X-CSE-ConnectionGUID: f7vMAqLgSWWS5PzNv4RueA==
X-CSE-MsgGUID: lj82VZbbTzWGpuJfoUK/Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="27841022"
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="27841022"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 05:27:04 -0700
X-CSE-ConnectionGUID: 3Ty+CgSPQ6isZ9a7wK1Q7w==
X-CSE-MsgGUID: fl5ePxqpTh2FgBstlVbIug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="65625329"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2024 05:27:03 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 05:27:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 05:27:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Sep 2024 05:27:02 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 05:27:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=if4mb0NLoHUfq1zUe1EBDa43o8RWJ1ytiKHRN/QrEYUAbKfKFVYidHFZFwtZuPFG6egkI/E2S/15KCfjkzwh1XAxZnowQeDShe5lbF/76P16RXbYVoHxpgC1R1Bsp9w4nA35TAJ5a7aaFs5Kx8MZ++x1WMRqlA/qn+sBHnWk1w025J0Hx2H+ecgFMfNxHufP3OsMEqpiLEhEAK99tNamR6epjB19jhONq0xdylZWfg75jivUmMxeljP2tDRSFq16y2ll7VgMfG64/Eotq2u9BWAf3o2k9k0xYqHnxs25HTQDyFZDOOdUkez9pcX5l0WQpi+QW3yz85r42Ayjg5unuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqtnNgNtPo7+mbSNAhy2XyxU7S/IgrJBeVmTYHabXf4=;
 b=iTjc+yVrln+UyHWMV7COoOgap9epbLYaIy5GecbA5kUN/xma0JvN/P4UH9Z4AYI+BWN08bvFDAZqdlwBpz+OkUOcfAaacT/RGW7g+DJ4dW8J1XvO/u1OgqAKKdsE55kv/cY6oSTejsIIgulUSQt6+mufB7B6doMSttcL2HsCBbf8GXKGI7Gjl1HJu31WqnmEBIoED9b0yN+gSpQtQa6G3b1OsvNlBaVl0jUg2HkXByNaUuXlUPgQuQhtQHXpgRaTcJjC0e+pAtXulM7LgJ1ADds+N1m+JsHG5Mt1c4ez4l7XLffco4njGbyp+U9yBSbqrkrtRLCYNJG5NdIaGY2w/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MN0PR11MB6010.namprd11.prod.outlook.com (2603:10b6:208:371::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 12:27:00 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Tue, 3 Sep 2024
 12:27:00 +0000
Message-ID: <235dcd89-54a6-43ca-bbb3-45dfd6db97e6@intel.com>
Date: Tue, 3 Sep 2024 14:25:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/9] kthread: allow vararg
 kthread_{create,run}_on_cpu()
To: Stanislav Fomichev <sdf@fomichev.me>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, John Fastabend
	<john.fastabend@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
 <20240830162508.1009458-3-aleksander.lobakin@intel.com>
 <ZtJODFOYkjgRTPCh@mini-arch>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ZtJODFOYkjgRTPCh@mini-arch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0014.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MN0PR11MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: 58133529-1dba-499b-b7b0-08dccc13b566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFZFVmpqcGNKSEhGYXZOZ3dpb3dZR1VyalJSWXdhWkI1ZXByUmpCTzNTbzRh?=
 =?utf-8?B?N3BrMmJJb3BYZU1Uczc4dlU3WTBFQkNtZ3lpNElCa1FFdVdya2FUa29XZUxU?=
 =?utf-8?B?RlBad09UZXo4L1ZvdmFTSWR0Q1ZkMU9xMys5MFpwOU4zZ1JZdlR0cjdRVjlJ?=
 =?utf-8?B?V3dhdEVPWnhpUk5Day9sYVk5QUZNZy9CSzExSVlFR1BGMFJjeldwdmtWbTV3?=
 =?utf-8?B?OUMzTHd6VkRqWFJleVlIT2svVlRrM3RGcCtFVWJWVDZlSHh4bENmaE5OSWc4?=
 =?utf-8?B?M2ZRL2R4YWNCb2Z4eTVtS3lpazFjR2tlVWhGZlFSd3ZKV3RldmVWY3IrTFUx?=
 =?utf-8?B?L1dXa0UzY0JLNTQyZjFtNVVMdG54K3pGcDVqZGpNL25aUHArNG5LaTUwYWtt?=
 =?utf-8?B?YllWUmhvOEZTVGp5SnJCVWhqQ1ByZkpXcUpkck0vLzFwbWFkWndzRjA3Ymtr?=
 =?utf-8?B?dGNIOHowVHEwTE5tcFREL3ZRRFZ0NWRvS1QrSVBLcmJWNnlQaU84OWFVM0x0?=
 =?utf-8?B?M0ptSUxWRzFYWUtSaVY0dm5DL29BaFdyMDdJYmdVM0ZTVkpIQ0pXd2FiUEFF?=
 =?utf-8?B?SVc0YUNDYlh0R0txbjlpakMvKzllMlpwenVRSnNXS01hRVZKNFhZSlF2VEJl?=
 =?utf-8?B?ZVQvbEVITXF2MUd4Z2w1WXdIZG5jTlpFc3pTWVplZXF6WlFqTDdFVmNlaTFL?=
 =?utf-8?B?YWc0YWtrR2xkaWFSRjUvN3ZQREY0V1lZcE9ndXJKY2s2UzdtRi92OS9KSHVE?=
 =?utf-8?B?YWZkUS8vMU1TOFcybFNxdDJ3b2JjUFkvbjJBWnp4Z1FFRks1Tm4ydGhKb0Jr?=
 =?utf-8?B?cjU5RnI3QTdPUUJvUE85WXRhUU1SNmprZVEybTc2ZVdzTEpyYjVuZHFpQkRN?=
 =?utf-8?B?eElrUlppZFE4SVZOK2VYeUhsNGxFZzNmalFjbGJ3UE1zTUZhWW41dTNjMVNG?=
 =?utf-8?B?SXdMWVVFT0lMZ1JzWW9xemtubURWRmhFNC8rTjVua3p1TDFDUGdMYTBqMlJL?=
 =?utf-8?B?c0hsdXgyNTlITVVsRndGZ2lacXE0VVdHbXN5ZmVLT2RRMWNvV1oweXpEbzJn?=
 =?utf-8?B?QWRPdDNmRzBGRzlVSTFqSUpHQ1FRd3NMM09DYjJsKzlFQXJqVjRaeUZER0xQ?=
 =?utf-8?B?V1ljLzRVck5mclZ3aU9RLzl6MVJGMmN3SndSSk92VVBFcjh4VVdnKzBHQVRN?=
 =?utf-8?B?dEpEcllLM2dPNXlqMjlTWEZVRVhaRGNZcHJpWGhCbjhCbEkzSlNFa2luTXdv?=
 =?utf-8?B?Q3grU3YrTXE1d1pSYldzSXBvQS9RTjlNY0VkbXFSK1ZKbEJjNE9OSnB0TE5F?=
 =?utf-8?B?ZlNXeE9BKzVJTGxuOG9FMW01NnJUaVNtN0FpMWlnV0ZtSWtTbDEyZVV2TWVz?=
 =?utf-8?B?eGpyU2NkOGNLWGwyZDZIL1J0SGViUUNYazkxWUhBN2cyVzVseTd2R1pzb09q?=
 =?utf-8?B?ejFvazZsV3JUNWM3VFlGaWVKNVlYQTdmWmZGOXVKRkFwT3NRcGtHcEIrdDJx?=
 =?utf-8?B?TE9HQktWRVgzSHk3eWIzbEUyVjI3cnU3NVM1SWtSUmtPZDg1WmhuUEFaMzVq?=
 =?utf-8?B?SnhrS3NRdWx4dDBWVHZUNDNjbklZNnBFeFRhazZQdTVnK3RoY1hhZmhoQmtU?=
 =?utf-8?B?M0psV1NGNEdlbkpuVi9pNHZva3BydTcyLy9pY1JOTTY5THo4a25PTnBXeVV0?=
 =?utf-8?B?eHp3K2dZdWlwWEFyVVhUTWhveXRXZExOdWJ3YkxTWE55Z1hIM21FREVjd2Qw?=
 =?utf-8?B?U0lkNml6SDFSSS9qSUZsbHRNOERtOEg2SlI0Nk1pSkt2MU03MXhFY3lBS3hJ?=
 =?utf-8?B?elBXZWtJdzczWjd5Tjl6Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGZjcHNpeTB5eHNGbWlSM1BtNkE2RU90ZFBFVHRVallpdUtyeHYwUVFaM095?=
 =?utf-8?B?OVF2ZzZla1ByWDdCc0FaUzRYMXdXM1pJVnM2OStHdW8xRm9rOVk1RTF0L2Zt?=
 =?utf-8?B?QVpPNWRiV2pIU2xTenR4UXdjcnUrd0lDK3RBNjAwUkFFaVNKNGpITGRQdkxl?=
 =?utf-8?B?S0Q3L0xZQlMxVWprMGgxTE5JaUNqQmNCWHRjdWF4dXJ2NkZURlVrZWdOUitF?=
 =?utf-8?B?RHhxKzNWa3Z0ZnZ3YysyYzY5OXNuc0lSeWNXWDVBbDFCREhEZ0J0TG01dWNI?=
 =?utf-8?B?NDFRT1BlOStoSk9NM2JXSzhkUWRmaW5oZzdCZ3dUd0J1eFlsM1pDOEh2alFU?=
 =?utf-8?B?WmYxb0ZqSVBFUUFUVTlsQ1hYc1FKSWRVL1A0RStPYkcvU2o3VXJLKzVrTGNB?=
 =?utf-8?B?endjYnc2OVhTVGJZdWhnWHFTT1R2cWtiaDIyd01iOW1UMGJqa2w3eFFxZS84?=
 =?utf-8?B?b3g5bDc5VjEwRXBYMTNWOFNlZ2pHSGhmcWhpbXhoRG5aVUhKWDI2S3B0aUF3?=
 =?utf-8?B?K1cxdTZoTjlrcVJtMjgxUkVaMVIrMUpHL0lyQ1JSeEJobUNiNjFlaUNUeEp5?=
 =?utf-8?B?OE1pc1IycW5zMVp0bWZDekdTL1pJY0lzR0VEVU1XM2xZZm04ZXluZmdQVDUr?=
 =?utf-8?B?YURwbjBQVFlaS3Zpb1h4ZlNUOVdVK3o0UVl4K1llNndJV29ENTcvV2tPRVFP?=
 =?utf-8?B?TDRwK1RzSGx0U2Y1amQ2bUZNRDAycTJUL1pTV3lpVUtsVy85cE5qVVhmenVx?=
 =?utf-8?B?dlNtOVRxNGNaa1pENGQ1NVhyY3ludG1VR2hFRlduVzhJL1dTSjBPaW5oUGx2?=
 =?utf-8?B?eFpoeVBqWUpFMmQwMEJYU0dqem9tVnZuSHNkRjc0eSsyM2svUFJLczRudG1i?=
 =?utf-8?B?RnlXeUlKaEpJcGp2QTlWMWFRKzhMYmhWR0tvUHRJVHdjclplYWppSlFScVgx?=
 =?utf-8?B?cE1GY1BMUE0rWUpMbDJhUjNtKyt1eHprek15MmpiNHA4Z0pheFBjTVFXYklh?=
 =?utf-8?B?dmUrV2FNa2VqZXlxQ3d4dzdLWDRBaU1TYWoxbkIwRTVNZVdYd2MrZng3TVdm?=
 =?utf-8?B?enZUUzMvanZhcWR1QVlZQUtlTFNuaEhHaXdjWU9yOHZMaGxUMVFibVhhUXc2?=
 =?utf-8?B?K0Yxbk5OSzNzaDRmRTBBZ0ZJK2I3bFAyTW5JZmFEaXlLMEsrbnhVRnpIMVNJ?=
 =?utf-8?B?bWFLZUZWcWI0L05WbDN0RFJ2QitYampYSndxSGVSS1JrZDBhcGlZQUtwQXJl?=
 =?utf-8?B?TmN1Z3ZEdzJuY1J0d09UWWRWVk9NOXRmNnVLTlBLQmc1RHV1MGtaNWxWVTd1?=
 =?utf-8?B?amRlS1ArS0dWWDJLaC9xQTJSRmtFbTl5NGoxckRGMVBPYzA1akIrZTlrQnkz?=
 =?utf-8?B?REsxc2xRZk9wN2phRGprbTUzTXNyZEFia1c3MHpOTFF4YWF2c2Y5SzJaaFY1?=
 =?utf-8?B?U1ZOc1VEN2h0eG9lMEpUaVA0MnlsdHFwTWR6Z3BnNGxkT1VCWFYvQVVuMk9n?=
 =?utf-8?B?V3I1Mkg1UnJ0Nys0NDgySmY5d0Q4dHlVK3dsUVE0N0RqUmFYdHRxeDI3ZEt5?=
 =?utf-8?B?ZkZ0SDZzbGhudVk5ZFdGV0d3YUE5REdPWVkxRWE4K2FEanBLL0Zidm5nbUxl?=
 =?utf-8?B?YUdZQ1RrSXpnUU1QVFg0NzAvNDRRTTQ3OVBBZnZZR1RUMW5kQXJZc3NteDBP?=
 =?utf-8?B?cHdDZDBwZzY0ZmlqbFFnY1V0cGowS3lFMUFMQStRTkE5OUh3RmpKZmpFa1RK?=
 =?utf-8?B?aU5lUFNQTHRCVERQWEM2OXlmOFB4bysrbGpuRkF6TFpmTUszWmxQYXlIc29D?=
 =?utf-8?B?NUJkL1BiMjE4cXREcWdKVFFBamI4NHZzWUpsYVQwRGs2dTFaeEEzdFVUT2pv?=
 =?utf-8?B?dVJMOU50RHJ6ZGZXbFZ6UVpCSFM3SDB2SkpLYkEyakRBVU90SUVadVBWVFN3?=
 =?utf-8?B?Nno0cXdyc1lFcDljUVMxYUVyZEZ3ZkVJTmduRHlEL1J5KytRbW16eERLZU5i?=
 =?utf-8?B?d24zZ21LMllXZHJiQkxZT1NCTHBkTUZPTTRLU2FMZEVsVHVkVGFybkthWlZB?=
 =?utf-8?B?SVRieDdINGZOekNJeDNLZGJYM1JMUTl5SFdOSExGUlJBSU5uUytXTk9kZ0RJ?=
 =?utf-8?B?T0hkQjNhaHlpbWJjYk1tZGdLUXlkd3hsWTJDcEpHTTlzQXZTMkVmanRxZ2d5?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58133529-1dba-499b-b7b0-08dccc13b566
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 12:27:00.0729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mC+QszshJ0oKTzl30fSewkUfA8hZoU8Pif5Pf/XDCyl8eZuA/zYRM8r0reGLl74A3XCCIrtpeua1z/NrfNGP7ur8Vh1dHvdlW/Z/C7XsN3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6010
X-OriginatorOrg: intel.com

From: Stanislav Fomichev <sdf@fomichev.me>
Date: Fri, 30 Aug 2024 15:56:12 -0700

> On 08/30, Alexander Lobakin wrote:
>> Currently, kthread_{create,run}_on_cpu() doesn't support varargs like
>> kthread_create{,_on_node}() do, which makes them less convenient to
>> use.
>> Convert them to take varargs as the last argument. The only difference
>> is that they always append the CPU ID at the end and require the format
>> string to have an excess '%u' at the end due to that. That's still true;
>> meanwhile, the compiler will correctly point out to that if missing.
>> One more nice side effect is that you can now use the underscored
>> __kthread_create_on_cpu() if you want to override that rule and not
>> have CPU ID at the end of the name.
>> The current callers are not anyhow affected.
>>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
>>  include/linux/kthread.h | 51 ++++++++++++++++++++++++++---------------
>>  kernel/kthread.c        | 22 ++++++++++--------
>>  2 files changed, 45 insertions(+), 28 deletions(-)
>>
>> diff --git a/include/linux/kthread.h b/include/linux/kthread.h
>> index b11f53c1ba2e..27a94e691948 100644
>> --- a/include/linux/kthread.h
>> +++ b/include/linux/kthread.h
>> @@ -27,11 +27,21 @@ struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
>>  #define kthread_create(threadfn, data, namefmt, arg...) \
>>  	kthread_create_on_node(threadfn, data, NUMA_NO_NODE, namefmt, ##arg)
>>  
>> -
>> -struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
>> -					  void *data,
>> -					  unsigned int cpu,
>> -					  const char *namefmt);
>> +__printf(4, 5)
>> +struct task_struct *__kthread_create_on_cpu(int (*threadfn)(void *data),
>> +					    void *data, unsigned int cpu,
>> +					    const char *namefmt, ...);
>> +
>> +#define kthread_create_on_cpu(threadfn, data, cpu, namefmt, ...)	   \
>> +	_kthread_create_on_cpu(threadfn, data, cpu, __UNIQUE_ID(cpu_),	   \
>> +			       namefmt, ##__VA_ARGS__)
>> +
>> +#define _kthread_create_on_cpu(threadfn, data, cpu, uc, namefmt, ...) ({   \
>> +	u32 uc = (cpu);							   \
>> +									   \
>> +	__kthread_create_on_cpu(threadfn, data, uc, namefmt,		   \
>> +				##__VA_ARGS__, uc);			   \
>> +})
>>  
>>  void get_kthread_comm(char *buf, size_t buf_size, struct task_struct *tsk);
>>  bool set_kthread_struct(struct task_struct *p);
>> @@ -62,25 +72,28 @@ bool kthread_is_per_cpu(struct task_struct *k);
>>   * @threadfn: the function to run until signal_pending(current).
>>   * @data: data ptr for @threadfn.
>>   * @cpu: The cpu on which the thread should be bound,
>> - * @namefmt: printf-style name for the thread. Format is restricted
>> - *	     to "name.*%u". Code fills in cpu number.
>> + * @namefmt: printf-style name for the thread. Must have an excess '%u'
>> + *	     at the end as kthread_create_on_cpu() fills in CPU number.
>>   *
>>   * Description: Convenient wrapper for kthread_create_on_cpu()
>>   * followed by wake_up_process().  Returns the kthread or
>>   * ERR_PTR(-ENOMEM).
>>   */
>> -static inline struct task_struct *
>> -kthread_run_on_cpu(int (*threadfn)(void *data), void *data,
>> -			unsigned int cpu, const char *namefmt)
>> -{
>> -	struct task_struct *p;
>> -
>> -	p = kthread_create_on_cpu(threadfn, data, cpu, namefmt);
>> -	if (!IS_ERR(p))
>> -		wake_up_process(p);
>> -
>> -	return p;
>> -}
>> +#define kthread_run_on_cpu(threadfn, data, cpu, namefmt, ...)		   \
>> +	_kthread_run_on_cpu(threadfn, data, cpu, __UNIQUE_ID(task_),	   \
>> +			    namefmt, ##__VA_ARGS__)
>> +
>> +#define _kthread_run_on_cpu(threadfn, data, cpu, ut, namefmt, ...)	   \
>> +({									   \
>> +	struct task_struct *ut;						   \
>> +									   \
>> +	ut = kthread_create_on_cpu(threadfn, data, cpu, namefmt,	   \
>> +				   ##__VA_ARGS__);			   \
>> +	if (!IS_ERR(ut))						   \
>> +		wake_up_process(ut);					   \
>> +									   \
>> +	ut;								   \
>> +})
> 
> Why do you need to use __UNIQUE_ID here? Presumably ({}) in _kthread_run_on_cpu

It will still be a -Wshadow warning if the caller has a variable with
the same name. I know it's enabled only on W=2, but anyway I feel like
we shouldn't introduce any new warnings when possible.

> should be enough to avoid the issue of non unique variable in the parent
> scope. (and similar kthread_run isn't using any __UNIQUE_IDs)
> 
> The rest of the patches look good.

Thanks,
Olek

