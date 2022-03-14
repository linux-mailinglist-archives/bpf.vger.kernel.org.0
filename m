Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB1A4D878C
	for <lists+bpf@lfdr.de>; Mon, 14 Mar 2022 15:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241554AbiCNPAv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Mar 2022 11:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiCNPAu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Mar 2022 11:00:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB92F419B5;
        Mon, 14 Mar 2022 07:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vXKkXDbED7M3BWB+wPrKSrCS9R2wouzreerqWBT0T0k=; b=ZeJJ0Dq/0uSZYlG1mlawxZ5pdN
        4YKofYC9jXWAD8OKnZ6MD5O2Q7RU4xao84q0SPnyE8chhrkf3jHJBh0NgYq84Sw1Z1HxemXMUgwWe
        GcU5fqQRiAK2Y8huReqxwheNlyAiLCuOpnyp8nKnxI02QA0mzzVg4OpsyvXd0pPXln6D8lhBgXxVl
        NxgSTCh2/ARaku4b1OM/sQceNmtht2cbwVwXwO34+b6Wjy1f62apVDcQDYSsh0rsmO3x0useBGZes
        lY8QAFuzzeqpOBPVlsXTY4uQJw6qDg3NWiqMljRX9HJpQA+Y1iPIQhT0VbcjcxwCjjkx7gTOrtqJm
        JVafiIsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTmA9-000sJS-Fu; Mon, 14 Mar 2022 14:59:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 18AEC3003BC;
        Mon, 14 Mar 2022 15:59:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EABB930413243; Mon, 14 Mar 2022 15:59:05 +0100 (CET)
Date:   Mon, 14 Mar 2022 15:59:05 +0100
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
Message-ID: <Yi9YOdn5Nbq9BBwd@hirez.programming.kicks-ass.net>
References: <Yif8nO2xg6QnVQfD@hirez.programming.kicks-ass.net>
 <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
 <YinGZObp37b27LjK@hirez.programming.kicks-ass.net>
 <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net>
 <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
 <CAADnVQJfffD9tH_cWThktCCwXeoRV1XLZq69rKK5vKy_y6BN8A@mail.gmail.com>
 <20220312154407.GF28057@worktop.programming.kicks-ass.net>
 <CAADnVQL7xrafAviUJg47LfvFSJpgZLwyP18Bm3S_KQwRyOpheQ@mail.gmail.com>
 <20220313085214.GK28057@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313085214.GK28057@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 13, 2022 at 09:52:14AM +0100, Peter Zijlstra wrote:
> On Sat, Mar 12, 2022 at 05:33:39PM -0800, Alexei Starovoitov wrote:
> > During the build with gcc 8.5 I see:
> > 
> > arch/x86/crypto/crc32c-intel.o: warning: objtool: file already has
> > .ibt_endbr_seal, skipping
> > arch/x86/crypto/crc32c-intel.o: warning: objtool: file already has
> > .orc_unwind section, skipping
> >   LD [M]  crypto/async_tx/async_xor.ko
> >   LD [M]  crypto/authenc.ko
> > make[3]: *** [../scripts/Makefile.modfinal:61:
> > arch/x86/crypto/crc32c-intel.ko] Error 255
> > make[3]: *** Waiting for unfinished jobs....
> > 
> > but make clean cures it.
> > I suspect it's some missing makefile dependency.
> 
> Yes, I recently ran into it; I've been trying to kick Makefile into
> submission but have not had success yet. Will try again on Monday.
> 
> Problem appears to be that it will re-link .ko even though .o hasn't
> changed, resulting in duplicate objtool runs. I've been trying to have
> makefile generate .o.objtool empty file to serve as dependency marker to
> avoid doing second objtool run, but like said, no luck yet.

Masahiro-san, I'm trying the below, but afaict it's not working because
the rule for the .o file itself:

$(multi-obj-m): FORCE
	$(call if_changed,link_multi-m)

will in fact update the timestamp of the .o file, even if if_changed
nops out the cmd. Concequently all rules that try to use if_changed with
this .o file as a dependency will find it newer and run anyway.


remake -x output of a fs/f2fs/ module (re)build:

     Prerequisite 'FORCE' of target 'fs/f2fs/f2fs.o' does not exist.
    Must remake target 'fs/f2fs/f2fs.o'.
../scripts/Makefile.build:454: target 'fs/f2fs/f2fs.o' does not exist
##>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
:
##<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    Successfully remade target file 'fs/f2fs/f2fs.o'.
   Prerequisite 'fs/f2fs/f2fs.o' is newer than target 'fs/f2fs/f2fs.mod'.
   Prerequisite 'FORCE' of target 'fs/f2fs/f2fs.mod' does not exist.
  Must remake target 'fs/f2fs/f2fs.mod'.
