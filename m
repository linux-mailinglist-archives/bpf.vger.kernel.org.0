Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66774646A7E
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 09:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiLHI3Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 03:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiLHI3O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 03:29:14 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB455B585
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 00:29:11 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B80P5vA007686;
        Thu, 8 Dec 2022 00:28:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=8TaWQzqcB13FVs2CcQKBHrQrFwEQ6+hwCWogMnLW43Q=;
 b=kf3OzIC+4ld6NoxQqYSpXjKSgLFCU3/Sx+/iM3bqfmejP8QvVYHfqxgedQc1ep3RB2ZT
 uLvrzFedQsVYucomzBAd87Nke3lmLXUV5JayjOG5GGJS+3i46BU+tFi7p/p1k2sXoCpf
 HjiR6oir/TjnCSoUMYgvghqfLt0x0ljgUJUXIZjKXDUboRakbY14ItWsoxUnJJlcROi9
 aY9gDShWZa3uNAYaw8kvnVJHwHbDQ1zcQzN24C7UQv+STtnw5jQ7VZKmseGKpMcqcyfE
 0G2MJVmK/hSQRNw2Ve27ATBmAJ7R5K8QIIEPaW8qVt7/4kS9vZlWHdtFxxviRxfoKLZq vw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3maqx788w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 00:28:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYwvM85I5NXG2GabU1Y7aHL791VK5acm4zdBvM8UkTfll9+DZeLhFkQjmbKZwJza3IHxXdJmUhCLnKxCYYBBqdUhrpwG3hTTBhQsZ4jkRM7vo52lL6lytHx6dgbtezGtfjO0FuH8EZzJwDr6Qdi7V+qjNvCUXIFIB7sgnSZ5jXDYAAtu68gN4nXgub41CYQ4cgYKX1s/ZZCHhrgWrWwwwvhFAUuXjGq4JUDru9mqiedtTnTSvzTdTSPkXacT9GupMyU73IBpCTgRvl1ij89UQAHzstpcW1DSr+ZBvLO708Kt8nnRrm/AfcKcN+pctjW7bqfq03EKrAZ7RXuZO7SqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TaWQzqcB13FVs2CcQKBHrQrFwEQ6+hwCWogMnLW43Q=;
 b=Tx2hVQ/TbwgiW6ikG6DonPZfMKhAOTH2qoHKIZs7utycB+QRabYTlBAK5gzPugLvV/7lf3Y7P9nKJco6eUr45HCsm9V6bQAGQ8jztVHqVGbjhl/l6EXG8N7MD+poyXkGLBigOMtL1+I7rGxm3ivHjxuVTsxJLyxnqAidZ9qvbYL+vPrCu5+RDaUFTiTbIojWB9cX6KNaQmEkhuqED4hsjoH92CyK3IfkhDbR34o3Yja1OOj2iUWOm/+l247b8214bdf/a5Iqsg3NyBXSG01CSh1rqIejlw+mL8z8nfsWIwGLmP3hI/7bR9txNV4PLrEKySgyhZG4SluHKLjifUhLkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4442.namprd15.prod.outlook.com (2603:10b6:303:103::13)
 by SJ0PR15MB5278.namprd15.prod.outlook.com (2603:10b6:a03:42d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 08:28:48 +0000
Received: from MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::5054:64cb:7c18:2993]) by MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::5054:64cb:7c18:2993%9]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 08:28:48 +0000
Message-ID: <4dc1def4-74a1-d1a6-386a-32e84962a55a@meta.com>
Date:   Thu, 8 Dec 2022 03:28:44 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next 00/13] BPF rbtree next-gen datastructure
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221207193616.y7n4lmufztjsq6tr@apollo>
 <5756f37f-c61a-71e1-5559-e6e009b606d6@meta.com>
 <20221207230602.logjjjv3kwiiy6u3@macbook-pro-6.dhcp.thefacebook.com>
 <33b0c075-3551-b57a-76e4-bc40452b3253@meta.com>
 <20221208035140.skuadnybf5aqb4o5@macbook-pro-6.dhcp.thefacebook.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221208035140.skuadnybf5aqb4o5@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:208:2d::34) To MW4PR15MB4442.namprd15.prod.outlook.com
 (2603:10b6:303:103::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4442:EE_|SJ0PR15MB5278:EE_
X-MS-Office365-Filtering-Correlation-Id: db493786-bfb6-4fe2-2e4f-08dad8f63a6b
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3LyPHoyZP+t+LcWsjXDeZefCLdIW0WU1+hcPVnBxslZrKwXT/gMLDfcNHmxxBGNFu6Id820+c9VTP5rWqsiN/KxJ7HgNtU73hGc4WFOGoWEDMSJbu35HCWzn6bD8wKHPo6rO+CFjkXJk7HkkaAezWjprA0Y/R3Mv+TmkqCP6qausskYMkGCsho/jhMNLenN6ZkX2740Mqo2BS2iS1sgfhRDDAVX+bOaWgeJusNu2RI2/Ts7ZsAiyycyvV5wcfoj67JJSXY31jVWg89zn5LjzeTqVpqCBWlsDOAUqzt1/CrlMzH7m00fOcXaa6u21amBADMkSfPSN6q66vADMCm7sZ5LK0tgpmOqIfS5jOJ9eNssD+5d1NkIDXgFycR1p8IkTbKUjl25f4GAyfqjPyk8PPbauCjwPXOyFiydIEB4lZFIxLJNns9bXXWvwbylTxhNzv2CaVVcVc5BxgHvjRKSQ/79wu1xouksC8ebhRET6dLENYg/RIFnuFf5/WZnbMQ69LatH4GhmNsluYrx0kKj0RYxjbnJFiE55JpStaUEtNZ36rtf2uGruaZ8sDkP2xdmqFM0lQux9NjgH1Pn0kH38tRRVQL72zG7rVe1QatKGfW8FDTxIX6FBmREcyXWRCyp1w/JB0hBFyyKPIjQdLKGBDqOLd9eq9FHz+CJms918uNrUE0IPRQiNX5rW6bN63senRXdlmliU4jSiBbcltjHm3zgjXfpbAjsxPjCQto3TreU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4442.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199015)(2906002)(30864003)(66476007)(41300700001)(66946007)(8676002)(4326008)(66556008)(8936002)(5660300002)(54906003)(316002)(6916009)(6512007)(6506007)(53546011)(6666004)(2616005)(36756003)(186003)(6486002)(31696002)(66899015)(31686004)(86362001)(478600001)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWRCVDRLd0ttb3hEQ0JqQWI3eDJuRXN0NVpCaHMzVHErbThua1g3THRCSWht?=
 =?utf-8?B?aklyZUl3dHlJL014K2VQZUI5R0R6RnM2WEgzSzMzS3ZtdDJ2bjlTN1pwb0xT?=
 =?utf-8?B?YzcxTmhBUm4vNTd1ZWlKcmJCbDVIZEdUdzJFekQvbG9YTVhmWllTcEx4eTIw?=
 =?utf-8?B?cndZbkhuL25zUnQ0clJzNFdlc1BJSlJyQ0VYam9OVUJSRGlWWkRyNENWYkVK?=
 =?utf-8?B?bGxwamN2dUhGMTVwaHpJWHVCZXJjVi9aMmxTUnc3cWxQTlcyeFRGQjJMTFN1?=
 =?utf-8?B?U1hvd3p4aGVyTlhwbUdUSlZTV2JUV200K1BGZWUvSERMbk1hTTNZM21lYWFv?=
 =?utf-8?B?NXg5WU45S1o0cXdORWtzSjBCaVppOUhXbU9QMlFlcGQ1bEVGNElqVE1KVyta?=
 =?utf-8?B?SlZ6Nk96OVFHT2VyKzh1OHFqZUh4OGlscm5oYTJtd3hUSHpiKzA4TXBpeVZh?=
 =?utf-8?B?NjJuTFdCOGdqeVhYZDVRSjM1UHljME1ta2duWTY4cmpvb2dvdG5tWGJUYmpU?=
 =?utf-8?B?UFZDUmpmTHFNdndiZXdjOEJHWXFmOUJFVCtDdHFsaHM2ODI2enR5Y05rTGFJ?=
 =?utf-8?B?Q3NQVi92bk5mY25kUkpDcVlWVzh3eTZ3cXRDN1RSOTBZWkdVK2wrRlY3SVNm?=
 =?utf-8?B?eS8rVWkxWW0zazlOdkxHMDFiMFpPbTBTcVExVzhLQlYxbER6QXB6NDU4TFQ1?=
 =?utf-8?B?cVRWS1JzcjFlTnpNWGtqaDROSENvN0ZLNC9Uc3FGYm9hYXdPS3R6K3BEVDlw?=
 =?utf-8?B?VWM3RjI1MTE5L0M0TkJkU082WnZwNzVKanF6ajJCSkRDdERBY2FlRmJlRXpC?=
 =?utf-8?B?VWtmWTV3UlBrdDJ5L0p5Wk5oclpjaXVJZ3haMDh2TFJsbmdhYzJmczl6T01t?=
 =?utf-8?B?VS9xL2xkZWgvZ2VvZFRDVDRQaHFRZGpRbTNzTlQ3RXMzZm5xSUtSaTFxK1Nv?=
 =?utf-8?B?KzFzQXRSOWIxdzRqQ29MbTR3THRzTFBxeW9GNXVqZzBzc2hXK2JQOThZVjM3?=
 =?utf-8?B?RjNlbWhZUCtCZ2Y5T1ZtM1p1VGtKMzdqZFFpK3plckgrVDM4THNCcC9OODdk?=
 =?utf-8?B?dmw3RTJjLzR6WWZyUHpYejk3TzJObHV5ZkR1L01HWCtNYkF3ZG5rRGNFbHZk?=
 =?utf-8?B?bm9FZ3pNWktFQkNURDFMZGJJRWdocFdwb0ticTY5UDB1ZVBRRUFjWjJVUjhL?=
 =?utf-8?B?SGgxQzRNSzJwM3RrWnN5bTZxTm54dFFSWFc2ZHJvcXZIZXhJTXh4VWdOZ1Nw?=
 =?utf-8?B?MGIvOVpuUjErM1AyVFgyMEJ1cVkzWWh4bjlJVlNPd28xWE5NVm9sL3RoL05O?=
 =?utf-8?B?TFBMQkZqR09HTlg4bkx6MEo4SHpEWnlQN2Z3c3haQjdyaVdKSzRTR201VHVG?=
 =?utf-8?B?SkZBMVNDZTBYRW91YVpydWEwTk43eG1tTUExeTFVcDBOdkw0VU1NNUVDWUtQ?=
 =?utf-8?B?anhDQUlLcjFMMXZqdVIrYTlZbHA1UjRSd3paUlQvOXQ2b1dFRHF1NGx3UVVN?=
 =?utf-8?B?aUFHNVhWcE0zTDFTM0lUTVFrRjNNVUJ0ZVUyRDgzZDI1THRhV1haTEdLMG1w?=
 =?utf-8?B?UUNMdDgvbDdOaXlJdnpkeTc4YXMrNWlnTFNZOXVTV1g0RUVpTlBNbDU2UDFy?=
 =?utf-8?B?TllnenNLK1J0bDQvSGhOOFFZeHVYcU5yWmRwU0NwQml3eGp0VUZHbFpKWS9J?=
 =?utf-8?B?OXVTTzJRSmtlWXYvZ01oV2YyaDFGeDlsQVpnUWpCWFFzVk9KWnBTbDhqRlZ1?=
 =?utf-8?B?MmNOUjlXSnJSS1E5eGpVcTFtbi9ZOFZuelFkaE5ZTnhKTlFtY1REMUJOME9q?=
 =?utf-8?B?L25UR21wREl6MnkrQVF6WkJkVDlNd2xDU3dnM2R2eUhrMjhyRitnL21XZGhq?=
 =?utf-8?B?b0lKbk5OcjIycDVmNEJJNHByUmdvajR1YjlSdm9GUEFWMXVIUnJyamZKeXYy?=
 =?utf-8?B?dFlnaStDWXh6ejM2eDd3VzN6MHNYNGdwVjR4Q0ZMbVZDbm12S0Rrd0xmTjF4?=
 =?utf-8?B?cEkranpXZ3c5a3J5UittWnE1UHRaSmpKUkNmZFRRdEwyMXFoUUNFdUJSTHJp?=
 =?utf-8?B?UVhTUUN3SHhGMkUrUi9Ka21ZdmZhb2diZHIxNDdxc01LNDM3TDFpM3ppTHpM?=
 =?utf-8?B?d0dEbE16NUJETCtUbGRvVXlQTURHdFliRUE5SVQ4S0JES3dvanZyL1RHQmFP?=
 =?utf-8?Q?mYG1TyCDz2VDJUI6qE0tKwk=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db493786-bfb6-4fe2-2e4f-08dad8f63a6b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4442.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 08:28:48.2034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BF9D3wuglZ1YFd/ipVElh8VMjr60N8Ecabt1eeHcqU8AdO45++R4Mu5t/1w2Cn7hd7ilK8r/ISCbuANvJ4v5cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5278
