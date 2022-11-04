Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C23E618D2F
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 01:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKDA2r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 20:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKDA2q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 20:28:46 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BCC11A10
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 17:28:43 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3NKnkI021948;
        Thu, 3 Nov 2022 17:28:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=NdjwqXY6g5GyzGauUv1qRws1Unia1B4YPieBP9kG1dM=;
 b=O3jQnOb0gZCjtV8mv1XH9TX9ReOa/ZmRwctYBB7G7IxLLawxyZh3Oc7b7DoQS0gEUR2f
 OpkKAQ0AqImg2GRiQlkmo4o+FPxaBJk0XUmYDZ4CGBVIEILXbSO/HE2DWHfX+mgvA48E
 +IthOq+YMJomr8/BX4PCz5gBunOi8YI8mtDAy6pbDHGyG8+ElFHeofMUTFgtKPed0vH3
 0Aph+fYyspr4xJYQKrwcL+Web+EAy7naQsf74AyfJfREtSl0n1I0pVVUEICVuQPiZzqo
 LVXGRTFyGi361Neoq0cvfXeLwEabUVm4sTyj1LZBsN+/FYOPps1tdcFarH/Z/Yzdcd6q Mw== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kmph58s06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 17:28:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/FuS91rApcvWj+TO7hOcJH/kwlsWe9Mcb8rkiNctONLXyqeemcThEI4FWWaRsibPBGWoPUF0aRtaOamzvFjwanqmhnqpIjI4R1B8/CVkklKdXBEfeasRVVESYUyVOUXZSkLxTYTRGInc168iZrOzL9c+eoEKy7pQin2eJTan/v4fKPdMtL9Pn/5PfowgTLapRViyRHwpMj62KJQsywEoO0LEHGjnAz07kDWFlsmWSZBpoaJeGjONyVaMxOrc9yXPCatdvZQb3x0IZp4HXVvnXdYkASWGR0O2vBQpDQ2XBc4cTsrgnzzcc4tYjJM8fY6ZByex9Zqs9RH5cpX4cvmTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdjwqXY6g5GyzGauUv1qRws1Unia1B4YPieBP9kG1dM=;
 b=jkHgPFpJkSXV5h7RInDG6FfFwDs9Jl21lN5c9mH8WSamLhM+rs5PZGoHUmQeUQ1bqyYSq1X31foqg6kIktQpFA+gOLlZzUeqwm8s/dmVRBxU+0UC7ad4CcinAPBAHC9xg7BKc3qN+1MbNFEdunSr2FD6SWNed9FDh6xwra2kZa8tFvHq8T8fo2MQ3bKaBD1lOjyXAlKIz2RJqRDb2gFRdO1rYoRRUezOESXIlKLKy2PrGKYRxGJtmtdnqwchBXPkKFJxt5UcdOg0FS1c5HS/E0dMpptzptefvtB2IdqCTyR/lzr7beVOEwI5TvlMjgf6mV8XBbmMwKYixQbErAVbZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB2278.namprd15.prod.outlook.com (2603:10b6:a02:8e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Fri, 4 Nov
 2022 00:28:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 00:28:24 +0000
Message-ID: <cfcb183e-1e4a-49ad-ed54-b416bc55a8de@meta.com>
Date:   Thu, 3 Nov 2022 17:28:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next 3/5] bpf: Add rcu btf_type_tag verifier support
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221103072102.2320490-1-yhs@fb.com>
 <20221103072118.2323222-1-yhs@fb.com>
 <20221103221715.zyegpoc3puz6oimx@apollo>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221103221715.zyegpoc3puz6oimx@apollo>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BYAPR15MB2278:EE_
