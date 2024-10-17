Return-Path: <bpf+bounces-42309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336B49A24FC
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 16:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5634B1C22673
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 14:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386301DE4ED;
	Thu, 17 Oct 2024 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jppWHeGH"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971DA1DD540;
	Thu, 17 Oct 2024 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175292; cv=fail; b=QclmNuV6wMyIt5En6pyATwueE8EbOLZo872oA1j+iNUAZQxD9lj3t50G0Ve6S9ye3Moo18h7dAm1+hBScr0ai+gXlnsNywf0LlRgeYEHIhr1YkONMYpzJx6lwl85ZXCAe9DxAQsfN0df4WE0hRkF7TkelXuQkh1YKwuAk4nwX+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175292; c=relaxed/simple;
	bh=N+WqcZlyyQwWtZdzTvQESmoRH9EySx5gYE6Fg4A6zuo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dx12GrgNqR9P+Wwo8JHaZkjMEpa/JTxjlJiKFhYJ8iYqBJEiQqmJfeDtOqQ5RN5HoLoVNGvnZzClzgGkf+020+Z3Xmyn+shYJJ0iAyhxibvlSnHpq52rG6YMHriDHa6Nxi7LfG71SADMTWfjhH24Piz+b4bjNjSx+9aZNw+jqK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jppWHeGH; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729175287; x=1760711287;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N+WqcZlyyQwWtZdzTvQESmoRH9EySx5gYE6Fg4A6zuo=;
  b=jppWHeGHPqgrD8rWPgwnofp5FknHWinrT2GW2W3LNrX9kotqBdPkcjVP
   YreSqGPCOufsH5AKkJWyI6Kq3ipxZwAvanK5zxASVK9XyHUoz2UrRXIBP
   wJkgayl0HWPPbFWaGF/8X6KZ5eN76qzQCyUIYxUqlLlUrOjg+3WFbTUQb
   E4HsZUlT8Eh1Wj8eaVgP8qPayM5KsUiVK9IlOx6PvPoA8ICHj/pCCdnj7
   DCViKDeRKtaBbaHPBFzecjty6TdK4PMlia/FgrcKfqiy8sbGLlb+JRk5n
   P2Xkv2o8BoSCjBGJh24PMICgYZZBPpgpzgCu9V4qR+3C2quJ0XQ5E9WDs
   g==;
X-CSE-ConnectionGUID: kqFzOhd/TFyX7rDTXkjpPw==
X-CSE-MsgGUID: NRCKqzqER0Sh55Ihu5cG0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28796205"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="28796205"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 07:28:02 -0700
X-CSE-ConnectionGUID: 8WeiWvPLQJqktlD6lBu2eg==
X-CSE-MsgGUID: TCraPDbcQXO5VI78hbfz9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="83644047"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 07:28:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 07:28:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 07:28:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 07:28:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 07:28:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkQE6RsrLgQMdc1Bj5OXou77tDUN0Xge9Oa69Z2keda/X7zLCp1VINCF+VOIHPR45JS+EiqGrV5VV3m0ghHVZpO+TeEZfueKZj+9c11GjIjOcrofkr0Iczyvb041BaESUFSSDhqM5wCKXHgcjtCtdmwIlXMdHnh4uYw9XOCDI9bf5o7meRYGEtc6p2A5MjgEfiTDcMfuyZkfnq2UtFASTZ9L2UaLpBqqh2VyU9aw6/wXyMhXMpQFCzTJqOynkqN17YVwKgt7jnCv6EVqjJqzh7OUl7ADxbrSzCtOQcl4inIVmMjMPgmL4h2PojeSWZkK9+RsvTdCWHM+X4HsDhloNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyZJv7S2CbYvP8EfmiekD5RhySsjzfZluZeh5tPhq6s=;
 b=GX3Udm7MqQas0+XcWnPNJQqlAtWNb+HreI2jOGvdypZEhspu0qdLgom9sjMD6++j3/0sW0t/7bp+Nsvx0m8WOCQnWotu/Y/KPLgEnpaxgJjacwPuuAnPP8r4634lSqPf7DEEQVwZsUxSKGOebF+jjCe3Hx/MPSSxsmPcqZx1d/+2L9CsNa1NI3e7tnWpc5DMP97hbI4ZVXRULtmhpIZfS9x2wyDgWyjmD76hpMHKByAeZJ7g9blfOy98R++eS+Xb3UllGfMsHmmHzDh3nFjQGXGjeVNsWCdXchSkXUVVCPHe0NbIhW4ZDjbRoDvy2/yAtg48E/aYeVAVQdmtmmmlOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB6193.namprd11.prod.outlook.com (2603:10b6:208:3eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 14:27:58 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 14:27:58 +0000
Message-ID: <ff067123-f516-4e86-bdeb-c7fcb5cef796@intel.com>
Date: Thu, 17 Oct 2024 16:27:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] xdp: Add Rx checksum hint
To: Muyang Tian <tianmuyang@huawei.com>
CC: Larysa Zaremba <larysa.zaremba@intel.com>, <bpf@vger.kernel.org>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Donald Hunter
	<donald.hunter@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
	<bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, "Maciej
 Fijalkowski" <maciej.fijalkowski@intel.com>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<yanan@huawei.com>, <xiesongyang@huawei.com>, <wuchangye@huawei.com>,
	<liuxin350@huawei.com>, <zhangmingyi5@huawei.com>, <liwei883@huawei.com>
