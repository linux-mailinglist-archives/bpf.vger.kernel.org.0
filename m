Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA982FDA91
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 21:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbhATUNa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 15:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbhATUN0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jan 2021 15:13:26 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB119C061575;
        Wed, 20 Jan 2021 12:12:46 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id u11so8838324plg.13;
        Wed, 20 Jan 2021 12:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=foCHEt7FF+EjVn9rkpAiAjBdZYjzS1bV8BzUmJzcbPo=;
        b=Q9XdDX0MAlt5hi2UrISiWdD7xCVePjhFsVXJnccCCtHFjnbiaBb8EzicUF9OxrtCzI
         2WRg7sPPfH+y4CNj+jB2/BTJq2iVbOevqICybIAa33UM+KnGbHaE7EiAHIvwfdoFvVU8
         bTpnwz0XdbIfymXkdiWXMYPAACwx0ze6iBbDNEf0QjiSo1lLMOJM9PNdlvdE+Zgh46Qr
         OVl8/R7kbmEJjoJD4leoSEsgqvE/R0VmlIProKI5vyyENFbYeRyXlcwzZqBAk+VZdvxy
         nW3c2tR9gdukSkz8GJYpz6XhTRNF62710b5b3M0HBUXOdvzWWapqADGcKxAsjcoNIycY
         eIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=foCHEt7FF+EjVn9rkpAiAjBdZYjzS1bV8BzUmJzcbPo=;
        b=uVTls6k6scFQ+l9csR+cWiQfN5srF/6YfqK9i8fkelpvVWB/L+VAMvisyRpbWWZMdk
         BZyayydEsiMAxp1DdbRHG22zzzq3KZ04MvyofA01rts/NqeBSx8LD1zTY/HdBhCiz3S5
         G4MZbug2hSPA8IgdJebTNVmyLd4lO4QIjI4UZM3Gj47n/X9NC6oDnC5rDS7K0G3jhj/H
         nXJd6LDKCK1X/OxjPcu74m/CZfGcT8TtYuSAEszobV7IyFlCGZyEIkjKpbOgB63D8VSZ
         uBOdNXFYl68tAyts/c+pfU80mBxzOXhtAucPjAht0abbqOs+dGX0xWYXK7hfKADYa1et
         qn9w==
X-Gm-Message-State: AOAM533yV85j7HwnJALxcB6xLcXIPPu21vPaL5BM8uh+1LSM2apX9H6n
        tc17oByK+1ol4iIwDTFvmg3y2hytNbk=
X-Google-Smtp-Source: ABdhPJxKt0KR2r/H1xrow2AhFhVvm9PkmwfZy4ZVoqnSA1JdlbNcpZr71L3A4LKR+0MirY6fItSETg==
X-Received: by 2002:a17:90a:d145:: with SMTP id t5mr7548907pjw.104.1611173565876;
        Wed, 20 Jan 2021 12:12:45 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:bed2])
        by smtp.gmail.com with ESMTPSA id 186sm3015756pfx.100.2021.01.20.12.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 12:12:45 -0800 (PST)
Date:   Wed, 20 Jan 2021 12:12:42 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Propagate memory bounds to registers in
 atomics w/ BPF_FETCH
Message-ID: <20210120201242.nm35li5yxvo7ir35@ast-mbp.dhcp.thefacebook.com>
References: <20210118160613.541020-1-jackmanb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118160613.541020-1-jackmanb@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 18, 2021 at 04:06:13PM +0000, Brendan Jackman wrote:
> When BPF_FETCH is set, atomic instructions load a value from memory
> into a register. The current verifier code first checks via
> check_mem_access whether we can access the memory, and then checks
> via check_reg_arg whether we can write into the register.
> 
> For loads, check_reg_arg has the side-effect of marking the
> register's value as unkonwn, and check_mem_access has the side effect
> of propagating bounds from memory to the register.
> 
> Therefore with the current order, bounds information is thrown away,
> but by simply reversing the order of check_reg_arg
> vs. check_mem_access, we can instead propagate bounds smartly.

I think such improvement makes sense, but please tweak commit log
to mention that check_mem_access() is doing it only for stack pointers.
Since "propagating from memory" is too generic. Most memory
won't have such propagation.

> A simple test is added with an infinite loop that can only be proved
> unreachable if this propagation is present.
> 
> Note that in the test, the memory value has to be written with two
> instructions:
> 
> 		BPF_MOV64_IMM(BPF_REG_0, 0),
> 		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
> 
> instead of one:
> 
> 		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> 
> Because BPF_ST_MEM doesn't seem to set the stack slot type to 0 when
> storing an immediate.

This bit is confusing in the commit log. Pls move it into test itself.

> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  kernel/bpf/verifier.c                         | 32 +++++++++++--------
>  .../selftests/bpf/verifier/atomic_bounds.c    | 18 +++++++++++
>  2 files changed, 36 insertions(+), 14 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/verifier/atomic_bounds.c
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0f82d5d46e2c..0512695c70f4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3663,9 +3663,26 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>  		return -EACCES;
>  	}
>  
> +	if (insn->imm & BPF_FETCH) {
> +		if (insn->imm == BPF_CMPXCHG)
> +			load_reg = BPF_REG_0;
> +		else
> +			load_reg = insn->src_reg;
> +
> +		/* check and record load of old value */
> +		err = check_reg_arg(env, load_reg, DST_OP);
> +		if (err)
> +			return err;
> +	} else {
> +		/* This instruction accesses a memory location but doesn't
> +		 * actually load it into a register.
> +		 */
> +		load_reg = -1;
> +	}
> +
>  	/* check whether we can read the memory */
>  	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
> -			       BPF_SIZE(insn->code), BPF_READ, -1, true);
> +			       BPF_SIZE(insn->code), BPF_READ, load_reg, true);
>  	if (err)
>  		return err;
>  
> @@ -3675,19 +3692,6 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>  	if (err)
>  		return err;
>  
> -	if (!(insn->imm & BPF_FETCH))
> -		return 0;
> -
> -	if (insn->imm == BPF_CMPXCHG)
> -		load_reg = BPF_REG_0;
> -	else
> -		load_reg = insn->src_reg;
> -
> -	/* check and record load of old value */
> -	err = check_reg_arg(env, load_reg, DST_OP);
> -	if (err)
> -		return err;
> -
>  	return 0;
>  }
>  
> diff --git a/tools/testing/selftests/bpf/verifier/atomic_bounds.c b/tools/testing/selftests/bpf/verifier/atomic_bounds.c
> new file mode 100644
> index 000000000000..45030165ed63
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/verifier/atomic_bounds.c
> @@ -0,0 +1,18 @@
> +{
> +	"BPF_ATOMIC bounds propagation, mem->reg",
> +	.insns = {
> +		/* a = 0; */
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
> +		/* b = atomic_fetch_add(&a, 1); */
> +		BPF_MOV64_IMM(BPF_REG_1, 1),
> +		BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH, BPF_REG_10, BPF_REG_1, -8),
> +		/* Verifier should be able to tell that this infinite loop isn't reachable. */
> +		/* if (b) while (true) continue; */
> +		BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, -1),
> +		BPF_EXIT_INSN(),

I think it's a bit unrealistic to use atomic_add to increment induction variable,
but I don't mind, since the verifier side is simple.
Could you add a C based test as well?
