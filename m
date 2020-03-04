Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D049D1797FC
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 19:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgCDSfE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 13:35:04 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9282 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725795AbgCDSfE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Mar 2020 13:35:04 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024IU3Ve024611;
        Wed, 4 Mar 2020 10:34:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=yE2s6TxPzW+8KVvGI5G2iB14EpBkWCvGn5CeRhmDdVE=;
 b=BMiQx3jqhE4vsE7QHCQvM3WjQIjJy5427h1gYYDy9A3yTp9eWPtSrTZaVpP1bNwQX8jz
 72EBCnQ/p8epFhIuVLqep5Xir6e9xQ2rZ+dH8MaxD7Qy0hLxgQ66ku4AuuceFdhMp+KW
 tWfLh7vxt+IgD9vDkkC6mJOrNnSlQw3HOXc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yht647ac6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 04 Mar 2020 10:34:52 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 4 Mar 2020 10:34:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2RgQKpVRFd0KeEGgIccX8/ZwF7gqL3HfwFSFMbvVh0iTKDYA0BCNLis2mBZSlf6mUxtXoLPi/WAo5R9HyQTBQr16tRiIRpD1wRy5hleMsqkxkojTjZdQk5VN2SyBYjqD0BiAOqCraQJWSHtkhMorBZcaT1NG9EPx0h6/OF3St9MaJ8uNkrbq9X1xLpLugMF8Q1Ld3+FvuiHqnzyqld1qiP0YTNmi6QJmxp6GR52RaATiAkW+otYlCx6z2AyUQ7tymzdB2Mz4klQE3bJWAVNiUlkV4c5gVwd5nlUAPVH05pRPGcDmt8f9Lsc+0PBEfIIbxjn1pa2EQpT74JZ4pwpJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yE2s6TxPzW+8KVvGI5G2iB14EpBkWCvGn5CeRhmDdVE=;
 b=bbEgvYASybeMKDe4TLaHDUb5Ok/BWJuFobO+M9nlVidXlsZF9epR3XktQTIRQUY3UGrAUnKzVWm4i1x47Dkj+edU6wGuv0o5qWpFLAzXPJlElvnztWOi4GtIfdtLHTN0DwrPNJns1Gtbi6YCVOMQtsq8i0q+jGiRHj8gkkzETZy25A1t6tKnVvPXCvmS9geeTo5Og+54M1Gus84pQHuvXG5leiSqzQwzn5hqJpoXdYP+n2AYFRce4bfhbbXmkVZnSR+VGwA4NFT+6+k4qR08sQSPkdeoyz812qRHITOw0gZzgZFN/RMUzohce1HRLOPyNFMODO3WXTg+Ozp15A7VxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yE2s6TxPzW+8KVvGI5G2iB14EpBkWCvGn5CeRhmDdVE=;
 b=XAC09epaI0snzlod8O1bMQX9VDgIwHpd9uHGxCatwhoh4LO0BPz/V8LAbtA3qdgrzYiNdVYu8+cf70lkkHaMcTzUlMqwwsjfDYpCdrtpH1I5LWmxXDet/TqGhE4aotB6UQ6Ul0T7IOtJ75I511hQ1Dx9RyG79VuhHBry4QeCPr4=
Received: from DM6PR15MB3001.namprd15.prod.outlook.com (2603:10b6:5:13c::16)
 by DM6PR15MB2539.namprd15.prod.outlook.com (2603:10b6:5:1a4::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Wed, 4 Mar
 2020 18:34:47 +0000
Received: from DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c]) by DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c%4]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 18:34:47 +0000
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: add send_signal_sched_switch
 test
To:     Song Liu <songliubraving@fb.com>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
References: <20200304175310.2389842-1-yhs@fb.com>
 <20200304175311.2389987-1-yhs@fb.com>
 <CAEf4BzZxwAbdMA+SPNkA_ZoBGd_q0Pr1jC5xT1hPdUq3pC+v3A@mail.gmail.com>
 <b6567fa5-cbab-a9c5-8a46-2767ca0d692f@fb.com>
 <A3268E98-91FB-4972-9B41-6B803E9BE81D@fb.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <611d0b3b-18bd-8564-4c8d-de7522ada0ba@fb.com>
