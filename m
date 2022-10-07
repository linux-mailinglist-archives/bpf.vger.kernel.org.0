Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C562F5F7320
	for <lists+bpf@lfdr.de>; Fri,  7 Oct 2022 05:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJGDOw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 23:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGDOv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 23:14:51 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB53D74
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 20:14:49 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296NpG8b026457
        for <bpf@vger.kernel.org>; Thu, 6 Oct 2022 20:14:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=K7EhKuI1jbG4ViOU0aqv120DXkowl7BJzEUSz3phvmw=;
 b=AGEvCchW6put5LxqapYeNv3QjBswjcFQXroF6dCRPaSZscb3kLK1pW7irHFm0cDGErj1
 svM9zft2RFerUUis0c/UF4lG4TxPNjpgkfRBZXiM5tDu5IEFE/tEAUfEH5A3ySzLJqXp
 iBZ5Ngfrkz1amf+b/JKnzHNkq0BOObYdwgA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k26gy1yw3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Oct 2022 20:14:48 -0700
Received: from twshared20183.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 20:14:46 -0700
Received: by devbig150.prn5.facebook.com (Postfix, from userid 187975)
        id CB4441138DF1C; Thu,  6 Oct 2022 20:14:35 -0700 (PDT)
Date:   Thu, 6 Oct 2022 20:14:35 -0700
From:   Jie Meng <jmeng@fb.com>
To:     KP Singh <kpsingh@kernel.org>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v4 2/3] bpf,x64: use shrx/sarx/shlx when
 available
Message-ID: <Yz+Zm6qar+nWrLZs@fb.com>
References: <20220927185801.1824838-1-jmeng@fb.com>
 <20221002051143.831029-1-jmeng@fb.com>
 <20221002051143.831029-3-jmeng@fb.com>
 <CACYkzJ4RvEZVp5-sybdn2tOuV-h6KyGJRjvEMZWBoqTBVrK1aQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACYkzJ4RvEZVp5-sybdn2tOuV-h6KyGJRjvEMZWBoqTBVrK1aQ@mail.gmail.com>
X-FB-Internal: Safe
X-Proofpoint-GUID: Mp8oJSJt-TQ82pXCL5kJCnDED_OHl0oQ
X-Proofpoint-ORIG-GUID: Mp8oJSJt-TQ82pXCL5kJCnDED_OHl0oQ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-06_02,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 05, 2022 at 09:11:01PM -0700, KP Singh wrote:
> On Sat, Oct 1, 2022 at 10:12 PM Jie Meng <jmeng@fb.com> wrote:
> >
> > Instead of shr/sar/shl that implicitly use %cl, emit their more flexible
> > alternatives provided in BMI2 when advantageous; keep using the non BMI2
> > instructions when shift count is already in BPF_REG_4/rcx as non BMI2
> > instructions are shorter.
> 
> This is confusing, you mention %CL in the first sentence and then RCX in the
> second sentence. Can you clarify this more here?

%cl is the lowest 8 bit of %rcx. In assembly, non BMI2 shifts with shift
count in register is written as

 SHR eax, cl

Although the use of CL is mandatory and if the shift count is in another
register it has to be moved into RCX first, unless of course when the
shift count is already in BPF_REG_4, which is mapped to RCX in x86-64.

It is indeed awkward but exactly what one would see in assembly: a MOV
to RCX and a shift that uses CL as the source register.

> 
> Also, It would be good to have some explanations about the
> performance benefits here as well.
> 
> i.e. a load + store + non vector instruction v/s a single vector instruction
> omitting the load. How many cycles do we expect in each case, I do expect the
> latter to be lesser, but mentioning it in the commit removes any ambiguity.

Although it uses similar encoding as AVX instructions BMI2 actually
operates on general purpose registers and no vector register is ever
involved [1]. Inside a CPU all shifts instructions (both baseline and BMI2
flavors) are almost always handled by the same units and have the same
latency and throughput [2].

