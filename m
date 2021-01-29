Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC933088D1
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 13:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhA2MEV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jan 2021 07:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhA2MCR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jan 2021 07:02:17 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E240C08ECA4;
        Fri, 29 Jan 2021 02:21:15 -0800 (PST)
Received: from zn.tnic (p200300ec2f0c9a00c2508fce5f12579a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9a00:c250:8fce:5f12:579a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A974D1EC026D;
        Fri, 29 Jan 2021 11:21:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611915670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TVLhEv6qFkJVfRGbRCeWnctSeyH/2aF863ezHXsArvw=;
        b=erNdzR8S0vCkAaDIcWEZuGKQk4j4hHdj0CaAHILELw+fn/JXJlOTzwZ30WCZs/K2z9dGjS
        24canQOHf8ZnUrv898FXTNxUFjY5Gj1mDjXUdu12OhUgtuR2tSl/HFc4D17HJs1JhQv6Hp
        yBHs112GHBP977M3ycTPGXi5MsyTmKE=
Date:   Fri, 29 Jan 2021 11:21:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, Masami Hiramatsu <masami.hiramatsu@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH] x86: Disable CET instrumentation in the kernel
Message-ID: <20210129102105.GA27841@zn.tnic>
References: <25cd2608-03c2-94b8-7760-9de9935fde64@suse.com>
 <20210128001353.66e7171b395473ef992d6991@kernel.org>
 <20210128002452.a79714c236b69ab9acfa986c@kernel.org>
 <a35a6f15-9ab1-917c-d443-23d3e78f2d73@suse.com>
 <20210128103415.d90be51ec607bb6123b2843c@kernel.org>
 <20210128123842.c9e33949e62f504b84bfadf5@gmail.com>
 <e8bae974-190b-f247-0d89-6cea4fd4cc39@suse.com>
 <eb1ec6a3-9e11-c769-84a4-228f23dc5e23@suse.com>
 <20210128165014.xc77qtun6fl2qfun@treble>
 <20210128215219.6kct3h2eiustncws@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128215219.6kct3h2eiustncws@treble>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 28, 2021 at 03:52:19PM -0600, Josh Poimboeuf wrote:
> 
> With retpolines disabled, some configurations of GCC will add Intel CET
> instrumentation to the kernel by default.  That breaks certain tracing
> scenarios by adding a superfluous ENDBR64 instruction before the fentry
> call, for functions which can be called indirectly.
> 
> CET instrumentation isn't currently necessary in the kernel, as CET is
> only supported in user space.  Disable it unconditionally.
> 
> Reported-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  Makefile          | 6 ------
>  arch/x86/Makefile | 3 +++
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index e0af7a4a5598..51c2bf34142d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -948,12 +948,6 @@ KBUILD_CFLAGS   += $(call cc-option,-Werror=designated-init)
>  # change __FILE__ to the relative path from the srctree
>  KBUILD_CPPFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
>  
> -# ensure -fcf-protection is disabled when using retpoline as it is
> -# incompatible with -mindirect-branch=thunk-extern
> -ifdef CONFIG_RETPOLINE
> -KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
> -endif
> -

Why is that even here, in the main Makefile if this cf-protection thing
is x86-specific?

Are we going to move it back there when some other arch gets CET or
CET-like support?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
