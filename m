Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3DF4A977B
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 11:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346769AbiBDKKB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 05:10:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234330AbiBDKKA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 05:10:00 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2148S7En015930;
        Fri, 4 Feb 2022 10:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=4qjsnKHDTfDxLQPblf6DA6XeYysns+OtTR31Bpr1zeQ=;
 b=Gu2XmgecpmhYboty58xCcTywxa+u0U3ez5LMPb4IbUnLK3Q8C9nPI8p3tsJSvF0pSk1Q
 uL/bzgWfDW416PhiGOjHash3KUfko3ymtIMpQqKr80ucXmaLJZ//ZylJoc2rVSft6Eaj
 RE7rFPPay6ZdZN7Yepv2yDZIFKcq6FLULkTngxcPrCM7S7JRe7hhxr5Mb8Q3msKqkeui
 vYjJ4OJhIeBOy8w4pwQSLoVeah9Xn2noUq1Z1cKSwlvsr9auwiAeZtpfE4xjPI4lnrx/
 o6JIyEHgtlB8crU2ZeoFA3aE11TLF0Pb0PRjINjYgrSUrZJwnp3eTSII9CJTHMRxSGCc 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e0rt594au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 10:09:41 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2149hNOe031389;
        Fri, 4 Feb 2022 10:09:40 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e0rt594ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 10:09:40 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 214A5LF7005999;
        Fri, 4 Feb 2022 10:09:38 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3e0r0u3ga8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 10:09:38 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2149xeIX17039776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 09:59:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 860F94C044;
        Fri,  4 Feb 2022 10:09:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 172D14C040;
        Fri,  4 Feb 2022 10:09:35 +0000 (GMT)
Received: from osiris (unknown [9.145.2.67])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  4 Feb 2022 10:09:35 +0000 (GMT)
Date:   Fri, 4 Feb 2022 11:09:33 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 02/10] s390/bpf: Add orig_gpr2 to user_pt_regs
Message-ID: <Yfz7XZi65R+hdDwW@osiris>
References: <20220204041955.1958263-1-iii@linux.ibm.com>
 <20220204041955.1958263-3-iii@linux.ibm.com>
 <CAEf4BzYPdqLE152BZo2twbd9FkpG2vahOFqNM6eYXzdWzDUPLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYPdqLE152BZo2twbd9FkpG2vahOFqNM6eYXzdWzDUPLQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: V9uVHrLtoK5ftWPP6Khv79XjuXykcoGU
X-Proofpoint-ORIG-GUID: TXDAmugWsqUDrqWsI5OZ5BuAN0V7IqOE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_03,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040054
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 03, 2022 at 09:19:42PM -0800, Andrii Nakryiko wrote:
> On Thu, Feb 3, 2022 at 8:20 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >
> > user_pt_regs is used by eBPF in order to access userspace registers -
> > see commit 466698e654e8 ("s390/bpf: correct broken uapi for
> > BPF_PROG_TYPE_PERF_EVENT program type"). In order to access the first
> > syscall argument from eBPF programs, we need to export orig_gpr2.
> >
> > args member is not in use since commit 56e62a737028 ("s390: convert to
> > generic entry"), so move orig_gpr2 in its place.
> >
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >  arch/s390/include/asm/ptrace.h      | 3 +--
> >  arch/s390/include/uapi/asm/ptrace.h | 2 +-
> >  2 files changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
> > index 4ffa8e7f0ed3..0278bacd61be 100644
> > --- a/arch/s390/include/asm/ptrace.h
> > +++ b/arch/s390/include/asm/ptrace.h
> > @@ -80,12 +80,11 @@ struct pt_regs {
> >         union {
> >                 user_pt_regs user_regs;
> >                 struct {
> > -                       unsigned long args[1];
> > +                       unsigned long orig_gpr2;
> >                         psw_t psw;
> >                         unsigned long gprs[NUM_GPRS];
> >                 };
> >         };
> > -       unsigned long orig_gpr2;
> 
> Please don't change the physical location of this field, it
> effectively breaks libbpf's syscall tracing macro on all older
> kernels. Let's do what you did in the previous revision and just
> expose the field at its correct offset. That way with up to date UAPI
> header or vmlinux.h all this will work even on old kernels (even
> without CO-RE).

That's (unfortunately) a valid argument. So looks like we can't get rid of
the args member now. Maybe we can put something else there or simply rename
it to "dontuse".
Anyway, that's not within the scope of this patch series.