X-Proofpoint-GUID: uQ8LlJCvizfcpgeYNB0BxxJcSvLWSk7b
X-Proofpoint-ORIG-GUID: uQ8LlJCvizfcpgeYNB0BxxJcSvLWSk7b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_04,2022-12-07_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/7/22 10:51 PM, Alexei Starovoitov wrote:
> On Wed, Dec 07, 2022 at 08:18:25PM -0500, Dave Marchevsky wrote:
>>
>> Before replying to specific things in this email, I think it would be useful
>> to have a subthread clearing up definitions and semantics, as I think we're
>> talking past each other a bit.
> 
> Yeah. We were not on the same page.
> The concepts of 'owning ref' and 'non-owning ref' appeared 'new' to me.
> I remember discussing 'conditional release' and OBJ_NON_OWNING_REF long ago
> and I thought we agreed that both are not necessary and with that
> I assumed that anything 'non-owning' as a concept is gone too.
> So the only thing left (in my mind) was the 'owning' concept.
> Which I mapped as ref_obj_id > 0. In other words 'owning' meant 'acquired'.
> 

Whereas in my mind the release_on_unlock logic was specifically added to
implement the mass invalidation part of non-owning reference semantics, and it
being accepted implied that we weren't getting rid of the concept :).

> Please have this detailed explanation in the commit log next time to
> avoid this back and forth.
> Now to the fun part...
> 

