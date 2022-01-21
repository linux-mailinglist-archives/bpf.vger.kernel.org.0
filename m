Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765C749672D
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 22:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiAUVPy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 16:15:54 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60764 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229520AbiAUVPx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Jan 2022 16:15:53 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20LGENpB019535;
        Fri, 21 Jan 2022 13:15:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=CA+I2/t3hyHaKZzw8Qj9StA/aZv44UGLw/iVkdFBdX0=;
 b=YDO03unxBZk4GYu6HAy7kmxNkQivuXnv41jJk83j3RguF03xtKJXjoBY52ygdvdWlSjg
 F5kbFBRGGnA51oKh3KWxTOMob9pPrk3WqB3mOimfJsh1JK9IGmUIY9rcvz+LD7tEPkNw
 VznzX1GC6OJkacwXyDa9dme5kP7sBdMceWQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dqhyvx0ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jan 2022 13:15:40 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 21 Jan 2022 13:15:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egaa/kxCy/XNbtZe+RxEWorbvkZoRcepXGrzbEBXAtJYoN/E8UvGtkVyhdiU5kL0LNMYXiyy8VRHDARZ5etyeZLUcBcyl/6CVVKgCQRMirF0s0KT6UDhCSf27txo6UdFI33uOkZ8Dnwunf3l1WJ1BbNBwF4YmerPZgKT/WeoDXBQm0VZ0nMWd5qG2f4PTKB8yZ31gKZin6WA2ha0AEWgKHGHHkeWNyRMNJs5bCzgcayHll0w7D+f6tNzGUz0rLhMMtG0HG5Zsnsfw5cNSFt7fSSVAQ8ShHOLL5mSfiXr7+VfFlXt/UBa2pzIXhxbqCyCzH2RMKv90SEeo81blSQLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CA+I2/t3hyHaKZzw8Qj9StA/aZv44UGLw/iVkdFBdX0=;
 b=fsooggs9YpmqGGrf1FggfLCA+ocdsm726EHPOwHy1O9DNZ/qXhmx8t2crOT4uJxQXv7P84Qma9zAv+94rdgmsG3LCpK60H5XbHmu4lmlSTBGgV1Ru2m3/HeGc2xqBDHN0LOz5F1ClEG8oNK2fkT2+bxzfx8qzsj8L4U1RQLdVC6+NiD0sUKh6pFmztzWK5QtquVe3NjHrn2pWvN3aU9YLDTUX4tcTBlrHTDonXAo2CyKHrxs+OSkfykt0kUs4uRdfb1PVWIDeotysR2gG2rJkVmabSXiPcQheaooJUw3He+gfOhOOXS0rF7BY08SsgQa/q2cUiqc/2JKxc6ljdq0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB4503.namprd15.prod.outlook.com (2603:10b6:a03:378::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 21 Jan
 2022 21:15:38 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0%5]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 21:15:38 +0000
