Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876C0618A1F
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 22:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiKCVDv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 17:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiKCVDu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 17:03:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873C32AC2
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 14:03:49 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3KwLfb023872;
        Thu, 3 Nov 2022 14:03:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=9kuWt3FUcwIUUx2V/UL8Rv8otnQn3Ymb4yxSPw+sM6c=;
 b=Njc7JljPrqSC5WdNzKuc/ZXbfaLkOf9lV7ueTfgKgWn7/NnY3+lDA1DKgI4ZXKfXtboe
 F7qTDOjaqxVfqTStXILQBVUNUM7W07IXR2lb6/6yDFPSrzJca2gJ1GO7Lhq8/hAW+XNK
 eddiApdv9UcJyjYWS20CcoXvFwHN8DWCYKWdK4vKdjIFfTR5uePCksRZs6R2xToGC0J7
 X+RaKn1Y0BbFKfRzCzVgujd8tBXmY/eUE01bbCJnjGSPT9OVyH6FZOpouzTV68xXQ86d
 FGIjKqtq4Wt8aJc0Yoe3s/CKd/8kaIyAJzLtZyDODi3kr5Y5tI0G5dviqeos9quVfY0K Dg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kkmtv1amb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 14:03:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asjk8XF3zCyNGXS3CxrmYN4sIini6QWYpdiA/i+2bHHS2lBrV8IMjRPWRp6QPlY9Fg7kSm54XMpSfSMrum6W5R8rD+NqD4bnbC/JY0lXVx1MLdG4pM0+Xo1S72DZ6TFWfRGnDOx6RuUTcr/k2GOXTXj1Q6bcfnqOGYj+Kb2rRrZm3ijIpH2dGkCJZCy9Oy8fnOvPjo0eUgZUqBnLzzC3fCJorWOI6S3QEdwVTPhYRqlpT0Ggj6W3DqI14qkUCRr310XBGeUg3nzagz6Lh0KPHjmIJLfZMTZHTTeMrQ7gfpo6JA4PR0eIMvDdVeUKsv7JI3hWGUU51b1ShaU4MOdOtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kuWt3FUcwIUUx2V/UL8Rv8otnQn3Ymb4yxSPw+sM6c=;
 b=EEEgZ5J/UgiQ4JGzgtCwhy3a9KDpktEgzKfbc8BG1mY3Bvk3tnZYFmm9HrDtQj0/vEYa4T+fviz68JgrSs5eQxclHHIuB3GsoZ9weJGLiKzxLf/WDNQ5gpSAE3PUHEanpDYeJu6q90R6Av1VyGMgDaASY8Ig2makqHsTktfMxdZTuImCZhBESk1fwmJP+FUdHsug/R7SdcPzg372oYf6gcOsky513ETUk5ovoiX+G5QRi3zjNcNQEbsoepZqyPwFoLUGb0H9f7GpEj9pM/w97k2LawZjK/VSftkOtUyxbWXoImo4cht38r8+BzPeZfTTi/T1hLzd/OGPhCpQ27AVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4580.namprd15.prod.outlook.com (2603:10b6:806:19c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Thu, 3 Nov
 2022 21:03:32 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 21:03:32 +0000
Message-ID: <248ab614-271f-6dc4-be9d-5cc650a1f7f3@meta.com>
Date:   Thu, 3 Nov 2022 14:03:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next 3/5] bpf: Add rcu btf_type_tag verifier support
Content-Language: en-US
To:     KP Singh <kpsingh@kernel.org>, Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221103072102.2320490-1-yhs@fb.com>
 <20221103072118.2323222-1-yhs@fb.com>
 <CACYkzJ5WHDdR82wQXfE7DadO7CejXCOy7J96woYcJ=1L5F1c_g@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CACYkzJ5WHDdR82wQXfE7DadO7CejXCOy7J96woYcJ=1L5F1c_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4580:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b650419-bc1c-441e-c22f-08dabddeddaf
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IRp7R+1tX4f1Vaf+Bs7IzqKJU5NYs+fqAU1sUFAQVO/S/IKeasc1jVft8rZpkvf7D6x13WVVrnd32Ty4IF+P9zf4GcgaB++4WTsquxRFwIpEazm4z/28IAcIX26NIRlzqaltElq7+Wa2pMKsid8L9a4MAB+pD9LibjJYkDXiO2jFmLohR2ywJH8c1tjJ0M+mTe4L7SB4Ug17MbShiI1J7gy26djuZTIIAtcohDEfoRFtCfnSsJVkw6zTkV+VvulW8+d0Hg/asyirjzJ8oEjdwu8YlkO38lg+X4IZpbQniHigUoMCkH2jFxfE9UafCeVzJsKTewJQzh9VCQSHyWP4dJWGK3Eg46AOKgAMrdUVoZyb7TaU9mEt8Gvwal0TQ8IqPLbE0dGRKuYovsnNynPC7R5Ugov11TAJAaawCH3ZlXADFitGwwVhISEN8WGwLZFtxZPMvbsh84A5fFA77B1QCOc3mPrrg74HrNMF5P6njjteT3ayQjP7oFkBsoSpgiwM3JKKzbP6Jc7OpxAaXFc1JLy7L+1wusOK2lq9wLynAWeBZZdecEXJe8Hc79Q/xGrjopMoy4cXYQDE6IlaxI+e54wLtita/QeyEd6pjtXBs8A8L73yuCFmlV2hK5Y1DKrpnNG/a8T8VDCPrYTEA0jgqKDCEKMeo9HeFILSuJtWQ+RSEjQilRfYv35WXZ0lvkxEbqdegNe9rJQikizLLqr9AfdyJfyPnAHPgrvBBt2O1uTIkqyisB4Hx28bqcTDjRKqnb1EW9NAJN1zZZ2GtvV4d9loKzvpJIinDIfoeTK0Gjc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199015)(83380400001)(36756003)(31686004)(38100700002)(86362001)(31696002)(53546011)(6506007)(6666004)(66946007)(6512007)(2616005)(8676002)(110136005)(316002)(8936002)(4326008)(66476007)(54906003)(5660300002)(186003)(2906002)(6486002)(66556008)(478600001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnpPb3RWeFVULzJHTm53N0Fad1BOelhsWE5Lb1dhaUdiTGpCWjBYQVAwNS9x?=
 =?utf-8?B?dHVCbDFBMVpoL2xLS09CUTcyWk9FQnFMMnc0MnJRSUphbWxJckFGR2JKb2Q4?=
 =?utf-8?B?MW1SSXl3TlVvaE9HSVE5SlZKVml3dW9vY1QxVmEzaEVEcHFmVzZGS25qQXpZ?=
 =?utf-8?B?c0lpaitaV1lJK1NRRTEzajVhMHZ0YkhRN0VzSWtVcUFaVzlZWjQ1c2g1NGNw?=
 =?utf-8?B?RVY5ZHJkZGdkUUM0MWg5dldKckxqSnIzaXJVRUY4U2dLWGM0VWh6a2VlQTgr?=
 =?utf-8?B?RVp4djc0YkV2MURCck5WWG40UzdKUTRkUXFCZnpKME5XcVdGZjdVRjVyUGdh?=
 =?utf-8?B?djhjL0RVRzZiZDFXeEpuS2dHcTdsRWFnd1YxaWFPSXk4emZVSTFkSmJOUTdP?=
 =?utf-8?B?d0NnK3g5RklDTTE1TGZCaDZydGZPZHJ5VGVoZ2d0bWJFcmdGeHhzMHlPSnJQ?=
 =?utf-8?B?MVcyT3ZmSXBSUkE0eDlvTWV5cjVWSS9OM0dlVWwvdEUvK3I1THlOTWFVVVk3?=
 =?utf-8?B?bGVXcGFiRU1FZDZmVWdiZ3dOSjRzVktNdE90ZzBHWlhtTVNGbWc1blZzMnpn?=
 =?utf-8?B?ZngvbitYbFgyV21MQk1vU1JhRjFNWDZNY2NzVGU2YVlVcnZXbUdDZ0pZYVl3?=
 =?utf-8?B?WTdUSzVnQ1h4NEROYS96SmtuTzk2MzJlcmlDcERTTWdDM3h5MjgrYjByWk41?=
 =?utf-8?B?Q2VPbUFEa2xWK2IrcnFYNkZWeFN0UlVnOG9KQVFiT1Rrdk1xaUF0V0lUdEtY?=
 =?utf-8?B?UXhsdHpaMWd4NXZGSHM1OTREWDNTZHdaWCtIRG1qSmZTNGhvcm5OQXliWU1W?=
 =?utf-8?B?VCtPVVF6VFJyNEpqMjlzakxMQVlCd25UYURkZk9PbEhOOXRuUmgxMzEyM2VG?=
 =?utf-8?B?Q1FhOW1KYXd6Mk1Idk1UTENsUTNWNVRpa2hLeUVjWVpxUVBZZmpXL0loS0JB?=
 =?utf-8?B?WFMrMm5xNDRxTExCMjMyWStoOElJRU9sYmQrYXBCd3hBdGMzUkRwZDBDdzZZ?=
 =?utf-8?B?RkVnMTUrY0wrZnBXWVc1K00wcGtIejhFOGhORmRubDF3S3hpNXNCVE5kdzln?=
 =?utf-8?B?YVZhK2liZEV6eHlwMDhDeVd1Z1NqQUhnamYvSEJ6QmlMQUQ1akdWWXUrZlpL?=
 =?utf-8?B?WWZGL0hSbWhKRTN5ZWd6WGlwaHFSeHlSUlIzYmtMNHRYWkdhNnVWSURFR2xO?=
 =?utf-8?B?UjBMbnpyc2lyUjVscmY0N1pOcmZrL1RaU24veHNIRGpwbXNFdkFIMmtEbEZn?=
 =?utf-8?B?cmxoVEJ1d1RWS1VsMWxwdWNUSlgxVnNuUzAvSkZlWmhMK3BmSmtBQmJqR00v?=
 =?utf-8?B?L0dUc291QWpGMGEwMUYvZDJhMmhFaDY2MERJdXlORnRWU3pmV2NDaFQ0ZEtw?=
 =?utf-8?B?NGZQSUdMTG9SdDZjOXFwejloakJaVTNPMFEvWUdUT1NjNjJsc1V3UzZVUStE?=
 =?utf-8?B?elpqeE8yZ3ZaZmNxWjJNc0twSG9lbEx2L1JDRkVSK3VaS0N2OHl4SWNFLzV5?=
 =?utf-8?B?WkZoNkpaM1JmbXU1UzNOT3FuZnF5eEFZOXQvQ2VaeHBKN0tNYy9QRGtKVTFv?=
 =?utf-8?B?V1pzSkEvMkZLL0JmampwUVlTSlVZNEFBYzc1dTF1dWp5aGtUaFVRZTFpMC9m?=
 =?utf-8?B?NVZKVUtpWCthZ0JTNDBoaXpnS3UxZlQxODZFYkNvV0labnBDS1ZhRGF4bVBW?=
 =?utf-8?B?USt6b2MrbHdhQ2YwN2Y1VmtJbHpWWEpMZW0zOXFEZmM3UnpWbXk4alpvcVlK?=
 =?utf-8?B?SzMvLzR1ZmZiN2pGUERMazhReUJRNEp3WVU1ZUdOUEhBaTNyQytTR01nWERS?=
 =?utf-8?B?djdXUDRYdytFZ3NpZ0RwOEw5bjFHa25MUlBiWTluZWFQeVkvYk1JNlV5b3hQ?=
 =?utf-8?B?NktYOUM0WEhRSUFLa2Qza1dZMFJIT0xZUnhiZVE5YXlVRmMzbXpxMjRRK3hh?=
 =?utf-8?B?bW94MDVwcVUveHg1SlR5S25lSFdWdE1sY2xPLzVacjBpa1RnL3hKN3pMRHZj?=
 =?utf-8?B?QWFYV2Z3MzhHRmpGZnJMUUtRcEZZaHJiN2JUSnNLN0Q3ZktNbkdCZ1hZL2xD?=
 =?utf-8?B?dFZHQ1Z6ZXpDNkd5L3dlRFQ5Nk4xaTIrbWRsN2dyOHN2RlkzU0tvS3VqamRj?=
 =?utf-8?B?SGcwcGN1cXlRZmVVT3FKVEZlTmMyaEIwOUEySnVFR2F4K2hicXR0VWtXWGE2?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b650419-bc1c-441e-c22f-08dabddeddaf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 21:03:32.7268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlqNCkqhPtekikQgSoRV7P25HzulwYhR+DDcTaD1tr2/GRkYMtyhntJKj0H6fi7b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4580
X-Proofpoint-ORIG-GUID: eMkKViwgEfTN22ZVmVrzOef_3bvdUhDb
X-Proofpoint-GUID: eMkKViwgEfTN22ZVmVrzOef_3bvdUhDb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/3/22 7:43 AM, KP Singh wrote:
> On Thu, Nov 3, 2022 at 8:21 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> A new bpf_type_flag MEM_RCU is added to indicate a PTR_TO_BTF_ID
>> object access needing rcu_read_lock protection. The rcu protection
>> is not needed for non-sleepable program. So various verification
>> checking is only done for sleepable programs. In particular, only
>> the following insns can be inside bpf_rcu_read_lock() region:
>>    - any non call insns except BPF_ABS/BPF_IND
>>    - non sleepable helpers and kfuncs.
>> Also, bpf_*_storage_get() helper's 5th hidden argument (for memory
>> allocation flag) should be GFP_ATOMIC.
>>
>> If a pointer (PTR_TO_BTF_ID) is marked as rcu, then any use of
>> this pointer and the load which gets this pointer needs to be
>> protected by bpf_rcu_read_lock(). The following shows a couple
>> of examples:
>>    struct task_struct {
>>          ...
>>          struct task_struct __rcu        *real_parent;
>>          struct css_set __rcu            *cgroups;
>>          ...
>>    };
>>    struct css_set {
>>          ...
>>          struct cgroup *dfl_cgrp;
>>          ...
>>    }
>>    ...
>>    task = bpf_get_current_task_btf();
>>    cgroups = task->cgroups;
>>    dfl_cgroup = cgroups->dfl_cgrp;
>>    ... using dfl_cgroup ...
>>
>> The bpf_rcu_read_lock/unlock() should be added like below to
>> avoid verification failures.
>>    task = bpf_get_current_task_btf();
>>    bpf_rcu_read_lock();
>>    cgroups = task->cgroups;
>>    dfl_cgroup = cgroups->dfl_cgrp;
>>    bpf_rcu_read_unlock();
>>    ... using dfl_cgroup ...
>>
>> The following is another example for task->real_parent.
>>    task = bpf_get_current_task_btf();
>>    bpf_rcu_read_lock();
>>    real_parent = task->real_parent;
>>    ... bpf_task_storage_get(&map, real_parent, 0, 0);
>>    bpf_rcu_read_unlock();
>>
>> There is another case observed in selftest bpf_iter_ipv6_route.c:
>>    struct fib6_info *rt = ctx->rt;
>>    ...
>>    fib6_nh = &rt->fib6_nh[0]; // Not rcu protected
>>    ...
>>    if (rt->nh)
>>      fib6_nh = &nh->nh_info->fib6_nh; // rcu protected
>>    ...
>>    ... using fib6_nh ...
>> Currently verification will fail with
>>    same insn cannot be used with different pointers
>> since the use of fib6_nh is tag with rcu in one path
>> but not in the other path. The above use case is a valid
>> one so the verifier is changed to ignore MEM_RCU type tag
>> in such cases.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/linux/bpf.h          |   3 +
>>   include/linux/bpf_verifier.h |   1 +
>>   kernel/bpf/btf.c             |  11 +++
>>   kernel/bpf/verifier.c        | 126 ++++++++++++++++++++++++++++++++---
>>   4 files changed, 133 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index a9bda4c91fc7..f0d973c8d227 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -458,6 +458,9 @@ enum bpf_type_flag {
>>          /* Size is known at compile time. */
>>          MEM_FIXED_SIZE          = BIT(10 + BPF_BASE_TYPE_BITS),
>>
>> +       /* MEM is tagged with rcu and memory access needs rcu_read_lock protection. */
>> +       MEM_RCU                 = BIT(11 + BPF_BASE_TYPE_BITS),
>> +
>>          __BPF_TYPE_FLAG_MAX,
>>          __BPF_TYPE_LAST_FLAG    = __BPF_TYPE_FLAG_MAX - 1,
>>   };
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 1a32baa78ce2..d4e56f5a4b20 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -324,6 +324,7 @@ struct bpf_verifier_state {
>>          u32 insn_idx;
>>          u32 curframe;
>>          u32 active_spin_lock;
>> +       u32 active_rcu_lock;
>>          bool speculative;
>>
>>          /* first and last insn idx of this verifier state */
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 35c07afac924..293d224a7f53 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -5527,6 +5527,8 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>>                          info->reg_type |= MEM_USER;
>>                  if (strcmp(tag_value, "percpu") == 0)
>>                          info->reg_type |= MEM_PERCPU;
>> +               if (strcmp(tag_value, "rcu") == 0)
>> +                       info->reg_type |= MEM_RCU;
>>          }
>>
>>          /* skip modifiers */
>> @@ -5765,6 +5767,9 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
>>                                  /* check __percpu tag */
>>                                  if (strcmp(tag_value, "percpu") == 0)
>>                                          tmp_flag = MEM_PERCPU;
>> +                               /* check __rcu tag */
>> +                               if (strcmp(tag_value, "rcu") == 0)
>> +                                       tmp_flag = MEM_RCU;
>>                          }
>>
>>                          stype = btf_type_skip_modifiers(btf, mtype->type, &id);
>> @@ -6560,6 +6565,12 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>>                  return -EINVAL;
>>          }
>>
>> +       if (sleepable && env->cur_state->active_rcu_lock) {
>> +               bpf_log(log, "kernel function %s is sleepable within rcu_read_lock region\n",
>> +                       func_name);
>> +               return -EINVAL;
>> +       }
>> +
>>          if (kfunc_meta && ref_obj_id)
>>                  kfunc_meta->ref_obj_id = ref_obj_id;
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 82c07fe0bfb1..3c5afd3bc216 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -188,6 +188,9 @@ struct bpf_verifier_stack_elem {
>>                                            POISON_POINTER_DELTA))
>>   #define BPF_MAP_PTR(X)         ((struct bpf_map *)((X) & ~BPF_MAP_PTR_UNPRIV))
>>
>> +/* Using insn->off = BPF_STORAGE_GET_CALL to mark bpf_*_storage_get() helper calls. */
>> +#define BPF_STORAGE_GET_CALL   1
>> +
>>   static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx);
>>   static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
>>
>> @@ -511,6 +514,22 @@ static bool is_dynptr_ref_function(enum bpf_func_id func_id)
>>          return func_id == BPF_FUNC_dynptr_data;
>>   }
>>
>> +static bool is_storage_get_function(enum bpf_func_id func_id)
>> +{
>> +       return func_id == BPF_FUNC_sk_storage_get ||
>> +              func_id == BPF_FUNC_inode_storage_get ||
>> +              func_id == BPF_FUNC_task_storage_get ||
>> +              func_id == BPF_FUNC_cgrp_storage_get;
>> +}
>> +
>> +static bool is_sleepable_function(enum bpf_func_id func_id)
>> +{
>> +       return func_id == BPF_FUNC_copy_from_user ||
>> +              func_id == BPF_FUNC_copy_from_user_task ||
>> +              func_id == BPF_FUNC_ima_inode_hash ||
>> +              func_id == BPF_FUNC_ima_file_hash;
>> +}
> 
> This is a bit concerning that these are in two different places in the kernel.
> We expose a helper based on prog->aux->sleepable in different places and
> it's worth doing some refactoring to keep all this logic in a single place.