I will add a documentation commit explaining 'owning' and 'non-owning' ref
as they pertain to these datastructures, after we agree about the semantics.

Speaking of which, although I have a few questions / clarifications, I think
we're more in agreement after your reply. After one more round of clarification
I will summarize conclusions to see if we agree on enough to move forward.

>>
>> On a conceptual level I've still been using "owning reference" and "non-owning
>> reference" to understand rbtree operations. I'll use those here and try to map
>> them to actual verifier concepts later.
>>
>> owning reference
>>
>>   * This reference controls the lifetime of the pointee
>>   * Ownership of pointee must be 'released' by passing it to some rbtree
>>     API kfunc - rbtree_add in our case -  or via bpf_obj_drop, which free's
>>     * If not released before program ends, verifier considers prog invalid
>>   * Access to the memory ref is pointing at will not page fault
> 
> agree.
> 
>> non-owning reference
>>
>>   * No ownership of pointee so can't pass ownership via rbtree_add, not allowed
>>     to bpf_obj_drop
>>   * No control of lifetime, but can infer memory safety based on context
>>     (see explanation below)
>>   * Access to the memory ref is pointing at will not page fault
>>     (see explanation below)
> 
> agree with addition that both read and write should be allowed into this
> 'non-owning' ptr.
> Which breaks if you map this to something that ORs with PTR_UNTRUSTED.
> 

