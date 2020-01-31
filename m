Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E44914E6B8
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2020 01:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgAaAsS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jan 2020 19:48:18 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:41466 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbgAaAsS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jan 2020 19:48:18 -0500
Received: by mail-pg1-f178.google.com with SMTP id x8so2535954pgk.8
        for <bpf@vger.kernel.org>; Thu, 30 Jan 2020 16:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=EgZxLtpgr3sZZUhtxkApY0Q9KtzCH4siguGHO+iOr3w=;
        b=ogB21X/M7up2+BWR/x2+y9WYRtOPWumyw0N83TGhkxD9OEjxyPC0rL1wKTIRLGQO8W
         FZNLidpYlm2S0I8b1LCQ4jUDij9BE5zkzr0dG1eX6YMsTUluiAnOYztTrHfHCmqF8lMq
         /AI86fTt2vDEyj/lagaQs85FzjuQ1zz2KCwsfAjXn5ICokpDypMz+PXRbAzUTr8Rqipg
         71LfkN0Z0EqjWEhcH1NtDcc9VnMVjwov/89VS8ohmX8ut64G6WX97u7c0LUSHI8x6asp
         hR3w7t8f2HFpaFPkie4cCGsN8uJyKpw7hPaY0W9WXFtyNDSE+7R7Wg0MUP9kVc+RwB9d
         O+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=EgZxLtpgr3sZZUhtxkApY0Q9KtzCH4siguGHO+iOr3w=;
        b=YdcW5LQaoyFY6z/y2u64ng8Wj2O3q1/NsycGj3Snf2hLRLCocXKLZaPn4IFnOsjBvj
         7ssuAPStcEJZSv+Vg9hKSfdQ8q8eYbxfgVj8o66m3ZErOBHPO/etwH6JNHBgIa491dD2
         g4j8dJWZnsThQFkbSjFzUNd5Y+7oWWmznyQmu9rghJdk9/TkFDzhPOhc/6dkCdBuZfxO
         cbHCM5RLgOZgXe/JJ6jv3zkuNL3nxCznFgBwa2sRQL3BMx6/lYP5EWcbMhs7BOBWnl7h
         FTy01/W8/uwVIv+z4s3QuSkwwIkie5VK7ny07wQlZoI+ie+Pn2Y1xLEo6rFlpfiSiUe0
         Uhlw==
X-Gm-Message-State: APjAAAVU5qDjZGpY2jdHvc9mW4OOMk2Do1TVla+nBDGDIor5CuwdPCZU
        fyBOLxv8fSZ/c/7q3sSxbXU=
X-Google-Smtp-Source: APXvYqyeE3FSceyzpY/5VHRyrcoCng/jiMPdvC178M0sVNtYYp4hqAoEVFb7rA5nAVVCEYMEz2clsg==
X-Received: by 2002:a63:4416:: with SMTP id r22mr7482694pga.254.1580431697179;
        Thu, 30 Jan 2020 16:48:17 -0800 (PST)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id i68sm7888380pfe.173.2020.01.30.16.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 16:48:16 -0800 (PST)
Date:   Thu, 30 Jan 2020 16:48:09 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Message-ID: <5e33794983ffe_43212ac192b965bc78@john-XPS-13-9370.notmuch>
In-Reply-To: <096d8647-3dc7-6923-dcd3-9702aee2467a@fb.com>
References: <158015334199.28573.4940395881683556537.stgit@john-XPS-13-9370>
 <b26a97e0-6b02-db4b-03b3-58054bcb9b82@iogearbox.net>
 <CAADnVQ+YhgKLkVCsQeBmKWxfuT+4hiHAYte9Xnq8XpC8WedQXQ@mail.gmail.com>
 <99042fc3-0b02-73cb-56cd-fc9a4bfdf3ee@iogearbox.net>
 <5e320c9a30f64_2a332aadcd1385bc3f@john-XPS-13-9370.notmuch>
 <20200130000415.dwd7zn6wj7qlms7g@ast-mbp>
 <5e33147f55528_19152af196f745c460@john-XPS-13-9370.notmuch>
 <20200130175935.dauoijsxmbjpytjv@ast-mbp.dhcp.thefacebook.com>
 <5e336803b5773_752d2b0db487c5c06e@john-XPS-13-9370.notmuch>
 <096d8647-3dc7-6923-dcd3-9702aee2467a@fb.com>
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

