Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C9735C875
	for <lists+bpf@lfdr.de>; Mon, 12 Apr 2021 16:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239061AbhDLOQM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 10:16:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9192 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237579AbhDLOQM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 12 Apr 2021 10:16:12 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CE96XQ023012;
        Mon, 12 Apr 2021 07:15:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=6claswn8j6lA+OyTeNiL6m+E+IJ2hn2McF8k7cBqAaM=;
 b=FJc1vOxoFbplRzM9eXzGJ8wwmCjTsMAHnXcpGys5AkHj/DQ8tnEGrSinF2yDTjs1J7KK
 hfTdQoFuUEtNDUUjbnk8KNElH9M/ZRyGLkjS+zANdhkIKqcG0NxWWXVKYtyqRIHDPoge
 TVpk+Nw5PvB2inSmrkWAkzWgucUs9pL7JKE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37uurwnd4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Apr 2021 07:15:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Apr 2021 07:15:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHB+dX4hYDoQvH2TSANUSE9DwtY215PaMpuXuDsFxwyrhIw6LvYDnuE7NZmpq8Im7KMFiuAZKwgVj0rRs5WbmJ80Z6HTDLDFG9rwwzk6DE7/iRSxnEVa3ZcYJ0YU2ufgu/j5l4V8wiDCM1hx86oyU295uhNymEDQ5i/lFGL6h0gmLdJ0YZtEtR/igtjh7/Z79or0O00HQDn2aRNx+vxE/P0wKWr1iz2ztByW0WoCkRG3MUTSMhL1hk0ro9u7P1DF8qV0x3D0ArSy7WCkpvYjqrPy2OkedKwsL8og0JIbAXmaaDcOGjIzTT9FiVip2rauztwHQ9yFZG7c0hTVnwenbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6claswn8j6lA+OyTeNiL6m+E+IJ2hn2McF8k7cBqAaM=;
 b=Uup2hZ/uPTVdV4bGhjIXUAqVeAuktVZ15IxkiljfJXtVpGtoPHvYxQHf/fHefjvsTxjfm7Ren88Ifioz524lWz0bRm/Z1YFjmyOxEDBvrvwXfmAwhFfgHcOwFN62gvOufV/k3FJZ5ZbcODQB2nILhDWncXkCbvjnR1nlFVLSVYu0likXNzFmctOiov/4O0M7sSpvDgVqEGufY9mpqf8IlJo68vCKM8+WoeRhKzlpU9pv8e2jCKsjJERmECy0MdZr1WwG9pgxG1AeoKfjtxpZ4JVin9rvvo+k7ZgbMnm9m5C0gpCCkmgKB38o2wcehMsVyP2POs0g+ZCRByVXJBxGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3967.namprd15.prod.outlook.com (2603:10b6:806:8c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Mon, 12 Apr
 2021 14:15:49 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Mon, 12 Apr 2021
 14:15:49 +0000
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: fix test_cpp compilation
 failure with clang
To:     <sedat.dilek@gmail.com>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>
References: <20210410164925.768741-1-yhs@fb.com>
 <20210410164940.770304-1-yhs@fb.com>
 <CA+icZUXzCpHWk8Vm5D4ZcCbdd9gqipVD5ALCw6SGTFbYfdJZiA@mail.gmail.com>
 <7c82c0f5-2a96-7a5c-b090-f26c9351786c@fb.com>
 <CA+icZUWwSg4Nd+AzAMx8Os4iAfs=40zeoYn0eVKg3Cy7fB5Cow@mail.gmail.com>
 <3f224f2c-bb7e-accc-b095-7fee8210861b@fb.com>
 <CA+icZUVPQT9WNona7xdmZP+2nS=xLn6hssd1wmLSeVNBzsOqTQ@mail.gmail.com>
 <1184be32-46d6-15a8-06b6-7e9bd26a88c6@fb.com>
 <CA+icZUWYNFpL+ueU3i2+1N=C1s51BgRv0D1kusfhzZsYscMTUA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <1b52c9f6-cf2e-f7f4-3ce6-e7acd449884e@fb.com>
Date:   Mon, 12 Apr 2021 07:15:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <CA+icZUWYNFpL+ueU3i2+1N=C1s51BgRv0D1kusfhzZsYscMTUA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:42e2]
X-ClientProxiedBy: MW4PR04CA0201.namprd04.prod.outlook.com
 (2603:10b6:303:86::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::110f] (2620:10d:c090:400::5:42e2) by MW4PR04CA0201.namprd04.prod.outlook.com (2603:10b6:303:86::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Mon, 12 Apr 2021 14:15:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6595c806-2383-42c6-cb4f-08d8fdbd78d3
X-MS-TrafficTypeDiagnostic: SA0PR15MB3967:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3967BAEE6AD1235DDC0D07CAD3709@SA0PR15MB3967.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TXMfbGV1D1p5AtHDTRBANrFm/zVj3sic8vWEBQJxZlFDstR2mYKQgqMmCZXXS54CRelA51M4m+FoZOCX8Noh9YxuOWXCI1r1AUEOYAhlQ3OVmgwtPR0CxE6PwWmLY/1+XjZ5c4gr8TJYLJBkELhP/3V8/SzRqytZrApCXok+rQTYEXzstFV8GZ/PpeNFmi+os4VHciNNejVmpAwn9bqqaWs/xuxLrIEz4gF9msOxGEcHftNMRXXv/S9LhZ1Au6YYE35/5MOfTbh00cK3kGt4LC1WoC8AxNLymGlctybpZ9WLapRzwbGu4WInnOH3bT1oVGUynHa/e2VHTVROtKr3S9ntRd6XV9KujmQA+MhqqGmQdzrz8kFdd/nVrwZt8EiMK8RwcWpIM98pRITf6dPjrksqzJkGXMLaTqcyogr4H+iyi92cPaklMCbGbgQcvGyDf3Nc8A+yfJr2H8fmMjHSH98Wqay+RDuNqlJczY+TYVIRVgIrRU+ptSdCpsnxZp1WmJQkWxTek39X6Pz1OJNuhOOJLgqKZQ35J/WbQdTRk4RUR7xHmsignuW/G0VoAyBQa4BL/1hObYSeTc3jwoCqgwbkym6mDpiPKAeW9PEBCs2N0bJ8dz78OigPzw9Fi1LpbKrrodwSpRNbI+WgyknpFfwwOhhqPHzLjlmj211Iwncdn/LS0f5i3j8ykIiT+IkYSmD2tY/ABIqTuYwNq3E8lQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(376002)(396003)(38100700002)(54906003)(36756003)(6486002)(316002)(83380400001)(66946007)(66476007)(6666004)(31696002)(66556008)(4326008)(478600001)(2616005)(8676002)(5660300002)(53546011)(86362001)(186003)(31686004)(16526019)(6916009)(52116002)(8936002)(2906002)(458404002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U054QUJhQjhiYS9vU2w4bmd4VXdQdTMralQxeGlxSTZ2WGkwNU5BT0ZJZC9z?=
 =?utf-8?B?cGZscWc3czVsWFZ5S2pEOWJCZGdFUHE0VXlMdFpCSTNaeGd3M2h0aFpXL0N4?=
 =?utf-8?B?UzV0SWR0aFY3N0FRQWQyalFMZHp1TFNQd2RzL1lCOStRWUl1akErdTRLR2Rw?=
 =?utf-8?B?b1VKRmRMeEJVMTZSSkMxNC9kTy9NMWx2Ky9lbDh2VXlrcCtrVS94Y0U5encw?=
 =?utf-8?B?Y2FjUVphY052QVFaYVEyRFQ0RzluUW9IVjg3WFdKRkJtUjVnTTVYMnd5RXNP?=
 =?utf-8?B?Z2VIendJU3dmM1ZNTkhsaDhtbnEwby9xVlFlLzlJaXV1SDVINGxXajZFVXZ2?=
 =?utf-8?B?UDJQQ3o2NzM5OVgrWUxzbE5wRzJxVUlnZUxNd2ZNcGVLNW02OGpFbmpIR2RE?=
 =?utf-8?B?VUdBbTJreUh4VHNhb29DS3VkYVRzRDZwR0xvR3RyTkszbVRJazV3SElSS3RL?=
 =?utf-8?B?dTNXbTZuYU1seG9CWXMxKzZhOVVzQ1UxYzUwUVhiQ1RWdG9sN3B5RW9oQ2JI?=
 =?utf-8?B?YU5FNkN1TzdIN0lBNHZ6RGNvS3pIRW5WM0tmNExGcHd0TEd2QWRNWUNaTzVa?=
 =?utf-8?B?L05mVURBdC8ydllzclhhRjN4WUtiN0Y3K2dPTHJyVzRtK3R4VzM5Q3U0WENq?=
 =?utf-8?B?QkdzOXArQ04yK2U1dERSNWRmczN2WWFTQUxqeDlmTVRzM1d5NHBZRTZ1Zi96?=
 =?utf-8?B?RnhLZTlXRW5OQ1ovcnlqemMvOEhlOExhWFpkaHI2Wm9uQ2EyUDdNMFNVK2dX?=
 =?utf-8?B?eXEwdElMN3d4YnVDUFM4Q01OY0xwdE9QTEp3dXNyR2VSaWk2M0EvWmVOMnpp?=
 =?utf-8?B?aVhmMU1kRDIxSHc3RkJwQ1FQUmdONXhEWnRGeko3ckR2UVdBYnhHZXZFKzdv?=
 =?utf-8?B?SU1Cd0VYREdUeGNOeExIcm9VUmtQYWV4MS9QNFRabGhUbWF5VlhFNHpxNUpU?=
 =?utf-8?B?NW9nV2tVS3N3YS9pbGNpMXZWYlEralZzM1MrSTVHcXJlSUJJTHpXcWhjZHM3?=
 =?utf-8?B?MnhPZWtYYU4rYWFCRDZFQXgweDA1Nm9MUC9VT0NldVc5bzNCcTdJQ0hPUzlN?=
 =?utf-8?B?MURoQ3dVc1BaWkxtY1gvT1ZiRW0yYng2ZndmVHk0VG8zd29vYldHNTVydWNY?=
 =?utf-8?B?dDE1QThnZHF0REV5R2JaUTRXa1YzZU9nQzc5ZWVXWXI3TjBFMjI3YU5TdFR4?=
 =?utf-8?B?QlplV3F6d3RRcEtkbmh4elMzUGZTakRTeExVNWtjZmdJaE5jWDE1bE9PUDFs?=
 =?utf-8?B?SjNVT2pjSkZoZzVKRytqeXdtN09lNDVVTTJjWEJYLytnejJlUHRSbVlOVGIy?=
 =?utf-8?B?Z0NGMlJoMHM4M1JCYWRnUndkakxTS2p4MXh5bWZ2ZDBFSkpKM0JrUXFMa1NG?=
 =?utf-8?B?QXJCMkpVL0l3ekwwR0U3MUhuSkNLRmp0WExTWWo2cHdRU0w4RFMrUWQwWWxY?=
 =?utf-8?B?Sm9mR29lUzRuemU3OHVNMWNZQWJVUGQwYWxoLzNWRlVQMTNDeGZYUFhhNDhh?=
 =?utf-8?B?ZzFqZHhQWFRraHhjalJjejJBOWg4TmJVNEpZaW0xUE5XYWQ2aHpnNDlxK2hP?=
 =?utf-8?B?RFBvdjA0OG5qOTc3TlRucnBpN3dDb1lzTWtNMy9ZbGlNQUtoZTJoRFdKNldS?=
 =?utf-8?B?M0FWZFZRdHdjRFRUWmZiN3RtNTIrbktxekc4QVdMN0cycjZMVWtCbWdZVUpC?=
 =?utf-8?B?VU5XYVBBU0Y0WkNmZFlZRG1rZUtOcElIWGxkck4rZ2FzVFJUN0JaUml6eitU?=
 =?utf-8?B?eGh6Ky9lMDRZRENXdGdmNkdlTk9BRWFEVEJIeVRYNVhkVkpzRStxT3crRXFM?=
 =?utf-8?Q?Z9g7QeAUNB8K0EyviKhJ+zIniI8SG3nF73SHA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6595c806-2383-42c6-cb4f-08d8fdbd78d3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 14:15:49.3366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARgRz4UTi+WwxHWGyTW7zRdO/jDjSgBbo5e6XC3spmxNy1I0xBRuxgPbst+ClQQr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3967
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: jfJIIwAIZdviDVwTXahtzI97IL3gf317
X-Proofpoint-GUID: jfJIIwAIZdviDVwTXahtzI97IL3gf317
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_10:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120097
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/11/21 11:06 PM, Sedat Dilek wrote:
> On Mon, Apr 12, 2021 at 7:42 AM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 4/11/21 9:47 PM, Sedat Dilek wrote:
>>> On Sun, Apr 11, 2021 at 9:08 PM Yonghong Song <yhs@fb.com> wrote:
>>> [ ... ]
>>>>> BTW, did you check (llvm-)objdump output?
>>>>>
>>>>> $ /opt/llvm-toolchain/bin/llvm-objdump-12 -Dr test_cpp | grep core_extern
>>>>
>>>> This is what I got with g++ compiled test_cpp:
>>>>
>>>> $ llvm-objdump -Dr test_cpp | grep core_extern
>>>>      406a80: e8 5b 01 00 00                callq   0x406be0
>>>> <_ZL25test_core_extern__destroyP16test_core_extern>
>>>>      406ab9: e8 22 01 00 00                callq   0x406be0
>>>> <_ZL25test_core_extern__destroyP16test_core_extern>
>>>> 0000000000406be0 <_ZL25test_core_extern__destroyP16test_core_extern>:
>>>>      406be3: 74 1a                         je      0x406bff
>>>> <_ZL25test_core_extern__destroyP16test_core_extern+0x1f>
>>>>      406bef: 74 05                         je      0x406bf6
>>>> <_ZL25test_core_extern__destroyP16test_core_extern+0x16>
>>>>
>>>
>>> What is the output when compiling with clang++ in your bpf-next environment?
>>
>> $ llvm-objdump -Dr test_cpp | grep core_extern
>> $
>>
>> So looks like all test_core_extern_*() functions are inlined.
>> This can be confirmed by looking at assembly code.
>> while for gcc, there is still the call to
>>     _ZL25test_core_extern__destroyP16test_core_extern
>> which is
>>     test_core_extern__destroy(test_core_extern*)
>>
>> This is just a difference between compiler optimizations
>> between gcc and clang. We don't need to worry about this.
>>
> 
> ( My previous comment was from my samrtphone - so I started into my desktop. )
> 
> Thanks for your analysis and hint about inlining.
> 
> My inbox is full with that different handling of inlining "GCC vs. LLVM/Clang".
> 
> When I recall correctly and I have not to care about the inlining
> optimization of clang++, then we can drop
> "$(OUTPUT)/test_core_extern.skel.h" from the BPF selftests Makefile:
> 
> [ tools/testing/selftests/bpf/Makefile ]
> 
> # Make sure we are able to include and link libbpf against c++.
> $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
> $(call msg,CXX,,$@)
> $(Q)$(CXX) $(CFLAGS) test_cpp.cpp $(BPFOBJ) $(LDLIBS) -o $@
> 
> Note: This is with your patchset applied against Linus Git
> 
> As we have the include here:
> 
> [ tools/testing/selftests/bpf/test_cpp.cpp ]
> 
> /* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> #include <iostream>
> #include <bpf/libbpf.h>
> #include <bpf/bpf.h>
> #include <bpf/btf.h>
> #include "test_core_extern.skel.h"
> ...
> 
> With and without keeping "test_core_extern.skel.h" I got the same
> output with g++ and llvm-objdump.
> Compiling with clang++ did not show that "CPP-file and C-header"
> build-error when dropping "test_core_extern.skel.h" from the Makefile.

Thanks for testing. Great to see all g++/clang++ compilations passed!

> 
> As said here all my testings with Linus Git not bpf-next.
> 
> Thanks for your precious time!
> 
> - Sedat -
> 
