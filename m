Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8255A683977
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 23:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjAaWkq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 17:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjAaWkp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 17:40:45 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A369EFB2;
        Tue, 31 Jan 2023 14:40:43 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id qw12so30179623ejc.2;
        Tue, 31 Jan 2023 14:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KUPztVm7TCSgk24kz0qZCmg6of4J1a8oSdbPBOcLku4=;
        b=c/BEL643UCrCF82LoV3IKB+5KyuXz5WCgAF5qbQDzmz2rbq8SsdE869+V0tZVubxFo
         kwynVei/99hhq1jWA3ffqaMRAEYrJJj1rIIf7DfLnUkDUpiBYTfVhzI9Z/Em8LpuZoQm
         VYbF0i8vaAicCJ+CpzW2Ao8HIop4wQ3gqACGS6IimGmadtIe465foqUvE+rD4HfBNQe2
         JrxI2gr9aN6FnTCUrCcjJlLQZmJQk9kTflb/21hb4xd+RERL8Nd9Gpsg3YRf+FGoycEe
         xpM0PgS3Ou5QF8H4uRdOBMUrvYaf/9o4GLXeRYDlp+SSXjEdS/faBBI2N85KMpIJyosB
         ZP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUPztVm7TCSgk24kz0qZCmg6of4J1a8oSdbPBOcLku4=;
        b=Tum7fVMkPXd7o2s/intcM0zhJ8wsm00iW2LnMLG1XHyWLL6EAAxH/mr9VdPQvB8QqN
         g5kAZAX30Neg57NZRWuR60vPoRRB9+DFi4rYPA8Rbjt+os+lkROZAM8WxweS1vIed8Av
         rhvDJzeiQcPY2JM+4j1bRAmPYlfG7cF0T/h2I2/t7AzaXOP1eAYAnEekT19CQi0ecqAl
         qtHUni3gWh68q+OESyhOy9RmRQ8G+dKL32stpvlMXFfxlRxlhbBR5FSCoK8/vWZyOp3F
         nQJjRkqgOz0vGqzqGd01k83EULXAeSlR8S/vnyYTYrV+nMpZ2s9fUvhOZeSGdVY432fY
         mopA==
X-Gm-Message-State: AO0yUKUfj8I6NyKAzGz6e1xmOfig15YvgyMY6+ydSAY4zAmaJpp1seHn
        n8AJ1nvCplH69P99xJZwFBo=
X-Google-Smtp-Source: AK7set+p5JQV/1HfuHev8lqBJ9svYuBbwUUuVTlWdesok6lYa6PakehRGFDPx8aWSKlzUNXHD+Gqhg==
X-Received: by 2002:a17:906:434b:b0:878:72f7:bd87 with SMTP id z11-20020a170906434b00b0087872f7bd87mr57007ejm.6.1675204841311;
        Tue, 31 Jan 2023 14:40:41 -0800 (PST)
Received: from krava ([83.240.61.48])
        by smtp.gmail.com with ESMTPSA id a26-20020a170906685a00b008878909859bsm4388047ejs.152.2023.01.31.14.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 14:40:40 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 31 Jan 2023 23:40:39 +0100
To:     Nathan Chancellor <nathan@kernel.org>
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
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v4 2/2] tools/resolve_btfids: Alter how HOSTCC is forced
Message-ID: <Y9mY5woe+45nTvTM@krava>
References: <20230124064324.672022-1-irogers@google.com>
 <20230124064324.672022-2-irogers@google.com>
 <Y9lN+H3ModGwwKV6@dev-arch.thelio-3990X>
 <CAP-5=fWvmEJ3DuKkhOEVg6zoiSKDGW-n=GFqRhse=2dP=C6i3Q@mail.gmail.com>
 <CAP-5=fWJzTOYj167maEP8=k=iWQJcrF-zOdbkTAUw94qrVOL5g@mail.gmail.com>
 <Y9ls+nWTwE5we5ah@dev-arch.thelio-3990X>
 <CAP-5=fWbd2gNhWXkffQQmVrLY6dzHxH68zumNwp4_a0b83D7qg@mail.gmail.com>
 <Y9mFVNEi5wAINARY@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9mFVNEi5wAINARY@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 31, 2023 at 02:17:08PM -0700, Nathan Chancellor wrote:
