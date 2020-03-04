Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBDFE17979E
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 19:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgCDSMe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 13:12:34 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47984 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725795AbgCDSMd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Mar 2020 13:12:33 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 024ICKsh021185;
        Wed, 4 Mar 2020 10:12:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=guQSpOGIOU7Fm7VSKRiefxoDMEFM4o+bVwhwH6BJWkg=;
 b=LSxAa36B0XWLpp407NVh514kojZqdFEhMdZ2+Ay8og+MRL7jKsXnwiuft34yk/MLVHCw
 VWaoeRt7wiqfor2YJjuioPgKIa3zTsh8QfzVuJ1vt0vHu1TF7C64wcPCRCiZbNDHcafs
 e0dBCYRn/W5dxkYwOb9B/v6BFBVeOAfO4h8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 2yhwxxnv1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 04 Mar 2020 10:12:21 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 4 Mar 2020 10:12:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/cUgVAE4gt7x6R0hTmn7uwwIZuR3NbFsIDUH/Sqj4oJN7mGuFqk/Pa/BptaXoEfCrHKjl6tk37BMbWsMC0rWdgCyZELySQ9tfOSrNNCZfpLMqtHjWb46MCrTQGwRL/5bwfYHzqudfUFyMSOHvb2TxCKeZK88jqAoKtKagO6Q9VjO/bJmgVaAqM8+eP0ojPWgv4wmjkdov4he27x3D+80eRPJQRCURPnl/n0Ew/vWcu24Isa4dFHp7nIW03gCOkgRZwfjBOYggxI6nq/Ej42uBhhQX6cyi5+diD+PJcLLVftr/FuesAXdzje5h8Z8nR9h51s/NeJYUkIS19n87X7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guQSpOGIOU7Fm7VSKRiefxoDMEFM4o+bVwhwH6BJWkg=;
 b=XfdIjULjZWf+q1Np1n3n/f2D6dqwfOmIenGEFu8yxBG+IVNRG+KYYI1ACHD1Z81plydcMkRc/gM7FnjaD8i5n+kmA3oQ+peODaSVtqSWjtKfHh3OW/wzHlcgm91kFaK5nwf4MwH7y8kZm/qe7yds6w895NnXDINkZ69GnouQZ14sodO/AQCjvHomD+Wj5ybvM5HtZxxt7e+JLL4ICbmVWSIv7jn88WE+bR6iGYJ1iA/QyB9FPRGqhcJ4EaOa3dGtVh28xYY5xsK60tpOe1tbb1e8zudPIE1KVzQMTEBNf+nGIcrB1nlOGBcd4bkL2Ly7oMIZV0gWvS1bBJJC/HgiBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guQSpOGIOU7Fm7VSKRiefxoDMEFM4o+bVwhwH6BJWkg=;
 b=cmMmoi0FHaUJXmksMv755rNxCHeuiQKRb8UNFIKuP3VYfCjj8gtirgUEr82Js9+A/jqqPnkz/wm3mhMHqeslG4gPwS54KGAzjhGZWoP1JcjBgtK0l47xq2lOy5xidOPwbqIPcyZXwPlr/EpWVkr2XuOu5IkPKEaJzVQdikSt53U=
Received: from DM6PR15MB3001.namprd15.prod.outlook.com (2603:10b6:5:13c::16)
 by DM6PR15MB3225.namprd15.prod.outlook.com (2603:10b6:5:165::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 18:12:11 +0000
Received: from DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c]) by DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c%4]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 18:12:11 +0000
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: add send_signal_sched_switch
 test
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
References: <20200304175310.2389842-1-yhs@fb.com>
 <20200304175311.2389987-1-yhs@fb.com>
 <CAEf4BzZxwAbdMA+SPNkA_ZoBGd_q0Pr1jC5xT1hPdUq3pC+v3A@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <b6567fa5-cbab-a9c5-8a46-2767ca0d692f@fb.com>
