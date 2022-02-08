Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3078F4AE362
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 23:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386053AbiBHWWr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 17:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387019AbiBHVq3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 16:46:29 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C335C0612B8
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 13:46:28 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218IEcqN037855;
        Tue, 8 Feb 2022 21:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=gZwTVrwZf0ZG+Z9rE00ySQ4L05xX5EZaiyhA4ytQ9Ag=;
 b=QAGahdND10ITSwQZ55NIvF9618uHcUxArX/Gz+G+nQfHlcn9M9uzn/8OGDAsbEMsmklI
 CZruYOtB8sF/0LoOLwgA1IUuLWw/Ex7eWX09y6UhQ/UNIUgsSHI6Tf8Lcp2LTFX04AaM
 MQPxYznvHPzpDU7nc3XN1+JlDO4FP2TwDLcFUOL0M4W088s4yRD9qhrYuBzCZZzcchIK
 Kc17xFVD+00Zoz0+yvg+I5BaLMdUoolbVO3bFCI1ujx16qXSAsqq1FYA94y+W0mik7qH
 UD/l8GXZuSlJkJoeMiZrUEnZYVNL/hm3PyUj13mWfywkiEYaw/C2Zkq9d+Grg8o4QkKC Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e3wmjv1js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 21:46:07 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 218LiIRD021416;
        Tue, 8 Feb 2022 21:46:06 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e3wmjv1jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 21:46:06 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 218Lan9R029975;
        Tue, 8 Feb 2022 21:46:04 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3e1ggk1gj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 21:46:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 218Lk1xs37814712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 21:46:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AC19A4054;
        Tue,  8 Feb 2022 21:46:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6292EA405B;
        Tue,  8 Feb 2022 21:46:00 +0000 (GMT)
Received: from [9.171.78.41] (unknown [9.171.78.41])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Feb 2022 21:46:00 +0000 (GMT)
Message-ID: <ee69bf0200fa21f2bab34384d57c32f126993d93.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v4 14/14] arm64: add a comment that warns that
 orig_x0 should not be moved
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, bpf <bpf@vger.kernel.org>
Date:   Tue, 08 Feb 2022 22:46:00 +0100
In-Reply-To: <CAADnVQLELpdhZba0GQdY6G-F6Ce4jnb_QnrJwc8F6yjMnLcEAw@mail.gmail.com>
References: <20220208051635.2160304-1-iii@linux.ibm.com>
         <20220208051635.2160304-15-iii@linux.ibm.com>
         <20220208192522.risaxa7debgxx5kz@ast-mbp.dhcp.thefacebook.com>
         <bb17e7657ada2577664caa6d0b9fbfcabf2f1676.camel@linux.ibm.com>
         <CAADnVQLELpdhZba0GQdY6G-F6Ce4jnb_QnrJwc8F6yjMnLcEAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -wjpIgaxsB7kyERpW1VH2JO-g9aYAjd4
X-Proofpoint-ORIG-GUID: eR-KqeOLoFRLpJnPDzONjvQyuLvw8ks0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_06,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=743 adultscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-02-08 at 13:11 -0800, Alexei Starovoitov wrote:
> On Tue, Feb 8, 2022 at 11:46 AM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > 
> > On Tue, 2022-02-08 at 11:25 -0800, Alexei Starovoitov wrote:
> > > On Tue, Feb 08, 2022 at 06:16:35AM +0100, Ilya Leoshkevich wrote:
> > > > orig_x0's location is used by libbpf tracing macros, therefore
> > > > it
> > > > should not be moved.
> > > > 
> > > > Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > ---
> > > >  arch/arm64/include/asm/ptrace.h | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/include/asm/ptrace.h
> > > > b/arch/arm64/include/asm/ptrace.h
> > > > index 41b332c054ab..7e34c3737839 100644
> > > > --- a/arch/arm64/include/asm/ptrace.h
> > > > +++ b/arch/arm64/include/asm/ptrace.h
> > > > @@ -185,6 +185,10 @@ struct pt_regs {
> > > >                         u64 pstate;
> > > >                 };
> > > >         };
> > > > +       /*
> > > > +        * orig_x0 is not exposed via struct user_pt_regs, but
> > > > its
> > > > location is
> > > > +        * assumed by libbpf's tracing macros, so it should not
> > > > be
> > > > moved.
> > > > +        */
> > > 
> > > In other words this comment is saying that the layout is ABI.
> > > That's not the case. orig_x0 here and equivalent on s390 can be
> > > moved.
> > > It will break bpf progs written without CO-RE and that is
> > > expected.
> > > Non CO-RE programs often do all kinds of bpf_probe_read_kernel
> > > and
> > > will be breaking when kernel layout is changing.
> > > I suggest to drop this patch and patch 12.
> > 
> > Yeah, that was the intention here: to promote orig_x0 to ABI using
> > a
> > comment, since doing this by extending user_pt_regs turned out to
> > be
> > infeasible. I'm actually ok with not doing this, since programs
> > compiled with kernel headers and using CO-RE macros will be fine.
> 
> The comment like this doesn't convert kernel internal struct into
> ABI.
> The comment is just wrong. BPF progs access many kernel data structs.
> s390's and arm64's struct pr_regs is not special in that sense.
> It's an internal struct.
> 
> > As you say, we don't care about programs that don't use CO-RE too
> > much
> > here - if they break after an incompatible kernel change, fine.
> 
> Before CO-RE was introduced bpf progs included kernel headers
> and were breaking when kernel changes. Nothing new here.
> See the history of bcc tools. Some of them are littered
> with ifdef VERSION ==.
> 
> > The question now is - how much do we care about programs that are
> 
> > compiled with userspace headers? Andrii suggested to use
> > offsetofend to
> > make syscall macros work there, however, this now requires this ABI
> > promotion.
> 
> Today s390 and arm64 have user_pt_regs as a first field in pt_regs.
> That is kernel internal behavior and that part can change if arch
> maintainers have a need for that.
> bpf progs without CO-RE would have to be adjusted when kernel
> changes.
> Even with CO-RE it's ok to rename pt_regs->orig_gpr2 on s390.
> The progs with CO-RE will break too. The authors of tracing bpf progs
> have to expect that sooner or later their progs will break and they
> would have to adjust them.

When it comes to authors of tracing bpf progs, I agree that eventually
they will have to adjust their code, CO-RE or not. However, in patch 13
I introduce the following libbpf macro:

#if defined(__KERNEL__) || defined(__VMLINUX_H__)
...
#else
#define PT_REGS_PARM1_SYSCALL(x) \
	(*(unsigned long *)(((char *)(x) + \
			     offsetofend(struct user_pt_regs,
pstate))))

If we merge this series without freezing orig_x0's offset, in case of
an incompatible kernel change the users of PT_REGS_PARMn_SYSCALL and
BPF_KPROBE_SYSCALL, who build against userspace headers, will not
simply have to update their code - they will have to upgrade libbpf.
It's also not clear how PT_REGS_PARM1_SYSCALL in the upgraded libbpf 
will even look like, given that it would need to work on both old and
new kernels.

I've also briefly looked into MIPS' ptrace.h, and it looks as if their
user_pt_regs has no relationship to kernel pt_regs. IIUC this means
that it's not possible to correctly implement PT_REGS_PARMn_SYSCALL
using MIPS userspace headers.

So I wonder whether we should allow using PT_REGS_PARMn_SYSCALL and
BPF_KPROBE_SYSCALL with userspace headers at all? Would it make sense
to simply fail the compilation if PT_REGS_PARMn_SYSCALL is used without
including kernel headers?
