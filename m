Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EC94DA03C
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 17:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbiCOQkl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 12:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbiCOQkk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 12:40:40 -0400
X-Greylist: delayed 236 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Mar 2022 09:39:28 PDT
Received: from condef-09.nifty.com (condef-09.nifty.com [202.248.20.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCC857155
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 09:39:27 -0700 (PDT)
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-09.nifty.com with ESMTP id 22FGRNOn020190
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 01:27:23 +0900
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 22FGR9dr025638;
        Wed, 16 Mar 2022 01:27:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 22FGR9dr025638
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1647361630;
        bh=BOExbP66O/Uw83XDrn7rpBs8+RR88II8AzpWN9E7Ij8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rA9hroOKKerr19Bw4b7PXizh9fqj0afiUYGVwhUHwpvJ2bkD1AYoPUizxA26Hehgc
         4dTPwZUXzvwb30kBQtUoKeA7DxBP1/7E95zjiSoSfF8Heaoodu5RJuxEh8OH5gIklh
         QRgjv5lW9jT1sgrMdYdVhK5UW9KnC2Gl5EwUTRuD5fVtttbD308l1nye5TUqa27Ft9
         6KJncFlXCu5RFVCiYPPj/T98I+0w9ENcCTdhuWpXxthBuTLlk7Dd7WX9nDIt/UyppB
         6uWPQTY0d/FAKufm7eHTX4rxsEUSXmAlt5ePMfKIY75EL6sSXIeSpzfoYt3CwubmnL
         OWoCzGmIKkBcg==
X-Nifty-SrcIP: [209.85.214.173]
Received: by mail-pl1-f173.google.com with SMTP id n15so16682437plh.2;
        Tue, 15 Mar 2022 09:27:09 -0700 (PDT)
X-Gm-Message-State: AOAM533EcG/ATJT6Mzg0mkGYmxbZEFYnxGtltclLqR5an4GjbFAaxZzm
        24N7XFk9LNrofoFnm0VtnnSPB0kVtfRbFRj6M4A=
X-Google-Smtp-Source: ABdhPJxBZNGNRIITAORFdnjsxJn8chKL2ZYd6FUuJo3h2ECaHhs7DII5mfIECrcrNqbnXKgYHaifSPRjWImr0MzXGYY=
X-Received: by 2002:a17:902:eb84:b0:151:f80e:e98b with SMTP id
 q4-20020a170902eb8400b00151f80ee98bmr29180354plg.99.1647361628703; Tue, 15
 Mar 2022 09:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <Yif8nO2xg6QnVQfD@hirez.programming.kicks-ass.net>
 <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
 <YinGZObp37b27LjK@hirez.programming.kicks-ass.net> <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net> <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
 <CAADnVQJfffD9tH_cWThktCCwXeoRV1XLZq69rKK5vKy_y6BN8A@mail.gmail.com>
 <20220312154407.GF28057@worktop.programming.kicks-ass.net>
 <CAADnVQL7xrafAviUJg47LfvFSJpgZLwyP18Bm3S_KQwRyOpheQ@mail.gmail.com>
 <20220313085214.GK28057@worktop.programming.kicks-ass.net> <Yi9YOdn5Nbq9BBwd@hirez.programming.kicks-ass.net>
In-Reply-To: <Yi9YOdn5Nbq9BBwd@hirez.programming.kicks-ass.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 16 Mar 2022 01:26:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNASOjsSRixifxxUBKiFdR_Q_pSoBu98zYU_u_z1rtUD=zA@mail.gmail.com>
Message-ID: <CAK7LNASOjsSRixifxxUBKiFdR_Q_pSoBu98zYU_u_z1rtUD=zA@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 14, 2022 at 11:59 PM Peter Zijlstra <peterz@infradead.org> wrot=
e:
>
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
> > makefile generate .o.objtool empty file to serve as dependency marker t=
o
> > avoid doing second objtool run, but like said, no luck yet.
>
> Masahiro-san, I'm trying the below, but afaict it's not working because
> the rule for the .o file itself:
>
> $(multi-obj-m): FORCE
>         $(call if_changed,link_multi-m)
>
> will in fact update the timestamp of the .o file, even if if_changed
> nops out the cmd. Concequently all rules that try to use if_changed with
> this .o file as a dependency will find it newer and run anyway.
>
>
> remake -x output of a fs/f2fs/ module (re)build:
>
>      Prerequisite 'FORCE' of target 'fs/f2fs/f2fs.o' does not exist.
>     Must remake target 'fs/f2fs/f2fs.o'.
> ../scripts/Makefile.build:454: target 'fs/f2fs/f2fs.o' does not exist
> ##>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> :
> ##<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
>     Successfully remade target file 'fs/f2fs/f2fs.o'.
>    Prerequisite 'fs/f2fs/f2fs.o' is newer than target 'fs/f2fs/f2fs.mod'.
>    Prerequisite 'FORCE' of target 'fs/f2fs/f2fs.mod' does not exist.
>   Must remake target 'fs/f2fs/f2fs.mod'.
> ../scripts/Makefile.build:281: update target 'fs/f2fs/f2fs.mod' due to: f=
s/f2fs/f2fs.o
> ##>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> set -e;   { echo  fs/f2fs/dir.o fs/f2fs/file.o fs/f2fs/inode.o fs/f2fs/na=
mei.o fs/f2fs/hash.o fs/f2fs/super.o fs/f2fs/inline.o fs/f2fs/checkpoint.o =
fs/f2fs/gc.o fs/f2fs/data.o fs/f2fs/node.o fs/f2fs/segment.o fs/f2fs/recove=
ry.o fs/f2fs/shrinker.o fs/f2fs/extent_cache.o fs/f2fs/sysfs.o fs/f2fs/debu=
g.o fs/f2fs/xattr.o fs/f2fs/acl.o fs/f2fs/iostat.o;  echo; } > fs/f2fs/f2fs=
.mod; printf '%s\n' 'cmd_fs/f2fs/f2fs.mod :=3D { echo  fs/f2fs/dir.o fs/f2f=
s/file.o fs/f2fs/inode.o fs/f2fs/namei.o fs/f2fs/hash.o fs/f2fs/super.o fs/=
f2fs/inline.o fs/f2fs/checkpoint.o fs/f2fs/gc.o fs/f2fs/data.o fs/f2fs/node=
.o fs/f2fs/segment.o fs/f2fs/recovery.o fs/f2fs/shrinker.o fs/f2fs/extent_c=
ache.o fs/f2fs/sysfs.o fs/f2fs/debug.o fs/f2fs/xattr.o fs/f2fs/acl.o fs/f2f=
s/iostat.o;  echo; } > fs/f2fs/f2fs.mod' > fs/f2fs/.f2fs.mod.cmd
> ##<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
>   Successfully remade target file 'fs/f2fs/f2fs.mod'.
>    Prerequisite 'fs/f2fs/f2fs.o' is newer than target 'fs/f2fs/f2fs.objto=
ol'.
>    Prerequisite 'FORCE' of target 'fs/f2fs/f2fs.objtool' does not exist.
>   Must remake target 'fs/f2fs/f2fs.objtool'.
> ../scripts/Makefile.build:287: update target 'fs/f2fs/f2fs.objtool' due t=
o: fs/f2fs/f2fs.o
> ##>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> set -e;   { echo fs/f2fs/f2fs.o  ; ./tools/objtool/objtool orc generate  =
--module  --lto --ibt  --no-fp    --uaccess   fs/f2fs/f2fs.o ; } > fs/f2fs/=
f2fs.objtool; printf '%s\n' 'cmd_fs/f2fs/f2fs.objtool :=3D { echo fs/f2fs/f=
2fs.o  ; ./tools/objtool/objtool orc generate  --module  --lto --ibt  --no-=
fp    --uaccess   fs/f2fs/f2fs.o ; } > fs/f2fs/f2fs.objtool' > fs/f2fs/.f2f=
s.objtool.cmd
> ##<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> fs/f2fs/f2fs.o: warning: objtool: file already has .static_call_sites sec=
tion, skipping
> fs/f2fs/f2fs.o: warning: objtool: file already has .ibt_endbr_seal, skipp=
ing
> fs/f2fs/f2fs.o: warning: objtool: file already has .orc_unwind section, s=
kipping
> ../scripts/Makefile.build:286: *** [fs/f2fs/f2fs.objtool] error 255
>
>
> Where we can see that we don't re-generate f2fs.o (empty command), but
> then we do re-generate f2fs.mod because f2fs.o is newer and the same
> happens for the new f2fs.objtool.
>
> Help?