[1] https://en.wikipedia.org/wiki/X86_Bit_manipulation_instruction_set
[2] https://www.agner.org/optimize/instruction_tables.pdf
> 
> >
> > To summarize, when BMI2 is available:
> > -------------------------------------------------
> >             |   arbitrary dst
> > =================================================
> > src == ecx  |   shl dst, cl
> > -------------------------------------------------
> > src != ecx  |   shlx dst, dst, src
> > -------------------------------------------------
> >
> > A concrete example between non BMI2 and BMI2 codegen.  To shift %rsi by
> > %rdi:
> >
> > Without BMI2:
> >
> >  ef3:   push   %rcx
> >         51
> >  ef4:   mov    %rdi,%rcx
> >         48 89 f9
> >  ef7:   shl    %cl,%rsi
> >         48 d3 e6
> >  efa:   pop    %rcx
> >         59
> >
> > With BMI2:
> >
> >  f0b:   shlx   %rdi,%rsi,%rsi
> >         c4 e2 c1 f7 f6
> >
> > Signed-off-by: Jie Meng <jmeng@fb.com>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 64 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index d9ba997c5891..d09c54f3d2e0 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -889,6 +889,48 @@ static void emit_nops(u8 **pprog, int len)
> >         *pprog = prog;
> >  }
> >
> > +/* emit the 3-byte VEX prefix */
> > +static void emit_3vex(u8 **pprog, bool r, bool x, bool b, u8 m,
> > +                     bool w, u8 src_reg2, bool l, u8 p)
> 
> Can you please use somewhat more descriptive variable names here?
> 
> or add more information about what x, b, m, w, l and p mean?

Apart from src_reg2, the rest is the same as what Intel has chosen to
name the various fields in the VEX prefix. Would rather keep them 
consistent so that people won't get confused when comparing with other
documents across the Internet.
> 
> > +{
> > +       u8 *prog = *pprog;
> > +       u8 b0 = 0xc4, b1, b2;
> > +       u8 src2 = reg2hex[src_reg2];
> > +
> > +       if (is_ereg(src_reg2))
> > +               src2 |= 1 << 3;
> > +
> > +       /*
> > +        *    7                           0
> > +        *  +---+---+---+---+---+---+---+---+
> > +        *  |~R |~X |~B |         m         |
> > +        *  +---+---+---+---+---+---+---+---+
> > +        */
> > +       b1 = (!r << 7) | (!x << 6) | (!b << 5) | (m & 0x1f);
> 
> Some explanation here would help, not everyone is aware of x86 vex encoding :)

The comment is the exact rule how different pieces of information is
encoded into the 3-byte VEX prefix i.e. their position and length, and
whether a field needs to be bit inverted. Combined with code the comment
should give one clear idea what the intent is here.
> 
> > +       /*
> > +        *    7                           0
> > +        *  +---+---+---+---+---+---+---+---+
> > +        *  | W |     ~vvvv     | L |   pp  |
> > +        *  +---+---+---+---+---+---+---+---+
> > +        */
> > +       b2 = (w << 7) | ((~src2 & 0xf) << 3) | (l << 2) | (p & 3);
> > +
> > +       EMIT3(b0, b1, b2);
> > +       *pprog = prog;
> > +}
> > +
> > +/* emit BMI2 shift instruction */
> > +static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
> > +{
> > +       u8 *prog = *pprog;
> > +       bool r = is_ereg(dst_reg);
> > +       u8 m = 2; /* escape code 0f38 */
> > +
> > +       emit_3vex(&prog, r, false, r, m, is64, src_reg, false, op);
> > +       EMIT2(0xf7, add_2reg(0xC0, dst_reg, dst_reg));
> > +       *pprog = prog;
> > +}
> > +
> >  #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
> >
> >  static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
> > @@ -1135,6 +1177,28 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
> >                 case BPF_ALU64 | BPF_LSH | BPF_X:
> >                 case BPF_ALU64 | BPF_RSH | BPF_X:
> >                 case BPF_ALU64 | BPF_ARSH | BPF_X:
> > +                       /* BMI2 shifts aren't better when shift count is already in rcx */
> > +                       if (boot_cpu_has(X86_FEATURE_BMI2) && src_reg != BPF_REG_4) {
> > +                               /* shrx/sarx/shlx dst_reg, dst_reg, src_reg */
> > +                               bool w = (BPF_CLASS(insn->code) == BPF_ALU64);
> > +                               u8 op;
> > +
> > +                               switch (BPF_OP(insn->code)) {
> > +                               case BPF_LSH:
> > +                                       op = 1; /* prefix 0x66 */
> > +                                       break;
> > +                               case BPF_RSH:
> > +                                       op = 3; /* prefix 0xf2 */
> > +                                       break;
> > +                               case BPF_ARSH:
> > +                                       op = 2; /* prefix 0xf3 */
> > +                                       break;
> > +                               }
> > +
> > +                               emit_shiftx(&prog, dst_reg, src_reg, w, op);
> > +
> > +                               break;
> > +                       }
> >
> >                         if (src_reg != BPF_REG_4) { /* common case */
> >                                 /* Check for bad case when dst_reg == rcx */
> > --
> > 2.30.2
> >
