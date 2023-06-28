Return-Path: <bpf+bounces-3612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F572740759
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 02:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB211C20B70
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 00:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12D01377;
	Wed, 28 Jun 2023 00:56:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935647E2;
	Wed, 28 Jun 2023 00:56:47 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DFE109;
	Tue, 27 Jun 2023 17:56:45 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S0gBMJ007719;
	Tue, 27 Jun 2023 17:56:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=IF6zuejf7PfRMpNAA7P2WszNLE4QSzYPSx7AwmDCrdk=;
 b=gochzk7X/CycU0f/hYTX7NnMK8jTo5amxSWKhUnAAbeF40RYkTaUr0+FFBc4Rh6x0r6T
 aGDjuOlyDzNuLhjX0/L1JWClxB/m6fH5127h6mm+XEtkq3gB/v8RdIy6hPu3K13uJco1
 /QGgV1HA1wi+X4VqpU1slBMTd03SRRo00pV1HzKozOGPTYef4vnCM0GR/A1yHSA0kBtL
 o2OXkLwW27Boh45w/hIQ9s4h1Rm8aW1qFPo4gaVdRb7G92p8KDa3G+CiDDVUYFqWHAA3
 hWl2o+ebf8ghDjDPzy0KNBqnYYl89NRAM+zU+Na0QVD7i3z5AZklKylDMIdQOPs2A8VY gQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rgaj582mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jun 2023 17:56:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtfaLG2RfEvFB9LayFbxWO8ORNfK3G+34ptN6DUr9Y89QOE6EgVvYNlYl12Au8lHDumnWTBHj1IKZPGNDzMEJuMEj55qDyLNZ5bl7K+dWjYSgfUbpNzc5+2F7JQbO/ITqTZ7xTkjT19lPKYDW9BkjBJaqdwU1BAc9VkqIHEOkMC499tTFjkYGM7IERAtYW9k+C19pHmdcD2aiwG0PAMZbyveODZUydPcWg5acOwAO7Tv1zXOrfcs5HK8qadFD7Mpw0ODCxvTD2Gc7koEWD6GdeAc95lGs3o18XsLxkMubioBefjjdQjYvLRx5U2krAhNXI/PN1G8p67aUaODqv6yNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IF6zuejf7PfRMpNAA7P2WszNLE4QSzYPSx7AwmDCrdk=;
 b=BAQ+biawqFKWLMuJKkmC8PS673EJ13Qzb9uP7tCcFATIxmHgP8hy/OwitBUw3Rb7Gs1BJ4gJ2qEWTLoU1e87jdsGY+kpY+Ra3lm9ZOCKs+Sw3Q/vTKDXDlpHCwUjG3+Hbi13upzrYzaxkn2xEKqjag3d3aNoLmmNrwx2MftaTzHW0koj78bcIVwmM28GT2D772NTM7INfiA5FjddOf+BsB3oE1Z1QEPFBrWwN31QluzlsRKkOrft1s/Tt3FC6YZAOkwYL6Vi0RtWGNcqivrFxlcJhx1C2TEcL2yXynlVBjiZA19RmtRWgEzOtKRvXWQcPNBkxeWUMp8BVJvAL5a9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4902.namprd15.prod.outlook.com (2603:10b6:806:1d1::12)
 by SA1PR15MB4756.namprd15.prod.outlook.com (2603:10b6:806:19f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 00:56:13 +0000
Received: from SA1PR15MB4902.namprd15.prod.outlook.com
 ([fe80::3b4a:9ff0:1438:b7a6]) by SA1PR15MB4902.namprd15.prod.outlook.com
 ([fe80::3b4a:9ff0:1438:b7a6%5]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 00:56:13 +0000
Message-ID: <3410a621-afc7-ba7b-47b8-b64e35f5a8fa@meta.com>
Date: Tue, 27 Jun 2023 17:56:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 bpf-next 12/13] bpf: Introduce bpf_mem_free_rcu()
 similar to kfree_rcu().
Content-Language: en-US
To: Hou Tao <houtao@huaweicloud.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        daniel@iogearbox.net, andrii@kernel.org, void@manifault.com,
        paulmck@kernel.org
Cc: tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
 <20230624031333.96597-13-alexei.starovoitov@gmail.com>
 <bfb3cbff-2837-156c-c240-5cf0a046ed38@huaweicloud.com>
From: Alexei Starovoitov <ast@meta.com>
In-Reply-To: <bfb3cbff-2837-156c-c240-5cf0a046ed38@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To SA1PR15MB4902.namprd15.prod.outlook.com
 (2603:10b6:806:1d1::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4902:EE_|SA1PR15MB4756:EE_
X-MS-Office365-Filtering-Correlation-Id: adc33145-f2cd-4d6c-7c9d-08db77727889
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eD5IJIEnd0nvd4AheCGAyZRM3f9MhjOkY1AOWRgnrI4Nut/dkmI1oqgVy33vgaTftoCawLJXpqo2rDUH7q9wLlN3lLz7yIbUlym5WaqfvRXiUcLrEa/QysopaUitXlvryQtODLWiNuvWgFcS7cpWOlN56i7Ccdh6kDXczOFNGb/XYs4G0c1Jf4hWHPoCrCGSvAlbP6EadU6whXQaDOgKYLPX8sBkRU78cZnDfRls7wQaU0fQ7lyhfrKuNTcVBYftFzuemwngs4Woh1fLN56xOAmtRJ2L2l9J5mkNBaucQQOUBe+IfTANuEBUydRubUwaUvlaLO4jH/VhK7XK2EAidAKNvDdnFSgsvzFo44/K8q6oZW3kRrJWgHJ3RHZgd1+k7vbqTLiZvbU8a6LLMvb/6MmMKHFVs1LqhOR4bdepgBAoyBT+kTz2XKVeHZZ1ujCp8hCqqIn89puohc/983wkK+kheBIBRmojOpLmoPkzsyTpCyelI69OGEANVsv9K1p0iWy/TwNnYGXl8uZz0CPsS5KYk8Sa5JIbndPsvm/LgCdvM1SHpbU9O4rCOKeMKdFGmqV5IrhUHu9CgM8eVkntTz70OJ2++0XvnzSgeCUxoUJaRJip7Nd0EckL3DK90DktySbwtS0FRNDCdYZf5nC2kg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4902.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199021)(2906002)(86362001)(6486002)(38100700002)(53546011)(2616005)(186003)(110136005)(41300700001)(31696002)(6512007)(4326008)(36756003)(478600001)(66476007)(66946007)(66556008)(316002)(31686004)(6506007)(7416002)(5660300002)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SVRaSWc5cmtqZG9NQ1hzeXE1d2JYTFVnNFloNER5Q0lJTEZYT09UNm8yc0ZZ?=
 =?utf-8?B?c0FSVGhXS2VPWjRTejc0NGtIeDhmNVBYalZnTytta3Ayd2M4VUFyeitzRjFR?=
 =?utf-8?B?VG9yZUdVQkxzeXR4N0xOWVFKSjAxVloyRTBjVitlZk5jMmF5MjBDV0cySVh5?=
 =?utf-8?B?VW5aM1lWMC91RVRERU5Meno4U0U4U2piamFGWVpQZk53SFVpdmpja3pDTkw1?=
 =?utf-8?B?SktReWxqOWNmNkNXTS9yekg2RlBwOXRVTkw0WkpDWnM2OFdoMVFvUmxEWkts?=
 =?utf-8?B?VkpOZ0FDUEN3ZWduN0p2MldDT21sYXgwNlg2QmZGdDNTSGoxZ3JGeHpmVldz?=
 =?utf-8?B?OHh3NVR4NmlGSXE2RithV3pGcDR4cmcvQlQzamJMY0FLVm1WUXhVVVNNdTNa?=
 =?utf-8?B?MzNQalBSbjZ1MkNlME1lNHZ2NTdjTFJRbUFIQ0RFVHdNblZKQWo2UlB6elBs?=
 =?utf-8?B?MzBWeDdJSXFCRzJ1WXM0ZUlqUDZsTXB1ZTBoVUZJRzdOYUdjQ2F6NTM1bVJU?=
 =?utf-8?B?OFVoaXF0Ti9EOWNVcmRPcDBzSjcyVUI2RmtROG5jU2xmdFRTVHZRM3lFenVQ?=
 =?utf-8?B?ZThkNjVSUStQWjFVNTlRSHFVZ3JJTXg4bXZLVWRNd2g0Nk8rOWpCTjl1NzJS?=
 =?utf-8?B?QVZ2S3RLS1BXTlNSMmZCRXRtK2IvRVdXdmExZmV4NXNzVlYrL0pzT3VjaXJM?=
 =?utf-8?B?TG1yeW40RGlqMEtzOEwyOEExTFVkanRpWTBtcmducE9JaUhZVndoRkVCcW5m?=
 =?utf-8?B?bkRyR0xZd0UwZUlmZDJRM0cyVm1KYjdWTU9aQVJrWk1RWFZQazNWM1BXcjBs?=
 =?utf-8?B?N0xxMmxQdTY1RkZkYnhwSUUyRGt5ODNqb0tlUm00MEl1SVgvYmhFL2l3UFUy?=
 =?utf-8?B?Z1Q0QjF5aEFKTDBDM0plL1hsV0g5djNXSHIxVExYMHBSclU5N200dkEyYlRY?=
 =?utf-8?B?ZXgrOGRTUmxVaHg5ZVNtYkJvYkRvdmZRRE5pS1EzZENEalUyQWREMThtdkQv?=
 =?utf-8?B?emdjOGpVb2F0M2V4elcycDlJN21jTUczQ0w4c1ArckF2Sldjd3lPS1lvNnQ0?=
 =?utf-8?B?Z1h6U3RKMURKeXdRQ3VwWGJOc2Y0VjZiYnhLaVUrYksxVDVrWXdHWmRydUda?=
 =?utf-8?B?WllRTXAwQkRmb3BnNFJtam5Wc2U5MHB6Qng2MExkcE8xT24yMjFIeXZ2eEdH?=
 =?utf-8?B?VEFlRUR5SnFScWpKTmU0cFFycVZNNkhhWnY1SENjUjIvTTV3T3RPaWNNaUsx?=
 =?utf-8?B?YzRXR0pBeTRxemNrOG81cjZsT0xSU2JURW03QldtMW5uRzU5U29GRnNncHov?=
 =?utf-8?B?My9LbmswcGdIWkdrV1o0QVpGTUxqQlJ4eG0vOTRlM3gwTGVpSGg2UUIycis4?=
 =?utf-8?B?dUNrSWRTUXBoeThSbis0V0V2dWlod2ZOaVpoaW5JQWMwc1k3alVFOEMwcjl0?=
 =?utf-8?B?d2xtNDRQNzRSQTRISWxncDlqTks0VUF0Z1JCY21kN2tpdVlBVTJZc1ZuU2RX?=
 =?utf-8?B?QWdObWZ3c0RLTU15S205NVhVVFVET1FSWWRwYllubjcxUms4dkRVR1FBQjc0?=
 =?utf-8?B?bmN2cGtzMUF1RjJWTFBLM0dCVWJoZG0vbjZyZGRtVnhWSmxrY2ZQN2hjTFhi?=
 =?utf-8?B?TWd6MU5MS2dtNVhMb0drRW0xVC9VVFpBSkQ2bW5wL2xWNEdBTFI0SnZYMGlt?=
 =?utf-8?B?YzZBem56UWl0cFBScDgvd2x4bWZXaGRZSDJ6SEVxSjE5b290WGYzRHE5REVM?=
 =?utf-8?B?SmhMUWthaE80ZWZpMExRUndTSnYxOUE1MFFRdDVvMzZLa0xJSUZtQUIxVUhr?=
 =?utf-8?B?RkVUTERSTURGYUo0dXZUbVlxcnorR1hyU2lveXdPd3BuK01LQmRpNWUvQ1Rl?=
 =?utf-8?B?ZzZlQWlZOUQxZ1V6c3hjN3ZCRUhuSCtHckdwaHJ1Z0VDQjB1bXFzWHgrS3Zt?=
 =?utf-8?B?Mkh3MVNiOWtNYjZmZG1BOFY0bGt1Q3NHMmpSR29ielpIc2YxMXY3cDVNTnRZ?=
 =?utf-8?B?azdCQWU5QTNkb293TXZsTUtJQTRqREpVbUVZYnp1cUdHTFd6czJYMGo3VmhC?=
 =?utf-8?B?bDlqUjViOUdoTVJpd0p2RmtKUFBVcDg4RmNiSW9GQ09waXhLa1F2YnAzR0Jt?=
 =?utf-8?B?Nkx6NEVNZVhtSXUyanAwTXoxTVVFVzVDQURMUHNOTVZJRzFQY2xjWnlRSU90?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc33145-f2cd-4d6c-7c9d-08db77727889
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4902.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 00:56:13.6339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvCn61LxkAUNdth4v7d6caRwxzit2iI+00mow7jMonXxH10w3DSXwJx1fWlwe6KC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4756
X-Proofpoint-GUID: XyYZxApm98G8PnAMcRJx4Ft5qTYDUmbN
X-Proofpoint-ORIG-GUID: XyYZxApm98G8PnAMcRJx4Ft5qTYDUmbN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_16,2023-06-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/25/23 4:15 AM, Hou Tao wrote:
> Hi,
> 
> On 6/24/2023 11:13 AM, Alexei Starovoitov wrote:
>> From: Alexei Starovoitov <ast@kernel.org>
>>
>> Introduce bpf_mem_[cache_]free_rcu() similar to kfree_rcu().
>> Unlike bpf_mem_[cache_]free() that links objects for immediate reuse into
>> per-cpu free list the _rcu() flavor waits for RCU grace period and then moves
>> objects into free_by_rcu_ttrace list where they are waiting for RCU
>> task trace grace period to be freed into slab.
> SNIP
>>   
>>   static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
>> @@ -498,8 +566,8 @@ static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
>>   
>>   static void free_mem_alloc(struct bpf_mem_alloc *ma)
>>   {
>> -	/* waiting_for_gp_ttrace lists was drained, but __free_rcu might
>> -	 * still execute. Wait for it now before we freeing percpu caches.
>> +	/* waiting_for_gp[_ttrace] lists were drained, but RCU callbacks
>> +	 * might still execute. Wait for them.
>>   	 *
>>   	 * rcu_barrier_tasks_trace() doesn't imply synchronize_rcu_tasks_trace(),
>>   	 * but rcu_barrier_tasks_trace() and rcu_barrier() below are only used
> I think an extra rcu_barrier() before rcu_barrier_tasks_trace() is still
> needed here, otherwise free_mem_alloc will not wait for inflight
> __free_by_rcu() and there will oops in rcu_do_batch().

Agree. I got confused by rcu_trace_implies_rcu_gp().
rcu_barrier() is necessary.

re: draining.
I'll switch to do if (draing) free_all; else call_rcu; scheme
to address potential memory leak though I wasn't able to repro it.


