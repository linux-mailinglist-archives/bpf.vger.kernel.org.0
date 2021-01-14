Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF2F2F6F16
	for <lists+bpf@lfdr.de>; Fri, 15 Jan 2021 00:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731007AbhANXqi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 18:46:38 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45894 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730776AbhANXqh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 Jan 2021 18:46:37 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 10ENhJhq018886;
        Thu, 14 Jan 2021 15:45:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=/jEu2XhKgorHo8uo/NhrgaTgf5uLHICfAQPx1ajaSK8=;
 b=mkMDJOIUnekYuBdCC1CwMwdsICUaF9cSajd+t6SYGVWxLhDMXsHvnEdH17m8XJIfQCCS
 HMdezeKuYj34JXtVT5+WV6LXX+S15YUv2CKcEL2kAsyVCkIBJ3lnGT/XS4vs+79ZE5Xx
 17VSh2LL9klpdBxvw+xa7eL9v8Oqxqz5sbA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 361fp3wun1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Jan 2021 15:45:50 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 14 Jan 2021 15:45:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1wGP0HypJfbshlhh+5C74idHLHZe2/W7yEJU+C6I4VBEuNuvM43j+2DrzOlFR8nWbfUqYA0Z0UybPf6qA+4NThOUI+Oo6bNQz88e1EV0YrqhNQpJemDhtUZOQD7xTE3SmBS1nfC2rptpem7Cq8XyImvuYdAqknMBwm22wb5gbSgBHprlE6UkO9iiqKX1EYCUn65Pe+6nl5SImooesIoimhGmj4uzeeeY5zAcVesglPAmQuEJsVDpETu5mcBJlamHKaaaRv9W/q5VVLw5d0C7YbgPPcIUYJZzVn9PESQGUWbbSkbzAzlnacRR9GCk9SaAxaRrSASmrhw7RzUmehJWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jEu2XhKgorHo8uo/NhrgaTgf5uLHICfAQPx1ajaSK8=;
 b=KYjNRMSueMpwCqNNqRaA+oFfmHhM2mybB+P7G3mRcTIbR1INz2oc2oLkMD+A9APsrsvf14HJlwkdi/Q/u1P5CPddK4CfEHLLeci/x1G7sTyy/GNFodHn8/71qukVY14ea1FirCz/Y9SpNeS9NwdD3uAuXQ7Ah4LVI5hNqnrWWJ/Yvxf333VcImVnfoD4Ub1L6oF7LkPIgTepWzzlnCNwuOmHcZxhbk+kb48kgtrYD35pI7xyuugv+3SbDl6zMBjhHwTeCCHUOXbMETyaWvLmAu8S5oIfcOfTZ2avmumNWPQ9/7aaBBobthDKFj4nchScuj17diq1azNRIAuCU/xAdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jEu2XhKgorHo8uo/NhrgaTgf5uLHICfAQPx1ajaSK8=;
 b=LZdFp1pTH0qA0U8raw5ds3Lix3dzXoo209HTsjkls93BilVQolrR7wUp9kt/cHMoc68bZP2DUlrS1Z4F8Aq9neEXMSjfWw5yn3rqOHmrpHBigNNH29YgILXzvEkwf6dcRHRZx3xhQYB6qU9p+t65P1ssd1/IOeiyk2V4UvBlDwA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3510.namprd15.prod.outlook.com (2603:10b6:a03:112::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Thu, 14 Jan
 2021 23:45:48 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3763.011; Thu, 14 Jan 2021
 23:45:48 +0000
Subject: Re: [PATCH v3 0/2] Kbuild: DWARF v5 support
To:     <sedat.dilek@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>
CC:     Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Caroline Tice <cmtice@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Nick Clifton <nickc@redhat.com>, bpf <bpf@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <20201204011129.2493105-1-ndesaulniers@google.com>
 <20201204011129.2493105-3-ndesaulniers@google.com>
 <CA+icZUVa5rNpXxS7pRsmj-Ys4YpwCxiPKfjc0Cqtg=1GDYR8-w@mail.gmail.com>
 <CA+icZUW6h4EkOYtEtYy=kUGnyA4RxKKMuX-20p96r9RsFV4LdQ@mail.gmail.com>
 <CABtf2+RdH0dh3NyARWSOzig8euHK33h+0jL1zsey9V1HjjzB9w@mail.gmail.com>
 <CA+icZUUtAVBvpU8M0PONnNSiOATgeL9Ym24nYUcRPoWhsQj8Ug@mail.gmail.com>
 <CAKwvOd=+g88AEDO9JRrV-gwggsqx5p-Ckiqon3=XLcx8L-XaKg@mail.gmail.com>
 <CAKwvOdnSx+8snm+q=eNMT4A-VFFnwPYxM=uunRkXdzX-AG4s0A@mail.gmail.com>
 <5707cd3c-03f2-a806-c087-075d4f207bee@fb.com>
 <CA+icZUXuzJ4SL=AwTaVq_-tCPnSSrF+w_P8gEKYnT56Ln0Zoew@mail.gmail.com>
 <CA+icZUXQ5bNX0eX7jEhgTMawdctZ4vkmYoRKDgxEMV5ZKp8YaQ@mail.gmail.com>
 <CAKwvOdn98zvjGaEy0O7uCb9AUZdZANCeSYpdti3U3uj4+V4dyQ@mail.gmail.com>
 <CA+icZUUMPwUF7wHir1rqNTGdQEgR1Fo5j646BunhEB6D3aFXsA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <02124c07-9411-2356-6288-3bc8c7aba61b@fb.com>
Date:   Thu, 14 Jan 2021 15:45:45 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <CA+icZUUMPwUF7wHir1rqNTGdQEgR1Fo5j646BunhEB6D3aFXsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:ab59]
X-ClientProxiedBy: MWHPR2001CA0003.namprd20.prod.outlook.com
 (2603:10b6:301:15::13) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::13f6] (2620:10d:c090:400::5:ab59) by MWHPR2001CA0003.namprd20.prod.outlook.com (2603:10b6:301:15::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Thu, 14 Jan 2021 23:45:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ab63abd-5d97-4553-7797-08d8b8e684ce
X-MS-TrafficTypeDiagnostic: BYAPR15MB3510:
X-Microsoft-Antispam-PRVS: <BYAPR15MB35100B53C4B3DBE08980FA39D3A80@BYAPR15MB3510.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5gTfclJq++2kXVPAFp20L6zVDWmlhRra6TS+svtBVHu7+GDZDd2fppddIHAPPUN2GcQzk/iIn84twxtmHPp+veS2Ca7+GaeyttqcNV8bm/DKYgRdvE+1rStyhILx+hI3pDIYgvQ7N0pn1nns8BkU2kj9ILGAtjRi13+5J8nXUla3GfLpGY1+7BoFP6pzieCh/ZXwi1XiYj55wd5wwIOmtuKQ0bhDHuYmkqgSpwnL6W7mDP6QszjdEH//Qti63DtbHoT5c8WblLOe0rz+ZGKt5B7YRmAmbrHAoR5iLOBrvDDBHKzr0d0lXjRA1UauPcecosovJ6Ez9xPwZmJuzJSoG7bpgDvocqcP76YoWEG8nPIYE6rgcnwTRDu64k/5wj7tatDQOqcQ/d0n68XjTALUjUmgIj77rKdzGDof8UrxP7g9kijzHRJGwkwNQgzqWa5VZlcU8aD9cJ9mnlk0yCa7GUS/7wySw+MsK5hKrGqIJcRAbfcXUqzAdi6Na3fxntAJZzkjaO9fal0veOKAFf09hmtwBoyDvy+35cHSMULiDew7EGxTJjulVZ6MTFBNc2/V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(346002)(366004)(66946007)(2616005)(478600001)(16526019)(31686004)(66556008)(8936002)(2906002)(66476007)(31696002)(316002)(5660300002)(52116002)(54906003)(53546011)(7416002)(186003)(8676002)(36756003)(4326008)(6916009)(966005)(6486002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aHh5NEFiUHJSdFJaVHkyMDJwQWxoT2tQWG5CaDdxUjNWSTJxbG9aV09pOUZ2?=
 =?utf-8?B?SDZwdThOckpBNHE3aXVEVlN5UGtmb2Z6QmZDUlNBRWpIazRjWnBzdldmTXhK?=
 =?utf-8?B?UHpRc1BBV09vWkJxV0NXYzF6dmFKdGRKSUJldjJURGlOdzhyVkFiYkRQV0dB?=
 =?utf-8?B?cTlXUEx3cEVxYVg0OVlwWmlKbFNPRCs5TFpwZDhnN3E4NFJmaE82RVpsRDNr?=
 =?utf-8?B?d3lxSys2Q0I2MFpNRHdjRnI5a0lZNnlVYkdyV21MSUpCSjJyRldFc3JBR1BW?=
 =?utf-8?B?RCt6UkNUdVlrVmlSRFpvMkoyY3F5bUs2V2JuVkk1MGVOUDBVUiszM1RVZGxS?=
 =?utf-8?B?WTFKQVZhZHRFaHNvQXMvZGtZRDFHU3ZhZkpxQktVMXpVQVRuUndOUnhaVW9H?=
 =?utf-8?B?VGZjdFhvcGovYS9LV2UxWWtVZDJSTHp6OFNwRU9aQzJxbDZlM2tCQllDYnpU?=
 =?utf-8?B?aFA1ZzBvZ2NNTHNWN0dQRXhSbmpkcENMTG9YYUdXTXNOeUFZbHlIOCtvOTZS?=
 =?utf-8?B?NnYyUS83ZmNrRzNIQ2VGZXBTQUpFWXhSaVA3alRnN3QycTRyOXNwL2lxeGRz?=
 =?utf-8?B?TE9SR0p6M3ZaUXVET0ZZbVFBY2ZIL0ZoOS9ZWUtNYnR3SGRQbGtKMUNBVzhH?=
 =?utf-8?B?YnhFMGZsSFFrdWtpa1B2TXdTN0RzeCtaVVllVzNwZHZWdE5CclE2Yk9keWlR?=
 =?utf-8?B?VkQ1UFNtR1p1VU5mUmkyOFRmZUlnUHF4K1NBZSt5d3FoR3VYV0FHTEtUOUNq?=
 =?utf-8?B?c3dndUlKaGhnam5VWjg5OVBUV3h5K3RWUUl1aGlvNFUyT3EvUU0vSzl6YUo4?=
 =?utf-8?B?bEpCby9YNjVsY25hVkdmNG5mMVVnelU5azAyWk0rVzVtSEFNQkI4cW82WVZH?=
 =?utf-8?B?TTFCQjBySXhwS2NSSm4zUnRmME0wOE0yOVFLREtFdC9mVXBoUExxdjNEN1R3?=
 =?utf-8?B?VDFxNmdRUmhPb0tHT3lkdk5GR0pLMzFLVE9wQ1NSYzd5NWEweUxUY2JOYjNK?=
 =?utf-8?B?cXVnMEUyU1ZabXdlWmpUblJ0OVZMalZUdDBTeGtLb0xPZk4xSnFGOVJDZ25H?=
 =?utf-8?B?bnRPalZYMzduS2U0c1hEZkh0YVZCWlgyU1orK2xWL1crWmtZM1ZXOGVuZlVa?=
 =?utf-8?B?enIwQ3FkYlN2ZjdSUDdEVVdpUFp1V2kwZkhETWpDNjRGdGxEZTV6d3lGTnZ2?=
 =?utf-8?B?cjh0NGphWXh2Z1VKcmlHUThSdE0rbFkzODdQc20yay9IRnNocVB1aU5peTM0?=
 =?utf-8?B?SzljZVA3elNRaUc2T0NEWjNuRWdUN2FGekVIb1FxS0ZZUHhuOFdGRXpXYVVJ?=
 =?utf-8?B?MUtUYXRRRldFbEV6NlFRS205Z2lLS1RrNkhPenh2T3VGMDFyWWVsQmhFbEhw?=
 =?utf-8?B?b1A4bS96eW1MOXc9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2021 23:45:48.1748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab63abd-5d97-4553-7797-08d8b8e684ce
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Uv9MVl4eu6t1CFJP1JVEqRU3u4d3oABoPhbYsezZTep7PfZWTpDayfvt++IVKb5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3510
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-14_10:2021-01-14,2021-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101140137
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/14/21 2:21 PM, Sedat Dilek wrote:
> On Thu, Jan 14, 2021 at 11:05 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>>
>> On Thu, Jan 14, 2021 at 1:52 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>
>>> Today, I have observed and reported (see [1]) bpf/btf/pahole issues
>>> with Clang v12 (from apt.llvm.org) and DWARF-4 ("four").
>>> Cannot speak for other compilers and its version.
>>
>> If these are not specific to DWARF5, then it sounds like
>> CONFIG_DEBUG_INFO_DWARF4 should also be marked as `depends on
>> !DEBUG_INFO_BTF`? (or !BTF && CC=clang)
>>
> 
> My experiments yesterday on Wednesday were with GCC v10.2.1 plus LLVM=1.
> There were no issues with DWARF v2 and v4 but v5.
> 
> Unfortunately, build-time is long here on my systems.
> 
> For now, I did CONFIG_DEBUG_INFO_BTF=n.
> 
> I have applied attached patch.
> 
> Is it possible to re-arrange CC depends?
> 
> [ /lib/Kconfig.debug ]
> 
> config DEBUG_INFO_DWARF5
>         bool "Generate DWARF Version 5 debuginfo"
> -       depends on GCC_VERSION >= 50000 || CC_IS_CLANG
> -       depends on CC_IS_GCC ||
> $(success,$(srctree)/scripts/test_dwarf5_support.sh $(CC)
> $(CLANG_FLAGS))
> +      depends on CC_IS_GCC && GCC_VERSION >= 50000 || CC_IS_CLANG
> +      depends on $(success,$(srctree)/scripts/test_dwarf5_support.sh
> $(CC) $(CLANG_FLAGS))
> +       depends on !DEBUG_INFO_BTF
>         help
>           Generate DWARF v5 debug info. Requires binutils 2.35, gcc 5.0+ (gcc
>           5.0+ accepts the -gdwarf-5 flag but only had partial support for some
> 
> And adding text to help concerning DEBUG_INFO_BTF is no good these days.

Thanks, the above change looks good to me as well as the suggestion to 
add some explanation why disabling DEBUG_INFO_BTF.

> 
> BTW, if you do not mind:
> 
> Label your patches with "*k*build:" not "*K*build:".
> 
> Use "DWARF *v*ersion" not "DWARF *V*ersion" - everywhere.
> 
> One patch missed the label "kbuild:" (guess the subject has too many
> characters).
> 
>>From what I remember - but these are small nits.
> 
> Thanks for DWARF v5 support in Linux.
> 
> - Sedat -
> 
>>>
>>> - Sedat -
>>>
>>> [1] https://lore.kernel.org/bpf/CA+icZUWb3OyaSQAso8LhsRifZnpxAfDtuRwgB786qEJ3GQ+kRw@mail.gmail.com/T/#m6d05cc6c634e9cee89060b2522abc78c3705ea4c
>> --
>> Thanks,
>> ~Nick Desaulniers