> On Tue, Jan 31, 2023 at 12:59:04PM -0800, Ian Rogers wrote:
> > On Tue, Jan 31, 2023 at 11:33 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > On Tue, Jan 31, 2023 at 11:25:38AM -0800, Ian Rogers wrote:
> > > > On Tue, Jan 31, 2023 at 10:08 AM Ian Rogers <irogers@google.com> wrote:
> > > > >
> > > > > On Tue, Jan 31, 2023 at 9:21 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > > > > >
> > > > > > Hi Ian,
> > > > > >
> > > > > > On Mon, Jan 23, 2023 at 10:43:24PM -0800, Ian Rogers wrote:
> > > > > > > HOSTCC is always wanted when building. Setting CC to HOSTCC happens
> > > > > > > after tools/scripts/Makefile.include is included, meaning flags are
> > > > > > > set assuming say CC is gcc, but then it can be later set to HOSTCC
> > > > > > > which may be clang. tools/scripts/Makefile.include is needed for host
> > > > > > > set up and common macros in objtool's Makefile. Rather than override
> > > > > > > CC to HOSTCC, just pass CC as HOSTCC to Makefile.build, the libsubcmd
> > > > > > > builds and the linkage step. This means the Makefiles don't see things
> > > > > > > like CC changing and tool flag determination, and similar, work
> > > > > > > properly.
> > > > > > >
> > > > > > > Also, clear the passed subdir as otherwise an outer build may break by
> > > > > > > inadvertently passing an inappropriate value.
> > > > > > >
> > > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > > > ---
> > > > > > >  tools/bpf/resolve_btfids/Makefile | 17 +++++++----------
> > > > > > >  1 file changed, 7 insertions(+), 10 deletions(-)
> > > > > > >
> > > > > > > diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> > > > > > > index 1fe0082b2ecc..daed388aa5d7 100644
> > > > > > > --- a/tools/bpf/resolve_btfids/Makefile
> > > > > > > +++ b/tools/bpf/resolve_btfids/Makefile
> > > > > > > @@ -18,14 +18,11 @@ else
> > > > > > >  endif
> > > > > > >
> > > > > > >  # always use the host compiler
> > > > > > > -AR       = $(HOSTAR)
> > > > > > > -CC       = $(HOSTCC)
> > > > > > > -LD       = $(HOSTLD)
> > > > > > > -ARCH     = $(HOSTARCH)
> > > > > > > +HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
> > > > > > > +               EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
> > > > > > > +
> > > > > > >  RM      ?= rm
> > > > > > >  CROSS_COMPILE =
> > > > > > > -CFLAGS  := $(KBUILD_HOSTCFLAGS)
> > > > > > > -LDFLAGS := $(KBUILD_HOSTLDFLAGS)
> > > > > > >
> > > > > > >  OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
> > > > > > >
> > > > > > > @@ -56,12 +53,12 @@ $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
> > > > > > >
> > > > > > >  $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
> > > > > > >       $(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
> > > > > > > -                 DESTDIR=$(SUBCMD_DESTDIR) prefix= \
> > > > > > > +                 DESTDIR=$(SUBCMD_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
> > > > > > >                   $(abspath $@) install_headers
> > > > > > >
> > > > > > >  $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
> > > > > > >       $(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
> > > > > > > -                 DESTDIR=$(LIBBPF_DESTDIR) prefix= EXTRA_CFLAGS="$(CFLAGS)" \
> > > > > > > +                 DESTDIR=$(LIBBPF_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
> > > > > > >                   $(abspath $@) install_headers
> > > > > > >
> > > > > > >  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
> > > > > > > @@ -80,11 +77,11 @@ export srctree OUTPUT CFLAGS Q
> > > > > > >  include $(srctree)/tools/build/Makefile.include
> > > > > > >
> > > > > > >  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
> > > > > > > -     $(Q)$(MAKE) $(build)=resolve_btfids
> > > > > > > +     $(Q)$(MAKE) $(build)=resolve_btfids $(HOST_OVERRIDES)
> > > > > > >
> > > > > > >  $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
> > > > > > >       $(call msg,LINK,$@)
> > > > > > > -     $(Q)$(CC) $(BINARY_IN) $(LDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
> > > > > > > +     $(Q)$(HOSTCC) $(BINARY_IN) $(KBUILD_HOSTLDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
> > > > > > >
> > > > > > >  clean_objects := $(wildcard $(OUTPUT)/*.o                \
> > > > > > >                              $(OUTPUT)/.*.o.cmd           \
> > > > > > > --
> > > > > > > 2.39.0.246.g2a6d74b583-goog
> > > > > > >
> > > > > >
> > > > > > I just bisected a linking failure when building resolve_btfids with
> > > > > > clang to this change as commit 13e07691a16f ("tools/resolve_btfids:
> > > > > > Alter how HOSTCC is forced") in the bpf-next tree.
> > > > > >
> > > > > > It appears to be related to whether or not CROSS_COMPILE is specified,
> > > > > > which we have to do for certain architectures and configurations still.
> > > > > > arm64 is not one of those but it helps demonstrate the issue.
> > > > > >
> > > > > >   # Turn off CONFIG_DEBUG_INFO_REDUCED and turn on CONFIG_DEBUG_INFO_BTF
> > > > > >   $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- HOSTLDFLAGS=-fuse-ld=lld LLVM=1 defconfig menuconfig
> > > > > >
> > > > > >   $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- HOSTLDFLAGS=-fuse-ld=lld LLVM=1 prepare
> > > > > >   ld.lld: error: $LINUX_SRC/tools/bpf/resolve_btfids//resolve_btfids-in.o is incompatible with elf64-x86-64
> > > > > >   clang-17: error: linker command failed with exit code 1 (use -v to see invocation)
> > > > > >   ...
> > > > > >
> > > > > > Before your change, with V=1, I see:
> > > > > >
> > > > > > clang -Wp,-MD,$LINUX_SRC/tools/bpf/resolve_btfids/.main.o.d -Wp,-MT,$LINUX_SRC/tools/bpf/resolve_btfids/main.o -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu11 -Wdeclaration-after-statement -g -I$LINUX_SRC/tools/include -I$LINUX_SRC/tools/include/uapi -I$LINUX_SRC/tools/bpf/resolve_btfids/libbpf/include -I$LINUX_SRC/tools/bpf/resolve_btfids/libsubcmd/include -D"BUILD_STR(s)=#s" -c -o $LINUX_SRC/tools/bpf/resolve_btfids/main.o main.c
> > > > > >
> > > > > > After, I see:
> > > > > >
> > > > > > clang -Wp,-MD,$LINUX_SRC/tools/bpf/resolve_btfids/.main.o.d -Wp,-MT,$LINUX_SRC/tools/bpf/resolve_btfids/main.o --target=aarch64-linux-gnu -g -I$LINUX_SRC/tools/include -I$LINUX_SRC/tools/include/uapi -I$LINUX_SRC/tools/bpf/resolve_btfids/libbpf/include -I$LINUX_SRC/tools/bpf/resolve_btfids/libsubcmd/include -D"BUILD_STR(s)=#s" -c -o $LINUX_SRC/tools/bpf/resolve_btfids/main.o main.c
> > > > > >
> > > > > > We seem to have taken on a '--target=aarch64-linux-gnu' (changing the
> > > > > > target of resolve_btfids-in.o) and we dropped the warning flags.
> > > > > >
> > > > > > I think this comes from the clang block in
> > > > > > tools/scripts/Makefile.include, which is included into the
> > > > > > resolve_btfids Makefile via tools/lib/bpf/Makefile.
> > > > > >
> > > > > > I am not super familiar with the tools build system, otherwise I would
> > > > > > try to provide a patch. I tried moving CROSS_COMPILE from a recursive to
> > > > > > simple variable ('=' -> ':=') and moving it to HOST_OVERRIDES but those
> > > > > > did not appear to resolve it for me.
> > > > > >
> > > > > > If there is any other information I can provide or patches I can test,
> > > > > > please let me know.
> > > > > >
> > > > > > Cheers,
> > > > > > Nathan
> > > > >
> > > > > Thanks Nathan, and thanks for all the details in the bug report. I'm
> > > > > looking into this.
> > > > >
> > > > > Ian
> > > >
> > > > Given the somewhat complicated cross compile I wasn't able to get a
> > > > reproduction. Could you see if the following addresses the problem:
> > >
> > > As long as you have an LLVM toolchain that targets AArch64 and your
> > > host, you should be able to reproduce this issue with those commands
> > > verbatim, as that command should not use any GNU binutils. I am pretty
> > > sure I tried it in a fresh container before reporting it but it is
> > > possible that I did not.
> > 
> > Thanks, do you have instructions on setting up the container?
> 
> Sure thing, this worked for me in the Linux source you would like to
> build (I marked it readonly to make sure any modifications were done in
> my host environment, remove the ':ro' if you would like to make edits to
> the source within the container). Docker should work as well but I did
> not test it.
> 
> $ podman run --rm -ti -v $PWD:/linux:ro docker.io/archlinux:base-devel
> # pacman -Syyu --noconfirm bc clang lib32-glibc lld llvm python
> ...
> 
> # To turn on CONFIG_DEBUG_INFO_BTF
> # make -C /linux -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- HOSTLDFLAGS=-fuse-ld=lld LLVM=1 O=/build defconfig menuconfig
> 
> # make -C /linux -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- HOSTLDFLAGS=-fuse-ld=lld LLVM=1 O=/build prepare
> ld.lld: error: /build/tools/bpf/resolve_btfids//resolve_btfids-in.o is incompatible with elf64-x86-64
> clang-15: error: linker command failed with exit code 1 (use -v to see invocation)
> 
> > > > ```
> > > > diff --git a/tools/bpf/resolve_btfids/Makefile
> > > > b/tools/bpf/resolve_btfids/Makefile
> > > > index daed388aa5d7..a06966841df4 100644
> > > > --- a/tools/bpf/resolv
> > 
> > Ian
> > e_btfids/Makefile
> > > > +++ b/tools/bpf/resolve_btfids/Makefile
> > > > @@ -19,10 +19,9 @@ endif
> > > >
> > > > # always use the host compiler
> > > > HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)"
> > > > ARCH="$(HOSTARCH)" \
> > > > -                 EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
> > > > +                 EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
> > > > CROSS_COMPILE=""
> > > >
> > > > RM      ?= rm
> > > > -CROSS_COMPILE =
> > > >
> > > > OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
> > > > ```
> > > >
> > >
> > > Unfortunately, it does not. I still see '--target=' end up in the
> > > CFLAGS of those files.

hi,
I can reproduce that and I think the reason is that the patch removes
CFLAGS setup

  CFLAGS  := $(KBUILD_HOSTCFLAGS)

so now the 'include ../../scripts/Makefile.include' will set CFLAGS
with the  --target=... and we fail

I can compile with the change below.. we could also set CROSS_COMPILE
before including tools/scripts/Makefile.include ... not sure which
on is better

also I need to check if we should keep LDFLAGS setup as well

jirka


---
diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index daed388aa5d7..875e3fcce7cd 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -64,6 +64,7 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
 LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
 LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
 
+CFLAGS := $(KBUILD_HOSTCFLAGS)
 CFLAGS += -g \
           -I$(srctree)/tools/include \
           -I$(srctree)/tools/include/uapi \

