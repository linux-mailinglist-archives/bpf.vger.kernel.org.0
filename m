Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1194E33446D
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 18:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhCJRAL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 12:00:11 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37240 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233783AbhCJQ7j (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Mar 2021 11:59:39 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12AGfj5L001216;
        Wed, 10 Mar 2021 08:59:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=7xNgyOVIKeay23LTQDLZqmGHNkrh2pialKkiJp6JHMo=;
 b=RjzDGZ6DzLYoWRv1tUdODPh3zs+G7DgQGPIDxtFiUX+UtJcIdV21DK/rz/guPm0Y4c2q
 gJYx8qQI4D8LKN/2u9F2rjZhQQPndVsj11CXKU4Dz3XnGSIA/uQPDJpYNgjwMXMAWfcK
 xeaDOvMPHpyy2cmST1NturXdWKGevUt6ZUo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 376c07ptvn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 10 Mar 2021 08:59:24 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 10 Mar 2021 08:59:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXVrd89nUeyX/4PRjZQsW9NtML7+wm1lL9teasU0RZlAkz4Wtv14vF5XPwgoUqIRv7otTkbQ2WFiJ0xVSq/8JJrVV2vkkiTlakQAO5NV0THDh7j46D/hKNBdFx1kt8Li7F3txIKwoFdh0POP26rysiPY/t5z5y7+7Jx0Z3NqN/t3KHgs2/9giJSvo+oVkqVWUjG3tu3+piai5OLwLEgUIUFadSqiA1L1NQKksSUHW92z2TWDajgS2YFXWn7STvDf/KyH5xGtOoe32J9aTrbTzILTgMBy2R37wN9cfJoaQ5hYNIdLFaZdPeWiZSwrA4wINTBTqPVRPZotCswpMDxAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xNgyOVIKeay23LTQDLZqmGHNkrh2pialKkiJp6JHMo=;
 b=SouhYtR9r9hSUXRJJgJ1iTJPwERgPg1UDmvYNdRiG6KyxcuPGlMYctD6e0NcyHTSHJIoegV2YK+aG9ZIQhmBZsfBetc/TnDaokugdlSGxXlFnhYibqtf+GlleKPTzQwA/9JPi+HF5dyenjdnioJPTHhu8NpFiF8PfRVjOCciAOe5ZlOeGq2kK0kX68FI2TLH9uBLU8Gj5mzpECAZYBFhxqSoqabZlVBguYGrgvJzP8d1PazGWUNnICPhZ6VnNPfSs4wTUtbyOmD25tUrK3tb7u5R+dNKJN2ZiUHrAg2u5fm8VN+5borqk1wQ0TTWNxuTCctl35H08qDvm1noon0gFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB1968.namprd15.prod.outlook.com (2603:10b6:805:e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 16:59:23 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.039; Wed, 10 Mar 2021
 16:59:22 +0000
Subject: Re: [BUG] One-liner array initialization with two pointers in BPF
 results in NULLs
To:     Florent Revest <revest@chromium.org>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210310015455.1095207-1-revest@chromium.org>
 <f5cfb3d0-fab4-ee07-70de-ad5589db1244@fb.com>
 <eb0a8485-9624-1727-6913-e4520c9d8c04@fb.com>
 <CABRcYmK8m21sb8dHbr1wLT_oTCBpvr2Zg-8KHwKuJ2Ak0iTZ_A@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <454d2e4b-f842-624c-a89e-441830c98e99@fb.com>
Date:   Wed, 10 Mar 2021 08:59:18 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <CABRcYmK8m21sb8dHbr1wLT_oTCBpvr2Zg-8KHwKuJ2Ak0iTZ_A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:9c2d]
X-ClientProxiedBy: MW4PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:303:8d::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1111] (2620:10d:c090:400::5:9c2d) by MW4PR03CA0167.namprd03.prod.outlook.com (2603:10b6:303:8d::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 16:59:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dcea82c-7ad8-47f5-30bc-08d8e3e5da86
X-MS-TrafficTypeDiagnostic: SN6PR1501MB1968:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB1968430001572877BF1BEB9BD3919@SN6PR1501MB1968.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dw7VO2fMuGYLaHZahJn+nQinnhU25zQP37fhMXDC3grC69nmZ61n5wgTZk+IvaOW3nE/fDlMkk71ZPMYljRgLjit5qYl3Qj6kFdPVlK6oDmYNv5Z5o6adHcUH3kgULIMj3HAd7ne6DYyxlJQd/1ppaBW+AATkv9W7WByUg2SWAK2ZoNiluUEHwq8Ub3ZHPe6/+FwJsf/pAjjbnRz4pMzDX+IDETOe+9zv7YySaWlf3LsQTjdMYPsiC59sXseoGyJPD7mHotgFMFXAympzVZ8tmSho/9X40JsX8EsNFYRrZzlZwHYNfcCR6vHZ9wa3hpIeu8RH4H2hbDlW3A6P6iWVC6fcbWSmaNbm0Gf7PV7bOH0YNcsw65WEQA1+QoNzG9aBcJLMa+71jnMwTwsWE/bRPHMn1/yHi2HA32/rjv7/zSwZRobN0UT7pnCLc33W+UZqsXb8Nbxu+Z7K3eBeWRb1bySiMCE0ifSou8BkcOiO5nHqEVRm5e1ovbT8lJFSjS1qaWW7pWNKDIWllKy2Hx3Owbn+euiH7GuV2pTpAkzSecoNp+OfcTF8GORz2lL4YqrcnPSGoA2FkOjBvumRkNI6+kKrOPEE4WHpwYjSdAEHAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(346002)(396003)(376002)(4326008)(31686004)(66946007)(53546011)(478600001)(54906003)(6486002)(83380400001)(52116002)(31696002)(6916009)(5660300002)(186003)(2906002)(36756003)(16526019)(66556008)(316002)(8676002)(6666004)(66476007)(8936002)(2616005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RnZyRXM2TUlsUGhpWWtIZkF3T3JTTG1ab1R6c1FWcE5BdmNqakJSd2tZNmZj?=
 =?utf-8?B?TzAxZzVpY0tNd3d1d2IvWUlHTnpTNGhJOEpUa0o5Nko2OTduUk9DU0NCenB6?=
 =?utf-8?B?QVpSb1IxRytEZTV2T1crSnE0UUM1TCtJVVhyYUJma3BCY3ZWcDhtZFNJTVBN?=
 =?utf-8?B?MWcvSDRjMW11R0V6cFZhMUhhNDZua0RKUGlhWWQxOXlkMDRQM2RxK0dxUmIz?=
 =?utf-8?B?MURTRlVMRTBIS2JaS0w1RXF3SzFZNG1nNmJ6eFgrMElETHRSdHpmTGdjbTl6?=
 =?utf-8?B?aFEvckZVM1F6OEZ0UEZhMWNibXFQK1BjSDBTaHlrZnNGRHBHQ0MwbTB0ejVq?=
 =?utf-8?B?amNOamVMdmVNdWsyUVVDZGZNVUVaTUoyb0c2a2E3QmpNOFY0Tlo2U0FxWDRE?=
 =?utf-8?B?RHFaMFM1MDlpTGltRWw2TmRSWFpKU2RiWkpHWnYybHVyUy9naTZaeE95bmRi?=
 =?utf-8?B?NkZva1UwS0tFQnVCVVRzSTJ1bnVnZWNwMmpkWGFLbTc2bUR2SHRDdURZQVlK?=
 =?utf-8?B?NTJRUHVDaU5IcHRnVXE0Rlh4dVpETkxEVWRmY1IzUnVtT0J2ZVBPQmM1QzFp?=
 =?utf-8?B?ZFFWc05CKzBIT25TUjBYSnoxaTFSRFluTVA1ZDhSV0s0aENjbzdCZit1R0Uz?=
 =?utf-8?B?M2FHR3FrZmc3cHQvMVgzOHRHb2t6YWRDNi9BNEZrZ0dyMVN1N0VUZlE3L0tP?=
 =?utf-8?B?alE5UHNkUVA3emdUREc1QUpUMklxVWt1SHNEZjlnYmNrRnBxcEhoUXRBWEJN?=
 =?utf-8?B?ZUVTVWxvcmRWbVp4KzY2ZFpoWUcyZWU5eVhaOXNMOUd3ei9ENGFjbFUxbEpZ?=
 =?utf-8?B?Sm03NlM1ZEE1c2l2dmkxeDE2NjM2RFBnRk85YXhqVmUwc1oxZUZnanZqblFJ?=
 =?utf-8?B?aVNDdXR2eGVQS1N4YmxjcE92QTZPTXl5NkFlOE5uRkQ3YU1MMmhjczZiRU5j?=
 =?utf-8?B?UEFyVjBqd0RRcmRra3pjdzVTbjI1dVJkVG1uOGFHUVRSYitOc0VsY3RBeFBG?=
 =?utf-8?B?ZDdGVnpDQnNqS0g2TlZxRTZDa0ZhaElTZWp5OTFWbSt1NEZXSXJHRG9Uc0VS?=
 =?utf-8?B?b0xxVUJpUWZJc3JHVEJnRXdBbUIzeHRTOU9PMmVtQlA5OUtZelBicWxKRWZn?=
 =?utf-8?B?bjcySy9sT0czL0x6bDFmaDFWdlg2OHVTSkI4MVd3TkdrbS9CYUFoVFhLWHM4?=
 =?utf-8?B?S0NiYWhZcG5Belp4ZlZoL1VnemEvNDN6VVRYaE9ycGxuK2VkRklidHQ5Qkk3?=
 =?utf-8?B?TTFQYStNMXZoWGZXZ3o2N0UzTXFiYVB3b0h4REh2NXhoTDdqVWtqNkhvNmlE?=
 =?utf-8?B?b0s3d0JkYmltbXQrUnVVbXIzQzdWRHRpQjMxb1BzbzU0RUk5cU1xdlZ3U21E?=
 =?utf-8?B?RTFDZU85RDNPNzFSOFdXVTFnT1JjY1BUQVZ5dHNwOTZHZkMyZ0lHOXN1UzJp?=
 =?utf-8?B?RmlXeExCM0c4TGJUM2xYRlNWQytGR21XM2ZneDZXTzEyalg0NmV2UHhKOEhx?=
 =?utf-8?B?K3hpa1UzeW5yQmRiVENWRmJiWENGeFFRWjU4WklWaDJxOHhId3hXai8zUHlS?=
 =?utf-8?B?R3FRVCtxWmplTHY1TjJDVCtzQ25mTVZPWHVxRzBoME5PQ2dzTWRkRWNQTjBp?=
 =?utf-8?B?aGZlWVN4WXdkVDJvRFZVOXBWUFJ4cXVHNWJuMGkxajJVbWYxc3ZtZGkvcXZG?=
 =?utf-8?B?M3Z6SmpHZzR1bHRTOFhWb2w0RE4zWTZKVFVWK1FVZGhnUFp1VGdpS1NYaWNu?=
 =?utf-8?B?em1GNkx6dHpBZ1M1dWQ2OHZLd2ZyRW5LU294d3A1WnFGQUpoYVhUNFJWKzlm?=
 =?utf-8?B?WkdETkd1UDh1S2Q3QVlQZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcea82c-7ad8-47f5-30bc-08d8e3e5da86
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 16:59:22.8547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9unaWXY9qwm7DF5BijHiQSQSiiM/inVNn9nYkis+nza6UDxAufKJwxKy8qRAL3f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB1968
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_10:2021-03-10,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100082
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/10/21 3:48 AM, Florent Revest wrote:
> On Wed, Mar 10, 2021 at 6:16 AM Yonghong Song <yhs@fb.com> wrote:
>> On 3/9/21 7:43 PM, Yonghong Song wrote:
>>> On 3/9/21 5:54 PM, Florent Revest wrote:
>>>> I noticed that initializing an array of pointers using this syntax:
>>>> __u64 array[] = { (__u64)&var1, (__u64)&var2 };
>>>> (which is a fairly common operation with macros such as BPF_SEQ_PRINTF)
>>>> always results in array[0] and array[1] being NULL.
>>>>
>>>> Interestingly, if the array is only initialized with one pointer, ex:
>>>> __u64 array[] = { (__u64)&var1 };
>>>> Then array[0] will not be NULL.
>>>>
>>>> Or if the array is initialized field by field, ex:
>>>> __u64 array[2];
>>>> array[0] = (__u64)&var1;
>>>> array[1] = (__u64)&var2;
>>>> Then array[0] and array[1] will not be NULL either.
>>>>
>>>> I'm assuming that this should have something to do with relocations
>>>> and might be a bug in clang or in libbpf but because I don't know much
>>>> about these, I thought that reporting could be a good first step. :)
>>>
>>> Thanks for reporting. What you guess is correct, this is due to
>>> relocations :-(
>>>
>>> The compiler notoriously tend to put complex initial values into
>>> rodata section. For example, for
>>>      __u64 array[] = { (__u64)&var1, (__u64)&var2 };
>>> the compiler will put
>>>      { (__u64)&var1, (__u64)&var2 }
>>> into rodata section.
>>>
>>> But &var1 and &var2 themselves need relocation since they are
>>> address of static variables which will sit inside .data section.
>>>
>>> So in the elf file, you will see the following relocations:
>>>
>>> RELOCATION RECORDS FOR [.rodata]:
>>> OFFSET           TYPE                     VALUE
>>> 0000000000000018 R_BPF_64_64              .data
>>> 0000000000000020 R_BPF_64_64              .data
> 
> Right :) Thank you for the explanations Yonghong!
> 
>>> Currently, libbpf does not handle relocation inside .rodata
>>> section, so they content remains 0.
> 
> Just for my own edification, why is .rodata relocation not yet handled
> in libbpf ? Is it because of a read-only mapping that makes it more
> difficult ?

We don't have this use case before. In general, people do not put
string pointers in init code in the declaration. I think 
bpf_seq_printf() is special about this and hence triggering
the issue.

To support relocation of rodata section, kernel needs to be
involved and this is actually more complicated as
the relocation is against .data section. Two issues the kernel
needs to deal with:
    - .data section will be another map in kernel, so i.e.,
      relocation of .rodata map value against another map.
    - .data section may be modified, some protection might
      be needed to prevent this. We may ignore this requirement
      since user space may have similar issue.

This is a corner case, if we can workaround in the libbpf, in
this particular case, bpf_tracing.h. I think it will be
good enough, not adding further complexity in kernel for
such a corner case.

> 
>>> That is why you see the issue with pointer as NULL.
>>>
>>> With array size of 1, compiler does not bother to put it into
>>> rodata section.
>>>
>>> I *guess* that it works in the macro due to some kind of heuristics,
>>> e.g., nested blocks, etc, and llvm did not promote the array init value
>>> to rodata. I will double check whether llvm can complete prevent
>>> such transformation.
>>>
>>> Maybe in the future libbpf is able to handle relocations for
>>> rodata section too. But for the time being, please just consider to use
>>> either macro, or the explicit array assignment.
>>
>> Digging into the compiler, the compiler tries to make *const* initial
>> value into rodata section if the initial value size > 64, so in
>> this case, macro does not work either. I think this is how you
>> discovered the issue.
> 
> Indeed, I was using a macro similar to BPF_SEQ_PRINTF and this is how
> I found the bug.
> 
>> The llvm does not provide target hooks to
>> influence this transformation.
> 
> Oh, that is unfortunate :) Thanks for looking into it! I feel that the
> real fix would be in libbpf anyway and the rest is just workarounds.

