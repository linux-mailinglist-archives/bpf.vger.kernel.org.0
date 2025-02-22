Return-Path: <bpf+bounces-52229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C6BA404D9
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 02:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB08470680F
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 01:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F47204C08;
	Sat, 22 Feb 2025 01:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9/6fRc2"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487752046B2;
	Sat, 22 Feb 2025 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740188485; cv=fail; b=shyRufJOxMlv5WJI9Eq3Z5iclcJ7gvnueT930igFhtxl6QrFcLwrwZFM3qvRZ7vx6JvbkSqe4eUwKItJ9bwaawvo7dIm9uSxlsuIMGljTK/slfsenkIm+nbAvutXZlZhEEPHMKDDStyZEIFrEp16LB7D/Q5whmAcNLapQhZKLN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740188485; c=relaxed/simple;
	bh=XTsoCc0Y6h1CFdPaSMPKzTp0maKcxi7choWN5+BCH7E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fy0TSZR7RuE4GXHSYLmP+RDjqHBq0KlCJa6lSr5FrOLnZGU+gX9C4ni7b+48DIo7Z/PxVBfKmDK1++hYRU8RnJskX1Y2yh5OYZ1mI5k6Uj7KlnKb/dfqpzAYzyZWI9yx0ThpEVcgOUi60rt3IYdCLfeFzQ2kJZikEtnVlvpNjL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9/6fRc2; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740188483; x=1771724483;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=XTsoCc0Y6h1CFdPaSMPKzTp0maKcxi7choWN5+BCH7E=;
  b=K9/6fRc2ipj54X4Y/fXPHPUw1GuRwvzKoFy5O4eaz5BK7znvP8+Jvz+r
   nOQkXb6/2uB1YPQSaLHmE2eyRMSL6sN7FwLtRv4KqQEzs5oHMjOecDMyZ
   ZxflxqKRUN66lMDpkwELVzsEULfqzmAjrrGCm4Npb1GtlfP16JIFFPT8d
   JKu+0mljH7khSlMsc/sLGfZu1w9+50cmLTaQe/OPtJvWGmUqM14XZNY3t
   IX9n6tX558GpV0JIJ7azqYAX/hhZT+AAixgS97caFYwsG+RYerG2ice+W
   lTtebkMOZtR4EHUna1oVBVnhHg42zFVgD+cG29O1nfeY5T4oBjrjCNmk/
   g==;
X-CSE-ConnectionGUID: mVY2Abi7S7mtfSbb4ega3w==
X-CSE-MsgGUID: 34vW6WouQXWK7k6BElVJcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="40732416"
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="40732416"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 17:41:22 -0800
X-CSE-ConnectionGUID: rNlesCr1Q/W2CZmWWxyjbA==
X-CSE-MsgGUID: 2H1MUwlZRU+/79+uBTEkvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="120501951"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2025 17:41:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 21 Feb 2025 17:41:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 17:41:21 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 17:41:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqkXz2yJeTE6tsLREEXokCkpuTgapDljYJz69irKpmqyR4uvwHtQZ9Kj0vg9AmwhR7uX7WykKpn3kbdctkfB/CWlG2RiDZPM9v+yZ65nClKOmZKwFm/RmhgVIFKB83TylLo9i85JN2Vgp1wGPsmwNPAnysuqPldGqO8/QpRz7hTjtDop4f2twnUXuEAi4F9gAZ8YGMdRpOwSLa0qTbdChVt75DuPs8A2rPqgdUuQXNYoJGRKhZMjB9Mu+uLG9EpJJ5+hUzi8Q1nqAd/Fa5NlvywZ5MOEnFzZPAodKzdwBs0wcF/G9of6YXgzFc01lnkiLmCTuvYogK9uDlrFIWGY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQI4RL8yDaX1OxRIlE+SopoGsOhkbhJmb6PiRdG4L+I=;
 b=pKAq7kIjMN6D7LFqKFVYpReTiJIrPbjE63EsJmP8xEQe4L1qqpy1MbSDtK+SeuRJU78Dm9OOQgbvc9pnkvIL6pGxZM3cyeZUYdqU5TBQYnaiabgimdqon8Z1K67mP9LOmw+Z6XJ1r8xu59loC5+2+ifEQcbvVY3l0DFdmk+rqQLIDjm+8Gkb9eGDFKTJBNBFS10EMtomEWczEd/biWqWKbdhb+NOmqo/JY12SyPjLGPaCoh8I+kmf3QKP4tXm3Iq3eVw2sUvfQGcCCREIp+50p7ng8ZwxZKQ1e4r14OcNJbY3FI/L4leXyp1a6atxo+nPh6eLhztz8kBMLblN7g1/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by LV8PR11MB8583.namprd11.prod.outlook.com (2603:10b6:408:1ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Sat, 22 Feb
 2025 01:40:38 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%6]) with mapi id 15.20.8466.016; Sat, 22 Feb 2025
 01:40:38 +0000
