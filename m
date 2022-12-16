Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920AF64F151
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 19:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiLPS6M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 13:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiLPS6L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 13:58:11 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F712DA99
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 10:58:10 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGIMFnS027876;
        Fri, 16 Dec 2022 10:57:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=I+4dWpgxFaFGFwPK6kIFkuFskQU4Df/HZjys5+3jaQM=;
 b=HzN4xqMyxtnX8qAcB6YifKQNitfi45CXd4pESh6ee365mxPsStHzo56aGQkJarhDkb3M
 fCqxIZuq3gYlNYu3Ux+/T9PqRLADNc2PkkEG4ZXU3flUxc76ZK6hoH+9L/5+DE61aLFV
 HqxfYZu8XSCZvA9nxZL9m4r2hKb+a1skliW6Ch6GAtTOVpaqVj4hRfr2gYaMrXAsWPyJ
 8mZTlnQiy3hhs+UFSO3HyDGn54r/Pypqu2Gs521YRF96q9Bw9CdEFkrlteaX5w/9Cd8R
 LaiMob7VZU8koXSq6MEZ5SVaysYV5AMx+5MATkhB0C1GDx+4exmN2jDzsuxQIXjmnct4 Qw== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mgwvu06xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 10:57:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PilYdYmsLNYFhFvcoR1y3eCfuRvxoC/9CRH2Ib7i2RTk4tsP2hvwPiroGYAQ27BPa1ysw7yLQoNqZxMiyvngpewaaKSj0/h4HKnRjn/9Kc6g2HUhaKrOp+WkqbIW/jk5VyskYjOpFL5122CJtJMToLV1MRbq0cs9HjztNbl4jn4FhVHNPJRe05va7GD16NPFD4XlB25eXyongMg9Mh7jjU2thdGVngP0rKBQwEGJGwHbs8YGfwFmWn6hTEgMuBoqAsfwyGzqeZS5x70vXhKJU762U46uCXr0bX+JSwsLgPicnLwrLhThrEm2ctGUY7DDaPzbybP/R+Shnv73fG5qhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+4dWpgxFaFGFwPK6kIFkuFskQU4Df/HZjys5+3jaQM=;
 b=hSWxw9M+cli43Nksy8zhezL9WvBDZ93IJPIY410kLdU1SbD+Gq0G1828ewo19vkjNU75v4XRL9Bn7ax5hvKFJXU3GwnketjUhJ7uXJsesNF5hKjU9cdFwQWkjxbQpvFL+whKtLaHYE1a+7MnnWNfJKV5JM5oz4ruqnEtzxUcDBelIPqRRYNK3MiUxQRYsGgFmOHqi9DX+mHgclvPnmG0FueBtqUTb3Hb2tB8NkLAKtWJLtGSxKwCBPEhwg2xjyMonyfnL73+RrMXdjCzkMmN4QvE9ntxuVKBOS+xktzfXtPWIEhB80ZxobjK+MxZZfBDCl4MRr+jx6nIa8WTPNX4HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3497.namprd15.prod.outlook.com (2603:10b6:5:170::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 18:57:40 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.015; Fri, 16 Dec 2022
 18:57:40 +0000
Message-ID: <338ef17c-81be-4b5a-69a0-9fa01c1ee650@meta.com>
Date:   Fri, 16 Dec 2022 10:57:37 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [bpf-next 2/2] selftests/bpf: add test cases for htab map
Content-Language: en-US
To:     Tonghao Zhang <xiangxia.m.yue@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
References: <20221214103857.69082-1-xiangxia.m.yue@gmail.com>
 <20221214103857.69082-2-xiangxia.m.yue@gmail.com>
 <73b9ef21-de67-e421-378a-1814ffbc263f@meta.com>
 <CAMDZJNUef_1aBCGoGkC5FpP3MvD-SciYn1jQ7Kkmcwk-gkzDKw@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAMDZJNUef_1aBCGoGkC5FpP3MvD-SciYn1jQ7Kkmcwk-gkzDKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR07CA0057.namprd07.prod.outlook.com
 (2603:10b6:a03:60::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3497:EE_
X-MS-Office365-Filtering-Correlation-Id: a45a3a37-7b87-4402-8810-08dadf9767bf
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h5+HnhkLYWb1RE8RcUej+DvRm9UnCj6Zbf1ZvgYbD8EnNS9CNMo/3thV9gKlvWWuLwSgZo0snfwC67YU+iYlD7C5KnspiTMz4t3Mu8WNG1Gyng6S+IfVRpqZFuR+qCuS/T6Dx0cmv8cyo15tf4lNKuzFnuUOnInMCRUsJ7hqxPBC6HNzv83KZ5EE5828AJEvhPSzzqxyUaImf3egPHmLn7fYy95KKokDAR+D6Xp3WIMVVVilvFD+xks35tk+V3KaSWPNVxFRVRSt8j8kZ1E/3O5/BBY7ZKCRJjUFZ5kOt4THp9j+lLEgTRvamuedZi1wlECLrwoW8uo3wg5CldJNHjnrTvw6CIwzY8fX1I8zTPgBEhUWlFS4L4hCZyu4KHkK6iY17f90ae4JlPoVcYfBRIPKs3sR71M1M9vLm4vGtYq5yJfOVbyJlL7IdBX2ZcMDU6k8worI+JUuRgnOrbmBfEsOS608A5acKiGhEz2dYrrgrITCTMqUblSeEpMRAt1HnUFoN/JZ/8RmcXkkP5ZzH+9NSoquYyiwdKhqtDwLW89izb2jzObRPlbO1iweobFSRtWB0BUPvoMZXUD6yiOZH3bcapSivfvroDRkxZZJ8t3iIC/3sGzU+Zm1C0dIwcx9H+GmUWec0YC3uiHoB0KR55z/Jqdb7MFmh/KGO9FKdaCRCB+LVJlxxtI1rDB5QIDqtIg9MMfm8JRVJC8hM9UzJddUxuSX6qJhq8InDk+liIQlPOxDlX0JqIrGkvqW8l/MyTwyIFmDtTkb5wmI3C9tbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199015)(2906002)(186003)(6506007)(6512007)(6486002)(36756003)(38100700002)(66556008)(41300700001)(66946007)(8936002)(86362001)(83380400001)(53546011)(5660300002)(316002)(66476007)(7416002)(54906003)(6916009)(31696002)(8676002)(4326008)(2616005)(966005)(478600001)(6666004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akU0R2ZHRWNZTkpkNW0yeEJWbGFHNjF5VmJtQlhyczB6d1ZBUUdQcFBqbVZ5?=
 =?utf-8?B?Z0djdkx0a0dTQWxTNlBIYUxNbzI5d0lFWE4vdmgrcmNZejMxR1MwcTdGdTIw?=
 =?utf-8?B?cEdRdFhleC8yd3JBMXpaQ05SdUVpbmJQbTJZakZYSjJyMGxTeXF3dEx4dnZO?=
 =?utf-8?B?QUlkMm1vUDkxU1NTMXg0TmZ3d2NQLzhyeXpVSE5oMllpV1BJYXlqSFlCQlVt?=
 =?utf-8?B?OWl3R3cyVGc2MTBZSm9YMGdGL1JxRm1YQlBKelRONFFNNDBScG5FUGxQalA0?=
 =?utf-8?B?VGlnK3dXTHRNSUJhNmlldnIrYlRXcmRBNHFpMzJEaG9Pd3RkTUQ3S0YzK2N0?=
 =?utf-8?B?RVdaUnZTSHB6bmFLWHBqbkJFZWVGWGg3b25iWEVmK0JRS1RkM1BFVjRWNzdw?=
 =?utf-8?B?cE9kTWtBWmhoMUdacXJyUmhiNmQvRlFMeVBOTGNQdXNVd2hQeHFTSVRkdVEw?=
 =?utf-8?B?cDNkcXdHbmpVeXUrQURhTnlRQVpRazNxaTFFZmx3SWR1OE1HdTIvVXBFdmlE?=
 =?utf-8?B?QmtnY2FmT2hZTGJnd3ZsSU80QmhUNFJGODlpQ0VGNk1OVmRQckUzY2xiYVJs?=
 =?utf-8?B?QWIvaUpJajVMVE9WdjRhNUNlQ1RlZDhaSkF3dmxoZEZLWEUrdk9rSmdHK2h4?=
 =?utf-8?B?dG9Hc3NPc2ZoYjlDaEF4MGJZQmhtaldmeDNkV09ObHBXWFZDZklQOW9iZjZl?=
 =?utf-8?B?NkVWVW1TekdzSjJ5MUtsTWtVM3Q5WDh2S01PWVlUN2kva3M3clJjTmJxZUZN?=
 =?utf-8?B?a0o3K0hsTHFQRHlHM29kM1NlaG1DeXIwRWxPUEN0L3BxSzJlOGY2YXZpR2Fa?=
 =?utf-8?B?ZFNQV29OUzZsVTZ6dTFPemRuYm9tMURBT0ltaDJwdk1ScG4xR0Q5MDczQWhp?=
 =?utf-8?B?YjVETzdPWiszNUZ5QmlETnR3bE5rcjVzWlVsQm9lNFZWdWRBOC9jSEVIOWgy?=
 =?utf-8?B?MjA4cXJ2R1BmMHpWWC85a1g2MGtPenNhd3FWYTZWMDNTRFZGU25PSzJoZ2tN?=
 =?utf-8?B?aVYrbDdnSkZSSm5oTUJMZFB0QlR5KzV3Unl2SE5nb1RlMVdnTzc3UzhiM3dZ?=
 =?utf-8?B?SDB5NDVhQ0d3bFZzaXFaRXZKYkRWeHI1Ny8zdHowSys1Y3h6YjEzWlNITzFs?=
 =?utf-8?B?TUc0aXZYVzFybDhOR3cvajk0UGRHWDdFZmRreHBXRisyMjRLK2tZVFY1bFJi?=
 =?utf-8?B?R0FrWXR4RVJleEFoVGNjcmFSalhjdk81N2x3emd3WEVwd2k5S09yU3MvT01x?=
 =?utf-8?B?alhKNVU3SGZabXZjaTRVdjhUYVI5YzFWbktmZlpxS2Z6NWtjNWpBVS9kbUhp?=
 =?utf-8?B?aEM5ZlprdHQ5QnQ0VWhWRHVyc3kzbUVpTTNlYzVMNWRlUGxvUjdYZklWQzNU?=
 =?utf-8?B?V0lFTEo2MlRwUFpaMGNKOWczMEpaSWJCSDY2VmF0TlJ5WkU0c2hxM3Iyc1lm?=
 =?utf-8?B?NTBzb2lQdG1TcXVZOWV5WHFaajlIUWJZQzV3NTV6Ky9wQ3o5Z0NDeER2WXNQ?=
 =?utf-8?B?WnVUcGVMREhqU0ZBek9mdEo1K2pQcURNdHlzUFNCQ1JkY1lHcSswK0JaQUZu?=
 =?utf-8?B?VzNRQjR0aXNQaE9wZ2EwVzNBbE5EZnhtaFhBU2xsSEpTa0ZtV203UXU1bkE0?=
 =?utf-8?B?U2Q3b296c0wzZXRkb0h0b3RsaEZ6alk5eXAwSkV3d0RFQzNjNmlNTzNqU3Jt?=
 =?utf-8?B?TFRrSU4wSDJLRW52a2prcldBWVcwbTNaV0JPcWJUUkw2QncyaDRMZmtidGNG?=
 =?utf-8?B?R2xKOHZoVjEreElNeEZpRWRSeXB6dC9ydE1KWHU1bFBMUUhaRjBmaVBYWHJ0?=
 =?utf-8?B?YXZwaWg5TTdwbHVyM2ZOOFcxb2ZQQzIwM2NhdXIwYWYrZEtRc3JRblBEdTBV?=
 =?utf-8?B?YWZzZjJmNzd4TXZwbFhDeTM5UHFkbFh4KzhxK2x6MkNtWmlsYWJ4TmorOFdE?=
 =?utf-8?B?SGRud2dEQlRwRmJwZWY3dHpJMWlnc29kTXhHU21rU2M5U09TNnFoNlNBdU1O?=
 =?utf-8?B?ZTE1L2hDUjBBUlhsdHJTVnpxelFHVnorWkQrOURPZUJnYW9CYzNHdDlvQzRm?=
 =?utf-8?B?MUdLL2hrN2JmOFpleDVZRy9ZbXpWY05SL05HdHRFQkROa211Nk5aaS8xVEtC?=
 =?utf-8?B?OEwzWHJpeXNnNWVVWFVJV1hyQmY5MWZMeS8vR2RucTRzZkFKd3FQRU9qQ2x2?=
 =?utf-8?B?T0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45a3a37-7b87-4402-8810-08dadf9767bf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 18:57:40.2195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FAT6tF/BsPxyqmF0yyV1bDTITXO6vEa5ykW2hFZArFGR5qfs85+YzFyhXniwyP9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3497
X-Proofpoint-GUID: P_TGc6uzqOSgbTBMwOEzrffdAsZIkTwL
X-Proofpoint-ORIG-GUID: P_TGc6uzqOSgbTBMwOEzrffdAsZIkTwL
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_12,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/16/22 2:36 AM, Tonghao Zhang wrote:
> On Fri, Dec 16, 2022 at 12:10 PM Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 12/14/22 2:38 AM, xiangxia.m.yue@gmail.com wrote:
>>> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
>>>
>>> This testing show how to reproduce deadlock in special case.
>>>
>>> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>> Cc: Andrii Nakryiko <andrii@kernel.org>
>>> Cc: Martin KaFai Lau <martin.lau@linux.dev>
>>> Cc: Song Liu <song@kernel.org>
>>> Cc: Yonghong Song <yhs@fb.com>
>>> Cc: John Fastabend <john.fastabend@gmail.com>
>>> Cc: KP Singh <kpsingh@kernel.org>
>>> Cc: Stanislav Fomichev <sdf@google.com>
>>> Cc: Hao Luo <haoluo@google.com>
>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>> Cc: Hou Tao <houtao1@huawei.com>
>>> ---
>>>    .../selftests/bpf/prog_tests/htab_deadlock.c  | 74 +++++++++++++++++++
>>>    .../selftests/bpf/progs/htab_deadlock.c       | 30 ++++++++
>>>    2 files changed, 104 insertions(+)
>>>    create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
>>>    create mode 100644 tools/testing/selftests/bpf/progs/htab_deadlock.c
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
>>> new file mode 100644
>>> index 000000000000..7dce4c2fe4f5
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
>>> @@ -0,0 +1,74 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/* Copyright (c) 2022 DiDi Global Inc. */
>>> +#define _GNU_SOURCE
>>> +#include <pthread.h>
>>> +#include <sched.h>
>>> +#include <test_progs.h>
>>> +
>>> +#include "htab_deadlock.skel.h"
>>> +
>>> +static int perf_event_open(void)
>>> +{
>>> +     struct perf_event_attr attr = {0};
>>> +     int pfd;
>>> +
>>> +     /* create perf event */
>>> +     attr.size = sizeof(attr);
>>> +     attr.type = PERF_TYPE_HARDWARE;
>>> +     attr.config = PERF_COUNT_HW_CPU_CYCLES;
>>> +     attr.freq = 1;
>>> +     attr.sample_freq = 1000;
>>> +     pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
>>> +
>>> +     return pfd >= 0 ? pfd : -errno;
>>> +}
>>> +
>>> +void test_htab_deadlock(void)
>>> +{
>>> +     unsigned int val = 0, key = 20;
>>> +     struct bpf_link *link = NULL;
>>> +     struct htab_deadlock *skel;
>>> +     cpu_set_t cpus;
>>> +     int err;
>>> +     int pfd;
>>> +     int i;
>>
>> No need to have three lines for type 'int' variables. One line
>> is enough to hold all three variables.
>>
>>> +
>>> +     skel = htab_deadlock__open_and_load();
>>> +     if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
>>> +             return;
>>> +
>>> +     err = htab_deadlock__attach(skel);
>>> +     if (!ASSERT_OK(err, "skel_attach"))
>>> +             goto clean_skel;
>>> +
>>> +     /* NMI events. */
>>> +     pfd = perf_event_open();
>>> +     if (pfd < 0) {
>>> +             if (pfd == -ENOENT || pfd == -EOPNOTSUPP) {
>>> +                     printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
>>> +                     test__skip();
>>> +                     goto clean_skel;
>>> +             }
>>> +             if (!ASSERT_GE(pfd, 0, "perf_event_open"))
>>> +                     goto clean_skel;
>>> +     }
>>> +
>>> +     link = bpf_program__attach_perf_event(skel->progs.bpf_perf_event, pfd);
>>> +     if (!ASSERT_OK_PTR(link, "attach_perf_event"))
>>> +             goto clean_pfd;
>>> +
>>> +     /* Pinned on CPU 0 */
>>> +     CPU_ZERO(&cpus);
>>> +     CPU_SET(0, &cpus);
>>> +     pthread_setaffinity_np(pthread_self(), sizeof(cpus), &cpus);
>>> +
>>> +     for (i = 0; i < 100000; i++)
>>
>> Please add some comments in the above loop to mention the test
>> expects (hopefully) duriing one of bpf_map_update_elem(), one
>> perf event might kick to trigger prog bpf_nmi_handle run.
>>
>>> +             bpf_map_update_elem(bpf_map__fd(skel->maps.htab),
>>> +                                 &key, &val, BPF_ANY);
>>> +
>>> +     bpf_link__destroy(link);
>>> +clean_pfd:
>>> +     close(pfd);
>>> +clean_skel:
>>> +     htab_deadlock__destroy(skel);
>>> +}
>>> diff --git a/tools/testing/selftests/bpf/progs/htab_deadlock.c b/tools/testing/selftests/bpf/progs/htab_deadlock.c
>>> new file mode 100644
>>> index 000000000000..c4bd1567f882
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/progs/htab_deadlock.c
>>> @@ -0,0 +1,30 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/* Copyright (c) 2022 DiDi Global Inc. */
>>> +#include <linux/bpf.h>
>>> +#include <bpf/bpf_helpers.h>
>>> +#include <bpf/bpf_tracing.h>
>>> +
>>> +char _license[] SEC("license") = "GPL";
>>> +
>>> +struct {
>>> +     __uint(type, BPF_MAP_TYPE_HASH);
>>> +     __uint(max_entries, 2);
>>> +     __uint(map_flags, BPF_F_ZERO_SEED);
>>> +     __uint(key_size, sizeof(unsigned int));
>>> +     __uint(value_size, sizeof(unsigned int));
>>> +} htab SEC(".maps");
>>
>> You can use
>>          __type(key, unsigned int);
>>          __type(value, unsigned int);
>> This is more expressive.
>>
>>> +
>>> +SEC("fentry/nmi_handle")
>>> +int bpf_nmi_handle(struct pt_regs *regs)
>>
>> Do we need this fentry function? Can be just put
>> bpf_map_update_elem() into bpf_perf_event program?
> Hi
> bpf_overflow_handler will check the bpf_prog_active, and
> bpf_map_update_value invokes bpf_disable_instrumentation,
> so the deadlock will not occur. In fentry/nmi_handle, bpf does not
> check the bpf_prog_active.

I see. Yes, fentry program does per prog recursion checking instead
of global bpf_prog_active.

> 
> Other comments look good to me, I will send v2 soon.
>> Also s390x and aarch64 failed the test due to none/incomplete trampoline
>> support. See bpf ci https://github.com/kernel-patches/bpf/pull/4211.
>> You need to add them in their corresponding deny list if this fentry
>> bpf program is used.
>>
>>> +{
>>> +     unsigned int val = 0, key = 4;
>>> +
>>> +     bpf_map_update_elem(&htab, &key, &val, BPF_ANY);
>>> +     return 0;
>>> +}
>>> +
>>> +SEC("perf_event")
>>> +int bpf_perf_event(struct pt_regs *regs)
>>> +{
>>> +     return 0;
>>> +}
> 
> 
> 
