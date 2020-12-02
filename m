Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081AA2CB62B
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 09:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387716AbgLBIE0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 03:04:26 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57222 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387712AbgLBIEZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Dec 2020 03:04:25 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B283Som004728;
        Wed, 2 Dec 2020 00:03:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=u2TUuUxFFYGFDp66tQn3A9BiZKETGlA9+fR3ovt7DVQ=;
 b=WpPLxkBZOn96QcNR6xPXENpiTyyLmdQWD15An52VQ6XSH8OKe9dQ16J1zqQjmuQyz2Hi
 tKqnliHvDgIgqdG0pHWxqV5GSb3IBe0MaDQUD9H/HXjobUU8Vw8bnDDgM8VUDIrFgJv0
 UktqD1l0t82WZlob7AE1EktLh0owcBYCg7Q= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 353uh53apj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 02 Dec 2020 00:03:25 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 00:03:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcINEhhyvkWHb7IcBqGbyz8Mbhi49NDju2am8xfZ1gZSQNKtXU9KPxRZHd5V0qZXqGEfCkI6C+krvzZTqiXQWCwWWk8x3hgJGOIMMS2Tr4x3myawFR1CaXN+bisNc/jaMizg7YmpoDwhtxr/coTGNJz7RF9NV0F71FAJageLyX2wYqtXTWOM43TNnL6ZDkHwh3dadDZ3tljxWXAPvRWmB7mkuXSDE2mNITYUjsDCUbOuyRNofSwkbJQfA75KBkQAs9dAPA7vaXRTREYrjHcp8NQUk8aix8mgySSApuuwU0Okl3FVa+nvhKv7FGtnoSRHS1NDocC9Ed+xMyycxasU9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekjr3XX7w6JdrIKwDE+Qez5luXhm8EYvR/T51RDr31Y=;
 b=nXW3BWW5X82PNRbMlo60ylWns3Cr8swNvL7L162BVo+C8hk5Cl9cl11nMsUlLDyQBlc2KCxPW4lglcbQ5LzKa2FztfYjSA5bru8gVUHfdPDKa000nDUBJxv8gq+NA6l0OU8JQjL/3EMu1uRe6G7vJnqf0DoyLgWjqUYHpeF89XZzbZQLojrWN+sPQMNs7aY3AC1QsCoD4ESyQ+997cV+LmKyHP//gipXOZyLcgtCY2hHtQqF4CXWz9o5IeFoVgioJ1E5bOj6VD6wb2LdM6erih4eTIe6uevy/JIUJ1M8Kz6R1HIv39VMi3q/yXn+uvHhTI96RRDGFEjTnhPOeyheKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekjr3XX7w6JdrIKwDE+Qez5luXhm8EYvR/T51RDr31Y=;
 b=QvxCvHrxHhOkDG5b7Un7VsGKE4LH4kn9HeCrwB6kWswFKOEv/4YjwD4dnE0t3bWo4ZJflg//v+c2hjRPRsPJ+acV7mI1p2qLOtneK8xDDwBeV84OMCz+sGe2vB2KOSEHBCSNH1lViKqdAAjFzzymGeXkAc6SSlCirshCRb3KZBM=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2647.namprd15.prod.outlook.com (2603:10b6:a03:153::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Wed, 2 Dec
 2020 08:03:18 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3611.025; Wed, 2 Dec 2020
 08:03:18 +0000
Subject: Re: [PATCH v2 bpf-next 00/13] Atomics for eBPF
From:   Yonghong Song <yhs@fb.com>
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
 <31a67edd-4837-cfd3-c9fe-a6942ebd87bb@fb.com>
