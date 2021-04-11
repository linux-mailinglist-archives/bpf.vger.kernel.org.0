Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40EA35B6B0
	for <lists+bpf@lfdr.de>; Sun, 11 Apr 2021 21:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbhDKTIn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Apr 2021 15:08:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36976 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235420AbhDKTIm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 11 Apr 2021 15:08:42 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13BJ6BJ3025269;
        Sun, 11 Apr 2021 12:08:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=64Xx/hF8Dwl2okKM6VDK9zd+RBvkuIjznMBWoohiI0o=;
 b=L11wOulg57jXlTEJ2Gab2lJ8Mz6Vx3P42xbsUB+UPWMk+cdhcp+c4s6iJ3ADLdNJUiTX
 ZZWGuG2eLGRg2WOPp7aM4M3VaGumFDTym1IxuoBvxe1FWcGiBSNbEDKPWr5zZ4dJYbjm
 7oMcHKNdGTFfVwTslreRmNCHeXWKk5q+D1Y= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37uv3p9w54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 11 Apr 2021 12:08:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 11 Apr 2021 12:08:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbcjjdAu6PK0lXlt7PW2X4qzJdGp7bt3D+w5kB3wXjMxzUW2qxDFh2Qg7GO+fbK4EccLBN03xdCf+VpsclHdSFaTtmt6EFJtfl3wnw8H7QupRVsmY4025bV4ywUKGLaIU8ehXxcNew4EPHdsCPjJSRElXn9BnugeJRMD0j50P5GvF80H7en/Asu8e1OG5k1o4KrKUafHOcbMFToU/EN4cMDWW8VAeJjUGC0xErwDfE5aHzBHPEhahguwVPbLRAYNIKaGlnf+6peAZBnqIZWr1qIv7ab2rW2xz1JsPPx3EJCdytV5pKEbOd9EpINFuDE3PNK0KJgRQI6BrQPrucSw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64Xx/hF8Dwl2okKM6VDK9zd+RBvkuIjznMBWoohiI0o=;
 b=H2Qu/EJvJjfxQKQRfxtizzxGdOHXPChjqkmERPF+ggjiVacQQK/Oxle4gouJsIRNkXiToF/VaFAqnrhm3HYj9JeJkFZUk3msXfi53HmmC+jCZOtBa0RrqS+YT7bjefXBxs4y04+El9oU8VvlJp40Om2pM3ERUQ3BWL/0J6hwRfI8xS3hr7gDJV6TBjNzMchKv+e6kqt06P9rb8fLPK+6tM28jTYM3ImVRb3vfCNhr4dWwGdfMN4bqCGkWsuiW+tgRQze1B/AYkJnLYBPkqF0J+bFgF/glxYSE80Wvi9P0WbJR8wuDZuW9Bxf8Ctt3cRR/wChcafgmLC3e+g9b5mdDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2206.namprd15.prod.outlook.com (2603:10b6:805:22::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Sun, 11 Apr
 2021 19:08:17 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Sun, 11 Apr 2021
 19:08:17 +0000
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: fix test_cpp compilation
 failure with clang
To:     <sedat.dilek@gmail.com>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>
References: <20210410164925.768741-1-yhs@fb.com>
 <20210410164940.770304-1-yhs@fb.com>
 <CA+icZUXzCpHWk8Vm5D4ZcCbdd9gqipVD5ALCw6SGTFbYfdJZiA@mail.gmail.com>
 <7c82c0f5-2a96-7a5c-b090-f26c9351786c@fb.com>
 <CA+icZUWwSg4Nd+AzAMx8Os4iAfs=40zeoYn0eVKg3Cy7fB5Cow@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3f224f2c-bb7e-accc-b095-7fee8210861b@fb.com>
Date:   Sun, 11 Apr 2021 12:08:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <CA+icZUWwSg4Nd+AzAMx8Os4iAfs=40zeoYn0eVKg3Cy7fB5Cow@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:ec9]
X-ClientProxiedBy: MWHPR21CA0042.namprd21.prod.outlook.com
 (2603:10b6:300:129::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::110f] (2620:10d:c090:400::5:ec9) by MWHPR21CA0042.namprd21.prod.outlook.com (2603:10b6:300:129::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.1 via Frontend Transport; Sun, 11 Apr 2021 19:08:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 236918d3-7e2e-41b6-6ee9-08d8fd1d29c6
X-MS-TrafficTypeDiagnostic: SN6PR15MB2206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB2206C4C69E959EA903AF9CB1D3719@SN6PR15MB2206.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbE74aHPBLKqK7OXVoSFuMf2qaBmRUx3D6J0SsaLv/Mr+2j2HmjWp0m3hmNsby107C7j7l4PSLFCCJby99O/S0YbEUS7Iu+iu3tOv2ipL7XSYbJAKmCJt7UfAuPAH9/AShU9JgALbJh7LA1XWGQdoDM7CR4Hs/uOrW0awVkAJK8nFPVCXeAkjHRVIuW5fwMsI5niFP3fr8RnShDBY9gBKj6anAMBQ68HWwTZPTP0huGRK7tpslQe6tHrngEAj29xWeZ7BPQtfg1L73fJYdFJWVREcB8NuyNLJVyMoEU8t3uNnRzuOIRvvXLsKbWuYQucRrqZvAIwPChqkpcjeRar/JZBadp1+B3Lkvs8IO98JNzldzkyHmxK5lb4jqSmu1TdNE9NLP/uH2phDx3eHO/W4dXsdcAU0OLFusij539Jl+sdL6M806FmosJGojPTxonCwxrj5xrfRTwzO8wc7mlanziiiaH1C6ZFWO2pLDZnbHY+C2RKplW421LW16/EWb93zxonz7HAL/QQyTlp0JhPxxgg9tMGG7TtpnFYYZewJxmaCG23qp/Vj9ye6ePbVgWLPABI43jK/lkmz4jBsWfdU5RL75T0C6wd1VsFFU8xMJbWBOMqe+Vm4dS2ROOe55czWJ3ZrCfhtNJ8qz7f3uo7sJPlFSm3eDSxkLPRdlBE5ql2PWJudFj+Uowa/lN625/4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(346002)(396003)(136003)(5660300002)(54906003)(2906002)(30864003)(83380400001)(316002)(16526019)(186003)(66476007)(66556008)(52116002)(66946007)(478600001)(36756003)(38100700002)(6666004)(2616005)(6486002)(86362001)(4326008)(8676002)(6916009)(8936002)(31696002)(31686004)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QW1hYThyK3loaXY2dVBSNXBtV2RBYlMreWxIaDZmbFplbnNUV3lMVEJBZXJU?=
 =?utf-8?B?dEVycStiQ3NMek9KRHJVM0VROVBLNmNRY3BKRVRHNk0zUXU3bmVydVdzU1lv?=
 =?utf-8?B?SDROSmpYQlhUWkhkQU43and3N3o4dDJpc2tnL09yMFM4Y1R1cEhxbVkzeldI?=
 =?utf-8?B?TXNYZmF2SFpJYXBMRFVXcERBV3NubTFlT2J0SC9Pd0J0MkJRUlYwNTU2ZHhm?=
 =?utf-8?B?ZTIzTHZFMGZkdUk1cXJUaGJtSFhCbFN5MmtHOVg4eVg0ZU5MY2dCTGx3K1pz?=
 =?utf-8?B?UEJ0L1F2eXNCdDlkSzBBTXNDV3VPaVdUY3MxWlBOSDg0ZFFLQ3dBTWE2V3RK?=
 =?utf-8?B?Z0NpMURxeklERWNQSWx3SHVMQ2VqTVNYcko2aGw0T1F1WjNNWWlJTWs1VVUx?=
 =?utf-8?B?ZklmM2lxRGFFWXF2cnJTbG1Ockwvb25SMlJBWXZFOERWd2c1MWNMTXJWM3Zs?=
 =?utf-8?B?NFMxQjRyMk5xZUZuRWdlTERWR3FscDAvQWhIUW5BNzFZVnd1eWZwWUMyUjBG?=
 =?utf-8?B?QlRCMmg0eXlFTmV4YWNEQk96UG4zTUE0YnlpNFlTWFEwRk9MMnRsMGNCaEFX?=
 =?utf-8?B?VW1Db1hlN1NBMHJLNUF5TXlNQWx1OWhxUHhVd2lwTUNTcVFiUTRKOEI1dFRF?=
 =?utf-8?B?VFZVZldkaFk3dmJoMk5uWW40TnJPZGZTcW9GQWFpMlB6M0l2eUVzMmRYQ3Er?=
 =?utf-8?B?YVljZkNEM09LeTNmV3JiSUphcFVuanlaZTRCSEprNWdRQ3R5Q2UwbWJzZklX?=
 =?utf-8?B?ZlZNU2FFOHBEZEs4dDRZN1NvWHNFcjE5K2JCV3RyQjdvbUo4MDNzOUNiakxh?=
 =?utf-8?B?c0RkQS9NVXBHdEIxZXJ6bEtpNHhLNGRzVFVUSU9jVHA2bUtSMWE5Wk82TE52?=
 =?utf-8?B?ZnBSdXZXd2d1VzlMd3JvRjJ1ZEMyWWVLa2dWYnlDNG5oK2xXcW1kU0lES3Jj?=
 =?utf-8?B?SFRXMnFsWGtqb3pDblU5dkpJZ0hYTHA5VlV5a096ZmUvUjl5STZWNytrMWk3?=
 =?utf-8?B?dG1Iakt5NktNQTRmSWlKaVk4eHVyU1k2cnZEZllOT0x0MlRlUEV4bDc3blo3?=
 =?utf-8?B?QkQ3R1BVdnRjWXlaWXY0RHdIR2xLdVNZVEVxa2ZKOWM4cms3eUFCNGRvdFVK?=
 =?utf-8?B?S0FaemgxdTZWNEkxTW5MU0FTblBiYXZmK2d5NUI3YWJYb0thRGc5NmMyUkw1?=
 =?utf-8?B?UFBPM3BzVm0xNktkbmx5SjJONmRUMUYwQW56RjB5MVI3K2RFWlVMbjNBZzli?=
 =?utf-8?B?MGcrZDNxMTR1K25QUXAxVGRmYmc5Vjl1ZkptQ2p4Rmt2TjRwR21PeGlqcC9C?=
 =?utf-8?B?OTJheG4xRERIa25vL2UwTkZTVkh0a3VJSDE5WXRWOXA3TFBkQmdHLzZ6TGFm?=
 =?utf-8?B?aStWUmQ5VUxjTEIxeXpNZmYzbmhUWkZndXA1Y1ltUHFDNUtTQkE0Ty8vcUJV?=
 =?utf-8?B?ZjkraWFFY1Q4MWZYRCs3dEdBVytQdy9VL2NPSzVzTlF6RzlzakoyR2IrNkJ4?=
 =?utf-8?B?S0o4cEp0bVh0eklzMldFNk14RnltOVJpT0lGMDhxMGF3bHl2eDd2a0c2MUU5?=
 =?utf-8?B?dW1iRVVaYkt3MEtxQnFIdEllWHhSUEZTUFdNTWVmZE12ZHIwaWpXeWFnUjJn?=
 =?utf-8?B?ZmoxeXhuREw2L0lLa3I2ZXpmam1jdGR2b1dtaUYzNXArSUx1Q0pwUkN6SkFV?=
 =?utf-8?B?RkVJZ3FlL2E3UzZuV2E3S0ZiTWlNNmRFbCtlVmNMUTdUMzRtZDltblM3T2Fq?=
 =?utf-8?B?RXRFVkkrcHBLY2tJSlFZelRJRm5nOUVFUFMxR0dzM3BNcno3WlFSQzNhTlB5?=
 =?utf-8?Q?9cJLerB6Dsz/Bc3NdrnWd+tf7cF2cxhStT68w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 236918d3-7e2e-41b6-6ee9-08d8fd1d29c6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2021 19:08:17.1443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKTgsZ0pNI5nEJHOzIi+txZ5rWmgprNEK8yLHkesGuXY1NzJZ/wQhgfUrYktjEQ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2206
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: llAUSrvtJkYngzZRDn1hvzrJWNjXhY9N
X-Proofpoint-GUID: llAUSrvtJkYngzZRDn1hvzrJWNjXhY9N
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-11_09:2021-04-09,2021-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104110148
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/11/21 10:31 AM, Sedat Dilek wrote:
> On Sun, Apr 11, 2021 at 7:20 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 4/11/21 3:47 AM, Sedat Dilek wrote:
>>> On Sat, Apr 10, 2021 at 6:49 PM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>> With clang compiler:
>>>>     make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
>>>>     make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
>>>> the test_cpp build failed due to the failure:
>>>>     warning: treating 'c-header' input as 'c++-header' when in C++ mode, this behavior is deprecated [-Wdeprecated]
>>>>     clang-13: warning: cannot specify -o when generating multiple output files
>>>>
>>>> test_cpp compilation flag looks like:
>>>>     clang++ -g -Og -rdynamic -Wall -I<...> ... \
>>>>     -Dbpf_prog_load=bpf_prog_test_load -Dbpf_load_program=bpf_test_load_program \
>>>>     test_cpp.cpp <...>/test_core_extern.skel.h <...>/libbpf.a <...>/test_stub.o \
>>>>     -lcap -lelf -lz -lrt -lpthread -o <...>/test_cpp
>>>>
>>>> The clang++ compiler complains the header file in the command line.
>>>> Let us remove the header file from the command line which is not intended
>>>> any way, and this fixed the problem.
>>>>
>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>>> ---
>>>>    tools/testing/selftests/bpf/Makefile | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>>>> index 6448c626498f..bbd61cc3889b 100644
>>>> --- a/tools/testing/selftests/bpf/Makefile
>>>> +++ b/tools/testing/selftests/bpf/Makefile
>>>> @@ -481,7 +481,7 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
>>>>    # Make sure we are able to include and link libbpf against c++.
>>>>    $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
>>>>           $(call msg,CXX,,$@)
>>>> -       $(Q)$(CXX) $(CFLAGS) $^ $(LDLIBS) -o $@
>>>> +       $(Q)$(CXX) $(CFLAGS) test_cpp.cpp $(BPFOBJ) $(LDLIBS) -o $@
>>>>
>>>>    # Benchmark runner
>>>>    $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h
>>>> --
>>>> 2.30.2
>>>>
>>>
>>> NOTE: bpf-next might be different from my build-environment.
>>>
>>> Yonghong, can you please re-test by adding explicitly CXX=g++ to your make line?
>>>
>>> Here I have:
>>>
>>> $ grep test_cpp make-log_tools-testing-selftests-bpf_clang_clang++.txt
>>> 1907:clang++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/include
>>> -I/home/dileks/src/linux-kernel/git/include/generated
>>> -I/home/dileks/src/linux-kernel/git/tools/lib
>>> -I/home/dileks/src/linux-kernel/git/tools/include
>>> -I/home/dileks/src/linux-kernel/git/tools/include/uapi
>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
>>> -Wno-unused-command-line-argument -Wno-format-security
>>> -Dbpf_prog_load=bpf_prog_test_load
>>> -Dbpf_load_program=bpf_test_load_program test_cpp.cpp
>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
>>> -lcap -lelf -lz -lrt -lpthread -o
>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp
>>>
>>> This clang++ line does not include <...>/test_core_extern.skel.h ^^^
>>>
>>> $ grep test_core_extern.skel.h
>>> make-log_tools-testing-selftests-bpf_clang_clang++.txt
>>> 704:/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/sbin/bpftool
>>> gen skeleton /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_co
>>> re_extern.o > /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_core_extern.skel.h
>>> 1592:/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/sbin/bpftool
>>> gen skeleton /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/no_alu
>>> 32/test_core_extern.o >
>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/no_alu32/test_core_extern.skel.h
>>>
>>> Checking test_cpp:
>>>
>>> $ /opt/llvm-toolchain/bin/llvm-objdump-12 -Dr test_cpp | grep extern
>>> 0000000000417e50 <cmp_externs>:
>>>    417e54: 75 22                         jne     0x417e78 <cmp_externs+0x28>
>>>    417e59: 75 10                         jne     0x417e6b <cmp_externs+0x1b>
>>>    417e61: 75 21                         jne     0x417e84 <cmp_externs+0x34>
>>>    417e69: 75 1e                         jne     0x417e89 <cmp_externs+0x39>
>>>    417e87: eb f2                         jmp     0x417e7b <cmp_externs+0x2b>
>>>    417e8c: eb ed                         jmp     0x417e7b <cmp_externs+0x2b>
>>>
>>> $ /opt/llvm-toolchain/bin/llvm-objdump-12 -Dr test_cpp | grep core_extern
>>> [ EMPTY ]
>>>
>>> When compiled with g++ in an earlier setup this contained "core_extern".
>>>
>>> With this version of your patchser it breaks *here* when using CXX=g++
>>> (and uses /usr/bin/ld as linker):
>>>
>>> g++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/b
>>> pf/tools/include -I/home/dileks/src/linux-kernel/git/include/generated
>>> -I/home/dileks/src/linux-kernel/git/tools/lib
>>> -I/home/dileks/src/linux-kernel/git/tools/include
>>> -I/home/dileks/src/linux-kernel/git/tools/include/uapi
>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
>>> -Wno-unused-command-line-argument -Wno-format-security
>>> -Dbpf_prog_load=bpf_prog_test_load
>>> -Dbpf_load_program=bpf_test_load_program test_cpp.cpp
>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
>>> -lcap -lelf -lz -lrt -lpthread -o
>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp
>>>
>>> /usr/bin/ld: /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a(libbpf-in.o):
>>> relocation R_X86_64_32 against `.rodata.str1.1' ca
>>> n not be used when making a PIE object; recompile with -fPIE
>>> collect2: error: ld returned 1 exit status
>>> make: *** [Makefile:457:
>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp]
>>> Error 1
>>
>> I cannot reproduce the issue with g++ with bpf-next, my command line is
>>
>> g++ -g -Og -rdynamic -Wall
>> -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf
>> -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include
>> -I/home/yhs/work/bpf-next/include/generated
>> -I/home/yhs/work/bpf-next/tools/lib
>> -I/home/yhs/work/bpf-next/tools/include
>> -I/home/yhs/work/bpf-next/tools/include/uapi
>> -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf
>> -Wno-unused-command-line-argument -Wno-format-security
>> -Dbpf_prog_load=bpf_prog_test_load
>> -Dbpf_load_program=bpf_test_load_program test_cpp.cpp
>> /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
>> -lcap -lelf -lz -lrt -lpthread -o
>> /home/yhs/work/bpf-next/tools/testing/selftests/bpf/test_cpp
>>
>> I modified to
>> g++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
>> -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf ...
>> and cannot reproduce the issue.
>> The macro HAVE_GENHDR is only effect for test_verifier.
>>
>>
>> Could you try to run the above g++ command by adding
>> test_core_extern.skel.h back, something like
>>
>>   > g++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
>>   > -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
>>   > -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/b
>>   > pf/tools/include -I/home/dileks/src/linux-kernel/git/include/generated
>>   > -I/home/dileks/src/linux-kernel/git/tools/lib
>>   > -I/home/dileks/src/linux-kernel/git/tools/include
>>   > -I/home/dileks/src/linux-kernel/git/tools/include/uapi
>>   > -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
>>   > -Wno-unused-command-line-argument -Wno-format-security
>>   > -Dbpf_prog_load=bpf_prog_test_load
>>   > -Dbpf_load_program=bpf_test_load_program test_cpp.cpp
>>   > test_core_extern.skel.h
>>   >
>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
>>   > -lcap -lelf -lz -lrt -lpthread -o
>>   > /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp
>>
>> The issue could be somewhere else?
>>
> 
> I have seen all that *skel* was reworked in bpf-next, so this is an issue here.
> 
> Adding test_core_extern.skel.h:
> 
> $ cd /tools/testing/selftests/bpf/
> 
> $ file test_core_extern.skel.h
> test_core_extern.skel.h: C source, ASCII text
> 
> $ g++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
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
> test_core_extern.skel.h
> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
> -lcap -lelf -lz -lrt -lpthread -o
> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp
> /usr/bin/ld: /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a(libbpf-in.o):
> relocation R_X86_64_32 against `.rodata.str1.1' ca
> n not be used when making a PIE object; recompile with -fPIE
> collect2: error: ld returned 1 exit status

So the issue is not related to this patch since adding 
test_core_extern.skel.h the failure is still there.

So looks like this is g++ compilation issue. So you should be
able to reproduce the issue without this patch set, right?

My gcc compiled libbpf.a also has a bunch of R_X86_64_32 relations
against the .rodata.str1.1 section:

$ readelf -r libbpf.a | less
File: libbpf.a(libbpf-in.o)

Relocation section '.rela.text' at offset 0x11a4b8 contains 3152 entries:
   Offset          Info           Type           Sym. Value    Sym. Name 
+ Addend
000000000136  00020000000b R_X86_64_32S      0000000000000000 .rodata + 0
00000000013b  00030000000a R_X86_64_32       0000000000000000 
.rodata.str1.1 + 6e
000000000141  00030000000a R_X86_64_32       0000000000000000 
.rodata.str1.1 + c
000000000147  00030000000a R_X86_64_32       0000000000000000 
.rodata.str1.1 + 10
00000000014d  00030000000a R_X86_64_32       0000000000000000 
.rodata.str1.1 + 16
000000000153  00030000000a R_X86_64_32       0000000000000000 
.rodata.str1.1 + 1d
000000000159  00030000000a R_X86_64_32       0000000000000000 
.rodata.str1.1 + 23
00000000015f  00030000000a R_X86_64_32       0000000000000000 
.rodata.str1.1 + 28
...

and I did not see any issues.
Adding '-###' to the compilation flags you can find the flags for
each subcommand, for linker, I have

  /usr/libexec/gcc/x86_64-redhat-linux/8/collect2 -plugin 
/usr/libexec/gcc/x86_64-redhat-linux/8/liblto_plugin.so 
"-plugin-opt=/usr/libexec/gcc/x86_64-redhat-linux/8/lto-wrapper" 
"-plugin-opt=-fresolution=/tmp/ccjktcVg.res" 
"-plugin-opt=-pass-through=-lgcc_s" "-plugin-opt=-pass-through=-lgcc" 
"-plugin-opt=-pass-through=-lc" "-plugin-opt=-pass-through=-lgcc_s" 
"-plugin-opt=-pass-through=-lgcc" --build-id --no-add-needed 
--eh-frame-hdr "--hash-style=gnu" -m elf_x86_64 -export-dynamic 
-dynamic-linker /lib64/ld-linux-x86-64.so.2 -o 
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/test_cpp 
/usr/lib/gcc/x86_64-redhat-linux/8/../../../../lib64/crt1.o 
/usr/lib/gcc/x86_64-redhat-linux/8/../../../../lib64/crti.o 
/usr/lib/gcc/x86_64-redhat-linux/8/crtbegin.o 
-L/usr/lib/gcc/x86_64-redhat-linux/8 
-L/usr/lib/gcc/x86_64-redhat-linux/8/../../../../lib64 -L/lib/../lib64 
-L/usr/lib/../lib64 -L/usr/lib/gcc/x86_64-redhat-linux/8/../../.. 
/tmp/cc0xqkPi.o 
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a 
-lcap -lelf -lz -lrt -lpthread "-lstdc++" -lm -lgcc_s -lgcc -lc -lgcc_s 
-lgcc /usr/lib/gcc/x86_64-redhat-linux/8/crtend.o 
/usr/lib/gcc/x86_64-redhat-linux/8/../../../../lib64/crtn.o
COLLECT_GCC_OPTIONS='-g' '-rdynamic' '-Wall' '-O2' '-D' 'HAVE_GENHDR' 
'-I' '/home/yhs/work/bpf-next/tools/testing/selftests/bpf' '-I' 
'/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include' '-I' 
'/home/yhs/work/bpf-next/include/generated' '-I' 
'/home/yhs/work/bpf-next/tools/lib' '-I' 
'/home/yhs/work/bpf-next/tools/include' '-I' 
'/home/yhs/work/bpf-next/tools/include/uapi' '-I' 
'/home/yhs/work/bpf-next/tools/testing/selftests/bpf' 
'-Wno-uuunused-command-line-argument' '-Wno-format-security' '-D' 
'bpf_prog_load=bpf_prog_test_load' '-D' 
'bpf_load_program=bpf_test_load_program' '-o' 
'/home/yhs/work/bpf-next/tools/testing/selftests/bpf/test_cpp' 
'-shared-libgcc' '-mtune=generic' '-march=x86-64'

Not sure whether you will see some different COLLECT_GCC_OPTIONS flags 
or not.

There is not much I can do here since I cannot reproduce the issue.
Maybe you can help to narrow down the reason of the failure a little
bit more.

> 
> Write that test_cpp.cpp in C :-)?

