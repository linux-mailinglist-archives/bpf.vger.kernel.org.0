Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4FB3563DB
	for <lists+bpf@lfdr.de>; Wed,  7 Apr 2021 08:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhDGGX5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Apr 2021 02:23:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43946 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230426AbhDGGX5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Apr 2021 02:23:57 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13765MBu028457;
        Tue, 6 Apr 2021 23:23:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=JrksJuJBqphd+1xyz9PhonG54IGG6v54GOlIR7NxU2M=;
 b=m0hw7v1lIt+ZcHbPZ9iyp7RpVh6jXM+4p8rrgwdYJoyPtCefQsrO+s//ZQxSbM+hnkBg
 9Z/FDp8p4g83g++S9WVxznFt1/A8PdB0l/3ebFPXp5MHAkgfKp1Iw2flJqXriZ+57Wok
 IbMjhDDJgKdqm4Qe472uhgbNdT37Q93lP+I= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37rvbe3ugr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 06 Apr 2021 23:23:33 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 6 Apr 2021 23:23:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjvQM29YWMcLgrhNtW/ny5fw+jVKbRkw1Aig9rv6tdhmRtNwrIqJtS+kNueBBk4VFWUYLEhQ9Fh9F4jF9DvGI21FMLYzkHEsFHaFcb/YSjd1b7OEfFwZUPGUvUgniy+Dwk0KxUjuK78WnfVK1XrE/IVbup7voFh1lNQOfdk49Cft18uX2xgUGdB1kgpfYndoH9kkeLjhF3CcwgfNVP7PS41RB6lyfGc5a/RQyKIrvmx3YWHTflIQ4JqDKUpppfWx0Qlb7k7+0Yx07LC7WxAJ/HIbM4Wt7rkf5fQO+RXsbf/gMwGlI+iaVfb2OnsXVRGf6H+XL8T/HFpPXXTpFVugEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrksJuJBqphd+1xyz9PhonG54IGG6v54GOlIR7NxU2M=;
 b=obV3IEufnGZqT8mxOAilZBV8dky4U0lNZfJTJSIZiNR0j+7M0w3g2zt/RaYKFaBtnhuluJ9i7DmtvJ+d5+9A3eH2Ug9Rus7cXBShZ09gsAo0iifIULisyv/F8jgKyz1X1uREjhAS9cs82QGkDqYm18ed0A8FM0fMPce+Kjmy56LOz7ER6cwqGwSH8/bQ+H9gMqNAlc42FD+wbaQWaBIuwpGUEcKq4vChy/eViSNZEcvKjMFXRpya74y0+QIvLvX2DQQPzIJXOPYBf/o3i65mI3AgRBXD/kQ6Q4ujiB1JWCb2luFInLsvhSfHLcLnSY+beFz+K6YlxgSL59b7oB/7oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2160.namprd15.prod.outlook.com (2603:10b6:805:9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 7 Apr
 2021 06:23:31 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 06:23:31 +0000
Subject: Re: [PATCH kbuild v4] kbuild: add an elfnote for whether vmlinux is
 built with lto
To:     <sedat.dilek@gmail.com>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        bpf <bpf@vger.kernel.org>, <kernel-team@fb.com>,
        Bill Wendling <morbo@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20210401232723.3571287-1-yhs@fb.com>
 <CAKwvOdmX8d3XTzJFk5rN_PnOQYJ8bXMrh8DrhzqN=UBNdQiO3g@mail.gmail.com>
 <CA+icZUVKCY4UJfSG_sXjZHwfOQZfBZQu0pj1VZ9cXX4e7w0n6g@mail.gmail.com>
 <c6daf068-ead0-810b-2afa-c4d1c8305893@fb.com>
 <CA+icZUWYQ8wjOYHYrTX52AbEa3nbXco6ZKdqeMwJaZfHuJ5BhA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <128db515-14dc-4ff1-eacb-8e48fc1f6ff6@fb.com>
Date:   Tue, 6 Apr 2021 23:23:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <CA+icZUWYQ8wjOYHYrTX52AbEa3nbXco6ZKdqeMwJaZfHuJ5BhA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:e6b7]
X-ClientProxiedBy: MWHPR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:300:4b::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::10dc] (2620:10d:c090:400::5:e6b7) by MWHPR02CA0007.namprd02.prod.outlook.com (2603:10b6:300:4b::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Wed, 7 Apr 2021 06:23:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a800f946-a2fb-44bc-98c7-08d8f98da9e0
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2160A5A61452AC818FD7C43BD3759@SN6PR1501MB2160.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U3M5X6i5BFrL+xLVgUlHFXqa9rJpLX/sGsJjWuEYKQXvteS5NWD46D7zF3jqjRPrNpYAhaFTdl/GpDpNekAGhj6gg/wAT00M1ZDi7u5TYXAuRWl+2LLFPB2KudtVnhQFrqqF+t8ZqJsKrCc5bqgR8Y5Fy31UX072Nddx1A+TuCjS9/L8Ps637K0Jr2vbEZ3/9IF8Qdl1meNvw1ryl4DKniAa5FuYh9u5i0mQhxNc4hCFBJjmEtcViazmBjCAK86Dh7/+IU6umBTGYXxhOvzCz9ceu2W8mJYC8GTXvXwNf2VFdLwqPaDZhaCJ2y16Sr3yeW9IB4WglheZXLEhmQl3yAGL7sdmvJ2FCVeGjKMniKgxD5nyy+XxkgugCcLfc6IMyZfH78AX3jx026H9+jss+9xJD7RDZPYCgypm6MxU8ReoB+x0rbZoIsnZgnK8/OPU7RH9uCrztcDYvyOUPamJXAAiZPkUz2c+pieVpISPRsHIhyOCMUGnonGEClZFuE9vQ4OeGPaFv2/44mKqVyAyQ6/GUXHOcx0Vux9zJuRUCpyVkB2w8kzinzYIJgv6mKvi9dYNYv8SX+ESaA9i44hCNMJLntS4gswfZqeGBt6hGyfwcgu0SvgPZUd76vfdH2/C79cAdV55y8cinEahqyaO9O/Uuip0HMn5ANxEMbDIjZKYgczGPinsheBDK5oB9E6QljYNAtRLWnjzUs0iFzuwTUIWM4x6kYTKTPZOAft4BGe7QtBpddywx5HgALzs+T5q+vqoAi0cv6xKIKYMabq3qI8j7czyhlZXY9xVGzNf39k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(376002)(346002)(396003)(6916009)(8676002)(8936002)(6486002)(38100700001)(478600001)(31696002)(83380400001)(2906002)(86362001)(316002)(54906003)(66476007)(66556008)(5660300002)(7416002)(36756003)(52116002)(31686004)(4326008)(16526019)(186003)(66946007)(2616005)(966005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TWxmTUJvWEtEQkR6ZE5BS0NmTGoxem4xZmJzaVZVNnJMcGNGNjVDd0lsZHRP?=
 =?utf-8?B?TGwxRE1HK0pxQWJzNU9aQVBxVFU5ZVNUMDBiSWN4TlRoQ21NZ1QvQ0xFN3h6?=
 =?utf-8?B?ZWp6Tmx5Q09NWXhUR3k2dldLRXJGK2JqMWg3eWEzRGVxRk9KSmx2OHZtdjVQ?=
 =?utf-8?B?cmF2aEM2UjBTTFF1UTJ6RjY0bWEzbzZydlZDSjU1Y2NYTWpBV25vK1RVaG9B?=
 =?utf-8?B?akRxbW45U1B4eEJ3dnJQbTFVL29EY1l4LzJ5Q2M1cUdDRVFvU3V2NjhhL0Mr?=
 =?utf-8?B?TFhmY2VBNC9uUmZESDhJZ1lEbUxJRm9EcnhKR0cvU1hPaXNjTCtPMVp1MXZh?=
 =?utf-8?B?YVZNS0tMNGVYdDFONVFuMldYclhuSnpGeW40YmNrUXZnSzNmdmZKWUo5L1Vn?=
 =?utf-8?B?QTVoQzd2OWpucTF4VW5KS3hkVi9LeUdXTWticXBqcmpaVGNIUlhZMEFLVWhL?=
 =?utf-8?B?bm83dEV4WUF3aHljS1dyenczVDJGcDdKdFRFVUN2Yk1hQlBLVExsN1M1L0NK?=
 =?utf-8?B?MEVXbjBKNFBhUmQ2RGhPNTdGcVNmZUFLQVJVbno4MDhsUWs4SXI4b2dYRXBs?=
 =?utf-8?B?WlZsWXJRSHdYQ2ZCYkZtQ3JRUkRCOS9JTExvSlRpd3RaTmtKbGFYYmFkVlBu?=
 =?utf-8?B?OVlGMVNwUTNINDFuSTZNdjV6Wm1hUTJpbEVHUSs3UVE4WkN4bHpOSmdxazZV?=
 =?utf-8?B?aEhMbnFPcjJyZVhTSmhVZHlyL2xGM011Wk9EdVVXblZ3Y05wWFlxTkJmSEVE?=
 =?utf-8?B?bjdCc054cUZwbEVyUlZDd0pVcVFGTm5hMWxGVDl2U3UxcWFmMUlqcHhZTzZs?=
 =?utf-8?B?Y1ByOG42cUQxaUt2Vm92UGpEZy91eVZjdTUxYnF2VVM5U3AxamlXdlJKQTJw?=
 =?utf-8?B?WkpVazh6eEM5VlE2UGFJZmovSkVoU0F0SEJ3cGsrZkM3TTdKbmRVZUFPTlRV?=
 =?utf-8?B?aFZNZ2JKQXg0TmZrWGVSajJiR3RibkIvOGFkTHVpdTNBMU5VR1BndlpYdjNL?=
 =?utf-8?B?QXpRQ2RuUmVSejBhelpvT2VlbUtDaVFxVXJGaElJb29INkN4SGJ1TmhScW1F?=
 =?utf-8?B?b2p4WTdmR1lzMEVEVlZ5cXkrMXVEUkx6NWY4K0FaSVcrOVdLOFFwdmRIYUVO?=
 =?utf-8?B?L0N6dWpjRC9acUNROHlBNVY3ZXFEaEtFemNLbXlzYjV4MkFyRGhrdGt4ekVT?=
 =?utf-8?B?YUUyaVhpbUxyOGIyWGRicHNMZFMxazVVSFFieWU4bnpVQmw3VHZ2RFpEUm5k?=
 =?utf-8?B?clJESkk3d0wwTWdmcFFnODBFbFBweDRXdHpqbGZyeTczVmFGSjVIVFdna3p5?=
 =?utf-8?B?cnVhV1YvbnlpY1hHTG9XL1VQaUYzMS9jTzRwQ3pCSlMxRnRCRmQvdFY3LzZs?=
 =?utf-8?B?cHhIdklnTWV2WnFncVNZR28xZFBFWld4R04vT3cwNGV6Y2NjbmR1NVc4dFRB?=
 =?utf-8?B?SmZYTlJzY2hMTEY1ZjlHUzE4czBzWXpMZUlieFR3QkxzK0lVUjVuMDQ2ZEVk?=
 =?utf-8?B?VXB3WXFsZDJGeVArUmg3L3RTU3JrZE1jL2MyZWtBTTdpaVVkeCswd3NFNE00?=
 =?utf-8?B?UjAxRjlTd1F0Z3FZank3cjJtWlpHY0FSekhJZFhBQkxNUVRxT1VYMnlweTNn?=
 =?utf-8?B?c0xGTzd1dnFTb1BPQ05Od1puTGVFbzB1NjhiVTdUMFN3RE9HZWdYSnhraEZy?=
 =?utf-8?B?bVNmYnpHRkdwZzNGSjkzcjJrZTVMY3UvWDNuUlRtUVpONlJsMFBtMms0NzFl?=
 =?utf-8?B?MzgrZTE2d1lVMFdHcEVtdVkrQ3ZrQ1Z0NHREUVRnRzdRUFhUay96MEtxdm9p?=
 =?utf-8?B?N0dYUm1ibjIrdGpvcjVTUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a800f946-a2fb-44bc-98c7-08d8f98da9e0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 06:23:31.0727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgmTgoXX3t8UmCaVWlNYlRlYSw0EE/YmTjG7sE6XwwYK5L8ds9vClYwt2I+C9XkY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2160
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: taZ1e7e3fUmL6n5e2x-O-u4S86l15jnM
X-Proofpoint-GUID: taZ1e7e3fUmL6n5e2x-O-u4S86l15jnM
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-07_03:2021-04-06,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070045
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/6/21 8:01 PM, Sedat Dilek wrote:
> On Tue, Apr 6, 2021 at 6:13 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>> Masahiro and Michal,
>>
>> Friendly ping. Any comments on this patch?
>>
>> The addition LTO .notes information emitted by kernel is used by pahole
>> in the following patch:
>>      https://lore.kernel.org/bpf/20210401025825.2254746-1-yhs@fb.com/
>>      (dwarf_loader: check .notes section for lto build info)
>>
> 
> Hi Yonghong,
> 
> the above pahole patch has this define and comment:
> 
> -static bool cus__merging_cu(Dwarf *dw)
> +/* Match the define in linux:include/linux/elfnote.h */
> +#define LINUX_ELFNOTE_BUILD_LTO 0x101
> 
> ...and does not fit with the define and comment in this kernel patch:
> 
> +#include <linux/elfnote.h>
> +
> +#define LINUX_ELFNOTE_LTO_INFO 0x101

Thanks, Sedat. I am aware of this. I think we can wait in pahole
to make a change until the kernel patch is finalized and merged.
The kernel patch may still change as we haven't get
maintainer's comment. This will avoid unnecessary churn's
in pahole side.

> 
> Thanks.
> 
> - Sedat -
> 
> 
>> Thanks,
>>
>> Yonghong
>>
>> On 4/6/21 12:05 AM, Sedat Dilek wrote:
>>> On Fri, Apr 2, 2021 at 8:07 PM 'Nick Desaulniers' via Clang Built
>>> Linux <clang-built-linux@googlegroups.com> wrote:
>>>>
>>>> On Thu, Apr 1, 2021 at 4:27 PM Yonghong Song <yhs@fb.com> wrote:
>>>>>
>>>>> Currently, clang LTO built vmlinux won't work with pahole.
>>>>> LTO introduced cross-cu dwarf tag references and broke
>>>>> current pahole model which handles one cu as a time.
>>>>> The solution is to merge all cu's as one pahole cu as in [1].
>>>>> We would like to do this merging only if cross-cu dwarf
>>>>> references happens. The LTO build mode is a pretty good
>>>>> indication for that.
>>>>>
>>>>> In earlier version of this patch ([2]), clang flag
>>>>> -grecord-gcc-switches is proposed to add to compilation flags
>>>>> so pahole could detect "-flto" and then merging cu's.
>>>>> This will increate the binary size of 1% without LTO though.
>>>>>
>>>>> Arnaldo suggested to use a note to indicate the vmlinux
>>>>> is built with LTO. Such a cheap way to get whether the vmlinux
>>>>> is built with LTO or not helps pahole but is also useful
>>>>> for tracing as LTO may inline/delete/demote global functions,
>>>>> promote static functions, etc.
>>>>>
>>>>> So this patch added an elfnote with a new type LINUX_ELFNOTE_LTO_INFO.
>>>>> The owner of the note is "Linux".
>>>>>
>>>>> With gcc 8.4.1 and clang trunk, without LTO, I got
>>>>>     $ readelf -n vmlinux
>>>>>     Displaying notes found in: .notes
>>>>>       Owner                Data size        Description
>>>>>     ...
>>>>>       Linux                0x00000004       func
>>>>>        description data: 00 00 00 00
>>>>>     ...
>>>>> With "readelf -x ".notes" vmlinux", I can verify the above "func"
>>>>> with type code 0x101.
>>>>>
>>>>> With clang thin-LTO, I got the same as above except the following:
>>>>>        description data: 01 00 00 00
>>>>> which indicates the vmlinux is built with LTO.
>>>>>
>>>>>     [1] https://lore.kernel.org/bpf/20210325065316.3121287-1-yhs@fb.com/
>>>>>     [2] https://lore.kernel.org/bpf/20210331001623.2778934-1-yhs@fb.com/
>>>>>
>>>>> Suggested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
>>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>>>
>>>> LGTM thanks Yonghong!
>>>> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>>>>
>>>
>>> Thanks for the patch.
>>>
>>> Feel free to add:
>>>
>>> Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v12.0.0-rc4 (x86-64)
>>>
>>> As a note for the pahole side:
>>> Recent patches require an adaptation of the define and its comment.
>>>
>>> 1. LINUX_ELFNOTE_BUILD_LTO -> LINUX_ELFNOTE_LTO_INFO
>>> 2. include/linux/elfnote.h -> include/linux/elfnote-lto.h
>>>
>>> - Sedat -
>>>
[...]
