Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F1425255F
	for <lists+bpf@lfdr.de>; Wed, 26 Aug 2020 03:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgHZB6m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Aug 2020 21:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgHZB6k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Aug 2020 21:58:40 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8200AC061574
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2020 18:58:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ls14so148013pjb.3
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2020 18:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xLdC9ND688u6xs5VTWloWjmvEbXN0787RhILJ/xlSyc=;
        b=MOYbw3ZQRi2JvL2xzjLNtrsIgnL6cYRGLj50s/gQrUtPcCg32X7hDsbc0ZV0Rh/Q08
         1bPudtCoHy1PSot9qvCvtnt8gTes3WgBI3E/WgdTUecohD+QDk3TCZ36o0/S2FScEByt
         9S1ZhmpaY7yJoIx+j2kaNq0wb+Dk2UMZQkX6WCdoog2j3PulTOdSWfVrVXuRzCbQsXHT
         l89FO++/TMkzar0UOT1sW54pSRpcW7qyfSRqoAYUP9FVY8wVym3tlQA50SS8BccYEPK/
         wZxjBWj1WS7sJhJWn4SeSKSv0MER4yYbg4JdfXGFZejYnya2c3NYHDov9JwfaB9tf8bD
         7f7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xLdC9ND688u6xs5VTWloWjmvEbXN0787RhILJ/xlSyc=;
        b=V8GbcL5vNLcs8oDCtA3im4AYRyHNgb8uGHErq4b7riBv86mGO7wkuXov+BBa6ewWKy
         V1zFujW30mm3wBMcoAG1Q4O1u8WPJ4H123nNBvPXycF8tHXyHemHxFYMe+dQLyWZWcJa
         bjEZCq5gjO1M0HNcJRPQ3Os6gjH8Ly509CA4y64Zsl5+f4EIYhzDGrWcnjIg1c7joob4
         iVVkA8gtSWNmm6idUntjLs6lyNi7Gm/LB04+S5NBbD0cNgoehGtwPJVoRqtiyF4Vroj4
         nYazhWvZcH0vmN+SW+u5Y6nURe8ouQ1GJtiK+cmgYB5R7+P4ig4OMaNJB5ooAjvCi0aA
         CSfA==
X-Gm-Message-State: AOAM532jaFMQRTLIb890f9cfjc896X7aX/UVf+wl6a7ct3HoqhYXjUOd
        Vbrp3JpRs9FJAgP03Qi1D2s=
X-Google-Smtp-Source: ABdhPJwCopbh66PYU1LNDYaley4FrqMrpNn7qIc1QoUQKPiM7fBIowTU2BK2n2bDa0MY4FzZeMs/IA==
X-Received: by 2002:a17:90a:e30e:: with SMTP id x14mr3708109pjy.150.1598407119928;
        Tue, 25 Aug 2020 18:58:39 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:3d59])
        by smtp.gmail.com with ESMTPSA id a20sm577335pfi.11.2020.08.25.18.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 18:58:39 -0700 (PDT)
Date:   Tue, 25 Aug 2020 18:58:36 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        John Fastabend <john.fastabend@gmail.com>, ecree@solarflare.com
Subject: Re: [PATCH bpf-next 1/2] bpf: fix a verifier failure with xor
Message-ID: <20200826015836.2rlfvhoznylkabp6@ast-mbp.dhcp.thefacebook.com>
References: <20200825064608.2017878-1-yhs@fb.com>
 <20200825064608.2017937-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825064608.2017937-1-yhs@fb.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 24, 2020 at 11:46:08PM -0700, Yonghong Song wrote:
