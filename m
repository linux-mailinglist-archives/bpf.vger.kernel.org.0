Return-Path: <bpf+bounces-69681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E90B2B9E757
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 11:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320FB17D3A0
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 09:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A56283FEF;
	Thu, 25 Sep 2025 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cNAKkeeV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925341ACDFD;
	Thu, 25 Sep 2025 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793342; cv=fail; b=rv3b+Viixj9AUKaXKYbraODwQ+ChVLEae7zReAPB2x7wf09471XI3ruliBBLCVAfRw/0JkzFs+iqik+beVxYzL56LCER/9iq05gho0HWEbKtsVebbwl9f/1UQWclHUNG8xSz1AXwJjTcna2hbNPz7iV3avg5ZWauhD3XXbO7yXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793342; c=relaxed/simple;
	bh=j4zGdvn22P3bM8V/a01Ahz/L7YGHfoyCfnbuT8rt/Hk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o7bkrceGFR8p+74VdPl5qDN0c9znwzevrUUAJOuKJtFKQMPF5LET1MhOkvzjoh2m7RU98/D1NyGQvsXHnH4nEmaYTDeEWpIQWP4kxu1r3hjsfO+kVhWylKpLGSLDui9gT8i7TzPwXfj1fPCYZrurbMDPGadowvZe7jgMmkT55HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cNAKkeeV; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758793341; x=1790329341;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=j4zGdvn22P3bM8V/a01Ahz/L7YGHfoyCfnbuT8rt/Hk=;
  b=cNAKkeeVZ7BDuJh9mD1ngpDVDdwKJn3mJQ+KNoECD81dqSrODK8lB0/s
   HxqPftcntuFaiVldtU/uvR4CuulRQeenlfdoYCzi3VFyU5lYOC+fSWJoL
   Ej6UmCssdFbjCa2A7M47CS/zMOVUxtK63O+YlmhjDnGFHj0lxugaqYbTk
   JlHPZravhIyDnYOi8PFdCresa9l0VrqBNJkJM6fNK2oWihM3KIDmbL3XE
   nuXWQnr/zlHUhbLGmns4u34HpSMjZtBt/j3ERRdjPFktUndEeIyC3S175
   JgeC6obZQ69gVXSi8BDZw+XxyjskadHLqm1XktK8U+0wjkg0oTwsZI6wW
   A==;
X-CSE-ConnectionGUID: 58/92D7TRyOiwccq3Wc30w==
X-CSE-MsgGUID: ty6MgmL7TyOGTGeK9kVjqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61214190"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="61214190"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 02:42:20 -0700
X-CSE-ConnectionGUID: M6+HrriZSD+GPnirEPBNPw==
X-CSE-MsgGUID: +Te6uFI3Ty6rOaKO7GAZSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="177125241"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 02:42:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 02:42:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 02:42:19 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.14) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 02:42:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u21yXDdeNM/seKZt83XAi13wUm6W7swPkkoombz370aFB2IhK4lutH98PkkB0mIfKzJW9e+0u0rwBlpNJEA5akVHvSj2R91R4Wo8mjTH7ffn5X5meXa83xxJtqmCAa9o37qt5CTB+7JOYZ+vFhsm+kEGzuKAYco6x0i/FsH8y7X4ZjW4hNstKq5Jkk6Swgf9LVEHvGJg8DviNUSbvhBS7AZZxsaagvsRmynbhZSzYWccuY3+sDzWaSRZZrbUgDQLbcyPU00K0iL6M+ZSgK0iyJDmA9iH8PYLW1RwxYjd5SdTy/86SP3VKCdJHpPjYiNtXF43F98jgg6PDr7dy9yzQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXif043VPvSuZ5ZfHj9xY4LSum/9eh/iuBaQl14+q8A=;
 b=pqMRMFXcyWfWflNlDy6TWDpPBOL+fUBaYRw8Cp0+wMIyqmn2CkX8KrVlvUaYFlNMRAUuUHhDxmBxS1RczGCjr3YbC/hzZLDfAc/cXwLNMTZt7Hlckrau0Ir7fwuK5gTYoRq5//1kOntZBoOj4eWVT35Q0dQ66ZsHvYWuLaqs6xhkyeIrPf5JReCxO00lHu5zQsaCdc85Mssz70gnd8MJmowig3oro1+F1Gt5aYmZ0nFxUf847JbYK4qOUplcJXERqKklsPSjg7irWSoWYBFEZX5Np5mUaQAdL1Blgx70N78wAFI6QDBaOHwAoeuQTkwHJMgwBFAbjm9UPeYgG/zueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MW4PR11MB5891.namprd11.prod.outlook.com (2603:10b6:303:169::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.19; Thu, 25 Sep 2025 09:42:16 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 09:42:16 +0000