Message-ID: <d423d325-b861-1954-a3ea-cd7b63aa02fc@fb.com>
Date:   Wed, 2 Dec 2020 00:03:15 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
In-Reply-To: <31a67edd-4837-cfd3-c9fe-a6942ebd87bb@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:bbc1]
X-ClientProxiedBy: MWHPR1201CA0021.namprd12.prod.outlook.com
 (2603:10b6:301:4a::31) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1841] (2620:10d:c090:400::5:bbc1) by MWHPR1201CA0021.namprd12.prod.outlook.com (2603:10b6:301:4a::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Wed, 2 Dec 2020 08:03:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6a3be03-f6dc-4ba3-e94d-08d89698ba51
X-MS-TrafficTypeDiagnostic: BYAPR15MB2647:
X-Microsoft-Antispam-PRVS: <BYAPR15MB264719E288CA0220E97BEDE5D3F30@BYAPR15MB2647.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XkYJFy/3bHwn3te8zveSuku2lGKzu7MOm0acbIrZZ/+klRSBdz6fow/PiYBiQURkgRdwfn3GvZeANivSSCzXPhQDbFhmZ9/t//gfEz+rMWU75XTlWJPlhED6yYHOg6EoOeD53VjQJosuOScTMDlSz1Zcot4qqzvXLuGOmKWTmomyGP6N99UDdiLNXvwaqwqFLl5A6pRoJ+IK9HmzR9H/UJPCcy/Z8qA8P02YoegX87fZNDwXhwi6MQWbwAYAw54L0hH4RxvAHUuEiTh1/DyA31AOQ0ehx8rWS5uKuefnwdWlIT8pLGmvcTPVaPwwRK+hn2FNcRljL43RQ5Y6aNEH8oAo3ODSjct3Bjk5fNtrUhWk4NemZLGL5DjZnw7it/OmRU1H+1YpROl0wc5bZvWbwMM6o2dDJkgQdruhBn1/B4D7dCMKQdan6Klq+XvJiIpTEYxNbrar6GqcTp9ypplE6l802YMt/VQ/+lx7wd4zmdoE9ITbjMkBmdf52RP3GE9XdpHjnUP+VxXV81yUgURQWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(396003)(376002)(136003)(478600001)(52116002)(7416002)(186003)(2616005)(54906003)(16526019)(86362001)(66556008)(66476007)(36756003)(4326008)(966005)(31696002)(66946007)(316002)(6486002)(8676002)(8936002)(5660300002)(6916009)(53546011)(2906002)(31686004)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MUNQZXRKME1hRXdkSDJPcTJ3YUpmYTRlYVZQUE8vMnFITjVBU0FHSFFTVTJN?=
 =?utf-8?B?STdmZGFtRVNhMm8rVWtEbXdWSEN6QU9Qd0ExbEFuRkJnZk5oNGFtZEdqc3Bi?=
 =?utf-8?B?NzV0aHE1R3FEZU13clcxTEV0SjB6a1hlUXpFSUJkaGRDWm5FT1pqU25wOVNV?=
 =?utf-8?B?MkZYVUhJMlp5dVBRTjV0SDJham9jbENnWXd0Yk1RUWVIcjYwWlVVWjY2TE1F?=
 =?utf-8?B?Vk0yVEUxYnQwY3JLVm16aVZnTXZSdVoxYjRySS91WUY2M1A4Q0E5SGFCNUhn?=
 =?utf-8?B?V0lzdjE2T2FZNmZ5a2x1M3JXb3Zwd2xRSmk5akdPQ3NoQWhSYXpTajg1MkZz?=
 =?utf-8?B?VUlkOEZQd3lvVlR4cUFTWjM1K0l0M0ZPRGFQb3k4UWc2UlBvZ0h5ZmozV3dN?=
 =?utf-8?B?YkppY1ErZHV6b0NHM2h2Y3NqQVNlSFBYTGtwbytGWWtMMmNjbTlwQUg5R1Qx?=
 =?utf-8?B?QnZmbitaK2ZNTmZXcEN0U1hkNWdkZ242YVFrZ2RhdFZqbVh3WFd0bVI3MUtl?=
 =?utf-8?B?cksxRWEwK25QcUhML2c4Q2lhbUM0a2hIcnFoRHc0QzVneE5hT0dzcXNtT3M3?=
 =?utf-8?B?MXplUExTNmRobmM2VnBvNUJxVEZLY0hMaGJUVWl0enJxTCtZSGx5cndsOUYv?=
 =?utf-8?B?ZmdPRXdWOWVNSmRVcDhmWStuYmZNd2xUNXJLRGZ6ZWI2ejNRN2dFSU5wL0ZI?=
 =?utf-8?B?T0N0Q2tCTmQ3dlNJZmd0WlVLdytBeVVzckFiRG9XWHNtNXpSTXYydUdwOG9D?=
 =?utf-8?B?S05va3dCenZQVnFDWDlUV2k4cXM0L3B6cXlWQkdUc2xQVEhBbkw4SnE1eG42?=
 =?utf-8?B?QXE2d0ZHMDRVamxkamlUSWlZQVdyRUtIelZWUXRZWlc4ams1NmduZTY3UEJE?=
 =?utf-8?B?Vmk4UU4wTCtNVWVWLzBPVllYUVNRU0VETmRCNGk4VzEvOHR3YWRMa3hya3JE?=
 =?utf-8?B?c3hHVEtSZUo4TDlTb1E2ekRDUTN5TXFEZ1ZVemxmS1RRQk1xZHRqSC9kWCtV?=
 =?utf-8?B?VmFMWHZST29hTTBMdmxSK1g2bUFLc0M5M05hYmErRklNY1FCWUR2UlYxVDF2?=
 =?utf-8?B?YW0yUk11dXBxN2FyUlFHd3owblQ1S3dpTEFGWkE3OXZYV01SakRFenZjNkRr?=
 =?utf-8?B?ZjRqMWszNG5KTUJEVmxkdEg0cjZLaUwvWWxITWRVMXVxN3pDYVdiZkpSZXBV?=
 =?utf-8?B?eWVUSjMyTTFvcUNIQm5qTVNRYnlRVkJLT283eHltY1dqMmZ5VXhEaTNZL2hq?=
 =?utf-8?B?T2JYV2V1SWEvL013RytLaWJiVXd2V0NmQVdXOGJSTFJubkRCS2tWR29KZGR4?=
 =?utf-8?B?Q1ZPZUFRMFdUaWEvaVhCT05UZitsNTRES2U4a1BQSWViRHRvdWVsK1VNTjRW?=
 =?utf-8?B?VHY3RDJnWGNhcVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a3be03-f6dc-4ba3-e94d-08d89698ba51
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 08:03:18.0649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eo+VOxmkOtdHdwsXcNdGbPw2Yb039vrOkMYbG4g1Cfiyte99B1MpcZKKRP8ZuzcX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2647
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_01:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012020048
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/1/20 9:05 PM, Yonghong Song wrote:
> 
> 
> On 12/1/20 6:00 PM, Andrii Nakryiko wrote:
>> On Mon, Nov 30, 2020 at 7:51 PM Yonghong Song <yhs@fb.com> wrote:
>>>
>>>
>>>
>>> On 11/30/20 9:22 AM, Yonghong Song wrote:
>>>>
>>>>
>>>> On 11/28/20 5:40 PM, Alexei Starovoitov wrote:
>>>>> On Fri, Nov 27, 2020 at 09:53:05PM -0800, Yonghong Song wrote:
>>>>>>
>>>>>>
>>>>>> On 11/27/20 9:57 AM, Brendan Jackman wrote:
>>>>>>> Status of the patches
>>>>>>> =====================
>>>>>>>
>>>>>>> Thanks for the reviews! Differences from v1->v2 [1]:
>>>>>>>
>>>>>>> * Fixed mistakes in the netronome driver
>>>>>>>
>>>>>>> * Addd sub, add, or, xor operations
>>>>>>>
>>>>>>> * The above led to some refactors to keep things readable. (Maybe I
>>>>>>>      should have just waited until I'd implemented these before 
>>>>>>> starting
>>>>>>>      the review...)
>>>>>>>
>>>>>>> * Replaced BPF_[CMP]SET | BPF_FETCH with just BPF_[CMP]XCHG, which
>>>>>>>      include the BPF_FETCH flag
>>>>>>>
>>>>>>> * Added a bit of documentation. Suggestions welcome for more places
>>>>>>>      to dump this info...
>>>>>>>
>>>>>>> The prog_test that's added depends on Clang/LLVM features added by
>>>>>>> Yonghong in
>>>>>>> https://reviews.llvm.org/D72184 
>>>>>>>
>>>>>>> This only includes a JIT implementation for x86_64 - I don't plan to
>>>>>>> implement JIT support myself for other architectures.
>>>>>>>
>>>>>>> Operations
>>>>>>> ==========
>>>>>>>
>>>>>>> This patchset adds atomic operations to the eBPF instruction set. 
>>>>>>> The
>>>>>>> use-case that motivated this work was a trivial and efficient way to
>>>>>>> generate globally-unique cookies in BPF progs, but I think it's
>>>>>>> obvious that these features are pretty widely applicable.  The
>>>>>>> instructions that are added here can be summarised with this list of
>>>>>>> kernel operations:
>>>>>>>
>>>>>>> * atomic[64]_[fetch_]add
>>>>>>> * atomic[64]_[fetch_]sub
>>>>>>> * atomic[64]_[fetch_]and
>>>>>>> * atomic[64]_[fetch_]or
>>>>>>
>>>>>> * atomic[64]_[fetch_]xor
>>>>>>
>>>>>>> * atomic[64]_xchg
>>>>>>> * atomic[64]_cmpxchg
>>>>>>
>>>>>> Thanks. Overall looks good to me but I did not check carefully
>>>>>> on jit part as I am not an expert in x64 assembly...
>>>>>>
>>>>>> This patch also introduced atomic[64]_{sub,and,or,xor}, similar to
>>>>>> xadd. I am not sure whether it is necessary. For one thing,
>>>>>> users can just use atomic[64]_fetch_{sub,and,or,xor} to ignore
>>>>>> return value and they will achieve the same result, right?
>>>>>>   From llvm side, there is no ready-to-use gcc builtin matching
>>>>>> atomic[64]_{sub,and,or,xor} which does not have return values.
>>>>>> If we go this route, we will need to invent additional bpf
>>>>>> specific builtins.
>>>>>
>>>>> I think bpf specific builtins are overkill.
>>>>> As you said the users can use atomic_fetch_xor() and ignore
>>>>> return value. I think llvm backend should be smart enough to use
>>>>> BPF_ATOMIC | BPF_XOR insn without BPF_FETCH bit in such case.
>>>>> But if it's too cumbersome to do at the moment we skip this
>>>>> optimization for now.
>>>>
>>>> We can initially all have BPF_FETCH bit as at that point we do not
>>>> have def-use chain. Later on we can add a
>>>> machine ssa IR phase and check whether the result of, say
>>>> atomic_fetch_or(), is used or not. If not, we can change the
>>>> instruction to atomic_or.
>>>
>>> Just implemented what we discussed above in llvm:
>>>     
>>> https://reviews.llvm.org/D72184 
>>> main change:
>>>     1. atomic_fetch_sub (and later atomic_sub) is gone. llvm will
>>>        transparently transforms it to negation followed by
>>>        atomic_fetch_add or atomic_add (xadd). Kernel can remove
>>>        atomic_fetch_sub/atomic_sub insns.
>>>     2. added new instructions for atomic_{and, or, xor}.
>>>     3. for gcc builtin e.g., __sync_fetch_and_or(), if return
>>>        value is used, atomic_fetch_or will be generated. Otherwise,
>>>        atomic_or will be generated.
>>
>> Great, this means that all existing valid uses of
>> __sync_fetch_and_add() will generate BPF_XADD instructions and will
>> work on old kernels, right?
> 
> That is correct.
> 
>>
>> If that's the case, do we still need cpu=v4? The new instructions are
>> *only* going to be generated if the user uses previously unsupported
>> __sync_fetch_xxx() intrinsics. So, in effect, the user consciously
>> opts into using new BPF instructions. cpu=v4 seems like an unnecessary
>> tautology then?
> 
> This is a very good question. Essentially this boils to when users can 
> use the new functionality including meaningful return value  of 
> __sync_fetch_and_add().
>    (1). user can write a small bpf program to test the feature. If user
>         gets a failed compilation (fatal error), it won't be supported.
>         Otherwise, it is supported.
>    (2). compiler provides some way to tell user it is safe to use, e.g.,
>         -mcpu=v4, or some clang macro suggested by Brendan earlier.
> 
> I guess since kernel already did a lot of feature discovery. Option (1)
> is probably fine.

Just pushed a new llvm version (https://reviews.llvm.org/D72184) which
removed -mcpu=v4. The new instructions will be generated by default
for 64bit type. For 32bit type, alu32 is required. Currently -mcpu=v3
already has alu32 as default and kernel supporting atomic insns should
have good alu32 support too. So I decided to have skip non-alu32 32bit
mode. But if people feel strongly to support non-alu32 32bit mode atomic
instructions, I can add them in llvm... The instruction encodings are
the same for alu32/non-alu32 32bit mode so the kernel will not be
impacted.
