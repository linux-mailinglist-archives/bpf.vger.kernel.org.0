Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAB24AE569
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 00:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbiBHX1C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 18:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiBHX1A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 18:27:00 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829DDC061576
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 15:26:59 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218LAJxB010856;
        Tue, 8 Feb 2022 23:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=4N7PXe++9OQZaloz9PQammt7hRj3Dc5Q7D6IG8NEJ1Y=;
 b=UGrhjw0MRGRovb2yKnJr/DbVwZrNPGOfCOWK2s7JjHe3zp9jvHE5HFdl3MJvNJLBAyIQ
 jN52dQJG/PEEIfAAmiYlElMm0V+NROAFb8GG0/nxEbKZCI/nLvIZ3lMLkYuZjqRgbp65
 1eppc6lV6UoQ/RUlr98F3Zr0QJp8mZ79tZpzMCppYQv/ICLGRbb3tSuT9gGCBQ+BCytZ
 fcB9Bfu2OjKlnQg+2buJliAuInr9SspFXkeo8ZDKCxlgtSI0K2oz0TOEJZOFwyniXQYu
 v0JDQ8/acED2Wyad62uhJLQTkEWyH4bjfgnYFLiXcLMmXELGwzHNipY9/k/lLr+JZ888 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e406ptp29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 23:26:40 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 218NCd9p000395;
        Tue, 8 Feb 2022 23:26:40 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e406ptp1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 23:26:39 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 218N99SI020730;
        Tue, 8 Feb 2022 23:26:37 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3e1gv99xk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 23:26:37 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 218NQY4346465378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 23:26:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A0D242054;
        Tue,  8 Feb 2022 23:26:34 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC80E42045;
        Tue,  8 Feb 2022 23:26:33 +0000 (GMT)
Received: from [9.171.78.41] (unknown [9.171.78.41])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Feb 2022 23:26:33 +0000 (GMT)
Message-ID: <aac0bbcaa484df34484eb928af208743167d50dc.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v4 06/14] libbpf: Add PT_REGS_SYSCALL_REGS macro
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
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, bpf <bpf@vger.kernel.org>
Date:   Wed, 09 Feb 2022 00:26:33 +0100
In-Reply-To: <CAEf4BzagHVnAEz+22eFU=EeFuwvBGyGUbfT8XCmv4zF97KdUBA@mail.gmail.com>
References: <20220208051635.2160304-1-iii@linux.ibm.com>
         <20220208051635.2160304-7-iii@linux.ibm.com>
         <CAEf4BzagHVnAEz+22eFU=EeFuwvBGyGUbfT8XCmv4zF97KdUBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: A7leChberKuva_4nOs04EaXFjSnrg1iQ
X-Proofpoint-GUID: YU3tNy80xyjUzFnZx_R8Pw_eMU4rH9mV
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_07,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080134
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-02-08 at 14:08 -0800, Andrii Nakryiko wrote:
> On Mon, Feb 7, 2022 at 9:16 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > 
> > Depending on whether or not an arch has ARCH_HAS_SYSCALL_WRAPPER,
> > syscall arguments must be accessed through a different set of
> > registers. Provide PT_REGS_SYSCALL_REGS macro to abstract away
> > that difference.
> > 
> > Reported-by: Heiko Carstens <hca@linux.ibm.com>
> > Co-developed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> 
> Again, there was nothing wrong with the way you did it in v3, please
> revert to that one.

I've realized that, even though fully correct, v3 looked somewhat
ad-hoc: it defined PT_REGS_SYSCALL_REGS for different architectures
without explaining why this particular arch has this parciular way to
access syscall arguments.

So I've decided to switch to the existing terminology, as Naveen
proposed [1]:

- arches that select ARCH_HAS_SYSCALL_WRAPPER in Kconfig get a
  __BPF_ARCH_HAS_SYSCALL_WRAPPER in bpf_tracing.h

- syscall handler calling convention is (at least partially) determined
  by whether or not an arch has a sycall wrapper as described in
  ARCH_HAS_SYSCALL_WRAPPER help text

I can, of course, switch back to v3 - both patches look functionally
identical - but this one seems to be a bit easier to understand.

[1]
https://lore.kernel.org/bpf/1643991537.bfyv1b2oym.naveen@linux.ibm.com/#t

> 
> >  tools/lib/bpf/bpf_tracing.h | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/tools/lib/bpf/bpf_tracing.h
> > b/tools/lib/bpf/bpf_tracing.h
> > index 82f1e935d549..7a015ee8fb11 100644
> > --- a/tools/lib/bpf/bpf_tracing.h
> > +++ b/tools/lib/bpf/bpf_tracing.h
> > @@ -64,6 +64,8 @@
> > 
> >  #if defined(bpf_target_x86)
> > 
> > +#define __BPF_ARCH_HAS_SYSCALL_WRAPPER
> > +
> >  #if defined(__KERNEL__) || defined(__VMLINUX_H__)
> > 
> >  #define __PT_PARM1_REG di
> > @@ -114,6 +116,8 @@
> > 
> >  #elif defined(bpf_target_s390)
> > 
> > +#define __BPF_ARCH_HAS_SYSCALL_WRAPPER
> > +
> >  /* s390 provides user_pt_regs instead of struct pt_regs to
> > userspace */
> >  #define __PT_REGS_CAST(x) ((const user_pt_regs *)(x))
> >  #define __PT_PARM1_REG gprs[2]
> > @@ -142,6 +146,8 @@
> > 
> >  #elif defined(bpf_target_arm64)
> > 
> > +#define __BPF_ARCH_HAS_SYSCALL_WRAPPER
> > +
> >  /* arm64 provides struct user_pt_regs instead of struct pt_regs to
> > userspace */
> >  #define __PT_REGS_CAST(x) ((const struct user_pt_regs *)(x))
> >  #define __PT_PARM1_REG regs[0]
> > @@ -344,6 +350,17 @@ struct pt_regs;
> > 
> >  #endif /* defined(bpf_target_defined) */
> > 
> > +/*
> > + * When invoked from a syscall handler BPF_KPROBE, returns a
> > pointer to a
> > + * struct pt_regs containing syscall arguments, that is suitable
> > for passing to
> > + * PT_REGS_PARMn_SYSCALL() and PT_REGS_PARMn_CORE_SYSCALL().
> > + */
> > +#ifdef __BPF_ARCH_HAS_SYSCALL_WRAPPER
> > +#define PT_REGS_SYSCALL_REGS(ctx) ((struct pt_regs
> > *)PT_REGS_PARM1(ctx))
> > +#else
> > +#define PT_REGS_SYSCALL_REGS(ctx) ctx
> > +#endif
> > +
> >  #ifndef ___bpf_concat
> >  #define ___bpf_concat(a, b) a ## b
> >  #endif
> > --
> > 2.34.1
> > 

