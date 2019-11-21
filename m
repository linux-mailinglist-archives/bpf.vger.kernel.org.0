Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADE9C1049C2
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2019 05:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfKUE7b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Nov 2019 23:59:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43696 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKUE7b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Nov 2019 23:59:31 -0500
Received: by mail-pl1-f196.google.com with SMTP id a18so971102plm.10
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2019 20:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XWN0SA2QVMC8Nwi0KdHnzSKDp20OWJN6OD6VQ60XqV4=;
        b=GdjUK6lfo/KRvg5RahbgqLfnrWzd6yALcrEDOOtSGXO5uFeNFz5QsJfp5cSTekmvEZ
         Svts+hjUC+B90S3F3cBE+mb9wcfDtdjLhRBCLU4Yp0PGWlIRa48UkhLGc8foKxN4DDLk
         MhgHXPSKeBy/BPssxsbFTmdXxfIRiRcOC0no9s12Riqvmnr5ZkpW44jVCbY7M3wBWAe3
         qsX3IfV62n43gzLhtne9DzvwQcLSDR06niuZOS10IT9s/8DwCT47V2T5dIhIqLajMM1k
         p4bF6qGiKOonI+KzFXHCSzy3OiXYMW6B7ZWwW49GEZN4jGxni+notBkt//dkBG/7HDBh
         +dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XWN0SA2QVMC8Nwi0KdHnzSKDp20OWJN6OD6VQ60XqV4=;
        b=A5ZBhMJNWBgo+AmQIUH+6g9XsXnSIc+lnlxrdLaZOheuh5AHEbv7phfWAfiwBcdILG
         dpeeqD8u8A3AL9Y4PoqOksIlcqZOcFcZP/H3wZm38VcDIpa0EXWO425K0hbrdsmJ6MP/
         q0oiWxIjq134WTyhvPH8TeKPjEFx0doW9hElnNWIvmcTwBTGMwPC9Vp7Nn2CBrNA7eCE
         kuVIG61xG3Ct67zb01CmfSb6a7GQuwzHOqcHUmJTnpq0cgt/TxJuycD1JzImLXiIeAM4
         TAuxyZcAR/Ddlna1eTgb91dQkXP8jFU0Tu/qEw8ZwLE7AighGXISq7JotKCXtO/wOOic
         qYWQ==
X-Gm-Message-State: APjAAAVng17UVFrlkY+3kBlnGmBic6tgmhMoK0Vn+YUAQeObUGVbf9Sz
        r8VZKKGkPWDxICBSQC6Z7wI=
X-Google-Smtp-Source: APXvYqzpuZrojqfVK/9hbfpZKY8+bzUDVYxa0B/GFAQqCgE+ic0xLlnb0+YH97J/CmLjFU9ZsgP0rw==
X-Received: by 2002:a17:90a:fb57:: with SMTP id iq23mr8853032pjb.79.1574312369967;
        Wed, 20 Nov 2019 20:59:29 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::9b19])
        by smtp.gmail.com with ESMTPSA id h22sm937887pgn.78.2019.11.20.20.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 20:59:28 -0800 (PST)
Date:   Wed, 20 Nov 2019 20:59:26 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        ecree@solarflare.com
Subject: Re: [PATCH bpf-next 1/2] bpf: provide better register bounds after
 jmp32 instructions
Message-ID: <20191121045924.v77wb5zzfliln7ql@ast-mbp.dhcp.thefacebook.com>
References: <20191121014024.1700638-1-yhs@fb.com>
 <20191121014024.1700703-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121014024.1700703-1-yhs@fb.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 20, 2019 at 05:40:24PM -0800, Yonghong Song wrote:
