Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAACB406777
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 09:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhIJHG2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 03:06:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:25376 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231223AbhIJHG1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Sep 2021 03:06:27 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18A702Up014795;
        Fri, 10 Sep 2021 00:05:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=V8Br6EWsmqIGnmuX1GEvqNLhjvqvV/VLlQFQTrIvNxw=;
 b=XLkw3npjXFWJZ64EX/EXpII6mC/X9dp/WXWnxcW2c10djiwCQvNB8Am8pl8lRuzBwZRQ
 wGmQ3qhJ4Oz6s0RYUZH7nVP3gEutMX/hTeWayB3Xq2gTth7JtyNO/7gpnBSXMpAhJxYI
 uzrd0udLiL48f9sNyIBXZZHF1uL0H0m5aAo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aytgdtjqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 00:05:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 10 Sep 2021 00:05:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZblZiZESkIyDK8KSerm9CNLvXeTa7YnTDj3j+w2OiYAynfq348BAwHCY2HPcDWwCDeh8UmGEKbGh3Qrl58d+Pa+yoj7o6zyApTZ6w9n8NHAY9B9GFSjmukmrR+BeaHrj9L3i56ilLcnNeIDWMpHFoW1Y6rRiL7u4S3Jd4DBZIooWS8d17S2V8qoFt6IqXu3wsonnSF5+wXU5tCUOaXw5r9BBVd/Zeh09C2UpQDeeOIl+GnCfqbyZ8Vpq2OayYsBwdWfbYpYUGaToBRb3Zu9iXlu7xq1yYBl8PGPzgM+5VH9OMhhgnzVIz6KTh+P19UtygV0UM9BJnBaRx5YlbmgTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=V8Br6EWsmqIGnmuX1GEvqNLhjvqvV/VLlQFQTrIvNxw=;
 b=mE3eFAlxHpgboTQtwd+xrS5O6HaQnFChBcebsL4lnQ2aqHiDpPBwldTG6W/wiN7/crCc9tPakQwDM7rGl1zX/wklAcfk34oG0TcvcGAbebX5wGyisW/VpFGaIlHoyrOZI/7fHOrFW/Osq5IoZbq4/7MHjqGTPV9UaEcPF6tfDncgAasqC9qq06k6LnxHyG4/bEAdD4VPZ0rXUlJM4diJS8PMBOvUWn0/+z+fvJBzsRGLcVhVw+z+zMCDOomMi8HkO2KML1DjSOCz2NKhP7prLLCJK9ceXmuV/TWaoXDG+L5ZPw1gUXLq/juX02wseZjO0Rsa5nBMf2ZvNO1heDuvxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4738.namprd15.prod.outlook.com (2603:10b6:806:19d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 07:05:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 07:04:59 +0000
Subject: Re: [PATCH bpf-next 0/9] bpf: add support for new btf kind
 BTF_KIND_TAG
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <david.faust@oracle.com>
References: <20210907230050.1957493-1-yhs@fb.com> <87a6kl8j1j.fsf@oracle.com>
 <e79ad277-9f26-1169-6e31-57d0b70d89d2@fb.com> <87o8915g02.fsf@oracle.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <03ff4fbd-b51d-2eff-303b-b36560d1b986@fb.com>
Date:   Fri, 10 Sep 2021 00:04:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <87o8915g02.fsf@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: BYAPR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPv6:2620:10d:c085:21e1::1064] (2620:10d:c090:400::5:9bc1) by BYAPR07CA0007.namprd07.prod.outlook.com (2603:10b6:a02:bc::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 07:04:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32efcaf2-8391-4db9-7aa5-08d974294dad
X-MS-TrafficTypeDiagnostic: SA1PR15MB4738:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4738999A2EF1F0DE0A54A986D3D69@SA1PR15MB4738.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXLdIRHCmTrWEgJGZSIec7KaSlJRKHsxgcWyOBETwHmCuHoVz6iF6YjnSN7VOzhrgMd0vUHO4xkkLOtIxDFdAsCu71oNYF5Oo8GxZjZ1B07ATITwSOIHRY1cwkzhKn4jzGKSzpzB/57O52/nGG2sCf/W3of+4B7fAjdnK2QTGHny8SMQA3rNaiD/rR3d07wzxGk+gq8Iye5txq7TgZU2atL+xiVHZ87Hn6ogstyrL6lAOjvkhL26DCFfe7bmI6GGInKqeNXkGWTXx6Np1TqN+PKCIS7mULr+SVMSmfF5Nj0KoJ+/AFDitXsHqGRMX4s9ljlPsyisovtrFUHB4jWus8HCWxgv/khTbyq5nGLTV+WHBR2ywZ8r8FcZBKffsjMyhTubt4gUxNHfZyZCxU40SZKHIXMwWutWmSyHOzDtU4ZiARXjhXdOalX3bhXxLrD7CHjkSCspB4w+9XY52p4WG4p8y7WbjifwP1AW/yE9jd7gryyM2uBzEgpY9fRpHumvvBHy+OkQW88bGV+W6S5TG85FHRPyZSTnIDXCHg790KuCilpc+r0zFugGcJFfX0Fxqfuy7WEE16YD+bLHNadTPNJVLFAS0jaEXqQ6SMchJpX7DRpy4TbQ5rvF2HNLoGlJmhjHZmWylbdpvhM1xudpkdcwhT8KGXUh4A+pYgYUmTFNJElJbuHHsHVDFBKQOXZ4fFAMwM7y1/HAd22oVryfCUZpD7s1ctPowjz8nLfQnni1SysliNNlil6KEUfijUOUwmnZNy/l7wmzQeG7/hbbh2+1Bmv7P0gJsRf5t47lrV7uTAd20dZbhr7orksPaYrlX1cXH3qmpwRzrL2E/MYTTdNQCYnZBA/Y77gyvmcK7Ag=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(8676002)(31686004)(66946007)(54906003)(8936002)(5660300002)(2906002)(66476007)(478600001)(66556008)(4326008)(83380400001)(38100700002)(31696002)(36756003)(966005)(86362001)(316002)(6916009)(52116002)(53546011)(186003)(6486002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekxXeHRlOGdsOEhENi9ZbmZYZlNJODJneUFTSGQ3Mlh4Vk1SWTBnRis4dzdj?=
 =?utf-8?B?N1hNZEJvSkRxYzFybHJKVFc5NnFkNGwzVHBpQlp2YXB5TndsN2N4NS91a2VV?=
 =?utf-8?B?cVlmczVyZ01vNGYzb1hTZnYyeGtpbFVWa1hrZ0FUeXdOd0s2QlN3bUVzVWo2?=
 =?utf-8?B?NkxDb05aS3N2ZFVPbWZpaWVaVGZSSUpCOU5FVWlZUU1vK2hOV2gydnUwTzh0?=
 =?utf-8?B?aEVIanRxb1F4T2x0MjZpdnBDdWVEVXJlaEhPdkRJdTZCQmpxUVdTNWtFTEhH?=
 =?utf-8?B?cXhZY29vc21EN3M2KzY2UDFJYkdxQUg3Q1gyNDNRcHQ3Y05MTmc2TmU1bThn?=
 =?utf-8?B?amtUdEFLS29MQ2dXTVZ6d1pTUGt6YkJGTGpaNDF6d3g4eGJVb2UyR0I0d0Iv?=
 =?utf-8?B?VFFha20wZU5SVy90VTNzb05nU2NRbWVkUmt5MUpZUFdBdGt2WHAvb0ROTlNZ?=
 =?utf-8?B?ZmRrdHlrRWhRN01ZQTAyeVo5cDNuZGg3a045bDk1c3JxckU2UWRmc0YzNlNt?=
 =?utf-8?B?Zzh1anR5Qi9RTy9lanpqcGFTcEFHNm5YSlp2b3VJckRWdU1LUnZCQ2NwcE83?=
 =?utf-8?B?ZGZySHVHd252NHFoT0RVRTNFR2hYMHh5MnZybjBFRitmbTVrUFJQRHY3Z0hq?=
 =?utf-8?B?ZmgxbWxOQTBjdVdpR1VrK0FaL1RXUTNnTStFd2o5c1QveDU2Q0VZRkpnK3dj?=
 =?utf-8?B?b3A5Y0RiOW9HT0VjTHREbnErME80b3ZGN1U5eGNCVG43ZXp6UE40TXZTVnBF?=
 =?utf-8?B?T0xVa3VVNHRhYVpUalEwdjQyR00waEd1M0VGZ2JLZjBUYms2Z0VzUjEyWGRO?=
 =?utf-8?B?UDBCNjIzUmRTQmQyN0w5SjhQYVBMdFl0c1pTZG5rVUpieWpIZUtpVEhJQ0VB?=
 =?utf-8?B?a01aQmhGUG9HY0VXVnlucm9yQzFmUVVlMWs1bTRQOGVJdUIxcGRnU2pvZVpt?=
 =?utf-8?B?b0xQZGxMVUduNkthVEt2TjdQR1YvSGhRRkpzcXFTYnNoWFV6TkpUWHpWdmxs?=
 =?utf-8?B?LzM1eWt1RnNJRGxWSzQ5Ti9qRk1vUXZXTisvQU9jWm9icVRBa3hjL2pPRlpV?=
 =?utf-8?B?Njl3N2pOdGhvalZRY1pGamNsbytNNGkrRlU0RnRjMFJVdUNlbXdOckhMT1F0?=
 =?utf-8?B?MVhCK3ZxQWtzOE11eWRTWURCWG1VZG5QVCsrODB6TGQ4NzVWYk0vNmVyemhv?=
 =?utf-8?B?Zk1DNTNMR3g5djFZQ3lqVmtoTDk4ODFVOE55L2RZUVpOTTVHelA5Wm5ucnNE?=
 =?utf-8?B?bk1oNFNKMWVxcnFWT1JPNHV4aitUNWRBQy9QWUowUE9yQ09ySWZGNzIyOWds?=
 =?utf-8?B?Y3dudXN4bWU2V1pLMks3YkcwWUp6Q2FwR3U1dUpEckJXOWJ2S0ZmblpwT2lX?=
 =?utf-8?B?MlVCYTNERHB1eHI4Mk9MYjhDUnpyNjlpcXQwQ29pSVgrYVVGQUVJbFVlWk1s?=
 =?utf-8?B?SzhnV1FmOVdwbmoxOWxTbFhuZGdWSDJMRyt3dWNlUXlSNTFqckJ2bWJsam4x?=
 =?utf-8?B?RkdteHpMZ3I0MUxDb1dmOVVORVpHSEhTdUJsSkJKOVhyRGVzUkpXdE11U3Ez?=
 =?utf-8?B?Z1JsTXQweE50QW1idnVzZ0Q5WjdPZmxvYzloVGw3QnlGaFUzTDFGalFnczZx?=
 =?utf-8?B?M1lCVTRiV0N1UXJFZ2FIVncvWEhyKytRNjhpdHo2UjNJMGdsRk9FVGgyOTRj?=
 =?utf-8?B?cWIyQ2JjTWovWm1pWDFJcUZKM1ZRcTBXZzAwVnZtajhmRWpPS0RRWlFFRzRX?=
 =?utf-8?B?Q2V1anJlVE5KZjJhencwQ3R5QmpSdGhKNEdCVFdMQ0VXUTFoUjcxdzRKVXov?=
 =?utf-8?B?UjNxeWZZVFExWElxbzhXdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32efcaf2-8391-4db9-7aa5-08d974294dad
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 07:04:59.6700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAC4KQ2HH6YWSwoA8MSUAjAraSWDo4qYOqsHX34WwqHJIu21bvNrhYBjJa6TRv2M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4738
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: OFBi75IRvbl58J3OEvRymTZWIsdVLe9k
X-Proofpoint-GUID: OFBi75IRvbl58J3OEvRymTZWIsdVLe9k
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-10_02:2021-09-09,2021-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109100043
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/9/21 7:19 PM, Jose E. Marchesi wrote:
> 
>> On 9/9/21 3:45 PM, Jose E. Marchesi wrote:
>>> Hi Yonghong.
>>>
>>>> LLVM14 added support for a new C attribute ([1])
>>>>     __attribute__((btf_tag("arbitrary_str")))
>>>> This attribute will be emitted to dwarf ([2]) and pahole
>>>> will convert it to BTF. Or for bpf target, this
>>>> attribute will be emitted to BTF directly ([3]).
>>>> The attribute is intended to provide additional
>>>> information for
>>>>     - struct/union type or struct/union member
>>>>     - static/global variables
>>>>     - static/global function or function parameter.
>>>>
>>>> This new attribute can be used to add attributes
>>>> to kernel codes, e.g., pre- or post- conditions,
>>>> allow/deny info, or any other info in which only
>>>> the kernel is interested. Such attributes will
>>>> be processed by clang frontend and emitted to
>>>> dwarf, converting to BTF by pahole. Ultimiately
>>>> the verifier can use these information for
>>>> verification purpose.
>>>>
>>>> The new attribute can also be used for bpf
>>>> programs, e.g., tagging with __user attributes
>>>> for function parameters, specifying global
>>>> function preconditions, etc. Such information
>>>> may help verifier to detect user program
>>>> bugs.
>>>>
>>>> After this series, pahole dwarf->btf converter
>>>> will be enhanced to support new llvm tag
>>>> for btf_tag attribute. With pahole support,
>>>> we will then try to add a few real use case,
>>>> e.g., __user/__rcu tagging, allow/deny list,
>>>> some kernel function precondition, etc,
>>>> in the kernel.
>>> We are looking into implementing this in the GCC BPF port.
>>
>> Hi, Jose, thanks for your reply. It would be great if the
>> btf_tag can be implemented in gcc.
>>
>>> Supporting the new C attribute in BPF programs as a target-specific
>>> attribute, and the new BTF kind, is straightforward enough.
>>> However, I am afraid it will be difficult to upstream to GCC support
>>> for
>>> a target-independent C attribute called `btf_tag' that emits a
>>> LLVM-specific DWARF tag.  Even if we proposed to use a GCC-specific
>>
>> Are you concerned with the name? The btf_tag name cames from the
>> discussion in
>> https://lore.kernel.org/bpf/CAADnVQJa=b=hoMGU213wMxyZzycPEKjAPFArKNatbVe4FvzVUA@mail.gmail.com/
>> as llvm guys want this attribute to be explicitly referring to bpf echo
>> system because we didn't implement for C++, and we didn't try to
>> annotate everywhere. Since its main purpose is to eventually encode in
>> btf (for different architectures), so we settled with btf_tag instead of
>> bpf_tag.
>>
>> But if you have suggestion to change to a different name which can
>> be acceptable by both gcc and llvm community, I am okay with that.
> 
> I think the name of the attribute is very fine when BTF is generated
> directly, like when compiling BPF programs.  My concern is that the
> connection `btf_tag () -> DWARF -> kernel/pahole -> BTF' may be seen as
> too indirect and application-specific (the kernel) for a general-purpose
> compiler attribute.

For llvm, btf_tag implies implementation scope as it *only covers* btf 
use cases. There are some other use cases which may utilize the same
IR/dwarf implementation, but they may use a flag to control or different
attribute. And this has been agreed upon with llvm community, so we
should be okay here.

> 
>>> DWARF tag like DW_TAG_GNU_annotation using the same number, or better a
>>> compiler neutral tag like DW_TAG_annotation or DW_TAG_BPF_annotation,
>>> adding such an attribute for all targets would still likely to be much
>>> controversial...
>>
>> This is okay too. If gcc settles with DW_TAG_GNU_annotation with a
>> different number (not conflict with existing other llvm tag numbers),
>> I think llvm can change to have the same name and number since we are
>> still in the release.
> 
> Thanks, that is very nice and appreciated :) I don't think the
> particular number used to encode the tag matters much, provided it
> doesn't collide with any existing one of course...
> 
> However, there may be a way to entirely avoid creating a new DWARF
> tag... see below.
> 
>>> Would you be open to explore other, more generic, ways to convey
>>> these
>>> annotations to pahole, something that could be easily supported by GCC,
>>> and potentially other C compilers?
>>
>> Could you share your proposal in detail? I think some kind of difference
>> might be okay if it is handled by pahole and invisible to users,
>> although it would be good if pahole only needs to handle single
>> interface w.r.t. btf_tag support.
> 
> GCC can currently generate BTF for any target, not just BPF.  For
> example, you can compile an object foo.o with both DWARF and BTF with:
> 
> $ gcc -c -gdwarf -gbtf foo.c
> 
> or with just BTF with:
> 
> $ gcc -c -gbtf foo.c
> 
> Binutils (ld) also supports full type deduplication for CTF, which is
> very similar to BTF.  We use it to build kernels in-house with CTF
> enabled for dtrace.  It is certainly possible to add support to ld to
> also merge and deduplicate BTF sections... it is similar enough to CTF
> to (hopefully) not require much work, and we were already considering
> doing it anyway for other purposes.
> 
> So the proposal would be:
> 
> For GCC, we can implement the btf_tag for any target, but impacting only
> the BTF output as the name implies.  No effect in DWARF.  Once ld is
> able to merge and deduplicate BTF, it shall then be possible to build
> the kernel and obtain the BTF for it without the aid of pahole, just
> building it with -gdwarf -gbtf and linking normally. (We know this works
> with CTF.)

This should be okay.

> 
> For LLVM, nothing would have to be done in the short term: just use the
> DWARF DIE + pahole approach already implemented.  But in the medium term
> LLVM could be made to 1) support emitting BTF for any target (not sure
> how difficult would that be, maybe it already can do that?) and 2) to
> support the -gbtf command-line option.
> 
> Then the generation of BTF for the kernel could be done in the same way
> (same build rules) with both compilers, and there would be no need for
> conveying the extra tags (nor any future extensions to aid the verifier
> on the kernel side) to pahole via DWARF.  Pure BTF all the way up (or
> down) without diversion to DWARF :)
> 
> Does this make sense? WDYT?

During discussion to implement btf_tag attribute, I actually have a 
prototype to emit BTF with non-BPF targets in llvm.
see https://reviews.llvm.org/D103549
But since we get a simpler solution to emit the info to llvm, so we went
there. We will keep this in mind, it is totally possible in the future
we may start to directly generate BTF from llvm for all architectures.

