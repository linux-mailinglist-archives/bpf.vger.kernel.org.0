Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B6A316806
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 14:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhBJN3m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 08:29:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229710AbhBJN3k (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Feb 2021 08:29:40 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11AD3STG160121;
        Wed, 10 Feb 2021 08:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=BEqkC96lTGeXQAMj/bqBNOqmxwlzBQ6MS20v5SVBe14=;
 b=QHH/AsH9R0/TFErtjCyo1Agfe+flB/mXXZt39rrXlBbO84LRJngFeInxq2xxldMMzuMU
 qOs1hOD1ocIlwys3SvMLC9mpkhBRrTiEMQWAKvlMxgBsioVbdCcJfTIXnRtoniX0pb8f
 Rfk4CprJeizWcaCHs7yGmCoLEZKqnwJzsiwb76PCYH3GMWzeHSeJ9bbELYhUmZf7SRSm
 t7PN9qQE+q1NmOT8NxC6TCPd94FUVhnxosZGAVlihFD6LFKjno4kjmSp7uz5tZTUG1yp
 dZzzROq8Ly3RfTdMBxiqCdvwRB8sV/jPPM0PEZ1VncHm3hr869GCJJkSPBmlKvVasM5n 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36mfs81bm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 08:28:45 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11AD4Bgm166679;
        Wed, 10 Feb 2021 08:28:45 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36mfs81bke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 08:28:45 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11ADRA5d025213;
        Wed, 10 Feb 2021 13:28:42 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 36hskb2cab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 13:28:42 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11ADSdrT58130694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 13:28:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADE8552050;
        Wed, 10 Feb 2021 13:28:39 +0000 (GMT)
Received: from [9.171.67.27] (unknown [9.171.67.27])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 38BB85204F;
        Wed, 10 Feb 2021 13:28:39 +0000 (GMT)
Message-ID: <5c6501bea0f7ae9dcb9d5f2071441942d5d3dc0f.camel@linux.ibm.com>
Subject: Re: What should BPF_CMPXCHG do when the values match?
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Brendan Jackman <jackmanb@google.com>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Wed, 10 Feb 2021 14:28:38 +0100
In-Reply-To: <CAADnVQJFcFwxEz=wnV=hkie-EDwa8s5JGbBQeFt1TGux1OihJw@mail.gmail.com>
References: <b1792bb3c51eb3e94b9d27e67665d3f2209bba7e.camel@linux.ibm.com>
         <CAADnVQJFcFwxEz=wnV=hkie-EDwa8s5JGbBQeFt1TGux1OihJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_05:2021-02-10,2021-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100126
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2021-02-09 at 20:14 -0800, Alexei Starovoitov wrote:
> On Tue, Feb 9, 2021 at 4:43 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > 
> > Hi,
> > 
> > I'm implementing BPF_CMPXCHG for the s390x JIT and noticed that the
> > doc, the interpreter and the X64 JIT do not agree on what the
> > behavior
> > should be when the values match.
> > 
> > If the operand size is BPF_W, this matters, because, depending on
> > the
> > answer, the upper bits of R0 are either zeroed out out or are left
> > intact.
> > 
> > I made the experiment based on the following modification to the
> > "atomic compare-and-exchange smoketest - 32bit" test on top of
> > commit
> > ee5cc0363ea0:
> > 
> > --- a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
> > +++ b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
> > @@ -57,8 +57,8 @@
> >                 BPF_MOV32_IMM(BPF_REG_1, 4),
> >                 BPF_MOV32_IMM(BPF_REG_0, 3),
> >                 BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, BPF_REG_10,
> > BPF_REG_1, -4),
> > -               /* if (old != 3) exit(4); */
> > -               BPF_JMP32_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
> > +               /* if ((u64)old != 3) exit(4); */
> > +               BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
> >                 BPF_MOV32_IMM(BPF_REG_0, 4),
> >                 BPF_EXIT_INSN(),
> >                 /* if (val != 4) exit(5); */
> > 
> > and got the following results:
> > 
> > 1) Documentation: Upper bits of R0 are zeroed out - but it looks as
> > if
> >    there is a typo and either a period or the word "otherwise" is
> >    missing?
> > 
> >    > If they match it is replaced with ``src_reg``, The value that
> > was
> >    > there before is loaded back to ``R0``.
> > 
> > 2) Interpreter + KVM: Upper bits of R0 are zeroed out (C semantics)
> > 
> > 3) X64 JIT + KVM: Upper bits of R0 are untouched (cmpxchg
> > semantics)
> > 
> >    => 0xffffffffc0146bc7: lock cmpxchg %edi,-0x4(%rbp)
> >       0xffffffffc0146bcc: cmp $0x3,%rax
> >    (gdb) p/x $rax
> >    0x6bd5720c00000003
> >    (gdb) x/d $rbp-4
> >    0xffffc90001263d5c: 3
> > 
> >       0xffffffffc0146bc7: lock cmpxchg %edi,-0x4(%rbp)
> >    => 0xffffffffc0146bcc: cmp $0x3,%rax
> >    (gdb) p/x $rax
> >    0x6bd5720c00000003
> > 
> > 4) X64 JIT + TCG: Upper bits of R0 are zeroed out (qemu bug?)
> > 
> >    => 0xffffffffc01441fc: lock cmpxchg %edi,-0x4(%rbp)
> >       0xffffffffc0144201: cmp $0x3,%rax
> >    (gdb) p/x $rax
> >    0x81776ea600000003
> >    (gdb) x/d $rbp-4
> >    0xffffc90001117d5c: 3
> > 
> >       0xffffffffc01441fc: lock cmpxchg %edi,-0x4(%rbp)
> >    => 0xffffffffc0144201: cmp $0x3,%rax
> >    (gdb) p/x $rax
> >    $3 = 0x3
> > 
> > So which option is the right one? In my opinion, it would be safer
> > to
> > follow what the interpreter does and zero out the upper bits.
> 
> Wow. What a find!
> I thought that all 32-bit x86 ops zero-extend the dest register.

