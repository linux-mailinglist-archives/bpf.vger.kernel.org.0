Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FC04DA009
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 17:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350029AbiCOQaT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 12:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350010AbiCOQaS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 12:30:18 -0400
X-Greylist: delayed 105 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Mar 2022 09:29:06 PDT
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D3E56C38;
        Tue, 15 Mar 2022 09:29:06 -0700 (PDT)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 22FGSqlW026839;
        Wed, 16 Mar 2022 01:28:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 22FGSqlW026839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1647361732;
        bh=kto8rSbm3Q3xiCM3iwqUkTy1Lz+u7MD+xAW0APggEBU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B36aTK1eOn+/DzeSKGQletXIVYZrcXnog3sAaflmoIeR8H/7rpVhq+y+D6//2VaeO
         vVDy0Sa8nS1yzua+ySP4gGoK9GZNq7HgLBaN53Q90UhxYqn0A4IP+U75WLtf/R6AYf
         GO6JRuP+WZlvpvKRBE6+iX/aEVe/LCa+BhMC5Rb/H4GkfYaO64IlQKzEsMzEGSYwV4
         0zTJkF/9RrsFTgLsvzRicpoRoLgT2BnnoHErkpYziHeRdDynhDEsJ8SL1dF4ZDxhUZ
         YAwJEZJhRQttDsojavllWVGf8W9or0rsUWfb3v0BRYJsrs0sYONIfF5dJmM8533BJZ
         pl+AeSF69MbgQ==
X-Nifty-SrcIP: [209.85.216.44]
Received: by mail-pj1-f44.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so2914770pjl.4;
        Tue, 15 Mar 2022 09:28:52 -0700 (PDT)
X-Gm-Message-State: AOAM531Gy75IXSaPIJcsaU9KNUukIzfI7XD4enmH5/cQHrblVPfMRf9n
        bOExu+0NC4zBX3qQ4EPvpg2YgBJORLLM1Rag3xY=
X-Google-Smtp-Source: ABdhPJyQQCiK2kYc6VKY4osuuaLXqfBSrRdu+1+tQj6ir64AFa+GJSuGhwO7V/BFO7Ul0tkdLmMYa9LM+xz47pi9Cqw=
X-Received: by 2002:a17:90a:ab17:b0:1b9:b61a:aadb with SMTP id
 m23-20020a17090aab1700b001b9b61aaadbmr5506333pjq.77.1647361731601; Tue, 15
 Mar 2022 09:28:51 -0700 (PDT)
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
Date:   Wed, 16 Mar 2022 01:28:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNAReAKXT97NHEnC-1UXozdcPdYNHR55knNRDatJr_GqrrA@mail.gmail.com>
Message-ID: <CAK7LNAReAKXT97NHEnC-1UXozdcPdYNHR55knNRDatJr_GqrrA@mail.gmail.com>
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


Why do you need to change this line?



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


Thanks for explaining how stupidly this works.
NACK.


I guess re-using the current clang-lto rule is much cleaner.
(but please rename  %.lto.o  to  %.prelink.o)


Roughly like this:


if CONFIG_LTO_CLANG || CONFIG_X86_KERNEL_IBT

$(obj)/%.prelink:  $(obj)/%.o FORCE
        [  $(LD) if CONFIG_LTO_CLANG ]   +  $(cmd_objtool)

endif







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



-- 
Best Regards
Masahiro Yamada
