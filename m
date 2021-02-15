Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5653931C41C
	for <lists+bpf@lfdr.de>; Mon, 15 Feb 2021 23:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhBOWnh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Feb 2021 17:43:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229720AbhBOWnh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Feb 2021 17:43:37 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11FMXUg3005740;
        Mon, 15 Feb 2021 17:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=6TeMNyQdjTkYlElPt2wZLvr3olBTRwHPB85CvYIG/N4=;
 b=QvX7lHQSMiIAz8YINdmSkduF3hCxzPsbsZQpQBv7RPLhhp1gau025YMdB/vTgnyps7iZ
 nrspDU5fKYYP5dxiYrl9saitw7j9IsEr56TrYNxSmI6AG7IOKLHl1t/lF8CaihEAc5fM
 Ee6RnKrs5XcOMNflAwi4+t6qC2SICWF5o9UkSr57fQid3y/kRnC2Df866fZN3PqwZsCm
 +MX3itvVaRBCceH5X7ll3Y8DXuLV6/TzoeNh/CTC50WNARYskFGj4esYtOFwiRSrjulm
 4p574wFktft1vdI7PfRr8pvjrnvF5PmRfmyZpwU2aq8hYUF0Eb5AZxOspQV6yslijilu rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36r0p9hqy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 17:42:37 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11FMZf4u014382;
        Mon, 15 Feb 2021 17:42:37 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36r0p9hqxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 17:42:36 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11FMfiw4014723;
        Mon, 15 Feb 2021 22:42:35 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 36p61ha80m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 22:42:35 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11FMgXVJ61604164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 22:42:33 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AB7C5204E;
        Mon, 15 Feb 2021 22:42:33 +0000 (GMT)
Received: from [9.171.67.27] (unknown [9.171.67.27])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9F0F65204F;
        Mon, 15 Feb 2021 22:42:32 +0000 (GMT)
Message-ID: <5f7b836cc07980352215a5ad9a959c7e7c47f1cf.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next] bpf: x86: Explicitly zero-extend rax after
 32-bit cmpxchg
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
Date:   Mon, 15 Feb 2021 23:42:32 +0100
In-Reply-To: <725b73b5-be08-f253-165d-e027ec568691@iogearbox.net>
References: <20210215171208.1181305-1-jackmanb@google.com>
         <44912664-5c0b-8d95-de01-c87b1e8a846c@iogearbox.net>
         <b4b116fd53ac14a3006d81ed90069600b3abae4f.camel@linux.ibm.com>
         <725b73b5-be08-f253-165d-e027ec568691@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_16:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102150169
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2021-02-15 at 23:35 +0100, Daniel Borkmann wrote:
> On 2/15/21 11:24 PM, Ilya Leoshkevich wrote:
> > On Mon, 2021-02-15 at 23:20 +0100, Daniel Borkmann wrote:
> > > On 2/15/21 6:12 PM, Brendan Jackman wrote:
> > > > As pointed out by Ilya and explained in the new comment,
> > > > there's a
> > > > discrepancy between x86 and BPF CMPXCHG semantics: BPF always
> > > > loads
> > > > the value from memory into r0, while x86 only does so when r0
> > > > and
> > > > the
> > > > value in memory are different.
> > > > 
> > > > At first this might sound like pure semantics, but it makes a
> > > > real
> > > > difference when the comparison is 32-bit, since the load will
> > > > zero-extend r0/rax.
> > > > 
> > > > The fix is to explicitly zero-extend rax after doing such a
> > > > CMPXCHG.
> > > > 
> > > > Note that this doesn't generate totally optimal code: at one of
> > > > emit_atomic's callsites (where BPF_{AND,OR,XOR} | BPF_FETCH are
> > > > implemented), the new mov is superfluous because there's
> > > > already a
> > > > mov generated afterwards that will zero-extend r0. We could
> > > > avoid
> > > > this unnecessary mov by just moving the new logic outside of
> > > > emit_atomic. But I think it's simpler to keep emit_atomic as a
> > > > unit
> > > > of correctness (it generates the correct x86 code for a certain
> > > > set
> > > > of BPF instructions, no further knowledge is needed to use it
> > > > correctly).
> > > > 
> > > > Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > Fixes: 5ffa25502b5a ("bpf: Add instructions for
> > > > atomic_[cmp]xchg")
> > > > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > > > ---
> > > >    arch/x86/net/bpf_jit_comp.c                   | 10 +++++++
> > > >    .../selftests/bpf/verifier/atomic_cmpxchg.c   | 25
> > > > ++++++++++++++++++
> > > >    .../selftests/bpf/verifier/atomic_or.c        | 26
> > > > +++++++++++++++++++
> > > >    3 files changed, 61 insertions(+)
> > > > 
> > > > diff --git a/arch/x86/net/bpf_jit_comp.c
> > > > b/arch/x86/net/bpf_jit_comp.c
> > > > index 79e7a0ec1da5..7919d5c54164 100644
> > > > --- a/arch/x86/net/bpf_jit_comp.c
> > > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > > @@ -834,6 +834,16 @@ static int emit_atomic(u8 **pprog, u8
> > > > atomic_op,
> > > >    
> > > >          emit_insn_suffix(&prog, dst_reg, src_reg, off);
> > > >    
> > > > +       if (atomic_op == BPF_CMPXCHG && bpf_size == BPF_W) {
> > > > +               /*
> > > > +                * BPF_CMPXCHG unconditionally loads into R0,
> > > > which
> > > > means it
> > > > +                * zero-extends 32-bit values. However x86
> > > > CMPXCHG
> > > > doesn't do a
> > > > +                * load if the comparison is successful.
> > > > Therefore
> > > > zero-extend
> > > > +                * explicitly.
> > > > +                */
> > > > +               emit_mov_reg(&prog, false, BPF_REG_0,
> > > > BPF_REG_0);
> > > 
> > > How does the situation look on other archs when they need to
> > > implement this in future?
> > > Mainly asking whether it would be better to instead to move this
> > > logic into the verifier
> > > instead, so it'll be consistent across all archs.
> > 
> > I have exactly the same check in my s390 wip patch.
> > So having a common solution would be great.
> 
> We do rewrites for various cases like div/mod handling, perhaps would
> be
> best to emit an explicit BPF_MOV32_REG(insn->dst_reg, insn->dst_reg)
> there,
> see the fixup_bpf_calls().

How about BPF_ZEXT_REG? Then arches that don't need this (I think
aarch64's instruction always zero-extends) can detect this using
insn_is_zext() and skip such insns.

