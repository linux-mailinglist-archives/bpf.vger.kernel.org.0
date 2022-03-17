Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CD34DCD67
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 19:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiCQSSk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 14:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237594AbiCQSSV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 14:18:21 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A20D221B8F;
        Thu, 17 Mar 2022 11:17:03 -0700 (PDT)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 22HIGhM3021798;
        Fri, 18 Mar 2022 03:16:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 22HIGhM3021798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1647541004;
        bh=rc+MZb1Rc8UPoapVsTEVnBHBc6LjyMDA/XIc+yuBoSY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vW89vEr1VVvLOEYYcHgnFJh42EyomgIlx0lni27MK6tzXrjfEZZi1yt7TgNyDzjyP
         /U30r4wxQdCXkaZo8UX8T2kthAbZSF00DuWKH5tSFY3x45AZl4L7CIVk0seWkxIOk+
         4+Ds1yPMqO8kL/0txA4FR3pA75axaTU59JFOCAUdaJPM+GpHPi77AtUwlCIwQTvQ36
         G2W2zoiHfmlCPY9zJn4SLYOkSNVLNLeZ4lYWH3rCrGwlm59nMdZgnjfYBwcLfdA3Dz
         cfDKQUDq7WqT+s0k25zKR2Iq8+JuHvClw1veATO6H8w1jjIFamDrpd4PAydoJpOnNM
         JwDjrEBroTfqg==
X-Nifty-SrcIP: [209.85.214.172]
Received: by mail-pl1-f172.google.com with SMTP id n2so5131191plf.4;
        Thu, 17 Mar 2022 11:16:43 -0700 (PDT)
X-Gm-Message-State: AOAM530cxknO3VurzKXCFaClNmOXeC7Ygma7A6TXlMQ+QZIB0gApZHAx
        NdRB44f9cqaBBbDUbe+sD8v1gOnZgHrXf/IRXwo=
X-Google-Smtp-Source: ABdhPJxoion/ay/c2AhKta6zCpPI6szxP6ejFc5c0oLrFVXBuEiPalN7opqhLo4zJMojy6smgj9q7pJsiLRzajm/kBY=
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id
 s7-20020a170902988700b001516e1c7082mr6326693plp.162.1647541002797; Thu, 17
 Mar 2022 11:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
 <YinGZObp37b27LjK@hirez.programming.kicks-ass.net> <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net> <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
 <CAADnVQJfffD9tH_cWThktCCwXeoRV1XLZq69rKK5vKy_y6BN8A@mail.gmail.com>
 <20220312154407.GF28057@worktop.programming.kicks-ass.net>
 <CAADnVQL7xrafAviUJg47LfvFSJpgZLwyP18Bm3S_KQwRyOpheQ@mail.gmail.com>
 <20220313085214.GK28057@worktop.programming.kicks-ass.net>
 <Yi9YOdn5Nbq9BBwd@hirez.programming.kicks-ass.net> <20220315081522.GA8939@worktop.programming.kicks-ass.net>
