Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0669F1797ED
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 19:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgCDSaj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 13:30:39 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17208 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729675AbgCDSai (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Mar 2020 13:30:38 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 024ITMXr012611;
        Wed, 4 Mar 2020 10:30:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=UtNw3yRXVXkxveQ5XTCKG3bI0iwT0exPteuz4494emk=;
 b=aXNu5OKbVr83zNH2VlZIQEUc632X6TF1NbXUyiSxmnulD46KTLPRruVVAkjyN2zJ8oIn
 Nz9eb/rfTTaWkjR53iZVWwU8Q0ym0QuAXw2z1AdZcbXx71zG/C3P6sdmtIe7wE8Eas63
 GS0ev9aQYg0DZfOvLPiUdKd+DyJdZVg7gIo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2yhv7vpk1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 04 Mar 2020 10:30:27 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 4 Mar 2020 10:30:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccxFBr/ZDyWxlquLiF5YPiW7eE31Ik919y4p2gvKsGAU4pMltK9nQagugpBplVxGOrSHhW762IwISl1gKlI60JnKjSuLy4fXMjZsSj9qAm1Y8H8Vy5AhfNpQ3ASOqedeTQPLL9DDGvHdmc7qY7eFmmYySucifK6sJ5ksulfumhlOeg60Tj2Bc60Q1sjr8paR9YycXTjRaReFZI+ia13hrm0lR9Wfo5XyG1mKCJw7pWnyW7x9om3/IGs9sNeCuvLPjkoXbxEmCFwwQ+58M54s8eJEQ+t2nLWMgEBnbgBDUIQTksHBv9bpyLEKi0//xz3TbwsKVQC0HW8En2aIQkUhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtNw3yRXVXkxveQ5XTCKG3bI0iwT0exPteuz4494emk=;
 b=HVeeNOO7mfblAj91Fl+HdeoIFrLT/SdOUumTsurJO5xScC+yHVuji24xhGEHtKW36sF+RZaq38FSmnPMX/UL0EYHn9LAABATQXVj6dg+gECgWuaXwl0UnrnZImttsiB7cEJ2Aaljco9i5oeY7vJ2eeHL86/FpniSRjWkqL9iuBOodcL2Ee/Dvg+S04wYWH62PccCe89iQbRJg8dvdxTluU2nOck1jvkbY6F07RCjc1g9K+MuP0q1SZOveMxbVtr5X2/530Fd/DIOXbYpyKt3Vgpa/uf45XBlv8QuIyrpVdZSVH/GJv5wFsf0CkH0/l2L7FYhRfa+8pEpAhHQPO9QMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtNw3yRXVXkxveQ5XTCKG3bI0iwT0exPteuz4494emk=;
 b=DW3tqBycO/wMHnStMFAL9FQIXGfO2Z5LrES/90qrIACQSzZp1cPxSVJg0ntjlB8cqtfm6ngvVmwHrb+4S4WSKq2MhLg8/2we1eGPsWJeCIIRzOm5rNHZFI16R7pU/fcv5H9K51dsFR4OXYER5JEHJgAUejCSoaoLs6zUhjZZHlM=
Received: from MW3PR15MB3882.namprd15.prod.outlook.com (2603:10b6:303:49::11)
 by MW3PR15MB3836.namprd15.prod.outlook.com (2603:10b6:303:45::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Wed, 4 Mar
 2020 18:30:24 +0000
Received: from MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5]) by MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5%5]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 18:30:24 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: add send_signal_sched_switch
 test
Thread-Topic: [PATCH bpf v2 2/2] selftests/bpf: add send_signal_sched_switch
 test
Thread-Index: AQHV8k3x064hLfnWp0aT76+XdkBMDqg4u0sAgAAA7gCAAAUbAA==
Date:   Wed, 4 Mar 2020 18:30:24 +0000
Message-ID: <A3268E98-91FB-4972-9B41-6B803E9BE81D@fb.com>
References: <20200304175310.2389842-1-yhs@fb.com>
 <20200304175311.2389987-1-yhs@fb.com>
 <CAEf4BzZxwAbdMA+SPNkA_ZoBGd_q0Pr1jC5xT1hPdUq3pC+v3A@mail.gmail.com>
 <b6567fa5-cbab-a9c5-8a46-2767ca0d692f@fb.com>
