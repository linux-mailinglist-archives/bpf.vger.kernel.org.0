Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B76562E99A
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 00:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiKQXaR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 18:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbiKQXaQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 18:30:16 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36A91101
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 15:30:13 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2AHN8of3022513;
        Thu, 17 Nov 2022 15:29:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=tadWo4rkDX5gv61+Df9dkkOQRAqUQkiVa69iWMAJ40M=;
 b=dpbtFHK6632o61LnDQlGEJqnUfvkCAIlsByKn4grQwVXqEM8HROtbaa6j24lydHKYY8C
 Eq8ThGj0aGZQatbmM96ZTotVN+PrHvNtL5NQ3CofJzK5e9BjFXC7qClBg7kVBa6kqWI4
 RO8jtkM4iL2FpoIvNuTJ6syvNIBoAWEWO6u+Yitk6DYOCVVk5zsDVnGht/ljLOf9cipT
 SrYsp9AG10KXaAT3vFWuQiEgaMckflP/6ouoVh3xLzVK2D1nJgFCs8JAfwK5Cd9ZR8Pi
 F0Ud6yXA+FJ2OdTEfwNOUncEYD9mkb7dg3b5tRPPVf4vnVSU6gKuQpMAk0BIN1adV5Bl +A== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by m0089730.ppops.net (PPS) with ESMTPS id 3kwxcag4ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 15:29:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B50Fg/Cfbfrv/p/gCmy7XsiFb9A/wabnHqPFo4ihC/VjkVQKMN0YT7pLf71Icax0dOFQlJBfukjD5ZtHnezTOPG/R1X5FXycK8On5zJq3QGaqSlDlCTWKkS2VUZ9iggfY6i6e0s01srsSajp1p5xpp7tdptxphPD3ILLq6KFDGHA4N3ldBEbm7Oz81Etg50JvZ6bsdldEfzmM/bc6+0xefomLz/aY9pnYHx7+oVuaXIdX0/cpN4OXul6GAsjVYjAjCMXv1fxEp0+62q3OVDFq426jAeEtlSqTdl0VU5gQJqms3XwFYJvF1HxFXT7fQZXi86JtkbbJbwYtim1/eABWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tadWo4rkDX5gv61+Df9dkkOQRAqUQkiVa69iWMAJ40M=;
 b=FDWEoDjhlS5aB8mZREul3VL/0OIve+j++rRD6yC5g3o51khkggXWaw7E7wHcwQLwmxVvM1IZi+dfrZIB5g2INW0XKEi68DsNTnAG7STzEYo0t9Ai86GC2XZPfhXrO1pMQAy+b4kWduZDFxAgoZpBkvtkgU+1OPivtF4GYZNF9KZUPKQu8pH8AxyC2tFHrXnEybOCDiQ9HY+jELPafhOju9W+nArYDlrkBUSvcrTAZzBOmhpT9ouGivLJmEU688AwVZ/v28s6VRCy4LL5AxIWK3Sma4YxvmvtNXHiX5KJJsE55fIc9BJFYRJrif6UCVtMCHVg98bOJp5f7UYZ13K7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DS0PR15MB5469.namprd15.prod.outlook.com (2603:10b6:8:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Thu, 17 Nov
 2022 23:29:55 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5813.013; Thu, 17 Nov 2022
 23:29:55 +0000
Message-ID: <d56223f9-483e-fbc1-4564-44c0858a1e3e@meta.com>
Date:   Thu, 17 Nov 2022 15:29:53 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH bpf-next v9 22/23] selftests/bpf: Add BPF linked list API
 tests
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
References: <20221117225510.1676785-1-memxor@gmail.com>
 <20221117225510.1676785-23-memxor@gmail.com>
 <CAADnVQKHibbQUNkwvd0g3YDK8n7k6g21=_TFd1=ccRFYJWrsOA@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAADnVQKHibbQUNkwvd0g3YDK8n7k6g21=_TFd1=ccRFYJWrsOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: PH0PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:510:5::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DS0PR15MB5469:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa06d83-dd09-45bf-a6d1-08dac8f3a263
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RFvS3KqwAOTq44LjZ8m/9sa/+X/sTISfx5dNvG+7UoiB0Y7Aju/HockzBTOT3TBNTgaSsJ+Av2cOOj532jne2ARBvYcW1Ic8DIWrdNK9D2o1Qo2kuNgI+SXR3jB+twFT1fGJwaGndTl2vD9ijDntUrNlCo8yUyK0LquDgxMhkOe8jqFVU4LF9GJIq+3xl9Y2Wy6gqmusr8LqO+8afriAGZpVZdOprVauzOxQF0DDmWHAKSnSs9uO6XVy6DAmDHs9+/ecy3tbcerjDvPIozk8CgozVr2QcGPCy54h6TonUxxgMyRKbTf8tt4vpE2SUlZPAiaEVyI7dxBRy707JdnpLAyPeY74RR+Vm2qa1VcTcW+mDyYxy1errw5m9SiygO7qS7r1hC/OUZnzQVPuBCjzsMo+ZGmBMj3U4TzazulCohjMKApiUh+3hxIy02XFxtJLFLM9wi6Jgin8LGzGKaTIGytb4Hpcp+AaqUeLiq/Iurme0S+S+AKKiKM02dVIAuCLAlPdMgbS47e/zWR4Sn61OYr5DEJGyfnaJA7J1wOsk7RvWumRW8BI1LofPk8Q8t3xPcKNtqqd10c5FCDVcgksqFxbJgUlGBBD+gF9PcgnJei2CNoCQ4TdEcW+44ZR/C7NLud3bYPub2wksBiGNoZn0eFYrKZirgIOJOeRn1w9kRgXl2Df/2riTZXw59Hra1DpRzZ9BFcU7BM//PDGML1FAUjEQz9O7kOaPuJfsW7flZajUckp9ZImgIgb3tpNe9v0ao2NaO/a2fGftqFMUeB1gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199015)(107886003)(31686004)(6486002)(966005)(478600001)(54906003)(110136005)(41300700001)(4326008)(186003)(30864003)(2906002)(8936002)(38100700002)(6506007)(316002)(53546011)(66946007)(66556008)(66476007)(2616005)(6512007)(8676002)(83380400001)(36756003)(31696002)(5660300002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2d3ZDVEU3ZYRU5Bd2gycHFZYm5RMEtPQ3N0cEwwY3c1NFpGVEVYOVpUMUYx?=
 =?utf-8?B?clQ1ZGVsWjUzTFFITm5qNHFLSWpDWHFLWFFQdmNSd3ZXN0N4QThWRGtrb3ZI?=
 =?utf-8?B?VGhWSlUzanRVVmF5RmVpVW10cDZvWFFCakVWd0xOa01Ydk4vNzBJMDZUbVR4?=
 =?utf-8?B?U0d4bTdEcXVWUS9objZhNHZBamFYekgvYW5Na0JUQi9xQ1c3T2NGZEpBL0pH?=
 =?utf-8?B?UmZaVmF1RjlTc0ZiblVSZmo4Wll5eStXUE5SSnZnekd0KzZOVUt4b0hLUXFH?=
 =?utf-8?B?QXVjOHNOWnIyUmRZcnhReFkyVk80ZVlRR2pEV2t4KzgveUhTTm9yVnBOTmpl?=
 =?utf-8?B?SDRnT0N4VUg0ZkNKa2xDVmJDVFphbHdUZFMvcldyN21ucGxCWjlob29EQXZj?=
 =?utf-8?B?NG13dmplYnJoVVo0LzloNzFVZTlYVmpVa2Q0bnpscGpHZlpIc2I0NFdBdlpJ?=
 =?utf-8?B?ZEdEeUllclBuZjQyd0x3bTZMYTFMZFEySS9kTThra25PYUpRdTFqSDQyVUto?=
 =?utf-8?B?TGRURkFyMFVOWVhEaUwwY1hOUko1eUYzeFVMLzBoYUN0WjBYeG5IdGo4SXJM?=
 =?utf-8?B?SDhMYXdIWVdoQjBiZmVNdURzWWhzRVhJTHFNZDJZdFhwZUE1dzA1aUVXdWNS?=
 =?utf-8?B?bTlaZm92NmlOUWRrTThka0ZWbTZkZm45enMyT1hwRXh2QjUybzhTUGhVOVZ5?=
 =?utf-8?B?TlhjTmhpd1hVQlpid1dQNW5icUcyK0pzenRFVi84Mmk5YU5ZcU5nSThnZTJr?=
 =?utf-8?B?Wm03ODNTdkYwYXdQVWE4cXJqUTFQUlVTRFJaZ3I3TC9JYVBtdzV1bG9mVnNF?=
 =?utf-8?B?UzM1ZzJPVU1TcDI2eEZtWitiQnN1Z2hxNHBqN2c0eFRYQ0t4TURsS1VmcVI4?=
 =?utf-8?B?L3pZTHJMM2NCTEFubGtidXhUUnBtVDVnSXF4WkIvNVVvTUtlQmtNTFhsdVFI?=
 =?utf-8?B?c1hwclpnK2l4eTc1OS90dTRPRm01S2hWZmFiZVN1dWpVTmdCSXBYeUoyQkdF?=
 =?utf-8?B?eWpDQllvNVRiWGVkL01well6VFdRNmFiZDBwNTZHWGtrb2k0eE1KMnhNM2FX?=
 =?utf-8?B?dnhjeHVCZWRSdytKc0RNa0cvYnNvMjdlUytFWHJ2d2VPNGFtTFNKdU9DZzJp?=
 =?utf-8?B?ckxzMlV6M0I5V3doM3BWaTJ0T1dGZ3JiRWo2SEcvYVM1a0tjcFpMOTNiSTNn?=
 =?utf-8?B?bTY1ckd6OFhGQjUvYTgvdFBFKzRBTkNmYzdPVkxtSDkwNTRDbVNkZTZRWUF0?=
 =?utf-8?B?Q0lQNjQwZzJsZm00OVRLdjE0WDZINlRWdGFRTlU3bUsvU055VXVjTWE4OWpL?=
 =?utf-8?B?ejJlZkRsTkNMUzlKeVFmR1QzSHI1NlFtdVRIZE01L24zUGNxdDN5RzA3N283?=
 =?utf-8?B?YTk5bjY2NjJLT2VveVpRbEg1NzRRYUVPNGdTOHZ1c0NMTWZFNE81emRHSlND?=
 =?utf-8?B?dzNBelRwczZVVHdIQUFIZ1pCaVV4Ymk2NVJhN2U5aGxTZ1lOUXlTa04xWUtW?=
 =?utf-8?B?K2dhRWszY3d1L29OSlNsandmSlBadEhXcm1lMC9SdVNmTTVUQmxWakFDUVNR?=
 =?utf-8?B?b1M5UXI4dHlTemtZNjhZSDJnYkJ0a0Q5RHl0MUtkRzdoYWFYWm0zYnNOL2N2?=
 =?utf-8?B?bGcvOW9jb3NoaW5xalNEMWhZYVhyMTVJRFhHMVR1VXVXeFRTYVBkUWxMRFI3?=
 =?utf-8?B?c29YeUJLbHVLckFjclc0Q0d1S0IzM3VIL1ZEa3A5R29zWUYwYVN0L3IwT3VK?=
 =?utf-8?B?cnQ3ZjVQdDRPbTVjK1hYWDNWWGJWYTk5ZE9wMVZaVHlINGs5NTIrUWZQVUZR?=
 =?utf-8?B?Tm1pQkIwZng0S0o3U0lJL0lSTGR2dSt6REFtZlBsS3c2TFBsY05YblVvRHY1?=
 =?utf-8?B?dEZ1dmtQUUlBRDFJbkd5SjAzWXJTUm5wRmZQNWxjaFovbW8wUmYrQVNTMXhz?=
 =?utf-8?B?andlUG9MZjNLWFhnUWh5NjJ4TWFCclUvcXZKNzY4YTluZnZPRW9IeE13V0U5?=
 =?utf-8?B?bkhQbSsvSk5IZGoyOHplNG01dCsvNFI2R01zaHV5ZlZlR09ZRXRBUFNBQlVq?=
 =?utf-8?B?MU9jUktrc1YzYnlkZGFLcmZ0OVV6blJkeS90c0RSMzBSdllMTHQ0Y082OXAz?=
 =?utf-8?B?QlptWWpPYjBZOGJuTkFaSWZMR3JQUUl2N1JCZzY5eDVwdUZCdUFTQlVuVThB?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa06d83-dd09-45bf-a6d1-08dac8f3a263
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 23:29:55.4800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGz8ZemctaUbqCML28xTblQG6im+c7dIvLuJkh2zcNQYbUtQJRaK7VOnnpTWqs0R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5469
X-Proofpoint-GUID: YFQXHnSRrqLYBcoyjOaP6XLc2DkhnM7k
X-Proofpoint-ORIG-GUID: YFQXHnSRrqLYBcoyjOaP6XLc2DkhnM7k
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/17/22 3:05 PM, Alexei Starovoitov wrote:
> On Thu, Nov 17, 2022 at 2:56 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>>
>> Include various tests covering the success and failure cases. Also, run
>> the success cases at runtime to verify correctness of linked list
>> manipulation routines, in addition to ensuring successful verification.
>>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>>   tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
>>   .../selftests/bpf/prog_tests/linked_list.c    | 255 ++++++++
>>   .../testing/selftests/bpf/progs/linked_list.c | 370 +++++++++++
>>   .../testing/selftests/bpf/progs/linked_list.h |  56 ++
>>   .../selftests/bpf/progs/linked_list_fail.c    | 581 ++++++++++++++++++
>>   5 files changed, 1263 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/linked_list.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/linked_list.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/linked_list.h
>>   create mode 100644 tools/testing/selftests/bpf/progs/linked_list_fail.c
>>
>> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
>> index be4e3d47ea3e..072243af93b0 100644
>> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
>> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
>> @@ -33,6 +33,7 @@ ksyms_module                             # test_ksyms_module__open_and_load unex
>>   ksyms_module_libbpf                      # JIT does not support calling kernel function                                (kfunc)
>>   ksyms_module_lskel                       # test_ksyms_module_lskel__open_and_load unexpected error: -9                 (?)
>>   libbpf_get_fd_by_id_opts                 # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
>> +linked_list                             # JIT does not support calling kernel function                                (kfunc)
> 
> probably needs it in arm64 denylist as well.
> 
>>   lookup_key                               # JIT does not support calling kernel function                                (kfunc)
>>   lru_bug                                  # prog 'printk': failed to auto-attach: -524
>>   map_kptr                                 # failed to open_and_load program: -524 (trampoline)
>> diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
>> new file mode 100644
>> index 000000000000..32ff1684a7d3
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
>> @@ -0,0 +1,255 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <test_progs.h>
>> +#include <network_helpers.h>
>> +
>> +#include "linked_list.skel.h"
>> +#include "linked_list_fail.skel.h"
>> +
>> +static char log_buf[1024 * 1024];
>> +
>> +static struct {
>> +       const char *prog_name;
>> +       const char *err_msg;
>> +} linked_list_fail_tests[] = {
>> +#define TEST(test, off) \
>> +       { #test "_missing_lock_push_front", \
>> +         "bpf_spin_lock at off=" #off " must be held for bpf_list_head" }, \
>> +       { #test "_missing_lock_push_back", \
>> +         "bpf_spin_lock at off=" #off " must be held for bpf_list_head" }, \
>> +       { #test "_missing_lock_pop_front", \
>> +         "bpf_spin_lock at off=" #off " must be held for bpf_list_head" }, \
>> +       { #test "_missing_lock_pop_back", \
>> +         "bpf_spin_lock at off=" #off " must be held for bpf_list_head" },
>> +       TEST(kptr, 32)
>> +       TEST(global, 16)
>> +       TEST(map, 0)
>> +       TEST(inner_map, 0)
>> +#undef TEST
>> +#define TEST(test, op) \
>> +       { #test "_kptr_incorrect_lock_" #op, \
>> +         "held lock and object are not in the same allocation\n" \
>> +         "bpf_spin_lock at off=32 must be held for bpf_list_head" }, \
>> +       { #test "_global_incorrect_lock_" #op, \
>> +         "held lock and object are not in the same allocation\n" \
>> +         "bpf_spin_lock at off=16 must be held for bpf_list_head" }, \
>> +       { #test "_map_incorrect_lock_" #op, \
>> +         "held lock and object are not in the same allocation\n" \
>> +         "bpf_spin_lock at off=0 must be held for bpf_list_head" }, \
>> +       { #test "_inner_map_incorrect_lock_" #op, \
>> +         "held lock and object are not in the same allocation\n" \
>> +         "bpf_spin_lock at off=0 must be held for bpf_list_head" },
>> +       TEST(kptr, push_front)
>> +       TEST(kptr, push_back)
>> +       TEST(kptr, pop_front)
>> +       TEST(kptr, pop_back)
>> +       TEST(global, push_front)
>> +       TEST(global, push_back)
>> +       TEST(global, pop_front)
>> +       TEST(global, pop_back)
>> +       TEST(map, push_front)
>> +       TEST(map, push_back)
>> +       TEST(map, pop_front)
>> +       TEST(map, pop_back)
>> +       TEST(inner_map, push_front)
>> +       TEST(inner_map, push_back)
>> +       TEST(inner_map, pop_front)
>> +       TEST(inner_map, pop_back)
>> +#undef TEST
>> +       { "map_compat_kprobe", "tracing progs cannot use bpf_list_head yet" },
>> +       { "map_compat_kretprobe", "tracing progs cannot use bpf_list_head yet" },
>> +       { "map_compat_tp", "tracing progs cannot use bpf_list_head yet" },
>> +       { "map_compat_perf", "tracing progs cannot use bpf_list_head yet" },
>> +       { "map_compat_raw_tp", "tracing progs cannot use bpf_list_head yet" },
>> +       { "map_compat_raw_tp_w", "tracing progs cannot use bpf_list_head yet" },
>> +       { "obj_type_id_oor", "local type ID argument must be in range [0, U32_MAX]" },
>> +       { "obj_new_no_composite", "bpf_obj_new type ID argument must be of a struct" },
>> +       { "obj_new_no_struct", "bpf_obj_new type ID argument must be of a struct" },
>> +       { "obj_drop_non_zero_off", "R1 must have zero offset when passed to release func" },
>> +       { "new_null_ret", "R0 invalid mem access 'ptr_or_null_'" },
>> +       { "obj_new_acq", "Unreleased reference id=" },
>> +       { "use_after_drop", "invalid mem access 'scalar'" },
>> +       { "ptr_walk_scalar", "type=scalar expected=percpu_ptr_" },
>> +       { "direct_read_lock", "direct access to bpf_spin_lock is disallowed" },
>> +       { "direct_write_lock", "direct access to bpf_spin_lock is disallowed" },
>> +       { "direct_read_head", "direct access to bpf_list_head is disallowed" },
>> +       { "direct_write_head", "direct access to bpf_list_head is disallowed" },
>> +       { "direct_read_node", "direct access to bpf_list_node is disallowed" },
>> +       { "direct_write_node", "direct access to bpf_list_node is disallowed" },
>> +       { "write_after_push_front", "only read is supported" },
>> +       { "write_after_push_back", "only read is supported" },
>> +       { "use_after_unlock_push_front", "invalid mem access 'scalar'" },
>> +       { "use_after_unlock_push_back", "invalid mem access 'scalar'" },
>> +       { "double_push_front", "arg#1 expected pointer to allocated object" },
>> +       { "double_push_back", "arg#1 expected pointer to allocated object" },
>> +       { "no_node_value_type", "bpf_list_node not found for allocated object\n" },
>> +       { "incorrect_value_type",
>> +         "operation on bpf_list_head expects arg#1 bpf_list_node at offset=0 in struct foo, "
>> +         "but arg is at offset=0 in struct bar" },
>> +       { "incorrect_node_var_off", "variable ptr_ access var_off=(0x0; 0xffffffff) disallowed" },
>> +       { "incorrect_node_off1", "bpf_list_node not found at offset=1" },
>> +       { "incorrect_node_off2", "arg#1 offset=40, but expected bpf_list_node at offset=0 in struct foo" },
>> +       { "no_head_type", "bpf_list_head not found for allocated object" },
>> +       { "incorrect_head_var_off1", "R1 doesn't have constant offset" },
>> +       { "incorrect_head_var_off2", "variable ptr_ access var_off=(0x0; 0xffffffff) disallowed" },
>> +       { "incorrect_head_off1", "bpf_list_head not found at offset=17" },
>> +       { "incorrect_head_off2", "bpf_list_head not found at offset=1" },
>> +       { "pop_front_off",
>> +         "15: (bf) r1 = r6                      ; R1_w=ptr_or_null_foo(id=4,ref_obj_id=4,off=40,imm=0) "
>> +         "R6_w=ptr_or_null_foo(id=4,ref_obj_id=4,off=40,imm=0) refs=2,4\n"
>> +         "16: (85) call bpf_this_cpu_ptr#154\nR1 type=ptr_or_null_ expected=percpu_ptr_" },
>> +       { "pop_back_off",
>> +         "15: (bf) r1 = r6                      ; R1_w=ptr_or_null_foo(id=4,ref_obj_id=4,off=40,imm=0) "
>> +         "R6_w=ptr_or_null_foo(id=4,ref_obj_id=4,off=40,imm=0) refs=2,4\n"
>> +         "16: (85) call bpf_this_cpu_ptr#154\nR1 type=ptr_or_null_ expected=percpu_ptr_" },
>> +};
>> +
>> +static void test_linked_list_fail_prog(const char *prog_name, const char *err_msg)
>> +{
>> +       LIBBPF_OPTS(bpf_object_open_opts, opts, .kernel_log_buf = log_buf,
>> +                                               .kernel_log_size = sizeof(log_buf),
>> +                                               .kernel_log_level = 1);
>> +       struct linked_list_fail *skel;
>> +       struct bpf_program *prog;
>> +       int ret;
>> +
>> +       skel = linked_list_fail__open_opts(&opts);
>> +       if (!ASSERT_OK_PTR(skel, "linked_list_fail__open_opts"))
>> +               return;
>> +
>> +       prog = bpf_object__find_program_by_name(skel->obj, prog_name);
>> +       if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
>> +               goto end;
>> +
>> +       bpf_program__set_autoload(prog, true);
>> +
>> +       ret = linked_list_fail__load(skel);
>> +       if (!ASSERT_ERR(ret, "linked_list_fail__load must fail"))
>> +               goto end;
>> +
>> +       if (!ASSERT_OK_PTR(strstr(log_buf, err_msg), "expected error message")) {
>> +               fprintf(stderr, "Expected: %s\n", err_msg);
>> +               fprintf(stderr, "Verifier: %s\n", log_buf);
>> +       }
>> +
>> +end:
>> +       linked_list_fail__destroy(skel);
>> +}
>> +
>> +static void clear_fields(struct bpf_map *map)
>> +{
>> +       char buf[24];
>> +       int key = 0;
>> +
>> +       memset(buf, 0xff, sizeof(buf));
>> +       ASSERT_OK(bpf_map__update_elem(map, &key, sizeof(key), buf, sizeof(buf), 0), "check_and_free_fields");
>> +}
>> +
>> +enum {
>> +       TEST_ALL,
>> +       PUSH_POP,
>> +       PUSH_POP_MULT,
>> +       LIST_IN_LIST,
>> +};
>> +
>> +static void test_linked_list_success(int mode, bool leave_in_map)
>> +{
>> +       LIBBPF_OPTS(bpf_test_run_opts, opts,
>> +               .data_in = &pkt_v4,
>> +               .data_size_in = sizeof(pkt_v4),
>> +               .repeat = 1,
>> +       );
>> +       struct linked_list *skel;
>> +       int ret;
>> +
>> +       skel = linked_list__open_and_load();
>> +       if (!ASSERT_OK_PTR(skel, "linked_list__open_and_load"))
>> +               return;
>> +
>> +       if (mode == LIST_IN_LIST)
>> +               goto lil;
>> +       if (mode == PUSH_POP_MULT)
>> +               goto ppm;
>> +
>> +       ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.map_list_push_pop), &opts);
>> +       ASSERT_OK(ret, "map_list_push_pop");
>> +       ASSERT_OK(opts.retval, "map_list_push_pop retval");
>> +       if (!leave_in_map)
>> +               clear_fields(skel->maps.array_map);
>> +
>> +       ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.inner_map_list_push_pop), &opts);
>> +       ASSERT_OK(ret, "inner_map_list_push_pop");
>> +       ASSERT_OK(opts.retval, "inner_map_list_push_pop retval");
>> +       if (!leave_in_map)
>> +               clear_fields(skel->maps.inner_map);
>> +
>> +       ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_push_pop), &opts);
>> +       ASSERT_OK(ret, "global_list_push_pop");
>> +       ASSERT_OK(opts.retval, "global_list_push_pop retval");
>> +       if (!leave_in_map)
>> +               clear_fields(skel->maps.data_A);
>> +
>> +       if (mode == PUSH_POP)
>> +               goto end;
>> +
>> +ppm:
>> +       ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.map_list_push_pop_multiple), &opts);
>> +       ASSERT_OK(ret, "map_list_push_pop_multiple");
>> +       ASSERT_OK(opts.retval, "map_list_push_pop_multiple retval");
>> +       if (!leave_in_map)
>> +               clear_fields(skel->maps.array_map);
>> +
>> +       ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.inner_map_list_push_pop_multiple), &opts);
>> +       ASSERT_OK(ret, "inner_map_list_push_pop_multiple");
>> +       ASSERT_OK(opts.retval, "inner_map_list_push_pop_multiple retval");
>> +       if (!leave_in_map)
>> +               clear_fields(skel->maps.inner_map);
>> +
>> +       ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_push_pop_multiple), &opts);
>> +       ASSERT_OK(ret, "global_list_push_pop_multiple");
>> +       ASSERT_OK(opts.retval, "global_list_push_pop_multiple retval");
>> +       if (!leave_in_map)
>> +               clear_fields(skel->maps.data_A);
>> +
>> +       if (mode == PUSH_POP_MULT)
>> +               goto end;
>> +
>> +lil:
>> +       ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.map_list_in_list), &opts);
>> +       ASSERT_OK(ret, "map_list_in_list");
>> +       ASSERT_OK(opts.retval, "map_list_in_list retval");
>> +       if (!leave_in_map)
>> +               clear_fields(skel->maps.array_map);
>> +
>> +       ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.inner_map_list_in_list), &opts);
>> +       ASSERT_OK(ret, "inner_map_list_in_list");
>> +       ASSERT_OK(opts.retval, "inner_map_list_in_list retval");
>> +       if (!leave_in_map)
>> +               clear_fields(skel->maps.inner_map);
>> +
>> +       ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_in_list), &opts);
>> +       ASSERT_OK(ret, "global_list_in_list");
>> +       ASSERT_OK(opts.retval, "global_list_in_list retval");
>> +       if (!leave_in_map)
>> +               clear_fields(skel->maps.data_A);
>> +end:
>> +       linked_list__destroy(skel);
>> +}
>> +
>> +void test_linked_list(void)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < ARRAY_SIZE(linked_list_fail_tests); i++) {
>> +               if (!test__start_subtest(linked_list_fail_tests[i].prog_name))
>> +                       continue;
>> +               test_linked_list_fail_prog(linked_list_fail_tests[i].prog_name,
>> +                                          linked_list_fail_tests[i].err_msg);
>> +       }
>> +       test_linked_list_success(PUSH_POP, false);
>> +       test_linked_list_success(PUSH_POP, true);
>> +       test_linked_list_success(PUSH_POP_MULT, false);
>> +       test_linked_list_success(PUSH_POP_MULT, true);
>> +       test_linked_list_success(LIST_IN_LIST, false);
>> +       test_linked_list_success(LIST_IN_LIST, true);
>> +       test_linked_list_success(TEST_ALL, false);
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/testing/selftests/bpf/progs/linked_list.c
>> new file mode 100644
>> index 000000000000..2c7b615c6d41
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/linked_list.c
>> @@ -0,0 +1,370 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_core_read.h>
>> +#include "bpf_experimental.h"
>> +
>> +#ifndef ARRAY_SIZE
>> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>> +#endif
>> +
>> +#include "linked_list.h"
>> +
>> +static __always_inline
>> +int list_push_pop(struct bpf_spin_lock *lock, struct bpf_list_head *head, bool leave_in_map)
>> +{
>> +       struct bpf_list_node *n;
>> +       struct foo *f;
>> +
>> +       f = bpf_obj_new(typeof(*f));
>> +       if (!f)
>> +               return 2;
>> +
>> +       bpf_spin_lock(lock);
>> +       n = bpf_list_pop_front(head);
>> +       bpf_spin_unlock(lock);
>> +       if (n) {
>> +               bpf_obj_drop(container_of(n, struct foo, node));
>> +               bpf_obj_drop(f);
>> +               return 3;
>> +       }
>> +
>> +       bpf_spin_lock(lock);
>> +       n = bpf_list_pop_back(head);
>> +       bpf_spin_unlock(lock);
>> +       if (n) {
>> +               bpf_obj_drop(container_of(n, struct foo, node));
>> +               bpf_obj_drop(f);
>> +               return 4;
>> +       }
>> +
>> +
>> +       bpf_spin_lock(lock);
>> +       f->data = 42;
>> +       bpf_list_push_front(head, &f->node);
>> +       bpf_spin_unlock(lock);
>> +       if (leave_in_map)
>> +               return 0;
>> +       bpf_spin_lock(lock);
>> +       n = bpf_list_pop_back(head);
>> +       bpf_spin_unlock(lock);
>> +       if (!n)
>> +               return 5;
>> +       f = container_of(n, struct foo, node);
>> +       if (f->data != 42) {
>> +               bpf_obj_drop(f);
>> +               return 6;
>> +       }
>> +
>> +       bpf_spin_lock(lock);
>> +       f->data = 13;
>> +       bpf_list_push_front(head, &f->node);
>> +       bpf_spin_unlock(lock);
>> +       bpf_spin_lock(lock);
>> +       n = bpf_list_pop_front(head);
>> +       bpf_spin_unlock(lock);
>> +       if (!n)
>> +               return 7;
>> +       f = container_of(n, struct foo, node);
>> +       if (f->data != 13) {
>> +               bpf_obj_drop(f);
>> +               return 8;
>> +       }
>> +       bpf_obj_drop(f);
>> +
>> +       bpf_spin_lock(lock);
>> +       n = bpf_list_pop_front(head);
>> +       bpf_spin_unlock(lock);
>> +       if (n) {
>> +               bpf_obj_drop(container_of(n, struct foo, node));
>> +               return 9;
>> +       }
>> +
>> +       bpf_spin_lock(lock);
>> +       n = bpf_list_pop_back(head);
>> +       bpf_spin_unlock(lock);
>> +       if (n) {
>> +               bpf_obj_drop(container_of(n, struct foo, node));
>> +               return 10;
>> +       }
>> +       return 0;
>> +}
>> +
>> +
>> +static __always_inline
>> +int list_push_pop_multiple(struct bpf_spin_lock *lock, struct bpf_list_head *head, bool leave_in_map)
>> +{
>> +       struct bpf_list_node *n;
>> +       struct foo *f[8], *pf;
>> +       int i;
>> +
>> +       for (i = 0; i < ARRAY_SIZE(f); i++) {
>> +               f[i] = bpf_obj_new(typeof(**f));
>> +               if (!f[i])
>> +                       return 2;
>> +               f[i]->data = i;
>> +               bpf_spin_lock(lock);
>> +               bpf_list_push_front(head, &f[i]->node);
>> +               bpf_spin_unlock(lock);
>> +       }
>> +
>> +       for (i = 0; i < ARRAY_SIZE(f); i++) {
>> +               bpf_spin_lock(lock);
>> +               n = bpf_list_pop_front(head);
>> +               bpf_spin_unlock(lock);
>> +               if (!n)
>> +                       return 3;
>> +               pf = container_of(n, struct foo, node);
>> +               if (pf->data != (ARRAY_SIZE(f) - i - 1)) {
>> +                       bpf_obj_drop(pf);
>> +                       return 4;
>> +               }
>> +               bpf_spin_lock(lock);
>> +               bpf_list_push_back(head, &pf->node);
>> +               bpf_spin_unlock(lock);
>> +       }
>> +
>> +       if (leave_in_map)
>> +               return 0;
>> +
>> +       for (i = 0; i < ARRAY_SIZE(f); i++) {
>> +               bpf_spin_lock(lock);
>> +               n = bpf_list_pop_back(head);
>> +               bpf_spin_unlock(lock);
>> +               if (!n)
>> +                       return 5;
>> +               pf = container_of(n, struct foo, node);
>> +               if (pf->data != i) {
>> +                       bpf_obj_drop(pf);
>> +                       return 6;
>> +               }
>> +               bpf_obj_drop(pf);
>> +       }
>> +       bpf_spin_lock(lock);
>> +       n = bpf_list_pop_back(head);
>> +       bpf_spin_unlock(lock);
>> +       if (n) {
>> +               bpf_obj_drop(container_of(n, struct foo, node));
>> +               return 7;
>> +       }
>> +
>> +       bpf_spin_lock(lock);
>> +       n = bpf_list_pop_front(head);
>> +       bpf_spin_unlock(lock);
>> +       if (n) {
>> +               bpf_obj_drop(container_of(n, struct foo, node));
>> +               return 8;
>> +       }
>> +       return 0;
>> +}
>> +
>> +static __always_inline
>> +int list_in_list(struct bpf_spin_lock *lock, struct bpf_list_head *head, bool leave_in_map)
>> +{
>> +       struct bpf_list_node *n;
>> +       struct bar *ba[8], *b;
>> +       struct foo *f;
>> +       int i;
>> +
>> +       f = bpf_obj_new(typeof(*f));
>> +       if (!f)
>> +               return 2;
>> +       for (i = 0; i < ARRAY_SIZE(ba); i++) {
>> +               b = bpf_obj_new(typeof(*b));
>> +               if (!b) {
>> +                       bpf_obj_drop(f);
>> +                       return 3;
>> +               }
>> +               b->data = i;
>> +               bpf_spin_lock(&f->lock);
>> +               bpf_list_push_back(&f->head, &b->node);
>> +               bpf_spin_unlock(&f->lock);
>> +       }
>> +
>> +       bpf_spin_lock(lock);
>> +       f->data = 42;
>> +       bpf_list_push_front(head, &f->node);
>> +       bpf_spin_unlock(lock);
>> +
>> +       if (leave_in_map)
>> +               return 0;
>> +
>> +       bpf_spin_lock(lock);
>> +       n = bpf_list_pop_front(head);
>> +       bpf_spin_unlock(lock);
>> +       if (!n)
>> +               return 4;
>> +       f = container_of(n, struct foo, node);
>> +       if (f->data != 42) {
>> +               bpf_obj_drop(f);
>> +               return 5;
>> +       }
>> +
>> +       for (i = 0; i < ARRAY_SIZE(ba); i++) {
>> +               bpf_spin_lock(&f->lock);
>> +               n = bpf_list_pop_front(&f->head);
>> +               bpf_spin_unlock(&f->lock);
>> +               if (!n) {
>> +                       bpf_obj_drop(f);
>> +                       return 6;
>> +               }
>> +               b = container_of(n, struct bar, node);
>> +               if (b->data != i) {
>> +                       bpf_obj_drop(f);
>> +                       bpf_obj_drop(b);
>> +                       return 7;
>> +               }
>> +               bpf_obj_drop(b);
>> +       }
>> +       bpf_spin_lock(&f->lock);
>> +       n = bpf_list_pop_front(&f->head);
>> +       bpf_spin_unlock(&f->lock);
>> +       if (n) {
>> +               bpf_obj_drop(f);
>> +               bpf_obj_drop(container_of(n, struct bar, node));
>> +               return 8;
>> +       }
>> +       bpf_obj_drop(f);
>> +       return 0;
>> +}
>> +
>> +static __always_inline
>> +int test_list_push_pop(struct bpf_spin_lock *lock, struct bpf_list_head *head)
>> +{
>> +       int ret;
>> +
>> +       ret = list_push_pop(lock, head, false);
>> +       if (ret)
>> +               return ret;
>> +       return list_push_pop(lock, head, true);
>> +}
>> +
>> +static __always_inline
>> +int test_list_push_pop_multiple(struct bpf_spin_lock *lock, struct bpf_list_head *head)
>> +{
>> +       int ret;
>> +
>> +       ret = list_push_pop_multiple(lock ,head, false);
>> +       if (ret)
>> +               return ret;
>> +       return list_push_pop_multiple(lock, head, true);
>> +}
>> +
>> +static __always_inline
>> +int test_list_in_list(struct bpf_spin_lock *lock, struct bpf_list_head *head)
>> +{
>> +       int ret;
>> +
>> +       ret = list_in_list(lock, head, false);
>> +       if (ret)
>> +               return ret;
>> +       return list_in_list(lock, head, true);
>> +}
>> +
>> +SEC("tc")
>> +int map_list_push_pop(void *ctx)
>> +{
>> +       struct map_value *v;
>> +
>> +       v = bpf_map_lookup_elem(&array_map, &(int){0});
>> +       if (!v)
>> +               return 1;
>> +       return test_list_push_pop(&v->lock, &v->head);
>> +}
>> +
>> +SEC("tc")
>> +int inner_map_list_push_pop(void *ctx)
>> +{
>> +       struct map_value *v;
>> +       void *map;
>> +
>> +       map = bpf_map_lookup_elem(&map_of_maps, &(int){0});
>> +       if (!map)
>> +               return 1;
>> +       v = bpf_map_lookup_elem(map, &(int){0});
>> +       if (!v)
>> +               return 1;
>> +       return test_list_push_pop(&v->lock, &v->head);
>> +}
>> +
>> +SEC("tc")
>> +int global_list_push_pop(void *ctx)
>> +{
>> +       return test_list_push_pop(&glock, &ghead);
>> +}
>> +
>> +SEC("tc")
>> +int map_list_push_pop_multiple(void *ctx)
>> +{
>> +       struct map_value *v;
>> +       int ret;
>> +
>> +       v = bpf_map_lookup_elem(&array_map, &(int){0});
>> +       if (!v)
>> +               return 1;
>> +       return test_list_push_pop_multiple(&v->lock, &v->head);
>> +}
>> +
>> +SEC("tc")
>> +int inner_map_list_push_pop_multiple(void *ctx)
>> +{
>> +       struct map_value *v;
>> +       void *map;
>> +       int ret;
>> +
>> +       map = bpf_map_lookup_elem(&map_of_maps, &(int){0});
>> +       if (!map)
>> +               return 1;
>> +       v = bpf_map_lookup_elem(map, &(int){0});
>> +       if (!v)
>> +               return 1;
>> +       return test_list_push_pop_multiple(&v->lock, &v->head);
>> +}
>> +
>> +SEC("tc")
>> +int global_list_push_pop_multiple(void *ctx)
>> +{
>> +       int ret;
>> +
>> +       ret = list_push_pop_multiple(&glock, &ghead, false);
>> +       if (ret)
>> +               return ret;
>> +       return list_push_pop_multiple(&glock, &ghead, true);
>> +}
>> +
>> +SEC("tc")
>> +int map_list_in_list(void *ctx)
>> +{
>> +       struct map_value *v;
>> +       int ret;
>> +
>> +       v = bpf_map_lookup_elem(&array_map, &(int){0});
>> +       if (!v)
>> +               return 1;
>> +       return test_list_in_list(&v->lock, &v->head);
>> +}
>> +
>> +SEC("tc")
>> +int inner_map_list_in_list(void *ctx)
>> +{
>> +       struct map_value *v;
>> +       void *map;
>> +       int ret;
>> +
>> +       map = bpf_map_lookup_elem(&map_of_maps, &(int){0});
>> +       if (!map)
>> +               return 1;
>> +       v = bpf_map_lookup_elem(map, &(int){0});
>> +       if (!v)
>> +               return 1;
>> +       return test_list_in_list(&v->lock, &v->head);
>> +}
>> +
>> +SEC("tc")
>> +int global_list_in_list(void *ctx)
>> +{
>> +       return test_list_in_list(&glock, &ghead);
>> +}
>> +
>> +char _license[] SEC("license") = "GPL";
>> diff --git a/tools/testing/selftests/bpf/progs/linked_list.h b/tools/testing/selftests/bpf/progs/linked_list.h
>> new file mode 100644
>> index 000000000000..8db80ed64db1
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/linked_list.h
>> @@ -0,0 +1,56 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#ifndef LINKED_LIST_H
>> +#define LINKED_LIST_H
>> +
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_experimental.h"
>> +
>> +struct bar {
>> +       struct bpf_list_node node;
>> +       int data;
>> +};
>> +
>> +struct foo {
>> +       struct bpf_list_node node;
>> +       struct bpf_list_head head __contains(bar, node);
>> +       struct bpf_spin_lock lock;
>> +       int data;
>> +       struct bpf_list_node node2;
>> +};
>> +
>> +struct map_value {
>> +       struct bpf_spin_lock lock;
>> +       int data;
>> +       struct bpf_list_head head __contains(foo, node);
>> +};
>> +
>> +struct array_map {
>> +       __uint(type, BPF_MAP_TYPE_ARRAY);
>> +       __type(key, int);
>> +       __type(value, struct map_value);
>> +       __uint(max_entries, 1);
>> +};
>> +
>> +struct array_map array_map SEC(".maps");
>> +struct array_map inner_map SEC(".maps");
>> +
>> +struct {
>> +       __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
>> +       __uint(max_entries, 1);
>> +       __type(key, int);
>> +       __type(value, int);
>> +       __array(values, struct array_map);
>> +} map_of_maps SEC(".maps") = {
>> +       .values = {
>> +               [0] = &inner_map,
>> +       },
>> +};
>> +
>> +#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
>> +
>> +private(A) struct bpf_spin_lock glock;
>> +private(A) struct bpf_list_head ghead __contains(foo, node);
>> +private(B) struct bpf_spin_lock glock2;
> 
> The latest llvm crashes with a bug here:
> 
> fatal error: error in backend: unable to write nop sequence of 4 bytes
> 
> Please see BPF CI.
> 
> So far I wasn't able to find a manual workaround :(
> Please give it a shot too.
> 
> Or disable the test for this case for now?

