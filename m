Return-Path: <bpf+bounces-43403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76BB9B51EB
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 19:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8796B284683
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 18:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8CC201003;
	Tue, 29 Oct 2024 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdzwHMh7"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D042107;
	Tue, 29 Oct 2024 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227067; cv=fail; b=QXJDOx82c4yAFoOX10iaZROXLhgrjSJzhDUybIimYt94MYPTP5sh/0eKwyMatp3m7Fof+DSZtF1SrXnu7xkmpKDzZvqqr1jBEsTO/BYqvjrbBkFblcnozAYCmf/FiCOf+7Y7sXwXjFskPL8RYZS2/kj2gDGJXrKu138c0POjuGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227067; c=relaxed/simple;
	bh=8u4tP+qZEl4801SgU+Zjno4TeDIrwBYXj+kuSNNKhe4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M9ACN1CNxBavm1Ps0BqbL2DDin8oeLJXYqvMKbzhtdHxfIYIk6bPbDlJNCb/Gr9wqCmDxghHjcWH97AxxWdjcqWb+X62U4INsV7Qj/3QXvUu84y4xDGk9wd9Pv/oQvgXzxq6xn58CZOg3c9BxNq06q1pND6azA6kTlKqARHCZkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fdzwHMh7; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730227066; x=1761763066;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8u4tP+qZEl4801SgU+Zjno4TeDIrwBYXj+kuSNNKhe4=;
  b=fdzwHMh7eNHd/5TKCsDEOMPyHv/w92eWZClCBskGPgsqzx1b91ma6zxB
   J6SHmA5eg1PSywwZlIDX2aasyac6b/H1OEK1uid7s0jtV0e25vJyY/8lv
   XHCNTFqcMnmTQwzrszcelA7p2n6ql1bw4Skni+S85wWbn0Kh7U2rv3/k+
   eBl+zJBrPo1+fo21GgeEgresi3yDyeRBi44mDQtVxb8Wk3jEAcSStYB1A
   XQGR26L5KVV+eTK7y4t1n0T1zqi7UZNViO7xDfXozePSLHDflGPfrz3U+
   4kJzVCdNMtoODUVgGjkko4Cll+qoxOHeVjfeYdPUo36nG/Ct5t0WGYgvD
   w==;
X-CSE-ConnectionGUID: 2VOZrLjrTOKJmCp8VrODUQ==
X-CSE-MsgGUID: D9AXVCJ2Q9eslkhWkzFcTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40425945"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40425945"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 11:37:46 -0700
X-CSE-ConnectionGUID: oYai8P4oSMqvJy4Vo+Xq8A==
X-CSE-MsgGUID: qwgVXsBOSxK8CRhc2t0iKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82128085"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 11:37:45 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 11:37:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 11:37:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 11:37:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATydgmeBb49K0xg2uBXbO+MV9s8Bjef0cMXIxUsyqBanSaONFNWcfN4LQaFOqX9brBGEN63+YUVBg0+wMq2Hp6g5CSmPKL88UW16Mrec6YMdLPhjTrtqz22WcLxp2KuY34eKKtih33nxFlxClXC4v2S9H5KVrAODFt4rVVRIZMhL8jbFPej3Kx02HoEzLrB/G9n8+z/53iAu31jLYX3IgTHvuxUlRsmVL3dPUrXPkff7GMcIMRJ7BFRDmpe65Tk/X2jB4AIP+85GHOJAu9B1rJJj040x8gjCSCxCgJH7eI6hJ9CQXZu0TnnzZ7exPRjzlNUe36vkhxIx+LBw/PPXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HL3m8msItEF+cvvsUx7GOQPr1ut6oU7T4QMLkKn9o3U=;
 b=hBNFLiQG8Dhg6VAVcxjDcLO/E/T+kJcb54X8yf144iLljVgux3sUDIdFvxJXUJOaEs6GUeby8rd6a9EtZ2jh3pY0ZpTeX7hMAok112/u8tiILBY5gFQRMCZ+7Sv0e8178KJiNg5zvsNjAIFLHp4iWkv6b0R7crSWeCl369/URBu0fVYOndKg6mKr0cJZsuPL5Fe2QTDA6bnob9zuyXUKnXWPcnVbeYXLIpgNDqd/nQ6nuPwX9IfLgO3ACxiQc1BeDS6JvYQ3DW9Ej6DN7gOD1+oUB5pV764Jvq6ZJj1toOUBLLFskKBITYPm7sFrq7+HqtPeuhy85PBvOEKINER8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH0PR11MB4776.namprd11.prod.outlook.com (2603:10b6:510:30::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 18:37:41 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%7]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 18:37:41 +0000
