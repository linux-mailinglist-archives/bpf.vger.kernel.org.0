Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E9B64641C
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 23:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLGW26 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 17:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiLGW25 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 17:28:57 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDEB8138A
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 14:28:55 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7Knp4U030442;
        Wed, 7 Dec 2022 14:28:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ZhmaQWEyyvdmpqkPaI8zL0o96vUlzue+FVX/74ad6aY=;
 b=dkZ+MPeh+GLGI2s3de1AFyKmzDn4R4vGU/0hnhEEKSQZqejVoozbIH9OyH+jofmjZsBg
 80LnlpWhYXhmmWBaWKtSzEnp8WgRJMDRy6B8iMAoz6Z1H6SCRfZ1b0i/PKXi2HkqsJfa
 BlzLNTySL4JhP1LStuIXVa5/Ap6mpSSyMgZnPLFZfp5ZpC1nrKK/4ta0aHT8Q6dL2F3w
 pJMeHjBVmiOH/ytR+RjofabJBX6xZXx7fqwi+F6oR7H3DDmrvlCUDlNpHA48/uosC2/q
 oTCTMo96OPxrcxafx9gGcakg7lNbj1ekuYTAIddoZ7B8mS+ykL00HOFyX4AQQfTn16Zp JQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3man55e6ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 14:28:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCkz+6gkNtO39oOH0vHPeYrxP/Q0CBC46y1VAOXUxr53CRBXggjJ60hfaEoYzh23s2JYGRGjKOFtw0DVUC1aOecI3wSvurlL7twKE+NS/31jCSbyChm5ywebGPuTYw+hmsmwNZ4gzx2X9tDn2YIasXQ9crcZPBkdmbzfDSsFDtPmGsCTPZ58mYqKv8B9bvLCbSHe2N9e0Y/5Qg+vtPV3Kl67fxTxHgHNo0NtIv5SljWSVOuHv5hJQfgJTVnEdqfdXxzE6d/qaO7tVV/2vW306ulglhVyOX6Y0FRiyN4zAESgjX6dFvTnjjz2sdAo7kfOPlc7Ewy5Mm53eBgZM8s2Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhmaQWEyyvdmpqkPaI8zL0o96vUlzue+FVX/74ad6aY=;
 b=m3KWwfzv+wxtukLds7sQEapu7wHq+KSzmEL+73fUdRaNhX8Cpk9NeI85zVNmF/IoAC80QS+tGE4Mc+S3wVxnS4NLvxoEs5LFLZz+VbLR0HCzz6Fg/TZgYdel9EtglO6o+AwZhCLqFEJWRVgXD6fy5UoC+bxtaNwrCjTol72amMx/Oe2kO/4l11jqZmCTPu+u4wC/3MQdIJV3er51TZDjyT38c4u7Pj4/w0gtqUc6qtTCMimkUH4oZybGGWATnFgGGYvXtWqt04hAptrm7cY8FWlXw4+66v5jEx+d5IkcyEOF5Rt0U3ndTRq+8qmfLRgHK8UoDVNb/1xgQeCGu/sWLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4442.namprd15.prod.outlook.com (2603:10b6:303:103::13)
 by SA1PR15MB4904.namprd15.prod.outlook.com (2603:10b6:806:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Wed, 7 Dec
 2022 22:28:36 +0000
Received: from MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::5054:64cb:7c18:2993]) by MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::5054:64cb:7c18:2993%9]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 22:28:36 +0000
Message-ID: <5756f37f-c61a-71e1-5559-e6e009b606d6@meta.com>
Date:   Wed, 7 Dec 2022 17:28:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next 00/13] BPF rbtree next-gen datastructure
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221207193616.y7n4lmufztjsq6tr@apollo>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221207193616.y7n4lmufztjsq6tr@apollo>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: MN2PR10CA0035.namprd10.prod.outlook.com
 (2603:10b6:208:120::48) To MW4PR15MB4442.namprd15.prod.outlook.com
 (2603:10b6:303:103::13)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4442:EE_|SA1PR15MB4904:EE_