test_cpp.cpp is intentionally to test libbpf used by a c++ application.

> 
> BTW, did you check (llvm-)objdump output?
> 
> $ /opt/llvm-toolchain/bin/llvm-objdump-12 -Dr test_cpp | grep core_extern

This is what I got with g++ compiled test_cpp:

$ llvm-objdump -Dr test_cpp | grep core_extern
   406a80: e8 5b 01 00 00                callq   0x406be0 
<_ZL25test_core_extern__destroyP16test_core_extern>
   406ab9: e8 22 01 00 00                callq   0x406be0 
<_ZL25test_core_extern__destroyP16test_core_extern>
0000000000406be0 <_ZL25test_core_extern__destroyP16test_core_extern>:
   406be3: 74 1a                         je      0x406bff 
<_ZL25test_core_extern__destroyP16test_core_extern+0x1f>
   406bef: 74 05                         je      0x406bf6 
<_ZL25test_core_extern__destroyP16test_core_extern+0x16>

> 
> - Sedat -
> 
>>>
>>> $ grep test_cpp ../make-log_tools-testing-selftests-bpf_clang_g++.txt
>>> | grep test_core_extern.skel.h
>>> [ EMPTY ]
>>>
>>> As said I do NOT use bpf-next.
>>>
>>> - Sedat -
>>>
>>>
>>>
>>> - Sedat -
>>>
