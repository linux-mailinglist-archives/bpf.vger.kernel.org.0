Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D92F35B657
	for <lists+bpf@lfdr.de>; Sun, 11 Apr 2021 19:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbhDKRlU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Apr 2021 13:41:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:61920 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233822AbhDKRlT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 11 Apr 2021 13:41:19 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13BHd2kY009279;
        Sun, 11 Apr 2021 10:40:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=pjOvxGefcZH8CxfNnt7Gs/PV3LLd3tKCFnTV2BjKmSQ=;
 b=BKnuKAPl6jEc/ETmSI+jZVL0wkRpZlAnMmu/ezDXQvCKzZiKRBlHm+Eb2k1QuTpMTjgE
 zK9Tq6VgKvr+nq3KX3/6Y8LYaFXxCfuRNfmwlFbjaIi1oNmASFzQ2mfSbDG+JBwkYkuX
 2msBMlWsIlUo6Iqd+Kx4PtJ/BDKAj4s5AG0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37uuqgsq3p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 11 Apr 2021 10:40:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 11 Apr 2021 10:40:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Epk5cMwAWvmUq/GwzdXfR2tO+cO1THFtzDLy6GEOL8hsEImPC28CExyt4aRrYMEaqVwEu268DAQIQdYVcNnKsVFqH6AbGK1Ys4GQg/tMEfLLV6KBmBfT0K8mdn+IgsVCwsrHi9qlx+X8fXokvUi1XVSspzihX9F/YBazkGu9XPMyWUNPt95xcJjbaiCeg/W9d3ibYGIDHQpUUdwQ5cPk/hqZGRRj7YyFjeTqZjbnyP/GjqfuhYo3IyKhN62eoEvX9hYf/FP04UyNcCBreBPAMIftt0K2eKIwwigWV4wO9WO9mSmu0qdMLWde4JAzfXeEqXcJ/zoBl/RmErdK4WYx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjOvxGefcZH8CxfNnt7Gs/PV3LLd3tKCFnTV2BjKmSQ=;
 b=MfhXvzCdd8aRc/dAeeGKHR4UViiRVqwq8qx9o9GkYtuiiVnjSuidk68BqcXsU88YF4POJ4wbSCx3/U3e1MQIqpoxPm/G/4T6E/yXzt52WkAyM2t198vzhB9J5I/eE2N4dIJpIefXtbs+feYK8rPGWFpH3Ao9f2ab1rO29tViNzEQMSk4HfqG/5rgc1/KWG/DwAPQIahomHfREVoEcSiYs0L8LNWoNxIGbVttXCLguhAEFHbrwTBHinqxd5w8egZ2FGb2175dwIXyv9Fae33J2MKRN6uBDHbiePyBmDEWeFNJH+X1KZmLGQVP4zR1rSBqFZZrnsU8VCrLBMTZED43FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4046.namprd15.prod.outlook.com (2603:10b6:806:8d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Sun, 11 Apr
 2021 17:40:50 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Sun, 11 Apr 2021
 17:40:50 +0000
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: silence clang compilation
 warnings
To:     <sedat.dilek@gmail.com>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>
References: <20210410164925.768741-1-yhs@fb.com>
 <20210410164946.770575-1-yhs@fb.com>
 <CA+icZUXZY+dhv+JHnpiz+tkN4T9f2XCd02Btp9QGRfnT2n6qBg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <e1c53fa7-f088-da5a-667c-8139ddf887f0@fb.com>
Date:   Sun, 11 Apr 2021 10:40:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <CA+icZUXZY+dhv+JHnpiz+tkN4T9f2XCd02Btp9QGRfnT2n6qBg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:ec9]
X-ClientProxiedBy: CO1PR15CA0074.namprd15.prod.outlook.com
 (2603:10b6:101:20::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::110f] (2620:10d:c090:400::5:ec9) by CO1PR15CA0074.namprd15.prod.outlook.com (2603:10b6:101:20::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Sun, 11 Apr 2021 17:40:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68023ba7-bffe-49d5-ed88-08d8fd10f21c
X-MS-TrafficTypeDiagnostic: SA0PR15MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB40467E2138F3CA3594D67289D3719@SA0PR15MB4046.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zu5RTEF7ulkb3iP+qfVkff6tStCngW8KzlWHq34X8AGhaMlZ4cng2ETpf+IyB/n4EPVvirjv4HCNG6qG9DTp37krL2Ixglx8BLRj6chimfm65YedY8vQjHXqu9JBioMkiZirxZGm5M3/KK3CAkhWW4GLbqdizSXb9wnHnqc5y/iL3mxGZQBk+C3tcrfnsgVUt5TDV4vML9dV0116Lu2ShNomP6R21aJAvuHuWJy/nN0I+jk7Yi8U+PlED/9IU1l/11TY7XLjuf44oTuUu9DdHHfZzXwQVyw85OrO0gz4HVswFHwY3tRl67TBqMT4X/REfmlnVo+qd4AHBg6ebmkxnW4f532ouXz8NPpwqw0UP5fIJrHf/fTBSaiVVdQcn/sRYhGqLCyKqXC095eHaaf1hiSUH4dUAB/CCpp6jDqXiHrrqyBqLHK2pTfMRz0GbuOzZdYiga+wtDkH+HWbPZk84jA3Pszg6VpAb8c+u3wvwL+GAk4KvTdkPhp3gc0Izls5pFoR+ZJv1x/C4X2JeolDuIzXnCRiRKPvWhzoVItRLAK8/A2WDCmF+lV+1LUJ8jHzmyTUq0qS9vop14U6Sy79Y4ZAA9fJhsCSj9Wkg9nM0udFhQYb90EoqFemofVpWloHlx+BkkiSqCkEr1QtVFEOghJvJSLW93uVQX+kX1ss+z1kI5kcFA8KTJ90HVTPnc/s1VVcXsz9sz2s8gUAnkc3gepQtkuoW8riv1WKpZ+oYnHZRGqZVplQpSHrWHUVnRf6Dexcmg6d66z1wnj/icMorw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(396003)(366004)(136003)(8676002)(52116002)(478600001)(2616005)(66946007)(53546011)(2906002)(6916009)(186003)(6486002)(83380400001)(5660300002)(36756003)(66476007)(31696002)(86362001)(16526019)(38100700002)(966005)(31686004)(66556008)(316002)(54906003)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TjFiQk9hMkdIc25TeTBtWlpqSjRSUVhoQVlHOHZXaStYMy9QLzlqVjdIT2R4?=
 =?utf-8?B?RmlrVDJ1dU9IaXFMN3Z6aEx1TlVoU3paUVdCYk1xUkFIbHlrdGxpS1pucTJS?=
 =?utf-8?B?VmVDdlB1SGcxSkFzYWZWRGVsSERUaXFjUEZlU2ZqbUVSeUNxeENkWGNYd2hv?=
 =?utf-8?B?Wk5qbEpCcTZ0NklId2tlMkc0aHRHK0dibnF0RUF6cG16RXdtRGtaYXBOckxF?=
 =?utf-8?B?RzVDL0xYQkt2VnhObmpzZzVzOFpnV29RSHZjcGpBdWJ2YTN5TnI1cW5VZkxL?=
 =?utf-8?B?bWRnTXpyOUN5RUE4YlZERkJ1L1YzWTc3M0NOa1VZOXcyYWNZYVRsQys1bG40?=
 =?utf-8?B?RlEwb1c0enlEZkVpbzViZW9XZTR1NmpNb0YzeU9TVVR4L0VmczJQZjBBbkRE?=
 =?utf-8?B?dVZqMWVYQjJaem9WY1gyZUkwWHJwR0ppMnB4ZGpCUXpUVFQ2RGtYc1VPUklW?=
 =?utf-8?B?VDdGQ3F6Q0JLeXdtNUNUVWF5SkJKWlFSd2dXcDREcSsvdVNDc0NockRsS0FW?=
 =?utf-8?B?VytHYmVwQ3pyK1ppNXltMHFyWldSeldmZmlQYktzSEJyTnJ1aHgzbTBVaVBJ?=
 =?utf-8?B?Nmw4M25MbGhZUk00MG90cEEwLzExZ2xiTEZiV3I3OTE3T0JIKzFuV1ZHRmNz?=
 =?utf-8?B?cWFRV0dLMXhmUDVzMXhoVWkzaDQrcUVkKzB6aHRWQllKb1BMSUcvN2tvTTNL?=
 =?utf-8?B?YndSeHY1NGF4SnJ1cnhYWFFTMTBuRGM2WStSZ1NJazFPOHE4OWF0NkR5SzhO?=
 =?utf-8?B?WmhDWkFRelA1RUp6dXFTRGZPc0VjUTRLdzFjdis2RzJQaXRSKzFTQkhwOHdF?=
 =?utf-8?B?cEFmM1dvSnd0NUk5OTZQQ2JvWTFlNmRma2RTK0haYTE4WFhxVkpaVVgraWdi?=
 =?utf-8?B?NHlrOEl4MW5PY0lPUXNkYUNtall4ZHhRc2lPVzRsUTF5VXdXaENOVUt2Mldn?=
 =?utf-8?B?bEVJRyszQXhndnVEbkpqV1crOHVvNi9qSUVabS9ubVhOdkdPeEVaMjZ5UVFU?=
 =?utf-8?B?ZzNRVFJpemJsMjQyVHZmdVdFeDgyeXoxZWJERW5hYzZDTHVqamsvdTEwd0xt?=
 =?utf-8?B?QlFZUnpkaWsyd3FrNVRVa0dSdUxXRlVHbytyT3E1aEd2eU9TZjhsa3p2dVJX?=
 =?utf-8?B?MEhwQ240QTlJVzdrMG0wYU9ZaDYyN2prWjRwWkNZdHlqMWtyeDRvTWFMRUFB?=
 =?utf-8?B?allENVY1bi80L3dvcit5YkRwVlduUTM3RWY2RUd5YWJlY3Z1L1ZmeVdDVDlk?=
 =?utf-8?B?Rk5SSGlIOTluZURaWFJPR0hQQUNNbFdoSTcyc2ZMRjMzNHdSeERxUVRWVnl6?=
 =?utf-8?B?alhqU1Y0c0NSMzdVWkN3cS9RRHEwcEpNMytDaUppQW54VkRCUzgwZ3VhTmRB?=
 =?utf-8?B?cXk3QjV6dXJwenVFUXArRkpBWU5QUjJuUmNmdmdzR2QyUzZHVmdGSWlQZUhK?=
 =?utf-8?B?RlZNcm9LcGs4Ly9adFZyK0F0MzZHa1NRalNSNTFkMkU4SGd0YVNMNk9HaDl1?=
 =?utf-8?B?WDcvTWRBRER2QmloM1ZlSlFOL2Y0UWNURWgzdUFWd2xuMTEyek5NdGY1ZjZN?=
 =?utf-8?B?dU1FZnd5Z0wxRFFOTnJyeURLVXhCdEhOUVltTHcyaDE4Nk1sMzZlMEdtcFMv?=
 =?utf-8?B?SEl5ZURiWVM2NjEzRkxZM2lHTnVlVGhDV2JDNVpZR2s4M2E3cjJLUjRJSXhv?=
 =?utf-8?B?ZWpIQU1KdDd4aERKQjRmWmFZclZ6bDAyZWM5eWNiTWk4blNqTlhkdWJwN2ZH?=
 =?utf-8?B?dWZyMk55cnE1aDdWWGw0aHFlcjZuWmtCc0hOVUVYVWViM2lnb0NrNTN2ejBR?=
 =?utf-8?Q?8AlaP0WzLKKilgUKLmo5L4UF97peU7N8Ebjy0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68023ba7-bffe-49d5-ed88-08d8fd10f21c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2021 17:40:49.8699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zVMhqEqoLvI6RHK0rjkKLU7PVj/+XVvd19v3zqcWfoLzhPvxIjJwVYH7/FmfTDM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4046
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: QbhBkh2dwFZw65WLj-bLUOt43OsdaiQZ
X-Proofpoint-GUID: QbhBkh2dwFZw65WLj-bLUOt43OsdaiQZ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-11_09:2021-04-09,2021-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104110139
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/11/21 4:12 AM, Sedat Dilek wrote:
> On Sat, Apr 10, 2021 at 6:49 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> With clang compiler:
>>    make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
>>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
>> Some linker flags are not used/effective for some binaries and
>> we have warnings like:
>>    warning: -lelf: 'linker' input unused [-Wunused-command-line-argument]
>>
>> We also have warnings like:
>>    .../selftests/bpf/prog_tests/ns_current_pid_tgid.c:74:57: note: treat the string as an argument to avoid this
>>          if (CHECK(waitpid(cpid, &wstatus, 0) == -1, "waitpid", strerror(errno)))
>>                                                                 ^
>>                                                                 "%s",
>>    .../selftests/bpf/test_progs.h:129:35: note: expanded from macro 'CHECK'
>>          _CHECK(condition, tag, duration, format)
>>                                           ^
>>    .../selftests/bpf/test_progs.h:108:21: note: expanded from macro '_CHECK'
>>                  fprintf(stdout, ##format);                              \
>>                                    ^
>> Let us add proper compilation flags to silence the above two kinds of warnings.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/testing/selftests/bpf/Makefile | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index bbd61cc3889b..a9c0a64a4c49 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -24,6 +24,8 @@ SAN_CFLAGS    ?=
>>   CFLAGS += -g -Og -rdynamic -Wall $(GENFLAGS) $(SAN_CFLAGS)             \
>>            -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
>>            -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)                      \
>> +         -Wno-unused-command-line-argument                             \
>> +         -Wno-format-security                                          \
> 
> Are both compliler flags available for GCC (I simply don't know or
> have checked)?

Good question. gcc/g++ (8.4.1) does not complain these two flags
and I assume they are okay as well. But further digging shows
gcc only support -W[no-]format-security
   https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html
and does not support -Wno-unused-command-line-argument.
gcc/g++ simply just ignored it.

I will make -Wno-unused-command-line-argument for clang
only in v2. Thanks for catching this.

> 
> - Sedat -
> 
>>            -Dbpf_prog_load=bpf_prog_test_load                            \
>>            -Dbpf_load_program=bpf_test_load_program
>>   LDLIBS += -lcap -lelf -lz -lrt -lpthread
>> --
>> 2.30.2
>>
