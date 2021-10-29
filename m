Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1764843FC72
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 14:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhJ2Mpl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 08:45:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48680 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhJ2Mpk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Oct 2021 08:45:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 149CA1FC9E;
        Fri, 29 Oct 2021 12:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635511391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cJEtmY7YHOs6f4JedKwYztqfPBaKRZOkgFV6yjG7xFQ=;
        b=qLTBHjnWkwLO8VU+yakuq2ofnp5lyt2Oc92oRNijQ9uiE7ms6TyBJGLqmwJIQeV1JHEWZD
        rj7hrjs5loicxG658b4moIhB1I+q3+CO5V0Fw+5oIG0HgxixlMeq4FDWGwKApolAAtvHm2
        7S0CG6UavvZD05dJvasJEtGtp5QeYlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635511391;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cJEtmY7YHOs6f4JedKwYztqfPBaKRZOkgFV6yjG7xFQ=;
        b=mff/CtITwb0LE1/FaaXiG9ff07Gu358S91KRrkdjw639RkwCoLJRJ8KwwXYXD73VJGnVnJ
        1pOP4Qik/aJ3shBQ==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EB33FA3B88;
        Fri, 29 Oct 2021 12:43:10 +0000 (UTC)
Date:   Fri, 29 Oct 2021 14:43:10 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com, bpf@vger.kernel.org
Subject: Re: [PATCH v3 00/16] x86: Rewrite the retpoline rewrite logic
In-Reply-To: <20211026120132.613201817@infradead.org>
Message-ID: <alpine.LSU.2.21.2110291442190.21447@pobox.suse.cz>
References: <20211026120132.613201817@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 26 Oct 2021, Peter Zijlstra wrote:

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

It is already in tip, but FWIW the objtool changes look good to me

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
