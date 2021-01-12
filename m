Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8EA2F2531
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 02:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbhALA6v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 19:58:51 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45660 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729918AbhALA6u (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 Jan 2021 19:58:50 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10C0rbVW020892;
        Mon, 11 Jan 2021 16:57:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=RebCOYrShCa5KjEN04sY7dgqjKhUWnbj/gKkMFodSwQ=;
 b=h3s+qjxfq4DH9OfFAnRzjuqdCpi9sNk3hyzu8BIZG72DoKBBAYWfsXUXvFY3B+sJk09T
 wVdRpl669ErW118w+JXPHFtdL3/RpCE70oLmKsyCW32dFaVfpZ5flH4i6oTMqMW8og02
 cpcrPmUbB6e9QCfAKI7dB9SQLZXuQ9FqEHE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35ywp97ynd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 11 Jan 2021 16:57:54 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 11 Jan 2021 16:57:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUg55eO6BezxV1hmAhfHpZHjxJOPuCD1gmsGQX/4sXsdI4sALvKuPqFxHCB305P14GLwpVecQe1Ioc/FMKXGhJmTSsThiG+pM3My9pgggP4gPOCkYeg0mRSO1ckH5JMNFa3mRD5lBK9/IM1omquM7GViyIrc6FQoN3cGpO9BrMybUC5qXG2Kyk/7q9smVM+0XRg21Nr+jhc1uHO8Bva951P+OHDDFL1qMkUyAK0L+/7z4ZVRSzBvyDUDq1I41XEo5sSXtwDnwLZmNKmnwYxppo0wh1npgkfCQYA6IbOMUP72qic99AGBDMsC6hvHr/xJdPjnYT6kYlgyTUUIEW+qDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nz19FXml8BqBVlgMKzkG2XgjgQF5k5y1uUJsaUD5ZmU=;
 b=cz7orbkP0lpLzegM/gtoR5B2od2ubJtKEnI+P6xYXqRipaZNWf2XJCT6Wy6LTyrBNMHYPqlIrV+lpDTkoJjTzd5xON4bZ/gWvXBOrUY9wCfMny8wY0A4jJUuMdeC/nj6MgDW4rVCTGcL0m7uzq5kr67o9LfydgBSNnU28mrjtokL0p2YhriKVgQqDC0ke0458yKiZyS4HR7Zbwe6EE3OF5eIldAIfijC2YRF5MNbH9YOGPcc0NuDznSUTXc+sc43xk0yWf/OhxGWrIIqzozZgtMh9BLLQKaXGfQ+geYZWE7lVpsMSDPhLBr8IOAK9RyiK6/lssh5oocK10nfnVbowQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nz19FXml8BqBVlgMKzkG2XgjgQF5k5y1uUJsaUD5ZmU=;
 b=YN1HupkA3rv11IzFTTpDw2XEQ6jPJh8e7dUWhXLNSo8SH7TqkZ2SShs0Dez27V0aEs5N6hNIuKmiYGHXRkcm9OvTodWnOw8MQzOTUmwZVHzTxPknHODnqwuOPKUKXo+aeS3jmT9554n1IAGlF1sk/4eiEf3uL8wt0NjfuvnTaEc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB3716.namprd15.prod.outlook.com (2603:10b6:a03:1b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Tue, 12 Jan
 2021 00:57:51 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 00:57:51 +0000
Subject: Re: Check pahole availibity and BPF support of toolchain before
 starting a Linux kernel build
To:     <sedat.dilek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Tom Stellard <tstellar@redhat.com>
References: <CA+icZUVuk5PVY4_HoCoY2ymd27UjuDi6kcAmFb_3=dqkvOA_Qw@mail.gmail.com>
 <fa019010-9d7c-206c-d2c6-0893381f5913@fb.com>
 <CA+icZUVm6ZZveqVoS83SVXe1nqkqZVRjLO+SK1_nXHKkgh4yPQ@mail.gmail.com>
 <CAEf4BzaEA5aWeCCvHp7ASo9TdfotcBtqNGexirEynHDSo7ufgg@mail.gmail.com>
 <CA+icZUVrF_LCVhELbNLA7=FzEZK4=jk3QLD9XT2w5bQNo=nnOA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <cb37bffa-b2c7-4395-40eb-2d39f5570214@fb.com>
Date:   Mon, 11 Jan 2021 16:57:47 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
In-Reply-To: <CA+icZUVrF_LCVhELbNLA7=FzEZK4=jk3QLD9XT2w5bQNo=nnOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:7b7c]
X-ClientProxiedBy: MW4PR04CA0180.namprd04.prod.outlook.com
 (2603:10b6:303:85::35) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::190b] (2620:10d:c090:400::5:7b7c) by MW4PR04CA0180.namprd04.prod.outlook.com (2603:10b6:303:85::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Tue, 12 Jan 2021 00:57:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 174feca5-cfa0-4107-ee21-08d8b695167c
X-MS-TrafficTypeDiagnostic: BY5PR15MB3716:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB3716A62926A9BA6B742D3C33D3AA0@BY5PR15MB3716.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MDXGgxWst84wUNjsClDzD/wbPbQYuWwKAcTtDRFuav62+nAymYMB+uQ9bvg9kQWJ6VBQbrJ6b8OuXpHQzZIs+rVV0KXSH49NtWdDtTsl9GqxGk+Ivo7FDBWCXRUw6dZdNbpDpcVr+3q3a8VaE5UztJRa1+HxTwn2TxU47cEF1ypLrHvqmcZPegmtQR7kLu1FFFrdhNFHn/3EIjlaekDjgisy5awST74HcFaS378bubFYWvZiTs9sUl49jvIACh3R+QgJ/vJlKUtR2Xg+PrLBCypplx8k6zWhrQA7bycXyIk+ge9WlpGdQCvLqjTwt2u6E5pZx1rpjISOCmFq8xepypfkAoUC+3kYeKo/Mniz9IvW0G767nzuRmyB1Adtk/J/UNE7OGuSvXSR2fFQ1B2Tc0NxRts244sbtxNi2E55J9P7aspdJbJ9fyrn6ucTsphZVGRwxjHhGU2ghjNNesqgP/HlstND51groF8SUTjAh7KcehS1QWKXo3YKF4//5A2IOiPffJo3xCX1dZnUm4/LE/DAoQKNPL1of5eiawimPoeq9KGN3PkauhwHbC3rZVfH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(39860400002)(346002)(396003)(366004)(8676002)(52116002)(478600001)(2906002)(966005)(86362001)(8936002)(53546011)(2616005)(4326008)(31696002)(16526019)(316002)(66946007)(186003)(31686004)(66556008)(36756003)(66476007)(5660300002)(6486002)(83380400001)(7416002)(6916009)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?andrY21iSTIzWHE2dUJ5TDhIekdxTEtGZEY1NTRPRmdYS1BGeDRoZStwVG9p?=
 =?utf-8?B?aUxRNU1YRnV6QjhaTG5HUHUxYnhTL21TRzB2SVBBdlRhNVFLUEJZalp5a0NG?=
 =?utf-8?B?T2hxNkErKzlrNjA4R296S0E3S1p0d0hkTGRQdDcwakxYVlRyZGpEdWIvR1hr?=
 =?utf-8?B?a0lGMHM5S2l4c1M3MHd0MDRhZ3gzWHhld0NxMmMrbUFSVlJSSmlZWmNiWkNq?=
 =?utf-8?B?bXZJMUZKK1BsMFkxWFkyZTNydXI5bHFxYW0rVTlYb2VodHZYT1JGK1M2em1X?=
 =?utf-8?B?eG9GNVZzaGFBSVQ2bTJQNGtkem9CbXYrNnhCYzBXR2VubFFIRkhrZlhQTWpW?=
 =?utf-8?B?VkY0LytZelZORzlzbWhUM3N3TlRNWTlLVXpid1hsbDFJRmI5VUR2ekhkdWNV?=
 =?utf-8?B?RE9EZEpYaCtMRHN5UWJNRVpCV1prby8xM0YrRVNIeVBHZjcwejNSdWdlK0FD?=
 =?utf-8?B?UHNJTEZzSVM4QnMxakZ1VG1QY1JxbXB0WjJCd1Jtd1RwZms3aFFybTY0ZVdp?=
 =?utf-8?B?L25nMjhXWVZ3T2N6UHAzTEY2a3B2a010T2dLYmdpTXBkVER0OVJTTzcwK3Mx?=
 =?utf-8?B?K0FIcjFjWFdWUjd5bDFqL1BjTDQ5VmVTNGJxd09kTHBLamtBTmtZS0t2enZR?=
 =?utf-8?B?OXNZeXRPQ2xlMDRzaE9zMXZVdmhYdG1wVm81VW56QkE2YnFZS1ZrTmJvNElo?=
 =?utf-8?B?dkZlN0RjclhWUVNCbmNNUkdTYWt1Wi9CT2ptdFdCMW8vWXJUT3VrNjhsYzFa?=
 =?utf-8?B?ZjF2UEw1ZHFRaWVOVW5PQ09DZHNNTWh2WEplT3J2SXZEYmRVZGxYbDZwSThk?=
 =?utf-8?B?YWttQ2l6eFpsaTV1NHprNkFZTHBKa0xOeDJPb1I5cDczSVFYRE5yM3VSWmE5?=
 =?utf-8?B?ZVlyZ1hOY28wUGY5UTA4WklVZTgwTWYyZ24zNTZONi9WVTU3UGR6MFVCelNS?=
 =?utf-8?B?K0VuNDlTT3o1Y0haYUxyWm1VeG1mUHJTcWFqSTFXR25aUWtURHY3bDJrM3hq?=
 =?utf-8?B?aXQ1bElGUWpOSFJ5cFZVSld6WEdNZTB6TWNaNDdQa3dvVXdocy8xaUhlQ29p?=
 =?utf-8?B?S1cvZExvWlN5YUYzSkJXTzdYUFhxSWZ1SEJLSkE0b2lYN2JZcmNtbkZBbktr?=
 =?utf-8?B?RnRzNzNuRHF3NWFJMko3S20zK2hoUmhHZnVybC9vMnRmeU5oMWlRcnJsMU56?=
 =?utf-8?B?Rk0yOVNCa2NPSTRGdk10TjlJWVA0aHJ6Nm0yUEYxa04weFRIZE53YXFyQlov?=
 =?utf-8?B?aVhOb1hsWDlyK21GOXBURTdLb0dIZEh5N2p2dHpnVXVJeEdqZDFFSm0xUlNG?=
 =?utf-8?B?QmR0MnBBYXd0WHdjNFN5S2o5aytJUG9lK1F2YzJZcitPbDJWSTFWY3dsbGZD?=
 =?utf-8?B?TUNYMi9tTHZUUmc9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2021 00:57:51.5724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 174feca5-cfa0-4107-ee21-08d8b695167c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rti96YQf3/LwTe2ls1gmdZWh0Hu3QvFrOShtChFJjhoHW0WVzBfrHUT1z3+pb3EI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3716
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 3 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-11_34:2021-01-11,2021-01-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/11/21 1:30 PM, Sedat Dilek wrote:
> On Mon, Jan 11, 2021 at 10:03 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Mon, Jan 11, 2021 at 9:56 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>
>>> On Mon, Jan 11, 2021 at 5:05 PM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>>
>>>>
>>>> On 1/11/21 4:48 AM, Sedat Dilek wrote:
>>>>> Hi BPF maintainers and Mashiro,
>>>>>
>>>>> Debian started to use CONFIG_DEBUG_INFO_BTF=y.
>>>>>
>>>>> My kernel-build fails like this:
>>>>>
>>>>> + info BTFIDS vmlinux
>>>>> + [  != silent_ ]
>>>>> + printf   %-7s %s\n BTFIDS vmlinux
>>>>>    BTFIDS  vmlinux
>>>>> + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
>>>>> FAILED: load BTF from vmlinux: Invalid argument
>>>>>
>>>>> The root cause is my selfmade LLVM toolchain has no BPF support.
>>>>
>>>> linux build should depend on LLVM toolchain unless you use LLVM to build
>>>> kernel.
>>>>
>>>>>
>>>>> $ which llc
>>>>> /home/dileks/src/llvm-toolchain/install/bin/llc
>>>>>
>>>>> $ llc --version
>>>>> LLVM (http://llvm.org/  ):
>>>>>    LLVM version 11.0.1
>>>>>    Optimized build.
>>>>>    Default target: x86_64-unknown-linux-gnu
>>>>>    Host CPU: sandybridge
>>>>>
>>>>>    Registered Targets:
>>>>>      x86    - 32-bit X86: Pentium-Pro and above
>>>>>      x86-64 - 64-bit X86: EM64T and AMD64
>>>>>
>>>>> Debian's llc-11 shows me BPF support is built-in.
>>>>>
>>>>> I see the breakag approx. 3 hours after the start of my kernel-build -
>>>>> in the stage "vmlinux".
>>>>> After 2 faulures in my build (2x 3 hours of build-time) I have still
>>>>> no finished Linux v5.11-rc3 kernel.
>>>>> This is a bit frustrating.
>>>>
>>>> You mean "BTFIDS  vmlinux" takes more than 3 hours here?
>>>> Maybe a bug in resolve_btfids due to somehow different ELF format
>>>> resolve_btfids need to handle?
>>>>
>>>
>>> [ CC Tom ]
>>>
>>> OMG no.
>>>
>>> 3 hours up to running scripts/link-vmlinux.sh.
>>>
>>> In the meantime I have built a LLVM toolchain with BPF support.
>>>
>>> $ llc --version
>>> LLVM (http://llvm.org/ ):
>>>   LLVM version 11.0.1
>>>   Optimized build.
>>>   Default target: x86_64-unknown-linux-gnu
>>>   Host CPU: sandybridge
>>>
>>>   Registered Targets:
>>>     bpf    - BPF (host endian)
>>>     bpfeb  - BPF (big endian)
>>>     bpfel  - BPF (little endian)
>>
>> As Yonghong mentioned, you don't need BPF target support in Clang to
>> build the kernel, so the issue is elsewhere. It's somewhere between
>> generated DWARF (we've seen multiple bugs in DWARF over time),
>> pahole's BTF output and resolve_btfids's handling of that BTF. I've
>> CC'ed Jiri, who can help with resolve_btfids.
>>
>> Meanwhile, if you can provide SHA from which you built Clang, kernel
>> config you used, and probably exact invocation of the build you used,
>> it would help reproduce the issue.
>>
> 
> OK, I see I have here DWARF v5 support patchset applied and enabled.
> 
> Furthermore: I applied latest clang-cfi.
> 
> This is with LLVM v11.0.1 final aka 43ff75f2c3feef64f9d73328230d34dac8832a91.

Did you use llvm to compile kernel? If this is the case, latest pahole 
will segfault. I am using latest trunk llvm. It is possible that 
generated dwarf with llvm is different from generated dwarf with gcc
and pahole did not process it correctly. I did not get time to
debug this though.

> 
> My kernel-config is attached.
> 
> [1] https://patchwork.kernel.org/project/linux-kbuild/patch/20201204011129.2493105-1-ndesaulniers@google.com/
> [2] https://patchwork.kernel.org/project/linux-kbuild/patch/20201204011129.2493105-2-ndesaulniers@google.com/
> [3] https://github.com/samitolvanen/linux/commits/clang-cfi
> 
>>>     x86    - 32-bit X86: Pentium-43ff75f2c3feef64f9d73328230d34dac8832a91
> Pro and above
>>>     x86-64 - 64-bit X86: EM64T and AMD64
>>>
>>> Tom reported BTF issues with pahole v1.19 (see [2] and [3]):
>>> "I ran into this same bug trying to build the Fedora kBROKEN_5-11-rc3-CONFIG_DEBUG_INFO_BTF-y-FAILED-load-BTF-from-vmlinux.txt
> ernel. The
>>> problem is that pahole segfaults at: scripts/link-vmlinux.sh:131. This
>>> looks to me like a bug in pahole."
>>>
>>> pahole ToT (post v1.19) offers some BTF fixes - I have manually build
>>> and use it.
>>>
>>> Building a new Linux-kernel...
>>>
>>> - Sedat -
>>>
>>> [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
>>> [2] https://github.com/ClangBuiltLinux/tc-build/issues/129#issuecomment-758026878
>>> [3] https://github.com/ClangBuiltLinux/tc-build/issues/129#issuecomment-758056553
>>
>> There are no significant bug fixes between pahole 1.19 and master that
>> would solve this problem, so let's try to repro this.
>>
> 
> You are right pahole fom latest Git does not solve the issue.
> 
> + info BTFIDS vmlinux
> + [  != silent_ ]
> + printf   %-7s %s\n BTFIDS vmlinux
>   BTFIDS  vmlinux
> + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> FAILED: load BTF from vmlinux: Invalid argument
> 
> - Sedat -
> 
>>>
>>>
>>>
>>>>>
>>>>> What about doing pre-checks - means before doing a single line of
>>>>> compilation - to check for:
>>>>> 1. Required binaries
>>>>> 2. Required support of whatever feature in compiler, linker, toolchain etc.
>>>>>
>>>>> Recently, I fell over depmod binary not found in my PATH - in one of
>>>>> the last steps (modfinal) of the kernel build.
>>>>>
>>>>> Any ideas to improve the situation?
>>>>> ( ...and please no RTFM, see links below. )
>>>>>
>>>>> Thanks.
>>>>>
>>>>> Regards,
>>>>> - Sedat -
>>>>>
>>>>>
>>>>> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/link-vmlinux.sh#n144
>>>>> [1] https://salsa.debian.org/kernel-team/linux/-/commit/929891281c61ce4403ddd869664c949692644a2f
>>>>> [2] https://www.kernel.org/doc/html/latest/bpf/bpf_devel_QA.html?highlight=pahole#llvm
>>>>> [3] https://www.kernel.org/doc/html/latest/bpf/btf.html?highlight=pahole#btf-generation
>>>>>
