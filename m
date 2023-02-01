Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CFA687071
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 22:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBAVVX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 16:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBAVVW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 16:21:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9BC6F210;
        Wed,  1 Feb 2023 13:21:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D65CB61976;
        Wed,  1 Feb 2023 21:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B7BC433D2;
        Wed,  1 Feb 2023 21:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675286479;
        bh=m3S4OzJdnGjTmstJHSznFwZolBITH6IF+3sH5WKXOiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GWwcM0JUNIuZ+xN2k44uFFv+A4mPA5xUE10IWC20rM0mB3pU82FcslAww4HVmPEgg
         fHMCwE4S8ajT5aXIg1riktTsmTpWIquzdROe1B0+h68eODzlz8QsDtZa+AoCf2xnjE
         11WBv30S/KlWGdqJiviyZIv2/evLzYIRPV1L+TnTPo8oXoiX7EHU+ft55lyMJAEC/j
         B5uj0NCox7FZ9/umzEikCwDpkIazThVrafNc1D7BRruNXdQ4dYgdfkQI1/bHkU61Rc
         dPFkvPe0mOwkXEaSzOYtocY+qX2jK2wzz1Okr3U0/9cxuw84MGapvdeqTMF1nISI/6
         L/SuHx50yMeqQ==
Date:   Wed, 1 Feb 2023 14:21:16 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Connor OBrien <connoro@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tools/resolve_btfids: Tidy host CFLAGS forcing
Message-ID: <Y9rXzIm3UY7lzYFt@dev-arch.thelio-3990X>
References: <20230201015015.359535-1-irogers@google.com>
 <Y9o4H61YmbOSCDOG@krava>
 <Y9pCY5IcYEqfNgBX@krava>
 <CAP-5=fVHFMJvaY_UE4QdV-PW+gy1EuyiHDXqWJmHVxS9Mr3XEQ@mail.gmail.com>
 <Y9rQnu6KPj1t8Rog@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9rQnu6KPj1t8Rog@krava>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 01, 2023 at 09:50:38PM +0100, Jiri Olsa wrote:
> On Wed, Feb 01, 2023 at 10:57:40AM -0800, Ian Rogers wrote:
> > On Wed, Feb 1, 2023 at 2:43 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Wed, Feb 01, 2023 at 11:00:02AM +0100, Jiri Olsa wrote:
> > > > On Tue, Jan 31, 2023 at 05:50:15PM -0800, Ian Rogers wrote:
> > > > > Avoid passing CROSS_COMPILE to submakes and ensure CFLAGS is forced to
> > > > > HOSTCFLAGS for submake builds. This fixes problems with cross
> > > > > compilation.
> > > > >
> > > > > Tidy to not unnecessarily modify/export CFLAGS, make the override for
> > > > > prepare and build clearer.
> > > > >
> > > > > Fixes: 13e07691a16f ("tools/resolve_btfids: Alter how HOSTCC is forced")
> > > > > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > >
> > > > hum, that seems to build just the fixdep and skip the resolve_btfids binary
> > > >
> > > > make[1]: Entering directory '/home/jolsa/kernel/linux-qemu/build'
> > > >   GEN     Makefile
> > > >   CALL    ../scripts/checksyscalls.sh
> > > >   DESCEND bpf/resolve_btfids
> > > >   HOSTCC  /home/jolsa/kernel/linux-qemu/build/tools/bpf/resolve_btfids/fixdep.o
> > > >   HOSTLD  /home/jolsa/kernel/linux-qemu/build/tools/bpf/resolve_btfids/fixdep-in.o
> > > >   LINK    /home/jolsa/kernel/linux-qemu/build/tools/bpf/resolve_btfids/fixdep
> > > >   UPD     include/generated/utsversion.h
> > > >   CC      init/version-timestamp.o
> > > >   LD      .tmp_vmlinux.btf
> > > >   BTF     .btf.vmlinux.bin.o
> > > > die__process_unit: DW_TAG_label (0xa) @ <0x4f0d4> not handled!
> > > >
> > > >   ...
> > > >
> > > > die__process_unit: DW_TAG_label (0xa) @ <0xaf91cc3> not handled!
> > > > die__process_unit: DW_TAG_label (0xa) @ <0xb032fa7> not handled!
> > > >   LD      .tmp_vmlinux.kallsyms1
> > > >   NM      .tmp_vmlinux.kallsyms1.syms
> > > >   KSYMS   .tmp_vmlinux.kallsyms1.S
> > > >   AS      .tmp_vmlinux.kallsyms1.S
> > > >   LD      .tmp_vmlinux.kallsyms2
> > > >   NM      .tmp_vmlinux.kallsyms2.syms
> > > >   KSYMS   .tmp_vmlinux.kallsyms2.S
> > > >   AS      .tmp_vmlinux.kallsyms2.S
> > > >   LD      .tmp_vmlinux.kallsyms3
> > > >   NM      .tmp_vmlinux.kallsyms3.syms
> > > >   KSYMS   .tmp_vmlinux.kallsyms3.S
> > > >   AS      .tmp_vmlinux.kallsyms3.S
> > > >   LD      vmlinux
> > > >   BTFIDS  vmlinux
> > > > ../scripts/link-vmlinux.sh: line 277: ./tools/bpf/resolve_btfids/resolve_btfids: No such file or directory
> > > > make[2]: *** [../scripts/Makefile.vmlinux:35: vmlinux] Error 127
> > > > make[2]: *** Deleting file 'vmlinux'
> > > > make[1]: *** [/home/jolsa/kernel/linux-qemu/Makefile:1264: vmlinux] Error 2
> > > > make[1]: Leaving directory '/home/jolsa/kernel/linux-qemu/build'
> > > > make: *** [Makefile:242: __sub-make] Error 2
> > > >
> > > > we actually have the hostprogs support in tools/build and we use it for
> > > > fixdep, I think we should use it also here, I'll check
> > >
> > > it doesn't look that bad.. the change below fixes the build for me,
> > > perhaps we should do that for all the host tools
> > >
> > > jirka
> > 
> > I don't mind this. The fixdep vs all thing is just cause by the
> > ordering in the Makefile, you can fix by specifying the target or add
> > this patch:
> > ```
> > --- a/tools/bpf/resolve_btfids/Makefile
> > +++ b/tools/bpf/resolve_btfids/Makefile
> > @@ -58,11 +58,11 @@ HOST_OVERRIDES_BUILD := $(HOST_OVERRIDES_PREPARE) \
> > 
> > LIBS = $(LIBELF_LIBS) -lz
> > 
> > +all: $(BINARY)
> > +
> > export srctree OUTPUT Q
> > include $(srctree)/tools/build/Makefile.include
> > 
> > -all: $(BINARY)
> > -
> > prepare: $(BPFOBJ) $(SUBCMDOBJ)
> > 
> > $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
> > ```
> > 
> > Should we do this and the hostprogs migration as a follow up? There
> > isn't that much use of hostprogs in tools, but I like that your change
> > will show HOSTCC rather than CC during compilation. If we use
> > hostprogs can we just avoid the overrides altogether?
> 
> right, I think so.. we can now remove it for the BINARY target and
> then for the rest of 'prepare' once they are converted to hostprogs..
> not sure how 'hostprogs' will work for library, will need to check
> 
> I'll try to send the format patch with the fix below tomorrow
> 
> Nathan, any chance you could test it?