In-Reply-To: <20220315081522.GA8939@worktop.programming.kicks-ass.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 18 Mar 2022 03:15:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ2mYMnOKMQheVi+6byUFE3KEkjm1zcndNUfe0tORGvug@mail.gmail.com>
Message-ID: <CAK7LNAQ2mYMnOKMQheVi+6byUFE3KEkjm1zcndNUfe0tORGvug@mail.gmail.com>
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        X86 ML <x86@kernel.org>, joao@overdrivepizza.com,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 15, 2022 at 5:15 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Mar 14, 2022 at 03:59:05PM +0100, Peter Zijlstra wrote:
> > On Sun, Mar 13, 2022 at 09:52:14AM +0100, Peter Zijlstra wrote:
> > > On Sat, Mar 12, 2022 at 05:33:39PM -0800, Alexei Starovoitov wrote:
> > > > During the build with gcc 8.5 I see:
> > > >
> > > > arch/x86/crypto/crc32c-intel.o: warning: objtool: file already has
> > > > .ibt_endbr_seal, skipping
> > > > arch/x86/crypto/crc32c-intel.o: warning: objtool: file already has
> > > > .orc_unwind section, skipping
> > > >   LD [M]  crypto/async_tx/async_xor.ko
> > > >   LD [M]  crypto/authenc.ko
> > > > make[3]: *** [../scripts/Makefile.modfinal:61:
> > > > arch/x86/crypto/crc32c-intel.ko] Error 255
> > > > make[3]: *** Waiting for unfinished jobs....
> > > >
> > > > but make clean cures it.
> > > > I suspect it's some missing makefile dependency.
> > >
> > > Yes, I recently ran into it; I've been trying to kick Makefile into
> > > submission but have not had success yet. Will try again on Monday.
> > >
> > > Problem appears to be that it will re-link .ko even though .o hasn't
> > > changed, resulting in duplicate objtool runs. I've been trying to have
> > > makefile generate .o.objtool empty file to serve as dependency marker to
> > > avoid doing second objtool run, but like said, no luck yet.
> >
> > Masahiro-san, I'm trying the below, but afaict it's not working because
> > the rule for the .o file itself:
> >
> Ha, sleep, it is marvelous!
>
> The below appears to be working as desired.
>
> ---
> Index: linux-2.6/scripts/Makefile.build
> ===================================================================
> --- linux-2.6.orig/scripts/Makefile.build
> +++ linux-2.6/scripts/Makefile.build
> @@ -86,12 +86,18 @@ ifdef need-builtin
>  targets-for-builtin += $(obj)/built-in.a
>  endif
>
> -targets-for-modules := $(patsubst %.o, %.mod, $(filter %.o, $(obj-m)))
> +targets-for-modules :=
>
>  ifdef CONFIG_LTO_CLANG
>  targets-for-modules += $(patsubst %.o, %.lto.o, $(filter %.o, $(obj-m)))
>  endif
>
> +ifdef CONFIG_X86_KERNEL_IBT
> +targets-for-modules += $(patsubst %.o, %.objtool, $(filter %.o, $(obj-m)))
> +endif
> +
> +targets-for-modules += $(patsubst %.o, %.mod, $(filter %.o, $(obj-m)))
> +
>  ifdef need-modorder
>  targets-for-modules += $(obj)/modules.order
>  endif
> @@ -276,6 +282,19 @@ cmd_mod = { \
>  $(obj)/%.mod: $(obj)/%$(mod-prelink-ext).o FORCE
>         $(call if_changed,mod)
>
> +#
> +# Since objtool will re-write the file it will change the timestamps, therefore
> +# it is critical that the %.objtool file gets a timestamp *after* objtool runs.
> +#
> +# Additionally, care must be had with ordering this rule against the other rules
> +# that take %.o as a dependency.
> +#
> +cmd_objtool_mod =                                                      \
> +       true $(cmd_objtool) ; touch $@
> +
> +$(obj)/%.objtool: $(obj)/%$(mod-prelink-ext).o FORCE
> +       $(call if_changed,objtool_mod)
> +
>  quiet_cmd_cc_lst_c = MKLST   $@
>        cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \
>                      $(CONFIG_SHELL) $(srctree)/scripts/makelst $*.o \
> Index: linux-2.6/scripts/Makefile.lib
> ===================================================================
> --- linux-2.6.orig/scripts/Makefile.lib
> +++ linux-2.6/scripts/Makefile.lib
> @@ -552,9 +552,8 @@ objtool_args =                                                              \
>         $(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)             \
>         $(if $(CONFIG_SLS), --sls)
>
> -cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
> -cmd_objtool_mod = $(if $(objtool-enabled), $(objtool) $(objtool_args) $(@:.ko=.o) ; )
> -cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
> +cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $(@:.objtool=.o))
> +cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$(@:.objtool=.o): $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
>
>  endif # CONFIG_STACK_VALIDATION
>
> @@ -575,8 +574,8 @@ $(obj)/%.o: objtool-enabled :=
>
>  # instead run objtool on the module as a whole, right before
>  # the final link pass with the linker script.
> -%.ko: objtool-enabled = y
> -%.ko: part-of-module := y
> +$(obj)/%.objtool: objtool-enabled = y
> +$(obj)/%.objtool: part-of-module := y
>
>  else
>
> Index: linux-2.6/scripts/Makefile.modfinal
> ===================================================================
> --- linux-2.6.orig/scripts/Makefile.modfinal
> +++ linux-2.6/scripts/Makefile.modfinal
> @@ -32,7 +32,6 @@ ARCH_POSTLINK := $(wildcard $(srctree)/a
>
>  quiet_cmd_ld_ko_o = LD [M]  $@
>        cmd_ld_ko_o +=                                                   \
> -       $(cmd_objtool_mod)                                              \
>         $(LD) -r $(KBUILD_LDFLAGS)                                      \
>                 $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)              \
>                 -T scripts/module.lds -o $@ $(filter %.o, $^);          \





I wrote cleaner code for the Kbuild part.

This replaces
  scripts/Makefile*
  scripts/mod/modpost.c
of ("x86/alternative: Use .ibt_endbr_seal to seal indirect calls")

If there is more time, I have an even cleaner idea.



diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a4b89b757287..12812cbb54cd 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -88,8 +88,8 @@ endif

 targets-for-modules := $(patsubst %.o, %.mod, $(filter %.o, $(obj-m)))

-ifdef CONFIG_LTO_CLANG
-targets-for-modules += $(patsubst %.o, %.lto.o, $(filter %.o, $(obj-m)))
+ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
+targets-for-modules += $(patsubst %.o, %.prelink.o, $(filter %.o, $(obj-m)))
 endif

 ifdef need-modorder
@@ -170,7 +170,7 @@ ifdef CONFIG_MODVERSIONS
 #   the actual value of the checksum generated by genksyms
 # o remove .tmp_<file>.o to <file>.o

-ifdef CONFIG_LTO_CLANG
+ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
 # Generate .o.symversions files for each .o with exported symbols,
