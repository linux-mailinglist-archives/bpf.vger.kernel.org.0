Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C2066A2D1
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 20:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjAMTYR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 14:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjAMTYO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 14:24:14 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDBD52C7E
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 11:24:12 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DJKtso030271;
        Fri, 13 Jan 2023 11:23:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=HeEYFWb8aVf/vwqtCpxO4a9NnEjqocbRbm01dDHjQlQ=;
 b=Im5Dq51H5F5MaBx0Pq1BTYtGQqPIUWKtj8HSHt2qAoNkrgaINZgNuhkgVhRbViay3pWb
 q4kWlF3T9UR+6ruV3+8ZMjfecmBLkCIEBUZ2unlFVmxixQvvvoSQAcG5s4bbt/+LqEqN
 vFia24nQfBD3Z6qjsSEfeiyqCLr89HNADiISBk3+hJ2AoRE5WYeCoKZ+BVOfPhq9rCIM
 0MRxXws7vTD+3m60eepEWsCTF+/cKBn77Unp7+vao4xMaL0p8npoz1bCNx4xn6G5i3W1
 ES61JT30hLZB2IQ3vaufpwUizPDOU4oJC9Zwgle0kmK0YU6MpqTFRL9YbDZdC0JodEK4 bQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n2v7kmub2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 11:23:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oR0TF03M3upxtUCP+o/LtuJKtMrAj5F+rNWRt2wB+NCwft3OQU85e1VH1apnPe+xy5aSbo8QdLfMui4EtExVCDqwFZ52bolEjRehb8MXBzAQ9bh8k/wB3vhW0QZDm7IN3sNZdFdiqcEJmYvBJl5xPoiCTrjuTut2TafsZSh37K93dNYApT/lyvMOuBghTBlENmj8KWYxe0L4yCdi8j+ciqfdchMiMjGGwHWkkyjA+JAAL67X/UpnCycnqO/VZdHbznhsTKu3XfarQ2MHy1ifroZV3e+CrdNop+QLQEG9iecngsZJrGQz8bfO6EdXl5rY1yZ6Xf8OeNiCqusm+yP9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HeEYFWb8aVf/vwqtCpxO4a9NnEjqocbRbm01dDHjQlQ=;
 b=X7BSO816qL5iD/lPX17ZvNkQuqZyXhXyXembqpBauBHY5qGJA0DQsTdpRTaeNUSv/2+01pbYxQx5weqrukeKBw7sM9Tt1j3Vc2VzglHhwHqMNC4EhHLWkjkb5qHGwmo40tuHodm9Z9QDuqsmZNzfhw94g0v8RWiaOrMUnCCvyA9FSJUb67zEB20LbW35q9WQF8WDDI/t3zko1cFi5UrAvjxdCoFUQIXs9nte6/Y9TS96XLrRgPZ7ZmHZTU4h0LgrbM8U6Aq43Rs7ZoOdZhpQaei263Z4vEjkhR4c2xVfXJKAgc9SWQLzPtAvj7PLyb4Nzr4C/fsK30ny0aVMr02nqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW3PR15MB4027.namprd15.prod.outlook.com (2603:10b6:303:4f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 19:23:54 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 19:23:53 +0000
Message-ID: <8c8cc92a-7437-728f-4f38-f278d9f35f07@meta.com>
Date:   Fri, 13 Jan 2023 11:23:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RFC bpf-next 0/5] Support for BPF_ST instruction in LLVM C
 compiler