X-MS-Office365-Filtering-Correlation-Id: 4737b794-2c61-4705-d7f6-08dad8a261ee
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rrn1Dy57Gr3K6oy0rymp9ekpdVxnNDMPId8bel2uROZ8n+e2XO5O3yVVUCRWaMEcNpO8tMjgzq0s39IBkk9yCpjM0xGqUAGyt20DaYCHVZm3JkBxk1piv/ulwi9zGQyqCDa+tOT7dtWGAc463GERDvsBqFb0QnFn2e/W7e68UoDI3W2ce6MLaj8TN4ij05ShwGmJA7t/iWtfstIXkk71jDysZb/xkOpBF8LcyapZOIGxuCT74cbWri2hiAfzcTWvxqB0mtqFjSf5nnjIJSopY6uLLejSsPa/Q4dxIc+GLGvXnCJdGhwdylCfpswvfKgeso7668i1WBLRStD+ruEgTkbQNnFc+8SodbB+O/i3tfvHr3GUNMPBEoRj9IcEYe/tgjAlCv1KbNbvAJoEQVPO8XwJMrJw11PthU+T4gnCPWun0SW3WDQpOiQpmITFeYg0aJXsg8AE0i9BDnmrmX0FOshKy8cbQY27xMWaluDeBbYGoFyKMz3JWkUUPhHq4d6QdDuHNeiZgv9xvyRSUL+JVXrPWuEbrwvykn0qdtJDGuf56+/MSYQmoyodfHI+XeMKJSWy3QrGu+NQTgnzP99PoBOL8TToq9FFc0Um5AurJOb8TtAJviPdTvR6kEJMhqnen/gM7ryrWMfqGtAYwNZMVonUieCBkweB/kIMuy90SvLWU0YAWtrNfvIYrDgDD9qYgwZFDtBL1sjMvSmcCr1W138EaL2dbTUhS+PomulMPqEvl+uCHEigirQrwYwV9/2A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4442.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(451199015)(2616005)(83380400001)(186003)(6512007)(31686004)(478600001)(6506007)(53546011)(66899015)(4326008)(6486002)(54906003)(2906002)(110136005)(38100700002)(316002)(8936002)(41300700001)(66476007)(66946007)(8676002)(66556008)(31696002)(5660300002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2FIVjBCYjE1VkR2Y2psZC93cm8wQ3JBaWQyWXdtRGcwNmlQY0ZJRk9VY083?=
 =?utf-8?B?Mi9rK0xJT2J3Q1NqRmc2dUJDMTRKdWFqQ0lHT3h3eEZDTDJNakhQZ2x0ZlhL?=
 =?utf-8?B?WXNxV1NZdG5iVkxtaFl3dDhRdFFzRk5MaUlrUGxaZW12dm9JRlBHY3NEZlBQ?=
 =?utf-8?B?NlB4Zzl4WUhlVytobmNpaUxiSlBvdng3TVpoQTJNb0IxdmMrakYwM09GOHRH?=
 =?utf-8?B?aTFsczM4OUNjL21vKzFUQzlwczcwZldDNExWZkh5alRKRk14TzFkeUI5WGFl?=
 =?utf-8?B?VVVxSlFQZnFORTdtSnFWbWJoT2ZpcDhnTHZ6c2FPWWpJbzgrV0w3WFIrRytS?=
 =?utf-8?B?cWpkU3ZqZlc3Tk1CS2RDdENuVGg2Zk5YREpBYlk3Q3hNRmFaYmpxQ0Fzd1V5?=
 =?utf-8?B?eSt5K3R3cHp1N05nSTB6b0ZEbW9lbFZueW9XYTR4RktWUmRvczBsSVE5WDk0?=
 =?utf-8?B?NWkvK0VSdTBQOXQxQk01cCtRUXdHUlpkbkU0QzVzR1dQWTQzMjhVbzBLVjRH?=
 =?utf-8?B?dFBEMUNMdzZqeklpVDBOc240cFduRzZvZGRnVmJEeCtRY2pNYjJZb0lTVHhV?=
 =?utf-8?B?cE8rYStjSG5pUWZJUGMzQmFUR3VWVVhJR01qQk5MQi9ITXJCYnNpdWl5S2J0?=
 =?utf-8?B?SFhSU2ZNWVdXNjNFRWNxZHhzaGIrMFhzZFBMejE2ODROT2xCdy9WVGFtK0Z6?=
 =?utf-8?B?VDE5MlZqdGdpNE1zWFFaQXk0K3VFZm5SOHdqcmVqRjRDU1V1TTRIOGdiUHEv?=
 =?utf-8?B?UHg0RFRmZnFIWFYvZ3hvSElvSEJNMnFBdm9PTndSQm5MbHlFK1pCQ3VtWmVS?=
 =?utf-8?B?TmV2dFRWRWsvUExTWUpNU200U1VsSndKUHhoR1B0dGovbFoyVWZKWXVnY2p2?=
 =?utf-8?B?b0ZjZWxKRUxhT0d3WkpnNW9TbnNPWGc0ZkJ4MnlQV3NRVStxaEw5eDFOQjI3?=
 =?utf-8?B?KzlXSkVEN3BqLyt0WWtnQzVMeFYrNFJXT0VNYzlBZWxiVzhoSXFOOHpVWEtY?=
 =?utf-8?B?M0lPbmkrdzlRL1ZvemVpQkhQNksyeThuTHlmdUk5eFVYdjAwWnp5dm55Z3NQ?=
 =?utf-8?B?TmZBWE03bmlTTS9UMlo1dnRKaGFCKytnV291N0lENGcxaHRDdi9IaDlyQWUr?=
 =?utf-8?B?UkpKQ1FOYXlNekZiWHhndHBDaU44MFpNcTRubWZHRDdBNElzc3owYWRxNUR6?=
 =?utf-8?B?SHMya1lLeG0rWTlTTWUzMFdva3NsVU0xTUZNSVdPUGJxNHhqNE5WMWptRWVv?=
 =?utf-8?B?ZlhyWGoxaGErbzlod0RWYlhrbjBMemF3WnNkcDJhSGNvN051UzhZd05pbmxs?=
 =?utf-8?B?QzRZcmtHaXJGaUhZZi9uSXVHWEpuTUQzenJzZzR5SzBCM1ZNbFlDYS8vbFl3?=
 =?utf-8?B?c3ZPa3BKajUwNHk4ZGx6ZDBaM0tLTFJJMjRaWVE3RGVIMk1lLzNqL3YrUXlz?=
 =?utf-8?B?M0VucDFlVjc4OUFLWVhyK2tqMnVMMXpEQjd6RGtTU3NYVDUwS2prWExRTW13?=
 =?utf-8?B?a0RERldXWVdoNGc0bGhldkFpS2hSQlc3VVNSWTBWNit4OEptejl5NGNnUXBk?=
 =?utf-8?B?WG55USt3a0orWkpPQXBrSXZYVUNuSzNLQWV1akNrbEt2Uk5jVENVOCsveEJX?=
 =?utf-8?B?NEdIUGgwLzlTb1NFa1dIdVNQaUxzNWQ3Y3pPUzRZNXVKaGJxcHphTktKQ2ll?=
 =?utf-8?B?cGRCeUVOdU5RNm91QjZvTUlMN3lkZHM2OWxQNlRZOGRtOU1GSThLck5JTGlq?=
 =?utf-8?B?Yjk5QmNOeXFYV3lrbkY1UGRNOHIyc09lbWFrVCtZUjhZT25reXUreEJxK1hF?=
 =?utf-8?B?VG5PU1gwWW9PelVOMTB1dkd0NVQrMHhnVEgxNTZTeWNaN0VtdndNeTlvOXM4?=
 =?utf-8?B?dW1SN0hMSHNDMTY4eHQrdFZ0VXVhWEVrc1dqNCtkZjhXcGFLZ2Nrd3BxZHFm?=
 =?utf-8?B?NEZkWHFqZm1HajRqU0E1ak8veWRLSVBtK285ZituRnRoanBWWW15bnZhelVO?=
 =?utf-8?B?K3lzNFJtZXZkcDJBeEtyM01pNDl1VWdDYU9adkxCY1gvUDFNdkwrbEgrUy9y?=
 =?utf-8?B?WUhGT2xid1ZaT0VvUU5WOUpkM3RKUzRQR0Z1MS93MTNsUHh2Tks2VHJxeCtT?=
 =?utf-8?B?a0ZVL1cxczhtZHhsSVBTL3dKcmJENWU5Wjc1L1BpZmZKMW9Mbk82SUZQWUFU?=
 =?utf-8?Q?k885lkG/+Sn76JY33fNmBRQ=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4737b794-2c61-4705-d7f6-08dad8a261ee
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4442.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 22:28:36.7721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJy/rLw+c5UJsI3XP9mBR6rubq010INurGGYEVMEgvDKKYUt2ADxwfWPVw5bOhgmwsNwaQG7KeW+2WTPzMb4gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4904
X-Proofpoint-ORIG-GUID: T2eyacknRHeqzNLClDEHLuuoKuTZt5wj
X-Proofpoint-GUID: T2eyacknRHeqzNLClDEHLuuoKuTZt5wj
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_11,2022-12-07_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/7/22 2:36 PM, Kumar Kartikeya Dwivedi wrote:
> On Wed, Dec 07, 2022 at 04:39:47AM IST, Dave Marchevsky wrote:
>> This series adds a rbtree datastructure following the "next-gen
>> datastructure" precedent set by recently-added linked-list [0]. This is
>> a reimplementation of previous rbtree RFC [1] to use kfunc + kptr
>> instead of adding a new map type. This series adds a smaller set of API
>> functions than that RFC - just the minimum needed to support current
>> cgfifo example scheduler in ongoing sched_ext effort [2], namely:
>>
>>   bpf_rbtree_add
>>   bpf_rbtree_remove
>>   bpf_rbtree_first
>>
>> [...]
>>
>> Future work:
>>   Enabling writes to release_on_unlock refs should be done before the
>>   functionality of BPF rbtree can truly be considered complete.
>>   Implementing this proved more complex than expected so it's been
>>   pushed off to a future patch.
>>

> 
> TBH, I think we need to revisit whether there's a strong need for this. I would
> even argue that we should simply make the release semantics of rbtree_add,
> list_push helpers stronger and remove release_on_unlock logic entirely,
> releasing the node immediately. I don't see why it is so critical to have read,
> and more importantly, write access to nodes after losing their ownership. And
> that too is only available until the lock is unlocked.
> 

Moved the next paragraph here to ease reply, it was the last paragraph
in your response.

> 
> Can you elaborate on actual use cases where immediate release or not having
> write support makes it hard or impossible to support a certain use case, so that
> it is easier to understand the requirements and design things accordingly?
>

Sure, the main usecase and impetus behind this for me is the sched_ext work
Tejun and others are doing (https://lwn.net/Articles/916291/). One of the
things they'd like to be able to do is implement a CFS-like scheduler using
rbtree entirely in BPF. This would prove that sched_ext + BPF can be used to
implement complicated scheduling logic.

If we can implement such complicated scheduling logic, but it has so much
BPF-specific twisting of program logic that it's incomprehensible to scheduler
folks, that's not great. The overlap between "BPF experts" and "scheduler
experts" is small, and we want the latter group to be able to read BPF
scheduling logic without too much struggle. Lower learning curve makes folks
more likely to experiment with sched_ext.

When 'rbtree map' was in brainstorming / prototyping, non-owning reference
semantics were called out as moving BPF datastructures closer to their kernel
equivalents from a UX perspective.

If the "it makes BPF code better resemble normal kernel code" argumentwas the
only reason to do this I wouldn't feel so strongly, but there are practical
concerns as well:

If we could only read / write from rbtree node if it isn't in a tree, the common
operation of "find this node and update its data" would require removing and
re-adding it. For rbtree, these unnecessary remove and add operations could
result in unnecessary rebalancing. Going back to the sched_ext usecase,
if we have a rbtree with task or cgroup stats that need to be updated often,
unnecessary rebalancing would make this update slower than if non-owning refs
allowed in-place read/write of node data.

Also, we eventually want to be able to have a node that's part of both a
list and rbtree. Likely adding such a node to both would require calling
kfunc for adding to list, and separate kfunc call for adding to rbtree.
Once the node has been added to list, we need some way to represent a reference
to that node so that we can pass it to rbtree add kfunc. Sounds like a
non-owning reference to me, albeit with different semantics than current
release_on_unlock.

> I think this relaxed release logic and write support is the wrong direction to
> take, as it has a direct bearing on what can be done with a node inside the
> critical section. There's already the problem with not being able to do
> bpf_obj_drop easily inside the critical section with this. That might be useful
> for draining operations while holding the lock.
> 

The bpf_obj_drop case is similar to your "can't pass non-owning reference
to bpf_rbtree_remove" concern from patch 1's thread. If we have:

  n = bpf_obj_new(...); // n is owning ref
  bpf_rbtree_add(&tree, &n->node); // n is non-owning ref

  res = bpf_rbtree_first(&tree);
  if (!res) {...}
  m = container_of(res, struct node_data, node); // m is non-owning ref

  res = bpf_rbtree_remove(&tree, &n->node);
  n = container_of(res, struct node_data, node); // n is owning ref, m points to same memory

  bpf_obj_drop(n);
  // Not safe to use m anymore

Datastructures which support bpf_obj_drop in the critical section can
do same as my bpf_rbtree_remove suggestion: just invalidate all non-owning
references after bpf_obj_drop. Then there's no potential use-after-free.
(For the above example, pretend bpf_rbtree_remove didn't already invalidate
'm', or that there's some other way to obtain non-owning ref to 'n''s node
after rbtree_remove)

I think that, in practice, operations where the BPF program wants to remove
/ delete nodes will be distinct from operations where program just wants to 
obtain some non-owning refs and do read / write. At least for sched_ext usecase
this is true. So all the additional clobbers won't require program writer
to do special workarounds to deal with verifier in the common case.

> Semantically in other languages, once you move an object, accessing it is
> usually a bug, and in most of the cases it is sufficient to prepare it before
> insertion. We are certainly in the same territory here with these APIs.

Sure, but 'add'/'remove' for these intrusive linked datastructures is
_not_ a 'move'. Obscuring this from the user and forcing them to use
less performant patterns for the sake of some verifier complexity, or desire
to mimic semantics of languages w/o reference stability, doesn't make sense to
me.

If we were to add some datastructures without reference stability, sure, let's
not do non-owning references for those. So let's make this non-owning reference
stuff easy to turn on/off, perhaps via KF_RELEASE_NON_OWN or similar flags,
which will coincidentally make it very easy to remove if we later decide that
the complexity isn't worth it. 
