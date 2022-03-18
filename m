Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383214DE19A
	for <lists+bpf@lfdr.de>; Fri, 18 Mar 2022 20:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbiCRTKn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Mar 2022 15:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiCRTKm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Mar 2022 15:10:42 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7336E1250
        for <bpf@vger.kernel.org>; Fri, 18 Mar 2022 12:09:21 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t14so5670340pgr.3
        for <bpf@vger.kernel.org>; Fri, 18 Mar 2022 12:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E2zwNWduQR0Aa76BgkNa/DHHV6ky4Gvuek8G0iw/1ZY=;
        b=D5OzHPO+NMVB7I6s+crfV1diAJDObI1fZNqqxoNyo40Z3OUQkSo+d292Fn27lIVovV
         akWdS/Gi1FhXQJWXm07la4m6Ugz7/Af6cUK5yT64AP0IhQFEeBzEZsHOmtuijSx/V1L0
         1Jrxb7fQwcJdHMhOX7Gas/8ACQf2ezQGcO/hbLFZxVYhjVJRot+RPv188+o9cVZUyJ+1
         Yh3LhAJyfqFit7h7VQubPrNqh5whRIbJyLPoiemRbFTKMiC7ivT6MzhmLPWTGymJWwwK
         Vx5XawAeVswG23LgrFsoT5kqGCPtoveWufSIe/tVJt279U+aAWMw46nLMKzt5Fob09m9
         obkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E2zwNWduQR0Aa76BgkNa/DHHV6ky4Gvuek8G0iw/1ZY=;
        b=nvzrTdtueNOGWfQDHgG217vKH3w0Lnn0DQHrbQsfUZVvT99L92AQcMVDE6i9e7Y9W4
         TMwQoG5e3wW/T6jLMcCgajDP4wYqkXHQMW/dNEuzuodXFL+tGDjoK/yK9pHlhrqGEw+2
         CAj77jqq2XwSIGGHdkwUarUxw+1a9E8vyrvNkgvS4Nn52CDyYP1sAFpI1J5UnGKd0T73
         1YNqH0HhbwOyhhkZeLhSpfpFRTFKM1F2yOJ7I82/TF0NLJYCOu/0Dz3tArCBVVWOt6nF
         6myyIuBe7vvcHrKML37sgBhsmjtEcdJ+sFNJgKpnH+I6nFbDwc53qnYFpqsWVS1x05dt
         YTcw==
X-Gm-Message-State: AOAM5314dD0582pCg4rzsmqBDiIi9NuJiV+88jMLkXALiSzIrRLpVHp0
        5ODnD0jub7IHsLx/CmHqB8c=
X-Google-Smtp-Source: ABdhPJxLKoegdwBCTEG1RaimW/7rlVfNQwnYohbGVpx1ayQxKMYofg4cYXsnG44DvlyiZwhUQbFgFg==
X-Received: by 2002:a05:6a00:1a11:b0:4f7:bf07:c068 with SMTP id g17-20020a056a001a1100b004f7bf07c068mr11452338pfv.81.1647630560461;
        Fri, 18 Mar 2022 12:09:20 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:400::5:7e8b])
        by smtp.gmail.com with ESMTPSA id k1-20020a056a00134100b004f78df32666sm11016867pfu.198.2022.03.18.12.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 12:09:19 -0700 (PDT)
Date:   Fri, 18 Mar 2022 12:09:17 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Subject: Re: [PATCH bpf-next v2 2/4] bpf, x86: Create bpf_trace_run_ctx on
 the caller thread's stack
Message-ID: <20220318190917.tecjespuzkegwb2k@ast-mbp>
References: <20220316004231.1103318-1-kuifeng@fb.com>
 <20220316004231.1103318-3-kuifeng@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316004231.1103318-3-kuifeng@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 15, 2022 at 05:42:29PM -0700, Kui-Feng Lee wrote:
