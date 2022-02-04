Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1EE4A992F
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 13:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242729AbiBDMVV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 07:21:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44596 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237442AbiBDMVU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 07:21:20 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214C2k0s010672;
        Fri, 4 Feb 2022 12:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=p6xh0B50MyKktXD9mqzDssA1flJde3H7ifL0xvIukTI=;
 b=I9dcoz94DpoBTP1bOC5txGEqpSTosVe2l70pVVBHI3tTxbyxkY/zF6H+6Eqt3PN1q8Dy
 nWYCEf+2P5v1tZiHWHyA08K4buQ+6fVJ2Fh4Q+uJOmyNFrpSm7Py5ZwUS9Hfu27pl0wk
 dS+z2fR9FJgIcGv8P6GnhZ9bDVGxT/baG/xiciniwsqZFwDaugV2Za6D/puOHIX3aLxf
 LYGaVfDl8gm8pmWpqz+ln1UDmLTqXKladK++VujFnRJm6hg6kMrwACCARiWq99maRBaR
 z5284oJObelNsS3GNOtmRTZdoUUZ6kPtJ7Yk9zH2VnwYamET6VAH5nmQ/rdMFcZL1Nft ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e109evbmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 12:21:01 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 214C5pId007060;
        Fri, 4 Feb 2022 12:21:00 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e109evbmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 12:21:00 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 214CDMC1018121;
        Fri, 4 Feb 2022 12:20:59 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3e0r0u4fxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 12:20:59 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 214CKt6E47317424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 12:20:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 948B1A4053;
        Fri,  4 Feb 2022 12:20:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDDD9A4040;
        Fri,  4 Feb 2022 12:20:54 +0000 (GMT)
Received: from [9.171.78.41] (unknown [9.171.78.41])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Feb 2022 12:20:54 +0000 (GMT)
Message-ID: <80a92fcc73e537b56491f8313574bea6dfa1c1c8.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 1/3] s390/bpf: Add orig_gpr2 to user_pt_regs
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        bpf@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Date:   Fri, 04 Feb 2022 13:20:54 +0100
In-Reply-To: <1643962017.hhlhw119x7.naveen@linux.ibm.com>
References: <20220201234200.1836443-1-iii@linux.ibm.com>
         <20220201234200.1836443-2-iii@linux.ibm.com> <YfrmO+pcSqrrbC3E@osiris>
         <1643952491.peuih6eln6.naveen@linux.ibm.com>
         <1643962017.hhlhw119x7.naveen@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gp5d65zmly870au4PPLZoUcU2YOPdAIv
X-Proofpoint-ORIG-GUID: 9RE9Ze-a9B3DQCsmYNNC6_ng5tGI4W04
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_04,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=972 clxscore=1011
 phishscore=0 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040067
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2022-02-04 at 08:21 +0000, Naveen N. Rao wrote:
> Naveen N. Rao wrote:
> > Hi Heiko,
> > 
> > Heiko Carstens wrote:
> > > On Wed, Feb 02, 2022 at 12:41:58AM +0100, Ilya Leoshkevich wrote:
> > > > user_pt_regs is used by eBPF in order to access userspace
> > > > registers -
> > > > see commit 466698e654e8 ("s390/bpf: correct broken uapi for
> > > > BPF_PROG_TYPE_PERF_EVENT program type"). In order to access the
> > > > first
> > > > syscall argument from eBPF programs, we need to export
> > > > orig_gpr2.
> > > > 
> > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > ---
> > > >  arch/s390/include/asm/ptrace.h      | 2 +-
> > > >  arch/s390/include/uapi/asm/ptrace.h | 1 +
> > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/s390/include/asm/ptrace.h
> > > > b/arch/s390/include/asm/ptrace.h
> > > > index 4ffa8e7f0ed3..c8698e643904 100644
> > > > --- a/arch/s390/include/asm/ptrace.h
> > > > +++ b/arch/s390/include/asm/ptrace.h
> > > > @@ -83,9 +83,9 @@ struct pt_regs {
> > > >                         unsigned long args[1];
> > > >                         psw_t psw;
> > > >                         unsigned long gprs[NUM_GPRS];
> > > > +                       unsigned long orig_gpr2;
> > > >                 };
> > > >         };
> > > > -       unsigned long orig_gpr2;
> > > >         union {
> > > >                 struct {
> > > >                         unsigned int int_code;
> > > > diff --git a/arch/s390/include/uapi/asm/ptrace.h
> > > > b/arch/s390/include/uapi/asm/ptrace.h
> > > > index ad64d673b5e6..b3dec603f507 100644
> > > > --- a/arch/s390/include/uapi/asm/ptrace.h
> > > > +++ b/arch/s390/include/uapi/asm/ptrace.h
> > > > @@ -295,6 +295,7 @@ typedef struct {
> > > >         unsigned long args[1];
> > > >         psw_t psw;
> > > >         unsigned long gprs[NUM_GPRS];
> > > > +       unsigned long orig_gpr2;
> > > >  } user_pt_regs;
> > > 
> > > Isn't this broken on nearly all architectures? I just checked
> > > powerpc,
> > > arm64, and riscv. While powerpc seems to mirror pt_regs as
> > > user_pt_regs,
> > > and therefore exports orig_gpr3, the bpf macros still seem to
> > > access the
> > > wrong location to access the first syscall parameter(?).
> > 
> > On powerpc, gpr[3] continues to be valid on syscall entry (so this
> > test 
> > passes on powerpc), though orig_gpr3 will remain valid throughout.
> 
> Hmm.. we can't use orig_gpr3 since we don't use a syscall wrapper.
> All 
> system calls just receive the parameters directly.
> 
> - Naveen

Right, I ran into this yesterday as well.
I solved it in v2
(https://lore.kernel.org/bpf/20220204041955.1958263-1-iii@linux.ibm.com/)
by introducing a macro that hides whether or not an arch uses a syscall
wrapper.
