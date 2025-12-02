Return-Path: <bpf+bounces-75868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B20D8C9ADAE
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 10:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB30C4E389B
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 09:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FEB30C359;
	Tue,  2 Dec 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FOFvw34f"
X-Original-To: bpf@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE99E3064BF;
	Tue,  2 Dec 2025 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764667769; cv=fail; b=g/MnuGJdQW86GJZJstHukLjSp7O/qDB9NaFUInUzyBqT+yWtjqpSjhBdgJNsbyMpCqbsxFezRDwwxd7yOyAUZ6bTJJKhOk8l8U8epX2yCuIC08xjD8deWfBhnGLSDmHXBwM3BPS0CdIev/4hGL04+qcPCzdri8ZwSiO4DDY2umg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764667769; c=relaxed/simple;
	bh=sLsFcyRlpb9Q4wZ2aa8KUR/loYbZ16XVq8y967sU+kY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BWFpb9eaOv1cskSEJhdvuTACy2VV8XUTWdVXWXdZ+kXTq+5zO82iWLqWgQuQfomeCTjfEGgLlDeVJdUxjdBT4GSBFEi7capZ+VWF5lLzeyhtF0mm6tUhpo8Z6F/2luePq/gZ65cLap+DXCkytzabALTJ3iEam+8SfPY0H5+xkIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FOFvw34f; arc=fail smtp.client-ip=52.101.62.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xI5sB65HYafI1sS0Qx8Z/1w71JSBv0KYf6itbELbLyzYNKvDe/4ZcWKnBJ78OtVMZKqrMuZs1V9drKdMTsbe23pdA4r+P6/MBoyh+EwDl3waxKcwdFy55hm++nY6DhdbqsLdUs77eGqfAPDypft8jXHAv5JqqA5cmn8C3mqse3bNXuMWwuvvRv3Ob7JPJ0LAFkWRL6rIHC0CxCpxwG8ksEvqPNjDE5Q7CMZ3k6NNmxz8Fk79phanPt7OkwlpkYs00kMYxZV1HouvarOgpi2qiEU5aVG+RvKN9qmWGrYKLjPXEAcityvZ0jusTjTFkdTX+Hac+0EZ8Kp7znaDJmN3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDsIJN8ZzJ07daYdj4rQi0fd10dSg0bdW0NC3Qa3N/o=;
 b=xfmugwUFWhBGLPEthLBFsjXWVsv4kQuKC8vm4M64GKTKc6Pqo5Qsk6ZYyncuhX7+t0qTapofLKvrQxlmxZ77KkATXlR3W4w1Gra3xwQNkU+zdtDdARraupEUB6+S2AcUV00x7BBs8VjZfyygWpxfdf4A/L5DmAPCQtWdyR/3nsSwD1kHloSQ4e+vKlVoR5NddZt6QPUW3Fg68oE7LsOjbPt2UepRPyMopfkmh2ig99l6obZJ9CIrmi4shPKMUMNR0Yow/89Aclo4SUKWhIlAv/FS6oUyG5vFPcTWYVOYxC+dEagbcWaEtdjJT2dpUyOtQZ7zl6GRxYAq3nQ5YWI/vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDsIJN8ZzJ07daYdj4rQi0fd10dSg0bdW0NC3Qa3N/o=;
 b=FOFvw34fVh8uTWhIOOaH2ikyfzWNIb60e45k+K/9jZ+d0kfyVAKDjHN45gnxagjpA48VF8GFARWS9zN4uzwIoEAt1X56vWIIh0XIWHPTbda83FqOco+NZuImR8XSR8bMmNmtIS+RYzKOzMDaF97XtrjN+knH3/6OBBAl8cXlYhIAdOdIlOEL59w5ntnp4Oh8t7amJwaqIjlvp1rQmYJ9Jk1mTiV0JeZUiNwWNguFJweai1wD0pvl26aeJoyjNolQ53yBSsbB9GDkNQu7ge56hMoTNs6Yd0jDYVBjZLLuJA4unPNiCTrBQkctW9G1972feFGLRUUutvHxXTMTBQ4Vcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 09:29:25 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 09:29:25 +0000
