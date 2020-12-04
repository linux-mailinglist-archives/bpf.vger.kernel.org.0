Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55192CE868
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 08:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgLDHHg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 02:07:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5086 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725550AbgLDHHf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Dec 2020 02:07:35 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0B4764sb030673;
        Thu, 3 Dec 2020 23:06:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=nAc6/uboaRe2wmVJ710R/lJSzG2j2JKbJ1BFM9+cLe0=;
 b=gl5lMFEmxwuZhpqq9niG/EtHFOQ/2YWKn6bRu1wdhrOdDKVEq0XK1C0W7oN4nDPW3PUu
 rWdjjuGbAyomYDdstOOIqw2XzC5U/uwa/TAJgasDH3ZmBwi6mPVqk1nD/crBekhDwh1L
 u0ALDKYq39KmQRDZegw7q9FLWLrS0qHexAY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 357682bvmc-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Dec 2020 23:06:35 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 23:06:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEP+Q72Bz70AFpXqEVmvSTerEG3Yj4wTlAcHqAn/2tU+Wov0DjqY++EvvBLRa2JyQS9nEtX55jU851yWqIOOeazKBwGxEEo/IkunM0ihvdtjRaio4U2CD3upN2Gy/pGE9UxqY8Q0VjElxhz32KH6Adgpd41e9zIvn4cH54IWX8aWlm8U2wo0BEjPFJCp7CHqq9ZdfdfLSHIA4I/LmJn2Q+Q3IKcKZbzwxNEriyHTrVI4e6nIbLgGVQrYgmhTai4ezZ+dyrbN/f23tvk77kzua8TgPyhvOqvu9gKn12YXsPSXrsmlzuYlWn9nImHVBIpbQYkBjvuRXKCmdtEyTAgwFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZECKzDiaPzrrjrKCmIl6J+XB238Z+ji0gb+wz/k/gw=;
 b=GdZJtDNV0XR4+C21e1qyFUztx53j2cfl7QEmhePLK2ZHY2cPXP8934LWwVeuJaDQEAfDjlsr1qDVJi/9BTH+q5U9Dfxaybjv2hou1GrpUrFm3qy9aMNeAFF2qv900sWASyMcTU3KI3fptbj6B08hMIpY09AW8jciuVatcBp/uQ0NEV43hp12KIBGAi1lU17zFQ1gtjAyPgruhrqKUzDnx3V/QV90S8DyB3tkhUb8fUUIkvFPUw5s0U+R0yC3e4qSITqzqfaIfO4Tb421it7MerjHPdL/NU8B+NjQCoXy1cHObQUiE4NmkbOvPrhbrRp0OoOrONLfNxcVnlbO8FLEhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZECKzDiaPzrrjrKCmIl6J+XB238Z+ji0gb+wz/k/gw=;
 b=VGpBgK6UvjguATe9vOB+s/3PlSBRVlt+o6+Y8aYysYF2edJ3/64JSoAYOsBTOPVZwBVU8UATyJGv2N8rpFVTqyywfyjC30m434cD1PM7Dpl50H22iwByIsXvuOoF9gZHFF7nR0ObSIIAJj41GmgaL0CV/qbYpAlYtBcBRtfShNs=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Fri, 4 Dec
 2020 07:06:33 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 07:06:33 +0000
