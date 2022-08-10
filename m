Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DDF58F1E2
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 19:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiHJRt2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 13:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiHJRs6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 13:48:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003A18C03B
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 10:48:51 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AGuPF1003023;
        Wed, 10 Aug 2022 10:48:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=2hoPLefXYIXIjXyw281Gu7BGOLw2r/4xhTZ8s8oCTwk=;
 b=qd3S6zYh3bu++d2p01Ow7Z8opB/v7Vm6ybAugcUJQpu4fGAkPbsVKyUnBKiW/itvWnAp
 yCPNFuo7OPQnpo53Yl1J6/96cvCTm5eSbE2nY1MMR6QKVvsVL8rwtoT/KEzhUtSSH3CZ
 0eELto64O4vDUP33B5OBWZJ4V7Ee6/4AD/A= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hvdb6acwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 10:48:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHAK1/3f91bwOLLDQOuGRs9BH31WQXCADZqKFPen1m0ds51nSYJK9dQtMC+LNX1faI02gxcC82qENixlf2wHmkC1gNYKrXOumb0t/YRb5e/24FskLMI9JWEYOsA1TSdfgvJekJ1A28o0sjGaXMktCsHngG4rzWswdGmVAAcirM42D/nPZCQwLLKOStH0uKeK3pmL+C+JMnsJqQsHWVgZxMESmh94fe7sQJ0Idd6mbTbIv30W+kX9pWO4gvXpFNIRzKTR+yCEnzFl3PI+RoDQS2cc1M5CmY0lS4aGV5XvGpKpnyhQaaiGELt0+OBJssizW42DUk8CMinUHulZn+DB6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hoPLefXYIXIjXyw281Gu7BGOLw2r/4xhTZ8s8oCTwk=;
 b=Ze8Obi6149sN/MifoC9V1cWc0j2h/kIst6wNQogZ7jHQwX/RERwYpZQheRjYqMtK8BsWzE6prG7r3rA8oageKo2qHaJsRc0Y66tYeaqxQnf6LFufXpwLJwX+eRr4d0Uk7bIOkFyfElT8bmyp0QqRPTsWKcN/4KGCvIArn1O8aFAnv0styDnXV3avjg49pL3CAJ8s/Tm8LoNM88nVI3wxbsRlFTsIVN436Sus8loRMlYAWA8gXxmfYf3WRT3AxOshfoRMi7ZURF0pafn2s7pYjzQORMwZOnN0tKSVrIKX9PnGtSMK92jcPUPnVefKM2FP5CYtcnCik6bJJM/DFYSBMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM5PR15MB1289.namprd15.prod.outlook.com (2603:10b6:3:b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 10 Aug
 2022 17:48:35 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::8500:4ce4:51fb:6a8e]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::8500:4ce4:51fb:6a8e%7]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 17:48:35 +0000
Message-ID: <e34cd3ef-81da-4993-da6c-ff104b585423@fb.com>
Date:   Wed, 10 Aug 2022 13:48:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [RFC PATCH bpf-next 11/11] selftests/bpf: Add rbtree map tests
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
 <20220722183438.3319790-12-davemarchevsky@fb.com>
 <be9fa91f-820e-27d0-f66b-9c2e1164681c@fb.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <be9fa91f-820e-27d0-f66b-9c2e1164681c@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0078.namprd02.prod.outlook.com
 (2603:10b6:208:51::19) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d7b044c-262b-47c3-eaf6-08da7af88c3b
