Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19AD5B0356
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 13:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiIGLov (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 07:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiIGLos (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 07:44:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C491C1C937;
        Wed,  7 Sep 2022 04:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bWWHRStIdtQiXmCBuizdNoX/+osRxMeXK7TBE7Fw1t4=; b=Rfb5uknUI86t/tdbOSxjMprg9A
        T5iDidCCA95A1pVWuiWuoXJajNPT19Gc5WmhpyKrdUDqLNPeYzI1gWiwGPeZrvbhw2/xNsHP1u25r
        gDw8N4A3UI4El8VFSDrftZIhMznaYzPaPQtvIq6ga4TWa0Lsm7yMtSGOaPex6lILPMyT6jkQ+LbWf
        zDzpP3DmncrAhWoUtBZEheX8WQ6roPfY2zWjRi00wUo9cU2UH8hkzT1CjcGAbwBxYEOoEMa6XyOWn
        JmPDKbDf2RaZ7roQ279LPm5mBhI68OkwIcmIm8W21ijheTK/GcTVFGBZuIzzl3Agvqtl299v7NCAJ
        ct5B4q+A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVtU1-00BJYq-53; Wed, 07 Sep 2022 11:44:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 414213003B0;
        Wed,  7 Sep 2022 13:44:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C605B2B9C92AD; Wed,  7 Sep 2022 13:44:37 +0200 (CEST)
Date:   Wed, 7 Sep 2022 13:44:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: Re: [PATCH 1/2] x86/kprobes: Fix kprobes instruction boudary check
 with CONFIG_RETHUNK
Message-ID: <YxiEJUn03gAJqm71@hirez.programming.kicks-ass.net>
References: <166251211081.632004.1842371136165709807.stgit@devnote2>
 <166251212072.632004.16078953024905883328.stgit@devnote2>
 <YxhQIBKzi+L0KDhc@hirez.programming.kicks-ass.net>
 <20220907184957.d41f085a998b2c7485353171@kernel.org>
 <YxhwGkmRy/kJa9fG@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxhwGkmRy/kJa9fG@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 07, 2022 at 12:19:06PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 07, 2022 at 06:49:57PM +0900, Masami Hiramatsu wrote:
> > Yeah, this looks good to me. What I just need is to add expanding
> > queue buffer. (can we use xarray for this purpose?)
> 
> Yeah, xarray might just work.
> 
> I need to go fetch the kids from school, but if I remember I'll modify
> objtool to tell us the max number required here (for any one particular
> build obviously).

quick hack below suggests we need 405 for a x86_64 defconfig+kvm_guest.config vmlinux.o.

  $ OBJTOOL_ARGS="--stats" make O=defconfig-build/ -j12 vmlinux.o
  ...
  max_targets: 405 (hidinput_connect)
  ...

And if you look at the output of:

  $ ./scripts/objdump-func defconfig-build/vmlinux.o hidinput_connect

I'm inclined to believe this. That function is crazy. So yeah, we
definitely need something dynamic.

---
 tools/objtool/check.c               | 12 ++++++++++++
 tools/objtool/include/objtool/elf.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e55fdf952a3a..897d3b83ab70 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3295,6 +3295,9 @@ static struct instruction *next_insn_to_validate(struct objtool_file *file,
 	return next_insn_same_sec(file, insn);
 }
 
+static int max_targets = 0;
+static char *max_name = NULL;
+
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -3312,6 +3315,14 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 	sec = insn->sec;
 
+	if (!insn->visited && func) {
+		func->targets++;
+		if (func->targets > max_targets) {
+			max_targets = func->targets;
+			max_name = func->name;
+		}
+	}
+
 	while (1) {
 		next_insn = next_insn_to_validate(file, insn);
 
@@ -4305,6 +4316,7 @@ int check(struct objtool_file *file)
 		printf("nr_cfi: %ld\n", nr_cfi);
 		printf("nr_cfi_reused: %ld\n", nr_cfi_reused);
 		printf("nr_cfi_cache: %ld\n", nr_cfi_cache);
+		printf("max_targets: %d (%s)\n", max_targets, max_name);
 	}
 
 out:
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 16f4067b82ae..a707becdef50 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -61,6 +61,7 @@ struct symbol {
 	u8 fentry            : 1;
 	u8 profiling_func    : 1;
 	struct list_head pv_target;
+	int targets;
 };
 
 struct reloc {
