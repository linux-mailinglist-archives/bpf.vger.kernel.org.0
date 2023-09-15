Return-Path: <bpf+bounces-10129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB357A13D8
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 04:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3C9281E38
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 02:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CDB81C;
	Fri, 15 Sep 2023 02:28:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7887E63F
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 02:28:55 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2100.outbound.protection.outlook.com [40.107.117.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6422134;
	Thu, 14 Sep 2023 19:28:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgZuak3pwhAxx5XlgmAt4bSqDMBmryQ6hgJ4IPhuaqK3wgqOzeCIpoT6g26wnln4ax8md/bUm0H2HSzboMHAaiw3uaRiQ1/IRiAGZvGnJgUSlFpDj1g54H/i0Y1KZz+/K+IuPStrJi2+1dVAG7IlofIhD8PydC8IgBTrzFb2DAy5qNpwIoB1XarWs50a4uKa5ge3aY4tP1Eh6LlLagWxDvIyoIfDOvseXCWKBbc+RhdK2b/ezLtYdij/NXsjsaxz8QncUAeZYyhISo4AElFqcl1skxkUciFbRrvV64oGC1GcYsCtdOvpfVvItbRHuCIWJ0uAIY62QkaY/TdFz5fj5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tG3FgS8ZSj94CF07MmpnM9xqz5bPwkFRicYItTR9sKE=;
 b=ncqfBDJ88LwTxBvTR7HLRLPDVrziNSw8PXLpOIrWRYp23tbHBxlT4phIjvtKs2s4iwe5iRsrMgG0wiWgKHEUMUNTCfw1i+S4/8H6NJzzZI+7q5RJBUfYm6uc38qPxnDsTca72M7RkoKnl04hEPq8WVK93fKjqbfQJ2pPTxD1ZaAipiFJMQe8b0U0bsp+QuiZio3aeF9J++Z0031Hr8ByukLOdaEzCNdTXjzkWa3VT1mqM6VVIrPwgty3ngDrxbv9ZNO+ZaE4O5YQ3pdAnWfLW2qCvlfcnEPHEvUPoigiGX7DFakJDd+nB6TV55hPv8nMwf4oLMd8NEOiiju2juE6YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tG3FgS8ZSj94CF07MmpnM9xqz5bPwkFRicYItTR9sKE=;
 b=mgm7HPvJd7LQlG7Hn5uHtV7sz4CNpD3+Ai7G/YJ8mFxC+qwKhzGenPDoP1xJag63DcIhWrPyfEoreYz/mbGpKr09hLyO81bJz8sDEq5nrojzBHdlVv2eGNZOpqw9GVhxmEmceuqB2D1J6oVzM+beD0+ENBgNVhqYEFnL+iOSY9trkR3NmKLWfOpai7Zi47C9hMQEQmqjUgxtTh8qpZyjPSoAvZvLSefL5Jv55ULVurpKW1gwFN74dBtDkfjKqoO8bgp1F6Q+74kcT6MwTTyMzna54bY8jNjVBKBSDTr3TxAytsUvyyJNWslrcSa0/kS4RYpAmqosyxoesVlTHWGc6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by SEYPR06MB5468.apcprd06.prod.outlook.com (2603:1096:101:b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 02:28:47 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::1c25:781c:9638:960d]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::1c25:781c:9638:960d%7]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 02:28:47 +0000
Message-ID: <9f6b8aaa-50b1-435b-a525-9a7986f63845@vivo.com>
Date: Fri, 15 Sep 2023 10:28:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [RFC PATCH v2 2/5] mm: Add policy_name to identify
 OOM policies
To: Chuyi Zhou <zhouchuyi@bytedance.com>, Jonathan Corbet <corbet@lwn.net>,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 muchun.song@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-3-zhouchuyi@bytedance.com>
 <87h6p1uz3w.fsf@meer.lwn.net> <5343d12a-630c-4d54-91f1-7a7d08326840@vivo.com>
 <89295904-3afa-4c8f-ccdb-1d78d9ad3024@bytedance.com>
From: Bixuan Cui <cuibixuan@vivo.com>
In-Reply-To: <89295904-3afa-4c8f-ccdb-1d78d9ad3024@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) To
 TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4045:EE_|SEYPR06MB5468:EE_