Message-ID: <be021cb8-9bff-4bfc-bc79-c84cbb3f4c4e@nvidia.com>
Date: Tue, 2 Dec 2025 09:29:17 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] mm/slab: introduce kvfree_rcu_barrier_on_cache() for
 cache destruction
To: Harry Yoo <harry.yoo@oracle.com>, surenb@google.com
Cc: Liam.Howlett@oracle.com, atomlin@atomlin.com, bpf@vger.kernel.org,
 cl@gentwo.org, da.gomez@kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org, lucas.demarchi@intel.com,
 maple-tree@lists.infradead.org, mcgrof@kernel.org, petr.pavlu@suse.com,
 rcu@vger.kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
 samitolvanen@google.com, sidhartha.kumar@oracle.com, urezki@gmail.com,
 vbabka@suse.cz, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <CAJuCfpFTMQD6oyR_Q1ds7XL4Km7h2mmzSv4z7f5fFnQ14=+g_A@mail.gmail.com>
 <20251128113740.90129-1-harry.yoo@oracle.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251128113740.90129-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0362.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::7) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CH2PR12MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: df000f26-4db2-48f0-3c3c-08de3185486a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWNiUXlmSXhZU0tVaG95eTgwYlBMb3hCVVZVTld3QWgrVTdaclVUQUF5ajl5?=
 =?utf-8?B?YVgyK2wvVE1kZHlSQS9TM1lmUTM5NFdrTzU2djBBMzVkRTRoWWM1RUYxVS9X?=
 =?utf-8?B?M1VUVU9YU0VXaWQ0RHB1cityVU1iOFdETjFyT1RqMEZOSmZBNTdVR3NacVNz?=
 =?utf-8?B?OFU4UWg3Nld4em9KQ3Q0K0pSR3NFa2NIRElseGZiZHRUaWNVenlmYlE4Y3Rq?=
 =?utf-8?B?YUVwdS9LKzdqR3hCWEwrdWorcDNoY1Rib1pTZWlBelFKNXJDOUxNWW91clpO?=
 =?utf-8?B?TUpKM05DNFEwc2UrS3BKVFZ2TkRONG5wMitacE1uWTZhT3VHbkJOWEUvOFd1?=
 =?utf-8?B?VXZLYm9XQ3pIZ3Z2SVBoRjgxbHhlY0VTb2RUbkdMdkZ2Vm5CYVk0Rkgra1h1?=
 =?utf-8?B?ZmprbWhkellLM1A5YmFKempXUlJTK0x1Vm5ZRk1nbSt5Sk43Sjg2YmNzRFpD?=
 =?utf-8?B?c3JRMk53MTBWQmlGeXYrNmx3a1JYSk44Y05DSDFUYWk3Q0dRcFFNcGFSK25a?=
 =?utf-8?B?MHV4R1RtZ2FwdVFBKzZjMmQvTlFsZFZ1U2lFKzlSWDlDMmFwc3lsNDJGN01J?=
 =?utf-8?B?d0VLM3BheGd4SnhlRlMyK0JUMWo3TnlZd1JKb2Y4RzZoeG1rc3NMVlJ1TE9i?=
 =?utf-8?B?cWYxbTZNLzlTUnFDckFGSTgvMzd1MFp4NThHbi9mVjJqY0Y3eVZsZyt6c1hj?=
 =?utf-8?B?dzh4SHBnYVFjczhySTU2MGVSV3BXMlk3YjFsT0tGL2FlOU5DblF6OEZtM0VN?=
 =?utf-8?B?RUQ0YmN2b1FOem1YRzdwd2ZaL1g2Wm1hN2lhRFV4ak5IQi8yTXpzOEQwZng5?=
 =?utf-8?B?ZUFCdzRreXAvdzc5TlFMb1lSUVZZNGxQTTZQdkZCZGd3OEZDcFN0YlJZa1ll?=
 =?utf-8?B?eHJMd2pUSFlBSmFsVkFwUDFNYTNFckFmbDhXWjFaQ1JUM3RraHNnUlJZYkNM?=
 =?utf-8?B?dTZPUFpmSzFrajBnemVWTWx4Ykhtc0p1blZCczlVNncyZDN2TTh6TjhXMU1N?=
 =?utf-8?B?TDVEVWdiekROTE9neEZBNUMvUFU1NjUxSGZtd2lrT0Eyd1VQNlI4bFd2Y0xW?=
 =?utf-8?B?N1BUUDRIN2xsYnFoREllZ3FIU285eXFVTVp5NWExRUlLL29oRGlCaS9DaVgv?=
 =?utf-8?B?V1MrVEVQTW1HR1BBUCtacW1GalYxbkxyWVdJUTVDYTZjUXhsYW9GUWdFRXdn?=
 =?utf-8?B?d0h3N3Z0eGZQaDZVVXQzckFLZEx3TmdCK2x5aWxzd0VVQTRqTWJ0bUVDOFBP?=
 =?utf-8?B?SDhYTjk1NWRvUnZXOTJ5cS9rTlVkNlRuMWJ1N1orWjVNMUo0QS9QdFVoRG9w?=
 =?utf-8?B?R3RJYXh2NzBHcU1xUWtmb1A4MXJweW9ST0o1dy80NzMvb3lieFhnYVlXMmZq?=
 =?utf-8?B?a0IzYlp5aTFkblhZV2FkTjkrK2R0T1QzNThKN3dSeHM0VElwY2Z0cXVwRXVP?=
 =?utf-8?B?V1BBUmR3VUhKL20wV3lqUTk3aSsvS1RJemhXK2tLN1hTVmZZelkzRENMSDRl?=
 =?utf-8?B?bmp3QnFCYmxnS1BZV3lRTlhYT05qNHIxVzBKWXJpWXZhWVNzU2cxcjNtSFlK?=
 =?utf-8?B?eUt3Y01mNXpiWmJLV2o2SHNla2lIRDMrK0t2a2UvSW1mZzAwUHRUVGd1eDhx?=
 =?utf-8?B?VEFpUjJFSUtsYWpXci9mZFE1ajVRR2p6RzBHZUUrRDNwcjFyTjJrTkZnOTAr?=
 =?utf-8?B?NURiQWV3VUZPTlNhQjVJNllPOFRDWXhpMUVvTUNTVU15eEdnWGFBWktWYUw5?=
 =?utf-8?B?UHU2enkrMW5heE55MGhDNCtJU2JMdVRJOWhBeWpPWFNoY3dtTy9ybEhPZWRH?=
 =?utf-8?B?YmhjeUtaQU5OTXV4cnJ1eVlSNlQvZXQxVWp5ZnlKMENGeW16N2lVMElsYzR0?=
 =?utf-8?B?czUwMW10dnhmUlI5cStzU2NST2RhdHpDN0tQSnBaa1ZTelZTTDZIWllJVnVx?=
 =?utf-8?B?cWxQamo5UWlPZEI0WFYxKyt5My9zSlp6YmtoeHVkU2ZhL2crbldFRTJnSUZo?=
 =?utf-8?B?ZDhLbDJod2hnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODc5TmswMm5nUlIrOGN6V0l4OGgzMUpTVTB2MkZ3Vk5NaG1kZGhhWVA1NlVD?=
 =?utf-8?B?WXRpbUhSRitMWHZKWVRiRHoyWmV0OG1iZE8xNnVhZEI0b3Q4L0x6ODRRc3lC?=
 =?utf-8?B?TkhZNVFvLzMxd0pRTDczck53aXpzOFhnNE4vdTdXT1VsZjhHUUdsWWwwYmlZ?=
 =?utf-8?B?bmJRQVdjdi9GVnA4V0JXS1FIekg3ZUtzTzl0TnVZV1BDeDZSMDV1TUdtZXE1?=
 =?utf-8?B?U2l5bjN1YVdZWkZ1d3Y0Y0FDYmRkckNIaDlqd0xaVXRrK29LMGp0QVZmakJC?=
 =?utf-8?B?Y1d3c0gycUhLK2RUMDg0VDlVb1RyTW1DeCt6QmRZOWlmWVNzcUhkL2hia3Uz?=
 =?utf-8?B?dGRneVJYMHplOUg3SklyeHVET3F1R25IMjBsUjQwOTI1ZnZrVDBqZjlEaVhp?=
 =?utf-8?B?SFc2RnhORXpJNVhWMkRoUHlKdm52Vkd5dzRNSUdKTDlTOC9kZEI1SXozYzJS?=
 =?utf-8?B?Y3o0Ujkydjd3ci84d1RWVTZLTFJIQms2cHdVcmZEV1JIU3dHTUN1dVloOXIv?=
 =?utf-8?B?ckFxRzVCN1VOWkxBN0Z4ZWdHOHp1M3o2d3pVSExwZCs3a3hPYnlIbnFWWmtJ?=
 =?utf-8?B?ODlveDdyelBPNTBYNm1xNk5qd1Fhd2RQMnUyeWt5UjhPSSswL1htV3JER041?=
 =?utf-8?B?L3htSWhaL1RjdEZvcllIZE8wSGdxVm5zc29XVWlwL09aeUhKbGQ2WEI1bldp?=
 =?utf-8?B?QThkUHdCak1SZEs2ZnkvK21FK0pIYitrWlh2YjR6TzVCWkJzd0hwaUVQM2NG?=
 =?utf-8?B?NURrbGdRNWFWNlpaVnFSMHJHN1hUb2FNWTAxVjhqbVQ5VVJ1YkRFNkFubFR2?=
 =?utf-8?B?L2hWOXl3b2lyQjB1SXE5b2wwRm9vWGIyZDlnaG5QWXJJQk5NWUcvWGRJY3Ez?=
 =?utf-8?B?bjA0WjRVcm1jUDNLVEtreEJVbjNyZ25iT0RucWxsRFNaK2RRMFgwQ2c3WWRn?=
 =?utf-8?B?SEF2MWtOU0hjVFpwZXk1VlhRWVhhOWczZWpBaWNoUGtmdUI0N0hsbTNVZDVx?=
 =?utf-8?B?bUFrOEQ1Qkl0YTZmWW1Ja2x6SDlKaE5YSnFFUVNIN0MyZ2c3blRjbHFpWkx4?=
 =?utf-8?B?bVZzT2xDZXYwS1lxWjI5VFJWZ0dIWTYxdWVVcUw5NTdkc0F6R1FVTWxrZXFY?=
 =?utf-8?B?aTR2Ynk2Nk05aEt5UjZJMk5IZHczUEFXSGlJaDNXek05MGJrczFTcGtjQkFF?=
 =?utf-8?B?UDJLbGFQN3dIUTdtR05wQkx0Z21HNDRFMzJmLzRPVTViL3VRTGFPM1NzVll1?=
 =?utf-8?B?K1dRR2NjVzFZWW1qVG53b2dhdkJiNzBMTVU4emQvRVJBTUpObkRSV09Idkhp?=
 =?utf-8?B?L1VBVHVnM3Q1U3VyT1dkSXJjSXFzempWR0tmaGkzM1VCb0hjTGpQMjQwQ3RF?=
 =?utf-8?B?T1F6VVhVMVAzNDltZ1N4aUlzMStaTUMyQjRhNmFiN2k2c0FsWHNNWll3S3F3?=
 =?utf-8?B?cW9oZHdJSVlXOFc2ZmpVd29udEw1ckV4Q0lDNTRNSFRQQUN4YXJ6RUNDY0c0?=
 =?utf-8?B?cmFOaTQ0TkxXNEhQNG41VTZMc0Q5eWwxNmY4SEtBOU84VVQ5ZkRQYUt4MHhD?=
 =?utf-8?B?VVRCS1VoTDRpZElia1JyOVpxVytVM0JJaU5jU3NKbkpQc3o0NHFrcGdvakVP?=
 =?utf-8?B?L08xWnZ2dkJnZmJzSXEzWktkM01zSUpzZEtsajdwa2h0OUpqaG9PbkU1aVpo?=
 =?utf-8?B?QVkzMENTMzRKTUFDajZrcVlNeDFJcFdRaEo2QmhVcXliQVlUZkZvZDRIQjZh?=
 =?utf-8?B?V1JiMXBLYU9aWCtuTFdLdElZdkpLWTdlOE12Qi92eC9DdTAweVl2eVY4N2hh?=
 =?utf-8?B?cXFBK2xHMmhuTkFKNldPNG5KbHp6ZWFwTXNnczE5Y2tQNyt1UkRKcUZDSVQ3?=
 =?utf-8?B?N2xyWGRCRGN3d3RFOEg2ZEhrR3NmY3RESmJGYmliaXNlY0FTSkg4ayt3R0xj?=
 =?utf-8?B?S1JuUHVtRU4yb2xXaDFKYTFYRnhVbGJRdVFsZ3ZkaTl0bVdjTERuVTN5UVl6?=
 =?utf-8?B?YnhscHFoc3dPMmFsd2pmdFZ0L1dzSUdxQytxT0t0cDNIcnYxdDVyT3ppNWZI?=
 =?utf-8?B?U0xUZkgyUkdjVkRxRmVRSVFGd1lkakVkcHpJNUtEcWxkVHBMWHVvSjJMQ2lw?=
 =?utf-8?Q?RdyGfpVVgra3+ICiU9U+fcTj7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df000f26-4db2-48f0-3c3c-08de3185486a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 09:29:25.0910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aaBT9G/gau8qkEyAbTanzlWyMhV3O+cb0j7+rxnqBVcUalQnRVISSzj+FpnNz1oAjsK7+MvUefrvYgVQs5h88Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520


