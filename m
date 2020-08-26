Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58621253A14
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 00:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHZWG2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Aug 2020 18:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZWG1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Aug 2020 18:06:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C090C061574
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 15:06:27 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h12so1864530pgm.7
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 15:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=eJZ+bCMvqTlloPLVNEkACK5qE+GqW9zWVIhvC2w1rRw=;
        b=uDMR2d/AcvWKpYCcoiLPBdTG2v+3fbRZL/+Rp1zD7VmQXIvoTmlWUagWkTuqO4Vcgc
         5agXybCgobLsZpw1ZA2+0+K8LVf9ikWRMOoGROaK5/mCw7MjXcyxOukH0XIhL/55hjvm
         Y7uxsy/amER3yYdBvW4siqFBuD1664B+yneL2D5dNNkCJVRd3PXius0v3Atyd3vDTw20
         CUsSznWWbggOE8A84rspSSTJMHsZaZZn0UX1N7GQ4NLQnt4I6fBIdvLQ+V/qg4bQfkzF
         n477ZxexqpuVuzdNjfrKksydh1Y9IFicAv6rVSVprA61LJTkW2UXDxLgb/FZPVsvMcvc
         ro3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=eJZ+bCMvqTlloPLVNEkACK5qE+GqW9zWVIhvC2w1rRw=;
        b=PUbN8W4985I5ZtSOCGDHczhBMv+VMHQ2/EKQcF74y0CCE/IbGrQMN7qO+WQlfZyVA2
         Nh0lDOjfNvj3rZERXJgdJa1rqfjFMEj4jB2wGu1PHEF1353XNYrWB98tTZg9gxjtdyxn
         viyFjbxKM1Q9NZcBhlscwZHrRvs1B7/FGQJhlQHp2as5b6aIBzsbFmZB0w5t9wXbSxJn
         0PllibVp3pz3K0LGHnVrRkYg53vgx3dNQFr8AHKM0Sl0GbgTCpO0KBxCWOVVzYFJRwAJ
         KtKKQW8NL6QcdQS5qJyVTmu8X1SYBGMvJlu4Hs95nTcX2WIiPK044JWQ8HnTYEtJ24ei
         1yBA==
X-Gm-Message-State: AOAM531bXeYJZaXdVijZHnCC6IND0Scihf6KVqwbTUD4hW/HSq58TurL
        0/S4kXjFAByxQbVUqoZrMgQ=
X-Google-Smtp-Source: ABdhPJzJ2pn26uY1u5Ow/aBKAOW2Vda8JrMpfhi/rsRxYGSF6d9CUm9uCTN0jej3pCT/NSwiAARgyQ==
X-Received: by 2002:a63:60e:: with SMTP id 14mr11917411pgg.343.1598479586212;
        Wed, 26 Aug 2020 15:06:26 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id w3sm177796pff.56.2020.08.26.15.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 15:06:25 -0700 (PDT)
