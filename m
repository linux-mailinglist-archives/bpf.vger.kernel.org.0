Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00A2814E620
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2020 00:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgA3Xek (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jan 2020 18:34:40 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43836 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgA3Xek (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jan 2020 18:34:40 -0500
Received: by mail-pg1-f195.google.com with SMTP id u131so2445088pgc.10
        for <bpf@vger.kernel.org>; Thu, 30 Jan 2020 15:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=2AVlLBSRwfHOud/2jXz/QvKpWZuxnxBzfHA963Dgy+Y=;
        b=TYDFdnlqz03ti5YEPegAHHEQFA5F2dzyifVOIMDoJvYVAEQqS0DeQsKuu+ljbd/Rqo
         DuUflMObFqLOil0sY/Pi2rIz5BEdZcLLuSLKSAciffAIvlwlSaqVqFOT+YseKxi33fA7
         cEpEAk7gJ0VtZSTsLG1BnP0DTFqbqA5pSPTBtn1ry6mLO9O9FKbyHTyTQify6j424lWm
         1OJR3nIWBoXa94FkKj3CYtrw6eIxLDHlGDFBvND7IJ2lf9zC1ZE5wPi4pcHRehMceoXA
         1KjAVLosoXDMz1YcggVVa816oBgx2WcVDOK3HV/aTyguOe4ZAh7v0TOmFNnuqXpBZUG0
         LzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=2AVlLBSRwfHOud/2jXz/QvKpWZuxnxBzfHA963Dgy+Y=;
        b=ZrO2jUwU1oa/f0cvxAFfHHbRhwqbn1mXQ8na5YVqUEgpK3VkU5oT0WZRKo/orvZncF
         JrmpIGDZHf2DW4+M1T70kOrpPaWUPXLuAb1WnHlNrzUJO5z26GV4tv8LRxZyDfXLUI8b
         kFyBGOlMo9NhWeBinWvQdi/Fs6G+Z6esCD0jI2bfw/wy1MhZ+mAm7UKgV7NpG2qDm3/T
         1baQULBQmLoBt3JfcQJWHRBOzZVZBvPAl7d2Snx/5UImhuiy3+ySQz1Dwcmd/x8BqCH9
         KvWARUKPoB86NpOdf0jAaw+RxGALlevULZQ85RcIwi2V69zYEjsLD6D1wncf/8KaZMrD
         VPVQ==
X-Gm-Message-State: APjAAAXzI5vKZ2of04UB4JWIOCPslkslxKb2on3t1GcCjciAtlyiRpBG
        bwDqxpgK+QfN8cUjFPWYWpI=
X-Google-Smtp-Source: APXvYqx9ym14skZCN8LlpMpwUcTjDqRTw2J9t0E4+KC849ABl2sQJr1i6G+Xk78HpI+wd8TDO6wPkA==
X-Received: by 2002:a63:e409:: with SMTP id a9mr7138027pgi.108.1580427278885;
        Thu, 30 Jan 2020 15:34:38 -0800 (PST)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id a69sm7927831pfa.129.2020.01.30.15.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 15:34:38 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:34:27 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>
Message-ID: <5e336803b5773_752d2b0db487c5c06e@john-XPS-13-9370.notmuch>
In-Reply-To: <20200130175935.dauoijsxmbjpytjv@ast-mbp.dhcp.thefacebook.com>
References: <158015334199.28573.4940395881683556537.stgit@john-XPS-13-9370>
 <b26a97e0-6b02-db4b-03b3-58054bcb9b82@iogearbox.net>
 <CAADnVQ+YhgKLkVCsQeBmKWxfuT+4hiHAYte9Xnq8XpC8WedQXQ@mail.gmail.com>
 <99042fc3-0b02-73cb-56cd-fc9a4bfdf3ee@iogearbox.net>
 <5e320c9a30f64_2a332aadcd1385bc3f@john-XPS-13-9370.notmuch>
 <20200130000415.dwd7zn6wj7qlms7g@ast-mbp>
 <5e33147f55528_19152af196f745c460@john-XPS-13-9370.notmuch>
 <20200130175935.dauoijsxmbjpytjv@ast-mbp.dhcp.thefacebook.com>
Subject: Re: [bpf PATCH v3] bpf: verifier, do_refine_retval_range may clamp
 umin to 0 incorrectly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov wrote:
> On Thu, Jan 30, 2020 at 09:38:07AM -0800, John Fastabend wrote:
> > Alexei Starovoitov wrote:
> > > On Wed, Jan 29, 2020 at 02:52:10PM -0800, John Fastabend wrote:
> > > > Daniel Borkmann wrote:
> > > > > On 1/29/20 8:28 PM, Alexei Starovoitov wrote:
> > > > > > On Wed, Jan 29, 2020 at 8:25 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > > > > >>>
> > > > > >>> Fixes: 849fa50662fbc ("bpf/verifier: refine retval R0 state for bpf_get_stack helper")
> > > > > >>> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> > > > > >>
> > > > > >> Applied, thanks!
> > > > > > 
> > > > > > Daniel,
> > > > > > did you run the selftests before applying?
> > > > > > This patch breaks two.
> > > > > > We have to find a different fix.
> > > > > > 
> > > > > > ./test_progs -t get_stack
> > > > > > 68: (85) call bpf_get_stack#67
> > > > > >   R0=inv(id=0,smax_value=800) R1_w=ctx(id=0,off=0,imm=0)
> > > > > > R2_w=map_value(id=0,off=0,ks=4,vs=1600,umax_value=4294967295,var_off=(0x0;
> > > > > > 0xffffffff)) R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0;
> > > > > > 0xffffffff)) R4_w=inv0 R6=ctx(id=0,off=0,im?
> > > > > > R2 unbounded memory access, make sure to bounds check any array access
> > > > > > into a map
> > > > > 
> > > > > Sigh, had it in my wip pre-rebase tree when running tests. I've revert it from the
> > > > > tree since this needs to be addressed. Sorry for the trouble.
> > > > 
> > > > Thanks I'm looking into it now. Not sure how I missed it on
> > > > selftests either older branch or I missed the test somehow. I've
> > > > updated toolchain and kernel now so shouldn't happen again.
> > > 
> > > Looks like smax_value was nuked by <<32 >>32 shifts.
> > > 53: (bf) r8 = r0   // R0=inv(id=0,smax_value=800)
> > > 54: (67) r8 <<= 32  // R8->smax_value = S64_MAX; in adjust_scalar_min_max_vals()
> > > 55: (c7) r8 s>>= 32
> > > ; if (usize < 0)
> > > 56: (c5) if r8 s< 0x0 goto pc+28
> > > // and here "less than zero check" doesn't help anymore.
> > > 
> > > Not sure how to fix it yet, but the code pattern used in
> > > progs/test_get_stack_rawtp.c
> > > is real. Plenty of bpf progs rely on this.
> > 
> > OK I see what happened I have some patches on my llvm tree and forgot to
> > pop them off before running selftests :/ These <<=32 s>>=32 pattern pops up
> > in a few places for us and causes verifier trouble whenever it is hit.
> > 
> > I think I have a fix for this in llvm, if that is OK. And we can make
> > the BPF_RSH and BPF_LSH verifier bounds tighter if we also define the
> > architecture expectation on the jit side. For example x86 jit code here,
> > 
> > 146:   shl    $0x20,%rdi
> > 14a:   shr    $0x20,%rdi
> > 
> > the shr will clear the most significant bit so we can say something about
> > the min sign value. I'll generate a couple patches today and send them
> > out to discuss. Probably easier to explain with code and examples.
> 
> How about we detect this pattern on the verifier side and replace with
> pseudo insn that will do 32-bit sign extend. Most archs have special
> cpu instruction to do this much more efficiently than two shifts.
> If JIT doesn't implement that pseudo yet the verifier can convert
> it back to two shifts.
> Then during verification it will process pseudo_sign_extend op easily.
> So the idea:
> 1. pattern match sequence of two shifts in a pass similar to
>    replace_map_fd_with_map_ptr() before main do_check()
> 2. pseudo_sign_extend gets process in do_check() doing the right thing
>    with bpf_reg_state.
> 3. JIT this pseudo insn or convert back
> 
> Long term we can upgrade this pseudo insn into uapi and let llvm emit it.

I'm not sure pattern matching in the verifier is best. This paticular
case of lsh/rsh games is the result of BPF backend generating it from
a LLVM IR zext.

Here is the LLVM IR generated from test_get_stack_rawtp that produces
the zext.


 %26 = call i32 inttoptr (i64 67 to i32 (i8*, i8*, i32, i64)*)(i8* %0, i8* nonnull %23, i32 800, i64 256) #3, !dbg !166
  call void @llvm.dbg.value(metadata i32 %26, metadata !124, metadata !DIExpression()), !dbg !130
  %27 = icmp slt i32 %26, 0, !dbg !167
  br i1 %27, label %41, label %28, !dbg !169

28:                                               ; preds = %25
  %29 = zext i32 %26 to i64, !dbg !170
  %30 = getelementptr i8, i8* %23, i64 %29, !dbg !170


Clang wants to do zext because we are promoting a i32 to i64. In the
BPF backend code we pattern match this as follows,

 def : Pat<(i64 (zext GPR32:$src)),
           (SRL_ri (SLL_ri (MOV_32_64 GPR32:$src), 32), 32)>;

Which generates the object code (again from test_get_stack_rawtp),

      56:       bc 81 00 00 00 00 00 00 w1 = w8
      57:       67 01 00 00 20 00 00 00 r1 <<= 32
      58:       77 01 00 00 20 00 00 00 r1 >>= 32

Unfortunately, this is a pretty poor form of zext from the verifiers point
of view it completely nukes bounds as you observed. So how about doing
something a bit simpler from the backend side. Noting that moving 32bit
into 32bit zero-extends on x86 and we also make that assumption elsewhere
so it should be safe to implement the zext from above object dump as just
the mov

  w1 = w8

Which we can implement in the backend with this patch,

diff --git a/llvm/lib/Target/BPF/BPFInstrInfo.td b/llvm/lib/Target/BPF/BPFInstrInfo.td
index 0f39294..a187103 100644
--- a/llvm/lib/Target/BPF/BPFInstrInfo.td
+++ b/llvm/lib/Target/BPF/BPFInstrInfo.td
@@ -733,7 +733,7 @@ def : Pat<(i64 (sext GPR32:$src)),
           (SRA_ri (SLL_ri (MOV_32_64 GPR32:$src), 32), 32)>;
 
 def : Pat<(i64 (zext GPR32:$src)),
-          (SRL_ri (SLL_ri (MOV_32_64 GPR32:$src), 32), 32)>;
+          (MOV_32_64 GPR32:$src)>;
 
Now the new object code is simply,

      54:       c6 08 14 00 00 00 00 00 if w8 s< 0 goto +20 <LBB0_6>
      55:       1c 89 00 00 00 00 00 00 w9 -= w8
      56:       bc 81 00 00 00 00 00 00 w1 = w8
      57:       bf 72 00 00 00 00 00 00 r2 = r7
      58:       0f 12 00 00 00 00 00 00 r2 += r1
      59:       bf 61 00 00 00 00 00 00 r1 = r6
      60:       bc 93 00 00 00 00 00 00 w3 = w9
      61:       b7 04 00 00 00 00 00 00 r4 = 0
      62:       85 00 00 00 43 00 00 00 call 67
;       if (ksize < 0)

That is the block from your originally trace. But one issue still 
remains and just the above llvm backend update doesn't fix the verifier
problem created by my patch because in the false branch after line 54
above we don't have the right bounds.

 53: (bc) w8 = w0
 ; if (usize < 0)
 54: (c6) if w8 s< 0x0 goto pc+20
  R0=inv(id=0,smax_value=800) R6=ctx(id=0,off=0,imm=0) R7=map_value(id=0,off=0,ks=4,vs=1600,imm=0) R8_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R9=inv800 R10=fp0 fp-8=mmmm????
 ; ksize = bpf_get_stack(ctx, raw_data + usize, max_len - usize, 0);
 55: (1c) w9 -= w8
 ; ksize = bpf_get_stack(ctx, raw_data + usize, max_len - usize, 0);
 56: (bc) w1 = w8
 57: (bf) r2 = r7
 58: (0f) r2 += r1
  R0_rw=invP(id=0,smax_value=800) R6=ctx(id=0,off=0,imm=0) R7_rw=map_value(id=0,off=0,ks=4,vs=1600,imm=0) R9_rw=inv800 R10=fp0 fp-8=mmmm????
 parent didn't have regs=1 stack=0 marks
 last_idx 52 first_idx 40
 regs=1 stack=0 before 52: (85) call bpf_get_stack#67
 ; ksize = bpf_get_stack(ctx, raw_data + usize, max_len - usize, 0);
 59: (bf) r1 = r6
 60: (bc) w3 = w9
 61: (b7) r4 = 0
 62: (85) call bpf_get_stack#67

At line :54 R0 has bounds [SMIN, 800] which by 53: are the bounds in
w8 remembering a load will zero extend there.  So we should expect
the false branch to have bounds [0, 800] exactly as we want. But,
we instead got only a umax_value? Digging deeper we are failing here,

 /* Return true if VAL is compared with a s64 sign extended from s32, and they
  * are with the same signedness.
  */
 static bool cmp_val_with_extended_s64(s64 sval, struct bpf_reg_state *reg)
 {
         return ((s32)sval >= 0 &&
                 reg->smin_value >= 0 && reg->smax_value <= S32_MAX) ||
                ((s32)sval < 0 &&
                 reg->smax_value <= 0 && reg->smin_value >= S32_MIN);
 }

This appears to conservative. I'll need to analyze that a bit but it
should be safe to relax to catch above <0 case. After that I expect
we should be passing again.

Sorry for the long thread but those are the details. What do you think,
in the meantime I'll generate the relaxed bounds on cmp_val_with_extended
and see what we can cook up with Daniel. It avoid pseudo instructions
and pattern matching which I think is a bit more general.

Thanks,
John