X-MS-Office365-Filtering-Correlation-Id: 57228ad4-8236-48b9-16ca-08dbb5937d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BMnDw7CKa2iXuOcti57vAjajbs/tHCN/P7YJANKU5E9rG6sovaSdln0oL1vlVXHNnoBzQxK+ErsdwtOvRi6h5vA81nQIvutgjgccJIBHwDszdq/Dfd+PuJbbAYzX7jSxvMWHhTsLzqHWRynUmg/VJyWGFG66FVElYFuH41pzOoaRrVRenIy7oK011r9klxllfuJPVmCmA1eLSPAz2QwQ2bYIqXngQn/2/vDx+P8Kx3o2o6fDknQW0CgvmGprKW0qGvlGXNfxVch3emTwoXZQVPQt90nTshYDVrWQVaVpMo1UsphxXt9bwe6CIz6RRAvtlxhzm7doUrxZYPRl/3fDNzh+UPhIs8KnipfM5Jjyq02rycB/JXl/9sag2X6i1AIp+QexnrB9WYiGVE57TD3tmic4yZGLVw8LJHTunS/K2qZCiGganzGWBvD1KArYTvp+1ECrbudPy+KL8AAJLrZmkK4CPIBr5RBHAcxI2AGDOqbNOtgKbegNUPuYnLNF6g0rQDlgzRqlMJbYp1vGelfhHDTMJLeNMZ7Dw/1bguOASvi56W2Zkjbo0b4qWiVn3z67OGurcAzkWr/pzOpw1q+cDykv/JRB4ox/vBsRGC4tBNpPzAzlokRpA91Egx4uP1huNtxqLhSp1Ol0BATds9mBb5UbxHegBxO728E/I82mXdDnJ9kgh1f9o4eu55k2oKeL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(136003)(346002)(1800799009)(186009)(451199024)(6512007)(6486002)(6506007)(6666004)(52116002)(83380400001)(38350700002)(38100700002)(86362001)(31696002)(36756003)(26005)(2616005)(4326008)(4744005)(7416002)(8676002)(2906002)(41300700001)(5660300002)(316002)(66556008)(66476007)(66946007)(31686004)(478600001)(110136005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTJWMTYyV0pHVExnSnpSQjFzNkNaUGMrSlVobzBSL2pYMUtrbmVFMkRiSWNV?=
 =?utf-8?B?cDJEY2wvWit4M3JQWkJzdjRQTVdkcVFVMVNOSUkvYjhqUnpzQlU2cHhrRzZH?=
 =?utf-8?B?OEFtbWtaSGhncnBHbjlhK0c0TlcyQlM0OHJtdU5DUXp4Q0d2NVMrZ240V09Q?=
 =?utf-8?B?MUthQy9FTXJHZngrcnEyaVBZaENVd0VDaWwrY0tGY0xNUlJRcTlSRmxNelc3?=
 =?utf-8?B?R2JTNFFLSzE5VW82ajlzaXF4RDIwcjlQOURubnpNMjhtenlrOFRPY2tKb2pZ?=
 =?utf-8?B?V1pqRFJmMUQraHhzNXNSczN3TjI5dWlFWEhPU1hmZ3NxeVh0M1Bhajk0REp0?=
 =?utf-8?B?OTB3TFlKQzRDVm9jcGc3ZmdESk4wQ0gyZjdETjNPVkFGL3JRdktSVHZ5QzJs?=
 =?utf-8?B?OVNub1NwVlN6MFRkeGJ1cXdNVGNIa2UyR2FvMlVHVElDa2JvZTJsZ0FRa1NC?=
 =?utf-8?B?K3NDT0s2UHhsbEVDNTdtWFZFZjZUNWpTdzNZS051eE9td21KcGFoOU0vQXVQ?=
 =?utf-8?B?TXpKSWNUMzd6bkVQU0w1VjN2WVljR2hFT0VGTnUyTmxUcXIxcDN0UURlcUhF?=
 =?utf-8?B?bDVoQktyclFkZ3lyRWJtSXNhQ0dObmlteVdZaE54a3FORlRZL1ZrSVM0clla?=
 =?utf-8?B?aEVVNkhGMXZWcitLdUN6YVJTZ2UwcUJET3ltaVc0dEZnWHljRWRZU0YvclY5?=
 =?utf-8?B?L3lVd0NRQWJDZGdEYjE0d1NhVWVQS0pMVFRkQ3p2bThCcnplK2h6M3ozcHpY?=
 =?utf-8?B?bmpMK21hNk9OMHM1Zk9OZ2cxbkRqMzQ3QWU0TXJCanZFbUVaV2JtR2p5VWpx?=
 =?utf-8?B?by9OOWZBYnRLQXVGcjBVczhNOVRaVnE2YThXemNMbmo5OHVWeElqUWxzbDNx?=
 =?utf-8?B?d2FUUTRCSlFaMjlackVOb2FmSDVCSFF4ZTlpb21OQzB0Q254NTMvSTl6QUtZ?=
 =?utf-8?B?VUdJZ0lJNkJBdE5KMXJuWGFOYzNreG9kWXN2MXZYUDV2aXErWk5SckNJalVz?=
 =?utf-8?B?OVpOd2RFaFFCTE16NEJBc1NmcjcrOTEvY3haZmVodmxaeHpQSTMwSCthb1BU?=
 =?utf-8?B?Q2QxZkx3cXRWYkxIMFNCL25UMGc2WnpoYklFWUVwUngwZnp5NE5iVHUxTW5V?=
 =?utf-8?B?TzhaQVM1VkZtMmhuL2RmOU0veHNNY2dPNDhwQTkreUdDeUpiN2Q1TGcwTEp0?=
 =?utf-8?B?SkhiU0hSYzZJSW9hMG4zVUhMUzJMZGpnSG1la0N0VDdJMmpydlJiMXAvd2lv?=
 =?utf-8?B?R3pEd0ljMmI0ZnRFdkJsdFdISjljWklTK3cxMVN1UzI2Z0JZUy81cGtLWUUz?=
 =?utf-8?B?QTFKMXF1c0pTd0YzYlBSQVpBekVHMHVkV01qVVVEZUlVdHh2a2NjNzROMitZ?=
 =?utf-8?B?N3EvZkNMMlFYTHJhdDVyTm5aLzNOUms0RmZiY0JDQ3p6VlNkclFaNjJZSDM5?=
 =?utf-8?B?cHFObHBlbHR0UlAyaWYwTHRaN1phVi9EbVRBQkw4Y1RNUjlkb2YwaC92Wm9E?=
 =?utf-8?B?ZFl5SWJvNTFBQlFtTm9LWklTT2xrWEwwb1U2WWdEZzd3UUtYUEtrdUpsV3Va?=
 =?utf-8?B?c21qUGRxVFNVaXlFZjc3bytHbUFVTklHRURHNE9tUHBsQVcyVEtkRGptOGh0?=
 =?utf-8?B?bVdKeStaZlpzMk5SZy9pSUx6a0FGdmhEVXVWcU9DV3A2NlhqZGxIMzRpYVRO?=
 =?utf-8?B?TVhpajNENmYySnNRb3FZN0gwNmNLcUFwZnJYQTQ5VDJCeVlZUmY4ZHVDYmFu?=
 =?utf-8?B?NkhsNnpGUjcwbmVCVWdUWXU2Rmh0ZEJSZ2dqbzFKKzVyVmYxV3crRG82by85?=
 =?utf-8?B?UUFKWWFLNkxoQit2SkZBZURGYVo0eU41cy9QUmZFQ1JYVUMrMXBvRWlqZWIr?=
 =?utf-8?B?TzdCRjN3OGtGMVRzcHNqb2JZRFdrMmp3WWlGQTN3Z0FTcVNTQ3dRZ1dqekFm?=
 =?utf-8?B?d201bjhWcDVGSWNUT3VoQzRxdFk5VjJjQllMd1RnSVMxZWFBU1phL2Mxa2hR?=
 =?utf-8?B?RnFIMWM1TmFZbjVzUW82bDVXd08rSTRMZlFXb1V6UEFNbnFGaGw1ZitKK1Js?=
 =?utf-8?B?VUpMaFBvN0lKNVBaQWpHYkh2TkY1c3B1eWlzRkFQOHBCZDJpNVdKK2lFVCt0?=
 =?utf-8?Q?8ysxSWJ5yj4NmwRCJPF/NhNui?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57228ad4-8236-48b9-16ca-08dbb5937d1e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 02:28:46.8980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kl8l2gvloIaj7tsUg/eBCfDOUxsfRzQoWFWoyR/PiVpharR/XcN2anb26LnKr5tYOX/RNFqcLi9ALPURQ/EKdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5468



在 2023/9/14 20:50, Chuyi Zhou 写道:
>>
>> Delete set_oom_policy_name, it makes no sense for users to set policy 
>> names. 🙂
>>
> 
> There can be multiple OOM policy in the system at the same time.
> 
> If we need to apply different OOM policies to different memcgs based on 
> different scenarios, we can use this hook(set_oom_policy_name) to set 
> name to identify which policy in invoked at that time.
> 
> Just some thoughts.
Well, I thought the system would only load one OOM policy(set one policy 
name), which would set the prio of all memcgs.

What you mean is that multiple bpf.c may be loaded at the system, and 
each bpf.c sets the different policy for different memcgs?