Help?

I had never noticed this thread before because
you did not CC me or kbuild ML.


Looking at the build system changes:
https://lore.kernel.org/all/20220308154319.528181453@infradead.org/
https://lore.kernel.org/all/20220308154319.822545231@infradead.org/

Both patches are wrong.
So is the fix-up you appended lator in this thread.

Apparently, you were screwing up Kbuild in a brown paper bag.
So scared.







>
> ---
> Index: linux-2.6/scripts/Makefile.build
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/scripts/Makefile.build
> +++ linux-2.6/scripts/Makefile.build
> @@ -92,6 +92,10 @@ ifdef CONFIG_LTO_CLANG
>  targets-for-modules +=3D $(patsubst %.o, %.lto.o, $(filter %.o, $(obj-m)=
))
>  endif
>
> +ifdef CONFIG_X86_KERNEL_IBT
> +targets-for-modules +=3D $(patsubst %.o, %.objtool, $(filter %.o, $(obj-=
m)))
> +endif
> +
>  ifdef need-modorder
>  targets-for-modules +=3D $(obj)/modules.order
>  endif
> @@ -276,6 +280,12 @@ cmd_mod =3D { \
>  $(obj)/%.mod: $(obj)/%$(mod-prelink-ext).o FORCE
>         $(call if_changed,mod)
>
> +cmd_objtool_mod =3D                                                     =
 \
> +       { echo $< $(cmd_objtool) ; } > $@
> +
> +$(obj)/%.objtool: $(obj)/%$(mod-prelink-ext).o FORCE
> +       $(call if_changed,objtool_mod)
> +
>  quiet_cmd_cc_lst_c =3D MKLST   $@
>        cmd_cc_lst_c =3D $(CC) $(c_flags) -g -c -o $*.o $< && \
>                      $(CONFIG_SHELL) $(srctree)/scripts/makelst $*.o \
> Index: linux-2.6/scripts/Makefile.lib
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/scripts/Makefile.lib
> +++ linux-2.6/scripts/Makefile.lib
> @@ -552,9 +552,8 @@ objtool_args =3D                                     =
                         \
>         $(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)             \
>         $(if $(CONFIG_SLS), --sls)
>
> -cmd_objtool =3D $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@=
)
> -cmd_objtool_mod =3D $(if $(objtool-enabled), $(objtool) $(objtool_args) =
$(@:.ko=3D.o) ; )
> -cmd_gen_objtooldep =3D $(if $(objtool-enabled), { echo ; echo '$@: $$(wi=
ldcard $(objtool))' ; } >> $(dot-target).cmd)
> +cmd_objtool =3D $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $(=
@:.objtool=3D.o))
> +cmd_gen_objtooldep =3D $(if $(objtool-enabled), { echo ; echo '$(@:.objt=
ool=3D.o): $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
>
>  endif # CONFIG_STACK_VALIDATION
>
> @@ -575,8 +574,8 @@ $(obj)/%.o: objtool-enabled :=3D
>
>  # instead run objtool on the module as a whole, right before
>  # the final link pass with the linker script.
> -%.ko: objtool-enabled =3D y
> -%.ko: part-of-module :=3D y
> +$(obj)/%.objtool: objtool-enabled =3D y
> +$(obj)/%.objtool: part-of-module :=3D y
>
>  else
>
> Index: linux-2.6/scripts/Makefile.modfinal
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/scripts/Makefile.modfinal
> +++ linux-2.6/scripts/Makefile.modfinal
> @@ -32,7 +32,6 @@ ARCH_POSTLINK :=3D $(wildcard $(srctree)/a
>
>  quiet_cmd_ld_ko_o =3D LD [M]  $@
>        cmd_ld_ko_o +=3D                                                  =
 \
> -       $(cmd_objtool_mod)                                              \
>         $(LD) -r $(KBUILD_LDFLAGS)                                      \
>                 $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)              \
>                 -T scripts/module.lds -o $@ $(filter %.o, $^);          \



--=20
Best Regards
Masahiro Yamada