Date:   Wed, 26 Aug 2020 15:06:16 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        John Fastabend <john.fastabend@gmail.com>, ecree@solarflare.com
Message-ID: <5f46dcd8c0156_50e8208f4@john-XPS-13-9370.notmuch>
In-Reply-To: <f2056e3c-e300-6fa0-8b8e-fa19ed5580bd@fb.com>
References: <20200825064608.2017878-1-yhs@fb.com>
 <20200825064608.2017937-1-yhs@fb.com>
 <20200826015836.2rlfvhoznylkabp6@ast-mbp.dhcp.thefacebook.com>
 <f2056e3c-e300-6fa0-8b8e-fa19ed5580bd@fb.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: fix a verifier failure with xor
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
> On 8/25/20 6:58 PM, Alexei Starovoitov wrote:
> > On Mon, Aug 24, 2020 at 11:46:08PM -0700, Yonghong Song wrote:
> >> bpf selftest test_progs/test_sk_assign failed with llvm 11 and llvm 12.
> >> Compared to llvm 10, llvm 11 and 12 generates xor instruction which
> >> is not handled properly in verifier. The following illustrates the
> >> problem:
> >>
> >>    16: (b4) w5 = 0
> >>    17: ... R5_w=inv0 ...
> >>    ...
> >>    132: (a4) w5 ^= 1
> >>    133: ... R5_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) ...
> >>    ...
> >>    37: (bc) w8 = w5
> >>    38: ... R5=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> >>            R8_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) ...
> >>    ...
> >>    41: (bc) w3 = w8
> >>    42: ... R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) ...
> >>    45: (56) if w3 != 0x0 goto pc+1
> >>     ... R3_w=inv0 ...
> >>    46: (b7) r1 = 34
> >>    47: R1_w=inv34 R7=pkt(id=0,off=26,r=38,imm=0)
> >>    47: (0f) r7 += r1
> >>    48: R1_w=invP34 R3_w=inv0 R7_w=pkt(id=0,off=60,r=38,imm=0)
> >>    48: (b4) w9 = 0
> >>    49: R1_w=invP34 R3_w=inv0 R7_w=pkt(id=0,off=60,r=38,imm=0)
> >>    49: (69) r1 = *(u16 *)(r7 +0)
> >>    invalid access to packet, off=60 size=2, R7(id=0,off=60,r=38)
> >>    R7 offset is outside of the packet
> >>
> >> At above insn 132, w5 = 0, but after w5 ^= 1, we give a really conservative
> >> value of w5. At insn 45, in reality the condition should be always false.
> >> But due to conservative value for w3, the verifier evaluates it could be
> >> true and this later leads to verifier failure complaining potential
> >> packet out-of-bound access.
> >>
> >> This patch implemented proper XOR support in verifier.
> >> In the above example, we have:
> >>    132: R5=invP0
> >>    132: (a4) w5 ^= 1
> >>    133: R5_w=invP1
> >>    ...
> >>    37: (bc) w8 = w5
> >>    ...
> >>    41: (bc) w3 = w8
> >>    42: R3_w=invP1
> >>    ...
> >>    45: (56) if w3 != 0x0 goto pc+1
> >>    47: R3_w=invP1
> >>    ...
> >>    processed 353 insns ...
> >> and the verifier can verify the program successfully.
> >>
> >> Cc: John Fastabend <john.fastabend@gmail.com>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---

Thanks! Although we use llvm11 (+ some extra patches) and I haven't
seen this yet if I get some time I'll try to see if I can get something
to generate this code.

Acked-by: John Fastabend <john.fastabend@gmail.com>

