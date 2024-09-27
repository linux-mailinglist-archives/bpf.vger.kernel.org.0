Return-Path: <bpf+bounces-40383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E99987DBE
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 06:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26CD31F238F5
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 04:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A539173332;
	Fri, 27 Sep 2024 04:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebN9ZAxu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5256170858
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 04:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727413117; cv=none; b=jvy4i1MjRHN0x0X8fQMfB52zqi4oqbWeFCx4kz3MzI2ILfJsVCJCrXvstg9P+MptgQ9Nr9Epe6Pc8Z1CTS7qGsgjbKCtuJbmKQbzHOIkyEUp0LCnQ8eNGwPS4L6LkdufDIAiMCeQ534plLyiqYOp0hJtWlevHIGP0gdH6t1eGTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727413117; c=relaxed/simple;
	bh=6f2ilka/xL+hiqjzlegH6wcHA7ZvsKzhScxBhoWUW6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DA4UCiMPlsOE7KChSP8WUYzUO8+0rXk1pPzpBSmiq9+D14XymMz+KEglf1ucuf509a7ztIqfkV3ODrt7TNXUCdXbtCOVe5me9PcsuxI7zVOqj2TERmQl78qzT6qVe5G7St/9/8xuVGfWEB4Nvp5L7a5t2GBaQWNJ58FcmQI4488=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebN9ZAxu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2053616fa36so21201025ad.0
        for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 21:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727413115; x=1728017915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EFrarGO4a6JFp4PDz4txxA1S+4Vrz7JDg28YTigpv4o=;
        b=ebN9ZAxuvDoH5h7OOytFnSRHVrntFmoyJi+X8IthCCSkQGkZdgzBQjVclUzIBa0UYp
         jnCdD8Pm/WzK4Ym0OvSGhAELPRyMOUOwt5irfWpgpoEJvWVi21mFJcit8xdAdHLBIiEI
         my8m5GqWfNP5J+XOQ2mwInyLCaUYttNh/0Djncodlq9BEM1xg3FxjH/+X6bLqfv4686G
         cu+B196kmflxtHvn6x6iHJjwNG1HOMhy+5M9SN94Ljh9Pp+3JhvrHI4yuAnFEeGR1565
         tRHAGEcIo/NCGaFdfnmjfnh/vPBlmD0jnIZajUNpZ2ch9kBBlSAo0R/AsS/91z4hGTcv
         5ExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727413115; x=1728017915;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EFrarGO4a6JFp4PDz4txxA1S+4Vrz7JDg28YTigpv4o=;
        b=JMIuaupebkqz7MnfOe9l2WO3JsgYraAdQgZRBV4Zxmm0AJZAMGjmUA/b2mcsXFsEOW
         moAxLY0n8AuAd+ykJV8ZAst32xxVYoGV5zMG+MCY+Afm9fHt6Ye5ds90W9Dl733PpH1T
         QzLlCeN3/j6N53ZgI9w8t8ralw4UxM29IKHtsTksonkv0RL57pAUqJ9x25bSDUbSaMSI
         I7BVCYBWX8AD8n1YWMydZ187dAt08ewPOfN/K4gq2B+wv6A1dNpHkx7Q9ePf8w256Zdj
         k7hPvNFJuR3P0KaRS+3CzjyRSyj8qg56l22o8is7hnV5fU7gRoH5rw9YwWQHcRf5mT4Q
         sCWg==
X-Forwarded-Encrypted: i=1; AJvYcCX92mzJ9i5qYqw+NrFyyNdDUzv7knN2bLKpHLlf1Wv0TkHKVo/rDJWqVJiE1GF1/WM7HKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxadsT/UE9bpze7T6qN/1V29VxTAiK7Drkr3nDhCpKHhFOsELI+
	ZtP96MharSJSRlY06PMP/+WhsLrKqvDZyOyNP92+rz6Udv5mtYa9
X-Google-Smtp-Source: AGHT+IEtaQFNgEqWiTHBcKxSpbJp6RICKIfHZXQaq9Mq7z1traKs9qYajpoYMCCf12Xnf2wXgrtewA==
X-Received: by 2002:a17:902:fb87:b0:202:28b1:9f34 with SMTP id d9443c01a7336-20b37bc0f7bmr26982675ad.56.1727413114871;
        Thu, 26 Sep 2024 21:58:34 -0700 (PDT)