Date: Sat, 22 Feb 2025 09:40:24 +0800
From: Philip Li <philip.li@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: kernel test robot <lkp@intel.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<dsahern@kernel.org>, <kuniyu@amazon.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>,
	<haoluo@google.com>, <jolsa@kernel.org>, <shuah@kernel.org>, <ykolal@fb.com>,
	<oe-kbuild-all@lists.linux.dev>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: support TCP_RTO_MAX_MS for
 bpf_setsockopt
Message-ID: <Z7krCJw4W03Ron/2@rli9-mobl>
References: <20250219081333.56378-2-kerneljasonxing@gmail.com>
 <202502201843.xA1qZbKX-lkp@intel.com>
 <CAL+tcoC9nboQ9UNeP1-g4nQKqXg+fLDu68RHjwKRx97f_iuCZQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoC9nboQ9UNeP1-g4nQKqXg+fLDu68RHjwKRx97f_iuCZQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|LV8PR11MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 796a8e5a-74b5-4054-cc43-08dd52e1e870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEVxZzczV2pUZXpEblJtUHNsUkloVDJPL2RuSFlGRUM4VERTT2NPbFB6Q2o5?=
 =?utf-8?B?WkJweThXUjY4UnQ5cVVsUXptZnFJeW95cUVaSnFhcUUxcHFlUjdWa09SU0JU?=
 =?utf-8?B?ckVUeWRGeXJsKzBNUUNlNHpwTkI5NDhYYzJVdGNXa2dZcmkyNjh6NlgxMjR3?=
 =?utf-8?B?SmFyUkdsRm9QKy8zbGltanc0SjVHcktBVUQxSFg1Um9tSWcremJlZnJVMHkr?=
 =?utf-8?B?c3R6VjVhcVBydXZIT2t3ZDFrbVZvYXgyM0pNdm9UemJBeDhhc2hiWXVBSTcw?=
 =?utf-8?B?OFJicnRQeENrUTBERDhGMDF3eUM3dmtRZjdZbVZCRFhKY3NMWG1NYlFpcnFh?=
 =?utf-8?B?c3RTb0FvZ1EzaFBDdVZEa0RUYkd4aUNraVBZemw5SlJja0M2bWIrSFJIb0g2?=
 =?utf-8?B?bkkrVE81dkhMRmkyRDhMV1gzQTNVOUp3WVpoVnN6dGZZc3g3ajg0SkxjR2Z6?=
 =?utf-8?B?bnZsSFlPTjJFTlZzaVlDMmlydFZRbGYybWRVRnRpSk41S3Bxa25GM1hhY3po?=
 =?utf-8?B?VVVzRm9NN1FqZTZxU3NoVmxXWnBySC94UXJCSGF0WTgwMnF2Y1dYdkxzSHZ1?=
 =?utf-8?B?RFR2NWtOZDlPQ0tHTlBac2RWNSthRXlOZTZpd2phOEh5bDJaelkyeHp3TkM4?=
 =?utf-8?B?VzE2NWdqdVdSZHphTVZZVEwrUjd0S01CeGNCckp0TFN6cE1yVzF2T0xkbjlQ?=
 =?utf-8?B?b3FFdkdIQ21aalBSS1NQU3RuOUNweTF6T01YaHZ0RzYvV0tsWFozSUtabTVK?=
 =?utf-8?B?WEZXRGc2dzVFclMzZXB2NUVpWFo0SnJrWUxIaXl5Q2lMUXFtSVRmUDRid0V3?=
 =?utf-8?B?cWxCNTlVdzZvSzQvZzcvWDJFc1Y3cFBOM1RTSkI4WWR1NFhPUXBqR2NaSExI?=
 =?utf-8?B?YkZleHA5Y0xic2JPV0RlaE9kWVNqUEJyc0phWmNtNDlMdkFBdlR3dGxyVG9s?=
 =?utf-8?B?RTVPbXFWMTNiV0F4VjltcEZ0cUZPcFpyc1kvbmVBUEZqWEMwMWwyUXkxNXFk?=
 =?utf-8?B?OGRaaytDL2FOanllbjJkTndFVHQvS3dQREt4YTB6Qkxrd1Z0ZW1FNHJPaHVT?=
 =?utf-8?B?aTNhakwwb1pjQzVoVW9uRWVvUzFreXVvTGhBUE9pQjhIc0JuMEpxdkNkMjVo?=
 =?utf-8?B?SFdnU0xTYmtXUUp3V2Q0NmFYV2hjRGNhZkVQdzUvNnVNcmxZWjFDdmo2cmNT?=
 =?utf-8?B?ai8zRUczY3MvSGxLV3ZHVUpZQ0dPbmJpbzNUT3Z0Y1NySFBudUpIeDRUN2t2?=
 =?utf-8?B?T0UyQldiLzY1TTkzOVFBUWZqVkVJQ3lKVCs2eWN0dks5OVdDam9Hait0cUJw?=
 =?utf-8?B?bldFM1NJY2Zkek00UllEcEkvcDgySXZKWlZVQTVEQWVxM1NoMkZYbDJwUG8z?=
 =?utf-8?B?MGhjSHVXaW53ZFpTNHFUZ0lMVUR0UkFsVUZCVVBncnA0N1BKQmt4ZHBjSnJm?=
 =?utf-8?B?cnZOTE1ucjkvYmpDVHZwczlxTG5JZHQ5VGhTVEdzSlVibVZTVnh2bjhZeGZL?=
 =?utf-8?B?NUZiMWJkN0w4WEpXVkVYQXQ4UTdjbzRYdU85RTQ3SDEvYVMzNEZYMFVBWlFa?=
 =?utf-8?B?VHhGZkFrVnE2RVlKOVdFOTJCY2ZHbzdEbEI1L29DclFMS2FkN1pGZ1VBOTBE?=
 =?utf-8?B?MitZeFNJcjhBb3NMNS9LYXJHNHBGcDBkYVk0V0l2TXVJVWk3dXR0bFk0TlJK?=
 =?utf-8?B?VlloMDlLdFFDQTl3QTVVZnZVL1QySFNORTRRTyt3emQrOUdIeXAyeWUxeU9l?=
 =?utf-8?B?MUdjbmNXQlQxZi9uOEkwWmdqTFFWYytaZU9tZDRnVmNRNTc1U25JWjNpQkFk?=
 =?utf-8?B?UEZIN0puSmhjRlp4d1UxUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW5XTzlWQlVTVDJOZStPbTlaSDBvcmdJL0d6a2NFQnRHdHMrTVVqdmJWcThU?=
 =?utf-8?B?TXA4Ym5KWW9ENlJEOVVwL05nWWFsUm5qdUw1MDhpWWtJK1VGbFFmZW5QOFkx?=
 =?utf-8?B?VlAvM21rNWcySFRkbnMzdXYyb2xPY2JZYS9VYXNQVVlKeXhpWk5rMFRicXJp?=
 =?utf-8?B?dnRobjcxa0dueWxBRzkxL3JrWFJrYlJNcDB1NlNqUHBhVUlIN3F3WjBrV3NT?=
 =?utf-8?B?L0wrNVZ3YktlZk9sZkpmZVJHT0NicjB3Vk9yNzVsVk5IUTJXekFac21lN3ds?=
 =?utf-8?B?dW9xY2VzVUhDL0NkWXI5T2FiOG5qNkRLMDB6Y3I0L3orWVdKOVM5RnRuejg0?=
 =?utf-8?B?VFQ3QzFWd1JWcjc5UGM0RDVvMXltcThVWU5YRjhicTVDUUFmVy92WWhZanhO?=
 =?utf-8?B?U2s0UjluM0xxa1hLWXNyUllOYzZUU0NGRjlqbUVLRG5BWEZzY2tmSnZVTkox?=
 =?utf-8?B?cmJTSk94ci9tejlyZTl0c3VwQW9UdW80OHhnbG9hTGVjOGdLcGNpUWtpSXUv?=
 =?utf-8?B?S0ZJRmNldUhxc0NFMGk4Zi9ldmZRTVFzU0piNGtUSUZZbUZUeTIwV0hjcHFM?=
 =?utf-8?B?NzNLTmsvcE14RStBWnNBeUpybWcvQ1JtYUpmc0NsaEU1Q2kwRGNMdGJiNFZY?=
 =?utf-8?B?NmZ4R3RZSk1HdXlYbEY2OFQ4akJDcVZteDdsekNqbVE4aDVmZEtIUk1TTldp?=
 =?utf-8?B?TEREV3JHVlBBV2owZjV2RGFnTlFZak4wVWhVZWdSODF2ZGFHb1d5cmJUbDBT?=
 =?utf-8?B?cmkxOXExTENuV0ZVNUVRQVZ1SFh6d014eXg1QlZSM01IMmhmckV5MG8wQ0NW?=
 =?utf-8?B?WkhCY3pUNUROWHQ2MnZHZmU0ZXBXbTBXajZucTY2QmFBU0kvKzNDV3pETGNV?=
 =?utf-8?B?Zk5VbHAybmxwa21wR3FJT29FaDFGK3hCdmZHY2dHR1NGUTVJUmhFbTQ1SzNU?=
 =?utf-8?B?Z1Fteldncmt4OEU0c0ZlOGRsVDhwZzZvd0lMeFZBb0JNSGk3d0IwY3JKRFps?=
 =?utf-8?B?ZHh0NkNwMUxEelo5N2d4b0V0WlRDemkwdTdUTnh1ZnlGVlJUNkVaY2JKUU4v?=
 =?utf-8?B?YU84Ym42UFNUZ0gzUFBLWG5kMXMyams1N2tmd2tLWC9uazJuN2lNa0ExTjFw?=
 =?utf-8?B?U1ZvaTRpZnBNZk9lSG1iTklqeEVIMkxZN0VPT2xBczU4a2g5alZ5Z1djemZU?=
 =?utf-8?B?bmRyRlRaOWM5eGc2cEljbFdacURzMWRIcU5aVk02NVJMYUVNOUVoYkFMMDN3?=
 =?utf-8?B?L0V2UXBmRExISlhITTRjOVc2bWROSGs3ckZoNUlHT3B1ZTc1cHpSdkF5S3lm?=
 =?utf-8?B?OVVFN3EyNDdiTzhmcjhIQXdWVldnSWI0Yng5dWtzam4rY0NNNExIQm4zcGVr?=
 =?utf-8?B?c2ZUMGQ3MXdnOWhCcG04a0o3dUg2UGdpM2IvU1BidDF2YTR2RWdOY003bWM0?=
 =?utf-8?B?SGpxY0s3YVJlNW5KZExvcGtmaXppUXRuYzFhU1BWai84YmtJYUF5T290VUxi?=
 =?utf-8?B?aVBFN3U4UU1GczdNbE5SRVlnNXVBU3VXZUViaWRtLzhOakRHSXlKQnp6UWdU?=
 =?utf-8?B?RXpjUXNvQ3ZSeCtKSmhaNWpsUGNNY3daSkdueGMzR2E5NTI4WmtQVnBJVkRk?=
 =?utf-8?B?TDdMMWtRcml5cThHWUl5b0pXQy9naks2VUZIVzIwUGpnRTlDZ1lSdGcxSnJG?=
 =?utf-8?B?elh6T0EwcWw1SlUrMEdmNjdIM3ppQWV1ZFZJSTBCdG54ZUEvanhnVUVXZm5t?=
 =?utf-8?B?RG5ha0JBanViK3pHcEc5K052Uy9GdnYxUytsSzFseVhkaUEyS0kvY1pWRGMr?=
 =?utf-8?B?TWQrWEdHZHdQUEFhalJrYmhmdDkyQ3c3Skx2Yzk3ZWxoM0F1aDd5OEtOdGVm?=
 =?utf-8?B?WXJ1TkwrK240YU83d0lBSnpSTmk0blFHbzdHK2VHNmdibFRGeThxQXVMNGoy?=
 =?utf-8?B?OUxJSWQ4a2ZXenAyQ2l1REdwMFY0dlNhaUpjV1JvWUh3TEFTcjFxbWtJZTNz?=
 =?utf-8?B?Wm51VWxNM3hlS1pSRkYzUy9YQURFVnhrWHdZcWxHMnBwUXp5cnhTd3pmcG9W?=
 =?utf-8?B?OTBxZVdmMGpDUlFMYURBNGNDWE50MzArTThrVER2MWNiTlFFUjF3TDdQd3k3?=
 =?utf-8?Q?jtzyhXyfO/K7U3tVRRbe2VBQR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 796a8e5a-74b5-4054-cc43-08dd52e1e870
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 01:40:37.9311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmKBJAFfFI64zmJeULVbJGIkm8xn7dW1gEVgwNGNmELDd4sN5A4DIU/Ic2CYf457SkojhLbq+ANTjni/dN5fFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8583
X-OriginatorOrg: intel.com

