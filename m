Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DA72CB437
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 06:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgLBFGj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 00:06:39 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7142 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbgLBFGi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Dec 2020 00:06:38 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B25087m025312;
        Tue, 1 Dec 2020 21:05:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=caQgFUJrbRV9sB9abghjtJpgHM61oNZWt+gb0I6OFhM=;
 b=QcGliFfMUi+OBi0e2zYKyA+Zvkd8tf43Vx8tawEMDqNxdSHfi1A4V1Yt+mwcj5OyEr7M
 vbbmqbpFcW70BV6JFtzDYO9SGoamJN3gUpQ2UcXrNrWrA3vvhIR50Wp3oC5aJT/8M/W1
 Od/zo6A/9xoYXXoM4XVsl0SN1WbFsnx2Sq4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 355t7y3qqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Dec 2020 21:05:37 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 1 Dec 2020 21:05:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNaYfndCdDznFTYNp5X4KWxE0urari01z63swyKJC19s6rdutaaeEsqG9vCSvjuSqVJ1WrCRCqyiVahHnT1WSb9tpdUtKSxpCKbFekY7UeVrf4uuJ2e/QT6Lp2solr7h7JyO5dTxk9W30VvK+FYGtM3HDO3yLutyktp8zoKRABC0zMfltgB/tI6lrWfuzazzjUmWY33eH8TKRTwUp+QsoHENrpFgUNvSnmveib4DLmd3FLR+sMP31Zy34IN2DLmQ0HpBKgBFOqnEu11OV0a7Lg0QsJxYHfpLfkuyDPD5EDZJsLxSFc/EImUEFXWnNoS8CjX7VdlN+oT3KQxq5zgVOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kA5yiW/7BQTaBVWJgFrUjkn0hfVDDBQ075ofD60UNyM=;
 b=T9Y9c8KsM7BHqJ2vkJQgw38fy/PoYrDrYR72BcRWvJbzCvNMdPgqI0vviTtVlZ2kGmk82Jr2SJJPYdY2hVoqgZW/Dfwz5s7leRboJfVpXiImu27oCVzKGxbfZlzaPnfdPnpTa0HChsgjZpRaY/7GcT2zZLMd+dRKwR7XU8I72FoL6UyNqtg3/eUM/7veiY+KFuMgvGwLmV7hDP8y7BFr/KhAOnM3ky9bXn9tZjINPOKQht1TG9qZZ/HT+BzOa5MLhhlbi2PdJ3nnuO1QHOHWhg33jBjc4CIjZqW2GFsdZ5cSEHUb2ImH2jccN6RdVnY0zz7Bx51zSYbZqZEJivDJmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kA5yiW/7BQTaBVWJgFrUjkn0hfVDDBQ075ofD60UNyM=;
 b=UCRCXlZXLiPbEyrzP7EP5mauFckMO+bhOnq0xEYU1iSUQBHGHvzruimrRK0XKd4ogWP/e+H35uoQwmxY3sVivYA92yJKSBa68XD9/A0bnvxwgdP64q2pBscZNgEeLSMHuQKvWhQsEN09AbYeeLTLIdvHSTJUmRm2WDp2sLUVSnU=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2407.namprd15.prod.outlook.com (2603:10b6:a02:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Wed, 2 Dec
 2020 05:05:35 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3611.025; Wed, 2 Dec 2020
 05:05:34 +0000
Subject: Re: [PATCH v2 bpf-next 00/13] Atomics for eBPF
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Brendan Jackman <jackmanb@google.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <829353e6-d90a-a91a-418b-3c2556061cda@fb.com>
 <20201129014000.3z6eua5pcz3jxmtk@ast-mbp>
 <b3903adc-59c6-816f-6512-2225c28f47f5@fb.com>
 <4fa9f8cf-aaf8-a63c-e0ca-7d4c83b01578@fb.com>
 <CAEf4BzYc=c_2xCMFAE6RjMCHKWJj2euP2B21y-jfvsNzPVkhpQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <31a67edd-4837-cfd3-c9fe-a6942ebd87bb@fb.com>
Date:   Tue, 1 Dec 2020 21:05:31 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
In-Reply-To: <CAEf4BzYc=c_2xCMFAE6RjMCHKWJj2euP2B21y-jfvsNzPVkhpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:bbc1]
X-ClientProxiedBy: CO2PR04CA0097.namprd04.prod.outlook.com
 (2603:10b6:104:6::23) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1841] (2620:10d:c090:400::5:bbc1) by CO2PR04CA0097.namprd04.prod.outlook.com (2603:10b6:104:6::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Wed, 2 Dec 2020 05:05:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ec6729f-d429-45a9-d07e-08d8967fe69e
X-MS-TrafficTypeDiagnostic: BYAPR15MB2407:
X-Microsoft-Antispam-PRVS: <BYAPR15MB240759133736EA81984176E1D3F30@BYAPR15MB2407.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EtLv7jEh72Pnp2//MbYvTZsN/AvmJgWd5t9VPGoDEVkbfBsPdvtW3L5W5L9IvtSvy/QyDV2wKVOfmOVk7uxTZuv5bsPBPrCl6RL7wNvk7tpFYneNOLW6At7dYs9IpfGjciROzmS535MI/DLdjvvELLrOXtAmCDLiNVhc5UM5eXnC5OeEWw0BjYehuWK+isEvGNUKh2sh8rs7ttT2JlaiH6I5eNa+KCwxHOuxrSoBIpiGu087AHtMkFDDTvW/cWyBpWpRGyPgcQaPOvCRp6nQk/kOUg0krrUvEtrpCgD4PNNIJ7PLsafUnIzBcVLqExq8iQtxroh7eH6Fkyqj34uVvRPiEsf4758bpUivOfPYGGeIafaKXp6k1Cd1ff0ZoyR6BsLyWxl2gi160OeMuXL3b2e80KABlI8lMCkMjpSU7ctNn+FIqbg72lDoYsPKCN1juJ8qST8aYniHY1KCXhulWZIDsqa4CXIam/4wrv3XmBunlnJ+29ZLAHH5HDZjU8qAdJqy9awcefI8oUsNkONtDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(366004)(39860400002)(31686004)(52116002)(478600001)(66946007)(186003)(16526019)(66476007)(66556008)(966005)(6916009)(54906003)(4326008)(316002)(2906002)(7416002)(53546011)(6486002)(36756003)(2616005)(8676002)(5660300002)(31696002)(8936002)(86362001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bExJb1llZHhYZnNmNXFTOHRiV1hwcTJQY3JTOW5WZ0tCZG9WU2daazJlZTF0?=
 =?utf-8?B?MkRSbmlZS1NqU0JLWDZvVW81QmN0cEZaaWdSQXNobmFnc1J6RGlITEZRYys5?=
 =?utf-8?B?dDJ5djJBRkhUWTN3WGh5S0s4TmR3T2RlZHE1UDBUUi94WG8vSE4xT2tsRDBN?=
 =?utf-8?B?M3dXRkRWYkFXQ0ZSU1orMmQyME1rRGhUOWdQMTE5M2hub3R2MFhWMUJhR3la?=
 =?utf-8?B?eXhpTmlNT29CM1RKNE9KVjlVdEd4WWNnbXdkVE1ESHRReWp4VTdyeTBMMTdy?=
 =?utf-8?B?Sm5XNkttVnplWWRySlRaNEdHdnhLNU4yNDAwdFhLckRaYzlDa3ZYWGpwSUU0?=
 =?utf-8?B?Z3JmZCtOaFZyaG9PajlNUTl5Q2VmUC9jTCt6ZVFhN2I2QXpsTExlczNuemp0?=
 =?utf-8?B?R3JJNXJoeDJ6RjJEdk5MSE9EbHNmU2JJRTQxeVJZNC92NWt0VFJyQkFSS2Rs?=
 =?utf-8?B?Qmh6NitGM1U0WWlNSzF4T1BxdXZoSWpaV05oU1pFNENzT3NrUi9HemtFUkRJ?=
 =?utf-8?B?TWh5bWpwdzdJdGVvWlBmUUFBOGYzMG1TNFUrT3FtWGdMRzJKbWExQlRVM0gz?=
 =?utf-8?B?UmdxV0hJN3FiUTZQaXZWaithR0R5ODVmQXVWNFB5NkFnSS9pWXFZTzFlSDZF?=
 =?utf-8?B?eUhVSVVuaXNuNHJMeDZjMzJDcnRTelU3T0REaU10MmFkcnlRQVBWbHg1S3VU?=
 =?utf-8?B?ZG44ZmM5cGZYZUJBU3NDTUpDUTlZbjgydks2ajFXVDNkNkFSR05IUSs3WGt2?=
 =?utf-8?B?VERXWUJsZi81blJUUlFncC9naUxEMXhHeWtySUkzVWxoQVN1MWZXeGpOc25U?=
 =?utf-8?B?cWZJd3l1dTFDMTdvUDd5WThjRmdJSWtCZ1VuRk42Nng2VHJ2d250ZTlFNUdi?=
 =?utf-8?B?K2lQeGZqZWsrMit3dTg0RU50ay9XY3RYR0lhQlNyeEgxUnNtQy9Ga3N6TUp5?=
 =?utf-8?B?QTV6dmhSR2hwSzBDSCtqVm1Fdno2b05JdmdYek03dEV4Zlg3dEtOYjZkdHdO?=
 =?utf-8?B?ZjJwdXhpbTc4dEs5cnhDZ3dtVEtvZGlya051Z2N0UjVzZFl2VE1qV0RMdFFC?=
 =?utf-8?B?NVI4MU9DVlNOY3RLdG5OalIxZzhXM0E0Sm95VlpyZHVPakMwVkdxclI2OW4z?=
 =?utf-8?B?ZXhTelJNSUtkMFlBV3JVdXErT29PV1dFRjF5Tk9nVlIwUmNVRmZYbWwzUGxF?=
 =?utf-8?B?WCtic3FLc3h3MVFPa0hRU3BvUE5KYUN4UTJNU1BDWHFTWGlodlg5SHlMYWhH?=
 =?utf-8?B?UFpWSDJ3S1hrcGRXVFlKWTJiUFdmb3VJTmdYd3RydnBkaDF0cXlZcFFMZThD?=
 =?utf-8?B?cHROWjF1SmN1RysydWY4aFdXYlVEMUxkZEhaUS85YzQxcnNZWkZYM2MraTlN?=
 =?utf-8?B?b2ZwNjBFZUg0TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec6729f-d429-45a9-d07e-08d8967fe69e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 05:05:34.8535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZN/qOvax/NHRv6zirQhjZqoYyJ2EbnxLBFVwSyqXsDoOW+w7X49cSZI0VFfFmkBd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2407
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_12:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020031
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/1/20 6:00 PM, Andrii Nakryiko wrote:
> On Mon, Nov 30, 2020 at 7:51 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 11/30/20 9:22 AM, Yonghong Song wrote:
>>>
>>>
>>> On 11/28/20 5:40 PM, Alexei Starovoitov wrote:
>>>> On Fri, Nov 27, 2020 at 09:53:05PM -0800, Yonghong Song wrote:
>>>>>
>>>>>
>>>>> On 11/27/20 9:57 AM, Brendan Jackman wrote:
>>>>>> Status of the patches
>>>>>> =====================
>>>>>>
>>>>>> Thanks for the reviews! Differences from v1->v2 [1]:
>>>>>>
>>>>>> * Fixed mistakes in the netronome driver
>>>>>>
>>>>>> * Addd sub, add, or, xor operations
>>>>>>
>>>>>> * The above led to some refactors to keep things readable. (Maybe I
>>>>>>      should have just waited until I'd implemented these before starting
>>>>>>      the review...)
>>>>>>
>>>>>> * Replaced BPF_[CMP]SET | BPF_FETCH with just BPF_[CMP]XCHG, which
>>>>>>      include the BPF_FETCH flag
>>>>>>
>>>>>> * Added a bit of documentation. Suggestions welcome for more places
>>>>>>      to dump this info...
>>>>>>
>>>>>> The prog_test that's added depends on Clang/LLVM features added by
>>>>>> Yonghong in
>>>>>> https://reviews.llvm.org/D72184
>>>>>>
>>>>>> This only includes a JIT implementation for x86_64 - I don't plan to
>>>>>> implement JIT support myself for other architectures.
>>>>>>
>>>>>> Operations
>>>>>> ==========
>>>>>>
>>>>>> This patchset adds atomic operations to the eBPF instruction set. The
>>>>>> use-case that motivated this work was a trivial and efficient way to
>>>>>> generate globally-unique cookies in BPF progs, but I think it's
>>>>>> obvious that these features are pretty widely applicable.  The
>>>>>> instructions that are added here can be summarised with this list of
>>>>>> kernel operations:
>>>>>>
>>>>>> * atomic[64]_[fetch_]add
>>>>>> * atomic[64]_[fetch_]sub
>>>>>> * atomic[64]_[fetch_]and
>>>>>> * atomic[64]_[fetch_]or
>>>>>
>>>>> * atomic[64]_[fetch_]xor
>>>>>
>>>>>> * atomic[64]_xchg
>>>>>> * atomic[64]_cmpxchg
>>>>>
>>>>> Thanks. Overall looks good to me but I did not check carefully
>>>>> on jit part as I am not an expert in x64 assembly...
>>>>>
>>>>> This patch also introduced atomic[64]_{sub,and,or,xor}, similar to
>>>>> xadd. I am not sure whether it is necessary. For one thing,
>>>>> users can just use atomic[64]_fetch_{sub,and,or,xor} to ignore
>>>>> return value and they will achieve the same result, right?
>>>>>   From llvm side, there is no ready-to-use gcc builtin matching
>>>>> atomic[64]_{sub,and,or,xor} which does not have return values.
>>>>> If we go this route, we will need to invent additional bpf
>>>>> specific builtins.
>>>>
>>>> I think bpf specific builtins are overkill.
>>>> As you said the users can use atomic_fetch_xor() and ignore
>>>> return value. I think llvm backend should be smart enough to use
>>>> BPF_ATOMIC | BPF_XOR insn without BPF_FETCH bit in such case.
>>>> But if it's too cumbersome to do at the moment we skip this
>>>> optimization for now.
>>>
>>> We can initially all have BPF_FETCH bit as at that point we do not
>>> have def-use chain. Later on we can add a
>>> machine ssa IR phase and check whether the result of, say
>>> atomic_fetch_or(), is used or not. If not, we can change the
>>> instruction to atomic_or.
>>
>> Just implemented what we discussed above in llvm:
>>     https://reviews.llvm.org/D72184
>> main change:
>>     1. atomic_fetch_sub (and later atomic_sub) is gone. llvm will
>>        transparently transforms it to negation followed by
>>        atomic_fetch_add or atomic_add (xadd). Kernel can remove
>>        atomic_fetch_sub/atomic_sub insns.
>>     2. added new instructions for atomic_{and, or, xor}.
>>     3. for gcc builtin e.g., __sync_fetch_and_or(), if return
>>        value is used, atomic_fetch_or will be generated. Otherwise,
>>        atomic_or will be generated.
> 
> Great, this means that all existing valid uses of
> __sync_fetch_and_add() will generate BPF_XADD instructions and will
> work on old kernels, right?

That is correct.

> 
> If that's the case, do we still need cpu=v4? The new instructions are
> *only* going to be generated if the user uses previously unsupported
> __sync_fetch_xxx() intrinsics. So, in effect, the user consciously
> opts into using new BPF instructions. cpu=v4 seems like an unnecessary
> tautology then?

This is a very good question. Essentially this boils to when users can 
use the new functionality including meaningful return value  of 
__sync_fetch_and_add().
   (1). user can write a small bpf program to test the feature. If user
        gets a failed compilation (fatal error), it won't be supported.
        Otherwise, it is supported.
   (2). compiler provides some way to tell user it is safe to use, e.g.,
        -mcpu=v4, or some clang macro suggested by Brendan earlier.

I guess since kernel already did a lot of feature discovery. Option (1)
is probably fine.
