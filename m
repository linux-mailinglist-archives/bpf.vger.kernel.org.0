Return-Path: <bpf+bounces-54340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE649A67CF9
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 20:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E1D7A740A
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 19:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E691DF24B;
	Tue, 18 Mar 2025 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="P/L30Mqa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E79F8F5A
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742325671; cv=none; b=k0hLsKKGrLw/2T1NB8BHVXNZUhnm0wgSqFi4Bz889Njt2KZRSNgiWVdkYpicfl/1yPjCJozLAxUjAe0oksB++l8ZzmZaJpbXnEULfPHzZus2p1+8aGxfaI1E+qDTxlB/XBqhhrOAsnJj0fgpwpykklBTREn4Mg+pvqGYWRBdH9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742325671; c=relaxed/simple;
	bh=60/rp+CuF3Pp56L80HHw3kGNPg8HOaiBCk05roXoeE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4NJ5+syXymgSOs+Fx9YQ14kDKPA93OOwlykSfbo9ank50cXkjSI4Ai6UH1SA63qC+VbTiAkeOPsVHUxDlnBOwgpRYXaZOQwgTC6UG6zQukECnl80JJUqLXiY4BF22VfxT31lUUYKT6XW00K2OGHuET7E0w9JYTYfVbfzlrEGd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=P/L30Mqa; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so24958615e9.3
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 12:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1742325664; x=1742930464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dPblEax3ea5jE/prdSS+jPA6g+woGQWKi5yglySGL8E=;
        b=P/L30MqaK3N+YxidrXtai6FmmaoTpQw4Zxhy2P5isaUk6N197n5MuFSrrKEGlFTiP6
         6Lv4fzeor+713AngaVtajm+HmZlPME9K846k0dlJVzHOHNaWjLY0JhPuPUIXR9n2mSWr
         7SgXvO1y6QrVDiZ2UCg2BXRrEoefja/nJPPI2TevvjKLy/m1uSMA3v47UxROI0JalBPx
         /dTx7iM2sqlqfoe/82VLCzPz9v1jWrqkAra3EY5jnw5XcOIE012JCmopQqo2D9fp8w29
         iApNDoJJcbt8W92PqSGAq5MSR4yRPImAQANcPmzBCRTyOyHqy1ohRtgnBWTm/ab+vl5A
         P1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742325664; x=1742930464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPblEax3ea5jE/prdSS+jPA6g+woGQWKi5yglySGL8E=;
        b=Hr/NbwNI/gwRUzECuixHpknODwqK0BdBfNhAFqBEsIK7RPrQ5pRCQ5HtkiS5Mtx0Jq
         QsyXPxUj6Cz7BVJuvurJNfHnuW1lgyaVISH2z4AgchUgwqkQv3vuouvMKf52u5FCAJfh
         vmL8WJzZYJnzcsPqbf3tYPPMySKjcoaVEBn1SlZSJMPMxfXy/l8wiI5LMOSOgjIngQYv
         haI0+kuSuB2+tYhpPAijkx5YrapT1YahPuaf2kU1u6lwGzpYL/o19OkYIFWhvuAN7aYH
         hmWRXshdjhYKHWRE0E9NeHn9b2iG3oIqpQcV4wx6S1Diu9YK5cA3sIcFvWJRx/dRIWuI
         N4rw==
X-Gm-Message-State: AOJu0YzdLGOkx/QKFYBrTvsk0djk9uovYpvVbWvb2XF9CrbSSwHUMQFL
	BTpHlWzfqXDB4prOBzhG6A3tasP0q6Zkhim+yJ6H4ht/K4AtptZs4CAne3ebhAA=