I think that's true, it's just that when the values match, cmpxchg is
specified to do nothing.

> I agree that it's best to zero upper bits for cmpxchg as well.

I will send a doc patch to clarify the wording then.

> I wonder whether compilers know about this exceptional behavior.

I'm not too familiar with the BPF LLVM backend, but at least CMPXCHG32
is defined in a similar way to XFALU32, so it should be fine. Maybe
Yonghong can comment on this further.

> I believe the bpf backend considers full R0 to be used by bpf's
> cmpxchg.

It's a little bit inconsistent at the moment. I don't know why yet,
but on s390 the subreg optimization kicks in and I have to run with the
following patch in order to avoid stack pointer zero extension:

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10588,6 +10588,7 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct
bpf_verifier_env *env,
        for (i = 0; i < len; i++) {
                int adj_idx = i + delta;
                struct bpf_insn insn;
+               u8 load_reg;
 
                insn = insns[adj_idx];
                if (!aux[adj_idx].zext_dst) {
@@ -10630,9 +10631,29 @@ static int
opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
                if (!bpf_jit_needs_zext())
                        continue;
 
+               /* zext_dst means that we want to zero-extend whatever
register
+                * the insn defines, which is dst_reg most of the time,
with
+                * the notable exception of BPF_STX + BPF_ATOMIC +
BPF_FETCH.
+                */
+               if (BPF_CLASS(insn.code) == BPF_STX &&
+                   BPF_MODE(insn.code) == BPF_ATOMIC) {
+                       /* BPF_STX + BPF_ATOMIC insns without BPF_FETCH
do not
+                        * define any registers, therefore zext_dst
cannot be
+                        * set.
+                        */
+                       if (WARN_ON_ONCE(!(insn.imm & BPF_FETCH)))
+                               return -EINVAL;
+                       if (insn.imm == BPF_CMPXCHG)
+                               load_reg = BPF_REG_0;
+                       else
+                               load_reg = insn.src_reg;
+               } else {
+                       load_reg = insn.dst_reg;
+               }
+
                zext_patch[0] = insn;
-               zext_patch[1].dst_reg = insn.dst_reg;
-               zext_patch[1].src_reg = insn.dst_reg;
+               zext_patch[1].dst_reg = load_reg;
+               zext_patch[1].src_reg = load_reg;
                patch = zext_patch;
                patch_len = 2;
 apply_patch_buffer:

However, this doesn't seem to affect x86_64.

> Do you know what xchg does on x86? What about arm64 with cas?

xchg always zeroes out the upper half.
Unlike x86_64's cmpxchg, arm64's cas is specified to always zero out
the upper half, even if the values match. I don't have access to arm8.1
machine to test this, but at least QEMU does behave this way.
s390's cs does not zero out the upper half, we need to use llgfr in
addition (which doesn't sound like a big deal to me).

