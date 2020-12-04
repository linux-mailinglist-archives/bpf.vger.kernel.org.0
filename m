Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379422CEADC
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 10:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgLDJ1F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 04:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgLDJ1E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Dec 2020 04:27:04 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96372C061A51
        for <bpf@vger.kernel.org>; Fri,  4 Dec 2020 01:26:24 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id e7so4611554wrv.6
        for <bpf@vger.kernel.org>; Fri, 04 Dec 2020 01:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9pMWWb/VCnNKsHriDEzR7pD1e4vHSeg0rLJmEH7HfEc=;
        b=VTwa/kqWR41TAGUJhuvwixPHSRqhMTPs8Ch2dlkj7/hi8Ja5YkWwgAMcTVutfzuQb4
         k3nvJVizQelY+QUtaZH6KdyznCLJBvkwpmi8ZhmvHQv8ZvUifaAQM8HVw1g9+LqedfQE
         T/5KgF4N+Le7IBD6iX/wczcixf4/baEBEkcfVVKaFrENoBp0XGlifalBCt2VASbdS2+U
         /0Q1SK1oKpGPkcEOCddP2Xyeg20rK+p3RYS2GnE9pIPwSMPLuFRiKl7qakkAMVLTmPne
         Wk+JSyqCZpjuJjqEOMwje8KFdAvK7p9QHAV7MiZ8wr7UapEY5wevbDPlfYc+Hpb3dMbc
         0AvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9pMWWb/VCnNKsHriDEzR7pD1e4vHSeg0rLJmEH7HfEc=;
        b=EWQB1SWgsJmKLHpD7t3j3zybZyzNntyVAZqXo7yDbuEnGs1G0Km2Hxyu3EHHezmRX5
         BbHPLTLLBDLt11bScO3d9Ykn/xi2tc8oToPQ5zLSf/bZ8FsSJTG4zONzmSEPCR4hgl7e
         ZHVcGujN+pyuwbxvD5xewXucVyWex897HmlyXwrlVRpqgQz7Laoc2NqwzC+yDqIERQdh
         MzWZmHjGMnbsQkdufQbWUcJXixsa6a4Tp4pI11GZp2jZejQ9bgq/euQ8gvjD9XHKHBY8
         qg5+3PpXVqqJZs9zSkXpiDU/rHI4k7S6RPpQGJip2EeLPDbyakI8rErBM5U+gVWAyDMt
         Fx/A==
X-Gm-Message-State: AOAM533Ts3YZ3lRtd5MSYUjwMg3HTClxqbLd8XwQ7xbjUJLG0m6j9BpG
        l3gGlwRmNAfRmhMr3B2DB4KMh1z9ESNHSg==
X-Google-Smtp-Source: ABdhPJwDCBsw1YN3Ch47EyvemKgHJgFecprqKWTrGWyGAjnni2MJZ070PRWU+yvdOzou5hq5okPR9A==
X-Received: by 2002:a5d:630b:: with SMTP id i11mr3934909wru.404.1607073982940;
        Fri, 04 Dec 2020 01:26:22 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id g18sm3095245wrp.63.2020.12.04.01.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 01:26:22 -0800 (PST)
Date:   Fri, 4 Dec 2020 09:26:18 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v3 08/14] bpf: Add instructions for
 atomic_[cmp]xchg
Message-ID: <X8oAuo7HB/2XvP4g@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-9-jackmanb@google.com>
 <34cf7a6e-4e97-9895-6dca-b38e631599b9@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34cf7a6e-4e97-9895-6dca-b38e631599b9@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

O Thu, Dec 03, 2020 at 09:34:23PM -0800, Yonghong Song wrote:
> On 12/3/20 8:02 AM, Brendan Jackman wrote:
> > This adds two atomic opcodes, both of which include the BPF_FETCH
> > flag. XCHG without the BPF_FETCh flag would naturally encode
> 
> BPF_FETCh => BPF_FETCH

Thanks, sorry I think you've already pointed that one out and I didn't fix it!

