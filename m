Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AC03C39BF
	for <lists+bpf@lfdr.de>; Sun, 11 Jul 2021 03:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhGKBTX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Jul 2021 21:19:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhGKBTW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Jul 2021 21:19:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A38061278;
        Sun, 11 Jul 2021 01:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625966196;
        bh=wrPvJNgH7+dtA6dPKTQidUVk07+TMZ2qL9MLt6idkBw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fe9YSuQmElVFxLsqhI+kuIGvS77fGgoyiMd4TKHtd8MQTKpLryj+JUteEtDiQmN4V
         N7/EEz5q5Rz4oqQYYV1+FtxJ2mprRvPfVl/uFq4b01yEh/XDura0XEyksRXs1AlVYT
         QTXQp4g34UjuZCrXj2Ih/TlxIcm/2KR1q2BRcr5Vej3a19/7PvH4ARJXVATy2aSSnq
         apnCtPlve6P9fQUVcqWKDZgpanyss0wqNKSP5o7WjMfJf+d/eZOdgmN8HWG4I2GJ15
         cTnFGH5FmlL783mPtUA8+o/WX33B9cp+gcVxZrgo8ALUiucNe0zO8Dao42BGleg27X
         5NafNlfaxmB7g==
Date:   Sun, 11 Jul 2021 10:16:33 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH 1/2] objtool: Add frame-pointer-specific function ignore
Message-Id: <20210711101633.eaceff78742984c641993ced@kernel.org>
In-Reply-To: <20210710192433.x5cgjsq2ksvaqnss@treble>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
        <162399996966.506599.810050095040575221.stgit@devnote2>
        <YOK8pzp8B2V+1EaU@gmail.com>
        <20210710003140.8e561ad33d42f9ac78de6a15@kernel.org>
        <20210710104104.3a270168811ac38420093276@kernel.org>
        <20210710190143.lrcsyal2ggubv43v@treble>
        <20210710192433.x5cgjsq2ksvaqnss@treble>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 10 Jul 2021 12:24:33 -0700
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> Add a CONFIG_FRAME_POINTER-specific version of
> STACK_FRAME_NON_STANDARD() for the case where a function is
> intentionally missing frame pointer setup, but otherwise needs
> objtool/ORC coverage when frame pointers are disabled.

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  include/linux/objtool.h       | 11 +++++++++++
>  tools/include/linux/objtool.h | 11 +++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/include/linux/objtool.h b/include/linux/objtool.h
> index 7e72d975cb76..c9575ed91052 100644
> --- a/include/linux/objtool.h
> +++ b/include/linux/objtool.h
> @@ -66,6 +66,17 @@ struct unwind_hint {
>  	static void __used __section(".discard.func_stack_frame_non_standard") \
>  		*__func_stack_frame_non_standard_##func = func
>  
> +/*
> + * STACK_FRAME_NON_STANDARD_FP() is a frame-pointer-specific function ignore
> + * for the case where a function is intentionally missing frame pointer setup,
> + * but otherwise needs objtool/ORC coverage when frame pointers are disabled.
> + */
> +#ifdef CONFIG_FRAME_POINTER
> +#define STACK_FRAME_NON_STANDARD_FP(func) STACK_FRAME_NON_STANDARD(func)
> +#else
> +#define STACK_FRAME_NON_STANDARD_FP(func)
> +#endif
> +
>  #else /* __ASSEMBLY__ */
>  
>  /*
> diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
> index 7e72d975cb76..c9575ed91052 100644
> --- a/tools/include/linux/objtool.h
> +++ b/tools/include/linux/objtool.h
> @@ -66,6 +66,17 @@ struct unwind_hint {
>  	static void __used __section(".discard.func_stack_frame_non_standard") \
>  		*__func_stack_frame_non_standard_##func = func
>  
> +/*
> + * STACK_FRAME_NON_STANDARD_FP() is a frame-pointer-specific function ignore
> + * for the case where a function is intentionally missing frame pointer setup,
> + * but otherwise needs objtool/ORC coverage when frame pointers are disabled.
> + */
> +#ifdef CONFIG_FRAME_POINTER
> +#define STACK_FRAME_NON_STANDARD_FP(func) STACK_FRAME_NON_STANDARD(func)
> +#else
> +#define STACK_FRAME_NON_STANDARD_FP(func)
> +#endif
> +
>  #else /* __ASSEMBLY__ */
>  
>  /*
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
