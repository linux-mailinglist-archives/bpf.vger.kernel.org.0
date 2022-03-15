Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADA34D95FC
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 09:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiCOIRL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 04:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345787AbiCOIRK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 04:17:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5677F4BFCF;
        Tue, 15 Mar 2022 01:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qyv9L1J7lwguExQlG54d6Y/3Vo+2ko997MYNN73Ttqo=; b=OVHBEZrcSgULGYImZyZkeB3Dqz
        3mskSLqD8AwhZSFAA7P/tPJv7+HK2PEdrKy52Xglr8vRqFGDVFu9EfUh97rSAN0G09sd6ImNb2lGO
        Kx6A9vSANmb1GH9jY+ADoPlxn7jYM0uxiIwDc7iKyQQhSjIss+XMa6lVhLLEaBb8CS/o+6NUGpPyo
        aiHUrZlqrV+ezBfxrpwzlMxTYbXbykV90OpfWcKKOJ9kepb5Bw+sQ8v+quvD/ZqJv/G/sTJ67/Awz
        WlZWrls9KEinKvs9pd+ybn364wMZrD5hOR9rePpWTxWZ+/n2WIpwp18y4Na8y4ZQREbQgLSecriHW
        QTRr04Aw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nU2Ky-0019lg-15; Tue, 15 Mar 2022 08:15:24 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C8F0986205; Tue, 15 Mar 2022 09:15:22 +0100 (CET)
Date:   Tue, 15 Mar 2022 09:15:22 +0100
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
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        masahiroy@kernel.org
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
Message-ID: <20220315081522.GA8939@worktop.programming.kicks-ass.net>
References: <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
 <YinGZObp37b27LjK@hirez.programming.kicks-ass.net>
 <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net>
 <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
 <CAADnVQJfffD9tH_cWThktCCwXeoRV1XLZq69rKK5vKy_y6BN8A@mail.gmail.com>
 <20220312154407.GF28057@worktop.programming.kicks-ass.net>
 <CAADnVQL7xrafAviUJg47LfvFSJpgZLwyP18Bm3S_KQwRyOpheQ@mail.gmail.com>
 <20220313085214.GK28057@worktop.programming.kicks-ass.net>
 <Yi9YOdn5Nbq9BBwd@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi9YOdn5Nbq9BBwd@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 14, 2022 at 03:59:05PM +0100, Peter Zijlstra wrote:
> On Sun, Mar 13, 2022 at 09:52:14AM +0100, Peter Zijlstra wrote:
> > On Sat, Mar 12, 2022 at 05:33:39PM -0800, Alexei Starovoitov wrote:
> > > During the build with gcc 8.5 I see:
> > > 
> > > arch/x86/crypto/crc32c-intel.o: warning: objtool: file already has
> > > .ibt_endbr_seal, skipping
> > > arch/x86/crypto/crc32c-intel.o: warning: objtool: file already has
> > > .orc_unwind section, skipping
> > >   LD [M]  crypto/async_tx/async_xor.ko
> > >   LD [M]  crypto/authenc.ko
> > > make[3]: *** [../scripts/Makefile.modfinal:61:
> > > arch/x86/crypto/crc32c-intel.ko] Error 255
> > > make[3]: *** Waiting for unfinished jobs....
> > > 
> > > but make clean cures it.
> > > I suspect it's some missing makefile dependency.
> > 
> > Yes, I recently ran into it; I've been trying to kick Makefile into
> > submission but have not had success yet. Will try again on Monday.
> > 
> > Problem appears to be that it will re-link .ko even though .o hasn't
> > changed, resulting in duplicate objtool runs. I've been trying to have
> > makefile generate .o.objtool empty file to serve as dependency marker to
> > avoid doing second objtool run, but like said, no luck yet.
> 
> Masahiro-san, I'm trying the below, but afaict it's not working because
> the rule for the .o file itself:
> 
Ha, sleep, it is marvelous!

The below appears to be working as desired.

---
Index: linux-2.6/scripts/Makefile.build
===================================================================
--- linux-2.6.orig/scripts/Makefile.build
+++ linux-2.6/scripts/Makefile.build
@@ -86,12 +86,18 @@ ifdef need-builtin
 targets-for-builtin += $(obj)/built-in.a
 endif
 
-targets-for-modules := $(patsubst %.o, %.mod, $(filter %.o, $(obj-m)))
+targets-for-modules :=
 
 ifdef CONFIG_LTO_CLANG
 targets-for-modules += $(patsubst %.o, %.lto.o, $(filter %.o, $(obj-m)))
 endif
 
+ifdef CONFIG_X86_KERNEL_IBT
+targets-for-modules += $(patsubst %.o, %.objtool, $(filter %.o, $(obj-m)))
+endif
+
+targets-for-modules += $(patsubst %.o, %.mod, $(filter %.o, $(obj-m)))
+
 ifdef need-modorder
 targets-for-modules += $(obj)/modules.order
 endif
@@ -276,6 +282,19 @@ cmd_mod = { \
 $(obj)/%.mod: $(obj)/%$(mod-prelink-ext).o FORCE
 	$(call if_changed,mod)
 
+#
+# Since objtool will re-write the file it will change the timestamps, therefore
+# it is critical that the %.objtool file gets a timestamp *after* objtool runs.
+#
+# Additionally, care must be had with ordering this rule against the other rules
+# that take %.o as a dependency.
+#
+cmd_objtool_mod =							\
+	true $(cmd_objtool) ; touch $@
+
+$(obj)/%.objtool: $(obj)/%$(mod-prelink-ext).o FORCE
+	$(call if_changed,objtool_mod)
+
 quiet_cmd_cc_lst_c = MKLST   $@
       cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \
 		     $(CONFIG_SHELL) $(srctree)/scripts/makelst $*.o \
Index: linux-2.6/scripts/Makefile.lib
===================================================================
--- linux-2.6.orig/scripts/Makefile.lib
+++ linux-2.6/scripts/Makefile.lib
@@ -552,9 +552,8 @@ objtool_args =								\
 	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
 	$(if $(CONFIG_SLS), --sls)
 
-cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
-cmd_objtool_mod = $(if $(objtool-enabled), $(objtool) $(objtool_args) $(@:.ko=.o) ; )
-cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
+cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $(@:.objtool=.o))
+cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$(@:.objtool=.o): $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
 
 endif # CONFIG_STACK_VALIDATION
 
@@ -575,8 +574,8 @@ $(obj)/%.o: objtool-enabled :=
 
 # instead run objtool on the module as a whole, right before
 # the final link pass with the linker script.
-%.ko: objtool-enabled = y
-%.ko: part-of-module := y
+$(obj)/%.objtool: objtool-enabled = y
+$(obj)/%.objtool: part-of-module := y
 
 else
 
Index: linux-2.6/scripts/Makefile.modfinal
===================================================================
--- linux-2.6.orig/scripts/Makefile.modfinal
+++ linux-2.6/scripts/Makefile.modfinal
@@ -32,7 +32,6 @@ ARCH_POSTLINK := $(wildcard $(srctree)/a
 
 quiet_cmd_ld_ko_o = LD [M]  $@
       cmd_ld_ko_o +=							\
-	$(cmd_objtool_mod)						\
 	$(LD) -r $(KBUILD_LDFLAGS)					\
 		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
 		-T scripts/module.lds -o $@ $(filter %.o, $^);		\
