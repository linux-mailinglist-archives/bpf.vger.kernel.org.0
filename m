Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440DF35E918
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 00:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244803AbhDMWiN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 18:38:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:2200 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242578AbhDMWiN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 13 Apr 2021 18:38:13 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DMZfbK018377;
        Tue, 13 Apr 2021 15:37:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=lJAzSWpFaR3mktdiW9sDamMGk9X7vn8uPLVIEMqlVhw=;
 b=hh/N+lRaAE+ZEozaDxM0KydnPuMuNhDI3BaALtiUPPi0F5ZeO3YurRZRqPf5k+jlIJ3D
 yoPJUrWCI1FmNnFmVhQZJUyhTehr64+CniZ7peG/9OxFhajCj+cuBFdd50+0IAVNM8zJ
 Ymmq0uNe5rx82Oh7XbhVdJsookZxDPKViUo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37wabcbq4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 13 Apr 2021 15:37:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Apr 2021 15:37:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFjtHeJTXocl8IhtcmL1Yznb6v58LqxJM8L0+Pt0qXpfsLdT3fUiNKlvs6VSs+7KppY3vP/X2dqYxGt8dyHKtvV/2obMy3UNatZQ3ShT/xuX+Lgx73bS+5qrVHVu7Kck1I474Df3GQQwhSNc7+A3cTg2DotNPvOegY/guiu4t9RAJySMTRk01Ly+FlLPnRPRgPKLcWAH0OKc8vbT2WWBJ4IJGeekFP+ybF8lKN1bjCKw5lAp2DI+giwqgHKUJrds3CxHHR9LH4x8KoNoFw5ubso4bQR6bvjsq2mgWkoMwohFGU3hgYD5v+jpS590WIczxKZZJNyxuP2ebgdUHsBw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJAzSWpFaR3mktdiW9sDamMGk9X7vn8uPLVIEMqlVhw=;
 b=Cr2n+zwT8m50KqKdIbzZ+zVAl9ySXdLqSNhFH6KDKsj5+NbPG2R/c05B+5Iz8J9yGXkAUThklYRFGW7A9UrKdRkD9P1WESQOfSdmnCzD5rnLMMK0HpM4qCqTjXRJv27Cfz+JGsnKB3kFh8fxhUXxq0IYbTKcG9St9swBG1xhfprx2kVA6fdgqdmsQ1F6wP4aj7u7P1elHcyxeXtwfz8Ro6/U8gnLoZmMxlZXyDia1rptnodKss9Y0KRbOS9AWV5ScLSGMamm8gAym3vpWF1/+bLIdWw9zf1abpcJ6yB0XdHCkD5IS9V6mRbcNpr7xUGXTPvhRHR7K2iRzVEDfJcSXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4386.namprd15.prod.outlook.com (2603:10b6:806:191::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Tue, 13 Apr
 2021 22:37:44 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Tue, 13 Apr 2021
 22:37:44 +0000
Subject: Re: [PATCH bpf-next v3 4/5] selftests/bpf: silence clang compilation
 warnings
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20210413153408.3027270-1-yhs@fb.com>
 <20210413153429.3029377-1-yhs@fb.com>
 <CAEf4BzY2qKks5EV2CYZjSHpv3Z-qakfKAw=dA-Uc7kh88_f0AA@mail.gmail.com>
 <CAKwvOdmgJBV5yv5robxvmpdYhkw1epY6FNYYwiszqZ0zyE0UAw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <d1c28757-3fd9-4395-53c1-deb3161e89d2@fb.com>
Date:   Tue, 13 Apr 2021 15:37:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <CAKwvOdmgJBV5yv5robxvmpdYhkw1epY6FNYYwiszqZ0zyE0UAw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:fd10]
X-ClientProxiedBy: CO2PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:102:2::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1058] (2620:10d:c090:400::5:fd10) by CO2PR05CA0053.namprd05.prod.outlook.com (2603:10b6:102:2::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend Transport; Tue, 13 Apr 2021 22:37:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ef983c9-1279-4bb5-962b-08d8feccc173
X-MS-TrafficTypeDiagnostic: SA1PR15MB4386:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB43869913533D5BB8B5D8372BD34F9@SA1PR15MB4386.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +P+Grs5TtvkVHhQOcYZQrMJKzuNfoy/W3+VdGkatYCBsaApS+axaGb9dSYdba4Eqj2CbgdaJRP5DAqdm0jhrriO+O/7rmd+TmF0xAwhZBTBikegUZHau5hTQq/pII3LbcX8PahbRHEm9wNCoQFY/j6sf6EcMqinwIqkljZINAmiKJUCnjhT0gmipI++/wN8AfBi7dWmejmrbPzhXMMi4MEOsHWPj1SRHfYdz3q0AYamkQiU9JMy4v+xMhaJ7VJG25Z8Lv15x5tFeam8F2o9FQOJIZF0sOrchIBTaTQekVsCTp0bB+mZxGsvHucERdXdTld5vl+4v3XR3fj3hQHBrsNjab4hCCMCM1lEHlJ7g1NRS3sH+qvpKmFSSmqv9vZICbXDwnIwOsSBuWbxe9rDIOLaQn4tcM4McuXniULB37jhkkCCKjzsetFAdFiS1v+E5VZOybI5o+UppsGtUPagg/LxUOKnEggNI13D58cpTDm2qoP0pJvPMbGhd7JuNar0IWOEZ9orhcrDmI/FqjQCp4XVqCmxrS2pztQkr0uXKL48yZ6Fp/UYDc94+o4MqaA9yTc4mXQ9oyfCpDDF7GCBWQxq/xj94z+93yooVzrSX5VVe+S4QsWiyCeOcpu2TQUT/UBfPyfW5Wz1xRh+G0GBh9HnSFgPuLjY83iIgwksm9QtD/ppDQuQexGC1+/2IQROY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(396003)(376002)(136003)(31696002)(186003)(110136005)(54906003)(86362001)(16526019)(2906002)(66476007)(66556008)(36756003)(2616005)(31686004)(83380400001)(478600001)(66946007)(38100700002)(8676002)(8936002)(52116002)(4326008)(5660300002)(6486002)(316002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?T2w1Q2VOdStEZ1hZZ09iWlorZm80ZlpzMnVjdUdTVVNTSHVDNFhWWUZ3MHAw?=
 =?utf-8?B?R0Q2NXc1d3lEcDRja1AwUHpDRHZDWnlPc0tKOXIveW5qakRmQWJRM2dYaVNJ?=
 =?utf-8?B?d3p4Mk1DYXFOekwxZ3k4R3lUOTN6TkRHL1owbzE2RmdtMlBXMi9TYm54TDE4?=
 =?utf-8?B?Sys0V3Jna2RoVW5OR1FlTjBjRDFHL1E2M3BnL0ZTbXRqMXJVcmxNUElKc0E1?=
 =?utf-8?B?eGZtQ0RobEVNMHh6WkhvOVBRVGUrbXRvQU42azFQYnNVZVBla1VYV2dPdDl5?=
 =?utf-8?B?Q0R1K01mR0ZFakEyQ0l0VjhVNWx0QnZid3gyOHpFTHB1WTJQaTd4NTVmVzZa?=
 =?utf-8?B?RnhneThjQkwxbjVRZ1F1aThFc3ptdXRMeVRqVExzbnFQbGllYTlmbE82Qzlw?=
 =?utf-8?B?YmdLR3NjV3AyZC9pWFkzNW1TNCtxRFlJb09VQ1ZVUHVqdE1hZUdKSHRxL0kz?=
 =?utf-8?B?aFlzTTlkcXkxdFpOT1BXRDRHOE41ekpmNXRtVDFKZ2tPYS9PRkU1SnVLY2k4?=
 =?utf-8?B?dDc3TVFUOXQ3VSttaG9tMmlHMHpYT0EzUGQwd3RFdTA1OWpsYVJFZzd1dWQz?=
 =?utf-8?B?VHJ0VGRzYm1JVzNtWEFlTCtZTnF0RnhMdVV6YVNoU2ZMQUhDUHVQZ2gzRkVD?=
 =?utf-8?B?cXI1UHNGeGs1Y1Bob3RaMm11a20yUElPMTg5UmZzZ0JxektMZXZWaUd5d0Fy?=
 =?utf-8?B?TEZReVJNWUVLUmF4MVRrYlJxbFJuNEJNMUExQktyc2huWEVEbW1ITTZoUTJK?=
 =?utf-8?B?cEpMOFFSTTBIeWxJS3p2MEhqOFRhK2g2WDlTSlFRVHBpQU10WWgvN2RHOFdG?=
 =?utf-8?B?SHVHSnpqWFhPY2RvR3FzampNMFpXczBFeTN0K1V0ZUQrejJudmRvSFFYYzZu?=
 =?utf-8?B?aytXUDlXWHhmYjgxZ1d5dG83VlZmUVg5cnZpSnk2bVJJOWRPZmR5dEJJbTd6?=
 =?utf-8?B?QlhIYXVrazFEWlg1VDBkT0dzbXRlNzY3aEVyTW5iczNzN29ZOWt5V3ZOZkRS?=
 =?utf-8?B?cXpIakthVGZBRWZhQXJnd2pBbXkvSlZNWFZGS050YlVTRTU3RFZtVWE4YWs1?=
 =?utf-8?B?ZU9DeWUzWXQ1NEUrb0pmRzJjditzL0hpS3BCb2RzUk5SU0FQRndtYjY3VE0r?=
 =?utf-8?B?NzhvdlhZTVZIcGVvM0pEdjdLeFk1WDlESWpuN3RjM0p0N0xlVUJCWmd3NGxZ?=
 =?utf-8?B?NzVjOVBuUUFKYlk0VVVZUFZSbzZ2WDZ5RUd6NDBjajY3Y0o2REJXbFFrcVJJ?=
 =?utf-8?B?ME9XWENQa0tVQ3JLRzQ0aHhybW0yMWpNUE5kdjRGVlQ1N2ltdVRXdXRxTUZ4?=
 =?utf-8?B?WkdxcUtiU2Yvcm5rMUFZdGhUYkZsK0RzOExoRXh4MWprMk91dlB2SEJLa29R?=
 =?utf-8?B?WWFmWjczU1NBR1lyNDd6ZTYrc2VRYUNKSEVQNXp5WkpNczRhWEhaaldEbmdU?=
 =?utf-8?B?KzNyaHhTR3dUamlnVkFwUkw0aGFCRlFHOXg1clJYeTZlZzhjYXZSRzR3eU5B?=
 =?utf-8?B?OUJuMkF6OEo2cDJYajE2K1ptRGw4a1FldTI4azFtbVlTNGRjK1FxMVY5Wi8z?=
 =?utf-8?B?QWlkV09JNmw0UWRUblNPRkJLVFVZQ3JIMXMrblM5aklWUEMxMk5ISFdzekRV?=
 =?utf-8?B?bUpoVmdSQW5aaFdKMkI3MW5pekZGaU5CZVRnaEtyWVdSMjJNcHRMSy9oOHk5?=
 =?utf-8?B?UDkrQklCZFBNVkcrTDBlV0REODAxQ3ZTY2s0K2RHT2IxQjR6cW43K1pLUkRX?=
 =?utf-8?B?RUJtbUs0VHVxdzFYbmVSanRRbkZNSXBFVXk4dmlldmVDQUJFZWREOW5BdU1E?=
 =?utf-8?Q?Yd0aNvioEHTT4QjYVN9dJH8DRUyFUW/kgr5G0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef983c9-1279-4bb5-962b-08d8feccc173
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 22:37:44.6245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tnx+PwIwYnum8edLF0xPjvpNf/32v3zZnskRqNpQVpdPFjsBKQLaCqHaqNdeHHae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4386
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: mTbV5XMOlaUB8ECLgv-5epapZDHKzm52
X-Proofpoint-ORIG-GUID: mTbV5XMOlaUB8ECLgv-5epapZDHKzm52
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_16:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104130147
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/13/21 3:17 PM, Nick Desaulniers wrote:
> On Tue, Apr 13, 2021 at 3:08 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Tue, Apr 13, 2021 at 8:34 AM Yonghong Song <yhs@fb.com> wrote:
>>>
>>> With clang compiler:
>>>    make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
>>>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
>>> Some linker flags are not used/effective for some binaries and
>>> we have warnings like:
>>>    warning: -lelf: 'linker' input unused [-Wunused-command-line-argument]
>>>
>>> We also have warnings like:
>>>    .../selftests/bpf/prog_tests/ns_current_pid_tgid.c:74:57: note: treat the string as an argument to avoid this
>>>          if (CHECK(waitpid(cpid, &wstatus, 0) == -1, "waitpid", strerror(errno)))
>>>                                                                 ^
>>>                                                                 "%s",
>>>    .../selftests/bpf/test_progs.h:129:35: note: expanded from macro 'CHECK'
>>>          _CHECK(condition, tag, duration, format)
>>>                                           ^
>>>    .../selftests/bpf/test_progs.h:108:21: note: expanded from macro '_CHECK'
>>>                  fprintf(stdout, ##format);                              \
>>>                                    ^
>>> The first warning can be silenced with clang option -Wno-unused-command-line-argument.
>>> For the second warning, source codes are modified as suggested by the compiler
>>> to silence the warning. Since gcc does not support the option
>>> -Wno-unused-command-line-argument and the warning only happens with clang
>>> compiler, the option -Wno-unused-command-line-argument is enabled only when
>>> clang compiler is used.
>>>
>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>> ---
>>
>> LGTM, please see the question below.
>>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>>
>>>   tools/testing/selftests/bpf/Makefile                         | 5 +++++
>>>   tools/testing/selftests/bpf/prog_tests/fexit_sleep.c         | 4 ++--
>>>   tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c | 4 ++--
>>>   3 files changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>>> index dcc2dc1f2a86..c45ae13b88a0 100644
>>> --- a/tools/testing/selftests/bpf/Makefile
>>> +++ b/tools/testing/selftests/bpf/Makefile
>>> @@ -28,6 +28,11 @@ CFLAGS += -g -Og -rdynamic -Wall $(GENFLAGS) $(SAN_CFLAGS)           \
>>>            -Dbpf_load_program=bpf_test_load_program
>>>   LDLIBS += -lcap -lelf -lz -lrt -lpthread
>>>
>>> +# Silence some warnings when compiled with clang
>>> +ifneq ($(LLVM),)
>>
>> This won't handle the case where someone does `make CC=clang`, right?
>> Do we care at all?
> 
> Right; it would be better to check CC=clang and have LLVM=1 enable
> CC=clang from a higher level Makefile (since tools/build/Makefile
> seems to override the top level $CC). See the top level Makefile
> L448-456.  Then it should work for CC=clang or LLVM=1.

I would consider LLVM=1 is recommended and should be supported
first. Support for CC=clang CXX=clang++ etc. can be done later
if people find cases where LLVM=1 does not fit their need.

> 
>>
>>
>>> +CFLAGS += -Wno-unused-command-line-argument
>>> +endif
>>> +
>>
>> [...]
> 
> 
> 
