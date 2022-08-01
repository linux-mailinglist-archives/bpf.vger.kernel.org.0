Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A106658702A
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 20:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiHASFI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 14:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiHASFH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 14:05:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F92427FC2;
        Mon,  1 Aug 2022 11:05:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A804B81613;
        Mon,  1 Aug 2022 18:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D749C433C1;
        Mon,  1 Aug 2022 18:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659377102;
        bh=WZn339z16/lJcxvgPxNR7mrRBsQuXDgDYpAiYuNzx5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f6N6Gu/0OX4dBOkvVeo4EYMwWss8/I7tFwLjpZ5KYuwtJXOElG1NANoVk0HcWo9eH
         rvxycBicHezG1h3Z7phG8d9F9bmK518a/+y49Orsf/7/OIHkmf1+wiZ3K5WeMqOQ6Z
         4prygSSWUXegtSwGZDOR1Lt1hVypCFlbpPRbBPRT/uPXMCDKQeYKvUbmPAwWL4v1mz
         HsGpM9OSs999M0nhpJGdmc44vpMxnFw5y/4/4sVhTE/pJ+j2qjLbTPIXrAn6hfmlgt
         dJQ0Xnkwi9Iw1v9/mUNpHMqqMR3Cg2//f6bKPFEgdSBUjcKA5eMzxWeJEPZITinI6T
         l4qZCfe9d/1Gw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 74AA640736; Mon,  1 Aug 2022 15:05:00 -0300 (-03)
Date:   Mon, 1 Aug 2022 15:05:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andres Freund <andres@anarazel.de>, Ben Hutchings <benh@debian.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH v3 3/8] tools include: add dis-asm-compat.h to handle
 version differences
Message-ID: <YugVzJqQhp2rYRvS@kernel.org>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220801013834.156015-1-andres@anarazel.de>
 <20220801013834.156015-4-andres@anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801013834.156015-4-andres@anarazel.de>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sun, Jul 31, 2022 at 06:38:29PM -0700, Andres Freund escreveu:
> binutils changed the signature of init_disassemble_info(), which now causes
> compilation failures for tools/{perf,bpf}, e.g. on debian unstable.
> Relevant binutils commit:
> https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07
> 
> This commit introduces a wrapper for init_disassemble_info(), to avoid
> spreading #ifdef DISASM_INIT_STYLED to a bunch of places. Subsequent
> commits will use it to fix the build failures.
> 
> It likely is worth adding a wrapper for disassember(), to avoid the already
> existing DISASM_FOUR_ARGS_SIGNATURE ifdefery.
> 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Cc: Quentin Monnet <quentin@isovalent.com>
> Cc: Ben Hutchings <benh@debian.org>
> Link: http://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
> Signed-off-by: Andres Freund <andres@anarazel.de>
> Signed-off-by: Ben Hutchings <benh@debian.org>

So, who is the author of this patch? Ben? b4 complained about it:

NOTE: some trailers ignored due to from/email mismatches:
    ! Trailer: Signed-off-by: Ben Hutchings <benh@debian.org>
     Msg From: Andres Freund <andres@anarazel.de>
NOTE: Rerun with -S to apply them anyway

If it is Ben, then we would need a:

From: Ben Hutchings <benh@debian.org>

At the beginning of the patch, right?

- Arnaldo

> ---
>  tools/include/tools/dis-asm-compat.h | 55 ++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 tools/include/tools/dis-asm-compat.h
> 
> diff --git a/tools/include/tools/dis-asm-compat.h b/tools/include/tools/dis-asm-compat.h
> new file mode 100644
> index 000000000000..70f331e23ed3
> --- /dev/null
> +++ b/tools/include/tools/dis-asm-compat.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +#ifndef _TOOLS_DIS_ASM_COMPAT_H
> +#define _TOOLS_DIS_ASM_COMPAT_H
> +
> +#include <stdio.h>
> +#include <dis-asm.h>
> +
> +/* define types for older binutils version, to centralize ifdef'ery a bit */
> +#ifndef DISASM_INIT_STYLED
> +enum disassembler_style {DISASSEMBLER_STYLE_NOT_EMPTY};
> +typedef int (*fprintf_styled_ftype) (void *, enum disassembler_style, const char*, ...);
> +#endif
> +
> +/*
> + * Trivial fprintf wrapper to be used as the fprintf_styled_func argument to
> + * init_disassemble_info_compat() when normal fprintf suffices.
> + */
> +static inline int fprintf_styled(void *out,
> +				 enum disassembler_style style,
> +				 const char *fmt, ...)
> +{
> +	va_list args;
> +	int r;
> +
> +	(void)style;
> +
> +	va_start(args, fmt);
> +	r = vfprintf(out, fmt, args);
> +	va_end(args);
> +
> +	return r;
> +}
> +
> +/*
> + * Wrapper for init_disassemble_info() that hides version
> + * differences. Depending on binutils version and architecture either
> + * fprintf_func or fprintf_styled_func will be called.
> + */
> +static inline void init_disassemble_info_compat(struct disassemble_info *info,
> +						void *stream,
> +						fprintf_ftype unstyled_func,
> +						fprintf_styled_ftype styled_func)
> +{
> +#ifdef DISASM_INIT_STYLED
> +	init_disassemble_info(info, stream,
> +			      unstyled_func,
> +			      styled_func);
> +#else
> +	(void)styled_func;
> +	init_disassemble_info(info, stream,
> +			      unstyled_func);
> +#endif
> +}
> +
> +#endif /* _TOOLS_DIS_ASM_COMPAT_H */
> -- 
> 2.37.0.3.g30cc8d0f14

-- 

- Arnaldo
