Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B0D5B1995
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 12:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiIHKF7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 06:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiIHKF7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 06:05:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6D2C6B6A;
        Thu,  8 Sep 2022 03:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MtA3UPFL7D0ttdi+gviDjq9jbPzocVoEXi27tj0FcoE=; b=q8h06ivg6hvrVMPohYumY7i+jO
        W3ZgGp0MnwMlqFvUM5lBSgrdW9gg4h0X9ai6TwFgZdDsXVYTvo0XycNwri4jjQ74PWASqmv39ehPg
        lbeJAJKo0Vt9rMx5I5vqWSk4nGkigSTn5/crFXUyUebp4jfWHWXruyMRMALX4RbwcLPZnt6qQhUjW
        pdLS/AMLpu0+f32Krr1H7sW1Z/UXRWZNo5/TixUpgsWWob+YXTulnUGGyeUsNCYXs6jiWlRS1Us7U
        Ws8CS23LXM9xpU+7b7VLge3rt/7luOzoghupF0KOKGUCWUgMUNdVuPDijPYhP5YSvy4urL38oj3vn
        khSzVS2w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWEOy-00AhEY-9H; Thu, 08 Sep 2022 10:05:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C2F3130008D;
        Thu,  8 Sep 2022 12:04:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 74889207ABF68; Thu,  8 Sep 2022 12:04:50 +0200 (CEST)
Date:   Thu, 8 Sep 2022 12:04:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, x86@kernel.org
Subject: [PATCH] x86,retpoline: Be sure to emit INT3 after JMP *%\reg
Message-ID: <Yxm+QkFPOhrVSH6q@hirez.programming.kicks-ass.net>
References: <166260087224.759381.4170102827490658262.stgit@devnote2>
 <166260088298.759381.11727280480035568118.stgit@devnote2>
 <20220908050855.w77mimzznrlp6pwe@treble>
 <Yxm2QU1NJIkIyrrU@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxm2QU1NJIkIyrrU@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 08, 2022 at 11:30:41AM +0200, Peter Zijlstra wrote:
> Let me go do a patch.

---
Subject: x86,retpoline: Be sure to emit INT3 after JMP *%\reg

Both AMD and Intel recommend using INT3 after an indirect JMP. Make sure
to emit one when rewriting the retpoline JMP irrespective of compiler
SLS options or even CONFIG_SLS.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c | 9 +++++++++
 arch/x86/net/bpf_jit_comp.c   | 3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 62f6b8b7c4a5..68d84cf8e001 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -453,6 +453,15 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
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
 
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index c1f6c1c51d99..37f821dee68f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -419,7 +419,8 @@ static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
 		OPTIMIZER_HIDE_VAR(reg);
 		emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
 	} else {
-		EMIT2(0xFF, 0xE0 + reg);
+		EMIT2(0xFF, 0xE0 + reg);	/* jmp *%\reg */
+		EMIT1(0xCC);			/* int3 */
 	}
 
 	*pprog = prog;
