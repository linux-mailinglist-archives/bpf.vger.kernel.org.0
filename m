Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DD2372E00
	for <lists+bpf@lfdr.de>; Tue,  4 May 2021 18:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhEDQ0x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 May 2021 12:26:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33782 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231523AbhEDQ0w (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 May 2021 12:26:52 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 144GE13V006981;
        Tue, 4 May 2021 09:25:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ujC99JH3dPaOw2WkqTA18svEnpSB6xMu0Vf1u4BXBSU=;
 b=jmrnrYTPtbsq57IgIn68gLme/pTinRvDwSpnIEaMfxKNBuVHBCk+igcnIg878aM2lRpa
 /ZgjRl2ijHlh1x5zf0fRpr4AmZV/RZ0t9isRjP9Ujf4yPoJJgcqlSg7nXOodY3o7wlqY
 byTGvLncjFRBC0jxj7ElyXMo6XLn52cWHno= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38b85w0wmc-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 04 May 2021 09:25:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 4 May 2021 09:24:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dO4wyP/FcnVgNLK+B37SJitiiPve48wAEAh8RZmNBfLkI4bdTa2sG439ThKNn0UjkM64mwyAcOwgRpYsiZ+JMTpZf/uPa3A9CreAJ7MirPgGCbIAaR4IwvyLhvy6KfIKQ1Up0Fhv9535p4WAtgFTise57zXCpNSjYeXGk7kkhAnfLHJ1aqOIPiaPzlVWFrmtsxay510Hawu352XGml2WLMHiJfGVFs+0xqjj5sQc5FzV+xAOVn+TczCvtc1jqEGQvKBSzHQ8nmZRGB2WQJPaDY4uBcPBvTkam0i5TGVKDwXdISWWfIo4kpkmovH4xMcnfUjn8zXSOcO5Q6+3zHWI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujC99JH3dPaOw2WkqTA18svEnpSB6xMu0Vf1u4BXBSU=;
 b=k4CS7VKr76RQSZyEdIKBYbDLFYWe8AofL6vESjsNzkjpqwpq5IhRZ3kBPYMbxivtqAGcQb7Y0E5pgrXmZUB6PZQ8NYfUiz/E6JUl9ihCRv7nUeg4SCn+hEffNYZvfriRG16rk4jSyb4gAoTtU7E8z9CZ0N1CPJNUxGVsH4IZ9whvYeAAlYBw9uBTDcfwIf4BJt/axTkU7+dLgdWTH55V2jWi3yJWV2YhOSfNXdpvZ51E8wHGt2/alygXc088DIlffbjN250NqrV5ZcPkKRLXWAZIKy8GmSKLX/wfArmiIpO5c+UTKNsPfMwcpayV3kAxbbNMgT1WkobOWfREV0TlyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4497.namprd15.prod.outlook.com (2603:10b6:806:198::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Tue, 4 May
 2021 16:24:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 16:24:57 +0000
Subject: Re: Typical way to handle missing macros in vmlinux.h
To:     Grant Seltzer Richman <grantseltzer@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>
References: <CAO658oV9AAcMMbVhjkoq5PtpvbVf41Cd_TBLCORTcf3trtwHfw@mail.gmail.com>
 <CAEf4Bzayxgt3P+kz36t6C8jp-MUTuwuKvwHWWsd2qrCs3-RHXA@mail.gmail.com>
 <CAO658oUpqOHmSAif+6zor1XTruDqHeTzAQHrCXOSPRo6oTp5vg@mail.gmail.com>
 <CAEf4BzYfn0SonnH=R-kA8eeYD5yBrAFQTsEMDtuOX=MaadTJsA@mail.gmail.com>
 <CAO658oWY3QK0A3U=NeDzXJRPsydCFWCrx1kdAfSdtq9CpNj0ow@mail.gmail.com>
 <CAEf4BzbRTuYQtzSScqCkM8dLfLLDzRs2BPKrHbrx3=joFr5YPw@mail.gmail.com>
 <CAO658oX7_b18Q4OxZ_PxAPhBjQPXv4+dQsQzH1-TWKhozikWiA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <294a5f06-19dd-d649-a000-c40f1fdbd299@fb.com>
Date:   Tue, 4 May 2021 09:24:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <CAO658oX7_b18Q4OxZ_PxAPhBjQPXv4+dQsQzH1-TWKhozikWiA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:2d57]
X-ClientProxiedBy: MW4PR04CA0168.namprd04.prod.outlook.com
 (2603:10b6:303:85::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::132d] (2620:10d:c090:400::5:2d57) by MW4PR04CA0168.namprd04.prod.outlook.com (2603:10b6:303:85::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Tue, 4 May 2021 16:24:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c886d7b1-e324-4d8e-4a09-08d90f192860
X-MS-TrafficTypeDiagnostic: SA1PR15MB4497:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4497C170600681C425534C30D35A9@SA1PR15MB4497.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sGPAbf6fhOdvOSXdhBAxZkrymhi7cJqwcCcAN2HaxGBIEGCMG2gFjhx615FP/P/H36B5mpcBdxcmTqaLUHCm02iinFagBwKjbZKKxg4+KL+x21HKjgxcPxFnFNny/eUvc6qjGx8w6+BT211GMmIFAaBPF5kfqAtYAf9WwLNnFCW6BciXQW8o+QSRRS8xE8ebpFU2iaHZmOK9S5xU5jhsvwRXbwnexIz5vZPFs4YiR4Pdex73R9gIauQeXdfyLkfJwljknbOa+muOpe0f0Vg6/FBBuuWW4Hor4fnCtrrXR9aTXAO0bJwuXxnolTTz1SVZ0eTc6mFdXFphs31YwAfEPkC5ngdUKkaK8JmCUTX6cNYOEsfcCpIuFjy1f0bt1zRdN3Y6BAMda0XBUYKY5Qq3e+IU6BlRZMW3zyELddhn+An2EZ/dnQbTUg9Cp+Qw5Pcy551LFqtW+fXk5zJYW855oFSECR3Fh5oal7fKXwgZYQ3mwFtkaYDaCEEkfGjJQmo8GfyKRkpUpk5xWRXgvXucE5RJy3tjxnBuXBB3IF2JO8Qx5Gs1nsrs2cuoYBD4ji6FA9zQtse+51uz9Fc0U3PAlvozsoemXwGEKlE7B20Vrgf7a4vllYFcpjG+E5WxXTyTpRQh3jiZml1JYQAD7uCaCz6I6nD2RpkDKdmtMjoMn5DQ02lrBwRvXhtCg3yiAxeQVM5Xhfk/MDcNG4WeaPJPLJmMpbJ8BTvc1ZnosSlATKNatALK6KDuScZMaAJ9PHIJz/LxJgfrU5TCxtCVYBMF7HGCLOecdCtZf1eXtjrRPuI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(83380400001)(966005)(6486002)(2906002)(8936002)(31686004)(4326008)(66556008)(31696002)(8676002)(66946007)(36756003)(6666004)(478600001)(316002)(5660300002)(53546011)(186003)(16526019)(52116002)(110136005)(86362001)(2616005)(66476007)(38100700002)(43043002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NVd0NVRxMzZXdm5UdDV3RHltbHlTTUg3TkNHMHM2eXVTb0t4K0JIR29Kd1Z4?=
 =?utf-8?B?YjM2ZVBKcHJ0VDJvVWlZNENmL00yNERiOEwwekVmNERvMVlZUFAzdFJwNXBv?=
 =?utf-8?B?TG5RUVRtZVpBTFdHdVVJN3IyWGVmSUg3cndvS1hCT1FSZkhoaHNxekVYejhr?=
 =?utf-8?B?WVI0VENzMmRramx3TXhwaktDTTEwb2o1RENqbTNpc2crNlFsRGZ1ai9HUnJx?=
 =?utf-8?B?MzM0LzY3OGZIdlJrUXBwSk5JbEVhbnlPQ2N1RTk1dW9MRHJSNjlDSVdWTW81?=
 =?utf-8?B?c3J1Ny82UDJQYlhyYVdvS042T0JTVUlJMnZnSWFhRU5QVDBBdiszMk1JbC9E?=
 =?utf-8?B?ekVqZWZZanZUSnRLdkcvTkNESXpaa0xtcDJpUlNwM2pKa3V3d0tTME5sS2VV?=
 =?utf-8?B?THVTanMvMmgrRFdaVEo4WnowVWtCZVR3S2YvM1VLZFF0RXV3ejFvejZqcklE?=
 =?utf-8?B?eS9XVHdNZ3JjWGpvS0hyRnpFUmRGSkdna2x6aEJrREkwM3YzVlI2N2NQTDli?=
 =?utf-8?B?eU51WC9GV3FJY2pPR2FoOWpHdE1lREdoK2pDdTlYVnFqUnhTbkM0MnFHMkx3?=
 =?utf-8?B?cmpsd29VNXc5ZDBpMTB0RmI1RlJSNitpcFhhVkxPd2tocUhNSmwxL0ZFVEto?=
 =?utf-8?B?bXlEUmxDSXNUTjh2bExTenFvVzF0eW5kNm5QSWpBckVtM0lodStNK1l2ak53?=
 =?utf-8?B?b21yOTJUUXplNXFtOU1pNS9Ddng2anhWR3RWYTg2NnBkQXdIYWp3UXp4QTlm?=
 =?utf-8?B?NWVaSHJ0ejUzQ1dCZ0NtYStJVHJpUFY5T2kxWDFBdlZsWEVNS29FV1NTVDFP?=
 =?utf-8?B?UEpvR0hsZlU3dWdKdzhkcUxjSEFvZkk2V0dqcjRiY3pCQjUyY2MwY2w1cGZs?=
 =?utf-8?B?WlAxdmhkRlluaG9URU5EbHpFOTRGRXp0eDJCV05PN2U1VUlTZFBKN1MxQ2Vz?=
 =?utf-8?B?a2N0aEhIT09VamgxRUFGV0UvNUtJWEZ4YXpCeStUNXBsMmp3d0NidlVmVjVt?=
 =?utf-8?B?NFJVN2htek5MaWNLbmppMDM0LzZ0cHdNT1ZZb1Exa1JHYjM3UXE3TUZRTXVF?=
 =?utf-8?B?bWlXUmxaK2svdnlRdUx4L3dNdFpGSW8vbEdwRCttT01jSldMWjJXRVZyWDM2?=
 =?utf-8?B?b0VxVThwN1F3cXF6QW5iVnR3Z09VaEFDN2JrVHNETnpZclBEOVhDS0VuMWJr?=
 =?utf-8?B?VW5ZMzVHaVRTaUZEMHMvSHNMUHFaSHdoZHhicDNrd3NEbmFNWHAzQWY0NTRl?=
 =?utf-8?B?Y0pXL3BqT3pzVFBmR1BGRFlha3dNOUF0TmhCcThnV3MyMCt3Q1JGUUJVVktl?=
 =?utf-8?B?M1NZTGhuS0JNRDZ0VkViVkN0WnJxOENkRk5MNFBkbzVDWUJjazNLeEt6Y0tX?=
 =?utf-8?B?aHFIekNhQ2FBdENVRXhPbnR4VDdXeGMvc2N1UGt5MUhLZGc4L1Ixb0lpMnpW?=
 =?utf-8?B?dDZzaWIvNFFGMmJPaXkxZlo1SkV5Z3BUanN1VnVMS2JycWl0N0lwRFRHT0hl?=
 =?utf-8?B?aEl3VVdRMDhPNkZxd0VPdnlCNVRPQ2tURFlUeVRybVU0Nm5aWVRFUkJzV2ty?=
 =?utf-8?B?RFNINWJGQWVVOE5OeWx6UjQvdy8xRGVVUnYzWHErWUdnNFNGaXQ3ZXlJV3F2?=
 =?utf-8?B?YjI2WjlEYnRaTmRyd1I5RUdSYkFGUzU1eTRCRjhXUlFyeVkzU3pZU3BIZnNO?=
 =?utf-8?B?R2dXblA1NjVtNCthYkNkWU5wZTNpck1EUUMyYkV6K2RjbU4rRmdCazdoUldu?=
 =?utf-8?B?ZUxVVkszQWlvc2YzL2wxWU5scXd3RjVvck9vblVOblNZbCtHbmdZam9nWjJD?=
 =?utf-8?Q?5pvHElEp8Ssx5GLtbTlNqrtETbPguR2bVcsW0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c886d7b1-e324-4d8e-4a09-08d90f192860
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 16:24:57.6943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHKtO11g3GTHmDN6RLqLBD7TJdmLbU9e1dWzLM9Ut65dcPLrSwQ9YVPjk+aI/Mdr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4497
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 1kO4R20-QkXn4YHvfalUM1eQh_stexJ2
X-Proofpoint-ORIG-GUID: 1kO4R20-QkXn4YHvfalUM1eQh_stexJ2
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-04_09:2021-05-04,2021-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2105040115
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/4/21 8:31 AM, Grant Seltzer Richman wrote:
> On Mon, May 3, 2021 at 5:22 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Mon, May 3, 2021 at 1:20 PM Grant Seltzer Richman
>> <grantseltzer@gmail.com> wrote:
>>>
>>> On Mon, May 3, 2021 at 2:43 PM Andrii Nakryiko
>>> <andrii.nakryiko@gmail.com> wrote:
>>>>
>>>> On Mon, May 3, 2021 at 11:32 AM Grant Seltzer Richman
>>>> <grantseltzer@gmail.com> wrote:
>>>>>
>>>>> On Wed, Apr 28, 2021 at 5:15 PM Andrii Nakryiko
>>>>> <andrii.nakryiko@gmail.com> wrote:
>>>>>>
>>>>>> On Wed, Apr 28, 2021 at 1:53 PM Grant Seltzer Richman
>>>>>> <grantseltzer@gmail.com> wrote:
>>>>>>>
>>>>>>> Hi all,
>>>>>>>
>>>>>>> I'm working on enabling CO:RE in a project I work on, tracee, and am
>>>>>>> running into the dilemma of missing macros that we previously were
>>>>>>> able to import from their various header files. I understand that
>>>>>>> macros don't make their way into BTF and therefore the generated
>>>>>>> vmlinux.h won't have them. However I can't import the various header
>>>>>>> files because of multiple-definition issues.
>>>>>>
>>>>>> Sadly, copy/pasting has been the only way so far.
>>>>>>
>>>>>>>
>>>>>>> Do people typically redefine each of these macros for their project?
>>>>>>> If so is there anything I should be careful of, such as architectural
>>>>>>> differences. Does anyone have creative ideas, even if not developed
>>>>>>> fully yet that I can possibly contribute to libbpf?
>>>>>>
>>>>>> We've discussed adding Clang built-in to detect if a specific type is
>>>>>> already defined and doing something like this in vmlinux.h:
>>>>>>
>>>>>> #if !__builtin_is_type_defined(struct task_struct)
>>>>>> struct task_struct {
>>>>>>       ...
>>>>>> }
>>>>>> #endif
>>>>>>
>>>>>> And just do that for every struct, union, typedef. That would allow
>>>>>> vmlinux.h to co-exist (somewhat) with other types.
>>>>>>
>>>>>> Another alternative is to not use vmlinux.h and use just linux
>>>>>> headers, but mark necessary types with
>>>>>> __attribute__((preserve_access_index)) to make them CO-RE relocatable.
>>>>>> You can add that to existing types with the same pragma that vmlinux.h
>>>>>> uses.
>>>>>
>>>>> I'm attempting to try doing the above. I'm just replacing
>>>>> bpf_probe_read with bpf_core_read and not importing vmlinux.h, just
>>>>> all the kernel headers I need.
>>>>
>>>> Yes, that will work, bpf_core_read() uses preserve_access_index
>>>> built-in to achieve the same effect.
>>>>
>>>>>
>>>>> When you say "Add that to existing types with the same pragma that
>>>>> vmlinux.h uses", Should I be able to add the following to my bpf
>>>>> source file before importing my headers?
>>>>>
>>>>> ifndef BPF_NO_PRESERVE_ACCESS_INDEX
>>>>> #pragma clang attribute push (__attribute__((preserve_access_index)),
>>>>> apply_to = record)
>>>>> #endif
>>>>>
>>>>> and then pop the attribute at the bottom of the file, or after the
>>>>> header includes.
>>>>
>>>> Yeah, that's the idea and that's what vmlinux.h does for all its
>>>> structs. It doesn't add __attribute__((preserve_access_index)) after
>>>> each struct/union. So I wonder why you are getting those unknown
>>>> attribute errors. Can you paste an example?
>>>
>>> Here's a couple examples of the warnings:
>>>
>>> ```
>>> tracee/tracee.bpf.c:5:46: warning: unknown attribute
>>> 'preserve_access_index' ignored [-Wunknown-attributes]
>>> #pragma clang attribute push (__attribute__((preserve_access_index)),
>>> apply_to = record)
>>>                                               ^
>>> /lib/modules/5.10.21-200.fc33.x86_64/source/include/linux/ipv6.h:185:1:
>>> note: when applied to this declaration
>>> struct ipv6_fl_socklist;
>>> ^
>>> tracee/tracee.bpf.c:5:46: warning: unknown attribute
>>> 'preserve_access_index' ignored [-Wunknown-attributes]
>>> #pragma clang attribute push (__attribute__((preserve_access_index)),
>>> apply_to = record)
>>>                                               ^
>>> /lib/modules/5.10.21-200.fc33.x86_64/source/include/linux/ipv6.h:187:1:
>>> note: when applied to this declaration
>>> struct inet6_cork {
>>> ```
>>>
>>> after these warnings are emitted (it seems as if there's one for every
>>> data type, though I can't confirm), I get errors that look like this:
>>>
>>> ```
>>> tracee/tracee.bpf.c:445:22: error: nested
>>> builtin_preserve_access_index() not supported
>>>      return READ_KERN(READ_KERN(task->thread_pid)->numbers[level].nr);
>>>                       ^
>>> tracee/tracee.bpf.c:206:27: note: expanded from macro 'READ_KERN'
>>>                            bpf_core_read(&_val, sizeof(_val), &ptr); \
>>> ```
>>> I believe this is just a result of the warnings above, but if you're
>>> curious it's what i'm doing here:
>>> https://github.com/aquasecurity/tracee/blob/core-experiment/tracee-ebpf/tracee/tracee.bpf.c#L204-L208
>>>
>>
>> Looking at your Makefile, you are not using `clang -target bpf` to
>> compile BPF object files, which is probably what causes you trouble.
>> preserve_access_index is a BPF target-only attribute. There is no need
>> to do the legacy clang -emit-llvm | llc, especially when you are using
>> CO-RE.
> 
> Got it. Funny enough, it turns out this is just a continuation of a
> conversation you had with my coworker Yaniv last year:
> https://lore.kernel.org/bpf/CAEf4BzbshRMCX1T1ooAtYGYuUGefbbo2=ProkMg5iOtUKh3YtQ@mail.gmail.com/
> 
> But to summarize our continued challenge: Adding the
> `preserve_access_index` attribute, compiling with `-target bpf`, and
> using the same kernel headers we used (not vmlinux.h) causes issues
> because of architecture specific asm errors (likely stemming from
> headers we include). Unless there's a way to get around those we're
> going to need to include "vmlinux.h", change our Makefile to `-target
> bpf`, and redefine macros and/or functions that vmlinux.h does not
> provide.
> 
> I think this is a pretty significant usability challenge. The idea you
> mentioned of having a built-in to detect if a type is defined would be
> a huge step forward. Has any progress been made towards this?

I briefly looked at this probably one and half years ago.
It will involve tweak clang frontend cpp side. Now I haven't
done any concrete work yet. But will look at it in the future.

> 
> Another thought is having vmlinux.h include function definitions,
> aren't they included in DWARF/BTF?
> 
> Thanks for your help, as always, Andrii!
> 
>>
>>>>
>>>> Also check that you use Clang that supports preserve_access_index, of course.
>>>
>>> I'm using clang 11.0 on Fedora 33. All dependencies appear properly
>>> installed (libelf, zlib, dwarves [provides pahole], llvm, llc,
>>> llvm-devel,...)
>>>
>>>>
>>>>>
>>>>> I've tried this and get a whole bunch of 'unknown attribute' warnings,
>>>>> leading me to believe that I either have something installed
>>>>> incorrectly or don't understand how to use clang attributes. Do I need
>>>>> to edit the types in the actual header files?
>>>>
>>>> No, the whole idea is to not touch original headers.
>>>
>>> Got it - that's good to know.
>>>
>>>>
>>>>>
>>>>> Thank you very very much for the help!
>>>>> - Grant
>>>>>>
>>>>>>>
>>>>>>> Thanks so much,
>>>>>>> Grant Seltzer