This is a known issue and Dave Marchevsky discovered it.

$ cat t.c
#define SEC(name) __attribute__((section(name))) 
 
                                      #define private(name) SEC(".data." 
#name) __attribute__((aligned(8)))
private(A) int glock; 
 

private(A) int ghead; 

$ clang -target bpf -O2 -c t.c 
 

fatal error: error in backend: unable to write nop sequence of 4 bytes 
 

PLEASE submit a bug report ...

The reason is that we try to add 'glock'/'ghead' into '.data.A' section.
Since we have alignment 8 requirement. There will be a 4 byte hole
between two variables.

With upstream patch https://reviews.llvm.org/D133456 (applied to llvm16 
around late September. The patch classified non-well-known section
names as .text section. And bpf backend requires multiple 8 counts
to write a nop.

bool BPFAsmBackend::writeNopData(raw_ostream &OS, uint64_t Count,
                                  const MCSubtargetInfo *STI) const {
   if ((Count % 8) != 0)
     return false;

   for (uint64_t i = 0; i < Count; i += 8)
     support::endian::write<uint64_t>(OS, 0x15000000, Endian);

   return true;
}

Since the whole is 4 bytes, and writeNopData will fail and the
compilation error will happen.

Considering the compiler changing behavior to classify internally
that all less-well-known sections will be all text section
and holds will go through BPFAsmBackend::writeNopData(). The best
strategy probably should be more tolerant on 'Count'.
If 'Count' is not multiple of 8, we *could* fill remaining with 0.
Some other arch'es already did this e.g., aarch64, x86, ppc, etc.

bool AArch64AsmBackend::writeNopData(raw_ostream &OS, uint64_t Count,
                                      const MCSubtargetInfo *STI) const {
   // If the count is not 4-byte aligned, we must be writing data into 
the text
   // section (otherwise we have unaligned instructions, and thus have far
   // bigger problems), so just write zeros instead.
   OS.write_zeros(Count % 4);

   // We are properly aligned, so write NOPs as requested.
   Count /= 4;
   for (uint64_t i = 0; i != Count; ++i)
     OS.write("\x1f\x20\x03\xd5", 4);
   return true;
}
So apparently, arm64 does not enforce multiple 4 (insn width 4 bytes).

Alternatively, we might ask upstream to classify section names with 
'.data.' as data section rather then text section. But this won't
scale. For example, user might use '.private.' as the prefix.

Dave Marchevsky is looking at this problem as well.