Message-ID: <170be4e4-6709-cfae-f728-81fc4452f111@fb.com>
Date:   Fri, 21 Jan 2022 13:15:34 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v6 bpf-next 1/3] bpf: Add bpf_copy_from_user_task() helper
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Kenny Yu <kennyyu@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Gabriele <phoenix1987@gmail.com>
References: <20220113233158.1582743-1-kennyyu@fb.com>
 <20220121193047.3225019-1-kennyyu@fb.com>
 <20220121193047.3225019-2-kennyyu@fb.com>
 <CAEf4BzYfQ4EbSa+c1-G0x_Zh4L6=TbutmH3qndTmv7wb2dAf1w@mail.gmail.com>
 <c8c18806-69ce-02f7-bb60-e2b2be30a809@fb.com>
 <CAEf4BzbqP1os=mB-WjQNareKumQrGUeqVEw8f+WZwKxN3Kq77A@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzbqP1os=mB-WjQNareKumQrGUeqVEw8f+WZwKxN3Kq77A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:301:1::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9643593-bf3b-429b-da0b-08d9dd232bee
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4503:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4503CF499F84435C0167628DD35B9@SJ0PR15MB4503.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BwqGFlGjtJwM/rpDgEga6t3Fy0sBjf7NFL2Mlnc/3FKoIjQr8r/hpwJrArNFcZs1hLmMcChkJu6+ADimm3UJg9fi9aYsYItWQImQ7S0Icw9Tfafq37SkLbq6JjOF2tZg53psxrDI7x6IZod1beab2s3KwanxQDATdCeb8D0P27eBrylBuQTTePeww22g5akzwVb9D7/YQlUd/0Y9YQ2CrE69B7O5mc6HmUQMOesQNm+51RdQUkb5wBsR1izwVyizVjb3C7g6F91T30fNteEPFYO1TVQrshej2Nw2pWLDpRQauJJv9KgQNcpFYKsGnaS9ftzmEkpY+D8Yh2G9dgtvW69Q/3irPapZdGVCOglKmyd4l6CLvD8NEgWF61EGgyaABMlfDcdih2PSCs/s5vYoQdne+4SqiGumBeVqlGVMgPiYD+yrJuHKpkGZz8UkcD8Qup1fSPSDZPnbaHNI0o7+hSIfMDTKvrnkhlXYzUC0zo7BwPDTMFynQ+usU52sK4QdS1x1UId8zoANHHtEI3VqXE0bV6gqJhmYHMs9mi2whCcvcLMhUulpP8vdoD8S86XZsBGKs2kXWmei/pYEGxLQ6wSYLITqGcZ/zrjJffyHNovrdOPLtmaN5463nxEFX6+63lS6B9LdGhL+0kHp6lGIyElEuIdZgTzb98KBs1SSQuZ6zjCVbOb8+/EuDC3wZNNevFO+qQeO51xFt80p0SayEpNwOSboSaB7+VC302FhN5mEseXe/JHC77/1IBqAeITn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(6486002)(8936002)(36756003)(4326008)(6916009)(6666004)(54906003)(31696002)(86362001)(6512007)(83380400001)(53546011)(6506007)(52116002)(186003)(316002)(31686004)(38100700002)(2906002)(66946007)(66476007)(508600001)(66556008)(5660300002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXAweGNJa2FIQ1EwK2JIaEY4NVBDYTMzd0NtS083SmZqRjlRRmlTTFkvREV2?=
 =?utf-8?B?OW1Ddm1oNjJVM2tWUktVVFNKWWdsOGtaOTl2WDQ0WUN6K05iNEVVYmxRcmEx?=
 =?utf-8?B?OHZRcXRzdDhrM1RrL0NSK1BsNXB6cHMzNTlkcG9jNkQ3R0JLM1A1ZStrY0xP?=
 =?utf-8?B?bkIreVltckZRdzdhRmc2VkZqYUdaUmRTSGpjYXJOTGEza1NCWlhBUnpGMllt?=
 =?utf-8?B?Ni8wSnNDeGhUdlBGQk9LNGhuMXpLbGY5QkYxSVZUeXZGUEwrejRGTlhiNnpo?=
 =?utf-8?B?MUc3WGsxOWpFc1RMQ2xrZkVHRXVkK0gxNW56eXk3ZFhtQktjdlJPMmVkYStP?=
 =?utf-8?B?OSs5UklHNjE0ZG1QdkdwNDl5RlBMVEEzSFBqSWYvMTVjbVMzNCtqd1A4MDJX?=
 =?utf-8?B?NlBwNEUxS1JDR3NaV3hRa0wydzI1emxuTEUzRStJU3J0aStRV0lzY2pWeWRs?=
 =?utf-8?B?ODBoTUpOa21US0orSXM3aHRvN0F2VVZZNnh2K2lOWER3UlQvc3dYYVJwKzZa?=
 =?utf-8?B?WnNwSHBZWlRQZUJ5QlpwQUlrMTFsQUdEbkZTbmljaHBpT0wrMkgvRXk3amll?=
 =?utf-8?B?dkFvZ0xjUGx4cUY5TnBQV3d6bUNjUEpQdUdxWkx1QUhNeUxHa0ExbkhlcThL?=
 =?utf-8?B?NENrVWlxejZMVzlCSmhnUndRS2IzUlRxK0JvMDkxS2RIV2VCdmhPZHJnTFBI?=
 =?utf-8?B?TDdmUlNLNEV6bFZ2Rmwyckw2ZWNvM2dIRXZJNElZcWFhS3JFUnNaakFyKzFR?=
 =?utf-8?B?SmxjeEZzVkhlcVdkVWQ2RFd6RktzY0o1R0dlVGovaDIzK2k2UjN0L2hHbENM?=
 =?utf-8?B?MldBb1AwclFvZzV6NFhibzdFdGx3eElsSFlsRllZUjdxZnFscGE0dWN6d1k5?=
 =?utf-8?B?NlA1cUhqUG9vOFFSYlJ3RGViV01TTlpmMDFvemRGTVYzbXZSeTNzdTdERmt5?=
 =?utf-8?B?Ry9zSDZGRmtjK1hubG9FekZydkVUdkFyT2NHZXRqbWdFTFlQY3pUazJwcWlK?=
 =?utf-8?B?QnZQeWkwWURqMkl6QjN6cGZ2NDEwYzhLTUN2cC9EMU9FWlZmVWlBTGMwZmkz?=
 =?utf-8?B?YjVPeW8wQTdWb3RRT05OTTBVait1QmlvR0F5eXRpbm9uOWQ5ZSt0d2NhcWJx?=
 =?utf-8?B?TGh2TVpDTTAwNldGRkwvU3FvK0NHZmF0T3Y5cytSaTJaTWczbE1QcDJHcERO?=
 =?utf-8?B?ektXRjhQbzRwYWgyb0FoL0V0VEpneHl3bkhEWTJ6b0luVTI3Q2dEdlRXWDBr?=
 =?utf-8?B?MC9TcEFkanhpTy92VWpON0E1Yk5aS0ZQRUpSejZnQTc4TjVnZkEraW9JVUU4?=
 =?utf-8?B?YjRia1FvSUJJQit6SzZHZmkvQk1qVUpkMHF5b1dseENML3hvL093U0pHUnIw?=
 =?utf-8?B?Mkp3MFgxakszeXNndWJ0eHlsc252djdQTnU1Sy85Qk52NjRXZVpjSEZUcVF3?=
 =?utf-8?B?Sm9DNWlwUzd1QU92Tm4wMmFtaWlCRkpEUCtOOVBsK2c2b2c5MnJTQnU1VlFR?=
 =?utf-8?B?VWtPVHJWS2Zad3JBQUdEbzhHUU83NTI5RE44RFM2ZnVuU0xDb1MrR05zc2Ir?=
 =?utf-8?B?T1hNRTFNNXJSSzJ1VGNPa1B4cE1TSUNoMnJOOXlBY1RmWjBzaW9Dd2FkN3hO?=
 =?utf-8?B?TzNCdktGTVg2dCtBNWNOanlFOFVydVRDVzBSYW45bVlNdnJwaitldWQrcTB6?=
 =?utf-8?B?ZkZEb3Q4TnpqTUlzaEtZNEYwM21OcTdTSFQ1L3JJVmZXSDZpSElYcm9CTWNI?=
 =?utf-8?B?MDcza0V6TkhyNzVSNVVGNUFyeVMzQjdCQkVIOVk2aTNHMm1YODFWQWhJVnV1?=
 =?utf-8?B?dnZQVGRrMHhKNndoUVhuT1d3WUpnMGF0eWkvWjNQMFJaYkw0Sm14eUk5UVBo?=
 =?utf-8?B?V1dkSTJaRVY1UnE0UUZKTkxRUmp0YW5XQVAxZFVOUy81UVo3VlVpOU9wS1l4?=
 =?utf-8?B?WkN0eEI3Wm9VQXlRdXZzMENLUWlsV1NTOVlKcVVJbEZpSEtMc3FJaURjclFp?=
 =?utf-8?B?ZjkyQm94Y1M2SkcrL1pPdUdWZ3ZpWWU0LzFTUUlSMnhVREdZV1QwWWJNYzhv?=
 =?utf-8?B?bnN6NkhVMndqdHpsWUgwV09XRHBhT2RXK0p0ekFRamFPRC9VTlJhdXpKNlN2?=
 =?utf-8?Q?6PJl0hqq62M+JRSrx48x2HJ2R?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9643593-bf3b-429b-da0b-08d9dd232bee
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 21:15:38.1709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D030IMRhNg/IdrqepPSxU8G9BLGljRo8lLhdGj5BnRnu5/WioHD4x9fB8iUyIg+y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4503
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: dF9SX9MdJPDUYFLN3i295lKcSBPy_JSu
X-Proofpoint-GUID: dF9SX9MdJPDUYFLN3i295lKcSBPy_JSu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_10,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201210135
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/21/22 12:07 PM, Andrii Nakryiko wrote:
> On Fri, Jan 21, 2022 at 12:04 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 1/21/22 11:53 AM, Andrii Nakryiko wrote:
>>> On Fri, Jan 21, 2022 at 11:31 AM Kenny Yu <kennyyu@fb.com> wrote:
>>>>
>>>> This adds a helper for bpf programs to read the memory of other
>>>> tasks. This also adds the ability for bpf iterator programs to
>>>> be sleepable.
>>>>
>>>> This changes `bpf_iter_run_prog` to use the appropriate synchronization for
>>>> sleepable bpf programs. With sleepable bpf iterator programs, we can no
>>>> longer use `rcu_read_lock()` and must use `rcu_read_lock_trace()` instead
>>>> to protect the bpf program.
>>>>
>>>> As an example use case at Meta, we are using a bpf task iterator program
>>>> and this new helper to print C++ async stack traces for all threads of
>>>> a given process.
>>>>
>>>> Signed-off-by: Kenny Yu <kennyyu@fb.com>
>>>> ---
>>>>    include/linux/bpf.h            |  1 +
>>>>    include/uapi/linux/bpf.h       | 10 ++++++++++
>>>>    kernel/bpf/bpf_iter.c          | 20 ++++++++++++++-----
>>>>    kernel/bpf/helpers.c           | 35 ++++++++++++++++++++++++++++++++++
>>>>    kernel/trace/bpf_trace.c       |  2 ++
>>>>    tools/include/uapi/linux/bpf.h | 10 ++++++++++
>>>>    6 files changed, 73 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>>> index 80e3387ea3af..5917883e528b 100644
>>>> --- a/include/linux/bpf.h
>>>> +++ b/include/linux/bpf.h
>>>> @@ -2229,6 +2229,7 @@ extern const struct bpf_func_proto bpf_kallsyms_lookup_name_proto;
>>>>    extern const struct bpf_func_proto bpf_find_vma_proto;
>>>>    extern const struct bpf_func_proto bpf_loop_proto;
>>>>    extern const struct bpf_func_proto bpf_strncmp_proto;
>>>> +extern const struct bpf_func_proto bpf_copy_from_user_task_proto;
>>>>
>>>>    const struct bpf_func_proto *tracing_prog_func_proto(
>>>>      enum bpf_func_id func_id, const struct bpf_prog *prog);
>>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>>> index fe2272defcd9..d82d9423874d 100644
>>>> --- a/include/uapi/linux/bpf.h
>>>> +++ b/include/uapi/linux/bpf.h
>>>> @@ -5049,6 +5049,15 @@ union bpf_attr {
>>>>     *             This helper is currently supported by cgroup programs only.
>>>>     *     Return
>>>>     *             0 on success, or a negative error in case of failure.
>>>> + *
>>>> + * long bpf_copy_from_user_task(void *dst, u32 size, const void *user_ptr, struct task_struct *tsk, u64 flags)
>>>> + *     Description
>>>> + *             Read *size* bytes from user space address *user_ptr* in *tsk*'s
>>>> + *             address space, and stores the data in *dst*. *flags* is not
>>>> + *             used yet and is provided for future extensibility. This helper
>>>> + *             can only be used by sleepable programs.
>>>
>>> "On error dst buffer is zeroed out."? This is an explicit guarantee.
>>>
>>>> + *     Return
>>>> + *             0 on success, or a negative error in case of failure.
>>>>     */
>>>>    #define __BPF_FUNC_MAPPER(FN)          \
>>>>           FN(unspec),                     \
>>>> @@ -5239,6 +5248,7 @@ union bpf_attr {
>>>>           FN(get_func_arg_cnt),           \
>>>>           FN(get_retval),                 \
>>>>           FN(set_retval),                 \
>>>> +       FN(copy_from_user_task),        \
>>>>           /* */
>>>>
>>>>    /* integer value in 'imm' field of BPF_CALL instruction selects which helper
>>>> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
>>>> index b7aef5b3416d..110029ede71e 100644
>>>> --- a/kernel/bpf/bpf_iter.c
>>>> +++ b/kernel/bpf/bpf_iter.c
>>>> @@ -5,6 +5,7 @@
>>>>    #include <linux/anon_inodes.h>
>>>>    #include <linux/filter.h>
>>>>    #include <linux/bpf.h>
>>>> +#include <linux/rcupdate_trace.h>
>>>>
>>>>    struct bpf_iter_target_info {
>>>>           struct list_head list;
>>>> @@ -684,11 +685,20 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx)
>>>>    {
>>>>           int ret;
>>>>
>>>> -       rcu_read_lock();
>>>> -       migrate_disable();
>>>> -       ret = bpf_prog_run(prog, ctx);
>>>> -       migrate_enable();
>>>> -       rcu_read_unlock();
>>>> +       if (prog->aux->sleepable) {
>>>> +               rcu_read_lock_trace();
>>>> +               migrate_disable();
>>>> +               might_fault();
>>>> +               ret = bpf_prog_run(prog, ctx);
>>>> +               migrate_enable();
>>>> +               rcu_read_unlock_trace();
>>>> +       } else {
>>>> +               rcu_read_lock();
>>>> +               migrate_disable();
>>>> +               ret = bpf_prog_run(prog, ctx);
>>>> +               migrate_enable();
>>>> +               rcu_read_unlock();
>>>> +       }
>>>>
>>>
>>> I think this sleepable bpf_iter change deserves its own patch. It has
>>> nothing to do with bpf_copy_from_user_task() helper.
>>
>> Without the above change, using bpf_copy_from_user_task() will trigger
>> rcu warning and may produce incorrect result. One option is to put
>> the above in a preparation patch before introducing
>> bpf_copy_from_user_task() so we won't have bisecting issues.
> 
> Sure, patch #1 for sleepable bpf_iter, patch #2 for the helper? I
> mean, it's not a big deal, but both seem to deserve their own focused
> patches.

okay with me.

> 
>>
>>>
>>>>           /* bpf program can only return 0 or 1:
>>>>            *  0 : okay
>> [...]