Agree re: read/write allowed. PTR_UNTRUSTED was an implementation detail.
Sounds like we agree on general purpose of owning, non-owning. Looks like
we're in agreement about above semantics.

>> 2) From verifier's perspective non-owning references can only exist
>> between spin_lock and spin_unlock. Why? After spin_unlock another program
>> can do arbitrary operations on the rbtree like removing and free-ing
>> via bpf_obj_drop. A non-owning ref to some chunk of memory that was remove'd,
>> free'd, and reused via bpf_obj_new would point to an entirely different thing.
>> Or the memory could go away.
> 
> agree that spin_unlock needs to clean up 'non-owning'.

Another point of agreement.

> 
>> To prevent this logic violation all non-owning references are invalidated by
>> verifier after critical section ends. This is necessary to ensure "will
>> not page fault" property of non-owning reference. So if verifier hasn't
>> invalidated a non-owning ref, accessing it will not page fault.
>>
>> Currently bpf_obj_drop is not allowed in the critical section, so similarly,
>> if there's a valid non-owning ref, we must be in critical section, and can
>> conclude that the ref's memory hasn't been dropped-and-free'd or dropped-
>> and-reused.
> 
> I don't understand why is that a problem.
> 
>> 1) Any reference to a node that is in a rbtree _must_ be non-owning, since
>> the tree has control of pointee lifetime. Similarly, any ref to a node
>> that isn't in rbtree _must_ be owning. (let's ignore raw read from kptr_xchg'd
>> node in map_val for now)
> 
> Also not clear why such restriction is necessary.
> 

If we have this restriction and bpf_rbtree_release also mass invalidates
non-owning refs, the type system will ensure that only nodes that are in a tree
will be passed to bpf_rbtree_release, and we can avoid the runtime check.

