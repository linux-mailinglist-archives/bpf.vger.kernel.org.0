Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D37496624
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 21:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiAUUE1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 15:04:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13712 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229474AbiAUUE0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Jan 2022 15:04:26 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20LGcBt7017925;
        Fri, 21 Jan 2022 12:04:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=jdXTN9nF0JZNiFCb0Riwc2TmMiDxHFizp1VJEpZvyvo=;
 b=MgkcF2pxX2OVPrs/dMD8goF4L8nZXwD1iwwiq0yYFenmXjuMzJpcI9s2xwVAvwPFjQXn
 lwy2uqBQ1ECqOUYiG0wLxGZZKFeNqj8EsQiDVPdAcsuZgvwYbbELmWLDPd0k0xmwDkip
 7rvFlsAMaRrfzgX9ryPaXISDX/D4Gd2a93w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dqhyg5kec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jan 2022 12:04:12 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 21 Jan 2022 12:04:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T93NxqNbGhsMjlzUllgCRIMlAwBK4c9poc0Uwq2sg9/62Bo6rvoRxaVO+4RuX6QhujOfpbA6m0BWKMLiysyKRIZSH5FYuMaVoNV45SfCA4E/Vrp/jZFnfff+zJkjTc4j/6FFsgj8dV4NEOg7ch0zi0vJ1sN5N2BWEDa/EkHU+VZmhKImzloLt3bP50eFp/2I1SL9HqUDPlQKmzX4qhQurR07sSd4QJQGSYjhRiAUG30jFi+9rKqY8/do/YXWr6iJrcDCNvyn45sXaGwySL7KrGhxMApMZxe8ky7SisIrufgFN7iQ4mr877QaSV4t+KzXKUPKHK9rYwm33YaVVNa94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdXTN9nF0JZNiFCb0Riwc2TmMiDxHFizp1VJEpZvyvo=;
 b=K1NokNNrE9zok0nm9t6plOAQl758Mvgr71VKpScALJNuqj/IaCMocF47AxXEGzE72oYyqUCJBePhGOEvH2lGt+Lw12bfcmQftSJdNm7WTZZ6qO2q+C89T+5g9XlUDzy3igPgxfYmLprLJ7YToyxYmbgAtxXHuFMnNiiWJ9SvmP43ZBM25a2Clnh0Pnq+Vjm5NUKTrqihR/NzQyUHWGZRD/nfUftEUQUgUoZnkk/AJFYYKpcZ6nwU89kmjbLC2Jahqx+uJoSYntrxp/d6t/w02yGtnJjwujqLniHonXyinL8v3Oifmo45sA00CNZmQtYIVatx6YYiTIL9fefbAM1+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB2647.namprd15.prod.outlook.com (2603:10b6:a03:153::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 21 Jan
 2022 20:04:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0%5]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 20:04:09 +0000