> BPF trampolines will create a bpf_trace_run_ctx on their stacks, and
> set/reset the current bpf_run_ctx whenever calling/returning from a
> bpf_prog.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 32 ++++++++++++++++++++++++++++++++
>  include/linux/bpf.h         | 12 ++++++++----
>  kernel/bpf/syscall.c        |  4 ++--
>  kernel/bpf/trampoline.c     | 21 +++++++++++++++++----
>  4 files changed, 59 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 1228e6e6a420..29775a475513 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1748,10 +1748,33 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
>  {
>  	u8 *prog = *pprog;
>  	u8 *jmp_insn;
> +	int ctx_cookie_off = offsetof(struct bpf_trace_run_ctx, bpf_cookie);
>  	struct bpf_prog *p = l->prog;
>  
> +	EMIT1(0x52);		 /* push rdx */

Why save/restore rdx?

> +
> +	/* mov rdi, 0 */
> +	emit_mov_imm64(&prog, BPF_REG_1, 0, 0);
> +
> +	/* Prepare struct bpf_trace_run_ctx.
> +	 * sub rsp, sizeof(struct bpf_trace_run_ctx)
> +	 * mov rax, rsp
> +	 * mov QWORD PTR [rax + ctx_cookie_off], rdi
> +	 */

How about the following instead:
sub rsp, sizeof(struct bpf_trace_run_ctx)
mov qword ptr [rsp + ctx_cookie_off], 0
?

> +	EMIT4(0x48, 0x83, 0xEC, sizeof(struct bpf_trace_run_ctx));
> +	EMIT3(0x48, 0x89, 0xE0);
> +	EMIT4(0x48, 0x89, 0x78, ctx_cookie_off);
> +
> +	/* mov rdi, rsp */
> +	EMIT3(0x48, 0x89, 0xE7);
> +	/* mov QWORD PTR [rdi + sizeof(struct bpf_trace_run_ctx)], rax */
> +	emit_stx(&prog, BPF_DW, BPF_REG_1, BPF_REG_0, sizeof(struct bpf_trace_run_ctx));

why not to do:
mov qword ptr[rsp + sizeof(struct bpf_trace_run_ctx)], rsp
?

> +
>  	/* arg1: mov rdi, progs[i] */
>  	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
> +	/* arg2: mov rsi, rsp (struct bpf_run_ctx *) */
> +	EMIT3(0x48, 0x89, 0xE6);
> +
>  	if (emit_call(&prog,
>  		      p->aux->sleepable ? __bpf_prog_enter_sleepable :
>  		      __bpf_prog_enter, prog))
> @@ -1797,11 +1820,20 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
>  	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
>  	/* arg2: mov rsi, rbx <- start time in nsec */
>  	emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
> +	/* arg3: mov rdx, rsp (struct bpf_run_ctx *) */
> +	EMIT3(0x48, 0x89, 0xE2);
>  	if (emit_call(&prog,
>  		      p->aux->sleepable ? __bpf_prog_exit_sleepable :
>  		      __bpf_prog_exit, prog))
>  			return -EINVAL;
>  
> +	/* pop struct bpf_trace_run_ctx
> +	 * add rsp, sizeof(struct bpf_trace_run_ctx)
> +	 */
> +	EMIT4(0x48, 0x83, 0xC4, sizeof(struct bpf_trace_run_ctx));

the sub rsp; add rsp pair for every prog call will add up.
Could you do sub rsp once at the beginning of trampoline?
And move
mov qword ptr[rsp + sizeof(struct bpf_trace_run_ctx)], rsp
to the beginning as well?

> +
> +	EMIT1(0x5A); /* pop rdx */
> +
>  	*pprog = prog;
>  	return 0;
>  }
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3dcae8550c21..d20a23953696 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -681,6 +681,8 @@ struct bpf_tramp_links {
>  	int nr_links;
>  };
>  
> +struct bpf_trace_run_ctx;
> +
>  /* Different use cases for BPF trampoline:
>   * 1. replace nop at the function entry (kprobe equivalent)
>   *    flags = BPF_TRAMP_F_RESTORE_REGS
> @@ -707,10 +709,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *tr, void *image, void *i
>  				struct bpf_tramp_links *tlinks,
>  				void *orig_call);
>  /* these two functions are called from generated trampoline */
> -u64 notrace __bpf_prog_enter(struct bpf_prog *prog);
> -void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start);
> -u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog);
> -void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start);
> +u64 notrace __bpf_prog_enter(struct bpf_prog *prog, struct bpf_trace_run_ctx *run_ctx);
> +void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start, struct bpf_trace_run_ctx *run_ctx);
> +u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog, struct bpf_trace_run_ctx *run_ctx);
> +void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start,
> +				       struct bpf_trace_run_ctx *run_ctx);
>  void notrace __bpf_tramp_enter(struct bpf_tramp_image *tr);
>  void notrace __bpf_tramp_exit(struct bpf_tramp_image *tr);
>  
> @@ -1291,6 +1294,7 @@ struct bpf_cg_run_ctx {
>  struct bpf_trace_run_ctx {
>  	struct bpf_run_ctx run_ctx;
>  	u64 bpf_cookie;
> +	struct bpf_run_ctx *saved_run_ctx;
>  };
>  
>  static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *new_ctx)
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index fecfc803785d..a289ef55ea17 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4793,13 +4793,13 @@ BPF_CALL_3(bpf_sys_bpf, int, cmd, union bpf_attr *, attr, u32, attr_size)
>  			return -EINVAL;
>  		}
>  
> -		if (!__bpf_prog_enter_sleepable(prog)) {
> +		if (!__bpf_prog_enter_sleepable(prog, NULL)) {
>  			/* recursion detected */
>  			bpf_prog_put(prog);
>  			return -EBUSY;
>  		}
>  		attr->test.retval = bpf_prog_run(prog, (void *) (long) attr->test.ctx_in);
> -		__bpf_prog_exit_sleepable(prog, 0 /* bpf_prog_run does runtime stats */);
> +		__bpf_prog_exit_sleepable(prog, 0 /* bpf_prog_run does runtime stats */, NULL);
>  		bpf_prog_put(prog);
>  		return 0;
>  #endif
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 54c695d49ec9..0b050aa2f159 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -580,9 +580,12 @@ static void notrace inc_misses_counter(struct bpf_prog *prog)
>   * [2..MAX_U64] - execute bpf prog and record execution time.
>   *     This is start time.
>   */
> -u64 notrace __bpf_prog_enter(struct bpf_prog *prog)
> +u64 notrace __bpf_prog_enter(struct bpf_prog *prog, struct bpf_trace_run_ctx *run_ctx)
>  	__acquires(RCU)
>  {
> +	if (run_ctx)
> +		run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);

We can remove these branches from critical path if we path actual run_ctx
instead of NULL in bpf_sys_bpf, right?

> +
>  	rcu_read_lock();
>  	migrate_disable();
>  	if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1)) {
> @@ -614,17 +617,23 @@ static void notrace update_prog_stats(struct bpf_prog *prog,
>  	}
>  }
>  
> -void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
> +void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start, struct bpf_trace_run_ctx *run_ctx)
>  	__releases(RCU)
>  {
> +	if (run_ctx)
> +		bpf_reset_run_ctx(run_ctx->saved_run_ctx);
> +
>  	update_prog_stats(prog, start);
>  	__this_cpu_dec(*(prog->active));
>  	migrate_enable();
>  	rcu_read_unlock();
>  }
>  
> -u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog)
> +u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog, struct bpf_trace_run_ctx *run_ctx)
>  {
> +	if (run_ctx)
> +		run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
> +
>  	rcu_read_lock_trace();
>  	migrate_disable();
>  	might_fault();
> @@ -635,8 +644,12 @@ u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog)
>  	return bpf_prog_start_time();
>  }
>  
> -void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start)
> +void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start,
> +				       struct bpf_trace_run_ctx *run_ctx)
>  {
> +	if (run_ctx)
> +		bpf_reset_run_ctx(run_ctx->saved_run_ctx);
> +
>  	update_prog_stats(prog, start);
>  	__this_cpu_dec(*(prog->active));
>  	migrate_enable();
> -- 
> 2.30.2
> 

-- 
