Return-Path: <bpf+bounces-9899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A7179E699
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 13:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372191C20ECD
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 11:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42B41E530;
	Wed, 13 Sep 2023 11:24:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE72C1E519
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 11:24:14 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2137.outbound.protection.outlook.com [40.107.117.137])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B05212E;
	Wed, 13 Sep 2023 04:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzpE5BOgqVfc+CphuMUR4kfznOz0wdd1GSmud0FqJnIjyyj55O7NHJGgyjrDbT7S8k7Bfot/uFNNWtcIfkqcPGcaoDkVjTjACdjhwp7olWaPHAzu1JUoNznPcBenK/g3QoPIfBsN2AozPvMy5ucxOtbgHS6yO6y8cQNEW7R7dYgOL5822GhbnQUo8JUWOFsZiKr8sm+fxmubsfyvmfKmG4r4XRU4wnYmrQllzvPaNreP7i7o55TubOKYy0YnZvLJaMfHv4M6vePKAaRC4dyJY7U3M5cvdz9CDgeky36z2ZJDH6EUIE2dDnuq9TKzgvUioUwyJtEgMKF8NvQO+iQ1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SW9AwQDnvesI7hVxaAL72Fj47X+CU1iH2Q9BD/kqios=;
 b=PqGy1SSlQYYSJ21ea2XWUEm1VPLblev3AUlDWzBm+waEWKma7Izb1luboMkm4ckA9jBmnrJ5LUQXzOZ28dCrX/ltb9t0Ek5y6xVlX1k+qDmSJ824r5e07y2ysyWmrSYogHoagcmYMXnPEi396RRHCSKqyJ350iUPUkySBanvKFmV4sMLKoNjCCkAHVYSdlugnIKKwGvHYM/nX8Xl3CRHSIijppkS6qMWS0VG+B2/ROgy6wmCScN9RRqusEwosoQKonFHJpPnpTlgzGgvDNXmIVzWicT0Qmjf+rw74NSX9plzK+dDnBIBx5cWuXHRtgZa+skYKcHIAOOn8OMjW/X6Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SW9AwQDnvesI7hVxaAL72Fj47X+CU1iH2Q9BD/kqios=;
 b=mSCtn50qc8se7ByJd9GFcBwu4ZCNc79QQqu/viqdJNrxY88kgm2v5Fzf4MC+KA++oSEUfUbPyvhIj9vM9SoLLnO5FVs/CL9rDVbVACLrfZcahnfACtX3Cf6smTo1G7Qj+oDYm4fRStv9972NmoCuLrpGCddW7BwKk1po9WLsImed5nsZtQeUnh+jP2BHlygZRPS/nQoIsTrXBaTRElzfhnJrR0tMi68/TQtb4/RXWtkE424oRo14uG+gnVmlDhyFkipEodX07p4zaLLm1FexDwkqrY6PpGrMJcnmRu1x3qm6lQ1SPGkhRwZjTl0jssocBZdbhKLCC+tTkmNx+y5OwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by SI2PR06MB5362.apcprd06.prod.outlook.com (2603:1096:4:1ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Wed, 13 Sep
 2023 11:24:10 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::1c25:781c:9638:960d]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::1c25:781c:9638:960d%7]) with mapi id 15.20.6768.036; Wed, 13 Sep 2023
 11:24:09 +0000