Message-ID: <c8c18806-69ce-02f7-bb60-e2b2be30a809@fb.com>
Date:   Fri, 21 Jan 2022 12:04:05 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v6 bpf-next 1/3] bpf: Add bpf_copy_from_user_task() helper
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kenny Yu <kennyyu@fb.com>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Gabriele <phoenix1987@gmail.com>
References: <20220113233158.1582743-1-kennyyu@fb.com>
 <20220121193047.3225019-1-kennyyu@fb.com>
 <20220121193047.3225019-2-kennyyu@fb.com>
 <CAEf4BzYfQ4EbSa+c1-G0x_Zh4L6=TbutmH3qndTmv7wb2dAf1w@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzYfQ4EbSa+c1-G0x_Zh4L6=TbutmH3qndTmv7wb2dAf1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0203.namprd04.prod.outlook.com
 (2603:10b6:104:5::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7729c883-79da-4007-d469-08d9dd192fc4
X-MS-TrafficTypeDiagnostic: BYAPR15MB2647:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB2647E16E18B3173653B93963D35B9@BYAPR15MB2647.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CNaXiuOPH0S9GEJ9Bh1ounLv8VHC/QqQFSoKyh4exkoDOHUmU/mbRErTIztI2xE6QSDwDd+Vte1Z5iGBcTvlyhg3YUn9TEC1GLBI3UVbJxzIjNfsJgUtKsyyuucw7kWWzIBiGXYffS5uGFkgOhOUv6JsoNM3iPQmpy8qShUqBW4gJAbNU0A+YLXjoykt8M0J47gzKqbtCl/jPAJHOReFyfQriVjaCjrkvHeu/xzqOeproXCWvoM4oejtNIP4HJ8SBzoZxyOlSzQei6NZsc+BmOGThohliXuh4rKboWzjUXZuB5KMj7GitpLjmprDC2mRHRolH2J5xx9qMZLeByTZXqS0izz2QORcO/JA0kuayTAXgVTxIu/b1IDatjnpvN4RdxT1CzN4wpuTn7iRNR9VxPAz4A59NzVkl+M+wxO/6zopceoFPkIiE5/E8JtEKhhcRQFdbo6VR9KWypFtSZ+94M88FfmOu+5hHv9I1t5I1AsJ5kzjh+Y7M6ljYvSB2pMhp9tc/z9f3UCSwW12o/Jaj8DbMlYlIK5SGuGdfbxpt8pABM0uBUk71rpHeDNf08tZOBMzVYz4lSEixQEGNqYhGQhz+aftckXbZEde9OHquEcsk5rRS6GCGv5cJzl95MmMj1wjv9sZBY3XDpmVmptzUgPbZzAiYN1hrzJTO6nf0IkSsGlqMNe6p1OSih0Ytfk+PisAInxEnuofyUYx9lpksgQNuS4bugEOXu0YRd3DFG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(4326008)(8936002)(53546011)(6636002)(186003)(2906002)(31686004)(36756003)(86362001)(6506007)(2616005)(5660300002)(6486002)(52116002)(8676002)(83380400001)(110136005)(54906003)(6512007)(66946007)(508600001)(66556008)(66476007)(6666004)(38100700002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXVwODF4b284aCtpNzFvaEw2UU9uVUQvbDVlaFZOOXl0RXRsR0YyMEs4c2lY?=
 =?utf-8?B?VG5kc0NLZFgrOTlwT3ByS1FaRzVhdXZLdzh5dkRzblFTMGp2WUc1ZWx2bXYx?=
 =?utf-8?B?dE9XWVpCZVNUUTZpa09Wd2Z5aE5yd09QS3daUnpZTVIwUGQzWnNxV1B0MmxZ?=
 =?utf-8?B?VU1MRVpRNHFpM0VDeEhTWXZhTDNhZ01Eb0RMdzk3ZDVSMGFFRWhQU0tVNzdo?=
 =?utf-8?B?ajBwd1FjQWNOSUl1cWF5dHVqS1JkU3ZJN1FaVFR1Z29kdGl0STJWM05xdFFW?=
 =?utf-8?B?U3MwdWRHQ2xueSs5Y3NGSHFVOW5mSGRjMFRkcU5BTWZHUnplSllxTDlUSDNO?=
 =?utf-8?B?YSs3Ym9nOXZ1cUttaXoxNEhvQmFkZ092TGg1UmRGMGxCVjFqSmJocUwzTlBu?=
 =?utf-8?B?cHB6Umc0aEIwdmVlS3ZXMlZKWVhHZWtWUGg4cEg1KzZKYXpPUmtWQUJzSENG?=
 =?utf-8?B?UGlhbHI0Q2d5T00yODhSZzJTRHBySUtMeTRjdGVWelpQUEpSZ2pQWks5ZmRJ?=
 =?utf-8?B?dWh5ZlM3Znh3c09CeDIwaHpKdmpHS2VONTUzZmxDNjhDUzBGMys0d1BkeG1D?=
 =?utf-8?B?MU82bTFFSm5sNUw2dndsdTFZSk1UMm9kWnR3b3gxT0RZWnhTMFpSQlRnaUUz?=
 =?utf-8?B?eFROcXZTYkI1UUF2VVdxVGM2R3NvMzNDK0tnNThYc0l0SENLVCtnd2duSnU5?=
 =?utf-8?B?YldLNHA0aEcyMXc2VzFhN2ZUYW1TektwckJvZk0rTWxST3ZzcXVqdUdTN3Ra?=
 =?utf-8?B?Uk1NdmlqdU9YclVTT29LMUFkTDB2UWtkTXByaURVLy9Tc1ZVYWczd2VtdHlV?=
 =?utf-8?B?YldXc0ZrRCt0UGZrdTB2aE85Z3plemNlZTZ3R0xIbi9CRkVvTVF5aTFPaHRG?=
 =?utf-8?B?U05BQ0d4SlFWZTZlUmFYcC9KMUQ3aUMrOXZTb2thZzhRRkJEdUhMSFZ6TTI3?=
 =?utf-8?B?blZ2SnhTT1Rsdmd5NU0reGZrZGFKbFdhSHcyMVJ0akljUldQajBYdEJMTDFp?=
 =?utf-8?B?Z1VTY2F0UGgyN2Y3NGhCekdPWGZPZzdoK0R1TnlFdXlqSmdwaVgvU3FQSHh3?=
 =?utf-8?B?MTNKc1V5cjdmK0ZRMHFBR1g3WG5iZ1MvbmZLMVNhN3JvOFRVQXFrbVNSNHNX?=
 =?utf-8?B?eFNNaGl1VUZXaEQxOCtJY05MQThZOTVhQjJ1USt6RU5iZVd0alRYZjVUOVIz?=
 =?utf-8?B?bnRGREY5MHlrbXM1WXlGQnp3cEp6ejRmaXl5V2hKL1M0KzRCSks1eUVwY0J3?=
 =?utf-8?B?VzRCM0YwdmNsdHM0THFvWmNqQ0hxbHRzb05GK2ZmZjJ0M2VSUGdVaXQwQldu?=
 =?utf-8?B?UXVwLy9NTC9xRW1JNU4rTEYzK08yTHpldVZIQXVlSGd6YVk3RjZZNU9pOGsr?=
 =?utf-8?B?N3VRKyt3eFlMbDkyQ0ZwcERTUnpoaytaRFZYRkpOTHBGMVlSK1VjZGdRaHpr?=
 =?utf-8?B?emVXV0ZSUmlWTE0wOXI5QUhXVWRuMmNsSkR2NmxWeWVya2sxUjUyWUdsTWht?=
 =?utf-8?B?WDZPSDNHTEVuV1NQOXpDTGxUN0haTzVtRnQ2QXd4RjhpclVJS0FVdEhnQ3Mz?=
 =?utf-8?B?V1BWZ1RrMmc4ZW11Zi9NUndFUUlRTUQzZFpSZGhFazZ2dStUOUZrVXpaaXEy?=
 =?utf-8?B?MU9xMEtSUzZUY0Eva3NIZUplVUU0bVpKSjNGRFB5UzRseWxzK3MxdjNtZi90?=
 =?utf-8?B?NGlKKzFURytubFMrT2RaVWhYblRmVXkzU3BWMHE1ajdabEYxdjc5Q3k1enJi?=
 =?utf-8?B?YS9ibWpoMTJFemV3bFRMN0RZZk04L0NVSEoza0lDbVNnUmhNNHJ0TmpjcmpE?=
 =?utf-8?B?a3Btc2U3RXZzNG9DK2tsUHZYNHlUZ25UaDdsbFgvQ05FZi9UTHZTRUVTNEE4?=
 =?utf-8?B?bXI2SnplUm0zelNsaGhuenN5MmpmVzBFcjZtS1V2WUNNRFMyS2p6ODdpTFdE?=
 =?utf-8?B?c1pwYVdaNUxOQWJTV1BENCtrc0F0QUxvVTFCZmhXNWMyMi9aN0tsczNhQkxJ?=
 =?utf-8?B?MllibEswdEhIOFNnWEpFYi93ajI1aHBhUnNmQXN5VmgyUmFWOWVZUjc5Qlcx?=
 =?utf-8?B?aFJQMy83aGpub2R2Z0tqRk5jUzRyQ1dBMnlOKzNGRndhREp0ZmlhWVZKQU9u?=
 =?utf-8?Q?4ljFiioeA4ohPtad53YdQRDwG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7729c883-79da-4007-d469-08d9dd192fc4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 20:04:09.6235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZeu6P4IcM4wvpwv1EwgnnS6jzGAuvejjHPas++2Pl5usFUqx7Uu9YLFDy7Ns5QR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2647
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: nXZJo-6Y967-Tsc8iMcQdn75OCiBpr0y
X-Proofpoint-GUID: nXZJo-6Y967-Tsc8iMcQdn75OCiBpr0y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_09,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/21/22 11:53 AM, Andrii Nakryiko wrote:
> On Fri, Jan 21, 2022 at 11:31 AM Kenny Yu <kennyyu@fb.com> wrote:
>>
>> This adds a helper for bpf programs to read the memory of other
>> tasks. This also adds the ability for bpf iterator programs to
>> be sleepable.
>>
>> This changes `bpf_iter_run_prog` to use the appropriate synchronization for
>> sleepable bpf programs. With sleepable bpf iterator programs, we can no
>> longer use `rcu_read_lock()` and must use `rcu_read_lock_trace()` instead
>> to protect the bpf program.
>>
>> As an example use case at Meta, we are using a bpf task iterator program
>> and this new helper to print C++ async stack traces for all threads of
>> a given process.
>>
>> Signed-off-by: Kenny Yu <kennyyu@fb.com>
>> ---
>>   include/linux/bpf.h            |  1 +
>>   include/uapi/linux/bpf.h       | 10 ++++++++++
>>   kernel/bpf/bpf_iter.c          | 20 ++++++++++++++-----
>>   kernel/bpf/helpers.c           | 35 ++++++++++++++++++++++++++++++++++
>>   kernel/trace/bpf_trace.c       |  2 ++
>>   tools/include/uapi/linux/bpf.h | 10 ++++++++++
>>   6 files changed, 73 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 80e3387ea3af..5917883e528b 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -2229,6 +2229,7 @@ extern const struct bpf_func_proto bpf_kallsyms_lookup_name_proto;
>>   extern const struct bpf_func_proto bpf_find_vma_proto;
>>   extern const struct bpf_func_proto bpf_loop_proto;
>>   extern const struct bpf_func_proto bpf_strncmp_proto;
>> +extern const struct bpf_func_proto bpf_copy_from_user_task_proto;
>>
>>   const struct bpf_func_proto *tracing_prog_func_proto(
>>     enum bpf_func_id func_id, const struct bpf_prog *prog);
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index fe2272defcd9..d82d9423874d 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -5049,6 +5049,15 @@ union bpf_attr {
>>    *             This helper is currently supported by cgroup programs only.
>>    *     Return
>>    *             0 on success, or a negative error in case of failure.
>> + *
>> + * long bpf_copy_from_user_task(void *dst, u32 size, const void *user_ptr, struct task_struct *tsk, u64 flags)
>> + *     Description
>> + *             Read *size* bytes from user space address *user_ptr* in *tsk*'s
>> + *             address space, and stores the data in *dst*. *flags* is not
>> + *             used yet and is provided for future extensibility. This helper
>> + *             can only be used by sleepable programs.
> 
> "On error dst buffer is zeroed out."? This is an explicit guarantee.
> 
>> + *     Return
>> + *             0 on success, or a negative error in case of failure.
>>    */
>>   #define __BPF_FUNC_MAPPER(FN)          \
>>          FN(unspec),                     \
>> @@ -5239,6 +5248,7 @@ union bpf_attr {
>>          FN(get_func_arg_cnt),           \
>>          FN(get_retval),                 \
>>          FN(set_retval),                 \
>> +       FN(copy_from_user_task),        \
>>          /* */
>>
>>   /* integer value in 'imm' field of BPF_CALL instruction selects which helper
>> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
>> index b7aef5b3416d..110029ede71e 100644
>> --- a/kernel/bpf/bpf_iter.c
>> +++ b/kernel/bpf/bpf_iter.c
>> @@ -5,6 +5,7 @@
>>   #include <linux/anon_inodes.h>
>>   #include <linux/filter.h>
>>   #include <linux/bpf.h>
>> +#include <linux/rcupdate_trace.h>
>>
>>   struct bpf_iter_target_info {
>>          struct list_head list;
>> @@ -684,11 +685,20 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx)
>>   {
>>          int ret;
>>
>> -       rcu_read_lock();
>> -       migrate_disable();
>> -       ret = bpf_prog_run(prog, ctx);
>> -       migrate_enable();
>> -       rcu_read_unlock();
>> +       if (prog->aux->sleepable) {
>> +               rcu_read_lock_trace();
>> +               migrate_disable();
>> +               might_fault();
>> +               ret = bpf_prog_run(prog, ctx);
>> +               migrate_enable();
>> +               rcu_read_unlock_trace();
>> +       } else {
>> +               rcu_read_lock();
>> +               migrate_disable();
>> +               ret = bpf_prog_run(prog, ctx);
>> +               migrate_enable();
>> +               rcu_read_unlock();
>> +       }
>>
> 
> I think this sleepable bpf_iter change deserves its own patch. It has
> nothing to do with bpf_copy_from_user_task() helper.

Without the above change, using bpf_copy_from_user_task() will trigger 
rcu warning and may produce incorrect result. One option is to put
the above in a preparation patch before introducing 
bpf_copy_from_user_task() so we won't have bisecting issues.

> 
>>          /* bpf program can only return 0 or 1:
>>           *  0 : okay
[...]