X-MS-Office365-Filtering-Correlation-Id: d759f7fd-43ce-42d2-524d-08dabdfb7c1e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0WysBygqs6PQMqvpk+HTscHqdTqlAcikz5t1X460EjpEorZ2AV+3leZ7pT5KllscK6I+5KnsFF6pUewYwmUP5bSf/muDvRKwLv87a+5H11u7WoZtssWM2KqPU32P8fxdooUw6qYT6okfUFYmH86dhAalbedqhMnBAS9ADT4llRhsLu8uxzaMTG7IIRZy6ehkMLDeI+HH+GwucEQ8MEk4ByhakiZYFkbAepG5Z/mF7iqHfUdohQvstgn0Oo7BTLsTYqpftNSS1d5rVld+yUbZ9ih1YdFHE4jKPgRkB3yYEBRZSlJxbk45ZkXkMbGZIf/JKbtrQZuHRbUvoa4j/mtS7lD91h82ciW9cmuWEIR7qyorf41OxV0QeDUuDQ554CCpn29l3Bne39i5Djmt4niRCWZFBH7XhExjwrM2BTikVQDvY6prz6De7k87cQfUJJ2VeDQGPuyyvA/yx2FaLfIoMbtvhX/NoxKkSWU/GDu3Zp31TIZp9qMiX1z9LUzV4gM9lcj6W7UoHGHpX8Voyz9NJ6JqE+8Wz8M7nQoDNVjOY0n9t3i/zbkpbsZmwLphzWfcOnA8wg5YUOGWQk1wcnK7ryajw11uTfgVBbJbegsznmpAu6lfbPmWSJgC6WnF1crtCB09lat6VJnEDs738oowOUDQVTPmsQzByI8sIXTNv2hDu7cck5OqU4MVOgQdIiscRPoGvigUcgnWz63pkWU2Fy3AI1hS26lTijbrqXzlL4LkmoZpyBt94YRIr5tM8LdtmO2tprO3/bLpzawcm/6yHJ9kWFKZo9GmXz1TiX3DbV/8m+v0j7cHT4gWsGYrcyxM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199015)(86362001)(31696002)(31686004)(36756003)(53546011)(30864003)(2906002)(5660300002)(186003)(2616005)(83380400001)(38100700002)(6512007)(54906003)(110136005)(316002)(8676002)(966005)(6486002)(478600001)(66476007)(4326008)(66556008)(8936002)(41300700001)(66946007)(6666004)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXlMcjZROXhZRFhrdkdPU1A1Wll0TGx4ZVpNT3E2NXdzOGJqdklyQ1AzZnQx?=
 =?utf-8?B?QUZ6Y0U5aktCZEJmVHhlOTFua2dPTXRTSGVPYWRKamZZOVNQV2lUak5PVm1u?=
 =?utf-8?B?NitoeUtQMDNzM0NJT1ZoZEFDVlBRV3hIeHEwNEpvUHcrbXZnc2hRQ1FSSlVi?=
 =?utf-8?B?QVp4YWVyaUs4eDV6VUl1UnpDcDUzcFYwVmRZMytpQWpZcEhLeTFoNEV5cGdX?=
 =?utf-8?B?Y24rQkFwc0JML0JwRFJRdlArS0RSNytjMm9mQnlWNDlrZkFvSmpWbDU1dkh2?=
 =?utf-8?B?ZVlRRGhkaElRWndURWsvS2N3d0dSMmdCbXZxZkdnbzhrZVVZSCtIR1ZWRjRC?=
 =?utf-8?B?YXF0cllyRTZ0ME95eHhVa0FnVFJTRGVLcFYvZ1JkLzVURU5SNGtjYzF0RWxP?=
 =?utf-8?B?elJQNk9qNFhLaGtZU2NPeFN5NXdrekNQZG9QUlc2WWVhZ0lhOVBBNmtUMW82?=
 =?utf-8?B?eDA0V1JZUGx2WXRqbjBDbDEwd1ZuUlMxMndrZk5Ua29IaUNxUUwzL1JQZVdq?=
 =?utf-8?B?S1FSUFV1UVQyTXh6ZTdRazV6VVdSM1hUNWYxTWlDbjJxbnhmdWlOVVhsb3pp?=
 =?utf-8?B?OUd3c0RHdHRpd0dWNlkzSldDTVhCTGZyNUJWQVptV0xYU1dDL3FXM2NDRGtH?=
 =?utf-8?B?NFAvanpnaWhqc29oREFGWFpJZkd6UzN5VFVvWDNFbzhNWUVMQWZDekZDbTly?=
 =?utf-8?B?amJxTTBOWlhwQ0RQOW9wZlIwMVFHbGF1VzJRL2NxaUJQRXlWMVRmZk1DWENE?=
 =?utf-8?B?ejUrTXRrdXRCRUVieEVvL09DYm81K0puTVl2RmFaK28zZm4zaU5SdmJ4YmpU?=
 =?utf-8?B?UWJHZWZJTWlJRjBFeXc5ZzNFVnV6YmhNVmRkZTNPaFhsUEY5SFlZVU1vbFJl?=
 =?utf-8?B?TjJ2OGRkaGgzb3hoM1MvMEJySW1HNTBwcEZRditlMmh0cHcreGkzQ0xBWW9Q?=
 =?utf-8?B?R1FyaGQyY0dXZ3NMdTRDbU5FZ1grYVJOYWdMb0tMT3VEc3N0S3orNyt5TG9q?=
 =?utf-8?B?QTlYZjY0VTBtQVVPUllVQ3hNc1hwUEE0ak9mRnV5VVJWaFBBdjBnQytHU3NZ?=
 =?utf-8?B?MldsUkN6NjdIVHJpK1drZEh6ZnZVUDRQMmxSTVQvSkE5RTV1dXEzWEJ5SEFo?=
 =?utf-8?B?eGpUVVVVQnlFMW9JZU9OTkV5djNzUFp0YlhLR3dPY0RkVG45SGV4NHhNMFY3?=
 =?utf-8?B?UmhIYTlmcnpuTzF4RTJ6L3NoZy9sM0dHVVM3L1pXVktkQ3VHUFFXdXZ4eDlV?=
 =?utf-8?B?Nm1YWVdVYVZ3ckI4clRaTGZEbmNyWDVsTDFiTjkyUkN3eTZTSzU3QlZlaEZG?=
 =?utf-8?B?OVZuQVQxbWQwRVRvQ2hmQUhWRy9NenZ3WFFEVUQ5ZXRuT1h3SmNndUhDeTZ5?=
 =?utf-8?B?K0tqWG1yWGpHMnhUZ1VGejRPSXJlZUk5NnpMYnZnd1BlemhPTW5LazE2ci9G?=
 =?utf-8?B?OE93aEwzeW9FNkhtMGt2REROLzduL0VnUVQyNE9yRTNtYWI3d0FScVpNNXY0?=
 =?utf-8?B?aGF6L2VZUTlvMFhZcVlSbDJ5STRIdi9tUVdhYWl5YmQ0RDhSQmxSRmFtRlZX?=
 =?utf-8?B?azNoS2tKU3FqYm5tK3ZpK3NFTmt2Mi9lOXU0bmxWUGcwUUZkSDJlelk0NHlr?=
 =?utf-8?B?K0I3a1RQdTlhYzZsZnZhSSsrYmlwcDlGMUJIQlJ2MlRKWEJKYk1ESE1qVXo0?=
 =?utf-8?B?M2VrT1NVZjBQd2RKWTR0WUpPenU1VGhsZkZiT3g3MnFSM3MySTZvSTRYL3lD?=
 =?utf-8?B?NGdEcWh5RmF3WmNSWXdrSktlb0lrU0NhRzVqWEpkRTRmMEJsd0xPc3BwSjNo?=
 =?utf-8?B?OW1WWE1SZmcwZHNFUzNCQm5DaXovS1FwRWtYZ25IK25VU1dnU0ZHc1FUVVh3?=
 =?utf-8?B?OWpMcEdONUFyZmUzdUhMVEdXb1NPTVNyK010aUVLV2dwYmFURW9aK290cmxH?=
 =?utf-8?B?UDRnMnVLNFFNb0dTUjlaU24vbVowVWtqSXZVOHJVNmc2REdjUHg5OUd0cEh2?=
 =?utf-8?B?U1EydUtyMHZRQTR1bXFtdWVJNG04WFZUYjduSEdmT25qZGFYeUtjaTdJYkI5?=
 =?utf-8?B?a0lkQWllTEk2ZnlDQUZJRDZUT2pwdU9MRzIrWnVOK3Z3MGtuNmVVbStLS1hp?=
 =?utf-8?B?ZXVIMmpJQ2x4OCsxNmpPbTRFL2hBeThhUUl3U1diS0REL3hvV3VmVWtNVjR0?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d759f7fd-43ce-42d2-524d-08dabdfb7c1e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 00:28:24.3930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALmphAUWd4RRDnOtnIr/57K/yimok8msmx9buVoNzfxZODAqllptPwsWp0ZOn5mA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2278