But below you mention preferring the runtime check, mostly noting here to
refer back when continuing reply below.

>> Moving on to rbtree API:
>>
>> bpf_rbtree_add(&tree, &node);
>>   'node' is an owning ref, becomes a non-owning ref.
>>
>> bpf_rbtree_first(&tree);
>>   retval is a non-owning ref, since first() node is still in tree
>>
>> bpf_rbtree_remove(&tree, &node);
>>   'node' is a non-owning ref, retval is an owning ref
> 
> agree on the above definition.
> >> All of the above can only be called when rbtree's lock is held, so invalidation
>> of all non-owning refs on spin_unlock is fine for rbtree_remove.
>>
>> Nice property of paragraph marked with 1) above is the ability to use the
>> type system to prevent rbtree_add of node that's already in rbtree and
>> rbtree_remove of node that's not in one. So we can forego runtime
>> checking of "already in tree", "already not in tree".
> 
> I think it's easier to add runtime check inside bpf_rbtree_remove()
> since it already returns MAYBE_NULL. No 'conditional release' necessary.
> And with that we don't need to worry about aliases.
> 

To clarify: You're proposing that we don't worry about solving the aliasing
problem at verification time. Instead rbtree_{add,remove} will deal with it
at runtime. Corollary of this is that my restriction tagged 1) above ("ref
to node in tree _must_ be non-owning, to node not in tree must be owning")
isn't something we're guaranteeing, due to possibility of aliasing.

So bpf_rbtree_remove might get a node that's not in tree, and
bpf_rbtree_add might get a node that's already in tree. Runtime behavior
of both should be 'nop'.


If that is an accurate restatement of your proposal, the verifier
logic will need to be changed:

For bpf_rbtree_remove(&tree, &node), if node is already not in a tree,
retval will be NULL, effectively not acquiring an owning ref due to
mark_ptr_or_null_reg's logic.

In this case, do we want to invalidate
arg 'node' as well? Or just leave it as a non-owning ref that points
to node not in tree? I think the latter requires fewer verifier changes,
but can see the argument for the former if we want restriction 1) to
mostly be true, unless aliasing.

The above scenario is the only case where bpf_rbtree_remove fails and
returns NULL.

(In this series it can fail and RET_NULL for this reason, but my earlier comment
about type system + invalidate all-non owning after remove as discussed below
was my original intent. So I shouldn't have been allowing RET_NULL for my
version of these semantics.)


For bpf_rbtree_add(&tree, &node, less), if arg is already in tree, then
'node' isn't really an owning ref, and we need to tag it as non-owning,
and program then won't need to bpf_obj_drop it before exiting. If node
wasn't already in tree and rbtree_add actually added it, 'node' would
also be tagged as non-owning, since tree now owns it. 

Do we need some way to indicate whether 'already in tree' case happened?
If so, would need to change retval from void to bool or struct bpf_rb_node *.

Above scenario is only case where bpf_rbtree_add fails and returns
NULL / false. 

>> But, as you and Kumar talked about in the past and referenced in patch 1's
>> thread, non-owning refs may alias each other, or an owning ref, and have no
>> way of knowing whether this is the case. So if X and Y are two non-owning refs
>> that alias each other, and bpf_rbtree_remove(tree, X) is called, a subsequent
>> call to bpf_rbtree_remove(tree, Y) would be removing node from tree which
>> already isn't in any tree (since prog has an owning ref to it). But verifier
>> doesn't know X and Y alias each other. So previous paragraph's "forego
>> runtime checks" statement can only hold if we invalidate all non-owning refs
>> after 'destructive' rbtree_remove operation.
> 
> right. we either invalidate all non-owning after bpf_rbtree_remove
> or do run-time check in bpf_rbtree_remove.
> Consider the following:
> bpf_spin_lock
> n = bpf_rbtree_first(root);
> m = bpf_rbtree_first(root);
> x = bpf_rbtree_remove(root, n)
> y = bpf_rbtree_remove(root, m)
> bpf_spin_unlock
> if (x)
>    bpf_obj_drop(x)
> if (y)
>    bpf_obj_drop(y)
> 
> If we invalidate after bpf_rbtree_remove() the above will be rejected by the verifier.
> If we do run-time check the above will be accepted and will work without crashing.
> 

Agreed, although the above example's invalid double-remove of same node is
the kind of thing I'd like to be prevented at verification time instead of
runtime. Regardless, continuing with your runtime check idea.