Yonghong Song wrote:
> 
> 
> On 1/30/20 3:34 PM, John Fastabend wrote:
> > Alexei Starovoitov wrote:
> >> On Thu, Jan 30, 2020 at 09:38:07AM -0800, John Fastabend wrote:
> >>> Alexei Starovoitov wrote:
> >>>> On Wed, Jan 29, 2020 at 02:52:10PM -0800, John Fastabend wrote:
> >>>>> Daniel Borkmann wrote:
> >>>>>> On 1/29/20 8:28 PM, Alexei Starovoitov wrote:
> >>>>>>> On Wed, Jan 29, 2020 at 8:25 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >>>>>>>>>
> >>>>>>>>> Fixes: 849fa50662fbc ("bpf/verifier: refine retval R0 state for bpf_get_stack helper")
> >>>>>>>>> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> >>>>>>>>
> >>>>>>>> Applied, thanks!
> >>>>>>>
> >>>>>>> Daniel,
> >>>>>>> did you run the selftests before applying?
> >>>>>>> This patch breaks two.
> >>>>>>> We have to find a different fix.
> >>>>>>>
> >>>>>>> ./test_progs -t get_stack
> >>>>>>> 68: (85) call bpf_get_stack#67
> >>>>>>>    R0=inv(id=0,smax_value=800) R1_w=ctx(id=0,off=0,imm=0)
> >>>>>>> R2_w=map_value(id=0,off=0,ks=4,vs=1600,umax_value=4294967295,var_off=(0x0;
> >>>>>>> 0xffffffff)) R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0;
> >>>>>>> 0xffffffff)) R4_w=inv0 R6=ctx(id=0,off=0,im?
> >>>>>>> R2 unbounded memory access, make sure to bounds check any array access
> >>>>>>> into a map
> >>>>>>
> >>>>>> Sigh, had it in my wip pre-rebase tree when running tests. I've revert it from the
> >>>>>> tree since this needs to be addressed. Sorry for the trouble.
> >>>>>
> >>>>> Thanks I'm looking into it now. Not sure how I missed it on
> >>>>> selftests either older branch or I missed the test somehow. I've
> >>>>> updated toolchain and kernel now so shouldn't happen again.
> >>>>
> >>>> Looks like smax_value was nuked by <<32 >>32 shifts.
> >>>> 53: (bf) r8 = r0   // R0=inv(id=0,smax_value=800)
> >>>> 54: (67) r8 <<= 32  // R8->smax_value = S64_MAX; in adjust_scalar_min_max_vals()
> >>>> 55: (c7) r8 s>>= 32
> >>>> ; if (usize < 0)
> >>>> 56: (c5) if r8 s< 0x0 goto pc+28
> >>>> // and here "less than zero check" doesn't help anymore.
> >>>>
> >>>> Not sure how to fix it yet, but the code pattern used in
> >>>> progs/test_get_stack_rawtp.c
> >>>> is real. Plenty of bpf progs rely on this.
> >>>
> >>> OK I see what happened I have some patches on my llvm tree and forgot to
> >>> pop them off before running selftests :/ These <<=32 s>>=32 pattern pops up
> >>> in a few places for us and causes verifier trouble whenever it is hit.
> >>>
> >>> I think I have a fix for this in llvm, if that is OK. And we can make
> >>> the BPF_RSH and BPF_LSH verifier bounds tighter if we also define the
> >>> architecture expectation on the jit side. For example x86 jit code here,
> >>>
> >>> 146:   shl    $0x20,%rdi
> >>> 14a:   shr    $0x20,%rdi
> >>>
> >>> the shr will clear the most significant bit so we can say something about
> >>> the min sign value. I'll generate a couple patches today and send them
> >>> out to discuss. Probably easier to explain with code and examples.
> >>
> >> How about we detect this pattern on the verifier side and replace with
> >> pseudo insn that will do 32-bit sign extend. Most archs have special
> >> cpu instruction to do this much more efficiently than two shifts.
> >> If JIT doesn't implement that pseudo yet the verifier can convert
> >> it back to two shifts.
> >> Then during verification it will process pseudo_sign_extend op easily.
> >> So the idea:
> >> 1. pattern match sequence of two shifts in a pass similar to
> >>     replace_map_fd_with_map_ptr() before main do_check()
> >> 2. pseudo_sign_extend gets process in do_check() doing the right thing
> >>     with bpf_reg_state.
> >> 3. JIT this pseudo insn or convert back
> >>
> >> Long term we can upgrade this pseudo insn into uapi and let llvm emit it.
> > 
> > I'm not sure pattern matching in the verifier is best. This paticular
> > case of lsh/rsh games is the result of BPF backend generating it from
> > a LLVM IR zext.
> > 
> > Here is the LLVM IR generated from test_get_stack_rawtp that produces
> > the zext.
> > 
> > 
> >   %26 = call i32 inttoptr (i64 67 to i32 (i8*, i8*, i32, i64)*)(i8* %0, i8* nonnull %23, i32 800, i64 256) #3, !dbg !166
> >    call void @llvm.dbg.value(metadata i32 %26, metadata !124, metadata !DIExpression()), !dbg !130
> >    %27 = icmp slt i32 %26, 0, !dbg !167
> >    br i1 %27, label %41, label %28, !dbg !169
> > 
> > 28:                                               ; preds = %25
> >    %29 = zext i32 %26 to i64, !dbg !170
> >    %30 = getelementptr i8, i8* %23, i64 %29, !dbg !170
> > 
> > 
> > Clang wants to do zext because we are promoting a i32 to i64. In the
> > BPF backend code we pattern match this as follows,
> > 
> >   def : Pat<(i64 (zext GPR32:$src)),
> >             (SRL_ri (SLL_ri (MOV_32_64 GPR32:$src), 32), 32)>;
> > 
> > Which generates the object code (again from test_get_stack_rawtp),
> > 
> >        56:       bc 81 00 00 00 00 00 00 w1 = w8
> >        57:       67 01 00 00 20 00 00 00 r1 <<= 32
> >        58:       77 01 00 00 20 00 00 00 r1 >>= 32
> > 
> > Unfortunately, this is a pretty poor form of zext from the verifiers point
> > of view it completely nukes bounds as you observed. So how about doing
> > something a bit simpler from the backend side. Noting that moving 32bit
> > into 32bit zero-extends on x86 and we also make that assumption elsewhere
> > so it should be safe to implement the zext from above object dump as just
> > the mov
> > 
> >    w1 = w8
> > 
> > Which we can implement in the backend with this patch,
> > 
> > diff --git a/llvm/lib/Target/BPF/BPFInstrInfo.td b/llvm/lib/Target/BPF/BPFInstrInfo.td
> > index 0f39294..a187103 100644
> > --- a/llvm/lib/Target/BPF/BPFInstrInfo.td
> > +++ b/llvm/lib/Target/BPF/BPFInstrInfo.td
> > @@ -733,7 +733,7 @@ def : Pat<(i64 (sext GPR32:$src)),
> >             (SRA_ri (SLL_ri (MOV_32_64 GPR32:$src), 32), 32)>;
> >   
> >   def : Pat<(i64 (zext GPR32:$src)),
> > -          (SRL_ri (SLL_ri (MOV_32_64 GPR32:$src), 32), 32)>;
> > +          (MOV_32_64 GPR32:$src)>;
> >   
> > Now the new object code is simply,
> > 
> >        54:       c6 08 14 00 00 00 00 00 if w8 s< 0 goto +20 <LBB0_6>
> >        55:       1c 89 00 00 00 00 00 00 w9 -= w8
> >        56:       bc 81 00 00 00 00 00 00 w1 = w8
> >        57:       bf 72 00 00 00 00 00 00 r2 = r7
> >        58:       0f 12 00 00 00 00 00 00 r2 += r1
> >        59:       bf 61 00 00 00 00 00 00 r1 = r6
> >        60:       bc 93 00 00 00 00 00 00 w3 = w9
> >        61:       b7 04 00 00 00 00 00 00 r4 = 0
> >        62:       85 00 00 00 43 00 00 00 call 67
> > ;       if (ksize < 0)
> > 
> > That is the block from your originally trace. But one issue still
> > remains and just the above llvm backend update doesn't fix the verifier
> > problem created by my patch because in the false branch after line 54
> > above we don't have the right bounds.
> > 
> >   53: (bc) w8 = w0
> >   ; if (usize < 0)
> >   54: (c6) if w8 s< 0x0 goto pc+20
> >    R0=inv(id=0,smax_value=800) R6=ctx(id=0,off=0,imm=0) R7=map_value(id=0,off=0,ks=4,vs=1600,imm=0) R8_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R9=inv800 R10=fp0 fp-8=mmmm????
> >   ; ksize = bpf_get_stack(ctx, raw_data + usize, max_len - usize, 0);
> >   55: (1c) w9 -= w8
> >   ; ksize = bpf_get_stack(ctx, raw_data + usize, max_len - usize, 0);
> >   56: (bc) w1 = w8
> >   57: (bf) r2 = r7
> >   58: (0f) r2 += r1
> >    R0_rw=invP(id=0,smax_value=800) R6=ctx(id=0,off=0,imm=0) R7_rw=map_value(id=0,off=0,ks=4,vs=1600,imm=0) R9_rw=inv800 R10=fp0 fp-8=mmmm????
> >   parent didn't have regs=1 stack=0 marks
> >   last_idx 52 first_idx 40
> >   regs=1 stack=0 before 52: (85) call bpf_get_stack#67
> >   ; ksize = bpf_get_stack(ctx, raw_data + usize, max_len - usize, 0);
> >   59: (bf) r1 = r6
> >   60: (bc) w3 = w9
> >   61: (b7) r4 = 0
> >   62: (85) call bpf_get_stack#67
> > 
> > At line :54 R0 has bounds [SMIN, 800] which by 53: are the bounds in
> > w8 remembering a load will zero extend there.  So we should expect
> > the false branch to have bounds [0, 800] exactly as we want. But,
> > we instead got only a umax_value? Digging deeper we are failing here,
> > 
> >   /* Return true if VAL is compared with a s64 sign extended from s32, and they
> >    * are with the same signedness.
> >    */
> >   static bool cmp_val_with_extended_s64(s64 sval, struct bpf_reg_state *reg)
> >   {
> >           return ((s32)sval >= 0 &&
> >                   reg->smin_value >= 0 && reg->smax_value <= S32_MAX) ||
> >                  ((s32)sval < 0 &&
> >                   reg->smax_value <= 0 && reg->smin_value >= S32_MIN);
> >   }
> > 
> > This appears to conservative. I'll need to analyze that a bit but it
> > should be safe to relax to catch above <0 case. After that I expect
> > we should be passing again.
> 
> Yes, this is the place I have problem as well. In my case, the top 32bit 
> bit may not be 0, it will be somehow magically cleared later through
> w_x = w_y style ALU operations.

The w_x = w_y MOV can be improved as well a bit and this helps my case.
Needs some more thought but roughly coerce_reg_to_size called from
MOV can do better with max bound. At the moment it loses all knowledge
of previous bounds checks on the move becuase of the smax_value=umax_value
below,

static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
{
	u64 mask;

	/* clear high bits in bit representation */
	reg->var_off = tnum_cast(reg->var_off, size);

	/* fix arithmetic bounds */
	mask = ((u64)1 << (size * 8)) - 1;
	if ((reg->umin_value & ~mask) == (reg->umax_value & ~mask)) {
		reg->umin_value &= mask;
		reg->umax_value &= mask;
	} else {
		reg->umin_value = 0;
		reg->umax_value = mask;
	}
	reg->smin_value = reg->umin_value;
	reg->smax_value = reg->umax_value;
}

I believe smax_value can likely be max(reg->smax_value, reg->umax_value)
but need to check. (assuming smax_value < UMAX_32) I need to drop off for
tonight but will dig into it tomorrow.

> 
> > 
> > Sorry for the long thread but those are the details. What do you think,
> > in the meantime I'll generate the relaxed bounds on cmp_val_with_extended
> > and see what we can cook up with Daniel. It avoid pseudo instructions
> > and pattern matching which I think is a bit more general.
> > 
> > Thanks,
> > John
> > 