Subject: Re: [PATCH bpf-next v3 13/14] bpf: Add tests for new BPF atomic
 operations
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-14-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <b629793c-fb9c-6ef5-e2d6-7acaf1d2fc7f@fb.com>
Date:   Thu, 3 Dec 2020 23:06:31 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201203160245.1014867-14-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:1dae]
X-ClientProxiedBy: MWHPR15CA0059.namprd15.prod.outlook.com
 (2603:10b6:301:4c::21) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::12b3] (2620:10d:c090:400::5:1dae) by MWHPR15CA0059.namprd15.prod.outlook.com (2603:10b6:301:4c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 07:06:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0420924d-a76b-46dd-5677-08d8982321f5
X-MS-TrafficTypeDiagnostic: BY5PR15MB3571:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3571CE550F2281A219243CA8D3F10@BY5PR15MB3571.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bD2BWShO3jUV6ZiIRRgS5vFrZ++eOYlhjJvD8ZMES1taiiN1idPqWjh749YnWGitmlHa4tT8AhNJzSohs68iMhguw4GLNkDnQMAJtwSw+BRj5503P8m+TV94iUnBtrYRy/d+d28YeYdo6xffm5SeLwZjyOrT05WlgI6Bv1dQKFi4M0+Yd+gGtC0GVPOQbobD7rDIHnKYBvWfB27WkrMUSuSbkHfdwuHzbuOoSB3OKc8MHeg6Q+GvH9xyZA/eHkqPtA0iIVl+tz7up3CHnlbWPLutAideGS/ljd4yTbOM6Xbph3+cvBS8o+7XJUfSRVdufv40CA5ysZ14WXEedC2hrTJqgxu2EHds4/WRPqiIOa14+2HaC2bfbP/XN7QKPe9WZFWYHJAWVXTXDhAWUT4vrq81SCRdmvMVqZnnCj+LNq4BYPJddnpstLqytQTeIZpNxS56tPfSFjLKFRwkBLn/63RuCB6r2he3FP3UaZzWxqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(39860400002)(376002)(136003)(53546011)(8676002)(52116002)(36756003)(83380400001)(54906003)(316002)(5660300002)(8936002)(186003)(4326008)(66946007)(66556008)(66476007)(16526019)(2906002)(478600001)(86362001)(6486002)(31686004)(2616005)(31696002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b25PZnpVejlZc1BCKyt0emxkeDVrOE94OFNobUs1LytxdlBwRFlXMjVjcFhI?=
 =?utf-8?B?dXMzL0ZBS3dwVXNmOXVScWk3Y3ptczRVbHE3WlF6SXJOY2RTdmdqWlhRK2U0?=
 =?utf-8?B?Q0Y5NGxtMWVrT2xmZGRmckdWdUNxdXpEWGV0V2RhSU95QzVyUUZyU2ZBR3lI?=
 =?utf-8?B?RlpWRHJYQ2R2WGI2QTdHTDI1dUZjOE5lNWNFRzFHV1R5NlhLSmtTdTZyYTlu?=
 =?utf-8?B?TlY5VHlDaE9mVVdFa3gxMmJnZ0ZwU2M2R0RocWY5TzFYYW9kcDhmbEh5V2py?=
 =?utf-8?B?d2R4cjFPZHd2MkFrYjY0U2E4V2kvQXJ3YWV3VGdGYldRdVdob3d2cEI4M1RD?=
 =?utf-8?B?YmJNMis3aHpmZXBCR29jYlpHRnAzbDJJMGp3dG9sZEMzYjNyNjhZSFZZSzU4?=
 =?utf-8?B?VitHUW9OSTBRbER6YXN1OERZRGxsdngxNjFnOU5OQkNBaGkrTXdTYS9hR1pK?=
 =?utf-8?B?WFpNcXl6bW83cUN2c1RUKzVlMzBUd3htWWlCUmpwU0UzcVpMbWNhckNUOHJm?=
 =?utf-8?B?SlhFVGhPdkFQR0o1VG5LSEpTMXk0REZnb080cHo0aXJaR3JWSi9la004SmUw?=
 =?utf-8?B?K1ErWGJJWUE4MjdlRitCYk9nb0owekw5WVd0VTNmc2pUdHZHMDQ5ejIzSzJw?=
 =?utf-8?B?Y1VKazZVTVFjWkI2eVBBeWVodFRYZHRqZzFhNGtaYkVVYnZWVUU0NVRBZGZD?=
 =?utf-8?B?dHVHVmpYU01EdzRHK3lHZWJaK2hJamtMekZvODhnSDZpOUR1QlB0bnRIN2FR?=
 =?utf-8?B?STlCZnFKd0VZSXdGa01NbUhMS3JuQTlLNkFVY2VaOUFGS29nQkFXc3hIK3lz?=
 =?utf-8?B?RzFEdHUxc1B2eUs4a25QWDZQeWhmN1J6R3BEc29lTWk4M0JlNlZ2Kzd2cWJM?=
 =?utf-8?B?eDVvMXJ2WmwrL3RHMmhyREVRNUR1dXBURVBFN1Z4S1dDVytHMERwMXhJaDNn?=
 =?utf-8?B?R2ZwZzhuWXkyTndheGVjdFBzeUk5aVlpOWl6Q2ZNMldHR2hTeEZSbzVoTjRS?=
 =?utf-8?B?MUVORGZzdFNxMW5MVUgvcmVRNWVaZlk2L3Jaczkrc000VUNKeXl6YzVrUkRr?=
 =?utf-8?B?a2Y5aGhWQk5hN0x0cHZDaW54S3Jwd1QxeWIwckVGalZFQzdLSGpJUXp6UEVV?=
 =?utf-8?B?Tk9Xb2dPM2QrR2dVMSt1TWg1SlFDZHUrOElvV21JbGxudEJ1RlRoeVl4eUcy?=
 =?utf-8?B?MXJRMkMvSVB2MHNlQzAxWFhJUVJUNnZYUlEvdVhFaEI4STNKdzYzY0R1K1lX?=
 =?utf-8?B?cHJUSEg5K1JNa3JzMzhXYmQ1bHcvVXlXdGMzWkgyZEw5M0h5Q3RJNjBkVEhj?=
 =?utf-8?B?RlRNbU5CdER0aHFUcUROd0lzbXczY1lyTXZGVzMvSzRkWEJaZ3hrdDRwOHNE?=
 =?utf-8?B?ZGlzWFJzSEtQNVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0420924d-a76b-46dd-5677-08d8982321f5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 07:06:33.5198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tz/DGvlFu9u8nYvbaxV17uWZkxYNrXHEaYL1ffzpHIguFaaXy4GklNA6hQSMXEG1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3571
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_02:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040039
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/3/20 8:02 AM, Brendan Jackman wrote:
> This relies on the work done by Yonghong Song in
> https://reviews.llvm.org/D72184
> 
> Note the use of a define called ENABLE_ATOMICS_TESTS: this is used
> to:
> 
>   - Avoid breaking the build for people on old versions of Clang
>   - Avoid needing separate lists of test objects for no_alu32, where
>     atomics are not supported even if Clang has the feature.
> 
> The atomics_test.o BPF object is built unconditionally both for
> test_progs and test_progs-no_alu32. For test_progs, if Clang supports
> atomics, ENABLE_ATOMICS_TESTS is defined, so it includes the proper
> test code. Otherwise, progs and global vars are defined anyway, as
> stubs; this means that the skeleton user code still builds.
> 
> The atomics_test.o userspace object is built once and used for both
> test_progs and test_progs-no_alu32. A variable called skip_tests is
> defined in the BPF object's data section, which tells the userspace
> object whether to skip the atomics test.
> 
> Change-Id: Iecc12f35f0ded4a1dd805cce1be576e7b27917ef
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>   tools/testing/selftests/bpf/Makefile          |   4 +
>   .../selftests/bpf/prog_tests/atomics_test.c   | 262 ++++++++++++++++++
>   .../selftests/bpf/progs/atomics_test.c        | 154 ++++++++++
>   .../selftests/bpf/verifier/atomic_and.c       |  77 +++++
>   .../selftests/bpf/verifier/atomic_cmpxchg.c   |  96 +++++++
>   .../selftests/bpf/verifier/atomic_fetch_add.c | 106 +++++++
>   .../selftests/bpf/verifier/atomic_or.c        |  77 +++++
>   .../selftests/bpf/verifier/atomic_xchg.c      |  46 +++
>   .../selftests/bpf/verifier/atomic_xor.c       |  77 +++++
>   9 files changed, 899 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/atomics_test.c
>   create mode 100644 tools/testing/selftests/bpf/progs/atomics_test.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_and.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_or.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xchg.c
>   create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xor.c
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index f21c4841a612..448a9eb1a56c 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -431,11 +431,15 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
>   		       $(wildcard progs/btf_dump_test_case_*.c)
>   TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
>   TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
> +ifeq ($(feature-clang-bpf-atomics),1)
> +  TRUNNER_BPF_CFLAGS += -DENABLE_ATOMICS_TESTS
> +endif
>   TRUNNER_BPF_LDFLAGS := -mattr=+alu32
>   $(eval $(call DEFINE_TEST_RUNNER,test_progs))
>   
>   # Define test_progs-no_alu32 test runner.
>   TRUNNER_BPF_BUILD_RULE := CLANG_NOALU32_BPF_BUILD_RULE
> +TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
>   TRUNNER_BPF_LDFLAGS :=
>   $(eval $(call DEFINE_TEST_RUNNER,test_progs,no_alu32))
>   
> diff --git a/tools/testing/selftests/bpf/prog_tests/atomics_test.c b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
> new file mode 100644
> index 000000000000..66f0ccf4f4ec
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
> @@ -0,0 +1,262 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +
> +
> +#include "atomics_test.skel.h"
> +
> +static struct atomics_test *setup(void)
> +{
> +	struct atomics_test *atomics_skel;
> +	__u32 duration = 0, err;
> +
> +	atomics_skel = atomics_test__open_and_load();
> +	if (CHECK(!atomics_skel, "atomics_skel_load", "atomics skeleton failed\n"))
> +		return NULL;
> +
> +	if (atomics_skel->data->skip_tests) {
> +		printf("%s:SKIP:no ENABLE_ATOMICS_TEST (missing Clang BPF atomics support)",
> +		       __func__);
> +		test__skip();
> +		goto err;
> +	}
> +
> +	err = atomics_test__attach(atomics_skel);
> +	if (CHECK(err, "atomics_attach", "atomics attach failed: %d\n", err))
> +		goto err;
> +
> +	return atomics_skel;
> +
> +err:
> +	atomics_test__destroy(atomics_skel);
> +	return NULL;
> +}
> +
> +static void test_add(void)
> +{
> +	struct atomics_test *atomics_skel;
> +	int err, prog_fd;
> +	__u32 duration = 0, retval;
> +
> +	atomics_skel = setup();

When running the test, I observed a noticeable delay between skel load 
and skel attach. The reason is the bpf program object file contains
multiple programs and the above setup() tries to do attachment
for ALL programs but actually below only "add" program is tested.
This will unnecessarily increase test_progs running time.

The best is for setup() here only load and attach program "add".
The libbpf API bpf_program__set_autoload() can set a particular
program not autoload. You can call attach function explicitly
for one specific program. This should be able to reduce test
running time.

> +	if (!atomics_skel)
> +		return;
> +
> +	prog_fd = bpf_program__fd(atomics_skel->progs.add);
> +	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
> +				NULL, NULL, &retval, &duration);
> +	if (CHECK(err || retval, "test_run add",
> +		  "err %d errno %d retval %d duration %d\n",
> +		  err, errno, retval, duration))
> +		goto cleanup;
> +
> +	ASSERT_EQ(atomics_skel->data->add64_value, 3, "add64_value");
> +	ASSERT_EQ(atomics_skel->bss->add64_result, 1, "add64_result");
> +
> +	ASSERT_EQ(atomics_skel->data->add32_value, 3, "add32_value");
> +	ASSERT_EQ(atomics_skel->bss->add32_result, 1, "add32_result");
> +
> +	ASSERT_EQ(atomics_skel->bss->add_stack_value_copy, 3, "add_stack_value");
> +	ASSERT_EQ(atomics_skel->bss->add_stack_result, 1, "add_stack_result");
> +
> +	ASSERT_EQ(atomics_skel->data->add_noreturn_value, 3, "add_noreturn_value");
> +
> +cleanup:
> +	atomics_test__destroy(atomics_skel);
> +}
> +
> +static void test_sub(void)
> +{
> +	struct atomics_test *atomics_skel;
> +	int err, prog_fd;
> +	__u32 duration = 0, retval;
> +
> +	atomics_skel = setup();
> +	if (!atomics_skel)
> +		return;
> +
[...]