On 28/11/2025 11:37, Harry Yoo wrote:
> Currently, kvfree_rcu_barrier() flushes RCU sheaves across all slab
> caches when a cache is destroyed. This is unnecessary when destroying
> a slab cache; only the RCU sheaves belonging to the cache being destroyed
> need to be flushed.
> 
> As suggested by Vlastimil Babka, introduce a weaker form of
> kvfree_rcu_barrier() that operates on a specific slab cache and call it
> on cache destruction.
> 
> The performance benefit is evaluated on a 12 core 24 threads AMD Ryzen
> 5900X machine (1 socket), by loading slub_kunit module.
> 
> Before:
>    Total calls: 19
>    Average latency (us): 8529
>    Total time (us): 162069
> 
> After:
>    Total calls: 19
>    Average latency (us): 3804
>    Total time (us): 72287
> 
> Link: https://lore.kernel.org/linux-mm/0406562e-2066-4cf8-9902-b2b0616dd742@kernel.org
> Link: https://lore.kernel.org/linux-mm/e988eff6-1287-425e-a06c-805af5bbf262@nvidia.com
> Link: https://lore.kernel.org/linux-mm/1bda09da-93be-4737-aef0-d47f8c5c9301@suse.cz
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---

Thanks for the rapid fix. I have been testing this and can confirm that 
this does fix the performance regression I was seeing.

BTW shouldn't we add a 'Fixes:' tag above? I would like to ensure that 
this gets picked up for v6.18 stable.

Otherwise ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic


