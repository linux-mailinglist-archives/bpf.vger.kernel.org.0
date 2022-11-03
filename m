Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92917618A27
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 22:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiKCVEe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 17:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiKCVE3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 17:04:29 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDE426E0
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 14:04:29 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3KwaBD021991;
        Thu, 3 Nov 2022 14:04:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ewbza6W/f+FRr+n9l/BuWesYhfPZWo55iTmMrDbtCjU=;
 b=D2NWfNWTtrpaqKb2scL6YM2BXmpf8ndrP4RvKpHTOSusr4+9aT61VXZ5A3NKvLvEUaAC
 le38rUCCezWubJr6avrZUsuOC1FawmHlsgktnhXu5AvFq92F71dl3emNcivZBQ/ojBwC
 O4dSuKHdkYXA7yGQ06EGV3YL+CemFda1xXZnf9oURHi4CN6zVgz81bkEIK0RibTMqyEh
 /bZQ34dNmpuxLy3T6VV7fBk7joOxBd+VSbyzgdwGE8BNi4rkLrhGSy4ciBUmCWMaSKPc
 1yexwq7IQj8CqX3p1x9eeFv8cCxifYQA8iCRhMD/23kCI25A2gc49ESrzUZ1ooA8D4Lw nA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kkvcwnms9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 14:04:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bELdWya4mKz9P2t0NXfrFeUwqzO4L17uX+hx3oSyhgUQ0Ee+MCj4fFFEPy9qPWXSvBHI64MfrynrxQ947H/N8LuF6P0SkJfuuPsh8YLbMsXhlen2CIunHBWDsrIGKbeF2vesdXF7wOfGLV81XsAkeHGDYA97le8zu2KisqkCJe5vV8TmmLWbZVePCD/rBHXyGMssJjKy0aMDtdT2yu9Cqizha4iag++01odVLbeNNqnMZvaJgInU8towpMeN8CcIYOoz/7iLW9SJ1t7mjxyxLBDEXw7tQqAqzb4Gu+qybQD6e+USzaQvLKBd5TT3UwV/c7Zm4Ff7Tcyn66CpiO1I6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewbza6W/f+FRr+n9l/BuWesYhfPZWo55iTmMrDbtCjU=;
 b=KH3sK4BDSeDTY3jcNnpUpo6/2blAjFp3y6nJ34VDZ9UVRjriCGZVYWFfggNBa84Ft2YhjPTc49zXOSy08AoOKDmRJzNBO1mEE8ZMo6b23N227Pwc/RzZ4p/ElfsOxSYGgaf5XIp943moNllsZULbarQeR4ZR/dUMQe/c5+hotmv+G9XzNrv800tjIg0Bd2jyKdu9tN1NQoi+5CX4IfOZLC7z5+vKCZBlJEVkcSrByuekzsNe32gv+fRdlJstu7eUaGuQ4QHnWVIGn0Cfdxzd1dUnNDPUwzVP52hJeRJCTpzZoMjF038+uaxzIx6Mui1Sg/+8Qg3GRdCuPyh4MkvKLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4580.namprd15.prod.outlook.com (2603:10b6:806:19c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Thu, 3 Nov
 2022 21:04:14 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 21:04:14 +0000
Message-ID: <e55fb180-55b4-6f7d-352d-4674c4449876@meta.com>
Date:   Thu, 3 Nov 2022 14:04:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: Add tests for
 bpf_rcu_read_lock()
Content-Language: en-US
To:     KP Singh <kpsingh@kernel.org>, Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221103072102.2320490-1-yhs@fb.com>
 <20221103072129.2325722-1-yhs@fb.com>
 <CACYkzJ7uWytec60oF1-hRsbVxoDuO9RYZizdChT4Lj7ZJvYcoA@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CACYkzJ7uWytec60oF1-hRsbVxoDuO9RYZizdChT4Lj7ZJvYcoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4580:EE_
X-MS-Office365-Filtering-Correlation-Id: ace9a0d3-4371-4f4c-80f5-08dabddef670
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fWrgi9/w0kPNb/FtKCbv2lONPPeg4BW/zH8LroR+kk0yDgEz6Y2feZUZKs7Q+CiCLB2RrQ0dgb6y/q4fAuU5Uhv0EHnDvOyyj+kkP2g72OLYATSCQdpbUZwJoYl7TqQlF/uFntZB3jUTZOPKAJI8g6paaqK2j0f3yBxz6fF+iJt/vRifr/DMz6v3dI5USK50Wq62NJ2CZ6hVvZ9qIN1mxdy2OMmPggNs0vLEQjRPpCW+TwkwrAFnmCK3lc87Fh+3xcokOZF2/NADaPecQq9c/oCKwtcwNmk1Y9nqi6/Wmmwtu7pSk7tH6ELNGWfwfFx18s0eE5xunVivHuCc8XxHIV73iY8MIB/AAystZ6S9oZnuCUNWbl3RmKTCZFcATiJ5rGRuoEBXGm2TEoYaw3ocacVpF4ss0cMGvKen3Mpt0CB+YyQ+kEV1S9tvnGUaoLu9EU6PsNUPx0c795cBl62acpofhxhz9KaDorpPWpl7uGBnk0mC6QGwx8YtxPXQJOTC0Mj3JBANjP+BX2kjYAYAc8j2tKqMxnhI0bgJaGYY4zARU3tzy6cQf2XmjIUVrVWFbricTfMfo1+UX2yvqng2xTF6PEDzKLFlbibSxZTRKu9vk8NohMNq9h/7m/bgYBOxRaQEEv8fPafUgR/0Z9ZaAyBAUae9ZeHHWt4nj9rWKpyPOH/gNi3jM1tMHznHEWcwtmRLPTYY06Ri/hFiUN1srptS8p5CdS4Z6d26xyGo+zedtkwIzmXQ6h01eE/t2s1W/GOe5IFbulCQ/6knGJXql/goT3j8roN21kV3Uvj5ebI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199015)(83380400001)(36756003)(31686004)(38100700002)(86362001)(31696002)(53546011)(6506007)(6666004)(66946007)(6512007)(2616005)(8676002)(110136005)(316002)(8936002)(4326008)(66476007)(54906003)(5660300002)(186003)(2906002)(6486002)(66556008)(478600001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1JweFV3SnZ4WEtyL2N4WGtUYWxSdHBVMmRaVVZjRVVuZ1lGV2c1SjVkU256?=
 =?utf-8?B?NUg0NVM1U2phZksxRTBnL3lEUXNiOWE4eGZEcFF3SFhILzNxWHFDTzdCWkVt?=
 =?utf-8?B?RXBrbk9ueU91SGd2akRhOTlDNFhpN0NHMWdyYlVJMmV4alJFMlFhbng3bHV3?=
 =?utf-8?B?WlBxUG9kSE0wSHBjemltbDk1bmYzaUUxcVNoTHRRRzdMK0RNRG1YTFZVdzhD?=
 =?utf-8?B?RXFJamFlMVdIN0lsT21KMDBJendoMjhvMkdrY1Z6YWIwcmFZamx1bUZSOUhC?=
 =?utf-8?B?OHZ1Z0JFbExDblRMTFJCY3p2dkJqeWxDaE4vUkdGKys2enlvNWFHT3Q2VmpG?=
 =?utf-8?B?M2JERkFIVFpZdkV4ckMrM3FPbEg4Qm9UTzl4ZUtpZUZmbk90NU1OR1I0clVp?=
 =?utf-8?B?c1RJZU85bEM1UUdtemRzUVRMUTBUU2tRTUtqTmlsdHd2bFJTWWVodE1yOTE1?=
 =?utf-8?B?VDl5V2wxUVVldTN6N3lKTyttcUFaTWVUMTVnVTV4S0pKdkNoTkZ2RmFuamdF?=
 =?utf-8?B?RjlnSXVJOG9CeW5uOEVMaVZ1Y3V0MVQ4WUlQK3FVbzNucU80SkVEUFlvdlha?=
 =?utf-8?B?WHN5c21lVVhYSllQd2FvaTMvUXlqalJiSFhOWFJKeVFENmhHK3gyMTB4dzk4?=
 =?utf-8?B?enhlT0txdVdRNjhxWE9obXRmbXNsR2NJYzZLZzhwOVQ4WmVkYmdqVXRtZXRP?=
 =?utf-8?B?cGVMVU82OHozUmtvalNNVnN5YVpoSnhUOHdKVGo0UW5KWGJUdUR3NHlNQzhD?=
 =?utf-8?B?U3NqUDhVSHAwZ1JxK3BrYnc1N2pIcUgzR2grdDkrODFmTkpuMnVWbnFtUkJE?=
 =?utf-8?B?ektwZGNMY3ZHNjJSaDgvb2M0K05SdmIwTno5MEtzUFl5TW56bGhHTG00RlJC?=
 =?utf-8?B?dmpNcWJQeGwzN0ZvN3R5alNhajRVUU93bDVJVGlUYWw1ZTBLdVZxZkNvNVl4?=
 =?utf-8?B?WDZGUUEyUVpBK1RWRnhPYzdUYk9uVENIMjNnNjJ6alk4M3F6QktRUVpSWjM3?=
 =?utf-8?B?MG5TMWJwYzFrWnc5cXdwSnRnNnI0OFliT004QjFPZ1ZMK1M2bkVoK2R6d0g5?=
 =?utf-8?B?dmJsK2NlL25EdzlGUGg3dDY0TXBBbnVQT282M3ZNNW5qLzRLK3dkR1huNGJ0?=
 =?utf-8?B?UGE1bGF5MjluSU9leG9EZXkrY1dWaTFvRmVtZHJoWmZWdE5vOENJckxtaVB1?=
 =?utf-8?B?N0k4NWh1bm9iM1JaQXRoTjkxWHo2S244UnRZNVJwRDJoQ21LS21OU1FuY0da?=
 =?utf-8?B?MzljZ2hhU0FPSnlQM1lXQ2hKM21JdkZjUlJIMUR2Qmc3SkJLMWhBNDBxanJK?=
 =?utf-8?B?aElEUmlyR1gvMDVVVFJRWkpyVjlyRWt3WXc3QzBtdGhDMzJjcS8zVkFQUHhr?=
 =?utf-8?B?TnQ0WmtTbGxaYmxMREZXUTZkdyt1T3BaRllWY0NEc3cra0FrVU90NzFOcU1S?=
 =?utf-8?B?UkNCM3ZkTXBTSFExVnp3TFcyS3BxaGFNSHdrbjNrb2h5U1B2SDAwa2dXSFRs?=
 =?utf-8?B?SmNPQTZDUmlWVDBpU0xnU3htUlFkUTFqN0NFT012MHQ2b0tZbUZmQ2NPVHhU?=
 =?utf-8?B?QWVqLzc2enlPaVJBdW1zT1JXMTd2NFdQOW9BRmVmS1FmSnZVWFJwTU9NSVpa?=
 =?utf-8?B?YUdUNzBoQTh3bGY2WmdXSy9qZEFhYnFMV1U4bHcxNnpOdU5BNVM2UFpINUpY?=
 =?utf-8?B?SFJnREFMV2VndVJsKzBBMEV3eDNXR3IwcXpKNU82eHdRTTBTZUhSWDk0b0pO?=
 =?utf-8?B?ak9RbHcxem5XK2V5Ulg4UVlhNlpLV0plSDErMXRMcFJ0MERUMCtxVkJZNmVv?=
 =?utf-8?B?aFNlbVlSSldYSVEzYW55T21WUWZIOGUxaDdoU1c0NFF5MVBMSDdYU0xxbklO?=
 =?utf-8?B?ZWo3VjM1dWVRazZPQk1aZDgyb0JwckF1SjUvd3g0b0hvQ1BDcnAvQlQ0alFj?=
 =?utf-8?B?WTArZmVDNXppS0gzdGNCTlJZbnNJZnRpWUFSMlRYc0E1NGNDR1MzdUNCYkVO?=
 =?utf-8?B?OTdmcGpFQUtreE1McjlqNjMrVWNjRlZTTmRsOWJBRXM0MXJPSFdHbEtSMlRi?=
 =?utf-8?B?eHVZaXZTeHlOSUxGWUFaVGZOZXZienZTdGJ5MlM5THdRcXB3T2F5MG5Uc0F3?=
 =?utf-8?B?VDdQNzlCRVdmbWhjYXJoN1JnWk8xTjJWUGgweXF1clNrWEg4ajZYK09HbWNS?=
 =?utf-8?B?OEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace9a0d3-4371-4f4c-80f5-08dabddef670
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 21:04:14.2710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NLsNaFZPdm4ITjJInODShMj/pg0xe7vHOApvrn4HyA3NTEMRthbUf4FBVpwdAyQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4580
X-Proofpoint-GUID: 0EdQPiPzRqnIwNfE6V0XPfFOM4e_YdVI
X-Proofpoint-ORIG-GUID: 0EdQPiPzRqnIwNfE6V0XPfFOM4e_YdVI
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



On 11/3/22 7:54 AM, KP Singh wrote:
> On Thu, Nov 3, 2022 at 8:21 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add a few positive/negative tests to test bpf_rcu_read_lock()
>> and its corresponding verifier support.
>>
>>    ./test_progs -t rcu_read_lock
>>    ...
>>    #145/1   rcu_read_lock/local_storage:OK
>>    #145/2   rcu_read_lock/runtime_diff_rcu_tag:OK
>>    #145/3   rcu_read_lock/negative_tests:OK
>>    #145     rcu_read_lock:OK
>>    Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   .../selftests/bpf/prog_tests/rcu_read_lock.c  | 101 ++++++++
>>   .../selftests/bpf/progs/rcu_read_lock.c       | 241 ++++++++++++++++++
>>   2 files changed, 342 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/rcu_read_lock.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
>> new file mode 100644
>> index 000000000000..46c02bdb1360
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
>> @@ -0,0 +1,101 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates.*/
>> +
>> +#define _GNU_SOURCE
>> +#include <unistd.h>
>> +#include <sys/syscall.h>
>> +#include <sys/types.h>
> 
> [...]
> 
>> +
>> +       task = bpf_get_current_task_btf();
>> +
>> +       bpf_rcu_read_lock();
>> +       real_parent = task->real_parent;
>> +       bpf_rcu_read_unlock();
> 
> The tests are nice, It would be nice to add a comment on what actually is wrong.
> 
> e.g.
> 
> /* real_parent is accessed outside the RCU critical section */

Sure. Will add some comments.

> 
> 
>> +       (void)bpf_task_storage_get(&map_b, real_parent, 0,
>> +                                  BPF_LOCAL_STORAGE_GET_F_CREATE);
>> +       return 0;
>> +}
>> +
> 
> [...]
> 
>> +       bpf_rcu_read_lock();
>> +       bkey = bpf_lookup_user_key(key_serial, flags);
>> +       bpf_rcu_read_unlock();
>> +        if (!bkey)
>> +                return -1;
>> +        bpf_key_put(bkey);
>> +
>> +        return 0;
> 
> nit: Spaces here instead of tabs.
> 
>> +}
>> --
>> 2.30.2
>>
