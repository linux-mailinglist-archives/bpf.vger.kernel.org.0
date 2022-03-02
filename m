Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA01D4C9CC6
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 05:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbiCBEy1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 23:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236930AbiCBEy1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 23:54:27 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ADAA94C5
        for <bpf@vger.kernel.org>; Tue,  1 Mar 2022 20:53:43 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2224dAAM010915;
        Tue, 1 Mar 2022 20:53:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=t6LmmDGjKJnpXXqk8ePQHT7vHLSy6hLL8/CfLTKkDUM=;
 b=a7yGZJ7xgYqCV7hLRcASqN4nfY3Ll9Vnw8q78F6j0N8/LrqqbfX7K/4oxLWKoeWjOqRK
 vy+VH4g9NR9KaKNkVxQ5Qs88higadoDbhhhg9dYzB1684k6xTJMqfKAWJIktRjkFiGeS
 nwouHP3XJS0bsBRFaF6RegFWhUv4iiNGVvs= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ej1r0g1hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 20:53:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWtll1AA1SeyDc+GCtkYb/HQOppx+vkOO9aLAJ2v+9BM3Ft3M8qSNEWJQWBDin+Xkan40Hd3bUCqpgv3DAbd9vc7bEnyz/ttZUmA/Zr3yrr/qkOYIsmPnd2URZn5cjPCUQkCDz0iRgd9TwHfyHbyrR9Fs60VN5zRh2HRtfmE8FDaCCFdO2gqLs8vGTtSyrVXgnpcwQ7yDQIxGulzTTXLdzkgjSagd6PokmnchiDWT1xHyWxRj2Oay0Dhwn5pm0x4vr7tnXjHkjycAnW15zKvE2UoTqCqgSbR3Nj5yEjaRHfyxKLWkf9TQxEXl0x7ZCu02K9sn5MCURexUHyOlKMlag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6LmmDGjKJnpXXqk8ePQHT7vHLSy6hLL8/CfLTKkDUM=;
 b=JCqAzTIEKZLHswHm5ca7dEmokGiNBL3/KdfWl+En7BBarBG/pUpVzl/1BuV8M22lDifLd6YRCYBHQmr+JR+RY36QQR/LjsVaj1l5NgI1yaUtXMH5geYyaB7dFphWCL+IVkXDrMWrmm5W4nVCmeZkR1sT/iVWrH1lJbocfF4JqIoGPoAMRspqPtuXJVXPMOSPIhiBjouMsGe631KZPborws86qmPlxGYjkvdEP9B4E2geo3QzJokWLuxHn09CX9HuybMDDyrjA/iDIcS+QpY81C6NgFPC3M8JfYy3P0uHscAxFjieGCViS0fbe80ZJ8pAG+gm4R+vpeH8ryYJx1QTEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2505.namprd15.prod.outlook.com (2603:10b6:5:85::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 04:53:27 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 04:53:26 +0000
Message-ID: <ab6970fc-eaa0-9462-9614-893085c42331@fb.com>
Date:   Tue, 1 Mar 2022 20:53:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH bpf-next] Improve BPF test stability (related to perf
 events and scheduling)
Content-Language: en-US
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20220219003004.1085072-1-mykolal@fb.com>
 <CAEf4BzahKEObA_quad2M5Rmn42yPCNFAvVUtPVthFi2jPYNpmg@mail.gmail.com>
 <22435EA9-9336-4978-819A-0F91EFDBEA9E@fb.com>
 <CAEf4BzaAr_khs682uyCZ0HhFuNJWwKYDcfqhNE12rWYmU20JOA@mail.gmail.com>
 <a8f8a6f2-25c4-09c2-0b5a-0dab73f17f9e@fb.com>
 <8A284AAF-84BA-48A4-BF4D-7BDB2426DAB8@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <8A284AAF-84BA-48A4-BF4D-7BDB2426DAB8@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faf5aae4-fa70-40fc-9674-08d9fc089681
