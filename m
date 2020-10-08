Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE1A286C66
	for <lists+bpf@lfdr.de>; Thu,  8 Oct 2020 03:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbgJHBeM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Oct 2020 21:34:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46874 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726371AbgJHBeM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Oct 2020 21:34:12 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0981Y2IZ012584;
        Wed, 7 Oct 2020 18:34:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=dI9P4qe0fiK/F4SNe2hq55etelYggSW/AE4HVzawR5A=;
 b=kjp8piy1U18ld+pTzKR0CQp+BSq3LFklebd0pB+dhIWd4C2u86qHAPQtBryFin/Z9ihF
 rFPLQoYgkKt9xNmIusyWg10PRLMF7OenoypeEU4kohZy83elt9q1lEdrF3Znzvur20x1
 Wt22mIDcjCp3Qqor74aIwU1FRd7kI3j6YrE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3418t9myed-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 07 Oct 2020 18:34:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 7 Oct 2020 18:33:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3Bdnsm+nCnS4g01P8QcTX47Ps9uxFQ659l1FGYZ8hMb/1lrWC61Mz6e39TDwIcvmzjPGgYTLZAEljz6NqWrh+bEGkbHexvgLYFaAPGre1cSHgpfcuMnmKZcaLiTbv3HInZ2AlfYvX+KJQlYKogVrNujbrPEggS79zN6jnNW9zyitglyZ4fDx2NFfXye3QxrQq7Nn+3O6tzd+WibqJs7jJ/DVT1sPcui2i5anUfyrPMQLQoD6GyAk5HyV1JcBqznY9TFkEXIpCqBIiafN+HWEDJceaxXPwJ70lAISHVDrGIatYQ07/tn4alMeGhdO7qK9ewF47iXUgsZwVw3DE1ahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eqfbir8g5n7OGVe8dlIXNAg3V9rv1t9fckv6teB7OAI=;
 b=er+TQXCWNIyoMLQe2CR+W7SvfS40UiB8/cjfznSBleS7BWqsl/TQRW+A90FhgwKeLhdAltQRzzvwX9CWe0Gy3bdnqLfSB4jYywvZ33DPXkudcTUFT3h/MVs+pxDX1TOHLapuE+p4iQafnGOKGFq5USyte3f2Fwc3P4uKcElK/H5MNg9iYvW9FwvHPo+y2F9t5HwEkh67IN96fksZ28JofnWIQzFbISdc40gmhRhshIu/95XlgebwBrNB+cWXHC4yylLaQU0DuGCqPWwklukYuvQvcdfjnUyuWQR3meN/SFYXs/fpXJ+UwmZNigdj4BILOeYOHPLECEzuMuYudKxVlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eqfbir8g5n7OGVe8dlIXNAg3V9rv1t9fckv6teB7OAI=;
 b=a5vdr5zb1SgKqh8ObUVI8D4kfsWRf32dATOmvJMEDwytY0hfuBkLlsZ/SrdUF9fAsd2AbWjvHek+DSbteeE+wu4VEDRhIlnX86cU0mqf2yCvzUDNV5N0yF9NRsEMeJSL6c/eg+k4t51Ppc4yOBLi3e6Xqw6nZcUeiao9lmuKU3w=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2198.namprd15.prod.outlook.com (2603:10b6:a02:8d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Thu, 8 Oct
 2020 01:33:54 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42%3]) with mapi id 15.20.3455.023; Thu, 8 Oct 2020
 01:33:54 +0000
Subject: Re: libbpf/bpftool inconsistent handling og .data and .bss ?
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Luigi Rizzo <lrizzo@google.com>
CC:     Luigi Rizzo <rizzo@iet.unipi.it>, bpf <bpf@vger.kernel.org>,
        Petar Penkov <ppenkov@google.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Stanislav Fomichev <sdf@google.com>