Okay, let me do a restructing to have a central place to check
helpers for sleepable program only.

> 
>> +
>>   static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
>>                                          const struct bpf_map *map)
>>   {
>> @@ -583,6 +602,8 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
>>                  strncpy(prefix, "percpu_", 32);
>>          if (type & PTR_UNTRUSTED)
>>                  strncpy(prefix, "untrusted_", 32);
>> +       if (type & MEM_RCU)
>> +               strncpy(prefix, "rcu_", 32);
[...]
>>
>> -               if (insn->imm == BPF_FUNC_task_storage_get ||
>> -                   insn->imm == BPF_FUNC_sk_storage_get ||
>> -                   insn->imm == BPF_FUNC_inode_storage_get ||
>> -                   insn->imm == BPF_FUNC_cgrp_storage_get) {
>> -                       if (env->prog->aux->sleepable)
>> +               if (is_storage_get_function(insn->imm)) {
>> +                       if (env->prog->aux->sleepable && insn->off) {
> 
> I would recommend explicitly checking if insn->off == BPF_STORAGE_GET_CALL.
> 
> Also, your comment says you are marking BPF_STORAGE_GET_CALL but this is only
> set when the call is in a classical RCU critical section and in a
> sleepable program. The
> The name and the comment above should reflect that.
> 
> BPF_STORAGE_GET_CALL_ATOMIC or something.

BPF_STORAGE_GET_CALL_ATOMIC sounds okay. Will use it unless I can come
up with a better name.

> 
> 
>> +                               insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
>> +                               insn->off = 0;
>> +                       } else if (env->prog->aux->sleepable)
>>                                  insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_KERNEL);
>>                          else
>>                                  insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
>> --
>> 2.30.2
>>