> >>   kernel/bpf/verifier.c | 66 +++++++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 66 insertions(+)
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index dd24503ab3d3..a08cabc0f683 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -5801,6 +5801,67 @@ static void scalar_min_max_or(struct bpf_reg_state *dst_reg,
> >>   	__update_reg_bounds(dst_reg);
> >>   }
> >>   
> >> +static void scalar32_min_max_xor(struct bpf_reg_state *dst_reg,
> >> +				 struct bpf_reg_state *src_reg)
> >> +{
> >> +	bool src_known = tnum_subreg_is_const(src_reg->var_off);
> >> +	bool dst_known = tnum_subreg_is_const(dst_reg->var_off);
> >> +	struct tnum var32_off = tnum_subreg(dst_reg->var_off);
> >> +	s32 smin_val = src_reg->s32_min_value;
> >> +
> >> +	/* Assuming scalar64_min_max_xor will be called so it is safe
> >> +	 * to skip updating register for known case.
> >> +	 */
> >> +	if (src_known && dst_known)
> >> +		return;
> > 
> > why?
> > I've looked at _and() and _or() variants that do the same and
> > couldn't quite remember why it's ok to do so.
> 
> Yes, I copied what _and() and _or() did. What I thought is
> if both known, 64bit scalar_min_max_xor() handled this and did
> not go though the approximation below, so that is why we return here.
> John, could you confirm?
> 
> > 
> >> +
> >> +	/* We get both minimum and maximum from the var32_off. */
> >> +	dst_reg->u32_min_value = var32_off.value;
> >> +	dst_reg->u32_max_value = var32_off.value | var32_off.mask;
> >> +
> >> +	if (dst_reg->s32_min_value >= 0 && smin_val >= 0) {
> >> +		/* XORing two positive sign numbers gives a positive,
> >> +		 * so safe to cast u32 result into s32.
> >> +		 */
> >> +		dst_reg->s32_min_value = dst_reg->u32_min_value;
> >> +		dst_reg->s32_max_value = dst_reg->u32_max_value;
> >> +	} else {
> >> +		dst_reg->s32_min_value = S32_MIN;
> >> +		dst_reg->s32_max_value = S32_MAX;
> >> +	}
> >> +}
> >> +
> >> +static void scalar_min_max_xor(struct bpf_reg_state *dst_reg,
> >> +			       struct bpf_reg_state *src_reg)
> >> +{
> >> +	bool src_known = tnum_is_const(src_reg->var_off);
> >> +	bool dst_known = tnum_is_const(dst_reg->var_off);
> >> +	s64 smin_val = src_reg->smin_value;
> >> +
> >> +	if (src_known && dst_known) {
> >> +		/* dst_reg->var_off.value has been updated earlier */
> > 
> > right, but that means that there is sort-of 'bug' (unnecessary operation)
> > that caused me a lot of head scratching.
> > scalar_min_max_and() and scalar_min_max_or() do the alu in similar situation:
> >          if (src_known && dst_known) {
> >                  __mark_reg_known(dst_reg, dst_reg->var_off.value |
> >                                            src_reg->var_off.value);
> > I guess it's still technically correct to repeat alu operation.
> > second & and second | won't change the value of dst_reg,
> > but it feels that it's correct by accident?
> > John ?

It is a hold-out from when we went from having a 32-bit var-off
and a 64-bit var-off. I'll send a patch its clumsy and not needed
for sure.

The other subtle piece here we should clean up. Its possible
to have a const in the subreg but a non-const in the wider
64-bit reg. In this case we skip marking the 32-bit subreg
as known and rely on the 64-bit case to handle it. But, we
may if the 64-bit reg is not const fall through and update
the 64-bit bounds. Then later we call __update_reg32_bounds()
and this will use the var_off, previously updated. The
32-bit bounds are then updated using this var_off so they
are correct even if less precise than we might expect. I
believe xor is correct here as well.

I need to send another patch with a comment for the BTF_ID
types. I'll add some test cases for this 64-bit non-const and
subreg const so we don't break it later. I'm on the fence
if we should tighten the bounds there as well. I'll see if
it helps readability to do explicit 32-bit const handling
there. I had it in one of the early series with the 32-bit
bounds handling, but dropped for what we have now.

> 
> I think for or and add, additional dst_reg op src_reg is okay. For 
> example, for "and", the computation looks like
>     dst = dst & src
>     dst = dst & src
> result will be the same as
>     dst = dst & src
> and the second is redundant and can be replaced with dst.
> The same for or,
>     dst = dst | src
>     dst = dst | src
> is the same as "dst = dst | src" and the second is redundant. So
> for and/or, the __mark_reg_known can just take dst_reg->var_off.value,
> but the current code is also correct but can be simplified.
> 
> This is not the case xor (^). The extra computation will
> change expected value.

Right.

> 
> > 
> >> +		__mark_reg_known(dst_reg, dst_reg->var_off.value);
> >> +		return;
> >> +	}
> >> +
> >> +	/* We get both minimum and maximum from the var_off. */
> >> +	dst_reg->umin_value = dst_reg->var_off.value;
> >> +	dst_reg->umax_value = dst_reg->var_off.value | dst_reg->var_off.mask;
> > 
> > I think this is correct, but I hope somebody else can analyze this as well.
> > John, Ed ?
> 
> Please do double check. Thanks.

LGTM, but I see a couple follow up patches with tests, comments,
and dropping the duplicate ALU op I'll try to do those Friday, unless
someone else does them first.

> 
> > 
> >> +
> >> +	if (dst_reg->smin_value >= 0 && smin_val >= 0) {
> >> +		/* XORing two positive sign numbers gives a positive,
> >> +		 * so safe to cast u64 result into s64.
> >> +		 */
> >> +		dst_reg->smin_value = dst_reg->umin_value;
> >> +		dst_reg->smax_value = dst_reg->umax_value;
> >> +	} else {
> >> +		dst_reg->smin_value = S64_MIN;
> >> +		dst_reg->smax_value = S64_MAX;
> >> +	}
> >> +
> >> +	__update_reg_bounds(dst_reg);
> >> +}