> > atomic_set. This is not supported because it would be of limited
> > value to userspace (it doesn't imply any barriers). CMPXCHG without
> > BPF_FETCH woulud be an atomic compare-and-write. We don't have such
> > an operation in the kernel so it isn't provided to BPF either.
> > 
> > There are two significant design decisions made for the CMPXCHG
> > instruction:
> > 
> >   - To solve the issue that this operation fundamentally has 3
> >     operands, but we only have two register fields. Therefore the
> >     operand we compare against (the kernel's API calls it 'old') is
> >     hard-coded to be R0. x86 has similar design (and A64 doesn't
> >     have this problem).
> > 
> >     A potential alternative might be to encode the other operand's
> >     register number in the immediate field.
> > 
> >   - The kernel's atomic_cmpxchg returns the old value, while the C11
> >     userspace APIs return a boolean indicating the comparison
> >     result. Which should BPF do? A64 returns the old value. x86 returns
> >     the old value in the hard-coded register (and also sets a
> >     flag). That means return-old-value is easier to JIT.
> > 
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> 
> Ack with minor comments in the above and below.

Thanks, ack to all the comments.

Have run a `grep -r "atomic_.*(\*" *.patch` - hopefully we're now free
of this mistake where the first arg is dereferenced in the
comments/disasm...

> Acked-by: Yonghong Song <yhs@fb.com>
> 
> > Change-Id: I3f19ad867dfd08515eecf72674e6fdefe28424bb
> > ---
> >   arch/x86/net/bpf_jit_comp.c    |  8 ++++++++
> >   include/linux/filter.h         | 20 ++++++++++++++++++++
> >   include/uapi/linux/bpf.h       |  4 +++-
> >   kernel/bpf/core.c              | 20 ++++++++++++++++++++
> >   kernel/bpf/disasm.c            | 15 +++++++++++++++
> >   kernel/bpf/verifier.c          | 19 +++++++++++++++++--
> >   tools/include/linux/filter.h   | 20 ++++++++++++++++++++
> >   tools/include/uapi/linux/bpf.h |  4 +++-
> >   8 files changed, 106 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 88cb09fa3bfb..7d29bc3bb4ff 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -831,6 +831,14 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
> >   		/* src_reg = atomic_fetch_add(*(dst_reg + off), src_reg); */
> >   		EMIT2(0x0F, 0xC1);
> >   		break;
> > +	case BPF_XCHG:
> > +		/* src_reg = atomic_xchg(*(u32/u64*)(dst_reg + off), src_reg); */
> 
> src_reg = atomic_xchg((u32/u64*)(dst_reg + off), src_reg)?
> 
> > +		EMIT1(0x87);
> > +		break;
> > +	case BPF_CMPXCHG:
> > +		/* r0 = atomic_cmpxchg(*(u32/u64*)(dst_reg + off), r0, src_reg); */
> 
> r0 = atomic_cmpxchg((u32/u64*)(dst_reg + off), r0, src_reg)?
> 
> > +		EMIT2(0x0F, 0xB1);
> > +		break;
> >   	default:
> >   		pr_err("bpf_jit: unknown atomic opcode %02x\n", atomic_op);
> >   		return -EFAULT;
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index 4e04d0fc454f..6186280715ed 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -280,6 +280,26 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
> >   		.off   = OFF,					\
> >   		.imm   = BPF_ADD | BPF_FETCH })
> > +/* Atomic exchange, src_reg = atomic_xchg((dst_reg + off), src_reg) */
> 
> src_reg = atomic_xchg(dst_reg + off, src_reg)?
> 
> > +
> > +#define BPF_ATOMIC_XCHG(SIZE, DST, SRC, OFF)			\
> > +	((struct bpf_insn) {					\
> > +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> > +		.dst_reg = DST,					\
> > +		.src_reg = SRC,					\
> > +		.off   = OFF,					\
> > +		.imm   = BPF_XCHG  })
> > +
> > +/* Atomic compare-exchange, r0 = atomic_cmpxchg((dst_reg + off), r0, src_reg) */
> 
> r0 = atomic_cmpxchg(dst_reg + off, r0, src_reg)?
> 
> > +
> > +#define BPF_ATOMIC_CMPXCHG(SIZE, DST, SRC, OFF)			\
> > +	((struct bpf_insn) {					\
> > +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> > +		.dst_reg = DST,					\
> > +		.src_reg = SRC,					\
> > +		.off   = OFF,					\
> > +		.imm   = BPF_CMPXCHG })
> > +
> >   /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
> >   #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 025e377e7229..53334530cc81 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -45,7 +45,9 @@
> >   #define BPF_EXIT	0x90	/* function return */
> >   /* atomic op type fields (stored in immediate) */
> > -#define BPF_FETCH	0x01	/* fetch previous value into src reg */
> > +#define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
> > +#define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
> > +#define BPF_FETCH	0x01	/* not an opcode on its own, used to build others */
> >   /* Register numbers */
> >   enum {
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 61e93eb7d363..28f960bc2e30 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -1630,6 +1630,16 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
> >   				(u32) SRC,
> >   				(atomic_t *)(unsigned long) (DST + insn->off));
> >   			break;
> > +		case BPF_XCHG:
> > +			SRC = (u32) atomic_xchg(
> > +				(atomic_t *)(unsigned long) (DST + insn->off),
> > +				(u32) SRC);
> > +			break;
> > +		case BPF_CMPXCHG:
> > +			BPF_R0 = (u32) atomic_cmpxchg(
> > +				(atomic_t *)(unsigned long) (DST + insn->off),
> > +				(u32) BPF_R0, (u32) SRC);
> > +			break;
> >   		default:
> >   			goto default_label;
> >   		}
> > @@ -1647,6 +1657,16 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
> >   				(u64) SRC,
> >   				(atomic64_t *)(s64) (DST + insn->off));
> >   			break;
> > +		case BPF_XCHG:
> > +			SRC = (u64) atomic64_xchg(
> > +				(atomic64_t *)(u64) (DST + insn->off),
> > +				(u64) SRC);
> > +			break;
> > +		case BPF_CMPXCHG:
> > +			BPF_R0 = (u64) atomic64_cmpxchg(
> > +				(atomic64_t *)(u64) (DST + insn->off),
> > +				(u64) BPF_R0, (u64) SRC);
> > +			break;
> >   		default:
> >   			goto default_label;
> >   		}
> > diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
> > index 3ee2246a52ef..18357ea9a17d 100644
> > --- a/kernel/bpf/disasm.c
> > +++ b/kernel/bpf/disasm.c
> > @@ -167,6 +167,21 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
> >   				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
> >   				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
> >   				insn->dst_reg, insn->off, insn->src_reg);
> > +		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
> > +			   insn->imm == BPF_CMPXCHG) {
> > +			verbose(cbs->private_data, "(%02x) r0 = atomic%s_cmpxchg(*(%s *)(r%d %+d), r0, r%d)\n",
> 
> (%02x) r0 = atomic%s_cmpxchg((%s *)(r%d %+d), r0, r%d)?
> 
> > +				insn->code,
> > +				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
> > +				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
> > +				insn->dst_reg, insn->off,
> > +				insn->src_reg);
> > +		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
> > +			   insn->imm == BPF_XCHG) {
> > +			verbose(cbs->private_data, "(%02x) r%d = atomic%s_xchg(*(%s *)(r%d %+d), r%d)\n",
> 
> (%02x) r%d = atomic%s_xchg((%s *)(r%d %+d), r%d)?
> 
> > +				insn->code, insn->src_reg,
> > +				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
> > +				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
> > +				insn->dst_reg, insn->off, insn->src_reg);
> >   		} else {
> >   			verbose(cbs->private_data, "BUG_%02x\n", insn->code);
> >   		}
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index a68adbcee370..ccf4315e54e7 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3601,10 +3601,13 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> >   static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
> >   {
> >   	int err;
> > +	int load_reg;
> 
> nit: not a big deal but maybe put this definition before 'int err' to
> maintain reverse christmas tree coding style.
> 
> >   	switch (insn->imm) {
> >   	case BPF_ADD:
> >   	case BPF_ADD | BPF_FETCH:
> > +	case BPF_XCHG:
> > +	case BPF_CMPXCHG:
> >   		break;
> >   	default:
> >   		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
> > @@ -3626,6 +3629,13 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
> >   	if (err)
> >   		return err;
> > +	if (insn->imm == BPF_CMPXCHG) {
> > +		/* Check comparison of R0 with memory location */
> > +		err = check_reg_arg(env, BPF_REG_0, SRC_OP);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> >   	if (is_pointer_value(env, insn->src_reg)) {
> >   		verbose(env, "R%d leaks addr into mem\n", insn->src_reg);
> >   		return -EACCES;
> > @@ -3656,8 +3666,13 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
> >   	if (!(insn->imm & BPF_FETCH))
> >   		return 0;
> > -	/* check and record load of old value into src reg  */
> > -	err = check_reg_arg(env, insn->src_reg, DST_OP);
> > +	if (insn->imm == BPF_CMPXCHG)
> > +		load_reg = BPF_REG_0;
> > +	else
> > +		load_reg = insn->src_reg;
> > +
> > +	/* check and record load of old value */
> > +	err = check_reg_arg(env, load_reg, DST_OP);
> >   	if (err)
> >   		return err;
> > diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
> > index ac7701678e1a..ea99bd17d003 100644
> > --- a/tools/include/linux/filter.h
> > +++ b/tools/include/linux/filter.h
> > @@ -190,6 +190,26 @@
> >   		.off   = OFF,					\
> >   		.imm   = BPF_ADD | BPF_FETCH })
> > +/* Atomic exchange, src_reg = atomic_xchg((dst_reg + off), src_reg) */
> 
> src_reg = atomic_xchg(dst_reg + off, src_reg)?
> 
> > +
> > +#define BPF_ATOMIC_XCHG(SIZE, DST, SRC, OFF)			\
> > +	((struct bpf_insn) {					\
> > +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> > +		.dst_reg = DST,					\
> > +		.src_reg = SRC,					\
> > +		.off   = OFF,					\
> > +		.imm   = BPF_XCHG })
> > +
> > +/* Atomic compare-exchange, r0 = atomic_cmpxchg((dst_reg + off), r0, src_reg) */
> 
> r0 = atomic_cmpxchg(dst_reg + off, r0, src_reg)?
> 
> > +
> > +#define BPF_ATOMIC_CMPXCHG(SIZE, DST, SRC, OFF)			\
> > +	((struct bpf_insn) {					\
> > +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> > +		.dst_reg = DST,					\
> > +		.src_reg = SRC,					\
> > +		.off   = OFF,					\
> > +		.imm   = BPF_CMPXCHG })
> > +
> >   /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
> >   #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > index 025e377e7229..53334530cc81 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -45,7 +45,9 @@
> >   #define BPF_EXIT	0x90	/* function return */
> >   /* atomic op type fields (stored in immediate) */
> > -#define BPF_FETCH	0x01	/* fetch previous value into src reg */
> > +#define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
> > +#define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
> > +#define BPF_FETCH	0x01	/* not an opcode on its own, used to build others */
> >   /* Register numbers */
> >   enum {
> > 
