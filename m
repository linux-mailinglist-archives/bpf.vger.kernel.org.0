Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22DA42A2C8
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 13:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbhJLLFb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 07:05:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232810AbhJLLFb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 Oct 2021 07:05:31 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19C8ZGU7027281;
        Tue, 12 Oct 2021 07:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Xowob3foClNe+UBjgCiRQuCluyPw48N2b8lBCW2lXoY=;
 b=oQOijNlax7dTYgIrcgvz/8EBsvX6EPig1X3c6jCx+HQuMaXL5Z4bvCvu63K1zwII8crm
 QN9q52TwVIPhsZRVadph/xt8kSWJ3DnzY/7fFtJU2ezxPGwNTjO7aTAyYluAoVqLQQmH
 01DDY3T/fSs/njELBCPuU7nuYTBjxMh8hNcjZPiCnwt0Trf674TvPKt+aoC8M3GXosK3
 1hTbyA0vyoWQPaygCyHOm/tP4svJV+BV6jO/O1N/ivXWftuw/2UPHmplMhVCoEE3JupV
 id6MgnWcOt81cGHBHNI3/590p6SUaEge8/shuGPo9Zfa2/TfFjr32NJwB/k11OkSUzV6 Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn49ypk1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 07:03:16 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19CAwXS2025329;
        Tue, 12 Oct 2021 07:03:16 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn49ypjyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 07:03:16 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19CApNeT021504;
        Tue, 12 Oct 2021 11:03:13 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3bk2q9nr2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 11:03:13 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19CAvRfL60293428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 10:57:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 087464C09C;
        Tue, 12 Oct 2021 11:03:00 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A45304C040;
        Tue, 12 Oct 2021 11:02:59 +0000 (GMT)
Received: from sig-9-145-45-184.uk.ibm.com (unknown [9.145.45.184])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Oct 2021 11:02:59 +0000 (GMT)
Message-ID: <fd749b049550e179d0d0b789d08a102655b1a68e.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Use cpu_number only on
 arches that have it
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Tue, 12 Oct 2021 13:02:59 +0200
In-Reply-To: <CAEf4BzY=npfWOSgPPEKZ9g44a5XQ_606agX840dLLCqJiDC++g@mail.gmail.com>
References: <20211012023218.399568-1-iii@linux.ibm.com>
         <20211012023218.399568-2-iii@linux.ibm.com>
         <CAEf4BzY=npfWOSgPPEKZ9g44a5XQ_606agX840dLLCqJiDC++g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W-CR5ggI-HLtqS1y0zkkFUIODPUDecPn
X-Proofpoint-GUID: 4qDJvLs4ZiCM7SncxQTJ0-U4isRgf-tH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_02,2021-10-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120065
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2021-10-12 at 05:56 +0200, Andrii Nakryiko wrote:
> On Tue, Oct 12, 2021 at 4:51 AM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > 
> > cpu_number exists only on Intel and aarch64, so skip the test
> > involing
> > it on other arches. An alternative would be to replace it with an
> > exported non-ifdefed primitive-typed percpu variable from the
> > common
> > code, but there appears to be none.
> > 
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/btf_dump.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> > b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> > index 87f9df653e4e..12f457b6786d 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> > @@ -778,8 +778,10 @@ static void test_btf_dump_struct_data(struct
> > btf *btf, struct btf_dump *d,
> >  static void test_btf_dump_var_data(struct btf *btf, struct
> > btf_dump *d,
> >                                    char *str)
> >  {
> > +#if defined(__i386__) || defined(__x86_64__) ||
> > defined(__aarch64__)
> >         TEST_BTF_DUMP_VAR(btf, d, NULL, str, "cpu_number", int,
> > BTF_F_COMPACT,
> >                           "int cpu_number = (int)100", 100);
> > +#endif
> 
> We are in the talks about supporting cross-compilation of selftests,
> and this will be just another breakage that we'll have to undo.

Why would this break? Cross-compilation should define these macros
based on target, not build system.

> Can we find some other variable that will be available on all
> architectures? Maybe "runqueues"?

Wouldn't runqueues be pointless? We already have cpu_profile_flip. I
thought the idea here was to have something marked with
EXPORT_PER_CPU_SYMBOL.

> >         TEST_BTF_DUMP_VAR(btf, d, NULL, str, "cpu_profile_flip",
> > int, BTF_F_COMPACT,
> >                           "static int cpu_profile_flip = (int)2",
> > 2);
> >  }
> > --
> > 2.31.1

