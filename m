Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6166D4A9952
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 13:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbiBDMa1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 07:30:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14258 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233152AbiBDMa0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 07:30:26 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214956Ze024424;
        Fri, 4 Feb 2022 12:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=TvwjME31FHZkA3m2Afs7JYdSlWGctnRfidrNFCnpk2w=;
 b=KXDMMIX2JeFuoaJ2ZtwxN3JFE59VMtc6cO9BfQ9Y+/Hj/0A6Z4q9gwfaYZCYXwM4JtQs
 N0KbltYneMWm5sFotOWz5TcNoWG8xnIflaKQ79URlpicTgZVFDMnAomeImCpF3JHc/wh
 2g7mU/BjNJhnQEg0+N2vnZvrgCWNO4kjGSPDgluGNMowpc/j8jD9PakgREp9hMWAZ+VP
 9DaBxFcCcrwhQ10ClqMH1XR5n3NWzoDIY3zaXmc3PenZbQzgW9tcEHwJv9uArDJpno1E
 TU37WPyX1NM0CFiJ/YN2GcC1/beew+umx0DUGMuiJpJlJmzi5f7GDTG1LT4hDTdpzDbx GA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0x2vxm9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 12:30:07 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 214C9O9F008463;
        Fri, 4 Feb 2022 12:30:06 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0x2vxm81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 12:30:06 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 214CDQEM030569;
        Fri, 4 Feb 2022 12:30:04 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3e0r0x4avp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 12:30:04 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 214CTwFf44040502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 12:29:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85D9711C054;
        Fri,  4 Feb 2022 12:29:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E909711C064;
        Fri,  4 Feb 2022 12:29:57 +0000 (GMT)
Received: from [9.171.78.41] (unknown [9.171.78.41])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Feb 2022 12:29:57 +0000 (GMT)
Message-ID: <6f30bdf7afe29f379b058300fef9398004b3be35.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v2 05/10] libbpf: Add PT_REGS_SYSCALL macro
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        bpf <bpf@vger.kernel.org>
Date:   Fri, 04 Feb 2022 13:29:57 +0100
In-Reply-To: <CAEf4Bza3CyG-1O20YbPNpNa25xP7MhcO3d0RwFpbENLmBXzBfQ@mail.gmail.com>
References: <20220204041955.1958263-1-iii@linux.ibm.com>
         <20220204041955.1958263-6-iii@linux.ibm.com>
         <CAEf4Bzbz-MP9QX-SaZ4+we1UnWvgiym_+aR580WdpewzmRKKNA@mail.gmail.com>
         <CAEf4Bza3CyG-1O20YbPNpNa25xP7MhcO3d0RwFpbENLmBXzBfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FCUZgkS7_BzQIPm-sqMdHKlb96zdA7wu
X-Proofpoint-ORIG-GUID: G4SHgObnHuva4f-k0g-ZmkakT-H-kf0t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_04,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxlogscore=997
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040067
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2022-02-03 at 21:23 -0800, Andrii Nakryiko wrote:
> On Thu, Feb 3, 2022 at 9:22 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > 
> > On Thu, Feb 3, 2022 at 8:20 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > > 
> > > Some architectures pass a pointer to struct pt_regs to syscall
> > > handlers, others unpack it into individual function parameters.
> > > Introduce a macro to describe what a particular arch does, using
> > > `passing pt_regs *` as a default.
> > > 
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> > >  tools/lib/bpf/bpf_tracing.h | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/tools/lib/bpf/bpf_tracing.h
> > > b/tools/lib/bpf/bpf_tracing.h
> > > index 30f0964f8c9e..400a4f002f77 100644
> > > --- a/tools/lib/bpf/bpf_tracing.h
> > > +++ b/tools/lib/bpf/bpf_tracing.h
> > > @@ -334,6 +334,15 @@ struct pt_regs;
> > > 
> > >  #endif /* defined(bpf_target_defined) */
> > > 
> > > +/*
> > > + * When invoked from a syscall handler kprobe, returns a pointer
> > > to a
> > > + * struct pt_regs containing syscall arguments and suitable for
> > > passing to
> > > + * PT_REGS_PARMn_SYSCALL() and PT_REGS_PARMn_CORE_SYSCALL().
> > > + */
> > > +#ifndef PT_REGS_SYSCALL
> > > +#define PT_REGS_SYSCALL(ctx) ((struct pt_regs
> > > *)PT_REGS_PARM1(ctx))
> > > +#endif
> > 
> > maybe PT_REGS_SYSCALL_REGS? It returns regs, not the "syscall".
> > PT_REGS prefix is for consistency with all other pt_regs macros,
> > but
> > "SYSCALL_REGS" is specifying what is actually returned by the macro
> > 
> 
> Oh, and instead of casting to `struct pt_regs *` directly, maybe use
> __PT_REGS_CAST() instead? For some architectures it probably should
> stay user_pt_regs (or whatever it is there).
> 
> > > +
> > >  #ifndef ___bpf_concat
> > >  #define ___bpf_concat(a, b) a ## b
> > >  #endif
> > > --
> > > 2.34.1
> > > 

I think it's better to keep this as struct pt_regs *, so that in
bpf progs we can do

	struct pt_regs *real_regs = PT_REGS_SYSCALL(ctx);

without having to worry about which arch we are on, or using the
opaque void *.
