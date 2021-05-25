Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB0138F8EE
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 05:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhEYDlj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 23:41:39 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46412 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230048AbhEYDli (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 May 2021 23:41:38 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14P3P01U005274;
        Mon, 24 May 2021 20:39:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=2dfzbDTUD9oRXHJwICxGY/0BW5RCAYA8iT+x9DjjOtM=;
 b=XILvwFXeC4UpndB7uJiB6cyJlZRKqd8kBn+n5Qbl45+ar6Pl7K0WVTgL0rKyurUhkiDa
 cXue0OX3sAh5KtawWQuHrBsNyfZgNZj5ARLWBI1X4V8ZudwgY8AehV7q0KS7pzIh3VfT
 fUIJM4t5orJQRYFUtwth0GPytQ9wkTiG/Qo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38ret9m454-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 24 May 2021 20:39:56 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 20:39:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLBY/Q2XJh28brF9VzQ7/bismFLWn/+iTofwQ2QiXBDENYpuyXHNhvz4Nq25buWBNtBwC3gc1DknLW+JebG3SjCj76ambWUrPsibPnCaJ3V6um9008DaGWlgDVJjj8d9M8NpTkKXNw7nB94LWD+0cv5Vh357YBpgjfLANOlZ2A+Ja4YDzKaM+7iecuo2DvfCjdjSXtQHQv3JeyuFWlOZcc1it9ac29bhKINixIJVZtkjcw5lQYgNQfr6ixcWSvEOqNTDn0Is+XwrFJZE/C3kB4OUZf70RqSCJYwmzXtCwZdafJZANXECQhPiN/Y/HfB0kjJanyn8j66q0pySq0r8fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84ufQ/+lsbODC0VaJoPnwJA398HAcaagN8BaOGqH59c=;
 b=D67N4vXXwIO5W+63ERObVnt0/hM2xDHyHaH3GxPkgVZ8OuaM7L6oB4XNHbbZshqKR/AfqRZyOZoWtpqqrI4le7l2U7nTpKF2SxkYvuAOyTcoCm1z0c7zdP3MFk40LhvXOeZouKovQ05Xcr1nyMqMsIYDjxwwihheMbfV9PyljsO/ylApkLfONGMByU2BHXOw45/LrT3FDfwgWajfTmR/sdB6Rt/qFPwEhpsCvTUFXsCRxhUtAdvI2CvevFW1DDwbFrgtr3GcnKJ1IULK1ksrvfv7yCJKepdORI+i2i3JoiW9Zd+ns5YyX26y/D3Gqy3X6RlYrS6lG3acfo09ToNzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4919.namprd15.prod.outlook.com (2603:10b6:806:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Tue, 25 May
 2021 03:39:53 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 03:39:53 +0000
Subject: Re: [PATCH bpf-next] docs/bpf: add llvm_reloc.rst to explain llvm bpf
 relocations
To:     John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Lorenz Bauer <lmb@cloudflare.com>
References: <20210522163925.3757287-1-yhs@fb.com>
 <CAEf4Bzb+gqH6aB72y+vCaHrq7HNNAROPV+2X0976CzCAmY8Jrw@mail.gmail.com>
 <22162d9d-7e89-53b2-015f-5e88a953c4dd@fb.com>
 <60abfd5d94d7_135f6208cd@john-XPS-13-9370.notmuch>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <c77ba8ee-d56c-0db6-4741-5527dc7053a7@fb.com>
Date:   Mon, 24 May 2021 20:39:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <60abfd5d94d7_135f6208cd@john-XPS-13-9370.notmuch>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:dece]
X-ClientProxiedBy: MW4PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:303:8d::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1d1d] (2620:10d:c090:400::5:dece) by MW4PR03CA0157.namprd03.prod.outlook.com (2603:10b6:303:8d::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26 via Frontend Transport; Tue, 25 May 2021 03:39:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f68f04d3-decb-4a21-d8b3-08d91f2ec1ed
X-MS-TrafficTypeDiagnostic: SA1PR15MB4919:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB49199D865EF6F59F83E2531FD3259@SA1PR15MB4919.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pji0IFc4u7tpnB7Z+X60B5NAW1q5Xp4aXhW4zo7/3khd+QSyiqxa4zhR33c8/nH7esQkomuDpXaRUF6TvhOuaGaDiZfflaJXbsCm17lSSXt/xwwUtLDhpbl78lCEr6yigqnCrXraAyo8qp3YEQS07lz76aoyKUQvVJaq2iPfr9BPi2aq6CIKtZ6OK7fz5j5WPYbMLu9izIOgTSHLXwfIKbQa4avKPAri8KZYt4OU21f1622i8eto7osnrfE3PKTt7c2Sjj/8p2/Ca4FUiHP+etNR2TPw1j9fj3ZDSXI0T8UKV8t6Xl5BXC8t/gQXMMVmxppbYPVVGSDDquGKaYXxT9bRhHi+5k+65QR/SYVflC1VS9zCYAcAT4YzwASxjs52fscqcKgAX1dXCYHYE9+XK3ioK7GXvOPfqMTB6fcCFFkoEYbkMrgJObRoiK+isBEGLkJZ809ZtgpP7mA+2mpaXjBDNLmjaMZAZn7Rk25vUv6PftEwAehCnyN2LlbTXYFz4ZApl6uTmOC0tssluqAe7zUnjE2cnWLfFtYPWhXC9Bi9bfpTe/W/PTNA/2HBBfOkDyV4uKh/kCHPQeQE+mZLM0Y12GrLlEYioNzJoZsRXIahKp8+uHtBiNiN3r1ae9UOCN4cHz085z6qj2qrMgRsG7NUBu2P5CyoCrXeM3aDyLGLU5IAK/RMUcuH1xVC77n48jAHk2VeCUB1l6p3+bs6XpuZujORC/9OA/hO9966NFPmn9nTZKzqGJbW+TDRVUs+ST84znkk2ijXHkBJBEsAOBpG6aqZnlWbJCY4jFYk57EjVCXYeezoCYDqwuJx1msi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(38100700002)(2616005)(36756003)(316002)(8676002)(31686004)(54906003)(6666004)(4326008)(5660300002)(2906002)(478600001)(19627235002)(966005)(6486002)(110136005)(8936002)(66556008)(53546011)(16526019)(66476007)(52116002)(86362001)(186003)(31696002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VllHU1F1SE4rZDVKZHhsM0V3SXdlQi9xUEh6R2tVZDFsYjVLVE03dzdoZmdq?=
 =?utf-8?B?dVJyVVRIeWhleWdiREY5YkUyMXZEN3ZLdkw4alVMRHNKbm55cFREQUtNRDNX?=
 =?utf-8?B?Qkh0UXA0TnFQYUk5VnVlNllVRzR1ZXZsTG1SRlpUQjNSM0ZvanM3K3BFS2Q3?=
 =?utf-8?B?Q0tlWHpFcHAzVjFvZ1huZzlGcUdscndiNGdrMFg2a2gvYnJlTE5vSTZ0RXZh?=
 =?utf-8?B?VHRSbUNDdWJjbTJLK2JqbjBHeDNnRXdIQ1NtYXBKWW02NVdhWUcyd0Z2b2c4?=
 =?utf-8?B?bEdVL0FJYm5kMThKQTAzNjVGbzdPaVRNaVZDMEFiMXBaZldadGoyWTRqRWh3?=
 =?utf-8?B?TENVWmM1aWsweWJZaFFRbVZMQXRmSzZ4TWRhYk93WkVaTmRPdVpmemhKZ3pQ?=
 =?utf-8?B?Lzc2cnRRKzZCQUhnVDJGYjdOZm8xemU4OVI1MFJ4TDlOV29USThOUG9TMVkv?=
 =?utf-8?B?MEp5SWZPOGNNOTFqMU0xUjh5RXJ3SWVLZlVSMjNvbTdWTDVZUVZlbkdQbkNG?=
 =?utf-8?B?RnhwbVF4WXRwdkdQWERicHdWVXhqMWFUZkFmeldPQllmQWFHRFFibmZTbE9H?=
 =?utf-8?B?QUlsMTdVUi85MHh4SURsWGI1RkRQeWtYSHdXdWNQWFI3K1NPSHpZZHZMbXk3?=
 =?utf-8?B?NDMwK0o0ZjQzRDdNODVVRXdrTlhKeE9mSWl0QXdxMXV0RWVhcXViU0NPUjZY?=
 =?utf-8?B?QjkweHYyNml3RHVLcUxnZlBpTnpuanJkb2lHdFk0UFpkMGs3UlROa0JrdnFB?=
 =?utf-8?B?UW56VnZtSjd0REpmV3NnUDl1c2lyRWpWeUNwcHkvNWcvOE9WWENVTXJ6L2lZ?=
 =?utf-8?B?MVBGa3J5UCtSNjdST2JvdXlyWlNkU3M3S3B0dlRjWTFKa1RIVDR3ZG9sZXF5?=
 =?utf-8?B?c0lFcG1JNzFWNlFVdnBuenIvckZ6Q055a2ZzMWNVb3hzM1FJUmRiVm0rUmhM?=
 =?utf-8?B?NGlGZkU0RjFZZ1VyWUZkOWR6Mng4aE5WQkdBZFpwQzdkNW9HUFl0dFpaUXU3?=
 =?utf-8?B?M2I3QkJEdmxZM2JZZlVoY3NINnB4M0FsY3V3Vmltcm5rQ2hpUXNzbDdnVkNM?=
 =?utf-8?B?OEdzQmpDRzFuZTZGTFMreWE3MmhOcjIrclMvWUxkSm5TYWphNkdGc3lvZnQy?=
 =?utf-8?B?RFVXR0RVbkhCVjRHd0xjdm9TRkhiRUdMYU5LTElqRldUbi9MMHVhUDhJNUVC?=
 =?utf-8?B?UjhIVVF0MDh0WHBsOWJ6K2tCWjZsaC9qcnZVZFBTSWxHOWVPTmU5bndHMmox?=
 =?utf-8?B?Q0lXM3RZVy9pc1hQaGQ5SStiUWtYWVJkbFcwWG5waUl1OTJwR3RWNVdlWUk4?=
 =?utf-8?B?SDhZYVRZTWppb0YxaU5uWUZ5UkVQM0pDSlZGU2pSR2hYOFpnQXlTdG1xSFFP?=
 =?utf-8?B?YUxvQWF5TTlzT3BlUkI1V0ZRYmZIeitBSEV5cFVpWFRoeWZwUkYrQnFxWEJZ?=
 =?utf-8?B?U2Uwd0J4WGRWS2pMTGdEVTNBdElJeE96MFA5UmNpNWlhUXJEZVVVM1ZFQjRn?=
 =?utf-8?B?Z0dkdW1GTFlZVW13bm9jb2d3V0pQa1BIN2psaFRtUUdvUjR1aDZVOVkxaXlW?=
 =?utf-8?B?RU5QUFpjSS82R3h5RTNPczZaZGRac2NZcXNHb1NLOXVoRXBtSDFaSlM2WnBk?=
 =?utf-8?B?dGdoQjFQbk9YNXdTMkl1b1A1bnJzOUx4K2JsQThLVUU2Sm9CVHF3YWdsVENZ?=
 =?utf-8?B?cUhnYkVnWGlhOEVEYVJEOTBJWko1WDY2c2VaaWhMSGRvSnMvVHVlNDIra0dU?=
 =?utf-8?B?NDhKVGtET1VEZ05xVnRiVkNqZmVJOVJ0UUJrYWlodUtuWHF3V3oyN2kyazdJ?=
 =?utf-8?B?Q3JaUjdaTVdxd1BscXpydz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f68f04d3-decb-4a21-d8b3-08d91f2ec1ed
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 03:39:53.3891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ov9uUjWUcCyLosphcAGhWfzq70/wOM6pcLrL0k2y9S8vc71oSBMcIqWIoDeS2OgA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4919
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: SumNG7XxEmCl-_3TAO5NDxGpx_fR4vj4
X-Proofpoint-GUID: SumNG7XxEmCl-_3TAO5NDxGpx_fR4vj4
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_02:2021-05-24,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250023
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/24/21 12:24 PM, John Fastabend wrote:
> Yonghong Song wrote:
>>
>>
>> On 5/24/21 10:23 AM, Andrii Nakryiko wrote:
>>> On Sat, May 22, 2021 at 9:39 AM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>> LLVM upstream commit https://reviews.llvm.org/D102712
>>>> made some changes to bpf relocations to make them
>>>> llvm linker lld friendly. The scope of
>>>> existing relocations R_BPF_64_{64,32} is narrowed
>>>> and new relocations R_BPF_64_{ABS32,ABS64,NODYLD32}
>>>> are introduced.
>>>>
>>>> Let us add some documentation about llvm bpf
>>>> relocations so people can understand how to resolve
>>>> them properly in their respective tools.
>>>>
>>>> Cc: John Fastabend <john.fastabend@gmail.com>
>>>> Cc: Lorenz Bauer <lmb@cloudflare.com>
>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>>> ---
>>>>    Documentation/bpf/index.rst      |   1 +
>>>>    Documentation/bpf/llvm_reloc.rst | 168 +++++++++++++++++++++++++++++++
>>>>    2 files changed, 169 insertions(+)
>>>>    create mode 100644 Documentation/bpf/llvm_reloc.rst
>>>>
>>>> diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
>>>> index a702f67dd45f..93e8cf12a6d4 100644
>>>> --- a/Documentation/bpf/index.rst
>>>> +++ b/Documentation/bpf/index.rst
>>>> @@ -84,6 +84,7 @@ Other
>>>>       :maxdepth: 1
>>>>
>>>>       ringbuf
>>>> +   llvm_reloc
>>>>
> 
> Thanks Yonghong, I found this helpful. I still had to crack
> open llvm code though to follow along. A couple small suggestions
> below, may or may not be useful. Overall looks good.
> 
>>>>    .. Links:
>>>>    .. _networking-filter: ../networking/filter.rst
>>>> diff --git a/Documentation/bpf/llvm_reloc.rst b/Documentation/bpf/llvm_reloc.rst
>>>> new file mode 100644
>>>> index 000000000000..bc62bce591b1
>>>> --- /dev/null
>>>> +++ b/Documentation/bpf/llvm_reloc.rst
>>>> @@ -0,0 +1,168 @@
>>>> +.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>>>> +
>>>> +====================
>>>> +BPF LLVM Relocations
>>>> +====================
>>>> +
>>>> +This document describes LLVM BPF backend relocation types.
>>>> +
>>>> +Relocation Record
>>>> +=================
>>>> +
>>>> +LLVM BPF backend records each relocation with the following 16-byte
>>>> +ELF structure::
>>>> +
>>>> +  typedef struct
>>>> +  {
>>>> +    Elf64_Addr    r_offset;  // Offset from the beginning of section.
>>>> +    Elf64_Xword   r_info;    // Relocation type and symbol index.
>>>> +  } Elf64_Rel;
>>>> +
>>>> +For static function/variable references, the symbol often refers to
>>>> +the section itself which has a value of 0. To identify actual static
>>>> +function/variable, its section offset or some computation result
>>>> +based on section offset is written to the original insn/data buffer,
>>>> +which is called ``IA`` (implicit addend) below.  For global
>>>> +function/variables, the symbol refers to actual global and the implicit
>>>> +addend is 0.
> 
> Above was too terse for me to follow without looking into some clang
> examples. Maybe an example right here would help not sure? Maybe expand
> the text a bit? I don't have a really good suggestion.

Just send a new revision with an example. Hope it will make it easy to
understand the above ``IA`` concept.

> 
>>>> +
>>>> +Different Relocation Types
>>>> +==========================
>>>> +
>>>> +Six relocation types are supported. The following is an overview and
>>>> +``S`` represents the value of the symbol in the symbol table::
>>>> +
>>>> +  Enum  ELF Reloc Type     Description      BitSize  Offset        Calculation
>>>> +  0     R_BPF_NONE         None
>>>> +  1     R_BPF_64_64        ld_imm64 insn    32       r_offset + 4  S + IA
>>>
>>> There are cases where we set all 64-bits of ld_imm64 (e.g., extern
>>> ksym, global variables). Or those will be a different relocation now
>>> (R_BPF_64_ABS64?). If not, I think BitSize 64 is more correct here.
>>
>> It is still R_BPF_64_64. In llvm, we have restriction that section
>> offset must be <= UINT32_MAX, and that is why only 32bit is used
>> to find the actual symbol in symbol table. 32bit permits 4GB section
>> which should enough in practice for a bpf program.
> 
> ^^^ maybe add this note in the doc somewhere? I had similar questions.

Added in the new revision.

> 
>>
>> libbpf or tools can write to full 64bits of imm values of ld_imm64 insn.
>>
>> The name is a little bit misleading, but it has become part of ABI
>> and lives in /usr/include/elf.h and we are not able to change it
>> any more.
>>
>>>
>>> Looking at LLVM diff I haven't found a test for global variables (at
>>> least I didn't realize it was there), so double-checking here (and it
>>> might be a good idea to have an explicit test for global variables?)
>>
>> We have llvm/test/CodeGen/BPF/reloc.ll and
>> llvm/test/CodeGen/BPF/reloc-btf.ll covering R_BPF_64_ABS64. But I think
>> I can enhance
>> llvm/test/CodeGen/BPF/reloc-2.ll to cover an explicit global variable case.
> 
> ^^^ maybe cross-reference llvm tests from kernel docs side? I often look at
> these when I get something unexpected/unknown maybe others would find
> it helpful, but not know where to look?

The llvm patch has not merged. We need to merge libbpf patch first. 
Otherwise, nightly libbpf CI will fail. But this doc includes a link
to the LLVM patch and you can just go to that llvm patch to find
examples!

> 
>>
>>>
>>>> +  2     R_BPF_64_ABS64     normal data      64       r_offset      S + IA
>>>> +  3     R_BPF_64_ABS32     normal data      32       r_offset      S + IA
>>>> +  4     R_BPF_64_NODYLD32  .BTF[.ext] data  32       r_offset      S + IA
>>>> +  10    R_BPF_64_32        call insn        32       r_offset + 4  (S + IA) / 8 - 1
>>>> +
>>>> +For example, ``R_BPF_64_64`` relocation type is used for ``ld_imm64`` instruction.
>>>> +The actual to-be-relocated data is stored at ``r_offset + 4`` and the read/write
>>>> +data bitsize is 32 (4 bytes). The relocation can be resolved with
>>>> +the symbol value plus implicit addend.
>>>> +
>>>> +In another case, ``R_BPF_64_ABS64`` relocation type is used for normal 64-bit data.
>>>> +The actual to-be-relocated data is stored at ``r_offset`` and the read/write data
>>>> +bitsize is 64 (8 bytes). The relocation can be resolved with
>>>> +the symbol value plus implicit addend.
>>>> +
>>>> +Both ``R_BPF_64_ABS32`` and ``R_BPF_64_NODYLD32`` types are for 32-bit data.
>>>> +But ``R_BPF_64_NODYLD32`` specifically refers to relocations in ``.BTF`` and
>>>> +``.BTF.ext`` sections. For cases like bcc where llvm ``ExecutionEngine RuntimeDyld``
>>>> +is involved, ``R_BPF_64_NODYLD32`` types of relocations should not be resolved
>>>> +to actual function/variable address. Otherwise, ``.BTF`` and ``.BTF.ext``
>>>> +become unusable by bcc and kernel.
>>>> +
>>>> +Type ``R_BPF_64_32`` is used for call instruction. The call target section
>>>> +offset is stored at ``r_offset + 4`` (32bit) and calculated as
>>>> +``(S + IA) / 8 - 1``.
>>>> +
>>>> +Examples
>>>> +========
>>>> +
> 
> I liked the examples.

Great. Just added one more in the new revision!
