Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5230E4D73E2
	for <lists+bpf@lfdr.de>; Sun, 13 Mar 2022 09:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbiCMIyC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Mar 2022 04:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiCMIyB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Mar 2022 04:54:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C75238;
        Sun, 13 Mar 2022 00:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XxBAm++QJgtGU16ffhunyrTU2NHDo5CknXs8koZZv2Y=; b=iWI8oFWKPrDvTTvon1p2L1CZSP
        6KsP6t8vSsTn8h7vwkkVxYaB3HpCZNVntkjVS7DDOvISzoecPNFEgFkIm2vlhnjs9wtLFjFs0o1fj
        eQPxEo1BjdynXFkD4nF9rLMcU9VgPH0y7+iFrvABalSMoY7UJF2KTuo7owH8x6UlggTi9GBEezeNe
        PmIr4vMioNXdXTUT43fLGdtOPV8WE76SBERfy7t7LNVWS88WU+hdG0wrWKjf6qUEhCZSXNZakaOG/
        tQB9QFtIuswz7Uuf/XjNTsZPB3bfWhwx6BTW9S9wfgQmXWszlNGUMO803v50cmebT6B5b3IQNiGfw
        LZmxn9dA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTJxY-000TQE-Ph; Sun, 13 Mar 2022 08:52:16 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 892E3987D0D; Sun, 13 Mar 2022 09:52:14 +0100 (CET)
Date:   Sun, 13 Mar 2022 09:52:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        X86 ML <x86@kernel.org>, joao@overdrivepizza.com,
        hjl.tools@gmail.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>, alyssa.milburn@intel.com,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
Message-ID: <20220313085214.GK28057@worktop.programming.kicks-ass.net>
References: <YifZhUVoHLT/76fE@hirez.programming.kicks-ass.net>
 <Yif8nO2xg6QnVQfD@hirez.programming.kicks-ass.net>
 <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
 <YinGZObp37b27LjK@hirez.programming.kicks-ass.net>
 <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net>
 <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
 <CAADnVQJfffD9tH_cWThktCCwXeoRV1XLZq69rKK5vKy_y6BN8A@mail.gmail.com>
 <20220312154407.GF28057@worktop.programming.kicks-ass.net>
 <CAADnVQL7xrafAviUJg47LfvFSJpgZLwyP18Bm3S_KQwRyOpheQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQL7xrafAviUJg47LfvFSJpgZLwyP18Bm3S_KQwRyOpheQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 12, 2022 at 05:33:39PM -0800, Alexei Starovoitov wrote:
> During the build with gcc 8.5 I see:
> 
> arch/x86/crypto/crc32c-intel.o: warning: objtool: file already has
> .ibt_endbr_seal, skipping
> arch/x86/crypto/crc32c-intel.o: warning: objtool: file already has
> .orc_unwind section, skipping
>   LD [M]  crypto/async_tx/async_xor.ko
>   LD [M]  crypto/authenc.ko
> make[3]: *** [../scripts/Makefile.modfinal:61:
> arch/x86/crypto/crc32c-intel.ko] Error 255
> make[3]: *** Waiting for unfinished jobs....
> 
> but make clean cures it.
> I suspect it's some missing makefile dependency.

Yes, I recently ran into it; I've been trying to kick Makefile into
submission but have not had success yet. Will try again on Monday.

Problem appears to be that it will re-link .ko even though .o hasn't
changed, resulting in duplicate objtool runs. I've been trying to have
makefile generate .o.objtool empty file to serve as dependency marker to
avoid doing second objtool run, but like said, no luck yet.

> and:
> vmlinux.o: warning: objtool: ksys_unshare()+0x626: unreachable instruction
> which stays even after make clean.

Humm, I shall have to dig out gcc-8.5 then.

> The rcu "false positive" is still there that causes
> sporadic hangs during the boot.

I've merged fix for that yesterday, shall respin this ibt tree to
include that.

> The test_progs shows:
> Summary: 228/1122 PASSED, 4 SKIPPED, 6 FAILED
> (when I remove one test)
> 
> That test is actually crashing the kernel:
> ./test_progs -t mod_race

Argh, I wasn't seeing crashing, I'll prod with sharp stick.