Received: from [10.22.68.152] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db5ed338sm725411a12.67.2024.09.26.21.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 21:58:34 -0700 (PDT)
Message-ID: <44ddec9e-cc74-4686-9228-52e4db301e8a@gmail.com>
Date: Fri, 27 Sep 2024 12:58:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 4/5] bpf, x86: Add jit support for private
 stack
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <20240926234526.1770736-1-yonghong.song@linux.dev>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20240926234526.1770736-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yonghong,

A brief review about the usage of this_cpu_off on non-SMP systems.

On 27/9/24 07:45, Yonghong Song wrote:
> Add jit support for private stack. For a particular subtree, e.g.,
>   subtree_root <== stack depth 120
>    subprog1    <== stack depth 80
>     subprog2   <== stack depth 40
>    subprog3    <== stack depth 160
> 
> Let us say that private_stack_ptr is the memory address allocated for
> private stack. The frame pointer for each above is calculated like below:
>   subtree_root  <== subtree_root_fp = private_stack_ptr + 120
>    subprog1     <== subtree_subprog1_fp = subtree_root_fp + 80
>     subprog2    <== subtree_subprog2_fp = subtree_subprog1_fp + 40
>    subprog3     <== subtree_subprog1_fp = subtree_root_fp + 160
> 
> For any function call to helper/kfunc, push/pop prog frame pointer
> is needed in order to preserve frame pointer value.
> 
> To deal with exception handling, push/pop frame pointer is also used
> surrounding call to subsequent subprog. For example,
>   subtree_root
>    subprog1
>      ...
>      insn: call bpf_throw
>      ...
> 
> After jit, we will have
>   subtree_root
>    insn: push r9
>    subprog1
>      ...
>      insn: push r9
>      insn: call bpf_throw
>      insn: pop r9
>      ...
>    insn: pop r9
> 
>   exception_handler
>      pop r9
>      ...
> where r9 represents the fp for each subprog.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  arch/x86/net/bpf_jit_comp.c | 87 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 81 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 06b080b61aa5..c264822c926b 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -325,6 +325,22 @@ struct jit_context {
>  /* Number of bytes that will be skipped on tailcall */
>  #define X86_TAIL_CALL_OFFSET	(12 + ENDBR_INSN_SIZE)
>  
> +static void push_r9(u8 **pprog)
> +{
> +	u8 *prog = *pprog;
> +
> +	EMIT2(0x41, 0x51);   /* push r9 */
> +	*pprog = prog;
> +}
> +
> +static void pop_r9(u8 **pprog)
> +{
> +	u8 *prog = *pprog;
> +
> +	EMIT2(0x41, 0x59);   /* pop r9 */
> +	*pprog = prog;
> +}
> +
>  static void push_r12(u8 **pprog)
>  {
>  	u8 *prog = *pprog;
> @@ -491,7 +507,7 @@ static void emit_prologue_tail_call(u8 **pprog, bool is_subprog)
>   */
>  static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>  			  bool tail_call_reachable, bool is_subprog,
> -			  bool is_exception_cb)
> +			  bool is_exception_cb, enum bpf_pstack_state  pstack)
>  {
>  	u8 *prog = *pprog;
>  
> @@ -518,6 +534,8 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>  		 * first restore those callee-saved regs from stack, before
>  		 * reusing the stack frame.
>  		 */
> +		if (pstack)
> +			pop_r9(&prog);
>  		pop_callee_regs(&prog, all_callee_regs_used);
>  		pop_r12(&prog);
>  		/* Reset the stack frame. */
> @@ -1404,6 +1422,22 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
>  	*pprog = prog;
>  }
>  
> +static void emit_private_frame_ptr(u8 **pprog, void *private_frame_ptr)
> +{
> +	u8 *prog = *pprog;
> +
> +	/* movabs r9, private_frame_ptr */
> +	emit_mov_imm64(&prog, X86_REG_R9, (long) private_frame_ptr >> 32,
> +		       (u32) (long) private_frame_ptr);
> +
> +	/* add <r9>, gs:[<off>] */
> +	EMIT2(0x65, 0x4c);
> +	EMIT3(0x03, 0x0c, 0x25);
> +	EMIT((u32)(unsigned long)&this_cpu_off, 4);

It should check CONFIG_SMP here like this commit:
1e9e0b85255e ("bpf: handle CONFIG_SMP=n configuration in x86 BPF JIT").

So, it seems better to reuse the code snippet of the commit.

Thanks,
Leon


