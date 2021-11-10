Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8CF44C5B6
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 18:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhKJRHy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 12:07:54 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50356 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231793AbhKJRHx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Nov 2021 12:07:53 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AAGwuGO000891;
        Wed, 10 Nov 2021 09:04:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=NNtG0ZINpb8RWrDsFDQroj1TB6QO3GkvqbciKZ2VzHI=;
 b=a6Miw1efsYU5KArSq45GMmX4ku375QYDt5Otf+CLXyEz6syDNOS4UKQi74Mq9JSZEmRV
 l9UrU0lfO9h/hmSuh3wSkOt/Oy0brvNVjE4bXNORwSYig55P7bbgSOiU70OO0QJX63PX
 9D3EL74mozcdp2miK5t7SfixOKzCgZNhBMQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c8gk5gvkj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 10 Nov 2021 09:04:48 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 10 Nov 2021 09:04:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gnr4OvPpv3uZbIkmKXQKUux6S207iqvqO8PphySkhDcztsGPZCc0AaLr0i2aSHHhno8t/4+CLeDRNNzrAZgNg4KYRrFCWsmCEMsuNNnkMFYuwm/FMV/Ox83V3kZ15KpGMY61BP5K2OITwbyD7WCDRL10TJx30wdaQ9NaQvBtscQUkFNRM09ctfnkYNncAgO56kKTSv5pUE8b77Nc6lkqWYfuOKc1uoHk9tc8r0HouDR5776+Z088D8qUs4oSyAGEYdop12JamrCp3NN4M1qO4jLvAmww9G6eJzhsn5ai02xNqqXojsvQzLgfZy9UzYacPvxjAiTKtgY5XrxFtC6WkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNtG0ZINpb8RWrDsFDQroj1TB6QO3GkvqbciKZ2VzHI=;
 b=m70M8yWI7TthGs4K87lVzS/5YO89sdgvhMI4kR79Mih0AjikInmQYBq0mjXgPG5ARsdznSXCoQCyPufx48mY1RqGNCGfEcy16jJ8x25REnk0LtDZsAMchmZmmCz9s3L+KIeP/zgbjF/2tX05iy+enqhFor+hFu17jikwg080DyTjSsuabmtK49T/0LvElT9WHenmC+UMwcKlNWjDJ8zF0LM/LE+0dpjiXFJ/9ZGto0A8QjgVQ+ZPkMXDyXeAmZfMG+G0hMwG2bOB3DOoguq8veBlrOm0RWt6L8N95msgWRBuMRBhI/YaUa5qq83PQ+ndkVvIyPLNfUCCGbld+eFxHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3982.namprd15.prod.outlook.com (2603:10b6:806:88::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Wed, 10 Nov
 2021 17:04:46 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 17:04:45 +0000
Message-ID: <69e9af56-02d8-1ec6-637c-80666788dc08@fb.com>
Date:   Wed, 10 Nov 2021 09:04:42 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH bpf-next 00/10] Support BTF_KIND_TYPE_TAG for btf_type_tag
 attributes
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>
References: <20211110051940.367472-1-yhs@fb.com>
 <20211110052805.qds3qzhabhdr3ah4@ast-mbp.dhcp.thefacebook.com>
 <d2546d58-67ee-0aee-5741-113f0583365b@fb.com>
 <CAADnVQLeW3s2Dx8+t8ajt=H3r-r8x40wFF18ia+wMbv6WYqdnw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAADnVQLeW3s2Dx8+t8ajt=H3r-r8x40wFF18ia+wMbv6WYqdnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR10CA0007.namprd10.prod.outlook.com (2603:10b6:301::17)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e1::11e2] (2620:10d:c090:400::5:cc53) by MWHPR10CA0007.namprd10.prod.outlook.com (2603:10b6:301::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16 via Frontend Transport; Wed, 10 Nov 2021 17:04:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2250ed7c-337e-4079-7298-08d9a46c3250
X-MS-TrafficTypeDiagnostic: SA0PR15MB3982:
X-Microsoft-Antispam-PRVS: <SA0PR15MB3982839C20BA59C884F5806BD3939@SA0PR15MB3982.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GNzV6U8DaUjpaEwq/6ACpUzFvxZ5mjzTjbXxHiRWg7ngysjABZeIXW0/3kTTkly4Esfg8RLtitveUDwDISnr/jIr8S0vIkw1EEaucxM/XjWExnqjk9OyDJ/uagcWE7bnnN6pLNTcXcHq8EtJXuiCm/7K6DG1FQ2wIj5NWDOWgqDhWXm4m5ES4xeQvXHz71YZhv2xj3pO7nkr9J9nt0LiBQbT3egu4qvf6nKp0nquq/PK/MU5Qwj1rMUXrbMhcxP6WYpoTQ3aA2LyuKJVRb8LaM5u7e7dIJcOveRB0yuvb2LimCZuKqtwHYJDNY0gvU2q0nCGRqNBaTkfG7L4YEZ6tmRAzxnAa+KnTLM1/o+omvmlGph64CUgZ6qIJH8hTIWzLtPESQjLrWBteM6/fQA4ZL+5ZemPz9gMY/GcG+QaldjWQR8q9fEFBoiCCeUGMBjXNt3nnuA64H+xDamqqt+25nMcI6eaXim1vHYDZv7XQTv0xQhOi9OLR+OUIhRZBnO6bs9H/RT9fNhN8z4erQyo+gBePahji0ihwgrFEBdh9eF0LDU5+6FijgphuX8q/LoecjiUZmoI9JRKKT9w4jseBVGAaJ5VKBiy68gaEpUfjLEmRo+QsAtFf+vvHARGY18zz6LMk7Rom7ErsBCIs9w86JTREwnaa5CcA17vE9avNIdvZvNb97iI8/dIiMC0cB1fdCxJYdpCk161zpvQxHrYIfrh9lJgodI1x6v5GCeBFmk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(5660300002)(31696002)(53546011)(54906003)(36756003)(186003)(2906002)(38100700002)(83380400001)(86362001)(2616005)(8676002)(31686004)(4326008)(52116002)(6486002)(6916009)(8936002)(66556008)(508600001)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3NiYko3eHhGdkc5UXZWd3VoVy83bXdwbDhzY1Z6MWRBRWhWRldnRUJUL0Z1?=
 =?utf-8?B?QUpLWGJEaUZWRUhaZ3ZQZWUrTFRRQ3h0bGpqUVhLWEV4ek4yc3hiNGJhWEJ2?=
 =?utf-8?B?ekE3emJkdWRnZmwwZE55d04wV3BYNXo3NnhPbzdsa2luUXB2aWxyMUZndXl0?=
 =?utf-8?B?dVJRL0ZETUxEdWNYRUtIWUZOdVd5YWF3K3ZnK1ptNnlxanc3UXV5SllaVFZU?=
 =?utf-8?B?NlQrOE9jSnNmOHlESk5lNE5RWWFKTVNYeFBNV2tXamZFUXMzMG5HYnRoWFhE?=
 =?utf-8?B?ZGtzdTRud2k1S2xZRFhyRmF6U091cXVTdW50b1JEREFYRTJTN2E2Y1V6b1dw?=
 =?utf-8?B?T29uK1ZlNEpuNGZJekdWdFlVUlRub2FlNjl2NGJlVzRQRy85TVFrZmZSb2lL?=
 =?utf-8?B?aVliK04xZ3VZNnRVdk5teDl0L3lsYTlmanRMWFF2RFRrQm05S2pHQytOdFBY?=
 =?utf-8?B?cnJTWExiazBJMjJ2U29JRVNSa29wZUN5MndrcVRQUXRhWStYajBld3IzUlQ3?=
 =?utf-8?B?RVhLTGVVUERyd2FlYklBRGFyQ00rSVJPSnBtVWQxYldMQ255UG1CdU5PdlBn?=
 =?utf-8?B?M2NZclhVZHc5WHN0TnUvVTVpWFd0UlZHYkFvSjZuMU9uMEVNZ09rQ3Q3WHQ3?=
 =?utf-8?B?N084OVhYR0RubFpCYldpVmxWbUdZWXo2WWtTQzJkYTdWMFFYaG5ZNXVVOGNI?=
 =?utf-8?B?dy9FZDZYZERmMlJrNHVrRXdXTzFiYkJvU3FqNEZ2TEp5WWl1N0tZOVhROUEv?=
 =?utf-8?B?b3FXQXFRSmwyQ1FVdWNCdEhMVUgxYUxqUGUzS1BhZU5WTEhMWk5PMWVza2FZ?=
 =?utf-8?B?aE9uYkhDY3VFeFpDSjdIcEtpZXJ4RThvWHRuUU5iQVBKVlVFcGVTUXlXZGhO?=
 =?utf-8?B?SHU3ZEI2OWY3UERTdXBudVl6NEhYYWx6ZHgzRWwzRUNlNzFUNDc1T0NOUkd0?=
 =?utf-8?B?REVETzJJL1E3c3FDUERnaDdnR3pUd3ZuZUlFQnpDdFhybXVFRUtJcnB1cC9q?=
 =?utf-8?B?QWcwVzBzWkhLQ1c0b2U4akJab3o5QWUzLzZiYWsyYzZLNDNWemxBV2pHdlFn?=
 =?utf-8?B?VkJwWVNxeUNDZUhNaHQ3S0F1NDdpaDdPSUZTN2daaWhDdlY1NFNoRHFPMnFD?=
 =?utf-8?B?SmlSTDJUNGFSUXNBZnZUUWs4czNhRVphS2VSU2NzaVNubXFtYmRLTTJUdm9V?=
 =?utf-8?B?N2NONERrR0NKVjZqQnpTU04xSk1KK0pxdVlIZnp3Y2pFV25CbkxaVmM2aWlI?=
 =?utf-8?B?OW1GamNXMTNKcC9FQ0JwSnYwd1BUQTlPSXhEYysrRFRTTnVPaHhlNFpucEJN?=
 =?utf-8?B?dFNoVzdvekhSMTR5eUsxUk9XclhNWDg0dXBSZ0RpSWRsdTdHOXJHOGpRT1dq?=
 =?utf-8?B?YzlxM25sV2VFdDhCRmNodEdmUFFMY3ZtclVpV0ljVW44Ukl3aVZ3UzFnNlls?=
 =?utf-8?B?WDhndHcvSEJXaEpIOE1rOURBbFVzczhPbzhRRHFVNWY3NU0yelBHRUkvQWtZ?=
 =?utf-8?B?MjlOWnBkdmc5dWNZVTJTUmpPeTVmRzlLb1pnVk1pYTFSbU5tTnVFK3crWk5R?=
 =?utf-8?B?VnM2eG5WcVVlTFZtK0tORXlPdXlWRXZhek5qZ2hDL1VZM3ErdG5CeUUzNkVm?=
 =?utf-8?B?eXVjSEYveU1TNVdoVml6RzQ2anNIV2hZZ09CWXFCUmh2RzdGbjU3NGN5empy?=
 =?utf-8?B?T0pjQ2NueXZ6cXBiVGN4K29UQ1B6VGhOc2xaRmkxczR6MWJDU3ZscmZBVTRY?=
 =?utf-8?B?aXp4ckUxRDdyWkZaQXhFM1dQdy9oZ0dOUDhaMHlHNEZLRndqY0NrbWFkSmxF?=
 =?utf-8?B?OW1kUERTdFFmOEZ1cTY3emxaaXUyK09tajZIOW1ydCtKK0VpRWpYUTd0TGFW?=
 =?utf-8?B?KzhabzJGTWhmTEp6bktpT0J5TWxtZzRrcjNuWnUyaC94SUNzYlc2Nk56Yk9H?=
 =?utf-8?B?S2M3cklsTTNWVHhCejZYdFovVXA5ZkhvVjVaSmxPanBMNC81aFowZUdyazhC?=
 =?utf-8?B?MHJNMFBkSDdhWXkzQ2R4WTFUdTh2SE10WjdMTUNnYmUzQWZXeFRPYktzQ1dC?=
 =?utf-8?B?eWs0dSt0TE9wRTRhU3A4d3pvNmJ5Rkx0MS9zZyt1UGI0eC96a0R2U1oraktW?=
 =?utf-8?Q?iWrHrotFKZDcfYGVBIcL37wEe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2250ed7c-337e-4079-7298-08d9a46c3250
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 17:04:45.8291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sa0oT3dw+gW2gPGHazdiQ4kMIvvzSxiN5pYTL6svdwwDa7gZUJ23S5lXo4uL4VS/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3982
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 5MnCEZ3tL4NiyjlMI4__pcOMnmrgBsxk
X-Proofpoint-ORIG-GUID: 5MnCEZ3tL4NiyjlMI4__pcOMnmrgBsxk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_06,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111100086
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/10/21 8:40 AM, Alexei Starovoitov wrote:
> On Tue, Nov 9, 2021 at 10:26 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 11/9/21 9:28 PM, Alexei Starovoitov wrote:
>>> On Tue, Nov 09, 2021 at 09:19:40PM -0800, Yonghong Song wrote:
>>>> LLVM patches ([1] for clang, [2] and [3] for BPF backend)
>>>> added support for btf_type_tag attributes. This patch
>>>> added support for the kernel.
>>>>
>>>> The main motivation for btf_type_tag is to bring kernel
>>>> annotations __user, __rcu etc. to btf. With such information
>>>> available in btf, bpf verifier can detect mis-usages
>>>> and reject the program. For example, for __user tagged pointer,
>>>> developers can then use proper helper like bpf_probe_read_kernel()
>>>> etc. to read the data.
>>>
>>> +#define __tag1 __attribute__((btf_type_tag("tag1")))
>>> +#define __tag2 __attribute__((btf_type_tag("tag2")))
>>> +
>>> +struct btf_type_tag_test {
>>> +       int __tag1 * __tag1 __tag2 *p;
>>> +} g;
>>>
>>> Can we build the kernel with the latest clang and get __user in BTF ?
>>
>> Not yet. The following are the steps:
>>     1. land this patch set in the kernel
>>     2. sync to libbpf repo.
>>     3. pahole sync with libbpf repo, and pahole convert btf_type_tag
>>        in llvm to BTF
>>     4. another kernel patch to define __user as
>>        __attribute__((btf_type_tag("user")))
>> and then we will get __user in vmlinux BTF.
> 
> Makes sense. I was wondering whether clang can handle
> the whole kernel source code with
> #define __user __attribute__((btf_type_tag("user")))
> Steps 1,2,3 are necessary to make use of it,
> but step 4 can be tried out already?

Yes, you try clang -> vmlinux dwarf part of step 4 with
the following kernel hack:

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 05ceb2e92b0e..30e199c30a53 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -32,7 +32,7 @@ static inline void __chk_io_ptr(const volatile void 
__iomem *ptr) { }
  # ifdef STRUCTLEAK_PLUGIN
  #  define __user       __attribute__((user))
  # else
-#  define __user
+#  define __user       __attribute__((btf_type_tag("user")))
  # endif
  # define __iomem
  # define __percpu
[yhs@devbig309.ftw3 ~/work/bpf-next]