Date: Thu, 25 Sep 2025 11:42:04 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Octavian Purdila <tavip@google.com>
CC: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <sdf@fomichev.me>, <ahmed.zaki@intel.com>,
	<aleksander.lobakin@intel.com>, <toke@redhat.com>, <lorenzo@kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>, Kuniyuki Iwashima
	<kuniyu@google.com>
Subject: Re: [PATCH net] xdp: use multi-buff only if receive queue supports
 page pool
Message-ID: <aNUObDuryXVFJ1T9@boxer>
References: <20250924060843.2280499-1-tavip@google.com>
 <20250924170914.20aac680@kernel.org>
 <CAGWr4cQCp4OwF8ESCk4QtEmPUCkhgVXZitp5esDc++rgxUhO8A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWr4cQCp4OwF8ESCk4QtEmPUCkhgVXZitp5esDc++rgxUhO8A@mail.gmail.com>
X-ClientProxiedBy: VI1PR09CA0174.eurprd09.prod.outlook.com
 (2603:10a6:800:120::28) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MW4PR11MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7b9355-66e2-49c7-af77-08ddfc17d042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVl6eGNPMzd6NFBGbG9CUUh4Mk9Ua2VVQjBZOG5Ba0NiVzVYZlAzOGx2M1Rr?=
 =?utf-8?B?T0JUZGdnSDRrWkx5bnlBNHNJTENFb0ZRSUFZeUl5cFVyK1cvZUZqL0ZVcXRK?=
 =?utf-8?B?ZWYzU241d0R4N3MvWFFiS3kyRFd3a3lDMjROZXgzVG5lM1Q3V0NKRUxCZXl1?=
 =?utf-8?B?R2JtUTZ3UHc3ekdwMzM4MXBCLzk1UzQ3MHlDakUzZlExOVYxNkg2R3lUenh3?=
 =?utf-8?B?VjExMllUK3dGNDRPTFIxc0tUbHBWU0tsTG1Jekd2TEswL0JzdlZDRjFwQmNh?=
 =?utf-8?B?YVVUOHNldWdUOHBiTW1Ga3BMb0k1MENLZU9qWndLa2pIMHlvYklka3ZQcm1u?=
 =?utf-8?B?RVBiTCtOc3VIekx4eU9uT3NZN2FpZjlZVkp0dFNndlpyREZNTDRMUG9vaU53?=
 =?utf-8?B?Y0hlOWhaanc1Y1M0a1JScEpwamFpY3FsZEh3QXA2Q0hKaDQybnhKd0JETzE1?=
 =?utf-8?B?aHExUGFaamdCZzhiOXR1NFBndkI1bkFkNEFZbkIwTTM2R2J2b1ViVjQrTzZK?=
 =?utf-8?B?cDZQbVc2QngvVGUwYUtkWkd0NWZ5QVlxVzBnV2wrekRJcDNaUCtOQjNtaUdm?=
 =?utf-8?B?em1wNnZQRkl2U1RMbmw1TUZ2N2J6M1lIMFlOTDR5OHQyUXVwRjRnd3c5MHh5?=
 =?utf-8?B?U1BxazVZOWR2VDZ5Ny91UDNmSnRaU3pCSWswbXNZYTNJaGZpMmwzTVRFcTVZ?=
 =?utf-8?B?aFN0TklsN0tYMzhPNVFMTXVnVzNNOHlVMzlIWkxoaTIzRkRpV3FWUFBhQVZL?=
 =?utf-8?B?T2x1UjlGNStSVUZCalZzcXVBMlFQbkxST0orTHlLSHREQy9YZzNOUHZxNGV0?=
 =?utf-8?B?elY3RlB1ZDlZU2RTL0R3dk9ZSktTNTF3c2pqL3Axakx6b2toWXl3cFA0K3lD?=
 =?utf-8?B?SExPWERHWTJYSEJ1ckhVY2dtZ3lTamE3YkZJYnAwWG1OclBOc2p1YWV6RlVF?=
 =?utf-8?B?aTJNRFR2Y1FBUlJXUlRSSytkd01ZS1gwYXNGejcwZnU5blh3ZVdCSDc2c1dh?=
 =?utf-8?B?aXBKOUJRQXdyUlZKSWE4SFlrRGZDZWE0QkVQSHE3VXk2L0JEZkxCS1hzc3lZ?=
 =?utf-8?B?anZGRk9KQWdjRS83YU5BbXBLZHExMVYyd1Faa1ZZVnNGVWR5TGM3T2dDRkY1?=
 =?utf-8?B?R2htRzdDV0swckk1NE9CZWtNYytVZk5lbGZVUnd5MnhLa0diRnQ1VEJjRS9p?=
 =?utf-8?B?VmJ5aGs1dEhjaGdLazNFT2VGeGh1YU54R20xYnN0NGg0b0l6UVBFRFF4ZGJo?=
 =?utf-8?B?YmFNTUw1b3BhSVVWcFlHRGtBSzhWNVR5WFRBL0tWaXJZblJEYnBsdjlsS2hw?=
 =?utf-8?B?V2RSbGlqcXhQNjBXN2toZmQ2N01ibmN6U0hpY2ZXWnQwc3pPdFNoQ1lLUUto?=
 =?utf-8?B?dDd6Ti9OZTBmM1NreHloS051NGJZYTZkbmR4MkdVbDhqQlVSZkY3T1czTVRh?=
 =?utf-8?B?ckRrWFphMDlzaTdndVdWSUtPeHRKNnM0ZFhBOTJ2L0VzRDBXRlFYK0hGTnNy?=
 =?utf-8?B?bmFUb1BNT0d0UEtxakdYSUVnRWZPaHpIODgxdFlOSzFsdFNRTkRIcXdtMTFQ?=
 =?utf-8?B?ZUkzajRndHp6OG1aWDE4N2JhQWZtWVRQUEFJVlRjd1pIdnBLUzNNV1QrYWZ0?=
 =?utf-8?B?K3pWRXJOaFlpc3UvL2l4Zyt4MDUxQTZiK05RaU94NGwybXpCaDBPQTlnQ0xF?=
 =?utf-8?B?enppcEJnTzRiazRnRmYxZkJEYmJxb240ckl4MXh4R2M1K3FuMnIrUDNlcjRq?=
 =?utf-8?B?QkU3UzJPcEs4Y29DQnNLY3VTTWpPWmxDZFcxbGlVVUhwbHdBMC9SY3lMYmtV?=
 =?utf-8?B?UFZYSy8zZTQ3eDlVakE2UTQyeWFHaUpDY2F2dE10dmhPS0RVeDMzNDJ6a1dm?=
 =?utf-8?B?UEllVjgrdjk2SGh6SnV0ZHpYVmhVc1ZMMVRMeWUxNUJiVFJraHlJTnYzcmls?=
 =?utf-8?Q?MtOkH8Em9Do=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlAzc3U5SXBIaXIwTWI0TDRLWW9HS3NRZHBEekRZaUIvTG03Z0ZpYUFsdTZp?=
 =?utf-8?B?RDQ5Z0NjclhwUHcwekhYWktoaHlNbVNhalhBUkRyRDdDU2U5OGZMNHZLZTZz?=
 =?utf-8?B?eEhYVVdJL3RtRGdlQzIzM2JYZXJ3WkJMMUI4UVN4S0swWnl3eGpBUHFORGVn?=
 =?utf-8?B?cllDWU5LdXVDOE1vUitLbFJLcUxtQXJMdjh1dDNHd25ZRW9IM3JZN0g0RnZh?=
 =?utf-8?B?MGgvQTlBdks2RE5GeUZNcXhETHZUTEtDdnBtVWFWUy9Gd1VMYW9BOXJlaXdD?=
 =?utf-8?B?Z0RxT2x2aXB3UEJGL2pIU0o2VUtveWNMRXFPcmcyWG5yQVBlRkFtYW1IMUd1?=
 =?utf-8?B?ZVJTUjcyUU54MU45ZHhFSXNIOVlTSzdUMXhBQmpJemJITEk1WGlPMWNPUXVX?=
 =?utf-8?B?UHhBd0loeHBiT2xpNTdaMnNEQUZvNlN0TW43OEM0T2hTY01HaC9CeUxjSlFr?=
 =?utf-8?B?c0JMa2d0ei9FQzFwL0NXVHlQUGhYcUtJMmRnTFNSdE1XakRvR21iWmxZWDIz?=
 =?utf-8?B?MDJaaHdzUEdBMzIrd0Z3RDR5MmlwUGZZKzllQXJESU5ER1BDQkg5SlFneGw2?=
 =?utf-8?B?NWlTV0pEMlNyTWlONVNGVGJ3RjdDNUlDeCtqOEFzbW5lSlArOVljemtFcHQy?=
 =?utf-8?B?a1IzM3dPR3JrMFpiOVVGN1lYNGM5bFA3TFBTMmlzUHludzJ6U2xra1B2Z1k4?=
 =?utf-8?B?aWU0TFZvNk9pcmFtbWNKZXh6NHZMbHRRTXo3RWR5bjdxNUpucGRhZEpYYm5V?=
 =?utf-8?B?QUhkNFoxSTJYRGpiS2o3Mys4aklYRlRadk5SWENhRGplajVucStKYTAwcmtj?=
 =?utf-8?B?bGlCS0NkemNxSlR5SUc0dzQ0c3l4ZzdhMnplSHhReDJjVGRZWE1jRXhFa1NO?=
 =?utf-8?B?VXJITHZjdkovdFVmVURteDV0M0JhbWw2bGFDQzF2THN0SXN0SkdJNVNaRWl4?=
 =?utf-8?B?RzhKTUN3UXErbDhhTngrODFMdzlxOVB3VlYvQllrWTRTend3WHdES21JVzdx?=
 =?utf-8?B?YzNxSEhaOUphaTIxd0h0bnRRTjFOVlpCRWR3T0dRUlFsdVdKczhhQ0JzWVF5?=
 =?utf-8?B?MTNrc1lIMnN4YTdIMGdvdjBjZVJBUTNGNEhVUDZLRTh2QkRFV2xEZUorQmRP?=
 =?utf-8?B?RXBaVDNzMDFZcFdGalV4b3dGL2RMOXpoYXFKYXl6eGdGWGxBNFV6aU04Qytv?=
 =?utf-8?B?aHY4VEQ1QXJTZHZ3ZmhMekN5cmV2S3E4N1plUVJOaTNhVi9ETWVScGZEeGVJ?=
 =?utf-8?B?TXdjYWY3MHZkYUUxREsvTEZGeEVRbkdxc1RXM1N2VEVJQjBqdkNyRXBnT3ZJ?=
 =?utf-8?B?V0g0YXUzanlYckc4ZU9hNGJ2N2k5VDIvaHVHVkJtNUY2OUltYVNNeElIUmcz?=
 =?utf-8?B?dkcrRElQQTdEYzB6NXIza1V4MmJyUVFnRlBOakVCZitXaGc2OXQ3Vy9xWisz?=
 =?utf-8?B?UDIrR2g1WmwzL1pZczU1TCsrRzVmRHZ4NDVOVWFnYlNpUlpiRDRrcWw1cmpH?=
 =?utf-8?B?WnpLOENySkp6TzdJWWhra1dyYmo0ajRFMndDc2NsQlQxSEtaMUMxOFY4N2RE?=
 =?utf-8?B?cFBDalFnN2lQend2U1YvczdxTHA0Yy9Udnk3U3h3T041UzVJeHFSaHBrVHha?=
 =?utf-8?B?NHBKQnNJZGdHWWl0ZFdLOEMvMUtiY1lTdHRLcUNwcGpFbHNFaWRXOTN1dlVl?=
 =?utf-8?B?Y0NkS05DRndnbm1OS3JxMnc0QkttSXYyRndFMmYvanZRdDhIUGp0Rm10TEJ4?=
 =?utf-8?B?VU5HMEFERFVqMmFORHBNWVRYTjVubW1kaS9PdHQ2Mm9EdTIrbHl4Sm5QZUky?=
 =?utf-8?B?TFgxNHNSbXd5M3dEVS9YNW14dWFERWY5Qm1HOExyNEZZeWlOZHpidUozUksr?=
 =?utf-8?B?Rm5XL0ErcWh3ZzZDcXh1TCtWaURJVlA3S2cwcGYzanZPYWgvRlI1cEZ2RFpD?=
 =?utf-8?B?K1RaRE1YZ0VQd0Z2OGs3cUxOVmI4eHRtK09IOTVGSTVBYkJKS1dkcmZjRnd0?=
 =?utf-8?B?NUtqVmc1SmpXL0ZpZmZjLzRBK1E5dmdteUx5QXIxaGpTRnRhVjE3NnA5c01X?=
 =?utf-8?B?UjdmOTJSTURhN0wwenIyRFZzMVZGMmlLdzdjWTNaZkR1UGxob0cxUUxSZ2Nz?=
 =?utf-8?B?dGdsR2hEakFwa1ZPNEpSSnlnWkFpcWFVcGtCNWdhZkE3YUhHdmdPYSs3QTZi?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7b9355-66e2-49c7-af77-08ddfc17d042
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 09:42:16.5940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQU+W+exMSeTwaNtA7HWwls68LlhJcLVDzSp6bnIe7SITqYrte4NN1LnT5xcXSVwwXQbJDdUmQQJtZ6/WF+fjODUKQEL2iFP8IEjZy9jaHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5891
X-OriginatorOrg: intel.com

