Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD2143E773
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 19:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhJ1RqR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 13:46:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36016 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhJ1RqR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Oct 2021 13:46:17 -0400
Received: from zn.tnic (p200300ec2f13a700349123b1f000d126.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:a700:3491:23b1:f000:d126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 11AA41EC067E;
        Thu, 28 Oct 2021 19:43:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635443029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LV/QiZdF7ZKqnJvyt4f9O/KBxui21yF4wr9jzKFDXrY=;
        b=qIWNzriERo9OwiVILV1unRM52LETMnLqD3z4taQIYbRTcwlLNSDkB47m4F2nal4ODvWhVM
        w4+M1r126g/lvOGdl3krqz4WodnO5D2W6NkFwVoas+Cn1RunTatMwxHEAvo9Ipf6dTk/9m
        zn3qhAel7oTvjr4iS1fpAWUK6sTL+04=
Date:   Thu, 28 Oct 2021 19:43:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com, bpf@vger.kernel.org
Subject: Re: [PATCH v3 00/16] x86: Rewrite the retpoline rewrite logic
Message-ID: <YXrhUQZ5lA70Fhm0@zn.tnic>
References: <20211026120132.613201817@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211026120132.613201817@infradead.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 02:01:32PM +0200, Peter Zijlstra wrote:
> Hi,
> 
> These patches rewrite the way retpolines are rewritten. Currently objtool emits
> alternative entries for most retpoline calls. However trying to extend that led
> to trouble (ELF files are horrid).
> 
> Therefore completely overhaul this and have objtool emit a .retpoline_sites
> section that lists all compiler generated retpoline thunk calls. Then the
> kernel can do with them as it pleases.
> 
> Notably it will:
> 
>  - rewrite them to indirect instructions for !RETPOLINE
>  - rewrite them to lfence; indirect; for RETPOLINE_AMD,
>    where size allows (boo clang!)
> 
> Specifically, the !RETPOLINE case can now also deal with the clang-special
> conditional-indirect-tail-call:
> 
>   Jcc __x86_indirect_thunk_\reg.
> 
> Finally, also update the x86 BPF jit to catch up to recent times and do these
> same things.
> 
> All this should help improve performance by removing an indirection.
> 
> Patches can (soon) be found here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git objtool/core
> 
> Changes since v2:
> 
>  - rewrite the __x86_indirect_thunk_array[] stuff again
>  - rewrite the retpoline,amd rewrite logic, it now also supports
>    rewriting the Jcc case, if the original instruction is long enough, but
>    more importantly, it's simpler code.
>  - bpf label simplification patch
>  - random assorted cleanups
>  - actually managed to get bpf selftests working
> 
> ---
>  arch/um/kernel/um_arch.c                |   4 +
>  arch/x86/include/asm/GEN-for-each-reg.h |  14 ++-
>  arch/x86/include/asm/alternative.h      |   1 +
>  arch/x86/include/asm/asm-prototypes.h   |  18 ---
>  arch/x86/include/asm/nospec-branch.h    |  72 ++---------
>  arch/x86/kernel/alternative.c           | 189 ++++++++++++++++++++++++++++-
>  arch/x86/kernel/cpu/bugs.c              |   7 --
>  arch/x86/kernel/module.c                |   9 +-
>  arch/x86/kernel/vmlinux.lds.S           |  14 +++
>  arch/x86/lib/retpoline.S                |  56 ++-------
>  arch/x86/net/bpf_jit_comp.c             | 160 +++++++++---------------
>  arch/x86/net/bpf_jit_comp32.c           |  22 +++-
>  tools/objtool/arch/x86/decode.c         | 120 ------------------
>  tools/objtool/check.c                   | 208 ++++++++++++++++++++++----------
>  tools/objtool/elf.c                     |  84 -------------
>  tools/objtool/include/objtool/check.h   |   1 -
>  tools/objtool/include/objtool/elf.h     |   6 +-
>  tools/objtool/special.c                 |   8 --
>  18 files changed, 472 insertions(+), 521 deletions(-)

Ok, this all looks real nice, thx!

Reviewed-by: Borislav Petkov <bp@suse.de> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