> The problem with release_on_unlock is that it marks 'n' after 1st remove
> as UNTRUSTED which means 'no write' and 'read via probe_read'.
> That's not good imo.
>

Based on your response to paragraph below this one, I think we're in agreement
that using PTR_UNTRUSTED for non-owning ref gives non-owning ref bunch of traits
it doesn't need, when I just wanted "can't pass ownership". So agreed that
PTR_UNTRUSTED is too blunt an instrument here.

Regarding "marks 'n' after 1st remove", the series isn't currently doing this,
I proposed it as a way to prevent aliasing problem, but I think your proposal
is explicitly not trying to prevent aliasing problem at verification time. So
for your semantics we would only have non-owning cleanup after spin_unlock.
And such cleanup might just mark refs PTR_UNTRUSTED instead of invalidating
entirely.

>>
>> It doesn't matter to me which combination of type flags, ref_obj_id, other
>> reg state stuff, and special-casing is used to implement owning and non-owning
>> refs. Specific ones chosen in this series for rbtree node:
>>
>> owning ref: PTR_TO_BTF_ID | MEM_ALLOC (w/ type that contains bpf_rb_node)
>>             ref_obj_id > 0
>>
>> non-owning ref: PTR_TO_BTF_ID | MEM_ALLOC (w/ type that contains bpf_rb_node)
>>                 PTR_UNTRUSTED
>>                   - used for "can't pass ownership", not PROBE_MEM
>>                   - this is why I mentioned "decomposing UNTRUSTED into more
>>                     granular reg traits" in another thread
> 
> Now I undestand, but that was very hard to grasp.
> UNTRUSTED means 'no write' and 'read via probe_read'.
> ref_set_release_on_unlock() also keeps ref_obj_id > 0 as you're correctly
> pointing out below:
>>                 ref_obj_id > 0
>>                 release_on_unlock = true
>>                   - used due to paragraphs starting with 2) above                
> 
> but the problem with ref_set_release_on_unlock() that it mixes real ref-d
> pointers with ref_obj_id > 0 with UNTRUSTED && ref_obj_id > 0.
> And the latter is a quite confusing combination in my mind,
> since we consider everything with ref_obj_id > 0 as good for KF_TRUSTED_ARGS.
> 

I think I understand your desire to get rid of release_on_unlock now. It's not
due to disliking the concept of "clean up non-owning refs after spin_unlock",
which you earlier agreed was necessary, but rather the specifics of
release_on_unlock mechanism used to achieve this. 

If so, I think I agree with your reasoning for why the mechanism is bad in
light of how you want owning/non-owning implemented. To summarize your
statements about release_on_unlock mechanism from the rest of your reply:

  * 'ref_obj_id > 0' already has a specific meaning wrt. is_trusted_reg,
    and we may want to support both TRUSTED and UNTRUSTED non-owning refs

    * My comment: Currently is_trusted_reg is only used for
      KF_ARG_PTR_TO_BTF_ID, while rbtree and list types are assigned special
      KF_ARGs. So hypothetically could have different 'is_trusted_reg' logic.
      I don't actually think that's a good idea, though, especially since
      rbtree / list types are really specializations of PTR_TO_BTF_ID anyways.
      So agreed.

  * Instead of using 'acquire' and (modified) 'release', we can achieve
    "clean-up non-owning after spin_unlock" by associating non-owning
    refs with active_lock.id when they're created. We can store this in
    reg.id, which is currently unused for PTR_TO_BTF_ID (afaict).

    * This will solve issue raised by previous point, allowing us to have
      non-owning refs which are truly 'untrusted' according to is_trusted_reg.

    * My comment: This all sounds reasonable. On spin_unlock we have
      active_lock.id, so can do bpf_for_each_reg_in_vstate to look for
      PTR_TO_BTF_IDs matching the id and do 'cleanup' for them.

>> Any other combination of type and reg state that gives me the semantics def'd
>> above works4me.
>>
>>
>> Based on this reply and others from today, I think you're saying that these
>> concepts should be implemented using:
>>
>> owning ref: PTR_TO_BTF_ID | MEM_ALLOC (w/ rb_node type)
>>             PTR_TRUSTED
>>             ref_obj_id > 0
> 
> Almost.
> I propose:
> PTR_TO_BTF_ID | MEM_ALLOC  && ref_obj_id > 0
> 
> See the definition of is_trusted_reg().
> It's ref_obj_id > 0 || flag == (MEM_ALLOC | PTR_TRUSTED)
> 
> I was saying 'trusted' because of is_trusted_reg() definition.
> Sorry for confusion.
>

