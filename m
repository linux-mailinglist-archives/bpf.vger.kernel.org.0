Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B2F4D2F21
	for <lists+bpf@lfdr.de>; Wed,  9 Mar 2022 13:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiCIMf0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 07:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiCIMf0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 07:35:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F0E1693AD
        for <bpf@vger.kernel.org>; Wed,  9 Mar 2022 04:34:26 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229BNdu4030759;
        Wed, 9 Mar 2022 12:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=g5JtA95GP3vSZzWuEG8oDf6q8sefbem76ik41pJpr3g=;
 b=p+BWbPXcitFOHWaT7G59ziCZbUgjEpsdYtMU0f0sC4unQ2pM2NYCZdOQ8TIgdpZrey1J
 O73EEGFXYhoXEgC6BpNOzEuUyvx32b6BWLx8TIpxxWS/DXNkDsz0qCF202f8Xhygkb3A
 hFUpzPNwfZVkotoI6+nDb6t9OB8zuGlIB3fyvqbV3mxZwOO2VfEsGPeG1VYMDwiPWLN6
 jAwfO3z+Tv4P9H6W/2BL3GnPgm12Na/1oTbKf96SDx1HXUCcx8hDSJ/ybLxyKAXHHWPP
 xW444gmrUxUEY/+QbfCaMdzWfMja9lwM7BXak33kPH+AthEHPfKNV7zXbf0OVZWejzbB Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3enu2sycwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 12:34:13 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 229CFQbt017367;
        Wed, 9 Mar 2022 12:34:12 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3enu2sycvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 12:34:12 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 229CHeKF025122;
        Wed, 9 Mar 2022 12:34:10 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3ekyg90me8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 12:34:10 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 229CMtdZ44761344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Mar 2022 12:22:55 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF4EAA405C;
        Wed,  9 Mar 2022 12:34:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FAD5A405F;
        Wed,  9 Mar 2022 12:34:06 +0000 (GMT)
Received: from [9.171.29.97] (unknown [9.171.29.97])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Mar 2022 12:34:06 +0000 (GMT)
Message-ID: <a924d763fe50ec80594ca3fac6b311cf9ec20fca.camel@linux.ibm.com>
Subject: Re: [PATCH RFC bpf-next 1/3] bpf: Fix certain narrow loads with
 offsets
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Wed, 09 Mar 2022 13:34:06 +0100
In-Reply-To: <871qzbz5sa.fsf@cloudflare.com>
References: <20220222182559.2865596-1-iii@linux.ibm.com>
         <20220222182559.2865596-2-iii@linux.ibm.com>
         <87bkygzbg5.fsf@cloudflare.com>
         <8d8b464f6c2820989d67f00d24b6003b8b758274.camel@linux.ibm.com>
         <871qzbz5sa.fsf@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -fY9mdShlNe2pBrakBpryDmCNExKZWsS
