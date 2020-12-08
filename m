Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DD22D31F3
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 19:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbgLHSQk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 13:16:40 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12846 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730231AbgLHSQk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 8 Dec 2020 13:16:40 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B8IB4tU030576;
        Tue, 8 Dec 2020 10:15:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=gXYfkFJwopuc0y7MnQH+qAPWvlmarXCIyyy8stOtMsk=;
 b=dKBDHNj49djL/C0wcm/0WHwFbwf2wEZrL0pfRHKc0spDuVje9+M3tLpp9+VtBPX1kBtc
 Rr93sSSAsn5Ii/+dGzhgs+58f0CmSzMo9JK9yHewb2Pgp7ejbslwfYtSRxRsSMnNDNJP
 4UYTHxVH+qMx7mXFsucwY99/fSQcerxij7A= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35a0k5nn1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Dec 2020 10:15:41 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 8 Dec 2020 10:15:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7hXyXzOR8Bj25/TlOrS4IOgSYomyuJzCUNVrCUeyBEu/zDnY7Jf8to78Zz7VMjhhiLM7pmc7L8IybpelhKvNmDg5NJ6aUzKKXYvHE00Xs8Pd7sGk086DRCGsom8BE4GS2Gt+nvQ2Dy/JlhFAHHHBUrjoBAzKHBs0OCEMPQiqfvffJUHDVlizS7380d5egpN60iXwrDAi0Z++D8LjYCwDQelPLtHn5KZqF7tSdEdwRv11LRsiUwReyX6MHVKPyRCG3AKgSSMZ00u7YJulfkR0MCp5zD5bqcLn1u5fwEdzjS8KbCi4dzR5FxpT3AEgGlM0SzdY66OzJAqFlMtE7LfAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EARC+ocs6JAheCz852MplPIKxwRnhjBrE7DvMj3RtpI=;
 b=MQ/JwL+e3cIYYuavYyfOp8OCWCsPgRhIMpe58WoPXOeBtmVkOGvRrw+mNRiJKvyUBXC8bTkcgpj46PewmvUUApiOcic0OpRk0QWKBCNGoebNkKne3cDZ4IN3QzC0JBH40krzOVxSblK77ua8SEss8PNpjSrvy9ONluMF6Cszv+oCs+cMAW6YYO01TKnCYJnQ3C9Gaz8TqlLzDOJRgqn4od3QgbmGs3z4qTKE04osri0nX3liuGbd6y5snsGaolr21mBWzSGfO44D8jbUu1tyEcYOs86UJal8mhuLavuVu9ljVYWdJpkIu5NkbxcNLDm08YxrnO19l0zjImP6E/qulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EARC+ocs6JAheCz852MplPIKxwRnhjBrE7DvMj3RtpI=;
 b=WA1Eh5NE6QvoHbamRd4Ocs6wqaj2rcLL1Q1GCr7jppqO5RbVZ/AviG1PUS8mXfmbF+cgvIqbHBxQ6ZYbY7r/LZ2Gdnv0vpnWmGI7mjLoqe9rt7D+s734oHxFYGn/F6G5LhupkfkRksIpu6O3PaK3/h03WSCZQO4u5zeWu2G+b1Q=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3205.namprd15.prod.outlook.com (2603:10b6:a03:104::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Tue, 8 Dec
 2020 18:15:39 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 18:15:39 +0000
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
 <24c9b2d7-f9b1-d7d4-71dc-47f4208ee6e9@fb.com> <X8+w8g56z11AKNci@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <67ee3925-9388-c9d4-8ad8-9c28cff35d55@fb.com>
Date:   Tue, 8 Dec 2020 10:15:35 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <X8+w8g56z11AKNci@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:7fe3]
X-ClientProxiedBy: MWHPR1401CA0004.namprd14.prod.outlook.com
 (2603:10b6:301:4b::14) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::113f] (2620:10d:c090:400::5:7fe3) by MWHPR1401CA0004.namprd14.prod.outlook.com (2603:10b6:301:4b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 18:15:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b0b5d7e-097b-4526-871e-08d89ba5449b
X-MS-TrafficTypeDiagnostic: BYAPR15MB3205:
X-Microsoft-Antispam-PRVS: <BYAPR15MB320520994934BBEE1DC21C1ED3CD0@BYAPR15MB3205.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8QpK42+/NpG3o5Xw7bH6u96xY0jFPGZbCK21JK0TLTUnUOWz1/+7fJODFGRvDOevXuJOatFhJrARdnIe5Z0ALaoM3R6eZGd/HHPulu2HrBd67sKgbg+GMwMW9pRt9FlnCI+xNbF0oMZz76j83hK/Nj+lDd85T/6WSg6WRzu3UUbZd+2itV8BGatVZTDsG0FweXvrpvDDygt0VZgjP+JAACQ4duDB7f+cFGip51DAZR8xoCh0ZObvTCHsjoRlqVR9B5dTHkfXSzwzlnJQkdfbp7wUwSmvdqqkY8ApU7U89McsiYP78GrJ620Gtxml/r4W4AxlAbV81Y5Gb/y2Xv5ZBrpem40EVF8qwAQY28KYVSMzrfNxy+njTGgxPvIxYJYjZSZNEjlBtg5aUE/gdyOFxWOSWsWziXFxTWQLaJ46I3rgDVjUeQ3uaI+0nTRriYJsYjzcPTCyJmB94GvfPx4o6FtxswFvYS8JInSxUK6Wo5y0JndCXxJmFUQILAuj6de
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(376002)(4326008)(66556008)(31696002)(6666004)(31686004)(6486002)(8676002)(8936002)(508600001)(53546011)(83380400001)(16526019)(30864003)(66946007)(36756003)(5660300002)(966005)(54906003)(66476007)(186003)(2906002)(6916009)(2616005)(86362001)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TUdIRWFNa3ZqTEdqTDhwalpHYlFxeHdtWnIxeFBXSlhVVzRXS2dKZGV0N2NY?=
 =?utf-8?B?Unltekg3VkJOREEwbjk3RTgxUGxFREZRU3d3QTF6ay83a21HMENvR09BWDVn?=
 =?utf-8?B?MnQvcCttOVJJMS9aVWdtTm0yZWo3cjJMNjh5Zk1iNkxLbVdZdDBrdU9NMEt4?=
 =?utf-8?B?NStnQUhrUVREZFFIR1hwWWUra3MzYjFsUkh4UDVQL2hCRFZudzh1R1h1ejlL?=
 =?utf-8?B?UFRFcy95dStJSEgzZjkvcmVGa25LeXZYblFvTlZzanJLKzI2cFdqNGhjVlgv?=
 =?utf-8?B?YitaU3NWSnVxS0thUzlhbk1sNlp3dFNFV1RZK1pUTERSQnc2Ty9kM0dYbW1F?=
 =?utf-8?B?dkhtSGdJcUczTHNNbnNncEIxQmtMRWFPL1lLM2E0UytEUkNZdmxVR0UwdFJI?=
 =?utf-8?B?QW80UmJTMjV5bHczUUtHcXJjYzhZM1U0REpFM01NeUU4WEoySnFNNDNkL0dE?=
 =?utf-8?B?blo4RmxnTmxSdDRVQnVNbmhTbHV6U25qcUFqeWNxaTJWWitoRGRXa0o1NzZ6?=
 =?utf-8?B?Y1k3K1Z2eW5SM2syTkc3VmlrOTVTQmhkVWFPVHRpc0F3VkZlNVczUy9DVm1I?=
 =?utf-8?B?TUdRTERtMlJ3aHRReW1sRGRPR2ljRXNGdXp3TDNOZFZVMEoxS1o1OHZseFFE?=
 =?utf-8?B?RytURlNtNVZxZkw5Y2ZPS1FqK09aTUhNdXF2S2xrNktiN0M3UEFPaENkd1ow?=
 =?utf-8?B?MFd3ZnkzNjAvaWJrRm9sTHpsN1BGSlo1V2ZleFAyRXBwMXNYOURsMnJWRmk3?=
 =?utf-8?B?bWxHUzF2anBaSDdzOTdmeFgwcXVkWnNkcHNQUlh6MFpnUStsYTVFa0ZONHFF?=
 =?utf-8?B?NDhMNTJCN04vWW4zTS9ldlAxemVSczV3RVl1N1hFVEsxbzZvOGZsZVAvSTdz?=
 =?utf-8?B?Q2FuTnFwUWExeUZzU3ozbmxuY1NLditTTnFZNCthVlIxUnZvMm13d2crQlZG?=
 =?utf-8?B?NUk1cnNjV04vNGduRzVFZmxaaE1rYVNjZ2FXMmJhYlJXS2krbkd1VXhwOXZD?=
 =?utf-8?B?SWVzWnpzdnpmR3RXTkZFYWhzRzBqS2M5ZE1JdkJQTlJ0QWZVVUZNU3EzRG9u?=
 =?utf-8?B?Q1R6SUtJQUFNZGVYdXpzelcxU0ZuVHl0Q1hPUGVsZy96ZnBJamIyUXVYZS9I?=
 =?utf-8?B?TjVJYU4yZFVrSkJyMkhlZHFsaGtIZFBPdjBrTWE0dXl6YnhGTlpZZlNlVlBY?=
 =?utf-8?B?U3prakl3M3kwWGVVYlZrSVgyRkFNNlpIaTd1UUhQMWNkUG91bHdmdzFnTlN5?=
 =?utf-8?B?THlTMGlNa0o0VUs1RE9rMDVNTzY3aDhSeXdKQWFXRWphdVkySFptV2Jlb28w?=
 =?utf-8?B?QnVCMExnSGhuNmNGMFBUOE1HQVF0dFBLQ2RpaDBEY0wzT284dExBVzBDSzN4?=
 =?utf-8?B?NnlMb3d2R2lsYmc9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 18:15:39.5018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0b5d7e-097b-4526-871e-08d89ba5449b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hLDpd1pyyz4H1Df/lmHJPEIlAdI1S3lnblrAYAp12nCf2K5+RWHxlkR9VKBEI8E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3205
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_14:2020-12-08,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/8/20 8:59 AM, Brendan Jackman wrote:
> On Tue, Dec 08, 2020 at 08:38:04AM -0800, Yonghong Song wrote:
>>
>>
>> On 12/8/20 4:41 AM, Brendan Jackman wrote:
>>> On Mon, Dec 07, 2020 at 07:18:57PM -0800, Yonghong Song wrote:
>>>>
>>>>
>>>> On 12/7/20 8:07 AM, Brendan Jackman wrote:
>>>>> The prog_test that's added depends on Clang/LLVM features added by
>>>>> Yonghong in commit 286daafd6512 (was https://reviews.llvm.org/D72184   ).
>>>>>
>>>>> Note the use of a define called ENABLE_ATOMICS_TESTS: this is used
>>>>> to:
>>>>>
>>>>>     - Avoid breaking the build for people on old versions of Clang
>>>>>     - Avoid needing separate lists of test objects for no_alu32, where
>>>>>       atomics are not supported even if Clang has the feature.
>>>>>
>>>>> The atomics_test.o BPF object is built unconditionally both for
>>>>> test_progs and test_progs-no_alu32. For test_progs, if Clang supports
>>>>> atomics, ENABLE_ATOMICS_TESTS is defined, so it includes the proper
>>>>> test code. Otherwise, progs and global vars are defined anyway, as
>>>>> stubs; this means that the skeleton user code still builds.
>>>>>
>>>>> The atomics_test.o userspace object is built once and used for both
>>>>> test_progs and test_progs-no_alu32. A variable called skip_tests is
>>>>> defined in the BPF object's data section, which tells the userspace
>>>>> object whether to skip the atomics test.
>>>>>
>>>>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>>>>
>>>> Ack with minor comments below.
>>>>
>>>> Acked-by: Yonghong Song <yhs@fb.com>
>>>>
>>>>> ---
>>>>>     tools/testing/selftests/bpf/Makefile          |  10 +
>>>>>     .../selftests/bpf/prog_tests/atomics.c        | 246 ++++++++++++++++++
>>>>>     tools/testing/selftests/bpf/progs/atomics.c   | 154 +++++++++++
>>>>>     .../selftests/bpf/verifier/atomic_and.c       |  77 ++++++
>>>>>     .../selftests/bpf/verifier/atomic_cmpxchg.c   |  96 +++++++
>>>>>     .../selftests/bpf/verifier/atomic_fetch_add.c | 106 ++++++++
>>>>>     .../selftests/bpf/verifier/atomic_or.c        |  77 ++++++
>>>>>     .../selftests/bpf/verifier/atomic_xchg.c      |  46 ++++
>>>>>     .../selftests/bpf/verifier/atomic_xor.c       |  77 ++++++
>>>>>     9 files changed, 889 insertions(+)
>>>>>     create mode 100644 tools/testing/selftests/bpf/prog_tests/atomics.c
>>>>>     create mode 100644 tools/testing/selftests/bpf/progs/atomics.c
>>>>>     create mode 100644 tools/testing/selftests/bpf/verifier/atomic_and.c
>>>>>     create mode 100644 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
>>>>>     create mode 100644 tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
>>>>>     create mode 100644 tools/testing/selftests/bpf/verifier/atomic_or.c
>>>>>     create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xchg.c
>>>>>     create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xor.c
>>>>>
>>>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>>>>> index ac25ba5d0d6c..13bc1d736164 100644
>>>>> --- a/tools/testing/selftests/bpf/Makefile
>>>>> +++ b/tools/testing/selftests/bpf/Makefile
>>>>> @@ -239,6 +239,12 @@ BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) 			\
>>>>>     	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
>>>>>     	     -I$(abspath $(OUTPUT)/../usr/include)
>>>>> +# BPF atomics support was added to Clang in llvm-project commit 286daafd6512
>>>>> +# (release 12.0.0).
>>>>> +BPF_ATOMICS_SUPPORTED = $(shell \
>>>>> +	echo "int x = 0; int foo(void) { return __sync_val_compare_and_swap(&x, 1, 2); }" \
>>>>> +	| $(CLANG) -x cpp-output -S -target bpf -mcpu=v3 - -o /dev/null && echo 1 || echo 0)
>>>>
>>>> '-x c' here more intuitive?
>>>>
>>>>> +
>>>>>     CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
>>>>>     	       -Wno-compare-distinct-pointer-types
>>>>> @@ -399,11 +405,15 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
>>>>>     		       $(wildcard progs/btf_dump_test_case_*.c)
>>>>>     TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
>>>>>     TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
>>>>> +ifeq ($(BPF_ATOMICS_SUPPORTED),1)
>>>>> +  TRUNNER_BPF_CFLAGS += -DENABLE_ATOMICS_TESTS
>>>>> +endif
>>>>>     TRUNNER_BPF_LDFLAGS := -mattr=+alu32
>>>>>     $(eval $(call DEFINE_TEST_RUNNER,test_progs))
>>>>>     # Define test_progs-no_alu32 test runner.
>>>>>     TRUNNER_BPF_BUILD_RULE := CLANG_NOALU32_BPF_BUILD_RULE
>>>>> +TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
>>>>>     TRUNNER_BPF_LDFLAGS :=
>>>>>     $(eval $(call DEFINE_TEST_RUNNER,test_progs,no_alu32))
>>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/atomics.c b/tools/testing/selftests/bpf/prog_tests/atomics.c
>>>>> new file mode 100644
>>>>> index 000000000000..c841a3abc2f7
>>>>> --- /dev/null
>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/atomics.c
>>>>> @@ -0,0 +1,246 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +
>>>>> +#include <test_progs.h>
>>>>> +
>>>>> +#include "atomics.skel.h"
>>>>> +
>>>>> +static void test_add(struct atomics *skel)
>>>>> +{
>>>>> +	int err, prog_fd;
>>>>> +	__u32 duration = 0, retval;
>>>>> +	struct bpf_link *link;
>>>>> +
>>>>> +	link = bpf_program__attach(skel->progs.add);
>>>>> +	if (CHECK(IS_ERR(link), "attach(add)", "err: %ld\n", PTR_ERR(link)))
>>>>> +		return;
>>>>> +
>>>>> +	prog_fd = bpf_program__fd(skel->progs.add);
>>>>> +	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
>>>>> +				NULL, NULL, &retval, &duration);
>>>>> +	if (CHECK(err || retval, "test_run add",
>>>>> +		  "err %d errno %d retval %d duration %d\n", err, errno, retval, duration))
>>>>> +		goto cleanup;
>>>>> +
>>>>> +	ASSERT_EQ(skel->data->add64_value, 3, "add64_value");
>>>>> +	ASSERT_EQ(skel->bss->add64_result, 1, "add64_result");
>>>>> +
>>>>> +	ASSERT_EQ(skel->data->add32_value, 3, "add32_value");
>>>>> +	ASSERT_EQ(skel->bss->add32_result, 1, "add32_result");
>>>>> +
>>>>> +	ASSERT_EQ(skel->bss->add_stack_value_copy, 3, "add_stack_value");
>>>>> +	ASSERT_EQ(skel->bss->add_stack_result, 1, "add_stack_result");
>>>>> +
>>>>> +	ASSERT_EQ(skel->data->add_noreturn_value, 3, "add_noreturn_value");
>>>>> +
>>>>> +cleanup:
>>>>> +	bpf_link__destroy(link);
>>>>> +}
>>>>> +
>>>> [...]
>>>>> +
>>>>> +__u64 xchg64_value = 1;
>>>>> +__u64 xchg64_result = 0;
>>>>> +__u32 xchg32_value = 1;
>>>>> +__u32 xchg32_result = 0;
>>>>> +
>>>>> +SEC("fentry/bpf_fentry_test1")
>>>>> +int BPF_PROG(xchg, int a)
>>>>> +{
>>>>> +#ifdef ENABLE_ATOMICS_TESTS
>>>>> +	__u64 val64 = 2;
>>>>> +	__u32 val32 = 2;
>>>>> +
>>>>> +	__atomic_exchange(&xchg64_value, &val64, &xchg64_result, __ATOMIC_RELAXED);
>>>>> +	__atomic_exchange(&xchg32_value, &val32, &xchg32_result, __ATOMIC_RELAXED);
>>>>
>>>> Interesting to see this also works. I guess we probably won't advertise
>>>> this, right? Currently for LLVM, the memory ordering parameter is ignored.
>>>
>>> Well IIUC this specific case is fine: the ordering that you get with
>>> BPF_[CMP]XCHG (via kernel atomic_[cmpxchg]) is sequential consistency,
>>> and its' fine to provide a stronger ordering than the one requested. I
>>> should change it to say __ATOMIC_SEQ_CST to avoid confusing readers,
>>> though.
>>>
>>> (I wrote it this way because I didn't see a __sync* function for
>>> unconditional atomic exchange, and I didn't see an __atomic* function
>>> where you don't need to specify the ordering).
>>
>> For the above code,
>>     __atomic_exchange(&xchg64_value, &val64, &xchg64_result,
>> __ATOMIC_RELAXED);
>> It tries to do an atomic exchange between &xchg64_value and
>>   &val64, and store the old &xchg64_value to &xchg64_result. So it is
>> equivalent to
>>      xchg64_result = __sync_lock_test_and_set(&xchg64_value, val64);
>>
>> So I think this test case can be dropped.
> 
> Ah nice, I didn't know about __sync_lock_test_and_set, let's switch to
> that I think.
> 
>>> However... this led me to double-check the semantics and realise that we
>>> do have a problem with ordering: The kernel's atomic_{add,and,or,xor} do
>>> not imply memory barriers and therefore neither do the corresponding BPF
>>> instructions. That means Clang can compile this:
>>>
>>>    (void)__atomic_fetch_add(&val, 1, __ATOMIC_SEQ_CST)
>>>
>>> to a {.code = (BPF_STX | BPF_DW | BPF_ATOMIC), .imm = BPF_ADD},
>>> which is implemented with atomic_add, which doesn't actually satisfy
>>> __ATOMIC_SEQ_CST.
>>
>> This is the main reason in all my llvm selftests I did not use
>> __atomic_* intrinsics because we cannot handle *different* memory
>> ordering properly.
>>
>>>
>>> In fact... I think this is a pre-existing issue with BPF_XADD.
>>>
>>> If all I've written here is correct, the fix is to use
>>> (void)atomic_fetch_add etc (these imply barriers) even when BPF_FETCH is
>>> not set. And that change ought to be backported to fix BPF_XADD.
>>
>> We cannot change BPF_XADD behavior. If we change BPF_XADD to use
>> atomic_fetch_add, then suddenly old code compiled with llvm12 will
>> suddenly requires latest kernel, which will break userland very badly.
> 
> Sorry I should have been more explicit: I meant that the fix would be to
> call atomic_fetch_add but discard the return value, purely for the
> implied barrier. The x86 JIT would stay the same. It would not break any
> existing code, only add ordering guarantees that the user probably
> already expected (since these builtins come from GCC originally and the
> GCC docs say "these builtins are considered a full barrier" [1])
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc-4.1.1/gcc/Atomic-Builtins.html

This is indeed the issue. In the past, people already use gcc
__sync_fetch_and_add() for xadd instruction for which git generated
code does not implying barrier.

The new atomics support has the following logic:
   . if return value is used, it is atomic_fetch_add
   . if return value is not used, it is xadd
The reason to do this is to preserve backward compabiility
and this way, we can get rid of -mcpu=v4.

barrier issue is tricky and as we discussed earlier let us
delay this after basic atomics support landed. We may not
100% conform to gcc __sync_fetch_and_add() or __atomic_*()
semantics. We do need to clearly document what is expected
in llvm and kernel.