I see. Sounds reasonable.

>> non-owning ref: PTR_TO_BTF_ID | MEM_ALLOC (w/ rb_node type)
>>                 PTR_TRUSTED
>>                 ref_obj_id == 0
>>                  - used for "can't pass ownership", since funcs that expect
>>                    owning ref need ref_obj_id > 0
> 
> I propose:
> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == 0
> 

Also sounds reasonable, perhaps with the addition of id > 0 to account for
your desired changes to release_on_unlock mechanism?

> Both 'owning' and 'non-owning' will fit for KF_TRUSTED_ARGS kfuncs.
> 
> And we will be able to pass 'non-owning' under spin_lock into other kfuncs
> and owning outside of spin_lock into other kfuncs.
> Which is a good thing.
> 

Allowing passing of owning ref outside of spin_lock sounds reasonable to me.
'non-owning' under spinlock will have the same "what if this touches __key"
issue I brought up in another thread. But you mentioned not preventing that
and I don't necessarily disagree, so just noting here.

>> And you're also adding 'untrusted' here, mainly as a result of
>> bpf_rbtree_add(tree, node) - 'node' becoming untrusted after it's added,
>> instead of becoming a non-owning ref. 'untrusted' would have state like:
>>
>> PTR_TO_BTF_ID | MEM_ALLOC (w/ rb_node type)
>> PTR_UNTRUSTED
>> ref_obj_id == 0?
> 
> I'm not sure whether we really need full untrusted after going through bpf_rbtree_add()
> or doing 'non-owning' is enough.
> If it's full untrusted it will be:
> PTR_TO_BTF_ID | PTR_UNTRUSTED && ref_obj_id == 0
> 

Yeah, I don't see what this "full untrusted" is giving us either. Let's have
"cleanup non-owning refs on spin_unlock" just invalidate the regs for now,
instead of converting to "full untrusted"?

Adding "full untrusted" later won't make any valid programs written with
"just invalidate the regs" in mind fail the verifier. So painless to add later.

> tbh I don't remember why we even have 'MEM_ALLOC | PTR_UNTRUSTED'.
> 

I think such type combo was only added to implement non-owning refs. If it's
rewritten to use your type combos I don't think there'll be any uses of
MEM_ALLOC | PTR_UNTRUSTED remaining.

>> I think your "non-owning ref" definition also differs from mine, specifically
>> yours doesn't seem to have "will not page fault". For this reason, you don't
>> see the need for release_on_unlock logic, since that's used to prevent refs
>> escaping critical section and potentially referring to free'd memory.
> 
> Not quite.
> We should be able to read/write directly through
> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == 0
> and we need to convert it to __mark_reg_unknown() after bpf_spin_unlock
> the way release_reference() is doing.
> I'm just not happy with using acquire_reference/release_reference() logic
> (as release_on_unlock is doing) for cleaning after unlock.
> Since we need to clean 'non-owning' ptrs in unlock it's confusing
> to call the process 'release'.
> I was hoping we can search through all states and __mark_reg_unknown() (or UNTRUSTED)
> every reg where 
> reg->id == cur_state->active_lock.id &&
> flag == PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == 0
> 
> By deleting relase_on_unlock I meant delete release_on_unlock flag
> and remove ref_set_release_on_unlock.
> 

Summarized above, but: agreed, and thanks for clarifying what you meant by 
"delete release_on_unlock".

>> This is where I start to get confused. Some questions:
>>
>>   * If we get rid of release_on_unlock, and with mass invalidation of
>>     non-owning refs entirely, shouldn't non-owning refs be marked PTR_UNTRUSTED?
> 
> Since we'll be cleaning all
> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == 0
> it shouldn't affect ptrs with ref_obj_id > 0 that came from bpf_obj_new.
> 
> The verifier already enforces that bpf_spin_unlock will be present
> at the right place in bpf prog.
> When the verifier sees it it will clean all non-owning refs with this spinlock 'id'.
> So no concerns of leaking 'non-owning' outside.
> 

Sounds like we don't want "full untrusted" or any PTR_UNTRUSTED non-owning ref.

> While processing bpf_rbtree_first we need to:
> regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
> regs[BPF_REG_0].id = active_lock.id;
> regs[BPF_REG_0].ref_obj_id = 0;
> 

Agreed.

