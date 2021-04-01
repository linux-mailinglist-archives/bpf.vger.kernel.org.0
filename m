Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE723520BE
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 22:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbhDAUus (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 16:50:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1756 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233588AbhDAUus (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Apr 2021 16:50:48 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 131KjEcq029356;
        Thu, 1 Apr 2021 13:50:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=9zkAP9KyPvOCZG2JAqIz5XXFAZPwwW7CSpcieDHQ7bc=;
 b=PBelZpDI3ljjAtP6CzwJKF2eyGWbFuwzgFOHAm7O9d2yka0kYYUoG2hF0ksciohO855V
 ib7ZYaokBPqNbk+PcQUdhhy0e730aO1sGkI5JSQvfmllzgiQl6R6x+llqP0y+2ODrpRG
 hYi/8XJNaZR2B2kqiM6mLqs1u/uTintWnE4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 37n29ne9q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 01 Apr 2021 13:50:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 13:50:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miJdtFvAZyOsLl8lFLnfnJM9eg5sHjbyeLpc8R7QSf1qzr8LuQOzZS+TW+UohnsN3wN+YQJhJCPNa1cKXYo1LKCaFobPwydse9xzaGP/L2RGmYDt8nci8uc+ormSGLKSPsc+RexMCksruIOqtxVvrvXxFHAJftKugcN6M5TINomlWcZE7WJhK94frXtsYSrIgbBbjaXN4yExFMEs9kRE+kVYJMukrsOEfk6U/g9RPYhj4Mlbr4Set1AxtMFqL/VBVWKdV6nqjuzBbmm9emkGk06FvdCf2TwFlb3kJTTDYH/YTfromZPDDJMsyn4PgbR65RX2JHCVL9xvBUnVB6qV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zkAP9KyPvOCZG2JAqIz5XXFAZPwwW7CSpcieDHQ7bc=;
 b=FRnYCDaE/GnP9/HJGPLiuwcNbx3M0mdFEcJDMyyWNioS6NaGKz46inW/nYhqtqAZM8G4n4kIWyjztpPBqrR0PdL05uEu+Mn4nNFk/kdekkojo6Tv0uuai7W8GIcCVSAchMrgJEX/U1xpfFpEoPH9sEk73GCS17uKYkJqmDbjavsbtwFy+XNL6By2CwoeoN1FU1JITHAyoPI9W/PTKD/yo8dM/rEtgVyrgr7hI54tm0r8tinBdw/Z1hUkZh5mt/ZOX4OvLiP5jS0jrnRao8vl+zNeM00NUGotsUHB7GXh8cl5QzYB353EsM+TcHHQEtt3NHsRpGkPji2vHuGIfBM0AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: markovi.net; dkim=none (message not signed)
 header.d=none;markovi.net; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4660.namprd15.prod.outlook.com (2603:10b6:806:19f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 20:50:34 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 20:50:34 +0000
Subject: Re: [PATCH kbuild v3 2/2] kbuild: add an elfnote with type
 BUILD_COMPILER_LTO_INFO
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        bpf <bpf@vger.kernel.org>, <kernel-team@fb.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
References: <20210401012406.1800957-1-yhs@fb.com>
 <20210401012417.1802681-1-yhs@fb.com>
 <CAKwvOdnDnO4ye5GToe04L8B4Tk+Ls6tAAoMVoi8LoC4gRLyLYQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f6169e57-48aa-b36f-e811-668beffa6608@fb.com>
Date:   Thu, 1 Apr 2021 13:50:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <CAKwvOdnDnO4ye5GToe04L8B4Tk+Ls6tAAoMVoi8LoC4gRLyLYQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:fb66]
X-ClientProxiedBy: CO2PR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:104:1::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::17eb] (2620:10d:c090:400::5:fb66) by CO2PR05CA0095.namprd05.prod.outlook.com (2603:10b6:104:1::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.9 via Frontend Transport; Thu, 1 Apr 2021 20:50:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64ed7cd1-15d1-4e48-2442-08d8f54fcbd3
X-MS-TrafficTypeDiagnostic: SA1PR15MB4660:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB466038082FC635F1E548E335D37B9@SA1PR15MB4660.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9TvwJVBnXbQt1LpIjDTkA7aympvLovTh532E9ez9ZqwW6m1RhSVHkxZ2GWbkLJr4/B69QOj2jnbA3sFYM87mgtAFz9um6CS45yIbUBlPyTiySbqKPsVIl8vFskgkuesfcv93jPtWPy3aSWN0bvDy+vjcILTiaB6jAjkTQhhs8wGtte7rvRMxb69xeqlluhHXNpwBsr6OluqdWfpBAcriRUQVtP0nWmya7nq64lFsXMb5W1araayoakH407JZnsQy9EnbjW8PMMnVecE/CAIm01bxMQJJZc9DvaJxGF8QjX5yHCquWyUPz5qp+V3AjfGmDcyc84MeBFT2YK9O3HOg1OL/c2jbc0iGUJT6YMcvRcLACdsJxVLYktLNnIcPHjpeAgJCSOljHgKr0sGoFyH/KWtuvyH97hJZGgthwtXFKlPcmvqav1HxH9nwq+v5R0GLcm4zREqDU5bwNLq6on+8ptDJKdpCECArLQUs4wKYEYvgvM5t6TsDW9pyQ4ygjDoLH9fVj9EVQ9vjBkHHQOwKWF4AccsHjEPoPrCqrENEUjA/ZQJt7U0lnW3pHnujRPuba8PMc7Iwekf+F9b6ydXDnSjlGZRJGdzAiB0UB4AdwR+FqsYmmPUiAqr80SboufGqsjDFRnrJAy/PkFuZJ5l6+0rtE7hoXsK0n7ViEFoqrJNwYuBhw8OrGEm7QjBiOtuK0wbkOROD7AI+WRUaWT285CQVISspdWw9l0BlD8qzcTzBdTG/6xct6axJQW1qcr+iTx+UnDe6MJ2a+s5hgaXkyU4mMn6rvOE1N7nKouaJz0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(396003)(346002)(39860400002)(16526019)(36756003)(2616005)(186003)(6486002)(66946007)(31686004)(478600001)(316002)(66476007)(66556008)(966005)(54906003)(4326008)(8936002)(53546011)(86362001)(31696002)(83380400001)(52116002)(8676002)(5660300002)(38100700001)(6666004)(6916009)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bkdtSTNBem9Sa1VYM3B6NXp1R2JVcGhaNmhxcStXaFBUNTZSZC8ySWJ0Rit5?=
 =?utf-8?B?WGs4UmxHYU5lZVRLdDdCckc0djZaZ1BBMzQySWY4aHRFUmdSdzRndFcwWjB4?=
 =?utf-8?B?YUdtV1pEejZxOThDRHR4L05zZ01iNEVDSDZOWStxWitCNGJPZDRTVlZQQ1hB?=
 =?utf-8?B?alYxdmU1MWN4NHRlcUZBNjJrVm5SVUFKOXNOVVVBTnVMY3p1TDh6UjdDeTlG?=
 =?utf-8?B?Zkt3bm9obC9VNVZ3Qnk0bm0veWdkdE50Qk4yZmZrZHI4eW5RdTBNZFBtZHI3?=
 =?utf-8?B?YmN4d1pFOW4yY3VrK1owR0ovdWZ0OGc5eWFGaFBWcDh0MVQ5L0JZRFNhL0Rh?=
 =?utf-8?B?VU9TRDFBbzNZV21YcnFVWXNCaDdEUGZ0dVoxVWtOM01WTC9hN0t2aFlEVmh0?=
 =?utf-8?B?UnJLODBIbUs4WjR0RHRZNlB1OUhhbEZnRnVXSk5MRDhGdEpJdU5qblNZNzJz?=
 =?utf-8?B?YWtzYSsrT29BUlArNDZDWWp5V25QWDlHdWdtWlN0NXI2ekd3ckxyYkpvNVla?=
 =?utf-8?B?ZEIyN25MM0RKMEJZc05BV3A4dnVLL2t1ZFVoUFBOV0pFMktMbi9HUC8yTlow?=
 =?utf-8?B?a2ZEK1Z5QWJzQWcwdFpNWFlzRlVnMGhvYnVvb2FJS1NuekFDM0k4K1E4UUlt?=
 =?utf-8?B?QVhHUTFOdWpjNmRiY1R6eEpyZ3QzMzR2WEhWZGt5ZEUxUzhOK3ZOWkN6QmJq?=
 =?utf-8?B?c2Jxc3lQbFJLRVMyektUa0lEUGZjK1hueG00eFZMOStleHc2OXRFR2RwMDU5?=
 =?utf-8?B?RXM3dnlCcDR6T1RTaTh1dTlsZzN2MStYT1o1YnJVSTA3MjkrQXYrMlFQQnYx?=
 =?utf-8?B?bUtnS2FNNTNQaURZc2lNQ0crUG94NGpDSldCaWRJTEFCcjNuam0xYWorZG40?=
 =?utf-8?B?TkI0Sjd6Vm0wWHpYQVJDSWRxeTdEU2lmWll5ZFhQdkN2bERFSElyRkhzK244?=
 =?utf-8?B?R2Jua2JaWVluRHUwaTJUMk1vWExaQ0tObEMzbTJPNVNGZjcrWGl3WVlEZ05I?=
 =?utf-8?B?aG9lVXRKRW9DYmpFMG1RNUhMN0NJM0xtUk1xRDBBSTdMMDkyakRmcE5XWHE5?=
 =?utf-8?B?cU9NY3p0VkI1T2JTYjEyKzFPcGJvc01sMFVWM3pkb0wxZ1BkVk55djY3VEZ5?=
 =?utf-8?B?MHZ1L1h6OU5Jc2g3Zmt3THBoNjkwL053ZnRtMFJFbjR5YnEzaWlBLzJWK3VW?=
 =?utf-8?B?OTRtRUhFRmJHSHFoR0VNQTMzSGJncEp2UUZ6Z3VnUEsxVElSS3Y2cnJ5Tnlk?=
 =?utf-8?B?RWYzK2lSblQyT0FMTC9XUE9FemtneTgya2gyZjRjRFk3N3V5Yjh1NFRQZzQ3?=
 =?utf-8?B?cFN6RVg2T2ZEVEdiK1FLZ2FnbCt6TEJhWmZVcHJTQ0xkOWFBVW9GQXQ0NStw?=
 =?utf-8?B?R29tajA4R3hpQ0RpNG5sYkhkV1M1YWc0YmdLNE5aRFlBL25Ybzk1aldZWXpF?=
 =?utf-8?B?ZmNiZS9CV2lIRTdYeHhBSkpMa2pFRjFsV0RJSVh5N05kM21kK2NTYjd4Z24r?=
 =?utf-8?B?WlY3N3hTVDVJU29FL1lYMkNZdXRCRFlRSVhJZ05ybmlobFM1SDlBcnJ5TW1N?=
 =?utf-8?B?a0NyYUpJQ2F4MVJ0bUYvOExwQk9JcHBHdHJQTTFXbmZ1THBPT1VRRkh0ekZu?=
 =?utf-8?B?OGZhV1VlbTBKejIya0oxeXVrZGR2Z2JWaUVyMG9nSGc2WUN0eWJxaEhSdk5Z?=
 =?utf-8?B?ZWJ1L2tHbmlpYVd3bGhmcXhLQW9Pd2pKTitlZll4RktjWjBHbmpHR1g1RDRl?=
 =?utf-8?B?aTBCd3JWbzBzZzBZZHA1YnFuWjhkajFMcEs1dWVWMlZQTEltN09tNDJvVGZy?=
 =?utf-8?B?bEZvME52ZEFybGxQVVVxZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ed7cd1-15d1-4e48-2442-08d8f54fcbd3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 20:50:34.5118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZ1lYOQkKNyMFh9FQg3HsfiCZ+KcKz2CRjdctF6mRqC5OSG4Zv5o7ZqJWCnUc2SB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4660
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: WhWToYjQBVFHPRzH-pyN4DeDp7JhvHzQ
X-Proofpoint-ORIG-GUID: WhWToYjQBVFHPRzH-pyN4DeDp7JhvHzQ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_13:2021-04-01,2021-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103310000 definitions=main-2104010133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/1/21 11:28 AM, Nick Desaulniers wrote:
> On Wed, Mar 31, 2021 at 6:24 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Currently, clang LTO built vmlinux won't work with pahole.
>> LTO introduced cross-cu dwarf tag references and broke
>> current pahole model which handles one cu as a time.
>> The solution is to merge all cu's as one pahole cu as in [1].
>> We would like to do this merging only if cross-cu dwarf
>> references happens. The LTO build mode is a pretty good
>> indication for that.
>>
>> In earlier version of this patch ([2]), clang flag
>> -grecord-gcc-switches is proposed to add to compilation flags
>> so pahole could detect "-flto" and then merging cu's.
>> This will increate the binary size of 1% without LTO though.
>>
>> Arnaldo suggested to use a note to indicate the vmlinux
>> is built with LTO. Such a cheap way to get whether the vmlinux
>> is built with LTO or not helps pahole but is also useful
>> for tracing as LTO may inline/delete/demote global functions,
>> promote static functions, etc.
>>
>> So this patch added an elfnote with type BUILD_COMPILER_LTO_INFO.
>> The owner of the note is "Linux".
>>
>> With gcc 8.4.1 and clang trunk, without LTO, I got
>>    $ readelf -n vmlinux
>>    Displaying notes found in: .notes
>>      Owner                Data size        Description
>>    ...
>>      Linux                0x00000004       func
>>       description data: 00 00 00 00
>>    ...
>> With "readelf -x ".notes" vmlinux", I can verify the above "func"
>> with type code 0x101.
>>
>> With clang thin-LTO, I got the same as above except the following:
>>       description data: 01 00 00 00
>> which indicates the vmlinux is built with LTO.
>>
>>   [1] https://lore.kernel.org/bpf/20210325065316.3121287-1-yhs@fb.com/
>>   [2] https://lore.kernel.org/bpf/20210331001623.2778934-1-yhs@fb.com/
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/linux/compiler.h | 8 ++++++++
>>   include/linux/elfnote.h  | 1 +
>>   init/version.c           | 2 ++
>>   scripts/mod/modpost.c    | 1 +
>>   4 files changed, 12 insertions(+)
>>
>> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
>> index df5b405e6305..b92930877277 100644
>> --- a/include/linux/compiler.h
>> +++ b/include/linux/compiler.h
>> @@ -245,6 +245,14 @@ static inline void *offset_to_ptr(const int *off)
>>    */
>>   #define prevent_tail_call_optimization()       mb()
>>
>> +#include <linux/elfnote.h>
>> +
>> +#ifdef CONFIG_LTO
>> +#define BUILD_COMPILER_LTO_INFO ELFNOTE32("Linux", LINUX_ELFNOTE_BUILD_LTO, 1)
>> +#else
>> +#define BUILD_COMPILER_LTO_INFO ELFNOTE32("Linux", LINUX_ELFNOTE_BUILD_LTO, 0)
>> +#endif
> 
> With this approach BUILD_COMPILER_LTO_INFO won't be available `#ifdef
> __ASSEMBLER__`; we don't need it today, and perhaps YAGNI, but I think

That is true. I didn't add it since I don't feel it. BUILD_SALT also 
added to vdso binary which I feel we don't need it today.

> I prefer how include/linux/build-salt.h defines
> LINUX_ELFNOTE_BUILD_SALT and keeps it isolated there.  Similarly, I
> think it would be better to create a new header, say
> include/linux/elfnote-lto.h that is basically a copy of
> include/linux/build-salt.h, but with the relevant defines replaced

Having a separate header like elfnote-lto.h sounds okay. Originally
I am reluctant to add a new header file, but maybe a new header
file is much cleaner than otherwise.

> with the LTO identifiers you add above.  Then init/version.c and
> scripts/mod/modpost.c can include include/linux/elfnote-lto.h and you
> don't have to touch include/linux/build-salt.h and we can keep the
> elfnote "types" isolated to their respective headers (otherwise this
> approach reduces the usefulness of include/linux/build-salt.h even
> existing, IMO. Feels like it should just be merged into
> include/linux/elfnote.h entirely at that point).

The only "drawback" is the type values are scattered in different
files which I am not really comfortable with it. But with consistent
naming convention, all values can be easily searched so we may not
have issue at all.

> 
> But, this is a much nicer approach! I forgot that elf notes were a thing!
> 
>> +
>>   #include <asm/rwonce.h>
>>
>>   #endif /* __LINUX_COMPILER_H */
>> diff --git a/include/linux/elfnote.h b/include/linux/elfnote.h
>> index 04af7ac40b1a..f5ec2b50ab7d 100644
>> --- a/include/linux/elfnote.h
>> +++ b/include/linux/elfnote.h
>> @@ -100,5 +100,6 @@
>>    * The types for "Linux" owned notes.
>>    */
>>   #define LINUX_ELFNOTE_BUILD_SALT       0x100
>> +#define LINUX_ELFNOTE_BUILD_LTO                0x101
>>
>>   #endif /* _LINUX_ELFNOTE_H */
>> diff --git a/init/version.c b/init/version.c
>> index 92afc782b043..a4f74b06fe78 100644
>> --- a/init/version.c
>> +++ b/init/version.c
>> @@ -9,6 +9,7 @@
>>
>>   #include <generated/compile.h>
>>   #include <linux/build-salt.h>
>> +#include <linux/compiler.h>
>>   #include <linux/export.h>
>>   #include <linux/uts.h>
>>   #include <linux/utsname.h>
>> @@ -45,3 +46,4 @@ const char linux_proc_banner[] =
>>          " (" LINUX_COMPILER ") %s\n";
>>
>>   BUILD_SALT;
>> +BUILD_COMPILER_LTO_INFO;
>> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>> index 24725e50c7b4..713c0d5d5525 100644
>> --- a/scripts/mod/modpost.c
>> +++ b/scripts/mod/modpost.c
>> @@ -2195,6 +2195,7 @@ static void add_header(struct buffer *b, struct module *mod)
>>          buf_printf(b, "#include <linux/compiler.h>\n");
>>          buf_printf(b, "\n");
>>          buf_printf(b, "BUILD_SALT;\n");
>> +       buf_printf(b, "BUILD_COMPILER_LTO_INFO;\n");
>>          buf_printf(b, "\n");
>>          buf_printf(b, "MODULE_INFO(vermagic, VERMAGIC_STRING);\n");
>>          buf_printf(b, "MODULE_INFO(name, KBUILD_MODNAME);\n");
>> --
>> 2.30.2
>>
> 
> 