../scripts/Makefile.build:281: update target 'fs/f2fs/f2fs.mod' due to: fs/f2fs/f2fs.o
##>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
set -e;   { echo  fs/f2fs/dir.o fs/f2fs/file.o fs/f2fs/inode.o fs/f2fs/namei.o fs/f2fs/hash.o fs/f2fs/super.o fs/f2fs/inline.o fs/f2fs/checkpoint.o fs/f2fs/gc.o fs/f2fs/data.o fs/f2fs/node.o fs/f2fs/segment.o fs/f2fs/recovery.o fs/f2fs/shrinker.o fs/f2fs/extent_cache.o fs/f2fs/sysfs.o fs/f2fs/debug.o fs/f2fs/xattr.o fs/f2fs/acl.o fs/f2fs/iostat.o;  echo; } > fs/f2fs/f2fs.mod; printf '%s\n' 'cmd_fs/f2fs/f2fs.mod := { echo  fs/f2fs/dir.o fs/f2fs/file.o fs/f2fs/inode.o fs/f2fs/namei.o fs/f2fs/hash.o fs/f2fs/super.o fs/f2fs/inline.o fs/f2fs/checkpoint.o fs/f2fs/gc.o fs/f2fs/data.o fs/f2fs/node.o fs/f2fs/segment.o fs/f2fs/recovery.o fs/f2fs/shrinker.o fs/f2fs/extent_cache.o fs/f2fs/sysfs.o fs/f2fs/debug.o fs/f2fs/xattr.o fs/f2fs/acl.o fs/f2fs/iostat.o;  echo; } > fs/f2fs/f2fs.mod' > fs/f2fs/.f2fs.mod.cmd
##<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  Successfully remade target file 'fs/f2fs/f2fs.mod'.
   Prerequisite 'fs/f2fs/f2fs.o' is newer than target 'fs/f2fs/f2fs.objtool'.
   Prerequisite 'FORCE' of target 'fs/f2fs/f2fs.objtool' does not exist.
  Must remake target 'fs/f2fs/f2fs.objtool'.
../scripts/Makefile.build:287: update target 'fs/f2fs/f2fs.objtool' due to: fs/f2fs/f2fs.o
##>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
set -e;   { echo fs/f2fs/f2fs.o  ; ./tools/objtool/objtool orc generate  --module  --lto --ibt  --no-fp    --uaccess   fs/f2fs/f2fs.o ; } > fs/f2fs/f2fs.objtool; printf '%s\n' 'cmd_fs/f2fs/f2fs.objtool := { echo fs/f2fs/f2fs.o  ; ./tools/objtool/objtool orc generate  --module  --lto --ibt  --no-fp    --uaccess   fs/f2fs/f2fs.o ; } > fs/f2fs/f2fs.objtool' > fs/f2fs/.f2fs.objtool.cmd
##<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
fs/f2fs/f2fs.o: warning: objtool: file already has .static_call_sites section, skipping
fs/f2fs/f2fs.o: warning: objtool: file already has .ibt_endbr_seal, skipping
fs/f2fs/f2fs.o: warning: objtool: file already has .orc_unwind section, skipping
../scripts/Makefile.build:286: *** [fs/f2fs/f2fs.objtool] error 255


Where we can see that we don't re-generate f2fs.o (empty command), but
then we do re-generate f2fs.mod because f2fs.o is newer and the same
happens for the new f2fs.objtool.

Help?

---
Index: linux-2.6/scripts/Makefile.build
===================================================================
--- linux-2.6.orig/scripts/Makefile.build
+++ linux-2.6/scripts/Makefile.build
@@ -92,6 +92,10 @@ ifdef CONFIG_LTO_CLANG
 targets-for-modules += $(patsubst %.o, %.lto.o, $(filter %.o, $(obj-m)))
 endif
 
+ifdef CONFIG_X86_KERNEL_IBT
+targets-for-modules += $(patsubst %.o, %.objtool, $(filter %.o, $(obj-m)))
+endif
+
 ifdef need-modorder
 targets-for-modules += $(obj)/modules.order
 endif
@@ -276,6 +280,12 @@ cmd_mod = { \
 $(obj)/%.mod: $(obj)/%$(mod-prelink-ext).o FORCE
 	$(call if_changed,mod)
 
+cmd_objtool_mod =							\
+	{ echo $< $(cmd_objtool) ; } > $@
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