Message-ID: <bbcc4dcc-b599-4e47-aef7-a1f462fcd377@intel.com>
Date: Tue, 29 Oct 2024 11:37:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 0/4] Fix passing 0 to ERR_PTR in intel ether
 drivers
To: Jakub Kicinski <kuba@kernel.org>
CC: Yue Haibing <yuehaibing@huawei.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <maciej.fijalkowski@intel.com>,
	<vedang.patel@intel.com>, <jithu.joseph@intel.com>, <andre.guedes@intel.com>,
	<horms@kernel.org>, <jacob.e.keller@intel.com>, <sven.auhagen@voleatech.de>,
	<alexander.h.duyck@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20241026041249.1267664-1-yuehaibing@huawei.com>
 <20241029074404.282e52b5@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20241029074404.282e52b5@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::12) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH0PR11MB4776:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae1863e-95c6-49e8-9fae-08dcf848c56a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTJXWEpYZ2pDQkdDOSsvKzJyUWM0S09za0tUUWJQdUIvUUZKV2l2NnhZek5D?=
 =?utf-8?B?aUdtU29MV2ppbEFrZGEyMEdONnVDWktlVEN6cXlSQ0I2Q0dGUG9hYnlXUFpq?=
 =?utf-8?B?cmJ4MnpIMlR2V0RYY3Z6NVEya0wwcGUrbjhtZGczVlR1dXkwTHZkOERjUFA2?=
 =?utf-8?B?aWtJbzVYYzhONjZlcWlWZUlwR3NWT2U2ckRrZHZ2S2o5ZGdKYTF6Vm9uSkJC?=
 =?utf-8?B?emN5QVplQVZNa2QyWThRRjJwMG1yUzBvTUkyb2ZKUGFCMGVJendQMEpQaVZG?=
 =?utf-8?B?R3IwZll3bkd0SFZiUzNaQkYwazFtQlVJTXN1MEhKWEJqbHMwYlBXeHQrVFFQ?=
 =?utf-8?B?WUJ4UVJvZnJUOVVob0IvTE5vekVQQ1ZpVThzQ01nRUdDc3VHT2JuSnl3L0Vu?=
 =?utf-8?B?WlRaR3Q4S0hZZ01rNU1FNGpMeFBMd1BHK3dnNElNK1ovMllmUjJwVE5rMUMz?=
 =?utf-8?B?VDAvaCt6S0taQW5zN1h0c3VlQXVrNXRwenlteUFCWG5jNXhYMWxqK055WnFN?=
 =?utf-8?B?RE51RFFGK3NqSG01VzgzczdsQ3RHOVNzc0Y5OU5YcnlTMUQ0RXAzU3pNRHBs?=
 =?utf-8?B?R0xWYUtHVTZ3OU5jZmV2T0FoN0pJTEdJd3c2d0Y0ZjR2SjNmV3FnVUgxdkdw?=
 =?utf-8?B?K28xNHllMGtnTlkxZmxxOGU0SmwwZy9HeVJ1ZVdvblEvWTd6TXA0TTRZdVNY?=
 =?utf-8?B?OHNsQWt2QlpPTng2R1ByVnd6Ylc4Zm5RcHA4K3o0Qm9uYUFQcmxGWDE0ZHUz?=
 =?utf-8?B?aWhyTTJaT2tMcXZZT255RW94MUJudTUyMkRSL3o2NlU1UTVTQ29Fd0l6Mmts?=
 =?utf-8?B?VXdURFhWbVdlVmMzb1ozR2Jjbk5IVDBkREFxVlFZbm11RVdYcnhxT3NqN0U1?=
 =?utf-8?B?N0Z3N1lnTiswRjdLcFM3b0lkb1V5dUpmemJjbDhlbk9EWC9YR1BjTUtOR2hk?=
 =?utf-8?B?TEZ5SzlMbkVpa3E4ZytnM2ZrMDZGSEIwVEVlK0VoZHVTYmp0RzhtREhWMWxr?=
 =?utf-8?B?aDBuUUhQaU5wbjZ5TjN2ZXR3R2NySFhKYzlESDI0bTFBeDUzc3EyWlU2cHhM?=
 =?utf-8?B?V3hadFkwQWFpeGdXQU5NVlBqMG1SQkErOHQ4TVZ3ZnloalZOS3hOclRFNU54?=
 =?utf-8?B?VHowbklMQ3UyLzkxV0d2dDBrNkVLczg1a2FsVzArekxSbVRFWHpIUzl4ZjNo?=
 =?utf-8?B?SlFqblFCWDBFYUV6Ris4RXMySmZnMCs1MnJrRTIrenJ4UUd3bE5DWkNHdnpu?=
 =?utf-8?B?ZlRKUXIyRHQwK01LM3FhTmxZNk1RNXJxVWJpdFpEVkNTRTRrM1B1Nm04RU12?=
 =?utf-8?B?SVhOMFlEcHhIZVI2ZmxieXc5Q2FnOWlGek1jQXZWMG9SRjFxamtxcDdUVURi?=
 =?utf-8?B?MDZjRE9OWCtjeGRMSk5CU0pQdFFONllwc1JiWndDNlRENER0cmlWRlFoVFU2?=
 =?utf-8?B?NFUwTHFjWG9DUVFqLzA2eWkzUUZ3eHUySktXZjhLekx5eFZWM2cyUzRMM1Fn?=
 =?utf-8?B?bXBWSlRGaElFQ0xlbjByZzg5WGI4eUtmQ24xelpQYnlOaU1ZY05kMXhlbStw?=
 =?utf-8?B?bTBQcTdCanBuaEdEd2x0TnN3cy9PcmFwSDcxZzhHYnZzSnpnb3g0UVJHVFE4?=
 =?utf-8?B?V3RhUmhJL2tDaXRFeEw1aktGRTZFaEZla1F6c0pQdU1HUjRLaHJKa3c5OXdB?=
 =?utf-8?B?SjF0VE94K3BZNEV4OGQyeGRJWGJaYUZqRmNWNkZPTHJKOWx1czlMRDdRYVdl?=
 =?utf-8?Q?Jwl4HEDzG55ATYkiu8gQrChco8denMxnR67Or21?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnQxTEFqUnV1cUpTckx4Yi82bFlWbEYzYVB5YnVYTE1vblhJN2RhbWIwaVhG?=
 =?utf-8?B?cFp5R0FwUXRlcms4YnhzV0tYeEF1S1E1UUlHTXlyWXA5MExnbTgyN0ZMQVVz?=
 =?utf-8?B?NjRkV3FDRzR5SmtUdGsyUzMwZGJrQWVSQ21DMUtkK0FlQUNFekZDMmh1d2NV?=
 =?utf-8?B?bThkVzI1SHNvNTF3RmtHSTVSQmV1T05MUzU0TUNubG5XdzZiek5yK2lHc1Vn?=
 =?utf-8?B?YkJVMm8zTFUwcUlXZXYrVWpKa2ZLSkhSNG82Nmo2R3lnZkNVUVphTjZEWUlt?=
 =?utf-8?B?WTJmS1RLQXRhTU9FT2t1ZTlwU1E4ZlNtNGowaFBmU0N0MjFCaXZnbWhqUzcx?=
 =?utf-8?B?VmoreFlRWlNpaTFYNzFVc1NqY1p1VDdXNiswTVRWZmtVMUNqUHpxOHM4eTRi?=
 =?utf-8?B?aVRwSkpzMVY1ZkVpV2F5azB1QytPYmZBMlhROU5MRG9vOVpsUVkvUzRWTVNq?=
 =?utf-8?B?Y0FKZWtOc2d5VDRQMitaWUlTOWZacHVQMnVqb0s0YkQ0UkI1d2NXaDlqbDdN?=
 =?utf-8?B?bjN1WmhXenJOWExPUm9FRUZtVXdkLzdnUEp0Z1Y2THFZbVc5NlA1UExiWk1k?=
 =?utf-8?B?VnNneFUySEVvQUhYNjFCZ00xcGwwRytneTFtM0tYbWtvdWdoODA0SFRvWmRj?=
 =?utf-8?B?cmlDY1h5NHBGUTZrbjdIcktSMUtoSExmcGViU01SQjFTcmhmVzRCYjZkQnQ3?=
 =?utf-8?B?R2ZpbHN1TmF3akE2MWNPSWNWN1JsWDBKSmg4VFBUQXk0R0FuNXJyd2UzeEVT?=
 =?utf-8?B?dER2d2c0RzEzeVI4Rm1RNVgzTXR6Q3V5SzFqM00vTTBaQjdwR0RqSEp1Z1h3?=
 =?utf-8?B?RktzbUFBYU5RaU5xaVVFSnhLbisxWmwwK2w2ajMyc09LVnRsbWVZSk9DeStH?=
 =?utf-8?B?RlV1d21XOGtJRUduYkNvYUNDWGgrc0l0OHJwRDZiVFE5bmNobTFCTmpXVklD?=
 =?utf-8?B?ZGtGWXdXVDg1eDNRZ0twUklqT1JWSE5uV1RrU3V0a3c3WjJtVFMwVzZiTTVE?=
 =?utf-8?B?VzRPZnVGODdHTFRMdk84TW9ncW1EQVJFaWRPdHZpcmJIQVp4V0U2QjhxVFRu?=
 =?utf-8?B?NkpFOERma2hDb2lsOExkbU1zdzFpald2NWo3QzdmRTZvams3T1FXcEpiYmxP?=
 =?utf-8?B?ak9FVDZvWGtSM3hubzRjYmhYTUNKN1NzdDlqc1c3TWkwbjhabnQrcUFrY05m?=
 =?utf-8?B?ZDRsbUF6TkIvalo2enh4bUt4OTBadnRuQ2pBRnlaYlpQdnJ4TFc4dFliaFN6?=
 =?utf-8?B?UmRzUzVHbzRmZmRDTms3MVFZSndocE5ueks0Snc2c1VtODFvTDcwMkpLVDk1?=
 =?utf-8?B?QmR5L3lnVDdPZFMzQ1hmdytURHZkR0txZDFQc20rS3Y0aEpCRTBNcmc3cldq?=
 =?utf-8?B?MlZlV3lrblVnK2xhS2JmYlVYaVZxZytJcFFhdXNhRVg4dTZzdzdmN2FDTUlZ?=
 =?utf-8?B?bHpNUnB6U0U4N1U0emVDVjR6QTNLejByQUM3WlY5cVhmRHA0Z2VCUlQxZGpx?=
 =?utf-8?B?MnZVbW5KN1ZzVndNNVpvamVPaDJZQnNzeFJ1M2M2UHIyS2pNbUNhTUhiZ2wz?=
 =?utf-8?B?Z2c4RmJGM2pHNEVrUjJuRXR3R0hXb29aV0lIQ1RkU29FNEQwZnRjczBFTmI4?=
 =?utf-8?B?akJTZndOSHpWZkJWTDJlNjZDbEIwcVVPbzBmbE1xbFkwZHk1bkJ0OEl0aWkr?=
 =?utf-8?B?bHJScThaSzVJT0RMUDZ3eXVkYjU0RU90aXJsZ1NUa1cyZ01pWm9yRm9EbjZ0?=
 =?utf-8?B?LzkxNTFYZXczZmhoQlpjeVNlQ0NxZFQ3bDAvcC80eExvakZXZ1FOVmdQMldY?=
 =?utf-8?B?WkFMQldxNTBNRDhGUzFlZXpnTmVEZDIzcUhDVTcyUVE2aTdYTWFzdEw4Sjl4?=
 =?utf-8?B?NnhURHdsdTdPdmNGcmN2T2FFTytRWnY1VHVRMFZRL1cvdjZqSGhyV3FCeTZS?=
 =?utf-8?B?eE9vdHVMZVM4L2J4YmdPdEVGNUtRUHZxVEZJcm5oNWN3dlJFUzlNTFh5TUpR?=
 =?utf-8?B?WDRFREZKb2xHbldDUUhsU0xXQjRzZHpWVnpVd2V1dFBWTWVQUGtXWklLbTBt?=
 =?utf-8?B?YkN0bzY1MTg3WlFVcnIySzhENVFTN3BIeE9vM0dBUnZiZjBnVzF0WjYxVVFN?=
 =?utf-8?B?QWNCQ3g1Z0EzMDBHL1E5TnZDUTdSTlBLOHoyS1o3Y20rKzRDeGxMR3VjWFZ6?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae1863e-95c6-49e8-9fae-08dcf848c56a
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 18:37:41.6147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VubWwc5K0m3RkiVjgsOj/gIBgtS8LOPL69uxWGJd9eEziPzrxTJZfu9mTrp5WrXJ7fhnR6vmJbxqpG8LRuifkFYagXTIxSccjjHXQ8te81U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4776
X-OriginatorOrg: intel.com



On 10/29/2024 7:44 AM, Jakub Kicinski wrote:
> On Sat, 26 Oct 2024 12:12:45 +0800 Yue Haibing wrote:
>> v4: Target to net-next
> 
> Nonetheless I'm going to assume Jake / Tony will take these.
> LMK if we should apply directly.

Yes, I'll take these through IWL.

Thanks,
Tony

