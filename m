Return-Path: <bpf+bounces-45648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F13E9D9E5B
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 21:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5AE2851AA
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 20:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA6F1DF260;
	Tue, 26 Nov 2024 20:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HhbyxqY1"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728E51DB350;
	Tue, 26 Nov 2024 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732652375; cv=fail; b=QlUSzwXL6rcplMuitWO9Y9N2gTVr1ExPXGVPc25jzAODunSC3o1By4ckHLlRvc/06WT+2r2+w3uEDNCOU0KjBZ0wcWlr11nrVItEOV1JpT7MMLFCO7n9M4YXGFBdvVkn80gEjQjfRjGByfwjODeYhaqd+dUB74GAC9NiZoaPD5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732652375; c=relaxed/simple;
	bh=db/PBq/e5YO7+uRl4gxqHTTCDy+dkJ8ao2BPnSnQ61c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c1DIWO+A9AleQP8WufAQIUVx4huJZY4cRMOIygD/6bSW/Op5IXY6tD2qOeML5SdOTROKRBBIzK9ztjBoSSJfO0ijDZhIm6uGw3HKHj4HzEXiEPlZBewtlw9M//ckNBYupp6qUtgw/62TC3uWhWL8Z2DAPEfmdjFDPWdvnf94JCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HhbyxqY1; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732652374; x=1764188374;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=db/PBq/e5YO7+uRl4gxqHTTCDy+dkJ8ao2BPnSnQ61c=;
  b=HhbyxqY1SYezgS8BJcIZ3GLjc0UY81Ihbszw1BmfrWkKZKKyS+xssBmk
   NufesFcM7xuNBY00vb8gPgMsCLAFx1y8WXcaLu1OC4TCBlupKonfgCstp
   jTfuO3gVKKKZWv0Jcas7LJnAg25lOG3xe0jCJgYhclyZHwGvFMCLr3+q6
   TbyyJx7bXgruy1kW+EOyKVPgVijZs0mPu2MDeEOpfeVWi9maLk+tSAwbA
   ASXA5S+8tCKQogP2afsFVhacQLKDxaBCLwVTfVCDZY1bpIgbaeRTgSYoP
   SDKDm9yHWCVjENd6pkJDQYVBI5qTm1dMMyKenivm7oSm0Ie4UcjaADXWs
   A==;