X-MS-TrafficTypeDiagnostic: DM6PR15MB2505:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB2505D97CEDF3DD8DF0620DA7D3039@DM6PR15MB2505.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QwH2wIlb05MwbO9fIbK30cg1WzyRrdkYL3j4pqjBYgiUiOlNs/G0Qz6odVE8wFNOUqvrlaULXzXt6P0XA34UdX+Ltpv7cbNg0F4Ql8Rzp/PoXQaJIotwR6kK795bW+6RTYBbyurEMm1eQ6n6jCp1svpG9GVSg/3YOT82hbB9YYPzz/lwdOhtf7M5aMNodrcu/7znmxFfshTAAyPTHhx3sETWpqGyHwVdbhPY67tDtG5bsvNTgm1g8U44sl//05JNIy1Aw60910Uy4U7Bgzx5pIEDhIMbqVwQZBc4udH2bwRHjVX/ajbatgZ26bkdi05HVEqhh/MTnkbGFgjgi4BWA67OTRacHsr9Eujw7X5Uo8eG39Iuzuu91TH+K96lRC5tbQGYUKS+M0cZNxu+YpJhvdB0IF3JzBV8jJZukxnRLxQZQ5d+zzc9BZO0l6RkoidyFxJaNKVJ+wBeoJWjfJzseG//vd/TBX1ek/URRyYv0ts2DXy96XzkWHuZPOFO6WUfx4aKZey3QdX8Sx3ZN9fdUV/DkC9NqYo2awGBWBFdhCO6C/Gl4UVD4fcJ9qY9ufr1HFybOoPjgm+LiDK/AYJb5tZltmiJuGUUqReJjkhBvOrseT768p4TY1jFFq0B3iTeykcKGWmjnsbl9eCQ2vNqv3CfZPCaoGLjQIrMNeyjhMUSGWn4gGJRIcxHN5qqantVBG/fbSDXeSGAZnz5L2pXSJbNdOZgDwy+86uECl1p/3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(2616005)(66476007)(186003)(54906003)(4326008)(6862004)(66946007)(66556008)(6666004)(6506007)(6512007)(31696002)(86362001)(53546011)(38100700002)(508600001)(37006003)(52116002)(6636002)(316002)(36756003)(31686004)(30864003)(8936002)(5660300002)(6486002)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUIwQzErZHNDQmY4Z3U2aGRyOWJWYXpDcmhTNmhrUkV6ajdvV3J4Z29DZVhD?=
 =?utf-8?B?MXdtK0ZDWGZJQVJFMlFvU3RMdk1xSGNVWTJoTlVBTmtua0NlUDlwbUdxWk5p?=
 =?utf-8?B?UVZOY3dXVklzN0E3UVhVY2N6WG5KN0s1WGJwS3M1M1ZsaW5mT09OaFJjQ3Zj?=
 =?utf-8?B?b0dJZVJsaitaUmRKS3VzZ3ZsQ21RQ1VaTGZvYXBwUlNFNzZud0NzVEE3UDdn?=
 =?utf-8?B?eW00NzNhMjMvRlFxMHdUSkVvU1VMQUFjWDlZcFdjRkgxRFNZTU00elNXUWJi?=
 =?utf-8?B?MDMxS1c4TjhTdGl4ZVpaWEcyVW9Gakw4emRLVkM1d2s2aG56c2Mza3lqY3lC?=
 =?utf-8?B?aWRrUkJmQjI1YkhHVm0xVHowMlVwWDNYUjBEejNNTHZTRWVoUFJORGEwVTVC?=
 =?utf-8?B?Z1k4OG4yU3ZLYXBWT2VGMThLS1FMcGVnQVl3blVQQmZOcGpkYkF2Q20xdG9M?=
 =?utf-8?B?MzVSU215dnJZUTlQaU0xQUNrd09wSnJYMFREd3o1WEl3Yjk1b0NNazN6cGNt?=
 =?utf-8?B?azVyU2hCNEVZTXA5SzNSaFZydG9UalRyWWQwRXVLbkdDaDlDTWFDN0t0NHdl?=
 =?utf-8?B?Z2YzVDQ1d0lrWGorbC9OOXZ0Sk5ucnhydjhEN3VPVEFrMlp6aFg0RjdBS1g4?=
 =?utf-8?B?ckpzVS91SXJ0ZXcvV3A1WkhybHpka0piZXNmNi94OTY5UHhzWENwYkN3NEtE?=
 =?utf-8?B?MWQ5MTdJY1JDS0NodUNCV2paVEtKMlQrcDhyVWhMRzVtUVNZMDlkOW0rbC9k?=
 =?utf-8?B?SzNvY00vU1poTy9VWnhSeUFoT1YzNG1BZFZ6Z056ci9EdzNRMmJWSWdQSHUv?=
 =?utf-8?B?UzBtcUxHeVEyRTBjZDV6QzQ5SkVRZTZsVmNFaktiK0hyeC9nMThLNWU0SVNI?=
 =?utf-8?B?OTREaGhUdVM3V0dPNHRHWTR1YnNldXdXeWN5TVp0ZmZqZkh1aFdlTGtaWnpm?=
 =?utf-8?B?SHVwZHlOVWh1NGY3WkJQRjZncDg5Vi91NmVnSnFmemJESExLMzhvdTJVNnNJ?=
 =?utf-8?B?T01obEM3REROZTR6UDFUQWJPNFJteXo5V0ZtUlBsMTY4TVVsa09ReVlhQlRJ?=
 =?utf-8?B?MURDQ2oxZTdiMTIyblRqaWZzdEVtOW8rdWV4ODJOMkR0MHJINzNhYzdZUnJ4?=
 =?utf-8?B?Qm5iaEtydjF0dFZkSm8wZmpCbHE2b253TWhSc2E4NVphd0ZnZ3pnQ3NwMHVp?=
 =?utf-8?B?dU1Tbis3VjBVT2NTYUVUeW9hTEtHRmtyS3lTeSswTkdPQ1N0WVhyU0kzNXNq?=
 =?utf-8?B?aXdGcE9xVEJsSjR1b01mRTgvQy95NU9ucTNlbmVHTktvUGJscG1ocGNaTlB6?=
 =?utf-8?B?ak1XdGZ6RUJwbDNkNjNNS3JlOXJ0UWZJT1BPVGVVYVFvNWZHRnRyY1BoZk1F?=
 =?utf-8?B?TzloZFJ0Y1hROEJkcFkySjZNNS8xVjdSOHRiVGNRTjhUZFVrcksvT2lxbG4v?=
 =?utf-8?B?M01HLytnMDJWejlHL00yVmhMOEZlU1J1L29pREhRQ0NhTEhKVVJFUUtnd3FX?=
 =?utf-8?B?T2VKSlFwalN2ckg2YjRSYkpjSmxuSkcrRjBrRERHbXJEODJVVFllOXZkTEVV?=
 =?utf-8?B?M3lpY3NtamV0bXVvcHg4YzNsQnBHblAzRUtQNEhieC9CRFhBRHFjN1d2ZW0x?=
 =?utf-8?B?R29TeFQ1d2JZbTZwbXVEVmhzL2JlRVpmRHVFb0VTdTcydU9IenNRMGx0aEpr?=
 =?utf-8?B?cGduMDFSN2M5NzVhR2c0cXF1KzJuZEh6cjlnUGtXaWpmTHJsTmZncGxSMFNV?=
 =?utf-8?B?cGEyR0ZVaEowNHdnWDY5dktlOTlBdlFmek1uQ2RBMndYYk55cGEweFZvbjJ0?=
 =?utf-8?B?V2t6RDI5bDNFV2JhWVdQWldFdUlOQ3dNSXUxNVFudjVyVXl6WWFEaXY5UFQw?=
 =?utf-8?B?RXQ3T2VibFQ2cEUweW5XQno4ajNYcWpXZk5EUmhIUXoxVDZkblVPWW5aMnN6?=
 =?utf-8?B?MXRDdGJCVEVEd3BQMmptMzNFUXVxN2t3OFJyWmFDTlNEK0tUUTlRSEN4TCs3?=
 =?utf-8?B?QW40RjZsQVJjTmdnQTl4NzJIS3hwSWMwejhGdk1ualpUMVRKbFlyWUlFbmZu?=
 =?utf-8?B?dDY1b1RyTEVzWTZ2aFNmY0NET2ZPa2s2aVIwb2hNMnJDeEFxZnVUcFBXdyt5?=
 =?utf-8?Q?/ems87IrcFQYzKaoo51NK7g1d?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf5aae4-fa70-40fc-9674-08d9fc089681
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 04:53:26.6211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDEVbJhTCmkt8Z5gf3wbOMZ2ch/N5WiytWSp8lPSwrZuR+Mz0WK6mgruav/nJaJm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2505
X-Proofpoint-ORIG-GUID: eD0Egu8GU7V9cNaBEQSWNzxkK266j26N
X-Proofpoint-GUID: eD0Egu8GU7V9cNaBEQSWNzxkK266j26N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_01,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 phishscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020021
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/28/22 7:45 PM, Mykola Lysenko wrote:
> 
> 
>> On Feb 22, 2022, at 8:32 PM, Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 2/22/22 7:13 PM, Andrii Nakryiko wrote:
>>> On Tue, Feb 22, 2022 at 12:35 PM Mykola Lysenko <mykolal@fb.com> wrote:
>>>>
>>>> Thanks for the review Andrii!
>>>>
>>>>> On Feb 19, 2022, at 8:39 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>>>>>
>>>>> On Fri, Feb 18, 2022 at 4:30 PM Mykola Lysenko <mykolal@fb.com> wrote:
>>>>>>
>>>>>> In send_signal, replace sleep with dummy cpu intensive computation
>>>>>> to increase probability of child process being scheduled. Add few
>>>>>> more asserts.
>>>>>>
>>>>>> In find_vma, reduce sample_freq as higher values may be rejected in
>>>>>> some qemu setups, remove usleep and increase length of cpu intensive
>>>>>> computation.
>>>>>>
>>>>>> In bpf_cookie, perf_link and perf_branches, reduce sample_freq as
>>>>>> higher values may be rejected in some qemu setups
>>>>>>
>>>>>> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
>>>>>> ---
>>>>>> .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |  2 +-
>>>>>> tools/testing/selftests/bpf/prog_tests/find_vma.c  |  5 ++---
>>>>>> .../selftests/bpf/prog_tests/perf_branches.c       |  4 ++--
>>>>>> tools/testing/selftests/bpf/prog_tests/perf_link.c |  2 +-
>>>>>> .../testing/selftests/bpf/prog_tests/send_signal.c | 14 ++++++++++----
>>>>>> 5 files changed, 16 insertions(+), 11 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
>>>>>> index cd10df6cd0fc..0612e79a9281 100644
>>>>>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
>>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
>>>>>> @@ -199,7 +199,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
>>>>>>         attr.type = PERF_TYPE_SOFTWARE;
>>>>>>         attr.config = PERF_COUNT_SW_CPU_CLOCK;
>>>>>>         attr.freq = 1;
>>>>>> -       attr.sample_freq = 4000;
>>>>>> +       attr.sample_freq = 1000;
>>>>>>         pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
>>>>>>         if (!ASSERT_GE(pfd, 0, "perf_fd"))
>>>>>>                 goto cleanup;
>>>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/find_vma.c b/tools/testing/selftests/bpf/prog_tests/find_vma.c
>>>>>> index b74b3c0c555a..acc41223a112 100644
>>>>>> --- a/tools/testing/selftests/bpf/prog_tests/find_vma.c
>>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/find_vma.c
>>>>>> @@ -30,7 +30,7 @@ static int open_pe(void)
>>>>>>         attr.type = PERF_TYPE_HARDWARE;
>>>>>>         attr.config = PERF_COUNT_HW_CPU_CYCLES;
>>>>>>         attr.freq = 1;
>>>>>> -       attr.sample_freq = 4000;
>>>>>> +       attr.sample_freq = 1000;
>>>>>>         pfd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CLOEXEC);
>>>>>>
>>>>>>         return pfd >= 0 ? pfd : -errno;
>>>>>> @@ -57,7 +57,7 @@ static void test_find_vma_pe(struct find_vma *skel)
>>>>>>         if (!ASSERT_OK_PTR(link, "attach_perf_event"))
>>>>>>                 goto cleanup;
>>>>>>
>>>>>> -       for (i = 0; i < 1000000; ++i)
>>>>>> +       for (i = 0; i < 1000000000; ++i)
>>>>>
>>>>> 1bln seems excessive... maybe 10mln would be enough?
>>>>
>>>> See explanation for send_signal test case below
>>>>
>>>>>
>>>>>>                 ++j;
>>>>>>
>>>>>>         test_and_reset_skel(skel, -EBUSY /* in nmi, irq_work is busy */);
>>>>>
>>>>> [...]
>>>>>
>>>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
>>>>>> index 776916b61c40..841217bd1df6 100644
>>>>>> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
>>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
>>>>>> @@ -4,11 +4,12 @@
>>>>>> #include <sys/resource.h>
>>>>>> #include "test_send_signal_kern.skel.h"
>>>>>>
>>>>>> -int sigusr1_received = 0;
>>>>>> +int sigusr1_received;
>>>>>> +volatile int volatile_variable;
>>>>>
>>>>> please make them static
>>>>
>>>> sure
>>>>
>>>>>
>>>>>>
>>>>>> static void sigusr1_handler(int signum)
>>>>>> {
>>>>>> -       sigusr1_received++;
>>>>>> +       sigusr1_received = 1;
>>>>>> }
>>>>>>
>>>>>> static void test_send_signal_common(struct perf_event_attr *attr,
>>>>>> @@ -42,7 +43,9 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>>>>>>                 int old_prio;
>>>>>>
>>>>>>                 /* install signal handler and notify parent */
>>>>>> +               errno = 0;
>>>>>>                 signal(SIGUSR1, sigusr1_handler);
>>>>>> +               ASSERT_OK(errno, "signal");
>>>>>
>>>>> just ASSERT_OK(signal(...), "signal");
>>>>
>>>> I am fine to merge signal and ASSERT lines, but will substitute with condition "signal(SIGUSR1, sigusr1_handler) != SIG_ERR”, sounds good?
>>>>
>>> Ah, signal is a bit special with return values. Yeah,
>>> ASSERT_NEQ(signal(...), SIG_ERR, "signal") sounds good.
>>>>>
>>>>>>
>>>>>>                 close(pipe_c2p[0]); /* close read */
>>>>>>                 close(pipe_p2c[1]); /* close write */
>>>>>> @@ -63,9 +66,12 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>>>>>>                 ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
>>>>>>
>>>>>>                 /* wait a little for signal handler */
>>>>>> -               sleep(1);
>>>>>> +               for (int i = 0; i < 1000000000; i++)
>>>>>
>>>>> same about 1bln
>>>>
>>>> With 10mln and 100 test runs I got 86 failures
>>>> 100mln - 63 failures
>>>> 1bln - 0 failures on 100 runs
>>>>
>>>> Now, there is performance concern for this test. Running
>>>>
>>>> time sudo  ./test_progs -t send_signal/send_signal_nmi_thread
>>>>
>>>> With 1bln takes ~4s
>>>> 100mln - 1s.
>>>> Unchanged test with sleep(1); takes ~2s.
>>>>
>>>> On the other hand 300mln runs ~2s, and only fails 1 time per 100 runs. As 300mln does not regress performance comparing to the current “sleep(1)” implementation, I propose to go with it. What do you think?
>>> I think if we need to burn multiple seconds of CPU to make the test
>>> reliable, then we should either rework or disable/remove the test. In
>>> CI those billions of iterations will be much slower. And even waiting
>>> for 4 seconds for just one test is painful.
>>> Yonghong, WDYT? Should we just drop thi test? It has caused us a bunch
>>> of flakiness and maintenance burden without actually catching any
>>> issues. Maybe it's better to just get rid of it?
>>
>> Could we try to set affinity for the child process here?
>> See perf_branches.c:
>>
>> ...
>>         /* generate some branches on cpu 0 */
>>         CPU_ZERO(&cpu_set);
>>         CPU_SET(0, &cpu_set);
>>         err = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_set);
>>         if (CHECK(err, "set_affinity", "cpu #0, err %d\n", err))
>>                 goto out_destroy;
>>         /* spin the loop for a while (random high number) */
>>         for (i = 0; i < 1000000; ++i)
>>                 ++j;
>> ...
>>
>> Binding the process (single thread) to a particular cpu can
>> prevent other non-binding processes from migrating to this
>> cpu and boost the chance for NMI triggered on this cpu.
>> This could be the reason perf_branches.c (and a few other tests)
>> does.
>>
>> In send_signal case, the cpu affinity probably should
>> set to cpu 1 as cpu 0 has been pinned by previous tests for
>> the main process and I didn't see it 'unpinned'
>> (by setaffinity to ALL cpus).
>> This is inconvenient.
>>
>> So the following is my suggestion:
>> 1. abstract the above 'pthread_setaffinity_np to
>>    a helper to set affinity to a particular cpu as
>>    this function has been used in several cases.
>> 2. create a new helper to undo setaffinity (set cpu
>>    mask to all available cpus) so we can pair it
>>    with pthread_setaffinity_np helper in prog_tests/...
>>    files.
>> 3. clean up prog_tests/... files which have pthread_setaffinity_np.
>> 4. use helpers 1/2 with loop bound 1000000 for send_signal test.
>>    The implementation here will be consistent with
>>    other NMI tests. Hopefully the test can consistent
>>    pass similar to other NMI tests.
>>
>> WDYT?
> 
> Hi Yonghong,
> 
> I have tried this approach in the send_signal test without much success unfortunately (different CPUs and configurations options). It is required though for perf_branches test, yet to understand why.