> With latest llvm (trunk https://github.com/llvm/llvm-project),
> test_progs, which has +alu32 enabled, failed for strobemeta.o.
> The verifier output looks like below with edit to replace large
> decimal numbers with hex ones.
>  193: (85) call bpf_probe_read_user_str#114
>    R0=inv(id=0)
>  194: (26) if w0 > 0x1 goto pc+4
>    R0_w=inv(id=0,umax_value=0xffffffff00000001)
>  195: (6b) *(u16 *)(r7 +80) = r0
>  196: (bc) w6 = w0
>    R6_w=inv(id=0,umax_value=0xffffffff,var_off=(0x0; 0xffffffff))
>  197: (67) r6 <<= 32
>    R6_w=inv(id=0,smax_value=0x7fffffff00000000,umax_value=0xffffffff00000000,
>             var_off=(0x0; 0xffffffff00000000))
>  198: (77) r6 >>= 32
>    R6=inv(id=0,umax_value=0xffffffff,var_off=(0x0; 0xffffffff))
>  ...
>  201: (79) r8 = *(u64 *)(r10 -416)
>    R8_w=map_value(id=0,off=40,ks=4,vs=13872,imm=0)
>  202: (0f) r8 += r6
>    R8_w=map_value(id=0,off=40,ks=4,vs=13872,umax_value=0xffffffff,var_off=(0x0; 0xffffffff))
>  203: (07) r8 += 9696
>    R8_w=map_value(id=0,off=9736,ks=4,vs=13872,umax_value=0xffffffff,var_off=(0x0; 0xffffffff))
>  ...
>  255: (bf) r1 = r8
>    R1_w=map_value(id=0,off=9736,ks=4,vs=13872,umax_value=0xffffffff,var_off=(0x0; 0xffffffff))
>  ...
>  257: (85) call bpf_probe_read_user_str#114
>  R1 unbounded memory access, make sure to bounds check any array access into a map
> 
> The value range for register r6 at insn 198 should be really just 0/1.
> The umax_value=0xffffffff caused later verification failure.
> 
> After jmp instructions, the current verifier already tried to use just
> obtained information to get better register range. The current mechanism is
> for 64bit register only. This patch implemented to tighten the range
> for 32bit sub-registers after jmp32 instructions.
> With the patch, we have the below range ranges for the
> above code sequence:
>  193: (85) call bpf_probe_read_user_str#114
>    R0=inv(id=0)
>  194: (26) if w0 > 0x1 goto pc+4
>    R0_w=inv(id=0,smax_value=0x7fffffff00000001,umax_value=0xffffffff00000001,
>             var_off=(0x0; 0xffffffff00000001))
>  195: (6b) *(u16 *)(r7 +80) = r0
>  196: (bc) w6 = w0
>    R6_w=inv(id=0,umax_value=0xffffffff,var_off=(0x0; 0x1))
>  197: (67) r6 <<= 32
>    R6_w=inv(id=0,umax_value=0x100000000,var_off=(0x0; 0x100000000))
>  198: (77) r6 >>= 32
>    R6=inv(id=0,umax_value=1,var_off=(0x0; 0x1))
>  ...
>  201: (79) r8 = *(u64 *)(r10 -416)
>    R8_w=map_value(id=0,off=40,ks=4,vs=13872,imm=0)
>  202: (0f) r8 += r6
>    R8_w=map_value(id=0,off=40,ks=4,vs=13872,umax_value=1,var_off=(0x0; 0x1))
>  203: (07) r8 += 9696
>    R8_w=map_value(id=0,off=9736,ks=4,vs=13872,umax_value=1,var_off=(0x0; 0x1))
>  ...
>  255: (bf) r1 = r8
>    R1_w=map_value(id=0,off=9736,ks=4,vs=13872,umax_value=1,var_off=(0x0; 0x1))
>  ...
>  257: (85) call bpf_probe_read_user_str#114
>  ...
> 
> At insn 194, the register R0 has better var_off.mask and smax_value.
> Especially, the var_off.mask ensures later lshift and rshift
> maintains proper value range.
> 
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/bpf/verifier.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9f59f7a19dd0..0090654c9010 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1007,6 +1007,20 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
>  						 reg->umax_value));
>  }
>  
> +static void __reg_bound_offset32(struct bpf_reg_state *reg)
> +{
> +	u64 mask = 0xffffFFFF;
> +	struct tnum range = tnum_range(reg->umin_value & mask,
> +				       reg->umax_value & mask);
> +	struct tnum lo32 = tnum_cast(reg->var_off, 4);
> +	struct tnum hi32 = reg->var_off;
> +
> +	hi32.value &= ~mask;
> +	hi32.mask &= ~mask;

sorry that was a quick hack :)
May be make sense to do it as a helper? similar to tnum_cast ?
The idea was to apply tnum_range to lower 32-bits.
May be tnum_intersect_with_mask(a, b, 4) ?
Or above two lines could be
hi32 = tnum_and(reg->var_off, tnum_bitwise_not(tnum_u32_max));
There is tnum_lshift/tnum_rshift. They could be used as well.

Ed,
how would you simplify __reg_bound_offset32 logic ?

> +
> +	reg->var_off = tnum_or(hi32, tnum_intersect(lo32, range));
> +}
> +
>  /* Reset the min/max bounds of a register */
>  static void __mark_reg_unbounded(struct bpf_reg_state *reg)
>  {
> @@ -5587,8 +5601,13 @@ static void reg_set_min_max(struct bpf_reg_state *true_reg,
>  	__reg_deduce_bounds(false_reg);
>  	__reg_deduce_bounds(true_reg);
>  	/* We might have learned some bits from the bounds. */
> -	__reg_bound_offset(false_reg);
> -	__reg_bound_offset(true_reg);
> +	if (is_jmp32) {
> +		__reg_bound_offset32(false_reg);
> +		__reg_bound_offset32(true_reg);
> +	} else {
> +		__reg_bound_offset(false_reg);
> +		__reg_bound_offset(true_reg);
> +	}
>  	/* Intersecting with the old var_off might have improved our bounds
>  	 * slightly.  e.g. if umax was 0x7f...f and var_off was (0; 0xf...fc),
>  	 * then new var_off is (0; 0x7f...fc) which improves our umax.
> @@ -5696,8 +5715,13 @@ static void reg_set_min_max_inv(struct bpf_reg_state *true_reg,
>  	__reg_deduce_bounds(false_reg);
>  	__reg_deduce_bounds(true_reg);
>  	/* We might have learned some bits from the bounds. */
> -	__reg_bound_offset(false_reg);
> -	__reg_bound_offset(true_reg);
> +	if (is_jmp32) {
> +		__reg_bound_offset32(false_reg);
> +		__reg_bound_offset32(true_reg);
> +	} else {
> +		__reg_bound_offset(false_reg);
> +		__reg_bound_offset(true_reg);
> +	}
>  	/* Intersecting with the old var_off might have improved our bounds
>  	 * slightly.  e.g. if umax was 0x7f...f and var_off was (0; 0xf...fc),
>  	 * then new var_off is (0; 0x7f...fc) which improves our umax.
> -- 
> 2.17.1
> 
