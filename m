Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B95E5BDC93
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 07:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiITFup (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 01:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiITFui (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 01:50:38 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021A43DF24
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 22:50:37 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JMsh8j013943;
        Mon, 19 Sep 2022 22:50:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=g7jAifRhU+JYC98SFKNLHj9QoG0kVQFPKdzQz3NivTk=;
 b=K6UY/5YOy2JOOPg0tKOn8+cHQzSAMYRsfUhsMopa/41GdT287KrqpCVds29XUst2njXq
 aALKo5SfYpAFV1E1+yJFwAcHj5Hf+iVycdf6m1CNjISymHPaNjtYz0aaJRbczg3Awa9m
 XDL9iNxa2wBqyvOc/UtlsAN+fY359+ANqmk= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jq0y6j0s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 22:50:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezP4ORmiJiPO574AiHLR/nh0WVre3YHTmv+HUvbPH+dsZxMcmWjHyjQisnxRm5UsceAx6pdgsPzXgfguJcAHhC8IRyC0Uv2dcPmOwUd39Ud/hQtOCakgC36TmUeMtEpyRRsHFDYMQAQs/81w4A8JRr90NMX1/4NRITDcGK15/IAoM1fyup5o3NYuh/xYZMY7Jto0BnjpTAnw0UCWYhKdIKw2jLlVGwvQnrM3tfmQEXE7HmLgxCntmjX+2urjhecy0KmOSFVESRY+PbvwXH9BYB+nFjiygrKvpdPxPql0oRPmVrLHUsBaIRyGrGu41qzDcjvHM4/oNN/TEq+x5glEFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7jAifRhU+JYC98SFKNLHj9QoG0kVQFPKdzQz3NivTk=;
 b=Zbl24DFR4N748DLXjeO/q2ipbbHjw/Ex8GECligbLcuAxcOmb2oNFWp2CfaDKX5WcYUumq0DjS3WNlXtcmlwnFq7LqH7n3dMvpq7/06QT3NGB8w+eNYeUoZkTxKuAQlYl7ORnLKeXThZxIOaWw33KUhijmtxFaOyET1zmCQLQMQnVWSdK9sY0vC4LiBSZVqgj3mEKkNdBbR65oHU6GaXoAeivX7knhhxVgd0cW9in7OxM/2v807lBSrzZ+HmjY4rTNCOAhE8leplIX0KNpwozQorjb1nP7PHZqHfZhXizEuCM6IkTwkcFU6/5yWTT6TOavAL1XkqAcjRs5jQ8NoDrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1670.namprd15.prod.outlook.com (2603:10b6:903:139::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 05:50:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 05:50:19 +0000
Message-ID: <55e96fb0-6a3a-8162-5c3e-41b10dd6a292@fb.com>
Date:   Mon, 19 Sep 2022 22:50:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add test verifying
 bpf_ringbuf_reserve retval use in map ops
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20220914123600.927632-1-davemarchevsky@fb.com>
 <20220914123600.927632-2-davemarchevsky@fb.com>
 <26e3f391-076e-49ce-89d6-21aa16f3c054@fb.com>
 <CAP01T75E9sp5Aq159Zjmrpmaue+gYkN66qjA06opDhLhbuUzAw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAP01T75E9sp5Aq159Zjmrpmaue+gYkN66qjA06opDhLhbuUzAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:207:3d::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CY4PR15MB1670:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2fc65d-3a12-4229-1ad2-08da9acc005f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prY15rsYMPOsRfXzeIk1DKx6NHINFuAvbLmiG23bHNklMX8P37+5AHweItnb8S7eaDvGdVHgA6yJxXdz5bgcpfyXm6Xeboot1n51V+6flP3SAo34rht5aH90zIP1BTopbMNDqIUfkSJylQ9mbTxcu5BZ/fdWu7EZSb872F1y085Fn92ZBtCcgB9u3ChYLI8i9I3vuVOklTledCiksyteorGL63h5HY0sYrP99Lgg6R6MjHFXOSw+0Q2EQd+0eOwvc4NW2N0bphMc6S91J32/5vnEy4IhZkW34EcaK7+vC0Ta0oN0wZrkbYAT2KFuq4Q1FPeSlqFOlXJ/2hwf/AU+3TBwNOxrxtwaN3AGI7tjIsy/32QWtfBgzl9SS73aocVoEi7+Ino22nr+lsFxCSLvJE1llEJ6y/WpWTrvkeiibr0/xCtAARU54ZAThi1hwzFUHlFvM6avGh0ukuhlYYTvR5WLcCWydHxapgRlMM2MBREFVMjMKVxpPs4p5MgL0nbhkuSfE5b5akrs+uAK2KL4Jt3VXX45j/Bv8yuSJkJaXqQC+9z1A3SQ3iOZyoRhFyDBUZLCny4BjDGIax2b/vBSCpJNBHC8CLRjAwFu0tFR/cKBJpCw/FhYTkE5GYSjFLtH13U19Bml3ih1QWkUEeMFGwCj5FeLG4jr5vDbZQmxLkeSX+WL7MUD3zhVrzvH8C9/+mdKZUFoo2/c8sEQfgBv/JlsOiC07VVUBiAOZU/tsPFkdAia5xx3ISLOeTlitDXdHV5EQ3WVEbnwERAmF9lMNaCCBDqyh5DDx9AHcWNMJAd2GQxr7g5vSCWRkER0iYkIy3eiOcFbn2vGWQ1cL6DYCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199015)(2906002)(2616005)(15650500001)(53546011)(6506007)(186003)(6512007)(84970400001)(86362001)(31696002)(6486002)(316002)(54906003)(6916009)(8676002)(4326008)(41300700001)(66946007)(66556008)(66476007)(478600001)(36756003)(6666004)(31686004)(8936002)(5660300002)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTlNODBncTFFSjlkOHV5bFlYNURmQVRKbWg4UVlSK2QwSkZJYy9KUmFrd3RQ?=
 =?utf-8?B?bGt1MkdWc21sandRV2pHWG8wVHJjTjRnNW12NVUrd2N2Qy9KWFoxNlM0bWhV?=
 =?utf-8?B?NnVMdmdhZThqVXpCZEVHMFNOd0VMYUMrSk9OOWpKRmJuamQyeTlKOW8wcExB?=
 =?utf-8?B?Smt5eEgzUjJmUHVxMURXZkJmaW5MY2c3eVBqbkFCNENsemJYNmNsblc5b0NV?=
 =?utf-8?B?cXhIWGhkcnFnL2RWTzRsVC9jdzAyUzExSVZwY0dhelFjNEZkdlh2cXJFbktD?=
 =?utf-8?B?YWNvK1ZXQW81NnV6ekVUdFVOSU5XSlZpc1JoZzhVeSt4UFNZaGh6SUJvaWI3?=
 =?utf-8?B?bXkyTUZGOC9pYnNwaXRYZysrSk4rWnptNzNrbTBDTXVVYUlYeEVFTnBUbHBD?=
 =?utf-8?B?UlNKNmZIZEZsRW5NV2c1MlZEODdtTWkxZkkxdkQyNmV3U2NTU0M2TWpLVEJm?=
 =?utf-8?B?WXNYNEU4ZzgwczBESTBsaXhxbnJQNnNwQU03V1JGWVdMSEpTWjJhcTdoUWtx?=
 =?utf-8?B?Y3M5RkYwbmw1ckxsMTBEVkRVWjY5SHZCdit2YXlKZEZSUHZGT2QxWXBKZXZ2?=
 =?utf-8?B?TkJUaUFGMFZ2NndsbHdTL1p1bHV6QmJIeWlXSGJDN1UwSmVUWnRGZTljRG5n?=
 =?utf-8?B?dzRzSjRGZjZDOTdMQks4RzFoQUdwdEtxTks4ZFBMSFFKYlo1MmZUUHA3NElX?=
 =?utf-8?B?eTU5bitibzlNa0U5NUZyQThIOC9ZdjdDNHZJVldlckhxa2pmWUxjeHFqaGRN?=
 =?utf-8?B?T0tSdEJ4N3NKY2MycTFvYUlUUHlJT2tFS21pcVF6OCtJZjNpYmRpdndYRFFT?=
 =?utf-8?B?Tm9nTExmdDg3SndCTHdqcE9ackczcE5YaDhqNzhSSm82K21DNUdqNklTZ3ov?=
 =?utf-8?B?cVUyc2VuU1ZKcG1EazlTK2xERkFXNHF6SWd6TjlsNnlSbUpidzZPczdyczV2?=
 =?utf-8?B?ajcwSHdZSnhCWmNGM1U0aDVHZU0vNlBvamFtNm5tTmlnSS9mRFlWMzdRMnVZ?=
 =?utf-8?B?Y3N1Ly8zOU9kaUg4U2JyVCswRmhRb3JYdSs1OWhoM0c0MkJpS3dDZ09QblM5?=
 =?utf-8?B?VUYxeDI1ZDd1YjNNWFJmN0YyMkloTmtCOFZsZmpUQmR5T1lZaElvSy9XclRz?=
 =?utf-8?B?U3J3UUJEQm03U0taMy9oTEJUdGFVMW4zenI2UFRCeDdvelNxelBkVUFsNzNB?=
 =?utf-8?B?MmNXOU1yWXU2RzZkam1aaDFhdG1qSHBpc2loS2twK0taS1IvNWxhRVFBdXhR?=
 =?utf-8?B?MDViY0tqZEVycWZLUnhocG0wa2ZLNForNWxzamp3WjJ5UDJ1K05VNzRQN1ZR?=
 =?utf-8?B?WUhTTnB1dWRNT0VVUFExVVMrZTJub3ArSEtNK1A4c1BUZXozaFppYWJHcFV3?=
 =?utf-8?B?dlpkaW0vYlZ2WmdCK29xMDA5YW16RjQya3pqU3hlTUJjbTJrZU1RdnZLd3RS?=
 =?utf-8?B?K25UdXpsYnpaZWdCWHNzeG9DVXNtS2diRzZNeXBYTUwweHB5TytDVUVSNitD?=
 =?utf-8?B?YTZ2ZCtBekIyQUtQWWtPSjFmbElScHFGL1Z3S3U1VVNFdzZHUWZUVFN1M0lX?=
 =?utf-8?B?RFVWd2hZTjJsUHVqWkFtWmNGQ2xFNDN6clhGVEhuazMrRG01cVpDanRCM1Rs?=
 =?utf-8?B?QUtJaGtZSEgzQjR2NE0rNjZEQ0JSVkJIOU8zeDhGKzJxdklDUGw2ZU45WFlT?=
 =?utf-8?B?L2hEdzNONjd5MlcxYzJ3Ui9DeGFVdjdaaE5WR2Z1a1BJY2UyTVRIVVlXRGNw?=
 =?utf-8?B?bVozamx2SHROOU4rZDhneVN4SjR2allOcC9tTlJ2aG96RFhkVEx5c0s1K1VG?=
 =?utf-8?B?QUhUcUF4bGVTMGZHQ3dxSUJncnk2NElJZzlYVGNGcnZNM1Q2SVNKZjYxSWxV?=
 =?utf-8?B?ek1BT1gzczVMc2Mwa21aMnpnaXRaUDJEZkYxYlBGa2pWVm9UV3NIMmIvK25F?=
 =?utf-8?B?cEE4N0krRTNTQ3BSMnVqYzQvM213T1d6NkxpZzE5T1RaZURadlJXaUNVYTgw?=
 =?utf-8?B?T25SSGtCcGJHRWFXVFEwbENqRG9HS2xRY3g5cllvaWlNZk9FYnpscFQzYkJU?=
 =?utf-8?B?dmt3Nk81WUhyTWJPWVBQS1BHalZrTnoyclc4bmlFRVpuT2JPTmFxK0kxRjBw?=
 =?utf-8?Q?JxK0lqbxdjBVqxgtdB5S8ebC9?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2fc65d-3a12-4229-1ad2-08da9acc005f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 05:50:19.7522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdKMy3GUGG8AOmqZtimit7xkjmYacr7eEd5MjHRhM6T2eljW0Ftcj+m383GjLquX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1670
X-Proofpoint-ORIG-GUID: ctwewSCkD9Z3yCIKWCgjTP5-mmsx0XOW
X-Proofpoint-GUID: ctwewSCkD9Z3yCIKWCgjTP5-mmsx0XOW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/19/22 4:22 PM, Kumar Kartikeya Dwivedi wrote:
> On Tue, 20 Sept 2022 at 00:53, Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 9/14/22 5:36 AM, Dave Marchevsky wrote:
>>> Add a test_ringbuf_map_key test prog, borrowing heavily from extant
>>> test_ringbuf.c. The program tries to use the result of
>>> bpf_ringbuf_reserve as map_key, which was not possible before previouis
>>> commits in this series. The test runner added to prog_tests/ringbuf.c
>>> verifies that the program loads and does basic sanity checks to confirm
>>> that it runs as expected.
>>>
>>> Also, refactor test_ringbuf such that runners for existing test_ringbuf
>>> and newly-added test_ringbuf_map_key are subtests of 'ringbuf' top-level
>>> test.
>>>
>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>>> ---
>>> v1->v2: lore.kernel.org/bpf/20220912101106.2765921-1-davemarchevsky@fb.com
>>>
>>> * Actually run the program instead of just loading (Yonghong)
>>> * Add a bpf_map_update_elem call to the test (Yonghong)
>>> * Refactor runner such that existing test and newly-added test are
>>>     subtests of 'ringbuf' top-level test (Yonghong)
>>> * Remove unused globals in test prog (Yonghong)
>>>
>>>    tools/testing/selftests/bpf/Makefile          |  8 ++-
>>>    .../selftests/bpf/prog_tests/ringbuf.c        | 63 ++++++++++++++++-
>>>    .../bpf/progs/test_ringbuf_map_key.c          | 70 +++++++++++++++++++
>>>    3 files changed, 137 insertions(+), 4 deletions(-)
>>>    create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
>>>
>> [...]
>>> diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c b/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
>>> new file mode 100644
>>> index 000000000000..495f85c6e120
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
>>> @@ -0,0 +1,70 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
>>> +
>>> +#include <linux/bpf.h>
>>> +#include <bpf/bpf_helpers.h>
>>> +#include "bpf_misc.h"
>>> +
>>> +char _license[] SEC("license") = "GPL";
>>> +
>>> +struct sample {
>>> +     int pid;
>>> +     int seq;
>>> +     long value;
>>> +     char comm[16];
>>> +};
>>> +
>>> +struct {
>>> +     __uint(type, BPF_MAP_TYPE_RINGBUF);
>>> +     __uint(max_entries, 4096);
>>> +} ringbuf SEC(".maps");
>>> +
>>> +struct {
>>> +     __uint(type, BPF_MAP_TYPE_HASH);
>>> +     __uint(max_entries, 1000);
>>> +     __type(key, struct sample);
>>> +     __type(value, int);
>>> +} hash_map SEC(".maps");
>>> +
>>> +/* inputs */
>>> +int pid = 0;
>>> +
>>> +/* inner state */
>>> +long seq = 0;
>>> +
>>> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
>>> +int test_ringbuf_mem_map_key(void *ctx)
>>> +{
>>> +     int cur_pid = bpf_get_current_pid_tgid() >> 32;
>>> +     struct sample *sample, sample_copy;
>>> +     int *lookup_val;
>>> +
>>> +     if (cur_pid != pid)
>>> +             return 0;
>>> +
>>> +     sample = bpf_ringbuf_reserve(&ringbuf, sizeof(*sample), 0);
>>> +     if (!sample)
>>> +             return 0;
>>> +
>>> +     sample->pid = pid;
>>> +     bpf_get_current_comm(sample->comm, sizeof(sample->comm));
>>> +     sample->seq = ++seq;
>>> +     sample->value = 42;
>>> +
>>> +     /* test using 'sample' (PTR_TO_MEM | MEM_ALLOC) as map key arg
>>> +      */
>>> +     lookup_val = (int *)bpf_map_lookup_elem(&hash_map, sample);
>>> +
>>> +     /* memcpy is necessary so that verifier doesn't complain with:
>>> +      *   verifier internal error: more than one arg with ref_obj_id R3
>>> +      * when trying to do bpf_map_update_elem(&hash_map, sample, &sample->seq, BPF_ANY);
>>> +      *
>>> +      * Since bpf_map_lookup_elem above uses 'sample' as key, test using
>>> +      * sample field as value below
>>> +      */
>>
>> If I understand correctly, the above error is due to the following
>> verifier code:
>>
>>           if (reg->ref_obj_id) {
>>                   if (meta->ref_obj_id) {
>>                           verbose(env, "verifier internal error: more
>> than one arg with ref_obj_id R%d %u %u\n",
>>                                   regno, reg->ref_obj_id,
>>                                   meta->ref_obj_id);
>>                           return -EFAULT;
>>                   }
>>                   meta->ref_obj_id = reg->ref_obj_id;
>>           }
>>
>> So this is an internal error. So normally this should not happen.
>> Could you investigate and fix the issue?
>>
> 
> Technically it's not an "internal" error, it's totally possible to
> pass two referenced registers from a program (which the verifier
> rejects). So a bad log message I guess.
> 
> We probably need to update the verifier to properly recognize the
> ref_obj_id for certain functions. For release arguments we already
> have meta.release_regno/OBJ_RELEASE for. It can already find the
> ref_obj_id from release_regno instead of meta.ref_obj_id.
> 
> For dynptr_ref or ptr_cast, simply store meta.ref_obj_id by capturing
> the regno and then setting it before r1-r5 is cleared.
> Since that is passed to r0 it will be done later after clearing of
> caller saved regs.
> ptr_cast and dynptr_ref functions are already exclusive (due to
> helper_multiple_ref_obj_use) so they can share the same regno field in
> meta.
> 
> Then remove this check on seeing more than one reg->ref_obj_id, so it
> isn't a problem to allow more than one refcounted registers for all
> other arguments, as long as we correctly remember the ones for the
> cases we care about.

Thanks for the explanation!

> 
> But it can probably be a separate change from this.

if the use case this patch set tried to address is using
bpf_map_update_elem(), we should fix the double
ref_obj_id in the current patch set. If only
bpf_map_lookup_elem() is needed. Then we can delay
the verifier change for the followup patch.