Sure thing, would you happen to have a single patch file of what I
should test? I am a little confused from reading the thread (unless what
you want tested has not been sent yet).

Cheers,
Nathan

> > > ---
> > > diff --git a/tools/bpf/resolve_btfids/Build b/tools/bpf/resolve_btfids/Build
> > > index ae82da03f9bf..077de3829c72 100644
> > > --- a/tools/bpf/resolve_btfids/Build
> > > +++ b/tools/bpf/resolve_btfids/Build
> > > @@ -1,3 +1,5 @@
> > > +hostprogs := resolve_btfids
> > > +
> > >  resolve_btfids-y += main.o
> > >  resolve_btfids-y += rbtree.o
> > >  resolve_btfids-y += zalloc.o
> > > @@ -7,4 +9,4 @@ resolve_btfids-y += str_error_r.o
> > >
> > >  $(OUTPUT)%.o: ../../lib/%.c FORCE
> > >         $(call rule_mkdir)
> > > -       $(call if_changed_dep,cc_o_c)
> > > +       $(call if_changed_dep,host_cc_o_c)
> > > diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> > > index daed388aa5d7..de513fd08535 100644
> > > --- a/tools/bpf/resolve_btfids/Makefile
> > > +++ b/tools/bpf/resolve_btfids/Makefile
> > > @@ -22,6 +22,9 @@ HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)
> > >                   EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
> > >
> > >  RM      ?= rm
> > > +HOSTCC  ?= gcc
> > > +HOSTLD  ?= ld
> > > +HOSTAR  ?= ar
> > >  CROSS_COMPILE =
> > >
> > >  OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
> > > @@ -64,7 +67,7 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
> > >  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
> > >  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
> > >
> > > -CFLAGS += -g \
> > > +HOSTCFLAGS += -g \
> > >            -I$(srctree)/tools/include \
> > >            -I$(srctree)/tools/include/uapi \
> > >            -I$(LIBBPF_INCLUDE) \
> > > @@ -73,7 +76,7 @@ CFLAGS += -g \
> > >
> > >  LIBS = $(LIBELF_LIBS) -lz
> > >
> > > -export srctree OUTPUT CFLAGS Q
> > > +export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR
> > >  include $(srctree)/tools/build/Makefile.include
> > >
> > >  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
