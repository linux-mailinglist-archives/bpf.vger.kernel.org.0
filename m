Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428373EF262
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 21:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhHQTCG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 15:02:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30656 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233217AbhHQTCF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Aug 2021 15:02:05 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17HIrsNU000956;
        Tue, 17 Aug 2021 12:01:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=vOMovQoSRKdNtKxG1p2xOCrfAKtw0tf4sxTu4NiCBFA=;
 b=ja8FWUApw+Zz3nItBR3U/43DDLD3lFNGZjB6YdtDMkWvUKvrqhobpOCb7/dVYnX/Ei5c
 oRb4rg5e/SSe9EXMZmXnzyFiZgRgWwqyl3yw+j0cp2x+jQBPzLPxlgY2RPf/z834u5/k
 4YdXgHx8bgUlLl9fjcvqqtk4HQNHmjt7ShM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3aftpf0hra-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 17 Aug 2021 12:01:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 12:01:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0LQczXwj+MT65Ag5O/BFgod71Nt+xA8i/muLhyEIlc3sf4FODw6hSz0iGKc72ObV5iPykbQj0foeZXSeS+8htaokr2ZWFR6bURJqAUazJWREefH0dmXhJCic4oNxp6GugC52uETFDkoimz5QLRhzsvO2Te07EmQsiPPvm0pyw/g59mtH1WgCjZd9dW6khNaP1R1oXUry32thUYZfpL1Y4qHDkPPw2PvVB3XRRPFGsHb9dblt7aXsBH2JyelESEiNagLCT/1vMMw6du2YG+mgRHUtd1wH/D/ANPXhydOKXeJch9oUVtxmZx65pErYMsSTRSyIjfzYhTG9Z6T6zOeZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOMovQoSRKdNtKxG1p2xOCrfAKtw0tf4sxTu4NiCBFA=;
 b=lt44FcXkMxUDh6q9khUYSL2oEam4GPnmX76RjE9D0CFXkwRec5bRiG1tdwuYLKs3LjC8mLbWMlojWY/+oy9Ey90wA1JgVnPOY8kI8MBwI/yVyB8xbOuXjB8AEEezLs+o2etvv/5Pm1Dn+ZEDyEAEZDKhbwaFJxxaYqmiCbonxTnzo4IX5Z399mTbAQJ7mP0J11bhgNyM4ai8TQvnylyYa56esOAv1r9fLnJX3yKIrzLLjDYBaHss9GrbqRNTFVOixr+drKZsAd8pPbUPf27sCm3T8g3N4JUZkLlfYiaA70eZ+ChVJ355QkY8RM24PeVaxF6b8IqDJw5qodlWzO5kDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4419.namprd15.prod.outlook.com (2603:10b6:806:196::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Tue, 17 Aug
 2021 19:01:11 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 19:01:11 +0000
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: fix flaky send_signal test
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210817171958.2769074-1-yhs@fb.com>
 <20210817172009.2770161-1-yhs@fb.com>
 <CAEf4BzbKJH6uyOCUswitC0VL+ayt9br15ppYdPE2JYxe6w_N_Q@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <00fd2f7d-d19b-d442-5d0e-4c05f65d7d68@fb.com>
Date:   Tue, 17 Aug 2021 12:01:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <CAEf4BzbKJH6uyOCUswitC0VL+ayt9br15ppYdPE2JYxe6w_N_Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: SJ0PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::10bd] (2620:10d:c090:400::5:8769) by SJ0PR13CA0103.namprd13.prod.outlook.com (2603:10b6:a03:2c5::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.11 via Frontend Transport; Tue, 17 Aug 2021 19:01:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4900b769-9f34-4e66-7d64-08d961b160a8
X-MS-TrafficTypeDiagnostic: SA1PR15MB4419:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB44196E8100CDC52D6613E5E7D3FE9@SA1PR15MB4419.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzg/WdJPycu2rFD+69Cg9r7JdQCCqz6GOHzDb2Al/i/UJh8y3s8T98BfOaA/P2me3XbxE5B0sjDLIR5EPsecCrIzGXhrzMxaKhW7TzYlUS2z8JeCoDobfiacnG79cv5FPop/jfuwL4l8bhD0Xdhx8XhtrfMLBRLQI9orXuVSzhT/UUmmXl7VGNxJM9F1NW2FwS8AIaX6hWHU3ziLtv7kqiE4pNkqajvVwSC45jQqEhJma/nT1WnV1Hkv7IW6U0letc3c2HxC3T6doOJrW9g1lhlTlK/VEs6UP7fZG2oS/+5LK2cwC2ErRvVAjH/E0WPnUu+IHw8pNht5sQczN8nZ2rAFIzOMlqd51N/As6O2GnuvOqKJhk1QAbAelq+8UJfViWhNq8pSSjUEASb+c3lNdxXW4r6/gxJNQjJ+AXA+TJVIIG+ezA59fH5IqyBTSEfjkAuYzLi7c+BH10ycHhrJU3FQNBQaE77/VWJiSF+L752G3BMLo9wCBrdDbDvRfCmp1+owIILm/QRje/CzUPWmZ71BHVmP0rlR9nrcIQEzieDT4T0JFbMvBFgDP57il3U99L8Xd73KluLFAb24xMjlloOn5EPIZp2gL1cQUXiDg0V8JS5zyqVx+pkGG1Fj48x6ZD/gIW/eqK3P4+qLgtInS14kpgtK+RJQGZOFyHQYmRiocSGRFmhB4m3QxhuIUaGLruzyNRj3jsyvSF6pladKz4P+RJNa5D4EtaayJdPKbE7UuhuNKmBLH7aLzGTJhMeXPmM7SAsPYE8UFpo/v9ka7292c9tya4zYTjqmJqQiAhwSDu1TWd23aazjkq1pCyOE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(316002)(54906003)(5660300002)(31696002)(53546011)(4326008)(66556008)(6486002)(66476007)(6916009)(966005)(2906002)(86362001)(38100700002)(2616005)(508600001)(36756003)(66946007)(8936002)(8676002)(31686004)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkRLOVowN3Y2eEsxK1Iwa3FPaVBteWF4V1hLcW9MSkZUWW45Z1ZaVkdaOUwr?=
 =?utf-8?B?b1ZmNnNPeFRtdkpZVWJRNC9oMUlZSFhmVE9zUEc4ZjhNa0Z3YlFrdlE5YzJx?=
 =?utf-8?B?SkdEaFYyMGVPeE9xdGUyQzUxV0dhQWo4dGNTNDVySGpubE5jZkJjWVpidzN3?=
 =?utf-8?B?WW1tS3RwYUtBTSsxcDlTSVUwVDlrMDczYnkralZ5WUNNYVZONXBQaUZXeGU5?=
 =?utf-8?B?N2tEM2JCanhLaDBxNDJodWhhMGVITXNxVkcrN2hhSzVqVHdBVzFHc1dKb0o2?=
 =?utf-8?B?dVpVTWI3ZkVQbzNpUklMWE9GQ2psSEE0bGQrRmNYcCtvMGVzaEdKRzhGaTlB?=
 =?utf-8?B?VnRHOXA2dFZqZGQwQUtiWnlUSm00UzZWRVZzaGNqbjhwSnc4Nm9lOEU4YWJE?=
 =?utf-8?B?UXhvQTIwcDh1N3Q4SE9GYVE5VklLWlhxMUkxL2FNTnVZZUltTnhRV2NDeTVz?=
 =?utf-8?B?TW1KQzJwNlUwTjM1a1VYWjcvU0Y5MWhYVXcwQ3UrZFg1YllpWkI2UXpvbnRF?=
 =?utf-8?B?ekZyRVlpSjRuMUZmK1ZqRjhNVUU5ek5xdThpMW1zZExsVmppaldTRzVzY29s?=
 =?utf-8?B?OHpPd1lNM1k0QVRDNXVHRkZZSzJ5U3RMV3E4Yk9hblpOeW9Gb1IvK1N5ZWRv?=
 =?utf-8?B?d00rSUZHZjd0TWZDMUlkZUZCM21valI5eGVOZlBBUkpuVVkwMnNVb2xTb010?=
 =?utf-8?B?UHpyUDJta1BWVFJrSzRINXIrWmFuSTZCd25BSUg0WWorc3UwL1Yyc2srUk8v?=
 =?utf-8?B?cmczRnlGSWhFUlhEU1hwZ1FQVDdHU0Fpb0RCVVhLT1NweUpKTkVIREFINVh2?=
 =?utf-8?B?MWJHK3JqOElobTlRUW9oN0YvWXFzWVBGaWJZVGlLbkhzYy80d2lteEQ1WDRX?=
 =?utf-8?B?ZzArbU8zNzlnUXloSGRjZGtXaGhJM0RTLzdDRlU1c0lsekErMTNkWm1lTXdT?=
 =?utf-8?B?NVpMNVlJUFF2NXArNHoyYzNIMkpwNEZxL2pvSk9xcEZ2Y2RUUHY0elRFNUJB?=
 =?utf-8?B?WWR2Skw4M0Vrcys4NGw2YW94NFM0d3hMU3o2QnQxdkJGWkRldUtEOElNVk1i?=
 =?utf-8?B?Z1FubkdDSU1LVTJZUjM1Y0k5UFQ3aUhPclQ2U3p6Q2FqWTBUUE40L3g1UHNL?=
 =?utf-8?B?bVRqaTRzOWpCOXZMNGVNdm5LSVo4UTBkUE8rR0hRdjVZeFRIUkEwQnIxbExh?=
 =?utf-8?B?dFh1eUxsckJ5SzFWRnV4bllWcDJJajVWRVpGTGFjOGhuSTdzWnpzQ2RjQ2FN?=
 =?utf-8?B?dVR4UlNyWkx0ZW43dzRwU2xTZG1CdisxZkNIejB6STNmV2xWbHZlVFhGZFYx?=
 =?utf-8?B?T0E1QjFXa2FhMUU3Y0NEbGFUOGVFSHdzOHI2RVlZcE9kTXlyMWhNdTVTMEdq?=
 =?utf-8?B?YjZTWk5XWHpsa1Q1cUU2QXVIUlBPREM1c01nWVZmYTJTQWJEVmFOdjc1RHRZ?=
 =?utf-8?B?TkFsUmVOaHJpRUVCK2VOd2QySDdkdlI2Vlp2ZTJKaExmZmx6Tm0rTnJIMlds?=
 =?utf-8?B?bE9BK1NvOG5xd2ZocERybmZ1UzhpZDVaa09ET2o5cWI1cGE1dGFSVzAyL2xn?=
 =?utf-8?B?a1B1c2tia1FrOXBSMHVBbmhQbWJDdUEzUUtUSE5LRlM1V0J0M0xKV3MxMURx?=
 =?utf-8?B?WlI3dU9FRVltQ2M0bUFseS8wc1NsNEU1TnFwYUpCbnlLYmhHL1IzR0RjRzg3?=
 =?utf-8?B?R0w5U1BLbDVPeENJSjhlVmo4Ukx1ZFFhQWczVFRBWnc5cmhHb1FBVnN3TkJa?=
 =?utf-8?B?L09DekZpT0svcFBycm03SHpMaVdnTDhOZlpYMXlsQ0JlNGJ3N1JBS0hReVFy?=
 =?utf-8?B?QlRRd2VPUkFBdG5pTUlndz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4900b769-9f34-4e66-7d64-08d961b160a8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 19:01:10.9845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAk4gNUsp+fcRqlWR9c/qxHsiDM7765GvcirFtPXC7rCHaGCVnhymY7/iYfsjjoI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4419
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Eo8oP3TV3g92A1X4SJsj_4-QF7Co1zU_
X-Proofpoint-GUID: Eo8oP3TV3g92A1X4SJsj_4-QF7Co1zU_
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-17_06:2021-08-17,2021-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 adultscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108170118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/17/21 11:45 AM, Andrii Nakryiko wrote:
> On Tue, Aug 17, 2021 at 10:20 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> libbpf CI has reported send_signal test is flaky although
>> I am not able to reproduce it in my local environment.
>> But I am able to reproduce with on-demand libbpf CI ([1]).
>>
>> Through code analysis, the following is possible reason.
>> The failed subtest runs bpf program in softirq environment.
>> Since bpf_send_signal() only sends to a fork of "test_progs"
>> process. If the underlying current task is
>> not "test_progs", bpf_send_signal() will not be triggered
>> and the subtest will fail.
>>
>> To reduce the chances where the underlying process is not
>> the intended one, this patch boosted scheduling priority to
>> -20 (highest allowed by setpriority() call). And I did
>> 10 runs with on-demand libbpf CI with this patch and I
>> didn't observe any failures.
>>
>>   [1] https://github.com/libbpf/libbpf/actions/workflows/ondemand.yml
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   .../selftests/bpf/prog_tests/send_signal.c    | 33 +++++++++++++++----
>>   .../bpf/progs/test_send_signal_kern.c         |  3 +-
>>   2 files changed, 28 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
>> index 41e158ae888e..0701c97456da 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
>> @@ -1,5 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   #include <test_progs.h>
>> +#include <sys/time.h>
>> +#include <sys/resource.h>
>>   #include "test_send_signal_kern.skel.h"
>>
>>   int sigusr1_received = 0;
>> @@ -10,7 +12,7 @@ static void sigusr1_handler(int signum)
>>   }
>>
>>   static void test_send_signal_common(struct perf_event_attr *attr,
>> -                                   bool signal_thread)
>> +                                   bool signal_thread, bool allow_skip)
>>   {
>>          struct test_send_signal_kern *skel;
>>          int pipe_c2p[2], pipe_p2c[2];
>> @@ -37,12 +39,23 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>>          }
>>
>>          if (pid == 0) {
>> +               int old_prio;
>> +
>>                  /* install signal handler and notify parent */
>>                  signal(SIGUSR1, sigusr1_handler);
>>
>>                  close(pipe_c2p[0]); /* close read */
>>                  close(pipe_p2c[1]); /* close write */
>>
>> +               /* boost with a high priority so we got a higher chance
>> +                * that if an interrupt happens, the underlying task
>> +                * is this process.
>> +                */
>> +               errno = 0;
>> +               old_prio = getpriority(PRIO_PROCESS, 0);
>> +               ASSERT_OK(errno, "getpriority");
>> +               ASSERT_OK(setpriority(PRIO_PROCESS, 0, -20), "setpriority");
>> +
>>                  /* notify parent signal handler is installed */
>>                  ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
>>
>> @@ -58,6 +71,9 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>>                  /* wait for parent notification and exit */
>>                  ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
>>
>> +               /* restore the old priority */
>> +               ASSERT_OK(setpriority(PRIO_PROCESS, 0, old_prio), "setpriority");
>> +
>>                  close(pipe_c2p[1]);
>>                  close(pipe_p2c[0]);
>>                  exit(0);
>> @@ -110,11 +126,16 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>>                  goto disable_pmu;
>>          }
>>
>> -       ASSERT_EQ(buf[0], '2', "incorrect result");
>> -
>>          /* notify child safe to exit */
>>          ASSERT_EQ(write(pipe_p2c[1], buf, 1), 1, "pipe_write");
>>
>> +       if (skel->bss->status == 0 && allow_skip) {
>> +               printf("%s:SKIP\n", __func__);
>> +               test__skip();
>> +       } else if (skel->bss->status != 1) {
>> +               ASSERT_EQ(buf[0], '2', "incorrect result");
>> +       }
>> +
>>   disable_pmu:
>>          close(pmu_fd);
>>   destroy_skel:
>> @@ -127,7 +148,7 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>>
>>   static void test_send_signal_tracepoint(bool signal_thread)
>>   {
>> -       test_send_signal_common(NULL, signal_thread);
>> +       test_send_signal_common(NULL, signal_thread, false);
>>   }
>>
>>   static void test_send_signal_perf(bool signal_thread)
>> @@ -138,7 +159,7 @@ static void test_send_signal_perf(bool signal_thread)
>>                  .config = PERF_COUNT_SW_CPU_CLOCK,
>>          };
>>
>> -       test_send_signal_common(&attr, signal_thread);
>> +       test_send_signal_common(&attr, signal_thread, true);
>>   }
>>
>>   static void test_send_signal_nmi(bool signal_thread)
>> @@ -167,7 +188,7 @@ static void test_send_signal_nmi(bool signal_thread)
>>                  close(pmu_fd);
>>          }
>>
>> -       test_send_signal_common(&attr, signal_thread);
>> +       test_send_signal_common(&attr, signal_thread, true);
>>   }
>>
>>   void test_send_signal(void)
>> diff --git a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
>> index b4233d3efac2..59c05c422bbd 100644
>> --- a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
>> +++ b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
>> @@ -18,8 +18,7 @@ static __always_inline int bpf_send_signal_test(void *ctx)
>>                          ret = bpf_send_signal_thread(sig);
>>                  else
>>                          ret = bpf_send_signal(sig);
>> -               if (ret == 0)
>> -                       status = 1;
>> +               status = (ret == 0) ? 1 : 2;
> 
> This doesn't make sense to me. status == 0 is the default value, it
> will stay 0 even if nothing is triggered, no BPF program is called,
> etc.

that is true.

> 
> If we are doing the skipping of the test logic (which I'd honestly
> just not do right now to see if we actually fixed the test), then I'd
> set status = 3 for the case when signal was triggered, but the current
> task is not test_progs. And only skip test if we get status 3. That
> is, status 0 and status 2 are bad (either not triggered, or some error
> when sending signal), 1 is OK, 3 is SKIP.

Here, we *assume* bpf program always got called which should be the case 
unless softirq/nmi logic goes wrong. so status = 0 means
pid doesn't match, and status = 1 means good bpf_send_signal happens,
status = 2 means bpf_send_signal helper fails.

> 
> But really, skipping a test that we couldn't randomly run doesn't feel
> good. Can you please leave the priority boosting part and drop the
> skipping part for now?

Sure. Let me drop skipping part. With the patch, I am expecting in 
*most* cases, we should not observe flakiness.

> 
>>          }
>>
>>          return 0;
>> --
>> 2.30.2
>>