X-MS-TrafficTypeDiagnostic: DM5PR15MB1289:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4AIr0scpnYbNgJN5FT6mZn9Fm0wVRDOnoKGap6d+XCzwq6YlSBGYtM9AXOuRVMu13VrbQDJnJkSmMhLnH8I5+JZNldZ1OM2digo4H/fKBMb0eUR01rvsq/LjdO+3j15EypPlvpYQ9eAUIlK/bZxjn917swxYkLkenaVxPFqXAODy/ZRxFs471AQd2lT5pVJqMfYOpLLeBrA1yxFV/MIJjFdiF5POJeCkVDSkzsbTnfYA4PXUcelx6umK44SHcRjhclponKnyTOPI+eC+a0Mr+wcVEGDAhzj0007zm5SN/JJg2XyK7y1ZgSBVEJkpt6OQY7xzYeMfNF1sj+CWeR5iOIj0JJ+MSaHcVgjzHQgKcdKkE5EzI7CqWI+oOVvrJ6D04gMpR/ClPe20PA1VI5Wav7DLd5hajYxGYpyB1o9uyTvWDANKek17ncwX4p47KwCjGR8FL7gYNT/cuZDtUV7ZJlb3PwQNbBta7GuWRGaYsxwVIPk6V1UfgXy49x5r2yq/yrTWNZ5lBQPij6+vkoLOWHIdOWLGyKaowuHU8arDPHbTa6el9a2sArF0A3yYPRkEI9DrazQm7OYkZlgtpTAU1AFZgNjrTuz+zwGZnGD0rjNHt8bZxIIFQ6+axTkpI7Zg8KsyOhaKIcfXn8hMny7Wx7XEnTqlJL8XmJoCRcSqgDSskVzLwSIiRiqpnE9+Ao/fiwAIO3/DPf6Mo1YKteWaC35HQQ9/iUszv0XXY84DuT5e1T6CZMb9x/pNv7dY0ey3CLsS3PMUBGu1ObJigiNn7UzECqnlM1IHPvokvMBrwsSq92MqXxZk9tFzFx1uHKRUYB2cBimDMNT+g6SpCMRz3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(36756003)(31686004)(316002)(86362001)(2616005)(66556008)(4326008)(8676002)(66476007)(54906003)(66946007)(8936002)(6486002)(6666004)(83380400001)(478600001)(5660300002)(41300700001)(38100700002)(31696002)(186003)(2906002)(6512007)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWlEdDJVLy9XWWdFVnkwSEdlSXZ6Z1BQajlnR2I5dHhnazREL3RQajg1alZ0?=
 =?utf-8?B?Y2gyT0NXTCtEMGhkVktXQ0VkTFpndjdPZFY4TXJGOHN1c1JBZVpDWWVvRVBq?=
 =?utf-8?B?R3BIZEtTS082QUNCRmJiTzgwUlhaV1pDc1lXUDhvZ1RLdUtLOXU0dHozNGUv?=
 =?utf-8?B?ZHg0YzBoV3Q1S2FDRmRBeVk2N0ZqZzg1ZW9tQ1J1ZjlKL3N6Z2V2VHpFQXVP?=
 =?utf-8?B?SG1ocmVULzVEL3BFaFY4cElQNlNscTZQZTJYQW9lNmxaSlloTHIwVk9sM1J3?=
 =?utf-8?B?NHdaeE1FSFBIeEZ5c09mcnhUMFlnSTczYXZnbndjV0U1RVU2M1Q2b1FiQ1dX?=
 =?utf-8?B?VWdqZXNsSHVQaTJRM05vWWVGcU50MkFmYVRUM1RKakNpVjU5eXRzaXl0UFV2?=
 =?utf-8?B?UlZtOHc4YWNWcEtKemVHWnFEWnhiME5FMlZoSUhsV0VNWkFMN2w4bFJrN1Qv?=
 =?utf-8?B?KytlTU5qNi9HbnJBdG0wSzdNaHJoTHRzNUpDZlZydzZVVXlLd0QvRStSRDRC?=
 =?utf-8?B?TlZja0QzZU9RQWIrNHl4T1hUTzZQNW0zL3BxRTdad0lIVDBGdFI5MWZ0WllE?=
 =?utf-8?B?STJOR1dCVU1LUTdPSnJQbG9TYzN6eVpqNHI2NnNKWkpvNlZ1WVM2b1RheTZq?=
 =?utf-8?B?N2c4a3BKL21YazBaYmdCa00xa0VGbTNzckQrc2tnT3hmWUZuYW1IQXlGSENt?=
 =?utf-8?B?TFEyd3h1Y1B6a25WMTNhQWZNNlBBZGlwQkZiWTNicjdTTnJ2ZXdkUWZFR2E0?=
 =?utf-8?B?QllOdjFzOU1wWW5WNlJTL3RhY3lXRy81cXc2Z3J1Zm1oMmZ5eHBXRU8rRUlB?=
 =?utf-8?B?NEgzSlNEQllabndxNGxCb1hTYVV4RlU3TE5FTE1Wc0I1L1hSajAySm1LaDJC?=
 =?utf-8?B?OTJIdFp0ZldBbGFoRXdTWER6d2M1RXNzbXRIS3FqUmJScGV1S05TZkVaR1cw?=
 =?utf-8?B?eGN5UW5INFBwMzA1S3JCWHpXYUFreENYZzlTdlkyOEtkU0tMc2ZiTmJuODNk?=
 =?utf-8?B?Y2hXcnRMcnZZTnNyOURXdG9XTG8vVkFRR2JQaE9xTURaZEJQZVpISEhBT2dJ?=
 =?utf-8?B?TmpVTjAyRldBSGF1amNhR3Vsd0QyVzVMbXl4UmxsL3JxdmJlT25lcUxMT01M?=
 =?utf-8?B?RENtZTQwZUIvTHdSU3UzdnR2RUtrTEtYQmFyVjgzUm85czl6cEpwcDBLUFdN?=
 =?utf-8?B?Q2U0a0srbzdwcWsxRzhIc3Jndnp3U3ZmYTI0cE40bUh6RHVKSyttVjhHMkF4?=
 =?utf-8?B?M1lURGQ2ZXE3YWRMa0RpUG9tMFJoWEFBSFgzUG8xY3NUOXZOWEFIYkF0dFll?=
 =?utf-8?B?TmkvLzFuSGxmRXV4RHpxMG0xajFiVjc3ZmFWWlJuMGUzMjNUSHZCdVkxYzdp?=
 =?utf-8?B?cGVmU3cwYXdRZ3BCV3pWZnI1cnRVcUI4TlFHK3htRGJqYWp0NW5Xa2pSS0tX?=
 =?utf-8?B?YVhqTWZ6bUM4c3hRb0w4K3EwTitxSFZnRUJJT2FrZWNkT1NacWJaTS9zUDkz?=
 =?utf-8?B?YXcwQ0pPeDNuc2hxVGgwd1hadlhkcnd2aVRwdHBOcGZMTE1HTm5ickg4K096?=
 =?utf-8?B?anpCZjY0RjdrMHlWK2NqWTQvdTI0Q291ZVFCL3BjQmZSS0dsNDZpc2ZDbGdE?=
 =?utf-8?B?emxaS0trWDFZUzBENm9CVzNuc2orUk5HWFlVWGllZnBUckpmbVZ6S0RpNUp0?=
 =?utf-8?B?dEY3Z1NpczIwM3kwWGRuZktqTDVsUG52bXc0OG0zdDNZaHdoUVNNYVUwUFVX?=
 =?utf-8?B?cVBXdW1QVTZGbFZSRTIvckpnNGhzVG1HN2FSVmRUM09ybUNmNHlxZ00wMVRH?=
 =?utf-8?B?Mmp3WnFqM2RVOGx2SCszUk9pKzJ4TndCeFRzVS9Fb0Rxb1BubTVuQXZPekp6?=
 =?utf-8?B?RUszcHZaZlc1aFR2RU9pY1RFNnRNNVJVYjNmVk5VbW56eG1kdFdlVjlwMW5M?=
 =?utf-8?B?TXBzOTUyanY4Qlg3eGNtSFRmMXRWMGpQcytRS3pjdVd4T29tYks1QTBTR25k?=
 =?utf-8?B?UmowSHVxVXRTSVJMMS9hanJjK0V4L3hnMkQ0bTZUazRuTjBaQnpoOVcraXFO?=
 =?utf-8?B?Zmc0cW9FUGx0ZkNWSzRFWlhrZUdVRGhoek16YTlqb2p3UGpMeHU5M29RcUgv?=
 =?utf-8?B?cmlNYkhzVmkweDB0ZVA5ZU0yOUNmL3pvWFMwRGdGMDhBN3F1TXcyeTY1MVNp?=
 =?utf-8?Q?/RTXBcEAa9x414+2POWBuC0=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7b044c-262b-47c3-eaf6-08da7af88c3b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 17:48:35.0655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zkm+I8n/SzAB3j12oN+9hOgDxO2Pjvvpwu5uCvvAvYPU5miA5VhA5BjlRzGAg4p//0j8LzEzSGsjqCkuDSRMeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1289