>>   * Since refs can alias each other, how to deal with bpf_obj_drop-and-reuse
>>     in this scheme, since non-owning ref can escape spin_unlock b/c no mass
>>     invalidation? PTR_UNTRUSTED isn't sufficient here
> 
> run-time check in bpf_rbtree_remove (and in the future bpf_list_remove)
> should address it, no?
> 

If we don't do "full untrusted" and cleanup non-owning refs by invalidating,
_and_ don't allow bpf_obj_{new,drop} in critical section, then I don't think
this is an issue.

But to elaborate on the issue, if we instead cleaned up non-owning by marking 
untrusted:

struct node_data *n = bpf_obj_new(typeof(*n));
struct node_data *m, *o;
struct some_other_type *t;

bpf_spin_lock(&lock);

bpf_rbtree_add(&tree, n);
m = bpf_rbtree_first();
o = bpf_rbtree_first(); // m and o are non-owning, point to same node

m = bpf_rbtree_remove(&tree, m); // m is owning

bpf_spin_unlock(&lock); // o is "full untrusted", marked PTR_UNTRUSTED

bpf_obj_drop(m);
t = bpf_obj_new(typeof(*t)); // pretend that exact chunk of memory that was
                             // dropped in previous statement is returned here

data = o->some_data_field;   // PROBE_MEM, but no page fault, so load will
                             // succeed, but will read garbage from another type
                             // while verifier thinks it's reading from node_data


If we clean up by invalidating, but eventually enable bpf_obj_{new,drop} inside
critical section, we'll have similar issue.

It's not necessarily "crash the kernel" dangerous, but it may anger program
writers since they can't be sure they're not reading garbage in this scenario.

>>   * If non-owning ref can live past spin_unlock, do we expect read from
>>     such ref after _unlock to go through bpf_probe_read()? Otherwise direct
>>     read might fault and silently write 0.
> 
> unlock has to clean them.
> 

Ack.

>>   * For your 'untrusted', but not non-owning ref concept, I'm not sure
>>     what this gives us that's better than just invalidating the ref which
>>     gets in this state (rbtree_{add,remove} 'node' arg, bpf_obj_drop node)
> 
> Whether to mark unknown or untrusted or non-owning after bpf_rbtree_add() is a difficult one.
> Untrusted will allow prog to do read only access (via probe_read) into the node
> but might hide bugs.
> The cleanup after bpf_spin_unlock of non-owning and clean up after
> bpf_rbtree_add() does not have to be the same.

This is a good point.

> Currently I'm leaning towards PTR_UNTRUSTED for cleanup after bpf_spin_unlock
> and non-owning after bpf_rbtree_add.
> 
> Walking the example from previous email:
> 
> struct bpf_rbtree_iter it;
> struct bpf_rb_node * node;
> struct bpf_rb_node *n, *m;
> 
> bpf_rbtree_iter_init(&it, rb_root); // locks the rbtree works as bpf_spin_lock
> while ((node = bpf_rbtree_iter_next(&it)) {
>   // node -> PTR_TO_BTF_ID | MEM_ALLOC | MAYBE_NULL && ref_obj_id == 0
>   if (node && node->field == condition) {
> 
>     n = bpf_rbtree_remove(rb_root, node);
>     if (!n) ...;
>     // n -> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == X
>     m = bpf_rbtree_remove(rb_root, node); // ok, but fails in run-time
>     if (!m) ...;
>     // m -> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == Y
> 
>     // node is still:
>     // node -> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == 0 && id == active_lock[0].id
> 
>     // assume we allow double locks one day
>     bpf_spin_lock(another_rb_root);
>     bpf_rbtree_add(another_rb_root, n);
>     // n -> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == 0 && id == active_lock[1].id
>     bpf_spin_unlock(another_rb_root);
>     // n -> PTR_TO_BTF_ID | PTR_UNTRUSTED && ref_obj_id == 0
>     break;
>   }
> }
> // node -> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == 0 && id == active_lock[0].id
> bpf_rbtree_iter_destroy(&it); // does unlock
> // node -> PTR_TO_BTF_ID | PTR_UNTRUSTED
> // n -> PTR_TO_BTF_ID | PTR_UNTRUSTED
> // m -> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == Y
> bpf_obj_drop(m);

This seems like a departure from other statements in your reply, where you're
leaning towards "non-owning and trusted" -> "full untrusted" after unlock
being unnecessary. I think the combo of reference aliases + bpf_obj_drop-and-
reuse make everything hard to reason about.

Regardless, your comments annotating reg state look correct to me.