Date:   Wed, 4 Mar 2020 10:34:43 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
In-Reply-To: <A3268E98-91FB-4972-9B41-6B803E9BE81D@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR17CA0083.namprd17.prod.outlook.com
 (2603:10b6:300:c2::21) To DM6PR15MB3001.namprd15.prod.outlook.com
 (2603:10b6:5:13c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from macbook-pro-52.dhcp.thefacebook.com (2620:10d:c090:500::5:3c54) by MWHPR17CA0083.namprd17.prod.outlook.com (2603:10b6:300:c2::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 18:34:46 +0000
X-Originating-IP: [2620:10d:c090:500::5:3c54]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60320a7d-ea22-44cb-7fff-08d7c06ab752
X-MS-TrafficTypeDiagnostic: DM6PR15MB2539:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB25390B63C4D6543DEE7B7FCAD3E50@DM6PR15MB2539.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:53;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(136003)(189003)(199004)(16526019)(6636002)(186003)(36756003)(6512007)(66556008)(66476007)(31696002)(6666004)(86362001)(4326008)(81166006)(478600001)(6506007)(6862004)(54906003)(81156014)(316002)(37006003)(53546011)(8936002)(66946007)(5660300002)(2906002)(6486002)(2616005)(52116002)(31686004)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB2539;H:DM6PR15MB3001.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jgyVBAHGiqrmBXsK6m0R7uzmbeflnIrK7r5KgkeJi2qEgVAHCeykqD594f0nQhsxqGfxsRh8PWhHUmu5w4VHGc+Bir+MqoXPebGQr+zHhEksG/cMtI8xBJginwliALKppJ084xX+xfafdJJ4QCy1jxSmOpEfxhkDBaD0g+M2+oC0tSVU0ScMz/4rapKvd+d/sOtltlbIctjvF16qL5tjz1SXbKXP9LFT6wUSbeXmKrZeyEfhViUvfqRBClwJ6F5PNFBMyv8x8wXYrdcXMPFQ403hKtEiNpu/Pzp0Dm1/8mACEMwXxuPbdrP9rjNEkrh+lJ6lYU7je5xcF6HOjmMiF0d7OjxgH8ylYhEju8nqtP2+61UR+Lc/glGmlcRmz/yDJSdi50RrJ1T3O8Svpxki1dn7OpsLEM+wpJHh46IgEZBdIxRH8T4qp5ktb0ZWomB
X-MS-Exchange-AntiSpam-MessageData: WOiYfmyEx/0rFrgIFNnyAlU1VGyA8LCKhlKk/jpmvCWGkeZoGujMeCOIbnYZnEQzeRwvf1vo13pvdb7qgPrHjdOfIqsYDzI+C37kqmWhWSP+vZ84o1MMkQYtdqlwkBzLtrcUBgv5UhV6/nZkez7vC26fyj2yHgFSssQUduyavuqdmgxw9IpSjrztqcEfgHdP
X-MS-Exchange-CrossTenant-Network-Message-Id: 60320a7d-ea22-44cb-7fff-08d7c06ab752
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 18:34:47.2597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvIXnKubT23yPMVlKe6MQdi2I4XnDjNpQG4+qE8MM0ryzh2RiPtXF1iDYNF6jPoq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2539
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_07:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040125
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/4/20 10:30 AM, Song Liu wrote:
> 
> 
>> On Mar 4, 2020, at 10:12 AM, Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 3/4/20 10:08 AM, Andrii Nakryiko wrote:
>>> On Wed, Mar 4, 2020 at 9:53 AM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>> Added one test, send_signal_sched_switch, to test bpf_send_signal()
>>>> helper triggered by sched/sched_switch tracepoint. This test can be used
>>>> to verify kernel deadlocks fixed by the previous commit. The test itself
>>>> is heavily borrowed from Commit eac9153f2b58 ("bpf/stackmap: Fix deadlock
>>>> with rq_lock in bpf_get_stack()").
>>>>
>>>> Cc: Song Liu <songliubraving@fb.com>
>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>>> ---
>>>>   .../bpf/prog_tests/send_signal_sched_switch.c | 89 +++++++++++++++++++
>>>>   .../bpf/progs/test_send_signal_kern.c         |  6 ++
>>>>   2 files changed, 95 insertions(+)
>>>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c b/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c
>>>> new file mode 100644
>>>> index 000000000000..f5c9dbdeb173
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c
>>>> @@ -0,0 +1,89 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +#include <test_progs.h>
>>>> +#include <stdio.h>
>>>> +#include <stdlib.h>
>>>> +#include <sys/mman.h>
>>>> +#include <pthread.h>
>>>> +#include <sys/types.h>
>>>> +#include <sys/stat.h>
>>>> +#include <fcntl.h>
>>>> +#include "test_send_signal_kern.skel.h"
>>>> +
>>>> +static void sigusr1_handler(int signum)
>>>> +{
>>>> +}
>>>> +
>>>> +#define THREAD_COUNT 100
>>>> +
>>>> +static char *filename;
>>>> +
>>>> +static void *worker(void *p)
>>>> +{
>>>> +       int err, fd, i = 0;
>>>> +       u32 duration = 0;
>>>> +       char *pptr;
>>>> +       void *ptr;
>>>> +
>>>> +       fd = open(filename, O_RDONLY);
>>>> +       if (CHECK(fd < 0, "open", "open failed %s\n", strerror(errno)))
>>>> +               return NULL;
>>>> +
>>>> +       while (i < 100) {
>>>> +               struct timespec ts = {0, 1000 + rand() % 2000};
>>>> +
>>>> +               ptr = mmap(NULL, 4096 * 64, PROT_READ, MAP_PRIVATE, fd, 0);
>>>> +               err = errno;
>>>> +               usleep(1);
>>>> +               if (CHECK(ptr == MAP_FAILED, "mmap", "mmap failed: %s\n",
>>>> +                         strerror(err)))
>>>> +                       break;
>>>> +
>>>> +               munmap(ptr, 4096 * 64);
>>>> +               usleep(1);
>>>> +               pptr = malloc(1);
>>>> +               usleep(1);
>>>> +               pptr[0] = 1;
>>>> +               usleep(1);
>>>> +               free(pptr);
>>>> +               usleep(1);
>>>> +               nanosleep(&ts, NULL);
>>>> +               i++;
>>> Any specific reason to do mmap()/munmap() in a loop? Would, say,
>>> getpid syscall work just fine as well to trigger a bunch of context
>>> switches? Or event just usleep(1) alone?
>>
>> No particular reason. Copied from Song's original reproducer and
>> it is working. Maybe Song can comment why it is written this way.
> 
> In that test, mmap/munmap are used to lock mmap_sem. I guess we
> don't really need them in this test.

Thanks. I will simplify the test then. The goal is to get more context 
switches.

> 
> Thanks,
> song
> 
