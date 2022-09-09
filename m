Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660735B317D
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 10:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiIIIQ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 04:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiIIIQ1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 04:16:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8281910BF;
        Fri,  9 Sep 2022 01:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YQ5J9awjZ8okuYIJK4Y9/jHYaZVzD6vj+0iVM56skK4=; b=IQ1QgFRvQegucY9qY4fqkih3Rv
        PDm3BAfSJS/0JcRF3F7Nt/XWxvCkTYOCjDL3F3oMCP3zWGUdw/Ipd2rB6hWABzkqp2QVYYHvZFCXe
        nMZVohvfmyPjDLbxqcnWTsf72ufmdfoyf1sLkBE97D1QO1XpdGVvvhRXGoOlN+QGbcMRpdU4CkZbZ
        DJe115z46Bz1dmf1b8TkiQyUvsMpKZxuY/DXFyirbxlH9yHfMS/ynCA72WmOPHJDL9upS1yqQrWvO
        h5O98UGQHgq0Vw/x5UF9SEvcVP90BP3conQxbHswHop5PovY9oEYD9x6v27EW/ZS93zpwkdXyYFgh
        4C4YOgDg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWZBQ-00D6Bb-Oi; Fri, 09 Sep 2022 08:16:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7AE44300202;
        Fri,  9 Sep 2022 10:16:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E783299F2F77; Fri,  9 Sep 2022 10:16:13 +0200 (CEST)
Date:   Fri, 9 Sep 2022 10:16:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>, X86 ML <x86@kernel.org>
Subject: Re: [PATCH] x86,retpoline: Be sure to emit INT3 after JMP *%\reg
Message-ID: <Yxr2TaWaN8VjJ60D@hirez.programming.kicks-ass.net>
References: <166260087224.759381.4170102827490658262.stgit@devnote2>
 <166260088298.759381.11727280480035568118.stgit@devnote2>
 <20220908050855.w77mimzznrlp6pwe@treble>
 <Yxm2QU1NJIkIyrrU@hirez.programming.kicks-ass.net>
 <Yxm+QkFPOhrVSH6q@hirez.programming.kicks-ass.net>
 <CAADnVQKWTaXFqYri9VG3ux-CJEBsjAP5PetH6Q1ccS8HoeP28g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKWTaXFqYri9VG3ux-CJEBsjAP5PetH6Q1ccS8HoeP28g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 08, 2022 at 07:01:12AM -0700, Alexei Starovoitov wrote:

> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index c1f6c1c51d99..37f821dee68f 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -419,7 +419,8 @@ static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
> >                 OPTIMIZER_HIDE_VAR(reg);
> >                 emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
> >         } else {
> > -               EMIT2(0xFF, 0xE0 + reg);
> > +               EMIT2(0xFF, 0xE0 + reg);        /* jmp *%\reg */
> > +               EMIT1(0xCC);                    /* int3 */
> 
> Hmm. Why is this unconditional?
> Shouldn't it be guarded with CONFIG_xx or cpu_feature_enabled ?
> People that don't care about hw speculation vulnerabilities
> shouldn't pay the price of increased code size.

Sure, like so then?

---
Subject: x86,retpoline: Be sure to emit INT3 after JMP *%\reg
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 8 Sep 2022 12:04:50 +0200

Both AMD and Intel recommend using INT3 after an indirect JMP. Make sure
to emit one when rewriting the retpoline JMP irrespective of compiler
SLS options or even CONFIG_SLS.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---

 arch/x86/kernel/alternative.c |    9 +++++++++
 arch/x86/net/bpf_jit_comp.c   |    4 +++-
 2 files changed, 12 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -453,6 +453,15 @@ static int patch_retpoline(void *addr, s
 		return ret;
 	i += ret;
 
+	/*
+	 * The compiler is supposed to EMIT an INT3 after every unconditional
+	 * JMP instruction due to AMD BTC. However, if the compiler is too old
+	 * or SLS isn't enabled, we still need an INT3 after indirect JMPs
+	 * even on Intel.
+	 */
+	if (op == JMP32_INSN_OPCODE && i < insn->length)
+		bytes[i++] = INT3_INSN_OPCODE;
+
 	for (; i < insn->length;)
 		bytes[i++] = BYTES_NOP1;
 
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -419,7 +419,9 @@ static void emit_indirect_jump(u8 **ppro
 		OPTIMIZER_HIDE_VAR(reg);
 		emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
 	} else {
-		EMIT2(0xFF, 0xE0 + reg);
+		EMIT2(0xFF, 0xE0 + reg);	/* jmp *%\reg */
+		if (IS_ENABLED(CONFIG_RETPOLINE) || IS_ENABLED(CONFIG_SLS))
+			EMIT1(0xCC);		/* int3 */
 	}
 
 	*pprog = prog;