and link these
 # to the kernel and/or modules at the end.
 cmd_modversions_c =
         \
@@ -230,6 +230,7 @@ objtool := $(objtree)/tools/objtool/objtool
 objtool_args =                                                         \
        $(if $(CONFIG_UNWINDER_ORC),orc generate,check)                 \
        $(if $(part-of-module), --module)                               \
+       $(if $(CONFIG_X86_KERNEL_IBT), --lto --ibt)                     \
        $(if $(CONFIG_FRAME_POINTER),, --no-fp)                         \
        $(if $(CONFIG_GCOV_KERNEL)$(CONFIG_LTO_CLANG), --no-unreachable)\
        $(if $(CONFIG_RETPOLINE), --retpoline)                          \
@@ -242,7 +243,7 @@ cmd_gen_objtooldep = $(if $(objtool-enabled), {
echo ; echo '$@: $$(wildcard $(o

 endif # CONFIG_STACK_VALIDATION

-ifdef CONFIG_LTO_CLANG
+ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)

 # Skip objtool for LLVM bitcode
 $(obj)/%.o: objtool-enabled :=
@@ -288,24 +289,24 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
        $(call if_changed_rule,cc_o_c)
        $(call cmd,force_checksrc)

-ifdef CONFIG_LTO_CLANG
+ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
 # Module .o files may contain LLVM bitcode, compile them into native code
 # before ELF processing
-quiet_cmd_cc_lto_link_modules = LTO [M] $@
-cmd_cc_lto_link_modules =                                              \
+quiet_cmd_cc_prelink_modules = LD [M]  $@
+      cmd_cc_prelink_modules =                                         \
        $(LD) $(ld_flags) -r -o $@                                      \
-               $(shell [ -s $(@:.lto.o=.o.symversions) ] &&            \
-                       echo -T $(@:.lto.o=.o.symversions))             \
+               $(shell [ -s $(@:.prelink.o=.o.symversions) ] &&
         \
+                       echo -T $(@:.prelink.o=.o.symversions))         \
                --whole-archive $(filter-out FORCE,$^)                  \
                $(cmd_objtool)

 # objtool was skipped for LLVM bitcode, run it now that we have compiled
 # modules into native code
-$(obj)/%.lto.o: objtool-enabled = y
-$(obj)/%.lto.o: part-of-module := y
+$(obj)/%.prelink.o: objtool-enabled = y
+$(obj)/%.prelink.o: part-of-module := y

-$(obj)/%.lto.o: $(obj)/%.o FORCE
-       $(call if_changed,cc_lto_link_modules)
+$(obj)/%.prelink.o: $(obj)/%.o FORCE
+       $(call if_changed,cc_prelink_modules)
 endif

 cmd_mod = { \
@@ -469,7 +470,7 @@ $(obj)/lib.a: $(lib-y) FORCE
 # Do not replace $(filter %.o,^) with $(real-prereqs). When a single object
 # module is turned into a multi object module, $^ will contain header file
 # dependencies recorded in the .*.cmd file.
-ifdef CONFIG_LTO_CLANG
+ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
 quiet_cmd_link_multi-m = AR [M]  $@
 cmd_link_multi-m =                                             \
        $(cmd_update_lto_symversions);                          \
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 79be57fdd32a..8bfc9238237c 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -230,11 +230,11 @@ dtc_cpp_flags  = -Wp,-MMD,$(depfile).pre.tmp
-nostdinc                    \
                 $(addprefix -I,$(DTC_INCLUDE))                          \
                 -undef -D__DTS__

-ifeq ($(CONFIG_LTO_CLANG),y)
+ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
 # With CONFIG_LTO_CLANG, .o files in modules might be LLVM bitcode, so we
 # need to run LTO to compile them into native code (.lto.o) before further
 # processing.
-mod-prelink-ext := .lto
+mod-prelink-ext := .prelink
 endif

 # Useful for describing the dependency of composite objects
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 6bfa33217914..09c3ab0a9b37 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1989,9 +1989,9 @@ static char *remove_dot(char *s)
                if (m && (s[n + m] == '.' || s[n + m] == 0))
                        s[n] = 0;

-               /* strip trailing .lto */
-               if (strends(s, ".lto"))
-                       s[strlen(s) - 4] = '\0';
+               /* strip trailing .prelink */
+               if (strends(s, ".prelink"))
+                       s[strlen(s) - 8] = '\0';
        }
        return s;
 }
@@ -2015,9 +2015,9 @@ static void read_symbols(const char *modname)
                /* strip trailing .o */
                tmp = NOFAIL(strdup(modname));
                tmp[strlen(tmp) - 2] = '\0';
-               /* strip trailing .lto */
-               if (strends(tmp, ".lto"))
-                       tmp[strlen(tmp) - 4] = '\0';
+               /* strip trailing .prelink */
+               if (strends(tmp, ".prelink"))
+                       tmp[strlen(tmp) - 8] = '\0';
                mod = new_module(tmp);
                free(tmp);

        }













--
Best Regards
Masahiro Yamada
