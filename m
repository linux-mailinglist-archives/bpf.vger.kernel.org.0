Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047A364FF1F
	for <lists+bpf@lfdr.de>; Sun, 18 Dec 2022 15:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiLRO3F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 18 Dec 2022 09:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiLRO3E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 18 Dec 2022 09:29:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C07764B;
        Sun, 18 Dec 2022 06:29:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CFEA60D34;
        Sun, 18 Dec 2022 14:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508FDC433EF;
        Sun, 18 Dec 2022 14:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671373743;
        bh=Zqkh13nE+XDBmuZq/TCof3vW2BU7H0r/zwDEZC/u0wE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hj2M8NWvf68ITr6u9qXgsHOzH9g7ujw6ae0wPJPUIzd+EEY4xYYlTWtDceu3hRk27
         LGy0XTojonV5ASYPopxIpno9p+uLSB0fU94vb4ZAK1o6ULZOOY0z4cisyglF1lVbsv
         bzOEMCcNjLstYV9N6s0f+P/wG4iikCcoDqR9TgPg6J/BxLjAv02sDG2MG0Wm587VQd
         z4z0klGnThaKFpJiPPrmdrLnX10o3Mnb6uKdnRnx+BQETtlcXbi4+k8YgV3WO32M8c
         XvyM7OZT0G6oErEsFZgu5BN/Prmo5mMQbr2VlhVSFRnw8nussbeQoX52M2/3MXoeB4
         MDbEHjh248muA==
Date:   Sun, 18 Dec 2022 23:28:59 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 2/2] x86/kprobes: Fix optprobe optimization check
 with CONFIG_RETHUNK
Message-Id: <20221218232859.742280c432e0a96ef979274d@kernel.org>
In-Reply-To: <5BCC1248-FC01-4EB2-BFB2-4BBDD9092045@vmware.com>
References: <166264927154.775585.16570756675363838701.stgit@devnote2>
        <166264929259.775585.14768855667710290362.stgit@devnote2>
        <5BCC1248-FC01-4EB2-BFB2-4BBDD9092045@vmware.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 15 Dec 2022 03:31:25 +0000
Nadav Amit <namit@vmware.com> wrote:

> 
> > On Sep 8, 2022, at 8:01 AM, Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since the CONFIG_RETHUNK and CONFIG_SLS will use INT3 for stopping
> > speculative execution after function return, kprobe jump optimization
> > always fails on the functions with such INT3 inside the function body.
> > (It already checks the INT3 padding between functions, but not inside
> > the function)
> > 
> > To avoid this issue, as same as kprobes, check whether the INT3 comes
> > from kgdb or not, and if so, stop decoding and make it fail. The other
> > INT3 will come from CONFIG_RETHUNK/CONFIG_SLS and those can be
> > treated as a one-byte instruction.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Fixes: e463a09af2f0 ("x86: Add straight-line-speculation mitigation")
> > Cc: stable@vger.kernel.org
> > ---
> > arch/x86/kernel/kprobes/opt.c |   28 ++++++++--------------------
> > 1 file changed, 8 insertions(+), 20 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
> > index e6b8c5362b94..e57e07b0edb6 100644
> > --- a/arch/x86/kernel/kprobes/opt.c
> > +++ b/arch/x86/kernel/kprobes/opt.c
> > @@ -15,6 +15,7 @@
> > #include <linux/extable.h>
> > #include <linux/kdebug.h>
> > #include <linux/kallsyms.h>
> > +#include <linux/kgdb.h>
> > #include <linux/ftrace.h>
> > #include <linux/objtool.h>
> > #include <linux/pgtable.h>
> > @@ -279,19 +280,6 @@ static int insn_is_indirect_jump(struct insn *insn)
> > return ret;
> > }
> > 
> > -static bool is_padding_int3(unsigned long addr, unsigned long eaddr)
> > -{
> > - unsigned char ops;
> > -
> > - for (; addr < eaddr; addr++) {
> > - if (get_kernel_nofault(ops, (void *)addr) < 0 ||
> > -    ops != INT3_INSN_OPCODE)
> > - return false;
> > - }
> > -
> > - return true;
> > -}
> > -
> > /* Decode whole function to ensure any instructions don't jump into target */
> > static int can_optimize(unsigned long paddr)
> > {
> > @@ -334,15 +322,15 @@ static int can_optimize(unsigned long paddr)
> > ret = insn_decode_kernel(&insn, (void *)recovered_insn);
> > if (ret < 0)
> > return 0;
> > -
> > +#ifdef CONFIG_KGDB
> > /*
> > - * In the case of detecting unknown breakpoint, this could be
> > - * a padding INT3 between functions. Let's check that all the
> > - * rest of the bytes are also INT3.
> > + * If there is a dynamically installed kgdb sw breakpoint,
> > + * this function should not be probed.
> > */
> > - if (insn.opcode.bytes[0] == INT3_INSN_OPCODE)
> > - return is_padding_int3(addr, paddr - offset + size) ? 1 : 0;
> > -
> > + if (insn.opcode.bytes[0] == INT3_INSN_OPCODE &&
> > +    kgdb_has_hit_break(addr))
> > + return 0;
> > +#endif
> > /* Recover address */
> > insn.kaddr = (void *)addr;
> > insn.next_byte = (void *)(addr + insn.length);
> 
> Hi Masami,
> 
> I encountered a similar issue with can_probe(). I see that your
> patches were not upstreamed, at least to 6.1.

Oops, I should update and resend the series. This patch must go
through x86 (tip) tree since it is x86 specific issue. Moreover,
this is a kind of bugfix because kprobes doesn't work correctly
with this issue.

> 
> So I was wondering whether it they are going to be upstreamed, and
> whether you want also to update can_probe().

Yeah, I want to push it.

Thank you!


> 
> Thanks,
> Nadav

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