X-Proofpoint-ORIG-GUID: J47G8mPahg01GrRvfYIaB4gxY9C7vWAp
X-Proofpoint-GUID: J47G8mPahg01GrRvfYIaB4gxY9C7vWAp
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
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



On 11/3/22 3:17 PM, Kumar Kartikeya Dwivedi wrote:
> On Thu, Nov 03, 2022 at 12:51:18PM IST, Yonghong Song wrote:
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
>> 	...
>> 	struct task_struct __rcu        *real_parent;
>> 	struct css_set __rcu            *cgroups;
>> 	...
>>    };
>>    struct css_set {
>> 	...
>> 	struct cgroup *dfl_cgrp;
>> 	...
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
>>   	/* Size is known at compile time. */
>>   	MEM_FIXED_SIZE		= BIT(10 + BPF_BASE_TYPE_BITS),
>>
>> +	/* MEM is tagged with rcu and memory access needs rcu_read_lock protection. */
>> +	MEM_RCU			= BIT(11 + BPF_BASE_TYPE_BITS),
>> +
> 
> IMO, PTR_RCU would be better name for this, since it applied to a specific
> pointer through which the access is done.

I choose MEM_RCU since we have MEM_USER and MEM_PERCPU for __user and 
__percpu tagged memory/pointer before. So choosing MEM_RCU is for
consistency reason. If necessary, I guess if necessary we could
change all of MEM_USER/MEM_PERCPU/MEM_RCU to PTR_*. I don't have
strong preference.

> 
>>   	__BPF_TYPE_FLAG_MAX,
>>   	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
>>   };
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 1a32baa78ce2..d4e56f5a4b20 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -324,6 +324,7 @@ struct bpf_verifier_state {
>>   	u32 insn_idx;
>>   	u32 curframe;
>>   	u32 active_spin_lock;
>> +	u32 active_rcu_lock;
>>   	bool speculative;
>>
>>   	/* first and last insn idx of this verifier state */
[...]
>> @@ -4536,6 +4558,14 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>>   		return -EACCES;
>>   	}
>>
>> +	if ((reg->type & MEM_RCU) && env->prog->aux->sleepable &&
>> +	    !env->cur_state->active_rcu_lock) {
>> +		verbose(env,
>> +			"R%d is ptr_%s access rcu-protected memory with off=%d, not in rcu_read_lock region\n",
>> +			regno, tname, off);
>> +		return -EACCES;
>> +	}
>> +
>>   	if (env->ops->btf_struct_access) {
>>   		ret = env->ops->btf_struct_access(&env->log, reg->btf, t,
>>   						  off, size, atype, &btf_id, &flag);
>> @@ -4552,6 +4582,14 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>>   	if (ret < 0)
>>   		return ret;
>>
>> +	if ((flag & MEM_RCU) && env->prog->aux->sleepable &&
>> +	    !env->cur_state->active_rcu_lock) {
>> +		verbose(env,
>> +			"R%d is rcu dereference ptr_%s with off=%d, not in rcu_read_lock region\n",
>> +			regno, tname, off);
>> +		return -EACCES;
>> +	}
>> +
> 
> This isn't right. Every load that obtains an RCU pointer needs to become tied to
> the current RCU section, and needs to be invalidated once the RCU section ends.
> 
> So in addition to checking that bpf_rcu_read_lock is held around MEM_RCU access,
> you need to invalidate all MEM_RCU pointers when bpf_rcu_read_unlock is called.
> 
> Otherwise, with the current logic, the following would become possible:
> 
> bpf_rcu_read_lock();
> p = rcu_dereference(foo->rcup);
> bpf_rcu_read_unlock();
> 
> // p is possibly dead
> 
> bpf_rcu_read_lock();
> // use p
> bpf_rcu_read_unlock();

Thanks for catching this. Will fix it in the next revision.

> 
> I have pretty much the same patchset lying locally in my tree (waiting for the
> kfunc rework to get in before I post it), but I can also rebase other stuff
> using explicit bpf_rcu_read_lock on top of yours.
> 
>>   	/* If this is an untrusted pointer, all pointers formed by walking it
>>   	 * also inherit the untrusted flag.
>>   	 */
>> @@ -5684,7 +5722,12 @@ static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
>>   static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
>>   static const struct bpf_reg_types alloc_mem_types = { .types = { PTR_TO_MEM | MEM_ALLOC } };
>>   static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
>> -static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
>> +static const struct bpf_reg_types btf_ptr_types = {
>> +	.types = {
>> +		PTR_TO_BTF_ID,
>> +		PTR_TO_BTF_ID | MEM_RCU,
>> +	}
>> +};
>>   static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALUE } };
>>   static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_BTF_ID | MEM_PERCPU } };
>>   static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
>> @@ -5758,6 +5801,20 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>>   	if (arg_type & PTR_MAYBE_NULL)
>>   		type &= ~PTR_MAYBE_NULL;
>>
>> +	/* If the reg type is marked as MEM_RCU, ensure the usage is in the rcu_read_lock
>> +	 * region, and remove MEM_RCU from the type since the arg_type won't encode
>> +	 * MEM_RCU.
>> +	 */
>> +	if (type & MEM_RCU) {
>> +		if (env->prog->aux->sleepable && !env->cur_state->active_rcu_lock) {
>> +			verbose(env,
>> +				"R%d is arg type %s needs rcu protection\n",
>> +				regno, reg_type_str(env, reg->type));
>> +			return -EACCES;
>> +		}
>> +		type &= ~MEM_RCU;
>> +	}
>> +
>>   	for (i = 0; i < ARRAY_SIZE(compatible->types); i++) {
>>   		expected = compatible->types[i];
>>   		if (expected == NOT_INIT)
>> @@ -5774,7 +5831,8 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>>   	return -EACCES;
>>
>>   found:
>> -	if (reg->type == PTR_TO_BTF_ID) {
>> +	/* reg is already protected by rcu_read_lock(). Peel off MEM_RCU from reg->type. */
>> +	if ((reg->type & ~MEM_RCU) == PTR_TO_BTF_ID) {
>>   		/* For bpf_sk_release, it needs to match against first member
>>   		 * 'struct sock_common', hence make an exception for it. This
>>   		 * allows bpf_sk_release to work for multiple socket types.
>> @@ -5850,6 +5908,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>>   	 * fixed offset.
>>   	 */
>>   	case PTR_TO_BTF_ID:
>> +	case PTR_TO_BTF_ID | MEM_RCU:
>>   		/* When referenced PTR_TO_BTF_ID is passed to release function,
>>   		 * it's fixed offset must be 0.	In the other cases, fixed offset
>>   		 * can be non-zero.
>> @@ -7289,6 +7348,26 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>>   	}
>>
>>   	meta.func_id = func_id;
>> +
>> +	if (func_id == BPF_FUNC_rcu_read_lock)
>> +		env->cur_state->active_rcu_lock++;
>> +	if (func_id == BPF_FUNC_rcu_read_unlock) {
>> +		if (env->cur_state->active_rcu_lock == 0) {
>> +			verbose(env, "missing bpf_rcu_read_lock\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		env->cur_state->active_rcu_lock--;
>> +	}
>> +	if (env->cur_state->active_rcu_lock) {
>> +		if (is_sleepable_function(func_id))
>> +			verbose(env, "sleepable helper %s#%din rcu_read_lock region\n",
>> +				func_id_name(func_id), func_id);
>> +
>> +		if (env->prog->aux->sleepable && is_storage_get_function(func_id))
>> +			insn->off = BPF_STORAGE_GET_CALL;
> 
> This is a bit ugly. Why not use bpf_insn_aux_data?

Sure I can use bpf_insn_aux_data.

> 
>> +	}
>> +
>>   	/* check args */
>>   	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
>>   		err = check_func_arg(env, i, &meta, fn);
>> @@ -10470,6 +10549,11 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
>>   		return -EINVAL;
>>   	}
>>
>> +	if (env->prog->aux->sleepable && env->cur_state->active_rcu_lock) {
>> +		verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_rcu_read_lock-ed region\n");
>> +		return -EINVAL;
>> +	}
>> +
>>   	if (regs[ctx_reg].type != PTR_TO_CTX) {
>>   		verbose(env,
>>   			"at the time of BPF_LD_ABS|IND R6 != pointer to skb\n");
>> @@ -11734,6 +11818,9 @@ static bool states_equal(struct bpf_verifier_env *env,
>>   	if (old->active_spin_lock != cur->active_spin_lock)
>>   		return false;
>>
>> +	if (old->active_rcu_lock != cur->active_rcu_lock)
>> +		return false;
>> +
>>   	/* for states to be equal callsites have to be the same
>>   	 * and all frame states need to be equivalent
>>   	 */
>> @@ -12141,6 +12228,11 @@ static bool reg_type_mismatch(enum bpf_reg_type src, enum bpf_reg_type prev)
>>   			       !reg_type_mismatch_ok(prev));
>>   }
>>
>> +static bool reg_type_mismatch_ignore_rcu(enum bpf_reg_type src, enum bpf_reg_type prev)
>> +{
>> +	return reg_type_mismatch(src & ~MEM_RCU, prev & ~MEM_RCU);
>> +}
>> +
> 
> See the discussion about this in David's set:
> https://lore.kernel.org/bpf/CAP01T75FGW7F=Ho+oqoC6WgxK5uUir2=CUgiW_HwqNxmzmthBg@mail.gmail.com

Thanks for the pointer. Yes, the case is similar to what the code ties
to address in the above.

> 
>>   static int do_check(struct bpf_verifier_env *env)
>>   {
>>   	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
>> @@ -12266,6 +12358,18 @@ static int do_check(struct bpf_verifier_env *env)
>>
>>   			prev_src_type = &env->insn_aux_data[env->insn_idx].ptr_type;
>>
>> +			/* For NOT_INIT *prev_src_type, ignore rcu type tag.
>> +			 * For code like below,
>> +			 *   struct foo *f;
>> +			 *   if (...)
>> +			 *     f = ...; // f with MEM_RCU type tag.
>> +			 *   else
>> +			 *     f = ...; // f without MEM_RCU type tag.
>> +			 *   ... f ...  // Here f could be with/without MEM_RCU
>> +			 *
>> +			 * It is safe to ignore MEM_RCU type tag here since
>> +			 * base types are the same.
>> +			 */
>>   			if (*prev_src_type == NOT_INIT) {
>>   				/* saw a valid insn
>>   				 * dst_reg = *(u32 *)(src_reg + off)
>> @@ -12273,7 +12377,7 @@ static int do_check(struct bpf_verifier_env *env)
>>   				 */
>>   				*prev_src_type = src_reg_type;
>>
>> -			} else if (reg_type_mismatch(src_reg_type, *prev_src_type)) {
>> +			} else if (reg_type_mismatch_ignore_rcu(src_reg_type, *prev_src_type)) {
>>   				/* ABuser program is trying to use the same insn
>>   				 * dst_reg = *(u32*) (src_reg + off)
>>   				 * with different pointer types:
>> @@ -12412,6 +12516,11 @@ static int do_check(struct bpf_verifier_env *env)
>>   					return -EINVAL;
>>   				}
>>
>> +				if (env->cur_state->active_rcu_lock) {
>> +					verbose(env, "bpf_rcu_read_unlock is missing\n");
>> +					return -EINVAL;
>> +				}
>> +
>>   				/* We must do check_reference_leak here before
>>   				 * prepare_func_exit to handle the case when
>>   				 * state->curframe > 0, it may be a callback
>> @@ -13499,6 +13608,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>>   			convert_ctx_access = bpf_xdp_sock_convert_ctx_access;
>>   			break;
>>   		case PTR_TO_BTF_ID:
>> +		case PTR_TO_BTF_ID | MEM_RCU:
> 
> This shouldn't be needed, right? If it is RCU protected, there shouldn't be a
> need for handling faults (or it's a bug in the kernel).

I guess we still need to do this.
Yes, it is rcu protected, but rcu protected pointer could be a NULL, so 
possible fault should still be handled.

> 
>>   		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
>>   			if (type == BPF_READ) {
>>   				insn->code = BPF_LDX | BPF_PROBE_MEM |
>> @@ -14148,11 +14258,11 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>>   			goto patch_call_imm;
>>   		}
>>
>> -		if (insn->imm == BPF_FUNC_task_storage_get ||
>> -		    insn->imm == BPF_FUNC_sk_storage_get ||
>> -		    insn->imm == BPF_FUNC_inode_storage_get ||
>> -		    insn->imm == BPF_FUNC_cgrp_storage_get) {
>> -			if (env->prog->aux->sleepable)
>> +		if (is_storage_get_function(insn->imm)) {
>> +			if (env->prog->aux->sleepable && insn->off) {
>> +				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
>> +				insn->off = 0;
>> +			} else if (env->prog->aux->sleepable)
>>   				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_KERNEL);
>>   			else
>>   				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
>> --
>> 2.30.2
>>