The real fix will need libbpf and kernel.

> 
>> So, there are two workarounds,
>> (1).    __u64 param_working[2];
>>           param_working[0] = (__u64)str1;
>>           param_working[1] = (__u64)str2;
>> (2). BPF_SEQ_PRINTF(seq, "%s ", str1);
>>        BPF_SEQ_PRINTF(seq, "%s", str2);
> 
> (2) is a bit impractical for my actual usecase. I am implementing a
> bpf_snprintf helper (patch series Coming Soon TM) and I wanted to keep
> the selftest short with a few BPF_SNPRINTF() calls that exercise most
> format specifiers.
> 
>> In practice, if you have at least one non-const format argument,
>> you should be fine. But if all format arguments are constant, then
>> none of them should be strings.
> 
> Just for context, this does not only happen for strings but also for
> all sorts of pointers, for example, when I try to do address lookup of
> global __ksym variables, which is important for my selftest.

Currently, in bpf_seq_printf(), we do memory copy for string
and certain ipv4/ipv6 addresses. ipv4 is not an issue as the compiler 
less likely put it into rodata. for ipv6,
if it is a constant, we can just directly put it into the format
string. For many other sort of pointers, we just print pointer
values, I don't see a value to print pointer value for something like
     static const param[] = { &str1, &str2 };
     bpf_seq_printf(seq, "%px\n", param[0]);

The global __ksym variable cannot be pointing to rodata at compile time,
so it should be fine.

> 
>> Maybe we could change marco
>>      unsigned long long ___param[] = { args };
>> to declare an array explicitly and then have a loop to
>> assign each array element?
> 
> I think this would be a good workaround for now, indeed. :) I'll look
> into it today and send it as part of my bpf_snprintf series.

If we can make it work, that will be great! thanks for working on this.

> 
> Thanks!
> 