Content-Language: en-US
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        david.faust@oracle.com, James Hilliard <james.hilliard1@gmail.com>
References: <20221231163122.1360813-1-eddyz87@gmail.com>
 <CAEf4BzbNM_U4b3gi4AwiTV5GMXEsAsJx8sMVA32ijJRygrVpFg@mail.gmail.com>
 <874jt5mh2j.fsf@oracle.com>
 <1155fda8d54188f04270bb72c625d91f772e9999.camel@gmail.com>
 <20230112222719.gdxwdocfutpbxust@MacBook-Pro-6.local.dhcp.thefacebook.com>
 <790ab9fd-dbcf-4593-1634-6f706675cde2@meta.com> <87a62mhl3m.fsf@oracle.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <87a62mhl3m.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:a03:338::30) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW3PR15MB4027:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d9fce0-3fd3-40b9-56ba-08daf59bb54a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cER7JylnBoGjtBRGFnsoSxsWx+0XbbwKr24N6UpbeAP8V53D5Q25PEBc0+uY5kOGOLxX4qLgWPiu63Dz22zcAjN7FPQNB334nNz6tsB0sDVRAv5X56fabT1vo5zqDHdTR8vT5G2y9jK4eB3Wp5yV+lMTE/spGKh35u7U9LEE8FRPrIX7bu+n7TBDm0pOlx5ZXU2QjWMPs6hpwWmCUi4hj8t/om7/dL5dvYJZkRHsLhwZaMTr9blmSgSLk9jC5aQdkXQo6rAVe9hI/27suOrWpt6QpBYzTqTZGD3vgiUmRz0Si4377qrHsfY21Qwumk3/s0bxzYcu7xraTmzCwO5I+vXz1cXveTql+XRnPdT8ZVGbA04DBIs2hRkpflF1lufe3C0Ar//jD8e2MneMA705losxdXJZToawjn+UcEzzLZb0tR9PRwWBuDen9ZGJcvNRU0zi/8iV2v/m/GjrYlyKV8gZeo/rpgNgaGDSOLToOumX2aELw5dFdj1OkZkTd8+l+1wl7JykUEOxv48P4kOUVp9op1Z18NXPFaTu0CoqWb7YeSTATyoQqyfNhM8jcIN/lRAY3k6hz1daPPiO4JHdqkFMl7C8qrlevdyyfs+D9IoYd7MBhtDaPF40gBVoKMeFJ2Zn7CUcGYUU6WbRhgUmvEhCJQWMh6CgflLFof1yAP0bzJT0vZxPGIhNkj4poF+Z4Zq09H/Tj3f4AqDy+GNEzN9OEWsKm5OevFUAP7f04P69k7NErAd96Kax/4Ksr7jAm83Uc39kHt/lWs4pWW59xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199015)(8936002)(7416002)(5660300002)(41300700001)(83380400001)(38100700002)(2906002)(36756003)(31696002)(86362001)(966005)(186003)(31686004)(6486002)(478600001)(6512007)(6506007)(8676002)(6916009)(4326008)(66556008)(66946007)(53546011)(66476007)(316002)(2616005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG9ZNjNScUJTcDNiSzBqZjk2SzhTTzgxRTZZMGlyVGtJWE43OGlWdjBzNVJx?=
 =?utf-8?B?Y3NwUDFSbWZUeGlrakozWkVzMmxZZDZCcm5PTHBTRjc3MzdvRFJUeG83Q3hB?=
 =?utf-8?B?NWVpMFRIR0l2VDExaWdvZmxsbEsrNGNMUXhtSDdIRmJEYnpxNng1bVdheDFJ?=
 =?utf-8?B?bzFvRWNxR3hJTzk0U1pmai9XMER1L2Q5VUxCVWlBeUtrNlBFZ0VsZFc2UmhH?=
 =?utf-8?B?bC8rWEJ6MFpqcDA0a1p4WmRoOEJVZ2Q1Yi9HdmhBOFBIV1h5VGNndlNGQUhN?=
 =?utf-8?B?d29BU01pMmNGRXJxQmxBdXRGYy9FaDl3VFVmQ0U0VDFGQXRQbUtMQVpZKzJ6?=
 =?utf-8?B?dnE5Q0xSMG1pSWFFKzRiZUc1WHNpOWpLdVltRGdsWndIOVF1N09aTGM5TzZa?=
 =?utf-8?B?bEF4bzFjcnlKczdFUm4vWnlqWDJZZk1nVW53ZmNqZ0NxUWsxMkRicG1nNHNy?=
 =?utf-8?B?WjFPRzVsTEp1aW94M21IZGJtalptQy9mcHlxNlZHUlBQS1dERk05RW5SaStU?=
 =?utf-8?B?bHU3d0RGNWRyREJVVW55MEhwZFZyeUdTemoxSWZyVlZRWUdIeVZWOTRab1VZ?=
 =?utf-8?B?czQzbHBmUWFrQnFja1hJRUdCMGZvT2pQbWlOUEZrVmM5Ukluei9veEw1OGxB?=
 =?utf-8?B?cjgxT3hjOW1ldlNzZGkxNFdGbjc1dC9OQzR6aUVRbHRPS2VQQ0pkVXUxSUJ1?=
 =?utf-8?B?Q1ZuZUdqRW9zM1BwZFlIa1JNenYzN01GUFFZa0ZTSmJqZkl6em5BOU1uOVdn?=
 =?utf-8?B?ZU9iU1lhRU9SL2lua05seGNhaUVoeVNoazRZTVBoREFLMjFYRkVQTlBQY3do?=
 =?utf-8?B?Wmc3bDE4QWhEdXVXVjA5c25FcENSNVIyN2JJVkU2MDVLMFdSTXNpaTFFSkhH?=
 =?utf-8?B?cjN1RUFjbTNlNSszU1cvYWhsLzhEeXNoQTRPU2c3MVlsVnF6Z0d2c1Q3VmJu?=
 =?utf-8?B?UXpsNjJZU01uMzUvdk1ONHlJNEc2ZE9vMkdyQzl0emUxckFyWTlTMGEyWjB5?=
 =?utf-8?B?aVpwMnZFTVp3VG05ekl0NlRJWnFtR3k4cUcrMHh0a3BGQVNLeStKZzRmQjYv?=
 =?utf-8?B?MHZiYklhYmFidWx0WnpMVkVDTWwrR2tFZGw2Skp0TzBuVjVrQkwwUG1DNTRD?=
 =?utf-8?B?cFlkTEZGOG8vZWpOVE0wWEZHUnpDV0JHZHFRWEVCSmpvOWtJaU0rVnlkS0lv?=
 =?utf-8?B?NkJhUkRyemdVZm9tR1pId1hSUjBkdGRUS3BYL2swTERDL3B3NjJkekRnWVVj?=
 =?utf-8?B?bHp4SzBTNEN0ZVp0NUIvakkyTGU5YnFOZmRENDhEdVpyQVJLMVhGWUZnWmZx?=
 =?utf-8?B?NXZudGNZSDhKa0VEN0VLczNWMkJrSUV4Zlk4Ny81V2Y5Y2xyYkJLamJhTnRV?=
 =?utf-8?B?RjBsUHRrRnBOQThodXpDUE1qc3NIUXl6ZzgwendhR0dUbm5IMlA1SmVIZFNH?=
 =?utf-8?B?K3VlS0dDRGxCVVdHcXlVMmc5Y3lrem9oUHhBeHhJalpRcURlYkVKNnRtTjdV?=
 =?utf-8?B?OGV0UHJvdWMzY2FCb0Nza2RWeWpnWmxlZlZGL1IyNHI3b2RXSWlpalpoUWdm?=
 =?utf-8?B?S0JTb3E2bzIwREVFdkU1UjdKNjROL3BLZW8vTDN3YTRGd1J5aHI3V0Myay91?=
 =?utf-8?B?Y0ZEaXl6L2FiQTRpeDVNNTdKUWJQVnBqOXlMMDI3K2pNbGRQS3A4K3oxMEps?=
 =?utf-8?B?SW1FKysrSTdxV0tIcDJaL1lEVjd3N1NPb0E5REdvWXpaTjV4WnFlMGlYQjhL?=
 =?utf-8?B?NEsxdFVOQVE5SmFBTDNvNVdrNjRsTzA0d0NuNCttYy9PR3JqdXNOU0N4R0dW?=
 =?utf-8?B?RHplMnd5L2RncEk4YWtVNVBuYStubWhJM2NraDdUYStqME9JekZnVlo0ZVQv?=
 =?utf-8?B?TlZ4RG1YcThFQVQ4MEMvcmF2ZHo5WHNxVkM1N3NjN3dYTkhtbnExbUMzOEZU?=
 =?utf-8?B?Unl5Nk1ObUc0N3F3cmN2ZGYybVRNSklENVVMU09FQ3VpbGlybkpOMy9mUTk3?=
 =?utf-8?B?dUN4VzBPQkN2aTJPdW9xU00vZU9jNWxwdldLSXV1ZnBhZmZEd3hRUWZmbTA0?=
 =?utf-8?B?NktteDVPRUEzTGRJMzFudEg1aGFRMEoxbnlnRWVMVmxORUwrdHFCVGltc0VI?=
 =?utf-8?B?NHBuUVl3b3B6V2tkVWZKZVZmTEFjcEpvY0w3Yzg3OFIvaDF2aFZqcW9XOFE2?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d9fce0-3fd3-40b9-56ba-08daf59bb54a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 19:23:53.8505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0iSFdOUz/hWeTYy0bnVuk5U2CIVYIzhNXZNBP42VGgZKHRjDtWZgLkZGZSCyV0Ey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4027