References: <CA+hQ2+gb_y7TViv13K_JpJTP=yHFqORmY+=6PrO4eAjgrBSitw@mail.gmail.com>
 <CAEf4BzbjUbYDrMc13-bYBBxicDmuokjLHyRaOVA-1JHD6vVbYg@mail.gmail.com>
 <CAMOZA0JFYEYmLqAQu=km624nZfY8epPEpmqqsdUigzp+jFsymQ@mail.gmail.com>
 <CAEf4BzYRiF00B+4=u8r-z+RN3bVWeV_h==4f_JJJZ133PhGAog@mail.gmail.com>
 <CAMOZA0J1u-DdNk4EDFxeemxNhS8teKYLmEEMPQUcfddaJFGwaw@mail.gmail.com>
 <CAEf4BzYnC+nBgeZ1uGb+upSwQiHpFK+hOM=fJ7WdUiZ4b1KdcA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <4f3a9f8b-bb7f-6800-6459-d12439899226@fb.com>
Date:   Wed, 7 Oct 2020 18:33:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
In-Reply-To: <CAEf4BzYnC+nBgeZ1uGb+upSwQiHpFK+hOM=fJ7WdUiZ4b1KdcA@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:20de]
X-ClientProxiedBy: MWHPR14CA0014.namprd14.prod.outlook.com
 (2603:10b6:300:ae::24) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1224] (2620:10d:c090:400::5:20de) by MWHPR14CA0014.namprd14.prod.outlook.com (2603:10b6:300:ae::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Thu, 8 Oct 2020 01:33:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aeeb73aa-e9bf-4310-cb79-08d86b2a3780
X-MS-TrafficTypeDiagnostic: BYAPR15MB2198:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2198577477DE9B39B1FBB549D30B0@BYAPR15MB2198.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CISGmKPX2kudI/neJVjtwPQN3HHevtboCBr0cER4GEIiHyhRAAPExYDX4+v+12PKSzhX51GdCQYqaRINzks/1l+ptmDSaAJNitc4gSN0jntgg6GbTYOo/0u6TI4KxMPGHCJvuuHZhRk4q1a6SRy6Rc7fHTVkLq3wfeNdLmleAqEWghT5oNSs0HTNzEcrq2l/P5UUDrwzv8nzsU5FFGJmssbvpyaw3XFad8g0mINJ2EbUE31BGMY2xrNcqYWtg8GaeGjOZL3jJoKs03CTpkaExFuFe/S8gTBERAHHJK1K3mqOdmiYGvz7kE5zkDAUvVSbwO4fTm92W+gbiHxJlmwfAeAGbWcJJXas/JdLHJgoBvIZPm2gCvkXsGYee603+wX2qxVkedluJUQFNZ+f6/onjNOdCPk3SnPqcbLXRA9QOUs7LC42OFnOfa0DJ+Jj56UCJNvacTrRr1YsYy4RyfOShjVJHLTt02so5/9yloa1+Js=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(376002)(396003)(366004)(2616005)(8676002)(8936002)(83380400001)(31696002)(4326008)(31686004)(83080400001)(6486002)(478600001)(66556008)(316002)(52116002)(66946007)(5660300002)(186003)(36756003)(16526019)(54906003)(2906002)(86362001)(110136005)(966005)(53546011)(66476007)(142923001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: au/3rstcFNi5QZgxlTNerZzMubvvEh8TQwXs75+1DRK57RlFOXrEnrqIJzaaaRo03Ns0X5dlubpSrerMG+F4MtElEMuCqP8erCfSx1v2aCcQkCSOfe69WC1uaDmP3YtQ0z2yWMdxNjhx6dZ5UGQggp56hDuujt7M2Fn1jy7aeJTCkKdotOmXKSWrA/6hoO39vu/Q+lrXHNVJjSeypEUQiSZ0zH691/XB0CDs/1xmKjCe0Om781spbEfZ0DH00l6KZFTrGQxcnXADIlABCZFykhr/M+H16e8FvK3R55Rbnlu3QlVImjHS6hLu/WKd4h9dk6rO+gqsl08tx1lI9K0+CQ8amOktlmb1DVAMthkWfeYGO0OdmAnTW3M/Ttf1I+ldZlX+nrvQNrnj4S9EAhB6TCy/jEO8rsvcTvR7EJPfH1SFQSAi+DxIfKKEibibnwOEKNc1Y9CT4epK0ijZqBDVG2gf+9ifjVSu/nmEBlGPTQ/2w+EE/yUeOyfHVJr9EjGLFnHALBS/OSagwSfEG3Y9URJhiz81Yh9e8GtSniZb7KKAJeSwXW2vCLx36lo+z81cY/5RLUKcAg5GtR/zqJcPHKfmzKX5ngo4dP09dNAv/7hfULoXXKWptnWKe1C5d88SvaBukJluL16i4mpKm1DOCqHYfzF+/lStTinUbb+sg8Q=
X-MS-Exchange-CrossTenant-Network-Message-Id: aeeb73aa-e9bf-4310-cb79-08d86b2a3780
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 01:33:54.0359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTslpjXpCfkiXcn4Iu/h7vO2f616m+qJFKUSxzZzW7PftLlptlzQXuaET+zORG8y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2198
X-OriginatorOrg: fb.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_10:2020-10-07,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010080012
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/7/20 3:26 PM, Andrii Nakryiko wrote:
> On Wed, Oct 7, 2020 at 2:29 PM Luigi Rizzo <lrizzo@google.com> wrote:
>>
>> On Wed, Oct 7, 2020 at 10:40 PM Andrii Nakryiko
>> <andrii.nakryiko@gmail.com> wrote:
>>>
>>> On Wed, Oct 7, 2020 at 1:31 PM Luigi Rizzo <lrizzo@google.com> wrote:
>>>>
>>>> TL;DR; there seems to be a compiler bug with clang-10 and -O2
>>>> when struct are in .data -- details below.
>>>>
>>>> On Wed, Oct 7, 2020 at 8:35 PM Andrii Nakryiko
>>>> <andrii.nakryiko@gmail.com> wrote:
>>>>>
>>>>> On Wed, Oct 7, 2020 at 9:03 AM Luigi Rizzo <rizzo@iet.unipi.it> wrote:
>>>>>>
>>>>>> I am experiencing some weirdness in global variables handling
>>>>>> in bpftool and libbpf, as described below.
>>>> ...
>>>>>> 2. .bss overrides from userspace are not seen in bpf at runtime
>>>>>>
>>>>>>      In foo_bpf.c I have "int x = 0;"
>>>>>>      In the userspace program, before foo_bpf__load(), I do
>>>>>>         obj->bss->x = 1
>>>>>>      but after attach, the bpf code does not see the change, ie
>>>>>>          "if (x == 0) { .. } else { .. }"
>>>>>>      always takes the first branch.
>>>>>>
>>>>>>      If I initialize "int x = 2" and then do
>>>>>>         obj->data->x = 1
>>>>>>      the update is seen correctly ie
>>>>>>            "if (x == 2) { .. } else { .. }"
>>>>>>       takes one or the other depending on whether userspace overrides
>>>>>>       the value before foo_bpf__load()
>>>>>
>>>>> This is quite surprising, given we have explicit selftests validating
>>>>> that all this works. And it seems to work. Please check
>>>>> prog_tests/skeleton.c and progs/test_skeleton.c. Can you try running
>>>>> it and confirm that it works in your setup?
>>>>
>>>> Ah, this was non intuitive but obvious in hindsight:
>>>>
>>>> .bss is zeroed by the kernel after load(), and since my program
>>>> changed the value before foo_bpf__load() , the memory was overwritten
>>>> with 0s. I could confirm this by printing the value after load.
>>>>
>>>> If I update obj->data-><something> after __load(),
>>>> or even after __attach() given that userspace mmaps .bss and .data,
>>>> everything works as expected both for scalars and structs.
>>>
>>> Check prog_tests/skeleton.c again, it sets .data, .bss, and .rodata
>>> before the load. And checks that those values are preserved after
>>> load. So .bss, if you initialize it manually, shouldn't zero-out what
>>> you set.
>>
>> Don't know what to say: it is cleared on my laptop 5.7.17
>>
>> I printed the values around assignments and calls
>> (also verified that obj->bss does not change):
>> Below, x is "uint32_t x = 0" in .bss
>> struct one { uint32_t a } s = { .a = 2} " in .data
>> Program output:
>>
>> before load, obj->bss is 0x7fb0698b6000
>> initially x is 0 s.a is 2
>> // x = 1; s.a = 3
>> before load x is 1 s.a is 3
>> after load, obj->bss is 0x7fb0698b6000
>> after load x is 0 s.a is 3 // note x is cleared, s is left alone
>> // x = 2; s.a = 4;
>> after assign x is 2 s.a is 4 variables by 10 every 5ms
>> // attach, when the program runs (every 5ms) does
>> // if (s.a == 2 || s.a > 10) { x += 10; s.a += 10}
>> after attach x is 12 s.a is 12
>> at runtime count_off is 2382 x is 12
>> at runtime count_off is 2382 x is 12
>> ...
>>
>> Could it be some security setting ?
>>
>>>
>>>>
>>>>>>
>>>>>> 3. .data overrides do not seem to work for non-scalar types
>>>>>>      In foo_bpf.c I have
>>>>>>            struct one { int a; }; // type also visible to userspace
>>>>>>            struct one x { .a = 2 }; // avoid bugs #1 and #2
>>>>>>      If in userspace I do
>>>>>>            obj->data->x.a = 1
>>>>>>      the update is not seen in the kernel, ie
>>>>>>              "if (x.a == 2) { .. } else { .. }"
>>>>>>       always takes the first branch
>>>>>>
>>>>>
>>>>> Similarly, the same skeleton selftest tests this situation. So please
>>>>> check selftests first and report if selftests for some reason don't
>>>>> work in your case.
>>>>
>>>> Actually test_skeleton.c does _not_ test for struct in .data,
>>>> only in .rodata and .bss
>>>
>>> It doesn't matter which section it's in, I meant it's testing struct
>>> field accesses from at least one of global data sections.
>>
>> Right but as the llvm-objdump shows, the compiler is treating
>> .bss and .data differently, at least for struct reads.
>>
>>>
>>>>
>>>> There seems to be a compiler error, at least with clang-10 and -O2
>>>>
>>>> Note how the struct case the compiler uses '2' as immediate value
>>>> when reading, whereas in the scalar case it correctly dereferences
>>>> the pointer to the variable
>>>
>>> It would be useful to include your original source code, especially
>>> the variable declaration parts. I suspect that you declared your
>>> struct variable as a static variable? In that case Clang will assume
>>> nothing can change the value and can inline values like 2. So either
>>> make sure you have a global variable declaration or use `static
>>> volatile`. See how `const volatile` is used throughout all selftests
>>> when working with the .rodata section.
>>
>> Perhaps the easiest is to see it on godbolt:
>>
>> https://godbolt.org/z/Mnx38v
>>
> 
> Thanks for the example. I can also reproduce this locally. It does
> seem like a Clang/LLVM bug at this point. The generated code makes
> absolutely no sense to me:
> 
> r1 = 100
> if r1 > 3 goto +5
> r1 = 3
> r1 += 111
> 
> Something fishy is going on there. I bet Yonghong will quickly figure
> out what's going on.

Thanks a lot for the test! This exposed a serious bug in llvm backend
for load optimization. The original opt pass is implemented in 2017
with local variables with initializer. Now *more* uses of global 
variables exposed additional bugs. I have posted a fix at
    https://reviews.llvm.org/D89021

> 
> BTW, I tried `static volatile` for the variable, marking volatile
> field a, marking variable as __attribute__((weak)). Nothing really
> helps, generated code is still weird and inlines constants.
> 
>> and how clang gets terribly confused when compiling read access
>> to the struct_in_data field
>>
>> cheers
>> luigi