Thanks for experiments. I looked at the code again. Indeed 
pthread_setaffinity_np is not needed for send_signal test. This is 
because we use perf_event_open pid/cpu config like below:
        pid > 0 and cpu == -1
               This measures the specified process/thread on any CPU.

For perf_branches, pthread_setaffinity_np is needed since it uses
the perf_evnet_open pid/cpu config like below:
        pid == -1 and cpu >= 0
               This measures all processes/threads on the specified CPU. 
  This requires CAP_SYS_ADMIN capabil‐
               ity or a /proc/sys/kernel/perf_event_paranoid value of 
less than 1.

> 
> In the V2 of this patch, I used modified approach when we will stop crunching volatile variable when needed condition became true. I hope this will be an acceptable middle ground in this case.

My current setup is using qemu on a physical server and cannot reproduce 
the issue. So I created another setup which uses qemu on a VM itseld and
can actually reproduce the issue. Replacing the sleep(1) with
   for (int i = 0; i < 1000000000; i++) /* 1billion */
      j++; /* volatile int j */
seems fixing the issue. But your change
   for (int i = 0; i < 100000000 && !sigusr1_received; i++)	
      volatile_variable /= i + 1;
works too and I tested it and in most cases the time for the subtest
is 0.8x or 0.9x seconds. Sometimes it can be < 0.5 seconds, and 
occasionally it may be 1.0x seconds. Overall, this is definitely
an improvement for fixing flakiness and better runtime.

> 
> Thanks!
> 
>>
>>>>
>>>>>
>>>>>> +                       volatile_variable++;
>>>>>>
>>>>>>                 buf[0] = sigusr1_received ? '2' : '0';
>>>>>> +               ASSERT_EQ(sigusr1_received, 1, "sigusr1_received");
>>>>>> +
>>>>>>                 ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
>>>>>>
>>>>>>                 /* wait for parent notification and exit */
>>>>>> @@ -110,9 +116,9 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>>>>>>         ASSERT_EQ(read(pipe_c2p[0], buf, 1), 1, "pipe_read");
>>>>>>
>>>>>>         /* trigger the bpf send_signal */
>>>>>> +       skel->bss->signal_thread = signal_thread;
>>>>>>         skel->bss->pid = pid;
>>>>>>         skel->bss->sig = SIGUSR1;
>>>>>> -       skel->bss->signal_thread = signal_thread;
>>>>>>
>>>>>>         /* notify child that bpf program can send_signal now */
>>>>>>         ASSERT_EQ(write(pipe_p2c[1], buf, 1), 1, "pipe_write");
>>>>>> --
>>>>>> 2.30.2
> 
