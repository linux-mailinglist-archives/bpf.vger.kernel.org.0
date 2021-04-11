Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D85C35B652
	for <lists+bpf@lfdr.de>; Sun, 11 Apr 2021 19:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbhDKRUb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Apr 2021 13:20:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28082 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233822AbhDKRUa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 11 Apr 2021 13:20:30 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13BHJUsb029659;
        Sun, 11 Apr 2021 10:20:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=XruwzYfPGmsv9+znVQs11sohblUPanevpnVxrC7xXE8=;
 b=jR5+rRe09Tgu2bJVqHImEc8XVAiKL2OxKubE0OG5pnQJVASWHNVTyH8Dfn2eg4fo1HIW
 JnKDj4xnMlSXl+gQM/M27WR2Qvgva2WsmWysKXCEP5dMkkuv461PD9ulaDPD/WjY1diK
 P7V1Aa0ICOh5vyeDH3FLulJEuQbVSX9kXds= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37uurwhn3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 11 Apr 2021 10:20:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 11 Apr 2021 10:20:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAKnae8OX5nNi8+WPE0xwY/zULcGsyWGzEaYk4IDG2K6rNajmyGHTLq/3i3RyHFnKhdAs7KNWmh1gXDRr+gr39bqfRL0CEngkA/8KWEruSM3zSqmq+qLh/ybvmgCjxLijyj6sK7q2AX11BKJx3s8YHU97vjFYLAvWwrGkK4cuIn1lVV+mhj5Vqu4WzoXv4UlceKH9bNpNwUTTP4Pkm9fO9h/o10d/IMBqZW65UjeN0k8Rd0ildM6FAnELftQh18sjfejV72vs7kFcF7Mhoj52+MfxoCO7333EX5KJUgrx0Cugl4+YooIT5I7/wriy7SNsbOGDTq/+C5GbVLySNJTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XruwzYfPGmsv9+znVQs11sohblUPanevpnVxrC7xXE8=;
 b=hXYYv0sTRTGGQ85rV1CJWYgVtfcF8NBys3NsSozeOVzGDdnjPIMJdwnREulIKvtSRFw26hN6Ck7Vc/JcdDsAw073rRXK4YbAxmLxLMv/+w3b3TF9PLZP3QDTVW+IKKtCY9CXcYBG+g6DzyUDo+9lSxlibaIcsCOlcJh14jXEIVGIEC745LGx2odwDZsWD9jpnayTw8Bfa1Csf/GLbNUszAZlE0F8yF3R+GfTJuQFGne/1bTHrDQMfM9CTcbPvpzOkuXMXHWRRwuocA4wzgteKJW5+8F+mjP27+YvyYeTUJVdRkBc/hKvrZ8p95sD5Byo4Y/GFle+DETGQnLV1mpqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4708.namprd15.prod.outlook.com (2603:10b6:806:19f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Sun, 11 Apr
 2021 17:20:07 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Sun, 11 Apr 2021
 17:20:07 +0000
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: fix test_cpp compilation
 failure with clang
To:     <sedat.dilek@gmail.com>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>
References: <20210410164925.768741-1-yhs@fb.com>
 <20210410164940.770304-1-yhs@fb.com>
 <CA+icZUXzCpHWk8Vm5D4ZcCbdd9gqipVD5ALCw6SGTFbYfdJZiA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <7c82c0f5-2a96-7a5c-b090-f26c9351786c@fb.com>
Date:   Sun, 11 Apr 2021 10:20:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <CA+icZUXzCpHWk8Vm5D4ZcCbdd9gqipVD5ALCw6SGTFbYfdJZiA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:ec9]
X-ClientProxiedBy: CO1PR15CA0098.namprd15.prod.outlook.com
 (2603:10b6:101:21::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::110f] (2620:10d:c090:400::5:ec9) by CO1PR15CA0098.namprd15.prod.outlook.com (2603:10b6:101:21::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Sun, 11 Apr 2021 17:20:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 106f76bc-63f7-4a39-a639-08d8fd0e0daf
X-MS-TrafficTypeDiagnostic: SA1PR15MB4708:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB470855FFDDE0517D275FD527D3719@SA1PR15MB4708.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jIUXWFk9mUDq8uOsmdlNXJGKdSPRf593uXmWQIDVBvr6UoZoZXpdVWnpRnW3B4pBzrOXyNi2wjokVP5qHH1gJDJKM0gOTwG1TwwbOQ8msppziXWr+6FIisv/c78z0fG+g6DUxYqKA3sp5aaxjyAhOON29IK2SnYyHtsxxRf/Moav2p80EJH/+GlcTtAYswToXw/2T+cVmfgD5MNoDLt/wRzIp1SocFwC8wl1ELkybbmqgaL4mkNOuKv9XCRDO547xUwdNtEVAI+6dCWXwTM+eFCQroEQX1HOAu664reQzLzyI1FkdABqtdxSt9+05BhMrYOovQ9JR7oIbzEjOG2eatd/JCKo8vFv39XYbKh+qE7hIOhQWr5hnYnbEs4YxM7nuzfJosjkq+WJsrKJ5ZdsEeoH4Ew68PfcOOLvzFgRD69N1QH0W/DJITx7HOgg7gCeQ7szCOqRmkRV5olih7kZNrZKe4uva0F/XxOfKnMsNchx4JnUjXzBZChXsyLCOMjXexCYMDgH/4ZyfIuvZi//NHhTgos4pgWsQtg1EIuMplqP0nvS6FTykpj2nUIyM4Fvkl8wFiQ1v3VeTLl0xwg+4nd5Be/85sUs9qCT9XIL/QYLpd9UTzjFlmbL2YLAQxJP980XdXfctKfebr/sK4p3JOHFmEwuZaBWpgScs46xLReSG+Cne/b6ZgCPiry5ZnVA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(376002)(346002)(366004)(31686004)(186003)(54906003)(8676002)(16526019)(478600001)(316002)(53546011)(8936002)(86362001)(38100700002)(2906002)(36756003)(31696002)(5660300002)(52116002)(66556008)(83380400001)(2616005)(6916009)(66476007)(6486002)(66946007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TFYxaGI5eFluakROOU4rNkR1QW9SK2YrYm1IQml1SUhHMU96MXlxeERDU1Rr?=
 =?utf-8?B?Rjg1RXlpa2d4UWpBZUFCWkp2SzU5c244YzF4UzdrckgzS3ZKVDVNOTBCZGdE?=
 =?utf-8?B?MnhWajg2VWoyZURnOUV4OTlIRWVFS3hWd2pwZVR0YklFa3RZNTlIbGVpZVV2?=
 =?utf-8?B?R2UrMmxBTGM0SDBaVmdCUWxxa3c1Y3ZmUGhHQ2gweFBXY0EvblVuTnpQNjFD?=
 =?utf-8?B?ZndZMERCdFlXT1B4UzV6WkpsVGRiL3g1M0N0dzR6S1lsTW9YT1ViTTFJdVM2?=
 =?utf-8?B?T3dYMFp2TUxqRmNFT2FHc3M3TnR4eWNtQ1BKYkNQeWVMUHVEOU04YlhEb2hG?=
 =?utf-8?B?YTJQWHpyakxqaUlsdHg1Um0rMy9xNllwaUlIQlNzOG50OEEyRVZLWngzckEy?=
 =?utf-8?B?aWRURS9sa1NCd2RtM0tPcW1GdnlKdkllRW05UEdCU0FJV3FrUSt0VUZxNkVF?=
 =?utf-8?B?Y0Q1dkl1UjNOQnk1YTdzdld6NEovRUNyV2lYR3B4SEs4dWZDbytlQzZzd0Rs?=
 =?utf-8?B?ZUVpN1FIMzYyQUdhbjJYVTFUOGxlUmtQMXd6RjdIdUU3RFpTY3NnZDFaYVdG?=
 =?utf-8?B?ajhFTjJKc3Y0TG9LQXBucnhyQzRYMzhjWGlEL3FpZ3h1RzBKUy92a09BTE5T?=
 =?utf-8?B?OENEelJxRjhwNmE3aWhXUGtjZUxZL0hITkdlWks1UkE0OSt0dW9Jb3E2bm9i?=
 =?utf-8?B?N1MySFN5QzBxazlvTVA0bzF3WkkreDA0bVlNcmd4S3J0NW04THcxak9KaGF2?=
 =?utf-8?B?cVczNVliV3BYc1psME1kd1ROUmR3bDhDWi9VYUNXS1NrNHMwMW5nSmtmdUxn?=
 =?utf-8?B?RTNrd3hteVBRajkrcG1QYWFqdGF6U25udGFHbWJjaGpCQlVlZEREYW5wcEE3?=
 =?utf-8?B?U3M2WGMvSkljYVJJRDNLdWdQL1N6ZnhpQ0ZDOVJRenlvZWd5YWx3dE5zRytD?=
 =?utf-8?B?SEd0VEh4L3RZU2l6RitUMW8vVzFSYitZM1pwaitjT0hvNHdlY2lSSW9lODFq?=
 =?utf-8?B?blArRmJrMlREcTJEU2xzOWxCeldqWElDWm1kWUlFMG9BV25PZlZjM0pvT3RG?=
 =?utf-8?B?QUNtZEFxV1Y4NERYaXM3aWE4TkMvUXZ4dDA1VzdrT2piMk9qVnpwVGp1ZURv?=
 =?utf-8?B?YzVtWjRQL29NaXIvTSt6RUUxeVNJckZiVTFvZGtFSzZlSEF2TGNISGZQdHpy?=
 =?utf-8?B?LzdTQWRKYm9LVkJ3cnFNVlhkeTNTWmxVUEpBM1FQTWZHeVhaYlorNTkrUFZE?=
 =?utf-8?B?WWptSXpXTVFKSlJKTEJVREZDTnNUQ21rR0hFYjlWcjc5ZnpYV2ZrUTkzdXBJ?=
 =?utf-8?B?OGxqT1lUOUh2K3AvSTgybWRtcmNoU2tDeUZLNGVud1crSDNFbHk2Qkt1WHVG?=
 =?utf-8?B?cnJ6MnNoa1J4N3VZMVUrMFJ3OVJJUVdhaUNveTlIN0pQbEtPaGdHVTJ3UU5u?=
 =?utf-8?B?RGMxbzlwdTA4MEw5WFlnTUx4NTluR3BZYk1Gc01KK01TM1QwWVdNVlhkUGQ3?=
 =?utf-8?B?aTF4TjJsTlpWVSs4Rm9lOVI0NUZwL3F5dm1yandyeG5GQ3dRaDJlNUY5L21M?=
 =?utf-8?B?eDRINDJrVHAxQlJyaURIb3ByUnhWcDR5ZllvK1dQUHh3UnhLYzVFVHp0Z1R6?=
 =?utf-8?B?bHVQZlJyZXE4R1dUNjRyajhnRTdkK3UwdFRYYmZwZUFaMllpVk5qTW56Sytm?=
 =?utf-8?B?V1RqMFhWYXQvSTRMUWVLaW5xSHg4UkNCMDJpak4xVG5LNHVXZXVmL2did25q?=
 =?utf-8?B?MktETmxDZUVobTlPUlFsckFVZ21UZ3ZWTFVkUS9ibjY2bkRNUFlaNmZnYlJm?=
 =?utf-8?Q?C0PeEzXsxR/38gersD722zlJvI2+LWCKpMRHw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 106f76bc-63f7-4a39-a639-08d8fd0e0daf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2021 17:20:07.4689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zouab0b3nBG1+bZryOBMfmHYnrf4CySk+QGb0HtZbxApJYUTFuv8OTySkHQnk9M8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4708
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: FoKRy9zuSTF-E31s9WmApPWg0LrI_idv
X-Proofpoint-GUID: FoKRy9zuSTF-E31s9WmApPWg0LrI_idv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-11_09:2021-04-09,2021-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104110136
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/11/21 3:47 AM, Sedat Dilek wrote:
> On Sat, Apr 10, 2021 at 6:49 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> With clang compiler:
>>    make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
>>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
>> the test_cpp build failed due to the failure:
>>    warning: treating 'c-header' input as 'c++-header' when in C++ mode, this behavior is deprecated [-Wdeprecated]
>>    clang-13: warning: cannot specify -o when generating multiple output files
>>
>> test_cpp compilation flag looks like:
>>    clang++ -g -Og -rdynamic -Wall -I<...> ... \
>>    -Dbpf_prog_load=bpf_prog_test_load -Dbpf_load_program=bpf_test_load_program \
>>    test_cpp.cpp <...>/test_core_extern.skel.h <...>/libbpf.a <...>/test_stub.o \
>>    -lcap -lelf -lz -lrt -lpthread -o <...>/test_cpp
>>
>> The clang++ compiler complains the header file in the command line.
>> Let us remove the header file from the command line which is not intended
>> any way, and this fixed the problem.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/testing/selftests/bpf/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index 6448c626498f..bbd61cc3889b 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -481,7 +481,7 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
>>   # Make sure we are able to include and link libbpf against c++.
>>   $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
>>          $(call msg,CXX,,$@)
>> -       $(Q)$(CXX) $(CFLAGS) $^ $(LDLIBS) -o $@
>> +       $(Q)$(CXX) $(CFLAGS) test_cpp.cpp $(BPFOBJ) $(LDLIBS) -o $@
>>
>>   # Benchmark runner
>>   $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h
>> --
>> 2.30.2
>>
> 
> NOTE: bpf-next might be different from my build-environment.
> 
> Yonghong, can you please re-test by adding explicitly CXX=g++ to your make line?
> 
> Here I have:
> 
> $ grep test_cpp make-log_tools-testing-selftests-bpf_clang_clang++.txt
> 1907:clang++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/include
> -I/home/dileks/src/linux-kernel/git/include/generated
> -I/home/dileks/src/linux-kernel/git/tools/lib
> -I/home/dileks/src/linux-kernel/git/tools/include
> -I/home/dileks/src/linux-kernel/git/tools/include/uapi
> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
> -Wno-unused-command-line-argument -Wno-format-security
> -Dbpf_prog_load=bpf_prog_test_load
> -Dbpf_load_program=bpf_test_load_program test_cpp.cpp
> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
> -lcap -lelf -lz -lrt -lpthread -o
> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp
> 
> This clang++ line does not include <...>/test_core_extern.skel.h ^^^
> 
> $ grep test_core_extern.skel.h
> make-log_tools-testing-selftests-bpf_clang_clang++.txt
> 704:/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/sbin/bpftool
> gen skeleton /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_co
> re_extern.o > /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_core_extern.skel.h
> 1592:/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/sbin/bpftool
> gen skeleton /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/no_alu
> 32/test_core_extern.o >
> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/no_alu32/test_core_extern.skel.h
> 
> Checking test_cpp:
> 
> $ /opt/llvm-toolchain/bin/llvm-objdump-12 -Dr test_cpp | grep extern
> 0000000000417e50 <cmp_externs>:
>   417e54: 75 22                         jne     0x417e78 <cmp_externs+0x28>
>   417e59: 75 10                         jne     0x417e6b <cmp_externs+0x1b>
>   417e61: 75 21                         jne     0x417e84 <cmp_externs+0x34>
>   417e69: 75 1e                         jne     0x417e89 <cmp_externs+0x39>
>   417e87: eb f2                         jmp     0x417e7b <cmp_externs+0x2b>
>   417e8c: eb ed                         jmp     0x417e7b <cmp_externs+0x2b>
> 
> $ /opt/llvm-toolchain/bin/llvm-objdump-12 -Dr test_cpp | grep core_extern
> [ EMPTY ]
> 
> When compiled with g++ in an earlier setup this contained "core_extern".
> 
> With this version of your patchser it breaks *here* when using CXX=g++
> (and uses /usr/bin/ld as linker):
> 
> g++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/b
> pf/tools/include -I/home/dileks/src/linux-kernel/git/include/generated
> -I/home/dileks/src/linux-kernel/git/tools/lib
> -I/home/dileks/src/linux-kernel/git/tools/include
> -I/home/dileks/src/linux-kernel/git/tools/include/uapi
> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
> -Wno-unused-command-line-argument -Wno-format-security
> -Dbpf_prog_load=bpf_prog_test_load
> -Dbpf_load_program=bpf_test_load_program test_cpp.cpp
> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
> -lcap -lelf -lz -lrt -lpthread -o
> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp
> 
> /usr/bin/ld: /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a(libbpf-in.o):
> relocation R_X86_64_32 against `.rodata.str1.1' ca
> n not be used when making a PIE object; recompile with -fPIE
> collect2: error: ld returned 1 exit status
> make: *** [Makefile:457:
> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp]
> Error 1

I cannot reproduce the issue with g++ with bpf-next, my command line is

g++ -g -Og -rdynamic -Wall 
-I/home/yhs/work/bpf-next/tools/testing/selftests/bpf 
-I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include 
-I/home/yhs/work/bpf-next/include/generated 
-I/home/yhs/work/bpf-next/tools/lib 
-I/home/yhs/work/bpf-next/tools/include 
-I/home/yhs/work/bpf-next/tools/include/uapi 
-I/home/yhs/work/bpf-next/tools/testing/selftests/bpf 
-Wno-unused-command-line-argument -Wno-format-security 
-Dbpf_prog_load=bpf_prog_test_load 
-Dbpf_load_program=bpf_test_load_program test_cpp.cpp 
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a 
-lcap -lelf -lz -lrt -lpthread -o 
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/test_cpp

I modified to
g++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR 
-I/home/yhs/work/bpf-next/tools/testing/selftests/bpf ...
and cannot reproduce the issue.
The macro HAVE_GENHDR is only effect for test_verifier.


Could you try to run the above g++ command by adding 
test_core_extern.skel.h back, something like

 > g++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
 > -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
 > -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/b
 > pf/tools/include -I/home/dileks/src/linux-kernel/git/include/generated
 > -I/home/dileks/src/linux-kernel/git/tools/lib
 > -I/home/dileks/src/linux-kernel/git/tools/include
 > -I/home/dileks/src/linux-kernel/git/tools/include/uapi
 > -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
 > -Wno-unused-command-line-argument -Wno-format-security
 > -Dbpf_prog_load=bpf_prog_test_load
 > -Dbpf_load_program=bpf_test_load_program test_cpp.cpp
 > test_core_extern.skel.h
 > 
/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
 > -lcap -lelf -lz -lrt -lpthread -o
 > /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp

The issue could be somewhere else?

> 
> $ grep test_cpp ../make-log_tools-testing-selftests-bpf_clang_g++.txt
> | grep test_core_extern.skel.h
> [ EMPTY ]
> 
> As said I do NOT use bpf-next.
> 
> - Sedat -
> 
> 
> 
> - Sedat -
> 