Date:   Wed, 4 Mar 2020 10:12:08 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
In-Reply-To: <CAEf4BzZxwAbdMA+SPNkA_ZoBGd_q0Pr1jC5xT1hPdUq3pC+v3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR18CA0064.namprd18.prod.outlook.com
 (2603:10b6:104:2::32) To DM6PR15MB3001.namprd15.prod.outlook.com
 (2603:10b6:5:13c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from macbook-pro-52.dhcp.thefacebook.com (2620:10d:c090:500::5:3c54) by CO2PR18CA0064.namprd18.prod.outlook.com (2603:10b6:104:2::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16 via Frontend Transport; Wed, 4 Mar 2020 18:12:10 +0000
X-Originating-IP: [2620:10d:c090:500::5:3c54]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b10cc66-7932-4170-933d-08d7c0678f5e
X-MS-TrafficTypeDiagnostic: DM6PR15MB3225:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB322569CD159B800AF86F3503D3E50@DM6PR15MB3225.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:42;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(346002)(376002)(136003)(189003)(199004)(6512007)(8676002)(186003)(8936002)(478600001)(86362001)(31696002)(54906003)(81166006)(81156014)(6916009)(2616005)(4326008)(6486002)(53546011)(16526019)(5660300002)(52116002)(2906002)(31686004)(316002)(66556008)(66946007)(6506007)(36756003)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB3225;H:DM6PR15MB3001.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /3bj8MyThQE+vxYu+0REBauxOCP2yTqQHgZNHTvdmRNA9jdmaHVTY8DJaP1NegNkdyJ+/sdlXtdwtC9WQVkJoCSrUWZp0uszt7ULwFlFJ7SbVlbqgnIYNq9B5VjT2YWAIWaWFhIEdp7U+bUSEKl0i39A9xtaFWsDw1gWHdZwnIicN147+nPPxy7Np0YmPVo5kskikEIR96VaU1TrsM7bS89TcG2Z6wf+DM7fEiuvhhGEjTRhlyKUd/DcdD1GaSl9Zac/4Le8sfKLADtONjATt4z2FfBD2id8JUXScrfhNPP8LJigAJ7OEZOvXgdOjEhwo5aiRS1OHw3AYaCeXm4vPFnK94DPtEDPu8GAnlXc8XQ7y/uZjV3aawLx06z97JCFVEvlo/2sxIr2+zIDoOq6+3OUVCDVX6IGGLMPLafmF9ugOu3QTgG9gx2wvXbk37I/
X-MS-Exchange-AntiSpam-MessageData: 3zCszKKh/GffnYwaerNuStKRj+KBJZBfGe0fWegWmW/ujo4HlIbzCfcrBaWOE2STpzLWzzGNve6w7fri6tZOYrOqY2y2pWCjDlCFB+NvWaNlteqHEnjTMwPwpHbU25V10qaKwih3iLiTE1cnBahj4dlC7RSrcWsCylb22PQlp5SRly6QrMz7207eF+kvrIBR
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b10cc66-7932-4170-933d-08d7c0678f5e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 18:12:11.7647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gzi0VuMf7cWfFGvjMkh3SvuOj7WzQgf/ieyqYlyxZkUljHdnORXaJ6YNHRbMuyci
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3225
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_07:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040124
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/4/20 10:08 AM, Andrii Nakryiko wrote:
> On Wed, Mar 4, 2020 at 9:53 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Added one test, send_signal_sched_switch, to test bpf_send_signal()
>> helper triggered by sched/sched_switch tracepoint. This test can be used
>> to verify kernel deadlocks fixed by the previous commit. The test itself
>> is heavily borrowed from Commit eac9153f2b58 ("bpf/stackmap: Fix deadlock
>> with rq_lock in bpf_get_stack()").
>>
>> Cc: Song Liu <songliubraving@fb.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   .../bpf/prog_tests/send_signal_sched_switch.c | 89 +++++++++++++++++++
>>   .../bpf/progs/test_send_signal_kern.c         |  6 ++
>>   2 files changed, 95 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c b/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c
>> new file mode 100644
>> index 000000000000..f5c9dbdeb173
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c
>> @@ -0,0 +1,89 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <test_progs.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <sys/mman.h>
>> +#include <pthread.h>
>> +#include <sys/types.h>
>> +#include <sys/stat.h>
>> +#include <fcntl.h>
>> +#include "test_send_signal_kern.skel.h"
>> +
>> +static void sigusr1_handler(int signum)
>> +{
>> +}
>> +
>> +#define THREAD_COUNT 100
>> +
>> +static char *filename;
>> +
>> +static void *worker(void *p)
>> +{
>> +       int err, fd, i = 0;
>> +       u32 duration = 0;
>> +       char *pptr;
>> +       void *ptr;
>> +
>> +       fd = open(filename, O_RDONLY);
>> +       if (CHECK(fd < 0, "open", "open failed %s\n", strerror(errno)))
>> +               return NULL;
>> +
>> +       while (i < 100) {
>> +               struct timespec ts = {0, 1000 + rand() % 2000};
>> +
>> +               ptr = mmap(NULL, 4096 * 64, PROT_READ, MAP_PRIVATE, fd, 0);
>> +               err = errno;
>> +               usleep(1);
>> +               if (CHECK(ptr == MAP_FAILED, "mmap", "mmap failed: %s\n",
>> +                         strerror(err)))
>> +                       break;
>> +
>> +               munmap(ptr, 4096 * 64);
>> +               usleep(1);
>> +               pptr = malloc(1);
>> +               usleep(1);
>> +               pptr[0] = 1;
>> +               usleep(1);
>> +               free(pptr);
>> +               usleep(1);
>> +               nanosleep(&ts, NULL);
>> +               i++;
> 
> 
> Any specific reason to do mmap()/munmap() in a loop? Would, say,
> getpid syscall work just fine as well to trigger a bunch of context
> switches? Or event just usleep(1) alone?

No particular reason. Copied from Song's original reproducer and
it is working. Maybe Song can comment why it is written this way.

> 
>> +       }
>> +       close(fd);
>> +       return NULL;
>> +}
>> +
>> +void test_send_signal_sched_switch(void)
>> +{
>> +       struct test_send_signal_kern *skel;
>> +       pthread_t threads[THREAD_COUNT];
>> +       u32 duration = 0;
>> +       int i, err;
>> +
>> +       filename = "/bin/ls";
>> +       signal(SIGUSR1, sigusr1_handler);
>> +
>> +       skel = test_send_signal_kern__open_and_load();
>> +       if (CHECK(!skel, "skel_open_and_load", "skeleton open_and_load failed\n"))
>> +               return;
>> +
>> +       skel->bss->pid = getpid();
>> +       skel->bss->sig = SIGUSR1;
>> +
>> +       err = test_send_signal_kern__attach(skel);
>> +       if (CHECK(err, "skel_attach", "skeleton attach failed\n"))
>> +               goto destroy_skel;
>> +
>> +       for (i = 0; i < THREAD_COUNT; i++) {
>> +               err = pthread_create(threads + i, NULL, worker, NULL);
>> +               if (CHECK(err, "pthread_create", "Error creating thread, %s\n",
>> +                         strerror(errno)))
>> +                       goto destroy_skel;
>> +       }
>> +
>> +       for (i = 0; i < THREAD_COUNT; i++)
>> +               pthread_join(threads[i], NULL);
>> +
>> +destroy_skel:
>> +       test_send_signal_kern__destroy(skel);
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
>> index 1acc91e87bfc..b4233d3efac2 100644
>> --- a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
>> +++ b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
>> @@ -31,6 +31,12 @@ int send_signal_tp(void *ctx)
>>          return bpf_send_signal_test(ctx);
>>   }
>>
>> +SEC("tracepoint/sched/sched_switch")
>> +int send_signal_tp_sched(void *ctx)
>> +{
>> +       return bpf_send_signal_test(ctx);
>> +}
>> +
>>   SEC("perf_event")
>>   int send_signal_perf(void *ctx)
>>   {
>> --
>> 2.17.1
>>
