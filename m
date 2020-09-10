Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08272264A7E
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 18:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgIJQ7n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 12:59:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32176 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726896AbgIJQ7S (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Sep 2020 12:59:18 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AGo2Fl159144;
        Thu, 10 Sep 2020 12:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=v6/zAaoG1Sjd6aUOJf/A0yLMiXMZAiPChvW6b2nBqsk=;
 b=AV6LU9CC0/AtFzgxNbesGgVHYJ1EiN3M4B/Ftwb6IOzWu0tgeSXtm/DsaQD3NDe6o0fb
 8YlsGQqSXC1OGjxNH0SAZX066XG7nCct9rjqqM3+BLBMX2iA973hCRny76QW9Laragd1
 hk4Pa4JqQXkFGHKKASsh4Cc565tbkjM7jEOPg3YO+bC0sE+1mzfc7VZmFA4px5NuN0Qa
 h7vvdznpV/9TvaNlEaU9u8jfV4ElzLB+rQezU0ZrGEPGu1CkTib+gDMrinKvjdSY9dUq
 C7hSikawrIlrk8jhnJZV7sY/SleezkdaxguDqd7EY+r1VsPrItLXMYgv7Al3Nh+VVIDJ VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33fr0wg6jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 12:59:08 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08AGpAuZ161688;
        Thu, 10 Sep 2020 12:59:08 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33fr0wg6hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 12:59:08 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08AGv8OD029630;
        Thu, 10 Sep 2020 16:59:06 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 33c2a8bkpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 16:59:06 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08AGvU5Z66126258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 16:57:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE8CB5204F;
        Thu, 10 Sep 2020 16:59:03 +0000 (GMT)
Received: from sig-9-145-5-224.uk.ibm.com (unknown [9.145.5.224])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B5A665204E;
        Thu, 10 Sep 2020 16:59:03 +0000 (GMT)
Message-ID: <7ec11f349647de2a16fc8b491b88473ed4773001.camel@linux.ibm.com>
Subject: Re: [PATCH v3 bpf-next 3/9] selftests/bpf: add __ksym extern
 selftest
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>
Date:   Thu, 10 Sep 2020 18:59:03 +0200
In-Reply-To: <CAEf4BzZTZsQTJSY-+ex5uLSUnYMW7RRWtbMEVFRWuzd8QsnAkg@mail.gmail.com>
References: <20200619231703.738941-1-andriin@fb.com>
         <20200619231703.738941-4-andriin@fb.com>
         <ba11b067a4d9635ee4e28ccc1b2896cc9c8c5be1.camel@linux.ibm.com>
         <CAEf4BzZTZsQTJSY-+ex5uLSUnYMW7RRWtbMEVFRWuzd8QsnAkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_04:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=3 clxscore=1015
 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100148
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2020-09-10 at 09:47 -0700, Andrii Nakryiko wrote:
> On Wed, Sep 9, 2020 at 6:59 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > Hi!
> > 
> > On Fri, 2020-06-19 at 16:16 -0700, Andrii Nakryiko wrote:
> > > Validate libbpf is able to handle weak and strong kernel symbol
> > > externs in BPF
> > > code correctly.
> > > 
> > > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> > > ---
> > >  .../testing/selftests/bpf/prog_tests/ksyms.c  | 71
> > > +++++++++++++++++++
> > >  .../testing/selftests/bpf/progs/test_ksyms.c  | 32 +++++++++
> > >  2 files changed, 103 insertions(+)
> > >  create mode 100644
> > > tools/testing/selftests/bpf/prog_tests/ksyms.c
> > >  create mode 100644
> > > tools/testing/selftests/bpf/progs/test_ksyms.c
> > > 
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c
> > > b/tools/testing/selftests/bpf/prog_tests/ksyms.c
> > > new file mode 100644
> > > index 000000000000..e3d6777226a8
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
> > > @@ -0,0 +1,71 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/* Copyright (c) 2019 Facebook */
> > > +
> > > +#include <test_progs.h>
> > > +#include "test_ksyms.skel.h"
> > > +#include <sys/stat.h>
> > > +
> > > +static int duration;
> > > +
> > > +static __u64 kallsyms_find(const char *sym)
> > > +{
> > > +     char type, name[500];
> > > +     __u64 addr, res = 0;
> > > +     FILE *f;
> > > +
> > > +     f = fopen("/proc/kallsyms", "r");
> > > +     if (CHECK(!f, "kallsyms_fopen", "failed to open: %d\n",
> > > errno))
> > > +             return 0;
> > > +
> > > +     while (fscanf(f, "%llx %c %499s%*[^\n]\n", &addr, &type,
> > > name)
> > > > 0) {
> > > +             if (strcmp(name, sym) == 0) {
> > > +                     res = addr;
> > > +                     goto out;
> > > +             }
> > > +     }
> > > +
> > > +     CHECK(false, "not_found", "symbol %s not found\n", sym);
> > > +out:
> > > +     fclose(f);
> > > +     return res;
> > > +}
> > > +
> > > +void test_ksyms(void)
> > > +{
> > > +     __u64 link_fops_addr = kallsyms_find("bpf_link_fops");
> > > +     const char *btf_path = "/sys/kernel/btf/vmlinux";
> > > +     struct test_ksyms *skel;
> > > +     struct test_ksyms__data *data;
> > > +     struct stat st;
> > > +     __u64 btf_size;
> > > +     int err;
> > > +
> > > +     if (CHECK(stat(btf_path, &st), "stat_btf", "err %d\n",
> > > errno))
> > > +             return;
> > > +     btf_size = st.st_size;
> > > +
> > > +     skel = test_ksyms__open_and_load();
> > > +     if (CHECK(!skel, "skel_open", "failed to open and load
> > > skeleton\n"))
> > > +             return;
> > > +
> > > +     err = test_ksyms__attach(skel);
> > > +     if (CHECK(err, "skel_attach", "skeleton attach failed:
> > > %d\n",
> > > err))
> > > +             goto cleanup;
> > > +
> > > +     /* trigger tracepoint */
> > > +     usleep(1);
> > > +
> > > +     data = skel->data;
> > > +     CHECK(data->out__bpf_link_fops != link_fops_addr,
> > > "bpf_link_fops",
> > > +           "got 0x%llx, exp 0x%llx\n",
> > > +           data->out__bpf_link_fops, link_fops_addr);
> > > +     CHECK(data->out__bpf_link_fops1 != 0, "bpf_link_fops1",
> > > +           "got %llu, exp %llu\n", data->out__bpf_link_fops1,
> > > (__u64)0);
> > > +     CHECK(data->out__btf_size != btf_size, "btf_size",
> > > +           "got %llu, exp %llu\n", data->out__btf_size,
> > > btf_size);
> > > +     CHECK(data->out__per_cpu_start != 0, "__per_cpu_start",
> > > +           "got %llu, exp %llu\n", data->out__per_cpu_start,
> > > (__u64)0);
> > > +
> > > +cleanup:
> > > +     test_ksyms__destroy(skel);
> > > +}
> > 
> > Why is __per_cpu_start expected to be 0? On my x86_64 Debian VM it
> > is
> > something like ffffffffxxxxxxxx, and this test fails. Wouldn't
> > it be better to take the value from kallsyms, like it's done with
> > bpf_link_fops, or am I missing something in my setup?
> > 
> 
> Hm... those per-CPU symbols are not real addresses, they are relative
> offsets, so I thought that __per_cpu_start always got to be 0.
> Strange
> that you see a real kernel address instead. I guess looking up in
> kallsyms would work either way, please feel free to send a fix.
> Thanks!

Hm, I think I have an explanation now - I accidentally built a non-SMP
kernel :-) I'll send a fix.

