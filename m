Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB65A2D2FE9
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 17:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgLHQjK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 11:39:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19672 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726810AbgLHQjI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 8 Dec 2020 11:39:08 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B8GYKmw007382;
        Tue, 8 Dec 2020 08:38:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=e1Ty72dYifipSiNRD65udFmdcBIgQXEp6aMaDTIxX9Q=;
 b=iaiwncaN2IOl2769kWnJQzgnj0YY3uno5Uc315zXNp/Iw5httiugBIZ3uOccghJFuRao
 hMa4wKZ8KUZNJ9RcKzGMqOT0i4DpFaF+VLjaq0b4ppLu+D3ZaAVYj4pjX5/PNNol2W6F
 lI6zF8JMJDHz/RjedzHL3XkU49QnAGPYSyQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35a2t4c1e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Dec 2020 08:38:10 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 8 Dec 2020 08:38:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBbT3MAwlLPoA+soagNBbISIcespVCQm0cLcmEPwVFp79LwLKFK5YZTfD5XKIFERipYo7aygygOOVYS09q/sqLZ9ic812K/xXNc34Rouu7CPPUfRt4/AbQCSpG706RQqMTroqhluBGj7ulZz10U/hkgIHT9SKHe0kCxlow6XuTJ0NfA/hdaHH0CwwwHwUnK2qHMgls0/uTe5BUYeTOclFAXs4Wl+mpWlYJmnajXgpedk9PC9v7txaND/10Nwzr4EFRzxM3rgQVGInNgtIsP5iHAAZhe7yRa1J/cLKkmHvuOg6Czo8LVnHU0zZYpK6In2hUA8xYguk8erBA5bMriiLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWcQ7xQqCevuKaagHozyThVy89+wV/Ug3Cop7p6izAE=;
 b=cF6ymkm/DMGb6yq3JQDqiSy5SDOFTfEgVpIrxd/kx35L8jL8OzzMZv0TmPCoYk9hKuCUS0acLgUTKJpJnumFIqq26zeGHnPGkvXXKCwKtjLxiB/eNB/9pKC6O0YWX/ySVbIy7MENExKtdNoHhxJu1+1jZVaZnlQLh5q4cLI2ym5T/PfP4oUQYFEAHOAOm0b5CA5xwmI7QeHj1+M+gi7HpQvDgkxNz7105c4cVlHuoddspUyiCyvNTFnByW16zVnTQF2GYvni2QTCaW1WTfMj8EjBuVbnkmVBaFZYrGlX9cqP50ItBDE+IzaSRfkQtbyY7GIxRE02YfghKz7vrG5dDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWcQ7xQqCevuKaagHozyThVy89+wV/Ug3Cop7p6izAE=;
 b=gHcD24l46nLCZ4JZBCTW98s1INbUtrmDDDXHAvSh17gZWZQ5nWGiIL/2pN57xXCT3iGp+FSsJhPykSupezi0adsLQPkt23+q8ewVJLV1ULYmgIbCa2QpYUptIiv0wCyQNYn48y+iOjvYNl3t15g0duJrB+r+rzSDSNLYTNZiJl0=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB3572.namprd15.prod.outlook.com (2603:10b6:a03:1b2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Tue, 8 Dec
 2020 16:38:07 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 16:38:07 +0000
Subject: Re: [PATCH bpf-next v4 10/11] bpf: Add tests for new BPF atomic
 operations
To:     Brendan Jackman <jackmanb@google.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201207160734.2345502-1-jackmanb@google.com>
 <20201207160734.2345502-11-jackmanb@google.com>
 <3adb88d5-b8d8-9c15-a988-7c10f86686fd@fb.com> <X890lro0A5mFJHyD@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <24c9b2d7-f9b1-d7d4-71dc-47f4208ee6e9@fb.com>
Date:   Tue, 8 Dec 2020 08:38:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <X890lro0A5mFJHyD@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:7fe3]
X-ClientProxiedBy: CO2PR07CA0049.namprd07.prod.outlook.com (2603:10b6:100::17)
 To BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::113f] (2620:10d:c090:400::5:7fe3) by CO2PR07CA0049.namprd07.prod.outlook.com (2603:10b6:100::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 16:38:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4eaf5919-653f-4fac-89e2-08d89b97a497
X-MS-TrafficTypeDiagnostic: BY5PR15MB3572:
X-Microsoft-Antispam-PRVS: <BY5PR15MB35721BD58E3B3449AB48EB75D3CD0@BY5PR15MB3572.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rxzh4xqFMI5RAwtpxVQpIhzPPYYvYnk74vfKay1gHwbgYW/JCHgUM/xz9R5UTfes4EB+8MwMc2QqaPx1nJaEmFI2DvY9b3TjsbuY/6j2LW4JB+0YSjmMlvENuDbTzkLidQF+qhF/8XYY1ntfo3OMUqMIA1gKzKle598Bu6fMwHfG0BAAJW9j/+bVwoukUmZ7LWH9myMBjzeyTthltYhtu1b7/3fohn7gZlKgOI5vPNB5i2gggEexV5UH6CHEcih6hNvH3m+ZBM9Oz8/xeMvqogEfCp0dEOS/gyGXSNPQVmjF+ZoozsorsDkdSrAZa+tJrdMPeIlXYDPxmunwYxuQQWCnjq0HN6hUYc5zv1uTLkUqdoOnRWZ43ECncgoycIswLs+sj8etuGbKaWKF/m6i1gI6o+hj77dVK7CHFua7Z+psRSYtZKkL3y/VHZUzaEmYnWSiCNU7rOczeZZe+Q1afDVm4oeCECfswgprLil/2bGX8Hqg6xyYvVtxMIg/CSH3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(54906003)(52116002)(6486002)(5660300002)(4326008)(86362001)(36756003)(31686004)(66476007)(508600001)(8676002)(53546011)(966005)(8936002)(83380400001)(16526019)(66946007)(6916009)(2906002)(2616005)(186003)(66556008)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cm9ReHBrK0VXYU9oVEpEVzhIL1pGQUp0c3J0bkJWZEh5NE9oeWdIckNFQzF3?=
 =?utf-8?B?TzJ4QzFTdVQrc1FwTkk1clN5RkgrUEd3YnZRNWJYREdoRnd2QzFsNFpTTzIy?=
 =?utf-8?B?dW45SThSSDVFV1ZnMGg5UFZKNHlyQW53OGJsRGlsMmVvTHc0REwxMzdVSEJX?=
 =?utf-8?B?cDNMQnNqMVRuMHgvUXRxYXVvdmZzWENWZGN1QkdCVFp0Z2FOdFV3bFN3TlVP?=
 =?utf-8?B?ZHhDeUZrbnlvcTBURGxGV2dkWEx0Z0RSTHhGTkJYUUZIeFVEZmp5em5JRFVu?=
 =?utf-8?B?UEFjemVoa25UK0lMcThKdWVheDlNSmZJMCtUV3VzWVE5WXRWMXJSL1F4NmxV?=
 =?utf-8?B?bkFoejZ6NFBoeTk4dXpGMzJ2TUxvNmJXYUNhWm1CcHZOYVVrWENRSzhNcEYy?=
 =?utf-8?B?UXo1K2hFcXdTUGQxWlduLzExY25oNS9nbnRGWnJlUWJsZkZnS2hnWTVLZkdG?=
 =?utf-8?B?NDRlWk1majdpS1dNYTduVi9xMXZBVUUycnVESkZnQ1Uxa3c2L1VQQ0pqTnFR?=
 =?utf-8?B?NWF2K3QzZ2pYWkNyV3RFY3VVMnh6WmFrV0pudXpSYnVRZ014ekkzMXd2QklF?=
 =?utf-8?B?ZGY2cGZDMVIvd3BrOGxxTHhMb1dMc1JCNDZySm56ZGhSTmNFa20xZVNQNDk1?=
 =?utf-8?B?VDdvNjFVazRCSTB3bGZoZzFZc2ljb3RDTkNzcklLNjZnOVhqc1lmdS9LcXht?=
 =?utf-8?B?c2lxa0prUjFLSHFaNDllQ0FSYVZGSmNJajNvRlJoT1BrcG1jYVBjYmgwMk92?=
 =?utf-8?B?MDArSjVwY21CSkwybkVKSTNUMXM1eXdqeFE0V0lPbFdvam1UZWJBcVFZeVl4?=
 =?utf-8?B?eEw1d0Zsb3FVb3Z3RGU2L3ZxMURwR2hFdVBNMEJhK0NRdDk0WXpwR3ZOTERt?=
 =?utf-8?B?aTlJNjh1YXZscjhaT3NXWjRjUFVOaGdKSmZKTWUyWGZkQmdjMEwxbGZ0SnhF?=
 =?utf-8?B?dTdFemszL2FQZTU1NEhZU1hDaFAxc0pLUitPeWs5VWUrK1lwd0F4QU9QMVBa?=
 =?utf-8?B?eEhzTUdlN210S28xYTJjQTZVSjNVc3pueWs0RDBLNVZnMVlIOS8xUzlKMDc0?=
 =?utf-8?B?SzlMTm5FQ2N0dS92M05sWUtQTUJ3MnhleEZ1YzJGQ3hnQys1cGZ4bXNyaUxY?=
 =?utf-8?B?VUFDUWlmMGNPSGQvWTFISEdkeDd3L2tSMnllQWlzbmNNSkRoaHp2V0R3S0Y2?=
 =?utf-8?B?THVrdnltaVNsR001eEMyb1Mvc1VFRTBxdU83OThXaGx4djR5MDJmY212SUdl?=
 =?utf-8?B?ZE10NlNmTW1NVnBud05EcDl6VzN1b0N4eGUzbWwzZkhZYThGamNsMWVRNFVz?=
 =?utf-8?B?aUpPZHpYNE9veDMzVEpEeUpnTjBpVm55UkQ0c3RzZzdrR0g5TFQ3RSt4Wnpu?=
 =?utf-8?B?SExnamlpTng3cVE9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 16:38:07.4887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eaf5919-653f-4fac-89e2-08d89b97a497
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 493wWyN/phpklJmK1OC2OZNvVnDlvEkPR6/h5i9IQDcEx5DTeQDGZr5qxWlY6V2F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3572
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_11:2020-12-08,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012080101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/8/20 4:41 AM, Brendan Jackman wrote:
> On Mon, Dec 07, 2020 at 07:18:57PM -0800, Yonghong Song wrote:
>>
>>
>> On 12/7/20 8:07 AM, Brendan Jackman wrote:
>>> The prog_test that's added depends on Clang/LLVM features added by
>>> Yonghong in commit 286daafd6512 (was https://reviews.llvm.org/D72184  ).
>>>
>>> Note the use of a define called ENABLE_ATOMICS_TESTS: this is used
>>> to:
>>>
>>>    - Avoid breaking the build for people on old versions of Clang
>>>    - Avoid needing separate lists of test objects for no_alu32, where
>>>      atomics are not supported even if Clang has the feature.
>>>
>>> The atomics_test.o BPF object is built unconditionally both for
>>> test_progs and test_progs-no_alu32. For test_progs, if Clang supports
>>> atomics, ENABLE_ATOMICS_TESTS is defined, so it includes the proper
>>> test code. Otherwise, progs and global vars are defined anyway, as
>>> stubs; this means that the skeleton user code still builds.
>>>
>>> The atomics_test.o userspace object is built once and used for both
>>> test_progs and test_progs-no_alu32. A variable called skip_tests is
>>> defined in the BPF object's data section, which tells the userspace
>>> object whether to skip the atomics test.
>>>
>>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>>
>> Ack with minor comments below.
>>
>> Acked-by: Yonghong Song <yhs@fb.com>
>>
>>> ---
>>>    tools/testing/selftests/bpf/Makefile          |  10 +
>>>    .../selftests/bpf/prog_tests/atomics.c        | 246 ++++++++++++++++++
>>>    tools/testing/selftests/bpf/progs/atomics.c   | 154 +++++++++++
>>>    .../selftests/bpf/verifier/atomic_and.c       |  77 ++++++
>>>    .../selftests/bpf/verifier/atomic_cmpxchg.c   |  96 +++++++
>>>    .../selftests/bpf/verifier/atomic_fetch_add.c | 106 ++++++++
>>>    .../selftests/bpf/verifier/atomic_or.c        |  77 ++++++
>>>    .../selftests/bpf/verifier/atomic_xchg.c      |  46 ++++
>>>    .../selftests/bpf/verifier/atomic_xor.c       |  77 ++++++
>>>    9 files changed, 889 insertions(+)
>>>    create mode 100644 tools/testing/selftests/bpf/prog_tests/atomics.c
>>>    create mode 100644 tools/testing/selftests/bpf/progs/atomics.c
>>>    create mode 100644 tools/testing/selftests/bpf/verifier/atomic_and.c
>>>    create mode 100644 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
>>>    create mode 100644 tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
>>>    create mode 100644 tools/testing/selftests/bpf/verifier/atomic_or.c
>>>    create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xchg.c
>>>    create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xor.c
>>>
>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>>> index ac25ba5d0d6c..13bc1d736164 100644
>>> --- a/tools/testing/selftests/bpf/Makefile
>>> +++ b/tools/testing/selftests/bpf/Makefile
>>> @@ -239,6 +239,12 @@ BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) 			\
>>>    	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
>>>    	     -I$(abspath $(OUTPUT)/../usr/include)
>>> +# BPF atomics support was added to Clang in llvm-project commit 286daafd6512
>>> +# (release 12.0.0).
>>> +BPF_ATOMICS_SUPPORTED = $(shell \
>>> +	echo "int x = 0; int foo(void) { return __sync_val_compare_and_swap(&x, 1, 2); }" \
>>> +	| $(CLANG) -x cpp-output -S -target bpf -mcpu=v3 - -o /dev/null && echo 1 || echo 0)
>>
>> '-x c' here more intuitive?
>>
>>> +
>>>    CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
>>>    	       -Wno-compare-distinct-pointer-types
>>> @@ -399,11 +405,15 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
>>>    		       $(wildcard progs/btf_dump_test_case_*.c)
>>>    TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
>>>    TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
>>> +ifeq ($(BPF_ATOMICS_SUPPORTED),1)
>>> +  TRUNNER_BPF_CFLAGS += -DENABLE_ATOMICS_TESTS
>>> +endif
>>>    TRUNNER_BPF_LDFLAGS := -mattr=+alu32
>>>    $(eval $(call DEFINE_TEST_RUNNER,test_progs))
>>>    # Define test_progs-no_alu32 test runner.
>>>    TRUNNER_BPF_BUILD_RULE := CLANG_NOALU32_BPF_BUILD_RULE
>>> +TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
>>>    TRUNNER_BPF_LDFLAGS :=
>>>    $(eval $(call DEFINE_TEST_RUNNER,test_progs,no_alu32))
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/atomics.c b/tools/testing/selftests/bpf/prog_tests/atomics.c
>>> new file mode 100644
>>> index 000000000000..c841a3abc2f7
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/prog_tests/atomics.c
>>> @@ -0,0 +1,246 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +#include <test_progs.h>
>>> +
>>> +#include "atomics.skel.h"
>>> +
>>> +static void test_add(struct atomics *skel)
>>> +{
>>> +	int err, prog_fd;
>>> +	__u32 duration = 0, retval;
>>> +	struct bpf_link *link;
>>> +
>>> +	link = bpf_program__attach(skel->progs.add);
>>> +	if (CHECK(IS_ERR(link), "attach(add)", "err: %ld\n", PTR_ERR(link)))
>>> +		return;
>>> +
>>> +	prog_fd = bpf_program__fd(skel->progs.add);
>>> +	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
>>> +				NULL, NULL, &retval, &duration);
>>> +	if (CHECK(err || retval, "test_run add",
>>> +		  "err %d errno %d retval %d duration %d\n", err, errno, retval, duration))
>>> +		goto cleanup;
>>> +
>>> +	ASSERT_EQ(skel->data->add64_value, 3, "add64_value");
>>> +	ASSERT_EQ(skel->bss->add64_result, 1, "add64_result");
>>> +
>>> +	ASSERT_EQ(skel->data->add32_value, 3, "add32_value");
>>> +	ASSERT_EQ(skel->bss->add32_result, 1, "add32_result");
>>> +
>>> +	ASSERT_EQ(skel->bss->add_stack_value_copy, 3, "add_stack_value");
>>> +	ASSERT_EQ(skel->bss->add_stack_result, 1, "add_stack_result");
>>> +
>>> +	ASSERT_EQ(skel->data->add_noreturn_value, 3, "add_noreturn_value");
>>> +
>>> +cleanup:
>>> +	bpf_link__destroy(link);
>>> +}
>>> +
>> [...]
>>> +
>>> +__u64 xchg64_value = 1;
>>> +__u64 xchg64_result = 0;
>>> +__u32 xchg32_value = 1;
>>> +__u32 xchg32_result = 0;
>>> +
>>> +SEC("fentry/bpf_fentry_test1")
>>> +int BPF_PROG(xchg, int a)
>>> +{
>>> +#ifdef ENABLE_ATOMICS_TESTS
>>> +	__u64 val64 = 2;
>>> +	__u32 val32 = 2;
>>> +
>>> +	__atomic_exchange(&xchg64_value, &val64, &xchg64_result, __ATOMIC_RELAXED);
>>> +	__atomic_exchange(&xchg32_value, &val32, &xchg32_result, __ATOMIC_RELAXED);
>>
>> Interesting to see this also works. I guess we probably won't advertise
>> this, right? Currently for LLVM, the memory ordering parameter is ignored.
> 
> Well IIUC this specific case is fine: the ordering that you get with
> BPF_[CMP]XCHG (via kernel atomic_[cmpxchg]) is sequential consistency,
> and its' fine to provide a stronger ordering than the one requested. I
> should change it to say __ATOMIC_SEQ_CST to avoid confusing readers,
> though.
> 
> (I wrote it this way because I didn't see a __sync* function for
> unconditional atomic exchange, and I didn't see an __atomic* function
> where you don't need to specify the ordering).

For the above code,
    __atomic_exchange(&xchg64_value, &val64, &xchg64_result, 
__ATOMIC_RELAXED);
It tries to do an atomic exchange between &xchg64_value and
  &val64, and store the old &xchg64_value to &xchg64_result. So it is
equivalent to
     xchg64_result = __sync_lock_test_and_set(&xchg64_value, val64);

So I think this test case can be dropped.

> 
> However... this led me to double-check the semantics and realise that we
> do have a problem with ordering: The kernel's atomic_{add,and,or,xor} do
> not imply memory barriers and therefore neither do the corresponding BPF
> instructions. That means Clang can compile this:
> 
>   (void)__atomic_fetch_add(&val, 1, __ATOMIC_SEQ_CST)
> 
> to a {.code = (BPF_STX | BPF_DW | BPF_ATOMIC), .imm = BPF_ADD},
> which is implemented with atomic_add, which doesn't actually satisfy
> __ATOMIC_SEQ_CST.

This is the main reason in all my llvm selftests I did not use
__atomic_* intrinsics because we cannot handle *different* memory
ordering properly.

> 
> In fact... I think this is a pre-existing issue with BPF_XADD.
> 
> If all I've written here is correct, the fix is to use
> (void)atomic_fetch_add etc (these imply barriers) even when BPF_FETCH is
> not set. And that change ought to be backported to fix BPF_XADD.

We cannot change BPF_XADD behavior. If we change BPF_XADD to use
atomic_fetch_add, then suddenly old code compiled with llvm12 will
suddenly requires latest kernel, which will break userland very badly.