On Thu, Feb 20, 2025 at 04:57:08PM +0800, Jason Xing wrote:
> On Thu, Feb 20, 2025 at 4:52 PM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Jason,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on bpf-next/master]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/bpf-support-TCP_RTO_MAX_MS-for-bpf_setsockopt/20250219-161637
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> > patch link:    https://lore.kernel.org/r/20250219081333.56378-2-kerneljasonxing%40gmail.com
> > patch subject: [PATCH bpf-next v3 1/2] bpf: support TCP_RTO_MAX_MS for bpf_setsockopt
> > config: x86_64-buildonly-randconfig-002-20250220 (https://download.01.org/0day-ci/archive/20250220/202502201843.xA1qZbKX-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250220/202502201843.xA1qZbKX-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202502201843.xA1qZbKX-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    net/core/filter.c: In function 'sol_tcp_sockopt':
> > >> net/core/filter.c:5385:14: error: 'TCP_RTO_MAX_MS' undeclared (first use in this function); did you mean 'TCP_RTO_MAX'?
> >     5385 |         case TCP_RTO_MAX_MS:
> >          |              ^~~~~~~~~~~~~~
> >          |              TCP_RTO_MAX
> >    net/core/filter.c:5385:14: note: each undeclared identifier is reported only once for each function it appears in
> 
> We've discussed this a few hours ago. It turned out to be the wrong
> branch which this series applied to. Please try bpf-next net branch
> instead :)

Thanks for the info, we will configure this branch in the bot side. Sorry
for the false positive.

> 
> Thanks,
> Jason
> 

