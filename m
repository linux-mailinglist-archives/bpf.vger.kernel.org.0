Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E514D2550
	for <lists+bpf@lfdr.de>; Wed,  9 Mar 2022 02:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiCIBIL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 20:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiCIBHv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 20:07:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E99134DE5
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 16:48:25 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228NXMgU017647;
        Tue, 8 Mar 2022 23:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=4fJ2MM9M41BOyRCy/50cF/r0OkbjyNyZcFz9yG1Wzj0=;
 b=ZGuMJ0x3Q/c3ZTCr10Dy9M1+r1xH0nuJ0LtP8Hghfj6oNIeotvDV5UbOCpuXlOQTITOu
 5rW5YjDxAg8c5q8D3am57Nkj68mz4Yy9WfJsX3Aib4FMLjW2Af9t7p3AvozTIJkiefnz
 ApBpgcr8f5FT06N2n7RLwlda2SNiRJHCtNcNHsJCij2zIrcwLokQhstjN0zNNS10yHr3
 p6hT49zBhSebDGP4FlpbXOm+jh1682WAahdkJafzFvrdP7QtryXUgxTLMIgsuZa+xxNi
 Lmopis4oR8TGUhIRw0ekKTbAln5MJvdchbINSpkp0YoQ2GUnJBPrPhW9D1vRh5eCTLMu HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3enu2sjwnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 23:59:06 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 228Nx6vn010164;
        Tue, 8 Mar 2022 23:59:06 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3enu2sjwn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 23:59:05 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 228NvKNx000531;
        Tue, 8 Mar 2022 23:59:03 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3eky4j0rp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 23:59:03 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 228Nx0VJ11600196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Mar 2022 23:59:00 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E414EA4040;
        Tue,  8 Mar 2022 23:58:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8893BA4051;
        Tue,  8 Mar 2022 23:58:59 +0000 (GMT)
Received: from [9.171.29.97] (unknown [9.171.29.97])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Mar 2022 23:58:59 +0000 (GMT)
Message-ID: <8d8b464f6c2820989d67f00d24b6003b8b758274.camel@linux.ibm.com>
Subject: Re: [PATCH RFC bpf-next 1/3] bpf: Fix certain narrow loads with
 offsets
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Wed, 09 Mar 2022 00:58:59 +0100
In-Reply-To: <87bkygzbg5.fsf@cloudflare.com>
References: <20220222182559.2865596-1-iii@linux.ibm.com>
         <20220222182559.2865596-2-iii@linux.ibm.com>
         <87bkygzbg5.fsf@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qJEKgtuXCgjIUVu08DYjfBTcpAU0or-X
