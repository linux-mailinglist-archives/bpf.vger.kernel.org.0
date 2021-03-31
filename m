Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6671834F664
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 03:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhCaBsR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Mar 2021 21:48:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41174 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231743AbhCaBsL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Mar 2021 21:48:11 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12V1exv7005086;
        Tue, 30 Mar 2021 18:47:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=FMYx1G/kZ2EUqLNac1Kxc1uG6NZ9Comln0PNoCW8QYU=;
 b=Og3cQL/SpeVIFXbtI4MesylL/rgEt7K5n0FBAU3YvNrU/Mv11/MmYk7+3nTag9c5ET4E
 yw1jld0mCLgwjw2S+daOfC2uJIkO4yVG4r6w70KIhVjbX3FyYkJgP61K+Lx5m0Ny6TS2
 1bCr0bj0oLzbRDQSNq6QOo3ZDRWxnUIkfgE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37maamhjbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Mar 2021 18:47:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 30 Mar 2021 18:47:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUUzjsvCI10vniSmUJHhbAN55C/CB9mFRPKY3B4mkAq05qUw/FfHagEnFsD+cjBLoXWDGYbokp5N6UVvNSMSugwC2+CPAF93UTb4wtudEQPCim+uCDmnOCSLqFiHHwvdpX1LaRkRXEl8V5U2iQAR+SeWRZLidgt1Y/Cd2gjH/om6gNLpPC6fp7ioG5SpfzRktgc6ByhXILB00LBy2hHKCG4dzStv3TT/zg5bR/80wuEnM2MbY9EDEBc/pWEZLdN3D/+5pEEa01BRgVHH/DpptOpvkqyj9q7gMme4lT6g7QreSZXFkUwhW9B1dWwaOlNjQWTuNsYAtcESEX35b0i3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbjImdJB11So7XBDvTzpCbGe0wCJ/WyGaqz9aqPSJ3M=;
 b=nfHKuTBXJMZLM1Gv26l4UKrjbfCAvuvt8bSfBs3kel3RJ5THTHiKY369g+VBo8tExWsHHEIjsmC9DgHMveraFqqJMOYvNWFDjSiu3qyg9XGKQaC4aeLBSXOUBsLs00BITYLv5OtMd6A2HONu/6Z/Wl8OaPwoihtiX0pc2lydP8YAxb6Hz8NTEIndFP2WSf2n68T+Kh5wyj9+xI+LCfrPqH0eiM6d2FwoNeCMPPh7IXHp6eSKCYwhLVJa+F1v+U6IRdAp2PZ1nCPQ2r/+686fGqMhYYYRmDfQKi/La4O0meyIRfL0nSXKCY+Hj3ZGJfxUVxJPQ0BOL1Jw8VMFn7ntUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB4093.namprd15.prod.outlook.com (2603:10b6:805:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 31 Mar
 2021 01:47:55 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 01:47:55 +0000
Subject: Re: [PATCH kbuild] kbuild: add -grecord-gcc-switches to clang build
To:     Fangrui Song <maskray@google.com>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        <arnaldo.melo@gmail.com>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kbuild@vger.kernel.org>,
        <masahiroy@kernel.org>, <michal.lkml@markovi.net>,
        <clang-built-linux@googlegroups.com>, <sedat.dilek@gmail.com>,
        <morbo@google.com>
References: <20210328064121.2062927-1-yhs@fb.com>
 <20210329225235.1845295-1-ndesaulniers@google.com>
 <0b8d17be-e015-83c3-88d8-7c218cd01536@fb.com>
 <20210331002507.xv4sxe27dqirmxih@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <79f231f2-2d14-0900-332e-cba42f770d9e@fb.com>
Date:   Tue, 30 Mar 2021 18:47:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <20210331002507.xv4sxe27dqirmxih@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:d5a5]
X-ClientProxiedBy: MWHPR1601CA0011.namprd16.prod.outlook.com
 (2603:10b6:300:da::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1120] (2620:10d:c090:400::5:d5a5) by MWHPR1601CA0011.namprd16.prod.outlook.com (2603:10b6:300:da::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Wed, 31 Mar 2021 01:47:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9c42df0-dfb6-487c-0b00-08d8f3e700fd
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4093:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB4093B7109AAE80D9B125E720D37C9@SN6PR1501MB4093.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5CAAnDsuyVptgN+K3l7QdPnETHGonofwxxmM5WFNb//w9BwxmfPrj2Jw5eiepWB3Jfz7iv7egnTb7+MEhPyuIuQ37m8p//m50W9jPMGRECB27VpBMU/0Dq+UFsjAZrIJHzpjmV9GuNlphMtyZWkIxw846k97uJ+j63T4Zhk0DieWcWfpOzLzbs14xPccBSM6bj3GlBKUV6g53aQHD6l0H6W0HhKWJeNrmFopIsJDLPfU5vKDYEabqz18wVR55q47v7HEh2S+KT4yApj5waul2aWgvZuAZxCyFWM2v7/2borsnkrRxy40YSYqSpuwUfZ2QzNx0+dATib1V9WD/EofABXQFkZWxaW4P0kTi7w9YfwHGjvHMQA58w2LtrP5Uoc2MoKl5IB7qdh6m3YEvxnaGnJw1jlUnp+VUFm0PmqGel4T9QpLR/iSDu5io/I4O7BkP8+/MaGZYw9Is7CstdfHdvknZYVF6bzhhH0s9SuyP+q7Z9e/B96F8tJXimmH9KPTAfm4c7ZoNB6cJMpMafgtBL/SLMTsDhI4m1ItnkIRisb9kLNLCk4KPNtJghrqE2vnnJwQWa9e+6OV83qnyxqg0WnzwohAXTLk/K8bqiqYct9Ny67UfdzvcvI6DpymclakFu+wVS9PF0zfvgRZYs/NALq7ooHUIYB7OJRL7vNgRemx530eNLjXMVhbdFAN3V+BRvOfpfEiuNv/qix0yC7V1kOiFOTDMqkC+KB+jwovVAjjyFel8MeZn3uFp+oG9QyFEMYk6PDYrntdS267WDnLPL2Fvy+yQyWTUC6ACgr51EA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(39860400002)(396003)(366004)(6666004)(6916009)(6486002)(52116002)(5660300002)(31686004)(36756003)(38100700001)(4326008)(83380400001)(66476007)(16526019)(186003)(31696002)(2616005)(966005)(7416002)(66946007)(66556008)(86362001)(478600001)(8676002)(316002)(8936002)(53546011)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bW1GbEtLZTJzYTNoMm5vV1JvcFNRS0dUNG9uZzhlNXh2TGY3enIzY2Uvdk82?=
 =?utf-8?B?WTVRMzJvUjFMZVpwOEZJcDRsNDhlUk1xcG13Z0NMTDNKMERaTWVjUjZPTjBt?=
 =?utf-8?B?OGh4UWJvbFZLYSs1d3pNQkJEank0R3dTUTdMK0UyVzVKTjhnU1R3Z3MwemU1?=
 =?utf-8?B?UFNpNlRuVTllZUU5SnNBNUhRK1dhQ3drYU80dFdRZXNBUjRQSi9CL2N5eXNt?=
 =?utf-8?B?cDVRdDRJZ3psZnFJeVRsa2Z6N3U0cVpSaVZFWm93d1ZMbWFBQXlGSlRaTk9L?=
 =?utf-8?B?di9ZQmV0OUNqSjZXN1ZMbWJ6VGh3YkxyTnNFa1VsejlDbWhoNEwwRHE4dDhE?=
 =?utf-8?B?QkpQNXBlTGRJak5iL0dWYXQ2UHhzM0JtR2ZwZVdJb0VkZlY0T3JRZGlMckJ4?=
 =?utf-8?B?eTIzc2N4MHJoZTFQNmtjY3dtaWhoQVFEV0dsbG54L0o2c0ZLbzNSOTQvUXdN?=
 =?utf-8?B?MndSMmtQNm1NYkFLOTB5SzJFUEk5amhZcDBaclBLMVIvYWJRSkdieTBVNVRB?=
 =?utf-8?B?MGwyL3plOFhrQk1DeGFkUGlzMmtoY1luOE1teG1DcXdLZW9sM3dIRmRFSzlK?=
 =?utf-8?B?b1htNzQrT1A4WWx4QWs2TEw1aEFtVU1BWHFpc1dTTTczaEtvSmhhejF3UzFQ?=
 =?utf-8?B?cTlITU1QNmE4V0IzQ2h6eEI5WEFMNVVLRHVudE5oL2JrcXBsQXM4Ykp6U2FS?=
 =?utf-8?B?U0tQM2xzMVUzQVVFMDNYaW55Sityd3ZqVDZPQitVcU1WZjNpMVQyendhMy80?=
 =?utf-8?B?SjlXR0FtMkhvMm5QcE1lcXhWKzNraEp2OEJVRDFmNjRyaE9MRHJERnFBSzFQ?=
 =?utf-8?B?aEUxOWdXZWRFbzdRNlFPNVdJOWlmakJYRDVMWTlRUEw5TUxBKys2NTI3T0ZZ?=
 =?utf-8?B?NUtrb3V5L1kvVmVhNG50NnZ0S0Nld2kxVm8yemtzZWt6TFpQUFg5dk9penZv?=
 =?utf-8?B?LzRTVTlnOU10TGRLMEdUQ0QvL0tSTFBVK2hVK0VrN0xtTENsZWNwKzd3TmJC?=
 =?utf-8?B?L1RSejAzQUp2N1daT0l0d3BaWXRMZzdhZ042RzJQYzB6VFMvR3hxZHo2VWgr?=
 =?utf-8?B?bHhzWFY1TVFGOVpkMnd4Tk90cmFnS0JYaE5BZEpFUTRGK2ZOaUZGTzZkMFNm?=
 =?utf-8?B?NjhDdGN1c1hPNTFpTm9LRzJpWkxOTitmMWlvcllXcGdOY0xSVjR2YU9xU1R3?=
 =?utf-8?B?ZkhlS3dLTm1XZ0xvUjg2VUNCOC9SQWxSWDR0ZG5GbEM3U1V1SS9oTlU1Z240?=
 =?utf-8?B?SUdqWDliNXZRdjNncXB5aDB1dU9zM2ZidmhIdEZ1SzNISU1Cc1FqVXFZaVJD?=
 =?utf-8?B?TXJjZDIxS1NmcUFpOU1QR3d4MVdMZGlSamRIRmU0TmplQnlCS0doOXByWUNY?=
 =?utf-8?B?SHFTd0FML2tvbkppTWFEbklOVzhjTDR2NXB2RnBONGRGakpsR1N2dDJEcURx?=
 =?utf-8?B?aHRaTStWb3hXaGRabC9wNzhMSTR5alV4WWpMbWcxYmFTbE9pVjVUQ1JYVjBY?=
 =?utf-8?B?RXZFTytSb1dydEFaSmR5dEMzMnBRT1pIWVJJTjdURGZEMEtTL0NTeC9rdWw4?=
 =?utf-8?B?ZXVaSjgrQXI1cktHSE5oMWg0RVRPa3hSc3hrMUdWSE05dDlhRDVKZU1nNUs3?=
 =?utf-8?B?MHVzcXJWNFI2WEw2dllDMWR3cER0SU5HdmlsZXZLWVZqSGhKK3Z4ZWczQmRD?=
 =?utf-8?B?SHFESjlYMzVESTQzQVJqTVZSMEl4dEpZbW9jaW5INEd0bGdnTmd4a1o0VFN1?=
 =?utf-8?B?bWt3S2Q4OG5FM2ZlNHlzNk1pdXI2M20yRWZLYVNNdU9VNkZmNks1RUR1NTZp?=
 =?utf-8?Q?StUoSudSAoN4XrDstuSJcl5nHzzaxPG2/xj7s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c42df0-dfb6-487c-0b00-08d8f3e700fd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 01:47:55.4122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkWPZVVFRu3MNkiT5FXrNoIga4mMg6cf4DNFMsf1ve5sScdMHL8lmSo+d/1WBjTF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4093
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: uv4JAirh73WN_V-hQjI8ngPmV9NdL6cz
X-Proofpoint-GUID: uv4JAirh73WN_V-hQjI8ngPmV9NdL6cz
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_13:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=856 mlxscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310010
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/30/21 5:25 PM, Fangrui Song wrote:
> On 2021-03-30, 'Yonghong Song' via Clang Built Linux wrote:
>>
>>
>> On 3/29/21 3:52 PM, Nick Desaulniers wrote:
>>> (replying to 
>>> https://lore.kernel.org/bpf/20210328064121.2062927-1-yhs@fb.com/)
>>>
>>> Thanks for the patch!
>>>
>>>> +# gcc emits compilation flags in dwarf DW_AT_producer by default
>>>> +# while clang needs explicit flag. Add this flag explicitly.
>>>> +ifdef CONFIG_CC_IS_CLANG
>>>> +DEBUG_CFLAGS    += -grecord-gcc-switches
>>>> +endif
>>>> +
> 
> Yes, gcc defaults to -grecord-gcc-switches. Clang doesn't.

Could you know why? dwarf size concern?

> 
>>> This adds ~5MB/1% to vmlinux of an x86_64 defconfig built with clang. 
>>> Do we
>>> want to add additional guards for CONFIG_DEBUG_INFO_BTF, so that we 
>>> don't have
>>> to pay that cost if that config is not set?
>>
>> Since this patch is mostly motivated to detect whether the kernel is
>> built with clang lto or not. Let me add the flag only if lto is
>> enabled. My measurement shows 0.5% increase to thinlto-vmlinux.
>> The smaller percentage is due to larger .debug_info section
>> (almost double) for thinlto vs. no lto.
>>
>> ifdef CONFIG_LTO_CLANG
>> DEBUG_CFLAGS   += -grecord-gcc-switches
>> endif
>>
>> This will make pahole with any clang built kernels, lto or non-lto.
> 
> I share the same concern about sizes. Can't pahole know it is clang LTO
> via other means? If pahole just needs to know the one-bit information
> (clang LTO vs not), having every compile option seems unnecessary....

This is v2 of the patch
   https://lore.kernel.org/bpf/20210331001623.2778934-1-yhs@fb.com/
The flag will be guarded with CONFIG_LTO_CLANG.

As mentioned in commit message of v2, the alternative is
to go through every cu to find out whether DW_FORM_ref_addr is used
or not. In other words, check every possible cross-cu references
to find whether cross-cu reference actually happens or not. This
is quite heavy for pahole...

What we really want to know is whether cross-cu reference happens
or not? If there is an easy way to get it, that will be great.

> 
>> If the maintainer wants further restriction with CONFIG_DEBUG_INFO_BTF,
>> I can do that in another revision.
>>
>> -- 
>> You received this message because you are subscribed to the Google 
>> Groups "Clang Built Linux" group.
>> To unsubscribe from this group and stop receiving emails from it, send 
>> an email to clang-built-linux+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit 
>> https://groups.google.com/d/msgid/clang-built-linux/0b8d17be-e015-83c3-88d8-7c218cd01536@fb.com 
>> .
