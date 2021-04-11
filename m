Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF5E35B65E
	for <lists+bpf@lfdr.de>; Sun, 11 Apr 2021 19:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbhDKRof (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Apr 2021 13:44:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62680 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233822AbhDKRoe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 11 Apr 2021 13:44:34 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13BHcxLP003616;
        Sun, 11 Apr 2021 10:44:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ijDCxWsxqrXFsp2sFzORBY1xzG9f1IB7lqSiKMD7jkM=;
 b=VEvl1+33JR4F+iVaq8KPKAWWBSvem8ylJDZVF2Vryzn3YCD0CEDOIdPqpU+dvRfBGFgf
 Be6CI9UeljL2jRYZTnHNPtjHj6Tv2z1qHruWeck/9Y9TqgvQxRxst9e7oaPsAbO/nCqf
 MNyAXrbjKOy/OKe3IrO1AarCQm1E7g5JQ2c= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37u9ht4xxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 11 Apr 2021 10:44:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 11 Apr 2021 10:44:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XE+8THlp9BcOcLJEdM8iuoMTzhqsVOnmuvHnSJEvKrm0itaIbgCQHLFVLkXH5vNyp39Bc+htzlu7EL06KvvebSztAYqYIo6TrqFFdHQwbCbod+aBbzFtEB66/CoAu1+Wv/x1mcwm9NsBnVZtOgA2hsMNl3TL5N7f50WV4e6XsCn+FMB6sTD5TiqTaAtNdN2c9esCIwFUjVEDi4s1uTQFS+yQnptvc7rernFUEOACcKEQoV+NV4Dc7CJFK/H+dmq1kEpwNJYmSu9KESKITeUB7hf5WqOmhqkgO2Gg0KFl0uMf2m7IRbqyFGAH4zq7AxwrRUXhc1oV+zld5MKwsS5qVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijDCxWsxqrXFsp2sFzORBY1xzG9f1IB7lqSiKMD7jkM=;
 b=fqxCaWVt8bxGciK9szBUVlP+HjVQ6tqReBg8wkhUFThL/EFTD6k1evoYcCAp21eZJldqGyf/t6oHIJAaBRjd45IbyV3+sOJx4o6QP7VGrIos3no1mbWIGbfNeqd5jUooJEayeOj2TU4cHZ/13dnsAOMgHgVrjp81KHttkLMh07vFll3nmbp1zsxicJZmgkwA7dD7BGA4Ouvk+9nh7GDTjyIdhjhq2qT36aImYPkDuAmnQO3SwCei5EWgZu2rkpHK9n6fHVvD64mIuT8pcqUL/4pfz6GWLSYeSRhFDgbdSw/CqMtSDHyvC/LabPUWKzBIHwRe6nNUv9HrwXkB+LK3vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4046.namprd15.prod.outlook.com (2603:10b6:806:8d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Sun, 11 Apr
 2021 17:44:03 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Sun, 11 Apr 2021
 17:44:03 +0000
Subject: Re: [PATCH kbuild v4] kbuild: add an elfnote for whether vmlinux is
 built with lto
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Bill Wendling <morbo@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20210401232723.3571287-1-yhs@fb.com>
 <CAKwvOdmX8d3XTzJFk5rN_PnOQYJ8bXMrh8DrhzqN=UBNdQiO3g@mail.gmail.com>
 <CA+icZUVKCY4UJfSG_sXjZHwfOQZfBZQu0pj1VZ9cXX4e7w0n6g@mail.gmail.com>
 <c6daf068-ead0-810b-2afa-c4d1c8305893@fb.com>
 <CA+icZUWYQ8wjOYHYrTX52AbEa3nbXco6ZKdqeMwJaZfHuJ5BhA@mail.gmail.com>
 <128db515-14dc-4ff1-eacb-8e48fc1f6ff6@fb.com> <YG23xiRqJLYRtZgQ@kernel.org>
 <08f2eda5-2226-d551-d660-dba981b6ced8@fb.com>
 <CAK7LNASUkLi4gu-9TY7p7kaLFKtEFA1qA0kc3VtOcgH9xJgsfA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <d43d8804-ff30-fa38-b9d0-5dc20df2d795@fb.com>
Date:   Sun, 11 Apr 2021 10:43:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <CAK7LNASUkLi4gu-9TY7p7kaLFKtEFA1qA0kc3VtOcgH9xJgsfA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:ec9]
X-ClientProxiedBy: MWHPR15CA0052.namprd15.prod.outlook.com
 (2603:10b6:301:4c::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::110f] (2620:10d:c090:400::5:ec9) by MWHPR15CA0052.namprd15.prod.outlook.com (2603:10b6:301:4c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Sun, 11 Apr 2021 17:44:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56ec4f42-193e-4c13-2d28-08d8fd116548
X-MS-TrafficTypeDiagnostic: SA0PR15MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB4046E4FA6E412EEC58E9B407D3719@SA0PR15MB4046.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OlXqRdqjMB8vttD2ZHVO/qS2CR08QOuQM6WcBUQ7JZA+MBk2AeuwNdcg9GMutkFryIkrwd5OclMTB3RWjKY9k9rM5oDimYPjrupx+FO7R8aH/ZCnVqrjEVp/w2+9Y+0FYeIop1PnkKj0G72JuW8Z/Q8SaoIQwKXouF0qSWK58+qI68lX2xNvmx+wvmptICe/D66nndw2lKICd7+8tpsD5DBQ19gAGxmgnZYImflAsR6V/o+TFclpC5B8Pf1hn/N9tZbPDMBc8u3sGOmghgWXsrZgU7pPo+zugHQy4VCNgcchgQQDeV4dsaAFxfOvzDodxbogOVixo4PIsLUiLDRCVi9KhAcKwhJbOSFK8d+MQgTQw4d+gGmayaOCPO22xXzTinkg2rzYuAw43OXRXFjr/ZA8gMOt+JkRDmGeYz2dWI5dmMnk88UPMvlVw6FLnXRkFwbeGtW0aC6DhY18heAzF0PYeL3ZZvIbbhWaZzAPawiLXtudi9JAq+SLcoFgECjZp18XIUKPorIwxm5WfDTOpvDL0ixnIDUuhviqvJolTpCftk707A57OgBanbT0XsjwJMIiOeyvFW8/L89foK9+xkrCoXgYy75EL2gSaHb5L6Ah2IBtWSAebku/OY1OXDOaqi88JY9WKCa9D1ef2y0Ov28PZVgCfvYe3m2iYjginEIeiccYDNMHImsE31t7yBkiKsXji62ww5ZxABJ+UilJMiWvIR7NYeoEO6A9m5Gg2frtH7nXUvJVO+EelHOqgEoBmHTzho28VBxYbaKb01xsPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(39860400002)(376002)(346002)(31696002)(36756003)(66476007)(5660300002)(4326008)(54906003)(316002)(8936002)(66556008)(86362001)(31686004)(7416002)(16526019)(38100700002)(966005)(2616005)(53546011)(66946007)(8676002)(52116002)(478600001)(6486002)(2906002)(186003)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MzY3c0llTTZhbm95eTFzdTMyM1AyMFhjdEhrVmRjYlRwT2ZHeVZIalZXSFhu?=
 =?utf-8?B?V05IYTUwaUkrblpuU3pCeEc5VUIvREZoNUNsQlJITFBIdXNkcjQ0Wm95TXlK?=
 =?utf-8?B?bUJSYkNUa2hOZFJCTlprbklmMmNJdEpzWVNLU293SzdlRTMxblRIWXlYeEM3?=
 =?utf-8?B?VHFkc2hqZlA0bWZEMVNQZG1UVU51dWJIazFhQzVaOTdHVzJWWElDeWc2V3E5?=
 =?utf-8?B?VDVoL2tya1ZKaXhQQnVRYzlKY2dwTUxmY1ZsaUR0dTlhbXlXQ3BIRnpENE1t?=
 =?utf-8?B?bnlBbkQ1QW5CWTN5b3VtYktIUERVNVFhYllHMEtWajA1b3FiL0p4cm9UbFBB?=
 =?utf-8?B?NFk2SkZXQzhPVEg0Ukd2UWtKaTRTZ2tEYzFWblNjSUtEWVIyM01IdnZib3k2?=
 =?utf-8?B?N01DZlp2NDk4QzFFQ1FVTkJuWlZEdmxQUWdDOWJSTWJ2NmthVEZzeFdOd0R2?=
 =?utf-8?B?c2pTRzNpTzhMYVA3ZXdLV2VrTFVBV1ZpdCs4cTg5UG9UNVBvUW8yRC9RT3oy?=
 =?utf-8?B?bElSSldRTWRocTJ0YzNNdTNXWXpQZExaWWJkKzl2emlldStOYzVHVlNUbXdJ?=
 =?utf-8?B?NVVQSDZmTmpJWGkxUUc2T1Z2a3BzWU9IUVlqdDdacHRwVzBlcDFLcFg1dkxU?=
 =?utf-8?B?Zy9xQXZxdVBDa21FWGozaW9nVHpWcDVVUy80bmdxdVVwRzRiSDNJT1JDeHlj?=
 =?utf-8?B?d3ZMTm1aQ1k0ZTEvNlZVZ0lFZmEvQVJJU05hRVVOUWo5S3BvNWRSbFJCMEJk?=
 =?utf-8?B?NWRHaUQ5SllvbmNRNnp1YllvWDgyaElrMEp2QjFLYU1ucUtKRk9TalhRbVI1?=
 =?utf-8?B?UUt0Q1FCbiszNWIwR201QkV5UUhUSFBVWStpZUdLT1prT3RmMTI5ZWdMd0dJ?=
 =?utf-8?B?V3ZFQmo0RVFQZEoyZmZxams2MmZrSjh3N2ptV1FJOGYzQnByOVg4QXRCZXdx?=
 =?utf-8?B?cUp5RklLc3RRRFVWRUZaNUtGblU0OE53K0FkaTNsbTJBeUl2d1JId21Qb25J?=
 =?utf-8?B?UU02VFZJeTdGN1hMN1AweXpGdlFIUjdLN3Bob2wvUStmRFNTc3R4YVhySlJs?=
 =?utf-8?B?UEdjN2phNVBIQUM5Z0Q4cmR2R3lMYXJpV1hpalNway9KaVBPMWpCOVNlSWIr?=
 =?utf-8?B?YUNRQzdxc0dDMit6N2dWM3JVRzJTZThTckNKcjZQU0FHYjlqSDlyT2Q5ZENn?=
 =?utf-8?B?d3AyZHpiQWFNYlJUOU5NZlowU2oxZDl4cDR1Skd3SkMrSlloZkREeGVFaDRT?=
 =?utf-8?B?Zm5Yam9ydS9XMmh5QTB2T0FuTTdLdStuMituVWVESUU5L3UrOHA5MTluZzFI?=
 =?utf-8?B?bkVzZHlveDVHQkdpTEtCMWQ5NFR4QVhQQTZIekhnUEsxMlg3NXYrQ1BjdCtr?=
 =?utf-8?B?NXpJTXYwVmR5dDdEZkhBQy81QUowTTJyZFZ4eDY1NENPRlJZY3haTTZvRFM4?=
 =?utf-8?B?SU1NSmEyb3hDRmcyMmVndXp5Q2lIaHJVQzJ2a05VZ0JRM25MbFhjU0psRmVD?=
 =?utf-8?B?NHlsVkthMGtrVkp1UXp0bFBITnVEQ0pMaDNJWnVIS2VjS3RMWHJwOENTQ2ds?=
 =?utf-8?B?aWFhU0VqbWRxcGRqMjVUbnd3a21hZXgwMkJJdEhWNkNsbDRQVDZzNzFkQ1hU?=
 =?utf-8?B?UlRHclFVNTNWeHUvblFUN2R6eWlwK0dSNUNDS09tMWc1cFpKdWlKOXRCQ3Zn?=
 =?utf-8?B?NldZZHRTTm1oSzRiS0Fyem5mcGpieURXblJRQitiSysyVHJBVVY5UXVZdnht?=
 =?utf-8?B?b29pTkwzelZCNmZiMjdDOU5FMTVwZGhHdFdsQWNUQjQxVGJNZ2ZEOUE2d2ta?=
 =?utf-8?Q?VcyG3Yj38CoUK1FJS0amqWBWXWBvciT4IdUfM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ec4f42-193e-4c13-2d28-08d8fd116548
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2021 17:44:03.0194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWy4Ad6n32PHJ40mAIk8cxEmBtZX8U5I82QxpJTy5v/WqUqxswSM663W9minr5fK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4046
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: nAo-HWlSD7HH_TOhnriTw1BVHCHLcmjU
X-Proofpoint-GUID: nAo-HWlSD7HH_TOhnriTw1BVHCHLcmjU
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-11_09:2021-04-09,2021-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104110139
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/11/21 5:31 AM, Masahiro Yamada wrote:
> On Wed, Apr 7, 2021 at 11:49 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 4/7/21 6:46 AM, Arnaldo Carvalho de Melo wrote:
>>> Em Tue, Apr 06, 2021 at 11:23:27PM -0700, Yonghong Song escreveu:
>>>> On 4/6/21 8:01 PM, Sedat Dilek wrote:
>>>>> On Tue, Apr 6, 2021 at 6:13 PM Yonghong Song <yhs@fb.com> wrote:
>>>>>> Masahiro and Michal,
>>>
>>>>>> Friendly ping. Any comments on this patch?
>>>
>>>>>> The addition LTO .notes information emitted by kernel is used by pahole
>>>>>> in the following patch:
>>>>>>        https://lore.kernel.org/bpf/20210401025825.2254746-1-yhs@fb.com/
>>>>>>        (dwarf_loader: check .notes section for lto build info)
>>>
>>>>> the above pahole patch has this define and comment:
>>>
>>>>> -static bool cus__merging_cu(Dwarf *dw)
>>>>> +/* Match the define in linux:include/linux/elfnote.h */
>>>>> +#define LINUX_ELFNOTE_BUILD_LTO 0x101
>>>
>>>>> ...and does not fit with the define and comment in this kernel patch:
>>>
>>>>> +#include <linux/elfnote.h>
>>>>> +
>>>>> +#define LINUX_ELFNOTE_LTO_INFO 0x101
>>>
>>>> Thanks, Sedat. I am aware of this. I think we can wait in pahole
>>>> to make a change until the kernel patch is finalized and merged.
>>>> The kernel patch may still change as we haven't get
>>>> maintainer's comment. This will avoid unnecessary churn's
>>>> in pahole side.
>>>
>>> So, I tested with clang 12 on fedora rawhide as well on fedora 33, and
>>> I'm satisfied with the current state to release v1.21, Masahiro, have
>>> you had the time to look at this?
>>>
>>> Yonghong, as we have a fallback in case the ELF note isn't available, I
>>> think we're safe even if the notes patch merge gets delayed, right?
>>
>> Right. That is why I separated the notes patch from other patches.
>> We can revisit it once the kernel patch is settled.
>>
>>>
>>> - Arnaldo
>>>
> 
> 
> Applied to linux-kbuild. Thanks.

Thanks!

> 
> 