X-Proofpoint-GUID: 84puj7knXTwjWOyXNSgpb8G59xvlHBxO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_09,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203080117
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-03-08 at 16:01 +0100, Jakub Sitnicki wrote:
> On Tue, Feb 22, 2022 at 07:25 PM +01, Ilya Leoshkevich wrote:
> > Verifier treats bpf_sk_lookup.remote_port as a 32-bit field for
> > backward compatibility, regardless of what the uapi headers say.
> > This field is mapped onto the 16-bit bpf_sk_lookup_kern.sport
> > field.
> > Therefore, accessing the most significant 16 bits of
> > bpf_sk_lookup.remote_port must produce 0, which is currently not
> > the case.
> > 
> > The problem is that narrow loads with offset - commit 46f53a65d2de
> > ("bpf: Allow narrow loads with offset > 0"), don't play nicely with
> > the masking optimization - commit 239946314e57 ("bpf: possibly
> > avoid
> > extra masking for narrower load in verifier"). In particular, when
> > we
> > suppress extra masking, we suppress shifting as well, which is not
> > correct.
> > 
> > Fix by moving the masking suppression check to BPF_AND generation.
> > 
> > Fixes: 46f53a65d2de ("bpf: Allow narrow loads with offset > 0")
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >  kernel/bpf/verifier.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index d7473fee247c..195f2e9b5a47 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12848,7 +12848,7 @@ static int convert_ctx_accesses(struct
> > bpf_verifier_env *env)
> >                         return -EINVAL;
> >                 }
> >  
> > -               if (is_narrower_load && size < target_size) {
> > +               if (is_narrower_load) {
> >                         u8 shift = bpf_ctx_narrow_access_offset(
> >                                 off, size, size_default) * 8;
> >                         if (shift && cnt + 1 >=
> > ARRAY_SIZE(insn_buf)) {
> > @@ -12860,15 +12860,19 @@ static int convert_ctx_accesses(struct
> > bpf_verifier_env *env)
> >                                         insn_buf[cnt++] =
> > BPF_ALU32_IMM(BPF_RSH,
> >                                                                    
> >      insn->dst_reg,
> >                                                                    
> >      shift);
> > -                               insn_buf[cnt++] =
> > BPF_ALU32_IMM(BPF_AND, insn->dst_reg,
> > -                                                               (1
> > << size * 8) - 1);
> > +                               if (size < target_size)
> > +                                       insn_buf[cnt++] =
> > BPF_ALU32_IMM(
> > +                                               BPF_AND, insn-
> > >dst_reg,
> > +                                               (1 << size * 8) -
> > 1);
> >                         } else {
> >                                 if (shift)
> >                                         insn_buf[cnt++] =
> > BPF_ALU64_IMM(BPF_RSH,
> >                                                                    
> >      insn->dst_reg,
> >                                                                    
> >      shift);
> > -                               insn_buf[cnt++] =
> > BPF_ALU64_IMM(BPF_AND, insn->dst_reg,
> > -
> >                                                                (1ULL
> >  << size * 8) - 1);
> > +                               if (size < target_size)
> > +                                       insn_buf[cnt++] =
> > BPF_ALU64_IMM(
> > +                                               BPF_AND, insn-
> > >dst_reg,
> > +                                               (1ULL << size * 8)
> > - 1);
> >                         }
> >                 }
> 
> Thanks for patience. I'm coming back to this.
> 
> This fix affects the 2-byte load from bpf_sk_lookup.remote_port.
> Dumping the xlated BPF code confirms it.
> 
> On LE (x86-64) things look well.
> 
> Before this patch:
> 
> * size=2, offset=0, 0: (69) r2 = *(u16 *)(r1 +36)
>    0: (69) r2 = *(u16 *)(r1 +4)
>    1: (b7) r0 = 0
>    2: (95) exit
> 
> * size=2, offset=2, 0: (69) r2 = *(u16 *)(r1 +38)
>    0: (69) r2 = *(u16 *)(r1 +4)
>    1: (b7) r0 = 0
>    2: (95) exit
> 
> After this patch:
> 
> * size=2, offset=0, 0: (69) r2 = *(u16 *)(r1 +36)
>    0: (69) r2 = *(u16 *)(r1 +4)
>    1: (b7) r0 = 0
>    2: (95) exit
> 
> * size=2, offset=2, 0: (69) r2 = *(u16 *)(r1 +38)
>    0: (69) r2 = *(u16 *)(r1 +4)
>    1: (74) w2 >>= 16
>    2: (b7) r0 = 0
>    3: (95) exit
> 
> Which works great because the JIT generates a zero-extended load
> movzwq:
> 
> * size=2, offset=0, 0: (69) r2 = *(u16 *)(r1 +36)
> bpf_prog_5e4fe3dbdcb18fd3:
>    0:   nopl   0x0(%rax,%rax,1)
>    5:   xchg   %ax,%ax
>    7:   push   %rbp
>    8:   mov    %rsp,%rbp
>    b:   movzwq 0x4(%rdi),%rsi
>   10:   xor    %eax,%eax
>   12:   leave
>   13:   ret
> 
> 
> * size=2, offset=2, 0: (69) r2 = *(u16 *)(r1 +38)
> bpf_prog_4a6336c64a340b96:
>    0:   nopl   0x0(%rax,%rax,1)
>    5:   xchg   %ax,%ax
>    7:   push   %rbp
>    8:   mov    %rsp,%rbp
>    b:   movzwq 0x4(%rdi),%rsi
>   10:   shr    $0x10,%esi
>   13:   xor    %eax,%eax
>   15:   leave
>   16:   ret
> 
> Runtime checks for bpf_sk_lookup.remote_port load and the 2-bytes of
> zero padding following it, like below, pass with flying colors:
> 
>         ok = ctx->remote_port == bpf_htons(8008);
>         if (!ok)
>                 return SK_DROP;
>         ok = *((__u16 *)&ctx->remote_port + 1) == 0;
>         if (!ok)
>                 return SK_DROP;
> 
> (The above checks compile to half-word (2-byte) loads.)
> 
> 
> On BE (s390x) things look different:
> 
> Before the patch:
> 
> * size=2, offset=0, 0: (69) r2 = *(u16 *)(r1 +36)
>    0: (69) r2 = *(u16 *)(r1 +4)
>    1: (bc) w2 = w2
>    2: (b7) r0 = 0
>    3: (95) exit
> 
> * size=2, offset=2, 0: (69) r2 = *(u16 *)(r1 +38)
>    0: (69) r2 = *(u16 *)(r1 +4)
>    1: (bc) w2 = w2
>    2: (b7) r0 = 0
>    3: (95) exit
> 
> After the patch:
> 
> * size=2, offset=0, 0: (69) r2 = *(u16 *)(r1 +36)
>    0: (69) r2 = *(u16 *)(r1 +4)
>    1: (bc) w2 = w2
>    2: (74) w2 >>= 16
>    3: (bc) w2 = w2
>    4: (b7) r0 = 0
>    5: (95) exit
> 
> * size=2, offset=2, 0: (69) r2 = *(u16 *)(r1 +38)
>    0: (69) r2 = *(u16 *)(r1 +4)
>    1: (bc) w2 = w2
>    2: (b7) r0 = 0
>    3: (95) exit
> 
> These compile to:
> 
> * size=2, offset=0, 0: (69) r2 = *(u16 *)(r1 +36)
> bpf_prog_fdd58b8caca29f00:
>    0:   j       0x0000000000000006
>    4:   nopr
>    6:   stmg    %r11,%r15,112(%r15)
>    c:   la      %r13,64(%r15)
>   10:   aghi    %r15,-96
>   14:   llgh    %r3,4(%r2,%r0)
>   1a:   srl     %r3,16
>   1e:   llgfr   %r3,%r3
>   22:   lgfi    %r14,0
>   28:   lgr     %r2,%r14
>   2c:   lmg     %r11,%r15,208(%r15)
>   32:   br      %r14
> 
> 
> * size=2, offset=2, 0: (69) r2 = *(u16 *)(r1 +38)
> bpf_prog_5e3d8e92223c6841:
>    0:   j       0x0000000000000006
>    4:   nopr
>    6:   stmg    %r11,%r15,112(%r15)
>    c:   la      %r13,64(%r15)
>   10:   aghi    %r15,-96
>   14:   llgh    %r3,4(%r2,%r0)
>   1a:   lgfi    %r14,0
>   20:   lgr     %r2,%r14
>   24:   lmg     %r11,%r15,208(%r15)
>   2a:   br      %r14
> 
> Now, we right shift the value when loading
> 
>   *(u16 *)(r1 +36)
> 
> which in C BPF is equivalent to
> 
>   *((__u16 *)&ctx->remote_port + 0)
> 
> due to how the shift is calculated by bpf_ctx_narrow_access_offset().

Right, that's exactly the intention here.
The way I see the situation is: the ABI forces us to treat remote_port
as a 32-bit field, even though the updated header now says otherwise.
And this:

    unsigned int remote_port;
    unsigned short result = *(unsigned short *)remote_port;

should be the same as:

    unsigned short result = remote_port >> 16;

on big-endian. Note that this is inherently non-portable.

> This makes the expected typical use-case
> 
>   ctx->remote_port == bpf_htons(8008)
> 
> fail on s390x because llgh (Load Logical Halfword (64<-16)) seems to
> lay
> out the data in the destination register so that it holds
> 0x0000_0000_0000_1f48.
> 
> I don't know that was the intention here, as it makes the BPF C code
> non-portable.
> 
> WDYT?

This depends on how we define the remote_port field. I would argue that
the definition from patch 2 - even though ugly - is the correct one.
It is consistent with both the little-endian (1f 48 00 00) and
big-endian (00 00 1f 48) ABIs.

I don't think the current definition is correct, because it expects
1f 48 00 00 on big-endian, and this is not the case. We can verify this
by taking 9a69e2^ and applying

--- a/tools/testing/selftests/bpf/progs/test_sk_lookup.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
@@ -417,6 +417,8 @@ int ctx_narrow_access(struct bpf_sk_lookup *ctx)
                return SK_DROP;
        if (LSW(ctx->remote_port, 0) != SRC_PORT)
                return SK_DROP;
+       if (ctx->remote_port != SRC_PORT)
+               return SK_DROP;
 
        /* Narrow loads from local_port field. Expect DST_PORT. */
        if (LSB(ctx->local_port, 0) != ((DST_PORT >> 0) & 0xff) ||

Therefore that

  ctx->remote_port == bpf_htons(8008)

fails without patch 2 is as expected.

> BTW. Out of curiosity, how does a Logical Load Halfword (llgh) differ
> differ from a non-logical Load Halfword (lgh) on s390x? Compiler
> Explorer generates a non-logical load for similar C code.

The logical one does zero extension, and the regular one does sign
extension.

The following

  unsigned long foo(unsigned short *bar) {
          return *bar;
  }

is compiled to

  foo(unsigned short*):
          llgh    %r2,0(%r2)
          br      %r14

with -O3. Without -O3 zeroing out the upper bits is done using the sllg
and srlg (left and right logical shifts respectively).
