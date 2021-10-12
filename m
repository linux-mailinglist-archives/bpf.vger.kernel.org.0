Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6109242A392
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 13:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbhJLLrd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 07:47:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236197AbhJLLrb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 Oct 2021 07:47:31 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19CBgiwe008605;
        Tue, 12 Oct 2021 07:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=aGYgnzSE6P01nv4la9fUPD0NNRPanrgWZzyFFv4b7aI=;
 b=WM5qkAt4SpFtsO1cdmMqSxp1Q5z5dent8qCD8l9C3YruWM31eRLgcbOnj4EjtNAdlMEs
 BOIPgPhpZLM9mZ9ivu/Ntpf7A+ltyMg9ArKCCJzMoXc7m2aiZ2yVnuqLMjkWuIgUbCOm
 TqRAtwHaz1uthqBg90t/3/0wwqPHnZbNsoh9tmMYLRFuSmEb/6XKGWUF+Tw5AYYuWp9w
 zZfx5A+zaBBX6+JDX00j9E7y2M/FZu7IaKBhVS6qTWWO1JFsagj2xXMawSGm7OtKtehQ
 eXg1sd3QSoTAjC/HrlbiABfXZC8YBoQGo9UygbPlTwXsS2M3nSP8bBZrnNJ728WBWmqp Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bn9qhr1xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 07:45:15 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19CBiB3U016117;
        Tue, 12 Oct 2021 07:45:15 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bn9qhr1x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 07:45:15 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19CBinaw006327;
        Tue, 12 Oct 2021 11:45:13 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3bk2q9fy8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 11:45:11 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19CBiTOI53674320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 11:44:29 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 453595204E;
        Tue, 12 Oct 2021 11:44:29 +0000 (GMT)
Received: from sig-9-145-45-184.uk.ibm.com (unknown [9.145.45.184])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E6D625206D;
        Tue, 12 Oct 2021 11:44:28 +0000 (GMT)
Message-ID: <53411d4555b81f26782c47087c8da8da4cd4e164.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 3/3] libbpf: Fix dumping __int128
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Tue, 12 Oct 2021 13:44:28 +0200
In-Reply-To: <CAEf4BzYzgSZELHujELqggGPyDFPCN4nM6OwGLzyy8O5mJAcXJw@mail.gmail.com>
References: <20211012023218.399568-1-iii@linux.ibm.com>
         <20211012023218.399568-4-iii@linux.ibm.com>
         <CAEf4BzYzgSZELHujELqggGPyDFPCN4nM6OwGLzyy8O5mJAcXJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vTJte3QGMe1j-HC6_g7zhE7V-o2e0src
X-Proofpoint-ORIG-GUID: 6_1v-zID5CzHDZhW13CtUy4y8O8qf5M9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_03,2021-10-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120067
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2021-10-12 at 05:52 +0200, Andrii Nakryiko wrote:
> On Tue, Oct 12, 2021 at 4:32 AM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > 
> > On s390 __int128 can be 8-byte aligned, therefore in libbpf will
> > occasionally consider variables of this type non-aligned and try to
> > dump them as a bitfield, which is supported for at most 64-bit
> > integers.
> > 
> > Fix by using the same trick as btf_dump_float_data(): copy non-
> > aligned
> > values to the local buffer.
> > 
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >  tools/lib/bpf/btf_dump.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> > index ab45771d0cb4..d8264c1762e8 100644
> > --- a/tools/lib/bpf/btf_dump.c
> > +++ b/tools/lib/bpf/btf_dump.c
> > @@ -1672,9 +1672,10 @@ static int btf_dump_int_data(struct btf_dump
> > *d,
> >  {
> >         __u8 encoding = btf_int_encoding(t);
> >         bool sign = encoding & BTF_INT_SIGNED;
> > +       char buf[16] __aligned(16);
> >         int sz = t->size;
> > 
> > -       if (sz == 0) {
> > +       if (sz == 0 || sz > sizeof(buf)) {
> >                 pr_warn("unexpected size %d for id [%u]\n", sz,
> > type_id);
> >                 return -EINVAL;
> >         }
> > @@ -1682,8 +1683,10 @@ static int btf_dump_int_data(struct btf_dump
> > *d,
> >         /* handle packed int data - accesses of integers not
> > aligned on
> >          * int boundaries can cause problems on some platforms.
> >          */
> > -       if (!ptr_is_aligned(data, sz))
> > -               return btf_dump_bitfield_data(d, t, data, 0, 0);
> > +       if (!ptr_is_aligned(data, sz)) {
> 
> I think ptr_is_aligned() logic is wrong. We should probably not
> assume
> that __int128 has 16-byte alignment. Can you try fixing it by using
> btf__align_of() API to get the natural alignment?

Ok, but this patch makes sense anyway, doesn't it? I can fix
ptr_is_aligned() separately.

> 
> > +               memcpy(buf, data, sz);
> > +               data = buf;
> > +       }
> > 
> >         switch (sz) {
> >         case 16: {
> > --
> > 2.31.1
> > 