> bpf selftest test_progs/test_sk_assign failed with llvm 11 and llvm 12.
> Compared to llvm 10, llvm 11 and 12 generates xor instruction which
> is not handled properly in verifier. The following illustrates the
> problem:
> 
>   16: (b4) w5 = 0
>   17: ... R5_w=inv0 ...
>   ...
>   132: (a4) w5 ^= 1
>   133: ... R5_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) ...
>   ...
>   37: (bc) w8 = w5
>   38: ... R5=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
>           R8_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) ...
>   ...
>   41: (bc) w3 = w8
>   42: ... R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) ...
>   45: (56) if w3 != 0x0 goto pc+1
>    ... R3_w=inv0 ...
>   46: (b7) r1 = 34
>   47: R1_w=inv34 R7=pkt(id=0,off=26,r=38,imm=0)
>   47: (0f) r7 += r1
>   48: R1_w=invP34 R3_w=inv0 R7_w=pkt(id=0,off=60,r=38,imm=0)
>   48: (b4) w9 = 0
>   49: R1_w=invP34 R3_w=inv0 R7_w=pkt(id=0,off=60,r=38,imm=0)
>   49: (69) r1 = *(u16 *)(r7 +0)
>   invalid access to packet, off=60 size=2, R7(id=0,off=60,r=38)
>   R7 offset is outside of the packet
> 
> At above insn 132, w5 = 0, but after w5 ^= 1, we give a really conservative
> value of w5. At insn 45, in reality the condition should be always false.
> But due to conservative value for w3, the verifier evaluates it could be
> true and this later leads to verifier failure complaining potential
> packet out-of-bound access.
> 
> This patch implemented proper XOR support in verifier.
> In the above example, we have:
>   132: R5=invP0
>   132: (a4) w5 ^= 1
>   133: R5_w=invP1
>   ...
>   37: (bc) w8 = w5
>   ...
>   41: (bc) w3 = w8
>   42: R3_w=invP1
>   ...
>   45: (56) if w3 != 0x0 goto pc+1
>   47: R3_w=invP1
>   ...
>   processed 353 insns ...
> and the verifier can verify the program successfully.
> 
> Cc: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/bpf/verifier.c | 66 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index dd24503ab3d3..a08cabc0f683 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5801,6 +5801,67 @@ static void scalar_min_max_or(struct bpf_reg_state *dst_reg,
>  	__update_reg_bounds(dst_reg);
>  }
>  
> +static void scalar32_min_max_xor(struct bpf_reg_state *dst_reg,
> +				 struct bpf_reg_state *src_reg)
> +{
> +	bool src_known = tnum_subreg_is_const(src_reg->var_off);
> +	bool dst_known = tnum_subreg_is_const(dst_reg->var_off);
> +	struct tnum var32_off = tnum_subreg(dst_reg->var_off);
> +	s32 smin_val = src_reg->s32_min_value;
> +
> +	/* Assuming scalar64_min_max_xor will be called so it is safe
> +	 * to skip updating register for known case.
> +	 */
> +	if (src_known && dst_known)
> +		return;

why?
I've looked at _and() and _or() variants that do the same and
couldn't quite remember why it's ok to do so.

> +
> +	/* We get both minimum and maximum from the var32_off. */
> +	dst_reg->u32_min_value = var32_off.value;
> +	dst_reg->u32_max_value = var32_off.value | var32_off.mask;
> +
> +	if (dst_reg->s32_min_value >= 0 && smin_val >= 0) {
> +		/* XORing two positive sign numbers gives a positive,
> +		 * so safe to cast u32 result into s32.
> +		 */
> +		dst_reg->s32_min_value = dst_reg->u32_min_value;
> +		dst_reg->s32_max_value = dst_reg->u32_max_value;
> +	} else {
> +		dst_reg->s32_min_value = S32_MIN;
> +		dst_reg->s32_max_value = S32_MAX;
> +	}
> +}
> +
> +static void scalar_min_max_xor(struct bpf_reg_state *dst_reg,
> +			       struct bpf_reg_state *src_reg)
> +{
> +	bool src_known = tnum_is_const(src_reg->var_off);
> +	bool dst_known = tnum_is_const(dst_reg->var_off);
> +	s64 smin_val = src_reg->smin_value;
> +
> +	if (src_known && dst_known) {
> +		/* dst_reg->var_off.value has been updated earlier */

right, but that means that there is sort-of 'bug' (unnecessary operation)
that caused me a lot of head scratching.
scalar_min_max_and() and scalar_min_max_or() do the alu in similar situation:
        if (src_known && dst_known) {
                __mark_reg_known(dst_reg, dst_reg->var_off.value |
                                          src_reg->var_off.value);
I guess it's still technically correct to repeat alu operation.
second & and second | won't change the value of dst_reg,
but it feels that it's correct by accident?
John ?

> +		__mark_reg_known(dst_reg, dst_reg->var_off.value);
> +		return;
> +	}
> +
> +	/* We get both minimum and maximum from the var_off. */
> +	dst_reg->umin_value = dst_reg->var_off.value;
> +	dst_reg->umax_value = dst_reg->var_off.value | dst_reg->var_off.mask;

I think this is correct, but I hope somebody else can analyze this as well.
John, Ed ?

> +
> +	if (dst_reg->smin_value >= 0 && smin_val >= 0) {
> +		/* XORing two positive sign numbers gives a positive,
> +		 * so safe to cast u64 result into s64.
> +		 */
> +		dst_reg->smin_value = dst_reg->umin_value;
> +		dst_reg->smax_value = dst_reg->umax_value;
> +	} else {
> +		dst_reg->smin_value = S64_MIN;
> +		dst_reg->smax_value = S64_MAX;
> +	}
> +
> +	__update_reg_bounds(dst_reg);
> +}
