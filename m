Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1920F4AE53D
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 00:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbiBHXJZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 18:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbiBHXJZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 18:09:25 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C68C06157B
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 15:09:24 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218LeALX037810;
        Tue, 8 Feb 2022 23:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=DI42c1h9KN61gAliPydPF/hI5xa7q+kvieSskuITPTg=;
 b=drA1GoTM9yiIaBMfzydz6GqXBAtUK5b0/46xOtM0XBOFUbaE75o1eSCOgaA+Xd9jgF6j
 P1Vea4k0TiRklW3w/UH6uE9IjOs9wpc9bSqymCFI1sB1j802spgjmIXnFmfOU37Songg
 sjfwySho9S9vS20akZLC/jI0qPdSSorNPo63oRc1khwr1cfOK/TdG6EDq1nOOm9UqN7p
 glPE8T7XsUDQkLCCGkBxtI0sIrsvsY1mOLluSgEGp8fCDIbZPDMQKrxf1596WGT3XeV+
 8/CX8cSGkPCCCw4xi+L7ljbZSbVYmg9bhbbcCB36FZeV1RHZOwj0sLaP1F0/omQ9pHJv xA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e3wmjwuy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 23:09:04 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 218N3kYp016212;
        Tue, 8 Feb 2022 23:09:03 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e3wmjwuxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 23:09:03 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 218N91DW020709;
        Tue, 8 Feb 2022 23:09:01 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3e1gv99vuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 23:09:01 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 218N8tDs42074582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 23:08:55 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EBDE11C064;
        Tue,  8 Feb 2022 23:08:55 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1079411C069;
        Tue,  8 Feb 2022 23:08:55 +0000 (GMT)
Received: from [9.171.78.41] (unknown [9.171.78.41])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Feb 2022 23:08:54 +0000 (GMT)
Message-ID: <566fdad05cb0176b7dfcffb6d99c59567db91c8e.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v4 05/14] libbpf: Generalize overriding syscall
 parameter access macros
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
Date:   Wed, 09 Feb 2022 00:08:54 +0100
In-Reply-To: <CAEf4BzZCYa-wz5B7pwvo6R84vs70YFxJddSvA_FwCGDnUrHXFg@mail.gmail.com>
References: <20220208051635.2160304-1-iii@linux.ibm.com>
         <20220208051635.2160304-6-iii@linux.ibm.com>
         <CAEf4BzZCYa-wz5B7pwvo6R84vs70YFxJddSvA_FwCGDnUrHXFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xwjvqg-fK6-JN08W7BDWx86cginIWjVF
X-Proofpoint-ORIG-GUID: kWY-b5qJAHf2O4GYBaj8vlzbfQShlsMH
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_07,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