X-Gm-Gg: ASbGncvWg7wf8uya/vJwa6tOWicu+PzlFZQOLjpZpJnzdtIfZywJuuMqhHVSvatyWL9
	8y6HgHjNndJwZu45dnGhOTedlT4Bhn+TTkZ/E/hughnEvTK6X+Jx3ucFQrN4n8eOTE10Jgt1qse
	owkbsz0oPNpXUPtyseojzGfg0BTcL2rEepIyQU/h3HS0ET3ww4oKD475aSvqs6gR3CuV2vw5qfo
	USV/r979qE97D1iUI2rCb+Qi9mCDn3y7SIXFpzdfRJDrsfSCbqLLeQ1h9E2mH4lg1VtLr1UKT83
	FXD4b4v3M/9Lzp/5+QhCOco85Yy9fFD3cY9rcsqs8KwtVaYXzq+xafKwl34=
X-Google-Smtp-Source: AGHT+IF3sMMrQ5cgnPUbBKe6XPRpuwl5kWedN6An7PN4ue6DTeUq0RAqa2KNfZgFcVdCv0mm8rnlBg==
X-Received: by 2002:a05:6000:1447:b0:390:fdba:ac7 with SMTP id ffacd0b85a97d-3971f511f00mr19718624f8f.51.1742325663646;
        Tue, 18 Mar 2025 12:21:03 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ebaa5sm18833547f8f.87.2025.03.18.12.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 12:21:03 -0700 (PDT)
Date: Tue, 18 Mar 2025 19:24:46 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: David Faust <david.faust@oracle.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>
Subject: Re: [RFC PATCH bpf-next 04/14] bpf: add support for an extended JA
 instruction
Message-ID: <Z9nIfsNWg++0B9zf@mail.gmail.com>
References: <20250318143318.656785-1-aspsk@isovalent.com>
 <20250318143318.656785-5-aspsk@isovalent.com>
 <f25a61cc-e2aa-42f0-9173-d4ab3b5a91b5@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f25a61cc-e2aa-42f0-9173-d4ab3b5a91b5@oracle.com>

On 25/03/18 12:00PM, David Faust wrote:
> 
> 
> On 3/18/25 07:33, Anton Protopopov wrote:
> > Add support for a new version of JA instruction, a static branch JA. Such
> > instructions may either jump to the specified offset or act as nops. To
> > distinguish such instructions from normal JA the BPF_STATIC_BRANCH_JA flag
> > should be set for the SRC register.
> > 
> > By default on program load such instructions are jitted as a normal JA.
> > However, if the BPF_STATIC_BRANCH_NOP flag is set in the SRC register,
> > then the instruction is jitted to a NOP.
> 
> [adding context from the cover letter:]
> > 3) Patch 4 adds support for a new BPF instruction. It looks
> > reasonable to use an extended BPF_JMP|BPF_JA instruction, and not
> > may_goto. Reasons: a follow up will add support for
> > BPF_JMP|BPF_JA|BPF_X (indirect jumps), which also utilizes INSN_SET maps (see [2]).
> > Then another follow up will add support CALL|BPF_X, for which there's
> > no corresponding magic instruction (to be discussed at the following
> > LSF/MM/BPF).
> 
> I don't understand the reasoning to extend JA rather than JCOND.
> 
> Couldn't the followup for indirect jumps also use JCOND, with BPF_SRC_X
> set to distinguish from the absolute jumps here?
>
> If the problem is that the indirect version will need both reigster
> fields and JCOND is using SRC to encode the operation (0 for may_goto),
> aren't you going to have exactly the same problem with BPF_JA|BPF_X and
> the BPF_STATIC_BRANCH flag?  Or is the plan to stick the flag in another
> different field of BPF_JA|BPF_X instruction...?
> 
> It seems like the general problem here that there is a growing class of
> statically-decided-post-compiler conditional jumps, but no more free
> insn class bits to use.  I suggest we try hard to encapsulate them as
> much as possible under JCOND rather than (ab)using different fields of
> different JMP insns to encode the 'maybe' versions on a case-by-case
> basis.
> 
> To put it another way, why not make BPF_JMP|BPF_JCOND its own "class"
> of insn and encode all of these conditional pseudo-jumps under it?

