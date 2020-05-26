Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA601A3685
	for <lists+bpf@lfdr.de>; Thu,  9 Apr 2020 17:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgDIPDU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Apr 2020 11:03:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37036 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgDIPDQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Apr 2020 11:03:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so12317063wrm.4
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2020 08:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vtCT7VM/U8+2ugDbyDMJTRpWOwmF4O8BiPI4Kf3pIEc=;
        b=lnPzj9Bos4zIi4HxiqB9cXT1T7jEoLWox6BqHGJFDPSY9FckMJUiJeVAhjVR6NIKAr
         w/vb2KU4OU8JtaRrW1873np+htxzXZj/D4Zxn+cxQvO7q3TOZHWhA/4oXK8od67/M+Yp
         dsuHpS/XLyeFBqag6B44vFpm4oDj52hW28y+Pug/YPHvmpCAL0UTOHXiSUUtpgOnRfT4
         CTllD7cvpOEJhB1/apMcuaJIJmiAIItovDjQIc9Q1hgkXA+60mEVzXb49omeCKQLJMCu
         p6bvpwV8mGHvLrQnnHEWD3U8119Kj9JUTdxNgrqc6d2g4ILAGT+nVX2T25UPNjM00MAs
         XgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vtCT7VM/U8+2ugDbyDMJTRpWOwmF4O8BiPI4Kf3pIEc=;
        b=GOG3e2SzueS2PWGa7M8g7niIe4z+g0ocvL5yR/cML21uJ2jp5GjC9apHffiIlMNZ6j
         SB1R9d0nUskflu6Yz4AZsewNfzFKWuyAxlspwHG8It1UAIDrgDXqJUYnMU+QJOJP4keo
         wTlRCnNlItwEhHLBJkfKqd+GG6zw1lwka2k3xQ6GybtygVxZYd0WSxsR96BQGsi4I5OC
         lDEV0CaEZri304e0rRfSZ/X9CDkgT6i7R738YWTq5Y7x+nYZaQRYEwIQBqvZJLG0e9Y4
         zotMZHHkezWzOSp81HogvG5JVGN2vQhiD0fm5HklDL3FtjfLUw4Cii42zYgYS2YW811o
         cl5g==
X-Gm-Message-State: AGi0PuaHqdsR2Y7k51KtY1DAg8kqgongkqNJJP+tcpP/pCzw3M1MNYyi
        D+C0FwD34VrcDZVCcOahI+A=
X-Google-Smtp-Source: APiQypLB/1na7gVNCGNE7SQ87SSPjnNj8qDdKt01LKGGYkEIN62URyCQr4qjDOFdCU8tTvCsrfoU8A==
X-Received: by 2002:a5d:4d50:: with SMTP id a16mr1099490wru.219.1586444593744;
        Thu, 09 Apr 2020 08:03:13 -0700 (PDT)
Received: from [192.168.1.254] (host149-67-dynamic.51-79-r.retail.telecomitalia.it. [79.51.67.149])
        by smtp.gmail.com with ESMTPSA id r14sm4186993wmg.0.2020.04.09.08.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 08:03:12 -0700 (PDT)
Subject: Re: [bpf PATCH v3] bpf: verifier, do_refine_retval_range may clamp
 umin to 0 incorrectly
To:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Cc:     yhs@fb.com, ast@kernel.org, daniel@iogearbox.net
References: <158015334199.28573.4940395881683556537.stgit@john-XPS-13-9370>
From:   Lorenzo Fontana <fontanalorenz@gmail.com>
Message-ID: <bbf6acea-e2a1-5bff-1cd5-e3748fd7b7ed@gmail.com>
Date:   Thu, 9 Apr 2020 17:03:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <158015334199.28573.4940395881683556537.stgit@john-XPS-13-9370>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/27/20 8:29 PM, John Fastabend wrote:
> do_refine_retval_range() is called to refine return values from specified
> helpers, probe_read_str and get_stack at the moment, the reasoning is
> because both have a max value as part of their input arguments and
> because the helper ensure the return value will not be larger than this
> we can set smax values of the return register, r0.
> 
> However, the return value is a signed integer so setting umax is incorrect
> It leads to further confusion when the do_refine_retval_range() then calls,
> __reg_deduce_bounds() which will see a umax value as meaning the value is
> unsigned and then assuming it is unsigned set the smin = umin which in this
> case results in 'smin = 0' and an 'smax = X' where X is the input argument
> from the helper call.
> 
> Here are the comments from _reg_deduce_bounds() on why this would be safe
> to do.
> 
>  /* Learn sign from unsigned bounds.  Signed bounds cross the sign
>   * boundary, so we must be careful.
>   */
>  if ((s64)reg->umax_value >= 0) {
> 	/* Positive.  We can't learn anything from the smin, but smax
> 	 * is positive, hence safe.
> 	 */
> 	reg->smin_value = reg->umin_value;
> 	reg->smax_value = reg->umax_value = min_t(u64, reg->smax_value,
> 						  reg->umax_value);
> 
> But now we incorrectly have a return value with type int with the
> signed bounds (0,X). Suppose the return value is negative, which is
> possible the we have the verifier and reality out of sync. Among other
> things this may result in any error handling code being falsely detected
> as dead-code and removed. For instance the example below shows using
> bpf_probe_read_str() causes the error path to be identified as dead
> code and removed.
> 
>>From the 'llvm-object -S' dump,
> 
>  r2 = 100
>  call 45
>  if r0 s< 0 goto +4
>  r4 = *(u32 *)(r7 + 0)
> 
> But from dump xlate
> 
>   (b7) r2 = 100
>   (85) call bpf_probe_read_compat_str#-96768
>   (61) r4 = *(u32 *)(r7 +0)  <-- dropped if goto
> 
> Due to verifier state after call being
> 
>  R0=inv(id=0,umax_value=100,var_off=(0x0; 0x7f))
> 
> To fix omit setting the umax value because its not safe. The only
> actual bounds we know is the smax. This results in the correct bounds
> (SMIN, X) where X is the max length from the helper. After this the
> new verifier state looks like the following after call 45.
> 
> R0=inv(id=0,smax_value=100)
> 
> Then xlated version no longer removed dead code giving the expected
> result,
> 
>   (b7) r2 = 100
>   (85) call bpf_probe_read_compat_str#-96768
>   (c5) if r0 s< 0x0 goto pc+4
>   (61) r4 = *(u32 *)(r7 +0)
> 
> Note, bpf_probe_read_* calls are root only so we wont hit this case
> with non-root bpf users.
> 
> v3: comment had some documentation about meta set to null case which
> is not relevant here and confusing to include in the comment.
> 
> v2 note: In original version we set msize_smax_value from check_func_arg()
> and propagated this into smax of retval. The logic was smax is the bound
> on the retval we set and because the type in the helper is ARG_CONST_SIZE
> we know that the reg is a positive tnum_const() so umax=smax. Alexei
> pointed out though this is a bit odd to read because the register in
> check_func_arg() has a C type of u32 and the umax bound would be the
> normally relavent bound here. Pulling in extra knowledge about future
> checks makes reading the code a bit tricky. Further having a signed
> meta data that can only ever be positive is also a bit odd. So dropped
> the msize_smax_value metadata and made it a u64 msize_max_value to
> indicate its unsigned. And additionally save bound from umax value in
> check_arg_funcs which is the same as smax due to as noted above tnumx_cont
> and negative check but reads better. By my analysis nothing functionally
> changes in v2 but it does get easier to read so that is win.
> 
> Fixes: 849fa50662fbc ("bpf/verifier: refine retval R0 state for bpf_get_stack helper")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  kernel/bpf/verifier.c |   19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7d530ce8719d..adeee88102e5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -227,8 +227,7 @@ struct bpf_call_arg_meta {
>  	bool pkt_access;
>  	int regno;
>  	int access_size;
> -	s64 msize_smax_value;
> -	u64 msize_umax_value;
> +	u64 msize_max_value;
>  	int ref_obj_id;
>  	int func_id;
>  	u32 btf_id;
> @@ -3569,11 +3568,15 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
>  	} else if (arg_type_is_mem_size(arg_type)) {
>  		bool zero_size_allowed = (arg_type == ARG_CONST_SIZE_OR_ZERO);
>  
> -		/* remember the mem_size which may be used later
> -		 * to refine return values.
> +		/* This is used to refine r0 return value bounds for helpers
> +		 * that enforce this value as an upper bound on return values.
> +		 * See do_refine_retval_range() for helpers that can refine
> +		 * the return value. C type of helper is u32 so we pull register
> +		 * bound from umax_value however, if negative verifier errors
> +		 * out. Only upper bounds can be learned because retval is an
> +		 * int type and negative retvals are allowed.
>  		 */
> -		meta->msize_smax_value = reg->smax_value;
> -		meta->msize_umax_value = reg->umax_value;
> +		meta->msize_max_value = reg->umax_value;
>  
>  		/* The register is SCALAR_VALUE; the access check
>  		 * happens using its boundaries.
> @@ -4077,10 +4080,10 @@ static void do_refine_retval_range(struct bpf_reg_state *regs, int ret_type,
>  	     func_id != BPF_FUNC_probe_read_str))
>  		return;
>  
> -	ret_reg->smax_value = meta->msize_smax_value;
> -	ret_reg->umax_value = meta->msize_umax_value;
> +	ret_reg->smax_value = meta->msize_max_value;
>  	__reg_deduce_bounds(ret_reg);
>  	__reg_bound_offset(ret_reg);
> +	__update_reg_bounds(ret_reg);
>  }
>  
>  static int
> 



I've been working on this problem too. Based on what we did to fix it in our BPF program by changing the return value conditionals [0], the reasoning behind this patch looks good to me. I also tried to apply this patch series and I don't see the loop happening in the xlated code.

Thanks for working on this John.


[0] https://patch-diff.githubusercontent.com/raw/draios/sysdig/pull/1612.patch
