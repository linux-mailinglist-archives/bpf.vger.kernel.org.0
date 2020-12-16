Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59C12DC77C
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 21:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgLPUBo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 15:01:44 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9571 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727027AbgLPUBo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Dec 2020 15:01:44 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 0BGJxDo9012898;
        Wed, 16 Dec 2020 12:00:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=06slGa2SL10Kb/dPVT1K20JNLBZ+i2vsxTk/Rpa92B0=;
 b=pQbRK3dp9v9io8bY4RAJrXCCmOJlRFhrB9A/U/y6/WbRNuuDQ8Ff4GDNabjp95DWyzJK
 bA8PnnDvbiv3T/RHLX7IAkuMjvuilg1HtjIXDVt5aCZZHHrQnn+WyjOCQi46AihA985I
 rYG0/vwAFZvmXgTn9aFm81VEvgOGIRXQjHQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 35f4vk5qtd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Dec 2020 12:00:42 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Dec 2020 12:00:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfTdKVQhDSrsnM7y9NuMhIAUT+42MWHw6sJO8Rn/Xoo1mAWyNj/HCwbjjCzefMrqqhuwPcjRojZiQnmykH/EVoPPIc29yKhrBx7YTRa6IfdfDKFdN+gXNoqIdpC6FZbt4s6a4vCc4C2CpbErjXg2OM0NUyo6GQZdNdBxmGNAfIhRJSFNtYw65rHKNKUXZr3tfXo2gLYbaShHAKnEPiPjJN9jBy+4z87gGxX6DktyZe2IzvZ0ysBHOvggh5Cs4fRz+q2Egr8ntqXWzHTAK2XvyPKGaTzptXKxa1adS1xmcDzCDlrJeZoD+WRfRIKvoIzJWUQPHzfHZYn3+Jk70Tfz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=612J+PYUtizOoP1WpHyCwxSi1MW0xRIEhVPaIK4mfQI=;
 b=nSeMBupDuk8zoULP2rsIu0iPLgoYgSkN9Q0vYzkb5kiyscsTNv/HAoO8HpZ0dItY+VMoJ93+1rwy03oMSyO/WRL48QweXVhRyH9bhpIHifmKepyeP3r3jm/jdlatbRNwnDCUehqDyBIx3o/GqyeN+Sk+nhHd5cQ4BBi0Wdu1gT3oM0fHHz7uXfxV25xYwzlXi8DumFX39MjoBLyoGDe9BjBx44CfD59+Q/YF5+X0cEkfakncEuH+HSgNg+uXgc2xN5pUimU3WKto3nkUo3MP9Vhr7TgK5Fq/6BO1o2cftJAjF2w65RtxKtt2IQkc2N+E6SkfVQHJ6Q7jLO3oKpZSBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=612J+PYUtizOoP1WpHyCwxSi1MW0xRIEhVPaIK4mfQI=;
 b=LojZYNnjQD/At9kJxMp1HuzcZhMvgbxengfrDO+JAVcCM5H568iMtJEmUp/440+EibOXAzo53N+ne5AwREL1rcx4si2GdGuJjuAopwYvQSRNSb4A/GyImLe2mcRXG7ZnFUVZkB8b2nD+C+SmFu+WxTt9E4Pq92c+6+iJb1Arxj4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB4085.namprd15.prod.outlook.com (2603:10b6:a02:bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Wed, 16 Dec
 2020 20:00:39 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 20:00:39 +0000
Subject: Re: [PATCH bpf-next v4 10/11] bpf: Add tests for new BPF atomic
 operations
To:     Brendan Jackman <jackmanb@google.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201207160734.2345502-1-jackmanb@google.com>
 <20201207160734.2345502-11-jackmanb@google.com>
 <3adb88d5-b8d8-9c15-a988-7c10f86686fd@fb.com> <X890lro0A5mFJHyD@google.com>
 <24c9b2d7-f9b1-d7d4-71dc-47f4208ee6e9@fb.com> <X8+w8g56z11AKNci@google.com>
 <67ee3925-9388-c9d4-8ad8-9c28cff35d55@fb.com> <X9iaHF4FdFAPYBLx@google.com>
 <3f49c18e-fed6-b005-19ca-b11ad620f535@fb.com>
 <CA+i-1C1qfhgZOnpD1kZW9_UzGSDpWgmqGM+YgCiJr5qxx4NeFg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <23484748-473b-fc05-e96e-4176b523c349@fb.com>
Date:   Wed, 16 Dec 2020 12:00:35 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <CA+i-1C1qfhgZOnpD1kZW9_UzGSDpWgmqGM+YgCiJr5qxx4NeFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:4fea]
X-ClientProxiedBy: MW4PR04CA0402.namprd04.prod.outlook.com
 (2603:10b6:303:80::17) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::12e6] (2620:10d:c090:400::5:4fea) by MW4PR04CA0402.namprd04.prod.outlook.com (2603:10b6:303:80::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17 via Frontend Transport; Wed, 16 Dec 2020 20:00:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfd360d6-0aa4-455e-624b-08d8a1fd4301
X-MS-TrafficTypeDiagnostic: BYAPR15MB4085:
X-Microsoft-Antispam-PRVS: <BYAPR15MB40858589A4202DA51B312D64D3C50@BYAPR15MB4085.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3golVVwE3r2T7Emmh7zrifYqma5dRnCZbNl9g7J4cna1NF+4pOvZ7nnvMtAfW4lTWWpTB+hl5XTU1pon7AUcbtao8VIPd8gdSHyTMcap2NkE4HjvM3XnJKnerwA0tUnQ7O4uhGnAnRpY9Tp628TYssoLaohjxTce1FrP07C7A994Dh47BXEEQFk4sEqz8Vlbzn7me1hP0vSHIp6gw0/ZXoxvK5I3RD1QY+kxEo5XOLKWOx7XNoRJT0tUF5ur/DDgZmY+tWi/C4EKMkzRjEoAjn0NjrcGbcfNJr7b1kTS4v7bbzD42LVbqjQivutd5OnPFmgoow9YZzMmGjpMN4M14rZ+ItjWEchdYs0RC9G6G+tclaHTCHwfUhsHW8ukSmoD29W4Xt2bbwNrjwKSVWtV98fQJyNmv+0mlsHIGtyml86JKhpcurk7Y9w9tNpjlTrlB0Qmz13knr2vAAc9bnKF7g9XL73Dm16wNIptZV8UwkU08j63Sku6bOIBtF1Bcc9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(396003)(366004)(346002)(186003)(8936002)(478600001)(30864003)(16526019)(83380400001)(5660300002)(31686004)(6916009)(2616005)(54906003)(8676002)(4326008)(316002)(66946007)(52116002)(53546011)(2906002)(966005)(31696002)(66574015)(66556008)(6486002)(36756003)(66476007)(6666004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: xsBKZ/RpNUiG2mOzvAXh8xqbP+YQ301/zNXRYckvMrFVGfZ/KlCsLdHUrTkCihHeoMCfrB9ZSy4AohQWY3n9bSiXL3mT2Bqx4cdULWNtBEnKODiLcX/XjuPNj+Kp5R33mcks+yjgmivkVCu0zC06j1E78iluCfgkklG4jdoTRo9OvLf5VQi0EVJklOVr2jiBbZIPXDneUQkym7MKRkE7WkSlTyCetky1YgYIcTOJWoUpSeojg2yUKuGggyZr6kvWwMX/AVn3a5oWeralO9EpL3r5EcLd/XQKNj9jLIOiXCQvwb/sy2mF9u0mXycyz021tlFB/ldPVUi+s2Xhxdc4ul36MzI8rWiMyOcnt6FVowupCDpVcPfpPGNfSSl2XrAGBwXpU7rzxhsUtHphZrHuI0jaBMVc9xVy/DblkIGYnVbJVP9lMpi140Y4KmqJ6L4BEM9IXkeIz9Cz/4XNdFNtCVRfmUXwTfm04JWTzUbQRIe4S/W5oLPcFB0A6MM6f29eE2f78daN7hOWrCxPbNYDXbs2fg5ZvYsTxpwvzObAJ1aGBGYUzU5ZsKfzv0/EVo1Fv7l5OGubo9DKKkSsQkSkx1JFUtyUaaYj+UlIX/ssXCiTnNENnAvRSQTTg2nWZ4g6p8b3Wi0t1hKAcz4g7BhtzLuBrwJvu5NPZWm8WEs0/WbEFd9qGH3DI7OWb1MA5EQ8696rrN6Q/vAcQGkzVIOwBdLXEDCt3Ugw6sSLvYy0Bqhi1f958s1rZ+uTtJlfR2W+oPNw+9YvLvC8iRXniQP/cv2E7a00NBgVh3TyGNV6f+U=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2020 20:00:39.4857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd360d6-0aa4-455e-624b-08d8a1fd4301
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIBUuGl9B6M3C10hQbJXef3/HrkeMkowglu7hJM11OKBJAMDZYT+9Zz49w7h879E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4085
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-16_08:2020-12-15,2020-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160123
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/16/20 3:51 AM, Brendan Jackman wrote:
> On Wed, 16 Dec 2020 at 08:19, Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 12/15/20 3:12 AM, Brendan Jackman wrote:
>>> On Tue, Dec 08, 2020 at 10:15:35AM -0800, Yonghong Song wrote:
>>>>
>>>>
>>>> On 12/8/20 8:59 AM, Brendan Jackman wrote:
>>>>> On Tue, Dec 08, 2020 at 08:38:04AM -0800, Yonghong Song wrote:
>>>>>>
>>>>>>
>>>>>> On 12/8/20 4:41 AM, Brendan Jackman wrote:
>>>>>>> On Mon, Dec 07, 2020 at 07:18:57PM -0800, Yonghong Song wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 12/7/20 8:07 AM, Brendan Jackman wrote:
>>>>>>>>> The prog_test that's added depends on Clang/LLVM features added by
>>>>>>>>> Yonghong in commit 286daafd6512 (was https://reviews.llvm.org/D72184     ).
>>>>>>>>>
>>>>>>>>> Note the use of a define called ENABLE_ATOMICS_TESTS: this is used
>>>>>>>>> to:
>>>>>>>>>
>>>>>>>>>       - Avoid breaking the build for people on old versions of Clang
>>>>>>>>>       - Avoid needing separate lists of test objects for no_alu32, where
>>>>>>>>>         atomics are not supported even if Clang has the feature.
>>>>>>>>>
>>>>>>>>> The atomics_test.o BPF object is built unconditionally both for
>>>>>>>>> test_progs and test_progs-no_alu32. For test_progs, if Clang supports
>>>>>>>>> atomics, ENABLE_ATOMICS_TESTS is defined, so it includes the proper
>>>>>>>>> test code. Otherwise, progs and global vars are defined anyway, as
>>>>>>>>> stubs; this means that the skeleton user code still builds.
>>>>>>>>>
>>>>>>>>> The atomics_test.o userspace object is built once and used for both
>>>>>>>>> test_progs and test_progs-no_alu32. A variable called skip_tests is
>>>>>>>>> defined in the BPF object's data section, which tells the userspace
>>>>>>>>> object whether to skip the atomics test.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>>>>>>>>
>>>>>>>> Ack with minor comments below.
>>>>>>>>
>>>>>>>> Acked-by: Yonghong Song <yhs@fb.com>
>>>>>>>>
>>>>>>>>> ---
>>>>>>>>>       tools/testing/selftests/bpf/Makefile          |  10 +
>>>>>>>>>       .../selftests/bpf/prog_tests/atomics.c        | 246 ++++++++++++++++++
>>>>>>>>>       tools/testing/selftests/bpf/progs/atomics.c   | 154 +++++++++++
>>>>>>>>>       .../selftests/bpf/verifier/atomic_and.c       |  77 ++++++
>>>>>>>>>       .../selftests/bpf/verifier/atomic_cmpxchg.c   |  96 +++++++
>>>>>>>>>       .../selftests/bpf/verifier/atomic_fetch_add.c | 106 ++++++++
>>>>>>>>>       .../selftests/bpf/verifier/atomic_or.c        |  77 ++++++
>>>>>>>>>       .../selftests/bpf/verifier/atomic_xchg.c      |  46 ++++
>>>>>>>>>       .../selftests/bpf/verifier/atomic_xor.c       |  77 ++++++
>>>>>>>>>       9 files changed, 889 insertions(+)
>>>>>>>>>       create mode 100644 tools/testing/selftests/bpf/prog_tests/atomics.c
>>>>>>>>>       create mode 100644 tools/testing/selftests/bpf/progs/atomics.c
>>>>>>>>>       create mode 100644 tools/testing/selftests/bpf/verifier/atomic_and.c
>>>>>>>>>       create mode 100644 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
>>>>>>>>>       create mode 100644 tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
>>>>>>>>>       create mode 100644 tools/testing/selftests/bpf/verifier/atomic_or.c
>>>>>>>>>       create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xchg.c
>>>>>>>>>       create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xor.c
>>>>>>>>>
>>>>>>>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>>>>>>>>> index ac25ba5d0d6c..13bc1d736164 100644
>>>>>>>>> --- a/tools/testing/selftests/bpf/Makefile
>>>>>>>>> +++ b/tools/testing/selftests/bpf/Makefile
>>>>>>>>> @@ -239,6 +239,12 @@ BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)                      \
>>>>>>>>>               -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)                   \
>>>>>>>>>               -I$(abspath $(OUTPUT)/../usr/include)
>>>>>>>>> +# BPF atomics support was added to Clang in llvm-project commit 286daafd6512
>>>>>>>>> +# (release 12.0.0).
>>>>>>>>> +BPF_ATOMICS_SUPPORTED = $(shell \
>>>>>>>>> +       echo "int x = 0; int foo(void) { return __sync_val_compare_and_swap(&x, 1, 2); }" \
>>>>>>>>> +       | $(CLANG) -x cpp-output -S -target bpf -mcpu=v3 - -o /dev/null && echo 1 || echo 0)
>>>>>>>>
>>>>>>>> '-x c' here more intuitive?
>>>>>>>>
>>>>>>>>> +
>>>>>>>>>       CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
>>>>>>>>>                 -Wno-compare-distinct-pointer-types
>>>>>>>>> @@ -399,11 +405,15 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko    \
>>>>>>>>>                         $(wildcard progs/btf_dump_test_case_*.c)
>>>>>>>>>       TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
>>>>>>>>>       TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
>>>>>>>>> +ifeq ($(BPF_ATOMICS_SUPPORTED),1)
>>>>>>>>> +  TRUNNER_BPF_CFLAGS += -DENABLE_ATOMICS_TESTS
>>>>>>>>> +endif
>>>>>>>>>       TRUNNER_BPF_LDFLAGS := -mattr=+alu32
>>>>>>>>>       $(eval $(call DEFINE_TEST_RUNNER,test_progs))
>>>>>>>>>       # Define test_progs-no_alu32 test runner.
>>>>>>>>>       TRUNNER_BPF_BUILD_RULE := CLANG_NOALU32_BPF_BUILD_RULE
>>>>>>>>> +TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
>>>>>>>>>       TRUNNER_BPF_LDFLAGS :=
>>>>>>>>>       $(eval $(call DEFINE_TEST_RUNNER,test_progs,no_alu32))
>>>>>>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/atomics.c b/tools/testing/selftests/bpf/prog_tests/atomics.c
>>>>>>>>> new file mode 100644
>>>>>>>>> index 000000000000..c841a3abc2f7
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/atomics.c
>>>>>>>>> @@ -0,0 +1,246 @@
>>>>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>>>>> +
>>>>>>>>> +#include <test_progs.h>
>>>>>>>>> +
>>>>>>>>> +#include "atomics.skel.h"
>>>>>>>>> +
>>>>>>>>> +static void test_add(struct atomics *skel)
>>>>>>>>> +{
>>>>>>>>> +       int err, prog_fd;
>>>>>>>>> +       __u32 duration = 0, retval;
>>>>>>>>> +       struct bpf_link *link;
>>>>>>>>> +
>>>>>>>>> +       link = bpf_program__attach(skel->progs.add);
>>>>>>>>> +       if (CHECK(IS_ERR(link), "attach(add)", "err: %ld\n", PTR_ERR(link)))
>>>>>>>>> +               return;
>>>>>>>>> +
>>>>>>>>> +       prog_fd = bpf_program__fd(skel->progs.add);
>>>>>>>>> +       err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
>>>>>>>>> +                               NULL, NULL, &retval, &duration);
>>>>>>>>> +       if (CHECK(err || retval, "test_run add",
>>>>>>>>> +                 "err %d errno %d retval %d duration %d\n", err, errno, retval, duration))
>>>>>>>>> +               goto cleanup;
>>>>>>>>> +
>>>>>>>>> +       ASSERT_EQ(skel->data->add64_value, 3, "add64_value");
>>>>>>>>> +       ASSERT_EQ(skel->bss->add64_result, 1, "add64_result");
>>>>>>>>> +
>>>>>>>>> +       ASSERT_EQ(skel->data->add32_value, 3, "add32_value");
>>>>>>>>> +       ASSERT_EQ(skel->bss->add32_result, 1, "add32_result");
>>>>>>>>> +
>>>>>>>>> +       ASSERT_EQ(skel->bss->add_stack_value_copy, 3, "add_stack_value");
>>>>>>>>> +       ASSERT_EQ(skel->bss->add_stack_result, 1, "add_stack_result");
>>>>>>>>> +
>>>>>>>>> +       ASSERT_EQ(skel->data->add_noreturn_value, 3, "add_noreturn_value");
>>>>>>>>> +
>>>>>>>>> +cleanup:
>>>>>>>>> +       bpf_link__destroy(link);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>> [...]
>>>>>>>>> +
>>>>>>>>> +__u64 xchg64_value = 1;
>>>>>>>>> +__u64 xchg64_result = 0;
>>>>>>>>> +__u32 xchg32_value = 1;
>>>>>>>>> +__u32 xchg32_result = 0;
>>>>>>>>> +
>>>>>>>>> +SEC("fentry/bpf_fentry_test1")
>>>>>>>>> +int BPF_PROG(xchg, int a)
>>>>>>>>> +{
>>>>>>>>> +#ifdef ENABLE_ATOMICS_TESTS
>>>>>>>>> +       __u64 val64 = 2;
>>>>>>>>> +       __u32 val32 = 2;
>>>>>>>>> +
>>>>>>>>> +       __atomic_exchange(&xchg64_value, &val64, &xchg64_result, __ATOMIC_RELAXED);
>>>>>>>>> +       __atomic_exchange(&xchg32_value, &val32, &xchg32_result, __ATOMIC_RELAXED);
>>>>>>>>
>>>>>>>> Interesting to see this also works. I guess we probably won't advertise
>>>>>>>> this, right? Currently for LLVM, the memory ordering parameter is ignored.
>>>>>>>
>>>>>>> Well IIUC this specific case is fine: the ordering that you get with
>>>>>>> BPF_[CMP]XCHG (via kernel atomic_[cmpxchg]) is sequential consistency,
>>>>>>> and its' fine to provide a stronger ordering than the one requested. I
>>>>>>> should change it to say __ATOMIC_SEQ_CST to avoid confusing readers,
>>>>>>> though.
>>>>>>>
>>>>>>> (I wrote it this way because I didn't see a __sync* function for
>>>>>>> unconditional atomic exchange, and I didn't see an __atomic* function
>>>>>>> where you don't need to specify the ordering).
>>>>>>
>>>>>> For the above code,
>>>>>>       __atomic_exchange(&xchg64_value, &val64, &xchg64_result,
>>>>>> __ATOMIC_RELAXED);
>>>>>> It tries to do an atomic exchange between &xchg64_value and
>>>>>>     &val64, and store the old &xchg64_value to &xchg64_result. So it is
>>>>>> equivalent to
>>>>>>        xchg64_result = __sync_lock_test_and_set(&xchg64_value, val64);
>>>>>>
>>>>>> So I think this test case can be dropped.
>>>>>
>>>>> Ah nice, I didn't know about __sync_lock_test_and_set, let's switch to
>>>>> that I think.
>>>>>
>>>>>>> However... this led me to double-check the semantics and realise that we
>>>>>>> do have a problem with ordering: The kernel's atomic_{add,and,or,xor} do
>>>>>>> not imply memory barriers and therefore neither do the corresponding BPF
>>>>>>> instructions. That means Clang can compile this:
>>>>>>>
>>>>>>>      (void)__atomic_fetch_add(&val, 1, __ATOMIC_SEQ_CST)
>>>>>>>
>>>>>>> to a {.code = (BPF_STX | BPF_DW | BPF_ATOMIC), .imm = BPF_ADD},
>>>>>>> which is implemented with atomic_add, which doesn't actually satisfy
>>>>>>> __ATOMIC_SEQ_CST.
>>>>>>
>>>>>> This is the main reason in all my llvm selftests I did not use
>>>>>> __atomic_* intrinsics because we cannot handle *different* memory
>>>>>> ordering properly.
>>>>>>
>>>>>>>
>>>>>>> In fact... I think this is a pre-existing issue with BPF_XADD.
>>>>>>>
>>>>>>> If all I've written here is correct, the fix is to use
>>>>>>> (void)atomic_fetch_add etc (these imply barriers) even when BPF_FETCH is
>>>>>>> not set. And that change ought to be backported to fix BPF_XADD.
>>>>>>
>>>>>> We cannot change BPF_XADD behavior. If we change BPF_XADD to use
>>>>>> atomic_fetch_add, then suddenly old code compiled with llvm12 will
>>>>>> suddenly requires latest kernel, which will break userland very badly.
>>>>>
>>>>> Sorry I should have been more explicit: I meant that the fix would be to
>>>>> call atomic_fetch_add but discard the return value, purely for the
>>>>> implied barrier. The x86 JIT would stay the same. It would not break any
>>>>> existing code, only add ordering guarantees that the user probably
>>>>> already expected (since these builtins come from GCC originally and the
>>>>> GCC docs say "these builtins are considered a full barrier" [1])
>>>>>
>>>>> [1] https://gcc.gnu.org/onlinedocs/gcc-4.1.1/gcc/Atomic-Builtins.html
>>>>
>>>> This is indeed the issue. In the past, people already use gcc
>>>> __sync_fetch_and_add() for xadd instruction for which git generated
>>>> code does not implying barrier.
>>>>
>>>> The new atomics support has the following logic:
>>>>     . if return value is used, it is atomic_fetch_add
>>>>     . if return value is not used, it is xadd
>>>> The reason to do this is to preserve backward compabiility
>>>> and this way, we can get rid of -mcpu=v4.
>>>>
>>>> barrier issue is tricky and as we discussed earlier let us
>>>> delay this after basic atomics support landed. We may not
>>>> 100% conform to gcc __sync_fetch_and_add() or __atomic_*()
>>>> semantics. We do need to clearly document what is expected
>>>> in llvm and kernel.
>>>
>>> OK, then I think we can probably justify not conforming to the
>>> __sync_fetch_and_add() semantics since that API is under-specified
>>> anyway.
>>>
>>> However IMO it's unambiguously a bug for
>>>
>>>     (void)__atomic_fetch_add(&x, y, __ATOMIC_SEQ_CST);
>>>
>>> to compile down to a kernel atomic_add. I think for that specific API
>>> Clang really ought to always use BPF_FETCH | BPF_ADD when
>>> anything stronger than __ATOMIC_RELAXED is requested, or even just
>>> refuse to compile with when the return value is ignored and a
>>> none-relaxed memory ordering is specified.
>>
>> Both the following codes:
>>      (void)__sync_fetch_and_add(p, a);
>>      (void)__atomic_fetch_add(p, a, __ATOMIC_SEQ_CST);
>>
>> will generate the same IR:
>>      %0 = atomicrmw add i32* %p, i32 %a seq_cst
>>
>> Basically that means for old compiler (<= llvm11),
>>     (void)__atomic_fetch_add(&x, y, __ATOMIC_SEQ_CST)
>> already generates xadd.
> 
> Ah, I didn't realise that was already the case, that's unfortunate.
> 
> For users of newer Clang with alu32 enabled, unless I'm being naïve
> this could be fixed without breaking compatibility. Clang could just
> start generating a BPF_ADD|BPF_FETCH, and then handle the fact that
> the src_reg is clobbered, right?

This may cause regressions as old kernel won't support 
BPF_ADD|BPF_FETCH. Since we do not have llvm flags to control
this behavior, that means users with old kernel
cannot use llvm12 any more.

> 
> For users without alu32 enabled I would actually argue that the new
> Clang should start failing to build that code - as a user I'd much
> rather have my build suddenly fail than my explicitly-stated ordering
> assumptions violated. But I understand if that doesn't seem too
> palatable...
> 