X-CSE-ConnectionGUID: xnvvlPCRTTO8FbR/cetFWQ==
X-CSE-MsgGUID: GPRYcriqSCSnVDG8X9+FDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="32783377"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="32783377"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 12:19:33 -0800
X-CSE-ConnectionGUID: qTHjrIT9S2iwERcv/fmDag==
X-CSE-MsgGUID: OsRKVpbwSamk8vz5NldLMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="91827552"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Nov 2024 12:19:33 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 26 Nov 2024 12:19:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 26 Nov 2024 12:19:32 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 26 Nov 2024 12:19:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+haK5Ljcr+wwLTXVvU7YCrONxdaBRDUznTFrlSvG53591qGGdwdR67v2xr1EDihlhxmc3kj0YZVQnW/I2evFwJqytzTfYeF/w+Dk8HYKJy+/SC1uMAwCpkYx9wspm2fMwLTxT7ACKuIS4J6ddK/UQujN1rT7WU5uePmLv70gudWulWnZF//Zjt34lIBz39HG7Ntn2UjBzLK2lmCFKK41/kvriuyCNbfXfGW9QX6BAnQXcn6webQhlmfC0Tz1yrwnmd7aQ/n7c2kCDAcGhw8210U8FdWa6KRU82rnCQKOTW7+ByU0vt0Xe12eMF1dXCt54FbB/LE+IOyqrzkApADSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7innH+3+b2RtWZ79Pagstf1miO3DiAbYJDVPfixRqM=;
 b=EaEf0VcRVeRhnoVjKyUAq29gTS5DUGk8fK7LZX7abz+AMHb35ff5boN8JoCnf1P7CobznFMdrpYlsPubqG8Bx1/eDDVaIzbfyrgmuwnxZfH+z9v01wXKmE32qUryPjsrlzU+7R9AqozH+mbFbL/6Voe8SjLTB+ciuQMoQ+RAIzjwgzivdvCAwdy8vVXhx7s3HJYSiybYqzICNkEdDfUgvfhg+6uB+jG9nvlIhQqSx9B8YK4HeVFHyyzeapXHKx1fJ7Nj2AcqpOqec14bTCRFL4T5B2+3SSuPUv8FYPqO1O6ykU4OJ4oBIIHbxa0fGosihLPhaL4pfksy2laFP8SSCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7446.namprd11.prod.outlook.com (2603:10b6:510:26d::5)
 by IA1PR11MB7727.namprd11.prod.outlook.com (2603:10b6:208:3f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Tue, 26 Nov
 2024 20:19:27 +0000
Received: from PH0PR11MB7446.namprd11.prod.outlook.com
 ([fe80::ee69:297e:231d:4d3a]) by PH0PR11MB7446.namprd11.prod.outlook.com
 ([fe80::ee69:297e:231d:4d3a%7]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 20:19:27 +0000
Date: Tue, 26 Nov 2024 14:14:25 -0600
From: "Olson, Matthew" <matthew.olson@intel.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
	<bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next] libbpf: Improve debug message when the base
 BTF cannot be found
Message-ID: <Z0YsIULqeCxeVVtF@bolson-desk>
References: <Zz-uG3hligqOqAMe@bolson-desk>
 <Zz_YBK3SWnZnze-n@bolson-desk>
 <CAEf4BzZtD2Dge4EV+ehKLk+-DVRNxTc4YfuJ+W5ytTVwgwFHjw@mail.gmail.com>
 <Z0Yj-CrmRQEildgb@bolson-desk>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0Yj-CrmRQEildgb@bolson-desk>
X-ClientProxiedBy: SN1PR12CA0110.namprd12.prod.outlook.com
 (2603:10b6:802:21::45) To PH0PR11MB7446.namprd11.prod.outlook.com
 (2603:10b6:510:26d::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7446:EE_|IA1PR11MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e5bd60-e8da-4bee-7874-08dd0e57a09a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDVOQkZJNE85OWVrSlYzNTZadkpYR1dIR3pNNnF6QnI4UmFndGV6L2hiRHhG?=
 =?utf-8?B?Y0NyYkpxOUJ1NVUreDBTTnVCTFdnZ1Mvb2VmdENIVkVNMzc5dWdPdUdPVVpX?=
 =?utf-8?B?YVNxbHpXK1AxL0lRVWxYeFZwM0hYTWxOZTQ5V1VSaEFvb1c2b2tUUk1vZzg0?=
 =?utf-8?B?c3VOakhWOGlHS25yeWl0MEtUODNFMEtGNmhlNmxzeEE4YXpCZzlrRWluSnRB?=
 =?utf-8?B?UGJlUHQrdTgxdjNuNkYyaEFQV0Y1b0FmNWMzTDUrbDhOSFdObGVRVHhKeXNh?=
 =?utf-8?B?SmxQOVdlNWc2azFibjVQS3BnYm5vOWh6OXJzMHNIajVPYStudlpMOCtDOFdq?=
 =?utf-8?B?VEZYMmprRXBkNDVnbE85TGpXRzdBTE8yUkZSZmdQUkM5S1hGdWdVdDMxemRJ?=
 =?utf-8?B?aHFRZUVYMHJENGVzRXZnanZlL29qTU84VUxubWEzWnBEWGhtMFlLcy9xeCta?=
 =?utf-8?B?YTVrWXYzMDR3WWVyb0k4c2JtdEx0TEYyeUNEeGx4Y1pFQno3OCtrQ2tKWXVU?=
 =?utf-8?B?U3lpamJudCsrR0gyMUlkZ2daNnJRTy9sOU1WaFJhWHY0ZmUzTHF6b25nekRD?=
 =?utf-8?B?LytyMW84ZERkOUJsSjhGZnpVZXYxMmJVbXhodUl2enlBS2pTSTFaaVVpK1Z0?=
 =?utf-8?B?cy90OUVPS1RYTVFEVDc0SnAyNkpLVExiamxwMVFqSmw3Uk5qWkpGUjNWN00v?=
 =?utf-8?B?RVJ6Q0wrU25jVjB0R1NubXI4WWkwUXBQamNWOGxNMWNsb1NLSUhxT0Y5YlBq?=
 =?utf-8?B?Z0JnczdvU1lLRElYRzZtVWZzekVTUXVuc3UvUlRqY0ZSalVJeGV0YXMxQlpy?=
 =?utf-8?B?YU55TmZndkhBZCt4Yk9oKzdDZHg4bThHUDd6L3hSU0RXM2tpellsTis2WUho?=
 =?utf-8?B?WXVabEdNUEVxV1JrR1UwSUpFY2VwdFU2YnFzcXZQaXFJMnFPZFcxQm9HUVBO?=
 =?utf-8?B?YW1DWTFpYTg0bTZBV2YyODVURC9ydlE1a0xkM2Q3WjIrNzB1VS9LZHRDeGFF?=
 =?utf-8?B?UTNPdGEvcTJPRkp0R1NPZVY0Q2FPQ1dBaGx0WElvZDh0QkdoWGRZa1hMdTk1?=
 =?utf-8?B?REhDRGZYcDJudEh6VHdBYnBEWDhlczhuVTY3S2hoaDFickxOZElLNCtSWUx2?=
 =?utf-8?B?QXF6WWZtQkdBR2l0R05acEVsM1YvbGhnMlJmeWRWbUU1SFBZRnFFY1B2MzJu?=
 =?utf-8?B?bzM3K0tjSmVWaGREdnpoWm9PVjZSeTZzcDRNUFBzb0tlaHJyaHpNRlhlaXVJ?=
 =?utf-8?B?NXU4Mm1IMWEzRDlZYzYrTmRHbmV2a3B4ZWNuYk8yZDR6eGFPT1RqejhHQkpM?=
 =?utf-8?B?YklDWHRxbUFINUhaa2JZbTAvWm9nYzAvY0xCOVArZzNheGJWT2FnMzhCSHgr?=
 =?utf-8?B?R01ZOUs2Q21tek8zaGV1SXNPUk1hOVlhVkVYZ2JoWiswanVFdkFjR1VleGZr?=
 =?utf-8?B?cngydGlhV0EyckxVaXZrdGNBZXdHVm9WVE5SZnhteE10N2JWTUNvWlFHZDBL?=
 =?utf-8?B?eFo2YmRLMHRhK1lVdlZMMllNcWRJaXNOcUNVV0Z3cVVtbW9IM01FTHJHajdN?=
 =?utf-8?B?dVlDVjREN0I0VDFIZ1JsUnduTkNvaitqTURLQmRSejhLMGwrelBZeC81V29M?=
 =?utf-8?B?RDJzMXp2cEh5Y3BvS1ZXZ3ZNdHZzbGZHVCtxVUR2R2JuMm5zZDNkbzlxb2tw?=
 =?utf-8?B?bkZ3RHg0aVY3VVdDTzh6bU1jRERldjE1bVBMR3FjUE9XemR1dlY2M1NFUldv?=
 =?utf-8?B?OFZobmxSdWJqdW11dFRMT09DemxUVFl4N29PZ241Nyt2dzZ2Q0RqSjdyRmVI?=
 =?utf-8?B?QmlNd2pqbWNjZnNlT2lzUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7446.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkxvRlpwb0Vrb3NNSGIzNXNMWWw4UUsrMGQyN2JUQ1RYVHAydEVwY21qajVE?=
 =?utf-8?B?Mi91WWhxNmMvWkJBMXpLUm5yU0M4YStONWxYQzFQKzIxS0RtdER1Rlp5c1pQ?=
 =?utf-8?B?cm5QNzlzL1hkUkxNcCtDZFZocGdBZUR2dkJSSzJRMWxtK056OHpQU0Z2OWdu?=
 =?utf-8?B?QWRab052dno5YUdMbVU5UzR5UWN0cTB2a2ZmdC9GMkpUTnpCOUFKVUk1RS9w?=
 =?utf-8?B?dVdhdU1zZkhhaytSOTNIZVJKRXFWbDNiYzVEUWdTQnlaRGlHN2FuNXI2NmFH?=
 =?utf-8?B?RG90YS9QNDJKVEUrSlJtcklWSlh4UmViMW1jTFRhQXZ3bm9IcTVnUVE4OW9K?=
 =?utf-8?B?Rm9DY3k2dmhvOGF1b1lITEd1SjB1TkRlZkp0bmdsUnUvYWk4dVc2WDZoNVF3?=
 =?utf-8?B?Q3VlbGVqRGtBR1NwSk9RL1RQa2dDaXJkTk5waEtxcVE5QVdKV3VDUWdNTW13?=
 =?utf-8?B?bzBjSHhaa2wwMDR5U25TS1VmZXVNQkRkYnpnRThydWdBS1pTZjlZSDdDRGhm?=
 =?utf-8?B?RjMyeForVjBHWU1LUWxvUHRpK2gyS3g1bjBUVmlZMzRwc3BwMXdwY1JBcmtT?=
 =?utf-8?B?YU5CVEJ0NThFSm5BN2dqcHEraGc3bFFVYU1GRkRmRWxmd3ZXZkZ3UXloRDA3?=
 =?utf-8?B?OWthN3JCMVJXRkZjTTJGcjUvT0RQT0hLbGpmOXpQZG43VithS09TeXV0dlJP?=
 =?utf-8?B?SUs5ZVNDd1FsU29oWk5Lb0N2MGVEc1o0bGl4dWsrekJPUHN2UEQzTGZLWExw?=
 =?utf-8?B?MG8vdWdOc1Btc1hySHJLbDloRUtiRDVxRUpiVjlmZDR5ekxValNudVpreWNj?=
 =?utf-8?B?c2J6SlJLMjhWUVB5ZXF4L1FEdmw5TVJGdWQ4d3BRTlBzbXpDUDdLa3QwN2x3?=
 =?utf-8?B?VnRvZmZHaDlmMyt2VDIvMTNIMHArTnVRb204NUxaM05mM3duRlpPeXI5TTlI?=
 =?utf-8?B?bCtYcGE2aVA2VlU1K05zejlPQzFuOS9zdE5Td3JSK1hacVZYUEtVSEIyd2Nr?=
 =?utf-8?B?UTJlSUF0em5XZWdCVzlEOFljaGtlaVkzYWlvdEljWFNDcTd4MkIyTTM4WnNr?=
 =?utf-8?B?K3dXSHlockpJRkxyR3pTV0Q5eFRXK0dpaGYyVTVrZjh0VmE1bkRWK0VuL0wx?=
 =?utf-8?B?YVVTdkIxbFNDRFVuQ2NuODBwczZDRTl4QkhzNDVXTTcyOFZCMGN6YytJMFhK?=
 =?utf-8?B?elFEbFB1d2w3cWxtcTg1SnYzZkFKbnN1T0MxdnZkMEM2NVZtaDM3UnQ0Ynkv?=
 =?utf-8?B?alJndWR6RXh3dkwrU0FQQXRydEdLK05GbFlDcjN5M3pEeGc5QWFrdTkxMldx?=
 =?utf-8?B?Wit5emZxY3FFaXZaSHdsUk0rQ3NTaWE2cTVoQWNvYWQxSFhGTmNUZGM5T0or?=
 =?utf-8?B?Q3BLbFdWUFYyNlhVcUlLL0FWZnlwRnpvL0tkemo4T1dCc2NQdTZQbnpSbzh6?=
 =?utf-8?B?NUJFKzlWMjhoMHRySU95dTlUYWJLazJGNmNHNW13blJwbnpkVWpscUNiaWNZ?=
 =?utf-8?B?Ti96a1IrQlpxaVZMbXlnWE1BY1lIcHNKS2VkVzYzT1drNEEzVjQ2VVFnYUpi?=
 =?utf-8?B?TUZQcmJucE9CTWZxQ2t0OTB4SmRyUGRVQnplRm40TmhTTkRvOUFYcURwMjh3?=
 =?utf-8?B?RWdSdkoya2w2T0sxeS9DVHk1YnFMNzZ6aGxtZ0pqUnBZd21zRmk0eW1QZE5F?=
 =?utf-8?B?eHVkUmVQd2NLc1JRWFczOW5vMm9XMklaVlN0aXFTL215Snd3ZnNNOVE2TEQr?=
 =?utf-8?B?ZWpiZ1M3Wk1KNm1TT051bXdtSDhaRElmc28rYXJhY1ZBTTUvdmhORHpRS2d5?=
 =?utf-8?B?WkJQeFZWa3JmQ2Y4VkpQU3BwZjdrT09kcFhXVmJwZFF5MXM0dHEycU9YbGNa?=
 =?utf-8?B?czBVc0Y3Z1JYYy9HdXQvQ0JmampVZjlmTC83M3FZSXNRMklySjBVZWdNaHpt?=
 =?utf-8?B?NXJJc3hFS1h2aGE5Z0hWendtRzBCSGJLOVduWTBlU29PcjJSQlV2aXRGR1Na?=
 =?utf-8?B?RHhoWTIwSXUrYmJ6TnpJRWJkeldPQUZmRlJMM25qaFZQZ2M2bm1lRy81c1Z4?=
 =?utf-8?B?bTF5T1dqd1pUcDJrOEwrd3MvWWFZaGh3aVYvT1RNcHNTSzM4T2NoMlRDRzhE?=
 =?utf-8?B?Y29LV0szM2ZFenM0NzZOSVA2SUVKNkNMM21DVjNCOUFDR1lMSXduUGRBZVBh?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e5bd60-e8da-4bee-7874-08dd0e57a09a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7446.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 20:19:27.6999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZhzlxVUvpY68gVplTLA1ERcf8ZaKSAUXOzqFDzejMhIdjp+R8UilB/14+Akvk5xGqEEGHgnfy6gEXuBEK+VFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7727
X-OriginatorOrg: intel.com

On Tue, Nov 26, 2024 at 01:39:36PM -0600, Olson, Matthew wrote:
> On Tue, Nov 26, 2024 at 11:21:21AM -0800, Andrii Nakryiko wrote:
> > On Thu, Nov 21, 2024 at 5:07 PM Olson, Matthew <matthew.olson@intel.com> wrote:
> > >
> > > From 22ed11ee2153fc921987eac7de24f564da9f9230 Mon Sep 17 00:00:00 2001
> > > From: Ben Olson <matthew.olson@intel.com>
> > > Date: Thu, 21 Nov 2024 11:26:35 -0600
> > > Subject: [PATCH v2 bpf-next] libbpf: Improve debug message when the base BTF
> > >  cannot be found
> > >
> > > When running `bpftool` on a kernel module installed in `/lib/modules...`,
> > > this error is encountered if the user does not specify `--base-btf` to
> > > point to a valid base BTF (e.g. usually in `/sys/kernel/btf/vmlinux`).
> > > However, looking at the debug output to determine the cause of the error
> > > simply says `Invalid BTF string section`, which does not point to the
> > > actual source of the error. This just improves that debug message to tell
> > > users what happened.
> > >
> > > Signed-off-by: Ben Olson <matthew.olson@intel.com>
> > > ---
> > >
> > > Changed in v2:
> > >   * Made error message better reflect the condition
> > >
> > >  tools/lib/bpf/btf.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > index 12468ae0d573..a4ae2df68b91 100644
> > > --- a/tools/lib/bpf/btf.c
> > > +++ b/tools/lib/bpf/btf.c
> > > @@ -283,7 +283,7 @@ static int btf_parse_str_sec(struct btf *btf)
> > >      return -EINVAL;
> > >    }
> > >    if (!btf->base_btf && start[0]) {
> > > -    pr_debug("Invalid BTF string section\n");
> > > +    pr_debug("Malformed BTF string section, did you forget to provide base BTF?\n");
> > 
> > I'm not sure why, but this v2 didn't make it into patchworks, so I
> > can't apply it. Can you please resend?
> 
> Sure thing. Thanks.

Ah, I think I figured out why it didn't make it into patchworks; I'll resend
yet again.

> 
> > 
> > Also please make sure you don't change indentation (tabs -> spaces),
> > because it looks like that's what happened here.
> 
> Ach, rookie mistake. I'll add clang-format to my git hooks.
> 
> > 
> > >      return -EINVAL;
> > >    }
> > >    return 0;
> > > --
> > > 2.47.0
> 