X-Proofpoint-GUID: wn9ItD8mx2CogW7YwL6F3bc8nv55_HB5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-09_04,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2022-03-09 at 09:36 +0100, Jakub Sitnicki wrote:
> On Wed, Mar 09, 2022 at 12:58 AM +01, Ilya Leoshkevich wrote:
> > On Tue, 2022-03-08 at 16:01 +0100, Jakub Sitnicki wrote:
> > > On Tue, Feb 22, 2022 at 07:25 PM +01, Ilya Leoshkevich wrote:
> > > > Verifier treats bpf_sk_lookup.remote_port as a 32-bit field for
> > > > backward compatibility, regardless of what the uapi headers
> > > > say.
> > > > This field is mapped onto the 16-bit bpf_sk_lookup_kern.sport
> > > > field.
> > > > Therefore, accessing the most significant 16 bits of
> > > > bpf_sk_lookup.remote_port must produce 0, which is currently
> > > > not
> > > > the case.
> > > > 
> > > > The problem is that narrow loads with offset - commit
> > > > 46f53a65d2de
> > > > ("bpf: Allow narrow loads with offset > 0"), don't play nicely
> > > > with
> > > > the masking optimization - commit 239946314e57 ("bpf: possibly
> > > > avoid
> > > > extra masking for narrower load in verifier"). In particular,
> > > > when
> > > > we
> > > > suppress extra masking, we suppress shifting as well, which is
> > > > not
> > > > correct.
> > > > 
> > > > Fix by moving the masking suppression check to BPF_AND
> > > > generation.
> > > > 
> > > > Fixes: 46f53a65d2de ("bpf: Allow narrow loads with offset > 0")
> > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > ---
> > > >  kernel/bpf/verifier.c | 14 +++++++++-----
> > > >  1 file changed, 9 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index d7473fee247c..195f2e9b5a47 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -12848,7 +12848,7 @@ static int convert_ctx_accesses(struct
> > > > bpf_verifier_env *env)
> > > >                         return -EINVAL;
> > > >                 }
> > > >  
> > > > -               if (is_narrower_load && size < target_size) {
> > > > +               if (is_narrower_load) {
> > > >                         u8 shift =
> > > > bpf_ctx_narrow_access_offset(
> > > >                                 off, size, size_default) * 8;
> > > >                         if (shift && cnt + 1 >=
> > > > ARRAY_SIZE(insn_buf)) {
> > > > @@ -12860,15 +12860,19 @@ static int
> > > > convert_ctx_accesses(struct
> > > > bpf_verifier_env *env)
> > > >                                         insn_buf[cnt++] =
> > > > BPF_ALU32_IMM(BPF_RSH,
> > > >                                                                
> > > >     
> > > >      insn->dst_reg,
> > > >                                                                
> > > >     
> > > >      shift);
> > > > -                               insn_buf[cnt++] =
> > > > BPF_ALU32_IMM(BPF_AND, insn->dst_reg,
> > > > -
> > > >                                                                (
> > > > 1
> > > > << size * 8) - 1);
> > > > +                               if (size < target_size)
> > > > +                                       insn_buf[cnt++] =
> > > > BPF_ALU32_IMM(
> > > > +                                               BPF_AND, insn-
> > > > > dst_reg,
> > > > +                                               (1 << size * 8)
> > > > -
> > > > 1);
> > > >                         } else {
> > > >                                 if (shift)
> > > >                                         insn_buf[cnt++] =
> > > > BPF_ALU64_IMM(BPF_RSH,
> > > >                                                                
> > > >     
> > > >      insn->dst_reg,
> > > >                                                                
> > > >     
> > > >      shift);
> > > > -                               insn_buf[cnt++] =
> > > > BPF_ALU64_IMM(BPF_AND, insn->dst_reg,
> > > > -
> > > >                                                                
> > > > (1ULL
> > > >  << size * 8) - 1);
> > > > +                               if (size < target_size)
> > > > +                                       insn_buf[cnt++] =
> > > > BPF_ALU64_IMM(
> > > > +                                               BPF_AND, insn-
> > > > > dst_reg,
> > > > +                                               (1ULL << size *
> > > > 8)
> > > > - 1);
> > > >                         }
> > > >                 }
> > > 
> > > Thanks for patience. I'm coming back to this.
> > > 
> > > This fix affects the 2-byte load from bpf_sk_lookup.remote_port.
> > > Dumping the xlated BPF code confirms it.
> > > 
> > > On LE (x86-64) things look well.
> > > 
> > > Before this patch:
> > > 
> > > * size=2, offset=0, 0: (69) r2 = *(u16 *)(r1 +36)
> > >    0: (69) r2 = *(u16 *)(r1 +4)
> > >    1: (b7) r0 = 0
> > >    2: (95) exit
> > > 
> > > * size=2, offset=2, 0: (69) r2 = *(u16 *)(r1 +38)
> > >    0: (69) r2 = *(u16 *)(r1 +4)
> > >    1: (b7) r0 = 0
> > >    2: (95) exit
> > > 
> > > After this patch:
> > > 
> > > * size=2, offset=0, 0: (69) r2 = *(u16 *)(r1 +36)
> > >    0: (69) r2 = *(u16 *)(r1 +4)
> > >    1: (b7) r0 = 0
> > >    2: (95) exit
> > > 
> > > * size=2, offset=2, 0: (69) r2 = *(u16 *)(r1 +38)
> > >    0: (69) r2 = *(u16 *)(r1 +4)
> > >    1: (74) w2 >>= 16
> > >    2: (b7) r0 = 0
> > >    3: (95) exit
> > > 
> > > Which works great because the JIT generates a zero-extended load
> > > movzwq:
> > > 
> > > * size=2, offset=0, 0: (69) r2 = *(u16 *)(r1 +36)
> > > bpf_prog_5e4fe3dbdcb18fd3:
> > >    0:   nopl   0x0(%rax,%rax,1)
> > >    5:   xchg   %ax,%ax
> > >    7:   push   %rbp
> > >    8:   mov    %rsp,%rbp
> > >    b:   movzwq 0x4(%rdi),%rsi
> > >   10:   xor    %eax,%eax
> > >   12:   leave
> > >   13:   ret
> > > 
> > > 
> > > * size=2, offset=2, 0: (69) r2 = *(u16 *)(r1 +38)
> > > bpf_prog_4a6336c64a340b96:
> > >    0:   nopl   0x0(%rax,%rax,1)
> > >    5:   xchg   %ax,%ax
> > >    7:   push   %rbp
> > >    8:   mov    %rsp,%rbp
> > >    b:   movzwq 0x4(%rdi),%rsi
> > >   10:   shr    $0x10,%esi
> > >   13:   xor    %eax,%eax
> > >   15:   leave
> > >   16:   ret
> > > 
> > > Runtime checks for bpf_sk_lookup.remote_port load and the 2-bytes
> > > of
> > > zero padding following it, like below, pass with flying colors:
> > > 
> > >         ok = ctx->remote_port == bpf_htons(8008);
> > >         if (!ok)
> > >                 return SK_DROP;
> > >         ok = *((__u16 *)&ctx->remote_port + 1) == 0;
> > >         if (!ok)
> > >                 return SK_DROP;
> > > 
> > > (The above checks compile to half-word (2-byte) loads.)
> > > 
> > > 
> > > On BE (s390x) things look different:
> > > 
> > > Before the patch:
> > > 
> > > * size=2, offset=0, 0: (69) r2 = *(u16 *)(r1 +36)
> > >    0: (69) r2 = *(u16 *)(r1 +4)
> > >    1: (bc) w2 = w2
> > >    2: (b7) r0 = 0
> > >    3: (95) exit
> > > 
> > > * size=2, offset=2, 0: (69) r2 = *(u16 *)(r1 +38)
> > >    0: (69) r2 = *(u16 *)(r1 +4)
> > >    1: (bc) w2 = w2
> > >    2: (b7) r0 = 0
> > >    3: (95) exit
> > > 
> > > After the patch:
> > > 
> > > * size=2, offset=0, 0: (69) r2 = *(u16 *)(r1 +36)
> > >    0: (69) r2 = *(u16 *)(r1 +4)
> > >    1: (bc) w2 = w2
> > >    2: (74) w2 >>= 16
> > >    3: (bc) w2 = w2
> > >    4: (b7) r0 = 0
> > >    5: (95) exit
> > > 
> > > * size=2, offset=2, 0: (69) r2 = *(u16 *)(r1 +38)
> > >    0: (69) r2 = *(u16 *)(r1 +4)
> > >    1: (bc) w2 = w2
> > >    2: (b7) r0 = 0
> > >    3: (95) exit
> > > 
> > > These compile to:
> > > 
> > > * size=2, offset=0, 0: (69) r2 = *(u16 *)(r1 +36)
> > > bpf_prog_fdd58b8caca29f00:
> > >    0:   j       0x0000000000000006
> > >    4:   nopr
> > >    6:   stmg    %r11,%r15,112(%r15)
> > >    c:   la      %r13,64(%r15)
> > >   10:   aghi    %r15,-96
> > >   14:   llgh    %r3,4(%r2,%r0)
> > >   1a:   srl     %r3,16
> > >   1e:   llgfr   %r3,%r3
> > >   22:   lgfi    %r14,0
> > >   28:   lgr     %r2,%r14
> > >   2c:   lmg     %r11,%r15,208(%r15)
> > >   32:   br      %r14
> > > 
> > > 
> > > * size=2, offset=2, 0: (69) r2 = *(u16 *)(r1 +38)
> > > bpf_prog_5e3d8e92223c6841:
> > >    0:   j       0x0000000000000006
> > >    4:   nopr
> > >    6:   stmg    %r11,%r15,112(%r15)
> > >    c:   la      %r13,64(%r15)
> > >   10:   aghi    %r15,-96
> > >   14:   llgh    %r3,4(%r2,%r0)
> > >   1a:   lgfi    %r14,0
> > >   20:   lgr     %r2,%r14
> > >   24:   lmg     %r11,%r15,208(%r15)
> > >   2a:   br      %r14
> > > 
> > > Now, we right shift the value when loading
> > > 
> > >   *(u16 *)(r1 +36)
> > > 
> > > which in C BPF is equivalent to
> > > 
> > >   *((__u16 *)&ctx->remote_port + 0)
> > > 
> > > due to how the shift is calculated by
> > > bpf_ctx_narrow_access_offset().
> > 
> > Right, that's exactly the intention here.
> > The way I see the situation is: the ABI forces us to treat
> > remote_port
> > as a 32-bit field, even though the updated header now says
> > otherwise.
> > And this:
> > 
> >     unsigned int remote_port;
> >     unsigned short result = *(unsigned short *)remote_port;
> > 
> > should be the same as:
> > 
> >     unsigned short result = remote_port >> 16;
> > 
> > on big-endian. Note that this is inherently non-portable.
> 
> 
> 
> 
> 
> > 
> > > This makes the expected typical use-case
> > > 
> > >   ctx->remote_port == bpf_htons(8008)
> > > 
> > > fail on s390x because llgh (Load Logical Halfword (64<-16)) seems
> > > to
> > > lay
> > > out the data in the destination register so that it holds
> > > 0x0000_0000_0000_1f48.
> > > 
> > > I don't know that was the intention here, as it makes the BPF C
> > > code
> > > non-portable.
> > > 
> > > WDYT?
> > 
> > This depends on how we define the remote_port field. I would argue
> > that
> > the definition from patch 2 - even though ugly - is the correct
> > one.
> > It is consistent with both the little-endian (1f 48 00 00) and
> > big-endian (00 00 1f 48) ABIs.
> > 
> > I don't think the current definition is correct, because it expects
> > 1f 48 00 00 on big-endian, and this is not the case. We can verify
> > this
> > by taking 9a69e2^ and applying
> > 
> > --- a/tools/testing/selftests/bpf/progs/test_sk_lookup.c
> > +++ b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
> > @@ -417,6 +417,8 @@ int ctx_narrow_access(struct bpf_sk_lookup
> > *ctx)
> >                 return SK_DROP;
> >         if (LSW(ctx->remote_port, 0) != SRC_PORT)
> >                 return SK_DROP;
> > +       if (ctx->remote_port != SRC_PORT)
> > +               return SK_DROP;
> >  
> >         /* Narrow loads from local_port field. Expect DST_PORT. */
> >         if (LSB(ctx->local_port, 0) != ((DST_PORT >> 0) & 0xff) ||
> > 
> > Therefore that
> > 
> >   ctx->remote_port == bpf_htons(8008)
> > 
> > fails without patch 2 is as expected.
> > 
> 
> Consider this - today the below is true on both LE and BE, right?
> 
>   *(u32 *)&ctx->remote_port == *(u16 *)&ctx->remote_port
> 
> because the loads get converted to:
> 
>   *(u16 *)&ctx_kern->sport == *(u16 *)&ctx_kern->sport
> 
> IOW, today, because of the bug that you are fixing here, the data
> layout
> changes from the PoV of the BPF program depending on the load size.
> 
> With 2-byte loads, without this patch, the data layout appears as:
> 
>   struct bpf_sk_lookup {
>     ...
>     __be16 remote_port;
>     __be16 remote_port;
>     ...
>   }

I see, one can indeed argue that this is also a part of the ABI now.
So we're stuck between a rock and a hard place.

> While for 4-byte loads, it appears as in your 2nd patch:
> 
>   struct bpf_sk_lookup {
>     ...
>     #if little-endian
>     __be16 remote_port;
>     __u16  :16; /* zero padding */
>     #elif big-endian
>     __u16  :16; /* zero padding */
>     __be16 remote_port;
>     #endif
>     ...
>   }
> 
> Because of that I don't see how we could keep complete ABI
> compatiblity,
> and have just one definition of struct bpf_sk_lookup that reflects
> it. These are conflicting requirements.
> 
> I'd bite the bullet for 4-byte loads, for the sake of having an
> endian-agnostic struct bpf_sk_lookup and struct bpf_sock definition
> in
> the uAPI header.
> 
> The sacrifice here is that the access converter will have to keep
> rewriting 4-byte access to bpf_sk_lookup.remote_port and
> bpf_sock.dst_port in this unexpected, quirky manner.
> 
> The expectation is that with time users will recompile their BPF
> progs
> against the updated bpf.h, and switch to 2-byte loads. That will make
> the quirk in the access converter dead code in time.
> 
> I don't have any better ideas. Sorry.
> 
> [...]

I agree, let's go ahead with this solution.

The only remaining problem that I see is: the bug is in the common
code, and it will affect the fields that we add in the future.

Can we either document this state of things in a comment, or fix the
bug and emulate the old behavior for certain fields?