In-Reply-To: <b6567fa5-cbab-a9c5-8a46-2767ca0d692f@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.60.0.2.5)
x-originating-ip: [2620:10d:c090:400::5:4f8d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2dfa745-e44b-4148-bfd6-08d7c06a1aff
x-ms-traffictypediagnostic: MW3PR15MB3836:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR15MB38362B2A2E31414ACAF37DADB3E50@MW3PR15MB3836.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:37;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(136003)(39860400002)(199004)(189003)(86362001)(6486002)(2906002)(6636002)(6512007)(4326008)(6862004)(8676002)(8936002)(186003)(81166006)(5660300002)(81156014)(6506007)(53546011)(64756008)(66946007)(478600001)(2616005)(66476007)(66556008)(36756003)(33656002)(316002)(54906003)(37006003)(71200400001)(76116006)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR15MB3836;H:MW3PR15MB3882.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DOYqaKxCB7aap/TZkzPFkoMgrQKt3vf6L9jSbeDGTBGTphthvQHZ5glut/j9sSLV1YDdbzaX29ndhfQ45z0JISoDUYXTMkDXHs9ChPFTXl7Ea7fgAK6XSwOOSC8+MqjV2xjitmFJFz2PBvIR9A7zlwG1kqRMaFw1Tq8pdTAXiPA5rFeuNSTJT8HyQHmIBazbz1dYXYCSbByCHVyFSoKEzMGIYFIUDxOwodv8yhZ5PPAGaifEkgOECXj0Ks324hoT+Sml580YyBPg/+rMKJxhYrFNlzVdIeIGVBL05TSZyGOPSRrAiBN9p3c+CfQxSCI9JNy2aCIjOWWQtcWyM091mglaO5uHFd7Ij7DUWIvzb/HfQaTzK7Q70M2hn5YrQZk8tH2eFhRepTboVuu9gzafZmSFZpczT4dSldgueayiHXLIUTgNqjVyACsKqT31Y4Ui
x-ms-exchange-antispam-messagedata: 1B45XVCn9MUMRPfR55jmoVHEODnJgSOmeeAdr9zz1AGynfWAn9GYzxLSqF/WK7podIw4N2Ysz4RU2imM5V9s8vtwS2J7jdeujav/NKCWbXCoewz3fiEL5iZnpjgmxZSwNxjnV0kvwKohLXq3EElhE11PKE+++1m98QwlxGSxAunJYBe98d5XQd2Kb3Rv8xDk
Content-Type: text/plain; charset="us-ascii"
Content-ID: <621F982CDE46B449B298D42C98560405@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c2dfa745-e44b-4148-bfd6-08d7c06a1aff
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 18:30:24.6148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YnT7UB2EQ7HqLIewLULczh6I/RLbaxFv+t2YdHQf5/SiyG1gKDfsAzjgqs0/BAkO4Do9nYLBMmrYR6mCxjGFSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3836
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_07:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040125
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Mar 4, 2020, at 10:12 AM, Yonghong Song <yhs@fb.com> wrote:
>=20
>=20
>=20
> On 3/4/20 10:08 AM, Andrii Nakryiko wrote:
>> On Wed, Mar 4, 2020 at 9:53 AM Yonghong Song <yhs@fb.com> wrote:
>>>=20
>>> Added one test, send_signal_sched_switch, to test bpf_send_signal()
>>> helper triggered by sched/sched_switch tracepoint. This test can be use=
d
>>> to verify kernel deadlocks fixed by the previous commit. The test itsel=
f
>>> is heavily borrowed from Commit eac9153f2b58 ("bpf/stackmap: Fix deadlo=
ck
>>> with rq_lock in bpf_get_stack()").
>>>=20
>>> Cc: Song Liu <songliubraving@fb.com>
>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>> ---
>>>  .../bpf/prog_tests/send_signal_sched_switch.c | 89 +++++++++++++++++++
>>>  .../bpf/progs/test_send_signal_kern.c         |  6 ++
>>>  2 files changed, 95 insertions(+)
>>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/send_signal_=
sched_switch.c
>>>=20
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal_sched_s=
witch.c b/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c
>>> new file mode 100644
>>> index 000000000000..f5c9dbdeb173
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c
>>> @@ -0,0 +1,89 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +#include <test_progs.h>
>>> +#include <stdio.h>
>>> +#include <stdlib.h>
>>> +#include <sys/mman.h>
>>> +#include <pthread.h>
>>> +#include <sys/types.h>
>>> +#include <sys/stat.h>
>>> +#include <fcntl.h>
>>> +#include "test_send_signal_kern.skel.h"
>>> +
>>> +static void sigusr1_handler(int signum)
>>> +{
>>> +}
>>> +
>>> +#define THREAD_COUNT 100
>>> +
>>> +static char *filename;
>>> +
>>> +static void *worker(void *p)
>>> +{
>>> +       int err, fd, i =3D 0;
>>> +       u32 duration =3D 0;
>>> +       char *pptr;
>>> +       void *ptr;
>>> +
>>> +       fd =3D open(filename, O_RDONLY);
>>> +       if (CHECK(fd < 0, "open", "open failed %s\n", strerror(errno)))
>>> +               return NULL;
>>> +
>>> +       while (i < 100) {
>>> +               struct timespec ts =3D {0, 1000 + rand() % 2000};
>>> +
>>> +               ptr =3D mmap(NULL, 4096 * 64, PROT_READ, MAP_PRIVATE, f=
d, 0);
>>> +               err =3D errno;
>>> +               usleep(1);
>>> +               if (CHECK(ptr =3D=3D MAP_FAILED, "mmap", "mmap failed: =
%s\n",
>>> +                         strerror(err)))
>>> +                       break;
>>> +
>>> +               munmap(ptr, 4096 * 64);
>>> +               usleep(1);
>>> +               pptr =3D malloc(1);
>>> +               usleep(1);
>>> +               pptr[0] =3D 1;
>>> +               usleep(1);
>>> +               free(pptr);
>>> +               usleep(1);
>>> +               nanosleep(&ts, NULL);
>>> +               i++;
>> Any specific reason to do mmap()/munmap() in a loop? Would, say,
>> getpid syscall work just fine as well to trigger a bunch of context
>> switches? Or event just usleep(1) alone?
>=20
> No particular reason. Copied from Song's original reproducer and
> it is working. Maybe Song can comment why it is written this way.

In that test, mmap/munmap are used to lock mmap_sem. I guess we=20
don't really need them in this test.=20

Thanks,
song=
