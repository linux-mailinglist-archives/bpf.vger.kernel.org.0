Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976E33231F4
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 21:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhBWUSH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 15:18:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233512AbhBWURG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Feb 2021 15:17:06 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11NK5MwJ079730;
        Tue, 23 Feb 2021 15:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=St6pjtBfL2ljwbY2qWVYVrreO9dN35gf6VqLe3vHkNo=;
 b=KnD5gzGn2p8JGknSjZHeWjjs63ofCilaHrZHU1E972zpFOD5NVy75GYi3i/gjUrrXvmf
 4/+EyZpH2hnxtd8utt3ibuLe+2LATvI/5MbgOJ/eTEk4VjAZiB/XnvllzbH8B53LlEqh
 9yOsA8vAXGyKJUVbbmwxvsjit2qrN2+yOBKkblowNa0XtQaZCKMieu7x7oKmGDGld450
 HDLybU9MgKX+m03qdaJgtqmLPmPitJn9wCS9iy9w6EAWjvuCm2j1rBG1F8Hj4Kpu5oW8
 vQ9s4qvPr6PBh1Y9MuajjwGMHWuCHVED2c0gfSrrIAh4tiPiokQZk+nUIWJkdaUkxl8q eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkfm0w92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 15:16:13 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11NK5QZT080214;
        Tue, 23 Feb 2021 15:16:12 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkfm0w7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 15:16:12 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11NKGATf030235;
        Tue, 23 Feb 2021 20:16:10 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 36tt289heq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 20:16:10 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11NKG7jE29098298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 20:16:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FF5BA4059;
        Tue, 23 Feb 2021 20:16:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20200A404D;
        Tue, 23 Feb 2021 20:16:07 +0000 (GMT)
Received: from sig-9-145-151-190.de.ibm.com (unknown [9.145.151.190])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Feb 2021 20:16:07 +0000 (GMT)
Message-ID: <df9bb41ed2065ff3b44bc85c4eb2e23d8e24fc88.camel@linux.ibm.com>
Subject: Re: [PATCH v4 bpf-next 6/7] selftest/bpf: Add BTF_KIND_FLOAT tests
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Tue, 23 Feb 2021 21:16:06 +0100
In-Reply-To: <CAEf4BzY+f77raXGrJN3Nz2To2EC0Td9zwaO2bYKS+W-ZftY9-Q@mail.gmail.com>
References: <20210222214917.83629-1-iii@linux.ibm.com>
         <20210222214917.83629-7-iii@linux.ibm.com>
         <CAEf4BzY+f77raXGrJN3Nz2To2EC0Td9zwaO2bYKS+W-ZftY9-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_08:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102230169
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2021-02-22 at 23:11 -0800, Andrii Nakryiko wrote:
> On Mon, Feb 22, 2021 at 1:52 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > 
> > Test the good variants as well as the potential malformed ones.
> > 
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > Acked-by: Yonghong Song <yhs@fb.com>
> > ---
> 
> Would be nice to have BTF dumping and dedup tests added/adjusted as
> well.
> 
> >  tools/testing/selftests/bpf/btf_helpers.c    |   4 +
> >  tools/testing/selftests/bpf/prog_tests/btf.c | 129
> > +++++++++++++++++++
> >  tools/testing/selftests/bpf/test_btf.h       |   3 +
> >  3 files changed, 136 insertions(+)
> > 
> 
> [...]

I will add a dedup in the next series, but dumping test requires LLVM
support, so it will have to come later separately. Still, in my local
setup the following works:

--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
@@ -205,6 +205,12 @@ struct struct_with_embedded_stuff {
        int t[11];
 };
 
+struct float_struct {
+       float *f;
+       const double *d;
+       volatile long double *ld;
+};
+
 struct root_struct {
        enum e1 _1;
        enum e2 _2;
@@ -219,6 +225,7 @@ struct root_struct {
        union_fwd_t *_12;
        union_fwd_ptr_t _13;
        struct struct_with_embedded_stuff _14;
+       struct float_struct _15;
 };
 
 /* ------ END-EXPECTED-OUTPUT ------ */


