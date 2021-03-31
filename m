Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC01234F777
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 05:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhCaD1U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Mar 2021 23:27:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55634 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233349AbhCaD1R (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Mar 2021 23:27:17 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12V3JRBq020364;
        Tue, 30 Mar 2021 20:27:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=hAiUZCxiQ6U7qMT6cKPjNQ7bSiC3HVP3UFXzsFxvftg=;
 b=DIlWojj31CpW3FgwHE59gbz8XXB/akJBqlvRtgWcVXbkzeYvsNA+5cnAc0UKYyshsjSk
 0Pg7ASFtEGS9sTzwPvIK9cytcsfMkFBJrGkfE2hffnYvD62vgGvkIxG9PKNctZN2tjrk
 J5rwAZeFiydEVTTVb2nMxS5t45oe/eQJYlc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37mffugc2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Mar 2021 20:27:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 30 Mar 2021 20:26:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9uHw1D4xKcE0LDyrQBXRon4CwQpRiUG5vZ4KOoin6S3B794Lrt1qwel59LiQX3RsVXbefa2pA0Y2dVyUUysNXd3+1+4KyylgzS3OfONnZNIfTU59IWVHjqMHiZwhx3S8Fz5KlHXTBoZkWd3Py6o/gMR6WESCQl1m4C/eq8vHaK9A2dMh+k63m87prkkNGGYrwzn/aK7ZcQ5ywTH14pJ3XNjfwg2F0s5wnJgERMFjhkaCwbDANGG966u6SVMBXWBcEqJD20N2OE8gZs8DnHwMfe7HYsmwxQQP/9F6xl9dpsh13u1m877dSyp8payonGw1oi0wH39ewNwF1MoiC0vtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAiUZCxiQ6U7qMT6cKPjNQ7bSiC3HVP3UFXzsFxvftg=;
 b=Lb+qpoi43KwHOIntEZgGUaMDD9PAn94TtQYidLGVX/m7NoOW03ie4gR01EMfHbyw5oiSnNo10zwav8BfyDAJBlcXPtJhBcH2+mAfzZklFjnKVQJ9sc/dwZ9AWOToJWUezFtKxAazoOKeztGZRi/kQEUJWzV5VYOmExEGWvxXIzjCLBQ2br+om56KsgW46TVAHMDBV51407O0yiRz0RbYzFu5ZO/hsYOfxXpFEPnrvz9X5FGD6pb5E30Kwv56Lq79xZcaP+C+w8toT4EiHJtRipH+QX0X8biFw5Hu0ZfwxnSPUQ/yKtvB+1uOKAOWVbBh68Aed6/eoi6TLlBffpbkTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB1967.namprd15.prod.outlook.com (2603:10b6:805:7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Wed, 31 Mar
 2021 03:26:56 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 03:26:56 +0000
Subject: Re: [PATCH kbuild] kbuild: add -grecord-gcc-switches to clang build
To:     David Blaikie <dblaikie@gmail.com>
CC:     =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        <kernel-team@fb.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Bill Wendling <morbo@google.com>
References: <20210328064121.2062927-1-yhs@fb.com>
 <20210329225235.1845295-1-ndesaulniers@google.com>
 <0b8d17be-e015-83c3-88d8-7c218cd01536@fb.com>
 <20210331002507.xv4sxe27dqirmxih@google.com>
 <79f231f2-2d14-0900-332e-cba42f770d9e@fb.com>
 <CAFP8O3JjU26pNKhFE2AniP-k=8-G09G2ZXc6BXndK9hugX-0ag@mail.gmail.com>
 <CAENS6EuKv9iWLy24Gp=7dyA0RHNo9sjORASAph4UWLXvDWB+oQ@mail.gmail.com>
 <d34a3d62-bae8-3a30-26b6-4e5e8efcd0af@fb.com>
 <CAENS6EuGOHcBURjR2ee2tPz3VdEu3EssCM3rFcyQqAM5MjeyQg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <121fdb24-4ec2-20bf-3c2e-3b0f68b2297a@fb.com>
Date:   Tue, 30 Mar 2021 20:26:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <CAENS6EuGOHcBURjR2ee2tPz3VdEu3EssCM3rFcyQqAM5MjeyQg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:d5a5]
X-ClientProxiedBy: MWHPR22CA0061.namprd22.prod.outlook.com
 (2603:10b6:300:12a::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1120] (2620:10d:c090:400::5:d5a5) by MWHPR22CA0061.namprd22.prod.outlook.com (2603:10b6:300:12a::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Wed, 31 Mar 2021 03:26:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd403e18-531e-4cee-0a7b-08d8f3f4d5f5
X-MS-TrafficTypeDiagnostic: SN6PR1501MB1967:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB1967E2190D637DA641D9634AD37C9@SN6PR1501MB1967.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VqJp2h662TUlxbb7BgA+w1Mgdle/teWjMaeZq5vLHlL7fzcbfkvo5H4CqH4xNR+Ey4n9Pju8k1OkexPs6uwui4yqSvPZYYXeGspzibfdeQWLYv1l8gVrc9hjNAiAcuzQkDpF/x82vZuA0FG5yJLViGQlKzahbpkhBYsJGIiVjp5yo7sZz1IUPw7ef6wrXdmy/CeVxuZkcowIbj41q4TiG/0CsJKZpvwr60LL5OIkuNs0kkc+Z5Y6FQiEcuwbDy1Ldxvo7ANjb/AyvVe0a5oUoaFiFaswwUstKpH5WydqzUU3Ubo8atTnlPAX+4kFjaKzbw5J/CUM9gFtPy1vu9i1YKzOnAFN5M+CHwmRpDRYrFpup/H+pmlLTqA2ae2c5JWHrJn4FfzoH9ZxXx/hCWoVVUfdQ/ad6V/DTOM0wc9UJ8U/nGvaEUaoAt0dWMffXFnzwI26XsMHSraWDWNXYKsWX/H9uYdff/F8b6Hq+wJBxZ4pMHKUBoXpHuxOObN8RXeAvdihbwwt80LLjlJcst/PCpqyvreaK1jQvRN/fSFa9GVIGapuGM3BfX0160MhKrdj7dtFimLMMfeMmNiYLJWqwPOkP4yxQS4GRfJz59olkbFceI2NntR32ZR/FuOiwLx63DDjH706VKNJAiLVZg4wSjSAw4n10iWcO0JDsLm1+ZJlxk4E1r9cGt3wr/f6xwMnXEkwgUcxejMeOjAoHn0atFc1PmnIkHndEZWDROAKKFWesoFQDn9D5rNePlUbc2c/6U0AROAyP2cxJiAKsYZFLKV260vXRG7QXPhw5L03359Al9itotM5GMTkvdmOHbW1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(136003)(39860400002)(186003)(7416002)(4326008)(2616005)(8936002)(316002)(31696002)(66946007)(66556008)(66476007)(16526019)(38100700001)(2906002)(6486002)(53546011)(52116002)(478600001)(66574015)(86362001)(5660300002)(966005)(83380400001)(6916009)(31686004)(36756003)(8676002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bkNJRStkaEh6VUJGMkVoL3RsWmF3U3RaeGdkS1VueHNTMWVBQ3lrWTQzZlpx?=
 =?utf-8?B?VW9FWjZvTmd4Wmk0RDlBd3VUTjNiNVk1ZHg5UkZ5bkRXcmRXRzdxSXBzeDY5?=
 =?utf-8?B?Wmx4Y3lOT0RCWWFzUnhXT25xamZ6QWpYblZ5dGNYWHRBeVlGMm9FN3VmWjhW?=
 =?utf-8?B?SmhUazY1cnJLbnZvcE1ZZWU0Ny81Wk12NzVQalk5WkM4aXA0S1lHOWU4ZUZq?=
 =?utf-8?B?VEhBZFdZSDlyY2lLWDFyWW1hN0t1OXdYNDZpMWtMdENDdVA0SXFvNWw4QUd2?=
 =?utf-8?B?bGI0UC9sUmJnNEVLbkxwcU5NeTI4ZnhqZEpHZzVZZ0FQVC9DYWFER0tjcEEy?=
 =?utf-8?B?OFU4dFhMWURhU3V6SmRJTnU3MXlWZmp2SnZ3WDJhZVM1WTE5YllGYkZmRHlo?=
 =?utf-8?B?WHI4Um4xMUFhRG1lSXExVEtJZTRjMzUweFN2b2lncndWdEFYQ0FYei9hM0wr?=
 =?utf-8?B?ZVI2elR1SVdHUFdjV2l6VldmSDBNZGJLMCtRam85bVVsRzlUdTYvN1NVQVFG?=
 =?utf-8?B?ZEJjT1htMERzTFI3K2pWZnQ2YVJ1U3ltYWQybFZReG1mdDNHSmF4Mll5Y1lv?=
 =?utf-8?B?eGVEdW45ekg3NGVnbE1kK3Q3c1hkUmlvSy9RRnp3dVRTM3Nobk91S0NhREdw?=
 =?utf-8?B?blFDbmRkcm5VRTk2T2hlZXZ4TzZveGtkeUVRRzIxdTVVUG96WmV1RzVIbVlM?=
 =?utf-8?B?UlQvczhDaUkvaVB5ajNSNzYvSFF6V2RiVlFXbnRQZlZnbGhKRkw5OEFkWitp?=
 =?utf-8?B?bnh5TjJQcVlDYVljR2Y5aTFxYnd3R1lmZ2EvV1pXYTBZUSsrUVMyZFZoaGwz?=
 =?utf-8?B?c3dtSENsc3kwUk91R2ljdlZsdTdaWWNYdnZRR1NJM08yeEU0U1ZaSDJQdkpZ?=
 =?utf-8?B?R09UWU92SGI0dGd1enJhYlp2aDJEazRSRGhIL0psbmNLZEJGT3dubjZuN1NJ?=
 =?utf-8?B?WnIwdGlLM2NmUUN6ZDNUM3lndjduaU0vS3diRG1reDNmN1QwZUpaS0psalZr?=
 =?utf-8?B?R05xSnBjWC84MVNrN0g4ZW1rRUtDRVZINlZ6OFpvdFNDSEptSTNzbjByZ2h2?=
 =?utf-8?B?NG4vWXJHYlBLSENjUFhKay9CWUNodW5IazBpRnRlOC9EL21FM1YrZnNveStv?=
 =?utf-8?B?ZnJXME0zRUtvNFhDVDlUdkh4bXRJd242NG5oWTNzOFl5V2ZNRFNMUzFUU01H?=
 =?utf-8?B?Y243ZTZCTVdEd0N2TG9VUllMQWtRSWsxSmQwMU5hbXpLNGxxUC9EVjg3eEcw?=
 =?utf-8?B?VzZraVI2cGNUdXU0RjV2Qi8xTkg2RWJqYTM1RldnQU1qd3V1cm5BUFh1dnRD?=
 =?utf-8?B?VjBJd2diZ3JyYVdQWkZUdXdqVkdYYUJhRFM4YmdqQ0k0eFZsVVhJcEkxSlBa?=
 =?utf-8?B?NWFPeUxxTEpjRm91SzF6WkQ0c01vRWFBd0ZNYXBvVjdGcDBEeEtQYXd6dSti?=
 =?utf-8?B?TGUrTWk3MDQ1djdONWRWclhvVE12eDRRclBreUhvbVFZZTBTeG52ajR0R2d6?=
 =?utf-8?B?bnVrbTJVSllxc3BEbVJ3anMyVTh6L3BQMEpwSm1HaGxPeHhWMDU5UytNTmIx?=
 =?utf-8?B?VXZIYVRMTFh5MjVaZHlKT3FDMkJKNmFTbExJZDZQZFIxam1RZFdvWWNoR2Na?=
 =?utf-8?B?K3RwL0JrcU5zY3g2TnFFdHQ5SEo2dkd2R0NLRWsxbnhoODgwZndkUmpDamFM?=
 =?utf-8?B?a3UrMW03MUZSdnRLT1pLV1Y4NTJMdXFjVW5nYkVDVjRWVzl2S3RoVUZXWnRo?=
 =?utf-8?B?YkN3TmtadzBBSlRaQW9NZU00RjFBL1B0S1RYSVJaMnphdHUvVk1Za3BVbEpk?=
 =?utf-8?Q?qRrAwQhDqCDcG7KEQWtpZrwGX901InM2XGEqY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd403e18-531e-4cee-0a7b-08d8f3f4d5f5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 03:26:56.1020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99f15dOe/cLwb8ZOWYHhFxjwTHD19yi0sCv6eXA98AXSeez2PtLyPltmrwhMfzkj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB1967
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: pSE7WqC3Gkh2SwpPRQ2oylR_xDYtPlyC
X-Proofpoint-ORIG-GUID: pSE7WqC3Gkh2SwpPRQ2oylR_xDYtPlyC
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_01:2021-03-30,2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 spamscore=0
 impostorscore=0 mlxlogscore=832 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310024
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/30/21 8:16 PM, David Blaikie wrote:
> On Tue, Mar 30, 2021 at 8:13 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 3/30/21 7:51 PM, David Blaikie wrote:
>>> On Tue, Mar 30, 2021 at 7:39 PM Fāng-ruì Sòng <maskray@google.com> wrote:
>>>>
>>>> On Tue, Mar 30, 2021 at 6:48 PM Yonghong Song <yhs@fb.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 3/30/21 5:25 PM, Fangrui Song wrote:
>>>>>> On 2021-03-30, 'Yonghong Song' via Clang Built Linux wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 3/29/21 3:52 PM, Nick Desaulniers wrote:
>>>>>>>> (replying to
>>>>>>>> https://lore.kernel.org/bpf/20210328064121.2062927-1-yhs@fb.com/)
>>>>>>>>
>>>>>>>> Thanks for the patch!
>>>>>>>>
>>>>>>>>> +# gcc emits compilation flags in dwarf DW_AT_producer by default
>>>>>>>>> +# while clang needs explicit flag. Add this flag explicitly.
>>>>>>>>> +ifdef CONFIG_CC_IS_CLANG
>>>>>>>>> +DEBUG_CFLAGS    += -grecord-gcc-switches
>>>>>>>>> +endif
>>>>>>>>> +
>>>>>>
>>>>>> Yes, gcc defaults to -grecord-gcc-switches. Clang doesn't.
>>>>>
>>>>> Could you know why? dwarf size concern?
>>>>>
>>>>>>
>>>>>>>> This adds ~5MB/1% to vmlinux of an x86_64 defconfig built with clang.
>>>>>>>> Do we
>>>>>>>> want to add additional guards for CONFIG_DEBUG_INFO_BTF, so that we
>>>>>>>> don't have
>>>>>>>> to pay that cost if that config is not set?
>>>>>>>
>>>>>>> Since this patch is mostly motivated to detect whether the kernel is
>>>>>>> built with clang lto or not. Let me add the flag only if lto is
>>>>>>> enabled. My measurement shows 0.5% increase to thinlto-vmlinux.
>>>>>>> The smaller percentage is due to larger .debug_info section
>>>>>>> (almost double) for thinlto vs. no lto.
>>>>>>>
>>>>>>> ifdef CONFIG_LTO_CLANG
>>>>>>> DEBUG_CFLAGS   += -grecord-gcc-switches
>>>>>>> endif
>>>>>>>
>>>>>>> This will make pahole with any clang built kernels, lto or non-lto.
>>>>>>
>>>>>> I share the same concern about sizes. Can't pahole know it is clang LTO
>>>>>> via other means? If pahole just needs to know the one-bit information
>>>>>> (clang LTO vs not), having every compile option seems unnecessary....
>>>>>
>>>>> This is v2 of the patch
>>>>>      https://lore.kernel.org/bpf/20210331001623.2778934-1-yhs@fb.com/
>>>>> The flag will be guarded with CONFIG_LTO_CLANG.
>>>>>
>>>>> As mentioned in commit message of v2, the alternative is
>>>>> to go through every cu to find out whether DW_FORM_ref_addr is used
>>>>> or not. In other words, check every possible cross-cu references
>>>>> to find whether cross-cu reference actually happens or not. This
>>>>> is quite heavy for pahole...
>>>>>
>>>>> What we really want to know is whether cross-cu reference happens
>>>>> or not? If there is an easy way to get it, that will be great.
>>>>
>>>> +David Blaikie
>>>
>>> Yep, that shouldn't be too hard to test for more directly - scanning
>>> .debug_abbrev for DW_FORM_ref_addr should be what you need. Would that
>>> be workable rather than relying on detecting clang/lto from command
>>> line parameters? (GCC can produce these cross-CU references too, when
>>> using lto - so this approach would help make the solution generalize
>>> over GCC's behavior too)
>>
>> Thanks, David. This should be better. I tried with a non-lto vmlinux.
>> Did "llvm-dwarfdump --debug-abbrev vmlinux > log" and then
>> "grep "DW_CHILDREN_no" log | wc -l" and get 231676 records.
> 
> What conclusions are you drawing from this number/data? (I'm not
> following how DW_CHILDREN_no relates to the topic - perhaps I'm
> missing something)

Approximation of the number of tags to visit:

...
[10] DW_TAG_array_type  DW_CHILDREN_yes
         DW_AT_type      DW_FORM_ref4
         DW_AT_sibling   DW_FORM_ref4

[11] DW_TAG_variable    DW_CHILDREN_no
         DW_AT_name      DW_FORM_strp
         DW_AT_decl_file DW_FORM_data1
         DW_AT_decl_line DW_FORM_data2
         DW_AT_decl_column       DW_FORM_data1
         DW_AT_type      DW_FORM_ref4
         DW_AT_external  DW_FORM_flag_present
         DW_AT_declaration       DW_FORM_flag_present

[12] DW_TAG_member      DW_CHILDREN_no
         DW_AT_name      DW_FORM_string
         DW_AT_decl_file DW_FORM_data1
         DW_AT_decl_line DW_FORM_data1
         DW_AT_decl_column       DW_FORM_data1
         DW_AT_type      DW_FORM_ref4
         DW_AT_data_member_location      DW_FORM_data1

[13] DW_TAG_subrange_type       DW_CHILDREN_no
         DW_AT_type      DW_FORM_ref4
         DW_AT_upper_bound       DW_FORM_data1
...
The bigger number means more tags to visit and will consume more time.
For a binary not compiled with lto, all these tags will be visited
before declaring that the dwarf does not have cross-cu reference.
So the number is just a relative guess on the cpu cost. But ya,
have to have real implementation first...

> 
>> I will try this approach. If the time is a very small fraction of
>> actual dwarf cu processing time, we should be fine. This definitely
>> better than visit all die's in cu trying to detect cross-cu reference.
> 
> *fingers crossed*
> 