On Thu, Sep 25, 2025 at 12:53:53AM -0700, Octavian Purdila wrote:
> On Wed, Sep 24, 2025 at 5:09 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Wed, 24 Sep 2025 06:08:42 +0000 Octavian Purdila wrote:
> > > When a BPF program that supports BPF_F_XDP_HAS_FRAGS is issuing
> > > bpf_xdp_adjust_tail and a large packet is injected via /dev/net/tun a
> > > crash occurs due to detecting a bad page state (page_pool leak).
> > >
> > > This is because xdp_buff does not record the type of memory and
> > > instead relies on the netdev receive queue xdp info. Since the TUN/TAP
> > > driver is using a MEM_TYPE_PAGE_SHARED memory model buffer, shrinking
> > > will eventually call page_frag_free. But with current multi-buff
> > > support for BPF_F_XDP_HAS_FRAGS programs buffers are allocated via the
> > > page pool.
> > >
> > > To fix this issue check that the receive queue memory mode is of
> > > MEM_TYPE_PAGE_POOL before using multi-buffs.
> >
> > This can also happen on veth, right? And veth re-stamps the Rx queues.

What do you mean by 're-stamps' in this case?

> 
> I am not sure if re-stamps will have ill effects.
> 
> The allocation and deallocation for this issue happens while
> processing the same packet (receive skb -> skb_pp_cow_data ->
> page_pool alloc ... __bpf_prog_run ->  bpf_xdp_adjust_tail).
> 
> IIUC, if the veth re-stamps the RX queue to MEM_TYPE_PAGE_POOL
> skb_pp_cow_data will proceed to allocate from page_pool and
> bpf_xdp_adjust_tail will correctly free from page_pool.

netif_get_rxqueue() gives you a pointer the netstack queue, not the driver
one. Then you take the xdp_rxq from there. Do we even register memory
model for these queues? Or am I missing something here.

We're in generic XDP hook where driver specifics should not matter here
IMHO.

> 

