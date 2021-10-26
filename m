Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3852043B1CE
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 14:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbhJZMHu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 08:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbhJZMHt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 08:07:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CCCC061745;
        Tue, 26 Oct 2021 05:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=XxknQUF5RAR+Y8Cwm798ztoeVs35pawGpR1E3DNaP58=; b=GzXb9WtNssAVj2aa3fm04AYWI1
        Uco3DTB+WVJQJKAn4GXBrANyEM6kXMINqLfWagDPlZ2dWyig3RuJm0X4yYvLsFcjIGFcGOI2g8xup
        IqREnJ2Gc9dm166uFUs58SQrLzX6yGbaLDYV3k6sHGy/276nwYE5GDFdWkRDnzKlhPbTbXXi1SqhP
        RKRLokgIfOkn5vcsHD3LbV9/TAFG/KSZsmDnwsgvS8iRid/t3nwZp3gyp63vYxcTxXFyWZQhIMLX+
        mVnvC70mrmOjvANDoU1rsbYbcezMhTveSbv0WbDvRGWEM7rAW8ObO+R9nxuNCtp0sXvJ46qRPqN0v
        pPqL9rcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfLCd-00CM0u-9D; Tue, 26 Oct 2021 12:05:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 21E963002AE;
        Tue, 26 Oct 2021 14:05:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EF16C25E57E54; Tue, 26 Oct 2021 14:05:13 +0200 (CEST)
Message-ID: <20211026120132.613201817@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 26 Oct 2021 14:01:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com,
        bpf@vger.kernel.org
Subject: [PATCH v3 00/16] x86: Rewrite the retpoline rewrite logic
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

These patches rewrite the way retpolines are rewritten. Currently objtool emits
alternative entries for most retpoline calls. However trying to extend that led
to trouble (ELF files are horrid).

Therefore completely overhaul this and have objtool emit a .retpoline_sites
section that lists all compiler generated retpoline thunk calls. Then the
kernel can do with them as it pleases.

Notably it will:

 - rewrite them to indirect instructions for !RETPOLINE
 - rewrite them to lfence; indirect; for RETPOLINE_AMD,
   where size allows (boo clang!)

Specifically, the !RETPOLINE case can now also deal with the clang-special
conditional-indirect-tail-call:

  Jcc __x86_indirect_thunk_\reg.

Finally, also update the x86 BPF jit to catch up to recent times and do these
same things.

All this should help improve performance by removing an indirection.

Patches can (soon) be found here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git objtool/core

Changes since v2:

 - rewrite the __x86_indirect_thunk_array[] stuff again
 - rewrite the retpoline,amd rewrite logic, it now also supports
   rewriting the Jcc case, if the original instruction is long enough, but
   more importantly, it's simpler code.
 - bpf label simplification patch
 - random assorted cleanups
 - actually managed to get bpf selftests working

---
 arch/um/kernel/um_arch.c                |   4 +
 arch/x86/include/asm/GEN-for-each-reg.h |  14 ++-
 arch/x86/include/asm/alternative.h      |   1 +
 arch/x86/include/asm/asm-prototypes.h   |  18 ---
 arch/x86/include/asm/nospec-branch.h    |  72 ++---------
 arch/x86/kernel/alternative.c           | 189 ++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/bugs.c              |   7 --
 arch/x86/kernel/module.c                |   9 +-
 arch/x86/kernel/vmlinux.lds.S           |  14 +++
 arch/x86/lib/retpoline.S                |  56 ++-------
 arch/x86/net/bpf_jit_comp.c             | 160 +++++++++---------------
 arch/x86/net/bpf_jit_comp32.c           |  22 +++-
 tools/objtool/arch/x86/decode.c         | 120 ------------------
 tools/objtool/check.c                   | 208 ++++++++++++++++++++++----------
 tools/objtool/elf.c                     |  84 -------------
 tools/objtool/include/objtool/check.h   |   1 -
 tools/objtool/include/objtool/elf.h     |   6 +-
 tools/objtool/special.c                 |   8 --
 18 files changed, 472 insertions(+), 521 deletions(-)