I agree that the "magic jump" (BPF_STATIC_BRANCH) is, maybe, better to go with
BPF_JMP|BPF_JCOND, as it emphasizes that the instruction is a special one.

However, for indirect jumps the BPF_JMP|BPF_JA|BPF_X looks more natural.

> As far as I am aware (I may be out of date), the only JCOND insn
> currently is may_goto (src_reg == 0), and may_goto only uses the 16-bit
> offset. That seems to leave a lot of room (and bits) to design a whole
> sub-class of JMP|JCOND instructions in a backwards compatible way...
> 
> > 
> > In order to generate BPF_STATIC_BRANCH_JA instructions using llvm two new
> > instructions will be added:
> > 
> > 	asm volatile goto ("nop_or_gotol %l[label]" :::: label);
> > 
> > will generate the BPF_STATIC_BRANCH_JA|BPF_STATIC_BRANCH_NOP instuction and
> > 
> > 	asm volatile goto ("gotol_or_nop %l[label]" :::: label);
> > 
> > will generate a BPF_STATIC_BRANCH_JA instruction, without an extra bit set.
> > The reason for adding two instructions is that both are required to implement
> > static keys functionality for BPF, namely, to distinguish between likely and
> > unlikely branches.
> > 
> > The verifier logic is extended to check both possible paths: jump and nop.
> > 
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >  arch/x86/net/bpf_jit_comp.c    | 19 +++++++++++++--
> >  include/uapi/linux/bpf.h       | 10 ++++++++
> >  kernel/bpf/verifier.c          | 43 +++++++++++++++++++++++++++-------
> >  tools/include/uapi/linux/bpf.h | 10 ++++++++
> >  4 files changed, 71 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index d3491cc0898b..5856ac1aab80 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1482,6 +1482,15 @@ static void emit_priv_frame_ptr(u8 **pprog, void __percpu *priv_frame_ptr)
> >  	*pprog = prog;
> >  }
> >  
> > +static bool is_static_ja_nop(const struct bpf_insn *insn)
> > +{
> > +	u8 code = insn->code;
> > +
> > +	return (code == (BPF_JMP | BPF_JA) || code == (BPF_JMP32 | BPF_JA)) &&
> > +	       (insn->src_reg & BPF_STATIC_BRANCH_JA) &&
> > +	       (insn->src_reg & BPF_STATIC_BRANCH_NOP);
> > +}
> > +
> >  #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
> >  
> >  #define __LOAD_TCC_PTR(off)			\
> > @@ -2519,9 +2528,15 @@ st:			if (is_imm8(insn->off))
> >  					}
> >  					emit_nops(&prog, INSN_SZ_DIFF - 2);
> >  				}
> > -				EMIT2(0xEB, jmp_offset);
> > +				if (is_static_ja_nop(insn))
> > +					emit_nops(&prog, 2);
> > +				else
> > +					EMIT2(0xEB, jmp_offset);
> >  			} else if (is_simm32(jmp_offset)) {
> > -				EMIT1_off32(0xE9, jmp_offset);
> > +				if (is_static_ja_nop(insn))
> > +					emit_nops(&prog, 5);
> > +				else
> > +					EMIT1_off32(0xE9, jmp_offset);
> >  			} else {
> >  				pr_err("jmp gen bug %llx\n", jmp_offset);
> >  				return -EFAULT;
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index b8e588ed6406..57e0fd636a27 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1462,6 +1462,16 @@ struct bpf_stack_build_id {
> >  	};
> >  };
> >  
> > +/* Flags for JA insn, passed in SRC_REG */
> > +enum {
> > +	BPF_STATIC_BRANCH_JA  = 1 << 0,
> > +	BPF_STATIC_BRANCH_NOP = 1 << 1,
> > +};
> > +
> > +#define BPF_STATIC_BRANCH_MASK (BPF_STATIC_BRANCH_JA | \
> > +				BPF_STATIC_BRANCH_NOP)
> > +
> > +
> >  #define BPF_OBJ_NAME_LEN 16U
> >  
> >  union bpf_attr {
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 6554f7aea0d8..0860ef57d5af 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -17374,14 +17374,24 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
> >  		else
> >  			off = insn->imm;
> >  
> > -		/* unconditional jump with single edge */
> > -		ret = push_insn(t, t + off + 1, FALLTHROUGH, env);
> > -		if (ret)
> > -			return ret;
> > +		if (insn->src_reg & BPF_STATIC_BRANCH_JA) {
> > +			/* static branch - jump with two edges */
> > +			mark_prune_point(env, t);
> >  
> > -		mark_prune_point(env, t + off + 1);
> > -		mark_jmp_point(env, t + off + 1);
> > +			ret = push_insn(t, t + 1, FALLTHROUGH, env);
> > +			if (ret)
> > +				return ret;
> > +
> > +			ret = push_insn(t, t + off + 1, BRANCH, env);
> > +		} else {
> > +			/* unconditional jump with single edge */
> > +			ret = push_insn(t, t + off + 1, FALLTHROUGH, env);
> > +			if (ret)
> > +				return ret;
> >  
> > +			mark_prune_point(env, t + off + 1);
> > +			mark_jmp_point(env, t + off + 1);
> > +		}
> >  		return ret;
> >  
> >  	default:
> > @@ -19414,8 +19424,11 @@ static int do_check(struct bpf_verifier_env *env)
> >  
> >  				mark_reg_scratched(env, BPF_REG_0);
> >  			} else if (opcode == BPF_JA) {
> > +				struct bpf_verifier_state *other_branch;
> > +				u32 jmp_offset;
> > +
> >  				if (BPF_SRC(insn->code) != BPF_K ||
> > -				    insn->src_reg != BPF_REG_0 ||
> > +				    (insn->src_reg & ~BPF_STATIC_BRANCH_MASK) ||
> >  				    insn->dst_reg != BPF_REG_0 ||
> >  				    (class == BPF_JMP && insn->imm != 0) ||
> >  				    (class == BPF_JMP32 && insn->off != 0)) {
> > @@ -19424,9 +19437,21 @@ static int do_check(struct bpf_verifier_env *env)
> >  				}
> >  
> >  				if (class == BPF_JMP)
> > -					env->insn_idx += insn->off + 1;
> > +					jmp_offset = insn->off + 1;
> >  				else
> > -					env->insn_idx += insn->imm + 1;
> > +					jmp_offset = insn->imm + 1;
> > +
> > +				/* Staic branch can either jump to +off or +0 */
> > +				if (insn->src_reg & BPF_STATIC_BRANCH_JA) {
> > +					other_branch = push_stack(env, env->insn_idx + jmp_offset,
> > +							env->insn_idx, false);
> > +					if (!other_branch)
> > +						return -EFAULT;
> > +
> > +					jmp_offset = 1;
> > +				}
> > +
> > +				env->insn_idx += jmp_offset;
> >  				continue;
> >  
> >  			} else if (opcode == BPF_EXIT) {
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > index b8e588ed6406..57e0fd636a27 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -1462,6 +1462,16 @@ struct bpf_stack_build_id {
> >  	};
> >  };
> >  
> > +/* Flags for JA insn, passed in SRC_REG */
> > +enum {
> > +	BPF_STATIC_BRANCH_JA  = 1 << 0,
> > +	BPF_STATIC_BRANCH_NOP = 1 << 1,
> > +};
> > +
> > +#define BPF_STATIC_BRANCH_MASK (BPF_STATIC_BRANCH_JA | \
> > +				BPF_STATIC_BRANCH_NOP)
> > +
> > +
> >  #define BPF_OBJ_NAME_LEN 16U
> >  
> >  union bpf_attr {
> 