X-Proofpoint-ORIG-GUID: UmcevySjwx4lTpW1mL0_ui5i2-rFduDD
X-Proofpoint-GUID: UmcevySjwx4lTpW1mL0_ui5i2-rFduDD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_12,2022-08-10_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/28/22 3:18 AM, Yonghong Song wrote:   
> 
> 
> On 7/22/22 11:34 AM, Dave Marchevsky wrote:
>> Add tests demonstrating happy path of rbtree map usage as well as
>> exercising numerous failure paths and conditions. Structure of failing
>> test runner is based on dynptr tests.
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> ---
>>   .../selftests/bpf/prog_tests/rbtree_map.c     | 164 ++++++++++++
>>   .../testing/selftests/bpf/progs/rbtree_map.c  | 111 ++++++++
>>   .../selftests/bpf/progs/rbtree_map_fail.c     | 236 ++++++++++++++++++
>>   .../bpf/progs/rbtree_map_load_fail.c          |  24 ++
>>   4 files changed, 535 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/rbtree_map.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/rbtree_map.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/rbtree_map_fail.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/rbtree_map_load_fail.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/rbtree_map.c b/tools/testing/selftests/bpf/prog_tests/rbtree_map.c
>> new file mode 100644
>> index 000000000000..17cadcd05ee4
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/rbtree_map.c
>> @@ -0,0 +1,164 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
>> +
>> +#include <sys/syscall.h>
>> +#include <test_progs.h>
>> +#include "rbtree_map.skel.h"
>> +#include "rbtree_map_fail.skel.h"
>> +#include "rbtree_map_load_fail.skel.h"
>> +
>> +static size_t log_buf_sz = 1048576; /* 1 MB */
>> +static char obj_log_buf[1048576];
>> +
>> +static struct {
>> +    const char *prog_name;
>> +    const char *expected_err_msg;
>> +} rbtree_prog_load_fail_tests[] = {
>> +    {"rb_node__field_store", "only read is supported"},
>> +    {"rb_node__alloc_no_add", "Unreleased reference id=2 alloc_insn=3"},
>> +    {"rb_node__two_alloc_one_add", "Unreleased reference id=2 alloc_insn=3"},
>> +    {"rb_node__remove_no_free", "Unreleased reference id=5 alloc_insn=28"},
>> +    {"rb_tree__add_wrong_type", "rbtree: R2 is of type task_struct but node_data is expected"},
>> +    {"rb_tree__conditional_release_helper_usage",
>> +        "R2 type=ptr_cond_rel_ expected=ptr_"},
>> +};
>> +
>> +void test_rbtree_map_load_fail(void)
>> +{
>> +    struct rbtree_map_load_fail *skel;
>> +
>> +    skel = rbtree_map_load_fail__open_and_load();
>> +    if (!ASSERT_ERR_PTR(skel, "rbtree_map_load_fail__open_and_load"))
>> +        rbtree_map_load_fail__destroy(skel);
>> +}
>> +
>> +static void verify_fail(const char *prog_name, const char *expected_err_msg)
>> +{
>> +    LIBBPF_OPTS(bpf_object_open_opts, opts);
>> +    struct rbtree_map_fail *skel;
>> +    struct bpf_program *prog;
>> +    int err;
>> +
>> +    opts.kernel_log_buf = obj_log_buf;
>> +    opts.kernel_log_size = log_buf_sz;
>> +    opts.kernel_log_level = 1;
>> +
>> +    skel = rbtree_map_fail__open_opts(&opts);
>> +    if (!ASSERT_OK_PTR(skel, "rbtree_map_fail__open_opts"))
>> +        goto cleanup;
>> +
>> +    prog = bpf_object__find_program_by_name(skel->obj, prog_name);
>> +    if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
>> +        goto cleanup;
>> +
>> +    bpf_program__set_autoload(prog, true);
>> +    err = rbtree_map_fail__load(skel);
>> +    if (!ASSERT_ERR(err, "unexpected load success"))
>> +        goto cleanup;
>> +
>> +    if (!ASSERT_OK_PTR(strstr(obj_log_buf, expected_err_msg), "expected_err_msg")) {
>> +        fprintf(stderr, "Expected err_msg: %s\n", expected_err_msg);
>> +        fprintf(stderr, "Verifier output: %s\n", obj_log_buf);
>> +    }
>> +
>> +cleanup:
>> +    rbtree_map_fail__destroy(skel);
>> +}
>> +
>> +void test_rbtree_map_alloc_node__size_too_small(void)
>> +{
>> +    struct rbtree_map_fail *skel;
>> +    struct bpf_program *prog;
>> +    struct bpf_link *link;
>> +    int err;
>> +
>> +    skel = rbtree_map_fail__open();
>> +    if (!ASSERT_OK_PTR(skel, "rbtree_map_fail__open"))
>> +        goto cleanup;
>> +
>> +    prog = skel->progs.alloc_node__size_too_small;
>> +    bpf_program__set_autoload(prog, true);
>> +
>> +    err = rbtree_map_fail__load(skel);
>> +    if (!ASSERT_OK(err, "unexpected load fail"))
>> +        goto cleanup;
>> +
>> +    link = bpf_program__attach(skel->progs.alloc_node__size_too_small);
>> +    if (!ASSERT_OK_PTR(link, "link"))
>> +        goto cleanup;
>> +
>> +    syscall(SYS_getpgid);
>> +
>> +    ASSERT_EQ(skel->bss->size_too_small__alloc_fail, 1, "alloc_fail");
>> +
>> +    bpf_link__destroy(link);
>> +cleanup:
>> +    rbtree_map_fail__destroy(skel);
>> +}
>> +
>> +void test_rbtree_map_add_node__no_lock(void)
>> +{
>> +    struct rbtree_map_fail *skel;
>> +    struct bpf_program *prog;
>> +    struct bpf_link *link;
>> +    int err;
>> +
>> +    skel = rbtree_map_fail__open();
>> +    if (!ASSERT_OK_PTR(skel, "rbtree_map_fail__open"))
>> +        goto cleanup;
>> +
>> +    prog = skel->progs.add_node__no_lock;
>> +    bpf_program__set_autoload(prog, true);
>> +
>> +    err = rbtree_map_fail__load(skel);
>> +    if (!ASSERT_OK(err, "unexpected load fail"))
>> +        goto cleanup;
>> +
>> +    link = bpf_program__attach(skel->progs.add_node__no_lock);
>> +    if (!ASSERT_OK_PTR(link, "link"))
>> +        goto cleanup;
>> +
>> +    syscall(SYS_getpgid);
>> +
>> +    ASSERT_EQ(skel->bss->no_lock_add__fail, 1, "alloc_fail");
>> +
>> +    bpf_link__destroy(link);
>> +cleanup:
>> +    rbtree_map_fail__destroy(skel);
>> +}
>> +
>> +void test_rbtree_map_prog_load_fail(void)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(rbtree_prog_load_fail_tests); i++) {
>> +        if (!test__start_subtest(rbtree_prog_load_fail_tests[i].prog_name))
>> +            continue;
>> +
>> +        verify_fail(rbtree_prog_load_fail_tests[i].prog_name,
>> +                rbtree_prog_load_fail_tests[i].expected_err_msg);
>> +    }
>> +}
>> +
>> +void test_rbtree_map(void)
>> +{
>> +    struct rbtree_map *skel;
>> +    struct bpf_link *link;
>> +
>> +    skel = rbtree_map__open_and_load();
>> +    if (!ASSERT_OK_PTR(skel, "rbtree_map__open_and_load"))
>> +        goto cleanup;
>> +
>> +    link = bpf_program__attach(skel->progs.check_rbtree);
>> +    if (!ASSERT_OK_PTR(link, "link"))
>> +        goto cleanup;
>> +
>> +    for (int i = 0; i < 100; i++)
>> +        syscall(SYS_getpgid);
>> +
>> +    ASSERT_EQ(skel->bss->calls, 100, "calls_equal");
>> +
>> +    bpf_link__destroy(link);
>> +cleanup:
>> +    rbtree_map__destroy(skel);
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/rbtree_map.c b/tools/testing/selftests/bpf/progs/rbtree_map.c
>> new file mode 100644
>> index 000000000000..0cd467838f6e
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/rbtree_map.c
>> @@ -0,0 +1,111 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
>> +
>> +#include "vmlinux.h"
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
>> +
>> +struct node_data {
>> +    struct rb_node node;
>> +    __u32 one;
>> +    __u32 two;
>> +};
>> +
>> +struct {
>> +    __uint(type, BPF_MAP_TYPE_RBTREE);
>> +    __type(value, struct node_data);
>> +} rbtree SEC(".maps");
>> +
>> +long calls;
>> +
>> +static bool less(struct rb_node *a, const struct rb_node *b)
>> +{
>> +    struct node_data *node_a;
>> +    struct node_data *node_b;
>> +
>> +    node_a = container_of(a, struct node_data, node);
>> +    node_b = container_of(b, struct node_data, node);
>> +
>> +    return node_a->one < node_b->one;
>> +}
>> +
>> +// Key = node_datq
>> +static int cmp(const void *key, const struct rb_node *b)
>> +{
>> +    struct node_data *node_a;
>> +    struct node_data *node_b;
>> +
>> +    node_a = container_of(key, struct node_data, node);
>> +    node_b = container_of(b, struct node_data, node);
>> +
>> +    return node_b->one - node_a->one;
>> +}
>> +
>> +// Key = just node_data.one
>> +static int cmp2(const void *key, const struct rb_node *b)
>> +{
>> +    __u32 one;
>> +    struct node_data *node_b;
>> +
>> +    one = *(__u32 *)key;
>> +    node_b = container_of(b, struct node_data, node);
>> +
>> +    return node_b->one - one;
>> +}
>> +
>> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
>> +int check_rbtree(void *ctx)
>> +{
>> +    struct node_data *node, *found, *ret;
>> +    struct node_data popped;
>> +    struct node_data search;
>> +    __u32 search2;
>> +
>> +    node = bpf_rbtree_alloc_node(&rbtree, sizeof(struct node_data));
> 
> If I understand correctly, bpf_rtbree_alloc_node() may cause reschedule
> inside the function. So, the program should be sleepable, right?
> 

My mistake, will change alloc flag to GFP_NOWAIT.

>> +    if (!node)
>> +        return 0;
>> +
>> +    node->one = calls;
>> +    node->two = 6;
>> +    bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));
>> +
>> +    ret = (struct node_data *)bpf_rbtree_add(&rbtree, node, less);
>> +    if (!ret) {
>> +        bpf_rbtree_free_node(&rbtree, node);
>> +        goto unlock_ret;
>> +    }
>> +
>> +    bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
>> +
>> +    bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));
>> +
>> +    search.one = calls;
>> +    found = (struct node_data *)bpf_rbtree_find(&rbtree, &search, cmp);
>> +    if (!found)
>> +        goto unlock_ret;
>> +
>> +    int node_ct = 0;
>> +    struct node_data *iter = (struct node_data *)bpf_rbtree_first(&rbtree);
>> +
>> +    while (iter) {
>> +        node_ct++;
>> +        iter = (struct node_data *)bpf_rbtree_next(&rbtree, iter);
>> +    }
>> +
>> +    ret = (struct node_data *)bpf_rbtree_remove(&rbtree, found);
>> +    if (!ret)
>> +        goto unlock_ret;
>> +
>> +    bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
>> +
>> +    bpf_rbtree_free_node(&rbtree, ret);
>> +
>> +    __sync_fetch_and_add(&calls, 1);
>> +    return 0;
>> +
>> +unlock_ret:
>> +    bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
>> +    return 0;
>> +}
>> +
> [...]