Message-ID: <cd33ccb9-9f17-4c27-b963-87bc22d4d490@vivo.com>
Date: Wed, 13 Sep 2023 19:24:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/5] mm, oom: Introduce bpf_oom_evaluate_task
To: Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, muchun.song@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 wuyun.abel@bytedance.com, robin.lu@bytedance.com,
 Michal Hocko <mhocko@suse.com>
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-2-zhouchuyi@bytedance.com>
From: Bixuan Cui <cuibixuan@vivo.com>
In-Reply-To: <20230810081319.65668-2-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR06CA0042.apcprd06.prod.outlook.com
 (2603:1096:404:2e::30) To TYZPR06MB4045.apcprd06.prod.outlook.com
 (2603:1096:400:21::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4045:EE_|SI2PR06MB5362:EE_
X-MS-Office365-Filtering-Correlation-Id: ba38ab45-a1a1-484b-bd52-08dbb44bf2f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yD//SJi414eUey/V7+JhG3z9K8HDJm0SFgQd4KPIPFtnNiHDhwrFjhQ5TPxrYDDCWIfwlb4RN974vY0XTGi1Ab/KyUZC1PTLQHEKurRm0SrFCresiFZ2T5FZZsybtiIqtOd0eU7x42CLXEQg25C6DqmZB0+qN/j4nRcQ5NdcqI+vuJayGoRyu4Zuc8kUFwm6sBmWOyh8SSonDjaVBT/Wveqmcw09z6XHQH+9zMfV6H203kU/lM3eI4TkcLCFVZ5RL77Huo01QVC+BiO+G/piVFuLwkywpv2nUMlNG6Xs9ugNHE/VMz6C05Tc6xH3dCIQ7c3/kIR3hsAswIGPxkcCoAp5jr+xedcijdKW+m93JRoAKPVj4Ju2sfLpMd7YcVuGyxF2f5p7s825j0rpN26+EPwZVeJRxUmC5ETozzcY8GL68ugEzGTUXTp0wPzjxj5AqsvO4remtXakJwsMmg12YxCwd336w0OI6uAkVaFY2SKF8RMWf8D9FTNdCtbA6qan7NvXeVuN5/DemAivDPTuaWZltPC3DwZx6UmcwJ5S8cx/NxlzkNaZW++AkijQkoeOGU1V263gZ1w8JGUODmw5FA/MwjvGT5DOnGYqZ6psXC7qYNbpDQbwWr8KO/x+a/o8I5g09znJzhmIlwMJokNm91iQKtJ4RgZ3np3kBY7c9VDiHYVIfJgsdtY/VmyNFxIv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(1800799009)(186009)(451199024)(316002)(31686004)(6486002)(52116002)(6666004)(6506007)(38100700002)(31696002)(38350700002)(86362001)(36756003)(4744005)(2906002)(26005)(6512007)(478600001)(2616005)(41300700001)(5660300002)(4326008)(8936002)(8676002)(7416002)(66946007)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3dLOGp2NFk0VExyUHBWRjFMdkFiVTNSV3FxdElWWVBUN1RiWEZzMk9FamJU?=
 =?utf-8?B?Y3l2Rml5NUozcUpQRXpTektVRDRpNHZTSXQxdUNnS3FqYm1OZ2tHYytaeXN3?=
 =?utf-8?B?UlF2YXNqdjR2SXgzS0lmNGF5b29DdURMN09zZ1h4Y2VKT2dmVzVqTGk4YW9k?=
 =?utf-8?B?bHJGL3hycWY0dmFqRC9WUGxqU0JPb251NUNEM2VJSFErVmFxZzRkL1FyUXh0?=
 =?utf-8?B?L3lPUmxxV0JwMklDQmFqVHNSdk5Qd0liRUxoa2R3OXkzeFh3bDNza0dlSE5I?=
 =?utf-8?B?aTJaQnR0OFNCcEx5OTNDRloyczVQM3VocVRIL1hKeEVBbFZaNUhDeHRSZlNh?=
 =?utf-8?B?L2FjLzBKUTEzb2lJZDc2MTVHYXNqYlNOUmNSWDRRdmh5bHB1eld5NUJsZTdi?=
 =?utf-8?B?d2VuNHFneW1FWExiUVJCY0tnd2hRb3FXd2d4UjBvTmpiTjVNaUplSjdtM1dz?=
 =?utf-8?B?RGZqN0crZ010ZjVReGNIYTRZRWl2YVFsdVc5elRubVhxc3VUUWkwakREUkUw?=
 =?utf-8?B?bUdQM1lZNlNqMkhRU1pDczB3Nnc2RGdmd2gzRW5RWUNSakcrY0tUbWdIeHdZ?=
 =?utf-8?B?WmtvaXJlTUNKVEFuME9sOGc2ZFBPM2d1cFY1Q1NFTG5ka3Z3SFViNm9Gb2FI?=
 =?utf-8?B?YldsMHBiRnFNQzIrRExSS0ZLUEZYZUs4cmlUWWc3R2Vwa0FOcytHSGd6VDlk?=
 =?utf-8?B?UURuZHYxRE85QVlDcW05M1p2cmYwaUhNbTRBVHliN2NlamZxTWxVSks5SmFV?=
 =?utf-8?B?bHRWMVVzdFNlcGNTU1dRZXRXVWUrZlBFNENQaDNnNCtVUmpIM3ROWi9MZGxQ?=
 =?utf-8?B?TGhxTDhZbUEyb0Q4RkwxS3QyUFlHY0VwNDg5cnVCeXFGUlRyMEl3cFNyWGxW?=
 =?utf-8?B?cnE3WjFRcUpqWjJDVFZlem5zUU1PMFQrTWk4U3J2Ti9oOHIrVE1OSnBOalM3?=
 =?utf-8?B?VEt3SVk0Q3FSZDJoOHV2Y0lPbnp2bTNLNDhRMDZ6TDNkeWxYYmJQYi9EaWt4?=
 =?utf-8?B?cWt2MStrQnl0YnI3eXgrSTJwTzVGUmdVN0h1b2p6Vll0eWVqTjROVmJ5aDdB?=
 =?utf-8?B?VC9xM3dwRzNaSHJYVUhjN0Q0YzU0NGtlL2F5VGxDdVVZSlN4OU9kOHZ4K09i?=
 =?utf-8?B?dmZ2QnpTRWtyVnhJQnBtZ09tTEVCN2ZWRkltdnVIRGZFOG5YOENaUEhzUDc3?=
 =?utf-8?B?ck4yQlMyRUZNZ3lXb1RoalgxN0FhUHBBTnROaXFTU0JpcjlFcWRjcGw4VHpx?=
 =?utf-8?B?Mm4wK3NlYzFYL3FFeWcxNk9HWEtteVQ2WXJMWjVJKzh0Z2dISi85aFpWbmcw?=
 =?utf-8?B?TEdXcXVDc2lVVlRvZVRNaVd0bDcvc25ZeVJZclVKb1dXU1pOaE9VbmkyT2tl?=
 =?utf-8?B?MVZkVGVWSEU3V0ExUWJyZ083ZCt3dmNDTkZSaWEzOXg1NnFKODVJZlJCQVMy?=
 =?utf-8?B?bG44TG93TTVyZ09KbzJVYkJiSldBZHBMR1QxN0x6cU9EblE5RC8xUFZoTDBL?=
 =?utf-8?B?ZGt3N3BLY3NvNkVmbUpmaHlFY3J0L294aWN3dzNocFRROEw2YVVDSmJ1K0VW?=
 =?utf-8?B?Rk53dDFmUXBiVEVlYlZ1MHVtYmlhYmpyNitzZzZ6K3pSdGJ0aGUzVkxrbmtZ?=
 =?utf-8?B?cDlJaTdMRjdETnpWWTQ1bzBSc3ZBRWpJTDdRYTVFYUlwa2lIZ1FzOFFENndt?=
 =?utf-8?B?V09Tak4vcS9oT2ozRm1Va24xS0lmRGxYQWRnZitUY2w2NjBpZGtNdFl0YW5E?=
 =?utf-8?B?dUxhU05EZkFPNDdtbUw2L2ppMER3YlpLOWlQQUZxUUhrNWFnT1dscDdFV2hw?=
 =?utf-8?B?VnRUMDdyZ1dpQXlyRUtwaFJ6UFh1ODZIcE4zeVl6RExIZ01QdWpWV1p0b0Ft?=
 =?utf-8?B?bDFldXdSNU5OQzlEYWlHYXJUb0E5SnU1alNjMSt0ZVIyQnZJd3R5ZVRlcC81?=
 =?utf-8?B?QzM5OFNTdFFHY3labVd2VEk2Q2pSK1NyZVowbjlza2FTcHJPbDAvc2k3SWNi?=
 =?utf-8?B?cTVMcGRTUW9sa1dMaFBRNlE0Mnhpa3NQQjhvTVpJYnRZbk9HS0Z0dXVJSmtw?=
 =?utf-8?B?VS9POGd1Q2NVTTUybkYrUm9GeTNlNWY3R016dHJjTmVKdDdWMGs5Nk5PN0xS?=
 =?utf-8?Q?ga1+DROGsbjCk8nDZLpTT8EOY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba38ab45-a1a1-484b-bd52-08dbb44bf2f7
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 11:24:09.6440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMZ5cmmP0ksM+HMwXqZvkcsxcT+AD8OW3JTFb328GEf/W17E1SkygWxBjwTiVuvG1exsWEy8AA1r76j7SQLD9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5362



在 2023/8/10 16:13, Chuyi Zhou 写道:
> + +__weak noinline int bpf_oom_evaluate_task(struct task_struct *task, 
> struct oom_control *oc) +{ + return NO_BPF_POLICY; +} + 
> +BTF_SET8_START(oom_bpf_fmodret_ids) +BTF_ID_FLAGS(func, 
> bpf_oom_evaluate_task) +BTF_SET8_END(oom_bpf_fmodret_ids)
I have a question here, why use __weak? Is there other modules that can 
redefine bpf_oom_evaluate_task? why not use __bpf_kfunc 
(Documentation/bpf/kfuncs.rst) ?

Thanks
Bixuan Cui

