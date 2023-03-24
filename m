Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F421D6C8460
	for <lists+bpf@lfdr.de>; Fri, 24 Mar 2023 19:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjCXSDo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 14:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjCXSC0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 210A08A59;
        Fri, 24 Mar 2023 11:02:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28299113E;
        Fri, 24 Mar 2023 11:02:05 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.56.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A01213F71E;
        Fri, 24 Mar 2023 11:01:18 -0700 (PDT)
Date:   Fri, 24 Mar 2023 18:01:13 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, lihuafei1@huawei.com
Subject: Re: [PATCH v3 2/4] arm64: ftrace: Simplify get_ftrace_plt
Message-ID: <ZB3laWS5+X13nhvi@FVFF77S0Q05N>
References: <20230324171451.2752302-1-revest@chromium.org>
 <20230324171451.2752302-3-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324171451.2752302-3-revest@chromium.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 24, 2023 at 06:14:49PM +0100, Florent Revest wrote:
> Following recent refactorings, the get_ftrace_plt function only ever
> gets called with addr = FTRACE_ADDR so its code can be simplified to
> always return the ftrace trampoline plt.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/ftrace.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index 758436727fba..432626c866a8 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -195,15 +195,15 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
>  	return ftrace_modify_code(pc, 0, new, false);
>  }
>  
> -static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
> +static struct plt_entry *get_ftrace_plt(struct module *mod)
>  {
>  #ifdef CONFIG_ARM64_MODULE_PLTS
>  	struct plt_entry *plt = mod->arch.ftrace_trampolines;
>  
> -	if (addr == FTRACE_ADDR)
> -		return &plt[FTRACE_PLT_IDX];
> -#endif
> +	return &plt[FTRACE_PLT_IDX];
> +#else
>  	return NULL;
> +#endif
>  }
>  
>  static bool reachable_by_bl(unsigned long addr, unsigned long pc)
> @@ -270,7 +270,7 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec,
>  	if (WARN_ON(!mod))
>  		return false;
>  
> -	plt = get_ftrace_plt(mod, *addr);
> +	plt = get_ftrace_plt(mod);
>  	if (!plt) {
>  		pr_err("ftrace: no module PLT for %ps\n", (void *)*addr);
>  		return false;
> -- 
> 2.40.0.348.gf938b09366-goog
> 