X-Proofpoint-ORIG-GUID: wUOzCEYBm5QQRW7s-GE5Jk7Fss1sWSvR
X-Proofpoint-GUID: wUOzCEYBm5QQRW7s-GE5Jk7Fss1sWSvR
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_10,2023-01-13_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/13/23 12:53 AM, Jose E. Marchesi wrote:
> 
>> On 1/12/23 2:27 PM, Alexei Starovoitov wrote:
>>> On Thu, Jan 05, 2023 at 02:07:05PM +0200, Eduard Zingerman wrote:
>>>> On Thu, 2023-01-05 at 11:06 +0100, Jose E. Marchesi wrote:
>>>>>> On Sat, Dec 31, 2022 at 8:31 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>>>>>>
>>>>>>> BPF has two documented (non-atomic) memory store instructions:
>>>>>>>
>>>>>>> BPF_STX: *(size *) (dst_reg + off) = src_reg
>>>>>>> BPF_ST : *(size *) (dst_reg + off) = imm32
>>>>>>>
>>>>>>> Currently LLVM BPF back-end does not emit BPF_ST instruction and does
>>>>>>> not allow one to be specified as inline assembly.
>>>>>>>
>>>>>>> Recently I've been exploring ways to port some of the verifier test
>>>>>>> cases from tools/testing/selftests/bpf/verifier/*.c to use inline assembly
>>>>>>> and machinery provided in tools/testing/selftests/bpf/test_loader.c
>>>>>>> (which should hopefully simplify tests maintenance).
>>>>>>> The BPF_ST instruction is popular in these tests: used in 52 of 94 files.
>>>>>>>
>>>>>>> While it is possible to adjust LLVM to only support BPF_ST for inline
>>>>>>> assembly blocks it seems a bit wasteful. This patch-set contains a set
>>>>>>> of changes to verifier necessary in case when LLVM is allowed to
>>>>>>> freely emit BPF_ST instructions (source code is available here [1]).
>>>>>>
>>>>>> Would we gate LLVM's emitting of BPF_ST for C code behind some new
>>>>>> cpu=v4? What is the benefit for compiler to start automatically emit
>>>>>> such instructions? Such thinking about logistics, if there isn't much
>>>>>> benefit, as BPF application owner I wouldn't bother enabling this
>>>>>> behavior risking regressions on old kernels that don't have these
>>>>>> changes.
>>>>>
>>>>> Hmm, GCC happily generates BPF_ST instructions:
>>>>>
>>>>>     $ echo 'int v; void foo () {  v = 666; }' | bpf-unknown-none-gcc -O2 -xc -S -o foo.s -
>>>>>     $ cat foo.s
>>>>>           .file	"<stdin>"
>>>>>           .text
>>>>>           .align	3
>>>>>           .global	foo
>>>>>           .type	foo, @function
>>>>>     foo:
>>>>>           lddw	%r0,v
>>>>>           stw	[%r0+0],666
>>>>>           exit
>>>>>           .size	foo, .-foo
>>>>>           .global	v
>>>>>           .type	v, @object
>>>>>           .lcomm	v,4,4
>>>>>           .ident	"GCC: (GNU) 12.0.0 20211206 (experimental)"
>>>>>
>>>>> Been doing that since October 2019, I think before the cpu versioning
>>>>> mechanism was got in place?
>>>>>
>>>>> We weren't aware this was problematic.  Does the verifier reject such
>>>>> instructions?
>>>>
>>>> Interesting, do BPF selftests generated by GCC pass the same way they
>>>> do if generated by clang?
>>>>
>>>> I had to do the following changes to the verifier to make the
>>>> selftests pass when BPF_ST instruction is allowed for selection:
>>>>
>>>> - patch #1 in this patchset: track values of constants written to
>>>>     stack using BPF_ST. Currently these are tracked imprecisely, unlike
>>>>     the writes using BPF_STX, e.g.:
>>>>          fp[-8] = 42;   currently verifier assumes that
>>>> fp[-8]=mmmmmmmm
>>>>                      after such instruction, where m stands for "misc",
>>>>                      just a note that something is written at fp[-8].
>>>>                           r1 = 42;       verifier tracks r1=42 after
>>>> this instruction.
>>>>       fp[-8] = r1;   verifier tracks fp[-8]=42 after this instruction.
>>>>
>>>>     So the patch makes both cases equivalent.
>>>>     - patch #3 in this patchset: adjusts
>>>> verifier.c:convert_ctx_access()
>>>>     to operate on BPF_ST alongside BPF_STX.
>>>>        Context parameters for some BPF programs types are "fake"
>>>> data
>>>>     structures. The verifier matches all BPF_STX and BPF_LDX
>>>>     instructions that operate on pointers to such contexts and rewrites
>>>>     these instructions. It might change an offset or add another layer
>>>>     of indirection, etc. E.g. see filter.c:bpf_convert_ctx_access().
>>>>     (This also implies that verifier forbids writes to non-constant
>>>>      offsets inside such structures).
>>>>         So the patch extends this logic to also handle BPF_ST.
>>> The patch 3 is necessary to land before llvm starts generating 'st'
>>> for ctx access.
>>> That's clear, but I'm missing why patch 1 is necessary.
>>> Sure, it's making the verifier understand scalar spills with 'st' and
>>> makes 'st' equivalent to 'stx', but I'm missing why it's necessary.
>>> What kind of programs fail to be verified when llvm starts generating 'st' ?
>>> Regarind -mcpu=v4.
>>> I think we need to add all of our upcoming instructions as a single flag.
>>> Otherwise we'll have -mcpu=v5,v6,v7 and full combinations of them.
>>> -mcpu=v4 could mean:
>>> - ST
>>> - sign extending loads
>>> - sign extend a register
>>> - 32-bit JA
>>> - proper bswap insns: bswap16, bswap32, bswap64
>>> The sign and 32-bit JA we've discussed earlier.
>>> The bswap was on my wish list forever.
>>> The existing TO_LE, TO_BE insns are really odd from compiler pov.
>>> The compiler should translate bswap IR op into proper bswap insn
>>> just like it does on all cpus.
>>> Maybe add SDIV to -mcpu=v4 as well?
>>
>> Right, we should add these insns in llvm17 with -mcpu=v4, so we
>> can keep the number of cpu generations minimum.
> 
> How do you plan to encode the sign-extend load instructions?
> 
> I guess a possibility would be to use one of the available op-mode for
> load instructions that are currently marked as reserved.  For example:
> 
>     IMM  = 0b000
>     ABS  = 0b001
>     IND  = 0b010
>     MEM  = 0b011
>     SEM = 0b100  <- new
> 
> Then we would have the following code fields for sign-extending LDX
> instructions:
> 
>     op-mode:SEM op-size:{W,H,B,DW} op-class:LDX

Right, this is what I plan to do as well. See my incomplete llvm
prototype here:
   https://reviews.llvm.org/D133464
