Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9093D9BCD
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 04:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbhG2Cbt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 22:31:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233256AbhG2Cbt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 22:31:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0049F60EE6;
        Thu, 29 Jul 2021 02:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627525906;
        bh=5/HPsHebrbOaMgQbW5JROk/C+DP2BAD0a73b/obXv4E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LhrofssXNc8Asa7WCNotX/fpvkxjERXBZds7ZUxQkbKAbYauuuF4PSE8TbH44qL7p
         UCOD1bewpwnhFALcDbG7PRV7F1RPI2ASbxFrQmi40oBTtRz7qlThZOQWREU0jl40un
         FCubINpWAI6di76VWiysZ6FRiHWB4x8lL9v9D+TxvYPgsOnO/Ts/v5lai6lL3I0olW
         BJczbN72y3HNFGiEmlrFyRc5pBjrRMzXcfDpplE71IQucpUO2NVVz3lILgKFgnBotr
         vgT3Bas/bHRgV2tZkkdjvefeyWF59jq5s8rOhQhZpc+lrvYiWjC8BiHF4jqoUlLjax
         AVnklcWhu3+rA==
Date:   Thu, 29 Jul 2021 11:31:42 +0900
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
Message-Id: <20210729113142.b0b26ad823e2350680347473@kernel.org>
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

Hi Josh,

I found one mistake on this patch. You have to add STACK_FRAME_NON_STANDARD_FP() in
case of !CONFIG_STACK_VALIDATION.

diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index c9575ed91052..aca52db2f3f3 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -138,6 +138,7 @@ struct unwind_hint {
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)      \
        "\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
+#define STACK_FRAME_NON_STANDARD_FP(func)
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0

Anyway, I will send my series including these patches and this fix as v10.

Thank you,


On Sat, 10 Jul 2021 12:24:33 -0700
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> Add a CONFIG_FRAME_POINTER-specific version of
> STACK_FRAME_NON_STANDARD() for the case where a function is
> intentionally missing frame pointer setup, but otherwise needs
> objtool/ORC coverage when frame pointers are disabled.
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