On Tue, 2022-02-08 at 14:05 -0800, Andrii Nakryiko wrote:
> On Mon, Feb 7, 2022 at 9:16 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > 
> > Instead of conditionally overriding PT_REGS_PARM4_SYSCALL, provide
> > default fallbacks for all __PT_PARMn_REG_SYSCALL macros, so that
> > architectures can simply override a specific syscall parameter
> > macro.
> > Also allow completely overriding PT_REGS_PARM1_SYSCALL for
> > non-trivial access sequences.
> > 
> > Co-developed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >  tools/lib/bpf/bpf_tracing.h | 48 +++++++++++++++++++++++++--------
> > ----
> >  1 file changed, 33 insertions(+), 15 deletions(-)
> > 
> > diff --git a/tools/lib/bpf/bpf_tracing.h
> > b/tools/lib/bpf/bpf_tracing.h
> > index da7e8d5c939c..82f1e935d549 100644
> > --- a/tools/lib/bpf/bpf_tracing.h
> > +++ b/tools/lib/bpf/bpf_tracing.h
> > @@ -265,25 +265,43 @@ struct pt_regs;
> > 
> >  #endif
> > 
> > -#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
> > -#define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
> > -#define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
> > -#ifdef __PT_PARM4_REG_SYSCALL
> > +#ifndef __PT_PARM1_REG_SYSCALL
> > +#define __PT_PARM1_REG_SYSCALL __PT_PARM1_REG
> > +#endif
> > +#ifndef __PT_PARM2_REG_SYSCALL
> > +#define __PT_PARM2_REG_SYSCALL __PT_PARM2_REG
> > +#endif
> > +#ifndef __PT_PARM3_REG_SYSCALL
> > +#define __PT_PARM3_REG_SYSCALL __PT_PARM3_REG
> > +#endif
> > +#ifndef __PT_PARM4_REG_SYSCALL
> > +#define __PT_PARM4_REG_SYSCALL __PT_PARM4_REG
> > +#endif
> > +#ifndef __PT_PARM5_REG_SYSCALL
> > +#define __PT_PARM5_REG_SYSCALL __PT_PARM5_REG
> > +#endif
> > +
> > +#ifndef PT_REGS_PARM1_SYSCALL
> > +#define PT_REGS_PARM1_SYSCALL(x) (__PT_REGS_CAST(x)-
> > >__PT_PARM1_REG_SYSCALL)
> > +#endif
> > +#ifndef PT_REGS_PARM2_SYSCALL
> > +#define PT_REGS_PARM2_SYSCALL(x) (__PT_REGS_CAST(x)-
> > >__PT_PARM2_REG_SYSCALL)
> > +#endif
> > +#ifndef PT_REGS_PARM3_SYSCALL
> > +#define PT_REGS_PARM3_SYSCALL(x) (__PT_REGS_CAST(x)-
> > >__PT_PARM3_REG_SYSCALL)
> > +#endif
> > +#ifndef PT_REGS_PARM4_SYSCALL
> >  #define PT_REGS_PARM4_SYSCALL(x) (__PT_REGS_CAST(x)-
> > >__PT_PARM4_REG_SYSCALL)
> > -#else /* __PT_PARM4_REG_SYSCALL */
> > -#define PT_REGS_PARM4_SYSCALL(x) PT_REGS_PARM4(x)
> >  #endif
> > -#define PT_REGS_PARM5_SYSCALL(x) PT_REGS_PARM5(x)
> > +#ifndef PT_REGS_PARM5_SYSCALL
> > +#define PT_REGS_PARM5_SYSCALL(x) (__PT_REGS_CAST(x)-
> > >__PT_PARM5_REG_SYSCALL)
> > +#endif
> > 
> > -#define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
> > -#define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
> > -#define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
> > -#ifdef __PT_PARM4_REG_SYSCALL
> > +#define PT_REGS_PARM1_CORE_SYSCALL(x)
> > BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM1_REG_SYSCALL)
> > +#define PT_REGS_PARM2_CORE_SYSCALL(x)
> > BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM2_REG_SYSCALL)
> > +#define PT_REGS_PARM3_CORE_SYSCALL(x)
> > BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM3_REG_SYSCALL)
> >  #define PT_REGS_PARM4_CORE_SYSCALL(x)
> > BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM4_REG_SYSCALL)
> > -#else /* __PT_PARM4_REG_SYSCALL */
> > -#define PT_REGS_PARM4_CORE_SYSCALL(x) PT_REGS_PARM4_CORE(x)
> > -#endif
> > -#define PT_REGS_PARM5_CORE_SYSCALL(x) PT_REGS_PARM5_CORE(x)
> > +#define PT_REGS_PARM5_CORE_SYSCALL(x)
> > BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM5_REG_SYSCALL)
> > 
> 
> No, please don't do it. It makes CORE variants too rigid. We agreed
> w/
> Naveen that the way you did it in v2 is better and more flexible and
> in v3 you did it the other way. Why?

As far as I remember we didn't discuss this proposal from Naveen [1] -
there was another one about moving SYS_PREFIX to libbpf, where
we agreed that it would have bad consequences.

Isn't this patch essentially equivalent to the one from my v3 [2],
but with the added ability to override more things and better-looking? 
I.e.: if we define __PT_PARMn_REG_SYSCALL, then PT_REGS_PARMn_SYSCALL
and PT_REGS_PARMn_CORE_SYSCALL use that, and __PT_PARMn_REG otherwise.

[1]
https://lore.kernel.org/bpf/1643990954.fs9q9mrdxt.naveen@linux.ibm.com/
[2]
https://lore.kernel.org/bpf/20220204145018.1983773-5-iii@linux.ibm.com/

> 
> >  #else /* defined(bpf_target_defined) */
> > 
> > --
> > 2.34.1
> > 

