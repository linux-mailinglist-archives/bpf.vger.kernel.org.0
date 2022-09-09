Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB565B3665
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 13:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiIILbX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 07:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiIILbV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 07:31:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD35D11B008
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 04:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f8O3JhWQoFYRzQBV86lfB7OAUyXJCpm3sBLXXPrXxWo=; b=iHS2i3v4aSohR7JTiq1Mk9o572
        PQwbvaIHZyS/SYRMOBVCfW3vkM++v/gpJ4BW1olsYcwP6CdUC/oZcqo0kJRhmHYUzWCpVk9zI73X8
        wbKoo5WPcci/VpmOr3jiwvF5AtfAC4koapCzOyFMTZyhKmChIyS/ozHBS0URVN0sSiHil4poAQL2/
        Dlo1kugf1F1rQyklkgIZDq/xMzQBDKJwoF325InhGWt8kLUWIqOkJvL2Vjo7HzgMYVS8qS+aUFnAT
        2FNrd5wyLr0KT+mA1fKlSwRVDM+bk89sjUW1FqkHxTPTt8ggWuq2sj7Fr4nH0a7YXHNpx/rprAa0C
        bO1T8x5g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWcDl-00B0lY-UU; Fri, 09 Sep 2022 11:30:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F9B1300023;
        Fri,  9 Sep 2022 13:30:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5463C201AF2DB; Fri,  9 Sep 2022 13:30:52 +0200 (CEST)
Date:   Fri, 9 Sep 2022 13:30:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
Subject: Re: [PATCHv3 bpf-next 3/6] bpf: Use given function address for
 trampoline ip arg
Message-ID: <Yxsj7KUhVYYxJ1l9@hirez.programming.kicks-ass.net>
References: <20220909101245.347173-1-jolsa@kernel.org>
 <20220909101245.347173-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909101245.347173-4-jolsa@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 09, 2022 at 12:12:42PM +0200, Jiri Olsa wrote:
> Using function address given at the generation time as the trampoline
> ip argument. This way we get directly the function address that we
> need, so we don't need to:
>   - read the ip from the stack
>   - subtract X86_PATCH_SIZE
>   - subtract ENDBR_INSN_SIZE if CONFIG_X86_KERNEL_IBT is enabled
>     which is not even implemented yet ;-)
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/net/bpf_jit_comp.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index ae89f4143eb4..1047686cc545 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2039,13 +2039,14 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
>  int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
>  				const struct btf_func_model *m, u32 flags,
>  				struct bpf_tramp_links *tlinks,
> -				void *orig_call)
> +				void *func_addr)
>  {
>  	int ret, i, nr_args = m->nr_args, extra_nregs = 0;
>  	int regs_off, ip_off, args_off, stack_size = nr_args * 8, run_ctx_off;
>  	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
>  	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
>  	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
> +	void *orig_call = func_addr;
>  	u8 **branches = NULL;
>  	u8 *prog;
>  	bool save_ret;
> @@ -2126,12 +2127,10 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>  
>  	if (flags & BPF_TRAMP_F_IP_ARG) {
>  		/* Store IP address of the traced function:
> -		 * mov rax, QWORD PTR [rbp + 8]
> -		 * sub rax, X86_PATCH_SIZE
> +		 * mov rax, func_addr

Shouldn't that be: movabs? Regular mov can't do 64bit immediates.

Also curse Intel syntax, this is bloody unreadable.

>  		 * mov QWORD PTR [rbp - ip_off], rax
>  		 */
> -		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
> -		EMIT4(0x48, 0x83, 0xe8, X86_PATCH_SIZE);
> +		emit_mov_imm64(&prog, BPF_REG_0, (long) func_addr >> 32, (u32) (long) func_addr);
>  		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
>  	}
>  
> -- 
> 2.37.3
> 