References: <20241017135430.51655-1-tianmuyang@huawei.com>
 <20241017135430.51655-2-tianmuyang@huawei.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241017135430.51655-2-tianmuyang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0021.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: 477d267e-e97c-4c68-daf4-08dceeb7e5bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWNFRm5KNjNtaFZSMlVNdzJrYmhCSGplWU9PVGlkZFFUaVdPdjQwOEY0U3B6?=
 =?utf-8?B?K1ZRRFI0eVJRS05IVmQ0Q0RKbThKTXd6YVpQVHVKWGNmUVlRQmxJb3hoZWVF?=
 =?utf-8?B?d0pOMHh1MGZlWDNNQmNYcHh1RHhDNndoeFhHUUdDOHBEdjE1dFNiZXZrdHhx?=
 =?utf-8?B?ZVVWaE1GUEc1NURpRksrSE1OcUxFKysvczB3UDQvc3hPTjZodENMRHk5aEFl?=
 =?utf-8?B?eWJlelpPZUNUeGNCdEpJS1dKbUsvWlVRYUhDQ2YzSzZ5ZllrdHNGNHZvcTlU?=
 =?utf-8?B?TWQ2dnJndUkrWkFURGhvTFN3MzVWQy9pSEE2VUM4ditSbHdQYUJUTkhUYVF5?=
 =?utf-8?B?bWlOVXpvWnZtTkRJbEdwcnJMTy83UTZLRnFPOG1lNVZYZjJEMitpWEFLMVd1?=
 =?utf-8?B?cUcrbitzaXBzWHdtcDRPdFI5VUJXVVlXMU9OcnQ2bENqZHBNVjI0bXRhb2Jp?=
 =?utf-8?B?RTFvNWRETE1SVDZkVm1reXhtNm9TdnFETGxjbmgvdGRiNUFzcXUvZ21zZktH?=
 =?utf-8?B?SUNNejdRa2VLeXFoai9TZWU4RURQRnVEOS9Wb1RPekE0dk0xZjRIam9XWGtM?=
 =?utf-8?B?c0M3RjdUN0g4MTdjcjRYRDQva1F1WllDeVQveFlDTElkUloxVkNHL0o4dGRP?=
 =?utf-8?B?Y3lKTU1HYlJvYm9MQmM1ZUZtUTN2Y0JmY2ZxdUJlenUxMEpLbHJ5T2FOWC81?=
 =?utf-8?B?elpPTmNEYlFFQWw2QUNBbFEyLzVQSEg2K201WUs1QTdCWi9XTWhWdi8vR2pY?=
 =?utf-8?B?a3JacXNsb2JrUnpuQ0NCTCtnckJuWmIrK0ZMTUVJMXNGYTZiZzFlMXF6ODRs?=
 =?utf-8?B?cWtnNGpiN1NuZTdNOVFmM3FLT2FwOHA0NUpyV092NjNFL2I1akZHMUNZSGta?=
 =?utf-8?B?SVZXOXNQRFdKamhnWjEyMXZBVS9ncVEwOHZjU2tmUkNzYURkS3FieTBSU25W?=
 =?utf-8?B?OE1Gb0tKNmtNVHo3YktnMWgrUC9PMHA4L2hXWkllb3ZhVUZ4bm9POVEvdHpL?=
 =?utf-8?B?bHNHd1NhMzEySkpRQnUrbjl3K0MxK09XK1pqU0NyRkN6YmVEQVNOUW5lQzM1?=
 =?utf-8?B?dzlKWkFqTHRTZkp5cFJFQXRiQVdYMW1PZmJkYjJuQXJXckFzR0x4YVh3bExR?=
 =?utf-8?B?L1ZRWFhScDVPRFNEejF0d2FJWHg3Q1c3cXpPNnhPS3kvUXE4MXZYNlh1Tnp0?=
 =?utf-8?B?a2NScFRsb0tKWkVFV3IvZTQ4ZmZBYzMwVUxvQ0laOCsvYUlHY21UNllKY0Vk?=
 =?utf-8?B?OGlCN1VxUjBQSDJJMXRVK3FGUzYxRU9WbzVudE90c081ZTRWWHBPVy9HMVhC?=
 =?utf-8?B?TStzZUhtMllKYW5wQWpZRGNvalNCUUVqSThMMGprdlJOTzFMWjRkS1VoSUFP?=
 =?utf-8?B?a1lyNnNWSzM0T2x5TXV6OEZTNlpiTVVpZmVqYWlnejRZVlBpQnR1dGZUVnhz?=
 =?utf-8?B?cjNEVEd5UEZiSXBaUHdicmNBZUtBeWZCeTBvYzdMMkZzL2ErcGRXK2RHQ3pQ?=
 =?utf-8?B?VWRpeEtqelZMOHBGZC9lTHVabTdUV08xUHhhUzJ5MHJTNUlwaGxYZEkrcXND?=
 =?utf-8?B?NlZvb3QvaGc4YmNkb3doS0ZMMmI1Z0N3dmlUVkVqWWVidmN2NXFBS1A0TC9R?=
 =?utf-8?B?bGNxK215N2JoUWFuT3V5UWZpR3h1VVEvVVp4c2doeU5QM1Y5VTNxMkFFUUZo?=
 =?utf-8?B?TzlVMEd0WHE4SjVWa0RTdWZqWFh1RHRMM0E3K2ZZc1diT2NmbjF3UzU5NEts?=
 =?utf-8?Q?uxdpqKTsJ8UlZl8P5EGz8oF32ng3VX1j9DAI1BR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0NKMEpiU21DWE5YRGVKY0hmWVVPdzBUV3B1RzRreGI3Wk9hbXpoYVY2eWY1?=
 =?utf-8?B?aUZ5RDVTcWwxNWVpWXVnZU1kT2lnV3BtelZDUVZmdG1lR1NQMEs3QzVjR0pM?=
 =?utf-8?B?ZnZ3UjBkeVpTcHh5RjhFVkJ2akRmM2Y1SmNjMHdUMFJoYmpOVWZJZUhXRkc4?=
 =?utf-8?B?T0t6dEdXYXFHWE9Nam5GaGxkUWUzU0VGRUs1VG85R0U4Vkg5M0QzOFpxdWZZ?=
 =?utf-8?B?Rjd3VmdML2EyY3lhYnk5cXQ1WERqMzhvTkdMZkp2eU1wbXFPTEpiK1pTdHQ3?=
 =?utf-8?B?K1FhMWd5MzhUUW9LTkRRKzlEZ0E5WnB3UG5lYU84WWJFc3FZVjdXSVNVNThI?=
 =?utf-8?B?Wk9obnA1V0svbEE1OHpUS21rSmRQSUJlV3dkQkdrUzdtVDVid0FIR1I0NjMy?=
 =?utf-8?B?SEo0eU1IV1hpTjRqMURIU3VwanZQSGV3T0UvZmdQbGl0SEQxbFE2eVhPU3Zl?=
 =?utf-8?B?dHRoZXUrVG5oSjBWL0M2S08yYkp1bUFrRitJbzVEUG5zSHlwaEcyS1RNM1NN?=
 =?utf-8?B?ejlUTVJxRWtLRkhzRXlSY01mTEJhVUpEd3RzQkNBdDY2S1dIUEo3OWJqcnRT?=
 =?utf-8?B?cDJ4UDJzZ3hmV3hEQllrdzVPbUdHOHh4b21xY2tTK0hCOE1MNENRUVZHaFBB?=
 =?utf-8?B?V1RSekloSzNNSnkvMEYxT3FpdzM5T0RZdy9OYlE0dGg2Z3BGN21EQ1NibFJS?=
 =?utf-8?B?SWhqTWp1WVgzMlNFZ1hMSnJLeUFwcXpOclU2ZGt3VmpQVktGM09sdUZQYWZp?=
 =?utf-8?B?cEt4Uzh2d2w3YVNaRW5YdWtVZTZmVmZjbTErTlRqSjYvbmdURkZvVU9neVlT?=
 =?utf-8?B?cFZMVUdCM2ZmaVVrTFFLaVdySFVnTmVXa1hkZWlUeGlZRzdkcklQbXhXNjA4?=
 =?utf-8?B?S1VPRk9hR3NFMGFvYnZQN0ZmeTdydDJ6SnIxSmR0ZTZKM3hTTXkxMDMzLzJh?=
 =?utf-8?B?bUdPY1Fyc21BdnVLS01JbVphTEQ1RGk1RXA4TTd5RnVrV01wckxaTmpQSTBX?=
 =?utf-8?B?NDZyZFg1QWRDZHRDQ01tb3FMWlZyajZXWUFaQmRYSmc2dVBnOVZQaUNzQzV0?=
 =?utf-8?B?VmU1VXc1dVVvcUhobW9VTFM1UjZVcnB4VUYzQmxTUDJod3ViZEZMcUdSSkJB?=
 =?utf-8?B?ZytyQ25jWnJadGNBK0tOL2thU3M4VTB3SGdkS0FuSHpjNHJ6KzIvbVZCbmJU?=
 =?utf-8?B?eFhDUjYwejJrUDRNTyswbHVnaTRQamh2R3NOUis3R0ZPbHhkTlZYUUV6M2hC?=
 =?utf-8?B?YVN6QTN0aitBdk4wTngrRjN5cmU4cHBLcjN1QWdGYm9IOXE1UDFwdWVQbVE5?=
 =?utf-8?B?R0ZQTFhsZVJJMUIzQlUwNVZnQXJybVl5dWJDb2UvRUtacEJRRDNPWHRFckhP?=
 =?utf-8?B?MW9ZZ2tIb1U3ZzJsaThBVTcvZDBmdDVPSktoek5rVUtGSzJwY3pHQURIRExL?=
 =?utf-8?B?SThaRDdLeFRiNWdWVmZrUEdidjhxaHVJMTB5ZzJGb1RTck80MkJLdThJNFR6?=
 =?utf-8?B?NFJxL2ZQWi9PQmExSnZCWmtFajBZWGRGbHQ0TnpSdm4yd1AySUhiYXdTYUNH?=
 =?utf-8?B?TVRMcUhWeEttdEYwT3Q4MW1TdHJWS0E5SCtyLzVEWHczczZrdXBCWnZlTFg4?=
 =?utf-8?B?ejNucVErSThJdTBUOFhEQUNET3N4TDd5c0xHa0E1QWJvOFlObldJemh3cDVo?=
 =?utf-8?B?aEhUVmw0QSs2cU9XeStSY1FaTlMra21Zb0lVUDNkVk5lV3ZYM0lLU1g3dUFN?=
 =?utf-8?B?WlpUV1Y1QzI0K1BXTFV4L1dnTXFmeWp2aVJXSHVwVzJWYm5ubWJJQkxmeGhF?=
 =?utf-8?B?aDBmbDMwWmg4MjZnMmFtZ050SE96L2pwNmF3WEFOVmF1eWhYanptZFhkQXdk?=
 =?utf-8?B?S3NyVTFtU1EyOE9TQVpZUURuQjdJOXlGUDlUM3dNdU85UU9nZFlldHQ0K1Fo?=
 =?utf-8?B?RWJ1K09JN2F0SUtSOElnOG1haVpab1oxbVNCOXpyTWZvU25rREZYSHJjQXk3?=
 =?utf-8?B?cVJ6eFpTeW81MGlSaWYxMmJWVXIrMVBKUHc3cDNvSkpVRlhDalVZTFpUaFRZ?=
 =?utf-8?B?ZFFnNm8xMnAyQk5YQzQrcUNObXI4TlhwR0V3YlAybHpIYVRLSEpDUk9WMHdk?=
 =?utf-8?B?R0gyTTNUY2FlTm1XUi9mZ0NTU2pwZzN4cXdySk8wN0RoQisxM1RNbk53dWM5?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 477d267e-e97c-4c68-daf4-08dceeb7e5bb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 14:27:58.3658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6TpXieA/3PmBTc3kYcAYFf35J+f6oE+YAOKsNaLVnmMwPgfZMR3xY/Ha+gzLhske2QdPuEGnLAuwCf7oo8AYSiUPTYBdjQw8E1Aecsm0bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6193
X-OriginatorOrg: intel.com

From: Muyang Tian <tianmuyang@huawei.com>
Date: Thu, 17 Oct 2024 21:54:28 +0800

> This is an implementation of functionality that allows drivers
> to expose checksum information to XDP.
> This information includes:
> - Checksum info, a union of
>   - complete checksum, if checksum is complete
>   - skb-style checksum start and offset, if checksum is partial
> - Checksum status, an enum which is the same as skb checksums in
>   skbuff.h, identical to sk_buff.ip_summed
> 
> Signed-off-by: Muyang Tian <tianmuyang@huawei.com>

Is it just me or this is clearly based on [0] sent a year ago?
Credits then?

> ---
>  Documentation/netlink/specs/netdev.yaml      |  4 +++
>  Documentation/networking/xdp-rx-metadata.rst |  3 ++
>  include/net/xdp.h                            | 38 ++++++++++++++++++++
>  include/uapi/linux/netdev.h                  |  3 ++
>  net/core/xdp.c                               | 23 ++++++++++++
>  tools/include/uapi/linux/netdev.h            |  3 ++
>  6 files changed, 74 insertions(+)

[0]
https://lore.kernel.org/bpf/20230927075124.23941-13-larysa.zaremba@intel.com

Thanks,
Olek

